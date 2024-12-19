#ifndef GPUPAGEHANDLER_H
#define GPUPAGEHANDLER_H

#include <QObject>
#include <QString>
#include <QProcess>
#include <QTimer>

class GPUPageHandler : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString gpuModel READ gpuModel NOTIFY gpuModelChanged) // Property für GPU Modell
    Q_PROPERTY(float gpuUsage READ gpuUsage NOTIFY gpuUsageChanged)   // Property für GPU Nutzung

public:
    explicit GPUPageHandler(QObject *parent = nullptr);
    ~GPUPageHandler();

    QString gpuModel() const;  // Getter für das GPU Modell
    float gpuUsage() const;    // Getter für die GPU Nutzung

signals:
    void gpuModelChanged();    // Signal, wenn sich das GPU Modell ändert
    void gpuUsageChanged();    // Signal, wenn sich die GPU Nutzung ändert

public slots:
    void fetchGPUInfo();       // Ruft Informationen über das GPU-Modell ab
    void fetchGPUUsage();      // Ruft die aktuelle GPU-Nutzung ab

private slots:
    void onFetchFinished(int exitCode, QProcess::ExitStatus exitStatus); // Verarbeitet das Ergebnis des GPU-Info-Abrufs

private:
    QString m_gpuModel;        // Speichert das GPU Modell
    float m_gpuUsage;          // Speichert die GPU Nutzung
    QTimer *m_usageTimer;      // Timer, um die GPU-Nutzung in regelmässigen Abständen zu aktualisieren
};

#endif // GPUPAGEHANDLER_H
