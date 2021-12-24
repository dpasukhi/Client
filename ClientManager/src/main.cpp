#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <clientcore.h>
#include <clientmanagerapi.h>

int main(int argc, char *argv[])
{
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;

  ClientManagerAPI my_data;
  my_data.requestOrders("../../Client/ClientManager/qml/message.json");
  auto root_context = engine.rootContext();
  root_context->setContextProperty("json_class", &my_data);

  const QUrl url(QStringLiteral("qrc:/CustomerUI.qml"));
  QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                   &app, [url](QObject *obj, const QUrl &objUrl) {
    if (!obj && url == objUrl)
      QCoreApplication::exit(-1);
  }, Qt::QueuedConnection);
  engine.load(url);

  return app.exec();
}
