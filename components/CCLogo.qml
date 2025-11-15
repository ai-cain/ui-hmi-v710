/******************************************************************************
 * CCLogo component
******************************************************************************/

import QtQuick 2.6

Item {
    id: base
    width: 400
    height: theLogo.height

    Image {
        id: theLogo

        width: parent.width > 400 ? 400 : parent.width

        source: "qrc:/graphics/logo.png"
        fillMode: Image.PreserveAspectFit
    }
}
