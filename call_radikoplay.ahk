;画像認識用エンコードテキスト。
global TextImages := Object()
SetTextImages()
;作業用ウインドウの URL。
workurl := ""

;設定の読み込み。
getconfig()

;アクティブウィンドウが スピーカー切り替えショートカットキー反応しないように無難なウインドウに切り替えておく。
detectwork(workurl)
Sleep, 300
;スピーカー出力先を切り替えるアプリAudio switcherのキーボードショートカットからヘッドホンに切り替える。
Send, +^{F7}
Sleep, 300
;Radiko の再生。
    radikoplay(a_args[1], a_args[2], a_args[3])
ExitApp, 1