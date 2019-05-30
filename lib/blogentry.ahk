; はてなブログの新規エントリーを用意する。
;新規エントリーページは作業用ウィンドウで開かれる。
;音声入力用ウィンドウのテキストをタイトルに利用する。
;テキストの内容はeltestによって展開される。
;タイトルに特定のキーワードが含まれていた場合、templateエレクトリの下のテンプレートファイルを読み込んで記事本文に貼り付ける。
;クリップボードの内容は破壊される 。
blogentry(hatena){
    global editor := 0
    global work := 0
    ; 作業ウィンドウ探す。
    detectchrome()
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(work = 0, 202)
    ; 作業ウィンドウに切り替える 。
    Sleep 100
    WinActivate,ahk_id %work%
    Sleep 100
    ; 新規タブを開いて。
    Send,^t
    ; ページが開くのをしっかり待ってから。
    Sleep 1500
    ; 新規エントリページを開く。
    SendInput,http://blog.hatena.ne.jp/%hatena%/%hatena%.hatenablog.com/edit
    Send,{enter}
    Sleep 3000
    ;音声入力ウィンドウのテキストを加工しながらクリップボードに放り込む。
    importEditorText(False)
    ;作業ウィンドウのエントリページに切り替えて。
    WinActivate,ahk_id %work%
    Sleep 100
    ; クリップボードにコピーしたタイトルに特定のキーワードが含まれているか検査する。
    t := Clipboard
    ;/ahkが含まれていたら Auto HOT key 向けのテンプレートを読み込んで本文に貼り付ける。
    pos := RegExMatch(t, "\/ahk")
    if pos > 0
    {
        ;タイトルのキーワードahkを見出しかっこに置き換える。
        t := RegExReplace(t, "\/ahk", "【AutoHotkey】")
        FileRead, Clipboard,%A_ScriptDir%\template\blogahk.txt
        If ErrorLevel <> 0
            Clipboard = テンプレートファイルが開けませんでした。
        Sleep 100
        ;テンプレートを本文に貼り付け。
        Send,^v
        Sleep 100
    }
    ; タイトルにフォーカスを移す 。
    Send,+{Tab}
    ;変換されたタイトルを貼り付け。
    Clipboard := t
    Send,^v
    Sleep 100
    ; フォーカスをタイトルから本文のテキストエリアに移す 。
    Send,{Tab}
    return
}
