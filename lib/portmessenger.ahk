;Firefox で表示中の Facebook メッセンジャーに音声入力されたテキストをコピペする。
;Firefox のオプションで Ctrl + tab で最近使用した順にタブを切り替えるオプションをオフにしておくこと。
;テキストのコピペはeltestを使う。
;メッセンジャーのページでコメント欄に入力フォーカスを合わせておくこと。
portmessenger(editorurl, messengerfriendid){
    global fox := 0
    ; 作業ウィンドウ探す。
    detectfirefox()
    ;必要なウィンドウが揃ってない場合は警告をメッセージを表示してアプリケーションを終了する。
    warnBox(fox = 0, 203)
    ;warnBox(work = 0, 202)
    ;Firefox をアクティブにしてタブを切り替えながらメッセンジャーページを探す。
    WinActivate,ahk_id %fox%
    Sleep 100
    url := "https://www.facebook.com/messages/t/"
    url .= messengerfriendid
    selecttab(fox, "", url)
    ;音声入力ウィンドウのテキストを加工しながらクリップボードに放り込む。
    importEditorText(editorurl)
    ;Firefox に切り替えて貼り付けの待機。
    WinActivate,ahk_id %fox%
    ;入力ボックスからフォーカスが外れることが時々あるのでクリックする。
    txtfld := FindTextImages("FBMessangerTextfield")
    ClickImage(txtfld, 1000)
    ;クリップボードのテキストをコメント欄に貼り付ける。
    Send,^v
    Sleep 100
    return 
}
