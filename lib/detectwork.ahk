; Google Chrome で開かれた作業用ウインドウを URL で探す。
;開かれている Chrome の枚数を返す。

detectwork(url){
    global work := 0
    Chromecnt := 0
    WinGet, windows, list
    loop ,%windows%
    {
        idstr := "ahk_id " . windows%A_Index%
        WinGetTitle,title,%idstr%
        pos := RegExMatch(title,"- Google Chrome$")
        if pos > 0
        {
            Chromecnt += 1
            WinGet,wid,ID,%idstr%
            found := selecttab(wid,"", url)
            if found
            {
                work := wid
                Break
            }
        }
    }
    return Chromecnt
}
