import QtQuick
import QtQuick.Controls

Item {
    id: ramPage

    Rectangle {
        anchors.fill: parent
        color: "#000000"

        Column {
            anchors.fill: parent
            spacing: 20
            anchors.centerIn: parent

            // Abschnitt für RAM-Modell
            Rectangle {
                color: "#000000"
                radius: 10
                width: parent.width * 0.8
                height: 80
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Gesamter RAM: " + (ramPageHandler ? ramPageHandler.totalMemory : "Lädt...")
                    color: "#ffffff"
                    anchors.centerIn: parent
                    font.pixelSize: 18
                    font.bold: true
                    clip: true
                }
            }

            // Abschnitt für RAM-Nutzungsdiagramm
            Rectangle {
                color: "#000000"
                width: parent.width * 0.8
                height: 200
                anchors.horizontalCenter: parent.horizontalCenter

                Canvas {
                    id: ramUsageCanvas
                    anchors.fill: parent

                    // Eigenschaften zur Verfolgung der RAM-Nutzung
                    property real ramUsage: ramPageHandler ? ramPageHandler.ramUsage : 0
                    property int maxPoints: 60
                    property var data: [] // Initialisierung als leeres Array
                    property int timeElapsed: 0

                    // Funktion zur Aktualisierung der RAM-Nutzung
                    function updateRamUsage() {
                        if (Array.isArray(ramUsageCanvas.data)) {
                            if (ramUsageCanvas.data.length >= ramUsageCanvas.maxPoints) {
                                ramUsageCanvas.data.shift(); // Entfernt den ältesten Wert
                            }
                            ramUsageCanvas.data.push(ramUsageCanvas.ramUsage / 100); // Normalisiert die Nutzung auf 0-1
                            ramUsageCanvas.requestPaint(); // Zeichnen anfordern
                            ramUsageCanvas.timeElapsed++; // Zeit erhöhen
                        }
                    }

                    // Signal zum Ändern der RAM-Nutzung
                    Connections {
                        target: ramPageHandler
                        function onRamUsageChanged() {
                            ramUsageCanvas.updateRamUsage(); // Bei Änderung der RAM-Nutzung das Diagramm aktualisieren
                        }
                    }

                    // Zeichnen des Diagramms
                    onPaint: {
                        var ctx = ramUsageCanvas.getContext('2d');
                        ctx.clearRect(0, 0, ramUsageCanvas.width, ramUsageCanvas.height); // Hintergrund löschen

                        // Zeichnen des Rasters
                        ctx.strokeStyle = "#565656"; // Rasterfarbe anpassen
                        ctx.lineWidth = 1;
                        for (var i = 0; i <= 10; i++) {
                            var y = (i / 10) * ramUsageCanvas.height;
                            ctx.beginPath();
                            ctx.moveTo(0, y);
                            ctx.lineTo(ramUsageCanvas.width, y);
                            ctx.stroke();
                        }

                        // Zeichnen der RAM-Nutzungs-Linie
                        ctx.beginPath();
                        ctx.strokeStyle = "#FF073A"; // Neon-rote Farbe
                        ctx.lineWidth = 3;

                        for (var i = 0; i < ramUsageCanvas.data.length; i++) {
                            var x = (i / ramUsageCanvas.maxPoints) * ramUsageCanvas.width;
                            var y = (1 - ramUsageCanvas.data[i]) * ramUsageCanvas.height;
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
                        ctx.lineTo(0, ramUsageCanvas.height);
                        ctx.stroke();

                        // X-Achse
                        ctx.beginPath();
                        ctx.moveTo(0, ramUsageCanvas.height);
                        ctx.lineTo(ramUsageCanvas.width, ramUsageCanvas.height);
                        ctx.stroke();

                        // Zeichnen der Y-Achsenbeschriftungen
                        ctx.fillStyle = "#ffffff";
                        ctx.font = "8px Arial";
                        ctx.textAlign = "left";
                        for (var i = 0; i <= 10; i++) {
                            var y = (i / 10) * ramUsageCanvas.height;
                            ctx.fillText((10 - i) * 10 + "%", 5, y + 5);
                        }

                        // Zeichnen der X-Achsenbeschriftungen
                        ctx.textAlign = "center"; // Text für die X-Achse zentrieren
                        ctx.fillStyle = "#ffffff";
                        ctx.font = "8px Arial";
                        for (var i = 0; i < ramUsageCanvas.maxPoints; i += 10) {
                            var x = (i / ramUsageCanvas.maxPoints) * ramUsageCanvas.width;
                            var labelY = ramUsageCanvas.height + 10; // Leicht oberhalb der Canvas-Grenze verschieben
                            ctx.fillText((ramUsageCanvas.timeElapsed - ramUsageCanvas.maxPoints + i) + "s", x, labelY);
                        }
                    }
                }
            }

            // Abschnitt für die Textanzeige der aktuellen RAM-Nutzung (optional)
            Rectangle {
                color: "#333333"
                radius: 5
                width: parent.width * 0.8
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Aktuelle RAM-Nutzung: " + (ramPageHandler ? Math.round(ramPageHandler.ramUsage) : 0) + "%"
                    color: "#ffffff"
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    font.bold: true
                }
            }
        }
    }
}
