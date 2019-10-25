; edge でRadiko の放送局のライブページを開いて再生する。
; パラメータ
;arg1:再生したい放送局の名称をアルファベットで渡す。
;arg2:タイムフリーで過去の番組を聴くなら時分秒の形式で放送時間を渡す。
;arg3:タイムフリーの場合は放送曜日を数値で渡す(日曜日が1。
;開いている Microsoft Edge を無断で閉じるので注意。
;放送局が指定されていない場合はページを閉じたまま再生を行わないので停止となる。
;再生ボタンはキーボードショートカットに対応していないので画像認識でクリックする。
;10秒以内に番組のページが開けなかった場合は再生に失敗する。

radikoplay(channel, onairtime="", wday=""){
    MsgBox, , ,まもなくラジオの再生が始まります。 ,5
    ;Microsoft Edge を閉じる強制的に。
    closeedge()
    ;放送局が指定されていない場合は再生しない。
    if channel =
    {
        return
    }
    url := "http://radiko.jp/#!/"
    if onairtime =
    {
        ;ライブページの URL と再生ボタンのサンプル画像ファイル名を用意する。
        url := url . "live/" . channel
        btnplay := "images\radikoplay.bmp"
    }
    Else
    {
        ;タイムフリーで過去の番組を聞きたい場合
        ;放送曜日と放送時間から前回放送日時を算出する。
        onairdate := getLastDateByWday(A_Now, wday)
        FormatTime, onairdate, %onairdate%, yyyyMMdd
        ;タイムシフトページの URL と再生ボタンのサンプルとタイムフリーに関する注意メッセージの OK ボタンのサンプル画像ファイル名を用意する。
        url := url . "ts/" . channel . "/" . onairdate . onairtime
        btnplay := "images\radikotsplay.bmp"
        btnok := "images\radikotsok.bmp"
    }
    Sleep 1000
    ;Edge は実行ファイルではないので START コマンドから起動しなければならないのでバッチファイルから起動してもらう。
    Run, microsoft-edge:%url%
    ;ページが開くまで待つ。
    Sleep 10000

    ;ここからは再生ボタンを探してクリックする処理。

    ;作業ディレクトリからの相対パスで探すので作業ディレクトリをバックアップして書き換える。
    wd := A_WorkingDir
    SetWorkingDir, %A_ScriptDir%
    ;再生ボタンの画像が所定のディレクトリに用意されている場合に限る。
    if FileExist(btnplay)
    {
        CoordMode,Pixel,Relative
        WinGetPos, , , Width, Height, A
        ;再生ボタンを探す。
        ImageSearch, x, y, 0, 0, Width, Height,*30 %btnplay%
        if ErrorLevel = 0
        {
            ;ボタンが見つかったので移動してクリック。
            MouseMove, x, y, 2
            MouseClick, Left
            ;タイムツリーの時はメッセージが表示されるので OK ボタンをクリックしなければならない。
            if btnok
            {
                ;OK ボタンのサンプル画像ファイルの存在を確認しておく。
                if FileExist(btnok)
                {
                    Sleep 1000
                    ;okボタンを探す。
                    ImageSearch, x, y, 0, 0, Width, Height,*30 %btnok%
                    if ErrorLevel = 0
                    {
                        MouseMove, x, y, 2
                        MouseClick, Left
                    }

                }
            }
            ;プレイヤーが起動してフォーカスを奪われる。
            ;ページの URL が取得できなくなるので入力フォーカスをページに戻す。
            Send,{Tab}
        }
    }
    SetWorkingDir, wd

    return
}
