/******************************************************************************
 * CCIPAddressText component
******************************************************************************/

import QtQuick 2.6

Item {
    id: base

    property bool hasSecondIpAddress: backEnd.ipAddress2 !== ""

    Text {
        anchors {
            left: parent.left
            right: parent.right
            //rightMargin: 6
            top: parent.top
            bottom: parent.bottom
            //bottomMargin: 6
        }

        //horizontalAlignment: Text.AlignRight
        //verticalAlignment: Text.AlignBottom

        color: colordef_ccLightGray

        font {
            pixelSize: 24
            bold: true
        }

        minimumPixelSize: 9
        fontSizeMode: Text.HorizontalFit

        text: base.hasSecondIpAddress ? backEnd.ipAddress1 + "\n" + backEnd.ipAddress2 : backEnd.ipAddress1
    }
}
