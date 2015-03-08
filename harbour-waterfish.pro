# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-waterfish

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

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-waterfish-de.ts

HEADERS += \
    src/settings.h

RESOURCES += \
    harbour-waterfish.qrc

