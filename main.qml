

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
    property var textArray: ["Principal", "Connection", "System Setup", "Backup", "Device Diagnostic", "Device Info"]

    property real numTotalButton: 5
    property real numContenButton: 4
    property real hTotalButton: 480
    property string currentPage: itemModel.count > 0 ? itemModel.get(0).page : ""
    property int numberPage: 0

    // propiedades importantes utilizadas
    property int radiusBox: 10
    property int smallSizeMenu: 70

    Rectangle {
        id: view

        anchors.centerIn: parent
        width: (Math.round(rotation) == 90 || Math.round(
                    rotation) == -90) ? parent.height : parent.width
        height: (Math.round(rotation) == 90 || Math.round(
                     rotation) == -90) ? parent.width : parent.height
        rotation: 0
        color: "#d3d3d3"

        ListModel {
            id: itemModel
            ListElement {
                title: "Setup"
                page: "pages/Page_2.qml"
                source: "qrc:/graphics/camera-outline.svg"//"https://unpkg.com/ionicons@5.5.2/dist/svg/home-outline.svg"
                color: "#ffa117" //"#f44336"
            }
            ListElement {
                title: "Diagnostic"
                page: "pages/Page_3.qml"
                source: "qrc:/graphics/camera-outline.svg"//"https://unpkg.com/ionicons@5.5.2/dist/svg/person-outline.svg"
                color: "#ffa117"
            }
            ListElement {
                title: "Connection"
                page: "pages/Page_4.qml"
                source: "qrc:/graphics/camera-outline.svg"
                color: "#ffa117" //"#0fc70f"
            }
            ListElement {
                title: "Info"
                page: "pages/Page_5.qml"
                source: "qrc:/graphics/camera-outline.svg"//"https://unpkg.com/ionicons@5.5.2/dist/svg/settings-outline.svg"
                color: "#ffa117" //"#2196f3"
            }
        }
        // area total del item para separar las paginas
        Item {
            id: stackItem
            anchors {
                left: menuHover.right
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                rightMargin: 5
                leftMargin: 0
                topMargin: 5
                bottomMargin: 5
            }

            z: 1

            StackView {
                id: stackView
                anchors.fill: parent
                z: parent.z + 1
                Component.onCompleted: {
                    if (itemModel.count > 0) {
                        currentPage = itemModel.get(0).page
                        numberPage = 0
                        stackView.replace(Qt.resolvedUrl(currentPage))
                    } else {
                        stackView.replace(Qt.resolvedUrl("pages/Page_1.qml"))
                    }
                }
            }
        }
        // area total del menu
        Rectangle {
            id: menuHover

            property int smallSize: root.smallSizeMenu
            property int largeSize: 3 * smallSize
            property bool isExpanded: false
            property int menuWidth: isExpanded ? largeSize : smallSize

            width: menuWidth
            height: parent.height
            color: view.color
            z: stackView.z + 10 // soloe s para poner el orden de la capa

            Behavior on width {
                NumberAnimation {
                    duration: 300
                }
            }
            // zona donde estara los botones y el open and close
            Rectangle {
                //anclajes de posicionamiento
                anchors{
                    fill: parent
                    rightMargin: radius / 2
                    leftMargin: radius / 2
                    topMargin: radius / 2
                    bottomMargin: radius / 2
                }

                radius: radiusBox
                color: "white"//"#efefef" //color de todo la barra del menu

                z: stackView.z + 20 // soloe s para poner el orden de la capa

                //columna para el menu
                Column {
                    id: column

                    spacing: 0
                    width: parent.width
                    height: parent.height

                    z: stackView.z + 30
                    //primer item para que desplegue el menu o se cierre
                    Item {
                        //anchors.horizontalCenter: parent.horizontalCenter
                        width: column.width
                        height: column.height / (itemModel.count + 1)
                        //area donde estara contenido el open and close
                        Item{
                            width: Math.min(parent.width / 2, menuHover.smallSize/2)
                            height: parent.height
                            anchors {
                                left: parent.left
                                leftMargin: menuHover.smallSize / 5 // Verifica que menuHover.smallSize tenga un valor adecuado
                                top: parent.top
                                topMargin: height / 5 // Asegúrate de que el valor de height sea válido en este contexto
                            }

                            //linea 1
                            Item {
                                width: Math.min(
                                           parent.width,
                                           menuHover.smallSize - menuHover.radius)
                                height: radiusBox/5
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
                                Behavior on transform {
                                    NumberAnimation {
                                        duration: 500
                                    }
                                }
                                Behavior on y {
                                    NumberAnimation {
                                        duration: 500
                                    }
                                }
                                Behavior on x {
                                    NumberAnimation {
                                        duration: 500
                                    }
                                }
                            }
                            //linea 2 o linea central
                            Item {
                                id: menuLinea2
                                width: Math.min(
                                           parent.width,
                                           menuHover.smallSize - menuHover.radius)
                                height: radiusBox/5
                                y: parent.height / 7
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
                                Behavior on transform {
                                    NumberAnimation {
                                        duration: 500
                                    }
                                }
                                Behavior on y {
                                    NumberAnimation {
                                        duration: 500
                                    }
                                }
                                Behavior on x {
                                    NumberAnimation {
                                        duration: 500
                                    }
                                }
                            }
                            //linea 3
                            Item {
                                width: Math.min(
                                           parent.width,
                                           menuHover.smallSize - menuHover.radius)
                                height: radiusBox/5
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
                                Behavior on transform {
                                    NumberAnimation {
                                        duration: 500
                                    }
                                }
                                Behavior on y {
                                    NumberAnimation {
                                        duration: 500
                                    }
                                }
                                Behavior on x {
                                    NumberAnimation {
                                        duration: 500
                                    }
                                }
                            }
                        }

                        Rectangle { //linea para separar del open and close y los demas botones
                            width: parent.width
                            height: 1.5
                            color: "#554D4D"
                            y: 5 * (parent.height / 7)
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                menuHover.isExpanded = !menuHover.isExpanded
                            }
                        }
                    }
                    // los botones restantes con images y texto
                    Repeater {
                        model: itemModel

                        Item {
                            width: column.width
                            height: column.height / (itemModel.count + 1)
                            anchors.horizontalCenter: parent.horizontalCenter

                            Rectangle {
                                id: boxColorIcon
                                width: 2 * parent.height / 3
                                height: width
                                anchors.verticalCenter: parent.verticalCenter
                                x: xImg()
                                color: model.index === numberPage ? model.color : "transparent"
                                radius: radiusBox
                                z: stackView.z + 40

                                function xImg() {
                                    var xsizeImg
                                    if (model.index === numberPage) {
                                        if (!menuHover.isExpanded) {
                                            return 18
                                        } else {
                                            return 6
                                        }
                                    } else {
                                        return 0
                                    }
                                }
                                Behavior on x {
                                    NumberAnimation {
                                        duration: 300
                                    }
                                }
                                Image {
                                    id: images
                                    anchors.centerIn: parent
                                    width: parent.width / 2
                                    source: model.index === numberPage ? "qrc:/graphics/alarm-white.svg" : model.source
                                    fillMode: Image.PreserveAspectFit
                                    z: stackView.z + 50
                                }
                            }
                            //sombra mediante un rectangle
                            Rectangle {
                                width: 2 * parent.height / 3
                                height: width
                                //anchors.verticalCenter: parent.verticalCenter
                                x: xImg()
                                y: 20
                                opacity: 0.2
                                color: model.index === numberPage ? model.color : "transparent"
                                radius: radiusBox
                                z: 999

                                function xImg() {
                                    var xsizeImg
                                    if (model.index === numberPage) {
                                        if (!menuHover.isExpanded) {
                                            return 23
                                        } else {
                                            return 11
                                        }
                                    } else {
                                        return 5
                                    }
                                }
                                Behavior on x {
                                    NumberAnimation {
                                        duration: 300
                                    }
                                }
                            }

                            Item {
                                width: parent.width
                                height: parent.height
                                clip: true
                                visible: menuHover.isExpanded
                                Text {
                                    text: model.title
                                    font.family: systemFont
                                    font.pixelSize: 16
                                    color: model.index === numberPage ? model.color : "black"
                                    anchors.verticalCenter: parent.verticalCenter
                                    x: boxColorIcon.x + boxColorIcon.width + 10
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (currentPage !== model.page) {
                                        stackView.replace(Qt.resolvedUrl(model.page))
                                        currentPage = model.page
                                        numberPage = model.index
                                        console.log("Carga qml ok:", currentPage)
                                    }
                                }
                            }
                        }
                    }
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

