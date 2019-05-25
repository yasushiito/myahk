 ;警告メッセージの準備。
warnMessage := Object()
setWarn()
;Chrome のはてな関係のタブを URL から探す。
    detectchrome()
    if selecttab(work, "", "http://b.hatena.ne.jp/")
        MsgBox, , , hatena found on chrome ,5
;Firefox のはてな関係のタブを URL から探す。
   detectfirefox()
    if selecttab(fox, "", "http://b.hatena.ne.jp/")
        MsgBox, , , hatena found on firefox ,5
;上記以外のブラウザまたはアプリケーションでは URL 探索はできない。
    WinGet, eltest, id, ahk_exe eltest.exe
    If (eltest <> 0) 
        selecttab(eltest, "", "http://b.hatena.ne.jp/")
Return
