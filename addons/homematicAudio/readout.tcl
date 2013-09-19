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

# send curl CCU remote request
set exe "/usr/local/addons/homematicAudio/curl"
set env(LD_LIBRARY_PATH) /usr/local/addons/homematicAudio

set url http://$CCURemoteIP:$CCURemotePort/readout


# generate params
set params ""

# loop arguments
foreach arg $::argv {
    set encoded [url-encode $arg]
    append params "?%22" $encoded "%22"
}

append url $params

# curl options
set options " --silent \\\n"

if { [catch {exec sh -c "$exe $options $url"} error] } {
    puts stderr "Error while sendding curl request: \n$error"
    exit 1
}

exit 0