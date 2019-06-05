Run, c:\temp\extractmht10\extractmht.exe,"c:\temp\psr\",pid
Sleep, 1000
Clipboard := "c:\temp\psr\" . A_Args[1]
Send,^v
Sleep, 100
Send,{Tab}
Send,{Tab}
Clipboard := "c:\temp\psr\"
Send,^v
Send,{enter}
WinWait, extractMHT
Sleep, 1000
WinWaitClose, extractMHT
IfWinNotExist, GIMP
{
    gimpexe = "C:\Program Files\GIMP 2\bin\gimp-2.10.exe"
    Run, %gimpexe%,,pid
    WinWait, GIMP (GNU Image Manipulation Program)
}
gimpjpeg := "" . A_ScriptDir . "\gimpjpeg.rb" . ""
Run, %gimpjpeg%