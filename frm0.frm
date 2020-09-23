VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "cd tray open/close"
   ClientHeight    =   930
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3240
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   930
   ScaleWidth      =   3240
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "&Info"
      Height          =   615
      Left            =   1680
      TabIndex        =   2
      Top             =   120
      Width           =   1215
   End
   Begin VB.CommandButton cmdClose 
      Caption         =   "&Close"
      Height          =   615
      Left            =   240
      TabIndex        =   1
      Top             =   120
      Width           =   1215
   End
   Begin VB.CommandButton cmdOpen 
      Caption         =   "&Open"
      Height          =   615
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   1215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
frmAbout.Show
End Sub

Private Sub Form_Load()
SendMCIString "close all", False
cmdClose.Visible = False
If (App.PrevInstance = True) Then
    End
End If
fCDLoaded = False
If (SendMCIString("open cdaudio alias cd wait shareable", True) = False) Then
    End
End If
SendMCIString "set cd time format tmsf wait", True
End Sub

Private Sub Form_Unload(Cancel As Integer)
'Close all MCI devices opened by this program
SendMCIString "close all", False
End Sub
Private Function SendMCIString(cmd As String, fShowError As Boolean) As Boolean
Static rc As Long
Static errStr As String * 200

rc = mciSendString(cmd, 0, 0, hWnd)
If (fShowError And rc <> 0) Then
    mciGetErrorString rc, errStr, Len(errStr)
    MsgBox errStr
End If
SendMCIString = (rc = 0)
End Function
' Open the CD Tray
Private Sub cmdopen_Click()
SendMCIString "set cd door open", True
cmdClose.Visible = True
cmdClose.Default = True
End Sub
Private Sub cmdclose_click()
'Close the CD Tray
' This Sub will also show the "CLOSE"
'button instead of the "OPEN" button.
SendMCIString "set cd door closed", True
cmdClose.Visible = False
cmdClose.Default = False
cmdOpen.Default = True
End Sub
'**************************************
'CD Rom Open/Close
'by: heresy on july 28, 1999
'created with visual basic 6.0
'compatible with: unknown
'have fun. and once again: PLEASE help
'us figure out the multiple drive situation.
'----
'~heresy




