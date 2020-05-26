;警告メッセージの準備。
warnMessage := Object()
setWarn()
;音声入力エディタの URL。
editorurl := ""
messengerfriendid := ""
;画像認識用エンコードテキスト。
TextImages := Object()
SetTextImages()

;設定の読み込み。
getconfig()
    portmessenger(editorurl, messengerfriendid)
    ExitApp, 0
