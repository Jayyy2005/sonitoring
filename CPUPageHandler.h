#ifndef CPUPAGEHANDLER_H
#define CPUPAGEHANDLER_H

#include <QObject>
#include <QString>
#include <QProcess>
#include <pdh.h> // Für PDH_HQUERY und PDH_HCOUNTER

class CPUPageHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString cpuModel READ cpuModel NOTIFY cpuModelChanged) // Property für CPU Modell
    Q_PROPERTY(float cpuUsage READ cpuUsage NOTIFY cpuUsageChanged)   // Property für CPU Nutzung

public:
    explicit CPUPageHandler(QObject *parent = nullptr);
    ~CPUPageHandler();

    QString cpuModel() const;  // Getter für das CPU Modell
    float cpuUsage() const;    // Getter für die CPU Nutzung

signals:
    void cpuModelChanged();    // Signal, wenn sich das CPU Modell ändert
    void cpuUsageChanged();    // Signal, wenn sich die CPU Nutzung ändert

private slots:
    void onFetchFinished(int exitCode, QProcess::ExitStatus exitStatus); // Verarbeitet das Ergebnis des CPU-Info-Abrufs

private:
    void fetchCPUInfo();       // Ruft Informationen über das CPU-Modell ab
    void fetchCPUUsage();      // Ruft die aktuelle CPU-Nutzung ab

    QString m_cpuModel{ "Unknown CPU" }; // Standardwert für das CPU-Modell
    float m_cpuUsage{ 0.0f };            // Standardwert für die CPU-Nutzung
    PDH_HQUERY hQuery{ nullptr };        // PDH-Abfrage-Handle
    PDH_HCOUNTER hCounter{ nullptr };    // PDH-Zähler-Handle
};

#endif // CPUPAGEHANDLER_H

