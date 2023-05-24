;#SingleInstance, Force
;SendMode Input
;SetWorkingDir, %A_ScriptDir%

;A_Clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.

;#IfWinActive,ahk_exe Steam.exe 
;===============================[quote]==========================
^q::
{
Send("^c")
Errorlevel := !ClipWait()
A_Clipboard := "[quote] " . A_Clipboard . " [/quote]"
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

;[/b] ctrl+b  
$^b::
{
  Send("^c")
  Errorlevel := !ClipWait() 
  A_Clipboard := "[b] " . A_Clipboard . " [/b]"
  Sleep(100)
  ;Send("^v")
  Send "{Ctrl Down}v"
  return
} 




