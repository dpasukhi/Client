#include "clientmanagerapi.h"
#include <QNetworkReply>
#include <QVector>
#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonValue>
#include <QJsonParseError>
#include <QFile>
#include <QDir>

ClientManagerAPI::ClientManagerAPI(QObject *parent) : QObject(parent)
{
  clearOrder();
}

bool ClientManagerAPI::authorization(const QString& theLogin,
                                     const QString& thePassword)
{
  QByteArray aLogin(theLogin.toStdString().c_str());
  QByteArray aPassword(thePassword.toStdString().c_str());
  QNetworkRequest aRequest;
  aRequest.setRawHeader("Login", aLogin);
  aRequest.setRawHeader("Password", aPassword);
  myCore.SendRecieve(aRequest,QByteArray(), ClientCore::operations::authorization, ClientCore::clients::manager);
  QByteArray aRes;
  QNetworkReply* aRep;
  if(!myCore.GetResult(aRes, &aRep))
    return false;
  if(aRep->rawHeader("Reply") == "accepted")
  {
    myCore.Authorization(theLogin, thePassword);
    return true;
  }
  return false;
}

bool ClientManagerAPI::requestOrders()
{
  clearOrder();
  QNetworkRequest aRequest;
  myCore.SendRecieve(aRequest,QByteArray(), ClientCore::operations::order_list, ClientCore::clients::manager);
  QByteArray aRes;
  QNetworkReply* aRep;
  if(!myCore.GetResult(aRes, &aRep))
    return false;
  if(aRep->rawHeader("Reply") == "accepted")
  {
    myOrderGet = true;
    parseOrder(aRes);
    return true;
  }
  return false;
}

bool ClientManagerAPI::requestOrders(const QString& thePath)
{
  QFile aFile;
  QString aPath =  QDir::currentPath() +"/" + thePath;
  aFile.setFileName(aPath);
  if (!aFile.open(QIODevice::ReadOnly | QIODevice::Text))
    return false;
  QByteArray myContent = aFile.readAll();
  aFile.close();
  myOrderGet = true;
  parseOrder(myContent);
  return true;
}

bool ClientManagerAPI::deleteOrder(const qint32 theOrderID)
{
  QNetworkRequest aRequest;
  QString anID;
  anID.setNum(theOrderID);
  aRequest.setRawHeader("ID", anID.toStdString().c_str());
  QByteArray anOrder;
  myCore.SendRecieve(aRequest, anOrder, ClientCore::operations::order_remove, ClientCore::clients::manager);
  QByteArray aRes;
  QNetworkReply* aRep;
  if(!myCore.GetResult(aRes, &aRep))
    return false;
  if(aRep->rawHeader("Reply") == "accepted")
  {
    return true;
  }
  return false;
}

void ClientManagerAPI::clearOrder()
{
  myOrderGet = false;
  myOrderCount = 0;;
  myOfficeNames.clear();
  myOfficeAdress.clear();
  myOfficeID.clear();
  myOrderID.clear();
  myOrderAdress.clear();
  myOrderData.clear();
  myNameDeliver.clear();
  myNameClient.clear();
}

void ClientManagerAPI::parseOrder(const QByteArray& theArray)
{
  QJsonDocument doc = QJsonDocument::fromJson(theArray);

  if (doc.isObject())
  {
      QJsonObject json = doc.object();
      QJsonArray jsonArray = json["orders"].toArray();
      foreach (const QJsonValue & value, jsonArray)
      {
          if (value.isObject())
          {
              QJsonObject obj = value.toObject();
              this->myOfficeNames.push_back(obj["name"].toString());
              this->myOrderID.push_back(obj["id_order"].toInt());
              this->myOfficeAdress.push_back(obj["office_adress"].toString());
              this->myOrderAdress.push_back(obj["order_adress"].toString());
              this->myOrderData.push_back(obj["data_order"].toString());
              this->myNameDeliver.push_back(obj["name_deliver"].toString());
              this->myNameClient.push_back(obj["name_client"].toString());
              this->myOrderCount += 1;
          }
      }
  }
}
