/******************************************************************************
 *
 * File:        PowerConfigHandler.h
 *
 * Description: This file contains the PowerConfigHandler class that takes care
 * of the interaction between CCAux power/suspend/resume control and the Qt
 * user interface.
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
#ifndef POWERCONFIGHANDLER_H
#define POWERCONFIGHANDLER_H

/******************************************************************************
 * Include Files
******************************************************************************/
#include "CCAuxHandlerBase.h"
#include <assert.h>

/* We are using an ifdef here in order to exclude all references to CCAux when
 * running in virtual Linux environment. This is handy when developing the UI
 * parts without the need of the actual hardware. See the project *.pro file
 * for further details about how CCAUX is defined for a specific display. */
#ifdef CCAUX
#include <Config.h>

using namespace CrossControl;
#endif

/******************************************************************************
 * Class Declaration
******************************************************************************/
/**
 * @brief PowerConfigHandler class that takes care of the interaction between
 * the user interface and CCAux power management. It has properties for getting
 * and setting parameters related to suspend, resume and power up features.
 */
class PowerConfigHandler : public CCAuxHandlerBase
{
    Q_OBJECT

    /**
    * @brief Get or set the startup trigger configuration value ("FRONT BUTTON",
    * "ON/OFF SIGNAL" or "BOTH BUTTON AND SIGNAL").
    */
    Q_PROPERTY(QString startupTriggerConfig READ startupTriggerConfig WRITE setStartupTriggerConfig NOTIFY startupTriggerConfigChanged)

    /**
    * @brief Get or set the external on/off signal trigger time (seconds) value
    * before putting the display unit into suspend or shutdown mode.
    */
    Q_PROPERTY(unsigned int extOnOffSigTrigTime READ extOnOffSigTrigTime WRITE setExtOnOffSigTrigTime NOTIFY extOnOffSigTrigTimeChanged)

    /**
    * @brief Get or set the on/off signal action ("NO ACTION", "SUSPEND" or
    * "SHUTDOWN").
    */
    Q_PROPERTY(QString onOffSigAction READ onOffSigAction WRITE setOnOffSigAction NOTIFY onOffSigActionChanged)

    /**
    * @brief Get or set the suspend max time (minutes), i.e. the time allowed
    * in suspend mode before automatically making a shutdown.
    */
    Q_PROPERTY(unsigned short suspendMaxTime READ suspendMaxTime WRITE setSuspendMaxTime NOTIFY suspendMaxTimeChanged)
public:
    explicit PowerConfigHandler(QObject *parent = 0);
    ~PowerConfigHandler();

    /**
    * @brief Initializes the handler by getting references to the CCAux object
    * and sets current values from the hardware.
    */
    void init();

signals:
    void startupTriggerConfigChanged();
    void extOnOffSigTrigTimeChanged();
    void onOffSigActionChanged();
    void suspendMaxTimeChanged();

private:
    /**
    * @brief Get the startup trigger configuration value ("FRONT BUTTON",
    * "ON/OFF SIGNAL" or "BOTH BUTTON AND SIGNAL").
    * @return Current startup trigger config value.
    */
    QString startupTriggerConfig();

    /**
    * @brief Set the startup trigger configuration value ("FRONT BUTTON",
    * "ON/OFF SIGNAL" or "BOTH BUTTON AND SIGNAL").
    * @param value [in] Requested startup trigger config value.
    */
    void setStartupTriggerConfig(QString value);

    /**
    * @brief Get the external on/off signal trigger time value before putting
    * the display unit into suspend or shutdown mode.
    * @return The current external on/off signal trigger time (seconds).
    */
    unsigned int extOnOffSigTrigTime();

    /**
    * @brief Set the external on/off signal trigger time value before putting
    * the display unit into suspend or shutdown mode.
    * @param value [in] Requested external on/off signal trigger time (seconds).
    */
    void setExtOnOffSigTrigTime(unsigned int value);

    /**
    * @brief Get the on/off signal action ("NO ACTION", "SUSPEND" or "SHUTDOWN").
    * @return The current on/off signal action.
    */
    QString onOffSigAction();

    /**
    * @brief Set the on/off signal action ("NO ACTION", "SUSPEND" or "SHUTDOWN").
    * @param value [in] Requested on/off signal action.
    */
    void setOnOffSigAction(QString value);

    /**
    * @brief Get the max time in suspended mode before automatically shutting
    * down the display unit.
    * @return The current max time in suspended mode (minutes).
    */
    unsigned short suspendMaxTime();

    /**
    * @brief Set the max time in suspended mode before automatically shutting
    * down the display unit.
    * @param value [in] Requested max suspended time (mintues).
    */
    void setSuspendMaxTime(unsigned short value);

    // CCAux
#ifdef CCAUX
    CONFIGHANDLE m_pConfig;

    static CrossControl::TriggerConf stringToTriggerConfig(QString str);
    static QString triggerConfigToString(CrossControl::TriggerConf conf);

    static CrossControl::PowerAction stringToPowerAction(QString str);
    static QString powerActionToString(CrossControl::PowerAction conf);

    // Private members
    CrossControl::TriggerConf m_startupTriggerConfig;
    PowerAction m_onOffSigAction;
#endif

    // Private members
    unsigned int m_extOnOffSigTrigTime;
    unsigned short m_suspendMaxTime;
};

#endif // POWERCONFIGHANDLER_H
