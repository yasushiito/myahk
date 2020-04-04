    if WaitBTStandby()
    {
        ;接続操作を行ったようなのでedge起動してスピーカーの切り替えを確認してみる。
        Sleep 1000
        ;Edge は実行ファイルではないので スキームで起動する。
        Run, microsoft-edge:http://radiko.jp/#!/top
        ;確認できたら手動で閉じるボタンを押してね。
    }
    Return
