WinActivate, ahk_exe psr.exe
Sleep, 1000
Send,{Tab}
Send,!v
Sleep, 1000
Clipboard := "c:\temp\psr\psr.zip"
Send,^v
Send,{Enter}
Sleep, 1000
IfWinExist, 名前を付けて保存
    Send, y
Sleep, 2500
WinClose, ahk_exe psr.exe
bat := """" . A_ScriptDir . "\extractpsr.bat" . """"
Run, %bat%