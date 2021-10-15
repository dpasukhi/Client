#include <mainwindow.h>
#include <QApplication>
#include <clientengine.h>

static const QString ORGANIZATION_NAME("UNN");
static const QString ORGANIZATION_DOMAIN("pizza.ru");
static const QString APPLICATION_NAME("Pizza for you Client");
static const QString SETTINGS_TRAY("settings/tray");

int main(int argc, char *argv[])
{
  QApplication a(argc, argv);
  MainWindow w;
  w.show();
  return a.exec();
}
