;。
blogasin(){
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
    if selecttab(work,"ブログ記事編集 - はてなブログ")
        ; 編集ホームに切り替わったらリンクを貼り付ける。
        Send,^v
    return
}












