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

    //height: backEnd.currentConfig.headerHeight // se modifico por
    height: 26 //se debe verificar que hace la funcion de arriba
    Column {
        anchors.fill: parent
        spacing: 1

        Text {
            id: headerTextField

            width: parent.width
            height: parent.height - separatorLine.height

            text: base.headerString

            horizontalAlignment: Text.AlignLeft

            color: colordef_ccDarkGray

            font {
                pixelSize: parent.height-2*separatorLine.height - parent.spacing //antes 20
                family: systemFont
            }

            minimumPixelSize: 12
            fontSizeMode: Text.VerticalFit
        }

        Rectangle
        {
            id: separatorLine

            width: parent.width/3

            height: 1
            color: colordef_ccOrange

            /*border {
                color: colordef_ccOrange
                width: 1
            }*/
        }
    }
}
