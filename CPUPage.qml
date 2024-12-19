import QtQuick
import QtQuick.Controls

Item {
    id: cpuPage

    Rectangle {
        anchors.fill: parent
        color: "#000000"

        Column {
            anchors.fill: parent
            spacing: 20
            anchors.centerIn: parent

            // Abschnitt für CPU-Modell
            Rectangle {
                color: "#000000"
                radius: 10
                width: parent.width * 0.8
                height: 80
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "CPU-Modell: " + (cpuPageHandler ? cpuPageHandler.cpuModel : "Lädt...")
                    color: "#ffffff"
                    anchors.centerIn: parent
                    font.pixelSize: 18
                    font.bold: true
                    clip: true
                }
            }

            // Abschnitt für CPU-Nutzungsdiagramm
            Rectangle {
                color: "#000000"
                width: parent.width * 0.8
                height: 200
                anchors.horizontalCenter: parent.horizontalCenter

                Canvas {
                    id: cpuUsageCanvas
                    anchors.fill: parent

                    property real cpuUsage: cpuPageHandler ? cpuPageHandler.cpuUsage : 0
                    property int maxPoints: 60
                    property var data: []
                    property int timeElapsed: 0

                    // Funktion zum Aktualisieren der CPU-Nutzung
                    function updateCpuUsage() {
                        if (Array.isArray(cpuUsageCanvas.data)) {
                            if (cpuUsageCanvas.data.length >= cpuUsageCanvas.maxPoints) {
                                cpuUsageCanvas.data.shift(); // Entfernt den ältesten Wert, wenn die maximale Anzahl an Punkten erreicht ist
                            }
                            cpuUsageCanvas.data.push(cpuUsageCanvas.cpuUsage / 100); // Normalisiert die Nutzung auf 0-1
                            cpuUsageCanvas.requestPaint(); // Zeichnen anfordern
                            cpuUsageCanvas.timeElapsed++; // Zeit erhöhen
                        }
                    }

                    // Verbindung zur CPU-Nutzungsänderung
                    Connections {
                        target: cpuPageHandler
                        function onCpuUsageChanged() {
                            cpuUsageCanvas.updateCpuUsage(); // Bei Änderung der CPU-Nutzung das Diagramm aktualisieren
                        }
                    }

                    // Zeichnen des Diagramms
                    onPaint: {
                        var ctx = cpuUsageCanvas.getContext('2d');
                        ctx.clearRect(0, 0, cpuUsageCanvas.width, cpuUsageCanvas.height); // Hintergrund löschen

                        // Zeichnen des Rasters
                        ctx.strokeStyle = "#565656";
                        ctx.lineWidth = 1;
                        for (var i = 0; i <= 10; i++) {
                            var y = (i / 10) * cpuUsageCanvas.height;
                            ctx.beginPath();
                            ctx.moveTo(0, y);
                            ctx.lineTo(cpuUsageCanvas.width, y);
                            ctx.stroke();
                        }

                        // Zeichnen der CPU-Nutzungs-Linie
                        ctx.beginPath();
                        ctx.strokeStyle = "#00FFFF"; // Neonblaue Farbe
                        ctx.lineWidth = 3;

                        for (var i = 0; i < cpuUsageCanvas.data.length; i++) {
                            var x = (i / cpuUsageCanvas.maxPoints) * cpuUsageCanvas.width;
                            var y = (1 - cpuUsageCanvas.data[i]) * cpuUsageCanvas.height;
                            if (i === 0) {
                                ctx.moveTo(x, y);
                            } else {
                                ctx.lineTo(x, y);
                            }
                        }
                        ctx.stroke();

                        // Zeichnen der Achsen
                        ctx.strokeStyle = "#a9a9a9";
                        ctx.lineWidth = 1;

                        // Y-Achse
                        ctx.beginPath();
                        ctx.moveTo(0, 0);
                        ctx.lineTo(0, cpuUsageCanvas.height);
                        ctx.stroke();

                        // X-Achse
                        ctx.beginPath();
                        ctx.moveTo(0, cpuUsageCanvas.height);
                        ctx.lineTo(cpuUsageCanvas.width, cpuUsageCanvas.height);
                        ctx.stroke();

                        // Zeichnen der Y-Achsenbeschriftungen
                        ctx.fillStyle = "#ffffff";
                        ctx.font = "8px Arial";
                        ctx.textAlign = "left";
                        for (var i = 0; i <= 10; i++) {
                            var y = (i / 10) * cpuUsageCanvas.height;
                            ctx.fillText((10 - i) * 10 + "%", 5, y + 5);
                        }

                        // Zeichnen der X-Achsenbeschriftungen
                        ctx.textAlign = "center"; // Text für die X-Achse zentrieren
                        ctx.fillStyle = "#ffffff";
                        ctx.font = "8px Arial";
                        for (var i = 0; i < cpuUsageCanvas.maxPoints; i += 10) {
                            var x = (i / cpuUsageCanvas.maxPoints) * cpuUsageCanvas.width;
                            var labelY = cpuUsageCanvas.height + 10; // Leicht oberhalb der Canvas-Grenze verschieben
                            ctx.fillText((cpuUsageCanvas.timeElapsed - cpuUsageCanvas.maxPoints + i) + "s", x, labelY);
                        }
                    }

                }
            }

            // Abschnitt für die Textanzeige der aktuellen CPU-Nutzung
            Rectangle {
                color: "#333333"
                radius: 5
                width: parent.width * 0.8
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Aktuelle CPU-Nutzung: " + (cpuPageHandler ? Math.round(cpuPageHandler.cpuUsage) : 0) + "%"
                    color: "#ffffff"
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    font.bold: true
                }
            }
        }
    }
}
