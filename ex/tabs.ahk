;Totally Accurate Battle Simulator
;ahk_class UnityWndClass
;ahk_exe TotallyAccurateBattleSimulator.exe
;ahk_pid 15976

#IfWinActive, ahk_exe TotallyAccurateBattleSimulator.exe

global tabs ;tabs winHnd
global self
global dblstopper := False
global BattleMode := False
global base := 0
global cx := 0  ;マウスが停滞していることを判定するために前回のマウス位置を記憶しておく。
global cy := 0  ;マイナスの時は判定エリア外に出ていたとのこと。
global stay := 0
global camwork := 1
global camworkcaptions := Object()
camworkcaptions[1] := "1 中央手前から俯瞰"
camworkcaptions[2] := "2 自分から俯瞰"
camworkcaptions[3] := "3 動かない"
camworkcaptions[4] := "4 地上まで降りる"
camworkcaptions[5] := "5 動かない"
global camworkmove := Object()
camworkmove[1] := "50,0,-20"
camworkmove[2] := "-25,0,10"
camworkmove[3] := "0,0,0"
camworkmove[4] := "125,0,0"
camworkmove[5] := "-25,0,-10"
global camfb := 0
global camlr := 0
global camz := 0
global godview := 0
global camofb := 0
global camolr := 0
global camoz := 0
global camstep := 2
global dlgPos := 0
global camEtc := "1,3,5,30"
global sendRBtn := False

WinGet, tabs, id, ahk_exe TotallyAccurateBattleSimulator.exe
if tabs = 0
{
  msgbox, , , Tabs を起動してください
  return
}

Gosub, unpackCamEtc
Gosub, unpackCamwork
Gosub, MakeGui
Gosub, ShowGui
Gosub, mover
SetTimer, BaseTimer, 500

LButton::
  KeyWait, LButton, T1
  if (ErrorLevel){
    SetTimer, EscapeBattleTimer, 100
    Return
  }
  Send, {LButton}
  if BattleMode
  {
;  Sleep, 80
    send, {w 15}
  }
  Return

p::
    SetTimer, EscapeBattleTimer, 60000
    SetTimer, StartBattleTimer, 3000
    return

o:: 
  BattleMode := False
  SetTimer, BaseTimer, off
  SetTimer, EscapeBattleTimer,off
  SetTimer, BattleTimer, off
  return

StartBattleTimer:
  WinGetPos, x, y, w, h, ahk_exe TotallyAccurateBattleSimulator.exe
  MouseMove, w/2, h/10
  Send,{LButton}
  Sleep, 1000
  SetTimer, StartBattleTimer, off
  if !godview
  {
    Send,{f}
    Sleep, 800
    Send,{f}
    Sleep, 1800
  }
  camfb := camofb
  camlr := camolr
  camz := camoz
  SetTimer, BattleTimer, 150
  BattleMode := True
  return

EscapeBattleTimer:
  Send,{Tab}
  Sleep, 50
  BattleMode := False
  SetTimer, EscapeBattleTimer,off
  SetTimer, BattleTimer, off
  Gosub, ShowGui
  Return

BaseTimer:
  MouseGetPos, mx, my, hnd
  WinGetTitle, title, ahk_id %hnd%
  if title = TABSカメラ操作
  {
    WinActivate, ahk_id %hnd%
    return
  }
  IfWinNotActive ahk_exe TotallyAccurateBattleSimulator.exe
    return
  if BattleMode
    return
  if hnd != %tabs%
    return
  if hnd = %self%
  {
    WinActivate, ahk_id %self%
  }
;マウスポインタが停滞しているか。
;小刻みに震えていても停滞していることにするために少し余裕を持たせてある。
  WinGetPos, x, y, w, h
  if mx > w / 2
  {
;    return
  }
  d:=3
  rsx := cx - d
  rex := cx + d
  rsy := cy - d
  rey := cy + d
  if mx Between %rsx% and %rex%
  {
    if my Between %rsy% and %rey%
    {
  ;停滞しているのでカウンターを増やし。
      if dblstopper
        return
      stay += 1
      if (stay > 3)
      {
        stay := 0
        dblstopper := True
        rx := w / 10
        ry := h - 40
        if (mx < rx) and (my > ry)
        {
          Gosub, btnLR
          return
        }
        if sendRBtn
        {
          Send, {RButton down}
          Sleep, 100
          Send, {RButton up}
        }
        Else
        {
          Send, {LButton down}
          Sleep, 100
          Send, {LButton up}
        }
      }
      return
    }
  }
;ポインタを動かしているので停滞カウンタをリセットして今の位置を記憶しておく。
  cx := mx
  cy := my
  stay := 0
  dblstopper := False
  return

BattleTimer:
  Loop, %camstep%
  {
    if (camfb > 0)
    {
      camfb := camfb - 1
      send, {w}
    }
    if (camfb < 0)
    {
      camfb := camfb + 1
      send, {s}
    }
    if (camlr > 0)
    {
      camlr := camlr - 1
      send, {d}
    }
    if (camlr < 0)
    {
      camlr := camlr + 1
      send, {a}
    }
    if (camz > 0)
    {
      camz := camz - 1
      send, {e}
    }
    if (camz < 0)
    {
      camz := camz + 1
      send, {q}
    }
  }
  Return

