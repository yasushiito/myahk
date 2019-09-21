;クリップボード内のテキストを eltestで変換して返す。
replaceClipboard(){
    Process,Exist,eltest.exe
    eltest := %ErrorLevel%
    warnBox(!eltest, 204)
    ; 作業ウィンドウに切り替えて埋め込みたいページを全面にする。
    WinActivate,ahk_exe eltest.exe
    Sleep 200
    ;テキスト変換を行うキーボードショートカットを送信。
    Send,^c
    Sleep 200
    msg := clipboard
    return msg
}
