/******************************************************************************
 * BacklightPage
******************************************************************************/

import QtQuick 2.6
//import QtGraphicalEffects 1.0
import CrossControl 1.0
import MyQmlModule 1.0
import "./../components"

Item {
    id: backlightID

    //color: "white"

    function incrementBacklight()
    {
        backLightHandler.increaseBacklight();
    }

    function decrementBacklight()
    {
        backLightHandler.decreaseBacklight();
    }

    function goBackToMain() {
        // View default page
        backEnd.setState(MyAppState.MAIN)
        backlightPage.visible = false
        navigationBar.hideEnter = false
    }

    function getLightSensorSymbol()
    {
        var symbol = ""
        var percentageOfMax = backLightHandler.currentLightSensorValue / backLightHandler.maxLightSensorValue;

        if (percentageOfMax < 0.01)
        {
            symbol = "\u2605"; // Unicode rainy umbrella
        }
        else if (percentageOfMax < 0.50)
        {
            symbol = "\u2601"; // Unicode cloud
        }
        else
        {
            symbol = "\u2600"; // Unicode sun
        }

        return symbol;
    }

    PageHeaderControl {
        id: pageHeader
        headerString: "BACKLIGHT"
    }

    Item {
        id: backlightView

        anchors {
            left: parent.left
            right: parent.right
            top: pageHeader.bottom
            topMargin: 8
            bottom: parent.bottom
        }

        Text {
            id: setBacklightText

            anchors {
                top: parent.top
                left: parent.left
                topMargin: backlightView.height / 32
            }

            font {
                pixelSize: 12
            }

            text: "SET BACKLIGHT"
        }

        Row {
            id: setBacklightRow

            anchors {
                top: setBacklightText.bottom
                left: parent.left
                topMargin: -backlightView.height / 62
            }

            spacing: 12

            Text {
                id: sunLow

                anchors.verticalCenter: parent.verticalCenter

                font {
                    pixelSize: 48
                }

                text: "\u2600"; // Unicode sun
            }

            CCSlider {
                minValue: 10
                maxValue: 255
                value: backLightHandler.currentBacklightValue
                height: 50
                width: 160

                anchors.verticalCenter: parent.verticalCenter

                onCurrentValueChanged: {
                    backLightHandler.currentBacklightValue = newValue;
                }
            }

            Text {
                id: sunHigh

                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 4

                font {
                    pixelSize: 96
                }

                text: "\u2600"; // Unicode sun
            }
        }

        Item {
            anchors {
                top: setBacklightRow.bottom
                left: parent.left
                topMargin: backlightView.height / 46
            }

            visible: backLightHandler.hasLightSensor

            Text {
                id: lightSensorText

                anchors {
                    top: parent.top
                    left: parent.left
                    topMargin: backlightView.height / 46
                }

                font {
                    pixelSize: 12
                }

                text: "LIGHT SENSOR"
            }

            Text {
                id: lightSensorValueText

                anchors {
                    top: lightSensorText.bottom
                    left: parent.left
                    topMargin: -backlightView.height / 26
                }

                font {
                    pixelSize: backlightView.height / 4
                }

                Connections {
                    target: backLightHandler

                    onCurrentLightSensorValueChanged: {
                        lightSensorValueText.text = getLightSensorSymbol();
                    }
                }

                Text {
                    font {
                        pixelSize: backlightView.height / 32
                    }

                    color: colordef_ccOrange

                    text: backLightHandler.currentLightSensorValue;

                    anchors {
                        centerIn: parent
                        verticalCenterOffset: -6
                    }
                }
            }
        }
    }

    StatusFieldControl {
        statusText: backLightHandler.lastError
    }
}
