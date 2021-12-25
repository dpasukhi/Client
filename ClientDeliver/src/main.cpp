#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <clientcore.h>
#include <QQmlContext>
#include "changefilejs.h"
#include <QtWebView/QtWebView>
#include <clientdeliverapi.h>

int main(int argc, char *argv[])
{
  QtWebView::initialize();

  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;

  ClientDeliverAPI my_data;
  ChangeFileJS changeSome;
  my_data.requestOrders(/*"../../Client/ClientDeliver/qml/message.json"*/);
  auto root_context = engine.rootContext();
  root_context->setContextProperty("json_class", &my_data);
  root_context->setContextProperty("ChangeFileJS", &changeSome);

  const QUrl url(QStringLiteral("qrc:/DeliverUI.qml"));
  QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                   &app, [url](QObject *obj, const QUrl &objUrl) {
    if (!obj && url == objUrl)
      QCoreApplication::exit(-1);
  }, Qt::QueuedConnection);
  engine.load(url);

  return app.exec();
}
