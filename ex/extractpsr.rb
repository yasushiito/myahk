if readlines.to_s =~ /(\w*)\.mht/
    fn = Regexp.last_match[0]
    ahkexe = '"C:\Program Files\autohotkey\autohotkey.exe"'
    extractpsr = '%USERPROFILE%\documents\autohotkey\ex\extractpsr.ahk'
    cmd = ahkexe + ' ' + extractpsr + ' ' + fn
    system(cmd)
end
