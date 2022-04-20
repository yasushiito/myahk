;Markdown 形式の文字列から URL を抜き出す。

geturlfrommd(markdown){
    ;URL の文字列の末尾に()で挟まれているとする。
    ;正規表現では()を使うと 合致した内容を変数で取得できる。
    pos := RegExMatch(markdown, "\((http|https)(.*)\)$", str)
    if pos > 0
    {
        ;受け取る変数strの中にはマッチした内容全体が入っている。
        ;str1, str2 の中には()で囲まれた中の正規表現に一致した文字列が入る。
        ;str1には http 又は https が、 str2にはそれ以降の URL がマッチしている。
        ;両者を結合すれば正確な URL となる。
        url := str1 . str2
        return url
    }
    ;Markdown ぽくなかったらそのまま返す。
    return markdown
}
