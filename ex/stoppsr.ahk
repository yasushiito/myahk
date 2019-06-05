WinActivate, ahk_exe psr.exe
Sleep, 100
Send,{Tab}
Send,!v
Clipboard := "c:\temp\psr\psr.zip"
Send,^v
Send,{Enter}
Sleep, 1000
IfWinExist, 名前を付けて保存
    Send, y
Sleep, 1000
WinClose, ahk_exe psr.exe
