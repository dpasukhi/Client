import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.0
import QtGraphicalEffects 1.15

ApplicationWindow {
    id: windowId

    property bool signInSuccess: true
    property string office_adress: ""
    property string order_adress: ""
    property var tmp_order: undefined
    property var list_order: []
    property var infoOrder: undefined

    width: 1920
    height: 1080
    visible: true

    color: "#f8f8f8"

    Rectangle {
        id: mainTableId

        implicitWidth: 1920
        implicitHeight: 100
        anchors {
            top: parent.top
        }
        color: "white"
    }

    Text {
        id: nameId

        text: "Pizza Time Manager"
        font.pixelSize: 25
        anchors {
            left: flickGrid.left
            leftMargin: 10
            verticalCenter: mainTableId.verticalCenter
        }
    }

    MyButton {
        id: signId

        width: 80
        height: 40
        textButton: "Вход"

        anchors {
            verticalCenter: mainTableId.verticalCenter
            right: flickGrid.right
            rightMargin: 10
        }

        onPressed: tableSign.visible = true
    }

    Flickable {
        id: flickGrid

        visible: signInSuccess
        anchors {
            top: mainTableId.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            topMargin: 15
            bottomMargin: 15
        }
        clip: true
        contentHeight: gridId.implicitHeight
        ScrollBar.vertical: ScrollBar {}

        GridLayout {
            id: gridId

            columns: 1
            columnSpacing: 10
            rowSpacing: 10

            anchors {
                centerIn: parent
                top: parent.top
            }

            Component.onCompleted: {
                var num = json_class.getOrderCount();
                for (var i = 0; i < num; i++) {
                    let name = json_class.getOrderOfficeName(i);
                    let id_order = json_class.getOrderID(i);
                    let office_adress = json_class.getOrderOfficeAdress(i);
                    let order_adress = json_class.getOrderAdress(i);
                    let data_order = json_class.getOrderData(i);
                    let name_deliver = json_class.getNameDeliver(i);
                    let name_client = json_class.getNameClient(i);
                    let comp = Qt.createComponent("OrderItem.qml");
                    let obj = comp.createObject(gridId, {textHeader: name, id_order: id_order, office_adress: office_adress, order_adress: order_adress, data_order: data_order, name_deliver: name_deliver, name_client: name_client});
                    list_order.push(obj)
                }
            }
        }
    }

    TableSign {
        id: tableSign

        visible: false
        width: 200
        height: 175
        anchors {
            top: signId.bottom
            right: signId.right
            topMargin: 5
        }
        regButton.onPressed: {
            tableSign.visible = false
            tableRegis.visible = true
        }
    }

    Rectangle {
        id: accessMenu

        visible: false
        anchors.centerIn: parent
        width: 300
        height: 200
        radius: 10
        color: "#50a684"

        Text {
            text: "Что вы хотите сделать с заказом?"
            color: "white"
            font.pixelSize: 18
            anchors.centerIn: parent
        }

        MyButton {
            id: buttonDelete

            width: 70
            backRect.border.color: "white"
            textButton: "Удалить"
            anchors {
                left: parent.left
                bottom: parent.bottom
                leftMargin: 10
                bottomMargin: 10
            }
            onPressed: {
                accessMenu.visible = false
                gridId.visible = true
                var num = list_order.indexOf(tmp_order, 0)
                list_order.splice(num, 1)
                tmp_order.destroy()
            }
        }


        MyButton {
            width: 100
            backRect.border.color: "white"
            textButton: "Посмотреть"
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: buttonDelete.verticalCenter
                bottom: parent.bottom
                bottomMargin: 10
            }
            onPressed: {
                let comp = Qt.createComponent("InfoOrder.qml");
                infoOrder = comp.createObject(descriptionMenu, {});
                descriptionMenu.visible = true
            }
        }

        MyButton {

            width: 70
            backRect.border.color: "white"
            textButton: "Отмена"
            anchors {
                right: parent.right
                bottom: parent.bottom
                rightMargin: 10
                bottomMargin: 10
            }
            onPressed: {
                accessMenu.visible = false
                gridId.visible = true
            }
        }

        Rectangle {
            id: descriptionMenu

            anchors.fill: parent
            visible: false
            radius: 10
            color: "#50a684"

            ColorOverlay {
                id: coloroverlay

                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: 5
                    rightMargin: 5
                }

                color: "white"
                height: 16
                width: 16
                source: Image {
                    source: "../image/svg/reaction_no.svg"
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        descriptionMenu.visible = false
                        infoOrder.destroy()
                    }
                }
            }
        }
    }

    MyButton {
        id: buttonUpdate

        width: 100
        textButton: "Обновить"
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 15
            bottomMargin: 15
        }

        onPressed: {
            for(var k = 0; k < list_order.length; k++) {
                list_order[k].destroy()
            }
            while(list_order.length != 0) {
                list_order.pop()
            }

            var num = json_class.getNum();
            for(var j = 0; j < num; j++) {
                let name = json_class.getName(j);
                let id_order = json_class.getId_order(j);
                let office_adress = json_class.getOffice_adress(j);
                let order_adress = json_class.getOrder_adress(j);
                let data_order = json_class.getData_order(j);
                let name_deliver = json_class.getName_deliver(j);
                let name_client = json_class.getName_client(j);
                let comp = Qt.createComponent("OrderItem.qml");
                let obj = comp.createObject(gridId, {textHeader: name, id_order: id_order, office_adress: office_adress, order_adress: order_adress, data_order: data_order, name_deliver: name_deliver, name_client: name_client});
                list_order.push(obj)
            }
        }
    }
}
