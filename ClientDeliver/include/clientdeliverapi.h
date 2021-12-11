#ifndef CLIENTDELIVERAPI_H
#define CLIENTDELIVERAPI_H

#include <clientcore.h>

class ClientDeliverAPI : public ClientCore
{
public:
  ClientDeliverAPI();

  int Authorization(const QString& theLogin, const QString& thePassword) { return  -1;};
};

#endif // CLIENTDELIVERAPI_H
