import QtQuick
import QtQuick.Controls

import "../../components"

Rectangle {
    width: parent ? parent.width : 0
    height: parent ? parent.height : 0
    radius: radiusBox
    color: "#ececec"

    ListModel {
        id: pageSubModel
        ListElement {
            fileName: "../features/UnderConstructionPage.qml"
            displayName: "CCAux"
        }
        ListElement {
            fileName: "../features/VersionsPage.qml"
            displayName: "Version"
        }
    }
    Item {
        id: spacingTitle
        height: parent.height-containerSubContent.height
        width: parent.width
        Text {
            anchors {
                top: parent.top
                topMargin: 40
                horizontalCenter: parent.horizontalCenter
            }

            font {
                pixelSize: 33
                family: systemFont
            }

            color: colordef_ccLightGray

            text: "Device Info"
        }
    }

    Item {
        id: containerSubContent
        height: 5*parent.height/6
        anchors {
            left: parent.left
            right: buttonContainer.left
            top: spacingTitle.bottom
        }

        Loader {
            id: pageLoader
            width: 7 * parent.width / 8
            height: 7 * parent.height / 8
            anchors.centerIn: parent

            source: Qt.resolvedUrl(pageSubModel.get(0).fileName)
            onLoaded: {
                if (pageLoader.item !== null) {
                    pageLoader.item.width = width
                    pageLoader.item.height = height
                }
            }
        }
    }

    Item {
        id: buttonContainer
        width: 140
        height: parent.height
        anchors.right: parent.right

        Column {
            spacing: 20
            anchors.centerIn: parent
            width: parent.width

            Repeater {
                model: pageSubModel
                Rectangle {
                    width: parent.width - 5
                    height: 50
                    color: pageLoader.source === Qt.resolvedUrl(
                               model.fileName) ? colordef_ccOrange : "grey"
                    radius: 10
                    anchors.left: parent.left

                    Text {
                        anchors.centerIn: parent
                        text: model.displayName
                        font.family: "URW Gothic L"
                        font.pixelSize: 16
                        color: pageLoader.source === Qt.resolvedUrl(
                                   model.fileName) ? "white": "#efefef"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (pageLoader.source !== Qt.resolvedUrl(
                                        model.fileName)) {
                                pageLoader.source = Qt.resolvedUrl(
                                            model.fileName)
                            }
                        }
                    }
                }
            }
        }
    }
}


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


/* VersionsPage
 {
     id: versionsPage
     anchors {
         top: parent.top
         left: parent.left
         bottom: parent.bottom
         bottomMargin: 4
     }

     width: parent.width  //navigationBar.isShowing ? parent.width - navigationBar.width : parent.width

     visible: true//false

     opacity: visible ? 1.0 : 0.0
     Behavior on opacity { NumberAnimation { easing.type: Easing.InOutQuad; duration: 600 } }
 }*/
