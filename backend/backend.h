/******************************************************************************
 *
 * File:        backend.h
 *
 * Description: The backend is the main handler for operations behind the UI.
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
#ifndef BACKEND_H
#define BACKEND_H

/******************************************************************************
 * Include Files
******************************************************************************/
#include <QObject>
#include <QProcess>
#include <QTimer>

#include "displayConfigHandler.h"
#include "ipaddress.h" //de ser encesario incluir en el cmake para saber que usas este archivo

#include "hwbutton.h"

/******************************************************************************
 * Manifest Constants, Macros
******************************************************************************/
const int IPADDRESS_POLLING_TIME = 1000; // milliseconds

/******************************************************************************
 * Class Declaration
******************************************************************************/
/**
 * @brief The BackEnd class is the main controller of some actions behind the UI,
 * except pure CCAux features that have separate handlers.
 */
class BackEnd : public QObject
{
    Q_OBJECT

    /**
    * @brief Get or set the page selection state from the main menu.
    */
    Q_PROPERTY(int state READ state WRITE setState NOTIFY stateChanged)

    /**
    * @brief Get the primary IP address of the display unit.
    */
    Q_PROPERTY(QString ipAddress1 READ ipAddress1 NOTIFY ipAddress1Changed)

    /**
    * @brief Get the secondary IP address of displays that support this.
    */
    Q_PROPERTY(QString ipAddress2 READ ipAddress2 NOTIFY ipAddress2Changed)

    /**
    * @brief Get the model name of the display unit, for example "CCpilot VS"
    */
    Q_PROPERTY(QString displayName READ displayName NOTIFY displayNameChanged)

    /**
    * @brief Get the configuration of the display unit, which contains info
    * about hardware and other display specific properties.
    */
    Q_PROPERTY(QObject *currentConfig READ currentConfig CONSTANT)

public:
    explicit BackEnd(QObject *parent = 0);
    ~BackEnd();

    /**
    * @brief Initializes the backend, sets up its objects and gets the current display
    * configuration.
    */
    void init();

signals:
    void stateChanged(int state);

    void ipAddress1Changed();
    void ipAddress2Changed();
    void displayNameChanged();

    void hardwareButtonStateChanged(int buttonNo, int buttonPressed);

public slots:
    /**
    * @brief Sets the page selection state.
    * @param state [in] The new state.
    */
    void setState(int state)
    {
        if (m_state == state)
            return;

        m_state = state;
        emit stateChanged(m_state);
    }

private slots:
    void ipTimerTimeout();
    void updateHwButtonState(int buttonNo, bool buttonPressed);

private:
    /**
    * @brief Gets the current page selection state.
    * @return The current page state enum.
    */
    int state() const { return m_state; }

    /**
    * @brief Gets the primary IP address as a string.
    * @return The primary IP address.
    */
    QString ipAddress1();

    /**
    * @brief Sets the current primary IP adress.
    * @param value [in] The current primary IP address as a string ("aaa.bbb.ccc.ddd").
    */
    void setIpAddress1(QString value);

    /**
    * @brief Gets the secondary IP address as a string.
    * @return The secondary IP address.
    */
    QString ipAddress2();

    /**
    * @brief Sets the current secondary IP adress.
    * @param value [in] The current secondary IP address as a string ("aaa.bbb.ccc.ddd").
    */
    void setIpAddress2(QString value);

    /**
    * @brief Gets the model name of the display unit, for example "CCpilot VS".
    * @return The model name of the display unit.
    */
    QString displayName();

    /**
    * @brief Sets the model name of the display unit, for example "CCpilot VS".
    * @param value [in] The model name of the display unit.
    */
    void setDisplayName(QString value);

    /**
    * @brief Gets the current configuraton of the display unit.
    * @return The current configuraton of the display unit.
    */
    DisplayConfiguration *currentConfig();

    // Member objects
    IpAddress *m_ipAddressHandler;
    QTimer *m_ipAddressTimer;
    HWButton *m_hwButtonHandler;

    DisplayConfigHandler m_displayConfigHandler;

    // Members
    int m_state;

    QString m_ipAddress1;
    QString m_ipAddress2;

    QString m_displayName;
};

#endif // BACKEND_H
