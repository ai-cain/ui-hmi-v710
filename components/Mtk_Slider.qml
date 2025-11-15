import QtQuick
import QtQuick.Controls

Slider {
    id: slider

    property real sliderWidth: parent.width
    property real sliderHeight: parent.width / 36

    width: sliderWidth
    height: sliderHeight

    property real sliderDiameter: slider.width / 10

    from: 0
    to: 100
    stepSize: 1

    background: Rectangle {
        x: slider.leftPadding
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: slider.width / 2
        implicitHeight: slider.height
        width: slider.availableWidth
        height: implicitHeight
        radius: height / 2
        color: "#746785"

        Rectangle {
            width: slider.visualPosition > 0 ? slider.handle.x + slider.handle.width / 2 : 0
            height: parent.height
            color: "#ee2957"
            radius: height / 2
        }
    }

    //el boton circulo
    handle: Rectangle {
        x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: sliderDiameter/// slider.width / 10
        implicitHeight: implicitWidth //size del circulo
        radius: implicitHeight / 2
        color: slider.pressed ? "#FA36AA" : "#f0f3f5"
        border.color: slider.pressed ? "#DAFFD9" : "#A3EDF0"
        border.width: slider.width / 80
    }
}
