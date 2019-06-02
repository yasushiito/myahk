gimpexe = '"C:\Program Files\GIMP 2\bin\gimp-2.10.exe"'
jpegdir = 'c:/temp/psr'
jpegfiles = Dir.glob(File.join(jpegdir, '*.jpeg')).join(' ')

if !jpegfiles.empty?
    jpegfileswin = jpegfiles.gsub('/', '\\')
    cmd = 'start /b cmd /c '+ gimpexe + ' ' + jpegfileswin
    system(cmd)
end
