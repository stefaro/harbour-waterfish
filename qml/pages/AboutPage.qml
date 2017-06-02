import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
   id: about
   SilicaFlickable {
       anchors.fill: parent
       Column {
           id: column
           width: parent.width
           height: parent.height

           spacing: Theme.paddingMedium
           PageHeader {
               id: header
               title: qsTr("About")
           }
           Row {
               x: Math.min(about.width/4, about.height/4)
               Image {
                   id: about_img
                   width: Math.min(about.width/2, about.height/2)
                   height: width
                   source: "qrc:/images/icons/256x256/harbour-waterfish.png"
               }
           }
           Row {
               width: parent.width - 2*Theme.paddingLarge
               x: Theme.paddingLarge
               Text {
                   color: Theme.primaryColor
                   width: parent.width
                   wrapMode: Text.Wrap
                   text: "WaterFish v" + appVersion + ""
               }
           }
           Row {
               width: parent.width - 2*Theme.paddingLarge
               x: Theme.paddingLarge

               Text {
                   color: Theme.primaryColor
                   width: parent.width
                   wrapMode: Text.Wrap
                   text: qsTr("<p>"+
                              "Simple app to keep track of your hydration level. Distributed under simplified BSD license. Sources can be found from github..." +
                              "</p><br/><p>" + "(c) 2015-2017 Stefan Roos" +
                              "</p>")
               }
           }
           Row {
               width: parent.width - 2*Theme.paddingMedium
               TextArea {
                   color: Theme.highlightColor
                   onClicked: Qt.openUrlExternally("https://github.com/stefaro/harbour-waterfish");
                   width: parent.width
                   readOnly: true
                   font.underline: true
                   font.pixelSize: Theme.fontSizeSmall
                   wrapMode: Text.WordWrap
                   text: "https://github.com/stefaro/harbour-waterfish"
               }
           }
       }
   }
}
