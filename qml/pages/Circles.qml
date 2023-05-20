import QtQuick 2.0

Rectangle {
    id: circle
    width: 20
    height: width
    color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
    border.color: color
    border.width: 1
    radius: width * 0.5
}
