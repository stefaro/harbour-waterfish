#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QVariant>
#include <QSettings>
#include <QDate>
#include <QDateTime>

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
    Q_PROPERTY(QDateTime lastDrinkTime READ lastDrinkTime WRITE setLastDrinkTime NOTIFY lastDrinkTimeChanged)
    Q_PROPERTY(bool shouldDrink READ shouldDrink)

public:
    QDate startDate();
    int amountToday();
    int amountPerDay() const;
    int amount() const;
    int hydrationLevel();
    bool notificationsEnabled() const;
    int notificationInterval() const;
    QDateTime lastDrinkTime() const;
    bool shouldDrink();

    explicit Settings(QObject *parent = 0);

    void updateLastDrinkTime();

    void checkIfDayChanged();

public slots:
    void setAmount(int value);
    void setAmountPerDay(int value);
    void setAmountToday(int value);
    void setStartDate(const QDate & date);
    void setNotificationsEnabled(bool value);
    void setNotificationInterval(int value);
    void setLastDrinkTime(const QDateTime & date);

signals:
    void startDateChanged();
    void amountTodayChanged();
    void amountPerDayChanged();
    void amountChanged();
    void notificationsEnabledChanged();
    void notificationIntervalChanged();
    void lastDrinkTimeChanged();

private:
    QSettings *m_settings;

    static const QString SETTING_AMOUNT;
    static const QString SETTING_AMOUNT_TODAY;
    static const QString SETTING_AMOUNT_PER_DAY;
    static const QString SETTING_DATE_STARTED;
    static const QString SETTING_NOTIFICATIONS_ENABLED;
    static const QString SETTING_NOTIFICATIONS_INTERVAL;
    static const QString SETTING_TIME_LAST_DRINK;
};

#endif // SETTINGS_H
