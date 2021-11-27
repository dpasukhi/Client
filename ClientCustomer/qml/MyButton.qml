import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: control

    property string textButton: ""
    property alias backRect: backRect

    implicitWidth: 80
    implicitHeight: 40

    background: Rectangle {
        id: backRect

        anchors.fill: parent
        color: "#50a684"
        radius: 10
    }

    contentItem: Text {

        text: textButton
        font.pixelSize: 14
        color: "white"
        horizontalAlignment : Text.AlignHCenter
        verticalAlignment : Text.AlignVCenter
    }

    states: [
        State {
            name: "default"
            when: control.enabled && !control.hovered
            PropertyChanges {
                target: backRect
                color: "#50a684"
            }
        },
        State {
            name: "hovered"
            when: control.enabled && control.hovered
            PropertyChanges {
                target: backRect
                color: "#508a84"
            }
        }
    ]
}
