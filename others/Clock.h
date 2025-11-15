#ifndef CLOCK_H
#define CLOCK_H

#include <QObject>
#include <QString>

class Clock : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentTime READ currentTime NOTIFY timeChanged)
    Q_PROPERTY(QString currentDate READ currentDate NOTIFY dateChanged)

public:
    explicit Clock(QObject *parent = nullptr);

    QString currentTime() const;
    QString currentDate() const;

public slots:
    void setTime(const QString &time);
    void setDate(const QString &date);

signals:
    void timeChanged();
    void dateChanged();

private slots:
    void updateTime();
    void updateDate();

private:
    QString m_currentTime;
    QString m_currentDate;
};

#endif // CLOCK_H
