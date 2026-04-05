# Datenmanagement Hausarbeit

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19430162.svg)](https://doi.org/10.5281/zenodo.19430162)

## Beschreibung
Dieses Repository enthält den R-Code zur DSGVO-konformen und FAIR-gerechten Aufbereitung eines klinischen Studiendatensatzes im Rahmen der Hausarbeit des Moduls **Forschungsdatenmanagement** (Medizinische Fakultät Mannheim, Universität Heidelberg).

## Studie
Prospektive Interventionsstudie zur Untersuchung des blutdrucksenkenden Effekts regelmäßiger Bewegung bei Patient*innen mit Hypertonie.

## Inhalt
- `01_data_converter_dsgvo.R` – DSGVO-konforme Bereinigung des Originaldatensatzes → Datensatz_v2
- `02_data_converter_fair.R` – FAIR-konforme Aufbereitung und Qualitätsverbesserung → Datensatz_v3
- `03_create_data_dictionary.R` – Automatische Erstellung des Data Dictionaries als PDF
- `04_data_quality_v4.R` – Datenqualitätssicherung nach Kahn et al. (2016) → Datensatz_v4

## Datensatzversionen
| Version | Beschreibung |
|---|---|
| v1 | Originaldatensatz (nicht im Repository) |
| v2 | DSGVO-konform bereinigt |
| v3 | FAIR-konform aufbereitet und qualitätsgesichert |
| v4 | Datenqualität geprüft nach Kahn et al. (2016) |

## DSGVO-Maßnahmen (v1 → v2)
- Entfernung direkter Personenidentifikatoren (Name)
- Entfernung indirekter Identifikatoren (Datum U1/U2, Größe, Gewicht)
- Generalisierung des Alters in Altersgruppen

## FAIR-Maßnahmen (v2 → v3)
- Spaltennamen nach CDISC/CDASH-Standard umbenannt
- Geschlecht, Raucherstatus und Bewegungsprotokoll vereinheitlicht
- Tippfehler korrigiert, fehlende Werte als NA kodiert
- Unplausible Blutdruckwerte als NA markiert
- Numerische Werte gerundet
- Export als CSV (UTF-8) für Langzeitarchivierung

## Datenqualitätsmaßnahmen (v3 → v4)
- **Conformance**: Nebenwirkungen auf kontrolliertes Vokabular standardisiert, Umlaute entfernt
- **Completeness**: Fehlende Werte dokumentiert und ausgegeben
- **Plausibility**: BMI von Patient 30027 (BMI = 14.37) als klinisch unplausibel identifiziert und als NA markiert

## Voraussetzungen
- R (>= 4.0)
- Packages: `readxl`, `writexl`, `dplyr`, `gridExtra`, `grid` (werden automatisch via `pacman` installiert)

## Repositorium & Lizenz
- Datensatz geplant zur Publikation via **Zenodo** (DOI ausstehend)
- Lizenz: **CC BY 4.0** für anonymisierten Analysedatensatz
- Rohdaten nur auf begründeten Antrag (Controlled Access)

## Hinweis
Der Originaldatensazu ist sind aus Datenschutzgründen nicht im Repository enthalten.

## Autor
Patrick Penk – 2026