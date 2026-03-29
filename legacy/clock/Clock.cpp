#include "Clock.h"
#include <QDateTime>
#include <QTimer>

Clock::Clock(QObject *parent) : QObject(parent)
{
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &Clock::updateTime);
    connect(timer, &QTimer::timeout, this, &Clock::updateDate);
    timer->start(1000); // Intervalo de 1000 ms = 1 segundo

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

void Clock::setTime(const QString &time)
{
    m_currentTime = time;
    emit timeChanged();
}

void Clock::setDate(const QString &date)
{
    m_currentDate = date;
    emit dateChanged();
}

void Clock::updateTime()
{
    //m_currentTime = QDateTime::currentDateTime().toString("hh:mm:ss"); //0-23h
    //m_currentTime = QDateTime::currentDateTime().toString("hh:mm:ss ap"); //AP->AM-PM, ap -> am pm
    //m_currentTime = QDateTime::currentDateTime().toString("hh:mm:ss a").toLower();

    QString timeStr = QDateTime::currentDateTime().toString("hh:mm:ss a"); //la hora en formato de 12 horas con AM/PM
    timeStr.replace("am", "a.m.");// Reemplaza AM/PM por a.m./p.m.
    timeStr.replace("pm", "p.m.");
    m_currentTime = timeStr;// Asigna el resultado a m_currentTime

    emit timeChanged();
}

void Clock::updateDate()
{
    m_currentDate = QDateTime::currentDateTime().toString("dd.MM.yy");
    emit dateChanged();
}
