#include "settings.h"
#include <QDebug>

Settings::Settings(QObject *parent)
    : QObject(parent)
    , m_settings(new QSettings(QSettings::UserScope,"com.sro.waterfish","harbour-waterfish",this))
{
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


