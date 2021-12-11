QT += quick
QT += core gui network
QT += quick webview

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

VPATH += ./src

SOURCES += \
    src/main.cpp \
    src/changefilejs.cpp \
    src/jsondata.cpp \
    src/writefile.cpp \
    src/clientdeliverapi.cpp

HEADERS += \
    include/changefilejs.h \
    include/jsondata.h \
    include/writefile.h \
    include/clientdeliverapi.h

INCLUDEPATH = ./include/

RESOURCES += ./qml/qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
  /qml/DeliverUI.qml \
  /qml/DeliverUIForm.ui.qml

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../ClientCore/release/ -lClientCore
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../ClientCore/debug/ -lClientCore
else:unix: LIBS += -L$$OUT_PWD/../ClientCore/ -lClientCore

INCLUDEPATH += $$PWD/../ClientCore/include/
DEPENDPATH += $$PWD/../ClientCore/src/
