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




GLOBAL AppTitleRoot := "HotSpots (AutoHotspot Bot)"
GLOBAL FolderTitleRoot := "HotSpots"
GLOBAL ConfigFileTitle := "autohotspot_handler.cfg" ;; remove the X on the end!
GLOBAL HotspotActivityLog := "hotspot_state.log"
GLOBAL ModulesPod := "modules"
GLOBAL Module0x001 := "pdaUptime.exe"


Menu, Tray, NoStandard
Menu, Tray, Add, Settings, SettingsBTN  ; Creates a new menu item.
Menu, Tray, Add, Open Container, OpenDirectoryRootBTN  ; Creates a new menu item.
Menu, Tray, Add  ; Creates a separator line.
Menu, Tray, Add, Direct QuickHotspot, RunQHSThreadCall   ; Creates a new menu item.
Menu, Tray, Add, Query PDAnet Uptime, pdaUptime_CallModuleBTN   ; Creates a new menu item.
Menu, Tray, Add  ; Creates a separator line.
Menu, Tray, Add, Halt Root Threads, clampRootThreadCalls   ; Creates a new menu item.
Menu, Tray, Add, Reboot Root Threads, reRunRootThreadCalls   ; Creates a new menu item.
Menu, Tray, Add, Refresh PDAnet hWnd, refreshPdaHwnd   ; Creates a new menu item.
Menu, Tray, Add, Revitalize StringTable, RefreshGlobalStrControl   ; Creates a new menu item.
Menu, Tray, Add  ; Creates a separator line.
Menu, Tray, Add, Reboot, ReloadBTN   ; Creates a new menu item.
Menu, Tray, Add, Exit, ExitBTN   ; Creates a new menu item.
Menu, Tray, Tip, %AppTitleRoot%







config_path := A_MyDocuments . "\" . FolderTitleRoot . "\" . ConfigFileTitle
create_config_path := A_MyDocuments . "\" . FolderTitleRoot

GLOBAL ModuleCall0x001 := A_MyDocuments . "\" . FolderTitleRoot . "\" . ModulesPod . "\" . Module0x001



; FileInstall, %A_ScriptDir%\%ModulesPod%\%Module0x001%, %create_config_path%\%ModulesPod%\%Module0x001%, 0
FileInstall, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\2023 WINDOWS STARTUP LAUNCHER ENGINE\modules\pdaUptime.exe, C:\Users\thann\Documents\HotSpots\modules\pdaUptime.exe, 1

IniRead, ShowDebugMessages1, %config_path%, DEBUG, ShowBreakpoints, 0


