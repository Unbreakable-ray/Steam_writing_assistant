;#IfWinActive, %YourEmailTitle% ;change this. makes the following hotkey only work when this window is active
^!t::                   ;Ctrl+alt+t

oldClip := clipboard    ;save your current clipboard data to a variable to set it back later
clipboard =             ;clear the clipboard
Send, ^c{left}        ;select all, copy and remove selection
ClipWait, 1             ;wait up to one second for the clipboard to contain text
VarForClip := clipboard ;assign a variable to the current clipboard contents
clipboard := oldclip    ;reset the clipboard to what you had before

MsgBox, %VarForClip%

return