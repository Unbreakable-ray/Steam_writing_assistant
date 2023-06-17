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








;================================[Auto tybe fix]============================
::im::I'm
::hes::he's
::Hes::He's
::shes::she's
::Shes::She's
::i::I
