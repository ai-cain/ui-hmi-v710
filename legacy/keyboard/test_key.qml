import QtQuick 2.15

Window {
    id: windowMain
    //objectName: "windowMain"
    width: 800
    height: 480
    visible: true
    title: qsTr("custom virtual keyboard")

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
        rootObject: windowMain
        // Puedes añadir más configuraciones si es necesario
    }

}
