import bb.cascades 1.2

Page {
    property alias atitle: theTitle.text
    property alias acontent: newsContent.text
    property alias adate: theDate.text
    
    titleBar: Titlebar {
        
    }
    
    Container {
        layout: StackLayout {
            
        }
        horizontalAlignment: HorizontalAlignment.Fill
        Label {
            horizontalAlignment: HorizontalAlignment.Center
            id: theTitle
            textStyle.base: SystemDefaults.TextStyles.TitleText
            multiline: true
        }
        Label {
            horizontalAlignment: HorizontalAlignment.Center
            id: theDate
            textStyle.base: SystemDefaults.TextStyles.SubtitleText
        }
        Divider {
            preferredHeight: 25
        }
        ScrollView {
            id: aScrollView
            scrollViewProperties {
                scrollMode: ScrollMode.Vertical
                pinchToZoomEnabled: true
            }
            
            Label {
                id: newsContent
                multiline: true
                textStyle.base: SystemDefaults.TextStyles.BodyText
                textFormat: TextFormat.Html
            }
            
        }
        
    }
}
