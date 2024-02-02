#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

;                         {[
;;           ELEVATE TO ADMIN UAC PROMPT BELOW
; If the script is not elevated, relaunch as administrator and kill current instance:
 
full_command_line := DllCall("GetCommandLine", "str")
 
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try ; leads to having the script re-launching itself as administrator
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}
;
;                          ]}




;;;
;;;
;;;
;;;
;;  DefineMainStrings
;;
GLOBAL CoreConfigFile := A_ScriptDir . "\config_core.cfg"
GLOBAL EngineConfigFile := A_ScriptDir . "\engine.cfg"
GLOBAL AccHandler = "0"
StepCounter := "0"
CurrentStandbyCount := "0"
CurrentHandlerLoopCount := "0"
;;;
;;;
;;;
;;;
;;  DefineAutoExecSection
;;


if FileExist(A_ScriptDir . "\engine.cfg")
{

}
Else
{
FileAppend,, %A_ScriptDir%\engine.cfg
Sleep, 2500
IniWrite 0, %EngineConfigFile%, ENGINE, AutoShutdown
}
;;
;;
;;
;;
;;
;;
;;
;;
;;
;;
if FileExist(CoreConfigFile)
{
	;; If Debugger is turned on, execute debug msg
	;;;
	;;;
	;;; FIRST DEBUGGER BREAKPOINT
	IniRead, EngineDebugState, config_core.cfg, ENGINE_DEBUG, Debugger
	If(EngineDebugState = 1)
	{
    MsgBox, 262144, [D2Overseer], [console]:  The core config file exists., 10
	}
}
Else
{
;;
;;
;;
;;
;;; Ini File not found, begin reconstruction with defined defaults
FileAppend, `n, %CoreConfigFile%
IniWrite 1, %CoreConfigFile%, ENGINE_SWITCHES, Auto_DiabloHandler
IniWrite 0, %CoreConfigFile%, ENGINE_SWITCHES, Auto_AccountSwap
IniWrite 1, %CoreConfigFile%, ENGINE_SWITCHES, Auto_AccountSwapContrlLock
IniWrite 1, %CoreConfigFile%, ENGINE_SWITCHES, Auto_AccSwapUsesSteam
IniWrite 1, %CoreConfigFile%, ENGINE_SWITCHES, Auto_BnetPlayButton
IniWrite 0, %CoreConfigFile%, ENGINE_SWITCHES, Auto_PollData
IniWrite 1, %CoreConfigFile%, ENGINE_TUNING, PromptOnFail
IniWrite 3, %CoreConfigFile%, ENGINE_TUNING, D2HandlerVerbosity
IniWrite 2300, %CoreConfigFile%, ENGINE_TUNING, AutoShutdownTimer
IniWrite 1300, %CoreConfigFile%, ENGINE_TUNING, AutoShutdownTimerB
IniWrite Username, %CoreConfigFile%, ENGINE_CONFIG, AccountLogin01
IniWrite Username2, %CoreConfigFile%, ENGINE_CONFIG, AccountLogin02
IniWrite Password1, %CoreConfigFile%, ENGINE_CONFIG, AccPass01
IniWrite Password2, %CoreConfigFile%, ENGINE_CONFIG, AccPass02
IniWrite Directory01, %CoreConfigFile%, ENGINE_CONFIG, D2Directory01
IniWrite Directory02, %CoreConfigFile%, ENGINE_CONFIG, D2Directory02
IniWrite SteamURL01, %CoreConfigFile%, ENGINE_CONFIG, D2SteamURL1
IniWrite SteamURL02, %CoreConfigFile%, ENGINE_CONFIG, D2SteamURL2
IniWrite 0, %CoreConfigFile%, ENGINE, SystemStandbyState
IniWrite 0, %CoreConfigFile%, ENGINE_DEBUG, Debugger
IniWrite 0, %CoreConfigFile%, ENGINE_DEBUG, SystemStandbyDebug
}


IniRead, EngineStandbyDebug, %CoreConfigFile%, ENGINE_DEBUG, SystemStandbyDebug
IniRead, EngineStandbyStatus, %CoreConfigFile%, ENGINE, SystemStandbyState
IniRead, EngineDisplayPrompts, %CoreConfigFile%, ENGINE_TUNING, PromptOnFail
IniRead, AutoD2HandlerVerbosity, %CoreConfigFile%, ENGINE_TUNING, D2HandlerVerbosity
IniRead, AutoShutdownDelay, %CoreConfigFile%, ENGINE_TUNING, AutoShutdownTimer
IniRead, AutoShutdownDelay2, %CoreConfigFile%, ENGINE_TUNING, AutoShutdownTimerB
IniRead, AutoD2HandlerState, %CoreConfigFile%, ENGINE_SWITCHES, Auto_DiabloHandler
IniRead, AutoAccHandlerState, %CoreConfigFile%, ENGINE_SWITCHES, Auto_AccountSwap
IniRead, AutoAccHandlerLocks, %CoreConfigFile%, ENGINE_SWITCHES, Auto_AccountSwapContrlLock
IniRead, AutoAccHandlerSteam, %CoreConfigFile%, ENGINE_SWITCHES, Auto_AccSwapUsesSteam
IniRead, AutoDataPollState, %CoreConfigFile%, ENGINE_SWITCHES, Auto_PollData
; IniRead, AutoShutdown, %CoreConfigFile%, ENGINE_SWITCHES, AutoShutdownTimer, 1
IniRead, AccLogin1, %CoreConfigFile%, ENGINE_CONFIG, AccountLogin01
IniRead, AccPass1, %CoreConfigFile%, ENGINE_CONFIG, AccPass01
IniRead, AccLogin2, %CoreConfigFile%, ENGINE_CONFIG, AccountLogin02
IniRead, AccPass2, %CoreConfigFile%g, ENGINE_CONFIG, AccPass02
IniRead, EngineDebugState, %CoreConfigFile%, ENGINE_DEBUG, Debugger

GLOBAL HandlerVerbosityLevel := AutoD2HandlerVerbosity
GLOBAL EngineStandbyState := EngineStandbyStatus

; MsgBox, The value is %OutputVar%.

; SetTimer, AutoShutdown, %AutoShutdownDelay%
; SetTimer, AutoShutdownTimer, %AutoShutdownDelay%

SetTimer, AutoShutdownTimer, %AutoShutdownDelay%

MainSub:
	StepCounter++
	; If(AutoShutdown = "1")
	; {

	; }
	;;;;;;________________________________________________________________________;;;;;;
	;;; Main Handler Sub Debug BREAKPOINT 01
	IniRead, EngineDebugState, config_core.cfg, ENGINE_DEBUG, Debugger
	If(EngineDebugState = 1)
	{
    MsgBox, 262144, [D2Overseer], [console]:  Auto D2R Handler Logic Fired.  `n`nCurrent Loop Count: %StepCounter%., 10
	}
		Process,Wait,D2R.exe
		Process,WaitClose,D2R.exe
		Process,Close, battle.net.exe
		Process,Close, battle.net.exe
		Process,Close, battle.net.exe
		Process,Close,Agent.exe
		Process,Close,Agent.exe
		Process,Close,Agent.exe
		;;;;;;________________________________________________________________________;;;;;;
		;; Verify Client Engine settings
		IniRead, EngineDisplayPrompts, %CoreConfigFile%, ENGINE_TUNING, PromptOnFail
		IniRead, AutoD2HandlerVerbosity, %CoreConfigFile%, ENGINE_TUNING, D2HandlerVerbosity
		IniRead, AutoD2HandlerState, %CoreConfigFile%, ENGINE_SWITCHES, Auto_DiabloHandler
		IniRead, AutoAccHandlerState, %CoreConfigFile%, ENGINE_SWITCHES, Auto_AccountSwap
		IniRead, AutoDataPollState, %CoreConfigFile%, ENGINE_SWITCHES, Auto_PollData
		IniRead, AutoAccHandlerSteam, %CoreConfigFile%, ENGINE_SWITCHES, Auto_AccSwapUsesSteam
		IniRead, AutoShutdownDelay, %CoreConfigFile%, ENGINE_TUNING, AutoShutdownTimer
		IniRead, AutoShutdownDelay2, %CoreConfigFile%, ENGINE_TUNING, AutoShutdownTimerB
		IniRead, AutoAccHandlerLocks, %CoreConfigFile%, ENGINE_SWITCHES, Auto_AccountSwapContrlLock
		;;;;;;------------------------------------------------------------------------;;;;;;
		;; Verify Base Engine Settings & States
		IniRead, EngineStandbyStatus, %CoreConfigFile%, ENGINE, SystemStandbyState
		;;;;;________________________________________________________________________;;;;;;
		;;; DEFINE SPECIFIC GLOBALS FOR CERTAIN NEEDED CRITICAL FEATURES
		GLOBAL HandlerVerbosityLevel := AutoD2HandlerVerbosity
		GLOBAL EngineStandbyState := EngineStandbyStatus
		;;;;;________________________________________________________________________;;;;;;
		If(AutoAccHandlerState = 1)
		{
	IniRead, EngineDebugState, config_core.cfg, ENGINE_DEBUG, Debugger
	If(EngineDebugState = 1)
	{
    MsgBox, 262144, [D2Overseer], [console]:  Auto Account Handler Event Logic Enabled., 10
	}
		If(AccHandler = 0)
			{
			GLOBAL AccHandler = "1"
			 If(AutoAccHandlerSteam = 1)
			  {
				; Run, steam://rungameid/16937913202140774400
				Run, steam_auto_C.exe
			    ; Return
	IniRead, EngineDebugState, config_core.cfg, ENGINE_DEBUG, Debugger

;;;;;________________________________________________________________________;;;;;;
;;; DEBUGGER BREAKPOINT 
	If(EngineDebugState = 1)
	{
    MsgBox, 262144, [D2Overseer], [console]:  Auto Account Handler Event Fired Steam C Drive Diablo 2., 10
	}
;;;;;________________________________________________________________________;;;;;;
			  }
			  Else{
				;   Run, D:\Program Files\Battle.net\Battle.net Launcher.exe
				Run, %A_ScriptDir%\nsAuto_C.exe
	IniRead, EngineDebugState, config_core.cfg, ENGINE_DEBUG, Debugger


;;;;;________________________________________________________________________;;;;;;
;;; DEBUGGER BREAKPOINT 
	If(EngineDebugState = 1)
	{
    MsgBox, 262144, [D2Overseer], [console]:  Auto Account Handler Event Fired NON-Steam C Drive Diablo 2., 10
	}
;;;;;________________________________________________________________________;;;;;;
			  }
			}
		Else If(AccHandler = 1)
			{
			GLOBAL AccHandler = "0"
			 If(AutoAccHandlerSteam = 1)
			  {
				; Run, steam://rungameid/16333687247205302272
				Run, steam_auto_D.exe
			    ; Return
	IniRead, EngineDebugState, config_core.cfg, ENGINE_DEBUG, Debugger
	If(EngineDebugState = 1)
	{
    MsgBox, 262144, [D2Overseer], [console]:  Auto Account Handler Event Fired Steam D Drive Diablo 2., 10
	}
			  }
			  Else{
				;   Run, D:\Program Files\Battle.net\Battle.net Launcher.exe
				Run, %A_ScriptDir%\nsAuto_D.exe
	IniRead, EngineDebugState, config_core.cfg, ENGINE_DEBUG, Debugger
	If(EngineDebugState = 1)
	{
    MsgBox, 262144, [D2Overseer], [console]:  Auto Account Handler Event Fired NON-Steam D Drive Diablo 2., 10
	}
			  }
			}
		}
	 
		;;;;;________________________________________________________________________;;;;;;

		If(AutoD2HandlerState = 1)
		{

				If(HandlerVerbosityLevel = "1")
					{
						ExitApp
					}
				  If(HandlerVerbosityLevel = "2")
						{
							;IniRead, EngineStandbyState, %CoreConfigFile%, ENGINE, SystemStandbyState
							If(EngineStandbyState = "0")
								{
									EngineStandbyStatus := "1"
									CurrentStandbyCount := "0"
								IniWrite, 1, %CoreConfigFile%, ENGINE, SystemStandbyState
								}
								Sleep, 1500
							Goto, StandbySub
						}
				  Else If(HandlerVerbosityLevel = "3")
						{
							Goto, MainSub
						}
		}

	
		

		If(AutoD2HandlerState = "0")
			{
				If(EngineDisplayPrompts = "1")
					{
						MsgBox, 4, D2 Overseer -- D2 Handler Event, The automated D2R Handler is turned off.`nThe overseer will not terminate Battle.net on game close. `n`n Would you like to enable just the base handler system?,
						IfMsgBox, Yes
							{
				IniWrite 2, %CoreConfigFile%, ENGINE_TUNING, D2HandlerVerbosity
				IniWrite 1, %CoreConfigFile%, ENGINE_SWITCHES, Auto_DiabloHandler
				Sleep, 150
				IniRead, AutoD2HandlerVerbosity, %CoreConfigFile%, ENGINE_TUNING, D2HandlerVerbosity
				IniRead, AutoD2HandlerState, %CoreConfigFile%, ENGINE_SWITCHES, Auto_DiabloHandler
				Goto, MainSub
							}
						IfMsgBox, No
							{
								MsgBox, 4, D2 Overseer -- D2 Handler Event, Would you like to disable prompts like this until you enable them yourself?,
								IfMsgBox, Yes
									{
										IniWrite, 0, %CoreConfigFile%, ENGINE_TUNING, PromptOnFail
										MsgBox, , D2 Overseer -- Closing, Automated Battle.net Logic Handled. `n`nThe Automated D2 Handler is disabled preparing to exit Overseer., 20
										ExitApp
									}
							}
					}
			}	
		; If(EngineDebugState = 1)
		; 	{
		; 	MsgBox, 262144, [D2Overseer], [console]:  D2 Auto D2 Handler logic Loop completed. `n`nStandby Loop Count: %CurrentHandlerLoopCount%, 13
		; 	}

	; SetTimer, Oversee_Event, 500
	
	Return



	AutoShutdownTimer:
	IniRead, ShutdownState, %A_ScriptDir%\engine.cfg, ENGINE, AutoShutdown, 0
	If(ShutdownState = "1")
	{
		IniWrite, 0, %EngineConfigFile%, ENGINE, AutoShutdown
		ExitApp
	}
	Sleep, %AutoShutdownDelay2%
	Return




	StandbySub:
	IniRead, EngineDebugState, config_core.cfg, ENGINE_DEBUG, Debugger
	If(EngineDebugState = "1")
		{
		MsgBox, 262144, [D2Overseer -- Debug], [console]:  D2 Overseer Standby Mode Loop Started, 10
		}
	IniRead, EngineStandbyStatus, %CoreConfigFile%, ENGINE, SystemStandbyState
	IniRead, EngineStandbyDebug, %CoreConfigFile%, ENGINE_DEBUG, SystemStandbyDebug
	Sleep, 20000
	IniRead, StandbyDebug, %CoreConfigFile%, ENGINE_DEBUG, SystemStandbyDebug, 0
	CurrentStandbyCount++
	If(StandbyDebug = "1")
	{
	MsgBox, 262144, [D2Overseer], [console]:  D2 Overseer Standby Mode Loop completing. `n`nStandby Loop Count: %CurrentStandbyCount%, 13
	}
	If(EngineStandbyStatus = "0")
		{
			CurrentStandbyCount := "0"
			; IniWrite, 0, %CoreConfigFile%, ENGINE, SystemStandbyState
			Sleep, 500
				Goto, MainSub
		}
		Else If(EngineStandbyStatus = "1")
			{
				
				; CurrentStandbyCount := "0"
				; IniWrite, 0, %CoreConfigFile%, ENGINE, SystemStandbyState
				Sleep, 500
				Goto, StandbySub
			}

			Goto, StandbySub
	Return
	




Center(WinTitle*)
{
	hWnd := WinExist(WinTitle*)
	WinGet max, MinMax
	if (max = 1)
		return

	WinGetPos ,,, w, h
	x := (A_ScreenWidth / 2) - (w / 2)
	y := (A_ScreenHeight / 2) - (h / 2)
	WinMove % "ahk_id" hWnd,, % x, % y
}