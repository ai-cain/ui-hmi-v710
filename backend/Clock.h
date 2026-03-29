#ifndef CLOCK_H
#define CLOCK_H

#include <QDateTime>
#include <QObject>
#include <QString>
#include <QTimer>

class Clock : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentTime READ currentTime NOTIFY dateTimeChanged)
    Q_PROPERTY(QString currentDate READ currentDate NOTIFY dateTimeChanged)
    Q_PROPERTY(int currentYear READ currentYear NOTIFY dateTimeChanged)
    Q_PROPERTY(int currentMonth READ currentMonth NOTIFY dateTimeChanged)
    Q_PROPERTY(int currentDay READ currentDay NOTIFY dateTimeChanged)
    Q_PROPERTY(int currentHour READ currentHour NOTIFY dateTimeChanged)
    Q_PROPERTY(int currentMinute READ currentMinute NOTIFY dateTimeChanged)

public:
    explicit Clock(QObject *parent = nullptr);

    QString currentTime() const;
    QString currentDate() const;
    int currentYear() const;
    int currentMonth() const;
    int currentDay() const;
    int currentHour() const;
    int currentMinute() const;

    Q_INVOKABLE bool setDateTimeParts(int year, int month, int day, int hour, int minute);

public slots:
    void setTime(const QString &time);
    void setDate(const QString &date);

signals:
    void dateTimeChanged();
    void timeChanged();
    void dateChanged();

private slots:
    void tick();

private:
    void emitDateTimeSignals();

    QDateTime m_currentDateTime;
    QTimer m_timer;
};

#endif // CLOCK_H
