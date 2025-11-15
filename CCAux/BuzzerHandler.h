/******************************************************************************
 *
 * File:        BuzzerHandler.h
 *
 * Description: This file contains the BuzzerHandler class that takes care of
 * the interaction between CCAux buzzer feature and the Qt user interface.
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
#ifndef BUZZERHANDLER_H
#define BUZZERHANDLER_H

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
#include <Buzzer.h>

using namespace CrossControl;
#endif

/******************************************************************************
 * Class Declaration
******************************************************************************/
/**
 * @brief BuzzerHandler class that takes care of the interaction between
 * the user interface and CCAux buzzer feature. It has properties for getting
 * and setting the volume and tonelength of the buzzer and also a call for
 * playing a tone with a given frequency.
 */
class BuzzerHandler : public CCAuxHandlerBase
{
    Q_OBJECT

    /**
    * @brief Get or set the buzzer volume value (0-100%).
    */
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged)

    /**
    * @brief Get or set the buzzer tone length in milliseconds.
    */
    Q_PROPERTY(int toneLength READ toneLength WRITE setToneLength NOTIFY toneLengthChanged)

    /**
    * @brief Get the frequency of the last tone played.
    */
    Q_PROPERTY(int frequency READ frequency NOTIFY frequencyChanged)

    /**
    * @brief Get or set the blocking (synch/asynch) mode parameter of the buzzing operation.
    */
    Q_PROPERTY(bool blockingMode READ blockingMode WRITE setBlockingMode NOTIFY blockingModeChanged)
public:
    /******************************************************************************
     * Datatypes & Enums
    ******************************************************************************/
    /**
     * @brief Tone frequences rounded to the closest integer
     */
    enum Tone
    {
        C  = 1047,
        CS = 1109,
        D  = 1175,
        DS = 1245,
        E  = 1319,
        F  = 1397,
        FS = 1480,
        G  = 1568,
        GS = 1661,
        A  = 1760,
        AS = 1865,
        B  = 1976
    };
    Q_ENUMS(Tone)

    explicit BuzzerHandler(QObject *parent = 0);
    ~BuzzerHandler();

    /**
    * @brief Initializes the handler by getting references to the CCAux objects
    * and sets a pleasant volume level.
    */
    void init();

    /**
    * @brief Plays a tone using the buzzer.
    * @param frequency [in] The frequency of the tone in Hz (700-10000 Hz)
    */
    Q_INVOKABLE void playTone(quint16 frequency);

signals:
    void volumeChanged();
    void toneLengthChanged();
    void frequencyChanged();
    void blockingModeChanged();

private:
    /**
    * @brief Gets the current volume of the buzzer.
    * @return Current volume value (0-100%)
    */
    int volume();

    /**
    * @brief Sets the current volume of the buzzer
    * @param value [in] Requested volume value (0-100%)
    */
    void setVolume(int value);

    /**
    * @brief Gets the current tone length of the buzzer.
    * @return Current tone length value.
    */
    int toneLength();

    /**
    * @brief Sets the current tone length value
    * @param value [in] Requested  tone length value.
    */
    void setToneLength(int value);

    /**
    * @brief Gets the frequency of the last tone played.
    * @return THe frequency of the last tone.
    */
    int frequency();

    /**
    * @brief Gets the current value of the blocking mode of the buzzer.
    * @return True if blocking (synch), otherwise false (asynch).
    */
    bool blockingMode();

    /**
    * @brief Sets the current blocking mode of the buzzer
    * @param value [in] Blocking mode (True = blocking, False = non-blocking).
    */
    void setBlockingMode(bool value);

    // CCAux
#ifdef CCAUX
    BUZZERHANDLE m_pBuzzer;
#endif

    // Private members
    int m_volume;
    int m_toneLength;
    int m_frequency;
    bool m_blockingMode;
};

#endif // BUZZERHANDLER_H
