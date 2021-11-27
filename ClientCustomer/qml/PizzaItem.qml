import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: mainItemId

    property alias source: pizzaImageId.source
    property alias textHeader: textHeaderId.text
    property alias textMain: textMainId.text
    property alias price: priceId.text

    implicitWidth: 225 + itemId.anchors.rightMargin * 2
    implicitHeight: 425 + itemId.anchors.topMargin
    color: "white"
    radius: 10
    clip: true

    Image {
        id: pizzaImageId

        anchors.top: parent.top
        width: parent.width
        height: 200
        source: "../image/jpg/Rustic-BBQ-(1).jpg"
    }

    Item{
        id: itemId

        anchors {
            top: pizzaImageId.bottom
            right: parent.right
            left: parent.left

            topMargin: 15
            rightMargin: 15
            leftMargin: 15
        }

        Column {
            spacing: 10
            anchors.top: itemId.bottom

            Text {
                id: textHeaderId

                width: itemId.width
                color: "#70544f"
                font.pixelSize: 16
                wrapMode: TextEdit.Wrap
            }

            Text {
                id: textMainId

                width: itemId.width
                color: "#aea19f"
                font.pixelSize: 12
                wrapMode: TextEdit.Wrap
            }

            TabBar {
                id: tabBar
                width: itemId.width
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

                width: itemId.width

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
        }
    }

    MyButton {
        id: buttobBuyId

        width: 80
        height: 40

        anchors {
            bottom: parent.bottom
            left: parent.left
            leftMargin: 15
            bottomMargin: 15
        }

        textButton: "В корзину"
        onPressed: menuBasket.modelBasket.append({name1: textHeaderId.text, name2: getTabBar(), name3: getsizePizza(), cost: priceId.text})
        function getsizePizza() {
            if(sizePizzaId.currentIndex == 0){
                return "23"
            }
            if(sizePizzaId.currentIndex == 1){
                return "30"
            }
            if(sizePizzaId.currentIndex == 2){
                return "35"
            }
            if(sizePizzaId.currentIndex == 3){
                return "40"
            }
        }

        function getTabBar() {
            if(tabBar.currentIndex == 0){
                return "Традиционное"
            } else {
                return "Тонкое"
            }
        }
    }

    Text {
        id: priceId

        anchors {
            bottom: parent.bottom
            right: parent.right
            rightMargin: 15
            bottomMargin: 20
        }

        text: "978"
        font.pixelSize: 25
    }
}
