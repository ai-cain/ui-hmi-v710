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
#include "PowerConfigHandler.h"

/******************************************************************************
 * Class Methods
******************************************************************************/
PowerConfigHandler::PowerConfigHandler(QObject *parent)
{
    setParent(parent);

    m_extOnOffSigTrigTime = 1; // 1 second
    m_suspendMaxTime      = 1; // 1 minute
}

PowerConfigHandler::~PowerConfigHandler()
{
#ifdef CCAUX
    ::Config_release(m_pConfig);
#endif
}

void PowerConfigHandler::init()
{
#ifdef CCAUX
    // Assign the handle to the CCAux backlight object
    m_pConfig = ::GetConfig();
    assert(m_pConfig);

    eErr err = ::Config_getStartupTriggerConfig(m_pConfig, &m_startupTriggerConfig);
    setLastErrorCode(err);

    err = ::Config_getExtOnOffSigTrigTime(m_pConfig, &m_extOnOffSigTrigTime);
    setLastErrorCode(err);

    // Quantize the time value to the fixed selectable ones
    if (m_extOnOffSigTrigTime > 20)
    {
        m_extOnOffSigTrigTime = 20;
    }
    else if (m_extOnOffSigTrigTime > 10)
    {
        m_extOnOffSigTrigTime = 10;
    }
    else if (m_extOnOffSigTrigTime > 5)
    {
        m_extOnOffSigTrigTime = 5;
    }
    else
    {
        m_extOnOffSigTrigTime = 1;
    }

    err = ::Config_getOnOffSigAction(m_pConfig, &m_onOffSigAction);
    setLastErrorCode(err);

    err = ::Config_getSuspendMaxTime(m_pConfig, &m_suspendMaxTime);
    setLastErrorCode(err);

    // Quantize the time value to the fixed selectable ones
    if (m_suspendMaxTime > 10)
    {
        m_suspendMaxTime = 10;
    }
    else if (m_suspendMaxTime > 5)
    {
        m_suspendMaxTime = 5;
    }
    else if (m_suspendMaxTime > 2)
    {
        m_suspendMaxTime = 2;
    }
    else
    {
        m_suspendMaxTime = 1;
    }
#endif

    emit startupTriggerConfigChanged();
    emit extOnOffSigTrigTimeChanged();
    emit onOffSigActionChanged();
    emit suspendMaxTimeChanged();
}

QString PowerConfigHandler::startupTriggerConfig()
{
    QString str = "FRONT BUTTON";

#ifdef CCAUX
    str = triggerConfigToString(m_startupTriggerConfig);
#endif
    return str;
}

void PowerConfigHandler::setStartupTriggerConfig(QString value)
{
#ifdef CCAUX
    CrossControl::TriggerConf conf = stringToTriggerConfig(value);
    if (conf != m_startupTriggerConfig)
    {
        m_startupTriggerConfig = conf;

        eErr err = CrossControl::Config_setStartupTriggerConfig(m_pConfig, m_startupTriggerConfig);
        setLastErrorCode(err);

        emit startupTriggerConfigChanged();
    }
#endif
}

unsigned int PowerConfigHandler::extOnOffSigTrigTime()
{
    return m_extOnOffSigTrigTime;
}

void PowerConfigHandler::setExtOnOffSigTrigTime(unsigned int value)
{
    if (value != m_extOnOffSigTrigTime)
    {
        m_extOnOffSigTrigTime = value;

#ifdef CCAUX
        ::Config_setExtOnOffSigTrigTime(m_pConfig, m_extOnOffSigTrigTime);
#endif

        emit extOnOffSigTrigTimeChanged();
    }
}

QString PowerConfigHandler::onOffSigAction()
{
    QString str = "NO ACTION";

#ifdef CCAUX
    str = powerActionToString(m_onOffSigAction);
#endif
    return str;
}

void PowerConfigHandler::setOnOffSigAction(QString value)
{
#ifdef CCAUX
    CrossControl::PowerAction conf = stringToPowerAction(value);
    if (conf != m_onOffSigAction)
    {
        m_onOffSigAction = conf;

        eErr err = CrossControl::Config_setOnOffSigAction(m_pConfig, m_onOffSigAction);
        setLastErrorCode(err);

        emit onOffSigActionChanged();
    }
#endif
}

unsigned short PowerConfigHandler::suspendMaxTime()
{
    return m_suspendMaxTime;
}

void PowerConfigHandler::setSuspendMaxTime(unsigned short value)
{
    if (value != m_suspendMaxTime)
    {
        m_suspendMaxTime = value;

#ifdef CCAUX
        ::Config_setSuspendMaxTime(m_pConfig, m_suspendMaxTime);
#endif

        emit suspendMaxTimeChanged();
    }
}

#ifdef CCAUX
CrossControl::TriggerConf PowerConfigHandler::stringToTriggerConfig(QString str)
{
    CrossControl::TriggerConf result;

    QString strU = str.toUpper();
    if (strU == "FRONT BUTTON")
    {
        result = CrossControl::Front_Button_Enabled;
    }
    else if (strU == "ON/OFF SIGNAL")
    {
        result = CrossControl::OnOff_Signal_Enabled;
    }
    else
    {
        result = CrossControl::Both_Button_And_Signal_Enabled;
    }

    return result;
}
#endif

#ifdef CCAUX
QString PowerConfigHandler::triggerConfigToString(CrossControl::TriggerConf conf)
{
    QString result;

    switch (conf)
    {
    case CrossControl::Front_Button_Enabled:
        result = "FRONT BUTTON";
        break;
    case CrossControl::OnOff_Signal_Enabled:
        result = "ON/OFF SIGNAL";
        break;
    default:
        result = "BOTH BUTTON AND SIGNAL";
        break;
    }

    return result;
}
#endif

#ifdef CCAUX
CrossControl::PowerAction PowerConfigHandler::stringToPowerAction(QString str)
{
    CrossControl::PowerAction result;

    QString strU = str.toUpper();
    if (strU == "NO ACTION")
    {
        result = CrossControl::NoAction;
    }
    else if (strU == "SUSPEND")
    {
        result = CrossControl::ActionSuspend;
    }
    else
    {
        result = CrossControl::ActionShutDown;
    }

    return result;
}
#endif

#ifdef CCAUX
QString PowerConfigHandler::powerActionToString(CrossControl::PowerAction conf)
{
    QString result;

    switch (conf)
    {
    case CrossControl::NoAction:
        result = "NO ACTION";
        break;
    case CrossControl::ActionSuspend:
        result = "SUSPEND";
        break;
    default:
        result = "SHUTDOWN";
        break;
    }

    return result;
}
#endif
