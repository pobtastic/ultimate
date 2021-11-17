> $4000 @org=$4000
> $4000 @start=$5B80
b $4000 Loading screen
D $4000 #UDGTABLE { #SCR(loading) | Lunar Jetman Loading Screen. } TABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$300,$20 Attributes

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

g $5E50

g $5E52

g $5E53

g $5E5D
g $5E5E

g $5E5F 1UP Score
D $5E5F 3-byte representation of the score.
@ $5E5F label=1UP_Score
B $5E5F,$03

g $5E62 2UP Score
D $5E62 3-byte representation of the score.
@ $5E62 label=2UP_Score
B $5E62,$03

g $5E65 Active Player
@ $5E65 label=Flag_ActivePlayer
D $5E65 Which player is currently active.
B $5E65 #TABLE(default,centre,centre) { =h Value | =h Player }
. { $00 | 1UP }
. { $FF | 2UP }
. TABLE#

g $5E66 Current menu item colour attribute
@ $5E66 label=Current_MenuAttr
B $5E66,$01

g $5E68

g $5E71 Number of players?

g $5E7C

g $5EA0 Active Player Fuel
@ $5EA0 label=ActivePlayer_Fuel
B $5EA0,$01

g $5EA1 Active Player Lives
@ $5EA1 label=ActivePlayer_Lives
B $5EA1,$01

g $5EA2
g $5EA3

g $5EA4 Inactive Player Fuel
@ $5EA4 label=InactivePlayer_Fuel
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

