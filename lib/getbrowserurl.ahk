getbrowserurl(retfocus = False){
    ; キーボードショートカットでアドオンまたは Extension を呼び出して URL を取得する。
    ;調べたいブラウザを アクティブにしてから呼び出してください。
    ;
    ; Google Chrome ではURL をクリップボードにコピーで行う。
    ;https://chrome.google.com/webstore/detail/copy-url-to-clipboard/miancenhdlkbmjmhlginhaaepbdnlllc?hl=ja
    ;設定は ALT + C で選択中のタブのみをプレーンテキストでコピーするようにしておくこと。
    ;Firefox ではCopyTabTitleUrlアドオンを利用する。
    ;https://addons.mozilla.org/ja/firefox/addon/copytabtitleurl/
    ;ALT + C で URL のみをクリップボードにコピーできるように設定しておく。
    
    ;Chrome の設定ページなどChrome 拡張がコピペしてくれない URL があるので警告メッセージを設定しておく。
    Clipboard := "URL の取得に失敗しました。"
    Send,!c
    ;複数タブの URL をコピーできるタイプのエクステンションは改行コードを含むことがあるので削除しておく。
    Clipboard := cutcrlf(Clipboard)
    return Clipboard
}
