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

    Loop % API.GetNbAccounts()
        API.CloseWindow(A_Index)
    API.LogWrite("Successfully closed " . API.GetNbAccounts() . " windows.")    
    API.ClearWindowList()
    API.GuiUpdateProgressText("Done.")
    API.GuiUpdateProgressBar(100)
return

;Scenario merged from: Scenarios\ConnectPlayersOnServer.ahk
/*
    Scenario: ConnectPlayersOnServer
*/

ConnectPlayersOnServer:
	;Header (auto-generated)
	Scenario := New API.Scenario(2,"ConnectPlayersOnServer")
	currentScenario := Scenario
	;End Header

    API.GuiUpdateProgressBar(0)

    section := A_ScreenWidth . "x" . A_ScreenHeight
    i := 1
    Loop, % API.GetNbAccounts() {
        ;Skip unactive accounts
        If !ArrayAccounts[A_Index].IsActive
        {
            API.LogWrite("Skipping character #" A_Index ", marked as inactive.")
            Continue
        }
        API.LogWrite("Trying to connect character #" A_Index " on server slot " ArrayAccounts[A_Index].ServerSlot " and player slot " ArrayAccounts[A_Index].PlayerSlot ".")        
        ;Get value for server slot
        inputX := Scenario.GetValueFromIni(section, "x" ArrayAccounts[A_Index].ServerSlot)
        inputY := Scenario.GetValueFromIni(section, "y" ArrayAccounts[A_Index].ServerSlot)
        If (!inputX || !inputY)
        {
            API.LogWrite("Couldn't load server slot position from INI, stopping current scenario.", 2)
            MsgBox, 16, Error, Couldn't load server slot position from INI, stopping current scenario.
            return
        }

        window := API.GetWindow(i)
        window.Activate()
        window.WaitActive()

        ;Connect on server
        Sleep 50 * Settings.Speed
        MouseMove, inputX, inputY, 5 * Settings.Speed
        Click, 2
        Sleep 1500

        ;Get value for player slot
        If (ArrayAccounts[A_Index].ServerSlot != ArrayAccounts[A_Index].PlayerSlot)
        {
            inputX := Scenario.GetValueFromIni(section, "x" ArrayAccounts[A_Index].PlayerSlot)
            inputY := Scenario.GetValueFromIni(section, "y" ArrayAccounts[A_Index].PlayerSlot)
            If (inputX = -1 || inputY = -1)
            {
                API.LogWrite("Couldn't load player slot position from INI, stopping current scenario.", 2)
                MsgBox, 16, Error, Couldn't load player slot position from INI, stopping current scenario.
                return
            }
            MouseMove, inputX, inputY, 5 * Settings.Speed
        }

        ;Connect player
        Sleep 50 * Settings.Speed
        Click, 2
        API.GuiUpdateProgressBar(i, API.GetNbAccounts())
        i++
        Sleep 1500
    }

    API.LogWrite("Successfully connected " i - 1 " characters.")
    API.GuiUpdateProgressBar(100)
return

;Scenario merged from: Scenarios\CycleWindows.ahk
/*
    Scenario: OpenDofusInstances
*/

SC056::
+SC056::
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

    API.LogWrite("Dest window is number #" destWin " (hwnd " window.hwnd ")")
    window.Activate()
    API.CurrentWindow := destWin
return

GetDestinationWindow(ascend)
{
    If ascend
    {
        ;destWin := (API.CurrentWindow = API.GetNbActiveAccounts()) ? 1 : API.CurrentWindow + 1
        i := API.CurrentWindow + 1
        Loop, % API.GetNbAccounts()
        {
            If (i > API.GetNbAccounts())
                i := 1
            If ArrayAccounts[i].IsActive
            {
                ;msgbox, returning %i%
                return i
            }
            i++
        }
        ;If (API.GetWindow[API.CurrentWindow + 1].hwnd = "")
        ;    msgbox, empty
    }
    Else
        destWin := (API.CurrentWindow = 1) ? API.GetNbActiveAccounts() : API.CurrentWindow - 1
    return destWin
}

;Scenario merged from: Scenarios\LoginAccounts.ahk
/*
    Scenario: LoginAccounts
*/

LoginAccounts:
	;Header (auto-generated)
	Scenario := New API.Scenario(4,"LoginAccounts")
	currentScenario := Scenario
	;End Header

    inputX := 0
    inputY := 0
    API.GuiUpdateProgressBar(0)

    section := A_ScreenWidth . "x" . A_ScreenHeight
    inputX := Scenario.GetValueFromIni(section, "x")
    inputY := Scenario.GetValueFromIni(section, "y")
    If (!inputX || !inputY)
    {
        API.LogWrite("Couldn't load account input position from INI, stopping current scenario.", 2)
        MsgBox, 16, Error, Couldn't load account input position from INI, stopping current scenario.
        return
    }
    i := 1
    Loop, % API.GetNbAccounts() {
        ;Skip unactive accounts
        If !ArrayAccounts[A_Index].IsActive
        {
            API.LogWrite("Skipping account #" A_Index ", marked as inactive.")
            i++
            Continue
        }
        If (Settings.WaitForAnkamaShield = True)
            MsgBox, % Translate("UnlockShield", API.GetUsername(A_Index))
        API.LogWrite("Trying to connect account #" A_Index ".")
        window := API.GetWindow(i)
        window.Activate()
        window.WaitActive()
        window.Maximize()
        Sleep, 50 * Settings.Speed
        MouseMove, inputX, inputY, 5 * Settings.Speed
        Click
        Sleep, 50 * Settings.Speed
        Send, ^a
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
        API.GuiUpdateProgressBar(i, API.GetNbAccounts())
        i++
        SleepHandler(0) ;handle sleep based on speed settings (parameter is for added sleep)
    }
    API.GuiUpdateProgressBar(100)
    return

