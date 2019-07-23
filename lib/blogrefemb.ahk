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
    ;参照元への誘導のタイトルに使うページタイトルを取得する。
    WinGetActiveTitle, title
    ;ウィンドウタイトルに含まれるブラウザ名称を取り除く。
    title := RegExReplace(title,"- Google Chrome$", "")
    ;選択されているテキストの取得を試みる。
    selectedtext := getselectedtext()
    ;テキストの選択が発見されたらドメインごとに適切な引用を行う。
    If strlen(selectedtext) > 0
    {
        ;選択範囲が改行で終わっている場合、改行がダブらないように一度削除してしまう。
        selectedtext := RegExReplace(selectedtext, "\n$" , "")
        ;ドメインごとに適切な引用を行う。
        txt := clipblockquotefordomain(url, title, selectedtext)
    }
    Else
    {
        ;ドメインごとに適切な引用を行う。
        txt := clipembedfordomain(url, title)

    }
    ; ブラウザのタブを切り替えながら編集ホームを探す 。
    if selecttabblogentry(work)
        ; 編集ホームに切り替わったらリンクを貼り付ける。
        Send,^v
    return
}
;クリップボードを使って選択されているテキストを返す。
getselectedtext(){
    ;あらかじめクリップボードを空にしておいて Ctrl + C で何らかのテキストがクリップボードにコピーされたならソースコードの一部を選択していたと判定する。
    clipboard :=
    Send, ^c
    res := clipboard
    return res
}
;ドメインごとに適切な引用スタイルでタグを生成してクリップボードにセットする。
clipblockquotefordomain(url, title, selectedtext){
    ;GitHubページからソースコードを引用するならタグを受け取る。
    txt := blockquotegithub(url, title, selectedtext)
    ;引用文字列が帰ってきたならクリップボードに転送して呼び出し元に復帰する。
    if strlen(txt) > 0
    {
        clipboard := txt
        return
    }
    ;YouTube のサムネイルならタグを受け取る。
    txt := blockquoteyoutube(url, title, selectedtext)
    ;引用文字列が帰ってきたならクリップボードに転送して呼び出し元に復帰する。
    if strlen(txt) > 0
    {
        clipboard := txt
        return
    }
    ;対応すべきドメインが見つからないので汎用の引用スタイルでタグを返す。
    txt :=
    ;引用のタグを生成する。
    ;txt := ">>`n" . selectedtext . "`n<<`n"
    txt := "><blockquote cite=""" . url . """><p>" . selectedtext . "</p><cite><a href=""" . url . """>" . title . "</a></cite></blockquote><`n"
    ;クリップボードに転送して呼び出し元に復帰する。
    clipboard := txt
    return
}
;GitHubページのソースコードを引用する形のタグを返す。
;無関係の URL なら空文字列を返す。
blockquotegithub(url, title, selectedtext){
    res :=
    ; URL がGitHubドメインであればソースコードの引用の可能性あり。
    x := RegExMatch(url, "^https\:\/\/github\.com\/")
    if x > 0
    {
        ;シンタックスハイライトのための言語名を URL から推測する。
        lang := urltolang(url)
        ;スーパー pre 記法による引用のタグを生成する。
        res := ">|" . lang . "|`n" . selectedtext . "`n||<`n"
        ;参照元への リンクのタグを生成する。
        res := res . "<cite><a href=""" . url . """>" . title . "</a></cite>`n"
    }
    ;無関係の URL なら空文字列を返す。
    return res 
}
;YouTube のサムネイルを引用する形のタグを返す。
;無関係の URL なら空文字列を返す。
blockquoteyoutube(url, title, selectedtext){
    res :=
    ; URL がYouTubeドメインであればサムネイルの可能性あり。
    x := RegExMatch(url, "^https\:\/\/www\.youtube\.com\/watch")
    if x > 0
    {
        ;正規表現を使って idらしい部分を取り出す。
        pos := RegExMatch(url,"v\=\w*", vid)
        ;見つかった場合。
        If pos > 0
        {
            ; 無駄な文字を取り除いてサムネイルへの URL にする。
            StringReplace, videoid, vid, v=
            vurl := "https://img.youtube.com/vi/" . videoid . "/default.jpg"
            ;画像と引用テキストをタグにする。
            res := "[" . url . ":image=" . vurl . "]`n" . selectedtext . "`n"
        }
    }
    ;無関係の URL なら空文字列を返す。
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
clipembedfordomain(url, title){
    ;YouTube の動画を埋め込むならタグを受け取る。
    txt := embedyoutube(url, title)
    ;引用文字列が帰ってきたならクリップボードに転送して呼び出し元に復帰する。
    if strlen(txt) > 0
    {
        clipboard := txt
        return
    }

    ;特殊な引用ではなかったのでdefaultの機能である埋め込みリンクをクリップボードに転送。
    ; URL 取り出して埋め込みリンクの文字列を生成してクリップボードに入れる 。
    clipboard = [%url%:embed:cite]
    return
}
;YouTube の動画を埋め込む形のタグを返す。
;無関係の URL なら空文字列を返す。
embedyoutube(url, title){
    res :=
    ; URL がYouTubeドメインであれば動画の可能性あり。
    x := RegExMatch(url, "^https\:\/\/www\.youtube\.com\/watch")
    if x > 0
    {
        ;正規表現を使って idらしい部分を取り出す。
        pos := RegExMatch(url,"v\=\w*", vid)
        ;見つかった場合。
        If pos > 0
        {
            ; 無駄な文字を取り除いて動画の id にする。
            StringReplace, videoid, vid, v=
            ;動画を埋め込むタグにする。
            res := "<iframe width=""560"" height=""315"" src=""https://www.youtube.com/embed/" . videoid . """ frameborder=""0"" allow=""accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"" allowfullscreen></iframe>"
        }
    }
    ;無関係の URL なら空文字列を返す。
    return res 
}
