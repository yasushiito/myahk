;アクティブウィンドウで選択している単語を Google 検索。
;アクティブにされているアプリケーションの種類によって選択単語の切り取り方が変わることもある。
;Visual Studio Code では利用言語を調べて言語を絞り込む。
;Chrome では表示中のページを調べて検索オプションを変更する。

wordgooglesearch(workurl){
    ;作業ウインドウを検索ブラウザとするために ID をグローバル変数からもらう。
    global work
    ;アクティブウィンドウを記憶しておく。
    WinGet, target, ID, A
    ;タイトルを取得する。
    WinGetActiveTitle, title
    ;アクティブウィンドウにふさわしい検索ワードをクリップボードにセットしてもらう。
    googlesearchfordomain(target, title)
    if clipboard=
    {
        MsgBox, , , 検索ワードが選択されていません。, 5
        return
    }
    ;作業ウィンドウをアクティブにして新しいタブから Google 検索する。
    if (!work or work = 0)
        detectwork(workurl)
    WinActivate, ahk_id %work%
    ;新しいタブが開くのを少し待ってから検索ワードを貼り付けて検索する。
    Send, ^t
    Sleep, 500
    Send,^v
    Sleep, 100
    Send, {Enter}
    return
}
;ドメインごとに適切な検索ワードを生成してクリップボードにセットする。
googlesearchfordomain(target, title){
    ;アプリケーションの種類を判別するためにプロセス名を取得する。
    WinGet, pn, ProcessName, ahk_id %target%
    ;Visual Studio CODE の場合。
    if pn = Code.exe
    {
        searchvscode(target, title)
        return
    }
    ;Chromeの場合はタイトルから判別する。
    pos := RegExMatch(title,"- Google Chrome$")
    if pos > 0
    {
        searchchrome(target, title)
        return
    }
    ;何のドメインにも該当しなかったら単純に選択テキストをコピーする。
    ;アプリケーションによっては何もコピーできないことがあるのでクリップボードをクリア。
    clipboard := ""
    Send, ^c
    Sleep, 100
    return
}
;Visual Studio CODE のソースコード上にあるワードを検索する場合。
searchvscode(target, title){
    ;開いているファイルの言語名を調べる。
    lang := titletolang(title)
    ;Visual Studio CODE をアクティブにして Ctrl + D でカーソル周辺の単語を選択する。
    WinActivate, ahk_id %target%
    Send, ^d
    Sleep, 100
    ;クリップボードに言語名称と選択した単語をセットして返す。
    Send, ^c
    Sleep, 100
    word := lang . " "
    word .= clipboard
    clipboard := word
    return
}
;ウィンドウタイトルからソースコードの言語名を推察する。
;言語名が不明な時はから文字列を返す。
titletolang(title)
{
    res :=
    ;ファイル名の後ろにハイフンで区切った単語が言語の名称と思われる。
    x := RegExMatch(title, "\- autohotkey")
    if x > 0
        res := "autohotkey"
    return res
}
;Chrome から検索ワードを拾う場合。
;自分のはてなブログでキーワード選択している場合は過去の記事限定で検索する。
;検索ワードはクリップボードに設定して帰される。
;自分のはてな ID をグローバル変数に読み込んでおく必要がある。
searchchrome(target, title){
    global hatenaid
    ;表示ページが自分のブログであるかを判定するためにクロームに切り替えてページの URL を取得。
    WinActivate, ahk_id %target%
    url := getbrowserurl()
    ;選択中の単語をクリップボードに送る。
    ;テキスト選択されていないことを考慮してクリップボードはクリアしておく。
    clipboard := ""
    Send, ^c
    Sleep, 100
    ;自分のブログに限定する検索オプション。
    opt := " site:" . hatenaid . ".hatenablog.com "
    ;編集ページの URL の場合。
    IfInString, url, blog.hatena.ne.jp/%hatenaid%, {
        clipboard .= opt
        return
    }
    ;表示中の記事から検索ワードを拾うとき。
    IfInString, url, %hatenaid%.hatenablog.com, {
        clipboard .= opt
        return
    }
    return
}

