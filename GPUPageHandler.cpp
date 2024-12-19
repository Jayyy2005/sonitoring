#include "GPUPageHandler.h"
#include <QDebug>
#include <cstdlib> // Für std::rand

GPUPageHandler::GPUPageHandler(QObject *parent)
    : QObject(parent), m_gpuUsage(0.0f), m_usageTimer(new QTimer(this)) {
    fetchGPUInfo(); // GPU-Modellinformationen bei der Initialisierung abrufen

    connect(m_usageTimer, &QTimer::timeout, this, &GPUPageHandler::fetchGPUUsage);
    m_usageTimer->start(1000); // GPU-Nutzung jede Sekunde aktualisieren
}

GPUPageHandler::~GPUPageHandler() {
    if (m_usageTimer) {
        m_usageTimer->stop();
        delete m_usageTimer;
    }
}

QString GPUPageHandler::gpuModel() const {
    return m_gpuModel;
}

float GPUPageHandler::gpuUsage() const {
    return m_gpuUsage;
}

void GPUPageHandler::fetchGPUInfo() {
    QProcess *process = new QProcess(this);
    connect(process, &QProcess::finished, this, &GPUPageHandler::onFetchFinished);

    // WMI-Befehl ausführen, um das GPU-Modell abzurufen
    process->start("wmic", QStringList() << "path" << "win32_videocontroller" << "get" << "caption");
}

void GPUPageHandler::onFetchFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    QProcess *process = qobject_cast<QProcess *>(sender());
    if (exitStatus == QProcess::CrashExit || exitCode != 0) {
        m_gpuModel = "Fehler beim Abrufen der GPU-Informationen";
    } else {
        QString output = process->readAllStandardOutput().trimmed();
        QStringList lines = output.split("\n");
        if (lines.size() > 1) {
            m_gpuModel = lines[1].trimmed(); // GPU-Namen extrahieren
        } else {
            m_gpuModel = "Unbekannte GPU";
        }
    }
    emit gpuModelChanged(); // UI über die Aktualisierung des GPU-Modells benachrichtigen
    process->deleteLater();
}

void GPUPageHandler::fetchGPUUsage() {
    // GPU-Nutzungsprozentsatz für Demonstrationszwecke simulieren
    m_gpuUsage = static_cast<float>(std::rand() % 101); // Zufallszahl zwischen 0 und 100
    emit gpuUsageChanged();
}
