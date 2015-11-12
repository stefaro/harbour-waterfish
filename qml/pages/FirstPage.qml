import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.waterfish.settings 1.0

Page {
    id: page
    allowedOrientations: Orientation.All
    property var applicationActive: appWindow.applicationActive && (status == PageStatus.Active || status == PageStatus.Activating)

    function refresh() {
        console.log("Refreshing view")
        var today = settings.amountToday;
        var perDay = settings.amountPerDay;

        progressBar.value = today
        progressBar.maximumValue = perDay
        progressBar.update();

        detailToDrink.value = perDay-today
        if (detailToDrink.value < 0 )detailToDrink.value = 0;
        detailToDrink.update();
        detailDrank.value = today;
    }
    onApplicationActiveChanged: {refresh();}

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
                    settings.setAmountToday(0);
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
                text: qsTr("Time to drink some water!")
                wrapMode: Text.WordWrap
                width: parent.width
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }

            DetailItem {
                id: detailToDrink
                label: "You still need to drink (dl)"
                value: settings.amountPerDay-settings.amountToday
            }

            DetailItem {
                id: detailDrank
                label: "You have drank today (dl)"
                value: settings.amountToday
            }


            ProgressBar {
                id:progressBar
                x:Theme.paddingSmall
                width: parent.width
                minimumValue: 0
                maximumValue: settings.amountPerDay
                value: settings.amountToday
            }

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
                    settings.setAmountPerDay(amountMenuDay.dlValues[cbAmountPerDay.currentIndex])
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
                    settings.setAmount( amountMenu.dlValues[cbAmount.currentIndex])
                    refresh();
                }
            }

            Label{
                id: infoLabel
                x: Theme.paddingLarge
                text: qsTr("You need to drink selected amount "
                           + (settings.amountPerDay/((cbAmount.currentIndex+1))).toFixed(1)
                           +  qsTr(" times a day to reach currently set hydration level"))
                wrapMode: Text.WordWrap
                width: parent.width - Theme.paddingLarge
            }
        }
    }
}
