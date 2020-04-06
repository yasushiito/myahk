;警告メッセージの準備。
warnMessage := Object()
setWarn()
;はてなブログの ID。
hatenaid := ""
;音声入力エディタの URL。
editorurl := ""
;作業用ウインドウの URL。
workurl := ""
;Facebook でメッセンジャーする相手の ID。
messengerfriendid := ""
;functionキーで 開くラジオのチャンネル名をカンマ区切りで。
radikoch := ""
;設定の読み込み。
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
    blogentry(hatenaid, editorurl, workurl)
    Return
;作業用ウィンドウで開いているページを編集中のブログにリンク挿入する。
#=::
    blogrefemb(workurl)
    Return
;作業用ウィンドウで開いているページを編集中のブログに選択文字列でリンク挿入する 。
#+=::
    blogrefsel(workurl)
    Return
;作業用ウィンドウで開いているGithub 上のファイルを編集中のブログに挿入する。
#^=::
    blogrefgithub(workurl)
    Return
;Chrome の新規タブで音声検索する。
#home::
    googlesearch(workurl)
    Return
;常用アプリケーションのウィンドウサイズと位置の調整。
#+home::
    adjust()
    Return
; Google Chrome に表示されているページをはてブする 。
#2::
    hatebucrm(editorurl, workurl)
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
        wordgooglesearch(workurl)
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
        portAny(editorurl)
        Return
    }
    mmic(editorurl)
    Return
;マウスポインターをウィンドウの両端で一定期間停止させるとスクロールさせる。
#+PgUp::
    scrollhover()
    Return
;ブラウザで Radiko のライブページを開く。
;放送局一覧はコンフィグで ini ファイルに記録されている。
F1::
    RadikoChrome(1, radikoch, workurl)
    Return
;ブラウザで Radiko のライブページを開く。
;放送局一覧はコンフィグで ini ファイルに記録されている。
F2::
    RadikoChrome(2, radikoch, workurl)
    Return
;ブラウザで Radiko のライブページを開く。
;放送局一覧はコンフィグで ini ファイルに記録されている。
F3::
    RadikoChrome(3, radikoch, workurl)
    Return
;ブラウザで Radiko のライブページを開く。
;放送局一覧はコンフィグで ini ファイルに記録されている。
F4::
    RadikoChrome(4, radikoch, workurl)
    Return
;ブラウザで Radiko のライブページを開く。
;放送局一覧はコンフィグで ini ファイルに記録されている。
F5::
    RadikoChrome(5, radikoch, workurl)
    Return
;ブラウザで Radiko のライブページを開く。
;放送局一覧はコンフィグで ini ファイルに記録されている。
F6::
    RadikoChrome(6, radikoch, workurl)
    Return
;ブラウザで Radiko のライブページを開く。
;放送局一覧はコンフィグで ini ファイルに記録されている。
F7::
    RadikoChrome(7, radikoch, workurl)
    Return
;ブラウザで Radiko のライブページを開く。
;放送局一覧はコンフィグで ini ファイルに記録されている。
F8::
    RadikoChrome(8, radikoch, workurl)
    Return
;ブラウザで Radiko のライブページを開く。
;放送局一覧はコンフィグで ini ファイルに記録されている。
F9::
    RadikoChrome(9, radikoch, workurl)
    Return
;ブラウザで Radiko のライブページを開く。
;放送局一覧はコンフィグで ini ファイルに記録されている。
F10::
    RadikoChrome(10, radikoch, workurl)
    Return
;Chrome の新規タブで音声検索を開始する。
; no asign
    ;googlesearch
