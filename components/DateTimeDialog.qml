import QtQuick 2.15
import QtQuick.Controls 2.15

Dialog {
    id: dateTimeDialog
    title: "Set Date and Time"
    width: 300
    height: 200
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel
}
