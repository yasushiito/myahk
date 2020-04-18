;画像認識で使用する画像のサンプルデータをテキスト化したものを返す。
;ロジックは極力編集したくないのでデータだけ別ファイルに分離した形。
;認識したい画像はたくさんあるので、関数化した。
;必要なサンプルデータをキーで取り出す。
;第一引数:必要な画像のキー。

FindTextImages(key){
    o := Object()
    o["btnplay"] := "|<>*190$60.zzzzzzzzzzzzzzzzzkzzk0000zUkzzk0000zUkzzk0000z1kzzzzUzzz1kzzzzUzzy0003w0007y0003w0007w0003w0007s0003w7Uy7k7kzzw7Uy7sDkzzw0007wTkzzw0007zzkzzw0007w0003w7Uy7w0003w7Uy7w0003U0000w0003U0000zzkzzU0000zzkzzw7zy7zzkzzw7zy7zzkzzw7zy7zzkzzw7z07k0001U"
    o["btnshare"] := "|<>*142$57.00010E00010008O0000M00Dqk0zk27zU8a001kE0018zU002003zg8000E001VV1zy2000MAM00Uk007wH00M60011WE060kk0EMG030640061k0y0lU00yA0AM2A03w1U630FU00US1UM260046Ms10ETw0X1Y0Du000wk4000U"
    o["stop"] := "|<>*189$59.y7w7zzzzzzsDsDzzz1zzk0007zy3zzU000Dzw7zz0000TzsDzw7zzzzzkTzsQ007y7Uzzks00DwD1zz1kzsTsS00S3U00zkw00s7001zVs01kDzzzz3k030E001y7Uzy0U003wD1zw13zy7sS3zw27zwDkw7zy4000TVsDzwC003z3kTzsQ007y7UzzkzsDzwD1zzVzkTzsS3zz3zUzzkw7zs"
    o["twittericon"] := "|<>*195$29.zzy1zTzs06TzU0ATz00MDw00k7s03k1k0DU000S0000w0001s0003s0007s000Ts000zU003z0007zU00Tzk01zzk07zy00Tz001zw00Dzz03zzk"
    o["tweet"] := "|<>*188$67.zzzzzbzzzsTzbzzzVzzzwDtVszzVzzzy7sMwTzVzzzz3yACDzVzzzzVz377zVzzzzkDlX3z1zzzzs1sEXy0zU01wECAls0Tk00yD7Dks6Dzzzz7nzkwT7zzzzXzzkzzXzzzzlzzUzzlzzzzszy0zzszzzzwTy1zzwTzzzyDz3zzyDzzzz7y"
    o["closex"] := "|<>*186$25.0zzU0DzU83zUC0zUDUDUDs3UDy00DzU0Dzs0Dzy0Dzz07zzU3zzU0zzU0DzU03zUC0zUDUDUDs3UDy0UDzU0Dzs0Dzy2DzzX"
    o["tsok"] := "|<>*181$45.zU7zUTk7k0Dw3y1s00TUTUS0w1w3s7kDkDUS1w3z0w3UDUzw7UQ3s7zUQ30z0zw3UEDs7zUQ03z0zw3U0zs7zUQ03z0zw3U0Ds7zUQ01z0zw3U07s7zUQ30TUzw7UQ1w3z0w3kDkDkDUS0y0w1w3s3s00TUTUDk0Dw3y0zU7zUTs4"
    Return o[key]
}
