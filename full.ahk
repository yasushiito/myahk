;警告メッセージの準備。
warnMessage := Object()
setWarn()
;設定の読み込み。
;はてなブログの ID。
hatenaid := ""
;音声入力エディタの URL。
editorurl := ""
;作業用ウインドウの URL。
workurl := ""
;Facebook でメッセンジャーする相手の ID。
messengerfriendid := ""

getconfig()
Menu, tray, click, 1
Menu, tray, add, config, config
;ウィンドウの端っこにマウスポインタを停止させるとスクロールできるのを頻繁に使うので常に有効にするよう昇格させた。
scrollhover()
;ウィンドウの位置とサイズを調整して音声入力と作業ウインドウを用意する。
adjust()
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
;長押しした時はアクティブウィンドウのカーソル周辺の単語を Chrome でネット検索する。
ScrollLock::
    ;長押し判定。
    ;スクリーンキーボードからマウスクリックで2入力しているので左ボタンを監視している。
    KeyWait, LButton, T1
    if ErrorLevel
    {
        wordgooglesearch()
        Return
    }

    Return
;音声入力ウィンドウのマイクをオンにする。
;長押しした時はアクティブウインドウに音声入力ウィンドウのテキストを転送する。
Pause::
    ;長押し判定。
    ;スクリーンキーボードからマウスクリックで2入力しているので左ボタンを監視している。
    KeyWait, LButton, T1
    if ErrorLevel
    {
        portAny()
        Return
    }
    mmic(editorurl)
    Return
;マウスポインターをウィンドウの両端で一定期間停止させるとスクロールさせる。
#+PgUp::
    scrollhover()
    Return
;Chrome の新規タブで音声検索を開始する。
; no asign
    ;googlesearch
