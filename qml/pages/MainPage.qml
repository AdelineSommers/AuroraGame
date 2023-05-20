import QtQuick 2.0
import Sailfish.Silica 1.0
import "Generate.js" as SameGame

Page {

    Result {
        id: res
        anchors.centerIn: parent
        z: 100
    }
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    property int old_score: 0
    property int new_score: 0
    property int life: 3
    property color touch_color
    property double r: 0
    property double g: 0
    property double b: 0

    Keys.onPressed: {
        switch (event.key) {
        case Qt.Key_Left:
            player.x -= 5
            //console.log("move left")
            break
        case Qt.Key_Right:
            player.x += 5
            //console.log("move right")
            break
        case Qt.Key_Up:
            player.y -= 5
            //console.log("move up")
            break
        case Qt.Key_Down:
            player.y += 5
            //console.log("move down")
            break
        }
        if (SameGame.checkIfTouched(player.x, player.y, player.width)) {
            new_score = SameGame.getScore()
            console.log(new_score)

            if (new_score <= old_score || new_score == 0) {
                life--
                player.width /= 2
                player.height /= 2

                console.log("life: " + life)
            } else {
                touch_color = SameGame.getColor()
                console.log(touch_color.r + ":" + touch_color.g + ":" + touch_color.b)
                console.log(player.color.r + ":" + player.color.g + ":" + player.color.b)

                r = (touch_color.r + player.color.r) * 0.5
                g = (touch_color.g + player.color.g) * 0.5
                b = (touch_color.b + player.color.b) * 0.5
                console.log(r + ":" + g + ":" + b)
                player.color = Qt.rgba(r, g, b, 255)
                player.width += 20
                player.height = player.width
            }

            switch (life) {
            case (0):
            {
                res.show("Game Over. Your score is " + new_score)
                lifeCount2.color = "red"
                lifeCount3.color = "red"
                player.width = 50
                player.height = player.width
                player.color = "white"
                SameGame.updateScore()
                SameGame.startNewGame()
                old_score = 0
                new_score = 0
                life = 3
                break
            }
            case (1):
            {
                lifeCount2.color = activePalette.window

                break
            }
            case (2):
            {
                lifeCount3.color = activePalette.window
                break
            }
            }
            if (life == 0) {

            }
            old_score = new_score
            score.text = "Score: " + old_score
        }
    }

    Rectangle {
        id: screen

        width: 720
        height: 1200

        SystemPalette {
            id: activePalette
        }

        Item {
            width: parent.width
            anchors {
                top: parent.top
                bottom: toolBar.top
            }

            Image {
                id: background
                anchors.fill: parent
                source: "fon.jpg"
                fillMode: Image.PreserveAspectCrop
            }

            MainCircle {
                id: player
                x: parent.width / 2
                y: parent.height / 2
            }
        }

        Rectangle {
            id: toolBar
            width: parent.width
            height: 50
            color: activePalette.window
            anchors.bottom: screen.bottom

            StartButton {
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
                text: "New Game"
                onClicked: {
                    SameGame.updateScore()
                    SameGame.startNewGame()
                    old_score = 0
                    new_score = 0
                    life = 3
                    lifeCount2.color = "red"
                    lifeCount3.color = "red"
                    player.width = 50
                    player.height = player.width
                    player.color = "white"
                }
            }
            Row {
                spacing: 2
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                Rectangle {
                    id: lifeCount1
                    color: "red"
                    width: 20
                    height: width
                }
                Rectangle {
                    id: lifeCount2
                    color: "red"
                    width: 20
                    height: width
                }
                Rectangle {
                    id: lifeCount3
                    color: "red"
                    width: 20
                    height: width
                }
            }

            Text {
                id: score
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                text: "Score: " + old_score
            }
        }

        //        Item {
        //            id: gameCanvas

        //            property int score: 0
        //            property int blockSize: 40

        //            width: parent.width
        //            height: parent.height
        //            anchors.centerIn: parent

        //            MouseArea {
        //                anchors.fill: parent
        //                onClicked: mouse => SameGame.handleClick(mouse.x, mouse.y)
        //            }
        //        }
    }
}
