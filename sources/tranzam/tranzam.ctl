> $4000 @org=$4000
> $4000 @start=$5B80
b $4000 Loading screen
D $4000 #UDGTABLE { #SCR(loading) | Tranz Am Loading Screen. } TABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$300,$20 Attributes

i $5B00

c $5B80 Game entry point
E $5B80 View the equivalent code in;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #PSSST$5B80 }
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

c $5CB0

i $5CB1

g $5E00 Best Time
@ $5E00 label=BestTime_1
B $5E00,$01
@ $5E01 label=BestTime_2
B $5E01,$01
@ $5E02 label=BestTime_3
B $5E02,$01

g $5E03 Flag: Best Time
@ $5E03 label=Flag_BestTime
D $5E03 When a value for "Best Time" exists this will be #N$01 else it'll be #N$00.
B $5E03,$01

g $5E04

g $5E05 Player Map Co-ordinates
@ $5E05 label=PlayerMapPosition
B $5E05,$02

g $5E07
B $5E07,$01

g $5E08
B $5E08,$02,$01

g $5E0A Fuel
@ $5E0A label=Fuel_LSB
@ $5E0B label=Fuel_MSB
B $5E0A,$02,$01

g $5E0C Temperature
@ $5E0C label=Temperature
B $5E0C,$01

g $5E0D Speed
@ $5E0D label=Speed
B $5E0D,$01

g $5E0E

g $5E10 Player Direction
@ $5E10 label=Player_Direction
B $5E10,$02,$01

g $5E12

g $5E13

g $5E17 Player X
@ $5E17 label=Player_X
B $5E17,$01

g $5E18 Player Y
@ $5E18 label=Player_Y
B $5E18,$01

g $5E19 Current Object
@ $5E19 label=CurrentObject
D $5E19 The currently processed #R$7811 entry.
W $5E19,$02

g $5E1B
B $5E1B,$01

g $5E1C
W $5E1C,$02

g $5E1E
B $5E1E,$01

g $5E1F
B $5E1F,$01

g $5E20 Actor Buffer
@ $5E20 label=Actor_Position_X
B $5E20,$01 X Position.
@ $5E21 label=Actor_Position_Y
B $5E21,$01 Y Position.
B $5E22,$01 Movement direction.
@ $5E23 label=HeightPixels
B $5E23,$01 Height (in pixels).
@ $5E24 label=WidthBytes
B $5E24,$01 Width (in bytes).
@ $5E25 label=CurrentSpriteHeight
B $5E25,$01 Current Sprite Height
@ $5E26 label=HeightLines
B $5E26,$01 Height lines.

g $5E27 Actor Screen Position
@ $5E27 label=ActorScreenPosition
B $5E27,$01 X Position.
B $5E28,$01 Y Position.

g $5E29 Game Timer
D $5E29 16-bit counter starting at 0x0000 and counting +1 (each time a sprite is moved or redrawn), although sometimes
.       it will increment + #N$02. This continues until the whole game is over - for both 1 and 2 player games. Counter
.       loops around after reaching #N$FFFF.
@ $5E29 label=GameTimer
W $5E29,$02

g $5E2B

g $5E2C Width Counter
D $5E2C Temporary counter used when drawing sprites.
@ $5E2C label=WidthCounter
B $5E2C,$01

g $5E2D Miles
@ $5E2D label=Miles
B $5E2D,$03

g $5E30 Unknown
@ $5E30 label=Unknown
B $5E30,$01

g $5E31 Time
@ $5E31 label=Time_1
B $5E31,$01
@ $5E32 label=Time_2
B $5E32,$01
@ $5E33 label=Time_3
B $5E33,$01

g $5E34 Player World Co-ordinates
@ $5E34 label=PlayerWorldPosition
B $5E34,$02 Player X/ Y position in relation to the whole "World".

g $5E36

g $5E38

g $5E39 Current Place
@ $5E39 label=CurrentPlaceID
D $5E39 This value will either be the current Place ID or #N$FF to indicate being open to entering a new place (to
.       avoid repetition).
B $5E39,$01 Current Place ID or #N$FF.

g $5E3A

g $5E3C Cups Collected
@ $5E3C label=Cups_Collected
B $5E3C,$01

g $5E3D Player Lives
@ $5E3D label=Player_Lives
B $5E3D,$01

