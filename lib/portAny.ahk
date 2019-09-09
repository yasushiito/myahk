;音声入力エディタのテキストをアクティブウィンドウにコピペする。
;貼り付けたいのウィンドウを事前にアクティブにしてカーソルを移動させておくこと。
portany(editorurl){
    WinGet, dst, ID, A
    BlockInput, on
    ;音声入力ウィンドウのテキストを加工しながらクリップボードに放り込む。
    importEditorText(editorurl)
    ;作業ウィンドウのエントリページに切り替えて。
    WinActivate,ahk_id %dst%
    Sleep 100
    ;テキストをペーストする。
    Send,^v
    BlockInput,off
    return 
}
