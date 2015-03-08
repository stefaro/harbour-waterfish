#include <QtQuick>
#include <sailfishapp.h>
#include <QQuickView>
#include <QQmlEngine>



#include "settings.h"

int main(int argc, char *argv[])
{
    // For this example, wizard-generates single line code would be good enough,
    // but very soon it won't be enough for you anyway, so use this more detailed example from start
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());

    // That is how you can access version strings in C++. And pass them on to QML
    view->rootContext()->setContextProperty("appVersion", 1.00);
    view->rootContext()->setContextProperty("appBuildNum", 10);



//    Here's how you will add QML components whenever you start using them
//    Check https://github.com/amarchen/Wikipedia for a more full example
//    view->engine()->addImportPath(SailfishApp::pathTo("qml/components").toString());
    qmlRegisterType<Settings>("harbour.waterfish.settings", 1, 0, "Settings");
    view->setSource(SailfishApp::pathTo("qml/harbour-waterfish.qml"));



    view->show();

    return app->exec();
}

