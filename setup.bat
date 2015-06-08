REM @ECHO OFF
cd %~dp0

IF EXIST "%systemdrive%\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\SendTo\" SET sendToDir=c:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\SendTo\
IF [%sendToDir%] neq [] GOTO BODY

IF EXIST "%systemroot%\Profiles\user\SendTo\" SET sendToDir=%systemroot%\Profiles\user\SendTo\
IF [%sendToDir%] neq [] GOTO BODY

IF EXIST "%systemdrive%\Documents and Settings\user\SendTo" SET sendToDir=%systemdrive%\Documents and Settings\user\SendTo
IF [%sendToDir%] neq [] GOTO BODY

GOTO FAIL

:BODY
IF EXIST "%sendToDir%QvdExplorer.lnk" DEL /F "%sendToDir%QvdExplorer.lnk"
cscript setup.vbs "%sendToDir%QvdExplorer.lnk" "QvdExplorer.bat"
EXIT
:FAIL
ECHO ERROR! Failed to find SendTo folder
pause
