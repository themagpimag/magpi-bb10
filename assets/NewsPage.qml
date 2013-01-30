import bb.cascades 1.0
import bb.data 1.0

Page {
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
	                            
                                contextActions: [
                                    ActionSet {
                                        title: ListItemData.pubDate.substring(5, 17)
                                        ActionItem {
                                            title: "Share"
                                            imageSource: "images/ctx_menu/share.png"
                                        }
                                    }
                                ]
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