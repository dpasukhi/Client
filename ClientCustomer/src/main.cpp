#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "clientcustomerapi.h"

int main(int argc, char *argv[])
{
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;

  ClientCustomerAPI myAPI;
  myAPI.requestProducts(/*"../../Client/ClientCustomer/qml/message.json"*/);
  myAPI.requestOffices(/*"../../Client/ClientCustomer/qml/office.json"*/);
  auto root_context = engine.rootContext();
  root_context->setContextProperty("api_class", &myAPI);
  root_context->setContextProperty("myModel", QVariant::fromValue(myAPI.getDataOffice()));

  const QUrl url(QStringLiteral("qrc:/CustomerUI.qml"));
  QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                   &app, [url](QObject *obj, const QUrl &objUrl) {
    if (!obj && url == objUrl)
      QCoreApplication::exit(-1);
  }, Qt::QueuedConnection);
  engine.load(url);

  return app.exec();
}
