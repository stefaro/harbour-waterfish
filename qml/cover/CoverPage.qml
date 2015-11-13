import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.waterfish.settings 1.0

CoverBackground {
    id: coverBackground

    property var applicationActive: appWindow.applicationActive && (status == PageStatus.Active || status == PageStatus.Activating)

    function refresh() {
        console.log("Refreshing cover view")
        var today = settings.amountToday;
        var perDay = settings.amountPerDay;

        progressBar.value = today
        progressBar.maximumValue = perDay
        progressBar.update();
    }

    onApplicationActiveChanged: {refresh(); }

    Label {
        id: label
        style: Text.Sunken
        width: parent.width
        font.weight: Font.DemiBold
        text: "WaterFish"
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    Settings{
        id: settings
    }
    Label {
        id: infoLabel
        width: parent.width - Theme.paddingSmall
        x: Theme.paddingSmall
        text: qsTr("Hydration level:")// +"\n" + settings.hydrationLevel +" %";
        anchors.bottom: progressBar.top
    }

    ProgressBar {
        id:progressBar
        x: 0
        width: coverBackground.width
        minimumValue: 0
        maximumValue: settings.amountPerDay
        value: settings.amountToday
        anchors.centerIn: parent
    }
    Label {
        id: lvlLabel
        width: parent.width - Theme.paddingSmall
        x: Theme.paddingSmall
        text: settings.hydrationLevel +" %";
        anchors.top: progressBar.bottom
        horizontalAlignment: TextInput.AlignHCenter
    }
    CoverActionList {
        id: coverAction
        CoverAction {
            iconSource: "image://theme/icon-cover-next"
            onTriggered: {
                var newVal = settings.amount + settings.amountToday;
                settings.setAmountToday(newVal)
                progressBar.value = newVal;
                progressBar.update();
                lvlLabel.text = settings.hydrationLevel +" %";
                infoLabel.update();

            }
        }
    }
}


