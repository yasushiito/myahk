;マウスポインターをウィンドウの左右両端に一定期間停止させるとスクロールが始まる。
;マウスポインターがウィンドウの上半分にある時は上方向にスクロール、下半分にある時は下方向にスクロールする。
;ウィンドウの上下両端に近づくほどスクロール速度が早くなる。
scrollhover(){

    scrollCnt := 0
    scrollSpdCnt := 0
    SetTimer, scrollWait, 250
    Return
}
;マウスポインターが一定期間滞留したか判定するための処理。
scrollWait:
    test := scrollTest()
    ;監視対象のウィンドウがある場合、そのアプリケーションが終了していたらスクロール処理も停止させる。
    if test < 0
    {
        SetTimer, scrollWait,Off
        SetTimer, scroll,Off
        ExitApp
    }
    if test > 0
    {
        scrollCnt += 1
        If scrollCnt > 2
        {
            SetTimer, scrollWait,Off
            scrollCnt := 0
            scrollSpdCnt := 0
            SetTimer, scroll, 150
        }
        return
    }
    scrollCnt := 0
    return
scroll:
    test := scrollTest()
    if test < 0
    {
        SetTimer, scrollWait,Off
        SetTimer, scroll,Off
        ExitApp
    }
    if test = 0
    {
        SetTimer, scroll,Off
        scrollCnt := 0
        SetTimer, scrollWait, 250
        return
    }
    if test <= 4
    {
        ; up
        spd := test -1
        direction := - 1
    }
    Else
    {
        ; scroll down
        spd := 8 - test
        direction := 1
    }
    if scrollSpdCnt >= %spd%
    {
        scrollSpdCnt := 0
        if direction < 0
            Send,{WheelUp}
        Else
            Send,{WheelDown}
    }
    Else
    {
        scrollSpdCnt += 1
    }
    return
scrollTest(){
    CoordMode,Mouse,Screen
    MouseGetPos, mx, my, ovid
    If ovid = 0
        return 0
    WinGetPos, wx, wy, ww, wh, ahk_id %ovid%
    lbarl := wx
    lbarr := wx + 20
    rbarl := wx + ww -20
    rbarr := wx + ww
    f := 0
    if mx Between %lbarl% and %lbarr%
        f += 1
    if mx Between %rbarl% and %rbarr%
        f += 1
    if f > 0
    {
        rx := mx - wx
        ry := my - wy
        rng := Floor(wh / 8)
        stp := Floor(ry / rng) + 1
        return stp
    }
    return 0
}
