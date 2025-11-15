/******************************************************************************
 *
 * File:        BackLightHandler.cpp
 *
 * Description: Contains the class methods for the BackLightHandler.
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
#include "BackLightHandler.h"

/******************************************************************************
 * Class Methods
******************************************************************************/
BackLightHandler::BackLightHandler(QObject *parent)
{
    setParent(parent);

    m_currentBacklightValue   = 10; // 10 of 255
    m_currentLightSensorValue = 0;
    m_maxLightSensorValue     = 0;
    m_hasLightSensor          = true;

#ifdef CCAUX
    m_lightSensorOpRange = new LightSensorOperationRange();
#endif
}

BackLightHandler::~BackLightHandler()
{
#ifdef CCAUX
    free(m_lightSensorOpRange);
    ::Backlight_release(m_pBackLight);
    ::Lightsensor_release(m_pLightSensor);
#endif
}

void BackLightHandler::init()
{
    m_lightSensorDetectTimer.setInterval(LIGHTSENSOR_POLLING_TIME); // 1 sec
    m_lightSensorDetectTimer.start();
    connect(&m_lightSensorDetectTimer, &QTimer::timeout, this, &BackLightHandler::lightSensorDetectTimerTimeout);

#ifdef CCAUX
    // Assign the handle to the CCAux backlight object
    m_pBackLight = ::GetBacklight();
    assert(m_pBackLight);

    m_pLightSensor = ::GetLightsensor();
    assert(m_pLightSensor);

    eErr err = ::Lightsensor_getOperatingRange(m_pBackLight, m_lightSensorOpRange);

    // Get current backlight value
    err = ::Backlight_getIntensity(m_pBackLight, &m_currentBacklightValue);
    setLastErrorCode(err);
#endif

    emit currentBacklightValueChanged();
}

int BackLightHandler::currentBacklightValue()
{
    return m_currentBacklightValue;
}

void BackLightHandler::setCurrentBacklightValue(int value)
{
    if (value != m_currentBacklightValue)
    {
        m_currentBacklightValue = value;

#ifdef CCAUX
        eErr err = Backlight_setIntensity(m_pBackLight, m_currentBacklightValue);
        setLastErrorCode(err);
#endif

        emit currentBacklightValueChanged();
    }
}

int BackLightHandler::currentLightSensorValue()
{
    return m_currentLightSensorValue;
}

void BackLightHandler::setCurrentLightSensorValue(int value)
{
    if (m_currentLightSensorValue != value)
    {
        m_currentLightSensorValue = value;

        emit currentLightSensorValueChanged();
    }
}

int BackLightHandler::maxLightSensorValue()
{
    return m_maxLightSensorValue;
}

void BackLightHandler::setMaxLightSensorValue(int value)
{
    if (m_maxLightSensorValue != value)
    {
        m_maxLightSensorValue = value;

        emit maxLightSensorValueChanged();
    }
}

bool BackLightHandler::hasLightSensor()
{
    return m_hasLightSensor;
}

void BackLightHandler::setHasLightSensor(int value)
{
    if (value != m_hasLightSensor)
    {
        m_hasLightSensor = value;

        emit hasLightSensorChanged();
    }
}

void BackLightHandler::increaseBacklight()
{
    // Increase backlight by 10 until it reaches maximum
    if (m_currentBacklightValue < BACKLIGHT_MAX_VALUE - 10)
    {
        m_currentBacklightValue += 10;
    }
    else
    {
        m_currentBacklightValue = BACKLIGHT_MAX_VALUE;
    }

    emit currentBacklightValueChanged();

#ifdef CCAUX
    eErr err = Backlight_setIntensity(m_pBackLight, m_currentBacklightValue);
    setLastErrorCode(err);
#endif
}

void BackLightHandler::decreaseBacklight()
{
    // Decrease backlight by 10 until it reaches 0
    if (m_currentBacklightValue > 20)
    {
        m_currentBacklightValue -= 10;
    }
    else
    {
        m_currentBacklightValue = 10;
    }

    emit currentBacklightValueChanged();

#ifdef CCAUX
    eErr err = Backlight_setIntensity(m_pBackLight, m_currentBacklightValue);
    setLastErrorCode(err);
#endif
}

void BackLightHandler::lightSensorDetectTimerTimeout()
{
#ifdef CCAUX
    quint16 lightSensorValue;
    eErr err = ::Lightsensor_getIlluminance(m_pLightSensor, &lightSensorValue);
    if (err == eErr::ERR_SUCCESS)
    {
        setCurrentLightSensorValue(lightSensorValue);

        if (lightSensorValue > m_maxLightSensorValue)
        {
            setMaxLightSensorValue(lightSensorValue);
        }
    }
    else
    {
        QString msg = ::GetErrorStringA(err);
        qDebug() << "Light sensor error: " << msg;
        qDebug() << "Light sensor feature will be disabled.";

        setHasLightSensor(false);
        m_lightSensorDetectTimer.stop();
    }
#endif
}
