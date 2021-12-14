#include "changefilejs.h"

static const QString UpHtml = \
"    <!DOCTYPE html>                                                                                                                                   \n"
"    <html>                                                                                                                                            \n"
"    <head>                                                                                                                                            \n"
"        <title>Система заказа пиццы</title>                                                                                                           \n"
"        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/>                                                                      \n"
"        <script src=\"https://api-maps.yandex.ru/2.1/?lang=ru_RU&amp;apikey=3f75c055-0822-4251-8423-ed9e741dda8f\" type=\"text/javascript\"></script> \n"
"        <script src=\"https://yandex.st/jquery/2.2.3/jquery.min.js\" type=\"text/javascript\"></script>                                               \n"
"        <script type=\"text/javascript\">                                                                                                             \n";

static const QString BottomHtml = \
"                                                                                         \n"
"        ymaps.ready(function () {                                                            \n"
"            var myMap = new ymaps.Map('map', {                                               \n"
"                center: [56.29, 43.98],                                                      \n"
"                zoom: 16,                                                                    \n"
"                controls: ['routePanelControl']                                              \n"
"            });                                                                              \n"
"                                                                                             \n"
"            var control = myMap.controls.get('routePanelControl');                           \n"
"                                                                                             \n"
"            control.routePanel.state.set({                                                   \n"
"                type: 'auto',                                                                \n"
"                fromEnabled: false,                                                          \n"
"                from: office_address,                                                        \n"
"                to: order_address,                                                           \n"
"                toEnabled: false                                                             \n"
"            });                                                                              \n"
"                                                                                             \n"
"            control.routePanel.options.set({                                                 \n"
"                allowSwitch: true,                                                           \n"
"                reverseGeocoding: true,                                                      \n"
"                types: { auto: true, masstransit: false, pedestrian: false, taxi: false }    \n"
"            });                                                                              \n"
"                                                                                             \n"
"            var trafficControl = new ymaps.control.TrafficControl({ state: {                 \n"
"                    providerKey: 'traffic#actual',                                           \n"
"                    trafficShown: true                                                       \n"
"                }});                                                                         \n"
"            myMap.controls.add(trafficControl);                                              \n"
"            var switchPointsButton = new ymaps.control.Button({                              \n"
"                data: {content: \"Поменять местами\", title: \"Поменять точки местами\"},    \n"
"                options: {selectOnClick: false, maxWidth: 160}                               \n"
"            });                                                                              \n"
"            switchPointsButton.events.add('click', function () {                             \n"
"                control.routePanel.switchPoints();                                           \n"
"            });                                                                              \n"
"            myMap.controls.add(switchPointsButton);                                          \n"
"                                                                                             \n"
"            objectManager = new ymaps.ObjectManager({                                        \n"
"                clusterize: true,                                                            \n"
"                gridSize: 32,                                                                \n"
"                clusterDisableClickZoom: true                                                \n"
"            });                                                                              \n"
"            objectManager.objects.options.set('preset', 'islands#greenDotIcon');             \n"
"            objectManager.clusters.options.set('preset', 'islands#greenClusterIcons');       \n"
"            myMap.geoObjects.add(objectManager);                                             \n"
"        });                                                                                  \n"
"</script>                                                                                    \n"
"<style>                                                                                      \n"
"    html, body, #map {                                                                       \n"
"        width: 100%;                                                                         \n"
"        height: 100%;                                                                        \n"
"        padding: 0;                                                                          \n"
"        margin: 0;                                                                           \n"
"    }                                                                                        \n"
"</style>                                                                                     \n"
"</head>                                                                                      \n"
"<body>                                                                                       \n"
"<div id=\"map\"></div>                                                                       \n"
"</body>                                                                                      \n"
"</html>                                                                                      \n"
"                                                                                             \n";

ChangeFileJS::ChangeFileJS(QObject *parent) : QObject(parent)
{

}

bool ChangeFileJS::setNewLine(QString office_address, QString order_address)
{
  std::ofstream fout("../qml/clientDeliver.html", std::ios_base::trunc | std::ios_base::out);
  fout << UpHtml.toStdString() << std::endl;
  QString str = "        var office_address = \"" + office_address + "\"";
  fout << str.toStdString() << std::endl;
  str = "        var order_address = \"" + order_address + "\"";
  fout << str.toStdString() << std::endl;
  fout << BottomHtml.toStdString() << std::endl;
  return true;
}

bool ChangeFileJS::reset()
{
  std::ofstream fout("../qml/clientDeliver.html", std::ios_base::trunc | std::ios_base::out);
  fout << UpHtml.toStdString() << std::endl;
  QString str = "        var office_address = \"\"";
  fout << str.toStdString() << std::endl;
  str = "        var order_address = \"\"";
  fout << str.toStdString() << std::endl;
  fout << BottomHtml.toStdString() << std::endl;
  return true;
}


