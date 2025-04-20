#tag Window
Begin Window wndAnimate
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   0
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   305
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   2053130239
   MenuBarVisible  =   True
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Animating Xojo, by Anthony G. Cyphers (GraffitiSuite.com)"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin AnimatedCanvas AnimatedCanvas1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AnimationEasing =   ""
      AnimationTime   =   2500
      AutoDeactivate  =   True
      Backdrop        =   0
      BackgroundColor =   &cFF000000
      BackgroundColorHover=   &c0000FF00
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   265
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   251
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PreserveTimes   =   False
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   20
      Transparent     =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   329
   End
   Begin CheckBox chkInterrupt
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Insert Interruption"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      State           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "Calibri"
      TextSize        =   12.0
      TextUnit        =   0
      Top             =   118
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   219
   End
   Begin GroupBox gbModals
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Test Modals"
      Enabled         =   True
      Height          =   135
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "Calibri"
      TextSize        =   12.0
      TextUnit        =   0
      Top             =   150
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   219
      Begin RadioButton radMenu
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "MenuItem"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "gbModals"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "Calibri"
         TextSize        =   12.0
         TextUnit        =   0
         Top             =   212
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   179
      End
      Begin RadioButton radModal
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Modal Window"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "gbModals"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "Calibri"
         TextSize        =   12.0
         TextUnit        =   0
         Top             =   244
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   179
      End
      Begin RadioButton radNone
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "None"
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "gbModals"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "Calibri"
         TextSize        =   12.0
         TextUnit        =   0
         Top             =   180
         Transparent     =   False
         Underline       =   False
         Value           =   True
         Visible         =   True
         Width           =   179
      End
   End
   Begin Label lblAnimSpeed
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Speed (ms)"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "Calibri"
      TextSize        =   12.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   84
   End
   Begin TextField fldSpeed
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   116
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   "#######"
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "2500"
      TextColor       =   &c00000000
      TextFont        =   "Calibri"
      TextSize        =   12.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   123
   End
   Begin CheckBox chkPreserve
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Preserve Times"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   "When True, subsequent clicks will finish in the remaining time of prior animation operations."
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      State           =   1
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "Calibri"
      TextSize        =   12.0
      TextUnit        =   0
      Top             =   86
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   True
      Width           =   219
   End
   Begin Label lblEasing
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Easing"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "Calibri"
      TextSize        =   12.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   84
   End
   Begin PopupMenu pmEasing
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Linear\r\nInQuad\r\nOutQuad\r\nInOutQuad\r\nInCubic\r\nOutCubic\r\nInOutCubic\r\nInElastic\r\nOutElastic\r\nInOutElastic"
      Italic          =   False
      Left            =   116
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "Calibri"
      TextSize        =   12.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   123
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub Interrupt()
		  app.SleepCurrentThread(AnimatedCanvas1.AnimationTime / 2)
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events AnimatedCanvas1
	#tag Event
		Sub BeforeAnimate()
		  '// In this version, we're going to test our animation's tolerance to a
		  '   couple of different scenarios. First, if something causes the main
		  '   event loop to pause, will our animation continue? Since we moved
		  '   our step calculation code inside the animation timer's action event
		  '   and use a lerp function, it will pick up where it should.
		  if chkInterrupt.Value then
		    xojo.Core.timer.CallLater(me.AnimationTime / 4, AddressOf interrupt)
		  end if
		  
		  '// Next, what happens if modals show while the animation is running?
		  '   This used to be a problem on Carbon where the main event loop would
		  '   pause while a modal element was shown, especially MenuItems.
		  '   This isn't a problem now, though, but we'll code in a test just to
		  '   prove it.
		  if radMenu.Value then
		    dim m as new MenuItem
		    m.Append(new MenuItem("Item 1"))
		    m.Append(new MenuItem("Item 2"))
		    dim mRet as MenuItem = m.PopUp
		    if not IsNull(mRet) then MsgBox("You selected " + mRet.Text)
		  elseif radModal.Value then
		    wndModal.ShowModalWithin(Self)
		  end if
		End Sub
	#tag EndEvent
	#tag Event
		Sub AfterAnimate()
		  MsgBox("Animation complete.")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events fldSpeed
	#tag Event
		Sub TextChange()
		  AnimatedCanvas1.AnimationTime = me.Text.Val
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events chkPreserve
	#tag Event
		Sub Action()
		  AnimatedCanvas1.PreserveTimes = me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events pmEasing
	#tag Event
		Sub Change()
		  AnimatedCanvas1.AnimationEasing = AnimatedCanvas.Easings(me.ListIndex)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
