//
// Script to set airfoil speaker volume
// If argument /speaker:"<speaker name>" is passed, the script will only set the volume for 
// the passed speaker, othwersite volume for all speaker will be set
//
// usage from Windows CLI:
// SetVolume.js  /volume:0,3 /speaker:"AirPort Express Schlafzimmer"
//

colNamedArguments = WScript.Arguments.Named;

strVolume = colNamedArguments.Item("volume");
strSpeaker = colNamedArguments.Item("speaker");

WScript.Echo("Volume: " + strVolume + "");
WScript.Echo("Speaker: " + strSpeaker + ""); 

var airfoilApp = WScript.CreateObject("RogueAmoeba.Airfoil");
var speakerCollection = airfoilApp.GetSpeakers();

for (var i = 0; i < speakerCollection.Count(); i++)
{
	var speaker = speakerCollection.Item(i);
	// WScript.Echo("Speaker " + i + " is " + speaker.Name() + "\n");
    if ( WScript.Arguments.Count() == 1 || strSpeaker == '')
    {
       speaker.SetVolume( strVolume);
       WScript.Echo(speaker.Name() + " Volume set\n");
    }

	else if(speaker.Name() == strSpeaker)
	{	
            speaker.SetVolume( strVolume);
            WScript.Echo(speaker.Name() + " Volume set\n");
	}

}





