//main.cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "keyEmitter.h"

int main(int argc, char *argv[])
{
  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;
  const QUrl url(QStringLiteral("qrc:/CustomKey/main.qml"));
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

  KeyEmitter keyEmitter;
  engine.rootContext()->setContextProperty("keyEmitter", &keyEmitter);

  return app.exec();
}
