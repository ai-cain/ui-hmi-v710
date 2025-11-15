/******************************************************************************
 *
 * File:        VersionHandler.h
 *
 * Description: This file contains the VersionHandler class that takes care of
 * the interaction between CCAux "Version" and "About" information and the Qt
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
#ifndef VERSIONHANDLER_H
#define VERSIONHANDLER_H

/******************************************************************************
 * Include Files
******************************************************************************/
#include "CCAuxHandlerBase.h"
#include <QVariant>
#include <assert.h>

/* We are using an ifdef here in order to exclude all references to CCAux when
 * running in virtual Linux environment. This is handy when developing the UI
 * parts without the need of the actual hardware. See the project *.pro file
 * for further details about how CCAUX is defined for a specific display. */
#ifdef CCAUX
#include <About.h>
#include <AuxVersion.h>

using namespace CrossControl;
#endif

/******************************************************************************
 * Class Declaration
******************************************************************************/
/**
 * @brief VersionItem class that holds version information displayed in the UI,
 * i.e. headline, version value and CCAux status of the call.
 */
class VersionItem : public QObject
{
    Q_OBJECT

public:
    /**
    * @brief Get the headline name, for example "OS Version". This info does not
    * change during runtime, thus CONSTANT.
    */
    Q_PROPERTY(QString name READ name CONSTANT)

    /**
    * @brief Get the version value, for example "1.4.0.0". This info does not
    * change during runtime, thus CONSTANT.
    */
    Q_PROPERTY(QString version READ version CONSTANT)

    /**
    * @brief Get the CCAux status of the call, for example "ERR_SUCCESS". This
    * info does not change during runtime, thus CONSTANT.
    */
    Q_PROPERTY(QString status READ status CONSTANT)

    /**
    * @brief Constructor.
    */
    VersionItem();

    /**
    * @brief Sets the name (header).
    * @param value [in] Name string.
    */
    void setName(QString value);

    /**
    * @brief Gets the name (header).
    * @return Name string.
    */
    QString name();

    /**
    * @brief Sets the version value.
    * @param value [in] Version string.
    */
    void setVersion(QString value);

    /**
    * @brief Gets the version value.
    * @return Version string.
    */
    QString version();

    /**
    * @brief Sets the CCAux status.
    * @param value [in] CCAux status string.
    */
    void setStatus(QString value);

    /**
    * @brief Gets the CCAux status.
    * @return Version string.
    */
    QString status();

private:
    // Private members
    QString m_name;
    QString m_version;
    QString m_status;
};

/**
 * @brief VersionHandler class that takes care of the interaction between
 * the user interface and CCAux "Version" and "About" objects and exposes
 * a list of VersionItems to be presented in the UI.
 */
class VersionHandler : public CCAuxHandlerBase
{
    Q_OBJECT

    /**
    * @brief Get the list of VersionItems, used as a model for the ListView
    * in the UNIT INFO page.
    */
    Q_PROPERTY(QVariant versionItems READ versionItems CONSTANT)

    /**
    * @brief Get the touch capability property of the unit, used to control
    * some of the graphical parts in the UI.
    */
    Q_PROPERTY(bool hasTouch READ hasTouch NOTIFY hasTouchChanged)
public:
    explicit VersionHandler(QObject *parent = 0);
    ~VersionHandler();

    /**
    * @brief Initializes the handler by getting references to the CCAux
    * AuxVersion and About objects.
    */
    void init();

signals:
    void lastErrorChanged();
    void hasTouchChanged();

private:
    /**
    * @brief Gets the list of VersionItems.
    */
    QVariant versionItems();

    /**
    * @brief Sets the has touch property.
    * @param value [in] The current has touch property.
    */
    void setHasTouch(bool value);

    /**
    * @brief Gets the has touch value.
    * @return Boolean value telling wether the unit has touch capabilities or not.
    */
    bool hasTouch();

    // AuxVersion info

    /**
    * @brief Gets the CCAux version string from the CCAux Version object.
    * @param result [out] The resulting version string.
    * @param status [out] The status string of the operation.
    */
    void getCCAuxVersion(QString &result, QString &status);

    /**
    * @brief Gets the CCAux driver version string from the CCAux Version object.
    * @param result [out] The resulting version string.
    * @param status [out] The status string of the operation.
    */
    void getCCAuxDriverVersion(QString &result, QString &status);

    /**
    * @brief Gets the Operating System version string from the CCAux Version object.
    * @param result [out] The resulting version string.
    * @param status [out] The status string of the operation.
    */
    void getOSVersion(QString &result, QString &status);

    /**
    * @brief Gets the System Supervisor version string from the CCAux Version object.
    * @param result [out] The resulting version string.
    * @param status [out] The status string of the operation.
    */
    void getSystemSupervisorVersion(QString &result, QString &status);

    /**
    * @brief Gets the Front microcontroller software version string from the
    * CCAux Version object.
    * @param result [out] The resulting version string.
    * @param status [out] The status string of the operation.
    */
    void getFrontVersion(QString &result, QString &status);

    /**
    * @brief Gets the FPGA software version string from the CCAux Version object.
    * @param result [out] The resulting version string.
    * @param status [out] The status string of the operation.
    */
    void getFPGAVersion(QString &result, QString &status);

    // About info

    /**
    * @brief Gets the serial number of the display unit from the CCAux About object.
    * @param result [out] The resulting serial number string.
    * @param status [out] The status string of the operation.
    */
    void getAboutUnitSerial(QString &result, QString &status);

    /**
    * @brief Gets the product revision version from the CCAux About object.
    * @param result [out] The resulting version string.
    * @param status [out] The status string of the operation.
    */
    void getAboutProductRev(QString &result, QString &status);

    /**
    * @brief Gets the manufacturing date of the display unit from the CCAux
    * About object.
    * @param result [out] The resulting date string.
    * @param status [out] The status string of the operation.
    */
    void getAboutManufacturingDate(QString &result, QString &status);

    /**
    * @brief Gets the resolution of the display unit from the CCAux About object.
    * @param result [out] The resulting resolution string (XXXXxYYYY).
    * @param status [out] The status string of the operation.
    */
    void getAboutDisplayResolution(QString &result, QString &status);

    /**
    * @brief Gets wether the display unit has touch support or not.
    * @param result [out] The resulting touch available bool value.
    * @param status [out] The status string of the operation.
    */
    void getAboutIsTouchScreenAvailable(QString &result, QString &status);

    /**
    * @brief Gets the number of hardware buttons on the display unit.
    * @param result [out] The resulting number of hardware buttons as a string value.
    * @param status [out] The status string of the operation.
    */
    void getAboutNumberOfHwButtons(QString &result, QString &status);

    // CCAux
#ifdef CCAUX
    AUXVERSIONHANDLE m_pAuxVersion;
    ABOUTHANDLE m_pAbout;
#endif

    // Private members
    QList<QObject *> *m_versionItems;
    bool m_hasTouch;
};

#endif // VERSIONHANDLER_H
