;音声入力ウィンドウのテキストを加工しながらクリップボードに放り込む。
;この処理はeltestが提供するGASインポートと自力でクリップボードでカットするやり方の2種類ある。
;通常は後者が選択される。
;アクティブウィンドウ切り替えられる。
;クリップボードの内容は破壊される。
importEditorText(editorurl, useGAS = False){
    if useGAS {
        ;Google Apps Script で作成したインポートプログラムを使う場合。
        Process,Exist,eltest.exe
        eltest := %ErrorLevel%
        warnBox(eltest = 0, 204)
        ;音声入力されたテキストをクリップボードに転送する
        Sleep 100
        WinActivate,ahk_exe eltest.exe
        Sleep 100
        ;eltestで音声入力テキストを取り込むショートカットを送信する。
        Send,^d
        Sleep 100

    }
    Else
    {
        ;音声入力エディタのテキストをクリップボードにカットする。
        cutEditorText(editorurl)
        ;クリップボード内のテキストを eltestで変換して返す。
        replaceClipboard()

    }
}