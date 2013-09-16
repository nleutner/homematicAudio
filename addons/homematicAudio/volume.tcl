#!/bin/tclsh

# Script to set airfoil speaker volume
# If argument "<speakername>" is passed, the script will only set the volume for
# the passed speaker, othwersite volume for all speaker will be set
#
# examples:
# tclsh volume.tcl <volumelevel>
# tclsh volume.tcl <volumelevel> <speakername>


# load libaries
load tclrega.so

# incluce system variable mapping
source conf/config.tcl

source lib/functions.tcl
init

if { $::argc == 0 } {
    puts "Error:"
    puts "missing command line argument!"
    puts "Usage:"
    puts "tclsh volume.tcl <volumelevel>"
    puts "tclsh volume.tcl 1"
    puts "tclsh volume.tcl <volumelevel> <speakername>"
    puts "tclsh volume.tcl 0,5 \"Speakername1\""
    exit 1;
}

# CCU Remote Address
set url http://$CCURemoteIP:$CCURemotePort/volume

set params ""

# loop arguments
foreach arg $::argv {
    set encoded [url-encode $arg]
    append params "?\"" $encoded "\""
}

append url $params

catch {exec ./busybox wget -q -O /dev/null "$url"} error