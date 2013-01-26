import bb.cascades 1.0
   
TabbedPane {
    id: tabbedPane
    showTabsOnActionBar: true
      
    Tab {
        title: "Issues"
          
        content: Page {
            content: Label {
                text: "This is tab with issues."
            }
        }
    }
       
    Tab {
        title: "News"
          
        content: Page {
            content: Label {
                text: "This is tab with news."
            }
        }
    }
} 

