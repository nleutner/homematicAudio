//
// Script to connect airfoil speakers by name
// If argument /speaker:"<speaker name>" is passed, the script will only connect 
// the passed speaker, othwersite all speakers will be connected
//
// usage from CLI:
// connect.js /speaker:"AirPort Express Schlafzimmer"
//


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
           speaker.Connect();
           //WScript.Echo(speaker.Name() + " disconnected\n");   
        }        
	else if(speaker.Name() == strSpeaker)
	{	
            speaker.Connect();
            //WScript.Echo(speaker.Name() + " disconnected\n");
	}

}

