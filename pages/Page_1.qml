import QtQuick
import "./../components"
Rectangle {
    //width: stackView.width //parent.width
    //height: stackView.height
    anchors.fill: stackView
    id: bottomPanel


    Text {
        anchors {
            top: bottomPanel.top
            //right: bottomPanel.right
            topMargin: 40
            horizontalCenter: bottomPanel.horizontalCenter
        }

        font {
            pixelSize: bottomPanel.height / 14
            family: systemFont
        }

        color: colordef_ccLightGray

        text: backEnd.currentConfig.name
    }

    CCLogo {
        id: ccLogo

        anchors {
            right: parent.right
            bottom: parent.bottom
        }

        // Leave 60% of the width for the logotype and 40% for the IP address
        width: bottomPanel.width * 0.50
    }

    CCIPAddressText {
        anchors {
            //right: ccLogo.left
            leftMargin: 10
            bottomMargin:  30
            bottom: parent.bottom
            //horizontalCenter: parent.horizontalCenter
            left: parent.left
            //rightMargin: versionHandler.hasTouch ? navigationBar.width : 0
            //top: parent.top
        }
    }


}
