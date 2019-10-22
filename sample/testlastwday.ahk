;日時と曜日を指定すると、その曜日の直近の年月日を返す処理のテスト。

;今日から未来に向けて一週間をすべての曜日でループする。
bd := A_Now
Loop, 7
{
    Loop, 7
    {
        ;内側のループを曜日としてベースとなる年月日から遡って日時を返してもらう。
        d := getDateByLastwday(bd,A_Index)
    }
    ;日付を1日進める。
    EnvAdd, bd, 1, Days
}

;曜日から直近の年月日を求める。
;第1パラメータ:起点となる年月日。
;第2パラメータ:直近の曜日 wdayと同じで日曜日を1とする数値。
;リターン:年月日。
;起点となる日付から過去一週間以内の W 曜日の年月日を返す。
getDateByLastwday(basedate, lastwday){
    ;変数の初期化。
    msg := ""
    lastdate := basedate
    ;ベースとなる日付の曜日を取得。
    FormatTime, wd, %lastdate%, WDay
    msg .= ("元になる年月日は`n" . lastdate . ":" . wd . "`n")
    msg .= ("知りたい曜日は`n" . lastwday . "`n")
    ;直近の曜日とは何日違うか調べる。
    x := (lastwday - wd)
    ;調べたい曜日が後ろの時は先週の曜日となる。
    If wd <= %lastwday%
        x -= 7
    msg .= ("遡る日数は`n" . x . "`n")
    ;ベースとなる日付から遡る  xは負の値が入っているので ADD でも遡る。
    EnvAdd, lastdate,%x%,Days


    msg .= ("直近の年月日は`n" . lastdate . "`n")
    ;結果の表示。
    MsgBox, , 日時から曜日を調べる, % msg
    Return lastdate
}
