#ifndef CLIENTCORE_H
#define CLIENTCORE_H

#include "ClientCore_global.h"
#include <QNetworkAccessManager>
#include <QByteArray>

class CLIENTCORE_EXPORT ClientCore
{
public:

  enum operations
  {
    product_list = 0,
    authorization,
    registration,
    order_list,
    office_list,
    order_send
  };
  enum clients
  {
    customer = 0,
    deliver,
    manager,
  };

  ClientCore();

  Q_INVOKABLE void Authorization(const QString& theLogin,
                                 const QString& thePassword);

  Q_INVOKABLE bool SendRecieve(QNetworkRequest& theRequest,
                               const QByteArray& thePostData,
                               const operations theOp,
                               const clients theClient);

  bool GetResult(QByteArray& theArray,
                 QNetworkReply** theReply);

private:

  void initRequest(QNetworkRequest& theRequest,
                   const operations theOp,
                   const clients theClient);

  QString GetTypeSend(const operations theOp);

  QString GetTypeClient(const clients theClient);

  QNetworkReply* Send(QNetworkRequest& theRequest,
                      const QByteArray& thePostData,
                      const operations theOp,
                      const clients theClient);

private:
  bool myIsGetted {false};
  QByteArray m_cache;
  QString login;
  QString password;
  const QString url = "http://127.0.0.1:8800";
  QNetworkReply* m_currentReply {nullptr};    // Current request being processed
  QNetworkAccessManager m_manager;            // Network manager for downloading files
};

#endif // CLIENTCORE_H
