#include "settings.h"
#include <QDebug>

const QString Settings::SETTING_AMOUNT = "amount";
const QString Settings::SETTING_AMOUNT_TODAY = "amount.today";
const QString Settings::SETTING_AMOUNT_PER_DAY  = "amount.per.day";
const QString Settings::SETTING_DATE_STARTED = "date.start";


Settings::Settings(QObject *parent)
    : QObject(parent)
    , m_settings(new QSettings(QSettings::UserScope,"com.sro.waterfish","harbour-waterfish",this))
{
}

int Settings::amountToday()
{
    // If day has changed, reset amount today value.
    QDate today;
    today = QDate::currentDate();
    if (startDate() != today)
    {
        setStartDate(today);
        setAmountToday(0);
        return 0;
    }
    return m_settings->value(SETTING_AMOUNT_TODAY,0).toInt();
}

int Settings::valueInt(const QString &key, const int defaultValue) const
{
    return value(key,defaultValue).toInt();
}

void Settings::setValue(const QString &key, const QVariant &value)
{
    qDebug() << "Setting value: " << value << " with key: " << key;
    m_settings->setValue(key,value);
    m_settings->sync();
}

QVariant Settings::value(const QString &key, const QVariant &defaultValue) const
{
    qDebug() << "getting value with key" << key;
    return m_settings->value(key,defaultValue);
}


