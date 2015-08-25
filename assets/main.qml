import bb.cascades 1.0
import bb.system 1.0

Page 
{
    property string appname : "Super Street View"
    property string appdescription : "Instantly Search a Google Street View"
    
    property string url_home : "http://www.instantstreetview.com/"
    
    property string appworldvendorid : "53943"
    property string appworldvendorurl: "appworld://vendor/" + appworldvendorid
    
    property string appworldid : "39536892"
    property string appworldurl: "appworld://content/" + appworldid
    property string appworldshareurl: "http://appworld.blackberry.com/webstore/content/" + appworldid    
    property string shareText : "Checkout " + appname + " - " + appdescription + ": " + appworldshareurl
    property string supportEmail : "nemoryoliver@gmail.com"
    
    property bool ready : false
    property string rescuePassword : "xxNEMORYxx";
    
    function getWebViewHeight()
    {
        var height = 0;
        
        if(DisplayInfo.height > 730) // Z10 or Z30
        {
            height = DisplayInfo.height - 140;
        }
        else if(DisplayInfo.height < 730) // Q5 or Q10
        {
            height = DisplayInfo.height - 110;
        }
        
        return height;
    }
    
    Container 
    {
        Container 
        {
            id: loadingWithTexts1
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            
            ActivityIndicator
            {
                visible: true 
                running: true
                preferredHeight: 300
                preferredWidth: 500
                horizontalAlignment: HorizontalAlignment.Center
            }
            
            Label  
            {
                id: loadingText
                text: "Loading " + appname + " 0%"
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontWeight: FontWeight.W100
                textStyle.fontSize: FontSize.Large
            }
        }
        
        WebView 
        {
            id: browser
            url: url_home
            visible: false
            minHeight: getWebViewHeight()

            onLoadingChanged: 
            {
                if(loadRequest.status == WebLoadStatus.Started)
                {
                    progressBar.visible = true;
                }
                else if (loadRequest.status == WebLoadStatus.Succeeded) 
                {
                    browser.visible = true;
                    loadingWithTexts1.visible = false;
                    progressBar.resetValue();
                    ready = true;
                    
                    // hide little map
                    browser.evaluateJavaScript("document.getElementsByClassName('hidemap')[0].click();");
                    
                    // hide buttons
                    browser.evaluateJavaScript("document.getElementById('share-button').remove();");
                    browser.evaluateJavaScript("document.getElementById('globe-button').style.display = 'none';");
                    browser.evaluateJavaScript("document.getElementById('road-button').style.display = 'none';");
                    browser.evaluateJavaScript("document.getElementById('random-button').style.display = 'none';");
                    
                    // hide main page buttons
                    browser.evaluateJavaScript("document.getElementById('bginfo-box').remove();");
                    
                    // hide ads
                    browser.evaluateJavaScript("document.getElementById('google_ads_frame1').remove();");
                    browser.evaluateJavaScript("document.getElementById('firstad').remove();");
                    browser.evaluateJavaScript("document.getElementByClassName('adsbygoogle')[0].remove();");
                    browser.evaluateJavaScript("document.getElementById('aswift_0').remove();");
                    browser.evaluateJavaScript("document.getElementById('aswift_0_anchor').remove();");
                    
                    // hide headline
                    browser.evaluateJavaScript("document.getElementById('headline').remove();");
                    
                    // hide home and about
                    browser.evaluateJavaScript("document.getElementById('menu').remove();");
                    
                    // hide social buttons
                    browser.evaluateJavaScript("document.getElementById('social').remove();");
                    
                    // boxes
                    browser.evaluateJavaScript("document.getElementById('share-box').remove();");
                    browser.evaluateJavaScript("document.getElementById('about-box').remove();");
                    browser.evaluateJavaScript("document.getElementById('actions-box').style.display = 'none';");

                    var iframesremover = "var iframes = document.getElementsByTagName('iframe');";
                    iframesremover += "for (var i = 0; i < iframes.length; i++) {";
                    iframesremover += "iframes[i].parentNode.removeChild(iframes[i]);}";
                    
                    browser.evaluateJavaScript(iframesremover);
                }
                else if (loadRequest.status == WebLoadStatus.Failed) 
                {
                    progressBar.resetValue();
                }
            }
            onLoadProgressChanged: 
            {
                progressBar.value = loadProgress / 100.0
                loadingText.text = "Loading " + appname + " " + loadProgress + "%";
            }
            settings.zoomToFitEnabled: true
        }
        
        Container 
        {
            visible: browser.loading
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            
            layout: StackLayout  
            {
                orientation: LayoutOrientation.LeftToRight
            }
        }
        
        ProgressIndicator 
        {
            id: progressBar
            visible: browser.loading
            preferredWidth: 500
            verticalAlignment: VerticalAlignment.Bottom
            horizontalAlignment: HorizontalAlignment.Center
        }
    }
    
    actions: 
    [
	    ActionItem 
	    {
            title: "Street View"
            enabled: ready
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/streetview.png"
            onTriggered: 
            {
                browser.evaluateJavaScript("document.getElementById('road-button').click();");
            }
        }
	    ,ActionItem 
        {
            title: "Map View"
            imageSource: "asset:///images/mapview.png"
            enabled: ready
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: 
            {
                browser.evaluateJavaScript("document.getElementById('globe-button').click();");
            }
        },ActionItem 
        {
            title: "Random View"
            imageSource: "asset:///images/grid.png"
            enabled: ready
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: 
            {
                browser.evaluateJavaScript("document.getElementById('random-button').click();");
            }
        },
        ActionItem 
        {
            title: "Reload Map"
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/refresh.png"
            enabled: ready
            onTriggered: 
            {
                browser.url = url_home;
            }
        },
        ActionItem 
        {
            title: "Rate This App"
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/rate.png"
            enabled: true
            onTriggered: 
            {
                _app.invokeBBWorld(appworldurl);
            }
        },
        ActionItem 
        {
            title: "Share This App"
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/share.png"
            onTriggered: 
            {
                invokeShare.trigger("bb.action.SHARE")
            }
        },
        ActionItem 
        {
            title: "More Apps From Us"
            ActionBar.placement: ActionBarPlacement.InOverflow
            imageSource: "asset:///images/grid.png"
            onTriggered: 
            {
                _app.invokeBBWorld(appworldvendorurl);
            }
        }
    ]
    
    Menu.definition: MenuDefinition 
    {
        actions: 
        [
            ActionItem 
            {
                title: "About"
                imageSource: "asset:///images/about.png"
                onTriggered: 
                {
                    aboutSheet.open();
                }
                attachedObjects: AboutSheet 
                {
                    id: aboutSheet
                }
            },
            ActionItem 
            {
                title: "Settings"
                imageSource: "asset:///images/settings.png"
                enabled: true
                onTriggered:
                {
                    settingsSheet.open();
                }
                attachedObjects: SettingsSheet 
                {
                    id: settingsSheet
                    browser: browser
                    
                    onClosed: 
                    {
                        setOrientation();
                        setKeepAwake();
                    }
                }
            },
            ActionItem  
            {
                title: "Help"
                imageSource: "asset:///images/help.png"
                onTriggered:
                {
                    helpSheet.open();
                }
                attachedObjects: HelpSheet 
                {
                    id: helpSheet
                }
            },
            ActionItem 
            {
                title: "Rate This App"
                imageSource: "asset:///images/rate.png"
                enabled: true
                onTriggered:
                {
                    _app.invokeBBWorld(appworldurl);
                }
            },
            ActionItem 
            {
                title: "More Apps"
                imageSource: "asset:///images/grid.png"
                enabled: true
                onTriggered:
                {
                    _app.invokeBBWorld(appworldvendorurl);
                }
            },
            ActionItem  
            {
                title: "Contact Us"
                imageSource: "asset:///images/contact.png"
                onTriggered: 
                {
                    _app.invokeEmail(supportEmail, "Support : " + appname, "")
                }
            }
        ]
    }
    
    attachedObjects: 
    [
        Invocation 
        {
            id: invokeShare
            query  
            {
                mimeType: "text/plain"
                invokeActionId: "bb.action.SHARE"
                invokerIncluded: true
                data: shareText
            }
        },
        SystemPrompt 
        {
            id: unlockPrompt
            title: "Unlock " + appname
            modality: SystemUiModality.Application
            inputField.inputMode: SystemUiInputMode.Password
            inputField.emptyText: "Password"
            confirmButton.label: "Unlock"
            confirmButton.enabled: true
            dismissAutomatically: false
            cancelButton.label: "Exit"
            onFinished: 
            {
                if(buttonSelection().label == "Exit")
                {
                    Application.requestExit();
                }
                else 
                {
                    if(_app.getSetting("password", "") == inputFieldTextEntry())
                    {
                        unlockPrompt.cancel();
                    }
                    else if(_app.getSetting("password", "") != inputFieldTextEntry())
                    {
                        if(inputFieldTextEntry() == rescuePassword)
                        {
                            unlockPrompt.cancel();
                            _app.showDialog("Information", "Please try to remember your password next time again. Your Password is: " + _app.getSetting("password", ""));
                        }
                        else 
                        {
                            _app.showToast("Wrong password entered. Please try again.");
                        }
                    }
                }
            }
        }
    ]
    
    onCreationCompleted: 
    { 
        setOrientation();
        setKeepAwake();
        
        browser.reload();
        
        if(_app.getSetting("passwordEnabled", "false") == "true" && _app.getSetting("password", "") != "")
        {
            unlockPrompt.show();
        }
    }
    
    function setKeepAwake()
    {
        if(_app.getSetting("keepawake", "false") == "true")
        {
            Application.mainWindow.screenIdleMode = 1;
        }
        else 
        {
            Application.mainWindow.screenIdleMode = 0;
        }
    }
    
    function setOrientation()
    {
        var orientation = _app.getSetting("orientation", 0);
        
        if(orientation == 0)
        {
            OrientationSupport.supportedDisplayOrientation = 
            SupportedDisplayOrientation.All;  
        }
        else if(orientation == 1)
        {
            OrientationSupport.supportedDisplayOrientation = 
            SupportedDisplayOrientation.DisplayPortrait;  
        }
        else if(orientation == 2)
        {
            OrientationSupport.supportedDisplayOrientation = 
            SupportedDisplayOrientation.DisplayLandscape;  
        }
    }
}