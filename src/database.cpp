#include "database.h"


Database::Database(QObject *parent) : QObject(parent)
{
    db = new QSqlDatabase(QSqlDatabase::addDatabase("QSQLITE"));
    QString path(QStandardPaths::writableLocation( QStandardPaths::AppDataLocation ));
    qDebug() << "SQLite db location " << path;
    QDir dir(path);
    if (dir.exists()==false){
        qDebug() << "creating app data directory";
        dir.mkpath(".");
    }
    db->setDatabaseName(path+"/"+"statistics.sqlite");
    if (db->open()){
        qDebug() << "db is open";
        initialize();
        purgeOldRecords();
    }else {
        qCritical() << "Cannot open statistics db!!";
    }
}

void Database::saveStatistics(QVariant value,QVariant target)
{
    QSqlQuery query;
    query.prepare("insert or replace into stats "
                  "(value, target)"
                  " values (:value, :target);");
    query.bindValue(":value",value);
    query.bindValue(":target",target);

    if (query.exec()){
        qDebug() << "successfully saved statistics row";
    }else {
        qCritical() << "cannot save statistics row!";
    }
}

void Database::initialize()
{
    qDebug() << "initializing db";
    QSqlQuery query;
    bool success =
    query.exec(
                "create table stats (time datetime primary key default current_timestamp, value integer, target integer)"
                );
    if (success){
        qDebug() << "db initialized successfully";
        db->commit();
    }else{
        qCritical() << "cannot initialize db! Probably already exists...";
    }
}

void Database::purgeOldRecords()
{
    qDebug() << "Removing records older than 6 months";
    QSqlQuery query;
    bool success =
    query.exec("Delete from stats where time <= date('now', '-180 day');");

    if (success){
        qDebug() << "Old records successfully removed";
        db->commit();
    }else{
        qCritical() << "Cannot remove old records.";
    }
}

QVariantList Database::getStatistics()
{
    QVariantMap map;
    QVariantList list;
    QSqlQuery query;
    query.exec("select strftime('%s',time) as time,value,target from stats;");

    if (query.exec()){
        map.clear();
        while(query.next()){
            map.insert("time",query.record().value("time").toLongLong()*1000);
            map.insert("value",query.record().value("value").toInt());
            map.insert("target",query.record().value("target").toInt());
            list.append(map);
        }
    }

    return list;
}
