import bb.cascades 1.0

Sheet 
{
    id: sheet
    peekEnabled: true
    
    Page 
    {
        titleBar: TitleBar 
        {
            title: "About"
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
                bottomPadding: 20
                
                Header 
                {
                    title: "About The App"
                }
                
                ImageView 
                {
                    topMargin: 30
                    preferredWidth: 400
                    scalingMethod: ScalingMethod.AspectFit
                    imageSource: "asset:///images/icon.png"
                    horizontalAlignment: HorizontalAlignment.Center
                }
                
                Label 
                {
                    text: appdescription + ". Best tool to use for Street Viewing on BlackBerry 10."
                    multiline: true
                    horizontalAlignment: HorizontalAlignment.Center
                }
                
                Header 
                {
                    title: "About The Developer"
                }
                
                ImageView 
                {
                    imageSource: "asset:///images/nemory.png"
                    horizontalAlignment: HorizontalAlignment.Center
                }
                
                Label 
                {
                    text: "Created and Maintained by: \nNemory Development Studios"
                    multiline: true
                    horizontalAlignment: HorizontalAlignment.Center
                }
                
                Header 
                {
                    title: "More"
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