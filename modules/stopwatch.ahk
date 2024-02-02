#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;Stopwatch



#NoEnv
#SingleInstance force
SetDefaultMouseSpeed, 70
SetTimer, QuerySettings, -200

; IniRead, AntiAFKStatus, settings.cfg, SETTINGS, AutoAFKHandler,0
; GLOBAL StateAutoAFK := AntiAFKStatus

timerm := "00"
timers := "00"
stopped := "0"

GLOBAL windowstatus := "0"
GLOBAL FirstToggleColdboot := "1"


Gui, Add, CheckBox, vAntiAFKControl gCheckAutoAFK, anti-afk
Gui, Add, CheckBox, x120 y5 vAlwaysOnTopControl gCheckTopmostLevelGUI, Topmost
Gui, Add, Text, x75 y22 w60 h20 vTText, %timerm%:%timers%
; Gui, Add, Button, x2 y42 w80 h20 vPause gButtonToggle, Toggle
Gui, Add, Button, x2 y42 w80 h20 vPause, Toggle
; Gui, Add, Button, x2 y42 w80 h20 vPause, Pause
Gui, Add, Button, x82 y42 w80 h20 vReset, Reset
; Gui, Add, CheckBox, vAntiAFKControl gCheckAutoAFK , -fixed
Gui, Show, h69 w185, Stopwatch
CheckMarkGivenControls()


; Settimer, Stopwatch, 1000
; SetTimer, QuerySettings, -250
SetTimer, QuerySettings, 1800

IniRead, TogglePauseShortcut, settings.cfg, SETTINGS, TogglePauseHotkey, PgUp
IniRead, ResetShortcut, settings.cfg, SETTINGS, ResetHotkey, PgDn
GLOBAL TogglePauseKey := TogglePauseShortcut
GLOBAL ResetKey := ResetShortcut
Hotkey, %TogglePauseKey%, ButtonToggle
Hotkey, %ResetKey%, ButtonReset
Return



Stopwatch:
timers += 1
if(timers > 59)
{
	timerm += 1
	timers := "0"
	GuiControl, , TText ,  %timerm%:%timers%
}
if(timers < 10)
{
	GuiControl, , TText ,  %timerm%:0%timers%
}
else
{
	GuiControl, , TText ,  %timerm%:%timers%
}
return

ButtonToggle:
If(FirstToggleColdboot="1")
{
	Settimer, Stopwatch, -1
	stopped = 0
	Sleep, 50
	stopped = 1
	Settimer, Stopwatch, Off
	GLOBAL FirstToggleColdboot := "0"
}
if(stopped = 0)
{
	Settimer, Stopwatch, off
	stopped = 1
If(StateAutoAFK) = (1)
{
	SetTimer, AntiIDLE, off
	Return
}
}
else
{
	Settimer, Stopwatch, 999
	stopped = 0
If(StateAutoAFK) = (1)
{
	SetTimer, AntiIDLE, %AntiAFKDelayTime%
	Return
}
}
return

ButtonReset:
timerm := "00"
timers := "00"
GuiControl, , TText ,  %timerm%:%timers%
return

GuiClose:
GuiEscape:
ExitApp
return

QuerySettings:
IniRead, AntiAFKStatus, settings.cfg, SETTINGS, AutoAFKHandler,0
IniRead, AntiAFKDelayT, settings.cfg, SETTINGS, AutoAFKDelay,0
IniRead, TopmostGUIPriority, settings.cfg, SETTINGS, StayTopmost,0
IniRead, TogglePauseShortcut, settings.cfg, SETTINGS, TogglePauseHotkey, PgUp
IniRead, ResetShortcut, settings.cfg, SETTINGS, ResetHotkey, PgDn
GLOBAL StateAutoAFK := AntiAFKStatus
GLOBAL AntiAFKDelayTime := AntiAFKDelayT
GLOBAL TopmostGUI := TopmostGUIPriority
GLOBAL TogglePauseKey := TogglePauseShortcut
GLOBAL ResetKey := ResetShortcut
Gui, Submit, NoHide
Return


CheckAutoAFK:
Gui, Submit, NoHide
IniWrite, %AntiAFKControl%, settings.cfg, SETTINGS, AutoAFKHandler
; IniWrite, Value, Filename, Section, Key
Return

CheckTopmostLevelGUI:
GuiControlGet, AlwaysOnTopVar,, AlwaysOnTopControl
Sleep, 50
IniWrite, %AlwaysOnTopVar%, settings.cfg, SETTINGS, StayTopmost
ToggleAlwaysOnTop()
Return

AntiIDLE:
MouseGetPos, CurrentMouseX, CurrentMouseY, CurrentMouseWin
Random, MouseMoveCoordinatesX, 200, 400
Random, MouseMoveCoordinatesY, 100, 400
; MouseMove, %MouseMoveCoordinatesX%, %MouseMoveCoordinatesY%    ;;;;  working (but untested for long term use) interrupt using AHK directly
; run, nircmd.exe setcursor %MouseMoveCoordinatesX% %MouseMoveCoordinatesY%    ;;;;  working nircmd version (to be sure its interrupting the system sleep adequately)
Sleep, 100
MouseMove, %MouseMoveCoordinatesX%, %MouseMoveCoordinatesY%
Sleep, 1000
MouseMove, %CurrentMouseX%, %CurrentMouseY%
; MsgBox,, ANTI-IDLE DEBUG, ANTI-IDLE LABEL FIRED!, 3
Return



CheckMarkGivenControls()
{
IniRead, AntiAFKStatus, settings.cfg, SETTINGS, AutoAFKHandler,0
GLOBAL StateAutoAFK := AntiAFKStatus
IniRead, TopmostGUIPriority, settings.cfg, SETTINGS, StayTopmost,0
GLOBAL TopmostGUI := TopmostGUIPriority
If(StateAutoAFK) = (1)
{
	GuiControl,,AntiAFKControl, 1
	; MsgBox, 11111
}
If(StateAutoAFK) = (0)
{
	GuiControl,,AntiAFKControl, 0
	; MsgBox, 22222
}
If(TopmostGUI="1")
{
	GuiControl,,AlwaysOnTopControl, 1
	ToggleAlwaysOnTop()
}
If(TopmostGUI="0")
{
	GuiControl,,AlwaysOnTopControl, 0
}
Return
}

Return
ToggleAlwaysOnTop()
{
	If (windowstatus = 0) {
	WinSet,AlwaysOnTop,On, Stopwatch
	GLOBAL windowstatus = 1
	} else {
	WinSet,AlwaysOnTop,Off, Stopwatch
	; WinSet,Bottom,, Stopwatch
	GLOBAL windowstatus = 0
	}
}