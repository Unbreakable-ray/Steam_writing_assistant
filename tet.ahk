#Requires AutoHotkey v2.0
#SingleInstance Force

^b::
{
	A_Clipboard := ""        ; Empties the clipboard
	Send "^c"                ;copies the current selection into the clipboard
	if !ClipWait(1)
	{
		MsgBox "The attempt to copy text onto the clipboard failed."
		return
	}
	/*
		Waits a maximum of 2 seconds until the clipboard contains data.
		If ClipWait times out, an error message is shown
	*/
	A_Clipboard := "[b]" A_Clipboard "[/b]"
	Send "^v"
	return
}