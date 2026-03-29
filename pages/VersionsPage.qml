/******************************************************************************
 * VersionsPage a.k.a UNIT INFO
******************************************************************************/

import QtQuick 2.6
//import QtGraphicalEffects 1.0
import CrossControl 1.0
import MyQmlModule 1.0
import "../components"

Rectangle {
    id: versionsID
    property var versionRef: (typeof versionHandler !== "undefined" && versionHandler !== null) ? versionHandler : null
    property var backendRef: (typeof backEnd !== "undefined" && backEnd !== null) ? backEnd : null

    color: "white"

    function goBackToMain() {
        // View default page
        if (backendRef)
            backendRef.setState(MyAppState.MAIN)
        versionsPage.visible = false
        navigationBar.hideEnter = false
    }

    PageHeaderControl {
        id: pageHeader
        headerString: "UNIT INFO"
    }

    Rectangle {
        id: versionView

        anchors {
            left: parent.left
            right: parent.right
            top: pageHeader.bottom
            topMargin: 8
            bottom: parent.bottom
        }

        color: "white"

        ListView {
            id: listView

            anchors.fill: parent

            property int fontSize: listView.width / 30 < 24 ? listView.width / 30 : 24

            delegate: Row {
                height: Math.max(nameText.implicitHeight, versionText.implicitHeight, statusText.implicitHeight);

                spacing: 4

                Text {
                    id: nameText

                    width: listView.width / 2.5
                    verticalAlignment: Text.AlignVCenter

                    // Enable word wrapping and shrink font size to fit the column width
                    fontSizeMode: Text.HorizontalFit
                    minimumPixelSize: 8

                    text: modelData.name
                    color: "black"
                    font {
                        pixelSize: listView.fontSize
                        bold: true
                    }
                }

                Text {
                    id: versionText

                    width: listView.width / 6
                    verticalAlignment: Text.AlignVCenter

                    // Enable word wrapping and shrink font size to fit the column width
                    fontSizeMode: Text.HorizontalFit
                    minimumPixelSize: 8

                    text: modelData.version
                    color: "black"
                    font {
                        pixelSize: listView.fontSize
                    }
                }

                Text {
                    id: statusText

                    width: listView.width / 5
                    verticalAlignment: Text.AlignVCenter

                    // Enable word wrapping and shrink font size to fit the column width
                    fontSizeMode: Text.HorizontalFit
                    minimumPixelSize: 8

                    text: modelData.status
                    color: "black"
                    font {
                        pixelSize: listView.fontSize
                    }
                }
            }

            model: versionRef ? versionRef.versionItems : []
        }
    }
}
