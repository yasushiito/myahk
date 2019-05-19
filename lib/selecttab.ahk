;ブラウザでタブを切り替えながらページを探す。
;ブラウザのウィンドウハンドルと探したいページタイトルをパラメータに渡す。
;ページタイトルでは判断できない時には第3パラメータ URL で指定できる。
;
selecttab(wnd, title, url=""){
    Sleep 100
    WinActivate,ahk_id %wnd%
    ; 現在のページタイトルを覚えておく、これはタブ切り替えを永久に繰り返さないために使う 。
    WinGetActiveTitle, current
    Sleep 100
    ;SetTitleMatchMode,2
    ; ブラウザのタブを切り替えながら編集ホームを探す 。
    Loop
    {
        ; ページタイトルを使ってタブ探索する。
        tm := False
        if StrLen(title) > 0
        {
            IfWinExist,%title%
                tm := True
        }
        Else
            tm := True
        ; URL を使ったタブ探索する。
        um := False
        if StrLen(url) > 0
        {
            ; URL を捕まえて正規表現で判別する。
            currenturl := getbrowserurl(True)
            pos := RegExMatch(currenturl, url)
            if pos > 0
                um := True

        }
        Else
            um := True
        ; タブが見つかったら探索を中止して TRUE を返す。
        If tm && um
            return True
        ; タブが見つからなかったら tab キーでタブを切り替える。
        Send,^{Tab}
        Sleep 100
        ;編集訪問が見つからない時はタブ切り替えが一周して戻って来るので判定して永久ループを開始する 。
        WinGetActiveTitle, active
        if current = %active%
        {
            return False
        }
    }
    return False
}












