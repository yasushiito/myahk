; はてなブログの新規エントリーを用意する。
;新規エントリーページは作業用ウィンドウで開かれる。
;音声入力用ウィンドウのテキストをタイトルに利用する。
;テキストの内容はeltestによって展開される。
;タイトルに特定のキーワードが含まれていた場合、templateエレクトリの下のテンプレートファイルを読み込んで記事本文に貼り付ける。
;クリップボードの内容は破壊される 。
blogentry(hatena, editorurl, workurl){
    global editor
    global work
    if (!editor or editor = 0)
        detecteditor(editorurl)
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(!editor, 201)
    if (!work or work = 0)
        detectwork(workurl)
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(!work, 202)
    ; 作業ウィンドウに切り替える 。
    Sleep 100
    WinActivate,ahk_id %work%
    Sleep 100
    ; 新規タブを開いて。
    Send,^t
    ; ページが開くのをしっかり待ってから。
    Sleep 1500
    ; 新規エントリページを開く。
    Clipboard := "http://blog.hatena.ne.jp/" . hatena . "/" . hatena . ".hatenablog.com/edit"
    Send, ^v
    Send,{enter}
    Sleep 3000
    ;バックアップを復元するメッセージが表示されていることがあるので 復元ボタンに移動。
    ;メッセージがない場合はタイトルに移動して enter を空打ちして フォーカスを本部に移動させる。
    ;ここで SHIFT + tab 入力すれば必ず入力フォーカスがタイトルに移動しているので不確定要素がなくなる。
    Send,+{Tab}
    Sleep 100
    Send,{enter}
    Sleep 100
    ;音声入力ウィンドウのテキストを加工しながらクリップボードに放り込む。
    importEditorText(editorurl)
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
    Clipboard := t
    ; タイトルにフォーカスを移す 。
    Send,+{Tab}
    Sleep 100
    ;変換されたタイトルを貼り付け。
    Send,^v
    Sleep 300
    ; フォーカスをタイトルから本文のテキストエリアに移す 。
    Send,{Tab}
    Sleep 100
    return
}
