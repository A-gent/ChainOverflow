# ChainOverflow
A small Windows engine for launching on Windows account logon.
Handles:
-Auto-Hotspots
-Software you want to launch at PC Startup
-Useful tools
-More to come
<br><br><br>


INSTALLATION:

*This engine is completely portable, and will unpack the necessary files it needs whenever they are not present when it is run. It does not touch the registry, rather it uses local config .ini files for controlling its variables, speed values, and enabling or disabling routines or features.*

*If you wish to compile the files yourself, follow the below instructions.*

-Download the newest ChainOverflow.exe file from the newest release listed under the [Releases section here](https://github.com/A-gent/ChainOverflow/releases).

-Place the "AutoHotspotHandler.exe", file at the root of your C:\ drive. 

-Optionally, you may use the Windows Task Scheduler to create a task with the condition to run on Logon using administrator priviledges, so this just automatically runs Chain Overflow the first time you logon to your Windows account.



<br>
COMPILING:

-Install AutoHotkey.

-Download the main repo's source files as a zip.

-Create a new folder to work in.

-Unzip the source files into your new folder.

-Using the IDE of your choice, open the 'autohotspot_handler.ahk' file, this is the main script. Within this file, edit the FileInstall lines near the top of the script to reflect the current directories of each necessary source file within your newly created folder.

-Use the AutoHotkey compiler to compile 'autohotspot_handler.ahk', name the .exe whatever you choose. Optionally you may use the given icon file in the source files when you compile the script, or use your own icon file, or just don't use one and AutoHotkey will simply give it the default green H icon.

-Optionally you may recompile any of the other sub-modules, or just use the given compiled executable files within the source files already.

<br>
USAGE:

To use this engine, its pretty much required that you use a compiled binary version of the main file. Either use the newest pre-compiled one for you under the [Releases section here](https://github.com/A-gent/ChainOverflow/releases) or use the compiling steps above to compile the AutoHotkey scripts from the source files yourself.
When the executable is ran, it will appear in the Windows taskbar tray in the bottom right side of the screen. Right clicking the icon of the engine in the tray will show you a control menu that allows you to take more direct control of the engine and its routines, as well as expose the settings configuration file via the 'Settings' button in that menu.
