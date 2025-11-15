import QtQuick 2.0

/*Clock {
    id: clock
    width:  400
    height: 400
}
*/

Item {
    id: root
    width: 300
    height: 300

    // Rectangle that will be rotated
    Rectangle {
        id: rotatingRectangle
        width: 100
        height: 100
        color: "lightblue"
        anchors.centerIn: parent
        rotation: rotationAngle // Bind rotation to the rotationAngle property

        MouseArea {
            id: dragArea
            anchors.fill: parent
            cursorShape: Qt.ClosedHandCursor

            // Set drag target
            drag.target: rotatingRectangle

            onPositionChanged: {
                if (drag.active) {
                    // Calculate the angle of rotation based on the mouse position
                    var centerX = rotatingRectangle.width / 2;
                    var centerY = rotatingRectangle.height / 2;
                    var mouseX = dragArea.x - centerX;
                    var mouseY = dragArea.y - centerY;
                    var angle = Math.atan2(mouseY, mouseX) * 180 / Math.PI + 90;

                    // Normalize angle to [0, 360) range
                    angle = angle % 360;
                    if (angle < 0) {
                        angle += 360;
                    }

                    // Set the rotation angle of the rectangle
                    rotationAngle = angle;
                }
            }

            onPressed: {
                drag.active = true;
            }

            onReleased: {
                drag.active = false;
            }
        }
    }

    // Property to control rotation angle
    property real rotationAngle: 0
}

