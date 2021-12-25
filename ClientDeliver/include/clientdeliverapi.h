#ifndef CLIENTDELIVERAPI_H
#define CLIENTDELIVERAPI_H

#include <clientcore.h>
#include <QObject>

class ClientDeliverAPI : public QObject
{
  Q_OBJECT
public:
  explicit ClientDeliverAPI(QObject *parent = nullptr);

  enum status
  {
    wait = 0,
    deliver = 1,
    done = 2
  };

  Q_INVOKABLE bool authorization(const QString& theLogin,
                                 const QString& thePassword);

  Q_INVOKABLE bool requestOrders();

  Q_INVOKABLE bool requestOrders(const QString& thePath);

  Q_INVOKABLE bool sendStatus(const qint32 theOrderID, const qint32 theStatus);

  Q_INVOKABLE qint32 getOrderCount() const { return myOrderCount; }

  Q_INVOKABLE QString getOrderOfficeName(qint32 theInd) const { return myOfficeNames[theInd]; }

  Q_INVOKABLE QString getOrderOfficeAdress(qint32 theInd) const { return myOfficeAdress[theInd]; }

  Q_INVOKABLE qint32 getOrderOfficeID(qint32 theInd) const { return myOfficeID[theInd]; }

  Q_INVOKABLE QString getOrderAdress(qint32 theInd) const { return myOrderAdress[theInd]; }

  Q_INVOKABLE qint32 getOrderID(qint32 theInd) const { return myOrderID[theInd]; }

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

  ClientCore myCore;
};

#endif // CLIENTDELIVERAPI_H
