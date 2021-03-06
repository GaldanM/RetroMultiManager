/*
    Scenario: OpenDofusInstances
*/

Main:
    API.CheckCurrentWindow()
    destWin := (API.CurrentWindow = 1) ? API.GetNbLinkedWindows() : API.CurrentWindow - 1
    window := API.GetWindow(destWin)
    API.LogWrite("Dest window is number #" destWin " (hwnd " window.hwnd ")")
    window.Activate()
    API.CurrentWindow := destWin
return