#include "settings.h"
#include <QDebug>

const QString Settings::SETTING_AMOUNT = "amount";
const QString Settings::SETTING_AMOUNT_TODAY = "amount.today";
const QString Settings::SETTING_AMOUNT_PER_DAY  = "amount.per.day";
const QString Settings::SETTING_DATE_STARTED = "date.start";
const QString Settings::SETTING_NOTIFICATIONS_ENABLED = "notifications.enabled";
const QString Settings::SETTING_NOTIFICATIONS_INTERVAL = "notifications.interval";


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
