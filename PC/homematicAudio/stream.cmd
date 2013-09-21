::
:: Script for connecting aifoils speakers and launching vcl to stream radio
:: The Script takes the stream url as first parameter and aditional Airfoil the speaker names as argument
::
:: usage:
:: radio.cmd "http://1live.akacast.akamaistream.net/7/706/119434/v1/gnl.akacast.akamaistream.net/1live" "AirPort Express Wohnzimmer"
:: radio.cmd "http://1live.akacast.akamaistream.net/7/706/119434/v1/gnl.akacast.akamaistream.net/1live" "AirPort Express Wohnzimmer" "AirPort Express Schlafzimmer"
::

@echo off

set STREAMURL=%1
shift

set VLC="C:\Program Files\VideoLAN\VLC\vlc.exe"
set VOLUME=256
set OPTIONS=--play-and-exit --volume=%VOLUME%

:: connect passed airfoil speakers
:loop

    IF [%1]==[] GOTO continue

    :: call script to connect speakers
    call cscript.exe bin\connect.js /speaker:%1

    shift
    Goto loop

:continue
:: kill existing tasks
:: taskkill /F /IM vlc.exe

:: connect radio stream using vlc
start "" %VLC% %OPTIONS% %STREAMURL%