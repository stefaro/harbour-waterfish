import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"
import harbour.waterfish.database 1.0

Page {
   id: stats

   property var dataList : []
   //property var parInfo :

   Component.onCompleted: {
       dataList = [[],[]];
       var statlist = [];
       var targetlist = [];
       var stat = database.getStatistics();
       stat.forEach(function(entry){
           dataList[0].push({timestamp:entry.time,value:entry.value})
           dataList[1].push({timestamp:entry.time,value:entry.target})
        }
       );
       console.log("time: " + statlist[0].timestamp);
       dataList.push(statlist);
       dataList.push(targetlist);
   }

   allowedOrientations: Orientation.Portrait | Orientation.Landscape

   SilicaFlickable {
       anchors.fill: parent
       anchors.leftMargin: Theme.paddingLarge
       anchors.rightMargin: Theme.paddingLarge
       anchors.bottomMargin: Theme.paddingLarge
       PageHeader
       {
           id: ph
           title: qsTr("Hydration statistics")
       }

       LinePlot
       {
           id: plot
           dataListModel: dataList
           parInfoModel: parInfo

           anchors.left: parent.left
           anchors.right: parent.right
           anchors.top: ph.bottom
           height: 400
           //anchors.bottomMargin: parent.bottom - Theme.paddingLarge*2
       }
   }

   Database{
       id: database
   }


   ListModel{
       id: parInfo
       Component.onCompleted: {
           this.clear();
           this.append({name:qsTr("hydration"),plotcolor:"#0099ff"})
           this.append({name:qsTr("target"),plotcolor:"#f05000"})
       }
   }
}
