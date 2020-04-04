; 作業用 Chrome で新規タブを開いてパラメータで指定された URL を開く。
OpenWork(url, workurl){
    global work
    ; 作業ウィンドウ探す。
    if (!work or work = 0)
        detectwork(workurl)
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(work = 0, 202)
    Sleep 100
    WinActivate,ahk_id %work%
    ;新規タブを開いて。
    Send,^t
    Sleep 800
    ;クリップボード経由でパラメータの URL を入力してページを開く。
    Clipboard := url
    Send,^v
    Sleep 100
    Send,{Enter}

    return
}
