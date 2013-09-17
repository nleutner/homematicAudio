#!/bin/tclsh

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
set url http://$CCURemoteIP:$CCURemotePort/readout

set params ""

# loop arguments
foreach arg $::argv {
    set encoded [url-encode $arg]
    append params "?\"" $encoded "\""
}

append url $params

catch {exec ./busybox wget -q -O /dev/null "$url"} error