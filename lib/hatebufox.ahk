;Firefox で表示しているページをはてブする 。
hatebufox(){
    editor := 0
    work := 0
    fox := 0
    Process,Exist,firefox.exe
    fox := %ErrorLevel%
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
        pos := RegExMatch(title,"- Mozilla Firefox")
        if pos > 0
        {
                WinGet,fox,ID,%idstr%
            }
    }
    Process,Exist,eltest.exe
    eltest := %ErrorLevel%
    If (eltest = 0) return
    If (fox = 0) return
    If (editor = 0) return
    If (work = 0) return
    Sleep 500
    ;SetTitleMatchMode,2
    ;WinActivate, Mozilla Firefox
    ;Sleep 500
    ;Send,^l
    ;Sleep 500
    ;Send,^a
    ;Sleep 500
    ;Send,^c
    ;Sleep 200
    ;bm := clipboard
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
    ;WinActivate,ahk_id %work%
    Sleep 500

    ;Send,^t
    ;Sleep 300
    ;clipboard = %bm%
    ;SendInput, %bm%
    ;Sleep 300
    ;Send,{Enter}
    WinActivate,ahk_id %fox%
    Sleep 500
    Send,^+o
    ;clipboard = %msg%
    Sleep 4000
    Send,^v
    Sleep 200
    Send,{tab}
    Sleep 200
    Send,{space}
    return 
}










