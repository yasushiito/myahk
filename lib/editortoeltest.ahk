    ;音声入力エディタのテキストをeltestに転送する。
editortoeltest(editorurl){
    clipboard := ""
    ;音声入力エディタのテキストをカットする。
    cutEditorText(editorurl)
    ;eltest探して切り替える。
    Process,Exist,eltest.exe
    eltest := %ErrorLevel%
    If eltest <> 0
    {
        WinActivate, ahk_exe eltest.exe
        Sleep, 100
        ;eltestはCtrl + C でクリップボードの内容を textarea に取り込める。
        Send, ^c
    }
}