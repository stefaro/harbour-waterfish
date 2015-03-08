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

        progressBar.value = settings.value("amount.today",0);
        progressBar.maximumValue = settings.value("amount.per.day",20)
        progressBar.minimumValue = 0;
        progressBar.update();
        detailToDrink.value = "" + settings.value("amount.per.day",20) - settings.value("amount.today",0) + " dl"
        detailToDrink.update();

        console.log("Date from settings: "+oldDate + " one day: " + oneDay);

        // for debuggin
        settings.setValue("amount.today",0);
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
                label: "You need to drink"
                value: "" + settings.value("amount.per.day",20) - settings.value("amount.today",0).toFixed(1) + " dl"
            }

            ProgressBar {
                id:progressBar
                x:Theme.paddingSmall
                width: parent.width
                minimumValue: 0
                maximumValue: settings.value("amount.per.day",20)
                value: settings.value("amount.today",0)
            }
            TextSwitch {
                x: Theme.paddingLarge
                text: "Notifications"
            }
            ComboBox {
                id: cbAmount
                label: "Amount to drink"

                menu: ContextMenu {
                    id: amountMenu
                    property var dlValues: [1,2,3,4,5];
                    MenuItem { text: ""+ amountMenu.dlValues[0]+"dl";}
                    MenuItem { text: ""+ amountMenu.dlValues[1]+"dl" }
                    MenuItem { text: ""+ amountMenu.dlValues[2]+"dl" }
                    MenuItem { text: ""+ amountMenu.dlValues[3]+"dl" }
                    MenuItem { text: ""+ amountMenu.dlValues[4]+"dl" }
                }
                onValueChanged: {
                    settings.setValue("amount",amountMenu.dlValues[cbAmount.currentIndex])
                    refresh();
                }
            }
            Label{
                id: infoLabel
                x: Theme.paddingLarge
                text: qsTr("You need to drink "
                           + cbAmount.value + " "
                           + (settings.value("amount.per.day",2)/((cbAmount.currentIndex+1)/10)).toFixed(1)
                           +  " times a day to reach normal hydration level")
                wrapMode: Text.WordWrap
                width: parent.width - Theme.paddingLarge
            }
        }
    }
}
