/******************************************************************************
 *
 * File:        ipaddress.h
 *
 * Description: Contains class to detect IP adresses from IPv4 interface
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
#ifndef IPADDRESS_H
#define IPADDRESS_H

/******************************************************************************
 * Include Files
******************************************************************************/
#include <QNetworkInterface>

/******************************************************************************
 * Class Declaration
******************************************************************************/
/**
 * @brief IpAdress class to detect IP address from a given IPv4 interface
 */
class IpAddress
{

public:
    /**
    * @brief Constructor
    */
    IpAddress() {}

    /**
    * @brief Returns the IP adress on the well-known format a.b.c.d from a given IPv4 interface.
    * @param interface [in] Interface string on the form "ethX" where X = 0,1,...
    * @return The detected IP adress, "" if not found.
    */
    QString get(QString interface)
    {
        QList<QNetworkAddressEntry> list = QNetworkInterface::interfaceFromName(interface).addressEntries();
        QString s;

        foreach (QNetworkAddressEntry a, list)
        {
            if (a.ip().protocol() == QAbstractSocket::IPv4Protocol)
                s = a.ip().toString();
        }

        return s;
    }
};

#endif // IPADDRESS_H
