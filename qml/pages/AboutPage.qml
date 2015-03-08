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
                   source: "qrc:/images/harbour-waterfish.png"
               }
           }

           Row {
               width: parent.width - 2*Theme.paddingLarge
               x: Theme.paddingLarge
               Text {
                   color: Theme.primaryColor
                   width: parent.width
                   wrapMode: Text.Wrap
                   text: qsTr("<p>" + "WaterFish" + " " +
                              "Simple app to keep track of your hydration level. Distributed under simplified BSD license." +
                              "</p><br/><p>" + "(c) 2015 Stefan Roos" +
                              "</p>")
               }
           }
           Row {
               width: parent.width - 2*Theme.paddingMedium
               TextArea {
                   color: Theme.highlightColor
                   onClicked: Qt.openUrlExternally("http://google.com");
                   width: parent.width
                   readOnly: true
                   font.underline: true
                   wrapMode: Text.NoWrap
                   text: "http://google.com"
               }
           }
       }
   }
}
