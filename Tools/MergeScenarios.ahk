/*
    Tools: Merge Scenario
*/

margedFilePath := A_ScriptDir . "\..\Scenarios\Out\MergedScenarios.ahk"
mergedFile := FileOpen(margedFilePath, "w")
mergedFile.WriteLine(";This file is automatically generated by the MergeScenarios tool.: ")
mergedFile.WriteLine(";Do not edit it!`n")

directory := A_ScriptDir . "\..\Scenarios\"
;msgbox, % directory
Loop, %directory%*.ahk
{
    FileRead, aFileContents, %A_LoopFileFullPath%
    mergedFile.WriteLine(";Scenario merged from: " . A_LoopFileFullPath)
    mergedFile.WriteLine(aFileContents . "`n")
}
mergedFile.Close()
ExitApp