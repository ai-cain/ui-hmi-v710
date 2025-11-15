/******************************************************************************
 * ListItem menuitem
******************************************************************************/

import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: listItem

    property var view: ListView.view
    property bool isCurrent: ListView.isCurrentItem

    width: view.width
    height: (view.lwHeight - view.margin * view.model.count) / view.nItemsVisible

    Image {
        id: itemIcon
        height: parent.height * 0.8
        width: height
        anchors.left: parent.left
        anchors.leftMargin: 14
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        source: model.icon
        scale: 0.8
        visible: model.icon === "" ? false: true

        ColorOverlay {
            anchors.fill: itemIcon
            source: itemIcon
            color: isCurrent ? "orange" : "gray"
            visible: model.overlayNotVisible ? false : true
        }
    }

    Text {
        id: itemText
        color:  parent.isCurrent ? "orange" : "grey"
        font.pixelSize: parent.height * 0.3
        font.family: systemFont
        anchors.left: model.icon === "" ? parent.left: itemIcon.right
        anchors.leftMargin: 14
        anchors.verticalCenter: itemIcon.verticalCenter
        text: model.text
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            view.currentIndex = index
            view.model.actions[index]()
        }
    }
}
