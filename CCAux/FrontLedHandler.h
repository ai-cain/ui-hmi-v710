/******************************************************************************
 *
 * File:        FrontLedHandler.h
 *
 * Description: This file contains the FrontLedHandler class that takes care of
 * the interaction between CCAux front led controller and the Qt user interface.
 *
 * Copyright (C) 2020 CrossControl AB
 * All rights reserved.
 * Contact: CrossControl AB (info@crosscontrol.com)
 *
 * Code Template Revision: 1.2
 *
******************************************************************************/

/******************************************************************************
 * Nesting Header
******************************************************************************/
#ifndef FRONTLEDHANDLER_H
#define FRONTLEDHANDLER_H

/******************************************************************************
 * Include Files
******************************************************************************/
#include "CCAuxHandlerBase.h"
#include <assert.h>

/******************************************************************************
 * Manifest Constants, Macros
******************************************************************************/
const unsigned char CCAUX_COLORCOMPONENT_MAXVALUE = 0x0F; // 15
const unsigned char RGB_COLORCOMPONENT_MAXVALUE   = 0xFF; // 255

/* We are using an ifdef here in order to exclude all references to CCAux when
 * running in virtual Linux environment. This is handy when developing the UI
 * parts without the need of the actual hardware. See the project *.pro file
 * for further details about how CCAUX is defined for a specific display. */
#ifdef CCAUX
#include <FrontLED.h>

using namespace CrossControl;
#endif

/******************************************************************************
 * Class Declaration
******************************************************************************/
/**
 * @brief FrontLedHandler class that takes care of the interaction between
 * the user interface and CCAux front led control. It has properties for
 * individually setting the Red, Green and Blue color component and getting the
 * current color in the HTML/QML well-known #AARRGGBB string color format.
 */
class FrontLedHandler : public CCAuxHandlerBase
{
    Q_OBJECT

    /**
    * @brief Get or set the Red color component of the front LED (0-15).
    */
    Q_PROPERTY(unsigned char currentRedValue READ currentRedValue WRITE setCurrentRedValue NOTIFY currentRedValueChanged)

    /**
    * @brief Get or set the Green color component of the front LED (0-15).
    */
    Q_PROPERTY(unsigned char currentGreenValue READ currentGreenValue WRITE setCurrentGreenValue NOTIFY currentGreenValueChanged)

    /**
    * @brief Get or set the Blue color component of the front LED (0-15).
    */
    Q_PROPERTY(unsigned char currentBlueValue READ currentBlueValue WRITE setCurrentBlueValue NOTIFY currentBlueValueChanged)

    /**
    * @brief Get the current front LED color in the well-known #AARRGGBB string color format.
    */
    Q_PROPERTY(QString currentColorHexCode READ currentColorHexCode NOTIFY currentColorHexCodeChanged)
public:
    explicit FrontLedHandler(QObject *parent = 0);
    ~FrontLedHandler();

    /**
    * @brief Initializes the handler by getting references to the CCAux objects
    * and detects the current front LED color.
    */
    void init();

signals:
    void currentRedValueChanged();
    void currentGreenValueChanged();
    void currentBlueValueChanged();
    void currentColorHexCodeChanged();

private:
    /**
    * @brief Gets the current Red color component of the front LED.
    * @return Current Red color component (0-15)
    */
    unsigned char currentRedValue();

    /**
    * @brief Sets the current Red color component of the front LED.
    * @param value [in] Red color component (0-15)
    */
    void setCurrentRedValue(unsigned char value);

    /**
    * @brief Gets the current Green color component of the front LED.
    * @return Current Green color component (0-15)
    */
    unsigned char currentGreenValue();

    /**
    * @brief Sets the current Green color component of the front LED.
    * @param value [in] Green color component (0-15)
    */
    void setCurrentGreenValue(unsigned char value);

    /**
    * @brief Gets the current Blue color component of the front LED.
    * @return Current Blue color component (0-15)
    */
    unsigned char currentBlueValue();

    /**
    * @brief Sets the current Blue color component of the front LED.
    * @param value [in] Blue color component (0-15)
    */
    void setCurrentBlueValue(unsigned char value);

    /**
    * @brief Gets the current front LED color in the well-known #AARRGGBB hex string color format.
    * @return Current front LED color in #AARRGGBB hex string format
    */
    QString currentColorHexCode();

    // CCAux
#ifdef CCAUX
    FRONTLEDHANDLE m_pFrontLed;
#endif

    // Private members
    unsigned char *m_ledRedValue;
    unsigned char *m_ledGreenValue;
    unsigned char *m_ledBlueValue;
};

#endif // FRONTLEDHANDLER_H
