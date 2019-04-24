getconfig(){
;前回の設定を読み込む。
    ;音声入力エディタの URL。
    IniRead, editorurl, %A_ScriptDir%\conf.ini, user, editorurl
    ;はてなブログの ID。
    IniRead, hatenaid, %A_ScriptDir%\conf.ini, user, hatenaid, yourid
}
