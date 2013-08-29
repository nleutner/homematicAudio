#!/bin/tclsh

# load libaries
load tclrega.so

# installation
# auf der shell ebene: ln -s /usr/local/addons/homematicAudio/sound /usr/local/etc/config/addons/www/sound

set command ""
append command "dom.GetObject(" \" [lindex $argv 0] \" ").Value();"

set ausgabe [rega $command]

# urlencode
source lib/functions.tcl
init
set encoded [url-encode $ausgabe]

# Aufruf und Erstellung der Datei
# ===============================
set url http://translate.google.com/translate_tts?tl=de&q=$encoded
set filename [lindex $argv 0].mp3

# debug
puts $ausgabe
puts $encoded
puts $url
puts $filename

exec ./busybox wget -q -U Mozilla -O sound/$filename "$url"

