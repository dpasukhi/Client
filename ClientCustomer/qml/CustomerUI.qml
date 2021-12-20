import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.0
import QtGraphicalEffects 1.15
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

    Basket {
        id: menuBasket
        anchors {
            top: mainTableId.bottom
            right: parent.right
            topMargin: 15
            rightMargin: 30
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

    Rectangle {
        id: buyMenu

        visible: false
        anchors.centerIn: parent
        width: 300
        height: 200
        radius: 10
        color: "#50a684"

        ComboBox{
            id: comboId

            onActivated: textComboId.text = comboId.currentText

            anchors {
                left: parent.left
                leftMargin: 10
                top: parent.top
                topMargin: 30
                right: parent.right
                rightMargin: 10
            }

            model: myModel
            background: Rectangle{
                id: comboIdBack

                width: parent.width
                height: parent.height
                color: "#f3f3f3"
            }
            font.pointSize: 11
            width: parent.width - 20

            popup: Popup {
                y: comboId.height
                width: comboId.width
                implicitHeight: contentItem.implicitHeight

                contentItem: ListView {
                    implicitHeight: contentHeight
                    model: comboId.delegateModel
                    currentIndex: comboId.highlightedIndex
                    ScrollIndicator.vertical: ScrollIndicator { }
                }

                background: Rectangle {
                    id: popupBackId
                    color: "white"
                    border.color: "black"
                    radius: 1
                }
            }
        }

        MyTextField {
            id:addressField

            hint: topHint
            hintText: "Ваш адрес"
            height: 32

            anchors {
                top: comboId.bottom
                left: parent.left
                right: parent.right
                leftMargin: 10
                rightMargin: 10
                topMargin: 25
            }
        }

        MyButton {
            id: buttonSend

            width: 100
            backRect.border.color: "white"
            textButton: "Отправить"
            anchors {
                right: parent.right
                bottom: parent.bottom
                rightMargin: 10
                bottomMargin: 10
            }
            onPressed: {
                if(addressField.acceptableInput){
                    while(menuBasket.modelBasket.count != 0) {
                        let i = menuBasket.modelBasket.count - 1
                        menuBasket.modelBasket.remove(i)
                    }
                    buyMenu.visible = false
                }
            }
        }

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
                onPressed: buyMenu.visible = false
            }
        }
    }
}
