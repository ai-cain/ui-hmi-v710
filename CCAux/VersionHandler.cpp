/******************************************************************************
 *
 * File:        VersionHandler.cpp
 *
 * Description: Contains the class methods for the VersionItem and
 * VersionHandler classes.
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
#include "VersionHandler.h"

/******************************************************************************
 * Class Methods of the VersionItem class
******************************************************************************/
VersionItem::VersionItem()
{
    m_name    = "";
    m_version = "";
    m_status  = "";
}

void VersionItem::setName(QString value)
{
    if (m_name != value)
    {
        m_name = value;
    }
}

QString VersionItem::name()
{
    return m_name;
}

void VersionItem::setVersion(QString value)
{
    if (m_version != value)
    {
        m_version = value;
    }
}

QString VersionItem::version()
{
    return m_version;
}

void VersionItem::setStatus(QString value)
{
    if (m_status != value)
    {
        m_status = value;
    }
}

QString VersionItem::status()
{
    return m_status;
}

/******************************************************************************
 * Class Methods of the VersionHandler class
******************************************************************************/
VersionHandler::VersionHandler(QObject *parent)
{
    setParent(parent);

    m_versionItems = new QList<QObject *>();
    m_hasTouch     = true;
}

VersionHandler::~VersionHandler()
{
    qDeleteAll(m_versionItems->begin(), m_versionItems->end());
    delete (m_versionItems);

#ifdef CCAUX
    ::AuxVersion_release(m_pAuxVersion);
    ::About_release(m_pAbout);
#endif
}

void VersionHandler::init()
{
#ifdef CCAUX
    // Assign the handle to the CCAux Version object
    m_pAuxVersion = ::GetAuxVersion();
    assert(m_pAuxVersion);

    // Assign the handle to the About object
    m_pAbout = ::GetAbout();
    assert(m_pAbout);
#endif
}

QVariant VersionHandler::versionItems()
{
    QString value, status;

    VersionItem *item = new VersionItem();
    getCCAuxVersion(value, status);
    item->setName("CCAux Version");
    item->setVersion(value);
    item->setStatus(status);
    m_versionItems->push_back(item);

    item = new VersionItem();
    getCCAuxDriverVersion(value, status);
    item->setName("CCAux Driver Version");
    item->setVersion(value);
    item->setStatus(status);
    m_versionItems->push_back(item);

    item = new VersionItem();
    getOSVersion(value, status);
    item->setName("OS Version");
    item->setVersion(value);
    item->setStatus(status);
    m_versionItems->push_back(item);

    item = new VersionItem();
    getSystemSupervisorVersion(value, status);
    item->setName("System Supervisor Version");
    item->setVersion(value);
    item->setStatus(status);
    m_versionItems->push_back(item);

    item = new VersionItem();
    getFrontVersion(value, status);
    item->setName("Front Version");
    item->setVersion(value);
    item->setStatus(status);
    m_versionItems->push_back(item);

    item = new VersionItem();
    getFPGAVersion(value, status);
    item->setName("FPGA Version");
    item->setVersion(value);
    item->setStatus(status);
    m_versionItems->push_back(item);

    item = new VersionItem();
    item->setName("");
    item->setVersion("");
    item->setStatus("");
    m_versionItems->push_back(item);

    item = new VersionItem();
    getAboutUnitSerial(value, status);
    item->setName("Unit Serial");
    item->setVersion(value);
    item->setStatus(status);
    m_versionItems->push_back(item);

    item = new VersionItem();
    getAboutProductRev(value, status);
    item->setName("Product Revision");
    item->setVersion(value);
    item->setStatus(status);
    m_versionItems->push_back(item);

    item = new VersionItem();
    getAboutManufacturingDate(value, status);
    item->setName("Manufacturing Date");
    item->setVersion(value);
    item->setStatus(status);
    m_versionItems->push_back(item);

    item = new VersionItem();
    getAboutDisplayResolution(value, status);
    item->setName("Display Resolution");
    item->setVersion(value);
    item->setStatus(status);
    m_versionItems->push_back(item);

    item = new VersionItem();
    getAboutIsTouchScreenAvailable(value, status);
    item->setName("Is Touch Available");
    item->setVersion(value);
    item->setStatus(status);
    m_versionItems->push_back(item);

    item = new VersionItem();
    getAboutNumberOfHwButtons(value, status);
    item->setName("No. of Hardware Buttons");
    item->setVersion(value);
    item->setStatus(status);
    m_versionItems->push_back(item);

    QVariant list = QVariant::fromValue(*m_versionItems);
    return list;
}

void VersionHandler::setHasTouch(bool value)
{
    if (m_hasTouch != value)
    {
        m_hasTouch = value;
        emit hasTouchChanged();
    }
}

bool VersionHandler::hasTouch()
{
    return m_hasTouch;
}

void VersionHandler::getCCAuxVersion(QString &result, QString &status)
{
    result = "-";
    status = "-";

#ifdef CCAUX
    quint8 major, minor, release, build;

    eErr err = ::AuxVersion_getCCAuxVersion(m_pAuxVersion, &major, &minor, &release, &build);
    if (err == eErr::ERR_SUCCESS)
    {
        result = QString("%1.%2.%3.%4").arg(major).arg(minor).arg(release).arg(build);
    }

    status = ::GetErrorStringA(err);
#endif
}

