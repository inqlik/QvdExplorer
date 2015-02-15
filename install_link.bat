cd %~dp0
REM copy QvdExplorer.lnk c:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\SendTo\
cscript createLink.vbs "c:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\SendTo\QvdExplorer.lnk" "QvdExplorer.bat"
