; スクリーンキーボードなどを右に配置する。
toolright(){
    editor := 0
    work := 0
    kbd := 0
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
        pos := RegExMatch(title,"スクリーン キーボード")
        if pos > 0
        {
            WinGet,kbd,ID,%idstr%
        }
    }

    If (editor <> 0) {
        WinMove,ahk_id %editor%, ,-300,-250,900,600
    }
    If (work <> 0) {
        WinMove,ahk_id %work%, ,600,20,1200,1050
    }
    kbd := %ErrorLevel%
    If (kbd <> 0) {
        ;WinMove,ahk_exe osk.exe, ,113,48
    }
    Process,Exist,eltest.exe
    eltest := %ErrorLevel%
    If (eltest <> 0) {
        WinMove,ahk_exe eltest.exe, ,175,470,450,360
    }
    return








}
