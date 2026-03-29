import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "../../components"

Rectangle {
    id: root
    property var clockRef: (typeof clock !== "undefined" && clock !== null) ? clock : null
    property int timeFontSize: Math.max(56, Math.min(78, Math.round(timeCard.height * 0.26)))
    property int dateFontSize: Math.max(18, Math.min(24, Math.round(timeCard.height * 0.08)))

    width: parent ? parent.width : 0
    height: parent ? parent.height : 0
    radius: 10
    color: "#f2efe7"

    PageHeaderControl {
        id: pageHeader
        headerString: "DATE & TIME"
    }

    Rectangle {
        id: timeCard
        anchors {
            top: pageHeader.bottom
            topMargin: 20
            bottom: parent.bottom
            bottomMargin: 20
            horizontalCenter: parent.horizontalCenter
        }

        width: Math.min(root.width * 0.82, 560)
        radius: 24
        color: "#fffdf8"
        border.width: 1
        border.color: "#e4ddd0"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 18
            spacing: 10

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 34

                Row {
                    anchors.centerIn: parent
                    spacing: 10

                    Rectangle {
                        width: 88
                        height: 28
                        radius: 14
                        color: "#1f1f1f"

                        Text {
                            anchors.centerIn: parent
                            text: "CLOCK"
                            color: "#f7f3ea"
                            font.pixelSize: 12
                            font.bold: true
                        }
                    }

                    Rectangle {
                        width: 74
                        height: 28
                        radius: 14
                        color: "#f6f0e6"
                        border.width: 1
                        border.color: "#d9cfbf"

                        Text {
                            anchors.centerIn: parent
                            text: "EDIT"
                            color: "#5f584d"
                            font.pixelSize: 12
                            font.bold: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: dateTimeDialog.open()
                        }
                    }
                }
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: root.clockRef ? root.clockRef.currentTime : "--:--"
                color: "#161616"
                font.family: "URW Gothic L"
                font.pixelSize: root.timeFontSize
                font.bold: true
            }

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 120
                Layout.preferredHeight: 2
                radius: 1
                color: "#d88b43"
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: root.clockRef ? root.clockRef.currentDate : "---"
                color: "#5b564f"
                font.family: "URW Gothic L"
                font.pixelSize: root.dateFontSize
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Edit the time shown in the app"
                color: "#8b8478"
                font.pixelSize: 14
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }

    DateTimeDialog {
        id: dateTimeDialog
        parent: Overlay.overlay
        x: Math.round((((parent && parent.width) ? parent.width : root.width) - width) / 2)
        y: Math.round((((parent && parent.height) ? parent.height : root.height) - height) / 2)
        clockRef: root.clockRef
    }
}
