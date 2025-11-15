/******************************************************************************
 * MainMenuPage
******************************************************************************/

import QtQuick 2.6

import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3

import MyQmlModule 1.0

Item {
    id: mainMenuID

    property int currentIndex: listView.currentIndex
    property bool showList: true

    function runCurrentIndexFunction() {
        listData.actions[currentIndex]()
    }

    function incrementIndex()
    {
        listView.incrementCurrentIndex()
    }

    function decrementIndex()
    {
        listView.decrementCurrentIndex()
    }

    function showPage(pageToShow)
    {
        pageToShow.visible = true;

        controller.collapseMenu();
    }

    function selectBacklight() {
        backEnd.setState(MyAppState.BACKLIGHT)
        console.log("Backlight page selected")
        showPage(backlightPage);
    }

    function selectBuzzer() {
        backEnd.setState(MyAppState.BUZZER)
        console.log("Buzzer page selected")
        showPage(buzzerPage);
    }

    function selectFrontLed() {
        backEnd.setState(MyAppState.FRONTLED)
        console.log("Front LED page selected")
        showPage(frontLedPage);
    }

    function selectVersions() {
        backEnd.setState(MyAppState.VERSION)
        console.log("Unit info page selected")
        showPage(versionsPage);
    }

    function selectPower() {
        backEnd.setState(MyAppState.POWER)
        console.log("Power page selected")
        showPage(powerPage);
    }

    function goBackToMain() {
        backEnd.setState(0)
        console.log("Go back to default page!")
    }

    Rectangle {
        id:mainMenuView

        width: parent.width
        height: parent.height
        color: "white"
        layer.enabled: true

        layer.effect: DropShadow {
            transparentBorder: false
            horizontalOffset: -3
            verticalOffset: 3
            color: "grey"
        }

        ListView {
            id: listView
            visible: mainMenuPage.showList
            opacity: visible ? 1.0 : 0.0
            Behavior on opacity { NumberAnimation { easing.type: Easing.InOutQuad; duration: 600 } }

            readonly property int margin: parent.height / 30            // ORIG = 20
            readonly property int lwWidth: parent.width - margin        // * 2
            readonly property int lwHeight: parent.height - margin      // * 2
            readonly property int nItemsVisible: 4

            width: lwWidth
            height: lwHeight
            rotation: 0

            anchors.centerIn: parent
            spacing: margin

            focus: true
            keyNavigationWraps: true
            Keys.forwardTo: controller

            model: ListData {id: listData}
            delegate: ListItem {}
            boundsBehavior: Flickable.StopAtBounds

            Image {
                id: listSelector
                height: listView.currentItem.height
                width: 4
                source:  "qrc:/graphics/Menu/menu-bar-active.png"

                y: listView.currentItem.y - listView.contentY
                Behavior on y
                {
                    NumberAnimation {
                        target: listSelector
                        property: "y"
                        duration: 600
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }
}
