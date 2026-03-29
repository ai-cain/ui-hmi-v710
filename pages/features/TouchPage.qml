import QtQuick

Rectangle {
    width: parent.width;
    height: parent.height;
    color: "#f4f4f4"
    radius: radiusBox

    MultiPointTouchArea {
        anchors.fill: parent
        minimumTouchPoints: 1
        maximumTouchPoints: 6

        touchPoints: [
            TouchPoint { id: touch1 },
            TouchPoint { id: touch2 },
            TouchPoint { id: touch3 },
            TouchPoint { id: touch4 },
            TouchPoint { id: touch5 },
            TouchPoint { id: touch6 }
        ]
    }

    Rectangle {
        x: touch1.x - width/2; y: touch1.y - height/2
        width: parent.width/5 ; height: parent.height/5
        visible: touch1.pressed
        radius: 10
        color: "cyan"
    }
    Rectangle {//--> collapse
        x: touch2.x - width/2; y: touch2.y - height/2
        width: parent.width/5 ; height: parent.height/5
        visible: touch2.pressed
        radius: 10
        color: "blue"
    }//<-- collapse
    Rectangle {//--> collapse
        x: touch3.x - width/2; y: touch3.y - height/2
        width: parent.width/5 ; height: parent.height/5
        visible: touch3.pressed
        radius: 10
        color: "red"
    }//<-- collapse
    Rectangle {//--> collapse
        x: touch4.x - width/2; y: touch4.y - height/2
        width: parent.width/5 ; height: parent.height/5
        visible: touch4.pressed
        radius: 10
        color: Qt.rgba(0,1,0.6,1)
    }//<-- collapse
    Rectangle {//--> collapse
        x: touch5.x - width/2; y: touch5.y - height/2
        width: parent.width/5 ; height: parent.height/5
        visible: touch5.pressed
        radius: 10
        color: "#C566E9"
    }//<-- collapse
    Rectangle {//--> collapse
        x: touch6.x - width/2; y: touch6.y - height/2
        width: parent.width/5 ; height: parent.height/5
        visible: touch6.pressed
        radius: 10
        color: "#E966C5"
    }//<-- collapse

    clip: ! touch1.pressed
    Item {
        id: container
        x: parent.width / 2
        y:parent.height / 2
        visible: !(touch1.pressed || touch2.pressed || touch3.pressed || touch4.pressed || touch5.pressed || touch6.pressed)
        Text {
            id: text2
            anchors.centerIn: parent
            color: "#555555"
            text: qsTr("Touch Me!")
            font.pixelSize: 32

            //! [letterspacing]
            SequentialAnimation on font.letterSpacing {
                loops: Animation.Infinite
                NumberAnimation {
                    from: 0
                    to: 50
                    easing.type: Easing.InQuad
                    duration: 2000
                }
                ScriptAction {
                    script: {
                        container.y = (parent.height / 4) + (Math.random() * parent.height / 2)
                        container.x = (parent.width / 4) + (Math.random() * parent.width / 2)
                    }
                }
            }
            //! [letterspacing]

            SequentialAnimation on opacity {
                loops: Animation.Infinite
                NumberAnimation {
                    from: 1
                    to: 0
                    duration: 1600
                }
                PauseAnimation {
                    duration: 400
                }
            }
        }
    }


}
//<-- slide


