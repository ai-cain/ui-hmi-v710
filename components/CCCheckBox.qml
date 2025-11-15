/******************************************************************************
 * CCCheckBox component
******************************************************************************/

import QtQuick 2.6
import QtQuick.Controls 2.4

// Based on https://doc.qt.io/qt-5/qtquickcontrols2-customize.html#customizing-checkbox

CheckBox {
    id: control

    width: indicatorPart.width + textPart.paintedWidth

    contentItem: Text {
        id: textPart

        text: control.text

        font {
            pixelSize: 14
            bold: true
        }

        color: colordef_ccOrange
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
    }

    indicator: Rectangle {
        id: indicatorPart

        height: control.height
        width: height

        anchors {
            left: textPart.right
            leftMargin: -control.height / 2
        }

        radius: 3

        border {
            color: colordef_ccLightGray
            width: 3
        }

        // Simple rectangle marker
        Rectangle {
            width: parent.height - 16
            height: parent.height - 16
            x: 8
            y: 8
            radius: 2
            color: colordef_ccOrange
            visible: control.checked
        }
    }
}
