;エンターキー入力されたら一定時間の間隔でリピート送信。
;マウスポインタを移動させるとリピートを止められる。

    ;マウスキャンセルのため、マウスポインタの座標を保存する。
    mx := 0
    my := 0
;エンターキーのホットキーを定義する。
;自分自身を再送信で無限ループが発生しないように$をつけておくこと。
$Enter::
    ;念のためタイマーをリセット。
    SetTimer, RepeatTimer, off
    ;キャンセルのためのマウスポインタの座標を取得。
    MouseGetPos, mx, my
    ;エンターキー送信。
    send, {Enter}
    ;リピート送信用のタイマーをセット(リピート開始までの時間は少し長めに)。
    SetTimer, RepeatTimer, 800
    return

;タイマーで起動されるリピート送信処理。
RepeatTimer:
    ;タイマーオフ。
    SetTimer, RepeatTimer, off
    ;マウスポインタの座標を取得。
    MouseGetPos, cx, cy
    ;エンターキー入力された瞬間の座標から一定量移動していたら 終了。
    if (Abs(cx - mx) > 7 or Abs(cy - my) > 7)
    {
        return
    }
    ;キーを送信して新たにタイマー設定。次回のリピートへ。
    send, {Enter}
    SetTimer, RepeatTimer,300
    return
