setup_path = %1%

Run, %setup_path%
WinWait, Macrium Reflect Installer
h := WinExist()
ControlSend,, {Enter}, ahk_id %h%

WinWait, Macrium Reflect Free Edition
BlockInput on
WinActivate
    Send, {Enter}
    
    WinWait,, License Agreement
    Send, !a
    Send, {Enter}
    
    WinWait,, License key
    Send, {Enter}

    WinWait,, Register your free copy
    Send, {Down}
    Send, {Enter}
    
    WinWait,, Click on the icons in the tree below
    Send, {Enter}

    WinWait,, begin the installation
    Send, {Enter}
BlockInput off

WinWait, Macrium Reflect Free Edition, &Finish
WinActivate
Send, {ESC}