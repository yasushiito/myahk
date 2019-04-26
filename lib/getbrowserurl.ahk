getbrowserurl(){
    ; URL バーをフォーカスして URL をすべて選択してコピー 。
    Send,^l
    Sleep 200
    Send,^a
    Sleep 200
    Send,^c
    Sleep 300
    return
}












