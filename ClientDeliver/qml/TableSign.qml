import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle {
    id: control

    property alias regButton: buttonReg

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
            onPressed: control.visible = false
        }
    }

    MyTextField {
        id:fieldPhone

        hint: topHint
        hintText: "Логин"
        height: 32

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            leftMargin: 5
            rightMargin: 5
            topMargin: 25
        }
    }

    MyTextField {
        hint: topHint
        hintText: "Пароль"
        height: 32

        anchors {
            top: fieldPhone.bottom
            left: parent.left
            right: parent.right
            leftMargin: 5
            rightMargin: 5
            topMargin: 20
        }
    }

    MyButton {
        id: buttonReg

        visible: false
        width: 100
        backRect.border.color: "white"
        textButton: "Регистрация"
        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: 5
            bottomMargin: 5
        }
    }

    MyButton {
        id: buttonSign

        width: 60
        backRect.border.color: "white"
        textButton: "Войти"
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 5
            bottomMargin: 5
        }
    }
}
