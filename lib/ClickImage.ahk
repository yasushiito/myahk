;ボタンなどの画像をアクティブウィンドウから探してマウスポインターを移動させて左クリックを送信する。
;画像認識ライブラリ FindText を利用して、目的の画像をスクリーンないから探してクリックする。
;マウスポインタの移動と左クリックの送信で行う。
;オプションでポインタの移動のみでクリックしないようにもできる。
;マウスの左ボタンを押し続けることでもクリックをキャンセルできる。

;パラメータ。
;imagetext:クリックしたい部分の画像を Find Text アプリでテキスト化したもの。
;delay:画像探索を始めるまでの待ち時間。マウスポインターが目的地に到着後、
;   一瞬でクリックしてしまうとクリックミスを起こしかねないので、 待ち時間のうち1割をマウス移動後に分割する。
;      
;noclick: TRUE を設定するとマウスポインターを移動させるだけでクリックしない。
;リターン。
;画像が見つかってクリックしたときに TRUE。見つからなかったらfalseを返す。

;  https://autohotkey.com/boards/viewtopic.php?f=6&t=17834

ClickImage(imagetext,delay=0, noclick=False){
    r := False
    ;UI 上のエフェクトを避けるためにマウスポインターをすみっこに寄せておく。
    CoordMode, mouse, Screen
    MouseMove, A_ScreenWidth, A_ScreenHeight, 0
    ;待ち時間の指定の90%の間待機する。
    if delay
        Sleep, delay - delay / 10
    ;スクリーン上から画像を探す。
    if (ok:=FindText(0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, imagetext))
    {
        ;見つかったので結果から座標を取り出す。
        X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
        ;マウスポインターを移動させてクリック。
        MouseMove, x, y, 0
        if delay
            Sleep, delay / 10
        ;オプション指定されているときはクリックしない。
        if !noclick
            ;マウスの左ボタンをプッシュしているときもクリックしない。
            GetKeyState, lb, LButton
            if lb = U
                MouseClick, Left
        r := True
    }
    Else
    {
        ;画像が見つからなかった場合、不足の待ち時間1割をスリープ。
        if delay
            Sleep, delay / 10
    }

    return r
}
