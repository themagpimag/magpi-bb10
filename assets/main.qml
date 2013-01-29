import bb.cascades 1.0
import bb.data 1.0
   
TabbedPane {
    id: tabbedPane
    showTabsOnActionBar: true
      
    Tab {
        title: "Issues"
          
        content: Page {
            content: ListView {
                objectName: "issuesListView"
                
            }
        }
    }
       
    Tab {
        title: "News"
          
        Page {
            content: ListView {
                id: newsListView
                dataModel: dataModel
              
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Container {
                            Label {
                                text: ListItemData.pubDate
                            }
                            Label {
                                text: ListItemData.title
                                multiline: true
                            }
                        }
                    }
                ]
            }
            
            attachedObjects: [
                GroupDataModel { 
                    id: dataModel
                    sortingKeys: ["pubDate"]
                    sortedAscending: false
                    grouping: ItemGrouping.None 
                },
                DataSource {
                    id: dataSource
                    source: "http://feeds.feedburner.com/MagPi"
                    query: "/rss/channel/item"
                    type: DataSourceType.Xml
                
                    onDataLoaded: {
                        dataModel.clear();
                        dataModel.insertList(data);
                    }
                }
            ]
            
            onCreationCompleted: {
                dataSource.load();
            }
        }
    }
    
    onCreationCompleted: {
        onStart();
    }
} 

