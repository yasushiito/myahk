;Bluetooth デバイスの一覧を開いて目的のデバイスが接続状態になるのを監視する。
;第1パラメータでデバイスが接続状態になった場合のサンプル 画像を与える。
;接続が確認できた時は trueを戻す。
;接続が確認できない場合は60秒間待機した後にリトライする。
;リトライは30回行われて最後まで接続されなかったら false を返す。

WaitBTConnect(img){
    ;デバイスの接続を確認できるまで30回リトライして待機する。
    ;中断したい時はタスクバーのアイコンダブルクリックでウィンドウを開いてスクリプトを停止する。
    Loop, 30
    {
        ;キーボードショートカットで Bluetooth デバイス一覧表示する。
        Send,#k
        ;全てのデバイスの接続状態の確認できるまで待つ。
        Sleep, 5000

        ;作業ディレクトリからの相対パスで探すので作業ディレクトリをバックアップして書き換える。
        wd := A_WorkingDir
        SetWorkingDir, %A_ScriptDir%
        ;デバイスが接続されている状態の画像が所定のディレクトリに用意されている場合に限る。
        if FileExist(img)
        {
            CoordMode,Pixel,Screen
            ;デバイス一覧を表示しているあたりから目的のデバイスの接続状態の画像を探す。
            ;タスクバーを画面の左に寄せているからスクリーンの左端を調べて。
            ImageSearch, x, y, 0, 0, 200, A_ScreenHeight,*30 %img%
            if ErrorLevel = 0
            {
                ;見つかったのでデバイス一覧を閉じて元の処理に帰る。
                ;MouseMove, x, y, 2
                Sleep 1000
                Send, {Esc}
                return True
            }   
        }
        SetWorkingDir, wd
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
    return False
}
