import bb.cascades 1.0

Sheet 
{
    id: sheet
    peekEnabled: true
    property WebView browser

    Page 
    {
        titleBar: TitleBar 
        {
            title: "Settings"
            dismissAction: ActionItem 
            {
                title: "Cancel"
                onTriggered: 
                {
                    sheet.close();
                }
            }
            acceptAction: ActionItem 
            {
                title: "Save"
                onTriggered: 
                {
                    _app.setSetting("password", password.text);
                    
                    if(passwordEnabled.checked == true && password.text != "")
                    {
                        _app.setSetting("passwordEnabled", passwordEnabled.checked);
                    }
                    else if(passwordEnabled.checked == true && password.text == "")
                    {
                        _app.showDialog("Attention", "You have checked the Secure With Password but did not specified a Password. Secure With Password is not enabled.");
                        passwordEnabled.checked = false;
                        _app.setSetting("passwordEnabled", false);
                    }
                    else if(passwordEnabled.checked == false)
                    {
                        _app.setSetting("passwordEnabled", false);
                    }
                    
                    _app.setSetting("keepawake", keepawake.checked);	
                    _app.setSetting("orientation", orientation.selectedIndex);
                    _app.showToast("Settings Saved");
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
                    title: "Orientation"
                }

                DropDown 
                {
                    id: orientation
                    title: "Preferred Orientation"
                    selectedIndex: _app.getSetting("orientation", 0);
                    enabled: true
                    options: 
                    [
                        Option
                        {
                            text: "Auto Orient"
                        },
                        Option
                        {
                            text: "Portrait"
                        },
                        Option
                        {
                            text: "Landscape"
                        }
                    ]
                }
                
                Header 
                {
                    title: "Screen"
                }
                
                CheckBox 
                {
                    id: keepawake
                    text: "Keep Awake"
                    checked: _app.getSetting("keepawake", false);
                    bottomMargin: 50
                }
                
                Header 
                {
                    title: "Security"
                }
                
                CheckBox 
                {
                    id: passwordEnabled
                    text: "Secure With Password"
                    checked: _app.getSetting("passwordEnabled", false);
                }
                
                TextField 
                {
                    id: password
                    enabled: passwordEnabled.checked
                    inputMode: TextFieldInputMode.Password
                    hintText: "password"
                    text: _app.getSetting("password", "");
                }
                
                Header 
                {
                    title: "Services"
                }
                
                Button 
                {
                    text: "Enable Location Services"
                    horizontalAlignment: HorizontalAlignment.Fill
                    imageSource: "asset:///images/location.png"
                    onClicked: 
                    {
                        invokeLocationSettings.trigger("bb.action.OPEN");
                    }
                    
                    attachedObjects: Invocation 
                    {
                        id: invokeLocationSettings
                        query 
                        {
                            mimeType: "settings/view"
                            invokeTargetId: "sys.settings.target"
                            uri: "settings://location"
                        }
                    }
                }
                
                Button 
                {
                    text: "Enable WIFI"
                    horizontalAlignment: HorizontalAlignment.Fill
                    imageSource: "asset:///images/wifi.png"
                    onClicked: 
                    {
                        invokeWIFISettings.trigger("bb.action.OPEN");
                    }
                    
                    attachedObjects: Invocation 
                    {
                        id: invokeWIFISettings
                        query 
                        {
                            mimeType: "settings/view"
                            invokeTargetId: "sys.settings.target"
                            uri: "settings://wifi"
                        }
                    }
                }
                
                Button 
                {
                    text: "Enable Mobile Data Services"
                    horizontalAlignment: HorizontalAlignment.Fill
                    imageSource: "asset:///images/mobiledata.png"
                    onClicked: 
                    {
                        invokeMobileDataSettings.trigger("bb.action.OPEN");
                    }
                    
                    attachedObjects: Invocation 
                    {
                        id: invokeMobileDataSettings
                        query 
                        {
                            mimeType: "settings/view"
                            invokeTargetId: "sys.settings.target"
                            uri: "settings://radio"
                        }
                    }
                }
                
                Button 
                {
                    text: "Clear App Data"
                    horizontalAlignment: HorizontalAlignment.Fill
                    imageSource: "asset:///images/clear.png"
                    onClicked: 
                    {
                        browser.storage.clear();
                        browser.reload();
                        
                        _app.showToast("Successfully Cleared.");
                    }
                }
                
                Header 
                {
                    title: "More"
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
            } 
        }
    }
}