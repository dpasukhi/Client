#ifndef CLIENTMANAGERAPI_H
#define CLIENTMANAGERAPI_H

#include <clientcore.h>

class ClientManagerAPI : public ClientCore
{
public:
  ClientManagerAPI();
  int Authorization(const QString& theLogin, const QString& thePassword) { return  -1;};
};

#endif // CLIENTMANAGERAPI_H
