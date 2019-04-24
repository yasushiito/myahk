; はてなブログの新規エントリーを用意する。
;新規エントリーページは作業用ウィンドウで開かれる。
;音声入力用ウィンドウのテキストをタイトルに利用する。
;テキストの内容はテキストランチャーによって展開される。
;クリップボードの内容は破壊される 。
blogentry(hatena){
    editor := 0
    work := 0
    WinGet, windows, list
    loop ,%windows%
    {
        idstr := "ahk_id " . windows%A_Index%
        WinGetTitle,title,%idstr%
        pos := RegExMatch(title,"- Google Chrome$")
        if pos > 0
        {
            pos := RegExMatch(title,"音声入力用")
            if pos > 0
            {
                WinGet,editor,ID,%idstr%
            }
            else
            {
                WinGet,work,ID,%idstr%
            }
        }
    }
    If (editor = 0) return
    If (work = 0) return
    ; 作業ウィンドウに切り替える 。
    Sleep 500
    WinActivate,ahk_id %work%
    Sleep 500
    ; 新規タブを開いて新規エントリページを開く。
    Send,^t
    Sleep 500
    SendInput,http://blog.hatena.ne.jp/%hatena%/%hatena%.hatenablog.com/edit
    Send,{enter}
    ; ページが開くのをしっかり待ってからタイトルにフォーカスを移す 。
    Sleep 3000
    Send,+{Tab}
    Sleep 500
    ; テキストランチャーに切り替えてクリップボードにコピーボタンを押す 。
    Process,Exist,eltest.exe
    if ErrorLevel = 0
        return
    WinActivate,ahk_pid %ErrorLevel%
    Sleep 500
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
    Sleep 500
    return
}












