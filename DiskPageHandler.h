#ifndef DISKPAGEHANDLER_H
#define DISKPAGEHANDLER_H

#include <QObject>
#include <QString>
#include <QProcess>
#include <pdh.h> // For PDH_HQUERY and PDH_HCOUNTER

class DiskPageHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString diskModel READ diskModel NOTIFY diskModelChanged)
    Q_PROPERTY(float diskUsage READ diskUsage NOTIFY diskUsageChanged)

public:
    explicit DiskPageHandler(QObject *parent = nullptr);
    ~DiskPageHandler();

    QString diskModel() const;  // Getter for Disk model
    float diskUsage() const;    // Getter for Disk usage

signals:
    void diskModelChanged();    // Signal to notify when disk model changes
    void diskUsageChanged();    // Signal to notify when disk usage changes

private slots:
    void onFetchFinished(int exitCode, QProcess::ExitStatus exitStatus); // Handles disk info fetching result

private:
    void fetchDiskInfo();       // Fetch Disk model information
    void fetchDiskUsage();      // Fetch real-time Disk usage

    QString m_diskModel{ "Unknown Disk" }; // Default value for Disk model
    float m_diskUsage{ 0.0f };            // Default value for Disk usage
};

#endif // DISKPAGEHANDLER_H
