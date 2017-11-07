; example1.nsi
;
; This script is perhaps one of the simplest NSIs you can make. All of the
; optional settings are left to their default settings. The installer simply 
; prompts the user asking them where to install, and drops a copy of example1.nsi
; there. 

;--------------------------------

; The name of the installer
Name "Shadow Macro"

; The file to write
OutFile "ShadowInstall.exe"

!define LANG_ENGLISH 3081
VIProductVersion "1.0.0.0"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "Shadow"
VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments" "For use with DataCAD"
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "dhSoftware"
;VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalTrademarks" "Test Application is a trademark of Fake company"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "David Henderson 2017"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "Shadow Macro for DataCAD"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "1.0.0.0"

!include LogicLib.nsh


Function .onInit

ReadRegStr $0 HKCU "Software\Microsoft\Windows\CurrentVersion\App Paths\DCADWIN.EXE" Path
${If} $0 != ""
	StrCpy $1 "DCX\"
	StrCpy $InstDir $0$1
	${If} ${FileExists} $InstDir
	${Else} 
		StrCpy $1 "Macros\"
		StrCpy $InstDir $0$1
	${EndIf}
${Else}
	ReadRegStr $0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\DCADWIN.exe" Path
	${If} $0 != ""
		StrCpy $1 "DCX\"
		StrCpy $InstDir $0$1
		${If} ${FileExists} $InstDir
		${Else} 
			StrCpy $1 "Macros\"
			StrCpy $InstDir $0$1
		${EndIf}
	${ElseIf} ${FileExists} "C:\DataCAD 24\macros"
		StrCpy $InstDir "C:\DataCAD 24\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 23\macros"
		StrCpy $InstDir "C:\DataCAD 23\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 22\macros"
		StrCpy $InstDir "C:\DataCAD 22\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 21\macros"
		StrCpy $InstDir "C:\DataCAD 21\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 20\macros"
		StrCpy $InstDir "C:\DataCAD 20\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 19\macros"
		StrCpy $InstDir "C:\DataCAD 19\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 18\macros"
		StrCpy $InstDir "C:\DataCAD 18\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 17\macros"
		StrCpy $InstDir "C:\DataCAD 17\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 16\macros"
		StrCpy $InstDir "C:\DataCAD 16\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 15\macros"
		StrCpy $InstDir "C:\DataCAD 15\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 14\macros"
		StrCpy $InstDir "C:\DataCAD 14\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 13\macros"
		StrCpy $InstDir "C:\DataCAD 13\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 12\macros"
		StrCpy $InstDir "C:\DataCAD 12\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 11\macros"
		StrCpy $InstDir "C:\DataCAD 11\macros\"
	${ElseIf} ${FileExists} "C:\DataCAD 10\DCX"
		StrCpy $InstDir "C:\DataCAD 10\DCX\"
	${ElseIf} ${FileExists} "C:\DataCAD\macros"
		StrCpy $InstDir "C:\DataCAD\macros\"
	${ElseIf} ${FileExists} "$ProgramFiles\DataCAD\Macros"
		StrCpy $InstDir "$ProgramFiles\DataCAD\Macros\"
	${ElseIf} ${FileExists} "$ProgramFiles\DataCAD\DCX"
		StrCpy $InstDir "$ProgramFiles\DataCAD\DCX\"
	${ElseIf} ${FileExists} "$ProgramFiles\DataCADWin\DCX"
		StrCpy $InstDir "$ProgramFiles\DataCADWin\DCX\"
	${ElseIf} ${FileExists} "$ProgramFiles\DCADWin\DCX"
		StrCpy $InstDir "$ProgramFiles\DCADWin\DCX\"
	${Else}
			StrCpy $InstDir "C:\"
	${EndIf}
${EndIf}
FunctionEnd



; Request application privileges for Windows Vista
RequestExecutionLevel user

DirText "You should install to your existing DataCAD macro folder.  Ensure that the Destination Folder below is correct before proceeding."  "Enter existing DataCAD Macros Folder (DCX folder in early DataCAD versions)" "" "Browse for Existing DataCAD Macros or DCX Folder:"

;--------------------------------

; Pages

Page license
Page directory
Page instfiles

 PageEx license
   LicenseText "ReadMe"
   LicenseData "ReadMe.txt"
	 LicenseForceSelection off

 PageExEnd



;--------------------------------
BrandingText  /TRIMCENTER "dhSoftware"
Caption "Install Shadow Macro"
LicenseData "C:\DCAL\Projects\Shadow\doc\ShadowLicense.txt"
LicenseForceSelection checkbox "I Accept"
;LicenseForceSelection radiobuttons "I Accept" "I Decline"
; The stuff to install
Section "" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
	File C:\dhSoftware\Delphi\SunPosition\Win32\Release\SunPos.exe
  File C:\DCAL\Projects\Shadow\doc\ShadowInstructions.pdf
	File C:\DCAL\Projects\Shadow\Shadow.dcx
	File C:\dhSoftware\Delphi\ShadHelp\Win32\Release\ShadHelp.exe
  
SectionEnd ; end the section

;HKEY_CLASSES_ROOT\Applications\DCADWIN.EXE\Shell\Open\command  C:\DataCAD 19\dcadwin.exe "%1"
;HKEY_CLASSES_ROOT\DataCAD.$WP\DefaultIcon  C:\Program Files (x86)\DataCAD\dcadwin.exe,14
;HKEY_CLASSES_ROOT\DataCAD.AEC\DefaultIcon  C:\Program Files (x86)\DataCAD\dcadwin.exe,2
;HKEY_CLASSES_ROOT\DataCAD.ARB\DefaultIcon  C:\Program Files (x86)\DataCAD\dcadwin.exe,11
;HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\App Paths\DCADWIN.EXE   Path=C:\DataCAD 19\
;HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\DCADWIN.exe   Path=C:\DataCAD 19\
;HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\CurrentVersion\App Paths\DCADWIN.EXE
