; スクリーンキーボードなどを左に配置する。
toolleft(){
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
        pos := RegExMatch(title,"スクリーン キーボード$")
        if pos > 0
        {
            WinGet,kbd,ID,%idstr%
        }
    }

    y := 0
    ;kbd := %ErrorLevel%
    If (kbd <> 0) {
        ;WinMove,ahk_exe osk.exe, ,113,48
        WinGetPos, , y, , , ahk_exe osk.exe
    }
    If (editor <> 0) {
        if y > 600
        {
            WinMove,ahk_id %editor%, ,-120,-220,900,600
        }
        else
        {
            WinMove,ahk_id %editor%, ,-120,500,900,600

        }
    }
    If (work <> 0) {
        WinMove,ahk_id %work%, ,600,20,1200,1050
    }
    Process,Exist,eltest.exe
    eltest := %ErrorLevel%
    If (eltest <> 0) {
        WinMove,ahk_exe eltest.exe, ,175,470,420,320
    }
    Process,Exist,explorer.EXE
    explorer := %ErrorLevel%
    If (explorer <> 0) {
        WinMove,ahk_exe explorer.EXE, ,533,200
    }
    Process,Exist,code.exe
    code := %ErrorLevel%
    If (code <> 0) {
        WinMove,ahk_exe code.exe, ,590,30,1100,1080
    }
    return








}
