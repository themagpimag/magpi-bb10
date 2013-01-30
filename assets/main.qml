import bb.cascades 1.0
import bb.data 1.0

TabbedPane {
    id: tabbedPane
    showTabsOnActionBar: true
    Tab {
        title: "Issues"
        imageSource: "images/tab_icons/issues_tab.png"
        IssuesPage {
            id: issuePage
        }
    }
    Tab {
        title: "News"
        imageSource: "images/tab_icons/news_tab.png"
        NewsPage {
            id: newsPage
        }
    }
}
