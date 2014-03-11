import bb.cascades 1.2
import bb.system 1.0

Page {
    
    content: Container {
        layout: DockLayout {
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                
                Button {
                    text: "Create a toast with a button"
                    attachedObjects: [
                        SystemToast {
                            id: myQmlToast
                            body: "Toast has been removed ..."
                            button.label: "Undo"
                            button.enabled: true
                        },
                        SystemProgressDialog {
                            
                        }
                    ]
                    onClicked: {
                        myQmlToast.show()
                    }
                } // end of Button
            } // end of Container
        } // end of inner Container
    } // end of top-level Container
} // end of Page