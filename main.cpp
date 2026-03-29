/******************************************************************************
 *
 * File:        main.cpp
 *
 * Description: This is the main class file where the application main function
 * is implemented, containing intialization of the application and its handlers.
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
#include <QGuiApplication>
#include <QQuickItem>
#include <QQuickView>
#include <QtQml>
#include <QDebug>
#include <QDateTime>

#include "CCAux/BackLightHandler.h"
#include "CCAux/BuzzerHandler.h"
#include "CCAux/FrontLedHandler.h"
#include "CCAux/PowerConfigHandler.h"
#include "CCAux/VersionHandler.h"
#include "backend/appstate.h"
#include "backend/backend.h"
#include "legacy/clock/Clock.h"

#include "legacy/keyboard/keyEmitter.h"

/******************************************************************************
 * The Main.
******************************************************************************/

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qDebug()<< QDateTime::currentDateTime();

    QQmlApplicationEngine engine;
    KeyEmitter keyEmitter;

    MyAppState::init();

    // instanciamos para la hora el clocl
    Clock clock;
    // Set la propiedad
    engine.rootContext()->setContextProperty("clock", &clock);
    engine.rootContext()->setContextProperty("keyEmitter", &keyEmitter);

    FrontLedHandler frontLedHandler;
    frontLedHandler.init();
    qmlRegisterUncreatableType<FrontLedHandler>("CrossControl", 1, 0, "FrontLedHandler", "Don't instance");
    engine.rootContext()->setContextProperty("frontLedHandler", &frontLedHandler);

    VersionHandler versionHandler;
    versionHandler.init();
    qmlRegisterUncreatableType<VersionHandler>("CrossControl", 1, 0, "VersionHandler", "Don't instance");
    engine.rootContext()->setContextProperty("versionHandler", &versionHandler);

    PowerConfigHandler powerConfigHandler;
    powerConfigHandler.init();
    qmlRegisterUncreatableType<PowerConfigHandler>("CrossControl", 1, 0, "PowerConfigHandler", "Don't instance");
    engine.rootContext()->setContextProperty("powerConfigHandler", &powerConfigHandler);



    BuzzerHandler buzzerHandler;
    buzzerHandler.init();
    qRegisterMetaType<BuzzerHandler::Tone>("BuzzerHandler::Tone");
    qmlRegisterType<BuzzerHandler>("MyQmlModule", 1, 0, "BuzzerHandler");
    engine.rootContext()->setContextProperty("buzzerHandler", &buzzerHandler);


    BackLightHandler backLightHandler;
    backLightHandler.init();
    qmlRegisterUncreatableType<BackLightHandler>("CrossControl", 1, 0, "BackLightHandler", "Don't instance");
    engine.rootContext()->setContextProperty("backLightHandler", &backLightHandler);


    BackEnd backEnd;
    backEnd.init();
    qmlRegisterUncreatableType<BackEnd>("CrossControl", 1, 0, "BackEnd", "Don't instance");

    engine.rootContext()->setContextProperty("backEnd", &backEnd);



    /*time_t initialTime;
    struct tm * timeinfo;
    err = Smart_getInitialTime(pSmart, &initialTime);
    if (ERR_SUCCESS ==err){
        timeinfo = localtime( &initialTime);
        std::cout<< asctime(timeinfo)<<endl;
    }*/

    const QUrl url("qrc:/UiHmiV710/main.qml");
    /*QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);*/
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);


    return app.exec();
}
