;This file is automatically generated by the MergeScenarios tool.
;Do not edit it!

;Scenario merged from: Scenarios\CloseDofusInstances.ahk
/*
    Scenario: Close Dofus Instances
*/

F12::
CloseDofusInstances:
	;Header (auto-generated)
	Scenario := New API.Scenario(1,"CloseDofusInstances")
	currentScenario := Scenario
	;End Header

    API.GuiUpdateProgressText("Closing Dofus instances...")
    API.GuiUpdateProgressBar(0)

    Loop % API.GetNbWindows()
        API.CloseWindow(A_Index)
    API.LogWrite("Successfully closed " . API.GetNbWindows() . " windows.")
    API.GuiUpdateProgressText("Done.")
    API.GuiUpdateProgressBar(100)
    API.ResetWindowsIndex()
return

;Scenario merged from: Scenarios\ConnectServersPlayers.ahk
/*
    Scenario: ConnectServersPlayers
*/

ConnectServersPlayers:
	;Header (auto-generated)
	Scenario := New API.Scenario(2,"ConnectServersPlayers")
	currentScenario := Scenario
	;End Header

    section := A_ScreenWidth . "x" . A_ScreenHeight
    inputX := Scenario.GetValueFromIni(section, "Server1_x")
    inputY := Scenario.GetValueFromIni(section, "Server1_y")

    API.GuiUpdateProgressBar(0)
    Loop, % API.GetNbWindows() {
        window := API.GetWindow(A_Index)
        window.Activate()
        window.WaitActive()

        Sleep 50 * Settings.Speed
        MouseMove, inputX, inputY, 5 * Settings.Speed
        Click, 2
        Sleep 500 * Settings.Speed
        Click, 2
        API.GuiUpdateProgressBar(A_Index, API.GetNbWindows())
        SleepHandler(0)
    }
    API.LogWrite("Successfully connected " API.GetNbWindows() " characters.")
    API.GuiUpdateProgressBar(100)
return

;Scenario merged from: Scenarios\CycleWindows.ahk
/*
    Scenario: OpenDofusInstances
*/

SC029::
+SC029::
CycleWindows:
	;Header (auto-generated)
	Scenario := New API.Scenario(3,"CycleWindows")
	currentScenario := Scenario
	;End Header

    If GetKeyState("LShift")
        destWin := GetDestinationWindow(false)
    Else
        destWin := GetDestinationWindow(true)
    
    window := API.GetWindow(destWin)
    window.Activate()
return

GetDestinationWindow(ascend)
{
    If ascend 
        destWin := (API.CurrentWindow = API.GetNbWindows()) ? 1 : API.CurrentWindow + 1
    Else
        destWin := (API.CurrentWindow = 1) ? API.GetNbWindows() : API.CurrentWindow - 1
    return destWin
}

;Scenario merged from: Scenarios\LoginAccounts.ahk
/*
    Scenario: LoginAccounts
    Will perform one OCR scan to find account input. 
    If it fails, it tries to load from default values (TO DO)
*/

LoginAccounts:
	;Header (auto-generated)
	Scenario := New API.Scenario(4,"LoginAccounts")
	currentScenario := Scenario
	;End Header

    inputX := 0
    inputY := 0
    
    API.GuiUpdateProgressBar(0)
    Loop, % API.GetNbWindows() {
        window := API.GetWindow(A_Index)
        window.Activate()
        window.WaitActive()
        window.Maximize()
        Sleep, 50 * Settings.Speed
        If (A_Index = 1)
        {
            If (Settings.EnableOCR = True)
                Gosub, GetAccountInputPosition
            If (!inputX || !inputY || inputX = 0 || inputY = 0)
            {
                API.LogWrite("OCR failed or disabled. Trying to get account input position from default settings.", 1)

                section := A_ScreenWidth . "x" . A_ScreenHeight
                inputX := Scenario.GetValueFromIni(section, "x")
                inputY := Scenario.GetValueFromIni(section, "y")
                
                If (!inputX || !inputY)
                {
                    API.LogWrite("Couldn't load account input position from INI, stopping current scenario.", 2)
                    return
                }
                Else 
                    API.LogWrite("IniRead found input with position [" . inputX . "," . inputY . "].")
            }
            Else
            {
                API.LogWrite("OCR found match with position [" . inputX . "," . inputY . "].")
                inputY += 70 ; might not work for every resolution, to be tested!
            }
        }
        MouseMove, inputX, inputY, 5 * Settings.Speed
        Click
        Sleep, 50 * Settings.Speed
        SendRaw, % API.GetUsername(A_Index)
        Sleep, 50 * Settings.Speed
        Send, {Tab}
        Sleep, 50 * Settings.Speed
        SendRaw, % API.GetPassword(A_Index)
        Sleep, 50 * Settings.Speed
        Send, {Tab}
        Sleep, 50 * Settings.Speed
        Send {Enter}
        API.GuiUpdateProgressBar(A_Index, API.GetNbWindows())
        SleepHandler(0) ;handle sleep based on speed settings (parameter is for added sleep)
    }
    API.GuiUpdateProgressBar(100)
    return

GetAccountInputPosition:
    MouseMove, 0, 0
    Sleep 1000 * Settings.Speed
    API.SearchImageInWindow("account" . A_ScreenWidth . "x" . A_ScreenHeight . ".png", inputX, inputY)
    Sleep 1500 * Settings.Speed
    return

;Scenario merged from: Scenarios\OpenDofusInstances.ahk
/*
    Scenario: OpenDofusInstances
*/

OpenDofusInstances:
	;Header (auto-generated)
	Scenario := New API.Scenario(5,"OpenDofusInstances")
	currentScenario := Scenario
	;End Header

    API.GuiUpdateProgressText("Opening Dofus instances...")
    API.GuiUpdateProgressBar(0)

    API.ClearWindowList()
    nbAccounts := API.GetTotalAccounts()

    i := 1
    Loop % nbAccounts {
        If !ArrayAccounts[i].IsActive
            Continue
        Run, % Settings.DofusPath,,, pid
        window := API.NewWindow(pid)
        window.WaitOpen()
        window.SetTitle(ArrayAccounts[i])
        API.GuiUpdateProgressBar(i, nbAccounts)
        SleepHandler(0)
        i++
    }
    API.LogWrite("Successfully opened " . nbAccounts " windows.")
    API.GuiUpdateProgressBar(100)
    API.GuiUpdateProgressText("Done.")
    return

