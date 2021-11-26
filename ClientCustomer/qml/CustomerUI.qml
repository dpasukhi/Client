import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import QtQuick.Window 2.0
import QtQuick 2.2
import "componentCreation.js" as MyScript

ApplicationWindow {
    width: 1024
    height: 720
    visible: true

    color: "#f8f8f8"

    Rectangle {
        id: mainTableId

        implicitWidth: 1920
        implicitHeight: 100
        anchors.top: parent.top
        color: "white"
    }

    Text {
        id: nameId

        text: "Pizza Time"
        font.pixelSize: 25
        anchors.left: gridId.left
        anchors.verticalCenter: mainTableId.verticalCenter
    }

    Rectangle {
        id: signId

        width: 80
        height: 40
        color: "#50a684"
        radius: 10

        anchors {
            verticalCenter: mainTableId.verticalCenter
            right: gridId.right
        }

        Text {
            id: textBuyId
            text: "Вход"
            font.pixelSize: 14
            color: "white"
            anchors.centerIn: parent
        }
    }

    GridLayout {
        id: gridId

        columns: 3
        columnSpacing: 10
        rowSpacing: 10

        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
            top: mainTableId.bottom
            topMargin: 35
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
