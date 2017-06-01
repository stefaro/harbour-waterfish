import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.waterfish.settings 1.0


/**

  Idea for this kind of a settings dialog was got from simpleweather:
  https://github.com/Acce0ss/simpleweather/blob/master/qml/pages/SettingPage.qml

  */
Dialog {
    id: settingsPage
    allowedOrientations: Orientation.All    
    property bool previousLoaded: false

    objectName: "SettingsPage"

    Settings{
        id: settings
    }

    onStatusChanged: {
        if(status === PageStatus.Active && !previousLoaded)
        {
            console.log("Time to load settings");
            cbAmountPerDay.currentIndex = dlToIndex(settings.amountPerDay)
            cbAmount.currentIndex = settings.amount-1;
            cbNotificationInterval.currentIndex = settings.notificationInterval-1;
            notificationsOn.checked = settings.notificationsEnabled;
            previousLoaded = true;
        }
    }

    onAccepted: {
        settings.setAmount(cbAmount.dlValue);
        settings.setAmountPerDay(cbAmountPerDay.dlValue);
        settings.setNotificationInterval(cbNotificationInterval.nInterval);
        settings.setNotificationsEnabled(notificationsOn.checked);
        previousLoaded = false;
    }

    onCanceled: {
        previousLoaded = false;
    }



    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height
        contentWidth: width
        clip: true

        ScrollDecorator {}

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingMedium

            DialogHeader {
                acceptTextVisible: true
                acceptText: qsTr("Save")
                cancelText: qsTr("Cancel")
                title: qsTr("Settings")
            }

            SectionHeader {
                text: qsTr("General")
            }

            ComboBox {
                id: cbAmountPerDay
                label: "Amount to drink daily"
                property int dlValue: currentItem.dlValue
                menu: ContextMenu {
                    MenuItem {
                        text: "2 l"
                        property int dlValue: 20
                    }
                    MenuItem {
                        text: "2,5 l"
                        property int dlValue: 25
                    }
                    MenuItem {
                        text: "3 l"
                        property int dlValue: 30
                    }
                    MenuItem {
                        text: "3,5 l"
                        property int dlValue: 35
                    }
                    MenuItem {
                        text: "4 l"
                        property int dlValue: 40
                    }
                }
            }

            ComboBox {
                id: cbAmount
                label: "Amount to drink"
                property var dlValue: currentItem.dlValue
                menu: ContextMenu {
                    MenuItem {
                        text: "1 dl"
                        property int dlValue: 1
                    }
                    MenuItem {
                        text: "2 dl"
                        property int dlValue: 2
                    }
                    MenuItem {
                        text: "3 dl"
                        property int dlValue: 3
                    }
                    MenuItem {
                        text: "4 dl"
                        property int dlValue: 4
                    }
                    MenuItem {
                        text: "5 dl"
                        property int dlValue: 5
                    }
                }
            }

            SectionHeader {
                text: qsTr("Notifications")
            }

            TextSwitch {
                id: notificationsOn
                width: parent.width

                text: qsTr("Notifications enabled")
                description: qsTr("Notify when too much time has passed since last drink event.")
            }
            ComboBox {
                id: cbNotificationInterval
                label: "Notify after"
                property var nInterval: currentItem.nInterval
                menu: ContextMenu {
                    MenuItem {
                        text: "1 h"
                        property int nInterval: 1
                    }
                    MenuItem {
                        text: "2 h"
                        property int nInterval: 2
                    }
                    MenuItem {
                        text: "3 h"
                        property int nInterval: 3
                    }
                    MenuItem {
                        text: "4 h"
                        property int nInterval: 4
                    }
                    MenuItem {
                        text: "5 h"
                        property int nInterval: 5
                    }
                }
            }

        }
    }

    function dlToIndex(dl){
        var val = 0;
        switch(dl)
        {
        case 20:
            val = 0;
            break;
        case 25:
            val = 1;
            break;
        case 30:
            val = 2;
            break;
        case 35:
            val = 3;
            break;
        case 40:
            val = 4;
            break;
        default:
            break;
        }
        return val;
    }

}
