import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: mainItemId

    property alias textHeader: nameOffice.text
    property alias id_order: numberOrder.text
    property string office_adress: ""
    property string order_adress: ""

    implicitWidth: 400
    implicitHeight: 100
    background: Rectangle {
        id: backRect

        anchors.fill: parent
        color: mainItemId.hovered ? "gray" : "white"
        radius: 10
    }
    clip: true

    onPressed: {
        windowId.office_adress = office_adress
        windowId.order_adress = order_adress
        //var tmp = ChangeFileJS.setNewLine(office_adress, order_adress)
        accessMenu.visible = true
        gridId.visible = false
    }

    Text {
        id: nameOffice

        font.pixelSize: 30

        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 10
        }
    }

    Text {
        id: numberOrder

        font.pixelSize: 18

        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
    }

}
