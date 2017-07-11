import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 640
    height: 480
    id: root
    title: qsTr("Hello World")
    property int numIcon: 0
    FileDialog{
        id: myDialog
        nameFilters: ["*.png", "*.jpg", "All file (*)"]
        folder: shortcuts.music+"/bibi_data/characters/thumbnail"
        selectMultiple: openFile.__action
        onAccepted: {
            console.log("You choose: "+myDialog.fileUrls)

            myModel.append({imgId: "abc"+numIcon++, imgSource: ""+myDialog.fileUrl})
        }
    }

    Button{
        id: openFile
        text: "Open"
        onClicked: {
            myDialog.open()
            myDialog.selectMultiple
        }
    }
    ListView{
        model: ListModel{
            id: myModel
            ListElement{imgId: ""; imgSource: ""}
        }
        delegate: Rectangle{
            Image {
                id: imgId
                source: imgSource
                width: 100
                height: 150
                Drag.active: clicked.drag.active
                Drag.hotSpot.x: imgId.x
                Drag.hotSpot.y: imgId.y
                x: root.width/2
                y: root.height/2
                MouseArea{
                    id: clicked
                    anchors.fill: parent
                    drag.target: parent
                }
            }
        }
    }
}
