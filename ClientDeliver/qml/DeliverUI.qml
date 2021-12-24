import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.0
import QtGraphicalEffects 1.15
import QtWebView 1.15
import "componentCreation.js" as MyScript

ApplicationWindow {
    id: windowId

    property bool signInSuccess: true
    property string office_adress: ""
    property string order_adress: ""
    property var tmp_webview: undefined
    property var tmp_order: undefined
    property var list_order: []

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

        text: "Pizza Time Deliver"
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
                    let comp = Qt.createComponent("OrderItem.qml");
                    let obj = comp.createObject(gridId, {textHeader: name, id_order: id_order, office_adress: office_adress, order_adress: order_adress});
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
        signButton.onPressed: {
            if(tableSign.signReady) {
                if(json_class.authorization(tableSign.login, tableSign.password)) {
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

    Rectangle {
        id: accessMenu

        visible: false
        anchors.centerIn: parent
        width: 300
        height: 200
        radius: 10
        color: "#50a684"

        Text {
            text: "Вы хотите взять этот заказ?"
            color: "white"
            font.pixelSize: 18
            anchors.centerIn: parent
        }

        MyButton {

            width: 50
            backRect.border.color: "white"
            textButton: "Да"
            anchors {
                left: parent.left
                bottom: parent.bottom
                leftMargin: 10
                bottomMargin: 10
            }
            onPressed: {
                buttonUpdate.visible = false
                accessMenu.visible = false
                var tmp = ChangeFileJS.setNewLine(office_adress, order_adress)
                var component = Qt.createComponent("MyWebView.qml");
                tmp_webview = component.createObject(webviewItem,
                                                     {url: "file:///clientDeliver.html"});
                buttonWebView.visible = true
            }
        }


        MyButton {

            width: 50
            backRect.border.color: "white"
            textButton: "Нет"
            anchors {
                right: parent.right
                bottom: parent.bottom
                rightMargin: 10
                bottomMargin: 10
            }
            onPressed: {
                gridId.visible = true
                accessMenu.visible = false
            }
        }
    }

    Item {
        id: webviewItem
        anchors.fill: parent
    }

    MyButton {
        id: buttonWebView

        visible: false
        width: 100
        textButton: "Подтвердить"
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 25
            bottomMargin: 25
        }
        onPressed: {
            deliverMenu.visible = true
        }
    }

    Rectangle {
        id: deliverMenu

        visible: false
        anchors.centerIn: parent
        width: 300
        height: 200
        radius: 10
        color: "#50a684"

        Text {
            text: "Вы отдали заказ?"
            color: "white"
            font.pixelSize: 18
            anchors.centerIn: parent
        }

        MyButton {

            width: 50
            backRect.border.color: "white"
            textButton: "Да"
            anchors {
                left: parent.left
                bottom: parent.bottom
                leftMargin: 10
                bottomMargin: 10
            }
            onPressed: {
                if(json_class.sendStatus(tmp_order.id_order, 2)) {
                    buttonUpdate.visible = true
                    deliverMenu.visible = false
                    buttonWebView.visible = false
                    tmp_webview.destroy()
                    var tmp = ChangeFileJS.reset()
                    var num = list_order.indexOf(tmp_order, 0)
                    list_order.splice(num, 1)
                    tmp_order.destroy()
                    gridId.visible = true
                }
            }
        }


        MyButton {

            width: 50
            backRect.border.color: "white"
            textButton: "Нет"
            anchors {
                right: parent.right
                bottom: parent.bottom
                rightMargin: 10
                bottomMargin: 10
            }
            onPressed: {
                deliverMenu.visible = false
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

            var num = json_class.getOrderCount();
            for (var i = 0; i < num; i++) {
                let name = json_class.getOrderOfficeName(i);
                let id_order = json_class.getOrderID(i);
                let office_adress = json_class.getOrderOfficeAdress(i);
                let order_adress = json_class.getOrderAdress(i);
                let comp = Qt.createComponent("OrderItem.qml");
                let obj = comp.createObject(gridId, {textHeader: name, id_order: id_order, office_adress: office_adress, order_adress: order_adress});
                list_order.push(obj)
            }
        }
    }
}
