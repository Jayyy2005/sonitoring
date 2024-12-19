import QtQuick
import QtQuick.Controls

Item {
    id: gpuPage

    Rectangle {
        anchors.fill: parent
        color: "#000000"  // Hintergrundfarbe ändern, um mit der CPU-Seite übereinzustimmen

        Column {
            anchors.fill: parent
            spacing: 20
            anchors.centerIn: parent

            // Abschnitt für GPU-Modell
            Rectangle {
                color: "#000000"
                radius: 10
                width: parent.width * 0.8
                height: 80
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "GPU-Modell: " + (gpuPageHandler ? gpuPageHandler.gpuModel : "Lädt...")
                    color: "#ffffff"
                    anchors.centerIn: parent
                    font.pixelSize: 18
                    font.bold: true
                    clip: true
                }
            }

            // Abschnitt für GPU-Nutzungsdiagramm
            Rectangle {
                color: "#000000"
                width: parent.width * 0.8
                height: 200
                anchors.horizontalCenter: parent.horizontalCenter

                Canvas {
                    id: gpuUsageCanvas
                    anchors.fill: parent

                    property real gpuUsage: gpuPageHandler ? gpuPageHandler.gpuUsage : 0
                    property int maxPoints: 60
                    property var data: []
                    property int timeElapsed: 0

                    // Funktion zum Aktualisieren der GPU-Nutzung
                    function updateGpuUsage() {
                        if (Array.isArray(gpuUsageCanvas.data)) {
                            if (gpuUsageCanvas.data.length >= gpuUsageCanvas.maxPoints) {
                                gpuUsageCanvas.data.shift(); // Entfernt den ältesten Wert, wenn die maximale Anzahl an Punkten erreicht ist
                            }
                            gpuUsageCanvas.data.push(gpuUsageCanvas.gpuUsage / 100); // Normalisiert die Nutzung auf 0-1
                            gpuUsageCanvas.requestPaint(); // Zeichnen anfordern
                            gpuUsageCanvas.timeElapsed++; // Zeit erhöhen
                        }
                    }

                    // Verbindung zur GPU-Nutzungsänderung
                    Connections {
                        target: gpuPageHandler
                        function onGpuUsageChanged() {
                            gpuUsageCanvas.updateGpuUsage(); // Bei Änderung der GPU-Nutzung das Diagramm aktualisieren
                        }
                    }

                    // Zeichnen des Diagramms
                    onPaint: {
                        var ctx = gpuUsageCanvas.getContext('2d');
                        ctx.clearRect(0, 0, gpuUsageCanvas.width, gpuUsageCanvas.height); // Hintergrund löschen

                        // Zeichnen des Rasters
                        ctx.strokeStyle = "#565656"; // Rasterfarbe anpassen
                        ctx.lineWidth = 1;
                        for (var i = 0; i <= 10; i++) {
                            var y = (i / 10) * gpuUsageCanvas.height;
                            ctx.beginPath();
                            ctx.moveTo(0, y);
                            ctx.lineTo(gpuUsageCanvas.width, y);
                            ctx.stroke();
                        }

                        // Zeichnen der GPU-Nutzungs-Linie
                        ctx.beginPath();
                        ctx.strokeStyle = "#39FF14"; // Neon-grüne Farbe für GPU-Nutzung
                        ctx.lineWidth = 3;

                        for (var i = 0; i < gpuUsageCanvas.data.length; i++) {
                            var x = (i / gpuUsageCanvas.maxPoints) * gpuUsageCanvas.width;
                            var y = (1 - gpuUsageCanvas.data[i]) * gpuUsageCanvas.height;
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
                        ctx.lineTo(0, gpuUsageCanvas.height);
                        ctx.stroke();

                        // X-Achse
                        ctx.beginPath();
                        ctx.moveTo(0, gpuUsageCanvas.height);
                        ctx.lineTo(gpuUsageCanvas.width, gpuUsageCanvas.height);
                        ctx.stroke();

                        // Zeichnen der Y-Achsenbeschriftungen
                        ctx.fillStyle = "#ffffff";
                        ctx.font = "8px Arial";
                        ctx.textAlign = "left";
                        for (var i = 0; i <= 10; i++) {
                            var y = (i / 10) * gpuUsageCanvas.height;
                            ctx.fillText((10 - i) * 10 + "%", 5, y + 5);
                        }

                        // Zeichnen der X-Achsenbeschriftungen
                        ctx.textAlign = "center"; // Text für die X-Achse zentrieren
                        ctx.fillStyle = "#ffffff";
                        ctx.font = "8px Arial";
                        for (var i = 0; i < gpuUsageCanvas.maxPoints; i += 10) {
                            var x = (i / gpuUsageCanvas.maxPoints) * gpuUsageCanvas.width;
                            var labelY = gpuUsageCanvas.height + 10; // Leicht oberhalb der Canvas-Grenze verschieben
                            ctx.fillText((gpuUsageCanvas.timeElapsed - gpuUsageCanvas.maxPoints + i) + "s", x, labelY);
                        }
                    }

                }
            }

            // Abschnitt für die Textanzeige der aktuellen GPU-Nutzung
            Rectangle {
                color: "#333333"
                radius: 5
                width: parent.width * 0.8
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Aktuelle GPU-Nutzung: " + (gpuPageHandler ? Math.round(gpuPageHandler.gpuUsage) : 0) + "%"
                    color: "#ffffff"
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    font.bold: true
                }
            }
        }
    }
}
