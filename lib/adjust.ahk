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
    global editorurl
    global workurl
    browser := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    ; 作業ウィンドウ探す。
    detectwork(workurl)
    ;作業ウィンドウが見つからなかったら Chrome ごと起動する。
    If work = 0 
    {
        ;すでに開いていた Chrome を閉じる。
        ;一枚でも Chrome ウィンドウが起動していると いつも使っているタブを開いて起動できない。
        closeblankchrome()
        Sleep, 1000
        ;新しいウィンドウで起動すること。
        Run , %browser% --new-window
        Sleep, 10000
        ; 作業ウィンドウ探す。
        detectwork(workurl)
    }

    ; 音声入力ウィンドウ探す。
    detecteditor(editorurl)
    IfWinNotExist, %editor%
    {
        ;音声入力ウィンドウが見つからなかったら Chrome ごと起動する。
        ;音声入力ウィンドウの URL が config で設定できる。
        ;新しいウィンドウで起動すること。
        Run , %browser% --new-window %editorurl%
        Sleep, 5000
        ; ウィンドウ探す。
        detecteditor(editorurl)
    }
    ;最終的に余分な Chrome ウィンドウは閉じる。
    closeblankchrome("chrome://newtab/")
    ; firefoxウィンドウ探す。
    detectfirefox()

    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(work = 0, 202)
    WinActivate, ahk_id %work%, ,%editor%
    ;位置とサイズを調整する。
    WinMove, A, ,600,20,1200,1050
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(editor = 0, 201)
    ;位置とサイズを調整する。
    WinMove,%editor%, ,-120,-220,900,600
    if fox = 0
    {
        Run , "C:\Program Files\Mozilla Firefox\firefox.exe"
        Sleep, 5000
        detectfirefox()
    }
    WinMove,ahk_id %fox%, ,660,40,1240,1000
    Process,Exist,eltest.exe
    eltest := %ErrorLevel%
    If eltest <> 0
    {
        WinMove,ahk_exe eltest.exe, ,175,470,420,320
    }
    ;Visual Studio CODE の位置とサイズの調整。
    Process,Exist,code.exe
    code := %ErrorLevel%
    If code <> 0
    {
        WinMove,ahk_exe code.exe, ,590,30,1100,1050
    }
    ;スクリーンキーボードは必須なので見つからなかったら起動する。
    Process,Exist,osk.exe
    osk := %ErrorLevel%
    if osk = 0
    {
        Run, osk.exe
        Sleep 1500
    }
    ;スクリーンキーボードの位置とサイズの調整 ただし管理者権限で実行した時のみ作用する。
    WinMove,ahk_exe osk.exe, ,120,747,646,196
    ;エクスプローラの位置とサイズの調整。
    ;ただし OS が管理しているエクスプローラーのハンドルを掴んでしまうので Window クラスでウィンドウをつかんでいる。
    ;同じクラスを使ったアプリケーションがあると失敗するかも。
    if !WinExist("ahk_class CabinetWClass")
    {
        Run, explorer.exe
        Sleep 1500
    }
    WinMove,ahk_class CabinetWClass, ,460,10,1068,710
    return
}
;Google Chrome で Ctrl +矢印を入力すると5回ずつ移動する。
;Ctrl +矢印では単語ごとに移動して欲しいところだけど、 Google Chrome は日本語を分解できないので結局1文字ずつしか動かない。
;スクリーンキーボードにはキーのリピート機能がないので キャレットの移動がめちゃくちゃ大変。
;そこでAutoHotkeyを利用して5回ずつ固定でもいいから大きめに動かすようにする。
;範囲選択しながら移動する時に困らないようにシフトキーとの組み合わせにも対応する。

#IfWinActive ahk_exe Chrome.exe
^Left::    send, {Left 5}
^+Left::    send, +{Left 5}
^Right::    send, {Right 5}
^+Right::    send, +{Right 5}
^Up::    send, {Up 5}
^+Up::    send, +{Up 5}
^Down::    send, {Down 5}
^+Down::    send, +{Down 5}

;このスクリプトを直接起動した場合はここから関数呼び出し。
;エクスプローラーなどから直接管理者権限で実行したい時などに使う。
If A_ScriptName = adjust.ahk
    adjust()