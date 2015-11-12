#include <QtQuick>
#include <sailfishapp.h>
#include <QQuickView>
#include <QQmlEngine>

#include "settings.h"

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->rootContext()->setContextProperty("appVersion", 1.1);
    view->rootContext()->setContextProperty("appBuildNum", 10);
    qmlRegisterType<Settings>("harbour.waterfish.settings", 1, 0, "Settings");
    view->setSource(SailfishApp::pathTo("qml/harbour-waterfish.qml"));
    view->show();
    return app->exec();
}

