/******************************************************************************
 * PageHeaderControl component
******************************************************************************/

import QtQuick 2.6

Item {
    id: base

    property string headerString: ""

    width: parent.width

    anchors {
        top: parent.top
        left: parent.left
    }

    height: backEnd.currentConfig.headerHeight

    Column {
        anchors.fill: parent
        spacing: 0

        Text {
            id: headerTextField

            width: parent.width
            height: parent.height - separatorLine.height

            text: base.headerString

            horizontalAlignment: Text.AlignLeft

            color: colordef_ccDarkGray

            font {
                pixelSize: 24
                family: systemFont
            }

            minimumPixelSize: 12
            fontSizeMode: Text.VerticalFit
        }

        Rectangle
        {
            id: separatorLine

            width: parent.width

            height: 2

            border {
                color: colordef_ccOrange
                width: 2
            }
        }
    }
}
