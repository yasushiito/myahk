;作業用ウィンドウで開いているページを編集中のブログにリンク挿入する。
;ブログ編集を支援するための機能。
;ブログ記事編集中に参考にしたページの埋め込みリンクを生成して記事のページに挿入する。
;
;実行前に次のことを確認すること 。
;編集フォームの本文の記事を挿入する場所に入力カーソルを配置しておくこと。
;参考にしたページのタブを選んでいること。
blogrefemb(){
    editor := 0
    work := 0
    WinGet, windows, list
    loop ,%windows%
    {
        idstr := "ahk_id " . windows%A_Index%
        WinGetTitle,title,%idstr%
        pos := RegExMatch(title,"- Google Chrome$")
        if pos > 0
        {
            pos := RegExMatch(title,"音声入力用")
            if pos > 0
            {
                WinGet,editor,ID,%idstr%
            }
            else
            {
                WinGet,work,ID,%idstr%
            }
        }
    }
    If (editor = 0) return
    If (work = 0) return
    Sleep 500
    WinActivate,ahk_id %work%
    ; URL バーをフォーカスして URL をすべて選択してコピー 。
    Sleep 500
    Send,^l
    Sleep 500
    Send,^a
    Sleep 500
    Send,^c
    ; 現在のページタイトルを覚えておく、これはタブ切り替えを永久に繰り返さないために使う 。
    WinGetActiveTitle, current
    Sleep 500
    ; クリップボードの内容を URL として取り出して埋め込みリンクの文字列を生成してクリップボードに入れる 。
    url := clipboard
    clipboard = [%url%:embed:cite]
    ; ブラウザのタブを切り替えながら編集ホームを探す 。
    Loop
    {
        Send,^{Tab}
        Sleep 500
        ; 編集フォームのページタイトル名は必ずこれであるはず 。
        IfWinExist,ブログ記事編集 - はてなブログ
        {
            Send,^v
            break
        }
        ;編集訪問が見つからない時はタブ切り替えが一周して戻って来るので判定して永久ループを開始する 。
        WinGetActiveTitle, active
        if current = %active%
        {
            break
        }
    }
    return
}












