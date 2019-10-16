;現在の日時を参照する。
today := A_Now
MsgBox , , 今日の日時 , % today ,5
;日時を翌日にずらす。
EnvAdd, today, 1, Days
MsgBox, , 明日, % today ,5
;日時を来月にずらす。
EnvAdd, today, 31, Days
MsgBox, , 来月に進めると一日に遡る, % today ,5

;現在の時刻から昨日の日付を得る。
today := A_Now
EnvAdd, today, -1, Days
MsgBox, , マイナスの時は過去に遡って計算できる, % today ,5

;二つの年月日の計算。
date1 := "20040301"
date2 := "20040229"
EnvSub,   date1, date2,Days
MsgBox, , 二つの日付の差を取れる, % date1 ,5

;小さい日付から大きい日付を引いてみる。
date1 := "20040301"
date2 := "20040229"
EnvSub, date2, date1,Days
MsgBox, , マイナスの日付の差も取れる, % date2 ,5
if date2 < 0
    MsgBox, , 日時の比較結果。, date1 は date2よりも新しいです。 ,5
