;作業用ウィンドウで開いているページを編集中のブログに選択文字列でリンク挿入する 。
blogrefsel(){
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
    Sleep 500
    WinActivate,ahk_id %work%
    Sleep 500
    Send,^l
    Sleep 500
    Send,^a
    Sleep 500
    Send,^c
    WinGetActiveTitle, current
    Sleep 500
    url := clipboard
    Loop
    {
        Send,^{Tab}
        Sleep 500
        IfWinExist,ブログ記事編集 - はてなブログ
        {
            Send,^x
            Sleep 500
            t := clipboard
            u := "[" . url . ":title=" . t . "]"
            clipboard = %u%
            Sleep 500
            Send,^v
            break
        }
        WinGetActiveTitle, active
        if current = %active%
        {
            break
        }
    }
    return
}












