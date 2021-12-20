import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Templates 2.15 as T

T.TextField {
    id: rootComponent

    readonly property int topHint: 0
    readonly property int bottomHint: 1

    property int hint: -1
    property string hintText: ""

    focus: true
    leftPadding: 8
    rightPadding: 8
    topPadding: 1
    bottomPadding: 1
    verticalAlignment: TextInput.AlignVCenter
    validator: RegExpValidator{regExp: /[A-z]+/}

    background: Rectangle {
        id: backRect

        anchors.fill: parent
        border.width: 1
        radius: 4
    }

    Text {
        id: hintObjText

        height: 16
        text: rootComponent.hint != -1 ? rootComponent.hintText : ""
        color: "white"

        anchors {
            left: parent.left
            top: rootComponent.hint == bottomHint ? parent.bottom : undefined
            bottom: rootComponent.hint == topHint ? parent.top : undefined
            leftMargin: 8
            topMargin: rootComponent.hint == bottomHint ? 1 : 0
            bottomMargin: rootComponent.hint == topHint ? 1 : 0
        }
    }

    Rectangle{
        id: rootComponentRec

        visible: true
        color: "red"
        radius: 20
        width: 15
        height: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        transform: Translate {x:-10}

        Text{
            text: "!"
            anchors.centerIn: parent
            color: "white"
        }
    }

    states: [
        State{
            name: "not empty"
            when: rootComponent.acceptableInput
            PropertyChanges {
                target: rootComponentRec
                visible: false
            }
        }
    ]
}
