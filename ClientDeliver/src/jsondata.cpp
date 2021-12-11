#include "jsondata.h"
#include <iostream>

JsonData::JsonData(QObject *parent) : QObject(parent)
{

}

void JsonData::jsonParse(QString JsonPath, QString JsonName)
{

    QString val;
    QFile file;
    QDir::setCurrent(JsonPath);
    file.setFileName(JsonName);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    val = file.readAll();
    file.close();

    QJsonDocument doc = QJsonDocument::fromJson(val.toUtf8());

    if (doc.isObject())
    {
        QJsonObject json = doc.object();
        QJsonArray jsonArray = json["orders"].toArray();
        foreach (const QJsonValue & value, jsonArray)
        {
            if (value.isObject())
            {
                QJsonObject obj = value.toObject();
                this->name.push_back(obj["name"].toString());
                this->id_order.push_back(obj["id_order"].toString());
                this->office_adress.push_back(obj["office_adress"].toString());
                this->order_adress.push_back(obj["order_adress"].toString());
                this->num += 1;
            }
        }
    }
}

qint32 JsonData::getNum()
{
  return this->num;
}

QString JsonData::getName(qint32 num)
{
  return this->name.at(num);
}

QString JsonData::getId_order(qint32 num)
{
  return this->id_order.at(num);
}

QString JsonData::getOffice_adress(qint32 num)
{
  return this->office_adress.at(num);
}

QString JsonData::getOrder_adress(qint32 num)
{
  return this->order_adress.at(num);
}
