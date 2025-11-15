/******************************************************************************
 *
 * File:        BackLightHandler.h
 *
 * Description: This file contains the BackLightHandler class that takes care of
 * the interaction between CCAux backlight controller and the Qt user interface.
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
#ifndef BACKLIGHTHANDLER_H
#define BACKLIGHTHANDLER_H

/******************************************************************************
 * Include Files
******************************************************************************/
#include "CCAuxHandlerBase.h"
#include <QTimer>
#include <assert.h>

/* We are using an ifdef here in order to exclude all references to CCAux when
 * running in virtual Linux environment. This is handy when developing the UI
 * parts without the need of the actual hardware. See the project *.pro file
 * for further details about how CCAUX is defined for a specific display. */
#ifdef CCAUX
#include <Backlight.h>
#include <Lightsensor.h>

using namespace CrossControl;
#endif

/******************************************************************************
 * Manifest Constants, Macros
******************************************************************************/
const int LIGHTSENSOR_POLLING_TIME = 500; // milliseconds
const int BACKLIGHT_MAX_VALUE      = 255;

/******************************************************************************
 * Class Declaration
******************************************************************************/
/**
 * @brief BackLightHandler class that takes care of the interaction between
 * the user interface and CCAux backlight control. It has properties for getting
 * and setting the backlight as well as monitoring the light sensor value.
 */
class BackLightHandler : public CCAuxHandlerBase
{
    Q_OBJECT

    /**
    * @brief Get or set the backlight value (0-255).
    */
    Q_PROPERTY(int currentBacklightValue READ currentBacklightValue WRITE setCurrentBacklightValue NOTIFY currentBacklightValueChanged)

    /**
    * @brief Get the current light sensor value (illuminance). The value is
    * timer controlled and is read-only. See documentation about operation
    * range of the light sensor.
    */
    Q_PROPERTY(int currentLightSensorValue READ currentLightSensorValue NOTIFY currentLightSensorValueChanged)

    /**
    * @brief Get the current light sensor value (illuminance). The value is
    * timer controlled and is read-only. See documentation about operation
    * range of the light sensor.
    */
    Q_PROPERTY(int maxLightSensorValue READ maxLightSensorValue NOTIFY maxLightSensorValueChanged)

    /**
    * @brief Get the property telling if the display unit has light sensor or not.
    */
    Q_PROPERTY(int hasLightSensor READ hasLightSensor NOTIFY hasLightSensorChanged)
public:
    explicit BackLightHandler(QObject *parent = 0);
    ~BackLightHandler();

    /**
    * @brief Initializes the handler by getting references to the CCAux objects
    * and sets current values from the hardware.
    */
    void init();

    /**
    * @brief Increases the backlight intensity by 10 up to maximum 255.
    */
    Q_INVOKABLE void increaseBacklight();

    /**
    * @brief Decreases the backlight intensity by 10 down to minimum 10.
    */
    Q_INVOKABLE void decreaseBacklight();

signals:
    void currentBacklightValueChanged();
    void currentLightSensorValueChanged();
    void maxLightSensorValueChanged();
    void hasLightSensorChanged();

private slots:
    void lightSensorDetectTimerTimeout();

private:
    /**
    * @brief Gets the current backlight value.
    * @return Current backlight value (0-255)
    */
    int currentBacklightValue();

    /**
    * @brief Sets the current backlight value.
    * @param value [in] Requested backlight value (0-255)
    */
    void setCurrentBacklightValue(int value);

    /**
    * @brief Gets the current light sensor value.
    * @return Current light sensor value. See documentation about setting the
    * range of the backlight sensor.
    */
    int currentLightSensorValue();

    /**
    * @brief Sets the current light sensor value. See documentation about the
    * range of the light sensor.
    * @param value [in] Currently detected light sensor value to set for the property.
    */
    void setCurrentLightSensorValue(int value);

    /**
    * @brief Gets the maximum light sensor value detected.
    * @return Maximum light sensor value.
    */
    int maxLightSensorValue();

    /**
    * @brief Sets the maximum light sensor value detected.
    * @param value [in] Maximum detected light sensor value to set for the property.
    */
    void setMaxLightSensorValue(int value);

    /**
    * @brief Gets the property telling if the display unit has light sensor or not.
    * @return Value telling that the display has light sensor.
    */
    bool hasLightSensor();

    /**
    * @brief Sets the value telling if the display unit has light sensor or not.
    * @param value [in] The current value.
    */
    void setHasLightSensor(int value);

    // CCAux
#ifdef CCAUX
    BACKLIGHTHANDLE m_pBackLight;
    LIGHTSENSORHANDLE m_pLightSensor;
    LightSensorOperationRange *m_lightSensorOpRange;
#endif

    // Private members
    unsigned char m_currentBacklightValue;
    int m_currentLightSensorValue;
    int m_maxLightSensorValue;
    int m_lightSensorRange;
    bool m_hasLightSensor;

    QTimer m_lightSensorDetectTimer;
};

#endif // BACKLIGHTHANDLER_H
