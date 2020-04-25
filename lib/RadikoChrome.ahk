;functionキーの1から10で Radiko のウェブページを開く。
;第一引数ch:functionキーの番号を数字で指定。
;第2引数channelstr:放送局のリストをカンマ区切りの文字列で指定する。
;第三引数workurl: radiko の Web ページを開くブラウザ

RadikoChrome(ch, channelstr, workurl, noclick=False){
    if (ch < 1 or ch > 10)
    {
        MsgBox, functionキーの番号が有効ではありません。(%ch%)
        return
    }
    ;放送局リスト channelstr カンマ区切りで分解す。
    StringSplit, channels, channelstr, `,
    ;チャンネル番号 CH を使って放送局名を取り出す。
    StringTrimLeft, channel,channels%ch%, 0
    ;放送局名を使って Radiko のライブページを開く。
    url := "http://radiko.jp/#!/live/" . channel
    OpenWork(url, workurl)

    ;ページのロードを待つ。
    Sleep 5000


    ;再生ボタンの画像サンプルをテキスト化したデータを取得する。
    btnplay := FindTextImages("RadikoPlay")
    ;ボタンを探してクリック。
    ClickImage(btnplay)
    return
}
