cd %~dp0
IF EXIST "c:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\SendTo\QvdExplorer.lnk" DEL /F "c:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\SendTo\QvdExplorer.lnk"
cscript setup.vbs "c:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\SendTo\QvdExplorer.lnk" "QvdExplorer.bat"
