;作業用ウィンドウで開いているページを編集中のブログにリンク挿入する。
;ブログ編集を支援するための機能。
;ブログ記事編集中に参考にしたページの埋め込みリンクを生成して記事のページに挿入する。
;対象ページがGitHubにアップロードされたファイルであればソースコードの引用として選択されたテキストを挿入する。
;
;実行前に次のことを確認すること 。
;編集フォームの本文の記事を挿入する場所に入力カーソルを配置しておくこと。
;参考にしたページのタブを選んでいること。
;参考にしたページがGitHubなら参考にした部分を選択しておくこと。
blogrefemb(){
    global editor := 0
    global work := 0
    ; 作業ウィンドウ探す。
    detectchrome()
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(editor = 0, 201)
    warnBox(work = 0, 202)
    ; 作業ウィンドウに切り替えて埋め込みたいページを全面にする。
    Sleep 100
    WinActivate,ahk_id %work%
    Sleep 100
    ; URL をクリップボードコピー 。
    url := getbrowserurl()
    ;GitHubページからソースコードを引用するならタグを受け取る。
    txt := pregithub(url)
    ;引用文字列が帰ってきたならクリップボードに転送する。
    if strlen(txt) > 0
        clipboard := txt
    Else
        ;特殊な引用ではなかったのでdefaultの機能である埋め込みリンクをクリップボードに転送。
        ; URL 取り出して埋め込みリンクの文字列を生成してクリップボードに入れる 。
        clipboard = [%url%:embed:cite]
    ; ブラウザのタブを切り替えながら編集ホームを探す 。
    if selecttabblogentry(work)
        ; 編集ホームに切り替わったらリンクを貼り付ける。
        Send,^v
    return
}
;GitHubページの差し込みならソースコードを引用する形のタグを返す。
;無関係の URL なら空文字列を返す。
pregithub(url){
    res :=
    ;あらかじめクリップボードを空にしておいて Ctrl + C で何らかのテキストがクリップボードにコピーされたならソースコードの一部を選択していたと判定する。
    clipboard :=
    Send, ^c
    selectedtext := clipboard
    ; URL がGitHubドメインであればソースコードの引用の可能性あり。
    x := RegExMatch(url, "^https\:\/\/github\.com\/")
    if x > 0
    {
        ;ソースコードの切り抜きたい部分を選択しているか。
        If strlen(selectedtext) > 0
        {
            ;シンタックスハイライトのための言語名を URL から推測する。
            lang := urltolang(url)
            ;選択範囲が改行で終わっている場合、改行がダブらないように一度削除してしまう。
            selectedtext := RegExReplace(selectedtext, "\n$" , "")
            ;参照元への誘導のタイトルに使うページタイトルを取得する。
            WinGetActiveTitle, title
            ;ウィンドウタイトルに含まれるブラウザ名称を取り除く。
            title := RegExReplace(title,"- Google Chrome$", "")
            ;スーパー pre 記法による引用のタグを生成する。
            res := ">|" . lang . "|`n" . selectedtext . "`n||<`n"
            ;参照元への リンクのタグを生成する。
            res := res . "<cite><a href=""" . url . """>" . title . "</a></cite>`n"
;            res := "><blockquote cite=""" . url . """>" . res . "<cite><a href=""" . url . """>" . title . "</a></cite></blockquote><"

        }
    }
    return res 
}
;シンタックスハイライトのための言語名を URL から推測する。
urltolang(url)
{
    res :=
    ;URL 末尾が拡張子であると断定して、拡張子によって言語名を判定する。
    ;.ahkであればAutoHotkey。
    x := RegExMatch(url, "\.ahk$")
    if x > 0
        res := "autohotkey"
    return res
}