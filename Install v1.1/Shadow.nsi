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

var DCSupDir

!define LANG_ENGLISH 3081
!define TEMP1 $R0 ;Temp variable
VIProductVersion "1.1.0.6"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "Shadow"
VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments" "For use with DataCAD"
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "dhSoftware"
;VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalTrademarks" "Test Application is a trademark of Fake company"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "David Henderson 2017"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "Shadow Macro for DataCAD"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "1.1.0.6"

!include LogicLib.nsh


Function .onInit

ReadRegStr $0 HKCU "Software\Microsoft\Windows\CurrentVersion\App Paths\DCADWIN.EXE" Path
${If} $0 != ""
	StrCpy $1 "DCX\"
	StrCpy $InstDir $0$1
	StrCpy $1 "Support Files"
	StrCpy $DCSupDir $0$1
	${If} ${FileExists} $InstDir
	${Else} 
		StrCpy $InstDir ""
	${EndIf}
	${If} $InstDir == ""
		StrCpy $1 "\DCX\"
		StrCpy $InstDir $0$1
		StrCpy $1 "\Support Files"
		StrCpy $DCSupDir $0$1
		${If} ${FileExists} $InstDir
		${Else}
			StrCpy $InstDir ""
		${EndIf}
	${EndIf}
	${If} $InstDir == ""
		StrCpy $1 "Macros\"
		StrCpy $InstDir $0$1
		StrCpy $1 "Support Files"
		StrCpy $DCSupDir $0$1
		${If} ${FileExists} $InstDir
		${Else}
			StrCpy $InstDir ""
		${EndIf}
	${EndIf}
	${If} $InstDir == ""
		StrCpy $1 "\Macros\"
		StrCpy $InstDir $0$1
		StrCpy $1 "\Support Files"
		StrCpy $DCSupDir $0$1
		${If} ${FileExists} $InstDir
		${Else}
			StrCpy $InstDir ""
		${EndIf}
	${EndIf}
${Else}
	ReadRegStr $0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\DCADWIN.exe" Path
	${If} $0 != ""
		StrCpy $1 "DCX\"
		StrCpy $InstDir $0$1
		StrCpy $1 "Support Files"
		StrCpy $DCSupDir $0$1
		${If} ${FileExists} $InstDir
		${Else} 
			StrCpy $InstDir ""
		${EndIf}
		${If} $InstDir == ""
			StrCpy $1 "\DCX\"
			StrCpy $InstDir $0$1
			StrCpy $1 "\Support Files"
			StrCpy $DCSupDir $0$1
			${If} ${FileExists} $InstDir
			${Else}
				StrCpy $InstDir ""
			${EndIf}
		${EndIf}
		${If} $InstDir == ""
			StrCpy $1 "Macros\"
			StrCpy $InstDir $0$1
			StrCpy $1 "Support Files"
			StrCpy $DCSupDir $0$1
			${If} ${FileExists} $InstDir
			${Else}
				StrCpy $InstDir ""
			${EndIf}
		${EndIf}
		${If} $InstDir == ""
			StrCpy $1 "\Macros\"
			StrCpy $InstDir $0$1
			StrCpy $1 "\Support Files"
			StrCpy $DCSupDir $0$1
			${If} ${FileExists} $InstDir
			${Else}
				StrCpy $InstDir ""
			${EndIf}
		${EndIf}
	${ElseIf} ${FileExists} "C:\DataCAD 24\macros"
		StrCpy $InstDir "C:\DataCAD 24\macros\"
		StrCpy $DCSupDir "C:\DataCAD 24\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 23\macros"
		StrCpy $InstDir "C:\DataCAD 23\macros\"
		StrCpy $DCSupDir "C:\DataCAD 23\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 22\macros"
		StrCpy $InstDir "C:\DataCAD 22\macros\"
		StrCpy $DCSupDir "C:\DataCAD 22\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 21\macros"
		StrCpy $InstDir "C:\DataCAD 21\macros\"
		StrCpy $DCSupDir "C:\DataCAD 21\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 20\macros"
		StrCpy $InstDir "C:\DataCAD 20\macros\"
		StrCpy $DCSupDir "C:\DataCAD 20\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 19\macros"
		StrCpy $InstDir "C:\DataCAD 19\macros\"
		StrCpy $DCSupDir "C:\DataCAD 19\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 18\macros"
		StrCpy $InstDir "C:\DataCAD 18\macros\"
		StrCpy $DCSupDir "C:\DataCAD 18\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 17\macros"
		StrCpy $InstDir "C:\DataCAD 17\macros\"
		StrCpy $DCSupDir "C:\DataCAD 17\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 16\macros"
		StrCpy $InstDir "C:\DataCAD 16\macros\"
		StrCpy $DCSupDir "C:\DataCAD 26\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 15\macros"
		StrCpy $InstDir "C:\DataCAD 15\macros\"
		StrCpy $DCSupDir "C:\DataCAD 15\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 14\macros"
		StrCpy $InstDir "C:\DataCAD 14\macros\"
		StrCpy $DCSupDir "C:\DataCAD 14\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 13\macros"
		StrCpy $InstDir "C:\DataCAD 13\macros\"
		StrCpy $DCSupDir "C:\DataCAD 13\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 12\macros"
		StrCpy $InstDir "C:\DataCAD 12\macros\"
		StrCpy $DCSupDir "C:\DataCAD 12\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 11\macros"
		StrCpy $InstDir "C:\DataCAD 11\macros\"
		StrCpy $DCSupDir "C:\DataCAD 11\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD 10\DCX"
		StrCpy $InstDir "C:\DataCAD 10\DCX\"
		StrCpy $DCSupDir "C:\DataCAD 10\Support Files"
	${ElseIf} ${FileExists} "C:\DataCAD\macros"
		StrCpy $InstDir "C:\DataCAD\macros\"
		StrCpy $DCSupDir "C:\DataCAD\Support Files"
	${ElseIf} ${FileExists} "$ProgramFiles\DataCAD\Macros"
		StrCpy $InstDir "$ProgramFiles\DataCAD\Macros\"
		StrCpy $DCSupDir "$ProgramFiles\DataCAD\Support Files"
	${ElseIf} ${FileExists} "$ProgramFiles\DataCAD\DCX"
		StrCpy $InstDir "$ProgramFiles\DataCAD\DCX\"
		StrCpy $DCSupDir "$ProgramFiles\DataCAD\Support Files"
	${ElseIf} ${FileExists} "$ProgramFiles\DataCADWin\DCX"
		StrCpy $InstDir "$ProgramFiles\DataCADWin\DCX\"
		StrCpy $DCSupDir "$ProgramFiles\DataCADWin\Support Files"
	${ElseIf} ${FileExists} "$ProgramFiles\DCADWin\DCX"
		StrCpy $InstDir "$ProgramFiles\DCADWin\DCX\"
		StrCpy $DCSupDir "$ProgramFiles\DCADWin\Support Files"
	${Else}
			StrCpy $InstDir "C:\DataCAD\Macro\"
			StrCpy $DCSupDir "C:\DataCAD\Support Files"
	${EndIf}
	
