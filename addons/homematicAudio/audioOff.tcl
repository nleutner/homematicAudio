#!/bin/tclsh

# Script to kill the vlc task and disconnect all speakers

# load libaries
load tclrega.so

# incluce system variable mapping
source conf/config.tcl

# CCU Remote Address
set url http://$CCURemoteIP:$CCURemotePort/audioOff

catch {exec ./busybox wget -q -O /dev/null "$url"} error