// Clock.cpp
#include "Clock.h"
#include <QDateTime>
#include <QTimer>

Clock::Clock(QObject *parent) : QObject(parent)
{
    // Crear un temporizador que actualice la hora cada segundo
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &Clock::updateTime);
    timer->start(1000); // Actualiza cada segundo
}

QString Clock::currentTime() const
{
    return QDateTime::currentDateTime().toString("hh:mm:ss");
}

void Clock::updateTime()
{
    // Emitir la señal que indica que la hora ha cambiado
    emit timeChanged();
}