If(FileExist(A_MyDocuments . "\" . FolderTitleRoot . "\" . ConfigFileTitle))
{
    If(ShowDebugMessages1="1")
    {
    MsgBox, , (1) Exists!, cfg at documents Exists!,
    }
    ; Return
}
Else
{
    If(ShowDebugMessages1="1")
    {
    MsgBox, , (1) DOES NOT Exist!, cfg at documents error! Rebuilding!,
    }
    FileCreateDir, %create_config_path%
    Sleep, 1500
    FileAppend,  , %config_path%
    Sleep, 1500
    IniWrite, 0, %config_path%, SWITCHES, AutoNetProbe
    Sleep, 1500
    FileAppend, "; 1.)  Run an auxiliary thread to periodically probe for internet connectivity. Experimental."---->";", %config_path%
    Sleep, 1500
    FileAppend, ";---->If Value = -1, indicates an exception error whereby eventually NetProbe dsabled itself due to exhaustion." [def. value: 0. range: 0-1(-1)] ";", %config_path%
    Sleep, 1500
    IniWrite, 1, %config_path%, SWITCHES, AutoPDAnetIDsniff
    Sleep, 1500
    FileAppend, "; 2.)  Thread to automatically keep PDAnet's HWnd up to date in config." [def. value: 0. range: 0-1] ";", %config_path%
    Sleep, 1500
    IniWrite, 0, %config_path%, SWITCHES, NetProbeImageRecog
    Sleep, 700
    FileAppend, "; 3.)  Uses image recognition in NetProbe to find the disconnect or connect buttons for PDANet TrayMenu." [def. value: 0. range: 0-1] ";", %config_path%
    Sleep, 1500
    IniWrite, 0, %config_path%, SWITCHES, QuickHotspot
    Sleep, 700
    FileAppend, "; 4.)  Force the system to run a Hotspot Init. Bypass instantly before timer logic." [def. vale: 1. range: 0-1] ";", %config_path%
    ; Sleep, 500
    ; FileAppend, ";", %config_path%
    Sleep, 1500
    IniWrite, 0, %config_path%, SWITCHES, QuickHotspotRerunCompat
    Sleep, 1500
    FileAppend, "; 5.)  If 1, Integrates QuickHotspot execution into Root Rerun Thread Statements tooltray contextmenu control." [def. value: 0. range: 0-1] ";", %config_path%
    Sleep, 1500
    IniWrite, 0, %config_path%, SWITCHES, 2PassCleanup
    Sleep, 1500
    FileAppend, "; 6.)  Perform a Second Process Close Event on the tail end of every cleanup pass." [def. value: 0. range: 0-1] ";", %config_path%   
    Sleep, 1500                ;;; This marks the end of writing SWITCHES section, leading into CONFIG so we do not get a monotony-breaking ";" line
    IniWrite, 22000, %config_path%, CONFIG, HotspotTickrate
    Sleep, 1500
    FileAppend, "; 1.)  Speed in miliseconds the main hotspot thread ticks at." [def. value: 22000. range: undefined] ";", %config_path%
    Sleep, 1500
    IniWrite, 47000, %config_path%, CONFIG, NetProbeTickrate
    Sleep, 1500
    FileAppend, "; 2.)  Speed in miliseconds the net probe thread ticks at." [def. value: 47000. range: undefined] ";", %config_path%
    Sleep, 1500
    IniWrite, 31000, %config_path%, CONFIG, CleanupTickrate
    Sleep, 1500
    FileAppend, "; 3.)  Speed in miliseconds that the powershell cleaner ticks at." [def. value: 31000. range: undefined] ";", %config_path%
    Sleep, 1500
    IniWrite, PdaNetPC.exe, %config_path%, PDAnet, pdaExe
    Sleep, 1500
    FileAppend, "; 1.)  Title of the PDANet executable." [def. value: PdaNetPC.exe. range: undefined] ";", %config_path%
    Sleep, 1500
    IniWrite, User-Input, %config_path%, PDAnet, pdaPath
    Sleep, 1500
    FileAppend, "; 2.)  Install Path to the PDANet executable." [def. value: undefined. range: undefined] ";", %config_path%

    IniWrite, 26000, %config_path%, PDAnet, pdaIDAutoUpdateRate
    Sleep, 1500  
    FileAppend, "; 3.)  Time between ticks of the Automatic PDAnet ID Update Thread." [def. value: 26000. range: undefined] ";", %config_path%
    Sleep, 1500  
    IniWrite, User-Input, %config_path%, PDAnet, pdaHWnd
    Sleep, 1500 
    FileAppend, "; 4.)  PDANet Hardware ID Signature." [def. value: undefined. range: undefined] ";", %config_path%
    Sleep, 1500  
    IniWrite, User-Input, %config_path%, PDAnet, pdaUptime
    Sleep, 1500 
    FileAppend, "; 5.)  PDANet Uptime (Formatted time-readable value given from milisecond data)." [def. value: undefined. range: undefined] ";", %config_path%
    Sleep, 1500  
    IniWrite, User-Input, %config_path%, PDAnet, pdaUptimeMS
    Sleep, 1500 
    FileAppend, "; 6.)  PDANet Uptime (FILETIME TO MS)." [def. value: undefined. range: undefined] ";", %config_path%
    Sleep, 1500                ;;; This marks the end of writing CONFIG section, leading into DEBUG section, so we do not get a monotony-breaking ";" line
    IniWrite, 1, %config_path%, DEBUG, InvokeUAC
    Sleep, 1500
    FileAppend, "; 1.)  Forces the script to always launch using elevated admin rights." [def. value: 1. range: 0-1] ";", %config_path%
    Sleep, 1500                ;;; This marks the end of writing CONFIG section, leading into DEBUG section, so we do not get a monotony-breaking ";" line
    IniWrite, 0, %config_path%, DEBUG, ShowBreakpoints
    Sleep, 1500
    FileAppend, "; 2.)  Shows breakpoint messages. 2 = debug hotspot logic. 3 = debug netprobe. 4 = debug tooltray controls." [def. value: 0. range: 0-4] ";", %config_path%

        ; If(FileExist(A_MyDocuments . ConfigFileTitle))
        If(FileExist(A_MyDocuments . "\" . FolderTitleRoot . "\" . ConfigFileTitle))
        {
        If(ShowDebugMessages1="1")
        {
        MsgBox, , (2) Exists!, cfg at documents Exists!,
        }
        }
        Else
        {
        If(ShowDebugMessages1="1")
        {
        MsgBox, , (2) DOES NOT Exist!, cfg at documents error! Rebuild failed! Check permissions or logic!,
        }
        ; Return
        }

}



SetTimer, RefreshGlobalStrControl, -150
Sleep, 500
; IniRead, AutoNetProbing, %%config_path%%, SWITCHES, AutoNetProbe
; IniRead, NetProbeTicks, %%config_path%%, CONFIG, HotspotTickrate
; IniRead, PDAnetExe, %%config_path%%, CONFIG, pdaExe
; IniRead, PDAnetPath, %%config_path%%, CONFIG, pdaPath

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
SetTimer, HotspotHeart, %HotspotPulse%
SetTimer, CleanUpDriver, %CleanerPulse%
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
Run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File start_hotspot_verify.ps1,,Hide
Sleep, 3500
FileRead, HotspotStates, %create_config_path%\%HotspotActivityLog%
Sleep, 5500
FileDelete, %create_config_path%\%HotspotActivityLog%
Process, Close, Powershell.exe
        If(ShowDebugMessages="2")
        {
        MsgBox,, HotSpot Heartbeat, Hotspot Status is: %HotspotStates%.
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
        MsgBox,, HotSpot Heartbeat, Hotspot is already turned on.
        }
    Return
}
If(HotspotStatus="0")
{
        If(ShowDebugMessages="2")
        {
        MsgBox,, HotSpot Heartbeat, Hotspot is turned off.
        }
    Run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File start_hotspot.ps1,,Hide
    Return
}
If(HotspotStatus="2")
{
        If(ShowDebugMessages="2")
        {
        MsgBox,, HotSpot Heartbeat, Hotspot is currently in transition state in-between turned on & off.
        }
    ; Run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File start_hotspot.ps1,,Hide
    Return
}
Return



CleanUpDriver:
        If(ShowDebugMessages="1")
        {
        MsgBox,, Powershell Cleaner Heartbeat, Hotspot cleaner heartbeat tick pulsed.
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
        MsgBox,, Powershell Cleaner Heartbeat, Hotspot cleaner heartbeat tick pulse arbitrary 2nd PASS called.
        }
}
        If(ShowDebugMessages="1")
        {
        MsgBox,, Powershell Cleaner Heartbeat, Hotspot cleaner heartbeat tick pulse complete.
        }
Return




NetProbe:
If(ProcessExist("PdaNetPC.exe"))
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
       MsgBox,, QuickHotspot Thread Recall, Successfully Directly-Executed QuickHotSpot Thread--despite or in favor of detected stored settings data.
    }
SetTimer, FireQuickHotspot, -1000
Return




clampRootThreadCalls:
SetTimer, RefreshGlobalStrControl, -150
SetTimer, CleanupQuickHotspot, -750
SetTimer, NetProbe, Off
SetTimer, FireQuickHotspot, Off
SetTimer, HotspotHeart, Off
SetTimer, CleanUpDriver, Off
SetTimer, FireQuickHotspot, Off
SetTimer, AutoPDAnetHWnd, Off
    If(ShowDebugMessages="4")
    {
        MsgBox,, Freeze All Threads, All major threads successfully frozen,
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
       MsgBox,, Root Thread Recall, Auto PDAnet ID Updater Switch detected and applied to main instance of execution.
    }
}

