#Persistent
    twitterRollCnt := 0
    twitterRollSpdCnt := 0
    SetTimer, twitterRollWait, 250
    Return
twitterRollWait:
    test := twitterRollTest()
    if test < 0
    {
        SetTimer, twitterRollWait,Off
        SetTimer, twitterRoll,Off
        ExitApp
    }
    if test > 0
    {
        twitterRollCnt += 1
        If twitterRollCnt > 2
        {
            SetTimer, twitterRollWait,Off
            twitterRollCnt := 0
            twitterRollSpdCnt := 0
            SetTimer, twitterRoll, 150
        }
        return
    }
    twitterRollCnt := 0
    return
twitterRoll:
    test := twitterRollTest()
    if test < 0
    {
        SetTimer, twitterRollWait,Off
        SetTimer, twitterRoll,Off
        ExitApp
    }
    if test = 0
    {
        SetTimer, twitterRoll,Off
        twitterRollCnt := 0
        SetTimer, twitterRollWait, 250
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
    if twitterRollSpdCnt >= %spd%
    {
        twitterRollSpdCnt := 0
        if direction < 0
            Send,{WheelUp}
        Else
            Send,{WheelDown}
    }
    Else
    {
        twitterRollSpdCnt += 1
    }
    return
twitterRollTest(){
    prc := WinExist("ahk_exe firefox.exe")
    If prc = 0
    {
        return -1
    }
    fox := WinExist("ホーム / Twitter - Mozilla Firefox")
    If fox = 0
        return 0
    CoordMode,Mouse,Screen
    MouseGetPos, mx, my, ovid
    If fox = %ovid%
    {
        WinGetPos, wx, wy, ww, wh, ahk_id %fox%
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
    }
    return 0
}













