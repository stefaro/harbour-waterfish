#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QVariant>
#include <QSettings>
#include <QDate>

class Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QDate startDate READ startDate WRITE setStartDate NOTIFY startDateChanged)
    Q_PROPERTY(int amountToday READ amountToday WRITE setAmountToday NOTIFY amountTodayChanged)
    Q_PROPERTY(int amountPerDay READ amountPerDay WRITE setAmountPerDay NOTIFY amountPerDayChanged)
    Q_PROPERTY(int amount READ amount WRITE setAmount NOTIFY amountChanged)
    Q_PROPERTY(int hydrationLevel READ hydrationLevel)
    Q_PROPERTY(bool notificationsEnabled READ notificationsEnabled WRITE setNotificationsEnabled NOTIFY notificationsEnabledChanged)
    Q_PROPERTY(int notificationInterval READ notificationInterval WRITE setNotificationInterval NOTIFY notificationIntervalChanged)
public:
    QDate startDate() const {return m_settings->value(SETTING_DATE_STARTED,QDate::currentDate()).toDate();}
    int amountToday();
    int amountPerDay() const {return m_settings->value(SETTING_AMOUNT_PER_DAY,20).toInt();}
    int amount() const;
    int hydrationLevel();
    bool notificationsEnabled() const {return m_settings->value(SETTING_NOTIFICATIONS_ENABLED,true).toBool();}
    int notificationInterval() const {return m_settings->value(SETTING_NOTIFICATIONS_INTERVAL,1).toInt();}

    explicit Settings(QObject *parent = 0);

public slots:
    void setAmount(int value);
    void setAmountPerDay(int value){m_settings->setValue(SETTING_AMOUNT_PER_DAY,value);m_settings->sync();emit amountPerDayChanged();}
    void setAmountToday(int value){m_settings->setValue(SETTING_AMOUNT_TODAY,value);m_settings->sync();emit amountTodayChanged();}
    void setStartDate(const QDate & date){m_settings->setValue(SETTING_DATE_STARTED,date);m_settings->sync();emit startDateChanged();}
    void setNotificationsEnabled(bool value){m_settings->setValue(SETTING_NOTIFICATIONS_ENABLED,value);m_settings->sync();emit notificationsEnabledChanged();}
    void setNotificationInterval(int value){m_settings->setValue(SETTING_NOTIFICATIONS_INTERVAL,value);m_settings->sync();emit notificationIntervalChanged();}

signals:
    void startDateChanged();
    void amountTodayChanged();
    void amountPerDayChanged();
    void amountChanged();
    void notificationsEnabledChanged();
    void notificationIntervalChanged();

private:
    QSettings *m_settings;

    static const QString SETTING_AMOUNT;
    static const QString SETTING_AMOUNT_TODAY;
    static const QString SETTING_AMOUNT_PER_DAY;
    static const QString SETTING_DATE_STARTED;
    static const QString SETTING_NOTIFICATIONS_ENABLED;
    static const QString SETTING_NOTIFICATIONS_INTERVAL;
};

#endif // SETTINGS_H
