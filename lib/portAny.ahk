;音声入力エディタのテキストをアクティブウィンドウにコピペする。
;貼り付けたいのウィンドウを事前にアクティブにしてカーソルを移動させておくこと。
portany(){
    global editor
    WinGet, dst, ID, A
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(editor = 0, 201)
    BlockInput, on
    ;音声入力ウィンドウのテキストを加工しながらクリップボードに放り込む。
    importEditorText(False)
    ;作業ウィンドウのエントリページに切り替えて。
    WinActivate,ahk_id %dst%
    Sleep 100
    ;テキストをペーストする。
    Send,^v
    BlockInput,off
    return 
}
