/******************************************************************************
 * CCSynthKey component
******************************************************************************/

import QtQuick 2.6

Rectangle {
    id: base

    property int frequency: 0
    property int octaveMultiplier: 1
    property string keyColor: "white"

    color: keyColor

    border {
        width: 2
        color: "black"
    }

    radius: Qt.colorEqual(base.color, "black") ? 4 : 2

    MouseArea {
        anchors.fill: parent

        onPressed: {
            buzzerHandler.playTone(base.frequency * base.octaveMultiplier);
            base.color = colordef_ccOrange
        }

        onReleased:
        {
            base.color = base.keyColor
        }
    }
}
