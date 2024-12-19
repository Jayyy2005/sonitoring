#include "RAMPageHandler.h"
#include <QDebug>
#include <QFile>
#include <sysinfoapi.h>

// Konstruktor
RAMPageHandler::RAMPageHandler(QObject *parent) : QObject(parent), m_ramUsage(0.0f)
{
    fetchRAMInfo(); // RAM-Modellinformationen beim Erstellen des Handlers abrufen

    // Timer für periodische RAM-Nutzungsaktualisierungen initialisieren
    m_usageTimer = new QTimer(this);
    connect(m_usageTimer, &QTimer::timeout, this, &RAMPageHandler::fetchRAMUsage);
    m_usageTimer->start(1000); // Alle 1 Sekunde aktualisieren
}

// Destruktor
RAMPageHandler::~RAMPageHandler()
{
    if (m_usageTimer) {
        m_usageTimer->stop();
        delete m_usageTimer;
    }
}

QString RAMPageHandler::totalMemory() const
{
    return m_totalMemory;
}

float RAMPageHandler::ramUsage() const
{
    return m_ramUsage;
}

void RAMPageHandler::fetchRAMInfo()
{
    // Plattform-spezifische Logik für die Gesamt-RAM-Informationen verwenden
#ifdef Q_OS_WIN
    QProcess *process = new QProcess(this);
    connect(process, &QProcess::finished, this, &RAMPageHandler::onFetchFinished);
    process->start("wmic", QStringList() << "memorychip" << "get" << "capacity");
#elif defined(Q_OS_UNIX)
    QFile memInfo("/proc/meminfo");
    if (!memInfo.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Fehler beim Öffnen der /proc/meminfo-Datei";
        return;
    }
    QString totalLine = memInfo.readLine();
    QStringList parts = totalLine.split(" ", Qt::SkipEmptyParts);
    if (parts.size() >= 2) {
        qulonglong kbMemory = parts[1].toULongLong();
        m_totalMemory = QString::number(kbMemory / (1024 * 1024)) + " GB";
    }
#endif
}

void RAMPageHandler::fetchRAMUsage()
{
    // Tatsächliche RAM-Nutzungsprozentsätze ermitteln
#ifdef Q_OS_WIN
    MEMORYSTATUSEX memStatus;
    memStatus.dwLength = sizeof(memStatus);
    GlobalMemoryStatusEx(&memStatus); // Ruft den Status des Arbeitsspeichers ab
    m_ramUsage = static_cast<float>(memStatus.dwMemoryLoad); // Verwendeter RAM in Prozent
#elif defined(Q_OS_UNIX)
    QFile memInfo("/proc/meminfo");
    if (memInfo.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qulonglong total = 0, free = 0, buffers = 0, cached = 0;
        QTextStream in(&memInfo);
        // Liest die ersten vier Zeilen für benötigte Informationen
        for (int i = 0; i < 4; ++i) {
            QStringList parts = in.readLine().split(" ", Qt::SkipEmptyParts);
            if (i == 0) total = parts[1].toULongLong();
            if (i == 1) free = parts[1].toULongLong();
            if (i == 2) buffers = parts[1].toULongLong();
            if (i == 3) cached = parts[1].toULongLong();
        }
        // Berechnet den benutzten RAM (Gesamt - frei - Buffers - Cached)
        qulonglong used = total - free - buffers - cached;
        m_ramUsage = 100.0f * static_cast<float>(used) / total; // RAM-Nutzung in Prozent
    }
#endif
    emit ramUsageChanged(); // Aktualisierte RAM-Nutzung an die UI senden
}

void RAMPageHandler::onFetchFinished(int exitCode, QProcess::ExitStatus exitStatus)
{
    QProcess *process = qobject_cast<QProcess *>(sender());
    if (exitStatus == QProcess::CrashExit || exitCode != 0) {
        m_totalMemory = "Fehler beim Abrufen der RAM-Informationen";
    } else {
        QString output = process->readAllStandardOutput().trimmed();
        QStringList lines = output.split("\n", Qt::SkipEmptyParts);
        if (lines.size() > 1) {
            m_totalMemory = lines[1].trimmed();
        } else {
            m_totalMemory = "Unbekannter RAM";
        }
    }
    emit totalMemoryChanged(); // Benachrichtige UI über die Änderung der Gesamt-RAM-Informationen
    process->deleteLater();
}
