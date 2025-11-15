/******************************************************************************
 * BuzzerPage
******************************************************************************/

import QtQuick 2.6
//import QtGraphicalEffects 1.0
import CrossControl 1.0
import MyQmlModule 1.0
import "../components"

Rectangle {
    id: buzzerID
    radius: 10
    color: "#e9e9e9"

    function hwButtonUpPressed()
    {
        var vol = buzzerHandler.volume;

        // Set volume to the nearest upper decade
        vol = vol / 10;
        vol = Math.floor(vol);
        vol = vol * 10;

        vol += 10;
        if (vol > 100)
        {
            vol = 100;
        }

        buzzerHandler.volume = vol;
    }

    function hwButtonDownPressed()
    {
        var vol = buzzerHandler.volume;

        // Set volume to the nearest lower decade
        vol /= 10;
        var floor = Math.floor(vol);
        var decimal = vol - floor;
        vol = floor * 10;

        if (decimal === 0.0)
        {
            vol = vol - 10;
        }

        if (vol < 10)
        {
            vol = 10;
        }

        buzzerHandler.volume = vol;
    }

    function hwButtonEnterPressed()
    {
        buzzerHandler.toneLength = 100;
        // Play a random tone between 700 and 3700 Hz
        var rn = 700 + Math.random() * 3000;
        buzzerHandler.playTone(rn);
    }

    function goBackToMain() {
        // View default page
        backEnd.setState(MyAppState.MAIN)
        buzzerPage.visible = false
        navigationBar.hideEnter = false
    }

    PageHeaderControl {
        id: pageHeader
        headerString: "BUZZER"
    }

    Item {
        id: buzzerView

        anchors {
            left: parent.left
            right: parent.right
            top: pageHeader.bottom
            topMargin: 8
            bottom: parent.bottom
        }

        CCSynth {
            id: ccSynth
            anchors {
                left: parent.left
                right: parent.right
                bottom: statusField.top
                bottomMargin: 12
            }

            //este esconde o muestra el teclado por completo
            visible: true //versionHandler.hasTouch

            height: ccSynth.width / 4
        }

        // Simple buzzer demo for non-touch units
        Item {
            anchors {
                left: parent.left
                right: parent.right
                bottom: statusField.top
                top: parent.top
                margins: 0
            }
            //muestra botones de up, down, etc que
            visible: false //!versionHandler.hasTouch

            Column {
                id: navColumn
                property int fontSize: height / 8

                anchors {
                    right: parent.right
                    top: parent.top
                    topMargin: -4
                    bottom: parent.bottom
                    bottomMargin: -4
                }

                spacing: 3

                Rectangle {
                    height: parent.height / 4 - 5
                    width: height
                    radius: height / 2

                    border {
                        width: 2
                        color: colordef_ccOrange
                    }

                    color: "lightgray"

                    Text {
                        anchors {
                            centerIn: parent
                            verticalCenterOffset: -2
                        }

                        font.pixelSize: navColumn.fontSize
                        text: "♫"
                    }
                }

                Rectangle {
                    height: parent.height / 4 - 5
                    width: height
                    radius: height / 2

                    border {
                        width: 2
                        color: colordef_ccOrange
                    }

                    color: "lightgray"

                    Text {
                        anchors {
                            centerIn: parent
                            verticalCenterOffset: -2
                        }

                        font.pixelSize: navColumn.fontSize
                        text: "⇧"
                    }
                }

                Rectangle {
                    height: parent.height / 4 - 5
                    width: height
                    radius: height / 2

                    border {
                        width: 2
                        color: colordef_ccOrange
                    }

                    color: "lightgray"

                    Text {
                        anchors {
                            centerIn: parent
                            verticalCenterOffset: -2
                        }

                        font.pixelSize: navColumn.fontSize
                        text: "⇩"
                    }
                }

                Rectangle {
                    height: parent.height / 4 - 5
                    width: height
                    radius: height / 2

                    border {
                        width: 2
                        color: colordef_ccOrange
                    }

                    color: "lightgray"

                    Text {
                        anchors {
                            centerIn: parent
                            verticalCenterOffset: -2
                        }

                        font.pixelSize: navColumn.fontSize
                        text: "⇦"
                    }
                }
            }

            Text {
                anchors {
                    centerIn: parent
                }

                font.pixelSize: 48
                text: buzzerHandler.frequency
            }
        }

        StatusFieldControl {
            id: statusField
            statusText: buzzerHandler.lastError
        }
    }
}
