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
        QJsonArray jsonArray = json["pizza"].toArray();
        foreach (const QJsonValue & value, jsonArray)
        {
            if (value.isObject())
            {
                QJsonObject obj = value.toObject();
                this->name.push_back(obj["name"].toString());
                this->description.push_back(obj["description"].toString());
                this->price.push_back(obj["price"].toString());
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

QString JsonData::getDescription(qint32 num)
{
  return this->description.at(num);
}

QString JsonData::getPrice(qint32 num)
{
  return this->price.at(num);
}
