/******************************************************************************
 * ButtonTempl component
******************************************************************************/

import QtQuick 2.0
import QtGraphicalEffects 1.0


Item {
    id: button

    property string color: "white"
    property bool highlighted: false
    property string imgFileName: ""
    property string altFileName:  ""
    property bool useAltImage: false
    property real scale: 1.0
    signal buttonClick()

    width: parent.width
    height: parent.height

    Item {
        id: iconContainer
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        Keys.forwardTo: controller

        Behavior on opacity { NumberAnimation { easing.type: Easing.InOutQuad; duration: 600 } }
        Rectangle {
            id: imageBorder
            width: parent.width
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            border.color: "white"
            border.width: 1
            color: colordef_ccLightGray
        }

        Image {
            id: iconBody
            source: useAltImage ? altFileName : imgFileName
            anchors.fill: parent
            scale: button.scale
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: iconContainer.horizontalCenter
            anchors.verticalCenter: iconContainer.verticalCenter


            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: highlighted ? "orange" : "white"
            }
        }

        MouseArea {
            anchors.fill: parent

            onClicked: button.buttonClick();
        }
    }
}
