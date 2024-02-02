;;;; https://www.autohotkey.com/boards/viewtopic.php?t=87367
fsize:=32

#NoEnv
Gui , Timer : -dpiscale
Gui , Timer :  +AlwaysOnTop -dpiscale +resize +toolwindow +LastFound

Gui, Timer:Default

Gui , Timer:add , text , x0 y0  w20 h20 gtog +backgroundtrans ,
Gui , Timer:add , text , x0 y0  w20 h20 gstart vires +backgroundtrans -border ,

Gui , Timer:Font , s%fsize% cBlue , Impact
Gui , Timer:add , text , x8 yp  h38 left  vdispt gresume, 00:00:00
Gui , Timer:Font
Gui , Timer:Font , s10 , Trebuchet MS

;	===========================================================
Gui , Timer:Add , Button , % "gstart x4 y+2 h22 center vbStart w83"  , Re/Start
Gui , Timer:Add , Button , % "gresume x+2 yp h22 vbres center w83" , P/Resume
;	===========================================================

;	===========================================================
Gui , Timer:add , Text , x4 y+2 w55 -border center , Hrs
Gui , Timer:add , Text , x+1 yp w55 -border center , Min
Gui , Timer:add , Text , x+1 yp w57 -border center , Sec
;	===========================================================

;	===========================================================
Gui , Timer:Font , s10 , Trebuchet MS
Gui , Timer:Add , Edit , x4 y+2 w55 h20 center ve3
Gui , Timer:Add , UpDown ,  yp w55 h20 -VScroll , 0
Gui , Timer:Add , Edit ,  x+2 yp w55 h20 center ve2
Gui , Timer:Add , UpDown ,   w55 h20 -VScroll , 0
Gui , Timer:Add , Edit ,  x+2 yp w55 h20 center ve1
Gui , Timer:Add , UpDown ,  w55 h20 -VScroll vud, 10

;	===========================================================
Gui , Timer:add, text , vTIdle x4 y+3 -border w58 gopa7 section , 00:00:00     
Gui , Timer:add, text , vTStart x4 y+2 w58 -border gSTTTT,  00:00:00
;	===========================================================

Gui, Timer:Add, DropDownList, vtimer_options Choose1 altsubmit x+2 ys+10 w110 gset_option_func, no_option|open file|system beep|message box|hybernate/sleep|shutdown|start_after_idle

STTTT:

Gui, Show, % " w" getcontrol("bres", "xw")+2 " h" getcontrol("timer_options", "yh")+2, Countdown Timer

GuiControl, Movedraw, ires, % " x0 " "y " getcontrol("dispt", "yh")-20


return
ires:
return
tog:
toggleb:=!toggleb

if toggleb {
Gui, Show, % " w" getcontrol("dispt", "xw")+4 " h" getcontrol("bres", "y")
}
else
Gui, Show, %  " w" getcontrol("ud", "xw")+4 " h" getcontrol("timer_options", "yh")+2

return

start:
;   Pause , 0
   Toggle:=1
   Gui , Submit , NoHide
   ;Gui , Timer:Font , s26 cBlue , Segoe UI
   Gui , Timer:Font , s%fsize% cBlue , Impact
   GuiControl , Timer:Font , dispt
 If e3 is not number
	e3:=0
 If e2 is not number
	e2:=0
 If e1 is not number
	e1:=0
 
   secsLeft :=  e3*3600+e2*60+e1
   seconds := Format("{:02}" , floor(mod(secsLeft , 60)))	
   minutes := Format("{:02}" , mod(floor(secsLeft/60) , 60))
   hours  :=  floor(secsLeft/3600)
   
   hur := Format("{:02}" , floor(abs(secsleft)/3600))
   min := Format("{:02}" , floor(mod(abs(secsLeft/60),60)))
   sec := Format("{:02}" , floor(mod(abs(secsLeft), 60)))
   
   GuiControl , Timer:text , dispt , %hur%:%min%:%sec% 
   FormatTime , TimeString, , HH:mm:ss				 
   GuiControl , Timer:text , TStart , %TimeString%
   SetTimer , CDTimer , 1000
return

resume:
  if (hours+minutes+seconds < -1) {
  gosub start
  return
  }
	Toggle:=!Toggle
	if (toggle) {  
		SetTimer, CDTimer, on
	 }
    else
		SetTimer, CDTimer, off
   GuiControl , , e3 , %hours%
   GuiControl , , e2 , %minutes%
   GuiControl , , e1 , %seconds%
   GuiControl , , dispt , %hur%:%min%:%sec%
return

CDTimer:
;   Gui , Submit , NoHide
   secsLeft--
   hur := Format("{:02}" , floor(abs(secsleft)/3600))
   min := Format("{:02}" , floor(mod(abs(secsLeft/60),60)))
   sec := Format("{:02}" , floor(mod(abs(secsLeft), 60)))
   GuiControl , Timer:text , dispt, %hur%:%min%:%sec%
   IfEqual , secsLeft , 0
   {
      ;Gui , Timer:Font , s26 cRed , Segoe UI
      Gui , Timer:Font , s%fsize% cRed , Impact
      GuiControl , Timer:Font , dispt  
      goto  opb%timer_options%
      return
   }
   Else	
      Return
   
set_option_func:
   Gui , Submit , NoHide
   goto  opa%timer_options%
opa1:
opb1:
return

opa2:
	FileSelectFile, SelectedFile, 3, , Open a file, Open After Countdown (*.*)
return
opb2:
	run, %SelectedFile%
return
   
opb3:
	 SoundBeep, 360, 1000
opa3:
return

opb4:
   msgbox , 262144 , Timer, Time's Up !
opa4:
return

opb5:
   run, rundll32.exe powrprof.dll`,SetSuspendState Sleep
opa5:
return

opb6:
   run, shutdown.exe /s
opa6:
return

Check4Idle:
	if (IdleTCd < 1){
    SetTimer Check4Idle, Off
	return
	}
	If (A_TimeIdle > IdleTCd*1000){
    SetTimer Check4Idle, Off
	gosub start
	return
	}
return

opa7: 
   Gui , Submit , NoHide
   inputbox, IdleTCd, Idle Time , Please enter minutes for PC to idle before auto countdown. 0 to disable, ,180 ,160
   SetTimer , Check4Idle , 1000
    idlhur := Format("{:02}" , floor(abs(IdleTCd)/60))
	idlmin := Format("{:02}" , floor(mod(abs(IdleTCd), 60)))
	idlsec := Format("{:02}" , floor(mod(abs(IdleTCd*60), 60)))
	IdleTCd := floor(IdleTCd*60)
	
	GuiControl , Timer:text , TIdle , %idlhur%:%idlmin%:%idlsec%
opb7:
return 

TimerGuiClose:
ExitApp


getcontrol(crtname, what)
{
 guicontrolget, out,  Pos, %crtname%

 if (what="x")
 return % outx

 if (what="y")
 return % outy

 if (what="w")
 return % outW

 if (what="h")
 return % outH

 if (what="yh")
 return % outy + outH 

 if (what="xw")
 return % outx + outW
}

