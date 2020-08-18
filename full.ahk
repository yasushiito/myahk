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

;マウスドラッグをアシストする。
;
;アプリケーションキーをスクリーンキーボードで長押しすると起動する。
;メッセージボックスが表示された後ドラッグ位置記憶モードに入る。
;ドラッグ位置記憶モードといっても視覚的には何も変化はない。
;マウスクリックで開始位置と終了位置を設定できる。
;2回目のクリックで終了位置を決定するとマウスポインターが自動操作に切り替わってドラッグする。
;ドラッグ位置記憶モードのキャンセルはできない
;間違って起動した場合は適当な場所で2回クリックする。
;タスクマネージャースクリーンキーボードのような上位のレイヤーで動いているアプリケーションの上ではクリックしても位置記憶できない。
;ドラッグ位置記憶モードのクリックでも、有効なクリックなので、 ファイルを移動させるつもりでアイコンをクリックすると普通に実行されるので注意。
;
;開始と終了2点の座標は記憶されるので繰り返し再生できる。
;シフトキーを押しながらアプリケーションキーの長押しで再生する。
;座標が記憶されていない時に再生すると警告メッセージが出る。


;ドラッグ位置記憶する変数。
global dragArea
AppsKey::
    ;長押し判定。
    ;スクリーンキーボードからマウスクリックで入力しているので左ボタンを監視している。
    KeyWait, LButton, T1
    if ErrorLevel
    {
        ;ドラッグ位置記憶モードの合図としてメッセージを表示。
        MsgBox, , , 左クリック2回でドラッグ位置記憶, 2
        ;左ボタンを押し下げて離れたらワンクリックとする。
        CoordMode,Mouse,Screen
        KeyWait, LButton, D
        Sleep, 100
        KeyWait, LButton, U
        ;開始地点の座標をスクリーン上の絶対位置で取得する。
        MouseGetPos, sx, sy
        ;2回目のクリックも同様に取得する。
        KeyWait, LButton, D
        Sleep, 100
        KeyWait, LButton, U
        MouseGetPos, ex, ey

        ;操作を繰り返すために開始と終了の座標を保存しておく。
        dragArea := sx . "," . sy . "," . ex . "," . ey
        
        ;ドラッグの自動操作。
        ;ユーザの操作を無視する。
        BlockInput, Mouse
        Sleep, 500
        ;マウスポインターを開始位置に移動させて左ボタンを押し下げる。
        MouseMove, sx, sy, 0
        Send, {LButton down}
        Sleep, 20
        ;そのまま終了位置に移動してからボタンを離す。
        MouseMove, ex, ey, 20
        Send, {LButton up}
        ;ユーザのマウス操作を有効にして終わり。
        BlockInput, off
        Return
    }
    ;長押しではなかった場合は通常通りにアプリケーションキー送信する。
    Send, {AppsKey}
    Return


;シフトキーを押しながらアプリケーションキーの長押し。
;マウスドラッグ操作をもう一度行う。
+AppsKey::
    ;長押し判定。
    ;スクリーンキーボードからマウスクリックで入力しているので左ボタンを監視している。
    KeyWait, LButton, T1
    if ErrorLevel
    {
        ;記憶された座標をカンマで分解して復元する。
        StringSplit, pos, dragArea, `,
        sx := pos1
        sy := pos2
        ex := pos3
        ey := pos4
        ;座標として復元できなかった場合は処理中止。
        i := sx . sy . ex . ey
        if i is not Number
        {
            MsgBox, , , 領域選択の記録を失敗しています\n%i%, 3
            Return
        }
        ;マウスドラッグの自動操作行う。
        CoordMode,Mouse,Screen
        BlockInput, Mouse
        Sleep, 500
        MouseMove, sx, sy, 0
        Send, {LButton down}
        Sleep, 20
        MouseMove, ex, ey, 20
        Send, {LButton up}
        BlockInput, off
        Return
    }
    ;長押しでなければ普通にシフトキーを押しながらのアプリケーションキー押下を送信する。
    Send, +{AppsKey}
    Return
;Chrome の新規タブで音声検索を開始する。
; no asign
    ;googlesearch
