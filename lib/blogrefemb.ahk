;作業用ウィンドウで開いているページを編集中のブログにリンク挿入する。
;ブログ編集を支援するための機能。
;ブログ記事編集中に参考にしたページの埋め込みリンクを生成して記事のページに挿入する。
;
;実行前に次のことを確認すること 。
;編集フォームの本文の記事を挿入する場所に入力カーソルを配置しておくこと。
;参考にしたページのタブを選んでいること。
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
    ; URL バーをフォーカスして URL をすべて選択してコピー 。
    getbrowserurl()
    ; クリップボードの内容を URL として取り出して埋め込みリンクの文字列を生成してクリップボードに入れる 。
    url := clipboard
    clipboard = [%url%:embed:cite]
    ; ブラウザのタブを切り替えながら編集ホームを探す 。
    if selecttabblogentry(work)
        ; 編集ホームに切り替わったらリンクを貼り付ける。
        Send,^v
    return
}












