import bb.cascades 1.0
import bb.data 1.0
import my.library 1.0

Page {
    property string title;
    property string imgUrl;
    Container {
        Label {
            text: title
        }
        RemoteImageView {
            url: imgUrl  
        }
    }
}
