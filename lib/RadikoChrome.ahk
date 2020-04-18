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


    ;ボタンを探してクリック。
    ;再生ボタンなどのクリックしたい部分の画像サンプルをテキスト化したデータを取得する。
    ;操作手順は、再生する、友達に教える、 Twitter アイコン、 Tweet Button、シェア画面を閉じるX。
    btnplay := FindTextImages("btnplay")
    btnshare := FindTextImages("btnshare")
    btntwittericon := FindTextImages("twittericon")
    btntweet := FindTextImages("tweet")
    btnclosex := FindTextImages("closex")
    ;スクリーン全体から再生を探す。
    if (ClickImage(btnplay))
    {
        Sleep 3000
        ClickImage(btnshare)
        Sleep 3000
        ClickImage(btntwittericon)
        Sleep 3000
        ClickImage(btntweet)
        Sleep 3000
        ClickImage(btnclosex)
    }
    return
}
