;前回の設定を読み込む。
getconfig(){
    global editorurl
    global workurl
    global hatenaid
    global messengerfriendid
    global radikoch
    ;音声入力エディタの URL。
    IniRead, editorurl, %A_ScriptDir%\conf.ini, user, editorurl
    ;作業用ウインドウの URL。
    IniRead, workurl, %A_ScriptDir%\conf.ini, user, workurl
    ;はてなブログの ID。
    IniRead, hatenaid, %A_ScriptDir%\conf.ini, user, hatenaid, yourid
    ;Facebook でメッセンジャーする相手の ID。
    IniRead, messengerfriendid, %A_ScriptDir%\conf.ini, user, messengerfriendid,fid
    ;functionキーから開く Radiko 放送局のチャンネル名をカンマ区切りで。
    IniRead, radikoch, %A_ScriptDir%\conf.ini, user, radikoch, TBS
}
