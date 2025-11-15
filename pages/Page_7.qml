import QtQuick

import "./../pages"
Item {
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

    P_OperacionesSlider{
        sumWidth: parent.width
        sumHeight: parent.height
    }

}

