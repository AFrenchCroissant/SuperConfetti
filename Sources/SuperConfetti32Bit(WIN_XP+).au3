
#include <AVIConstants.au3>
#include <GuiConstantsEx.au3>
#include <TreeViewConstants.au3>
#include <InetConstants.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Local Static $btnDl, $btnRefresh, $hyperlink
Global $guiReturn
Local Static $guiWidth = 250
Local Static $guiHeight = 250
Local Static $halfGuiWidth = $guiWidth /2
Local Static $halfGuiHeight = $guiHeight /2
Local Static $fourthGuiHeight = $guiHeight/4
Local Static $AboutGui, $MainGui
Local Static $btnClose = "11111"
Local Static $btnWebsite = "22222"

$MainGui = GUICreate("Super Confetti for Windows", $guiWidth, $guiHeight)
GUISetIcon(@ScriptDir & "\" & @ScriptName, 0);only display the icon when compiled

$idFileMenu = GUICtrlCreateMenu("File")
$idFileItemImg = GUICtrlCreateMenuItem("Open .GIF image", $idFileMenu)
$idFileItemSound = GUICtrlCreateMenuItem("Open .MP3, .WAV", $idFileMenu)
$idRecentFilesMenu = GUICtrlCreateMenu("Recent Files", $idFileMenu)
$idSeparator1 = GUICtrlCreateMenuItem("", $idFileMenu)
$idExitItem = GUICtrlCreateMenuItem("Exit", $idFileMenu)
$idDownloadMenu = GUICtrlCreateMenu("Download")
$idDlImageItem = GUICtrlCreateMenuItem("Download demo image", $idDownloadMenu)
$idDlMusicItem = GUICtrlCreateMenuItem("Download demo music", $idDownloadMenu)
$idControlMenu = GUICtrlCreateMenu("Control")
$idPlayItem = GUICtrlCreateMenuItem("Play", $idControlMenu)
$idStopItem = GUICtrlCreateMenuItem("Stop", $idControlMenu)
$idHelpMenu = GUICtrlCreateMenu("?")
$idAboutItem = GUICtrlCreateMenuItem("About", $idHelpMenu)

$sFile = "pickle.gif"
_ShowPic()
Func _ShowPic()
GUICtrlCreatePic($sFile, $halfGuiWidth - 64, $fourthGuiHeight - 25, 128, 128)
GUICtrlSetTip(-1, "Pickle :)")
EndFunc
$btnDl = GUICtrlCreateButton ( "Download image", $guiWidth - 230, $guiHeight -55, 100, 25)
GUICtrlSetTip(-1, "Download a 128x128 pixel image")
$btnRefresh = GUICtrlCreateButton ( "Refresh", $guiWidth - 115, $guiHeight -55, 100, 25)
GUICtrlSetTip(-1, "Refresh the GUI")

GUISetState(@SW_SHOW)
  While 1
    $guiReturn = GUIGetMsg(1)
    Select
     Case $guiReturn[0] = $GUI_EVENT_CLOSE
		 If $guiReturn[1] = $AboutGui Then
			   GUISwitch($AboutGui)
			   GUIDelete($AboutGui)
			ElseIf $guiReturn[1] = $MainGui Then
			   Exit
		 EndIf
     Case $guiReturn[0] = $btnDl
		 InetGet("https://i.ibb.co/C222Ttv/pickle.gif", @ScriptDir & "\pickle.gif", $INET_FORCERELOAD)
		 $sFile = "pickle.gif"
     Case $guiReturn[0] = $idDlImageItem
		 InetGet("https://i.ibb.co/C222Ttv/pickle.gif", @ScriptDir & "\pickle.gif", $INET_FORCERELOAD)
		 $sFile = "pickle.gif"
     Case $guiReturn[0] = $idDlMusicItem
		 InetGet("https://drive.google.com/u/0/uc?id=1q0Tri3RCf3R0LH5jcovfmOoroHottiSk&export=download", @ScriptDir & "\Wallpaper.mp3", $INET_FORCERELOAD)
		 $sFile = "Wallpaper.mp3"
		 SoundPlay ($sFile)
	 Case $guiReturn[0] = $btnRefresh
		 _ShowPic()
     Case $guiReturn[0] = $idFileItemImg
		 $sFile = FileOpenDialog("Choose image...", @UserProfileDir & "\Pictures", "GIF Image (*.gif*)")
		 If @error <> 1 Then GUICtrlCreateMenuItem($sFile, $idRecentFilesMenu)
	 Case $guiReturn[0] = $idFileItemSound
		 $sFile = FileOpenDialog("Choose music...", @UserProfileDir & "\Music", "Music(*.mp3*), (*.wav*)")
		 If @error <> 1 Then GUICtrlCreateMenuItem($sFile, $idRecentFilesMenu)
		 SoundPlay($sFile)
	 Case $guiReturn[0] = $idExitItem
		 Exit
	 Case $guiReturn[0] = $idPlayItem
		 SoundPlay("")
		 SoundPlay($sFile)
	 Case $guiReturn[0] = $idStopItem
		 SoundPlay("")
	 Case $guiReturn[0] = $idAboutItem
		 $AboutGui = GUICreate("About Super Confetti", 175, 200, -1, -1, -1, $WS_EX_TOOLWINDOW, $MainGui)
		 GUISetBkColor (0xD6D6D6, $AboutGui )
		 GUICtrlCreateLabel("Created By AFrenchCroissant", 21, 10)
		 GUICtrlCreateLabel("AutoIT version : " & @AutoItVersion, 30, 30)
		 GUICtrlCreateLabel("Super Conffetti v1.0 32Bit", 28, 50)
		 GUICtrlCreateLabel("for windows XP/Vista/7/8/8.1/10", 5, 70)
		 GUICtrlCreateLabel("Demo music by Kevin Mc Leod", 10, 90)
		 $btnWebsite = GUICtrlCreateButton ( "Website", 35, 130, 100, 25)
		 $btnClose = GUICtrlCreateButton ( "Close", 35, 165, 100, 25)
		 GUISetState(@SW_SHOW)
     Case $guiReturn[0] = $btnClose
		 GUISwitch($AboutGui)
		 GUIDelete($AboutGui)
	  Case $guiReturn[0] = $btnWebsite
		 ShellExecute("https://www.autoitscript.com")
    EndSelect
  WEnd
