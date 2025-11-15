/******************************************************************************
 * ListData listmodel
******************************************************************************/

import QtQuick 2.0

ListModel {

    ListElement {
        icon: ""
        text: "BACKLIGHT"
    }

    ListElement {
        icon: ""
        text: "BUZZER"
    }


    ListElement {
        icon: ""
        text: "FRONT LED"
    }

    ListElement {
        icon: ""
        text: "UNIT INFO"
    }

    ListElement {
        icon: ""
        text: "POWER"
    }

    readonly property var actions: [

        ( function() {
            mainMenuPage.selectBacklight()
        } ),
        ( function() {
            mainMenuPage.selectBuzzer()
        } ),
        ( function() {
            mainMenuPage.selectFrontLed()
        } ),
        ( function() {
            mainMenuPage.selectVersions()
        } ),
        ( function() {
            mainMenuPage.selectPower()
        } ),
        ( function() {
            mainMenuPage.goBackToMain()
        } )
    ]

}


