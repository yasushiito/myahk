    if WaitBTStandby()
    {
        ;接続操作を行ったようなのでedge起動してスピーカーの切り替えを確認してみる。
        ;Edge は実行ファイルではないので スキームで起動する。
        Run, microsoft-edge:http://radiko.jp/#!/top
        Sleep 1000
        ;確認できたら手動で閉じるボタンを押してね。
        WinGetPos, , , w, , A
        CoordMode, Mouse, Relative
        MouseMove, w, 0
    }
    Return
