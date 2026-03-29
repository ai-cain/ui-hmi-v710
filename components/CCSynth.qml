/******************************************************************************
 * CCSynth component
******************************************************************************/

import QtQuick 2.6
import MyQmlModule 1.0
import "../components"

Rectangle {
    id: base
    property var buzzerRef: (typeof buzzerHandler !== "undefined" && buzzerHandler !== null) ? buzzerHandler : null

    property int controlPanelHeight: 90

    Rectangle {
        id: syntChassis

        anchors {
            fill: parent
        }

        color: colordef_ccLightGray
        radius: 4

        border {
            width: 2
            color: "black"
        }

        gradient: Gradient {
                GradientStop { position: 0.0; color: colordef_ccDarkGray }
                GradientStop { position: 0.75; color: colordef_ccLightGray }
            }

        Row {
            id: controlsRow
            anchors {
                top: parent.top
                left: parent.left
                leftMargin: 8
                right: parent.right
            }

            height: base.controlPanelHeight
            spacing: 16

            Column
            {
                id: synthName
                height: parent.height
                width: nameText.implicitWidth

                spacing: 2

                anchors.verticalCenter: parent.verticalCenter

                Text {
                    id: nameText
                    height: parent.height * 0.62
                    verticalAlignment: Text.AlignBottom

                    font {
                        pixelSize: 28
                        bold: true
                        italic: true
                        underline: true
                        family: systemFont
                    }

                    fontSizeMode: Text.HorizontalFit
                    minimumPixelSize: 12

                    color: colordef_ccOrange
                    text: "CCSynth AL-91"
                }

                Text {
                    height: parent.height * 0.3
                    width: parent.width

                    font {
                        pixelSize: 12
                    }

                    fontSizeMode: Text.HorizontalFit
                    minimumPixelSize: 4

                    color: colordef_ccOrange

                    text: "NONPROGRAMMABLE MONOPHONIC SYNTHESIZER"
                }
            }

            Text {
                id: textVolume
                height: parent.height
                verticalAlignment: Text.AlignVCenter

                font {
                    pixelSize: 14
                    bold: true
                }

                fontSizeMode: Text.HorizontalFit
                minimumPixelSize: 12

                color: colordef_ccOrange

                text: "VOLUME:"
            }

            CCSlider {
                id: volumeSlider

                anchors.verticalCenter: parent.verticalCenter

                minValue: 10
                maxValue: 100
                valueTextColor: "white"

                value: buzzerRef ? buzzerRef.volume : minValue
                height: parent.height * 0.5
                width: (parent.width - synthName.width - textVolume.width - textToneLength.width - controlsRow.spacing * 4 - 44 - checkBoxBlocking.width) / 2

                onCurrentValueChanged: function(newValue) {
                    if (buzzerRef)
                        buzzerRef.volume = newValue;
                }
            }

            Text {
                id: textToneLength
                height: parent.height
                verticalAlignment: Text.AlignVCenter

                font {
                    pixelSize: 14
                    bold: true
                }

                fontSizeMode: Text.HorizontalFit
                minimumPixelSize: 12

                color: colordef_ccOrange

                text: "TONE LENGTH:"
            }

            CCSlider {
                id: toneLengthSlider

                anchors.verticalCenter: parent.verticalCenter

                minValue: 50 // 50 ms
                maxValue: 2000 // 2 secs
                valueTextColor: "white"

                value: buzzerRef ? buzzerRef.toneLength : minValue
                height: parent.height * 0.5
                width: (parent.width - synthName.width - textVolume.width - textToneLength.width - controlsRow.spacing * 4 - 44 - checkBoxBlocking.width) / 2

                onCurrentValueChanged: function(newValue) {
                    if (buzzerRef)
                        buzzerRef.toneLength = newValue;
                }
            }

            CCCheckBox {
                id: checkBoxBlocking
                height: parent.height * 0.5

                anchors.verticalCenter: parent.verticalCenter

                onClicked: if (buzzerRef) buzzerRef.blockingMode = checkBoxBlocking.checked

                text: "BLOCKING:"
            }
        }

        Item {
            id: keysItem

            property int spacing: 8

            anchors {
                fill: parent
                topMargin: base.controlPanelHeight
                leftMargin: 16
                rightMargin: 16
            }

            Row {
                anchors.fill: parent

                spacing: 0

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.C
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.D
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.E
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.F
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.G
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.A
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.B
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.C
                    octaveMultiplier: 2
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.D
                    octaveMultiplier: 2
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.E
                    octaveMultiplier: 2
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.F
                    octaveMultiplier: 2
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.G
                    octaveMultiplier: 2
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.A
                    octaveMultiplier: 2
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.B
                    octaveMultiplier: 2
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.C
                    octaveMultiplier: 4
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.D
                    octaveMultiplier: 4
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.E
                    octaveMultiplier: 4
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.F
                    octaveMultiplier: 4
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.G
                    octaveMultiplier: 4
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.A
                    octaveMultiplier: 4
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.B
                    octaveMultiplier: 4
                }

                CCSynthKey {
                    width: parent.width / 22 // 22 white keys
                    height: parent.height
                    keyColor: "white"
                    frequency: BuzzerHandler.C
                    octaveMultiplier: 8
                }
            }

            Row {
                anchors {
                    fill: parent
                    leftMargin: (parent.width / 22) * 0.68 //parent.width / 16 - parent.width / 40
                }

                spacing: (parent.width / 22) * 0.355

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.CS
                }

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.DS
                }

                Item {
                    width: parent.width / 33
                    height: parent.height * 0.6
                }

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.FS
                }

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.GS
                }

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.AS
                }

                Item {
                    width: parent.width / 33
                    height: parent.height * 0.6
                }

                // Octave 2

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.CS
                    octaveMultiplier: 2
                }

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.DS
                    octaveMultiplier: 2
                }

                Item {
                    width: parent.width / 33
                    height: parent.height * 0.6
                }

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.FS
                    octaveMultiplier: 2
                }

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.GS
                    octaveMultiplier: 2
                }

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.AS
                    octaveMultiplier: 2
                }

                Item {
                    width: parent.width / 33
                    height: parent.height * 0.6
                }

                // Octave 3

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.CS
                    octaveMultiplier: 4
                }

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.DS
                    octaveMultiplier: 4
                }

                Item {
                    width: parent.width / 33
                    height: parent.height * 0.6
                }

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.FS
                    octaveMultiplier: 4
                }

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.GS
                    octaveMultiplier: 4
                }

                CCSynthKey {
                    width: parent.width / 33
                    height: parent.height * 0.6
                    keyColor: "black"
                    frequency: BuzzerHandler.AS
                    octaveMultiplier: 4
                }
            }
        }
    }
}
