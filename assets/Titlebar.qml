import bb.cascades 1.2


TitleBar {
    property variant current_ds;
    kind: TitleBarKind.FreeForm
    kindProperties: FreeFormTitleBarKindProperties {
        Container {
            background: Color.Black;
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            leftPadding: 10
            rightPadding: 10
            Container {
                horizontalAlignment: HorizontalAlignment.Left
                
                ImageView {
                    imageSource: "asset:///images/TheMagPi.png";
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Left
                    maxHeight: 123;
                    maxWidth: 307;
                }
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Right
                
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
            }
            ImageButton {
                defaultImageSource: "asset:///images/refresh.png";
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Right
                maxHeight: 71
                maxWidth: 71
                onClicked: {
                    console.log("refresh");
                    mpIndicator.start();
                    mpDataModel.clear();
                    current_ds.load();
                    mpIndicator.start();
                }
            }
        }
    }

}
