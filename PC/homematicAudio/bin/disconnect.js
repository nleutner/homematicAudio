//
// Script to disconnect airfoil speakers
// If argument /speaker:"<speaker name>" is passed, the script will only disconnect 
// the passed speaker, othwersite all speakers will be disconnected
//
// usage from CLI:
// disconnect.js /speaker:"AirPort Express Schlafzimmer"
//
// var runningSources = airfoilApp.GetRunningSources();

colNamedArguments = WScript.Arguments.Named;

strSpeaker = colNamedArguments.Item("speaker");

//WScript.Echo("Speaker: " + strSpeaker + ""); 

var airfoilApp = WScript.CreateObject("RogueAmoeba.Airfoil");
var speakerCollection = airfoilApp.GetSpeakers();

for (var i = 0; i < speakerCollection.Count(); i++)
{
	var speaker = speakerCollection.Item(i);
	//WScript.Echo("Speaker " + i + " is " + speaker.Name() + "\n");
        if ( WScript.Arguments.Count() == 0 || strSpeaker == '')
        {
           speaker.Disconnect();
           //WScript.Echo(speaker.Name() + " disconnected\n");   
        }        
	else if(speaker.Name() == strSpeaker)
	{	
            speaker.Disconnect();
            //WScript.Echo(speaker.Name() + " disconnected\n");
	}

}
