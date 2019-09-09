;作業用ウィンドウで開いているGithub 上のファイルを編集中のブログに挿入する。
;ブログ編集を支援するための機能。
;ブログ記事編集中に紹介したいファイルの内容を引用して記事のページに挿入する。
;タブの中からGitHubのページを探索するものの、ドメイン名の一致だけで判断しているので完全ではない。
;必ず紹介したいコードのページをカレントタブにしておくこと。
;
;実行前に次のことを確認すること 。
;編集フォームの本文の記事を挿入する場所に入力カーソルを配置しておくこと。
;同一 Chrome のタブでGitHubのファイルを表示しでいること。
;ソースコードは次のサービスを利用して成形されて表示される。
;http://gist-it.appspot.com/
;
;作成と修正の経緯。
;http://yasushiito.hatenablog.com/entry/2019/05/19/155429
blogrefgithub(workurl){
    global work
    ; 作業ウィンドウ探す。
    if (!work or work = 0)
        detectwork(workurl)
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(work = 0, 202)
    ; 作業ウィンドウに切り替える。
    Sleep 100
    WinActivate,ahk_id %work%
    Sleep 300
    ; カレントタブがGitHubを選択してなければタブの中から探してみる。
    github := selecttab(work,"", "https://github.com/")
    warnBox(github = False, 301)
    
    ; URL バーをフォーカスして URL をすべて選択してコピー 。
    getbrowserurl()
    ; クリップボードの内容を URL として取り出して埋め込みリンクの文字列を生成してクリップボードに入れる 。
    url := clipboard
    clipboard = <script src="http://gist-it.appspot.com/%url%"></script>
    ; ブラウザのタブを切り替えながら編集ホームを探す 。
    entry := selecttabblogentry(work)
    warnBox(entry = False, 302)
    ; 編集ホームに切り替わったらリンクを貼り付ける。
    Send,^v
    return
}
