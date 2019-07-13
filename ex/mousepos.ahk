;マウスで左クリックした座標をクリップボードに追加するスクリプト。
;キーボードを使わずにマウスポインタの座標を取得するのはちょっと面倒。
;そこで常駐してマウスクリックを監視して、クリックした瞬間のマウスポインターの位置をスクリーンの絶対座標とアクティブウィンドウの相対座標でクリップボードのテキストに追加する。
;Win+ iで座標取得開始/終了を切り替できる。
;絶対座標と括弧内に相対座標を出力する。
;win + zでアプリケーション終了。
;なおスクリプトの性質上アクティブウィンドウの範囲を超える座標取得できない。
#Persistent
    global d := 0
    Menu, tray, click, 1
    Return
;Win+ i で座標取得開始/終了を切り替
#i::
    global d
    if d = 0
    {
        MsgBox, , , 左クリックでクリップボードにマウス座標を追加します wi n+iで中止します。, 5
        Clipboard :=
        SetTimer, mpos, 100
        d := 1
    }
    Else
    {
        MsgBox, , , マウス座標の取得を中止しました。, 5
        SetTimer, mpos, off
        d := 0
    }
    Return
;win + zでアプリケーション終了。
#z::
    SetTimer, mpos, off
    ExitApp, 0
;マウス左ボタンの押下状態をタイマー監視。
mpos:
    GetKeyState, stat, LButton, "p"
    if stat = D
    {
        ;マウス座標はスクリーン上の絶対座標で指定する。
        CoordMode,Mouse,Screen
        MouseGetPos, mx, my
        ;相対座標を括弧内で指定する。
        CoordMode,Mouse,Relative
        MouseGetPos, rx, ry
        t := mx . "," . my . "(" . rx . "," . ry . ")`n"
        Clipboard .= t
        MsgBox, , , %t%, 3
    }
    Return
