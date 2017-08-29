TARGET = harbour-waterfish
QT += dbus
QT += sql
CONFIG += sailfishapp
SOURCES += src/harbour-waterfish.cpp \
    src/settings.cpp \
    src/database.cpp

OTHER_FILES += qml/harbour-waterfish.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-waterfish.changes.in \
    rpm/harbour-waterfish.spec \
    rpm/harbour-waterfish.yaml \
    translations/*.ts \
    harbour-waterfish.desktop \
    qml/pages/AboutPage.qml \
    qml/components\LinePlot.qml

CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-waterfish-de.ts
TRANSLATIONS += translations/harbour-waterfish-fr.ts
TRANSLATIONS += translations/harbour-waterfish-fi.ts

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

HEADERS += \
    src/settings.h \
    src/database.h

RESOURCES += \
    harbour-waterfish.qrc

DISTFILES += \
    qml/pages/SettingsPage.qml \
    qml/pages/StatisticsPage.qml

