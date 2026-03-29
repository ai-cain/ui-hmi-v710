/******************************************************************************
 * BacklightPage
******************************************************************************/

import QtQuick 2.6
//import QtGraphicalEffects 1.0
import CrossControl 1.0
import MyQmlModule 1.0
import "./../components"

Rectangle {
    id: backlightID
    property var lightHandler: (typeof backLightHandler !== "undefined" && backLightHandler !== null) ? backLightHandler : null
    property var backendRef: (typeof backEnd !== "undefined" && backEnd !== null) ? backEnd : null
    radius: 10
    color: "#f4f4f4"//"#e9e9e9"


    function incrementBacklight()
    {
        if (lightHandler)
            lightHandler.increaseBacklight();
    }

    function decrementBacklight()
    {
        if (lightHandler)
            lightHandler.decreaseBacklight();
    }

    function goBackToMain() {
        // View default page
        if (backendRef)
            backendRef.setState(MyAppState.MAIN)
        backlightPage.visible = false
        navigationBar.hideEnter = false
    }

    function getLightSensorSymbol()
    {
        var symbol = ""
        if (!lightHandler || lightHandler.maxLightSensorValue <= 0)
        {
            return "";
        }

        var percentageOfMax = lightHandler.currentLightSensorValue / lightHandler.maxLightSensorValue;

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
                //left: parent.left
                horizontalCenter: parent.horizontalCenter
                topMargin: backlightView.height / 32
            }

            font {
                pixelSize: 15
            }

            text: "SET BACKLIGHT"
        }

        Row {
            id: setBacklightRow


            anchors {
                top: setBacklightText.bottom
                //left: parent.left
                horizontalCenter: parent.horizontalCenter
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
                value: lightHandler ? lightHandler.currentBacklightValue : minValue
                height: 50
                width: 160

                anchors.verticalCenter: parent.verticalCenter

                onCurrentValueChanged: function(newValue) {
                    if (lightHandler)
                        lightHandler.currentBacklightValue = newValue;
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
                //left: parent.left
                horizontalCenter: parent.horizontalCenter
                topMargin: backlightView.height / 46
            }

            visible: lightHandler ? lightHandler.hasLightSensor : false

            Text {
                id: lightSensorText

                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                    //left: parent.left
                    topMargin: backlightView.height / 46
                }

                font {
                    pixelSize: 15
                }

                text: "LIGHT SENSOR"
            }

            Text {
                id: lightSensorValueText

                anchors {
                    top: lightSensorText.bottom
                    horizontalCenter: parent.horizontalCenter
                    //left: parent.left
                    topMargin: -backlightView.height / 26
                }

                font {
                    pixelSize: backlightView.height / 3
                }

                Connections {
                    target: lightHandler

                    function onCurrentLightSensorValueChanged() {
                        lightSensorValueText.text = getLightSensorSymbol();
                    }
                }

                Text {
                    font {
                        pixelSize: backlightView.height / 15 >15 ? backlightView.height/15 : 15// valor numerico
                    }

                    color: colordef_ccOrange

                    text: lightHandler ? lightHandler.currentLightSensorValue : "-";

                    anchors {
                        centerIn: parent
                        verticalCenterOffset: -6
                    }
                }
            }
        }
    }

    StatusFieldControl {
        statusText: lightHandler ? lightHandler.lastError : "Unavailable"
    }
}
