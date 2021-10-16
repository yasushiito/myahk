﻿; 作業用 Chrome で検索タブを開いて音声検索する。
googlesearch(workurl){
    global work
    ; 作業ウィンドウ探す。
    if (!work or work = 0)
        detectwork(workurl)
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(work = 0, 202)
    Sleep 100
    WinActivate, ahk_id %work%, ,%editor%
    ;WinActivate,ahk_id %work%
;    Sleep 300
;    WinWaitActive, ahk_id %work%, ,2
    ;新規タブを開いて検索ページをアクティブにする。
    Send,^t
    Sleep 800
    ;アドレスバーからメインウィンドウに戻ってキーボードショートカットから音声検索するには、シフトを押しながら Tab でないと機能しない。
    Send,+{tab}
    Sleep 100
    Send,+{tab}
    Sleep 100
    ; ctrl+shift+.マイクをオンにする。
    Send,^+{vkbesc34}
    ;マウスポインターを移動させて再検索またはヒットページのクリックに備える。
    WinGetPos, x,y,w,h,ahk_id %work%
    CoordMode, Mouse, Screen
    ;多分この辺が使いやすい。
    x:= x+Floor(w*3/4)
    y += 200
    MouseMove, %x%, %y%, 10

    return
}
