set objWSHShell = CreateObject("WScript.Shell")
set objFso = CreateObject("Scripting.FileSystemObject")

' command line arguments
' TODO: error checking
sShortcut = objWSHShell.ExpandEnvironmentStrings(WScript.Arguments.Item(0))
sTargetPath = objFso.GetAbsolutePathName(WScript.Arguments.Item(1))
sWorkingDirectory = objFso.GetParentFolderName(sTargetPath)

set objSC = objWSHShell.CreateShortcut(sShortcut) 

objSC.TargetPath = sTargetPath
objSC.WorkingDirectory = sWorkingDirectory

objSC.Save