${EndIf}

	StrCpy $0 $DCSupDir "" -1
	StrCmp $0 "\" 0 +2
	StrCpy $DCSupDir $DCSupDir -1
	StrCpy $0 $InstDir "" -1
	StrCmp $0 "\" 0 +2
	StrCpy $InstDir $InstDir -1

  InitPluginsDir
  File /oname=$PLUGINSDIR\Directories.ini "directories.ini"
  WriteIniStr $PLUGINSDIR\Directories.ini "Field 4" "State" "$DCSupDir"
  WriteIniStr $PLUGINSDIR\Directories.ini "Field 2" "State" "$InstDir"

FunctionEnd


Function SetCustom

  ;Display the InstallOptions dialog

  Push ${TEMP1}

    InstallOptions::dialog "$PLUGINSDIR\Directories.ini"
    Pop ${TEMP1}
  	;WriteINIStr ${DCMainDIR} "$PLUGINSDIR\test.ini" "Field 2" "State"

  Pop ${TEMP1}

FunctionEnd


Function SetCustom1

  ;Display the InstallOptions dialog
  InitPluginsDir
	ReserveFile "ReadMe.ini"

  File /oname=$PLUGINSDIR\ReadMe.ini "ReadMe.ini"
	StrCpy $0 "\ShadowInstructions.pdf"
	StrCpy $1 $DCSupDir$0
	WriteIniStr $PLUGINSDIR\ReadMe.ini "Field 2" "Text" "$1"
	WriteIniStr $PLUGINSDIR\ReadMe.ini "Field 4" "State" "$1"

  Push ${TEMP1}

    InstallOptions::dialog "$PLUGINSDIR\ReadMe.ini"
    Pop ${TEMP1}

  Pop ${TEMP1}

FunctionEnd


; Request application privileges for Windows Vista
RequestExecutionLevel user

DirText "You should install to your existing DataCAD macro folder.  Ensure that the Destination Folder below is correct before proceeding."  "Enter existing DataCAD Macros Folder (DCX folder in early DataCAD versions)" "" "Browse for Existing DataCAD Macros or DCX Folder:"

;--------------------------------

; Pages

Page license
Page custom SetCustom ValidateCustom ": Install Directories" ;Custom page. InstallOptions gets called in SetCustom.
;Page directory
Page instfiles
Page custom SetCustom1 ValidateCustom1 ": Instruction Manual" ;Custom page. InstallOptions gets called in SetCustom.

 PageEx license
   LicenseText "ReadMe"
   LicenseData "ReadMe.txt"
	 LicenseForceSelection off

 PageExEnd



;--------------------------------
BrandingText  /TRIMCENTER "dhSoftware"
Caption "Install Shadow Macro"
LicenseData "C:\DCAL\Projects\Shadow\doc v1.1\ShadowLicense.txt"
LicenseForceSelection checkbox "I Accept"
;LicenseForceSelection radiobuttons "I Accept" "I Decline"
; The stuff to install
Section "" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
	File C:\DCAL\Projects\Shadow\Shadow.dcx
	
	StrCpy $0 $DCSupDir
	StrCpy $1 "\dhsoftware"
	StrCpy $DCSupDir $0$1
  SetOutPath $DCSupDir

	File C:\dhSoftware\Delphi\SunPosition\Win32\Release\SunPos.exe
  File "C:\DCAL\Projects\Shadow\doc v1.1\ShadowInstructions.pdf"
	File "C:\dhSoftware\Delphi\ShadHelp v1.1\Win32\Release\ShadHelp.exe"
  
SectionEnd ; end the section

Function ValidateCustom

  ReadINIStr $DCSupDir "$PLUGINSDIR\Directories.ini" "Field 4" "State"
  ReadINIStr $INSTDIR "$PLUGINSDIR\Directories.ini" "Field 2" "State"

  
FunctionEnd
Function ValidateCustom1

  
FunctionEnd
