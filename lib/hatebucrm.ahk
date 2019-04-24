;Google Chrome に表示されているページをはてブする 。
hatebucrm(){
    editor := 0
    work := 0
    WinGet, windows, list
    loop ,%windows%
    {
        idstr := "ahk_id " . windows%A_Index%
        WinGetTitle,title,%idstr%
        pos := RegExMatch(title,"- Google Chrome$")
        if pos > 0
        {
            pos := RegExMatch(title,"音声入力用")
            if pos > 0
            {
                WinGet,editor,ID,%idstr%
            }
            else
            {
                WinGet,work,ID,%idstr%
            }
        }
    }
    Process,Exist,eltest.exe
    eltest := %ErrorLevel%
    If (eltest = 0) return
    If (editor = 0) return
    If (work = 0) return
    WinActivate,ahk_exe eltest.exe

    Sleep 500
    Send,^d
    ;WinActivate,ahk_id %editor%
    ;Sleep 500
    ;Send,^a
    ;Sleep 500
    ;Send,^x
    ;Sleep 200
    ;msg := clipboard
    WinActivate,ahk_id %work%
    ;bm := clipboard
    Sleep 500
    Send,^b
    Sleep 4000
    ;clipboard = %msg%
    Send,^v
    Sleep 500
    Send,{tab}
    Sleep 500
    Send,{space}
    return
}












