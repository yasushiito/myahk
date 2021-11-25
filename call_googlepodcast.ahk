;Google Podcast で指定した番組を再生する。
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
;Podcast 番組を再生。
googlepodcast(a_args[1])
ExitApp, 1