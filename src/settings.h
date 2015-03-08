#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QVariant>
#include <QSettings>

class Settings : public QObject
{
    Q_OBJECT
public:
    explicit Settings(QObject *parent = 0);

signals:

public slots:
    void setValue(const QString & key, const QVariant & value);
    QVariant value(const QString &key, const QVariant &defaultValue = QVariant()) const;
    int valueInt(const QString &key, const int defaultValue) const;
private:
    QSettings *m_settings;
};

#endif // SETTINGS_H
