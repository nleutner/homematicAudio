#!/bin/tclsh

# Script to kill the vlc task and disconnect all speakers

# load libaries
load tclrega.so

# incluce system variable mapping
source conf/config.tcl

# send curl CCU remote request
set exe "/usr/local/addons/homematicAudio/curl"
set env(LD_LIBRARY_PATH) /usr/local/addons/homematicAudio

set url http://$CCURemoteIP:$CCURemotePort/audioOff
set options " --silent \\\n"

if { [catch {exec sh -c "$exe $options $url"} error] } {
    puts stderr "Error while sendding curl request: \n$error"
    exit 1
}

exit 0