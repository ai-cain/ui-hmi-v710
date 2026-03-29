/******************************************************************************
 *
 * File:        hwbutton.cpp
 *
 * Description: Contains the class methods for the HWButton class.
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
#include "hwbutton.h"
#include <QDebug>

#ifdef Q_OS_LINUX
#include <fcntl.h>
#include <linux/input.h>
#include <unistd.h>
#endif

/******************************************************************************
 * Class Methods
******************************************************************************/
HWButton::HWButton(QObject *parent)
    : HWButton(0, parent)
{
}

HWButton::HWButton(int hwButtonInputId, QObject *parent)
    : QObject(parent),
      m_buttonsFd(-1),
      m_notifier(nullptr)
{
    for (uint i = 0; i < m_buttons.size(); i++)
    {
        m_buttons[i] = Released;
    }

#ifdef Q_OS_LINUX
    // --------------- Button Press set up --------------------------
    const QString device = QString("/dev/input/event%1").arg(hwButtonInputId);
    m_buttonsFd           = ::open(device.toLocal8Bit().constData(), O_RDONLY, 0);
    if (m_buttonsFd < 0)
    {
        qDebug() << "Failed to open input device" << device;
    }
    else
    {
        m_notifier = new QSocketNotifier(m_buttonsFd, QSocketNotifier::Read, this);
        connect(m_notifier, SIGNAL(activated(int)), this, SLOT(processButtonEvent()));
    }
#else
    Q_UNUSED(hwButtonInputId);
#endif
}

HWButton::~HWButton()
{
#ifdef Q_OS_LINUX
    if (m_buttonsFd >= 0)
    {
    ::close(m_buttonsFd);
    }
#endif
    delete m_notifier;
}

void HWButton::processButtonEvent()
{
#ifdef Q_OS_LINUX
    struct input_event event;
    ssize_t n = ::read(m_buttonsFd, &event, sizeof(input_event));
    if (n != static_cast<ssize_t>(sizeof(input_event)))
    {
        // "Unexpected lenght read"
        return;
    }

    if (event.type != EV_KEY)
        return;

    int buttonIndex = 0;

    switch (event.code)
    {
    case KEY_F1:
        buttonIndex = 1;
        break;
    case KEY_F2:
        buttonIndex = 2;
        break;
    case KEY_F3:
        buttonIndex = 3;
        break;
    case KEY_F4:
        buttonIndex = 4;
        break;
    case KEY_F5:
        buttonIndex = 5;
        break;
    case KEY_F6:
        buttonIndex = 6;
        break;
    case KEY_F7:
        buttonIndex = 7;
        break;
    case KEY_F8:
        buttonIndex = 8;
        break;
    case KEY_F9:
        buttonIndex = 9;
        break;
    case KEY_F10:
        buttonIndex = 10;
        break;
    }

    if (buttonIndex > 0)
    {
        if (event.value == 1)
        {
            setButton(buttonIndex, Pressed);
        }
        else
        {
            setButton(buttonIndex, Released);
        }
    }
#endif
}
