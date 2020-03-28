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
    warnBox(editor = 0, 201)
    if (!work or work = 0)
        detectwork(workurl)
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
    Clipboard := "http://blog.hatena.ne.jp/" . hatena . "/" . hatena . ".hatenablog.com/edit"
    Send, ^v
    Send,{enter}
    Sleep 3000
    ;音声入力ウィンドウのテキストを加工しながらクリップボードに放り込む。
    importEditorText(editorurl)
    ;作業ウィンドウのエントリページに切り替えて。
    WinActivate,ahk_id %work%
    Sleep 100
    ;前回編集の途中でフォームを閉じるとバックアップが残ることがある。
    ;この状態では本文にテンプレートを挿入した後にタイトルに移ってタイトルを貼り付けようとした時に復元ボタンに引っかかって失敗する。
    ;そこでひとまず先に復元ボタンを消す作業を行う。
    ;本文から SHIFT + tab でフォーカス移動すると、タイトルまたは復元ボタンに移動する。
    ;この状態で Ctrl + Enter すると、 タイトルにフォーカスがある時は何も起こらず、復元ボタンの時はボタンが消える。
    ;この状態で tab キー送信で、どちらのパターンも本文にフォーカスを持つ状態になる。
    ;普通にエンターするだけだと、タイトルにフォーカスがあるときに本文に移動してしまう。
    Send,+{Tab}
    Sleep 100
    Send,^{enter}
    Sleep 100
    Send,{Tab}
    Sleep 100
    ; クリップボードにコピーしたタイトルに特定のキーワードが含まれているか検査する。
    t := Clipboard
    ;タイトルの末尾が句読点で終わっているのがダサいので削除する。
    ;ただし文章の途中は削除しない。
    t := RegExReplace(t, "。`n$", "")
    ;/ahkが含まれていたら Auto HOT key 向けのテンプレートを読み込んで本文に貼り付ける。
    pos := RegExMatch(t, "\/ahk")
    if pos > 0
    {
        ;タイトルのキーワードahkを見出しかっこに置き換える。
        t := RegExReplace(t, "\/ahk", "【AutoHotkey】")
        FileRead, Clipboard,%A_ScriptDir%\template\blogahk.txt
        If ErrorLevel <> 0
            Clipboard := "テンプレートファイルが開けませんでした。"
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
