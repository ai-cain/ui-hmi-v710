import QtQuick 2.15
import QtQuick.Controls 2.15
import "./../keyboard"
Dialog {
    id: dateTimeDialog
    title: "Set Date and Time"
    width: 300
    height: 200



        /*Button {
            text: "Set Date and Time"
            onClicked: {
                clock.setTime(timeInput.text)
                clock.setDate(dateInput.text)
                dateTimeDialog.close()
            }
        }

        Button {
            text: "Cancel"
            onClicked: dateTimeDialog.close

}
