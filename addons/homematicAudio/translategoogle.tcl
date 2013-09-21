#!/bin/tclsh

# load libaries
load tclrega.so

# incluce system variable mapping
source conf/sysvariables.tcl

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
#puts $ausgabe
#puts $encoded
#puts $url
#puts $filename

if { [catch {exec wget -q -U Mozilla -O sound/$filename "$url"} error] } {
    puts stderr "Could not fetch $filename from $url \n$error"
    exit 1
}

