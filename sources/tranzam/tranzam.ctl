; Copyright Ashby Computers & Graphics Ltd 1983, Rare Ltd, 2026 ArcadeGeek LTD.
> $4000 @org=$4000
> $4000 @rom
> $4000 @start=$5B80
> $4000 @expand=#DEF(#POKE()(anchor,text) #LINK(Pokes#$anchor)($text))
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))
b $4000 Loading screen
@ $4000 label=Loading
D $4000 #UDGTABLE { =h Tranz Am Loading Screen } { #SCR$02(loading) } UDGTABLE#
N $4000 The hills strip below is cropped from the loading screen and is used as
. the repeating footer background of every page.
. #UDGTABLE { =h Footer Strip }
. { #SCR$01,$00,$0B,$06,$02(hills-strip) } UDGTABLE#
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

c $5B80 Game Entry Point
@ $5B80 label=GameEntry
D $5B80 The entry point of the game. The code and data from #N$5F01 onwards are
. held one byte higher in memory than they are used, so they are moved down by
. one byte before control is passed to #R$5F00.
E $5B80 View the equivalent code in;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #PSSST$5B80 }
. { #SABREWULF$6000 }
. { #UNDERWURLDE$67F2 }
. LIST#
E $5B80 Later Ultimate games use more advanced decryption mechanisms;
. #LIST
. { #ATICATAC$5B80 }
. { #LUNARJETMAN$5B80 }
. LIST#
  $5B80,$01 Disable interrupts.
  $5B81,$0B Move #N$20FF bytes from #N$5F01 to #N$5F00.
  $5B8C,$03 Jump to #R$5F00.

i $5B8F

c $5CB0 Indirect Jump
@ $5CB0 label=IndirectJump
D $5CB0 Jumps to the handler address already held in #REGhl. This is the byte
. #N$E9 (JP (HL)) which sits in the Spectrum system variable
. #SKOOLKID$5CB0(NMIADD), reused as a trampoline.
E $5CB0 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$5CB0 }
. { #LUNARJETMAN$5CB0 }
. { #NIGHTSHADE$5CB0 }
. { #SABREWULF$5CB0 }
. LIST#
R $5CB0 HL Jump address
  $5CB0,$01 Jump to the address held in #REGhl.

i $5CB1

g $5E00 Best Time
@ $5E00 label=BestTime_1
D $5E00 The best time so far, as three BCD bytes. The hours are a single digit
. (in the low nibble). See #R$5E31 for the time of the current game.
B $5E00,$01 Hours.
@ $5E01 label=BestTime_2
B $5E01,$01 Minutes.
@ $5E02 label=BestTime_3
B $5E02,$01 Seconds.

g $5E03 Flag: Best Time
@ $5E03 label=Flag_BestTime
D $5E03 When a value for "Best Time" exists this will be #N$01 else it'll be #N$00.
B $5E03,$01

g $5E04 Player X Position
@ $5E04 label=PlayerMapPosition_Fraction
D $5E04 The position of the player's car along the map. It is a 24-bit number
. made up of a fraction of a map unit and then the position in map units. The
. fraction is needed because the car moves by less than one map unit each frame
. (see #R$6D73). The map is #N$1800 map units wide.
B $5E04,$01 Fraction of a map unit.
@ $5E05 label=PlayerMapPosition
W $5E05,$02 Position in map units.

g $5E07 Player Y Position
@ $5E07 label=PlayerMapPositionY_Fraction
D $5E07 The position of the player's car up the map, in the same way as
. #R$5E04. The map is #N$0C00 map units high.
B $5E07,$01 Fraction of a map unit.
@ $5E08 label=PlayerMapPositionY
W $5E08,$02 Position in map units.

g $5E0A Fuel
@ $5E0A label=Fuel_LSB
D $5E0A The amount of fuel in the tank, which is shown on the fuel gauge. It is
. used up as the car moves (see #R$6E7E) and set to #N$C0FF by a refuel (see
. #R$7012). The car is out of fuel when the high byte is #N$00.
B $5E0A,$01 Low byte.
@ $5E0B label=Fuel_MSB
B $5E0B,$01 High byte (#N$C0 is a full tank).

g $5E0C Temperature
@ $5E0C label=Temperature
D $5E0C The temperature of the engine, which is shown on the temperature gauge.
. It goes up to #N$C0, rising at high speeds and falling at low speeds (see
. #R$6E95). The car slows down as if it has no fuel when the temperature is
. #N$A0 or more.
B $5E0C,$01

g $5E0D Speed
@ $5E0D label=Speed
D $5E0D The speed of the player's car, which is shown on the speed gauge. It
. goes from #N$00 to #N$C0 (see #R$6D07).
B $5E0D,$01

g $5E0E Unknown
@ $5E0E label=Unknown_5E0E
D $5E0E Only ever written to, with #N$0000, when a new car is set up (see
. #R$63C1). Purpose not yet known.
B $5E0E,$02

g $5E10 Player Direction
@ $5E10 label=Player_Direction
D $5E10 The direction that the player's car is facing, as a #N$0400 step
. circle: #N$0000 is straight up and the car turns clockwise as the number
. increases. Steering changes it by #N$18 each frame (see #R$6E43).
B $5E10,$01 Low byte.
B $5E11,$01 High byte (the quadrant, #N$00-#N$03).

g $5E12 Unused
@ $5E12 label=Unused_5E12
D $5E12 This byte is not referenced by the game.
B $5E12,$01

g $5E13 Object Quadrant
@ $5E13 label=Object_Quadrant
D $5E13 Which side of the player's car the object being drawn is on, found by
. #R$6B47 and used by #R$6F3C. Bit 1 is set when the object is to the left of
. the car.
B $5E13,$01

g $5E14 Object Screen Position
@ $5E14 label=Object_Screen_X
D $5E14 The position on the screen of the object being drawn, which is worked
. out by #R$6F3C. The values are not used again after that.
B $5E14,$01 X position.
@ $5E15 label=Object_Screen_Y
B $5E15,$01 Y position.

g $5E16 Unused
@ $5E16 label=Unused_5E16
D $5E16 This byte is not referenced by the game.
B $5E16,$01

g $5E17 Object Distance X
@ $5E17 label=Object_Distance_X
D $5E17 The horizontal distance (always positive, in map units) from the
. player's car to the object being drawn, which is worked out by #R$6B47.
B $5E17,$01

g $5E18 Object Distance Y
@ $5E18 label=Object_Distance_Y
D $5E18 The vertical distance (always positive, in map units) from the
. player's car to the object being drawn, which is worked out by #R$6B47.
B $5E18,$01

g $5E19 Current Object
@ $5E19 label=CurrentObject
D $5E19 The address of the first entry in #R$7811 which might be in view of the
. player's car. #R$6B47 starts from here, and it is kept up to date by #R$6BFE
. and #R$6C2D.
W $5E19,$02

g $5E1B Flag: Pointer Moved Back
@ $5E1B label=Flag_PointerMovedBack
D $5E1B Set to #N$01 by #R$6C2D when it has moved the pointer at #R$5E19 back
. to an earlier map point, else #N$00.
B $5E1B,$01

g $5E1C Previous Distance
@ $5E1C label=PreviousDistance
D $5E1C The distance to the previous map point, kept by #R$6C2D when it is
. moving the pointer at #R$5E19 forwards.
W $5E1C,$02

g $5E1E Object Sprite ID
@ $5E1E label=ObjectSpriteID
D $5E1E The sprite ID that is used to draw the object being drawn by #R$6F3C.
. This is the same as #R$5E1F, unless the object is a place name.
B $5E1E,$01

g $5E1F Active Object
@ $5E1F label=ActiveObject
D $5E1F The sprite ID of the entry in #R$7811 that is being drawn by #R$6B47.
. Bit 6 is set for a place name, and a collected cup is #N$60.
B $5E1F,$01

g $5E20 Actor Buffer
@ $5E20 label=Actor_Position_X
D $5E20 The old state of the actor whose sprite is being erased and drawn again
. (see #R$71ED and #R$7101).
B $5E20,$01 X Position.
@ $5E21 label=Actor_Position_Y
B $5E21,$01 Y Position.
@ $5E22 label=Actor_SpriteID
B $5E22,$01 Sprite ID (#N$00 if there is no sprite to erase).
@ $5E23 label=HeightPixels
B $5E23,$01 Height (in pixels).
@ $5E24 label=WidthBytes
B $5E24,$01 Width (in bytes).
@ $5E25 label=CurrentSpriteHeight
B $5E25,$01 Number of lines of the old sprite left to erase.
@ $5E26 label=HeightLines
B $5E26,$01 Number of lines of the new sprite left to draw.

g $5E27 Actor Screen Position
@ $5E27 label=ActorScreenPosition
D $5E27 The position of the sprite being coloured by #R$704B.
B $5E27,$01 X Position.
B $5E28,$01 Y Position.

g $5E29 Game Timer
@ $5E29 label=GameTimer
D $5E29 16-bit counter starting at 0x0000 and counting +1 for each pass of the
. main loop (see #R$6A87). This continues until the game is over. Counter loops
. around after reaching #N$FFFF.
W $5E29,$02

g $5E2B Unused
@ $5E2B label=Unused_5E2B
D $5E2B This byte is not referenced by the game.
B $5E2B,$01

g $5E2C Width Counter
@ $5E2C label=WidthCounter
D $5E2C Temporary counter used when drawing sprites.
B $5E2C,$01

g $5E2D Miles
@ $5E2D label=Miles
D $5E2D The miles travelled, as six BCD digits (see #R$6D12 and #R$6CDE).
B $5E2D,$01 Digits 1 and 2.
B $5E2E,$01 Digits 3 and 4. Each time this changes the player is awarded
. points.
B $5E2F,$01 Digits 5 and 6.

g $5E30 Miles Fraction
@ $5E30 label=Miles_Fraction
D $5E30 The fraction of a mile that has been travelled, which carries over into
. the miles when it overflows (see #R$6D12).
B $5E30,$01

g $5E31 Time
@ $5E31 label=Time_1
D $5E31 The time taken in the current game, as three BCD bytes. The hours are a
. single digit (in the low nibble). See #R$64C7.
B $5E31,$01 Hours.
@ $5E32 label=Time_2
B $5E32,$01 Minutes.
@ $5E33 label=Time_3
B $5E33,$01 Seconds.

g $5E34 Player World Co-ordinates
@ $5E34 label=PlayerWorldPosition
D $5E34 The inverted low byte of #R$5E05 and the low byte of #R$5E08 from the
. last time that the terrain dots were moved (see #R$6588).
B $5E34,$02 Player X/ Y position in relation to the whole "World".

g $5E36 Player Marker Address
@ $5E36 label=PlayerMarker_Address
D $5E36 The screen address of the player's marker on the map in the sidebar (see
. #R$653E).
W $5E36,$02

g $5E38 Player Marker Byte
@ $5E38 label=PlayerMarker_Byte
D $5E38 The byte of the screen that is covered up by the player's marker on the
. map (see #R$6557).
B $5E38,$01

g $5E39 Current Place
@ $5E39 label=CurrentPlaceID
D $5E39 This value will either be the current Place ID or #N$FF to indicate being open to entering a new place (to
.       avoid repetition).
B $5E39,$01 Current Place ID or #N$FF.

g $5E3A Object Map Pointer
@ $5E3A label=ObjectMapPointer
D $5E3A The address of the entry in #R$7811 which follows the object that was
. last drawn, which is used to find the sprite ID of a cup or other object that
. has been reached.
W $5E3A,$02

g $5E3C Cups Collected
@ $5E3C label=Cups_Collected
B $5E3C,$01

g $5E3D Player Lives
@ $5E3D label=Player_Lives
B $5E3D,$01

g $5E3E Game Options
@ $5E3E label=GameOptions
D $5E3E #TABLE(default,centre,centre)
. { =h Byte | =h Binary | =h Option }
. { #N$00 | #EVAL($00, $02, $08) | Keyboard }
. { #N$02 | #EVAL($02, $02, $08) | Joystick }
. TABLE#
E $5E3E View the equivalent code in;
. #LIST
. { #UNDERWURLDE$8ED5 }
. LIST#
B $5E3E,$01

g $5E3F Current menu item colour attribute
@ $5E3F label=Current_MenuAttribute
B $5E3F,$01

g $5E40 Old Sprite Shift
@ $5E40 label=OldSpriteShift
D $5E40 The number of pixels that the old sprite is shifted to the right by (see
. #R$70B2).
B $5E40,$01

g $5E41 New Sprite Shift
@ $5E41 label=NewSpriteShift
D $5E41 The number of pixels that the new sprite is shifted to the right by (see
. #R$70D2).
B $5E41,$01

g $5E42 Object Attribute
@ $5E42 label=ObjectAttribute
D $5E42 The attribute of the object being drawn, which is worked out by
. #R$6B47.
B $5E42,$01

g $5E43 Flag: Day or Night
@ $5E43 label=Flag_DayNight
D $5E43 #TABLE(default,centre,centre) { =h Byte | =h Flag } { #N$00 | Day } { #N$01 | Night } TABLE#
B $5E43,$01

g $5E44 Background Attribute
@ $5E44 label=Background_Attribute
B $5E44,$01

g $5E45 Bounce Counter
@ $5E45 label=BounceCounter
D $5E45 Set to #N$05 when the car bounces off the edge of the map, and counted
. down by #R$6E43 while the bounce sound is made.
B $5E45,$01

g $5E46 Sound Counter
@ $5E46 label=SoundCounter
D $5E46 Used as a counter for the cup collection and refuelling sounds.
B $5E46,$01

g $5E47 Sound Store
@ $5E47 label=SoundStore
B $5E47,$01

g $5E48 Temporary Text Item X Position
@ $5E48 label=Temp_Text_Pos_X
D $5E48 Used for the indent for; #LIST { #R$5F6C(Game Menu items) } { #R$607D(Congratulations Messaging) } LIST#
B $5E48,$01

g $5E49 High Score
@ $5E49 label=High_Score
D $5E49 3-byte representation of the score.
E $5E49 View the equivalent code in;
. #LIST
. { #COOKIE$5F09 }
. { #JETPAC$5CF0 }
. { #LUNARJETMAN$5E06 }
. { #PSSST$5E00 }
. { #SABREWULF$B304 }
. LIST#
B $5E49,$01 Byte #1.
@ $5E4A label=High_Score_2
B $5E4A,$01 Byte #2.
@ $5E4B label=High_Score_3
B $5E4B,$01 Byte #3.

g $5E4C Score
@ $5E4C label=Score_1
D $5E4C 3-byte representation of the score.
B $5E4C,$01 Byte #1.
@ $5E4D label=Score_2
B $5E4D,$01 Byte #2.
@ $5E4E label=Score_3
B $5E4E,$01 Byte #3.

g $5E4F Last Place Visited
@ $5E4F label=LastPlaceVisited
D $5E4F The sprite ID of the last place that the car has refuelled at, so that
. the points for reaching a place are only awarded once in a row (see
. #R$7001). It is reset when a new car is set up.
B $5E4F,$01

g $5E50 Objects
@ $5E50 label=Object_1_State
@ $5E53 label=Object_2_State
@ $5E56 label=Object_3_State
@ $5E59 label=Object_4_State
@ $5E5C label=Object_5_State
@ $5E5F label=Object_6_State
@ $5E62 label=Object_7_State
@ $5E65 label=Object_8_State
D $5E50 The objects that are in view, which are drawn by #R$6F3C and removed by
. #R$6AF5. The sprite ID has bit 7 set when the object has been seen this
. frame, and the sprite ID is #N$00 when the slot is not used. The game only
. uses the first seven slots.
N $5E50 Object #N($01 + (#PC - $5E50) / $03).
B $5E50,$01 Sprite ID.
@ $5E51 label=Object_1_X
B $5E51,$01 X Position.
B $5E52,$01 Y Position.
L $5E50,$03,$08

g $5E68 Radar Blips
@ $5E68 label=RadarBlips
D $5E68 The three blips on the radar (see #R$625C): the first car, the second car
. and the nearest cup. Each is four bytes: the column and row where the blip is
. drawn, and then the column and row where it will be drawn next. A column and
. row of #N$00 and #N$00 mean that there is no blip.
B $5E68,$04
L $5E68,$04,$03

g $5E74 Miles Checkpoint
@ $5E74 label=MilesCheckpoint
D $5E74 The middle byte of the miles (#R$5E2E) the last time that points were
. awarded for it by #R$6D12.
B $5E74,$01

g $5E75 Unused
@ $5E75 label=Unused_5E75
D $5E75 These bytes are not referenced by the game.
B $5E75,$0B

g $5E80 Player Entity
@ $5E80 label=Entity_Player
D $5E80 The first of the three entities that the main loop handles (see
. #R$6009); #R$6A15 holds the initial values. This one is the player's car.
. The first byte is the state, which says what the entity is doing (#N$01 when
. driving and #N$03 when exploding). The player's car is drawn in the centre of
. the play area, so its position is not used for movement.
B $5E80,$01 State.
B $5E81,$01 X position on the screen.
B $5E82,$01 Y position on the screen.
B $5E83,$01 Attribute.
B $5E84,$01 Timer for the explosion (see #R$6318).
B $5E85,$07 Purpose not yet known.

g $5E8C First Car Entity
@ $5E8C label=Entity_Car_1
D $5E8C The first of the two cars that chase the player. See #R$6633 for what
. each of the fields means.
B $5E8C,$01 State, or the sprite ID while the car is being drawn.
B $5E8D,$01 X position on the screen.
B $5E8E,$01 Y position on the screen.
B $5E8F,$01 Colour.
@ $5E90 label=Entity_Car_1_X
W $5E90,$02 X position.
@ $5E92 label=Entity_Car_1_Y
W $5E92,$02 Y position.
B $5E94,$01 X speed.
B $5E95,$01 Y speed.
B $5E96,$01 Flags.
B $5E97,$01 Sprite ID.

g $5E98 Second Car Entity
@ $5E98 label=Entity_Car_2
D $5E98 The second of the two cars that chase the player. See #R$6633 for what
. each of the fields means.
B $5E98,$01 State, or the sprite ID while the car is being drawn.
B $5E99,$01 X position on the screen.
B $5E9A,$01 Y position on the screen.
B $5E9B,$01 Colour.
@ $5E9C label=Entity_Car_2_X
W $5E9C,$02 X position.
@ $5E9E label=Entity_Car_2_Y
W $5E9E,$02 Y position.
B $5EA0,$01 X speed.
B $5EA1,$01 Y speed.
B $5EA2,$01 Flags.
B $5EA3,$01 Sprite ID.

g $5EA4 Unused
@ $5EA4 label=Entities_End
D $5EA4 These bytes are not referenced by the game; #R$6A73 uses the address as
. the end of the entities.
B $5EA4,$5C

c $5F00 Security Check
@ $5F00 label=SecurityCheck
D $5F00 The game only starts when the second byte of #SKOOLKID$5C78(FRAMES) is
. #N$58. If it is any other value then this returns to the caller instead of
. running the game.
E $5F00 Continue on to #R$5F07.
E $5F00 View the equivalent code in;
. #LIST
. { #ATICATAC$6000 }
. { #COOKIE$5F00 }
. { #JETPAC$61E5 }
. { #LUNARJETMAN$8000 }
. { #PSSST$61C6 }
. { #SABREWULF$995A }
. LIST#
  $5F00,$01 Disable interrupts.
  $5F01,$03 Fetch the second byte of #SKOOLKID$5C78(FRAMES).
  $5F04,$03 Return if #REGa is not equal to #N$58.

c $5F07 Game Initialisation
@ $5F07 label=GameInitialisation
D $5F07 Clears the game variables, builds the day time game window and then runs
. the game selection menu until the player chooses to start a game.
E $5F07 View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #COOKIE$6298 }
. { #JETPAC$61EB }
. { #LUNARJETMAN$800A }
. { #PSSST$61CD }
. { #SABREWULF$9960 }
. LIST#
N $5F07 Blank the game variables.
  $5F07,$0D Write #N$00 to the #N$00A4 bytes from #N($5E00, $04, $04) to
. #N($5EA3, $04, $04).
  $5F14,$06 Write #N$FFFF to #R$5E00 (the best time) - this isn't used anywhere
. until #R$5E03 is set.
@ $5F1A label=Game_Restart
N $5F1A Entered again when a game is over, to return to the game selection menu.
  $5F1A,$06 Write #N$FFFF to #R$5E34.
  $5F20,$03 Set the stack pointer to #N($5E00, $04, $04).
  $5F23,$03 Set the day time attributes using #R$6175.
  $5F26,$03 Create the game window using #R$68A0.
N $5F29 Print the menu, then check the keyboard for the player's choice.
@ $5F29 label=GameSelect_Loop
  $5F29,$03 Print the game selection menu using #R$5F6C.
N $5F2C The "Best Time Today" banner only shows when one is set. The flag at
. #R$5E03 toggles it on/ off.
  $5F2C,$07 If #R$5E03 is not zero, call #R$6483.
  $5F33,$04 Take a copy of the control options from #R$5E3E.
  $5F37,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $5F3D,$01 Flip the bits, so a pressed key is now a set bit.
N $5F3E Handle keyboard selection.
@ $5F3E label=GameSelect_CheckKeyboard
  $5F3E,$04 Jump to #R$5F44 if key "1" has not been pressed ("1 KEYBOARD").
  $5F42,$02 Reset bit 1 of the options in #REGd, to select the keyboard.
N $5F44 Handle joystick selection.
@ $5F44 label=GameSelect_CheckJoystick
  $5F44,$04 Jump to #R$5F4A if key "2" has not been pressed ("2 JOYSTICK").
  $5F48,$02 Set bit 1 of the options in #REGd, to select the joystick.
N $5F4A Handle starting a new game.
@ $5F4A label=GameSelect_CheckStart
  $5F4A,$05 Jump to #R$5FEF if key "3" has been pressed ("3 START GAME").
N $5F4F Store the choice, then flash the selected menu line.
  $5F4F,$04 Save the control options back to #R$5E3E.
  $5F53,$03 Point #REGhl at the colour of the first selectable menu line
. (#R$5FA8), which skips the title.
  $5F56,$04 Fetch the control options from #R$5E3E into #REGc.
  $5F5A,$04 If the joystick option is selected, jump to #R$5F65.
N $5F5E Set the first menu item, unset the second.
@ $5F5E label=MenuAttributeSetFirst
  $5F5E,$02 Set the FLASH attribute for the first selection.
  $5F60,$01 Move on to the colour of the second menu line.
  $5F61,$02 Unset the FLASH attribute for the second selection.
  $5F63,$02 Jump to #R$5F29.
N $5F65 Unset the first menu item, set the second.
@ $5F65 label=MenuAttributeSetSecond
  $5F65,$02 Unset the FLASH attribute for the first selection.
  $5F67,$01 Move onto the next menu attribute.
  $5F68,$02 Set the FLASH attribute for the second selection.
  $5F6A,$02 Jump to #R$5F29.

c $5F6C Game Selection Menu
@ $5F6C label=GameMenu
D $5F6C Prints the five lines of the game selection menu. The X position of the
. text is #N$68 (held at #R$5E48), the colour of each line comes from the table
. at #R$5FA7, the Y positions come from the table at #R$5FAC and the text itself
. is held at #R$5FB1.
. The shadow registers hold the pointer to the Y positions (#REGhl'), the pointer to the text (#REGde') and the line counter (#REGb'). The main registers hold the pointer to the attributes (#REGde).
. #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5F29,stop=$5F2C)
. #SCR$02(game-selection-menu) } UDGTABLE# #POPS
E $5F6C View the equivalent code in;
. #LIST
. { #ATICATAC$7CAF }
. { #COOKIE$6332 }
. { #JETPAC$6260 }
. { #LUNARJETMAN$80D1 }
. { #PSSST$6250 }
. { #SABREWULF$B473 }
. { #UNDERWURLDE$90E4 }
. LIST#
  $5F6C,$05 Write the X position of the menu text, #N$68, to #R$5E48.
  $5F71,$03 Point #REGde at the table of menu line colours (#R$5FA7).
  $5F74,$01 Switch to the shadow registers.
  $5F75,$03 Point #REGhl' at the table of menu line Y positions (#R$5FAC).
  $5F78,$03 Point #REGde' at the menu text (#R$5FB1).
N $5F7B There are five lines of text.
  $5F7B,$02 Set the line counter to #N$05, one for each line of the menu.
@ $5F7D label=GameMenu_Loop
  $5F7D,$01 Switch back to the main registers.
  $5F7E,$04 Fetch the colour of this menu line and write it to #R$5E3F.
  $5F82,$01 Move on to the colour of the next menu line.
  $5F83,$01 Switch to the shadow registers.
  $5F84,$01 Stash the line counter on the stack.
  $5F85,$01 Fetch the Y position of this menu line.
  $5F86,$01 Move on to the Y position of the next menu line.
  $5F87,$01 Stash the Y position pointer on the stack.
  $5F88,$01 Set #REGh to the Y position of the line.
  $5F89,$04 Set #REGl to the X position of the text, from #R$5E48.
  $5F8D,$03 Print the line of text using #R$5F97.
  $5F90,$01 Switch to the shadow registers.
  $5F91,$02 Restore the Y position pointer and the line counter from the stack.
  $5F93,$01 Move the text pointer on to the start of the next line of text.
  $5F94,$02 Decrease the line counter by one and loop back to #R$5F7D until all
. of the lines have been printed.
  $5F96,$01 Return.

c $5F97 Write Menu Line
@ $5F97 label=MenuWriteText
D $5F97 Prints a line of text and sets the attributes for it. The last character
. of the text has bit 7 set. The attribute is held at #R$5E3F.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5F6C,stop=$5F8D)
. #SCR$04,$09,$03,$14,$03(write-menu-line-before)
. | #SIM(start=$5F8D,stop=$5F90)
. #SCR$04,$09,$03,$14,$03(write-menu-line-after) } UDGTABLE# #POPS
E $5F97 View the equivalent code in;
. #LIST
. { #ATICATAC$7D8A }
. { #COOKIE$63E0 }
. { #JETPAC$62FF }
. { #LUNARJETMAN$81AB }
. { #PSSST$62E7 }
. { #SABREWULF$B52D }
. { #UNDERWURLDE$91B0 }
. LIST#
R $5F97 HL Pixel co-ordinates (#REGh is the Y position, #REGl the X position)
R $5F97 DE Pointer to the text
  $5F97,$01 Stash the text position on the stack.
  $5F98,$03 Convert the text position to a screen address using #R$6F10.
  $5F9B,$03 Fetch the colour of the line from #R$5E3F.
  $5F9E,$01 Hold the colour in #REGa' ready for the string printer.
  $5F9F,$01 Switch to the shadow registers.
  $5FA0,$01 Restore the text position from the stack.
  $5FA1,$03 Convert the text position to an attribute address using #R$7097.
  $5FA4,$03 Jump to #R$6524 to print the text and set the attributes.

b $5FA7 Game Select Attribute Table
@ $5FA7 label=GameSelection_Attributes
@ $5FA8 label=GameSelection_Attributes_Options
D $5FA7 One attribute byte per menu line. The routines that flash the
. selected line set or clear FLASH in the byte for the line being
. updated. The first byte belongs to the title, so the flashing code
. starts at #R$5FA8.
E $5FA7 View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #COOKIE$635E }
. { #JETPAC$628D }
. { #LUNARJETMAN$810E }
. { #PSSST$627C }
. { #SABREWULF$B498 }
. { #UNDERWURLDE$9119 }
. LIST#
  $5FA7,$05,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | Game Selection }
. { #N$02 | 1 Keyboard }
. { #N$03 | 2 Joystick }
. { #N$04 | 3 Start Game }
. { #N$05 | © 1983 A.C.G. }
. TABLE#

b $5FAC Game Select Y Position Table
@ $5FAC label=GameSelection_Position
E $5FAC View the equivalent code in;
. #LIST
. { #ATICATAC$7CF1 }
. { #COOKIE$6365 }
. { #JETPAC$6293 }
. { #LUNARJETMAN$8115 }
. { #PSSST$6282 }
. { #SABREWULF$B4A0 }
. { #UNDERWURLDE$911F }
. LIST#
  $5FAC,$05,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | Game Selection }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | 1 Keyboard }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | 2 Joystick }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | 3 Start Game }
. { #N$05 | #EVAL(#PEEK(#PC+$04) / $08) | © 1983 A.C.G. }
. TABLE#

t $5FB1 Messaging: Game Selection Screen Text
@ $5FB1 label=GameSelection_Text
E $5FB1 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #COOKIE$636C }
. { #JETPAC$6299 }
. { #LUNARJETMAN$811C }
. { #PSSST$6288 }
. { #UNDERWURLDE$9125 }
. LIST#
  $5FB1,$0E,$0D:$01 "GAME SELECTION".
  $5FBF,$0B,$0A:$01 "1  KEYBOARD".
  $5FCA,$0B,$0A:$01 "2  JOYSTICK".
  $5FD5,$0D,$0C:$01 "3  START GAME".
  $5FE2,$0D,h$01,$0B:$01 "© 1983 A.C.G.".

c $5FEF Start Game
@ $5FEF label=StartGame
D $5FEF Resets the frame counter, the number of lives and the score, creates a
. new game, and then falls into the main loop.
E $5FEF View the equivalent code in;
. #LIST
. { #ATICATAC$7D9A }
. { #COOKIE$6428 }
. { #JETPAC$6333 }
. { #LUNARJETMAN$81BB }
. { #PSSST$632D }
. LIST#
  $5FEF,$07 Write #N$00 to #LIST { #SKOOLKID$5C78(FRAMES) } { #R$5E74 } LIST#
N $5FF6 Reset the players life count.
  $5FF6,$05 Set the number of lives to #N$03.
N $5FFB Reset the players score (#N$03 digits).
  $5FFB,$03 Point #REGhl at the score (#R$5E4C).
  $5FFE,$02 Set the byte counter to #N$03, as the score is held in three bytes.
@ $6000 label=ResetScore_Loop
  $6000,$02 Clear a byte of the score.
  $6002,$01 Move on to the next byte of the score.
  $6003,$02 Decrease the byte counter by one and loop back to #R$6000 until the
. whole score has been cleared.
  $6005,$01 Enable interrupts.
  $6006,$03 Set up a new game using #R$6391.

c $6009 Run Main Loop
@ $6009 label=MainLoop_NewPass
D $6009 The game loop. Each pass runs the handler for each of the three entities
. held from #R$5E80 (the player's car and the two opponent cars), in turn. The
. handler is chosen by the entity state held in the first byte of the entity,
. using the table at #R$6028. Once every entity has been handled #R$6A73 plays
. the engine sound, checks for a pause and starts the loop again.
. #TABLE(default,centre,centre)
. { =h State | =h Meaning }
. { #N$00 | Inactive }
. { #N$01 | Player car driving }
. { #N$02 | Opponent car driving }
. { #N$03 | Player car exploding }
. TABLE#
  $6009,$04 Point #REGix at the first entity, the player's car (#R$5E80).
  $600D,$03 Set the stack pointer to #N($5E00, $04, $04).
N $6010 Dispatch the handler for this entity.
@ $6010 label=MainLoop
  $6010,$04 Stash #R$6A73 on the stack as the return address for the handler.
  $6014,$03 Point #REGhl at the table of handlers (#R$6028).
  $6017,$03 Fetch the entity state from *#REGix+#N$00.
  $601A,$01 Rotate the state left, ready to use it as an index into the table of
. words.
  $601B,$02,b$01 Keep only bits 1-6.
  $601D,$03 Make the offset into the table of handlers in #REGbc.
  $6020,$01 Add the offset to the address of the table.
  $6021,$04 Fetch the address of the handler from the table into #REGhl.
  $6025,$03 Jump to the handler via #R$5CB0.

w $6028 Main Jump Table
@ $6028 label=JumpTable_Main
D $6028 The handler for each entity state, indexed by the state held in the
. first byte of the entity (see #R$6009).
  $6028,$02 State #N$00: #R$6030 (the entity is inactive).
  $602A,$02 State #N$01: #R$6A9B (the player's car is driving).
  $602C,$02 State #N$02: #R$6633 (an opponent car is driving).
  $602E,$02 State #N$03: #R$6318 (the player's car is exploding).

c $6030 Instant Return
@ $6030 label=Return
D $6030 The handler for an inactive entity. It does nothing.
  $6030,$01 Return.

t $6031 Messaging: Score/ Hi-Score Text
@ $6031 label=Text_ScoreHi
D $6031 The line of text printed along the top of the play area by #R$68F2. The
. first byte is the colour attribute (#COLOUR$70). The score is printed over the
. first run of spaces by #R$6CB6 and the high score over the last run by
. #R$6CBE.
  $6031,$15,h$01,$13:$01

c $6046 Add Points To Score
@ $6046 label=AddPointsToScore
D $6046 Adds a number of points to the score, using BCD arithmetic, and then
. prints the new score. The score is held as three BCD bytes from #R$5E4C, the
. least significant byte being the last.
E $6046 View the equivalent code in;
. #LIST
. { #ATICATAC$A19C }
. { #BUBBLER$9662 }
. { #COOKIE$7415 }
. { #CYBERUN$925E }
. { #JETPAC$70F9 }
. { #LUNARJETMAN$899C }
. { #MARTIANOIDS$B573 }
. { #NIGHTSHADE$C2ED }
. { #PENTAGRAM$BB29 }
. { #PSSST$737A }
. { #SABREWULF$B5A9 }
. { #UNDERWURLDE$A045 }
. LIST#
R $6046 B Points to add (hundreds and thousands, as BCD)
R $6046 C Points to add (units and tens, as BCD)
  $6046,$03 Point #REGhl at the units and tens of the score (#R$5E4E).
  $6049,$01 Fetch the units and tens of the score.
  $604A,$02 Add the units and tens of the points to it, using BCD.
  $604C,$01 Write the new units and tens back to the score.
  $604D,$01 Move on to the hundreds and thousands of the score.
  $604E,$01 Fetch the hundreds and thousands of the score.
  $604F,$02 Add the hundreds and thousands of the points, plus any carry, using
. BCD.
  $6051,$01 Write the new hundreds and thousands back to the score.
  $6052,$01 Move on to the ten thousands and hundred thousands of the score.
  $6053,$01 Fetch the ten thousands and hundred thousands of the score.
  $6054,$03 Add any carry from the hundreds and thousands to it, using BCD.
  $6057,$01 Write the new ten thousands and hundred thousands back to the score.
  $6058,$03 Jump to #R$6CB6 to print the new score.

c $605B Check High Score
@ $605B label=CheckHighScore
D $605B Compares the score with the high score, one byte at a time starting with
. the most significant. If the score is higher then it is copied over the high
. score.
E $605B View the equivalent code in;
. #LIST
. { #COOKIE$73D3 }
. { #JETPAC$6398 }
. LIST#
  $605B,$03 Point #REGde at the byte before the high score (#N$5E48), as the
. pointer is incremented before each byte is compared.
  $605E,$03 Point #REGhl at the byte before the score (#N$5E4B), as the pointer
. is incremented before each byte is compared.
  $6061,$02 Set the byte counter to #N$03, as the scores are held in three
. bytes.
@ $6063 label=CheckHighScore_Loop
  $6063,$01 Move on to the next byte of the score.
  $6064,$01 Move on to the next byte of the high score.
  $6065,$02 Compare the byte of the high score with the same byte of the score.
  $6067,$02 If the score byte is higher than the high score byte then jump to
. #R$606E, as there is a new high score.
  $6069,$02 If the two bytes are the same then jump to #R$606C to compare the
. next byte.
  $606B,$01 Return if the score byte is lower than the high score byte.
@ $606C label=CheckHighScore_Skip
  $606C,$02 Decrease the byte counter by one and loop back to #R$6063 until all
. three bytes have been compared.
N $606E A new High Score has been made, so update #R$5E49(HighScore).
@ $606E label=NewHighScore
  $606E,$02 Set the byte counter to #N$03, as the scores are held in three
. bytes.
  $6070,$03 Point #REGhl at the score (#R$5E4C).
  $6073,$03 Point #REGde at the high score (#R$5E49).
@ $6076 label=NewHighScore_CopyLoop
  $6076,$02 Copy a byte of the score to the high score.
  $6078,$01 Move on to the next byte of the score.
  $6079,$01 Move on to the next byte of the high score.
  $607A,$02 Decrease the byte counter by one and loop back to #R$6076 until the
. whole score has been copied.
  $607C,$01 Return.

c $607D Display Congratulations Messaging
@ $607D label=DisplayCongratsMessaging
D $607D Prints the four lines of the message shown when all eight cups have been
. collected. It sets up the shadow registers, as #R$5F6C does, and then reuses
. the printing loop at #R$5F7D.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SIM(start=$6414,stop=$641A)
. #SCR$01(congratulations-before)
. | #SIM(start=$641A,stop=$641D)
. #SCR$01(congratulations-after) } UDGTABLE# #POPS
  $607D,$05 Write the X position of the message text, #N$50, to #R$5E48.
  $6082,$03 Point #REGde at the table of line colours (#R$6091).
  $6085,$01 Switch to the shadow registers.
  $6086,$03 Point #REGhl' at the table of line Y positions (#R$6095).
  $6089,$03 Point #REGde' at the congratulations text (#R$6099).
  $608C,$02 Set the line counter to #N$04, one for each line of the message.
  $608E,$03 Jump to #R$5F7D to print the lines of the message.

b $6091 Congratulations Attributes
@ $6091 label=CongratsMessaging_Attributes
D $6091 The colour attribute of each line of the congratulations message
. (#COLOUR$70).
B $6091,$04

b $6095 Congratulations Y Positions
@ $6095 label=CongratsMessaging_Position
D $6095 The Y position, in pixels, of each line of the congratulations message.
B $6095,$04,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | "CONGRATULATIONS YOU" }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | " HAVE SUCCESSFULLY" }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | "COLLECTED THE EIGHT" }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | " CUPS OF ULTIMATE" }
. TABLE#

t $6099 Messaging: Congratulations
@ $6099 label=Message_Congrats
  $6099,$13,$12:$01 "CONGRATULATIONS YOU".
  $60AC,$12,$11:$01 " HAVE SUCCESSFULLY".
  $60BE,$13,$12:$01 "COLLECTED THE EIGHT".
  $60D1,$12,$11:$01 " CUPS OF ULTIMATE".

c $60E3 Sounds: Bounce
@ $60E3 label=SoundsBounce
D $60E3 Plays eight groups of four square waves using #R$614B. The period of
. each group comes from one of the first eight bytes of the ROM, with bit 7 set
. (so the period is never less than #N$80). This is the sound made when the car
. reaches the edge of the map.
. #HTML(#AUDIO0(bounce.wav)(#INCLUDE(Bounce)))
E $60E3 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$A173 }
. LIST#
  $60E3,$03 Point #REGhl at the start of the ROM, which supplies the periods of
. the waves.
  $60E6,$02 Set the group counter to #N$08, one for each group of waves.
@ $60E8 label=SoundsBounce_Loop
  $60E8,$02 Set the wave counter to #N$04, for the waves in each group.
  $60EA,$01 Fetch the next ROM byte.
  $60EB,$01 Move on to the next ROM byte.
  $60EC,$02,b$01 Keep only bits 0-6.
  $60EE,$02,b$01 Set bit 7.
  $60F0,$01 Set the period of the waves in this group.
@ $60F1 label=SoundsBounce_Play
  $60F1,$03 Play a square wave using #R$614B.
  $60F4,$03 Decrease the wave counter by one and loop back to #R$60F1 until all
. of the waves in the group have been played.
  $60F7,$03 Decrease the group counter by one and loop back to #R$60E8 until all
. of the groups have been played.
  $60FA,$01 Return.

c $60FB Play Sound
@ $60FB label=PlaySound
D $60FB Flips the speaker bit (bit 4) of the value held at #R$5E47 and writes
. the result to port #N$FE. The lower bits of the value set the border colour.
  $60FB,$03 Fetch the speaker and border state from #R$5E47.
  $60FE,$02,b$01 Flip bit 4 (the speaker).
  $6100,$03 Write the new speaker and border state back to #R$5E47.
  $6103,$02 Write the state to port #N$FE, which sets the speaker and the border
. colour.
  $6105,$01 Return.

c $6106 Play Noise
@ $6106 label=PlayNoise
D $6106 Steps through the first #N$0400 bytes of the ROM and flips the speaker,
. using #R$60FB, for every byte which has bit 4 set. The ROM contents are used
. as a source of noise. This is the sound made when an opponent car hits an
. obstacle.
. #HTML(#AUDIO0(noise.wav)(#INCLUDE(Noise)))
  $6106,$03 Point #REGhl at the start of the ROM, which is the source of the
. noise.
  $6109,$03 Set the byte counter to #N$0400.
@ $610C label=PlayNoise_Loop
  $610C,$01 Fetch the next ROM byte.
  $610D,$01 Move on to the next ROM byte.
  $610E,$02,b$01 Keep only bit 4.
  $6110,$02 Jump to #R$6115 if bit 4 is not set.
  $6112,$03 Flip the speaker using #R$60FB.
@ $6115 label=PlayNoise_Next
  $6115,$01 Decrease the byte counter by one.
  $6116,$04 Loop back to #R$610C until all #N$0400 bytes have been used.
  $611A,$01 Return.

c $611B Sounds: Cup/ Refuel
@ $611B label=SoundsCupRefuel
D $611B Plays the next step of the sound made when a cup is collected or the car
. is refuelled. This is called every frame but only makes a sound on every other
. frame.
. The step counter is held at #R$5E46. For the refuel sound it counts down from
. #N$07 and bit 7 is clear; each step has a higher pitch than the one before.
. For the cup sound it starts at #N$87 (bit 7 set) and each step has a lower
. pitch than the one before. Each step plays #N$20 square waves using #R$614B,
. and there are six of them.
. The cup sound: #HTML(#AUDIO0(cup-collected.wav)(#INCLUDE(CupCollected)))
. The refuel sound: #HTML(#AUDIO0(refuel.wav)(#INCLUDE(Refuel)))
  $611B,$03 Fetch the game timer from #R$5E29.
  $611E,$02,b$01 Keep only bit 0.
  $6120,$01 Return on every other frame.
  $6121,$03 Point #REGhl at the step counter (#R$5E46).
  $6124,$01 Fetch the step counter.
  $6125,$04 Jump to #R$613E if bit 7 is set, as that is the cup sound.
  $6129,$02 Return if the step counter is zero, as there is no sound to play.
  $612B,$01 Decrease the step counter by one.
  $612C,$01 Write the new step counter back to #R$5E46.
  $612D,$01 Return if the step counter has reached zero, as the sound is over.
N $612E Work out the period of the waves from the step counter.
@ $612E label=SoundsRefuel
  $612E,$02 Multiply the step counter by #N$04, by rotating it left twice.
  $6130,$02,b$01 Keep only bits 2-4.
  $6132,$02,b$01 Set bit 5.
  $6134,$01 Set the period of the waves.
  $6135,$02 Set the wave counter to #N$20.
@ $6137 label=SoundsCupRefuel_Loop
  $6137,$03 Play a square wave using #R$614B.
  $613A,$03 Decrease the wave counter by one and loop back to #R$6137 until all
. #N$20 waves have been played.
  $613D,$01 Return.
N $613E The cup sound keeps bit 7 set in the step counter, and inverts the step
. so that the pitch falls rather than rises.
@ $613E label=SoundsCup
  $613E,$02,b$01 Keep only the step counter (bits 0-6).
  $6140,$01 Return if the step counter is zero, as the sound is over.
  $6141,$01 Decrease the step counter by one.
  $6142,$02,b$01 Set bit 7 so that the sound stays the cup sound.
  $6144,$01 Write the new step counter back to #R$5E46.
  $6145,$02,b$01 Keep only the step counter (bits 0-6).
  $6147,$01 Return if the step counter has reached zero.
  $6148,$01 Flip the bits, so that the pitch falls with each step.
  $6149,$02 Jump to #R$612E.

c $614B Play Square Wave
@ $614B label=PlaySquareWave
D $614B Plays one cycle of a square wave. The speaker is flipped, then flipped
. back again after a delay of the same length.
E $614B View the equivalent code in;
. #LIST
. { #LUNARJETMAN$B8DA }
. LIST#
R $614B D Delay count for each half of the wave
  $614B,$03 Flip the speaker using #R$60FB.
  $614E,$01 Set the delay counter to the period of the wave.
@ $614F label=PlaySquareWave_Loop_1
  $614F,$02 Decrease the delay counter by one and loop back to #R$614F until the
. first half of the wave is over.
  $6151,$03 Flip the speaker using #R$60FB.
  $6154,$01 Set the delay counter to the period of the wave.
@ $6155 label=PlaySquareWave_Loop_2
  $6155,$02 Decrease the delay counter by one and loop back to #R$6155 until the
. second half of the wave is over.
  $6157,$01 Return.

c $6158 Sounds: Engine
@ $6158 label=SoundsEngine
D $6158 Plays the engine sound: four square waves using #R$614B. The period of
. the waves is #N$3F minus the speed divided by #N$04, so the faster the car is
. going, the higher the pitch. There is no sound when the car is stationary.
. #HTML(#AUDIO0(engine.wav)(#INCLUDE(Engine)))
  $6158,$03 Fetch the speed of the car from #R$5E0D.
  $615B,$02 Return if the car is stationary.
  $615D,$02 Divide the speed by #N$04, by rotating it right twice.
  $615F,$01 Flip the bits, so the faster the car the shorter the period.
  $6160,$02,b$01 Keep only bits 0-5.
  $6162,$01 Set the period of the waves.
  $6163,$02 Set the wave counter to #N$04.
  $6165,$07 If #R$5E80 is #N$03 then jump to #R$616E.
  $616C,$02 Set the delay counter to #N$0C (this has no effect, as it is
. overwritten).
@ $616E label=SoundsEngine_Loop
  $616E,$03 Play a square wave using #R$614B.
  $6171,$03 Decrease the wave counter by one and loop back to #R$616E until all
. #N$04 waves have been played.
  $6174,$01 Return.

c $6175 Set Day Playarea Attributes
@ $6175 label=SetDayAttributes
D $6175 Selects day time, using bright black on yellow (#COLOUR$70) for the play
. area background.
E $6175 Continue on to #R$617B.
  $6175,$04 Write #N$00 (day time) to #R$5E43.
  $6179,$02 Use the day time background attribute, #N$70.

c $617B Set Background Attribute
@ $617B label=SetBackgroundAttr
D $617B Stores the attribute used for the play area background.
R $617B A Background attribute
  $617B,$03 Write the attribute to #R$5E44, the background of the play area.
  $617E,$01 Return.

c $617F Set Night Playarea Attributes
@ $617F label=SetNightAttributes
D $617F Selects night time, using bright black on black (#COLOUR$40) for the
. play area background.
  $617F,$05 Write #N$01 (night time) to #R$5E43.
  $6184,$02 Use the night time background attribute, #N$40.
  $6186,$02 Jump to #R$617B.

c $6188 Controls: Kempston Joystick
@ $6188 label=ReadKempstonJoystick
D $6188 Reads the Kempston joystick. The bits are flipped so that, as with the
. keyboard routines, a direction which is pressed is a reset bit: bit 0 is
. right, bit 1 is left, bit 2 is down (brake) and bit 3 is up (accelerate).
E $6188 View the equivalent code in;
. #LIST
. { #JETPAC$733A }
. { #LUNARJETMAN$8F9B }
. { #SABREWULF$B0D9 }
. LIST#
R $6188 O:A Joystick controls
  $6188,$02 Read the Kempston joystick (port #N$1F) into #REGa.
  $618A,$01 Flip the bits.
  $618B,$01 Return.

c $618C Input: Left/ Right
@ $618C label=ReadInputLR
D $618C Reads the steering controls. From the keyboard the car steers left with
. Z, C, M or B, and steers right with X, V, N or FULL-STOP.
E $618C View the equivalent code in;
. #LIST
. { #JETPAC$733E }
. LIST#
R $618C O:A #N$FD if left is pressed, #N$FE if right is pressed, else #N$FF
N $618C Check if this should be read from the Kempston joystick instead?
  $618C,$07 If #R$5E3E indicates the control method is via the Kempston joystick
. then jump to #R$6188.
N $6193 Check for "Left" and "Right" button inputs for port #N$FE.
  $6193,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $6199,$02,b$01 Keep only bits 1-4 (stripping out the SHIFT key).
  $619B,$04 If none of these keys have been pressed, jump to #R$61A7.
  $619F,$02,b$01 Keep only bits 2 ("X") and 4 ("V").
  $61A1,$04 If neither key is pressed ("Z" or "C" is) jump to #R$61B9.
  $61A5,$02 Else "X" or "V" was pressed, so jump to #R$61BC.
N $61A7 Check for "Left" and "Right" button input for port #N$7F.
@ $61A7 label=ReadInputLR_7F
  $61A7,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | FULL-STOP | M | N | B }
. TABLE#
  $61AD,$02,b$01 Keep only bits 1-4 (stripping out the SPACE key).
  $61AF,$04 If none of these keys have been pressed, jump to #R$61BF.
  $61B3,$02,b$01 Keep only bits 2 ("M") and 4 ("B").
  $61B5,$04 If neither key is pressed ("N" or "FULL-STOP" is) jump to #R$61BC.
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
@ $61C2 label=ReadInputBrake
D $61C2 Reads the brake control. From the keyboard any key in the rows A to G,
. or ENTER to H, applies the brake.
E $61C2 View the equivalent code in;
. #LIST
. { #JETPAC$7374 }
. LIST#
R $61C2 O:A #N$FB if the brake is pressed, else #N$FF
N $61C2 Check if this should be read from the Kempston joystick instead?
  $61C2,$07 If #R$5E3E indicates the control method is via the Kempston joystick
. then jump to #R$6188.
N $61C9 Check for "Brake" button input.
  $61C9,$02 Set the keyboard row counter to #N$02.
  $61CB,$02 #REGa=#N$FD (the first keyboard row).
@ $61CD label=ReadInputBrake_Loop
  $61CD,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FD | A | S | D | F | G }
. { #N$BF | ENTER | L | K | J | H }
. TABLE#
  $61D1,$02,b$01 Keep only bits 0-4.
  $61D3,$04 If any buttons were pressed jump to #R$61DD.
  $61D7,$02 #REGa=#N$BF (the second keyboard row).
  $61D9,$02 Decrease the keyboard row counter by one and loop back to #R$61CD
. until both rows have been checked.
  $61DB,$02 Jump to #R$61BF.
N $61DD Return "Brake" button pressed.
@ $61DD label=Input_Brake
  $61DD,$02 #REGa=#EVAL($FB, $02, $08).
  $61DF,$01 Return.

c $61E0 Input: Accelerate
@ $61E0 label=ReadInputAccelerate
D $61E0 Reads the accelerator control. From the keyboard any key in the rows Q
. to T, or P to Y, accelerates the car.
E $61E0 View the equivalent code in;
. #LIST
. { #JETPAC$7393 }
. LIST#
R $61E0 O:A #N$F7 if accelerate is pressed, else #N$FF
N $61E0 Check if this should be read from the Kempston joystick instead?
  $61E0,$07 If #R$5E3E indicates the control method is via the Kempston joystick
. then jump to #R$6188.
N $61E7 Check for "Accelerator" button input.
  $61E7,$02 Set the keyboard row counter to #N$02.
  $61E9,$02 #REGa=#N$FB (the first keyboard row).
@ $61EB label=ReadInputAccelerate_Loop
  $61EB,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FB | Q | W | E | R | T }
. { #N$DF | P | O | I | U | Y }
. TABLE#
  $61EF,$02,b$01 Keep only bits 0-4.
  $61F1,$04 If any buttons were pressed jump to #R$61FB.
  $61F5,$02 #REGa=#N$DF (the second keyboard row).
  $61F7,$02 Decrease the keyboard row counter by one and loop back to #R$61EB
. until both rows have been checked.
  $61F9,$02 Jump to #R$61BF.
N $61FB Return "Accelerator" button pressed.
@ $61FB label=Input_Accelerate
  $61FB,$02 #REGa=#EVAL($F7, $02, $08).
  $61FD,$01 Return.

c $61FE Offset Blip Left
@ $61FE label=OffsetBlipLeft
D $61FE Continues #R$6212 when the target is to the left of the player (or level
. with it). The horizontal distance is scaled to radar pixels and taken away
. from the centre column of the radar. If the target is too far away then the
. blip is hidden.
R $61FE HL Horizontal distance from the target to the player
R $61FE IX Radar blip record
  $61FE,$03 Call #R$6253 to multiply the distance by #N$04, which leaves the
. distance in radar pixels in #REGh.
  $6201,$02 #REGa=#N$0C (the centre column of the radar).
  $6203,$01 Take the distance away from the centre column to give the column to
. the left of the player.
  $6204,$02 If the target is more than #N$0C pixels to the left then jump to
. #R$624D.
  $6206,$02 Jump to #R$622A to store the column.

c $6208 Offset Blip Down
@ $6208 label=OffsetBlipDown
D $6208 Continues #R$6212 when the target is not further up the map than the
. player. The vertical distance is scaled to radar pixels and added to the
. centre row of the radar. If the target is too far away then the blip is
. hidden.
R $6208 HL Vertical distance from the target to the player
R $6208 IX Radar blip record
  $6208,$03 Call #R$6253 to multiply the distance by #N$04, which leaves the
. distance in radar pixels in #REGh.
  $620B,$02 Start from the centre row of the radar (#N$0E).
  $620D,$01 Take the distance away from the centre row (flipped to a row below
. the centre at #R$6245).
  $620E,$02 If the target is more than #N$0E pixels away then jump to #R$624D.
  $6210,$02 Jump to #R$6245 to convert this into a row below the centre of the
. radar.

c $6212 Locate Radar Blip
@ $6212 label=LocateRadarBlip
D $6212 Works out where a target is shown on the radar. The radar is centred on
. the player and one radar pixel covers #N$20 map units. The column
. (#N$00-#N$18) and row (#N$00-#N$1C) are stored in the third and fourth bytes
. of the blip record, measured from the top left of the radar. If the target is
. more than #N$0C pixels to the left or right of the player, or more than #N$0E
. pixels above or below, then both are set to #N$00 and the blip is hidden.
R $6212 BC Target X position (doubled)
R $6212 DE Target Y position (doubled)
R $6212 IX Radar blip record
N $6212 Work out the horizontal distance between the player and the target.
  $6212,$03 #REGhl=player X map position (#R$5E05).
  $6215,$04 Double the value so it matches the scale of the target position.
  $6219,$01 Reset the carry flag.
  $621A,$02 Work out the horizontal distance from the target to the player.
  $621C,$02 If the target is not to the right of the player then jump to
. #R$61FE.
N $621E The target is to the right of the player, so make the distance positive.
  $621E,$03 Call #R$6BF6.
  $6221,$03 Call #R$6253 to multiply the distance by #N$04, which leaves the
. distance in radar pixels in #REGh.
  $6224,$02 Start from the centre column of the radar (#N$0C).
  $6226,$01 Compare the distance with #N$0C.
  $6227,$02 If the target is more than #N$0C pixels to the right then jump to
. #R$624D.
  $6229,$01 Add the distance to the centre column to give the column to the
. right of the player.
N $622A Store the column and do the same for the vertical distance.
@ $622A label=LocateRadarBlip_StoreColumn
  $622A,$03 Store the column in the blip record.
  $622D,$03 #REGhl=player Y map position (#R$5E08).
  $6230,$04 Double the value so it matches the scale of the target position.
  $6234,$01 Reset the carry flag.
  $6235,$02 Work out the vertical distance from the target to the player.
  $6237,$02 If the target is not further up the map than the player then jump to
. #R$6208.
N $6239 The target is further up the map than the player, so make the distance
. positive.
  $6239,$03 Call #R$6BF6.
  $623C,$03 Call #R$6253 to multiply the distance by #N$04, which leaves the
. distance in radar pixels in #REGh.
  $623F,$02 Start from the centre row of the radar (#N$0E).
  $6241,$01 Compare the distance with #N$0E.
  $6242,$02 If the target is more than #N$0E pixels away then jump to #R$624D.
  $6244,$01 Add the distance to the centre row.
N $6245 Rows are counted down the radar, so flip the value to give the row above
. the centre.
@ $6245 label=LocateRadarBlip_FlipRow
  $6245,$02 Negate #REGa.
  $6247,$02 Add #N$1C so the row counts down from the top of the radar.
N $6249 Store the row.
@ $6249 label=LocateRadarBlip_StoreRow
  $6249,$03 Store the row in the blip record.
  $624C,$01 Return.

c $624D Hide Radar Blip
@ $624D label=HideRadarBlip
D $624D Hides a blip by setting its column to #N$00, then jumps into #R$6212 to
. set its row to #N$00 as well.
R $624D IX Radar blip record
  $624D,$04 Write #N$00 to the column of the blip record.
  $6251,$02 Jump to #R$6249.

c $6253 Multiply HL By Four
@ $6253 label=MultiplyHLByFour
D $6253 Used to convert a distance (in doubled map units) into radar pixels,
. which are then found in #REGh.
R $6253 HL Value
R $6253 O:HL Value multiplied by #N$04
  $6253,$02 Set the shift counter to #N$02.
@ $6255 label=MultiplyHLByFour_Loop
  $6255,$04 Rotate #REGhl left by one place.
  $6259,$02 Decrease the shift counter by one and loop back to #R$6255 until
. both shifts have been done.
  $625B,$01 Return.

c $625C Update Radar
@ $625C label=UpdateRadar
D $625C Updates the radar. A blip is shown by clearing a #N$02 by #N$02 block of
. pixels, and removed again by setting them. The player is always the blip at
. the centre. The other blips are the two cars (at #R$5E8C and #R$5E98) and the
. first cup within range, which are tracked by three four-byte records starting
. at #R$5E68. The first two bytes of a record hold the column and row that were
. drawn last time and the next two bytes hold the new column and row, or zero if
. the target is not on the radar.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SIM(start=$6010,stop=$6AAE,sp=$5E00)
. #SCR$06,$00,$0A,$05,$05(update-radar-before)
. | #SIM(start=$6AAE,stop=$6AB1)
. #SCR$06,$00,$0A,$05,$05(update-radar-after) } UDGTABLE# #POPS
N $625C Draw the player at the centre of the radar.
  $625C,$03 #REGhl=#N$6513 (the pixel column and row of the centre of the
. radar).
  $625F,$03 #REGbc=#N($0202, $04, $04) (the size of a blip).
  $6262,$03 Call #R$6991 to clear the pixels.
N $6265 Work out the new position of each blip.
  $6265,$04 Point #REGix at the first blip record (#R$5E68).
  $6269,$04 Fetch the X position of the car at #R$5E8C from #R$5E90.
  $626D,$04 Fetch the Y position of the car at #R$5E8C from #R$5E92.
  $6271,$03 Call #R$6212.
  $6274,$03 Set the size of a blip record, #N$04.
  $6277,$02 Point #REGix at the next blip record.
  $6279,$04 Fetch the X position of the car at #R$5E98 from #R$5E9C.
  $627D,$04 Fetch the Y position of the car at #R$5E98 from #R$5E9E.
  $6281,$03 Call #R$6212.
  $6284,$03 Set the size of a blip record, #N$04.
  $6287,$02 Point #REGix at the next blip record.
  $6289,$03 Call #R$62DA to find a cup to show.
N $628C Now move each blip. This takes two passes: the first removes the blip
. from where it was last time and the second draws it at the new position.
  $628C,$04 Point #REGix at the first blip record (#R$5E68).
  $6290,$02 Set the blip counter to #N$03.
@ $6292 label=UpdateRadar_Loop
  $6292,$02 Set the pass counter to #N$02.
  $6294,$03 Fetch the column of the blip.
  $6297,$03 Fetch the row of the blip.
@ $629A label=UpdateRadar_Pass
  $629A,$04 If the blip is not on the radar then jump to #R$62D5.
  $629E,$04 Add #N$07 (the left edge of the radar) to the column.
  $62A2,$04 Add #N$57 (the top edge of the radar) to the row.
  $62A6,$01 Decrease the pass counter by one.
  $62A7,$01 Stash the counters on the stack.
  $62A8,$02 If this was the first pass then jump to #R$62C6.
N $62AA This is the second pass, so draw the blip at its new position.
  $62AA,$03 #REGbc=#N($0202, $04, $04) (the size of a blip).
  $62AD,$03 Call #R$6991 to clear the pixels.
  $62B0,$01 Restore the counters from the stack.
N $62B1 The new position becomes the position that was drawn.
@ $62B1 label=UpdateRadar_Next
  $62B1,$03 Fetch the new column of the blip.
  $62B4,$03 Store it as the column drawn.
  $62B7,$03 Fetch the new row of the blip.
  $62BA,$03 Store it as the row drawn.
  $62BD,$03 Set the size of a blip record, #N$04.
  $62C0,$02 Point #REGix at the next blip record.
  $62C2,$03 Decrease the blip counter by one and loop back to #R$6292 until all
. #N$03 blips have been done.
  $62C5,$01 Return.
N $62C6 This is the first pass, so remove the blip from where it was drawn last
. time.
@ $62C6 label=UpdateRadar_RemoveBlip
  $62C6,$03 #REGbc=#N($0202, $04, $04) (the size of a blip).
  $62C9,$03 Call #R$6998 to set the pixels.
  $62CC,$01 Restore the counters from the stack.
@ $62CD label=UpdateRadar_NewPosition
  $62CD,$03 Fetch the new column of the blip.
  $62D0,$03 Fetch the new row of the blip.
  $62D3,$02 Jump to #R$629A for the second pass.
N $62D5 There is no blip at this position.
@ $62D5 label=UpdateRadar_Hidden
  $62D5,$03 Decrease the pass counter by one and jump to #R$62B1 if both passes
. are done.
  $62D8,$02 Jump to #R$62CD for the second pass.

c $62DA Locate Radar Cup
@ $62DA label=CollisionCup
D $62DA Finds a cup to show on the radar. Each of the #N$08 cups in #R$721F is
. checked in turn: if the map entry still has the cup sprite ID (#N$20) and the
. cup is less than #N$0C cells (of #N$20 map units) from the player
. horizontally, then it is placed on the radar by #R$6212. Only the first such
. cup is used. If there is no cup then the blip is hidden.
E $62DA View the equivalent code in;
. #LIST
. { #PSSST$63AA }
. LIST#
R $62DA IX Radar blip record
N $62DA Find the player's horizontal position in cells.
  $62DA,$03 Fetch the player's X position on the map from #R$5E05.
  $62DD,$04 Double the value so it matches the scale used by the radar.
  $62E1,$03 Call #R$6253 to multiply the position by #N$04, which leaves the
. position in cells in #REGh.
  $62E4,$01 Keep the player's X position in cells in #REGc.
  $62E5,$03 Point #REGhl at the table of cup map addresses (#R$721F).
  $62E8,$02 Set the cup counter to #N$08, one for each cup.
N $62EA Fetch the address of the cup from #R$721F.
@ $62EA label=CollisionCup_Loop
  $62EA,$01 Fetch the low byte of the map address of this cup.
  $62EB,$01 Move on to the high byte.
  $62EC,$01 Fetch the high byte of the map address of this cup.
  $62ED,$01 Move on to the next cup in the table.
N $62EE Check this is still a valid cup (that it hasn't been collected already).
  $62EE,$02 Point #REGde at the sprite ID of the map entry.
  $62F0,$05 If this is not a cup (the sprite ID is not #N$20) then jump to
. #R$6301.
N $62F5 This is still a valid cup, so process it.
  $62F5,$02 Point #REGde back at the start of the map entry.
  $62F7,$01 Fetch the X position of the cup.
  $62F8,$01 Subtract the player's X position to give the horizontal distance.
  $62F9,$04 Make the distance positive.
@ $62FD label=CollisionCup_Test_X
  $62FD,$04 If the cup is less than #N$0C cells away then jump to #R$6306.
@ $6301 label=CollisionCup_Next
  $6301,$02 Decrease the cup counter by one and loop back to #R$62EA until all
. of the cups have been checked.
  $6303,$03 There is no cup in range so jump to #R$624D to hide the blip.
N $6306 Convert the position of the cup to the same scale used by #R$6212.
@ $6306 label=CollisionCup_Test_Y
  $6306,$01 Fetch the X position of the cup.
  $6307,$01 Point #REGde at the Y position of the cup.
  $6308,$01 Keep the X position of the cup in #REGh.
  $6309,$01 Fetch the Y position of the cup.
  $630A,$01 Keep the Y position of the cup in #REGd.
  $630B,$03 Call #R$6B30 to set #REGde to the cup Y position multiplied by
. #N$20.
  $630E,$01 Swap the #REGde and #REGhl registers.
  $630F,$03 Call #R$6B2B to set #REGde to the cup X position multiplied by
. #N$40.
  $6312,$01 Swap the #REGde and #REGhl registers.
  $6313,$01 Move the high byte of the doubled X position into #REGb.
  $6314,$01 Move the low byte of the doubled X position into #REGc.
  $6315,$03 Jump to #R$6212 to place the blip (#REGbc is the cup X position and
. #REGde is the cup Y position, both doubled).

c $6318 Handle Explosion
@ $6318 label=HandlerExplosion
D $6318 Runs while the car is exploding (state #N$03 in the first byte of the
. player entity at #R$5E80). The explosion timer (the fifth byte of the entity,
. which starts at #N$C0) counts down and when it reaches zero the game is over.
. Every four frames the sprite alternates between sprite IDs #N$21 and #N$22
. (the sprites at #R$7473 and #R$7494).
. The only sound while the car is exploding is the engine note, as the speed
. is set to #N$01 on every frame (see #R$6158).
. #HTML(#AUDIO0(explosion.wav)(#INCLUDE(Explosion)))
R $6318 IX Player entity (#R$5E80)
N $6318 #PUSHS #UDGTABLE(default,centre,centre,centre)
. { =h Before | =h Explosion 1 | =h Explosion 2 }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SIM(start=$6010,stop=$6A87,sp=$5E00)
. #SCR$04,$11,$0A,$06,$05(explosion-before)
. | #POKES$5E80,$03;$5E84,$A5
. #SIM(start=$6009,stop=$6A87,sp=$5E00)
. #SCR$04,$11,$0A,$06,$05(explosion-frame-1)
. | #POKES$5E84,$A1
. #SIM(start=$6009,stop=$6A87,sp=$5E00)
. #SCR$04,$11,$0A,$06,$05(explosion-frame-2) } UDGTABLE# #POPS
  $6318,$03 Fetch the sprite ID of the current explosion frame from the end of
. the entity.
  $631B,$03 Write #REGa to the first byte of the entity, as this is the sprite
. ID that #R$71ED copies.
  $631E,$03 Call #R$71ED to copy the position and sprite ID of the entity.
  $6321,$03 Call #R$6557 to keep the player's marker on the map flashing.
N $6324 Count down the length of the explosion.
  $6324,$05 Decrease the explosion timer by one and jump to #R$6353 if the
. explosion has finished.
  $6329,$03 Fetch the explosion timer.
  $632C,$02,b$01 Keep only bits 0-1.
  $632E,$02 If the result is not zero then keep the same sprite and jump to
. #R$6340.
  $6330,$06 If bit 2 of the explosion timer is not set then jump to #R$633C.
  $6336,$04 Write #N$21 to the sprite ID.
  $633A,$02 Jump to #R$6340.
N $633C The other frame of the explosion.
@ $633C label=HandlerExplosion_Frame2
  $633C,$04 Write #N$22 to the sprite ID.
N $6340 Redraw the explosion.
@ $6340 label=HandlerExplosion_Draw
  $6340,$03 Fetch the sprite ID of the current explosion frame.
  $6343,$03 Write #REGa to the first byte of the entity, as this is the sprite
. ID that #R$7101 draws.
  $6346,$03 Call #R$7101 to erase the old sprite and draw the new one.
  $6349,$04 Write #N$03 (the exploding state) to the first byte of the entity.
  $634D,$05 Set the speed of the car to #N$01, which leaves the engine making a
. low note.
  $6352,$01 Return.

c $6353 Game Over
@ $6353 label=GameOver
D $6353 Reached when the explosion has finished. Takes a life away. If there are
. lives left then the next car starts at #R$63A7, otherwise the best time is
. checked, "GAME OVER" is shown for a short while and the game restarts.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5F29,stop=$5F2C)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SIM(start=$6010,stop=$6A87,sp=$5E00)
. #POKES$5E3D,$00
. #SCR$01(game-over-before)
. | #SIM(start=$6353,stop=$637E)
. #SCR$01(game-over-after) } UDGTABLE# #POPS
E $6353 View the equivalent code in;
. #LIST
. { #ATICATAC$8C35 }
. { #COOKIE$6BE0 }
. { #LUNARJETMAN$A8E3 }
. { #PSSST$60FD }
. { #SABREWULF$AA6A }
. LIST#
  $6353,$03 Call #R$7139 to erase the explosion.
  $6356,$03 Switch to night time using #R$617F.
N $6359 Give a 50/50 chance of "Night Driver" mode.
  $6359,$02 Fetch a random number (from the Z80 refresh register).
  $635B,$02,b$01 Keep only bit 0.
  $635D,$02 If the random bit is clear then jump to #R$6362, keeping night time.
N $635F Else set "day" time.
  $635F,$03 Switch back to day time using #R$6175.
N $6362 See #POKE(infinite_lives,Infinite Lives).
@ $6362 label=GameOver_Skip
  $6362,$03 Point #REGhl at the number of lives (#R$5E3D).
  $6365,$01 Take a life away.
  $6366,$03 If the number of lives is not negative then jump to #R$63A7.
N $6369 Else, trigger the game over events.
  $6369,$02 Set the number of lives to #N$00.
  $636B,$01 Remove the return address (#R$6A73) pushed by the main loop from the
. stack.
  $636C,$03 Check for a new high score using #R$605B.
  $636F,$03 Switch to day time using #R$6175.
  $6372,$03 Create the game window using #R$68A0.
N $6375 Print the "Game Over" messaging.
  $6375,$03 #REGhl=#N($5878, $04, $04) (pixel co-ordinates: #REGh is the Y
. position and #REGl is the X position).
  $6378,$03 Point #REGde at the "GAME OVER" text (#R$63DA).
  $637B,$03 Print the text using #R$5F97.
N $637E Display the text for a short time.
  $637E,$02 Set the delay count to #N$04.
  $6380,$03 Wait using #R$6386.
  $6383,$03 Jump to #R$5F1A to go back to the game selection menu.

c $6386 Delay Loop
@ $6386 label=Delay
D $6386 A pure delay. #REGhl counts down from zero, round through #N$FFFF, back
. to zero again, and this is repeated #REGb times.
E $6386 View the equivalent code in;
. #LIST
. { #MARTIANOIDS$BD32 }
. LIST#
R $6386 B Number of times to execute the delay
  $6386,$03 Set the delay counter to #N$0000, which counts down through #N$FFFF.
N $6389 From #REGhl being set above (and for each loop), decrementing
. #N($0000, $04, $04) by one gives #N$FFFF.
@ $6389 label=Delay_Loop
  $6389,$01 Decrease the delay counter by one.
  $638A,$04 Loop back to #R$6389 until the delay counter is zero.
  $638E,$02 Decrease the repeat count by one and loop back to #R$6389 until the
. delay has been repeated #REGb times.
  $6390,$01 Return.

c $6391 Initialise New Game
@ $6391 label=NewGame
D $6391 Sets up a new game with three lives, no cups collected, and the miles
. and time reset. Continues into #R$63A7 which sets up the first car.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6006,sp=$5E00)
. #SCR$02,$00,$00,$08,$18(new-game-before)
. | #SIM(start=$6006,stop=$6009)
. #SCR$02,$00,$00,$08,$18(new-game-after) } UDGTABLE# #POPS
E $6391 View the equivalent code in;
. #LIST
. { #COOKIE$63F0 }
. { #LUNARJETMAN$A84C }
. LIST#
  $6391,$05 Write starting lives to #R$5E3D (duplicate of #R$5FF6 - possibly so
. POKEs would appear to not work?)
@ $6396 label=NewGame_ResetCups
  $6396,$04 Set the number of cups collected to #N$00.
  $639A,$03 Put the cups back at new positions using #R$6498.
N $639D Reset miles and time.
  $639D,$03 Point #REGhl at the miles (#R$5E2D).
  $63A0,$02 Set the byte counter to #N$07, to cover the miles and the time.
@ $63A2 label=GameInit_Reset
  $63A2,$02 Clear a byte of the miles and time.
  $63A4,$01 Move on to the next byte.
  $63A5,$02 Decrease the byte counter by one and loop back to #R$63A2 until the
. miles and time have been cleared.
N $63A7 Set up a new car.
@ $63A7 label=PlayerInit
  $63A7,$03 Create the game window using #R$68A0.
  $63AA,$03 Call #R$653E to find where the player's marker is on the map.
  $63AD,$03 Call #R$656E to save the screen byte at the position of the marker.
  $63B0,$03 Find the first object using #R$6BFE.
  $63B3,$03 Set up the entities using #R$6A09.
  $63B6,$06 Write #N($C000, $04, $04) (the maximum value for fuel) to #R$5E0A.
  $63BC,$0B Write #N($0000, $04, $04) to; #LIST { #R$5E0C } { #R$5E0E } {
. #R$5E10 } LIST#
  $63C7,$06 Set the player's X position on the map (#R$5E05) to
. #N($0C40, $04, $04).
  $63CD,$06 Set the player's Y position on the map (#R$5E08) to
. #N($0640, $04, $04).
  $63D3,$04 Clear the last place visited (#R$5E4F).
  $63D7,$03 Jump to #R$6BFE to find the first object.

t $63DA Messaging: Game Over
@ $63DA label=Message_GameOver
  $63DA,$09,$08:$01 "GAME OVER".
@ $63E3 label=Message_YourTime
  $63E3,$0D,$0C:$01 "YOUR TIME WAS".
@ $63F0 label=Message_BestTime
  $63F0,$0F,$0E:$01 "BEST TIME TODAY".

c $63FF Handler: Pick Up Cup
@ $63FF label=HandlerCup
D $63FF Awards the points for a cup, which are #N$0200 for the first cup up to
. #N$1600 for the eighth (the number of cups already collected plus one,
. doubled, in hundreds). If this was the last of the eight cups then the
. "congratulations" messaging is shown along with the time taken, "Best Time
. Today" is updated if it has been beaten, and a new round starts (without
. resetting the lives). Otherwise the number of cups collected is displayed.
N $63FF Calculate number of points to award.
  $63FF,$03 Fetch the number of cups collected so far (#R$5E3C).
  $6402,$03 Work out the points as (cups collected + #N$01) * #N$02, in BCD.
N $6405 Adds points to score.
  $6405,$01 Set the points to award, in hundreds (as BCD).
  $6406,$02 Set the units and tens of the points to #N$00.
  $6408,$03 Add the points to the score using #R$6046.
N $640B Handle incrementing the cup counter.
  $640B,$04 Increment #R$5E3C by one.
N $640F Have all the cups been collected?
  $640F,$01 Fetch the number of cups collected.
  $6410,$04 If fewer than #N$08 cups have been collected then jump to #R$646C to
. display the count.
N $6414 All cups have been collected, display the "congratulations" messaging.
  $6414,$03 Switch to day time using #R$6175.
  $6417,$03 Create the game window using #R$68A0.
  $641A,$03 Display the congratulations message using #R$607D.
N $641D Writes the line "YOUR TIME WAS".
  $641D,$03 #REGhl=#N($5868, $04, $04) (pixel co-ordinates: #REGh is the Y
. position and #REGl is the X position).
  $6420,$03 Point #REGde at the "YOUR TIME WAS" text (#R$63E3).
  $6423,$03 Print the text using #R$5F97.
N $6426 Set #REGhl to where the time itself will display.
  $6426,$03 #REGhl=#N($6880, $04, $04) (pixel co-ordinates: #REGh is the Y
. position and #REGl is the X position).
  $6429,$03 Call #R$6F10 to convert this into a screen address.
  $642C,$03 Display the time taken using #R$6CEC.
N $642F Has a "Best Time Today" been set yet?
  $642F,$06 If #R$5E03 is zero then jump to #R$645A.
  $6435,$03 Display the best time so far using #R$6483.
N $6438 Compare the time taken with the best time, one byte at a time starting
. with the most significant.
  $6438,$03 Point #REGhl at the best time (#R$5E00).
  $643B,$03 Point #REGde at the time taken (#R$5E31).
  $643E,$02 Set the byte counter to #N$03.
@ $6440 label=BestTime_Compare
  $6440,$02 Compare the byte of the time at #REGde against the byte of the best
. time at #REGhl.
  $6442,$02 If the time is less than the best time then jump to #R$645E.
  $6444,$02 If the bytes are the same then jump to #R$6448.
  $6446,$02 The time is more than the best time, so jump to #R$644C.
@ $6448 label=BestTime_Compare_Next
  $6448,$01 Move onto the next #R$5E00 byte.
  $6449,$01 Move onto the next #R$5E31 byte.
  $644A,$02 Decrease the byte counter by one and loop back to #R$6440 until all
. of the bytes have been compared.
N $644C Create a short pause, then start the next round.
@ $644C label=HandlerCup_Delay
  $644C,$02 Set the delay count to #N$0C.
  $644E,$03 Pause using #R$6386.
  $6451,$03 Call #R$6396 to reset the cups and set up a new car, which returns
. here.
  $6454,$03 Set the stack pointer to #N($5E00, $04, $04).
  $6457,$03 Jump to #R$6009.

c $645A Update "Best Time Today"
@ $645A label=BestTime_Set
D $645A Reached when no "Best Time Today" has been set yet. Sets the flag to say
. that one exists, then stores the time taken as the best time.
  $645A,$01 Make #REGa #N$01 (it is zero here).
  $645B,$03 Set the "Best Time Today" flag at #R$5E03.
@ $645E label=BestTime_Update
  $645E,$0C Write #R$5E31 to #R$5E00.
  $646A,$02 Jump to #R$644C.

c $646C Display Cups Collected
@ $646C label=DisplayCupsCollected
D $646C Shows a cup sprite and the number of cups collected.
N $646C Prints the cup sprite to the screen.
  $646C,$03 #REGhl=#N($672E, $04, $04) (pixel co-ordinates: #REGh is the Y
. position and #REGl is the X position).
  $646F,$03 Point #REGde at the cup sprite (#R$7F4A).
  $6472,$03 Call #R$70DB to set up the sprite at these co-ordinates.
  $6475,$03 Call #R$714C to draw the sprite.
N $6478 Print the "cups collected" count to the screen.
  $6478,$03 Point #REGde at the number of cups collected (#R$5E3C).
  $647B,$03 Set the screen address of the count, #N$48C6.
  $647E,$02 Set the digit counter to #N$01.
  $6480,$03 Jump to #R$6CD2 to print the count as a single digit.

c $6483 Display Best Time
@ $6483 label=DisplayBestTime
D $6483 Shows the "BEST TIME TODAY" line and the best time.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SIM(start=$5F29,stop=$5F2C)
. #POKES$5E00,$01;$5E01,$23;$5E02,$45;$5E03,$01
. #SCR$03,$08,$11,$18,$05(display-best-time-before)
. | #SIM(start=$5F2C,stop=$5F33)
. #SCR$03,$08,$11,$18,$05(display-best-time-after) } UDGTABLE# #POPS
N $6483 Writes the line "BEST TIME TODAY".
  $6483,$03 #REGhl=#N($9060, $04, $04) (pixel co-ordinates: #REGh is the Y
. position and #REGl is the X position).
  $6486,$03 Point #REGde at the "BEST TIME TODAY" text (#R$63F0).
  $6489,$03 Print the line using #R$5F97.
N $648C Set #REGhl to where the time itself will display.
  $648C,$03 #REGhl=#N($A080, $04, $04) (pixel co-ordinates: #REGh is the Y
. position and #REGl is the X position).
  $648F,$03 Call #R$6F10 to convert this into a screen address.
N $6492 Point to Best Time.
  $6492,$03 Point #REGde at the best time (#R$5E00).
  $6495,$03 Jump to #R$6CFD.

c $6498 Randomise Cup Positions
@ $6498 label=RandomiseCups
D $6498 Gives every cup on the map a new Y position from #N$20 to #N$9F, putting
. back any cups which have been collected. The numbers come from the ROM, read
. from a random address in the first #N$4000 bytes (the low byte of the address
. is whatever is in #REGe).
  $6498,$03 Point #REGbc at the end of the map (#R$7CD6, one byte past the end
. of #R$7811).
  $649B,$02 Fetch a random number (from the Z80 refresh register).
N $649D Limit the number to 0-63.
  $649D,$02,b$01 Keep only bits 0-5.
  $649F,$01 Use it as the high byte of a random ROM address, held in #REGd.
  $64A0,$03 #REGhl=#N($0000, $04, $04).
  $64A3,$02 Add #REGde to #REGhl then swap them over (this leaves #REGde
. unchanged).
  $64A5,$03 #REGhl=#R$7811(#N$7813) (the sprite ID of the first map entry).
N $64A8 Check the sprite ID of each map entry.
@ $64A8 label=RandomiseCups_Loop
  $64A8,$01 Fetch the sprite ID of the map entry.
  $64A9,$04 If this is a cup (#REGa is #N$20) then jump to #R$64B3.
  $64AD,$04 If this is not a collected cup (#REGa is not #N$60) then jump to
. #R$64BC.
  $64B1,$02 Put the cup back by writing #N$20 as the sprite ID.
N $64B3 Write a new random Y position.
@ $64B3 label=HandlerSpriteCup
  $64B3,$01 Point #REGhl at the Y position of the cup.
  $64B4,$01 Fetch a random byte from the ROM.
  $64B5,$01 Move on to the next ROM address.
  $64B6,$02,b$01 Keep only bits 0-6.
  $64B8,$02 Add #N$20 so that the Y position is between #N$20 and #N$9F.
  $64BA,$01 Store the new Y position of the cup.
  $64BB,$01 Point #REGhl back at the sprite ID of the map entry.
N $64BC Move on to the sprite ID of the next map entry, and check if the end of
. the map has been reached.
@ $64BC label=RandomiseCups_Next
  $64BC,$03 Increment #REGhl by three.
  $64BF,$01 Stash the map pointer on the stack.
  $64C0,$01 Reset the carry flag.
  $64C1,$02 Work out how far the map pointer is from the end of the map.
  $64C3,$01 Restore the map pointer from the stack.
  $64C4,$02 If the map pointer is before the end of the map then jump to
. #R$64A8.
  $64C6,$01 Return.

c $64C7 Handler: Update Time
@ $64C7 label=HandlerTime
D $64C7 Adds one second to the time taken every #N$32 frames. The time is held
. as three BCD bytes from #R$5E31: hours (a single digit), minutes and seconds.
  $64C7,$03 Fetch the frame counter from #SKOOLKID$5C78(FRAMES).
  $64CA,$03 Return if less than #N$32 frames (one second) have passed.
  $64CD,$02 Take #N$32 frames off the frame counter.
  $64CF,$03 Write the remaining frames back to #SKOOLKID$5C78(FRAMES).
N $64D2 Update the time from the smallest unit upwards.
N $64D2 Handles the "seconds".
  $64D2,$03 Point #REGhl at the seconds of the time (#R$5E33).
  $64D5,$01 Grab the seconds.
  $64D6,$01 Add one second.
  $64D7,$02 Convert to BCD and write seconds back to #R$5E33.
  $64D9,$03 Return unless seconds have reached #N$60.
  $64DC,$02 Reset seconds to #N$00.
N $64DE Handles the "minutes".
  $64DE,$01 Point #REGhl at the minutes of the time (#R$5E32).
  $64DF,$01 Grab the minutes.
  $64E0,$01 Add one minute.
  $64E1,$02 Convert to BCD and write minutes back to #R$5E32.
  $64E3,$03 Return unless minutes have reached #N$60.
  $64E6,$02 Reset minutes to #N$00.
N $64E8 Handles the "hours".
  $64E8,$01 Point #REGhl at the hours of the time (#R$5E31).
  $64E9,$01 Grab the hours.
  $64EA,$01 Add one hour.
  $64EB,$01 Convert to BCD.
  $64EC,$02,b$01 Keep only bits 0-3 (so the hours are a single digit).
  $64EE,$01 Write hours back to #R$5E31.
  $64EF,$01 Return.

c $64F0 Display Place Name
@ $64F0 label=DisplayPlaceName
D $64F0 Prints the name of a place on the bottom line of the screen. Nothing
. happens unless bit 6 of the sprite ID of the map entry is set, which marks it
. as a place name. Bits 0-5 are then the number of the name in #R$722F. The
. number plus one is written to #R$5E39 so that #R$6A9B knows a place name is
. being shown.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SCR$03,$08,$15,$18,$03(place-name-before)
. | #POKES$5DFE,$DA;$5DFF,$6F
. #SIM(start=$64F0,stop=$6FDA,a=$42,sp=$5DFE)
. #SCR$03,$08,$15,$18,$03(place-name-after) } UDGTABLE# #POPS
R $64F0 A Bits 0-6 of #R$5E1F
  $64F0,$03 Return if bit 6 of #REGa is not set (i.e. not a place name).
N $64F3 Strip out the bit which indicates the need to display the place name.
  $64F3,$02,b$01 Keep only bits 0-5.
  $64F5,$03 Set the minimum length of a place name without the "end-of-string"
. bit (e.g. "TUCSO(N)"), #N($0005, $04, $04).
  $64F8,$03 Point #REGhl at the table of place names (#R$722F).
  $64FB,$04 Write the number of the place name plus one to #R$5E39.
  $64FF,$02 Set the place name counter to the number of the place name.
  $6501,$02 If it is the first place name then there is no need to search, so
. jump to #R$650B.
N $6503 Speed up (slightly) searching through place names by adding #REGde
. (#N($0005, $04, $04)) to the start address.
@ $6503 label=DisplayPlaceName_Search
  $6503,$01 Add the minimum length of a place name to the pointer.
N $6504 Search for the end of the current place name.
@ $6504 label=DisplayPlaceName_Loop
  $6504,$02 If bit 7 (the "end-of-string" flag) is not set...
  $6506,$01 Increment #REGhl by one.
  $6507,$02 ...then jump to #R$6504.
N $6509 #REGb stores the entry number of the place name, so keep going until we
. find it.
  $6509,$02 Decrease the place name counter by one and loop back to #R$6503
. until the right place name has been reached.
N $650B Output the place name to the screen.
@ $650B label=DisplayPlaceName_Print
  $650B,$01 Swap the registers, so that #REGde points at the place name.
  $650C,$03 #REGhl=#N$B868 (pixel co-ordinates: #REGh is the Y position and
. #REGl is the X position).
  $650F,$01 Stash the pixel co-ordinates on the stack.
  $6510,$03 Convert them to a screen address using #R$6F10.
  $6513,$02 Set the attribute of the place name to #COLOUR$70.
  $6515,$01 Keep the attribute in the shadow #REGaf register.
  $6516,$02 Jump to #R$651F.

c $6518 Print Colour String
@ $6518 label=PrintStringColour
D $6518 Prints a string of characters and sets the attribute of each one. The
. first byte of the string is the attribute and the last character of the string
. has bit 7 set.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5F26,stop=$68F2)
. #SCR$04,$08,$00,$18,$01(print-colour-string-before)
. | #SIM(start=$68F2,stop=$68F8)
. #SCR$04,$08,$00,$18,$01(print-colour-string-after) } UDGTABLE# #POPS
E $6518 View the equivalent code in;
. #LIST
. { #ATICATAC$A1F3 }
. { #COOKIE$7488 }
. { #JETPAC$716C }
. { #LUNARJETMAN$8A11 }
. { #MARTIANOIDS$BD99 }
. { #PSSST$73ED }
. { #SABREWULF$B53D }
. { #UNDERWURLDE$9C3C }
. LIST#
R $6518 HL Pixel co-ordinates (#REGh is the Y position, #REGl the X position)
R $6518 DE Pointer to string data
  $6518,$01 Stash the pixel co-ordinates on the stack.
  $6519,$03 Convert them to a screen address using #R$6F10.
  $651C,$01 Fetch the attribute from the first byte of the string.
  $651D,$01 Keep the attribute in the shadow #REGaf register.
  $651E,$01 Increment #REGde by one to point to the text of the string.
@ $651F label=PrintStringColour_UseAttribute
  $651F,$01 Switch to the shadow registers.
  $6520,$01 Restore the pixel co-ordinates from the stack.
  $6521,$03 Find the attribute address of the cell using #R$7097.
N $6524 Print each character, and set its attribute.
@ $6524 label=PrintString_Loop
  $6524,$01 Switch back to the normal registers.
  $6525,$01 Fetch the character to print.
  $6526,$04 If bit 7 is set (which signifies the end of the string), jump to
. #R$6535.
  $652A,$03 Print the character using #R$6C96.
  $652D,$01 Move on to the next character of the string.
  $652E,$01 Switch to the shadow registers.
  $652F,$01 Switch to the shadow #REGaf register.
  $6530,$01 Copy the attribute byte to the screen.
  $6531,$01 Move on to the next cell on the row.
  $6532,$01 Switch to the shadow #REGaf register.
  $6533,$02 Jump to #R$6524.
N $6535 Because the last character contains the terminator, it needs to be
. handled separately.
@ $6535 label=PrintString_LastCharacter
  $6535,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $6537,$03 Print the last character using #R$6C96.
  $653A,$01 Switch to the shadow registers.
  $653B,$01 Switch to the shadow #REGaf register.
  $653C,$01 Copy the attribute byte to the screen.
  $653D,$01 Return.

c $653E Locate Player Marker
@ $653E label=LocatePlayerMarker
D $653E Works out where the player's marker belongs on the map in the sidebar,
. where one pixel is #N$80 units of the player's position. The marker is at
. #REGh=#N$47 - the Y position / #N$80 and #REGl=#N$08 + the X position / #N$80.
R $653E O:HL Pixel co-ordinates of the marker (#REGh is the Y position and #REGl is the X position)
  $653E,$04 Fetch the player's Y position on the map (#R$5E08).
  $6542,$04 Double it, so that #REGd holds the Y position / #N$80.
  $6546,$02 Start from #N$47, the bottom of the map.
  $6548,$01 Take the Y position away, as the map counts up from the bottom.
  $6549,$01 Keep the Y position of the marker in #REGd.
  $654A,$03 Fetch the player's X position on the map (#R$5E05).
  $654D,$04 Double it, so that #REGh holds the X position / #N$80.
  $6551,$01 Fetch the X position / #N$80.
  $6552,$02 Add #N$08, the X position of the left edge of the map.
  $6554,$01 Set the X position of the marker in #REGl.
  $6555,$01 Set the Y position of the marker in #REGh.
  $6556,$01 Return.

c $6557 Flash Player Marker
@ $6557 label=FlashPlayerMarker
D $6557 Shows the player's position on the map in the sidebar as a pixel which
. flashes on and off every #N$08 frames. When the marker moves, the screen byte
. it was covering is put back, using the copy saved in #R$5E38. The address of
. that byte is held in #R$5E36.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Marker on | =h Marker off }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #POKES$5E05,$C0;$5E06,$0C;$5E08,$98;$5E09,$05
. #SIM(start=$6010,stop=$6AAB,sp=$5E00)
. #POKES$5E29,$08
. #SIM(start=$6AAB,stop=$6AAE)
. #SCR$08,$02,$06,$05,$03(flash-marker-on)
. | #POKES$5E29,$00
. #SIM(start=$6AAB,stop=$6AAE)
. #SCR$08,$02,$06,$05,$03(flash-marker-off) } UDGTABLE# #POPS
  $6557,$03 Work out the pixel co-ordinates of the marker using #R$653E.
N $655A Has the marker moved? The saved value is a screen address, whereas
. #REGhl holds pixel co-ordinates, so these are only equal by coincidence.
  $655A,$01 Stash the pixel co-ordinates on the stack.
  $655B,$04 Fetch the screen address saved for the marker (#R$5E36).
  $655F,$01 Reset the carry flag.
  $6560,$02 Compare the pixel co-ordinates with the saved screen address.
  $6562,$01 Restore the pixel co-ordinates from the stack.
  $6563,$02 Jump to #R$657A if the result was zero.
N $6565 Put back the screen byte that was covered by the marker.
  $6565,$01 Stash the pixel co-ordinates on the stack.
  $6566,$03 Fetch the screen address of the byte the marker covered (#R$5E36).
  $6569,$03 Fetch the screen byte that the marker covered (#R$5E38).
  $656C,$01 Put the screen byte back.
  $656D,$01 Restore the pixel co-ordinates from the stack.
N $656E Save the screen byte at the position of the marker.
@ $656E label=FlashPlayerMarker_SaveByte
  $656E,$01 Stash the pixel co-ordinates on the stack.
  $656F,$03 Convert the pixel co-ordinates to a screen address using #R$6F10.
  $6572,$03 Save the screen address of the marker at #R$5E36.
  $6575,$01 Fetch the screen byte at the marker.
  $6576,$03 Save the screen byte at #R$5E38.
  $6579,$01 Restore the pixel co-ordinates from the stack.
N $657A Flash the marker, setting the pixel on one phase and clearing it on the
. other.
@ $657A label=FlashPlayerMarker_Flash
  $657A,$03 Set the size of the marker, a single pixel (#N($0101, $04, $04)).
  $657D,$03 Fetch the game timer from #R$5E29.
  $6580,$02,b$01 Keep only bit 3, which changes every #N$08 frames.
  $6582,$03 If the bit is set then jump to #R$6998 to draw the marker.
  $6585,$03 Else jump to #R$6991 to remove the marker.

c $6588 Update Terrain Dots
@ $6588 label=UpdateTerrainDots
D $6588 Moves the dots which are scattered over the play area, to give the
. impression that the car is moving. Nothing happens unless the car has moved
. since last time. Each of the #N$10 dots at #R$65FD is then redrawn by #R$65B1.
. The low bytes of the player's X (flipped) and Y positions are saved in #R$5E34
. so the dots can be erased from where they were drawn.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SIM(start=$6010,stop=$6AB1,sp=$5E00)
. #SCR$02,$09,$03,$16,$12(terrain-dots-before)
. | #SIM(start=$6AB1,stop=$6AB4)
. #SCR$02,$09,$03,$16,$12(terrain-dots-after) } UDGTABLE# #POPS
  $6588,$03 Fetch the player position used last time (#R$5E34).
  $658B,$03 Fetch the low byte of the player's X position on the map (#R$5E05).
  $658E,$01 Flip all the bits, as the dots move the opposite way to the car.
  $658F,$01 Keep the flipped X position in #REGe.
  $6590,$04 Fetch the low byte of the player's Y position on the map (#R$5E08)
. and keep it in #REGd.
N $6594 Check if the player has moved.
  $6594,$01 Reset the carry flag.
  $6595,$01 Stash #REGhl on the stack.
  $6596,$02 Compare the new player position with the position used last time.
  $6598,$01 Restore #REGhl from the stack.
  $6599,$01 Return if the player has not moved.
  $659A,$01 Stash the new player position on the stack.
  $659B,$04 Point #REGix at the first terrain dot (#R$65FD).
  $659F,$02 Set the dot counter to #N$10.
@ $65A1 label=UpdateTerrainDots_Loop
  $65A1,$01 Stash the dot counter on the stack.
  $65A2,$03 Update the dot using #R$65B1.
  $65A5,$04 Point #REGix at the next dot.
  $65A9,$01 Restore the dot counter from the stack.
  $65AA,$02 Decrease the dot counter by one and loop back to #R$65A1 until all
. #N$10 dots have been updated.
  $65AC,$01 Restore the new player position from the stack.
  $65AD,$03 Write #REGhl to #R$5E34.
  $65B0,$01 Return.

c $65B1 Update Terrain Dot
@ $65B1 label=UpdateTerrainDot
D $65B1 Erases a terrain dot if it has been drawn, then draws it at its new
. position if that is inside the play area. The attribute of the cell containing
. the dot is also set. A dot is drawn as a #N$02 by #N$02 block of pixels.
R $65B1 D Low byte of the player Y map position
R $65B1 E Low byte of the player X map position (flipped)
R $65B1 IX Terrain dot (an entry in #R$65FD)
  $65B1,$03 Set the size of a dot (#N($0202, $04, $04)).
  $65B4,$07 If bit 0 of the X position is set (the dot has been drawn) then call
. #R$6980 to erase it.
N $65BB Work out the X position of the dot on the screen.
  $65BB,$03 Fetch the X position of the dot.
  $65BE,$02,b$01 Keep only bits 1-7.
  $65C0,$02 Negate it, as the dots move the opposite way to the car.
  $65C2,$01 Add the player's X position to give the X position of the dot on the
. screen.
  $65C3,$03 Return if this is before the left edge of the play area (less than
. #N$48).
  $65C6,$03 Return if this is after the right edge of the play area (#N$F8 or
. more).
  $65C9,$01 Set the X position on the screen in #REGl.
N $65CA Work out the Y position of the dot on the screen.
  $65CA,$01 Fetch the player's Y position.
  $65CB,$03 Take the Y position of the dot away to give the Y position on the
. screen.
  $65CE,$03 Return if this is above the top of the play area (less than #N$08).
  $65D1,$03 Return if this is below the bottom of the play area (#N$B8 or more).
  $65D4,$01 Set the Y position on the screen in #REGh.
N $65D5 Draw the dot.
  $65D5,$04 Set bit 0 of the X position to show that the dot has been drawn.
  $65D9,$03 #REGbc=#N$0202 (the size of a dot).
  $65DC,$01 Stash the pixel co-ordinates on the stack.
  $65DD,$03 Call #R$6998.
  $65E0,$01 Restore the pixel co-ordinates from the stack.
  $65E1,$01 Stash #REGde on the stack.
  $65E2,$03 Find the attribute address of the cell using #R$7097.
  $65E5,$01 Restore #REGde from the stack.
N $65E6 Set the attribute of the cell. At night this is the background attribute
. with white ink, so the dot can be seen. In the day it is the background
. attribute.
  $65E6,$06 Jump to #R$65F8 if #R$5E43 is zero.
  $65EC,$03 Fetch the background attribute (#R$5E44).
  $65EF,$02,b$01 Set bits 0-2, which gives white ink so the dot can be seen.
@ $65F1 label=UpdateTerrainDot_Apply
  $65F1,$01 Keep the new attribute in #REGc.
  $65F2,$01 Fetch the current attribute of the cell.
  $65F3,$03 Return if the attribute is already #N$76.
  $65F6,$01 Set the attribute of the cell.
  $65F7,$01 Return.
@ $65F8 label=UpdateTerrainDot_Day
  $65F8,$03 Fetch the background attribute (#R$5E44).
  $65FB,$02 Jump to #R$65F1.

b $65FD Terrain Dots
@ $65FD label=TerrainDots
D $65FD The #N$10 dots scattered over the play area. Each entry is two bytes:
. the X position and the Y position of the dot. Bit 0 of the X position is
. set when the dot is drawn.
  $65FD,$02 Entity #N($01 + (#PC - $65FD) / $02) X/ Y co-ordinates.
L $65FD,$02,$10

c $661D Reduce Car X Position
@ $661D label=ReduceCarX
D $661D Continues #R$6633 when the car is moving towards lower X positions.
. Takes the distance away from the X position, stopping at zero.
R $661D DE X position of the car
R $661D HL Distance to move
  $661D,$01 Swap #REGde and #REGhl so that #REGhl is the X position and #REGde
. is the distance.
  $661E,$01 Reset the carry flag.
  $661F,$02 #REGhl=#REGhl - #REGde.
  $6621,$02 If the result is not negative then jump to #R$6659.
  $6623,$03 #REGhl=#N($0000, $04, $04) (stop at zero).
  $6626,$02 Jump to #R$6659.

c $6628 Reduce Car Y Position
@ $6628 label=ReduceCarY
D $6628 Continues #R$6633 when the car is moving towards lower Y positions.
. Takes the distance away from the Y position, stopping at zero.
R $6628 DE Y position of the car
R $6628 HL Distance to move
  $6628,$01 Swap #REGde and #REGhl so that #REGhl is the Y position and #REGde
. is the distance.
  $6629,$01 Reset the carry flag.
  $662A,$02 #REGhl=#REGhl - #REGde.
  $662C,$02 If the result is not negative then jump to #R$6681.
  $662E,$03 #REGhl=#N($0000, $04, $04) (stop at zero).
  $6631,$02 Jump to #R$6681.

c $6633 Handler: Car
@ $6633 label=HandlerCar
D $6633 Moves and draws one of the two cars (the entities at #R$5E8C and
. #R$5E98), which chase the player. The car is drawn at its position relative to
. the player, but only when it is closer than #N$58 map units in both
. directions. It is then steered towards the player, bounces off objects, and
. destroys the player if it hits.
. #TABLE(default,centre,centre)
. { =h Byte | =h Contents }
. { #N$00 | State (#N$02), or the sprite ID while the car is being drawn }
. { #N$01 | X position on the screen }
. { #N$02 | Y position on the screen }
. { #N$03 | Colour (#N$00 or #N$02), or the attribute while the car is drawn }
. { #N$04-#N$05 | X position (twice the map position) }
. { #N$06-#N$07 | Y position (twice the map position) }
. { #N$08 | X speed (bit 7: moving to lower X; bits 0-4: speed) }
. { #N$09 | Y speed (bit 7: moving to lower Y; bits 0-4: speed) }
. { #N$0A | Flags (bit 0: car is drawn; bit 7: faster car) }
. { #N$0B | Sprite ID }
. TABLE#
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SIM(start=$6010,stop=$6A87,sp=$5E00)
. #SCR$02,$08,$00,$18,$18(handler-car-before)
. | #POKES$5E90,$C0;$5E91,$18;$5E92,$B0;$5E93,$0C
. #SIM(start=$6009,stop=$6A87,sp=$5E00)
. #SCR$02,$08,$00,$18,$18(handler-car-after) } UDGTABLE# #POPS
R $6633 IX Car entity
N $6633 Draw the car using the sprite ID from the last frame.
  $6633,$03 Fetch the sprite ID of the car from the last frame.
  $6636,$03 Write #REGa to the first byte of the entity, as this is the sprite
. ID that #R$71ED copies.
  $6639,$03 Call #R$71ED to copy the position and sprite ID of the entity.
N $663C Move the car in the X direction. The distance moved is the X speed
. divided by #N$04, or by #N$02 for the faster car.
  $663C,$03 #REGd=high byte of the X position.
  $663F,$03 #REGe=low byte of the X position.
  $6642,$03 Fetch the X speed of the car.
  $6645,$06 If the car is the faster car (bit 7 of the flags is set) then jump
. to #R$664C.
  $664B,$01 Halve the speed again, as this is not the faster car.
@ $664C label=HandlerCar_ScaleSpeedX
  $664C,$01 Halve the speed.
  $664D,$02,b$01 Keep only bits 0-3 to give the distance to move.
  $664F,$03 #REGhl=the distance to move.
  $6652,$06 If the car is moving towards lower X then jump to #R$661D to
. subtract the distance.
  $6658,$01 Add the distance to the X position.
@ $6659 label=HandlerCar_StoreX
  $6659,$03 Store the high byte of the new X position.
  $665C,$03 Store the low byte of the new X position.
  $665F,$04 Halve the X position (to match the scale of the player position).
  $6663,$01 Stash the X position on the stack.
N $6664 Move the car in the Y direction in the same way.
  $6664,$03 #REGd=high byte of the Y position.
  $6667,$03 #REGe=low byte of the Y position.
  $666A,$03 #REGa=Y speed.
  $666D,$06 If bit 7 of the flags is set then jump to #R$6674.
  $6673,$01 Divide #REGa by two.
@ $6674 label=HandlerCar_ScaleSpeedY
  $6674,$01 Divide #REGa by two.
  $6675,$02,b$01 Keep only bits 0-3.
  $6677,$03 #REGhl=the distance to move.
  $667A,$06 If the car is moving towards lower Y then jump to #R$6628 to
. subtract the distance.
  $6680,$01 Add the distance to the Y position.
@ $6681 label=HandlerCar_StoreY
  $6681,$03 Store the high byte of the new Y position.
  $6684,$03 Store the low byte of the new Y position.
  $6687,$04 Halve the Y position (to match the scale of the player position).
N $668B Work out the distance between the car and the player, and which side of
. the player the car is on. This is kept in the shadow #REGaf register: bit 0 is
. set if the car is below the player and bit 1 is set if the car is to the left
. of the player.
  $668B,$04 Fetch the player's Y position on the map (#R$5E08).
  $668F,$02 Reset the shadow #REGaf register.
  $6691,$02 Take the player's Y position away from the Y position of the car.
  $6693,$02 If the car is not below the player then jump to #R$669C.
  $6695,$03 Call #R$6BF6 to make the distance positive.
  $6698,$01 Switch to the shadow #REGaf register.
  $6699,$02 Set bit 0 by making #REGa #N$01, as the car is below the player.
  $669B,$01 Switch back to the normal #REGaf register.
N $669C Do the same for the X direction.
@ $669C label=HandlerCar_DistanceX
  $669C,$01 Swap the Y distance with the X position on the stack.
  $669D,$04 Fetch the player's X position on the map (#R$5E05).
  $66A1,$01 Reset the carry flag.
  $66A2,$02 Take the player's X position away from the X position of the car.
  $66A4,$02 If the car is not to the left of the player then jump to #R$66AD.
  $66A6,$03 Call #R$6BF6 to make the distance positive.
  $66A9,$01 Switch to the shadow #REGaf register.
  $66AA,$02,b$01 Set bit 1.
  $66AC,$01 Switch back to the normal #REGaf register.
@ $66AD label=HandlerCar_CheckVisible
  $66AD,$01 Fetch the Y distance from the player.
  $66AE,$01 Switch to the shadow #REGaf register.
  $66AF,$01 Keep the direction flags in #REGc.
N $66B0 The car is only drawn when both distances are less than #N$58.
  $66B0,$05 Jump to #R$6741 if either distance is more than #N$FF.
  $66B5,$06 Jump to #R$6741 if the X distance is #N$58 or more.
  $66BB,$06 Jump to #R$6741 if the Y distance is #N$58 or more.
N $66C1 Work out the position of the car on the screen. The player is at #N$98
. across and #N$68 down.
  $66C1,$04 If the car is below the player then jump to #R$66C7.
  $66C5,$02 Negate the Y distance, as the car is above the player.
@ $66C7 label=HandlerCar_AddPlayerY
  $66C7,$02 Add #N$68 (the Y position of the player).
  $66C9,$03 Store the Y position of the car.
  $66CC,$02 Check if the car is to the left of the player.
  $66CE,$01 Fetch the X distance from the player.
  $66CF,$02 If the car is not to the left of the player then jump to #R$66D3.
  $66D1,$02 Negate the X distance, as the car is to the left of the player.
@ $66D3 label=HandlerCar_AddPlayerX
  $66D3,$02 Add #N$98 (the X position of the player).
  $66D5,$03 Store the X position of the car.
N $66D8 Choose which of the #N$10 car sprites to use, so that the car points in
. the direction it is moving. The quadrant of travel comes from the direction
. bits (bit 7) of the two speeds, and the angle within it from #R$683B using the
. top three bits of each speed.
  $66D8,$01 Stash the direction flags on the stack.
  $66D9,$04 Fetch the Y speed and keep it in #REGe.
  $66DD,$01 Rotate #REGa left so that bit 0 is the direction bit of the Y speed.
  $66DE,$04 Fetch the X speed and keep it in #REGb.
  $66E2,$02 Rotate #REGc left so that bit 0 is the direction bit of the X speed.
  $66E4,$01 Exclusive OR #REGa with #REGc.
  $66E5,$02,b$01 Keep only bit 0.
  $66E7,$02 Shift #REGc left so that bit 1 is the direction bit of the X speed.
  $66E9,$01 Combine the bits.
  $66EA,$02,b$01 Keep only bits 0-1 (the quadrant).
  $66EC,$04 Multiply the quadrant by #N$04.
  $66F0,$01 Keep the quadrant in #REGc.
  $66F1,$01 Fetch the X speed.
  $66F2,$02 Divide the X speed by four.
  $66F4,$02,b$01 Keep only bits 0-2.
  $66F6,$01 Keep the X speed bits in #REGb.
  $66F7,$01 Fetch the Y speed.
  $66F8,$01 Rotate #REGa left.
  $66F9,$02,b$01 Keep only bits 3-5.
  $66FB,$01 Combine with the X speed bits.
  $66FC,$01 #REGe=the index into the table.
  $66FD,$02 #REGd=#N$00.
  $66FF,$03 Point #REGhl at the table of angles (#R$683B).
  $6702,$01 Add the index to the start of the table.
  $6703,$01 Fetch the angle from the table.
  $6704,$02 Compare the angle with #N$FF.
  $6706,$02 If the car has no speed then keep the same sprite and jump to
. #R$671D.
  $6708,$04 Jump to #R$6712 if the quadrant is not odd.
  $670C,$02 Negate the angle.
  $670E,$04 Add #N$04 to #REGc.
@ $6712 label=HandlerCar_SetSprite
  $6712,$01 Add the quadrant.
  $6713,$02,b$01 Keep only bits 0-3.
  $6715,$02 Add #N$10 to get the sprite ID.
  $6717,$03 Store the sprite ID.
  $671A,$03 Write the sprite ID to the first byte of the entity, as this is the
. sprite ID that #R$7101 draws.
N $671D Set the colour of the car, which depends on whether it is day or night,
. then draw it.
@ $671D label=HandlerCar_Colour
  $671D,$03 Fetch the colour of the car.
  $6720,$03 Fetch the day/night flag (#R$5E43).
  $6723,$01 Stash #REGbc on the stack.
  $6724,$02 Clear the high byte of the table index.
  $6726,$01 Add the colour to the day/night flag.
  $6727,$01 Keep the index into the table of car attributes in #REGc.
  $6728,$03 Point #REGhl at the table of car attributes (#R$6837).
  $672B,$01 Add the index to the start of the table.
  $672C,$01 Fetch the attribute of the car.
  $672D,$03 Write the attribute to the colour byte of the entity.
  $6730,$03 Call #R$7101 to erase the old car and draw the new one.
  $6733,$03 Call #R$704B to set the attributes of the car.
  $6736,$01 Restore #REGbc from the stack.
  $6737,$03 Put the colour back in the entity.
  $673A,$01 Restore the direction flags from the stack.
  $673B,$04 Set bit 0 of the flags (the car is drawn).
  $673F,$02 Jump to #R$6750.
N $6741 The car is too far away to be seen. If it was drawn then erase it.
@ $6741 label=HandlerCar_TooFar
  $6741,$06 If the car has not been drawn then jump to #R$6750.
  $6747,$04 Reset bit 0 of the flags (the car is no longer drawn).
  $674B,$01 Stash the direction flags on the stack.
  $674C,$03 Call #R$7139 to erase the car.
  $674F,$01 Restore the direction flags from the stack.
N $6750 Steer the car towards the player, starting with the X speed.
@ $6750 label=HandlerCar_SteerX
  $6750,$02 Check if the car is to the left of the player.
  $6752,$03 Fetch the X speed.
  $6755,$02 If the car is to the left of the player then jump to #R$6799.
N $6757 The car is to the right of the player, so it wants to move towards lower
. X.
  $6757,$04 If the car is moving towards higher X then jump to #R$6786 to slow
. it down.
  $675B,$02,b$01 Keep only bits 0-4 (the speed).
@ $675D label=HandlerCar_SpeedUpX
  $675D,$06 If it is the faster car then jump to #R$6791.
  $6763,$02 Compare the speed with the limit of #N$1F.
@ $6765 label=HandlerCar_CheckLimitX
  $6765,$02 If the speed is at the limit then jump to #R$676A.
  $6767,$03 Increase the X speed by one.
N $676A Do the same for the Y speed.
@ $676A label=HandlerCar_SteerY
  $676A,$02 Check if the car is below the player.
  $676C,$03 Fetch the Y speed.
  $676F,$02 If it is then jump to #R$67B2.
N $6771 The car is above the player, so it wants to move towards lower Y.
  $6771,$04 If the car is moving towards higher Y then jump to #R$67A7 to slow
. it down.
  $6775,$02,b$01 Keep only bits 0-4 (the speed).
@ $6777 label=HandlerCar_SpeedUpY
  $6777,$06 If it is the faster car then jump to #R$6795.
  $677D,$02 Compare the speed with the limit of #N$1F.
@ $677F label=HandlerCar_CheckLimitY
  $677F,$02 If the speed is at the limit then jump to #R$67BE.
  $6781,$03 Increase the Y speed by one.
  $6784,$02 Jump to #R$67BE.
N $6786 Slow the car down. When it stops, the direction bit is set so that the
. car speeds up in the opposite direction.
@ $6786 label=HandlerCar_SlowDownX
  $6786,$03 Decrease the X speed by one.
  $6789,$02 If the speed is not zero then jump to #R$676A.
  $678B,$04 Set bit 7 of the X speed.
  $678F,$02 Jump to #R$676A.
N $6791 The limit on the speed of the faster car is lower.
@ $6791 label=HandlerCar_LimitX
  $6791,$02 Compare the speed with the limit of #N$15.
  $6793,$02 Jump to #R$6765.
@ $6795 label=HandlerCar_LimitY
  $6795,$02 Compare the speed with the limit of #N$15.
  $6797,$02 Jump to #R$677F.
N $6799 The car is to the left of the player, so it wants to move towards higher
. X.
@ $6799 label=HandlerCar_SteerLeft
  $6799,$04 If the car is moving towards higher X then jump to #R$675D to speed
. it up.
  $679D,$02,b$01 Keep only bits 0-4 (the speed).
  $679F,$02 If the car is still moving then jump to #R$6786 to slow it down.
  $67A1,$04 Set the X speed to zero.
  $67A5,$02 Jump to #R$676A.
@ $67A7 label=HandlerCar_SlowDownY
  $67A7,$03 Decrease the Y speed by one.
  $67AA,$02 If the speed is not zero then jump to #R$67BE.
  $67AC,$04 Set bit 7 of the Y speed.
  $67B0,$02 Jump to #R$67BE.
N $67B2 The car is below the player, so it wants to move towards higher Y.
@ $67B2 label=HandlerCar_SteerBelow
  $67B2,$04 If the car is moving towards higher Y then jump to #R$6777 to speed
. it up.
  $67B6,$02,b$01 Keep only bits 0-4 (the speed).
  $67B8,$02 If the car is still moving then jump to #R$67A7 to slow it down.
  $67BA,$04 Set the Y speed to zero.
N $67BE Put the state back, then check whether the car has hit an object.
@ $67BE label=HandlerCar_Collisions
  $67BE,$04 Write #N$02 (the car state) to the first byte of the entity.
  $67C2,$05 Return if the car is not drawn.
  $67C7,$03 Point #REGhl at the first object (#R$5E50).
  $67CA,$02 Set the object counter to #N$07.
@ $67CC label=HandlerCar_ObjectLoop
  $67CC,$04 If bit 6 of the object (a place name or collected cup) is set then
. jump to #R$6807 to skip it.
  $67D0,$01 Move on to the X position of the object.
  $67D1,$01 Fetch the X position of the object.
  $67D2,$03 Take the X position of the car away to give the distance.
  $67D5,$03 If the result is positive then jump to #R$67DA.
  $67D8,$02 Negate #REGa.
@ $67DA label=HandlerCar_CheckDistanceX
  $67DA,$04 If the object is #N$0A or more pixels away then jump to #R$6808.
  $67DE,$01 Move on to the Y position of the object.
  $67DF,$01 Fetch the Y position of the object.
  $67E0,$03 Take the Y position of the car away to give the distance.
  $67E3,$03 If the result is positive then jump to #R$67E8.
  $67E6,$02 Negate #REGa.
@ $67E8 label=HandlerCar_CheckDistanceY
  $67E8,$04 If the object is #N$0A or more pixels away then jump to #R$6809.
N $67EC The car has hit the object. Bounce off it, turning the car around in the
. X direction and changing the Y speed by a random amount.
  $67EC,$02 Fetch a random number (from the Z80 refresh register).
  $67EE,$02,b$01 Keep only bits 0-3.
  $67F0,$02,b$01 Set bit 7.
  $67F2,$01 Keep the random change in #REGb.
  $67F3,$03 Fetch the Y speed.
  $67F6,$01 Change the Y speed by the random number.
  $67F7,$03 Store the Y speed.
  $67FA,$03 Fetch the X speed.
  $67FD,$02,b$01 Flip bit 7 to turn the car around in the X direction.
  $67FF,$03 Store the X speed.
  $6802,$03 Call #R$6106 to play a noise.
  $6805,$02 Jump to #R$681A.
N $6807 Move on to the next object.
@ $6807 label=HandlerCar_NextObject
  $6807,$01 Move on to the X position of the object.
@ $6808 label=HandlerCar_NextObject_FromX
  $6808,$01 Move on to the Y position of the object.
@ $6809 label=HandlerCar_NextObject_FromY
  $6809,$01 Move on to the next object.
  $680A,$02 Decrease the object counter by one and loop back to #R$67CC until
. all #N$07 objects have been checked.
N $680C The car has not hit anything. There is a small chance of the X speed
. being changed.
  $680C,$02 Fetch a random number (from the Z80 refresh register).
  $680E,$02,b$01 Keep only bits 0-6.
  $6810,$02 If it is not zero (which is most of the time) then jump to #R$681A.
  $6812,$03 Fetch the X speed.
  $6815,$02,b$01 Flip bits 0-3 to change the X speed.
  $6817,$03 Store the X speed.
N $681A Check if the car has hit the player, which is when the car is less than
. #N$0C pixels away in both directions.
@ $681A label=HandlerCar_PlayerCollision
  $681A,$03 Fetch the X position of the car.
  $681D,$02 #REGa=#REGa - #N$98 (the X position of the player).
  $681F,$03 If the result is positive then jump to #R$6824.
  $6822,$02 Negate #REGa.
@ $6824 label=HandlerCar_PlayerDistanceX
  $6824,$02 Compare the distance with #N$0C.
N $6826 See #POKE(immune_to_cars,Immune To Cars).
  $6826,$01 Return if the car is #N$0C or more pixels away.
  $6827,$03 Fetch the Y position of the car.
  $682A,$02 #REGa=#REGa - #N$68 (the Y position of the player).
  $682C,$03 If the result is positive then jump to #R$6831.
  $682F,$02 Negate #REGa.
@ $6831 label=HandlerCar_PlayerDistanceY
  $6831,$02 Compare the distance with #N$0C.
  $6833,$01 Return if the car is #N$0C or more pixels away.
  $6834,$03 Jump to #R$703E to destroy the player.

b $6837 Car Attributes
@ $6837 label=CarAttributes
D $6837 The attribute for each colour of car. There is one pair of bytes for
. each colour (#N$00 and #N$02), the first byte of which is used in the day and
. the second at night.
B $6837,$04,$02

b $683B Car Direction Table
@ $683B label=CarDirectionTable
D $683B The angle of travel of a car, which is #N$00 when moving vertically and
. #N$04 when moving horizontally. Each row is for a different value of bits 2-4
. of the Y speed and each column is for a different value of bits 2-4 of the X
. speed. The first entry is #N$FF as the car is not moving.
B $683B,$40,$08

c $687B Display Lives
@ $687B label=DisplayPlayerLives
D $687B Draws one car icon in the bottom row of the sidebar for each life
. remaining in #R$5E3D.
E $687B View the equivalent code in;
. #LIST
. { #ATICATAC$A2CE }
. { #COOKIE$7378 }
. { #JETPAC$70A4 }
. { #LUNARJETMAN$894F }
. { #PSSST$7325 }
. LIST#
N $687B #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$68C7,sp=$5E00)
. #SCR$03,$00,$15,$08,$03(display-lives-before)
. | #SIM(start=$68C7,stop=$68CA)
. #SCR$03,$00,$15,$08,$03(display-lives-after) } UDGTABLE# #POPS
  $687B,$05 Return if there are no lives left (#R$5E3D).
  $6880,$01 Set the lives counter to the number of lives (#R$5E3D).
  $6881,$03 #REGhl=#N$BC08 (pixel co-ordinates: #REGh is the Y position and
. #REGl is the X position of the first car).
  $6884,$04 Write #N$00 to #R$5E41.
@ $6888 label=DisplayPlayerLives_Loop
  $6888,$03 Point #REGde at the car sprite (#R$7CD6).
  $688B,$03 Print a car using #R$6891.
  $688E,$02 Decrease the lives counter by one and loop back to #R$6888 until a
. car has been shown for every life.
  $6890,$01 Return.
N $6891 Print the player sprite.
@ $6891 label=DisplayPlayerLives_Print
  $6891,$02 Stash the lives counter and the pixel co-ordinates on the stack.
  $6893,$03 Call #R$70DB to set up the sprite at the co-ordinates in #REGhl.
  $6896,$03 Call #R$714C to draw the sprite.
  $6899,$02 Restore the pixel co-ordinates and the lives counter from the stack.
N $689B Move onto the next life "slot".
  $689B,$04 Add #N$10 to the X position, ready for the next car.
  $689F,$01 Return.

c $68A0 Create Game Window
@ $68A0 label=CreateWindow
D $68A0 Builds the game screen from scratch. The screen and attribute buffers
. are cleared, then the sidebar, the map, the cup count, the lives, the score
. headings and the border of the play area are drawn.
E $68A0 View the equivalent code in;
. #LIST
. { #JETPAC$608A }
. { #LUNARJETMAN$84D8 }
. LIST#
N $68A0 #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$68A0,clear=1,sp=$5E00)
. #SCR$01(create-window-before)
. | #SIM(start=$68A0,stop=$5F29)
. #SCR$01(create-window-after) } UDGTABLE# #POPS
  $68A0,$03 Point #REGhl at the radar blip records (#R$5E68).
  $68A3,$03 #REGbc=#N($0C00, $04, $04) (#REGb is the counter for the #N$0C
. bytes and #REGc is #N$00).
@ $68A6 label=CreateWindow_ClearBlips
  $68A6,$01 Clear a byte of the radar blip records.
  $68A7,$01 Increment #REGhl by one.
  $68A8,$02 Decrease the byte counter by one and loop back to #R$68A6 until all
. #N$0C bytes have been cleared.
  $68AA,$06 Write #N$FFFF to #R$5E34 (so the terrain dots are drawn afresh).
  $68B0,$03 Point #REGhl at the first terrain dot (#R$65FD).
  $68B3,$02 Set the dot counter to #N$10.
@ $68B5 label=CreateWindow_Terrain
  $68B5,$02 Reset bit 0 of the byte #REGhl is pointing to (the dot is not
. drawn).
  $68B7,$02 Move on to the next terrain dot.
  $68B9,$02 Decrease the dot counter by one and loop back to #R$68B5 until all
. #N$10 dots are marked as not drawn.
  $68BB,$03 Call #R$7200 to reset the attribute buffer.
  $68BE,$03 Call #R$69BC to draw the sidebar.
  $68C1,$03 Call #R$6949 to plot the map points.
  $68C4,$03 Call #R$646C to display the cups collected.
  $68C7,$03 Call #R$687B to display the lives.
  $68CA,$03 Call #R$6CDE to display the miles and time.
N $68CD Draw the border of the play area, by setting a row of attributes along
. the top and bottom and a column along each side.
  $68CD,$03 #REGhl=#N$5808 (the attribute address of the top left).
  $68D0,$03 #REGbc=#N($1801, $04, $04) (#N$18 across and #N$01 down).
  $68D3,$01 Stash #REGbc on the stack.
  $68D4,$03 Set the attributes of the top row using #R$6900.
  $68D7,$03 #REGhl=#N$5AE8 (the attribute address of the bottom left).
  $68DA,$01 Restore #REGbc from the stack.
  $68DB,$03 Set the attributes of the bottom row using #R$6900.
  $68DE,$03 #REGhl=#N$5828 (the attribute address of the left side).
  $68E1,$03 #REGbc=#N($0116, $04, $04) (#N$01 across and #N$16 down).
  $68E4,$01 Stash #REGbc on the stack.
  $68E5,$03 Stash the size of the side on the stack.
  $68E8,$01 Restore #REGbc from the stack.
  $68E9,$03 #REGhl=#N$583F (the attribute address of the right side).
  $68EC,$03 Set the attributes of the right side using #R$6900.
N $68EF Print the "SCORE" and "HI-SCORE" headings and the scores.
  $68EF,$03 #REGhl=#N($0050, $04, $04) (pixel co-ordinates: #REGh is the Y
. position and #REGl is the X position).
  $68F2,$03 Point #REGde at the "SCORE" and "HI-SCORE" headings (#R$6031).
  $68F5,$03 Print the headings using #R$6518.
  $68F8,$03 Call #R$6CB6 to print the score.
  $68FB,$03 Call #R$6CBE to print the high score.
  $68FE,$02 Jump to #R$6919.

c $6900 Set PlayArea Attributes
@ $6900 label=AttributesPlayArea
D $6900 Fills a block of the attribute buffer with #N$76 (#COLOUR$76), which
. forms part of the border of the play area.
R $6900 B Width of the block (in cells)
R $6900 C Height of the block (in rows)
R $6900 HL Attribute address of the top left of the block
  $6900,$01 Keep the width of the block in #REGe.
@ $6901 label=AttributesPlayArea_Row
  $6901,$01 Set the cell counter to the width of the block.
  $6902,$01 Stash the address of the start of the row on the stack.
@ $6903 label=AttributesPlayArea_Column
  $6903,$02 Set the attribute of the cell to #N$76.
  $6905,$01 Increment #REGhl by one.
  $6906,$02 Decrease the cell counter by one and loop back to #R$6903 until the
. row is done.
  $6908,$01 Restore the address of the start of the row from the stack.
  $6909,$03 Call #R$6910 to move down a row.
  $690C,$01 Decrease the row counter by one.
  $690D,$02 Jump back to #R$6901 until all of the rows have been done.
  $690F,$01 Return.

c $6910 Move Down One Row
@ $6910 label=MoveDownOneRow
D $6910 Adds #N$20 to an address, which moves it down by one character row in
. the attribute buffer or the screen buffer (for as long as it stays within the
. same third of the screen).
R $6910 HL Current address
R $6910 O:HL Address one row down
  $6910,$04 #REGl=#REGl + #N$20 (one row).
  $6914,$04 #REGh=#REGh + #N$00 (but include the carry from above).
  $6918,$01 Return.

c $6919 Display Night Driver Text
@ $6919 label=DisplayNightDriver
D $6919 If it is night, shows "NIGHT DRIVER" for a short time and then removes
. it again.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$617F,stop=$617E)
. #SIM(start=$5F26,stop=$6919)
. #SCR$03,$08,$06,$18,$05(night-driver-before)
. | #SIM(start=$6919,stop=$6927)
. #SCR$03,$08,$06,$18,$05(night-driver-after) } UDGTABLE# #POPS
  $6919,$05 Return if #R$5E43 is zero (i.e. it is "day").
N $691E Else it is night so handle the interlude to display "Night Driver".
  $691E,$03 #REGhl=#N$4070 (pixel co-ordinates: #REGh is the Y position and
. #REGl is the X position).
  $6921,$03 Point #REGde at the "NIGHT DRIVER" text (#R$693C).
  $6924,$03 Print the text using #R$6518.
N $6927 Display the text for a short time.
  $6927,$02 Set the delay count to #N$04.
  $6929,$03 Wait using #R$6386.
N $692C Remove the messaging.
  $692C,$03 #REGhl=#N$4070 (pixel co-ordinates: #REGh is the Y position and
. #REGl is the X position).
  $692F,$01 Stash the pixel co-ordinates on the stack.
  $6930,$03 Convert them to a screen address using #R$6F10.
  $6933,$02 Set the attribute to #N$00, which hides the text.
  $6935,$01 Keep the attribute in the shadow #REGaf register.
  $6936,$03 Point #REGde at the blank text (#R$6AE5).
  $6939,$03 Jump to #R$651F to print the blank text.

t $693C Messaging: Night Driver
@ $693C label=NightDriver_Text
D $693C The attribute byte, followed by the text. The last character has bit 7
. set.
  $693C,$0D,h$01,$0B:$01 "NIGHT DRIVER" (#COLOUR(#PEEK(#PC)) is the attribute).

c $6949 Plot Map Points
@ $6949 label=PlotMapPoints
D $6949 Plots a dot on the map in the sidebar for every entry in the map points
. table at #R$7811, except place names and collected cups (which are marked with
. #N$60). One pixel on the map is #N$80 map units.
N $6949 #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$68C1,clear=1,sp=$5E00)
. #SCR$03,$00,$05,$08,$05(plot-map-before)
. | #SIM(start=$68C1,stop=$68C4)
. #SCR$03,$00,$05,$08,$05(plot-map-after) } UDGTABLE# #POPS
  $6949,$03 Point #REGbc at the map points (#R$7811).
@ $694C label=PlotMapPoints_Loop
  $694C,$03 #REGhl=#N$4708 (pixel co-ordinates of the bottom left of the map:
. #REGh is the Y position and #REGl is the X position).
N $694F Handle the X co-ordinate.
  $694F,$01 Fetch the X position of the map point.
  $6950,$01 Increment the map pointer in #REGbc by one.
N $6951 Scale the X co-ordinate for the smaller map display output.
  $6951,$04 Divide the X position by #N$04 to scale it for the map.
  $6955,$01 Keep the scaled X position in #REGe.
N $6956 Handle the Y co-ordinate.
  $6956,$01 Fetch the Y position of the map point.
  $6957,$01 Increment the map pointer in #REGbc by one.
N $6958 Scale the Y co-ordinate for the smaller map display output.
  $6958,$06 Divide the Y position by #N$08 to scale it for the map.
  $695E,$01 Keep the scaled Y position in #REGd.
N $695F Calculate the pixel co-ordinates of our currently processed map point.
  $695F,$03 Take the scaled Y position away from the Y pixel position, as the
. map counts up from the bottom.
  $6962,$03 Add the scaled X position to the X pixel position.
N $6965 Handle the map point "type" - place names are excluded.
  $6965,$01 Fetch the sprite ID of the map point.
  $6966,$01 Increment the map pointer in #REGbc by one. Now pointing to the next
. record.
  $6967,$01 Stash the pointer to the next map point on the stack.
  $6968,$03 #REGbc=#N($0101, $04, $04) (a single pixel, used in #R$6998).
N $696B Skip place names - they don't show a marker on the map.
  $696B,$04 If bit 6 is set then this is a place name so skip and jump to
. #R$6976.
  $696F,$04 If #REGa is #N$60 (a collected cup), jump to #R$6976.
  $6973,$03 Plot the point using #R$6998.
N $6976 Check if finished. The stack contains the start of the next record, or
. the first byte past the end of the map points.
@ $6976 label=PlotMapPoints_Continue
  $6976,$01 Restore the pointer to the next map point from the stack.
  $6977,$03 Point #REGhl at the end of the map points (#R$7CD6, one byte past
. the end of #R$7811).
  $697A,$01 Reset the carry flag.
  $697B,$02 Compare the map pointer with the end of the map points.
  $697D,$02 If the end of the map points has not been reached then jump to
. #R$694C.
  $697F,$01 Return.

c $6980 Handler: Terrain Dots
@ $6980 label=HandlerTerrainDots
D $6980 Erases a terrain dot from where it was drawn. The position is worked out
. from the player position that was saved in #R$5E34 when the dots were last
. updated.
R $6980 IX One of the #N$10 #R$65FD entities
  $6980,$04 Reset bit 0 of the given Terrain Dot entity (it is no longer drawn).
  $6984,$03 Fetch the player position used last time (#R$5E34).
  $6987,$05 #REGl=player X - terrain dot X.
  $698C,$05 #REGh=player Y - terrain dot Y.

c $6991 Clear Pixels
@ $6991 label=ClearPixels
D $6991 Clears a block of pixels. Writes the opcode operand for #N$86 (which
. makes #R$69AE reset a bit) to #R$69A6(#N$69A7), then continues at #R$699D.
R $6991 B Height of the block in pixels
R $6991 C Width of the block in pixels
R $6991 HL Pixel co-ordinates of the bottom left of the block (#REGh is the Y position and #REGl is the X position)
  $6991,$05 Write #N$86 to #R$69A6(#N$69A7).
  $6996,$02 Jump to #R$699D.

c $6998 Set Pixels
@ $6998 label=SetPixels
D $6998 Sets a block of pixels. Writes the opcode operand for #N$C6 (which makes
. #R$69AE set a bit) to #R$69A6(#N$69A7), then continues at #R$699D.
R $6998 B Height of the block in pixels
R $6998 C Width of the block in pixels
R $6998 HL Pixel co-ordinates of the bottom left of the block (#REGh is the Y position and #REGl is the X position)
  $6998,$05 Write #N$C6 to #R$69A6(#N$69A7).

c $699D Plot Pixels
@ $699D label=PlotPixels
D $699D Sets or clears a block of pixels, going up from the bottom row and
. across from the left column. Which of the two depends on the operands that
. have been written by #R$6991 or #R$6998.
R $699D B Height of the block in pixels
R $699D C Width of the block in pixels
R $699D HL Pixel co-ordinates of the bottom left of the block (#REGh is the Y position and #REGl is the X position)
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
  $69A6,$02,b$01 Set bits 1-2, 6-7 (this operand is modified).
  $69A8,$03 Store #REGa as the opcode of the instruction at #R$69AE(#N$69AF).
  $69AB,$03 Call #R$6F10.
@ $69AE label=PlotPixels_Column
  $69AE,$02 Set (or reset) the bit of the byte at #REGhl for this pixel.
  $69B0,$03 Call #R$6ECB to move up one pixel.
  $69B3,$02 Decrease the height counter by one and loop back to #R$69AE until
. the whole column has been set (or cleared).
  $69B5,$02 Restore #REGhl and #REGbc from the stack.
  $69B7,$01 Move on to the next pixel column.
  $69B8,$03 Decrease the width counter by one and loop back to #R$699D until all
. of the columns have been done.
  $69BB,$01 Return.

c $69BC Draw HUD Panel
@ $69BC label=DrawHUDPanel
D $69BC Draws the sidebar (the leftmost #N$08 columns of the screen) from the
. tile layout at #R$7691 and the attributes at #R$7751. Each tile is printed
. with #R$6C96 while the character set pointer refers to the tiles at #R$74B1.
E $69BC View the equivalent code in;
. #LIST
. { #LUNARJETMAN$8BBB }
. LIST#
N $69BC #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$68BE,clear=1,sp=$5E00)
. #SCR$02,$00,$00,$08,$18(draw-sidebar-before)
. | #SIM(start=$68BE,stop=$68C1)
. #SCR$02,$00,$00,$08,$18(draw-sidebar-after) } UDGTABLE# #POPS
  $69BC,$04 Stash #SKOOLKID$5C36(CHARS) on the stack.
  $69C0,$06 Write #R$74B1 to #SKOOLKID$5C36(CHARS).
  $69C6,$03 Point #REGhl at the tile layout of the sidebar (#R$7691).
  $69C9,$03 Point #REGde at the attributes of the sidebar (#R$7751).
  $69CC,$01 Switch to the shadow registers.
  $69CD,$03 Point #REGhl' at the screen buffer (#N$4000).
  $69D0,$03 Point #REGde' at the attribute buffer (#N$5800).
  $69D3,$02 Set the row counter to #N$18, the height of the sidebar.
  $69D5,$05 Write #N$08 (width of the sidebar) to #R$5E2C.
@ $69DA label=DrawHUDPanel_Loop
  $69DA,$04 Set the tile counter to the width of the sidebar (#R$5E2C).
  $69DE,$02 Stash the buffer addresses of the start of this row on the stack.
@ $69E0 label=DrawHUDPanel_LineLoop
  $69E0,$01 Switch back to the normal registers.
  $69E1,$01 Fetch the tile from the sidebar layout.
  $69E2,$01 Move on to the next tile.
  $69E3,$01 Switch to the shadow registers.
N $69E4 Now using the screen data held by the shadow registers.
  $69E4,$03 Print the tile using #R$6C96.
  $69E7,$01 Switch back to the normal registers.
  $69E8,$01 Fetch the attribute of the tile from the sidebar attributes.
  $69E9,$01 Move on to the next attribute.
  $69EA,$01 Switch to the shadow registers.
  $69EB,$01 Write the sidebar attribute data to the attribute buffer.
  $69EC,$01 Increment the attribute buffer pointer by one.
  $69ED,$02 Decrease the tile counter by one and loop back to #R$69E0 until the
. whole row has been drawn.
N $69EF Restore the attribute buffer address for the start of this line.
  $69EF,$01 Restore #REGhl' from the stack.
  $69F0,$03 Call #R$6910 to move down a row.
  $69F3,$01 Exchange #REGde' and #REGhl' so that #REGde' holds the attribute
. address for the next row (#REGhl' is overwritten below).
N $69F4 Restore the screen buffer address for the start of this line.
  $69F4,$01 Restore #REGhl' from the stack.
  $69F5,$03 Call #R$6910 to move down a row.
N $69F8 Account for the Spectrum screen layout in memory.
  $69F8,$01 Fetch the low byte of the screen buffer address.
  $69F9,$02,b$01 Keep only bits 5-7.
  $69FB,$02 Jump to #R$6A01 if we're not crossing a screen section.
  $69FD,$04 Else #REGh'=#REGh'+#N$07.
@ $6A01 label=DrawHUDPanel_Skip
  $6A01,$01 Decrease the row counter by one.
  $6A02,$02 Jump back to #R$69DA until all of the rows have been drawn.
N $6A04 All done! Finish by reverting the change to #SKOOLKID$5C36(CHARS) and
. returning.
  $6A04,$04 Restore #SKOOLKID$3D00(CHARSET) from the stack and write it back to
. #SKOOLKID$5C36(CHARS).
  $6A08,$01 Return.

c $6A09 Initialise Entities
@ $6A09 label=InitialiseEntities
D $6A09 Sets up the player's car and the two opponent cars (the three entities
. at #R$5E80) from the template at #R$6A15.
E $6A09 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$A3DD }
. LIST#
  $6A09,$03 Point #REGhl at the entity template (#R$6A15).
  $6A0C,$03 Point #REGde at the entities (#R$5E80).
  $6A0F,$03 #REGbc=#N($0024, $04, $04) (#N$03 entities of #N$0C bytes each).
  $6A12,$02 Copy the template to the entities.
  $6A14,$01 Return.

b $6A15 Entity Template
@ $6A15 label=EntityTemplate
D $6A15 The initial values copied to the entities at #R$5E80 by #R$6A09. The
. first byte of each entity is the state used by #R$6009: #N$01 for the player's
. car driving and #N$02 for an opponent car driving.
B $6A15,$0C,$0C Player's car.
B $6A21,$0C,$0C First opponent car.
B $6A2D,$0C,$0C Second opponent car.

c $6A39 Draw Player
@ $6A39 label=DrawPlayer
D $6A39 Draws the car in the centre of the play area, using the frame from
. #R$7F24 which matches the current direction.
N $6A39 #PUSHS #UDGTABLE(default,centre,centre,centre)
. { =h Before | =h After #R$6A39 | =h After #R$7064 }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SIM(start=$6010,stop=$6AB9,sp=$5E00)
. #SCR$04,$11,$0A,$06,$05(draw-player-before)
. | #SIM(start=$6AB9,stop=$6ABC)
. #SCR$04,$11,$0A,$06,$05(draw-player-drawn)
. | #SIM(start=$6ABC,stop=$6ACB)
. #SCR$04,$11,$0A,$06,$05(draw-player-coloured) } UDGTABLE# #POPS
  $6A39,$03 Fetch the direction the car is facing (#R$5E10).
  $6A3C,$03 #REGbc=#N($0020, $04, $04) (half of a step between two of the #N$10
. directions, so the direction is rounded to the nearest).
  $6A3F,$01 #REGhl=#REGhl + #REGbc.
  $6A40,$01 #REGa=#REGh.
  $6A41,$02,b$01 Keep only bits 0-1.
N $6A43 Shift the top two bits of #REGl into the bottom of #REGa to make a
. direction between #N$00 and #N$0F.
  $6A43,$06 Rotate #REGl left and shift its top bit into #REGa.
  $6A49,$02 Double #REGa to use it as an index into a table of words.
  $6A4B,$03 Point #REGhl at the table of player sprites (#R$7F24).
  $6A4E,$03 Create an offset in #REGbc.
  $6A51,$01 #REGhl=#R$7F24 + offset.
  $6A52,$03 Fetch the pointer to the sprite of the player for this direction
. into #REGde.
N $6A55 The player is drawn statically in the centre of the play area.
  $6A55,$03 Set the screen address to draw the player at, the centre of the play
. area (#N$4F93).
N $6A58 The player sprite is #N$02 bytes in width.
  $6A58,$05 Write #N$02 to #R$5E2C.
  $6A5D,$01 Fetch the height of the sprite.
  $6A5E,$01 Increment #REGde by one to point to the sprite data.
  $6A5F,$01 Keep the height of the sprite in #REGc as the row counter.
@ $6A60 label=DrawPlayer_NextRow
  $6A60,$04 Set the byte counter to the width of the sprite (#R$5E2C).
  $6A64,$01 Stash the screen address of the start of the row on the stack.
@ $6A65 label=DrawPlayer_NextCol
  $6A65,$02 Copy a byte from #REGde (the player sprite data) to #REGhl (the
. screen position).
  $6A67,$01 Move on to the next byte of sprite data.
  $6A68,$01 Move on to the next screen byte.
  $6A69,$02 Decrease the byte counter by one and loop back to #R$6A65 until the
. row has been drawn.
  $6A6B,$01 Restore the screen address of the start of the row from the stack.
  $6A6C,$03 Call #R$6ECB to move up one pixel line.
  $6A6F,$03 Decrease the row counter by one and jump to #R$6A60 until all of the
. rows have been drawn.
  $6A72,$01 Return.

c $6A73 Move On To Next Entity
@ $6A73 label=NextEntity
D $6A73 The return address for every entity handler (see #R$6010). Moves on to
. the next entity or, when all of the entities have been handled, plays the
. engine sound and then waits while the game is paused.
  $6A73,$03 Set the size of an entity (#N($000C, $04, $04)).
  $6A76,$02 #REGix=#REGix + #REGde (point to the next entity).
  $6A78,$03 Copy the entity pointer into #REGhl (using the stack to do so).
  $6A7B,$03 Point #REGbc at the end of the entities (#R$5EA4, the first byte
. after the last entity).
  $6A7E,$01 Reset the carry flag.
  $6A7F,$02 Compare the entity pointer with the end of the entities.
  $6A81,$03 Jump to #R$6010 if there is another entity to handle.
  $6A84,$03 Call #R$6158 to play the engine sound.

c $6A87 Pause Game
@ $6A87 label=Pause_Loop
D $6A87 Waits for as long as "SHIFT" is held down, then counts the frame and
. starts the main loop again.
  $6A87,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $6A8D,$04 Is "SHIFT" being pressed? If it is then jump back to #R$6A87.
  $6A91,$03 Fetch the game timer from #R$5E29.
  $6A94,$01 Add one to the game timer, as a frame has passed.
  $6A95,$03 Write the new game timer back to #R$5E29.
  $6A98,$03 Jump to #R$6009 to handle the entities again.

c $6A9B Handler: Player
@ $6A9B label=HandlerPlayer
D $6A9B Handles the player's car while it is being driven (entity state #N$01).
. Draws the objects and the car, then updates the radar, the terrain dots, the
. sidebar and the sounds.
R $6A9B IX The player entity (#R$5E80)
  $6A9B,$02 Stash #REGix on the stack.
N $6A9D Reset the current place so that it can be set again if a place is in
. view.
  $6A9D,$05 Write #N$FF to #R$5E39.
  $6AA2,$03 Call #R$6B47 to draw the objects that are in view.
  $6AA5,$03 Call #R$6AF5 to remove the objects that are no longer in view.
  $6AA8,$03 Call #R$6D12 to update the miles, the speed, the position, the
. steering and the fuel.
  $6AAB,$03 Call #R$6557 to flash the player marker on the map.
  $6AAE,$03 Call #R$625C to update the radar.
  $6AB1,$03 Call #R$6588 to update the terrain dots.
  $6AB4,$03 Call #R$611B to make the cup and refuel sounds.
  $6AB7,$02 Restore #REGix from the stack.
N $6AB9 Draw and colourise the player sprite.
  $6AB9,$03 Call #R$6A39.
  $6ABC,$03 Point #REGhl at the attribute buffer location of the player
. (#N$5993).
  $6ABF,$03 #REGbc=#N($0202, $04, $04) (height * width in bytes).
N $6AC2 Merge the player sprite colour in with the current background colour.
  $6AC2,$03 Fetch the background attribute (#R$5E44).
  $6AC5,$02,b$01 Set bit 1 (RED).
  $6AC7,$01 Keep the attribute to colour the car with in #REGd.
  $6AC8,$03 Colour the car using #R$7064.
N $6ACB Handles updating the dashboard values.
  $6ACB,$03 Call #R$64C7 to update the time.
  $6ACE,$03 Call #R$6CDE to display the miles and the time.
N $6AD1 Remove the place name from the screen when no place is in view any more.
  $6AD1,$03 Fetch the place name flag (#R$5E39).
  $6AD4,$02 Return if #R$5E39 is zero (the name has already been removed).
  $6AD6,$01 Add one, so that #N$FF becomes #N$00.
  $6AD7,$01 Return if #REGa is not zero (a place is in view; it is only zero
. here when the value was #N$FF, see #R$6A9D).
  $6AD8,$03 Clear the place name flag (#R$5E39) so that this is only done once.
  $6ADB,$03 #REGhl=#N$B868 (pixel co-ordinates).
  $6ADE,$03 Point #REGde at the blank text (#R$6AE4).
  $6AE1,$03 Jump to #R$6518 to overwrite the place name with spaces.

t $6AE4 Messaging: Blank Place Name
@ $6AE4 label=Blank_Text_Attribute
@ $6AE5 label=Blank_Text
D $6AE4 Used to overwrite the place name on the screen. The first byte is the
. attribute, followed by the spaces to print.
B $6AE4,$01 Attribute: #N$76 (bright yellow ink on yellow paper).
  $6AE5,$10,$0F:$01 Contains #N$0F spaces, the last with bit 7 set.

c $6AF5 Handler: Objects
@ $6AF5 label=HandlerObjects
D $6AF5 Looks after the objects (#N$07 slots from #R$5E50). #R$6B47 sets bit 7
. of the sprite ID of each object that is in view, so for each slot this clears
. that bit for objects still in view, erases the objects which are no longer in
. view and frees their slots. Empty slots just waste a little time.
  $6AF5,$03 Point #REGhl at the first object (#R$5E50).
  $6AF8,$02 Set the object counter to #N$07.
@ $6AFA label=CheckObjectActive
  $6AFA,$04 If bit 7 is not set on the current objects sprite ID value, jump to
. #R$6B12.
  $6AFE,$02 Reset bit 7 of the sprite ID.
  $6B00,$02 Jump to #R$6B0C.
N $6B02 An empty slot; spend some time so that the frame takes about as long as
. it does for a used one.
@ $6B02 label=HandlerObjects_EmptySlot
  $6B02,$01 Stash #REGhl on the stack.
N $6B03 See #POKE(make_the_game_go_faster,Make The Game Go Faster).
  $6B03,$03 Set the delay counter to #N($0118, $04, $04).
@ $6B06 label=ObjectPauseLoop
  $6B06,$01 Decrease the delay counter by one.
  $6B07,$04 Loop back to #R$6B06 until the delay counter is zero.
  $6B0B,$01 Restore #REGhl from the stack.
@ $6B0C label=NextObject
  $6B0C,$02 Move on to the Y position of the object.
@ $6B0E label=NextObject_2
  $6B0E,$01 Move on to the next object.
  $6B0F,$02 Decrease the object counter by one and loop back to #R$6AFA until
. all #N$07 objects have been checked.
  $6B11,$01 Return.

c $6B12 Erase Object
@ $6B12 label=EraseObject
D $6B12 Erases an object that is no longer in view and empties its slot. An
. empty slot is handled by the pause loop at #R$6B02 instead.
R $6B12 HL The object slot
R $6B12 B Number of object slots left to handle
  $6B12,$01 Fetch the sprite ID of the object.
  $6B13,$03 If #REGa is zero then the slot is empty, so jump to #R$6B02.
  $6B16,$02 Stash #REGbc and #REGhl on the stack.
  $6B18,$03 Point #REGix at the object (using the stack to do so).
  $6B1B,$03 Copy the position and sprite ID of the object using #R$71ED.
  $6B1E,$03 Call #R$7139 to erase the object from the screen.
  $6B21,$01 Restore #REGhl from the stack.
  $6B22,$01 Set #REGa to #N$00, ready to empty the slot.
  $6B23,$01 Empty the slot by clearing the sprite ID of the object.
  $6B24,$01 Increment #REGhl by one.
  $6B25,$01 Write #N$00 to the next byte of the object.
  $6B26,$01 Increment #REGhl by one.
  $6B27,$01 Write #N$00 to the final byte of the object.
  $6B28,$01 Restore #REGbc from the stack.
  $6B29,$02 Jump to #R$6B0E.

c $6B2B Scale Value
@ $6B2B label=ScaleValue
D $6B2B Converts a map position held in a single byte into map units, by
. shifting #REGd right through #REGe so that #REGde is #REGd * #N$0100 shifted
. right by a fixed number of bits. #R$6B2B multiplies by #N$40, #R$6B30
. multiplies by #N$20 (used for the X position of a map point) and #R$6B3D
. multiplies by #N$10 (used for the Y position of a map point).
R $6B2B D Value to scale
R $6B2B O:DE Scaled value
  $6B2B,$01 Stash #REGbc on the stack.
  $6B2C,$02 Set the shift counter to #N$02.
  $6B2E,$02 Jump to #R$6B33.
N $6B30 Multiply by #N$20.
@ $6B30 label=ScaleValue_DivideByEight
  $6B30,$01 Stash #REGbc on the stack.
  $6B31,$02 Set the shift counter to #N$03.
@ $6B33 label=ScaleValue_Shift
  $6B33,$02 Clear the low byte of the scaled value.
@ $6B35 label=ScaleValue_Loop
  $6B35,$02 Shift #REGd right, moving bit 0 into the carry flag.
  $6B37,$02 Rotate the carry flag into #REGe.
  $6B39,$02 Decrease the shift counter by one and loop back to #R$6B35 until all
. of the shifts have been done.
  $6B3B,$01 Restore #REGbc from the stack.
  $6B3C,$01 Return.
N $6B3D Multiply by #N$10.
@ $6B3D label=ScaleValue_DivideBySixteen
  $6B3D,$01 Stash #REGbc on the stack.
  $6B3E,$02 Set the shift counter to #N$04.
  $6B40,$02 Jump to #R$6B33.

c $6B42 Set Day Object Attributes Pointer
@ $6B42 label=SetDayObjectAttributes
D $6B42 Points #REGhl at the attributes for the objects in the daytime, then
. rejoins #R$6B47 where the sprite ID is read.
  $6B42,$03 Point #REGhl at the day time object attributes (#R$6BE6).
  $6B45,$02 Jump to #R$6B7F.

c $6B47 Draw Objects
@ $6B47 label=DrawObjects
D $6B47 Goes through the map points (#R$7811), from the one that #R$5E19 points
. to, and draws each one that is in view of the player's car. The map points are
. in order of their X position, so it stops at the first one which is more than
. #N$60 map units away horizontally. Map points which are too far away
. vertically are skipped.
N $6B47 #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #POKES$5E05,$C0;$5E06,$0C;$5E08,$98;$5E09,$05
. #SIM(start=$6BFE,stop=$6C29,sp=$5E00)
. #SIM(start=$6010,stop=$6AA2,sp=$5E00)
. #SCR$02,$08,$00,$18,$18(draw-objects-before)
. | #SIM(start=$6AA2,stop=$6AA5)
. #SCR$02,$08,$00,$18,$18(draw-objects-after) } UDGTABLE# #POPS
  $6B47,$04 Fetch the first map point that might be in view (#R$5E19).
N $6B4B Handle the next map point. #REGa' is used to hold flags which say which
. side of the player's car the map point is on; bit 1 is set when it is to the
. right and bit 0 is set when it is higher up the map.
@ $6B4B label=DrawObjects_Next
  $6B4B,$01 Prepare to clear the direction flags.
  $6B4C,$01 Exchange #REGa with #REGa' to clear the flags.
  $6B4D,$01 Fetch the X position of the map point.
  $6B4E,$01 Move on to the Y position of the map point.
  $6B4F,$01 Keep the X position in #REGd.
  $6B50,$03 Call #R$6B30 to convert it to map units in #REGde.
  $6B53,$03 Fetch the player's X position on the map (#R$5E05).
  $6B56,$03 #REGhl=#REGhl - #REGde (the horizontal distance to the map point).
  $6B59,$02 Jump to #R$6B62 if the map point is not to the right of the player's
. car.
  $6B5B,$03 Call #R$6BF6 to make the distance positive.
  $6B5E,$01 Switch to the flags.
  $6B5F,$02,b$01 Flip bit 1 (the map point is to the right).
  $6B61,$01 Switch back.
@ $6B62 label=DrawObjects_CheckRangeX
  $6B62,$01 Stash the distance on the stack.
  $6B63,$01 Keep the distance in #REGde.
  $6B64,$03 Set the furthest distance in view, #N($0060, $04, $04).
  $6B67,$03 Take the distance away from the furthest distance in view.
  $6B6A,$01 Restore the distance (#REGhl) from the stack.
  $6B6B,$01 Return if the map point is more than #N$60 units away horizontally.
  $6B6C,$01 Fetch the horizontal distance (the low byte).
  $6B6D,$03 Store the horizontal distance in #R$5E17.
  $6B70,$01 Fetch the Y position of the map point.
  $6B71,$01 Move on to the sprite ID of the map point.
  $6B72,$01 Keep the Y position in #REGd.
  $6B73,$03 Call #R$6B3D to convert it to map units in #REGde.
N $6B76 Pick the attributes for the objects; they depend on the time of day.
  $6B76,$03 Fetch the day/night flag (#R$5E43).
  $6B79,$03 If it is day time then jump to #R$6B42.
  $6B7C,$03 Point #REGhl at the night time object attributes (#R$6BD6).
@ $6B7F label=DrawObjects_Sprite
  $6B7F,$01 Fetch the sprite ID of the map point.
  $6B80,$01 Move on to the next map point.
  $6B81,$03 Store the sprite ID in #R$5E1F.
N $6B84 Cups, place names and collected cups all use the first attribute.
  $6B84,$04 Jump to #R$6BD3 if this is a cup (#N$20).
  $6B88,$04 Jump to #R$6BD3 if this is a place name or a collected cup (#N$40 or
. more).
  $6B8C,$06 Add the sprite ID to the pointer to find the attribute for this
. sprite.
@ $6B92 label=DrawObjects_Attribute
  $6B92,$03 Fetch the background attribute (#R$5E44).
  $6B95,$01 Merge the colour of the object with the background.
  $6B96,$03 Store the attribute of the object in #R$5E42.
  $6B99,$03 Fetch the player's Y position on the map (#R$5E08).
  $6B9C,$03 #REGhl=#REGhl - #REGde (the vertical distance to the map point).
  $6B9F,$02 Jump to #R$6BA8 if the map point is not higher up the map than the
. player's car.
  $6BA1,$03 Call #R$6BF6 to make the distance positive.
  $6BA4,$01 Switch to the flags.
  $6BA5,$02,b$01 Flip bit 0 (the map point is higher up the map).
  $6BA7,$01 Switch back.
@ $6BA8 label=DrawObjects_CheckRangeY
  $6BA8,$01 Stash the distance on the stack.
  $6BA9,$01 Keep the distance in #REGde.
  $6BAA,$03 Set the furthest distance in view, #N($0060, $04, $04).
  $6BAD,$03 Take the distance away from the furthest distance in view.
  $6BB0,$01 Restore the distance (#REGhl) from the stack.
  $6BB1,$02 Jump to #R$6B4B if the map point is more than #N$60 units away
. vertically.
  $6BB3,$01 Fetch the vertical distance (the low byte).
  $6BB4,$03 Store the vertical distance in #R$5E18.
N $6BB7 Use the flags to look up the quadrant of the map point.
  $6BB7,$01 Switch to the direction flags.
  $6BB8,$01 Use the direction flags as the index into the quadrant table.
  $6BB9,$02 Clear the high byte of the index.
  $6BBB,$03 Point #REGhl at the quadrant table (#R$6BCF).
  $6BBE,$01 Add the index to the start of the table.
  $6BBF,$01 Fetch the quadrant.
  $6BC0,$03 Store the quadrant in #R$5E13.
  $6BC3,$04 Store the map point pointer in #R$5E3A.
  $6BC7,$01 Stash #REGbc on the stack.
  $6BC8,$03 Call #R$6F3C to place the object on the screen.
  $6BCB,$01 Restore #REGbc from the stack.
  $6BCC,$03 Jump to #R$6B4B.
N $6BCF The quadrant for each combination of the flags in #REGa'. Bit 1 of the
. quadrant is set when the object is to the left of the player's car.
@ $6BCF label=DrawObjects_QuadrantTable
B $6BCF,$04
N $6BD3 Use the first attribute for cups, place names and collected cups.
@ $6BD3 label=DrawObjects_FirstAttribute
  $6BD3,$01 #REGa=#N$00 (this has no effect, as #REGa is loaded again below).
  $6BD4,$02 Jump to #R$6B92.

b $6BD6 Night Object Attributes
@ $6BD6 label=NightObjectAttributes
D $6BD6 The colour of each object at night, indexed by sprite ID. It is merged
. with the background attribute at #R$5E44.
B $6BD6,$10

b $6BE6 Day Object Attributes
@ $6BE6 label=DayObjectAttributes
D $6BE6 The colour of each object in the daytime, indexed by sprite ID. It is
. merged with the background attribute at #R$5E44.
B $6BE6,$10

c $6BF6 Negate HL
@ $6BF6 label=NegateHL
D $6BF6 Makes #REGhl negative.
E $6BF6 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D01B }
. { #MARTIANOIDS$B4B1 }
. { #NIGHTSHADE$E0DD }
. { #UNDERWURLDE$ADD6 }
. LIST#
R $6BF6 HL The word
R $6BF6 O:HL The negative of the word
N $6BF6 Invert both bytes, then add one.
  $6BF6,$03 Invert the low byte.
  $6BF9,$03 Invert the high byte.
  $6BFC,$01 Increment #REGhl by one.
  $6BFD,$01 Return.

c $6BFE Find First Object
@ $6BFE label=FindFirstObject
D $6BFE Finds the first map point whose X position is not less than the player's
. X position minus #N$60, and writes its address to #R$5E19. If there is not one
. then the pointer is reset to the start of the map points.
  $6BFE,$03 Point #REGbc at the first map point (#R$7811).
  $6C01,$03 Fetch the player's X position on the map (#R$5E05).
  $6C04,$03 Set the furthest distance in view, #N($0060, $04, $04).
  $6C07,$03 #REGhl=#REGhl - #REGde (the left edge of the view).
  $6C0A,$01 Exchange #REGde and #REGhl.
@ $6C0B label=FindFirstObject_Next
  $6C0B,$01 Exchange them back so #REGhl holds the left edge of the view again.
  $6C0C,$01 Fetch the X position of the map point.
  $6C0D,$01 Move on to the Y position of the map point.
  $6C0E,$01 Keep the X position in #REGd.
  $6C0F,$03 Call #R$6B30 to convert it to map units in #REGde.
  $6C12,$01 Exchange #REGde and #REGhl.
  $6C13,$03 #REGhl=#REGhl - #REGde (the distance from the left edge of the
. view).
  $6C16,$02 Jump to #R$6C2A if the map point is not to the left of the left
. edge.
  $6C18,$02 Move on to the next map point.
  $6C1A,$03 Point #REGhl at the end of the map points (#R$7CD6, one byte past
. the end of #R$7811).
  $6C1D,$03 #REGhl=#REGhl - #REGbc.
  $6C20,$02 Jump to #R$6C0B if there are more map points.
  $6C22,$03 Point #REGbc at the first map point (#R$7811), to go back to the
. start.
@ $6C25 label=FindFirstObject_Store
  $6C25,$04 Write #REGbc to #R$5E19.
  $6C29,$01 Return.
@ $6C2A label=FindFirstObject_Found
  $6C2A,$01 Decrease #REGbc by one (back to the X position).
  $6C2B,$02 Jump to #R$6C25.

c $6C2D Update Current Object
@ $6C2D label=UpdateCurrentObject
D $6C2D Moves the pointer at #R$5E19 so that it still points to the first map
. point which is within #N$60 map units of the player's X position.
  $6C2D,$04 Write #N$00 to #R$5E1B (it is set to #N$01 if the pointer moves
. back).
  $6C31,$04 Fetch the pointer to the first map point in view (#R$5E19).
N $6C35 Look at the earlier map points to see if the pointer has to move back.
@ $6C35 label=UpdateCurrentObject_Back
  $6C35,$03 Decrease #REGbc by three (to the previous map point).
  $6C38,$01 Fetch the X position of the map point.
  $6C39,$01 Keep the X position in #REGd.
  $6C3A,$03 Call #R$6B30 to convert it to map units in #REGde.
  $6C3D,$03 Find how far the map point is from the player using #R$6C82.
  $6C40,$02 Jump to #R$6C49 if the map point is not close enough.
  $6C42,$05 Write #N$01 to #R$5E1B.
  $6C47,$02 Jump to #R$6C35.
@ $6C49 label=UpdateCurrentObject_Moved
  $6C49,$03 Fetch the flag which says whether the pointer moved back (#R$5E1B).
  $6C4C,$03 Jump to #R$6C57 if the pointer did not move back.
  $6C4F,$03 Increment #REGbc by three (to the first map point which is close
. enough).
@ $6C52 label=UpdateCurrentObject_Store
  $6C52,$04 Write #REGbc to #R$5E19.
  $6C56,$01 Return.
N $6C57 Check whether the pointer has to move forward.
@ $6C57 label=UpdateCurrentObject_Forward
  $6C57,$04 Fetch the pointer to the first map point in view (#R$5E19).
  $6C5B,$01 Fetch the X position of the map point.
  $6C5C,$01 Keep the X position in #REGd.
  $6C5D,$03 Call #R$6B30 to convert it to map units in #REGde.
  $6C60,$03 Find how far the map point is from the player using #R$6C82.
  $6C63,$01 Return if the map point is close enough.
@ $6C64 label=UpdateCurrentObject_Closer
  $6C64,$03 Write the distance to #R$5E1C.
@ $6C67 label=UpdateCurrentObject_NextPoint
  $6C67,$03 Increment #REGbc by three (to the next map point).
  $6C6A,$01 Fetch the X position of the map point.
  $6C6B,$01 Keep the X position in #REGd.
  $6C6C,$03 Call #R$6B30 to convert it to map units in #REGde.
  $6C6F,$03 Find how far the map point is from the player using #R$6C82.
  $6C72,$02 Jump to #R$6C52 if the map point is close enough.
  $6C74,$01 Stash the distance on the stack.
  $6C75,$04 Fetch the previous distance from #R$5E1C.
  $6C79,$03 #REGhl=#REGhl - #REGde.
  $6C7C,$01 Restore the distance (#REGhl) from the stack.
  $6C7D,$02 Jump to #R$6C67 if the distance is the same as before.
  $6C7F,$02 Jump to #R$6C64 if the map point is nearer than the previous one.
  $6C81,$01 Return.

c $6C82 Get Map Distance
@ $6C82 label=GetMapDistance
D $6C82 Finds the distance between the first co-ordinate of the player's map
. position at #R$5E05 and the value in #REGde. The carry flag is set when the
. distance is less than #N$0060.
R $6C82 DE Map position
R $6C82 O:HL Distance
R $6C82 O:F The carry flag is set when the distance is less than #N$0060
  $6C82,$03 Fetch the player's X position on the map (#R$5E05).
  $6C85,$03 #REGhl=#REGhl - #REGde.
  $6C88,$02 Jump to #R$6C8D if there was no carry.
  $6C8A,$03 Call #R$6BF6.
@ $6C8D label=GetMapDistance_Compare
  $6C8D,$01 Stash #REGhl on the stack.
  $6C8E,$03 Set the furthest distance in view, #N($0060, $04, $04).
  $6C91,$03 Compare the distance with the furthest distance in view.
  $6C94,$01 Restore #REGhl from the stack.
  $6C95,$01 Return.

c $6C96 Print Character
@ $6C96 label=PrintScreen
E $6C96 View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #MARTIANOIDS$B5CB }
. { #NIGHTSHADE$CB19 }
. { #PSSST$73CD }
. { #SABREWULF$B589 }
. { #UNDERWURLDE$98DF }
. LIST#
R $6C96 A ASCII value to print
R $6C96 HL Screen address
  $6C96,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $6C99,$03 Set #REGhl to the character code.
  $6C9C,$03 Calculate offset for ASCII character (#REGhl=#REGhl * 8).
  $6C9F,$04 #REGde=#SKOOLKID$5C36(CHARS).
  $6CA3,$02 #REGde=#REGhl + #N$3C00. For examples of usage;
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Letter | =h ASCII Value | =h * 8 (offset) | =h CHARS + offset }
. #FOREACH($55,$4C,$54,$49,$4D,$41,$54,$45)(value,
. { #LET(result=$3C00 + value * $08) "#CHR(value)" | #N(value) | #N(value * 8) | #SKOOLKID($3D00,{result})(#N({result})) }
. )
. TABLE#
N $6CA5 Print the character to the screen.
  $6CA5,$01 Restore #REGhl, containing the screen buffer location, from the stack.
  $6CA6,$02 #REGb=#N$08 (#N$08 rows of pixels).
@ $6CA8 label=PrintScreen_Loop
  $6CA8,$02 Copy a byte of the character to the screen buffer.
  $6CAA,$01 Move on to the next byte of the character.
  $6CAB,$01 Move onto the next pixel line.
  $6CAC,$02 Decrease the pixel row counter by one and loop back to #R$6CA8 until
. all #N$08 rows have been drawn.
  $6CAE,$02 Restore #REGde and #REGbc from the stack.
N $6CB0 Reset #REGhl and move to the next column, ready to print the next character.
  $6CB0,$04 #REGh=#REGh - #N$08 (reset the display line).
  $6CB4,$01 Move on to the next screen column.
  $6CB5,$01 Return.

c $6CB6 Print Scores
@ $6CB6 label=Score_1UP
D $6CB6 Prints the score or the high score at the top of the screen, as six BCD
. digits. The same code (from #R$6CC4) also prints other BCD numbers, such as
. the miles and the time.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SCR$04,$08,$00,$18,$01(print-scores-before)
. | #POKES$5E4C,$12;$5E4D,$34;$5E4E,$50;$5E49,$98;$5E4A,$76;$5E4B,$54
. #SIM(start=$68F8,stop=$68FE)
. #SCR$04,$08,$00,$18,$01(print-scores-after) } UDGTABLE# #POPS
E $6CB6 View the equivalent code in;
. #LIST
. { #ATICATAC$A1AE }
. { #COOKIE$7438 }
. { #JETPAC$711C }
. { #LUNARJETMAN$89BF }
. { #PSSST$739D }
. { #SABREWULF$B5CC }
. LIST#
N $6CB6 Sets up the player score.
  $6CB6,$03 #REGhl=#N$400D (screen location of the score).
  $6CB9,$03 Point #REGde at the score (#R$5E4C).
  $6CBC,$02 Jump to #R$6CC4.
N $6CBE Sets up the HI score.
@ $6CBE label=Score_HI
  $6CBE,$03 #REGhl=#N$4018 (screen location of the high score).
  $6CC1,$03 Point #REGde at the high score (#R$5E49).
N $6CC4 Prints the score. Entering at #R$6CC6 prints #REGb bytes (two digits
. each) of the BCD number at #REGde to the screen location in #REGhl.
@ $6CC4 label=PrintScore
  $6CC4,$02 Set the byte counter to #N$03 (a score is #N$03 bytes, so #N$06
. digits).
@ $6CC6 label=PrintScore_Loop
  $6CC6,$01 Fetch the next byte of the number, which holds two digits.
  $6CC7,$04 #REGa=#REGa / #N$10 (the first digit).
  $6CCB,$02,b$01 Keep only bits 0-3.
  $6CCD,$02 Add #N$30 to convert the digit to ASCII.
  $6CCF,$03 Call #R$6C96 to print the digit.
N $6CD2 Prints the second digit of the byte; entering here skips the first
. digit.
@ $6CD2 label=PrintScore_SecondDigit
  $6CD2,$01 Fetch the byte again, for the second digit.
  $6CD3,$02,b$01 Keep only bits 0-3.
  $6CD5,$02 Add #N$30 to convert the digit to ASCII.
  $6CD7,$03 Call #R$6C96 to print the digit.
  $6CDA,$01 Move on to the next byte of the number.
  $6CDB,$02 Decrease the byte counter by one and loop back to #R$6CC6 until all
. of the bytes have been printed.
  $6CDD,$01 Return.

c $6CDE Display Miles/ Time
@ $6CDE label=DisplayMiles
D $6CDE Prints the miles travelled (six digits) and the time (one digit for the
. hours, two for the minutes and two for the seconds) in the sidebar.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SCR$04,$00,$00,$08,$05(display-miles-before)
. | #POKES$5E2D,$01;$5E2E,$23;$5E2F,$45;$5E31,$01;$5E32,$23;$5E33,$45
. #SIM(start=$68CA,stop=$68CD)
. #SCR$04,$00,$00,$08,$05(display-miles-after) } UDGTABLE# #POPS
  $6CDE,$03 Set the screen position of the miles, #N$4061.
  $6CE1,$03 Point #REGde at the miles (#R$5E2D).
  $6CE4,$02 Set the byte counter to #N$03 (the miles are #N$03 bytes, so #N$06
. digits).
  $6CE6,$03 Print the miles using #R$6CC6.
  $6CE9,$03 Set the screen position of the time, #N$4021.
@ $6CEC label=DisplayTime_Minutes
  $6CEC,$03 Point #REGde at the time (#R$5E31).
  $6CEF,$02 Set the byte counter to #N$02 (the single hours digit and the two
. minutes digits).
  $6CF1,$03 Call #R$6CD2 to skip the first digit of the hours byte.
  $6CF4,$03 Point #REGde at the seconds (#R$5E33).
@ $6CF7 label=DisplayTime_Seconds
  $6CF7,$01 Move on one column to leave a gap before the seconds.
  $6CF8,$02 Set the byte counter to #N$01 (the two seconds digits).
  $6CFA,$03 Jump to #R$6CC6 to print the seconds.

c $6CFD Print Best Time
@ $6CFD label=PrintBestTime
D $6CFD Prints a time (such as the best time at #R$5E00) in the same way as
. #R$6CEC.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SIM(start=$5F29,stop=$5F2C)
. #POKES$5E00,$01;$5E01,$23;$5E02,$45;$5E03,$01
. #SIM(start=$5F2C,stop=$6492)
. #SCR$03,$08,$11,$18,$05(print-best-time-before)
. | #SIM(start=$6492,stop=$5F33)
. #SCR$03,$08,$11,$18,$05(print-best-time-after) } UDGTABLE# #POPS
R $6CFD DE Address of the time
R $6CFD HL Screen location
N $6CFD Print the first two digits.
  $6CFD,$02 Set the byte counter to #N$02.
  $6CFF,$03 Print the hours and minutes using #R$6CD2.
N $6D02 Print the final digit.
  $6D02,$03 Point #REGde at the seconds of the time (#R$5E02).
  $6D05,$02 Jump to #R$6CF7.

c $6D07 Increase Speed
@ $6D07 label=HandlerCanAccelerate
D $6D07 Adds #N$04 to the speed, unless that would take it to the top speed of
. #N$C0 or more, in which case the speed is left as it is.
  $6D07,$03 Fetch the speed of the car (#R$5E0D).
  $6D0A,$02 Add #N$04 to the speed.
  $6D0C,$04 Jump to #R$6D76 if the speed has reached the top speed (#N$C0 or
. more).
  $6D10,$02 Jump to #R$6D73 to write the new speed.

c $6D12 Update Player Car
@ $6D12 label=UpdatePlayerCar
D $6D12 Called once a frame for the player's car. Adds to the miles travelled,
. handles the accelerator and the brake, then moves the car, steers it and uses
. up fuel.
. #TABLE(default,centre,centre)
. { =h Address | =h Meaning }
. { #R$5E04 | X position of the car (#N$03 bytes, the top two are in map units) }
. { #R$5E07 | Y position of the car (#N$03 bytes, the top two are in map units) }
. { #R$5E10 | Direction of the car (#N$0400 is a full turn) }
. TABLE#
N $6D12 Add the speed to the odometer.
  $6D12,$02 Set the miles carry to #N$00.
  $6D14,$03 Fetch the speed of the car (#R$5E0D).
  $6D17,$03 Rotate the top bit of #REGa into #REGc.
  $6D1A,$03 Rotate the top bit of #REGa into #REGc again (this multiplies the
. speed by #N$04).
  $6D1D,$03 Point #REGhl at the fraction of a mile (#R$5E30).
  $6D20,$01 Add the scaled speed to the fraction of a mile.
  $6D21,$01 Write the fraction of a mile back.
  $6D22,$01 Fetch the carry from the speed.
  $6D23,$02 Set the byte counter to #N$03 (the miles are stored in three bytes).
N $6D25 Working backwards, add onto the odometer.
@ $6D25 label=CalcMiles
  $6D25,$01 Move back to the previous byte of the miles.
  $6D26,$01 Add the carry to the byte of the miles.
  $6D27,$01 Convert the result to BCD.
  $6D28,$01 Write the byte of the miles back.
  $6D29,$02 Clear the carry value, keeping the carry flag.
  $6D2B,$02 Decrease the byte counter by one and loop back to #R$6D25 until all
. three bytes of the miles have been done.
N $6D2D Award some points every time the middle byte of the miles changes.
  $6D2D,$04 Fetch the middle byte of the miles as it was last time (#R$5E74)
. and keep it in #REGl.
  $6D31,$03 Fetch the middle byte of the miles (#R$5E2E).
  $6D34,$03 Jump to #R$6D40 if the middle byte of the miles has not changed.
  $6D37,$03 Store the new middle byte of the miles in #R$5E74.
  $6D3A,$03 Set the points to add, #N($0010, $04, $04).
  $6D3D,$03 Add the points to the score using #R$6046.
@ $6D40 label=UpdatePlayerCar_CheckFuel
  $6D40,$03 #REGhl=#R$5E05 (the value is not used).
N $6D43 Check fuel.
  $6D43,$03 Fetch the fuel level (#R$5E0B).
N $6D46 See #POKE(infinite_fuel,Infinite Fuel).
  $6D46,$03 Jump to #R$6D56 if there is still some fuel.
N $6D49 Handle being out of fuel (or too hot): slow down gradually, but allow
. the car to be driven again when it is slow enough.
@ $6D49 label=UpdatePlayerCar_NoFuel
  $6D49,$03 Fetch the speed of the car (#R$5E0D).
  $6D4C,$04 Jump to #R$6D5D if the speed is below #N$33, so the car can be
. driven again.
  $6D50,$01 Slow the car down by one.
  $6D51,$03 Write the speed back to #R$5E0D.
  $6D54,$02 Jump to #R$6D64.
N $6D56 Check the temperature.
@ $6D56 label=UpdatePlayerCar_CheckTemperature
  $6D56,$03 Fetch the temperature (#R$5E0C).
N $6D59 See #POKE(infinite_temperature,Infinite Temperature).
  $6D59,$04 Jump to #R$6D49 if the temperature is #N$A0 or more.
N $6D5D Check the accelerator.
@ $6D5D label=UpdatePlayerCar_Accelerate
  $6D5D,$03 Check if the accelerator is pressed using #R$61E0.
  $6D60,$04 Jump to #R$6D07 if the accelerator is pressed.
N $6D64 Check the brake.
@ $6D64 label=UpdatePlayerCar_Brake
  $6D64,$03 Check if the brake is pressed using #R$61C2.
  $6D67,$04 Jump to #R$6D76 if the brake is not pressed.
  $6D6B,$03 Fetch the speed of the car (#R$5E0D).
  $6D6E,$02 Subtract #N$10 from the speed.
  $6D70,$02 Jump to #R$6D73 if the speed did not go below zero.
  $6D72,$01 Set the speed to #N$00.

c $6D73 Set Speed
@ $6D73 label=HandlerAccelerate
D $6D73 Stores the new speed, draws the speed gauge and moves the car. The
. direction is split into the quadrant (the top two bits, held in #R$5E11) and
. the position in that quadrant (the top five bits of #R$5E10). The table at
. #R$7F6B is then used to share out the speed between the Y and X directions;
. the X part uses the table from the other end.
R $6D73 A Speed
  $6D73,$03 Write the new speed to #R$5E0D.
N $6D76 Draw the speed gauge.
@ $6D76 label=HandlerAccelerate_Gauge
  $6D76,$03 Fetch the speed of the car (#R$5E0D).
  $6D79,$03 Set the screen location of the speed gauge, #N$49E2.
  $6D7C,$03 Draw the speed gauge using #R$6EDE.
N $6D7F Work out the direction.
  $6D7F,$03 Fetch the quadrant of the direction (#R$5E11).
  $6D82,$01 Add one to the quadrant.
  $6D83,$01 Keep the quadrant in #REGc.
  $6D84,$03 Fetch the direction (#R$5E10).
  $6D87,$03 Shift #REGa right three times.
  $6D8A,$02,b$01 Keep bits 0-4.
  $6D8C,$04 Jump to #R$6D92 if bit 0 of #REGc is set.
  $6D90,$02,b$01 Reverse bits 0-4 (the position in the quadrant is measured the
. other way round).
@ $6D92 label=HandlerAccelerate_TableIndex
  $6D92,$01 Use the position in the quadrant as the index into the table.
  $6D93,$02 Clear the high byte of the index.
  $6D95,$01 Stash the index on the stack.
  $6D96,$03 Point #REGhl at the table which shares out the speed (#R$7F6B).
  $6D99,$01 Add the index to the start of the table.
  $6D9A,$04 Fetch the speed of the car (#R$5E0D) and keep it in #REGe.
  $6D9E,$02 Clear the high byte of the speed.
  $6DA0,$01 Stash #REGde (the speed) on the stack.
  $6DA1,$01 Fetch the share of the speed from the table.
  $6DA2,$03 Call #R$6F2F to multiply #REGa by the speed.
N $6DA5 Move the car in the Y direction.
  $6DA5,$03 Fetch the top byte of the Y position of the car (#R$5E07 + #N$02).
  $6DA8,$04 #REGde=#R$5E07.
  $6DAC,$03 Call #R$6EC2 to divide the result by #N$20.
  $6DAF,$04 Jump to #R$6DEF if the car is moving to a lower Y position.
  $6DB3,$01 Add the result to the Y position.
  $6DB4,$02 Carry any overflow into the top byte.
  $6DB6,$04 Jump to #R$6E00 if the Y position reached the edge of the map
. (#N$0C).
@ $6DBA label=HandlerAccelerate_StoreY
  $6DBA,$03 Write the top byte of the Y position.
  $6DBD,$03 Write the rest of the Y position.
N $6DC0 Move the car in the X direction.
@ $6DC0 label=HandlerAccelerate_MoveX
  $6DC0,$01 Restore the speed from the stack.
  $6DC1,$01 Restore the offset from the stack.
  $6DC2,$01 Stash the speed on the stack.
  $6DC3,$03 Point #REGhl at the end of the table which shares out the speed
. (#R$7F8A).
  $6DC6,$01 Clear the carry flag.
  $6DC7,$02 #REGhl=#R$7F8A - offset (this reads the table from the other end).
  $6DC9,$01 Fetch the share of the speed from the table.
  $6DCA,$01 Restore the speed from the stack.
  $6DCB,$03 Call #R$6F2F to multiply #REGa by the speed.
  $6DCE,$03 Fetch the top byte of the X position of the car (#R$5E04 + #N$02).
  $6DD1,$04 #REGde=#R$5E04.
  $6DD5,$03 Call #R$6EC2 to divide the result by #N$20.
  $6DD8,$01 Decrease #REGc by one.
  $6DD9,$04 Jump to #R$6E32 if the car is moving to a lower X position.
  $6DDD,$01 Add the result to the X position.
  $6DDE,$02 Carry any overflow into the top byte.
  $6DE0,$04 Jump to #R$6E19 if the X position reached the edge of the map
. (#N$18).
@ $6DE4 label=HandlerAccelerate_StoreX
  $6DE4,$03 Write the rest of the X position.
  $6DE7,$03 Write the top byte of the X position.
@ $6DEA label=HandlerAccelerate_UpdateObject
  $6DEA,$03 Call #R$6C2D.
  $6DED,$02 Jump to #R$6E43.

c $6DEF Subtract Y Movement
@ $6DEF label=SubtractY
D $6DEF Moves the car to a lower Y position. If it would go below the start of
. the map then it bounces off the edge instead.
  $6DEF,$01 #REGhl=Y position.
  $6DF0,$03 Subtract the result of the multiplication from the Y position.
  $6DF3,$02 Borrow from the top byte.
  $6DF5,$02 Jump to #R$6DBA if the top byte is not zero.
  $6DF7,$01 Switch to the shadow flags.
  $6DF8,$01 #REGa=#REGh.
  $6DF9,$04 Jump to #R$6E00 if the position is below #N$80 in the second byte.
  $6DFD,$01 Switch back.
  $6DFE,$02 Jump to #R$6DBA.

c $6E00 Bounce Off Y Edge
@ $6E00 label=BounceY
D $6E00 Reverses the direction in Y, sounds the bounce and carries on with the X
. direction.
  $6E00,$03 Fetch the quadrant of the direction (#R$5E11).
  $6E03,$02,b$01 Flip bit 0 to reverse the direction in Y.
  $6E05,$03 Write the quadrant back to #R$5E11.
  $6E08,$03 Fetch the direction (#R$5E10).
  $6E0B,$01 Flip all the bits to reverse the direction within the quadrant.
  $6E0C,$03 Write the direction back to #R$5E10.
  $6E0F,$02 Set the bounce counter to #N$05.
  $6E11,$03 Write the bounce counter to #R$5E45.
  $6E14,$03 Make the bounce sound using #R$60E3.
  $6E17,$02 Jump to #R$6DC0.

c $6E19 Bounce Off X Edge
@ $6E19 label=BounceX
D $6E19 Reverses the direction in X, sounds the bounce and carries on.
  $6E19,$03 Fetch the quadrant of the direction (#R$5E11).
  $6E1C,$02,b$01 Flip bits 0 and 1.
  $6E1E,$03 Write the quadrant back to #R$5E11.
  $6E21,$03 Fetch the direction (#R$5E10).
  $6E24,$01 Flip all the bits.
  $6E25,$03 Write the direction back to #R$5E10.
  $6E28,$02 Set the bounce counter to #N$05.
  $6E2A,$03 Write the bounce counter to #R$5E45.
  $6E2D,$03 Make the bounce sound using #R$60E3.
  $6E30,$02 Jump to #R$6DEA.

c $6E32 Subtract X Movement
@ $6E32 label=SubtractX
D $6E32 Moves the car to a lower X position. If it would go below the start of
. the map then it bounces off the edge instead.
  $6E32,$01 #REGhl=X position.
  $6E33,$03 Subtract the result of the multiplication from the X position.
  $6E36,$02 Borrow from the top byte.
  $6E38,$02 Jump to #R$6DE4 if the top byte is not zero.
  $6E3A,$01 Switch to the shadow flags.
  $6E3B,$01 #REGa=#REGh.
  $6E3C,$04 Jump to #R$6E19 if the position is below #N$80 in the second byte.
  $6E40,$01 Switch back.
  $6E41,$02 Jump to #R$6DE4.

c $6E43 Handle Steering And Fuel
@ $6E43 label=HandlerSteering
D $6E43 Counts down the bounce, steers the car, uses up fuel and updates the
. temperature and the gauges.
N $6E43 Count down the bounce; the sound is only made while this is not zero.
  $6E43,$03 Fetch the bounce counter (#R$5E45).
  $6E46,$03 Jump to #R$6E54 if the bounce is over.
  $6E49,$01 Count down the bounce.
  $6E4A,$03 Write the bounce counter back to #R$5E45.
  $6E4D,$02 Jump to #R$6E51 if the counter is now zero.
  $6E4F,$02 #REGa=#N$02.
@ $6E51 label=HandlerSteering_StoreSound
  $6E51,$03 Write #REGa to #R$5E47.
N $6E54 Steer the car.
@ $6E54 label=HandlerSteering_Steer
  $6E54,$03 Read the steering keys using #R$618C.
  $6E57,$03 Point #REGhl at the direction (#R$5E10).
  $6E5A,$02 Set the amount to turn by, #N$18.
  $6E5C,$05 Jump to #R$6E76 if left is pressed.
  $6E61,$05 Jump to #R$6E6C if right is pressed.
  $6E66,$02 Set the amount to turn by to #N$00, as the car is going straight on.
  $6E68,$02 Jump to #R$6E7E.
N $6E6A This instruction is never used.
  $6E6A,$02 #REGe=#N$18.
N $6E6C Turn right.
@ $6E6C label=HandlerSteering_TurnRight
  $6E6C,$02 Clear the high byte of the amount to turn by.
  $6E6E,$01 Add the amount to turn by to the direction.
  $6E6F,$03 Write the direction back to #R$5E10.
  $6E72,$02 Jump to #R$6E7E.
N $6E74 This instruction is never used.
  $6E74,$02 #REGe=#N$18.
N $6E76 Turn left.
@ $6E76 label=HandlerSteering_TurnLeft
  $6E76,$02 Clear the high byte of the amount to turn by.
  $6E78,$03 Take the amount to turn by away from the direction.
  $6E7B,$03 Write the direction back to #R$5E10.
N $6E7E Don't "use fuel" on every frame. This routine uses the last two bits of
. the #R$5E29(GameTimer) (i.e. a number between 0-3) to only process every
. fourth frame.
@ $6E7E label=HandlerFuel
  $6E7E,$03 Fetch the game timer (#R$5E29).
  $6E81,$02,b$01 Keep only bits 0-1.
  $6E83,$02 If the result is not zero then jump to #R$6E9B.
N $6E85 Handles "using" fuel.
  $6E85,$03 Fetch the speed of the car (#R$5E0D).
  $6E88,$01 Use the speed as the amount of fuel to use, in #REGc.
  $6E89,$02 Clear the high byte of the amount of fuel to use.
  $6E8B,$03 Fetch the fuel (#R$5E0A).
N $6E8E A higher speed uses more fuel.
  $6E8E,$02 #REGhl=#REGhl (fuel) - #REGbc (speed).
  $6E90,$02 If there's "carry" (i.e. if the player has run out of fuel) jump to
. #R$6E95.
  $6E92,$03 Write #REGhl to #R$5E0A.
@ $6E95 label=FuelSkipWrite
  $6E95,$04 If the current speed is more than #N$B0 (top speed) jump to #R$6EAF.
  $6E99,$02 Compare current speed with #N$60.
N $6E9B Handle the temperature gauge.
@ $6E9B label=HandlerTemperatureGauge
  $6E9B,$03 Fetch the temperature (#R$5E0C).
  $6E9E,$02 If there's carry set (this could be either from #R$6E99 or #R$6E81)
. then jump to #R$6EBC.
@ $6EA0 label=DrawTemperatureGauge
  $6EA0,$03 Set the screen location of the temperature gauge,
. #N($5162, $04, $04).
  $6EA3,$03 Draw the temperature gauge using #R$6EDE.
N $6EA6 Handle the fuel gauge.
  $6EA6,$03 Fetch the fuel level (#R$5E0B).
  $6EA9,$03 Set the screen location of the fuel gauge, #N($5122, $04, $04).
  $6EAC,$03 Draw the fuel gauge using #R$6EDE.
N $6EAF Handle the temperature gauge at maximum speed.
@ $6EAF label=TemperatureMaxSpeed
  $6EAF,$03 Fetch the temperature (#R$5E0C).
N $6EB2 Check if the temperature is already at the upper limit.
  $6EB2,$04 If the current temperature is more than #N$C0 jump to #R$6EA0.
N $6EB6 Go ahead and increase the temperature...
  $6EB6,$01 Increase the temperature by one.
@ $6EB7 label=UpdateTemperature
  $6EB7,$03 Write the new temperature back to #R$5E0C.
  $6EBA,$02 Jump to #R$6EA0.
N $6EBC Handles dropping the temperature gauge.
@ $6EBC label=TemperatureDrop
  $6EBC,$03 If the current temperature is at zero jump to #R$6EA0.
  $6EBF,$01 Decrease the temperature by one.
  $6EC0,$02 Jump to #R$6EB7.

c $6EC2 Divide By Thirty-Two
@ $6EC2 label=DivideByThirtyTwo
D $6EC2 Shifts #REGhl right by five bits, which divides it by #N$20.
R $6EC2 HL Value
R $6EC2 O:HL Value divided by #N$20
  $6EC2,$02 Set the shift counter to #N$05.
@ $6EC4 label=DivideByThirtyTwo_Loop
  $6EC4,$02 Shift #REGh right, moving bit 0 into the carry flag.
  $6EC6,$02 Rotate the carry flag into #REGl from the top.
  $6EC8,$02 Decrease the shift counter by one and loop back to #R$6EC4 until all
. five shifts have been done.
  $6ECA,$01 Return.

c $6ECB Screen Address One Pixel Above
@ $6ECB label=ScreenPosition1PixelAbove
D $6ECB Calculates the new address for writing a sprite pixel, in an upward
. direction, taking into consideration the screen memory layout.
E $6ECB View the equivalent code in;
. #LIST
. { #ATICATAC$9F03 }
. { #LUNARJETMAN$85F6 }
. { #UNDERWURLDE$AE71 }
. LIST#
R $6ECB HL Current position
R $6ECB O:HL Address for new position
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
R $6EDE HL Screen location to draw the gauge
R $6EDE A Current Gauge Level
N $6EDE #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #POKES$5E0B,$60;$5E0C,$80
. #SIM(start=$6010,stop=$6EA0,sp=$5E00)
. #SCR$03,$00,$0F,$08,$06(draw-gauge-before)
. | #SIM(start=$6EA0,stop=$6A87)
. #SCR$03,$00,$0F,$08,$06(draw-gauge-after) } UDGTABLE# #POPS
  $6EDE,$05 Scale the gauge level down by #N$04 to give the number of pixels to
. fill, in #REGc.
N $6EE3 Decrease gauge count by #N$08 and keep looping around until what's left is < #N$08 - then handle this part separately.
@ $6EE3 label=DrawGaugeLine_Loop
  $6EE3,$03 Take #N$08 away from the pixel count.
  $6EE6,$02 If gauge count < #N$08 then jump to #R$6EF0.
  $6EE8,$01 Keep the remaining pixel count in #REGc.
  $6EE9,$02 Set a full line of pixels, #N$FF.
  $6EEB,$03 Draw a full cell of the gauge using #R$6EFD.
  $6EEE,$02 Jump to #R$6EE3.
N $6EF0 Handles drawing the last section of the gauge level.
@ $6EF0 label=DrawGaugeScreen_Last
  $6EF0,$02 Create an offset in #REGbc (#REGb=#N$00, #REGc=gauge count).
  $6EF2,$01 Stash the gauge screen location temporarily.
  $6EF3,$04 Point #REGhl at the gauge data (#R$6F07 + the remaining pixel
. count).
  $6EF7,$01 Fetch the pixels for the end of the gauge.
  $6EF8,$01 Restore the gauge screen location from the stack.
  $6EF9,$03 Call #R$6EFD.
  $6EFC,$01 #REGa=#N$00 (no pixels - i.e. masking).
N $6EFD Writes #REGa to the screen.
@ $6EFD label=DrawGaugeScreen
  $6EFD,$01 Stash the gauge screen location temporarily.
  $6EFE,$02 #REGb=#N$07 (counter for number of lines to draw).
@ $6F00 label=DrawGaugeScreen_Loop
  $6F00,$01 Write #REGa to the screen location held by #REGhl.
  $6F01,$01 Increment #REGh by one to move onto the next row.
  $6F02,$02 Decrease counter by one and loop back to #R$6F00 until counter is zero.
  $6F04,$01 Restore the original gauge screen location from the stack.
  $6F05,$01 Increment #REGl by one to move onto the next column.
  $6F06,$01 Return.
N $6F07 Gauge data; each value corresponds to a "full" line for #N$09 decreasing values. This completes the "end"
.       section when drawing a gauge line.
@ $6F07 label=GaugeData
B $6F07,$09,$01 #UDG(#PC)

c $6F10 Calculate Screen Address
@ $6F10 label=ScreenAddress
D $6F10 Converts pixel co-ordinates into the matching address in the screen
. buffer.
E $6F10 View the equivalent code in;
. #LIST
. { #ATICATAC$9BA2 }
. { #COOKIE$76E3 }
. { #JETPAC$7308 }
. { #LUNARJETMAN$851E }
. { #MARTIANOIDS$BD4B }
. { #PSSST$759A }
. { #SABREWULF$B8AD }
. { #UNDERWURLDE$ADF8 }
. LIST#
R $6F10 HL Pixel co-ordinates (#REGh is the Y position, counting down from the top of the screen, and #REGl is the X position)
R $6F10 O:HL Screen buffer address
  $6F10,$01 #REGa=#REGl.
  $6F11,$03 #REGa=#REGa / #N$08.
  $6F14,$02,b$01 Keep only bits 0-4.
  $6F16,$01 #REGl=#REGa.
  $6F17,$01 #REGa=#REGh.
  $6F18,$02 #REGa=#REGa * #N$04.
  $6F1A,$02,b$01 Keep only bits 5-7.
  $6F1C,$01 Set the bits from #REGl.
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
  $6F2C,$01 Set the bits from #REGh.
  $6F2D,$01 #REGh=#REGa.
  $6F2E,$01 Return.

c $6F2F Multiply A By DE
@ $6F2F label=MultiplyAByDE
D $6F2F Multiplies #REGa by #REGde, by adding #REGde to the result for each bit
. of #REGa which is set.
E $6F2F View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE0D }
. { #ATICATAC$9AAD }
. { #GUNFRIGHT$D03E }
. { #KNIGHTLORE$D4F9 }
. { #NIGHTSHADE$E0EE }
. { #SABREWULF$BC5A }
. { #UNDERWURLDE$AC68 }
. LIST#
R $6F2F A The first number
R $6F2F DE The second number
R $6F2F O:HL Result
  $6F2F,$03 #REGhl=#N($0000, $04, $04).
  $6F32,$02 Set the bit counter to #N$08.
@ $6F34 label=MultiplyAByDE_Loop
  $6F34,$01 Shift the result left.
  $6F35,$01 Rotate the next bit of #REGa into the carry flag.
  $6F36,$02 Jump to #R$6F39 if the bit is not set.
  $6F38,$01 Add #REGde to the result.
@ $6F39 label=MultiplyAByDE_Next
  $6F39,$02 Decrease the bit counter by one and loop back to #R$6F34 until all
. #N$08 bits have been used.
  $6F3B,$01 Return.

c $6F3C Place Object
@ $6F3C label=PlaceObject
D $6F3C Works out where an object found by #R$6B47 is on the screen and draws
. it. The object's slot in the table at #R$5E50 is found (or a free slot is
. used), the old sprite is erased, the new one is drawn and coloured, and then
. the car is checked to see if it has hit the object. The car is at the centre
. of the play area, so the screen position of the object is its distance from
. the car (#R$5E17 and #R$5E18) added to, or subtracted from, the position of
. the car (#N$98 and #N$68).
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #POKES$5E05,$C0;$5E06,$0C;$5E08,$98;$5E09,$05
. #SIM(start=$6BFE,stop=$6C29,sp=$5E00)
. #SIM(start=$6010,stop=$6BC8,sp=$5E00)
. #SCR$04,$11,$11,$06,$05(place-object-before)
. | #SIM(start=$6BC8,stop=$6BCB)
. #SCR$04,$11,$11,$06,$05(place-object-after) } UDGTABLE# #POPS
N $6F3C Work out the Y position. Return if the object is off the top or bottom
. of the screen.
  $6F3C,$04 Fetch the quadrant of the object (#R$5E13) and keep it in #REGc.
  $6F40,$01 Increment #REGa by one.
  $6F41,$02,b$01 Keep only bits 0-1.
  $6F43,$02 Test bit 1.
  $6F45,$03 Fetch the vertical distance from the car (#R$5E18).
  $6F48,$02 Jump to #R$6F4C if bit 1 was set.
  $6F4A,$02 Make the distance negative.
@ $6F4C label=PlaceObject_AddCarY
  $6F4C,$02 #REGa=#REGa + #N$68 (the Y position of the car).
  $6F4E,$03 Return if the Y position is #N$C0 or more.
  $6F51,$03 Return if the Y position is less than #N$10.
  $6F54,$03 Write the Y position to #R$5E15.
  $6F57,$01 Keep the Y position in #REGh.
N $6F58 Work out the X position. Return if the object is off the left or right
. of the screen.
  $6F58,$03 Fetch the horizontal distance from the car (#R$5E17).
  $6F5B,$03 Return if the distance is #N$58 or more.
  $6F5E,$04 Jump to #R$6F64 if the object is to the right of the car.
  $6F62,$02 Make the distance negative.
@ $6F64 label=PlaceObject_AddCarX
  $6F64,$02 #REGa=#REGa + #N$98 (the X position of the car).
  $6F66,$03 Write the X position to #R$5E14.
  $6F69,$01 Keep the X position in #REGl.
N $6F6A Collected cups are not drawn, and place names are drawn as a fuel pump
. (sprite #N$07).
  $6F6A,$03 Fetch the sprite ID of the map point (#R$5E1F).
  $6F6D,$03 Return if this is a collected cup.
  $6F70,$04 Jump to #R$6F7A if this is a cup.
  $6F74,$04 Jump to #R$6F7A if this is not a place name.
  $6F78,$02 Use the fuel pump sprite, #N$07.
@ $6F7A label=PlaceObject_Sprite
  $6F7A,$03 Write the sprite ID to #R$5E1E.
  $6F7D,$01 Stash the screen position on the stack.
  $6F7E,$01 Keep the screen position in #REGde.
N $6F7F Look for the object in the table of objects that are already on the
. screen; it is the same object if it is within #N$0A pixels in both directions.
  $6F7F,$02 Set the slot counter to #N$07 (the number of object slots).
  $6F81,$03 Point #REGhl at the X position of the first object (#R$5E51).
@ $6F84 label=PlaceObject_Search
  $6F84,$01 Fetch the X position of the object in the slot.
  $6F85,$01 Subtract the new X position.
  $6F86,$03 Jump to #R$6F8B if the difference is positive.
  $6F89,$02 Make the difference positive.
@ $6F8B label=PlaceObject_CompareX
  $6F8B,$04 Jump to #R$6FAC if the object is #N$0A or more pixels away.
  $6F8F,$01 Move on to the Y position.
  $6F90,$01 Fetch the Y position of the object in the slot.
  $6F91,$01 Subtract the new Y position.
  $6F92,$03 Jump to #R$6F97 if the difference is positive.
  $6F95,$02 Make the difference positive.
@ $6F97 label=PlaceObject_CompareY
  $6F97,$04 Jump to #R$6FAD if the object is #N$0A or more pixels away.
N $6F9B The object is already on the screen. Store its old state so that the old
. sprite is erased when the new one is drawn.
  $6F9B,$01 Stash the address of the Y position on the stack.
  $6F9C,$02 Move back to the sprite ID.
  $6F9E,$03 Point #REGix at the object (using the stack to do so).
  $6FA1,$03 Fetch the new sprite ID (#R$5E1E).
  $6FA4,$01 Write the new sprite ID to the object.
  $6FA5,$03 Copy the details of the object using #R$71ED.
  $6FA8,$01 Restore the address of the Y position from the stack.
  $6FA9,$01 Restore the screen position from the stack.
  $6FAA,$02 Jump to #R$6FC1.
N $6FAC Move on to the next object.
@ $6FAC label=PlaceObject_Next
  $6FAC,$01 Increment #REGhl by one.
@ $6FAD label=PlaceObject_Skip
  $6FAD,$02 Increment #REGhl by two (to the X position of the next object).
  $6FAF,$02 Decrease the slot counter by one and loop back to #R$6F84 until all
. of the slots have been checked.
N $6FB1 The object is not on the screen yet, so look for a free slot.
  $6FB1,$01 Restore the screen position from the stack.
  $6FB2,$03 Point #REGhl at the first object slot (#R$5E50).
  $6FB5,$02 Set the slot counter to #N$07 (the number of object slots).
  $6FB7,$01 Set #REGa to #N$00.
  $6FB8,$03 Write #REGa to #R$5E22 (there is no old sprite to erase).
@ $6FBB label=PlaceObject_FindSlot
  $6FBB,$01 Fetch the sprite ID of the slot.
  $6FBC,$01 Test whether the slot is empty.
  $6FBD,$02 Jump to #R$7024 if the slot is used.
  $6FBF,$02 Move on to the Y position.
N $6FC1 Store the object in its slot.
@ $6FC1 label=PlaceObject_Store
  $6FC1,$01 Write the Y position.
N $6FC2 See #POKE(invisible_obstacles,Invisible Obstacles).
  $6FC2,$01 Move back to the X position.
  $6FC3,$01 Write the X position.
  $6FC4,$01 Move back to the sprite ID.
  $6FC5,$03 Fetch the new sprite ID (#R$5E1E).
  $6FC8,$02,b$01 Set bit 7 (so that #R$6AF5 knows that the object is still in
. view).
  $6FCA,$01 Write the sprite ID.
  $6FCB,$03 #REGix=#REGhl (using the stack to do so).
  $6FCE,$03 Fetch the sprite ID of the map point (#R$5E1F).
  $6FD1,$04 Jump to #R$6FDA if this is a cup.
  $6FD5,$02,b$01 Keep only bits 0-6.
  $6FD7,$03 Display the place name using #R$64F0.
N $6FDA Erase the old sprite, draw the new one and colour it.
@ $6FDA label=PlaceObject_Draw
  $6FDA,$03 Draw the object using #R$7101.
  $6FDD,$03 Fetch the X position of the object.
  $6FE0,$03 Fetch the Y position of the object.
  $6FE3,$04 Fetch the attribute of the object (#R$5E42) and keep it in #REGd.
  $6FE7,$03 Colour the object using #R$7052.
N $6FEA Check if the car is near enough to the object to have hit it.
  $6FEA,$03 Fetch the horizontal distance from the car (#R$5E17).
N $6FED See #POKE(immune_to_obstacles,Immune To Obstacles).
  $6FED,$03 Return if the object is #N$0A or more pixels away in X.
  $6FF0,$03 Fetch the vertical distance from the car (#R$5E18).
  $6FF3,$03 Return if the object is #N$0A or more pixels away in Y.
  $6FF6,$03 Fetch the sprite ID of the map point (#R$5E1F).
  $6FF9,$04 Jump to #R$702A if this is a cup.
  $6FFD,$04 Jump to #R$7038 if this is not a place name.
N $7001 The car has reached a place. Add #N$50 points the first time that this
. place is visited, and then refuel.
  $7001,$01 Keep the place in #REGc.
  $7002,$03 Fetch the last place visited (#R$5E4F).
  $7005,$03 Jump to #R$7012 if this is the same place as the last one.
  $7008,$01 Fetch the place.
  $7009,$03 Write the place as the last place visited (#R$5E4F).
  $700C,$03 Set the points to award, #N($0050, $04, $04).
  $700F,$03 Add the points to the score using #R$6046.
@ $7012 label=PlaceObject_Refuel
  $7012,$03 Set the fuel to a full tank, #N$C0FF.
  $7015,$03 Write the fuel to #R$5E0A.
  $7018,$03 Fetch the step counter of the sound (#R$5E46).
  $701B,$02,b$01 Keep only bits 0-6.
  $701D,$01 Return if a sound is already being made.
  $701E,$02 Set the step counter to #N$07, which starts the refuel sound.
  $7020,$03 Write the step counter to #R$5E46.
  $7023,$01 Return.

c $7024 Next Object Slot
@ $7024 label=NextObjectSlot
D $7024 Moves on to the next slot when looking for a free slot for an object. If
. all of the slots are used then the object is not drawn.
  $7024,$03 Increment #REGhl by three.
  $7027,$02 Decrease the slot counter by one and loop back to #R$6FBB until all
. of the slots have been checked.
  $7029,$01 Return.

c $702A Collect Cup
@ $702A label=CollectCup
D $702A The car has reached a cup. Marks the cup as collected on the map, starts
. the cup sound and then handles picking up the cup.
  $702A,$03 Fetch the pointer to the map point after the cup (#R$5E3A).
  $702D,$01 Move back to the sprite ID.
  $702E,$02 Write #N$60 (a collected cup) to the map point.
  $7030,$02 Set the step counter to #N$87, which starts the cup sound.
  $7032,$03 Write the step counter to #R$5E46.
  $7035,$03 Jump to #R$63FF.

c $7038 Hit Object
@ $7038 label=HitObject
D $7038 The car has hit an object. Changes the object to a tombstone (sprite
. #N$0F), removes the two cars and makes the player's car explode.
  $7038,$03 Fetch the pointer to the map point after the object (#R$5E3A).
  $703B,$01 Move back to the sprite ID.
  $703C,$02 Write #N$0F (a tombstone) to the map point.
@ $703E label=HitObject_DestroyPlayer
  $703E,$07 Write #N$00 to #LIST { #R$5E8C } { #R$5E98 } LIST#
  $7045,$05 Write #N$03 to #R$5E80 (the player's car is exploding).
  $704A,$01 Return.

c $704B Colourise Sprite
@ $704B label=ColouriseSprite
D $704B Sets the attributes under a sprite to the attribute of the actor. The
. sprite is coloured from the bottom upwards and the attributes of the top row
. of the screen and of the border (#N$76) are left alone. Entering at #R$7052
. (#REGd is the attribute and #REGhl is the position of the bottom left of the
. sprite in pixels) or at #R$7064 (#REGb is the width and #REGc is the height in
. attribute cells, #REGd is the attribute and #REGhl is the attribute buffer
. address of the bottom left) uses the normal registers instead of the shadow
. registers.
E $704B View the equivalent code in;
. #LIST
. { #LUNARJETMAN$8733 }
. LIST#
R $704B IX Actor entity
  $704B,$01 Switch to the shadow registers.
  $704C,$03 Fetch the position of the sprite (#R$5E27).
  $704F,$03 #REGd'=the attribute of the actor.
N $7052 Work out the size of the sprite in attribute cells.
@ $7052 label=ColouriseSprite_Position
  $7052,$03 Call #R$7097 to convert the pixel co-ordinates into an attribute
. buffer address.
  $7055,$03 #REGa=#R$5E24 (the width of the sprite in bytes).
  $7058,$01 Keep the width in #REGb.
  $7059,$03 #REGa=#R$5E23 (the height of the sprite in pixels).
  $705C,$02 #REGa=#REGa / #N$04.
  $705E,$01 Increment #REGa by one.
  $705F,$01 #REGa=#REGa / #N$02.
  $7060,$02,b$01 Keep only bits 0-4.
  $7062,$01 Increment #REGa by one.
  $7063,$01 #REGc=#REGa (the number of rows).
N $7064 Colour each of the rows, going upwards.
@ $7064 label=ColouriseSprite_Block
  $7064,$01 Keep the width in #REGe.
@ $7065 label=ColouriseSprite_Loop1
  $7065,$01 Stash the address of the start of the row on the stack.
@ $7066 label=ColouriseSprite_Loop2
  $7066,$01 #REGa=#REGh.
  $7067,$04 Jump to #R$7089 if the address is beyond the end of the attribute
. buffer.
  $706B,$02 Stash #REGhl and #REGbc on the stack.
  $706D,$03 #REGbc=#N$5820 (the start of the second row of attributes).
  $7070,$03 #REGhl=#REGhl - #REGbc.
  $7073,$02 Restore #REGbc and #REGhl from the stack.
  $7075,$02 Jump to #R$7089 if the address is in the top row of attributes.
  $7077,$01 Fetch the current attribute of the cell.
  $7078,$04 Jump to #R$707D if this is a border attribute (#N$76).
  $707C,$01 Write the attribute of the actor.
@ $707D label=ColouriseSprite_NextColumn
  $707D,$01 Move onto the next column.
  $707E,$01 #REGa=#REGl.
  $707F,$02,b$01 Keep only bits 0-4.
  $7081,$02 Jump to #R$7087 if the address is still in the same row.
  $7083,$04 Move back to the start of the row (this is for when the actor is
. partly off the right of the screen).
@ $7087 label=ColouriseSprite_Next
  $7087,$02 Decrease the column counter by one and loop back to #R$7066 until
. the whole row has been coloured.
@ $7089 label=ColouriseSprite_NextRow
  $7089,$01 Restore the address of the start of the row from the stack.
  $708A,$01 Stash #REGbc on the stack.
  $708B,$01 Clear the carry flag.
  $708C,$03 Set the size of a row, #N($0020, $04, $04).
  $708F,$02 Move up a row.
  $7091,$01 Restore #REGbc from the stack.
  $7092,$01 Reset the width counter.
  $7093,$01 Decrease the row counter by one.
  $7094,$02 Loop back to #R$7065 until all of the rows have been coloured.
  $7096,$01 Return.

c $7097 Calculate Attribute Address
@ $7097 label=AttributeAddress
E $7097 View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #COOKIE$7534 }
. { #JETPAC$720E }
. { #LUNARJETMAN$8506 }
. { #PSSST$748F }
. { #UNDERWURLDE$ADE0 }
. LIST#
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
  $70A9,$02,b$01 Set MSB of the attribute buffer #N$58. This ensures our value
. is >= #N$5800.
  $70AB,$01 Store this back in #REGh.
  $70AC,$01 Return.

c $70AD Get Visible Height
@ $70AD label=GetVisibleHeight
D $70AD Works out how many lines of a sprite can be drawn upwards from a
. position without reaching the top row of the screen (which is not part of the
. play area).
R $70AD H Y position of the sprite
R $70AD O:C Number of lines
  $70AD,$01 Fetch the Y position of the sprite.
  $70AE,$02 Take #N$08 away, as the top row of the screen is not part of the
. play area.
  $70B0,$01 Keep the number of lines that can be drawn in #REGc.
  $70B1,$01 Return.

c $70B2 Prepare Old Sprite
@ $70B2 label=PrepareOldSprite
D $70B2 Prepares to erase the sprite of an actor from where it was last drawn,
. using the old state held in the actor buffer at #R$5E20. Points #REGde to the
. sprite data, #REGhl to the screen address, stores the pixel shift in #R$5E40
. and the number of lines to erase in #R$5E25.
E $70B2 View the equivalent code in;
. #LIST
. { #COOKIE$7557 }
. { #PSSST$7542 }
. LIST#
E $70B2 Continue on to #R$70CE.
R $70B2 O:DE Sprite data (after the height)
R $70B2 O:HL Screen address of the bottom left of the sprite
R $70B2 O:C #N$00
  $70B2,$03 Call #R$7155 to fetch the sprite.
  $70B5,$03 Fetch the old position of the sprite (#R$5E20).
  $70B8,$01 #REGa=#REGl.
  $70B9,$02 Make #REGa negative.
  $70BB,$02,b$01 Keep only bits 0-2.
  $70BD,$03 Write the pixel shift to #R$5E40.
  $70C0,$03 Work out how many lines can be drawn using #R$70AD.
  $70C3,$03 Convert the position into a screen address using #R$6F10.
  $70C6,$01 Fetch the height of the sprite.
  $70C7,$03 Jump to #R$70CB if the height is no more than the number of lines
. that can be drawn.
  $70CA,$01 Use the number of lines that can be drawn, as the sprite is too
. tall.
@ $70CB label=PrepareOldSprite_Rows
  $70CB,$03 Write the number of lines to #R$5E25.

c $70CE Skip Sprite Height
@ $70CE label=NextSprite
D $70CE Points #REGde to the sprite data (after the height) and clears the line
. counter.
R $70CE DE Sprite
R $70CE O:DE Sprite data
R $70CE O:C #N$00
  $70CE,$02 #REGc=#N$00.
  $70D0,$01 Increment #REGde by one to point to the next sprite header value.
  $70D1,$01 Return.

c $70D2 Prepare Actor Sprite
@ $70D2 label=PrepareActorSprite
D $70D2 Prepares to draw the sprite of an actor at its new position. Points
. #REGde to the sprite data and #REGhl to the screen address, stores the pixel
. shift in #R$5E41, the width in bytes in #R$5E24 and the number of lines to
. draw in #R$5E26 and #R$5E23.
E $70D2 View the equivalent code in;
. #LIST
. { #COOKIE$7584 }
. LIST#
R $70D2 IX Actor entity
R $70D2 O:DE Sprite data (after the height)
R $70D2 O:HL Screen address of the bottom left of the sprite
R $70D2 O:C #N$00
  $70D2,$03 Call #R$7168 to fetch the sprite.
@ $70D5 label=PrepareActorSprite_Position
  $70D5,$03 #REGl=X position of the actor.
  $70D8,$03 #REGh=Y position of the actor.
@ $70DB label=PrepareActorSprite_Shift
  $70DB,$01 #REGa=#REGl.
  $70DC,$02 Make #REGa negative.
  $70DE,$02,b$01 Keep only bits 0-2.
  $70E0,$03 Write the pixel shift to #R$5E41.
  $70E3,$02 Set the width of the sprite in bytes, #N$02.
  $70E5,$02 Jump to #R$70E8 if the sprite is not shifted.
  $70E7,$01 Increment #REGa by one (a shifted sprite is one byte wider).
@ $70E8 label=PrepareActorSprite_Width
  $70E8,$03 Write the width to #R$5E24.
  $70EB,$03 Write the position to #R$5E27.
  $70EE,$03 Work out how many lines can be drawn using #R$70AD.
  $70F1,$03 Convert the position into a screen address using #R$6F10.
  $70F4,$01 Fetch the height of the sprite.
  $70F5,$03 Jump to #R$70F9 if the height is no more than the number of lines
. that can be drawn.
  $70F8,$01 Use the number of lines that can be drawn, as the sprite is too
. tall.
@ $70F9 label=PrepareActorSprite_Rows
  $70F9,$03 Write the number of lines to #R$5E26.
  $70FC,$03 Write the number of lines to #R$5E23.
  $70FF,$02 Jump to #R$70CE.

c $7101 Display Entity
@ $7101 label=DisplayEntity
D $7101 Erases the sprite of an actor from where it was last drawn (the old
. state held in the actor buffer at #R$5E20) and draws it at its new position.
. Both sprites are handled a line at a time by #R$7170, but if the old and the
. new Y positions are different then the lines of one sprite that stick out
. below the other are handled first.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #POKES$5E05,$C0;$5E06,$0C;$5E08,$98;$5E09,$05
. #SIM(start=$6BFE,stop=$6C29,sp=$5E00)
. #SIM(start=$6010,stop=$6FDA,sp=$5E00)
. #SCR$04,$11,$11,$06,$05(display-entity-before)
. | #SIM(start=$6FDA,stop=$6FDD)
. #SCR$04,$11,$11,$06,$05(display-entity-after) } UDGTABLE# #POPS
E $7101 View the equivalent code in;
. #LIST
. { #ATICATAC$9FCA }
. { #COOKIE$75CC }
. { #JETPAC$726A }
. { #PSSST$74EB }
. { #SABREWULF$B9A9 }
. { #UNDERWURLDE$96F7 }
. LIST#
R $7101 IX Actor entity
  $7101,$03 Fetch the sprite ID of the old sprite (#R$5E22).
  $7104,$04 Jump to #R$7149 if there is no old sprite, as there is nothing to
. erase.
  $7108,$03 Call #R$70D2 to prepare the new sprite.
  $710B,$01 Switch to the shadow registers (to keep the new sprite).
  $710C,$03 Call #R$70B2 to prepare the old sprite.
  $710F,$03 #REGa=#R$5E21 (the old Y position).
  $7112,$03 Subtract the new Y position.
  $7115,$03 Jump to #R$71D1 if the old and new Y positions are the same.
  $7118,$03 Jump to #R$712A if the new sprite is lower down than the old sprite.
  $711B,$01 #REGc=the number of lines that the old sprite sticks out below the
. new sprite.
  $711C,$03 #REGa=#R$5E25 (the number of lines in the old sprite).
  $711F,$04 Jump to #R$71D1 if the old sprite has fewer lines than this.
  $7123,$01 Subtract the lines that stick out.
  $7124,$03 Write the number of lines left to #R$5E25.
  $7127,$03 Jump to #R$7170 to erase the lines that stick out.
N $712A The new sprite is lower down, so it has some lines to draw before any
. lines are erased.
@ $712A label=DisplayEntity_NewLower
  $712A,$01 Switch to the shadow registers (the new sprite).
  $712B,$02 Make the result positive.
  $712D,$01 #REGc=the number of lines that the new sprite sticks out below the
. old sprite.
  $712E,$03 #REGa=#R$5E26 (the number of lines in the new sprite).
  $7131,$04 Jump to #R$71D0 if the new sprite has fewer lines than this.
  $7135,$01 Subtract the lines that stick out.
  $7136,$03 Jump to #R$71E4 to store the number of lines left and to draw the
. lines that stick out.

c $7139 Remove Entity
@ $7139 label=RemoveEntity
D $7139 Erases the sprite of an actor from where it was last drawn (the old
. state held in the actor buffer at #R$5E20), without drawing it again.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #POKES$5E05,$C0;$5E06,$0C;$5E08,$98;$5E09,$05
. #SIM(start=$6BFE,stop=$6C29,sp=$5E00)
. #SIM(start=$6010,stop=$6FEA,sp=$5E00)
. #SCR$04,$11,$11,$06,$05(remove-entity-before)
. | #SIM(start=$6B1B,stop=$6B21)
. #SCR$04,$11,$11,$06,$05(remove-entity-after) } UDGTABLE# #POPS
E $7139 View the equivalent code in;
. #LIST
. { #ATICATAC$9F56 }
. { #COOKIE$7607 }
. { #JETPAC$72A5 }
. { #PSSST$7526 }
. { #SABREWULF$B8F5 }
. { #UNDERWURLDE$9636 }
. LIST#
  $7139,$03 Call #R$70B2 to prepare the old sprite.
  $713C,$01 Switch to the shadow registers.
  $713D,$01 Set #REGa to #N$00.
  $713E,$01 #REGc=#REGa (there are no lines of the new sprite to draw).
  $713F,$06 Write #N$00 to; #LIST { #R$5E26 } { #R$5E23 } LIST#
  $7145,$01 Switch back to the normal registers.
  $7146,$03 Jump to #R$7170.

c $7149 Draw Entity
@ $7149 label=DrawEntity
D $7149 Draws the sprite of an actor at its position, when there is no old
. sprite to erase.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #POKES$5E05,$C0;$5E06,$0C;$5E08,$98;$5E09,$05
. #SIM(start=$6BFE,stop=$6C29,sp=$5E00)
. #SIM(start=$6010,stop=$7149,sp=$5E00)
. #SCR$04,$11,$11,$06,$05(draw-entity-before)
. | #SIM(start=$7149,stop=$6FDD)
. #SCR$04,$11,$11,$06,$05(draw-entity-after) } UDGTABLE# #POPS
E $7149 View the equivalent code in;
. #LIST
. { #ATICATAC$9F4A }
. { #COOKIE$7617 }
. { #JETPAC$72B5 }
. { #SABREWULF$B919 }
. { #UNDERWURLDE$962A }
. LIST#
R $7149 IX Actor entity
  $7149,$03 Call #R$70D2 to prepare the new sprite.
@ $714C label=DrawEntity_NoOldSprite
  $714C,$01 Switch to the shadow registers.
  $714D,$04 Write #N$00 to #R$5E25 (there are no lines of the old sprite to
. erase).
  $7151,$01 #REGc=#REGa.
  $7152,$03 Jump to #R$7170.

c $7155 Fetch Sprite
@ $7155 label=FetchSprite
D $7155 Finds the sprite for the sprite ID in the actor buffer (#R$5E22), or
. when entering at #R$7158 the sprite for the sprite ID in #REGa. The sprite
. data starts with the height in lines. Each line is two bytes.
E $7155 View the equivalent code in;
. #LIST
. { #COOKIE$7623 }
. { #LUNARJETMAN$8568 }
. { #UNDERWURLDE$9646 }
. LIST#
R $7155 O:DE Sprite
  $7155,$03 Fetch the sprite ID from the actor buffer (#R$5E22).
@ $7158 label=GetSprite
  $7158,$03 Work out the offset into the table of sprites.
  $715B,$02,b$01 Keep only bits 1-6.
  $715D,$03 #REGhl=#R$7F06.
  $7160,$03 Create an offset in #REGbc.
  $7163,$01 #REGhl=#R$7F06 + offset.
  $7164,$03 #REGde=fetch sprite address pointed to by #REGhl.
  $7167,$01 Return.

c $7168 Fetch Actor Sprite
@ $7168 label=FetchActorSprite
D $7168 Finds the sprite for the sprite ID of an actor.
E $7168 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$9652 }
. LIST#
R $7168 IX Actor entity
R $7168 O:DE Sprite
  $7168,$03 Load the sprite ID from the currently active actor.
  $716B,$02 Jump to #R$7158.

c $716D Erase Line Without Shift
@ $716D label=MaskSprite_Unshifted
D $716D Used by #R$7170 when the sprite is not shifted. Puts the screen address
. in #REGhl, keeping the sprite pointer on the stack, and carries on with the
. first byte of the line.
  $716D,$01 Swap #REGhl with the value on the stack.
  $716E,$02 Jump to #R$718F.

c $7170 Mask Sprite
@ $7170 label=MaskSprite
D $7170 Erases the old sprite and draws the new sprite, a line at a time going
. up the screen. One line of the old sprite is erased by clearing its bits from
. the screen, then one line of the new sprite is drawn, and so on until both are
. done. The old sprite is held in the normal registers and the new sprite in the
. shadow registers. In each set #REGc holds the number of lines left, #REGde the
. sprite data and #REGhl the screen address.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #POKES$5E05,$C0;$5E06,$0C;$5E08,$98;$5E09,$05
. #SIM(start=$6BFE,stop=$6C29,sp=$5E00)
. #SIM(start=$6010,stop=$7170,sp=$5E00)
. #SCR$04,$11,$11,$06,$05(mask-sprite-before)
. | #SIM(start=$7170,stop=$6FDD)
. #SCR$04,$11,$11,$06,$05(mask-sprite-after) } UDGTABLE# #POPS
E $7170 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$8A5C }
. LIST#
  $7170,$04 Jump to #R$71CB if there are no more lines of the old sprite.
  $7174,$01 Decrease the number of lines left by one.
  $7175,$01 Stash the screen address on the stack.
  $7176,$04 Fetch the number of pixels to shift by (#R$5E40) and keep the pixel
. shift in #REGb.
  $717A,$01 #REGhl=sprite data and #REGde=screen address.
  $717B,$01 Stash the screen address on the stack.
  $717C,$01 #REGd=the first byte of this line of the sprite.
  $717D,$01 Increment the sprite data pointer by one.
  $717E,$01 #REGe=the second byte of this line of the sprite.
  $717F,$01 Increment the sprite data pointer by one.
  $7180,$03 Jump to #R$716D if the sprite is not shifted.
  $7183,$01 #REGhl=sprite data and #REGde=this line of the sprite.
  $7184,$01 #REGa=#N$00.
@ $7185 label=MaskSprite_ShiftErase
  $7185,$01 Shift the line of the sprite left.
  $7186,$01 Rotate the bit that was shifted out into #REGa.
  $7187,$02 Decrease counter by one and loop back to #R$7185 until counter is
. zero.
  $7189,$01 #REGde=the shifted line of the sprite and #REGhl=sprite data.
  $718A,$01 #REGhl=screen address (the sprite data pointer goes on the stack).
  $718B,$01 Invert the bits of the first byte of the line.
  $718C,$01 Remove the bits from the screen.
  $718D,$01 Write the byte back to the screen.
  $718E,$01 Move onto the next screen byte.
@ $718F label=MaskSprite_EraseBytes
  $718F,$01 #REGa=#REGd.
  $7190,$01 Invert the bits.
  $7191,$01 Remove the bits from the screen.
  $7192,$01 Write the byte back to the screen.
  $7193,$01 Move onto the next screen byte.
  $7194,$01 #REGa=#REGe.
  $7195,$01 Invert the bits.
  $7196,$01 Remove the bits from the screen.
  $7197,$01 Write the byte back to the screen.
  $7198,$01 Restore the sprite data pointer from the stack.
  $7199,$01 Restore the screen address of the start of the line from the stack.
  $719A,$03 Call #R$6ECB to move up a line.
N $719D Now draw one line of the new sprite.
  $719D,$01 Switch to the shadow registers (the new sprite).
  $719E,$01 #REGa=#REGc.
  $719F,$03 Jump to #R$71C8 if there are no more lines of the new sprite.
@ $71A2 label=MaskSprite_Draw
  $71A2,$01 Decrease the number of lines left by one.
  $71A3,$01 Stash the screen address on the stack.
  $71A4,$04 Fetch the number of pixels to shift by (#R$5E41) and keep the pixel
. shift in #REGb.
  $71A8,$01 #REGhl=sprite data and #REGde=screen address.
  $71A9,$01 Stash the screen address on the stack.
  $71AA,$01 #REGd=the first byte of this line of the sprite.
  $71AB,$01 Increment the sprite data pointer by one.
  $71AC,$01 #REGe=the second byte of this line of the sprite.
  $71AD,$01 Increment the sprite data pointer by one.
  $71AE,$03 Jump to #R$71EA if the sprite is not shifted.
  $71B1,$01 #REGhl=sprite data and #REGde=this line of the sprite.
  $71B2,$01 #REGa=#N$00.
@ $71B3 label=MaskSprite_ShiftDraw
  $71B3,$01 Shift the line of the sprite left.
  $71B4,$01 Rotate the bit that was shifted out into #REGa.
  $71B5,$02 Decrease counter by one and loop back to #R$71B3 until counter is
. zero.
  $71B7,$01 #REGde=the shifted line of the sprite and #REGhl=sprite data.
  $71B8,$01 #REGhl=screen address (the sprite data pointer goes on the stack).
  $71B9,$01 Merge the first byte of the line with the screen.
  $71BA,$01 Write the byte back to the screen.
  $71BB,$01 Move onto the next screen byte.

c $71BC Draw Two Bytes
@ $71BC label=DrawTwoBytes
D $71BC Draws the last two bytes of a line of the new sprite and moves up a
. line.
  $71BC,$01 #REGa=#REGd.
  $71BD,$02 Merge the bits from #REGhl with #REGd and write the result back to
. #REGhl.
  $71BF,$01 Increment #REGl by one.
  $71C0,$01 #REGa=#REGe.
  $71C1,$02 Merge the bits from #REGhl with #REGe and write the result back to
. #REGhl.
  $71C3,$02 Restore #REGde and #REGhl from the stack.
  $71C5,$03 Call #R$6ECB.
@ $71C8 label=MaskSprite_Next
  $71C8,$01 Switch to the normal registers.
  $71C9,$02 Jump to #R$7170.

c $71CB Update Sprite Size
@ $71CB label=ActorUpdateSizeNext
D $71CB Used by #R$7170 when all of the lines of the old sprite have been
. erased. If there are lines of the new sprite left then they are drawn,
. otherwise the number of lines left of both sprites is updated, so that the
. lines which stick out can be handled.
  $71CB,$01 Switch to the shadow registers (the new sprite).
  $71CC,$01 #REGa=#REGc.
  $71CD,$01 Test the number of lines left.
  $71CE,$02 Jump to #R$71A2 if there are lines of the new sprite left to draw.
@ $71D0 label=ActorUpdateSizeFlipReg
  $71D0,$01 Switch to the normal registers.
@ $71D1 label=ActorUpdateSize
  $71D1,$04 Fetch the number of lines left of the old sprite (#R$5E25) and keep
. it in #REGc.
  $71D5,$03 Fetch the number of lines left of the new sprite (#R$5E26).
  $71D8,$01 Combine the lines left of the old sprite and the new sprite.
  $71D9,$01 Return if there are no lines left in either.
  $71DA,$04 Write #N$00 to #R$5E25.
  $71DE,$01 Switch to the shadow registers.
  $71DF,$04 Fetch the number of lines left of the new sprite (#R$5E26) and keep
. it in #REGc.
  $71E3,$01 Set #REGa to #N$00.
@ $71E4 label=ActorUpdateHeightAndMask
  $71E4,$03 Write the number of lines left of the new sprite to #R$5E26.
  $71E7,$01 Switch to the normal registers.
  $71E8,$02 Jump to #R$7170.

c $71EA Draw Line Without Shift
@ $71EA label=MaskSprite_DrawUnshifted
D $71EA Used by #R$7170 when the sprite is not shifted. Puts the screen address
. in #REGhl, keeping the sprite pointer on the stack, and draws the line.
  $71EA,$01 Swap #REGhl with the value on the stack.
  $71EB,$02 Jump to #R$71BC.

c $71ED Store Entity
@ $71ED label=StoreEntity
D $71ED Copies the position and the sprite ID of an actor into the actor buffer
. at #R$5E20, so that its sprite can be erased from there the next time it is
. drawn.
E $71ED View the equivalent code in;
. #LIST
. { #ATICATAC$9FFB }
. { #COOKIE$76D0 }
. { #JETPAC$7327 }
. { #PSSST$75B9 }
. { #SABREWULF$BB0B }
. { #UNDERWURLDE$989F }
. LIST#
R $71ED IX Actor entity
  $71ED,$06 Copy the X position of the actor to #R$5E20.
  $71F3,$06 Copy the Y position of the actor to #R$5E21.
  $71F9,$06 Copy the sprite ID of the actor to #R$5E22.
  $71FF,$01 Return.

c $7200 Reset Attribute Buffer
@ $7200 label=ResetAttributes
D $7200 Sets the border to black, clears the screen with #R$7211, then fills the
. attribute file with the background attribute at #R$5E44.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$5F07,stop=$5F29,clear=1,sp=$5E00)
. #SIM(start=$5FEF,stop=$6010,sp=$5E00)
. #SIM(start=$6010,stop=$6A87,sp=$5E00)
. #SCR$01(reset-attributes-before)
. | #SIM(start=$68BB,stop=$68BE)
. #SCR$01(reset-attributes-after) } UDGTABLE# #POPS
E $7200 View the equivalent code in;
. #LIST
. { #ATICATAC$80C2 }
. { #COOKIE$74E2 }
. { #JETPAC$71C6 }
. { #LUNARJETMAN$84BB }
. { #PSSST$7447 }
. { #SABREWULF$BB8F }
. LIST#
  $7200,$03 Set the border to #INK$00.
  $7203,$03 Call #R$7211.
  $7206,$03 Point #REGhl at the attribute buffer (#N$5800).
  $7209,$02 #REGb=#N$5B (i.e. finish once we reach the end of the attribute
. buffer).
  $720B,$04 Fetch the background attribute (#R$5E44) as the value to write.
  $720F,$02 Jump to #R$7218.

c $7211 Reset Screen Buffer
@ $7211 label=ResetScreen
D $7211 Clears the display file by filling it with #N$00. The screen attributes
. are left as they were.
E $7211 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE60 }
. { #ATICATAC$80B4 }
. { #COOKIE$74D4 }
. { #CYBERUN$9A7E }
. { #GUNFRIGHT$D6DB }
. { #JETPAC$71B8 }
. { #KNIGHTLORE$D544 }
. { #LUNARJETMAN$84AD }
. { #NIGHTSHADE$E5A8 }
. { #PSSST$7439 }
. { #SABREWULF$BB81 }
. LIST#
E $7211 Continue on to #R$7218 to blank the screen buffer.
  $7211,$03 #REGhl=#N$4000 (screen buffer).
  $7214,$02 #REGb=#N$58 (i.e. finish once we reach the start of the attribute
. buffer).
  $7216,$02 #REGc=#N$00 (value to write).

c $7218 Fill Memory
@ $7218 label=ResetCopier
E $7218 View the equivalent code in;
. #LIST
. { #ATICATAC$80BB }
. { #COOKIE$74DB }
. { #JETPAC$71BF }
. { #LUNARJETMAN$84B4 }
. { #PSSST$7440 }
. { #SABREWULF$BB88 }
. LIST#
R $7218 HL Target address
R $7218 B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $7218 C Value to write
  $7218,$01 Write #REGc to the target address.
  $7219,$01 Increment the target address by one.
  $721A,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $721C,$02 Keep looping back to #R$7218 until there is no carry-over.
  $721E,$01 Return.

w $721F Cup Table
@ $721F label=CupTable
D $721F Links to the entry in #R$7811 for every cup. The Y position of each cup
. is chosen at random when a round starts (see #R$6498).
  $721F,$02 Cup #N($01 + (#PC - $721F) / $02).
L $721F,$02,$08

t $722F Messaging: Place Names
@ $722F label=PlaceNames
D $722F The names of the places that can be visited. A place on the map has bit
. 6 of its sprite ID set and the rest of the ID is the number of its name in
. this list (see #R$64F0). The last character of each name has bit 7 set.
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
@ $7352 label=Sprite_Cactus
D $7352 The sprite of a cactus (sprite IDs #N$01 and #N$08). The first byte is
. the height in lines; each line is then two bytes.
  $7352,$01 Height = #N(#PEEK(#PC)) pixels.
  $7353,$20,b$02 #SPRITE$00(cactus)

b $7373 Sprite: USA Sign
@ $7373 label=Sprite_USA_Sign
D $7373 The sprite of a USA sign (sprite IDs #N$02 and #N$09). The first byte is
. the height in lines; each line is then two bytes.
  $7373,$01 Height = #N(#PEEK(#PC)) pixels.
  $7374,$20,b$02 #SPRITE$01(sign)

b $7394 Sprite: Flower
@ $7394 label=Sprite_Flower
D $7394 The sprite of a flower (sprite IDs #N$04 and #N$0B). The first byte is
. the height in lines; each line is then two bytes.
  $7394,$01 Height = #N(#PEEK(#PC)) pixels.
  $7395,$20,b$02 #SPRITE$03(flower)

b $73B5 Sprite: Boulder
@ $73B5 label=Sprite_Boulder
D $73B5 The sprite of a boulder (sprite IDs #N$05 and #N$0C). The first byte is
. the height in lines; each line is then two bytes.
  $73B5,$01 Height = #N(#PEEK(#PC)) pixels.
  $73B6,$1E,b$02 #SPRITE$04(boulder)

b $73D4 Sprite: Tree
@ $73D4 label=Sprite_Tree
D $73D4 The sprite of a tree (sprite IDs #N$06 and #N$0D). The first byte is the
. height in lines; each line is then two bytes.
  $73D4,$01 Height = #N(#PEEK(#PC)) pixels.
  $73D5,$20,b$02 #SPRITE$05(tree)

b $73F5 Sprite: Fuel Pump
@ $73F5 label=Sprite_Fuel_Pump
D $73F5 The sprite of a fuel pump (sprite ID #N$07), which is used to mark the
. places that the car can refuel at. The first byte is the height in lines; each
. line is then two bytes.
  $73F5,$01 Height = #N(#PEEK(#PC)) pixels.
  $73F6,$20,b$02 #SPRITE$06(fuel-pump)

b $7416 Sprite: Pylon
@ $7416 label=Sprite_Pylon
D $7416 The sprite of a pylon (sprite ID #N$0E). The first byte is the height in
. lines; each line is then two bytes.
  $7416,$01 Height = #N(#PEEK(#PC)) pixels.
  $7417,$20,b$02 #SPRITE$0D(pylon)

b $7437 Sprite: Tombstone
@ $7437 label=Sprite_Tombstone
D $7437 The sprite of a tombstone (sprite ID #N$0F), which an object is changed
. to when the car hits it. The first byte is the height in lines; each line is
. then two bytes.
  $7437,$01 Height = #N(#PEEK(#PC)) pixels.
  $7438,$20,b$02 #SPRITE$0E(tombstone)

b $7458 Sprite: Bush
@ $7458 label=Sprite_Bush
D $7458 The sprite of a bush (sprite IDs #N$03 and #N$0A). The first byte is the
. height in lines; each line is then two bytes.
  $7458,$01 Height = #N(#PEEK(#PC)) pixels.
  $7459,$1A,b$02 #SPRITE$02(bush)

b $7473 Sprite: Explosion
@ $7473 label=Sprite_Explosion_1
D $7473 The two frames of the explosion when the car is destroyed (sprite IDs
. #N$21 and #N$22). The first byte is the height in lines; each line is then two
. bytes.
E $7473 #FRAMES(explosion-01,$05;explosion-02)(explosion-frames)
N $7473 Frame #N$01
  $7473,$01 Height = #N(#PEEK(#PC)) pixels.
  $7474,$20,b$02 #SPRITE$20(explosion-01*)
N $7494 Frame #N$02
@ $7494 label=Sprite_Explosion_2
  $7494,$01 Height = #N(#PEEK(#PC)) pixels.
  $7495,$1C,b$02 #SPRITE$21(explosion-02*)

b $74B1 UDG Graphics
@ $74B1 label=UDG_Tiles
D $74B1 The #N$3C tiles that the sidebar is drawn with by #R$69BC. Each tile is
. #N$08 bytes.
N $74B1 Tile ID: "#N(#EVAL((#PC - $74B1) / $08))".
  $74B1,b$08,$01 #UDG(#PC)
L $74B1,$08,$3C

b $7691 Sidebar Layout
@ $7691 label=SidebarLayoutData
D $7691 The tile number for each of the #N$08 columns and #N$18 rows of the
. sidebar, which is drawn by #R$69BC.
  $7691,$08 #FOR($00,$07)||n|#UDG($74B1 + #PEEK(#PC + n) * $08)||
L $7691,$08,$18

b $7751 Sidebar Attributes
@ $7751 label=SidebarAttributes
D $7751 The attribute for each of the #N$08 columns and #N$18 rows of the
. sidebar, which is drawn by #R$69BC.
  $7751,$08 #FOR($00,$07)||n|#UDG($74B1 + #PEEK(n + #PC - $C0) * $08,attr=#PEEK(#PC + n))||
L $7751,$08,$18

b $7811 Map Points
@ $7811 label=MapPoints
D $7811 The obstacles, cups and places on the map, in order of their X position.
. Each is three bytes: the X position (in units of #N$20 map units), the Y
. position (in units of #N$10 map units) and the sprite ID. A sprite ID of #N$20
. is a cup (which is changed to #N$60 when it is collected) and one with bit 6
. set is the name of a place. See #R$6B47.
  $7811,$03 Map Point #N((#PC - $7811) / $03, $03, $03): #SPRITENAME(#PEEK(#PC + $02) - $01).
L $7811,$03,$197

b $7CD6 Sprite: Car
@ $7CD6 label=Sprite_Car_1
D $7CD6 The car in each of the #N$10 directions it can face, going clockwise
. from straight up (sprite IDs #N$10 to #N$1F). The first byte is the height in
. lines; each line is then two bytes.
E $7CD6 #FRAMES(car-01,10;car-02;car-03;car-04;car-05;car-06;car-07;car-08;car-09;car-0A;car-0B;car-0C;car-0D;car-0E;car-0F;car-10)(car-ani)
N $7CD6 Frame #N$01.
  $7CD6,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CD7,$22,b$02 #CAR$00(car-01*)

N $7CF9 Frame #N$02.
@ $7CF9 label=Sprite_Car_2
  $7CF9,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CFA,$22,b$02 #CAR$01(car-02*)

N $7D1C Frame #N$03.
@ $7D1C label=Sprite_Car_3
  $7D1C,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D1D,$22,b$02 #CAR$02(car-03*)

N $7D3F Frame #N$04.
@ $7D3F label=Sprite_Car_4
  $7D3F,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D40,$22,b$02 #CAR$03(car-04*)

N $7D62 Frame #N$05.
@ $7D62 label=Sprite_Car_5
  $7D62,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D63,$22,b$02 #CAR$04(car-05*)

N $7D85 Frame #N$06.
@ $7D85 label=Sprite_Car_6
  $7D85,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D86,$22,b$02 #CAR$05(car-06*)

N $7DA8 Frame #N$07.
@ $7DA8 label=Sprite_Car_7
  $7DA8,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DA9,$22,b$02 #CAR$06(car-07*)

N $7DCB Frame #N$08.
@ $7DCB label=Sprite_Car_8
  $7DCB,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DCC,$22,b$02 #CAR$07(car-08*)

N $7DEE Frame #N$09.
@ $7DEE label=Sprite_Car_9
  $7DEE,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DEF,$22,b$02 #CAR$08(car-09*)

N $7E11 Frame #N$0A.
@ $7E11 label=Sprite_Car_10
  $7E11,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E12,$22,b$02 #CAR$09(car-0A*)

N $7E34 Frame #N$0B.
@ $7E34 label=Sprite_Car_11
  $7E34,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E35,$22,b$02 #CAR$0A(car-0B*)

N $7E57 Frame #N$0C.
@ $7E57 label=Sprite_Car_12
  $7E57,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E58,$22,b$02 #CAR$0B(car-0C*)

N $7E7A Frame #N$0D.
@ $7E7A label=Sprite_Car_13
  $7E7A,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E7B,$22,b$02 #CAR$0C(car-0D*)

N $7E9D Frame #N$0E.
@ $7E9D label=Sprite_Car_14
  $7E9D,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E9E,$22,b$02 #CAR$0D(car-0E*)

N $7EC0 Frame #N$0F.
@ $7EC0 label=Sprite_Car_15
  $7EC0,$01 Height = #N(#PEEK(#PC)) pixels.
  $7EC1,$22,b$02 #CAR$0E(car-0F*)

N $7EE3 Frame #N$10.
@ $7EE3 label=Sprite_Car_16
  $7EE3,$01 Height = #N(#PEEK(#PC)) pixels.
  $7EE4,$22,b$02 #CAR$0F(car-10*)

w $7F06 Sprite Table
@ $7F06 label=SpritesTable
D $7F06 The address of the sprite for each sprite ID, in order from #N$01. The
. objects on the map use #N$01 to #N$0F, and #N$08 to #N$0D have the same
. sprites as #N$01 to #N$06.
E $7F06 View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #LUNARJETMAN$BAC0 }
. { #PSSST$761A }
. { #SABREWULF$BF84 }
. LIST#
  $7F06,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100)(#N((#PC - $7F06) / $02)) #SPRITENAME((#PC - $7F06) / $02).
L $7F06,$02,$0F

w $7F24 Player Sprite Table
@ $7F24 label=PlayerSpriteTable
D $7F24 The address of the sprite of the car for each of the #N$10 directions
. (sprite IDs #N$10 to #N$1F), which #R$6A39 chooses from.
  $7F24,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100)(#N((#PC - $7F24) / $02)) #CARNAME((#PC - $7F24) / $02).
L $7F24,$02,$10

w $7F44 Sprites Table #N$02
@ $7F44 label=SpritesTable2
D $7F44 This isn't a separate table; it's a continuation of #R$7F06 just, the player sprites have a "special" zero-based
.       reference of their own.
  $7F44,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100)(#N((#PC - $7F06) / $02)) #SPRITENAME((#PC - $7F06) / $02).
L $7F44,$02,$03

b $7F4A Sprite: Cup
@ $7F4A label=Sprite_Cup
D $7F4A The sprite of a cup (sprite ID #N$20). The first byte is the height in
. lines; each line is then two bytes.
  $7F4A,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F4B,$20,b$02 #SPRITE$1F(cup)

b $7F6B Movement Table
@ $7F6B label=MovementTable
D $7F6B A quarter of a cosine curve in #N$20 steps. #R$6D73 uses it to share out
. the speed between the Y and X directions: the Y part reads it from the start
. and the X part reads it from the end.
B $7F6B,$1F,$08
@ $7F8A label=MovementTable_Last
B $7F8A,$01 The last value, which is the first one that the X part reads.

t $7F8B Messaging: Copyright
@ $7F8B label=Text_Copyright
D $7F8B A copyright message, which is not used by the game.
  $7F8B,$29 "COPYRIGHT 1983 A.C.G. ALL RIGHTS RESERVED".

b $7FB4 Unused Bytes
@ $7FB4 label=Unused_Bytes
D $7FB4 Bytes that the game does not use. They look like what is left of an
. earlier version of the game: a copy of #R$71ED which stores to different
. addresses, then a copy of #R$6F10 and then some addresses.
B $7FB4,$04
B $7FB8,$13
B $7FCB,$1F
W $7FEA,$16,$02

i $8000
b $B868
i $B869
