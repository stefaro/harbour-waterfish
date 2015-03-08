import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.waterfish.settings 1.0

CoverBackground {
    id: coverBackground
    Label {
        id: label
        style: Text.Sunken
        width: parent.width
        font.weight: Font.DemiBold
        text: qsTr("WaterFish")
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    Settings{
        id: settings
    }
    MenuLabel {
        width: parent.width - Theme.paddingSmall
        x: Theme.paddingSmall
        text: "Hydration level:"
        anchors.bottom: progressBar.top
    }
    ProgressBar {
        id:progressBar
        x: 0
        width: coverBackground.width
        minimumValue: 0
        maximumValue: settings.value("amount.per.day",20)
        value: settings.value("amount.today",0)
        anchors.centerIn: parent
    }

    Label{
        id: infoLabel
        width: parent.width - Theme.paddingSmall
        x: Theme.paddingSmall
        anchors.top: coverBackground.bottom
        text: "" + settings.value("amount.today",0) / 10.0
              + " / "
              + settings.value("amount.per.day",20) / 10;
    }



    CoverActionList {
        id: coverAction
        CoverAction {
            iconSource: "image://theme/icon-cover-next"
            onTriggered: {
                var oldVal = settings.valueInt("amount.today",0);
                var newVal = settings.valueInt("amount",1) + oldVal;
                settings.setValue("amount.today",newVal)
                progressBar.value = newVal;
                progressBar.update();
                infoLabel.text = "" + settings.value("amount.today",0) / 10.0
                      + " / "
                      + settings.value("amount.per.day",20) / 10;
                infoLabel.update();

            }
        }
    }
}

