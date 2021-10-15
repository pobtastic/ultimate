> $4000 @org=$4000
b $4000 Loading screen
D $4000 #UDGTABLE { #SCR(loading) | JetPac Loading Screen. } TABLE#
@ $4000 label=LOADING
B $4000,6144,32 Pixels
B $5800,768,32 Attributes

i $5B00
S $5B00
@ $5B01 start
@ $5B01 org
@ $5B01 replace=/#SPRITE2x2,\i/#UDGARRAY2,attr=\1,scale=4,step=2,flip=2;(#PC)-(#PC+$11)-$01-$10
@ $5B01 replace=/#SPRITE2x3,\i/#UDGARRAY2,attr=\1,scale=4,step=2,flip=2;(#PC)-(#PC+$21)-$01-$10
; This is currently unused.
@ $5B01 replace=/#SPRITE3x1,\i/#UDGARRAY3,attr=\1,scale=4,step=2,flip=2;(#PC)-(#PC+$02)
@ $5B01 replace=/#SPRITE3x2,\i/#UDGARRAY3,attr=\1,scale=4,step=3,flip=2;(#PC)-(#PC+$1A)-$01-$18
@ $5B01 replace=/#SPRITE3x3,\i/#UDGARRAY3,attr=\1,scale=4,step=3,flip=2;(#PC)-(#PC+$32)-$01-$18
@ $5B01 replace=/#SHIP/#UDGARRAY#(2,attr=7,scale=4,step=2,flip=2#FOR($03,$49,$23)(n,;(#PC+n)-(#PC+n+$11)-$01-$10))
@ $5B01 replace=/#ITEM,\i/#UDGARRAY2,attr=\1,scale=4,step=2,mask=1,flip=2;(#PC)-(#PC+$11)-$01-$10{0,($10-#PEEK(#PC-1))*4,$10*4,#PEEK(#PC-1)*4}
@ $5B01 replace=/#DIMENSIONS/Dimensions #PEEK(#PC+1) bytes x #EVAL(#PEEK(#PC+2),10,2) pixels
b $5B01

c $5B80 Game entry point
@ $5B80 label=GameEntry
  $5B80,$0B Moves #N$2000 bytes from #N$6004 to #N$6000.
  $5B8B,$03 Jump to #R$61E5.

g $5C36 ????

g $5C78 Frame Counter
@ $5C78 label=FRAME_COUNTER

b $5C79

