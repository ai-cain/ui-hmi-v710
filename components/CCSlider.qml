/******************************************************************************
 * CCSlider component
******************************************************************************/

import QtQuick 2.6

Item {
    id: base

    property int minValue: 0
    property int maxValue: 100
    property int value: 0
    property string valueTextColor: "black"

    property int lineWidth: base.height / 15 > 3 ? base.height / 15 : 3
    property string lineColor: colordef_ccDarkGray

    signal currentValueChanged(int newValue)

    Rectangle {
        id: barId
        color: base.lineColor

        border {
            width: 0
        }

        height: base.lineWidth
        width: parent.width
        y: parent.height / 2 - barId.height / 2
    }

    Rectangle {
        id: valueIndicator

        height: parent.height - 4
        width: height / 1.618

        color: colordef_ccOrange
        radius: 4

        border {
            width: 3
            color: colordef_ccLightGray
        }

        x: ((base.value - base.minValue) / (base.maxValue - base.minValue)) * barId.width - valueIndicator.width / 2
        y: (parent.height - valueIndicator.height) / 2

        MouseArea {
            anchors.fill: parent

            drag.target: valueIndicator
            drag.axis: Drag.XAxis
            drag.minimumX: -valueIndicator.width / 2
            drag.maximumX: barId.width - valueIndicator.width / 2

            onMouseXChanged: {
                var value = ((valueIndicator.x + valueIndicator.width / 2) / barId.width * (base.maxValue - base.minValue)) + base.minValue
                currentValueChanged(value);
            }
        }

        Text {
            id: valueText
            anchors {
                top: parent.bottom
                left: parent.left
                right: parent.right
            }

            color: base.valueTextColor

            font {
                pointSize: base.height > 0 ? base.height / 3 : 10
                bold: true
            }

            horizontalAlignment: Text.AlignHCenter

            text: base.value
        }
    }
}
