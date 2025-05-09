# 🔐 AusweisApp2 Wrapper für Linux (Firewall-Aware Launcher)

Wrapper-Skript für AusweisApp2 unter Linux, um UFW für die Kopplung von mobilen Geräten vorübergehend zu deaktivieren.

## 🔧 Übersicht

Dieses Projekt bietet ein benutzerfreundliches Bash-Skript, das die Nutzung der [AusweisApp2](https://www.ausweisapp.bund.de/) auf Linux-Systemen mit aktivierter UFW-Firewall (Uncomplicated Firewall) erleichtert. Es löst ein häufiges Problem, bei dem das Desktop-Programm die mobile App auf dem Smartphone nicht erkennt, solange UFW aktiv ist.

---

## 🧩 Das Problem

Viele Nutzer:innen berichten, dass die Desktop-Version von **AusweisApp2** ihr Smartphone nicht erkennen kann, obwohl beide Geräte im selben WLAN sind. Ursache ist häufig die aktive **UFW-Firewall**, die die Kommunikation zwischen den Geräten blockiert.

---

## ✅ Lösung

Dieses Skript:

1. Prüft, ob UFW aktiv ist
2. Deaktiviert UFW temporär
3. Startet AusweisApp2 (via Flatpak)
4. Aktiviert UFW wieder, sobald die App geschlossen wird
5. Protokolliert alle Aktionen in einer Log-Datei
6. Sendet Desktop-Benachrichtigungen

---

## 🔧 Voraussetzungen

- **Linux Mint** oder vergleichbares Debian-basiertes System
- **Flatpak** und **AusweisApp2** installiert:  
  ```bash
  flatpak install flathub de.bund.ausweisapp.ausweisapp2
````

* **UFW** ist aktiv (kann mit `sudo ufw status` geprüft werden)
* `notify-send` ist installiert (Teil von `libnotify-bin`)

---

## 📦 Installation

### 1. Klone dieses Repository

```bash
git clone https://github.com/dein-benutzername/ausweisapp2-wrapper.git
cd ausweisapp2-wrapper
```

### 2. Mach das Skript ausführbar

```bash
chmod +x ausweisapp-wrapper.sh
```

### 3. Erstelle einen Desktop-Eintrag

Passe in der Datei `ausweisapp2-wrapper.desktop` den Pfad zur `ausweisapp-wrapper.sh`-Datei an:

```ini
Exec=/pfad/zu/ausweisapp-wrapper.sh
```

### 🔧 Hinweise:

* Ersetze `/pfad/zum/ausweisapp-wrapper.sh` mit dem absoluten Pfad zur Datei, z.B. `/home/deinname/ausweisapp2-wrapper/ausweisapp-wrapper.sh`.

* Dann kopiere sie nach:

  ```bash
  cp ausweisapp2-wrapper.desktop ~/.local/share/applications/
  ```

  Danach:

  ```bash
  update-desktop-database ~/.local/share/applications/
  ```

Nun erscheint **„AusweisApp2 Wrapper“** im Anwendungsmenü.

---


## 🛡️ Sudo ohne Passwort (optional)

Damit UFW-Befehle ohne Passwortabfrage genutzt werden können, füge Folgendes zu einer Datei unter `/etc/sudoers.d/` hinzu:

```bash
echo "$USER ALL=(ALL) NOPASSWD: /usr/sbin/ufw" | sudo tee /etc/sudoers.d/ausweisapp2
```

> ⚠️ Vorsicht: Unsachgemäße Änderungen an sudoers-Dateien können das System unbrauchbar machen.

---

## 🐞 Trouble Shooting / Fehlersuche

* Stelle sicher, dass **beide Geräte im selben Netzwerk** sind.
* Prüfe mit `ping [IP_DES_HANDYS]`, ob das Handy erreichbar ist.
* Beobachte das Log unter: `~/ausweisapp-fw.log`
* Stelle sicher, dass Flatpak-Apps richtig ausgeführt werden:

  ```bash
  flatpak run de.bund.ausweisapp.ausweisapp2
  ```

---

### 🔍 IP-Adresse des Handys ermitteln

Damit die Kopplung mit der **AusweisApp2** funktioniert, muss dein Smartphone im gleichen Netzwerk erreichbar sein.

So findest du die IP-Adresse deines Handys:

1. **Auf dem Handy:**

   * Öffne die WLAN-Einstellungen.
   * Tippe auf das verbundene Netzwerk.
   * Dort wird oft die **IP-Adresse** angezeigt (z.B. `192.168.0.42`).

2. **Vom PC aus prüfen:**

   ```bash
   ping [IP_DES_HANDYS]
   ```

   Wenn die Antwortzeit angezeigt wird, ist das Handy erreichbar.

---

## 🔒 Sicherheitshinweis

Das Wrapper-Skript schaltet die Firewall vorübergehend aus. Auch wenn das Risiko gering ist, besteht ein kleines Sicherheitsrisiko. Verwende das Skript nur bei Bedarf und achte darauf, dass während der deaktivierten Firewall keine anderen Anwendungen Dienste nach außen bereitstellen.

---

## 📝 Lizenz

MIT-Lizenz – siehe [LICENSE](LICENSE) für weitere Informationen.

---


## 🙌 Credits

Entstanden aus eigener Erfahrung und Frustration bei der Arbeit mit der AusweisApp. Da keine Lösung für das geschilderte Problem auffindbar war, habe ich mich ans Werk gemacht – und dies hier ist das Ergebnis. Getestet unter Linux Mint mit UFW und Flatpak.

````
>>>>>>> 1e5f8c2 (Initialer Commit: AusweisApp2 UFW Wrapper für Linux)
