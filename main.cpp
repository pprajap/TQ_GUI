#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "CppInterface.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    CppInterface cppInterface;
    engine.rootContext()->setContextProperty("cppInterface", &cppInterface);

    engine.load(QUrl(QStringLiteral("qrc:/TQ_GUI/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