c $8000 Security Check
E $8000 Continue on to #R$800A.
E $8000 View the equivalent code in;
. #LIST
. { #ATICATAC$6000 }
. { #COOKIE$5F00 }
. { #JETPAC$61E5 }
. { #PSSST$61C6 }
. { #TRANZAM$5F00 }
. LIST#
@ $8000 label=SecurityCheck
  $8000,$01 Disable interrupts.
  $8001,$03 Set the stack pointer to #N$5E00.
  $8004,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $8007,$03 Return if #REGa is not #N$25.

c $800A Game Initialisation
E $800A View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #COOKIE$6298 }
. { #LUNARJETMAN$800A }
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

  $80C9,$01 Return.

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
  $80E8,$03 #REGh'=#REGa #REGl'=#N$58.
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
  $8100,$01
  $8102,$02,b$01 Keep only bit 1.
  $8104,$03 Create an offset in #REGhl.
  $8107,$01 #REGhl=#R$BAA4 + offset.
  $8108,$03 #REGde=
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

t $811C Game Selection Title text
E $811C View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #COOKIE$636C }
. { #JETPAC$6299 }
. { #PSSST$6288 }
. { #TRANZAM$5FB1 }
. LIST#
@ $811C label=GameSelection_Title
E $811C View the equivalent code in #ATICATAC$7CF8.
  $811C,$0E,$0D:$01 "GAME SELECTION".
  $812A,$10,$0F:$01 "1  1 PLAYER GAME".
  $813A,$10,$0F:$01 "2  2 PLAYER GAME".
  $814A,$0B,$0A:$01 "3  KEYBOARD".
  $8155,$14,$13:$01 "4  KEMPSTON JOYSTICK".
  $8169,$14,$13:$01 "5  CURSOR   JOYSTICK".
  $817D,$0D,$0C:$01 "6  START GAME".

t $818A Copyright Messaging
@ $818A label=Message_Copyright
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
  $822C,$03 Jump to #R$81E9.

c $822F

c $824A

w $82C5

c $84AD Reset Screen Buffer
E $84AD View the equivalent code in;
. #LIST
. { #ATICATAC$80B4 }
. { #COOKIE$74D4 }
. { #JETPAC$71B8 }
. { #PSSST$7439 }
. { #TRANZAM$7211 }
. LIST#
@ $84AD label=ResetScreen
E $84AD Continue on to #R$84B4 to blank the screen buffer.
E $84AD View the equivalent code in #ATICATAC$80B4.
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
N $84EB Write the 1UP, 2UP and HI scores.
  $84EB,$03 Call #R$F5EC.
  $84EE,$03 Call #R$89BF.
  $84F1,$03 Call #R$89C7.
  $84F4,$03 Jump to #R$89CF.

c $84F7 Reset Planet
@ $84F7 label=ResetPlanet
  $84F7,$03 #REGhl=#N$6000.
  $84FA,$03 #REGbc=#N$0480 (counter).
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
  $8508,$03 Divide by #N08.
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

c $864F

c $865E

c $867F

c $86A1

c $8701

c $8733

c $877C

c $8787

c $8807

c $8826

c $8891

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

c $899C

c $89BF Print Scores
E $89BF View the equivalent code in;
. #LIST
. { #COOKIE$7438 }
. { #JETPAC$711C }
. { #PSSST$739D }
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
. { =h Letter | =h ASCII Value | =h - #N$20 * #N08 (offset) | =h CHARS + offset }
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
N $8A37 Prints "1UP".
  $8A37,$03 #REGhl=#N($0018, 4, 4).
  $8A3A,$03 #REGde=#R$8A51.
  $8A3D,$03 Call #R$8A11.
N $8A40 Prints "HI".
  $8A40,$03 #REGhl=#N($0078, 4, 4).
  $8A43,$03 #REGde=#R$8A59.
  $8A46,$03 Call #R$8A11.
N $8A49 Prints "2UP".
  $8A49,$03 #REGhl=#N($00D8, 4, 4).
  $8A4C,$03 #REGde=#R$8A55.
  $8A4F,$02 Jump to #R$8A11.
N $8A51 Banner text data.
@ $8A51 label=1UP_Text
T $8A51,$04,h$01,$02:$01 "1UP" (#N(#PEEK(#PC)) is the attribute).
@ $8A55 label=2UP_Text
T $8A55,$04,h$01,$02:$01 "2UP" (#N(#PEEK(#PC)) is the attribute).
@ $8A59 label=HI_Text
T $8A59,$03,h$01,$01:$01 "HI" (#N(#PEEK(#PC)) is the attribute).

c $8A5C

c $8B73

c $8BA5

c $8BBB

c $8C01

c $8C3E

c $8C5F

c $8C6C

c $8C71

c $8CBC

c $8D06
  $8D06,$03 Call #R$8F90.

c $8E5A

c $8F6A Player Input: Cursor Joystick
@ $8F6A label=Player_Cursor
R $8F6A O:A Controls
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

c $8F90 Read Player Input
@ $8F90 label=ReadInput
M $8F90,$06 Jump to #R$8F9F if #R$5E00 is set for keyboard controls.
  $8F93,$02,b$01
  $8F97,$04 Jump to #R$8F6A if #R$5E00 is set for cursor joystick controls.
N $8F9B Read from the Kempston Joystick.
@ $8F9B label=Player_Kempston
  $8F9B,$02 #REGa=controls.
  $8F9D,$01 Flip the bits.
  $8F9E,$01 Return.

c $8F9F Player Input: Keyboard
@ $8F9F label=Player_Keyboard
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

c $91E2

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

c $9356

c $945C

c $9C23
  $9C23,$0B Copy #N$0018 bytes from #R$9D80 to #N$5E20.
  $9C2E,$0B Copy #N$0018 bytes from #R$9D98 to #N$5E06.
  $9C39,$01 Return.

b $9C3A
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
  $9E25,$03 Jump to #R$B8A8.
N $9E28 All the attributes a laser beam can be.
B $9E28,$04

c $9E2C Animate: Laser Beam
@ $9E2C label=LaserBeam_Animate

c $9ECA

c $9EDC
B $A008,$60
B $A068,$90

c $A0F8

c $A84C Initialise New Game
@ $A84C label=NewGame
  $A84C,$02 #REGb=#N$02 (counter for our two players).
@ $A84E label=NewGame_Loop
  $A84E,$01 Stash the counter in #REGbc on the stack.
N $A84F Handle setting up 1UP player.
  $A84F,$05 Write 1UP starting fuel to #R$5EA0.
  $A854,$05 Write 1UP starting lives to #R$5EA1.
  $A859,$07 Write #N$00 to; #LIST { #R$5EA2 } { #R$5EA3 } LIST#
  $A860,$03 Call #R$B3DC.
  $A863,$03 Call #R$9F5E.
  $A866,$03 Call #R$A880.
  $A869,$01 Restore #REGbc from the stack.
  $A86A,$02 Decrease counter by one and loop back to #R$A84E until counter is zero.
N $A86C Handle setting up 2UP player.
  $A86C,$05 Write 2UP starting lives to #R$5EA5.
  $A871,$05 Write 2UP starting fuel to #R$5EA4.
  $A876,$06 Return if #R$5E00 indicates this is a 1 player only game.
  $A87C,$03 Write #REGa to #R$5EA5.
  $A87F,$01 Return.

c $A880

c $B3A3 Message: Teleporting
@ $B3A3 label=MessageTeleporting
  $B3A3,$01 Disable interrupts.
  $B3A4,$03 Call #R$8BA5.
  $B3A7,$02 #REGb=#N$10 (colour cycling counter).
@ $B3A9 label=MessageTeleporting_Loop
  $B3A9,$01 Stash #REGbc (the colour cycling counter) on the stack.
N $B3AA Handle printing "#FONT:(TELEPORTING)$D347" messaging.
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
N $B3D0 Messaging data.
@ $B3D0 label=String_Teleporting
T $B3D0,$0C,h$01,$0A:$01 Attribute: #N(#PEEK(#PC)) + "TELEPORTING".

c $B3DC

c $B3E8
B $B451

c $B460

c $B594 Messaging: Missile Launch
@ $B594 label=Message_MissileLaunch
N $B594 Print "WARNING".
  $B594,$03 #REGde=#R$B5DC.
  $B597,$03 #REGhl=#N($2860, $04, $04) (screen buffer location).
  $B59A,$03 Call #R$8A11.
N $B59D Print "A MISSILE HAS BEEN LAUNCHED".
  $B59D,$03 #REGde=#R$B5E4.
  $B5A0,$03 #REGhl=#N($3808, $04, $04) (screen buffer location).
  $B5A3,$03 Call #R$8A11.
N $B5A6 Print "FROM THE ENEMY BASE".
  $B5A6,$03 #REGde=#R$B601.
  $B5A9,$03 #REGhl=#N($4808, $04, $04) (screen buffer location).
  $B5AC,$03 Call #R$8A11.
N $B5AF Print "YOUR LUNAR ROVER IS IN DANGER".
  $B5AF,$03 #REGde=#R$B617.
  $B5B2,$03 #REGhl=#N($5808, $04, $04) (screen buffer location).
  $B5B5,$03 Call #R$8A11.
N $B5B8 Print "OF BEING DESTROYED".
  $B5B8,$03 #REGde=#R$B636.
  $B5BB,$03 #REGhl=#N($6808, $04, $04) (screen buffer location).
  $B5BE,$03 Call #R$8A11.
N $B5C1 Print "IT IS ESTIMATED THAT    LASER".
  $B5C1,$03 #REGde=#R$B64A.
  $B5C4,$03 #REGhl=#N($8008, $04, $04) (screen buffer location).
  $B5C7,$03 Call #R$8A11.
N $B5CA Print "HITS WILL BE REQUIRED TO".
  $B5CA,$03 #REGde=#R$B669.
  $B5CD,$03 #REGhl=#N($9008, $04, $04) (screen buffer location).
  $B5D0,$03 Call #R$8A11.
N $B5D3 Print "DESTROY THE MISSILE.".
  $B5D3,$03 #REGde=#R$B683.
  $B5D6,$03 #REGhl=#N($A008, $04, $04) (screen buffer location).
  $B5D9,$03 Jump to #R$8A11.
N $B5DC Messaging data.
T $B5DC,$08,h$01,$06:$01 "WARNING".
T $B5E4,$1D,h$01,$1B:$01 "A MISSILE HAS BEEN LAUNCHED "
T $B601,$16,h$01,$14:$01 "FROM THE ENEMY BASE "
T $B617,$1F,h$01,$1D:$01 "YOUR LUNAR ROVER IS IN DANGER ".
T $B636,$14,h$01,$12:$01 "OF BEING DESTROYED ".
T $B64A,$1F,h$01,$1D:$01 "IT IS ESTIMATED THAT    LASER ".
T $B669,$1A,h$01,$18:$01 "HITS WILL BE REQUIRED TO ".
T $B683,$16,h$01,$14:$01 "DESTROY THE MISSILE. ".

c $B699

c $B6AE

c $B6CF

c $B731
B $B76D,$18

c $B8A8 Sounds: Laser Beam
@ $B8A8 label=SoundsLaserBeam
  $B8B3,$01 Return.

c $B8B4
  $B8BC,$01 Return.

c $B8BD
  $B8C1,$02 Jump to #R$B8CD.

c $B8C3
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
c $B934

c $B950
B $B95C,$08
B $B964,$08
B $B96C,$07

c $B973
B $B978

c $B986
B $B98B

c $B9A1
B $B9A6

c $B9BC
  $B9BC,$01 Disable interrupts.
  $B9BD,$03 #REGhl=#N$FF51.
  $B9C8,$02 Jump to #R$B9C0.
  $B9CA,$02,b$01 Keep only bits 0-6.
  $B9D0,$01 Enable interrupts.
  $B9D1,$01 Return.

b $B9D2
  $BA35

w $BAA4
  $BAA4,$04,$02

b $BAA8

w $BAC0 Jetman Sprite Table
E $BAC0 View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #JETPAC$0000 }
. { #PSSST$761A }
. { #TRANZAM$0000 }
. LIST#
@ $BAC0 label=JetmanSpritesTable
  $BAC0,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $BAC0) / 2)).
L $BAC0,$02,$11

w $BAE2 Rover Graphics Table
@ $BAE2 label=RoverGraphicsTable
  $BAE2,$02 Graphic ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $BAE2) / 2)).
L $BAE2,$02,$18

w $BB12 Sprite Table
@ $BB12 label=SpritesTable
  $BB12,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $BB12) / 2)) #SPRITENAME((#PC - $BB12) / 2).
L $BB12,$02,$3D

w $BB8C Graphics Table
@ $BB8C label=GraphicsTable
  $BB8C,$02 Graphic ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $BB8C) / 2)).
L $BB8C,$02,$09

w $BB9E Attribute Table?
@ $BB9E label=AttributeTable
  $BB9E,$02 Graphic ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $BB9E) / 2)).
L $BB9E,$02,$09

w $BBB0 Graphics Table 2
@ $BBB0 label=GraphicsTable2
  $BBB0,$02 Graphic ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $BBB0) / 2)).
L $BBB0,$02,$09

b $BC9E

b $BCBC Sprite: None
  $BCBC,$01 Height = #N(#PEEK(#PC)) pixels.
  $BCBD,$01

b $BCBE Sprite: Jetman Walking
N $BCBE Walking left frame 1.
  $BCBE,$01 Height = #N(#PEEK(#PC)) pixels.
  $BCBF,$2C,$02 #JETMAN$08(jetman-walk-left-01)

N $BCEB Walking left frame 2.
  $BCEB,$01 Height = #N(#PEEK(#PC)) pixels.
  $BCEC,$2C,$02 #JETMAN$09(jetman-walk-left-02)

N $BD18 Walking left frame 3.
  $BD18,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD19,$2C,$02 #JETMAN$0A(jetman-walk-left-03)

N $BD45 Walking right frame 1.
  $BD45,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD46,$2C,$02 #JETMAN$0C(jetman-walk-right-01)

N $BD72 Walking right frame 2.
  $BD72,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD73,$2C,$02 #JETMAN$0D(jetman-walk-right-02)

N $BD9F Walking right frame 3.
  $BD9F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BDA0,$2C,$02 #JETMAN$0E(jetman-walk-right-03)

b $BDCC Sprite: Jetman Flying
N $BDCC Flying left frame 1.
  $BDCC,$01 Height = #N(#PEEK(#PC)) pixels.
  $BDCD,$30,$02 #JETMAN$00(jetman-fly-left-01)

N $BDFD Flying left frame 2.
  $BDFD,$01 Height = #N(#PEEK(#PC)) pixels.
  $BDFE,$30,$02 #JETMAN$01(jetman-fly-left-02)

N $BE2E Flying right frame 1.
  $BE2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $BE2F,$30,$02 #JETMAN$04(jetman-fly-right-01)

N $BE5F Flying right frame 2.
  $BE5F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BE60,$30,$02 #JETMAN$05(jetman-fly-right-02)

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
  $C5D0,$D8,$08 #ROVER$16(rover-right-0A)

N $C6A8 Right frame 11.
  $C6A8,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C6A9,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6AA,$D8,$08 #ROVER$17(rover-right-0B)

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
  $CEC2,$D8,$08 #ROVER$0E(rover-left-0A)

N $CF9A Left frame 11.
  $CF9A,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CF9B,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF9C,$D8,$08 #ROVER$0F(rover-left-0B)

b $D074 Sprite: Teleporter
E $D074 #UDGTABLE(default) { #UDGARRAY*teleporter-01,15;teleporter-02;teleporter-03;teleporter-04(teleporter) } UDGTABLE#
N $D074 Frame 1.
  $D074,$01 Height = #N(#PEEK(#PC)) pixels.
  $D075,$36,$02 #SPRITE$00(teleporter-01*)

N $D0AB Frame 2.
  $D0AB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D0AC,$36,$02 #SPRITE$01(teleporter-02*)

N $D0E2 Frame 3.
  $D0E2,$01 Height = #N(#PEEK(#PC)) pixels.
  $D0E3,$36,$02 #SPRITE$02(teleporter-03*)

N $D119 Frame 4.
  $D119,$01 Height = #N(#PEEK(#PC)) pixels.
  $D11A,$36,$02 #SPRITE$03(teleporter-04*)

b $D150
b $D151 The UDG for the lives icon.
@ $D151 label=UDG_Life
  $D151,$08,b$01 #UDGTABLE(default,centre) { #UDG#(#PC),attr=$07 } UDGTABLE#

b $D159

b $D160

b $D167 Sprite: Turret
N $D167 Left frame 1.
  $D167,$01 Height = #N(#PEEK(#PC)) pixels.
  $D168,$16,$02 #SPRITE$06(turret-left-01)

N $D17E Left frame 2.
  $D17E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D17F,$16,$02 #SPRITE$07(turret-left-02)

N $D195 Left frame 3.
  $D195,$01 Height = #N(#PEEK(#PC)) pixels.
  $D196,$18,$02 #SPRITE$08(turret-left-03)

N $D1AE Left frame 4.
  $D1AE,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1AF,$1C,$02 #SPRITE$09(turret-left-04)

N $D1CB Left frame 5.
  $D1CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1CC,$1E,$02 #SPRITE$0A(turret-left-05)

N $D1EA Left frame 6.
  $D1EA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1EB,$22,$02 #SPRITE$0B(turret-left-06)

N $D20D Left frame 7.
  $D20D,$01 Height = #N(#PEEK(#PC)) pixels.
  $D20E,$24,$02 #SPRITE$0C(turret-left-07)

N $D232 Left frame 8.
  $D232,$01 Height = #N(#PEEK(#PC)) pixels.
  $D233,$24,$02 #SPRITE$0D(turret-left-08)

N $D257 Right frame 1.
  $D257,$01 Height = #N(#PEEK(#PC)) pixels.
  $D258,$16,$02 #SPRITE$0E(turret-right-01)

N $D26E Right frame 2.
  $D26E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D26F,$16,$02 #SPRITE$0F(turret-right-02)

N $D285 Right frame 3.
  $D285,$01 Height = #N(#PEEK(#PC)) pixels.
  $D286,$18,$02 #SPRITE$10(turret-right-03)

N $D29E Right frame 4.
  $D29E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D29F,$1C,$02 #SPRITE$11(turret-right-04)

N $D2BB Right frame 5.
  $D2BB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2BC,$1E,$02 #SPRITE$12(turret-right-05)

N $D2DA Right frame 6.
  $D2DA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2DB,$22,$02 #SPRITE$13(turret-right-06)

N $D2FD Right frame 7.
  $D2FD,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2FE,$24,$02 #SPRITE$14(turret-right-07)

N $D322 Right frame 8.
  $D322,$01 Height = #N(#PEEK(#PC)) pixels.
  $D323,$24,$02 #SPRITE$15(turret-right-08)

b $D347 Main Font
@ $D347 label=MainFont
  $D347,$08 #UDG(#PC)
L $D347,$08,$4B

b $D59F Sprite: Blob
N $D59F Frame 1.
  $D59F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5A0,$20,$02 #SPRITE$1E(blob-01)

N $D5C0 Frame 2.
  $D5C0,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5C1,$20,$02 #SPRITE$1F(blob-02)

N $D5E1 Frame 3.
  $D5E1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5E2,$20,$02 #SPRITE$20(blob-03)

N $D602 Frame 4.
  $D602,$01 Height = #N(#PEEK(#PC)) pixels.
  $D603,$1C,$02 #SPRITE$21(blob-04)

N $D61F Frame 5.
  $D61F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D620,$18,$02 #SPRITE$22(blob-05)

N $D638 Frame 6.
  $D638,$01 Height = #N(#PEEK(#PC)) pixels.
  $D639,$1C,$02 #SPRITE$23(blob-06)

N $D655 Frame 7.
  $D655,$01 Height = #N(#PEEK(#PC)) pixels.
  $D656,$20,$02 #SPRITE$24(blob-07)

N $D676 Frame 8.
  $D676,$01 Height = #N(#PEEK(#PC)) pixels.
  $D677,$20,$02 #SPRITE$25(blob-08)

N $D697 Frame 9.
  $D697,$01 Height = #N(#PEEK(#PC)) pixels.
  $D698,$20,$02 #SPRITE$26(blob-09)

N $D6B8 Frame 10.
  $D6B8,$01 Height = #N(#PEEK(#PC)) pixels.
  $D6B9,$20,$02 #SPRITE$27(blob-10)

N $D6D9 Frame 11.
  $D6D9,$01 Height = #N(#PEEK(#PC)) pixels.
  $D6DA,$20,$02 #SPRITE$28(blob-11)

N $D6FA Frame 12.
  $D6FA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D6FB,$20,$02 #SPRITE$29(blob-12)

N $D71B Frame 13.
  $D71B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D71C,$20,$02 #SPRITE$2A(blob-13)

N $D73C Frame 14.
  $D73C,$01 Height = #N(#PEEK(#PC)) pixels.
  $D73D,$20,$02 #SPRITE$2B(blob-14)

N $D75D Frame 15.
  $D75D,$01 Height = #N(#PEEK(#PC)) pixels.
  $D75E,$20,$02 #SPRITE$2C(blob-15)

N $D77E Frame 16.
  $D77E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D77F,$20,$02 #SPRITE$2D(blob-16)

b $D79F Sprite: Sparkle
N $D79F Frame 1.
  $D79F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7A0,$12,$02 #SPRITE$32(sparkle-01)

N $D7B2 Frame 2.
  $D7B2,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7B3,$18,$02 #SPRITE$33(sparkle-02)

N $D7CB Frame 3.
  $D7CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7CC,$20,$02 #SPRITE$34(sparkle-03)

N $D7EC Frame 4.
  $D7EC,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7ED,$20,$02 #SPRITE$35(sparkle-04)

N $D80D Frame 5.
  $D80D,$01 Height = #N(#PEEK(#PC)) pixels.
  $D80E,$20,$02 #SPRITE$36(sparkle-05)

N $D82E Frame 6.
  $D82E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D82F,$20,$02 #SPRITE$37(sparkle-06)

N $D84F Frame 6.
  $D84F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D850,$20,$02 #SPRITE$38(sparkle-07)

b $D870
  $D870,$01 Height = #N(#PEEK(#PC)) pixels.
  $D871 #SPRITE$2E(test-2E)

b $D876
  $D876,$01 Height = #N(#PEEK(#PC)) pixels.
  $D877 #SPRITE$2F(test-2F)

b $D87E

b $D888

b $D894 Sprite: Spinning Top Alien
N $D894 Frame 1.
  $D894,$01 Height = #N(#PEEK(#PC)) pixels.
  $D895,$20,$02 #SPRITE$16(top-01)

N $D8B5 Frame 2.
  $D8B5,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8B6,$1E,$02 #SPRITE$17(top-02)

N $D8D4 Frame 3.
  $D8D4,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8D5,$1C,$02 #SPRITE$18(top-03)

N $D8F1 Frame 4.
  $D8F1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8F2,$1A,$02 #SPRITE$19(top-04)

N $D90C Frame 5.
  $D90C,$01 Height = #N(#PEEK(#PC)) pixels.
  $D90D,$18,$02 #SPRITE$1A(top-05)

N $D925 Frame 6.
  $D925,$01 Height = #N(#PEEK(#PC)) pixels.
  $D926,$16,$02 #SPRITE$1B(top-06)

N $D93C Frame 7.
  $D93C,$01 Height = #N(#PEEK(#PC)) pixels.
  $D93D,$1A,$02 #SPRITE$1C(top-07)

N $D957 Frame 8.
  $D957,$01 Height = #N(#PEEK(#PC)) pixels.
  $D958,$1E,$02 #SPRITE$1D(top-08)

b $D976 Sprite: Platform
  $D976,$01 Height = #N(#PEEK(#PC)) pixels.
  $D977,$10,$02 #SPRITE$04(platform)

b $D987 Frame 8.

b $D9C8

b $DA09

b $DA4A

b $DA8B

b $DACC

b $DB0D

b $DB4E

b $DB8F

b $DBD0

b $DC11

b $DC52

b $DC93

b $DCD4

b $DD15

b $DD56

b $DF13 Graphic: Alien Base
N $DF13 Frame 1.
  $DF13,$01 Width = #N(#PEEK(#PC)) bytes.
  $DF14,$01 Height = #N(#PEEK(#PC)) pixels.
  $DF15,$40,$04 #GRAPHIC$01(base-01)

N $DF55 Frame 2.
  $DF55,$01 Width = #N(#PEEK(#PC)) bytes.
  $DF56,$01 Height = #N(#PEEK(#PC)) pixels.
  $DF57,$50,$05 #GRAPHIC$02(base-02)

N $DFA7 Frame 3.
  $DFA7,$01 Width = #N(#PEEK(#PC)) bytes.
  $DFA8,$01 Height = #N(#PEEK(#PC)) pixels.
  $DFA9,$50,$05 #GRAPHIC$03(base-03)

N $DFF9 Frame 4.
  $DFF9,$01 Width = #N(#PEEK(#PC)) bytes.
  $DFFA,$01 Height = #N(#PEEK(#PC)) pixels.
  $DFFB,$50,$05 #GRAPHIC$04(base-04)

N $E04B Frame 5.
  $E04B,$01 Width = #N(#PEEK(#PC)) bytes.
  $E04C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E04D,$50,$05 #GRAPHIC$05(base-05)

N $E09D Frame 6.
  $E09D,$01 Width = #N(#PEEK(#PC)) bytes.
  $E09E,$01 Height = #N(#PEEK(#PC)) pixels.
  $E09F,$50,$05 #GRAPHIC$06(base-06)

N $E0EF Frame 7.
  $E0EF,$01 Width = #N(#PEEK(#PC)) bytes.
  $E0F0,$01 Height = #N(#PEEK(#PC)) pixels.
  $E0F1,$50,$05 #GRAPHIC$07(base-07)

N $E141 Frame 8.
  $E141,$01 Width = #N(#PEEK(#PC)) bytes.
  $E142,$01 Height = #N(#PEEK(#PC)) pixels.
  $E143,$50,$05 #GRAPHIC$08(base-08)

b $E193

b $E1B4

b $E23B

b $E256

b $E271

b $E28C

b $E2A7

b $E2C8

b $E2E9

b $E306

b $E31F

b $E338

b $E351

b $E36E

b $E533

b $E55E

b $E589

b $E5B4

b $EB67 Graphic: Explosion
N $EB67 Frame 1.
  $EB67,$01 Width = #N(#PEEK(#PC)) bytes.
  $EB68,$01 Height = #N(#PEEK(#PC)) pixels.
  $EB69,$E0,$07 #GRAPHIC$07(explosion-01)

N $EC49 Frame 2.
  $EC49,$01 Width = #N(#PEEK(#PC)) bytes.
  $EC4A,$01 Height = #N(#PEEK(#PC)) pixels.
  $EC4B,$D8,$07 #GRAPHIC$07(explosion-02)

N $EC6A Frame 3.
  $EC6A,$01 Width = #N(#PEEK(#PC)) bytes.
  $EC6B,$01 Height = #N(#PEEK(#PC)) pixels.
  $EC6C,$D8,$07 #GRAPHIC$07(explosion-03)

N $EC8B Frame 4.
  $EC8B,$01 Width = #N(#PEEK(#PC)) bytes.
  $EC8C,$01 Height = #N(#PEEK(#PC)) pixels.
  $EC8D,$D8,$07 #GRAPHIC$07(explosion-04)

N $ECAC Frame 5.
  $ECAC,$01 Width = #N(#PEEK(#PC)) bytes.
  $ECAD,$01 Height = #N(#PEEK(#PC)) pixels.
  $ECAE,$D8,$07 #GRAPHIC$07(explosion-05)

N $ECCD Frame 6.
  $ECCD,$01 Width = #N(#PEEK(#PC)) bytes.
  $ECCE,$01 Height = #N(#PEEK(#PC)) pixels.
  $ECCF,$D8,$07 #GRAPHIC$07(explosion-06)

N $ECEE Frame 7.
  $ECEE,$01 Width = #N(#PEEK(#PC)) bytes.
  $ECEF,$01 Height = #N(#PEEK(#PC)) pixels.
  $ECF0,$D8,$07 #GRAPHIC$07(explosion-07)

N $ED0F Frame 8.
  $ED0F,$01 Width = #N(#PEEK(#PC)) bytes.
  $ED10,$01 Height = #N(#PEEK(#PC)) pixels.
  $ED11,$D8,$07 #GRAPHIC$07(explosion-08)

N $ED30 Frame 9.
  $ED30,$01 Width = #N(#PEEK(#PC)) bytes.
  $ED31,$01 Height = #N(#PEEK(#PC)) pixels.
  $ED32,$D8,$07 #GRAPHIC$07(explosion-09)

b $EE17 Sprite: Bomb
E $EE17 #UDGTABLE(default) { #UDGARRAY*bomb-01,25;bomb-02;bomb-03(bomb) } UDGTABLE#
N $EE17 Frame 1.
  $EE17,$01 Height = #N(#PEEK(#PC)) pixels.
  $EE18,$20,$02 #SPRITE$07(bomb-01*)

N $EE38 Frame 2.
  $EE38,$01 Height = #N(#PEEK(#PC)) pixels.
  $EE39,$20,$02 #SPRITE$07(bomb-02*)

N $EE59 Frame 3.
  $EE59,$01 Height = #N(#PEEK(#PC)) pixels.
  $EE5A,$20,$02 #SPRITE$07(bomb-03*)

b $EE7A

c $F232
T $F274,$03,h$01,$01:$01 Attribute: #N(#PEEK(#PC)) + "TH".
T $F277,$0A,h$01,$08:$01 Attribute: #N(#PEEK(#PC)) + "TOP SCORE".
T $F281,$03,h$01,$01:$01 Attribute: #N(#PEEK(#PC)) + "ND".
T $F284,$03,h$01,$01:$01 Attribute: #N(#PEEK(#PC)) + "RD".
T $F287,$0E,h$01,$0C:$01 Attribute: #N(#PEEK(#PC)) + "HIGHEST SCORE".

c $F295

c $F33E

c $F410 Hall Of Fame
@ $F410 label=HallOfFame
@ $F417 label=
@ $F419 label=
@ $F424 label=
N $F427 Handle printing "THE ULTIMATE" messaging.
  $F427,$03 #REGhl=#N$1850 (screen buffer location).
  $F42A,$03 #REGde=#R$F4AA.
  $F42D,$03 Call #R$8A11.
N $F430 Handle printing "HALL OF FAME" messaging.
  $F430,$03 #REGhl=#N$2850 (screen buffer location).
  $F433,$03 #REGde=#R$F4B8.
  $F436,$03 Call #R$8A11.
  $F439,$03 #REGhl=#N$4048 (screen buffer location).
@ $F441 label=
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
T $F4AA,$0E,h$01,$0C:$01 Attribute: #N(#PEEK(#PC)) + "THE ULTIMATE ".
T $F4B8,$0E,h$01,$0C:$01 Attribute: #N(#PEEK(#PC)) + "HALL OF FAME ".

c $F4C6
@ $F4C6 label=HighScoreMessaging
N $F4C6 Handle printing "CONGRATULATIONS PLAYER ...".
  $F4C6,$03 #REGde=#R$F4FB.
  $F4C9,$03 #REGhl=#N$6020 (screen buffer location).
  $F4CC,$03 Call #R$8A11.
N $F4CF Handle printing the player "number".
  $F4CF,$05 #REGa=#R$5E71 + #N$30.
  $F4D4,$03 #REGhl=#N$489B (screen buffer location).
  $F4D7,$03 Call #R$89EF.
N $F4DA Handle printing "TODAYS".
  $F4DA,$03 #REGde=#R$F513.
  $F4DD,$03 #REGhl=#N$7068 (screen buffer location).
  $F4E0,$03 Call #R$8A11.
  $F4E3,$03 Call #R$F232.
N $F4E6 Handle printing "JETMAN WILL REMEMBER YOU".
  $F4E6,$03 #REGde=#R$F51B.
  $F4E9,$03 #REGhl=#N$9020 (screen buffer location).
  $F4EC,$03 Call #R$8A11.
  $F4EF,$03 #REGhl=#N$53AD.
  $F4F2,$02 #REGb=#N$03.
  $F4FA,$01 Return.
T $F4FB,$18,h$01,$16:$01 Attribute: #N(#PEEK(#PC)) + "CONGRATULATIONS PLAYER ".
T $F513,$08,h$01,$06:$01 Attribute: #N(#PEEK(#PC)) + "TODAYS ".
T $F51B,$1A,h$01,$18:$01 Attribute: #N(#PEEK(#PC)) + "JETMAN WILL REMEMBER YOU ".

c $F535
  $F535,$01
  $F53D,$03 Call #R$84D8.
  $F540,$03 #REGhl=#N$5900.
  $F550,$03 Call #R$F4C6.
  $F56D,$01 Return.

c $F56E

c $F5EC

c $F609

c $F612

c $F628

c $F632

c $F641

c $F662

b $F66E Terrain UDGs
@ $F66E label=TerrainUDGs
  $F66E,$08 #UDG(#PC)
L $F66E,$08,$90

i $FC00
