/******************************************************************************
 * Controller component
******************************************************************************/

import QtQuick 2.0
import MyQmlModule 1.0

Item {
    id: controllerRoot

    property bool backButtonPressed: false
    property bool upButtonPressed: false
    property bool downButtonPressed: false
    property bool enterButtonPressed: false

    function enterPressed()
    {
        enterButtonPressed = true;
    }

    function enterReleased()
    {
        enterButtonPressed = false;
    }

    function upPressed()
    {
        upButtonPressed = true;
    }

    function upReleased()
    {
        upButtonPressed = false;
    }

    function downPressed()
    {
        downButtonPressed = true;
    }

    function downReleased()
    {
        downButtonPressed = false;
    }

    function backPressed()
    {
        backButtonPressed = true;
    }

    function backReleased()
    {
        backButtonPressed = false;
    }

    function expandMenu()
    {
        navigationBar.isShowing = true;
        navigationBar.isNavigationMode = true;
        mainMenuPage.isShowing = true;
    }

    function collapseMenu()
    {
        navigationBar.isShowing = versionHandler.hasTouch;
        navigationBar.isNavigationMode = false;
        mainMenuPage.isShowing = false;
    }

    onEnterButtonPressedChanged:
    {
        if(enterButtonPressed)
        {
            switch(backEnd.state)
            {
            case MyAppState.MAIN:
                if(navigationBar.isNavigationMode)
                {
                    collapseMenu();

                    mainMenuPage.runCurrentIndexFunction();
                }
                else
                {
                    expandMenu()
                }
                break;

            case MyAppState.BACKLIGHT:

                break;

            case MyAppState.BUZZER:
                buzzerPage.hwButtonEnterPressed();
                break;

            case MyAppState.FRONTLED:

                break;

            case MyAppState.VERSION:

                break;

            case MyAppState.POWER:

                break;

            default:
                break
            }
        }
    }

    onUpButtonPressedChanged:
    {
        if(upButtonPressed)
        {
            switch(backEnd.state)
            {
            case MyAppState.MAIN:
                if(navigationBar.isNavigationMode)
                    mainMenuPage.decrementIndex();
                else
                {
                    expandMenu();
                }
                break;

            case MyAppState.BACKLIGHT:
                backlightPage.incrementBacklight();
                break;

            case MyAppState.BUZZER:
                buzzerPage.hwButtonUpPressed();
                break;

            case MyAppState.FRONTLED:
                frontLedPage.incrementIndex();
                break;

            case MyAppState.VERSION:
                //versionsPage.incrementIndex();
                break;

            case MyAppState.POWER:
                //powerPage.incrementIndex();
                break;

            default:
                break
            }
        }
    }

    onDownButtonPressedChanged:
    {
        if(downButtonPressed)
        {
            switch(backEnd.state)
            {
            case MyAppState.MAIN:
                if(navigationBar.isNavigationMode)
                    mainMenuPage.incrementIndex()
                else
                {
                    expandMenu()
                }
                break;

            case MyAppState.BACKLIGHT:
                backlightPage.decrementBacklight();
                break;

            case MyAppState.BUZZER:
                buzzerPage.hwButtonDownPressed();
                break;

            case MyAppState.FRONTLED:
                frontLedPage.decrementIndex();
                break;

            case MyAppState.VERSION:
                //versionsPage.decrementIndex();
                break;

            case MyAppState.POWER:
                //powerPage.decrementIndex();
                break;

            default:
                break
            }
        }
    }

    onBackButtonPressedChanged:
    {
        if(backButtonPressed) {
            switch(backEnd.state)
            {
            case MyAppState.MAIN:
                navigationBar.isShowing = versionHandler.hasTouch ? true : !navigationBar.isShowing
                navigationBar.isNavigationMode = !navigationBar.isNavigationMode;
                mainMenuPage.isShowing = !mainMenuPage.isShowing
                break;

            case MyAppState.BACKLIGHT:
                backlightPage.goBackToMain()
                break;

            case MyAppState.BUZZER:
                buzzerPage.goBackToMain()
                break;

            case MyAppState.FRONTLED:
                frontLedPage.goBackToMain()
                break;

            case MyAppState.VERSION:
                versionsPage.goBackToMain()
                break;

            case MyAppState.POWER:
                powerPage.goBackToMain()
                break;

            default:
                break

            }
       }
    }

    Connections {
        target: backEnd
        onHardwareButtonStateChanged: {
            if (buttonNo === backEnd.currentConfig.hwButtonNrOk)
            {
                enterButtonPressed = buttonPressed;
            }
            else if (buttonNo === backEnd.currentConfig.hwButtonNrUp)
            {
                upButtonPressed = buttonPressed;
            }
            else if (buttonNo === backEnd.currentConfig.hwButtonNrDown)
            {
                downButtonPressed = buttonPressed;
            }
            else if (buttonNo === backEnd.currentConfig.hwButtonNrCancel)
            {
                backButtonPressed = buttonPressed;
            }
        }
    }

    property int    m_myOffset_F:   16777194
    property int    m_myOffset_E:   16777196
    property int    m_myOffset_D:   16777198
    property int    m_myOffset_C:   16777200

    Keys.onPressed: {
        if (event.key === Qt.Key_C + m_myOffset_C)
        {
            if (event.isAutoRepeat === false)   // do not allow auto-repeated events. one click -- one action
            {
                backButtonPressed = true
            }
        }
        else if (event.key === Qt.Key_D + m_myOffset_D)
        {
                downButtonPressed = true        // "DOWN" pressed
        }
        else if (event.key === Qt.Key_E + m_myOffset_E)
        {
           upButtonPressed = true               //  "UP" pressed
        }
        else if (event.key === Qt.Key_F + m_myOffset_F)
        {
            if (event.isAutoRepeat === false)
            {
                    enterButtonPressed = true   // "ENTER" pressed
            }
        }
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_C + m_myOffset_C)
        {
            if (event.isAutoRepeat === false)   // do not allow auto-repeated events. one click -- one action
            {
                backButtonPressed = false
            }
        }
        else if (event.key === Qt.Key_D + m_myOffset_D)
        {
            downButtonPressed = false
        }
        else if (event.key === Qt.Key_E + m_myOffset_E)
        {
            upButtonPressed = false
        }
        else if (event.key === Qt.Key_F + m_myOffset_F)
        {
            if (event.isAutoRepeat === false)
            {
                enterButtonPressed = false
            }
        }
    }
}
