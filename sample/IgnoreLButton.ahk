;マウスの左ボタンを無視するテスト。

;特定の状態の時、ユーザのクリック操作を 無効にできるかの実験。
;本当にクリックできなくなると困るので無視するのは2回まで。
;tab キーで クリック無効カウンターを2階に設定。
;ESC キーで終了。


;左ボタンを無視する回数、1以上で無視する。
global ignoreCnt := 0

LButton::
    ;カウンタの設定を間違えても脱出できるようにカウンターを減算してからチェックしている。
    ignoreCnt -= 1
    if ignoreCnt >= 0
        ;キャンセル中なので途中離脱。
        Return
    ;ボタン押下が有効な状態なのでボタン送信。
    ignoreCnt := 0
    Send, {LButton}
    Return



Esc::
    ExitApp, 1

Tab::
    ignoreCnt := 2
    Send, {Tab}
    Return
