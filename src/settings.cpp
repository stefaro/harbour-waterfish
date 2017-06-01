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

int Settings::amountToday()
{
    // If day has changed, reset amount today value.
    QDate today;
    today = QDate::currentDate();
    if (startDate() != today)
    {
        qDebug() << "day has changed, resetting values";
        setStartDate(today);
        setAmountToday(0);
        return 0;
    }
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
    bool drink = false;

    if (notificationsEnabled()){
        long seconds = 0;
        QDateTime dNow(QDateTime::currentDateTime());
        QDateTime last = lastDrinkTime();
        seconds = last.msecsTo(dNow)/1000;
        qDebug() << "last time drank was: " << seconds << "s ago";

        long requiredSeconds = notificationInterval()*60*60;
        if (seconds >= requiredSeconds){
            drink = true;
        }
    }

    return drink;
}

void Settings::setAmountToday(int value)
{
    m_settings->setValue(SETTING_AMOUNT_TODAY,value);
    setLastDrinkTime(QDateTime::currentDateTime());
    m_settings->sync();
    emit amountTodayChanged();
}

