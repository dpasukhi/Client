#include "clientcustomerapi.h"
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

ClientCustomerAPI::ClientCustomerAPI(QObject *parent) : QObject(parent)
{
  clear();
}

bool ClientCustomerAPI::authorization(const QString& theLogin,
                                      const QString& thePassword)
{
  QByteArray aLogin(theLogin.toStdString().c_str());
  QByteArray aPassword(thePassword.toStdString().c_str());
  QNetworkRequest aRequest;
  aRequest.setRawHeader("Login", aLogin);
  aRequest.setRawHeader("Password", aPassword);
  myCore.SendRecieve(aRequest,QByteArray(), ClientCore::operations::authorization, ClientCore::clients::customer);
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

bool ClientCustomerAPI::registration(const QString& theName,
                                     const QString& theMiddleName,
                                     const QString& theLastName,
                                     const QString& thePhone,
                                     const QString& theEmail,
                                     const QString& theLogin,
                                     const QString& thePassword)
{
  QByteArray aLogin(theLogin.toStdString().c_str());
  QByteArray aPassword(thePassword.toStdString().c_str());
  QByteArray aName(theName.toStdString().c_str());
  QByteArray aMiddleName(theMiddleName.toStdString().c_str());
  QByteArray aLastName(theLastName.toStdString().c_str());
  QByteArray aPhone(thePhone.toStdString().c_str());
  QByteArray aEmail(theEmail.toStdString().c_str());
  QNetworkRequest aRequest;
  aRequest.setRawHeader("Login", aLogin);
  aRequest.setRawHeader("Password", aPassword);
  aRequest.setRawHeader("Name", aName);
  aRequest.setRawHeader("MiddleName", aMiddleName);
  aRequest.setRawHeader("LastName", aLastName);
  aRequest.setRawHeader("Phone", aPhone);
  aRequest.setRawHeader("Email", aEmail);
  myCore.SendRecieve(aRequest,QByteArray(), ClientCore::operations::registration, ClientCore::clients::customer);
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

bool ClientCustomerAPI::requestProducts()
{
  clearProduct();
  QNetworkRequest aRequest;
  myCore.SendRecieve(aRequest,QByteArray(), ClientCore::operations::product_list, ClientCore::clients::customer);
  QByteArray aRes;
  QNetworkReply* aRep;
  if(!myCore.GetResult(aRes, &aRep))
    return false;
  if(aRep->rawHeader("Reply") == "accepted")
  {
    myProductsGet = true;
    parseProduct(aRes);
    return true;
  }
  return false;
}

bool ClientCustomerAPI::requestProducts(const QString& thePath)
{
  QFile aFile;
  QString aPath =  QDir::currentPath() +"/" + thePath;
  aFile.setFileName(aPath);
  if (!aFile.open(QIODevice::ReadOnly | QIODevice::Text))
    return false;
  QByteArray myContent = aFile.readAll();
  aFile.close();
  parseProduct(myContent);
  return true;
}

bool ClientCustomerAPI::requestOffices()
{
  clearOffice();
  QNetworkRequest aRequest;
  myCore.SendRecieve(aRequest,QByteArray(), ClientCore::operations::office_list, ClientCore::clients::customer);
  QByteArray aRes;
  QNetworkReply* aRep;
  if(!myCore.GetResult(aRes, &aRep))
    return false;
  if(aRep->rawHeader("Reply") == "accepted")
  {
    myProductsGet = true;
    parseOffices(aRes);
    return true;
  }
  return false;
}

bool ClientCustomerAPI::requestOffices(const QString& thePath)
{
  QFile aFile;
  QString aPath =  QDir::currentPath() +"/" + thePath;
  aFile.setFileName(aPath);
  if (!aFile.open(QIODevice::ReadOnly | QIODevice::Text))
    return false;
  QByteArray myContent = aFile.readAll();
  aFile.close();
  parseOffices(myContent);
  return true;
}

void ClientCustomerAPI::clear()
{
  clearOffice();
  clearProduct();
  clearOrder();
}

void ClientCustomerAPI::clearOffice()
{
  myOfficeGet = false;
  myOfficeCount = 0;
  myOfficeNames.clear();
  myOfficeAdress.clear();
}

void ClientCustomerAPI::clearProduct()
{
  myProductsGet = false;
  myProductCount = 0;
  myProductNames.clear();
  myProductDescriptions.clear();
  myProductPrices.clear();
}

void ClientCustomerAPI::clearOrder()
{
  myOrderSet = false;
  myOrderCount = 0;
  myOrderOfficeID = -1;
  mySumPrice = 0;
  myOrderAdress = "";
  myOrderID.clear();
}

void ClientCustomerAPI::parseProduct(const QByteArray& theArray)
{
  QJsonDocument doc = QJsonDocument::fromJson(theArray);

  if (doc.isObject())
  {
    QJsonObject json = doc.object();
    QJsonArray jsonArray = json["pizza"].toArray();
    foreach (const QJsonValue & value, jsonArray)
    {
      if (value.isObject())
      {
        QJsonObject obj = value.toObject();
        this->myProductNames.push_back(obj["name"].toString());
        this->myProductDescriptions.push_back(obj["description"].toString());
        this->myProductPrices.push_back(obj["price"].toString());
        this->myProductID.push_back(obj["id"].toInt());
        this->myProductCount += 1;
      }
    }
  }
}

void ClientCustomerAPI::parseOffices(const QByteArray& theArray)
{
  QJsonDocument doc = QJsonDocument::fromJson(theArray);

  if (doc.isObject())
  {
    QJsonObject json = doc.object();
    QJsonArray jsonArray = json["office"].toArray();
    foreach (const QJsonValue & value, jsonArray)
    {
      if (value.isObject())
      {
        QJsonObject obj = value.toObject();
        this->myOfficeNames.push_back(obj["name"].toString());
        this->myOfficeAdress.push_back(obj["adress"].toString());
        this->myOfficeID.push_back(obj["id"].toInt());
        this->myOfficeCount += 1;
      }
    }
  }
}

QStringList ClientCustomerAPI::getDataOffice() const
{
  QStringList anOffices;
  foreach (const QString & value, myOfficeNames)
  {
    anOffices.append(value);
  }
  return anOffices;
}

bool ClientCustomerAPI::sendOrder()
{
  QNetworkRequest aRequest;
  QByteArray anOrder = createOrder();
  myCore.SendRecieve(aRequest, anOrder, ClientCore::operations::order_send, ClientCore::clients::customer);
  QByteArray aRes;
  QNetworkReply* aRep;
  if(!myCore.GetResult(aRes, &aRep))
    return false;
  if(aRep->rawHeader("Reply") == "accepted")
  {
    myOrderSet = true;
    return true;
  }
  return false;
}
#include <fstream>

QByteArray ClientCustomerAPI::createOrder() const
{
  QJsonArray jsonArray;
  for(int i = 0; i < myOrderCount; i++)
  {
    QJsonObject anObj;
    anObj.insert("order_id", myOrderID[i]);
    anObj.insert("order_sum_price", mySumPrice);
    anObj.insert("order_office_id", myOrderOfficeID);
    anObj.insert("order_adress", myOrderAdress);
    QJsonValue aValue(anObj);
    jsonArray.append(aValue);
  }
  QJsonObject json;
  json.insert("order", jsonArray);
  QJsonDocument aDoc(json);
  return aDoc.toJson();
}
