#Persistent
    Menu, tray, click, 1
;    CoordMode,Pixel,Screen
;    CoordMode,Mouse,Screen

    repeatMx := 0
    repeatMy := 0
$Left::
    repeatKeyIndex := 1
    Gosub, sftkbdrpt
    return

$Right::
    repeatKeyIndex := 2
    Gosub, sftkbdrpt
    return

$Up::
    repeatKeyIndex := 3
    Gosub, sftkbdrpt
    return

$Down::
    repeatKeyIndex := 4
    Gosub, sftkbdrpt
    return

$BackSpace::
    repeatKeyIndex := 5
    Gosub, sftkbdrpt
    return

$Del::
    repeatKeyIndex := 6
    Gosub, sftkbdrpt
    return

$Space::
    repeatKeyIndex := 7
    Gosub, sftkbdrpt
    return

$PgUp::
    repeatKeyIndex := 8
    Gosub, sftkbdrpt
    return

$PgDn::
    repeatKeyIndex := 9
    Gosub, sftkbdrpt
    return

$+Left::
    repeatKeyIndex := 101
    Gosub, sftkbdrpt
    return

$+Right::
    repeatKeyIndex := 102
    Gosub, sftkbdrpt
    return

$+Up::
    repeatKeyIndex := 103
    Gosub, sftkbdrpt
    return

$+Down::
    repeatKeyIndex := 104
    Gosub, sftkbdrpt
    return

RepeatTimer:
    SetTimer, RepeatTimer, off
    MouseGetPos, cx, cy
    if (Abs(cx - repeatMx) > 5 or Abs(cy - repeatMy) > 5)
    {
        GetKeyState, s, Shift
        if s = D 
        {
            send, {Shift}
        }
        return
    }
    downKey(repeatKeyIndex)
    SetTimer, RepeatTimer,300
    return

sftkbdrpt:
    SetTimer, RepeatTimer, off
    MouseGetPos, repeatMx, repeatMy
    downKey(repeatKeyIndex)
    SetTimer, RepeatTimer, 800
    return

downKey(kidx){
    switch kidx {
    case 1:
        send, {Left}
    case 2:
        send, {Right}
    case 3:
        send, {Up}
    case 4:
        send, {Down}
    case 5:
        send, {BackSpace}
    case 6:
        send, {Del}
    case 7:
        send, {Space}
    case 8:
        send, {PgUp}
    case 9:
        send, {PgDn}
    case 101:
        send, +{Left}
    case 102:
        send, +{Right}
    case 103:
        send, +{Up}
    case 104:
        send, +{Down}
    
    }
    return
}