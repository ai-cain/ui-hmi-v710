/******************************************************************************
 *
 * File:        backend.cpp
 *
 * Description: Contains the class methods for the BackEnd of the application.
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
#include <QDebug>
#include <QNetworkInterface>
#include <QString>

#include "appstate.h"
#include "backend.h"

/******************************************************************************
 * Class Methods
******************************************************************************/
BackEnd::BackEnd(QObject *parent)
    : QObject(parent)
{
    m_ipAddress1 = "-";
    m_ipAddress2 = "-";

    m_ipAddressHandler = new IpAddress();
    m_ipAddressTimer   = new QTimer();

    setState((int)MyAppState::AppState::MAIN);
}

BackEnd::~BackEnd()
{
    delete m_ipAddressHandler;
    delete m_ipAddressTimer;
    delete m_hwButtonHandler;
}

void BackEnd::init()
{
    // Detect and setup the current display configuration
    m_displayConfigHandler.init();
    DisplayConfiguration *currentConfig = m_displayConfigHandler.current();
    QString displayName                 = currentConfig->name();
    setDisplayName(displayName);

    qDebug() << "Current display configuration: " << displayName;

    // Setup hardware button handler, does not cause any harm on displays not supporting this
    m_hwButtonHandler = new HWButton(currentConfig->hwButtonInputId());
    connect(m_hwButtonHandler, &HWButton::buttonChanged, this, &BackEnd::updateHwButtonState);

    connect(m_ipAddressTimer, &QTimer::timeout, this, &BackEnd::ipTimerTimeout);
    m_ipAddressTimer->setInterval(IPADDRESS_POLLING_TIME); // 1 sec
    m_ipAddressTimer->start();
}

QString BackEnd::ipAddress1()
{
    return m_ipAddress1;
}

void BackEnd::setIpAddress1(QString value)
{
    if (value != m_ipAddress1)
    {
        m_ipAddress1 = value;
        emit ipAddress1Changed();
    }
}

QString BackEnd::ipAddress2()
{
    return m_ipAddress2;
}

void BackEnd::setIpAddress2(QString value)
{
    if (value != m_ipAddress2)
    {
        m_ipAddress2 = value;
        emit ipAddress2Changed();
    }
}

QString BackEnd::displayName()
{
    return m_displayName;
}

void BackEnd::setDisplayName(QString value)
{
    if (value != m_displayName)
    {
        m_displayName = value;
        emit displayNameChanged();
    }
}

DisplayConfiguration *BackEnd::currentConfig()
{
    return m_displayConfigHandler.current();
}

void BackEnd::ipTimerTimeout()
{
    QString ip1 = m_ipAddressHandler->get("eth0");
    QString ip2 = m_ipAddressHandler->get("eth1");

    if (ip1 == "")
    {
        ip1 = "0.0.0.0";
    }

    setIpAddress1(ip1);
    setIpAddress2(ip2);
}

void BackEnd::updateHwButtonState(int buttonNo, bool buttonPressed)
{
    emit hardwareButtonStateChanged(buttonNo, buttonPressed);
}
