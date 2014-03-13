import bb.cascades 1.2
import bb.data 1.0

NavigationPane {
    id: issueNavPane
    
    Page {
        titleBar: Titlebar {
            id: issuesTB
        }
        
        actions: [
            InvokeActionItem {
                title: qsTr("Rate Me!")
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
                
               // dataModel: mpDataModel
                
                listItemComponents: [
                    ListItemComponent {
                        type: "header";
                        
                        Header {
                            title: qsTr("Issue ") + ListItemData
                        }
                    },
                    ListItemComponent {
                        type: "item"; //"listItem"
                        
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            
                            }
                            verticalAlignment: VerticalAlignment.Center
                            horizontalAlignment: HorizontalAlignment.Center
                            
                            Container {
                                preferredHeight: 500
                                minWidth: 768
                                
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                                
                                id: highlightContainer
                                
                                topPadding: 15
                                bottomPadding: 15
                                leftPadding: 15
                                rightPadding: 15
                                
                                WebView {
                                    horizontalAlignment: HorizontalAlignment.Center
                                    preferredWidth: 320
                                    preferredHeight: 425
                                    url: ListItemData.image_url;
                                }
                                
                                Label {
                                    verticalAlignment: VerticalAlignment.Center
                                    horizontalAlignment: HorizontalAlignment.Center
                                    text: ListItemData.date
                                    textStyle.base: SystemDefaults.TextStyles.PrimaryText
                                }
                            
                            }
                        
                        
                        }
                    }
                
                
                ]
                onTriggered: {
                    var selectedItem = dataModel.data(indexPath);
                    var ip = issuePage.createObject();
                    ip.issue_id = selectedItem.id;
                    issueNavPane.push(ip);
                }
            }
        }
        
        attachedObjects: [
            GroupDataModel {
                id: mpDataModel;
                sortingKeys: ["id"];
                sortedAscending: false;
            },
            DataSource {
                id: dataSource;
                source: "http://magpi-api.appspot.com/issues"; //http://www.themagpi.com/mps_api/mps-api-v1.php?mode=list_issues";
                onDataLoaded: {
                    console.log("data = " + data.issues[1].date);
                    mpDataModel.insertList(data.issues);//["data"]);
                    listView.setDataModel(mpDataModel);
                    mpIndicator.stop();
                }
            }
        ]
        
        onCreationCompleted: {
            dataSource.load();
            issuesTB.current_ds = dataSource;
            issuesTB.visible = true;
        }
    }
}