import QtQuick
import QtQuick.Controls

import "./../pages"
Rectangle {
    //width: stackView.width //parent.width
    //height: stackView.height
    anchors.fill: stackView


    /*BacklightPage
    {
        id: backlightPage

        anchors {
            top: parent.top
            left: parent.left
            //bottom: parent.bottom
            bottomMargin: 4
        }
        width: parent.width/2//navigationBar.isShowing ? parent.width - navigationBar.width : parent.width
        height: parent.height/2
        visible: true //estaba en false
        opacity: visible ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { easing.type: Easing.InOutQuad; duration: 600 } }
    }

    FrontLedPage
    {
        id: frontLedPage
        anchors {
            top: parent.top
            right:   parent.right
            //bottom: parent.bottom
            bottomMargin: 4
        }

        width: parent.width/2//navigationBar.isShowing ? parent.width - navigationBar.width : parent.width
        height: parent.height/2
        visible: true//false

        opacity: visible ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { easing.type: Easing.InOutQuad; duration: 600 } }
    }*/

    StackView {
          id: stackView
          anchors.fill: parent

          // Página inicial con un rectángulo vacío
          Rectangle {
              width: 360
              height: 360
              color: "white"
          }
      }

      // Contenedor de botones
      Item {
          id: buttonContainer
          width: 100
          height: parent.height
          anchors.right: parent.right
          anchors.rightMargin: 10
          anchors.topMargin: 10
          anchors.bottomMargin: 10

          Column {
              spacing: 20
              anchors.centerIn: parent

              Repeater {
                  model: 2  // Número de páginas (rectángulos)
                  Rectangle {
                      width: 130
                      height: 50
                      color: "#DDDDDD"
                      radius: 10

                      Text {
                          anchors.centerIn: parent
                          text: "Page " + (index + 1)
                      }

                      MouseArea {
                          anchors.fill: parent
                          onClicked: {
                              var color;
                              if (index === 0) {
                                  color = "lightblue";
                              } else if (index === 1) {
                                  color = "lightgreen";
                              }

                              var newPage = Qt.createQmlObject('import QtQuick 2.15; Rectangle { width: 360; height: 360; color: "' + color + '"; Behavior on y { NumberAnimation { duration: 1000; } } }', stackView);
                              newPage.y = -newPage.height;  // Empujar el nuevo rectángulo hacia arriba fuera de la vista
                              stackView.push(newPage);
                              newPage.y = 0;  // Moverlo a la posición visible
                          }
                      }
                  }
              }
          }
      }



}
