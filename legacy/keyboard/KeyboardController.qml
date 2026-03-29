//this archived is keyboardController.qml
import QtQuick

Item {
    id: keyboard_controller
    objectName: "keyboard_controller"

    // reference on the TextInput
    property Item target
    // Boolean on the state of the keyboard
    property bool isKeyboardActive: false

    property var rootObject
    property bool startInSymbols: false
    property bool fillParent: false

    function show(targetItem, symbolsMode) {
        if (targetItem !== undefined && targetItem !== null)
            keyboard_controller.target = targetItem

        if (symbolsMode !== undefined)
            keyboard_controller.startInSymbols = symbolsMode

        if (!keyboard_controller.target) {
            console.warn("KeyboardController.show() called without a target")
            return
        }

        if (typeof keyboard_controller.target.forceActiveFocus === "function")
            keyboard_controller.target.forceActiveFocus()

        if (keyboard === null) {
            keyboard = keyboardComponent.createObject(
                        keyboard_controller.rootObject
                        ? keyboard_controller.rootObject
                        : keyboard_controller.parent)
        }

        if (keyboard !== null) {
            keyboard.target = keyboard_controller.target
            keyboard.controller = keyboard_controller
            keyboard.symbols = keyboard_controller.startInSymbols
            keyboard.shift = false
            keyboard.fillParent = keyboard_controller.fillParent
            keyboard_controller.isKeyboardActive = true
        }
    }

    function hide() {
        if (keyboard !== null) {
            keyboard.destroy()
            keyboard = null
        }

        keyboard_controller.isKeyboardActive = false
    }

    // private
    property Item keyboard: null
    Component {
        id: keyboardComponent
        Keyboard {}
    }
}
