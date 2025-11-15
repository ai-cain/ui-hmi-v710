import QtQuick 2.15
import QtQuick.Controls
import "./../js/Suma.js" as SumaFunction
//suma con js
Rectangle {
    width: 300
    height: 300
    Column {
            anchors.centerIn: parent
            spacing: 10

            Text {
                id: num1Text
                text: "Número 1: " + SumaFunction.sumaObject.num1
            }

            // Slider para num1
            Slider {
                id: num1Slider
                from: 0
                to: 100
                stepSize: 1
                value: SumaFunction.sumaObject.num1
                onValueChanged: {
                    SumaFunction.updateNum1(value);
                    num1Text.text = "Número 1: " + SumaFunction.sumaObject.num1;
                    resultText.text = "Resultado: " + SumaFunction.getResult();
                }
            }
            Text {
                id: num2Text
                text: "Número 2: " + SumaFunction.sumaObject.num2
            }
            // Slider para num2
            Slider {
                id: num2Slider
                from: 0
                to: 100
                stepSize: 1
                value: SumaFunction.sumaObject.num2
                onValueChanged: {
                    SumaFunction.updateNum2(value);
                    num2Text.text = "Número 2: " + SumaFunction.sumaObject.num2;
                    resultText.text = "Resultado: " + SumaFunction.getResult();
                }
            }



            Text {
                id: resultText
                text: "Resultado: " + SumaFunction.getResult()
            }

            Button {
                text: "Resetear Valores"
                onClicked: {
                    SumaFunction.resetValues();
                    num1Slider.value = SumaFunction.sumaObject.num1;
                    num2Slider.value = SumaFunction.sumaObject.num2;
                    num1Text.text = "Número 1: " + SumaFunction.sumaObject.num1;
                    num2Text.text = "Número 2: " + SumaFunction.sumaObject.num2;
                    resultText.text = "Resultado: " + SumaFunction.getResult();
                }
            }
        }
}
