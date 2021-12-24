#include "clientcore.h"
#include <QNetworkReply>
#include <QEventLoop>

ClientCore::ClientCore()
{}

void ClientCore::Authorization(const QString& theLogin, const QString& thePassword)
{
  login = theLogin;
  password = thePassword;
}

QNetworkReply* ClientCore::Send(QNetworkRequest& theRequest,
                                const QByteArray& thePostData,
                                const operations theOp,
                                const clients theClient)
{
  initRequest(theRequest, theOp, theClient);
  return m_manager.post(theRequest,thePostData);
}

bool ClientCore::SendRecieve(QNetworkRequest& theRequest,
                             const QByteArray& thePostData,
                             const operations theOp,
                             const clients theClient)
{
  myIsGetted = true;
  m_cache.clear();
  delete m_currentReply;
  m_currentReply = Send(theRequest, thePostData, theOp, theClient);
  QEventLoop loop;
  QEventLoop::connect(m_currentReply, SIGNAL(finished()), &loop, SLOT(quit()));
  // FIXME: no error handler
  loop.exec();
  m_cache.append(m_currentReply->readAll());
  return true;
}

bool ClientCore::GetResult(QByteArray& theArray, QNetworkReply** theReply)
{
  if (myIsGetted != true)
    return false;
  theArray = m_cache;
  *theReply = m_currentReply;
  return true;
}

QString ClientCore::GetTypeSend(const ClientCore::operations theOp)
{
  QString aRes;
  switch (theOp)
  {
    case product_list :
      aRes = "prod_list";
      break;
    case authorization :
      aRes = "authorization";
      break;
    case order_list :
      aRes = "order_list";
      break;
    case registration :
      aRes = "registration";
      break;
    case office_list :
      aRes = "office_list";
      break;
    case order_send :
      aRes = "order_send";
      break;
  }
  return aRes;
}

QString ClientCore::GetTypeClient(const ClientCore::clients theClient)
{
  QString aRes;
  switch (theClient)
  {
    case deliver :
      aRes = "deliver";
      break;
    case manager :
      aRes = "manager";
      break;
    case customer :
      aRes = "customer";
      break;
  }
  return aRes;
}

void ClientCore::initRequest(QNetworkRequest& theRequest, const operations theOp, const clients theClient)
{
  theRequest.setUrl(url + "/" + GetTypeClient(theClient));
  theRequest.setRawHeader("Type", GetTypeSend(theOp).toStdString().c_str());
}
