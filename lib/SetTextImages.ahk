;画像認識で使用する画像のサンプルデータをテキスト化したものを返す。
;ロジックは極力編集したくないのでデータだけ別ファイルに分離した形。
;認識したい画像はたくさんあるので、関数化した。
;必要なサンプルデータをキーで取り出す。
;第一引数:必要な画像のキー。

SetTextImages(){
    global TextImages
    ;Radiko ホームページ。

    ;再生するボタン。
    TextImages["RadikoPlay"] := "|<>*189$58.zzzzzzz1zy0000DwA7zs0000zUkTzU0003y31zzzw7zzkQ7zzzkTzz0001s000Ds0007U000z0000S0003w0001sT1sDUT1zzVw7Uy3w7zy0003yTkTzs000Dzz1zzU000zU000y7kS3y0003sT1sDs000A00007U000k0000TzkTz00001zz1zzVzzUzzw7zy7zy3zzkTzsTzsDzz1zzVzs0w0000C7zU3k0000sTy0D00003Vzs1w0000DzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU"
    ;友達に教えるボタン。
    TextImages["RadikoShare"] := "|<>*148$39.0001U81U00A/0800DvM17zUAm0M001gzn003zqAM000llW000A+8E003yF2001UnMEE0E8/260061kEU00z62403y1kMU00kO3600668MDy0lVV000QE6U"
    ;停止するボタン。
    TextImages["RadikoStop"] := "|<>*188$59.y3y7zzzkTzw0001zzUzzs0003zz1zzU0007zy3zz3zzzzzw7zy6001z1sDzsA003y3kTzkMTy7w7U07Uk00DsD00C1U00TkS00Q3zzzzUw00k4000T1sDzU8000y3kTz0FzzVw7Uzz0Xzz3sD1zzV0007kS3zz3000zUw7zy6001z1sDzwDy3zy3kTzsTw7zw7UzzkzsDzsD1zzVw0Tw0000D3s0zs0000S7s3zk0000wDkDzU0001"
    ;Twitter でシェアするボタン。
    TextImages["RadikoTwitterIcon"] := "|<>*195$28.zzy3zzzk2Nzy013zk047z0087w03U7k0D0000w00030000S0001s0007k000TU003y000Ds001zk007zU00zzU07zy00zzU07zU01zy"
    ;Twitter ポップアップのtweetボタン。
    TextImages["RadikoTweet"] := "|<>*186$55.zzXzzzy7zzzkzzzz3zzzkzzzzVzzzkzzzzkzzzkzzzzsTzzUzzzzw1zz0zzzzy0Dy0Tzzzz21s0Ds00DVk827w007ky2D3zzzzsTnzVzzzzwDzzkzzzzy7zzsTzzzz3zzwDzzzzVzzy7zzzzkzzz3zzzzsTz"
    ;友達に教えるウィンドウを閉じるボタン。
    TextImages["RadikoCloseX"] := "|<>*187$26.VzzssDzw61zy1UDz0Q1zUDUDk7w1s3zUA1zw00zzU0Tzw0DzzU7zzs1zzw0Dzy01zz00DzUA1zk7UDs3w1w1zUC0zw1UTzUMDzw67zzXzzzzs"
    ;タイムフリー再生 OK ボタン。
    TextImages["RadikoOk"] := "|<>*181$45.zU7zUTk7k0Dw3y1s00TUTUS0w1w3s7kDkDUS1w3z0w3UDUzw7UQ3s7zUQ30z0zw3UEDs7zUQ03z0zw3U0zs7zUQ03z0zw3U0Ds7zUQ01z0zw3U07s7zUQ30TUzw7UQ1w3z0w3kDkDkDUS0y0w1w3s3s00TUTUDk0Dw3y0zU7zUTs4"
    ;Facebook メッセンジャーのメッセージ入力ボックス。
    TextImages["FBMessangerTextfield"] := "|<>*187$50.0010000A000E0000k0047U003121yE00M6EXkA003UW8427zk4AY110000110EU00000U4000000M100000kM0M0000sM03z001k000000008"
}
