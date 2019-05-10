;Firefox で表示しているページをはてブする 。
hatebufox(){
    global editor := 0
    global work := 0
    global fox := 0
    ; 作業ウィンドウ探す。
    detectchrome()
    ; 作業ウィンドウ探す。
    detectfirefox()
    ;必要なウィンドウが揃っていない場合は処理を中止する。
    If editor = 0 return
    If work = 0 return
    If fox = 0 return
    ;音声入力されたテキストをクリップボードに転送する
    Process,Exist,eltest.exe
    eltest := %ErrorLevel%
    If eltest = 0 return
    Sleep 100
    WinActivate,ahk_exe eltest.exe
    Sleep 100
    ;テキストをカット&ペーストでクリップボードに転送するがテキスト加工できないので今は利用していない。
    ;SetTitleMatchMode,2
    ;WinActivate, Mozilla Firefox
    ;Sleep 500
    ;Send,^l
    ;Sleep 500
    ;Send,^a
    ;Sleep 500
    ;Send,^c
    ;Sleep 200
    ;bm := clipboard
    ;eltestで音声入力テキストを取り込むショートカットを送信する。
    Send,^d
    Sleep 100
    ;かつてはツールバーの調子が悪いことがあったので Chrome で開き直してブックマークしていたが安定したのでコメントにした。
    ;WinActivate,ahk_id %editor%
    ;Sleep 500
    ;Send,^a
    ;Sleep 500
    ;Send,^x
    ;Sleep 200
    ;msg := clipboard
    ;WinActivate,ahk_id %work%
    ;Sleep 100
    ;Send,^t
    ;Sleep 300
    ;clipboard = %bm%
    ;SendInput, %bm%
    ;Sleep 300
    ;Send,{Enter}
    ;はてブツールバーでブックマークする
    WinActivate,ahk_id %fox%
    Sleep 100
    ;ショートカットキーを送信する
    Send,^+o
    ;clipboard = %msg%
    ;eltestはネット経由でテキストを転送するのでクリップボードに治るまでしっかり待機する。
    Sleep 5000
    ;クリップボードのテキストをコメント欄に貼り付ける。
    Send,^v
    Sleep 100
    ;同時に Twitter にも投稿するチェックをつける。
    Send,{tab}
    Sleep 100
    Send,{space}
    return 
}










