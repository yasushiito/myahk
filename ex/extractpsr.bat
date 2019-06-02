"C:\Program Files (x86)\7-Zip\7z.exe" x \temp\psr\psr.zip  -o\temp\psr\ -y
"C:\Program Files (x86)\7-Zip\7z.exe" l \temp\psr\psr.zip | ruby "%USERPROFILE%\documents\autohotkey\ex\extractpsr.rb"