MakeGui:
  Gui, Font, S15
  Gui, Add, Checkbox, checked%godview% vgodview gcheckgodview, 神視点
  vc := camworkcaptions[1]
  i := camworkcaptions.Length() - 1
  Loop, %i%
  {
    if A_Index = %camwork%
    {
      vc := vc . "|"
    }
    vc := vc . "|" . camworkcaptions[A_Index+1] 
  }
    l := camworkcaptions.Length()
  if camwork = %l%
  {
    vc := vc . "||"
  }
  ;msgbox, , , % camworkcaptions.Length()
  ;msgbox, , , % camworkcaptions[camwork]
;  msgbox, , , % vc
  Gui, add, DropDownList, x+20 w200 gselCamWork vcamwork, %vc%
  Gui, Add, Button, W200 X25 Default gsubmit, ！バトル開始！
  if sendRBtn
    s := "LBtn"
  Else
    s := "RBtn"
  Gui, Add, Button, W40 X+40 gbtnLR, %s%
  Gui, add, text, X0, 開始直後のカメラの動き
  Gui, Add, Button, X10 W40 gbtnoq, Q
  Gui, Add, Button, X+80 W40 gbtnow, W
  Gui, Add, Button, X+80 W40 gbtnoe, E
  Gui, add, text, X10, 進（＋でW）退（－でS）
  Gui, add, edit, vcamofb x+20 w60, %camofb%
  Gui, add, text, X10, 右（＋でD）左（－でA）
  Gui, add, edit, vcamolr x+20 w60, %camolr%
  Gui, add, text, X10, 上（＋でE）下（－でQ）
  Gui, add, edit, vcamoz X+20 w60, %camoz%
  Gui, Add, Button, X10 W40 gbtnoa, A
  Gui, Add, Button, X+80 W40 gbtnos, S
  Gui, Add, Button, X+80 W40 gbtnod, D
  Gui, add, text, X20, 移動量
  Gui, add, edit, X+10 vcamstep w40, %camstep%
  Gui, Add, Button, W40 X5 gmover, →
  Gui, Add, Button, W90 X+70 gsendEsc, ESC
  Gui, Add, Button, W40 X+70 gmovel, ←
  Gui, Add, Button, W80 X100 gbtnUpdate, 更新
  Gui, Add, Button, W80 X+20 gbtnSave, 保存
  return

ShowGui:
;ダイアログを表示する。
  Gui, Show, , TABSカメラ操作
  if dlgPos = 0
  {
    Gosub, movel
  }
  Else
  {
    Gosub, mover
  }
  WinGet, self, id, a 
  return

submit:
  Gui, Submit
  CoordMode, Mouse, Relative
  WinActivate, ahk_exe TotallyAccurateBattleSimulator.exe
  SetTimer, EscapeBattleTimer, 60000
  SetTimer, StartBattleTimer, 3000
  return

ButtonCancel:
    Gui, Destroy
    Return

checkgodview:
  return

selCamWork:
  Gui, Submit
  StringSplit, ret, camwork, %A_Space%,
;  msgbox, , , %ret1%
  camwork := ret1
  Gui, Destroy
  Gosub, unpackCamwork
  Gosub, MakeGui
  Gosub, ShowGui
  return


btnoq:
  camoz := camoz - 5
  Gui, Destroy
  Gosub, MakeGui
  Gosub, ShowGui
  return

btnow:
  camofb := camofb + 5
  Gui, Destroy
  Gosub, MakeGui
  Gosub, ShowGui
  return

btnoe:
  camoz := camoz + 5
  Gui, Destroy
  Gosub, MakeGui
  Gosub, ShowGui
  return

btnoa:
  camolr := camolr - 5
  Gui, Destroy
  Gosub, MakeGui
  Gosub, ShowGui
  return

btnos:
  camofb := camofb - 5
  Gui, Destroy
  Gosub, MakeGui
  Gosub, ShowGui
  return

btnod:
  camolr := camolr + 5
  Gui, Destroy
  Gosub, MakeGui
  Gosub, ShowGui
  return

btnUpdate:
  Gui, submit
  Gosub, packCamwork
  Gui, Destroy
  Gosub, MakeGui
  Gosub, ShowGui
  return

btnSave:
  IniWrite, %editorurl%, %A_ScriptDir%\tabsconf.ini, user, editorurl
  Gosub, MakeGui
  Gosub, ShowGui
  return

packCamwork:
  w := camofb . "," . camolr . "," . camoz
  camworkmove[camwork] := w
  return

packCamEtc:
  w := godview . "," . camwork . "," . camstep
  camEtc := w
  return

unpackCamwork:
  w := camworkmove[camwork]
  StringSplit, ret, w, `,
  camofb := ret1
  camolr := ret2
  camoz := ret3
  return

unpackCamEtc:
  w := camEtc
  StringSplit, ret, w, `,
  godview := ret1
  camwork := ret2
  camstep := ret3
  return

mover:
  WinMove, a, , 1400, 300 
  dlgPos := 1
  return

movel:
  WinMove, a, , 50, 300 
  dlgPos := 0
  return

btnLR:
  sendRBtn := !sendRBtn
  Gui, Destroy
  Gosub, MakeGui
  Gosub, ShowGui
  WinActivate, ahk_id %tabs%
  return

sendEsc:
  WinActivate, ahk_exe TotallyAccurateBattleSimulator.exe
  Sleep, 1000
  send, {Escape}
  return

 