import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.waterfish.settings 1.0

Page {
    id: page
    allowedOrientations: Orientation.All
    property var applicationActive: appWindow.applicationActive && (status == PageStatus.Active || status == PageStatus.Activating)

    function refresh() {
        var oldDate = settings.value("date.start",Date.now());
        var oneDay = 24*60*60*1000
        if (oldDate - Date.now() >= oneDay){
            console.log("Next day, reset values!");
            settings.value("date.start",Date.now());
            settings.setValue("amount.today",0);
        }else console.log("continuing same day");

        var today = settings.valueInt("amount.today",0)
        var perDay = settings.valueInt("amount.per.day",20)

        progressBar.value = today
        progressBar.maximumValue = perDay
        progressBar.update();

        detailToDrink.value = perDay-today
        if (detailToDrink.value < 0 )detailToDrink.value = 0;
        detailToDrink.update();
        detailDrank.value = today;

        // for debuggin
        //settings.setValue("amount.today",0);
    }
    onApplicationActiveChanged: {console.log("appActive changed");refresh();}

    Settings{
        id: settings
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Reset hydration level")
                onClicked: {
                    settings.setValue("amount.today",0);
                    refresh();
                }
            }
        }

        contentHeight: column.height
        Column {
            id: column
            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("WaterFish")
            }
            Label {
                x: Theme.paddingLarge
                text: qsTr("Hello, sailors! Time to drink some water!")
                wrapMode: Text.WordWrap
                width: parent.width
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }



            DetailItem {
                id: detailToDrink
                label: "You still need to drink (dl)"
                value: settings.value("amount.per.day",20)-settings.value("amount.today",0)
            }


            DetailItem {
                id: detailDrank
                label: "You have drank (dl)"
                value: settings.value("amount.today",0)
            }


            ProgressBar {
                id:progressBar
                x:Theme.paddingSmall
                width: parent.width
                minimumValue: 0
                maximumValue: settings.value("amount.per.day",20)
                value: settings.value("amount.today",0)
            }
            // Maybe for next version
            //            TextSwitch {
            //                x: Theme.paddingLarge
            //                text: "Notifications"
            //            }

            ComboBox {
                id: cbAmountPerDay
                label: "Amount to drink daily"
                menu: ContextMenu {
                    id: amountMenuDay
                    property var dlValues: [20,25,30,35,40];
                    MenuItem { text: "" + amountMenuDay.dlValues[0]/10 + " l" }
                    MenuItem { text: "" + amountMenuDay.dlValues[1]/10 + " l" }
                    MenuItem { text: "" + amountMenuDay.dlValues[2]/10 + " l" }
                    MenuItem { text: "" + amountMenuDay.dlValues[3]/10 + " l" }
                    MenuItem { text: "" + amountMenuDay.dlValues[4]/10 + " l" }
                }
                onValueChanged: {
                    settings.setValue("amount.per.day",
                                      amountMenuDay.dlValues[cbAmountPerDay.currentIndex])
                    settings.setValue("amount.per.day.indx",cbAmountPerDay.currentIndex)
                    refresh();
                }
            }

            ComboBox {
                id: cbAmount
                label: "Amount to drink"
                menu: ContextMenu {
                    id: amountMenu
                    property var dlValues: [1,2,3,4,5];
                    MenuItem { text: "" + amountMenu.dlValues[0] + "dl" }
                    MenuItem { text: "" + amountMenu.dlValues[1] + "dl" }
                    MenuItem { text: "" + amountMenu.dlValues[2] + "dl" }
                    MenuItem { text: "" + amountMenu.dlValues[3] + "dl" }
                    MenuItem { text: "" + amountMenu.dlValues[4] + "dl" }
                }
                onValueChanged: {
                    settings.setValue("amount",
                                      amountMenu.dlValues[cbAmount.currentIndex])
                    settings.setValue("amount.indx",cbAmount.currentIndex)
                    refresh();
                }
            }

            Label{
                id: infoLabel
                x: Theme.paddingLarge
                text: qsTr("You need to drink "
                           + cbAmount.value + " "
                           + (settings.value("amount.per.day",20)/((cbAmount.currentIndex+1))).toFixed(1)
                           +  " times a day to reach currently set hydration level")
                wrapMode: Text.WordWrap
                width: parent.width - Theme.paddingLarge
            }
        }
    }
}
