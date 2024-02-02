#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
#Persistent
DetectHiddenWindows, On


;;;; https://serverfault.com/questions/924794/powershell-script-to-detect-when-a-hot-spot-is-in-use-and-edit-the-registry


;;;; https://stackoverflow.com/questions/45833873/enable-windows-10-built-in-hotspot-by-cmd-batch-powershell
;;;; https://superuser.com/questions/1341997/using-a-uwp-api-namespace-in-powershell/1342416#1342416



full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
try
{
if A_IsCompiled
Run *RunAs "%A_ScriptFullPath%" /restart
else
Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
}
ExitApp
}




GLOBAL AppTitleRoot := "Chain Overflow"
GLOBAL FolderTitleRoot := "ChainOverflow"
; GLOBAL ConfigFileTitle := "autohotspot_handler.cfg" ;; remove the X on the end!
GLOBAL ConfigFileTitle := "chain_core.cfg" ;; remove the X on the end!
GLOBAL HotspotActivityLog := "hotspot_state.log"
GLOBAL ModulesPod := "modules"
GLOBAL Module0x001 := "pdaUptime.exe"
GLOBAL Module0x002 := "StopWatch.exe"
GLOBAL Module0x003 := "bnet_overseer.exe"
GLOBAL Module0x004 := "CounterTimer.exe"


Menu, Tray, NoStandard
Menu, Tray, Add, Settings, SettingsBTN  ; Creates a new menu item.
Menu, Tray, Add, Open Container, OpenDirectoryRootBTN  ; Creates a new menu item.
Menu, Tray, Add, Open Local App Folder, OpenDirectoryAppBTN  ; Creates a new menu item.
Menu, Tray, Add  ; Creates a separator line.
Menu, Tray, Add, Direct QuickHotspot, RunQHSThreadCall   ; Creates a new menu item.
Menu, Tray, Add, Query PDAnet Uptime, pdaUptime_CallModuleBTN   ; Creates a new menu item.
Menu, Tray, Add  ; Creates a separator line.
Menu, Tray, Add, StopWatch, OpenStopWatch  ;
Menu, Tray, Add, Countdown Timer, OpenCountdownTimer  ;
Menu, Tray, Add, Run Battle.net Overseer, OpenBNETHandler  ;
Menu, Tray, Add  ; Creates a separator line.
; Menu, Tray, Add, Halt Root Threads, clampRootThreadCalls   ; Creates a new menu item.
Menu, Tray, Add, Stop Auto-HotSpot, clampHotSpotSThreadCall   ; Creates a new menu item.
Menu, Tray, Add, Start Auto-HotSpot, reRunHotSpotSThreadCall   ; Creates a new menu item.
Menu, Tray, Add, Stop Auto-Server, clampServerThreadCalls   ; Creates a new menu item.
Menu, Tray, Add, Start Auto-Server, reRunServerThreadCalls   ; Creates a new menu item.
Menu, Tray, Add  ; Creates a separator line.
Menu, Tray, Add, Stop *All* Threads, clampRootThreadCalls   ; Creates a new menu item.
Menu, Tray, Add, Rerun *All* Threads, reRunRootThreadCalls   ; Creates a new menu item.
Menu, Tray, Add, Refresh PDAnet HardwareID, refreshPdaHwnd   ; Creates a new menu item.
Menu, Tray, Add, Refresh String Table, RefreshGlobalStrControl   ; Creates a new menu item.
Menu, Tray, Add  ; Creates a separator line.
Menu, Tray, Add, Reboot Engine, ReloadBTN   ; Creates a new menu item.
Menu, Tray, Add, Exit, ExitBTN   ; Creates a new menu item.
Menu, Tray, Tip, %AppTitleRoot%








config_path := A_MyDocuments . "\" . FolderTitleRoot . "\" . ConfigFileTitle
create_config_path := A_MyDocuments . "\" . FolderTitleRoot
create_modules_path := A_MyDocuments . "\" . FolderTitleRoot . "\modules"
create_bnetOverseer_path := A_MyDocuments . "\" . FolderTitleRoot . "\modules\BNET Overseer"


GLOBAL AppFolderCallRoot := A_MyDocuments . "\" . FolderTitleRoot . "\"

GLOBAL ModuleCall0x001 := A_MyDocuments . "\" . FolderTitleRoot . "\" . ModulesPod . "\" . Module0x001

GLOBAL ModuleCall0x002 := A_MyDocuments . "\" . FolderTitleRoot . "\" . ModulesPod . "\" . Module0x002

GLOBAL ModuleCall0x003 := A_MyDocuments . "\" . FolderTitleRoot . "\" . ModulesPod . "\BNET Overseer\" . Module0x003

GLOBAL ModuleCall0x004 := A_MyDocuments . "\" . FolderTitleRoot . "\" . ModulesPod . "\BNET Overseer\" . Module0x004

FileCreateDir, %create_config_path%
FileCreateDir, %create_modules_path%
FileCreateDir, %create_bnetOverseer_path%
Sleep, 350


FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\start_hotspot.ps1, C:\start_hotspot.ps1, 1
FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\start_hotspot_verify.ps1, C:\start_hotspot_verify.ps1, 1

; FileInstall, %A_ScriptDir%\%ModulesPod%\%Module0x001%, %create_config_path%\%ModulesPod%\%Module0x001%, 0
; FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\autohotspot_handler.cfg, C:\Users\thann\Documents\HotSpots\autohotspot_handler.cfg, 0
; FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\autohotspot_handler.cfg, C:\autohotspot_handler.cfg, 0
FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\chain_core.cfg, C:\Users\thann\Documents\ChainOverflow\chain_core.cfg, 0
FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\NULL.exe, C:\Users\thann\Documents\ChainOverflow\null\null.exe, 0
; FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\chain_core.cfg, C:\chain_core.cfg, 0

FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\start_hotspot.ps1, C:\Users\thann\Documents\ChainOverflow\start_hotspot.ps1, 1
FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\start_hotspot_mine.ps1, C:\Users\thann\Documents\ChainOverflow\start_hotspot_mine.ps1, 1
FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\start_hotspot_default.ps1, C:\Users\thann\Documents\ChainOverflow\start_hotspot_default.ps1, 1
FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\start_hotspot_verify.ps1, C:\Users\thann\Documents\ChainOverflow\start_hotspot_verify.ps1, 1

FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\modules\pdaUptime.exe, C:\Users\thann\Documents\ChainOverflow\modules\pdaUptime.exe, 1
FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\modules\StopWatch.exe, C:\Users\thann\Documents\ChainOverflow\modules\StopWatch.exe, 1
FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\modules\CounterTimer.exe, C:\Users\thann\Documents\ChainOverflow\modules\CounterTimer.exe, 1

FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\modules\steam_battleOverseer\bnet_overseer.exe, C:\Users\thann\Documents\ChainOverflow\modules\BNET Overseer\bnet_overseer.exe, 0
FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\modules\steam_battleOverseer\config_core.cfg, C:\Users\thann\Documents\ChainOverflow\modules\BNET Overseer\config_core.cfg, 1
FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\NewGithubSourceFiles\modules\steam_battleOverseer\engine.cfg, C:\Users\thann\Documents\ChainOverflow\modules\BNET Overseer\engine.cfg,1

IniRead, ShowDebugMessages1, %config_path%, DEBUG, ShowBreakpoints, 0


; If(FileExist(A_MyDocuments . "\" . FolderTitleRoot . "\" . ConfigFileTitle))
; {
;     If(ShowDebugMessages1="1")
;     {
;     MsgBox, , (1) Exists!, cfg at documents Exists!,
;     }
;     ; Return
; }
; Else
; {
;     If(ShowDebugMessages1="1")
;     {
;     MsgBox, , (1) DOES NOT Exist!, cfg at documents error! Rebuilding!,
;     }
;     FileCreateDir, %create_config_path%
;     Sleep, 1500
;     FileAppend,  , %config_path%
;     Sleep, 1500
;     IniWrite, 0, %config_path%, SWITCHES, AutoNetProbe
;     Sleep, 1500
;     FileAppend, "; 1.)  Run an auxiliary thread to periodically probe for internet connectivity. Experimental."---->";", %config_path%
;     IniWrite, 0, %config_path%, SWITCHES, AutoServerLauncher
;     Sleep, 1500
;     FileAppend, "; 1.)  Run an auxiliary thread to launch the Auto Server Launcher Handler", %config_path%
;     Sleep, 1500
;     FileAppend, ";---->If Value = -1, indicates an exception error whereby eventually NetProbe dsabled itself due to exhaustion." [def. value: 0. range: 0-1(-1)] ";", %config_path%
;     Sleep, 1500
;     IniWrite, 1, %config_path%, SWITCHES, AutoPDAnetIDsniff
;     Sleep, 1500
;     FileAppend, "; 2.)  Thread to automatically keep PDAnet's HWnd up to date in config." [def. value: 0. range: 0-1] ";", %config_path%
;     Sleep, 1500
;     IniWrite, 0, %config_path%, SWITCHES, NetProbeImageRecog
;     Sleep, 700
;     FileAppend, "; 3.)  Uses image recognition in NetProbe to find the disconnect or connect buttons for PDANet TrayMenu." [def. value: 0. range: 0-1] ";", %config_path%
;     Sleep, 1500
;     IniWrite, 0, %config_path%, SWITCHES, QuickHotspot
;     Sleep, 700
;     FileAppend, "; 4.)  Force the system to run a Hotspot Init. Bypass instantly before timer logic." [def. vale: 1. range: 0-1] ";", %config_path%
;     ; Sleep, 500
;     ; FileAppend, ";", %config_path%
;     Sleep, 1500
;     IniWrite, 0, %config_path%, SWITCHES, QuickHotspotRerunCompat
;     Sleep, 1500
;     FileAppend, "; 5.)  If 1, Integrates QuickHotspot execution into Root Rerun Thread Statements tooltray contextmenu control." [def. value: 0. range: 0-1] ";", %config_path%
;     Sleep, 1500
;     IniWrite, 0, %config_path%, SWITCHES, 2PassCleanup
;     Sleep, 1500
;     FileAppend, "; 6.)  Perform a Second Process Close Event on the tail end of every cleanup pass." [def. value: 0. range: 0-1] ";", %config_path%   
;     Sleep, 1500                ;;; This marks the end of writing SWITCHES section, leading into CONFIG so we do not get a monotony-breaking ";" line
;     IniWrite, 22000, %config_path%, CONFIG, HotspotTickrate
;     Sleep, 1500
;     FileAppend, "; 1.)  Speed in miliseconds the main hotspot thread ticks at." [def. value: 22000. range: undefined] ";", %config_path%
;     Sleep, 1500
;     IniWrite, 47000, %config_path%, CONFIG, NetProbeTickrate
;     Sleep, 1500
;     FileAppend, "; 2.)  Speed in miliseconds the net probe thread ticks at." [def. value: 47000. range: undefined] ";", %config_path%
;     Sleep, 1500
;     IniWrite, 31000, %config_path%, CONFIG, CleanupTickrate
;     Sleep, 1500
;     FileAppend, "; 3.)  Speed in miliseconds that the powershell cleaner ticks at." [def. value: 31000. range: undefined] ";", %config_path%
;     Sleep, 1500
;     IniWrite, PdaNetPC.exe, %config_path%, PDAnet, pdaExe
;     Sleep, 1500
;     FileAppend, "; 1.)  Title of the PDANet executable." [def. value: PdaNetPC.exe. range: undefined] ";", %config_path%
;     Sleep, 1500
;     IniWrite, User-Input, %config_path%, PDAnet, pdaPath
;     Sleep, 1500
;     FileAppend, "; 2.)  Install Path to the PDANet executable." [def. value: undefined. range: undefined] ";", %config_path%

;     IniWrite, 26000, %config_path%, PDAnet, pdaIDAutoUpdateRate
;     Sleep, 1500  
;     FileAppend, "; 3.)  Time between ticks of the Automatic PDAnet ID Update Thread." [def. value: 26000. range: undefined] ";", %config_path%
;     Sleep, 1500  
;     IniWrite, User-Input, %config_path%, PDAnet, pdaHWnd
;     Sleep, 1500 
;     FileAppend, "; 4.)  PDANet Hardware ID Signature." [def. value: undefined. range: undefined] ";", %config_path%
;     Sleep, 1500  
;     IniWrite, User-Input, %config_path%, PDAnet, pdaUptime
;     Sleep, 1500 
;     FileAppend, "; 5.)  PDANet Uptime (Formatted time-readable value given from milisecond data)." [def. value: undefined. range: undefined] ";", %config_path%
;     Sleep, 1500  
;     IniWrite, User-Input, %config_path%, PDAnet, pdaUptimeMS
;     Sleep, 1500 
;     FileAppend, "; 6.)  PDANet Uptime (FILETIME TO MS)." [def. value: undefined. range: undefined] ";", %config_path%
;     Sleep, 1500                ;;; This marks the end of writing CONFIG section, leading into DEBUG section, so we do not get a monotony-breaking ";" line
;     IniWrite, 1, %config_path%, DEBUG, InvokeUAC
;     Sleep, 1500
;     FileAppend, "; 1.)  Forces the script to always launch using elevated admin rights." [def. value: 1. range: 0-1] ";", %config_path%
;     Sleep, 1500                ;;; This marks the end of writing CONFIG section, leading into DEBUG section, so we do not get a monotony-breaking ";" line
;     IniWrite, 0, %config_path%, DEBUG, ShowBreakpoints
;     Sleep, 1500
;     FileAppend, "; 2.)  Shows breakpoint messages. 2 = debug hotspot logic. 3 = debug netprobe. 4 = debug tooltray controls." [def. value: 0. range: 0-4] ";", %config_path%
;     IniWrite, 0, %config_path%, DEBUG, ShowBreakpoints
;     Sleep, 1500
;     FileAppend, "; 2.)  Shows breakpoint messages. 2 = debug hotspot logic. 3 = debug netprobe. 4 = debug tooltray controls." [def. value: 0. range: 0-4] ";", %config_path%

;         ; If(FileExist(A_MyDocuments . ConfigFileTitle))
;         If(FileExist(A_MyDocuments . "\" . FolderTitleRoot . "\" . ConfigFileTitle))
;         {
;         If(ShowDebugMessages1="1")
;         {
;         MsgBox, , (2) Exists!, cfg at documents Exists!,
;         }
;         }
;         Else
;         {
;         If(ShowDebugMessages1="1")
;         {
;         MsgBox, , (2) DOES NOT Exist!, cfg at documents error! Rebuild failed! Check permissions or logic!,
;         }
;         ; Return
;         }

; }



SetTimer, RefreshGlobalStrControl, -150
; Sleep, 500
Sleep, 1500


; IniRead, AutoNetProbing, %config_path%, SWITCHES, AutoNetProbe
; IniRead, NetProbeTicks, %config_path%, CONFIG, HotspotTickrate
; IniRead, PDAnetExe, %config_path%, CONFIG, pdaExe
; IniRead, PDAnetPath, %config_path%, CONFIG, pdaPath


; IniRead, HotspotPulsar, %config_path%, CONFIG, HotspotTickrate, 22000
; IniRead, CleanerPulsar, %config_path%, CONFIG, CleanupTickrate, 31000
; IniRead, QuickHotspotLaunch, %config_path%, SWITCHES, QuickHotspot, 0
; IniRead, 2PAS_Cleanup, %config_path%, SWITCHES, 2PassCleanup, 0
; IniRead, ShowDebugMessages2, %config_path%, DEBUG, ShowBreakpoints, 0
; IniRead, NetProbeImageRecogn, %config_path%, SWITCHES, NetProbeImageRecog

; GLOBAL NetProbeImageRecog := NetProbeImageRecogn
; GLOBAL QuickHotspot :=  QuickHotspotLaunch 
; GLOBAL 2PASCleanup :=  2PAS_Cleanup 
; GLOBAL HotspotPulse :=  HotspotPulsar
; GLOBAL CleanerPulse :=  CleanerPulsar
; GLOBAL PDAExe := PDAnetExe
; GLOBAL PDAPath := PDAnetPath
; GLOBAL AutoNetProbe := AutoNetProbing
; GLOBAL NetProbeTick := NetProbeTicks
; GLOBAL PDAformatted := PDAnetPath . "\" . PDAExe

; GLOBAL NetProbeExecutionLevel := ""
; If(ShowDebugMessages1=ShowDebugMessages2)
; {
;     GLOBAL ShowDebugMessages := ShowDebugMessages1
; }
; Else
; {
;     GLOBAL ShowDebugMessages := ShowDebugMessages2
; }

ThrowString0x001 := 0
; If(ShowDebugMessages="1")
; {
; MsgBox,, value notifiers, `n| 2pass cleanup = %2PASCleanup% `n| ShowDebugMessages = %ShowDebugMessages%, 25
; }


Sleep, 25000
; Run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File C:\start_hotspot.ps1,,Hide
If(AutoPDAnetIDsniff="1")
{
SetTimer, AutoPDAnetHWnd, %pdaIDAutoUpdateRate%
}
If(AutoNetProbe="1")
{
SetTimer, NetProbe, %NetProbeTick%
}
If(QuickHotspot="1")
{
    SetTimer, FireQuickHotspot, -1000
}


;;;;; WE DO CHECK THE VALUE OF 'doMAINAutoHotspotThread' VARIABLE HERE SINCE THIS IS A THE AUTOEXEC RUN OF THE NORMAL ROOT THREADS *NOT* USING THE TRAYMENU CONTROLS
If(doMAINAutoHotspotThread="1")
{
SetTimer, HotspotHeart, %HotspotPulse%
SetTimer, CleanUpDriver, %CleanerPulse%
}




If(doMAINAutoStartupsThread="1")
{
    GLOBAL StartupLauncherDelay := "-" . AutoStartupsDelay
    SetTimer, AutoStartupsThread, %StartupLauncherDelay%
}

If(doMAINAutoServersThread="1")
{
    GLOBAL ServerLauncherDelay := "-" . AutoServersDelay
    SetTimer, AutoServersThread, %ServerLauncherDelay%
}

If(doMAINAutoServersThread="2")   ;  IF 'AutoServerLaunchers' value is 2, then instead of performing a single launch like if it were 1, we do an automated server watcher that reopens the servers if they close.
{
    SetTimer, AutoServersThread, OFF ;; ENSURE WE'RE NOT SOMEHOW RUNNING TWO INSTANCES OF THE SERVER THREAD, SINGLE-USE AND REPEATING AT ONCE
    SetTimer, AutoServersRepeaterThread, %AutoServerRepeater%
}




















If(QuickHotspot="1")
{
SetTimer, CleanupQuickHotspot, -7500
}
Return



AutoPDAnetHWnd:
PDAhWid := WinExist("ahk_exe PdaNetPC.exe")

	IniWrite, %PDAhWid%, %config_path%, PDAnet, pdaHWnd

IniRead, PDAhWnd_facade, %config_path%, PDAnet, PDAhWnd, data_unwritable
GLOBAL PDAhWnd := PDAhWnd_facade
Return




FireQuickHotspot:
Run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File start_hotspot.ps1,,Hide
Return

CleanupQuickHotspot:
Process, Close, Powershell.exe
If(2PASCleanup="1")
{
Process, Close, Powershell.exe
}
Return


HotspotHeart:
IniRead, ShowDebugMessages3, %config_path%, DEBUG, ShowBreakpoints, 0
GLOBAL ShowDebugMessages := ShowDebugMessages3
; Run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File start_hotspot_verify.ps1,,Hide
Run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File start_hotspot.ps1,,Hide
Sleep, 3500
FileRead, HotspotStates, %create_config_path%\%HotspotActivityLog%
Sleep, 5500
FileDelete, %create_config_path%\%HotspotActivityLog%
Process, Close, Powershell.exe
        If(ShowDebugMessages="2")
        {
        MsgBox,, [ChainOverflow]: HotSpot Heartbeat, Hotspot Status is: %HotspotStates%.
        }
Needle1 := "On"
Needle2 := "Off"
Needle3 := "InTransition"
If InStr(HotspotStates, Needle1)
    {
        GLOBAL HotspotStatus := "1"
    }
If InStr(HotspotStates, Needle2)
    {
        GLOBAL HotspotStatus := "0"
    }
If InStr(HotspotStates, Needle3)
    {
        GLOBAL HotspotStatus := "2"
    }
If(HotspotStatus="1")
{
        If(ShowDebugMessages="2")
        {
        MsgBox,, [ChainOverflow]: HotSpot Heartbeat, Hotspot is already turned on.
        }
    Return
}
If(HotspotStatus="0")
{
        If(ShowDebugMessages="2")
        {
        MsgBox,, [ChainOverflow]: HotSpot Heartbeat, Hotspot is turned off.
        }
    Run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File start_hotspot.ps1,,Hide
    Return
}
If(HotspotStatus="2")
{
        If(ShowDebugMessages="2")
        {
        MsgBox,, [ChainOverflow]: HotSpot Heartbeat, Hotspot is currently in transition state in-between turned on & off.
        }
    ; Run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File start_hotspot.ps1,,Hide
    Return
}
Return




AutoStartupsThread:
If(doStartupLauncher001="1")
{
GLOBAL StartupApp001 := StartupLaunchDIR001 . "\" . StartupLaunchEXE001
Run, %StartupApp001%
}

If(doStartupLauncher002="1")
{
GLOBAL StartupApp002 := StartupLaunchDIR002 . "\" . StartupLaunchEXE002
Run, %StartupApp002%
}

If(doStartupLauncher003="1")
{
GLOBAL StartupApp003 := StartupLaunchDIR003 . "\" . StartupLaunchEXE003
Run, %StartupApp003%
}

If(doStartupLauncher004="1")
{
GLOBAL StartupApp004 := StartupLaunchDIR004 . "\" . StartupLaunchEXE004
Run, %StartupApp004%
}

If(doStartupLauncher005="1")
{
GLOBAL StartupApp005 := StartupLaunchDIR005 . "\" . StartupLaunchEXE005
Run, %StartupApp005%
}

If(doStartupLauncher006="1")
{
GLOBAL StartupApp006 := StartupLaunchDIR006 . "\" . StartupLaunchEXE006
Run, %StartupApp006%
}

If(doStartupLauncher007="1")
{
GLOBAL StartupApp007 := StartupLaunchDIR007 . "\" . StartupLaunchEXE007
Run, %StartupApp007%
}

If(doStartupLauncher008="1")
{
GLOBAL StartupApp008 := StartupLaunchDIR008 . "\" . StartupLaunchEXE008
Run, %StartupApp008%
}

If(doStartupLauncher009="1")
{
GLOBAL StartupApp009 := StartupLaunchDIR009 . "\" . StartupLaunchEXE009
Run, %StartupApp009%
}

If(doStartupLauncher010="1")
{
GLOBAL StartupApp010 := StartupLaunchDIR010 . "\" . StartupLaunchEXE010
Run, %StartupApp010%
}
Return



AutoServersThread:

;;; RUN VDESK HERE, MAYBE MAKE IT OPTIONAL

If(doServerLauncher001="1")
{
GLOBAL ServerApp001 := ServerLaunchDIR001 . "\" . ServerLaunchEXE001
Run, %ServerApp001%
}
If(doServerLauncher002="1")
{
GLOBAL ServerApp002 := ServerLaunchDIR002 . "\" . ServerLaunchEXE002
Run, %ServerApp002%
}
If(doServerLauncher003="1")
{
GLOBAL ServerApp003 := ServerLaunchDIR003 . "\" . ServerLaunchEXE003
Run, %ServerApp003%
}
        If(ShowDebugMessages="5")
        {
        MsgBox,, [ChainOverflow]: Server Launcher, Single-Execute Thread of Auto Server-Launcher called.
        }
Return






AutoServersRepeaterThread:
If(ProcessExist(ServerLaunchEXE001))
{
; Do nothing, the process exists
}
    Else
    {
        IfWinExist, %ServerLaunchTITLE001%
        {
            ; Do nothing, the batch window exists
        }
        Else
            {
            ;;; CALL VDESK NULL HERE TO THE CORRECT PAGE, MAYBE MAKE IT OPTIONAL
            GLOBAL ServerApp001 := ServerLaunchDIR001 . "\" . ServerLaunchEXE001
            Run, %ServerApp001%
            }

    }
If(ProcessExist(ServerLaunchEXE002))
{
; Do nothing, the process exists
}
    Else
    {
        IfWinExist, %ServerLaunchTITLE002%
        {
            ; Do nothing, the batch window exists
        }
        Else
            {
            ;;; CALL VDESK NULL HERE TO THE CORRECT PAGE
            GLOBAL ServerApp002 := ServerLaunchDIR002 . "\" . ServerLaunchEXE002
            Run, %ServerApp002%
            }

    }
If(ProcessExist(ServerLaunchEXE003))
{
; Do nothing, the process exists
}
    Else
    {
        IfWinExist, %ServerLaunchTITLE003%
        {
            ; Do nothing, the batch window exists
        }
        Else
            {
            ;;; CALL VDESK NULL HERE TO THE CORRECT PAGE
            GLOBAL ServerApp003 := ServerLaunchDIR002 . "\" . ServerLaunchEXE003
            Run, %ServerApp003%
            }

    }

        If(ShowDebugMessages="5")
        {
        MsgBox,, [ChainOverflow]: Server Handler, Repeater Thread of Auto Server-Handler called.
        }
Return








CleanUpDriver:
        If(ShowDebugMessages="1")
        {
        MsgBox,, [ChainOverflow]: Powershell Cleaner Heartbeat, Hotspot cleaner heartbeat tick pulsed.
        }
If(ThrowString0x001="0")
{
    ThrowString0x001++ ;; var = 1 now, cold boot iniated, do a one-time close of a large block of powershell exe instances
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
If(ThrowString0x001="1")
{
ThrowString0x001++ ;; now the the var will hit 2 and this will never execute again
FileDelete, %create_config_path%\%HotspotActivityLog%
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
Process, Close, Powershell.exe
}
Process, Close, Powershell.exe  ;; perform one single ensured exit of powershell's current exe instances
If(2PASCleanup="1")
{
Process, Close, Powershell.exe  ;; if enabled, allows the automated cleaner to perform two passes to close powershell on normal subsequent ticks
        If(ShowDebugMessages="1")
        {
        MsgBox,, [ChainOverflow]: Powershell Cleaner Heartbeat, Hotspot cleaner heartbeat tick pulse arbitrary 2nd PASS called.
        }
}
        If(ShowDebugMessages="1")
        {
        MsgBox,, [ChainOverflow]: Powershell Cleaner Heartbeat, Hotspot cleaner heartbeat tick pulse complete.
        }
Return




NetProbe:
; If(ProcessExist("PdaNetPC.exe"))
If(ProcessExist(PDAExe))
{

}
Else
{
Run, %PDAPath%\%PDAExe%
}

;;;;; RUN NET CONNECTIVITY TEST HERE, PARSE THE RESULTS, IF THE RESULTS PROVE TRUE, 
    UrlDownloadToFile, https://drive.google.com/file/d/1xTyQApFEKttY_EbL5grZWOkVcc7qgZHe/view?usp=sharing, create_config_path\netprobe.hotspots
    if ErrorLevel   ; i.e. it's not blank or zero.
    MsgBox, The File was unable to be downloaded and does not exist.
    else
    MsgBox, The file was downloaded, you're connect to the internet, verify the file's size to be sure?
    Return

    Sleep, 500
ResultA:=TrayIcon_Button(PDAExe, "L", false, 1)
; TrayIcon_Button(LaunchDataExe, "L", false, 1)
; TrayIcon_Button(LaunchDataExe, "L", false, 1)
; TrayIcon_Button(LaunchDataExe, "L", false, 1)
; Sleep, 1000
; ResultB:=FindClick(Image001, "silent n w3000")
; If(ResultB="0")
; {
;     If(AutoRetry="1")
;     {
;         SoundBeep, 750, 700
;         Sleep, 1000
;             MouseMove, 17, 6, 50, R
;             Sleep, 700
;             Click
;             Sleep, 700
;             BlockInput, Off
;             Return
;         }
;     }
Return
; NetProbe:
; If(ProcessExist("PdaNetPC.exe"))
; {

; }
; Else
; {
; Run, %PDAPath%\%PDAExe%
; }

; ;;;;; RUN NET CONNECTIVITY TEST HERE, PARSE THE RESULTS, IF THE RESULTS PROVE TRUE, 
;     UrlDownloadToFile, https://drive.google.com/file/d/1xTyQApFEKttY_EbL5grZWOkVcc7qgZHe/view?usp=sharing, create_config_path\netprobe.hotspots
;     if ErrorLevel   ; i.e. it's not blank or zero.
;     MsgBox, The File was unable to be downloaded and does not exist.
;     else
;     MsgBox, The file was downloaded, you're connect to the internet, verify the file's size to be sure?
;     Return

;     Sleep, 500
; ResultA:=TrayIcon_Button(PDAExe, "L", false, 1)
; ; TrayIcon_Button(LaunchDataExe, "L", false, 1)
; ; TrayIcon_Button(LaunchDataExe, "L", false, 1)
; ; TrayIcon_Button(LaunchDataExe, "L", false, 1)
; ; Sleep, 1000
; ; ResultB:=FindClick(Image001, "silent n w3000")
; ; If(ResultB="0")
; ; {
; ;     If(AutoRetry="1")
; ;     {
; ;         SoundBeep, 750, 700
; ;         Sleep, 1000
; ;             MouseMove, 17, 6, 50, R
; ;             Sleep, 700
; ;             Click
; ;             Sleep, 700
; ;             BlockInput, Off
; ;             Return
; ;         }
; ;     }
Return







RunQHSThreadCall:
SetTimer, RefreshGlobalStrControl, -150
    If(ShowDebugMessages="4")
    {
       MsgBox,, [ChainOverflow]: QuickHotspot Thread Recall, Successfully Directly-Executed QuickHotSpot Thread--despite or in favor of detected stored settings data.
    }
SetTimer, FireQuickHotspot, -1000
Return










clampHotSpotSThreadCall:
SetTimer, HotspotHeart, Off
SetTimer, CleanUpDriver, Off
    If(ShowDebugMessages="4")
    {
        MsgBox,, [ChainOverflow]: Freeze HotSpot Thread, Auto-HotSpot thread successfully frozen,
    }
Return



reRunHotSpotSThreadCall:
SetTimer, RefreshGlobalStrControl, -150
Sleep, 100
If(QuickHotspotRerunCompat="1")
{
    If(ShowDebugMessages="4")
    {
       MsgBox,, [ChainOverflow]: Root Thread Recall, QuickHotSpotCompat Switch detected and applied to main instance of execution.
    }
    If(QuickHotspot="1")
    {
    SetTimer, FireQuickHotspot, -1000
    }
}
If(QuickHotspot="1")
{
SetTimer, CleanupQuickHotspot, -7500
}
    If(ShowDebugMessages="4")
    {
       MsgBox,, [ChainOverflow]: Root Thread Recall, Successfully Re-Executed All Root Thread Calls--Checking them against stored settings data.
    }
SetTimer, HotspotHeart, %HotspotPulse%
SetTimer, CleanUpDriver, %CleanerPulse%

    If(ShowDebugMessages="4")
    {
        MsgBox,, [ChainOverflow]: Unfreeze HotSpot Thread, Auto-HotSpot thread successfully resumed,
    }
Return






clampServerThreadCalls:
; SetTimer, AutoServersRepeaterThread, %AutoServerRepeater%
SetTimer, AutoServersRepeaterThread, OFF
    If(ShowDebugMessages="4")
    {
        MsgBox,, [ChainOverflow]: Freeze Server Thread, Server thread successfully froze,
    }
Return


reRunServerThreadCalls:
SetTimer, RefreshGlobalStrControl, -150
Sleep, 150
SetTimer, AutoServersRepeaterThread, %AutoServerRepeater%
    If(ShowDebugMessages="4")
    {
        MsgBox,, [ChainOverflow]: Freeze Server Thread, Server thread successfully resumed,
    }
Return








clampRootThreadCalls:
SetTimer, RefreshGlobalStrControl, -150
SetTimer, CleanupQuickHotspot, -750
SetTimer, AutoServersThread, OFF
SetTimer, AutoStartupsThread, OFF
SetTimer, NetProbe, Off
SetTimer, FireQuickHotspot, Off
SetTimer, HotspotHeart, Off
SetTimer, CleanUpDriver, Off
SetTimer, FireQuickHotspot, Off
SetTimer, AutoPDAnetHWnd, Off
    If(ShowDebugMessages="4")
    {
        MsgBox,, [ChainOverflow]: Freeze All Threads, All threads successfully frozen,
    }
Return




reRunRootThreadCalls:
SetTimer, RefreshGlobalStrControl, -150
Sleep, 800
If(AutoPDAnetIDsniff="1")
{
SetTimer, AutoPDAnetHWnd, %pdaIDAutoUpdateRate%
    If(ShowDebugMessages="4")
    {
       MsgBox,, [ChainOverflow]: Root Thread Recall, Auto PDAnet ID Updater Switch detected and applied to main instance of execution.
    }
}

If(AutoNetProbe="1")
{
SetTimer, NetProbe, %NetProbeTick%
    If(ShowDebugMessages="4")
    {
       MsgBox,, [ChainOverflow]: Root Thread Recall, Auto NetProbe Switch detected and applied to main instance of execution.
    }
}

If(QuickHotspotRerunCompat="1")
{
    If(ShowDebugMessages="4")
    {
       MsgBox,, [ChainOverflow]: Root Thread Recall, QuickHotSpotCompat Switch detected and applied to main instance of execution.
    }
    If(QuickHotspot="1")
    {
    SetTimer, FireQuickHotspot, -1000
    }
}

;;;;; WE DON'T CHECK THE VALUE OF 'doMAINAutoHotspotThread' VARIABLE HERE SINCE THIS IS A MANUAL RE-RUN OF THE NORMAL ROOT THREADS USING THE TRAYMENU CONTROLS
SetTimer, HotspotHeart, %HotspotPulse%
SetTimer, CleanUpDriver, %CleanerPulse%

If(QuickHotspot="1")
{
SetTimer, CleanupQuickHotspot, -7500
}
    If(ShowDebugMessages="4")
    {
       MsgBox,, [ChainOverflow]: Root Thread Recall, Successfully Re-Executed All Root Thread Calls--Checking them against stored settings data.
    }
Return






RefreshGlobalStrControl:
If(ProcessExist("PdaNetPC.exe"))
{
    PDAhWid := WinExist("ahk_exe PdaNetPC.exe")

	IniWrite, %PDAhWid%, %config_path%, PDAnet, pdaHWnd

    IniRead, PDAhWnd_facade, %config_path%, PDAnet, PDAhWnd, data_unwritable
    GLOBAL PDAhWnd := PDAhWnd_facade
}

IniRead, AutoAutoHotSpotHeartbeatMAIN, %config_path%, SWITCHES, AutoHotSpots
GLOBAL doMAINAutoHotspotThread := AutoAutoHotSpotHeartbeatMAIN

IniRead, AutoStartupLaunchersMAIN, %config_path%, SWITCHES, AutoStartupLaunchers, 0
IniRead, AutoStartupLaunchersDelay, %config_path%, CONFIG, StartupLaunchersDelay, 2500
GLOBAL doMAINAutoStartupsThread := AutoStartupLaunchersMAIN
GLOBAL AutoStartupsDelay := AutoStartupLaunchersDelay
If(doMAINAutoStartupsThread="1")
{
IniRead, doStartupLaunchers001, %config_path%, STARTUP_LAUNCHERS, doLaunch_001, 0
IniRead, doStartupLaunchers002, %config_path%, STARTUP_LAUNCHERS, doLaunch_002, 0
IniRead, doStartupLaunchers003, %config_path%, STARTUP_LAUNCHERS, doLaunch_003, 0
IniRead, doStartupLaunchers004, %config_path%, STARTUP_LAUNCHERS, doLaunch_004, 0
IniRead, doStartupLaunchers005, %config_path%, STARTUP_LAUNCHERS, doLaunch_005, 0
IniRead, doStartupLaunchers006, %config_path%, STARTUP_LAUNCHERS, doLaunch_006, 0
IniRead, doStartupLaunchers007, %config_path%, STARTUP_LAUNCHERS, doLaunch_007, 0
IniRead, doStartupLaunchers008, %config_path%, STARTUP_LAUNCHERS, doLaunch_008, 0
IniRead, doStartupLaunchers009, %config_path%, STARTUP_LAUNCHERS, doLaunch_009, 0
IniRead, doStartupLaunchers010, %config_path%, STARTUP_LAUNCHERS, doLaunch_010, 0
GLOBAL doStartupLauncher001 := doStartupLaunchers001
GLOBAL doStartupLauncher002 := doStartupLaunchers002
GLOBAL doStartupLauncher003 := doStartupLaunchers003
GLOBAL doStartupLauncher004 := doStartupLaunchers004
GLOBAL doStartupLauncher005 := doStartupLaunchers005
GLOBAL doStartupLauncher006 := doStartupLaunchers006
GLOBAL doStartupLauncher007 := doStartupLaunchers007
GLOBAL doStartupLauncher008 := doStartupLaunchers008
GLOBAL doStartupLauncher009 := doStartupLaunchers009
GLOBAL doStartupLauncher010 := doStartupLaunchers010
IniRead, StartupsLaunchDIR001, %config_path%, STARTUP_LAUNCHERS, LaunchFolder_001, userInputNeeded
IniRead, StartupsLaunchDIR002, %config_path%, STARTUP_LAUNCHERS, LaunchFolder_002, userInputNeeded
IniRead, StartupsLaunchDIR003, %config_path%, STARTUP_LAUNCHERS, LaunchFolder_003, userInputNeeded
IniRead, StartupsLaunchDIR004, %config_path%, STARTUP_LAUNCHERS, LaunchFolder_004, userInputNeeded
IniRead, StartupsLaunchDIR005, %config_path%, STARTUP_LAUNCHERS, LaunchFolder_005, userInputNeeded
IniRead, StartupsLaunchDIR006, %config_path%, STARTUP_LAUNCHERS, LaunchFolder_006, userInputNeeded
IniRead, StartupsLaunchDIR007, %config_path%, STARTUP_LAUNCHERS, LaunchFolder_007, userInputNeeded
IniRead, StartupsLaunchDIR008, %config_path%, STARTUP_LAUNCHERS, LaunchFolder_008, userInputNeeded
IniRead, StartupsLaunchDIR009, %config_path%, STARTUP_LAUNCHERS, LaunchFolder_009, userInputNeeded
IniRead, StartupsLaunchDIR010, %config_path%, STARTUP_LAUNCHERS, LaunchFolder_010, userInputNeeded
GLOBAL StartupLaunchDIR001 := StartupsLaunchDIR001
GLOBAL StartupLaunchDIR002 := StartupsLaunchDIR002
GLOBAL StartupLaunchDIR003 := StartupsLaunchDIR003
GLOBAL StartupLaunchDIR004 := StartupsLaunchDIR004
GLOBAL StartupLaunchDIR005 := StartupsLaunchDIR005
GLOBAL StartupLaunchDIR006 := StartupsLaunchDIR006
GLOBAL StartupLaunchDIR007 := StartupsLaunchDIR007
GLOBAL StartupLaunchDIR008 := StartupsLaunchDIR008
GLOBAL StartupLaunchDIR009 := StartupsLaunchDIR009
GLOBAL StartupLaunchDIR010 := StartupsLaunchDIR010
IniRead, StartupsLaunchEXE001, %config_path%, STARTUP_LAUNCHERS, LaunchEXE_001, userInputNeeded
IniRead, StartupsLaunchEXE002, %config_path%, STARTUP_LAUNCHERS, LaunchEXE_002, userInputNeeded
IniRead, StartupsLaunchEXE003, %config_path%, STARTUP_LAUNCHERS, LaunchEXE_003, userInputNeeded
IniRead, StartupsLaunchEXE004, %config_path%, STARTUP_LAUNCHERS, LaunchEXE_004, userInputNeeded
IniRead, StartupsLaunchEXE005, %config_path%, STARTUP_LAUNCHERS, LaunchEXE_005, userInputNeeded
IniRead, StartupsLaunchEXE006, %config_path%, STARTUP_LAUNCHERS, LaunchEXE_006, userInputNeeded
IniRead, StartupsLaunchEXE007, %config_path%, STARTUP_LAUNCHERS, LaunchEXE_007, userInputNeeded
IniRead, StartupsLaunchEXE008, %config_path%, STARTUP_LAUNCHERS, LaunchEXE_008, userInputNeeded
IniRead, StartupsLaunchEXE009, %config_path%, STARTUP_LAUNCHERS, LaunchEXE_009, userInputNeeded
IniRead, StartupsLaunchEXE010, %config_path%, STARTUP_LAUNCHERS, LaunchEXE_010, userInputNeeded
GLOBAL StartupLaunchEXE001 := StartupsLaunchEXE001
GLOBAL StartupLaunchEXE002 := StartupsLaunchEXE002
GLOBAL StartupLaunchEXE003 := StartupsLaunchEXE003
GLOBAL StartupLaunchEXE004 := StartupsLaunchEXE004
GLOBAL StartupLaunchEXE005 := StartupsLaunchEXE005
GLOBAL StartupLaunchEXE006 := StartupsLaunchEXE006
GLOBAL StartupLaunchEXE007 := StartupsLaunchEXE007
GLOBAL StartupLaunchEXE008 := StartupsLaunchEXE008
GLOBAL StartupLaunchEXE009 := StartupsLaunchEXE009
GLOBAL StartupLaunchEXE010 := StartupsLaunchEXE010
}





IniRead, AutoServerHandlingMAIN, %config_path%, SWITCHES, AutoServerLaunchers, 0
IniRead, AutoServerLaunchersDelay, %config_path%, CONFIG, ServerLaunchersDelay, 5500
IniRead, ServerLauncherRepeaterSpeed, %config_path%, CONFIG, ServerLauncherRepeaterTickrate, 44000
GLOBAL doMAINAutoServersThread := AutoServerHandlingMAIN
GLOBAL AutoServersDelay := AutoServerLaunchersDelay
GLOBAL AutoServerRepeater := ServerLauncherRepeaterSpeed
If(doMAINAutoServersThread="1")
{
IniRead, doServerLaunchers001, %config_path%, SERVER_LAUNCHERS, doLaunch_001, 0
IniRead, doServerLaunchers002, %config_path%, SERVER_LAUNCHERS, doLaunch_002, 0
IniRead, doServerLaunchers003, %config_path%, SERVER_LAUNCHERS, doLaunch_003, 0
GLOBAL doServerLauncher001 := doServerLaunchers001
GLOBAL doServerLauncher002 := doServerLaunchers002
GLOBAL doServerLauncher003 := doServerLaunchers003
IniRead, ServersLaunchDIR001, %config_path%, SERVER_LAUNCHERS, LaunchFolder_001, userInputNeeded
IniRead, ServersLaunchDIR002, %config_path%, SERVER_LAUNCHERS, LaunchFolder_002, userInputNeeded
IniRead, ServersLaunchDIR003, %config_path%, SERVER_LAUNCHERS, LaunchFolder_003, userInputNeeded
GLOBAL ServerLaunchDIR001 := ServersLaunchDIR001
GLOBAL ServerLaunchDIR002 := ServersLaunchDIR002
GLOBAL ServerLaunchDIR003 := ServersLaunchDIR003
IniRead, ServersLaunchEXE001, %config_path%, SERVER_LAUNCHERS, LaunchEXE_001, userInputNeeded
IniRead, ServersLaunchEXE002, %config_path%, SERVER_LAUNCHERS, LaunchEXE_002, userInputNeeded
IniRead, ServersLaunchEXE003, %config_path%, SERVER_LAUNCHERS, LaunchEXE_003, userInputNeeded
GLOBAL ServerLaunchEXE001 := ServersLaunchEXE001
GLOBAL ServerLaunchEXE002 := ServersLaunchEXE002
GLOBAL ServerLaunchEXE003 := ServersLaunchEXE003
IniRead, ServersLaunchTITLE001, %config_path%, SERVER_LAUNCHERS, ServerLaunchTITLE_001, userInputNeeded
IniRead, ServersLaunchTITLE002, %config_path%, SERVER_LAUNCHERS, ServerLaunchTITLE_002, userInputNeeded
IniRead, ServersLaunchTITLE003, %config_path%, SERVER_LAUNCHERS, ServerLaunchTITLE_003, userInputNeeded
GLOBAL ServerLaunchTITLE001 := ServersLaunchTITLE001
GLOBAL ServerLaunchTITLE002 := ServersLaunchTITLE002
GLOBAL ServerLaunchTITLE003 := ServersLaunchTITLE003
}




IniRead, ShowDebugMessages1, %config_path%, DEBUG, ShowBreakpoints, 0
IniRead, AutoPDAnetIDsniffer, %config_path%, SWITCHES, AutoPDAnetIDsniff
IniRead, AutoPDAnetIDsniffRate, %config_path%, PDAnet, pdaIDAutoUpdateRate
GLOBAL pdaIDAutoUpdateRate := AutoPDAnetIDsniffRate
GLOBAL AutoPDAnetIDsniff := AutoPDAnetIDsniffer
IniRead, AutoNetProbing, %config_path%, SWITCHES, AutoNetProbe
IniRead, NetProbeTicks, %config_path%, CONFIG, HotspotTickrate
IniRead, PDAnetExe, %config_path%, PDAnet, pdaExe
IniRead, PDAnetPath, %config_path%, PDAnet, pdaPath
IniRead, bPDAnetUptime, %config_path%, PDAnet, pdaUptime
IniRead, bPDAnetUptimeMS, %config_path%, PDAnet, pdaUptimeMS
GLOBAL pdaUptime := bPDAnetUptime
GLOBAL pdaUptimeMS := bPDAnetUptimeMS
IniRead, HotspotPulsar, %config_path%, CONFIG, HotspotTickrate, 22000
IniRead, CleanerPulsar, %config_path%, CONFIG, CleanupTickrate, 31000
IniRead, QuickHotspotLaunch, %config_path%, SWITCHES, QuickHotspot, 0
IniRead, 2PAS_Cleanup, %config_path%, SWITCHES, 2PassCleanup, 0
IniRead, ShowDebugMessages2, %config_path%, DEBUG, ShowBreakpoints, 0
IniRead, NetProbeImageRecogn, %config_path%, SWITCHES, NetProbeImageRecog
IniRead, QuickHotspotRerunCompt, %config_path%, SWITCHES, QuickHotspotRerunCompat
GLOBAL QuickHotspotRerunCompat := QuickHotspotRerunCompt
GLOBAL NetProbeImageRecog := NetProbeImageRecogn
GLOBAL QuickHotspot :=  QuickHotspotLaunch 
GLOBAL 2PASCleanup :=  2PAS_Cleanup 
GLOBAL HotspotPulse :=  HotspotPulsar
GLOBAL CleanerPulse :=  CleanerPulsar
GLOBAL PDAExe := PDAnetExe
GLOBAL PDAPath := PDAnetPath
GLOBAL AutoNetProbe := AutoNetProbing
GLOBAL NetProbeTick := NetProbeTicks
GLOBAL PDAformatted := PDAnetPath . "\" . PDAExe
GLOBAL NetProbeExecutionLevel := ""
If(ShowDebugMessages1=ShowDebugMessages2)
{
    GLOBAL ShowDebugMessages := ShowDebugMessages1
}
Else
{
    GLOBAL ShowDebugMessages := ShowDebugMessages2
}
    If(ShowDebugMessages="4")
    {
        MsgBox,, [ChainOverflow]: Refresh Master StringTable, Successfully Merged Any String Updates To Present!, 35
    }
Return

ReloadBTN:
    If(ShowDebugMessages="4")
    {
        MsgBox,, [ChainOverflow]: Reload Control Event, Preparing to re-execute the engine subsystem...,
    }
Reload
Return

SettingsBTN:
; Run, "notepad.exe" %A_MyDocuments%\HotSpots\autohotspot_handler.cfg
; Run, "notepad.exe" %A_MyDocuments%\HotSpots\%ConfigFileTitle%
Run, "notepad.exe" %config_path%
    If(ShowDebugMessages="4")
    {
        MsgBox,, [ChainOverflow]: Settings Control Event, Executing partially hard-coded directory,
    }
return


OpenDirectoryRootBTN:
Run, explorer.exe ""%A_ScriptDir%""
Return

OpenDirectoryAppBTN:
Run, explorer.exe ""%AppFolderCallRoot%""
Return

ExitBTN:
ExitApp


refreshPdaHwnd:
PDAhWid := WinExist("ahk_exe PdaNetPC.exe")

    IniWrite, %PDAhWid%, %config_path%, PDAnet, pdaHWnd

IniRead, PDAhWnd_facade, %config_path%, PDAnet, PDAhWnd, data_unwritable
GLOBAL PDAhWnd := PDAhWnd_facade
Sleep 1000
    If(ShowDebugMessages="4")
    {
        MsgBox,, [ChainOverflow]: Refresh PDAnet Signatures, Successfully refreshed the PDAnet hWnd.,
    }
Return



pdaUptime_CallModuleBTN:
Run, %ModuleCall0x001%
Return




OpenStopWatch:
Run, %ModuleCall0x002%
Return

OpenCountdownTimer:
Run, %ModuleCall0x004%
Return


OpenBNETHandler:
Run, %ModuleCall0x003%
Return



Return
ProcessExist(PIDorName:="")
{
    Process Exist, %PIDorName%
    return ErrorLevel
}

#Include, functionLibrary.toolkit