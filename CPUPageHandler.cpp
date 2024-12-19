#include "CPUPageHandler.h"
#include <QDebug>
#include <QTimer>
#include <QProcess>
#include <QThread>

CPUPageHandler::CPUPageHandler(QObject *parent)
    : QObject(parent), m_cpuUsage(0.0f), hQuery(nullptr), hCounter(nullptr) {
    // CPU-Informationen abrufen, wenn der Handler erstellt wird
    fetchCPUInfo();

    // PDH-Abfrage und Zähler initialisieren
    PDH_STATUS status = PdhOpenQuery(NULL, 0, &hQuery);
    if (status != ERROR_SUCCESS) {
        qWarning() << "Fehler beim Öffnen der PDH-Abfrage. Fehlercode:" << status;
        return;
    }

    status = PdhAddCounter(hQuery, L"\\Processor Information(_Total)\\% Processor Time", 0, &hCounter);
    if (status != ERROR_SUCCESS) {
        qWarning() << "Fehler beim Hinzufügen des PDH-Zählers. Fehlercode:" << status;
        PdhCloseQuery(hQuery);
        hQuery = nullptr;
        return;
    }

    // Timer einrichten, um die CPU-Nutzung periodisch abzurufen
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &CPUPageHandler::fetchCPUUsage);
    timer->start(1000); // Alle 1 Sekunde aktualisieren
}

CPUPageHandler::~CPUPageHandler() {
    // PDH-Abfrage aufräumen
    if (hQuery) {
        PdhCloseQuery(hQuery);
    }
}

QString CPUPageHandler::cpuModel() const {
    return m_cpuModel;
}

float CPUPageHandler::cpuUsage() const {
    return m_cpuUsage;
}

void CPUPageHandler::fetchCPUInfo() {
    QProcess *process = new QProcess(this);

    // Prozess aufräumen, wenn er beendet ist
    connect(process, &QProcess::finished, process, &QProcess::deleteLater);
    connect(process, &QProcess::finished, this, &CPUPageHandler::onFetchFinished);

    // Befehl starten, um detaillierte CPU-Modellinformationen abzurufen
    process->start("wmic", QStringList() << "cpu" << "get" << "Name");
}

void CPUPageHandler::onFetchFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    QProcess *process = qobject_cast<QProcess *>(sender());
    if (!process) return;

    if (exitStatus == QProcess::CrashExit || exitCode != 0) {
        qWarning() << "Fehler beim Abrufen der CPU-Informationen. Exit-Status:" << exitStatus << "Exit-Code:" << exitCode;
        m_cpuModel = "Fehler beim Abrufen der CPU-Informationen";
    } else {
        QString output = process->readAllStandardOutput().trimmed();
        QStringList lines = output.split("\n", Qt::SkipEmptyParts);
        if (lines.size() > 1) {
            m_cpuModel = lines[1].trimmed(); // Detailliertes CPU-Modell aus der Ausgabe holen
        } else {
            m_cpuModel = "Unbekannte CPU";
        }
    }

    emit cpuModelChanged();
}

void CPUPageHandler::fetchCPUUsage() {
    if (!hQuery || !hCounter) {
        qWarning() << "PDH-Abfrage oder Zähler ist nicht initialisiert.";
        return;
    }

    // Abfragedaten sammeln
    PDH_STATUS status = PdhCollectQueryData(hQuery);
    if (status != ERROR_SUCCESS) {
        qWarning() << "Fehler beim Sammeln der PDH-Daten. Fehlercode:" << status;
        return;
    }

    // Formatierten Zählerwert abrufen
    PDH_FMT_COUNTERVALUE counterVal;
    status = PdhGetFormattedCounterValue(hCounter, PDH_FMT_DOUBLE, NULL, &counterVal);
    if (status != ERROR_SUCCESS) {
        qWarning() << "Fehler beim Abrufen des formatierten Zählerwerts. Fehlercode:" << status;
        return;
    }

    m_cpuUsage = static_cast<float>(counterVal.doubleValue);
    emit cpuUsageChanged();
}
