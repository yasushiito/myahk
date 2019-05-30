;常用アプリケーションのウィンドウサイズと位置の調整。
;調整するのは次のアプリ。
;Google Chrome の音声入力ウィンドウ。
;Google Chrome の作業ウィンドウ。
;Firefox。
;ランチャーアプリeltest。
;Visual Studio code。
adjust(){
    global editor := 0
    global work := 0
    global fox := 0
    global eltest := 0
    ; 作業ウィンドウ探す。
    detectchrome()
    ; 作業ウィンドウ探す。
    detectfirefox()

    If (editor <> 0) {
        WinMove,ahk_id %editor%, ,-120,-220,900,600
    }
    If (work <> 0) {
        WinMove,ahk_id %work%, ,600,20,1200,1050
    }
    Process,Exist,eltest.exe
    eltest := %ErrorLevel%
    If (eltest <> 0) {
        WinMove,ahk_exe eltest.exe, ,175,470,420,320
    }
    Process,Exist,code.exe
    code := %ErrorLevel%
    If (code <> 0) {
        WinMove,ahk_exe code.exe, ,590,30,1100,1080
    }
    return
}
