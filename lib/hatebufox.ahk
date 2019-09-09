;Firefox で表示しているページをはてブする 。
hatebufox(){
    global editorurl
    ;global editor := 0
    ;global work := 0
    global fox := 0
    global eltest := 0
    ; firefoxウィンドウ探す。
    detectfirefox()
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(fox = 0, 203)
    ;warnBox(work = 0, 202)
    ;音声入力ウィンドウのテキストを加工しながらクリップボードに放り込む。
    importEditorText(editorurl)
    ;かつてはツールバーの調子が悪いことがあったので Chrome で開き直してブックマークしていたが安定したのでコメントにした。
    ;WinActivate,ahk_id %work%
    ;Sleep 100
    ;Send,^t
    ;Sleep 300
    ;clipboard = %bm%
    ;SendInput, %bm%
    ;Sleep 300
    ;Send,{Enter}
    ;はてブツールバーでブックマークする
    WinActivate,ahk_id %fox%
    Sleep 100
    ;ショートカットキーを送信する
    Send,^+o
    Sleep 1500
    ;クリップボードのテキストをコメント欄に貼り付ける。
    Send,^v
    Sleep 100
    ;同時に Twitter にも投稿するチェックをつける。
    Send,{tab}
    Sleep 100
    Send,{space}
    return 
}
