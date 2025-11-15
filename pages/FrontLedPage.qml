/******************************************************************************
 * FrontLedPage
******************************************************************************/

import QtQuick 2.6
//import QtGraphicalEffects 1.0
import CrossControl 1.0
import MyQmlModule 1.0
import "../components"

Rectangle {
    id: frontLedID

    color: "white"

    function incrementIndex()
    {
        var value = frontLedHandler.currentBlueValue;
        value++;
        if (value > 15)
        {
            value = 15;
        }

        frontLedHandler.currentBlueValue = value;
    }

    function decrementIndex()
    {
        var value = frontLedHandler.currentBlueValue;
        value--;
        if (value < 0)
        {
            value = 0;
        }

        frontLedHandler.currentBlueValue = value;
    }

    function goBackToMain() {
        // View default page
        backEnd.setState(MyAppState.MAIN)
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
            topMargin: 8
            bottom: parent.bottom
        }

        Column {
            id: rgbSlidersColumn
            spacing: frontLedView.height / 20

            Row {
                spacing: 24

                CCLedHeader {
                    anchors.verticalCenter: parent.verticalCenter
                    //width: frontLedView.width / 3

                    ledColor: "red"
                    label: "Red"
                }

                CCSlider {
                    id: redSlider

                    anchors.verticalCenter: parent.verticalCenter

                    minValue: 0
                    maxValue: 15

                    value: frontLedHandler.currentRedValue
                    height: frontLedView.height / 10
                    width: frontLedView.width / 5

                    onCurrentValueChanged: {
                        frontLedHandler.currentRedValue = newValue;
                    }
                }
            }

            Row {
                spacing: 24

                CCLedHeader {
                    anchors.verticalCenter: parent.verticalCenter
                    //width: frontLedView.width / 3

                    ledColor: "lime"
                    label: "Green"
                }

                CCSlider {
                    id: greenSlider

                    anchors.verticalCenter: parent.verticalCenter

                    minValue: 0
                    maxValue: 15

                    value: frontLedHandler.currentGreenValue
                    height: frontLedView.height / 10
                    width: frontLedView.width / 5

                    onCurrentValueChanged: {
                        frontLedHandler.currentGreenValue = newValue;
                    }
                }
            }


            Row {
                spacing: 24

                CCLedHeader {
                    anchors.verticalCenter: parent.verticalCenter
                    //width: frontLedView.width / 3

                    ledColor: "blue"
                    label: "Blue"
                }

                CCSlider {
                    id: blueSlider

                    anchors.verticalCenter: parent.verticalCenter

                    minValue: 0
                    maxValue: 15

                    value: frontLedHandler.currentBlueValue
                    height: frontLedView.height / 10
                    width: frontLedView.width / 5

                    onCurrentValueChanged: {
                        frontLedHandler.currentBlueValue = newValue;
                    }
                }
            }
        }

        Rectangle {
            id: resultingLed
            anchors {
                left: rgbSlidersColumn.right
                verticalCenter: rgbSlidersColumn.verticalCenter
                leftMargin: rgbSlidersColumn.spacing
            }

            color: frontLedHandler.currentColorHexCode

            height: rgbSlidersColumn.height * 0.4
            width: height

            radius: height / 2
        }

        // Blur the LED circle to create a shining impression
        // Set the amount of "shine" to the max intensity of one color component
        /*FastBlur {
               anchors.fill: resultingLed
               source: resultingLed
               transparentBorder: true
               radius: 4 * Math.max(frontLedHandler.currentRedValue, frontLedHandler.currentGreenValue, frontLedHandler.currentBlueValue)
           }*/

        StatusFieldControl {
            statusText: frontLedHandler.lastError
        }
    }
}
