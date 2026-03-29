/******************************************************************************
 * FrontLedPage
******************************************************************************/

import QtQuick 2.6
//import QtGraphicalEffects 1.0
import CrossControl 1.0
import MyQmlModule 1.0
import "../../components"

Rectangle {
    id: frontLedID
    property var ledHandler: (typeof frontLedHandler !== "undefined" && frontLedHandler !== null) ? frontLedHandler : null
    property var backendRef: (typeof backEnd !== "undefined" && backEnd !== null) ? backEnd : null
    radius: 10
    color: "#f4f4f4"//"#e9e9e9"

    function incrementIndex()
    {
        if (!ledHandler)
            return;
        var value = ledHandler.currentBlueValue;
        value++;
        if (value > 15)
        {
            value = 15;
        }

        ledHandler.currentBlueValue = value;
    }

    function decrementIndex()
    {
        if (!ledHandler)
            return;
        var value = ledHandler.currentBlueValue;
        value--;
        if (value < 0)
        {
            value = 0;
        }

        ledHandler.currentBlueValue = value;
    }

    function goBackToMain() {
        // View default page
        if (backendRef)
            backendRef.setState(MyAppState.MAIN)
        frontLedPage.visible = false
        navigationBar.hideEnter = false
    }

    PageHeaderControl {
        id: pageHeader
        headerString: "FRONT LED"
    }

    Item {
        id: frontLedView

        anchors {
            left: parent.left
            right: parent.right
            top: pageHeader.bottom
            topMargin: 30
            bottom: parent.bottom
        }
        Row{
            spacing: frontLedView.height / 5
            anchors.horizontalCenter: parent.horizontalCenter
            Column {
                id: rgbSlidersColumn
                spacing: frontLedView.height / 20
                //

                Row {
                    spacing: 24

                    CCLedHeader {
                        anchors.verticalCenter: parent.verticalCenter
                        width: frontLedView.width / 4

                        ledColor: "red"
                        label: "Red"
                    }

                    CCSlider {
                        id: redSlider

                        anchors.verticalCenter: parent.verticalCenter

                        minValue: 0
                        maxValue: 15

                        value: ledHandler ? ledHandler.currentRedValue : minValue
                        height: frontLedView.height / 10
                        width: frontLedView.width / 4

                        onCurrentValueChanged: function(newValue) {
                            if (ledHandler)
                                ledHandler.currentRedValue = newValue;
                        }
                    }
                }

                Row {
                    spacing: 24

                    CCLedHeader {
                        anchors.verticalCenter: parent.verticalCenter
                        width: frontLedView.width / 4

                        ledColor: "lime"
                        label: "Green"
                    }

                    CCSlider {
                        id: greenSlider

                        anchors.verticalCenter: parent.verticalCenter

                        minValue: 0
                        maxValue: 15

                        value: ledHandler ? ledHandler.currentGreenValue : minValue
                        height: frontLedView.height / 10
                        width: frontLedView.width / 4

                        onCurrentValueChanged: function(newValue) {
                            if (ledHandler)
                                ledHandler.currentGreenValue = newValue;
                        }
                    }
                }


                Row {
                    spacing: 24

                    CCLedHeader {
                        anchors.verticalCenter: parent.verticalCenter
                        width: frontLedView.width / 4

                        ledColor: "blue"
                        label: "Blue"
                    }

                    CCSlider {
                        id: blueSlider

                        anchors.verticalCenter: parent.verticalCenter

                        minValue: 0
                        maxValue: 15

                        value: ledHandler ? ledHandler.currentBlueValue : minValue
                        height: frontLedView.height / 10
                        width: frontLedView.width / 4

                        onCurrentValueChanged: function(newValue) {
                            if (ledHandler)
                                ledHandler.currentBlueValue = newValue;
                        }
                    }
                }
            }

            Rectangle {
                id: resultingLed
                anchors {
                    //left: rgbSlidersColumn.right
                    verticalCenter: rgbSlidersColumn.verticalCenter
                    //leftMargin: 2*rgbSlidersColumn.spacing

                }

                color: ledHandler ? ledHandler.currentColorHexCode : "transparent"

                height: rgbSlidersColumn.height * 0.4
                width: height

                radius: height / 2
            }
        }

        // Blur the LED circle to create a shining impression
        // Set the amount of "shine" to the max intensity of one color component
        /*FastBlur {
               anchors.fill: resultingLed
               source: resultingLed
               transparentBorder: true
               radius: 4 * Math.max(frontLedHandler.currentRedValue, frontLedHandler.currentGreenValue, frontLedHandler.currentBlueValue)
           }*/
    }

    StatusFieldControl {
        statusText: ledHandler ? ledHandler.lastError : "Unavailable"
    }
}
