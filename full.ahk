;警告メッセージの準備。
warnMessage := Object()
setWarn()
;設定の読み込み。
    ;はてなブログの ID。
global hatenaid
    ;音声入力エディタの URL。
global editorurl
getconfig()
Menu, tray, click, 1
Menu, tray, add, config, config
Return
config:
    setconfig()
    Return

#insert::
; はてなブログの新規エントリーを用意する。
    blogentry(hatenaid)
    Return
;作業用ウィンドウで開いているページを編集中のブログにリンク挿入する。
#=::
    blogrefemb()
    Return
;作業用ウィンドウで開いているページを編集中のブログに選択文字列でリンク挿入する 。
#+=::
    blogrefsel()
    Return
;作業用ウィンドウで開いているGithub 上のファイルを編集中のブログに挿入する。
#^=::
    blogrefgithub()
    Return
;Chrome の新規タブで音声検索する。
#home::
    googlesearch()
    Return
;常用アプリケーションのウィンドウサイズと位置の調整。
#+home::
    adjust()
    Return
; Google Chrome に表示されているページをはてブする 。
#2::
    hatebucrm()
    Return
; Firefox で表示しているページをはてブする 。
#+2::
    hatebufox()
    Return
;IME を切り替える。
CapsLock::Send, {vkF3sc029}
;音声入力ウィンドウのマイクをオンにする。
pause::
    mmic(editorurl)
    Return
;マウスポインターをウィンドウの両端で一定期間停止させるとスクロールさせる。
#+PgUp::
    scrollhover()
    Return
;Chrome の新規タブで音声検索を開始する。
; no asign
    ;googlesearch
