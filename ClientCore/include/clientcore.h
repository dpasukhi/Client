#ifndef CLIENTCORE_H
#define CLIENTCORE_H

#include "ClientCore_global.h"
#include <QNetworkAccessManager>

class QNetworkReply;

class CLIENTCORE_EXPORT ClientCore
{
public:
  ClientCore();
  virtual int Authorization(const QString& theLogin, const QString& thePassword) = 0;
  void SetHeader(const QString& HeaderName, const QString& HeaderValue);
public slots:
  // Method of canceling the load
  void cancelDownload();

signals:
  // A signal that sends information about the progress of the download
  void updateDownloadProgress(qint64 bytesReceived, qint64 bytesTotal);

private slots:
  // Slot for gradual reading of downloaded data
  void onReadyRead();
  // Slot for processing request completion
  void onReply(QNetworkReply* reply);

private:
  QByteArray m_cache;
  QString HeaderName;
  QString login;
  QString password;
  QString HeaderValue;
  QNetworkAccessManager m_manager;            // Network manager for downloading files
};

#endif // CLIENTCORE_H
