#ifndef RAMPAGEHANDLER_H
#define RAMPAGEHANDLER_H

#include <QObject>
#include <QString>
#include <QTimer>
#include <QProcess>

class RAMPageHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString totalMemory READ totalMemory NOTIFY totalMemoryChanged)  // Property für den gesamten RAM
    Q_PROPERTY(float ramUsage READ ramUsage NOTIFY ramUsageChanged)             // Property für die RAM-Nutzung

public:
    explicit RAMPageHandler(QObject *parent = nullptr);
    ~RAMPageHandler();

    QString totalMemory() const;  // Getter für den gesamten RAM
    float ramUsage() const;       // Getter für die RAM-Nutzung

    void fetchRAMInfo();          // Ruft die Information über den gesamten RAM ab
    void fetchRAMUsage();         // Ruft die aktuelle RAM-Nutzung ab

signals:
    void totalMemoryChanged();    // Signal, wenn sich der gesamte RAM ändert
    void ramUsageChanged();       // Signal, wenn sich die RAM-Nutzung ändert

private:
    QString m_totalMemory;        // Speichert den gesamten RAM
    float m_ramUsage;             // Speichert die aktuelle RAM-Nutzung
    QTimer *m_usageTimer;         // Timer für die regelmässige Aktualisierung der Nutzung

    void onFetchFinished(int exitCode, QProcess::ExitStatus exitStatus);  // Slot, wenn der Abrufprozess beendet ist
};

#endif // RAMPAGEHANDLER_H
