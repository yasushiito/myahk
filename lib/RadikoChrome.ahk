;functionキーの1から10で Radiko のウェブページを開く。
;第一引数ch:functionキーの番号を数字で指定。
;第2引数channelstr:放送局のリストをカンマ区切りの文字列で指定する。
;第三引数workurl: radiko の Web ページを開くブラウザ

RadikoChrome(ch, channelstr, workurl){
    if (ch < 1 or ch > 10)
    {
        MsgBox, functionキーの番号が有効ではありません。(%ch%)
        return
    }
    ;放送局リストカンマ区切りで分解す。
    StringSplit, channels, channelstr, `,
    StringTrimLeft, channel,channels%ch%, 0
    ;放送局名を使って Radiko のライブページを開く。
    url := "http://radiko.jp/#!/live/" . channel
    OpenWork(url, workurl)

    ;ライブページの再生ボタンのサンプル画像ファイル名を用意する。
    btnplay := "images\radikoplay.bmp"
    Sleep 1000
    ;ボタンを探してクリック。
;    r := ClickButton(btnplay)
    ;連打防止のためクリック成功失敗に関わらず3秒間停止。
;    Sleep 3000
    return
}
