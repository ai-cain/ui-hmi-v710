#ifndef KEYEMITTER_H
#define KEYEMITTER_H

#include <QObject>
#include <QCoreApplication>
#include <QKeyEvent>
#include <QMap>
class KeyEmitter : public QObject
{
    Q_OBJECT
public:
    KeyEmitter(QObject* parent=nullptr) : QObject(parent) {}
    Q_INVOKABLE void keyPressed(QObject* obj, Qt::Key key, QString strKey) {
        QKeyEvent keyPressEvent = QKeyEvent(QEvent::Type::KeyPress, key, Qt::NoModifier, strKey);
        QCoreApplication::sendEvent(obj, &keyPressEvent);
    }   
};
#endif // KEYEMITTER_H
