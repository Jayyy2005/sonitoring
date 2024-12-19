#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "GPUPageHandler.h"
#include "RAMPageHandler.h"
#include "CPUPageHandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // Erstelle Instanzen der Handler
    CPUPageHandler cpuPageHandler;
    GPUPageHandler gpuPageHandler;
    RAMPageHandler ramPageHandler;

    // Mache die Handler für QML verfügbar
    CPUPageHandler cpuHandler;
    engine.rootContext()->setContextProperty("cpuPageHandler", &cpuPageHandler);
    GPUPageHandler gpuHandler;
    engine.rootContext()->setContextProperty("gpuPageHandler", &gpuPageHandler);
    RAMPageHandler ramHandler;
    engine.rootContext()->setContextProperty("ramPageHandler", &ramPageHandler);

    // Lade die Haupt-QML-Datei
    engine.loadFromModule("sonitoring", "Main");

    return app.exec();
}
