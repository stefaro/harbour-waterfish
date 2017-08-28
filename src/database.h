#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QtSql>

class Database : public QObject
{
    Q_OBJECT
public:
    explicit Database(QObject *parent = 0);

signals:

public slots:
    void saveStatistics(QVariant value, QVariant target);
    QVariantList getStatistics();

private:
    static const QString DB_NAME;
    QSqlDatabase *db;
    Q_DISABLE_COPY(Database)
    void initialize();
    void purgeOldRecords();
};

#endif // DATABASE_H
