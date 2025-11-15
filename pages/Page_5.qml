import QtQuick

import "./../pages"
Item{
    width: 700//parent.width
    height: 480//parent.height

    Rectangle{
        width: 100
        height: 50
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "red"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                Qt.quit();
            }
        }
    }

    VersionsPage
    {
        id: versionsPage
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

