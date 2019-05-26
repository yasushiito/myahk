;Firefox で表示中の Facebook メッセンジャーに音声入力されたテキストをコピペする。
;Firefox のオプションで Ctrl + tab で最近使用した順にタブを切り替えるオプションをオフにしておくこと。
;テキストのコピペはeltestを使う。
;メッセンジャーのページでコメント欄に入力フォーカスを合わせておくこと。
portmessenger(){
    global fox := 0
    global eltest := 0
    global messengerfriendid
    ; 作業ウィンドウ探す。
    detectfirefox()
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(fox = 0, 203)
    ;warnBox(work = 0, 202)
    Process,Exist,eltest.exe
    eltest := %ErrorLevel%
    warnBox(eltest = 0, 204)
    Sleep 100
    ;Firefox をアクティブにしてタブを切り替えながらメッセンジャーページを探す。
    WinActivate,ahk_id %fox%
    Sleep 100
    url := "https\:\/\/www\.facebook\.com\/messages\/t\/"
    url .= messengerfriendid
    selecttab(fox, "", url)
    ;音声入力されたテキストをクリップボードに転送する
    Sleep 100
    WinActivate,ahk_exe eltest.exe
    Sleep 100
    ;eltestで音声入力テキストを取り込むショートカットを送信する。
    Send,^d
    Sleep 100
    ;Firefox に切り替えて貼り付けの待機。
    WinActivate,ahk_id %fox%
    ;eltestはネット経由でテキストを転送するのでクリップボードに治るまでしっかり待機する。
    Sleep 5000
    ;クリップボードのテキストをコメント欄に貼り付ける。
    Send,^v
    Sleep 100
    return 
}










