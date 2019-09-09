; 
detectchrome(){
    global editorurl
    global workurl
    global editor := 0
    global work := 0
    ; 作業ウィンドウ探す。
    detectwork(workurl)
    ; 音声入力ウィンドウ探す。
    detecteditor(editorurl)
}
