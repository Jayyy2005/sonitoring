## Informieren

### User Stories

| US-№ | Verbindlichkeit | Art          | Beschreibung                                                       |
| ---- | --------------- | ------------ | ------------------------------------------------------------------|
| 0    | Muss            | Funktional   | Als User muss ich in der Lage sein, die App zu steuern. |
| 1    | Muss            | Funktional   | Als User muss ich in der Lage sein, Informationen über meine Komponenten anzusehen. |
| 2    | Muss            | Funktional   | Als User muss ich in der Lage sein, meine PC-Komponenten zu überwachen. |
| 3    | Muss            | Funktional   | Als User muss ich in der Lage sein, die App zu schliessen. |
| 4    | Muss            | Funktional   | Als User habe ich die Möglichkeit, mich über die App zu informieren. |



### Testfälle

| Testfall-Nummer | Ausgangslage                                  | Eingabe                                        | Erwartete Ausgabe                                                      |
| --------------- | --------------------------------------------- | ---------------------------------------------- | ---------------------------------------------------------------------- |
| 0.1             | Der Benutzer öffnet das Programm.                  | Doppelklick auf das Programm.                  | Das Programm wird gestartet, die Startseite wird zuerst angezeigt.                                         |
| 1.1             | Der Benutzer sieht die Informationen zu seiner CPU ein.| Klick auf "CPU" in der Navigationsleiste. | Das installierte CPU-Modell wird angezeigt.                   |
| 1.2             | Der Benutzer sieht die Informationen zu seiner GPU ein.| Klick auf "GPU" in der Navigationsleiste. | Das installeirte GPU-Modell wird in der Kontaktliste angezeigt.                   |
| 1.3            | Der Benutzer sieht die Informationen zu seinem RAM ein.| Klick auf "RAM" in der Navigationsleiste. | Der insgesamt verfügbare Arbeitsspeicher wird angezeigt. |
| 2.1             | Der Benutzer überwacht die Nutzung der CPU.    | Klick auf "CPU" in der Navigationsleiste.             | Die Nutzung der CPU in Prozent sowie ein Diagramm mit der Darstellung in Sekunden pro Minute werden angezeigt. |
| 2.2             |  Der Benutzer überwacht die Nutzung der GPU.       | Klick auf "GPU" in der Navigationsleiste.  | Die Nutzung der GPU in Prozent sowie ein Diagramm mit der Darstellung in Sekunden pro Minute werden angezeigt. |
| 2.3             |  Der Benutzer überwacht die Nutzung des RAM.       | Klick auf "RAM" in der Navigationsleiste.  | Die Nutzung des RAM in Prozent sowie ein Diagramm mit der Darstellung in Sekunden pro Minute werden angezeigt. |
| 3.1             | Der Benutzer schliesst das Programm.    | Klick auf "Beenden" in der Navigationsleiste.               | Das Programm wird beendet. |
| 4.1             | Der Benutzer informiert sich über das Programm.         | Klick auf "Home" in der Navigationsleiste.            | Die Startseite mit den Informationen des Programmes wird angezeigt. |

## Planen


| AP-№ | Zuständig | Beschreibung                            | Geplante Zeit | Frist        |
| ---- | --------- | --------------------------------------- | ------------- | ------------ |
| 0.0  | Raviraj   | Projektantrag erstellen  | 2 Stunden    | 08.11.2024   |
| 1.A  | Raviraj   | Projektdokumentation erstellen     | 2 Stunden     | 08.11.2024  |
| 2.A  | Raviraj   | Qt für Visual Studio installieren         | 2 Stunden    | 15.11.2024   |
| 2.B  | Raviraj   | C++ und Qt Grundlagen recherchieren | 2 Stunden | 15.11.2024   |
| 3.A  | Raviraj   | CPU Überwachung implementieren | 4 Stunden | 22.11.2024   |
| 3.B  | Raviraj   | GPU Überwachung implementieren         | 4 Stunden     | 29.11.2024   |
| 3.C  | Raviraj   | RAM Überwachung implementieren         | 4 Stunden     | 06.12.2024   |
| 3.D  | Raviraj   | Programm optimieren und Fehlerbehebung implementieren         | 4 Stunden     | 13.12.2024   |
| 4.A  | Raviraj   | Mahara Portfolio erstellen        | 3 Stunden    | 20.12.2024   |
| 4.B  | Raviraj   | Projektdokumentation abschliessen        | 1 Stunde    | 20.12.2024   |

## 3 Entscheiden

Ich habe entschieden, auf die Implementierung zur Überwachung der Festplatte zu verzichten, da sie zu aufwendig ist und ich viel Zeit verliere.

## Use Case Diagramm

![Untitled Diagram drawio](https://github.com/user-attachments/assets/bfc669be-a7c5-4d18-981d-5bfb6d135a18)


## 4 Realisieren

| AP-№ | Zuständig | Geplante Zeit | Tatsächliche Zeit | Datum      |
| ---- | --------- | ------------- | ----------------- | ---------- |
| 0.0  | Raviraj   | 2 Stunden      | 2 Stunden         | 08.11.2024 |
| 1.A  | Raviraj   | 2 Stunden      | 2 Stunden      | 08.11.2024 |
| 2.A  | Raviraj   | 2 Stunden      | 4 Stunden         | 15.11.2024 |
| 2.B  | Raviraj   | 2 Stunden      | 2 Stunden        | 15.11.2024 |
| 3.A  | Raviraj   | 4 Stunden      | 8 Stunden         | 29.11.2024 |
| 3.B  | Raviraj   | 4 Stunden     | 5 Stunden        | 06.12.2024 |
| 3.C  | Raviraj   | 4 Stunden     | 5 Stunden        | 06.12.2024 |
| 3.D  | Raviraj   | 4 Stunden     | 3 Stunden        | 13.12.2024 |
| 4.A  | Raviraj   | 3 Stunden      | 3 Stunden         | 20.12.2024 |
| 4.B  | Raviraj   | 1 Stunde      | 1 Stunde        | 20.12.2024 |

## 5 Kontrollieren

### Testprotokoll

| Testfall-№ | Resultat | Tester  | Datum     |
| -----------| ---------| --------| ----------|
| 0.1        | OK       | Raviraj | 20.12.2024|
| 1.1        | OK       | Raviraj | 20.12.2024|
| 1.2        | OK       | Raviraj | 20.12.2024|
| 1.3        | OK       | Raviraj | 20.12.2024|
| 2.1        | OK       | Raviraj | 20.12.2024|
| 2.2        | OK       | Raviraj | 20.12.2024|
| 2.3        | OK       | Raviraj | 20.12.2024|
| 3.1        | OK       | Raviraj | 20.12.2024|
| 4.1        | OK       | Raviraj | 20.12.2024|

## Mahara-Link
https://portfolio.bbbaden.ch/view/view.php?t=7764d993722db1f018ee
