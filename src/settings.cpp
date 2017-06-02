#include "settings.h"
#include <QDebug>

const QString Settings::SETTING_AMOUNT = "amount";
const QString Settings::SETTING_AMOUNT_TODAY = "amount.today";
const QString Settings::SETTING_AMOUNT_PER_DAY  = "amount.per.day";
const QString Settings::SETTING_DATE_STARTED = "date.start";
const QString Settings::SETTING_NOTIFICATIONS_ENABLED = "notifications.enabled";
const QString Settings::SETTING_NOTIFICATIONS_INTERVAL = "notifications.interval";
const QString Settings::SETTING_TIME_LAST_DRINK = "date.last.drink";

Settings::Settings(QObject *parent)
    : QObject(parent)
    , m_settings(new QSettings(QSettings::UserScope,"harbour-waterfish","harbour-waterfish",this))
{
}

int Settings::hydrationLevel()
{
    return double(amountToday())/double(amountPerDay())*100.0;
}

void Settings::checkIfDayChanged()
{
    QDate today = QDate::currentDate();
    QDate start = startDate();
    qDebug() << "comparing start date ("
             << start <<") to current date (" << today << ")";

    if (start != today)
    {
        qDebug() << "day has changed, resetting values";
        setStartDate(today);
        setAmountToday(0);
    }
}

int Settings::amountToday()
{
    // If day has changed, reset amount today value.
    checkIfDayChanged();
    return m_settings->value(SETTING_AMOUNT_TODAY,0).toInt();
}


void Settings::setAmount(int value)
{
    qDebug() << "Changing amount value to" << value;
    m_settings->setValue(SETTING_AMOUNT,value);
    m_settings->sync();
    emit amountChanged();
}
int Settings::amount() const
{
    int val = m_settings->value(SETTING_AMOUNT,1).toInt();
    qDebug() << "Getting amount value "<< val;
    return val;
}

bool Settings::shouldDrink()
{
    checkIfDayChanged();

    if (notificationsEnabled()){
        long seconds = 0;
        QDateTime dNow(QDateTime::currentDateTime());
        QDateTime last = lastDrinkTime();
        seconds = last.msecsTo(dNow)/1000;
        qDebug() << "last time drank was: " << seconds << "s ago";

        long requiredSeconds = notificationInterval()*60*60;
        if (seconds >= requiredSeconds){
            qDebug() << "user should be notified";
            return true;
        }
        qDebug() << "No need to notify user now.";
    }
    return false;
}

void Settings::setAmountToday(int value)
{
    m_settings->setValue(SETTING_AMOUNT_TODAY,value);
    updateLastDrinkTime();
    m_settings->sync();
    emit amountTodayChanged();
}

void Settings::updateLastDrinkTime()
{
    setLastDrinkTime(QDateTime::currentDateTime());
}
void Settings::setAmountPerDay(int value)
{
    m_settings->setValue(SETTING_AMOUNT_PER_DAY,value);
    m_settings->sync();
    emit amountPerDayChanged();
}
void Settings::setStartDate(const QDate & date)
{
    m_settings->setValue(SETTING_DATE_STARTED,date);
    m_settings->sync();
    emit startDateChanged();
}
void Settings::setNotificationsEnabled(bool value)
{
    m_settings->setValue(SETTING_NOTIFICATIONS_ENABLED,value);
    m_settings->sync();
    emit notificationsEnabledChanged();
}
void Settings::setNotificationInterval(int value)
{
    m_settings->setValue(SETTING_NOTIFICATIONS_INTERVAL,value);
    m_settings->sync();
    emit notificationIntervalChanged();
}
void Settings::setLastDrinkTime(const QDateTime & date)
{
    m_settings->setValue(SETTING_TIME_LAST_DRINK,date);
    m_settings->sync();
    emit lastDrinkTimeChanged();
}
bool Settings::notificationsEnabled() const
{
    return m_settings->value(SETTING_NOTIFICATIONS_ENABLED,true).toBool();
}
int Settings::notificationInterval() const
{
    return m_settings->value(SETTING_NOTIFICATIONS_INTERVAL,1).toInt();
}
QDateTime Settings::lastDrinkTime() const
{
    return m_settings->value(SETTING_TIME_LAST_DRINK,QDateTime::currentDateTime()).toDateTime();
}
int Settings::amountPerDay() const
{
    return m_settings->value(SETTING_AMOUNT_PER_DAY,20).toInt();
}
QDate Settings::startDate()
{
    QDate date = m_settings->value(SETTING_DATE_STARTED,QDate(1,1,1970)).toDate();
    if (date == QDate(1,1,1970)){
        qDebug() <<"no start date set.. setting today as start date";
        date = QDate::currentDate();
        setStartDate(date);
        emit startDateChanged();
    }
    return date;
}
