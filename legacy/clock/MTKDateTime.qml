import QtQuick 2.15
import QtQuick.Controls 2.15

import "./../../components"

Rectangle {
    width: parent.width
    height: parent.height
    color: "#f4f4f4"

    PageHeaderControl {
        id: pageHeader
        headerString: "DATE & TIME"
    }

    // Instancia del diálogo
    DateTimeDialog {
        id: dateTimeDialog
        anchors.centerIn: parent
    }

    Text {
        id: timeText
        text: clock.currentTime
        font.pixelSize: 40
        anchors.centerIn: parent
    }

    Text {
        id: dateText
        text: clock.currentDate
        font.pixelSize: 40
        anchors.top: timeText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button {
        text: "Edit Date and Time"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: //dateTimeDialog.open()
        { console.log("llamando editar fecha y hora")
    }

    }

    Connections {
        target: clock
        function onTimeChanged() {
            timeText.text = clock.currentTime
        }
    }

    Connections {
        target: clock
        function onDateChanged() {
            dateText.text = clock.currentDate
        }
    }
}


/*
Rectangle {
    width: parent.width;
    height: parent.height;
    color: "#f4f4f4"
    radius: radiusBox

    Text {
          id: timeText
          text: clock.currentTime
          font.pixelSize: 40
          anchors.centerIn: parent
      }
    Text {
          id: dateText
          text: clock.currentDate
          font.pixelSize: 40
          anchors.top: timeText.bottom
          anchors.horizontalCenter: parent.horizontalCenter
      }


      Connections {
          target: timeText
          onTimeChanged: {
              timeText.text = clock.currentTime
          }
      }
      Connections {
          target: dateText
          onTimeChanged: {
              timeText.text = clock.currentDate
          }
      }

}
  */


