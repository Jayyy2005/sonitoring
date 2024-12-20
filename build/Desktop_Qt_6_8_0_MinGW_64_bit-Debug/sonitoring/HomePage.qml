import QtQuick
import QtQuick.Controls

Item {
    width: 400
    height: 400

    // Rechteck als Hintergrund, das den gesamten verfügbaren Platz ausfüllt
    Rectangle {
        anchors.fill: parent
        color: "#000000"

        // Spalte mit zentrierten Texten und Abstand zwischen den einzelnen Texten
        Column {
            anchors.centerIn: parent
            spacing: 10

            // Text für die Willkommensnachricht
            Text {
                text: "Willkommen zu Sonitoring!"
                color: "#ffffff"
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
            }

            // Text, der eine kurze Beschreibung des Programms enthält
            Text {
                text: "Sonitoring ist ein Programm,\num Ihre Komponenten-Spezifikationen zu holen und Ihre Aktivitäten zu messen\n(Messungen pro Sekunde basierend auf einer 1-Minuten-Tabelle).\n\nDarunter zählen:\n- Prozessor\n- Grafikkarte\n- Arbeitsspeicher\n\n"
                color: "#ffffff"
                wrapMode: Text.WordWrap
                font.pixelSize: 10
            }

            // Text mit einer Kontakt-E-Mail-Adresse, die beim Klicken eine E-Mail öffnet
            Text {
                text: "Haben Sie ein Problem mit dem Programm? Dann kontaktieren Sie mich unter:\n[sanjayraviraj2005@gmail.com]"
                wrapMode: Text.WordWrap
                font.pixelSize: 10
                color: "blue"
                MouseArea {
                    anchors.fill: parent
                    onClicked: Qt.openUrlExternally("mailto:sanjayraviraj2005@gmail.com")
                }
            }
        }
    }
}