g $5E3E Game Options
D $5E3E #TABLE(default,centre,centre)
. { =h Byte | =h Binary | =h Option }
. { #N$00 | #EVAL($00, 2, 8) | Keyboard }
. { #N$02 | #EVAL($02, 2, 8) | Joystick }
. TABLE#
@ $5E3E label=GameOptions
B $5E3E,$01

g $5E3F Current Menu Item Colour attribute
@ $5E3F label=Current_MenuAttr
B $5E3F,$01

g $5E40
g $5E41
g $5E42

g $5E43
B $5E43,$01

g $5E44 Background Attribute
@ $5E44 label=Background_Attribute
B $5E44,$01

g $5E45

g $5E46 Sound Counter
D $5E46 Used as a counter for the cup collection and refuelling sounds.
@ $5E46 label=SoundCounter
B $5E46,$01

g $5E47 Sound Store
@ $5E47 label=SoundStore
B $5E47,$01

g $5E48 Temporary Text Item X Position
D $5E48 Used for the indent for; #LIST { #R$5F6C(Game Menu items) } { #R$607D(Congratulations Messaging) } LIST#
@ $5E48 label=Temp_Text_Pos_X
B $5E48,$01

g $5E49 High Score
E $5E49 View the equivalent code in;
. #LIST
. { #COOKIE$5F09 }
. { #JETPAC$5CF0 }
. { #LUNARJETMAN$5E06 }
. { #PSSST$5E00 }
. LIST#
D $5E49 3-byte representation of the score.
@ $5E49 label=HighScore_1
B $5E49,$01 Byte #1.
@ $5E4A label=HighScore_2
B $5E4A,$01 Byte #2.
@ $5E4B label=HighScore_3
B $5E4B,$01 Byte #3.

g $5E4C Score
D $5E4C 3-byte representation of the score.
@ $5E4C label=Score_1
B $5E4C,$01 Byte #1.
@ $5E4D label=Score_2
B $5E4D,$01 Byte #2.
@ $5E4E label=Score_3
B $5E4E,$01 Byte #3.

g $5E4F

g $5E50 Objects
@ $5E50 label=Object_1_State
@ $5E53 label=Object_2_State
@ $5E56 label=Object_3_State
@ $5E59 label=Object_4_State
@ $5E5C label=Object_5_State
@ $5E5F label=Object_6_State
@ $5E62 label=Object_7_State
@ $5E65 label=Object_8_State
N $5E50 Object #N($01 + (#PC - $5E50) / $03).
B $5E50,$01 Sprite ID.
B $5E51,$01 X Position.
B $5E52,$01 Y Position.
L $5E50,$03,$08

g $5E68
g $5E74

g $5E80 Explosion Entity?
B $5E80,$01 Frame ID.
B $5E81,$01 X position.
B $5E82,$01 Y position.

g $5E8C

g $5E90
W $5E90,$02

g $5E92
W $5E92,$02

g $5E94

g $5E98 Black Car?
B $5E98,$01 Sprite ID.
B $5E99,$01 X Position.
B $5E9A,$01 Y Position.

g $5E9C
g $5E9E

g $5EA4

c $5F00 Security Check
E $5F00 Continue on to #R$5F07.
E $5F00 View the equivalent code in;
. #LIST
. { #ATICATAC$6000 }
. { #COOKIE$5F00 }
. { #LUNARJETMAN$8000 }
. { #PSSST$61C6 }
. LIST#
@ $5F00 label=SecurityCheck
  $5F00,$01 Disable interrupts.
  $5F01,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $5F04,$03 Return if #REGa is not #N$58.

c $5F07 Game Initialisation
N $5F07 Blank the game configs.
E $5F07 View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #COOKIE$6298 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$800A }
. { #PSSST$61CD }
. LIST#
@ $5F07 label=GameInitialisation
  $5F07,$0D Write #N$00 to #N$00A3 bytes starting from #N($5E00, $04, $04).
  $5F14,$06 Write #N$FFFF to #R$5E00(BestTime) - this isn't used anywhere until #R$5E03 is set.
@ $5F1A label=Game_Restart
  $5F1A,$06 Write #N$FFFF to #R$5E34.
  $5F20,$03 Set the stack pointer to #N($5E00, $04, $04).
  $5F23,$03 Call #R$6175.
  $5F26,$03 Call #R$68A0.
@ $5F29 label=GameSelect_Loop
  $5F29,$03 Call #R$5F6C.
N $5F2C The "Best Time Today" banner only shows when one is set. The flag at #R$5E03 toggles it on/ off.
  $5F2C,$07 If #R$5E03 is not zero, call #R$6483.
  $5F33,$04 #REGd=#R$5E3E.
  $5F37,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $5F3D,$01 Flip the bits.
N $5F3E Handle keyboard selection.
@ $5F3E label=GameSelect_CheckKeyboard
  $5F3E,$02 Has key "1" been pressed? ("1 KEYBOARD").
  $5F40,$02 If not jump to #R$5F44.
  $5F42,$02 Set control method = keyboard.
N $5F44 Handle joystick selection.
@ $5F44 label=GameSelect_CheckJoystick
  $5F44,$02 Has key "2" been pressed? ("2 JOYSTICK").
  $5F46,$02 If not jump to #R$5F4A.
  $5F48,$02 Set control method = joystick.
N $5F4A Handle starting a new game.
@ $5F4A label=GameSelect_CheckStart
  $5F4A,$02 Has key "3" been pressed? ("3 START GAME").
  $5F4C,$03 If it has then jump to #R$5FEF.
N $5F4F Handle flashing each selection.
  $5F4F,$04 Write #REGd to #R$5E3E.
  $5F53,$03 #REGhl=#R$5FA8(GameSelection_Attributes) + #N$01 (i.e. ignoring "Game Selection" as it doesn't flash).
  $5F56,$04 #REGc=#R$5E3E.
  $5F5A,$04 If the joystick option is selected, jump to #R$5F65.
N $5F5E Set the first menu item, unset the second.
@ $5F5E label=MenuAttributeSetFirst
  $5F5E,$02 Set the FLASH attribute for the first selection.
  $5F60,$01 Move onto the next menu attribute.
  $5F61,$02 Unset the FLASH attribute for the second selection.
  $5F63,$02 Jump to #R$5F29.
N $5F65 Unset the first menu item, set the second.
@ $5F65 label=MenuAttributeSetSecond
  $5F65,$02 Unset the FLASH attribute for the first selection.
  $5F67,$01 Move onto the next menu attribute.
  $5F68,$02 Set the FLASH attribute for the second selection.
  $5F6A,$02 Jump to #R$5F29.

c $5F6C Game Selection Menu
E $5F6C View the equivalent code in;
. #LIST
. { #ATICATAC$7CAF }
. { #COOKIE$6332 }
. { #JETPAC$6260 }
. { #LUNARJETMAN$80D1 }
. { #PSSST$6250 }
. LIST#
@ $5F6C label=GameMenu
  $5F6C,$05 Write #N$68 to #R$5E48.
  $5F71,$03 #REGde=#R$5FA7.
  $5F74,$01 Switch to the shadow registers.
  $5F75,$03 #REGhl'=#R$5FAC.
  $5F78,$03 #REGde'=#R$5FB1.
N $5F7B There are five lines of text.
  $5F7B,$02 #REGb'=#N$05 (counter).
@ $5F7D label=GameMenu_Loop
  $5F7D,$01 Switch back to the normal registers.
  $5F7E,$04 Copy a byte from #REGde to #R$5E3F.
  $5F82,$01 Increment #REGde by one.
  $5F83,$01 Switch to the shadow registers.
  $5F84,$01 Stash #REGbc' on the stack.
  $5F85,$01 #REGa=#REGhl' (grab the position data).
  $5F86,$01 Increment #REGhl' (position data pointer) by one.
  $5F87,$01 Stash #REGhl' (position data pointer) on the stack.
  $5F88,$01 #REGh'=#REGa.
  $5F89,$04 #REGl'=#R$5E48.
  $5F8D,$03 Call #R$5F97.
  $5F90,$01 Switch back to the normal registers.
  $5F91,$02 Restore #REGhl and #REGbc from the stack.
  $5F93,$01 Increase #REGde by one.
  $5F94,$02 Decrease counter by one and loop back to #R$5F7D until counter is zero.
  $5F96,$01 Return.

c $5F97 Write Menu Line
E $5F97 View the equivalent code in;
. #LIST
. { #ATICATAC$7D8A }
. { #COOKIE$63E0 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$62E7 }
. LIST#
@ $5F97 label=MenuWriteText
  $5F97,$01 Stash #REGhl containing the co-ordinate on the stack.
  $5F98,$03 Call #R$6F10.
  $5F9B,$03 #REGa=the menu attribute byte from #R$5E3F.
  $5F9E,$01 Switch to the shadow #REGaf register.
  $5F9F,$01 Switch to the shadow registers.
  $5FA0,$01 Restore #REGhl from the stack.
  $5FA1,$03 Call #R$7097.
  $5FA4,$03 Jump to #R$6524.

b $5FA7 Game Select Attribute Table
E $5FA7 View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #COOKIE$635E }
. { #JETPAC$628D }
. { #LUNARJETMAN$810E }
. { #PSSST$627C }
. LIST#
@ $5FA7 label=GameSelection_Attributes
  $5FA7,$05,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | Game Selection }
. { #N$02 | 1 Keyboard }
. { #N$03 | 2 Joystick }
. { #N$04 | 3 Start Game }
. { #N$05 | © 1983 A.C.G. }
. TABLE#

b $5FAC Game Select Y Position Table
E $5FAC View the equivalent code in;
. #LIST
. { #ATICATAC$7CF1 }
. { #COOKIE$6365 }
. { #JETPAC$6293 }
. { #LUNARJETMAN$8115 }
. { #PSSST$6282 }
. LIST#
@ $5FAC label=GameSelection_Position
  $5FAC,$05,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | Game Selection }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | 1 Keyboard }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | 2 Joystick }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | 3 Start Game }
. { #N$05 | #EVAL(#PEEK(#PC+$04) / $08) | © 1983 A.C.G. }
. TABLE#

t $5FB1 Game Selection Screen Text
E $5FB1 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #COOKIE$636C }
. { #JETPAC$6299 }
. { #LUNARJETMAN$811C }
. { #PSSST$6288 }
. LIST#
@ $5FB1 label=GameSelection_Text
  $5FB1,$0E,$0D:$01 "GAME SELECTION".
  $5FBF,$0B,$0A:$01 "1  KEYBOARD".
  $5FCA,$0B,$0A:$01 "2  JOYSTICK".
  $5FD5,$0D,$0C:$01 "3  START GAME".
  $5FE2,$0D,h$01,$0B:$01 "© 1983 A.C.G.".

c $5FEF Start Game
E $5FEF View the equivalent code in;
. #LIST
. { #ATICATAC$7D9A }
. { #COOKIE$6428 }
. { #JETPAC$6333 }
. { #LUNARJETMAN$81BB }
. { #PSSST$631E }
. LIST#
@ $5FEF label=StartGame
  $5FEF,$07 #HTML(Write #N$00 to #LIST { <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> } { #R$5E74 } LIST#)
N $5FF6 Reset the players life count.
  $5FF6,$05 Write starting lives to #R$5E3D.
N $5FFB Reset the players score (#N$03 digits).
  $5FFB,$03 #REGhl=#R$5E4C.
  $5FFE,$02 #REGb=#N$03.
@ $6000 label=ResetScore_Loop
  $6000,$02 Write #N$00 to #REGhl.
  $6002,$01 Increment #REGhl by one.
  $6003,$02 Decrease counter by one and loop back to #R$6000 until counter is zero.
  $6005,$01 Enable interrupts.
  $6006,$03 Call #R$6391.
  $6009,$04 #REGix=#R$5E80.
  $600D,$03 Set the stack pointer to #N($5E00, $04, $04).
@ $6010 label=MainLoop
  $6010,$03 #REGhl=#R$6A73.
  $6013,$01 Stash #REGhl on the stack.
  $6014,$03 #REGhl=#R$6028.
  $601B,$02,b$01 Keep only bits 1-6.
  $601D,$03 Create an offset in #REGbc.
  $6020,$01 #REGhl=#REGhl + offset.
  $6021,$04 #REGhl=address from #R$6028 + offset.
  $6025,$03 Jump to #R$5CB0.

w $6028 Main Jump Table
@ $6028 label=JumpTable_Main
  $6028,$08,$02

c $6030 Instant Return
@ $6030 label=Return
  $6030,$01 Return.

t $6031 Score/ Hi-Score Text
@ $6031 label=Text_ScoreHi
  $6031,$15,h$01,$13:$01

c $6046 Add Points To Score
E $6046 View the equivalent code in;
. #LIST
. { #JETPAC$70F9 }
. LIST#
R $6046 BC Points to add to score
@ $6046 label=AddPointsToScore
  $6046,$03 #REGhl=#R$5E4E.
  $6049,$01 #REGa=score byte #3.
  $604A,$02 Add #REGc to score byte #3 with BCD conversion.
  $604C,$01 Update score byte #3.
  $604D,$01 Move onto the next score byte.
  $604E,$01 #REGa=score byte #2.
  $604F,$02 Add (with carry) #REGb to score byte #2 with BCD conversion.
  $6051,$01 Update score byte #2.
  $6052,$01 Move onto the next score byte.
  $6053,$01 #REGa=score byte #1.
  $6054,$02 Add #N$00 (i.e. just the carry flag) to score byte #1 with BCD conversion.
  $6057,$01 Update score byte #1.
  $6058,$03 Jump to #R$6CB6.

c $605B Check High Score
E $605B View the equivalent code in;
. #LIST
. { #COOKIE$73D3 }
. { #JETPAC$6398 }
. LIST#
@ $605B label=CheckHighScore
  $605B,$03 #REGde=#R$5E49(#N$5E48) noting due to the INC below this is #R$5E49 - #N$01.
  $605E,$03 #REGhl=#R$5E4C(#N$5E4B) noting due to the INC below this is #R$5E4C - #N$01.
  $6061,$02 #REGb=#N$03 (scores are held in three digits).
@ $6063 label=CheckHighScore_Loop
  $6063,$01 Increment #REGhl by one.
  $6064,$01 Increment #REGde by one.
  $6065,$02 Check #REGde against #REGhl.
  $6067,$02 If the current score digit is higher than the same digit of the high score then jump to #R$606E.
  $6069,$02 If both the same digits of the current score and high score are the same number jump straight onto #R$606C.
  $606B,$01 Return if the current score digit is less than the same high score digit.
@ $606C label=CheckHighScore_Skip
  $606C,$02 Decrease counter by one and loop back to #R$6063 until counter is zero.
N $606E A new High Score has been made, so update #R$5E49(HighScore).
@ $606E label=NewHighScore
  $606E,$02 #REGb=#N$03 (scores are held in three digits).
  $6070,$03 #REGhl=#R$5E4C.
  $6073,$03 #REGde=#R$5E49.
@ $6076 label=NewHighScore_CopyLoop
  $6076,$02 Copy the byte from #REGhl to #REGde.
  $6078,$01 Increment #REGhl by one.
  $6079,$01 Increment #REGde by one.
  $607A,$02 Decrease counter by one and loop back to #R$6076 until counter is zero.
  $607C,$01 Return.

c $607D Display Congratulations Messaging
@ $607D label=DisplayCongratsMessaging
  $607D,$05 Write #N$50 to #R$5E48.
  $6082,$03 #REGde=#R$6091.
  $6085,$01 Switch to the shadow registers.
  $6086,$03 #REGhl'=#R$6095.
  $6089,$03 #REGde'=#R$6099.
  $608C,$02 #REGb'=#N$04.
  $608E,$03 Jump to #R$5F7D.
@ $6091 label=CongratsMessaging_Attributes
B $6091,$04
@ $6095 label=CongratsMessaging_Position
B $6095,$04,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | "CONGRATULATIONS YOU" }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | " HAVE SUCCESSFULLY" }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | "COLLECTED THE EIGHT" }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | " CUPS OF ULTIMATE" }
. TABLE#

t $6099 Text: Congratulations
@ $6099 label=Message_Congrats
  $6099,$13,$12:$01 "CONGRATULATIONS YOU".
  $60AC,$12,$11:$01 " HAVE SUCCESSFULLY".
  $60BE,$13,$12:$01 "COLLECTED THE EIGHT".
  $60D1,$12,$11:$01 " CUPS OF ULTIMATE".

c $60E3 Sounds: Bounce
@ $60E3 label=SoundsBounce
  $60E3,$03 #REGhl=#N($0000, $04, $04).
  $60E6,$02 #REGc=#N$08.
@ $60E8 label=SoundsBounce_Loop
  $60E8,$02 #REGe=#N$04.
  $60EA,$01 #REGa=the byte pointed to by #REGhl.
  $60EB,$01 Increment #REGhl by one.
  $60EC,$02,b$01 Keep only bits 0-6.
  $60EE,$02,b$01 Set bit 7.
  $60F0,$01 Store the result in #REGd.
@ $60F1 label=SoundsBounce_Play
  $60F1,$03 Call #R$614B.
  $60F4,$01 Decrease #REGe by one.
  $60F5,$02 If #REGe is not zero, jump to #R$60F1.
  $60F7,$01 Decrease #REGc by one.
  $60F8,$02 If #REGc is not zero, jump to #R$60E8.
  $60FA,$01 Return.

c $60FB Play Sound
@ $60FB label=PlaySound
  $60FB,$03 #REGa=#R$5E47.
  $60FE,$02 Flip speaker on/ off (flip bit 4).
  $6100,$03 Write #REGa back to #R$5E47.
  $6103,$02 Play sound.
  $6105,$01 Return.

c $6106
  $611A,$01 Return.

c $611B Sounds: Cup/ Refuel
@ $611B label=SoundsCupRefuel
  $611B,$03 #REGa=#R$5E29.
  $611E,$02,b$01 Keep only bit 0.
  $6120,$01 Return every other frame.
  $6121,$03 #REGhl=#R$5E46.
  $6124,$01 #REGa=item ID.
  $6125,$04 Jump to #R$613E if bit 7 is not set.
  $6129,$02 Return if item ID is zero.
  $612B,$01 Decrease #REGa/ item ID by one.
  $612C,$01 Store #REGa at #R$5E46.
  $612D,$01 Return if the new item ID is zero.
@ $612E label=SoundsRefuel
  $612E,$02 #REGa=#REGa * #N$04.
  $6130,$02,b$01 Keep only bits 2-4.
  $6132,$02,b$01 Set bit 5.
  $6134,$01 Store the result in #REGd.
  $6135,$02 #REGc=#N$20.
@ $6137 label=SoundsCupRefuel_Loop
  $6137,$03 Call #R$614B.
  $613A,$01 Decrease #REGc by one.
  $613B,$02 Jump back to #R$6137 until #REGc is zero.
  $613D,$01 Return.
@ $613E label=SoundsCup
  $613E,$02,b$01 Keep only bits 0-6.
  $6140,$01 Return if #REGa is now zero.
  $6141,$01 Decrease #REGa by one.
  $6142,$02,b$01 Set bit 7.
  $6144,$01 Store #REGa at #R$5E46.
  $6145,$02,b$01 Keep only bits 0-6.
  $6147,$01 Return if #REGa is now zero.
  $6148,$01 Flip the bits.
  $6149,$02 Jump to #R$612E.

c $614B Play square wave sound
@ $614B label=PlaySquareWave
R $614B D Duration of wave
  $614B,$03 Call #R$60FB.
  $614E,$01 #REGb=#REGd.
@ $614F label=PlaySquareWave_Loop_1
  $614F,$02 Decrease counter by one and loop back to #R$614F until counter is zero.
  $6151,$03 Call #R$60FB.
  $6154,$01 #REGb=#REGd.
@ $6155 label=PlaySquareWave_Loop_2
  $6155,$02 Decrease counter by one and loop back to #R$6155 until counter is zero.
  $6157,$01 Return.

c $6158 Sounds: Engine
@ $6158 label=SoundsEngine
  $6158,$03 #REGa=#R$5E0D.
  $615B,$02 Return if #R$5E0D is zero.
  $615D,$02 #REGa=#R$5E0D / #N$04.
  $615F,$01 Flip the bits.
  $6160,$02,b$01 Keep only bits 0-5.
  $6162,$01 Store the result in #REGd.
  $6163,$02 #REGc=#N$04.
  $6165,$07 If #R$5E80 is #N$03 then jump to #R$616E.
  $616C,$02 #REGb=#N$0C.
@ $616E label=SoundsEngine_Loop
  $616E,$03 Call #R$614B.
  $6171,$01 Decrease #REGc by one.
  $6172,$02 If #REGc is not zero, jump to #R$616E.
  $6174,$01 Return.

c $6175 Set Default Playarea Attributes
@ $6175 label=SetDefaultAttributes
E $6175 Continue on to #R$617B.
  $6175,$04 Write #N$00 to #R$5E43.
  $6179,$02 #REGa=#N$70.

c $617B Set Background Attribute
R $617B A Background attribute
@ $617B label=SetBackgroundAttr
  $617B,$03 Write #REGa to #R$5E44.
  $617E,$01 Return.

c $617F
  $617F,$05 Write #N$01 to #R$5E43.
  $6184,$02 #REGa=#N$40.
  $6186,$02 Jump to #R$617B.

c $6188 Controls: Kempston Joystick
@ $6188 label=ReadKempstonJoystick
R $6188 A Joystick controls
  $6188,$03 #REGa=controls.
  $618A,$01 Flip the bits.
  $618B,$01 Return.

c $618C Input: Left/ Right
E $618C View the equivalent code in;
. #LIST
. { #JETPAC$733E }
. LIST#
N $618C Check if this should be read from the Kempston joystick instead?
@ $618C label=ReadInputLR
  $618C,$07 If #R$5E3E indicates the control method is via the Kempston joystick then jump to #R$6188.
N $6193 Check for "Left" and "Right" button inputs for port #N$FE.
  $6193,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { $FE | SHIFT | Z | X | C | V }
. TABLE#
  $6199,$02,b$01 Strip out the SHIFT key.
  $619B,$04 If none of these keys have been pressed, jump to #R$61A7.
  $619F,$02,b$01 Keep only bits 2 ("X") and 4 ("V").
  $61A1,$04 If neither key is pressed jump to #R$61B9.
  $61A5,$02 Jump to #R$61BC.
N $61A7 Check for "Left" and "Right" button input for port #N$7F.
@ $61A7 label=ReadInputLR_7F
  $61A7,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { $7F | SPACE | FULL-STOP | M | N | B }
. TABLE#
  $61AD,$02,b$01 Strip out the SPACE key.
  $61AF,$04 If none of these keys have been pressed, jump to #R$61BF.
  $61B3,$02,b$01 Keep only bits 2 ("M") and 4 ("B").
  $61B5,$04 If neither key is pressed jump to #R$61BC.
N $61B9 Return "Left" button pressed.
@ $61B9 label=Input_Left
  $61B9,$02 #REGa=#EVAL($FD, $02, $08).
  $61BB,$01 Return.
N $61BC Return "Right" button pressed.
@ $61BC label=Input_Right
  $61BC,$02 #REGa=#EVAL($FE, $02, $08).
  $61BE,$01 Return.
N $61BF Return "no input".
@ $61BF label=Input_None
  $61BF,$02 #REGa=#EVAL($FF, $02, $08).
  $61C1,$01 Return.

c $61C2 Input: Brake
E $61C2 View the equivalent code in;
. #LIST
. { #JETPAC$7374 }
. LIST#
N $61C2 Check if this should be read from the Kempston joystick instead?
@ $61C2 label=ReadInputBrake
  $61C2,$07 If #R$5E3E indicates the control method is via the Kempston joystick then jump to #R$6188.
N $61C9 Check for "Brake" button input.
  $61C9,$02 #REGb=#N$02 (counter for checking two ports).
  $61CB,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { $FD | A | S | D | F | G }
. { $BF | ENTER | L | K | J | H }
. TABLE#
@ $61CD label=ReadInputBrake_Loop
  $61D1,$02,b$01 Keep only bits 0-4.
  $61D3,$04 If any buttons were pressed jump to #R$61DD.
  $61D7,$02 #REGa=switch to port #N$BF.
  $61D9,$02 Decrease counter by one and loop back to #R$61CD until counter is zero.
  $61DB,$02 Jump to #R$61BF.
N $61DD Return "Brake" button pressed.
@ $61DD label=Input_Brake
  $61DD,$02 #REGa=#EVAL($FB, $02, $08).
  $61DF,$01 Return.

c $61E0 Input: Accelerate
E $61E0 View the equivalent code in;
. #LIST
. { #JETPAC$7393 }
. LIST#
N $61E0 Check if this should be read from the Kempston joystick instead?
@ $61E0 label=ReadInputAccelerate
  $61E0,$07 If #R$5E3E indicates the control method is via the Kempston joystick then jump to #R$6188.
N $61E7 Check for "Accelerator" button input.
  $61E7,$02 #REGb=#N$02 (counter for checking two ports).
  $61E9,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { $FB | Q | W | E | R | T }
. { $DF | P | O | I | U | Y }
. TABLE#
@ $61EB label=ReadInputAccelerate_Loop
  $61EF,$02,b$01 Keep only bits 0-4.
  $61F1,$04 If any buttons were pressed jump to #R$61FB.
  $61F5,$02 #REGa=switch to port #N$DF.
  $61F7,$02 Decrease counter by one and loop back to #R$61EB until counter is zero.
  $61F9,$02 Jump to #R$61BF.
N $61FB Return "Accelerator" button pressed.
@ $61FB label=Input_Accelerate
  $61FB,$02 #REGa=#EVAL($F7, $02, $08).
  $61FD,$01 Return.

c $61FE
  $61FE,$03 Call #R$6253.
  $6201,$02 #REGa=#N$0C.
  $6206,$02 Jump to #R$622A.

  $6208,$03 Call #R$6253.
  $620B,$02 #REGa=#N$0E.
  $6210,$02 Jump to #R$6245.

c $6212
  $6212,$03 #REGhl=#R$5E05.
  $621E,$03 Call #R$6BF6.
  $6221,$03 Call #R$6253.
  $6224,$02 #REGa=#N$0C.
  $622D,$03 #REGhl=#R$5E08.
  $6239,$03 Call #R$6BF6.
  $623C,$03 Call #R$6253.
  $623F,$02 #REGa=#N$0E.
  $624C,$01 Return.
  $6251,$02 Jump to #R$6249.
  $6253,$02 #REGb=#N$02.
  $625B,$01 Return.

c $625C
  $625C,$03 #REGhl=#R$6513.
  $625F,$03 #REGbc=#N($0202, $04, $04).
  $6262,$03 Call #R$6991.
  $6265,$04 #REGix=#R$5E68.
  $6269,$04 #REGbc=#R$5E90.
  $626D,$04 #REGde=#R$5E92.
  $6271,$03 Call #R$6212.
  $6274,$03 #REGbc=#N($0004, $04, $04).
  $6279,$04 #REGbc=#R$5E9C.
  $627D,$04 #REGde=#R$5E9E.
  $6281,$03 Call #R$6212.
  $6284,$03 #REGbc=#N($0004, $04, $04).
  $6289,$03 Call #R$62DA.
  $628C,$04 #REGix=#R$5E68.
  $6290,$02 #REGc=#N$03.
  $6292,$02 #REGb=#N$02.
  $62A7,$01 Stash #REGbc on the stack.
  $62AA,$03 #REGbc=#N($0202, $04, $04).
  $62AD,$03 Call #R$6991.
  $62B0,$01 Restore #REGbc from the stack.
  $62BD,$03 #REGde=#N($0004, $04, $04).
  $62C5,$01 Return.
  $62C6,$03 #REGbc=#N($0202, $04, $04).
  $62C9,$03 Call #R$6998.
  $62CC,$01 Stash #REGbc on the stack.
  $62D8,$02 Jump to #R$62CD.

c $62DA Collision: Cups
E $62DA View the equivalent code in;
. #LIST
. { #PSSST$63AA }
. LIST#
@ $62DA label=CollisionCup
  $62DA,$03 #REGhl=#R$5E05.
  $62E1,$03 Call #R$6253.
  $62E5,$03 #REGhl=pointer to #R$721F.
  $62E8,$02 #REGb=#N$08 (set a counter for the #N$08 cups).
N $62EA Fetch the address of the cup from #R$721F.
@ $62EA label=CollisionCup_Loop
  $62EA,$01 #REGe=LSB of the cup map address.
  $62EB,$01 Increment #REGhl by one.
  $62EC,$01 #REGd=MSB of the cup map address.
  $62ED,$01 Increment #REGhl by one, ready to process the next cup.
N $62EE Check this is still a valid cup (that it hasn't been collected already).
  $62EE,$02 Increment #REGde by two (point to the sprite ID).
  $62F0,$05 If this is not a cup (the sprite ID is not #N$20), then jump to #R$6301.
N $62F5 This is still a valid cup, so process it.
  $62F5,$02 Decrease #REGde by two (go back to the start of the map record).
  $62F7,$01 Fetch the cup X position.
  $62F9,$04 Make sure we have a positive byte.
@ $62FD label=CollisionCup_Test_X
  $62FD,$04 If #N$0C is jump to #R$6306.
@ $6301 label=CollisionCup_Next
  $6301,$02 Decrease counter by one and loop back to #R$62EA until counter is zero.
  $6303,$03 Jump to #R$624D.
@ $6306 label=CollisionCup_Test_Y
  $6306,$01 Fetch the cup X position.
  $6307,$01 Increment #REGde by one.
  $6308,$01 #REGh=cup X position.
  $6309,$01 Fetch the cup Y position.
  $630A,$01 #REGd=cup Y position.
  $630B,$03 Call #R$6B30.
  $630E,$01 Swap the #REGde and #REGhl registers.
  $630F,$03 Call #R$6B2B.
  $6312,$01 Swap the #REGde and #REGhl registers.
  $6313,$01 #REGb=#REGh.
  $6314,$01 #REGc=#REGl.
  $6315,$03 Jump to #R$6212.

c $6318
  $631E,$03 Call #R$71ED.
  $6321,$03 Call #R$6557.
  $632C,$02,b$01 Keep only bits 0-1.
  $633A,$02 Jump to #R$6340.

c $633C

  $6340,$03
  $6346,$03 Call #R$7101.
  $634D,$05 Write #N$01 to #R$5E0D.
  $6352,$01 Return.

c $6353 Game Over
@ $6353 label=GameOver
  $6353,$03 Call #R$7139.
  $6356,$03 Call #R$617F.
N $6359 Give a 50/50 chance of "Night Driver" mode.
  $6359,$02 #REGa=random number.
  $635B,$02,b$01 Keep only bit 0.
  $635D,$02 If #REGa is zero jump to #R$6362.
  $635F,$03 Call #R$6175.
@ $6362 label=GameOver_Skip
  $6362,$03 #REGhl=#R$5E3D.
  $6365,$01 Decrease #R$5E3D by one.
  $636C,$03 Call #R$605B.
  $636F,$03 Call #R$6175.
  $6372,$03 Call #R$68A0.
  $6375,$03 #REGhl=#N($5878, $04, $04) (screen location).
  $6378,$03 #REGde=#R$63DA.
  $637B,$03 Call #R$5F97.
  $637E,$02 #REGb=#N$04.
  $6380,$03 Call #R$6386.
  $6383,$03 Jump to #R$5F1A.

c $6386 Delay Loop
R $6386 B Number of times to execute the delay
@ $6386 label=Delay
  $6386,$03 #REGhl=#N($0000, $04, $04) (large counter).
N $6389 From #REGhl being set above (and for each loop), decrementing #N($0000, $04, $04) by one gives #N$FFFF.
@ $6389 label=Delay_Loop
  $6389,$01 Decrease #REGhl by one.
  $638A,$04 Loop back to #R$6389 until #REGhl is zero.
  $638E,$02 Decrease counter by one and loop back to #R$6389 until counter is zero.
  $6390,$01 Return.

c $6391 Initialise New Game
@ $6391 label=GameInit
  $6391,$05 Write starting lives to #R$5E3D (duplicate of #R$5FF6 - possibly so POKEs would appear to not work?)
  $6396,$04 Write #N$00 to #R$5E3C.
  $639A,$03 Call #R$6498.
N $639D Reset miles and time.
  $639D,$03 #REGhl=#R$5E2D.
  $63A0,$02 #REGb=#N$07 (counter).
@ $63A2 label=GameInit_Reset
  $63A2,$02 Write #N$00 to #REGhl.
  $63A4,$01 Increment #REGhl by one.
  $63A5,$02 Decrease counter by one and loop back to #R$63A2 until counter is zero.
@ $63A7 label=PlayerInit
  $63A7,$03 Call #R$68A0.
  $63AA,$03 Call #R$653E.
  $63AD,$03 Call #R$656E.
  $63B0,$03 Call #R$6BFE.
  $63B3,$03 Call #R$6A09.
  $63B6,$06 Write #N($C000, $04, $04) (the maximum value for fuel) to #R$5E0A.
  $63BC,$0B Write #N($0000, $04, $04) to; #LIST { #R$5E0C } { #R$5E0E } { #R$5E10 } LIST#
  $63C7,$06 Write #N($0C40, $04, $04) to #R$5E05.
  $63CD,$06 Write #N($0640, $04, $04) to #R$5E08.
  $63D3,$04 Write #N$00 to #R$5E4F.
  $63D7,$03 Jump to #R$6BFE.

t $63DA Text: Game Over
@ $63DA label=Message_GameOver
  $63DA,$09,$08:$01 "GAME OVER".
@ $63E3 label=Message_YourTime
  $63E3,$0D,$0C:$01 "YOUR TIME WAS".
@ $63F0 label=Message_BestTime
  $63F0,$0F,$0E:$01 "BEST TIME TODAY".

c $63FF Handler: Pick Up Cup
@ $63FF label=HandlerCup
N $63FF Calculate number of points to award.
  $63FF,$03 #REGa=#R$5E3C.
  $6402,$03 #REGa=(#REGa + #N$01) * #N$02 with BCD conversion.
N $6405 Adds points to score.
  $6405,$03 #REGbc=number of points to award.
  $6408,$03 Call #R$6046.
N $640B Handle incrementing the cup counter.
  $640B,$04 Increment #R$5E3C by one.
N $640F Have all the cups been collected?
  $640F,$01 #REGa=#R$5E3C.
  $6410,$04 If #REGa is less than #N$08 jump to #R$646C.
N $6414 All cups have been collected, display the "congratulations" messaging.
  $6414,$03 Call #R$6175.
  $6417,$03 Call #R$68A0.
  $641A,$03 Call #R$607D.
N $641D Writes the line "YOUR TIME WAS".
  $641D,$03 #REGhl=#N($5868, $04, $04) (screen location).
  $6420,$03 #REGde=#R$63E3.
  $6423,$03 Call #R$5F97.
N $6426 Set #REGhl to where the time itself will display.
  $6426,$03 #REGhl=#N($6880, $04, $04) (screen location).
  $6429,$03 Call #R$6F10.
  $642C,$03 Call #R$6CEC.
N $642F Has a new "Best Time" been made?
  $642F,$06 If #R$5E03 is zero then jump to #R$645A.
  $6435,$03 Call #R$6483.
  $6438,$03 #REGhl=#R$5E00.
  $643B,$03 #REGde=#R$5E31.
  $643E,$02 #REGb=#N$03 (counter).
@ $6440 label=BestTime_Compare
  $6440,$02 Compare #REGde against #REGhl.
  $6442,$02 If it's higher than #REGa then jump to #R$645E.
  $6444,$02 If zero then jump to #R$6448.
  $6446,$02 Jump to #R$644C.
@ $6448 label=BestTime_Compare_Next
  $6448,$01 Move onto the next #R$5E00(BestTime) digit.
  $6449,$01 Move onto the next #R$5E31(Time) digit.
  $644A,$02 Decrease counter by one and loop back to #R$6440 until counter is zero.
@ $644C label=HandlerCup_Delay
N $644C Create a short pause.
  $644C,$02 #REGb=#N$0C.
  $644E,$03 Call #R$6386.
  $6451,$03 Call #R$6396.
  $6454,$03 Set the stack pointer to #N($5E00, $04, $04).
  $6457,$03 Jump to #R$6009.

c $645A Update "Best Time Today"
@ $645A label=BestTime_Set
  $645A,$01 Increment #REGa by one.
  $645B,$03 Store #REGa at #R$5E03.
@ $645E label=BestTime_Update
  $645E,$0C Write #R$5E31(Time) to #R$5E00(BestTime).
  $646A,$02 Jump to #R$644C.

c $646C Display Cups Collected
@ $646C label=DisplayCupsCollected
N $646C Prints the cup sprite to the screen.
  $646C,$03 #REGhl=#N$672E (screen location).
  $646F,$03 #REGde=#R$7F4A(SpriteCup).
  $6472,$03 Call #R$70DB.
  $6475,$03 Call #R$714C.
N $6478 Print the "cups collected" count to the screen.
  $6478,$03 #REGde=#R$5E3C.
  $647B,$03 #REGhl=#N$48C6.
  $647E,$02 #REGb=#N$01.
  $6480,$03 Jump to #R$6CD2.

c $6483 Display Best Time
@ $6483 label=DisplayBestTime
N $6483 Writes the line "BEST TIME TODAY".
  $6483,$03 #REGhl=#N($9060, $04, $04) (screen location).
  $6486,$03 #REGde=#R$63F0.
  $6489,$03 Call #R$5F97.
N $648C Set #REGhl to where the time itself will display.
  $648C,$03 #REGhl=#N($A080, $04, $04) (screen location).
  $648F,$03 Call #R$6F10.
N $6492 Point to Best Time.
  $6492,$03 #REGde=#R$5E00.
  $6495,$03 Jump to #R$6CFD.

c $6498
  $6498,$03 #REGbc=#R$7CD6 (one byte past the end of #R$7811).
  $649B,$02 #REGa=random number.
N $649D Limit the number to 0-63.
  $649D,$02,b$01 Keep only bits 0-5.
  $649F,$01 Store the result in #REGd.
  $64A0,$03 #REGhl=#N($0000, $04, $04).
  $64A3,$02 #REGde=#REGhl + #REGde.
  $64A5,$03 #REGhl=#R$7811(#N$7813).
  $64A8,$01 #REGa=#REGhl.
  $64A9,$04 If #REGa is #N$20 jump to #R$64B3.
  $64AD,$04 If #REGa is not #N$60 jump to #R$64BC.
  $64B1,$02
@ $64B3 label=HandlerSpriteCup
  $64B3,$01 Decrease #REGhl by one.
  $64B4,$01 #REGa=#REGde.
  $64B5,$01 Increment #REGde by one.
  $64B6,$02,b$01 Keep only bits 0-6.
  $64B8,$02 #REGa=#REGa + #N$20.
  $64BA,$01 Store #REGa at #REGhl.
  $64BB,$01 Increment #REGhl by one.
  $64BC,$03 Increment #REGhl by three.
  $64BF,$01 Stash #REGhl on the stack.
  $64C3,$01 Restore #REGhl from the stack.
  $64C4,$02 If ... jump to #R$64A8.
  $64C6,$01 Return.

c $64C7 Handler: Update Time
@ $64C7 label=HandlerTime
  $64C7,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $64CA,$03 Return if #REGa < #N$32.
  $64CD,$02 #REGa = #REGa - #N$32.
  $64CF,$03 #HTML(Write #REGa back to <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
N $64D2 Update the time from the smallest unit upwards.
N $64D2 Handles the "seconds".
  $64D2,$03 #REGhl=#R$5E33.
  $64D5,$01 Grab the seconds.
  $64D6,$01 Increase seconds by one.
  $64D7,$02 Write seconds back to #R$5E33.
  $64D9,$03 Return unless seconds have reached #N$60.
  $64DC,$02 Reset seconds to #N$00.
N $64DE Handles the "minutes".
  $64DE,$01 #REGhl=#R$5E32.
  $64DF,$01 Grab the minutes.
  $64E0,$01 Increase minutes by one.
  $64E1,$02 Write minutes back to #R$5E32.
  $64E3,$03 Return unless minutes have reached #N$60.
  $64E6,$02 Reset minutes to #N$00.
N $64E8 Handles the "hours".
  $64E8,$01 #REGhl=#R$5E31.
  $64E9,$01 Grab the hours.
  $64EA,$01 Increase hours by one.
  $64EB,$04,b$01 Keeping only bits 0-3, write hours back to #R$5E31.
  $64EF,$01 Return.

c $64F0 Display Place Name
R $64F0 A Bits 0-6 of #R$5E1F
@ $64F0 label=DisplayPlaceName
  $64F0,$03 Return if bit 6 of #REGa is set.
N $64F3 Strip out the bit which indicates the need to display the place name.
  $64F3,$02,b$01 Keep only bits 0-5.
  $64F5,$03 #REGde=#N($0005, $04, $04) (the minimum length of a place name without the "end-of-string" bit e.g.
.           "TUCSO(N)").
  $64F8,$03 #REGhl=#R$722F.
  $64FB,$04 Write #REGa + #N$01 to #R$5E39.
  $64FF,$02 #REGb=original value of #REGa (used as a counter for finding the place name text).
  $6501,$02 If #REGa is zero there's no need to search so jump immediately to #R$650B.
N $6503 Speed up (slightly) searching through place names by adding #REGde (#N($0005, $04, $04)) to the start address.
@ $6503 label=DisplayPlaceName_Search
  $6503,$01 Adds #REGde (#N($0005, $04, $04)) to the place name pointer.
N $6504 Search for the end of the current place name.
@ $6504 label=DisplayPlaceName_Loop
  $6504,$02 If bit 7 (the "end-of-string" flag) is not set...
  $6506,$01 Increment #REGhl by one.
  $6507,$02 ...then jump to #R$6504.
N $6509 #REGb stores the entry number of the place name, so keep going until we find it.
  $6509,$02 Decrease counter by one and loop back to #R$6503 until counter is zero.
N $650B Output the place name to the screen.
@ $650B label=DisplayPlaceName_Print
  $650B,$01 Switch the #REGde and #REGhl registers.
  $650C,$03 #REGhl=#N$B868 (screen location).
  $650F,$01 Stash #REGhl on the stack.
  $6510,$03 Call #R$6F10.
  $6513,$02 #REGa=#N$70 (attribute byte - BLACK ink on YELLOW paper).
  $6515,$01 Switch to the shadow #REGaf register.
  $6516,$02 Jump to #R$651F.

c $6518 Print Colour String
E $6518 View the equivalent code in;
. #LIST
. { #ATICATAC$A1F3 }
. { #COOKIE$7488 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$8A11 }
. { #PSSST$73ED }
. LIST#
@ $6518 label=PrintStringColour
R $6518 DE Pointer to string data
  $6518,$01 Stash #REGhl on the stack.
  $6519,$03 Call #R$6F10.
  $651C,$01 Fetch the attribute byte.
  $651D,$01 Switch to the shadow #REGaf register.
  $651E,$01 Increment #REGde by one to point to the text of the string.
  $651F,$01 Switch to the shadow registers.
  $6520,$01 Restore #REGhl from the stack.
  $6521,$03 Call #R$7097.
@ $6524 label=PrintString_Loop
  $6524,$01 Switch back to the normal registers.
  $6525,$01 Fetch the character to print.
  $6526,$04 If bit 7 is set (which signifies the end of the string), jump to #R$6535.
  $652A,$03 Call #R$6C96.
  $652D,$01 Increment #REGde by one.
  $652E,$01 Switch to the shadow registers.
  $652F,$01 Switch to the shadow #REGaf register.
  $6530,$01 Copy the attribute byte to the screen.
  $6531,$01 Increment #REGl by one.
  $6532,$01 Switch to the shadow #REGaf register.
  $6533,$02 Jump to #R$6524.
N $6535 Because the last character contains the terminator, it needs to be handled separately.
@ $6535 label=PrintString_LastCharacter
  $6535,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $6537,$03 Call #R$6C96.
  $653A,$01 Switch to the shadow registers.
  $653B,$01 Switch to the shadow #REGaf register.
  $653C,$01 Copy the attribute byte to the screen.
  $653D,$01 Return.

c $653E
  $653E,$04 #REGde=#R$5E08.
  $6546,$02 #REGa=#N$47.
  $654A,$03 #REGhl=#R$5E05.
  $6556,$01 Return.

c $6557
  $6557,$03 Call #R$653E.
  $655A,$01 Stash #REGhl on the stack.
  $655B,$04 #REGde=#R$5E36.
  $655F,$01 Reset the carry flag.
  $6560,$02 #REGhl=#REGhl - #REGde.
  $6562,$01 Restore #REGhl from the stack.
  $6563,$02 Jump to #R$657A if the result was zero.
  $6565,$01 Stash #REGhl on the stack.
  $6566,$03 #REGhl=#R$5E36.
  $6569,$03 #REGa=#R$5E38.
  $656C,$01 Store #REGa at #REGhl.
  $656D,$01 Restore #REGhl from the stack.
  $656E,$01 Stash #REGhl on the stack.
  $656F,$03 Call #R$6F10.
  $6572,$03 Store #REGhl at #R$5E36.
  $6575,$01 #REGa=the byte #REGhl is pointing at.
  $6576,$03 Store #REGa at #R$5E38.
  $6579,$01 Restore #REGhl from the stack.
  $657A,$03 #REGbc=#N($0101, $04, $04).
  $657D,$03 #REGa=#R$5E29.
  $6580,$02,b$01 Keep only bit 3.
  $6582,$03 If the result is not zero, jump to #R$6998.
  $6585,$03 Jump to #R$6991.

c $6588
  $6588,$03 #REGhl=#R$5E34.
  $658B,$03 #REGa=#R$5E05.
  $6590,$03 #REGa=#R$5E08.
  $6595,$01 Stash #REGhl on the stack.
  $6598,$01 Restore #REGhl from the stack.
  $659A,$01 Stash #REGde on the stack.
  $659B,$04 #REGix=#R$65FD.
  $659F,$02 #REGb=#N$10.
  $65A1,$01 Stash #REGbc on the stack.
  $65A2,$03 Call #R$65B1.
  $65A9,$01 Restore #REGbc from the stack.
  $65AC,$01 Restore #REGhl from the stack.
  $65AD,$03 Write #REGhl to #R$5E34.
  $65B0,$01 Return.

c $65B1
  $65B1,$03 #REGbc=#N$0202.
  $65BE,$02,b$01 Keep only bits 1-7.
  $65D9,$03 #REGbc=#N$0202.
  $65DC,$01 Stash #REGhl on the stack.
  $65DD,$03 Call #R$6998.
  $65E0,$01 Restore #REGhl from the stack.
  $65E1,$01 Stash #REGde on the stack.
  $65E2,$03 Call #R$7097.
  $65E5,$01 Restore #REGde from the stack.
  $65E6,$06 Jump to #R$65F8 if #R$5E43 is zero.
  $65EC,$03 #REGa=#R$5E44.
  $65EF,$02,b$01 Set bits 0-2.
  $65F7,$01 Return.
  $65F8,$03 #REGa=#R$5E44.
  $65FB,$02 Jump to #R$65F1.

b $65FD Terrain Dots
@ $65FD label=TerrainDots
  $65FD,$02 Entity #N($01 + (#PC - $65FD) / $02) X/ Y co-ordinates.
L $65FD,$02,$10

c $661D

c $6633
  $6639,$03 Call #R$71ED.
  $664D,$02,b$01 Keep only bits 0-3.
  $664F,$03 Create an offset in #REGhl.

  $6675,$02,b$01 Keep only bits 0-3.
  $6677,$03 Create an offset in #REGhl.

  $668B,$04 #REGde=#R$5E08.
  $6695,$03 Call #R$6BF6.
  $669D,$04 #REGde=#R$5E05.
  $66A6,$03 Call #R$6BF6.
  $66AA,$02,b$01 Set bit 1.

  $66FF,$03 #REGhl=#R$683B.

  $6720,$03 #REGa=#R$5E43.
  $6728,$03 #REGhl=#R$6837.

  $6802,$03 Call #R$6106.
  $6805,$02 Jump to #R$681A.

c $6826

b $6837
B $683B

c $687B Display Lives
E $687B View the equivalent code in;
. #LIST
. { #ATICATAC$0000 }
. { #COOKIE$7378 }
. { #JETPAC$70A4 }
. { #LUNARJETMAN$894F }
. { #PSSST$7325 }
. LIST#
@ $687B label=DisplayPlayerLives
  $687B,$05 Return if #R$5E3D is zero.
  $6880,$01 #REGb=#R$5E3D.
  $6881,$03 #REGhl=#N$BC08.
  $6884,$04 Write #N$00 to #R$5E41.
@ $6888 label=DisplayPlayerLives_Loop
  $6888,$03 #REGde=#R$7CD6(SpriteCar_1).
  $688B,$03 Call #R$6891.
  $688E,$02 Decrease counter by one and loop back to #R$6888 until counter is zero.
  $6890,$01 Return.
N $6891 Print the player sprite.
@ $6891 label=DisplayPlayerLives_Print
  $6891,$02 Stash #REGbc and #REGhl on the stack.
  $6893,$03 Call #R$70DB.
  $6896,$03 Call #R$714C.
  $6899,$02 Restore #REGhl and #REGbc from the stack.
N $689B Move onto the next life "slot".
  $689B,$04 #REGl=#REGl + #N$10.
  $689F,$01 Return.

c $68A0 Create Game Window
@ $68A0 label=CreateWindow
  $68A0,$0A Write #N$00 to #N$0C bytes starting from #R$5E68.
  $68AA,$06 Write #N$FFFF to #R$5E34.
  $68B0,$03 #REGhl=#R$65FD.
  $68B3,$02 #REGb=#N$10.
@ $68B5 label=CreateWindow_Terrain
  $68B5,$02 Reset bit 0 of the byte #REGhl is pointing to.
  $68B7,$02 Increment #REGhl by two.
  $68B9,$02 Decrease counter by one and loop back to #R$68B5 until counter is zero.
  $68BB,$03 Call #R$7200.
  $68BE,$03 Call #R$69BC.
  $68C1,$03 Call #R$6949.
  $68C4,$03 Call #R$646C.
  $68C7,$03 Call #R$687B.
  $68CA,$03 Call #R$6CDE.
  $68CD,$03 #REGhl=#N$5808 (attribute buffer).
  $68D0,$03 #REGbc=#N($1801, $04, $04).
  $68D3,$01 Stash #REGbc on the stack.
  $68D4,$03 Call #R$6900.
  $68D7,$03 #REGhl=#N$5AE8 (attribute buffer).
  $68DA,$01 Restore #REGbc from the stack.
  $68DB,$03 Call #R$6900.
  $68DE,$03 #REGhl=#N$5828 (attribute buffer).
  $68E1,$03 #REGbc=#N($0116, $04, $04).
  $68E4,$01 Stash #REGbc on the stack.
  $68E5,$03 Call #R$6900.
  $68E8,$01 Restore #REGbc from the stack.
  $68E9,$03 #REGhl=#N$583F (attribute buffer).
  $68EC,$03 Call #R$6900.
  $68EF,$03 #REGhl=#N($0050, $04, $04).
  $68F2,$03 #REGde=#R$6031.
  $68F5,$03 Call #R$6518.
  $68F8,$03 Call #R$6CB6.
  $68FB,$03 Call #R$6CBE.
  $68FE,$02 Jump to #R$6919.

c $6900 Set PlayArea Attributes
@ $6900 label=AttributesPlayArea
R $6900 B Count for width
R $6900 C Count for height
R $6900 HL Attribute address
  $6900,$01 #REGe=#REGb.
  $6901,$01 #REGb=#REGe.
  $6902,$01 Stash #REGhl on the stack.
  $6903,$02 Write #N$76 to #REGhl.
  $6905,$01 Increment #REGhl by one.
  $6906,$02 Decrease counter by one and loop back to #R$6903 until counter is zero.
  $6908,$01 Restore #REGhl from the stack.
  $6909,$03 Call #R$6910.
  $690C,$01 Decrease #REGc by one.
  $690D,$02 Jump back to #R$6901 until #REGc is zero.
  $690F,$01 Return.

c $6910 Screen Address One Pixel Below
R $6910 HL Current position
R $6910 O:HL Address for new position
N $6910 Calculates the new address for writing a sprite pixel, in an downwards direction.
  $6910,$04 #REGl=#REGl + #N$20 (one line).
  $6914,$04 #REGh=#REGh + #N$00 (but include the carry from above).
  $6918,$01 Return.

c $6919 Display Night Driver Text
@ $6919 label=DisplayNightDriver
  $6919,$05 Return if #R$5E43 is zero.
  $691E,$03 #REGhl=#N$4070 (screen location).
  $6921,$03 #REGde=#R$693C.
  $6924,$03 Call #R$6518.
  $6927,$02 #REGb=#N$04 (delay length).
  $6929,$03 Call #R$6386.
  $692C,$03 #REGhl=#N$4070 (screen location).
  $692F,$01 Stash #REGhl on the stack.
  $6930,$03 Call #R$6F10.
  $6933,$02 #REGa=#N$00.
  $6935,$01 Switch to the shadow #REGaf register.
  $6936,$03 #REGde=#R$6AE4(#N$6AE5).
  $6939,$03 Jump to #R$651F.
@ $693C label=NightDriver_Text
T $693C,$0D,h$01,$0B:$01

c $6949 Plot Map Points
@ $6949 label=PlotMapPoints
  $6949,$03 #REGbc=#R$7811.
  $694C,$03 #REGhl=#N$4708.
  $6973,$03 Call #R$6998.
  $6977,$03 #REGhl=#R$7CD6.
  $697F,$01 Return.

c $6980 Handler: Terrain Dots
@ $6980 label=HandlerTerrainDots
R $6980 IX One of the #N$10 #R$65FD entities
  $6980,$04 Reset bit 0 of the given Terrain Dot entity.
  $6984,$03 #REGhl=#R$5E34.
  $6987,$05 #REGl=player Y - terrain dot Y.
  $698C,$05 #REGh=player X - terrain dot X.
  $6991,$05 Write #N$86 to #R$69A6(#N$69A7).
  $6996,$02 Jump to #R$699D.
N $6998
  $6998,$05 Write #N$C6 to #R$69A6(#N$69A7).
  $699D,$02 Stash #REGbc and #REGhl on the stack.
  $699F,$01 #REGa=#REGl.
  $69A0,$01 Flip the bits.
  $69A1,$03 #REGa=#REGa * #N$08.
  $69A4,$02,b$01 Keep only bits 3-5.
N $69A6 #TABLE(default,centre,centre)
. { =h,c3 Self modifying code }
. { =h Altered From | =h Bytes | =h bits |  }
. { #R$6991 | #N$86 | #EVAL($86, $02) }
. { #R$6998 | #N$C6 | #EVAL($C6, $02) }
. TABLE#
  $69A6,$02,b$01 Set bits 1-2, 6-7.
  $69A8,$03 Store #REGa at #R$69AE(#N$69AF).
  $69AB,$03 Call #R$6F10.
  $69AE,$02 Set bit 0 of #REGhl.
  $69B0,$03 Call #R$6ECB.
  $69B3,$02 Decrease counter by one and loop back to #R$69AE until counter is zero.
  $69B5,$02 Restore #REGhl and #REGbc from the stack.
  $69B7,$01 Increment #REGl by one.
  $69B8,$03 Decrease counter by one and loop back to #R$699D until counter is zero.
  $69BB,$01 Return.

c $69BC Draw PlayArea
@ $69BC label=DrawPlayArea
  $69BC,$04 #HTML(Stash <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a> on the stack.)
  $69C0,$06 #HTML(Write #R$74B1 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $69C6,$03 #REGhl=#R$7691.
  $69C9,$03 #REGde=#R$7751.
  $69CC,$01 Switch to the shadow registers.
  $69CD,$03 #REGhl'=#N$4000 (screen buffer).
  $69D0,$03 #REGde'=#N$5800 (attributes buffer).
  $69D3,$02 #REGc'=#N$18 (height of the sidebar).
  $69D5,$05 Write #N$08 (width of the sidebar) to #R$5E2C.
@ $69DA label=DrawPlayArea_Loop
  $69DA,$04 #REGb'=#R$5E2C.
  $69DE,$02 Stash #REGhl and #REGde on the stack.
@ $69E0 label=DrawPlayArea_LineLoop
  $69E0,$01 Switch back to the normal registers.
  $69E1,$01 #REGa=fetch the sidebar layout data.
  $69E2,$01 Increment the sidebar layout data pointer by one.
  $69E3,$01 Switch to the shadow registers.
N $69E4 Now using the screen data held by the shadow registers.
  $69E4,$03 Call #R$6C96.
  $69E7,$01 Switch back to the normal registers.
  $69E8,$01 #REGa=fetch the sidebar attribute data.
  $69E9,$01 Increment the sidebar attribute data pointer by one.
  $69EA,$01 Switch to the shadow registers.
  $69EB,$01 Write the sidebar attribute data to the attribute buffer.
  $69EC,$01 Increment the attribute buffer pointer by one.
  $69ED,$02 Decrease counter by one and loop back to #R$69E0 until counter is zero.
N $69EF Restore the attribute buffer address for the start of this line.
  $69EF,$01 Restore #REGhl from the stack.
  $69F0,$03 Call #R$6910.
  $69F3,$01 #REGde=#REGhl (ignoring the exchange as #REGhl is instantly overwritten below).
N $69F4 Restore the screen buffer address for the start of this line.
  $69F4,$01 Restore #REGhl from the stack.
  $69F5,$03 Call #R$6910.
N $69F8 Account for the Spectrum screen layout in memory.
  $69F8,$01 #REGa=#REGl.
  $69F9,$02,b$01 Keep only bits 5-7.
  $69FB,$02 Jump to #R$6A01 if we're not crossing a screen section.
  $69FD,$04 Else #REGh=#REGh+#N$07.
@ $6A01 label=DrawPlayArea_Skip
  $6A01,$01 Decrease the height counter by one.
  $6A02,$02 Keep jumping back to #R$69DA until the height counter is zero.
N $6A04 #HTML(All done! Finish by reverting the change to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a> and returning.)
  $6A04,$04 #HTML(Restore <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/3D00.html">CHARSET</a> from the stack and write it back to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $6A08,$01 Return.

c $6A09
  $6A09,$0B Copy #N$24 bytes of data from #R$6A15 to #R$5E80.
  $6A14,$01 Return.
B $6A15,$24


c $6A39 Draw Player
@ $6A39 label=DrawPlayer
  $6A39,$03 #REGhl=#R$5E10.
  $6A3C,$03 #REGbc=#N($0020, $04, $04).
  $6A41,$02,b$01 Keep only bits 0-1.
  $6A4B,$03 #REGhl=#R$7F24.
  $6A4E,$03 Create an offset in #REGbc.
  $6A51,$01 #REGhl=#R$7F24 + offset.
  $6A52,$03 #REGde=pointer to the player sprite for this direction.
N $6A55 The player is drawn statically in the centre of the play area.
  $6A55,$03 #REGhl=#N$4F93 (screen location).
N $6A58 The player sprite is #N$02 bytes in width.
  $6A58,$05 Write #N$02 to #R$5E2C.
  $6A5D,$01 #REGa=height of the sprite in pixels.
  $6A5E,$01 Increment #REGde by one to point to the sprite data.
  $6A5F,$01 #REGc=#REGa (height of the sprite).
@ $6A60 label=DrawPlayer_NextRow
  $6A60,$04 #REGb=#R$5E2C.
  $6A64,$01 Push #REGhl on the stack.
@ $6A65 label=DrawPlayer_NextCol
  $6A65,$02 Copy a byte from #REGde (the player sprite data) to #REGhl (the screen position).
  $6A67,$01 Increment #REGde (the player sprite data pointer) by one.
  $6A68,$01 Increment #REGl by one, this moves onto the next adjacent screen byte.
  $6A69,$02 Decrease counter by one and loop back to #R$6A65 until counter is zero.
  $6A6B,$01 Restore #REGhl from the stack.
  $6A6C,$03 Call #R$6ECB.
  $6A6F,$03 Decrease #REGc (height) by one and jump to #R$6A60 if it is not zero.
  $6A72,$01 Return.

c $6A73
  $6A73,$03 #REGde=#N($000C, $04, $04).
  $6A76,$02
  $6A78,$03 #REGhl=#REGix (using the stack to do so).
  $6A7B,$03 #REGbc=#R$5EA4.
  $6A84,$03 Call #R$6158.

@ $6A87 label=Pause_Loop
N $6A87 Holding "SHIFT" pauses the game.
  $6A87,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $6A8D,$02 Has the "SHIFT" key been pressed?
  $6A8F,$02 If it has then jump to #R$6A87.
  $6A91,$03 #REGhl=#R$5E29.
  $6A94,$01 Increment #REGhl by one.
  $6A95,$03 Write #REGhl to #R$5E29.
  $6A98,$03 Jump to #R$6009.

c $6A9B
  $6A9B,$02 Stash #REGix on the stack.
  $6A9D,$05 Write #N$FF to #R$5E39.
  $6AA2,$03 Call #R$6B47.
  $6AA5,$03 Call #R$6AF5.
  $6AA8,$03 Call #R$6D12.
  $6AAB,$03 Call #R$6557.
  $6AAE,$03 Call #R$625C.
  $6AB1,$03 Call #R$6588.
  $6AB4,$03 Call #R$611B.
  $6AB7,$02 Restore #REGix from the stack.
N $6AB9 Draw and colourize the player sprite.
  $6AB9,$03 Call #R$6A39.
  $6ABC,$03 #REGhl=#N$5993 (attribute buffer location).
  $6ABF,$03 #REGbc=#N($0202, $04, $04) (height * width in bytes).
N $6AC2 Merge the player sprite colour in with the current background colour.
  $6AC2,$03 #REGa=#R$5E44.
  $6AC5,$02,b$01 Set bit 1 (RED).
  $6AC7,$01 Store the result in #REGd.
  $6AC8,$03 Call #R$7064.
N $6ACB Handles updating the dashboard values.
  $6ACB,$03 Call #R$64C7.
  $6ACE,$03 Call #R$6CDE.
  $6AD1,$03 #REGa=#R$5E39.
  $6AD4,$02 Return if #R$5E39(#REGa) is zero.
  $6AD6,$01 Increment #R$5E39(#REGa) by one.
  $6AD7,$01 Return if #R$5E39(#REGa) if anything other than zero (see #R$6A9D; #N$FF + #N$01 = #N$00).
  $6AD8,$03 Write #REGa to #R$5E39.
  $6ADB,$03 #REGhl=#N$B868.
  $6ADE,$03 #REGde=#R$6AE4.
  $6AE1,$03 Call #R$6518.
T $6AE4,$11,h$01,$0F:$01

c $6AF5
  $6AF5,$03 #REGhl=#R$5E50.
  $6AF8,$02 #REGb=#N$07.
  $6B00,$02 Jump to #R$6B0C.

  $6B02,$01 Stash #REGbc on the stack.
  $6B03,$03 #REGhl=#N($0118, $04, $04).
  $6B06,$01 Decrease #REGhl by one.
  $6B07,$04 If #REGhl is not zero, jump to #R$6B06.
  $6B0B,$01 Restore #REGhl from the stack.
  $6B0C,$02 Increment #REGhl by two.
  $6B0E,$01 Increment #REGhl by one.
  $6B0F,$02 Decrease counter by one and loop back to #R$6AFA until counter is zero.
  $6B11,$01 Return.

c $6B12
R $6B12 HL Entity
  $6B12,$04 If the byte held at #REGhl is zero, jump to #R$6B02.
  $6B16,$02 Push #REGbc and #REGhl on the stack.
  $6B18,$03 #REGix=#REGhl (using the stack to do so).
  $6B1B,$03 Call #R$71ED.
  $6B1E,$03 Call #R$7139.
  $6B21,$01 Restore #REGhl from the stack.
  $6B22,$02 Write #N$00 to #REGhl.
  $6B24,$01 Increment #REGhl by one.
  $6B25,$01 Write #N$00 to #REGhl.
  $6B26,$01 Increment #REGhl by one.
  $6B27,$01 Write #N$00 to #REGhl.
  $6B28,$01 Restore #REGbc from the stack.
  $6B29,$02 Jump to #R$6B0E.

c $6B2B
  $6B2B,$01 Stash #REGbc on the stack.
  $6B2C,$02 #REGb=#N$02.
  $6B2E,$02 Jump to #R$6B33.

  $6B30,$01 Stash #REGbc on the stack.
  $6B31,$02 #REGb=#N$03.

  $6B33,$02 #REGe=#N$00.
  $6B39,$02 Decrease counter by one and loop back to #R$6B35 until counter is zero.
  $6B3B,$01 Restore #REGbc from the stack.
  $6B3C,$01 Return.

  $6B3D,$01 Stash #REGbc on the stack.
  $6B3E,$02 #REGb=#N$04.
  $6B40,$02 Jump to #R$6B33.

c $6B42
  $6B42,$03 #REGhl=#R$6BE6.
  $6B45,$02 Jump to #R$6B7F.

c $6B47 Draw Objects
@ $6B47 label=DrawObjects
  $6B47,$04 #REGbc=#R$5E19.
  $6B4B,$01 #REGa=#N$00.
  $6B4D,$01 #REGa'=object X position.
  $6B4E,$01 Increment #REGbc by one.
  $6B4F,$01 #REGd=#REGa'.
  $6B50,$03 Call #R$6B30.
  $6B53,$03 #REGhl=#R$5E05.
  $6B5B,$03 Call #R$6BF6.
  $6B62,$01 Stash #REGhl on the stack.
  $6B64,$03 #REGhl=#N($0060, $04, $04).
  $6B6A,$01 Restore #REGhl from the stack.
  $6B6D,$03 Store #REGa at #R$5E17.
  $6B71,$01 Increment #REGbc by one.
  $6B73,$03 Call #R$6B3D.
  $6B76,$03 #REGa=#R$5E43.
  $6B7C,$03 #REGhl=#R$6BD6.
  $6B81,$03 Store #REGa at #R$5E1F.
  $6B92,$03 #REGa=#R$5E44.
  $6B99,$03 #REGhl=#R$5E08.
  $6BA1,$03 Call #R$6BF6.
  $6BAA,$03 #REGhl=#N($0060, $04, $04).
  $6BB4,$03 Store #REGa at #R$5E18.
  $6BBB,$03 #REGhl=#R$6BCF.
  $6BC0,$03 Store #REGa at #R$5E13.
  $6BC3,$04 Store #REGbc at #R$5E3A.
  $6BD1,$03 #REGbc=#N($AF00, $04, $04).
  $6BD4,$02 Jump to #R$6B92.
B $6BD6,$20

c $6BF6

c $6BFE
  $6BFE,$03 #REGbc=#R$7811.
  $6C01,$03 #REGhl=#R$5E05.
  $6C04,$03 #REGde=#N($0060, $04, $04).
  $6C07,$01 Clear the carry flag.
  $6C0C,$01
  $6C0D,$01
  $6C0E,$01 #REGd=#REGa.
  $6C0F,$03 Call #R$6B30.
  $6C18,$02 Increment #REGbc twice (move onto the next record).
  $6C1A,$03 #REGhl=#R$7CD6.
  $6C29,$01 Return.
  $6C22,$07 Write #R$7811 to #R$5E19.
  $6C2A,$01 Decrease #REGbc by one.
  $6C2B,$02 Jump to #R$6C25.

c $6C2D
  $6C2D,$04 Write #N$00 to #R$5E1B.
  $6C31,$04 #REGbc=#R$5E19.
  $6C35,$03 Decrease #REGbc by three.
  $6C38,$02 #REGd=#REGbc.
  $6C3A,$03 Call #R$6B30.
  $6C3D,$03 Call #R$6C82.
  $6C42,$05 Write #N$01 to #R$5E1B.
  $6C47,$02 Jump to #R$6C35.

  $6C49,$06 Jump to #R$6C57 if #R$5E1B is zero.
  $6C56,$01 Return.

  $6C57,$04 #REGbc=#R$5E19.
  $6C5B,$02 #REGd=#REGbc.
  $6C5D,$03 Call #R$6B30.
  $6C60,$03 Call #R$6C82.

  $6C6C,$03 Call #R$6B30.
  $6C6F,$03 Call #R$6C82.
  $6C74,$01 Stash #REGhl on the stack.
  $6C75,$04 #REGde=#R$5E1C.
  $6C7C,$01 Restore #REGhl from the stack.
  $6C81,$01 Return.

c $6C82
  $6C82,$03 #REGhl=#R$5E05.
  $6C85,$01 Clear the carry flag.
  $6C8A,$03 Call #R$6BF6.
  $6C8E,$03 #REGde=#N($0060, $04, $04).
  $6C91,$01 Clear the carry flag.
  $6C95,$01 Return.

c $6C96 Print Character
E $6C96 View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #PSSST$73CD }
. LIST#
@ $6C96 label=PrintScreen
R $6C96 A ASCII value to print
R $6C96 HL Screen address
  $6C96,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $6C99,$03 Create an offset in #REGhl.
  $6C9C,$03 Calculate offset for ASCII character (#REGhl=#REGhl * 8).
  $6C9F,$04 #HTML(#REGde=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $6CA3,$02 #REGde=#REGhl + #N$3C00. For examples of usage;
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Letter | =h ASCII Value | =h * 8 (offset) | =h CHARS + offset }
. #FOREACH($55,$4C,$54,$49,$4D,$41,$54,$45)(value,
. { #LET(result=$3C00 + value * $08) "#CHR(value)" | #N(value) | #N(value * 8) | #HTML(<a href="https://skoolkid.github.io/rom/asm/3D00.html##N({result}, 2, 3, 1, 1)()">#N({result})) }
. )
. TABLE#
N $6CA5 Print the character to the screen.
  $6CA5,$01 Restore #REGhl, containing the screen buffer location, from the stack.
  $6CA6,$02 #REGb=#N$08 (#N$08 rows of pixels).
@ $6CA8 label=PrintScreen_Loop
  $6CA8,$02 Copy a byte from the font data to the screen buffer.
  $6CAA,$01 Increment the font data by one.
  $6CAB,$01 Move onto the next pixel line.
  $6CAC,$02 Decrease counter by one and loop back to #R$6CA8 until counter is zero.
  $6CAE,$02 Restore #REGde and #REGbc from the stack.
N $6CB0 Reset #REGhl and move to the next column, ready to print the next character.
  $6CB0,$04 #REGh=#REGh - #N$08 (reset the display line).
  $6CB4,$01 Increment screen column by one.
  $6CB5,$01 Return.

c $6CB6 Print Scores
E $6CB6 View the equivalent code in;
. #LIST
. { #COOKIE$7438 }
. { #JETPAC$711C }
. { #LUNARJETMAN$89BF }
. { #PSSST$739D }
. LIST#
N $6CB6 Sets up the player score.
@ $6CB6 label=Score_Player
  $6CB6,$03 #REGhl=#N$400D.
  $6CB9,$03 #REGde=#R$5E4C.
  $6CBC,$02 Jump to #R$6CC4.
N $6CBE Sets up the HI score.
@ $6CBE label=Score_HI
  $6CBE,$03 #REGhl=#N$4018.
  $6CC1,$03 #REGde=#R$5E49.
N $6CC4 Prints the score.
@ $6CC4 label=PrintScore
  $6CC4,$02 #REGb=#N$03.
@ $6CC6 label=PrintScore_Loop
  $6CCB,$02,b$01 Keep only bits 0-3.
  $6CCF,$03 Call #R$6C96.
  $6CD3,$02,b$01 Keep only bits 0-3.
  $6CD7,$03 Call #R$6C96.
  $6CDD,$01 Return.

c $6CDE Display Miles/ Time.
@ $6CDE label=DisplayMiles
  $6CDE,$03 #REGhl=#N$4061 (screen position).
  $6CE1,$03 #REGde=#R$5E2D.
  $6CE4,$02 #REGb=#N$03 ("miles" is #N$03 digits).
  $6CE6,$03 Call #R$6CC6.
  $6CE9,$03 #REGhl=#N$4021 (screen position).
@ $6CEC label=DisplayTime_Minutes
  $6CEC,$03 #REGde=#R$5E31.
  $6CEF,$02 #REGb=#N$02 ("time/ minutes" is #N$02 digits).
  $6CF1,$03 Call #R$6CD2.
  $6CF4,$03 #REGde=#R$5E33.
@ $6CF7 label=DisplayTime_Seconds
  $6CF7,$01 Increment #REGhl (screen position) by one.
  $6CF8,$02 #REGb=#N$01 ("time/ seconds" is #N$01 digit).
  $6CFA,$03 Jump to #R$6CC6.

c $6CFD Print Best Time
@ $6CFD label=PrintBestTime
N $6CFD Print the first two digits.
  $6CFD,$02 #REGb=#N$02.
  $6CFF,$03 Call #R$6CD2.
N $6D02 Print the final digit.
  $6D02,$03 #REGde=#R$5E02.
  $6D05,$02 Jump to #R$6CF7.

c $6D07
  $6D07,$05 #REGa=#R$5E0D + #N$04.
  $6D0C,$04 If #REGa is more than #N$C0 jump to #R$6D76.
  $6D10,$02 Else, jump to #R$6D73.

c $6D12
  $6D12,$02 #REGc=#N$00.
  $6D14,$03 #REGa=#R$5E0D.
  $6D1D,$03 #REGhl=#R$5E30.
N $6D23 Working backwards, add onto the odometer.
  $6D23,$02 #REGb=#N$03 (counter - miles are stored in three bytes).
@ $6D25 label=CalcMiles
  $6D25,$01 Decrease the pointer to the miles counter held by #REGhl by one.
  $6D26,$02 Adds #REGa to the miles byte held at #REGhl.
  $6D28,$01 Write #REGa to #REGhl.
  $6D29,$02 Reset #REGa to #N$00 while maintaining the carry flag.
  $6D2B,$02 Decrease counter by one and loop back to #R$6D25 until counter is zero.
  $6D2D,$04 #REGl=#R$5E74.
  $6D31,$03 #REGa=#R$5E2D(#N$5E2E).
  $6D3A,$03 #REGbc=#N($0010, $04, $04).
  $6D3D,$03 Call #R$6046.
  $6D40,$03 #REGhl=#R$5E05.
N $6D43 Check fuel.
  $6D43,$06 If #R$5E0B(Fuel level) is not zero then jump to #R$6D56.
N $6D49 Handle being out of fuel.
  $6D49,$03 #REGa=#R$5E0D.
  $6D54,$02 Jump to #R$6D64.

N $6D56 Check temperature.
  $6D56,$03 #REGa=#R$5E0C.

  $6D5D,$03 Call #R$61E0.
  $6D64,$03 Call #R$61C2.
  $6D6B,$03 #REGa=#R$5E0D.
  $6D72,$01 #REGa=#N$00.
N $6D73 Increase speed (see #R$6D07).
@ $6D73 label=Accelerate
  $6D73,$03 Write #REGa to #R$5E0D.
  $6D76,$03 #REGa=#R$5E0D.
  $6D79,$03 #REGhl=#N($49E2, $04, $04).
  $6D7C,$03 Call #R$6EDE.
  $6D7F,$03 #REGa=#R$5E11.
  $6D82,$01 Increment #REGa by one.
  $6D83,$01 Store the result in #REGc.
  $6D84,$03 #REGa=#R$5E10.
  $6D87,$03 Shift #REGa right three times.
  $6D8A,$02,b$01 Keep bits 0-4.

  $6D90,$02,b$01 Unset bits 0-4.
  $6D92,$03 Create an offset; #REGe=#REGa and #REGd=#N$00.
  $6D95,$01 Stash #REGde on the stack.
  $6D96,$04,$03 #REGhl=#R$7F6B + offset.
  $6D9A,$06 Create an offset; #REGe=#R$5E0D and #REGd=#N$00.
  $6DA0,$01 Stash #REGde on the stack.
  $6DA2,$03 Call #R$6F2F.
  $6DA5,$03 #REGa=#R$5E09.
  $6DA8,$04 #REGde=#R$5E07.

  $6E66,$02 #REGe=#N$00.
  $6E68,$02 Jump to #R$6E7E.
  $6E6A,$02 #REGe=#N$18.
  $6E6C,$02 #REGd=#N$00.
  $6E72,$02 Jump to #R$6E7E.
  $6E74,$02 #REGe=#N$18.
  $6E76,$02 #REGd=#N$00.
N $6E7E Don't "use fuel" on every frame. This routine uses the last two bits of the #R$5E29(GameTimer) (i.e. a number
.       between 0-3) to only process every fourth frame.
@ $6E7E label=HandlerFuel
  $6E7E,$03 #REGa=#R$5E29.
  $6E81,$02,b$01 Keep only bits 0-1.
  $6E83,$02 If the result is not zero then jump to #R$6E9B.
N $6E85 Handles "using" fuel.
  $6E85,$06 #REGb=#N$00, #REGc=#R$5E0D.
  $6E8B,$03 #REGhl=#R$5E0A.
N $6E8E A higher speed uses more fuel.
  $6E8E,$02 #REGhl=#REGhl (fuel) - #REGbc (speed).
  $6E90,$02 If there's "carry" (i.e. if the player has run out of fuel) jump to #R$6E95.
  $6E92,$03 Write #REGhl to #R$5E0A.
@ $6E95 label=FuelSkipWrite
  $6E95,$04 If the current speed is more than #N$B0 (top speed) jump to #R$6EAF.
  $6E99,$02 Compare current speed with #N$60.

N $6E9B Handle the temperature gauge.
@ $6E9B label=HandlerTemperatureGauge
  $6E9B,$03 #REGa=#R$5E0C.
  $6E9E,$02 If there's carry set (this could be either from #R$6E99 or #R$6E81) then jump to #R$6EBC.
@ $6EA0 label=DrawTemperatureGauge
  $6EA0,$03 #REGhl=#N($5162, $04, $04) (screen location).
  $6EA3,$03 Call #R$6EDE.
N $6EA6 Handle the fuel gauge.
  $6EA6,$03 #REGa=#R$5E0B.
  $6EA9,$03 #REGhl=#N($5122, $04, $04) (screen location).
  $6EAC,$03 Jump to #R$6EDE.
N $6EAF Handle the temperature gauge at maximum speed.
@ $6EAF label=TemperatureMaxSpeed
  $6EAF,$03 #REGa=#R$5E0C.
N $6EB2 Check if the temperature is already at the upper limit.
  $6EB2,$04 If the current temperature is more than #N$C0 jump to #R$6EA0.
N $6EB6 Go ahead and increase the temperature...
  $6EB6,$01 Increment #REGa by one.
@ $6EB7 label=UpdateTemperature
  $6EB7,$05 Write the updated #REGa (temperature) back to #R$5E0C.
  $6EBA,$02 Jump to #R$6EA0.
N $6EBC Handles dropping the temperature gauge.
@ $6EBC label=TemperatureDrop
  $6EBC,$03 If the current temperature is at zero jump to #R$6EA0.
  $6EBF,$01 Decrease #REGa (temperature) by one.
  $6EC0,$02 Jump to #R$6EB7.
  $6EC2,$02 #REGb=#N$05.
  $6EC8,$02 Decrease counter by one and loop back to #R$6EC4 until counter is zero.
  $6ECA,$01 Return.

c $6ECB Screen Address One Pixel Above
R $6ECB HL Current position
R $6ECB O:HL Address for new position
N $6ECB Calculates the new address for writing a sprite pixel, in an upward direction, taking into consideration the screen memory layout.
@ $6ECB label=ScreenPos1PixelAbove
  $6ECB,$01 Decrement #REGh to move up one pixel on screen.
  $6ECC,$02 Store the inverted result in #REGa.
  $6ECE,$02,b$01 Keep only bits 0-2.
  $6ED0,$01 If a character line has not been crossed then return.
  $6ED1,$04 Else subtract #N$20 from #REGl.
  $6ED5,$01 Invert the bits in #REGa.
  $6ED6,$02,b$01 Keep only bits 5-7.
  $6ED8,$01 If a new section of the screen has not been crossed then return.
  $6ED9,$05 Else add #N$08 to #REGh and return.

c $6EDE Draw Gauge Line
@ $6EDE label=DrawGaugeLine
  $6EDE,$04 Shift #REGa right two times (#REGa / #N$04).
  $6EE2,$01 Store the result in #REGc.
  $6EEB,$03 Call #R$6EFD.
  $6EEE,$02 Jump to #R$6EE3.
  $6EF0,$02 #REGb=#N$00.
  $6EF2,$01 Stash #REGhl on the stack.
  $6EF3,$03 #REGhl=#R$6F07.
  $6EF8,$01 Restore #REGhl from the stack.
  $6EF9,$03 Call #R$6EFD.
  $6EFC,$01 #REGa=#N$00.
  $6EFD,$01 Stash #REGhl on the stack.
  $6EFE,$02 #REGb=#N$07.
  $6F02,$02 Decrease counter by one and loop back to #R$6F00 until counter is zero.
  $6F04,$01 Restore #REGhl from the stack.
  $6F06,$01 Return.

B $6F07

c $6F10 Calculate Screen Address
E $6F10 View the equivalent code in;
. #LIST
. { #ATICATAC$9BA2 }
. { #COOKIE$76E3 }
. { #JETPAC$7308 }
. { #LUNARJETMAN$851E }
. { #PSSST$759A }
. LIST#
@ $6F10 label=ScreenAddress
  $6F10,$01 #REGa=#REGl.
  $6F11,$03 #REGa=#REGa / #N$08.
  $6F14,$02,b$01 Keep only bits 0-4.
  $6F16,$01 #REGl=#REGa.
  $6F17,$01 #REGa=#REGh.
  $6F18,$02 #REGa=#REGa * #N$04.
  $6F1A,$02,b$01 Keep only bits 5-7.
  $6F1C,$01
  $6F1D,$01 #REGl=#REGa.
  $6F1E,$01 #REGa=#REGh.
  $6F1F,$02,b$01 Keep only bits 0-2.
  $6F21,$01 Switch to the shadow #REGaf register.
  $6F22,$01 #REGa=#REGh.
  $6F23,$03 #REGa=#REGa / #N$08.
  $6F26,$02,b$01 Keep only bits 3-4.
  $6F28,$02,b$01 Set bit 6.
  $6F2A,$01 #REGh=#REGa.
  $6F2B,$01 Switch to the shadow #REGaf register.
  $6F2C,$01
  $6F2D,$01 #REGh=#REGa.
  $6F2E,$01 Return.

c $6F2F
  $6F2F,$03 #REGhl=#N($0000, $04, $04).
  $6F32,$02 #REGb=#N$08 (counter).
  $6F34,$01
  $6F35,$01
  $6F36,$02
  $6F38,$01
  $6F39,$02 Decrease counter by one and loop back to #R$6F34 until counter is zero.
  $6F3B,$01 Return.

c $6F3C
  $6F3C,$03 #REGa=#R$5E13.
  $6F41,$02,b$01 Keep only bits 0-1.
  $6F45,$03 #REGa=#R$5E18.
  $6F58,$03 #REGa=#R$5E17.
  $6F6A,$03 #REGa=#R$5E1F.
  $6F78,$02 #REGa=#N$07.
  $6F7D,$01 Push #REGhl on the stack.
  $6F7F,$02 #REGb=#N$07.
  $6F81,$03 #REGhl=#R$5E51.
  $6F9B,$01 Push #REGhl on the stack.
  $6F9E,$03 #REGix=#REGhl (using the stack to do so).
  $6FA1,$03 #REGa=#R$5E1E.
  $6FA5,$03 Call #R$71ED.
  $6FA8,$02 Restore #REGhl and #REGde from the stack.
  $6FAA,$02 Jump to #R$6FC1.

c $6FAC
  $6FB2,$03 #REGhl=#R$5E50.
  $6FB5,$02 #REGb=#N$07.
  $6FB7,$04 Write #N$00 to #R$5E22.
  $6FC5,$03 #REGa=#R$5E1E.
  $6FC8,$02,b$01 Set bit 7.
  $6FCA,$01 Write this back to #REGhl.
  $6FCB,$03 #REGix=#REGhl (using the stack to do so).
  $6FCE,$03 #REGa=#R$5E1F.
  $6FD5,$02,b$01 Keep only bits 0-6.
  $6FD7,$03 Call #R$64F0.
  $6FDA,$03 Call #R$7101.
  $6FDD,$03 #REGl=
  $6FE0,$03 #REGh=
  $6FE3,$04 #REGd=#R$5E42.
  $6FE7,$03 Call #R$7052.
  $6FEA,$06 Return if too far from #R$5E17 (i.e. more than #N$0A pixels).
  $6FF0,$06 Return if too far from #R$5E18 (i.e. more than #N$0A pixels).
  $6FF6,$03 #REGa=#R$5E1F.
  $6FF9,$04
  $7002,$03 #REGa=#R$5E4F.
N $700C Add #N($0050, $04, $04) points to the score.
  $700C,$03 #REGbc=#N($0050, $04, $04).
  $700F,$03 Call #R$6046.
  $7012,$06 Write #N$C0FF to #R$5E0A.
  $7018,$03 #REGa=#R$5E46.
  $701B,$02,b$01 Keep only bits 0-6.
  $701E,$05 Write #N$07 to #R$5E46.
  $7023,$01 Return.

c $7024

c $702A
  $702A,$03 #REGhl=#R$5E3A.
  $7030,$05 Write #N$87 to #R$5E46.
  $7035,$03 Jump to #R$63FF.

c $7038
  $7038,$03 #REGhl=#R$5E3A.
  $703E,$07 Write #N$00 to #LIST { #R$5E8C } { #R$5E98 } LIST#
  $7045,$05 Write #N$03 to #R$5E80.
  $704A,$01 Return.

c $704B Colourise sprite
@ $704B label=ColouriseSprite
  $704B,$01 Switch to the shadow registers.
  $704C,$03 #REGhl'=#R$5E27(actor co-ordinates).
  $704F,$03 #REGd'=object colour attribute.
  $7052,$03 Call #R$7097 - #REGhl' now holds the co-ordinates to an attribute file address.
  $7055,$04 #REGb'=#R$5E24(width loop counter (in pixels)).
  $7059,$03 #REGa=#R$5E23.
  $705C,$04 #REGa=((#REGa / #N$04) + #N$01) / #N$02.
  $7060,$02,b$01 Keep only bits 0-4.
  $7062,$01 Increment #REGa by one.
  $7063,$01 #REGc'=height loop counter (in pixels).
  $7064,$01 #REGe'=width loop counter (in pixels).
@ $7065 label=ColouriseSprite_Loop1
  $7065,$01 Stash #REGhl on the stack.
@ $7066 label=ColouriseSprite_Loop2
  $7066,$01 #REGa=actor Y position.
  $7067,$04 Decrement position if address is outside of attribute file address range.
  $706B,$02 Stash #REGhl and #REGbc on the stack.
  $706D,$03 #REGbc'=#N$5820.
  $7070,$01 Clear the carry flag.
  $7073,$02 Restore #REGbc and #REGhl from the stack.
  $707F,$02,b$01 Keep only bits 0-4.
  $7087,$02 Decrease counter by one and loop back to #R$7066 until counter is zero.
  $7089,$01 Restore #REGhl from the stack.
  $708A,$01 Stash #REGbc on the stack.
  $708B,$01 Clear the carry flag.
  $708C,$05 #REGhl -= 32 tiles. Places address pointer previous line.
  $7091,$01 Restore #REGbc from the stack.
  $7092,$01 #REGb=reset to original width counter.
  $7093,$01 Decrement height counter.
  $7094,$02 Repeat until all tiles have been coloured.
  $7096,$01 Return.

c $7097 Calculate Attribute Address
E $7097 View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #COOKIE$7534 }
. { #JETPAC$720E }
. { #LUNARJETMAN$8506 }
. { #PSSST$748F }
. LIST#
@ $7097 label=AttributeAddress
N $7097 Converts a given pixel address to the associated attribute buffer address.
R $7097 HL Pixel address co-ordinates
R $7097 O:HL Attribute buffer address
  $7097,$01 Horizontal co-ordinate.
  $7098,$03 Divide by #N$08.
  $709B,$02,b$01 Keep only bits 0-4 (#N$00-#N$1F / minimum-maximum horizontal screen values).
  $709D,$01 Store this back in #REGl.
  $709E,$01 Vertical co-ordinate.
  $709F,$02 Multiply by #N$04.
  $70A1,$01 Store this in #REGc temporarily.
  $70A2,$02,b$01 Keep only bits 5-7.
  $70A4,$01 Set the bits from #REGl.
  $70A5,$01 #REGl=#REGa.
  $70A6,$01 Fetch the stored value from #REGc.
  $70A7,$02,b$01 Keep only bits 0-1.
  $70A9,$02,b$01 Set MSB of the attribute buffer #N$58. This ensures our value is >= #R$5800.
  $70AB,$01 Store this back in #REGh.
  $70AC,$01 Return.

c $70AD

c $70B2 Get Actor Position/ Direction
@ $70B2 label=ActorFindPosDir
E $70B2 Continue on to #R$70CE.
  $70B2,$03 Call #R$7155.
  $70B5,$03 #REGhl=#R$5E20.
  $70B8,$01 #REGa=#REGl.
  $70BB,$02,b$01 Keep only bits 0-2.
  $70C0,$03 Call #R$70AD.
  $70C3,$03 Call #R$6F10.
  $70CA,$01 #REGa=#REGc.

c $70CE
@ $70CE label=NextSprite
  $70CE,$02 #REGc=#N$00.
  $70D0,$01 Increment #REGde by one to point to the next sprite header value.
  $70D1,$01 Return.

c $70D2
@ $70D2 label=FindActorSpriteAndUpdate
  $70D2,$03 Call #R$7168.
@ $70D5 label=ActorUpdate
  $70D5,$06 Fetch actor co-ordinates.
  $70DE,$02,b$01 Keep only bits 0-2.
  $70E0,$03 Write this to #R$5E41.
  $70E3,$02 #REGa=#N$02.
  $70E7,$01 Increment #REGa by one.
  $70E8,$03 Write #REGa to #R$5E24.
  $70EB,$03 Write #REGhl to #R$5E27.
  $70EE,$03 Call #R$70AD.
  $70F1,$03 Call #R$6F10.
  $70F9,$03 Set #R$5E26.
  $70FC,$03 Set #R$5E23.
  $70FF,$02 Jump to #R$70CE.

c $7101
@ $7101 label=ActorEraseMovedSprite
  $7101,$07 #R$5E22.
  $7108,$03 Call #R$70D2.
  $710C,$03 Call #R$70B2.
  $710F,$03 #REGa=#R$5E21.
  $711C,$03 #REGa=#R$5E25.
  $7127,$03 Jump to #R$7170.
  $712E,$03 #REGa=#R$5E26.
  $7136,$03 Jump to #R$71E4.

c $7139 Erase Destroyed Actor
@ $7139 label=ActorEraseDestroyed
  $7139,$03 Call #R$70B2.
  $713C,$01
  $713D,$02 #REGc=#N$00.
  $713F,$06 Write #N$00 to; #LIST { #R$5E26 } { #R$5E23 } LIST#
  $7145,$01
  $7146,$03 Jump to #R$7170.

c $7149
  $7149,$03 Call #R$70D2.
  $714D,$04 Write #N$00 to #R$5E25.
  $7151,$01 #REGc=#N$00.
  $7152,$03 Jump to #R$7170.

c $7155 Fetch Sprite
@ $7155 label=GetDefaultSprite
  $7155,$03 #REGa=#R$5E22.
@ $7158 label=GetSprite
  $7158,$03 Calculate offset for sprite lookup table.
  $715B,$02,b$01 Keep only bits 1-6.
  $715D,$03 #REGhl=#R$7F06.
  $7160,$03 Create an offset in #REGbc.
  $7163,$01 #REGhl=#R$7F06 + offset.
  $7164,$03 #REGde=fetch sprite address pointed to by #REGhl.
  $7167,$01 Return.

N $7168 .
@ $7168 label=ActorGetSprite
  $7168,$03 Load the sprite ID from the currently active actor.
  $716B,$02 Jump to #R$7158.

c $716D
  $716D,$01 .
  $716E,$02 Jump to #R$718F.

c $7170 Mask Sprite
@ $7170 label=MaskSprite
  $7170,$04 Jump to #R$71CB if the vertical position is zero.
  $7174,$01 Decrease #REGc by one.
  $7175,$01 Stash #REGhl on the stack.
  $7176,$04 #REGb=#R$5E40.
  $719A,$03 Call #R$6ECB.
  $71A4,$04 #REGb=#R$5E41.
  $71A9,$01 Stash #REGde on the stack.
  $71C5,$03 Call #R$6ECB.
  $71C9,$02 Jump to #R$7170.
@ $71D0 label=ActorUpdateSizeFlipReg
@ $71D1 label=ActorUpdateSize
  $71D1,$04 #REGc=#R$5E25.
  $71D5,$03 #REGa=#R$5E26.
  $71DF,$04 #REGc=#R$5E26.
@ $71E4 label=ActorUpdateHeightAndMask
  $71E8,$02 Jump to #R$7170.

c $71ED Store Entity
E $71ED View the equivalent code in;
. #LIST
. { #ATICATAC$9FFB }
. { #COOKIE$0000 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$75B9 }
. LIST#
@ $71ED label=StoreEntity
  $71ED,$06 Copy actor X position to active actor X position.
  $71F3,$06 Copy actor Y position to active actor Y position.
  $71F9,$06 Copy actor movement to active actor movement.
  $71FF,$01 Return.

c $7200 Reset Attribute Buffer
E $7200 View the equivalent code in;
. #LIST
. { #ATICATAC$80C2 }
. { #COOKIE$74E2 }
. { #JETPAC$71C6 }
. { #LUNARJETMAN$84BB }
. { #PSSST$7447 }
. LIST#
@ $7200 label=ResetAttributes
  $7200,$03 Set the border to black.
  $7203,$03 Call #R$7211.
  $7206,$03 #REGhl=#R$5800(attribute buffer).
  $7209,$02 #REGb=#N$5B (i.e. finish once we reach the end of the #R$5800(attribute buffer)).
  $720B,$04 #REGc=#R$5E44.
  $720F,$02 Jump to #R$7218.

c $7211 Reset Screen Buffer
E $7211 View the equivalent code in;
. #LIST
. { #ATICATAC$80B4 }
. { #COOKIE$74D4 }
. { #JETPAC$71B8 }
. { #LUNARJETMAN$84AD }
. { #PSSST$7439 }
. LIST#
@ $7211 label=ResetScreen
E $7211 Continue on to #R$7218 to blank the screen buffer.
  $7211,$03 #REGhl=#R$4000(screen buffer).
  $7214,$02 #REGb=#N$58 (i.e. finish once we reach the start of #R$5800(attribute buffer)).
  $7216,$02 #REGc=#N$00 (value to write).

c $7218 Reset Routine
E $7218 View the equivalent code in;
. #LIST
. { #ATICATAC$80BB }
. { #COOKIE$74DB }
. { #JETPAC$71B8 }
. { #LUNARJETMAN$84B4 }
. { #PSSST$7440 }
. LIST#
R $7218 HL Target address
R $7218 B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $7218 C Value to write
@ $7218 label=ResetCopier
  $7218,$01 Write #REGc to the target address.
  $7219,$01 Increment the target address by one.
  $721A,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $721C,$02 Keep looping back to #R$7218 until there is no carry-over.
  $721E,$01 Return.

w $721F Cup Table
D $721F Links to the entry in #R$7811 for every cup.
@ $721F label=CupTable
  $721F,$02 Cup #N((#PC - $721F) / 2).
L $721F,$02,$08

t $722F Place Names
@ $722F label=PlaceNames
  $722F,$0C,$0B:$01 "LOS ANGELES".
  $723B,$0D,$0C:$01 "SAN FRANCISCO".
  $7248,$0B,$0A:$01 "SAN DIEGO".
  $7253,$0A,$09:$01 "SEATTLE".
  $725D,$0B,$0A:$01 "LAS VEGAS".
  $7268,$0A,$09:$01 "TUCSON".
  $7272,$0E,$0D:$01 "SALT LAKE CITY".
  $7280,$0A,$09:$01 "EL PASO".
  $728A,$0C,$0B:$01 "GREAT FALLS".
  $7296,$0C,$0B:$01 "ALBUQUERQUE".
  $72A2,$0A,$09:$01 "DENVER".
  $72AC,$0A,$09:$01 "DALLAS".
  $72B6,$0A,$09:$01 "WICHITA".
  $72C0,$0C,$0B:$01 "KANSAS CITY".
  $72CC,$0A,$09:$01 "HUSTON".
  $72D6,$0C,$0B:$01 "MINNEAPOLIS".
  $72E2,$0B,$0A:$01 "ST. LOUIS".
  $72ED,$0A,$09:$01 "CHICAGO".
  $72F7,$0C,$0B:$01 "NEW ORLEANS".
  $7303,$0B,$0A:$01 "NASHVILLE".
  $730E,$0C,$0B:$01 "CINCINNATI".
  $731A,$0A,$09:$01 "DETROIT".
  $7324,$0A,$09:$01 "ATLANTA".
  $732E,$0C,$0B:$01 "WASHINGTON".
  $733A,$0D,$0C:$01 "JACKSONVILLE".
  $7347,$0B,$0A:$01 "NEW YORK".

b $7352 Sprite: Cactus
  $7352,$01 Height = #N(#PEEK(#PC)) pixels.
  $7353,$20,b$02 #SPRITE$00(cactus)

b $7373 Sprite: USA Sign
  $7373,$01 Height = #N(#PEEK(#PC)) pixels.
  $7374,$20,b$02 #SPRITE$01(sign)

b $7394 Sprite: Flower
  $7394,$01 Height = #N(#PEEK(#PC)) pixels.
  $7395,$20,b$02 #SPRITE$03(flower)

b $73B5 Sprite: Boulder
  $73B5,$01 Height = #N(#PEEK(#PC)) pixels.
  $73B6,$1E,b$02 #SPRITE$04(boulder)

b $73D4 Sprite: Tree
  $73D4,$01 Height = #N(#PEEK(#PC)) pixels.
  $73D5,$20,b$02 #SPRITE$05(tree)

b $73F5 Sprite: Fuel Pump
  $73F5,$01 Height = #N(#PEEK(#PC)) pixels.
  $73F6,$20,b$02 #SPRITE$06(fuel-pump)

b $7416 Sprite: Pylon
  $7416,$01 Height = #N(#PEEK(#PC)) pixels.
  $7417,$20,b$02 #SPRITE$0D(pylon)

b $7437 Sprite: Tombstone
  $7437,$01 Height = #N(#PEEK(#PC)) pixels.
  $7438,$20,b$02 #SPRITE$0E(tombstone)

b $7458 Sprite: Bush
  $7458,$01 Height = #N(#PEEK(#PC)) pixels.
  $7459,$1A,b$02 #SPRITE$02(bush)

b $7473 Sprite: Explosion
N $7473 Frame 1
  $7473,$01 Height = #N(#PEEK(#PC)) pixels.
  $7474,$20,b$02 #SPRITE$20(explosion-01)
N $7494 Frame 2
  $7494,$01 Height = #N(#PEEK(#PC)) pixels.
  $7495,$1E,b$02 #SPRITE$21(explosion-02)

b $74B1 UDG Graphics
@ $74B1 label=UDG_Tiles
N $74B1 Tile ID: "#N(#EVAL((#PC - $74B1) / $08))".
  $74B1,b$08,$01 #UDG(#PC)
L $74B1,$08,$3C

b $7691 Sidebar Layout
@ $7691 label=SidebarLayoutData
  $7691,$08 #FOR($00,$07)||n|#UDG($74B1 + #PEEK(#PC + n) * $08)||
L $7691,$08,$18

b $7751 Sidebar Attributes
@ $7751 label=SidebarAttributes
  $7751,$08 #FOR($00,$07)||n|#UDG($74B1 + #PEEK(n + #PC - $C0) * $08,attr=#PEEK(#PC + n))||
L $7751,$08,$18

b $7811 Map Points
@ $7811 label=MapPoints
  $7811,$03 Map Point #N((#PC - $7811) / $03, $03, $03): #SPRITENAME(#PEEK(#PC + $02) - $01).
L $7811,$03,$197

b $7CD6 Sprite: Car
E $7CD6 #UDGARRAY*car-01,10;car-02;car-03;car-04;car-05;car-06;car-07;car-08;car-09;car-0A;car-0B;car-0C;car-0D;car-0E;car-0F;car-10(car-ani)
N $7CD6 Frame 1.
  $7CD6,$01 Width = #N(#PEEK(#PC)) bytes.
  $7CD7,$22,b$02 #CAR$00(car-01*)

N $7CF9 Frame 2.
  $7CF9,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CFA,$22,b$02 #CAR$01(car-02*)

N $7D1C Frame 3.
  $7D1C,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D1D,$22,b$02 #CAR$02(car-03*)

N $7D3F Frame 4.
  $7D3F,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D40,$22,b$02 #CAR$03(car-04*)

N $7D62 Frame 5.
  $7D62,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D63,$22,b$02 #CAR$04(car-05*)

N $7D85 Frame 6.
  $7D85,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D86,$22,b$02 #CAR$05(car-06*)

N $7DA8 Frame 7.
  $7DA8,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DA9,$22,b$02 #CAR$06(car-07*)

N $7DCB Frame 8.
  $7DCB,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DCC,$22,b$02 #CAR$07(car-08*)

N $7DEE Frame 9.
  $7DEE,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DEF,$22,b$02 #CAR$08(car-09*)

N $7E11 Frame 10.
  $7E11,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E12,$22,b$02 #CAR$09(car-0A*)

N $7E34 Frame 11.
  $7E34,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E35,$22,b$02 #CAR$0A(car-0B*)

N $7E57 Frame 12.
  $7E57,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E58,$22,b$02 #CAR$0B(car-0C*)

N $7E7A Frame 13.
  $7E7A,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E7B,$22,b$02 #CAR$0C(car-0D*)

N $7E9D Frame 14.
  $7E9D,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E9E,$22,b$02 #CAR$0D(car-0E*)

N $7EC0 Frame 15.
  $7EC0,$01 Height = #N(#PEEK(#PC)) pixels.
  $7EC1,$22,b$02 #CAR$0E(car-0F*)

N $7EE3 Frame 16.
  $7EE3,$01 Height = #N(#PEEK(#PC)) pixels.
  $7EE4,$22,b$02 #CAR$0F(car-10*)

w $7F06 Sprites Table
E $7F06 View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$0000 }
. LIST#
@ $7F06 label=SpritesTable
  $7F06,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $7F06) / 2)) #SPRITENAME((#PC - $7F06) / 2).
L $7F06,$02,$0F

w $7F24 Player Sprite Table
@ $7F24 label=PlayerSpriteTable
  $7F24,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $7F24) / 2)) #CARNAME((#PC - $7F24) / 2).
L $7F24,$02,$10

w $7F44 Sprites Table 2
D $7F44 This isn't a separate table; it's a continuation of #R$7F06 just, the player sprites have a "special" zero-based
.       reference of their own.
@ $7F44 label=SpritesTable2
  $7F44,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $7F06) / 2)) #SPRITENAME((#PC - $7F06) / 2).
L $7F44,$02,$03

b $7F4A Sprite: Cup
  $7F4A,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F4B,$20,b$02 #SPRITE$1F(cup)

b $7F6B

i $8000
b $B868
i $B869
