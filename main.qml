/*
https://www.cnblogs.com/suRimn/p/9831269.html
https://github.com/sueRimn/QMLExamples
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Particles 2.0
import Qt.labs.folderlistmodel
import "./pages"
import "./components"


ApplicationWindow {
    id: root
    width: 800
    height: 480
    visible: true

    property string colordef_ccPink: "#ffffa0a0"
    property string colordef_ccRed: "#ffd23e42"
    property string colordef_ccGreen: "#ff9cc647"
    property string colordef_ccOrange: "#fff39200"
    property string colordef_ccLightGray: "#ff646363"
    property string colordef_ccDarkGray: "#ff262626"

    property int m_currIndex: 0
    property string systemFont: "URW Gothic L"

    property int anchorsMenu: 0
    property color colorLineMenu: "orange"
    property var textArray : ["Principal","Connection", "System Setup", "Backup", "Device Diagnostic", "Device Info"]

    property real numTotalButton: 5
    property real numContenButton: 4
    property real hTotalButton: 480
    property string currentPage: "" // Nue


    property int numberPage: 0



    Item {
        id: view

        anchors.centerIn: parent
        // this will provide automatic adaption to screen size and orientation
        width: ( Math.round(rotation) == 90 || Math.round(rotation) == -90 ) ? parent.height : parent.width
        height: ( Math.round(rotation) == 90 || Math.round(rotation) == -90 ) ? parent.width : parent.height
        //color : "#EFEFEF"//"#3E4253"
        rotation: 0

        ListModel {
            id: itemModel
            ListElement {
                title: "Setup"
                page: "pages/Page_1.qml"
                source: "https://unpkg.com/ionicons@5.5.2/dist/svg/home-outline.svg"
                color: "#ffa117"//"#f44336"
            }
            ListElement {
                title: "Diagnostic"
                page: "pages/Page_2.qml"
                source: "https://unpkg.com/ionicons@5.5.2/dist/svg/person-outline.svg"
                color: "#ffa117"
            }
            ListElement {
                title: "Connection"
                page: "pages/Page_3.qml"
                source: "https://unpkg.com/ionicons@5.5.2/dist/svg/camera-outline.svg"
                color: "#ffa117"//"#0fc70f"
            }
            ListElement {
                title: "Info"
                page: "pages/Page_4.qml"
                source: "https://unpkg.com/ionicons@5.5.2/dist/svg/settings-outline.svg"
                color: "#ffa117"//"#2196f3"
            }
        }

        Rectangle {
            id: menuHover

            property int smallSize: 70
            property int largeSize: 3*smallSize
            property bool isExpanded: false
            property int menuWidth: isExpanded ? largeSize : smallSize

            width: menuWidth
            height: hTotalButton - radius
            radius: 10
            color: "white"
            x: radius / 2
            y: radius / 2

            Behavior on width { NumberAnimation { duration: 300 } }

            Column {
                id: column
                spacing: 0
                anchors.horizontalCenter:  parent.horizontalCenter
                width: menuHover.width - 2 * menuHover.radius
                height: hTotalButton - 2 * menuHover.radius
                y: menuHover.radius/2
                x: menuHover.radius/2
                z: 100

                Item {
                    anchors.horizontalCenter:  parent.horizontalCenter
                    width: column.width
                    height: column.height / (itemModel.count + 1)
                    Item {
                        width: 30//parent.width
                        height: parent.height
                        x:10/2
                        y: parent.height / 4

                        Item {
                            width: Math.min(parent.width, menuHover.smallSize - menuHover.radius)
                            height: 2
                            x: menuHover.isExpanded ? menuLinea2.x : 0
                            y: menuHover.isExpanded ? menuLinea2.y : 0
                            Rectangle {
                                id: rect
                                width: parent.width
                                height: parent.height
                                color: "black"
                                visible: true
                            }

                            transform: Rotation {
                                angle: menuHover.isExpanded ? 135 : 0
                                origin.x: rect.width / 2
                                origin.y: rect.height / 2
                            }
                            Behavior on transform {  NumberAnimation { duration: 500 } }
                            Behavior on y { NumberAnimation { duration: 500 } }
                            Behavior on x { NumberAnimation { duration: 500 } }
                        }

                        Item {
                            id: menuLinea2
                            width: Math.min(parent.width, menuHover.smallSize - menuHover.radius)
                            height: 2
                            y:  parent.height / 7
                            Rectangle {
                                id: rect2
                                width: parent.width
                                height: parent.height
                                color: "black"
                                visible: true
                            }

                            transform: Rotation {
                                angle: menuHover.isExpanded ? 135 : 0
                                origin.x: rect2.width / 2
                                origin.y: rect2.height / 2
                            }
                            Behavior on transform {  NumberAnimation { duration: 500 } }
                            Behavior on y { NumberAnimation { duration: 500 } }
                            Behavior on x { NumberAnimation { duration: 500 } }
                        }

                        Item {
                            width: Math.min(parent.width, menuHover.smallSize - menuHover.radius)
                            height: 2
                            x: menuHover.isExpanded ? menuLinea2.x : 0
                            y: menuHover.isExpanded ? menuLinea2.y : 2 * (parent.height / 7)
                            Rectangle {
                                id: rect3
                                width: parent.width
                                height: parent.height
                                color: "black"
                                visible: true
                            }
                            transform: Rotation {
                                angle: menuHover.isExpanded ? 45 : 0
                                origin.x: rect3.width / 2
                                origin.y: rect3.height / 2
                            }
                            Behavior on transform {  NumberAnimation { duration: 500 } }
                            Behavior on y { NumberAnimation { duration: 500 } }
                            Behavior on x { NumberAnimation { duration: 500 } }
                        }
                    }

                    Rectangle {
                        width: menuHover.width
                        height: 1.5
                        color: "#554D4D"
                        x: -column.x
                        y: parent.height-2 * (parent.height / 7)

                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            menuHover.isExpanded = !menuHover.isExpanded;
                            console.log(width, height)
                        }
                    }
                }

                Repeater {
                    model: itemModel

                    Item {
                        width: column.width
                        height: column.height / (itemModel.count + 1)
                        anchors.horizontalCenter: parent.horizontalCenter

                        Rectangle {
                            id: boxColorIcon
                            width: 2*parent.height / 3
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            x: xImg()
                            color: model.index === numberPage ? model.color : "transparent"
                            radius: 8
                            z: 1000

                            function xImg (){
                                var xsizeImg
                                if(model.index === numberPage  ){
                                    if( !menuHover.isExpanded){
                                        return 18
                                    }
                                    else{
                                        return 6
                                    }
                                }else {
                                    return 0
                                }
                            }
                            Behavior on x { NumberAnimation { duration: 300 } }
                            Image {
                                id: images
                                anchors.centerIn: parent
                                width:  parent.width /2
                                source: model.index === numberPage ? "qrc:/graphics/alarm-white.svg" : model.source
                                fillMode: Image.PreserveAspectFit
                                z: 1200
                            }
                        }
                        //sombra mediante un rectangle
                        Rectangle {
                            width: 2*parent.height / 3
                            height: width
                            //anchors.verticalCenter: parent.verticalCenter
                            x: 5+xImg()
                            y: 20
                            opacity: 0.2
                            color: model.index === numberPage ? model.color : "transparent"
                            radius: 8
                            z: 999

                            function xImg (){
                                var xsizeImg
                                if(model.index === numberPage  ){
                                    if( !menuHover.isExpanded){
                                        return 18
                                    }
                                    else{
                                        return 6
                                    }
                                }else {
                                    return 0
                                }
                            }
                            Behavior on x { NumberAnimation { duration: 300 } }
                        }

                        Item {
                            width: parent.width
                            height: parent.height
                            clip : true
                            visible: menuHover.isExpanded
                            Text {
                                text: model.title
                                font.family: systemFont
                                font.pixelSize: 16
                                color: model.index === numberPage ? model.color : "black"
                                anchors.verticalCenter: parent.verticalCenter
                                x: boxColorIcon.x+boxColorIcon.width+10
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (currentPage !== model.page) {
                                    var component = Qt.createComponent(model.page)

                                    if (component.status === Component.Ready) {
                                        stackView.push(component.createObject(stackView))
                                        currentPage = model.page
                                        numberPage = model.index
                                        console.log("Carga qml  ok:", currentPage)
                                        //console.log(numberPage, model.color)
                                    } else {
                                        console.log("Error loading :", component.errorString())
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        StackView {
            id: stackView
            x: menuHover.width + 2*menuHover.x  //anchors.right: root.right
            anchors.top: view.top
            height: view.height
            width: view.width - menuHover.width-menuHover.x
            z: -1

            Component.onCompleted: {
                var component = Qt.createComponent("pages/Page_1.qml")
                if (component.status === Component.Ready) {
                    stackView.push(component.createObject(stackView))
                } else {
                    console.log("Error loading :", component.errorString())
                }
            }
        }
    }
}


/*

ApplicationWindow {
    id: root
    width: 800
    height: 480
    visible: true

    property string colordef_ccPink: "#ffffa0a0"
    property string colordef_ccRed: "#ffd23e42"
    property string colordef_ccGreen: "#ff9cc647"
    property string colordef_ccOrange: "#fff39200"
    property string colordef_ccLightGray: "#ff646363"
    property string colordef_ccDarkGray: "#ff262626"

    property int m_currIndex: 0
    property string systemFont: "URW Gothic L"

    property int anchorsMenu: 0
    property color colorLineMenu: "orange"
    property var textArray : ["Principal","Connection", "System Setup", "Backup", "Device Diagnostic", "Device Info"]

    property real numTotalButton: 5
    property real numContenButton: 4
    property real hTotalButton: 480
    property string currentPage: "" // Nueva propiedad para almacenar la ruta de la página actual

    ListModel {
        id: itemModel
        ListElement {
            title: "Principal"
            page: "pages/Page_1.qml"
        }
        ListElement {
            title: "BackLight"
            page: "pages/Page_2.qml"
        }
        ListElement {
            title: "Buzzer"
            page: "pages/Page_3.qml"
        }
        ListElement {
            title: "Front Led"
            page: "pages/Page_4.qml"
        }
        ListElement {
            title: "UNit Info"
            page: "pages/Page_5.qml"
        }
        ListElement {
            title: "Power"
            page: "pages/Page_6.qml"
        }
        ListElement {
            title: "Operaciones"
            page: "pages/Page_7.qml"

        }
    }

    Column {
        id: column
        spacing: 0
        width: 100
        height: hTotalButton
        z: 100

        Repeater {
            model: itemModel

            Rectangle {
                width: 100
                height: parent.height / itemModel.count
                color : colordef_ccOrange

                Text {
                    text: model.title
                    font.pointSize: 12
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (currentPage !== model.page) {
                            var component = Qt.createComponent(model.page)
                            if (component.status === Component.Ready) {
                                stackView.push(component.createObject(stackView))
                                currentPage = model.page // Actualiza la propiedad currentPage
                                console.log("Carga qml con éxito:", currentPage)
                            } else {
                                console.log("Error loading :", component.errorString())
                            }
                        }
                    }
                }
            }
        }
    }

    StackView {
        id: stackView
        anchors.left: column.right
        anchors.top: column.top
        height: column.height
        width: parent.width - column.width

        Component.onCompleted: {
            var component = Qt.createComponent("pages/Page_1.qml")
            if (component.status === Component.Ready) {
                stackView.push(component.createObject(stackView))
            } else {
                console.log("Error loading :", component.errorString())
            }
        }
    }
}


    Rectangle {
        id: menuTodo
        width: root.width
        height: root.height
        anchors.fill: parent
        anchors.margins: 5

        Rectangle{
            id: menuSection
            width:  menuTodo.width/6
            height: menuTodo.height
            anchors{
                left: menuTodo.left
                top : menuTodo.top
            }
            color : colordef_ccOrange
        }
        //Contenido de las paginas
        Item{
            id: menuPages
            width: menuTodo.width-menuSection.width
            height: menuTodo.height
            anchors{
                right: menuTodo.right
                top : menuTodo.top
            }
            //Page_1 {}
            Page_2 {}

        }
    }*/
//xd
