import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle {
    id: control

    property alias regContinue: buttonReg
    property bool regReady: fieldNameFirst.statusFill && fieldNameSecond.statusFill &&
                            fieldNameThird.statusFill && fieldPhone.statusFill &&
                            fieldEmail.statusFill && fieldLogin.statusFill &&
                            fieldPassword.statusFill

    property string nameFirst: fieldNameFirst.text
    property string nameSecond: fieldNameSecond.text
    property string nameThird: fieldNameThird.text
    property string phone: fieldPhone.text
    property string email: fieldEmail.text
    property string login: fieldLogin.text
    property string password: fieldPassword.text

    radius: 10
    color: "#50a684"

    ColorOverlay {

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
        id:fieldNameFirst

        hint: topHint
        hintText: "Имя"
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
        id:fieldNameSecond

        hint: topHint
        hintText: "Фамилия"
        height: 32

        anchors {
            top: fieldNameFirst.bottom
            left: parent.left
            right: parent.right
            leftMargin: 5
            rightMargin: 5
            topMargin: 25
        }
    }

    MyTextField {
        id:fieldNameThird

        hint: topHint
        hintText: "Отчество"
        height: 32

        anchors {
            top: fieldNameSecond.bottom
            left: parent.left
            right: parent.right
            leftMargin: 5
            rightMargin: 5
            topMargin: 25
        }
    }

    MyTextField {
        id: fieldPhone

        hint: topHint
        hintText: "Номер телефона"
        height: 32

        anchors {
            top: fieldNameThird.bottom
            left: parent.left
            right: parent.right
            leftMargin: 5
            rightMargin: 5
            topMargin: 20
        }
    }

    MyTextField {
        id: fieldEmail

        hint: topHint
        hintText: "Почта"
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

    MyTextField {
        id: fieldLogin

        hint: topHint
        hintText: "Логин"
        height: 32

        anchors {
            top: fieldEmail.bottom
            left: parent.left
            right: parent.right
            leftMargin: 5
            rightMargin: 5
            topMargin: 20
        }
    }

    MyTextField {
        id: fieldPassword

        hint: topHint
        hintText: "Пароль"
        height: 32

        anchors {
            top: fieldLogin.bottom
            left: parent.left
            right: parent.right
            leftMargin: 5
            rightMargin: 5
            topMargin: 20
        }
    }

    MyButton {
        id: buttonReg

        width: 100
        backRect.border.color: "white"
        textButton: "Продолжить"
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 5
            bottomMargin: 5
        }
    }

    function clearField() {
        fieldNameFirst.text = ""
        fieldNameSecond.text = ""
        fieldNameThird.text = ""
        fieldPhone.text = ""
        fieldEmail.text = ""
        fieldLogin.text = ""
        fieldPassword.text = ""
    }
}
