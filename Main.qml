import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 600
    height: 400
    title: qsTr("Sonitoring")

    flags: Qt.Window | Qt.FramelessWindowHint  // Fenster ohne Rahmen, nicht grössenveränderbar
    color: "#121212"  // Dunkelgrau-schwarzer Hintergrund für das Fenster

    // Hauptlayout: unterteilt in eine Seitenleiste und einen Hauptinhaltbereich
    RowLayout {
        anchors.fill: parent
        spacing: 15

        // Seitenleiste für die Navigation mit fester Position
        Rectangle {
            id: sidebar
            color: "#2C2C2C" // Dunkelgrau für die Seitenleiste
            Layout.preferredWidth: 150
            Layout.fillHeight: true
            z: 1  // Sicherstellen, dass die Seitenleiste im Vordergrund bleibt

            // Inhalt der Seitenleiste (Navigationsbuttons)
            ColumnLayout {
                anchors.fill: parent
                spacing: 0  // Kein Abstand zwischen den Buttons

                // Titel der Seitenleiste
                Text {
                    text: "Sonitoring"
                    font.pixelSize: 24
                    color: "#E0E0E0"  // Helles Grau für den Titeltext
                    Layout.alignment: Qt.AlignLeft
                    Layout.margins: 10  // Rand für den Titel für Trennung
                }

                // Navigationsbuttons
                Button {
                    Layout.fillWidth: true  // Button soll die gesamte Breite der Seitenleiste ausfüllen
                    Layout.preferredHeight: 75
                    background: Rectangle {
                        color: "#2C2C2C"
                    }
                    contentItem: Text {
                        text: "Home"
                        color: "#E0E0E0"  // Helles Grau für den Text
                        anchors.centerIn: parent  // Text wird im Button zentriert
                        width: parent.width  // Textbreite soll der Buttonbreite entsprechen
                        height: parent.height  // Texthöhe soll der Buttonhöhe entsprechen
                    }
                    MouseArea {
                        anchors.fill: parent
                        onPressed: parent.background.color = "#333333"  // Hintergrundfarbe ändern, wenn gedrückt
                        onReleased: parent.background.color = "#2C2C2C"  // Hintergrundfarbe zurücksetzen, wenn losgelassen
                        onClicked: stackView.push("HomePage.qml")  // Bei Klick die "HomePage.qml" anzeigen
                    }
                }

                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 75
                    background: Rectangle {
                        color: "#2C2C2C"
                    }
                    contentItem: Text {
                        text: "CPU"
                        color: "#E0E0E0"
                        anchors.centerIn: parent
                        width: parent.width
                        height: parent.height
                    }
                    MouseArea {
                        anchors.fill: parent
                        onPressed: parent.background.color = "#333333"
                        onReleased: parent.background.color = "#2C2C2C"
                        onClicked: stackView.push("CPUPage.qml")  // Bei Klick die "CPUPage.qml" anzeigen
                    }
                }

                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 75
                    background: Rectangle {
                        color: "#2C2C2C"
                    }
                    contentItem: Text {
                        text: "RAM"
                        color: "#E0E0E0"
                        anchors.centerIn: parent
                        width: parent.width
                        height: parent.height
                    }
                    MouseArea {
                        anchors.fill: parent
                        onPressed: parent.background.color = "#333333"
                        onReleased: parent.background.color = "#2C2C2C"
                        onClicked: stackView.push("RAMPage.qml")  // Bei Klick die "RAMPage.qml" anzeigen
                    }
                }

                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 75
                    background: Rectangle {
                        color: "#2C2C2C"
                    }
                    contentItem: Text {
                        text: "GPU"
                        color: "#E0E0E0"
                        anchors.centerIn: parent
                        width: parent.width
                        height: parent.height
                    }
                    MouseArea {
                        anchors.fill: parent
                        onPressed: parent.background.color = "#333333"
                        onReleased: parent.background.color = "#2C2C2C"
                        onClicked: stackView.push("GPUPage.qml")  // Bei Klick die "GPUPage.qml" anzeigen
                    }
                }

                // Schliessen-Button unten
                Button {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    background: Rectangle {
                        color: "#C0392B"  // Dunkelroter Hintergrund für den Schliessen-Button
                    }
                    contentItem: Text {
                        text: "Beenden"
                        color: "#E0E0E0"
                        anchors.centerIn: parent
                        width: parent.width
                        height: parent.height
                    }
                    MouseArea {
                        anchors.fill: parent
                        onPressed: parent.background.color = "#9B2C1F"  // Hintergrundfarbe ändern, wenn gedrückt
                        onReleased: parent.background.color = "#C0392B"  // Hintergrundfarbe zurücksetzen, wenn losgelassen
                        onClicked: Qt.quit()  // Bei Klick die Anwendung schliessen
                    }
                }
            }
        }

        // StackView zum Anzeigen der Seiten
        StackView {
            id: stackView
            anchors.top: parent.top
            anchors.left: sidebar.right  // StackView wird direkt rechts von der Seitenleiste positioniert
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            z: 0  // StackView soll hinter der Seitenleiste bleiben

            initialItem: "HomePage.qml"  // Anfangs die "HomePage.qml" anzeigen
        }
    }
}
