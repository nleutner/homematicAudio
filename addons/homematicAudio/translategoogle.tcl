load tclrega.so

# Variablen: Zeichenkette wird als Parameter übergeben
set command ""
append command "dom.GetObject(" \" [lindex $argv 0] \" ").Value();"
set ausgabe [rega $command]

# Aufruf und Erstellung der Datei
# ===============================
set url http://translate.google.com/translate_tts?tl=de&q=$ausgabe
exec /usr/bin/wget -q -U Mozilla -O /usr/local/etc/config/addons/www/Soundfiles/$argv.mp3 $url
