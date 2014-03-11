import bb.cascades 1.2
import bb.data 1.0

NavigationPane {
    id: newsNavPane
    
    attachedObjects: [
        ComponentDefinition {
            id: newPage
            source: "New.qml"
        }
    ]
    Page {
        titleBar: Titlebar { 
            id: newsTB
        }
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
                sortingKeys: ["date"];
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
        }
    
    }
}
