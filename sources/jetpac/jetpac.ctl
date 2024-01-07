> $4000 @org=$4000
> $4000 @start=$5B80
b $4000 Loading screen
D $4000 #UDGTABLE { =h JetPac Loading Screen } { #SCR$02(loading) } UDGTABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

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

g $5CF3 Game Options
E $5CF3 View the equivalent code in;
. #LIST
. { #ATICATAC$5E00 }
. { #COOKIE$5F0C }
. { #LUNARJETMAN$5E00 }
. { #PSSST$5E03 }
. LIST#
@ $5CF3 label=GameOptions
D $5CF3 Holds the number of players and the chosen control method.
. #TABLE(default,centre,centre)
. { =h Byte | =h Binary | =h Option }
. { #N$00 | #EVAL($00, $02, $08) | 1UP Game + Keyboard }
. { #N$01 | #EVAL($01, $02, $08) | 2UP Game + Keyboard }
. { #N$02 | #EVAL($02, $02, $08) | 1UP Game + Kempston Joystick }
. { #N$03 | #EVAL($03, $02, $08) | 2UP Game + Kempston Joystick }
. TABLE#
N $5CF3 "Number of Players" on Bit #N$00.
N $5CF3 "Control Method" on Bit #N$01.

g $5CF4 1UP Score
D $5CF4 3-byte representation of the score.
@ $5CF4 label=1UP_Score
B $5CF4,$03

g $5CF7 2UP Score
D $5CF7 3-byte representation of the score.
@ $5CF7 label=2UP_Score
B $5CF7,$03

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
D $5D01 The default starting position is #N$80.
@ $5D01 label=Jetman_Pos_X
B $5D01,$01

g $5D02 Jetman Y Co-ordinate
D $5D02 The default start position is #N$B7.
@ $5D02 label=Jetman_Pos_Y
B $5D02,$01

g $5D03 Jetman Attribute
D $5D03 The default colour on game start is #N$47.
@ $5D03 label=Jetman_Colour
B $5D03,$01

g $5D04 Jetman Direction
@ $5D04 label=Jetman_Direction
B $5D04,$01

g $5D05 Jetman Speed: Horizontal
D $5D05 #TABLE(default,centre,centre) { =h,c2 Maximum Value } { =h Walking | =h Flying } { #N$20 | #N$40 } TABLE#
@ $5D05 label=Jetman_Speed_X
B $5D05,$01

g $5D06 Jetman Speed: Vertical
D $5D06 Maximum Value: #N$3F.
@ $5D06 label=Jetman_Speed_Y
B $5D06,$01

g $5D07 Jetman Height
D $5D07 Jetman sprite height, always #N$24.
@ $5D07 label=Jetman_Height

g $5D08 Laser Beam Parameters
D $5D08 #TABLE(default,centre) { =h Bytes(n) | =h Variable }
. { 0 | Unused=#N$00, Used=#N$10 }
. { 1 | Y Position }
. { 2 | X position pulse #1 }
. { 3 | X position pulse #2 }
. { 4 | X position pulse #3 }
. { 5 | X position pulse #4 }
. { 6 | Beam length }
. { 7 | Colour attribute }
. TABLE#
@ $5D08 label=Laser_Param_1
B $5D08,$08 Laser Beam #1.
@ $5D10 label=Laser_Param_2
B $5D10,$08 Laser Beam #2.
@ $5D18 label=Laser_Param_3
B $5D18,$08 Laser Beam #3.
@ $5D20 label=Laser_Param_4
B $5D20,$08 Laser Beam #4.

g $5D28 Explosion Sound Parameters
D $5D28 Explosion sound parameters for frequency and duration.
@ $5D28 label=Explosion_Param_SFX
B $5D28,$01 Frequency is #N$0C or #N$0D.
B $5D29,$01 Length is always set to #N$04.
S $5D2A,$06 Unused.

g $5D30 Active Player Rocket Parameters
@ $5D30 label=ActivePlayerRocket_State
B $5D30,$01 Movement: #TABLE(default,centre,centre,centre) { =h On Pad | =h Up | =h Down } { #N$09 | #N$0A | #N$0B } TABLE#
@ $5D31 label=ActivePlayerRocket_Pos_X
B $5D31,$01 X Position.
@ $5D32 label=ActivePlayerRocket_Base_Pos_Y
B $5D32,$01 Y Position (base module).
@ $5D33 label=ActivePlayerRocket_Attribute
B $5D33,$01 Colour Attribute.
@ $5D34 label=ActivePlayerNum_Rocket_Pieces
B $5D34,$01 Number of rocket pieces on the pad.
@ $5D35 label=ActivePlayerNum_Fuel_Pods
B $5D35,$01 Number of collected fuel pods.
B $5D36,$01 Unused.
B $5D37,$01 Unused (always #N$1C).

g $5D38 Fuel 00 when not on screen, $04 when visible
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

g $5D98 Inactive Player Rocket Parameters
@ $5D98 label=InactivePlayerRocket_State
B $5D98,$01 Movement: #TABLE(default,centre,centre,centre) { =h On Pad | =h Up | =h Down } { #N$09 | #N$0A | #N$0B } TABLE#
@ $5D99 label=InactivePlayerRocket_Pos_X
B $5D99,$01 X Position.
@ $5D9A label=InactivePlayerRocket_Base_Pos_Y
B $5D9A,$01 Y Position (base module).
@ $5D9B label=InactivePlayerRocket_Attribute
B $5D9B,$01 Colour Attribute.
@ $5D9C label=InactivePlayerNum_Rocket_Pieces
B $5D9C,$01 Number of rocket pieces on the pad.
@ $5D9D label=InactivePlayerNum_Fuel_Pods
B $5D9D,$01 Number of collected fuel pods.
B $5D9E,$01 Unused.
B $5D9F,$01 Unused (always #N$1C).

g $5DA0 Inactive Player Rocket module (fuel/part)
B $5DA0,$08

g $5DA8 Inactive Player Collectible/ Rocket middle
B $5DA8,$08

g $5DC0 Actor Buffer
@ $5DC0 label=Buffer_Actor
B $5DC0,$01 X Position.
B $5DC1,$01 Y Position.
B $5DC2,$01 Movement direction.
B $5DC3,$01 Height (in pixels).
B $5DC4,$01 Width (in bytes).
B $5DC5,$01 Height?
B $5DC6,$01 Height?
B $5DC7,$01 Flying movement/ direction?

g $5DC8 Jetman Fly Counter?
@ $5DC8 label=JetmanFlyCounter
B $5DC8,$01

g $5DC9 Alien Direction
@ $5DC9 label=AlienDirection
B $5DC9,$01

g $5DCA Jetman Speed Modifier
@ $5DCA label=JetmanSpeedModifier
B $5DCA,$01

g $5DCB Current Alien ID
@ $5DCB label=ActiveAlien
B $5DCB,$01

g $5DCC Game Timer
D $5DCC 16-bit counter starting at 0x0000 and counting +1 (each time a sprite is moved or redrawn), although sometimes
.       it will increment + #N$02. This continues until the whole game is over - for both 1 and 2 player games. Counter
.       loops around after reaching #N$FFFF.
@ $5DCC label=GameTimer
W $5DCC,$02

g $5DCE Random Number
D $5DCE Value is calculated using the 16-bit game timer LSB value, which is used to fetch a byte from the ROM (between addresses #N$00 and #N$FF), then by adding the current #REGr.
@ $5DCE label=Random_Number
B $5DCE,$01

g $5DCF Actor Screen Position
@ $5DCF label=ActorScreenPos
B $5DCF,$01 X Position.
B $5DD0,$01 Y Position.

g $5DD1 Active Player
@ $5DD1 label=Flag_ActivePlayer
D $5DD1 Which player is currently active.
B $5DD1 #TABLE(default,centre,centre) { =h Value | =h Player }
. { $00 | 1UP }
. { $FF | 2UP }
. TABLE#

g $5DD2 ???
g $5DD3 ???

g $5DD4 Last Frame
D $5DD4 #HTML(Holds a copy of the last <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> counter.)
@ $5DD4 label=LastFrame
B $5DD4,$01

g $5DD5 Frame Updated
@ $5DD5 label=FrameUpdated
D $5DD5 Has the frame been updated? #N$00=No #N$01=Yes.
B $5DD5,$01

g $5DD6 Menu Item Attribute
D $5DD6 Current menu item colour attribute.
@ $5DD6 label=Current_MenuAttr
B $5DD6,$01

g $5DD7 "Get Ready" Delay Counter
@ $5DD7 label=PlayDelay_Counter
B $5DD7,$01

g $5DF0 Active Player Level
@ $5DF0 label=ActivePlayer_Level
B $5DF0,$01

g $5DF1 Active Player Lives
@ $5DF1 label=ActivePlayer_Lives
B $5DF1,$01

s $5DF2

g $5DF8 Inactive Player Level
@ $5DF8 label=InactivePlayer_Level
B $5DF8,$01

g $5DF9 Inactive Player Lives
@ $5DF9 label=InactivePlayer_Lives
B $5DF9,$01

b $5E00

b $5FC0

g $6000 Platform Graphics
@ $6000 label=Platform_Buffer
B $6000,$04 Middle.
B $6004,$04 Bottom.
B $6008,$04 Left.
B $600C,$04 Right.

g $6010 Player Initialisation Data
@ $6010 label=Initialisation_Player
  $6010,$08

g $6018 Rocket Initialisation Data
@ $6018 label=Initialisation_Rocket_Base
B $6018,$08,$01
@ $6020 label=Initialisation_Rocket_Top
B $6020,$08,$01
@ $6028 label=Initialisation_Rocket_Middle
B $6028,$08,$01

g $6030 Fuel Pod Initialisation Data
@ $6030 label=Initialisation_FuelPod
B $6030,$08

g $6038 Collectible Initialisation Data
@ $6038 label=Initialisation_Collectible
B $6038,$08

t $6040 Rights Messaging
@ $6040 label=Message_Rights
  $6040,$21,h$01,c$01,$1E:$01 "© 1983 A.C.G. ALL RIGHTS RESERVED".

t $6061 Copyright Messaging
@ $6061 label=Message_Copyright
  $6061,$29 "COPYRIGHT 1983 A.C.G. ALL RIGHTS RESERVED".

c $608A Create Game Window
E $608A View the equivalent code in;
. #LIST
. { #ATICATAC$80AA }
. { #COOKIE$5FB7 }
. { #LUNARJETMAN$0000 }
. { #PSSST$5F53 }
. { #TRANZAM$0000 }
. LIST#
@ $608A label=CreateWindow
N $608A Blank the screen and write the banner.
  $608A,$03 Set the border to black.
  $608D,$03 Call #R$71B8.
  $6090,$03 Call #R$71C6.
  $6093,$03 Call #R$7192.
  $6096,$03 Attribute buffer address.
  $6099,$03 #REGb=loop counter, #REGc=Cyan/Yellow.
  $609C,$01 Reset bytes in the attribute buffer.
  $609D,$01 Increment #REGl by one (move to the next address in the attribute buffer).
  $609E,$02 Decrease counter by one and loop back to #R$609C until counter is zero.
  $60A0,$03 Call #R$711C.
  $60A3,$03 Call #R$7124.
  $60A6,$03 Jump to #R$712C.

c $60A9 Initialise New Level
@ $60A9 label=LevelNew
  $60A9,$03 #REGa=#R$5DF0.
M $60AC,$04 If #R$5DF0 % $04 (every 4th level) ... then continue and reset the rocket else jump to #R$60BA.
  $60AC,$02,b$01
  $60B0,$03 Call #R$60CD.
  $60B3,$04 Increase the lives counter #R$5DF1 by one.
  $60B7,$03 Call #R$619A.
@ $60BA label=LevelInitialisation
  $60BA,$03 Call #R$6929.
  $60BD,$03 Call #R$608A.
  $60C0,$03 Call #R$766D.
  $60C3,$03 Call #R$70A4.
  $60C6,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $60C9,$03 Write #REGa to #R$5DD4.
  $60CC,$01 Return.

c $60CD Reset Rocket
@ $60CD label=RocketReset
  $60CD,$0B Copy #N$18 bytes of data from #R$6018 to #R$5D30.
  $60D8,$02 #REGa=#N$08.
  $60DA,$03 Jump to #R$6EF9.

c $60DD Reset Player
@ $60DD label=PlayerReset

C $6103,$03 #REGa=#R$5DF9

  $6146,$02 Decrease #REGb by one, jump to #R$6141 if not zero

c $616A  1UP/ 2UP Swapper
E $616A View the equivalent code in;
. #LIST
. { #COOKIE$6416 }
. { #LUNARJETMAN$0000 }
. { #PSSST$613B }
. LIST#
@ $616A label=ChangePlayer
N $616A This routine "swaps" the data between #REGde and #REGhl.
  $616A,$03 #REGhl=#R$5DF0.
  $616D,$03 #REGde=#R$5DF8.
  $6170,$02 #REGb=#N$02 (counter).
  $6172,$03 Call #R$617D.
  $6175,$03 #REGhl=#R$5D30.
  $6178,$03 #REGde=#R$5D98.
  $617B,$02 #REGb=#N$18 (counter).
N $617D This looks complicated but it's just grabbing the data from #REGde, grabbing the data from #REGhl, and writing the others data to each one.
@ $617D label=ChangePlayer_Loop
  $617D,$01 #REGa=#REGde.
  $617E,$01 #REGc=#REGhl.
  $617F,$01 Store #REGa at #REGhl.
  $6180,$02 Store #REGc at #REGde.
  $6182,$02 Increment both #REGhl and #REGde by one.
  $6184,$02 Decrease counter by one and loop back to #R$617D until counter is zero.
  $6186,$01 Return.

t $6187 Game Over P1 Message
@ $6187 label=Message_GameOverP1
  $6187,$13,h$01,$11:$01 "GAME OVER PLAYER 1" (#N(#PEEK(#PC)) is the attribute).

c $619A Player Initialisation
@ $619A label=PlayerInitialisation
  $619A,$03 #REGhl Source address: #R$6010
  $619D,$03 #REGde Target address: #R$5D00
  $61A0,$03 #REGbc=loop counter
  $61A3,$02 Action! Copy source to target, decrease counter, repeat until zero
  $61A5,$02 #REGa=$80
  $61A7,$07 if bit 0 is set for #R$5CF3 (is this a 2UP game) then jump to #R$61B0
  $61AE,$05 Add $7F to #REGa and update #R$5DD7 with the result
  $61B3,$07 Decrease #R$5DF1 by 1
  $61BA,$03 Jump to #R$70A4

c $61BD
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

c $61D3
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

c $62FF Print Menu Item
@ $62FF label=PrintMenuItem
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

c $6333 Start Game
E $6333 View the equivalent code in;
. #LIST
. { #ATICATAC$7D9A }
. { #COOKIE$6428 }
. { #LUNARJETMAN$81BB }
. { #PSSST$631E }
. { #TRANZAM$5FEF }
. LIST#
@ $6333 label=StartGame
  $6333,$03 #REGhl=#R$5CF4
  $6336,$03 #REGbc=#R$6000
  $6339,$03

  $6345,$03 Change the stack pointer to #R$5CF0
  $6348,$01 Enable interrupts
  $6349,$04 #REGix=#R$5D30
  $634D,$01 Clear #REGa (sets to $00)
  $634E,$03 Writes #REGa to #R$5DCB
  $6351,$07 #HTML(Compare <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> and #R$5DD4.)
  $635C,$04 Stash #R$69A8 on the stack.
  $6360,$03 #REGhl=#R$6374.
  $6366,$01 #REGa=#REGa * #N$02.
  $6367,$02,b$01 Keep only bits 1-6.
  $6369,$03 Create an offset in #REGbc.
  $636C,$05 #REGhl=the address held at #R$6374 + offset.
  $6371,$03 #HTML(Jump to <a href="https://skoolkid.github.io/rom/asm/5CB0.html">NMIADD</a> which will jump to the address in #REGhl.)

w $6374 Jump Table
@ $6374 label=JumpTable
  $6374,$24,$02

c $6398
@ $6398 label=NewHighScore
  $63AC,$04 #REGe=#R$5CF4(#N$5CF6).

  $63B0,$04 Compare #REGe with #R$5CF7(#N$5CF9).
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

c $63CB Update Highscore
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

c $6498

c $651F
  $653F,$06 Drop #REGix+$02 (fuel Y co-ordinate) by two pixels

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

c $66C7

c $66EB

c $6707

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

c $67ED Sounds: Thrusters
@ $67ED label=SoundsThrusters

c $67FD Sounds: Rocket Build
@ $67FD label=SoundsRocketBuild

c $6803 Sounds: Pickup Fuel
@ $6803 label=SoundsPickupFuel

c $6809 Sounds: Pickup Item
E $6809 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$B8C9 }
. LIST#
@ $6809 label=SoundsPickupItem

c $680D Play square wave sound
@ $680D label=PlaySquareWave
R $680D D Duration of wave
  $680D,$04 #REGa=#N$10 (speaker on = bit 4).
  $6811,$03 Decrease duration by one and loop back to #R$6812 until duration is zero.
@ $6812 label=PlaySquareWave_Loop
  $6814,$03 Speaker off.
  $6817,$03 Decrease duration by one and loop back to #R$6818 until duration is zero.
@ $6818 label=Silence_Loop
  $681D,$01 Return.

c $681E Sounds: Laser Beam
@ $681E label=SoundsLaserBeam
  $6821,$02 Decrease #REGb by one, and loop back to #R$6821 until zero
  $6828,$02 Decrease #REGb by one, and loop back to #R$6828 until zero
  $6833,$01 Return.

c $6834 Set Explosion Sound Defaults
@ $6834 label=ExplosionInitialise
B $6847,$04

c $684B

c $6854
  $6864,$02 Decrease #REGb by one, and loop back to #R$6864 until zero
  $686A,$02 Decrease #REGb by one, and loop back to #R$686A until zero

c $68B1

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

c $691B Limit Frame Rate
E $691B View the equivalent code in;
. #LIST
. { #COOKIE$7152 }
. { #LUNARJETMAN$824A }
. { #PSSST$70DF }
. LIST#
@ $691B label=LimitFrameRate
N $691B Called at the beginning of each game loop. Setting a higher pause value will slow the game down.
  $691B,$05 Return if #R$5DD5 is not marked as being updated.
  $6920,$03 Introduce a counter (#N($00C0,$04,$04)) for a slight pause.
@ $6923 label=LimitFrameRate_Loop
  $6923,$01 Decrease counter by one.
  $6924,$04 Keep jumping back to #R$6923 until the counter is zero.
  $6928,$01 Return.

c $6929

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

c $6A6C

c $6AEF

c $6C2F

c $6CF5

c $6DD3 Meteor Update
  $6DD6,$03 #REGhl=$5DCB.

  $6E98,$02 Decrease #REGb by one, and loop back to #R$6E5A until zero.
  $6EAE,$02 Decrease #REGb by one, and loop back to #R$6EA8 until zero.
  $6EB9,$02 Decrease #REGb by one, and loop back to #R$6EB6 until zero.
  $6ED7,$02 Decrease #REGb by one, and loop back to #R$6ED1 until zero.
  $6EF1,$02 Decrease #REGb by one, and loop back to #R$6EDC until zero.

  $6EFA,$03 #REGa=#R$5DF0

c $6F91 Handler: Laser Beam
@ $6F91 label=Handler_LaserBeam
N $6F91 Only handle the laser beam on every 4th frame.
  $6F91,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $6F94,$02,b$01 Keep only bits 0-1.
  $6F96,$01 #HTML(Return if <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> is non-zero.)
N $6F97 Search for a "free" laser beam slot.
  $6F97,$03 #REGhl=#R$5D08.
  $6F9A,$03 #REGde=#N($0008, $04, $04) (each slot is #N$08 bytes).
  $6F9D,$02 #REGb=#N$04 (counter; there are 4 "slots").
@ $6F9F label=LaserBeam_Slot
  $6F9F,$04 If the slot is not in use, jump to #R$6FA7.
  $6FA3,$01 #REGhl=#REGhl+#REGde (move onto the next slot).
  $6FA4,$02 Decrease counter by one and loop back to #R$6F9F until counter is zero.
N $6FA6 All laser beam slots are in use so just return...
  $6FA6,$01 Return.
N $6FA7 Initialise a new laser beam.
@ $6FA7 label=Init_LaserBeam
  $6FA7,$02 Mark the laser beam slot as "in-use".
  $6FA9,$01 #REGhl=Laser beam Y position.
  $6FAA,$05 #REGb=#R$5D00.
  $6FAF,$02 #REGa=#R$5D01.
  $6FB1,$02,b$01 Keep only bits 3-7.
  $6FB3,$02,b$01 Set bits 0 and 2.
@ $6FBD label=LaserBeam_Left
  $6FCE,$03 #REGa=#R$5DCE.
  $6FD1,$02,b$01 Keep only bits 3-5.
  $6FD3,$02,b$01 Set bits 2 and 7.
  $6FD8,$03 #REGhl=#R$6FE9.
  $6FDB,$03 #REGa=#R$5DCE.
  $6FDE,$02,b$01 Keep only bits 0-1.
  $6FE6,$03 Jump to #R$681E.
N $6FE9 All the attributes a laser beam can be.
@ $6FE9 label=LaserBeam_Attributes
B $6FE9,$04

N $6FED Handle drawing the laser beam moving to the right.
@ $6FED label=LaserBeam_Right
  $6FED,$01 #REGa=Jetman X position.
  $6FEE,$02,b$01 Keep only bits 0-2.
  $6FF0,$01 #REGa=.
  $6FF7,$02,b$01 Keep only bits 1-7.
  $6FF9,$01 Store the result in #REGc.
  $6FFA,$02 Jump to #R$6FBD.

c $6FFC Animate: Laser Beam
@ $6FFC label=LaserBeam_Animate

  $706E,$03 #REGa=(IX+$06)

c $70A4 Display Lives
E $70A4 View the equivalent code in;
. #LIST
. { #ATICATAC$0000 }
. { #COOKIE$7378 }
. { #LUNARJETMAN$894F }
. { #PSSST$7325 }
. { #TRANZAM$0000 }
. LIST#
@ $70A4 label=DisplayPlayerLives
N $70A4 Controller for 1UP lives.
  $70A4,$06 Call #R$7308 with #N($0040, $04, $04) (screen buffer address) for 1UP lives.
  $70AA,$03 #REGa=1UP lives remaining (by calling #R$70E3).
  $70AD,$03 If 1UP lives are zero, jump to #R$70CC.
  $70B0,$03 Else, there are lives to display so call #R$70BF.
N $70B3 Controller for 2UP lives.
@ $70B3 label=Controller2UPLives
  $70B3,$06 Call #R$7308 with #N($00B0, $04, $04) (screen buffer address) for 2UP lives.
  $70B9,$03 #REGa=2UP lives remaining (by calling #R$70F1).
  $70BC,$03 If 2UP lives are zero, jump to #R$70D1.
N $70BF Handles displaying the lives count and UDG character.
@ $70BF label=HandlerDisplayLives
  $70BF,$02 Add #N$30 to convert to an ASCII character (starting at "0" character).
  $70C1,$03 Call #R$714C.
  $70C4,$03 #REGde=#R$70DB.
  $70C7,$02 Stash #REGbc and #REGde on the stack.
  $70C9,$03 Jump to #R$715C.
N $70CC 1UP has no lives.
@ $70CC label=Handler1UPNoLives
  $70CC,$03 Call #R$70D1.
  $70CF,$02 Jump to #R$70B3.
N $70D1 2UP has no lives.
@ $70D1 label=Handler2UPNoLives
  $70D1,$02 #REGa=ASCII " " (SPACE).
  $70D3,$03 Call #R$714C.
  $70D6,$02 #REGa=ASCII " " (SPACE).
  $70D8,$03 Jump to #R$714C.

N $70DB The UDG for the lives icon.
@ $70DB label=UDG_Life
B $70DB,$08,b$01 #UDGTABLE(default,centre) { #UDG#(#PC),attr=$07 } UDGTABLE#

N $70E3 Controller for the currently active player.
@ $70E3 label=ControllerActiveLives
  $70E3,$06 If #R$5DD1 is not zero then jump to #R$70ED.
N $70E9 Return currently active players lives left.
@ $70E9 label=ActivePlayerLives
  $70E9,$03 #REGa=#R$5DF1.
  $70EC,$01 Return.
N $70ED Return inactive players lives left.
@ $70ED label=InactivePlayerLives
  $70ED,$03 #REGa=#R$5DF9.
  $70F0,$01 Return.
N $70F1 Controller for the inactive player.
@ $70F1 label=ControllerInactiveLives
  $70F1,$06 If #R$5DD1 is zero then jump to #R$70ED.
  $70F7,$02 Jump to #R$70E9.

c $70F9 Add Points To Score
E $70F9 View the equivalent code in;
. #LIST
. { #COOKIE$7415 }
. { #PSSST$737A }
. { #TRANZAM$6046 }
. LIST#
@ $70F9 label=AddPointsToScore
  $70F9,$04 Evaluate #R$5DD1
  $70FD,$02 Jump to #R$7104 if 2UP is active player

  $70FF,$03 #REGhl=#R$5CF4(#N$5CF6).
  $7102,$02 Jump forward to #R$7107
  $7104,$03 #REGhl=#R$5CF7(#N$5CF9).
  $7107,$01 #REGa=#REGhl
  $7115,$01 Writes #REGa to the memory location currently in #REGhl
  $7116,$04 Evaluate #R$5DD1
  $711A,$02 Jump to #R$7124 if 2UP is active player

c $711C Print Scores
E $711C View the equivalent code in;
. #LIST
. { #COOKIE$7438 }
. { #LUNARJETMAN$89BF }
. { #PSSST$739D }
. { #TRANZAM$6CB6 }
. LIST#
@ $711C label=Score_1UP
N $711C Sets up the 1UP score.
  $711C,$03 #REGhl=#N$4021 (screen buffer address).
  $711F,$03 #REGde=#R$5CF4.
  $7122,$02 Jump to #R$7132.

N $7124 Sets up the 2UP score.
@ $7124 label=Score_2UP
  $7124,$03 #REGhl=#N$4039 (screen buffer address).
  $7127,$03 #REGde=#R$5CF7.
  $712A,$02 Jump to #R$7132.

N $712C Sets up the HI score.
@ $712C label=Score_HI
  $712C,$03 #REGhl=#N$402D (screen buffer address).
  $712F,$03 #REGde=#R$5CF0.

N $7132 Prints the score.
@ $7132 label=PrintScore
  $7132,$02 #REGb=#N$03.
@ $7134 label=PrintScore_Loop
  $7134,$01 #REGa=#REGde.
  $7135,$04 #REGa=#REGa / #N$10.
  $7139,$02,b$01 Keep only bits 0-3.
  $713B,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $713D,$03 Call #R$714C.
  $7140,$01 #REGa=#REGde.
  $7141,$02,b$01 Keep only bits 0-3.
  $7143,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $7145,$03 Call #R$714C.
  $7148,$01 Increment #REGde by one.
  $7149,$02 Decrease counter by one and loop back to #R$7134 until counter is zero.
  $714B,$01 Return.

c $714C Print Character
E $714C View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #COOKIE$7468 }
. { #LUNARJETMAN$89EF }
. { #PSSST$73CD }
. { #TRANZAM$6C96 }
. LIST#
@ $714C label=PrintScreen
R $714C A ASCII value to print
R $714C HL Screen address
  $714C,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $714F,$03 Create an offset in #REGhl.
  $7152,$03 #REGhl=#REGhl * #N08.
  $7155,$04 #HTML(#REGde=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $7159,$02 #REGde=#REGhl + #N$3C00. For examples of usage;
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Letter | =h ASCII Value | =h * 8 (offset) | =h CHARS + offset }
. #FOREACH($55,$4C,$54,$49,$4D,$41,$54,$45)(value,
. { #LET(result=$3C00 + value * $08) "#CHR(value)" | #N(value) | #N(value * $08) | #HTML(<a href="https://skoolkid.github.io/rom/asm/3D00.html##N({result}, $02, $03, $01, $01)()">#N({result})) }
. )
. TABLE#
N $715B Print the character to the screen.
  $715B,$01 Restore #REGhl, containing the screen buffer location, from the stack.
  $715C,$02 #REGb=#N$08 (#N$08 rows of pixels).
@ $715E label=PrintScreen_Loop
  $715E,$02 Copy a byte from the font data to the screen buffer.
  $7160,$01 Increment the font data by one.
  $7161,$01 Move onto the next pixel line.
  $7162,$02 Decrease counter by one and loop back to #R$715E until counter is zero.
  $7164,$02 Restore #REGde and #REGbc from the stack.
N $7166 Reset #REGhl and move to the next column, ready to print the next character.
  $7166,$04 #REGh=#REGh - #N$08 (reset the display line).
  $716A,$01 Increment screen column by one.
  $716B,$01 Return.

c $716C Print String
E $716C View the equivalent code in;
. #LIST
. { #ATICATAC$A1F3 }
. { #COOKIE$7488 }
. { #LUNARJETMAN$0000 }
. { #PSSST$73ED }
. { #TRANZAM$0000 }
. LIST#
@ $716C label=PrintString
R $716C DE Pointer to string data
  $716C,$01 Stash #REGhl on the stack.
  $716D,$03 Call #R$7308.
  $7170,$01 Fetch the attribute byte.
  $7171,$01 Switch to the shadow #REGaf register.
  $7172,$01 Increment #REGde by one to point to the text of the string.
  $7173,$01 Switch to the shadow registers.
  $7174,$01 Restore #REGhl' from the stack.
  $7175,$03 Call #R$720E.

@ $7178 label=PrintString_Loop
  $7178,$01 Switch back to the normal registers.
  $7179,$01 Fetch the character to print.
  $717A,$04 If bit 7 is set (which signifies the end of the string), jump to #R$7189.
  $717E,$03 Call #R$714C.
  $7181,$01 Increment #REGde by one.
  $7182,$01 Switch to the shadow registers.
  $7183,$01 Switch to the shadow #REGaf register.
  $7184,$01 Copy the attribute byte to the screen.
  $7185,$01 Increment #REGl by one.
  $7186,$01 Switch to the shadow #REGaf register.
  $7187,$02 Jump to #R$7178.
N $7189 Because the last character contains the terminator, it needs to be handled separately.
@ $7189 label=PrintString_LastCharacter
  $7189,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $718B,$03 Call #R$714C.
  $718E,$01 Switch to the shadow registers.
  $718F,$01 Switch to the shadow #REGaf register.
  $7190,$01 Copy the attribute byte to the screen.
  $7191,$01 Return.

c $7192 Print Banner
E $7192 View the equivalent code in;
. #LIST
. { #COOKIE$74AE }
. { #LUNARJETMAN$8A37 }
. { #PSSST$7413 }
. LIST#
@ $7192 label=PrintBanner
N $7192 Prints "1UP".
  $7192,$03 #REGhl=#N($0018, 4, 4).
  $7195,$03 #REGde=#R$71AD.
  $7198,$03 Call #R$711C.
N $719B Prints "HI".
  $719B,$03 #REGhl=#N($0078, 4, 4).
  $719E,$03 #REGde=#R$71B5.
  $71A1,$03 Call #R$711C.
N $71A4 Prints "2UP".
  $71A4,$03 #REGhl=#N($00D8, 4, 4).
  $71A7,$03 #REGde=#R$71B1.
  $71AA,$03 Jump to #R$711C.
N $71AD Banner text data.
@ $71AD label=1UP_Text
T $71AD,$04,h$01,$02:$01 "1UP" (#N(#PEEK(#PC)) is the attribute).
@ $71B1 label=2UP_Text
T $71B1,$04,h$01,$02:$01 "2UP" (#N(#PEEK(#PC)) is the attribute).
@ $71B5 label=HI_Text
T $71B5,$03,h$01,$01:$01 "HI" (#N(#PEEK(#PC)) is the attribute).

c $71B8 Reset Screen Buffer
E $71B8 View the equivalent code in;
. #LIST
. { #ATICATAC$80B4 }
. { #COOKIE$74D4 }
. { #LUNARJETMAN$84AD }
. { #PSSST$7439 }
. { #TRANZAM$7211 }
. LIST#
@ $71B8 label=ResetScreen
E $71B8 Continue on to #R$71BF to blank the screen buffer.
  $71B8,$03 #REGhl=#R$4000(screen buffer).
  $71BB,$02 #REGb=#N$58 (i.e. finish once we reach the start of #R$5800(attribute buffer)).
  $71BD,$02 #REGc=#N$00 (value to write).

c $71BF Reset Routine
E $71BF View the equivalent code in;
. #LIST
. { #ATICATAC$80BB }
. { #COOKIE$74DB }
. { #LUNARJETMAN$84B4 }
. { #PSSST$7440 }
. { #TRANZAM$7218 }
. LIST#
R $71BF HL Target address
R $71BF B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $71BF C Value to write
@ $71BF label=ResetCopier
  $71BF,$01 Write #REGc to the target address.
  $71C0,$01 Increment the target address by one.
  $71C1,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $71C3,$02 Keep looping back to #R$71BF until there is no carry-over.
  $71C5,$01 Return.

c $71C6 Reset Attribute Buffer
E $71C6 View the equivalent code in;
. #LIST
. { #ATICATAC$80C2 }
. { #COOKIE$74E2 }
. { #LUNARJETMAN$84BB }
. { #PSSST$7447 }
. { #TRANZAM$7200 }
. LIST#
@ $71C6 label=ResetAttributes
  $71C6,$03 #REGhl=#R$5800(attribute buffer).
  $71C9,$02 #REGb=#N$5B (i.e. finish once we reach the end of the #R$5800(attribute buffer)).
  $71CB,$02 #REGc=#N$47 (value to write).
  $71CD,$02 Jump to #R$71BF.

c $71CF Colourise Sprite
@ $71CF label=ColouriseSprite
  $71CF,$01 Switch to the shadow registers.
  $71D0,$03 #REGhl'=actor co-ordinates.
  $71D3,$03 Call #R$720E - #REGhl' now holds the co-ordinates to an attribute file address.
  $71D6,$04 #REGb'=width loop counter (in pixels).
  $71DA,$03 #REGa=#R$5DC3.
  $71DD,$04 #REGa=((#REGa / #N$04) + #N$01) / #N$02.
  $71E1,$02,b$01 Keep only bits 0-4.
  $71E3,$01 Increment #REGa by one.
  $71E4,$01 #REGc=height loop counter (in pixels).
  $71E5,$03 #REGd=object colour attribute.
  $71E8,$01 #REGe=width loop counter (in pixels).
@ $71E9 label=ColouriseSprite_Loop1
  $71E9,$01 Stash #REGhl on the stack.
@ $71EA label=ColouriseSprite_Loop2
  $71EA,$01 #REGa=actor Y position.
  $71EB,$08 Decrement position if address is outside of attribute file address range.
  $71F3,$01 Otherwise, set the colour at this location.
  $71F4,$01 Next tile column.
  $71F5,$05,b$01 Next tile if column < screen width (32 chars).
  $71FA,$03 Else, wrap-around and continue applying colour.
  $71FD,$01 #REGl=start of current row.
  $71FE,$02 Decrease counter by one and loop back to #R$71EA until counter is zero.
  $7200,$01 Restore #REGhl from the stack.
  $7201,$01 Stash #REGbc on the stack.
  $7202,$01 Clear the carry flag.
  $7203,$05 #REGhl -= 32 tiles. Places address pointer previous line.
  $7208,$01 Restore #REGbc from the stack.
  $7209,$01 #REGb=reset to original width counter.
  $720A,$01 Decrement height counter.
  $720B,$02 Repeat until all tiles have been coloured.
  $720D,$01 Return.

c $720E Calculate Attribute Address
E $720E View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #COOKIE$7534 }
. { #LUNARJETMAN$8506 }
. { #PSSST$748F }
. { #TRANZAM$7097 }
. LIST#
@ $720E label=AttributeAddress
N $720E Converts a given pixel address to the associated attribute buffer address.
R $720E HL Pixel address co-ordinates
R $720E O:HL Attribute buffer address
  $720E,$01 Horizontal co-ordinate.
  $720F,$03 Divide by #N$08.
  $7212,$02,b$01 Keep only bits 0-4 (#N$00-#N$1F / minimum-maximum horizontal screen values).
  $7214,$01 Store this back in #REGl.
  $7215,$01 Vertical co-ordinate.
  $7216,$02 Multiply by #N$04.
  $7218,$01 Store this in #REGc temporarily.
  $7219,$02,b$01 Keep only bits 5-7.
  $721B,$01 Set the bits from #REGl.
  $721C,$01 #REGl=#REGa.
  $721D,$01 Fetch the stored value from #REGc.
  $721E,$02,b$01 Keep only bits 0-1.
  $7220,$02,b$01 Set MSB of the attribute buffer #N$58. This ensures our value is >= #R$5800.
  $7222,$01 Store this back in #REGh.
  $7223,$01 Return.

c $7224

c $723C

c $725E

c $726A

c $72EE

c $7308 Calculate Screen Address
E $7308 View the equivalent code in;
. #LIST
. { #ATICATAC$9BA2 }
. { #COOKIE$76E3 }
. { #LUNARJETMAN$851E }
. { #PSSST$759A }
. { #TRANZAM$6F10 }
. LIST#
@ $7308 label=ScreenAddress
  $7308,$01 #REGa=#REGl.
  $7309,$03 #REGa=#REGa / #N$08.
  $730C,$02,b$01 Keep only bits 0-4.
  $730E,$01 #REGl=#REGa.
  $730F,$01 #REGa=#REGh.
  $7310,$02 #REGa=#REGa * #N$04.
  $7312,$02,b$01 Keep only bits 5-7.
  $7314,$01
  $7315,$01 #REGl=#REGa.
  $7316,$01 #REGa=#REGh.
  $7317,$02,b$01 Keep only bits 0-2.
  $7319,$01 Switch to the shadow #REGaf register.
  $731A,$01 #REGa=#REGh.
  $731B,$03 #REGa=#REGa / #N$08.
  $731E,$02,b$01 Keep only bits 3-4.
  $7320,$02,b$01 Set bit 6.
  $7322,$01 #REGh=#REGa.
  $7323,$01 Switch to the shadow #REGaf register.
  $7324,$01
  $7325,$01 #REGh=#REGa.
  $7326,$01 Return.

c $7327 Store Entity
E $7327 View the equivalent code in;
. #LIST
. { #ATICATAC$9FFB }
. { #COOKIE$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$75B9 }
. { #TRANZAM$71ED }
. LIST#
@ $7327 label=StoreEntity
  $7327,$06 Copy actor X position to active actor X position.
  $732D,$06 Copy actor Y position to active actor Y position.
  $7333,$06 Copy actor movement to active actor movement.
  $7339,$01 Return.

c $733A Controls: Kempston Joystick
E $733A View the equivalent code in;
. #LIST
. { #ATICATAC$0000 }
. { #COOKIE$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$75CC }
. { #TRANZAM$0000 }
. LIST#
@ $733A label=ReadKempstonJoystick
R $733A A Joystick controls
  $733A,$02 #REGa=controls.
  $733C,$01 Flip the bits.
  $733D,$01 Return.

c $733E Input: Left/ Right
E $733E View the equivalent code in;
. #LIST
. { #TRANZAM$618C }
. LIST#
N $733E Check if this should be read from the Kempston joystick instead?
@ $733E label=ReadInputLR
  $733E,$07 If #R$5CF3 indicates the control method is via the Kempston joystick then jump to #R$733A.
N $7345 Check for "Left" and "Right" button inputs for port #N$FE.
  $7345,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $734B,$02,b$01 Strip out the SHIFT key.
  $734D,$04 If none of these keys have been pressed, jump to #R$7359.
  $7351,$02,b$01 Keep only bits 2 ("X") and 4 ("V").
  $7353,$04 If neither key is pressed jump to #R$736B.
  $7357,$02 Jump to #R$736E.
N $7359 Check for "Left" and "Right" button input for port #N$7F.
@ $7359 label=ReadInputLR_7F
  $7359,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | FULL-STOP | M | N | B }
. TABLE#
  $735F,$02,b$01 Strip out the SPACE key.
  $7361,$04 If none of these keys have been pressed, jump to #R$7371.
  $7365,$02,b$01 Keep only bits 2 ("M") and 4 ("B").
  $7367,$04 If neither key is pressed jump to #R$736E.
N $736B Return "Left" button pressed.
@ $736B label=Input_Left
  $736B,$02 #REGa=#EVAL($FD, $02, $08).
  $736D,$01 Return.
N $736E Return "Right" button pressed.
@ $736E label=Input_Right
  $736E,$02 #REGa=#EVAL($FE, $02, $08).
  $7370,$01 Return.
N $7371 Return "no input".
@ $7371 label=Input_None
  $7371,$02 #REGa=#EVAL($FF, $02, $08).
  $7373,$01 Return.

c $7374 Input: Fire
E $7374 View the equivalent code in;
. #LIST
. { #TRANZAM$61C2 }
. LIST#
N $7374 Check if this should be read from the Kempston joystick instead?
@ $7374 label=ReadInputFire
  $7374,$07 If #R$5CF3 indicates the control method is via the Kempston joystick then jump to #R$733A.
N $737B Check for "Fire" button input.
  $737B,$02 #REGb=#N$02 (counter for checking two ports).
  $737D,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { $FD | A | S | D | F | G }
. { $BF | ENTER | L | K | J | H }
. TABLE#
@ $737F label=ReadInputFire_Loop
  $7383,$02,b$01 Keep only bits 0-4.
  $7385,$04 If any buttons were pressed jump to #R$7390.
  $7389,$02 #REGa=switch to port #N$BF.
  $738B,$02 Decrease counter by one and loop back to #R$737F until counter is zero.
N $738D Return "no input".
  $738D,$02 #REGa=#EVAL($FF, $02, $08).
  $738F,$01 Return.
N $7390 Return "Fire" button pressed.
@ $7390 label=Input_Fire
  $7390,$02 #REGa=#EVAL($EF, $02, $08).
  $7392,$01 Return.

c $7393 Input: Thrust
E $7393 View the equivalent code in;
. #LIST
. { #TRANZAM$61E0 }
. LIST#
N $7393 Check if this should be read from the Kempston joystick instead?
@ $7393 label=ReadInputThrust
  $7393,$07 If #R$5CF3 indicates the control method is via the Kempston joystick then jump to #R$733A.
  $739A,$02 #REGb=#N$02 (counter for checking two ports).
  $739C,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { $FB | Q | W | E | R | T }
. { $DF | P | O | I | U | Y }
. TABLE#
@ $739E label=ReadInputThrust_Loop
  $73A2,$02,b$01 Keep only bits 0-4.
  $73A4,$04 If any buttons were pressed jump to #R$73AF.
  $73A8,$02 #REGa=switch to port #N$DF.
  $73AA,$02 Decrease counter by one and loop back to #R$737F until counter is zero.
N $73AC Return "no input".
  $73AC,$02 #REGa=#EVAL($FF, $02, $08).
  $73AE,$01 Return.
N $73AF Return "Thrust" button pressed.
@ $73AF label=Input_Thrust
  $73AF,$02 #REGa=#EVAL($F7, $02, $08).
  $73B1,$01 Return.

c $73B2 Game Play Starts
@ $73B2 label=GamePlayStarts

c $73D3 Jetman Fly
@ $73D3 label=JetmanThrust

  $7445,$02 Decrease #REGb by one, and loop back to #R$7439 until zero

c $7571 Jetman Walk
@ $7571 label=JetmanWalk

c $761D
  $766A,$02 Decrease #REGb by one, and loop back to #R$7622 until zero

c $766D
  $76A1,$02 Decrease #REGb by one, and loop back to #R$769E until zero
  $76CC,$02 Decrease #REGb by one, and loop back to #R$76CA until zero
  $76D8,$02 Decrease #REGb by one, and loop back to #R$7672 until zero

b $76E2 Platform Graphics
@ $76E2 label=UDG_Platform
D $76E2 Middle section repeats for both floor and platforms
N $76E2 #UDGARRAY6,attr=$04,scale=$04;(#PC);(#PC+$08)x$04;(#PC + $10)(platform)
N $76E2 #UDGARRAY6,attr=$06,scale=$04;(#PC);(#PC+$08)x$02;(#PC + $10)(floor)
N $76E2 Left-hand Platform UDG
B $76E2 #UDG#(#PC),attr=$04
N $76EA Middle Platform UDG
B $76EA #UDG#(#PC),attr=$04
N $76F2 Right-hand Platform UDG
B $76F2 #UDG#(#PC),attr=$04

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
  $76FA,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $76FA) / 2)) #JETMANNAME((#PC - $76FA) / $02).
L $76FA,$02,$10

w $771A

c $773A Mask Sprite
@ $773A label=MaskSprite

@ $777C label=ActorUpdateSizeFlipReg
@ $777D label=ActorUpdateSize
@ $7790 label=ActorUpdateHeightAndMask

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
