#!/bin/bash

# ===============================================
# AusweisApp2 Firewall-Wrapper-Skript für Linux
# Deaktiviert UFW temporär, startet AusweisApp2
# und aktiviert UFW nach dem Schließen der App erneut.
# ===============================================

# --- Konfiguration ---
LOGFILE="$HOME/ausweisapp-fw.log"
NOTIFY_TITLE="AusweisApp2 Wrapper"
UFW_PATH="/usr/sbin/ufw"
FLATPAK_APP="de.bund.ausweisapp.ausweisapp2"

# --- Hilfsfunktionen ---
zeitstempel() { date '+%Y-%m-%d %H:%M:%S'; }
log() { echo "[$(zeitstempel)] $1" | tee -a "$LOGFILE"; }
benachrichtigen() { notify-send "$NOTIFY_TITLE" "$1"; }

# --- UFW-Status prüfen ---
UFW_AKTIV=false
if sudo "$UFW_PATH" status | grep -q "Status: active"; then
    UFW_AKTIV=true
    log "UFW ist aktiv. Deaktiviere temporär..."
    benachrichtigen "Firewall (UFW) wird für AusweisApp2 deaktiviert..."
    sudo "$UFW_PATH" disable
else
    log "UFW ist bereits deaktiviert."
fi

# --- AusweisApp2 starten ---
log "Starte AusweisApp2 über Flatpak..."
benachrichtigen "AusweisApp2 wird gestartet..."
flatpak run "$FLATPAK_APP"
EXIT_CODE=$?

log "AusweisApp2 wurde mit Code $EXIT_CODE beendet"

# --- UFW wieder aktivieren ---
if [ "$UFW_AKTIV" = true ]; then
    log "Aktiviere UFW wieder..."
    benachrichtigen "Firewall wird wieder aktiviert..."
    sudo "$UFW_PATH" enable
else
    log "Keine Reaktivierung von UFW notwendig."
fi

log "Vorgang abgeschlossen."
exit 0
