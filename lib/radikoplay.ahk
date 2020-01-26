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
        btnplay := "images\radikoplay.bmp"
        ;友達に教えるボタンのサンプル画像ファイル名。
        btnshare := "images\radikosharelv.bmp"
        ;SHARE ウィンドウを閉じるバツボタンのサンプル画像(青)。
        btnclose := "images\radikocloselv.bmp"
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
        ;友達に教えるボタンのサンプル画像ファイル名。
        btnshare := "images\radikosharets.bmp"
        ;;SHARE ウィンドウを閉じるバツボタンのサンプル画像(赤)。
        btnclose := "images\radikoclosets.bmp"
    }
    ;Twitter でシェアボタン。
    btnsharetwitter := "images\radikosharetwico.bmp"
    ;Twitter ポップアップの送信ボタンのサンプル画像。
    btnsharetweet := "images\radikosharetwok.bmp"
    Sleep 1000
    ;クリックミスを考慮して3階までリトライする。
    Loop, 3
    {
        ;Edge は実行ファイルではないので START コマンドから起動しなければならないのでバッチファイルから起動してもらう。
        Run, microsoft-edge:%url%
        ;ページが開くまで待つ。
        Sleep 5000
        ;ウィンドウ左端にはスクリーンキーボードなどのオーバーレイアプリが開いてボタンを隠してしまうのでスクリーン右側に移動させる。
        WinMove, A,,600, 0, 1200, A_ScreenHeight
        Sleep 5000
        ;ここからは再生ボタンを探してクリックする処理。
        ;ボタンを探してクリック。
        r := ClickButton(btnplay)
        ;連打防止のためクリック成功失敗に関わらず3秒間停止。
        Sleep 3000
        ;ボタンクリックに成功していたらループを中断。
        if r
            Break
        ;クイックに失敗していたらページの読み込みに失敗しているかもしれないのでMicrosoft Edge を閉じる
        closeedge()
        Sleep 5000
    }
    ;タイムフリーの時に表示される注意喚起ウィンドウを OK ボタンクリックで閉じる。
    if btnok
    {
        ;クリックミスを考慮して3階までリトライする。
        Loop, 3
        {
            ;OK ボタンを探してクリック。
            ;フォントサイズがウィンドウのサイズと比例しているのでブラウザの大きさを変えると動かなくなる。
            r := ClickButton(btnok)
            ;連打防止のためクリック成功失敗に関わらず5秒間停止。
            Sleep 5000
            ;ボタンクリックに成功していたらループを中断。
            if r
                Break
        }
    }

    ;ここからは友達に教える機能の Twitter 連携。

    ;友達に教えるボタンを探してクリックする
    ; ページに表示される情報の密度次第で画面に表示されていないこともある。
    Loop, 3
    {
        ;友達に教えるボタンを探してクリック。
        r := ClickButton(btnshare)
        ;連打防止のためクリック成功失敗に関わらず5秒間停止。
        Sleep 5000
        ;ボタンクリックに成功していたらループを中断。
        if r
            Break
    }
    ;連携する SNS のアイコン一覧が表示されるので Twitter アイコンを探してクリックする。
    ;Twitter のポップアップが番組情報入りで開くので送信ボタンを探してクリックする。
    ;ブラウザが Twitter にログインしていないとこける。
    ;その場合ポップアップは閉じられずに残る。
    Loop, 3
    {
        ;Twitter アイコンを探してクリック。
        r := ClickButton(btnsharetwitter)
        ;連打防止のためクリック成功失敗に関わらず5秒間停止。
        Sleep 5000
        ;Twitter アイコンクリックに成功していたらポップアップのtweetをクリック。
        if r
        {
            ;tweet ボタンを探してクリック。
            r := ClickButton(btnsharetweet)
            ;連打防止のためクリック成功失敗に関わらず5秒間停止。
            Sleep 5000
            if r
                Break
        }
    }
    ;SNS 一覧が開きぱなしなのでクローズボタンを探してクリックする。
    ;ポップアップが上に乗っかると見つからないこともある。
    Loop, 3
    {
        ;X ボタンを探してクリック。
        r := ClickButton(btnclose)
        ;連打防止のためクリック成功失敗に関わらず5秒間停止。
        Sleep 5000
        ;ボタンクリックに成功していたらループを中断。
        if r
            Break
    }
    ;再生を始めるとプレイヤーが起動してフォーカスを奪われる。
    ;ページの URL が取得できなくなるので入力フォーカスをページに戻す。
    if r
        Send,{Tab}

    return
}
