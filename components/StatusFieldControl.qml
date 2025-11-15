/******************************************************************************
 * StatusFieldControl component
******************************************************************************/

import QtQuick 2.6

Rectangle {
    id: base

    property string statusText: ""

    color: "grey"

    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    height: parent.height / 9

    Text {
        anchors {
            fill: parent
            margins: base.parent.height / 100
        }

        fontSizeMode: Text.VerticalFit
        minimumPixelSize: 8

        font {
            pointSize: 20
        }

        color: "white"
        wrapMode: Text.Wrap

        text: "Status: " + base.statusText
    }
}
