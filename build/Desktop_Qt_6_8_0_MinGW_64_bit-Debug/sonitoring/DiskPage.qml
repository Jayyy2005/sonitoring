import QtQuick
import QtQuick.Controls

Item {
    width: 400
    height: 400

    Rectangle {
        anchors.fill: parent
        color: "#000000"  // Hintergrundfarbe auf Schwarz setzen

        Column {
            anchors.centerIn: parent
            spacing: 10  // Abstand zwischen den Text-Elementen

            // Titeltext: Willkommen
            Text {
                text: "Willkommen zu Sonitoring!"
                color: "#ffffff"  // Weisse Schriftfarbe
                font.pixelSize: 18  // Schriftgrösse festlegen
                horizontalAlignment: Text.AlignHCenter  // Text horizontal zentrieren
            }

            // Beschreibungstext zu Sonitoring
            Text {
                text: "Sonitoring ist ein Programm,\num Ihre Komponenten-Spezifikationen zu holen und Ihre Aktivitäten zu messen\n(Messungen pro Sekunde basierend auf einer 1-Minuten-Tabelle).\n\nDarunter zählen:\n- Prozessor\n- Grafikkarte\n- Arbeitsspeicher\n\n"
                color: "#ffffff"  // Weisse Schriftfarbe
                wrapMode: Text.WordWrap  // Text wird umgebrochen, wenn er zu lang ist
                font.pixelSize: 10  // Schriftgrösse festlegen
            }

            // Kontakttext mit einer E-Mail-Adresse
            Text {
                text: "Haben Sie ein Problem mit dem Programm? Dann kontaktieren Sie mich unter:\n[sanjayraviraj2005@gmail.com]"
                wrapMode: Text.WordWrap  // Text wird umgebrochen, wenn er zu lang ist
                font.pixelSize: 10  // Schriftgrösse festlegen
                color: "blue"  // Textfarbe Blau für den Link
                MouseArea {
                    anchors.fill: parent  // Mausbereich wird auf das gesamte Text-Element angewendet
                    onClicked: Qt.openUrlExternally("mailto:sanjayraviraj2005@gmail.com")  // E-Mail-Link, öffnet das E-Mail-Programm
                }
            }
        }
    }
}
