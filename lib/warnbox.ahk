warnBox(expression, wid){
global warnMessage
    If (expression) {
        MsgBox, , , % warnMessage[wid]  ,5
        Exit, -1

    }
}
