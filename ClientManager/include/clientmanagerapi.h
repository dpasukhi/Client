#ifndef CLIENTMANAGERAPI_H
#define CLIENTMANAGERAPI_H

#include <clientcore.h>
#include <QObject>

class ClientManagerAPI : public QObject
{
  Q_OBJECT
public:
  explicit ClientManagerAPI(QObject *parent = nullptr);

  Q_INVOKABLE bool authorization(const QString& theLogin,
                                 const QString& thePassword);

  Q_INVOKABLE bool requestOrders();

  Q_INVOKABLE bool requestOrders(const QString& thePath);

  Q_INVOKABLE bool deleteOrder(const qint32 theOrderID);

  Q_INVOKABLE qint32 getOrderCount() const { return myOrderCount; }

  Q_INVOKABLE QString getOrderOfficeName(qint32 theInd) const { return myOfficeNames[theInd]; }

  Q_INVOKABLE QString getOrderOfficeAdress(qint32 theInd) const { return myOfficeAdress[theInd]; }

  Q_INVOKABLE qint32 getOrderOfficeID(qint32 theInd) const { return myOfficeID[theInd]; }

  Q_INVOKABLE QString getOrderAdress(qint32 theInd) const { return myOrderAdress[theInd]; }

  Q_INVOKABLE qint32 getOrderID(qint32 theInd) const { return myOrderID[theInd]; }

  Q_INVOKABLE QString getOrderData(qint32 theInd) const { return myOrderData[theInd]; }

  Q_INVOKABLE QString getNameDeliver(qint32 theInd) const { return myNameDeliver[theInd]; }

  Q_INVOKABLE QString getNameClient(qint32 theInd) const { return myNameClient[theInd]; }

  Q_INVOKABLE void clearOrder();

  Q_INVOKABLE void parseOrder(const QByteArray& theArray);

private:

  bool myOrderGet;
  qint32 myOrderCount;
  QVector <QString> myOfficeNames;
  QVector <QString> myOfficeAdress;
  QVector <qint32> myOfficeID;
  QVector <qint32> myOrderID;
  QVector <QString> myOrderAdress;
  QVector <QString> myOrderData;
  QVector <QString> myNameDeliver;
  QVector <QString> myNameClient;

  ClientCore myCore;
};

#endif // CLIENTMANAGERAPI_H
