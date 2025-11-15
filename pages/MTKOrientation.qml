import QtQuick

import "./../components"

Rectangle {
    id: boxOrientation
    width: parent.width;
    height: parent.height;
    color: "#f4f4f4"
    radius: radiusBox

    property real rectHeight1: height / 5
    property real rectWidth1: rectHeight1 * 4 / 3
    property real boxElementH: boxOrientation.height  / 2.4
    property real boxElementW: boxOrientation.width  / 2.2

    property var nameOrientation: ["LandScape Left", "LandScape Right", "Upside Down", "Portrait"]
    property var numOrientation: [0, 180, 90, 270]

    PageHeaderControl {
        id: pageHeader
        headerString: "DISPLAY ORIENTATION"
    }


    Grid {
        id: grid
        rows: 2
        columns: 2
        columnSpacing: 10
        rowSpacing: 10

        width: 2*boxElementW+rowSpacing
        height: 2*boxElementH+columnSpacing
        anchors.horizontalCenter:  parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10


        Repeater {
            id: repOrientation
            model: 4
            Rectangle {
                id: boxElement
                width: boxElementW
                height: boxElementH
                color: "transparent"
                //color: "#fcfcff"
                radius: 10
                border.width: 1
                border.color: index === 0? "orange" : "#bfdfff"

                Item {
                    width: rectWidth1
                    height: rectHeight1
                    anchors.centerIn: parent

                    Rectangle {
                        width: parent.width
                        height: parent.height
                        color: "#d0d0d0"
                        border.color: "#e0e0e0"

                        Rectangle {
                            width: parent.width / 8
                            height: parent.height
                            anchors.left: parent.left
                            color: "#808080"
                        }

                        Rectangle {
                            width: parent.width / 8
                            height: parent.height
                            anchors.right: parent.right
                            color: "#808080"
                        }

                        Rectangle {
                            width: parent.width / 10
                            height: width
                            anchors.top: parent.top
                            x: 3 * width
                            color: "#00ff00"
                            radius: height / 2
                        }
                    }
                    rotation:numOrientation[index]
                }
                Text {
                    text: nameOrientation[index]
                    font.pixelSize: 16
                    font.family: systemFont
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "gray"
                    anchors.bottomMargin: 5
                }


            }

        }

    }

}


