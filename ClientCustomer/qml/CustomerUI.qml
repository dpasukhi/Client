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

    QtObject {
        id: p

        property int count: 0
        property var list_officeName: []
        property var list_officeAdress: []
        property var list_officeId: []
    }

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

        property bool signOk: false
        width: 80
        height: 40
        textButton: "Вход"

        anchors {
            verticalCenter: mainTableId.verticalCenter
            right: flickGrid.right
            rightMargin: 10
        }

        onPressed: {
            if(signId.signOk) {
                signId.textButton = "Вход"
                signId.signOk = false
                loginUser.visible = false
            } else {
                if(tableRegis.visible === false)
                    tableSign.visible = true
            }
        }

        Text {
            id: loginUser

            font.pixelSize: 14
            color: "black"
            visible: false
            text: ""
            anchors {
                right: parent.left
                rightMargin: 10
                verticalCenter: parent.verticalCenter
            }
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
                var num = api_class.getProductCount();
                for (var i = 0; i < num; i++) {
                    var name = api_class.getProductName(i);
                    var description = api_class.getProductDescription(i);
                    var price = api_class.getProductPrice(i);
                    var id = api_class.getProductID(i);
                    MyScript.createSpriteObjects(name, description, price, id);
                }
                p.count = api_class.getOfficeCount();
                for (var j = 0; j < p.count; j++) {
                    p.list_officeName.push(api_class.getOfficeName(j));
                    p.list_officeAdress.push(api_class.getOfficeAdress(j));
                    p.list_officeId.push(api_class.getOfficetID(j));
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
        signButton.onPressed: {
            if(tableSign.signReady) {
                if(api_class.authorization(tableSign.login, tableSign.password)) {
                    tableSign.visible = false
                    loginUser.text = tableSign.login
                    loginUser.visible = true
                    signId.textButton = "Выйти"
                    signId.signOk = true
                    tableSign.clearField()
                }
            }
        }
    }

    TableReg {
        id: tableRegis

        visible: false
        width: 200
        height: 450
        anchors {
            top: signId.bottom
            right: signId.right
            topMargin: 5
        }

        regContinue.onPressed: {
            if(tableRegis.regReady) {
                if(api_class.registration(tableRegis.nameFirst, tableRegis.nameSecond, tableRegis.nameThird,
                                          tableRegis.phone, tableRegis.email, tableRegis.login, tableRegis.password)) {
                    tableRegis.visible = false
                    loginUser.text = tableRegis.login
                    loginUser.visible = true
                    signId.textButton = "Выйти"
                    signId.signOk = true
                    tableRegis.clearField()
                }
            }
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

            property int currentId: 0

            onActivated: {
                comboId.displayText = comboId.currentText
                var num = p.list_officeName.indexOf(comboId.currentText, 0)
                comboId.currentId = p.list_officeId[num]
            }

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
                    api_class.setOrderSumPrice(menuBasket.sumAllBusket)
                    api_class.setOrderOfficeID(comboId.currentId)
                    api_class.setOrderAdress(addressField.text)
                    for(var j = 0; j < menuBasket.modelBasket.count; j++) {
                        for(var k = 0; k < menuBasket.modelBasket.get(j).number; k++) {
                            api_class.setOrderID(menuBasket.modelBasket.get(k).pizzaId)
                            console.log(menuBasket.modelBasket.get(k).pizzaId)
                        }
                    }
                    if(api_class.sendOrder()) {
                        while(menuBasket.modelBasket.count != 0) {
                            let i = menuBasket.modelBasket.count - 1
                            menuBasket.modelBasket.remove(i)
                        }
                        buyMenu.visible = false
                    }
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
