#ifndef CLIENTMANAGERAPI_H
#define CLIENTMANAGERAPI_H

//#include <clientcore.h>
#include <QObject>

class ClientManagerAPI : public QObject
{
  Q_OBJECT
public:
  explicit ClientManagerAPI(QObject *parent);
};

#endif // CLIENTMANAGERAPI_H
