; Firefox のウィンドウを探します。
;Firefox は1枚しか起動していない前提です。
detectfirefox(){
    global fox := 0
    WinGet, windows, list
    loop ,%windows%
    {
        idstr := "ahk_id " . windows%A_Index%
        WinGetTitle,title,%idstr%
        pos := RegExMatch(title," - Mozilla Firefox$")
        if pos > 0
        {
            WinGet,fox,ID,%idstr%
        }
    }
    return
}
