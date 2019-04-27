;作業用ウィンドウで開いているGithub 上のファイルを編集中のブログに挿入する。
;ブログ編集を支援するための機能。
;ブログ記事編集中に紹介したいファイルの内容を引用して記事のページに挿入する。
;
;実行前に次のことを確認すること 。
;編集フォームの本文の記事を挿入する場所に入力カーソルを配置しておくこと。
;同一 Chrome のタブでGitHubのファイルを表示したタブを選んでいること。
;ソースコードは次のサービスを利用して成形されて表示される。
;http://gist-it.appspot.com/
blogrefgithub(){
    global editor := 0
    global work := 0
    ; 作業ウィンドウ探す。
    detectchrome()
    If editor = 0 return
    If work = 0 return
    ; 作業ウィンドウに切り替えて埋め込みたいページを全面にする。
    Sleep 300
    WinActivate,ahk_id %work%
    Sleep 300
    ; URL バーをフォーカスして URL をすべて選択してコピー 。
    getbrowserurl()
    ; クリップボードの内容を URL として取り出して埋め込みリンクの文字列を生成してクリップボードに入れる 。
    url := clipboard
    clipboard = <script src="http://gist-it.appspot.com/%url%"></script>
    ; ブラウザのタブを切り替えながら編集ホームを探す 。
    if selecttab(work,"ブログ記事編集 - はてなブログ")
        ; 編集ホームに切り替わったらリンクを貼り付ける。
        Send,^v
    return
}
