Implementierung der Sprachausgabe über translate.google und Audio Ausgabe von Stream URL.
Der Befehl wird von der homematic an den PC gesendet und von CCU-RemotePC ausgeführt.

Entsprechende Hardware vorausgesetzt.

*   http://www.videolan.org/vlc/                VLC Player
*   http://www.apple.com/de/airplay/            z.B. Airport Express
*   http://dragonfly.at/CCU-RemotePC.html       Ab Version v1.3.1
*   http://www.rogueamoeba.com/airfoil/windows/ Airfoil

####Benötigte Addons:
#####CCU1:
[Telnet](http://www.homematic-inside.de/software/addons/item/telnet-dienst) -> mit Telnet ein Passwort für den FTP Zugang auf der CCU einrichten

Telnet Session (Windows) öffnen:

*   Start
*   Eingabeaufforderung
*   `telnet`
*   `open 192.168.X.X`
*   `root`
*   `passwd`
*   dein Passwort
*   dein Passwort

[FTP](http://www.homematic-inside.de/software/addons/item/ftp) -> Installieren

[Filezilla](https://filezilla-project.org/) -> Ordner aus dem GIT als Zip herunterladen und nach */usr/local/addons/* kopieren

*   Server:192.168.X.XXX
*   User:root
*   Passwort:dein Passwort was beim Telnet gesetzt wurde

#####CCU2:
[Filezilla](https://filezilla-project.org/) -> Ordner aus dem GIT als Zip herunterladen und nach */usr/local/addons/* kopieren

*   Server: sftp://192.168.X.XX
*   User:root
*   Passwort: MuZhlo9n%8!G
*   Port: 22

#####CCU1/CCU2

[CUx-Daemon](http://www.homematic-inside.de/software/cuxdaemon) -> Performance schonender Aufruf

*   homematic -> Einstellungen -> Systemsteuerung -> Zusatzsoftware
*   Cux-Damon -> Einstellen
*   Geräte
*   CUxD Gerätetyp -> (28)System) 

![CuxD](https://github.com/nleutner/homematicWeather/blob/develop/addons/homematicWeather/doc/images/Cux%20Exec.jpg?raw=true)

*   homematic -> Posteingang

![homematic](https://raw.github.com/nleutner/homematicWeather/develop/addons/homematicWeather/doc/images/Cux%20CCU.gif)



###addons/homematicAudio





####config.tcl
Diese Datei ist die einzige die angepasst werden muss.

 Variabel                 |Beschreibung                                                                |
:-------------------------|:---------------------------------------------------------------------------|
CCURemoteIP               |Remote IP des Windows Rechner auf dem die CCU-RemotePC.exe läuft
CCURemotePort             |Port in der Einstellung der CCU-RemotePC.exe




####audioOff.tcl
Diese Programm wird mit einem homematic Programm aufgerufen. Es sendet einen Befehl an den PC auf dem CCU-RemotePC.exe gestartet ist.
Die CCU-RemotePC.exe startet die audioOff.cmd. Dadurch werden alle Airplay Geräte deaktiviert und der VLC Player beendet.

#####Systemvariabeln
 Name                     | Variablentyp| Werte|Maßeinheit
:-------------------------|:------------|:-----|:-------
                          |             |      |

#####Aufruf im homematic Programm:
```
dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh audioOff.tcl");
```





####readout.tcl
Diese Programm wird mit einem homematic Programm aufgerufen. Es sendet einen Befehl an den PC auf dem CCU-RemotePC.exe gestartet ist.
Die CCU-RemotePC.exe startet die readout.cmd. Diese beginnt mit der Wiedergabe der .mp3 auf den entsprechenden Airport Geräten.

#####Systemvariabeln
 Name                     | Variablentyp| Werte|Maßeinheit
:-------------------------|:------------|:-----|:-------
                          |             |      |

#####Aufruf im homematic Programm:
```
! Ansage vorlesen
dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh readout.tcl 'SprachausgabeDynamisch.mp3' 'AirPort Express T-Home'");

```

#####Parameter
> dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh readout.tcl 'Datei.mp3' 'AirPort Gerät' 'AirPort Gerät'");

 Name                     | Beschreibung
:-------------------------|:------------------------------------------
Datei.mp3                 |Dateiname der unter /Sound/ liegenden .mp3
AirPort Gerät             |Optionale Parameter. Bei fehlen werden alle Geräte angesprochen.



####stream.tcl
Diese Programm wird mit einem homematic Programm aufgerufen. Es sendet einen Befehl an den PC auf dem CCU-RemotePC.exe gestartet ist.
Die CCU-RemotePC.exe startet die stream.cmd. Diese startet die Wiedergabe eines AudioStreams.

#####Systemvariabeln
 Name                     | Variablentyp| Werte|Maßeinheit
:-------------------------|:------------|:-----|:-------
                          |             |      |

#####Aufruf im homematic Programm:
```
!
! General usage:
! tclsh stream.tcl <streamurl> <speakername>
! or for more speakers:
! tclsh stream.tcl <streamurl> <speakername> <speakername>


! 1Live Radio starten
dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh stream.tcl 'http://1live.akacast.akamaistream.net/7/706/119434/v1/gnl.akacast.akamaistream.net/1live' 'AirPort Express Schlafzimmer' 'AirPort Express T-Home'");
```

#####Parameter
> dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh stream.tcl 'streamURL' 'AirPort Gerät' 'AirPort Gerät'");

 Name                     | Beschreibung
:-------------------------|:------------------------------------------
streamURL                 |Angabe der streamURL
AirPort Gerät             |Optionale Parameter. Bei fehlen werden alle Geräte angesprochen.





####translategoogle.tcl
Mit diesem Programm wird eine Systemvariabel mit einem Text befüllt. Dieser wird an translate.google übergeben und eine .mp3 wird auf der CCU unter /sound abgelegt.
Anschließend wird der Befehl an den PC auf dem CCU-RemotePC.exe gestartet ist gesendet.
Die CCU-RemotePC.exe startet die translategoogle.cmd.

#####Systemvariabeln
 Name                     | Variablentyp| Werte|Maßeinheit
:-------------------------|:------------|:-----|:-------
SprachausgabeDynamisch    |Zeichenkette |      |


#####Aufruf im homematic Programm:
```
! Variable zur Sprachausgabe mit Text füllen
dom.GetObject('SprachausgabeDynamisch').State('Hallo Welt !');

! Ansage vorbereiten und mp3 ablegen
dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh translategoogle.tcl 'SprachausgabeDynamisch'");

! Ansage vorlesen
dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh readout.tcl 'SprachausgabeDynamisch.mp3' 'AirPort Express T-Home'");
```

#####Aufruf im homematic Programm:
Beispiel: Ausgabe mit Werten der homematic Systemvariabeln
```
! Vorbereitung Wetteransage
var current=dom.GetObject('Wetter-Temp-Aktuell').Value().ToInteger();
var maxtemp=dom.GetObject('Wetter-MaxTemp-Heute').Value().ToInteger();
var prozentregen=dom.GetObject('Wetter-Regen-Heute').Value().ToInteger();

var w0 = dom.GetObject('SprachausgabeDynamisch');
w0.State("Aktuell "#current#" Grad, Maximale Temperatur "#maxtemp#" Grad, Regenrisiko Heute"#prozentregen#" Prozent");

! Ansage vorbereiten und mp3 ablegen
dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh translategoogle.tcl 'SprachausgabeDynamisch'");

! Ansage vorlesen
dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh readout.tcl 'SprachausgabeDynamisch.mp3' 'AirPort Express T-Home'");

```

#####Parameter
dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh translategoogle.tcl 'Systemvariabel'");

 Name                     | Beschreibung
:-------------------------|:------------------------------------------
Systemvariabel            |Name der Systemvariabel dessen String als .mp3 erstellt werden soll






####volume.tcl
Diese Programm wird mit einem homematic Programm aufgerufen. Es sendet einen Befehl an den PC auf dem CCU-RemotePC.exe gestartet ist.
Die CCU-RemotePC.exe startet die volume.cmd. Diese stellt die Lautstärke der Airplay Geräte ein.


#####Systemvariabeln
 Name                     | Variablentyp| Werte|Maßeinheit
:-------------------------|:------------|:-----|:-------
                          |             |      |


#####Aufruf im homematic Programm:
```
!Master Volume 20% (all speakers)
dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh volume.tcl 0,2");
```

#####Aufruf im homematic Programm:
```
!Volume 50% for speaker called "AirPort Express Wohnzimmer"
dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh volume.tcl 0,2 'AirPort Express Wohnzimmer' ");
```

#####Parameter
dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh volume.tcl Wert 'AirPort Gerät' ");

 Name                     | Beschreibung
:-------------------------|:------------------------------------------
Wert                      |Der Wert kann zwischen 0,1 - 1 liegen
AirPort Gerät             |Optionale Parameter. Bei fehlen werden alle Geräte angesprochen.
