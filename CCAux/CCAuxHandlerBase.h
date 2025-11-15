/******************************************************************************
 *
 * File:        CCAuxHandlerBase.h
 *
 * Description: This file contains the base class for CCAux handlers, with
 * shared error handling.
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
#ifndef CCAUXHANDLERBASE_H
#define CCAUXHANDLERBASE_H

/******************************************************************************
 * Include Files
******************************************************************************/
#include <QDebug>
#include <QObject>

/* We are using an ifdef here in order to exclude all references to CCAux when
 * running in virtual Linux environment. This is handy when developing the UI
 * parts without the need of the actual hardware. See the project *.pro file
 * for further details about how CCAUX is defined for a specific display. */
#ifdef CCAUX
#include <CCAuxErrors.h>

using namespace CrossControl;
#endif

/******************************************************************************
 * Class Declaration
******************************************************************************/
/**
 * @brief VersionHandler class that takes care of the interaction between
 * the user interface and CCAux "Version" and "About" objects and exposes
 * a list of VersionItems to be presented in the UI.
 */
class CCAuxHandlerBase : public QObject
{
    Q_OBJECT

    /**
    * @brief Get the error message from the latest CCAux operation.
    */
    Q_PROPERTY(QString lastError READ lastError NOTIFY lastErrorChanged)

public:
    /**
    * @brief Constructor.
    */
    explicit CCAuxHandlerBase(QObject *parent = 0)
        : QObject(parent)
    {
#ifdef CCAUX
        m_err = ::eErr::ERR_SUCCESS;
#endif
    }

    /**
    * @brief Destructor.
    */
    ~CCAuxHandlerBase() {}

signals:
    void lastErrorChanged();

protected:
    /**
    * @brief Gets the error description from the last CCAux operation.
    * @return The error message string of the error.
    */
    QString lastError()
    {
        QString msg = "No CCAux available";

#ifdef CCAUX
        msg = ::GetErrorStringA(m_err);
#endif

        return msg;
    }

    /**
    * @brief Sets the error code and descrition from the last CCAux operation.
    * @param code [in] Error code to set error message from.
    */
    void setLastErrorCode(uint code)
    {
#ifdef CCAUX
        if (m_err != code)
        {
            m_err = eErr(code);

            emit lastErrorChanged();
        }
#else
        qDebug() << "No CCAux available (code = " << code << ")";
#endif
    }

#ifdef CCAUX
    eErr m_err;
#endif
};

#endif // CCAUXHANDLERBASE_H
