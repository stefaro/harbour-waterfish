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
public:
    QDate startDate() const {return m_settings->value(SETTING_DATE_STARTED,QDate::currentDate()).toDate();}
    int amountToday();
    int amountPerDay() const {return m_settings->value(SETTING_AMOUNT_PER_DAY,20).toInt();}
    int amount() const {return m_settings->value(SETTING_AMOUNT,0).toInt();}
    int hydrationLevel();

    explicit Settings(QObject *parent = 0);

public slots:
    void setAmount(int value){m_settings->setValue(SETTING_AMOUNT,value);m_settings->sync();emit amountChanged();}
    void setAmountPerDay(int value){m_settings->setValue(SETTING_AMOUNT_PER_DAY,value);m_settings->sync();emit amountPerDayChanged();}
    void setAmountToday(int value){m_settings->setValue(SETTING_AMOUNT_TODAY,value);m_settings->sync();emit amountTodayChanged();}
    void setStartDate(const QDate & date){m_settings->setValue(SETTING_DATE_STARTED,date);m_settings->sync();emit startDateChanged();}

signals:
    void startDateChanged();
    void amountTodayChanged();
    void amountPerDayChanged();
    void amountChanged();

private:
    QSettings *m_settings;

    static const QString SETTING_AMOUNT;
    static const QString SETTING_AMOUNT_TODAY;
    static const QString SETTING_AMOUNT_PER_DAY;
    static const QString SETTING_DATE_STARTED;
};

#endif // SETTINGS_H
