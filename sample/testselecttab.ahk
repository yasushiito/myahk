    detectchrome()
    if selecttab(work, "ブログ記事編集 - はてなブログ")
        MsgBox, , , blogentry found ,5
    if selecttab(work, "", "https://github.com/")
        MsgBox, , , github found ,5
    if selecttab(work, "Amazon", "www.amazon.co.jp")
        MsgBox, , , amazon found ,5
Return
