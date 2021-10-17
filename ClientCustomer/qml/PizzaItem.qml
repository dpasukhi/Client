import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: mainItemId


    property alias sourcePizza: pizzaImageId.source
    property alias textHeader: textHeaderId.text
    property alias textMain: textMainId.text

    implicitWidth: 225
    implicitHeight: 625
    color: "white"
    radius: 5

    Image {
        id: pizzaImageId

        width: 225
        height: 200
    }

    Column {

        spacing: 10
        leftPadding: 15
        rightPadding: 15

        anchors.top: pizzaImageId.bottom

        TextEdit {
            id: textHeaderId

            width: mainItemId.width - 30
            color: "#70544f"
            font.pixelSize: 16
            wrapMode: TextEdit.Wrap
        }

        TextEdit {
            id: textMainId

            width: mainItemId.width - 30
            color: "#aea19f"
            font.pixelSize: 12
            wrapMode: TextEdit.Wrap
        }

        TabBar {
            id: tabBar
            width: mainItemId.width - 30
            TabButton {
                Text {
                    color: tabBar.currentIndex == 0 ? "#70544f" : "#a69895"
                    text: "Традиционное"
                    anchors.centerIn: parent
                }

                background: Rectangle {
                    color: tabBar.currentIndex == 0 ? "#ededed" : "white"
                    radius: 8
                }
            }
            TabButton {
                Text {
                    color: tabBar.currentIndex == 1 ? "#70544f" : "#a69895"
                    text: "Тонкое"
                    anchors.centerIn: parent
                }
                background: Rectangle {
                    color: tabBar.currentIndex == 1 ? "#ededed" : "white"
                    radius: 8
                }
            }
        }

        TabBar {
            id: sizePizzaId

            width: mainItemId.width - 30

            TabButton {
                Text {
                    color: sizePizzaId.currentIndex == 0 ? "#70544f" : "#a69895"
                    text: "23"
                    anchors.centerIn: parent
                }

                background: Rectangle {
                    color: sizePizzaId.currentIndex == 0 ? "#ededed" : "white"
                    radius: 8
                }
            }
            TabButton {
                Text {
                    color: sizePizzaId.currentIndex == 1 ? "#70544f" : "#a69895"
                    text: "30"
                    anchors.centerIn: parent
                }
                background: Rectangle {
                    color: sizePizzaId.currentIndex == 1 ? "#ededed" : "white"
                    radius: 8
                }
            }
            TabButton {
                Text {
                    color: sizePizzaId.currentIndex == 2 ? "#70544f" : "#a69895"
                    text: "35"
                    anchors.centerIn: parent
                }

                background: Rectangle {
                    color: sizePizzaId.currentIndex == 2 ? "#ededed" : "white"
                    radius: 8
                }
            }
            TabButton {
                Text {
                    color: sizePizzaId.currentIndex == 3 ? "#70544f" : "#a69895"
                    text: "40"
                    anchors.centerIn: parent
                }
                background: Rectangle {
                    color: sizePizzaId.currentIndex == 3 ? "#ededed" : "white"
                    radius: 8
                }
            }

        }

        Row {
            spacing: mainItemId.width/2 - 30
            Rectangle {
                id: buttobBuyId

                width: 80
                height: 40
                color: "#50a684"
                radius: 10

                Text {
                    text: "В корзину"
                    font.pixelSize: 14
                    color: "white"
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            Text {
                id: priceId

                text: "978"
                font.pixelSize: 25
                anchors.verticalCenter: buttobBuyId.verticalCenter
                anchors.right: sizePizzaId.right
            }
        }
    }
}
