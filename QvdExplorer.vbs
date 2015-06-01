
Option Explicit
 
function getNamePrefix(ArgArray)
  Dim namePart, dirPart
  Dim nameArray()
  for i=0 to ArgArray.Count-1
    if i = 0 then
      dirPart = Replace(Replace(LCase(objFSO.getParentFolderName(ArgArray(i))),"\","."),":","")
    end if
    namePart = objFSO.getBaseName(Trim(ArgArray(i)))
    ReDim Preserve nameArray(i + 1)
    nameArray(i) = namePart
  next 
  getNamePrefix = Join(nameArray,"_") & "_" &dirPart

end function


Dim WshArguments, i, rootPath, targetPath, tempName, outFile , qvdFileName
Dim baseName,WshShell,objFSO, text, notInFile, f, substr
Const qvExe = """C:\Program Files\QlikView\qv.exe"" /L /NoData "
Set objFSO = CreateObject("Scripting.FileSystemObject")
set WshArguments = WScript.Arguments
if WshArguments.Count = 0 then
    WScript.Echo "QVD filee shoud be passed as parameters"
    WScript.Quit
end if
rootPath = objFSO.GetParentFolderName(Wscript.ScriptFullName)
targetPath = ""

For Each f In objFSO.GetFolder(objFSO.BuildPath(rootPath,"Data")).Files
  If LCase(objFSO.GetExtensionName(f.Name)) = "qvs" Then
    Dim objStream, strData
    Set objStream = CreateObject("ADODB.Stream")
    objStream.CharSet = "utf-8"
    objStream.Open
    objStream.LoadFromFile(f.path)

    text = objStream.ReadText()

    objStream.Close
    Set objStream = Nothing

    text = replace(replace(text,chr(10),""),chr(13),"")
    notInFile = False
    for i=0 to WshArguments.Count-1
      substr = Trim(WshArguments(i))
      if InStr(text, substr) = 0 then
        notInFile = True
        exit for
      end if
    next
    if not notInFile then
      targetPath = Replace(LCase(f.path),".qvs","")
      exit for
    end if
  End If
Next

if targetPath = "" then
  tempName = objFSO.GetTempName()
  tempName = Replace(tempName,".tmp","")
  tempName = getNamePrefix(WshArguments) & "_" & tempName
  targetPath = objFSO.BuildPath(objFSO.BuildPath(rootPath,"Data"),tempName)

  Set outFile = CreateObject("ADODB.Stream")
  outFile.Open
  outFile.CharSet = "utf-8"
  'outFile.WriteText targetPath & vbNewline

  for i=0 to WshArguments.Count-1
    qvdFileName=Trim(WshArguments(i))
    if (UCase(objFSO.getExtensionName(qvdFileName)) <> "QVD") then
      WScript.Echo "Invalid file in parameter: " & qvdFileName
      WScript.Quit
    end if
    baseName = LCase(objFSO.getBaseName(qvdFileName))
    outFile.WriteText "[" &baseName & "]:" & vbNewline
    outFile.WriteText "LOAD * FROM" & vbNewline
    outFile.WriteText "  [" & qvdFileName & "] (QVD);" & vbNewline & vbNewline 
    ' Additional metaddata 
    ' outFile.WriteText "QvdFieldHeader: " & vbNewline
    ' outFile.WriteText "LOAD FieldName as _META_FieldName," & vbNewline
    ' outFile.WriteText "  NoOfSymbols as _META_UniqValues " & vbNewline
    ' outFile.WriteText "    FROM [" & qvdFileName & "] (XmlSimple, Table is [QvdTableHeader/Fields/QvdFieldHeader]);" & vbNewline & vbNewline



  next 'end of loop

  outFile.SaveToFile targetPath & ".qvs", 2
  Set outFile = Nothing

  objFSO.CopyFile objFSO.BuildPath(rootPath,"Template.qvw"),targetPath & ".qvw"
end if  

Set WshShell = CreateObject("WScript.Shell")
WshShell.Run qvExe & targetPath & ".qvw"