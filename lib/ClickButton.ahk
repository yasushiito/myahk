;ボタンなどの画像をアクティブウィンドウから探してクリックする。
;パラメータ。
;img: 画像ファイル(実行スクリプトファイルからの早退ディレクトリ)。
;リターン。
;画像が見つかってクリックしたときに TRUE。見つからなかったらfalseを返す。

ClickButton(img){
    r := False
    ;作業ディレクトリからの相対パスで探すので作業ディレクトリをバックアップして書き換える。
    wd := A_WorkingDir
    SetWorkingDir, %A_ScriptDir%
    ;ボタンの画像が所定のディレクトリに用意されている場合に限る。
    if FileExist(img)
    {
        CoordMode,Pixel,Relative
        WinGetPos, , , Width, Height, A
        ;ボタンを探す。
        ImageSearch, x, y, 0, 0, Width, Height,*30 %img%
        if ErrorLevel = 0
        {
            ;ボタンが見つかったので移動してクリック。
            MouseMove, x, y, 2
            Sleep 1000
            MouseClick, Left
            r := True
        }
    }
    SetWorkingDir, wd

    return r
}
