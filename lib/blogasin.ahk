;作業用ウィンドウで開いているAmazon の商品紹介を編集中のブログに挿入する。
;ブログ編集を支援するための機能。
;タブの中からAmazonのページを探索するものの、ドメイン名の一致だけで判断しているので完全ではない。
;必ず紹介したい商品のページをカレントタブにしておくこと。
;
;実行前に次のことを確認すること 。
;編集フォームの本文の記事を挿入する場所に入力カーソルを配置しておくこと。
;同一 Chrome のタブでAmazon の商品ページを表示していること。
;
;作成と修正の経緯。
;http://yasushiito.hatenablog.com/entry/2019/05/08/073000
;http://yasushiito.hatenablog.com/entry/2019/05/21/094015
blogasin(){
    global editor := 0
    global work := 0
    ; 作業ウィンドウ探す。
    detectchrome()
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(editor = 0, 201)
    warnBox(work = 0, 202)
    ; 作業ウィンドウに切り替えて埋め込みたいページを全面にする。
    Sleep 300
    WinActivate,ahk_id %work%
    Sleep 300
    ; カレントタブがamazonを選択してなければタブの中から探してみる。
    amazon := selecttab(work,"", "https://www.amazon.co.jp/")
    warnBox(amazon = False, 303)
    
    ; URL バーをフォーカスして URL をすべて選択してコピー 。
    getbrowserurl()
    ; クリップボードの内容を URL として取り出して埋め込みリンクの文字列を生成してクリップボードに入れる 。
    url := clipboard
    asin := ""
    ;正規表現を使って asin コードらしい部分を取り出す。
    pos := RegExMatch(url,"dp/\w*", dpasin)
    ;見つかった場合。
    If pos > 0
    {
        ; dp/を取り除いて完全な asin コードにする。
        StringReplace, asin, dpasin, dp/
    }
    ;正規表現を使って asin コードらしい部分を取り出す。
    pos := RegExMatch(url,"gp/product/\w*", gpasin)
    ;見つかった場合。
    If pos > 0
    {
        ; gp/product/を取り除いて完全な asin コードにする。
        StringReplace, asin, gpasin, gp/product/
    }
    ;asin コードが見つからなかったら処理を中止。
    If StrLen(asin) = 0
        return
    ; アマゾンのタグを生成してクリップボードに転送する。
    clipboard = [asin:%asin%:detail]
    ; ブラウザのタブを切り替えながら編集ホームを探す 。
    entry := selecttabblogentry(work)
    warnBox(entry = False, 302)
    ; 編集ホームに切り替わったらリンクを貼り付ける。
    Send,^v
    return
}
