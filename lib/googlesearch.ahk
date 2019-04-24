; スクリーンキーボードなどを右に配置する。
googlesearch(){
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
    If (editor = 0) return
    If (work = 0) return
    Sleep 300
    WinActivate,ahk_id %work%
    Sleep 300
    Send,^t
    Sleep 800
    Send,{tab}
    Sleep 300
    ; ctrl+shift+.マイクをオンにする。
    Send,^+{vkbesc34}
    WinGetPos, x,y,w,h,ahk_id %work%
    CoordMode, Mouse, Screen
    x:= x+Floor(w*3/4)
    y += 200
    MouseMove, %x%, %y%, 10

    return




}
