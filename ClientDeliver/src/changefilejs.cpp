#include "changefilejs.h"

static const QString dataJs = \
"                             \n"
"    ymaps.ready(function () { \n"
"        var myMap = new ymaps.Map(\'map\', { \n"
"            center: [56.29, 43.98], \n"
"            zoom: 16, \n"
"            // Добавим панель маршрутизации.                                                  \n"
"            controls: [\'routePanelControl\']                                                 \n"
"        });                                                                                   \n"
"                                                                                              \n"
"        var control = myMap.controls.get(\'routePanelControl\');                              \n"
"        //control.routePanel.geolocate(\'from\');                                             \n"
"        //control.state.set(\'expanded\', true);                                              \n"
"                                                                                              \n"
"        control.routePanel.state.set({                                                        \n"
"            type: \'auto\',                                                                   \n"
"            fromEnabled: true,                                                                \n"
"            from: office_address,                                                             \n"
"            to: order_address,                                                                \n"
"            toEnabled: false                                                                  \n"
"        });                                                                                   \n"
"                                                                                              \n"
"        // Зададим опции панели для построения машрутов.                                      \n"
"        control.routePanel.options.set({                                                      \n"
"            allowSwitch: true,                                                                \n"
"            reverseGeocoding: true,                                                           \n"
"            types: { auto: true, masstransit: false, pedestrian: false, taxi: false }         \n"
"        });                                                                                   \n"
"                                                                                              \n"
"        var trafficControl = new ymaps.control.TrafficControl({ state: {                      \n"
"                providerKey: \'traffic#actual\',                                              \n"
"                trafficShown: true                                                            \n"
"            }});                                                                              \n"
"        myMap.controls.add(trafficControl);                                                   \n"
"        var switchPointsButton = new ymaps.control.Button({                                   \n"
"            data: {content: \"Поменять местами\", title: \"Поменять точки местами\"},         \n"
"            options: {selectOnClick: false, maxWidth: 160}                                    \n"
"        });                                                                                   \n"
"        switchPointsButton.events.add(\'click\', function () {                                \n"
"            control.routePanel.switchPoints();                                                \n"
"        });                                                                                   \n"
"        myMap.controls.add(switchPointsButton);                                               \n"
"                                                                                              \n"
"        objectManager = new ymaps.ObjectManager({                                             \n"
"            clusterize: true,                                                                 \n"
"            gridSize: 32,                                                                     \n"
"            clusterDisableClickZoom: true                                                     \n"
"        });                                                                                   \n"
"        objectManager.objects.options.set(\'preset\', \'islands#greenDotIcon\');              \n"
"        objectManager.clusters.options.set(\'preset\', \'islands#greenClusterIcons\');        \n"
"        myMap.geoObjects.add(objectManager);                                                  \n"
"                                                                                              \n"
"        //$.ajax({                                                                            \n"
"        //url: \"data.json\"                                                                  \n"
"        //}).done(function(data) {                                                            \n"
"        //objectManager.add(data);                                                            \n"
"        //});                                                                                 \n"
"    });                                                                                       \n";

ChangeFileJS::ChangeFileJS(QObject *parent) : QObject(parent)
{

}

bool ChangeFileJS::setNewLine(QString office_address, QString order_address)
{
  std::ofstream fout("../qml/clientDeliver.js", std::ios_base::trunc | std::ios_base::out);
  QString str = "var office_address = \"" + office_address + "\"";
  fout << str.toStdString() << std::endl;
  str = "var order_address = \"" + order_address + "\"";
  fout << str.toStdString() << std::endl;
  fout << dataJs.toStdString() << std::endl;
  return true;
}

bool ChangeFileJS::reset()
{
  std::ofstream fout("../qml/clientDeliver.js", std::ios_base::trunc | std::ios_base::out);
  fout << dataJs.toStdString() << std::endl;
  return true;
}


