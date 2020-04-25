; #Include <FindText>

 t1:=A_TickCount, X:=Y:=""

Text:="|<>*190$60.zzzzzzzzzzzzzzzzzkzzk0000zUkzzk0000zUkzzk0000z1kzzzzUzzz1kzzzzUzzy0003w0007y0003w0007w0003w0007s0003w7Uy7k7kzzw7Uy7sDkzzw0007wTkzzw0007zzkzzw0007w0003w7Uy7w0003w7Uy7w0003U0000w0003U0000zzkzzU0000zzkzzw7zy7zzkzzw7zy7zzkzzw7zy7zzkzzw7z07k0001U"

 if (ok:=FindText(1417-150000, 764-150000, 1417+150000, 764+150000, 0, 0, Text))
 {
   CoordMode, Mouse
   X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
   ; Click, %X%, %Y%
 }

 MsgBox, 4096, Tip, % "Found :`t" Round(ok.MaxIndex())
   . "`n`nTime  :`t" (A_TickCount-t1) " ms"
   . "`n`nPos   :`t" X ", " Y
   . "`n`nResult:`t" (ok ? "Success !" : "Failed !")

 for i,v in ok
   if (i<=2)
     MouseTip(ok[i].x, ok[i].y)


;===== Copy The Following Functions To Your Own Code Just once =====

ExitApp, 1