
closeedge(){
    WinGet, windows, list
    ;全てのウィンドウを調べる。
    loop ,%windows%
    {
        idstr := "ahk_id " . windows%A_Index%
        ;ウィンドウタイトルの末尾を調べて edgeだけに対して処理を行う。
        WinGetTitle,title,%idstr%
        pos := RegExMatch(title,"\- Microsoft​ Edge$")
        if pos > 0
        {
            WinGet,wid,ID,%idstr%
            WinClose, ahk_id %wid%
        }
    }
}
