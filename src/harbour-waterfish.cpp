#include <QtQuick>
#include <sailfishapp.h>
#include <QQuickView>
#include <QQmlEngine>
#include <nemonotifications-qt5/notification.h>

#include "settings.h"


int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->rootContext()->setContextProperty("appVersion", 1.2);
    view->rootContext()->setContextProperty("appBuildNum", 20);
    qmlRegisterType<Settings>("harbour.waterfish.settings", 1, 0, "Settings");
    view->setSource(SailfishApp::pathTo("qml/harbour-waterfish.qml"));
    view->show();
    return app->exec();
}

