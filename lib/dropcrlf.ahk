dropcrlf(str){
    str := RegExReplace(str, "\n", "")
    str := RegExReplace(str, "\r", "")
    return str
}
