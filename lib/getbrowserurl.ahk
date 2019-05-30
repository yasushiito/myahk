getbrowserurl(retfocus = False){
    ; URL バーをフォーカスして URL をすべて選択してコピー 。
    Send,^l
    Sleep 100
    Send,^a
    Sleep 100
    Send,^c
    Sleep 100
    If retfocus
    {
        ;Google Chrome では空っぽの JavaScript を実行して入力フォーカスをページに戻すことができる。
        SendInput, javascript:
        Sleep 100
        Send,{Enter}
    }
    return Clipboard
}
