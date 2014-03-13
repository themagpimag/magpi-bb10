/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.2
import bb.system 1.2

TabbedPane {
    showTabsOnActionBar: true
    
    attachedObjects: [
        ComponentDefinition {
            id: issuePage
            source: "Issue.qml"
        },
        ComponentDefinition {
            id: newPage
            source: "New.qml"
        },
        SystemToast {
            id: infoToast
            body: "Developer\nDaniele (b0unc3) Maio\ndaniele.maio@gmail.com\n\nData\nThe MagPI Magazine\nwww.themagpi.com\n\nLicense\nThis software is released under MIT License. Copyright (c) 2014"
            button.label: "Ok"
            button.enabled: true
        }
    ]
    
    Tab {
        title: qsTr("Issues");
        imageSource: "asset:///images/issues.png"
        Issues {
            
        }
    }
    Tab {
        title: qsTr("News");
        imageSource: "asset:///images/news.png"
        News {
            
        }
    }
}

