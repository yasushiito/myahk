;画像認識用エンコードテキスト。
global TextImages := Object()
SetTextImages()


;Radiko の再生。
    radikoplay(a_args[1], a_args[2], a_args[3])
ExitApp, 1