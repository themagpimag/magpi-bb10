import bb.cascades 1.0
import bb.data 1.0

TabbedPane {
    id: tabbedPane
    showTabsOnActionBar: true
    Tab {
        title: "Issues"
        imageSource: "tab_icons/issues_tab.png"
        content: Page {
            Container {
                layout: DockLayout { 
                }
                ActivityIndicator {
                    id: issuesIndicator
                    preferredWidth: 250
                    preferredHeight: 250
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }
                ListView {
                    id: issuesListView
                    dataModel: issuesModel
                    listItemComponents: [
                        ListItemComponent {
                            type: "item"
                            StandardListItem {
                                title: ListItemData.title.split(" - ")[0]
                                description: ListItemData.title.split(" - ")[1]
                            }
                        }
                    ]
                }
            }
            attachedObjects: [
                GroupDataModel {
                    id: issuesModel
                    sortingKeys: [
                        "title"
                    ]
                    sortedAscending: false
                    grouping: ItemGrouping.None
                },
                DataSource {
                    id: issuesSource
                    source: "http://feeds.feedburner.com/theMagPi"
                    query: "/rss/channel/item"
                    type: DataSourceType.Xml
                    onDataLoaded: {
                        issuesModel.clear();
                        issuesModel.insertList(data);
                        issuesIndicator.stop();
                    }
                }
            ]
            onCreationCompleted: {
                issuesIndicator.start();
                issuesSource.load();
            }
        }
    }
    Tab {
        title: "News"
        imageSource: "tab_icons/news_tab.png"
        content: Page {
	        Container {
	            layout: DockLayout { 
	            }
	            ActivityIndicator {
	                id: newsIndicator
	                preferredWidth: 250
	                preferredHeight: 250
	                horizontalAlignment: HorizontalAlignment.Center
	                verticalAlignment: VerticalAlignment.Center
	            }
	            ListView {
	                id: newsListView
	                dataModel: newsModel
	                listItemComponents: [
	                    ListItemComponent {
	                        type: "item"
	                        Container {
	                            Label {
	                                text: ListItemData.pubDate.substring(5, 17)
	                            }
	                            Label {
	                                text: ListItemData.title
	                                multiline: true
	                            }
	                            Divider {
	                                verticalAlignment: VerticalAlignment.Bottom
	                                horizontalAlignment: HorizontalAlignment.Center
	                            }
	                        }
	                    }
	                ]
	            }
	        }
            attachedObjects: [
                GroupDataModel {
                    id: newsModel
                    sortingKeys: [
                        "pubDate"
                    ]
                    sortedAscending: false
                    grouping: ItemGrouping.None
                },
                DataSource {
                    id: newsSource
                    source: "http://feeds.feedburner.com/MagPi"
                    query: "/rss/channel/item"
                    type: DataSourceType.Xml
                    onDataLoaded: {
                        newsModel.clear();
                        newsModel.insertList(data);
                        newsIndicator.stop();
                    }
                }
            ]
            onCreationCompleted: {
                newsIndicator.start();
                newsSource.load();
            }
        }
    }
    onCreationCompleted: {
        onStart();
    }
}
