#Requires AutoHotkey v2.0
#SingleInstance Force




;SendMode Input
;SetWorkingDir, %A_ScriptDir%

;A_Clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.

;#IfWinActive,ahk_exe Steam.exe 


;===============================[quote]==========================
$^q::
{
  A_Clipboard := "" 
  Send "^c"
  ;Errorlevel := !ClipWait()
  ClipWait 
  A_Clipboard := ("[quote] " . A_Clipboard . " [/quote]")
  ;MsgBox "Control-C copied the following contents to the clipboard:`n`n" A_Clipboard
  Sleep(100)
  Send "^v"
  return
} 



;================================[bold]============================
/*
;[b]""[/b] alt+b  
 ^b::
 { 
   Send("^c")
   ;Errorlevel := !ClipWait()
  ClipWait
   clipboard := "[b]`" " . A_Clipboard . " `"[/b]"
   Sleep(10)
   Send("^v")
   return
 } ;
*/

;[b][/b] Ctrl+b  
^b::
{
A_Clipboard := ""  
Send "^c"
  if !ClipWait(00.1)
    {  
      ;;; if dos NOT have have text


      ;MsgBox "The attempt to copy text onto the clipboard failed."
      ;MsgBox "Control-C copied the following contents to the clipboard:`n`n" A_Clipboard
      Send("{shift Down}^{Left}{shift Up}") 
      Sleep(100)
      Send "^c"
      ;clean space
      ;A_Clipboard := RegExMatch(A_Clipboard, "\s") ? RegExReplace(A_Clipboard, "\s") : SubStr(A_Clipboard, 2)
      ;SendInput "[b]" . A_Clipboard . "[/b]"
      clipwait 
      A_Clipboard := StrReplace(A_Clipboard, "`r`n") ;remove new line *it works
      ;MsgBox "Control-C copied the following contents to the clipboard:`n`n" A_Clipboard
      SendInput "[b]" A_Clipboard "[/b]" 
		   return 
    } 

;;; if dos slection have have text

;Errorlevel := !ClipWait()
A_Clipboard := "[b]" A_Clipboard "[/b]"
;Sleep(100)
Send "^v"
return
}


;[b]""[/b] Alt+b
!b::
{
  A_Clipboard := "" 
  Send "^c"
  Errorlevel := !ClipWait()
  A_Clipboard := "[b]`" " . A_Clipboard . " `"[/b]"
  Sleep(100)
  Send "^v"
  return
} 

;================================[Italic]============================

;[i][/i] Ctrl+i  
^i::
{
  A_Clipboard := "" 
  Send "^c"
  
  Errorlevel := !ClipWait()
  A_Clipboard := "[i]"  A_Clipboard  "[/i]"
  Sleep(100)
  Send "^v"
  return
} 


;[i]""[/i] Alt+i
!i::
{
  A_Clipboard := "" 
  Send "^c"
  Errorlevel := !ClipWait()
  A_Clipboard := "[i]`" " . A_Clipboard . " `"[/i]"
  Sleep(100)
  Send "^v"
  return
} 



;================================[spoiler]============================

;[s][/s] Ctrl+s  
^s::
{
  A_Clipboard := "" 
  Send "^c"
  Errorlevel := !ClipWait()
  A_Clipboard := "[spoiler]"  A_Clipboard  "[/spoiler]"
  Sleep(100)
  Send "^v"
  return
} 

;================================[horizontal rule]============================

;[hr][/hr] Ctrl+h  
^h:: SendInput ("[hr][/hr]")


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
;!c::Send("[code]  [/code]")
;^e::Send("[code]  [/code]")

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


!c::
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


;================================[]============================