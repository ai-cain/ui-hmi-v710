import QtQuick 2.15
import QtQuick.Controls 2.15

import libSuma 1.0
import libOperacion 1.0
import "./../components"

Item {
    id: boxSum

    property real sumWidth: parent.width
    property real sumHeight: parent.height

    width: sumWidth
    height: sumHeight

    Operacion {
        id: operacion
        num1: 50
        num2: 10
    }

    Column {
        spacing: sumHeight/50
        anchors.centerIn: parent

        Item {
            implicitWidth: boxSum.width
            implicitHeight: row1.height
            Row {
                id: row1
                anchors.centerIn: parent
                spacing: sumWidth/20

                Item {
                    width: sumWidth/4
                    height: sumHeight*3/10

                    TextField {
                        id: num1Input
                        width: sumWidth/10
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                        }
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        text: operacion.num1.toString()
                        onTextChanged: operacion.num1 = parseInt(text)
                    }

                    Mtk_Slider {
                        anchors.centerIn: parent
                        sliderWidth: sumWidth/4
                        sliderHeight: sliderWidth/25

                        sliderDiameter: 25

                        value: operacion.num1
                        onValueChanged: operacion.num1 = value
                    }
                }
                Item {
                    width: sumWidth/4
                    height: sumHeight*3/10
                    TextField {
                        id: num2Input
                        width: sumWidth/10
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                        }
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        text: operacion.num2.toString()
                        onTextChanged: operacion.num2 = parseInt(text)
                    }

                    Mtk_Slider {
                        anchors.centerIn: parent
                        sliderWidth: sumWidth/4
                        sliderHeight: sliderWidth/25
                        sliderDiameter: 25
                        value: operacion.num2
                        onValueChanged: operacion.num2 = value

                    }

                }
            }
        }

        Item {

            implicitWidth: boxSum.width
            implicitHeight: rowResult.height
            Row {
                id: rowResult
                anchors.centerIn: parent
                spacing: sumWidth/21 // Espacio entre los botones
                Mtk_Button {
                    buttonText: "Suma"
                    cicleText: operacion.suma
                    buttonWidth: sumWidth/5
                    buttonHeight: buttonWidth/5
                }

                Mtk_Button {
                    buttonText: "Resta"
                    cicleText: operacion.resta
                    buttonWidth: sumWidth/5
                    buttonHeight: buttonWidth/5
                }

                Mtk_Button {
                    buttonText: "Multiplicación"
                    cicleText: operacion.multiplicacion
                    buttonWidth: sumWidth/5
                    buttonHeight: buttonWidth/5
                }

                Mtk_Button {
                    buttonText: "División"
                    cicleText: operacion.division.toFixed(2)
                    buttonWidth: sumWidth/5
                    buttonHeight: buttonWidth/5
                }
            }
        }
    }
}
