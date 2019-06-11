; Google Chrome で開かれた音声入力エディタを URL で探す。
detecteditor(url){
    global editor := 0
    WinGet, windows, list
    loop ,%windows%
    {
        idstr := "ahk_id " . windows%A_Index%
        WinGetTitle,title,%idstr%
        pos := RegExMatch(title,"- Google Chrome$")
        if pos > 0
        {
            WinGet,wid,ID,%idstr%
            found := selecttab(wid,"", url)
            if found
            {
                editor := wid
                Break
            }
        }
    }
    return
}
