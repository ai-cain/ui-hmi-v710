import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property string buttonText: "ButtonText"
    property string cicleText: "CircleText"
    property real buttonWidth: 100
    property real buttonHeight: 40

    width: buttonWidth
    height: buttonHeight + buttonWidth / 5 + 10 // Suma espacio para el círculo

    Rectangle {
        id: buttonRect
        width: parent.width
        height: buttonHeight
        radius: height / 3
        color: "transparent"
        border.color: "#A5D0E9" // Color del borde
        border.width: 2

        Text {
            text: buttonText
            color: "#050507"
            font.pixelSize: parent.height * 0.5
            anchors.centerIn: parent
        }
    }

    Rectangle {
        width: buttonWidth / 2
        height: width / 3
        radius: height / 2
        color: "transparent"
        border.color: "#A5D0E9" // Color del borde del círculo
        border.width: 2
        anchors.horizontalCenter: parent.horizontalCenter
        y: buttonRect.height + height // Ajusta el círculo debajo del botón

        Text {
            text: cicleText
            color: "#212E60"
            font.pixelSize: parent.height * 0.5
            anchors.centerIn: parent
        }
    }
}
