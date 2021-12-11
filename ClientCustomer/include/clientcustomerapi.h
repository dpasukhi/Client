#ifndef CLIENTCUSTOMERAPI_H
#define CLIENTCUSTOMERAPI_H

#include <clientcore.h>

class ClientCustomerAPI : public ClientCore
{
public:
  ClientCustomerAPI();
  int Authorization(const QString& theLogin, const QString& thePassword) { return  -1;};
};

#endif // CLIENTCUSTOMERAPI_H
