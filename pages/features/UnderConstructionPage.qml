import QtQuick
Rectangle {
    radius: radiusBox
    //anchors.fill: parent
    color: "#f4f4f4"

    Rectangle{
        width: 100
        height: 50
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "red"
        radius: 10
        MouseArea{
            anchors.fill: parent
            onClicked: {
                Qt.quit();
            }
            Text {
                anchors.centerIn: parent
                text: qsTr("EXIT")
                color: "white"
            }
        }
    }

    Image {
        width:  parent.width
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/graphics/under-construction.png"
    }
}

