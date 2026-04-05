# Datenmanagement Hausarbeit

## Beschreibung
Dieses Repository enthält den R-Code zur DSGVO-konformen Aufbereitung eines klinischen Studiendatensatzes im Rahmen der Hausarbeit des Moduls **Forschungsdatenmanagement** (Medizinische Fakultät Mannheim, Universität Heidelberg).

## Studie
Prospektive Interventionsstudie zur Untersuchung des blutdrucksenkenden Effekts regelmäßiger Bewegung bei Patient*innen mit Hypertonie.

## Inhalt
- `data_converter_dsgvo.R` – R-Skript zur DSGVO-konformen Bereinigung des Originaldatensatzes

## DSGVO-Maßnahmen
- Entfernung direkter Personenidentifikatoren (Name)
- Entfernung indirekter Identifikatoren (Datum U1/U2, Größe, Gewicht)
- Generalisierung des Alters in Altersgruppen

## Voraussetzungen
- R (>= 4.0)
- Packages: `readxl`, `writexl`, `dplyr` (werden automatisch via `pacman` installiert)

## Hinweis
Die Datensätze (`.xlsx`, `.csv`) sind aus Datenschutzgründen nicht im Repository enthalten.

## Autor
Patrick Penk – 2026