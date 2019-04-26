;作業用ウィンドウで開いているページを編集中のブログに選択文字列でリンク挿入する 。
blogrefsel(){
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
    ; ブラウザのタブを切り替えながら編集ホームを探す 。
    if selecttab(work,"ブログ記事編集 - はてなブログ")
    ; 編集ホームに切り替わったらリンクを貼り付ける。
    {
        ; 入力フォームで選択中の文字をカットする。
        Send,^x
        Sleep 200
        t := clipboard
        ; URL と選択文字列から埋め込みタグ生成する。
        u := "[" . url . ":title=" . t . "]"
        clipboard = %u%
        Sleep 200
        Send,^v
    }
    return
}












