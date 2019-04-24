mmic(editorurl){
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

    If (editor <> 0) {
        Sleep 500
        WinActivate,ahk_id %editor%
        Sleep 500
        Send,+^s
    }
    Else
    {
        if work = 0
        {
            run,"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
            WinWait,ahk_exe chrome.exe, , 5
            If ErrorLevel <> 0
            {
                MsgBox, Google Chrome が起動できませんでした
                Return
            }
        }
        SetTitleMatchMode,2
        WinActivate,- Google Chrome
        Sleep 500
        Send,^n
        Sleep 500
        SendInput,%editorurl%
        Send,{enter}
        Sleep 3000
        Send,+^s
    }
    return
}
