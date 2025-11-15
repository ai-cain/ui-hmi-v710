#include "Clock.h"
#include <QDateTime>
#include <QTimer>

Clock::Clock(QObject *parent) : QObject(parent)
{
    // Crea un temporizador para actualizar la hora y la fecha cada segundo
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &Clock::updateTime);
    connect(timer, &QTimer::timeout, this, &Clock::updateDate);
    timer->start(1000); // Intervalo de 1000 ms = 1 segundo

    // Inicializa la hora y la fecha al crear el objeto
    updateTime();
    updateDate();
}

QString Clock::currentTime() const
{
    return m_currentTime;
}

QString Clock::currentDate() const
{
    return m_currentDate;
}

void Clock::updateTime()
{
    m_currentTime = QDateTime::currentDateTime().toString("hh:mm:ss");
    emit timeChanged();
}

void Clock::updateDate()
{
    m_currentDate = QDateTime::currentDateTime().toString("dd.MM.yy");
    emit dateChanged();
}
