/******************************************************************************
 * PageHeaderControl component
******************************************************************************/

import QtQuick 2.6

Item {
    id: base

    property string headerString: ""

    width: parent.width

    anchors {
        //top: parent.top
        //left: parent.left
        centerIn: parent
    }

    height: backEnd.currentConfig.headerHeight


    Text {
        id: headerTextField

        width: parent.width
        height: parent.height

        text: base.headerString

        horizontalAlignment: Text.AlignHCenter

        color: colordef_ccLightGray

        anchors.topMargin: 40

        font {
            pixelSize: 33
            family: systemFont
        }

        minimumPixelSize: 24
        fontSizeMode: Text.Center
    }
}
