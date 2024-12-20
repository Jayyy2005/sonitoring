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
    // Logik für die Gesamt-RAM-Informationen verwenden
    QProcess *process = new QProcess(this);
    connect(process, &QProcess::finished, this, &RAMPageHandler::onFetchFinished);
    process->start("wmic", QStringList() << "memorychip" << "get" << "capacity");
}

void RAMPageHandler::fetchRAMUsage()
{
    // Tatsächliche RAM-Nutzungsprozentsätze ermitteln
    MEMORYSTATUSEX memStatus;
    memStatus.dwLength = sizeof(memStatus);
    GlobalMemoryStatusEx(&memStatus); // Ruft den Status des Arbeitsspeichers ab
    m_ramUsage = static_cast<float>(memStatus.dwMemoryLoad); // Verwendeter RAM in Prozent
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
