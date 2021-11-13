> $4000 @org=$4000
> $4000 @start=$5B80
b $4000 Loading screen
D $4000 #UDGTABLE { #SCR(loading) | PSSST Loading Screen. } TABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$300,$20 Attributes

i $5B00

@ $5B00 replace=/#DIMENSIONS/Dimensions #EVAL(#PEEK(#PC + $01) * $08) pixels x #EVAL(#PEEK(#PC + $02), $0A, $02) pixels.
@ $5B00 expand=#DEF(#SPRITE(addr,attr) #UDGARRAY2,attr=$attr,scale=4,step=2,mask=1,flip=2;($addr)-($addr+$11)-$01-$10{0,($10-#PEEK($addr-1))*4,$10*4,#PEEK($addr-1)*4})
@ $5B00 expand=#DEF(#FONT(id) #EVAL($7B4A + $id * $08))

c $5B80 Game entry point
E $5B80 View the equivalent code in;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #TRANZAM$5B80 }
. LIST#
E $5B80 Later Ultimate games use more advanced decryption mechanisms;
. #LIST
. { #ATICATAC$5B80 }
. { #LUNARJETMAN$5B80 }
. LIST#
@ $5B80 label=GameEntry
  $5B80,$01 Disable interrupts.
  $5B81,$0B Copy #N$2114 bytes from #N$5EED to #N$5EEC.
  $5B8C,$03 Jump to #R$61C6.

b $5B8F

c $5CB0

g $5CB1

g $5E00 High Score
E $5E00 View the equivalent code in;
. #LIST
. { #COOKIE$5F09 }
. { #JETPAC$5CF0 }
. { #LUNARJETMAN$5E06 }
. { #PSSST$5E00 }
. LIST#
D $5E00 3-byte representation of the score.
@ $5E00 label=High_Score

g $5E03 Game Options
@ $5E03 label=GameOptions
D $5E03 #TABLE(default,centre,centre)
. { =h Byte | =h Binary | =h Option }
. { #N$00 | #EVAL($00, 2, 8) | 1UP Game + Keyboard }
. { #N$01 | #EVAL($01, 2, 8) | 2UP Game + Keyboard }
. { #N$02 | #EVAL($02, 2, 8) | 1UP Game + Kempston Joystick }
. { #N$03 | #EVAL($03, 2, 8) | 2UP Game + Kempston Joystick }
. TABLE#

g $5E04 Sound On/ Off
D $5E04 Either #N$00 or #N$01.
@ $5E04 label=Sound_Enable

g $5E05 1UP Score
D $5E05 3-byte representation of the score.
@ $5E05 label=1UP_Score
g $5E08 2UP Score
D $5E08 3-byte representation of the score.
@ $5E08 label=2UP_Score

g $5E0B Temporary Actor State
@ $5E0B label=Actor
  $5E0B,$01 Actor X position.
  $5E0C,$01 Actor Y position.
  $5E0D,$01 Actor movement direction.
  $5E0E,$01 Height in pixels.
  $5E0F,$01 Width in tiles.
  $5E10,$01 Current sprite height value.
  $5E11,$01 Sprite graphic data height value.
  $5E12,$01 Todo.
  $5E13,$01 Todo.
  $5E14,$01 Todo.
  $5E15,$01 Todo.

g $5E16 Current Bug ID
D $5E16 Values are #N$00 (no bug update?) up to the max number of bugs: #N$01 to #N$06.
.       Used by all bug update routines and in a few other places.
@ $5E16 label=CurrentBug_ID

g $5E17 Game Timer
D $5E17 16-bit counter starting at 0x0000 and counting +1 (each time a sprite is moved or redrawn), although sometimes
.       it will increment + #N$02. This continues until the whole game is over - for both 1 and 2 player games. Counter
.       loops around after reaching #N$FFFF.
@ $5E17 label=GameTimer
W $5E17,$02

g $5E19 Random Number
D $5E19 Value is calculated using the 16-bit game timer LSB value, which is used to fetch a byte from the ROM (between addresses #N$00 and #N$FF), then by adding the current #REGr.
@ $5E19 label=RandomNumber

g $5E1E Current Player
D $5E1E Either #N$00 for 1UP or #N$FF for 2UP.
@ $5E1E label=Current_Player

g $5E1F Last Frame
D $5E1F #HTML(Holds a copy of the last <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> counter.)
@ $5E1F label=LastFrame

g $5E20 Frame Updated
@ $5E20 label=FrameUpdated
D $5E20 Has the frame been updated? #N$00=No #N$01=Yes.

g $5E21 Menu Item Attribute
D $5E21 Current menu item colour attribute.
@ $5E21 label=Current_MenuAttr
B $5E21,$01

g $5E22 "Get Ready" Delay Counter
@ $5E22 label=PlayDelay_Counter

g $5E23
  $5E23,$0A,$01

g $5E37 Current Player Level
D $5E37 Note that level 1 is #N$00.
@ $5E37 label=CurrentPlayer_Level

g $5E38 Current Player Lives
D $5E38 Current players remaining lives.
@ $5E38 label=CurrentPlayer_Lives

g $5E39 2UP Level
@ $5E39 label=2UP_Level

g $5E3A 2UP Lives
@ $5E3A label=2UP_Lives
g $5E3B
g $5E3C

g $5E44

g $5E6C Robbie State
@ $5E6C label=State_Robbie_Active
  $5E6C,$01 Is Robbie dead #N$00, alive #N$01 or alive and carrying a can of pesticide #N$02?
@ $5E6D label=State_Robbie_Pos_X
  $5E6D,$01 X position.
@ $5E6E label=State_Robbie_Pos_Y
  $5E6E,$01 Y position.
@ $5E6F label=State_Robbie_Colour
  $5E6F,$01 Colour attribute.
  $5E70,$01
  $5E71,$01
  $5E72,$01
  $5E73,$01

g $5E74

g $5E77

g $5E8C Flower State
@ $5E8C label=State_Flower
  $5E8C,$01 Dunno.

g $5E94 Leaf Data
N $5E94 Leaf 1 data.
@ $5E94 label=Leaf_1_State
  $5E94,$01 Leaf "1" state.
. #TABLE(default,centre,centre) { =h Value | =h State }
. { #N$00 | Inactive }
. { #N$11 | Right-hand side }
. { #N$51 | Left-hand side }
. TABLE#
@ $5E95 label=Leaf_1_Pos_X
  $5E95,$01 Leaf "1" X position in pixels.
@ $5E96 label=Leaf_1_Pos_Y
  $5E96,$01 Leaf "1" Y position in pixels.
@ $5E97 label=Leaf_1_Colour
  $5E97,$01 Leaf "1" colour attribute.
  $5E98,$02 #N$00 or #N$01... Todo.
@ $5E9A label=Leaf_1_Frame
  $5E9A,$01 Leaf "1" frame ID.
  $5E9B,$01 Unused?

N $5E9C Leaf 2 data.
@ $5E9C label=Leaf_2_State
  $5E9C,$01 Leaf "2" state.
. #TABLE(default,centre,centre) { =h Value | =h State }
. { #N$00 | Inactive }
. { #N$11 | Right-hand side }
. { #N$51 | Left-hand side }
. TABLE#
@ $5E9D label=Leaf_2_Pos_X
  $5E9D,$01 Leaf "2" X position in pixels.
@ $5E9E label=Leaf_2_Pos_Y
  $5E9E,$01 Leaf "2" Y position in pixels.
@ $5E9F label=Leaf_2_Colour
  $5E9F,$01 Leaf "2" colour attribute.
  $5EA0,$02 #N$00 or #N$01... Todo.
@ $5EA2 label=Leaf_2_Frame
  $5EA2,$01 Leaf "2" frame ID.
  $5EA3,$01 Unused?

N $5EA4 Leaf 3 data.
@ $5EA4 label=Leaf_3_State
  $5EA4,$01 Leaf "3" state.
. #TABLE(default,centre,centre) { =h Value | =h State }
. { #N$00 | Inactive }
. { #N$11 | Right-hand side }
. { #N$51 | Left-hand side }
. TABLE#
@ $5EA5 label=Leaf_3_Pos_X
  $5EA5,$01 Leaf "3" X position.
@ $5EA6 label=Leaf_3_Pos_Y
  $5EA6,$01 Leaf "3" Y position.
@ $5EA7 label=Leaf_3_Colour
  $5EA7,$01 Leaf "3" colour attribute.
  $5EA8,$02 #N$00 or #N$01... Todo.
@ $5EAA label=Leaf_3_Frame
  $5EAA,$01 Leaf "3" frame ID.
  $5EAB,$01 Unused?

N $5EAC Leaf 4 data.
@ $5EAC label=Leaf_4_State
  $5EAC,$01 Leaf "4" state.
. #TABLE(default,centre,centre) { =h Value | =h State }
. { #N$00 | Inactive }
. { #N$11 | Right-hand side }
. { #N$51 | Left-hand side }
. TABLE#
@ $5EAD label=Leaf_4_Pos_X
  $5EAD,$01 Leaf "4" X position.
@ $5EAE label=Leaf_4_Pos_Y
  $5EAE,$01 Leaf "4" Y position.
@ $5EAF label=Leaf_4_Colour
  $5EAF,$01 Leaf "4" colour attribute.
  $5EB0,$02 #N$00 or #N$01... Todo.
@ $5EB2 label=Leaf_4_Frame
  $5EB2,$01 Leaf "4" frame ID.
  $5EB3,$01 Unused?

g $5EB4


t $5EF5 Copyright Messaging
@ $5EF5 label=Message_Copyright
  $5EF5,$21,h$01,c$01,$1E:$01 Attribute: #N(#PEEK(#PC)) + "© 1983 A.C.G. ALL RIGHTS RESERVED".

b $5F16

g $5F1E Default Robbie State
@ $5F1E label=DefaultState_Robbie
  $5F1E,$08,$01

g $5F26 Default Flower State
@ $5F26 label=DefaultState_Flower
  $5F26,$08,$01

g $5F2E
  $5F2E,$0A

g $5F38

c $5F40 Reset Flower/ Leaf states
@ $5F40 label=ResetFlowerLeaf
  $5F40,$0B Copy #N$08 bytes of data from #R$5F26 to #R$5E8C.
  $5F4B,$03 #REGhl=#R$5E94.
  $5F4E,$02 #REGb=#N$04 (leaf counter).
  $5F50,$03 Jump to #R$70D6 to set all leaf objects inactive.

c $5F53 Create Game Window
@ $5F53 label=CreateWindow
N $5F53 Blank the screen and write the banner.
  $5F53,$03 Set the border to black.
  $5F56,$03 Call #R$7447.
  $5F59,$03 Call #R$7439.
  $5F5C,$03 Call #R$7413.
N $5F5F Set the attributes for the 1UP lives graphic.
  $5F5F,$03 #REGhl=#N$5808 (attribute buffer).
  $5F62,$02 #REGa=#N$47.
  $5F64,$01 Write #REGa to #REGhl.
  $5F65,$01 Increment #REGhl by one.
  $5F66,$01 Write #REGa to #REGhl.
N $5F67 Set the attributes for the 2UP lives graphic.
  $5F67,$03 #REGhl=#N$5816 (attribute buffer).
  $5F6A,$01 Write #REGa to #REGhl.
  $5F6B,$01 Increment #REGhl by one.
  $5F6C,$01 Write #REGa to #REGhl.
N $5F6D Set the attributes for the score line (the whole line is INK:#N$46).
  $5F6D,$03 #REGhl=#N$5820 (attribute buffer).
  $5F70,$03 #REGbc=counter:#N$20, INK:#N$46.
@ $5F73 label=CreateWindow_Loop
  $5F73,$01 Write #N$46 to the attribute buffer.
  $5F74,$01 Move onto the next column.
  $5F75,$02 Decrease counter by one and loop back to #R$5F73 until counter is zero.
  $5F77,$03 Call #R$739D.
  $5F7A,$03 Call #R$73A5.
  $5F7D,$03 Jump to #R$73AD.

c $5F80 Initialise New Level
@ $5F80 label=LevelNew
  $5F80,$04 Increment #R$5E38 by one (for display purposes).
  $5F84,$03 Call #R$5FA0.
  $5F87,$03 Call #R$5F40.
  $5F8A,$03 Call #R$6176.
N $5F8D Initialise the level.
@ $5F8D label=LevelInit
  $5F8D,$03 Call #R$5F53.
  $5F90,$03 Call #R$602E.
  $5F93,$03 Call #R$5FB0.
  $5F96,$03 Call #R$7325.
  $5F99,$06 #HTML(Write <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> to #R$5E1F.)
  $5F9F,$01 Return.

c $5FA05E94
  $5FA0,$0B Copy #N$0A bytes of data from #R$5F2E to #R$5E23.
  $5FAB,$04 Reset #R$5E3C.
  $5FAF,$01 Return.

c $5FB0
  $5FB0,$02 #REGc=#N$01.
  $5FB2,$03 #REGde=#R$5E23.
  $5FB5,$02 #REGl=#N$08.
  $5FB7,$02 Stash #REGde and #REGbc on the stack.
  $5FB9,$03 Call #R$5FDE.
  $5FBC,$02 Restore #REGbc and #REGde from the stack.
  $5FC9,$02 Stash #REGde and #REGbc on the stack.
  $5FCB,$03 Call #R$5FDE.
  $5FCE,$02 Restore #REGbc and #REGde from the stack.
  $5FD7,$01 Return.

c $5FD8
  $5FD8,$02 Write #N$00 to #REGde.
  $5FDA,$03 #REGa=#R$5E3C.
  $5FDD,$01 Return.

c $5FDE
  $5FDF,$02,b$01 Keep only bits 3-7.
  $5FEA,$02,b$01 Keep only bits 1-5.
  $5FEC,$03 Create an offset in #REGde.
  $5FF0,$03 #REGhl=#R$601B.
W $601B,$04,$02

c $601F

c $602E Draw PlayArea
@ $602E label=DrawPlayArea
  $602E,$04 #HTML(Stash <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a> on the stack.)
  $6032,$06 #HTML(Write #R$76D6 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
N $6038 Create the left-hand wall.
  $6038,$03 #REGde=#R$6087.
  $603B,$03 #REGhl=#N$1800 (screen position).
  $603E,$02 #REGb=#N$14 (counter).
  $6040,$03 Call #R$6077.
N $6043 Create the right-hand wall.
  $6043,$03 #REGhl=#N$18F8 (screen position).
  $6046,$02 #REGb=#N$14 (counter).
  $6048,$03 Call #R$6077.
N $604B Create left-hand cubby-holes.
  $604B,$03 #REGde=#R$6089.
  $604E,$03 #REGhl=#N$1800 (screen position).
  $6051,$03 Call #R$601F.
N $6054 Create right-hand cubby-holes.
  $6054,$03 #REGhl=#N$18E8 (screen position).
  $6057,$03 Call #R$601F.
N $605A Create the floor.
  $605A,$03 #REGhl=#N$B800 (screen position).
  $605D,$03 #REGde=#R$608D.
  $6060,$02 #REGc=#N$10 (outer counter).
@ $6062 label=DrawPlayArea_FloorLoop
  $6062,$02 #REGb=#N$01 (inner counter).
  $6064,$03 Call #R$6077.
  $6067
  $606F,$03 Decrease #REGc by one and loop back to #R$6062 until it is zero.
  $6072,$04 #HTML(Restore <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a> from the stack, and write it back to #N$5C36.)
  $6076,$01 Return.
N $6077 Enables calling #R$73ED in a loop to reprint a UDG a given number of times using #REGc.
@ $6077 label=PrintString_Wrapper
  $6077,$03 Stash #REGhl, #REGde and #REGbc on the stack.
  $607A,$03 Call #R$73ED.
  $607D,$03 Restore #REGbc, #REGde and #REGhl from the stack.
  $6080,$04 Move onto the next .
  $6084,$02 Decrease counter by one and loop back to #R$6077 until counter is zero.
  $6086,$01 Return.
N $6087 Screen Data.
@ $6087 label=Message_Bricks_LR
B $6087,$02 Brick attribute + 1 x brick UDG ID #N$00+#N$80 (EOL).
@ $6089 label=Message_Bricks_Cubby
B $6089,$04 Brick attribute + 3 x brick UDG ID #N$00+#N$80 (EOL).
@ $608D label=Message_Floor
B $608D,$03 Floor attribute + UDG ID #N$01 + UDG ID #N$02+#N$80 (EOL).

c $6090 Player Turn Ends
@ $6090 label=Message_Eaten
T $6090,$1A,h$01,$18:$01 Attribute: #N(#PEEK(#PC)) + "YOUR PLANT HAS BEEN EATEN".
@ $60AA label=PlayerTurnEnds
  $60AA,$04 Reset #R$5E3C.
  $60AE,$08
  $60B8,$03 Call #R$5F53.
  $60BB,$03 #REGde=#R$6090.
  $60BE,$03 #REGhl=#N$7020.
  $60C1,$03 Call #R$610B.
  $60C4,$03 #REGhl=#R$5EB4.
  $60C7,$02 #REGb=#N$07.
  $60C9,$03 Call #R$70D6.
M $60CC,$07 If #R$5E03 says this is a 2UP game, jump to #R$60E0.
  $60CC,$03
  $60CF,$02,b$01
  $60D1,$02
N $60D3 Handle 1UP player.
@ $60D3 label=PlayerTurnEnds_1UP
  $60D3,$07 If 1UP is out of lives (using #R$5E38), jump to #R$6127.
  $60DA,$03 Call #R$5F8D.
  $60DD,$03 Jump to #R$6176.
N $60E0 Handle 2UP player.
@ $60E0 label=PlayerTurnEnds_2UP
  $60E0,$06 If #R$5E3A says this is a 1UP game, jump to #R$60D3.
  $60E6,$07 If 2UP is out of lives (using #R$5E38), jump to #R$611F.
  $60ED,$03 Call #R$613B.
  $60F0,$07 Change current player at #R$5E1E (flip bits between #N$00 and #N$FF).
  $60F7,$03 Call #R$5F8D.
  $60FA,$03 Jump to #R$6176.

c $60FD Game Over
@ $60FD label=GameOver1UP
N $60FD #HTML(Set up altering the "GAME OVER PLAYER <em>X</em>" message for 1UP.)
  $60FD,c,$02 #REGa="1" + #N$80 (escape character).
N $60FF Print the messaging and pause to show it for a period of time.
@ $60FF label=GameOver_Write
  $60FF,$03 Write ASCII player number to #R$6163(#N$6175).
  $6102,$03 Call #R$5F53.
  $6105,$03 #REGde=#R$6163.
  $6108,$03 #REGhl=#N$7038.
N $610B Print message and pause, also used by #R$5FB0 and #R$631E.
@ $610B label=GameOverPrint_Pause
  $610B,$03 Call #R$73ED.
N $610E Introduce a pause by counting down from #N$10000 four times.
  $610E,$02 #REGb=#N$04 (counter).
@ $6110 label=GameOverPause
  $6110,$03 #REGhl=#N$0000 (large counter).
@ $6113 label=GameOverPause_Loop
  $6113,$01 Decrease #REGhl by one.
  $6114,$04 Loop back to #R$6113 until #REGhl is zero.
  $6118,$02 Decrease counter by one and loop back to #R$6113 until counter is zero.
  $611A,$01 Return.
N $611B #HTML(Set up altering the "GAME OVER PLAYER <em>X</em>" message for 2UP.)
@ $611B label=GameOver2UP
  $611B,c,$02 #REGa="2" + #N$80 (escape character).
  $611D,$02 Jump to #R$60FF.

N $611F This controller simply returns on end. This is for when the game continues after the messaging.
@ $611F label=GameOver_Controller
  $611F,$06 If #R$5E1E is zero, jump to #R$6110.
  $6125,$02 Else, jump to #R$611B.

N $6127 This is a controller with a jump to #R$61EA to return to the game selection screen.
@ $6127 label=GameOver_ControllerRestart
  $6127,$03 Call #R$708F.
  $612A,$06 If #R$5E1E is not zero, jump to #R$6136.
  $6130,$03 Call #R$60FD.
@ $6133 label=GameOver_Restart
  $6133,$03 Jump to #R$61EA.
@ $6136 label=GameOver_Restart2UP
  $6136,$03 Call #R$611B.
  $6139,$02 Jump to #R$6133.

c $613B 1UP/ 2UP Swapper.
E $613B View the equivalent code in;
. #LIST
. { #COOKIE$6416 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #TRANZAM$0000 }
. LIST#
@ $613B label=ChangePlayer
N $613B This routine "swaps" the data between #REGde and #REGhl.
  $613B,$03 #REGhl=#R$5E37.
  $613E,$03 #REGde=#R$5E39.
  $6141,$02 #REGb=#N$02 (counter).
  $6143,$03 Call #R$6159.
  $6146,$03 #REGhl=#R$5E23.
  $6149,$03 #REGde=#R$5E2D.
  $614C,$02 #REGb=#N$0A.
  $614E,$03 Call #R$6159.
  $6151,$03 #REGhl=#R$5E44.
  $6154,$03 #REGde=#R$5E8C.
  $6157,$02 #REGb=#N$28.
N $6159 This looks complicated but it's just grabbing the data from #REGde, grabbing the data from #REGhl, and writing the others data to each one.
@ $6159 label=ChangePlayer_Loop
  $6159,$01 #REGa=#REGde.
  $615A,$01 #REGc=#REGhl.
  $615B,$01 Store #REGa at #REGhl.
  $615C,$02 Store #REGc at #REGde.
  $615E,$02 Increase both #REGhl and #REGde by one.
  $6160,$02 Decrease counter by one and loop back to #R$6159 until counter is zero.
  $6162,$01 Return.

t $6163 Game Over Message
@ $6163 label=Message_GameOver
  $6163,$13,h$01,$11:$01 "GAME OVER PLAYER X".

c $6176 Player Initialisation
@ $6176 label=PlayerInit
  $6176,$05 Write #N$15 to #R$5EE4.
  $617B,$0B Copy #N$08 bytes of data from #R$5F1E to #R$5E6C(Robbie_Object).
N $6186 Set default "begin play" delay period.
  $6186,$02 #REGa=#N$80 (delay counter).
  $6188,$07 If #R$5E03 says this is a 1UP game, jump to #R$6191.
  $618F,$02 Else, #REGa=#N$FF for a two player game (to give more time for "passing over" the controls.
@ $6191 label=PlayerInit_WriteDelay
  $6191,$03 Write the delay counter to #R$5E22.
N $6194 "Spend" a life.
  $6194,$07 Decrease #R$5E38 by one.
  $619B,$03 Jump to #R$7325.

c $619E

c $61B4

c $61C6 Security Check
@ $61C6 label=SecurityCheck
E $61C6 Continue on to #R$61CD.
  $61C6,$01 Disable interrupts.
  $61C7,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $61CA,$03 Return if #REGa is not #N$65.

c $61CD Game Initialisation
E $61CD View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #COOKIE$6298 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$800A }
. { #TRANZAM$5F07 }
. LIST#
N $61CD Blank the 1UP, 2UP and HI scores.
@ $61CD label=GameInitialisation
  $61CD,$0A Write #N$00 to #N$0B bytes from #N$5E00 to #N$5E0B.
@ $61D3 label=GameInitialisation_Loop
N $61D7 #HTML(This calculates a "checksum" of the <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEPER</a> routine.
.       The expected value at the end is #N$00, and if #R$5E04 does not contain #N$00 then the game is muted.)
  $61D7,$03 #HTML(#REGhl=<a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEPER</a>.)
  $61DA,$02 #REGb=#N$43 (counter).
  $61DC,$01 #REGa=#N$00.
@ $61DD label=Mute_Loop
  $61DD,$01 Add the byte at #REGhl to #REGa.
  $61DE,$01 Increment #REGhl by one.
  $61DF,$02 Decrease counter by one and loop back to #R$61DD until counter is zero.
  $61E1,$02 #REGa=#REGa + #N$68.
  $61E3,$03 Store this number at #R$5E04.
  $61E6,$04 #HTML(Write #N$00 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C48.html">BORDCR</a>.)

@ $61EA label=Game_Restart
  $61EA,$01 Disable interrupts.
  $61EB,$03 Set the stack pointer to #N$5D00.
  $61EE,$03 Call #R$5F53.
@ $61F1 label=GameSelect_Loop
  $61F1,$03 Call #R$6250.
  $61F4,$04 #REGd=#R$5E03.
  $61F8,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $61FE,$01 Flip the bits.

N $61FF Handle 1UP selection.
  $61FF,$02 Has key "1" been pressed? ("1 PLAYER GAME").
  $6201,$02 If not jump to #R$6205.
  $6203,$02 Set player count = 1.
N $6205 Handle 2UP selection.
@ $6205 label=GameSelect_CheckP2
  $6205,$02 Has key "2" been pressed? ("2 PLAYER GAME").
  $6207,$02 If not jump to #R$620B.
  $6209,$02 Set player count = 2.
N $620B Handle Keyboard selection.
@ $620B label=GameSelect_CheckKeyboard
  $620B,$02 Has key "3" been pressed? ("KEYBOARD").
  $620D,$02 If not jump to #R$6211.
  $620F,$02 Set control method = keyboard.
N $6211 Handle Kempston Joystick selection.
@ $6211 label=GameSelect_CheckKempston
  $6211,$02 Has key "4" been pressed? ("KEMPSTON JOYSTICK").
  $6213,$02 If not jump to #R$6217.
  $6215,$02 Set control method = joystick.
N $6217 Handle starting a new game.
@ $6217 label=GameSelect_StartGame
  $6217,$02 Has key "5" been pressed? ("START GAME").
  $6219,$03 If so, jump to #R$632D.
N $621C Handle flashing each selection.
  $621C,$04 Write #REGd to #R$5E03.
  $6220,$03 #REGhl=#R$627D(GameSelection_Attributes).
  $6223,$04 #REGc=#R$5E03.
@ $6227 label=MenuAttributeCheckPlayer
  $6227,$04 If a 2UP game is selected, jump to #R$6238.
  $622B,$03 Else, call #R$6242.
N $622E Check control method.
@ $622E label=MenuAttributeCheckControl
  $622E,$04 If joystick is selected, jump to #R$623D.
  $6232,$03 Else, call #R$6242.
@ $6235 label=GameSelect_End
  $6235,$03 Jump back to #R$61F1.
N $6238 Handle flashing 2UP.
@ $6238 label=MenuAttrHandle2UP
  $6238,$03 Call #R$6249.
  $623B,$02 Jump to #R$622E.
N $623D Handle flashing joystick.
@ $623D label=MenuAttrHandleJoystick
  $623D,$03 Call #R$6249.
  $6240,$02 Jump to #R$6235.
  $6240,$02 Jump to #R$6235.
N $6242 Set the first menu item, unset the second.
@ $6242 label=MenuAttributeSetFirst
  $6242,$02 Set the FLASH attribute for the first selection.
  $6244,$01 Move onto the next menu attribute.
  $6245,$02 Unset the FLASH attribute for the second selection.
  $6247,$01 Move onto the next menu selection attribute.
  $6248,$01 Return.
N $6249 Unset the first menu item, set the second.
@ $6249 label=MenuAttributeSetSecond
  $6249,$02 Unset the FLASH attribute for the first selection.
  $624B,$01 Move onto the next menu attribute.
  $624C,$02 Set the FLASH attribute for the second selection.
  $624E,$01 Move onto the next menu selection attribute.
  $624F,$01 Return.

c $6250 Game Selection Menu
E $6250 View the equivalent code in;
. #LIST
. { #ATICATAC$7CAF }
. { #COOKIE$6332 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$80D1 }
. { #TRANZAM$0000 }
. LIST#
@ $6250 label=GameMenu
  $6250,$03 #REGde=#R$627C.
  $6253,$01 Switch to the shadow registers.
  $6254,$03 #REGhl'=#R$6282.
  $6257,$03 #REGde'=#R$6288.
N $625A There are six lines of text.
  $625A,$02 #REGb'=#N$06 (counter).
@ $625C label=GameMenu_Loop
  $625C,$01 Switch back to the normal registers.
  $625D,$04 Store the attribute byte to #R$5E21.
  $6261,$01 Increment #REGde by one.
  $6262,$01 Switch to the shadow registers.
  $6263,$01 Stash #REGbc' on the stack.
  $6264,$01 #REGa=#REGhl' (grab the position data).
  $6265,$01 Increment #REGhl' (position data pointer) by one.
  $6266,$01 Stash #REGhl' (position data pointer) on the stack.
  $6267,$03 #REGh'=#REGa and #REGl'=#N$38 (indentation).
  $626A,$03 Call #R$62E7.
  $626D,$01 Switch back to the normal registers.
  $626E,$02 Restore #REGhl and #REGbc from the stack.
  $6270,$01 Increase #REGde by one.
  $6271,$02 Decrease counter by one and loop back to #R$625C until counter is zero.
N $6273 Print the copyright footer.
  $6273,$03 #REGhl=#N$B800.
  $6276,$03 #REGde=#R$5EF5.
  $6279,$03 Jump to #R$73ED.

b $627C Game Select Attribute Table
E $627C View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #COOKIE$635E }
. { #JETPAC$628D }
. { #LUNARJETMAN$810E }
. { #TRANZAM$5FA7 }
. LIST#
@ $627C label=GameSelection_Attributes
  $627C,$06,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | Game Selection }
. { #N$02 | 1 Player Game }
. { #N$03 | 2 Player Game }
. { #N$04 | Keyboard }
. { #N$05 | Kempston Joystick }
. { #N$06 | Start Game }
. TABLE#

b $6282 Game Select Y Position Table
E $6282 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF1 }
. { #COOKIE$6365 }
. { #JETPAC$6293 }
. { #LUNARJETMAN$8115 }
. { #TRANZAM$5FAC }
. LIST#
@ $6282 label=GameSelection_Position
  $6282,$06,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | Game Selection }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | 1 Player Game }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | 2 Player Game }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | Keyboard }
. { #N$05 | #EVAL(#PEEK(#PC+$04) / $08) | Kempston Joystick }
. { #N$06 | #EVAL(#PEEK(#PC+$05) / $08) | Start Game }
. TABLE#

t $6288 Game Selection Screen Text
E $6288 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #COOKIE$636C }
. { #JETPAC$6299 }
. { #LUNARJETMAN$811C }
. { #TRANZAM$5FB1 }
. LIST#
@ $6288 label=GameSelection_Text
  $6288,$0E,$0D:$01 "GAME SELECTION".
  $6296,$11,$10:$01 "1   1 PLAYER GAME".
  $62A7,$11,$10:$01 "2   2 PLAYER GAME".
  $62B8,$0C,$0B:$01 "3   KEYBOARD".
  $62C4,$15,$14:$01 "4   KEMPSTON JOYSTICK".
  $62D9,$0E,$0D:$01 "5   START GAME".

c $62E7 Write Menu Line
E $62E7 View the equivalent code in;
. #LIST
. { #ATICATAC$7D8A }
. { #COOKIE$63E0 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #TRANZAM$0000 }
. LIST#
@ $62E7 label=MenuWriteText
  $62E7,$01 Stash #REGhl containing the co-ordinate on the stack.
  $62E8,$03 Call #R$759A.
  $62EB,$03 #REGa=the menu attribute byte from #R$5E21.
  $62EE,$01 Switch to the shadow #REGaf register.
  $62EF,$01 Switch to the shadow registers.
  $62F0,$01 Restore #REGhl from the stack.
  $62F1,$03 Call #R$748F.
  $62F4,$03 Jump to #R$73F9.

c $62F7 Reset Player Data
@ $62F7 label=ResetPlayerData
  $62F7,$02 #REGb=#N$02 (loop counter, max. 2 players).
@ $62F9 label=ResetPlayerData_Loop
  $62F9,$01 Stash #REGbc on the stack.
  $62FA,$04 Reset #R$5E37 to #N$00 (level 1).
  $62FE,$05 Set #R$5E38 to #N$04.
  $6303,$03 Call #R$5FA0.
  $6306,$03 Call #R$5F40.
  $6309,$03 Call #R$613B.
  $630C,$01 Restore #REGbc from the stack.
  $630D,$02 Decrease player counter by one and loop back to #R$62F9 until counter is zero.
N $630F 2UP has one "extra" life, due to the way the game "spends" a life when your turn starts.
  $630F,$05 Write #N$05 to #R$5E3A.
  $6314,$03 #REGa=#R$5E03.
  $6317,$02,b$01 Keep only bit 0 (1 or 2 players).
  $6319,$01 Return if this is a two player game.
  $631A,$03 Else, write #N$00 to #R$5E3A (2UP has no lives).
  $631D,$01 Return.

c $631E New Game
@ $631E label=Message_SprayBugs
T $631E,$0F,h$01,$0D:$01 "SPRAY THE BUGS"
E $631E View the equivalent code in;
. #LIST
. { #ATICATAC$7D9A }
. { #COOKIE$6428 }
. { #JETPAC$6333 }
. { #LUNARJETMAN$81BB }
. { #TRANZAM$5FEF }
. LIST#
N $632D Start New Game.
@ $632D label=GameStart
  $632D,$03 Call #R$5F53.
  $6330,$03 #REGhl=#N($7048, 4, 4).
  $6333,$03 #REGde=#R$631E.
  $6336,$03 Call #R$610B.
  $6339,$0D Write #N$00 to #N$E6 bytes from #R$5E05.
  $6346,$03 Call #R$62F7.
  $6349,$03 Call #R$7113.
  $634C,$03 Call #R$5F80.

  $634F,$03 #REGsp=#N$5D00.
  $6352,$01 Enable interrupts.
  $6353,$04 #REGix=#R$5E8C.
  $6357,$04 Write #N$00 to #R$5E16 to reset the enemy counter.
@ $635B label=MainLoop
  $635B,$07 #HTML(Compare <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> and #R$5E1F.)
N $6362 If interrupts are enabled, then #R$70ED will be called and DI executed.
  $6362,$04 If they are not equal call #R$70ED.
  $6366,$03 #REGhl=#R$7130(generate new actor routine).
  $6369,$01 Stash #REGhl on the stack.
  $636A,$03 #REGhl=#R$637E.
  $636D,$06,c$04,b$01 Calculate the jump table offset.
@ $6373 label=PerformJump
  $6373,$03 #REGbc=offset.
  $6376,$01 #REGhl=Jump table + offset.
  $6377,$04 #REGhl=Fetch the jump address.
  $637B,$03 Jump to #R$5CB0 which does an indirect jump to the jump address.

w $637E Main Jump Table
@ $637E label=JumpTable_Main

c $63AA Leaf Collision
@ $63AA label=LeafCollision
  $63AA,$03 #REGhl=#R$5E94.
  $63AD,$02 #REGb=#N$04 (leaf counter).
  $63AF,$03 #REGbc=#N$0008 (data offset).
@ $63B2 label=LeafCollision_Loop
  $63B2,$01 Stash #REGhl on the stack.
  $63B3,$04 If the current leaf is not active, jump to #R$63DC.
  $63B7,$02 #REGa=current leaf X position.
  $63B9,$03 Leaf X position - bug X Position.
  $63BC,$05 Make sure we have a positive byte.
@ $63C1 label=LeafCollision_Test_X
  $63C1,$04 Jump to #R$63DC if #REGa >= #N$0A.
  $63C5,$02 #REGa=current leaf Y position.
  $63C7,$03 Leaf Y position - bug Y Position.
  $63CA,$05 Make sure we have a positive byte.
@ $63CF label=LeafCollision_Test_Y
  $63CF,$04 Jump to #R$63DC if #REGa >= #N$0A.
  $63D3,$02 Increment #REGhl by two (skip colour attribute).
  $63D5,$05 Write #N$01 to todo and todo (being eaten?)
  $63DA,$01 Restore #REGhl from the stack.
  $63DB,$01 Return.
N $63DC Handles moving onto the next leaf object.
@ $63DC label=LeafCollision_Next
  $63DC,$01 Restore #REGhl from the stack.
  $63DD,$01 Add the data offset/ move onto the next leaf.
  $63DE,$02 Decrease counter by one and loop back to #R$63B2 until counter is zero.
  $63E0,$01 Return.

c $63E1 Play Music
@ $63E1 label=PlayMusic
R $63E1 DE Music Data
  $63E1,$01 Fetch the music data byte.
  $63E2,$03 Return if the terminator character has been reached.
  $63E5,$02,b$01 Keep only bits 0-3.
  $63E7,$01 Decrease #REGa by one.
  $63E8,$02 #REGa=#REGa * 2.
  $63EA,$03 Create an offset in #REGbc.
  $63ED,$04 #REGhl=#N$640D + offset.
  $63F1,$01 Stash #REGde on the stack.
  $63F2,$01
  $6402,$02 Stash #REGix on the stack.
  $6404,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEPER</a.)
  $6407,$03 Restore #REGix and #REGde from the stack.
  $640A,$01 Increment #REGde by one.
  $640B,$02 Loop back round to the #R$63E1(beginning) (we only end when the terminator is reached).
W $640D Music Data
@ $640D label=MusicData
B $641D

c $644D
  $644D,$02 #REGe=#N$00.
  $644F,$03 #REGhl=#R$5E8D.
  $6460,$02 Jump to #R$6464.
  $6472,$01 Return.

c $6473 Sound Effects
  $6473,$02 #REGc=#N$0F.
  $6479,$02,b$01 Keep only bits 0-2.
  $647E,$03 Call #R$64AA.
  $6484,$01 Return.

  $6497,$03 Call #R$64AA.
  $649D,$01 Return.

  $64A3,$03 Call #R$64AA.

c $64AA Play square wave sound
@ $64AA label=PlaySquareWave
R $64AA D Duration of wave
  $64AA,$04 #REGa=#N$10 (speaker on = bit 4).
  $64AE,$03 Decrease duration by one and loop back to #R$64AF until counter is zero.
@ $64AF label=PlaySquareWave_Loop
  $64B1,$03 Speaker off.
  $64B4,$03 Decrease duration by one and loop back to #R$64B5 until counter is zero.
@ $64B5 label=Silence_Loop
  $64B7,$01 Return.

c $64B8

  $64C2,$03 Call #R$64AA.
  $64C8,$01 Return.

  $64CF,$03 Call #R$64AA.
  $64D5,$01 Return.

  $64E0,$03 Call #R$64AA.
  $64E6,$01 Return.

c $64ED
  $64ED,$03 #REGhl=#R$5E16.
  $64F0,$01 Increment #R$5E16 by one.
  $64F1,$03 Call #R$75B9.
  $64F4,$03 Call #R$63AA.
  $64F7,$03 Jump to #R$72F5.

c $64FA

c $65F7 Animate Explosion
@ $65F7 label=AnimateExplosion
R $65F7 IX Explosion animation object
  $65F7,$03 #REGhl=#R$5E16.
  $65FA,$01 Increment #R$5E16 by one.
  $65FB,$03 #REGc=explosion animation frame.
  $65FE,$03 #REGb=explosion animation state.
  $6601,$03 #REGa=#R$5E17.
  $6604,$06 Increment frame if timer & state are both zero.
@ $660A label=ExplosionFetchSpriteFrame
  $660A,$01 #REGa=current explosion animation frame.
  $660B,$04 Create an offset using the animation frame ID.
  $660F,$03 #REGhl=#R$6682.
  $6612,$01 #REGhl=#REGhl + offset.
  $6613,$03 #REGde=fetch sprite frame address from #REGhl.
  $6616,$03 #REGhl=X/Y co-ordinates of the exploding actor.
  $661C,$04 If the current frame >= #N$06 then the animation has finished.
  $6620,$04 If the current frame >= #N$03 then we're halfway done.
  $6624,$03 Call #R$751C.
  $6627,$03 #REGa=#R$5E19.
  $662A,$02,b$01 Keep only bits 0-2.
  $662C,$02,b$01 Set bits 1 and 6 (BRIGHT).
  $662E,$03 Update with a random colour
  $6631,$03 Jump to #R$7450.
N $6634 After an explosion, we check if it was the player that died!
@ $6634 label=AnimateExplosion_End
  $6634,$06 Update anim object so "animating" = "direction".
  $663A,$03 Call #R$75B9.
  $663D,$03 Call #R$7526.
  $6647,$02,b$01 Keep only bits 0-5.
  $6651,$03 #REGhl=#R$5E23.
  $6654,$03 #REGbc=#R$5E2D.
  $6657,$03 #REGa=#R$5E19.
  $665A,$02,b$01 Keep only bits 0-2.

  $666C,$03 #REGhl=#R$5E23.
  $666F,$02 Jump to #R$6660.
  $6671,$03 #REGa=#R$5E77.
  $6674,$02,b$01 Keep only bits 0-2.
  $6676,$02,b$01 Set bit 3.
  $6678,$01 Stash the result at the address held by #REGhl.
  $6679,$03 Jump to #R$60AA.
  $667C,$03 Call #R$74AB.
  $667F,$03 Jump to #R$7529.

w $6682 Explosion lookup table
D $6682 Sprite addresses are repeated because on first use they are animated using a pink colour, then animated again in black, so as to make them disappear.
@ $6682 label=ExplosionLookupTable
  $6682,$02 Small explosion.
  $6684,$02 Medium explosion.
  $6686,$02 Large explosion.
L $6682,$06,$02

c $668E
c $66A6
  $66A6,$03 Call #R$75B9.
  $66A9,$06 Jump to #R$66D6 if #R$5E22 is not yet finished.
  $66AF,$03 #REGa=#R$5E17.
  $66B2,$02,b$01 Keep only bits 0-2.
  $66B4,$02 Jump to #R$66D6 if the result is non-zero.
  $66B6,$03 Call #R$6791.
  $66B9,$03 Call #R$74A8.
  $66CC,$03 Call #R$6791.
  $66CF,$03 Call #R$74C0.
  $66D3,$03 Call #R$74F2.
  $66D6,$01 Return.

c $66D7
  $66D7,$03 #REGhl=#R$5E6C.
  $66DA,$02 #REGb=#N$10.
  $66DC,$03 Call #R$70D6.
  $66DF,$06 #R$5E04.
  $66EB,$02,b$01 Keep only bits 0-2.
  $66EF,$03 #REGde=#R$641D.
  $66F2,$03 #REGhl=#R$5E38.
  $66F6,$03 Call #R$63E1.
  $66FD,$03 Jump to #R$5F80.
  $6700,$03 #REGde=#R$642D.
  $6703,$02 Jump to #R$66F6.

c $670E Colourise Open Flower
@ $670E label=ColouriseFlower
  $671D,$03 #REGde=#R$6748.
  $6720,$03 #REGbc=#N$0907.
  $672B,$02,b$01 Keep only bits 0-1.
  $673E,$01 Return.
@ $6748 label=FlowerAttributes
B $6748,$3F,$09

c $6787
B $6787
  $6791

c $679C

c $67AE
c $698F
c $69E8

c $6A98
  $6A98,$03 Call #R$64ED.
  $6A9B,$01 Decrease #REGe by one.
  $6A9C,$03 Jump to #R$6A73 if #REGe is zero.
  $6A9F,$03 Call #R$6A42.
  $6AB8,$06 If the stunned slug timer is zero, jump to #R$6AC3.
  $6ABE,$03 Decrease the stunned slug timer by one.
  $6AC1,$02 Jump to #R$6AF9.

  $6AC3

c $6A73
  $6A73,$03 Call #R$65DC.
  $6A76,$02 Stash #REGix on the stack.
  $6A78,$04 #REGix=#R$5EE4.
  $6A7C,$04 #REGc=#R$5E6C.
  $6A80,$02 #REGa=#R$5E6D.
  $6A85,$02 #REGa=#R$5E6E.
  $6A8A,$01 #REGa=#R$5E6C.
  $6A8B,$03 Call #R$65F1.
  $6A8E,$02 Restore #REGix from the stack.
  $6A90,$07 Write #N$00 to #R$5E6C and #R$5E74.
  $6A97,$01 Return.

c $6BD0

c $6C53
  $6C53,$03 Call #R$75B9.
  $6C76,$02,b$01 Keep only bits 0-2.
  $6C7A,$03 Call #R$6CC7.
  $6C7D,$03 Call #R$74A8.
  $6C8F,$03 Call #R$6CC7.
  $6C92,$03 Call #R$74C0.
  $6C99,$03 Jump to #R$7450.
  $6C9C,$03 #REGa=#R$5E17.
  $6C9F,$02,b$01 Keep only bits 0-1.
  $6CA3,$03 Call #R$6CC7.
  $6CA6,$03 Call #R$74A8.
  $6CB3,$03 Call #R$6CC7.
  $6CB6,$03 Call #R$6A3A.
  $6CBD,$01 Return.
  $6CBE,$03 Call #R$6CC7.
  $6CC1,$03 Call #R$751C.
  $6CC4,$03 Jump to #R$7450.

c $6CC7
  $6CD6,$03 #REGhl=#R$6CE1.
  $6CE0,$01 Return.
B $6CE1

c $6CF1

c $6D0C
  $6D0C,$03 Call #R$75B9.
  $6D0F,$03 #REGde=#R$769A.
  $6D12,$06 If #R$5E6C is not active, jump to #R$6D07.
  $6D18,$06 #R$5E22
  $6D1E,$03 #REGa=#R$5E3B.

c $6D9C Read Player Input
@ $6D9C label=ReadInput
  $6D9C,$08 Jump to #R$75CC if #R$5E03 is set to joystick controls.
N $6DA4 Read keyboard input.
  $6DA4,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { $FB | Q | W | E | R | T }
. TABLE#
N $6DAA Convert the bits into game compatible bits (as in, see #R$75CC - as this is what is being matched).
  $6DAA,$01 Store the original result in #REGc.
  $6DAB,$01 Rotate the bits right once.
  $6DAC,$02,b$01 Keep only bit 0.
  $6DAE,$01 Store the result in #REGe.
  $6DAF,$01 Restore the original result to #REGa.
  $6DB0,$01 Rotate the bits left once.
  $6DB1,$02,b$01 Keep only bit 1.
  $6DB3,$01 Set the bits already processed from #REGe.
  $6DB4,$01 Store the result in #REGe.
  $6DB5,$01 Restore the original result to #REGa.
  $6DB6,$02,b$01 Keep only bits 2-4.
  $6DB8,$01 Set the bits already processed from #REGe.
  $6DB9,$01 Return.

c $6DBA
c $6ED2
c $6EF1

c $70D1
@ $70D1 label=Reset
  $70D1,$03 #REGhl=#R$5E94.
  $70D4,$02 #REGb=#N$0B.

c $70D6 Set Objects Inactive
R $70D6 B Loop counter
R $70D6 HL Object to be updated
@ $70D6 label=SetObjectInactive
  $70D6,$03 Increment value.
@ $70D9 label=SetObjectInactive_Loop
  $70D9,$02 Reset first byte of object.
  $70DB,$01 Set #REGhl to beginning of next object.
  $70DC,$02 Decrease counter by one and loop back to #R$70D9 until counter is zero.
  $70DE,$01 Return.

c $70DF Limit Frame Rate
E $70DF View the equivalent code in;
. #LIST
. { #JETPAC$691B }
. LIST#
@ $70DF label=LimitFrameRate
  $70DF,$05 Return if #R$5E20 is not marked as being updated.
  $70E4,$03 Introduce a counter for a slight pause.
@ $70E7 label=LimitFrameRate_Loop
  $70E7,$01 Decrease counter by one.
  $70E8,$04 Keep looping back to #R$70E7 until the counter is zero.
  $70EC,$01 Return.

c $70ED Frame Update
@ $70ED label=FrameUpdate
  $70ED,$01 Disable interrupts.
  $70EE,$06 #HTML(Update #R$5E1F with <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $70F4,$05 Set #R$5E20 as "being updated" (i.e. #N$01).
  $70F9,$02 Stash #REGix on the stack.
  $70FB,$06 Write #R$5E8C to #R$713C(#N$713D).
  $7101,$0B #HTML(Write #N$C3 to #R$714F and #R$7125 to #R$714F(#N$7150), i.e. <code>JP #R$7125</code>).
  $710C,$04 #REGix=#R$5E6C.
  $7110,$03 Jump to #R$635B.

c $7113 Reset Modified Code
@ $7113 label=ResetModifiedCode
  $7113,$06 Write #R$5EEC to #R$713C(#N$713D).
  $7119,$05 Write #N$2A to #R$714F.
  $711E,$06 Write #R$5E17 to #R$714F(#N$7150).
  $7124,$01 Return.

c $7125 Reset Modified Code In Frame
@ $7125 label=ResetModifiedInFrame
  $7125,$03 Call #R$7113.
  $7128,$02 Restore jump table address, saved during frame update.
  $712A,$04 Set #R$5E20 as "not updated" (i.e. #N$00).
  $712E,$01 Enable interrupts.
  $712F,$01 Return.

c $7130 New Actor
@ $7130 label=NewActor
R $7130 IX Item object
  $7130,$04 Increment #R$5E19 by one.
  $7134,$03 Set offset.
  $7137,$02 Set #REGix to next group of bytes.
  $7139,$03 Copy #REGix to #REGhl using the stack.
N $713C The self-modifying code routines change the address here to be either;
. #TABLE(default,centre,centre)
. { =h Altering Routine | =h Alteration }
. { #R$7113 | #N$5EEC }
. TABLE#
  $713C,$03 #REGbc=#R$5EEC.
  $713F,$01 Clear the carry flag
  $7140,$05

@ $7145 label=Pause_Loop
N $7145 Holding "SHIFT" pauses the game.
  $7145,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $714B,$02 Has the "SHIFT" key been pressed?
  $714D,$02 If it has then jump to #R$7145.
  $714F,$03 #REGhl=#R$5E17(see #R$711E).
  $7152,$01

c $721A
  $721A,$04 #REGix=#R$5E3C.
  $721E,$03 Call #R$75B9.
  $7230,$03 Call #R$74EB.
  $7233,$03 Call #R$7450.
  $7236,$03 #REGa=#R$5E17.
  $7239,$02,b$01 Keep only bits 0-1.
  $7241,$02,b$01 Unset bit 2.
  $7246,$03 Jump to #R$634F.

c $7249

c $7262
  $7262,$01 Stash #REGhl on the stack.
  $7263,$01 Switch #REGde and #REGhl.
  $7264,$08 Copy #N$0008 bytes of data from #R$5F16 to #REGde.
  $726C,$02 Restore #REGix from the stack (the old value in #REGhl).
  $726E,$03 #REGa=#R$5E13.
  $7280,$02,b$01 Keep only bits 5-7.
  $7287,$03 #REGa=#R$5E37.
  $729C,$02,b$01 Keep only bits 0-1.

  $72A5,$03 #REGhl=#R$72E9.
  $72AE,$03 #REGa=#R$5E19.
  $72BC,$03 #REGhl=#R$5E6E.
  $72C9,$03 Jump to #R$71BE.
  $72D6,$02,b$01 Keep only bit 0.
  $72DC,$02,b$01 Keep only bit 0.
  $72E3,$02,b$01 Keep only bit 0.
  $72E7,$02 Jump to #R$729C.
N $72CC Who knows.
B $72E9,$0C,$03

c $72F5 Bug Collision
@ $72F5 label=BugCollision
R $72F5 IX Bug object
R $72F5 O:E #N$00 no collision
R $72F5 O:E #N$01 collision
  $72F5,$03 #REGhl=#R$5E6C.
  $72F8,$02 #REGe=Default value #N$00 (no collision).
  $72FA,$01 #REGa=#R$5E6C.
  $72FB,$02,b$01 Keep only bits 0-5.
  $72FD,$01 Decrease #REGa by one.
  $72FE,$02 If #REGa is zero then jump to #R$7302.
  $7300,$02
@ $7302 label=BugCollision_X
  $7302,$02 #REGa=#R$5E6D.
  $7304,$03 Robbie X position - bug X Position.
  $7307,$05 Make sure we have a positive byte.
@ $730C label=BugCollision_Test_X
  $730C,$03 Return if #REGa >= #N$10.
  $730F,$02 #REGa=#R$5E6E.
  $7311,$03 Robbie Y position - bug Y position.
  $7314,$05 Set #REGd to #N$12 if it's a positive number.
  $7319,$03 #REGd=bug sprite height.
  $731C,$02 Jump to #R$7320.
@ $731E label=BugCollision_SetHeight
  $731E,$02 #REGd=#N$12.
@ $7320 label=BugCollision_Test_Y
  $7320,$02 Return if #REGd >= #REGa.
N $7322 A collision has been detected.
  $7322,$02 #REGe=#N$01.
  $7324,$01 Return.

c $7325 Display Lives
@ $7325 label=DisplayPlayerLives
  $7325,$06 Call #R$759A with #N($0040, 4, 4) for 1UP lives.
  $732B,$03 Call #R$7364.
  $732E,$03 Display an empty space if no lives are remaining.
  $7331,$03 Call #R$7340.
@ $7334 label=DisplayPlayerLives_2UP
  $7334,$06 Call #R$759A with #N($00B0, 4, 4) for 2UP lives.
  $733A,$03 Call #R$7372.
  $733D,$03 Display an empty space if no lives are remaining.
@ $7340 label=DisplayPlayerLives_Print
  $7340,$02 Add #N$30 to convert to an ASCII character (starting at 0 character).
  $7342,$03 Call #R$73CD.
  $7345,$03 #REGde=#R$735C.
  $7348,$02 Stash #REGbc and #REGde on the stack.
  $734A,$03 Jump to #R$73DD.
  $734D,$03 Call #R$7352.
  $7350,$02 Jump to #R$7334.
  $7352,$02 #REGa=ASCII " " (SPACE).
  $7354,$03 Call #R$73CD.
  $7357,$02 #REGa=ASCII " " (SPACE).
  $7359,$03 Jump to #R$73CD.
@ $735C label=UDG_Life
B $735C,$08,b$01 #UDG(#PC)

N $7364 Check which player is current in a one player game.
@ $7364 label=ReturnLives_1UPController
  $7364,$06 If #R$5E1E is 2UP, jump to #R$736E.
N $736A Handle 1UP.
@ $736A label=ReturnLives_1UP
  $736A,$03 #REGa=#R$5E38.
  $736D,$01 Return.
N $736E Handle 2UP.
@ $736E label=ReturnLives_2UP
  $736E,$03 #REGa=#R$5E3A.
  $7371,$01 Return.
N $7372 Check which player is current in a two player game.
@ $7372 label=ReturnLives_2UPController
  $7372,$06 If #R$5E1E is 1UP, jump to #R$736E.
  $7378,$02 Else, it's 2UP so jump to #R$736A.

c $737A

c $739D Print Scores
E $739D View the equivalent code in;
. #LIST
. { #COOKIE$7438 }
. { #JETPAC$711C }
. { #LUNARJETMAN$89BF }
. { #TRANZAM$6CB6 }
. LIST#
@ $739D label=Score_1UP
N $739D Sets up the 1UP score.
  $739D,$03 #REGhl=#N$4021 (screen buffer address).
  $73A0,$03 #REGde=#R$5E05.
  $73A3,$02 Jump to #R$73B3.

N $73A5 Sets up the 2UP score.
@ $73A5 label=Score_2UP
  $73A5,$03 #REGhl=#N$4039 (screen buffer address).
  $73A8,$03 #REGde=#R$5E08.
  $73AB,$02 Jump to #R$73B3.

N $73AD Sets up the HI score.
@ $73AD label=Score_HI
  $73AD,$03 #REGhl=#N$402D (screen buffer address).
  $73B0,$03 #REGde=#R$5E00.

N $73B3 Prints the score.
@ $73B3 label=PrintScore
  $73B3,$02 #REGb=#N$03.
@ $73B5 label=PrintScore_Loop
  $73B5,$01 #REGa=#REGde.
  $73B6,$04 #REGa=#REGa / #N$10.
  $73BA,$02,b$01 Keep only bits 0-3.
  $73BC,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $73BE,$03 Call #R$73CD.
  $73C1,$01 #REGa=#REGde.
  $73C2,$02,b$01 Keep only bits 0-3.
  $73C4,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $73C6,$03 Call #R$73CD.
  $73C9,$01 Increment #REGde by one.
  $73CA,$02 Decrease counter by one and loop back to #R$73B5 until counter is zero.
  $73CC,$01 Return.

c $73CD Print Character
E $73CD View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #TRANZAM$6C96 }
. LIST#
@ $73CD label=PrintScreen
R $73CD A ASCII value to print
R $73CD HL Screen address
  $73CD,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $73D0,$03 Create an offset in #REGhl.
  $73D3,$03 #REGhl=#REGhl * 8.
  $73D6,$04 #HTML(#REGde=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $73DA,$02 #REGde=#REGhl + #N$3C00. For examples of usage;
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Letter | =h ASCII Value | =h * 8 (offset) | =h CHARS + offset }
. #FOREACH($55,$4C,$54,$49,$4D,$41,$54,$45)(value,
. { #LET(result=$3C00 + value * $08) "#CHR(value)" | #N(value) | #N(value * 8) | #HTML(<a href="https://skoolkid.github.io/rom/asm/3D00.html##N({result}, 2, 3, 1, 1)()">#N({result})) }
. )
. TABLE#
N $73DC Print the character to the screen.
  $73DC,$01 Restore #REGhl, containing the screen buffer location, from the stack.
  $73DD,$02 #REGb=#N$08 (#N$08 rows of pixels).
@ $73DF label=PrintScreen_Loop
  $73DF,$02 Copy a byte from the font data to the screen buffer.
  $73E1,$01 Increment the font data by one.
  $73E2,$01 Move onto the next pixel line.
  $73E3,$02 Decrease counter by one and loop back to #R$73DF until counter is zero.
  $73E5,$02 Restore #REGde and #REGbc from the stack.
N $73E7 Reset #REGhl and move to the next column, ready to print the next character.
  $73E7,$04 #REGh=#REGh - #N$08 (reset the display line).
  $73EB,$01 Increment screen column by one.
  $73EC,$01 Return.

c $73ED Print String
@ $73ED label=PrintString
R $73ED DE Pointer to string data
  $73ED,$01 Stash #REGhl on the stack.
  $73EE,$03 Call #R$759A.
  $73F1,$01 Fetch the attribute byte.
  $73F2,$01 Switch to the shadow #REGaf register.
  $73F3,$01 Increment #REGde by one to point to the text of the string.
  $73F4,$01 Switch to the shadow registers.
  $73F5,$01 Restore #REGhl' from the stack.
  $73F6,$03 Call #R$748F.

@ $73F9 label=PrintString_Loop
  $73F9,$01 Switch back to the normal registers.
  $73FA,$01 Fetch the character to print.
  $73FB,$04 If bit 7 is set (which signifies the end of the string), jump to #R$740A.
  $73FF,$03 Call #R$73CD.
  $7402,$01 Increment #REGde by one.
  $7403,$01 Switch to the shadow registers.
  $7404,$01 Switch to the shadow #REGaf register.
  $7405,$01 Copy the attribute byte to the screen.
  $7406,$01 Increment #REGl by one.
  $7407,$01 Switch to the shadow #REGaf register.
  $7408,$02 Jump to #R$73F9.
N $740A Because the last character contains the terminator, it needs to be handled separately.
@ $740A label=PrintString_LastCharacter
  $740A,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $740C,$03 Call #R$73CD.
  $740F,$01 Switch to the shadow registers.
  $7410,$01 Switch to the shadow #REGaf register.
  $7411,$01 Copy the attribute byte to the screen.
  $7412,$01 Return.

c $7413 Print Banner
E $74AE View the equivalent code in;
. #LIST
. { #COOKIE$74AE }
. { #JETPAC$7192 }
. { #LUNARJETMAN$8A37 }
. LIST#
@ $7413 label=PrintBanner
N $7413 Prints "1UP".
  $7413,$03 #REGhl=#N($0018, 4, 4).
  $7416,$03 #REGde=#R$742E.
  $7419,$03 Call #R$73ED.
N $741C Prints "HI".
  $741C,$03 #REGhl=#N($0078, 4, 4).
  $741F,$03 #REGde=#R$7436.
  $7422,$03 Call #R$73ED.
N $7425 Prints "2UP".
  $7425,$03 #REGhl=#N($00D8, 4, 4).
  $7428,$03 #REGde=#R$7432.
  $742B,$03 Jump to #R$73ED.
N $742E Banner text data.
@ $742E label=1UP_Text
T $742E,$04,h$01,$02:$01 "1UP" (#N(#PEEK(#PC)) is the attribute).
@ $7432 label=2UP_Text
T $7432,$04,h$01,$02:$01 "2UP" (#N(#PEEK(#PC)) is the attribute).
@ $7436 label=HI_Text
T $7436,$03,h$01,$01:$01 "HI" (#N(#PEEK(#PC)) is the attribute).

c $7439 Reset Screen Buffer
E $7439 View the equivalent code in;
. #LIST
. { #ATICATAC$80B4 }
. { #COOKIE$74D4 }
. { #JETPAC$71B8 }
. { #LUNARJETMAN$84AD }
. { #TRANZAM$7211 }
. LIST#
@ $7439 label=ResetScreen
E $7439 Continue on to #R$7440 to blank the screen buffer.
  $7439,$03 #REGhl=#R$4000(screen buffer).
  $743C,$02 #REGb=#N$58 (i.e. finish once we reach the start of #R$5800(attribute buffer)).
  $743E,$02 #REGc=#N$00 (value to write).

c $7440 Reset Routine
E $7440 View the equivalent code in;
. #LIST
. { #ATICATAC$80BB }
. { #COOKIE$74DB }
. { #JETPAC$71B8 }
. { #LUNARJETMAN$84B4 }
. { #TRANZAM$7218 }
. LIST#
R $7440 HL Target address
R $7440 B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $7440 C Value to write
@ $7440 label=ResetCopier
  $7440,$01 Write #REGc to the target address.
  $7441,$01 Increment the target address by one.
  $7442,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $7444,$02 Keep looping back to #R$7440 until there is no carry-over.
  $7446,$01 Return.

c $7447 Reset Attribute Buffer
E $7447 View the equivalent code in;
. #LIST
. { #ATICATAC$80C2 }
. { #COOKIE$74E2 }
. { #JETPAC$71C6 }
. { #LUNARJETMAN$84BB }
. { #TRANZAM$7200 }
. LIST#
@ $7447 label=ResetAttributes
  $7447,$03 #REGhl=#R$5800(attribute buffer).
  $744A,$02 #REGb=#N$5B (i.e. finish once we reach the end of the #R$5800(attribute buffer)).
  $744C,$02 #REGc=#N$00 (value to write).
  $744E,$02 Jump to #R$7440.

c $7450 Colourise sprite.
@ $7450 label=ColouriseSprite
  $7450,$01 Switch to the shadow registers.
  $7451,$03 #REGhl'=actor co-ordinates.
  $7454,$03 Call #R$748F - #REGhl' now holds the co-ordinates to an attribute file address.
  $7457,$04 #REGb'=width loop counter (in pixels).
  $745B,$03 #REGa=#R$5E0E.
  $745E,$04 #REGa=((#REGa / #N$04) + #N$01) / #N$02.
  $7462,$02,b$01 Keep only bits 0-4.
  $7464,$01 Increment #REGa by one.
  $7465,$01 #REGc=height loop counter (in pixels).
  $7466,$03 #REGd=object colour attribute.
  $7469,$01 #REGe=width loop counter (in pixels).
@ $746A label=ColouriseSprite_Loop1
  $746A,$01 Stash #REGhl on the stack.
@ $746B label=ColouriseSprite_Loop2
  $746B,$01 #REGa=actor Y position.
  $746C,$08 Decrement position if address is outside of attribute file address range.
  $7474,$01 Otherwise, set the colour at this location.
  $7475,$01 Next tile column.
  $7476,$05,b$01 Next tile if column < screen width (32 chars).
  $747B,$03 else, wrap-around and continue applying colour.
  $747E,$01 #REGl=start of current row.
  $747F,$02 Decrease counter by one and loop back to #R$746B until counter is zero.
  $7481,$01 Restore #REGhl from the stack.
  $7482,$01 Stash #REGbc on the stack.
  $7483,$01 Clear the carry flag.
  $7484,$05 #REGhl -= 32 tiles. Places address pointer previous line.
  $7489,$01 Restore #REGbc from the stack.
  $748A,$01 #REGb=reset to original width counter.
  $748B,$01 Decrement height counter.
  $748C,$02 Repeat until all tiles have been coloured.
  $748E,$01 Return.

c $748F Calculate Attribute Address
E $748F View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #COOKIE$7534 }
. { #JETPAC$720E }
. { #LUNARJETMAN$8506 }
. { #TRANZAM$7097 }
. LIST#
@ $748F label=AttributeAddress
N $748F Converts a given pixel address to the associated attribute buffer address.
R $748F HL Pixel address co-ordinates
R $748F O:HL Attribute buffer address
  $748F,$01 Horizontal co-ordinate.
  $7490,$03 Divide by #N08.
  $7493,$02,b$01 Keep only bits 0-4 (#N$00-#N$1F / minimum-maximum horizontal screen values).
  $7495,$01 Store this back in #REGl.
  $7496,$01 Vertical co-ordinate.
  $7497,$02 Multiply by #N$04.
  $7499,$01 Store this in #REGc temporarily.
  $749A,$02,b$01 Keep only bits 5-7.
  $749C,$01 Set the bits from #REGl.
  $749D,$01 #REGl=#REGa.
  $749E,$01 Fetch the stored value from #REGc.
  $749F,$02,b$01 Keep only bits 0-1.
  $74A1,$02,b$01 Set MSB of the attribute buffer #N$58. This ensures our value is >= #R$5800.
  $74A3,$01 Store this back in #REGh.
  $74A4,$01 Return.

c $74A5

c $751C
  $751C,$03 Call #R$74C0.
  $751F,$02 Jump to #R$7539.

  $7521,$03 Call #R$74A8.
  $7524,$02 Jump to #R$7529.

  $7526,$03 Call #R$74A5.
  $7533,$03 Jump to #R$75D0.

c $7542 Actor: Get Position/ Direction
@ $7542 label=ActorFindPosDir
  $7542,$03 #REGa=actor X position.
  $7545,$02,b$01 Keep only bits 1-2.
  $7547,$01 Store the result in #REGc.
  $7548,$03 #REGa=actor movement direction.

N $754B Actor: Get Sprite Address
@ $754B label=ActorGetSpriteAddress
  $754B,$04 Jump to #R$7551 if bit 6 of sprite header is reset.
  $755A,$02,b$01 Keep only bits 4-7.
  $755D,$03 #REGhl=#R$761A.
  $7560,$03 Create an offset in #REGbc.
  $7563,$01 #REGhl=sprite table + offset.
  $7564,$03 #REGde=sprite address.
  $7567,$01 Return.

c $7568

c $757A Actor: Move Sprite
@ $757A label=ActorMoveSprite
R $757A IX actor object
  $757A,$03 #REGa=actor X position.
  $757D,$02,b$01 Keep only bits 1-2.
  $757F,$01 Store the result in #REGc.
  $7580,$03 #REGa=sprite header byte.
  $7583,$02 Jump to #R$7542.

c $7585 Calculate screen address one pixel above current position
N $7585 Calculates the new address for writing a sprite pixel, in an upward direction, taking into consideration the screen memory layout.
R $7585 HL Current position
R $7585 O:HL Address for new position
@ $7585 label=ScreenPos1PixelAbove
  $7585,$01 Decrement #REGh to move up one pixel on screen.
  $7586,$01 Store the result in #REGa.
  $7587,$02,b$01 Keep only bits 0-2.
  $7589,$03 If a character line has not been crossed then return.
  $758C,$04 Else subtract #N$20 from #REGl.
  $7590,$02,b$01 Keep only bits 5-7.
  $7592,$03 If a new section of the screen has not been crossed then return.
  $7595,$05 Else add #N$08 to #REGh and return.

c $759A Calculate Screen Address
E $759A View the equivalent code in;
. #LIST
. { #ATICATAC$9BA2 }
. { #COOKIE$76E3 }
. { #JETPAC$7308 }
. { #LUNARJETMAN$851E }
. { #TRANZAM$6F10 }
. LIST#
@ $759A label=ScreenAddress
  $759A,$01 #REGa=#REGl.
  $759B,$03 #REGa=#REGa / #N$08.
  $759E,$02,b$01 Keep only bits 0-4.
  $75A0,$01 #REGl=#REGa.
  $75A1,$01 #REGa=#REGh.
  $75A2,$02 #REGa=#REGa * #N$04.
  $75A4,$02,b$01 Keep only bits 5-7.
  $75A6,$01
  $75A7,$01 #REGl=#REGa.
  $75A8,$01 #REGa=#REGh.
  $75A9,$02,b$01 Keep only bits 0-2.
  $75AB,$01 Switch to the shadow #REGaf register.
  $75AC,$01 #REGa=#REGh.
  $75AD,$03 #REGa=#REGa / #N$08.
  $75B0,$02,b$01 Keep only bits 3-4.
  $75B2,$02,b$01 Set bit 6.
  $75B4,$01 #REGh=#REGa.
  $75B5,$01 Switch to the shadow #REGaf register.
  $75B6,$01
  $75B7,$01 #REGh=#REGa.
  $75B8,$01 Return.

c $75B9 Store Entity
E $75B9 View the equivalent code in;
. #LIST
. { #ATICATAC$9FFB }
. { #COOKIE$0000 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #TRANZAM$71ED }
. LIST#
@ $75B9 label=StoreEntity
  $75B9,$06 Copy actor X position to active actor X position.
  $75BF,$06 Copy actor Y position to active actor Y position.
  $75C5,$06 Copy actor movement to active actor movement.
  $75CB,$01 Return.

c $75CC Controls: Kempston Joystick
@ $75CC label=ReadKempstonJoystick
R $75CC A Joystick controls
  $75CC,$03 #REGa=controls.
  $75CE,$01 Flip the bits.
  $75CF,$01 Return.

c $75D0 Erase Sprite
@ $75D0 label=MaskSprite
R $75D0 B Loop counter
R $75D0 C Actor Y position, or zero?
R $75D0 DE Address into a sprite/buffer
R $75D0 HL Address in the DISPLAY_FILE
  $75D0,$04 Jump to #R$75FB if the sprites vertical position is zero.
  $75D4,$01 Else decrement.
  $75D5,$02 Stash #REGbc and #REGhl on the stack.
N $75D7 Loop to create a mask of the sprite and it write to the screen.
  $75D7,$01 #REGa=sprite byte.
  $75D8,$03 Create mask and write to screen.
  $75DB,$01 Move onto the next byte.
  $75DC,$01 Move onto the next column.
  $75DD,$02 Decrease counter by one and loop back to #R$75D7 until counter is zero.
  $75DF,$01 Restore #REGhl from the stack.
  $75E0,$03 Call #R$7585.
  $75E3,$01 Restore #REGbc from the stack.

  $75E5,$04 Jump to #R$75F8 if #REGc is zero.
  $75EA,$02 Stash #REGbc and #REGhl on the stack.
  $75F3,$01 Restore #REGhl from the stack.
  $75F4,$03 Call #R$7585.
  $75F7,$01 Restore #REGbc from the stack.

w $761A Sprites Table
E $761A View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #TRANZAM$0000 }
. LIST#
@ $761A label=SpritesTable
  $761A,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#EVAL((#PC - $761A) / 2)).
L $761A,$02,$40

b $769A Sprite: Flower (Bud)
N $769A #DIMENSIONS
  $769A,$01 Terminator.
  $769B,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $769C,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $769D,$39,$03 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $05, $04 * {width} * $08, $04 * {height}}(flower-01)

b $76D6 UDG Graphics
@ $76D6 label=UDG_Brick
N $76D6 ID: "#N(#EVAL((#PC - $76D6) / $08))".
  $76D6,b$08,$01 #UDG(#PC,attr=$7A)
N $76DE ID: "#N(#EVAL((#PC - $76D6) / $08))".
@ $76DE label=UDG_Floor_1
  $76DE,b$08,$01 #UDG(#PC,attr=$32)
N $76E6 ID: "#N(#EVAL((#PC - $76D6) / $08))".
@ $76E6 label=UDG_Floor_2
  $76E6,b$08,$01 #UDG(#PC,attr=$32)

b $76EE Sprite: Pesticide Spray Can
N $76EE #DIMENSIONS
  $76EE,$01 Terminator.
  $76EF,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $76F0,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $76F1 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(can-01)

N $7711 #DIMENSIONS
  $7711,$01 Terminator.
  $7712,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7713,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7714 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(can-02)

N $7734 #DIMENSIONS
  $7734,$01 Terminator.
  $7735,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7736,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7737 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(can-03)

N $7757 #DIMENSIONS
  $7757,$01 Terminator.
  $7758,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7759,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $775A #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(can-04)

b $778A Sprite: Robbie the robot
N $778A #DIMENSIONS
  $778A,$01 Terminator.
  $778B,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $778C,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $778D #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $05, $04 * {width} * $08, $04 * {height}}(robbie-01*)

N $77C6 #DIMENSIONS
  $77C6,$01 Terminator.
  $77C7,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $77C8,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $77C9 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $05, $04 * {width} * $08, $04 * {height}}(robbie-02*)

N $7802 #DIMENSIONS
  $7802,$01 Terminator.
  $7803,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7804,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7805 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $05, $04 * {width} * $08, $04 * {height}}(robbie-03*)

N $783E #DIMENSIONS
  $783E,$01 Terminator.
  $783F,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7840,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7841 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $05, $04 * {width} * $08, $04 * {height}}(robbie-04*)

b $787A Sprite: Leaves
N $787A #DIMENSIONS
  $787A,$01 Terminator.
  $787B,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $787C,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $787D #UDGARRAY1,attr=7,scale=4,step=1,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $03, $04 * {width} * $08, $04 * {height}}(leaf-01)

N $7882 #DIMENSIONS
  $7882,$01 Terminator.
  $7883,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7884,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7885 #UDGARRAY1,attr=7,scale=4,step=1,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(leaf-02)

N $788D #DIMENSIONS
  $788D,$01 Terminator.
  $788E,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $788F,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7890 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $05, $04 * {width} * $08, $04 * {height}}(leaf-03)

N $78A6 #DIMENSIONS
  $78A6,$01 Terminator.
  $78A7,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $78A8,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $78A9 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(leaf-04)

N $78C9 #DIMENSIONS
  $78C9,$01 Terminator.
  $78CA,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $78CB,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $78CC #UDGARRAY1,attr=7,scale=4,step=1,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $03, $04 * {width} * $08, $04 * {height}}(leaf-05)

N $78D1 #DIMENSIONS
  $78D1,$01 Terminator.
  $78D2,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $78D3,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $78D4 #UDGARRAY1,attr=7,scale=4,step=1,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(leaf-06)

N $78DC #DIMENSIONS
  $78DC,$01 Terminator.
  $78DD,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $78DE,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $78DF #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $05, $04 * {width} * $08, $04 * {height}}(leaf-07)

N $78F5 #DIMENSIONS
  $78F5,$01 Terminator.
  $78F6,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $78F7,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $78F8 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(leaf-08)

b $7918 Sprite: Smoke Bomb
N $7918 #DIMENSIONS
  $7918,$01 Terminator.
  $7919,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $791A,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $791B #UDGARRAY1,attr=7,scale=4,step=1,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04, $04 * {width} * $08, $04 * {height}}(smoke-01)

N $7922 #DIMENSIONS
  $7922,$01 Terminator.
  $7923,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7924,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7925,$0E,b$02 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04, $04 * {width} * $08, $04 * {height}}(smoke-02)

N $7933 #DIMENSIONS
  $7933,$01 Terminator.
  $7934,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7935,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7936 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(smoke-03)

N $7946 #DIMENSIONS
  $7946,$01 Terminator.
  $7947,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7948,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7949 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(smoke-04)

N $7959 #DIMENSIONS
  $7959,$01 Terminator.
  $795A,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $795B,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $795C #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $08, $04 * {width} * $08, $04 * {height}}(smoke-05)

N $7970 #DIMENSIONS
  $7970,$01 Terminator.
  $7971,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7972,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7973 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $08, $04 * {width} * $08, $04 * {height}}(smoke-06)

b $7991 Sprite: Streamer/ Leech Laser
N $7991 #DIMENSIONS
  $7991,$01 Terminator.
  $7992,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7993,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7994,$0E,b$02 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04, $04 * {width} * $08, $04 * {height}}(streamer-01)

N $79A2 #DIMENSIONS
  $79A2,$01 Terminator.
  $79A3,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $79A4,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $79A5,$0E,b$02 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04, $04 * {width} * $08, $04 * {height}}(streamer-02)

b $79B3 Sprite: Scuttling Leech
N $79B3 #DIMENSIONS
  $79B3,$01 Terminator.
  $79B4,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $79B5,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $79B6 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04, $04 * {width} * $08, $04 * {height}}(leech-01)

N $79E3 #DIMENSIONS
  $79E3,$01 Terminator.
  $79E4,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $79E5,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $79E6 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04, $04 * {width} * $08, $04 * {height}}(leech-02)

N $7A13 #DIMENSIONS
  $7A13,$01 Terminator.
  $7A14,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7A15,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7A16 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04, $04 * {width} * $08, $04 * {height}}(leech-03)

N $7A43 #DIMENSIONS
  $7A43,$01 Terminator.
  $7A44,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7A45,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7A46 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04, $04 * {width} * $08, $04 * {height}}(leech-04)

b $7A73 Sprite: Interstellar Space Slug
N $7A73 #DIMENSIONS
  $7A73,$01 Terminator.
  $7A74,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7A75,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7A76 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $04, $04 * {width} * $08, $04 * {height}}(slug-01)

N $7A9A #DIMENSIONS
  $7A9A,$01 Terminator.
  $7A9B,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7A9C,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7A9D #UDGARRAY4,attr=7,scale=4,step=4,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(slug-02)

N $7ABD #DIMENSIONS
  $7ABD,$01 Terminator.
  $7ABE,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7ABF,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7AC0 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $04, $04 * {width} * $08, $04 * {height}}(slug-03)

N $7AE4 #DIMENSIONS
  $7AE4,$01 Terminator.
  $7AE5,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7AE6,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7AE7 #UDGARRAY4,attr=7,scale=4,step=4,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(slug-04)

b $7B07 Sprite: Menacing Midges
N $7B07 #DIMENSIONS
  $7B07,$01 Terminator.
  $7B08,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7B09,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7B0A #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $05, $04 * {width} * $08, $04 * {height}}(midges-01)

N $7B43 #DIMENSIONS
  $7B43,$01 Terminator.
  $7B44,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7B45,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7B46 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $06, $04 * {width} * $08, $04 * {height}}(midges-02)

N $7B7C #DIMENSIONS
  $7B7C,$01 Terminator.
  $7B7D,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7B7E,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7B7F #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $05, $04 * {width} * $08, $04 * {height}}(midges-03)

N $7BB8 #DIMENSIONS
  $7BB8,$01 Terminator.
  $7BB9,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7BBA,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7BBB #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $06, $04 * {width} * $08, $04 * {height}}(midges-04)

b $7BF1 Sprite: Insect Repellent/ Super Space Slug Spray
N $7BF1 #DIMENSIONS
  $7BF1,$01 Terminator.
  $7BF2,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7BF3,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7BF4,$0E,b$02 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04, $04 * {width} * $08, $04 * {height} - $04}(repellent-01)

N $7C02 #DIMENSIONS
  $7C02,$01 Terminator.
  $7C03,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7C04,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7C05,$10,b$02 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(repellent-02)

N $7C15 #DIMENSIONS
  $7C15,$01 Terminator.
  $7C16,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7C17,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7C18,$0E,b$02 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04, $04 * {width} * $08, $04 * {height} - $04}(repellent-03)

N $7C26 #DIMENSIONS
  $7C26,$01 Terminator.
  $7C27,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7C28,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7C29,$10,b$02 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(repellent-04)

b $7C39 Sprite: Flower (Others)
N $7C39 #DIMENSIONS
  $7C39,$01 Terminator.
  $7C3A,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7C3B,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7C3C,$36,$03 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $06, $04 * {width} * $08, $04 * {height}}(flower-02)

N $7C72 #DIMENSIONS
  $7C72,$01 Terminator.
  $7C73,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7C74,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7C75,$5A,$03 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08){$00, $04 * $02, $04 * {width} * $08, $04 * {height}}(flower-03)

N $7CCF For attributes see #R$6748. #DIMENSIONS
  $7CCF,$01 Terminator.
  $7CD0,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7CD1,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7CD2,$1F8,$09 #UDGARRAY9,scale=4,step=9,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)@$6775-$6786;$676C-$6774;$6763-$676B;$6751-$6762;$6748-$6750(flower-04)

b $7ECA Sprite: Explosions
N $7ECA #DIMENSIONS
  $7ECA,$01 Terminator.
  $7ECB,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7ECC,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7ECD #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(explosion-01*)

N $7EFD #DIMENSIONS
  $7EFD,$01 Terminator.
  $7EFE,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7EFF,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7F00 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(explosion-02*)

N $7F30 #DIMENSIONS
  $7F30,$01 Terminator.
  $7F31,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7F32,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7F33 #UDGARRAY3,attr=7,scale=4,step=3,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(explosion-03*)

b $7F63 Sprite: Fertiliser
N $7F63 #DIMENSIONS
  $7F63,$01 Terminator.
  $7F64,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7F65,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7F66,$24,b$02 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}))-$01-({width} * $08){$00, $04 * $07, $04 * {width} * $08, $08 * {height}}(fertiliser*)

b $7F8A Sprite: Fly Swat
N $7F8A #DIMENSIONS
  $7F8A,$01 Terminator.
  $7F8B,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7F8C,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7F8D,$20,b$02 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08)(swatter*)

b $7FAD Sprite: Watering Can
N $7FAD #DIMENSIONS
  $7FAD,$01 Terminator.
  $7FAE,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7FAF,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7FB0,$22,b$02 #UDGARRAY2,attr=7,scale=4,step=2,flip=2;(#PC)-(#PC + ({height} * {width}))-$01-({width} * $08){$00, $04 * $07, $04 * {width} * $08, $08 * {height}}(watering-can*)

b $7FD2

i $7FFB
