#ifndef CLIENTDELIVERAPI_H
#define CLIENTDELIVERAPI_H

//#include <clientcore.h>
#include <QObject>

class ClientDeliverAPI : public QObject
{
  Q_OBJECT
public:
  explicit ClientDeliverAPI(QObject *parent);

};

#endif // CLIENTDELIVERAPI_H
