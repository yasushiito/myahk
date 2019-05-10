mmic(editorurl){
    global editor := 0
    ; 作業ウィンドウ探す。
    detectchrome()
    If editor = 0 return
    Sleep 100
    WinActivate,ahk_id %editor%
    Sleep 100
    Send,+^s
    return
}
