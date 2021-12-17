import QtQuick 2.15
import QtQuick.Controls 2.15

Column {
    id: columnText

    anchors {
        left: parent.left
        top: parent.top
        topMargin: 10
        leftMargin: 10
    }

    Repeater {
        model: ["Номер офиса: " + tmp_order.textHeader,
                "Номер заказа: " + tmp_order.id_order,
                "Адрес офиса: " + tmp_order.office_adress,
                "Адрес заказчика: " + tmp_order.order_adress,
                "Дата заказа: " + tmp_order.data_order,
                "Курьер: " + tmp_order.name_deliver,
                "Заказчик: " + tmp_order.name_client]

        Text {
            width: descriptionMenu.width - 20
            text: modelData
            color: "White"
            font.pixelSize: 14
            wrapMode: Text.Wrap
        }
    }
}
