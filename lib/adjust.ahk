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
    cnt := detectwork(workurl)
    If work = 0 
    {
        ;作業ウィンドウが見つからなかったら Chrome ごと起動する。
        ;作業ウィンドウの URL が config で設定できる。
        ;新しいウィンドウで起動すること。
        if cnt = 0
        {
            Run , %browser% --new-window
            Sleep, 10000
        }
        Else
        {
            ;本当は起動時に開く 特定のページセットを使いたいが初期起動でないと準備してくれないようなので緊急避難的に作業ウィンドウだけを開く。
            ;いつもの初期タブを表示させたければ一度クロームを全て終了させてから起動し直す。
            Run , %browser% --new-window %workurl%
            Sleep, 4000
        }
        ; 作業ウィンドウ探す。
        detectwork(workurl)
    }
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(work = 0, 202)
    WinMove,ahk_id %work%, ,600,20,1200,1050

    ; 音声入力ウィンドウ探す。
    detecteditor(editorurl)
    ; 作業ウィンドウ探す。
    detectfirefox()

    If editor = 0
    {
        ;音声入力ウィンドウが見つからなかったら Chrome ごと起動する。
        ;音声入力ウィンドウの URL が config で設定できる。
        ;新しいウィンドウで起動すること。
        Run , %browser% --new-window %editorurl%
        Sleep, 3000
        ; ウィンドウ探す。
        detecteditor(editorurl)
    }
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(editor = 0, 201)
    WinMove,ahk_id %editor%, ,-120,-220,900,600
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
