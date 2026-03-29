import QtQuick
import "./../components"
import "./../legacy/keyboard"
Rectangle {
    id: bottomPanel
    property var backendRef: (typeof backEnd !== "undefined" && backEnd !== null) ? backEnd : null

    anchors.fill: parent
    radius: radiusBox
    color: "#efefee"
    MouseArea{
        anchors.fill: parent
        onClicked:{
            console.log(height)
        }
    }

    Text {
        anchors {
            top: bottomPanel.top
            topMargin: 40
            horizontalCenter: bottomPanel.horizontalCenter
        }

        font {
            pixelSize: bottomPanel.height / 14
            family: systemFont
        }

        color: colordef_ccLightGray

        text: backendRef && backendRef.currentConfig ? backendRef.currentConfig.name : "No device info"
    }

    CCLogo {
        id: ccLogo

        anchors {
            right: parent.right
            bottom: parent.bottom
        }

        // Leave 60% of the width for the logotype and 40% for the IP address
        width: bottomPanel.width * 0.50
    }

    CCIPAddressText {
        anchors {
            //right: ccLogo.left
            leftMargin: 10
            bottomMargin:  30
            bottom: parent.bottom
            //horizontalCenter: parent.horizontalCenter
            left: parent.left
            //rightMargin: versionHandler.hasTouch ? navigationBar.width : 0
            //top: parent.top
        }
    }


    Rectangle {
        id:boxxx
        color: "#134B70"
        anchors {
            centerIn: parent
            margins: 10
        }

        height: 50
        width: 200
        radius: 5

        TextInput {
            id: textInput
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }
            font.pixelSize: 0.5 * parent.height
            cursorVisible: true
        }

        MouseArea {
            anchors.fill: textInput
            onClicked: {
                console.log("El TextInput fue clicado")
                textInput.focus = true

                // Mostrar el teclado virtual cuando se hace clic
                keyboardController.show()
            }
        }
    }

    // Declaración del KeyboardController
    KeyboardController {
        id: keyboardController
        target: textInput
        rootObject: bottomPanel
        // Puedes añadir más configuraciones si es necesario
    }
}
