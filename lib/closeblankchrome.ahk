;起動中の Chrome のウィンドウで新しいタブを開いている物をキーボードショートカットで閉じる。
;新しいタブだけの無駄なウインドウを閉じる効果がある。
closeblankchrome(url=""){
    WinGet, windows, list
    loop ,%windows%
    {
        idstr := "ahk_id " . windows%A_Index%
        WinGetTitle,title,%idstr%
        pos := RegExMatch(title,"- Google Chrome$")
        if pos > 0
        {
            ;ウィンドウをアクティブにする。
            WinActivate, %idstr%
            if url =
                ;閉じるウィンドウを URL で指定されていないならカレントウィンドウを閉じるキーボードショートカットを送信。
                Send, ^+w
            Else
            {
                ;閉じるウィンドウを URL で指定しているならブラウザの URL を取得して判別を行う。
                ;クリップボード送信しても何も入らないこともあるので事前に clipboard に URL を放り込んでおいて変化を観察する。
                Clipboard := url
                burl := getbrowserurl()
                ;タブの URL の判別を行う。
                StringGetPos, pos, burl, %url%
                if (ErrorLevel = 0)
                {
                    ;カレントタブを閉じるキーボードショートカットを送信してタブを閉じる。
                    ;全てのタブが閉じられればウィンドウも同時に閉じられる。
                    Send, ^w
                }
            }
        }
    }
    return
}
