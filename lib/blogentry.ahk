; はてなブログの新規エントリーを用意する。
;新規エントリーページは作業用ウィンドウで開かれる。
;音声入力用ウィンドウのテキストをタイトルに利用する。
;テキストの内容はテキストランチャーによって展開される。
;クリップボードの内容は破壊される 。
blogentry(hatena){
    global editor := 0
    global work := 0
    ; 作業ウィンドウ探す。
    detectchrome()
    If editor = 0 return
    If work = 0 return
    ; 作業ウィンドウに切り替える 。
    Sleep 100
    WinActivate,ahk_id %work%
    Sleep 100
    ; 新規タブを開いて新規エントリページを開く。
    Send,^t
    Sleep 100
    SendInput,http://blog.hatena.ne.jp/%hatena%/%hatena%.hatenablog.com/edit
    Send,{enter}
    ; ページが開くのをしっかり待ってからタイトルにフォーカスを移す 。
    Sleep 3000
    Send,+{Tab}
    Sleep 100
    ; テキストランチャーに切り替えてクリップボードにコピーボタンを押す 。
    Process,Exist,eltest.exe
    if ErrorLevel = 0
        return
    WinActivate,ahk_pid %ErrorLevel%
    Sleep 100
    Send,^d
    ; テキストの取得を待ちながら作業用ウィンドウがアクティブであることを確認 。
    Sleep 5000
    WinActivate,ahk_id %work%
    Sleep 500
    ; コピーしたテキストをタイトルとして貼り付け 。
    Send,^v
    Sleep 500
    ; フォーカスをタイトルから本文のテキストエリアに移す 。
    Send,{Tab}
    return
}












