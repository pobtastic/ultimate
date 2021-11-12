> $4000 @org=$4000
> $4000 @start=$5B80
b $4000 Loading screen
D $4000 #UDGTABLE { #SCR2(loading) | JetPac Loading Screen. } TABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$300,$20 Attributes

i $5B00

c $5B80 Game entry point
E $5B80 View the equivalent code in;
. #LIST
. { #COOKIE$5B80 }
. { #PSSST$5B80 }
. { #TRANZAM$5B80 }
. LIST#
E $5B80 Later Ultimate games use more advanced decryption mechanisms;
. #LIST
. { #ATICATAC$5B80 }
. { #LUNARJETMAN$5B80 }
. LIST#
@ $5B80 label=GameEntry
  $5B80,$0B Moves #N$2000 bytes from #N$6004 to #N$6000.
  $5B8B,$03 Jump to #R$61E5.

i $5B8E

g $5CF0 High Score
E $5CF0 View the equivalent code in;
. #LIST
. { #COOKIE$5F09 }
. { #LUNARJETMAN$5E06 }
. { #PSSST$5E00 }
. LIST#
D $5CF0 3-byte representation of the score.
@ $5CF0 label=High_Score
B $5CF0,$03

g $5CF3 Game Type
@ $5CF3 label=GAME_TYPE
D $5CF3 Holds the number of players and the chosen control method.
. #TABLE(default,centre,:w) { =h Bit(n) | =h Unset(0) | =h Set(1) } { 0 | 1up | 2up } { 1 | Keyboard | Kempston } TABLE#
  $5CF3 #TABLE(default,centre,:w) { =h Value | =h Num Players | =h Control Method }
. { 0 | 1UP | Keyboard }
. { 1 | 2UP | Keyboard }
. { 2 | 1UP | Kempston }
. { 3 | 2UP | Kempston }
. TABLE#


g $5CF4 Player 1 Score
@ $5CF4 label=1UP_SCORE_1ST
D $5CF4 The current score for player 1.
B $5CF4 Upper scoring byte
B $5CF5 Middle scoring byte
@ $5CF5 label=1UP_SCORE_2ND
B $5CF6 Lower scoring byte
@ $5CF6 label=1UP_SCORE_3RD

g $5CF7 Player 2 Score
@ $5CF7 label=2UP_SCORE_1ST
D $5CF7 The current score for player 2.
B $5CF7 Upper scoring byte
B $5CF8 Middle scoring byte
@ $5CF8 label=2UP_SCORE_2ND
B $5CF9 Lower scoring byte
@ $5CF9 label=2UP_SCORE_3RD

b $5CFA Buffer
g $5D00 Jetman Frame
@ $5D00 label=JETMAN_FRAME
D $5D00 Relates to which frame to display.
B $5D00 #TABLE(default,centre,centre,centre,centre,centre) { =h Value | =h Walking | =h Flying | =h Direction | =h Bits }
. { $00 | #SPACE(1)     | #SPACE(1) | None  | #EVAL($00,$02,$08) }
. { $01 | #SPACE(1)     | X         | Right | #EVAL($01,$02,$08) }
. { $41 | #SPACE(1)     | X         | Left  | #EVAL($41,$02,$08) }
. { $82 | X             | #SPACE(1) | Right | #EVAL($82,$02,$08) }
. { $C2 | X             | #SPACE(1) | Left  | #EVAL($C2,$02,$08) }
. TABLE#
E $5D00 "None" is used to not show Jetman at all i.e. at the start of a game and while "inside the rocket".

g $5D01 Jetman X Co-ordinate
@ $5D01 label=JETMAN_POS_X
g $5D02 Jetman Y Co-ordinate
@ $5D02 label=JETMAN_POS_Y

b $5D03

g $5D0E

g $5D30 PARAM1
g $5D31 PARAM2
g $5D32 PARAM3
g $5D33 PARAM4
g $5D34 PARAM5

g $5D35 Number of collected fuel pods for current level
@ $5D35 label=NUM_FUEL_PODS

g $5D36 PARAM7
g $5D37 PARAM8
g $5D38 Fuel 00 when not on screen, $04 when visible
g $5D38 PARAM10
g $5D39 Ship top section X position
g $5D3A Fuel (height)
g $5D3B PARAM12

g $5D3C Fuel status
@ $5D3C label=FUEL_POD_STATUS
D $5D3C Note the status doesn't "reset". For example, after you've filled the ship with fuel and the ship is flashing
.       this value remains at $07 even though no more fuel pods will drop.  Hence, it only has a value of $00 when the
.       ship is in pieces and no fuel pod is set to drop.
B $5D3C #TABLE(default,centre,centre,centre,centre,centre) { =h Value | =h State | =h Bits }
. { $00 | Invisible/ None             | #EVAL($00,$02,$08) }
. { $01 | Falling (from the sky)      | #EVAL($01,$02,$08) }
. { $03 | Collected (i.e. "attached") | #EVAL($03,$02,$08) }
. { $07 | Falling (can't recollect)   | #EVAL($07,$02,$08) }
. TABLE#

g $5D3D PARAM14
g $5D3E PARAM15
g $5D3F PARAM16

g $5D40 Item visibility
@ $5D40 label=ITEM_VISIBILITY
D $5D40 $00 when not on screen, $0e when visible
B $5D40 $00 (#EVAL($00,$02,$08)) when not on screen, $0e (#EVAL($0e,$02,$08)) when visible

g $5D41 Ship middle section X position

g $5D42 Falling item (height)

b $5D48
B $5D49
  $5D4A
  $5D4B
  $5D4C
  $5D4D
  $5D4E
  $5D4F

g $5D50 Alien 1
  $5D51 Alien 1 X?
  $5D52 Alien 1 Y?
  $5D53 Alien 1 Frame?

g $5D58 Alien 2
  $5D59 Alien 2 X?
  $5D5A Alien 2 Y?
  $5D5B Alien 2 Frame?

g $5D60 Alien 3
  $5D61 Alien 3 X?
  $5D62 Alien 3 Y?
  $5D63 Alien 3 Frame?

g $5D68 Alien 4
  $5D69 Alien 4 X?
  $5D6A Alien 4 Y?
  $5D6B Alien 4 Frame?

g $5D70 Alien 5
  $5D71 Alien 5 X?
  $5D72 Alien 5 Y?
  $5D73 Alien 5 Frame?

g $5D78 Alien 6
  $5D79 Alien 6 X?
  $5D7A Alien 6 Y?
  $5D7B Alien 6 Frame?

g $5D88

g $5D98 ???

g $5DC5 ???

g $5DC6 ???
g $5DCA
g $5DCB ???
g $5DCC ????
g $5DCF LOOKING2

g $5DD1 Active Player
@ $5DD1 label=ACTIVE_PLAYER
D $5DD1 Which player is currently active.
B $5DD1 #TABLE(default,centre,centre) { =h Value | =h Player }
. { $00 | 1UP }
. { $FF | 2UP }
. TABLE#

g $5DD2 ???
g $5DD3 ???
g $5DD4 ???
g $5DD5 ???
g $5DD6 $C7 / $47 before game starts then $00?

g $5DD7 Countdown timer for interval before game starts
@ $5DD7 label=INTERVAL_COUNTDOWN

g $5DF0 Player Current Level
@ $5DF0 label=CURRENT_LEVEL

g $5DF1 Player 1 Lives
@ $5DF1 label=1UP_CURRENT_LIVES

g $5DF2 LOOKING3
@ $5DF2 label=LOOKING3

g $5DF8 ?????

g $5DF9 Player 2 Lives
@ $5DF9 label=2UP_CURRENT_LIVES

b $5E00

b $5FC0

b $6010

g $6018 New Game Parameters
@ $6018 label=INIT_GAME_ENV
B $6019,$11,$01

b $602A

b $6038
B $6038,$08

t $6040 Rights Messaging
@ $6040 label=Message_Rights
  $6040,$21,h$01,c$01,$1E:$01 "© 1983 A.C.G. ALL RIGHTS RESERVED".

t $6061 Copyright Messaging
@ $6061 label=Message_Copyright
  $6061,$2A "COPYRIGHT 1983 A.C.G. ALL RIGHTS RESERVED".

c $608A
@ $608A label=LEVEL_INIT
C $608A,$03 Black Border
  $608D,$03 Clear the screen
  $6090,$03 Reset the screen colours
  $6093,$03 Display score labels
  $6096,$03 Attribute file address
  $6099,$03 #REGb=loop counter, #REGc=Cyan/Yellow
  $609C,$01 Reset bytes in the attribute file
  $609E,$02 Decrease #REGb by one, jump to #R$609C if not zero
  $60A0,$03 Update display with player 1 score
  $60A3,$03 Update display with player 2 score
  $60A6,$03 Update display with high score
  $60A9,$03 #REGa=#R$5DF0
  $60AC,$04 If #R$5DF0 is divisible by $03 ... jump to init with a "broken ship"
  $60B3,$04 Increase the live counter #R$5DF1 by one
  $60C6,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $60C9,$03 Write #REGa to #R$5DD4
  $60CC,$01 Return

C $60CD,$03 #REGhl Source address: #R$6018
  $60D0,$03 #REGde Target address: #R$5D30
  $60D3,$03 #REGbc=loop counter
  $60D6,$02 Action! Copy source to target, decrease counter, repeat until zero
  $60D8,$02 #REGa=$08
  $60DA,$03 Jump to #R$6EF9

C $6103,$03 #REGa=#R$5DF9

  $6146,$02 Decrease #REGb by one, jump to #R$6141 if not zero

C $616A,$03 #REGhl=#R$5DF0
  $616D,$03 #REGde=#R$5DF8
  $6170,$02 #REGb=$02
  $6172,$03
  $6175,$03 #REGhl=#R$5D30
  $6178,$03 #REGde=#R$5D98
  $617B,$02 #REGb=$18
  $617D,$01 #REGa=#REGde
  $617E,$01 #REGc=#REGhl
  $617F,$01 Writes #REGa to #REGhl
  $6180,$01 #REGa=#REGc
  $6181,$01 Writes #REGa to #REGde
  $6182,$01 Increase #REGhl by one
  $6183,$01 Increase #REGde by one
  $6184,$02 Decrease #REGb by one, jump to #R$617D if not zero
  $6186,$01 Return
B $6187,$01
T $6188,$12,$11:1 GAME OVER PLAYER 1

C $619A,$03 #REGhl Source address: #R$6010
  $619D,$03 #REGde Target address: #R$5D00
  $61A0,$03 #REGbc=loop counter
  $61A3,$02 Action! Copy source to target, decrease counter, repeat until zero
  $61A5,$02 #REGa=$80
  $61A7,$07 if bit 0 is set for #R$5CF3 (is this a 2UP game) then jump to #R$61B0
  $61AE,$05 Add $7F to #REGa and update #R$5DD7 with the result
  $61B3,$07 Decrease #R$5DF1 by 1
  $61BA,$03 Jump to #R$70A4

  $61BD,$03 #REGa=#R$5DD1
  $61C0,$01
  $61C1,$02
  $61C3,$03 #REGhl=$0018
  $61C6,$03
  $61C9,$02 #REGb=$03
  $61CB,$01 #REGa=(#REGhl)
  $61CC,$02
  $61CE,$01 Push #REGa into the memory location at #REGhl
  $61CF,$01 Increase #REGhl by one
  $61D0,$02 Decrease #REGb by one, jump to #R$61CB if not zero
  $61D2,$01 Return

  $61DD,$02 Decrease #REGb by one, jump to #R$61D8 if not zero

c $61E5 Security Check
E $61E5 Continue on to #R$61EB.
E $61E5 View the equivalent code in;
. #LIST
. { #ATICATAC$6000 }
. { #COOKIE$5F00 }
. { #LUNARJETMAN$8000 }
. { #PSSST$61C6 }
. { #TRANZAM$5F00 }
. LIST#
@ $61E5 label=SecurityCheck
  $61E5,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $61E8,$03 Return if #REGa is not #N$83.

c $61EB Game Initialisation
E $61EB View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #COOKIE$6298 }
. { #LUNARJETMAN$800A }
. { #PSSST$61CD }
. { #TRANZAM$5F07 }
. LIST#
@ $61EB label=GameInitialisation
@ $61F1 label=GameInitialisation_Loop
N $61EB Blank the 1UP, 2UP and HI scores.
  $61EB,$0A Write #N$00 to #N$0A bytes from #R$5CF0 to #N$5CFA.

@ $61F5 label=Game_Restart
  $61F5,$01 Disable interrupts.
  $61F6,$03 Set the stack pointer to #R$5CF0.
  $61F9,$03 Call #R$608A.
  $61FC,$05 Write #N$04 to #R$5DCA.

  $6204,$04 #REGd=#R$5CF3.
  $6208,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $620E,$01 Flip the bits.
N $620F Handle 1UP selection.
  $620F,$02 Has key "1" been pressed? ("1 PLAYER GAME").
  $6211,$02 If not jump to #R$6215.
  $6213,$02 Set player count = 1.
N $6215 Handle 2UP selection.
@ $6215 label=GameSelect_CheckP2
  $6215,$02 Has key "2" been pressed? ("2 PLAYER GAME").
  $6217,$02 If not jump to #R$621B.
  $6219,$02 Set player count = 2.
N $621B Handle Keyboard selection.
@ $621B label=GameSelect_CheckKeyboard
  $621B,$02 Has key "3" been pressed? ("3 KEYBOARD").
  $621D,$02 If not jump to #R$6221.
  $621F,$02 Set control = "keyboard".
N $6221 Handle Kempston Joystick selection.
@ $6221 label=GameSelect_CheckKempston
  $6221,$02 Has key "4" been pressed? ("4 KEMPSTON JOYSTICK").
  $6223,$02 If not jump to #R$6227.
  $6225,$02 Set control = "joystick".
N $6227 Handle starting a new game.
@ $6227 label=GameSelect_CheckStart
  $6227,$02 Has key "5" been pressed? ("5 START GAME").
  $6229,$03 If so, jump to #R$6333.
N $622C Handle flashing each selection.
  $6230,$03 #REGhl=#R$628D(GameSelection_Attributes)+#N$01 (i.e. ignoring "Game Selection" as it doesn't flash).

c $6260 Game Selection Menu
E $6260 View the equivalent code in;
. #LIST
. { #ATICATAC$7CAF }
. { #COOKIE$6332 }
. { #LUNARJETMAN$80D1 }
. { #PSSST$6250 }
. { #TRANZAM$5F6C }
. LIST#
@ $6260 label=GameMenu
  $6260,$03 #REGde=#R$628D.
  $6263,$01 Switch to the shadow registers.
  $6264,$03 #REGhl'=#R$6293.
  $6267,$03 #REGde'=#R$6299.
N $626A There are six lines of text.
  $626A,$02 #REGb'=#N$06 (counter).
  $626C,$01 Switch back to the normal registers.
@ $626C label=GameMenu_Loop
  $626D,$04 Copy a byte from #REGde to #R$5DD6.
  $6271,$01 Increment #REGde by one.
  $6272,$01 Switch to the shadow registers.
  $6273,$01 Stash #REGbc' on the stack.
  $6274,$01 #REGa=#REGhl' (grab the position data).
  $6275,$01 Increment #REGhl' (position data pointer) by one.
  $6276,$01 Stash #REGhl' (position data pointer) on the stack.
  $6277,$03 #REGh'=#REGa #REGl'=#N$30.
  $627A,$03 Call #R$62FF.
  $627D,$01 Switch back to the normal registers.
  $627E,$02 Restore #REGhl and #REGbc from the stack.
  $6280,$01 Increase #REGde by one.
  $6281,$02 Decrease counter by one and loop back to #R$626C until counter is zero.
  $6283,$03 #REGhl=#N$B800 (screen buffer position).
  $6286,$03 #REGde=#R$6040.
  $6289,$03 Call #R$716C.
  $628C,$01 Return.

b $628D Game Select Attribute Table
E $628D View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #COOKIE$635E }
. { #LUNARJETMAN$810E }
. { #PSSST$627C }
. { #TRANZAM$5FA7 }
. LIST#
@ $628D label=GameSelection_Attributes
  $628D,$06,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | Game Selection }
. { #N$02 | 1 Player Game }
. { #N$03 | 2 Player Game }
. { #N$04 | 3 Keyboard }
. { #N$05 | 4 Kempston Joystick }
. { #N$06 | 5 Start Game }
. TABLE#

b $6293 Game Select Y Position Table
E $6293 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF1 }
. { #COOKIE$6365 }
. { #LUNARJETMAN$8115 }
. { #PSSST$6282 }
. { #TRANZAM$5FAC }
. LIST#
@ $6293 label=GameSelection_Position
  $6293,$06,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | Game Selection }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | 1 Player Game }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | 2 Player Game }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | 3 Keyboard }
. { #N$05 | #EVAL(#PEEK(#PC+$04) / $08) | 4 Kempston Joystick }
. { #N$06 | #EVAL(#PEEK(#PC+$05) / $08) | 5 Start Game }
. TABLE#

t $6299 Game Selection Title text
E $6299 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #COOKIE$636C }
. { #LUNARJETMAN$811C }
. { #PSSST$6288 }
. { #TRANZAM$5FB1 }
. LIST#
@ $6299 label=GameSelection_Text
  $6299,$15,$14:$01 "JETPAC GAME SELECTION".
  $62AE,$11,$10:$01 "1   1 PLAYER GAME".
  $62BF,$11,$10:$01 "2   2 PLAYER GAME".
  $62D0,$0C,$0B:$01 "3   KEYBOARD".
  $62DC,$15,$14:$01 "4   KEMPSTON JOYSTICK".
  $62F1,$0E,$0D:$01 "5   START GAME".

c $62FF
C $62FF Store #REGhl on the stack
  $6300
  $6303 #REGa=#R$5DD6
  $6306 Exchanges #REGaf with #REGaf'
  $6307 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $6308 Restore #REGhl
  $6309
  $630C Jump to #R$7178

c $630F
C $630F,$02 #REGb=$02
  $6311,$01 Stores #REGbc on the stack
C $6312,$01 Clear #REGa (sets to $00)
C $6313,$03 #R$5DF0=#REGa
  $6316,$02 #REGa=Number of lives for 1UP on starting a game
  $6318,$03 Updates #R$5DF1 with the number of starting lives
  $6322,$02 Decrease #REGb by one, jump to #R$6311 if not zero
  $6324,$02 #REGa=Number of lives for 2UP on starting a game
  $6326,$03 Updates #R$5DF9 with the number of starting lives
  $6329,$03 #REGa=#R$5CF3
  $632C,$03 Return if this is a 2UP game

  $632F,$03 Sets #R$5DF9 to zero (as a 1UP game is in progress)
  $6332,$01 Return

  $6333,$03 #REGhl=#R$5CF4
  $6336,$03 #REGbc=#R$6000
  $6339,$03

  $6345,$03 Change the stack pointer to #R$5CF0
  $6348,$01 Enable interrupts
  $6349,$04 #REGix=#R$5D30
  $634D,$01 Clear #REGa (sets to $00)
  $634E,$03 Writes #REGa to #R$5DCB

  $63AC,$04 #REGe=#R$5CF6

  $63B0,$04 Compare #REGe with #R$5CF9
  $63B4,$02 Jump if carry flag is set to #R$63D5

  $63B6,$03 #REGhl=#R$5CF7
@ $63B6 label=COMPARE_2UP_SCORE
N $63B6 Tests to see if the highscore has been beaten by 2UP.
@ $63B9 label=CHECK_HIGHSCORE
  $63B9,$01 Push #REGhl onto the stack (see #R$63CB)
  $63BA,$03 #REGde=#R$5CF0
  $63BD,$02 #REGb=$03
  $63BF,$02 Compare #REGa against #R$5CF0
  $63C1,$02 If it's higher, update the highscore
  $63C3,$02 Jump if not zero to #R$63C9 (so if it's less than the current highscore)
  $63C5,$01 Increase #REGhl by one
  $63C6,$01 Increase #REGde by one
  $63C7,$02 Decrease #REGb by one, jump to #R$63BF if not zero
  $63C9,$01 Fetch #REGhl off the stack (to clear it)
  $63CA,$01 Return

c $63CB Updates the highscore
@ $63CB label=UPDATE_HIGHSCORE
D $63CB The top of the stack will contain either #R$5CF4 or #R$5CF7. The three bytes which make up the players score are
.       copied over to the #R$5CF0 memory location.
C $63CB,$01 Fetch #REGhl off the stack
  $63CC,$03 #REGde Target address: #R$5CF0
  $63CF,$03 #REGbc=loop counter
  $63D2,$02 Action! Copy source to target, decrease counter, repeat until zero
  $63D4,$01 Return

C $63D5,$03 #REGhl=#R$5CF4
@ $63D5 label=COMPARE_1UP_SCORE
N $63D5 Tests to see if the highscore has been beaten by 1UP.
  $63D8,$02 Jump to #R$63B9

c $63DA

C $653F,$06 Drop #REGix+$02 (fuel Y co-ordinate) by two pixels

C $65CE,$03 #REGa=(#REGix+$02) (fuel Y co-ordinate)
C $65D1,$02 Is #REGa=$B0? (has the fuel reached the ship yet?)
C $65D3,$03 If not, jump back to #R$653F
C $65D6,$07 Fuel pod deposited correctly; increase #R$5D35 by one
C $65DD,$02 Jump to #R$65C4
C $65DF,$06 If #R$5D00 is &$3F then return...
C $65E5,$03 Return if #R$5D00 is greater than (or equal to) $03

C $65E8,$03 #REGhl Source address: $6038
C $65EB,$03 #REGde Target address: #R$5D40
C $65EE,$03 #REGbc=loop counter
C $65F1,$01 #REGa=(#REGde)
  $65FA,$02 Action! Copy source to target, decrease counter, repeat until zero

  $6639,$03 #REGhl=$6030
  $663C,$03 #REGde=#R$5D38
  $663F,$03 #REGbc=$0008
  $6642,$01 #REGa=(#REGde)
  $6645,$05 Check if #R$5D35 is $06? Is the ship full of fuel?

  $665A,$01 Return

  $665B,$03 #REGhl=#R$5D38
  $665E,$02 #REGb=$0C
  $6660,$03 #REGde=$0008
  $6663,$02 Reset the memory held at location #REGhl (set to $00)
  $6665,$01 Increase #REGhl by $08
  $6666,$02 Decrease #REGb by one, and loop back to #R$6663 until zero
  $6668,$01 Return

  $6766,$02 Decrease #REGb by one, and loop back to #R$6740 until zero

C $671A,$02 Store #REGix on the stack
C $671C,$04 #REGix=#R$5D00
  $67C0,$02 Decrease #REGb by one, and loop back to #R$67B1 until zero

w $67C3 Collectables Sprite Table
E $67C3 View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #LUNARJETMAN$BAC0 }
. { #PSSST$761A }
. { #TRANZAM$0000 }
. LIST#
@ $67C3 label=CollectableSpritesTable
  $67C3,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100)(#N((#PC - $67C3) / $02)) #COLLECTABLENAME((#PC - $67C3) / 2).
L $67C3,$02,$15

c $67ED
  $6812,$02 Decrease #REGb by one, and loop back to #R$6812 until zero
  $6818,$02 Decrease #REGb by one, and loop back to #R$6818 until zero
  $6821,$02 Decrease #REGb by one, and loop back to #R$6821 until zero
  $6828,$02 Decrease #REGb by one, and loop back to #R$6828 until zero
  $6864,$02 Decrease #REGb by one, and loop back to #R$6864 until zero
  $686A,$02 Decrease #REGb by one, and loop back to #R$686A until zero

w $690F Explosion Sprite Table
E $690F View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #LUNARJETMAN$BAC0 }
. { #PSSST$761A }
. { #TRANZAM$0000 }
. LIST#
@ $690F label=ExplosionSpritesTable
  $690F,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $690F) / 2)) #EXPLOSIONNAME((#PC - $690F) / 2).
L $690F,$02,$06

c $691B
  $6920,$03 #REGhl=$00C0
  $6923,$01 Decrease #REGhl by one
  $6928,$01 Return

  $6929,$03 #REGhl=#R$6945
  $692C,$03 #REGa=#R$5DF0

w $6945 Alien Sprite Table
E $6945 View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #LUNARJETMAN$BAC0 }
. { #PSSST$761A }
. { #TRANZAM$0000 }
. LIST#
@ $6945 label=AlienSpritesTable
  $6945,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $6945) / 2)) #ALIENNAME((#PC - $6945) / 2).
L $6945,$02,$10

c $6965
  $698B,$03 #REGhl=#R$5D88
  $698E,$03 Push #REGhl to $69B5
  $6991,$02 #REGa=$3A
  $6993,$03 Push #REGa to #R$69D3
  $6996,$03 #REGhl=$0244
  $6999,$03 Push #REGhl to $69D4
  $699C,$01 Return

  $6A00,$03 #REGhl=#R$5D50
  $6A03,$02 #REGb=$06
  $6A05,$03 #REGde=$0008
  $6A08,$01 #REGa=(#REGhl)
  $6A09,$01
  $6A0A,$03 If zero jump back to #R$6A19
  $6A0D,$01 Add #REGde to #REGhl

  $6A0E,$02 Decrease #REGb by one, and loop back to #R$6A08 until zero

  $6A16,$03 Jump to #R$6345

C $6DD6,$03 #REGhl=$5DCB

  $6E98,$02 Decrease #REGb by one, and loop back to #R$6E5A until zero
  $6EAE,$02 Decrease #REGb by one, and loop back to #R$6EA8 until zero
  $6EB9,$02 Decrease #REGb by one, and loop back to #R$6EB6 until zero
  $6ED7,$02 Decrease #REGb by one, and loop back to #R$6ED1 until zero
  $6EF1,$02 Decrease #REGb by one, and loop back to #R$6EDC until zero

C $6EFA,$03 #REGa=#R$5DF0
  $6F91,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)

  $6FA4,$02 Decrease #REGb by one, and loop back to #R$6F9F until zero
  $6FCB,$02 Decrease #REGb by one, and loop back to #R$6FC9 until zero

  $706E,$03 #REGa=(IX+$06) #R$5D0E

C $70A4,$03 #REGhl=$0040
  $70A7,$03 Call the routine at #R$7308
  $70AA,$03 Call the routine at #R$70E3


b $70DB Lives UDG
D $70DB The graphic for the lives icon
B $70DB #UDG#(#PC),attr=7
@ $70DB label=UDG_LIVES

c $70E3 Lives left for active player
@ $70E3 label=ACTIVE_PLAYER_LIVES
D $70E3 Loads the number of lives left for the active player into #REGa.
C $70E3,$04 Evaluate #R$5DD1
  $70E7,$02 Jump to #R$70ED if 2UP is active player
  $70E9,$03 #REGa=#R$5DF1
@ $70E9 label=1UP_PLAYER_LIVES
  $70EC,$01 Return
  $70ED,$03 #REGa=#R$5DF9
@ $70ED label=2UP_PLAYER_LIVES
  $70F0,$01 Return

  $70F1,$04 Evaluate #R$5DD1
@ $70F1 label=INACTIVE_PLAYER_LIVES
  $70F5,$02 Jump to #R$70ED if 1UP is active player
  $70F7,$02 Jump to #R$70E9

  $70F9,$04 Evaluate #R$5DD1
  $70FD,$02 Jump to #R$7104 if 2UP is active player

  $70FF,$03 #REGhl=#R$5CF6
  $7102,$02 Jump forward to #R$7107
  $7104,$03 #REGhl=#R$5CF9
  $7107,$01 #REGa=#REGhl
  $7115,$01 Writes #REGa to the memory location currently in #REGhl
  $7116,$04 Evaluate #R$5DD1
  $711A,$02 Jump to #R$7124 if 2UP is active player

c $711C Scoring Display Routines
N $711C Point to Player 1 score and display
C $711C,$03 #REGhl=Screen location for output
@ $711C label=DISPLAY_1UP_SCORE
  $711F,$03 #REGde=#R$5CF4
  $7122 Generate scores and output to screen
N $7124 Point to Player 2 score and display
C $7124,$03 #REGhl=Screen location for output
@ $7124 label=DISPLAY_2UP_SCORE
  $7127,$03 #REGde=#R$5CF7
  $712A Generate scores and output to screen
N $712C Point to Highscore and display
C $712C,$03 #REGhl=Screen location for output
@ $712C label=DISPLAY_HIGHSCORE
  $712F,$03 #REGde=#R$5CF0
N $7132 Display routine
C $7132,$02 #REGb=3
@ $7132 label=DISPLAY_SCORE
  $7134,$01 #REGa=Loads the accumulator with the contents of #REGde
@ $7134 label=DISPLAY_SCORE_LOOP
  $7135,$04 #REGa=Shift 4 bits to the right
  $7139,$02
  $713B,$02 Adds $30 to #REGa
  $713D,$03 Call routine @#R$714C
  $7140,$01 Loads #REGa with the contents of the memory location held by #REGde
  $7141,$02
  $7143,$02 Adds $30 to #REGa
  $7145,$03 Call routine @#R$714C
  $7148,$01 Increments #REGde by one
  $7149,$02 Decrease #REGb by one, and loop back to #R$7134 until zero
  $714B,$01 Return

  $714C,$03 Push #REGbc, #REGde and #REGhl onto the stack
  $714F,$01 #REGl=#REGa
  $7150,$02 #REGh=$00
  $7152,$03 Add #REGhl to itself 3 times
  $7155,$04 #HTML(#REGde=<a href="https://skoolkid.github.io/rom/asm/5C36.html">CHARS</a>.)
  $7159,$01 Add #REGde to #REGhl
  $715A,$01 Exchanges #REGhl with #REGde
  $715B,$01 Fetch #REGhl off the stack
  $715C,$02 #REGb=$08

  $7162,$02 Decrease #REGb by one, and loop back to #R$715E until zero
  $7164,$02 Fetch #REGde and #REGbc back off the stack
  $716B,$01 Return

  $7178,$01 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $7179,$01
  $7191,$01 Return

c $7192
@ $7192 label=SCORE_LABELS
C $7192,$03 #REGhl=$0018
  $7195,$03 #REGde=$71AD

  $719B,$03 #REGhl=$0078
  $719E,$03 #REGde=$71B5

  $71A4,$03 #REGhl=$00D8
  $71A7,$03 #REGde=$71B1

c $71B8
D $71B8 Clears the screen
@ $71B8 label=CLEAR_PIXELS
C $71B8,$03 #REGhl=Start of the screen buffer
C $71BB,$02 #REGb=$58
C $71BD,$02 #REGc=0
C $71BF,$01 Send #REGc (0) to #REGhl (clearing the screen)
C $71C0,$01
C $71C1,$04 Loop back when #REGh=#REGb (i.e. when #REGhl reaches $5800)
C $71C5,$01 Return

N $71C6 Reset the screen colours
@ $71C6 label=CLEAR_ATTRIBUTES
C $71C6,$03 #REGhl=Start of the attribute buffer
C $71C9,$02 #REGb=$5B End of the attribute space
C $71CB,$02 #REGc=$47
C $71CD,$02 Runs the #R$71BF loop again to set all the attributes to #REGc ($47=PAPER:Black;INK:While;BRIGHT)
  $71FE,$02 Decrease #REGb by one, and loop back to #R$71EA until zero

@ $7327 label=MOVE_JETMAN_POS
C $7327,$06 Copy #R$5D01 to $5DC0
C $732D,$06 Copy #R$5D02 to $5DC1
C $7333,$06 Copy #R$5D00 to $5DC2
C $7339,$01 Return
  $738B,$02 Decrease #REGb by one, and loop back to #R$737F until zero
  $73AA,$02 Decrease #REGb by one, and loop back to #R$739E until zero
  $7445,$02 Decrease #REGb by one, and loop back to #R$7439 until zero
  $766A,$02 Decrease #REGb by one, and loop back to #R$7622 until zero
  $76A1,$02 Decrease #REGb by one, and loop back to #R$769E until zero
  $76CC,$02 Decrease #REGb by one, and loop back to #R$76CA until zero
  $76D8,$02 Decrease #REGb by one, and loop back to #R$7672 until zero

b $76E2 Platform Graphics
@ $76E2 label=PLATFORM
D $76E2 Middle section repeats for both floor and platforms
N $76E2 #UDGARRAY6,attr=4,scale=4;(#PC);(#PC+$08)x4;(#PC+$10)(platform)
N $76E2 #UDGARRAY6,attr=6,scale=4;(#PC);(#PC+$08)x2;(#PC+$10)(floor)
N $76E2 Left-hand Platform UDG
B $76E2 #UDG#(#PC),attr=4
N $76EA Middle Platform UDG
B $76EA #UDG#(#PC),attr=4
N $76F2 Right-hand Platform UDG
B $76F2 #UDG#(#PC),attr=4

w $76FA Jetman Sprite Table
E $76FA View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #LUNARJETMAN$BAC0 }
. { #PSSST$761A }
. { #TRANZAM$0000 }
. LIST#
@ $76FA label=JetmanSpritesTable
  $76FA,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $76FA) / 2)).
L $76FA,$02,$10

w $771A

c $7758

b $7796 JetMan Graphics
N $7796 Flying Frame Right 1
  $7796,$01 Terminator.
  $7797,$01 Width = #N(#PEEK(#PC)) bytes.
  $7798,$01 Height = #N(#PEEK(#PC)) pixels.
  $7799 #JETMAN$00(fly-r-1)

N $77C9 Flying Frame Right 2
  $77C9,$01 Terminator.
  $77CA,$01 Width = #N(#PEEK(#PC)) bytes.
  $77CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $77CC #JETMAN$01(fly-r-2)

N $7814 Flying Frame Right 3
  $7814,$01 Terminator.
  $7815,$01 Width = #N(#PEEK(#PC)) bytes.
  $7816,$01 Height = #N(#PEEK(#PC)) pixels.
  $7817 #JETMAN$02(fly-r-3)

N $785F Flying Frame Right 4
  $785F,$01 Terminator.
  $7860,$01 Width = #N(#PEEK(#PC)) bytes.
  $7861,$01 Height = #N(#PEEK(#PC)) pixels.
  $7862 #JETMAN$03(fly-r-4)

N $78AA Flying Frame Left 1
  $78AA,$01 Terminator.
  $78AB,$01 Width = #N(#PEEK(#PC)) bytes.
  $78AC,$01 Height = #N(#PEEK(#PC)) pixels.
  $78AD #JETMAN$07(fly-l-1)

N $78DD Flying Frame Left 2
  $78DD,$01 Terminator.
  $78DE,$01 Width = #N(#PEEK(#PC)) bytes.
  $78DF,$01 Height = #N(#PEEK(#PC)) pixels.
  $78E0 #JETMAN$06(fly-l-2)

N $7910 Flying Frame Left 3
  $7910,$01 Terminator.
  $7911,$01 Width = #N(#PEEK(#PC)) bytes.
  $7912,$01 Height = #N(#PEEK(#PC)) pixels.
  $7913 #JETMAN$05(fly-l-3)

N $795B Flying Frame Left 4
  $795B,$01 Terminator.
  $795C,$01 Width = #N(#PEEK(#PC)) bytes.
  $795D,$01 Height = #N(#PEEK(#PC)) pixels.
  $795E #JETMAN$04(fly-l-4)

N $79A6 Walking Frame Left 1
  $79A6,$01 Terminator.
  $79A7,$01 Width = #N(#PEEK(#PC)) bytes.
  $79A8,$01 Height = #N(#PEEK(#PC)) pixels.
  $79A9 #JETMAN$0F(wlk-l-1)

N $79D9 Walking Frame Left 2
  $79D9,$01 Terminator.
  $79DA,$01 Width = #N(#PEEK(#PC)) bytes.
  $79DB,$01 Height = #N(#PEEK(#PC)) pixels.
  $79DC #JETMAN$0E(wlk-l-2)

N $7A0C Walking Frame Left 3
  $7A0C,$01 Terminator.
  $7A0D,$01 Width = #N(#PEEK(#PC)) bytes.
  $7A0E,$01 Height = #N(#PEEK(#PC)) pixels.
  $7A0F #JETMAN$0D(wlk-l-3)

N $7A57 Walking Frame Left 4
  $7A57,$01 Terminator.
  $7A58,$01 Width = #N(#PEEK(#PC)) bytes.
  $7A59,$01 Height = #N(#PEEK(#PC)) pixels.
  $7A5A #JETMAN$0C(wlk-l-4)

N $7AA2 Walking Frame Right 1
  $7AA2,$01 Terminator.
  $7AA3,$01 Width = #N(#PEEK(#PC)) bytes.
  $7AA4,$01 Height = #N(#PEEK(#PC)) pixels.
  $7AA5 #JETMAN$08(wlk-r-1)

N $7AD5 Walking Frame Right 2
  $7AD5,$01 Terminator.
  $7AD6,$01 Width = #N(#PEEK(#PC)) bytes.
  $7AD7,$01 Height = #N(#PEEK(#PC)) pixels.
  $7AD8 #JETMAN$09(wlk-r-2)

N $7B08 Walking Frame Right 3
  $7B08,$01 Terminator.
  $7B09,$01 Width = #N(#PEEK(#PC)) bytes.
  $7B0A,$01 Height = #N(#PEEK(#PC)) pixels.
  $7B0B #JETMAN$0A(wlk-r-3)

N $7B53 Walking Frame Right 4
  $7B53,$01 Terminator.
  $7B54,$01 Width = #N(#PEEK(#PC)) bytes.
  $7B55,$01 Height = #N(#PEEK(#PC)) pixels.
  $7B56 #JETMAN$0B(wlk-r-4)

b $7B9E Round 1 Alien Graphics
E $7B9E #UDGARRAY*round-1-1,50;round-1-2(round-1-frames)
N $7B9E Frame 1
  $7B9E,$01 Height = #N(#PEEK(#PC)) pixels.
  $7B9F,$16,b$02 #ALIEN$00(round-1-1*)
N $7BB5 Frame 2
  $7BB5,$01 Height = #N(#PEEK(#PC)) pixels.
  $7BB6,$16,b$02 #ALIEN$01(round-1-2*)

b $7BCC Explosion Frames
E $7BCC #UDGARRAY*exp-01,50;exp-02;exp-03(explosion)
N $7BCC Small.
  $7BCC,$01 Terminator.
  $7BCD,$01 Width = #N(#PEEK(#PC)) bytes.
  $7BCE,$01 Height = #N(#PEEK(#PC)) pixels.
  $7BCF,$30,b$03 #EXPLOSION$00(exp-01*)

N $7BFF Medium.
  $7BFF,$01 Terminator.
  $7C00,$01 Width = #N(#PEEK(#PC)) bytes.
  $7C01,$01 Height = #N(#PEEK(#PC)) pixels.
  $7C02,$30,b$03 #EXPLOSION$01(exp-02*)

N $7C32 Large.
  $7C32,$01 Terminator.
  $7C33,$01 Width = #N(#PEEK(#PC)) bytes.
  $7C34,$01 Height = #N(#PEEK(#PC)) pixels.
  $7C35,$30,b$03 #EXPLOSION$02(exp-03*)

b $7C65 Ship U3
N $7C65 #SHIP(ship-u3)
N $7C65 Bottom.
  $7C65,$01 Terminator.
  $7C66,$01 Width = #N(#PEEK(#PC)) bytes.
  $7C67,$01 Height = #N(#PEEK(#PC)) pixels.
  $7C68,$20,b$02 #COLLECTABLE$02(ship-u3-1)

N $7C88 Middle.
  $7C88,$01 Terminator.
  $7C89,$01 Width = #N(#PEEK(#PC)) bytes.
  $7C8A,$01 Height = #N(#PEEK(#PC)) pixels.
  $7C8B,$20,b$02 #COLLECTABLE$06(ship-u3-2)

N $7CAB Top.
  $7CAB,$01 Terminator.
  $7CAC,$01 Width = #N(#PEEK(#PC)) bytes.
  $7CAD,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CAE,$20,b$02 #COLLECTABLE$0A(ship-u3-3)

b $7CCE Ship U1
N $7CCE #SHIP(ship-u1)
N $7CCE Bottom.
  $7CCE,$01 Terminator.
  $7CCF,$01 Width = #N(#PEEK(#PC)) bytes.
  $7CD0,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CD1,$20,b$02 #COLLECTABLE$00(ship-u1-1)

N $7CF1 Middle.
  $7CF1,$01 Terminator.
  $7CF2,$01 Width = #N(#PEEK(#PC)) bytes.
  $7CF3,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CF4,$20,b$02 #COLLECTABLE$04(ship-u1-2)

N $7D14 Top.
  $7D14,$01 Terminator.
  $7D15,$01 Width = #N(#PEEK(#PC)) bytes.
  $7D16,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D17,$20,b$02 #COLLECTABLE$08(ship-u1-3)

b $7D37 Ship U2
N $7D37 #SHIP(ship-u2)
N $7D37 Bottom.
  $7D37,$01 Terminator.
  $7D38,$01 Width = #N(#PEEK(#PC)) bytes.
  $7D39,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D3A,$20,b$02 #COLLECTABLE$01(ship-u2-1)

N $7D5A Middle.
  $7D5A,$01 Terminator.
  $7D5B,$01 Width = #N(#PEEK(#PC)) bytes.
  $7D5C,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D5D,$20,b$02 #COLLECTABLE$05(ship-u2-2)

N $7D7D Top.
  $7D7D,$01 Terminator.
  $7D7E,$01 Width = #N(#PEEK(#PC)) bytes.
  $7D7F,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D80,$20,b$02 #COLLECTABLE$09(ship-u2-3)

b $7DA0 Ship U4
N $7DA0 #SHIP(ship-u4)
N $7DA0 Bottom.
  $7DA0,$01 Terminator.
  $7DA1,$01 Width = #N(#PEEK(#PC)) bytes.
  $7DA2,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DA3,$20,b$02 #COLLECTABLE$03(ship-u4-1)

N $7DC3 Middle.
  $7DC3,$01 Terminator.
  $7DC4,$01 Width = #N(#PEEK(#PC)) bytes.
  $7DC5,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DC6,$20,b$02 #COLLECTABLE$07(ship-u4-2)

N $7DE6 Top.
  $7DE6,$01 Terminator.
  $7DE7,$01 Width = #N(#PEEK(#PC)) bytes.
  $7DE8,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DE9,$20,b$02 #COLLECTABLE$0B(ship-u4-3)

b $7E09 Sprite: Gold Bar
  $7E09,$01 Terminator.
  $7E0A,$01 Width = #N(#PEEK(#PC)) bytes.
  $7E0B,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E0C,$10,b$02 #COLLECTABLE$10(gold-bar)

b $7E1C Sprite: Fuel Pod
  $7E1C,$01 Terminator.
  $7E1D,$01 Width = #N(#PEEK(#PC)) bytes.
  $7E1E,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E1F,$16,b$02 #COLLECTABLE$0C(fuel)

b $7E35 Sprite: Plutonium
  $7E35,$01 Terminator.
  $7E36,$01 Width = #N(#PEEK(#PC)) bytes.
  $7E37,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E38,$16,b$02 #COLLECTABLE$11(plutonium)

b $7E4E Sprite: Isotope
  $7E4E,$01 Terminator.
  $7E4F,$01 Width = #N(#PEEK(#PC)) bytes.
  $7E50,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E51,$1A,b$02 #COLLECTABLE$12(isotope)

b $7E6B Sprite: Mineral
  $7E6B,$01 Terminator.
  $7E6C,$01 Width = #N(#PEEK(#PC)) bytes.
  $7E6D,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E6E,$12,b$02 #COLLECTABLE$13(mineral)

b $7E80 Sprite: Gemstone
  $7E80,$01 Terminator.
  $7E81,$01 Width = #N(#PEEK(#PC)) bytes.
  $7E82,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E83,$18,b$02 #COLLECTABLE$14(gemstone)

b $7E9B Round 2 Alien Graphics
E $7E9B #UDGARRAY*round-2-1,50;round-2-2(round-2-frames)
N $7E9B Frame 1
  $7E9B,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E9C,$1C,b$02 #ALIEN$02(round-2-1*)
N $7EB8 Frame 2
  $7EB8,$01 Height = #N(#PEEK(#PC)) pixels.
  $7EB9,$1C,b$02 #ALIEN$03(round-2-2*)

b $7ED5 Round 4 Alien Graphics
  $7ED5,$01 Height = #N(#PEEK(#PC)) pixels.
  $7ED6,$0E,b$02 #ALIEN$06(round-4-1)

b $7EE4 Round 5 Alien Graphics
  $7EE4,$01 Height = #N(#PEEK(#PC)) pixels.
  $7EE5,$10,b$02 #ALIEN$08(round-5-1)

b $7EF5 Round 3 Alien Graphics
E $7EF5 #UDGARRAY*round-3-1,50;round-3-2(round-3-frames)
N $7EF5 Frame 1
  $7EF5,$01 Height = #N(#PEEK(#PC)) pixels.
  $7EF6,$20,b$02 #ALIEN$04(round-3-1*)

N $7F16 Frame 2
  $7F16,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F17,$1C,b$02 #ALIEN$05(round-3-2*)

b $7F33 Round 6 Alien Graphics
  $7F33,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F34,$1E,b$02 #ALIEN$0A(round-6-1)

b $7F52 Round 7 Alien Graphics
  $7F52,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F53,$1C,b$02 #ALIEN$0C(round-7-1)

b $7F6F Round 8 Alien Graphics
  $7F6F,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F70,$1C,b$02 #ALIEN$0E(round-8-1)

b $7F8C Flame Graphics
E $7F8C #UDGTABLE(ships,centre,centre,centre,centre)
. {
.   #UDGARRAY#($02,attr=$07,scale=$04,step=$02,flip=2#FOR($03,$49,$23)(n,;($7CCE+n)-($7CCE+n+$11)-$01-$10))(ship-u1-flame)  |
.   #UDGARRAY#($02,attr=$07,scale=$04,step=$02,flip=2#FOR($03,$49,$23)(n,;($7D37+n)-($7D37+n+$11)-$01-$10))(ship-u2-flame)  |
.   #UDGARRAY#($02,attr=$07,scale=$04,step=$02,flip=2#FOR($03,$49,$23)(n,;($7C65+n)-($7C65+n+$11)-$01-$10))(ship-u3-flame)  |
.   #UDGARRAY#($02,attr=$07,scale=$04,step=$02,flip=2#FOR($03,$49,$23)(n,;($7DA0+n)-($7DA0+n+$11)-$01-$10))(ship-u4-flame)
. }
. { #UDGARRAY*flame-1,50;flame-2(frame-frames)  | #UDGARRAY*flame-1,50;flame-2(frame-frames)  | #UDGARRAY*flame-1,50;flame-2(frame-frames)  | #UDGARRAY*flame-1,50;flame-2(frame-frames) }
. UDGTABLE#
N $7F8C Flame Frame 1
  $7F8C,$01 Terminator.
  $7F8D,$01 Width = #N(#PEEK(#PC)) bytes.
  $7F8E,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F8F,$1E,b$02 #UDGARRAY$02,attr=$02,scale=$04,step=$02,flip=$02;(#PC)-(#PC+$11)-$01-$10{0,($10-#PEEK(#PC-$01))*$04,$10*$04,#PEEK(#PC-$01)*$04}(flame-1*)

S $7FAD,$02
N $7FAF Flame Frame 2
  $7FAF,$01 Terminator.
  $7FB0,$01 Width = #N(#PEEK(#PC)) bytes.
  $7FB1,$01 Height = #N(#PEEK(#PC)) pixels.
  $7FB2,$1E,b$02 #UDGARRAY$02,attr=$02,scale=$04,step=$02,flip=$02;(#PC)-(#PC+$11)-$01-$10{0,($10-#PEEK(#PC-$01))*$04,$10*$04,#PEEK(#PC-$01)*$04}(flame-2*)

t $7FD0 Copyright Messaging
@ $7FD0 label=Message_Copyright2
  $7FD0,$2C,h$01,c$01,$29:$01 COPYRIGHT 1983 A.C.G. ALL RIGHTS RESERVED
S $7FFC,$04
i $8000
