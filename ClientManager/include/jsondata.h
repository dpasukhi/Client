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
    Q_INVOKABLE QString getId_order(qint32 num);
    Q_INVOKABLE QString getOffice_adress(qint32 num);
    Q_INVOKABLE QString getOrder_adress(qint32 num);
    Q_INVOKABLE QString getData_order(qint32 num);
    Q_INVOKABLE QString getName_deliver(qint32 num);
    Q_INVOKABLE QString getName_client(qint32 num);

private:
    qint8 num = 0;
    QVector <QString> name;
    QVector <QString> id_order;
    QVector <QString> office_adress;
    QVector <QString> order_adress;
    QVector <QString> data_order;
    QVector <QString> name_deliver;
    QVector <QString> name_client;

signals:

};

#endif // JSONDATA_H
