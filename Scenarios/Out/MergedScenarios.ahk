;This file is automatically generated by the MergeScenarios tool.: 
;Do not edit it!

;Scenario merged from: C:\Dev\AHK\RetroMultiManager\Tools\..\Scenarios\LoginAccounts.ahk
LoginAccounts:
    WinGet, windows, List, Dofus
    Loop, %windows% {
        window := windows%A_Index%
        WinActivate, ahk_id %window%
        WinWaitActive, ahk_id %window%
        Sleep 50
        id := nbInstances - %A_Index% + 1
        WinSetTitle, %id%
        Click, 30,100
        Send, {Tab}
        Sleep 50
        SendRaw, % username[id]
        Sleep 50
        Send, {Tab}
        Sleep 50
        SendRaw, % password[id]
        Sleep 50
        ;Send {Enter}
        Sleep 300
        WinMaximize, ahk_id %window%
    }
return

;Scenario merged from: C:\Dev\AHK\RetroMultiManager\Tools\..\Scenarios\OpenDofusInstances.ahk
OpenDofusInstances:
    GUI_UpdateText("Opening Dofus instances...")
    GUI_UpdateBar(0)

    nbAccounts := API.GetNbAccounts()
    API.WindowList := [] ;get rid of old windows
    Loop % nbAccounts {
        Run, % oSettings.DofusPath,,, pid
        
        API.WindowList[A_Index] := New API.Window(pid)
        API.WindowList[A_Index].WaitOpen()
        API.WindowList[A_Index].SetTitle(ArrayAccounts[A_Index])

        GUI_UpdateBar(step)
        step += stepSize
        SleepHandler(0)
    }
    GUI_UpdateBar(100)
    GUI_UpdateText("Done.")
    return

;Scenario merged from: C:\Dev\AHK\RetroMultiManager\Tools\..\Scenarios\Test.ahk
Test1:
    MsgBox, % "test1"
    return
