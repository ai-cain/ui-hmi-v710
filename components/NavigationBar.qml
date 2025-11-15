/******************************************************************************
 * NavigationBar component
******************************************************************************/

import QtQuick 2.0

Rectangle {
    color: "white"
    property bool hideEnter: false

    Column {
        anchors.fill: parent

        ButtonTempl {
            id: buttonEnter
            imgFileName: "qrc:/graphics/Menu/menu-enter.png"
            altFileName: ""
            useAltImage: hideEnter
            scale: 0.4
            highlighted: controller.enterButtonPressed
            onButtonClick: { controller.enterPressed(); controller.enterReleased() }
            //opacity: hideEnter ? 0.0 : 1.0
        }
        ButtonTempl {
            id: buttonUp
            imgFileName: "qrc:/graphics/Menu/menu-up.png"
            altFileName: "qrc:/graphics/Menu/menu-plus.png"
            useAltImage: hideEnter
            scale: 0.6
            highlighted: controller.upButtonPressed
            onButtonClick: { controller.upPressed(); controller.upReleased() }
        }
        ButtonTempl {
            id: buttonDown
            imgFileName: "qrc:/graphics/Menu/menu-down.png"
            altFileName: "qrc:/graphics/Menu/menu-minus.png"
            scale: 0.6
            useAltImage: hideEnter
            highlighted: controller.downButtonPressed
            onButtonClick: { controller.downPressed(); controller.downReleased() }
        }
        ButtonTempl {
            id: buttonBack
            imgFileName: "qrc:/graphics/Menu/menu-return.png"
            scale: 0.7
            highlighted: controller.backButtonPressed
            onButtonClick: { controller.backPressed(); controller.backReleased() }
        }

    }


}
