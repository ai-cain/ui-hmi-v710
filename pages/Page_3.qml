import QtQuick
import "./../pages"
Item{
    width: stackView.width //parent.width
    height: stackView.height
    //anchors.fill: parent
    BuzzerPage
    {
        id: buzzerPage
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            bottomMargin: 4
        }

        width: parent.width  //navigationBar.isShowing ? parent.width - navigationBar.width : parent.width

        visible: true//false
        opacity: visible ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { easing.type: Easing.InOutQuad; duration: 600 } }
    }
}
