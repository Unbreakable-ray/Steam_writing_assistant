;@xmaxray @unbreakable-ray 

#Requires AutoHotkey v2.0
#SingleInstance Force
;#IfWinActive,ahk_exe Steam.exe 

;===============================[start the engine]==========================
aa := 1 ;For Smart navitcation




;===============================[quote]==========================

^q::
{   
    gg := ""
    A_Clipboard := "" 
    Send "^c"
    Sleep(50)
    gg := ("[quote]" A_Clipboard "[/quote]")
    A_Clipboard := gg
    Send "^v"
    return
}
;================================[bold]============================
^b::
               {
    A_Clipboard := "" 
    Send '{Blind}+{Left}'
    Send "^c"
    if !ClipWait(0.1)
                                {
                                    send ("[b][/b]")
                                    send ("{Left 5}")
                                    global aa :=2
                                    return
                                }
        gg := ""  
        gg := A_Clipboard

                    
                                if (gg = "]") 
                                {
                                  Send ("^ {End}")
                                  Sleep(10)
                                  Send ("[b] [/b]")
                                  Sleep(10)
                                  Send ("{Left 5}")
                                  return
                                } 
                    
                            
                                else 
                                    {
                                    Send ("[b]" gg "[/b]") 
                                    return
                                    }    

                    
                    
                    
                }


;================================[horizontal rule]============================

;[hr][/hr] Ctrl+h  
^h:: 
^r:: SendInput ("[hr][/hr]")
;================================[spoiler]======================================

;[s][/s] Ctrl+s  
^s::
{
    gg := ""
    A_Clipboard := "" 
    Send "^c"
    Sleep(50)
    gg := ("[spoiler]" A_Clipboard "[/spoiler]")
    A_Clipboard := gg
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

;================================[Smart navitcation]============================
;defult number is 1
^Space:: 
        {
            global  
            if ( aa=1)
                {
                    Send "^{End}"
                                        return
                }
                    
            else if (aa=2)
                {
                    Send ("{Right 3}{Space}")
                    global aa :=1
                    return
                }

                else if (aa=3)
                    {
                      
                    }
                
        }
        


;================================[]============================