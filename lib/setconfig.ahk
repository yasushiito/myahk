setconfig(){
    global editorurl
    global workurl
    global hatenaid
    global messengerfriendid
    global radikoch
;入力ダイアログを作成する。
    Gui, add, text, ,音声入力エディタの URL
    Gui, add, edit, veditorurl w200, %editorurl%
    Gui, add, text, ,作業用ウインドウの URL
    Gui, add, edit, vworkurl w200, %workurl%
    Gui, add, text, ,はてなブログの ID
    Gui, add, edit, vhatenaid w200, %hatenaid%
    Gui, add, text, ,メッセンジャーでチャットしたい相手の ID
    Gui, add, edit, vmessengerfriendid w200, %messengerfriendid%
    Gui, add, text, ,Funcキーで radiko を開く(放送局名をカンマ区切り)
    Gui, add, edit, vradikoch w200, %radikoch%
    Gui, Add, Button, W100 X25 Default gsubmit, OK
    Gui, Add, Button, W100 X+10, Cancel
;ダイアログを表示する。
    Gui, Show,, 設定
    Return

}
;ダイアログの OK ボタンを押された時の処理。
submit:
    Gui, Submit
;入力された値を保存する。
    ;音声入力エディタの URL。
    IniWrite, %editorurl%, %A_ScriptDir%\conf.ini, user, editorurl
    ;作業用ウインドウの URL。
    IniWrite, %workurl%, %A_ScriptDir%\conf.ini, user, workurl
    ;はてなブログの ID。
    IniWrite, %hatenaid%, %A_ScriptDir%\conf.ini, user, hatenaid
    ;メッセンジャーの特定のお気に入り。
    IniWrite, %messengerfriendid%, %A_ScriptDir%\conf.ini, user, messengerfriendid
    ;Radiko の放送局リストをカンマ区切り。
    IniWrite, %radikoch%, %A_ScriptDir%\conf.ini, user, radikoch
    Return
;ダイアログのキャンセルボタン押された時の処理。
ButtonCancel:
    Gui, Destroy
    Return