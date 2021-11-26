import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import QtQuick.Window 2.0
import QtQuick 2.2
import QtWebView 1.1

ApplicationWindow {
    width: 1024
    height: 720
    visible: true

    color: "#f8f8f8"

    WebView {
        id: webView
        anchors.fill: parent
        url: "../qml/client.html"
        onLoadingChanged: {
            if (loadRequest.errorString)
                console.error(loadRequest.errorString);
        }
    }
}

