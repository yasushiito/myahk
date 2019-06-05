del /q c:\temp\psr\*.mht
del /q c:\temp\psr\*.htm
del /q c:\temp\psr\*.css
del /q c:\temp\psr\*.jpeg
"C:\Program Files (x86)\7-Zip\7z.exe" x C:\temp\psr\psr.zip  -oC:\temp\psr\ -y
"C:\Program Files (x86)\7-Zip\7z.exe" l C:\temp\psr\psr.zip | ruby "%USERPROFILE%\documents\autohotkey\ex\extractpsr.rb"
