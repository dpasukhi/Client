import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.0
import "componentCreation.js" as MyScript

ApplicationWindow {
    id: windowId

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

        text: "Pizza Time"
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

        onPressed: {
            if(tableRegis.visible === false)
                tableSign.visible = true
        }
    }

    Basket {
        id: menuBasket
        anchors {
            top: mainTableId.bottom
            right: parent.right
            topMargin: 15
            rightMargin: 30
        }
    }

    Flickable {
        id: flickGrid

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

            columns: 3
            columnSpacing: 10
            rowSpacing: 10

            anchors {
                centerIn: parent
                top: parent.top
            }

            Component.onCompleted: {
                var num = json_class.getNum();
                for (var i = 0; i < num; i++) {
                    var name = json_class.getName(i);
                    var description = json_class.getDescription(i);
                    var price = json_class.getPrice(i);
                    MyScript.createSpriteObjects(name, description, price);
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

    TableReg {
        id: tableRegis

        visible: false
        width: 200
        height: 400
        anchors {
            top: signId.bottom
            right: signId.right
            topMargin: 5
        }
    }
}
