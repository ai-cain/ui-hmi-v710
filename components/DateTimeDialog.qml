import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog {
    id: dateTimeDialog
    property var clockRef: (typeof clock !== "undefined" && clock !== null) ? clock : null
    property string errorText: ""

    title: "Edit Date & Time"
    width: 420
    padding: 24
    modal: true
    focus: true
    standardButtons: Dialog.NoButton
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    function syncFromClock() {
        if (!dateTimeDialog.clockRef)
            return

        hourBox.value = dateTimeDialog.clockRef.currentHour
        minuteBox.value = dateTimeDialog.clockRef.currentMinute
        dayBox.value = dateTimeDialog.clockRef.currentDay
        monthBox.value = dateTimeDialog.clockRef.currentMonth
        yearBox.value = dateTimeDialog.clockRef.currentYear
        dateTimeDialog.errorText = ""
    }

    function applyChanges() {
        if (!dateTimeDialog.clockRef)
            return

        if (dateTimeDialog.clockRef.setDateTimeParts(yearBox.value, monthBox.value, dayBox.value, hourBox.value, minuteBox.value)) {
            dateTimeDialog.errorText = ""
            dateTimeDialog.close()
        } else {
            dateTimeDialog.errorText = "Invalid date."
        }
    }

    onOpened: syncFromClock()

    background: Rectangle {
        radius: 20
        color: "#fffdf8"
        border.width: 1
        border.color: "#dfd9cc"
    }

    contentItem: ColumnLayout {
        spacing: 18

        Label {
            text: "Adjust the app clock"
            color: "#4c4740"
            font.pixelSize: 15
        }

        ColumnLayout {
            spacing: 8

            Label {
                text: "Time"
                color: "#1f1f1f"
                font.pixelSize: 14
                font.bold: true
            }

            RowLayout {
                spacing: 10

                SpinBox {
                    id: hourBox
                    from: 0
                    to: 23
                    editable: true
                    Layout.fillWidth: true
                }

                Label {
                    text: ":"
                    color: "#4c4740"
                    font.pixelSize: 22
                    font.bold: true
                }

                SpinBox {
                    id: minuteBox
                    from: 0
                    to: 59
                    editable: true
                    Layout.fillWidth: true
                }
            }
        }

        ColumnLayout {
            spacing: 8

            Label {
                text: "Date"
                color: "#1f1f1f"
                font.pixelSize: 14
                font.bold: true
            }

            RowLayout {
                spacing: 10

                SpinBox {
                    id: dayBox
                    from: 1
                    to: 31
                    editable: true
                    Layout.fillWidth: true
                }

                SpinBox {
                    id: monthBox
                    from: 1
                    to: 12
                    editable: true
                    Layout.fillWidth: true
                }

                SpinBox {
                    id: yearBox
                    from: 2020
                    to: 2099
                    editable: true
                    Layout.fillWidth: true
                }
            }
        }

        Label {
            visible: dateTimeDialog.errorText.length > 0
            text: dateTimeDialog.errorText
            color: "#c94c2f"
            font.pixelSize: 13
        }
    }

    footer: RowLayout {
        spacing: 10
        layoutDirection: Qt.RightToLeft

        Button {
            text: "Apply"
            onClicked: dateTimeDialog.applyChanges()
        }

        Button {
            text: "Cancel"
            onClicked: dateTimeDialog.close()
        }
    }
}
