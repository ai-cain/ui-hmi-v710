/******************************************************************************
 *
 * File:        displayConfigHandler.h
 *
 * Description: This file contains a class used to handle different display
 * configurations, for example hardware button assignment.
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
#ifndef DISPLAYCONFIGHANDLER_H
#define DISPLAYCONFIGHANDLER_H

/******************************************************************************
 * Include Files
******************************************************************************/
#include <QObject>
#include <QVariant>

/******************************************************************************
 * Datatypes & Enums
******************************************************************************/
/**
 * @brief Enum declaration of supported display configurations.
 */
enum Configuration_Type
{
    CONFIG_VA = 0,
    CONFIG_VS,
    CONFIG_VI2,
    CONFIG_V700,
    CONFIG_V710,
    CONFIG_X900,
    CONFIG_GENERIC
};

/******************************************************************************
 * Class Declaration
******************************************************************************/
/**
 * @brief DisplayConfiguration class that sets up and holds display specific
 * properties.
 */
class DisplayConfiguration : public QObject
{
    Q_OBJECT
public:
    /**
    * @brief Get the model name of the display unit.
    */
    Q_PROPERTY(QString name READ name CONSTANT)

    /**
    * @brief Get the hardware button number assigned to the OK main menu option.
    */
    Q_PROPERTY(int hwButtonNrOk READ hwButtonNrOk CONSTANT)

    /**
    * @brief Get the hardware button number assigned to the UP main menu option.
    */
    Q_PROPERTY(int hwButtonNrUp READ hwButtonNrUp CONSTANT)

    /**
    * @brief Get the hardware button number assigned to the DOWN main menu option.
    */
    Q_PROPERTY(int hwButtonNrDown READ hwButtonNrDown CONSTANT)

    /**
    * @brief Get the hardware button number assigned to the CANCEL/RETURN main menu option.
    */
    Q_PROPERTY(int hwButtonNrCancel READ hwButtonNrCancel CONSTANT)

    /**
    * @brief Get the height of the page header texts.
    */
    Q_PROPERTY(int headerHeight READ headerHeight CONSTANT)

    /**
    * @brief Default constructor.
    */
    /******************************/
    //DisplayConfiguration();// observacion******************************************************
    /******************************/
    /**
    * @brief Constructor.
    */
    explicit DisplayConfiguration(Configuration_Type configType,
                                  QString name,
                                  int hwButtonNrOk,
                                  int hwButtonNrUp,
                                  int hwButtonNrDown,
                                  int hwButtonNrCancel,
                                  int hwButtonInputId,
                                  int headerHeight);

    /**
    * @brief Gets the display unit configuration enum identifier.
    * @return The display unit configuration identifier.
    */
    Configuration_Type configType();

    /**
    * @brief Gets the model name of the display unit.
    * @return The model name of the display unit.
    */
    QString name();

    /**
    * @brief Gets the hardware button number assigned to the OK main menu option.
    * @return The hardware button number assigned to the OK main menu option.
    */
    int hwButtonNrOk();

    /**
    * @brief Gets the hardware button number assigned to the UP main menu option.
    * @return The hardware button number assigned to the UP main menu option.
    */
    int hwButtonNrUp();

    /**
    * @brief Gets the hardware button number assigned to the DOWN main menu option.
    * @return The hardware button number assigned to the DWON main menu option.
    */
    int hwButtonNrDown();

    /**
    * @brief Gets the hardware button number assigned to the CANCEL main menu option.
    * @return The hardware button number assigned to the CANCEL main menu option.
    */
    int hwButtonNrCancel();

    /**
    * @brief Gets the event ID for the hardware buttons device, i.e. /dev/input/event<ID>.
    * @return The device event ID for the hardware buttons.
    */
    int hwButtonInputId();

    /**
    * @brief Gets the height of the page header texts.
    * @return The height of the page header texts.
    */
    int headerHeight();

private:
    // Private members
    Configuration_Type m_configType;
    QString m_name;
    int m_hwButtonNrOk;
    int m_hwButtonNrUp;
    int m_hwButtonNrDown;
    int m_hwButtonNrCancel;
    int m_hwButtonInputId;
    int m_headerHeight;
};

/**
 * @brief Setup of the different display configurations.
 */
const std::vector<DisplayConfiguration *> DisplayConfigurations = {
    // configType , name  , hwButtonNrOk, hwButtonNrUp, hwButtonNrDown, ,hwButtonNrCancel, hwButtonInputId, headerHeight
    new DisplayConfiguration(Configuration_Type::CONFIG_VA, "CCpilot VA", 6, 7, 8, 9, 0, 40),
    new DisplayConfiguration(Configuration_Type::CONFIG_VS, "CCpilot VS", 0, 0, 0, 0, 0, 40),
    new DisplayConfiguration(Configuration_Type::CONFIG_VI2, "CCpilot VI2", 1, 2, 3, 4, 2, 24),
    new DisplayConfiguration(Configuration_Type::CONFIG_V700, "CCpilot V700", 0, 0, 0, 0, 0, 40),
    new DisplayConfiguration(Configuration_Type::CONFIG_V710, "CCpilot V710", 0, 0, 0, 0, 0, 40), // anadido por gerald
    new DisplayConfiguration(Configuration_Type::CONFIG_X900, "CCpilot X900", 0, 0, 0, 0, 0, 40),
    new DisplayConfiguration(Configuration_Type::CONFIG_GENERIC, "Generic CCpilot", 0, 0, 0, 0, 0, 40)
};

/**
 * @brief DisplayConfigurationHandler class that handles the current display unit configuration.
 */
class DisplayConfigHandler
{
public:
    explicit DisplayConfigHandler();
    ~DisplayConfigHandler();

    /**
     * @brief Initialization which detects and sets up the current display unit configuration.
     */
    void init();

    /**
    * @brief Gets a reference to the current display unit configuration.
    * @return The current display unit configuration.
    */
    DisplayConfiguration *current();

private:
    /**
    * @brief Detects the current display unit type by using 'uname' Linux feature.
    * @return The current display unit configuration identifier.
    */
    Configuration_Type getDisplayType();

    // Private member
    DisplayConfiguration *m_currentConfig;
};

#endif // DISPLAYCONFIGHANDLER_H
