//
// Script to connect airfoil speakers by name
//
// usage from CLI:
// connect.js "AirPort Express Schlafzimmer"
//


airplayLautsprecher = WScript.Arguments.Item(0);


//WScript.Echo(airplayLautsprecher);

//var airplayLautsprecher = "AirPort Express Schlafzimmer";
var airfoilApp = WScript.CreateObject("RogueAmoeba.Airfoil");
var speakerCollection = airfoilApp.GetSpeakers();

for (var i = 0; i < speakerCollection.Count(); i++)
{
	var speaker = speakerCollection.Item(i);
	// WScript.Echo("Speaker " + i + " is " + speaker.Name() + "\n");

	if(speaker.Name() == airplayLautsprecher)
	{
	    //speaker.Disconnect();	
            speaker.Connect();
		//WScript.Echo(speaker.Name() + " wurde verbunden\n");
	}
}

function endsWith(str, suffix)
{
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
}

