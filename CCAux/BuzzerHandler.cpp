/******************************************************************************
 *
 * File:        BuzzerHandler.cpp
 *
 * Description: Contains the class methods for the BuzzerHandler.
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
#include "BuzzerHandler.h"

/******************************************************************************
 * Class Methods
******************************************************************************/
BuzzerHandler::BuzzerHandler(QObject *parent)
{
    setParent(parent);

    m_volume       = 20; // 20 %
    m_toneLength   = 200; // 200 ms
    m_frequency    = 0;
    m_blockingMode = false;
}

BuzzerHandler::~BuzzerHandler()
{
#ifdef CCAUX
    ::Buzzer_release(m_pBuzzer);
#endif
}

void BuzzerHandler::init()
{
#ifdef CCAUX
    // Assign the handle to the CCAux buzzer object
    m_pBuzzer = ::GetBuzzer();
    assert(m_pBuzzer);

    eErr err = ::Buzzer_setScaledVolume(m_pBuzzer, m_volume);
    setLastErrorCode(err);
#endif
    emit volumeChanged();
    emit toneLengthChanged();
}

int BuzzerHandler::volume()
{
    return m_volume;
}

void BuzzerHandler::setVolume(int value)
{
    if (m_volume != value)
    {
        m_volume = value;

#ifdef CCAUX
        eErr err = ::Buzzer_setScaledVolume(m_pBuzzer, m_volume);
        setLastErrorCode(err);
#endif

        emit volumeChanged();
    }
}

int BuzzerHandler::toneLength()
{
    return m_toneLength;
}

void BuzzerHandler::setToneLength(int value)
{
    if (m_toneLength != value)
    {
        m_toneLength = value;
        emit toneLengthChanged();
    }
}

int BuzzerHandler::frequency()
{
    return m_frequency;
}

bool BuzzerHandler::blockingMode()
{
    return m_blockingMode;
}

void BuzzerHandler::setBlockingMode(bool value)
{
    if (m_blockingMode != value)
    {
        m_blockingMode = value;

        emit blockingModeChanged();
    }
}

void BuzzerHandler::playTone(quint16 frequency)
{
    m_frequency = frequency;
#ifdef CCAUX
    eErr err = ::Buzzer_setFrequency(m_pBuzzer, frequency);
    setLastErrorCode(err);

    err = ::Buzzer_buzze(m_pBuzzer, m_toneLength, m_blockingMode);
    setLastErrorCode(err);
#endif
    emit frequencyChanged();
}
