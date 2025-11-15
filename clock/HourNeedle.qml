import QtQuick 2.0

Item {
    id: id_root
    property int value: 0
    property int valueminute: 0
    property int granularity: 12
    property int rotationOffset: 90  // Offset to align the needle correctly

    Rectangle {
        width: 2
        height: id_root.height * 0.3
        color: "#c6eef3"
        anchors {
            horizontalCenter: id_root.horizontalCenter
            bottom: id_root.verticalCenter
        }
        antialiasing: true
    }

    // Rotation calculation
    rotation: (360 / granularity) * (value % granularity) + (360 / 60) * (valueminute % 60) - rotationOffset
    antialiasing: true

    // MouseArea for drag functionality
    MouseArea {
        id: dragArea
        anchors.fill: parent
        cursorShape: Qt.ClosedHandCursor

        onPositionChanged: {
            if (drag.active) {
                // Calculate new angle based on the mouse position
                var centerX = id_root.width / 2;
                var centerY = id_root.height / 2;
                var deltaX = dragArea.x - centerX;
                var deltaY = dragArea.y - centerY;
                var angle = Math.atan2(deltaY, deltaX) * 180 / Math.PI + 90;

                // Normalize angle to [0, 360) range
                angle = angle % 360;
                if (angle < 0) {
                    angle += 360;
                }

                // Convert angle to a value for the hour needle
                var newHourValue = Math.round((angle / 360) * granularity);
                id_root.value = newHourValue;
                id_root.valueminute = Math.round(((angle % (360 / granularity)) / (360 / granularity)) * 60);
            }
        }

        onPressed: {
            drag.active = true;
        }

        onReleased: {
            drag.active = false;
        }
    }

    // Drag properties
    Drag.active: dragArea.drag.active
    Drag.hotSpot.x: id_root.width / 2
    Drag.hotSpot.y: id_root.height
}
