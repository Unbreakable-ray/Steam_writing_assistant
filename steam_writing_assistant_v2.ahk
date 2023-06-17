;@xmaxray @unbreakable-ray 

#Requires AutoHotkey v2.0
#SingleInstance Force
;#HotIf WinActive("ahk_exe Steam.exe")
#HotIf WinActive("ahk_exe steamwebhelper.exe") || WinActive("ahk_exe notepad++.exe") ;|| WinActivate("Steam")
;===============================[start the engine]==========================
smartNavigation := 1 ;For Smart navigation  
modClipbord_God := "" ;clipboread work
modClipbord_Backup := ""
fileSengture := "Not ready"




;for singture function
if FileExist(A_MyDocuments . "\SWA.txt") ;is if file singture exit
    {
    signature := FileRead(A_MyDocuments . "\SWA.txt",  "UTF-8") ;sinugture
    ;MsgBox("file signature exit and loaded") ;for test
    fileSengture := "File is loaded" ;debug
    }
else ;create new sengture file 
    {
        FileAppend "
        (
        )", A_MyDocuments "\SWA.txt" , "UTF-8"
        fileSengture := "new file created"


    }

;===============================classes
class WebRequest
            {
                    __New() {
                        this.whr := ComObject('WinHttp.WinHttpRequest.5.1')
                    }

                    __Delete() {
                        this.whr := ''
                    }

                    Fetch(url, method := 'GET', HeadersMap := '', body := '', getRawData := false) {
                        this.whr.Open(method, url, true)
                        for name, value in HeadersMap
                            this.whr.SetRequestHeader(name, value)
                        this.error := ''
                        this.whr.Send(body)
                        this.whr.WaitForResponse()
                        status := this.whr.status
                        if (status != 200)
                            this.error := 'HttpRequest error, status: ' . status . ' — ' . this.whr.StatusText
                        SafeArray := this.whr.responseBody
                        pData := NumGet(ComObjValue(SafeArray) + 8 + A_PtrSize, 'Ptr')
                        length := SafeArray.MaxIndex() + 1
                        if !getRawData
                            res := StrGet(pData, length, 'UTF-8')
                        else {
                            outData := Buffer(length, 0)
                            DllCall('RtlMoveMemory', 'Ptr', outData, 'Ptr', pData, 'Ptr', length)
                            res := outData
                        }
                        return res
                    }
            }
;===============================[Temp engine]==========================
;/*

;notepad ++ for testing
note :=1 ;for note ;temp
#n::
{
    global note  

    If (note=1)
        {
            Run "C:\Program Files (x86)\Notepad++\notepad++.exe"
            WinMaximize "ahk_exe notepad++.exe"
            note := 2
            return
        }
    if (note = 2)
        {
            WinMinimize "ahk_exe notepad++.exe" 
            note := 1
            return
        }
        return

    }

;*/
;===============================[Debug]==========================
;remove and add to display or allow it(;)
+F1:: MsgBox "Navigation mode is     [ " . smartNavigation . " ].", ("Debug window = Navigation" ), "Iconi" ;cheak navigation mode
+F2:: MsgBox "modClipbord_God contains:    [" . modClipbord_God . "] `n `n A-Clipboard contains:    [" . A_Clipboard . "]", ("Debug window = Navigation" ), "Iconi" ;cheak navigation mode
+F3:: MsgBox "Signature status: [" . fileSengture . "]"


msgInfo_god := "Navigation mode is     [ " . smartNavigation . " ]. `n`n modClipbord_God contains:    [" . modClipbord_God . "] `n`n Clipboard contains (A_Clipboard):    [" . A_Clipboard . "] `n`n Signature status: [" . fileSengture . "] `n `n modClipbord_Backup contains:    [" . modClipbord_Backup . "] ."
MSGINFOTEST := "Navigation mode is     [ " . smartNavigation . " ]."
;$F4:: MsgBox ( msgInfo_god) , ("Debug window = God mode" ) ;;bug
$F4:: MsgBox "Navigation mode is     [ " . smartNavigation . " ]. `n`n modClipbord_God contains:    [" . modClipbord_God . "] `n`n Clipboard contains (A_Clipboard):    [" . A_Clipboard . "] `n`n Signature status: [" . fileSengture . "] `n `n modClipbord_Backup contains:    [" . modClipbord_Backup . "] ." , ("Debug window = God mode" )

