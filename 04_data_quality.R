# ============================================================
# Datenqualitätssicherung nach Kahn et al. (2016)
# Datensatz_v3 -> Datensatz_v4
# ============================================================

# 1. Packages laden
if (!require("pacman")) install.packages("pacman")
pacman::p_load(readxl, writexl, dplyr, gridExtra, grid)

# 2. Working Directory setzen
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Ausgabeordner erstellen
if (!dir.exists("Datensatz_v4")) dir.create("Datensatz_v4")

# 3. Datensatz einlesen
df <- read_excel("Datensatz_v3/Datensatz_v3.xlsx")
cat("Datensatz_v3 geladen:", nrow(df), "Zeilen,", ncol(df), "Spalten\n\n")

df_v4 <- df

# ============================================================
# CONFORMANCE - Nebenwirkungen standardisieren
# Schwachstelle: Freitexteinträge ohne kontrolliertes Vokabular
# ============================================================

cat("=== CONFORMANCE: Nebenwirkungen ===\n")
cat("Einzigartige Werte vor Standardisierung:\n")
print(table(df_v4$NEBENWIRKUNGEN, useNA = "always"))

df_v4 <- df_v4 %>%
  mutate(NEBENWIRKUNGEN = case_when(
    NEBENWIRKUNGEN == "Kopfschmerzen"  ~ "Kopfschmerzen",
    NEBENWIRKUNGEN == "Migräne"        ~ "Migraene",
    NEBENWIRKUNGEN == "Bauchschmerzen" ~ "Bauchschmerzen",
    NEBENWIRKUNGEN == "Durchfall"      ~ "Durchfall",
    NEBENWIRKUNGEN == "Erbrechen"      ~ "Erbrechen",
    NEBENWIRKUNGEN == "Seitenstechen"  ~ "Seitenstechen",
    NEBENWIRKUNGEN == "Herzrasen"      ~ "Herzrasen",
    NEBENWIRKUNGEN == "Müdigkeit"      ~ "Muedigkeit",
    TRUE                               ~ NA_character_
  ))

cat("\nEinzigartige Werte nach Standardisierung:\n")
print(table(df_v4$NEBENWIRKUNGEN, useNA = "always"))
cat("Conformance: Nebenwirkungen standardisiert\n\n")

# ============================================================
# COMPLETENESS - Fehlende Werte dokumentieren
# Schwachstelle: Fehlende Werte ohne Begründung
# ============================================================

cat("=== COMPLETENESS: Fehlende Werte ===\n")
na_counts <- colSums(is.na(df_v4))
cat("Fehlende Werte pro Variable:\n")
print(na_counts[na_counts > 0])

cat("\nPatient*innen mit fehlenden Werten:\n")
print(df_v4[!complete.cases(df_v4), c("PAT_ID", names(na_counts)[na_counts > 0])])
cat("Completeness: Fehlende Werte dokumentiert\n\n")

# ============================================================
# PLAUSIBILITY - BMI Grenzwert
# Schwachstelle: Klinisch unplausibler BMI bei Patient 30027
# ============================================================

cat("=== PLAUSIBILITY: BMI Grenzwert ===\n")
cat("Patient*innen mit auffällig niedrigem BMI (< 16):\n")
print(df_v4 %>% filter(!is.na(BMI) & BMI < 16) %>% select(PAT_ID, BMI))

# BMI von Patient 30027 als NA markieren
df_v4 <- df_v4 %>%
  mutate(BMI = ifelse(PAT_ID == 30027, NA, BMI))

cat("Plausibility: BMI von Patient 30027 als NA markiert\n\n")

# ============================================================
# Ergebnis prüfen
# ============================================================

cat("Vorschau Datensatz_v4:\n")
print(head(df_v4))

# ============================================================
# Datensatz_v4 speichern
# ============================================================

write_xlsx(df_v4, "Datensatz_v4/Datensatz_v4.xlsx")
write.csv(df_v4, "Datensatz_v4/Datensatz_v4.csv", row.names = FALSE, fileEncoding = "UTF-8")
cat("Datensatz_v4.xlsx und .csv gespeichert!\n")

# Als PDF speichern
pdf("Datensatz_v4/Datensatz_v4.pdf", width = 20, height = 12)
grid.text("Datensatz_v4 - Datenqualitaet geprueft (Kahn et al. 2016)",
          x = 0.5, y = 0.97,
          gp = gpar(fontsize = 14, fontface = "bold"))
grid.text("Forschungsdatenmanagement Hausarbeit | Patrick Penk",
          x = 0.5, y = 0.93,
          gp = gpar(fontsize = 9, col = "grey40"))
tbl <- tableGrob(df_v4, rows = NULL,
                 theme = ttheme_default(
                   core    = list(fg_params = list(cex = 0.7)),
                   colhead = list(fg_params = list(cex = 0.8, fontface = "bold"))
                 ))

# Tabelle manuell skalieren
tbl$widths  <- unit(rep(1/ncol(df_v4), ncol(df_v4)), "npc")
tbl$heights <- unit(rep(1/(nrow(df_v4)+1), nrow(df_v4)+1), "npc")

pushViewport(viewport(x = 0.5, y = 0.44, width = 0.98, height = 0.82,
                      just = c("center", "center")))
grid.draw(tbl)
popViewport()
dev.off()
cat("Datensatz_v4.pdf erfolgreich gespeichert!\n")