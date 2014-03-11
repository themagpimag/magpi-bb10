import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Page {
    property int issue_id;
    property string issue_url;
    property string issue_pdf_url;
    
    titleBar: Titlebar {
        id: theTB
    
    }
    
    onIssue_idChanged: {
        issue_url = "http://magpi-api.appspot.com/issues/"+issue_id;
        ds.load();
    }
    
    actions: [
        ActionItem {
            id: dwlPDF
            title: qsTr("Download PDF")
            imageSource: "asset:///images/ic_download.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                console.log("download PDF at " + issue_pdf_url);
                _app.downloadPDF(issue_pdf_url);
            }
        },
        InvokeActionItem {
            id: share
            title: qsTr("Share")
            imageSource: "asset:///images/ic_share.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            query {
                mimeType: "text/plain"
                invokeActionId: "bb.action.SHARE"
            }
            onTriggered: {
                data = "I just read issue " + issue_id + " of @TheMagPI using their @BlackBerry app. Read it here today - " + issue_pdf_url;
            }
            
        }
    ]
    
    
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        horizontalAlignment: HorizontalAlignment.Center
        Label {
            id: theTitle
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Top
            //text: "Issue " + issue_id;
            textStyle.base: SystemDefaults.TextStyles.TitleText
            textStyle.color: Color.DarkGray
        }
        
        Container {
            id: mainContent
            layout: StackLayout {
            
            }
            
            topPadding: 10
            rightPadding: 10
            leftPadding: 10
            bottomPadding: 10
            
            ScrollView {
                id: scrollView
                
                scrollViewProperties {
                    scrollMode: ScrollMode.Vertical
                    pinchToZoomEnabled: true
                }
                
                Container {
                    WebView {
                        id: wvImg
                        horizontalAlignment: HorizontalAlignment.Center
                        preferredWidth: 320
                        preferredHeight: 425
                    }
                    
                    Label {
                        multiline: true
                        id: theContent
                        textStyle.base: SystemDefaults.TextStyles.BodyText
                        textFormat: TextFormat.Html
                    }
                }
            }
        }
    
    }
    
    attachedObjects: [
        DataSource {
            id: ds;
            source: issue_url;
            
            onDataLoaded: {
                theContent.text = data.content
                theTitle.text = "Issue " + issue_id + " - " + data.date;
                wvImg.url = data.image_url;
                issue_pdf_url = data.pdf_url;
            }
        }
    ]
}