/*
;;varable
msgInfo_smartNavigation := "Navigation mode is     [ " . smartNavigation . " ]."
msgInfo_modClipbord_God :="modClipbord_God contains:    [" . modClipbord_God . "] ."
msgInfo_Clipboard := "A-Clipboard contains:    [" . A_Clipboard . "]"
msgInfo_fileSignature := "Signature status: [" . fileSengture . "]"
msgInfo_modClipbord_Backup := "modClipbord_Backup contains:    [" . modClipbord_Backup . "] ."

F4:: MsgBox ("" . msgInfo_smartNavigation . "`n `n" . msgInfo_modClipbord_God . "" )
*/

;===============================[quote]==========================
^q::
{   
    
    A_Clipboard := ""
    Send "^c"
    Send ("{Delete}") ; see if this good?
                    if !ClipWait(0.2,0) ;if there is no text
                        {
                            
                            
                            if (modClipbord_God="")

                                { ;start (see if modClipbord_God empty)
                                
                                    SetTimer ChangeButtonNames, 20 ;timer to change butten naem
                                    Result := MsgBox("There is no slected text `n Add Quote [BB] code?", ("Error: No text found" ), "YNC Iconi Default3 0x40000")
                                    
                                    if (Result = "Yes")
                                            {
                                                
                                                ;Send("[quote][/quote]") disabled: too slow
                                                A_Clipboard := ("[quote] [/quote]")
                                                Sleep(50)
                                                Send "^v"
                                                Send("{Left 8}")
                                                return
                                                
                                            }
                                            if (Result = "No")
                                                {
                                                    
                                                    global modClipbord_Backup
                                                    A_Clipboard := (modClipbord_Backup)
                                                    Send "^v"
                                                    return
                                                    
                                                }
                                        
                                        
                                        if (Result ="Cancel")
                                        
                                            {
                                                Sleep(10)
                                                return
                                                
                                            }
                                        
                                                    
                                                            
                                            ChangeButtonNames() ;change bttens names
                                            {
                                                if !WinExist("Error: No text found")
                                                    return  ; Keep waiting.
                                                SetTimer , 0
                                                WinActivate
                                                ControlSetText "&Yes", "Button1"
                                                ControlSetText "&Last quoted", "Button2"
                                            
                                            }
                                            return
                                } ;end (see if modClipbord_God empty)
                            else ;if modClipbord_God has stumodClipbord_Backup
                                {
                                    ;MsgBox "modClipbord_God is full"
                                    A_Clipboard := modClipbord_God
                                    Send ("^v")
                                global modClipbord_Backup := modClipbord_God
                                    modClipbord_God := ""
                                    return
                                }    
                            return





                            
                            
                        }
    ;modClipbord_God := ""
    ;if text found
        global modClipbord_God := ("[quote]" . A_Clipboard . "[/quote]")
        global modClipbord_Backup := modClipbord_God
        A_Clipboard := modClipbord_God
     ;Send "^v"
     return
}




;================================      ==============================
;================================[bold]============================
;================================       ============================




^b::
               {
    global smartNavigation
    A_Clipboard := "" 
    Send "^c"  
    if !ClipWait(0.1)
        { ;bold by send keybored
    Send '{Blind}+{Left}'
    Send "^c"
    if !ClipWait(0.1) ;no text
                                {
                                    send ("[b][/b]")
                                    send ("{Left 4}")
                                    global smartNavigation :=2 ;for Smart navigation
                                    return
                                }
        modClipbord_God := ""  
        modClipbord_God := A_Clipboard
        modClipbord_God := StrReplace(A_Clipboard, A_Space, "") ;remove space
        modClipbord_God := StrReplace(A_Clipboard, "`r`n", "") ;remove new lines
        
        
                                if (modClipbord_God = "]") 
                                {
                                  Send ("{Delete}")
                                  Sleep(10)
                                  ;Send ("][b][/b]") too slow
                                  A_Clipboard :=("][b][/b]")
                                  Send  "^v"
                                  Sleep(10)
                                  Send ("{Left 4}")
                                  global smartNavigation := 2 ;for Smart navigation
                                  return
                                } 
                    
                            
                                else 
                                    {
                                    
                                    ;Send ("[b]" modClipbord_God "[/b]")  too slow
                                    A_Clipboard := ("[b]" modClipbord_God "[/b]")
                                    Send "^v"
                                    global smartNavigation := 4 ;for Smart navigation
                                    return

                                    }    

                    
                    return
                    
                } ;end of bold by keybored
                
                
                ;blod by [mouse]
                global modClipbord_God := ""  
                global modClipbord_God := A_Clipboard
                global modClipbord_God := StrReplace(A_Clipboard, A_Space, "") ;remove space
                global modClipbord_God := StrReplace(A_Clipboard, "`r`n", "") ;remove new lines   modClipbord_God:= A_Clipboard
                global modClipbord_God :="[b]" . A_Clipboard . "[/b]"
                A_Clipboard := modClipbord_God
                Send "^v"
                



               }


