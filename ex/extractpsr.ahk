Run, c:\temp\extractmht10\extractmht.exe,"c:\temp\psr\",pid
Sleep, 1000
mht := "c:\temp\psr\" . A_Args[1]
SendInput, %mht%
Send,{Tab}
Send,{Tab}
SendInput, c:\temp\psr\
Send,{enter}