g $5CF0 High Score
@ $5CF0 label=HIGH_SCORE
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
. { $00 | #SPACE(1)     | #SPACE(1) | None  | #EVAL($00,2,8) }
. { $01 | #SPACE(1)     | X         | Right | #EVAL($01,2,8) }
. { $41 | #SPACE(1)     | X         | Left  | #EVAL($41,2,8) }
. { $82 | X             | #SPACE(1) | Right | #EVAL($82,2,8) }
. { $C2 | X             | #SPACE(1) | Left  | #EVAL($C2,2,8) }
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
. { $00 | Invisible/ None             | #EVAL($00,2,8) }
. { $01 | Falling (from the sky)      | #EVAL($01,2,8) }
. { $03 | Collected (i.e. "attached") | #EVAL($03,2,8) }
. { $07 | Falling (can't recollect)   | #EVAL($07,2,8) }
. TABLE#

g $5D3D PARAM14
g $5D3E PARAM15
g $5D3F PARAM16

g $5D40 Item visibility
@ $5D40 label=ITEM_VISIBILITY
D $5D40 $00 when not on screen, $0e when visible
B $5D40 $00 (#EVAL($00,2,8)) when not on screen, $0e (#EVAL($0e,2,8)) when visible

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
B $6019,17,1

b $602A

b $6038
B $6038,8

T $6042,31,30:1 1983 A.C.G. ALL RIGHTS RESERVED
T $6061,42 COPYRIGHT 1983 A.C.G. ALL RIGHTS RESERVED

c $608A
@ $608A label=LEVEL_INIT
C $608A,3 Black Border
  $608D,3 Clear the screen
  $6090,3 Reset the screen colours
  $6093,3 Display score labels
  $6096,3 Attribute file address
  $6099,3 #REGb=loop counter, #REGc=Cyan/Yellow
  $609C,1 Reset bytes in the attribute file
  $609E,2 Decrease #REGb by one, jump to #R$609C if not zero
  $60A0,3 Update display with player 1 score
  $60A3,3 Update display with player 2 score
  $60A6,3 Update display with high score
  $60A9,3 #REGa=#R$5DF0
  $60AC,4 If #R$5DF0 is divisible by $03 ... jump to init with a "broken ship"
  $60B3,4 Increase the live counter #R$5DF1 by one
  $60C6,3 #REGa=#R$5C78
  $60C9,3 Write #REGa to #R$5DD4
  $60CC,1 Return

C $60CD,3 #REGhl Source address: #R$6018
  $60D0,3 #REGde Target address: #R$5D30
  $60D3,3 #REGbc=loop counter
  $60D6,2 Action! Copy source to target, decrease counter, repeat until zero
  $60D8,2 #REGa=$08
  $60DA,3 Jump to #R$6EF9

C $6103,3 #REGa=#R$5DF9

  $6146,2 Decrease #REGb by one, jump to #R$6141 if not zero

C $616A,3 #REGhl=#R$5DF0
  $616D,3 #REGde=#R$5DF8
  $6170,2 #REGb=$02
  $6172,3
  $6175,3 #REGhl=#R$5D30
  $6178,3 #REGde=#R$5D98
  $617B,2 #REGb=$18
  $617D,1 #REGa=#REGde
  $617E,1 #REGc=#REGhl
  $617F,1 Writes #REGa to #REGhl
  $6180,1 #REGa=#REGc
  $6181,1 Writes #REGa to #REGde
  $6182,1 Increase #REGhl by one
  $6183,1 Increase #REGde by one
  $6184,2 Decrease #REGb by one, jump to #R$617D if not zero
  $6186,1 Return
B $6187,1
T $6188,$12,$11:1 GAME OVER PLAYER 1

C $619A,3 #REGhl Source address: #R$6010
  $619D,3 #REGde Target address: #R$5D00
  $61A0,3 #REGbc=loop counter
  $61A3,2 Action! Copy source to target, decrease counter, repeat until zero
  $61A5,2 #REGa=$80
  $61A7,7 if bit 0 is set for #R$5CF3 (is this a 2UP game) then jump to #R$61B0
  $61AE,5 Add $7F to #REGa and update #R$5DD7 with the result
  $61B3,7 Decrease #R$5DF1 by 1
  $61BA,3 Jump to #R$70A4

  $61BD,3 #REGa=#R$5DD1
  $61C0,1
  $61C1,2
  $61C3,3 #REGhl=$0018
  $61C6,3
  $61C9,2 #REGb=$03
  $61CB,1 #REGa=(#REGhl)
  $61CC,2
  $61CE,1 Push #REGa into the memory location at #REGhl
  $61CF,1 Increase #REGhl by one
  $61D0,2 Decrease #REGb by one, jump to #R$61CB if not zero
  $61D2,1 Return

  $61DD,2 Decrease #REGb by one, jump to #R$61D8 if not zero

c $61E5 Security Check
@ $61E5 label=SecurityCheck
  $61E5,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $61E8,$03 Return if #REGa is not #N$83.

  $61F5,$01 Disable interrupts.

  $6260,3 #REGde=$628D
  $6263,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $6264,3 #REGhl=#R$6293
  $6267,3 #REGde=#R$6299
  $626A,2 #REGb=$06
  $626C,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
@ $626C label=PRINT_START_SCREEN
  $626D,1 #REGa=#R$6299
  $626E,3 Write #REGa to #R$5DD6
  $6271,1 Point to next character
  $6272,1 Exchange back #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $6273,1 Push #REGbc onto the stack
  $6274,1 #REGa=(#REGhl)
  $6275,1 Increment #REGhl
  $6276,1 Push #REGhl onto the stack

  $6281,2 Decrease #REGb by one, jump to #R$626C if not zero

g $6293 LOOKING

b $6299 Start Screen
@ $6299 label=START_SCREEN
T $6299,$15,$14:1 JETPAC GAME SELECTION
T $62AE,$11,$10:1 1#SPACE(3)1 PLAYER GAME
T $62BF,$11,$10:1 2#SPACE(3)2 PLAYER GAME
T $62D0,$0C,$0B:1 3#SPACE(3)KEYBOARD
T $62DC,$15,$14:1 4#SPACE(3)KEMPSTON JOYSTICK
T $62F1,$0E,$0D:1 5#SPACE(3)START GAME

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
C $630F,2 #REGb=$02
  $6311,1 Stores #REGbc on the stack
C $6312,1 Clear #REGa (sets to $00)
C $6313,3 #R$5DF0=#REGa
  $6316,2 #REGa=Number of lives for 1UP on starting a game
  $6318,3 Updates #R$5DF1 with the number of starting lives
  $6322,2 Decrease #REGb by one, jump to #R$6311 if not zero
  $6324,2 #REGa=Number of lives for 2UP on starting a game
  $6326,3 Updates #R$5DF9 with the number of starting lives
  $6329,3 #REGa=#R$5CF3
  $632C,3 Return if this is a 2UP game

  $632F,3 Sets #R$5DF9 to zero (as a 1UP game is in progress)
  $6332,1 Return

  $6333,3 #REGhl=#R$5CF4
  $6336,3 #REGbc=#R$6000
  $6339,3

  $6345,3 Change the stack pointer to #R$5CF0
  $6348,1 Enable interrupts
  $6349,4 #REGix=#R$5D30
  $634D,1 Clear #REGa (sets to $00)
  $634E,3 Writes #REGa to #R$5DCB

  $63AC,4 #REGe=#R$5CF6

  $63B0,4 Compare #REGe with #R$5CF9
  $63B4,2 Jump if carry flag is set to #R$63D5

  $63B6,3 #REGhl=#R$5CF7
@ $63B6 label=COMPARE_2UP_SCORE
N $63B6 Tests to see if the highscore has been beaten by 2UP.
@ $63B9 label=CHECK_HIGHSCORE
  $63B9,1 Push #REGhl onto the stack (see #R$63CB)
  $63BA,3 #REGde=#R$5CF0
  $63BD,2 #REGb=$03
  $63BF,2 Compare #REGa against #R$5CF0
  $63C1,2 If it's higher, update the highscore
  $63C3,2 Jump if not zero to #R$63C9 (so if it's less than the current highscore)
  $63C5,1 Increase #REGhl by one
  $63C6,1 Increase #REGde by one
  $63C7,2 Decrease #REGb by one, jump to #R$63BF if not zero
  $63C9,1 Fetch #REGhl off the stack (to clear it)
  $63CA,1 Return

c $63CB Updates the highscore
@ $63CB label=UPDATE_HIGHSCORE
D $63CB The top of the stack will contain either #R$5CF4 or #R$5CF7. The three bytes which make up the players score are
.       copied over to the #R$5CF0 memory location.
C $63CB,1 Fetch #REGhl off the stack
  $63CC,3 #REGde Target address: #R$5CF0
  $63CF,3 #REGbc=loop counter
  $63D2,2 Action! Copy source to target, decrease counter, repeat until zero
  $63D4,1 Return

C $63D5,3 #REGhl=#R$5CF4
@ $63D5 label=COMPARE_1UP_SCORE
N $63D5 Tests to see if the highscore has been beaten by 1UP.
  $63D8,2 Jump to #R$63B9

c $63DA

C $653F,6 Drop #REGix+$02 (fuel Y co-ordinate) by two pixels

C $65CE,3 #REGa=(#REGix+$02) (fuel Y co-ordinate)
C $65D1,2 Is #REGa=$B0? (has the fuel reached the ship yet?)
C $65D3,3 If not, jump back to #R$653F
C $65D6,7 Fuel pod deposited correctly; increase #R$5D35 by one
C $65DD,2 Jump to #R$65C4
C $65DF,6 If #R$5D00 is &$3F then return...
C $65E5,3 Return if #R$5D00 is greater than (or equal to) $03

C $65E8,3 #REGhl Source address: $6038
C $65EB,3 #REGde Target address: #R$5D40
C $65EE,3 #REGbc=loop counter
C $65F1,1 #REGa=(#REGde)
  $65FA,2 Action! Copy source to target, decrease counter, repeat until zero

  $6639,3 #REGhl=$6030
  $663C,3 #REGde=#R$5D38
  $663F,3 #REGbc=$0008
  $6642,1 #REGa=(#REGde)
  $6645,5 Check if #R$5D35 is $06? Is the ship full of fuel?

  $665A,1 Return

  $665B,3 #REGhl=#R$5D38
  $665E,2 #REGb=$0C
  $6660,3 #REGde=$0008
  $6663,2 Reset the memory held at location #REGhl (set to $00)
  $6665,1 Increase #REGhl by $08
  $6666,2 Decrease #REGb by one, and loop back to #R$6663 until zero
  $6668,1 Return

  $6766,2 Decrease #REGb by one, and loop back to #R$6740 until zero

C $671A,2 Store #REGix on the stack
C $671C,4 #REGix=#R$5D00
  $67C0,2 Decrease #REGb by one, and loop back to #R$67B1 until zero

  $6812,2 Decrease #REGb by one, and loop back to #R$6812 until zero
  $6818,2 Decrease #REGb by one, and loop back to #R$6818 until zero
  $6821,2 Decrease #REGb by one, and loop back to #R$6821 until zero
  $6828,2 Decrease #REGb by one, and loop back to #R$6828 until zero
  $6864,2 Decrease #REGb by one, and loop back to #R$6864 until zero
  $686A,2 Decrease #REGb by one, and loop back to #R$686A until zero

C $6920,3 #REGhl=$00C0
  $6923,1 Decrease #REGhl by one
  $6928,1 Return

  $6929,3 #REGhl=#R$6945
  $692C,3 #REGa=#R$5DF0
  $6938

  $698B,3 #REGhl=#R$5D88
  $698E,3 Push #REGhl to $69B5
  $6991,2 #REGa=$3A
  $6993,3 Push #REGa to #R$69D3
  $6996,3 #REGhl=$0244
  $6999,3 Push #REGhl to $69D4
  $699C,1 Return

  $6A00,3 #REGhl=#R$5D50
  $6A03,2 #REGb=$06
  $6A05,3 #REGde=$0008
  $6A08,1 #REGa=(#REGhl)
  $6A09,1
  $6A0A,3 If zero jump back to #R$6A19
  $6A0D,1 Add #REGde to #REGhl

  $6A0E,2 Decrease #REGb by one, and loop back to #R$6A08 until zero

  $6A16,3 Jump to #R$6345

C $6DD6,3 #REGhl=$5DCB

  $6E98,2 Decrease #REGb by one, and loop back to #R$6E5A until zero
  $6EAE,2 Decrease #REGb by one, and loop back to #R$6EA8 until zero
  $6EB9,2 Decrease #REGb by one, and loop back to #R$6EB6 until zero
  $6ED7,2 Decrease #REGb by one, and loop back to #R$6ED1 until zero
  $6EF1,2 Decrease #REGb by one, and loop back to #R$6EDC until zero

C $6EFA,3 #REGa=#R$5DF0
  $6F91,3 #REGa=#R$5C78

  $6FA4,2 Decrease #REGb by one, and loop back to #R$6F9F until zero
  $6FCB,2 Decrease #REGb by one, and loop back to #R$6FC9 until zero

  $706E,3 #REGa=(IX+$06) #R$5D0E

C $70A4,3 #REGhl=$0040
  $70A7,3 Call the routine at #R$7308
  $70AA,3 Call the routine at #R$70E3


b $70DB Lives UDG
D $70DB The graphic for the lives icon
B $70DB #UDG#(#PC),attr=7
@ $70DB label=UDG_LIVES

c $70E3 Lives left for active player
@ $70E3 label=ACTIVE_PLAYER_LIVES
D $70E3 Loads the number of lives left for the active player into #REGa.
C $70E3,4 Evaluate #R$5DD1
  $70E7,2 Jump to #R$70ED if 2UP is active player
  $70E9,3 #REGa=#R$5DF1
@ $70E9 label=1UP_PLAYER_LIVES
  $70EC,1 Return
  $70ED,3 #REGa=#R$5DF9
@ $70ED label=2UP_PLAYER_LIVES
  $70F0,1 Return

  $70F1,4 Evaluate #R$5DD1
@ $70F1 label=INACTIVE_PLAYER_LIVES
  $70F5,2 Jump to #R$70ED if 1UP is active player
  $70F7,2 Jump to #R$70E9

  $70F9,4 Evaluate #R$5DD1
  $70FD,2 Jump to #R$7104 if 2UP is active player

  $70FF,3 #REGhl=#R$5CF6
  $7102,2 Jump forward to #R$7107
  $7104,3 #REGhl=#R$5CF9
  $7107,1 #REGa=#REGhl
  $7115,1 Writes #REGa to the memory location currently in #REGhl
  $7116,4 Evaluate #R$5DD1
  $711A,2 Jump to #R$7124 if 2UP is active player

c $711C Scoring Display Routines
N $711C Point to Player 1 score and display
C $711C,3 #REGhl=Screen location for output
@ $711C label=DISPLAY_1UP_SCORE
  $711F,3 #REGde=#R$5CF4
  $7122 Generate scores and output to screen
N $7124 Point to Player 2 score and display
C $7124,3 #REGhl=Screen location for output
@ $7124 label=DISPLAY_2UP_SCORE
  $7127,3 #REGde=#R$5CF7
  $712A Generate scores and output to screen
N $712C Point to Highscore and display
C $712C,3 #REGhl=Screen location for output
@ $712C label=DISPLAY_HIGHSCORE
  $712F,3 #REGde=#R$5CF0
N $7132 Display routine
C $7132,2 #REGb=3
@ $7132 label=DISPLAY_SCORE
  $7134,1 #REGa=Loads the accumulator with the contents of #REGde
@ $7134 label=DISPLAY_SCORE_LOOP
  $7135,4 #REGa=Shift 4 bits to the right
  $7139,2
  $713B,2 Adds $30 to #REGa
  $713D,3 Call routine @#R$714C
  $7140,1 Loads #REGa with the contents of the memory location held by #REGde
  $7141,2
  $7143,2 Adds $30 to #REGa
  $7145,3 Call routine @#R$714C
  $7148,1 Increments #REGde by one
  $7149,2 Decrease #REGb by one, and loop back to #R$7134 until zero
  $714B,1 Return

  $714C,3 Push #REGbc, #REGde and #REGhl onto the stack
  $714F,1 #REGl=#REGa
  $7150,2 #REGh=$00
  $7152,3 Add #REGhl to itself 3 times
  $7155,4 #REGde=#R$5C36
  $7159,1 Add #REGde to #REGhl
  $715A,1 Exchanges #REGhl with #REGde
  $715B,1 Fetch #REGhl off the stack
  $715C,2 #REGb=$08

  $7162,2 Decrease #REGb by one, and loop back to #R$715E until zero
  $7164,2 Fetch #REGde and #REGbc back off the stack
  $716B,1 Return

  $7178,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $7179,1
  $7191,1 Return

c $7192
@ $7192 label=SCORE_LABELS
C $7192,3 #REGhl=$0018
  $7195,3 #REGde=$71AD

  $719B,3 #REGhl=$0078
  $719E,3 #REGde=$71B5

  $71A4,3 #REGhl=$00D8
  $71A7,3 #REGde=$71B1

c $71B8
D $71B8 Clears the screen
@ $71B8 label=CLEAR_PIXELS
C $71B8,3 #REGhl=Start of the screen buffer
C $71BB,2 #REGb=$58
C $71BD,2 #REGc=0
C $71BF,1 Send #REGc (0) to #REGhl (clearing the screen)
C $71C0,1
C $71C1,4 Loop back when #REGh=#REGb (i.e. when #REGhl reaches $5800)
C $71C5,1 Return

N $71C6 Reset the screen colours
@ $71C6 label=CLEAR_ATTRIBUTES
C $71C6,3 #REGhl=Start of the attribute buffer
C $71C9,2 #REGb=$5B End of the attribute space
C $71CB,2 #REGc=$47
C $71CD,2 Runs the #R$71BF loop again to set all the attributes to #REGc ($47=PAPER:Black;INK:While;BRIGHT)
  $71FE,2 Decrease #REGb by one, and loop back to #R$71EA until zero

@ $7327 label=MOVE_JETMAN_POS
C $7327,6 Copy #R$5D01 to $5DC0
C $732D,6 Copy #R$5D02 to $5DC1
C $7333,6 Copy #R$5D00 to $5DC2
C $7339,1 Return
  $738B,2 Decrease #REGb by one, and loop back to #R$737F until zero
  $73AA,2 Decrease #REGb by one, and loop back to #R$739E until zero
  $7445,2 Decrease #REGb by one, and loop back to #R$7439 until zero
  $766A,2 Decrease #REGb by one, and loop back to #R$7622 until zero
  $76A1,2 Decrease #REGb by one, and loop back to #R$769E until zero
  $76CC,2 Decrease #REGb by one, and loop back to #R$76CA until zero
  $76D8,2 Decrease #REGb by one, and loop back to #R$7672 until zero

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

c $76FA

b $7796 JetMan Graphics

@ $7796 label=JETMAN_FLY_R_1
N $7796 Flying Frame Right 1
N $7796 #DIMENSIONS
B $7796,1 terminator
  $7797,1 width = #PEEK(#PC) bytes
  $7798,1 height = #PEEK(#PC) pixels
  $7799 #SPRITE2x3,7(fly-r-1)

@ $77C9 label=JETMAN_FLY_R_2
N $77C9 Flying Frame Right 2
N $77C9 #DIMENSIONS
B $77C9,1 terminator
  $77CA,1 width = #PEEK(#PC) bytes
  $77CB,1 height = #PEEK(#PC) pixels
  $77CC #SPRITE3x3,7(fly-r-2)

@ $7814 label=JETMAN_FLY_R_3
N $7814 Flying Frame Right 3
N $7814 #DIMENSIONS
B $7814,1 terminator
  $7815,1 width = #PEEK(#PC) bytes
  $7816,1 height = #PEEK(#PC) pixels
  $7817 #SPRITE3x3,7(fly-r-3)

@ $785F label=JETMAN_FLY_R_4
N $785F Flying Frame Right 4
N $785F #DIMENSIONS
B $785F,1 terminator
  $7860,1 width = #PEEK(#PC) bytes
  $7861,1 height = #PEEK(#PC) pixels
  $7862 #SPRITE3x3,7(fly-r-4)

@ $78AA label=JETMAN_FLY_L_1
N $78AA Flying Frame Left 1
N $78AA #DIMENSIONS
B $78AA,1 terminator
  $78AB,1 width = #PEEK(#PC) bytes
  $78AC,1 height = #PEEK(#PC) pixels
  $78AD #SPRITE2x3,7(fly-l-1)

@ $78DD label=JETMAN_FLY_L_2
N $78DD Flying Frame Left 2
N $78DD #DIMENSIONS
B $78DD,1 terminator
  $78DE,1 width = #PEEK(#PC) bytes
  $78DF,1 height = #PEEK(#PC) pixels
  $78E0 #SPRITE2x3,7(fly-l-2)

@ $7910 label=JETMAN_FLY_L_3
N $7910 Flying Frame Left 3
N $7910 #DIMENSIONS
B $7910,1 terminator
  $7911,1 width = #PEEK(#PC) bytes
  $7912,1 height = #PEEK(#PC) pixels
  $7913 #SPRITE3x3,7(fly-l-3)

@ $795B label=JETMAN_FLY_L_4
N $795B Flying Frame Left 4
N $795B #DIMENSIONS
B $795B,1 terminator
  $795C,1 width = #PEEK(#PC) bytes
  $795D,1 height = #PEEK(#PC) pixels
  $795E #SPRITE3x3,7(fly-l-4)

@ $79A6 label=JETMAN_WLK_L_1
N $79A6 Walking Frame Left 1
N $79A6 #DIMENSIONS
B $79A6,1 terminator
  $79A7,1 width = #PEEK(#PC) bytes
  $79A8,1 height = #PEEK(#PC) pixels
  $79A9 #SPRITE2x3,7(wlk-l-1)

@ $79D9 label=JETMAN_WLK_L_2
N $79D9 Walking Frame Left 2
N $79D9 #DIMENSIONS
B $79D9,1 terminator
  $79DA,1 width = #PEEK(#PC) bytes
  $79DB,1 height = #PEEK(#PC) pixels
  $79DC #SPRITE2x3,7(wlk-l-2)

@ $7A0C label=JETMAN_WLK_L_3
N $7A0C Walking Frame Left 3
N $7A0C #DIMENSIONS
B $7A0C,1 terminator
  $7A0D,1 width = #PEEK(#PC) bytes
  $7A0E,1 height = #PEEK(#PC) pixels
  $7A0F #SPRITE3x3,7(wlk-l-3)

@ $7A57 label=JETMAN_WLK_L_4
N $7A57 Walking Frame Left 4
N $7A57 #DIMENSIONS
B $7A57,1 terminator
  $7A58,1 width = #PEEK(#PC) bytes
  $7A59,1 height = #PEEK(#PC) pixels
  $7A5A #SPRITE3x3,7(wlk-l-4)

@ $7AA2 label=JETMAN_WLK_R_1
N $7AA2 Walking Frame Right 1
N $7AA2 #DIMENSIONS
B $7AA2,1 terminator
  $7AA3,1 width = #PEEK(#PC) bytes
  $7AA4,1 height = #PEEK(#PC) pixels
  $7AA5 #SPRITE2x3,7(wlk-r-1)

@ $7AD5 label=JETMAN_WLK_R_2
N $7AD5 Walking Frame Right 2
N $7AD5 #DIMENSIONS
B $7AD5,1 terminator
  $7AD6,1 width = #PEEK(#PC) bytes
  $7AD7,1 height = #PEEK(#PC) pixels
  $7AD8 #SPRITE2x3,7(wlk-r-2)

@ $7B08 label=JETMAN_WLK_R_3
N $7B08 Walking Frame Right 3
N $7B08 #DIMENSIONS
B $7B08,1 terminator
  $7B09,1 width = #PEEK(#PC) bytes
  $7B0A,1 height = #PEEK(#PC) pixels
  $7B0B #SPRITE3x3,7(wlk-r-3)

@ $7B53 label=JETMAN_WLK_R_4
N $7B53 Walking Frame Right 4
N $7B53 #DIMENSIONS
B $7B53,1 terminator
  $7B54,1 width = #PEEK(#PC) bytes
  $7B55,1 height = #PEEK(#PC) pixels
  $7B56 #SPRITE3x3,7(wlk-r-4)

b $7B9E Round 1 Alien Graphics
E $7B9E #UDGARRAY*round-1-1,50;round-1-2(round-1-frames)
N $7B9E Frame 1
B $7B9E,1 height = #PEEK(#PC) pixels
  $7B9F #ITEM,3(round-1-1*)
@ $7B9F label=UDG_ALIEN1-1
N $7BB5 Frame 2
B $7BB5,1 height = #PEEK(#PC) pixels
  $7BB6 #ITEM,3(round-1-2*)
@ $7BB6 label=UDG_ALIEN1-2

b $7BCC Explosion Frames
E $7BCC #UDGARRAY*exp-01,50;exp-02;exp-03(explosion)

N $7BCC Frame 1
N $7BCC #DIMENSIONS
B $7BCC,1 terminator
  $7BCD,1 width = #PEEK(#PC) bytes
  $7BCE,1 height = #PEEK(#PC) pixels
  $7BCF #SPRITE3x2,7(exp-01*)
@ $7BCF label=UDG_EXPLOSION_1

N $7BFF Frame 2
N $7BFF #DIMENSIONS
B $7BFF,1 terminator
  $7C00,1 width = #PEEK(#PC) bytes
  $7C01,1 height = #PEEK(#PC) pixels
  $7C02 #SPRITE3x2,7(exp-02*)
@ $7C02 label=UDG_EXPLOSION_2

N $7C32 Frame 3
N $7C32 #DIMENSIONS
B $7C32,1 terminator
  $7C33,1 width = #PEEK(#PC) bytes
  $7C34,1 height = #PEEK(#PC) pixels
  $7C35 #SPRITE3x2,7(exp-03*)
@ $7C35 label=UDG_EXPLOSION_3

b $7C65 Ship Graphics
D $7C65 The ships are all 2 bytes x 16 pixel and hence are 6 character blocks high.
@ $7C65 label=SHIP_U3
N $7C65 Ship U3
N $7C65 #SHIP(ship-u3)
B $7C65,1 terminator
  $7C66,1 width = #PEEK(#PC) bytes
  $7C67,1 height = #PEEK(#PC) pixels
  $7C68 #SPRITE2x2,7(ship-u3-1)

  $7C88,1 terminator
  $7C89,1 width = #PEEK(#PC) bytes
  $7C8A,1 height = #PEEK(#PC) pixels
  $7C8B #SPRITE2x2,7(ship-u3-2)

  $7CAB,1 terminator
  $7CAC,1 width = #PEEK(#PC) bytes
  $7CAD,1 height = #PEEK(#PC) pixels
  $7CAE #SPRITE2x2,7(ship-u3-3)

@ $7CCE label=SHIP_U1
N $7CCE Ship U1
N $7CCE #SHIP(ship-u1)
B $7CCE,1 terminator
  $7CCF,1 width = #PEEK(#PC) bytes
  $7CD0,1 height = #PEEK(#PC) pixels
  $7CD1 #SPRITE2x2,7(ship-u1-1)

  $7CF1,1 terminator
  $7CF2,1 width = #PEEK(#PC) bytes
  $7CF3,1 height = #PEEK(#PC) pixels
  $7CF4 #SPRITE2x2,7(ship-u1-2)

  $7D14,1 terminator
  $7D15,1 width = #PEEK(#PC) bytes
  $7D16,1 height = #PEEK(#PC) pixels
  $7D17 #SPRITE2x2,7(ship-u1-3)

@ $7D37 label=SHIP_U2
N $7D37 Ship U2
N $7D37 #SHIP(ship-u2)
B $7D37,1 terminator
  $7D38,1 width = #PEEK(#PC) bytes
  $7D39,1 height = #PEEK(#PC) pixels
  $7D3A #SPRITE2x2,7(ship-u2-1)

  $7D5A,1 terminator
  $7D5B,1 width = #PEEK(#PC) bytes
  $7D5C,1 height = #PEEK(#PC) pixels
  $7D5D #SPRITE2x2,7(ship-u2-2)

  $7D7D,1 terminator
  $7D7E,1 width = #PEEK(#PC) bytes
  $7D7F,1 height = #PEEK(#PC) pixels
  $7D80 #SPRITE2x2,7(ship-u2-3)

@ $7DA0 label=SHIP_U4
N $7DA0 Ship U4
N $7DA0 #SHIP(ship-u4)
B $7DA0,1 terminator
  $7DA1,1 width = #PEEK(#PC) bytes
  $7DA2,1 height = #PEEK(#PC) pixels
  $7DA3 #SPRITE2x2,7(ship-u4-1)

  $7DC3,1 terminator
  $7DC4,1 width = #PEEK(#PC) bytes
  $7DC5,1 height = #PEEK(#PC) pixels
  $7DC6 #SPRITE2x2,7(ship-u4-2)

  $7DE6,1 terminator
  $7DE7,1 width = #PEEK(#PC) bytes
  $7DE8,1 height = #PEEK(#PC) pixels
  $7DE9 #SPRITE2x2,7(ship-u4-3)


b $7E09 Item Graphics
D $7E09 All the collectible items for the game.

N $7E09 Gold Bar
N $7E09 #DIMENSIONS
B $7E09,1 terminator
  $7E0A,1 width = #PEEK(#PC) bytes
  $7E0B,1 height = #PEEK(#PC) pixels
; This one is unique in that it's only one byte in height.
  $7E0C #UDGARRAY2,attr=6,scale=4,step=2,flip=2;(#PC)-(#PC+$01)(item-1)
@ $7E0C label=UDG_ITEM1

N $7E1C Fuel Pod
N $7E1C #DIMENSIONS
B $7E1C,1 terminator
  $7E1D,1 width = #PEEK(#PC) bytes
  $7E1E,1 height = #PEEK(#PC) pixels
  $7E1F #ITEM,3(item-2)
@ $7E1F label=UDG_ITEM2

N $7E35 Plutonium
N $7E35 #DIMENSIONS
B $7E35,1 terminator
  $7E36,1 width = #PEEK(#PC) bytes
  $7E37,1 height = #PEEK(#PC) pixels
  $7E38 #ITEM,5(item-3)
@ $7E38 label=UDG_ITEM3

N $7E4E Isotope
N $7E4E #DIMENSIONS
B $7E4E,1 terminator
  $7E4F,1 width = #PEEK(#PC) bytes
  $7E50,1 height = #PEEK(#PC) pixels
  $7E51 #ITEM,5(item-4)
@ $7E51 label=UDG_ITEM4

N $7E6B Mineral
N $7E6B #DIMENSIONS
B $7E6B,1 terminator
  $7E6C,1 width = #PEEK(#PC) bytes
  $7E6D,1 height = #PEEK(#PC) pixels
  $7E6E #ITEM,3(item-5)
@ $7E6E label=UDG_ITEM5

N $7E80 Gemstone
N $7E80 #DIMENSIONS
B $7E80,1 terminator
B $7E81,1 width = #PEEK(#PC) bytes
  $7E82,1 height = #PEEK(#PC) pixels
  $7E83 #ITEM,3(item-6)
@ $7E83 label=UDG_ITEM6

b $7E9B Round 2 Alien Graphics
E $7E9B #UDGARRAY*round-2-1,50;round-2-2(round-2-frames)
N $7E9B Frame 1
B $7E9B,1 height = #PEEK(#PC) pixels
  $7E9C #ITEM,2(round-2-1*)
@ $7E9C label=UDG_ALIEN2_1
N $7EB8 Frame 2
B $7EB8,1 height = #PEEK(#PC) pixels
  $7EB9 #ITEM,2(round-2-2*)
@ $7EB9 label=UDG_ALIEN2_2

b $7ED5 Round 4 Alien Graphics
N $7ED5 Frame 1
B $7ED5,1 height = #PEEK(#PC) pixels
  $7ED6 #ITEM,7(round-4-1)

b $7EE4 Round 5 Alien Graphics
N $7EE4 Frame 1
B $7EE4,1 height = #PEEK(#PC) pixels
  $7EE5 #ITEM,4(round-5-1)
@ $7EE5 label=UDG_ALIEN5_1

b $7EF5 Round 3 Alien Graphics
E $7EF5 #UDGARRAY*round-3-1,50;round-3-2(round-3-frames)
N $7EF5 Frame 1
B $7EF5,1 height = #PEEK(#PC) pixels
  $7EF6 #ITEM,3(round-3-1*)
@ $7EF6 label=UDG_ALIEN3_1
N $7F16 Frame 2
B $7F16,1 height = #PEEK(#PC) pixels
  $7F17 #ITEM,3(round-3-2*)
@ $7F17 label=UDG_ALIEN3_2

b $7F33 Round 6 Alien Graphics
N $7F33 Frame 1
B $7F33,1 height = #PEEK(#PC) pixels
  $7F34 #ITEM,5(round-6-1)
@ $7F34 label=UDG_ALIEN6_1

b $7F52 Round 7 Alien Graphics
N $7F52 Frame 1
B $7F52,1 height = #PEEK(#PC) pixels
  $7F53 #ITEM,2(round-7-1)
@ $7F53 label=UDG_ALIEN7_1

b $7F6F Round 8 Alien Graphics
N $7F6F Frame 1
B $7F6F,1 height = #PEEK(#PC) pixels
  $7F70 #ITEM,3(round-8-1)
@ $7F70 label=UDG_ALIEN8_1

b $7F8C Flame Graphics

@ $7F8C label=UDG_FLAME1
N $7F8C Flame Frame 1
N $7F8C #DIMENSIONS
B $7F8C,1 terminator
  $7F8D,1 width = #PEEK(#PC) bytes
  $7F8E,1 height = #PEEK(#PC) pixels
  $7F8F #ITEM,2(flame-1*)

S $7FAD,2

@ $7FAF label=UDG_FLAME2
N $7FAF Flame Frame 2
N $7FAF #DIMENSIONS
B $7FAF,1 terminator
  $7FB0,1 width = #PEEK(#PC) bytes
  $7FB1,1 height = #PEEK(#PC) pixels
  $7FB2 #ITEM,2(flame-2*)

N $7FD0 #TABLE(ships)
. {
. #UDGARRAY#(2,attr=7,scale=4,step=2,flip=2#FOR($03,$49,$23)(n,;($7CCE+n)-($7CCE+n+$11)-$01-$10))(ship-u1-flame)  |
. #UDGARRAY#(2,attr=7,scale=4,step=2,flip=2#FOR($03,$49,$23)(n,;($7D37+n)-($7D37+n+$11)-$01-$10))(ship-u2-flame)  |
. #UDGARRAY#(2,attr=7,scale=4,step=2,flip=2#FOR($03,$49,$23)(n,;($7C65+n)-($7C65+n+$11)-$01-$10))(ship-u3-flame)  |
. #UDGARRAY#(2,attr=7,scale=4,step=2,flip=2#FOR($03,$49,$23)(n,;($7DA0+n)-($7DA0+n+$11)-$01-$10))(ship-u4-flame)
. }
. {
. #UDGARRAY*flame-1,50;flame-2(frame-frames)  |
. #UDGARRAY*flame-1,50;flame-2(frame-frames)  |
. #UDGARRAY*flame-1,50;flame-2(frame-frames)  |
. #UDGARRAY*flame-1,50;flame-2(frame-frames)
. }
. TABLE#

N $7FD0 Random bytes perhaps?
D $7FD0
T $7FD2,42,41:1 COPYRIGHT 1983 A.C.G. ALL RIGHTS RESERVED
S $7FFC,4
i $8000
