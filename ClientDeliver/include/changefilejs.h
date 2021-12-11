#ifndef CHANGEFILEJS_H
#define CHANGEFILEJS_H

#include <QObject>
#include <QString>
#include <fstream>
#include <iostream>

class ChangeFileJS : public QObject
{
  Q_OBJECT
public:
  explicit ChangeFileJS(QObject *parent = nullptr);
  Q_INVOKABLE bool setNewLine(QString office_address, QString order_address);
  Q_INVOKABLE bool reset();

signals:

};

#endif // CHANGEFILEJS_H
