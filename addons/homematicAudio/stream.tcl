#!/bin/tclsh

# Script to stream radio or music using Airplay (vcl and airfoil)
#
# examples (from bash):
# tclsh stream.tcl "<streamurl>" "<speakername>"
# tclsh stream.tcl "http://1live.akacast.akamaistream.net/7/706/119434/v1/gnl.akacast.akamaistream.net/1live" "AirPort Express T-Home"
#
# CCU:
# ! 1Live Radio starten
# dom.GetObject("CUxD.CUX2801001:1.CMD_EXEC").State("cd /usr/local/addons/homematicAudio && tclsh stream.tcl 'http://1live.akacast.akamaistream.net/7/706/119434/v1/gnl.akacast.akamaistream.net/1live' 'AirPort Express Schlafzimmer' 'AirPort Express T-Home'");
#

# load libaries
load tclrega.so

# incluce system variable mapping
source conf/config.tcl

source lib/functions.tcl
init

if { $::argc == 0 } {
    puts "Error:"
    puts "missing command line argument!"
    exit 1;
}

# CCU Remote Address
set url http://$CCURemoteIP:$CCURemotePort/stream

set params ""

# loop arguments
foreach arg $::argv {
    set encoded [url-encode $arg]
    append params "?\"" $encoded "\""
}

append url $params

catch {exec ./busybox wget -q -O /dev/null "$url"} error