homematicAudio
==============
Audio implementations for homematic

Installation
==============

1. System variables
create a system variable which holds the text which should be translated to a sound file.
This could be something like "SprachausgabeDynamisch".
The contents of the variable will be used to generate the speech output.

2. Transfer files using sftp or ftp
Transfer the complete addon folder to the target system under /usr/local/addons/
This will result in having: /usr/local/addons/homematicAudio

3. Make busybox binary executable
Due to the CCU has an old version of busybox, this extension comes with a BusyBox 1.19.4 executable.

cd /usr/local/addons/homematicAudio
chmod 755 busybox

4. create directory for sound files
Create the directory where the soundfiles from google will be placed.

cd /usr/local/addons/homematicAudio
mkdir sound

5. create symbolic link
To make soundfiles available through http://<homematicIP>/addons/sound/SprachausgabeDynamisch.mp3
you need to create a symbolic link from the addon directory to the public www directory using ssh

ln -s /usr/local/addons/homematicAudio/sound /usr/local/etc/config/addons/www/sound


Credits
==============
anli - compiled busyboy binary
http://homematic-forum.de/forum/viewtopic.php?f=41&t=8725

#@TODO
busybox abfgragen welche CCU
