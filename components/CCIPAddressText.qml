/******************************************************************************
 * CCIPAddressText component
******************************************************************************/

import QtQuick 2.6

Item {
    id: base
    property var backendRef: (typeof backEnd !== "undefined" && backEnd !== null) ? backEnd : null

    property bool hasSecondIpAddress: backendRef && backendRef.ipAddress2 !== ""

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

        text: !backendRef ? "-" : base.hasSecondIpAddress ? backendRef.ipAddress1 + "\n" + backendRef.ipAddress2 : backendRef.ipAddress1
    }
}
