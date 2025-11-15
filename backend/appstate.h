/******************************************************************************
 *
 * File:        appstate.h
 *
 * Description: This file contains the helper class MyAppState which is used
 * to contol the menu and page selections in the application.
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
#ifndef APPSTATE_H
#define APPSTATE_H
#pragma once

/******************************************************************************
 * Include Files
******************************************************************************/
#include <QObject>
#include <QtQml>

/******************************************************************************
 * Class Declaration
******************************************************************************/
/**
* @brief The MyAppState is an enum class that can be used to control the page
* selection in the application.
*/
class MyAppState : public QObject
{
    Q_OBJECT

public:
    /**
     * @brief Enumeration of the available pages. New pages can be added.
     */
    enum class AppState
    {
        MAIN,
        BACKLIGHT,
        BUZZER,
        FRONTLED,
        VERSION,
        POWER
    };
    Q_ENUMS(AppState)

    /**
     * @brief Initialization by registering the enum to be accessible from QML
     */
    static void init()
    {
        qRegisterMetaType<MyAppState::AppState>("MyAppState::AppState");
        qmlRegisterType<MyAppState>("MyQmlModule", 1, 0, "MyAppState");
    }
};
#endif // APPSTATE_H
