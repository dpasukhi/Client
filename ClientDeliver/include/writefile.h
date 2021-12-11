#ifndef WRITEFILE_H
#define WRITEFILE_H
#include <QString>
#include <fstream>
#include <iostream>
#include <QObject>

class WriteFileJS : public QObject
{
Q_OBJECT
public:
  explicit WriteFileJS(QObject *parent = nullptr);
  Q_INVOKABLE bool setNewLine(QString office_address, QString order_address);
  Q_INVOKABLE bool reset();

  signals:
};

#endif // WRITEFILE_H
