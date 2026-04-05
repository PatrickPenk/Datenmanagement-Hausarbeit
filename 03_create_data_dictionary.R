# ============================================================
# Data Dictionary als PDF erstellen
# ============================================================

# 1. Packages laden
if (!require("pacman")) install.packages("pacman")
pacman::p_load(readxl, dplyr, gridExtra, grid)

# 2. Working Directory setzen
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Ausgabeordner erstellen falls nicht vorhanden
if (!dir.exists("DataDictionary")) dir.create("DataDictionary")

# 3. Datensatz einlesen fuer Uebersicht
df <- read_excel("Datensatz_v3/Datensatz_v3.xlsx")
cat("Datensatz geladen:", nrow(df), "Zeilen,", ncol(df), "Spalten\n")

# 4. Data Dictionary definieren
data_dictionary <- data.frame(
  Variable = c("PAT_ID", "GESCHLECHT", "BMI", "DIAGNOSE",
               "RR_PRE_SYS", "RR_POST_SYS", "RR_PRE_DIA", "RR_POST_DIA",
               "BEWEGUNGSPROTOKOLL", "BEWEGUNGSDATEN",
               "MEDIKAMENT_DOSIS", "BEHANDLUNGSDAUER",
               "NEBENWIRKUNGEN", "RAUCHERSTATUS", "ALTERSGRUPPE"),
  Typ = c("Integer", "String", "Float", "String",
          "Integer", "Float", "Float", "Float",
          "String", "String", "String",
          "Float", "String", "String", "String"),
  Einheit = c("-", "-", "kg/m2", "-",
              "mmHg", "mmHg", "mmHg", "mmHg",
              "-", "-", "mg",
              "Monate", "-", "-", "-"),
  Wertebereich = c("30010-30039", "m/w/d", "10-70", "Hypertonie/Hypotonie/keine",
                   "60-250", "60-250", "40-150", "40-150",
                   "ja/nein", "ja/nein", "Freitext",
                   "4-6.5", "Freitext",
                   "Raucher/Nichtraucher/Starker Raucher",
                   "unter 30/30-44/45-59/60-74/75+"),
  Beschreibung = c("Anonymisierte Patienten-ID",
                   "Geschlecht (m/w/d/NA)",
                   "Body Mass Index, gerundet auf 2 Nachkommastellen",
                   "Primaerdiagnose der Studie",
                   "Systolischer Blutdruck vor Behandlung",
                   "Systolischer Blutdruck nach Behandlung",
                   "Diastolischer Blutdruck vor Behandlung",
                   "Diastolischer Blutdruck nach Behandlung",
                   "Bewegungsprotokoll ausgefuellt (ja/nein/NA)",
                   "Bewegungsdaten via App vorhanden (ja/nein)",
                   "Taegliche Medikamentendosis",
                   "Behandlungsdauer in Monaten (numerisch)",
                   "Aufgetretene Nebenwirkungen",
                   "Rauchverhalten",
                   "Generalisierte Altersgruppe"),
  stringsAsFactors = FALSE
)

# 5. PDF erstellen
pdf("DataDictionary/DataDictionary_v1.pdf", width = 20, height = 12)

# Titel
grid.text("Data Dictionary - Studiendatensatz Hypertonie",
          x = 0.5, y = 0.97,
          gp = gpar(fontsize = 16, fontface = "bold"))
grid.text(paste("Datensatz_v3 |", nrow(df), "Beobachtungen |", ncol(df), "Variablen | Patrick Penk"),
          x = 0.5, y = 0.93,
          gp = gpar(fontsize = 11, col = "grey40"))

# Tabelle
tbl <- tableGrob(data_dictionary,
                 rows = NULL,
                 theme = ttheme_default(
                   core    = list(fg_params = list(cex = 0.75),
                                  padding = unit(c(6, 4), "mm")),
                   colhead = list(fg_params = list(cex = 0.85, fontface = "bold"),
                                  padding = unit(c(6, 4), "mm"))
                 ))

# Tabelle zentriert und mit mehr Platz positionieren
pushViewport(viewport(y = 0.45, height = 0.85))
grid.draw(tbl)
popViewport()
dev.off()

cat("DataDictionary_v1.pdf erfolgreich erstellt!\n")