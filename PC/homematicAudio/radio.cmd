::
:: Script for connecting aifoils speakers and launching vcl to stream radio
:: The Script takes the Airfoil speaker names as argument
::
:: usage:
:: radio.cmd "AirPort Express Wohnzimmer"
:: radio.cmd "AirPort Express Wohnzimmer" "AirPort Express Schlafzimmer"
::


@echo off

set STREAMURL=http://1live.akacast.akamaistream.net/7/706/119434/v1/gnl.akacast.akamaistream.net/1live

set VLC="C:\Program Files\VideoLAN\VLC\vlc.exe"
set VOLUME=256
set OPTIONS=--volume=%VOLUME%

:: connect passed airfoil speakers
:loop

    IF [%1]==[] GOTO continue

    :: call script to connect speakers
    call cscript.exe bin\connect.js %1

    shift
    Goto loop

:continue
:: kill existing tasks
taskkill /F /IM vlc.exe

:: connect radio stream using vlc
start "" %VLC% %OPTIONS% %STREAMURL%
