import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

Rectangle {
    id: control

    property alias modelBasket: modelList
    property int helpInt: modelList.count > 0 ? 80 : 40
    property int sumAllBusket: 0

    property string reaction_no: "../image/svg/reaction_no.svg"
    property string step_minus: "../image/svg/step_minus.svg"
    property string step_plus: "../image/svg/step_plus.svg"

    radius: 10
    color: "White"
    width: 300
    height: textBasket.height + listBasket.height + helpInt

    ListModel {
        id: modelList
    }

    Text {
        id: textBasket

        text: "Корзина"
        font.pixelSize: 16
        anchors {
            left: parent.left
            top: parent.top
            topMargin: 5
            leftMargin: 5
        }
    }

    Text {
        id: textDesk

        visible: modelList.count > 0 ? false : true
        text: "Корзина пуста. Выберите пиццу из меню"
        anchors {
            top: textBasket.top
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        font.pixelSize: 12
    }

    Text {
        id: textSum

        visible: modelList.count > 0 ? true : false
        text: "Сумма заказа: "
        font.pixelSize: 12
        anchors {
            bottom: orderButton.top
            left: parent.left
            bottomMargin: 5
            leftMargin: 5
        }
    }

    Text {
        visible: modelList.count > 0 ? true : false
        text: sumOrder()
        font.pixelSize: 12
        anchors {
            bottom: orderButton.top
            right: parent.right
            rightMargin: 5
            bottomMargin: 5
        }

        function sumOrder(){
            var sum = 0
            for(var i = 0; i < modelList.count; i++){
                sum +=  parseInt(modelList.get(i).cost * modelList.get(i).number)
            }
            control.sumAllBusket = sum
            return sum.toString()
        }
    }

    MyButton {
        id: orderButton

        visible: modelList.count > 0 ? true : false
        textButton: "Оформить"
        anchors {
            bottom: parent.bottom
            right: parent.right
            bottomMargin: 5
            rightMargin: 5
        }
        onPressed: buyMenu.visible = true
    }

    ColumnLayout {
        id: listBasket

        anchors {
            top: textBasket.bottom
            left: textBasket.left
            topMargin: 5
        }

        Repeater {
            model: modelList
            delegate: Rectangle {
                id: delegateId
                width: control.width - 5
                height: imagePizza.height + info_one.height + info_two.height
                Image {
                    source: reaction_no
                    anchors {
                        top: parent.top
                        right: parent.right
                    }
                    MouseArea {
                        anchors.fill: parent
                        onPressed: modelList.remove(index)
                    }
                }
                Image {
                    id: imagePizza

                    height: 50
                    width: 50
                    source: "../image/jpg/Rustic-BBQ-(1).jpg"
                    anchors {
                        top: parent.top
                        left: parent.left
                    }
                }
                Text {
                    id: info_one
                    text: name1
                    font.pixelSize: 12
                    anchors {
                        top: parent.top
                        left: imagePizza.right
                    }
                }
                Text {
                    id: info_two
                    text: name2 + ", " + name3
                    font.pixelSize: 12
                    anchors {
                        top: info_one.bottom
                        left: imagePizza.right
                        topMargin: 1
                    }
                }
                Row {
                    id: rowBar

                    anchors.top: imagePizza.bottom
                    anchors.left: parent.left
                    anchors.topMargin: 2
                    anchors.leftMargin: 2
                    spacing: 2
                    Button {
                        width: 16
                        height: 16
                        background: Rectangle {
                            radius: 15
                            color: "#50a684"
                            ColorOverlay {
                                anchors.centerIn: parent
                                color: "white"
                                height: 16
                                width: 16
                                source: Image {
                                    source: step_minus
                                }
                            }
                        }
                        onPressed: if(number > 1) {
                                       number--
                                   }
                    }
                    Text {
                        id: textNum

                        font.pixelSize: 14
                        text: number
                    }
                    Button {
                        width: 16
                        height: 16
                        background: Rectangle {
                            radius: 15
                            color: "#50a684"
                            ColorOverlay {
                                anchors.centerIn: parent
                                color: "white"
                                height: 16
                                width: 16
                                source: Image {
                                    source: step_plus
                                }
                            }
                        }
                        onPressed: number++
                    }
                }
                Text {
                    id: info_three
                    text: cost
                    font.pixelSize: 16
                    anchors {
                        verticalCenter: rowBar.verticalCenter
                        right: parent.right
                        rightMargin: 2
                    }
                }
                Rectangle {
                    height: 1
                    color: "black"
                    anchors {
                        top: info_three.bottom
                        right: parent.right
                        left: parent.left
                        topMargin: 5
                        leftMargin: -5
                    }
                }
            }
        }
    }
}