If(AutoNetProbe="1")
{
SetTimer, NetProbe, %NetProbeTick%
    If(ShowDebugMessages="4")
    {
       MsgBox,, Root Thread Recall, Auto NetProbe Switch detected and applied to main instance of execution.
    }
}

If(QuickHotspotRerunCompat="1")
{
    If(ShowDebugMessages="4")
    {
       MsgBox,, Root Thread Recall, QuickHotSpotCompat Switch detected and applied to main instance of execution.
    }
    If(QuickHotspot="1")
    {
    SetTimer, FireQuickHotspot, -1000
    }
}
SetTimer, HotspotHeart, %HotspotPulse%
SetTimer, CleanUpDriver, %CleanerPulse%
If(QuickHotspot="1")
{
SetTimer, CleanupQuickHotspot, -7500
}
    If(ShowDebugMessages="4")
    {
       MsgBox,, Root Thread Recall, Successfully Re-Executed All Root Thread Calls--Checking them against stored settings data.
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
        MsgBox,, Refresh Master StringTable, Successfully Merged Any String Updates To Present!, 35
    }
Return

ReloadBTN:
    If(ShowDebugMessages="4")
    {
        MsgBox,, Reload Control Event, Preparing to re-execute the engine subsystem...,
    }
Reload
Return

SettingsBTN:
Run, "notepad.exe" %A_MyDocuments%\HotSpots\autohotspot_handler.cfg
    If(ShowDebugMessages="4")
    {
        MsgBox,, Settings Control Event, Executing partially hard-coded directory,
    }
return


OpenDirectoryRootBTN:
Run, explorer.exe ""%A_ScriptDir%""
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
        MsgBox,, Refresh PDAnet Signatures, Successfully refreshed the PDAnet hWnd.,
    }
Return



pdaUptime_CallModuleBTN:
Run, %ModuleCall0x001%
Return


Return
ProcessExist(PIDorName:="")
{
    Process Exist, %PIDorName%
    return ErrorLevel
}

#Include, functionLibrary.toolkit