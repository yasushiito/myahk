;Google Chrome に表示されているページをはてブする 。
hatebucrm(){
    global editor := 0
    global work := 0
    ; 作業ウィンドウ探す。
    detectchrome()
    If editor = 0 return
    If work = 0 return
    ; 作業ウィンドウに切り替えて埋め込みたいページを全面にする。
    Process,Exist,eltest.exe
    eltest := %ErrorLevel%
    If (eltest = 0) return
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












