#!/bin/tclsh

# Script connect airfoil speakers
# If argument "<speakername>" is passed, the script will only disconnect
# the passed speaker, othwersite volume for all speaker will be disconnected
#
# examples:
# tclsh connect.tcl
# tclsh connect.tcl <speakername>


# load libaries
load tclrega.so

# incluce system variable mapping
source conf/config.tcl

source lib/functions.tcl
init

# send curl CCU remote request
set exe "/usr/local/addons/homematicAudio/curl"
set env(LD_LIBRARY_PATH) /usr/local/addons/homematicAudio

set url http://$CCURemoteIP:$CCURemotePort/disconnect

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
    puts stderr "Error while sending curl request: \n$error"
    exit 1
}

exit 0