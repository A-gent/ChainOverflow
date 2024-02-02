# ChainOverflow
A small Windows engine for launching on Windows account logon.
Handles:
-Auto-Hotspots
-Software you want to launch at PC Startup
-Useful tools
-More to come


INSTALLATION:
Place the "AutoHotspotHandler.exe", file at the root of your C:\ drive. 
Optionally, you may use the Windows Task Scheduler to create a task with the condition to run on Logon using administrator priviledges, so this just automatically runs CHain Overflow the first time you logon to your Windows account.
If you wish to compile the files yourself, follow the below instructions.


COMPILING:
-Install AutoHotkey.
-Download the main repo's source files as a zip.
-Create a new folder to work in.
-Unzip the source files into your new folder.
-Using the IDE of your choice, open the 'autohotspot_handler.ahk' file, this is the main script. Within this file, edit the FileInstall lines near the top of the script to reflect the current directories of each necessary source file.
-Use the AutoHotkey compiler to compile 'autohotspot_handler.ahk', name the .exe whatever you choose.
-Optionally you may recompile any of the other sub-modules, or just use the given compiled executable files within the source files already.
