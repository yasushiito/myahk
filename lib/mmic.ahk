mmic(editorurl){
    global editor
    ; 作業ウィンドウ探す。
    if (!editor or editor = 0)
        detecteditor(editorurl)
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(editor = 0, 201)
    Sleep 200
    WinActivate, %editor%
    Sleep 200
    Send,+^s
    return
}