;Scenario merged from: Scenarios\MoveAllPlayers.ahk
/*
    Scenario: MoveAllPlayers
*/

^SC056::
MoveAllPlayers:
	;Header (auto-generated)
	Scenario := New API.Scenario(5,"MoveAllPlayers")
	currentScenario := Scenario
	;End Header

    API.GuiUpdateProgressBar(0)
    MouseGetPos, outputX, outputY
    nbWindow := API.GetNbAccounts()
    Loop, % nbWindow {
        window := API.GetWindow(A_Index)
        API.GuiUpdateProgressText("Moving player " A_Index ".")
        API.GuiUpdateProgressBar(A_Index, nbWindow)

        window.Activate()
        window.WaitActive()

        Click, outputX, outputY

        Sleep 250
    }
    
    window := API.GetWindow(1)
    window.Activate()
    window.WaitActive()
    
    API.LogWrite("Successfully moved " nbWindow " characters.")
    API.GuiUpdateProgressBar(100)
return

;Scenario merged from: Scenarios\OpenDofusInstances.ahk
/*
    Scenario: OpenDofusInstances
*/

OpenDofusInstances:
	;Header (auto-generated)
	Scenario := New API.Scenario(6,"OpenDofusInstances")
	currentScenario := Scenario
	;End Header

    API.GuiUpdateProgressBar(0, 3)
    API.GuiUpdateProgressText("Opening Dofus instances...")

    API.ClearWindowList()
    nbAccounts := API.GetNbAccounts()

    Loop % nbAccounts {
        If !ArrayAccounts[A_Index].IsActive
            Continue
        Run, % Settings.DofusPath
        API.GuiUpdateProgressBar(A_Index, nbAccounts)
        SleepHandler(0)
        sleep, 200 * Settings.Speed
        WinGet, window, ID, Dofus
        this_window := API.SaveWindow(window, A_Index)
        this_window.WaitOpen()
        this_window.SetTitle(ArrayAccounts[A_Index])
    }

    API.LogWrite("Successfully opened " . API.GetNbActiveAccounts() " windows.")
    API.GuiUpdateProgressBar(100)
    API.GuiUpdateProgressText("Done.")
    return

;Scenario merged from: Scenarios\Organize.ahk
/*
    Scenario: Reorganize windows according to initiative 
*/

Organize:
	;Header (auto-generated)
	Scenario := New API.Scenario(7,"Organize")
	currentScenario := Scenario
	;End Header

    tempAccounts := ArrayAccounts.Clone()
    orderedAccounts := []
    accountsToRemove := []
    
    ;Look for closed windows
    Loop % tempAccounts.Length() {
        API.LogWrite("tempAccounts[" A_Index "].Window.hwnd : " tempAccounts[A_Index].Window.hwnd)
        If Not WinExist("ahk_id " . tempAccounts[A_Index].Window.hwnd) {
            accountsToRemove.Push(A_Index)
        }
    }

    ;Supress closed account
    Loop % accountsToRemove.Length() {
        index := accountsToRemove[A_Index]
        API.LogWrite("Le fenetre du compte '" tempAccounts[index].Nickname "' a disparu, suppression dans la gestion de fenètre")
        tempAccounts.RemoveAt(index)
    }

    ;Selection sort by initiative
    While (tempAccounts.Length() != 0) {
        maxInitiativeIndex := -1
        Loop % tempAccounts.Length() {
            If (tempAccounts[A_Index].Initiative > tempAccounts[maxInitiativeIndex].Initiative) {
                maxInitiativeIndex := A_Index
            }
        }
        API.LogWrite("L'initiative la plus haute est celle du compte #" maxInitiativeIndex " :" tempAccounts[maxInitiativeIndex].Nickname)
        orderedAccounts.Push(tempAccounts[maxInitiativeIndex])
        tempAccounts.RemoveAt(maxInitiativeIndex)
    }
    
    ; Set new windows Title + debug
    API.LogWrite("L'initiative dans l'ordre :")
    Loop % orderedAccounts.Length() {
        API.LogWrite(A_Index ": " orderedAccounts[A_Index].Nickname)
        orderedAccounts[A_Index].Window.id := A_Index
        orderedAccounts[A_Index].Window.setTitle(orderedAccounts[A_Index], A_Index)
    }
    ArrayAccounts := orderedAccounts
return

