;ボタンなどの画像をアクティブウィンドウから探してマウスポインターを移動させて左クリックを送信する。
;画像認識ライブラリ FindText を利用して、目的の画像をスクリーンないから探してクリックする。
;マウスポインタの移動と左クリックの送信で行う。
;ポインタの移動のみでクリックしないようにもできる。

;パラメータ。
;imagetext:クリックしたい部分の画像を Find Text アプリでテキスト化したもの。
;noclick: TRUE を設定するとマウスポインターを移動させるだけでクリックしない。
;リターン。
;画像が見つかってクリックしたときに TRUE。見つからなかったらfalseを返す。

;  https://autohotkey.com/boards/viewtopic.php?f=6&t=17834

ClickImage(imagetext, noclick=False){
    r := False
    if (ok:=FindText(0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, imagetext))
    {
        ;見つかったので結果から座標を取り出す。
        X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
        ;マウスポインターを移動させてクリック。
        CoordMode, mouse, Screen
        MouseMove, x, y, 10
        if !noclick
            MouseClick, Left
        r := True
    }

    return r
}
