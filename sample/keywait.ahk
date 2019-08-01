;長押しした時に別の処理を行うテスト。
Menu, tray, click, 1
Esc::
  KeyWait, Esc, T1
  if (ErrorLevel){
    Send,T
    Sleep, 1000
    Return
  }
  Send,F
  Return