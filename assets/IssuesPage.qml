import bb.cascades 1.0
import bb.data 1.0

NavigationPane {
            id: navigationPane
            Page {
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
                    onTriggered: {
                        var chosenItem = dataModel.data(indexPath);
                        var issuePage = singleIssuePageDefinition.createObject();
                        issuePage.title = chosenItem["title"];
                        issuePage.imgUrl = getImgSrc(chosenItem["description"]);
                        navigationPane.push(issuePage);
                    }
                    
                    function getImgSrc(description) {
                        var regex = new RegExp("img src='(.*?)'", "m");
                        var match = regex.exec(description);
                
                        if (match != null && match.length > 1)
                            return match[1];
                        else
                            return null;
                    }
                    
                    listItemComponents: [
                        ListItemComponent {
                            type: "item"
                            StandardListItem {
                                title: ListItemData.title.split(" - ")[0]
                                description: ListItemData.title.split(" - ")[1]
                                
                                contextActions: [
                                    ActionSet {
                                        title: ListItemData.title
                                        ActionItem {
                                            title: "View"
                                            imageSource: "images/ctx_menu/view.png"
                                        }
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
        attachedObjects: [
            ComponentDefinition {
	            id: singleIssuePageDefinition
	            source: "SingleIssuePage.qml"
            }
        ]
    }