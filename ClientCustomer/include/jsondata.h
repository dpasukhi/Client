#ifndef JSONDATA_H
#define JSONDATA_H

#include <QVector>
#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonValue>
#include <QJsonParseError>
#include <QFile>
#include <QDir>

class JsonData : public QObject
{
    Q_OBJECT
public:
    explicit JsonData(QObject *parent = nullptr);

    void jsonParse(QString JsonPath, QString JsonName);

    Q_INVOKABLE qint32 getNum();
    Q_INVOKABLE QString getName(qint32 num);
    Q_INVOKABLE QString getDescription(qint32 num);
    Q_INVOKABLE QString getPrice(qint32 num);
    QStringList getDataOffice();

private:
    qint8 num = 0;
    QVector <QString> name;
    QVector <QString> description;
    QVector <QString> price;
    QStringList office;

signals:

};

#endif // JSONDATA_H
