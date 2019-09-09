; Google Chrome で開かれた音声入力エディタを URL で探す。
;第1パラメータで与えられた URL を開いているのが音声エディタのウィンドウである。
detecteditor(url){
    global editor
    IfWinExist, ahk_id %editor%
        Return editor
    editor := 0
    ;念のためクリップボードをバックアップしておく。
    cb := Clipboard
    WinGet, windows, list
    ;全てのウィンドウを調べる。
    loop ,%windows%
    {
        idstr := "ahk_id " . windows%A_Index%
        ;ウィンドウタイトルの末尾を調べて Chrome だけに対して処理を行う。
        WinGetTitle,title,%idstr%
        pos := RegExMatch(title,"- Google Chrome$")
        if pos > 0
        {
            WinGet,wid,ID,%idstr%
            ;Chrome をアクティブにしてキーボードショートカットから URL を取得する。
            WinActivate,ahk_id %wid%
            ;Chrome Extension Copy all URLs を起動して ウィンドウで開いているすべてのタブの URL を取得する。
            Send, !+c
            ;作業ウインドウを特定付ける URL を開いているWindows であれば作業用ウィンドウとする。
            StringGetPos, pos, Clipboard, %url%
            if ErrorLevel = 0
            {
                editor := wid
                Break
            }
        }
    }
    ;クリップボードにバックアップを返す。
    Clipboard := cb
    return editor
}
