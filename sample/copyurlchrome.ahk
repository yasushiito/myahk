;ブラウザの URL を取得するためのサンプル。
;【AutoHotkey】ブラウザで表示中のページの URL を取得したい。
;http://yasushiito.hatenablog.com/entry/2019/05/17/084621
#1::
;Windows +1のショートカットで起動できます。
;Google Chrome をアクティブにしてから起動してください。
    ;URL バーに移動します。
    Send,^l
    Sleep 200
     ;URL を選択します。
    Send,^a
    Sleep 200
    ;URL をコピーします。
    Send,^c
    Sleep 200
    ;クリップボードの内容を確認しています。
   MsgBox, , , % Clipboard ,5
    ;からの JavaScript コマンド実行してみます。
    SendInput, javascript:
    Sleep 300
    Send,{Enter}
    Sleep 300
    ;ウェブページにフォーカスがあることを確認してみてください。
Return
