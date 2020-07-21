;曜日から直近の年月日を求める。
;第1パラメータ:起点となる年月日。
;第2パラメータ:直近の曜日 wdayと同じで日曜日を1とする数値。
;リターン:年月日。
;起点となる日付から過去一週間以内の W 曜日の年月日を返す。
getLastDateByWday(basedate, lastwday){
    lastdate := basedate
    ;ベースとなる日付の曜日を取得。
    FormatTime, wd, %lastdate%, WDay
    ;直近の曜日とは何日違うか調べる。
    x := (lastwday - wd)
    ;調べたい曜日が後ろの時は先週の曜日となる。
;    If wd <= %lastwday%
    If wd < %lastwday%
        x -= 7
    ;ベースとなる日付から遡る  xは負の値が入っているので ADD でも遡る。
    EnvAdd, lastdate,%x%,Days
    Return lastdate
}
