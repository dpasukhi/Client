import QtQuick 2.15
import QtQuick.Controls 2.15
import QtWebView 1.15

WebView {
    id: webView

    visible: true
    anchors.fill: parent

    onLoadProgressChanged: {
        if (windowId.flag === true)
            webView.destroy();
    }

    onLoadingChanged: {
        if (loadRequest.errorString)
            console.error(loadRequest.errorString);
    }
}
