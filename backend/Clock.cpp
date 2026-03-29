#include "Clock.h"
#include <QLocale>

Clock::Clock(QObject *parent)
    : QObject(parent),
      m_currentDateTime(QDateTime::currentDateTime())
{
    connect(&m_timer, &QTimer::timeout, this, &Clock::tick);
    m_timer.start(1000);
}

QString Clock::currentTime() const
{
    return m_currentDateTime.toString("hh:mm");
}

QString Clock::currentDate() const
{
    return QLocale::system().toString(m_currentDateTime.date(), "ddd, dd MMM yyyy");
}

int Clock::currentYear() const
{
    return m_currentDateTime.date().year();
}

int Clock::currentMonth() const
{
    return m_currentDateTime.date().month();
}

int Clock::currentDay() const
{
    return m_currentDateTime.date().day();
}

int Clock::currentHour() const
{
    return m_currentDateTime.time().hour();
}

int Clock::currentMinute() const
{
    return m_currentDateTime.time().minute();
}

bool Clock::setDateTimeParts(int year, int month, int day, int hour, int minute)
{
    const QDate date(year, month, day);
    const QTime time(hour, minute, 0);

    if (!date.isValid() || !time.isValid())
    {
        return false;
    }

    m_currentDateTime.setDate(date);
    m_currentDateTime.setTime(time);
    emitDateTimeSignals();
    return true;
}

void Clock::setTime(const QString &time)
{
    static const QStringList formats = {
        "hh:mm",
        "h:mm",
        "hh:mm:ss",
        "h:mm:ss",
        "hh:mm AP",
        "h:mm AP"
    };

    for (const QString &format : formats)
    {
        const QTime parsed = QTime::fromString(time, format);
        if (parsed.isValid())
        {
            m_currentDateTime.setTime(parsed);
            emitDateTimeSignals();
            return;
        }
    }
}

void Clock::setDate(const QString &date)
{
    static const QStringList formats = {
        "dd.MM.yyyy",
        "dd.MM.yy",
        "dd/MM/yyyy",
        "dd/MM/yy",
        "yyyy-MM-dd"
    };

    for (const QString &format : formats)
    {
        const QDate parsed = QDate::fromString(date, format);
        if (parsed.isValid())
        {
            m_currentDateTime.setDate(parsed);
            emitDateTimeSignals();
            return;
        }
    }
}

void Clock::tick()
{
    m_currentDateTime = m_currentDateTime.addSecs(1);
    emitDateTimeSignals();
}

void Clock::emitDateTimeSignals()
{
    emit dateTimeChanged();
    emit timeChanged();
    emit dateChanged();
}
