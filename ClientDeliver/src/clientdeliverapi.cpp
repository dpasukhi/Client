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
  return true;
}

bool ClientDeliverAPI::requestOrders()
{
  return true;
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
  parseOrder(myContent);
  return true;
}

bool ClientDeliverAPI::sendStatus(const qint32 theOrderID,
                                  const qint32& theStatus)
{
  return true;
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