void VersionHandler::getCCAuxDriverVersion(QString &result, QString &status)
{
    result = "-";
    status = "-";

#ifdef CCAUX
    quint8 major, minor, release, build;

    eErr err = ::AuxVersion_getCCAuxDrvVersion(m_pAuxVersion, &major, &minor, &release, &build);
    if (err == eErr::ERR_SUCCESS)
    {
        result = QString("%1.%2.%3.%4").arg(major).arg(minor).arg(release).arg(build);
    }

    status = ::GetErrorStringA(err);
#endif
}

void VersionHandler::getOSVersion(QString &result, QString &status)
{
    result = "-";
    status = "-";

#ifdef CCAUX
    quint8 major, minor, release, build;

    eErr err = ::AuxVersion_getOSVersion(m_pAuxVersion, &major, &minor, &release, &build);
    if (err == eErr::ERR_SUCCESS)
    {
        result = QString("%1.%2.%3.%4").arg(major).arg(minor).arg(release).arg(build);
    }

    status = ::GetErrorStringA(err);
#endif
}

void VersionHandler::getSystemSupervisorVersion(QString &result, QString &status)
{
    result = "-";
    status = "-";

#ifdef CCAUX
    quint8 major, minor, release, build;

    eErr err = ::AuxVersion_getSSVersion(m_pAuxVersion, &major, &minor, &release, &build);
    if (err == eErr::ERR_SUCCESS)
    {
        result = QString("%1.%2.%3.%4").arg(major).arg(minor).arg(release).arg(build);
    }

    status = ::GetErrorStringA(err);
#endif
}

void VersionHandler::getFrontVersion(QString &result, QString &status)
{
    result = "-";
    status = "-";

#ifdef CCAUX
    quint8 major, minor, release, build;

    eErr err = ::AuxVersion_getFrontVersion(m_pAuxVersion, &major, &minor, &release, &build);
    if (err == eErr::ERR_SUCCESS)
    {
        result = QString("%1.%2.%3.%4").arg(major).arg(minor).arg(release).arg(build);
    }

    status = ::GetErrorStringA(err);
#endif
}

void VersionHandler::getFPGAVersion(QString &result, QString &status)
{
    result = "-";
    status = "-";

#ifdef CCAUX
    quint8 major, minor, release, build;

    eErr err = ::AuxVersion_getFPGAVersion(m_pAuxVersion, &major, &minor, &release, &build);
    if (err == eErr::ERR_SUCCESS)
    {
        result = QString("%1.%2.%3.%4").arg(major).arg(minor).arg(release).arg(build);
    }

    status = ::GetErrorStringA(err);
#endif
}

void VersionHandler::getAboutDisplayResolution(QString &result, QString &status)
{
    result = "-";
    status = "-";

#ifdef CCAUX
    char *buff = new char(100);

    eErr err = ::About_getDisplayResolution(m_pAbout, buff, 100);
    if (err == eErr::ERR_SUCCESS)
    {
        result = QString("%1").arg(buff);
    }

    free(buff);

    status = ::GetErrorStringA(err);
#endif
}

void VersionHandler::getAboutIsTouchScreenAvailable(QString &result, QString &status)
{
    result = "-";
    status = "-";

#ifdef CCAUX
    bool isAvailable;

    eErr err = ::About_getIsTouchScreenAvailable(m_pAbout, &isAvailable);
    if (err == eErr::ERR_SUCCESS)
    {
        result = isAvailable ? "Yes" : "No";
    }

    setHasTouch(isAvailable);

    status = ::GetErrorStringA(err);
#endif
}

void VersionHandler::getAboutUnitSerial(QString &result, QString &status)
{
    result = "-";
    status = "-";

#ifdef CCAUX
    char *buff = new char(100);

    eErr err = ::About_getUnitSerial(m_pAbout, buff, 100);
    if (err == eErr::ERR_SUCCESS)
    {
        result = QString("%1").arg(buff);
    }

    free(buff);

    status = ::GetErrorStringA(err);
#endif
}

void VersionHandler::getAboutProductRev(QString &result, QString &status)
{
    result = "-";
    status = "-";

#ifdef CCAUX
    char *buff = new char(100);

    eErr err = ::About_getMainProdRev(m_pAbout, buff, 100);
    if (err == eErr::ERR_SUCCESS)
    {
        result = QString("%1").arg(buff);
    }

    free(buff);

    status = ::GetErrorStringA(err);
#endif
}

void VersionHandler::getAboutManufacturingDate(QString &result, QString &status)
{
    result = "-";
    status = "-";

#ifdef CCAUX
    char *buff = new char(100);

    eErr err = ::About_getMainManufacturingDate(m_pAbout, buff, 100);
    if (err == eErr::ERR_SUCCESS)
    {
        result = QString("%1").arg(buff);
    }

    free(buff);

    status = ::GetErrorStringA(err);
#endif
}

void VersionHandler::getAboutNumberOfHwButtons(QString &result, QString &status)
{
    result = "-";
    status = "-";

#ifdef CCAUX
    int number;

    eErr err = ::About_getNrOfButtons(m_pAbout, &number);
    if (err == eErr::ERR_SUCCESS)
    {
        result = QString("%1").arg(number);
    }

    status = ::GetErrorStringA(err);
#endif
}
