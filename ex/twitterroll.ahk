send,#s
sleep 500
send,twitter
sleep 500
send,{enter}
sleep 3000
WinGet, win, ID, A
loop
{
IfWinNotExist, ahk_id %win%
  break
WinGet, now, ID, A
If (win = now) {
loop, 7
{
  Sleep 60
  Send,{up}
}
  Sleep 8000
}

}