;================================[horizontal rule]============================

;[hr][/hr] Ctrl+h  
^h:: 
^r::
{ 
    SendInput ("[hr][/hr]")
    Send ("{Enter}")
 }
;================================[spoiler]======================================

;[s][/s] Ctrl+s  
^s::
{
    modClipbord_God := ""
    A_Clipboard := "" 
    Send "^c"
    Sleep(50)
    global modClipbord_God := ("[spoiler]" A_Clipboard "[/spoiler]")
    A_Clipboard := modClipbord_God
    Send "^v"
    return
} 
;================================[Bulleted list]============================
^3::
{ 
SendInput
(
"
[list]
[*]
[/list]
"
)

Send("{Up 2}")
Send("{Right  3}")

return
} 

;================================[order list]============================
^4::
{ 
SendInput
(
"
[olist]
[*]
[/olist]
"
)

Send("{Up 2}")
Send("{Right  3}")
return
} 

;================================[one slot list]============================
^1::
{ 
Sleep(50)
Send("{Enter}")
SendInput("[*]")
return
}
;================================[code]============================
;code -> Alt+c / Ctrl+e
!c::
^e::
{
SendInput
(
"
[code]  

[/code]
"
)
send ("{Up 2}")
}

;================================[navitaction]============================


^Down:: 
{
    Send "^{End}"
}

;================================[Smart navigation]============================
;defult number is 1
^Space::
 {
            global smartNavigation

            
            if ( smartNavigation=1)
                {
                    Send "^{End}"
                    return
                }
                    
            else if (smartNavigation=2)
                {
                    Send ("{Right 4}")
                    SendInput (" ")
                    global smartNavigation :=1
                    return
                }

                else if (smartNavigation=3)
                    {
                        Send "{Right}{Space}"
                        global smartNavigation :=1
                        return
                    }
                else if (smartNavigation=4)
                    {
                    Send "{Left 4}"
                    SendInput " "
                    global smartNavigation := 1
                    return
                   }

               return 
 }
        


;================================[Smart dublcate]============================
":: ;""
{
    Send ('""')
    Send ("{Left}")
    global smartNavigation := 3
    return

}

