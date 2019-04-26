selecttab(wnd, title){
    Sleep 100
    WinActivate,ahk_id %wnd%
    ; 現在のページタイトルを覚えておく、これはタブ切り替えを永久に繰り返さないために使う 。
    WinGetActiveTitle, current
    Sleep 100
    ; ブラウザのタブを切り替えながら編集ホームを探す 。
    Loop
    {
        Send,^{Tab}
        Sleep 200
        ; 編集フォームのページタイトル名は必ずこれであるはず 。
        IfWinExist,%title%
        {
            return True
        }
        ;編集訪問が見つからない時はタブ切り替えが一周して戻って来るので判定して永久ループを開始する 。
        WinGetActiveTitle, active
        if current = %active%
        {
            return False
        }
    }
    return
}












