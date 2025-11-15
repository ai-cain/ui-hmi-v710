import QtQuick 2.0

Item {
    id: base

    property string text
    property var elements: ["1", "2"]
    property int currentIndex: 0
    property string currentString: ""

    signal clicked()

    function nextElement() {
        if (base.currentIndex == base.elements.length - 1)
        {
            base.currentIndex = 0
        }
        else
        {
            base.currentIndex++
        }

        currentString = elements[base.currentIndex];
    }

    onCurrentStringChanged: {
        base.currentIndex = elements.indexOf(base.currentString);
    }

//    anchors
//    {
//        left: parent.left
//        right: width > 0 ? undefined : parent.right
//    }

    Rectangle
    {
        color: base.enabled ? colordef_ccOrange : colordef_ccLightGray
        radius: 5

        anchors.fill: parent

        border
        {
            color: base.enabled ? colordef_ccDarkGray : colordef_ccLightGray
            width: 1
        }

        Text {
            id: labelText
            //text: base.elements[base.currentIndex]
            text: base.currentIndex + ": " + base.currentString;
            color: "White"

            anchors
            {
                fill: parent
                rightMargin: 8
                leftMargin: 8
            }

            font
            {
                bold: true
                pixelSize: parent.height / 3
            }

            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                base.nextElement();
                base.clicked();
            }
        }
    }
}
