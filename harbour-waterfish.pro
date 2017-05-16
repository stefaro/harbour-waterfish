TARGET = harbour-waterfish
QT += dbus
CONFIG += sailfishapp
SOURCES += src/harbour-waterfish.cpp \
    src/settings.cpp

OTHER_FILES += qml/harbour-waterfish.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-waterfish.changes.in \
    rpm/harbour-waterfish.spec \
    rpm/harbour-waterfish.yaml \
    translations/*.ts \
    harbour-waterfish.desktop \
    qml/pages/AboutPage.qml

#CONFIG += sailfishapp_i18n
#TRANSLATIONS += translations/harbour-waterfish-de.ts

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

HEADERS += \
    src/settings.h

RESOURCES += \
    harbour-waterfish.qrc
