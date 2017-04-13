; Parameters:
;   Path to agent
;   Type of trial install - Free, Home, Workstation, Server, ServerPlus
; 

exe_path   = %1%
setup_dir  = %2%
trial_type = %3%

if (!trial_type)
    trial_type := "Free"

Run, %exe_path%

WinWait, Macrium Reflect Download Agent
hwnd := WinExist()

; Select installation package
ControlClick, Button2, ahk_id %hwnd%
Control, ChooseString, %trial_type%, ComboBox1, ahk_id %hwnd%

; Download Location and Options
ControlSetText, Edit2, %setup_dir%, ahk_id %hwnd%
ControlClick, Button6, ahk_id %hwnd%

; Download
Sleep 3000
ControlClick, Button10, ahk_id %hwnd%
loop {
    IfWinExist, ,The Macrium Reflect download agent is retrieving the download option list ahk_id %hwnd%
    {
        WinActivate
        Send, {Enter}
    }
    else break
    Sleep 1000
}

Sleep 1000
IfWinExist,,&Yes
{
    WinActivate
    Send, {ENTER}
}

loop {
    Sleep 1000
    IfWinExist,, Click to view log file
    {
        WinActivate
        Send, {ENTER}
        ControlSend,,{ESC}, ahk_id %hwnd% 
        break
    }
}

; =============================================================================================
; This code is not used but could be eventually enabled to set Options, such as no PE

;; Set Options

;loop {
;    Sleep 1000
;    ControlClick, Button7, ahk_id %hwnd%
;    ControlSend, Button7, {Enter}, ahk_id %hwnd%
;    
;    Sleep 500
;    IfWinExist, , The Macrium Reflect download agent is retrieving the download option list 
;        Send, {Enter}
;    else break
;}

;IfWinNotExist, Set Download Options 
;{
;    Msgbox Can't set Macrium install options. Aborting.
;    Return
;}
;hwnd2 = WinExist()

;; "Reflect Installer Only"
; Send, {TAB}{DOWN}, ahk_id %hwnd2%