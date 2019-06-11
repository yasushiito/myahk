;ブラウザでタブを切り替えながらページを探す。
;戻り値はタブが見つかった場合 TRUE 見つからなかった場合 false が戻ります。
;ブラウザのウィンドウハンドルと探したいページタイトルをパラメータに渡す。
;ページタイトルで判断できない時には第3パラメータ URL で指定できる。
;URL が一致するものを対象とします。
;第3パラメータは URL で省略可能とします。完全一致ではなく含まれていれば有効となります。
;第2パラメータのタイトルは省略できませんが、空文字列を渡せばタイトルは無視して URL だけでタブを探します。今のところ左一致で判断していますので、タイトルの途中の文字で判定することはできません。
;第2第3パラメータ両方与えれば両方一致した物を探します。
selecttab(wnd, title, url=""){
    Sleep 100
    WinActivate,ahk_id %wnd%
    ; 現在のページタイトルを覚えておく、これはタブ切り替えを永久に繰り返さないために使う 。
    WinGetActiveTitle, current
    Sleep 100
    urlfunc := 0
    pos := RegExMatch(current,"- Google Chrome$")
    if pos > 0
        urlfunc := 1
    pos := RegExMatch(current," - Mozilla Firefox$")
    if pos > 0
        urlfunc := 2
    warnBox(urlfunc = 0, 401)
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
            if urlfunc = 1
                currenturl := getbrowserurl(True)
            Else if urlfunc = 2
                currenturl := getfirefoxurl()
            Else
                currenturl := ""
            IfInString, currenturl, %url%
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
