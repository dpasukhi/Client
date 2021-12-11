import QtQuick 2.15
import QtQuick.Controls 2.15
import QtWebView 1.15

WebView {
    id: webView

    visible: true
    anchors.fill: parent


    onLoadingChanged: {
        if (loadRequest.errorString)
            console.error(loadRequest.errorString);
    }

    MyButton {

        visible: true
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
}
