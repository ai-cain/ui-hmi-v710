/******************************************************************************
 *
 * File:        displayConfigHandler.cpp
 *
 * Description: Contains class methods for the DisplayConfigurationHandler.
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
#include <QProcess>

#include "displayConfigHandler.h"

/******************************************************************************
 * Class Methods
******************************************************************************/
DisplayConfiguration::DisplayConfiguration(Configuration_Type configType,
                                           QString name,
                                           int hwButtonNrOk,
                                           int hwButtonNrUp,
                                           int hwButtonNrDown,
                                           int hwButtonNrCancel,
                                           int hwButtonInputId,
                                           int headerHeight)
{
    m_configType       = configType;
    m_name             = name;
    m_hwButtonNrOk     = hwButtonNrOk;
    m_hwButtonNrUp     = hwButtonNrUp;
    m_hwButtonNrDown   = hwButtonNrDown;
    m_hwButtonNrCancel = hwButtonNrCancel;
    m_hwButtonInputId  = hwButtonInputId;
    m_headerHeight     = headerHeight;
}

Configuration_Type DisplayConfiguration::configType() { return m_configType; }
QString DisplayConfiguration::name() { return m_name; }
int DisplayConfiguration::hwButtonNrOk() { return m_hwButtonNrOk; }
int DisplayConfiguration::hwButtonNrUp() { return m_hwButtonNrUp; }
int DisplayConfiguration::hwButtonNrDown() { return m_hwButtonNrDown; }
int DisplayConfiguration::hwButtonNrCancel() { return m_hwButtonNrCancel; }
int DisplayConfiguration::hwButtonInputId() { return m_hwButtonInputId; }
int DisplayConfiguration::headerHeight() { return m_headerHeight; }

DisplayConfigHandler::DisplayConfigHandler()
{
}

DisplayConfigHandler::~DisplayConfigHandler()
{
}

void DisplayConfigHandler::init()
{
    Configuration_Type displayType = getDisplayType();

    //displayType = Configuration_Type::CONFIG_VI2;
    //displayType = Configuration_Type::CONFIG_V710; //by gerald, hacer lo mismo para v510

    for (std::vector<DisplayConfiguration *>::size_type i = 0; i < DisplayConfigurations.size(); i++)
    {
        DisplayConfiguration *configItem = DisplayConfigurations[i];
        if (configItem->configType() == displayType)
        {
            m_currentConfig = configItem;
        }
    }
}

DisplayConfiguration *DisplayConfigHandler::current()
{
    return m_currentConfig;
}

Configuration_Type DisplayConfigHandler::getDisplayType()
{
    Configuration_Type result = Configuration_Type::CONFIG_GENERIC;

    QProcess process;
    process.start("uname", QStringList() << "-n");
    if (!process.waitForFinished(1000))
        return result;

    QString detected = "";
    while (process.bytesAvailable())
    {
        QString s(process.readLine());

        detected.append(s);
    }

    if (detected.length() > 0)
    {
        detected = detected.trimmed();
        detected = detected.toUpper();
        detected = detected.replace("LINUX", "");
        detected = detected.replace("-", "");
    }

    if (detected.contains("VA"))
    {
        result = Configuration_Type::CONFIG_VA;
    }
    else if (detected.contains("VS"))
    {
        result = Configuration_Type::CONFIG_VS;
    }
    else if (detected.contains("VI2"))
    {
        result = Configuration_Type::CONFIG_VI2;
    }
    else if (detected.contains("V700"))
    {
        result = Configuration_Type::CONFIG_V700;
    } // add by gerald
    else if (detected.contains("V710"))
    {
        result = Configuration_Type::CONFIG_V710;
    }// ver resto del codigo
    else if (detected.contains("X900"))
    {
        result = Configuration_Type::CONFIG_X900;
    }

    return result;
}
