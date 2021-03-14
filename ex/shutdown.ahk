;ショートカットキーで PC をシャットダウンする。
;いくつかの理由でシャットダウンが失敗することがある。
;アプリケーションによっては編集中のファイルがあるなどシャットダウンを妨げる。
;他のユーザでサインインしていても失敗する。

;UI 上のエフェクトを避けるためにマウスポインターをすみっこに寄せておく。
CoordMode, mouse, Screen
MouseMove, A_ScreenWidth, A_ScreenHeight, 0
sleep 3000

;シャットダウン前に済ませたいこと。
;ヘッドフォンに切り替えたスピーカーを本体に戻す。
;スピーカー出力先を切り替えるアプリAudio switcherのキーボードショートカットから切り替える。
Send, +^{F6}

;スタートボタンの右クリックで開くメニューから電源の項目のシャットダウンを選ぶ。
sleep 5000
Send, #x
sleep 3000
Send, u
sleep 1500
Send, u
