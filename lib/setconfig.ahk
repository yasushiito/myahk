setconfig(){
;入力ダイアログを作成する。
    Gui, add, text, ,音声入力エディタの URL
    Gui, add, edit, veditorurl w200, %editorurl%
    Gui, add, text, ,はてなブログの ID
    Gui, add, edit, vhatenaid w200, %hatenaid%
    Gui, Add, Button, W100 X25 Default gsubmit, OK
    Gui, Add, Button, W100 X+10, Cancel
;ダイアログを表示する。
    Gui, Show,, 設定のサンプル
    Return

}
;ダイアログの OK ボタンを押された時の処理。
submit:
    Gui, Submit
;入力された値を保存する。
    ;音声入力エディタの URL。
    IniWrite, %editorurl%, %A_ScriptDir%\conf.ini, user, editorurl
    ;はてなブログの ID。
    IniWrite, %hatenaid%, %A_ScriptDir%\conf.ini, user, hatenaid
    Return
;ダイアログのキャンセルボタン押された時の処理。
ButtonCancel:
    Gui, Destroy
    Return