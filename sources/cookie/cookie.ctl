> $4000 @org=$4000
> $4000 @start=$5B80
b $4000 Loading screen
D $4000 #UDGTABLE { =h Cookie Loading Screen } { #SCR$02(loading) } UDGTABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00
@ $5B00 expand=#DEF(#SPRITE(addr,attr) #UDGARRAY2,attr=$attr,scale=4,step=2,mask=1,flip=2;($addr)-($addr+$11)-$01-$10{0,($10-#PEEK($addr-1))*4,$10*4,#PEEK($addr-1)*4})

c $5B80 Game entry point
E $5B80 View the equivalent code in;
. #LIST
. { #JETPAC$5B80 }
. { #PSSST$5B80 }
. { #TRANZAM$5B80 }
. LIST#
E $5B80 Later Ultimate games use more advanced decryption mechanisms;
. #LIST
. { #ATICATAC$5B80 }
. { #LUNARJETMAN$5B80 }
. LIST#
@ $5B80 label=GameEntry
  $5B80,$01 Disable interrupts.
  $5B81,$0B Moves #N$20FF bytes from #N$5F01 to #N$5F00.
  $5B8C,$03 Jump to #R$5F00.

b $5B8F

c $5F00 Security Check
E $5F00 View the equivalent code in;
. #LIST
. { #ATICATAC$6000 }
. { #JETPAC$61E5 }
. { #LUNARJETMAN$8000 }
. { #PSSST$61C6 }
. { #TRANZAM$5F00 }
. LIST#
@ $5F00 label=SecurityCheck
  $5F00,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $5F03,$03 Return if #REGa is not #N$32.
  $5F06,$03 Jump to #R$6298.

g $5F09 High Score
E $5F09 View the equivalent code in;
. #LIST
. { #JETPAC$5CF0 }
. { #LUNARJETMAN$5E06 }
. { #PSSST$5E00 }
. { #TRANZAM$5E49 }
. LIST#
D $5F09 3-byte representation of the score.
@ $5F09 label=HighScore_1
B $5F09,$01 Byte #1.
@ $5F0A label=HighScore_2
B $5F0A,$01 Byte #2.
@ $5F0B label=HighScore_3
B $5F0B,$01 Byte #3.

g $5F0C Game Options
@ $5F0C label=GameOptions
D $5F0C #TABLE(default,centre,centre)
. { =h Byte | =h Binary | =h Option }
. { #N$00 | #EVAL($00, 2, 8) | 1UP Game + Keyboard }
. { #N$01 | #EVAL($01, 2, 8) | 2UP Game + Keyboard }
. { #N$02 | #EVAL($02, 2, 8) | 1UP Game + Kempston Joystick }
. { #N$03 | #EVAL($03, 2, 8) | 2UP Game + Kempston Joystick }
. { #N$04 | #EVAL($04, 2, 8) | 1UP Game + Cursor Joystick }
. { #N$05 | #EVAL($05, 2, 8) | 2UP Game + Cursor Joystick }
. TABLE#
g $5F0D Sound On/ Off
D $5F0D Either #N$00 or #N$01.
@ $5F0D label=Sound_Enable

g $5F0E 1UP Score
D $5F0E 3-byte representation of the score.
@ $5F0E label=1UP_Score_1
B $5F0E,$01 Byte #1.
@ $5F0F label=1UP_Score_2
B $5F0F,$01 Byte #2.
@ $5F10 label=1UP_Score_3
B $5F10,$01 Byte #3.

g $5F11 2UP Score
D $5F11 3-byte representation of the score.
@ $5F11 label=2UP_Score_1
B $5F11,$01 Byte #1.
@ $5F12 label=2UP_Score_2
B $5F12,$01 Byte #2.
@ $5F13 label=2UP_Score_3
B $5F13,$01 Byte #3.

g $5F14
@ $5F14 label=
  $5F14,$01
@ $5F15 label=
  $5F15,$01
@ $5F16 label=
  $5F16,$01

g $5F17
g $5F18

s $5F19

g $5F1B

g $5F1D

g $5F1F
W $5F1F,$02

g $5F21 Current Player
@ $5F21 label=ActivePlayer
D $5F21 The currently active player.
. #TABLE(default,centre,centre)
. { =h Value | =h Player }
. { #N$00 | 1UP }
. { #N$01 | 2UP }
. TABLE#

g $5F22 Last Frame
@ $5F22 label=LastFrame

g $5F23 Frame Updated
@ $5F23 label=FrameUpdated
D $5F23 Has the frame been updated? #N$00=No #N$01=Yes.

g $5F24 Menu Item Attribute
D $5F24 Current menu item colour attribute.
@ $5F24 label=Current_MenuAttr
B $5F24,$01

g $5F25 Game Delay Timer
@ $5F25 label=GameDelayTimer
D $5F25 At the beginning of each player turn there is a delay to allow the player to be ready for play.
. #TABLE(default,centre,centre)
. { =h Value | =h Game Mode }
. { #N$80 | 1UP }
. { #N$FF | 2UP }
. TABLE#
. The larger delay for a 2UP game is useful for swapping players controls.

g $5F26
g $5F27
g $5F28

g $5F29

g $5F2B
W $5F2B,$02

g $5F2D 1UP Player
@ $5F2D label=1UP_Level
  $5F2D,$01 1UP Level
@ $5F2E label=1UP_Lives
  $5F2E,$01 1UP Lives
@ $5F2F label=1UP_Nasties
  $5F2F,$01 Number of Nasties to kill
@ $5F30 label=1UP_Ingredients
  $5F30,$01 Number of ingredients to collect
g $5F31 2UP Player
@ $5F31 label=2UP_Level
  $5F31,$01 2UP Level
@ $5F32 label=2UP_Lives
  $5F32,$01 2UP Lives
@ $5F33 label=2UP_Nasties
  $5F33,$01 Number of Nasties to kill
@ $5F34 label=2UP_Ingredients
  $5F34,$01 Number of ingredients to collect

g $5F35 Nasties Buffer
@ $5F35 label=BufferNasties
  $5F35,$01
  $5F36,$01
  $5F37,$01
  $5F38,$01
  $5F39,$01
  $5F3A,$01
  $5F3B,$01
  $5F3C,$01

b $5F3D

g $5F55 Ingredients Buffer
@ $5F55 label=BufferIngredients
  $5F55,$01
  $5F56,$01
  $5F57,$01
  $5F58,$01
  $5F59,$01
  $5F5A,$01
  $5F5B,$01
  $5F5C,$01
g $5F5D
b $5F5E

t $5F85 Copyright Messaging
@ $5F85 label=Message_Copyright
  $5F85,$09 "COPYRIGHT".
N $5F8E #N(#PEEK(#PC)) is the text colour. #N(#PEEK(#PC + $01)) is the font code for the "©" symbol.
@ $5F8E label=Message_Rights
  $5F8E,$21,h$01,c$01,$1E:$01 "© 1983 A.C.G. ALL RIGHTS RESERVED".

b $5FAF
  $5FAF,$08,$01

c $5FB7 Create Game Window
@ $5FB7 label=CreateWindow
N $5FB7 Blank the screen and write the banner.
  $5FB7,$03 Call #R$74E2.
  $5FBA,$03 Call #R$74D4.
  $5FBD,$03 Call #R$74AE.
N $5FC0 Set the attributes for the 1UP lives graphic.
  $5FC0,$03 #REGhl=#N$5808.
  $5FC3,$02 #REGa=#N$47.
  $5FC5,$01 Write #REGa to #REGhl.
  $5FC6,$01 Increment #REGhl by one.
  $5FC7,$01 Write #REGa to #REGhl.
N $5FC8 Set the attributes for the 2UP lives graphic.
  $5FC8,$03 #REGhl=#N$5816.
  $5FCB,$01 Write #REGa to #REGhl.
  $5FCC,$01 Increment #REGhl by one.
  $5FCD,$01 Write #REGa to #REGhl.
N $5FCE Set the attributes for the score line (the whole line is INK:#N$45).
  $5FCE,$03 #REGhl=#N$5820.
  $5FD1,$03 #REGbc=counter:#N$20, INK:#N$45.
@ $5FD4 label=CreateWindow_Loop
  $5FD4,$01 Write #N$45 to the attribute buffer.
  $5FD5,$01 Move onto the next column.
  $5FD6,$02 Decrease counter by one and loop back to #R$5FD4 until counter is zero.
N $5FD8 Write the 1UP, 2UP and HI scores.
  $5FD8,$03 Call #R$7438.
  $5FDB,$03 Call #R$7440.
  $5FDE,$03 Jump to #R$7448.

c $5FE1
  $5FE1,$04 Increase #R$5F2E by one.
  $5FE5,$03 Call #R$6FFD.

  $5FE8,$03 #REGa=#R$5F2D.
  $5FED,$03 Call #R$5FB7.
  $5FF0,$03 Call #R$6017.
  $5FF3,$03 Call #R$7378.
N $5FF6 #HTML(Self modifying code; this updates the command at #R$7515 to <strong>"CP #N$1A"</strong>.)
  $5FF6,$05 Write #N$1A to #R$7515(#N$7516).
  $5FFB,$06 #HTML(Write <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> to #R$5F22.)
  $6001,$01 Return.
  $6002,$01 #REGa=#REGb.
  $6003,$01 Switch to the shadow registers.
  $6004,$03 Create an offset in #REGbc'.
  $6007,$04 Calculate the address using the offset and #R$6011.
  $600B,$04 Write the data from the offset to #R$5F27.
  $600F,$01 Switch to the normal registers.
  $6010,$01 Return.
B $6011,$06

N $6017 The pantry is constructed like it is a font.
  $6017,$04 #HTML(Stash <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a> on the stack.)
  $601B,$06 #HTML(Write #R$7B4A to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $6021,$03 #REGa=#R$5F2D.
  $6024,$02,b$01 Keep only bits 0-2.
  $6026,$01 Store the result in #REGb.
  $6027,$02 #REGa=#N$20.
  $6032,$03 #REGde=#R$613B.
  $6035,$03 #REGhl=#N$10D0.
  $6038,$03 Call #R$7488.

b $613B Pantry Graphic
@ $613B label=CupboardData
N $613B The pantry is printed like a font.
  $613B,$01 Attribute = #PEEK(#PC).
  $613C,$06,b$01 Offsets.
L $613B,$07,$02
  $6149,$01 Attribute = #PEEK(#PC).
  $614A,$10,b$01 Offsets.

  $616D,$01 Attribute = #PEEK(#PC).
  $616E,$06,b$01 Offsets.
  $6174,$01 Attribute = #PEEK(#PC).
  $6175,$05,b$01 Offsets.
  $6198,$01 Attribute = #PEEK(#PC).
  $6199,$04,b$01 Offsets.
  $6218,$01 Attribute = #PEEK(#PC).
  $6219,$04,b$01 Offsets.

c $6298 Game Initialisation
E $6298 View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #JETPAC$61EB }
. { #LUNARJETMAN$800A }
. { #PSSST$61CD }
. { #TRANZAM$5F07 }
. LIST#
@ $6298 label=GameInitialisation
@ $629E label=GameInitialisation_Loop
N $6298 Blank the 1UP, 2UP and HI scores.
  $6298,$0A Write #N$00 to #N$0B bytes from #R$5F09 to #N$5F13.
N $62A2 #HTML(This calculates a "checksum" of the <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEPER</a> routine.
.       The expected value at the end is #N$00, and if #R$5F0D does not contain #N$00 then the game is muted.)
  $62A2,$03 #HTML(#REGhl=<a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEPER</a>.)
  $62A5,$02 #REGb=#N$43 (counter).
  $62A7,$01 #REGa=#N$00.
@ $62A8 label=Mute_Loop
  $62A8,$01 Add the byte at #REGhl to #REGa.
  $62A9,$01 Increment #REGhl by one.
  $62AA,$02 Decrease counter by one and loop back to #R$62A8 until counter is zero.
  $62AC,$02 #REGa=#REGa + #N$68.
  $62AE,$03 Store this number at #R$5F0D.
  $62B1,$04 #HTML(Write #N$00 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C48.html">BORDCR</a>.)

@ $62B5 label=Game_Restart
  $62B5,$01 Disable interrupts.
  $62B6,$03 Set the stack pointer to #R$5F00.
  $62B9,$03 Call #R$5FB7.
@ $62BC label=GameSelect_Loop
  $62BC,$03 Call #R$6332.
  $62BF,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $62C5,$01 Flip the bits.
  $62C6,$01 #REGe=#REGa.
  $62C7,$03 #REGa=#R$5F0C.
N $62CA Handle 1UP selection.
  $62CA,$02 Has key "1" been pressed? ("1 PLAYER GAME").
  $62CC,$02 If not jump to #R$62D0.
  $62CE,$02 Set player count = 1.
N $62D0 Handle 2UP selection.
@ $62D0 label=GameSelect_CheckP2
  $62D0,$02 Has key "2" been pressed? ("2 PLAYER GAME").
  $62D2,$02 If not jump to #R$62D6.
  $62D4,$02 Set player count = 2.
N $62D6 Handle Keyboard selection.
@ $62D6 label=GameSelect_CheckKeyboard
  $62D6,$02 Has key "3" been pressed? ("KEYBOARD").
  $62D8,$02 If not jump to #R$62DC.
  $62DA,$02,b$01 Keep only bits 0, 3-7.
N $62DC Handle Kempston Joystick selection.
@ $62DC label=GameSelect_CheckKempston
  $62DC,$02 Has key "4" been pressed? ("KEMPSTON JOYSTICK").
  $62DE,$02 If not jump to #R$62E4.
  $62E0,$02,b$01 Keep only bits.
  $62E2,$02,b$01 Set bit 1.
N $62E4 Handle Cursor Joystick selection.
@ $62E4 label=GameSelect_CheckCursor
  $62E4,$02 Has key "5" been pressed? ("CURSOR JOYSTICK").
  $62E6,$02 If not jump to #R$62EC.
  $62E8,$02,b$01 Keep only bits 0, 3-7.
  $62EA,$02,b$01 Set bit 2.
@ $62EC label=GameSelect_CheckStart
  $62EC,$03 Store #REGa at #R$5F0C.
N $62EF "0" for "Start Game" is on a different port.
  $62EF,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $62F5,$01 Flip the bits.
N $62F6 Handle starting a new game.
  $62F6,$02 Has key "0" been pressed? ("START GAME").
  $62F8,$03 If so, jump to #R$6428.
N $62FB Handle flashing each selection.
  $62FB,$03 #REGhl=#R$635F(GameSelection_Attributes)+#N$01 (i.e. ignoring "Game Selection" as it doesn't flash).
  $62FE,$04 #REGc=#R$5F0C.
  $6302,$04 If a 1UP game is selected, jump to #R$631F.
  $6306,$03 Call #R$6324.
@ $6309 label=MenuAttrHandler
  $6309,$02 #REGb=#N$03.
  $630B,$01 #REGa=#REGc.
@ $630D label=MenuAttrHandler_Loop
  $630D,$02,b$01 Keep only bits 0-1.
  $6311,$03 Call #R$6327.
  $6314,$01 Decrease #REGa by one.
  $6315,$02 Decrease counter by one and loop back to #R$630D until counter is zero.
  $6317,$03 Jump back to #R$62BC.
N $631A Handle flashing 2UP.
@ $631A label=MenuAttrHandle2UP
  $631A,$03 Call #R$632E.
  $631D,$02 Jump to #R$6314.
N $631F Handle flashing joystick.
@ $631F label=MenuAttrHandleJoystick
  $631F,$03 Call #R$632B.
  $6322,$02 Jump to #R$6309.
N $6324 Set the first menu item, unset the second.
@ $6324 label=MenuAttributeSetUnset
  $6324,$02 Set the FLASH attribute for the menu attribute.
  $6326,$01 Move onto the next menu attribute.
@ $6327 label=MenuAttributeUnSetFirst
  $6327,$02 Unset the FLASH attribute for the menu attribute.
  $6329,$01 Move onto the next menu attribute.
  $632A,$01 Return.
N $632B Unset the first menu item, set the second.
@ $632B label=MenuAttributeUnsetSet
  $632B,$02 Unset the FLASH attribute for the menu attribute.
  $632D,$01 Move onto the next menu attribute.
@ $632E label=MenuAttributeSetFirst
  $632E,$02 Set the FLASH attribute for the menu attribute.
  $6330,$01 Move onto the next menu attribute.
  $6331,$01 Return.

c $6332 Game Selection Menu
E $6332 View the equivalent code in;
. #LIST
. { #ATICATAC$7CAF }
. { #JETPAC$6260 }
. { #LUNARJETMAN$80D1 }
. { #PSSST$6250 }
. { #TRANZAM$5F6C }
. LIST#
@ $6332 label=GameMenu
  $6332,$03 #REGde=#R$635E.
  $6335,$01 Switch to the shadow registers.
  $6336,$03 #REGhl'=#R$6365.
  $6339,$03 #REGde'=#R$636C.
N $633C There are seven lines of text.
  $633C,$02 #REGb'=#N$07 (counter).
@ $633E label=GameMenu_Loop
  $633E,$01 Switch back to the normal registers.
  $633F,$04 Copy a byte from #REGde to #R$5F24.
  $6343,$01 Increment #REGde by one.
  $6344,$01 Switch to the shadow registers.
  $6345,$01 Stash #REGbc' on the stack.
  $6346,$01 #REGa=#REGhl' (grab the position data).
  $6347,$01 Increment #REGhl' (position data pointer) by one.
  $6348,$01 Stash #REGhl' (position data pointer) on the stack.
  $6349,$03 #REGh'=#REGa #REGl'=#N$38.
  $634C,$03 Call #R$63E0.
  $634F,$01 Switch back to the normal registers.
  $6350,$02 Restore #REGhl and #REGbc from the stack.
  $6352,$01 Increase #REGde by one.
  $6353,$02 Decrease counter by one and loop back to #R$633E until counter is zero.
  $6355,$03 #REGhl=#R$B800.
  $6358,$03 #REGde=#R$5F8E.
  $635B,$03 Jump to #R$7488.

b $635E Game Select Attribute Table
E $635E View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #JETPAC$628D }
. { #LUNARJETMAN$810E }
. { #PSSST$627C }
. { #TRANZAM$5FA7 }
. LIST#
@ $635E label=GameSelection_Attributes
  $635E,$07,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | Game Selection }
. { #N$02 | 1 Player Game }
. { #N$03 | 2 Player Game }
. { #N$04 | Keyboard }
. { #N$05 | Kempston Joystick }
. { #N$06 | Cursor Joystick }
. { #N$07 | Start Game }
. TABLE#

b $6365 Game Select Y Position Table
E $6365 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF1 }
. { #JETPAC$6293 }
. { #LUNARJETMAN$8115 }
. { #PSSST$6282 }
. { #TRANZAM$5FAC }
. LIST#
@ $6365 label=GameSelection_Position
  $6365,$07,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | Game Selection }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | 1 Player Game }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | 2 Player Game }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | Keyboard }
. { #N$05 | #EVAL(#PEEK(#PC+$04) / $08) | Kempston Joystick }
. { #N$06 | #EVAL(#PEEK(#PC+$05) / $08) | Cursor Joystick }
. { #N$07 | #EVAL(#PEEK(#PC+$06) / $08) | Start Game }
. TABLE#

t $636C Game Selection Screen Text
E $636C View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #JETPAC$6299 }
. { #LUNARJETMAN$811C }
. { #PSSST$6288 }
. { #TRANZAM$5FB1 }
. LIST#
@ $636C label=GameSelection_Text
T $636C,$0E,$0D:$01 "GAME SELECTION".
T $637A,$11,$10:$01 "1   1 PLAYER GAME".
T $638B,$11,$10:$01 "2   2 PLAYER GAME".
T $639C,$0C,$0B:$01 "3   KEYBOARD".
T $63A8,$15,$14:$01 "4   KEMPSTON JOYSTICK".
T $63BD,$15,$14:$01 "5   CURSOR   JOYSTICK".
T $63D2,$0E,$0D:$01 "0   START GAME".

c $63E0 Write Menu Line
E $63E0 View the equivalent code in;
. #LIST
. { #ATICATAC$7D8A }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$62E7 }
. { #TRANZAM$5F97 }
. LIST#
@ $63E0 label=MenuWriteText
  $63E0,$01 Stash #REGhl containing the co-ordinate on the stack.
  $63E1,$03 Call #R$76E3.
  $63E4,$03 #REGa=the menu attribute byte from #R$5F24.
  $63E7,$01 Switch to the shadow #REGaf register.
  $63E8,$01 Switch to the shadow registers.
  $63E9,$01 Restore #REGhl from the stack.
  $63EA,$03 Call #R$7534.
  $63ED,$03 Jump to #R$7494.

c $63F0 Initialise Players
@ $63F0 label=PlayersInit
  $63F0,$02 #REGb=#N$02 (counter; both players).
@ $63F2 label=PlayersInit_Loop
  $63F2,$01 Stash #REGbc on the stack.
  $63F3,$04 Write #N$00 to #R$5F2D.
N $63F7 Set both players starting lives.
  $63F7,$05 Write #N$04 to #R$5F2E.
  $63FC,$03 Call #R$6416 to swap the player data between 1UP and 2UP players.
  $63FF,$01 Restore #REGbc from the stack.
  $6400,$02 Decrease counter by one and loop back to #R$63F2 until counter is zero.
N $6402 Note this is +#N$01 to #R$63F7 as you "spend a life", and 1UP goes first.
  $6402,$05 Write #N$05 to #R$5F32.
N $6407 Default to writing #N$FF to #R$5F31 (this is a 1UP game).
  $6407,$05 Write #N$FF to #R$5F31.
N $640C Handle 2UP game.
M $640C,$06 Return if bit 0 of #R$5F0C is not set (i.e. if this is a 1UP game).
  $640C,$03
  $640F,$02,b$01
  $6411,$01
  $6412,$03 Else, write it to #R$5F32.
  $6415,$01 Return.

c $6416 1UP/ 2UP Swapper
E $6416 View the equivalent code in;
. #LIST
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$613B }
. { #TRANZAM$0000 }
. LIST#
@ $6416 label=ChangePlayer
N $6416 This routine "swaps" the data between #REGde and #REGhl.
  $6416,$03 #REGhl=#R$5F2D.
  $6419,$03 #REGde=#R$5F31.
  $641C,$02 #REGb=#N$04 (counter).
N $641E This looks complicated but it's just grabbing the data from #REGde, grabbing the data from #REGhl, and writing the others data to each one.
@ $641E label=ChangePlayer_Loop
  $641E,$01 #REGa=#REGde.
  $641F,$01 #REGc=#REGhl.
  $6420,$01 Store #REGa at #REGhl.
  $6421,$02 Store #REGc at #REGde.
  $6423,$02 Increase both #REGhl and #REGde by one.
  $6425,$02 Decrease counter by one and loop back to #R$641E until counter is zero.
  $6427,$01 Return.

c $6428 Start Game
E $6428 View the equivalent code in;
. #LIST
. { #ATICATAC$7D9A }
. { #JETPAC$6333 }
. { #LUNARJETMAN$81BB }
. { #PSSST$631E }
. { #TRANZAM$5FEF }
. LIST#
@ $6428 label=StartGame
  $6428,$03 Call #R$74E2.
  $642B,$03 Call #R$74D4.
  $642E,$06 If #R$5F0D is not zero then jump to #R$643A.
  $6434,$03 #REGde=#R$65C8.
  $6437,$03 Call #R$6568.
@ $643A label=SkipMusic
  $643A,$07 Write #N$00 to; #LIST { #R$5F30 } { #R$5F34 } LIST#
  $6441,$0D Write #N$00 to #N$0076 bytes, from #N$5F0E to #N$5F84.

  $644E,$03 Call #R$63F0.
  $6451,$03 Call #R$7186.
  $6454,$03 Call #R$6C58.

@ $6457 label=MainLoopResetStack
  $6457,$03 Set the stack pointer to #R$5F00.
  $645A,$01 Enable interrupts.
  $645B,$04 #REGix=#R$5F55.
  $645F,$04 Write #N$00 to #R$5F1B to reset the current nasties.

@ $6463 label=MainLoop
  $6463,$07 #HTML(Compare <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> and #R$5F22.)
N $646A If interrupts are enabled, then #R$7160 will be called and DI executed.
  $646A,$04 If they are not equal call #R$7160.
  $646E,$03 #REGhl=#R$71A3.
  $6471,$01 Stash #REGhl on the stack.
  $6472,$03 #REGhl=#R$6486.
  $6475,$03 #REGa=#REGix+#N$00.
  $6478,$01 #REGa=#REGa * 2.
  $6479,$02,b$01 Keep only bits 1-6.
  $647B,$03 Create an offset in #REGbc.
  $647E,$01 #REGhl=#REGhl + offset.
  $647F,$01
  $6480,$01 Increment #REGhl by one.
  $6481,$02
  $6483,$03 #HTML(Jump to <a href="https://skoolkid.github.io/rom/asm/5CB0.html">NMIADD</a> which should just jump to the address in #REGhl.)

w $6486 Jump Table

c $64E8

b $6524

c $6568 Play Music
@ $6568 label=PlayMusic
R $6568 DE Music Data
  $6568,$01 Fetch the music data byte.
  $6569,$03 Return if the terminator character has been reached.
  $656C,$02,b$01 Keep only bits 0-3.
  $656E,$01 Decrease #REGa by one.
  $656F,$02 #REGa=#REGa * 2.
  $6571,$03 Create an offset in #REGbc.
  $6574,$04 #REGhl=#N$6594 + offset.
  $6578,$01 Stash #REGde on the stack.
  $6579,$01
  $6589,$02 Stash #REGix on the stack.
  $658B,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/03B5.html">BEEPER</a.)
  $658E,$03 Restore #REGix and #REGde from the stack.
  $6591,$01 Increment #REGde by one.
  $6592,$02 Loop back round to the #R$6568(beginning) (we only end when the terminator is reached).
W $6594
B $65C8 Music Data
@ $65C8 label=MusicData

c $65E8
B $6631
  $6653

c $6735
B $6745

c $67E2
B $6821,$04

c $6825
c $683E

c $6854
@ $6854 label=LevelStartJingle
  $6854,$03 #REGc=pointer to counter.
  $6857,$03 Increment the counter by one.
  $685A,$06 Create an offset from #R$686A using the counter as the LSB.
  $6860,$01 #REGd=fetch the next byte from #R$686A.
  $6861,$02 #REGc=#N$08 (note counter).
@ $6863 label=LevelStartJingle_Loop
  $6863,$03 Call #R$68B1.
  $6866,$01 Decrease the note counter by one.
  $6867,$02 Keep looping back to #R$6863 until the note counter is zero.
  $6869,$01 Return.
B $686A,$18
@ $6882 label=GameStartJingle
  $6882,$02 #REGd=#N$30.
  $6884,$02 #REGc=#N$40.
  $6886,$02 Jump to #R$6863.

c $6888

c $68B1 Play square wave sound
@ $68B1 label=PlaySquareWave
R $68B1 D Duration of wave
  $68B1,$07 Play square wave sound.
@ $68B6 label=PlaySquareWave_Loop
  $68B8,$06 Play "silence".
@ $68BC label=Silence_Loop
  $68BE,$01 Return.

c $68BF

c $68C4
  $68C4,$03 #REGhl=#R$68D0.
  $68C7,$03 #REGde=#R$5F4D.
  $68CA,$03 #REGbc=#N$0008.
  $68CF,$01 Return.
B $68D0,$0E
B $68DE,$09
  $68E7,$03 #REGhl=#R$68EC.
  $68EA,$02 Jump to #R$68C7.
B $68EC,$0E
  $68FA,$03 #REGhl=#R$68FF.
  $68FD,$02 Jump to #R$68C7.
B $68FF,$16
  $6915,$03 #REGhl=#R$691A.
B $691A,$09

c $6BE0 Game Over
@ $6BE0 label=GameOver_1UP
N $6BE0 #HTML(Set up altering the "GAME OVER PLAYER <em>X</em>" message for 1UP.)
  $6BE0,c,$02 #REGa="1" + #N$80 (escape character).
N $6BE2 Print the messaging and pause to show it for a period of time.
@ $6BE2 label=GameOver_Write
  $6BE2,$03 Write ASCII player number to #R$6C1F(#N$6C30).
  $6BE5,$03 Call #R$5FB7.
  $6BE8,$03 #REGde=#R$6C1E.
  $6BEB,$03 #REGhl=#N$7038.
  $6BEE,$03 Call #R$7488.
N $6BF1 Introduce a pause by counting down from #N$10000 four times.
  $6BF1,$02 #REGb=#N$04 (counter).
  $6BF3,$03 #REGhl=#N$0000 (large counter).
@ $6BF6 label=GameOver_Pause
  $6BF6,$01 Decrease #REGhl by one.
  $6BF7,$04 Loop back to #R$6BF6 until #REGhl is zero.
  $6BFB,$02 Decrease counter by one and loop back to #R$6BF6 until counter is zero.
  $6BFD,$01 Return.
N $6BFE #HTML(Set up altering the "GAME OVER PLAYER <em>X</em>" message for 2UP.)
@ $6BFE label=GameOver_2UP
  $6BFE,c,$02 #REGa="2" + #N$80 (escape character).
  $6C00,$02 Jump to #R$6BE2.

N $6C02 This controller simply returns on end. This is for when the game continues after the messaging.
@ $6C02 label=GameOver_Controller
  $6C02,$06 If #R$5F21 is zero, jump to #R$6BE0.
  $6C08,$02 Else, jump to #R$6BFE.

N $6C0A This is a controller with a jump to #R$62B5 to return to the game selection screen.
@ $6C0A label=GameOver_ControllerRestart
  $6C0A,$03 Call #R$73D3.
  $6C0D,$06 If #R$5F21 is not zero, jump to #R$6C19.
  $6C13,$03 Call #R$6BE0.
@ $6C16 label=GameOver_Restart
  $6C16,$03 Jump to #R$62B5.
@ $6C19 label=GameOver_Restart2UP
  $6C19,$03 Call #R$6BFE.
  $6C1C,$02 Jump to #R$6C16.

N $6C1E Game Over Messaging
@ $6C1E label=GameOver_Text
T $6C1E,$13,h$01,$11:$01 #HTML("GAME OVER PLAYER <em>X</em>" (#N(#PEEK(#PC)) is the attribute).)

c $6C31
  $6C3B,$01 Return.

c $6C3C Next Level
@ $6C3C label=NextLevel
  $6C3C,$04 Increase #R$5F2D by one.
  $6C40,$01 #REGa=#R$5F2D.
  $6C41,$02,b$01 Keep only bits 1-3.
N $6C43 Every #N$05 levels is an extra life, handle the logic.
  $6C43,$04 If there's carry-over from #N$05 jump to #R$6C58.
  $6C47,$04 Add #N$03 to #R$5F2D (and write it).
  $6C4B,$04 Increase #R$5F2E by one.
  $6C4F,$03 #REGbc=#N$2500.
  $6C52,$03 Call #R$7415.
  $6C55,$03 Jump to #R$64E8.

c $6C58 Initialise New Game
@ $6C58 label=GameInit
  $6C58,$03 #REGa=#R$5F2D.
  $6C5B,$01 #REGa=#REGa * 2.
  $6C5C,$02,b$01 Keep only bits 4-6.
  $6C5E,$02 Add #N$10.
  $6C60,$03 Write this to #R$5F2F.
  $6C63,$05 Write #N$0A to #R$5F55.
  $6C68,$03 Write #N$20 to #R$5F56.
N $6C6B The number of Nasties to spawn maxes at #N$99.
  $6C6B,$04 #REGa=#R$5F30.
  $6C6F,$03 #REGa=#REGa + #N$01 (with "Decimal Adjust after Addition").
  $6C72,$04 If #REGa is already #N$99 jump to #R$6C78.
  $6C76,$02 #REGa=#N$99.
@ $6C78 label=GameInit_Return
  $6C78,$01 Write #REGa to #REGhl.
  $6C79,$01 Return.

c $6C7A

c $6D38
  $6D38,$03 Call #R$6D45.
  $6D3B,$03 #REGhl=#R$5F35.
  $6D3E,$03 #REGde=#R$6D87.
  $6D41,$02 #REGc=#N$07.
  $6D43,$02 Jump to #R$6D67.

  $6D45,$04 Write #N$00 to #R$5F29.
  $6D49,$05 Write #N$1E to #R$7515(#N$7516).
  $6D4E,$03 Call #R$74E2.
  $6D51,$03 Call #R$74D4.
  $6D54,$03 #REGhl=#R$6D7D.
  $6D57,$03 #REGa=#R$5F2D.
  $6D5A,$02 #REGc=#N$06.
  $6D5C,$01
  $6D5D,$02,b$01 Keep only bits 0-3.
  $6D5F,$03 Create an offset in #REGde.
  $6D62,$02 #REGde=#REGhl + offset.
  $6D64,$03 #REGhl=#R$5F55.

b $6D7D
  $6D7D,$0A,$05

c $6D87
B $6D87,$02
  $6D89,$03 #REGa=#REGix+#N$00.
  $6D8C,$01 Stash #REGaf on the stack.
  $6DA6,$03 Call #R$7617.
  $6DA9,$01 Restore #REGaf from the stack.
  $6DAD,$01 Return.
N $6DAE 1
  $6DAE,$02 #REGa=#N$02.
  $6DB0,$02 Jump to #R$6DD3.
N $6DB2 2
  $6DB2,$02 #REGa=#N$01.
  $6DB4,$02 Jump to #R$6DD3.
N $6DB6 2
  $6DBC,$03 Call #R$76D0.
  $6DC2,$02,b$01 Keep only bits 0-1.
  $6DEA,$03 Call #R$75CC.
  $6DED,$03 Call #R$74EE.
N $6DF0 3
  $6DF0,$01 Restore #REGaf from the stack.
  $6DF4,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $6DF7,$02,b$01 Keep only bits 0-2.
  $6E10,$01 Return.
  $6E1A,$03 #REGhl=#R$5F35.
  $6E1D,$03 #REGde=#R$6D87.
  $6E20,$02 #REGc=#N$07.
  $6E22,$03 Jump to #R$6D67.

c $6E25

c $6FFD
  $6FFD,$03 #REGhl=#R$5FAF.
  $7000,$03 #REGde=#R$5F35.
  $7003,$03 #REGbc=#N$0008.
  $7008,$02 #REGa=#N$80.
  $700A,$03 #REGhl=#R$5F0C.
  $7016,$07 Decrease #R$5F2E by one.
  $701D,$03 Jump to #R$7378.

c $7020 Flash Score Label
@ $7020 label=ScoreLabelFlash
N $7020 Controller for handling whether to action 1UP or 2UP score label.
  $7020,$03 #REGa=#R$5F21.
  $7023,$03 If the current player is 2UP then jump to #R$7043.
N $7026 Flash 1UP score label.
  $7026,$03 #REGhl=#N($00,$02,$03),#N($18,$02,$03) (position of the 1UP score label).

N $7029 Set flash state for the 3-attributes of the score label.
@ $7029 label=FlashText
  $7029,$03 Call #R$7534.
  $702C,$02 #REGb=#N$03 (counter for the three letters in a score label).
@ $702E label=FlashText_Loop
  $702E,$01 Fetch the attribute byte.
  $702F,$02,b$01 Ensure bit 7 is set (the flash bit).
  $7031,$01 Write the attribute byte back.
  $7032,$01 Increase the attribute pointer by one.
  $7033,$02 Decrease counter by one and loop back to #R$702E until counter is zero.
  $7035,$01 Return.

N $7036 Unset flash state for the 3-attributes of the score label.
@ $7036 label=UnsetFlashText
  $7036,$03 Call #R$7534.
  $7039,$02 #REGb=#N$03 (counter for the three letters in a score label).
@ $703B label=UnsetFlashText_Loop
  $703B,$01 Fetch the attribute byte.
  $703C,$02,b$01 Keep only bits 0-6 (i.e. everything except the flash bit).
  $703E,$01 Write the attribute byte back.
  $703F,$01 Increase the attribute pointer by one.
  $7040,$02 Decrease counter by one and loop back to #R$703B until counter is zero.
  $7042,$01 Return.

N $7043 Flash 2UP score label.
@ $7043 label=FlashScoreLabel2UP
  $7043,$03 #REGhl=#N($00,$02,$03),#N($D8,$02,$03) (position of the 2UP score label).
  $7046,$02 Jump to #R$7029.

c $7048 Game Play Entry
@ $7048 label=GamePlayEntry
  $7048,$07 If #R$5F25 is zero, jump to #R$706B.
  $704F,$01 Decrement #R$5F25 by one.
  $7050,$02 Jump to #R$7020 if the delay timer is still active.
  $7052,$06 If #R$5F21 says this is a 2UP game, jump to #R$7066.

N $7058 Handle turning off flash for 1UP score label.
  $7058,$03 #REGhl=#N($00,$02,$03),#N($18,$02,$03) (position of the 1UP score label).
@ $705B label=Game_UnsetFlash
  $705B,$03 Call #R$7036.
  $705E,$03 Call #R$7617.
  $7061,$03 Call #R$6882.
  $7064,$02 Jump to #R$706B.
N $7066 Handle turning off flash for 2UP score label.
@ $7066 label=Game2UP_UnsetFlash
  $7066,$03 #REGhl=#N($00,$02,$03),#N($D8,$02,$03) (position of the 2UP score label).
  $7069,$02 Jump to #R$705B.

c $706B Game Play Start
@ $706B label=GamePlay_Start
N $706B Init.
  $706B,$03 Call #R$76D0.
  $706E,$03 Call #R$6FB4.

c $713D
  $713D,$03 #REGhl=#R$5F35.
  $7140,$02 #REGb=#N$0A.
  $7142,$02 Jump to #R$7149.
  $7144,$03 #REGhl=#R$5F5D.
  $7147,$02 #REGb=#N$09.
  $7149,$03 #REGde=#N$0008.
  $714F,$02 Decrease counter by one and loop back to #R$714C until counter is zero.
  $7151,$01 Return.

c $7152
  $7152,$05 Return if #R$5F23 is not zero.
  $7157,$03 #REGhl=#N$0100.
  $715A,$01 Decrease #REGhl by one.
  $715B,$04 Jump to #R$715A if #REGhl is not zero.
  $715F,$01 Return.

c $7160 Frame Update
@ $7160 label=FrameUpdate
  $7160,$01 Disable interrupts.
  $7161,$06 #HTML(Store <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> at #R$5F22.)
  $7167,$05 Set #R$5F23 to #N$01 (frame has updated).
  $716C,$02 Stash #REGix on the stack.
  $716E,$06 Write #R$5F55 to #N$71AC.
N $7174 Self modifying code;
@ $7174 ssub=ld ($71BE),hl ; Modify `JP, nnnn` - rocket object
  $7174,$0B #HTML(Write #N$C3 to #R$71BE and #R$7198 to #R$71BE(#N$71BF), i.e. <strong>JP #R$7198</strong>).
  $717F,$04 #REGix=#R$5F35.
  $7183,$03 Jump to #R$6463.

c $7186
N $7186 Self modifying code; this updates the address for #REGbc (at #R$71AB).
  $7186,$06 Write #R$5F85 to #R$71AB(#N$71AC).
N $718C Self modifying code; this updates the command at #R$71BE to "LD HL, (xx)".
  $718C,$05 Write #N$2A to #R$71BE.
N $7191 Self modifying code; this updates the address for #REGhl (at #R$71BE).
  $7191,$06 Write #R$5F1D to #R$71BE(#N$71BF).
  $7197,$01 Return.

c $7198
  $7198,$03 Call #R$7186.
  $719B,$02 Restore #REGix from the stack.
  $719D,$04 Write #N$00 to #R$5F23.
  $71A1,$01 Enable interrupts.
  $71A2,$01 Return.

  $71A3,$05 #REGix=#REGix + #N$0008.
  $71A8,$03 #REGhl=#REGix (using the stack to make the transfer).
  $71AB,$03 #REGbc=#N$5F85(see #R$7186).
  $71AE,$01
  $71AF,$02 #REGhl=#REGhl - #REGbc.
  $71B1,$03 If there is any carry-over, jump to #R$6463.

N $71B4 Holding "SHIFT" during an interlude pauses the game.
  $71B4,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $71BA,$02 Has key "SHIFT" been pressed?
  $71BC,$02 If it has then jump to #R$71B4.
  $71BE,$03 #REGhl=#N$5F1D(see #R$7191).

  $71D2,$03 Call #R$713D.
  $71D5,$03 Call #R$6C3C.

  $71E6,$02,b$01 Keep only bits 0-4.
  $71F9,$02,b$01 Keep only bits 0-5.

  $7211,$03 Jump to #R$6457.

  $7232,$02,b$01 Keep only bits 3-6.
  $7261,$02,b$01 Keep only bits 0-1.
  $726D,$04 Set the colour to #N$45.
  $7271,$03 Call #R$7617.
  $7274,$03 Call #R$67E2.
  $7277,$02 Jump to #R$7211.
B $7279
  $72A3

c $7378 Display Lives
E $7378 View the equivalent code in;
. #LIST
. { #ATICATAC$0000 }
. { #JETPAC$70A4 }
. { #LUNARJETMAN$0000 }
. { #PSSST$7325 }
. { #TRANZAM$0000 }
. LIST#
  $7378,$06 Write #N($0002, $04, $04) to #R$5F2B.
@ $737E label=DisplayPlayerLives
N $737E Controller for 1UP lives.
  $737E,$06 Call #R$76E3 with #N($0040, $04, $04) (screen buffer address) for 1UP lives.
  $7384,$03 #REGa=1UP lives remaining (by calling #R$73BD).
  $7387,$03 If 1UP lives are zero, jump to #R$73A6.
  $738A,$03 Else, there are lives to display so call #R$7399.
N $738D Controller for 2UP lives.
@ $738D label=Controller2UPLives
  $738D,$06 Call #R$76E3 with #N($00B0, $04, $04) (screen buffer address) for 2UP lives.
  $7393,$03 #REGa=2UP lives remaining (by calling #R$73CB).
  $7396,$03 If 2UP lives are zero, jump to #R$73AB.
N $7399 Handles displaying the lives count and UDG character.
@ $7399 label=HandlerDisplayLives
  $7399,$02 Add #N$30 to convert to an ASCII character (starting at "0" character).
  $739B,$03 Call #R$7468.
  $739E,$03 #REGde=#R$73B5.
  $73A1,$02 Stash #REGbc and #REGde on the stack.
  $73A3,$03 Jump to #R$7478.
N $73A6 1UP has no lives.
@ $73A6 label=Handler1UPNoLives
  $73A6,$03 Call #R$73AB.
  $73A9,$02 Jump to #R$738D.
N $73AB 2UP has no lives.
@ $73AB label=Handler2UPNoLives
  $73AB,$02 #REGa=ASCII " " (SPACE).
  $73AD,$03 Call #R$7468.
  $73B0,$02 #REGa=ASCII " " (SPACE).
  $73B2,$03 Jump to #R$7468.

N $73B5 The UDG for the lives icon.
@ $73B5 label=UDG_Life
B $73B5,$08,b$01 #UDGTABLE(default,centre) { #UDG#(#PC),attr=$07 } UDGTABLE#

N $73BD Controller for the currently active player.
@ $73BD label=ControllerActiveLives
  $73BD,$06 If #R$5F21 is not zero then jump to #R$73C7.
N $73C3 Return currently active players lives left.
@ $73C3 label=ActivePlayerLives
  $73C3,$03 #REGa=#R$5F2E.
  $73C6,$01 Return.
N $73C7 Return inactive players lives left.
@ $73C7 label=InactivePlayerLives
  $73C7,$03 #REGa=#R$5F32.
  $73CA,$01 Return.
N $73CB Controller for the inactive player.
@ $73CB label=ControllerInactiveLives
  $73CB,$06 If #R$5F21 is zero then jump to #R$73C7.
  $73D1,$02 Jump to #R$73C3.

c $73D3 Check High Score
E $73D3 View the equivalent code in;
. #LIST
. { #JETPAC$6398 }
. { #TRANZAM$605B }
. LIST#
@ $73D3 label=CheckHighScore
  $73D3,$03 #REGhl=#R$5F0E.
  $73D6,$04 #REGde=#R$5F11.
  $73E7,$08 Compare #R$5F10 against #R$5F13.
  $73F1,$03 #REGhl=#R$5F11.
  $73F4,$01 Stash #REGhl on the stack.
  $73F5,$03 #REGde=#R$5F09.
  $73F8,$02 #REGb=#N$03 (scores are held in three digits).
  $7404,$01 Restore #REGhl from the stack.
  $7405,$01 Return.
  $7406,$01 Restore #REGhl from the stack.
  $7407,$03 #REGde=#R$5F09.
  $740A,$03 #REGbc=#N($0003, $04, $04) (scores are held in three digits).
  $740F,$01 Return.
  $7410,$03 #REGhl=#R$5F0E.
  $7413,$02 Jump to #R$73F4.

c $7415 Add Points To Score
E $7415 View the equivalent code in;
. #LIST
. { #JETPAC$70F9 }
. { #PSSST$737A }
. { #TRANZAM$6046 }
. LIST#
R $7415 BC Points to add to score
N $7415 Check the active player.
@ $7415 label=AddPointsToScore
  $7415,$06 If #R$5F21 is not zero, jump to #R$7420.
N $741B Set the score address for 1UP.
  $741B,$03 #REGhl=#R$5F10.
  $741E,$02 Jump to #R$7423.
N $7420 Set the score address for 2UP.
@ $7420 label=AddPointsToScore_2UP
  $7420,$03 #REGhl=#R$5F13.
N $7423 Process adding the points to the appropriate score.
@ $7423 label=AddPointsToScore_Start
  $7423,$01 #REGa=score byte #3.
  $7424,$02 Add #REGc to score byte #3 with BCD conversion.
  $7426,$01 Update score byte #3.
  $7427,$01 Move onto the next score byte.
  $7428,$01 #REGa=score byte #2.
  $7429,$02 Add (with carry) #REGb to score byte #2 with BCD conversion.
  $742B,$01 Update score byte #2.
  $742C,$01 Move onto the next score byte.
  $742D,$01 #REGa=score byte #1.
  $742E,$03 Add #N$00 (i.e. just the carry flag) to score byte #1 with BCD conversion.
  $7431,$01 Update score byte #1.
N $7432 Check the active player.
  $7432,$06 If #R$5F21 is not zero, jump to #R$7440.

c $7438 Print Scores
E $7438 View the equivalent code in;
. #LIST
. { #JETPAC$711C }
. { #LUNARJETMAN$89BF }
. { #PSSST$739D }
. { #TRANZAM$6CB6 }
. LIST#
@ $7438 label=Score_1UP
N $7438 Sets up the 1UP score.
  $7438,$03 #REGhl=#N$4021 (screen buffer address).
  $743B,$03 #REGde=#R$5F0E.
  $743E,$02 Jump to #R$744E.

N $7440 Sets up the 2UP score.
@ $7440 label=Score_2UP
  $7440,$03 #REGhl=#N$4039 (screen buffer address).
  $7443,$03 #REGde=#R$5F11.
  $7446,$02 Jump to #R$744E.

N $7448 Sets up the HI score.
@ $7448 label=Score_HI
  $7448,$03 #REGhl=#N$402D (screen buffer address).
  $744B,$03 #REGde=#R$5F09.

N $744E Prints the score.
@ $744E label=PrintScore
  $744E,$02 #REGb=#N$03.
@ $7450 label=PrintScore_Loop
  $7450,$01 #REGa=#REGde.
  $7451,$04 #REGa=#REGa / #N$10.
  $7455,$02,b$01 Keep only bits 0-3.
  $7457,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $7459,$03 Call #R$7468.
  $745C,$01 #REGa=#REGde.
  $745D,$02,b$01 Keep only bits 0-3.
  $745F,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $7461,$03 Call #R$7468.
  $7464,$01 Increment #REGde by one.
  $7465,$02 Decrease counter by one and loop back to #R$7450 until counter is zero.
  $7467,$01 Return.

c $7468 Print Character
E $7468 View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #PSSST$73CD }
. { #TRANZAM$6C96 }
. LIST#
@ $7468 label=PrintScreen
R $7468 A ASCII value to print
R $7468 HL Screen address
  $7468,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $746B,$03 Create an offset in #REGhl.
  $746E,$03 #REGhl=#REGhl * 8.
  $7471,$04 #HTML(#REGde=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $7475,$02 #REGde=#REGhl + #N$3C00. For examples of usage;
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Letter | =h ASCII Value | =h * 8 (offset) | =h CHARS + offset }
. #FOREACH($55,$4C,$54,$49,$4D,$41,$54,$45)(value,
. { #LET(result=$3C00 + value * $08) "#CHR(value)" | #N(value) | #N(value * 8) | #HTML(<a href="https://skoolkid.github.io/rom/asm/3D00.html##N({result}, 2, 3, 1, 1)()">#N({result})) }
. )
. TABLE#
N $7477 Print the character to the screen.
  $7477,$01 Restore #REGhl, containing the screen buffer location, from the stack.
  $7478,$02 #REGb=#N$08 (#N$08 rows of pixels).
@ $747A label=PrintScreen_Loop
  $747A,$02 Copy a byte from the font data to the screen buffer.
  $747C,$01 Increment the font data by one.
  $747D,$01 Move onto the next pixel line.
  $747E,$02 Decrease counter by one and loop back to #R$747A until counter is zero.
  $7480,$02 Restore #REGde and #REGbc from the stack.
N $7482 Reset #REGhl and move to the next column, ready to print the next character.
  $7482,$04 #REGh=#REGh - #N$08 (reset the display line).
  $7486,$01 Increment screen column by one.
  $7487,$01 Return.

c $7488 Print String
@ $7488 label=PrintString
R $7488 DE Pointer to string data
  $7488,$01 Stash #REGhl on the stack.
  $7489,$03 Call #R$76E3.
  $748C,$01 Fetch the attribute byte.
  $748D,$01 Switch to the shadow #REGaf register.
  $748E,$01 Increment #REGde by one to point to the text of the string.
  $748F,$01 Switch to the shadow registers.
  $7490,$01 Restore #REGhl from the stack.
  $7491,$03 Call #R$7534.

@ $7494 label=PrintString_Loop
  $7494,$01 Switch back to the normal registers.
  $7495,$01 Fetch the character to print.
  $7496,$04 If bit 7 is set (which signifies the end of the string), jump to #R$74A5.
  $749A,$03 Call #R$7468.
  $749D,$01 Increment #REGde by one.
  $749E,$01 Switch to the shadow registers.
  $749F,$01 Switch to the shadow #REGaf register.
  $74A0,$01 Copy the attribute byte to the screen.
  $74A1,$01 Increment #REGl by one.
  $74A2,$01 Switch to the shadow #REGaf register.
  $74A3,$02 Jump to #R$7494.
N $74A5 Because the last character contains the terminator, it needs to be handled separately.
@ $74A5 label=PrintString_LastCharacter
  $74A5,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $74A7,$03 Call #R$7468.
  $74AA,$01 Switch to the shadow registers.
  $74AB,$01 Switch to the shadow #REGaf register.
  $74AC,$01 Copy the attribute byte to the screen.
  $74AD,$01 Return.

c $74AE Print Banner
E $74AE View the equivalent code in;
. #LIST
. { #JETPAC$7192 }
. { #LUNARJETMAN$8A37 }
. { #PSSST$7413 }
. LIST#
@ $74AE label=PrintBanner
N $74AE Prints "1UP".
  $74AE,$03 #REGhl=#N($0018, 4, 4).
  $74B1,$03 #REGde=#R$74C9.
  $74B4,$03 Call #R$7488.
N $74B7 Prints "HI".
  $74B7,$03 #REGhl=#N($0078, 4, 4).
  $74BA,$03 #REGde=#R$74D1.
  $74BD,$03 Call #R$7488.
N $74C0 Prints "2UP".
  $74C0,$03 #REGhl=#N($00D8, 4, 4).
  $74C3,$03 #REGde=#R$74CD.
  $74C6,$03 Jump to #R$7488.
N $74C9 Banner text data.
@ $74C9 label=1UP_Text
T $74C9,$04,h$01,$02:$01 "1UP" (#N(#PEEK(#PC)) is the attribute).
@ $74CD label=2UP_Text
T $74CD,$04,h$01,$02:$01 "2UP" (#N(#PEEK(#PC)) is the attribute).
@ $74D1 label=HI_Text
T $74D1,$03,h$01,$01:$01 "HI" (#N(#PEEK(#PC)) is the attribute).

c $74D4 Reset Screen Buffer
E $74D4 View the equivalent code in;
. #LIST
. { #ATICATAC$80B4 }
. { #JETPAC$71B8 }
. { #LUNARJETMAN$84AD }
. { #PSSST$7439 }
. { #TRANZAM$7211 }
. LIST#
@ $74D4 label=ResetScreen
E $74D4 Continue on to #R$74DB to blank the screen buffer.
  $74D4,$03 #REGhl=#R$4000(screen buffer).
  $74D7,$02 #REGb=#N$58 (i.e. finish once we reach the start of #R$5800(attribute buffer)).
  $74D9,$02 #REGc=#N$00 (value to write).

c $74DB Reset Routine
E $74DB View the equivalent code in;
. #LIST
. { #ATICATAC$80BB }
. { #JETPAC$71B8 }
. { #LUNARJETMAN$84B4 }
. { #PSSST$7440 }
. { #TRANZAM$7218 }
. LIST#
R $74DB HL Target address
R $74DB B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $74DB C Value to write
@ $74DB label=ResetCopier
  $74DB,$01 Write #REGc to the target address.
  $74DC,$01 Increment the target address by one.
  $74DD,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $74DF,$02 Keep looping back to #R$74DB until there is no carry-over.
  $74E1,$01 Return.

c $74E2 Reset Attribute Buffer
E $74E2 View the equivalent code in;
. #LIST
. { #ATICATAC$80C2 }
. { #JETPAC$71C6 }
. { #LUNARJETMAN$84BB }
. { #PSSST$7447 }
. { #TRANZAM$7200 }
. LIST#
@ $74E2 label=ResetAttributes
  $74E2,$03 Set the border to black.
  $74E5,$03 #REGhl=#R$5800(attribute buffer).
  $74E8,$02 #REGb=#N$5B (i.e. finish once we reach the end of the #R$5800(attribute buffer)).
  $74EA,$02 #REGc=#N$00 (value to write).
  $74EC,$02 Jump to #R$74DB.

c $74EE
  $74EF,$03 #REGhl=#R$5F1F.
  $74F2,$03 Call #R$7534.
  $7500,$02,b$01 Keep only bits 0-4.
  $7513,$02,b$01 Keep only bits 0-4.
  $7515
  $751C,$02,b$01 Keep only bits 0-4.
  $7524,$02 Decrease counter by one and loop back to #R$7509 until counter is zero.
  $7529,$03 #REGbc=#N$0020.
  $7533,$01 Return.

c $7534 Calculate Attribute Address
E $7534 View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #JETPAC$720E }
. { #LUNARJETMAN$8506 }
. { #PSSST$748F }
. { #TRANZAM$7097 }
. LIST#
@ $7534 label=AttributeAddress
N $7534 Converts a given pixel address to the associated attribute buffer address.
R $7534 HL Pixel address co-ordinates
R $7534 O:HL Attribute buffer address
  $7534,$01 Horizontal co-ordinate.
  $7535,$03 Divide by #N08.
  $7538,$02,b$01 Keep only bits 0-4 (#N$00-#N$1F / minimum-maximum horizontal screen values).
  $753A,$01 Store this back in #REGl.
  $753B,$01 Vertical co-ordinate.
  $753C,$02 Multiply by #N$04.
  $753E,$01 Store this in #REGc temporarily.
  $753F,$02,b$01 Keep only bits 5-7.
  $7541,$01 Set the bits from #REGl.
  $7542,$01 #REGl=#REGa.
  $7543,$01 Fetch the stored value from #REGc.
  $7544,$02,b$01 Keep only bits 0-1.
  $7546,$02,b$01 Set MSB of the attribute buffer #N$58. This ensures our value is >= #R$5800.
  $7548,$01 Store this back in #REGh.
  $7549,$01 Return.

c $754A

c $7557
  $7557,$03 Call #R$7623.
  $755A,$03 #REGhl=#R$5F14.
  $7560,$02,b$01 Keep only bits 1-3.
  $756B,$03 Call #R$754A.
  $756E,$03 Call #R$76E3.
  $7575,$01 #REGa=#N$00.
  $7576,$03 Write #REGa to #R$5F19.
  $757B,$02 #REGb=#N$00.

c $7584
  $7584,$03 Call #R$7635.
  $7590,$02,b$01 Keep only bits 1-3.
  $75A3,$03 Call #R$754A.
  $75A9,$03 Call #R$76E3.
  $75B0,$01 #REGa=#N$00.
  $75B7,$02 #REGb=#N$00.
  $75BE,$02 Jump to #R$7580.
  $75C6,$03 Call #R$7587.
  $75CA,$02 Jump to #R$75D3.

c $75CC

c $7623 Fetch Sprite
R $7623 O:DE The sprite memory address
@ $7623 label=GetDefaultSprite
  $7623,$03 #REGa=#R$5F16.
@ $7626 label=GetSprite
  $7626,$01 Decrease #REGa by one.
  $7627,$01 Multiply by 2 as the table contains addresses.
  $7628,$02,b$01 Keep only bits 1-6.
  $762A,$03 #REGhl=#R$7702(sprite lookup table).
  $762D,$04 Calculate the lookup address (#REGhl + offset).
  $7631,$03 #REGde=fetch sprite address pointed to by #REGhl.
  $7634,$01 Return.

N $7635 This entry point is used by the routine at #R$7584.
@ $7635 label=ActorGetSprite
  $7635,$03 Load the sprite ID from the currently active actor.
  $7638,$02 Jump to #R$7626.

c $763A
B $767C
  $768F

c $76D0 Test...
@ $76D0 @label=ActorUpdateMove
  $76D0,$06 Copy actor X position to active actor X position.
  $76D6,$06 Copy actor Y position to active actor Y position.
  $76DC,$06 Copy actor movement to active actor movement.
  $76E2,$01 Return.

c $76E3 Calculate Screen Address
E $76E3 View the equivalent code in;
. #LIST
. { #ATICATAC$9BA2 }
. { #JETPAC$7308 }
. { #LUNARJETMAN$851E }
. { #PSSST$759A }
. { #TRANZAM$6F10 }
. LIST#
@ $76E3 label=ScreenAddress
  $76E3,$01 #REGa=#REGl.
  $76E4,$03 #REGa=#REGa / #N$08.
  $76E7,$02,b$01 Keep only bits 0-4.
  $76E9,$01 #REGl=#REGa.
  $76EA,$01 #REGa=#REGh.
  $76EB,$02 #REGa=#REGa * #N$04.
  $76ED,$02,b$01 Keep only bits 5-7.
  $76EF,$01
  $76F0,$01 #REGl=#REGa.
  $76F1,$01 #REGa=#REGh.
  $76F2,$02,b$01 Keep only bits 0-2.
  $76F4,$01 Switch to the shadow #REGaf register.
  $76F5,$01 #REGa=#REGh.
  $76F6,$03 #REGa=#REGa / #N$08.
  $76F9,$02,b$01 Keep only bits 3-4.
  $76FB,$02,b$01 Set bit 6.
  $76FD,$01 #REGh=#REGa.
  $76FE,$01 Switch to the shadow #REGaf register.
  $76FF,$01
  $7700,$01 #REGh=#REGa.
  $7701,$01 Return.

w $7702 Sprites Table
E $7702 View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$761A }
. { #TRANZAM$0000 }
. LIST#
@ $7702 label=SpritesTable
  $7702,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#EVAL((#PC - $7702) / 2)).
L $7702,$02,$30

b $7762 Sprite: Cake
N $7762 Sprite #N$2B - Cake 1
  $7762,$01 width = #PEEK(#PC) bytes.
  $7763 #SPRITE(#PC,7)(cake-01)

N $7783 Sprite #N$2C - Cake 2
  $7783,$01 width = #PEEK(#PC) bytes.
  $7784 #SPRITE(#PC,7)(cake-02)

N $77A4 Sprite #N$2D - Cake 3
  $77A4,$01 width = #PEEK(#PC) bytes.
  $77A5 #SPRITE(#PC,7)(cake-03)

N $77C5 Sprite #N$2E - Cake 4
  $77C5,$01 width = #PEEK(#PC) bytes.
  $77C6 #SPRITE(#PC,7)(cake-04)

N $77E6 Sprite #N$2F - Cake 5
  $77E6,$01 width = #PEEK(#PC) bytes.
  $77E7 #SPRITE(#PC,7)(cake-05)

b $7807
E $7807 #UDGARRAY*batter-01,50;batter-02;batter-03;batter-04(batter)
N $7807 Frame 1.
  $7807,$01 width = #PEEK(#PC) bytes.
  $7808 #SPRITE(#PC,7)(batter-01*)

N $781C Frame 2.
  $781C,$01 width = #PEEK(#PC) bytes.
  $781D #SPRITE(#PC,7)(batter-02*)

N $7831 Frame 3.
  $7831,$01 width = #PEEK(#PC) bytes.
  $7832 #SPRITE(#PC,7)(batter-03*)

N $7846 Frame 4.
  $7846,$01 width = #PEEK(#PC) bytes.
  $7847 #SPRITE(#PC,7)(batter-04*)

b $785B Sprite: Flour Explosion
E $785B #UDGARRAY*explosion-02,50;explosion-01(explosion)
N $785B Frame 1.
  $785B,$01 width = #PEEK(#PC) bytes.
  $785C #SPRITE(#PC,7)(explosion-01*)

N $786C Frame 2.
  $786C,$01 width = #PEEK(#PC) bytes.
  $786D #SPRITE(#PC,7)(explosion-02*)

b $7883 Sprite: Charlie the Chef
N $7883 Sprite #N$00 - Frame 1.
  $7883,$01 width = #PEEK(#PC) bytes.
  $7884 #UDGARRAY2,attr=7,scale=4,step=2,mask=1,flip=2;(#PC)-(#PC+$11)-$01-$10(charlie-01)

N $78AC Sprite #N$01 - Frame 2.
  $78AC,$01 width = #PEEK(#PC) bytes.
  $78AD #UDGARRAY2,attr=7,scale=4,step=2,mask=1,flip=2;(#PC)-(#PC+$11)-$01-$10(charlie-02)

N $78D5
  $78D5,$01 width = #PEEK(#PC) bytes.
  $78D6 #SPRITE(#PC,7)(charlie-hat)

N $78E2
  $78E2,$01 width = #PEEK(#PC) bytes.
  $78E3 #SPRITE(#PC,7)(whoknows15)

N $78FF
  $78FF,$01 width = #PEEK(#PC) bytes.
  $7900 #SPRITE(#PC,7)(whoknows16)

b $791C Sprite: Flour Bag
N $791C Sprite #N$02.
  $791C,$01 width = #PEEK(#PC) bytes
  $791D #SPRITE(#PC,7)(flour)

b $7933 Sprite: Colonel Custard
E $7933 #UDGARRAY*custard-02,50;custard-01(custard)
N $7933 Sprite #N$03 - Frame 1.
  $7933,$01 width = #PEEK(#PC) bytes
  $7934 #SPRITE(#PC,6)(custard-01*)

N $794E Sprite #N$04 - Frame 2.
  $794E,$01 width = #PEEK(#PC) bytes
  $794F #SPRITE(#PC,6)(custard-02*)

b $796D Sprite: Chunky Chocolate
E $796D #UDGARRAY*chocolate-01,50;chocolate-02(chocolate)
N $796D Frame 1.
  $796D,$01 width = #PEEK(#PC) bytes
  $796E #SPRITE(#PC,2)(chocolate-01*)

N $798E Frame 2.
  $798E,$01 width = #PEEK(#PC) bytes
  $798F #SPRITE(#PC,2)(chocolate-02*)

b $79AF Sprite: Sneaky Sugar
E $79AF #UDGARRAY*sugar-01,50;sugar-02(sugar)
N $79AF Frame 1.
  $79AF,$01 width = #PEEK(#PC) bytes
  $79B0 #SPRITE(#PC,4)(sugar-01*)

N $79CE Frame 2.
  $79CE,$01 width = #PEEK(#PC) bytes
  $79CF #SPRITE(#PC,4)(sugar-02*)

b $79ED Sprite: Mixed Peel
E $79ED #UDGARRAY*peel-01,50;peel-02(peel)
N $79ED Frame 1.
  $79ED,$01 width = #PEEK(#PC) bytes
  $79EE #SPRITE(#PC,3)(peel-01*)

N $7A0C Frame 2.
  $7A0C,$01 width = #PEEK(#PC) bytes
  $7A0D #SPRITE(#PC,3)(peel-02*)

b $7A29 Sprite: Crafty Cheese
E $7A29 #UDGARRAY*cheese-01,50;cheese-02(cheese)
N $7A29 Frame 1.
  $7A29,$01 width = #PEEK(#PC) bytes
  $7A2A #SPRITE(#PC,6)(cheese-01*)

N $7A4C Frame 2.
  $7A4C,$01 width = #PEEK(#PC) bytes
  $7A4D #SPRITE(#PC,6)(cheese-02*)

b $7A6F Sprite: Bernie Bolt
D $7A6F Sprite #N$21.
  $7A6F,$01 width = #PEEK(#PC) bytes.
  $7A70 #SPRITE(#PC,7)(bolt)

b $7A90 Sprite: Wally Washer
D $7A90 Sprite #N$1F + #N$20.
  $7A90,$01 width = #PEEK(#PC) bytes.
  $7A91 #SPRITE(#PC,7)(washer)

b $7AB1 Sprite: Terry Tack
D $7AB1 Sprite #N$1E.
  $7AB1,$01 width = #PEEK(#PC) bytes.
  $7AB2 #SPRITE(#PC,7)(tack)

b $7AD2 Sprite: Mike The Pike
  $7AD2,$01 width = #PEEK(#PC) bytes.
  $7AD3 #SPRITE(#PC,7)(pike)

b $7AF3 Sprite: Tin Tin Can
  $7AF3,$01 width = #PEEK(#PC) bytes.
  $7AF4 #SPRITE(#PC,7)(tin-can)

b $7B14 Sprite: Bin Monster
N $7B14 Sprite #N$23 - Frame 1.
E $7B14 #UDGARRAY*monster-01,50;monster-02(monster)
  $7B14,$01 width = #PEEK(#PC) bytes.
  $7B15 #SPRITE(#PC,7)(monster-01*)
N $7B2F Sprite #N$24 - Frame 2.
  $7B2F,$01 width = #PEEK(#PC) bytes.
  $7B30 #SPRITE(#PC,7)(monster-02*)

b $7B4A Cupboard Graphic
@ $7B4A label=CupboardGraphic
N $7B4A ID: "#EVAL((#PC - $7B4A) / $08)".
  $7B4A,b,$01 #UDG(#PC)
L $7B4A,$08,$60


i $8000
b $B800
i $B801
