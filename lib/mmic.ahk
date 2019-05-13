mmic(editorurl){
    global editor := 0
    ; 作業ウィンドウ探す。
    detectchrome()
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(editor = 0, 201)
    Sleep 100
    WinActivate,ahk_id %editor%
    Sleep 100
    Send,+^s
    return
}
