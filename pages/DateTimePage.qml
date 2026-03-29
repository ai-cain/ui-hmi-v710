import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "../components"

Rectangle {
    id: root
    property var clockRef: (typeof clock !== "undefined" && clock !== null) ? clock : null

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

        width: Math.min(parent.width * 0.82, 560)
        radius: 24
        color: "#fffdf8"
        border.width: 1
        border.color: "#e4ddd0"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 28
            spacing: 12

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
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
                    font.letterSpacing: 1.2
                }
            }

            Item {
                Layout.fillHeight: true
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: clockRef ? clockRef.currentTime : "--:--"
                color: "#161616"
                font.family: "URW Gothic L"
                font.pixelSize: 88
                font.bold: true
            }

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 120
                height: 2
                radius: 1
                color: "#d88b43"
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: clockRef ? clockRef.currentDate : "---"
                color: "#5b564f"
                font.family: "URW Gothic L"
                font.pixelSize: 24
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

            Button {
                Layout.alignment: Qt.AlignHCenter
                text: "Edit"
                onClicked: dateTimeDialog.open()
            }
        }
    }

    DateTimeDialog {
        id: dateTimeDialog
        anchors.centerIn: parent
        clockRef: root.clockRef
    }
}
