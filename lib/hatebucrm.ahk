;Google Chrome に表示されているページをはてブする 。
hatebucrm(editorurl, workurl){
    global work
    ; 作業ウィンドウ探す。
    if (!work or work = 0)
        detectwork(workurl)
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(work = 0, 202)
    ;音声入力ウィンドウのテキストを加工しながらクリップボードに放り込む。
    importEditorText(editorurl)
    WinActivate,ahk_id %work%
    Sleep 100
    ;はてブツールバーのブックマークポップアップを開く。
    Send,^b
    Sleep 2000
    ;クリップボードのテキストをコメント欄に貼り付ける。
    Send,^v
    Sleep 100
    ;Twitter にも投稿するチェックボックスにうつってチェックする。
    Send,{tab}
    Sleep 100
    Send,{space}
    return
}
