; Google Chrome で開かれた作業用ウインドウを URL で探す。
;第1パラメータで与えられた URL を開いているのが作業用ウィンドウである。
detectwork(url){
    global work
    IfWinExist, ahk_id %work%
        Return work
    work := 0
    ;念のためクリップボードをバックアップしておく。
    cb := Clipboard
    ;全てのウィンドウを調べる。
    WinGet, windows, list
    loop ,%windows%
    {
        ;ウィンドウタイトルの末尾を調べて Chrome だけに対して処理を行う。
        idstr := "ahk_id " . windows%A_Index%
        WinGetTitle,title,%idstr%
        pos := RegExMatch(title,"- Google Chrome$")
        if pos > 0
        {
            WinGet,wid,ID,%idstr%
            ;Chrome をアクティブにしてキーボードショートカットから URL を取得する。
            WinActivate,ahk_id %wid%
            ;Chrome Extension Copy all URLs を起動して ウィンドウで開いているすべてのタブの URL を取得する。
            Send, !+c
            ;作業ウィンドウを特定付ける URL が含まれてイルカ調べる。
            StringGetPos, pos, Clipboard, %url%
            if ErrorLevel = 0
            {
                work := wid
                Break
            }
        }
    }
    ;クリップボードにバックアップを返す。
    Clipboard := cb
    Return work
}
