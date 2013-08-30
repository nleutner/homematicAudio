#!/bin/tclsh

# load libaries
load tclrega.so

# Variablen: SprachausgabeWetter Zeichenkette

array set values [rega_script {
var wetterstation=dom.GetObject(2941).Value().ToInteger();
var maxtemp=dom.GetObject('Wetterprognose-Heute').Value().ToInteger();
var prozentregen=dom.GetObject('Wetter-Regen-Heute').Value().ToInteger();
}]

set wetterstationtemp $values(wetterstation);
set maxtemp $values(maxtemp);
set prozentregen $values(prozentregen);

# Werte in Variabel schreiben
# =============================
set rega_cmd ""
append rega_cmd "var w0 = dom.GetObject('SprachausgabeWetter');"
append rega_cmd "w0.State('Aktuell $wetterstationtemp Grad, Maximale Temperatur $maxtemp Grad, Regenrisiko $prozentregen Prozent');"
rega_script $rega_cmd