getfirefoxurl(){
    ; アドオンcopytabtitleurlのキーボードショートカットで URL を取得。
    ; https://addons.mozilla.org/ja/firefox/addon/copytabtitleurl/
    Send,!c
    Sleep 100
    return Clipboard
}
