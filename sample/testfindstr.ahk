
initstr := ""
abc := "abcdefg"
c := "c"
IfInString, abc, b
    MsgBox, , IfInStringで文字列の中を検索。, 第2パラメータは文字列として扱われる。,5
IfInString, abc, %c%
    MsgBox, , IfInStringで文字列の中を検索。, 変数の内容を使って検索できる。,5
    MsgBox, , , b ,5

Return
