;音声入力エディタのテキストをクリップボードにカットする。
;アクティブウィンドウは音声入力ウィンドウに切り替えられる。
;クリップボードの内容は破壊される。
cutEditorText(){
    global editor := 0
    ; 作業ウィンドウ探す。
    detectchrome()
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(editor = 0, 201)
    ;音声入力エディタに切り替えて全てを選択して切り取り。
    WinActivate,ahk_id %editor%
    Sleep 100
    Send,^a
    Sleep 100
    Send,^x
    Sleep 100
    msg := clipboard
    return msg
}
