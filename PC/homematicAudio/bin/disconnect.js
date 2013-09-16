//
// Script to disconnect airfoil speakers by name
// If argument /speaker:"<speaker name>" is passed, the script will only disconnect
// the passed speaker, othwersite all connected speakers will be disconnected
// usage from CLI:
// disconnect.js
// disconnect.js /speaker:"AirPort Express Schlafzimmer"
//

strSpeaker = colNamedArguments.Item("speaker");

WScript.Echo("Speaker: " + strSpeaker + "");

var airfoilApp = WScript.CreateObject("RogueAmoeba.Airfoil");
var speakerCollection = airfoilApp.GetSpeakers();
var runningSources = airfoilApp.GetRunningSources();

for (var i = 0; i < speakerCollection.Count(); i++)
{
	var speaker = speakerCollection.Item(i);

    if ( WScript.Arguments.Count() == 0 || strSpeaker == '')
    {
        if(speaker.Connected())
        {
            speaker.Disconnect()
        }
        WScript.Echo(speaker.Name() + " disconnected\n");
    }

    else if(speaker.Name() == strSpeaker)
    {
        if(speaker.Connected())
        {
            speaker.Disconnect()
        }
        WScript.Echo(speaker.Name() + " disconnected\n");
    }
}

