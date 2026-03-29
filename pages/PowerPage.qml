/******************************************************************************
 * FrontLedPage
******************************************************************************/

import QtQuick 2.6
//import QtGraphicalEffects 1.0
import CrossControl 1.0
import MyQmlModule 1.0
import "../components"

Rectangle {
    id: powerID
    property var powerHandler: (typeof powerConfigHandler !== "undefined" && powerConfigHandler !== null) ? powerConfigHandler : null
    property var backendRef: (typeof backEnd !== "undefined" && backEnd !== null) ? backEnd : null

    color: "white"

//    function incrementIndex()
//    {
//        var value = frontLedHandler.currentBlueValue;
//        value++;
//        if (value > 15)
//        {
//            value = 15;
//        }

//        frontLedHandler.currentBlueValue = value;
//    }

//    function decrementIndex()
//    {
//        var value = frontLedHandler.currentBlueValue;
//        value--;
//        if (value < 0)
//        {
//            value = 0;
//        }

//        frontLedHandler.currentBlueValue = value;
//    }

    function goBackToMain() {
        // View default page
        if (backendRef)
            backendRef.setState(MyAppState.MAIN)
        powerPage.visible = false
        navigationBar.hideEnter = false
    }

    PageHeaderControl {
        id: pageHeader
        headerString: "POWER"
    }

    Item {
        id: powerView

        anchors {
            left: parent.left
            right: parent.right
            top: pageHeader.bottom
            topMargin: 8
            bottom: parent.bottom
        }

        Column {
            anchors {
                left: parent.left
                leftMargin: 8
                top: parent.top
                topMargin: 8
            }

            spacing: 8

            Row {
                spacing: 8

                Text {
                    text: "STARTUP TRIGGER:"

                    width: 200
                    height: 50
                    verticalAlignment: Text.AlignVCenter

                    font {
                        pixelSize: 12
                    }
                }

                CCToggleButton {
                    id: startupTriggerConfigToggler

                    currentString: powerHandler ? powerHandler.startupTriggerConfig : "";

                    width: 300
                    height: 50

                    elements: ["FRONT BUTTON", "ON/OFF SIGNAL", "BOTH BUTTON AND SIGNAL"]

                    onClicked: {
                        if (powerHandler)
                            powerHandler.startupTriggerConfig = startupTriggerConfigToggler.currentString;
                    }
                }
            }

            Row {
                spacing: 8

                Text {
                    text: "EXT. ON/OFF TRIGGER TIME:"

                    width: 200
                    height: 50
                    verticalAlignment: Text.AlignVCenter

                    font {
                        pixelSize: 12
                    }
                }

                CCToggleButton {
                    id: extOnOffSigTrigTimeToggler

                    currentString: powerHandler ? powerHandler.extOnOffSigTrigTime : "";

                    width: 300
                    height: 50

                    elements: ["1", "5", "10", "20"]

                    onClicked: {
                        if (powerHandler)
                            powerHandler.extOnOffSigTrigTime = parseInt(extOnOffSigTrigTimeToggler.currentString, 10);
                    }
                }

                Text {
                    text: "SECONDS"

                    height: 50
                    verticalAlignment: Text.AlignVCenter

                    font {
                        pixelSize: 12
                    }
                }
            }

            Row {
                spacing: 8

                Text {
                    text: "ON/OFF SIGNAL ACTION:"

                    width: 200
                    height: 50
                    verticalAlignment: Text.AlignVCenter

                    font {
                        pixelSize: 12
                    }
                }

                CCToggleButton {
                    id: onOffSigActionToggler

                    currentString: powerHandler ? powerHandler.onOffSigAction : "";

                    width: 300
                    height: 50

                    elements: ["NO ACTION", "SUSPEND", "SHUTDOWN"]

                    onClicked: {
                        if (powerHandler)
                            powerHandler.onOffSigAction = onOffSigActionToggler.currentString;
                    }
                }
            }

            Row {
                spacing: 8

                Text {
                    text: "MAX. SUSPEND TIME:"

                    width: 200
                    height: 50
                    verticalAlignment: Text.AlignVCenter

                    font {
                        pixelSize: 12
                    }
                }

                CCToggleButton {
                    id: suspendMaxTimeToggler

                    currentString: powerHandler ? powerHandler.suspendMaxTime : "";

                    width: 300
                    height: 50

                    elements: ["1", "2", "5", "10"]

                    onClicked: {
                        if (powerHandler)
                            powerHandler.suspendMaxTime = parseInt(suspendMaxTimeToggler.currentString, 10);
                    }
                }

                Text {
                    text: "MINUTES"

                    height: 50
                    verticalAlignment: Text.AlignVCenter

                    font {
                        pixelSize: 12
                    }
                }
            }
        }

        StatusFieldControl {
            statusText: powerHandler ? powerHandler.lastError : "Unavailable"
        }
    }
}
