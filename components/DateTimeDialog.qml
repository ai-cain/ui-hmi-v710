import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "../legacy/keyboard"

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

    function twoDigits(value) {
        return value < 10 ? "0" + value : "" + value
    }

    function readNumber(field) {
        const value = parseInt(field.text, 10)
        return isNaN(value) ? NaN : value
    }

    function showKeyboardFor(field) {
        dateKeyboard.show(field, true)
    }

    function syncFromClock() {
        if (!dateTimeDialog.clockRef)
            return

        hourField.text = twoDigits(dateTimeDialog.clockRef.currentHour)
        minuteField.text = twoDigits(dateTimeDialog.clockRef.currentMinute)
        dayField.text = "" + dateTimeDialog.clockRef.currentDay
        monthField.text = "" + dateTimeDialog.clockRef.currentMonth
        yearField.text = "" + dateTimeDialog.clockRef.currentYear
        dateTimeDialog.errorText = ""
    }

    function applyChanges() {
        if (!dateTimeDialog.clockRef)
            return

        const year = readNumber(yearField)
        const month = readNumber(monthField)
        const day = readNumber(dayField)
        const hour = readNumber(hourField)
        const minute = readNumber(minuteField)

        if (isNaN(year) || isNaN(month) || isNaN(day) || isNaN(hour) || isNaN(minute)) {
            dateTimeDialog.errorText = "Complete all values."
            return
        }

        if (dateTimeDialog.clockRef.setDateTimeParts(year, month, day, hour, minute)) {
            dateTimeDialog.errorText = ""
            dateTimeDialog.close()
        } else {
            dateTimeDialog.errorText = "Invalid date."
        }
    }

    onOpened: {
        syncFromClock()
        dateKeyboard.hide()
    }

    onClosed: dateKeyboard.hide()

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

                TextField {
                    id: hourField
                    Layout.fillWidth: true
                    Layout.preferredWidth: 110
                    maximumLength: 2
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 22
                    inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
                    validator: IntValidator {
                        bottom: 0
                        top: 23
                    }

                    onActiveFocusChanged: {
                        if (activeFocus)
                            dateTimeDialog.showKeyboardFor(hourField)
                    }

                    background: Rectangle {
                        radius: 10
                        color: "#ffffff"
                        border.width: 1
                        border.color: hourField.activeFocus ? "#d88b43" : "#d7d1c6"
                    }
                }

                Label {
                    text: ":"
                    color: "#4c4740"
                    font.pixelSize: 22
                    font.bold: true
                }

                TextField {
                    id: minuteField
                    Layout.fillWidth: true
                    Layout.preferredWidth: 110
                    maximumLength: 2
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 22
                    inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
                    validator: IntValidator {
                        bottom: 0
                        top: 59
                    }

                    onActiveFocusChanged: {
                        if (activeFocus)
                            dateTimeDialog.showKeyboardFor(minuteField)
                    }

                    background: Rectangle {
                        radius: 10
                        color: "#ffffff"
                        border.width: 1
                        border.color: minuteField.activeFocus ? "#d88b43" : "#d7d1c6"
                    }
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

                TextField {
                    id: dayField
                    Layout.fillWidth: true
                    Layout.preferredWidth: 100
                    maximumLength: 2
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 22
                    inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
                    validator: IntValidator {
                        bottom: 1
                        top: 31
                    }

                    onActiveFocusChanged: {
                        if (activeFocus)
                            dateTimeDialog.showKeyboardFor(dayField)
                    }

                    background: Rectangle {
                        radius: 10
                        color: "#ffffff"
                        border.width: 1
                        border.color: dayField.activeFocus ? "#d88b43" : "#d7d1c6"
                    }
                }

                TextField {
                    id: monthField
                    Layout.fillWidth: true
                    Layout.preferredWidth: 100
                    maximumLength: 2
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 22
                    inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
                    validator: IntValidator {
                        bottom: 1
                        top: 12
                    }

                    onActiveFocusChanged: {
                        if (activeFocus)
                            dateTimeDialog.showKeyboardFor(monthField)
                    }

                    background: Rectangle {
                        radius: 10
                        color: "#ffffff"
                        border.width: 1
                        border.color: monthField.activeFocus ? "#d88b43" : "#d7d1c6"
                    }
                }

                TextField {
                    id: yearField
                    Layout.fillWidth: true
                    Layout.preferredWidth: 140
                    maximumLength: 4
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 22
                    inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
                    validator: IntValidator {
                        bottom: 2020
                        top: 2099
                    }

                    onActiveFocusChanged: {
                        if (activeFocus)
                            dateTimeDialog.showKeyboardFor(yearField)
                    }

                    background: Rectangle {
                        radius: 10
                        color: "#ffffff"
                        border.width: 1
                        border.color: yearField.activeFocus ? "#d88b43" : "#d7d1c6"
                    }
                }
            }
        }

        Label {
            visible: dateTimeDialog.errorText.length > 0
            text: dateTimeDialog.errorText
            color: "#c94c2f"
            font.pixelSize: 13
        }

        Item {
            id: keyboardHost
            Layout.fillWidth: true
            Layout.preferredHeight: dateKeyboard.isKeyboardActive ? 160 : 0
            clip: true
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

    KeyboardController {
        id: dateKeyboard
        rootObject: keyboardHost
        fillParent: true
        startInSymbols: true
    }
}
