var blockSize = 40
var maxColumn = 10
var maxRow = 15
var maxIndex = maxColumn * maxRow
var board = new Array(maxIndex)
var new_board = new Array(maxIndex)
var newX = 0
var newY = 0
var component1
var component2
var score = 0
var total_score = 0
var is_touched = false
var color

//Index function used instead of a 2D array
function getRand(max) {
    return Math.floor(Math.random() * max)
}

function getScore() {
    return total_score
}

function getColor() {
    return color
}

function updateScore() {
    score = 0
    total_score = 0
}

function destroyBoard(board) {
    for (var i = 0; i < maxIndex; i++) {
        if (board[i] != null)
            board[i].destroy()
    }
}

function startNewGame() {
    //Delete blocks from previous game
    destroyBoard(board)

    var maxX = Math.floor(background.width - 20)
    var maxY = Math.floor(background.height - 20)
    console.log("max x:" + maxX)
    console.log("max y:" + maxY)

    //Calculate board size
    maxColumn = Math.floor(background.width / blockSize)
    console.log("max col:" + maxColumn)
    maxRow = Math.floor(background.height / blockSize)
    console.log("max row:" + maxRow)
    maxIndex = maxRow * maxColumn
    console.log("max Index:" + maxIndex)

    //Initialize Board
    board = new Array(maxIndex)

    for (var k = 8; k < 11; k++) {
        newX = getRand(maxX)
        newY = getRand(maxY)
        board[k] = null
        createBomb(newX, newY, k)
        console.log("ganerate bomb")
    }

    for (var j = 0; j < 8; j++) {
        newX = getRand(maxX)
        newY = getRand(maxY)
        board[j] = null
        createBlock(newX, newY, j)
    }
}

function createBomb(x, y, index) {
    if (component2 == null)
        component2 = Qt.createComponent("Bomb.qml")

    // Note that if Block.qml was not a local file, component.status would be
    // Loading and we should wait for the component's statusChanged() signal to
    // know when the file is downloaded and ready before calling createObject().
    if (component2.status == Component.Ready) {
        var dynamicObject = component2.createObject(background)
        if (dynamicObject == null) {
            console.log("error creating bomb")
            console.log(component2.errorString())
            return false
        }
        dynamicObject.x = x
        dynamicObject.y = y
        dynamicObject.width = blockSize
        dynamicObject.height = blockSize
        board[index] = dynamicObject
    } else {
        console.log("error loading block component2")
        console.log(component2.errorString())
        return false
    }
    return true
}

function createBlock(x, y, index) {
    if (component1 == null)
        component1 = Qt.createComponent("Circles.qml")

    // Note that if Block.qml was not a local file, component.status would be
    // Loading and we should wait for the component's statusChanged() signal to
    // know when the file is downloaded and ready before calling createObject().
    if (component1.status == Component.Ready) {
        var dynamicObject = component1.createObject(background)
        if (dynamicObject == null) {
            console.log("error creating block")
            console.log(component1.errorString())
            return false
        }
        dynamicObject.x = x
        dynamicObject.y = y
        dynamicObject.width = blockSize
        dynamicObject.height = blockSize
        board[index] = dynamicObject
    } else {
        console.log("error loading block component1")
        console.log(component1.errorString())
        return false
    }
    return true
}

function checkIfTouched(x, y, size) {
    is_touched = false
    for (var q = 0; q < 11; q++) {
        var NewDinamObj = board[q]
        if (NewDinamObj != null) {
            if (NewDinamObj.x >= x - 20 && NewDinamObj.x <= x + size) {
                if (NewDinamObj.y >= y - 20 && NewDinamObj.y <= y + size) {
                    color = board[q].color
                    board[q].destroy()
                    board[q] = null
                    is_touched = true
                    if (q < 8) {
                        console.log("q: " + q + "score up")
                        score += 1
                        total_score += 1
                    } else {
                        total_score = total_score / 2
                    }
                }
            }
        }
    }

    if (score == 8) {
        startNewGame()
        score = 0
    }
    return is_touched
}
