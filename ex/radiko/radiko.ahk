;起動中の Radiko ガジェットを操作してキーボードショートカットから放送局を選択する。

;Win キー+ F1で TBS ラジオを選択する。
#F1::
;画像検索の座標指定を Radiko ガジェットのウィンドウの左上を起点とした早退座標で指定する。
    CoordMode,Pixel,Relative
;放送局一覧から放送局選択メニューに移動する。
    openMenu()
;放送局を探して選択する。
    select("*40 tbs.png")
;停止中なら再生開始する。
    play()
    Return
;Win キー+ F2で文化放送選択する。
#F2::
    CoordMode,Pixel,Relative
    openMenu()
    select("*40 bunka.bmp")
    play()
    Return
;;Win キー+ F3でニッポン放送を選択する。
#F3::
    CoordMode,Pixel,Relative
    openMenu()
    select("*40 nippon.bmp")
    play()
    Return
;放送局一覧から放送局選択メニューに移動する。
openMenu(){
;Radiko ガジェットをアクティブにしてウィンドウの大きさ取得する。
    WinActivate, ahk_exe radiko_player_air.exe
    BlockInput, on
    Sleep, 100
    WinGetPos, , , Width, Height, A
;スピーカーの画像が見つからなければ放送局一覧画面を表示している。
    ImageSearch, x, y, 0, 0, Width, Height,*40 mute.png
    if ErrorLevel = 1
    {
;メニューボタンをクリックして放送局選択画面に移動する。
        ImageSearch, x, y, 0, 0, Width, Height,*40 menu.png
        if ErrorLevel = 0
        {
            MouseMove, x, y, 2
            MouseClick, Left
        }
        Else
        {
;ボタンが見つからないということは違うウィンドウを選択しているようなので処理を中止する。
            MsgBox, Radiko のウィンドウではないようです。
            ExitApp, 1
        }
    }
;マウスやキーボードの入力ブロックを解除する。
    BlockInput, Default
    Return
}
;放送局を選択する。
;パラメータで渡した放送局のロゴ画像を選択するまで右矢印をクリックし続ける。
select(Imagefile){
;ユーザからのマウス操作をブロックする。
    BlockInput, on
;Radiko Player のウィンドウサイズを取得して画像を探す範囲を限定する。
    WinGetPos, , , Width, Height, A    
;期待する放送局が見つかるまで繰り返す。
;ただし永久ループに陥らないように最大30回で脱出する。
;起動直後は放送局ロゴのダウンロードが間に合わずに表示できないことがあることも回避している。
    Loop, 30
    {
        Sleep, 500
;放送局のロゴが見つかったらループから脱出する。
        ImageSearch, x, y, 0, 0, Width, Height, % Imagefile
        if ErrorLevel = 0
        {
            Break
        }
;次の放送局を選択するボタンを探してマウスでクリックする。
;画像が見つかった時は、発見した左上の座標を相対座標で返す。
        ImageSearch, x, y, 0, 0, Width, Height,*40 next.png
        if ErrorLevel = 0
        {
;発見された座標をクリックする ウィンドウの左上を起点とした相対座標で指定している。
            MouseMove, x, y, 2
            MouseClick, Left
        }

    }
;ユーザからの操作を受け付けるようにする。
    BlockInput, Default
}
;再生ボタンのクリック。
;停止ボタンが押されている時には再生ボタンをクリックして音声をオンにする。
play(){
    WinActivate, ahk_exe radiko_player_air.exe
    BlockInput, on
    Sleep, 100
    WinGetPos, , , Width, Height, A
;再生ボタンがハイライトされてなかったら停止中。
    ImageSearch, x, y, 0, 0, Width, Height,*40 off.png
    if ErrorLevel = 0
    {
            MouseMove, x, y, 2
            MouseClick, Left
    }
    BlockInput, Default
    Return
}
