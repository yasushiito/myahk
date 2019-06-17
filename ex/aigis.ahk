;ゲーム千年戦争アイギスをプレイする際にドラッグアンドドロップの作業を助けてくれる。
;ゲーム画面上で一定時間マウスポインターを停滞させるとマウスクリックします。
;ユニット一覧の上で停滞させた時はユニットを使えるドラッグアンドドロップ操作に入ります。
;ドラッグアンドドロップ操作中にはマウスポインターをユニット一覧の上から外した後にマウスポインターを停滞させた場所でドロップします。
;
;Win+ M で アシストモードを開始。
;Win+U 執務室でのアシスト(ユニット出撃ドラッグのアシストは無し。
;Win+P でアシストモードを終了。
;画面上のマウスポインターの絶対位置で動作します。
;ウィンドウの位置とサイズが変わると期待通りに動作しません。
;Google Chrome 上で ズームを50%でゲーム画面を表示しています。
;クロームのポジションはウィンドウの位置とサイズをアジャストするスクリプトによって調整しています。
#Persistent
    global editor := 0
    global cx := 0  ;マウスが停滞していることを判定するために前回のマウス位置を記憶しておく。
    global cy := 0  ;マイナスの時は判定エリア外に出ていたとのこと。
    global stay := 0
    global dnd := False
    global u := False
    Menu, tray, click, 1
    detectchrome()
    ;マウス座標の指定と画像を探す処理の座標はスクリーン上の絶対座標で指定する。
    CoordMode,Pixel,Screen
    CoordMode,Mouse,Screen
    Return
;Win+ M で アシストモードを開始。
#m::
    SetTimer, aigis, off
    stay := 0
    cx := -1
    dnd := False
    ua := True
    SetTimer, aigis, 40
    Return
;Win+u執務室でのアシストを開始。
;クリックはゆっくりめで監視する。
;ユニット出撃のためのドラッグ監視はしない。
#u::
    SetTimer, aigis, off
    stay := 0
    cx := -1
    dnd := False
    ua := False
    SetTimer, aigis, 100
    Return
;Win+P でアシストモードを終了。
#p::
    SetTimer, aigis, off
    Return
;アシスト監視。
aigis:
;アイギスが最前面でなければ監視しない。
    IfWinNotActive, 千年戦争アイギス
        return
    MouseGetPos, mx, my
;ゲーム画面の範囲内にマウスポインタが入っているか。
    test := hitTest(880,160,1500,560,mx,my)
    if test
    {
;マウスポインターが初めてゲーム内に入ってきた場合の初期化。
        if cx < 0
        {
            stay := 0
            cx := mx
            cy := my
        }
;マウスポインタが停滞しているか。
;小刻みに震えていても停滞していることにするために少し余裕を持たせてある。
        d:=2
        if hitTest(cx-d,cy-d,cx+d,cy+d,mx,my) 
        {
;停滞しているのでカウンターを増やし。
            stay += 1
        }
        Else
        {
;ポインタを動かしているので停滞カウンタをリセットして今の位置を記憶しておく。
            cx := mx
            cy := my
            stay := 0
        }
    }
    Else
    {
;マウスポインターゲームの外に出ているので状態を初期化。
        stay := 0
        cx := -1
        dnd := False
    }
;一定期間マウスポインターを停滞させたか。
    if stay > 5
    {
;ユニット一覧のエリア判定はスキルボタンがある右端とユニットスクロールが発生する左端のエリアは判定に含まれない。
        if !ua
        {
;連打しないように判定はイコールを使って一度だけ。
            if stay=6
            {
                MouseClick, Left
            }
            return
        }
        if hitTest(920,495,1445,555,mx,my)
        {
;停滞させているのはユニット一覧の中。
;ドラッグアンドドロップ状態にして左ボタンをしっぱなしにする。
            dnd := True
            Send, {LButton down}
        }
        Else
        {
;フィールド上で停滞している。
            if dnd
            {
;ドラッグアンドドロップ中なら。
;ドラッグアンドドロップ状態を解除して左ボタンを上げる。
                dnd := False
                Send, {LButton Up}
;明示的にクリックしてやらないと掴んだユニットを離さないことがあるらしい。
                MouseClick, Left
            }
;通常のフィールドなのでスキル使用のためのクリック。
;ステータス表示のためのクリック。
;割り込み6回に1度に対してクリックするべきか判定する。
            if Mod(stay, 6) =0
            {
;移動中から停止した時は必ずクリックしないとフィールドをクリックしてステータス表示をキャンセルできない。
                if stay = 6
                {
                    MouseClick, Left
                }
                Else
                {
;ステータスとスキルボタンを消さないようにステータス表示中はクリックしない。
                    ImageSearch, fx, fy, 900,480,945,520,*40 blue.bmp
                    if ErrorLevel = 1
                    {
                        MouseClick, Left
                    }
                }
            }
        }
    }
    return
;長方形の領域の中に含まれているかの判定。
hitTest(sx,sy,ex,ey,mx,my){
    f := 0
    if mx Between %sx% and %ex%
        f += 1
    if my Between %sy% and %ey%
        f += 1
    if f > 1
    {
        return True
    }
    return False
}
