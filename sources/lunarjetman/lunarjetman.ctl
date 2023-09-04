> $4000 @org=$4000
> $4000 @start=$5B80
b $4000 Loading screen
D $4000 #UDGTABLE { =h Lunar Jetman Loading Screen } { #SCR$02(loading) } UDGTABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

c $5B80 Decryption Routine
N $5B80 Runs "RRD" on every byte from #N$7FFF-#N$FBFF.
E $5B80 View the equivalent code in #ATICATAC$5B80.
E $5B80 Earlier Ultimate games use a much simpler mechanism;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #PSSST$5B80 }
. { #TRANZAM$5B80 }
. LIST#
@ $5B80 label=GameEntry
  $5B80,$03 #REGhl=#N$7FFF.
  $5B83,$03 #REGbc=#N$007C.
  $5B86,$01 Reset the flags.
@ $5B87 label=Decryption_Loop
  $5B87,$02 RRD operation.
  $5B89,$01 Increment #REGhl by one.
  $5B8A,$02 Decrease counter by one and loop back to #R$5B87 until counter is zero.
  $5B8C,$01 Decrease #REGc by one.
  $5B8D,$02 Loop back to #R$5B87 until #REGc is zero.
  $5B8F,$03 Jump to #R$8000.

i $5B92

c $5CB0 Indirect Jump
@ $5CB0 label=IndirectJump
  $5CB0,$01 Jump to the address held in #REGhl.

i $5CB1

g $5E00 Game Options
@ $5E00 label=GameOptions
B $5E00,$01

g $5E01

g $5E04 Font Pointer
D $5E04 Holds a pointer to the currently used font data.
@ $5E04 label=FontPointer
W $5E04,$02

g $5E06 High Score
E $5E06 View the equivalent code in;
. #LIST
. { #COOKIE$5F09 }
. { #JETPAC$5CF0 }
. { #PSSST$5E00 }
. LIST#
D $5E06 3-byte representation of the score.
@ $5E06 label=High_Score

g $5E09

g $5E20

g $5E35

g $5E38

g $5E40

g $5E42

g $5E50

g $5E52

g $5E53 Last Frame
D $5E53 #HTML(Holds a copy of the last <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> counter.)
@ $5E53 label=LastFrame
  $5E53,$01

g $5E56
g $5E57
g $5E58
g $5E59
g $5E5A

g $5E5D
g $5E5E

g $5E5F 1UP Score
D $5E5F 3-byte representation of the score.
@ $5E5F label=1UP_Score_1
  $5E5F,$01 Byte #1.
@ $5E60 label=1UP_Score_2
  $5E60,$01 Byte #2.
@ $5E61 label=1UP_Score_3
  $5E61,$01 Byte #3.

g $5E62 2UP Score
D $5E62 3-byte representation of the score.
@ $5E62 label=2UP_Score_1
  $5E62,$01 Byte #1.
@ $5E63 label=2UP_Score_2
  $5E63,$01 Byte #2.
@ $5E64 label=2UP_Score_3
  $5E64,$01 Byte #3.

g $5E65 Active Player
@ $5E65 label=Flag_ActivePlayer
D $5E65 Which player is currently active.
. $5E65 #TABLE(default,centre,centre) { =h Value | =h Player }
. { #N$00 | 1UP }
. { #N$FF | 2UP }
. TABLE#

g $5E66 Current menu item colour attribute
@ $5E66 label=Current_MenuAttr
  $5E66,$01

g $5E67 Game Delay Timer
@ $5E67 label=GameDelayTimer
D $5E67 At the beginning of each player turn there is a delay to allow the player to be ready for play.
. #TABLE(default,centre,centre)
. { =h Value | =h Game Mode }
. { #N$80 | 1UP }
. { #N$FF | 2UP }
. TABLE#
. The larger delay for a 2UP game is useful for swapping players controls.

g $5E68

g $5E6C
g $5E6D
g $5E6F

g $5E71 Number of players?

g $5E73

g $5E74

g $5E75

g $5E77 High Score Position
D $5E77 Used when calculating the players position in the high score table.
@ $5E77 label=HighScorePosition
  $5E77,$01

g $5E78

g $5E7C

g $5EA0 Active Player Level
@ $5EA0 label=ActivePlayer_Level
B $5EA0,$01

g $5EA1 Active Player Lives
@ $5EA1 label=ActivePlayer_Lives
B $5EA1,$01

g $5EA2
g $5EA3

g $5EA4 Inactive Player Level
@ $5EA4 label=InactivePlayer_Level
B $5EA4,$01

g $5EA5 Inactive Player Lives
@ $5EA5 label=InactivePlayer_Lives
B $5EA5,$01

g $5EA6
g $5EA7

g $6000 Laser Beam Parameters
E $6000 View the equivalent code in;
. #LIST
. { #JETPAC$5D08 }
. LIST#
D $6000 #TABLE(default,centre) { =h Bytes(n) | =h Variable }
. TABLE#
@ $6000 label=Laser_Param_1
B $6000,$18 Laser Beam #1.
@ $6018 label=Laser_Param_2
B $6018,$18 Laser Beam #2.
@ $6030 label=Laser_Param_3
B $6030,$18 Laser Beam #3.
@ $6048 label=Laser_Param_4
B $6048,$18 Laser Beam #4.

b $6060
  $6060,$2E,$01

g $608E Fuel Level
@ $608E label=FuelLevel_1
@ $608F label=FuelLevel_2
  $608E,$02,$01

b $6090

b $6195

b $6198 Bomb States?
@ $6198 label=Bomb_StatesTBC
  $6198,$08,$01

g $61B0 Alien States
@ $61B0 label=Alien_States
D $61B0 There are a maximum of 6 aliens on the screen at one time, and those states
. are stored here in this data block.
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h Byte | =h State | =h Byte | =h State | =h Byte | =h State }
. { #N$00 | TBC | #N$08 | TBC | #N$10 | TBC }
. { #N$01 | TBC | #N$09 | TBC | #N$11 | TBC }
. { #N$02 | TBC | #N$0A | TBC | #N$12 | TBC }
. { #N$03 | TBC | #N$0B | TBC | #N$13 | TBC }
. { #N$04 | TBC | #N$0C | TBC | #N$14 | TBC }
. { #N$05 | TBC | #N$0D | TBC | #N$15 | TBC }
. { #N$06 | TBC | #N$0E | TBC | #N$16 | TBC }
. { #N$07 | TBC | #N$0F | TBC | #N$17 | TBC }
. TABLE#
  $61B0,$18 Slot 1.
  $61C8,$18 Slot 2.
  $61E0,$18 Slot 3.
  $61F8,$18 Slot 4.
  $6210,$18 Slot 5.
  $6228,$18 Slot 6.

b $6240

b $7000 Active Terrain Data
@ $7000 label=TerrainData_Active
  $7000,$400,$10

b $7400 Inactive Terrain Data
@ $7400 label=TerrainData_Inactive
  $7400,$400,$10

b $7800

c $8000 Security Check
E $8000 Continue on to #R$800A.
E $8000 View the equivalent code in;
. #LIST
. { #ATICATAC$6000 }
. { #COOKIE$5F00 }
. { #JETPAC$61E5 }
. { #PSSST$61C6 }
. { #SABREWULF$995A }
. { #TRANZAM$5F00 }
. LIST#
@ $8000 label=SecurityCheck
  $8000,$01 Disable interrupts.
  $8001,$03 Set the stack pointer to #N$5E00.
  $8004,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $8007,$03 Return if #REGa is not #N$83.

c $800A Game Initialisation
E $800A View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #COOKIE$6298 }
. { #JETPAC$61EB }
. { #PSSST$61CD }
. { #TRANZAM$5F07 }
. LIST#
@ $800A label=GameInitialisation
@ $8010 label=GameInitialisation_Loop
  $800A,$0E Write #N$00 to #N$2200 bytes starting from #R$5E00.
  $8018,$06 Write #R$D347 to #R$5E04.
  $801E,$03 Call #R$9C23.
  $8021,$03 Call #R$84D8.
  $8024,$03 #REGde=#R$BA2A.
  $8027,$03 Call #R$B9BC.
  $802A,$02 Jump to #R$8035.
@ $802C label=Game_Restart
  $802C,$03 Call #R$84D8.
  $802F,$03 Call #R$F410.
  $8032,$03 Call #R$84D8.
@ $8035 label=GameSelect_Loop
  $8035,$03 Call #R$80D1.
  $8038,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $803E,$01 Flip the bits.
  $803F,$01 #REGe=#REGa.
  $8040,$03 #REGa=#R$5E00.
  $8043,$03 Write #REGa to #R$5E7C.

N $8046 Handle 1UP selection.
@ $8046 label=GameSelect_CheckP1
  $8046,$02 Has key "1" been pressed? ("1 PLAYER GAME").
  $8048,$02 If not jump to #R$804C.
  $804A,$02 Set player count = 1.
N $804C Handle 2UP selection.
@ $804C label=GameSelect_CheckP2
  $804C,$02 Has key "2" been pressed? ("2 PLAYER GAME").
  $804E,$02 If not jump to #R$8052.
  $8050,$02 Set player count = 2.
N $8052 Handle Keyboard selection.
@ $8052 label=GameSelect_CheckKeyboard
  $8052,$02 Has key "3" been pressed? ("3 KEYBOARD").
  $8054,$02 If not jump to #R$8058.
  $8056,$02,b$01 Set control method = keyboard.
N $8058 Handle Kempston Joystick selection.
@ $8058 label=GameSelect_CheckKempston
  $8058,$02 Has key "4" been pressed? ("4 KEMPSTON JOYSTICK").
  $805A,$02 If not jump to #R$8060.
  $805C,$02,b$01 Strip out the control method bits.
  $805E,$02,b$01 Set control method = kempston.
N $8060 Handle Cursor Joystick selection.
@ $8060 label=GameSelect_CheckCursor
  $8060,$02 Has key "5" been pressed? ("5 CURSOR JOYSTICK").
  $8062,$02 If not jump to #R$8068.
  $8064,$02,b$01 Strip out the control method bits.
  $8066,$02,b$01 Set control method = cursor.
N $8068 Handle starting a new game.
@ $8068 label=GameSelect_StartGame
  $8068,$03 Store #REGa at #R$5E00.
  $806B,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $8071,$01 Flip the bits.
  $8072,$02 Has key "6" been pressed? ("6 START GAME").
  $8074,$03 If so, jump to #R$81BB.

  $8077,$04 #REGc=#R$5E00.
  $807B,$03 #REGa=#R$5E7C.

  $807F,$01 Stash #REGaf on the stack.
  $8085,$01 Restore #REGaf from the stack.
  $8086,$02,b$01 Keep only bits 1-2.
  $808A,$03 #REGde=#R$BA9E.
  $808D,$01 #REGa=#REGc.
  $808E,$02,b$01 Keep only bits 1-2.
  $8090,$03 Create an offset in #REGhl.
  $8093,$01 #REGhl=#R$BA9E + offset.
  $8094,$03 #REGde=address held at #REGhl.
  $8097,$03 Call #R$B9BC.
N $809A Handle flashing each selection.
  $809A,$03 #REGhl=#R$810F(GameSelection_Attributes)+#N$01 (i.e. ignoring "Game Selection" as it doesn't flash).
  $809D,$04 #REGc=#R$5E00.
@ $80A8 label=MenuAttrHandler
  $80A8,$02 #REGb=#N$03.
@ $80AC label=MenuAttrHandler_Loop
  $80AC,$02,b$01
  $80B6,$03 Jump to #R$8035.
  $80B9,$03 Call #R$80CD.
  $80BC,$02 Jump to #R$80B3.
  $80BE,$03 Call #R$80CA.
  $80C1,$02 Jump to #R$80A8.
N $80C3 Set the first menu item, unset the second.
@ $80C3 label=MenuAttributeSetUnset
  $80C3,$02 Set the FLASH attribute for the menu attribute.
  $80C5,$01 Move onto the next menu attribute.
@ $80C6 label=MenuAttributeUnSetFirst
  $80C6,$02 Unset the FLASH attribute for the menu attribute.
  $80C8,$01 Move onto the next menu attribute.
  $80C9,$01 Return.
N $80CA Unset the first menu item, set the second.
@ $80CA label=MenuAttributeUnsetSet
  $80CA,$02 Unset the FLASH attribute for the menu attribute.
  $80CC,$01 Move onto the next menu attribute.
@ $80CD label=MenuAttributeSetFirst
  $80CD,$02 Set the FLASH attribute for the menu attribute.
  $80CF,$01 Move onto the next menu attribute.
  $80D0,$01 Return.

c $80D1 Game Selection Menu
E $80D1 View the equivalent code in;
. #LIST
. { #ATICATAC$7CAF }
. { #COOKIE$6332 }
. { #JETPAC$0000 }
. { #PSSST$6250 }
. { #TRANZAM$0000 }
. LIST#
@ $80D1 label=GameMenu
  $80D1,$03 #REGde=#R$810E.
  $80D4,$01 Switch to the shadow registers.
  $80D5,$03 #REGhl'=#R$8115.
  $80D8,$03 #REGde'=#R$811C.
N $80DB There are seven lines of text.
  $80DB,$02 #REGb'=#N$07 (counter).
@ $80DD label=GameMenu_Loop
  $80DD,$01 Switch back to the normal registers.
  $80DE,$04 Copy a byte from #REGde to #R$5E66.
  $80E2,$01 Increment #REGde by one.
  $80E3,$01 Switch to the shadow registers.
  $80E4,$01 Stash #REGbc' on the stack.
  $80E5,$01 #REGa=#REGhl' (grab the position data).
  $80E6,$01 Increment #REGhl' (position data pointer) by one.
  $80E7,$01 Stash #REGhl' (position data pointer) on the stack.
  $80E8,$03 #REGh'=#REGa #REGl'=#N$38.
  $80EB,$03 Call #R$81AB.
  $80EE,$01 Switch back to the normal registers.
  $80EF,$02 Restore #REGhl and #REGbc from the stack.
  $80F1,$01 Increment #REGde by one.
  $80F2,$02 Decrease counter by one and loop back to #R$80DD until counter is zero.
  $80F4,$03 #REGhl=#N($B800, $04, $04) (screen buffer location).
  $80F7,$03 #REGde=#R$818A.
  $80FA,$03 Jump to #R$8A11.

c $80FD
  $80FD,$03 #REGde=#R$BAA4.
  $8100,$01 #REGa=#REGc.
  $8101,$01 Rotate bit 0 to bit 1.
  $8102,$02,b$01 Keep only bit 1.
  $8104,$03 Create an offset in #REGhl.
  $8107,$01 #REGhl=#R$BAA4 + offset.
  $8108,$03 #REGde=#REGhl.
  $810B,$03 Jump to #R$B9BC.

b $810E Game Select Attribute Table
E $810E View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #COOKIE$635E }
. { #JETPAC$628D }
. { #PSSST$627C }
. { #TRANZAM$5FA7 }
. LIST#
@ $810E label=GameSelection_Attributes
  $810E,$07,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | Game Selection }
. { #N$02 | 1 Player Game }
. { #N$03 | 2 Player Game }
. { #N$04 | 3 Keyboard }
. { #N$05 | 4 Kempston Joystick }
. { #N$06 | 5 Cursor Joystick }
. { #N$07 | 6 Start Game }
. TABLE#

b $8115 Game Select Y Position Table
E $8115 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF1 }
. { #COOKIE$6365 }
. { #JETPAC$6293 }
. { #PSSST$6282 }
. { #TRANZAM$5FAC }
. LIST#
@ $8115 label=GameSelection_Position
  $8115,$07,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | Game Selection }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | 1 Player Game }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | 2 Player Game }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | 3 Keyboard }
. { #N$05 | #EVAL(#PEEK(#PC+$04) / $08) | 4 Kempston Joystick }
. { #N$06 | #EVAL(#PEEK(#PC+$05) / $08) | 5 Cursor Joystick }
. { #N$07 | #EVAL(#PEEK(#PC+$06) / $08) | 6 Start Game }
. TABLE#

t $811C Messaging: Game Selection Title
E $811C View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #COOKIE$636C }
. { #JETPAC$6299 }
. { #PSSST$6288 }
. { #TRANZAM$5FB1 }
. LIST#
N $811C #FONT:(GAME SELECTION)addr=$D347,attr=$47(game-selection)
@ $811C label=String_GameSelection
  $811C,$0E,$0D:$01 "GAME SELECTION".
N $812A #FONT:(1  1 PLAYER GAME)addr=$D347,attr=$47(1up-game)
@ $812A label=String_1UP_Game
  $812A,$10,$0F:$01 "1  1 PLAYER GAME".
N $813A #FONT:(2  2 PLAYER GAME)addr=$D347,attr=$47(2up-game)
@ $813A label=String_2UP_Game
  $813A,$10,$0F:$01 "2  2 PLAYER GAME".
N $814A #FONT:(3  KEYBOARD)addr=$D347,attr=$47(keyboard)
@ $814A label=String_Keyboard
  $814A,$0B,$0A:$01 "3  KEYBOARD".
N $8155 #FONT:(4  KEMPSTON JOYSTICK)addr=$D347,attr=$47(kempston)
@ $8155 label=String_Kempston
  $8155,$14,$13:$01 "4  KEMPSTON JOYSTICK".
N $8169 #FONT:(5  CURSOR   JOYSTICK)addr=$D347,attr=$47(cursor)
@ $8169 label=String_Cursor
  $8169,$14,$13:$01 "5  CURSOR   JOYSTICK".
N $817D #FONT:(6  START GAME)addr=$D347,attr=$47(start-game)
@ $817D label=String_StartGame
  $817D,$0D,$0C:$01 "6  START GAME".

t $818A Messaging: Copyright
N $818A #FONT:(% 1983 A.C.G. ALL RIGHTS RESERVED)addr=$D347,attr=$45(copyright)
@ $818A label=String_Copyright
E $818A View the equivalent code in #ATICATAC$7D51.
  $818A,$21,h$01,c$01,$1E:$01 Attribute: #N(#PEEK(#PC)) + "© 1983 A.C.G. ALL RIGHTS RESERVED".

c $81AB Write Menu Line
E $81AB View the equivalent code in;
. #LIST
. { #ATICATAC$7D8A }
. { #COOKIE$63E0 }
. { #JETPAC$0000 }
. { #PSSST$62E7 }
. { #TRANZAM$0000 }
. LIST#
@ $81AB label=MenuWriteText
  $81AB,$01 Stash #REGhl containing the co-ordinate on the stack.
  $81AC,$03 Call #R$851E.
  $81AF,$03 #REGa=the menu attribute byte from #R$5E66.
  $81B2,$01 Switch to the shadow #REGaf register.
  $81B3,$01 Switch to the shadow registers.
  $81B4,$01 Restore #REGhl from the stack.
  $81B5,$03 Call #R$8506.
  $81B8,$03 Jump to #R$8A1D.

c $81BB Start Game
E $81BB View the equivalent code in;
. #LIST
. { #ATICATAC$7D9A }
. { #COOKIE$6428 }
. { #JETPAC$6333 }
. { #PSSST$631E }
. { #TRANZAM$5FEF }
. LIST#
@ $81BB label=StartGame
  $81BB,$03 #REGde=#R$BA35.
  $81BE,$03 Call #R$B9BC.
N $81C1 Reset Planet data.
  $81C1,$03 #REGhl=#R$5E50.
  $81C4,$03 #REGbc=#R$6000.
  $81C7,$03 Call #R$84B2.
  $81CA,$03 Call #R$84F7.
  $81CD,$03 Call #R$A84C.
  $81D0,$03 Call #R$822F.
  $81D3,$03 Call #R$A826.
  $81D6,$03 Set the stack pointer to #R$5E00.
  $81D9,$07 If #R$5E68 is not zero, call #R$A2CF.
  $81E0,$01 Enable interrupts.
  $81E1,$04 Write #N$00 to #R$5E5E.
  $81E5,$04 #REGix=#R$6078.
  $81E9,$04 #HTML(#REGc=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $81F4,$03 #REGhl=#R$8259.
  $81F7,$01 Stash #REGhl on the stack.
  $81F8,$03 #REGbc=#R$82C5.

  $8206,$03 Jump to #R$5CB0.

c $8209
  $8209,$01 Disable interrupts.
  $820A,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $8210,$05 Write #N$01 to #R$5E52.
  $8217,$06 Write #N$6078 to #R$8261(#N$8262).
  $821D,$05 Write #N$C3 to #R$826A.
  $8222,$06 Write #R$823F to #R$826B.
  $8228,$04 #REGix=#R$6000.
  $822C,$03 Jump to #R$81E9.

c $822F
  $822F,$06 Write #R$6240 to #R$8261(#N$8262).
  $8235,$09 Write #N$00 to #R$826A, #R$826B and #R$826C.
  $823E,$01 Return.

c $823F
  $823F,$03 Call #R$822F.
  $8248,$01 Enable interrupts.
  $8249,$01 Return.

c $824A
  $824A,$03 #REGa=#R$5E52.
  $824F,$03 #REGhl=#N($00C0,$04,$04).
  $8252,$01 Decrease #REGhl by one.
  $8253,$04 Jump to #R$8252 until #REGhl is zero.
  $8257,$01 Return.

c $8258
  $8258,$01 Return.

B $826A,$03,$01

c $8298 Controls: Pause
@ $8298 label=ControlsPause
  $8298,$01 Disable interrupts.
  $8299,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DF | P | O | I | U | Y }
. TABLE#
N $829F If key "O" is not being pressed, then just return.
  $829F,$03 Return if bit 1 is not set.
N $82A2 Return if any other key has been pressed with "O".
  $82A2,$01 Flip the bits.
  $82A3,$02,b$01 Keep only bits 0, 2-4.
  $82A5,$01 Return if the result is not zero.
N $82A6 Loop until the "O" button is released.
@ $82A6 label=GamePaused_Debounce
  $82A6,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DF | P | O | I | U | Y }
. TABLE#
  $82AC,$04 Jump to #R$82A6 if bit 1 is set.
N $82B0 Creates an infinite loop which only exits when "O" is pressed again.
@ $82B0 label=GamePaused
  $82B0,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DF | P | O | I | U | Y }
. TABLE#
  $82B6,$04 Jump to #R$82B0 if bit 1 is not set.
N $82BA Likewise, to prevent the pause from recurring instantly, loop until the "O" button is released.
@ $82BA label=GamePaused_Debounce_Exit
  $82BA,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DF | P | O | I | U | Y }
. TABLE#
  $82C0,$04 Jump to #R$82BA if bit 1 is set.
  $82C4,$01 Return.

w $82C5 Jump Table
@ $82C5 label=JumpTable

c $84AD Reset Screen Buffer
E $84AD Continue on to #R$84B4 to blank the screen buffer.
E $84AD View the equivalent code in;
. #LIST
. { #ATICATAC$80B4 }
. { #COOKIE$74D4 }
. { #JETPAC$71B8 }
. { #PSSST$7439 }
. { #TRANZAM$7211 }
. LIST#
@ $84AD label=ResetScreen
  $84AD,$03 #REGhl=#R$4000(screen buffer).
  $84B0,$02 #REGb=#N$58 (i.e. finish once we reach the start of #R$5800(attribute buffer)).
  $84B2,$02 #REGc=#N$00 (value to write).

c $84B4 Reset Routine
E $84B4 View the equivalent code in;
. #LIST
. { #ATICATAC$80BB }
. { #COOKIE$74DB }
. { #JETPAC$71B8 }
. { #PSSST$7440 }
. { #TRANZAM$7218 }
. LIST#
R $84B4 HL Target address
R $84B4 B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $84B4 C Value to write
@ $84B4 label=ResetCopier
E $84B4 View the equivalent code in #ATICATAC$80BB.
  $84B4,$01 Write #REGc to the target address.
  $84B5,$01 Increment the target address by one.
  $84B6,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $84B8,$02 Keep looping back to #R$84B4 until the comparison is zero.
  $84BA,$01 Return.

c $84BB Reset Attribute Buffer
E $84BB View the equivalent code in;
. #LIST
. { #ATICATAC$80C2 }
. { #COOKIE$74E2 }
. { #JETPAC$71C6 }
. { #PSSST$7447 }
. { #TRANZAM$7200 }
. LIST#
@ $84BB label=ResetAttributes
  $84BB,$03 Set the border to black.
  $84BE,$03 #REGhl=#R$5800(attribute buffer).
  $84C1,$02 #REGb=#N$5B (i.e. finish once we reach the end of the #R$5800(attribute buffer)).
  $84C3,$02 #REGc=#N$43 (value to write).
  $84C5,$03 Call #R$84B4.

  $84D7,$01 Return.

c $84D8 Create Game Window
E $84D8 View the equivalent code in;
. #LIST
. { #COOKIE$5FB7 }
. { #PSSST$5F53 }
. LIST#
@ $84D8 label=CreateWindow
N $84D8 Blank the screen and write the banner.
  $84D8,$03 Call #R$84BB.
  $84DB,$03 Call #R$84AD.
  $84DE,$03 Call #R$8A37.
N $84E1 Set the attributes for the score line (the whole line is INK:#N$46).
  $84E1,$03 #REGhl=#N$5820.
  $84E4,$03 #REGbc=counter:#N$20, INK:#N$46.
@ $84E7 label=CreateWindow_Loop
  $84E7,$01 Write #N$46 to the attribute buffer.
  $84E8,$01 Move onto the next column.
  $84E9,$02 Decrease counter by one and loop back to #R$84E7 until counter is zero.
N $84EB Display the current 1UP and 2UP level.
  $84EB,$03 Call #R$F5EC.
N $84EE Write the 1UP, 2UP and HI scores.
  $84EE,$03 Call #R$89BF.
  $84F1,$03 Call #R$89C7.
  $84F4,$03 Jump to #R$89CF.

c $84F7 Reset Planet
@ $84F7 label=ResetPlanet
  $84F7,$03 #REGhl=#R$6000.
  $84FA,$03 #REGbc=#N$0480 (counter).
@ $84FD label=ResetPlanet_Loop
  $84FD,$02 Write #N$00 to #REGhl.
  $84FF,$01 Increment #REGhl by one.
  $8500,$05 Decrease counter by one and loop back to #R$84FD until counter is zero.
  $8505,$01 Return.

c $8506 Calculate Attribute Address
E $8506 View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #COOKIE$7534 }
. { #JETPAC$720E }
. { #PSSST$748F }
. { #TRANZAM$7097 }
. LIST#
N $8506 Converts a given pixel address to the associated attribute buffer address.
R $8506 HL Pixel address co-ordinates
R $8506 O:HL Attribute buffer address
@ $8506 label=AttributeAddress
  $8506,$01 Stash #REGbc on the stack.
  $8507,$01 Horizontal co-ordinate.
  $8508,$03 Divide by #N$08.
  $850B,$02,b$01 Keep only bits 0-4 (#N$00-#N$1F / minimum-maximum horizontal screen values).
  $850D,$01 Store this back in #REGl.
  $850E,$01 Vertical co-ordinate.
  $850F,$02 Multiply by #N$04.
  $8511,$01 Store this in #REGc temporarily.
  $8512,$02,b$01 Keep only bits 5-7.
  $8514,$01 Set the bits from #REGl.
  $8515,$01 #REGl=#REGa.
  $8516,$01 Fetch the stored value from #REGc.
  $8517,$02,b$01 Keep only bits 0-1.
  $8519,$02,b$01 Set MSB of the attribute buffer #N$58. This ensures our value is >= #R$5800.
  $851B,$01 Store this back in #REGh.
  $851C,$01 Restore #REGbc from the stack.
  $851D,$01 Return.

c $851E Calculate Screen Address
E $851E View the equivalent code in;
. #LIST
. { #ATICATAC$9BA2 }
. { #COOKIE$76E3 }
. { #JETPAC$7308 }
. { #PSSST$759A }
. { #TRANZAM$6F10 }
. LIST#
@ $851E label=ScreenAddress
  $851E,$01 #REGa=#REGl.
  $851F,$03 #REGa=#REGa / #N$08.
  $8522,$02,b$01 Keep only bits 0-4.
  $8524,$01 #REGl=#REGa.
  $8525,$01 #REGa=#REGh.
  $8526,$02 #REGa=#REGa * #N$04.
  $8528,$02,b$01 Keep only bits 5-7.
  $852A,$01
  $852B,$01 #REGl=#REGa.
  $852C,$01 #REGa=#REGh.
  $852D,$02,b$01 Keep only bits 0-2.
  $852F,$01 Switch to the shadow #REGaf register.
  $8530,$01 #REGa=#REGh.
  $8531,$03 #REGa=#REGa / #N$08.
  $8534,$02,b$01 Keep only bits 3-4.
  $8536,$02,b$01 Set bit 6.
  $8538,$01 #REGh=#REGa.
  $8539,$01 Switch to the shadow #REGaf register.
  $853A,$01
  $853B,$01 #REGh=#REGa.
  $853C,$01 Return.

c $853D

c $8568
  $8568,$03 #REGbc=#R$BAC0.
  $856B,$03 #REGa=#R$5EA2.
  $856F,$03 #REGa=#R$5E54.
  $857E,$01 Return.

c $857F
  $857F,$03 #REGbc=#R$BAC0.
  $8582,$03 #REGa=#R$5EA2.
  $858C,$02 Jump to #R$8575.

c $858E

b $85D9

c $85F6 Screen Address One Pixel Above
@ $85F6 label=ScreenPos1PixelAbove
R $85F6 HL Current position
R $85F6 O:HL Address for new position
N $85F6 Calculates the new address for writing a sprite pixel, in an upward direction, taking into consideration the screen memory layout.
  $85F6,$01 Decrement #REGh by one to move up one pixel on screen.
  $85F7,$02 Store the inverted result in #REGa.
  $85F9,$02,b$01 Keep only bits 0-2.
  $85FB,$01 If a screen bank boundary has not been crossed then return.
  $85FC,$04 Else subtract #N$20 from #REGl.
  $8600,$01 If there is any carry then return.
  $8601,$04 Else add #N$08 to #REGh and return.
  $8605,$01 Return.

c $8606
  $8606,$01 Exchange the #REGde and #REGhl registers.
  $8611,$03 Jump to #R$85F6.

c $8614
  $8614,$01 Exchange the #REGde and #REGhl registers.

c $864F
  $864F,$07 Write #N$00 to #LIST { #R$5E59 } { #R$5E58 } LIST#
  $8656,$01 #REGc=#N$00.
  $8657,$01
  $8658,$03 Call #R$88E8.
  $865B,$03 Jump to #R$87B9.

c $865E
  $865E,$03 #REGe=#REGix+#N$0C.
  $8661,$03 #REGd=#REGix+#N$0D.
  $8664,$03 #REGl=#REGix+#N$0E.
  $8667,$03 #REGh=#REGix+#N$0F.
  $866A,$03 #REGa=#REGix+#N$09.
  $866D,$03 Write #REGa to #R$85D7(#N$85D8).
  $8670,$03 #REGa=#REGix+#N$0A.
  $8673,$03 Write #REGa to #R$5E5A.
  $8676,$03 #REGa=#REGix+#N$0B.
  $8679,$03 Write #REGa to #R$5E56.
  $867C,$02 #REGc=#N$00.
  $867E,$01 Return.

c $867F
  $867F,$1F Write #N$00 to;
. #LIST
. { #REGix+#N$09 }
. { #REGix+#N$0A }
. { #REGix+#N$0B }
. { #REGix+#N$0C }
. { #REGix+#N$0D }
. { #REGix+#N$0E }
. { #REGix+#N$0F }
. { #R$5E59 }
. { #R$5E57 }
. { #R$5E58 }
. LIST#
  $869E,$02 #REGc=#N$00.
  $86A0,$01 Return.

c $86A1
  $86A1,$03 #REGl=#REGix+#N$02.
  $86A4,$03 #REGh=#REGix+#N$03.
  $86A7,$04 #REGhl=#REGhl+#N($0078,$04,$04).
  $86AB,$04 #REGbc=#R$607A.
  $86B3,$02,b$01 Keep only bits 0-4.
  $86BF,$03 Call #R$857F.
  $86C2,$03 #REGl=#REGix+#N$01.
  $86C5,$03 #REGh=#REGix+#N$04.

  $86CB,$02,b$01 Keep only bits 1-3.

  $86D1,$02 #REGa=#N$E8.

  $86E4,$03 Call #R$851E.

  $86FE,$02 #REGc=#N$00.
  $8700,$01 Return.

c $8701
  $8701,$03 Call #R$865E.
  $8704,$01 Switch to the shadow registers.
  $8705,$03 Call #R$86A1.
  $8708,$01 Switch back to the normal registers.
  $8709,$03 #REGa=#R$5E56.
  $8715,$01 #REGc=#REGa.
  $8716,$03 #REGa=#R$5E5A.
  $8721,$03 Jump to #R$858E.

  $8730,$03 Jump to #R$85BB.

c $8733
  $8733,$03 #REGl=#REGix+#N$01.
  $8736,$03 #REGh=#REGix+#N$04.
  $8739,$03 #REGd=#REGix+#N$07.
  $873C,$03 #REGa=#R$5E57.

  $8742,$03 Call #R$8506.
  $8745,$03 #REGa=#R$5E58.

  $8759,$03 #REGbc=#N$5AC0.

  $8771,$03 #REGbc=#N($0020,$04,$04).

  $874C,$02,b$01 Keep only bits 0-4.
  $874E,$01 Increment #REGa by one.
  $874F,$01 #REGc=#REGa.

  $877B,$01 Return.

c $877C
  $877C,$03 Call #R$88E8.
  $877F,$01 Switch to the shadow registers.
  $8780,$03 Call #R$88A3.
  $8783,$01 Switch back to the normal registers.
  $8784,$03 Jump to #R$878F.

c $8787
  $8787,$03 Call #R$88E8.
  $878A,$01 Switch to the shadow registers.
  $878B,$03 Call #R$8826.
  $878E,$01 Switch back to the normal registers.

c $87B9
  $87B9,$01 #REGa=#REGc.
  $87BA,$03 If #REGa is zero, jump to #R$8807.
  $87BD,$01 Decrease #REGc by one.
  $87BE,$02 Stash #REGbc and #REGhl on the stack.
  $87C0,$01 #REGa=#REGde.
  $87C1,$01 Increment #REGde by one.
  $87C2,$01
  $87C3,$01 Write #REGa to #REGhl.
  $87C4,$01 Increment #REGl by one.
  $87C5,$02
  $87C7,$02 Jump to #R$87C7.

c $8807

c $8826

c $8891
  $8891,$10 Write #N$00 to:
. #LIST
. { #R$5E59 }
. { #R$5E58 }
. { #REGix+#N$0A }
. { #R$5E57 }
. { #REGix+#N$0B }
. LIST#
  $88A1,$02 Jump to #R$8879.

c $88A3
  $88A3,$03 Call #R$857F.
  $88A6,$03 #REGl=#REGix+#N$01.
  $88A9,$03 #REGh=#REGix+#N$04.
  $88AC,$01 #REGa=#REGde.
  $88AD,$01 Increment #REGde by one.
  $88AE,$01 #REGb=#REGa.
  $88AF,$02 Jump to #R$88E2.

c $88B1
  $88B1

c $88E8

c $890A

c $8931

c $8947

c $894F Display Lives
E $894F View the equivalent code in;
. #LIST
. { #ATICATAC$0000 }
. { #COOKIE$7378 }
. { #JETPAC$70A4 }
. { #PSSST$7325 }
. { #SABREWULF$B7CD }
. { #TRANZAM$0000 }
. LIST#
@ $894F label=DisplayPlayerLives
N $894F Controller for 1UP lives.
  $894F,$06 Call #R$851E with #N($0040, $04, $04) (screen buffer address) for 1UP lives.
  $8955,$03 #REGa=1UP lives remaining (by calling #R$8986).
  $8958,$03 If 1UP lives are zero, jump to #R$8977.
  $895B,$03 Else, there are lives to display so call #R$896A.
N $895E Controller for 2UP lives.
@ $895E label=Controller2UPLives
  $895E,$06 Call #R$851E with #N($00B0, $04, $04) (screen buffer address) for 2UP lives.
  $8964,$03 #REGa=2UP lives remaining (by calling #R$8994).
  $8967,$03 If 2UP lives are zero, jump to #R$897C.
N $896A Handles displaying the lives count and UDG character.
@ $896A label=HandlerDisplayLives
  $896A,$02 Add #N$30 to convert to an ASCII character (starting at "0" character).
  $896C,$03 Call #R$89EF.
  $896F,$03 #REGde=#R$D151.
  $8972,$02 Stash #REGbc and #REGde on the stack.
  $8974,$03 Jump to #R$8A01.
N $8977 1UP has no lives.
@ $8977 label=Handler1UPNoLives
  $8977,$03 Call #R$897C.
  $897A,$02 Jump to #R$895E.
N $897C 2UP has no lives.
@ $897C label=Handler2UPNoLives
  $897C,$02 #REGa=ASCII " " (SPACE).
  $897E,$03 Call #R$89EF.
  $8981,$02 #REGa=ASCII " " (SPACE).
  $8983,$03 Jump to #R$89EF.
N $8986 Controller for the currently active player.
@ $8986 label=ControllerActiveLives
  $8986,$06 If #R$5E65 is not zero then jump to #R$8990.
N $898C Return currently active players lives left.
@ $898C label=ActivePlayerLives
  $898C,$03 #REGa=#R$5EA1.
  $898F,$01 Return.
N $8990 Return inactive players lives left.
@ $8990 label=InactivePlayerLives
  $8990,$03 #REGa=#R$5EA5.
  $8993,$01 Return.
N $8994 Controller for the inactive player.
@ $8994 label=ControllerInactiveLives
  $8994,$06 If #R$5E65 is zero then jump to #R$8990.
  $899A,$02 Jump to #R$898C.

c $899C Add Points To Score
E $899C View the equivalent code in;
. #LIST
. { #COOKIE$7415 }
. { #JETPAC$70F9 }
. { #PSSST$737A }
. { #SABREWULF$B5A9 }
. { #TRANZAM$6046 }
. LIST#
R $899C BC Points to add to score
@ $899C label=AddPointsToScore
N $899C Check the active player.
  $899C,$06 If #R$5E65 is not zero, jump to #R$89A7.
N $89A2 Set the score address for 1UP.
  $89A2,$03 #REGhl=#R$5E61.
  $89A5,$02 Jump to #R$89AA.
N $89A7 Set the score address for 2UP.
@ $89A7 label=AddPointsToScore_2UP
  $89A7,$03 #REGhl=#R$5E64.
N $89AA Process adding the points to the appropriate score.
@ $89AA label=AddPointsToScore_Start
  $89AA,$01 #REGa=score byte #3.
  $89AB,$02 Add #REGc to score byte #3 with BCD conversion.
  $89AD,$01 Update score byte #3.
  $89AE,$01 Move onto the next score byte.
  $89AF,$01 #REGa=score byte #2.
  $89B0,$02 Add (with carry) #REGb to score byte #2 with BCD conversion.
  $89B2,$01 Update score byte #2.
  $89B3,$01 Move onto the next score byte.
  $89B4,$01 #REGa=score byte #1.
  $89B5,$03 Add #N$00 (i.e. just the carry flag) to score byte #1 with BCD conversion.
  $89B8,$01 Update score byte #1.
N $89B9 Check the active player.
  $89B9,$06 If #R$5E65 is not zero, jump to #R$89C7.

c $89BF Print Scores
E $89BF View the equivalent code in;
. #LIST
. { #COOKIE$7438 }
. { #JETPAC$711C }
. { #PSSST$739D }
. { #SABREWULF$B5CC }
. { #TRANZAM$6CB6 }
. LIST#
@ $89BF label=Score_1UP
N $89BF Sets up the 1UP score.
  $89BF,$03 #REGhl=#N$4021 (screen buffer address).
  $89C2,$03 #REGde=#R$5E5F.
  $89C5,$02 Jump to #R$89D5.

N $89C7 Sets up the 2UP score.
@ $89C7 label=Score_2UP
  $89C7,$03 #REGhl=#N$4039 (screen buffer address).
  $89CA,$03 #REGde=#R$5E62.
  $89CD,$02 Jump to #R$89D5.

N $89CF Sets up the HI score.
@ $89CF label=Score_HI
  $89CF,$03 #REGhl=#N$402D (screen buffer address).
  $89D2,$03 #REGde=#R$5E06.

N $89D5 Prints the score.
@ $89D5 label=PrintScore
  $89D5,$02 #REGb=#N$03.
@ $89D7 label=PrintScore_Loop
  $89D7,$01 #REGa=#REGde.
  $89D8,$04 #REGa=#REGa / #N$10.
  $89DC,$02,b$01 Keep only bits 0-3.
  $89DE,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $89E0,$03 Call #R$89EF.
  $89E3,$01 #REGa=#REGde.
  $89E4,$02,b$01 Keep only bits 0-3.
  $89E6,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $89E8,$03 Call #R$89EF.
  $89EB,$01 Increment #REGde by one.
  $89EC,$02 Decrease counter by one and loop back to #R$89D7 until counter is zero.
  $89EE,$01 Return.

c $89EF Print Character
E $89EF View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #PSSST$73CD }
. { #TRANZAM$6C96 }
. LIST#
@ $89EF label=PrintScreen
R $89EF A ASCII value to print
R $89EF HL Screen address
  $89EF,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $89F2,$05 Create an offset in #REGhl.
  $89F7,$03 #REGhl=#REGhl * 8.
  $89FA,$04 #REGde=#R$5E04 (main font is #R$D347).
  $89FE,$02 #REGde=#REGhl + #REGde. For examples of usage;
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Letter | =h ASCII Value | =h - #N$20 * #N$08 (offset) | =h CHARS + offset }
. #FOREACH($55,$4C,$54,$49,$4D,$41,$54,$45)(value,
.   { #LET(result=$D347 + (value - $20) * $08) "#CHR(value)" | #N(value) | #N((value - $20) * $08) | #R({result}) }
. )
. TABLE#
N $8A00 Print the character to the screen.
  $8A00,$01 Restore #REGhl, containing the screen buffer location, from the stack.
  $8A01,$02 #REGb=#N$08 (#N$08 rows of pixels).
@ $8A03 label=PrintScreen_Loop
  $8A03,$02 Copy a byte from the font data to the screen buffer.
  $8A05,$01 Increment the font data by one.
  $8A06,$01 Move onto the next pixel line.
  $8A07,$02 Decrease counter by one and loop back to #R$8A03 until counter is zero.
  $8A09,$02 Restore #REGde and #REGbc from the stack.
N $8A0B Reset #REGhl and move to the next column, ready to print the next character.
  $8A0B,$04 #REGh=#REGh - #N$08 (reset the display line).
  $8A0F,$01 Increment screen column by one.
  $8A10,$01 Return.

c $8A11 Print Colour String
E $8A11 View the equivalent code in;
. #LIST
. { #ATICATAC$A1F3 }
. { #COOKIE$7488 }
. { #JETPAC$0000 }
. { #PSSST$73ED }
. { #TRANZAM$0000 }
. LIST#
@ $8A11 label=PrintStringColour
R $8A11 DE Pointer to string data
  $8A11,$01 Stash #REGhl on the stack.
  $8A12,$03 Call #R$851E.
  $8A15,$01 Fetch the attribute byte.
  $8A16,$01 Switch to the shadow #REGaf register.
  $8A17,$01 Increment #REGde by one to point to the text of the string.
  $8A18,$01 Switch to the shadow registers.
  $8A19,$01 Restore #REGhl from the stack.
  $8A1A,$03 Call #R$8506.

@ $8A1D label=PrintString_Loop
  $8A1D,$01 Switch back to the normal registers.
  $8A1E,$01 Fetch the character to print.
  $8A1F,$04 If bit 7 is set (which signifies the end of the string), jump to #R$8A2E.
  $8A23,$03 Call #R$89EF.
  $8A26,$01 Increment #REGde by one.
  $8A27,$01 Switch to the shadow registers.
  $8A28,$01 Switch to the shadow #REGaf register.
  $8A29,$01 Copy the attribute byte to the screen.
  $8A2A,$01 Increment #REGl by one.
  $8A2B,$01 Switch to the shadow #REGaf register.
  $8A2C,$02 Jump to #R$8A1D.
N $8A2E Because the last character contains the terminator, it needs to be handled separately.
@ $8A2E label=PrintString_LastCharacter
  $8A2E,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $8A30,$03 Call #R$89EF.
  $8A33,$01 Switch to the shadow registers.
  $8A34,$01 Switch to the shadow #REGaf register.
  $8A35,$01 Copy the attribute byte to the screen.
  $8A36,$01 Return.

c $8A37 Print Banner
E $8A37 View the equivalent code in;
. #LIST
. { #COOKIE$74AE }
. { #JETPAC$7192 }
. { #PSSST$7413 }
. LIST#
@ $8A37 label=PrintBanner
N $8A37 Handle printing "#FONT:(1UP)addr=$D347,attr=$47(1up)" messaging.
  $8A37,$03 #REGhl=#N($0018,$04,$04).
  $8A3A,$03 #REGde=#R$8A51.
  $8A3D,$03 Call #R$8A11.
N $8A40 Handle printing "#FONT:(HI)addr=$D347,attr=$45(hi)" messaging.
  $8A40,$03 #REGhl=#N($0078,$04,$04).
  $8A43,$03 #REGde=#R$8A59.
  $8A46,$03 Call #R$8A11.
N $8A49 Handle printing "#FONT:(2UP)addr=$D347,attr=$47(2up)" messaging.
  $8A49,$03 #REGhl=#N($00D8,$04,$04).
  $8A4C,$03 #REGde=#R$8A55.
  $8A4F,$02 Jump to #R$8A11.

t $8A51 Messaging: Banner Text
N $8A51 #FONT:(1UP)addr=$D347,attr=$47(1up)
@ $8A51 label=String_1UP
  $8A51,$04,h$01,$02:$01 "1UP" (#N(#PEEK(#PC)) is the attribute).
N $8A55 #FONT:(2UP)addr=$D347,attr=$47(2up)
@ $8A55 label=String_2UP
  $8A55,$04,h$01,$02:$01 "2UP" (#N(#PEEK(#PC)) is the attribute).
N $8A59 #FONT:(HI)addr=$D347,attr=$45(hi)
@ $8A59 label=String_HI
  $8A59,$03,h$01,$01:$01 "HI" (#N(#PEEK(#PC)) is the attribute).

c $8A5C

c $8B73

c $8BA5
  $8BA5,$03 #REGhl=#N$57BF.
  $8BA8,$03 #REGbc=#N$2088.
  $8BAB,$02 Stash #REGbc and #REGhl on the stack.
  $8BAD,$02 Write #N$00 to #REGhl.
  $8BAF,$01 Decrease #REGhl by one.
  $8BB0,$02 Decrease counter by one and loop back to #R$8BAD until counter is zero.
  $8BB2,$01 Restore #REGhl from the stack.
  $8BB3,$03 Call #R$85F6.
  $8BB6,$01 Restore #REGbc from the stack.
  $8BB7,$01 Decrease #REGc by one.
  $8BB8,$02 Jump back to #R$8BAB until #REGc is zero.
  $8BBA,$01 Return.

c $8BBB Draw HUD Panel
E $8BBB View the equivalent code in;
. #LIST
. { #COOKIE$5FE1 }
. { #TRANZAM$69BC }
. LIST#
@ $8BBB label=DrawHUDPanel
  $8BBB,$03 #REGhl=#R$5E04.
  $8BBE,$01 Stash #REGhl on the stack.
  $8BBF,$06 Write #R$DD97 to #R$5E04.
N $8BC5 The panel is printed like a font.
  $8BC5,$03 #REGbc=#N$1E03.
  $8BC8,$03 #REGde=#R$DE5F.
  $8BCB,$03 #REGhl=#N$4041 (screen buffer location).
@ $8BCE label=DrawHUDPanel_Pixel_Row

@ $8BD0 label=DrawHUDPanel_Pixel_Column

N $8BE2 Now write the attribute bytes.
  $8BE2,$03 #REGde=#R$DEB9.
  $8BE5,$03 #REGhl=#N$5841 (attribute buffer location).
  $8BE8,$03 #REGbc=#N$1E03.
@ $8BEB label=DrawHUDPanel_Attribute_Row

@ $8BED label=DrawHUDPanel_Attribute_Column

N $8BFC Restore the old font pointer.
  $8BFC,$01 Restore #REGhl from the stack.
  $8BFD,$03 Write #REGhl back to #R$5E04.
  $8C00,$01 Return.

c $8C01 Draw Gauge
R $8C01 A Lower byte of gauge
R $8C01 HL Screen location
@ $8C01 label=DrawGauge
N $8C01 Stash the lower gauge byte for later.
  $8C01,$01 #REGc=#REGa.
N $8C02 Stash the screen location for later, as we'll need it to gain the screen buffer address.
  $8C02,$01 Stash #REGhl on the stack.
  $8C03,$03 Call #R$8506.
N $8C06 Restore the lower gauge byte.
  $8C06,$01 #REGa=#REGc.
N $8C07 Rotate off the INK bits.
  $8C07,$03 Rotate the bits right three times (including the carry).
  $8C0A,$02,b$01 Keep only bits 0-4 (PAPER, BRIGHT and FLASH).
  $8C0C,$02 Jump to #R$8C1A if the result is zero (i.e. empty/ blank).
  $8C0E,$01 #REGb=#REGa.
N $8C0F This moves along 
@ $8C0F label=DrawGauge_Find
  $8C0F,$01 #REGa=attribute byte.
  $8C10,$03 Rotate the bits left three times (including the carry).
  $8C13,$02,b$01 Keep only bits 3-5 (INK).
  $8C15,$01
  $8C16,$01 Write #REGa back to #REGhl.
  $8C17,$01 Increment #REGhl by one.
  $8C18,$02 Decrease counter by one and loop back to #R$8C0F until counter is zero.
N $8C1A Fetch the attribute byte for where the gauge ends.
@ $8C1A label=DrawGauge_Draw
  $8C1A,$01 #REGa=#REGhl.
N $8C1B Remove the PAPER bits.
  $8C1B,$02,b$01 Keep only bits 0-2, 6-7.
  $8C1D,$01 Write #REGa back to #REGhl.
N $8C1E Store the attribute buffer address in #REGde.
  $8C1E,$01 Switch the #REGde and #REGhl registers.
N $8C1F Restore the screen location for the screen buffer address call.
  $8C1F,$01 Restore #REGhl from the stack.
  $8C20,$03 Call #R$851E.
  $8C23,$01 #REGa=#REGe.
  $8C24,$02,b$01 Keep only bits 0-4.
  $8C26,$01 #REGe=#REGa.
  $8C27,$01 #REGa=#REGl.
  $8C28,$02,b$01 Keep only bits 5-7.
  $8C2A,$01
  $8C2B,$01 #REGl=#REGa.
N $8C2C Restore the lower gauge byte.
  $8C2C,$01 #REGa=#REGc.
N $8C2D The gradient lines are stored in the font at: #R$D51F.
. #UDGTABLE(default,centre,centre)
. { #N$00 | #FONT:([)addr=$D347,attr=$47(gradient-0) }
. { #N$01 | #FONT:(\)addr=$D347,attr=$47(gradient-1) }
. { #N$02 | #FONT:(])addr=$D347,attr=$47(gradient-2) }
. { #N$03 | #FONT:(^)addr=$D347,attr=$47(gradient-3) }
. { #N$04 | #FONT:(_)addr=$D347,attr=$47(gradient-4) }
. { #N$05 | #FONT:(`)addr=$D347,attr=$47(gradient-5) }
. { #N$06 | #FONT:(a)addr=$D347,attr=$47(gradient-6) }
. { #N$07 | #FONT:(b)addr=$D347,attr=$47(gradient-7) }
. UDGTABLE#
N $8C2D There are 8 gradient line images, so ensure the number reference is between #N$00-#N$07.
  $8C2D,$02,b$01 Keep only bits 0-2.
N $8C2F The first value is #N$5B which corresponds to "#FONT:([)addr=$D347,attr=$47(gradient-0)" (the smallest gradient).
  $8C2F,$02 #REGa=#REGa+#N$5B.
  $8C31,$03 Call #R$89EF.
N $8C34 Restore the lower gauge byte.
  $8C34,$01 #REGa=#REGc.
  $8C35,$01 Flip the bits.
  $8C36,$02,b$01 Keep only bits 0-2.
  $8C38,$01 Return if the result is not zero.
  $8C39,$02 #REGa=#N$20.
  $8C3B,$03 Jump to #R$89EF.

c $8C3E Flash Score Label
@ $8C3E label=HandlerScoreLabel
E $8C3E View the equivalent code in;
. #LIST
. { #COOKIE$7020 }
. { #SABREWULF$AEA1 }
. LIST#
  $8C3E,$06 If #R$5E6C is zero, jump to #R$8C49.
  $8C44,$04 Write #N$00 to #REGix+#N$00.
  $8C48,$01 Return.
N $8C49 Controller for handling whether to action 1UP or 2UP score label.
@ $8C49 label=ScoreLabelFlash
  $8C49,$06 If #R$5E65 is not zero, jump to #R$8C6C.
N $8C4F Flash 1UP score label.
  $8C4F,$03 #REGhl=#N($0018,$04,$04) (position of the 1UP score label).
N $8C52 Set flash state for the 3-attributes of the score label.
@ $8C52 label=FlashText
  $8C52,$03 Call #R$8506.
  $8C55,$02 #REGb=#N$03 (counter for the three letters in a score label).
@ $8C57 label=FlashText_Loop
  $8C57,$01 Fetch the attribute byte.
  $8C58,$02,b$01 Ensure bit 7 is set (the flash bit).
  $8C5A,$01 Write the attribute byte back to #REGhl.
  $8C5B,$01 Increment the attribute address pointer by one.
  $8C5C,$02 Decrease counter by one and loop back to #R$8C57 until counter is zero.
  $8C5E,$01 Return.
N $8C5F Unset flash state for the 3-attributes of the score label.
@ $8C5F label=UnsetFlashText
  $8C5F,$03 Call #R$8506.
  $8C62,$02 #REGb=#N$03 (counter for the three letters in a score label).
@ $8C64 label=UnsetFlashText_Loop
  $8C64,$01 Fetch the attribute byte.
  $8C65,$02,b$01 Keep only bits 0-6 (i.e. everything except the flash bit).
  $8C67,$01 Write the attribute byte back to #REGhl.
  $8C68,$01 Increment the attribute address pointer by one.
  $8C69,$02 Decrease counter by one and loop back to #R$8C64 until counter is zero.
  $8C6B,$01 Return.
N $8C6C Flash 2UP score label.
@ $8C6C label=FlashScoreLabel2UP
  $8C6C,$03 #REGhl=#N($00D8,$04,$04) (position of the 2UP score label).
  $8C6F,$02 Jump to #R$8C52.

c $8C71
  $8C71,$07 If #R$5E67 is zero, jump to #R$8C99.
  $8C78,$01 Decrement #R$5E67 by one.
  $8C79,$02 Jump to #R$8C3E if the delay timer is still active.
  $8C7B,$03 Call #R$B8C9.
  $8C7E,$03 #REGa=#R$5EA0.
  $8C81,$02,b$01 Keep only bit 0.
  $8C83,$03 Write the result to #R$5EA2.
  $8C86,$06 Jump to #R$8C94 if #R$5E65 is not zero.
  $8C8C,$03 #REGhl=#N($0018,$04,$04).
  $8C8F,$03 Call #R$8C5F.
  $8C92,$02 Jump to #R$8C99.
  $8C94,$03 #REGhl=#N($00D8,$04,$04).
  $8C97,$02 Jump to #R$8C8F.
  $8C99,$03 #REGhl=#N($1040,$04,$04).
  $8C9C,$03 #REGa=#R$608F.
  $8C9F,$03 Call #R$8C01.
  $8CA2,$03 Call #R$8F90.

  $8CB1,$05 Write #N$00 to #REGix+#N$05.

  $8CB9,$03 Jump to #R$8CDF.

c $8CBC

c $8D06
  $8DA4,$03 #REGhl=#R$608E.
  $8DA7,$04 If jetmans fuel has run out, jump to #R$8DBB.
  $8DAB,$01 Reset flags.
N $8DAC Subtract the fuel expenditure from the current fuel level.
  $8DAC,$02 #REGhl=#REGhl-#REGbc.
  $8DAE,$04 If there's any fuel remaining, jump to #R$8DBB.
  $8DB2,$03 #REGde=#R$BA2D.
  $8DB5,$03 Call #R$B9BC.
  $8DB8,$06 Write #N($0000,$04,$04) to #R$608E.
  $8DBE,$01 #REGa=#REGh.
  $8DBF,$03 #REGhl=#N$1040.
  $8DC2,$03 Call #R$8C01.
  $8DC5,$03 Call #R$907B.

  $8D06,$03 Call #R$8F90.

c $8E5A

c $8EC5

c $8F34
  $8F34,$04 #REGa=#REGix+#N$06.
  $8F4C,$02 #REGc=#N$F8.
  $8F53,$02 #REGc=#N$FC.
  $8F58,$04 #REGix+#N$06=#N$E0.
  $8F5C,$02 #REGb=#N$40.
  $8F5E,$03 Jump to #R$8D61.

c $8F61
  $8F61,$04 Write #N$00 to #REGix+#N$06.
  $8F65,$02 #REGb=#N$10.
  $8F67,$03 Jump to #R$8D93.

c $8F6A Controls: Cursor Joystick
@ $8F6A label=ReadCursorJoystick
R $8F6A O:A Controls
E $8F6A View the equivalent code in;
. #LIST
. { #SABREWULF$B103 }
. LIST#
  $8F6A,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $8F70,$01 Store this value in #REGc temporarily.
N $8F71 Handle "up".
  $8F71,$02,b$01 Keep only bit 3 ("7").
  $8F73,$01 Store this value in #REGe.
  $8F74,$03 Retrieve #REGc and rotate the bits right twice.
N $8F77 Handle "down", "right" and "fire".
  $8F77,$02,b$01 Keep only bits 0 ("8"), 2 ("6") and 6 ("0").
  $8F79,$01 Set the bits from #REGe.
  $8F7A,$01 Store this value back in #REGe.
N $8F7B Handle relocating the "fire" bit.
  $8F7B,$02 Rotate the bits right twice.
  $8F7D,$02,b$01 Keep only bit 4 ("0").
  $8F7F,$01 Set the bits from #REGe.
N $8F80 Filter out the unused bits.
  $8F80,$02,b$01 Keep only bits 0-4.
  $8F82,$01 Store this value back in #REGe.
N $8F83 Handle reading "left" from a different port.
  $8F83,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
N $8F89 Handle relocating the "left" bit.
  $8F89,$03 Rotate the bits right three times.
  $8F8C,$02,b$01 Keep only bit 1 ("5").
  $8F8E,$01 Set the bits from #REGe resulting in;
. #TABLE(default,centre,centre,centre)
. { =h Key | =h Direction | =h Bit }
. { "8" | Right | 0 }
. { "5" | Left | 1 }
. { "6" | Down | 2 }
. { "7" | Up | 3 }
. { "0" | Fire | 4 }
. TABLE#
. This matches the Kempston Joystick inputs.
  $8F8F,$01 Return.

c $8F90 Handler: Controls
E $8F90 Continue on to #R$8F9B.
E $8F90 View the equivalent code in;
. #LIST
. { #SABREWULF$B0A3 }
. LIST#
@ $8F90 label=HandlerControls
M $8F90,$06 Jump to #R$8F9F if #R$5E00 is set for keyboard controls.
  $8F93,$02,b$01
  $8F97,$04 Jump to #R$8F6A if #R$5E00 is set for cursor joystick controls.

c $8F9B Controls: Kempston Joystick
R $8F9B O:A Controls
E $8F9B View the equivalent code in;
. #LIST
. { #SABREWULF$B0D9 }
. LIST#
N $8F9B Read from the Kempston Joystick.
@ $8F9B label=ReadKempstonJoystick
  $8F9B,$02 #REGa=controls.
  $8F9D,$01 Flip the bits.
  $8F9E,$01 Return.

c $8F9F Controls: Keyboard
E $8F9F View the equivalent code in;
. #LIST
. { #SABREWULF$B0FA }
. LIST#
@ $8F9F label=ReadKeyboard
R $8F9F O:A Controls
  $8F9F,$02 #REGc=#N$FF.
  $8FA1,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$E7 | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 }
. TABLE#
  $8FA7,$01 Flip the bits.
  $8FA8,$02,b$01 Keep only bits 0-4.
  $8FAE,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DB | Q | W | E | R | T | Y | U | I | O | P }
. TABLE#
  $8FB4,$01 Flip the bits.
  $8FB5,$02,b$01 Keep only bits 0-4.
  $8FBB,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$BD | A | S | D | F | G | H | J | K | L | ENTER }
. TABLE#
  $8FC1,$01 Flip the bits.
  $8FC2,$02,b$01 Keep only bits 0-4.
  $8FC8,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $8FCE,$01 Flip the bits.
  $8FD0,$02,b$01 Keep only bits 2 and 4.
  $8FD7,$02,b$01 Keep only bit 3.
  $8FDD,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | FULL-STOP | M | N | B }
. TABLE#
  $8FE3,$01 Flip the bits.
  $8FE5,$02,b$01 Keep only bit 3.
  $8FEC,$02,b$01 Keep only bits 2 and 4.
  $8FF3,$01 Return.

c $8FF4
  $8FF4,$03 #REGa=#REGix+#N$00.
  $9002,$03 Jump to #R$8DD9.

c $9005
  $9005,$03 #REGa=#REGix+#N$00.
  $900F,$05 Write #N$F0 to #REGix+#N$06.
  $901D,$03 Jump to #R$8DD9.

c $9020
  $9020,$03 #REGa=#R$5E6C.

  $902D,$03 #REGhl=#R$9D5A.
  $9030,$03 #REGde=#N$6078.
  $9033,$03 #REGbc=#N($0018,$04,$04).

  $903F,$03 Call #R$AD3F.

  $9047,$03 #REGbc=#N($0040,$04,$04).
  $904A,$03 Call #R$A002.

  $9073,$03 Jump to #R$894F.
  $9076,$03 #REGbc=#N$FFC0.
  $9079,$02 Jump to #R$904A.

c $907B
  $907B,$03 #REGa=#REGix+#N$05.

c $917C
R $917C HL Terrain Buffer?
  $917C,$02 Stash #REGhl and #REGde on the stack.
  $917E,$01
  $917F,$02 #REGh=#N$00.
  $9181,$03 #REGhl=#REGhl^#N$03.
  $9184,$03 #REGde=#R$F66E.
  $9187,$01 #REGhl=#REGhl+#REGde.
  $9188,$02 #REGb=#N$08.
  $918A,$02 Restore #REGde from the stack, but stash a copy of it again.
  $918C,$02
  $918E,$01 Increment #REGhl by one.
  $918F,$01 Increment #REGd by one.
  $9190,$02
  $919D,$01 Return.

c $919E
  $919E,$03 #REGde=#N$FF88.
  $91A3,$02,b$01 Keep only bits 0-5.
  $91B6,$03 #REGde=#N$50C0.
  $91B9,$02 Jump to #R$917C.

c $91BB
  $91BB,$03 #REGh=#REGix+#N$03.
  $91BE,$03 #REGl=#REGix+#N$02.
  $91C1,$01 #REGa=#REGh.
  $91C2,$02,b$01 Keep only bits 0-4.
  $91C4,$01 #REGh=#REGa.

  $91D1,$01 Stash #REGhl on the stack.
  $91D2,$03 #REGbc=#R$7000.

  $91DA,$01 #REGa=#REGh.
  $91DB,$02,b$01 Keep only bits 0-1.
  $91DD,$01 #REGh=#REGa.

  $91E0,$01 Restore #REGhl from the stack.
  $91E1,$01 Return.

c $91E2
  $91E2,$06 If #R$5E6C is not zero, jump to #R$9267.
  $91E8,$06 Write #N$9000 to #N$608E.
  $91EE,$01 #REGa=#REGh.
  $91EF,$03 #REGhl=#N$1040.
  $91F2,$03 Call #R$8C01.
  $91F5,$03 Call #R$8F90.

  $920D,$02 Jump to #R$9211.

  $921E,$03 #REGde=#N$FFF8.

  $922F,$02,b$01 Keep only bits 0-1.

  $9235,$03 #REGhl=#R$7000.

  $923D,$02,b$01 Keep only bit 3.

  $9248,$02 Jump to #R$9250.

c $930C
  $930C,$03 #REGhl=#N$6097.
  $930F,$03 #REGde=#N$607F.
  $9312,$03 #REGbc=#N($0009,$04,$04).
  $9323,$02,b$01 Keep only bit 3.
  $932B,$04 Write #N$00 to #N$6090.
  $9335,$03 Jump to #R$B8BD.
  $933C,$02 Jump to #R$932B.

c $933E
  $933E,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SPACE | FULL-STOP | M | N | B | Shift | Z | X | C | V }
. TABLE#
  $9344,$01 Flip the bits.
  $9345,$02,b$01 Keep only bit 0.
  $9347,$02 If the result is zero jump to #R$9350.
  $9349,$03 #REGa=#R$5E5D.
  $934C,$03 If #REGa is not zero then jump to #R$9354.
  $934F,$01 Increment #REGa by one.
  $9350,$03 Write #REGa to #R$5E5D.
  $9353,$01 Return.
  $9354,$01 #REGa=#N$00.
  $9355,$01 Return.

c $9356 Draw Terrain?
  $9356,$03 #REGhl=#R$607A.
  $9359,$03 #REGde=#N$FF88.
  $935E,$02,b$01 Keep only bits 0-4.
  $936D,$03 #REGde=#N$50C0.
  $9370,$03 #REGbc=#R$7000.
  $9373,$02 #REGa=#N$20.
  $937A,$03 Call #R$917C.
  $9383,$02,b$01 Keep only bits 0-1.
  $938A,$03 #REGhl=#N$5AE1.
  $938D,$03 #REGbc=#N$1E5B.
  $9390,$01 Write #REGc to #REGhl.
  $9391,$01 Increment #REGhl by one.
  $9392,$02 Decrease counter by one and loop back to #R$9390 until counter is zero.
  $9394,$01 Return.

c $9395 Find Unused Alien Slot
@ $9395 label=FindSlotAlien
R $9395 O:F Z: slot available
R $9395 O:F NZ: no available slots
R $9395 O:HL The alien slot address
  $9395,$03 #REGhl=#R$61B0.
N $9398 There are a maximum of 6 aliens on screen at a time.
  $9398,$02 #REGb=#N$06 (alien counter).
  $939A,$03 #REGde=#N($0018,$04,$04) (the length of each slot).
@ $939D label=FindSlotAlien_Loop
  $939D,$01 #REGa=#REGhl.
  $939E,$03 Jump to #R$93A5 if #REGa is zero.
  $93A1,$01 #REGhl=#REGhl+#REGde.
  $93A2,$02 Decrease alien slot counter by one and loop back to #R$939D until counter is zero.
  $93A4,$01 If no available slot was found, ensure the Z flag is unset (so NZ is true).
@ $93A5 label=FindSlotAlien_Return
  $93A5,$01 Return.

c $93A6
  $93A6,$03 #REGhl=#R$607A.
  $93A9,$03
  $93AC,$03
  $93AF,$05 #REGa=#R$607C+#N$08.
  $93B4,$04
  $93B8,$05 Write #N$AF to #REGix+#N$04.
  $93BD,$03 Call #R$8701.
  $93C0,$03 Call #R$8733.
  $93C3,$03 Call #R$945C.
  $93C6,$02
  $93C8,$04
  $93CD,$04 Write #N$2F to #REGix+#N$00.
  $93D1,$03 #REGhl=#R$6080.
  $93E0,$03 Jump to #R$B8C3.

  $93E3,$04 Reset bit 0 of #REGix+#N$08.
  $93E7,$01 Return.

c $945C
  $945C,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { =r2 #N$7E | SPACE | FULL-STOP | M | N | B }
. { Shift | Z | X | C | V }
. TABLE#
  $9462,$01 Flip the bits.
  $9463,$02,b$01 Keep only bit 1.
  $9465,$01 Return.

c $9466
  $9466,$02 #REGa=random number.
  $9468,$02,b$01 Keep only bits 0-1.
  $946A,$01 Return if the value is not zero.
  $946B,$03 #REGa=#R$5E67.
  $946E,$02 Return if the value is not zero.
  $9470,$03 Call #R$9395.
  $9473,$01 Return if there were no available alien slots.
  $9474,$01 Stash #REGhl (the free alien slot) on the stack.
  $9475,$01 Switch the #REGde and #REGhl registers.
  $9476,$03 #REGa=#R$5E40.
  $9479,$01 Rotate #REGa left once.
  $947A,$02,b$01 Keep only bits 1-3.
  $947C,$03 Create an offset in #REGbc - max #N$0E (only even numbers).
N $947F 
  $947F,$03 #REGa=#R$5EA0.
  $9482,$04 Compare the current level against #N$0C, if there's any carry over then jump to #R$9488.
  $9486,$02 #REGa=#N$0C.
  $9488,$02,b$01 Keep only bits 1-3.
  $948A,$03 Create an offset in #REGhl - number can be:
. #LIST
. { #N($0002,$04,$04) }
. { #N($0004,$04,$04) }
. { #N($0006,$04,$04) }
. { #N($0008,$04,$04) }
. { #N($000A,$04,$04) }
. { #N($000C,$04,$04) }
. LIST#
  $948D,$04 #REGhl+=#R$9D72.
  $9491,$04 #REGhl=alien lookup table appropriate for the current level.
  $9495,$01 #REGhl+=.
  $949A,$03 #REGbc=#N($0018,$04,$04).
  $949D,$01 #REGde=the free alien slot (from earlier).
  $949E,$01 Stash #REGde (the free alien slot) on the stack again.

  $94A1,$01 #REGhl=the free alien slot.

  $94C8,$02,b$01 Keep only bits 0-4.

  $94D3,$02,b$01 Keep only bit 7.

  $94DF,$02,b$01 Keep only bit 7.

  $94E7,$03 #REGde=#N($0090,$04,$04).
  $94EA,$02 Jump to #R$94EF.

  $94F1,$02,b$01 Keep only bits 0-4.

  $94FB,$02,b$01 Keep only bits 3-6.

  $950A,$02,b$01 Keep only bit 7.

  $9512,$03 #REGde=#N($0090,$04,$04).
  $9515,$02 Jump to #R$951A.
  $9517,$03 #REGde=#N$FF70.

  $9526,$02,b$01 Keep only bits 3-6.

  $9530,$01 Return.

c $9531
  $9531,$03 #REGhl=#R$5E5E.

  $955C,$03 Jump to #R$9937.

c $95B6
  $95B6,$03 Call #R$91BB.
  $95B9,$01 Stash #REGhl on the stack.
  $95BA,$03 #REGde=#R$7000.
  $95BD,$01 Switch the #REGde and #REGhl registers.
  $95BE,$01 #REGhl=#REGhl+#REGde.

  $95C3,$02 Write #N$0A to #REGhl. #UDG($F66E+$0A*$08,attr=$43)
  $95C5,$02 Jump to #R$95C9.
  $95C7,$02 Write #N$08 to #REGhl. #UDG($F66E+$08*$08,attr=$43)

  $95CB,$02,b$01 Keep only bits 0-1.

  $95CE,$03 #REGhl=#R$7000.
  $95D1,$01 #REGhl=#REGhl+#REGde.

  $95D6,$02 Write #N$0A to #REGhl. #UDG($F66E+$0A*$08,attr=$43)
  $95D8,$02 Jump to #R$95DC.
  $95DA,$02 Write #N$09 to #REGhl. #UDG($F66E+$09*$08,attr=$43)

  $95E8,$02,b$01 Keep only bits 0-4.

  $95EB,$03 #REGde=#R$7000.

  $9630,$02 #REGb=#N$08 (counter).
  $9632,$01 #REGa=#REGde.

  $9651,$01 Return.
  $9652,$01 Restore #REGhl from the stack.
  $9653,$01 Return.

c $9654

c $970E

c $9C23
  $9C23,$0B Copy #N$0018 bytes from #R$9D80 to #N$5E20.
  $9C2E,$0B Copy #N$0018 bytes from #R$9D98 to #N$5E06.
  $9C39,$01 Return.

b $9C3A Alien States
@ $9C3A label=Alien_Meteor
  $9C3A,$18 #SPRITENAME(#PEEK(#PC)).
L $9C3A,$18,$08
@ $9C52 label=Alien_MrMagneticBrella
@ $9C6A label=Alien_TheBlob
@ $9C82 label=Alien_TheBlock
@ $9C9A label=Alien_BouncingWheel
@ $9CB2 label=Alien_Spinner
@ $9CCA label=Alien_Saturn
@ $9CE2 label=Alien_Shooter

w $9CFA Alien Lookup Table
D $9CFA All levels beyond level 6, repeat the level 6 lookups.
N $9CFA Level 1 aliens.
@ $9CFA label=Level1Aliens
N $9D0A Level 2 aliens.
@ $9D0A label=Level2Aliens
N $9D1A Level 3 aliens.
@ $9D1A label=Level3Aliens
N $9D2A Level 4 aliens.
@ $9D2A label=Level4Aliens
N $9D3A Level 5 aliens.
@ $9D3A label=Level5Aliens
N $9D4A Level 6 aliens.
@ $9D4A label=Level6Aliens

b $9D5A

w $9D72 Levels Alien Lookup Table
@ $9D72 label=LevelsAlienLookupTable

b $9D80
  $9D80,$18
b $9D98
  $9D98,$18
b $9DB0

c $9DC0 Handler: Laser Beam
E $9DC0 View the equivalent code in;
. #LIST
. { #JETPAC$6F91 }
. LIST#
@ $9DC0 label=Handler_LaserBeam
N $9DC0 Only handle the laser beam on every 4th frame.
  $9DC0
  $9DC3,$02,b$01 Keep only bit 0.
N $9DC6 Search for a "free" laser beam slot.
  $9DC6,$03 #REGhl=#R$6000.
  $9DC9,$03 #REGde=#N($0018, $04, $04) (each slot is #N$18 bytes).
  $9DCC,$02 #REGb=#N$04 (counter; there are 4 "slots").
@ $9DCE label=LaserBeam_Slot
  $9DCE,$04 If the slot is not in use, jump to #R$9DDE.
  $9DD2,$01 #REGhl=#REGhl+#REGde (move onto the next slot).
  $9DD3,$02 Decrease counter by one and loop back to #R$9DCE until counter is zero.
N $9DD5 All laser beam slots are in use so just return...
  $9DD5,$01 Return.
N $9DD6 Possibly the "shoot right" code?
  $9DD6,$02 #REGa=#REGa+#N$10.
  $9DD8,$02,b$01 Set bit 2.
  $9DDA,$02,b$01 Keep only bits 1-7.
  $9DDC,$02 Jump to #R$9DFA.
N $9DDE Initialise a new laser beam.
@ $9DDE label=Init_LaserBeam
  $9DDE,$02 Mark the laser beam slot as "in-use".
  $9DE0,$01 #REGhl=Laser beam Y position.
  $9DE1,$03 #REGde=#R$6078.
  $9E17,$03 #REGhl=#R$9E28.
  $9E25,$03 Jump to #R$B8A8.
N $9E28 All the attributes a laser beam can be.
@ $9E28 label=Attributes_LaserBeam
B $9E28,$04

c $9E2C Animate: Laser Beam
@ $9E2C label=LaserBeam_Animate
  $9E2C,$03 Call #R$A796.
  $9E2F,$03 Laser Y position.
  $9E32,$03 Laser X position: pulse #1.
  $9E35,$04 Jump to #R$9E68 if bit 2 is reset.
  $9E39,$01 #REGl=X position: pulse #1.
  $9E46,$03 Call #R$851E.
  $9E51,$03 Call #R$8506.
  $9E60,$02,b$01 Keep only bits 3-7.
  $9E69,$03 #REGbc=#N$031C.
  $9E6C,$02 #REGe=#N$E0.
N $9E6F Loop counter (to process pulses #2, #3, #4).
  $9E6F,$02 #REGe=#N$03.
  $9E7B,$02,b$01 Keep only bits 3-7.
  $9E8C,$01 Return.
  $9E98,$02,b$01 Keep only bits 0-2.
  $9E9B,$03 #REGa=#R$5E40.
  $9E9E,$02,b$01 Keep only bits 0-1.
  $9EA0,$02,b$01 Set bit 2.
  $9EA9,$02,b$01 Set bit 2.
  $9EAC,$01 Return.

  $9EC9,$01 Return.

c $9ECA
  $9ECA,$03 #REGa=#R$607A.
  $9ED0,$02,b$01 Keep only bits 0-2.
  $9ED7,$03 Call #R$8787.
  $9EDA,$02 Jump to #R$9EEE.

c $9EDC
  $9EDC,$03 #REGa=#R$607A.
N $9EE4 The Lunar Rover has seven (eleven?) frames of animation.
  $9EE4,$02,b$01 Keep only bits 0-2.
N $9EE6 With sprite IDs beginning from #R$BE90(#N$22) (#SPRITENAME$22).
  $9EE6,$02
  $9EE8,$03 Write #REGa to #REGix+#N$00.
  $9EEB,$03 Call #R$8787.

c $9F5E
  $9F5E,$03 #REGhl=#R$A008.
  $9F61,$03 #REGde=#R$6090.
  $9F64,$03 #REGbc=#N($0060,$04,$04).
  $9F67,$02
  $9F69,$01 Return.

c $9F6A

b $A008
  $A008,$60,$10

b $A068
  $A068,$90,$10

c $A0F8

c $A1AA

B $A313,$04

c $A317 Handler: Reset Laser Beam Slots
N $A317 See #R$9DC6 for the handler which actions "searching" for a free slot.
@ $A317 label=Handler_ResetLaserBeamSlots
  $A317,$03 #REGhl=#R$6000.
  $A31A,$03 #REGde=#N($0018,$04,$04).
  $A31D,$02 #REGb=#N$04 (counter).
@ $A31F label=ResetLaserBeamSlots_Loop
  $A31F,$02 Write #N$00 to #REGhl.
  $A321,$01 #REGhl=#REGhl+#REGde.
  $A322,$02 Decrease counter by one and loop back to #R$A31F until counter is zero.
  $A324,$01 Return.

c $A325
c $A378
c $A39C

c $A3C1
  $A3C1,$03 Call #R$945C.

  $A3CC,$03 Call #R$91BB.

  $A3F1,$05 Write #N$AF to #REGix+#N$04.
  $A3F6,$03 Jump to #R$A375.
  $A3F9,$04 Set bit 3 of #REGix+#N$00.
  $A3FD,$02 Jump to #R$A3DF.

c $A3FF
  $A3FF,$03 #REGa=#R$6090.

  $A40E,$03 Call #R$945C.

  $A413,$03 Call #R$A4FC.

  $A418,$04 Write #N$00 to #R$5EA3.

  $A427,$02,b$01 Keep only bits 4-7.
  $A429,$02,b$01 Set bits 0-1.

  $A42E,$03 Call #R$B8BD.

  $A4B9,$01 Return.

c $A4BA
  $A4BA,$03 #REGl=#REGix+#N$02.
  $A4BD,$03 #REGh=#REGix+#N$03.

  $A4D3,$03 Call #R$8947.
  $A4D6,$03 #REGbc=#N($00C0,$04,$04).

  $A4DD,$03 #REGa=#R$6074.

  $A4E6,$01 Retun.

c $A4E7
  $A4E7,$03 #REGa=#R$6078.
  $A4ED,$03 Call #R$945C.

  $A4F1,$03 #REGa=#R$6080.
  $A4F4,$02,b$01 Keep only bit 0.
  $A4F6,$01 Return the result is #N$01.

  $A50E,$02,b$01 Keep only bits 0-4.

  $A521,$01 Return.

c $A522
  $A522,$03 Call #R$B89A.
  $A525,$03 Call #R$B6AE.

  $A52C,$08 Write #N$00 to #REGix+#N$06 and #REGix+#N$05.
  $A534,$05 Write #N$AF to #REGix+#N$04.
  $A539,$01 Return.

c $A53A
  $A53A,$07 #REGhl=#REGix+#N($0018,$04,$04).
  $A541,$03 Return if the byte at this address is non-zero.
  $A544,$02 Write #N$C8 to #REGhl.

  $A557,$02,b$01 Keep only bits 2-5.

  $A55C,$03 #REGhl=#R$A68B.

  $A56E,$02,b$01 Keep only bits 0-4.

  $A577,$02 Jump to #R$A5C8.

c $A579
  $A579,$03 #REGa=#R$5E42.
  $A57C,$02,b$01 Keep only bits 0-1.
  $A57E,$01 Return if the result is non-zero.
  $A57F,$03 Call #R$8F90.
  $A585,$03 #REGhl=#R$6000.
  $A588,$03 #REGde=#N($0018,$04,$04).
  $A58B,$02 #REGb=#N$02 (counter).

  $A592,$02 Decrease counter by one and loop back to #R$A58D until counter is zero.
  $A594,$01 Return.

c $A73C

c $A826 Initialise New Level
@ $A826 label=LevelNew
  $A826,$04 Increase the lives counter #R$5EA1 by one.
@ $A82A label=LevelInitialisation
  $A82A,$03 Call #R$B385.
  $A82D,$03 Call #R$9020.
  $A830,$03 Call #R$84D8.
  $A833,$03 Call #R$A2F5.
  $A836,$03 Call #R$A317.
  $A839,$03 Call #R$894F.
  $A83C,$03 Call #R$9356.
  $A83F,$03 Call #R$8BBB.
  $A842,$03 Call #R$B2F9.
  $A845,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $A848,$03 Write #REGa to #R$5E53.
  $A84B,$01 Return.

c $A84C Initialise New Game
@ $A84C label=NewGame
  $A84C,$02 #REGb=#N$02 (counter for our two players).
@ $A84E label=NewGame_Loop
  $A84E,$01 Stash the counter in #REGbc on the stack.
N $A84F Handle setting up 1UP player.
  $A84F,$05 Write 1UP starting level to #R$5EA0.
  $A854,$05 Write 1UP starting lives to #R$5EA1.
  $A859,$07 Write #N$00 to; #LIST { #R$5EA2 } { #R$5EA3 } LIST#
  $A860,$03 Call #R$B3DC.
  $A863,$03 Call #R$9F5E.
  $A866,$03 Call #R$A880.
  $A869,$01 Restore #REGbc from the stack.
  $A86A,$02 Decrease counter by one and loop back to #R$A84E until counter is zero.
N $A86C Handle setting up 2UP player.
  $A86C,$05 Write 2UP starting lives to #R$5EA5.
  $A871,$05 Write 2UP starting level to #R$5EA4.
  $A876,$03 #REGa=#R$5E00.
  $A879,$02,b$01 Keep only bit 0.
  $A87B,$01 Return if #R$5E00 indicates this is a 1 player only game.
  $A87C,$03 Write #REGa to #R$5EA5.
  $A87F,$01 Return.

c $A880
  $A880,$03 #REGhl=#R$5EA0.
  $A883,$03 #REGde=#R$5EA4.
  $A886,$02 #REGb=#N$04.
  $A891,$03 #REGhl=#R$7000.
  $A894,$03 #REGde=#R$7400.
  $A897,$03 #REGbc=#N$0400.
  $A89A,$03 Call #R$A8A6.
  $A89D,$03 #REGhl=#R$6090.
  $A8A0,$03 #REGde=#R$6240.
  $A8A3,$03 #REGbc=#N$0120.
  $A8A6,$01 Stash #REGbc on the stack.
  $A8A7,$01 #REGa=fetch byte from #REGde.
  $A8A8,$01 #REGc=fetch byte from #REGhl.
  $A8A9,$03 Write the byte from #REGde to #REGhl, and the byte from #REGhl to #REGde.
  $A8AC,$01 Increment #REGhl by one.
  $A8AD,$01 Increment #REGde by one.
  $A8AE,$01 Restore #REGbc from the stack.
  $A8AF,$01 Decrease #REGbc by one.
  $A8B0,$04 Jump back to #R$A8A6 until #REGbc is zero.
  $A8B4,$01 Return.

c $A8B5
  $A8B5,$03 #REGa=#R$5E00.
  $A8B8,$02,b$01 Keep only bit 0.
  $A8BA,$02
  $A8BC,$06 Jump to #R$A939 if #R$5EA1 is zero.
  $A8C2,$03 Jump to #R$A82A.

  $A8C5,$06 Jump to #R$A8BC if #R$5EA5 is zero.

  $A8CB,$07 Call #R$A931 if #R$5EA1 is zero.

  $A8D2,$03 Call #R$A880.
  $A8D5,$04 Write #N$00 to #R$5E6C.
  $A8D9,$03 #REGa=#R$5E65.
  $A8DC,$01 Flip the bits.
  $A8DD,$03 Write the result back to #R$5E65.
  $A8E0,$03 Jump to #R$A82A.

c $A8E3 Game Over
E $A8E3 View the equivalent code in;
. #LIST
. { #ATICATAC$8C35 }
. { #COOKIE$6BE0 }
. LIST#
@ $A8E3 label=GameOver_1UP_Messaging
N $A8E3 #HTML(Set up altering the "#FONT:(GAME OVER PLAYER 0)addr=$D347,attr=$47(game-over-0up)" message for 1UP.)
  $A8E3,c,$02 #REGa="1" + #N$80 (escape character).
N $A8E5 Print the altered messaging and pause to show it for a period of time.
@ $A8E5 label=GameOver_Write
  $A8E5,$03 Write ASCII player number to #R$A94C(#N$A95D).
  $A8E8,$03 Call #R$84D8.
N $A8EB Handle printing "#FONT:(GAME OVER PLAYER X)addr=$D347,attr=$47(game-over)" messaging.
  $A8EB,$03 #REGde=#R$A94B.
  $A8EE,$03 #REGhl=#N$7038 (screen location).
  $A8F1,$03 Call #R$8A11.
  $A8F4,$03 #REGde=#R$B9D2.
  $A8F7,$03 Call #R$B9BC.
N $A8FA Set a lower delay period for the following test.
  $A8FA,$02 #REGb=#N$04 (delay loop counter).
  $A8FC,$05 #REGa=#R$6090-#N$1A.
  $A901,$04 If the lunar rover was not destroyed, jump straight to #R$A922.
N $A905 Handle printing "#FONT:(YOUR LUNAR ROVER HAS BEEN)addr=$D347,attr=$45(lunar-rover)" messaging.
  $A905,$03 #REGde=#R$A95E.
  $A908,$03 #REGhl=#N$3818 (screen location).
  $A90B,$03 Call #R$8A11.
N $A90E Handle printing "#FONT:(DESTROYED.)addr=$D347,attr=$45(destroyed)" messaging.
  $A90E,$03 #REGde=#R$A979.
  $A911,$03 #REGhl=#N$4858 (screen location).
  $A914,$03 Call #R$8A11.
N $A917 Handle printing "#FONT:(ALL IS LOST.)addr=$D347,attr=$45(all-lost)" messaging.
  $A917,$03 #REGde=#R$A985.
  $A91A,$03 #REGhl=#N$5850 (screen location).
  $A91D,$03 Call #R$8A11.
N $A920 Provide a pause for us to reflect that the game has now ended.
  $A920,$02 #REGb=#N$08 (delay loop counter).
@ $A922 label=GameOverDelay
  $A922,$03 #REGhl=#N($0000,$04,$04).
N $A925 From #REGhl being set above, note that decrementing #N($0000,$04,$04) by one gives #N$FFFF.
@ $A925 label=GameOverDelay_Loop
  $A925,$01 Decrease #REGhl by one.
  $A926,$04 Jump back to #R$A925 until #REGhl is zero.
  $A92A,$02 Decrease delay loop counter by one and loop back to #R$A925 until the counter is zero.
  $A92C,$01 Return.
N $A92D #HTML(Set up altering the "#FONT:(GAME OVER PLAYER 0)addr=$D347,attr=$47(game-over-0up)" message for 2UP.)
@ $A92D label=GameOver_2UP_Messaging
  $A92D,c,$02 #REGa="2" + #N$80 (escape character).
  $A92F,$02 Jump to #R$A8E5.
N $A931 Handles checking if this is a 1UP or 2UP game.
@ $A931 label=GameOver_Check_Player_1UP
  $A931,$06 If #R$5E65 is zero, jump to #R$A8E3.
  $A937,$02 Jump to #R$A92D.
N $A939 Handles checking if this is a 2UP or 1UP game.
@ $A939 label=GameOver_Check_Player_2UP
  $A939,$06 If #R$5E65 is not zero, jump to #R$A945.
  $A93F,$03 Call #R$A8E3.
  $A942,$03 Jump to #R$F56E.
N $A945 Handle 2UP, and then check if this is a new high score.
@ $A945 label=GameOver_2UP
  $A945,$03 Call #R$A92D.
  $A948,$03 Jump to #R$F56E.

t $A94B Messaging: Game Over
N $A94B #FONT:(GAME OVER PLAYER X)addr=$D347,attr=$47(game-over)
@ $A94B label=String_GameOver
  $A94B,$13,h$01,$11:$01 Attribute: #N(#PEEK(#PC)) + "GAME OVER PLAYER X".
N $A95E #FONT:(YOUR LUNAR ROVER HAS BEEN)addr=$D347,attr=$45(lunar-rover)
@ $A95E label=String_Lunar_Rover
  $A95E,$1B,h$01,$19:$01 Attribute: #N(#PEEK(#PC)) + "YOUR LUNAR ROVER HAS BEEN".
N $A979 #FONT:(DESTROYED.)addr=$D347,attr=$45(destroyed)
@ $A979 label=String_Destroyed
  $A979,$0C,h$01,$0A:$01 Attribute: #N(#PEEK(#PC)) + "DESTROYED.".
N $A985 #FONT:(ALL IS LOST.)addr=$D347,attr=$45(all-lost)
@ $A985 label=String_All_Lost
  $A985,$0E,h$01,$0C:$01 Attribute: #N(#PEEK(#PC)) + "ALL IS LOST.".

c $A993
B $AADF,$50

c $AB9D
  $AB9D,$03 #REGhl=#R$AADF.
  $ABA0,$03 #REGde=#R$AA4B.
  $ABA3,$03 #REGbc=#N($0050,$04,$04).
  $ABA6,$02
  $ABA8,$01 Return.

c $ABA9
  $ABA9,$03 #REGa=#REGix+#N$00.
  $ABAD,$02,b$01 Keep only bits 0-3.

  $ABB4,$03 Call #R$8701.
  $ABB7,$03 Jump to #R$8733.
  $ABBA,$02 #REGe=#N$18.
  $ABBC,$03 Call #R$B2A4.

  $ABC2,$06 If #REGix+#N$17 is zero, jump to #R$AC3E.
  $ABC8,$03 Call #R$ABA9.
  $ABCB,$03 #REGa=#R$5E42.
  $ABCE,$01 Flip the bits.
  $ABCF,$02,b$01 Keep only bits 0-3.

  $ABD2,$06 If #R$5E67 is not zero, jump to #R$ABE5.
  $ABD8,$07 If #R$6078 is #N$81, jump to #R$ABE5.

  $ABE8,$03 #REGhl=#N$2040.
  $ABEB,$03 Call #R$8C01.
  $ABEE,$03 Call #R$AD36.

  $ABF3,$03 Call #R$AD0B.
  $ABF6,$03 #REGhl=#N$587B (attribute buffer location).
  $ABF9,$03 Call #R$AD00.
  $ABFC,$03 #REGhl=#N$587D (attribute buffer location).
  $ABFF,$02 #REGa=#N$42 (attribute value).
  $AC01,$03 Call #R$AD00.
  $AC04,$03 #REGa=#R$5E42.
  $AC07,$02,b$01 Keep only bits 0-5.
  $AC09,$02
  $AC0B,$02 If so, jump to #R$AC1A.
  $AC0D,$03
N $AC10 Handle printing the "#FONT:(ghij)addr=$D347,attr=$45(alien)" messaging.
  $AC10,$03 #REGde=#R$AC24.
@ $AC13 label=BannerMessaging_Print
  $AC13,$03 #REGhl=#N$10D8 (screen location).
  $AC16,$03 Call #R$8A11.
  $AC19,$01 Return.
N $AC1A Handle printing the "#FONT:(cdef)addr=$D347,attr=$45(base)" messaging.
  $AC1A,$03 #REGde=#R$AC1F.
  $AC1D,$02 Jump to #R$AC13.
@ $AC1F label=BannerMessaging_Base
T $AC1F,$05,$04:01 Attribute: #N(#PEEK(#PC)) + "#FONT:(cdef)addr=$D347,attr=$45(base)".
@ $AC24 label=BannerMessaging_Alien
T $AC24,$05,$04:01 Attribute: #N(#PEEK(#PC)) + "#FONT:(ghij)addr=$D347,attr=$45(alien)".
  $AC29,$03 Call #R$AD0B.
  $AC2C,$03 #REGhl=#N$587D (attribute buffer location).
  $AC2F,$03 Call #R$AD00.
  $AC32,$03 #REGhl=#N$587B (attribute buffer location).
  $AC35,$02 #REGa=#N$42 (attribute byte).
  $AC37,$02 Jump to #R$AC01.

c $AC39

B $ACA0,$30
B $ACD0,$30

c $AD00 Handler: Colourise 2x2
@ $AD00 label=Handler_Colour2x2
N $AD00 This routine writes an attribute value to four attribute buffer locations.
R $AD00 A The attribute value to write
R $AD00 HL The address in the attribute buffer to begin writing to
  $AD00,$01 Write #REGa to #REGhl.
N $AD01 Move one byte to the right.
  $AD01,$01 Increment #REGl by one.
  $AD02,$01 Write #REGa to #REGhl.
N $AD03 Moves down to the next line, but less one byte - so under the first attribute buffer location.
  $AD03,$04 #REGhl=#REGhl+#N($001F,$04,$04).
  $AD07,$01 Write #REGa to #REGhl.
N $AD08 Move one byte to the right.
  $AD08,$01 Increment #REGl by one.
  $AD09,$01 Write #REGa to #REGhl.
  $AD0A,$01 Return.

c $AD0B

c $AD22
  $AD22,$03 Call #R$AD0B.
  $AD25,$03 #REGhl=#N$5861 (attribute buffer location).
  $AD28,$01 Stash #REGaf on the stack.
  $AD29,$03 Call #R$AD00.
  $AD2C,$01 Restore #REGaf from the stack.
  $AD2D,$03 #REGhl=#N$5863 (attribute buffer location).
  $AD30,$03 Jump to #R$AD00.

c $AD33
  $AD33,$01 #REGa=#N$00.
  $AD34,$02 Jump to #R$AD25.

c $AD36
  $AD36,$03 #REGhl=#R$607A.

  $ADDE,$03 Call #R$B2D7.
N $ADE1 Destroying the missile adds #N$0500 points. TBC is this the decoy missile?
  $ADE1,$03 #REGbc=#N$0500.
  $ADE4,$03 Call #R$899C.
  $ADE7,$03 Jump to #R$A76B.

B $AEBC,$30
B $AEEC,$30

N $AF67 Take one hit off the missile hit count total.
  $AF67,$03 Decrease #REGix+#N$16 by one.
  $AF6A,$02 Jump to #R$AFB1 if the missile has been destroyed.
  $AF6C,$03 Call #R$B8B4.
N $AF6F Each missile hit adds #N$0100 points.
  $AF6F,$03 #REGbc=#N$0100.
  $AF72,$03 Call #R$899C.

  $AFAE,$03 Call #R$B2D7.
  $AFB1,$05 Write #N$01 to #R$6195.
N $AFB6 Destroying the missile adds #N$0500 points. TBC is this the decoy missile?
  $AFB6,$03 #REGbc=#N$0500.
  $AFB9,$03 Call #R$899C.

c $B2F9
  $B2F9,$03 #REGa=#N$60B0.
  $B300,$02,b$01 Set bit 7.
  $B305,$03 #REGa=#N$60C8.
  $B30C,$02,b$01 Set bit 7.
  $B311,$03 #REGa=#N$60E0.
  $B314,$02,b$01 Keep only bits 2-7.
  $B329,$02,b$01 Set bit 1.
  $B338,$01 Return.

c $B339
  $B339,$02 Write #N$40 to #REGhl.
  $B33B,$02 Jump to #R$B2EE.

c $B33D
  $B33D,$03 Decrease #REGix+#N$12 by one.

  $B357,$03 Call #R$907B.

  $B36A,$03 Call #R$B8CD.

  $B378,$03 Jump to #R$ABB4.

c $B37B
  $B37B,$04 Write #N$AF to #REGix+#N$04.
  $B37F,$03 Call #R$A75D.
  $B382,$03 Jump to #R$ABB4.

c $B385
  $B385,$03 #REGhl=#R$61B0.
  $B388,$02 #REGb=#N$90.
  $B38A,$02 Write #N$00 to #REGhl.
  $B38C,$01 Increment #REGhl by one.
  $B38D,$02 Decrease counter by one and loop back to #R$B38A until counter is zero.
  $B38F,$01 Return.

c $B390
  $B390,$05 Return if #R$5E6C is not zero.
  $B395,$03 Decrease #REGix+#N$05 by one.
  $B398,$01 Return if the result is above zero.
  $B399,$03 Jump to #R$A8B5.
N $B39C
  $B39C,$03 Decrease #REGix+#N$05 by one.
  $B39F,$01 Return if the result is above zero.
  $B3A0,$03 Jump to #R$A8B5.

c $B3A3 Message: Teleporting
@ $B3A3 label=MessageTeleporting
  $B3A3,$01 Disable interrupts.
  $B3A4,$03 Call #R$8BA5.
  $B3A7,$02 #REGb=#N$10 (colour cycling counter).
@ $B3A9 label=MessageTeleporting_Loop
  $B3A9,$01 Stash #REGbc (the colour cycling counter) on the stack.
N $B3AA Handle printing "#FONT:(TELEPORTING)addr=$D347,attr=$41(teleporting)" messaging.
  $B3AA,$03 #REGhl=#N$7058 (screen buffer location).
  $B3AD,$03 #REGde=#R$B3D0.
  $B3B0,$03 Call #R$8A11.
N $B3B3 Create a small pause so the player can read the messaging. This is an inner loop, as it's called for each time
.       the INK is changed - hence it's #N($2000, $04, $04) * #N$10.
  $B3B3,$03 #REGhl=#N($2000, $04, $04) (counter).
@ $B3B6 label=Teleporting_Pause
  $B3B6,$01 Decrease #REGhl by one.
  $B3B7,$04 Jump back to #R$B3B6 until #REGhl is zero.
N $B3BB Handle cycling the text INK colour.
  $B3BB,$03 #REGa=the attribute byte of #R$B3D0.
  $B3BE,$01 Increment #REGa by one.
  $B3BF,$02,b$01 Keep only bits 0-2 (INK).
  $B3C1,$02 Jump to #R$B3C4 if #REGa was not zero.
  $B3C3,$01 Increment #REGa by one.
@ $B3C4 label=MsgTeleporting_Skip
  $B3C4,$02,b$01 Set bit 6 (BRIGHT).
  $B3C6,$03 Store #REGa at #R$B3D0 to overwrite the attribute byte.
  $B3C9,$01 Restore #REGbc (the colour cycling counter) from the stack.
  $B3CA,$03 Call #R$B8E8.
  $B3CD,$02 Decrease colour cycling counter by one and loop back to #R$B3A9 until the counter is zero.
  $B3CF,$01 Return.

t $B3D0 Messaging: Teleporting
N $B3D0 #FONT:(TELEPORTING)addr=$D347,attr=$41(teleporting)
@ $B3D0 label=String_Teleporting
  $B3D0,$0C,h$01,$0A:$01 Attribute: #N(#PEEK(#PC)) + "TELEPORTING".

c $B3DC Initialise Terrain
@ $B3DC label=Terrain_Initialise
  $B3DC,$03 #REGhl=#R$F6CE.
  $B3DF,$03 #REGde=#R$7000.
  $B3E2,$03 #REGbc=#N$0400.
  $B3E5,$02 Copies the default terrain data to the terrain buffer.
  $B3E7,$01 Return.

c $B3E8
  $B3E8,$03 #REGa=#R$5E42.
  $B3EB,$01 Flip the bits.
  $B3EC,$02,b$01 Keep only bit 0.
  $B3EE,$02
  $B3F0,$03 Decrease #REGix+#N$08 by one.

  $B41B,$03 Call #R$A002.

  $B42F,$03 Call #R$8787.
  $B432,$03 Call #R$8733.

  $B440,$01 Return.
  $B441,$03 Call #R$864F.
  $B444,$04 Write #N$00 to #R$5EA1.
  $B448,$04 Write #N$85 to #REGix+#N$00.
  $B44C,$04 Write #N$40 to #REGix+#N$05.
  $B450,$01 Return.
B $B451

c $B460
  $B4C1,$01 Return.

c $B4C2
  $B4C2,$03 #REGhl=#N$60A8.
  $B4C5,$03 #REGbc=#N$0711.

c $B52E
  $B52E,$01 Disable interrupts.
  $B52F,$03 #REGde=#R$BA2A.
  $B532,$03 Call #R$B9BC.

  $B539,$03 Call #R$B699.
N $B53C Here we alter "#FONT:(IT IS ESTIMATED THAT XX LASER)addr=$D347,attr=$47(hits)" to update with the number of hits.
  $B53C,$03 #REGhl=#R$B64B(#N$B660).

  $B544,$02,b$01 Keep only bits 0-3.

  $B54F,$02,b$01 Keep only bits 0-3.

  $B554,$03 Call #R$8BA5.
  $B557,$02 #REGb=#N$0C.
  $B559,$01 Stash #REGbc on the stack.
  $B55A,$03 Call #R$8298.
  $B55D,$03 Call #R$B594.
  $B560,$02 #REGc=#N$80 (pitch).
  $B562,$02 #REGd=#N$80 (duration).
  $B564,$03 Call #R$B8DA.

  $B577,$03 #REGhl=#R$8000.

  $B57F,$01 Restore #REGbc from the stack.

  $B582,$03 #REGde=#R$B9DA.
  $B585,$03 Call #R$B9BC.
  $B588,$03 Call #R$8BA5.
  $B58B,$03 Call #R$A317.
  $B58E,$03 Call #R$B385.
  $B591,$03 Jump to #R$A2F5.

c $B594 Messaging: Missile Launch
@ $B594 label=Message_MissileLaunch
N $B594 Handle displaying "WARNING" messaging.
  $B594,$03 #REGde=#R$B5DC.
  $B597,$03 #REGhl=#N($2860, $04, $04) (screen location).
  $B59A,$03 Call #R$8A11.
N $B59D Handle displaying "A MISSILE HAS BEEN LAUNCHED" messaging.
  $B59D,$03 #REGde=#R$B5E4.
  $B5A0,$03 #REGhl=#N($3808, $04, $04) (screen location).
  $B5A3,$03 Call #R$8A11.
N $B5A6 Handle displaying "FROM THE ENEMY BASE" messaging.
  $B5A6,$03 #REGde=#R$B601.
  $B5A9,$03 #REGhl=#N($4808, $04, $04) (screen location).
  $B5AC,$03 Call #R$8A11.
N $B5AF Handle displaying "YOUR LUNAR ROVER IS IN DANGER" messaging.
  $B5AF,$03 #REGde=#R$B617.
  $B5B2,$03 #REGhl=#N($5808, $04, $04) (screen location).
  $B5B5,$03 Call #R$8A11.
N $B5B8 Handle displaying "OF BEING DESTROYED" messaging.
  $B5B8,$03 #REGde=#R$B636.
  $B5BB,$03 #REGhl=#N($6808, $04, $04) (screen location).
  $B5BE,$03 Call #R$8A11.
N $B5C1 Handle displaying "IT IS ESTIMATED THAT    LASER" messaging.
  $B5C1,$03 #REGde=#R$B64A.
  $B5C4,$03 #REGhl=#N($8008, $04, $04) (screen location).
  $B5C7,$03 Call #R$8A11.
N $B5CA Handle displaying "HITS WILL BE REQUIRED TO" messaging.
  $B5CA,$03 #REGde=#R$B669.
  $B5CD,$03 #REGhl=#N($9008, $04, $04) (screen location).
  $B5D0,$03 Call #R$8A11.
N $B5D3 Handle displaying "DESTROY THE MISSILE." messaging.
  $B5D3,$03 #REGde=#R$B683.
  $B5D6,$03 #REGhl=#N($A008, $04, $04) (screen location).
  $B5D9,$03 Jump to #R$8A11.

t $B5DC Messaging: Missile Launch
@ $B5DC label=String_Warning
N $B5DC #FONT:(WARNING)addr=$D347,attr=$56(warning)
  $B5DC,$08,h$01,$06:$01 "WARNING".
@ $B5E4 label=String_Launched
N $B5E4 #FONT:(A MISSILE HAS BEEN LAUNCHED)addr=$D347,attr=$46(launched)
  $B5E4,$1D,h$01,$1B:$01 "A MISSILE HAS BEEN LAUNCHED "
@ $B601 label=String_EnemyBase
N $B601 #FONT:(FROM THE ENEMY BASE)addr=$D347,attr=$46(enemy-base)
  $B601,$16,h$01,$14:$01 "FROM THE ENEMY BASE "
@ $B617 label=String_Danger
N $B617 #FONT:(YOUR LUNAR ROVER IS IN DANGER)addr=$D347,attr=$44(danger)
  $B617,$1F,h$01,$1D:$01 "YOUR LUNAR ROVER IS IN DANGER ".
@ $B636 label=String_BeingDestroyed
N $B636 #FONT:(OF BEING DESTROYED)addr=$D347,attr=$44(being-destroyed)
  $B636,$14,h$01,$12:$01 "OF BEING DESTROYED ".
@ $B64A label=String_Estimated
N $B64A #FONT:(IT IS ESTIMATED THAT    LASER)addr=$D347,attr=$47(estimated)
  $B64A,$1F,h$01,$1D:$01 "IT IS ESTIMATED THAT    LASER ".
@ $B669 label=String_Required
N $B669 #FONT:(HITS WILL BE REQUIRED TO)addr=$D347,attr=$47(required)
  $B669,$1A,h$01,$18:$01 "HITS WILL BE REQUIRED TO ".
@ $B683 label=String_DestroyMissile
N $B683 #FONT:(DESTROY THE MISSILE.)addr=$D347,attr=$47(missile)
  $B683,$16,h$01,$14:$01 "DESTROY THE MISSILE. ".

c $B699 Convert To Base 10
@ $B699 label=Convert_Base10
R $B699 A Input number
R $B699 O:A Output number
N $B699 For an example, given #REGa=#N$16 - the output is #EVAL($22,$02,$08).
N $B699 First count the number of "10's" in #REGa.
  $B699,$03 #REGbc=#N($000A,$04,$04).
@ $B69C label=Convert_Base10_Loop
  $B69C,$01 Increment #REGb counter.
  $B69D,$01 #REGa-=#N$0A.
  $B69E,$02 Jump back to #R$B69C until there's a carry amount.
  $B6A0,$01 #REGa+=#REGc.
  $B6A1,$01 Decrease the counter in #REGb by one to account for the carry.
  $B6A2,$08 Shift and rotate #REGb four times.
  $B6AA,$02,b$01 Keep only bits 0-3.
  $B6AC,$01 Set the bits from #REGb.
  $B6AD,$01 Return.

c $B6AE
  $B6AE,$04 #REGc=#REGix+#N$05.
  $B6B9,$03 #REGl=#REGix+#N$02.
  $B6BC,$03 #REGh=#REGix+#N$03.
  $B6BF,$03 Call #R$A002.
  $B6CE,$01 Return.

c $B6CF
  $B6CF,$03 #REGbc=#R$B6DB.
  $B6D2,$03 #REGa=#REGix+#N$08.
  $B6D5,$02,b$01 Keep only bits 0-3.
  $B6D7,$01 #REGl=#REGa.
  $B6D8,$03 Jump to #R$81FE.
W $B6DB,$10
  $B6EB,$01 Return.
  $B6EC,$03 Call #R$B7A8.
  $B6EF,$03 Call #R$945C.
  $B706,$04 Write #N$81 to #REGix+#N$08.
  $B716,$03 Call #R$B8BD.
  $B719,$03 Jump to #R$A431.
  $B723,$03 #REGbc=#N$FFF4.
  $B729,$03 Jump to #R$A43E.
  $B72C,$03 #REGbc=#N($0012,$04,$04).
  $B72F,$02 Jump to #R$B726.

c $B731
B $B76D,$18

c $B785
  $B785,$03 Call #R$945C.

  $B78E,$03 Call #R$A4E7.

  $B793,$04 Write #N$81 to #REGix+#N$08.
  $B797,$03 #REGa=#R$6080.
  $B79A,$02,b$01 Set bit 0.
  $B79C,$03 Write #REGa to #R$6080.
  $B79F,$03 Call #R$B8BD.
  $B7A2,$03 Call #R$B7A8.
  $B7A5,$03 Jump to #R$ABB4.

c $B7A8 Handler: Bomb
@ $B7A8 label=Handler_Bomb
R $B7A8 IX Animation object
N $B7A8 Animate the sprite.
  $B7A8,$03 #REGa=#REGix+#N$00.
  $B7AB,$01 Increment #REGa by one.
N $B7AC The bomb has four frames of animation.
  $B7AC,$02,b$01 Keep only bits 0-1.
N $B7AE With sprite IDs beginning from #R$EE17(#N$EC) (#SPRITENAME$EC).
  $B7AE,$02 #REGa=#REGa+#N$EC.
  $B7B0,$03 Write #REGa back to #REGix+#N$00.
  $B7B3,$03 #REGa=#REGix+#N$07.
  $B7B6,$02,b$01
  $B7B8,$03 Write #REGa back to #REGix+#N$07.
  $B7BB,$01 Return.

c $B7BC
  $B7BC,$03 Call #R$945C.

  $B81E,$03 Call #R$B6AE.

  $B828,$03 Call #R$B854.

  $B82E,$03 Call #R$B16F.
  $B831,$05 Write #N$01 to #R$6195.
N $B836 Destroying the alien base adds #N$3000 points.
  $B836,$03 #REGbc=#N$3000.
  $B839,$03 Call #R$899C.

  $B87D,$01 Return.

c $B87E
  $B87E,$03 #REGa=#R$6078.
  $B883,$03 #REGhl=#R$BCA9.

  $B888,$02 #REGa=#N$57.
  $B88A,$01 Write #REGa to #REGhl.
  $B88B,$01 Increment #REGhl by one.
  $B88C,$01 Write #REGa to #REGhl.
  $B88D,$01 Increment #REGhl by one.
  $B88E,$02 Write #N$47 to #REGhl.
  $B890,$01 Return.
  $B891,$02 #REGa=#N$57.
  $B893,$02 Write #N$47 to #REGhl.
  $B895,$01 Increment #REGhl by one.
  $B896,$01 Write #REGa to #REGhl.
  $B897,$01 Increment #REGhl by one.
  $B898,$01 Write #REGa to #REGhl.
  $B899,$01 Return.

c $B89A
  $B89A,$03 Decrease #REGix+#N$11 by one.
  $B89D,$01 Return if the result is not zero.
  $B89E,$03 #REGa=#REGix+#N$12.
  $B8A1,$03 Write #REGa to #REGix+#N$11.
  $B8A4,$03 Increment #REGix+#N$06 by one.
  $B8A7,$01 Return.

c $B8A8 Sounds: Laser Beam
@ $B8A8 label=SoundsLaserBeam
  $B8B3,$01 Return.

c $B8B4 Sounds: Laser Missile Hit
@ $B8B4 label=SoundsLaserMissileHit
  $B8B4,$02 #REGc=#N$38 (pitch).
@ $B8B6 label=SoundsLaserMissileHit_Loop
  $B8B6,$03 Call #R$B8DA.
  $B8B9,$03 Decrease duration by one and loop back to #R$B8B6 until duration is zero.
  $B8BC,$01 Return.

c $B8BD
  $B8BD,$02 #REGd=#N$20 (duration).
  $B8BF,$02 #REGc=#N$50 (pitch).
  $B8C1,$02 Jump to #R$B8CD.

c $B8C3
  $B8C3,$02 #REGd=#N$30 (duration).
  $B8C5,$02 #REGc=#N$40 (pitch).
  $B8C7,$02 Jump to #R$B8CD.

c $B8C9 Sounds: Pickup Item
E $B8C9 View the equivalent code in;
. #LIST
. { #JETPAC$6809 }
. LIST#
@ $B8C9 label=SoundsPickupItem
  $B8C9,$02 #REGd=#N$40 (duration).
  $B8CB,$02 #REGc=#N$30 (pitch).
@ $B8CD label=SquareWave_Loop
  $B8CD,$03 Call #R$B8DA.
  $B8D0,$03 Decrease duration by one and loop back to #R$B8CD until duration is zero.
  $B8D3,$01 Return.

c $B8D4
  $B8D4,$02 #REGd=#N$10 (duration).
  $B8D6,$02 #REGc=#N$60 (pitch).
  $B8D8,$02 Jump to #R$B8CD.

c $B8DA Play square wave sound
@ $B8DA label=PlaySquareWave
R $B8DA C Duration of wave
  $B8DA,$03 Decrease duration by one and loop back to #R$B8DB until duration is zero.
@ $B8DB label=Silence_Loop
  $B8DD,$04 #REGa=#N$10 (speaker on = bit 4).
  $B8E1,$03 Decrease duration by one and loop back to #R$B8E2 until duration is zero.
@ $B8E2 label=PlaySquareWave_Loop
  $B8E4,$03 Speaker off.
  $B8E7,$01 Return.

c $B8E8

c $B8F2

c $B8FF

c $B918

c $B922
E $B922 Continue on to #R$B92D.
  $B922,$03 Decrease #REGix+#N$03 by one.
  $B925,$02 Jump to #R$B94B if zero.
  $B927,$03 #REGc=#REGix+#N$03 (duration).
  $B92A,$03 #REGd=#REGix+#N$02 (pitch).

c $B92D Play Wave Sequence
@ $B92D label=PlayWaveSequence
R $B92D C Duration of wave
R $B92D D Number of times to repeat
E $B92D View the equivalent code in;
. #LIST
. { #SABREWULF$BF6D }
. LIST#
  $B92D,$03 Call #R$B8DA.
  $B930,$01 Decrease #REGd by one.
  $B931,$02 Jump to #R$B92D until #REGd is zero.
  $B933,$01 Return.

c $B934
  $B934,$03 Decrease #REGix+#N$01 by one.
  $B937,$02 Jump to #R$B94B if zero.
N $B939 Create an offset in #REGbc.
  $B939,$03 #REGc=#REGix+#N$01.
  $B93C,$02 #REGb=#N$00.
  $B93E,$03 #REGl=#REGix+#N$02.
  $B941,$03 #REGh=#REGix+#N$03.
  $B944,$01 #REGhl=#REGhl+#REGbc.
  $B945,$01 #REGc=#REGhl (duration).
  $B946,$03 #REGd=#REGix+#N$04 (pitch).
  $B949,$02 Jump to #R$B92D.

c $B94B Sound: Finish Effect
@ $B94B label=SoundEffect_Finish
E $B94B View the equivalent code in;
. #LIST
. { #JETPAC$6839 }
. LIST#
N $B94B Set frequency to zero.
  $B94B,$04 Write #N$00 to #REGix+#N$00.
  $B94F,$01 Return.

c $B950
R $B950 HL Source address
R $B950 DE Destination address
R $B950 BC Number of bytes to copy
  $B950,$03 #REGhl=#R$B95C.
  $B953,$03 #REGde=#R$6060.
  $B956,$03 #REGbc=#N($0008,$04,$04).
  $B959,$02 Copy #N$08 bytes from #REGhl to #REGde.
  $B95B,$01 Return.
B $B95C,$04
  $B960
B $B965,$07
B $B96C,$07

N $B973
  $B973,$03 #REGhl=#R$B978.
  $B976,$02 Jump to #R$B953.
B $B978

N $B986
  $B986,$03 #REGhl=#R$B98B.
  $B989,$02 Jump to #R$B953.
B $B98B

N $B9A1
  $B9A1,$03 #REGhl=#R$B9A6.
  $B9A4,$02 Jump to #R$B953.
B $B9A6

c $B9BC
  $B9BC,$01 Disable interrupts.
  $B9BD,$03 #REGhl=#R$FF51.
  $B9C8,$02 Jump to #R$B9C0.
  $B9CA,$02,b$01 Keep only bits 0-6.
  $B9D0,$01 Enable interrupts.
  $B9D1,$01 Return.

b $B9D2
  $B9EE
  $B9FC
  $BA09
  $BA0F
  $BA1D
  $BA2A
  $BA2D
  $BA35

w $BA9E

w $BAA4
  $BAA4,$04,$02

b $BAA8

w $BABE

w $BAC0 Sprite Table
@ $BAC0 label=SpritesTable
E $BAC0 View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #JETPAC$0000 }
. { #PSSST$761A }
. { #TRANZAM$0000 }
. LIST#
  $BAC0,$02 Sprite ID: #R(#PEEK(#PC)+#PEEK(#PC+$01)*$100)(#N((#PC-$BABE)/$02)) #SPRITENAME((#PC-$BABE)/$02).
L $BAC0,$02,$EF

b $BC9E
  $BC9E,$01 Width = #N(#PEEK(#PC)) bytes.
  $BC9F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BCA0,$1C,$07
  $BCA9

b $BCBC Sprite: None
  $BCBC,$01 Width = #N(#PEEK(#PC)) bytes.
  $BCBD,$01 Height = #N(#PEEK(#PC)) pixels.

b $BCBE Sprite: Jetman Walking
N $BCBE Walking left frame 1.
  $BCBE,$01 Height = #N(#PEEK(#PC)) pixels.
  $BCBF,$2C,$02 #SPRITE$08(jetman-walk-left-01*)

N $BCEB Walking left frame 2.
  $BCEB,$01 Height = #N(#PEEK(#PC)) pixels.
  $BCEC,$2C,$02 #SPRITE$09(jetman-walk-left-02*)

N $BD18 Walking left frame 3.
  $BD18,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD19,$2C,$02 #SPRITE$0A(jetman-walk-left-03*)

N $BD45 Walking right frame 1.
  $BD45,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD46,$2C,$02 #SPRITE$0C(jetman-walk-right-01*)

N $BD72 Walking right frame 2.
  $BD72,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD73,$2C,$02 #SPRITE$0D(jetman-walk-right-02*)

N $BD9F Walking right frame 3.
  $BD9F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BDA0,$2C,$02 #SPRITE$0E(jetman-walk-right-03*)

b $BDCC Sprite: Jetman Flying
N $BDCC Flying left frame 1.
  $BDCC,$01 Height = #N(#PEEK(#PC)) pixels.
  $BDCD,$30,$02 #SPRITE$00(jetman-fly-left-01)

N $BDFD Flying left frame 2.
  $BDFD,$01 Height = #N(#PEEK(#PC)) pixels.
  $BDFE,$30,$02 #SPRITE$01(jetman-fly-left-02)

N $BE2E Flying right frame 1.
  $BE2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $BE2F,$30,$02 #SPRITE$04(jetman-fly-right-01)

N $BE5F Flying right frame 2.
  $BE5F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BE60,$30,$02 #SPRITE$05(jetman-fly-right-02)

b $BE90 Graphic: Moon Rover
N $BE90 Right frame 1.
  $BE90,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $BE91,$01 Height = #N(#PEEK(#PC)) pixels.
  $BE92,$BD,$07 #ROVER$04(rover-right-01)

N $BF4F Right frame 2.
  $BF4F,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $BF50,$01 Height = #N(#PEEK(#PC)) pixels.
  $BF51,$BD,$07 #ROVER$05(rover-right-02)

N $C00E Right frame 3.
  $C00E,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C00F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C010,$BD,$07 #ROVER$06(rover-right-03)

N $C0CD Right frame 4.
  $C0CD,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C0CE,$01 Height = #N(#PEEK(#PC)) pixels.
  $C0CF,$BD,$07 #ROVER$07(rover-right-04)

N $C18C Right frame 5.
  $C18C,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C18D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C18E,$D8,$08 #ROVER$11(rover-right-05)

N $C266 Right frame 6.
  $C266,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C267,$01 Height = #N(#PEEK(#PC)) pixels.
  $C268,$D8,$08 #ROVER$12(rover-right-06)

N $C340 Right frame 7.
  $C340,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C341,$01 Height = #N(#PEEK(#PC)) pixels.
  $C342,$D8,$08 #ROVER$13(rover-right-07)

N $C41A Right frame 8.
  $C41A,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C41B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C41C,$D8,$08 #ROVER$14(rover-right-08)

N $C4F4 Right frame 9.
  $C4F4,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C4F5,$01 Height = #N(#PEEK(#PC)) pixels.
  $C4F6,$D8,$08 #ROVER$15(rover-right-09)

N $C5CE Right frame 10.
  $C5CE,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C5CF,$01 Height = #N(#PEEK(#PC)) pixels.
  $C5D0,$D8,$08 #ROVER$16(rover-right-10)

N $C6A8 Right frame 11.
  $C6A8,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C6A9,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6AA,$D8,$08 #ROVER$17(rover-right-11)

N $C782 Left frame 1.
  $C782,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C783,$01 Height = #N(#PEEK(#PC)) pixels.
  $C784,$BD,$07 #ROVER$03(rover-left-04*)

N $C841 Left frame 2.
  $C841,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C842,$01 Height = #N(#PEEK(#PC)) pixels.
  $C843,$BD,$07 #ROVER$02(rover-left-03*)

N $C900 Left frame 3.
  $C900,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C901,$01 Height = #N(#PEEK(#PC)) pixels.
  $C902,$BD,$07 #ROVER$01(rover-left-02*)

N $C9BF Left frame 4.
  $C9BF,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C9C0,$01 Height = #N(#PEEK(#PC)) pixels.
  $C9C1,$BD,$07 #ROVER$00(rover-left-01*)

N $CA7E Left frame 5.
  $CA7E,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CA7F,$01 Height = #N(#PEEK(#PC)) pixels.
  $CA80,$D8,$08 #ROVER$09(rover-left-05)

N $CB58 Left frame 6.
  $CB58,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CB59,$01 Height = #N(#PEEK(#PC)) pixels.
  $CB5A,$D8,$08 #ROVER$0A(rover-left-06)

N $CC32 Left frame 7.
  $CC32,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CC33,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC34,$D8,$08 #ROVER$0B(rover-left-07)

N $CD0C Left frame 8.
  $CD0C,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CD0D,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD0E,$D8,$08 #ROVER$0D(rover-left-08)

N $CDE6 Left frame 9.
  $CDE6,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CDE7,$01 Height = #N(#PEEK(#PC)) pixels.
  $CDE8,$D8,$08 #ROVER$0D(rover-left-09)

N $CEC0 Left frame 10.
  $CEC0,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CEC1,$01 Height = #N(#PEEK(#PC)) pixels.
  $CEC2,$D8,$08 #ROVER$0E(rover-left-10)

N $CF9A Left frame 11.
  $CF9A,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CF9B,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF9C,$D8,$08 #ROVER$0F(rover-left-11)

b $D074 Sprite: Teleporter
E $D074 #UDGTABLE(default) { #UDGARRAY*teleporter-01,15;teleporter-02;teleporter-03;teleporter-04(teleporter) } UDGTABLE#
N $D074 Frame 1.
  $D074,$01 Height = #N(#PEEK(#PC)) pixels.
  $D075,$36,$02 #SPRITE$29(teleporter-01*)

N $D0AB Frame 2.
  $D0AB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D0AC,$36,$02 #SPRITE$2A(teleporter-02*)

N $D0E2 Frame 3.
  $D0E2,$01 Height = #N(#PEEK(#PC)) pixels.
  $D0E3,$36,$02 #SPRITE$2B(teleporter-03*)

N $D119 Frame 4.
  $D119,$01 Height = #N(#PEEK(#PC)) pixels.
  $D11A,$36,$02 #SPRITE$2C(teleporter-04*)

b $D150
b $D151 The UDG for the lives icon
@ $D151 label=UDG_Life
  $D151,$08,b$01 #UDGTABLE(default,centre) { #UDG#(#PC),attr=$07 } UDGTABLE#

b $D159

b $D160

b $D167 Sprite: Turret
N $D167 Left frame 1.
  $D167,$01 Height = #N(#PEEK(#PC)) pixels.
  $D168,$16,$02 #SPRITE$2F(turret-left-01)

N $D17E Left frame 2.
  $D17E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D17F,$16,$02 #SPRITE$30(turret-left-02)

N $D195 Left frame 3.
  $D195,$01 Height = #N(#PEEK(#PC)) pixels.
  $D196,$18,$02 #SPRITE$31(turret-left-03)

N $D1AE Left frame 4.
  $D1AE,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1AF,$1C,$02 #SPRITE$32(turret-left-04)

N $D1CB Left frame 5.
  $D1CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1CC,$1E,$02 #SPRITE$33(turret-left-05)

N $D1EA Left frame 6.
  $D1EA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1EB,$22,$02 #SPRITE$34(turret-left-06)

N $D20D Left frame 7.
  $D20D,$01 Height = #N(#PEEK(#PC)) pixels.
  $D20E,$24,$02 #SPRITE$35(turret-left-07)

N $D232 Left frame 8.
  $D232,$01 Height = #N(#PEEK(#PC)) pixels.
  $D233,$24,$02 #SPRITE$36(turret-left-08)

N $D257 Right frame 1.
  $D257,$01 Height = #N(#PEEK(#PC)) pixels.
  $D258,$16,$02 #SPRITE$37(turret-right-01)

N $D26E Right frame 2.
  $D26E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D26F,$16,$02 #SPRITE$38(turret-right-02)

N $D285 Right frame 3.
  $D285,$01 Height = #N(#PEEK(#PC)) pixels.
  $D286,$18,$02 #SPRITE$39(turret-right-03)

N $D29E Right frame 4.
  $D29E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D29F,$1C,$02 #SPRITE$3A(turret-right-04)

N $D2BB Right frame 5.
  $D2BB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2BC,$1E,$02 #SPRITE$3B(turret-right-05)

N $D2DA Right frame 6.
  $D2DA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2DB,$22,$02 #SPRITE$3C(turret-right-06)

N $D2FD Right frame 7.
  $D2FD,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2FE,$24,$02 #SPRITE$3D(turret-right-07)

N $D322 Right frame 8.
  $D322,$01 Height = #N(#PEEK(#PC)) pixels.
  $D323,$24,$02 #SPRITE$3E(turret-right-08)

b $D347 Main Font
@ $D347 label=MainFont
  $D347,$08 #UDG(#PC)
L $D347,$08,$4B

b $D59F Sprite: The Blob
D $D59F The Blob appears from level 4 onwards.
N $D59F Frame 1.
  $D59F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5A0,$20,$02 #SPRITE$47(blob-01*)

N $D5C0 Frame 2.
  $D5C0,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5C1,$20,$02 #SPRITE$48(blob-02*)

N $D5E1 Frame 3.
  $D5E1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5E2,$20,$02 #SPRITE$49(blob-03*)

N $D602 Frame 4.
  $D602,$01 Height = #N(#PEEK(#PC)) pixels.
  $D603,$1C,$02 #SPRITE$4A(blob-04*)

N $D61F Frame 5.
  $D61F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D620,$18,$02 #SPRITE$4B(blob-05*)

N $D638 Frame 6.
  $D638,$01 Height = #N(#PEEK(#PC)) pixels.
  $D639,$1C,$02 #SPRITE$4C(blob-06*)

N $D655 Frame 7.
  $D655,$01 Height = #N(#PEEK(#PC)) pixels.
  $D656,$20,$02 #SPRITE$4D(blob-07*)

N $D676 Frame 8.
  $D676,$01 Height = #N(#PEEK(#PC)) pixels.
  $D677,$20,$02 #SPRITE$4E(blob-08*)

b $D697 Sprite: Meteor
D $D697 Meteors appear from level 1 onwards.
E $D697 #UDGTABLE(default) { #UDGARRAY*meteor-01,15;meteor-02;meteor-03;meteor-04;meteor-05;meteor-06;meteor-07;meteor-08(meteor) } UDGTABLE#
N $D697 Frame 1.
  $D697,$01 Height = #N(#PEEK(#PC)) pixels.
  $D698,$20,$02 #SPRITE$4F(meteor-01*)

N $D6B8 Frame 2.
  $D6B8,$01 Height = #N(#PEEK(#PC)) pixels.
  $D6B9,$20,$02 #SPRITE$50(meteor-02*)

N $D6D9 Frame 3.
  $D6D9,$01 Height = #N(#PEEK(#PC)) pixels.
  $D6DA,$20,$02 #SPRITE$51(meteor-03*)

N $D6FA Frame 4.
  $D6FA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D6FB,$20,$02 #SPRITE$52(meteor-04*)

N $D71B Frame 5.
  $D71B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D71C,$20,$02 #SPRITE$53(meteor-05*)

N $D73C Frame 6.
  $D73C,$01 Height = #N(#PEEK(#PC)) pixels.
  $D73D,$20,$02 #SPRITE$54(meteor-06*)

N $D75D Frame 7.
  $D75D,$01 Height = #N(#PEEK(#PC)) pixels.
  $D75E,$20,$02 #SPRITE$55(meteor-07*)

N $D77E Frame 8.
  $D77E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D77F,$20,$02 #SPRITE$56(meteor-08*)

b $D79F Sprite: Sparkle
D $D79F Sparkles appear from level 3 onwards.
N $D79F Frame 1.
  $D79F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7A0,$12,$02 #SPRITE$5B(sparkle-01*)

N $D7B2 Frame 2.
  $D7B2,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7B3,$18,$02 #SPRITE$5C(sparkle-02*)

N $D7CB Frame 3.
  $D7CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7CC,$20,$02 #SPRITE$5D(sparkle-03*)

N $D7EC Frame 4.
  $D7EC,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7ED,$20,$02 #SPRITE$5E(sparkle-04*)

N $D80D Frame 5.
  $D80D,$01 Height = #N(#PEEK(#PC)) pixels.
  $D80E,$20,$02 #SPRITE$5F(sparkle-05*)

N $D82E Frame 6.
  $D82E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D82F,$20,$02 #SPRITE$60(sparkle-06*)

N $D84F Frame 7.
  $D84F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D850,$20,$02 #SPRITE$61(sparkle-07*)

b $D870
  $D870,$01 Height = #N(#PEEK(#PC)) pixels.
  $D871 #CROP(#PC,$01,$07)(thing57)

b $D876
  $D876,$01 Height = #N(#PEEK(#PC)) pixels.
  $D877 #CROP(#PC,$01,$07)(thing58)

b $D87E
  $D87E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D87F #CROP(#PC,$01,$07)(thing63)

b $D888
  $D888,$01 Height = #N(#PEEK(#PC)) pixels.
  $D889 #CROP(#PC,$01,$07)(thing64)

b $D894 Sprite: Mr Magnetic Brella
D $D894 Mr Magnetic Brella appears from level 6 onwards.
N $D894 Frame 1.
  $D894,$01 Height = #N(#PEEK(#PC)) pixels.
  $D895,$20,$02 #SPRITE$3F(brella-01*)

N $D8B5 Frame 2.
  $D8B5,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8B6,$1E,$02 #SPRITE$40(brella-02*)

N $D8D4 Frame 3.
  $D8D4,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8D5,$1C,$02 #SPRITE$41(brella-03*)

N $D8F1 Frame 4.
  $D8F1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8F2,$1A,$02 #SPRITE$42(brella-04*)

N $D90C Frame 5.
  $D90C,$01 Height = #N(#PEEK(#PC)) pixels.
  $D90D,$18,$02 #SPRITE$43(brella-05*)

N $D925 Frame 6.
  $D925,$01 Height = #N(#PEEK(#PC)) pixels.
  $D926,$16,$02 #SPRITE$44(brella-06*)

N $D93C Frame 7.
  $D93C,$01 Height = #N(#PEEK(#PC)) pixels.
  $D93D,$1A,$02 #SPRITE$45(brella-07*)

N $D957 Frame 8.
  $D957,$01 Height = #N(#PEEK(#PC)) pixels.
  $D958,$1E,$02 #SPRITE$46(brella-08*)

b $D976 Sprite: Platform
  $D976,$01 Height = #N(#PEEK(#PC)) pixels.
  $D977,$10,$02 #SPRITE$2D(platform)

b $D987 Sprite: Missile Launcher
E $D987 #UDGTABLE(default) { #UDGARRAY*missile-launcher-01,15;missile-launcher-02;missile-launcher-03;missile-launcher-04;missile-launcher-05;missile-launcher-06;missile-launcher-07;missile-launcher-08;missile-launcher-09;missile-launcher-10;missile-launcher-11;missile-launcher-12;missile-launcher-13;missile-launcher-14;missile-launcher-15;missile-launcher-16(missile-launcher) } UDGTABLE#
N $D987 Frame 1.
  $D987,$01 Height = #N(#PEEK(#PC)) pixels.
  $D988,$40,$02 #SPRITE$6F(missile-launcher-01*)

N $D9C8 Frame 2.
  $D9C8,$01 Height = #N(#PEEK(#PC)) pixels.
  $D9C9,$40,$02 #SPRITE$70(missile-launcher-02*)

N $DA09 Frame 3.
  $DA09,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA0A,$40,$02 #SPRITE$71(missile-launcher-03*)

N $DA4A Frame 4.
  $DA4A,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA4B,$40,$02 #SPRITE$72(missile-launcher-04*)

N $DA8B Frame 5.
  $DA8B,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA8C,$40,$02 #SPRITE$73(missile-launcher-05*)

N $DACC Frame 6.
  $DACC,$01 Height = #N(#PEEK(#PC)) pixels.
  $DACD,$40,$02 #SPRITE$74(missile-launcher-06*)

N $DB0D Frame 7.
  $DB0D,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB0E,$40,$02 #SPRITE$75(missile-launcher-07*)

N $DB4E Frame 8.
  $DB4E,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB4F,$40,$02 #SPRITE$76(missile-launcher-08*)

N $DB8F Frame 9.
  $DB8F,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB90,$40,$02 #SPRITE$77(missile-launcher-09*)

N $DBD0 Frame 10.
  $DBD0,$01 Height = #N(#PEEK(#PC)) pixels.
  $DBD1,$40,$02 #SPRITE$78(missile-launcher-10*)

N $DC11 Frame 11.
  $DC11,$01 Height = #N(#PEEK(#PC)) pixels.
  $DC12,$40,$02 #SPRITE$79(missile-launcher-11*)

N $DC52 Frame 12.
  $DC52,$01 Height = #N(#PEEK(#PC)) pixels.
  $DC53,$40,$02 #SPRITE$7A(missile-launcher-12*)

N $DC93 Frame 13.
  $DC93,$01 Height = #N(#PEEK(#PC)) pixels.
  $DC94,$40,$02 #SPRITE$7B(missile-launcher-13*)

N $DCD4 Frame 14.
  $DCD4,$01 Height = #N(#PEEK(#PC)) pixels.
  $DCD5,$40,$02 #SPRITE$7C(missile-launcher-14*)

N $DD15 Frame 15.
  $DD15,$01 Height = #N(#PEEK(#PC)) pixels.
  $DD16,$40,$02 #SPRITE$7D(missile-launcher-15*)

N $DD56 Frame 16.
  $DD56,$01 Height = #N(#PEEK(#PC)) pixels.
  $DD57,$40,$02 #SPRITE$7E(missile-launcher-16*)

b $DD97 UDG Graphics
@ $DD97 label=UDG_Tiles
N $DD97 Tile ID: "#N(#EVAL((#PC - $DD97) / $08))".
  $DD97,b$08,$01 #UDG(#PC)
L $DD97,$08,$19

b $DE5F HUD Panel Layout
@ $DE5F label=HUDPanelLayoutData
  $DE5F,$1E #FOR($00,$1D)||n|#UDG($DD97 + #PEEK(#PC + n) * $08)||
L $DE5F,$1E,$03

b $DEB9 HUD Panel Attributes
@ $DEB9 label=HUDPanelAttributes
  $DEB9,$1E #FOR($00,$1D)||n|#UDG($DD97 + #PEEK(n + #PC - $5A) * $08,attr=#PEEK(#PC + n))||
L $DEB9,$1E,$03

b $DF13 Graphic: Alien Base
N $DF13 Frame 1.
  $DF13,$01 Width = #N(#PEEK(#PC)) bytes.
  $DF14,$01 Height = #N(#PEEK(#PC)) pixels.
  $DF15,$40,$04 #GRAPHIC$67(base-01)

N $DF55 Frame 2.
  $DF55,$01 Width = #N(#PEEK(#PC)) bytes.
  $DF56,$01 Height = #N(#PEEK(#PC)) pixels.
  $DF57,$50,$05 #GRAPHIC$68(base-02)

N $DFA7 Frame 3.
  $DFA7,$01 Width = #N(#PEEK(#PC)) bytes.
  $DFA8,$01 Height = #N(#PEEK(#PC)) pixels.
  $DFA9,$50,$05 #GRAPHIC$69(base-03)

N $DFF9 Frame 4.
  $DFF9,$01 Width = #N(#PEEK(#PC)) bytes.
  $DFFA,$01 Height = #N(#PEEK(#PC)) pixels.
  $DFFB,$50,$05 #GRAPHIC$6A(base-04)

N $E04B Frame 5.
  $E04B,$01 Width = #N(#PEEK(#PC)) bytes.
  $E04C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E04D,$50,$05 #GRAPHIC$6B(base-05)

N $E09D Frame 6.
  $E09D,$01 Width = #N(#PEEK(#PC)) bytes.
  $E09E,$01 Height = #N(#PEEK(#PC)) pixels.
  $E09F,$50,$05 #GRAPHIC$6C(base-06)

N $E0EF Frame 7.
  $E0EF,$01 Width = #N(#PEEK(#PC)) bytes.
  $E0F0,$01 Height = #N(#PEEK(#PC)) pixels.
  $E0F1,$50,$05 #GRAPHIC$6D(base-07)

N $E141 Frame 8.
  $E141,$01 Width = #N(#PEEK(#PC)) bytes.
  $E142,$01 Height = #N(#PEEK(#PC)) pixels.
  $E143,$50,$05 #GRAPHIC$6E(base-08)

b $E193 Sprite: Missile
N $E193 Frame Up-Left.
  $E193,$01 Height = #N(#PEEK(#PC)) pixels.
  $E194,$20,$02 #SPRITE$7F(missile-up-left)

N $E1B4 Frame Up-Right.
  $E1B4,$01 Height = #N(#PEEK(#PC)) pixels.
  $E1B5,$20,$02 #SPRITE$83(missile-up-right)

b $E1D5
N $E1D5
  $E1D5,$01 Height = #N(#PEEK(#PC)) pixels.
  $E1D6,$32,$02 #SPRITE$9A(9a)

N $E208
  $E208,$01 Height = #N(#PEEK(#PC)) pixels.
  $E209,$32,$02

b $E23B Sprite: Missile Flame
N $E23B Frame 1.
  $E23B,$01 Height = #N(#PEEK(#PC)) pixels.
  $E23C,$1A,$02 #SPRITE$81(missile-flame-01*)

N $E256 Frame 2.
  $E256,$01 Height = #N(#PEEK(#PC)) pixels.
  $E257,$1A,$02 #SPRITE$82(missile-flame-02*)

N $E271 Frame 3.
  $E271,$01 Height = #N(#PEEK(#PC)) pixels.
  $E272,$1A,$02 #SPRITE$85(missile-flame-03*)

N $E28C Frame 4.
  $E28C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E28D,$1A,$02 #SPRITE$86(missile-flame-04*)

b $E2A7 Sprite: The Block
D $E2A7 The Block appears from level 1 onwards.
N $E2A7 Frame 1.
  $E2A7,$01 Height = #N(#PEEK(#PC)) pixels.
  $E2A8,$20,$02 #SPRITE$87(block-01)

N $E2C8 Frame 2.
  $E2C8,$01 Height = #N(#PEEK(#PC)) pixels.
  $E2C9,$20,$02 #SPRITE$88(block-02)

N $E2E9 Frame 3.
  $E2E9,$01 Height = #N(#PEEK(#PC)) pixels.
  $E2EA,$1C,$02 #SPRITE$89(block-03)

N $E306 Frame 4.
  $E306,$01 Height = #N(#PEEK(#PC)) pixels.
  $E307,$18,$02 #SPRITE$8A(block-04)

N $E31F Frame 5.
  $E31F,$01 Height = #N(#PEEK(#PC)) pixels.
  $E320,$18,$02 #SPRITE$8B(block-05)

N $E338 Frame 6.
  $E338,$01 Height = #N(#PEEK(#PC)) pixels.
  $E339,$18,$02 #SPRITE$8C(block-06)

N $E351 Frame 7.
  $E351,$01 Height = #N(#PEEK(#PC)) pixels.
  $E352,$1C,$02 #SPRITE$8D(block-07)

N $E36E Frame 8.
  $E36E,$01 Height = #N(#PEEK(#PC)) pixels.
  $E36F,$20,$02 #SPRITE$8E(block-08)

b $E38F Sprite: Missile
N $E38F Left frame.
  $E38F,$01 Height = #N(#PEEK(#PC)) pixels.
  $E390,$12,$02 #SPRITE$9F(missile-left)

N $E3A2 Right frame.
  $E3A2,$01 Height = #N(#PEEK(#PC)) pixels.
  $E3A3,$12,$02 #SPRITE$A3(missile-right)

b $E3B5 Sprite: Missile Flame
N $E3B5 Left frame 1.
  $E3B5,$01 Height = #N(#PEEK(#PC)) pixels.
  $E3B6,$14,$02 #SPRITE$A1(missile-flame-left-01)

N $E3CA Left frame 2.
  $E3CA,$01 Height = #N(#PEEK(#PC)) pixels.
  $E3CB,$10,$02 #SPRITE$A2(missile-flame-left-02)

N $E3DB Right frame 1.
  $E3DB,$01 Height = #N(#PEEK(#PC)) pixels.
  $E3DC,$14,$02 #SPRITE$A5(missile-flame-right-01)

N $E3F0 Right frame 2.
  $E3F0,$01 Height = #N(#PEEK(#PC)) pixels.
  $E3F1,$10,$02 #SPRITE$A6(missile-flame-right-02)

b $E401
  $E401,$01 Height = #N(#PEEK(#PC)) pixels.
  $E402,$32,$02 #SPRITE$97(thing97)

N $E434
  $E434,$01 Height = #N(#PEEK(#PC)) pixels.
  $E435,$32,$02 #SPRITE$98(thing98)

N $E467
  $E467,$01 Height = #N(#PEEK(#PC)) pixels.
  $E468,$32,$02 #SPRITE$99(thing99)

b $E49A
  $E49A,$01 Height = #N(#PEEK(#PC)) pixels.
  $E49B,$32,$02 #SPRITE$9B(thing3)

N $E4CD
  $E4CD,$01 Height = #N(#PEEK(#PC)) pixels.
  $E4CE,$32,$02 #SPRITE$9C(thing4)

N $E500
  $E500,$01 Height = #N(#PEEK(#PC)) pixels.
  $E501,$32,$02 #SPRITE$9D(thing5)

b $E533 Sprite: Alien Base Plasma
E $E533 #UDGTABLE(default) { #UDGARRAY*alien-base-plasma-01,5;alien-base-plasma-01;alien-base-plasma-02;alien-base-plasma-03;alien-base-plasma-04;alien-base-plasma-04;alien-base-plasma-03;alien-base-plasma-02(alien-base-plasma) } UDGTABLE#
N $E533 Frame 1.
  $E533,$01 Height = #N(#PEEK(#PC)) pixels.
  $E534,$2A,$02 #SPRITE$90(alien-base-plasma-01*)

N $E55E Frame 2.
  $E55E,$01 Height = #N(#PEEK(#PC)) pixels.
  $E55F,$2A,$02 #SPRITE$91(alien-base-plasma-02*)

N $E589 Frame 3.
  $E589,$01 Height = #N(#PEEK(#PC)) pixels.
  $E58A,$2A,$02 #SPRITE$92(alien-base-plasma-03*)

N $E5B4 Frame 4.
  $E5B4,$01 Height = #N(#PEEK(#PC)) pixels.
  $E5B5,$2A,$02 #SPRITE$93(alien-base-plasma-04*)

b $E5DF
  $E5DF,$01 Height = #N(#PEEK(#PC)) pixels.
  $E5E0,$18,$02 #SPRITE$BF(thing1)

N $E5F8
  $E5F8,$01 Height = #N(#PEEK(#PC)) pixels.
  $E5F9,$20,$02 #SPRITE$C0(thing2)

N $E619
  $E619,$01 Height = #N(#PEEK(#PC)) pixels.
  $E61A,$20,$02 #SPRITE$C1(thingc1)

N $E63A
  $E63A,$01 Height = #N(#PEEK(#PC)) pixels.
  $E63B,$20,$02 #SPRITE$C2(thingc2)

N $E65B
  $E65B,$01 Height = #N(#PEEK(#PC)) pixels.
  $E65C,$20,$02 #SPRITE$C3(thingc3)

N $E67C
  $E67C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E67D,$20,$02 #SPRITE$C4(thingc4)

N $E69D
  $E69D,$01 Height = #N(#PEEK(#PC)) pixels.
  $E69E,$20,$02 #SPRITE$C5(thingc5)

N $E6BE
  $E6BE,$01 Height = #N(#PEEK(#PC)) pixels.
  $E6BF,$20,$02 #SPRITE$C6(thingc6)

N $E6DF
  $E6DF,$01 Height = #N(#PEEK(#PC)) pixels.
  $E6E0,$08,$02 #SPRITE$C7(thingc7)

b $E6E8
  $E6E8,$01 Height = #N(#PEEK(#PC)) pixels.
  $E6E9,$08,$02 #SPRITE$C8(thingc8)

b $E6F1

b $E6FA

b $E703 Sprite: Saturn
D $E703 Saturn appears from level 10 onwards.
E $E703 #UDGTABLE(default) { #UDGARRAY*saturn-01,15;saturn-02;saturn-03;saturn-04;saturn-05;saturn-06;saturn-07;saturn-02;saturn-01;saturn-08;saturn-09;saturn-10;saturn-11;saturn-12;saturn-13;saturn-08(saturn) } UDGTABLE#
N $E703 Frame 1.
  $E703,$01 Height = #N(#PEEK(#PC)) pixels.
  $E704,$18,$02 #SPRITE$CB(saturn-01*)

N $E71C Frame 2.
  $E71C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E71D,$18,$02 #SPRITE$CC(saturn-02*)

N $E735 Frame 3.
  $E735,$01 Height = #N(#PEEK(#PC)) pixels.
  $E736,$18,$02 #SPRITE$CD(saturn-03*)

N $E74E Frame 4.
  $E74E,$01 Height = #N(#PEEK(#PC)) pixels.
  $E74F,$18,$02 #SPRITE$CE(saturn-04*)

N $E767 Frame 5.
  $E767,$01 Height = #N(#PEEK(#PC)) pixels.
  $E768,$18,$02 #SPRITE$CF(saturn-05*)

N $E780 Frame 6.
  $E780,$01 Height = #N(#PEEK(#PC)) pixels.
  $E781,$18,$02 #SPRITE$D0(saturn-06*)

N $E799 Frame 7.
  $E799,$01 Height = #N(#PEEK(#PC)) pixels.
  $E79A,$18,$02 #SPRITE$D1(saturn-07*)

N $E7B2 Frame 8.
  $E7B2,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7B3,$18,$02 #SPRITE$D4(saturn-08*)

N $E7CB Frame 9.
  $E7CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7CC,$18,$02 #SPRITE$D5(saturn-09*)

N $E7E4 Frame 10.
  $E7E4,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7E5,$18,$02 #SPRITE$D6(saturn-10*)

N $E7FD Frame 11.
  $E7FD,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7FE,$18,$02 #SPRITE$D7(saturn-11*)

N $E816 Frame 12.
  $E816,$01 Height = #N(#PEEK(#PC)) pixels.
  $E817,$18,$02 #SPRITE$D8(saturn-12*)

N $E82F Frame 13.
  $E82F,$01 Height = #N(#PEEK(#PC)) pixels.
  $E830,$18,$02 #SPRITE$D9(saturn-13*)

b $E848 Sprite: Spinner
D $E848 Spinner appears from level 2 onwards.
N $E848 Frame 1.
  $E848,$01 Height = #N(#PEEK(#PC)) pixels.
  $E849,$26,$02 #SPRITE$AF(spinner-01)

N $E86F Frame 2.
  $E86F,$01 Height = #N(#PEEK(#PC)) pixels.
  $E870,$26,$02 #SPRITE$B0(spinner-02)

N $E896 Frame 3.
  $E896,$01 Height = #N(#PEEK(#PC)) pixels.
  $E897,$24,$02 #SPRITE$B1(spinner-03)

N $E8BB Frame 4.
  $E8BB,$01 Height = #N(#PEEK(#PC)) pixels.
  $E8BC,$1E,$02 #SPRITE$B2(spinner-04)

N $E8DA Frame 5.
  $E8DA,$01 Height = #N(#PEEK(#PC)) pixels.
  $E8DB,$16,$02 #SPRITE$B3(spinner-05)

N $E8F1 Frame 6.
  $E8F1,$01 Height = #N(#PEEK(#PC)) pixels.
  $E8F2,$1E,$02 #SPRITE$B4(spinner-06)

b $E910 Sprite: Jetman Falling
E $E910 #UDGTABLE(default) { #UDGARRAY*jetman-falling-01,15;jetman-falling-02;jetman-falling-03;jetman-falling-04(jetman-falling) } UDGTABLE#
N $E910 Frame 1.
  $E910,$01 Height = #N(#PEEK(#PC)) pixels.
  $E911,$22,$02 #SPRITE$DB(jetman-falling-01*)

N $E933 Frame 2.
  $E933,$01 Height = #N(#PEEK(#PC)) pixels.
  $E934,$22,$02 #SPRITE$DC(jetman-falling-02*)

N $E956 Frame 3.
  $E956,$01 Height = #N(#PEEK(#PC)) pixels.
  $E957,$22,$02 #SPRITE$DD(jetman-falling-03*)

N $E979 Frame 4.
  $E979,$01 Height = #N(#PEEK(#PC)) pixels.
  $E97A,$22,$02 #SPRITE$DE(jetman-falling-04*)

b $E99C Sprite: Shooter
E $E99C #UDGTABLE(default) { #UDGARRAY*shooter-01,15;shooter-02;shooter-03;shooter-04;shooter-05;shooter-06;shooter-07(shooter) } UDGTABLE#
D $E99C Shooters appear from level 8 onwards.
N $E99C Frame 1.
  $E99C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E99D,$20,$02 #SPRITE$B7(shooter-01*)

N $E9BD Frame 2.
  $E9BD,$01 Height = #N(#PEEK(#PC)) pixels.
  $E9BE,$20,$02 #SPRITE$B8(shooter-02*)

N $E9DE Frame 3.
  $E9DE,$01 Height = #N(#PEEK(#PC)) pixels.
  $E9DF,$20,$02 #SPRITE$B9(shooter-03*)

N $E9FF Frame 4.
  $E9FF,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA00,$20,$02 #SPRITE$BA(shooter-04*)

N $EA20 Frame 5.
  $EA20,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA21,$20,$02 #SPRITE$BB(shooter-05*)

N $EA41 Frame 6.
  $EA41,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA42,$20,$02 #SPRITE$BC(shooter-06*)

N $EA62 Frame 7.
  $EA62,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA63,$20,$02 #SPRITE$BD(shooter-07*)

b $EA83
  $EA83,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA84,$04,$01

b $EA88
  $EA88,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA89,$04,$01

b $EA8D Graphic: Explosion
N $EA8D Frame 1.
  $EA8D,$01 Width = #N(#PEEK(#PC)) bytes.
  $EA8E,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA8F,$1C,$02 #GRAPHIC$DF(explosion-01)

N $EAAB Frame 2.
  $EAAB,$01 Width = #N(#PEEK(#PC)) bytes.
  $EAAC,$01 Height = #N(#PEEK(#PC)) pixels.
  $EAAD,$40,$04 #GRAPHIC$E0(explosion-02)

N $EAED Frame 3.
  $EAED,$01 Width = #N(#PEEK(#PC)) bytes.
  $EAEE,$01 Height = #N(#PEEK(#PC)) pixels.
  $EAEF,$78,$05 #GRAPHIC$E1(explosion-03)

N $EB67 Frame 4.
  $EB67,$01 Width = #N(#PEEK(#PC)) bytes.
  $EB68,$01 Height = #N(#PEEK(#PC)) pixels.
  $EB69,$E0,$07 #GRAPHIC$E2(explosion-04)

N $EC49 Frame 5.
  $EC49,$01 Height = #N(#PEEK(#PC)) pixels.
  $EC4A,$20,$02 #SPRITE$E3(explosion-05)

N $EC6A Frame 6.
  $EC6A,$01 Height = #N(#PEEK(#PC)) pixels.
  $EC6B,$20,$02 #SPRITE$E4(explosion-06)

N $EC8B Frame 7.
  $EC8B,$01 Height = #N(#PEEK(#PC)) pixels.
  $EC8C,$20,$02 #SPRITE$E5(explosion-07)

N $ECAC Frame 8.
  $ECAC,$01 Height = #N(#PEEK(#PC)) pixels.
  $ECAD,$20,$02 #SPRITE$E6(explosion-08)

N $ECCD Frame 9.
  $ECCD,$01 Height = #N(#PEEK(#PC)) pixels.
  $ECCE,$20,$02 #SPRITE$E7(explosion-09)

N $ECEE Frame 10.
  $ECEE,$01 Height = #N(#PEEK(#PC)) pixels.
  $ECEF,$20,$02 #SPRITE$E8(explosion-10)

N $ED0F Frame 11.
  $ED0F,$01 Height = #N(#PEEK(#PC)) pixels.
  $ED10,$20,$02 #SPRITE$E9(explosion-11)

N $ED30 Frame 12.
  $ED30,$01 Height = #N(#PEEK(#PC)) pixels.
  $ED31,$20,$02 #SPRITE$EA(explosion-12)

b $ED51 Sprite: Bouncing Wheel
E $ED51 #UDGTABLE(default) { #UDGARRAY*bouncing-wheel-01,5;bouncing-wheel-02;bouncing-wheel-03;bouncing-wheel-04;bouncing-wheel-05;bouncing-wheel-06(bouncing-wheel) } UDGTABLE#
D $ED51 Bouncing Wheels appear from level 1 onwards.
N $ED51 Frame 1.
  $ED51,$01 Height = #N(#PEEK(#PC)) pixels.
  $ED52,$20,$02 #SPRITE$A7(bouncing-wheel-01*)

N $ED72 Frame 2.
  $ED72,$01 Height = #N(#PEEK(#PC)) pixels.
  $ED73,$20,$02 #SPRITE$A8(bouncing-wheel-02*)

N $ED93 Frame 3.
  $ED93,$01 Height = #N(#PEEK(#PC)) pixels.
  $ED94,$20,$02 #SPRITE$A9(bouncing-wheel-03*)

N $EDB4 Frame 4.
  $EDB4,$01 Height = #N(#PEEK(#PC)) pixels.
  $EDB5,$20,$02 #SPRITE$AA(bouncing-wheel-04*)

N $EDD5 Frame 5.
  $EDD5,$01 Height = #N(#PEEK(#PC)) pixels.
  $EDD6,$20,$02 #SPRITE$AB(bouncing-wheel-05*)

N $EDF6 Frame 6.
  $EDF6,$01 Height = #N(#PEEK(#PC)) pixels.
  $EDF7,$20,$02 #SPRITE$AC(bouncing-wheel-06*)

b $EE17 Sprite: Bomb
E $EE17 #UDGTABLE(default) { #UDGARRAY*bomb-01,25;bomb-02;bomb-03;bomb-02(bomb) } UDGTABLE#
N $EE17 Frame 1.
  $EE17,$01 Height = #N(#PEEK(#PC)) pixels.
  $EE18,$20,$02 #SPRITE$EB(bomb-01*)

N $EE38 Frame 2.
  $EE38,$01 Height = #N(#PEEK(#PC)) pixels.
  $EE39,$20,$02 #SPRITE$EC(bomb-02*)

N $EE59 Frame 3.
  $EE59,$01 Height = #N(#PEEK(#PC)) pixels.
  $EE5A,$20,$02 #SPRITE$ED(bomb-03*)

b $EE7A

c $F232 New High Score Suffix
@ $F232 label=NewHighScore_Suffix
  $F232,$07 If #R$5E77 is zero, jump to #R$F26B.
N $F239 #N$00 is the "Top Score" so we +#N$01 to make it human readable.
  $F239,$02 #REGa=#REGa+#N$31 (convert to ASCII + #N$01).
  $F23B,$03 #REGhl=#N$5007 (screen buffer location).
  $F23E,$01 Stash the ASCII highscore position on the stack.
  $F23F,$03 Call #R$89EF.
  $F242,$01 #REGa=the ASCII highscore position from the stack.
  $F243,$02 #REGa=#REGa-#N$31.
  $F245,$03 #REGhl=#N$8048 (screen location).
N $F248 Remember that #N$00 is the "Top Score" so #N$01 is 2nd place.
  $F248,$05 If the highscore position is #N$01 jump to #R$F261.
N $F24D And #N$02 is 3rd...
  $F24D,$05 If the highscore position is #N$02 jump to #R$F266.
N $F252 Anything higher will use the "TH" suffix messaging.
@ $F252 label=NewHighScore_Suffix_TH
  $F252,$03 #REGde=#R$F274.
@ $F255 label=NewHighScore_Suffix_Print
  $F255,$03 Call #R$8A11.
N $F258 Handle displaying "HIGHEST SCORE" messaging.
@ $F258 label=NewHighScore_Suffix_Highest
  $F258,$03 #REGhl=#N$8060 (screen location).
  $F25B,$03 #REGde=#R$F287.
  $F25E,$03 Jump to #R$8A11.
N $F261 Handle displaying the "ND" suffix messaging.
@ $F261 label=NewHighScore_Suffix_ND
  $F261,$03 #REGde=#R$F281.
  $F264,$02 Jump to #R$F255.
N $F266 Handle displaying the "RD" suffix messaging.
@ $F266 label=NewHighScore_Suffix_RD
  $F266,$03 #REGde=#R$F284.
  $F269,$02 Jump to #R$F255.
N $F26B Handle displaying "TOP SCORE" messaging.
@ $F26B label=NewHighScore_Suffix_Top_Score
  $F26B,$03 #REGhl=#N$8058 (screen location).
  $F26E,$03 #REGde=#R$F277.
  $F271,$03 Jump to #R$8A11.

t $F274 Messaging: High Score Suffixes
N $F274 #FONT:(TH)addr=$D347,attr=$46(th)
@ $F274 label=HighScore_Suffixes_TH
  $F274,$03,h$01,$01:$01 Attribute: #N(#PEEK(#PC)) + "TH".
N $F277 #FONT:(TOP SCORE)addr=$D347,attr=$46(top-score)
@ $F277 label=HighScore_Top_Score
  $F277,$0A,h$01,$08:$01 Attribute: #N(#PEEK(#PC)) + "TOP SCORE".
N $F281 #FONT:(ND)addr=$D347,attr=$46(nd)
@ $F281 label=HighScore_Suffixes_ND
  $F281,$03,h$01,$01:$01 Attribute: #N(#PEEK(#PC)) + "ND".
N $F284 #FONT:(RD)addr=$D347,attr=$46(rd)
@ $F284 label=HighScore_Suffixes_RD
  $F284,$03,h$01,$01:$01 Attribute: #N(#PEEK(#PC)) + "RD".
N $F287 #FONT:(HIGHEST SCORE)addr=$D347,attr=$46(highest-score)
@ $F287 label=HighScore_Highest_Score
  $F287,$0E,h$01,$0C:$01 Attribute: #N(#PEEK(#PC)) + "HIGHEST SCORE".

c $F295

c $F33E
  $F33E,$04 Write #N$00 to #R$5E73.
  $F342,$03 Jump to #R$802C.

c $F345
  $F345,$03 #REGde=#R$5E38.
  $F348,$03 #REGhl=#R$5E35.

  $F35B,$03 #REGhl=#R$5E78.
  $F35E,$03 #REGbc=#N($0003,$04,$04).

  $F36D,$03 #REGde=#R$5E62.
  $F370,$02 Jump to #R$F375.
  $F372,$03 #REGde=#R$5E5F.
  $F375,$03 Call #R$F3BF.

  $F38B,$03 #REGde=#R$5E5F.

  $F399,$03 Call #R$F535.
  $F39C,$03 Jump to #R$F5E3.

  $F3A6,$03 #REGde=#R$5E62.

  $F3B4,$05 Write #N$01 to #R$5E65.
  $F3B9,$03 Call #R$F535.
  $F3BC,$03 Jump to #R$F5E3.

c $F3BF
  $F40F,$01 Return.

c $F410 Hall Of Fame
@ $F410 label=HallOfFame
  $F410,$02 #REGa=#N$47.
  $F412,$02 #REGc=#N$08.
  $F414,$03 #REGhl=#N$5900.
  $F417,$02 #REGb=#N$40.
  $F422,$02 #REGa=#N$44.
N $F427 Handle printing "THE ULTIMATE" messaging.
  $F427,$03 #REGhl=#N$1850 (screen location).
  $F42A,$03 #REGde=#R$F4AA.
  $F42D,$03 Call #R$8A11.
N $F430 Handle printing "HALL OF FAME" messaging.
  $F430,$03 #REGhl=#N$2850 (screen location).
  $F433,$03 #REGde=#R$F4B8.
  $F436,$03 Call #R$8A11.
  $F439,$03 #REGhl=#N$4048 (screen buffer location).
@ $F441 label=
  $F451,$03 #REGhl=#N$4060 (screen buffer location).
  $F454,$03 #REGde=#R$5E20.
  $F457,$02 #REGc=#N$08.
  $F45D,$02 #REGb=#N$03.
  $F46E,$02 #REGc=#N$08.
  $F470,$03 #REGde=#R$5E06.
  $F473,$03 #REGhl=#N$4088.
  $F476,$02 #REGb=#N$03.
  $F478,$01 Stash #REGhl on the stack.
  $F479,$03 Call #R$851E.
  $F47C,$03 Call #R$89D7.
  $F47F,$01 Restore #REGhl from the stack.
  $F480,$04 #REGh=#REGh+#N$10.
  $F484,$01 Decrease #REGc by one.
  $F485,$02 Jump back to #R$F476 until #REGc is zero.
  $F487,$05 Write #N$01 to #R$5E74.
  $F48C,$06 Write #N$0400 to #R$5E6D.
  $F492,$01 Enable interrupts.
  $F493,$01
  $F49B,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$E7 | Q | W | E | R | T | Y | U | I | O | P }
. TABLE#
  $F4A1,$01 Flip the bits.
  $F4A2,$02,b$01 Keep only bits 0-4.
  $F4A9,$01 Return.

t $F4AA Messaging: Hall Of Fame
N $F4AA #FONT:(THE ULTIMATE)addr=$D347,attr=$45(ultimate)
@ $F4AA label=String_Ultimate
  $F4AA,$0E,h$01,$0C:$01 Attribute: #N(#PEEK(#PC)) + "THE ULTIMATE ".
N $F4B8 #FONT:(HALL OF FAME)addr=$D347,attr=$45(hall-of-fame)
@ $F4B8 label=String_HallOfFame
  $F4B8,$0E,h$01,$0C:$01 Attribute: #N(#PEEK(#PC)) + "HALL OF FAME ".

c $F4C6 Handler: High Score Messaging
@ $F4C6 label=HighScoreMessaging
N $F4C6 Handle printing "CONGRATULATIONS PLAYER ..." messaging.
  $F4C6,$03 #REGde=#R$F4FB.
  $F4C9,$03 #REGhl=#N$6020 (screen location).
  $F4CC,$03 Call #R$8A11.
N $F4CF Handle printing the player "number".
  $F4CF,$05 #REGa=#R$5E71 + #N$30 (convert to ASCII).
  $F4D4,$03 #REGhl=#N$489B (screen buffer location).
  $F4D7,$03 Call #R$89EF.
N $F4DA Handle printing "TODAYS" messaging.
  $F4DA,$03 #REGde=#R$F513.
  $F4DD,$03 #REGhl=#N$7068 (screen location).
  $F4E0,$03 Call #R$8A11.
  $F4E3,$03 Call #R$F232.
N $F4E6 Handle printing "JETMAN WILL REMEMBER YOU" messaging.
  $F4E6,$03 #REGde=#R$F51B.
  $F4E9,$03 #REGhl=#N$9020 (screen location).
  $F4EC,$03 Call #R$8A11.
  $F4EF,$03 #REGhl=#N$53AD (attribute buffer location).
  $F4F2,$02 #REGb=#N$03 (counter).
@ $F4F4 label=HighScoreMessaging_Loop
  $F4F4,$02 Write #N$7E to #REGhl.
  $F4F6,$02 Increment #REGl by two.
  $F4F8,$02 Decrease counter by one and loop back to #R$F4F4 until counter is zero.
  $F4FA,$01 Return.

t $F4FB Messaging: High Score
N $F4FB #FONT:(CONGRATULATIONS PLAYER X)addr=$D347,attr=$47(congratulations)
@ $F4FB label=String_Congratulations
  $F4FB,$18,h$01,$16:$01 Attribute: #N(#PEEK(#PC)) + "CONGRATULATIONS PLAYER ".
N $F513 #FONT:(TODAYS)addr=$D347,attr=$47(todays)
@ $F513 label=String_Todays
  $F513,$08,h$01,$06:$01 Attribute: #N(#PEEK(#PC)) + "TODAYS ".
N $F51B #FONT:(JETMAN WILL REMEMBER YOU)addr=$D347,attr=$47(remember)
@ $F51B label=String_Remember
  $F51B,$1A,h$01,$18:$01 Attribute: #N(#PEEK(#PC)) + "JETMAN WILL REMEMBER YOU ".

c $F535
  $F535,$01 #REGa=#REGb.
  $F53D,$03 Call #R$84D8.
  $F540,$03 #REGhl=#N$5900.
  $F543,$02 #REGc=#N$02.
  $F545,$02 #REGa=#N$46.
  $F547,$02 #REGb=#N$00 (counter).
  $F549,$01 Write #REGa to #REGhl.
  $F54A,$01 Increment #REGhl by one.
  $F54B,$02 Decrease counter by one and loop back to #R$F549 until counter is zero.
  $F54D,$01 Decrease #REGc by one.
  $F54E,$02 Jump back to #R$F547 until #REGc is zero.
  $F550,$03 Call #R$F4C6.
  $F553,$06 Write #N($1000,$04,$04) to #R$5E6D.
  $F559,$06 Write #N$50AD to #R$5E75.
  $F55F,$04 Write #N$00 to #R$5E6F.
  $F563,$03 #REGhl=#R$5E78.
  $F566,$02 #REGb=#N$03 (counter).
  $F568,$02 Write #N$41 to #REGhl.
  $F56A,$01 Increment #REGhl by one.
  $F56B,$02 Decrease counter by one and loop back to #R$F568 until counter is zero.
  $F56D,$01 Return.

c $F56E Handler: New High Score
@ $F56E label=NewHighScore
  $F56E,$03 #REGde=#R$5E5F.
  $F571,$03 #REGhl=#R$5E62.
  $F57B,$02 Jump to #R$F58F.

c $F5E3
  $F5E3,$02 #REGb=#N$00.
  $F5E5,$02
  $F5E7,$01 Enable interrupts.
  $F5E8,$01
  $F5E9,$03 Jump to #R$F295.

c $F5EC Print 1UP/ 2UP Levels
@ $F5EC label=PrintPlayerLevels
N $F5EC Sets attributes for 1UP level.
  $F5EC,$03 #REGhl=#N$0848.
  $F5EF,$03 Call #R$F662.
N $F5F2 Sets attributes for 2UP level.
  $F5F2,$03 #REGhl=#N$08A0.
  $F5F5,$03 Call #R$F662.
N $F5F8 Is this a 1 or 2 player game?
  $F5F8,$06 If #R$5E65 is not zero, jump to #R$F609.
N $F5FE Handler for printing 1UP level followed by 2UP level.
  $F5FE,$03 #REGhl=#N$0848.
  $F601,$03 Call #R$F612.
  $F604,$03 #REGhl=#N$08A0.
  $F607,$02 Jump to #R$F628.
N $F609 Handler for printing 2UP level followed by 1UP level.
@ $F609 label=Handler_PrintPlayerLevels
  $F609,$03 #REGhl=#N$0848.
  $F60C,$03 Call #R$F628.
N $F60F Handles the 2UP level.
  $F60F,$03 #REGhl=#N$08A0.
N $F612 Handles displaying "#FONT:(L)addr=$D347,attr=$47(level)" for 1UP.
@ $F612 label=Print1UPLevel
  $F612,$02 #REGa=#N$4C.
  $F614,$03 Call #R$F632.
  $F617,$03 Call #R$F641.
N $F61A Prints the first digit (held in #REGa from #REGb).
@ $F61A label=PrintLevel
  $F61A,$01 Stash #REGbc on the stack.
  $F61B,$02 Add #N$30 to convert to an ASCII character (starting at "0" character).
  $F61D,$03 Call #R$F632.
  $F620,$01 Restore #REGbc from the stack.
N $F621 Now move onto the second digit held in #REGc.
  $F621,$01 #REGa=#REGc.
  $F622,$02 Add #N$30 to convert to an ASCII character (starting at "0" character).
  $F624,$03 Call #R$F632.
  $F627,$01 Return.
N $F628 Handles displaying "#FONT:(L)addr=$D347,attr=$47(level)" for 2UP.
@ $F628 label=Print2UPLevel
  $F628,$02 #REGa=#N$4C.
  $F62A,$03 Call #R$F632.
  $F62D,$03 Call #R$F658.
  $F630,$02 Jump to #R$F61A.
N $F632 Keep #REGhl (pixel co-ordinates) and #REGaf (the ASCII character to print) for later.
@ $F632 label=PrintLevelMessaging
  $F632,$02 Stash #REGhl and #REGaf on the stack.
  $F634,$03 Call #R$851E.
N $F637 Fetch the ASCII character we want to print from the stack.
  $F637,$01 Restore #REGaf from the stack.
  $F638,$03 Call #R$89EF.
N $F63B Restore the pixel co-ordinates from the stack, and move onto the next character column.
  $F63B,$01 Restore #REGhl from the stack.
  $F63C,$04 #REGl=#REGl+#N$08.
  $F640,$01 Return.

c $F641 Active Player Level
@ $F641 label=Calculate_ActivePlayer_Level
R $F641 BC Player level as two digits
  $F641,$07 If #R$5EA0 is not #N$FF, jump to #R$F649.
  $F648,$01 #REGa=#N$00.
N $F649 This reads #REGa into #REGbc as two nibbles, e.g. level 21 would be #EVAL($15,$02,$08) which returns #N$2101.
@ $F649 label=Calculate_Player_Level
  $F649,$03 Call #R$B699.
  $F64C,$01 #REGb=#REGa.
  $F64D,$02,b$01 Keep only bits 0-3.
  $F64F,$01 #REGc=#REGa.
  $F650,$01 #REGa=#REGb.
  $F651,$04 Rotate the bits of #REGa right four times.
  $F655,$02,b$01 Keep only bits 0-3.
  $F657,$01 Return.
@ $F658 label=Calculate_InactivePlayer_Level
  $F658,$07 If #R$5EA4 is not #N$FF, jump to #R$F649.
  $F65F,$01 #REGa=#N$00.
  $F660,$02 Jump to #R$F649.

c $F662 Helper: Colour Levels Messaging Green
@ $F662 label=ColourLevelsGreen
R $F662 HL Pixel address co-ordinates
  $F662,$03 Call #R$8506.
  $F665,$02 #REGb=#N$03.
  $F667,$03 Write #N$44 (#COLOUR$44 attribute byte) to #REGhl.
@ $F669 label=ColourLevelsGreen_Loop
  $F66A,$01 Increment #REGhl by one.
  $F66B,$02 Decrease counter by one and loop back to #R$F669 until counter is zero.
  $F66D,$01 Return.

b $F66E Terrain UDGs
@ $F66E label=TerrainUDGs
  $F66E,$08 #UDG(#PC,attr=$43)
L $F66E,$08,$0C

b $F6CE Default Terrain Data
@ $F6CE label=TerrainData_Default
  $F6CE,$10 #FOR($00,$0F)||n|#UDG($F66E + #PEEK(#PC + n) * $08,attr=$43)||
L $F6CE,$10,$40

b $FACE

i $FC00

b $FF44
  $FF44,$10,$01

w $FF54
  $FF54,$02

i $FF56
