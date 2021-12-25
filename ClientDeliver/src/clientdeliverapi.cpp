#include "clientdeliverapi.h"
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

ClientDeliverAPI::ClientDeliverAPI(QObject *parent) : QObject(parent)
{
  clearOrder();
}

bool ClientDeliverAPI::authorization(const QString& theLogin,
                                     const QString& thePassword)
{
  QByteArray aLogin(theLogin.toStdString().c_str());
  QByteArray aPassword(thePassword.toStdString().c_str());
  QNetworkRequest aRequest;
  aRequest.setRawHeader("Login", aLogin);
  aRequest.setRawHeader("Password", aPassword);
  myCore.SendRecieve(aRequest,QByteArray(), ClientCore::operations::authorization, ClientCore::clients::deliver);
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

bool ClientDeliverAPI::requestOrders()
{
  clearOrder();
  QNetworkRequest aRequest;
  myCore.SendRecieve(aRequest,QByteArray(), ClientCore::operations::order_list, ClientCore::clients::deliver);
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

bool ClientDeliverAPI::requestOrders(const QString& thePath)
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

bool ClientDeliverAPI::sendStatus(const qint32 theOrderID,
                                  const qint32 theStatus)
{
  QNetworkRequest aRequest;
  QString aSts(theStatus);
  aRequest.setRawHeader("status", aSts.toStdString().c_str());
  QString anID;
  anID.setNum(theOrderID);
  aRequest.setRawHeader("ID", anID.toStdString().c_str());
  QByteArray anOrder;
  myCore.SendRecieve(aRequest, anOrder, ClientCore::operations::status_send, ClientCore::clients::deliver);
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

void ClientDeliverAPI::clearOrder()
{
  myOrderGet = false;
  myOrderCount = 0;;
  myOfficeNames.clear();
  myOfficeAdress.clear();
  myOfficeID.clear();
  myOrderID.clear();
  myOrderAdress.clear();
}

void ClientDeliverAPI::parseOrder(const QByteArray& theArray)
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
              this->myOfficeID.push_back(obj["id_office"].toInt());
              this->myOfficeAdress.push_back(obj["office_adress"].toString());
              this->myOrderAdress.push_back(obj["order_adress"].toString());
              this->myOrderID.push_back(obj["id_order"].toInt());
              this->myOrderCount += 1;
          }
      }
  }
}
