;警告メッセージの準備。
warnMessage := Object()
setWarn()
;音声入力エディタの URL。
editorurl := ""
messengerfriendid := ""
;設定の読み込み。
getconfig()
    portmessenger(editorurl, messengerfriendid)
    Return
