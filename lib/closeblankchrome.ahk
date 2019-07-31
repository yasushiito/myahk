;起動中の Chrome のウィンドウで新しいタブを開いている物をキーボードショートカットで閉じる。
;新しいタブだけの無駄なウインドウを閉じる効果がある。
closeblankchrome(){
    WinGet, windows, list
    loop ,%windows%
    {
        idstr := "ahk_id " . windows%A_Index%
        WinGetTitle,title,%idstr%
        pos := RegExMatch(title,"- Google Chrome$")
        if pos > 0
        {
            ;ウィンドウをアクティブにして URL を取得する。
            WinActivate, %idstr%
            url := getbrowserurl()
            ;新しいタブの URL の判別を行う。
            pos := RegExMatch(url,"chrome\:\/\/newtab\/")
            if pos > 0
            {
                ;カレントタブを閉じるキーボードショートカットを送信してタブを閉じる。
                ;全てのタブが閉じられればウィンドウも同時に閉じられる。
                Send, ^w
            }
        }
    }
    return
}
