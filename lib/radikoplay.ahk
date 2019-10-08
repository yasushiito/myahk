; edge でRadiko の放送局のライブページを開いて再生する。
; パラメータで再生したい放送局の名称をアルファベットで渡す。
;開いている Microsoft Edge を無断で閉じるので注意。
;放送局が指定されていない場合はページを閉じたまま再生を行わないので停止となる。
;再生ボタンはキーボードショートカットに対応していないので画像認識でクリックする。
;10秒以内に番組のページが開けなかった場合は再生に失敗する。

radikoplay(channel){
    ;Microsoft Edge を閉じる強制的に。
    closeedge()
    ;放送局が指定されていない場合は再生しない。
    if channel =
    {
        return
    }
    ;タイムフリーで過去の番組を聞きたい場合は#!/ts/channel/日時を URL に含める。
    ;FormatTime, t, , yyyyMMddHHmmss
    url := "http://radiko.jp/#!/live/" . channel ;. "/" . t
    ;Edge は実行ファイルではないので START コマンドから起動しなければならないのでバッチファイルから起動してもらう。
    Run, microsoft-edge:%url%
    ;ページが開くまで待つ。
    Sleep 10000

    ;ここからは再生ボタンを探してクリックする処理。

    ;作業ディレクトリからの相対パスで探すので作業ディレクトリをバックアップして書き換える。
    wd := A_WorkingDir
    SetWorkingDir, %A_ScriptDir%
    fbminput := "images\radikoplay.bmp"
    ;再生ボタンの画像が所定のディレクトリに用意されている場合に限る。
    if FileExist(fbminput)
    {
        CoordMode,Pixel,Relative
        WinGetPos, , , Width, Height, A
        ;再生ボタンを探す。
        ImageSearch, x, y, 0, 0, Width, Height,*30 %fbminput%
        if ErrorLevel = 0
        {
            MouseMove, x, y, 2
            MouseClick, Left
            ;プレイヤーが起動してフォーカスを奪われる。
            ;ページの URL が取得できなくなるので入力フォーカスをページに戻す。
            Send,{Tab}
        }
    }
    SetWorkingDir, wd

    return
}
