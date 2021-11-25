; edge でGoogle Podcast のチャンネルを開いて再生する。
; パラメータ
;arg1:再生したいチャンネルの文字列。
;ボタンが見つからない、クリックに失敗した時などに備えてリトライする。
;3回トライして失敗したなら Microsoft Edge を開いたまま終了する。

googlepodcast(channel){
    ;Microsoft Edge を閉じる強制的に。
    closeedge()
    ;放送局が指定されていない場合は再生しない。
    if channel =
    {
        return
    }
    url := "https://podcasts.google.com/"
    url := url . "feed/" . channel
    
    ;再生ボタンなどのクリックしたい部分の画像サンプルをテキスト化したデータを取得する。
    global TextImages
    btnplay := TextImages["GooglepodcastPlay"]
    btnstop := TextImages["GooglepodcastStop"]
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
    return
}
