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
}
