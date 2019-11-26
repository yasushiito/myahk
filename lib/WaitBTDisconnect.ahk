;Bluetooth デバイスの一覧を開いて目的のデバイスが接続状態になるのを監視する。
;第1パラメータでデバイスが接続状態になった場合のサンプル 画像を与える。
;接続が確認できた時は trueを戻す。
;接続が確認できない場合は60秒間待機した後にリトライする。
;リトライは30回行われて最後まで接続されなかったら false を返す。

WaitBTStandby(){
    MsgBox, , ,まもなくラジオの再生が始まります。 ,5
    ;デバイスの接続を確認できるまで30回リトライして待機する。
    ;中断したい時はタスクバーのアイコンダブルクリックでウィンドウを開いてスクリプトを停止する。
    Loop, 30
    {
        ;キーボードショートカットで Bluetooth デバイス一覧表示する。
        Send,#k
        ;全てのデバイスの接続状態の確認できるまで待つ。
        Sleep, 5000
        rd := ClickButton("images\bth163dd.bmp",true)
        if rd
            return True
        Send, {Space}
        Sleep 1000
        Send, h-163

        Sleep 1000
        Send, {Tab}
        Sleep 1000
        Send, {Enter}
        Sleep 1000
        Send, {Tab}
        Sleep 1000
        Send, {Space}
        Sleep, 5000
        ;見つからなかったらデバイス一覧を閉じて一分間待機した後にリトライする。
        Send, {Esc}
        Loop, 12
        {
            ;左クリックをしていればデバイスが準備できてなくても無視して続行する。
            GetKeyState, l, LButton
            if l = D
                return True
            Sleep, 5000
        }
    }
    ;最後まで見つからなかったので失敗を返す。
    ;音声を受信するためのデバイスの接続を確認するなら有効にする。
    MsgBox, , ,スピーカーが見つかりませんでした。 ,5
    return False
}
