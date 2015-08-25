import bb.cascades 1.0

Sheet 
{
    id: sheet
    peekEnabled: true

    Page 
    {
        titleBar: TitleBar 
        {
            title: "Help & Instructions"
            dismissAction: ActionItem 
            {
                title: "Close"
                onTriggered: 
                {
                    sheet.close();
                }
            }
        }
        
        ScrollView 
        {
            Container 
            {
                topPadding: 20
                leftPadding: 20
                rightPadding: 20
                
                Header 
                {
                    title: "Street View Button"
                }
                
                Label 
                {
                    text: "This button changes the Map View to a Street View but only when a Street View Map is available. You can determine if there's a Street View available when you see a man standing in the map."
                    multiline: true
                }
                
                Header 
                {
                    title: "Map View"
                }
                
                Label 
                {
                    text: "This button changes the Street View to a Map View."
                    multiline: true
                }
                
                Header 
                {
                    title: "Random View"
                }
                
                Label 
                {
                    text: "This button randomly selects a nearby Street View Map."
                    multiline: true
                }
                
                Button
                {
                    text: "More Apps From Us"
                    imageSource: "asset:///images/grid.png"
                    horizontalAlignment: HorizontalAlignment.Fill
                    onClicked: 	
                    {
                        _app.invokeBBWorld(appworldvendorurl);
                    }
                }
                
                Button
                {
                    text: "Contact Us"
                    imageSource: "asset:///images/contact.png"
                    horizontalAlignment: HorizontalAlignment.Fill
                    onClicked: 
                    {
                        _app.invokeEmail(supportEmail, "Support : " + appname, "")
                    }
                }
            }  
        } 
    }
}