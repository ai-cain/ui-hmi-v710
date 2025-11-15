/******************************************************************************
 *
 * File:        FrontLedHandler.cpp
 *
 * Description: Contains the class methods for the FrontLedHandler.
 *
 * Copyright (C) 2020 CrossControl AB
 * All rights reserved.
 * Contact: CrossControl AB (info@crosscontrol.com)
 *
 * Code Template Revision: 1.2
 *
******************************************************************************/

/******************************************************************************
 * Include Files
******************************************************************************/
#include "FrontLedHandler.h"

#ifdef CCAUX
#include <CCAuxErrors.h>
#endif

/******************************************************************************
 * Class Methods
******************************************************************************/
FrontLedHandler::FrontLedHandler(QObject *parent)
{
    setParent(parent);

    // Initialize to full RED. Current color will be detected in the init() procedure.
    m_ledRedValue   = new unsigned char(CCAUX_COLORCOMPONENT_MAXVALUE);
    m_ledGreenValue = new unsigned char(0x00);
    m_ledBlueValue  = new unsigned char(0x00);
}

FrontLedHandler::~FrontLedHandler()
{
    free(m_ledRedValue);
    free(m_ledGreenValue);
    free(m_ledBlueValue);

#ifdef CCAUX
    ::FrontLED_release(m_pFrontLed);
#endif
}

void FrontLedHandler::init()
{
#ifdef CCAUX
    // Assign the handle to the CCAux front LED object
    m_pFrontLed = ::GetFrontLED();
    assert(m_pFrontLed);

    // Get current backlight value
    eErr err = ::FrontLED_getColor(m_pFrontLed, m_ledRedValue, m_ledGreenValue, m_ledBlueValue);
    setLastErrorCode(err);
#endif

    emit currentRedValueChanged();
    emit currentGreenValueChanged();
    emit currentBlueValueChanged();
    emit currentColorHexCodeChanged();
}

unsigned char FrontLedHandler::currentRedValue()
{
    return *m_ledRedValue;
}

void FrontLedHandler::setCurrentRedValue(unsigned char value)
{
    if (*m_ledRedValue != value)
    {
        *m_ledRedValue = value;

#ifdef CCAUX
        eErr err = ::FrontLED_setColor(m_pFrontLed, *m_ledRedValue, *m_ledGreenValue, *m_ledBlueValue);
        setLastErrorCode(err);
#endif

        emit currentRedValueChanged();
        emit currentColorHexCodeChanged();
    }
}

unsigned char FrontLedHandler::currentGreenValue()
{
    return *m_ledGreenValue;
}

void FrontLedHandler::setCurrentGreenValue(unsigned char value)
{
    if (*m_ledGreenValue != value)
    {
        *m_ledGreenValue = value;

#ifdef CCAUX
        eErr err = ::FrontLED_setColor(m_pFrontLed, *m_ledRedValue, *m_ledGreenValue, *m_ledBlueValue);
        setLastErrorCode(err);
#endif

        emit currentGreenValueChanged();
        emit currentColorHexCodeChanged();
    }
}

unsigned char FrontLedHandler::currentBlueValue()
{
    return *m_ledBlueValue;
}

void FrontLedHandler::setCurrentBlueValue(unsigned char value)
{
    if (*m_ledBlueValue != value)
    {
        *m_ledBlueValue = value;

#ifdef CCAUX
        eErr err = ::FrontLED_setColor(m_pFrontLed, *m_ledRedValue, *m_ledGreenValue, *m_ledBlueValue);
        setLastErrorCode(err);
#endif

        emit currentBlueValueChanged();
        emit currentColorHexCodeChanged();
    }
}

QString FrontLedHandler::currentColorHexCode()
{
    /* Led color components are defined 0 - 15, so normalize it to 15 and multiply
     * the factor by 255 to get 24-bit true color */
    int red   = (float)*m_ledRedValue / CCAUX_COLORCOMPONENT_MAXVALUE * RGB_COLORCOMPONENT_MAXVALUE;
    int green = (float)*m_ledGreenValue / CCAUX_COLORCOMPONENT_MAXVALUE * RGB_COLORCOMPONENT_MAXVALUE;
    int blue  = (float)*m_ledBlueValue / CCAUX_COLORCOMPONENT_MAXVALUE * RGB_COLORCOMPONENT_MAXVALUE;

    // Format "#aarrggbb"
    QString code = QString("#ff%1%2%3").arg(red, 2, 16, QChar('0')).arg(green, 2, 16, QChar('0')).arg(blue, 2, 16, QChar('0'));
    return code;
}
