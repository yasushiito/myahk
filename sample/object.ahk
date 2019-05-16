warnMessage := Object()
warnMessage.a := "キーのピリオドで指定して参照する。"
warnMessage.b := "キーをピリオドで指定して文字列で参照する。"
warnMessage.c := "キーを変数から参照する。"
warnMessage["d"] := "キーを文字列で指定してピリオドで参照する。"
warnMessage[200] := "キーを数値で指定する。"
MsgBox, , , % warnMessage.a ,5
; MsgBox, , , %warnMessage.a% ,5
MsgBox, , , % warnMessage["b"]  ,5
; MsgBox, , , %warnMessage["a"]% ,5
key := "c"
MsgBox, , , % warnMessage.key ,5    ; 参照できていない。
MsgBox, , , % warnMessage[key]  ,5
MsgBox, , , % warnMessage.d ,5
MsgBox, , , % warnMessage[200]  ,5
Return
