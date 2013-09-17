::
:: Script for downloading a soundfile from homematic, connecting aifoils speakers 
:: and launching vcl to play a soundfile
:: The Script takes the soundfile as first argumant and the Airfoil speaker names as additional arguments
::
:: usage:
:: cmd(translategoogle.cmd "SprachausgabeDynamisch.mp3" "AirPort Express Wohnzimmer")
:: cmd(translategoogle.cmd "SprachausgabeDynamisch.mp3" "AirPort Express Wohnzimmer" "Air Port Express Schlafzimmer")
::

@echo off
set SOUNDFILE=%1
set HOMEMATIC=192.168.2.10

set VLC="C:\Program Files\VideoLAN\VLC\vlc.exe"
set VOLUME=328
set OPTIONS=--play-and-exit --volume=%VOLUME%

IF EXIST %SOUNDFILE% DEL %SOUNDFILE%

echo %SOUNDFILE%

shift

:loop

    IF [%1]==[] GOTO continue
    :: call script to connect speakers
    call CSCRIPT.EXE bin\connect.js %1
    shift
    Goto loop

:continue

:: donwload soundfile from homematic
bin\wget.exe "http://%HOMEMATIC%/addons/sound/%SOUNDFILE%"

:: play sound using vlc
%VLC% %OPTIONS% %SOUNDFILE%

::ping /n 15 localhost >nul

:: kill vlc
::taskkill /F /IM vcl.exe