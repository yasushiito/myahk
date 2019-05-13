;Google Chrome に表示されているページをはてブする 。
hatebucrm(){
    ;global editor := 0
    global work := 0
    ; 作業ウィンドウ探す。
    detectchrome()
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    ;warnBox(editor = 0, 201)
    warnBox(work = 0, 202)
    Process,Exist,eltest.exe
    eltest := %ErrorLevel%
    warnBox(eltest = 0, 204)
    ; 作業ウィンドウに切り替えて埋め込みたいページを全面にする。
    WinActivate,ahk_exe eltest.exe
    Sleep 100
    Send,^d
    ;WinActivate,ahk_id %editor%
    ;Sleep 500
    ;Send,^a
    ;Sleep 500
    ;Send,^x
    ;Sleep 200
    ;msg := clipboard
    WinActivate,ahk_id %work%
    ;bm := clipboard
    Sleep 100
    Send,^b
    Sleep 4000
    ;clipboard = %msg%
    Send,^v
    Sleep 100
    Send,{tab}
    Sleep 100
    Send,{space}
    return
}












