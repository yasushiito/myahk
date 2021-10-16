; edge でRadiko の放送局のライブページを開いて再生する。
;Radiko の友達に教える機能で Twitter と連携して番組情報をtweetする。
; パラメータ
;arg1:再生したい放送局の名称をアルファベットで渡す。
;arg2:タイムフリーで過去の番組を聴くなら時分秒の形式で放送時間を渡す。
;arg3:タイムフリーの場合は放送曜日を数値で渡す(日曜日が1。
;開いている Microsoft Edge を無断で閉じるので注意。
;放送局が指定されていない場合はページを閉じたまま再生を行わないので停止となる。
;再生ボタンはキーボードショートカットに対応していないので画像認識でクリックする。
;10秒以内に番組のページが開けなかった場合は再生に失敗する。

radikoplay(channel, onairtime="", wday=""){
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
    }
    Else
    {
        ;タイムフリーで過去の番組を聞きたい場合
        ;放送曜日と放送時間から前回放送日時を算出する。
        onairdate := getLastDateByWday(A_Now, wday)
        FormatTime, onairdate, %onairdate%, yyyyMMdd
        ;タイムシフトページの URL と再生ボタンのサンプルとタイムフリーに関する注意メッセージの OK ボタンのサンプル画像ファイル名を用意する。
        url := url . "ts/" . channel . "/" . onairdate . onairtime
    }
    
    ;再生ボタンなどのクリックしたい部分の画像サンプルをテキスト化したデータを取得する。
    ;操作手順は、再生する、友達に教える、 Twitter アイコン、 Tweet Button、シェア画面を閉じるX。
    ;ただしタイムフリーの場合は再生ボタンの後に OK ボタンをクリックする。
    global TextImages
    btnplay := TextImages["RadikoPlay"]
    btnok := TextImages["RadikoOk"]
    btnstop := TextImages["RadikoStop"]
    btnshare := TextImages["RadikoShare"]
    btntwittericon := TextImages["RadikoTwitterIcon"]
    btntweet := TextImages["RadikoTweet"]
    btnclosex := TextImages["RadikoCloseX"]
    Sleep 1000
    ;クリックミスを考慮して3階までリトライする。
    Loop, 3
    {
        ;Edge は実行ファイルではないので START コマンドから起動しなければならないのでバッチファイルから起動してもらう。
        Run, microsoft-edge:%url%
        ;ページが開くまで待つ。
        Sleep 6000
        ;ウィンドウ左端にはスクリーンキーボードなどのオーバーレイアプリが開いてボタンを隠してしまうのでスクリーン右側に移動させる。
        WinMove, A,,600, 0, 1200, A_ScreenHeight
        ;ここからは再生ボタンを探してクリックする処理。
        ;ボタンを探してクリック。
        r := ClickImage(btnplay, 2000)
        ;ボタンクリックに成功していたらループを中断。
        if r
        {
            ;タイムフリー再生の時注意喚起ウインドーの OK ボタンをクリック。
            if onairdate
            {
                ;r := ClickImage(btnok, 2000)
            }
        }
        ;再生するボタンを探して再生されたことを確認する。
        ;マウスポインタの位置によってはスクロールしてしまってクリックミスすることがあった。
        Sleep, 6000
        if (ok:=FindText(0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, btnstop))
        {
            Break
        }
        ;クイックに失敗していたらページの読み込みに失敗しているかもしれないのでMicrosoft Edge を閉じる
        if A_Index < 3
        {
            closeedge()
        }
        Sleep 3000
    }

    ;ここからは友達に教える機能の Twitter 連携。
    ;操作手順は、友達に教える、 Twitter アイコン、 Tweet Button、シェア画面を閉じるX。
    ;ClickImage(btnshare, 3000)
    ;ClickImage(btntwittericon, 1500)
    ;ClickImage(btntweet, 3000)
    ;ClickImage(btnclosex, 1500)

    ;再生を始めるとプレイヤーが起動してフォーカスを奪われる。
    ;ページの URL が取得    できなくなるので入力フォーカスをページに戻す。
    if r
        Send,{Tab}

    return
}
