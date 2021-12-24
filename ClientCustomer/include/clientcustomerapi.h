#ifndef CLIENTCUSTOMERAPI_H
#define CLIENTCUSTOMERAPI_H

#include <clientcore.h>
#include <QObject>

class ClientCustomerAPI : public QObject
{
      Q_OBJECT
public:
  explicit ClientCustomerAPI(QObject *parent = nullptr);

  Q_INVOKABLE bool authorization(const QString& theLogin,
                                 const QString& thePassword);

 Q_INVOKABLE  bool registration(const QString& theName,
                                const QString& theMiddleName,
                                const QString& theLastName,
                                const QString& thePhone,
                                const QString& theEmail,
                                const QString& theLogin,
                                const QString& thePassword);

  Q_INVOKABLE bool requestProducts();

  Q_INVOKABLE bool requestProducts(const QString& thePath);

  Q_INVOKABLE bool requestOffices();

  Q_INVOKABLE bool requestOffices(const QString& thePath);

  Q_INVOKABLE qint32 getProductCount() const { return myProductCount; };

  Q_INVOKABLE QString getProductName(qint32 theInd) const { return myProductNames[theInd]; }

  Q_INVOKABLE QString getProductDescription(qint32 theInd) const { return myProductDescriptions[theInd]; }

  Q_INVOKABLE QString getProductPrice(qint32 theInd) const { return myProductPrices[theInd]; }

  Q_INVOKABLE qint32 getProductID(qint32 theInd) const { return myProductID[theInd]; }

  Q_INVOKABLE qint32 getOfficeCount() const { return myOfficeCount; }

  Q_INVOKABLE QString getOfficeName(qint32 theInd) const { return myOfficeNames[theInd]; }

  Q_INVOKABLE QString getOfficeAdress(qint32 theInd) const { return myOfficeAdress[theInd]; }

  Q_INVOKABLE void clear();

  Q_INVOKABLE void clearOffice();

  Q_INVOKABLE void clearProduct();

  Q_INVOKABLE void clearOrder();

  Q_INVOKABLE void parseProduct(const QByteArray& theArray);

  Q_INVOKABLE void parseOffices(const QByteArray& theArray);

  Q_INVOKABLE qint32 getOfficetID(qint32 theInd) const { return myOfficeID[theInd]; }

  Q_INVOKABLE QStringList getDataOffice() const;

  // Sending an own order

  Q_INVOKABLE void setOrderID(const qint32 theID)  { myOrderID.push_back(theID); myOrderCount++;}

  Q_INVOKABLE void setOrderSumPrice(const qint32 theSumPrice)  { mySumPrice = theSumPrice;}

  Q_INVOKABLE void setOrderOfficeID(const qint32 theOfficeID)  { myOrderOfficeID = theOfficeID;}

  Q_INVOKABLE void setOrderAdress(const QString theAdress)  { myOrderAdress = theAdress;}

  Q_INVOKABLE bool sendOrder();

  Q_INVOKABLE QByteArray createOrder() const;

private:

  ClientCore myCore;

  bool myProductsGet;
  qint32 myProductCount;
  QVector <QString> myProductNames;
  QVector <QString> myProductDescriptions;
  QVector <QString> myProductPrices;
  QVector <qint32> myProductID;

  bool myOfficeGet;
  qint32 myOfficeCount;
  QVector <QString> myOfficeNames;
  QVector <QString> myOfficeAdress;
  QVector <qint32> myOfficeID;

  bool myOrderSet;
  qint32 myOrderCount;
  qint32 myOrderOfficeID;
  qint32 mySumPrice;
  QString myOrderAdress;
  QVector <qint32> myOrderID;
};

#endif // CLIENTCUSTOMERAPI_H
