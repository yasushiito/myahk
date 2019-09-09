;警告メッセージの準備。
warnMessage := Object()
setWarn()
;設定の読み込み。
global hatenaid
editorurl := ""
workurl := ""
getconfig()
    blogentry(hatenaid, editorurl, workurl)
    Return