$}:: ;{}
${::
{
    Send ("{Raw}{}")
    Send ("{Left}")
    global smartNavigation := 3
    return

}

$]::
$[::
    {
        Send ("{Raw}[]")
        Send ("{Left}")
        global smartNavigation := 3
        return
    
    }
;================================[signature]============================
F1::
{
A_Clipboard :=  signature
Send "^v"
;MsgBox  StrGet((FileRead(A_MyDocuments . "\SWA.txt",  "UTF-16-RAW")), "UTF-16")
;MsgBox  (FileRead(A_MyDocuments . "\SWA.txt",  "UTF-8"))
return
}


F5:: 
{
    global signature := FileRead(A_MyDocuments . "\SWA.txt" ,"UTF-8") ;update
}

+F5::
{
    
   Run 'notepad.exe ' A_MyDocuments . "\SWA.txt"
   WinWait("ahk_exe notepad.exe")
   SetTimer cheakNotepadExit, 20
   
   
   
   cheakNotepadExit()
    {
        if WinExist("ahk_class Notepad") 
            {
                ;restart
                return
            }
        
                        
        else
            {
            ;Sleep(200)
            global signature := FileRead(A_MyDocuments . "\SWA.txt", "UTF-8") ;update
            SetTimer ,0
            fileSengture := "internal-edited and loaded"
            MsgBox  "Info: New signature louded", ("Steam writing assistant"), "0x40000 Iconi"
            }
            
    }
      
        
    }



    ;Run A_MyDocuments . "\SWA.txt"
    ;WinWait("ahk_exe notepad.exe")




;================================[Auto lower case]============================


$f10::
{
    A_Clipboard := ""
    ;Send "^c" ;dosn't work with f10
   Send("{ctrl Down}c{ctrl Up}")    
    if !ClipWait(0.1)
        {
            Msgbox "no text"
        }
    modClipbord_God := (StrLower(A_Clipboard)) 
    A_Clipboard := (modClipbord_God)
    Send("{ctrl Down}v{ctrl Up}")   
    modClipbord_Backup_for_devs := A_Clipboard
    A_Clipboard := ""
}
;================================[Auto-translate]============================ temp
f3:: 
{
    A_Clipboard := ""
    Send "^c"
    if !ClipWait(0.2,0) ;if there is no text
        {
           MsgBox "Please select the text", "No selected text found"
           return
        }
    text := GoogleTranslate(A_Clipboard , &from := 'auto')
    MsgBox 'from: ' . from . '`ntranslate: ' . text, 'from auto to English'



    GoogleTranslate(str, from := 'auto', to := 'en', &variants := '') {
        static JS := ObjBindMethod(GetJsObject(), 'eval'), _ := JS(GetJScript())
        
        json := SendRequest(str, Type(from) = 'VarRef' ? %from% : from, to)
        return ExtractTranslation(json, from, &variants)

        GetJsObject() {
            static document := '', JS
            if !document {
                document := ComObject('HTMLFILE')
                document.write('<meta http-equiv="X-UA-Compatible" content="IE=9">')
                JS := document.parentWindow
                (document.documentMode < 9 && JS.execScript())
            }
            return JS
        }

        GetJScript() {
            return '
            ( Join
                var TKK="406398.2087938574";function b(r,_){for(var t=0;t<_.length-2;t+=3){var $=_.charAt(t+2),$="a"<=$?$
                .charCodeAt(0)-87:Number($),$="+"==_.charAt(t+1)?r>>>$:r<<$;r="+"==_.charAt(t)?r+$&4294967295:r^$}return r}
                function tk(r){for(var _=TKK.split("."),t=Number(_[0])||0,$=[],a=0,h=0;h<r.length;h++){var n=r.charCodeAt(h);
                128>n?$[a++]=n:(2048>n?$[a++]=n>>6|192:(55296==(64512&n)&&h+1<r.length&&56320==(64512&r.charCodeAt(h+1))?
                (n=65536+((1023&n)<<10)+(1023&r.charCodeAt(++h)),$[a++]=n>>18|240,$[a++]=n>>12&63|128):$[a++]=n>>12|224,$
                [a++]=n>>6&63|128),$[a++]=63&n|128)}for(a=0,r=t;a<$.length;a++)r+=$[a],r=b(r,"+-a^+6");return r=b(r,
                "+-3^+b+-f"),0>(r^=Number(_[1])||0)&&(r=(2147483647&r)+2147483648),(r%=1e6).toString()+"."+(r^t)}
            )'
        }

        SendRequest(str, sl, tl) {
            static WR := ''
                , headers := Map('Content-Type', 'application/x-www-form-urlencoded;charset=utf-8',
                                'User-Agent'  , 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0')
            if (!WR)
                {
                WR := WebRequest()
                WR.Fetch('https://translate.google.com',, headers)
                    }
            url := 'https://translate.googleapis.com/translate_a/single?client=gtx'
                . '&sl=' . sl . '&tl=' . tl . '&hl=' . tl
                . '&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&ie=UTF-8&oe=UTF-8&otf=0&ssel=0&tsel=0&pc=1&kc=1'
                . '&tk=' . JS('tk')(str)
            return WR.Fetch(url, 'POST', headers, 'q=' . JS('encodeURIComponent')(str))
        }

        ExtractTranslation(json, from, &variants) {
            jsObj := JS('(' . json . ')')
            if !IsObject(jsObj.1) {
                Loop jsObj.0.length {
                    variants .= jsObj.0.%A_Index - 1%.0
                }
            } else {
                mainTrans := jsObj.0.0.0
                Loop jsObj.1.length {
                    variants .= '`n+'
                    obj := jsObj.1.%A_Index - 1%.1
                    Loop obj.length {
                        txt := obj.%A_Index - 1%
                        variants .= (mainTrans = txt ? '' : '`n' . txt)
                    }
                }
            }
            if !IsObject(jsObj.1)
                mainTrans := variants := Trim(variants, ',+`n ')
            else
                variants := mainTrans . '`n+`n' . Trim(variants, ',+`n ')

            (Type(from) = 'VarRef' && %from% := jsObj.8.3.0)
            return mainTrans
        }
    }

    
}


;https://www.autohotkey.com/boards/viewtopic.php?t=63835




;================================[]============================