/******************************************************************************
 * CCLedHeader component
******************************************************************************/

import QtQuick 2.6

Item {
    id: base

    property string ledColor: "red"
    property string label: "Red"

    height: 50
    width: 125

    Row {
        anchors {
            fill: parent
            verticalCenter: parent.verticalCenter
            margins: 8
        }

        spacing: 8

        Text {
            id: headerText

            height: parent.height
            width: parent.width - ledIndicator.width

            font {
                pixelSize: parent.width / 5 < 24 ? parent.width / 5 : 24
            }

            verticalAlignment: Text.AlignVCenter

            text: base.label
        }

        // A circular rectangle...
        Rectangle {
            id: ledIndicator

            height: parent.height
            width: height
            radius: parent.height / 2

            color: base.ledColor
        }
    }
}
