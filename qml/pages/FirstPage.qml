import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.waterfish.settings 1.0

Page {
    id: firstPage
    allowedOrientations: Orientation.All
    property var applicationActive: appWindow.applicationActive && (status == PageStatus.Active || status == PageStatus.Activating)
    property double drinkCount: 20.0
    function refresh() {
        var today = settings.amountToday;
        var perDay = settings.amountPerDay;

        progressBar.value = today
        progressBar.maximumValue = perDay
        progressBar.update();

        detailToDrink.value = perDay-today
        if (detailToDrink.value < 0 )detailToDrink.value = 0;
        detailToDrink.update();
        detailDrank.value = today;

        drinkCount = perDay/settings.amount;
    }
    onApplicationActiveChanged: {refresh();}

    Settings{
        id: settings
        onAmountChanged:  {
            console.log("Amount changed")  ;
            refresh();
        }
        onAmountPerDayChanged:{
            refresh();
            console.log("Amount per day changed")
        }

    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
            MenuItem {
                text: qsTr("Statistics")
                onClicked: pageStack.push(Qt.resolvedUrl("StatisticsPage.qml"))
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
            width: firstPage.width
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
                label: qsTr("You still need to drink (dl)")
                value: settings.amountPerDay-settings.amountToday
            }

            DetailItem {
                id: detailDrank
                label: qsTr("You have drank today (dl)")
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

            Label{
                id: infoLabel
                x: Theme.paddingLarge
                text: qsTr("You need to drink selected amount %1 times a day to reach currently set hydration level")
                        .arg( drinkCount.toPrecision(2) );
                wrapMode: Text.WordWrap
                width: parent.width - Theme.paddingLarge
            }
        }
    }
}
