import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

NavigationPane {
    id: newsNavPane
    
    Page {
        titleBar: Titlebar { 
            id: newsTB
        }
        
        actions: [
            InvokeActionItem {
                title: qsTr("Rate Me!");
                ActionBar.placement: ActionBarPlacement.InOverflow
                imageSource: "asset:///images/rate.png"
                query {
                    invokeTargetId: "sys.appworld"
                    invokeActionId: "bb.action.OPEN"
                    uri: "appworld://"
                }
            },
            ActionItem {
                title: qsTr("Info");
                ActionBar.placement: ActionBarPlacement.InOverflow
                imageSource: "asset:///images/info.png"
                onTriggered: {
                    infoToast.show();
                }
            }
        
        ]
        
        Container {
            layout: DockLayout {
                
            }
            ActivityIndicator {
                id: mpIndicator
                preferredWidth: 250
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                running: true
            }
            
            ListView {
                id: listView;
                
                
                dataModel: mpDataModel
                
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }
                            topPadding: 10
                            bottomPadding: 10
                            rightPadding: 10
                            leftPadding: 10
                            
                            Label {
                                text: qsTr(ListItemData.title)
                                textStyle.base: SystemDefaults.TextStyles.PrimaryText
                                textFormat: TextFormat.Html
                            }
                            Label {
                                text: qsTr(ListItemData.content)
                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                textFormat: TextFormat.Html
                            }
                            Label {
                                text: qsTr(ListItemData.date)
                                textStyle.base: SystemDefaults.TextStyles.SmallText
                                textFormat: TextFormat.Html
                                horizontalAlignment: HorizontalAlignment.Right
                            }
                        }
                    }
                ]
                onTriggered: {
                    var selectedItem = dataModel.data(indexPath);
                    var np = newPage.createObject();
                    np.atitle = selectedItem.title;
                    np.adate = selectedItem.date
                    np.acontent = selectedItem.content
                    newsNavPane.push(np);
                }
            }
        }
        
        attachedObjects: [
            GroupDataModel {
                id: mpDataModel;
                sortingKeys: ["id"];
                sortedAscending: false;
                grouping: ItemGrouping.None
            },
            DataSource {
                id: dataSource;
                source: "http://magpi-api.appspot.com/news";
                onDataLoaded: {
                    console.log("data = " + data.news[1].date);
                    mpDataModel.insertList(data.news);//["data"]);
                    mpIndicator.stop();
                }
            }
        ]
        
        onCreationCompleted: {
            dataSource.load();
            newsTB.current_ds = dataSource;
            newsTB.visible = true;
        }
    
    }
}
