; Copyright Ashby Computers & Graphics Ltd 1983, Rare Ltd, 2026 ArcadeGeek LTD.
> $4000 @org=$4000
> $4000 @start=$5B80
> $4000 @expand=#DEF(#POKE()(anchor,text) #LINK(Pokes#$anchor)($text))
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))
> $4000 @set-handle-unsupported-macros=1
b $4000 Loading screen
@ $4000 label=Loading
D $4000 #UDGTABLE { =h Lunar Jetman Loading Screen } { #SCR$02(loading) } UDGTABLE#
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

c $5B80 Decryption Routine
@ $5B80 label=GameEntry
D $5B80 Decrypts the game by running RRD on every byte from
. #N$7FFF up to #N($FBFE), then jumps to #R$8000.
E $5B80 View the equivalent code in #ATICATAC$5B80.
E $5B80 Earlier Ultimate games use a much simpler mechanism;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #PSSST$5B80 }
. { #TRANZAM$5B80 }
. LIST#
N $5B80 Decrypt every byte from #N$7FFF upwards.
  $5B80,$03 Set the start address to #N$7FFF.
  $5B83,$03 Set #REGb to #N$00 so each inner pass covers one
. page, and #REGc to #N$7C pages.
  $5B86,$01 Reset the flags.
@ $5B87 label=Decryption_Loop
  $5B87,$02 Rotate the current byte right through the accumulator.
  $5B89,$01 Move onto the next byte.
  $5B8A,$02 Decrease #REGb by one and loop back to #R$5B87
. until this page is done.
  $5B8C,$01 Decrease the page count by one.
  $5B8D,$02 Loop back to #R$5B87 until every page is decrypted.
@ $5B8F label=GameEntry_Jump
  $5B8F,$03 Jump to #R$8000.

i $5B92

c $5CB0 Indirect Jump
@ $5CB0 label=IndirectJump
D $5CB0 Jumps to the handler address already held in #REGhl.
R $5CB0 HL Jump address
  $5CB0,$01 Jump to the address held in #REGhl.

i $5CB1

g $5E00 Game Options
@ $5E00 label=GameOptions
D $5E00 Holds the number of players and the chosen control method.
. Bit #N$00 is the player count, bits #N$01-#N$02 are the control method.
. #TABLE(default,centre,centre)
. { =h Bits 1-2 | =h Control Method }
. { #N$00 | Keyboard }
. { #N$02 | Kempston Joystick }
. { #N$04 | Cursor Joystick }
. TABLE#
. Bit #N$00 is reset for a 1UP game, or set for a 2UP game.
B $5E00,$01

u $5E01 Unused
@ $5E01 label=Unused_After_Game_Options
D $5E01 Cleared by #R$800A; not referenced by the game.

g $5E04 Font Pointer
@ $5E04 label=FontPointer
D $5E04 Holds a pointer to the currently used font data.
W $5E04,$02

g $5E06 High Score
@ $5E06 label=High_Score
D $5E06 3-byte representation of the score.
E $5E06 View the equivalent code in;
. #LIST
. { #COOKIE$5F09 }
. { #JETPAC$5CF0 }
. { #PSSST$5E00 }
. LIST#

g $5E09 High Score Table
@ $5E09 label=High_Score_Table
D $5E09 Remaining 3-byte scores which follow #R$5E06. #R$9C23 copies
. #R$9D98 over this whole table on initialisation.

g $5E20 Hall Of Fame Names
@ $5E20 label=HallOfFame_Names
D $5E20 Eight 3-letter names. #R$9C23 copies #R$9D80 here;
. #R$F410 prints them beside the scores at #R$5E06. The
. eighth name occupies #R$5E35.

g $5E35 Hall Of Fame Last Name
@ $5E35 label=HallOfFame_LastName
D $5E35 Eighth name slot. #R$F345 uses it as the LDDR source
. when opening a gap in the name table.

g $5E38 Hall Of Fame Name End
@ $5E38 label=HallOfFame_NameEnd
D $5E38 Byte after the name table. #R$F345 uses it as the LDDR
. destination.

g $5E40 Random Number
@ $5E40 label=RandomNumber
D $5E40 Updated each game loop by adding a ROM byte, addressed by the
. low byte of #R$5E42, to itself.
E $5E40 View the equivalent code in #JETPAC$5DCE.

g $5E42 Game Timer
@ $5E42 label=GameTimer
D $5E42 Incremented once per game loop. The low byte indexes ROM when
. refreshing #R$5E40.
E $5E42 View the equivalent code in #JETPAC$5DCC.

g $5E50 Planet Data
@ $5E50 label=PlanetData
D $5E50 Start of the in-play object RAM that #R$81BB clears up to
. #R$6000.

g $5E52 Frame Updated
@ $5E52 label=FrameUpdated
D $5E52 Has the frame been updated? #TABLE(default,centre,centre) { #N$00 | No } { #N$01 | Yes } TABLE#
  $5E52,$01

g $5E53 Last Frame
@ $5E53 label=LastFrame
D $5E53 Holds a copy of the last #SKOOLKID$5C78(FRAMES) counter.
  $5E53,$01

g $5E56 Sprite Cached Y
@ $5E56 label=SpriteCachedY
D $5E56 Working copy of the actor's cached Y position (*#REGix+#N$0B),
. compared with the new Y when a sprite is redrawn. #R$88E8 uses it to
. hold the high byte of the cached screen address instead.

g $5E57 Sprite Width
@ $5E57 label=SpriteWidth
D $5E57 Width in character columns of the sprite being drawn. #R$8733
. uses it as the column count when colouring the sprite.

g $5E58 Sprite Height
@ $5E58 label=SpriteHeight
D $5E58 Height in pixel rows of the sprite being drawn, kept so #R$8733
. can work out how many attribute rows to colour.

g $5E59 Sprite Rows Left
@ $5E59 label=SpriteRowsLeft
D $5E59 Rows of the new sprite image still to be drawn.

g $5E5A Sprite Cached Rows
@ $5E5A label=SpriteCachedRows
D $5E5A Rows of the old (cached) sprite image still to be erased. It is
. copied from *#REGix+#N$0A and counted down while a sprite is redrawn.

g $5E5D Space Key Latch
@ $5E5D label=SpaceKeyLatch
D $5E5D Set to #N$01 by #R$933E when SPACE is first pressed, so holding
. the key only counts once. Cleared again when SPACE is released.

g $5E5E Alien Count
@ $5E5E label=AlienCount
D $5E5E Number of live aliens this frame. #R$8287 asks #R$9466 to spawn
. another while this is less than #N$07.

g $5E5F 1UP Score
@ $5E5F label=1UP_Score_1
D $5E5F 3-byte representation of the score.
  $5E5F,$01 Byte #1.
@ $5E60 label=1UP_Score_2
  $5E60,$01 Byte #2.
@ $5E61 label=1UP_Score_3
  $5E61,$01 Byte #3.

g $5E62 2UP Score
@ $5E62 label=2UP_Score_1
D $5E62 3-byte representation of the score.
  $5E62,$01 Byte #1.
@ $5E63 label=2UP_Score_2
  $5E63,$01 Byte #2.
@ $5E64 label=2UP_Score_3
  $5E64,$01 Byte #3.

g $5E65 Active Player
@ $5E65 label=Flag_ActivePlayer
D $5E65 Which player is currently active.
. #TABLE(default,centre,centre) { =h Value | =h Player }
. { #N$00 | 1UP }
. { #N$FF | 2UP }
. TABLE#

g $5E66 Current menu item colour attribute
@ $5E66 label=Current_MenuAttribute
D $5E66 Attribute of the menu line currently being printed. #R$81AB
. fetches it when printing a line.
  $5E66,$01

g $5E67 Game Delay Timer
@ $5E67 label=GameDelayTimer
D $5E67 At the beginning of each player turn there is a delay
. to allow the player to be ready for play.
. #TABLE(default,centre,centre)
. { =h Value | =h Game Mode }
. { #N$40 | 1UP }
. { #N$7F | 2UP }
. TABLE#
. The larger delay for a 2UP game is useful for swapping players controls.

g $5E68 Teleport Restore
@ $5E68 label=TeleportRestore
D $5E68 Set to #N$01 once a teleport has been set up. #R$81D6 then
. calls #R$A2CF to finish it with a debris burst, clearing the flag.

g $5E69 Debris Count
@ $5E69 label=DebrisCount
D $5E69 Number of explosion particles still moving. The debris
. handlers loop until this returns to #N$00.

g $5E6A Debris Y
@ $5E6A label=Debris_Y
D $5E6A Working Y used when filling explosion particles.
B $5E6A,$01

g $5E6C Player Inactive
@ $5E6C label=PlayerInactive
D $5E6C Non-zero while Jetman is dying, teleporting or otherwise not
. in play. Handlers return early and the game loop restarts at
. #R$81D6.

g $5E6D Hall Of Fame Timer
@ $5E6D label=HallOfFame_Timer
D $5E6D Countdown used by the hall of fame input loop.

g $5E6F Hall Of Fame Index
@ $5E6F label=HallOfFame_Index
D $5E6F Current character position while entering a name.

g $5E70 Hall Of Fame Fire Lock
@ $5E70 label=HallOfFame_FireLock
D $5E70 Set after fire accepts a letter so the same press cannot
. advance again.

g $5E71 High Score Player
@ $5E71 label=HighScore_Player
D $5E71 Which player's score is being ranked: #N$01 for 1UP, #N$02 for
. 2UP.

g $5E72 High Score Other Player
@ $5E72 label=HighScore_OtherPlayer
D $5E72 Non-zero while the other player's score still needs to be
. ranked after this insert.

g $5E73 High Score Done
@ $5E73 label=HighScore_Done
D $5E73 Set to #N$01 when name entry starts for the first-ranked player
. and cleared by #R$F33E. Nothing reads it.

g $5E74 High Score Player Copy
@ $5E74 label=HighScore_PlayerCopy
D $5E74 Insert flag for #R$F3BF. Non-zero (set from #R$5E71) makes it
. also insert the score into the table; #N$00 only returns the rank.

g $5E75 Hall Of Fame Pointer
@ $5E75 label=HallOfFame_Pointer
D $5E75 Screen address where the letter being edited is printed. It
. advances by two columns after each letter is accepted.

g $5E77 High Score Position
@ $5E77 label=HighScorePosition
D $5E77 Used when calculating the player's position in the high score table.
  $5E77,$01

g $5E78 Hall Of Fame Name
@ $5E78 label=HallOfFame_Name
D $5E78 Three-letter name being entered. #R$F535 seeds it as
. "AAA"; #R$F345 copies it into the name table.
B $5E78,$03

g $5E7B Debris Pitch
@ $5E7B label=Debris_Pitch
D $5E7B Working pitch. #R$B8F2 plays three clicks from this
. byte; the debris handlers increment or decrement it.
B $5E7B,$01

g $5E7C Previous Game Options
@ $5E7C label=PreviousGameOptions
D $5E7C Copy of #R$5E00 from the last menu pass, used to notice when
. the selection has changed.

g $5EA0 Active Player Level
@ $5EA0 label=ActivePlayer_Level
D $5EA0 Level of the active player. A value of #N($FF) is treated as
. level #N$00 when #R$F641 converts it to two digits. Swapped with
. #R$5EA4 by #R$A880.
B $5EA0,$01

g $5EA1 Active Player Lives
@ $5EA1 label=ActivePlayer_Lives
D $5EA1 Lives the active player has left. Swapped with #R$5EA5 by
. #R$A880.
N $5EA1 See #POKE(255_lives,255 Lives).
N $5EA1 See #POKE(infinite_lives,Infinite Lives).
B $5EA1,$01

g $5EA2 Level Parity
@ $5EA2 label=LevelParity
D $5EA2 Bit #N$00 of the current level. #R$8568 and #R$857F test it to
. decide whether to remap the sprite ID with #R$853D.

g $5EA3 Rover Cargo Flag
@ $5EA3 label=RoverCargoFlag
D $5EA3 #N$00 when the rover is empty, #N$01 when an object is attached
. to it.

g $5EA4 Inactive Player Level
@ $5EA4 label=InactivePlayer_Level
D $5EA4 Level of the inactive player. A value of #N($FF) is treated as
. level #N$00 when #R$F658 converts it to two digits. Swapped with
. #R$5EA0 by #R$A880.
B $5EA4,$01

g $5EA5 Inactive Player Lives
@ $5EA5 label=InactivePlayer_Lives
D $5EA5 Lives the inactive player has left. Swapped with #R$5EA1 by
. #R$A880.
N $5EA5 See #POKE(255_lives,255 Lives).
B $5EA5,$01

g $5EA6 Inactive Level Parity
@ $5EA6 label=InactivePlayer_LevelParity
D $5EA6 Copy of #R$5EA2 swapped in by #R$A880.
B $5EA6,$01

g $5EA7 Inactive Rover Cargo Flag
@ $5EA7 label=InactivePlayer_RoverCargoFlag
D $5EA7 Copy of #R$5EA3 swapped in by #R$A880.
B $5EA7,$01

u $5EA8 Unused
@ $5EA8 label=Unused_After_Player_State
D $5EA8 Not referenced by the game.

g $6000 Laser Beam Parameters
@ $6000 label=Laser_Parameter_1
D $6000 Four #N$18-byte actor slots for the laser beams, in the same
. field order as #R$6078. They are the first of the #N$18 actor slots, which
. run up to #R$6240. Every slot is laid out the same way:
. #TABLE(default,centre,left)
. { =h Offset | =h Contents }
. { #N$00 | Type (the sprite ID) }
. { #N$01 | Screen column }
. { #N$02-#N$03 | World X }
. { #N$04 | Y }
. { #N$05 | Horizontal speed }
. { #N$06 | Vertical thrust }
. { #N$07 | Colour }
. { #N$08 | Flags }
. { #N$09-#N$0F | Sprite cache, cleared by #R$A2F5 }
. { #N$10-#N$17 | State specific to the actor type }
. TABLE#
E $6000 View the equivalent code in;
. #LIST
. { #JETPAC$5D08 }
. LIST#
B $6000,$18 Laser Beam #1.
@ $6018 label=Laser_Parameter_2
B $6018,$18 Laser Beam #2.
@ $6030 label=Laser_Parameter_3
B $6030,$18 Laser Beam #3.
@ $6048 label=Laser_Parameter_4
B $6048,$18 Laser Beam #4.

g $6060 Explosion Slot
@ $6060 label=Explosion_Slot
D $6060 #N$18-byte actor slot. #R$B950 copies explosion
. templates here.
B $6060,$14
@ $6074 label=Explosion_Slot_Timer
B $6074,$04

g $6078 Jetman Slot
@ $6078 label=Jetman_Slot
D $6078 #N$18-byte actor slot for Jetman. The last two
. bytes are the fuel pair at #R$608E.
B $6078,$02
@ $607A label=Jetman_Position
W $607A,$02
@ $607C label=Jetman_Y
B $607C,$01
@ $607D label=Jetman_Speed
B $607D,$02
N $607F Copied from #R$6097 when boarding the rover.
@ $607F label=Jetman_Board_Copy
B $607F,$01
@ $6080 label=Jetman_Flags
B $6080,$08
B $6088,$06

g $608E Fuel Level
@ $608E label=FuelLevel_1
@ $608F label=FuelLevel_2
D $608E 16-bit fuel remaining. #R$9020 initialises it to
. #N$9000.
N $608E See #POKE(infinite_fuel,Infinite Fuel).
  $608E,$02,$01

g $6090 Rover Slot
@ $6090 label=Rover_Slot
D $6090 #N$18-byte actor slot for the moon rover.
B $6090,$01 Type.
@ $6092 label=Rover_Position
B $6092,$05
N $6097 Copied to #R$607F when boarding the rover.
@ $6097 label=Rover_Board_Copy
B $6097,$09
B $60A0,$08

g $60A8 World Slots
@ $60A8 label=World_Slot_1
D $60A8 Four #N$18-byte actor slots before #R$6108.
. The fields follow the same order as #R$6078.
. #R$B4C2 fills debris from here.
N $60A8 Slot 1.
. Seeking aliens attach to this object. Collecting any
. later world object teleports Jetman here.
B $60A8,$01 Type.
B $60A9,$01 Screen column.
@ $60AA label=World_Slot_1_Position
W $60AA,$02 World X.
@ $60AC label=World_Slot_1_Y
B $60AC,$01 Y position.
B $60AD,$01 Horizontal speed.
B $60AE,$01 Vertical thrust.
B $60AF,$01 Colour.
@ $60B0 label=World_Slot_1_Flags
B $60B0,$01 Flags.
B $60B1,$0F Remaining actor bytes.
N $60C0 Slot 2.
. Collecting slot 1 teleports Jetman here. #R$9884 tests
. whether a seeking alien is beside this object.
@ $60C0 label=World_Slot_2
B $60C0,$01 Type.
B $60C1,$01 Screen column.
@ $60C2 label=World_Slot_2_Position
W $60C2,$02 World X.
@ $60C4 label=World_Slot_2_Y
B $60C4,$01 Y position.
B $60C5,$01 Horizontal speed.
B $60C6,$01 Vertical thrust.
B $60C7,$01 Colour.
@ $60C8 label=World_Slot_2_Flags
B $60C8,$01 Flags.
B $60C9,$0F Remaining actor bytes.
N $60D8 Slot 3.
. Third world-object slot. Written as type #N$C0 when a
. missile reaches the player.
@ $60D8 label=World_Slot_3
B $60D8,$01 Type.
B $60D9,$01 Screen column.
@ $60DA label=World_Slot_3_Position
W $60DA,$02 World X.
@ $60DC label=World_Slot_3_Y
B $60DC,$01 Y position.
B $60DD,$01 Horizontal speed.
B $60DE,$01 Vertical thrust.
B $60DF,$01 Colour.
@ $60E0 label=World_Slot_3_Flags
B $60E0,$01 Flags.
B $60E1,$0F Remaining actor bytes.
N $60F0 Slot 4.
. Holds the platform (type #N$2E) that Jetman picks up when the
. action key is pressed beside the rover, if this slot is free.
@ $60F0 label=World_Slot_4
B $60F0,$01 Type.
B $60F1,$01 Screen column.
@ $60F2 label=World_Slot_4_Position
W $60F2,$02 World X.
@ $60F4 label=World_Slot_4_Y
B $60F4,$01 Y position.
B $60F5,$01 Horizontal speed.
B $60F6,$01 Vertical thrust.
B $60F7,$01 Colour.
@ $60F8 label=World_Slot_4_Flags
B $60F8,$01 Flags.
B $60F9,$0F Remaining actor bytes.

g $6108 Object Slots
@ $6108 label=Object_Slot_1
D $6108 Five #N$18-byte slots. #R$B1D3 starts its scan here.
B $6108,$18 Slot 1.
@ $6120 label=Object_Slot_2
B $6120,$18 Slot 2.
@ $6138 label=Object_Slot_3
B $6138,$02 Slot 3.
@ $613A label=Object_Slot_3_Position
W $613A,$02
@ $613C label=Object_Slot_3_Y
B $613C,$14
@ $6150 label=Object_Slot_4
B $6150,$18 Slot 4.
@ $6168 label=Object_Slot_5
B $6168,$17 Slot 5.
@ $617F label=Missile_Launcher_Countdown
B $617F,$01 Slot 5 missile launcher countdown.

g $6180 Alien Base Slot
@ $6180 label=AlienBase_Slot
D $6180 #N$18-byte actor slot for the alien base, before the bomb slot.
. #R$6182 is its world X position and #R$6184 its Y position.
B $6180,$02
@ $6182 label=AlienBase_WorldX
W $6182,$02
B $6184,$11
@ $6195 label=Missile_Destroyed_Flag
B $6195,$03

g $6198 Bomb Slot
@ $6198 label=Bomb_States
D $6198 #N$18-byte actor slot for the thrown bomb. #R$B731 copies the
. bomb template here when the slot is empty.
B $6198,$08,$01

g $61B0 Alien States
@ $61B0 label=Alien_Slot_1
D $61B0 There are a maximum of 6 aliens on the screen at one
. time. Each slot is #N$18 bytes and uses the same field
. order as #R$6078.
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h Byte | =h State | =h Byte | =h State | =h Byte | =h State }
. { #N$00 | Type | #N$08 | Flags | #N$10 | Explode flag }
. { #N$01 | Screen column | #N$09 | Pixel shift | #N$11 | Animation
. timer }
. { #N$02 | World X (low) | #N$0A | Cached height | #N$12 | X wobble speed }
. { #N$03 | World X (high) | #N$0B | Cached Y or width | #N$13 | X wobble }
. { #N$04 | Y position | #N$0C | Graphic low | #N$14 | Y wobble
. speed }
. { #N$05 | Horizontal speed | #N$0D | Graphic high | #N$15 | Y
. wobble }
. { #N$06 | Vertical thrust | #N$0E | Screen low | #N$16 | Extra X
. speed }
. { #N$07 | Colour | #N$0F | Screen high | #N$17 | Age }
. TABLE#
B $61B0,$18 Slot 1.
@ $61C8 label=Alien_Slot_2
B $61C8,$18 Slot 2.
@ $61E0 label=Alien_Slot_3
B $61E0,$18 Slot 3.
@ $61F8 label=Alien_Slot_4
B $61F8,$18 Slot 4.
@ $6210 label=Alien_Slot_5
B $6210,$18 Slot 5.
@ $6228 label=Alien_Slot_6
B $6228,$18 Slot 6.

g $6240 Actor List End
@ $6240 label=Actor_List_End
D $6240 First address after the last actor slot, where object walks stop.
. It also starts the #N($0120,$04,$04) bytes where #R$A880 stores the
. inactive player's actor slots.
B $6240,$01

i $6241

b $7000 Active Terrain Data
@ $7000 label=TerrainData_Active
  $7000,$400,$10

b $7400 Inactive Terrain Data
@ $7400 label=TerrainData_Inactive
  $7400,$400,$10

i $7800

c $8000 Security Check
@ $8000 label=SecurityCheck
D $8000 A short copy-protection test on the FRAMES timer. The
. game continues into #R$800A when the check passes.
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
  $8000,$01 Disable interrupts.
  $8001,$03 Set the stack pointer to #R$5E00.
  $8004,$03 #REGa=#SKOOLKID$5C78(FRAMES)+#N$01.
  $8007,$03 Return if the timer is not #N$83.

c $800A Game Initialisation
@ $800A label=GameInitialisation
D $800A Clears game RAM, installs the font, writes the default
. scores and queues the briefing tune before entering the menu
. loop.
E $800A View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #COOKIE$6298 }
. { #JETPAC$61EB }
. { #PSSST$61CD }
. { #SABREWULF$9960 }
. { #TRANZAM$5F07 }
. LIST#
@ $8010 label=GameInitialisation_Loop
N $800A Clear every game variable.
  $800A,$0E Write #N$00 to #N$2200 bytes starting from #R$5E00.
N $8018 Use the custom font.
  $8018,$06 Write #R$D347 to #R$5E04.
N $801E Set the default scores and draw the menu window.
  $801E,$03 Call #R$9C23.
  $8021,$03 Call #R$84D8.
N $8024 Queue the briefing tune and enter the menu loop.
  $8024,$03 Set the tune pointer to #R$BA2A.
  $8027,$03 Queue the briefing tune.
  $802A,$02 Jump to #R$8035.

c $802C Game Restart
@ $802C label=Game_Restart
D $802C Rebuilds the menu window, shows the hall of fame, then
. loops on the game selection keys until "6" starts a game.
  $802C,$03 Call #R$84D8.
  $802F,$03 Call #R$F410.
  $8032,$03 Call #R$84D8.
@ $8035 label=GameSelect_Loop
N $8035 Draw the menu, then read keys "1"-"5".
  $8035,$03 Call #R$80D1.
  $8038,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $803E,$01 Flip the bits.
  $803F,$01 Store the key bits for the tests below.
  $8040,$06 Copy #R$5E00 to #R$5E7C.
N $8046 Handle 1UP selection.
@ $8046 label=GameSelect_CheckP1
  $8046,$04 Jump to #R$804C if "1" was not pressed.
  $804A,$02 Set a 1UP game.
N $804C Handle 2UP selection.
@ $804C label=GameSelect_CheckP2
  $804C,$04 Jump to #R$8052 if "2" was not pressed.
  $8050,$02 Set a 2UP game.
N $8052 Handle Keyboard selection.
@ $8052 label=GameSelect_CheckKeyboard
  $8052,$04 Jump to #R$8058 if "3" was not pressed.
  $8056,$02,b$01 Set the control method to keyboard.
N $8058 Handle Kempston Joystick selection.
@ $8058 label=GameSelect_CheckKempston
  $8058,$04 Jump to #R$8060 if "4" was not pressed.
  $805C,$02,b$01 Clear the control method bits.
  $805E,$02,b$01 Set the control method to Kempston.
N $8060 Handle Cursor Joystick selection.
@ $8060 label=GameSelect_CheckCursor
  $8060,$04 Jump to #R$8068 if "5" was not pressed.
  $8064,$02,b$01 Clear the control method bits.
  $8066,$02,b$01 Set the control method to cursor.
N $8068 Write the options back, then test "6" to start.
@ $8068 label=GameSelect_StartGame
  $8068,$03 Write the updated options to #R$5E00.
  $806B,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $8071,$01 Flip the bits.
  $8072,$05 Jump to #R$81BB if "6" was pressed.
N $8077 Queue a jingle if the player count or control method
. changed since the last pass.
  $8077,$04 Copy the current game options into #REGc.
  $807B,$04 Compare them with #R$5E7C.
  $807F,$01 Stash the changed-option flags on the stack.
  $8080,$05 Call #R$80FD if the player count has changed.
  $8085,$01 Restore the changed-option flags from the stack.
  $8086,$02,b$01 Keep only the control method bits.
  $8088,$02 Jump to #R$809A if the control method is unchanged.
N $808A Queue the jingle for the newly selected control method.
  $808A,$03 Set the tune table pointer to #R$BA9E.
  $808D,$01 Fetch the current game options.
  $808E,$02,b$01 Keep only the control method bits.
  $8090,$03 Create an offset in #REGhl.
  $8093,$01 Point #REGhl at the matching entry in #R$BA9E.
  $8094,$03 Fetch the control-method jingle address.
  $8097,$03 Queue the control-method jingle.
@ $809A label=Game_Restart_FlashSelection
N $809A Flash the selected 1UP/ 2UP and control-method lines.
  $809A,$03 #REGhl=#R$810F (the first selectable line, skipping the title).
  $809D,$04 Copy the current game options into #REGc.
  $80A1,$04 Jump to #R$80BE if this is a 2UP game.
  $80A5,$03 Call #R$80C3.
N $80A8 Flash the line for the selected control method and clear the
. other two.
@ $80A8 label=MenuAttributeHandler
  $80A8,$02 Set a control method counter in #REGb for #N$03 loops.
  $80AA,$02 Fetch the options and move the control bits into
. bits 0-1.
@ $80AC label=MenuAttributeHandler_Loop
  $80AC,$02,b$01 Keep only bits 0-1.
  $80AE,$02 Jump to #R$80B9 if this control method is selected.
  $80B0,$03 Call #R$80C6.
@ $80B3 label=GameSelect_ReadOptions
  $80B3,$03 Decrease the method bits and loop back to #R$80AC
. until all three lines are updated.
  $80B6,$03 Jump to #R$8035.
N $80B9 Flash the selected control-method line.
@ $80B9 label=Game_Restart_FlashControlMethod
  $80B9,$03 Call #R$80CD.
  $80BC,$02 Jump to #R$80B3.
N $80BE Flash the 2UP line, then handle the control methods.
@ $80BE label=Game_Restart_Flash2UP
  $80BE,$03 Call #R$80CA.
  $80C1,$02 Jump to #R$80A8.
N $80C3 Flash this menu line and clear FLASH on the next.
@ $80C3 label=MenuAttributeSetUnset
  $80C3,$02 Set the FLASH attribute for this menu line.
  $80C5,$01 Move onto the next menu attribute.
@ $80C6 label=MenuAttributeUnSetFirst
  $80C6,$02 Clear the FLASH attribute for this menu line.
  $80C8,$01 Move onto the next menu attribute.
  $80C9,$01 Return.
N $80CA Clear FLASH on this menu line and set it on the next.
@ $80CA label=MenuAttributeUnsetSet
  $80CA,$02 Clear the FLASH attribute for this menu line.
  $80CC,$01 Move onto the next menu attribute.
@ $80CD label=MenuAttributeSetFirst
  $80CD,$02 Set the FLASH attribute for this menu line.
  $80CF,$01 Move onto the next menu attribute.
  $80D0,$01 Return.

c $80D1 Game Selection Menu
@ $80D1 label=GameMenu
D $80D1 Draws the seven menu lines and the copyright message.
E $80D1 View the equivalent code in;
. #LIST
. { #ATICATAC$7CAF }
. { #COOKIE$6332 }
. { #JETPAC$6260 }
. { #PSSST$6250 }
. { #SABREWULF$B473 }
. { #TRANZAM$5F6C }
. LIST#
N $80D1 #PUSHS #UDGTABLE { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SIM(start=$80D1,stop=$80F4,sp=$5E00)
. #SIM(start=$80F4,stop=$8A36,sp=$5E00)
. #SCR$02(main-menu) } UDGTABLE# #POPS
  $80D1,$03 Set the attribute table pointer to #R$810E.
  $80D4,$01 Switch to the shadow registers.
  $80D5,$03 Set the Y position table pointer to #R$8115.
  $80D8,$03 Set the message pointer to #R$811C.
N $80DB There are seven lines of text.
  $80DB,$02 Set a line counter in #REGb' for #N$07 loops.
@ $80DD label=GameMenu_Loop
  $80DD,$01 Switch back to the normal registers.
  $80DE,$04 Copy the line attribute to #R$5E66.
  $80E2,$01 Move the attribute table pointer on by one.
N $80E3 Fetch the line Y position and print the line.
  $80E3,$01 Switch to the shadow registers.
  $80E4,$01 Stash the line counter on the stack.
  $80E5,$01 Fetch the line Y position.
  $80E6,$01 Move the Y position table pointer on by one.
  $80E7,$01 Stash the Y position table pointer on the stack.
  $80E8,$03 Set the print co-ordinate from the Y position and
. X position #N$38.
  $80EB,$03 Call #R$81AB.
N $80EE Move on to the next line of text until all seven are printed.
  $80EE,$01 Switch to the shadow registers.
  $80EF,$02 Restore the Y position table pointer and line
. counter from the stack.
  $80F1,$01 Move the message pointer on to the next string.
  $80F2,$02 Decrease the line counter by one and loop back to
. #R$80DD until every line is printed.
N $80F4 Print the copyright line.
  $80F4,$03 Set the screen position to #N($B800,$04,$04).
  $80F7,$03 Set the message pointer to #R$818A.
  $80FA,$03 Jump to #R$8A11.

c $80FD Queue Menu Tune
@ $80FD label=QueueMenuTune
D $80FD Picks the 1UP or 2UP jingle from #R$BAA4 and queues it.
R $80FD C Game options from #R$5E00
N $80FD Pick the 1UP or 2UP jingle and queue it.
  $80FD,$03 Set the tune table pointer to #R$BAA4.
  $8100,$01 Fetch the game options.
  $8101,$01 Move the player-count bit into bit 1.
  $8102,$02,b$01 Keep only bit 1.
  $8104,$03 Create an offset using the player-count bit.
  $8107,$01 Point #REGhl at the matching entry in #R$BAA4.
  $8108,$03 Fetch the 1UP or 2UP jingle address.
  $810B,$03 Jump to #R$B9BC.

b $810E Game Select Attribute Table
@ $810E label=GameSelection_Attributes
@ $810F label=GameSelection_Attributes_Options
D $810E One attribute byte per menu line, all starting as #COLOUR$47. The
. routines at #R$80C3 set or clear FLASH in the byte for the line being
. updated. The first byte belongs to the title, so the flashing code starts
. at #R$810F.
E $810E View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #COOKIE$635E }
. { #JETPAC$628D }
. { #PSSST$627C }
. { #TRANZAM$5FA7 }
. LIST#
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
N $811C #FONTaddr=$D347,attr=$47,chars=0(GAME SELECTION)(game-selection)
@ $811C label=String_GameSelection
  $811C,$0E,$0D:$01 "GAME SELECTION".
N $812A #FONTaddr=$D347,attr=$47,chars=0(1  1 PLAYER GAME)(1up-game)
@ $812A label=String_1UP_Game
  $812A,$10,$0F:$01 "1  1 PLAYER GAME".
N $813A #FONTaddr=$D347,attr=$47,chars=0(2  2 PLAYER GAME)(2up-game)
@ $813A label=String_2UP_Game
  $813A,$10,$0F:$01 "2  2 PLAYER GAME".
N $814A #FONTaddr=$D347,attr=$47,chars=0(3  KEYBOARD)(keyboard)
@ $814A label=String_Keyboard
  $814A,$0B,$0A:$01 "3  KEYBOARD".
N $8155 #FONTaddr=$D347,attr=$47,chars=0(4  KEMPSTON JOYSTICK)(kempston)
@ $8155 label=String_Kempston
  $8155,$14,$13:$01 "4  KEMPSTON JOYSTICK".
N $8169 #FONTaddr=$D347,attr=$47,chars=0(5  CURSOR   JOYSTICK)(cursor)
@ $8169 label=String_Cursor
  $8169,$14,$13:$01 "5  CURSOR   JOYSTICK".
N $817D #FONTaddr=$D347,attr=$47,chars=0(6  START GAME)(start-game)
@ $817D label=String_StartGame
  $817D,$0D,$0C:$01 "6  START GAME".

t $818A Messaging: Copyright
N $818A #FONTaddr=$D347,attr=$45,chars=0(% 1983 A.C.G. ALL RIGHTS RESERVED)(copyright)
@ $818A label=String_Copyright
E $818A View the equivalent code in #ATICATAC$7D51.
  $818A,$21,h$01,c$01,$1E:$01 Attribute: #COLOUR(#PEEK(#PC)) + "© 1983 A.C.G. ALL RIGHTS RESERVED".

c $81AB Write Menu Line
@ $81AB label=MenuWriteText
D $81AB Converts a menu line co-ordinate into screen and
. attribute addresses, then prints the line using #R$5E66.
E $81AB View the equivalent code in;
. #LIST
. { #ATICATAC$7D8A }
. { #COOKIE$63E0 }
. { #JETPAC$62FF }
. { #PSSST$62E7 }
. { #SABREWULF$B52D }
. { #TRANZAM$5F97 }
. LIST#
R $81AB HL Menu line co-ordinate
R $81AB DE Message pointer
N $81AB Convert the menu line co-ordinate and print the string.
  $81AB,$01 Stash the menu line co-ordinate on the stack.
  $81AC,$03 Call #R$851E.
  $81AF,$03 Fetch the menu attribute from #R$5E66.
  $81B2,$01 Switch to the shadow #REGaf register.
  $81B3,$01 Switch to the shadow registers.
  $81B4,$01 Restore the menu line co-ordinate from the stack.
  $81B5,$03 Call #R$8506.
  $81B8,$03 Jump to #R$8A1D.

c $81BB Start Game
@ $81BB label=StartGame
D $81BB Queues the start-game tune, clears planet RAM and then
. walks every actor through #R$82C5.
E $81BB View the equivalent code in;
. #LIST
. { #ATICATAC$7D9A }
. { #COOKIE$6428 }
. { #JETPAC$6333 }
. { #PSSST$631E }
. { #TRANZAM$5FEF }
. LIST#
N $81BB Queue the start-game tune and clear planet RAM.
  $81BB,$03 Set the tune pointer to #R$BA35.
  $81BE,$03 Queue the start-game tune.
N $81C1 Reset the planet and player state.
  $81C1,$03 Set the start address to #R$5E50.
  $81C4,$03 Set the end address to #R$6000.
  $81C7,$03 Call #R$84B2.
  $81CA,$03 Call #R$84F7.
  $81CD,$03 Call #R$A84C.
  $81D0,$03 Call #R$822F.
  $81D3,$03 Call #R$A826.
@ $81D6 label=StartGame_ReadyStack
N $81D6 Ready the stack and restore Jetman after a teleport.
  $81D6,$03 Set the stack pointer to #R$5E00.
  $81D9,$07 Call #R$A2CF if #R$5E68 is set.
  $81E0,$01 Enable interrupts.
@ $81E1 label=StartGame_DispatchActor
N $81E1 Dispatch the current actor through the jump table.
  $81E1,$04 Write #N$00 to #R$5E5E.
  $81E5,$04 Point #REGix at #R$6078.
@ $81E9 label=StartGame_NextActor
  $81E9,$04 #REGc=#SKOOLKID$5C78(FRAMES).
  $81ED,$07 Call #R$8209 if #R$5E53 does not match.
  $81F4,$04 Push #R$8259 as the return address.
  $81F8,$03 Set the jump-table pointer to #R$82C5.
  $81FB,$03 Fetch the actor type from *#REGix+#N$00.
@ $81FE label=StartGame_AfterActor
  $81FE,$08 Fetch the handler address from #R$82C5.
  $8206,$03 Jump to #R$5CB0.

c $8209 Frame Update
@ $8209 label=FrameUpdate
D $8209 Runs when the FRAMES counter has ticked. Marks the frame as
. updated and walks the actor slots from #R$6000 up to #R$6078 (the
. laser beams and explosion), then returns to the current actor.
E $8209 View the equivalent code in;
. #LIST
. { #COOKIE$7160 }
. { #PSSST$70ED }
. LIST#
N $8209 Mark the frame as updated, then walk the slots up to #R$6078.
  $8209,$01 Disable interrupts.
  $820A,$06 Write #SKOOLKID$5C78(FRAMES) to #R$5E53.
  $8210,$05 Write #N$01 to #R$5E52.
  $8215,$02 Stash #REGix on the stack.
  $8217,$06 Write #R$6078 to #R$8261(#N$8262).
  $821D,$05 Write #N$C3 (JP) to #R$826A.
  $8222,$06 Write #R$823F to #R$826B.
  $8228,$04 #REGix=#R$6000.
  $822C,$03 Jump to #R$81E9.

c $822F Reset Modified Code
@ $822F label=ResetModifiedCode
D $822F Points the object iterator at #R$6240 and removes the JP
. patched in by #R$8209.
E $822F View the equivalent code in;
. #LIST
. { #COOKIE$7186 }
. { #PSSST$7113 }
. LIST#
N $822F Point the object iterator at #R$6240 and remove the JP.
  $822F,$06 Write #R$6240 to #R$8261(#N$8262).
  $8235,$09 Write #N$00 to #R$826A, #R$826B and #R$826C.
  $823E,$01 Return.

c $823F Reset Modified Code In Frame
@ $823F label=ResetModifiedInFrame
D $823F Restores the actor pointer stashed by #R$8209 and clears
. #R$5E52.
E $823F View the equivalent code in;
. #LIST
. { #PSSST$7125 }
. LIST#
N $823F Restore the actor pointer stashed by #R$8209.
  $823F,$03 Call #R$822F.
  $8242,$02 Restore #REGix from the stack.
  $8244,$04 Write #N$00 to #R$5E52.
  $8248,$01 Enable interrupts.
  $8249,$01 Return.

c $824A Limit Frame Rate
@ $824A label=LimitFrameRate
D $824A Handler for an empty actor slot (type #N$00). Waits for a short
. delay unless a frame update is running. A larger counter here slows
. the game down.
E $824A View the equivalent code in;
. #LIST
. { #COOKIE$7152 }
. { #JETPAC$691B }
. { #PSSST$70DF }
. LIST#
N $824A Return if the frame is marked as updated, otherwise pause.
  $824A,$05 Return if #R$5E52 is marked as being updated.
  $824F,$03 Introduce a counter (#N($00C0,$04,$04)) for a slight pause.
@ $8252 label=LimitFrameRate_Loop
  $8252,$01 Decrease counter by one.
  $8253,$04 Keep jumping back to #R$8252 until the counter is zero.
  $8257,$01 Return.

u $8258
D $8258 Never reached, as nothing jumps here.
C $8258,$01 Return.

c $8259 Next Object Slot
@ $8259 label=NextObjectSlot
D $8259 Return address pushed by #R$81F4. Moves #REGix onto the next
. #N$18-byte actor and either dispatches it or runs the rest of
. the game loop once the list is finished.
R $8259 IX Actor slot
N $8259 Advance #REGix onto the next #N$18-byte actor slot.
  $8259,$05 #REGix+=#N($0018,$04,$04).
  $825E,$03 Copy #REGix to #REGhl (using the stack).
  $8261,$09 Jump to #R$81E9 if #REGhl is still below #R$6240.
B $826A,$03,$01 Patched to JP #R$823F while a frame update is running.
N $826D Update timers, then handle pause, spawning, pickups and bombs.
  $826D,$07 Increment #R$5E42 by one.
N $8274 Stir the random number with a byte from the ROM, picked by the low
. byte of the timer.
  $8274,$02 #REGh=#N$00, so #REGhl is a ROM address from #N($0000,$04,$04) to
. #N($00FF,$04,$04), set by the low byte of #R$5E42.
  $8276,$03 #REGa=*#R$5E40.
  $8279,$01 Add the ROM byte at *#REGhl to #REGa.
  $827A,$03 Write #REGa back to #R$5E40.
  $827D,$03 Call #R$8298.
N $8280 Restart the game loop early if Jetman is not in play.
  $8280,$07 Jump to #R$81D6 if #R$5E6C is set.
N $8287 Spawn an alien if there are too few, then run the
. remaining handlers for this frame.
  $8287,$08 Call #R$9466 if #R$5E5E is less than #N$07.
  $828F,$03 Call #R$9F70.
  $8292,$03 Call #R$B731.
  $8295,$03 Jump to #R$81D6.

c $8298 Controls: Pause
@ $8298 label=ControlsPause
D $8298 If "O" is pressed on its own, waits for it to be released, then
. for a second press and release of "O" before returning.
N $8298 Hold the game while "O" is pressed.
  $8298,$01 Disable interrupts.
  $8299,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DF | P | O | I | U | Y }
. TABLE#
N $829F If key "O" is not being pressed, then just return.
  $829F,$03 Return if bit 1 is set.
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
  $82AC,$04 Jump to #R$82A6 if "O" is still pressed.
N $82B0 Creates an infinite loop which only exits when "O" is pressed again.
@ $82B0 label=GamePaused
  $82B0,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DF | P | O | I | U | Y }
. TABLE#
  $82B6,$04 Jump to #R$82B0 if "O" is not pressed.
N $82BA Likewise, to prevent the pause from recurring
. instantly, loop until the "O" button is released.
@ $82BA label=GamePaused_Debounce_Exit
  $82BA,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DF | P | O | I | U | Y }
. TABLE#
  $82C0,$04 Jump to #R$82BA if "O" is still pressed.
  $82C4,$01 Return.

w $82C5 Jump Table
@ $82C5 label=JumpTable
D $82C5 Handler routine address for each actor type, indexed by the
. type byte at *#REGix+#N$00.

c $84AD Reset Screen Buffer
@ $84AD label=ResetScreen
D $84AD Points at the screen buffer and falls into #R$84B4 to
. fill it with #N$00.
E $84AD Continue on to #R$84B4 to blank the screen buffer.
E $84AD View the equivalent code in;
. #LIST
. { #ATICATAC$80B4 }
. { #COOKIE$74D4 }
. { #JETPAC$71B8 }
. { #PSSST$7439 }
. { #SABREWULF$BB81 }
. { #TRANZAM$7211 }
. LIST#
N $84AD Point at the screen buffer and fall into #R$84B4.
  $84AD,$03 Set the target address to #N$4000 (screen buffer).
  $84B0,$02 Finish at the start of #N$5800.
@ $84B2 label=ResetScreen_Fill
  $84B2,$02 Set the fill value to #N$00.

c $84B4 Fill Memory
@ $84B4 label=ResetCopier
D $84B4 Writes #REGc from the target address up to the page in
. #REGb.
E $84B4 View the equivalent code in;
. #LIST
. { #ATICATAC$80BB }
. { #COOKIE$74DB }
. { #JETPAC$71BF }
. { #PSSST$7440 }
. { #SABREWULF$BB88 }
. { #TRANZAM$7218 }
. LIST#
R $84B4 HL Target address
R $84B4 B End-address MSB (the LSB is always #N$00)
R $84B4 C Value to write
  $84B4,$01 Write the fill value to the target address.
  $84B5,$01 Move onto the next byte.
  $84B6,$02 Compare the target page with the end page.
  $84B8,$02 Jump back to #R$84B4 until the end page is reached.
  $84BA,$01 Return.

c $84BB Reset Attribute Buffer
@ $84BB label=ResetAttributes
D $84BB Fills the attribute buffer with #COLOUR$43, then paints
. a black column on the left and right of each row.
E $84BB View the equivalent code in;
. #LIST
. { #ATICATAC$80C2 }
. { #COOKIE$74E2 }
. { #JETPAC$71C6 }
. { #PSSST$7447 }
. { #SABREWULF$BB8F }
. { #TRANZAM$7200 }
. LIST#
N $84BB Fill the attribute buffer with #COLOUR$43.
  $84BB,$03 Set the border to #INK$00.
  $84BE,$03 Set the target address to #N$5800 (attribute
. buffer).
  $84C1,$02 Finish at the end of the attribute buffer (#N$5B00).
  $84C3,$02 Set the fill value to #COLOUR$43.
  $84C5,$03 Call #R$84B4.
N $84C8 Paint a black column on each side of the play area.
  $84C8,$03 Set the attribute pointer to #N$5800.
  $84CB,$03 Set the offset to the right-hand column to
. #N($001F,$04,$04).
  $84CE,$03 Set the row counter to #N$18 and the edge colour to
. #INK$00.
@ $84D1 label=ResetAttributes_Loop
  $84D1,$01 Write black to the left-hand column.
  $84D2,$01 Move to the right-hand column.
  $84D3,$02 Write black to the right-hand column and move onto
. the next row.
  $84D5,$02 Decrease the row counter by one and loop back to
. #R$84D1 until all #N$18 rows are done.
  $84D7,$01 Return.

c $84D8 Create Game Window
@ $84D8 label=CreateWindow
D $84D8 Blanks the screen, draws the banner and writes the
. score line.
E $84D8 View the equivalent code in;
. #LIST
. { #ATICATAC$80AA }
. { #COOKIE$5FB7 }
. { #JETPAC$608A }
. { #PSSST$5F53 }
. { #TRANZAM$68A0 }
. LIST#
N $84D8 #PUSHS #UDGTABLE { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SCR$02(game-window) } UDGTABLE# #POPS
N $84D8 Blank the screen and write the banner.
  $84D8,$03 Call #R$84BB.
  $84DB,$03 Call #R$84AD.
  $84DE,$03 Call #R$8A37.
N $84E1 Colour the score line #COLOUR$46.
  $84E1,$03 Set the attribute pointer to #N$5820.
  $84E4,$03 Set the column counter to #N$20 and the colour to
. #COLOUR$46.
@ $84E7 label=CreateWindow_Loop
  $84E7,$01 Write #COLOUR$46 to the attribute buffer.
  $84E8,$01 Move onto the next column.
  $84E9,$02 Decrease the column counter by one and loop back to
. #R$84E7 until the line is done.
N $84EB Display the current 1UP and 2UP levels.
  $84EB,$03 Call #R$F5EC.
N $84EE Write the 1UP, 2UP and HI scores.
  $84EE,$03 Call #R$89BF.
  $84F1,$03 Call #R$89C7.
  $84F4,$03 Jump to #R$89CF.

c $84F7 Reset Planet
@ $84F7 label=ResetPlanet
D $84F7 Clears #N($0480,$04,$04) bytes of object RAM from
. #R$6000.
N $84F7 Clear #N($0480,$04,$04) bytes of object RAM from #R$6000.
  $84F7,$03 Set the target address to #R$6000.
  $84FA,$03 Set the byte counter to #N($0480,$04,$04).
@ $84FD label=ResetPlanet_Loop
  $84FD,$02 Write #N$00 to the current object-RAM byte.
  $84FF,$01 Move onto the next byte.
  $8500,$05 Decrease the byte counter by one and loop back to
. #R$84FD until every byte is clear.
  $8505,$01 Return.

c $8506 Calculate Attribute Address
E $8506 View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #COOKIE$7534 }
. { #JETPAC$720E }
. { #PSSST$748F }
. { #SABREWULF$B8DD }
. { #TRANZAM$7097 }
. LIST#
@ $8506 label=AttributeAddress
D $8506 Converts a pixel address into the matching attribute
. buffer address.
R $8506 HL Pixel address co-ordinates
R $8506 O:HL Attribute buffer address
N $8506 Convert the pixel X/Y in #REGhl into an attribute address.
  $8506,$01 Stash #REGbc on the stack.
  $8507,$01 Horizontal co-ordinate.
  $8508,$03 Divide by #N$08.
  $850B,$02,b$01 Keep only bits 0-4 (#N$00-#N$1F /
. minimum-maximum horizontal screen values).
  $850D,$01 Store this back in #REGl.
N $850E Merge the vertical co-ordinate into the low byte.
  $850E,$01 Vertical co-ordinate.
  $850F,$02 Multiply by #N$04.
  $8511,$01 Store this in #REGc temporarily.
  $8512,$02,b$01 Keep only bits 5-7.
  $8514,$01 Set the bits from #REGl.
  $8515,$01 #REGl=#REGa.
N $8516 Work out the high byte in the attribute buffer.
  $8516,$01 Fetch the stored value from #REGc.
  $8517,$02,b$01 Keep only bits 0-1.
  $8519,$02,b$01 Set the attribute buffer MSB to #N$58.
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
. { #SABREWULF$B8AD }
. { #TRANZAM$6F10 }
. LIST#
@ $851E label=ScreenAddress
D $851E Converts a pixel address into the matching screen
. buffer address.
R $851E HL Pixel address co-ordinates
R $851E O:HL Screen buffer address
N $851E Convert the pixel X/Y in #REGhl into a screen address.
  $851E,$01 Fetch the horizontal co-ordinate.
  $851F,$03 #REGa=#REGa / #N$08.
  $8522,$02,b$01 Keep only bits 0-4.
  $8524,$01 #REGl=#REGa.
  $8525,$01 #REGa=#REGh.
  $8526,$02 #REGa=#REGa * #N$04.
  $8528,$02,b$01 Keep only bits 5-7.
  $852A,$01 Merge in the column bits.
  $852B,$01 Store this back in #REGl.
N $852C Work out the high byte from the vertical co-ordinate.
  $852C,$01 Fetch the vertical co-ordinate.
  $852D,$02,b$01 Keep only bits 0-2.
  $852F,$01 Switch to the shadow #REGaf register.
  $8530,$01 Fetch the vertical co-ordinate.
  $8531,$03 Divide by #N$08.
  $8534,$02,b$01 Keep only bits 3-4.
  $8536,$02,b$01 Set the screen-buffer MSB bit.
  $8538,$01 Store this back in #REGh.
  $8539,$01 Switch to the shadow #REGaf register.
  $853A,$01 Merge in the line bits.
  $853B,$01 Store this back in #REGh.
  $853C,$01 Return.

c $853D Remap Alien Sprite
@ $853D label=MapSpriteBand
D $853D On odd levels, #R$8568 and #R$857F pass the sprite ID here
. so four alien families can be drawn from #R$EE7A instead of
. #R$BAC0. Any other ID is returned unchanged, and the caller
. keeps #R$BAC0.
. #TABLE(default,centre,centre,centre)
. { =h Sprite IDs | =h Family | =h #R$EE7A Index }
. { #N$40-#N$47 | Brella | #N$01-#N$08 }
. { #N$48-#N$4F | Blob | #N$09-#N$10 }
. { #N$88-#N$8F | Block | #N$11-#N$18 }
. { #N$B0-#N$B5 | Spinner | #N$19-#N$1E }
. TABLE#
R $853D A Sprite ID
R $853D O:A Sprite ID, or a 1-based index into #R$EE7A
R $853D O:BC #R$EE7A when the ID is one of the remapped families
N $853D Test the four odd-level alien ID ranges.
  $853D,$01 Stash the original sprite ID.
  $853E,$04 Drop #N$40 and test for brella IDs #N$40-#N$47.
  $8542,$04 Jump to #R$8560 with table offset #N$00 if it matches.
  $8546,$02 Drop another #N$08.
  $8548,$02 Set the table offset to #N$08.
  $854A,$04 Jump to #R$8560 if it is now a blob ID
. #N$48-#N$4F.
  $854E,$04 Drop #N$40 and test for block IDs #N$88-#N$8F.
  $8552,$04 Jump to #R$8560 with table offset #N$10 if it matches.
  $8556,$04 Drop #N$28 and test for spinner IDs #N$B0-#N$B5.
  $855A,$04 Jump to #R$8560 with table offset #N$18 if it matches.
  $855E,$02 Return the original sprite ID if no family matched.
@ $8560 label=MapSpriteBand_Matched
N $8560 Build the #R$EE7A index and return that table pointer.
  $8560,$02,b$01 Keep only the frame within the family.
  $8562,$02 Add the table offset and make the index 1-based.
  $8564,$03 Point #REGbc at #R$EE7A.
  $8567,$01 Return.

c $8568 Fetch Sprite
@ $8568 label=FetchSprite
D $8568 Looks up the sprite pointer for the ID in #R$5E53(#N$5E54).
. #R$BAC0 is the default table. On an odd level #R$853D may
. switch the index and table to #R$EE7A. Nothing calls this
. routine; the game uses #R$857F instead.
E $8568 View the equivalent code in;
. #LIST
. { #ATICATAC$9E89 }
. { #COOKIE$7623 }
. { #SABREWULF$B928 }
. { #TRANZAM$7155 }
. LIST#
R $8568 O:DE Sprite address
  $8568,$03 Point the sprite table at #R$BAC0.
  $856B,$04 Test #R$5EA2.
  $856F,$03 Fetch the sprite ID from #R$5E53(#N$5E54).
  $8572,$03 Call #R$853D if this is an odd level.
@ $8575 label=FetchSprite_Loop
N $8575 Index the sprite table and return the address.
  $8575,$09 Fetch the sprite address for index #REGa-#N$01.
  $857E,$01 Return.

c $857F Fetch Actor Sprite
@ $857F label=FetchActorSprite
D $857F Same lookup as #R$8568, but the index comes from the current
. actor type at *#REGix+#N$00.
E $857F View the equivalent code in;
. #LIST
. { #ATICATAC$9E96 }
. { #SABREWULF$B934 }
. LIST#
R $857F IX Actor slot
R $857F O:DE Sprite address
  $857F,$03 Point the sprite table at #R$BAC0.
  $8582,$04 Test #R$5EA2.
  $8586,$03 Fetch the actor type from *#REGix+#N$00.
  $8589,$03 Call #R$853D if this is an odd level.
  $858C,$02 Jump to #R$8575.

c $858E XOR Sprite Loop
@ $858E label=XORSpriteLoop
D $858E XOR the old sprite (normal registers) and the new sprite
. (shadow registers) onto the screen one row at a time, using
. #REGc as each sprite's row counter. Any rows left in #R$5E5A
. and #R$5E59 are then picked up.
R $858E HL Screen address
R $858E DE Graphic pointer
N $858E Draw remaining rows from the current graphic pair.
  $858E,$04 Jump to #R$85A2 if the row counter is zero.
  $8592,$04 Decrease the row counter and XOR the next row of the old
. sprite.
  $8596,$01 Switch to the shadow registers.
  $8597,$04 Jump to #R$859F if the shadow row counter is zero.
@ $859B label=XORSpriteLoop_Loop
  $859B,$04 Decrease the shadow row counter and XOR the next row of
. the new sprite.
@ $859F label=XORSpriteLoop_NextSide
  $859F,$03 Switch back and loop to #R$858E.
@ $85A2 label=XORSpriteLoop_TryShadow
N $85A2 No more rows on this side; try the other register set.
  $85A2,$01 Switch to the shadow registers.
  $85A3,$04 Jump to #R$859B if the shadow row counter is still live.
@ $85A7 label=XORSpriteLoop_FinishSprite
N $85A7 Finish the sprites if either has rows left to draw.
  $85A7,$01 Switch back to the normal registers.
@ $85A8 label=XORSpriteLoop_Write
  $85A8,$09 Return if both #R$5E5A and #R$5E59 are zero.
  $85B1,$05 Write #N$00 to #R$5E5A and switch register sets.
  $85B6,$05 Load the remaining row count and clear #REGa.
@ $85BB label=XORSpriteLoop_NextPair
  $85BB,$03 Write the remaining row count to #R$5E59.
  $85BE,$03 Switch back and loop to #R$858E.
N $85C1 Copy of #R$8606 for the old sprite. The self-modified jump at
. #R$85D7 lands here when the sprite is byte-aligned.
  $85C1,$0E XOR the graphic pair onto the screen and move up one
. pixel.
@ $85CF label=XORSpriteLoop_LoadPair
  $85CF,$08 Load the next graphic pair from #REGde.
@ $85D7 label=XORSpriteLoop_Shift
  $85D7,$02 Self-modifying shift. The operand is written by
. #R$866A.

c $85D9 Shift Old Sprite Pair
@ $85D9 label=ShiftOldSpritePair
D $85D9 Copy of #R$8614(#N$861E) for the old sprite. The self-modified jump at
. #R$85D7 lands in this run of shifts, which push the graphic
. pair into pixel alignment before it is XORed onto the screen.
  $85D9,$0E Shift the pair left through #REGa.
  $85E7,$01 Switch the shifted pair into #REGde.
@ $85E8 label=ShiftOldSpritePair_XOR
N $85E8 XOR three bytes onto the screen, then move up one pixel.
  $85E8,$0E XOR #REGa, #REGd and #REGe onto the screen at #REGhl and
. restore the graphic pointer.

c $85F6 Screen Address One Pixel Above
@ $85F6 label=ScreenPosition1PixelAbove
D $85F6 Moves a screen address up one pixel, wrapping through the
. Spectrum display layout.
R $85F6 HL Current position
R $85F6 O:HL Address for new position
E $85F6 View the equivalent code in;
. #LIST
. { #PSSST$7585 }
. { #TRANZAM$6ECB }
. LIST#
N $85F6 Move the screen address up one pixel, wrapping the row.
  $85F6,$01 Move up one pixel.
  $85F7,$02 Invert the new line byte.
  $85F9,$02,b$01 Keep only bits 0-2.
  $85FB,$01 Return if a character-row boundary was not crossed.
  $85FC,$04 Subtract #N$20 from the column address.
  $8600,$01 Return if that wrapped into the previous third.
  $8601,$04 Add #N$08 to the line byte.
  $8605,$01 Return.

c $8606 XOR Sprite Pair Up
@ $8606 label=XORSpritePairUp
D $8606 XOR a 16-bit graphic pair onto the screen, then move up one
. pixel via #R$85F6.
R $8606 HL Screen address
  $8606,$0B XOR the graphic pair onto the screen at #REGhl.
  $8611,$03 Jump to #R$85F6.

c $8614 Prepare Sprite Write
@ $8614 label=PrepareSpriteWrite
D $8614 Shift the next graphic pair of the new sprite and XOR it onto
. the screen, moving up one pixel. #R$862F positions the actor and then
. continues at #R$8637.
R $8614 DE Graphic pointer
N $8614 Shift the next graphic pair into place and XOR it onto the screen.
  $8614,$08 Load the next graphic pair from #REGde.
@ $861C label=PrepareSpriteWrite_ShiftPair
  $861C,$02 Self-modifying shift. The operand is written by
. #R$86D3.
  $861E,$0E Rotate the pair into pixel alignment.
  $862C,$03 Switch the pair back and jump to #R$85E8.
  $862F,$05 Apply the actor position, then continue at #R$8637.

c $8634 Position And Draw Sprite
@ $8634 label=PositionAndDrawSprite
D $8634 Position the actor's sprite with #R$86A1, clear the remaining row
. count and start the draw through #R$858E.
R $8634 IX Actor slot
N $8634 #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$8634 | =h After #R$8733 }
. { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SIM(start=$81BB,stop=$81D6,sp=$5E00)
. #SCR$03,$0B,$11,$0A,$06(position-draw-before)
. | #SIM(start=$8E53,stop=$8E56,ix=$6078,sp=$5E00)
. #SCR$03,$0B,$11,$0A,$06(position-draw-drawn)
. | #SIM(start=$8733,stop=$0000,ix=$6078,sp=$5E00)
. #SCR$03,$0B,$11,$0A,$06(position-draw-coloured) } UDGTABLE# #POPS
  $8634,$03 Call #R$86A1.
@ $8637 label=PositionAndDrawSprite_ClearWidth
  $8637,$06 Switch register sets, then write #N$00 to #R$5E5A and the
. row counter.
  $863D,$03 Jump to #R$858E.

c $8640 Draw Cached Sprite
@ $8640 label=DrawCachedSprite
D $8640 Clear the scratch counts, load the actor's cached sprite with
. #R$865E and start the draw through #R$858E.
R $8640 IX Actor slot
N $8640 #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before #R$8640 | =h After #R$8640 }
. { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SIM(start=$81BB,stop=$81D6,sp=$5E00)
. #SIM(start=$8DD9,stop=$8DDC,ix=$6078,sp=$5E00)
. #SIM(start=$8DDC,stop=$8DDF,ix=$6078,sp=$5E00)
. #SCR$03,$0B,$11,$0A,$06(cached-drawn)
. | #SIM(start=$B4BA,stop=$B4BD,ix=$6078,sp=$5E00)
. #SCR$03,$0B,$11,$0A,$06(cached-erased) } UDGTABLE# #POPS
N $8640 The cached image of the sprite is XORed off the screen, so the
. pixels of the sprite disappear.
  $8640,$08 Write #N$00 to #R$5E59, #R$5E58 and the row
. counter.
  $8648,$01 Switch to the shadow registers.
  $8649,$03 Call #R$865E.
  $864C,$03 Jump to #R$858E.

c $864F Clear Sprite Scratch
@ $864F label=ClearSpriteScratch
D $864F Zero #R$5E59 and #R$5E58, then XOR the actor's cached sprite
. onto the screen again (erasing it) through #R$87B9.
R $864F IX Actor slot
N $864F #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before #R$864F | =h After #R$864F }
. { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SIM(start=$81BB,stop=$81D6,sp=$5E00)
. #SIM(start=$9EEB,stop=$9EEE,ix=$6090,sp=$5E00)
. #SIM(start=$8733,stop=$0000,ix=$6090,sp=$5E00)
. #SCR$03,$04,$11,$0A,$06(scratch-drawn)
. | #SIM(start=$B441,stop=$B444,ix=$6090,sp=$5E00)
. #SCR$03,$04,$11,$0A,$06(scratch-erased) } UDGTABLE# #POPS
N $864F The cached image of the sprite is XORed off the screen, so the
. pixels of the sprite disappear.
  $864F,$07 Write #N$00 to #LIST { #R$5E59 } { #R$5E58 } LIST#
  $8656,$02 Clear the row counter and switch register sets.
  $8658,$03 Call #R$88E8.
  $865B,$03 Jump to #R$87B9.

c $865E Load Sprite Scratch
@ $865E label=LoadSpriteScratch
D $865E Copy the current actor's cached sprite fields into the draw
. workspace.
R $865E IX Actor slot
  $865E,$06 Fetch the cached graphic pointer.
  $8664,$06 Fetch the cached screen address.
  $866A,$06 Write the cached shift to #R$85D7(#N$85D8).
  $8670,$06 Write the cached height (row count) to #R$5E5A.
  $8676,$06 Write the cached Y position to #R$5E56.
  $867C,$02 Clear the row counter.
  $867E,$01 Return.

c $867F Reset Sprite Fields
@ $867F label=ResetSpriteFields
D $867F Clear the cached sprite bytes on the actor and the draw
. workspace.
R $867F IX Actor slot
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
  $869E,$02 Clear the row counter.
  $86A0,$01 Return.

c $86A1 Position Sprite
@ $86A1 label=PositionSprite
D $86A1 Convert the actor's world position into a screen column
. relative to #R$607A, then fetch its sprite.
R $86A1 IX Actor slot
N $86A1 Convert the actor world X into a screen column.
  $86A1,$06 Fetch the actor's world X position.
  $86A7,$04 Add the #N($0078,$04,$04) draw offset.
  $86AB,$04 Fetch the scroll position from #R$607A.
  $86AF,$03 Subtract the scroll position.
  $86B2,$01 Fetch the high byte of the screen column.
  $86B3,$02,b$01 Keep only bits 0-4.
  $86B5,$02 Jump to #R$867F if the actor is off-screen.
  $86B7,$05 Jump to #R$867F if the column is at least #N$F0.
N $86BC Store the column and look up the actor sprite.
  $86BC,$03 Store the screen column in *#REGix+#N$01.
  $86BF,$03 Call #R$857F.
@ $86C2 label=PositionSprite_Apply
N $86C2 Build the pixel-shift index from the column.
  $86C2,$06 Fetch the screen column and actor Y.
  $86C8,$03 Build a pixel-shift index from the column.
  $86CB,$02,b$01 Keep only bits 1-3.
  $86CD,$04 Jump to #R$86D3 if the shift is not #N$0E.
  $86D1,$02 Set the shift operand to #N$E8.
N $86D3 Store the pixel shift for the sprite drawing code.
@ $86D3 label=PositionSprite_StoreShift
  $86D3,$06 Write the shift to #R$861C(#N$861D) and
. *#REGix+#N$09.
N $86D9 Choose the scratch width from the shift.
  $86D9,$02 Set the scratch width to #N$02.
  $86DB,$02 Jump to #R$86DE if the shift was #N$0E.
  $86DD,$01 Widen the scratch width to #N$03.
@ $86DE label=PositionSprite_StoreWidth
  $86DE,$06 Write the scratch width and cache the actor Y.
N $86E4 Work out the screen address, then cache the sprite details on
. the actor.
  $86E4,$03 Call #R$851E.
  $86E7,$0B Copy the sprite height into #R$5E59, #R$5E58 and
. *#REGix+#N$0A.
  $86F2,$0C Cache the graphic pointer and screen address on the
. actor.
  $86FE,$02 Clear the row counter.
  $8700,$01 Return.

c $8701 Draw Sprite
@ $8701 label=DrawSprite
D $8701 Load the actor's cached (old) sprite, work out the new sprite
. position, and XOR both onto the screen through #R$858E.
R $8701 IX Actor slot
N $8701 #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$8701 | =h After #R$8733 }
. { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SIM(start=$81BB,stop=$81D6,sp=$5E00)
. #SCR$03,$0B,$11,$0A,$06(jetman-before)
. | #SIM(start=$8DD9,stop=$8DDC,ix=$6078,sp=$5E00)
. #SCR$03,$0B,$11,$0A,$06(jetman-drawn)
. | #SIM(start=$8DDC,stop=$8DDF,ix=$6078,sp=$5E00)
. #SCR$03,$0B,$11,$0A,$06(jetman-coloured) } UDGTABLE# #POPS
N $8701 Load the cached sprite, then XOR it onto the screen.
  $8701,$03 Call #R$865E.
  $8704,$01 Switch to the shadow registers.
  $8705,$03 Call #R$86A1.
  $8708,$01 Switch back to the normal registers.
N $8709 Compare the cached Y position with the actor Y.
  $8709,$06 Subtract the actor Y from #R$5E56.
  $870F,$03 Jump to #R$85A8 if they match.
  $8712,$03 Jump to #R$8724 if the actor has moved down (the result
. is negative).
  $8715,$01 Store the row difference in the row counter.
  $8716,$07 Jump to #R$85A8 if the difference is taller than the old
. sprite's rows in #R$5E5A.
  $871D,$07 Subtract it from #R$5E5A and jump to #R$858E.
@ $8724 label=DrawSprite_ActorMovedDown
  $8724,$04 Switch register sets and negate the row difference.
  $8728,$07 Jump to #R$85A7 if the difference is taller than the new
. sprite's rows in #R$5E59.
  $872F,$04 Subtract it from the row count and jump to
. #R$85BB.

c $8733 Colourise Sprite
@ $8733 label=ColouriseSprite
D $8733 Write the actor's attribute bytes into the buffer using
. #R$8506.
E $8733 View the equivalent code in;
. #LIST
. { #JETPAC$71CF }
. { #PSSST$7450 }
. { #TRANZAM$704B }
. LIST#
R $8733 IX Actor slot
N $8733 #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$8701 | =h After #R$8733 }
. { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SIM(start=$81BB,stop=$81D6,sp=$5E00)
. #SCR$03,$0B,$11,$0A,$06(jetman-before)
. | #SIM(start=$8DD9,stop=$8DDC,ix=$6078,sp=$5E00)
. #SCR$03,$0B,$11,$0A,$06(jetman-drawn)
. | #SIM(start=$8DDC,stop=$8DDF,ix=$6078,sp=$5E00)
. #SCR$03,$0B,$11,$0A,$06(jetman-coloured) } UDGTABLE# #POPS
N $8733 Write the actor colour into the attribute rectangle.
  $8733,$06 Fetch the screen column and actor Y.
  $8739,$03 Fetch the actor colour from *#REGix+#N$07.
  $873C,$05 Return if #R$5E57 is zero.
  $8741,$01 Set the column counter from #R$5E57.
  $8742,$03 Call #R$8506.
  $8745,$07 Turn #R$5E58 into an attribute-row count.
  $874C,$02,b$01 Keep only bits 0-4.
  $874E,$02 Store the row count.
@ $8750 label=ColouriseSprite_Loop
N $8750 Paint one attribute row, then step up to the next.
  $8750,$02 Stash the counters and attribute address.
  $8752,$05 Jump to #R$8770 if the address is below #N$5800.
  $8757,$0C Skip this row if the address is at or past
. #N$5AC0.
N $8763 Write the actor colour along the row, skipping empty
. attributes.
@ $8763 label=ColouriseSprite_WriteInk
  $8763,$04 Jump to #R$8768 if this attribute is empty.
  $8767,$01 Write the actor colour.
@ $8768 label=ColouriseSprite_NextColumn
  $8768,$02 Move onto the next attribute column.
  $876A,$02,b$01 Keep only bits 0-4.
  $876C,$04 Jump to #R$8770 if the row wrapped, else loop back
. to #R$8763.
N $8770 Step up one attribute row and repeat until every row is
. painted.
@ $8770 label=ColouriseSprite_NextRow
  $8770,$01 Restore the start of this attribute row.
  $8771,$07 Move up one attribute row.
  $8778,$03 Decrease the row counter and loop back to #R$8750
. until every row is painted.
  $877B,$01 Return.

c $877C Draw Sprite Pair
@ $877C label=DrawSpritePair
D $877C Reload the actor graphic and XOR it via #R$88A3.
R $877C IX Actor slot
N $877C #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$8787 | =h After #R$877C | =h After #R$890A }
. { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SIM(start=$81BB,stop=$81D6,sp=$5E00)
. #SCR$03,$04,$11,$0A,$06(pair-before)
. | #SIM(start=$9EEB,stop=$9EEE,ix=$6090,sp=$5E00)
. #SCR$03,$04,$11,$0A,$06(pair-drawn)
. | #SIM(start=$9267,stop=$926A,ix=$6090,sp=$5E00)
. #SCR$03,$04,$11,$0A,$06(pair-redrawn)
. | #SIM(start=$927A,stop=$9280,ix=$6090,sp=$5E00)
. #SCR$03,$04,$11,$0A,$06(pair-coloured) } UDGTABLE# #POPS
  $877C,$03 Call #R$88E8.
  $877F,$01 Switch to the shadow registers.
  $8780,$03 Call #R$88A3.
  $8783,$01 Switch back to the normal registers.
  $8784,$03 Jump to #R$878F.

c $8787 Draw Actor Sprite
@ $8787 label=DrawActorSprite
D $8787 Reload the actor graphic and XOR it via #R$8826.
R $8787 IX Actor slot
N $8787 #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$8787 | =h After #R$8733 }
. { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SIM(start=$81BB,stop=$81D6,sp=$5E00)
. #SCR$03,$04,$11,$0A,$06(rover-before)
. | #SIM(start=$9EEB,stop=$9EEE,ix=$6090,sp=$5E00)
. #SCR$03,$04,$11,$0A,$06(rover-drawn)
. | #SIM(start=$8733,stop=$0000,ix=$6090,sp=$5E00)
. #SCR$03,$04,$11,$0A,$06(rover-coloured) } UDGTABLE# #POPS
N $8787 Reload the actor graphic and XOR it via #R$8826.
  $8787,$03 Call #R$88E8.
  $878A,$01 Switch to the shadow registers.
  $878B,$03 Call #R$8826.
  $878E,$01 Switch back to the normal registers.
@ $878F label=DrawActorSprite_Fetch
N $878F Compare the cached screen MSB with the actor Y.
  $878F,$06 Subtract the actor Y from #R$5E56.
  $8795,$03 Jump to #R$880D if they match.
  $8798,$03 Jump to #R$87AA if the result is negative.
  $879B,$01 Store the row difference in the row counter.
  $879C,$07 Jump to #R$880D if the difference is taller than the old
. sprite's rows in #R$5E5A.
  $87A3,$07 Subtract it from #R$5E5A and jump to #R$87B9.
@ $87AA label=DrawActorSprite_Draw
  $87AA,$04 Switch register sets and negate the row difference.
  $87AE,$07 Jump to #R$880C if the difference is taller than the new
. sprite's rows in #R$5E59.
  $87B5,$04 Subtract it from the row count and jump to
. #R$8820.

c $87B9 Write Sprite Row
@ $87B9 label=WriteSpriteRow
D $87B9 XOR one graphic row from #REGde onto the screen at #REGhl.
R $87B9 HL Screen address
R $87B9 DE Graphic pointer
N $87B9 XOR one graphic row from #REGde onto the screen at #REGhl.
  $87B9,$04 Jump to #R$8807 if the row counter is zero.
  $87BD,$01 Decrease the row counter by one.
  $87BE,$02 Stash the counters and screen address.
@ $87C0 label=WriteSpriteRow_Loop
  $87C0,$04 XOR the next graphic byte onto the screen.
  $87C4,$03 Move to the next column and loop back to #R$87C0.
N $87C7 Skip the unused graphic bytes, then step up one pixel line.
@ $87C7 label=WriteSpriteRow_SkipRest
  $87C7,$02 Self-modifying skip. The operand is written by
. #R$88F8.
  $87C9,$10 Skip the remaining bytes of this graphic row.
  $87D9,$01 Restore the screen address from the stack.
  $87DA,$03 Call #R$85F6.
  $87DD,$01 Restore the counters from the stack.
N $87DE Switch to the other sprite and write its next row if
. it has rows left.
  $87DE,$05 Jump to #R$8804 if the shadow row counter is zero.
@ $87E3 label=WriteSpriteRow_DecreaseShadow
  $87E3,$01 Decrease the shadow row counter.
  $87E4,$02 Stash the counters and the screen address on the
. stack.
@ $87E6 label=WriteSpriteRow_XORByte
  $87E6,$04 XOR the next graphic byte onto the screen.
  $87EA,$03 Move to the next column and loop back to #R$87E6.
N $87ED Skip the unused graphic bytes, then step up one pixel line.
@ $87ED label=WriteSpriteRow_SkipGraphic
  $87ED,$02 Self-modifying skip. The operand is written by
. #R$8850 and #R$88C6.
  $87EF,$10 Skip the remaining bytes of this graphic row.
  $87FF,$01 Restore the screen address from the stack.
  $8800,$03 Call #R$85F6.
  $8803,$01 Restore the counters from the stack.
@ $8804 label=WriteSpriteRow_NextSide
  $8804,$03 Switch back and loop to #R$87B9.

c $8807 Continue Sprite Write
@ $8807 label=ContinueSpriteWrite
D $8807 Switch to the shadow registers and keep XOR-ing the current
. sprite.
  $8807,$05 Jump to #R$87E3 if the shadow row counter
. is live.
@ $880C label=ContinueSpriteWrite_Next
  $880C,$01 Switch back to the normal registers.
@ $880D label=ContinueSpriteWrite_Row
  $880D,$09 Return if both #R$5E5A and #R$5E59 are zero.
  $8816,$05 Write #N$00 to #R$5E5A and switch register sets.
  $881B,$05 Load the remaining row count and clear #REGa.
@ $8820 label=ContinueSpriteWrite_Done
  $8820,$03 Write the remaining row count to #R$5E59.
  $8823,$03 Switch back and loop to #R$87B9.

c $8826 Fetch And Draw
@ $8826 label=FetchAndDraw
D $8826 Look up the actor sprite, clip it against the left and right
. screen edges, and cache its graphic pointer and screen address on
. the actor.
R $8826 IX Actor slot
N $8826 Look up the actor sprite and test whether it is on-screen.
  $8826,$03 Call #R$857F.
  $8829,$06 Fetch the actor's world X position.
  $882F,$07 Subtract the scroll position at #R$607A.
  $8836,$04 Add the #N($0068,$04,$04) draw offset.
  $883A,$01 Fetch the high byte of the screen column.
  $883B,$02,b$01 Keep only bits 0-4.
  $883D,$02 Jump to #R$88B1 if the actor is on-screen.
  $883F,$04 Jump to #R$8891 if the column is not #N$1F.
N $8843 Clip a sprite that straddles the left edge.
  $8843,$07 Arithmetic-shift the column down by three.
  $884A,$03 Jump to #R$8891 if the result is positive.
  $884D,$01 Store the shifted column.
  $884E,$02,b$01 Keep only bits 0-3.
  $8850,$06 Write the skip to #R$87ED(#N$87EE) and
. *#REGix+#N$09.
N $8856 Work out how much of the sprite width is visible and
. cache the visible width and height.
  $8856,$04 Fetch the sprite width and add the shifted column.
  $885A,$05 Jump to #R$8891 if that sum is zero or negative.
  $885F,$01 Copy the visible width into #REGb.
  $8860,$06 Write the visible width to #R$5E57 and
. *#REGix+#N$0B.
  $8866,$0B Copy the next header byte into #R$5E59, #R$5E58
. and *#REGix+#N$0A.
N $8871 Skip the graphic bytes hidden off the left edge.
  $8871,$02 #REGa=width-visible width (the bytes hidden on the left).
@ $8873 label=FetchAndDraw_Loop
  $8873,$04 Skip graphic bytes until the visible strip starts.
  $8877,$02 Set the screen column to #N$00.
@ $8879 label=FetchAndDraw_StoreColumn
N $8879 Cache the visible strip and draw it.
  $8879,$03 Store the screen column.
  $887C,$03 Fetch the actor Y.
  $887F,$03 Call #R$851E.
  $8882,$0C Cache the graphic pointer and screen address on the
. actor.
  $888E,$02 Clear the row counter.
  $8890,$01 Return.

c $8891 Clear Sprite Cache
@ $8891 label=ClearSpriteCache
D $8891 Zero the remaining sprite workspace and the actor's cached
. width/height.
R $8891 IX Actor slot
  $8891,$10 Write #N$00 to:
. #LIST
. { #R$5E59 }
. { #R$5E58 }
. { #REGix+#N$0A }
. { #R$5E57 }
. { #REGix+#N$0B }
. LIST#
  $88A1,$02 Jump to #R$8879.

c $88A3 Fetch Sprite Size
@ $88A3 label=FetchSpriteSize
D $88A3 Look up the actor sprite and take its width from the first
. graphic byte.
R $88A3 IX Actor slot
N $88A3 Look up the actor sprite and take its width from the header.
  $88A3,$03 Call #R$857F.
  $88A6,$06 Fetch the screen column and actor Y.
  $88AC,$03 Fetch the sprite width and move past the header.
  $88AF,$02 Jump to #R$88E2.

c $88B1 Read Sprite Header
@ $88B1 label=ReadSpriteHeader
D $88B1 Fetch the width byte from the graphic and rotate it into a
. pixel count.
R $88B1 DE Graphic pointer
N $88B1 Read the sprite width and rotate it into a pixel count.
  $88B1,$03 Fetch the sprite width and move past the header.
  $88B4,$03 Rotate the width into a pixel count.
  $88B7,$02,b$01 Keep only bits 3-7.
  $88B9,$03 Jump to #R$88E2 if adding the column does not wrap.
  $88BC,$03 Rotate the overflow back to a nibble.
  $88BF,$02,b$01 Keep only bits 0-3.
  $88C1,$05 Store the overflow and turn it into a right-hand
. skip.
N $88C6 Store the skip and visible width, then copy the
. height into the draw workspace.
@ $88C6 label=ReadSpriteHeader_Loop
  $88C6,$06 Write the skip to #R$87ED(#N$87EE) and
. *#REGix+#N$09.
  $88CC,$09 Write the visible width to #R$5E57 and
. *#REGix+#N$0B.
  $88D5,$0B Copy the next header byte into #R$5E58, #R$5E59
. and *#REGix+#N$0A.
  $88E0,$02 Jump to #R$8879.
N $88E2 Use no skip when the sprite does not wrap past
. the screen column.
@ $88E2 label=ReadSpriteHeader_Done
  $88E2,$04 Set the skip operand to #N$10 (skip nothing) and clear
. the overflow.
  $88E6,$02 Jump to #R$88C6.

c $88E8 Load Sprite Pointers
@ $88E8 label=LoadSpritePointers
D $88E8 Copy the graphic pointer and size from the actor into the
. draw workspace.
R $88E8 IX Actor slot
N $88E8 Copy the cached graphic pointer and size from the actor.
  $88E8,$06 Fetch the cached graphic pointer.
  $88EE,$06 Fetch the cached screen address.
  $88F4,$04 Write the screen MSB to #R$5E56.
  $88F8,$06 Write the cached skip to #R$87C7(#N$87C8).
  $88FE,$06 Write the cached height (row count) to #R$5E5A.
  $8904,$03 Fetch the cached width into the column counter.
  $8907,$02 Clear the row counter.
  $8909,$01 Return.

c $890A Write Sprite Attributes
@ $890A label=WriteSpriteAttributes
D $890A Paint a rectangle of colours into the attribute buffer, taking one
. colour byte from the grid at #REGde for every cell the actor's sprite covers
. and leaving empty cells alone.
R $890A DE Colour grid
R $890A IX Actor slot
N $890A #PUSHS #UDGTABLE(default,centre,centre)
. { =h After #R$877C | =h After #R$890A }
. { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SIM(start=$81BB,stop=$81D6,sp=$5E00)
. #SIM(start=$9EEB,stop=$9EEE,ix=$6090,sp=$5E00)
. #SIM(start=$9267,stop=$926A,ix=$6090,sp=$5E00)
. #SCR$03,$04,$11,$0A,$06(pair-redrawn)
. | #SIM(start=$927A,stop=$9280,ix=$6090,sp=$5E00)
. #SCR$03,$04,$11,$0A,$06(pair-coloured) } UDGTABLE# #POPS
N $890A Paint the actor colour rectangle into the attribute buffer.
  $890A,$06 Fetch the screen column and actor Y.
  $8910,$03 Call #R$8506.
  $8913,$06 Fetch the width and height from the graphic header.
@ $8919 label=WriteSpriteAttributes_Loop
  $8919,$02 Stash the counters and attribute address.
N $891B Write the colours along the row, skipping empty attributes.
@ $891B label=WriteSpriteAttributes_WriteInk
  $891B,$04 Jump to #R$8921 if this attribute is empty.
  $891F,$02 Write the next colour byte.
@ $8921 label=WriteSpriteAttributes_NextColumn
  $8921,$04 Move onto the next colour and attribute column,
. looping back to #R$891B.
N $8925 Step up one attribute row and repeat until every row is
. painted.
  $8925,$08 Restore this row and step up one attribute row.
  $892D,$03 Decrease the height and loop back to #R$8919 until
. every row is painted.
  $8930,$01 Return.

c $8931 Fill Attribute Row
@ $8931 label=FillAttributeRow
D $8931 Write #REGd over a block of attributes, #REGb columns wide and
. #REGc rows high, stepping up a row at a time. Empty (zero)
. attributes are left alone.
R $8931 B Number of columns
R $8931 C Number of rows
R $8931 D Attribute value
R $8931 HL Attribute address of the bottom-left cell
  $8931,$02 Stash the counters and attribute address.
@ $8933 label=FillAttributeRow_Loop
  $8933,$04 Jump to #R$8938 if this attribute is empty.
  $8937,$01 Write the fill colour.
@ $8938 label=FillAttributeRow_NextColumn
  $8938,$03 Move onto the next column and loop back to #R$8933.
  $893B,$08 Restore this row and step up one attribute row.
  $8943,$03 Decrease the height and loop back to #R$8931 until
. every row is painted.
  $8946,$01 Return.

c $8947 Negate Pair
@ $8947 label=NegatePair
D $8947 Two's-complement #REGhl and return.
R $8947 HL Value to negate
R $8947 O:HL Negated value
  $8947,$07 Invert #REGhl and add one.
  $894E,$01 Return.

c $894F Display Lives
@ $894F label=DisplayPlayerLives
D $894F Draw the 1UP and 2UP lives counts and the life UDG, or
. spaces if a player has none.
E $894F View the equivalent code in;
. #LIST
. { #ATICATAC$A2CE }
. { #COOKIE$7378 }
. { #JETPAC$70A4 }
. { #PSSST$7325 }
. { #SABREWULF$B7CD }
. { #TRANZAM$687B }
. LIST#
N $894F Controller for 1UP lives.
  $894F,$06 Call #R$851E with the pixel co-ordinates
. #N($0040,$04,$04) to get the 1UP lives screen address.
  $8955,$03 #REGa=1UP lives remaining (by calling #R$8986).
  $8958,$03 If 1UP lives are zero, jump to #R$8977.
  $895B,$03 Else, there are lives to display so call #R$896A.
N $895E Controller for 2UP lives.
@ $895E label=Controller2UPLives
  $895E,$06 Call #R$851E with the pixel co-ordinates
. #N($00B0,$04,$04) to get the 2UP lives screen address.
  $8964,$03 #REGa=2UP lives remaining (by calling #R$8994).
  $8967,$03 If 2UP lives are zero, jump to #R$897C.
N $896A Handles displaying the lives count and UDG character.
@ $896A label=HandlerDisplayLives
  $896A,$02 Add #N$30 to convert to an ASCII character
. (starting at "0").
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
N $8986 Return the 1UP player's lives left.
@ $8986 label=FetchLives_1UP
  $8986,$06 If #R$5E65 is not zero then jump to #R$8990.
N $898C Return currently active players lives left.
@ $898C label=ActivePlayerLives
  $898C,$03 #REGa=*#R$5EA1.
  $898F,$01 Return.
N $8990 Return inactive players lives left.
@ $8990 label=InactivePlayerLives
  $8990,$03 #REGa=*#R$5EA5.
  $8993,$01 Return.
N $8994 Return the 2UP player's lives left.
@ $8994 label=FetchLives_2UP
  $8994,$06 If #R$5E65 is zero then jump to #R$8990.
  $899A,$02 Jump to #R$898C.

c $899C Add Points To Score
@ $899C label=AddPointsToScore
D $899C Add #REGbc to the active player's BCD score, then print
. that score.
E $899C View the equivalent code in;
. #LIST
. { #COOKIE$7415 }
. { #JETPAC$70F9 }
. { #PSSST$737A }
. { #SABREWULF$B5A9 }
. { #TRANZAM$6046 }
. LIST#
R $899C BC Points to add to score
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
  $89B5,$03 Add #N$00 (just the carry flag) to score byte
. #1 with BCD conversion.
  $89B8,$01 Update score byte #1.
N $89B9 Check the active player.
  $89B9,$06 If #R$5E65 is not zero, jump to #R$89C7.

c $89BF Print Scores
@ $89BF label=Score_1UP
D $89BF Print a three-byte BCD score to the banner.
E $89BF View the equivalent code in;
. #LIST
. { #ATICATAC$A1AE }
. { #COOKIE$7438 }
. { #JETPAC$711C }
. { #PSSST$739D }
. { #SABREWULF$B5CC }
. { #TRANZAM$6CB6 }
. LIST#
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
  $89D5,$02 Set a score byte counter in #REGb for #N$03 loops.
@ $89D7 label=PrintScore_Loop
  $89D7,$01 #REGa=*#REGde.
  $89D8,$04 #REGa=#REGa / #N$10.
  $89DC,$02,b$01 Keep only bits 0-3.
  $89DE,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $89E0,$03 Call #R$89EF.
N $89E3 Print the lower digit of the score byte.
  $89E3,$01 #REGa=*#REGde.
  $89E4,$02,b$01 Keep only bits 0-3.
  $89E6,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $89E8,$03 Call #R$89EF.
  $89EB,$01 Increment #REGde by one.
  $89EC,$02 Decrease the counter by one and jump back to
. #R$89D7 until it is zero.
  $89EE,$01 Return.

c $89EF Print Character
@ $89EF label=PrintScreen
D $89EF Print one ASCII character from the current font to the
. screen.
E $89EF View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #PSSST$73CD }
. { #SABREWULF$B589 }
. { #TRANZAM$6C96 }
. LIST#
R $89EF A ASCII value to print
R $89EF HL Screen address
  $89EF,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $89F2,$05 Create an offset in #REGhl.
  $89F7,$03 #REGhl=#REGhl * 8.
  $89FA,$04 #REGde=*#R$5E04 (main font is #R$D347).
  $89FE,$02 #REGde=#REGhl + #REGde. For examples of usage;
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Letter | =h ASCII Value | =h - #N$20 * #N$08 (offset) | =h CHARS + offset }
. #FOREACH($55,$4C,$54,$49,$4D,$41,$54,$45)(value,
.   { #LET(result=$D347 + (value - $20) * $08) "#CHR(value)" | #N(value) | #N((value - $20) * $08) | #R({result}) }
. )
. TABLE#
N $8A00 Print the character to the screen.
  $8A00,$01 Restore the screen buffer location from the
. stack.
@ $8A01 label=PrintCharacter_Draw
  $8A01,$02 Set a pixel row counter in #REGb for #N$08 loops.
@ $8A03 label=PrintScreen_Loop
  $8A03,$02 Copy a byte from the font data to the screen buffer.
  $8A05,$01 Increment the font data by one.
  $8A06,$01 Move onto the next pixel line.
  $8A07,$02 Decrease the counter by one and jump back to
. #R$8A03 until it is zero.
  $8A09,$02 Restore #REGde and #REGbc from the stack.
N $8A0B Reset #REGhl and move to the next column, ready
. to print the next character.
  $8A0B,$04 #REGh=#REGh - #N$08 (reset the display line).
  $8A0F,$01 Increment screen column by one.
  $8A10,$01 Return.

c $8A11 Print Colour String
@ $8A11 label=PrintStringColour
D $8A11 Print a bit-7-terminated string using the attribute byte
. stored in front of the text.
E $8A11 View the equivalent code in;
. #LIST
. { #ATICATAC$A1F3 }
. { #COOKIE$7488 }
. { #JETPAC$716C }
. { #PSSST$73ED }
. { #SABREWULF$B53D }
. { #TRANZAM$6518 }
. LIST#
R $8A11 DE Pointer to string data
R $8A11 HL Pixel address co-ordinates
  $8A11,$01 Stash #REGhl on the stack.
  $8A12,$03 Call #R$851E.
  $8A15,$01 Fetch the attribute byte.
  $8A16,$01 Switch to the shadow #REGaf register.
  $8A17,$01 Increment #REGde by one to point to the text of the string.
  $8A18,$01 Switch to the shadow registers.
  $8A19,$01 Restore #REGhl from the stack.
  $8A1A,$03 Call #R$8506.

N $8A1D Print each character with its attribute until the
. string terminator is reached.
@ $8A1D label=PrintString_Loop
  $8A1D,$01 Switch back to the normal registers.
  $8A1E,$01 Fetch the character to print.
  $8A1F,$04 Jump to #R$8A2E if bit 7 is set (end of the
. string).
  $8A23,$03 Call #R$89EF.
N $8A26 Move to the next character and write this cell's attribute.
  $8A26,$01 Increment #REGde by one.
  $8A27,$01 Switch to the shadow registers.
  $8A28,$01 Switch to the shadow #REGaf register.
  $8A29,$01 Copy the attribute byte to the screen.
  $8A2A,$01 Increment #REGl by one.
  $8A2B,$01 Switch to the shadow #REGaf register.
  $8A2C,$02 Jump to #R$8A1D.
N $8A2E Because the last character contains the terminator,
. it needs to be handled separately.
@ $8A2E label=PrintString_LastCharacter
  $8A2E,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $8A30,$03 Call #R$89EF.
  $8A33,$01 Switch to the shadow registers.
  $8A34,$01 Switch to the shadow #REGaf register.
  $8A35,$01 Copy the attribute byte to the screen.
  $8A36,$01 Return.

c $8A37 Print Banner
@ $8A37 label=PrintBanner
D $8A37 Print the 1UP, HI and 2UP labels along the top of the
. screen.
E $8A37 View the equivalent code in;
. #LIST
. { #COOKIE$74AE }
. { #JETPAC$7192 }
. { #PSSST$7413 }
. { #SABREWULF$B563 }
. LIST#
N $8A37 Handle printing "#FONTaddr=$D347,attr=$47,chars=0(1UP)(1up)" messaging.
  $8A37,$03 #REGhl=#N($0018,$04,$04).
  $8A3A,$03 #REGde=#R$8A51.
  $8A3D,$03 Call #R$8A11.
N $8A40 Handle printing "#FONTaddr=$D347,attr=$45,chars=0(HI)(hi)" messaging.
  $8A40,$03 #REGhl=#N($0078,$04,$04).
  $8A43,$03 #REGde=#R$8A59.
  $8A46,$03 Call #R$8A11.
N $8A49 Handle printing "#FONTaddr=$D347,attr=$47,chars=0(2UP)(2up)" messaging.
  $8A49,$03 #REGhl=#N($00D8,$04,$04).
  $8A4C,$03 #REGde=#R$8A55.
  $8A4F,$02 Jump to #R$8A11.

t $8A51 Messaging: Banner Text
N $8A51 #FONTaddr=$D347,attr=$47,chars=0(1UP)(1up)
@ $8A51 label=String_1UP
  $8A51,$04,h$01,$02:$01 "1UP" (#COLOUR(#PEEK(#PC)) is the attribute).
N $8A55 #FONTaddr=$D347,attr=$47,chars=0(2UP)(2up)
@ $8A55 label=String_2UP
  $8A55,$04,h$01,$02:$01 "2UP" (#COLOUR(#PEEK(#PC)) is the attribute).
N $8A59 #FONTaddr=$D347,attr=$45,chars=0(HI)(hi)
@ $8A59 label=String_HI
  $8A59,$03,h$01,$01:$01 "HI" (#COLOUR(#PEEK(#PC)) is the attribute).

c $8A5C Mask Sprite
@ $8A5C label=MaskSprite
D $8A5C XOR the old (cached) image of a masked sprite off the screen
. and its new image on, row by row, using the remaining row counts in
. #R$5E5A (old image) and #R$5E59 (new image).
E $8A5C View the equivalent code in;
. #LIST
. { #JETPAC$773A }
. { #TRANZAM$7170 }
. LIST#
R $8A5C HL Screen address
R $8A5C DE Graphic pointer
N $8A5C Draw remaining rows from the current masked pair.
  $8A5C,$04 Jump to #R$8A70 if the row counter is zero.
  $8A60,$04 Decrease the row counter and draw the next row of the old image.
  $8A64,$01 Switch to the shadow registers.
  $8A65,$04 Jump to #R$8A6D if the shadow row counter is zero.
@ $8A69 label=MaskSprite_Loop
  $8A69,$04 Decrease the shadow row counter and draw the next row of
. the new image.
@ $8A6D label=MaskSprite_NextSide
  $8A6D,$03 Switch back and loop to #R$8A5C.
@ $8A70 label=MaskSprite_TryShadow
  $8A70,$01 Switch to the shadow registers.
  $8A71,$04 Jump to #R$8A69 if the shadow row counter is still
. live.
@ $8A75 label=MaskSprite_FinishSprite
N $8A75 Finish the sprite if any rows remain to be erased or drawn.
  $8A75,$01 Switch back to the normal registers.
@ $8A76 label=MaskSprite_TestRemaining
  $8A76,$09 Return if both #R$5E5A and #R$5E59 are zero.
  $8A7F,$05 Write #N$00 to #R$5E5A and switch register sets.
  $8A84,$05 Load the remaining row count and clear #REGa.
@ $8A89 label=MaskSprite_StoreRowCount
  $8A89,$03 Write the remaining row count to #R$5E59.
  $8A8C,$03 Switch back and loop to #R$8A5C.
N $8A8F Reached by the self-modified shift (operand #N$F2) when the mask
. is byte-aligned: only one screen byte is XORed.
  $8A8F,$04 Switch the pair and jump to #R$8AAF.
N $8A93 Load and shift the next mask byte for a row of the
. old image.
@ $8A93 label=MaskSprite_LoadMask
  $8A93,$08 Load the next mask byte from #REGde.
@ $8A9B label=MaskSprite_ShiftMask
  $8A9B,$02 Self-modifying shift. The operand is written by
. #R$8B5E.
  $8A9D,$08 Shift the mask left into pixel alignment.
@ $8AA5 label=MaskSprite_XORFirst
  $8AA5,$05 XOR the first mask byte onto the screen.
  $8AAA,$01 Fetch the new column.
  $8AAB,$02,b$01 Keep only bits 0-4.
  $8AAD,$02 Jump to #R$8AB2 if the row wrapped.
@ $8AAF label=MaskSprite_XORSecond
  $8AAF,$03 XOR the second mask byte onto the screen.
N $8AB2 Step the screen address up one pixel line.
@ $8AB2 label=MaskSprite_MoveUp
  $8AB2,$02 Restore the graphic pointer and screen address.
  $8AB4,$03 Move up one pixel.
  $8AB7,$02,b$01 Keep only bits 0-2.
  $8AB9,$01 Return if a character-row boundary was not crossed.
  $8ABA,$04 Subtract #N$20 from the column address.
  $8ABE,$01 Return if that wrapped into the previous third.
  $8ABF,$04 Add #N$08 to the line byte.
  $8AC3,$01 Return.
N $8AC4 Reached by the self-modified shift (operand #N$F2) when the mask
. is byte-aligned: only one screen byte is XORed.
  $8AC4,$04 Switch the pair and jump to #R$8AAF.
N $8AC8 Load and shift the next mask byte for a row of the
. new image.
@ $8AC8 label=MaskSprite_LoadMaskAgain
  $8AC8,$08 Load the next mask byte from #REGde.
@ $8AD0 label=MaskSprite_ShiftAndPlace
  $8AD0,$02 Self-modifying shift. The operand is written by
. #R$8B24.
  $8AD2,$0A Shift the mask left into pixel alignment and jump to
. #R$8AA5.
  $8ADC,$0C Call #R$86A1, clear #R$5E5A and jump to #R$8A5C.

c $8AE8 Clear Mask Scratch
@ $8AE8 label=ClearMaskScratch
D $8AE8 Zero #R$5E59 and #R$5E58, reload the actor's cached mask sprite with
. #R$8B52 and carry on drawing at #R$8A5C.
R $8AE8 IX Actor slot
  $8AE8,$08 Write #N$00 to #R$5E59, #R$5E58 and the row
. counter.
  $8AF0,$07 Switch register sets, reload the cached sprite and
. jump to #R$8A5C.

c $8AF7 Position Mask Sprite
@ $8AF7 label=PositionMaskSprite
D $8AF7 Convert the actor's world position into a screen column. If it is on
. screen, work out the pixel shift, the screen address and the sprite size,
. and cache them on the actor.
R $8AF7 IX Actor slot
  $8AF7,$06 Fetch the actor's world X position.
  $8AFD,$07 Subtract the scroll position at #R$607A.
  $8B04,$04 Add the #N($0078,$04,$04) draw offset.
  $8B08,$01 Fetch the high byte of the screen column.
  $8B09,$02,b$01 Keep only bits 0-4.
  $8B0B,$03 Jump to #R$867F if the actor is off-screen.
  $8B0E,$03 Store the screen column in *#REGix+#N$01.
N $8B11 Look up the sprite graphic and work out the pixel
. shift from the screen column.
  $8B11,$03 Call #R$857F.
  $8B14,$06 Fetch the screen column and actor Y.
  $8B1A,$02 Build a pixel-shift index from the column.
  $8B1C,$02,b$01 Keep only bits 0-2.
  $8B1E,$04 Jump to #R$8B24 if the shift is not #N$07.
  $8B22,$02 Set the shift operand to #N$F2.
@ $8B24 label=PositionMaskSprite_StoreShift
  $8B24,$06 Write the shift to #R$8AD0(#N$8AD1) and
. *#REGix+#N$09.
N $8B2A Choose the scratch width for the shift.
  $8B2A,$02 Set the scratch width to #N$01.
  $8B2C,$02 Jump to #R$8B2F if the shift was #N$07.
  $8B2E,$01 Widen the scratch width to #N$02.
@ $8B2F label=PositionMaskSprite_StoreWidth
  $8B2F,$06 Write the scratch width and cache the actor Y.
N $8B35 Work out the screen address, then cache the sprite
. size and pointers on the actor.
  $8B35,$03 Call #R$851E.
  $8B38,$0B Copy the sprite height into #R$5E59, #R$5E58 and
. *#REGix+#N$0A.
  $8B43,$0C Cache the graphic pointer and screen address on the
. actor.
  $8B4F,$02 Clear the row counter.
  $8B51,$01 Return.

c $8B52 Reload Mask Cache
@ $8B52 label=ReloadMaskCache
D $8B52 Reload the cached graphic pointer, screen address, shift, row count
. and Y position from the actor into the draw workspace.
R $8B52 IX Actor slot
  $8B52,$06 Fetch the cached graphic pointer.
  $8B58,$06 Fetch the cached screen address.
  $8B5E,$06 Write the cached shift to #R$8A9B(#N$8A9C).
  $8B64,$06 Write the cached row count to #R$5E5A.
  $8B6A,$06 Write the cached Y position to #R$5E56.
  $8B70,$02 Clear the row counter.
  $8B72,$01 Return.

c $8B73 Draw Object Sprite
@ $8B73 label=DrawObjectSprite
D $8B73 Position an alien or pickup sprite and draw it through
. #R$8A5C.
R $8B73 IX Actor slot
N $8B73 #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$8B73 | =h After #R$8733 }
. { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SIM(start=$81BB,stop=$81D6,sp=$5E00)
. #POKES$60D8,$59;$60DA,$58;$60DB,$00;$60DC,$90;$60DD,$00;$60DF,$47
. #SCR$04,$10,$10,$06,$04(shot-before)
. | #SIM(start=$A81C,stop=$A81F,ix=$60D8,sp=$5E00)
. #SCR$04,$10,$10,$06,$04(shot-drawn)
. | #SIM(start=$A81F,stop=$A822,ix=$60D8,sp=$5E00)
. #SCR$04,$10,$10,$06,$04(shot-coloured) } UDGTABLE# #POPS
N $8B73 Position an alien or pickup sprite and draw it.
  $8B73,$03 Call #R$8B52.
  $8B76,$01 Switch to the shadow registers.
  $8B77,$03 Call #R$8AF7.
  $8B7A,$01 Switch back to the normal registers.
N $8B7B Compare the cached Y position with the actor Y.
  $8B7B,$06 Subtract the actor Y from #R$5E56.
  $8B81,$03 Jump to #R$8A76 if they match.
  $8B84,$03 Jump to #R$8B96 if the actor is below the cached
. position.
  $8B87,$01 Store the Y difference in the row counter.
  $8B88,$07 Jump to #R$8A76 if the Y difference
. is greater than #R$5E5A.
  $8B8F,$07 Subtract it from #R$5E5A and jump to #R$8A5C.
@ $8B96 label=DrawObjectSprite_ClipHeight
  $8B96,$04 Switch register sets and negate the Y difference.
  $8B9A,$07 Jump to #R$8A75 if the Y difference
. is greater than #R$5E59.
  $8BA1,$04 Subtract it from the row count and jump to
. #R$8A89.

c $8BA5 Blank Play Area
@ $8BA5 label=BlankPlayArea
D $8BA5 Clear the playfield pixels upward from #N($57BF), one scan
. line at a time.
N $8BA5 Clear the playfield pixels upward from #N$57BF.
  $8BA5,$03 Set the start address to #N$57BF.
  $8BA8,$03 Set the line width to #N$20 and the line count to
. #N$88.
@ $8BAB label=BlankPlayArea_Loop
  $8BAB,$02 Stash the counters and screen address.
@ $8BAD label=BlankPlayArea_WriteByte
  $8BAD,$02 Write #N$00 to the current byte.
  $8BAF,$01 Move left one byte.
  $8BB0,$02 Decrease the column counter and loop back to
. #R$8BAD until the line is clear.
N $8BB2 Move up one scan line and repeat until every line is clear.
  $8BB2,$01 Restore the screen address from the stack.
  $8BB3,$03 Call #R$85F6.
  $8BB6,$01 Restore the counters from the stack.
  $8BB7,$01 Decrease the line count.
  $8BB8,$02 Jump back to #R$8BAB until every line is clear.
  $8BBA,$01 Return.

c $8BBB Draw HUD Panel
@ $8BBB label=DrawHUDPanel
D $8BBB Print the dashboard graphic as a #N$1E by #N$03 font
. block, then write its attributes.
E $8BBB View the equivalent code in;
. #LIST
. { #COOKIE$5FE1 }
. { #TRANZAM$69BC }
. LIST#
N $8BBB Print the dashboard graphic as a #N$1E by #N$03 font.
  $8BBB,$04 Stash the current font pointer.
  $8BBF,$06 Write #R$DD97 to #R$5E04.
N $8BC5 The panel is printed like a font.
  $8BC5,$03 Set the size to #N$1E columns and #N$03 rows.
  $8BC8,$03 Set the pixel-data pointer to #R$DE5F.
  $8BCB,$03 Set the screen position to #N$4041.
@ $8BCE label=DrawHUDPanel_Pixel_Row
  $8BCE,$02 Stash the counters and screen address.
@ $8BD0 label=DrawHUDPanel_Pixel_Column
  $8BD0,$09 Print the next panel character and loop back to
. #R$8BD0 until the row is done.
  $8BD9,$09 Restore this row, step down one character row and
. loop back to #R$8BCE until every row is printed.
N $8BE2 Now write the attribute bytes.
  $8BE2,$03 Set the attribute-data pointer to #R$DEB9.
  $8BE5,$03 Set the attribute position to #N$5841.
  $8BE8,$03 Set the size to #N$1E columns and #N$03 rows.
@ $8BEB label=DrawHUDPanel_Attribute_Row
  $8BEB,$02 Stash the counters and attribute address.
@ $8BED label=DrawHUDPanel_Attribute_Column
  $8BED,$06 Write the next attribute byte and loop back to
. #R$8BED until the row is done.
  $8BF3,$09 Restore this row, step down one attribute row and
. loop back to #R$8BEB until every row is painted.
N $8BFC Restore the old font pointer.
  $8BFC,$04 Restore the previous font pointer to #R$5E04.
  $8C00,$01 Return.

c $8C01 Draw Gauge
@ $8C01 label=DrawGauge
D $8C01 Draw a fuel/level bar at the given screen position, using
. the gauge value as both length and gradient.
R $8C01 A Gauge value (bits 3-7 whole cells, bits 0-2 gradient)
R $8C01 HL Screen location
N $8C01 Stash the gauge value for later.
  $8C01,$01 Stash the gauge byte.
N $8C02 Stash the screen location for later, as we'll need
. it to gain the screen buffer address.
  $8C02,$01 Stash #REGhl on the stack.
  $8C03,$03 Call #R$8506.
N $8C06 Restore the gauge value.
  $8C06,$01 #REGa=#REGc.
N $8C07 Divide by #N$08 to leave the number of whole cells.
  $8C07,$03 Rotate the bits right three times (including the carry).
  $8C0A,$02,b$01 Keep only bits 0-4.
  $8C0C,$02 Jump to #R$8C1A if there are no whole cells to fill.
  $8C0E,$01 #REGb=#REGa.
N $8C0F Copy the INK bits into PAPER as the bar is filled.
@ $8C0F label=DrawGauge_Find
  $8C0F,$01 Fetch the current attribute byte.
  $8C10,$03 Rotate the bits left three times (including the carry).
  $8C13,$02,b$01 Keep only bits 3-5 (the INK bits, now in the PAPER position).
  $8C15,$02 Merge them back into the attribute byte.
  $8C17,$01 Increment #REGhl by one.
  $8C18,$02 Decrease the counter by one and jump back to
. #R$8C0F until it is zero.
N $8C1A Fetch the attribute byte for where the gauge ends.
@ $8C1A label=DrawGauge_Draw
  $8C1A,$01 #REGa=*#REGhl.
N $8C1B Remove the PAPER bits.
  $8C1B,$02,b$01 Keep only bits 0-2, 6-7.
  $8C1D,$01 Write #REGa back to *#REGhl.
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
  $8C2A,$02 Merge in the column bits.
N $8C2C Restore the gauge value.
  $8C2C,$01 #REGa=#REGc.
N $8C2D The gradient lines are stored in the font at: #R$D51F.
. #UDGTABLE(default,centre,centre)
. { #N$00 | #FONTaddr=$D347,attr=$47,chars=0([)(gradient-0) }
. { #N$01 | #FONTaddr=$D347,attr=$47,chars=0(\)(gradient-1) }
. { #N$02 | #FONTaddr=$D347,attr=$47,chars=0(])(gradient-2) }
. { #N$03 | #FONTaddr=$D347,attr=$47,chars=0(^)(gradient-3) }
. { #N$04 | #FONTaddr=$D347,attr=$47,chars=0(_)(gradient-4) }
. { #N$05 | #FONTaddr=$D347,attr=$47,chars=0(`)(gradient-5) }
. { #N$06 | #FONTaddr=$D347,attr=$47,chars=0(a)(gradient-6) }
. { #N$07 | #FONTaddr=$D347,attr=$47,chars=0(b)(gradient-7) }
. UDGTABLE#
N $8C2D There are 8 gradient line images, so keep the
. index between #N$00 and #N$07.
  $8C2D,$02,b$01 Keep only bits 0-2.
N $8C2F The first value is #N$5B which corresponds to "#FONTaddr=$D347,attr=$47,chars=0([)(gradient-0)" (the smallest gradient).
  $8C2F,$02 #REGa=#REGa+#N$5B.
  $8C31,$03 Call #R$89EF.
N $8C34 Restore the gauge value.
  $8C34,$01 #REGa=#REGc.
  $8C35,$01 Flip the bits.
  $8C36,$02,b$01 Keep only bits 0-2.
  $8C38,$01 Return if the result is not zero.
  $8C39,$02 #REGa=#N$20.
  $8C3B,$03 Jump to #R$89EF.

c $8C3E Flash Score Label
@ $8C3E label=HandlerScoreLabel
D $8C3E Flash the active player's 1UP or 2UP banner label, or
. clear the actor if #R$5E6C is set.
E $8C3E View the equivalent code in;
. #LIST
. { #COOKIE$7020 }
. { #SABREWULF$AEA1 }
. LIST#
R $8C3E IX Actor slot
N $8C3E Flash the active player's 1UP or 2UP banner label.
  $8C3E,$06 If #R$5E6C is zero, jump to #R$8C49.
  $8C44,$04 Write #N$00 to *#REGix+#N$00.
  $8C48,$01 Return.
N $8C49 Controller for handling whether to action 1UP or 2UP score label.
@ $8C49 label=ScoreLabelFlash
  $8C49,$06 If #R$5E65 is not zero, jump to #R$8C6C.
N $8C4F Flash 1UP score label.
  $8C4F,$03 #REGhl=#N($0018,$04,$04) (position of the 1UP score label).
N $8C52 Set flash state for the 3-attributes of the score label.
@ $8C52 label=FlashText
  $8C52,$03 Call #R$8506.
  $8C55,$02 Set a letter counter in #REGb for #N$03 loops.
@ $8C57 label=FlashText_Loop
  $8C57,$01 Fetch the attribute byte.
  $8C58,$02,b$01 Ensure bit 7 is set (the flash bit).
  $8C5A,$01 Write the attribute byte back to *#REGhl.
  $8C5B,$01 Increment the attribute address pointer by one.
  $8C5C,$02 Decrease the counter by one and jump back to
. #R$8C57 until it is zero.
  $8C5E,$01 Return.

c $8C5F Unset Flash Text
@ $8C5F label=UnsetFlashText
D $8C5F Clear the FLASH bit of the three score label attributes at the
. screen position in #REGhl.
R $8C5F HL Pixel address co-ordinates
  $8C5F,$03 Call #R$8506.
  $8C62,$02 Set a letter counter in #REGb for #N$03 loops.
@ $8C64 label=UnsetFlashText_Loop
  $8C64,$01 Fetch the attribute byte.
  $8C65,$02,b$01 Keep only bits 0-6 (i.e. everything except the flash bit).
  $8C67,$01 Write the attribute byte back to *#REGhl.
  $8C68,$01 Increment the attribute address pointer by one.
  $8C69,$02 Decrease the counter by one and jump back to
. #R$8C64 until it is zero.
  $8C6B,$01 Return.

c $8C6C Flash 2UP Score Label
@ $8C6C label=FlashScoreLabel2UP
D $8C6C Point #REGhl at the 2UP score label, then flash it at #R$8C52.
  $8C6C,$03 #REGhl=#N($00D8,$04,$04) (position of the 2UP score label).
  $8C6F,$02 Jump to #R$8C52.

c $8C71 Handler: Jetman
@ $8C71 label=Handler_Jetman
D $8C71 Handler for Jetman while he is walking on the ground. Counts down
. #R$5E67 at the start of a turn, then draws the fuel gauge and reads the
. controls.
R $8C71 IX Actor slot
N $8C71 Count down #R$5E67, or skip straight to play.
  $8C71,$07 If #R$5E67 is zero, jump to #R$8C99.
  $8C78,$01 Decrement #R$5E67 by one.
  $8C79,$02 Jump to #R$8C3E if the delay timer is still active.
N $8C7B Play the pickup tone and unflash the score label.
  $8C7B,$03 Call #R$B8C9.
  $8C7E,$03 #REGa=*#R$5EA0.
  $8C81,$02,b$01 Keep only bit 0.
  $8C83,$03 Write the result to #R$5EA2.
N $8C86 Pick the score label of the active player to
. unflash.
  $8C86,$06 Jump to #R$8C94 if #R$5E65 is not zero.
  $8C8C,$03 #REGhl=#N($0018,$04,$04).
@ $8C8F label=Handler_Jetman_AfterLevel
  $8C8F,$03 Call #R$8C5F.
  $8C92,$02 Jump to #R$8C99.
@ $8C94 label=Handler_Jetman_Draw
  $8C94,$03 #REGhl=#N($00D8,$04,$04).
  $8C97,$02 Jump to #R$8C8F.
@ $8C99 label=Handler_Jetman_Play
N $8C99 Draw the fuel gauge and read the controls.
  $8C99,$03 #REGhl=#N($1040,$04,$04).
  $8C9C,$03 Fetch the high fuel byte from #R$608F.
  $8C9F,$03 Call #R$8C01.
N $8CA2 Read the controls and walk left or right, or take
. off if UP is pressed.
  $8CA2,$03 Call #R$8F90.
  $8CA5,$05 Jump to #R$8CE2 if LEFT is pressed.
  $8CAA,$05 Jump to #R$8CF4 if RIGHT is pressed.
  $8CAF,$02 Test whether UP is pressed.
  $8CB1,$05 Clear the horizontal speed.
  $8CB6,$03 Jump to #R$9005 if UP is pressed.
  $8CB9,$03 Jump to #R$8CDF.

c $8CBC Handler: Jetman Walk
@ $8CBC label=Handler_JetmanWalk
D $8CBC Jetman is walking on the ground. Keep him walking while there is
. ground beneath him, or launch him if UP is pressed or the ground ends.
R $8CBC IX Actor slot
N $8CBC Set the vertical thrust first. #N$F0
. is a signed -#N$10 upward thrust.
  $8CBC,$04 Write #N$F0 to *#REGix+#N$06.
  $8CC0,$03 Call #R$8F90.
  $8CC3,$05 Jump to #R$9005 if UP is pressed.
N $8CC8 Keep walking if there is ground under Jetman, otherwise launch.
  $8CC8,$03 Call #R$91BB.
  $8CCB,$05 Jump to #R$9005 if there is no terrain under
. Jetman.
  $8CD0,$05 Jump to #R$9005 if the cell beside Jetman is empty.
  $8CD5,$07 Jump to #R$9005 if bit 3 of the second terrain byte is
. set (a crater tile).
  $8CDC,$03 Jump to #R$8DC5 to move and animate Jetman.
@ $8CDF label=Handler_JetmanWalk_Face
  $8CDF,$03 Jump to #R$8DD9.
@ $8CE2 label=Handler_JetmanWalk_FaceLeft
N $8CE2 Face Jetman left and keep walking. #N$F0 is a
. signed -#N$10 leftward speed.
  $8CE2,$05 Write #N$F0 to *#REGix+#N$05.
N $8CE7 Bit 2 of the 0-based sprite index is the facing: reset means left and
. set means right.
  $8CE7,$03 #REGa=*#REGix+#N$00.
  $8CEA,$01 Decrease it to a 0-based sprite index.
  $8CEB,$02 Reset the facing bit.
  $8CED,$01 Restore the 1-based sprite ID.
  $8CEE,$03 Write #REGa back to *#REGix+#N$00.
  $8CF1,$03 Jump to #R$8CBC.

@ $8CF4 label=Handler_JetmanWalk_FaceRight
N $8CF4 Face Jetman right and keep walking. #N$10 is a
. signed +#N$10 rightward speed.
  $8CF4,$05 Write #N$10 to *#REGix+#N$05.
N $8CF9 Same 0-based facing bit as #R$8CE7, but set it for
. right.
  $8CF9,$03 #REGa=*#REGix+#N$00.
  $8CFC,$01 Decrease it to a 0-based sprite index.
  $8CFD,$02 Set the facing bit.
  $8CFF,$01 Restore the 1-based sprite ID.
  $8D00,$03 Write #REGa back to *#REGix+#N$00.
  $8D03,$03 Jump to #R$8CBC.

c $8D06 Handler: Jetman Movement
@ $8D06 label=Handler_JetmanMovement
D $8D06 Read the controls, spend fuel when flying, and update
. Jetman's facing and animation.
R $8D06 IX Actor slot
N $8D06 Face Jetman from LEFT/ RIGHT, or coast the current
. horizontal speed toward a rest.
  $8D06,$03 Call #R$8F90.
  $8D09,$05 Jump to #R$8EC5 if LEFT is pressed.
  $8D0E,$05 Jump to #R$8E5A if RIGHT is pressed.
  $8D13,$06 Jump to #R$8D3A if the horizontal speed is zero.
  $8D19,$03 Jump to #R$8D2A if Jetman is moving right.
N $8D1C Coast a leftward speed back toward rest.
  $8D1C,$02 Add #N$02 to the speed.
  $8D1E,$04 Jump to #R$8D37 if it is now less than #N$D0.
  $8D22,$04 Jump to #R$8D37 if it is at least #N$E0.
  $8D26,$02 Add a further #N$10 to leave the mid-band.
  $8D28,$02 Jump to #R$8D37.
@ $8D2A label=Handler_JetmanMovement_CoastRight
N $8D2A Coast a rightward speed back toward rest.
  $8D2A,$02 Decrease the speed by #N$02.
  $8D2C,$04 Jump to #R$8D37 if it is now at least #N$40.
  $8D30,$05 Jump to #R$8D37 if it is less than #N$30.
  $8D35,$02 Subtract a further #N$10 to leave the mid-band.
@ $8D37 label=Handler_JetmanMovement_Grounded
  $8D37,$03 Write the speed to *#REGix+#N$05.
@ $8D3A label=Handler_JetmanMovement_Read
N $8D3A Read the thrust keys while any fuel remains.
  $8D3A,$03 Call #R$8F90.
  $8D3D,$01 Stash the controls in #REGb.
  $8D3E,$06 Jump to #R$8D4E if #R$608F is zero.
  $8D44,$05 Jump to #R$8F34 if UP is pressed.
  $8D49,$05 Jump to #R$8F61 if DOWN is pressed.
@ $8D4E label=Handler_JetmanMovement_Gravity
N $8D4E Apply gravity when Jetman is not thrusting.
  $8D4E,$02 Clear the fuel-spend base.
  $8D50,$07 Jump to #R$8D5B if the vertical thrust is negative.
  $8D57,$04 Jump to #R$8D61 if the downward thrust is already
. at least #N$40.
@ $8D5B label=Handler_JetmanMovement_ThrustStep
N $8D5B The gravity step is #N$08 (signed +#N$08).
. Upward thrust uses the opposite #N$F8.
  $8D5B,$02 Set the downward step to #N$08.
@ $8D5D label=Handler_JetmanMovement_AddThrust
  $8D5D,$04 Add the step to the vertical thrust.
@ $8D61 label=Handler_JetmanMovement_Loop
N $8D61 Convert the thrust into a Y offset and test for the
. ground or a crater.
  $8D61,$03 Fetch the vertical thrust.
  $8D64,$08 Divide it by #N$10.
  $8D6C,$03 Add it to Jetman's Y position.
  $8D6F,$05 Jump to #R$8F61 if Jetman is above the play area.
  $8D74,$04 Jump to #R$8D90 if Jetman is still above the
. ground line.
N $8D78 Check the terrain beneath Jetman's new position.
  $8D78,$03 Call #R$91BB.
  $8D7B,$04 Jump to #R$8D8A if the first terrain cell is empty.
  $8D7F,$04 Jump to #R$8D8A if the second terrain cell is empty.
  $8D83,$07 Jump to #R$8FF4 if neither cell has bit 3 set (a crater).
@ $8D8A label=Handler_JetmanMovement_ClampThrust
N $8D8A When the cell is empty or a crater, snap to the ground line at Y=#N$AF
. and give a small upward thrust of #N$E0 (signed -#N$20).
  $8D8A,$04 Write #N$E0 to the vertical thrust.
  $8D8E,$02 #REGa=#N$AF.
@ $8D90 label=Handler_JetmanMovement_WriteY
  $8D90,$03 Write the Y position to *#REGix+#N$04.
@ $8D93 label=Handler_JetmanMovement_FuelFromSpeed
N $8D93 Spend fuel from the horizontal speed, then redraw the
. gauge.
  $8D93,$07 Jump to #R$8D9C if the horizontal speed is positive.
  $8D9A,$02 Negate it so the spend uses the magnitude.
@ $8D9C label=Handler_JetmanMovement_HalveSpeed
  $8D9C,$02 Halve the speed.
  $8D9E,$01 Add the fuel-spend base.
  $8D9F,$02 Double the result.
  $8DA1,$03 Store the spend in #REGbc.
  $8DA4,$03 Fetch the current fuel from #R$608E.
  $8DA7,$04 Jump to #R$8DBB if the fuel has already run out.
  $8DAB,$01 Reset the carry flag.
@ $8DAC label=Handler_JetmanMovement_SpendFuel
N $8DAC Subtract the fuel expenditure from the current fuel level.
N $8DAC See #POKE(infinite_fuel,Infinite Fuel).
  $8DAC,$02 Subtract the spend from the fuel.
  $8DAE,$04 Jump to #R$8DBB if the high fuel byte is not zero.
N $8DB2 Queue a tune and empty the tank when the fuel is
. used up.
  $8DB2,$03 #REGde=#R$BA2D.
  $8DB5,$03 Call #R$B9BC.
  $8DB8,$03 #REGhl=#N($0000,$04,$04).
N $8DBB Store the remaining fuel and redraw the gauge.
@ $8DBB label=Handler_JetmanMovement_AfterFuel
  $8DBB,$03 Write the remaining fuel to #R$608E.
  $8DBE,$01 Fetch the high fuel byte.
  $8DBF,$03 #REGhl=#N($1040,$04,$04) (gauge position).
  $8DC2,$03 Call #R$8C01.
@ $8DC5 label=Handler_JetmanMovement_Animate
N $8DC5 Walk the 0-based sprite index: keep bits 2-7
. (facing and flying/ walking) and merge bits 0-1
. from the frame timer.
  $8DC5,$03 Call #R$907B.
  $8DC8,$03 Fetch #R$5E42.
  $8DCB,$02,b$01 Keep only bits 0-1.
  $8DCD,$01 Stash the frame bits.
  $8DCE,$03 Fetch the actor type.
  $8DD1,$01 Decrease it to a 0-based sprite index.
  $8DD2,$02,b$01 Keep only bits 2-7.
  $8DD4,$01 Merge in the frame bits.
  $8DD5,$01 Restore the 1-based sprite ID.
  $8DD6,$03 Write it back to *#REGix+#N$00.
@ $8DD9 label=Handler_JetmanMovement_Draw
N $8DD9 Draw Jetman and fire the laser when FIRE is held.
  $8DD9,$03 Call #R$8701.
  $8DDC,$03 Call #R$8733.
  $8DDF,$03 Call #R$8F90.
  $8DE2,$05 Call #R$9DC0 if FIRE is pressed.
N $8DE7 Queue a flying jingle on some frames.
  $8DE7,$07 Jump to #R$8E07 if #R$FF54 is not
. #R$FF51.
  $8DEE,$03 Fetch #R$5E40.
  $8DF1,$02,b$01 Keep only bits 0-6.
  $8DF3,$02 Jump to #R$8E07 if the result is not zero.
N $8DF5 Pick a jingle from the table using the game timer and
. queue it.
  $8DF5,$03 Fetch #R$5E42.
  $8DF8,$02,b$01 Keep only bits 1-3.
  $8DFA,$03 Convert that index into #REGbc.
  $8DFD,$04 Point #REGhl at the matching entry in #R$9DB0.
  $8E01,$03 Fetch the tune pointer.
  $8E04,$03 Call #R$B9BC.
@ $8E07 label=Handler_JetmanMovement_RefillFromRover
N $8E07 Refill the tank when Jetman is beside the rover, then
. take a platform (action key) or board (SPACE).
  $8E07,$03 Fetch Jetman's Y position.
  $8E0A,$03 Return if it is less than #N$A8.
N $8E0D Return unless the rover is on this screen and within reach.
  $8E0D,$03 Fetch #R$607A.
  $8E10,$04 Fetch #R$6092.
  $8E14,$03 Subtract the rover position from Jetman's.
  $8E17,$04 Add a #N$0C tolerance.
  $8E1B,$01 Fetch the high byte of the gap.
  $8E1C,$02,b$01 Keep only bits 0-4.
  $8E1E,$01 Return if the rover is not on this screen.
  $8E1F,$04 Return if the low byte is at least #N$18.
N $8E23 Refill the fuel tank.
  $8E23,$06 Write #N$9000 to #R$608E.
N $8E29 Bit 0 of Jetman's flags is set while he is
. carrying an item.
  $8E29,$05 Return if Jetman is already carrying an item.
  $8E2E,$05 Jump to #R$8E4F if the action key is not pressed.
  $8E33,$03 #REGhl=#R$60F0.
  $8E36,$03 Return if world slot 4 is already in use.
N $8E39 Type #N$2E is the platform Jetman now carries.
  $8E39,$02 Write type #N$2E to the slot.
  $8E3B,$04 Move to the colour byte.
  $8E3F,$02 Write #COLOUR$43 to the colour.
  $8E41,$03 Set bit 0 of the slot flags.
  $8E44,$04 Write #N$00 to *#REGhl+#N$02.
  $8E48,$04 Set bit 0 of Jetman's flags.
  $8E4C,$03 Jump to #R$B8BD.
N $8E4F Board the rover if SPACE is pressed.
@ $8E4F label=Handler_JetmanMovement_TestSpace
  $8E4F,$04 Return if SPACE is not pressed.
  $8E53,$03 Call #R$8634.
  $8E56,$03 Call #R$930C.
  $8E59,$01 Return.

c $8E5A Face Jetman Right
@ $8E5A label=FaceJetmanRight
D $8E5A Set bit #N$02 of the actor type so Jetman faces right,
. then accelerate or cap the horizontal speed.
R $8E5A IX Actor slot
N $8E5A Decrease to the 0-based sprite index, set bit 2
. to face right, then write the 1-based ID back.
  $8E5A,$03 Fetch the actor type.
  $8E5D,$01 Decrease it to a 0-based sprite index.
  $8E5E,$02 Set the facing bit.
  $8E60,$01 Restore the 1-based sprite ID.
  $8E61,$03 Write it back to *#REGix+#N$00.
N $8E64 Push the speed right while any fuel remains. Bit 0
. of the actor flags is set while Jetman is carrying an
. item, which slows him down.
  $8E64,$06 Jump to #R$8E97 if Jetman is carrying an item.
  $8E6A,$07 Jump to #R$8E89 if the horizontal speed is negative.
N $8E71 Settle on the slow speed if the fuel has run out.
  $8E71,$01 Stash the speed in #REGaf'.
  $8E72,$06 Jump to #R$8E93 if #R$608F is zero.
N $8E78 Speed up to the right unless the speed is already at the cap.
  $8E78,$01 Restore the speed.
  $8E79,$05 Jump to #R$8D3A if the speed is already at least
. #N$40.
  $8E7E,$02 Add #N$08 to the speed.
  $8E80,$04 Jump to #R$8E86 if it is still less than #N$30.
  $8E84,$02 Add a further #N$10 to leave the mid-band.
@ $8E86 label=FaceJetmanRight_Loop
  $8E86,$03 Jump to #R$8D37.
@ $8E89 label=FaceJetmanRight_ReverseLeft
N $8E89 Reverse a leftward speed toward the right.
  $8E89,$04 Jump to #R$8E8F if the speed is at least #N$D0.
  $8E8D,$02 Add #N$10 to the speed.
@ $8E8F label=FaceJetmanRight_AddStep
  $8E8F,$02 Add #N$08 to the speed.
  $8E91,$02 Jump to #R$8E86.
@ $8E93 label=FaceJetmanRight_NoFuel
N $8E93 With no fuel, settle on a slow rightward speed of #N$10 (signed +#N$10).
  $8E93,$02 Set a slow rightward speed of #N$10.
  $8E95,$02 Jump to #R$8E86.
@ $8E97 label=FaceJetmanRight_Carrying
N $8E97 While carrying an item, use a slower rightward cap.
  $8E97,$07 Jump to #R$8EB0 if the horizontal speed is negative.
N $8E9E Settle on the slow speed if the fuel has run out.
  $8E9E,$01 Stash the speed in #REGaf'.
  $8E9F,$06 Jump to #R$8EBB if #R$608F is zero.
N $8EA5 Speed up to the right unless the speed is already at the cap.
  $8EA5,$01 Restore the speed.
  $8EA6,$05 Jump to #R$8EC0 if the speed is already at least
. #N$20.
  $8EAB,$02 Add #N$04 to the speed.
  $8EAD,$03 Jump to #R$8D37.
N $8EB0 Reverse a leftward speed toward the right.
@ $8EB0 label=FaceJetmanRight_CarryingClamp
  $8EB0,$04 Jump to #R$8EB6 if the speed is at least #N$D0.
  $8EB4,$02 Add #N$10 to the speed.
@ $8EB6 label=FaceJetmanRight_CarryingStep
  $8EB6,$02 Add #N$08 to the speed.
  $8EB8,$03 Jump to #R$8D37.
@ $8EBB label=FaceJetmanRight_CarryingSlow
N $8EBB With no fuel while carrying an item, settle on #N$10 (signed +#N$10).
  $8EBB,$02 Set a slow rightward speed of #N$10.
  $8EBD,$03 Jump to #R$8D37.
@ $8EC0 label=FaceJetmanRight_CarryingFast
N $8EC0 Cap the rightward speed at #N$20 while carrying an item.
  $8EC0,$02 Set a rightward cap of #N$20.
  $8EC2,$03 Jump to #R$8D37.

c $8EC5 Face Jetman Left
@ $8EC5 label=FaceJetmanLeft
D $8EC5 Reset bit #N$02 of the actor type so Jetman faces left,
. then accelerate or cap the horizontal speed.
R $8EC5 IX Actor slot
N $8EC5 Decrease to the 0-based sprite index, reset bit
. 2 to face left, then write the 1-based ID back.
  $8EC5,$03 Fetch the actor type.
  $8EC8,$01 Decrease it to a 0-based sprite index.
  $8EC9,$02 Reset the facing bit.
  $8ECB,$01 Restore the 1-based sprite ID.
  $8ECC,$03 Write it back to *#REGix+#N$00.
N $8ECF Push the speed left while any fuel remains. Bit 0
. of the actor flags is set while Jetman is carrying an
. item, which slows him down.
  $8ECF,$06 Jump to #R$8F03 if Jetman is carrying an item.
  $8ED5,$07 Jump to #R$8EF3 if the horizontal speed is positive.
N $8EDC Settle on the slow speed if the fuel has run out.
  $8EDC,$01 Stash the speed in #REGaf'.
  $8EDD,$06 Jump to #R$8EFF if #R$608F is zero.
N $8EE3 Speed up to the left unless the speed is already at the cap.
  $8EE3,$01 Restore the speed.
  $8EE4,$05 Jump to #R$8D3A if the speed is already below
. #N$D0.
  $8EE9,$02 Subtract #N$08 from the speed.
  $8EEB,$04 Jump to #R$8E86 if it is still at least #N$E0.
  $8EEF,$02 Subtract a further #N$10 to leave the mid-band.
  $8EF1,$02 Jump to #R$8E86.
@ $8EF3 label=FaceJetmanLeft_ReverseRight
N $8EF3 Reverse a rightward speed toward the left.
  $8EF3,$04 Jump to #R$8EFB if the speed is less than #N$30.
  $8EF7,$02 Subtract #N$10 from the speed.
  $8EF9,$02 Jump to #R$8E86.
@ $8EFB label=FaceJetmanLeft_SubtractStep
  $8EFB,$02 Subtract #N$08 from the speed.
  $8EFD,$02 Jump to #R$8E86.
@ $8EFF label=FaceJetmanLeft_NoFuel
N $8EFF With no fuel, settle on a slow leftward speed of #N$F0 (signed -#N$10).
  $8EFF,$02 Set a slow leftward speed of #N$F0.
  $8F01,$02 Jump to #R$8E86.
@ $8F03 label=FaceJetmanLeft_Carrying
N $8F03 While carrying an item, use a slower leftward cap.
  $8F03,$07 Jump to #R$8F1C if the horizontal speed is positive.
N $8F0A Settle on the slow speed if the fuel has run out.
  $8F0A,$01 Stash the speed in #REGaf'.
  $8F0B,$06 Jump to #R$8F2A if #R$608F is zero.
N $8F11 Speed up to the left unless the speed is already at the cap.
  $8F11,$01 Restore the speed.
  $8F12,$05 Jump to #R$8F2F if the speed is already below
. #N$F0.
  $8F17,$02 Subtract #N$04 from the speed.
  $8F19,$03 Jump to #R$8D37.
N $8F1C Reverse a rightward speed toward the left.
@ $8F1C label=FaceJetmanLeft_CarryingClamp
  $8F1C,$04 Jump to #R$8F25 if the speed is less than #N$30.
  $8F20,$02 Subtract #N$10 from the speed.
  $8F22,$03 Jump to #R$8D37.
@ $8F25 label=FaceJetmanLeft_CarryingStep
  $8F25,$02 Subtract #N$08 from the speed.
  $8F27,$03 Jump to #R$8D37.
@ $8F2A label=FaceJetmanLeft_CarryingSlow
N $8F2A With no fuel while carrying an item, settle on #N$F0 (signed -#N$10).
  $8F2A,$02 Set a slow leftward speed of #N$F0.
  $8F2C,$03 Jump to #R$8D37.
@ $8F2F label=FaceJetmanLeft_CarryingFast
N $8F2F Cap the leftward speed at #N$E0 (signed -#N$20)
. while carrying an item.
  $8F2F,$02 Set a leftward cap of #N$E0.
  $8F31,$03 Jump to #R$8D37.

c $8F34 Apply Upward Thrust
@ $8F34 label=ApplyJetmanUpwardThrust
D $8F34 Strengthen the upward thrust in *#REGix+#N$06 while
. UP is held, then continue the movement handler.
R $8F34 IX Actor slot
N $8F34 Strengthen the upward thrust while fuel remains.
  $8F34,$04 Fetch the vertical thrust.
  $8F38,$04 Jump to #R$8F4C if it is already positive.
  $8F3C,$05 Store the absolute thrust in #REGb.
N $8F41 Bit 0 of the actor flags is set while Jetman is
. carrying an item.
  $8F41,$06 Jump to #R$8F51 if Jetman is carrying an item.
  $8F47,$05 Jump to #R$8D61 if the thrust is already below
. #N$C0.
@ $8F4C label=ApplyJetmanUpwardThrust_Normal
N $8F4C The normal upward step is #N$F8 (signed
. -#N$08). Gravity uses the opposite step of #N$08.
  $8F4C,$02 Set the normal upward step to #N$F8.
  $8F4E,$03 Jump to #R$8D5D.
@ $8F51 label=ApplyJetmanUpwardThrust_Carrying
N $8F51 While Jetman is carrying an item, use a weaker
. upward step of #N$FC (signed -#N$04).
  $8F51,$02 Compare the thrust with #N$E0.
  $8F53,$02 Set the upward step to #N$FC.
  $8F55,$03 Jump to #R$8D5D if the thrust is at least #N$E0.
N $8F58 Cap Jetman's upward thrust at #N$E0 and spend
. extra fuel: #REGb=#N$40 is the base added at
. #R$8D93.
  $8F58,$04 Write #N$E0 to the vertical thrust.
  $8F5C,$02 Set the fuel-spend base to #N$40.
  $8F5E,$03 Jump to #R$8D61.

c $8F61 Clear Jetman Thrust
@ $8F61 label=ClearJetmanThrust
D $8F61 Stop vertical thrust, leave Jetman's Y position unchanged and
. go on to spend fuel.
R $8F61 IX Actor slot
N $8F61 Stop vertical thrust and skip the Y position update.
  $8F61,$04 Clear the vertical thrust.
N $8F65 #REGb is the fuel-spend base added at #R$8D93.
. #N$10 spends extra fuel; the gravity path uses
. #N$00.
  $8F65,$02 Set the fuel-spend base to #N$10.
  $8F67,$03 Jump to #R$8D93.

c $8F6A Controls: Cursor Joystick
@ $8F6A label=ReadCursorJoystick
D $8F6A Read the cursor keys and remap them onto the Kempston
. bit order.
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
D $8F90 Dispatch to the keyboard, cursor or Kempston reader
. chosen in #R$5E00.
R $8F90 O:A Controls
N $8F90 Dispatch to the keyboard, cursor or Kempston reader.
M $8F90,$07 Jump to #R$8F9F if #R$5E00 is set for keyboard
. controls.
  $8F93,$02,b$01 Keep only bits 1-2.
  $8F97,$04 Jump to #R$8F6A if #R$5E00 is set for cursor
. joystick controls.

c $8F9B Controls: Kempston Joystick
@ $8F9B label=ReadKempstonJoystick
D $8F9B Read the Kempston port and invert the bits so they
. match the keyboard decoder.
R $8F9B O:A Controls
E $8F9B View the equivalent code in;
. #LIST
. { #JETPAC$733A }
. { #PSSST$75CC }
. { #SABREWULF$B0D9 }
. { #TRANZAM$6188 }
. LIST#
  $8F9B,$02 #REGa=controls.
  $8F9D,$01 Flip the bits.
  $8F9E,$01 Return.

c $8F9F Controls: Keyboard
@ $8F9F label=ReadKeyboard
D $8F9F Read the movement and fire rows into the same bit
. order as the Kempston joystick.
R $8F9F O:A Controls
E $8F9F View the equivalent code in;
. #LIST
. { #SABREWULF$B0FA }
. LIST#
N $8F9F Start with every control bit released, then read 0-9.
  $8F9F,$02 Start with every control bit released.
  $8FA1,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$E7 | 1 / 0 | 2 / 9 | 3 / 8 | 4 / 7 | 5 / 6 }
. TABLE#
  $8FA7,$01 Flip the bits.
  $8FA8,$02,b$01 Keep only bits 0-4.
  $8FAA,$02 Jump to #R$8FAE if no number key is pressed.
  $8FAC,$02 Reset the DOWN bit.
N $8FAE Read the top letter row; any key pressed in it
. counts as UP.
@ $8FAE label=ReadKeyboard_Letters
  $8FAE,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DB | Q / P | W / O | E / I | R / U | T / Y }
. TABLE#
  $8FB4,$01 Flip the bits.
  $8FB5,$02,b$01 Keep only bits 0-4.
  $8FB7,$02 Jump to #R$8FBB if no letter in this row is
. pressed.
  $8FB9,$02 Reset the UP bit.
N $8FBB Read the home row; any key pressed in it counts
. as FIRE.
@ $8FBB label=ReadKeyboard_HomeRow
  $8FBB,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$BD | A / ENTER | S / L | D / K | F / J | G / H }
. TABLE#
  $8FC1,$01 Flip the bits.
  $8FC2,$02,b$01 Keep only bits 0-4.
  $8FC4,$02 Jump to #R$8FC8 if no letter in this row is
. pressed.
  $8FC6,$02 Reset the FIRE bit.
N $8FC8 Read the bottom-left row; X and V count as LEFT
. and C counts as RIGHT.
@ $8FC8 label=ReadKeyboard_ZXCV
  $8FC8,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $8FCE,$01 Flip the bits.
  $8FCF,$01 Stash the row in #REGb.
  $8FD0,$02,b$01 Keep only bits 2 and 4.
  $8FD2,$02 Jump to #R$8FD6 if neither key is pressed.
  $8FD4,$02 Reset the LEFT bit.
N $8FD6 Reset the RIGHT bit if C is pressed.
@ $8FD6 label=ReadKeyboard_TestC
  $8FD6,$01 Fetch the stored row.
  $8FD7,$02,b$01 Keep only bit 3.
  $8FD9,$02 Jump to #R$8FDD if "C" is not pressed.
  $8FDB,$02 Reset the RIGHT bit.
N $8FDD Read the bottom-right row; N counts as LEFT and
. M or B counts as RIGHT.
@ $8FDD label=ReadKeyboard_BNM
  $8FDD,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | FULL-STOP | M | N | B }
. TABLE#
  $8FE3,$01 Flip the bits.
  $8FE4,$01 Stash the row in #REGb.
  $8FE5,$02,b$01 Keep only bit 3.
  $8FE7,$02 Jump to #R$8FEB if "N" is not pressed.
  $8FE9,$02 Reset the LEFT bit.
N $8FEB Reset the RIGHT bit if M or B is pressed.
@ $8FEB label=ReadKeyboard_TestFullStop
  $8FEB,$01 Fetch the stored row.
  $8FEC,$02,b$01 Keep only bits 2 and 4.
  $8FEE,$02 Jump to #R$8FF2 if neither key is pressed.
  $8FF0,$02 Reset the RIGHT bit.
@ $8FF2 label=ReadKeyboard_ReturnControls
  $8FF2,$01 #REGa=the collected controls.
  $8FF3,$01 Return.

c $8FF4 Land Jetman
@ $8FF4 label=LandJetman
D $8FF4 Switch Jetman to the walking sprite, snap him to
. the ground line and redraw.
R $8FF4 IX Actor slot
N $8FF4 The actor type is a 1-based sprite ID. Decrease it
. to work on the 0-based index, set bit 3 to switch
. from the flying frames to the walking frames, then
. write the 1-based ID back.
  $8FF4,$03 Fetch the actor type.
  $8FF7,$01 Decrease it to a 0-based sprite index.
  $8FF8,$02 Set the walking-frame bit.
  $8FFA,$01 Restore the 1-based sprite ID.
  $8FFB,$03 Write it back to *#REGix+#N$00.
N $8FFE Snap Jetman to the ground line at Y=#N$AF.
  $8FFE,$04 Write #N$AF to Jetman's Y position.
N $9002 Draw the standing sprite and continue the
. movement handler.
  $9002,$03 Jump to #R$8DD9.

c $9005 Launch Jetman
@ $9005 label=LaunchJetman
D $9005 Switch to the flying frames, apply upward thrust and lift Jetman
. three pixels.
R $9005 IX Actor slot
N $9005 Decrease to the 0-based sprite index, reset
. bit 3 to switch from walking to flying frames,
. then write the 1-based ID back.
  $9005,$03 Fetch the actor type.
  $9008,$01 Decrease it to a 0-based sprite index.
  $9009,$02 Reset the walking-frame bit.
  $900B,$01 Restore the 1-based sprite ID.
  $900C,$03 Write it back to *#REGix+#N$00.
N $900F #N$F0 is a signed -#N$10 upward thrust. Lift
. Jetman three pixels off the ground line.
  $900F,$05 Write #N$F0 to the vertical thrust.
  $9014,$09 Decrease Jetman's Y position by three.
N $901D Draw the flying sprite and continue the
. movement handler.
  $901D,$03 Jump to #R$8DD9.

c $9020 Initialise Jetman
@ $9020 label=InitialiseJetman
D $9020 Respawn Jetman beside the parked rover: copy the default actor
. into #R$6078, set the start delay, take a life and refill the
. tank, unless #R$5E6C is already set.
N $9020 Copy the default actor into #R$6078 if the rover is parked.
  $9020,$05 Return if #R$5E6C is already set.
  $9025,$03 Fetch the rover type from #R$6090.
N $9028 Rover sprite IDs begin at #N$1A. Continue only
. when the type is in the #N$10 rover frames
. #N$1A-#N$29.
  $9028,$02 Subtract #N$1A.
  $902A,$03 Return if that is not a rover frame.
N $902D Copy the default Jetman actor into the live slot.
  $902D,$0B Copy the default #N$18-byte Jetman data from #R$9D5A to the
. Jetman slot at #R$6078.
  $9038,$03 Fetch #R$6092.
  $903B,$04 Fetch #R$6182.
  $903F,$03 Call #R$AD3F.
  $9042,$03 Fetch #R$6092 again.
  $9045,$02 Jump to #R$9076 if the rover is outside the
. #N$1000 range of #R$6182.
N $9047 Offset Jetman #N$40 to the right of the rover.
. The left-hand path at #R$9076 uses #N$FFC0.
  $9047,$03 Set the offset in #REGbc to #N($0040,$04,$04).
N $904A Set the terrain scroll position from the offset
. world X.
@ $904A label=InitialiseJetman_Scroll
  $904A,$03 Call #R$A002.
  $904D,$01 Fetch the low byte of the masked position.
  $904E,$02,b$01 Keep only bits 3-7.
  $9050,$01 Write it back to #REGl.
  $9051,$03 Write the position to #R$607A.
N $9054 Hold a longer start delay in a 2UP game.
  $9054,$02 #REGa=#N$40.
  $9056,$03 #REGhl=#R$5E00.
  $9059,$04 Jump to #R$905F if this is a 1UP game.
  $905D,$02 Add #N$3F to the delay.
@ $905F label=InitialiseJetman_WriteDelay
  $905F,$03 Write the delay to #R$5E67.
@ $9062 label=InitialiseJetman_ReadLives
  $9062,$03 Fetch #R$5EA1.
@ $9065 label=InitialiseJetman_DecreaseLives
N $9065 See #POKE(infinite_lives,Infinite Lives).
  $9065,$01 Decrease the lives counter by one.
@ $9066 label=InitialiseJetman_WriteLives
  $9066,$03 Write it back to #R$5EA1.
N $9069 #N$9000 is a full tank.
  $9069,$06 Fill #R$608E.
N $906F Clear #R$5E6C so Jetman is in play.
  $906F,$04 Write #N$00 to #R$5E6C.
  $9073,$03 Jump to #R$894F.
@ $9076 label=InitialiseJetman_OffsetLeft
N $9076 Offset Jetman #N$40 to the left of the rover.
  $9076,$03 Set the offset in #REGbc to #N$FFC0 (-#N$40).
  $9079,$02 Jump to #R$904A.

c $907B Apply Jetman Speed
@ $907B label=ApplyJetmanSpeed
D $907B Use the horizontal speed in *#REGix+#N$05 to update
. Jetman's world position.
R $907B IX Actor slot
  $907B,$03 Fetch the horizontal speed.
  $907E,$08 Divide it by #N$10.
  $9086,$01 Store the pixel step in #REGe.
  $9087,$02 Clear #REGd for a positive step.
  $9089,$03 Jump to #R$908E if the step is positive.
  $908C,$02 Set #REGd=#N$FF for a negative step.
@ $908E label=ApplyJetmanSpeed_AddWorldX
N $908E Add the step to the world X and wrap it to the
. planet width.
  $908E,$03 Fetch the high byte of the world X.
  $9091,$03 Fetch the low byte of the world X.
  $9094,$01 Fetch the fine X.
  $9095,$02,b$01 Keep only bits 0-2.
N $9097 Draw a new terrain column on a cell boundary, then
. scroll the terrain bitmap by the step.
  $9097,$02 Stash the world X and the step on the stack.
  $9099,$03 Call #R$915C if Jetman is on a cell boundary.
  $909C,$01 Restore the step from the stack.
  $909D,$03 Call #R$90AC.
N $90A0 Add the step to the world X and write it back.
  $90A0,$01 Restore the world X from the stack.
  $90A1,$01 Add the step to the world X.
  $90A2,$01 Fetch the high byte.
  $90A3,$02,b$01 Keep only bits 0-4.
  $90A5,$03 Write the high byte back to *#REGix+#N$03.
  $90A8,$03 Write the low byte back to *#REGix+#N$02.
  $90AB,$01 Return.
@ $90AC label=ApplyJetmanSpeed_ScrollLeft
N $90AC Scroll the terrain bitmap left or right by the pixel
. step.
  $90AC,$03 #REGhl=#N$50C0.
  $90AF,$02 Set a pixel row counter in #REGc for #N$08 loops.
  $90B1,$03 Return if there is no horizontal movement.
  $90B4,$03 Jump to #R$9109 if Jetman is moving right.
N $90B7 When Jetman is moving left, shift the terrain bitmap right.
  $90B7,$02 Negate the leftward step.
  $90B9,$03 Jump to #R$90D8 if the step is #N$01.
  $90BC,$03 Jump to #R$90EA if the step is #N$02.
  $90BF,$03 Fetch the low byte of the world X.
  $90C2,$02,b$01 Keep only bits 0-1.
  $90C4,$02 Jump to #R$90EA if Jetman is not on a 4-pixel
. boundary.
@ $90C6 label=ApplyJetmanSpeed_Loop
N $90C6 Rotate each pixel row right by four bits.
  $90C6,$01 Clear the accumulator.
  $90C7,$02 Set a column counter in #REGb for #N$20 loops.
  $90C9,$01 Stash the row start on the stack.
@ $90CA label=ApplyJetmanSpeed_RotateNibbleRight
  $90CA,$02 Rotate the nibble through the current byte.
  $90CC,$01 Move onto the next column.
  $90CD,$02 Decrease the column counter by one and loop back
. to #R$90CA until the row is done.
  $90CF,$01 Restore the row start from the stack.
  $90D0,$01 Move down one pixel row.
  $90D1,$03 Decrease the row counter by one and loop back to
. #R$90C6 until all eight rows are done.
N $90D4 Return the step actually scrolled (-#N$04) in #REGde.
  $90D4,$03 #REGde=#N$FFFC.
  $90D7,$01 Return.
@ $90D8 label=ApplyJetmanSpeed_RotateRowRight
N $90D8 Rotate each pixel row right by one bit.
  $90D8,$01 Clear the accumulator.
  $90D9,$02 Set a column counter in #REGb for #N$20 loops.
  $90DB,$01 Stash the row start on the stack.
@ $90DC label=ApplyJetmanSpeed_RotateByteRight
  $90DC,$02 Rotate the current byte right.
  $90DE,$01 Move onto the next column.
  $90DF,$02 Decrease the column counter by one and loop back
. to #R$90DC until the row is done.
  $90E1,$01 Restore the row start from the stack.
  $90E2,$01 Move down one pixel row.
  $90E3,$03 Decrease the row counter by one and loop back to
. #R$90D8 until all eight rows are done.
N $90E6 Return the step actually scrolled (-#N$01) in #REGde.
  $90E6,$03 #REGde=#N$FFFF.
  $90E9,$01 Return.
N $90EA Use a one-bit rotate if Jetman is on an odd pixel, otherwise
. fall through to a two-bit rotate.
@ $90EA label=ApplyJetmanSpeed_TestOddPixel
  $90EA,$03 Fetch the low byte of the world X.
  $90ED,$02,b$01 Keep only bit 0.
  $90EF,$02 Jump to #R$90D8 if Jetman is on an odd pixel.
@ $90F1 label=ApplyJetmanSpeed_RotateRowRight2
N $90F1 Rotate each pixel row right by two bits.
  $90F1,$03 Clear both accumulators.
  $90F4,$01 Stash the row start on the stack.
  $90F5,$02 Set a column counter in #REGb for #N$20 loops.
@ $90F7 label=ApplyJetmanSpeed_RotateByteRight2
  $90F7,$06 Rotate the current byte right twice.
  $90FD,$01 Move onto the next column.
  $90FE,$02 Decrease the column counter by one and loop back
. to #R$90F7 until the row is done.
  $9100,$01 Restore the row start from the stack.
  $9101,$01 Move down one pixel row.
  $9102,$03 Decrease the row counter by one and loop back to
. #R$90F1 until all eight rows are done.
N $9105 Return the step actually scrolled (-#N$02) in #REGde.
  $9105,$03 #REGde=#N$FFFE.
  $9108,$01 Return.
@ $9109 label=ApplyJetmanSpeed_ScrollRight
N $9109 When Jetman is moving right, shift the terrain bitmap left.
  $9109,$03 #REGhl=#N$50DF.
  $910C,$03 Jump to #R$912B if the step is #N$01.
  $910F,$03 Jump to #R$913D if the step is #N$02.
  $9112,$03 Fetch the low byte of the world X.
  $9115,$02,b$01 Keep only bits 0-1.
  $9117,$02 Jump to #R$913D if Jetman is not on a 4-pixel
. boundary.
@ $9119 label=ApplyJetmanSpeed_RotateRowLeft4
N $9119 Rotate each pixel row left by four bits.
  $9119,$01 Clear the accumulator.
  $911A,$02 Set a column counter in #REGb for #N$20 loops.
  $911C,$01 Stash the row start on the stack.
@ $911D label=ApplyJetmanSpeed_RotateNibbleLeft
  $911D,$02 Rotate the nibble through the current byte.
  $911F,$01 Move onto the previous column.
  $9120,$02 Decrease the column counter by one and loop back
. to #R$911D until the row is done.
  $9122,$01 Restore the row start from the stack.
  $9123,$01 Move down one pixel row.
  $9124,$03 Decrease the row counter by one and loop back to
. #R$9119 until all eight rows are done.
  $9127,$03 #REGde=#N($0004,$04,$04).
  $912A,$01 Return.
@ $912B label=ApplyJetmanSpeed_RotateRowLeft
N $912B Rotate each pixel row left by one bit.
  $912B,$01 Clear the accumulator.
  $912C,$02 Set a column counter in #REGb for #N$20 loops.
  $912E,$01 Stash the row start on the stack.
@ $912F label=ApplyJetmanSpeed_RotateByteLeft
  $912F,$02 Rotate the current byte left.
  $9131,$01 Move onto the previous column.
  $9132,$02 Decrease the column counter by one and loop back
. to #R$912F until the row is done.
  $9134,$01 Restore the row start from the stack.
  $9135,$01 Move down one pixel row.
  $9136,$03 Decrease the row counter by one and loop back to
. #R$912B until all eight rows are done.
  $9139,$03 #REGde=#N($0001,$04,$04).
  $913C,$01 Return.
N $913D Rotate by one bit if Jetman is on an odd pixel, else by two.
@ $913D label=ApplyJetmanSpeed_TestOddPixelRight
  $913D,$03 Fetch the low byte of the world X.
  $9140,$02,b$01 Keep only bit 0.
  $9142,$02 Jump to #R$912B if Jetman is on an odd pixel.
@ $9144 label=ApplyJetmanSpeed_RotateRowLeft2
N $9144 Rotate each pixel row left by two bits.
  $9144,$03 Clear both accumulators.
  $9147,$01 Stash the row start on the stack.
  $9148,$02 Set a column counter in #REGb for #N$20 loops.
@ $914A label=ApplyJetmanSpeed_RotateByteLeft2
  $914A,$06 Rotate the current byte left twice.
  $9150,$01 Move onto the previous column.
  $9151,$02 Decrease the column counter by one and loop back
. to #R$914A until the row is done.
  $9153,$01 Restore the row start from the stack.
  $9154,$01 Move down one pixel row.
  $9155,$03 Decrease the row counter by one and loop back to
. #R$9144 until all eight rows are done.
  $9158,$03 #REGde=#N($0002,$04,$04).
  $915B,$01 Return.

c $915C Draw New Column
@ $915C label=DrawNewColumn
D $915C When Jetman crosses a cell boundary, point
. #REGhl at the new terrain cell and #REGde at the
. screen column that has scrolled into view.
E $915C Continue on to #R$917C.
R $915C HL World X
R $915C DE Pixel step
R $915C O:HL Pointer to the cell after the drawn one
R $915C O:DE Screen address one character row below the column
N $915C Draw the new terrain column that has scrolled into
. view.
  $915C,$05 Jump to #R$919E if Jetman is moving left.
  $9161,$04 Add #N$80 to the world X.
  $9165,$01 Fetch the high byte.
  $9166,$02,b$01 Keep only bits 0-4.
  $9168,$01 Write it back to #REGh.
  $9169,$03 #REGde=#R$7000.
  $916C,$0C Divide the world position by #N$08.
  $9178,$01 #REGhl+=#REGde.
  $9179,$03 #REGde=#N$50DF.

c $917C Draw Terrain Column
@ $917C label=DrawTerrainColumn
D $917C Copy eight bytes of terrain graphic from #R$F66E into
. the screen column in #REGde.
R $917C HL Terrain cell pointer
R $917C DE Screen address
N $917C Copy eight bytes of terrain graphic into the screen column.
  $917C,$02 Stash the cell pointer and the screen address on
. the stack.
N $917E Work out the address of the graphic for the terrain cell.
  $917E,$01 Fetch the terrain cell.
  $917F,$02 #REGh=#N$00.
  $9181,$03 Multiply the cell index by #N$08.
  $9184,$03 #REGde=#R$F66E.
  $9187,$01 Point #REGhl at that graphic.
  $9188,$02 Set a pixel row counter in #REGb for #N$08 loops.
  $918A,$02 Restore the screen address from the stack, but
. stash a copy of it on the stack again.
@ $918C label=DrawTerrainColumn_Loop
  $918C,$02 Copy the graphic byte to the screen.
  $918E,$01 Move onto the next graphic byte.
  $918F,$01 Move down one pixel row.
  $9190,$02 Decrease the row counter by one and loop back to
. #R$918C until the column is drawn.
N $9192 Advance to the next screen row and the next terrain cell.
  $9192,$01 Restore the screen column from the stack.
  $9193,$04 Advance the screen pointer by one character row.
  $9197,$04 Add the carry into the high byte.
  $919B,$01 Restore the cell pointer from the stack.
  $919C,$01 Move onto the next cell.
  $919D,$01 Return.

c $919E Locate Terrain Cell
@ $919E label=LocateTerrainCell
D $919E Map a world position onto #R$7000 and draw that column.
R $919E HL World position
N $919E Map the world position onto #R$7000 and draw that column.
  $919E,$03 #REGde=#N$FF88.
  $91A1,$01 #REGhl+=#REGde.
  $91A2,$01 #REGa=#REGh.
  $91A3,$02,b$01 Keep only bits 0-4.
  $91A5,$01 #REGh=#REGa.
N $91A6 Convert the position into a terrain cell pointer.
  $91A6,$03 #REGde=#R$7000.
  $91A9,$0C Divide the world position by #N$08.
  $91B5,$01 #REGhl+=#REGde.
N $91B6 Aim at the leftmost screen column and draw it.
  $91B6,$03 #REGde=#N$50C0.
  $91B9,$02 Jump to #R$917C.

c $91BB Read Terrain Cell
@ $91BB label=ReadTerrainCell
D $91BB Return the two terrain bytes under the current actor.
R $91BB IX Actor slot
R $91BB O:D First terrain byte
R $91BB O:E Second terrain byte
R $91BB O:HL Terrain cell index
N $91BB Return the two terrain bytes under the current actor.
  $91BB,$03 Fetch the high byte of the world X.
  $91BE,$03 Fetch the low byte of the world X.
  $91C1,$01 Fetch the high byte.
  $91C2,$02,b$01 Keep only bits 0-4.
  $91C4,$01 Write it back to #REGh.
  $91C5,$0C Divide the world position by #N$08.
N $91D1 Read the first terrain byte from the cell.
  $91D1,$01 Stash the cell index on the stack.
  $91D2,$04 Point #REGhl at that terrain cell, offset from #R$7000.
  $91D6,$01 Fetch the first terrain byte.
  $91D7,$02 Restore the cell index from the stack, but stash
. a copy of it on the stack again.
N $91D9 Step to the next cell, wrapping the index, and read
. the second terrain byte.
  $91D9,$01 Move onto the next cell.
  $91DA,$01 Fetch the high byte.
  $91DB,$02,b$01 Keep only bits 0-1.
  $91DD,$01 Write it back to #REGh.
  $91DE,$01 Point #REGhl at that terrain cell.
  $91DF,$01 Fetch the second terrain byte.
  $91E0,$01 Restore the cell index from the stack.
  $91E1,$01 Return.

c $91E2 Handler: Moon Rover
@ $91E2 label=Handler_MoonRover
D $91E2 Drive the rover: refill the fuel gauge, read the controls and
. stop the rover at craters in the terrain ahead.
R $91E2 IX Actor slot
N $91E2 Refill the tank, then steer from the controls.
  $91E2,$06 Jump to #R$9267 if #R$5E6C is set.
  $91E8,$06 Write #N$9000 to #R$608E.
  $91EE,$01 Fetch the high fuel byte.
  $91EF,$03 #REGhl=#N($1040,$04,$04) (gauge position).
  $91F2,$03 Call #R$8C01.
N $91F5 Read the controls and speed the rover up if LEFT
. or RIGHT is held.
  $91F5,$03 Call #R$8F90.
  $91F8,$05 Jump to #R$92CB if RIGHT is pressed.
  $91FD,$05 Jump to #R$92BA if LEFT is pressed.
N $9202 Neither direction is held, so ease the speed back
. towards zero.
  $9202,$06 Jump to #R$9211 if the horizontal speed is zero.
  $9208,$03 Jump to #R$920F if the rover is moving right.
  $920B,$02 Add #N$01 to the speed.
  $920D,$02 Jump to #R$9211.
@ $920F label=Handler_MoonRover_Decelerate
  $920F,$02 Subtract #N$01 from the speed.
@ $9211 label=Handler_MoonRover_Loop
  $9211,$03 Write the speed to *#REGix+#N$05.
N $9214 Look ahead under the wheels for blocking terrain.
  $9214,$03 Fetch #R$607A.
  $9217,$07 Jump to #R$92B4 if the rover is moving left.
  $921E,$03 #REGde=#N$FFF8.
@ $9221 label=Handler_MoonRover_LookAhead
  $9221,$01 Add the look-ahead offset.
  $9222,$0C Divide the world position by #N$08.
  $922E,$01 Fetch the high byte.
  $922F,$02,b$01 Keep only bits 0-1.
  $9231,$01 Write it back to #REGh.
N $9232 Scan the cells ahead of the rover and stop it at an
. empty cell or a crater.
  $9232,$02 Set a cell counter in #REGb for #N$06 loops.
  $9234,$01 Switch the index into #REGde.
@ $9235 label=Handler_MoonRover_TestTerrain
  $9235,$03 #REGhl=#R$7000.
  $9238,$01 Point #REGhl at that terrain cell.
  $9239,$04 Jump to #R$924A if the cell is empty.
  $923D,$02,b$01 Keep only bit 3.
  $923F,$02 Jump to #R$924A if it is a crater.
N $9241 Step on to the next cell, wrapping the index.
  $9241,$01 Move onto the next cell.
  $9242,$01 Fetch the high byte.
  $9243,$02,b$01 Keep only bits 0-1.
  $9245,$01 Write it back to #REGd.
  $9246,$02 Decrease the cell counter by one and loop back
. to #R$9235 until the scan is done.
  $9248,$02 Jump to #R$9250.
N $924A Stop the rover: it has reached an empty cell or a crater.
@ $924A label=Handler_MoonRover_Stop
  $924A,$04 Write #N$00 to the horizontal speed.
  $924E,$02 Jump to #R$9264.
@ $9250 label=Handler_MoonRover_PickFrame
N $9250 Pick a facing frame from the fine X.
  $9250,$06 Jump to #R$9264 if the horizontal speed is zero.
  $9256,$03 Jump to #R$92A7 if the rover is moving left.
  $9259,$03 Fetch the low byte of the world X.
  $925C,$01 Rotate it right.
  $925D,$02,b$01 Keep only bits 0-1.
N $925F Sprite IDs begin at #R$BE90(#N$16) (#SPRITENAME$16).
  $925F,$02 Add #N$16 for the right-facing frames.
  $9261,$03 Write it to the actor type.
N $9264 Move the rover along the planet and draw its sprite.
@ $9264 label=Handler_MoonRover_ApplySpeed
  $9264,$03 Call #R$907B.
@ $9267 label=Handler_MoonRover_DrawSprite
  $9267,$03 Call #R$877C.
N $926A While Jetman is inactive, step the inactive counter
. and hand over to #R$9F3F.
  $926A,$06 Jump to #R$9277 if #R$5E6C is zero.
  $9270,$04 Increment #R$5E6C by one.
  $9274,$03 Jump to #R$9F3F.
N $9277 Colour the rover lights, body and banner.
@ $9277 label=Handler_MoonRover_ColourLights
  $9277,$03 Call #R$B87E.
  $927A,$03 #REGde=#R$BC9E.
  $927D,$03 Call #R$890A.
  $9280,$03 Call #R$AD22.
N $9283 Leave the rover if SPACE has just been pressed.
  $9283,$03 Call #R$933E.
  $9286,$03 Call #R$92DC if SPACE is pressed.
N $9289 Queue a jingle only when the tune buffer has
. finished and the random number allows it.
  $9289,$06 Return if #R$FF54 is not #R$FF51.
  $928F,$03 Fetch #R$5E40.
  $9292,$02,b$01 Keep only bits 0-6.
  $9294,$01 Return if the result is not zero.
N $9295 Choose a tune from the table using the game timer
. and queue it.
  $9295,$03 Fetch #R$5E42.
  $9298,$02,b$01 Keep only bits 1-3.
  $929A,$03 Convert that index into #REGbc.
  $929D,$04 Point #REGhl at the matching entry in #R$9DB0.
  $92A1,$03 Fetch the tune pointer.
  $92A4,$03 Jump to #R$B9BC.
N $92A7 Pick a left-facing frame from the fine X.
@ $92A7 label=Handler_MoonRover_FineX
  $92A7,$03 Fetch the low byte of the world X.
  $92AA,$01 Rotate it right.
  $92AB,$02,b$01 Keep only bits 0-1.
N $92AD Sprite IDs begin at #R$C9BF(#N$12) (#SPRITENAME$12).
  $92AD,$02 Add #N$12 for the left-facing frames.
  $92AF,$03 Write it to the actor type.
  $92B2,$02 Jump to #R$9264.
N $92B4 Look further ahead when the rover is moving left.
@ $92B4 label=Handler_MoonRover_LookLeft
  $92B4,$03 #REGde=#N$FFF0.
  $92B7,$03 Jump to #R$9221.
@ $92BA label=Handler_MoonRover_AccelerateLeft
N $92BA Accelerate left, but cap the speed at #N$E8.
  $92BA,$07 Jump to #R$92C6 if the horizontal speed is
. positive.
  $92C1,$05 Jump to #R$9211 if the speed is already below
. #N$E8.
@ $92C6 label=Handler_MoonRover_SubtractSpeed
  $92C6,$02 Subtract #N$02 from the speed.
  $92C8,$03 Jump to #R$9211.
@ $92CB label=Handler_MoonRover_AccelerateRight
N $92CB Accelerate right, but cap the speed at #N$28.
  $92CB,$07 Jump to #R$92D7 if the horizontal speed is
. negative.
  $92D2,$05 Jump to #R$9211 if the speed is already at least
. #N$28.
@ $92D7 label=Handler_MoonRover_AddSpeed
  $92D7,$02 Add #N$02 to the speed.
  $92D9,$03 Jump to #R$9211.
@ $92DC label=Handler_MoonRover_Leave
N $92DC Leave the rover and restore Jetman on foot.
  $92DC,$03 Call #R$B8C3.
  $92DF,$0B Copy the #N$0E bytes of rover state from #R$607A back out of the
. Jetman slot to #R$6092.
N $92EA Screen column #N$78 is standing beside the rover.
. Type #N$16 and above is facing right: walking
. frames #N$09 (left) and #N$0D (right), parked
. rover frames #N$1A and #N$22.
  $92EA,$04 Write #N$78 to *#REGix+#N$01.
  $92EE,$07 Jump to #R$9304 if the actor type is at least
. #N$16.
N $92F5 When facing left, walk with type #N$09 and park the rover as type #N$1A.
  $92F5,$04 Write #N$09 to the actor type.
  $92F9,$02 #REGa=#N$1A.
N $92FB Write the parked rover's type and finish by clearing the banner colour.
@ $92FB label=Handler_MoonRover_WriteType
  $92FB,$03 Write #REGa to #R$6090.
  $92FE,$03 Call #R$8634.
  $9301,$03 Jump to #R$AD33.
N $9304 When facing right, walk with type #N$0D and park the rover as type
. #N$22.
@ $9304 label=Handler_MoonRover_StandingFrame
  $9304,$04 Write #N$0D to the actor type.
  $9308,$02 #REGa=#N$22.
  $930A,$02 Jump to #R$92FB.

c $930C Board Moon Rover
@ $930C label=BoardMoonRover
D $930C Copy the rover state over Jetman, snap him to the seat and
. play #R$B8BD.
R $930C IX Actor slot
N $930C Copy the rover state over Jetman and snap him to the seat.
  $930C,$0B Copy the #N$09 bytes of rover state from #R$6097 over Jetman at
. #R$607F.
N $9317 Screen column #N$68 is the rover seat. Y=#N$AF
. is the ground line.
  $9317,$04 Write #N$68 to *#REGix+#N$01.
  $931B,$04 Write #N$AF to Jetman's Y position.
N $931F Bit 2 of the 0-based sprite index is facing.
. Type #N$12 is seated left, #N$16 is seated right.
  $931F,$03 Fetch the actor type.
  $9322,$01 Decrease it to a 0-based sprite index.
  $9323,$02,b$01 Keep only the facing bit.
  $9325,$02 Jump to #R$9338 if Jetman is facing right.
N $9327 "#SPRITENAME$12".
  $9327,$04 Write #N$12 to the actor type.
N $932B Clear the parked rover, stop Jetman and play the take-object sound.
@ $932B label=BoardMoonRover_Loop
  $932B,$04 Write #N$00 to #R$6090.
  $932F,$06 Write #N$00 to the speed and the thrust.
  $9335,$03 Jump to #R$B8BD.
N $9338 When Jetman faces right, seat him as type #N$16 and finish as above.
@ $9338 label=BoardMoonRover_WriteType
  $9338,$04 Write #N$16 to the actor type.
  $933C,$02 Jump to #R$932B.

c $933E Test Space Key
@ $933E label=TestSpaceKey
D $933E Return non-zero only on the call when SPACE (or SHIFT) goes
. down. #R$5E5D latches the key as held until it is released.
R $933E O:A Zero unless SPACE has just been pressed
N $933E Return non-zero when SPACE is first pressed.
  $933E,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { =r2 #N$7E | SPACE | FULL-STOP | M | N | B }
. { Shift | Z | X | C | V }
. TABLE#
N $9344 Test SPACE and clear the latch if it is up.
  $9344,$01 Flip the bits.
  $9345,$02,b$01 Keep only bit 0.
  $9347,$02 If the result is zero jump to #R$9350.
N $9349 Report a new press only if the latch was not already set.
  $9349,$03 #REGa=*#R$5E5D.
  $934C,$03 If #REGa is not zero then jump to #R$9354.
  $934F,$01 Increment #REGa by one.
@ $9350 label=TestSpaceKey_StoreLatch
  $9350,$03 Write #REGa to #R$5E5D.
  $9353,$01 Return.
@ $9354 label=TestSpaceKey_Clear
  $9354,$01 #REGa=#N$00.
  $9355,$01 Return.

c $9356 Draw Terrain
@ $9356 label=DrawTerrain
D $9356 Redraw the whole strip of moon surface along the bottom of the
. screen for the current scroll position, then colour the row of ground
. beneath it.
.
. Jetman always stands at pixel column #N$78, so the left-hand edge of the
. screen is #N$78 pixels behind his world X in #R$607A. That is divided by
. #N$08 to find the terrain cell at the left edge, as the world is
. #N$2000 pixels wide and #R$7000 holds one cell for every #N$08 of them
. (#N$400 cells), wrapping round at the far end. The #N$20 cells from there
. are drawn side by side along character row #N$16.
N $9356 Work out which terrain cell sits at the left-hand edge of the screen.
  $9356,$03 Fetch Jetman's world X from #R$607A.
@ $9359 label=DrawTerrain_Target
  $9359,$03 #REGde=#N$FF88 (minus #N$78).
  $935C,$01 Subtract #N$78 to find the world X of the left-hand edge of the
. screen.
N $935D The world is #N$2000 pixels wide, so wrap anything left of its start
. back round to the far end.
  $935D,$01 #REGa=#REGh.
  $935E,$02,b$01 Keep only bits 0-4 so the position wraps round the world.
  $9360,$01 #REGh=#REGa.
  $9361,$0C Divide the world X by #N$08 to give the terrain cell index.
N $936D Start at the left-hand end of the terrain row on the screen.
  $936D,$03 Set the screen address to #N$50C0 (the start of character row
. #N$16).
  $9370,$03 Set the terrain base in #REGbc to #R$7000.
  $9373,$02 Set a column counter in #REGa for #N$20 loops.
@ $9375 label=DrawTerrain_Loop
N $9375 Draw the graphic for one terrain cell.
  $9375,$02 Stash the counter and the cell index on the stack.
  $9377,$01 Add the terrain base to get the address of the cell.
  $9378,$02 Stash the terrain base and the screen address on the stack.
  $937A,$03 Call #R$917C to copy the cell graphic onto the screen.
  $937D,$01 Restore the screen address from the stack.
  $937E,$01 Move along to the next screen column.
  $937F,$02 Restore the terrain base and the cell index from the stack.
N $9381 Step on to the next terrain cell, wrapping round at the end of the
. world, and loop until every column is drawn.
  $9381,$01 Move onto the next cell index.
  $9382,$01 #REGa=#REGh.
  $9383,$02,b$01 Keep only bits 0-1 so the index wraps round after #N$400
. cells.
  $9385,$01 #REGh=#REGa.
  $9386,$01 Restore the counter from the stack.
  $9387,$01 Decrease the column counter by one.
  $9388,$02 Jump back to #R$9375 until all #N$20 columns are drawn.
N $938A Colour the ground beneath the terrain; the black border columns at
. either edge of the window are left alone.
  $938A,$03 Set the attribute pointer to #N$5AE1 (the second column of the
. bottom row).
  $938D,$03 Set a column counter in #REGb for #N$1E loops and the ground
. colour in #REGc to #COLOUR$5B.
@ $9390 label=DrawTerrain_WriteByte
  $9390,$01 Write the ground colour to the attribute buffer.
  $9391,$01 Move onto the next column.
  $9392,$02 Decrease the column counter by one and loop back to #R$9390
. until the ground is coloured.
  $9394,$01 Return.

c $9395 Find Unused Alien Slot
@ $9395 label=FindSlotAlien
D $9395 Scan the six alien slots at #R$61B0 and return the
. first unused one.
R $9395 O:F Z: slot available
R $9395 O:F NZ: no available slots
R $9395 O:HL The alien slot address
N $9395 Scan the six alien slots and return the first free one.
  $9395,$03 #REGhl=#R$61B0.
N $9398 There are a maximum of 6 aliens on screen at a time.
  $9398,$02 Set an alien slot counter in #REGb for #N$06 loops.
  $939A,$03 #REGde=#N($0018,$04,$04) (the length of each slot).
@ $939D label=FindSlotAlien_Loop
  $939D,$04 Jump to #R$93A5 if this slot is unused.
  $93A1,$01 Move onto the next slot.
  $93A2,$02 Decrease the alien counter by one and loop back
. to #R$939D until every slot has been checked.
  $93A4,$01 Leave the Z flag unset as no free slot was found.
@ $93A5 label=FindSlotAlien_Return
  $93A5,$01 Return.

c $93A6 Place Actor At Scroll
@ $93A6 label=PlaceActorAtScroll
D $93A6 Copy #R$607A into the actor's world position and draw it.
. On action, turn it into type #N$2F, handled by #R$93E8, and play
. #R$B8C3.
R $93A6 IX Actor slot
N $93A6 Place the actor at Jetman's scroll position.
  $93A6,$03 Fetch #R$607A.
  $93A9,$03 Write the high byte to the actor's world X.
  $93AC,$03 Write the low byte to the actor's world X.
  $93AF,$03 Fetch #R$607C.
  $93B2,$02 Add #N$08 to the Y position.
  $93B4,$04 Jump to #R$93BA if it is still above the ground
. line.
N $93B8 #N$AF is the ground line.
  $93B8,$02 #REGa=#N$AF.
N $93BA Redraw the actor and test the action key.
@ $93BA label=PlaceActorAtScroll_Draw
  $93BA,$03 Write the Y position to *#REGix+#N$04.
  $93BD,$03 Call #R$8701.
  $93C0,$03 Call #R$8733.
  $93C3,$03 Call #R$945C.
  $93C6,$02 Jump to #R$93E3 if the action key is not pressed.
  $93C8,$05 Return if bit 0 of the actor flags is already set.
N $93CD Turn the actor into type #N$2F and give it Jetman's speed.
  $93CD,$04 Write type #N$2F to the actor.
  $93D1,$03 #REGhl=#R$6080.
  $93D4,$02 Reset bit 0 of Jetman's flags.
  $93D6,$03 Fetch #R$607D.
  $93D9,$03 Copy that speed to the actor.
N $93DC #N$10 is a signed +#N$10 downward throw.
  $93DC,$04 Write #N$10 to the vertical thrust.
  $93E0,$03 Jump to #R$B8C3.
@ $93E3 label=PlaceActorAtScroll_ClearAttached
  $93E3,$04 Reset bit 0 of the actor flags.
  $93E7,$01 Return.

c $93E8 Handler: Falling Platform
@ $93E8 label=Handler_FallingPlatform
D $93E8 Drop a thrown platform (type #N$2F): speed it up under gravity and
. move it along. When it reaches the ground line, stamp it into the
. terrain and free the slot.
R $93E8 IX Actor slot
N $93E8 Increase the downward thrust by two, up to a cap of #N$30.
  $93E8,$03 Fetch the vertical thrust.
  $93EB,$04 Jump to #R$93F5 if it is already at least #N$30.
  $93EF,$06 Increase the thrust by two.
N $93F5 Turn the thrust into a Y movement and test for the ground.
@ $93F5 label=Handler_FallingPlatform_ApplyGravity
  $93F5,$08 Divide the thrust by #N$10.
  $93FD,$03 Add it to the actor's Y position.
  $9400,$03 Write the Y position back.
  $9403,$04 Jump to #R$9435 if the actor is still above the
. ground line.
N $9407 When the actor has hit the ground, stamp tile #N$03 into two terrain
. cells.
  $9407,$03 Call #R$91BB.
N $940A Snap the actor to the ground line.
  $940A,$05 Write #N$B7 to the actor's Y position.
  $940F,$03 #REGde=#R$7000.
  $9412,$02 Point #REGhl at the terrain cell.
  $9414,$02 Write tile #N$03 into that cell.
N $9416 Step to the next cell, wrapping the index, and stamp it too.
  $9416,$01 Move onto the next cell.
  $9417,$01 Fetch the high byte.
  $9418,$02,b$01 Keep only bits 0-1.
  $941A,$01 Write it back to #REGd.
  $941B,$04 Point #REGhl at that terrain cell.
  $941F,$02 Write tile #N$03 into that cell.
N $9421 Align the actor to a character column, clear the terrain
. pixels beneath it and free the slot.
  $9421,$03 Fetch the low byte of the world X.
  $9424,$02,b$01 Keep only bits 3-7.
  $9426,$04 Align the world X to a character column.
  $942A,$03 Call #R$98AE.
  $942D,$03 Call #R$8701.
  $9430,$04 Write #N$00 to the actor type.
  $9434,$01 Return.
@ $9435 label=Handler_FallingPlatform_AddSpeed
N $9435 Add the horizontal speed and redraw the actor.
  $9435,$03 Fetch the horizontal speed.
  $9438,$08 Divide it by #N$10.
  $9440,$03 Copy the step into #REGc and clear #REGb.
  $9443,$03 Jump to #R$9448 if the step is positive.
  $9446,$02 Set #REGb=#N$FF for a negative step.
N $9448 Add the step to the world X and redraw the actor.
@ $9448 label=Handler_FallingPlatform_WriteWorldX
  $9448,$03 Fetch the low byte of the world X.
  $944B,$03 Fetch the high byte of the world X.
  $944E,$01 Add the step to the world X.
  $944F,$03 Write the high byte back.
  $9452,$03 Write the low byte back.
  $9455,$03 Call #R$8701.
  $9458,$03 Call #R$8733.
  $945B,$01 Return.

c $945C Test Action Key
@ $945C label=TestActionKey
D $945C Return non-zero when FULL-STOP or Z (action) is held.
R $945C O:A Zero if the action key is not pressed
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

c $9466 Spawn Alien
@ $9466 label=SpawnAlien
D $9466 Roll a 1-in-4 chance, then copy a level-appropriate alien
. into a free slot.
  $9466,$02 #REGa=random number.
  $9468,$02,b$01 Keep only bits 0-1.
  $946A,$01 Return if the value is not zero.
  $946B,$04 Fetch #R$5E67.
@ $946F label=SpawnAlien_TestDelay
N $946F See #POKE(no_enemies,No Enemies).
  $946F,$01 Return if the delay is still running.
  $9470,$03 Call #R$9395.
  $9473,$01 Return if there were no available alien slots.
  $9474,$01 Stash the free alien slot on the stack.
  $9475,$01 Switch the #REGde and #REGhl registers.
  $9476,$03 Fetch #R$5E40.
  $9479,$01 Rotate it left once.
  $947A,$02,b$01 Keep only bits 1-3.
  $947C,$03 Create an even offset in #REGbc.
N $947F Pick the alien table for this level (cap at level #N$0C).
  $947F,$03 Fetch #R$5EA0.
  $9482,$04 Jump to #R$9488 if the current level is less than
. #N$0C.
  $9486,$02 #REGa=#N$0C.
@ $9488 label=SpawnAlien_PickOffset
  $9488,$02,b$01 Keep only bits 1-3.
  $948A,$03 Create an offset in #REGhl - number can be:
. #LIST
. { #N($0000,$04,$04) }
. { #N($0002,$04,$04) }
. { #N($0004,$04,$04) }
. { #N($0006,$04,$04) }
. { #N($0008,$04,$04) }
. { #N($000A,$04,$04) }
. { #N($000C,$04,$04) }
. LIST#
N $948D Look up the template for the alien to spawn.
  $948D,$04 Point #REGhl into #R$9D72.
  $9491,$04 Fetch the alien table for this level.
  $9495,$01 Add the random offset.
  $9496,$04 Fetch that alien's template.
  $949A,$03 Set the byte count in #REGbc to #N$18 for one actor slot.
  $949D,$02 Restore the free slot from the stack, but stash a
. copy of it on the stack again.
  $949F,$02 Copy the alien data into the free slot.
  $94A1,$01 #REGhl=the free alien slot.
N $94A2 Place the alien relative to #R$607A, with special
. paths for types #N$88 and #N$B8.
  $94A2,$01 Fetch the alien type.
  $94A3,$02 Move #REGhl onto the world X.
  $94A5,$01 Stash it on the stack.
  $94A6,$03 Fetch #R$607A.
  $94A9,$04 Jump to #R$94DB if the type is #N$88.
  $94AD,$05 Jump to #R$9506 if the type is #N$B8.
N $94B2 Place any other alien a random distance either side of the
. scroll position.
  $94B2,$03 Fetch #R$5E40.
  $94B5,$03 Store it as an 8-bit offset in #REGbc.
N $94B8 Place the alien left of the scroll position if bit 1 of the random
. number is set, else right.
  $94B8,$03 #REGde=#N($0080,$04,$04).
  $94BB,$02,b$01 Keep only bit 1.
  $94BD,$02 Jump to #R$94C5 if that bit is reset.
  $94BF,$04 Subtract the offset from the scroll position.
  $94C3,$02 Jump to #R$94C7.
@ $94C5 label=SpawnAlien_AddScroll
  $94C5,$02 Add the offset to the scroll position.
N $94C7 Wrap the position into the world.
@ $94C7 label=SpawnAlien_MaskWorldX
  $94C7,$01 Fetch the high byte.
  $94C8,$02,b$01 Keep only bits 0-4.
  $94CA,$01 Write it back to #REGh.
  $94CB,$01 Copy that position into #REGde.
N $94CC Store the world X and randomly reverse the horizontal speed.
  $94CC,$01 Restore the slot pointer from the stack.
  $94CD,$03 Write the world X into the slot.
  $94D0,$02 Move onto the horizontal speed.
  $94D2,$01 Fetch the random byte.
  $94D3,$02,b$01 Keep only bit 7.
  $94D5,$01 Return if that bit is reset.
  $94D6,$04 Negate the horizontal speed.
  $94DA,$01 Return.
@ $94DB label=SpawnAlien_Type88
N $94DB Type #N$88: spawn off the left or right edge.
  $94DB,$03 Fetch #R$5E40.
  $94DE,$01 Stash it in #REGb.
  $94DF,$02,b$01 Keep only bit 7.
  $94E1,$02 Subtract #N$40 to make the speed.
  $94E3,$01 Copy the speed into #REGc.
N $94E4 Pick the edge: a positive speed spawns off the left, otherwise off the
. right.
  $94E4,$03 Jump to #R$94EC if the result is positive.
  $94E7,$03 #REGde=#N($0090,$04,$04).
  $94EA,$02 Jump to #R$94EF.
@ $94EC label=SpawnAlien_LeftEdge
  $94EC,$03 #REGde=#N$FF70.
N $94EF Apply the edge offset to the scroll position and wrap it.
@ $94EF label=SpawnAlien_ApplyEdge
  $94EF,$01 Add the edge offset to the scroll position.
  $94F0,$01 Fetch the high byte.
  $94F1,$02,b$01 Keep only bits 0-4.
  $94F3,$01 Write it back to #REGh.
  $94F4,$01 Copy that position into #REGde.
N $94F5 Store the world X, then set a random Y position and the
. speed.
  $94F5,$01 Restore the slot pointer from the stack.
  $94F6,$03 Write the world X into the slot.
  $94F9,$01 Move onto the Y position.
N $94FA Choose a random Y position.
  $94FA,$01 Fetch the random byte.
  $94FB,$02,b$01 Keep only bits 3-6.
  $94FD,$03 Jump to #R$9500 if those bits are not zero,
. else force #N$01.
@ $9500 label=SpawnAlien_WriteY
  $9500,$02 Add #N$37 to make a Y position.
  $9502,$01 Write the Y position.
  $9503,$01 Move onto the speed.
  $9504,$01 Write the speed.
  $9505,$01 Return.
@ $9506 label=SpawnAlien_TypeB8
N $9506 Type #N$B8: the same edge spawn as type #N$88.
  $9506,$03 Fetch #R$5E40.
  $9509,$01 Stash it in #REGb.
  $950A,$02,b$01 Keep only bit 7.
  $950C,$02 Subtract #N$40 to make the speed.
  $950E,$01 Copy the speed into #REGc.
N $950F Pick the edge: a positive speed spawns off the left, otherwise off the
. right.
  $950F,$03 Jump to #R$9517 if the result is positive.
  $9512,$03 #REGde=#N($0090,$04,$04).
  $9515,$02 Jump to #R$951A.
@ $9517 label=SpawnAlien_TypeB8_LeftEdge
  $9517,$03 #REGde=#N$FF70.
N $951A Apply the edge offset to the scroll position and wrap it.
@ $951A label=SpawnAlien_TypeB8_ApplyEdge
  $951A,$01 Add the edge offset to the scroll position.
  $951B,$01 Fetch the high byte.
  $951C,$02,b$01 Keep only bits 0-4.
  $951E,$01 Write it back to #REGh.
  $951F,$01 Copy that position into #REGde.
N $9520 Store the world X, then set a random Y position and the
. speed.
  $9520,$01 Restore the slot pointer from the stack.
  $9521,$03 Write the world X into the slot.
  $9524,$01 Move onto the Y position.
N $9525 Choose a random Y position.
  $9525,$01 Fetch the random byte.
  $9526,$02,b$01 Keep only bits 3-6.
  $9528,$03 Jump to #R$952B if those bits are not zero,
. else force #N$01.
@ $952B label=SpawnAlien_TypeB8_WriteY
  $952B,$02 Add #N$37 to make a Y position.
  $952D,$01 Write the Y position.
  $952E,$01 Move onto the speed.
  $952F,$01 Write the speed.
  $9530,$01 Return.

c $9531 Handler: Meteor
@ $9531 label=PlaceSpawnedAlien
D $9531 Count the meteor and drop it two pixels, exploding it at the
. ground line. Award points if its explode flag is set.
R $9531 IX Actor slot
  $9531,$03 #REGhl=#R$5E5E.
  $9534,$01 Increase #R$5E5E by one.
  $9535,$03 Fetch the actor's Y position.
  $9538,$02 Add #N$02 to it.
  $953A,$04 Jump to #R$95B3 if it has reached the ground line.
  $953E,$03 Write the Y position back.
N $9541 Set the actor type to one of the animation frames.
  $9541,$03 Fetch #R$5E42.
  $9544,$02,b$01 Keep only bits 0-2.
N $9546 Sprite IDs begin at #R$D697(#N$50) (#SPRITENAME$50).
  $9546,$02 Add #N$50 for the animation frames.
  $9548,$03 Write it to the actor type.
@ $954B label=PlaceSpawnedAlien_Age
N $954B Age the alien, then apply its horizontal speed.
  $954B,$06 Jump to #R$955F if *#REGix+#N$0A is not zero.
  $9551,$06 Jump to #R$955F if bit 0 of the actor flags is set.
  $9557,$05 Jump to #R$9563 if the age byte has not wrapped.
  $955C,$03 Jump to #R$9937.
@ $955F label=PlaceSpawnedAlien_ClearAge
  $955F,$04 Write #N$00 to the age byte.
N $9563 Move the alien horizontally by its speed and redraw it.
@ $9563 label=PlaceSpawnedAlien_ApplySpeed
  $9563,$03 Fetch the high byte of the world X.
  $9566,$03 Fetch the low byte of the world X.
N $9569 Turn the horizontal speed into a signed pixel step.
  $9569,$03 Fetch the horizontal speed.
  $956C,$02 Clear #REGd for a positive step.
  $956E,$08 Divide it by #N$10.
  $9576,$03 Jump to #R$957B if the step is positive.
  $9579,$02 Set #REGd=#N$FF for a negative step.
N $957B Add the step to the world X and wrap it.
@ $957B label=PlaceSpawnedAlien_AddStep
  $957B,$01 Store the pixel step in #REGe.
  $957C,$01 Add the step to the world X.
  $957D,$01 Fetch the high byte.
  $957E,$02,b$01 Keep only bits 0-4.
  $9580,$03 Write the high byte back.
  $9583,$03 Write the low byte back.
N $9586 Redraw the alien and its colours.
  $9586,$03 Call #R$8701.
  $9589,$03 Call #R$8733.
N $958C Award a score if the explode flag is set.
  $958C,$06 Jump to #R$95A9 if bit 0 of *#REGix+#N$10 is
. reset.
N $9592 Work out the points for this alien from its type.
  $9592,$03 Fetch the actor type.
  $9595,$03 Rotate it right three times.
  $9598,$02,b$01 Keep only bits 0-4.
  $959A,$02 Add #N$01.
  $959C,$01 Convert that value to decimal.
  $959D,$03 Store it in #REGhl.
  $95A0,$04 Multiply it by #N$10.
  $95A4,$02 Copy the points into #REGbc.
  $95A6,$03 Call #R$899C.
@ $95A9 label=PlaceSpawnedAlien_TestHit
  $95A9,$03 Call #R$A766.
N $95AC Kill Jetman and explode the alien if they are touching.
  $95AC,$04 Return if #R$B2A2 does not set carry.
  $95B0,$03 Call #R$B2D7.
@ $95B3 label=PlaceSpawnedAlien_Explode
  $95B3,$03 Jump to #R$A76B.

c $95B6 Stamp Terrain Tile
@ $95B6 label=StampTerrainTile
D $95B6 Write crater tiles into #R$7000 under the current actor and
. redraw them on the screen.
R $95B6 IX Actor slot
  $95B6,$03 Call #R$91BB.
  $95B9,$01 Stash the cell index on the stack.
  $95BA,$03 #REGde=#R$7000.
  $95BD,$01 Switch the #REGde and #REGhl registers.
  $95BE,$01 Point #REGhl at that terrain cell.
  $95BF,$04 Jump to #R$95C7 if bit 3 of the tile is reset.
  $95C3,$02 Write #N$0A to the cell. #UDG($F66E+$0A*$08,attr=$43)
  $95C5,$02 Jump to #R$95C9.
@ $95C7 label=StampTerrainTile_WriteFirstCell
  $95C7,$02 Write #N$08 to the cell. #UDG($F66E+$08*$08,attr=$43)
@ $95C9 label=StampTerrainTile_Neighbour
N $95C9 Stamp the neighbouring cell.
  $95C9,$01 Move onto the next cell.
  $95CA,$01 Fetch the high byte.
  $95CB,$02,b$01 Keep only bits 0-1.
  $95CD,$01 Write it back to #REGd.
  $95CE,$03 #REGhl=#R$7000.
  $95D1,$01 Point #REGhl at that terrain cell.
N $95D2 Pick the tile for the neighbouring cell: #N$0A if bit 3 is set, else
. #N$09.
  $95D2,$04 Jump to #R$95DA if bit 3 of the tile is reset.
  $95D6,$02 Write #N$0A to the cell. #UDG($F66E+$0A*$08,attr=$43)
  $95D8,$02 Jump to #R$95DC.
@ $95DA label=StampTerrainTile_WriteSecondCell
  $95DA,$02 Write #N$09 to the cell. #UDG($F66E+$09*$08,attr=$43)
@ $95DC label=StampTerrainTile_Redraw
N $95DC Redraw the stamped columns onto the play area.
  $95DC,$06 Jump to #R$9652 if #R$98AE returns non-zero.
  $95E2,$03 Subtract #N$08 from the high byte.
  $95E5,$01 Write it back to #REGh.
N $95E6 Wrap the cell index and point #REGde at its terrain cell.
  $95E6,$01 Exchange the cell index with the stacked pointer.
  $95E7,$01 Fetch the high byte.
  $95E8,$02,b$01 Keep only bits 0-4.
  $95EA,$01 Write it back to #REGh.
  $95EB,$03 #REGde=#R$7000.
  $95EE,$03 Point #REGde at that terrain cell.
  $95F1,$01 Exchange the cell index with the stacked pointer.
N $95F2 Move onto the next screen column if the scroll is on a character
. boundary.
  $95F2,$03 Fetch #R$607A.
  $95F5,$02,b$01 Keep only bits 0-2.
  $95F7,$03 Jump to #R$95FA if the scroll is not on a
. character boundary, else move onto the next screen column.
@ $95FA label=StampTerrainTile_XORColumn
N $95FA OR the first graphic column onto the screen.
  $95FA,$01 Stash the screen pointer on the stack.
  $95FB,$04 Fetch the tile index from *#REGde into #REGhl.
  $95FF,$03 #REGde=#R$F66E.
  $9602,$04 Multiply the tile index by #N$08 and add the
. graphic base.
  $9606,$01 Point #REGde at that graphic.
N $9607 Work out the pixel shift from the scroll position.
  $9607,$01 Switch to the shadow registers.
  $9608,$03 Fetch #R$607A.
  $960B,$02 Negate the low byte.
  $960D,$02,b$01 Keep only bits 0-2.
  $960F,$01 Store the pixel shift in #REGc.
  $9610,$01 Switch back to the main registers.
  $9611,$02 Restore the screen pointer from the stack, but
. stash a copy of it on the stack again.
  $9613,$02 Set a pixel row counter in #REGb for #N$08 loops.
  $9615,$03 Call #R$9632.
N $9618 Fetch the next terrain cell's graphic and draw it in the
. next screen column.
  $9618,$01 Restore the screen pointer from the stack.
  $9619,$01 Exchange it with the stacked cell index.
  $961A,$01 Move onto the next cell.
  $961B,$01 Fetch the high byte.
  $961C,$02,b$01 Keep only bits 0-1.
  $961E,$01 Write it back to #REGh.
N $961F Look up the graphic for that cell.
  $961F,$03 #REGde=#R$7000.
  $9622,$01 Point #REGhl at that terrain cell.
  $9623,$03 Fetch the tile index from *#REGhl into #REGhl.
  $9626,$03 Multiply the tile index by #N$08.
  $9629,$03 #REGde=#R$F66E.
  $962C,$02 Point #REGde at that graphic.
N $962E Aim at the next screen column and reset the row counter.
  $962E,$01 Restore the screen pointer from the stack.
  $962F,$01 Move onto the next screen column.
  $9630,$02 Set a pixel row counter in #REGb for #N$08 loops.
@ $9632 label=StampTerrainTile_Loop
N $9632 Shift a graphic byte by the scroll and OR it onto
. two neighbouring screen bytes.
  $9632,$01 Fetch the graphic byte.
  $9633,$01 Switch to the shadow registers.
  $9634,$03 Store it in #REGh and clear #REGl.
  $9637,$01 #REGb=the pixel shift.
  $9638,$04 Jump to #R$9642 if there is no shift.
@ $963C label=StampTerrainTile_ShiftPixel
  $963C,$04 Shift the graphic right by one pixel.
  $9640,$02 Decrease the shift counter by one and loop back
. to #R$963C until the shift is done.
N $9642 OR the shifted graphic onto the two screen bytes.
@ $9642 label=StampTerrainTile_MergeBytes
  $9642,$03 Stash the low byte and fetch the high byte.
  $9645,$01 Switch back to the main registers.
  $9646,$03 Merge the high byte onto the current screen byte.
  $9649,$01 Fetch the stashed low byte.
  $964A,$02 Merge the low byte onto the next screen byte.
  $964C,$01 Move onto the next graphic byte.
  $964D,$02 Step back and down one pixel row.
  $964F,$02 Decrease the row counter by one and loop back to
. #R$9632 until the column is drawn.
  $9651,$01 Return.
@ $9652 label=StampTerrainTile_Restore
  $9652,$01 Restore the cell index from the stack.
  $9653,$01 Return.

c $9654 Handler: Drifting Alien
@ $9654 label=Handler_DriftingAlien
D $9654 Count the alien, then drift it relative to the scroll in
. #R$607A.
R $9654 IX Actor slot
  $9654,$03 #REGhl=#R$5E5E.
  $9657,$01 Increase #R$5E5E by one.
N $9658 Compare the alien with #R$607A and pick a drift
. direction.
  $9658,$03 Fetch the high byte of the world X.
  $965B,$03 Fetch the low byte of the world X.
  $965E,$04 Fetch #R$607A.
  $9662,$03 Subtract the scroll position.
  $9665,$05 Jump to #R$96D7 if the alien is left of the
. scroll.
N $966A Speed the alien up towards the left, up to a limit.
  $966A,$02 Clear the reverse-animation flag.
  $966C,$07 Jump to #R$9677 if the horizontal speed is
. positive.
  $9673,$04 Jump to #R$9679 if the speed is already below
. #N$D1.
@ $9677 label=Handler_DriftingAlien_Decelerate
  $9677,$02 Subtract #N$02 from the speed.
@ $9679 label=Handler_DriftingAlien_Loop
  $9679,$03 Write the speed back.
N $967C Aim the vertical thrust at Jetman, or at mid-screen
. when Jetman is in the rover.
  $967C,$03 Fetch the Jetman type from #R$6078.
  $967F,$04 Jump to #R$9687 if Jetman is on foot.
  $9683,$02 #REGa=#N$68.
  $9685,$02 Jump to #R$968A.
@ $9687 label=Handler_DriftingAlien_FetchJetmanY
  $9687,$03 Fetch #R$607C.
N $968A Compare with the alien's Y position and, if the alien is above the
. target, increase the downward thrust, up to a limit.
@ $968A label=Handler_DriftingAlien_CompareY
  $968A,$03 Subtract the alien's Y position.
  $968D,$03 Jump to #R$96E8 if the alien is below the target.
  $9690,$07 Jump to #R$969B if the vertical thrust is
. negative.
  $9697,$04 Jump to #R$969D if the thrust is already at least
. #N$30.
@ $969B label=Handler_DriftingAlien_AddThrust
  $969B,$02 Add #N$02 to the thrust.
N $969D Apply the thrust to the alien's Y position, bouncing at the
. top and bottom.
@ $969D label=Handler_DriftingAlien_ApplyThrust
  $969D,$03 Write the thrust back.
  $96A0,$08 Divide it by #N$10.
  $96A8,$03 Add it to the alien's Y position.
  $96AB,$04 Jump to #R$96F7 if the alien is above the play
. area.
  $96AF,$04 Jump to #R$9705 if the alien has hit the ground
. line.
  $96B3,$03 Write the Y position back.
@ $96B6 label=Handler_DriftingAlien_Animate
N $96B6 Animate the frame and colour, then continue at
. #R$954B.
  $96B6,$03 Increase the animation timer.
  $96B9,$03 Fetch the animation timer.
  $96BC,$02,b$01 Keep only bits 0-2.
  $96BE,$04 Jump to #R$96C4 if the reverse-animation flag is
. set.
  $96C2,$02,b$01 Flip bits 0-2.
N $96C4 Sprite IDs begin at #R$D59F(#N$48) (#SPRITENAME$48).
@ $96C4 label=Handler_DriftingAlien_WriteFrame
  $96C4,$02 Add #N$48 for the drifting frames.
  $96C6,$03 Write it to the actor type.
N $96C9 Alternate the colour using bit 0 of #R$5E42.
  $96C9,$03 Fetch #R$5E42.
  $96CC,$01 Rotate it left once.
  $96CD,$02,b$01 Keep only bit 1.
  $96CF,$02 Add #N$44 for the colour.
  $96D1,$03 Write it to the actor colour.
  $96D4,$03 Jump to #R$954B.
@ $96D7 label=Handler_DriftingAlien_DriftRight
N $96D7 When the alien is left of the scroll, drift right.
  $96D7,$02 Set the reverse-animation flag.
  $96D9,$07 Jump to #R$96E4 if the horizontal speed is
. negative.
  $96E0,$04 Jump to #R$9679 if the speed is already at least
. #N$30.
@ $96E4 label=Handler_DriftingAlien_AddSpeed
  $96E4,$02 Add #N$02 to the speed.
  $96E6,$02 Jump to #R$9679.
@ $96E8 label=Handler_DriftingAlien_ThrustUp
N $96E8 When the alien is below the target, apply upward thrust.
  $96E8,$07 Jump to #R$96F3 if the vertical thrust is
. positive.
  $96EF,$04 Jump to #R$969D if the thrust is already below
. #N$D1.
@ $96F3 label=Handler_DriftingAlien_SubtractThrust
  $96F3,$02 Subtract #N$02 from the thrust.
  $96F5,$02 Jump to #R$969D.
@ $96F7 label=Handler_DriftingAlien_BounceTop
N $96F7 Bounce off the top of the play area.
  $96F7,$07 Jump to #R$96B6 if the vertical thrust is
. positive.
@ $96FE label=Handler_DriftingAlien_NegateThrust
  $96FE,$02 Negate the thrust.
  $9700,$03 Write it back.
  $9703,$02 Jump to #R$96B6.
@ $9705 label=Handler_DriftingAlien_BounceGround
N $9705 Bounce off the ground line.
  $9705,$07 Jump to #R$96B6 if the vertical thrust is
. negative.
  $970C,$02 Jump to #R$96FE.

c $970E Handler: Mr Magnetic Brella
@ $970E label=Handler_MrMagneticBrella
D $970E Count the alien and steer it toward the scroll position at
. #R$607A. When it is close to the object at #R$60AA, it picks
. that object up and carries it.
R $970E IX Actor slot
  $970E,$03 #REGhl=#R$5E5E.
  $9711,$01 Increase #R$5E5E by one.
  $9712,$07 Jump to #R$97F4 if the alien is already attached.
N $9719 Attach when the alien is close to #R$60AA.
  $9719,$06 Jump to #R$974C if #R$60B0 is already set.
N $971F Test whether the alien is horizontally close to the object.
  $971F,$03 Fetch the high byte of the world X.
  $9722,$03 Fetch the low byte of the world X.
  $9725,$04 Fetch #R$60AA.
  $9729,$04 Add an #N$08 tolerance.
  $972D,$02 Subtract the target position.
  $972F,$01 Fetch the high byte of the gap.
  $9730,$02,b$01 Keep only bits 0-4.
  $9732,$02 Jump to #R$974C if they are not on the same
. screen.
  $9734,$01 Fetch the low byte of the gap.
  $9735,$04 Jump to #R$974C if it is at least #N$10.
N $9739 Test whether the alien is vertically close to the object.
  $9739,$03 Fetch #R$60AC.
  $973C,$03 Subtract the alien's Y position.
  $973F,$04 Jump to #R$974C if the Y gap is at least #N$10.
N $9743 Flag both the alien and the object as attached.
  $9743,$04 Set bit 0 of the actor flags.
  $9747,$03 #REGhl=#R$60B0.
  $974A,$02 Set bit 0 of the target flags.
N $974C Copy the position at #R$60AA to the alien if it is beside
. #R$60C2.
@ $974C label=Handler_MrMagneticBrella_CopyBeside
  $974C,$05 Jump to #R$9761 if the alien is not beside
. #R$60C2.
  $9751,$04 Fetch #R$60AA.
  $9755,$06 Copy that position into the alien's world X.
  $975B,$03 Fetch #R$60AC.
  $975E,$03 Copy it to the alien's Y position.
@ $9761 label=Handler_MrMagneticBrella_ApplyDownThrust
N $9761 Apply downward thrust and update the Y position.
  $9761,$07 Jump to #R$976C if the vertical thrust is
. negative.
  $9768,$04 Jump to #R$9771 if the thrust is already at least
. #N$30.
@ $976C label=Handler_MrMagneticBrella_AddThrust
  $976C,$02 Add #N$02 to the thrust.
  $976E,$03 Write the thrust back.
@ $9771 label=Handler_MrMagneticBrella_AddThrustToY
  $9771,$08 Divide the thrust by #N$10.
  $9779,$03 Add it to the alien's Y position.
  $977C,$04 Jump to #R$97E6 if the alien has hit the ground
. line.
@ $9780 label=Handler_MrMagneticBrella_WriteY
  $9780,$03 Write the Y position back.
@ $9783 label=Handler_MrMagneticBrella_Loop
N $9783 Steer toward the scroll, then animate.
  $9783,$03 Fetch the high byte of the world X.
  $9786,$03 Fetch the low byte of the world X.
  $9789,$01 Stash the world X on the stack.
  $978A,$04 Fetch #R$607A.
  $978E,$02 Subtract the scroll position.
  $9790,$02 #REGc=#N$00.
N $9792 Leave the speed unchanged if the alien is on this screen or just off
. its left edge.
  $9792,$01 Fetch the high byte of the gap.
  $9793,$02,b$01 Keep only bits 0-4.
  $9795,$02 Jump to #R$97A8 if the alien is on this screen.
  $9797,$02,b$01 Set bits 5-7.
  $9799,$01 Flip the bits.
  $979A,$03 Jump to #R$97A8 if the result is zero.
  $979D,$02 Test bit 4 of the gap.
N $979F #N$30 is a signed +#N$30 rightward speed; #N$D0
. is signed -#N$30 leftward.
  $979F,$02 #REGa=#N$30.
  $97A1,$02 Jump to #R$97A5 if the alien is left of the
. scroll.
  $97A3,$02 #REGa=#N$D0.
@ $97A5 label=Handler_MrMagneticBrella_WriteSpeed
  $97A5,$03 Write the speed to *#REGix+#N$05.
N $97A8 Move the carried object with the alien if it is attached.
@ $97A8 label=Handler_MrMagneticBrella_RestoreX
  $97A8,$01 Restore the world X from the stack.
  $97A9,$07 Jump to #R$97C1 if the alien is not attached.
  $97B0,$03 Write the world X back to #R$60AA.
  $97B3,$03 Fetch the alien's Y position.
  $97B6,$02 Add #N$1A.
  $97B8,$04 Jump to #R$97BE if it is still above the ground
. line.
N $97BC #N$AF is the ground line.
  $97BC,$02 #REGa=#N$AF.
@ $97BE label=Handler_MrMagneticBrella_WriteLinkedY
  $97BE,$03 Write it to #R$60AC.
N $97C1 Animate the alien and set its colour.
@ $97C1 label=Handler_MrMagneticBrella_TickAnimation
  $97C1,$03 Increase the animation timer.
  $97C4,$03 Fetch the animation timer.
  $97C7,$02,b$01 Keep only bits 0-2.
N $97C9 Sprite IDs begin at #R$D894(#N$40) (#SPRITENAME$40).
  $97C9,$02 Add #N$40 for the seeking frames.
  $97CB,$03 Write it to the actor type.
  $97CE,$06 Jump to #R$97DF if bit 0 of *#REGix+#N$10 is
. reset.
  $97D4,$06 Jump to #R$97DF if the alien is not attached.
  $97DA,$05 Write #N$80 to #R$60B0.
@ $97DF label=Handler_MrMagneticBrella_SetColour
  $97DF,$04 Write #COLOUR$45 to the actor colour.
  $97E3,$03 Jump to #R$954B.
@ $97E6 label=Handler_MrMagneticBrella_BounceGround
N $97E6 Bounce off the ground line.
  $97E6,$07 Jump to #R$9780 if the vertical thrust is
. negative.
  $97ED,$02 Negate the thrust.
  $97EF,$03 Write it back.
  $97F2,$02 Jump to #R$9783.
@ $97F4 label=Handler_MrMagneticBrella_AttachedFly
N $97F4 When attached, keep flying and copy the new position back to #R$60AA.
  $97F4,$03 Increase the animation timer.
  $97F7,$03 Fetch the alien's Y position.
  $97FA,$02 Compare it with #N$70.
  $97FC,$03 Fetch the vertical thrust.
  $97FF,$02 Jump to #R$985A if the alien is at or below
. mid-screen.
N $9801 When above mid-screen, increase the downward thrust, up to a limit.
  $9801,$04 Jump to #R$9809 if the thrust is negative.
  $9805,$04 Jump to #R$980B if the thrust is already at least
. #N$30.
@ $9809 label=Handler_MrMagneticBrella_AttachedAddThrust
  $9809,$02 Add #N$02 to the thrust.
N $980B Apply the thrust to the alien's Y position, stopping at the ground
. line.
@ $980B label=Handler_MrMagneticBrella_AttachedApplyThrust
  $980B,$03 Write the thrust back.
  $980E,$08 Divide it by #N$10.
  $9816,$03 Add it to the alien's Y position.
  $9819,$04 Jump to #R$981F if it is still above the ground
. line.
N $981D #N$AF is the ground line.
  $981D,$02 #REGa=#N$AF.
@ $981F label=Handler_MrMagneticBrella_AttachedWriteY
  $981F,$03 Write the Y position back.
N $9822 Occasionally pick a new horizontal direction using
. #R$5E40.
  $9822,$07 Jump to #R$9872 if #R$5E40 is zero.
  $9829,$02,b$01 Keep only bits 0-6.
  $982B,$02 Jump to #R$983A if the result is not zero.
  $982D,$01 Fetch the stored random byte.
  $982E,$02,b$01 Keep only bit 7.
  $9830,$01 Stash that sign bit.
  $9831,$03 Fetch the actor flags.
  $9834,$02,b$01 Keep only bits 0-6.
  $9836,$04 Merge in the sign bit and write the flags back.
@ $983A label=Handler_MrMagneticBrella_AccelerateFromFlag
N $983A Accelerate left or right from bit 7 of the flags.
  $983A,$04 Test bit 7 of the actor flags.
  $983E,$03 Fetch the horizontal speed.
  $9841,$02 Jump to #R$9866 if bit 7 is set.
N $9843 When bit 7 is reset, speed up towards the right, up to a limit.
  $9843,$04 Jump to #R$984B if the speed is negative.
  $9847,$04 Jump to #R$984D if the speed is already at least
. #N$30.
@ $984B label=Handler_MrMagneticBrella_AddSpeed
  $984B,$02 Add #N$02 to the speed.
@ $984D label=Handler_MrMagneticBrella_WriteSpeedBack
  $984D,$03 Write the speed back.
N $9850 Stash the world X and rejoin the shared code at #R$97A8.
@ $9850 label=Handler_MrMagneticBrella_StashWorldX
  $9850,$03 Fetch the high byte of the world X.
  $9853,$03 Fetch the low byte of the world X.
  $9856,$01 Stash the world X on the stack.
  $9857,$03 Jump to #R$97A8.
@ $985A label=Handler_MrMagneticBrella_ThrustUp
N $985A When below mid-screen, apply upward thrust.
  $985A,$04 Jump to #R$9862 if the thrust is positive.
  $985E,$04 Jump to #R$980B if the thrust is already below
. #N$D1.
@ $9862 label=Handler_MrMagneticBrella_SubtractThrust
  $9862,$02 Subtract #N$02 from the thrust.
  $9864,$02 Jump to #R$980B.
@ $9866 label=Handler_MrMagneticBrella_CapSpeed
  $9866,$04 Jump to #R$986E if the speed is positive.
  $986A,$04 Jump to #R$984D if the speed is already below
. #N$D1.
@ $986E label=Handler_MrMagneticBrella_SubtractSpeed
  $986E,$02 Subtract #N$02 from the speed.
  $9870,$02 Jump to #R$984D.
@ $9872 label=Handler_MrMagneticBrella_DetachIfTerrain
N $9872 When #R$5E40 is zero, check for terrain under the alien. If there
. is some, detach the alien; otherwise carry on accelerating.
  $9872,$03 Call #R$91BB.
  $9875,$04 Jump to #R$983A if the first terrain cell is
. empty.
  $9879,$05 Write #N$80 to #R$60B0.
  $987E,$04 Write #N$00 to the actor flags.
  $9882,$02 Jump to #R$9850.

c $9884 Test Alien Beside Slot
@ $9884 label=TestAlienBesideSlot
D $9884 Return with the Z flag set if the alien is beside the object in
. #R$60C2, otherwise with the Z flag unset.
R $9884 IX Actor slot
  $9884,$03 Fetch the high byte of the world X.
  $9887,$03 Fetch the low byte of the world X.
  $988A,$04 Fetch #R$60C2.
  $988E,$04 Add an #N$08 tolerance.
  $9892,$02 Subtract the slot-2 position.
  $9894,$01 Fetch the high byte of the gap.
  $9895,$02,b$01 Keep only bits 0-4.
  $9897,$02 Jump to #R$98AA if they are not on the same
. screen.
  $9899,$01 Fetch the low byte of the gap.
  $989A,$04 Jump to #R$98AA if it is at least #N$10.
N $989E Test whether the alien is vertically close to the object.
  $989E,$03 Fetch #R$60C4.
  $98A1,$03 Subtract the alien's Y position.
  $98A4,$04 Jump to #R$98AA if the Y gap is at least #N$10.
  $98A8,$02 Return with the Z flag set.
@ $98AA label=TestAlienBesideSlot_NotBeside
  $98AA,$04 Return with the Z flag unset.

c $98AE Clear Terrain Under Actor
@ $98AE label=ClearTerrainUnderActor
D $98AE Clear the play-area pixels under the actor and return with the Z
. flag set, or return with it unset if the actor is off-screen.
R $98AE IX Actor slot
  $98AE,$03 Fetch the high byte of the world X.
  $98B1,$03 Fetch the low byte of the world X.
  $98B4,$04 Fetch #R$607A.
  $98B8,$03 Subtract the scroll position.
  $98BB,$04 Add a #N$78 tolerance.
  $98BF,$01 Fetch the high byte of the gap.
  $98C0,$02,b$01 Keep only bits 0-4.
  $98C2,$01 Return if the actor is not on this screen.
N $98C3 Build the pixel mask for the fine scroll position.
  $98C3,$01 Switch the gap into #REGde.
  $98C4,$03 Fetch #R$607A.
  $98C7,$02,b$01 Keep only bits 0-2.
  $98C9,$01 Store the fine scroll in #REGb.
  $98CA,$02 #REGa=#N$00.
  $98CC,$03 #REGhl=#N($00FF,$04,$04).
  $98CF,$02 Jump to #R$98D5 if there is no fine scroll.
@ $98D1 label=ClearTerrainUnderActor_ShiftMask
  $98D1,$02 Shift the mask left by one pixel.
  $98D3,$02 Decrease the fine-scroll counter by one and loop
. back to #R$98D1 until the shift is done.
@ $98D5 label=ClearTerrainUnderActor_StoreMask
  $98D5,$02 Store the mask in #REGde and the overflow in
. #REGc.
N $98D7 Work out the screen column under the actor.
  $98D7,$03 Fetch #R$607A.
  $98DA,$03 Divide the scroll by #N$08.
  $98DD,$02,b$01 Keep only bits 0-4.
  $98DF,$01 Store the scroll column in #REGl.
N $98E0 Work out the actor's column relative to the scroll column.
  $98E0,$03 Fetch the low byte of the world X.
  $98E3,$03 Divide it by #N$08.
  $98E6,$02,b$01 Keep only bits 0-4.
  $98E8,$01 Subtract the scroll column.
  $98E9,$02 Add #N$0E.
  $98EB,$02,b$01 Keep only bits 0-4.
  $98ED,$03 #REGhl=#N$50C0.
  $98F0,$02 Point #REGhl at that screen column.
  $98F2,$02 Set a pixel row counter in #REGb for #N$08 loops.
N $98F4 Clear the masked pixels one pixel row at a time.
@ $98F4 label=ClearTerrainUnderActor_MaskRow
  $98F4,$01 Stash the row start on the stack.
  $98F5,$04 Mask the first screen byte.
  $98F9,$04 Mask the middle screen byte.
  $98FD,$03 Mask the third screen byte.
  $9900,$01 Restore the row start from the stack.
  $9901,$01 Move down one pixel row.
  $9902,$02 Decrease the row counter by one and loop back to
. #R$98F4 until the column is cleared.
  $9904,$02 Return with the Z flag set.

c $9906 Handler: The Block
@ $9906 label=Handler_Block
D $9906 Animate The Block, or clear the slot once it has moved off the
. screen in the direction it is travelling.
R $9906 IX Actor slot
  $9906,$03 Fetch the high byte of the world X.
  $9909,$03 Fetch the low byte of the world X.
  $990C,$04 Fetch #R$607A.
  $9910,$03 Subtract the scroll position.
  $9913,$06 Jump to #R$9930 if the horizontal speed is
. negative.
  $9919,$01 Fetch the high byte of the gap.
  $991A,$02,b$01 Keep only bits 0-4.
  $991C,$04 Jump to #R$9937 if the alien has left the screen.
N $9920 Select the animation frame for The Block.
@ $9920 label=Handler_Block_Animation
  $9920,$03 Increase the animation timer.
  $9923,$03 Fetch the animation timer.
  $9926,$02,b$01 Keep only bits 0-2.
N $9928 Sprite IDs begin at #R$E2A7(#N$88) (#SPRITENAME$88).
  $9928,$02 Add #N$88 for these frames.
  $992A,$03 Write it to the actor type.
  $992D,$03 Jump to #R$954B.
N $9930 When The Block is moving left, test whether it has left the left edge.
@ $9930 label=Handler_Block_StillOnScreen
  $9930,$01 Fetch the high byte of the gap.
  $9931,$02,b$01 Set bits 5-7.
  $9933,$04 Jump to #R$9920 if the alien has not left the
. left edge.
@ $9937 label=Handler_Block_ClearType
  $9937,$04 Write #N$00 to the actor type.
  $993B,$01 Return.

c $993C Handler: Bouncing Wheel
@ $993C label=Handler_BouncingWheel
D $993C Steer the Bouncing Wheel toward the scroll position and bounce it
. at the play-area edges.
R $993C IX Actor slot
  $993C,$03 Fetch the high byte of the world X.
  $993F,$03 Fetch the low byte of the world X.
  $9942,$04 Fetch #R$607A.
  $9946,$03 Subtract the scroll position.
  $9949,$02 #REGc=#N$00.
N $994B Leave the speed unchanged if the wheel is on this screen or just off
. its left edge.
  $994B,$01 Fetch the high byte of the gap.
  $994C,$02,b$01 Keep only bits 0-4.
  $994E,$02 Jump to #R$9961 if the alien is on this screen.
  $9950,$02,b$01 Set bits 5-7.
  $9952,$01 Flip the bits.
  $9953,$03 Jump to #R$9961 if the result is zero.
  $9956,$02 Test bit 4 of the gap.
N $9958 #N$30 is a signed +#N$30 rightward speed; #N$D0
. is signed -#N$30 leftward.
  $9958,$02 #REGa=#N$30.
  $995A,$02 Jump to #R$995E if the alien is left of the
. scroll.
  $995C,$02 #REGa=#N$D0.
@ $995E label=Handler_BouncingWheel_WriteSpeed
  $995E,$03 Write the speed to *#REGix+#N$05.
N $9961 Move the wheel vertically, bouncing it off the play-area edges.
@ $9961 label=Handler_BouncingWheel_AddY
  $9961,$03 Fetch the alien's Y position.
  $9964,$03 Add the vertical thrust.
  $9967,$04 Jump to #R$9988 if the alien is above the play
. area.
  $996B,$04 Jump to #R$998E if the alien has hit the ground
. line.
  $996F,$03 Write the Y position back.
N $9972 Step the animation timer and pick the animation frame.
@ $9972 label=Handler_BouncingWheel_TickAnimation
  $9972,$03 Increase the animation timer.
  $9975,$03 Fetch the animation timer.
  $9978,$04 Jump to #R$9980 if it is still below #N$06.
  $997C,$04 Write #N$00 to the animation timer.
N $9980 Sprite IDs begin at #R$ED51(#N$A8) (#SPRITENAME$A8).
@ $9980 label=Handler_BouncingWheel_WriteFrame
  $9980,$02 Add #N$A8 for these frames.
  $9982,$03 Write it to the actor type.
  $9985,$03 Jump to #R$954B.
N $9988 Bounce off the top by thrusting down, or off the ground by thrusting
. up.
@ $9988 label=Handler_BouncingWheel_ThrustDown
  $9988,$04 Write #N$03 to the vertical thrust.
  $998C,$02 Jump to #R$9972.
@ $998E label=Handler_BouncingWheel_ThrustUp
  $998E,$04 Write #N$FD to the vertical thrust.
  $9992,$02 Jump to #R$9972.

c $9994 Handler: Spinner
@ $9994 label=Handler_Spinner
D $9994 Wobble the Spinner's X and Y speed offsets, steer it toward the
. scroll position and bounce it at the play-area edges.
R $9994 IX Actor slot
  $9994,$07 Jump to #R$999F if *#REGix+#N$12 is positive.
  $999B,$02 #REGa=#N$02.
  $999D,$02 Jump to #R$99A1.
@ $999F label=Handler_Spinner_WobbleX
  $999F,$02 #REGa=#N$FE.
@ $99A1 label=Handler_Spinner_AddWobbleX
  $99A1,$03 Add it to *#REGix+#N$13.
  $99A4,$03 Write the new value back.
  $99A7,$03 Add it to *#REGix+#N$12.
  $99AA,$03 Write the new value back.
N $99AD Wobble the vertical speed offsets in the same way.
  $99AD,$07 Jump to #R$99B8 if *#REGix+#N$14 is positive.
  $99B4,$02 #REGa=#N$02.
  $99B6,$02 Jump to #R$99BA.
@ $99B8 label=Handler_Spinner_WobbleY
  $99B8,$02 #REGa=#N$FE.
@ $99BA label=Handler_Spinner_AddWobbleY
  $99BA,$03 Add it to *#REGix+#N$15.
  $99BD,$03 Write the new value back.
  $99C0,$03 Add it to *#REGix+#N$14.
  $99C3,$03 Write the new value back.
N $99C6 Move the spinner vertically, bouncing it off the play-area
. edges.
  $99C6,$03 Add the vertical thrust.
  $99C9,$08 Divide the result by #N$10.
  $99D1,$03 Add it to the alien's Y position.
  $99D4,$04 Jump to #R$9A23 if the alien is above the play
. area.
  $99D8,$04 Jump to #R$9A29 if the alien has hit the ground
. line.
  $99DC,$03 Write the Y position back.
N $99DF Work out the extra horizontal speed from the scroll position.
@ $99DF label=Handler_Spinner_CompareScroll
  $99DF,$03 Fetch the high byte of the world X.
  $99E2,$03 Fetch the low byte of the world X.
  $99E5,$04 Fetch #R$607A.
  $99E9,$03 Subtract the scroll position.
  $99EC,$02 #REGc=#N$00.
N $99EE Leave the extra speed unchanged if the spinner is on this screen or
. just off its left edge.
  $99EE,$01 Fetch the high byte of the gap.
  $99EF,$02,b$01 Keep only bits 0-4.
  $99F1,$02 Jump to #R$9A04 if the alien is on this screen.
  $99F3,$02,b$01 Set bits 5-7.
  $99F5,$01 Flip the bits.
  $99F6,$03 Jump to #R$9A04 if the result is zero.
  $99F9,$02 Test bit 4 of the gap.
N $99FB #N$20 is a signed +#N$20 rightward extra speed;
. #N$E0 is signed -#N$20 leftward.
  $99FB,$02 #REGa=#N$20.
  $99FD,$02 Jump to #R$9A01 if the alien is left of the
. scroll.
  $99FF,$02 #REGa=#N$E0.
@ $9A01 label=Handler_Spinner_WriteExtraX
  $9A01,$03 Write it to *#REGix+#N$16.
@ $9A04 label=Handler_Spinner_MergeExtraSpeed
  $9A04,$03 Fetch *#REGix+#N$16.
  $9A07,$03 Add *#REGix+#N$12.
  $9A0A,$03 Write the result to the horizontal speed.
N $9A0D Step the animation timer and pick the animation frame.
  $9A0D,$03 Increase the animation timer.
  $9A10,$03 Fetch the animation timer.
  $9A13,$04 Jump to #R$9A1B if it is still below #N$06.
  $9A17,$04 Write #N$00 to the animation timer.
N $9A1B Sprite IDs begin at #R$E848(#N$B0) (#SPRITENAME$B0).
@ $9A1B label=Handler_Spinner_WriteFrame
  $9A1B,$02 Add #N$B0 for these frames.
  $9A1D,$03 Write it to the actor type.
  $9A20,$03 Jump to #R$954B.
@ $9A23 label=Handler_Spinner_ThrustDown
N $9A23 #N$20 is a signed +#N$20 downward thrust. #N$E0
. is signed -#N$20 upward.
  $9A23,$04 Write #N$20 to the vertical thrust.
  $9A27,$02 Jump to #R$99DF.
@ $9A29 label=Handler_Spinner_ThrustUp
  $9A29,$04 Write #N$E0 to the vertical thrust.
  $9A2D,$02 Jump to #R$99DF.

c $9A2F Handler: Saturn
@ $9A2F label=Handler_Saturn
D $9A2F Drift the Saturn toward the scroll position and aim it at Jetman.
R $9A2F IX Actor slot
  $9A2F,$03 #REGhl=#R$5E5E.
  $9A32,$01 Increase #R$5E5E by one.
N $9A33 Steer the horizontal speed toward the scroll position.
  $9A33,$03 Fetch the high byte of the world X.
  $9A36,$03 Fetch the low byte of the world X.
  $9A39,$04 Fetch #R$607A.
  $9A3D,$03 Subtract the scroll position.
  $9A40,$05 Jump to #R$9AAB if the alien is left of the
. scroll.
N $9A45 Speed the alien up towards the left, up to a limit.
  $9A45,$02 #REGc=#N$00.
  $9A47,$07 Jump to #R$9A52 if the horizontal speed is
. positive.
  $9A4E,$04 Jump to #R$9A54 if the speed is already below
. #N$B1.
@ $9A52 label=Handler_Saturn_Decelerate
  $9A52,$02 Subtract #N$02 from the speed.
@ $9A54 label=Handler_Saturn_WriteSpeed
  $9A54,$03 Write the speed back.
N $9A57 Pick a target height from Jetman's position and steer the
. vertical thrust toward it.
  $9A57,$03 Fetch the Jetman type from #R$6078.
  $9A5A,$04 Jump to #R$9A62 if Jetman is on foot.
  $9A5E,$02 #REGa=#N$68.
  $9A60,$02 Jump to #R$9A65.
@ $9A62 label=Handler_Saturn_FetchJetmanY
  $9A62,$03 Fetch #R$607C.
N $9A65 Compare with the alien's Y position and, if the alien is above the
. target, increase the downward thrust, up to a limit.
@ $9A65 label=Handler_Saturn_CompareY
  $9A65,$03 Subtract the alien's Y position.
  $9A68,$03 Jump to #R$9ABC if the alien is below the target.
  $9A6B,$07 Jump to #R$9A76 if the vertical thrust is
. negative.
  $9A72,$04 Jump to #R$9A78 if the thrust is already at least
. #N$40.
@ $9A76 label=Handler_Saturn_AddThrust
  $9A76,$02 Add #N$02 to the thrust.
N $9A78 Apply the thrust to the Y position, bouncing off the play-area
. edges.
@ $9A78 label=Handler_Saturn_ApplyThrust
  $9A78,$03 Write the thrust back.
  $9A7B,$08 Divide it by #N$10.
  $9A83,$03 Add it to the alien's Y position.
  $9A86,$04 Jump to #R$9ACB if the alien is above the play
. area.
  $9A8A,$04 Jump to #R$9AD9 if the alien has hit the ground
. line.
  $9A8E,$03 Write the Y position back.
N $9A91 Pick the animation frame and colour.
@ $9A91 label=Handler_Saturn_Animate
  $9A91,$03 Increase the animation timer.
  $9A94,$03 Fetch the animation timer.
  $9A97,$02,b$01 Keep only bits 0-3.
N $9A99 Sprite IDs begin at #R$E703(#N$CC) (#SPRITENAME$CC).
  $9A99,$02 Add #N$CC for these frames.
  $9A9B,$03 Write it to the actor type.
N $9A9E Alternate the colour using bit 0 of #R$5E42.
  $9A9E,$03 Fetch #R$5E42.
  $9AA1,$02,b$01 Keep only bit 0.
  $9AA3,$02 Add #N$45 for the colour.
  $9AA5,$03 Write it to the actor colour.
  $9AA8,$03 Jump to #R$954B.
@ $9AAB label=Handler_Saturn_DriftRight
N $9AAB When the alien is left of the scroll, drift right.
  $9AAB,$02 #REGc=#N$80.
  $9AAD,$07 Jump to #R$9AB8 if the horizontal speed is
. negative.
  $9AB4,$04 Jump to #R$9A54 if the speed is already at least
. #N$50.
@ $9AB8 label=Handler_Saturn_AddSpeed
  $9AB8,$02 Add #N$02 to the speed.
  $9ABA,$02 Jump to #R$9A54.
@ $9ABC label=Handler_Saturn_ApplyUpThrust
N $9ABC When the alien is below the target, apply upward thrust.
  $9ABC,$07 Jump to #R$9AC7 if the vertical thrust is
. positive.
  $9AC3,$04 Jump to #R$9A78 if the thrust is already below
. #N$C1.
@ $9AC7 label=Handler_Saturn_SubtractThrust
  $9AC7,$02 Subtract #N$02 from the thrust.
  $9AC9,$02 Jump to #R$9A78.
@ $9ACB label=Handler_Saturn_BounceTop
N $9ACB Bounce off the top of the play area.
  $9ACB,$07 Jump to #R$9A91 if the vertical thrust is
. positive.
@ $9AD2 label=Handler_Saturn_NegateThrust
  $9AD2,$02 Negate the thrust.
  $9AD4,$03 Write it back.
  $9AD7,$02 Jump to #R$9A91.
@ $9AD9 label=Handler_Saturn_BounceGround
N $9AD9 Bounce off the ground line.
  $9AD9,$07 Jump to #R$9A91 if the vertical thrust is
. negative.
  $9AE0,$02 Jump to #R$9AD2.

c $9AE2 Handler: Shooter
@ $9AE2 label=Handler_Shooter
D $9AE2 Fire a shot when the Shooter is on screen, then chase Jetman's Y
. position.
R $9AE2 IX Actor slot
  $9AE2,$03 Fetch the high byte of the world X.
  $9AE5,$03 Fetch the low byte of the world X.
  $9AE8,$01 Stash the world X on the stack.
  $9AE9,$04 Fetch #R$607A.
  $9AED,$03 Subtract the scroll position.
  $9AF0,$07 Jump to #R$9B9E if the horizontal speed is
. negative.
  $9AF7,$01 Fetch the high byte of the gap.
  $9AF8,$02,b$01 Keep only bits 0-4.
  $9AFA,$05 Jump to #R$9BA6 if the alien has left the screen.
N $9AFF Skip firing and chase Jetman if the shooter is not on this
. screen.
@ $9AFF label=Handler_Shooter_ShotTolerance
  $9AFF,$04 Add a #N$78 tolerance.
  $9B03,$01 Fetch the high byte.
  $9B04,$01 Restore the world X into #REGde from the stack.
  $9B05,$03 Jump to #R$9B59 if the alien is not on this
. screen.
  $9B08,$01 Stash the world X on the stack again.
N $9B09 Set the speed to #N$50 or #N$B0 if bit 7 of *#REGix+#N$01 differs
. from the direction of travel.
  $9B09,$03 Fetch the screen column.
  $9B0C,$03 XOR it with the horizontal speed.
  $9B0F,$02,b$01 Keep only bit 7.
  $9B11,$02 Jump to #R$9B24 if they already match.
  $9B13,$07 Jump to #R$9B20 if the horizontal speed is
. negative.
  $9B1A,$04 Write #N$50 to the horizontal speed.
  $9B1E,$02 Jump to #R$9B24.
@ $9B20 label=Handler_Shooter_ShotSpeedLeft
  $9B20,$04 Write #N$B0 to the horizontal speed.
N $9B24 Spawn a shot in a free alien slot.
@ $9B24 label=Handler_Shooter_SpawnShot
  $9B24,$03 Call #R$9395.
  $9B27,$01 Restore the world X into #REGde from the stack.
  $9B28,$02 Jump to #R$9B59 if no alien slot is free.
  $9B2A,$02 Write type #N$B6 to the new slot.
  $9B2C,$06 Jump to #R$9B34 if the shot is moving left.
  $9B32,$02 Write type #N$B7.
N $9B34 Fill in the new shot: its position, speed, thrust and colour.
@ $9B34 label=Handler_Shooter_CopyShotX
  $9B34,$02 Move onto the world X.
  $9B36,$03 Write the shooter's world X into the slot.
  $9B39,$01 Move onto the Y position.
  $9B3A,$04 Copy the shooter's Y position.
N $9B3E Give the shot a speed in the direction the shooter is moving.
  $9B3E,$01 Move onto the horizontal speed.
  $9B3F,$07 Jump to #R$9B4A if the shooter is moving left.
  $9B46,$02 Write #N$70 to the shot speed.
  $9B48,$02 Jump to #R$9B4C.
@ $9B4A label=Handler_Shooter_ShotSpeedRight
  $9B4A,$02 Write #N$90 to the shot speed.
N $9B4C Zero the thrust, set the colour and clear the rest of the slot.
@ $9B4C label=Handler_Shooter_InitialiseShotSlot
  $9B4C,$04 Write #N$00 to the thrust.
  $9B50,$02 Write #COLOUR$47 to the colour.
  $9B52,$02 Set a byte counter in #REGb for #N$0F loops.
@ $9B54 label=Handler_Shooter_ClearShotTail
  $9B54,$03 Clear the next slot byte.
  $9B57,$02 Decrease the byte counter by one and loop back
. to #R$9B54 until the slot is cleared.
@ $9B59 label=Handler_Shooter_ChaseJetmanY
N $9B59 Chase Jetman's Y position.
  $9B59,$03 Fetch #R$607C.
  $9B5C,$03 Subtract the alien's Y position.
  $9B5F,$03 Jump to #R$9BAC if Jetman is below the alien.
  $9B62,$07 Jump to #R$9B6D if the vertical thrust is
. positive.
  $9B69,$04 Jump to #R$9B6F if the thrust is already below
. #N$EF.
@ $9B6D label=Handler_Shooter_ChaseSubtractThrust
  $9B6D,$02 Subtract #N$02 from the thrust.
N $9B6F Apply the thrust to the Y position unless it would leave the
. play area.
@ $9B6F label=Handler_Shooter_ChaseApplyThrust
  $9B6F,$03 Write the thrust back.
  $9B72,$08 Divide it by #N$10.
  $9B7A,$03 Add it to the alien's Y position.
  $9B7D,$04 Jump to #R$9B88 if the alien is above the play
. area.
  $9B81,$04 Jump to #R$9B88 if the alien has hit the ground
. line.
  $9B85,$03 Write the Y position back.
N $9B88 Step the animation timer and pick the animation frame.
@ $9B88 label=Handler_Shooter_ChaseTickAnimation
  $9B88,$03 Increase the animation timer.
  $9B8B,$03 Fetch the animation timer.
  $9B8E,$04 Jump to #R$9B96 if it is still below #N$07.
  $9B92,$04 Write #N$00 to the animation timer.
N $9B96 Sprite IDs begin at #R$E99C(#N$B8) (#SPRITENAME$B8).
@ $9B96 label=Handler_Shooter_ChaseWriteFrame
  $9B96,$02 Add #N$B8 for these frames.
  $9B98,$03 Write it to the actor type.
  $9B9B,$03 Jump to #R$954B.
N $9B9E Test whether a left-moving shooter has gone off the left edge.
@ $9B9E label=Handler_Shooter_ChaseStillOnScreen
  $9B9E,$01 Fetch the high byte of the gap.
  $9B9F,$02,b$01 Set bits 5-7.
  $9BA1,$05 Jump to #R$9AFF if the alien has not left the
. left edge.
@ $9BA6 label=Handler_Shooter_ChaseClearType
  $9BA6,$04 Write #N$00 to the actor type.
  $9BAA,$01 Restore the world X from the stack.
  $9BAB,$01 Return.
N $9BAC When Jetman is below the shooter, thrust downward.
@ $9BAC label=Handler_Shooter_ChaseAddThrustTest
  $9BAC,$07 Jump to #R$9BB7 if the vertical thrust is
. negative.
  $9BB3,$04 Jump to #R$9B6F if the thrust is already at least
. #N$20.
@ $9BB7 label=Handler_Shooter_ChaseAddThrust
  $9BB7,$02 Add #N$02 to the thrust.
  $9BB9,$02 Jump to #R$9B6F.

c $9BBB Handler: The Pip
@ $9BBB label=Handler_ThePip
D $9BBB Move the shot with its horizontal speed and test whether it has
. hit.
R $9BBB IX Actor slot
  $9BBB,$03 Fetch the high byte of the world X.
  $9BBE,$03 Fetch the low byte of the world X.
  $9BC1,$04 Fetch #R$607A.
  $9BC5,$03 Subtract the scroll position.
  $9BC8,$06 Jump to #R$9C17 if the horizontal speed is
. negative.
  $9BCE,$01 Fetch the high byte of the gap.
  $9BCF,$02,b$01 Keep only bits 0-4.
  $9BD1,$04 Jump to #R$9C1E if the shot has left the screen.
N $9BD5 Move the shot along its horizontal speed.
@ $9BD5 label=Handler_ThePip_MoveShotX
  $9BD5,$03 Fetch the high byte of the world X.
  $9BD8,$03 Fetch the low byte of the world X.
N $9BDB Turn the horizontal speed into a signed pixel step.
  $9BDB,$03 Fetch the horizontal speed.
  $9BDE,$02 Clear #REGd for a positive step.
  $9BE0,$08 Divide it by #N$10.
  $9BE8,$03 Jump to #R$9BED if the speed is positive.
  $9BEB,$02 Set #REGd=#N$FF for a negative step.
@ $9BED label=Handler_ThePip_AddShotStep
  $9BED,$01 Store the pixel step in #REGe.
N $9BEE Add the step to the world X, keep it in range and write it back.
  $9BEE,$01 Add the step to the world X.
  $9BEF,$01 Fetch the high byte.
  $9BF0,$02,b$01 Keep only bits 0-4.
  $9BF2,$03 Write the high byte back.
  $9BF5,$03 Write the low byte back.
N $9BF8 Draw the shot and colour its sprite.
  $9BF8,$03 Call #R$8B73.
  $9BFB,$03 Call #R$8733.
  $9BFE,$06 Jump to #R$9C0D if bit 0 of *#REGix+#N$10 is
. reset.
  $9C04,$03 Set the points to award in #REGbc to #N($0050,$04,$04).
  $9C07,$03 Call #R$899C.
  $9C0A,$03 Call #R$A73C.
N $9C0D Test whether the shot has hit Jetman, and kill him if so.
@ $9C0D label=Handler_ThePip_ShotHit
  $9C0D,$04 Return if #R$B2A2 does not set carry.
  $9C11,$03 Call #R$A73C.
  $9C14,$03 Jump to #R$B2D7.
@ $9C17 label=Handler_ThePip_ShotStillOnScreen
  $9C17,$01 Fetch the high byte of the gap.
  $9C18,$02,b$01 Set bits 5-7.
  $9C1A,$04 Jump to #R$9BD5 if the shot has not left the left
. edge.
@ $9C1E label=Handler_ThePip_ShotClearType
  $9C1E,$04 Write #N$00 to the actor type.
  $9C22,$01 Return.

c $9C23 Set Default Values
@ $9C23 label=SetDefaults
D $9C23 Copy the default names and high-score tables into
. working RAM.
N $9C23 Copy the default names and high-score tables into RAM.
  $9C23,$0B Copy #N($0018,$04,$04) bytes from #R$9D80 to #R$5E20.
  $9C2E,$0B Copy #N($0018,$04,$04) bytes from #R$9D98 to #R$5E06.
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
@ $9CFA label=Level1Aliens
D $9CFA Eight alien template pointers per row, picked at random by
. #R$9466. #R$9D72 selects the row from the level number (bits 1-3),
. so each row serves two levels and level #N$0A onwards uses the
. last row.
N $9CFA Level 1 aliens.
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

b $9D5A Jetman Default Data
@ $9D5A label=Jetman_Default_Data
D $9D5A Copied to #R$6078 by #R$9020.
B $9D5A,$18

w $9D72 Levels Alien Lookup Table
@ $9D72 label=LevelsAlienLookupTable

b $9D80 Default Hall Of Fame Names
@ $9D80 label=Default_HallOfFame_Names
D $9D80 Eight 3-letter names copied to #R$5E20 by #R$9C23:
. ACG, UPG, JSL, CTS, TDS, CLW, ICL and IBM.
  $9D80,$18

b $9D98 Default High Score
@ $9D98 label=Default_High_Score
D $9D98 Eight 3-byte BCD scores, highest first, copied over #R$5E06
. by #R$9C23.
B $9D98,$03 Default high score.
B $9D9B,$15 Other table entries.

w $9DB0 Jetman Tune Table
@ $9DB0 label=Jetman_Tune_Table
D $9DB0 Eight tune pointers. #R$8D06 and #R$91E2 pick one using bits
. 1-3 of #R$5E42 to queue a jingle on some frames. The first and last
. entries both point to #R$BA88.
W $9DB0,$10,$02

c $9DC0 Handler: Laser Beam
E $9DC0 View the equivalent code in;
. #LIST
. { #JETPAC$6F91 }
. LIST#
@ $9DC0 label=Handler_LaserBeam
D $9DC0 On even frames, find a free slot at #R$6000 and copy
. Jetman's column and Y into a new beam.
N $9DC0 Only fire on even values of #R$5E42.
  $9DC0,$03 Fetch #R$5E42.
  $9DC3,$02,b$01 Keep only bit 0.
  $9DC5,$01 Return if this is an odd frame.
@ $9DC6 label=Handler_LaserBeam_FindSlot
N $9DC6 Search for a free laser beam slot.
  $9DC6,$03 #REGhl=#R$6000.
  $9DC9,$03 #REGde=#N($0018,$04,$04).
  $9DCC,$02 Set a slot counter in #REGb for #N$04 loops.
@ $9DCE label=LaserBeam_Slot
  $9DCE,$04 Jump to #R$9DDE if this slot is free.
  $9DD2,$01 Move onto the next slot.
  $9DD3,$02 Decrease the slot counter by one and loop back
. to #R$9DCE until every slot has been tried.
N $9DD5 All four laser beam slots are in use.
  $9DD5,$01 Return.
@ $9DD6 label=Handler_LaserBeam_Loop
N $9DD6 When firing to the right, step the column on by #N$10.
  $9DD6,$02 Add #N$10 to the screen column.
  $9DD8,$02,b$01 Set bit 2.
  $9DDA,$02,b$01 Keep only bits 1-7.
  $9DDC,$02 Jump to #R$9DFA.
N $9DDE Initialise a new laser beam from Jetman.
@ $9DDE label=Initialise_LaserBeam
  $9DDE,$02 Write type #N$11 to mark the slot in use.
  $9DE0,$01 Move onto the beam Y.
  $9DE1,$03 #REGde=#R$6078.
  $9DE4,$02 #REGb=#N$0D.
  $9DE6,$01 Fetch Jetman's type.
  $9DE7,$01 Move onto Jetman's screen column.
N $9DE8 The actor type is a 1-based sprite ID. Decrease
. it to work on the 0-based index: bit 3 is set when
. walking and reset when flying, bit 2 is facing.
  $9DE8,$01 Decrease it to a 0-based sprite index.
  $9DE9,$04 Jump to #R$9DEF if Jetman is flying.
  $9DED,$02 Decrease the Y offset by two.
@ $9DEF label=Handler_LaserBeam_TestFacing
  $9DEF,$02,b$01 Keep only bit 2.
  $9DF1,$01 Fetch Jetman's screen column.
  $9DF2,$02 Jump to #R$9DD6 if Jetman is facing right.
  $9DF4,$02 Subtract #N$08 from the screen column.
  $9DF6,$02,b$01 Keep only bits 3-7.
  $9DF8,$02,b$01 Set bits 0 and 2.
N $9DFA Write the beam Y and the X of each of the four pulses.
@ $9DFA label=Handler_LaserBeam_StoreColumn
  $9DFA,$01 Stash the beam column in #REGc.
  $9DFB,$03 Move onto Jetman's Y.
  $9DFE,$01 Fetch Jetman's Y.
  $9DFF,$01 Subtract the Y offset.
  $9E00,$01 Write it as the beam Y.
  $9E01,$01 Move onto the first pulse X.
N $9E02 Write the beam column into the four pulses, clearing bit 2 in all but
. the first.
  $9E02,$02 Set a pulse counter in #REGb for #N$03 loops.
  $9E04,$01 Write the beam column as pulse #N$01.
  $9E05,$01 Copy it into #REGa.
  $9E06,$02,b$01 Reset bit 2.
@ $9E08 label=Handler_LaserBeam_WritePulse
  $9E08,$01 Move onto the next pulse X.
  $9E09,$01 Write the column without bit 2.
  $9E0A,$02 Decrease the pulse counter by one and loop back
. to #R$9E08 until pulses #N$02-#N$04 are written.
N $9E0C Set the beam timer, pick the beam colour and play the laser
. sound.
  $9E0C,$01 Move onto the beam timer.
  $9E0D,$03 Fetch #R$5E40.
  $9E10,$02,b$01 Keep only bits 3-4.
  $9E12,$02 Add #N$60.
  $9E14,$01 Write it as the beam timer.
N $9E15 Pick the beam colour from the table at #R$9E28 using bits 0-1 of
. #R$5E40.
  $9E15,$01 Move onto the beam colour.
  $9E16,$01 Switch the slot pointer into #REGde.
  $9E17,$03 #REGhl=#R$9E28.
  $9E1A,$03 Fetch #R$5E40.
  $9E1D,$02,b$01 Keep only bits 0-1.
  $9E1F,$03 Create an offset in #REGbc.
  $9E22,$01 Point #REGhl at that colour.
  $9E23,$01 Fetch the colour.
  $9E24,$01 Write it to the beam colour.
  $9E25,$03 Jump to #R$B8A8.
N $9E28 The four colours a laser beam can be.
@ $9E28 label=Attributes_LaserBeam
B $9E28,$01 #COLOUR(#PEEK(#PC)).
L $9E28,$01,$04

c $9E2C Animate: Laser Beam
@ $9E2C label=LaserBeam_Animate
E $9E2C View the equivalent code in;
. #LIST
. { #JETPAC$6FFC }
. LIST#
D $9E2C XOR the four beam pulses onto the screen and drop the
. slot when they have all expired.
R $9E2C IX Actor slot
  $9E2C,$03 Call #R$A796.
  $9E2F,$03 Fetch the beam Y.
  $9E32,$03 Fetch pulse #N$01.
  $9E35,$04 Jump to #R$9E68 if bit 2 is reset.
N $9E39 Move pulse #N$01 on and invert the screen byte there.
  $9E39,$01 Copy the pulse X into #REGl.
  $9E3A,$02 #REGa=#N$08.
  $9E3C,$04 Jump to #R$9E42 if bit 0 of the pulse X is reset.
  $9E40,$02 Negate the step.
N $9E42 Add the step to pulse #N$01 and find the screen byte there.
@ $9E42 label=LaserBeam_Animate_StepX
  $9E42,$01 Add the step to the pulse X.
  $9E43,$01 Copy the new X into #REGe.
  $9E44,$01 Copy the beam Y into #REGh.
  $9E45,$01 Stash the beam position on the stack.
  $9E46,$03 Call #R$851E.
  $9E49,$03 Write the new X back as pulse #N$01.
N $9E4C Invert the screen byte, then find the attribute square.
  $9E4C,$02 #REGa=#N$FF.
  $9E4E,$01 Invert the screen byte.
  $9E4F,$01 Write it back.
  $9E50,$01 Restore the beam position from the stack.
  $9E51,$03 Call #R$8506.
N $9E54 Colour the attribute square, then count the beam timer down.
  $9E54,$03 Fetch the beam colour.
  $9E57,$01 Write it to the attribute square.
  $9E58,$03 Fetch the beam timer.
  $9E5B,$02 Subtract #N$08.
  $9E5D,$03 Write it back.
  $9E60,$02,b$01 Keep only bits 3-7.
  $9E62,$02 Jump to #R$9E68 if any of those bits remain.
  $9E64,$04 Reset bit 2 of pulse #N$01.
@ $9E68 label=LaserBeam_Animate_WalkPulses
N $9E68 Set up the pixel masks in the shadow registers, then walk
. pulses #N$02-#N$04.
  $9E68,$01 Switch to the shadow registers.
  $9E69,$03 #REGbc'=#N$031C.
  $9E6C,$02 #REGe'=#N$E0.
  $9E6E,$01 Switch back to the main registers.
  $9E6F,$02 #REGe=#N$03.
  $9E71,$03 Copy the slot pointer into #REGbc (using the
. stack).
  $9E74,$03 Move #REGbc onto pulse #N$02.
N $9E77 Walk the pulses, skipping any on pulse #N$01's character column.
@ $9E77 label=LaserBeam_Animate_Loop
  $9E77,$01 Fetch this pulse X.
  $9E78,$03 Compare it against pulse #N$01.
  $9E7B,$02,b$01 Keep only bits 3-7.
  $9E7D,$02 Jump to #R$9E8D if the pulses are not on the
. same character column.
  $9E7F,$01 Switch to the shadow registers.
  $9E80,$03 Rotate the mask bytes.
  $9E83,$01 Switch back to the main registers.
  $9E84,$01 Move onto the next pulse.
  $9E85,$01 Decrease the pulse counter by one.
  $9E86,$02 Jump back to #R$9E77 if any pulses remain.
N $9E88 Free the actor slot once every pulse has been skipped.
  $9E88,$04 Write #N$00 to the slot type.
  $9E8C,$01 Return.
N $9E8D If this pulse is not moving yet, wait on the beam timer and
. then start it.
@ $9E8D label=LaserBeam_Animate_TestBit
  $9E8D,$01 Fetch this pulse X.
  $9E8E,$04 Jump to #R$9EAD if bit 2 is set.
N $9E92 Count the beam timer down and return until its low bits reach zero.
  $9E92,$03 Decrease the beam timer by one.
  $9E95,$03 Fetch the beam timer.
  $9E98,$02,b$01 Keep only bits 0-2.
  $9E9A,$01 Return if the timer is still running.
N $9E9B Fold bits 0-1 of #R$5E40 into the beam timer and start this pulse
. moving.
  $9E9B,$03 Fetch #R$5E40.
  $9E9E,$02,b$01 Keep only bits 0-1.
  $9EA0,$02,b$01 Set bit 2.
  $9EA2,$03 Merge in the beam timer.
  $9EA5,$03 Write it back.
  $9EA8,$01 Fetch this pulse X.
  $9EA9,$02,b$01 Set bit 2.
  $9EAB,$01 Write it back.
  $9EAC,$01 Return.
N $9EAD Move this pulse on and XOR its mask onto the screen.
@ $9EAD label=LaserBeam_Animate_DrawPulse
  $9EAD,$01 Fetch this pulse X.
  $9EAE,$01 Copy it into #REGl.
  $9EAF,$02 #REGa=#N$08.
  $9EB1,$04 Jump to #R$9EB7 if bit 0 of the pulse X is reset.
  $9EB5,$02 Negate the step.
@ $9EB7 label=LaserBeam_Animate_AdvancePulse
  $9EB7,$01 Add the step to the pulse X.
  $9EB8,$01 Write the new X back.
N $9EB9 Draw this pulse by XORing its mask onto the screen byte.
  $9EB9,$01 Copy the beam Y into #REGh.
  $9EBA,$03 Call #R$851E.
  $9EBD,$01 Switch to the shadow registers.
  $9EBE,$03 Rotate the mask bytes.
  $9EC1,$01 Switch back to the main registers.
  $9EC2,$01 Flip the screen pixels that are set in the mask in #REGa, so the
. pulse is drawn, or erased if it is already there.
  $9EC3,$01 Write it back.
  $9EC4,$01 Move onto the next pulse.
  $9EC5,$01 Decrease the pulse counter by one.
  $9EC6,$03 Jump back to #R$9E77 if any pulses remain.
  $9EC9,$01 Return.

c $9ECA Animate From Scroll
@ $9ECA label=AnimateFromScroll
D $9ECA Use the low bits of #R$607A minus the actor world X as the
. animation frame.
R $9ECA IX Actor slot
  $9ECA,$03 Fetch #R$607A.
  $9ECD,$03 Subtract the actor world X.
  $9ED0,$02,b$01 Keep only bits 0-2.
N $9ED2 Sprite IDs begin at #R$C782(#N$1A) (#SPRITENAME$1A).
  $9ED2,$02 Add #N$1A for the sprite IDs.
  $9ED4,$03 Write it to the actor type.
  $9ED7,$03 Call #R$8787.
  $9EDA,$02 Jump to #R$9EEE.

c $9EDC Handler: Rover Frames
@ $9EDC label=Handler_RoverFrames
D $9EDC Advance the moon rover animation from #R$607A, then
. colour the cab and flash the HUD tile chosen by #R$AD36.
R $9EDC IX Actor slot
  $9EDC,$03 Fetch #R$607A.
  $9EDF,$03 Subtract the rover world X.
  $9EE2,$02 Negate the difference.
N $9EE4 The rover has eight frames of animation.
  $9EE4,$02,b$01 Keep only bits 0-2.
N $9EE6 Sprite IDs begin at #R$BE90(#N$22)
. (#SPRITENAME$22).
  $9EE6,$02 Add #N$22 for the rover frames.
  $9EE8,$03 Write it to the actor type.
  $9EEB,$03 Call #R$8787.
@ $9EEE label=Handler_RoverFrames_TestInactive
N $9EEE While #R$5E6C is set, count it up and tint the rover from it.
  $9EEE,$03 Fetch #R$5E6C.
  $9EF1,$03 Jump to #R$9EFA if it is zero.
  $9EF4,$01 Increase #R$5E6C by one.
  $9EF5,$03 Write it back.
  $9EF8,$02 Jump to #R$9F3F.
N $9EFA Fill attribute cells at the rover's position when #R$5E57 is
. not zero.
@ $9EFA label=Handler_RoverFrames_Address
  $9EFA,$03 Fetch the rover screen column.
  $9EFD,$03 Fetch the rover Y.
  $9F00,$03 Call #R$8506.
  $9F03,$03 Fetch #R$5E57.
  $9F06,$03 Jump to #R$9F18 if it is zero.
N $9F09 Fill two rows of the rover's attribute cells with #COLOUR$47, then the
. two rows above them with #COLOUR$45. Cells that are empty are left alone.
  $9F09,$01 Set the number of columns to fill in #REGb from #R$5E57.
  $9F0A,$02 Set the number of rows to fill in #REGc to #N$02.
  $9F0C,$02 Set the fill attribute in #REGd to #COLOUR$47.
  $9F0E,$03 Call #R$8931 to fill the first two rows.
N $9F11 #R$8931 leaves #REGhl one row above the last row it filled, so the
. next call carries on from there.
  $9F11,$02 Set the fill attribute in #REGd to #COLOUR$45.
  $9F13,$02 Set the number of rows to fill in #REGc to #N$02.
  $9F15,$03 Call #R$8931 to fill the next two rows up.
N $9F18 Flash one of the two HUD tiles, chosen by #R$AD36.
@ $9F18 label=Handler_RoverFrames_MissileBanner
  $9F18,$03 Call #R$AD36.
  $9F1B,$02 Jump to #R$9F2E if #R$AD36 returned no carry.
N $9F1D The carry is set, so flash the first tile (#N$5861) and set the
. second tile (#N$5863) to a steady colour.
  $9F1D,$03 Call #R$AD0B to fetch the flashing attribute.
  $9F20,$03 Point #REGhl at the first HUD tile (#N$5861).
  $9F23,$03 Call #R$AD00 to colour the tile with #REGa.
  $9F26,$03 Point #REGhl at the second HUD tile (#N$5863).
  $9F29,$02 Set the steady attribute in #REGa to #COLOUR$42.
  $9F2B,$03 Jump to #R$AD00 to colour the tile with #REGa.
N $9F2E There is no carry, so flash the second tile (#N$5863) and set the
. first tile (#N$5861) to a steady colour.
@ $9F2E label=Handler_RoverFrames_ClearBanner
  $9F2E,$03 Call #R$AD0B to fetch the flashing attribute.
  $9F31,$03 Point #REGhl at the second HUD tile (#N$5863).
  $9F34,$03 Call #R$AD00 to colour the tile with #REGa.
  $9F37,$03 Point #REGhl at the first HUD tile (#N$5861).
  $9F3A,$02 Set the steady attribute in #REGa to #COLOUR$42.
  $9F3C,$03 Jump to #R$AD00 to colour the tile with #REGa.
@ $9F3F label=Handler_RoverFrames_Tint
N $9F3F Tint the rover from the frame value in #REGa.
  $9F3F,$02 Compare #REGa against #N$30.
  $9F41,$03 Jump to #R$B03B if it is at least #N$30.
N $9F44 Use bits 1-3 of the value as the INK colour, stepping through the
. colours as it counts up.
  $9F44,$01 Rotate it right once.
  $9F45,$02,b$01 Keep only bits 0-2.
  $9F47,$02 Jump to #R$9F4A if the result is not zero.
N $9F49 The PAPER is black, so INK #N$00 would make the rover black on black and
. invisible. Use INK #N$01 (blue) as the lowest colour instead.
  $9F49,$01 Increase it to #N$01.
@ $9F4A label=Handler_RoverFrames_WriteColour
  $9F4A,$02,b$01 Set bit 6.
  $9F4C,$03 Write it to the rover colour.
  $9F4F,$03 Call #R$8733.
N $9F52 Play a tone derived from the rover colour.
  $9F52,$03 Fetch the rover colour.
  $9F55,$01 Invert the bits.
  $9F56,$02,b$01 Keep only bits 0-6.
  $9F58,$01 Copy the tone into #REGc.
  $9F59,$02 #REGd=#N$20.
  $9F5B,$03 Jump to #R$B918.

c $9F5E Initialise Objects
@ $9F5E label=InitialiseObjects
D $9F5E Copy the #N$60-byte object table from #R$A008 into the
. in-play slots at #R$6090.
  $9F5E,$0B Copy #N$60 bytes from #R$A008 to #R$6090.
  $9F69,$01 Return.

c $9F6A Step Pickup Candidate
@ $9F6A label=StepPickupCandidate
D $9F6A Step the high byte of the candidate pickup world X on by #N$10, then
. test it again at #R$9F87.
R $9F6A HL Candidate world X
  $9F6A,$01 Fetch the high byte.
  $9F6B,$02 Add #N$10.
  $9F6D,$01 Write it back.
  $9F6E,$02 Jump to #R$9F87.

c $9F70 Handler: Pickups
@ $9F70 label=Handler_Pickups
D $9F70 Keep the collectible objects in the world. When the pickup slots are
. empty, refill them, choose a world X away from Jetman and the rover, place
. the pickups from it and then advance the level.
N $9F70 Refill #R$6108 from #R$A068 when those slots are empty.
  $9F70,$03 Call #R$B1E2.
  $9F73,$01 Return if any pickup slot is still in use.
  $9F74,$0B Copy the #N$90 bytes of pickup templates from #R$A068 into the
. pickup slots at #R$6108.
N $9F7F Seed the candidate world X in #REGhl from #R$5E42 and #R$5E40.
  $9F7F,$03 Fetch #R$5E42.
  $9F82,$01 Stash it in #REGh.
  $9F83,$03 Fetch #R$5E40.
  $9F86,$01 Stash it in #REGl.
@ $9F87 label=Handler_Pickups_AwayFromJetman
N $9F87 Keep the new world X at least #N$10 away from
. #R$607A and #R$6092.
  $9F87,$03 Fetch the high byte of #R$607A.
  $9F8A,$03 Multiply it by #N$08.
  $9F8D,$01 Subtract the candidate high byte.
  $9F8E,$03 Jump to #R$9F93 if the result is positive.
  $9F91,$02 Negate the difference.
@ $9F93 label=Handler_Pickups_TestJetmanX
  $9F93,$02 Compare it against #N$10.
  $9F95,$02 Jump to #R$9F6A if it is closer than that.
N $9F97 Retry unless the candidate is also at least #N$10 from #R$6092.
  $9F97,$03 Fetch the high byte of #R$6092.
  $9F9A,$03 Multiply it by #N$08.
  $9F9D,$01 Subtract the candidate high byte.
  $9F9E,$03 Jump to #R$9FA3 if the result is positive.
  $9FA1,$02 Negate the difference.
@ $9FA3 label=Handler_Pickups_TestRoverX
  $9FA3,$02 Compare it against #N$10.
  $9FA5,$02 Jump to #R$9F6A if it is closer than that.
N $9FA7 Write the new pickup positions into the pickup slots.
  $9FA7,$06 Divide the candidate high byte by #N$08.
  $9FAD,$03 Write it to #R$6108(#N$610A).
N $9FB0 Derive the other pickup world X values by adding offsets and wrapping.
. #R$A002 hands the wrapped result back in #REGhl, so each offset is added to
. the world X written just before it.
  $9FB0,$03 Set the offset in #REGbc to #N($0040,$04,$04) to place the next
. pickup that far on from the first.
  $9FB3,$03 Call #R$A002 to add the offset and wrap the world X.
  $9FB6,$03 Write it to #R$6168(#N$616A).
N $9FB9 Place the next pickup a smaller step further on.
  $9FB9,$03 Set the offset in #REGbc to #N($0008,$04,$04).
  $9FBC,$03 Call #R$A002 to add the offset and wrap the world X.
  $9FBF,$03 Write it to #R$6182.
N $9FC2 Finally step on by #N$40 again for the last pickup.
  $9FC2,$03 Set the offset in #REGbc to #N($0040,$04,$04).
  $9FC5,$03 Call #R$A002 to add the offset and wrap the world X.
  $9FC8,$03 Write it to #R$613A.
N $9FCB Advance the level, and award an extra life every
. fourth level.
  $9FCB,$03 Fetch #R$5EA0.
  $9FCE,$04 Jump to #R$9FD3 if it is already #N$63.
  $9FD2,$01 Increase the level by one.
@ $9FD3 label=Handler_Pickups_WriteLevel
  $9FD3,$03 Write it back to #R$5EA0.
  $9FD6,$03 Jump to #R$9FEA if the new level is zero.
  $9FD9,$02,b$01 Keep only bits 0-1.
  $9FDB,$02 Jump to #R$9FEA if this is not a fourth level.
N $9FDD Award an extra life and queue a jingle, then redraw the lives.
  $9FDD,$03 #REGhl=#R$5EA1.
  $9FE0,$01 Increase #R$5EA1 by one.
  $9FE1,$03 Point #REGde at the tune at #R$BAB4.
  $9FE4,$03 Call #R$B9BC.
  $9FE7,$03 Call #R$894F.
N $9FEA Turn the level into the missile launcher countdown at #R$617F (the
. higher the level, the shorter it is), then jump to #R$F5EC.
. Rotating left twice multiplies the level by #N$04. Inverting and masking
. that to bits 2-5 gives #N$3C minus #N$04 for each level, so adding #N$51
. leaves a countdown that falls by #N$04 per level, from #N$8D to #N$51.
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Level | =h Rotate x2 | =h Invert | =h Keep bits 2-5 | =h Add #N$51 }
. { #N$00 | #N$00 | #N$FF | #N$3C | #N$8D }
. { #N$01 | #N$04 | #N$FB | #N$38 | #N$89 }
. { #N$02 | #N$08 | #N$F7 | #N$34 | #N$85 }
. { #N$07 | #N$1C | #N$E3 | #N$20 | #N$71 }
. { #N$0F | #N$3C | #N$C3 | #N$00 | #N$51 }
. { #N$10 and up | #N$FF | #N$00 | #N$00 | #N$51 }
. TABLE#
@ $9FEA label=Handler_Pickups_TestLevel10
  $9FEA,$03 Fetch #R$5EA0.
  $9FED,$02 Compare it against #N$10.
  $9FEF,$03 Call #R$9FFF if the level is at least #N$10.
  $9FF2,$02 Rotate the level left twice.
  $9FF4,$01 Invert the bits.
  $9FF5,$02,b$01 Keep only bits 2-5.
  $9FF7,$02 Add #N$51.
  $9FF9,$03 Write it to #R$617F.
  $9FFC,$03 Jump to #R$F5EC.
N $9FFF Levels of #N$10 and above use #N$FF in place of the level, so they all
. get the shortest countdown (#N$51). The rotate would otherwise wrap the
. high bits of the level round into the result.
@ $9FFF label=Handler_Pickups_ForceMaximumLevel
  $9FFF,$02 #REGa=#N$FF.
  $A001,$01 Return.

c $A002 Wrap World X
@ $A002 label=MaskWorldX
D $A002 Add #REGbc to a world X and keep bits 0-4 of
. the high byte.
R $A002 HL World X
R $A002 BC Offset
R $A002 O:HL Wrapped world X
N $A002 Add the offset and wrap the high byte to bits 0-4.
  $A002,$01 Add the offset.
  $A003,$01 Fetch the high byte.
  $A004,$02,b$01 Keep only bits 0-4.
  $A006,$01 Write it back.
  $A007,$01 Return.

b $A008 Object Defaults
@ $A008 label=Object_Defaults
D $A008 Four #N$18-byte actor templates. #R$9F5E copies
. this table to #R$6090.
B $A008,$60,$18

b $A068 Pickup Defaults
@ $A068 label=Pickup_Defaults
D $A068 Six #N$18-byte templates. #R$9F70 copies
. this table to #R$6108 when the pickup list is empty.
B $A068,$90,$18

c $A0F8 Handler: Pickup Action
@ $A0F8 label=Handler_PickupAction
D $A0F8 Test the action key and drop or collect the current object.
R $A0F8 IX Actor slot
  $A0F8,$05 Jump to #R$A101 if the action key is pressed.
  $A0FD,$04 Reset bit 1 of the actor flags.
@ $A101 label=Handler_PickupAction_TestRover
  $A101,$03 Fetch #R$6090.
  $A104,$02 Subtract #N$1A.
  $A106,$04 Jump to #R$A10F if that is not a rover frame.
  $A10A,$03 Call #R$A431.
  $A10D,$02 Jump to #R$A126.
@ $A10F label=Handler_PickupAction_PickOffset
N $A10F Type #N$16 and above is seated facing right;
. hang the object on the left.
  $A10F,$03 Fetch #R$6078.
  $A112,$04 Jump to #R$A121 if Jetman's type is less than
. #N$16.
  $A116,$03 Set the offset in #REGbc to #N$FFF4 (-#N$0C).
N $A119 Place the object at Jetman's X plus the offset, then go to collect it.
@ $A119 label=Handler_PickupAction_Loop
  $A119,$03 Fetch #R$607A.
  $A11C,$03 Call #R$A43E.
  $A11F,$02 Jump to #R$A12C.
@ $A121 label=Handler_PickupAction_OnFootOffset
  $A121,$03 Set the offset in #REGbc to #N($0012,$04,$04).
  $A124,$02 Jump to #R$A119.
N $A126 Skip the collect test unless the action key is pressed.
@ $A126 label=Handler_PickupAction_TestAction
  $A126,$03 Call #R$945C.
  $A129,$03 Jump to #R$A212 if the action key is not pressed.
@ $A12C label=Handler_PickupAction_Collect
N $A12C Collect this object if Jetman is free and in range.
  $A12C,$03 Fetch #R$6080.
  $A12F,$02,b$01 Keep only bit 0.
  $A131,$03 Jump to #R$A212 if Jetman is already carrying.
  $A134,$03 Fetch the actor flags.
  $A137,$02,b$01 Keep only bits 0-2 and 4-6.
  $A139,$03 Jump to #R$A212 if any of those bits are set.
N $A13C Check the object is in range of Jetman.
  $A13C,$03 Call #R$A4FC.
  $A13F,$03 Jump to #R$A212 if the object is out of range.
N $A142 Free the rover if this object was attached to it.
  $A142,$06 Jump to #R$A14C if bit 3 of the actor flags is
. reset.
  $A148,$04 Write #N$00 to #R$5EA3.
N $A14C Mark Jetman as carrying the object and play the pickup sound.
@ $A14C label=Handler_PickupAction_SetCarrying
  $A14C,$03 Fetch #R$6080.
  $A14F,$02,b$01 Set bit 0.
  $A151,$03 Write it back.
  $A154,$04 Write #N$06 to the actor flags.
  $A158,$03 Jump to #R$B8BD.
@ $A15B label=Handler_PickupAction_SnapToJetman
N $A15B Snap the object onto Jetman.
  $A15B,$03 Fetch #R$607A.
  $A15E,$03 Write the low byte as the object world X.
  $A161,$03 Write the high byte.
  $A164,$03 Fetch #R$607C.
  $A167,$02 Add #N$12.
  $A169,$04 Jump to #R$A16F if that is still above the
. ground line.
N $A16D #N$AF is the ground line.
  $A16D,$02 #REGa=#N$AF.
@ $A16F label=Handler_PickupAction_WriteY
  $A16F,$03 Write it as the object Y.
  $A172,$05 Jump to #R$A17C if the action key is pressed.
  $A177,$04 Reset bit 1 of the actor flags.
  $A17B,$01 Return.
@ $A17C label=Handler_PickupAction_Throw
N $A17C Throw the object on a second action press.
  $A17C,$05 Return if bit 1 of the actor flags is set.
  $A181,$04 Reset bit 2 of the actor flags.
  $A185,$03 Fetch #R$6080.
  $A188,$02,b$01 Reset bit 0.
  $A18A,$03 Write it back.
  $A18D,$04 Set bit 1 of the actor flags.
  $A191,$04 Set bit 7 of the actor flags.
N $A195 Give the object Jetman's speed and play the drop sound.
  $A195,$03 Fetch #R$607D.
  $A198,$08 Divide it by #N$10.
  $A1A0,$03 Write it as the object speed.
  $A1A3,$04 Write #N$01 to the object thrust.
  $A1A7,$03 Jump to #R$B8C3.

c $A1AA Handler: Pickup
@ $A1AA label=Handler_Pickup
D $A1AA Animate a collectible, attach it to the rover when #R$5EA3 is
. clear, and teleport Jetman from #R$A212 when SPACE is pressed
. beside it.
R $A1AA IX Actor slot
N $A1AA Cycle the sprite ID and colour from #R$5E42.
  $A1AA,$03 Fetch #R$5E42.
  $A1AD,$01 Rotate it right once.
  $A1AE,$01 Stash it in #REGc.
  $A1AF,$02,b$01 Keep only bits 0-1.
N $A1B1 Sprite IDs begin at #R$D074(#N$2A) (#SPRITENAME$2A).
  $A1B1,$02 Add #N$2A for the pickup frames.
  $A1B3,$03 Write it to the actor type.
  $A1B6,$02 Clear #REGb.
  $A1B8,$03 #REGhl=#R$A313.
N $A1BB Pick the actor colour from the next two bits of the timer.
  $A1BB,$01 Copy the rotated timer into #REGa.
  $A1BC,$02 Rotate it right twice.
  $A1BE,$02,b$01 Keep only bits 0-1.
  $A1C0,$01 Copy the colour index into #REGc.
  $A1C1,$01 Point #REGhl at that colour.
  $A1C2,$01 Fetch the colour.
  $A1C3,$03 Write it to the actor colour.
  $A1C6,$07 Jump to #R$A0F8 if bit 3 of the actor flags is
. set.
N $A1CD Drop the object to the ground while bit 7 of the actor
. flags is set.
  $A1CD,$06 Jump to #R$A1F8 if bit 7 of the actor flags is
. reset.
  $A1D3,$03 Call #R$A522.
  $A1D6,$02 Jump to #R$A1E0 if the object has not landed.
  $A1D8,$03 Fetch the actor flags.
  $A1DB,$02,b$01 Keep only bit 1.
  $A1DD,$03 Write it back.
N $A1E0 Attach the pickup to the rover if the rover is not
. carrying and the pickup is in range.
@ $A1E0 label=Handler_Pickup_TestCarrying
  $A1E0,$03 Fetch #R$5EA3.
  $A1E3,$03 Jump to #R$A1F8 if the rover is already carrying.
  $A1E6,$03 Call #R$A4BA.
  $A1E9,$02 Jump to #R$A1F8 if the object is out of range.
  $A1EB,$05 Write #N$01 to #R$5EA3.
  $A1F0,$04 Set bit 3 of the actor flags.
  $A1F4,$04 Reset bit 2 of the actor flags.
@ $A1F8 label=Handler_Pickup_Draw
  $A1F8,$03 Call #R$ABB4.
N $A1FB Type #N$11 and above means Jetman is not on
. foot.
  $A1FB,$03 Fetch #R$6078.
  $A1FE,$03 Return if Jetman's type is at least #N$11.
  $A201,$07 Jump to #R$A15B if bit 2 of the actor flags is
. set.
  $A208,$03 Call #R$945C.
  $A20B,$03 Jump to #R$A12C if the action key is pressed.
  $A20E,$04 Reset bit 1 of the actor flags.
@ $A212 label=Handler_Pickup_Teleport
N $A212 Teleport Jetman when SPACE is pressed beside this pickup.
  $A212,$03 Fetch #R$6078.
  $A215,$03 Return if Jetman's type is at least #N$11.
N $A218 Return unless Jetman is in range and SPACE is pressed.
  $A218,$03 Call #R$A4FC.
  $A21B,$01 Return if the object is out of range.
  $A21C,$03 Call #R$933E.
  $A21F,$01 Return if SPACE is not pressed.
N $A220 Find the object to teleport to: the position at #R$60AA, unless this
. is the object at #R$60A8.
  $A220,$03 Copy the slot pointer into #REGhl (using the
. stack).
  $A223,$03 Set #REGbc to the slot-1 address #R$60A8.
  $A226,$01 Clear the carry flag.
  $A227,$02 Subtract the slot-1 address.
  $A229,$03 Jump to #R$A30A if this is slot 1.
  $A22C,$03 Fetch #R$60AC.
  $A22F,$03 Fetch #R$60AA.
@ $A232 label=Handler_Pickup_Attach
N $A232 Move Jetman onto the destination object's position and
. start the teleport.
  $A232,$04 Fetch #R$607C into #REGde.
  $A236,$03 Write the destination Y over #R$607C.
  $A239,$01 Fetch the low byte of the destination world X.
  $A23A,$02,b$01 Keep only bits 3-7.
  $A23C,$01 Write it back.
  $A23D,$03 Write the pair to #R$607A.
N $A240 Record a Y near Jetman's old position for the debris burst.
  $A240,$01 Fetch Jetman's old Y.
  $A241,$02 Subtract #N$0C.
  $A243,$03 Write it to #R$5E6A.
  $A246,$03 Fetch #R$6078.
N $A249 The actor type is a 1-based sprite ID. Decrease
. it to work on the 0-based index, reset bit 3 to
. switch from the walking frames to the flying
. frames, then write the 1-based ID back.
  $A249,$01 Decrease it to a 0-based sprite index.
  $A24A,$02,b$01 Reset bit 3.
  $A24C,$01 Increase it by one.
  $A24D,$03 Write it back.
  $A250,$03 Jump to #R$A299.

c $A253 Fill Pickup Debris
@ $A253 label=FillPickupDebris
D $A253 Fill the #N$10 debris particles at #R$AA4B from the template at
. #R$AA13(#N$AA1B), using #R$5E6A as the starting Y of the burst.
  $A253,$03 #REGde=#R$AA13(#N$AA1B).
  $A256,$03 #REGhl=#R$AA4B.
  $A259,$02 Set a particle counter in #REGb for #N$10 loops.
N $A25B Fill each debris particle with a flag, the burst Y and template bytes.
@ $A25B label=FillPickupDebris_Loop
  $A25B,$02 Write #N$80 as the particle flag.
  $A25D,$01 Move onto the particle Y.
  $A25E,$03 Fetch #R$5E6A.
  $A261,$01 Write it.
  $A262,$01 Move onto the next field.
  $A263,$02 Copy the next template byte.
  $A265,$02 Write it and move on.
  $A267,$02 Copy the next template byte.
  $A269,$02 Write it and move on.
  $A26B,$02 Copy the next template byte.
  $A26D,$02 Write it and move on.
  $A26F,$02 Decrease the particle counter by one and loop
. back to #R$A25B until all #N$10 are filled.
  $A271,$01 Return.

c $A272 Animate Pickup Debris
@ $A272 label=AnimatePickupDebris
D $A272 Step the #N$10 debris particles at #R$AA4B, repeating until none of
. them is still moving (#R$5E69 is zero).
  $A272,$04 Write #N$00 to #R$5E69.
  $A276,$03 Fetch #R$5E7B.
  $A279,$01 Decrease it by one.
  $A27A,$03 Write it back.
  $A27D,$03 Call #R$B8F2.
N $A280 Step each of the #N$10 debris particles in turn.
  $A280,$04 #REGix=#R$AA4B.
  $A284,$02 Set a particle counter in #REGb for #N$10 loops.
@ $A286 label=AnimatePickupDebris_CallParticle
  $A286,$01 Stash the particle counter on the stack.
  $A287,$03 Call #R$A993.
  $A28A,$03 Set the step to the next particle in #REGbc to #N($0005,$04,$04).
  $A28D,$02 Move onto the next particle.
  $A28F,$01 Restore the particle counter from the stack.
  $A290,$02 Decrease the particle counter by one and loop
. back to #R$A286 until all #N$10 have moved.
N $A292 Go round again while particles are still moving, else return.
  $A292,$03 Fetch #R$5E69.
  $A295,$03 Jump back to #R$A272 if any particles remain.
  $A298,$01 Return.

c $A299 Start Teleport
@ $A299 label=StartTeleport
D $A299 Play the briefing tune and burst debris around Jetman, then rebuild
. the play area at the new position and rejoin the actor loop at #R$81E1.
. This sets #R$5E68, so that #R$A2CF finishes the teleport.
  $A299,$01 Disable interrupts.
  $A29A,$03 #REGde=#R$BA2A.
  $A29D,$03 Call #R$B9BC.
  $A2A0,$01 Call the ROM interrupt routine at #SKOOLKID$0038(MASK-INT).
N $A2A1 Run the first debris burst.
  $A2A1,$04 Write #N$00 to #R$5E7B.
  $A2A5,$03 Call #R$A253.
  $A2A8,$03 Call #R$A272.
N $A2AB Redraw Jetman's sprite, then run another debris burst.
  $A2AB,$04 #REGix=#R$6078.
  $A2AF,$03 Call #R$8640.
  $A2B2,$03 Call #R$A253.
  $A2B5,$03 Call #R$A272.
N $A2B8 Reset the laser beam slots and sprite caches, redraw the play area and
. rejoin the actor loop.
  $A2B8,$03 Call #R$A317.
  $A2BB,$05 Write #N$01 to #R$5E68.
  $A2C0,$03 Call #R$A2F5.
  $A2C3,$03 Call #R$B3A3.
  $A2C6,$03 Call #R$8BA5.
  $A2C9,$03 Call #R$9356.
  $A2CC,$03 Jump to #R$81E1.

c $A2CF Finish Teleport
@ $A2CF label=FinishTeleport
D $A2CF Finish the teleport by bursting debris at Jetman's new position and
. clearing #R$5E68.
  $A2CF,$03 Fetch #R$607C.
  $A2D2,$02 Subtract #N$0C.
  $A2D4,$03 Write it to #R$5E6A.
  $A2D7,$03 Call #R$A253.
N $A2DA Animate the burst, then save the particle positions to the template.
  $A2DA,$03 Call #R$AA9B.
  $A2DD,$03 Call #R$AB2F.
N $A2E0 Restore the template over the particles and animate it twice more.
  $A2E0,$04 Write #N$00 to #R$5E7B.
  $A2E4,$03 Call #R$AB9D.
  $A2E7,$03 Call #R$AB48.
  $A2EA,$03 Call #R$AB9D.
  $A2ED,$03 Call #R$AB48.
  $A2F0,$04 Write #N$00 to #R$5E68.
  $A2F4,$01 Return.

c $A2F5 Clear Sprite Caches
@ $A2F5 label=ClearSpriteCaches
D $A2F5 Write #N$00 over the cached sprite bytes (*#REGix+#N$09 to
. *#REGix+#N$0F) of each of the #N$18 actor slots, so that every actor is
. redrawn from scratch and no stale image is XORed off the redrawn screen.
. Bytes #N$00-#N$08 are the actor itself and bytes #N$10-#N$17 are state
. specific to its type, so they are left alone.
N $A2F5 Start at byte #N$09 of the first slot, #R$6000(#N$6009).
  $A2F5,$03 #REGhl=#R$6000(#N$6009).
  $A2F8,$03 Set #REGb to #N$07 cache bytes per slot and #REGc to #N$18 slots.
  $A2FB,$03 #REGde=#N($0011,$04,$04).
N $A2FE Clear the seven cache bytes of each slot in turn.
@ $A2FE label=ClearSpriteCaches_Loop
  $A2FE,$01 Stash #REGbc on the stack.
@ $A2FF label=ClearSpriteCaches_WriteByte
  $A2FF,$02 Write #N$00 to the current cache byte.
  $A301,$01 Move onto the next cache byte.
  $A302,$02 Decrease the inner counter by one and loop back
. to #R$A2FF until this slot is clear.
  $A304,$01 Skip the rest of the slot.
  $A305,$01 Restore #REGbc from the stack.
  $A306,$01 Decrease #REGc by one.
  $A307,$02 Jump back to #R$A2FE until #REGc is zero.
  $A309,$01 Return.

c $A30A Resume Pickup
@ $A30A label=ResumePickup
D $A30A Rejoin the teleport at #R$A232 using world slot 2's position.
N $A30A Teleport using world slot 2's position.
  $A30A,$03 Fetch #R$60C2.
  $A30D,$03 Fetch #R$60C4.
  $A310,$03 Jump to #R$A232.

b $A313 Pickup Colours
@ $A313 label=Pickup_Colours
D $A313 Four colour bytes. #R$A1AA writes one to the
. actor attribute each frame.
B $A313,$01 #COLOUR(#PEEK(#PC)).
L $A313,$01,$04

c $A317 Handler: Reset Laser Beam Slots
@ $A317 label=Handler_ResetLaserBeamSlots
D $A317 Clears the four laser beam slots from #R$6000 by writing #N$00
. to the first byte of each #N$18-byte slot.
N $A317 See #R$9DC6 for the handler which actions "searching" for a free slot.
  $A317,$03 #REGhl=#R$6000.
  $A31A,$03 #REGde=#N($0018,$04,$04).
  $A31D,$02 Set a slot counter in #REGb for #N$04 loops.
@ $A31F label=ResetLaserBeamSlots_Loop
  $A31F,$02 Write #N$00 to *#REGhl.
  $A321,$01 #REGhl=#REGhl+#REGde.
  $A322,$02 Decrease the counter by one and jump back to
. #R$A31F until it is zero.
  $A324,$01 Return.

c $A325 Handler: World Object
@ $A325 label=Handler_WorldObject
D $A325 Route a fuel pod, bomb or pickup through collect, drop and
. action-key tests.
R $A325 IX Actor slot
N $A325 Reset the drop bit unless the action key is held.
  $A325,$05 Jump to #R$A32E if the action key is pressed.
  $A32A,$04 Reset bit 1 of the actor flags.
@ $A32E label=Handler_WorldObject_DispatchFlags
N $A32E Dispatch on carried, attached or free-in-world.
  $A32E,$07 Jump to #R$A3FF if bit 2 of the actor flags is
. set.
  $A335,$07 Jump to #R$A3C1 if bit 0 of the actor flags is
. set.
N $A33C Settle the object on the ground, then attach it if the
. rover is free and in range.
  $A33C,$03 Call #R$A522.
  $A33F,$03 Fetch #R$5EA3.
  $A342,$03 Jump to #R$A34A if the rover is already carrying.
  $A345,$03 Call #R$A4BA.
  $A348,$02 Jump to #R$A39C if the object is in range.
@ $A34A label=Handler_WorldObject_TestAction
N $A34A On action, attach this object if Jetman can collect it.
  $A34A,$06 Jump to #R$A375 if bit 1 of the actor flags is
. set.
  $A350,$03 Call #R$945C.
  $A353,$02 Jump to #R$A375 if the action key is not pressed.
  $A355,$03 Fetch #R$6078.
N $A358 Type #N$11 and above means Jetman is not on
. foot.
  $A358,$04 Jump to #R$A375 if Jetman's type is at least
. #N$11.
  $A35C,$03 Call #R$A4FC.
  $A35F,$02 Jump to #R$A375 if the object is out of range.
N $A361 Mark Jetman as carrying and flag the object as held.
  $A361,$03 #REGhl=#R$6080.
  $A364,$04 Jump to #R$A375 if bit 0 is set.
  $A368,$02 Set bit 0 of #R$6080.
  $A36A,$04 Set bit 0 of the actor flags.
  $A36E,$04 Set bit 1 of the actor flags.
  $A372,$03 Call #R$B8BD.
@ $A375 label=Handler_WorldObject_Loop
  $A375,$03 Jump to #R$ABB4.

c $A378 Release Carried Item
@ $A378 label=ReleaseCarriedItem
D $A378 Clear the carried-item bits, store the throw speed and play
. #R$B8C3.
R $A378 IX Actor slot
N $A378 Clear the carried-item bits and store the throw speed.
  $A378,$04 Reset bit 0 of *#REGix+#N$08.
  $A37C,$04 Set bit 1 of *#REGix+#N$08.
  $A380,$03 #REGhl=#R$6080.
  $A383,$02 Reset bit 0 of *#REGhl.
N $A385 Set the throw speed from Jetman's speed, then play the drop sound.
  $A385,$03 Fetch #R$607D.
  $A388,$08 Divide #REGa by #N$10.
  $A390,$03 Write #REGa to *#REGix+#N$05.
  $A393,$04 Write #N$01 to *#REGix+#N$06.
  $A397,$03 Call #R$B8C3.
  $A39A,$02 Jump to #R$A375.

c $A39C Attach Carried Item
@ $A39C label=AttachCarriedItem
D $A39C Mark the object as carried and set #R$5EA3.
R $A39C IX Actor slot
N $A39C Mark the object as carried and set #R$5EA3.
  $A39C,$04 Set bit 2 of the actor flags.
  $A3A0,$05 Write #N$01 to #R$5EA3.
N $A3A5 Record in the actor flags which way the rover faces.
  $A3A5,$03 Fetch #R$6090.
  $A3A8,$02 Compare it against #N$22.
  $A3AA,$02 #REGa=#N$00.
  $A3AC,$02 Jump to #R$A3B0 if the rover type is below
. #N$22.
  $A3AE,$02 Add #N$08.
N $A3B0 Keep the facing bit from the actor type and merge it into the flags.
@ $A3B0 label=AttachCarriedItem_KeepBit3
  $A3B0,$03 XOR it with the actor type.
  $A3B3,$02,b$01 Keep only bit 3.
  $A3B5,$01 Stash that bit in #REGc.
  $A3B6,$03 Fetch the actor flags.
  $A3B9,$02,b$01 Reset bit 3.
  $A3BB,$01 Merge the rover-facing bit back in.
  $A3BC,$03 Write the flags back.
  $A3BF,$02 Jump to #R$A375.

c $A3C1 Place Carried Item
@ $A3C1 label=PlaceCarriedItem
D $A3C1 On action, snap the object to the ground using the terrain
. under Jetman.
R $A3C1 IX Actor slot
N $A3C1 On action, snap the object to the ground under Jetman.
  $A3C1,$03 Call #R$945C.
  $A3C4,$02 Jump to #R$A3D3 if the action key is not pressed.
  $A3C6,$06 Jump to #R$A3D3 if bit 1 of the actor flags is
. set.
  $A3CC,$03 Call #R$91BB.
  $A3CF,$01 Fetch the first terrain byte under the object.
  $A3D0,$03 Jump to #R$A378 if that cell is not empty.
@ $A3D3 label=PlaceCarriedItem_Facing
N $A3D3 Bit 2 of Jetman's 0-based sprite index is
. facing. Copy that into bit 3 of this object.
  $A3D3,$03 Fetch #R$6078.
  $A3D6,$01 Decrease it to a 0-based sprite index.
  $A3D7,$02,b$01 Keep only the facing bit.
  $A3D9,$02 Jump to #R$A3F9 if Jetman is facing right.
  $A3DB,$04 Reset bit 3 of the actor type.
N $A3DF Place the object at Jetman's X, just below his Y.
@ $A3DF label=PlaceCarriedItem_Loop
  $A3DF,$03 Fetch #R$607A.
  $A3E2,$03 Write the low byte as the object world X.
  $A3E5,$03 Write the high byte.
  $A3E8,$03 Fetch #R$607C.
  $A3EB,$02 Add #N$08.
  $A3ED,$04 Jump to #R$A3F3 if that is still above the
. ground line.
N $A3F1 #N$AF is the ground line.
  $A3F1,$02 #REGa=#N$AF.
@ $A3F3 label=PlaceCarriedItem_WriteY
  $A3F3,$03 Write it as the object Y.
  $A3F6,$03 Jump to #R$A375.
@ $A3F9 label=PlaceCarriedItem_SetBit3
  $A3F9,$04 Set bit 3 of the actor type.
  $A3FD,$02 Jump to #R$A3DF.

c $A3FF Handler: Held Object
@ $A3FF label=Handler_HeldObject
D $A3FF While #R$6090 is a rover frame, test action to let Jetman
. take this object off the rover and clear #R$5EA3.
R $A3FF IX Actor slot
  $A3FF,$03 Fetch #R$6090.
  $A402,$02 Subtract #N$1A.
  $A404,$04 Jump to #R$A45A if that is not a rover frame.
N $A408 Let Jetman take the object off the rover when the action
. key is pressed beside it.
  $A408,$06 Jump to #R$A431 if bit 1 of the actor flags is
. set.
  $A40E,$03 Call #R$945C.
  $A411,$02 Jump to #R$A431 if the action key is not pressed.
  $A413,$03 Call #R$A4FC.
  $A416,$02 Jump to #R$A431 if the object is out of range.
N $A418 Take the object: clear #R$5EA3 and mark Jetman as carrying.
  $A418,$04 Write #N$00 to #R$5EA3.
  $A41C,$03 Fetch #R$6080.
  $A41F,$02,b$01 Set bit 0.
  $A421,$03 Write it back.
N $A424 Mark the object as held by Jetman and play the pickup sound.
  $A424,$03 Fetch the actor flags.
  $A427,$02,b$01 Keep only bits 4-7.
  $A429,$02,b$01 Set bits 0-1.
  $A42B,$03 Write the flags back.
  $A42E,$03 Call #R$B8BD.
@ $A431 label=Handler_HeldObject_Loop
N $A431 Hang the object off the rover.
  $A431,$03 Fetch #R$6090.
  $A434,$04 Jump to #R$A450 if the rover type is below
. #N$22.
  $A438,$03 Set the offset in #REGbc to #N$FFF4 (-#N$0C).
@ $A43B label=Handler_HeldObject_FetchRoverX
  $A43B,$03 Fetch #R$6092.
N $A43E Place the object at the base X plus the offset, above the rover Y, and
. draw it.
@ $A43E label=Handler_HeldObject_WriteX
  $A43E,$01 Add the offset.
  $A43F,$03 Write the low byte as the object world X.
  $A442,$03 Write the high byte.
  $A445,$03 Fetch the rover Y.
  $A448,$02 Subtract #N$16.
  $A44A,$03 Write it as the object Y.
  $A44D,$03 Jump to #R$ABB4.
@ $A450 label=Handler_HeldObject_OnFootOffset
  $A450,$03 Set the offset in #REGbc to #N($0012,$04,$04).
  $A453,$02 Jump to #R$A43B.
@ $A455 label=Handler_HeldObject_AdvanceFrame
  $A455,$03 Call #R$A48D.
  $A458,$02 Jump to #R$A46F.
@ $A45A label=Handler_HeldObject_CycleFromUp
N $A45A Cycle the held-object frame from UP.
  $A45A,$03 Call #R$A579.
  $A45D,$03 Fetch #R$5E42.
  $A460,$02,b$01 Keep only bit 0.
  $A462,$02 Jump to #R$A46F if this is an odd frame.
  $A464,$03 Call #R$8F90.
  $A467,$01 Stash the controls in #REGd.
  $A468,$04 Jump to #R$A455 if UP is pressed.
  $A46C,$03 Call #R$A4A0.
@ $A46F label=Handler_HeldObject_PickOffset
N $A46F Type #N$16 and above is seated facing right;
. hang the object on the left.
  $A46F,$03 Fetch #R$6078.
  $A472,$04 Jump to #R$A483 if Jetman's type is less than
. #N$16.
  $A476,$02 #REGa=#N$08.
  $A478,$03 Call #R$A4AA.
  $A47B,$03 Set the offset in #REGbc to #N$FFF4 (-#N$0C).
@ $A47E label=Handler_HeldObject_FetchJetmanX
  $A47E,$03 Fetch #R$607A.
  $A481,$02 Jump to #R$A43E.
N $A483 Hang the object on the right when the type is below #N$16.
@ $A483 label=Handler_HeldObject_ClearBit3
  $A483,$02 #REGa=#N$00.
  $A485,$03 Call #R$A4AA.
  $A488,$03 Set the offset in #REGbc to #N($0012,$04,$04).
  $A48B,$02 Jump to #R$A47E.
@ $A48D label=Handler_HeldObject_NextFrame
N $A48D Advance the low three bits of the actor type.
  $A48D,$03 Fetch the actor type.
  $A490,$01 Stash it in #REGc.
  $A491,$02,b$01 Keep only bits 0-2.
  $A493,$03 Return if those bits are already #N$07.
  $A496,$01 Increase the frame by one.
N $A497 Write the new frame back into the low three bits of the type.
@ $A497 label=Handler_HeldObject_MergeType
  $A497,$01 Stash the new frame in #REGb.
  $A498,$01 Copy the original type into #REGa.
  $A499,$02,b$01 Keep only bits 3-7.
  $A49B,$01 Merge the new frame back in.
  $A49C,$03 Write it to the actor type.
  $A49F,$01 Return.
@ $A4A0 label=Handler_HeldObject_PreviousFrame
N $A4A0 Step the low three bits of the actor type back.
  $A4A0,$03 Fetch the actor type.
  $A4A3,$01 Stash it in #REGc.
  $A4A4,$02,b$01 Keep only bits 0-2.
  $A4A6,$01 Return if the frame is already zero.
  $A4A7,$01 Decrease the frame by one.
  $A4A8,$02 Jump to #R$A497.
@ $A4AA label=Handler_HeldObject_CopyFlagBit
N $A4AA XOR #REGa with the actor flags and write bit 3 of the
. result to bit 3 of the actor type.
  $A4AA,$03 XOR #REGa with the actor flags.
  $A4AD,$02,b$01 Keep only bit 3.
  $A4AF,$01 Stash that bit in #REGc.
  $A4B0,$03 Fetch the actor type.
  $A4B3,$02,b$01 Reset bit 3.
  $A4B5,$01 Merge the flag bit back in.
  $A4B6,$03 Write it to the actor type.
  $A4B9,$01 Return.

c $A4BA Compare Actor Distance
@ $A4BA label=CompareActorDistance
D $A4BA Return carry if this actor is close enough to the rover
. to collect.
R $A4BA IX Actor slot
R $A4BA O:F Carry if this actor is in range
N $A4BA Return carry if this actor is close enough to the rover.
  $A4BA,$03 Fetch the actor world X.
  $A4BD,$03 Fetch the high byte.
  $A4C0,$03 Multiply it by #N$08.
  $A4C3,$02 Copy it into #REGbc.
N $A4C5 Work out the horizontal distance between the rover and
. the actor.
  $A4C5,$03 Fetch #R$6092.
  $A4C8,$03 Multiply it by #N$08.
  $A4CB,$01 Clear the carry flag.
  $A4CC,$02 Subtract the actor world X.
N $A4CE Make the difference positive.
  $A4CE,$01 Fetch the high byte of the difference.
  $A4CF,$04 Jump to #R$A4D6 if the result is positive.
  $A4D3,$03 Call #R$8947.
N $A4D6 Return if the actor is outside the collect range.
@ $A4D6 label=CompareActorDistance_TestRange
  $A4D6,$03 Set the collect range in #REGbc to #N($00C0,$04,$04).
  $A4D9,$01 Clear the carry flag.
  $A4DA,$02 Subtract the collect range.
  $A4DC,$01 Return if the actor is too far away.
N $A4DD Compare the rover's height against the actor's Y.
  $A4DD,$03 Fetch the rover Y.
  $A4E0,$01 Decrease it by one.
  $A4E1,$03 Subtract the actor Y.
  $A4E4,$02 Compare it against #N$16.
  $A4E6,$01 Return.

c $A4E7 Test Jetman Action
@ $A4E7 label=TestJetmanAction
D $A4E7 Return whether Jetman can collect, using his type and the
. action key.
R $A4E7 IX Actor slot
N $A4E7 Return unless Jetman can collect and action is pressed.
. Type #N$11 and above means Jetman is not on foot.
  $A4E7,$03 Fetch #R$6078.
  $A4EA,$03 Return if Jetman's type is at least #N$11.
  $A4ED,$03 Call #R$945C.
  $A4F0,$01 Return if the action key is not pressed.
  $A4F1,$03 Fetch #R$6080.
  $A4F4,$02,b$01 Keep only bit 0.
  $A4F6,$01 Return if Jetman is already carrying.
  $A4F7,$05 Return if bit 7 of the actor flags is set.
@ $A4FC label=TestJetmanAction_ComparePosition
N $A4FC Compare this actor against #R$607A and #R$607C.
  $A4FC,$03 Fetch the actor world X.
  $A4FF,$03 Fetch the high byte.
  $A502,$04 Add an #N$08 offset.
N $A506 Return unless Jetman is horizontally close to the actor.
  $A506,$04 Fetch #R$607A.
  $A50A,$01 Clear the carry flag.
  $A50B,$02 Subtract Jetman's world X.
  $A50D,$01 Fetch the high byte of the difference.
  $A50E,$02,b$01 Keep only bits 0-4.
  $A510,$01 Return if the actor is on a different screen.
  $A511,$01 Fetch the low byte.
  $A512,$03 Return if it is at least #N$10.
N $A515 Test whether Jetman is vertically within reach of the actor.
  $A515,$03 Fetch #R$607C.
  $A518,$02 Subtract #N$08.
  $A51A,$03 Subtract the actor Y.
  $A51D,$02 Negate the difference.
  $A51F,$02 Compare it against #N$18.
  $A521,$01 Return.

c $A522 Clamp Object To Ground
@ $A522 label=ClampObjectToGround
D $A522 Tick the object timer and stop it at Y=#N$AF.
R $A522 IX Actor slot
N $A522 Tick the object timer and clamp Y to the ground line.
  $A522,$03 Call #R$B89A.
  $A525,$03 Call #R$B6AE.
  $A528,$04 Jump to #R$A536 if the object is still above the
. ground line.
  $A52C,$08 Write #N$00 to the thrust and the speed.
  $A534,$02 #REGa=#N$AF.
@ $A536 label=ClampObjectToGround_WriteY
  $A536,$03 Write it as the object Y.
  $A539,$01 Return.

c $A53A Spawn Linked Object
@ $A53A label=SpawnLinkedObject
D $A53A If the next actor slot is free, write type #N$C8 into it
. and copy a speed and thrust pair from #R$A68B.
R $A53A IX Actor slot
N $A53A Write type #N$C8 into the next slot if it is free.
  $A53A,$03 Copy the slot pointer into #REGhl (using the
. stack).
  $A53D,$03 #REGde=#N($0018,$04,$04).
  $A540,$01 Move onto the next slot.
  $A541,$03 Return if that slot is already in use.
  $A544,$02 Write type #N$C8.
  $A546,$02 Move onto the new world X.
  $A548,$01 Switch the destination into #REGde.
N $A549 Select a speed and thrust pair from #R$A68B for the new slot.
  $A549,$03 Fetch #R$5E42.
  $A54C,$01 Stash it in #REGc.
  $A54D,$03 Fetch #R$5E40.
  $A550,$01 Add the timer.
  $A551,$03 Write it back to #R$5E40.
N $A554 Use bits 2-5 of the timer to index the table.
  $A554,$03 Fetch #R$5E40.
  $A557,$02,b$01 Keep only bits 2-5.
  $A559,$03 Create an offset in #REGbc.
  $A55C,$03 #REGhl=#R$A68B.
  $A55F,$01 Add the offset.
  $A560,$02 Skip the X and Y offsets to reach the speed in the table.
N $A562 Place the new object beside and above this one.
  $A562,$03 Fetch the actor world X.
  $A565,$02 Add #N$08.
  $A567,$01 Write it as the new world X.
N $A568 Carry the addition into the high byte of the new world X.
  $A568,$01 Move onto the high byte.
  $A569,$03 Fetch the actor world X high byte.
  $A56C,$02 Add the carry.
  $A56E,$02,b$01 Keep only bits 0-4.
  $A570,$01 Write the high byte.
N $A571 Put the new Y #N$10 above the actor Y.
  $A571,$01 Move onto the new Y.
  $A572,$03 Fetch the actor Y.
  $A575,$02 Subtract #N$10.
  $A577,$02 Jump to #R$A5C8.

c $A579 Handler: Player Shot
@ $A579 label=Handler_PlayerShot
D $A579 On a 1-in-4 frame, spawn a shot into a free laser slot
. when FIRE is held, then fly any live shots.
R $A579 IX Actor slot
  $A579,$03 Fetch #R$5E42.
  $A57C,$02,b$01 Keep only bits 0-1.
  $A57E,$01 Return if this is not a 4th frame.
  $A57F,$03 Call #R$8F90.
  $A582,$03 Return if FIRE is not pressed.
N $A585 Look for a free laser slot.
  $A585,$03 #REGhl=#R$6000.
  $A588,$03 #REGde=#N($0018,$04,$04).
  $A58B,$02 Set a slot counter in #REGb for #N$02 loops.
@ $A58D label=Handler_PlayerShot_Loop
  $A58D,$04 Jump to #R$A595 if this slot is free.
  $A591,$01 Move onto the next slot.
  $A592,$02 Decrease the slot counter by one and loop back
. to #R$A58D until both slots have been tried.
  $A594,$01 Return.
@ $A595 label=Handler_PlayerShot_Initialise
N $A595 Initialise a new shot from the current actor.
  $A595,$01 Stash the free slot on the stack.
  $A596,$03 Call #R$B960.
  $A599,$01 Restore the free slot from the stack.
  $A59A,$02 Write type #N$58.
  $A59C,$02 Move onto the new world X.
  $A59E,$01 Switch the destination into #REGde.
N $A59F Look up this actor's entry in the shot table at #R$A68B.
  $A59F,$03 Fetch the actor type.
  $A5A2,$02 Rotate it left twice.
  $A5A4,$02,b$01 Keep only bits 2-5.
  $A5A6,$03 Create an offset in #REGbc.
  $A5A9,$03 #REGhl=#R$A68B.
  $A5AC,$01 Add the offset.
N $A5AD Add the table X offset to the actor world X.
  $A5AD,$01 Fetch the X offset.
  $A5AE,$02 Clear #REGb.
  $A5B0,$04 Jump to #R$A5B5 if the offset is positive.
  $A5B4,$01 Sign-extend into #REGb.
@ $A5B5 label=Handler_PlayerShot_AddWorldX
  $A5B5,$03 Add the actor world X.
  $A5B8,$01 Move onto the next table byte.
  $A5B9,$01 Write the new world X.
  $A5BA,$01 Move onto the high byte.
N $A5BB Work out the high byte of the new world X and the new Y.
  $A5BB,$03 Fetch the actor world X high byte.
  $A5BE,$01 Add the sign.
  $A5BF,$02,b$01 Keep only bits 0-4.
  $A5C1,$01 Write the high byte.
  $A5C2,$01 Move onto the new Y.
  $A5C3,$03 Fetch the actor Y.
  $A5C6,$01 Add the table Y offset.
  $A5C7,$01 Move onto the next table byte.
@ $A5C8 label=Handler_PlayerShot_WriteFields
N $A5C8 Write the remaining shot fields and clear the rest
. of the slot.
  $A5C8,$01 Write the new Y.
  $A5C9,$01 Move onto the speed.
  $A5CA,$02 Copy the next table byte.
  $A5CC,$02 Write it and move on.
  $A5CE,$02 Copy the next table byte.
  $A5D0,$02 Write it and move on.
N $A5D2 Pick the shot colour from the timer at #R$5E40.
  $A5D2,$03 Fetch #R$5E40.
  $A5D5,$02,b$01 Keep only bits 0-1.
  $A5D7,$03 Point #REGbc at the shot colour table at #R$A5EF.
  $A5DA,$01 Add the colour index.
  $A5DB,$01 Copy the low byte into #REGc.
  $A5DC,$01 Fetch the high byte.
  $A5DD,$02 Add the carry.
  $A5DF,$01 Write it back to #REGb.
  $A5E0,$01 Fetch the colour.
  $A5E1,$01 Write it to the shot colour.
  $A5E2,$01 Move onto the next field.
  $A5E3,$02 #REGa=#N$20.
  $A5E5,$01 Write it.
  $A5E6,$01 Move on.
N $A5E7 Clear the remaining #N$0F bytes of the slot.
  $A5E7,$02 Set a byte counter in #REGb for #N$0F loops.
  $A5E9,$01 Clear #REGa.
@ $A5EA label=Handler_PlayerShot_ClearTail
  $A5EA,$01 Write #N$00.
  $A5EB,$01 Move onto the next byte.
  $A5EC,$02 Decrease the byte counter by one and loop back
. to #R$A5EA until the slot tail is clear.
  $A5EE,$01 Return.
N $A5EF The four colours a player shot can be.
@ $A5EF label=Handler_PlayerShot_Colours
B $A5EF,$01 #COLOUR(#PEEK(#PC)).
L $A5EF,$01,$04
@ $A5F3 label=Handler_PlayerShot_AdvanceX
N $A5F3 Advance the shot world X from the packed nibble
. at *#REGix+#N$10.
  $A5F3,$03 Add the X nibble.
  $A5F6,$01 Stash the sum in #REGc.
  $A5F7,$02,b$01 Keep only bits 0-3.
  $A5F9,$03 Write it back as the X nibble.
  $A5FC,$01 Copy the sum into #REGa.
  $A5FD,$04 Rotate the high nibble down into bits 0-3.
  $A601,$02,b$01 Keep only bits 0-3.
  $A603,$02 Clear #REGb.
  $A605,$02 Jump to #R$A63E.
@ $A607 label=Handler_PlayerShot_AdvanceY
N $A607 Advance the shot Y from the packed nibble at
. *#REGix+#N$11.
  $A607,$03 Add the Y nibble.
  $A60A,$01 Stash the sum in #REGc.
  $A60B,$02,b$01 Keep only bits 0-3.
  $A60D,$03 Write it back as the Y nibble.
  $A610,$01 Copy the sum into #REGa.
  $A611,$04 Rotate the high nibble down into bits 0-3.
  $A615,$02,b$01 Keep only bits 0-3.
  $A617,$02 Jump to #R$A66A.
@ $A619 label=Handler_PlayerShot_Fly
N $A619 Count down the shot timer and work out the X step from
. the shot speed.
  $A619,$03 Decrease the shot timer by one.
  $A61C,$03 Jump to #R$A73C if it has expired.
  $A61F,$03 Fetch the shot speed.
  $A622,$04 Jump to #R$A5F3 if the speed is positive.
N $A626 Work out a negative X step when the speed is negative.
  $A626,$03 Add the X nibble.
  $A629,$01 Stash the sum in #REGc.
  $A62A,$02,b$01 Keep only bits 0-3.
  $A62C,$02 Negate it.
  $A62E,$03 Write it back as the X nibble.
  $A631,$01 Copy the sum into #REGa.
  $A632,$02 Negate it.
  $A634,$04 Rotate the high nibble down into bits 0-3.
  $A638,$02,b$01 Keep only bits 0-3.
  $A63A,$02 Negate it.
  $A63C,$02 #REGb=#N$FF.
N $A63E Add the X step to the shot's world X.
@ $A63E label=Handler_PlayerShot_WriteX
  $A63E,$03 Add the step to the world X.
  $A641,$03 Write it back.
  $A644,$03 Fetch the high byte.
  $A647,$01 Add the sign.
  $A648,$02,b$01 Keep only bits 0-4.
  $A64A,$03 Write the high byte back.
N $A64D Work out the Y step from the shot thrust.
  $A64D,$03 Fetch the shot thrust.
  $A650,$04 Jump to #R$A607 if the thrust is positive.
N $A654 Work out a negative Y step when the thrust is negative.
  $A654,$03 Add the Y nibble.
  $A657,$01 Stash the sum in #REGc.
  $A658,$02,b$01 Keep only bits 0-3.
  $A65A,$02 Negate it.
  $A65C,$03 Write it back as the Y nibble.
  $A65F,$01 Copy the sum into #REGa.
  $A660,$02 Negate it.
  $A662,$04 Rotate the high nibble down into bits 0-3.
  $A666,$02,b$01 Keep only bits 0-3.
  $A668,$02 Negate it.
@ $A66A label=Handler_PlayerShot_WriteY
  $A66A,$03 Add the step to the shot Y.
N $A66D Destroy the shot if it hits the ground or leaves the
. play area.
  $A66D,$02 Compare it against #N$AF.
  $A66F,$03 Jump to #R$A73C if the shot is on the ground.
  $A672,$02 Compare it against #N$30.
  $A674,$03 Jump to #R$A73C if the shot is above the play
. area.
N $A677 Store the new Y, flip the shot frame and draw the shot.
  $A677,$03 Write the new Y.
  $A67A,$03 Fetch the shot type.
  $A67D,$02,b$01 Flip bit 0.
  $A67F,$03 Write it back.
  $A682,$03 Call #R$8B73.
  $A685,$03 Call #R$8733.
  $A688,$03 Jump to #R$A6CB.
@ $A68B label=Handler_PlayerShot_Table
B $A68B,$40 Shot table. Each #N$04-byte entry holds an X offset, a Y
. offset, a speed and a thrust.
@ $A6CB label=Handler_PlayerShot_TestSlots
N $A6CB Test the shot against the alien and object slots.
  $A6CB,$02 #REGa=#N$18.
  $A6CD,$03 Write it over the hit-height compare at
. #R$A701(#N$A726).
  $A6D0,$03 #REGhl=#R$61B0.
  $A6D3,$03 #REGde=#N($0018,$04,$04).
  $A6D6,$02 Set a slot counter in #REGb for #N$06 loops.
  $A6D8,$03 Call #R$A6F2.
N $A6DB Test the object slot at #R$6108 with a hit height of #N$0C.
  $A6DB,$02 #REGa=#N$0C.
  $A6DD,$03 Write it over the hit-height compare at
. #R$A701(#N$A726).
  $A6E0,$03 #REGhl=#R$6108.
  $A6E3,$02 Set a slot counter in #REGb for #N$01 loop.
  $A6E5,$03 Call #R$A6F2.
N $A6E8 Test the object slot at #R$6138 with a hit height of #N$18.
  $A6E8,$02 #REGa=#N$18.
  $A6EA,$03 Write it over the hit-height compare at
. #R$A701(#N$A726).
  $A6ED,$03 #REGhl=#R$6138.
  $A6F0,$02 Set a slot counter in #REGb for #N$01 loop.
N $A6F2 Test every slot in this group that is in use.
@ $A6F2 label=Handler_PlayerShot_ScanSlot
  $A6F2,$01 Fetch the slot type.
  $A6F3,$01 Test it.
  $A6F4,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $A6F7,$03 Call #R$A701 if the slot is in use.
  $A6FA,$03 Restore #REGhl, #REGde and #REGbc from the
. stack.
  $A6FD,$01 Move onto the next slot.
  $A6FE,$02 Decrease the slot counter by one and loop back
. to #R$A6F2 until every slot has been tested.
  $A700,$01 Return.
@ $A701 label=Handler_PlayerShot_CompareBox
N $A701 Compare this slot's box against the shot.
  $A701,$02 Move onto the slot world X.
  $A703,$01 Switch the slot pointer into #REGde.
  $A704,$01 Fetch the world X.
  $A705,$01 Move onto the high byte.
  $A706,$01 Copy the low byte into #REGc.
  $A707,$01 Fetch the high byte.
  $A708,$01 Move onto the Y.
  $A709,$01 Copy the high byte into #REGb.
  $A70A,$03 #REGhl=#N($0008,$04,$04).
  $A70D,$01 Add the box offset.
N $A70E Check the shot is horizontally within reach of the slot.
  $A70E,$03 Fetch the shot world X.
  $A711,$03 Fetch the shot world X high byte.
  $A714,$01 Clear the carry flag.
  $A715,$02 Subtract the shot world X.
  $A717,$01 Fetch the high byte of the difference.
  $A718,$02,b$01 Keep only bits 0-4.
  $A71A,$01 Return if they are on different screens.
  $A71B,$01 Fetch the low byte.
  $A71C,$03 Return if it is at least #N$10.
N $A71F Check the shot is vertically within reach of the slot.
  $A71F,$01 Fetch the slot Y.
  $A720,$02 Add #N$04.
  $A722,$03 Subtract the shot Y.
  $A725,$02 Compare it against the current hit height.
  $A727,$01 Return if the shot missed.
N $A728 Set the slot's explode flag, clear the shot and stop
. testing.
  $A728,$01 Switch the slot pointer into #REGhl.
  $A729,$04 Point #REGhl at the explode flag.
  $A72D,$02 Set bit 0 of the explode flag.
  $A72F,$03 Call #R$8AE8.
  $A732,$04 Write #N$00 to the shot type.
  $A736,$05 Discard the stacked return addresses and saved registers.
  $A73B,$01 Return.

c $A73C Start Small Explosion
@ $A73C label=StartSmallExplosion
D $A73C Turn the actor into the first frame of a small explosion (type
. #N$64) and pick its colour. #R$A742 animates it from there.
E $A73C View the equivalent code in;
. #LIST
. { #JETPAC$68B1 }
. { #PSSST$65F7 }
. LIST#
R $A73C IX Actor slot
N $A73C "#SPRITENAME$64".
  $A73C,$04 Write #N$64 to *#REGix+#N$00.
  $A740,$02 Jump to #R$A772.

c $A742 Handler: Small Explosion
@ $A742 label=Handler_SmallExplosion
D $A742 Step a small explosion through its frames (types #N$64 to #N$66),
. then clear the slot once it reaches type #N$67.
R $A742 IX Actor slot
N $A742 Draw the current explosion frame and step the type.
  $A742,$03 Call #R$8B73.
  $A745,$03 Call #R$8733.
  $A748,$03 Increment the actor type by one.
  $A74B,$01 Return.
@ $A74C label=Handler_SmallExplosion_PlaySound
N $A74C Play the explosion sound, then clear the slot.
  $A74C,$03 Fetch *#REGix+#N$0A.
  $A74F,$03 Jump to #R$A755 if it is zero.
  $A752,$03 Call #R$B8FF.
@ $A755 label=Handler_SmallExplosion_ClearType
  $A755,$03 Call #R$8AE8.
  $A758,$04 Write #N$00 to the actor type.
  $A75C,$01 Return.

c $A75D Start Crater
@ $A75D label=StartCrater
D $A75D Set up the explosion burst, then turn the actor into the first
. crater frame (type #N$C0) and pick its colour.
R $A75D IX Actor slot
  $A75D,$03 Call #R$B973.
N $A760 "#SPRITENAME$C0".
  $A760,$04 Write #N$C0 to *#REGix+#N$00.
  $A764,$02 Jump to #R$A772.

c $A766 Start Explosion
@ $A766 label=StartExplosion
D $A766 If the actor's explode flag is set, switch to sprite #N$5C
. and pick a fragment colour.
E $A766 View the equivalent code in;
. #LIST
. { #JETPAC$689F }
. LIST#
R $A766 IX Actor slot
N $A766 Switch to sprite #N$5C when the explode flag is set.
  $A766,$05 Return if bit 0 of *#REGix+#N$10 is not set.
@ $A76B label=StartExplosion_SetSprite
N $A76B "#SPRITENAME$5C".
  $A76B,$04 *#REGix+#N$00=#N$5C.
  $A76F,$03 Call #R$B9A1.
@ $A772 label=StartExplosion_PickOffset
N $A772 Pick a fragment colour from #R$5E40.
  $A772,$03 Fetch #R$5E40.
  $A775,$02,b$01 Keep only bits 0-1.
  $A777,$03 Create an offset in #REGbc.
  $A77A,$04 #REGhl=#R$A792+offset.
  $A77E,$01 Fetch the colour.
  $A77F,$03 Write it to the actor colour.
  $A782,$01 Return.

c $A783 Handler: Sparkle Burst
@ $A783 label=Handler_SparkleBurst
D $A783 Step a sparkle burst through its frames (types #N$5C to #N$62), drawing
. each one, then clear the slot once it reaches type #N$63.
R $A783 IX Actor slot
N $A783 Draw the actor and step its type.
  $A783,$03 Call #R$ABB4.
  $A786,$03 Increment the actor type by one.
  $A789,$01 Return.
@ $A78A label=Handler_SparkleBurst_Clear
N $A78A Clear the actor's sprite and free its slot.
  $A78A,$03 Call #R$8640.
  $A78D,$04 Write #N$00 to the actor type.
  $A791,$01 Return.

b $A792 Fragment Colours
@ $A792 label=FragmentColours
D $A792 The four attributes #R$A772 picks from, using bits 0-1 of #R$5E40,
. to colour explosion fragments.
B $A792,$01 #COLOUR(#PEEK(#PC)).
L $A792,$01,$04

c $A796 Test Laser Hits
@ $A796 label=TestLaserHits
D $A796 Walk the alien and object slots and test each one for a
. laser hit.
N $A796 Test the six alien slots, then object slots #N$01 and #N$03.
  $A796,$03 #REGhl=#R$61B0.
  $A799,$03 #REGde=#N($0018,$04,$04).
  $A79C,$02 Set a slot counter in #REGb for #N$06 loops.
  $A79E,$03 Call #R$A7CB.
N $A7A1 Test object slots #N$01 and #N$03 in turn.
  $A7A1,$03 #REGhl=#R$6108.
  $A7A4,$02 Set a slot counter in #REGb for #N$01 loop.
  $A7A6,$03 Call #R$A7CB.
  $A7A9,$03 #REGhl=#R$6138.
  $A7AC,$02 Set a slot counter in #REGb for #N$01 loop.
  $A7AE,$03 Call #R$A7CB.
N $A7B1 Test slots #N$02 and #N$04 when their type is #N$C8-#N$CB.
  $A7B1,$03 #REGhl=#R$6120.
  $A7B4,$01 Fetch the slot type.
  $A7B5,$02 Subtract #N$C8.
  $A7B7,$04 Jump to #R$A7C0 if that is at least #N$04.
  $A7BB,$02 Set a slot counter in #REGb for #N$01 loop.
  $A7BD,$03 Call #R$A7CB.
N $A7C0 Test object slot #N$04 the same way.
@ $A7C0 label=TestLaserHits_Slot4
  $A7C0,$03 #REGhl=#R$6150.
  $A7C3,$01 Fetch the slot type.
  $A7C4,$02 Subtract #N$C8.
  $A7C6,$03 Return if that is at least #N$04.
  $A7C9,$02 Set a slot counter in #REGb for #N$01 loop.
@ $A7CB label=TestLaserHits_Loop
N $A7CB Compare this slot against the current laser pulse.
  $A7CB,$01 Fetch the slot type.
  $A7CC,$03 Jump to #R$A7DE if the slot is free.
  $A7CF,$06 Jump to #R$A7DE if bit 2 of pulse #N$01 is
. reset.
  $A7D5,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $A7D8,$03 Call #R$A7E2.
  $A7DB,$03 Restore #REGhl, #REGde and #REGbc from the stack.
@ $A7DE label=TestLaserHits_NextSlot
  $A7DE,$01 #REGhl+=#REGde.
  $A7DF,$02 Decrease the counter by one and jump back to
. #R$A7CB until it is zero.
  $A7E1,$01 Return.

c $A7E2 Test One Hit
@ $A7E2 label=TestOneHit
D $A7E2 Compare one actor's box against the current laser pulse.
R $A7E2 HL Actor slot
N $A7E2 Build the actor hit-box from its world X and Y.
  $A7E2,$02 Move onto the actor world X.
  $A7E4,$01 Switch the actor pointer into #REGde.
  $A7E5,$01 Fetch the world X.
  $A7E6,$01 Move onto the high byte.
  $A7E7,$01 Copy the low byte into #REGc.
  $A7E8,$01 Fetch the high byte.
  $A7E9,$01 Move onto the Y.
  $A7EA,$01 Copy the high byte into #REGb.
  $A7EB,$03 #REGhl=#N($0090,$04,$04).
  $A7EE,$01 Add the box offset.
N $A7EF Compare that box against the current laser pulse.
  $A7EF,$04 Fetch #R$607A.
  $A7F3,$01 Copy the low byte into #REGa.
  $A7F4,$03 Add pulse #N$01.
  $A7F7,$01 Copy the sum into #REGc.
  $A7F8,$01 Copy the high byte into #REGa.
  $A7F9,$02 Add the carry.
  $A7FB,$01 Copy it into #REGb.
  $A7FC,$01 Clear the carry flag.
  $A7FD,$02 Subtract the pulse world X.
N $A7FF Return if the pulse is outside the hit-box
. horizontally.
  $A7FF,$01 Fetch the high byte of the difference.
  $A800,$02,b$01 Keep only bits 0-4.
  $A802,$01 Return if they are on different screens.
  $A803,$01 Fetch the low byte.
  $A804,$03 Return if it is at least #N$20.
N $A807 Return if the pulse misses the actor vertically.
  $A807,$01 Fetch the actor Y.
  $A808,$02 Add #N$04.
  $A80A,$03 Subtract the beam Y.
  $A80D,$03 Return if the pulse missed.
N $A810 Mark the actor as exploding and consume the pulse.
  $A810,$01 Switch the actor pointer into #REGhl.
  $A811,$04 Point #REGhl at the explode flag.
  $A815,$02 Set bit 0 of the explode flag.
  $A817,$04 Reset bit 2 of pulse #N$01.
  $A81B,$01 Return.

c $A81C Handler: Player Shot Launch
@ $A81C label=Handler_PlayerShotLaunch
D $A81C Draw a newly fired shot for its first two frames (types #N$58 and
. #N$59), stepping the type on each time. At type #N$5A the shot is
. handled by #R$A619, which flies it.
R $A81C IX Actor slot
  $A81C,$03 Call #R$8B73.
  $A81F,$03 Call #R$8733.
  $A822,$03 Increment the actor type by one.
  $A825,$01 Return.

c $A826 Initialise New Level
@ $A826 label=LevelNew
D $A826 Awards an extra life, then rebuilds the level by resetting the
. aliens, Jetman, the window and the sprite caches.
E $A826 View the equivalent code in;
. #LIST
. { #JETPAC$60A9 }
. { #PSSST$5F80 }
. LIST#
N $A826 #PUSHS #UDGTABLE { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SIM(start=$81BB,stop=$81D6,sp=$5E00)
. #SCR$02(new-level) }
. { #SCR$01,$01,$16,$1E,$02(terrain-strip) } UDGTABLE# #POPS
N $A826 Award an extra life, then rebuild the level.
  $A826,$04 Increase the lives counter #R$5EA1 by one.
@ $A82A label=LevelInitialisation
N $A82A Reset aliens, Jetman, the window and the sprite caches.
  $A82A,$03 Call #R$B385.
  $A82D,$03 Call #R$9020.
  $A830,$03 Call #R$84D8.
N $A833 Clear the sprite caches and the laser beam slots.
  $A833,$03 Call #R$A2F5.
  $A836,$03 Call #R$A317.
N $A839 Redraw the lives, terrain and HUD panel, then drop the world
. objects.
  $A839,$03 Call #R$894F.
  $A83C,$03 Call #R$9356.
  $A83F,$03 Call #R$8BBB.
  $A842,$03 Call #R$B2F9.
N $A845 Store the current frame counter as the last frame.
  $A845,$03 #REGa=#SKOOLKID$5C78(FRAMES).
  $A848,$03 Write #REGa to #R$5E53.
  $A84B,$01 Return.

c $A84C Initialise New Game
@ $A84C label=NewGame
D $A84C Sets the starting level and lives for both players. The loop
. runs twice, clearing the level parity and carrying flag, initialising
. the terrain and then swapping the player states using #R$A880. The
. 2UP starting lives and level are written afterwards.
E $A84C View the equivalent code in;
. #LIST
. { #COOKIE$6C58 }
. { #TRANZAM$6391 }
. LIST#
N $A84C Write the starting level and lives for both players.
  $A84C,$02 Set a player counter in #REGb for #N$02 loops.
@ $A84E label=NewGame_Loop
  $A84E,$01 Stash the counter in #REGbc on the stack.
N $A84F Handle setting up 1UP player.
  $A84F,$05 Write 1UP starting level to #R$5EA0.
N $A854 See #POKE(255_lives,255 Lives).
  $A854,$05 Write 1UP starting lives to #R$5EA1.
  $A859,$07 Write #N$00 to; #LIST { #R$5EA2 } { #R$5EA3 } LIST#
  $A860,$03 Call #R$B3DC.
  $A863,$03 Call #R$9F5E.
  $A866,$03 Call #R$A880.
  $A869,$01 Restore #REGbc from the stack.
  $A86A,$02 Decrease the counter by one and jump back to
. #R$A84E until it is zero.
N $A86C Handle setting up 2UP player.
N $A86C See #POKE(255_lives,255 Lives).
  $A86C,$05 Write 2UP starting lives to #R$5EA5.
  $A871,$05 Write 2UP starting level to #R$5EA4.
  $A876,$03 #REGa=*#R$5E00.
  $A879,$02,b$01 Keep only bit 0.
  $A87B,$01 Return if #R$5E00 indicates this is a 2UP game.
  $A87C,$03 Write #N$00 to #R$5EA5 as there is no 2UP player.
  $A87F,$01 Return.

c $A880 1UP/ 2UP Swapper
@ $A880 label=ChangePlayer
D $A880 Swaps the active and inactive player data. Exchanges the four
. player-state bytes at #R$5EA0 and #R$5EA4, #N$0400 bytes of terrain
. between #R$7000 and #R$7400, and #N$0120 bytes of actor slots between
. #R$6090 and #R$6240.
E $A880 View the equivalent code in;
. #LIST
. { #COOKIE$6416 }
. { #JETPAC$616A }
. { #PSSST$613B }
. { #SABREWULF$B235 }
. LIST#
N $A880 This routine "swaps" the data between #REGde and #REGhl.
N $A880 These are all the player states.
  $A880,$03 #REGhl=#R$5EA0.
  $A883,$03 #REGde=#R$5EA4.
  $A886,$02 Set a byte counter in #REGb for #N$04 loops.
N $A888 Exchange the four player-state bytes at #R$5EA0
. with the inactive copy at #R$5EA4.
@ $A888 label=ChangePlayer_States
  $A888,$01 #REGa=*#REGde.
  $A889,$01 #REGc=*#REGhl.
  $A88A,$03 Swap the bytes at *#REGhl and *#REGde.
  $A88D,$01 Increment #REGhl by one.
  $A88E,$01 Increment #REGde by one.
  $A88F,$02 Decrease the counter by one and jump back to
. #R$A888 until it is zero.
N $A891 This is the current terrain buffer data.
  $A891,$03 #REGhl=#R$7000.
  $A894,$03 #REGde=#R$7400.
  $A897,$03 Set the byte count in #REGbc to #N$0400.
  $A89A,$03 Call #R$A8A6.
N $A89D And this is the active sprites.
  $A89D,$03 #REGhl=#R$6090.
  $A8A0,$03 #REGde=#R$6240.
  $A8A3,$03 Set the byte count in #REGbc to #N$0120.
N $A8A6 Exchange the bytes at #REGhl and #REGde for
. #REGbc counts.
@ $A8A6 label=ChangePlayer_Loop
  $A8A6,$01 Stash #REGbc on the stack.
  $A8A7,$01 #REGa=*#REGde.
  $A8A8,$01 #REGc=*#REGhl.
  $A8A9,$03 Swap the bytes at *#REGhl and *#REGde.
  $A8AC,$01 Increment #REGhl by one.
  $A8AD,$01 Increment #REGde by one.
  $A8AE,$01 Restore #REGbc from the stack.
  $A8AF,$01 Decrease #REGbc by one.
  $A8B0,$04 Jump back to #R$A8A6 until #REGbc is zero.
  $A8B4,$01 Return.

c $A8B5 Lose Life
@ $A8B5 label=LoseLife
D $A8B5 Spend a life for the active player. In a 2UP game, swap to
. the other player when they still have lives left.
N $A8B5 1UP path.
  $A8B5,$03 #REGa=*#R$5E00.
  $A8B8,$02,b$01 Keep only bit 0.
  $A8BA,$02 Jump to #R$A8C5 if this is a 2UP game.
@ $A8BC label=LoseLife_Loop
  $A8BC,$06 Jump to #R$A939 if #R$5EA1 is zero.
  $A8C2,$03 Jump to #R$A82A.
@ $A8C5 label=LoseLife_2UP
N $A8C5 2UP path.
  $A8C5,$06 Jump to #R$A8BC if #R$5EA5 is zero.
  $A8CB,$07 Call #R$A931 if #R$5EA1 is zero.
  $A8D2,$03 Call #R$A880.
  $A8D5,$04 Write #N$00 to #R$5E6C.
  $A8D9,$07 Flip #R$5E65 to the other player.
  $A8E0,$03 Jump to #R$A82A.

c $A8E3 Game Over
@ $A8E3 label=GameOver_1UP_Messaging
D $A8E3 Prints the "GAME OVER PLAYER X" message for the player who has
. lost their last life. If the lunar rover was destroyed, it also prints
. "YOUR LUNAR ROVER HAS BEEN DESTROYED." and "ALL IS LOST." before
. pausing.
E $A8E3 View the equivalent code in;
. #LIST
. { #ATICATAC$8C35 }
. { #COOKIE$6BE0 }
. { #PSSST$60FD }
. { #SABREWULF$AA6A }
. { #TRANZAM$6353 }
. LIST#
N $A8E3 #HTML(Set up altering the "#FONTaddr=$D347,attr=$47,chars=0(GAME OVER PLAYER 0)(game-over-0up)" message for 1UP.)
  $A8E3,c,$02 #REGa="1" + #N$80 (bit 7 marks the last character).
N $A8E5 Print the altered messaging and pause to show it for a period of time.
@ $A8E5 label=GameOver_Write
  $A8E5,$03 Write ASCII player number to #R$A94B(#N$A95D).
  $A8E8,$03 Call #R$84D8.
N $A8EB Handle printing "#FONTaddr=$D347,attr=$47,chars=0(GAME OVER PLAYER X)(game-over)" messaging.
  $A8EB,$03 #REGde=#R$A94B.
  $A8EE,$03 #REGhl=#N$7038 (screen location).
  $A8F1,$03 Call #R$8A11.
  $A8F4,$03 #REGde=#R$B9D2.
  $A8F7,$03 Call #R$B9BC.
N $A8FA Set a lower delay period for the following test.
  $A8FA,$02 Set a delay counter in #REGb for #N$04 loops.
  $A8FC,$05 #REGa=*#R$6090-#N$1A.
  $A901,$04 If the lunar rover was not destroyed, jump straight to #R$A922.
N $A905 Handle printing "#FONTaddr=$D347,attr=$45,chars=0(YOUR LUNAR ROVER HAS BEEN)(lunar-rover)" messaging.
  $A905,$03 #REGde=#R$A95E.
  $A908,$03 #REGhl=#N$3818 (screen location).
  $A90B,$03 Call #R$8A11.
N $A90E Handle printing "#FONTaddr=$D347,attr=$45,chars=0(DESTROYED.)(destroyed)" messaging.
  $A90E,$03 #REGde=#R$A979.
  $A911,$03 #REGhl=#N$4858 (screen location).
  $A914,$03 Call #R$8A11.
N $A917 Handle printing "#FONTaddr=$D347,attr=$45,chars=0(ALL IS LOST.)(all-lost)" messaging.
  $A917,$03 #REGde=#R$A985.
  $A91A,$03 #REGhl=#N$5850 (screen location).
  $A91D,$03 Call #R$8A11.
N $A920 Provide a pause for us to reflect that the game has now ended.
  $A920,$02 Set a delay counter in #REGb for #N$08 loops.
@ $A922 label=GameOverDelay
  $A922,$03 #REGhl=#N($0000,$04,$04).
N $A925 Decrementing #N($0000,$04,$04) by one gives
. #N($FFFF), so the inner loop runs a full 16-bit
. count.
@ $A925 label=GameOverDelay_Loop
  $A925,$01 Decrease #REGhl by one.
  $A926,$04 Jump back to #R$A925 until #REGhl is zero.
  $A92A,$02 Decrease the counter by one and jump back to
. #R$A925 until it is zero.
  $A92C,$01 Return.
N $A92D #HTML(Set up altering the "#FONTaddr=$D347,attr=$47,chars=0(GAME OVER PLAYER 0)(game-over-0up)" message for 2UP.)
@ $A92D label=GameOver_2UP_Messaging
  $A92D,c,$02 #REGa="2" + #N$80 (bit 7 marks the last character).
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
N $A94B #FONTaddr=$D347,attr=$47,chars=0(GAME OVER PLAYER X)(game-over)
@ $A94B label=String_GameOver
  $A94B,$13,h$01,$11:$01 Attribute: #COLOUR(#PEEK(#PC)) + "GAME OVER PLAYER X".
N $A95E #FONTaddr=$D347,attr=$45,chars=0(YOUR LUNAR ROVER HAS BEEN)(lunar-rover)
@ $A95E label=String_Lunar_Rover
  $A95E,$1B,h$01,$19:$01 Attribute: #COLOUR(#PEEK(#PC)) + "YOUR LUNAR ROVER HAS BEEN".
N $A979 #FONTaddr=$D347,attr=$45,chars=0(DESTROYED.)(destroyed)
@ $A979 label=String_Destroyed
  $A979,$0C,h$01,$0A:$01 Attribute: #COLOUR(#PEEK(#PC)) + "DESTROYED.".
N $A985 #FONTaddr=$D347,attr=$45,chars=0(ALL IS LOST.)(all-lost)
@ $A985 label=String_All_Lost
  $A985,$0E,h$01,$0C:$01 Attribute: #COLOUR(#PEEK(#PC)) + "ALL IS LOST.".

c $A993 Move Debris Particle
@ $A993 label=MoveDebrisParticle
D $A993 Add the particle velocity and discard it if it leaves the
. play area.
R $A993 IX Particle
N $A993 Add the particle velocity to its X/Y position.
  $A993,$03 Fetch the particle X.
  $A996,$03 Add the X velocity.
  $A999,$01 Copy the new X into #REGl.
  $A99A,$03 Fetch the particle Y.
  $A99D,$03 Add the Y velocity.
  $A9A0,$01 Copy the new Y into #REGh.
@ $A9A1 label=MoveDebrisParticle_TestX
N $A9A1 Discard the particle if it has left the play area.
  $A9A1,$01 Fetch the new X.
  $A9A2,$03 Return if it is less than #N$08.
  $A9A5,$03 Return if it is at least #N$F8.
  $A9A8,$01 Fetch the new Y.
  $A9A9,$03 Return if it is less than #N$30.
  $A9AC,$03 Return if it is at least #N$A8.
N $A9AF Write the new position and count a live particle.
  $A9AF,$03 Write the new X.
  $A9B2,$03 Write the new Y.
  $A9B5,$03 Fetch #R$5E69.
  $A9B8,$01 Increase it by one.
  $A9B9,$03 Write it back.
N $A9BC Colour the attribute square under the particle.
  $A9BC,$03 #REGbc=#N$0202.
  $A9BF,$01 Stash the particle position on the stack.
  $A9C0,$01 Switch to the shadow registers.
  $A9C1,$01 Restore the particle position from the stack.
  $A9C2,$02 Copy it into #REGhl'.
  $A9C4,$03 Call #R$8506.
N $A9C7 Colour the square with the particle colour unless its attribute
. is zero.
  $A9C7,$01 Fetch the attribute byte.
  $A9C8,$03 Jump to #R$A9CF if it is already zero.
  $A9CB,$03 Fetch the particle colour.
  $A9CE,$01 Write it to the attribute square.
@ $A9CF label=MoveDebrisParticle_ScreenAddress
N $A9CF XOR the particle pixels onto the screen.
  $A9CF,$01 Switch back to the main registers.
  $A9D0,$03 Call #R$851E.
@ $A9D3 label=MoveDebrisParticle_Loop
  $A9D3,$02 Stash the counters and the screen address on the
. stack.
  $A9D5,$03 Fetch the particle X.
@ $A9D8 label=MoveDebrisParticle_PixelIndex
  $A9D8,$02,b$01 Keep only bits 0-2.
  $A9DA,$01 Copy the pixel index into #REGe.
N $A9DB Look up the pixel mask for this column and XOR it
. onto the screen.
  $A9DB,$01 Stash #REGa in #REGaf'.
  $A9DC,$01 Copy the pixel index into #REGa.
  $A9DD,$03 #REGde=#R$AA13.
  $A9E0,$01 Add the pixel index.
  $A9E1,$01 Copy the low byte into #REGe.
  $A9E2,$01 Fetch the high byte.
  $A9E3,$02 Add the carry.
  $A9E5,$01 Write it back to #REGd.
  $A9E6,$01 Fetch the pixel mask.
  $A9E7,$01 Invert the screen byte.
  $A9E8,$01 Write it back.
  $A9E9,$01 Restore #REGa from #REGaf'.
N $A9EA Advance the pixel index, moving to the next screen
. and attribute column at a byte boundary.
  $A9EA,$01 Increase the pixel index by one.
  $A9EB,$02,b$01 Keep only bits 0-2.
  $A9ED,$02 Jump to #R$AA10 if the byte boundary was not
. crossed.
  $A9EF,$01 Move onto the next screen column.
  $A9F0,$01 Switch to the shadow registers.
  $A9F1,$01 Increase the attribute column by one.
N $A9F2 Colour this column's attribute square the same way.
@ $A9F2 label=MoveDebrisParticle_Attribute
  $A9F2,$02 Copy the attribute address into #REGhl'.
  $A9F4,$01 Stash #REGa in #REGaf'.
  $A9F5,$03 Call #R$8506.
  $A9F8,$01 Fetch the attribute byte.
  $A9F9,$03 Jump to #R$AA00 if it is already zero.
  $A9FC,$03 Fetch the particle colour.
  $A9FF,$01 Write it to the attribute square.
@ $AA00 label=MoveDebrisParticle_NextColumn
N $AA00 Step to the next column or up one pixel row.
  $AA00,$01 Switch back to the main registers.
  $AA01,$01 Restore #REGa from #REGaf'.
  $AA02,$02 Decrease the column counter by one and loop
. back to #R$A9D8 until the pair is drawn.
N $AA04 Move up one pixel row and repeat until every row is drawn.
  $AA04,$01 Restore the screen address from the stack.
  $AA05,$03 Call #R$85F6.
  $AA08,$01 Switch to the shadow registers.
  $AA09,$01 Move the shadow copy of the particle Y up by one pixel.
  $AA0A,$01 Switch back to the main registers.
  $AA0B,$01 Restore the counters from the stack.
  $AA0C,$01 Decrease the row counter by one.
  $AA0D,$02 Jump back to #R$A9D3 if any rows remain.
  $AA0F,$01 Return.
@ $AA10 label=MoveDebrisParticle_NextRow
  $AA10,$01 Switch to the shadow registers.
  $AA11,$02 Jump to #R$A9F2.
@ $AA13 label=MoveDebrisParticle_Masks
B $AA13,$38 Pixel masks, then debris velocity and colour triples.
@ $AA27 label=MoveDebrisParticle_Table

g $AA4B Debris Particles
@ $AA4B label=Debris_Particles
D $AA4B Sixteen 5-byte particle records used by #R$AA9B.
B $AA4B,$50,$05

c $AA9B Animate Debris
@ $AA9B label=AnimateDebris
D $AA9B Move the #N$10 explosion particles at #R$AA4B until
. #R$5E69 returns to zero.
N $AA9B Walk all #N$10 debris particles until none remain.
  $AA9B,$04 Write #N$00 to #R$5E69.
  $AA9F,$04 #REGix=#R$AA4B.
  $AAA3,$02 Set a particle counter in #REGb for #N$10 loops.
N $AAA5 Move each particle in turn.
@ $AAA5 label=AnimateDebris_Loop
  $AAA5,$01 Stash the particle counter on the stack.
  $AAA6,$03 Call #R$AAB8.
  $AAA9,$03 Set the step to the next particle in #REGbc to #N($0005,$04,$04).
  $AAAC,$02 Move onto the next particle.
  $AAAE,$01 Restore the particle counter from the stack.
  $AAAF,$02 Decrease the particle counter by one and loop
. back to #R$AAA5 until all #N$10 have moved.
N $AAB1 Repeat the pass until no particles remain on screen.
  $AAB1,$03 Fetch #R$5E69.
  $AAB4,$03 Jump back to #R$AA9B if any particles remain.
  $AAB7,$01 Return.
@ $AAB8 label=AnimateDebris_AddVelocity
N $AAB8 Add this particle's velocity and keep it on-screen.
  $AAB8,$03 Fetch the particle X.
  $AABB,$03 Add the X velocity.
  $AABE,$01 Copy the new X into #REGl.
  $AABF,$03 Fetch the particle Y.
  $AAC2,$03 Add the Y velocity.
  $AAC5,$01 Copy the new Y into #REGh.
N $AAC6 Return unless the new position is inside the play area.
  $AAC6,$01 Fetch the new X.
  $AAC7,$03 Return if it is less than #N$08.
  $AACA,$03 Return if it is at least #N$F8.
  $AACD,$01 Fetch the new Y.
  $AACE,$03 Return if it is less than #N$30.
  $AAD1,$03 Return if it is at least #N$A8.
N $AAD4 Keep the new position and count this particle as still moving.
  $AAD4,$03 Write the new X.
  $AAD7,$03 Write the new Y.
  $AADA,$03 #REGhl=#R$5E69.
  $AADD,$01 Increase #R$5E69 by one.
  $AADE,$01 Return.

b $AADF Debris Defaults
@ $AADF label=Debris_Defaults
D $AADF Template copied to #R$AA4B by #R$AB9D. #R$AB2F saves the
. particle X and Y positions here.
B $AADF,$50,$05

c $AB2F Initialise Debris
@ $AB2F label=InitialiseDebris
D $AB2F Save the X and Y of the #N$10 debris particles at #R$AA4B
. into the template at #R$AADF.
N $AB2F Copy the X and Y of each particle into the template.
  $AB2F,$03 #REGhl=#R$AA4B.
  $AB32,$03 #REGde=#R$AADF.
  $AB35,$02 Set a particle counter in #REGb for #N$10 loops.
@ $AB37 label=InitialiseDebris_Loop
  $AB37,$02 Copy the particle X.
  $AB39,$02 Write it and move on.
  $AB3B,$02 Copy the particle Y.
  $AB3D,$02 Write it and move on.
N $AB3F Skip the velocity and colour bytes of both records.
  $AB3F,$03 Skip the rest of this particle record.
  $AB42,$03 Skip the rest of this template record.
  $AB45,$02 Decrease the particle counter by one and loop
. back to #R$AB37 until all #N$10 are copied.
  $AB47,$01 Return.

c $AB48 Animate Debris Burst
@ $AB48 label=AnimateDebrisBurst
D $AB48 Play the explosion tick and move the #N$10 debris particles.
N $AB48 Tick the explosion pitch and walk the debris particles.
  $AB48,$04 Write #N$00 to #R$5E69.
  $AB4C,$03 Fetch #R$5E7B.
  $AB4F,$01 Increase it by one.
  $AB50,$03 Write it back.
  $AB53,$03 Call #R$B8F2.
  $AB56,$04 #REGix=#R$AA4B.
  $AB5A,$02 Set a particle counter in #REGb for #N$10 loops.
@ $AB5C label=AnimateDebrisBurst_Loop
N $AB5C Move one particle, then loop until all #N$10 have moved.
  $AB5C,$01 Stash the particle counter on the stack.
  $AB5D,$03 Call #R$AB78.
  $AB60,$03 Set the step to the next particle in #REGbc to #N($0005,$04,$04).
  $AB63,$02 Move onto the next particle.
  $AB65,$01 Restore the particle counter from the stack.
  $AB66,$02 Decrease the particle counter by one and loop
. back to #R$AB5C until all #N$10 have moved.
N $AB68 Repeat the whole pass while any particle is still moving.
  $AB68,$03 Fetch #R$5E69.
  $AB6B,$03 Jump back to #R$AB48 if any particles remain.
  $AB6E,$01 Return.
N $AB6F Return if this parked particle's Y matches #R$5E6A.
. Otherwise move it.
@ $AB6F label=AnimateDebrisBurst_CompareY
  $AB6F,$03 Fetch #R$5E6A.
  $AB72,$04 Return if it matches this particle Y.
  $AB76,$02 Jump to #R$AB7F.
@ $AB78 label=AnimateDebrisBurst_TestParkedX
  $AB78,$03 Fetch the particle X.
  $AB7B,$04 Jump to #R$AB6F if it is #N$80.
N $AB7F Add the velocity to the particle position.
@ $AB7F label=AnimateDebrisBurst_AddX
  $AB7F,$03 Fetch the particle X.
  $AB82,$03 Add the X velocity.
  $AB85,$01 Copy the new X into #REGl.
  $AB86,$03 Fetch the particle Y.
  $AB89,$03 Add the Y velocity.
  $AB8C,$01 Copy the new Y into #REGh.
N $AB8D Return if the new X is #N$80 and the new Y matches #R$5E6A.
. Otherwise jump to #R$A9A1.
  $AB8D,$01 Fetch the new X.
  $AB8E,$04 Jump to #R$AB95 if it is #N$80.
  $AB92,$03 Jump to #R$A9A1.
@ $AB95 label=AnimateDebrisBurst_CompareNewY
  $AB95,$03 Fetch #R$5E6A.
  $AB98,$02 Return if it matches the new Y.
  $AB9A,$03 Jump to #R$A9A1.

c $AB9D Copy Debris Template
@ $AB9D label=CopyDebrisTemplate
D $AB9D Copy #N$50 bytes from #R$AADF into #R$AA4B.
  $AB9D,$0B Copy #N$50 bytes from #R$AADF to #R$AA4B.
  $ABA8,$01 Return.

c $ABA9 Draw Current Actor
@ $ABA9 label=DrawCurrentActor
D $ABA9 Step the actor type through frames #N$70-#N$7F and draw it
. through #R$8701.
R $ABA9 IX Actor slot
N $ABA9 Step the actor type through frames #N$70-#N($7F), then draw.
  $ABA9,$03 Fetch the actor type.
  $ABAC,$01 Increase it by one.
  $ABAD,$02,b$01 Keep only bits 0-3.
N $ABAF Sprite IDs begin at #R$D987(#N$70) (#SPRITENAME$70).
  $ABAF,$02 Add #N$70.
  $ABB1,$03 Write it back.
@ $ABB4 label=DrawCurrentActor_Draw
  $ABB4,$03 Call #R$8701.
  $ABB7,$03 Jump to #R$8733.

c $ABBA Handler: Missile Launcher
@ $ABBA label=Handler_MissileLauncher
D $ABBA Handle the missile launcher (types #N$70 to #N$7F). Kill Jetman if
. he is in range, then while *#REGix+#N$17 is set step the frame, count it
. down, draw its gauge and flash the base or alien banner. Otherwise
. continue at #R$AC3E.
R $ABBA IX Actor slot
N $ABBA Test range, then draw the missile banner when
. *#REGix+#N$17 is set.
  $ABBA,$02 #REGe=#N$18.
  $ABBC,$03 Call #R$B2A4.
  $ABBF,$03 Call #R$B2D7 if this actor is close enough.
  $ABC2,$06 Jump to #R$AC3E if *#REGix+#N$17 is zero.
  $ABC8,$03 Call #R$ABA9.
N $ABCB Count down *#REGix+#N$17 every sixteenth frame,
. unless the countdown is suspended.
  $ABCB,$03 Fetch #R$5E42.
  $ABCE,$01 Invert the bits.
  $ABCF,$02,b$01 Keep only bits 0-3.
  $ABD1,$01 Return if the result is not zero.
  $ABD2,$06 Jump to #R$ABE5 if #R$5E67 is not zero.
  $ABD8,$03 Fetch #R$6078.
  $ABDB,$02 Compare it against #N$81.
@ $ABDD label=Handler_MissileLauncher_TestType
N $ABDD See #POKE(infinite_time,Infinite Time).
  $ABDD,$02 Jump to #R$ABE5 if Jetman's type is #N$81.
  $ABDF,$03 Decrease *#REGix+#N$17 by one.
  $ABE2,$03 Call #R$B16F if it is now zero.
N $ABE5 Draw the gauge for *#REGix+#N$17.
@ $ABE5 label=Handler_MissileLauncher_Gauge
  $ABE5,$03 Fetch *#REGix+#N$17.
  $ABE8,$03 #REGhl=#N$2040.
  $ABEB,$03 Call #R$8C01.
N $ABEE Flash one of the banner tiles, chosen by which side
. of Jetman the actor is on.
  $ABEE,$03 Call #R$AD36.
  $ABF1,$02 Jump to #R$AC29 if the actor is not to the left of Jetman.
N $ABF3 The actor is to the left, so flash the first tile (#N$587B) and set
. the second tile (#N$587D) to a steady colour.
  $ABF3,$03 Call #R$AD0B to fetch the flashing attribute.
  $ABF6,$03 Point #REGhl at the first banner tile (#N$587B).
  $ABF9,$03 Call #R$AD00 to colour the tile with #REGa.
  $ABFC,$03 Point #REGhl at the second banner tile (#N$587D).
  $ABFF,$02 Set the steady attribute in #REGa to #COLOUR$42.
@ $AC01 label=Handler_MissileLauncher_Loop
  $AC01,$03 Call #R$AD00 to colour the tile with #REGa.
N $AC04 Print the base or alien banner message at fixed
. points in the timer, otherwise return.
  $AC04,$03 Fetch #R$5E42.
  $AC07,$02,b$01 Keep only bits 0-5.
  $AC09,$02 Compare it against #N$0F.
  $AC0B,$02 Jump to #R$AC1A if they are equal.
  $AC0D,$03 Return if it is not #N$2F.
N $AC10 Handle printing the "#FONTaddr=$D347,attr=$45,chars=0(ghij)(alien)" messaging.
  $AC10,$03 #REGde=#R$AC24.
@ $AC13 label=BannerMessaging_Print
  $AC13,$03 #REGhl=#N$10D8 (screen location).
  $AC16,$03 Call #R$8A11.
  $AC19,$01 Return.
@ $AC1A label=Handler_MissileLauncher_PrintBase
N $AC1A Handle printing the "#FONTaddr=$D347,attr=$45,chars=0(cdef)(base)" messaging.
  $AC1A,$03 #REGde=#R$AC1F.
  $AC1D,$02 Jump to #R$AC13.
@ $AC1F label=BannerMessaging_Base
T $AC1F,$05,$04:01 Attribute: #COLOUR(#PEEK(#PC)) + "#FONTaddr=$D347,attr=$45,chars=0(cdef)(base)".
@ $AC24 label=BannerMessaging_Alien
T $AC24,$05,$04:01 Attribute: #COLOUR(#PEEK(#PC)) + "#FONTaddr=$D347,attr=$45,chars=0(ghij)(alien)".
N $AC29 The actor is not to the left, so flash the second tile (#N$587D) and
. set the first tile (#N$587B) to a steady colour.
@ $AC29 label=Handler_MissileLauncher_FlashBanner
  $AC29,$03 Call #R$AD0B to fetch the flashing attribute.
  $AC2C,$03 Point #REGhl at the second banner tile (#N$587D).
  $AC2F,$03 Call #R$AD00 to colour the tile with #REGa.
  $AC32,$03 Point #REGhl at the first banner tile (#N$587B).
  $AC35,$02 Set the steady attribute in #REGa to #COLOUR$42.
  $AC37,$02 Jump to #R$AC01 to colour the tile with #REGa.

c $AC39 Align To Rover
@ $AC39 label=AlignToRover
D $AC39 Use the rover position when the rover is in play, otherwise
. Jetman's, then convert types #N$70 and #N$78 into the linked slots
. at #R$6138.
R $AC39 IX Actor slot
N $AC39 Start from the scroll X.
  $AC39,$03 #REGhl=*#R$607A.
  $AC3C,$02 Jump to #R$AC4A.
@ $AC3E label=AlignToRover_TestRoverY
N $AC3E Prefer the rover X when its type is in the
. #N$10 rover frames #N$1A-#N$29.
  $AC3E,$03 #REGa=*#R$6090.
  $AC41,$02 Subtract #N$1A.
  $AC43,$02 Compare it with #N$10.
  $AC45,$02 Jump to #R$AC39 if that is not a rover frame.
  $AC47,$03 #REGhl=*#R$6092.
@ $AC4A label=AlignToRover_TestType
N $AC4A Test whether this actor is in range of that X, then its type.
  $AC4A,$03 Call #R$AD39.
  $AC4D,$03 #REGa=*#REGix+#N$00.
  $AC50,$02 Jump to #R$AC59 if carry is set.
  $AC52,$02 Compare #REGa with #N$78.
  $AC54,$02 Jump to #R$AC60 if they are equal.
  $AC56,$03 Jump to #R$ABA9.
@ $AC59 label=AlignToRover_Type70
N $AC59 Type #N$70 copies #R$ACA0.
  $AC59,$02 Compare #REGa with #N$70.
  $AC5B,$02 Jump to #R$AC6F if they are equal.
  $AC5D,$03 Jump to #R$ABA9.
@ $AC60 label=AlignToRover_Type78
N $AC60 Type #N$78 copies #R$ACD0 and becomes #N$98.
  $AC60,$03 Call #R$ABB4.
  $AC63,$03 Call #R$B1D3.
  $AC66,$01 Return if any object slot is in use.
  $AC67,$03 Call #R$AC7E.
  $AC6A,$04 Write #N$98 to *#REGix+#N$00.
  $AC6E,$01 Return.
@ $AC6F label=AlignToRover_ConvertLauncher
N $AC6F Type #N$70 becomes #N$9C.
  $AC6F,$03 Call #R$ABB4.
  $AC72,$03 Call #R$B1D3.
  $AC75,$01 Return if any object slot is in use.
  $AC76,$03 Call #R$AC83.
  $AC79,$04 Write #N$9C to *#REGix+#N$00.
  $AC7D,$01 Return.
@ $AC7E label=AlignToRover_CopyTarget2
N $AC7E Copy #N$30 bytes into #R$6138.
  $AC7E,$03 #REGhl=#R$ACD0.
  $AC81,$02 Jump to #R$AC86.
@ $AC83 label=AlignToRover_CopyTarget
  $AC83,$03 #REGhl=#R$ACA0.
@ $AC86 label=AlignToRover_CopyToSlot
  $AC86,$03 #REGde=#R$6138.
  $AC89,$05 Copy #N$30 bytes from #REGhl to #REGde.
N $AC8E Place the slot at this actor's world X and #N$10 above its Y.
  $AC8E,$03 #REGl=*#REGix+#N$02.
  $AC91,$03 #REGh=*#REGix+#N$03.
  $AC94,$03 Write #REGhl to #R$613A.
  $AC97,$03 #REGa=*#REGix+#N$04.
  $AC9A,$02 #REGa-=#N$10.
  $AC9C,$03 Write #REGa to #R$613C.
  $AC9F,$01 Return.

@ $ACA0 label=AlignToRover_Target
B $ACA0,$30
@ $ACD0 label=AlignToRover_Target_2
B $ACD0,$30

c $AD00 Handler: Colourise 2x2
@ $AD00 label=Handler_Colour2x2
D $AD00 Write an attribute value to four attribute buffer
. locations.
R $AD00 A The attribute value to write
R $AD00 HL The address in the attribute buffer to begin writing to
  $AD00,$01 Write #REGa to *#REGhl.
N $AD01 Move one byte to the right.
  $AD01,$01 Increment #REGl by one.
  $AD02,$01 Write #REGa to *#REGhl.
N $AD03 Move down one attribute row, less one byte, so the
. write sits under the first location.
  $AD03,$04 #REGhl=#REGhl+#N($001F,$04,$04).
  $AD07,$01 Write #REGa to *#REGhl.
N $AD08 Move one byte to the right.
  $AD08,$01 Increment #REGl by one.
  $AD09,$01 Write #REGa to *#REGhl.
  $AD0A,$01 Return.

c $AD0B Flash Attribute
@ $AD0B label=FlashAttribute
D $AD0B Return attribute #COLOUR$42 or #COLOUR$72 according to bit
. #N$04 of #R$5E42.
R $AD0B O:A Attribute value
N $AD0B Return attribute #COLOUR$42 or #COLOUR$72 from the timer.
  $AD0B,$03 Fetch #R$5E42.
  $AD0E,$02,b$01 Keep only bit 4.
  $AD10,$02 Jump to #R$AD14 if that bit is reset.
  $AD12,$02 #REGa=#N$30.
@ $AD14 label=FlashAttribute_Loop
  $AD14,$02,b$01 Set bits 1 and 6.
  $AD16,$01 Return.

c $AD17 Flash Attribute Alternative
@ $AD17 label=FlashAttributeAlternative
D $AD17 Return attribute #COLOUR$42 or #COLOUR$7A according to bit #N$04 of
. #R$5E42.
R $AD17 O:A Attribute value
  $AD17,$03 Fetch #R$5E42.
  $AD1A,$02,b$01 Keep only bit 4.
  $AD1C,$02 Jump to #R$AD14 if that bit is reset.
  $AD1E,$02 #REGa=#N$38.
  $AD20,$02 Jump to #R$AD14.

c $AD22 Colourise Banner
@ $AD22 label=ColouriseBanner
D $AD22 Flash the rover HUD tiles at #N$5861 and #N$5863.
N $AD22 Flash the rover HUD tiles at #N$5861 and #N$5863.
  $AD22,$03 Call #R$AD0B.
@ $AD25 label=ColouriseBanner_Loop
  $AD25,$03 Point #REGhl at the first HUD tile (#N$5861).
  $AD28,$01 Stash #REGaf on the stack.
  $AD29,$03 Call #R$AD00 to colour the tile with #REGa.
  $AD2C,$01 Restore #REGaf from the stack.
  $AD2D,$03 Point #REGhl at the second HUD tile (#N$5863).
  $AD30,$03 Jump to #R$AD00 to colour the tile with #REGa.

c $AD33 Clear Banner Colour
@ $AD33 label=ClearBannerColour
D $AD33 Write attribute #COLOUR$00 into the rover banner attributes.
  $AD33,$01 #REGa=#N$00.
  $AD34,$02 Jump to #R$AD25.

c $AD36 Test Actor Side
@ $AD36 label=Handler_Missile
D $AD36 Test whether this actor is to the left of Jetman. The world wraps
. at #N$2000 so carry is set when Jetman's world X (#R$607A) is less than
. #N$1000 ahead of the actor.
R $AD36 IX Actor slot
  $AD36,$03 Fetch #R$607A.
@ $AD39 label=Handler_Missile_FetchActorX
  $AD39,$03 Fetch the actor world X.
  $AD3C,$03 Fetch the high byte.
@ $AD3F label=Handler_Missile_CompareWorldX
N $AD3F Return carry if #REGhl is ahead of #REGbc (to its right) by
. less than #N$1000 (allowing for the wrap at #N$2000).
  $AD3F,$01 Clear the carry flag.
  $AD40,$02 Subtract the second world X.
  $AD42,$01 Fetch the high byte of the difference.
  $AD43,$04 Jump to #R$AD4E if the result is negative.
N $AD47 Test a positive difference against the range and return carry.
  $AD47,$03 Set the range in #REGbc to #N$1000.
  $AD4A,$01 Clear the carry flag.
  $AD4B,$02 Subtract the range.
  $AD4D,$01 Return.
N $AD4E Call #R$8947 on a negative difference, then test it against the
. range and invert the carry.
@ $AD4E label=Handler_Missile_NegateThenRange
  $AD4E,$03 Call #R$8947.
  $AD51,$03 Set the range in #REGbc to #N$1000.
  $AD54,$01 Clear the carry flag.
  $AD55,$02 Subtract the range.
  $AD57,$01 Invert the carry flag.
  $AD58,$01 Return.

c $AD59 Handler: Alien Base
@ $AD59 label=Handler_AlienBase
D $AD59 Draw the alien base, then turn it and its launcher into craters
. once #R$5E6C is set or the destroyed flag at #R$6195 is set.
R $AD59 IX Actor slot
N $AD59 Draw the base using the frame that matches its pixel offset.
  $AD59,$02 #REGe=#N$14.
  $AD5B,$03 Call #R$B2A4.
  $AD5E,$03 Call #R$B2D7 if this actor is close enough.
N $AD61 Pick the frame for the base's pixel offset and write it as the
. actor type.
  $AD61,$03 Fetch #R$607A.
  $AD64,$03 Subtract the actor world X.
  $AD67,$02 Negate the difference.
  $AD69,$02,b$01 Keep only bits 0-2.
N $AD6B Sprite IDs begin at #R$DF13(#N$68) (#SPRITENAME$68).
  $AD6B,$02 Add #N$68 for the alien base frames.
  $AD6D,$03 Write it to the actor type.
N $AD70 Draw the base and colour its attribute tiles.
  $AD70,$03 Call #R$8787.
  $AD73,$03 Fetch #R$5E58.
  $AD76,$02 Subtract #N$08.
  $AD78,$03 Write it back.
  $AD7B,$03 Call #R$8733.
N $AD7E Return unless the base has been destroyed or
. #R$5E6C is set.
  $AD7E,$03 Fetch #R$5E6C.
  $AD81,$03 Jump to #R$AD89 if it is not zero.
  $AD84,$03 Fetch the destroyed flag at *#REGix+#N$15.
  $AD87,$02 Return if it is zero.
@ $AD89 label=Handler_Missile_HideSlots
N $AD89 Erase the base, turn #R$6168 and #R$6180 into craters (type
. #N$C0), move the base #N$08 left and clear #R$6180(#N$6188).
  $AD89,$03 Call #R$864F.
  $AD8C,$02 #REGa=#N$C0.
  $AD8E,$03 Write it to #R$6168.
  $AD91,$03 Write it to #R$6180.
N $AD94 Move the world X at #R$6182 left by #N$08.
  $AD94,$03 Fetch #R$6182.
  $AD97,$03 Set the offset in #REGbc to #N$FFF8 (-#N$08).
  $AD9A,$03 Call #R$A002.
  $AD9D,$03 Write it back.
N $ADA0 Clear #N$08 bytes of that slot from #R$6180(#N$6188).
  $ADA0,$03 #REGhl=#R$6180(#N$6188).
  $ADA3,$02 Set a byte counter in #REGb for #N$08 loops.
@ $ADA5 label=Handler_Missile_Loop
  $ADA5,$02 Write #N$00 to the current byte.
  $ADA7,$01 Move onto the next byte.
  $ADA8,$02 Decrease the byte counter by one and loop back
. to #R$ADA5 until the tail is clear.
  $ADAA,$01 Return.

c $ADAB Handler: Upward Missile
@ $ADAB label=Handler_UpwardMissile
D $ADAB Fly an upward missile (types #N$80 and #N$84) by its speed and
. thrust. It explodes when it touches Jetman or is shot, or once its Y is
. less than #N$3C.
R $ADAB IX Actor slot
N $ADAB Fly the missile, or explode it on a hit.
  $ADAB,$03 Call #R$B2A2.
  $ADAE,$02 Jump to #R$ADDE if Jetman is in range.
  $ADB0,$06 Jump to #R$ADE1 if bit 0 of the explode flag is
. set.
N $ADB6 Move the missile along by its speed and thrust.
  $ADB6,$03 Fetch the actor world X.
  $ADB9,$03 Fetch the high byte.
  $ADBC,$02 Clear #REGb.
  $ADBE,$03 Fetch the actor speed.
  $ADC1,$01 Copy it into #REGc.
  $ADC2,$04 Jump to #R$ADC7 if the speed is positive.
  $ADC6,$01 Sign-extend into #REGb.
@ $ADC7 label=Handler_Missile_AddSpeed
  $ADC7,$01 Add the speed to the world X.
  $ADC8,$03 Write the low byte back.
  $ADCB,$03 Write the high byte back.
N $ADCE Move the missile along its Y by the thrust.
  $ADCE,$03 Fetch the actor Y.
  $ADD1,$03 Add the thrust.
  $ADD4,$03 Write it back.
N $ADD7 Explode the missile once it has flown above Y
. #N($3C), otherwise draw it.
  $ADD7,$04 Jump to #R$ADE7 if the Y is less than #N$3C.
  $ADDB,$03 Jump to #R$ABB4.
@ $ADDE label=Handler_Missile_HitJetman
  $ADDE,$03 Call #R$B2D7.
@ $ADE1 label=Handler_Missile_AwardPoints
N $ADE1 Destroying the missile adds #N$0500 points.
  $ADE1,$03 Set the points to award in #REGbc to #N$0500.
  $ADE4,$03 Call #R$899C.
@ $ADE7 label=Handler_Missile_Explode
  $ADE7,$03 Jump to #R$A76B.

c $ADEA Handler: Upward Missile Flame
@ $ADEA label=Handler_UpwardMissileFlame
D $ADEA Keep the flame (types #N$82/#N$83 or #N$86/#N$87 via
. #R$AE1D) attached to the missile held in the slot at #R$6138. The
. flame is cleared if that slot no longer holds the missile.
R $ADEA IX Actor slot
N $ADEA Hang this actor off the #N$80 slot at #R$6138.
  $ADEA,$03 Fetch #R$6138.
  $ADED,$04 Jump to #R$AE2F if the type is not #N$80.
  $ADF1,$03 Fetch #R$613A.
  $ADF4,$04 Add a #N$14 offset.
N $ADF8 Place this actor at the missile's position, offset
. for the flame.
@ $ADF8 label=Handler_Missile_MaskWorldX
  $ADF8,$01 Fetch the high byte.
  $ADF9,$02,b$01 Keep only bits 0-4.
  $ADFB,$01 Write it back.
  $ADFC,$03 Write the low byte as the actor world X.
  $ADFF,$03 Write the high byte.
  $AE02,$03 Fetch #R$613C.
  $AE05,$02 Add #N$10.
  $AE07,$03 Write it as the actor Y.
N $AE0A Alternate the flame frame and colour.
  $AE0A,$03 Fetch the actor type.
  $AE0D,$02,b$01 Flip bit 0.
  $AE0F,$03 Write it back.
  $AE12,$03 Fetch the actor colour.
  $AE15,$02,b$01 Flip bit 2.
  $AE17,$03 Write it back.
  $AE1A,$03 Jump to #R$ABB4.
@ $AE1D label=Handler_UpwardMissileFlame_HangLeft
N $AE1D The same hang, offset left, for type #N$84.
  $AE1D,$03 Fetch #R$6138.
  $AE20,$04 Jump to #R$AE2F if the type is not #N$84.
  $AE24,$03 Fetch #R$613A.
  $AE27,$03 Set the offset in #REGbc to #N($0010,$04,$04).
  $AE2A,$01 Clear the carry flag.
  $AE2B,$02 Subtract the offset.
  $AE2D,$02 Jump to #R$ADF8.
@ $AE2F label=Handler_Missile_ClearType
  $AE2F,$03 Call #R$8640.
  $AE32,$04 Write #N$00 to the actor type.
  $AE36,$01 Return.

c $AE37 Handler: Missile Spawner
@ $AE37 label=Handler_MissileSpawner
D $AE37 Draw the actor and step its type through #N$98-#N$9B (every 8th
. frame) or #N$9C-#N$9F (every 4th frame). On reaching #N$9B or #N$9F it
. spawns a sideways missile. Types #N$9B and #N$9F only draw.
R $AE37 IX Actor slot
  $AE37,$03 Jump to #R$ABB4.
@ $AE3A label=Handler_MissileSpawner_AnimateLeft
N $AE3A Animate types #N$98-#N$9B every 8th frame, spawning the left
. missile when the type reaches #N$9B.
  $AE3A,$02 #REGe=#N$18.
  $AE3C,$03 Call #R$B2A4.
  $AE3F,$03 Call #R$B2D7 if this actor is close enough.
  $AE42,$03 Call #R$ABB4.
N $AE45 Return unless this is every eighth frame.
  $AE45,$03 Fetch #R$5E42.
  $AE48,$02,b$01 Keep only bits 0-2.
  $AE4A,$01 Return if the result is not zero.
N $AE4B Step the type, then spawn a missile once it reaches #N$9B.
  $AE4B,$03 Increase the actor type by one.
  $AE4E,$03 Fetch the actor type.
  $AE51,$02,b$01 Keep only bits 0-1.
  $AE53,$05 Call #R$AE78 if those bits are #N$03.
  $AE58,$01 Return.
@ $AE59 label=Handler_MissileSpawner_AnimateRight
N $AE59 Animate types #N$9C-#N$9F every 4th frame, spawning the right
. missile when the type reaches #N$9F.
  $AE59,$02 #REGe=#N$18.
  $AE5B,$03 Call #R$B2A4.
  $AE5E,$03 Call #R$B2D7 if this actor is close enough.
  $AE61,$03 Call #R$ABB4.
N $AE64 Return unless this is every fourth frame.
  $AE64,$03 Fetch #R$5E42.
  $AE67,$02,b$01 Keep only bits 0-1.
  $AE69,$01 Return if the result is not zero.
N $AE6A Step the type, then spawn a missile once it reaches #N$9F.
  $AE6A,$03 Increase the actor type by one.
  $AE6D,$03 Fetch the actor type.
  $AE70,$02,b$01 Keep only bits 0-1.
  $AE72,$05 Call #R$AEB7 if those bits are #N$03.
  $AE77,$01 Return.

c $AE78 Spawn Missile
@ $AE78 label=Handler_Missile_CopyTemplate
D $AE78 Copy the left-facing missile and flame templates at #R$AEBC (or the
. right-facing pair at #R$AEEC, entered at #R$AEB7) into #R$6108 and place
. them at this actor. The hit count is the level plus #N$08 (up to #N$63).
. Then jump to #R$B52E to show the laser estimate, unless #R$6168(#N$6172) is
. non-zero or Jetman's type is #N$2A or above with no lives left.
R $AE78 IX Actor slot
N $AE78 Copy the #N$A0 template into #R$6108.
  $AE78,$03 #REGhl=#R$AEBC.
@ $AE7B label=Handler_Missile_FillObjectSlots
  $AE7B,$03 #REGde=#R$6108.
  $AE7E,$05 Copy the #N$30-byte template into the object slots.
N $AE83 Place the missile at this actor's X, and #N$0C above its Y.
  $AE83,$03 Fetch the actor world X.
  $AE86,$03 Fetch the high byte.
  $AE89,$03 Write it to #R$6108(#N$610A).
  $AE8C,$03 Fetch the actor Y.
  $AE8F,$02 Subtract #N$0C.
  $AE91,$03 Write it to #R$6108(#N$610C).
N $AE94 Set the hit count to the level plus #N($08), up to #N$63.
  $AE94,$03 Fetch #R$5EA0.
  $AE97,$02 Add #N$08.
  $AE99,$04 Jump to #R$AE9F if that is less than #N$63.
  $AE9D,$02 #REGa=#N$63.
@ $AE9F label=Handler_Missile_WriteHitCount
  $AE9F,$03 Write it to #R$6108(#N$611E).
N $AEA2 Decide whether to show the laser estimate at #R$B52E.
  $AEA2,$03 Fetch #R$6168(#N$6172).
  $AEA5,$02 Return if it is not zero.
  $AEA7,$03 Fetch #R$5EA1.
  $AEAA,$04 Jump to #R$B52E if any lives remain.
  $AEAE,$03 Fetch #R$6078.
  $AEB1,$03 Return if Jetman's type is at least #N$2A.
  $AEB4,$03 Jump to #R$B52E.
@ $AEB7 label=Handler_Missile_CopyTemplate2
  $AEB7,$03 #REGhl=#R$AEEC.
  $AEBA,$02 Jump to #R$AE7B.
@ $AEBC label=Missile_Object_Template
B $AEBC,$30
@ $AEEC label=Missile_Object_Template_2
B $AEEC,$30

c $AF1C Handler: Sideways Missile
@ $AF1C label=Handler_SidewaysMissile
D $AF1C Fly a sideways missile (types #N$A0 and #N$A4). Flash the left or
. right warning marker, take laser hits off its hit count, step its X by its
. speed and steer its Y by its distance from the target. It explodes at
. #R$AFE9 on reaching Jetman or the rover.
R $AF1C IX Actor slot
N $AF1C Colour the missile banner and apply hits.
  $AF1C,$03 Call #R$B2A2.
  $AF1F,$03 Jump to #R$AFAE if Jetman is in range.
N $AF22 Flash the banner tile on the side where the missile is.
  $AF22,$03 Call #R$AD36.
  $AF25,$02 Jump to #R$AF35 if the missile is not to the left of Jetman.
N $AF27 The missile is to the left, so flash the first tile (#N$587B) and set
. the second tile (#N$587D) to a steady colour.
  $AF27,$03 Call #R$AD17 to fetch the flashing attribute.
  $AF2A,$03 Point #REGhl at the first banner tile (#N$587B).
  $AF2D,$03 Call #R$AD00 to colour the tile with #REGa.
  $AF30,$03 Point #REGhl at the second banner tile (#N$587D).
  $AF33,$02 Jump to #R$AF41 to set the other tile to a steady colour.
N $AF35 The missile is not to the left, so flash the second tile (#N$587D) and
. set the first tile (#N$587B) to a steady colour.
@ $AF35 label=Handler_Missile_FlashBanner
  $AF35,$03 Call #R$AD17 to fetch the flashing attribute.
  $AF38,$03 Point #REGhl at the second banner tile (#N$587D).
  $AF3B,$03 Call #R$AD00 to colour the tile with #REGa.
  $AF3E,$03 Point #REGhl at the first banner tile (#N$587B).
N $AF41 Set the other banner tile to #COLOUR$42.
@ $AF41 label=Handler_Missile_BannerColour
  $AF41,$02 Set the steady attribute in #REGa to #COLOUR$42.
  $AF43,$03 Call #R$AD00 to colour the tile with #REGa.
N $AF46 Cycle the missile colour on even frames.
  $AF46,$03 Fetch #R$5E42.
  $AF49,$02,b$01 Keep only bit 0.
  $AF4B,$02 Jump to #R$AF61 if this is an odd frame.
  $AF4D,$03 Fetch the actor colour.
  $AF50,$04 Jump to #R$AF61 if it is already #COLOUR$46.
  $AF54,$03 Fetch #R$5E40.
  $AF57,$02,b$01 Keep only bits 0-2.
  $AF59,$03 Jump to #R$AF5C if the result is not zero,
. else force #N$01.
@ $AF5C label=Handler_Missile_WriteBright
  $AF5C,$02,b$01 Set bit 6.
  $AF5E,$03 Write it to the actor colour.
N $AF61 Skip to the movement unless the missile has been hit.
@ $AF61 label=Handler_Missile_TakeHit
  $AF61,$06 Jump to #R$AF7D if bit 0 of the explode flag is
. reset.
N $AF67 Take one hit off the missile hit count.
  $AF67,$03 Decrease *#REGix+#N$16 by one.
@ $AF6A label=Handler_Missile_Target
N $AF6A See #POKE(destroy_missile_with_one_shot,Destroy
. Missile With One Shot).
  $AF6A,$02 Jump to #R$AFB1 if the missile has been destroyed.
  $AF6C,$03 Call #R$B8B4.
N $AF6F Each missile hit adds #N$0100 points.
  $AF6F,$03 Set the points to award in #REGbc to #N$0100.
  $AF72,$03 Call #R$899C.
  $AF75,$04 Write #COLOUR$42 to the actor colour.
  $AF79,$04 Write #N$00 to the explode flag.
@ $AF7D label=Handler_Missile_StepX
N $AF7D Step the missile world X from its speed.
  $AF7D,$03 Fetch the actor world X.
  $AF80,$03 Fetch the high byte.
  $AF83,$03 Fetch the actor speed.
  $AF86,$02 Clear #REGb.
  $AF88,$01 Copy the speed into #REGa.
  $AF89,$04 Jump to #R$AF8E if the speed is positive.
  $AF8D,$01 Sign-extend into #REGb.
@ $AF8E label=Handler_Missile_WriteSteppedX
  $AF8E,$01 Add the speed to the world X.
  $AF8F,$01 Fetch the high byte.
  $AF90,$02,b$01 Keep only bits 0-4.
  $AF92,$01 Write it back.
  $AF93,$03 Write the low byte.
  $AF96,$03 Write the high byte.
N $AF99 Test the target range, then steer the Y from the distance.
  $AF99,$03 Call #R$B0D1.
  $AF9C,$02 Jump to #R$AFE9 if the missile has reached its target.
N $AF9E Pick the Y steering band from the distance left, or just draw.
  $AF9E,$01 Fetch the high byte of the distance left in #REGhl.
  $AF9F,$04 Jump to #R$AFDD if it is less than #N$02.
  $AFA3,$04 Jump to #R$AFD6 if it is less than #N$10.
  $AFA7,$04 Jump to #R$AFC5 if it is less than #N$20.
@ $AFAB label=Handler_Missile_Draw
  $AFAB,$03 Jump to #R$ABB4.
N $AFAE Kill Jetman if he is in range, then destroy the missile.
@ $AFAE label=Handler_Missile_InRange
  $AFAE,$03 Call #R$B2D7.
@ $AFB1 label=Handler_Missile_Destroyed
  $AFB1,$05 Write #N$01 to #R$6195.
N $AFB6 Destroying the missile adds #N$0500 points.
  $AFB6,$03 Set the points to award in #REGbc to #N$0500.
  $AFB9,$03 Call #R$899C.
  $AFBC,$03 Point #REGde at the tune at #R$BAA8.
  $AFBF,$03 Call #R$B9BC.
  $AFC2,$03 Jump to #R$A76B.
@ $AFC5 label=Handler_Missile_SteerY
N $AFC5 Steer the missile Y toward a band from the high byte.
  $AFC5,$03 Fetch the actor Y.
  $AFC8,$02 Compare it against #N$50.
N $AFCA Draw the missile once the Y matches its band, otherwise nudge it.
@ $AFCA label=Handler_Missile_YReached
  $AFCA,$02 Jump to #R$AFAB if they are equal.
  $AFCC,$02 Jump to #R$AFD0 if the Y is already past the
. band.
  $AFCE,$02 Increase the Y by two.
@ $AFD0 label=Handler_Missile_DecreaseY
  $AFD0,$01 Decrease the Y by one.
  $AFD1,$03 Write it back.
  $AFD4,$02 Jump to #R$AFAB.
N $AFD6 In the middle band, steer the Y toward #N$80.
@ $AFD6 label=Handler_Missile_MidBand
  $AFD6,$03 Fetch the actor Y.
  $AFD9,$02 Compare it against #N$80.
  $AFDB,$02 Jump to #R$AFCA.
N $AFDD In the low band, steer the Y toward #N$A7.
@ $AFDD label=Handler_Missile_LowBand
  $AFDD,$03 Fetch the actor Y.
  $AFE0,$02 Compare it against #N$A7.
  $AFE2,$02 Jump to #R$AFAB if they are equal.
  $AFE4,$01 Increase the Y by one.
  $AFE5,$02 Compare it against #N$A7.
  $AFE7,$02 Jump to #R$AFCA.
@ $AFE9 label=Handler_Missile_FreezeWorld
N $AFE9 The missile has reached Jetman or the rover: set #R$5E6C, then
. turn the world slots, the bomb and the aliens into craters and
. explosions.
  $AFE9,$05 Write #N$01 to #R$5E6C.
  $AFEE,$02 #REGa=#N$C0.
  $AFF0,$03 Write it to #R$60D8.
  $AFF3,$03 Write it to #R$60A8.
  $AFF6,$03 Write it to #R$60C0.
N $AFF9 Turn world slot 4 into an explosion if it is in use.
  $AFF9,$03 Fetch #R$60F0.
  $AFFC,$03 Jump to #R$B004 if it is free.
  $AFFF,$05 Write #N$5C to #R$60F0.
N $B004 Turn the bomb into a crater if it is in use.
@ $B004 label=Handler_Missile_HideBomb
  $B004,$03 Fetch #R$6198.
  $B007,$03 Jump to #R$B00F if it is free.
  $B00A,$05 Write #N$C0 to #R$6198.
N $B00F Turn every active alien into an explosion.
@ $B00F label=Handler_Missile_ScanAliens
  $B00F,$03 #REGhl=#R$61B0.
  $B012,$03 #REGde=#N($0018,$04,$04).
  $B015,$02 Set an alien slot counter in #REGb for #N$06 loops.
@ $B017 label=Handler_Missile_TestAlienSlot
  $B017,$01 Fetch the slot type.
  $B018,$03 Jump to #R$B031 if the slot is free.
N $B01B Work out from the slot type how to convert it.
  $B01B,$02,b$01 Reset bit 0.
  $B01D,$04 Jump to #R$B037 if the type is #N$5A.
  $B021,$04 Jump to #R$B037 if the type is #N$B6.
  $B025,$02,b$01 Keep only bits 2-7.
  $B027,$04 Jump to #R$B031 if the type is #N$64.
  $B02B,$04 Jump to #R$B037 if the type is #N$C8.
  $B02F,$02 Write #N$5C to the slot.
N $B031 Move onto the next slot, looping until every alien is done.
@ $B031 label=Handler_Missile_NextAlienSlot
  $B031,$01 Move onto the next slot.
  $B032,$02 Decrease the slot counter by one and loop back
. to #R$B017 until every alien is processed.
  $B034,$03 Jump to #R$A76B.
@ $B037 label=Handler_Missile_ConvertAlien
  $B037,$02 Write #N$64 to the slot.
  $B039,$02 Jump to #R$B031.

c $B03B Convert To Debris
@ $B03B label=Handler_Missile_FallingDebris
D $B03B Turn Jetman, if he is riding the rover, or else the parked rover
. into falling debris (type #N$E0).
N $B03B Convert Jetman or the rover into falling debris.
  $B03B,$03 Fetch #R$6078.
  $B03E,$02 Subtract #N$12.
  $B040,$02 Compare it against #N$08.
  $B042,$03 Set #REGb to the falling debris type #N$E0 and #REGc to #N$04.
. Loading #REGbc keeps the flags from the compare.
  $B045,$02 Jump to #R$B056 if Jetman is riding the rover.
N $B047 When the rover is parked, turn it into falling debris.
  $B047,$01 Copy #N$E0 into #REGa.
  $B048,$03 Write it to #R$6090.
  $B04B,$01 Copy #N$04 into #REGa.
  $B04C,$03 Write it to #R$6090(#N$6098).
  $B04F,$03 #REGde=#R$6092.
  $B052,$03 Call #R$B4C2.
  $B055,$01 Return.
N $B056 When Jetman is on the rover, turn Jetman into falling debris.
@ $B056 label=Handler_Missile_JetmanDebris
  $B056,$01 Copy #N$E0 into #REGa.
  $B057,$03 Write it to #R$6078.
  $B05A,$01 Copy #N$04 into #REGa.
  $B05B,$03 Write it to #R$6080.
  $B05E,$03 #REGde=#R$607A.
  $B061,$03 Call #R$B4C2.
  $B064,$01 Return.

c $B065 Handler: Sideways Missile Flame
@ $B065 label=Handler_SidewaysMissileFlame
D $B065 Keep the flame (types #N$A6/#N$A7 here, #N$A2/#N$A3 via
. #R$B098) attached to the missile held in the slot at #R$6108. The
. flame is cleared if that slot no longer holds the missile.
R $B065 IX Actor slot
N $B065 Hang this actor off the #N$A4 slot at #R$6108.
  $B065,$03 Fetch #R$6108.
  $B068,$04 Jump to #R$B0C9 if the type is not #N$A4.
N $B06C Alternate the flame frame and colour.
  $B06C,$03 Fetch the actor type.
  $B06F,$02,b$01 Flip bit 0.
  $B071,$03 Write it back.
  $B074,$03 Fetch the actor colour.
  $B077,$02,b$01 Flip bit 2.
  $B079,$03 Write it back.
N $B07C Match the flame Y to the missile Y.
  $B07C,$03 Fetch #R$6108(#N$610C).
  $B07F,$03 Write it as the actor Y.
N $B082 Place the flame to the left of the missile's world X.
  $B082,$03 Fetch #R$6108(#N$610A).
  $B085,$03 Set the offset in #REGbc to #N($0018,$04,$04).
  $B088,$01 Clear the carry flag.
  $B089,$02 Subtract the offset.
  $B08B,$01 Fetch the high byte.
  $B08C,$02,b$01 Keep only bits 0-4.
  $B08E,$01 Write it back.
  $B08F,$03 Write the low byte as the actor world X.
  $B092,$03 Write the high byte.
  $B095,$03 Jump to #R$ABB4.
@ $B098 label=Handler_SidewaysMissileFlame_HangRight
N $B098 The same hang, offset right, for type #N$A0.
  $B098,$03 Fetch #R$6108.
  $B09B,$04 Jump to #R$B0C9 if the type is not #N$A0.
N $B09F Alternate the flame frame and colour.
  $B09F,$03 Fetch the actor type.
  $B0A2,$02,b$01 Flip bit 0.
  $B0A4,$03 Write it back.
  $B0A7,$03 Fetch the actor colour.
  $B0AA,$02,b$01 Flip bit 2.
  $B0AC,$03 Write it back.
N $B0AF Match the flame Y to the missile Y.
  $B0AF,$03 Fetch #R$6108(#N$610C).
  $B0B2,$03 Write it as the actor Y.
N $B0B5 Place the flame to the right of the missile's world X.
  $B0B5,$03 Fetch #R$6108(#N$610A).
  $B0B8,$04 Add a #N$14 offset.
  $B0BC,$01 Fetch the high byte.
  $B0BD,$02,b$01 Keep only bits 0-4.
  $B0BF,$01 Write it back.
  $B0C0,$03 Write the low byte as the actor world X.
  $B0C3,$03 Write the high byte.
  $B0C6,$03 Jump to #R$ABB4.
N $B0C9 Free this flame's slot because the missile is gone.
@ $B0C9 label=Handler_Missile_HideActor
  $B0C9,$03 Call #R$8640.
  $B0CC,$04 Write #N$00 to the actor type.
  $B0D0,$01 Return.

c $B0D1 Test Target Range
@ $B0D1 label=Handler_Missile_TestJetmanRange
D $B0D1 Return carry if this actor is close enough to its target: Jetman
. when he is riding the rover, otherwise the parked rover. The world X
. difference is scaled by #N$08 and must be less than #N($00C0,$04,$04) and
. the target must be #N$00-#N$1F below the actor.
R $B0D1 IX Actor slot
  $B0D1,$03 Fetch #R$6078.
N $B0D4 Types #N$12-#N$19 are Jetman seated on the rover;
. use his slot. Otherwise use the rover slot when its
. type is in #N$1A-#N$29.
  $B0D4,$02 Subtract #N$12.
  $B0D6,$04 Jump to #R$B112 if Jetman is seated.
  $B0DA,$03 Fetch #R$6090.
  $B0DD,$02 Subtract #N$1A.
  $B0DF,$04 Jump to #R$B11B if that is not a rover frame.
  $B0E3,$03 Fetch #R$6092.
  $B0E6,$03 Fetch the rover Y.
  $B0E9,$01 Stash it in #REGc.
N $B0EA Scale both world X values and test the horizontal range.
@ $B0EA label=Handler_Missile_ScaleTargetX
  $B0EA,$03 Multiply the target world X by #N$08.
  $B0ED,$03 Fetch the actor world X.
  $B0F0,$03 Fetch the high byte.
  $B0F3,$01 Switch the pairs.
  $B0F4,$03 Multiply the actor world X by #N$08.
N $B0F7 Take the absolute horizontal distance between the two scaled
. X values.
  $B0F7,$01 Clear the carry flag.
  $B0F8,$02 Subtract the target world X.
  $B0FA,$01 Fetch the high byte of the difference.
  $B0FB,$04 Jump to #R$B102 if the result is positive.
  $B0FF,$03 Call #R$8947.
N $B102 Return unless the actor is within the horizontal range.
@ $B102 label=Handler_Missile_SubtractRange
  $B102,$03 #REGde=#N($00C0,$04,$04).
  $B105,$01 Clear the carry flag.
  $B106,$02 Subtract the range.
  $B108,$01 Return if the actor is too far away.
N $B109 Test the vertical distance to the target.
  $B109,$03 Fetch the actor Y.
  $B10C,$01 Subtract the target Y.
  $B10D,$02 Negate the difference.
  $B10F,$02 Compare it against #N$20.
  $B111,$01 Return.
N $B112 Use Jetman's position as the target when he is seated.
@ $B112 label=Handler_Missile_FetchJetman
  $B112,$03 Fetch #R$607A.
  $B115,$03 Fetch #R$607C.
  $B118,$01 Stash it in #REGc.
  $B119,$02 Jump to #R$B0EA.
@ $B11B label=Handler_Missile_OutOfRange
  $B11B,$02 Return with the carry flag clear.

c $B11D Explode Object Slots
@ $B11D label=Handler_Missile_ExplodeObjects
D $B11D Turn the object slots at #R$6108 and #R$6138 into explosions (type
. #N$5C), then jump to #R$AFE9.
  $B11D,$02 #REGa=#N$5C.
  $B11F,$03 Write it to #R$6108.
  $B122,$03 Write it to #R$6138.
  $B125,$03 Jump to #R$AFE9.

c $B128 Handler: Alien Base Plasma
@ $B128 label=Handler_AlienBasePlasma
D $B128 Handle the alien base plasma (types #N$90-#N$97). Jump to #R$B11D
. when it is close enough to its target (#R$B0D1). Otherwise kill Jetman if he
. is close (#R$B2D7), try to spawn a linked #N$C8 object (#R$A53A), step the
. frame through #N$90-#N$97 and colour the sprite.
R $B128 IX Actor slot
  $B128,$03 Call #R$B0D1.
  $B12B,$03 Jump to #R$B11D if this actor is in range.
  $B12E,$03 Call #R$B2A2.
  $B131,$03 Call #R$B2D7 if Jetman is close enough.
  $B134,$03 Call #R$A53A.
N $B137 Step the actor type through #N$90-#N$97.
  $B137,$03 Fetch the actor type.
  $B13A,$01 Increase it by one.
  $B13B,$02,b$01 Keep only bits 0-2.
N $B13D Sprite IDs begin at #R$E533(#N$90) (#SPRITENAME$90).
  $B13D,$02 Add #N$90.
  $B13F,$03 Write it back.
  $B142,$03 Call #R$8701.
N $B145 Colour the sprite with the actor colour.
  $B145,$03 Fetch the actor screen column.
  $B148,$03 Fetch the actor Y.
  $B14B,$03 Call #R$8506.
  $B14E,$03 Fetch the actor colour.
  $B151,$02 #REGc=#N$02.
  $B153,$03 Fetch #R$5E57.
  $B156,$02 Return if it is zero.
  $B158,$01 Copy it into the column counter.
  $B159,$03 Call #R$8750.
N $B15C Colour one more row with a cycling bright INK.
  $B15C,$03 Fetch #R$5E42.
  $B15F,$03 Rotate it right three times.
  $B162,$02,b$01 Keep only bits 0-2.
  $B164,$03 Jump to #R$B167 if the result is not zero,
. else force #N$01.
@ $B167 label=Handler_Missile_SetBrightColour
  $B167,$02,b$01 Set bit 6.
  $B169,$01 Copy the colour into #REGd.
  $B16A,$02 #REGc=#N$01.
  $B16C,$03 Jump to #R$8750.

c $B16F Convert Object Slots
@ $B16F label=Handler_Missile_ConvertExploding
D $B16F Turn the object slots at #R$6108 and #R$6138 into craters (type
. #N$C0) if they are in use. Turn #R$6120 and #R$6150 into small explosions
. (type #N$64) if their type is #N$C8-#N$CB. Then jump to #R$B960.
  $B16F,$03 Fetch #R$6108.
  $B172,$03 Jump to #R$B17A if it is free.
  $B175,$05 Write #N$C0 to #R$6108.
@ $B17A label=Handler_Missile_ClearSlot3
  $B17A,$03 Fetch #R$6138.
  $B17D,$03 Jump to #R$B185 if it is free.
  $B180,$05 Write #N$C0 to #R$6138.
N $B185 Turn the #N$C8-#N$CB slots into small explosions.
@ $B185 label=Handler_Missile_TestSlot2
  $B185,$03 Fetch #R$6120.
  $B188,$02 Subtract #N$C8.
  $B18A,$04 Jump to #R$B193 if that is at least #N$04.
  $B18E,$05 Write #N$64 to #R$6120.
@ $B193 label=Handler_Missile_TestSlot4
  $B193,$03 Fetch #R$6150.
  $B196,$02 Subtract #N$C8.
  $B198,$04 Jump to #R$B1A1 if that is at least #N$04.
  $B19C,$05 Write #N$64 to #R$6150.
@ $B1A1 label=Handler_Missile_CopyExplosion
  $B1A1,$03 Jump to #R$B960.

c $B1A4 Animate Crater
@ $B1A4 label=AnimateCrater
D $B1A4 Step a crater sprite, then stamp terrain when the frame
. reaches #N$C8.
R $B1A4 IX Actor slot
N $B1A4 Step the crater frame on even frames, then stamp the terrain when
. it reaches #N$C8.
  $B1A4,$03 Call #R$ABB4.
  $B1A7,$03 Fetch #R$5E42.
  $B1AA,$02,b$01 Keep only bit 0.
  $B1AC,$01 Return if this is an odd frame.
  $B1AD,$03 Increase the actor type by one.
  $B1B0,$03 Fetch the actor type.
  $B1B3,$03 Return if it is not #N$C8.
N $B1B6 Stamp the crater into the terrain and change the actor type.
  $B1B6,$03 Call #R$95B6.
  $B1B9,$04 Write #N$63 to the actor type.
N $B1BD Return unless this actor is in Jetman's slot.
  $B1BD,$03 Copy the slot pointer into #REGhl (using the
. stack).
  $B1C0,$03 Set #REGbc to Jetman's slot address #R$6078.
  $B1C3,$01 Clear the carry flag.
  $B1C4,$02 Subtract Jetman's slot address.
  $B1C6,$01 Return if this is not Jetman.
  $B1C7,$03 Call #R$8640.
  $B1CA,$04 Write #N$81 to the actor type.
  $B1CE,$04 Write #N$40 to the actor speed.
  $B1D2,$01 Return.

c $B1D3 Scan Object Slots
@ $B1D3 label=ScanObjectSlots
D $B1D3 OR together the types of the #N$18-byte object slots from #R$6108
. (four, or six from #R$B1E2). Return with the zero flag set if all are free.
N $B1D3 OR together the object-slot types starting at #R$6108.
  $B1D3,$03 #REGhl=#R$6108.
  $B1D6,$02 Set a slot counter in #REGb for #N$04 loops.
N $B1D8 Merge the types of the slots, stepping over each slot in turn.
@ $B1D8 label=ScanObjectSlots_Loop
  $B1D8,$03 #REGde=#N($0018,$04,$04).
  $B1DB,$01 Clear #REGa.
@ $B1DC label=ScanObjectSlots_MergeType
  $B1DC,$01 Merge in the current slot type.
  $B1DD,$01 Move onto the next slot.
  $B1DE,$02 Decrease the slot counter by one and loop back
. to #R$B1DC until every slot is tested.
  $B1E0,$01 Test the merged types.
  $B1E1,$01 Return.
N $B1E2 Scan six slots instead of four.
@ $B1E2 label=ScanObjectSlots_Test
  $B1E2,$03 #REGhl=#R$6108.
  $B1E5,$02 #REGb=#N$06.
  $B1E7,$02 Jump to #R$B1D8.

c $B1E9 Advance Position
@ $B1E9 label=AdvanceAnimation
D $B1E9 Add the horizontal speed to the fractional X accumulator in
. *#REGix+#N$10 (bits 1-3 only) and add the carried step to the world X at
. #R$B246. #R$B1FD does the same for the vertical thrust, using
. *#REGix+#N$11 and continues at #R$B272.
R $B1E9 A Horizontal speed
R $B1E9 IX Actor slot
N $B1E9 Add the speed to the fraction and keep the carry as the step.
  $B1E9,$03 #REGa+=*#REGix+#N$10.
  $B1EC,$01 #REGc=#REGa.
  $B1ED,$02,b$01 Keep only bits 1-3.
  $B1EF,$03 Write #REGa to *#REGix+#N$10.
N $B1F2 Rotate the carry bits of the sum down to make the whole step.
  $B1F2,$01 Copy the sum into #REGa.
  $B1F3,$04 Rotate the high nibble down into bits 0-3.
  $B1F7,$02,b$01 Keep only bits 0-3.
  $B1F9,$02 Clear #REGb.
  $B1FB,$02 Jump to #R$B246.
N $B1FD Add the vertical thrust to the Y fraction in the same way.
@ $B1FD label=AdvanceAnimation_AddYNibble
  $B1FD,$03 Add the Y nibble.
  $B200,$01 Stash the sum in #REGc.
  $B201,$02,b$01 Keep only bits 0-3.
  $B203,$03 Write it back as the Y nibble.
  $B206,$01 Copy the sum into #REGa.
  $B207,$04 Rotate the high nibble down into bits 0-3.
  $B20B,$02,b$01 Keep only bits 0-3.
  $B20D,$02 Jump to #R$B272.

c $B20F Score Small Hit
@ $B20F label=ScoreSmallHit
D $B20F Add #N$25 points and start the explosion at #R$A73C.
R $B20F IX Actor slot
N $B20F Add #N$25 points and start the explosion at #R$A73C.
  $B20F,$03 Set the points to award in #REGbc to #N($0025,$04,$04).
  $B212,$03 Call #R$899C.
  $B215,$03 Jump to #R$A73C.

c $B218 Tick Then Explode
@ $B218 label=TickThenExplode
D $B218 Move the actor by its fractional speed and thrust and cycle its
. frame. Start #R$A73C when the timer at *#REGix+#N$08 reaches zero, when the
. actor reaches the ground or leaves the top of the play area, or when it
. touches Jetman.
R $B218 IX Actor slot
N $B218 Decrease the actor timer and explode when it reaches zero.
  $B218,$07 Jump to #R$B20F if bit 0 of the explode flag is
. set.
  $B21F,$03 Decrease the actor timer by one.
  $B222,$03 Jump to #R$A73C if it is now zero.
N $B225 Work out the horizontal step from the actor speed.
  $B225,$03 Fetch the actor speed.
  $B228,$04 Jump to #R$B1E9 if the speed is positive.
N $B22C Add a negative speed to the X fraction and make the step
. negative.
  $B22C,$03 Add the X nibble.
  $B22F,$01 Stash the sum in #REGc.
  $B230,$02,b$01 Keep only bits 0-3.
  $B232,$02 Negate it.
  $B234,$02,b$01 Reset bit 0.
  $B236,$03 Write it back as the X nibble.
N $B239 Turn the carried bits of the sum into the negative step.
  $B239,$01 Copy the sum into #REGa.
  $B23A,$02 Negate it.
  $B23C,$04 Rotate the high nibble down into bits 0-3.
  $B240,$02,b$01 Keep only bits 0-3.
  $B242,$02 Negate it.
  $B244,$02 #REGb=#N$FF.
N $B246 Move the world X by the step and wrap it.
@ $B246 label=TickThenExplode_AddX
  $B246,$03 Add the step to the world X.
  $B249,$03 Write it back.
  $B24C,$03 Fetch the high byte.
  $B24F,$01 Add the sign.
  $B250,$02,b$01 Keep only bits 0-4.
  $B252,$03 Write the high byte back.
N $B255 Work out the vertical step from the actor thrust.
  $B255,$03 Fetch the actor thrust.
  $B258,$04 Jump to #R$B1FD if the thrust is positive.
N $B25C Add a negative thrust to the Y fraction and make the step
. negative.
  $B25C,$03 Add the Y nibble.
  $B25F,$01 Stash the sum in #REGc.
  $B260,$02,b$01 Keep only bits 0-3.
  $B262,$02 Negate it.
  $B264,$03 Write it back as the Y nibble.
N $B267 Turn the carried bits of the sum into the negative step.
  $B267,$01 Copy the sum into #REGa.
  $B268,$02 Negate it.
  $B26A,$04 Rotate the high nibble down into bits 0-3.
  $B26E,$02,b$01 Keep only bits 0-3.
  $B270,$02 Negate it.
N $B272 Move the actor Y, exploding on the ground or above the
. play area.
@ $B272 label=TickThenExplode_AddY
  $B272,$03 Add the step to the actor Y.
  $B275,$02 Compare it against #N$AF.
  $B277,$03 Jump to #R$A73C if the actor is on the ground.
  $B27A,$02 Compare it against #N$30.
  $B27C,$03 Jump to #R$A73C if the actor is above the play
. area.
  $B27F,$03 Write the new Y.
N $B282 Advance the frame within the actor's type family.
  $B282,$03 Fetch the actor type.
  $B285,$02,b$01 Keep only bits 2-7.
  $B287,$01 Stash the family in #REGc.
  $B288,$03 Fetch the actor type.
  $B28B,$01 Increase it by one.
  $B28C,$02,b$01 Keep only bits 0-1.
  $B28E,$01 Merge the family back in.
  $B28F,$03 Write it to the actor type.
N $B292 Draw the sprite and write its attributes.
  $B292,$03 Call #R$8B73.
  $B295,$03 Call #R$8733.
N $B298 Explode the actor if it is touching Jetman.
  $B298,$03 Call #R$B2A2.
  $B29B,$01 Return if Jetman is out of range.
  $B29C,$03 Call #R$B2D7.
  $B29F,$03 Jump to #R$A73C.

c $B2A2 Test Jetman Range
@ $B2A2 label=TickThenExplode_CloseRange
D $B2A2 Return carry if this actor is touching Jetman. This entry uses a
. vertical range of #N$0E; #R$B2A4 takes the range in #REGe. Carry is clear
. while the delay timer at #R$5E67 is running or Jetman's type is #N$11 or
. above.
R $B2A2 IX Actor slot
  $B2A2,$02 #REGe=#N$0E.
@ $B2A4 label=TickThenExplode_TestJetman
N $B2A4 Return carry if this actor is close enough to Jetman.
. Type #N$11 and above means Jetman is not on foot.
  $B2A4,$03 Fetch #R$5E67.
  $B2A7,$02 Return if the delay timer is still running.
  $B2A9,$03 Fetch #R$6078.
  $B2AC,$03 Return if Jetman's type is at least #N$11.
N $B2AF Test the horizontal distance to Jetman.
  $B2AF,$03 Fetch the actor world X.
  $B2B2,$03 Fetch the high byte.
  $B2B5,$04 Add an #N$08 box offset.
  $B2B9,$04 Fetch #R$607A.
  $B2BD,$01 Clear the carry flag.
  $B2BE,$02 Subtract Jetman's world X.
  $B2C0,$01 Fetch the high byte of the difference.
  $B2C1,$02,b$01 Keep only bits 0-4.
  $B2C3,$01 Return if they are on different screens.
  $B2C4,$01 Fetch the low byte.
  $B2C5,$03 Return if it is at least #N$10.
N $B2C8 Work out the vertical gap to Jetman.
  $B2C8,$03 Fetch #R$607C.
  $B2CB,$02 Subtract #N$04.
  $B2CD,$03 Subtract the actor Y.
@ $B2D0 label=TickThenExplode_TestHeight
N $B2D0 #REGa is (Jetman's Y minus #N$04) minus this actor's Y. Keep
. that gap as a positive distance, then compare it with #REGe.
N $B2D0 See #POKE(immunity,Immunity).
  $B2D0,$03 Jump to #R$B2D5 if Jetman is at or below this actor.
  $B2D3,$02 Else make the vertical gap positive.
@ $B2D5 label=TickThenExplode_Compare
N $B2D5 See #POKE(immunity,Immunity).
  $B2D5,$02 Return. Carry is set when the gap is smaller
. than #REGe.

c $B2D7 Kill Jetman
@ $B2D7 label=TickThenExplode_KillJetman
D $B2D7 Turn Jetman into the dying type (#N$DC) and bounce him away, then
. continue into #R$B2F9.
R $B2D7 IX Actor slot
  $B2D7,$03 #REGde=#R$B9DA(#N$B9E7).
  $B2DA,$03 Call #R$B9BC.
  $B2DD,$03 #REGhl=#R$6078.
  $B2E0,$02 Write #N$DC as Jetman's type.
N $B2E2 Pick the bounce direction from the actor screen column.
  $B2E2,$03 #REGhl=#R$607D.
  $B2E5,$03 Fetch the actor screen column.
  $B2E8,$04 Jump to #R$B339 if it is less than #N$78.
  $B2EC,$02 Write #N$C0 as Jetman's speed.
N $B2EE Set Jetman's thrust, then write #N$06 into two bytes of his
. slot.
@ $B2EE label=TickThenExplode_Loop
  $B2EE,$01 Move onto Jetman's thrust.
  $B2EF,$02 Write #N$01 as Jetman's thrust.
  $B2F1,$03 #REGhl=#R$6080(#N$608A).
  $B2F4,$02 Write #N$06.
  $B2F6,$01 Move onto the next byte.
  $B2F7,$02 Write #N$06.

c $B2F9 Drop World Objects
@ $B2F9 label=HideDistantObjects
D $B2F9 Set bit 7 (falling) on world slots 1 and 2 unless they are carried,
. clear the low flag bits of slot 3, update the bomb flags and turn an
. occupied slot 4 into a platform.
N $B2F9 Set bit 7 (falling) on world slot 1 unless bit 3 (carried) is set.
  $B2F9,$03 Fetch #R$60B0.
  $B2FC,$04 Jump to #R$B305 if bit 3 is set.
  $B300,$02,b$01 Set bit 7.
  $B302,$03 Write it back.
N $B305 Do the same for world slot 2.
@ $B305 label=HideDistantObjects_Slot2Flags
  $B305,$03 Fetch #R$60C8.
  $B308,$04 Jump to #R$B311 if bit 3 is set.
  $B30C,$02,b$01 Set bit 7.
  $B30E,$03 Write it back.
N $B311 Clear bits 0-1 of the flags of world slot 3.
@ $B311 label=HideDistantObjects_Slot3Flags
  $B311,$03 Fetch #R$60E0.
  $B314,$02,b$01 Keep only bits 2-7.
  $B316,$03 Write it back.
N $B319 Update the bomb flag when it is not on the ground.
  $B319,$03 Fetch #R$6198(#N$61A0).
  $B31C,$04 Jump to #R$B32B if bit 2 is set.
  $B320,$03 Fetch #R$6198(#N$619C).
  $B323,$02 Compare it against #N$AF.
  $B325,$02 #REGa=#N$00.
  $B327,$02 Jump to #R$B32B if they are equal.
  $B329,$02,b$01 Set bit 1.
@ $B32B label=HideDistantObjects_WriteBomb
  $B32B,$03 Write it to #R$6198(#N$61A0).
N $B32E Turn world slot 4 into a platform if it is occupied.
  $B32E,$03 Fetch #R$60F0.
  $B331,$02 Return if it is free.
  $B333,$05 Write #N$2F to #R$60F0.
  $B338,$01 Return.

c $B339 Bounce Jetman Right
@ $B339 label=BounceJetmanRight
D $B339 Write #N$40 as Jetman's horizontal speed so he bounces away to the
. right, then rejoin #R$B2EE.
R $B339 HL #R$607D (Jetman's horizontal speed)
  $B339,$02 Write #N$40 to *#REGhl.
  $B33B,$02 Jump to #R$B2EE.

c $B33D Tick Actor Frame
@ $B33D label=TickActorFrame
D $B33D Decrease *#REGix+#N($12), apply speed, and redraw the actor.
R $B33D IX Actor slot
N $B33D Reload the frame timer, or apply speed and redraw.
  $B33D,$05 Jump to #R$B357 if the frame timer is not zero.
  $B342,$03 Fetch *#REGix+#N$13.
  $B345,$03 Reload the frame timer.
  $B348,$03 Increase the actor thrust by one.
  $B34B,$03 Fetch the actor speed.
  $B34E,$03 Jump to #R$B357 if the speed is zero.
  $B351,$03 Jump to #R$B356 if the speed is positive.
  $B354,$02 Increase the speed by two.
@ $B356 label=TickActorFrame_DecreaseSpeed
  $B356,$01 Decrease the speed by one.
N $B357 Apply the speed, then drop the actor by its thrust.
@ $B357 label=TickActorFrame_ApplyMotion
  $B357,$03 Call #R$907B.
  $B35A,$03 Fetch the actor Y.
  $B35D,$03 Add the thrust.
  $B360,$04 Jump to #R$B37B if the actor has reached the
. ground line.
  $B364,$03 Write the new Y.
  $B367,$01 Stash it in #REGc.
  $B368,$02 #REGd=#N$03.
  $B36A,$03 Call #R$B8CD.
N $B36D Pick the dying frame from the frame counter and redraw.
  $B36D,$03 Fetch #R$5E42.
  $B370,$01 Rotate it right once.
  $B371,$02,b$01 Keep only bits 0-1.
N $B373 Sprite IDs begin at #R$E910(#N$DC) (#SPRITENAME$DC).
  $B373,$02 Add #N$DC for the dying frames.
  $B375,$03 Write it to the actor type.
  $B378,$03 Jump to #R$ABB4.

c $B37B Explode At Ground
@ $B37B label=ExplodeAtGround
D $B37B Place the actor on the ground and start #R$A75D.
R $B37B IX Actor slot
N $B37B Place the actor on the ground line at Y=#N$AF
. and start #R$A75D.
  $B37B,$04 Write #N$AF to the actor Y.
  $B37F,$03 Call #R$A75D.
  $B382,$03 Jump to #R$ABB4.

c $B385 Reset Alien States
@ $B385 label=ResetAlienStates
D $B385 Writes #N$00 to every alien state to clear it.
  $B385,$03 #REGhl=#R$61B0.
N $B388 There are six alien slots, each is #N$18 bytes long.
  $B388,$02 Set a byte counter in #REGb for #N$90 loops.
@ $B38A label=ResetAlienStates_Loop
  $B38A,$02 Write #N$00 to *#REGhl.
  $B38C,$01 Increment #REGhl by one.
  $B38D,$02 Decrease the counter by one and jump back to
. #R$B38A until it is zero.
  $B38F,$01 Return.

c $B390 Count Death Timer
@ $B390 label=CountDeathTimer
D $B390 Tick the actor's death countdown and lose a life when it
. reaches zero.
R $B390 IX Actor slot
N $B390 Tick the death countdown and lose a life when it expires.
  $B390,$05 Return if #R$5E6C is not zero.
  $B395,$03 Decrease *#REGix+#N$05 by one.
  $B398,$01 Return if the result is above zero.
  $B399,$03 Jump to #R$A8B5.
@ $B39C label=CountDeathTimer_Unconditional
N $B39C Same death countdown for type #N($85), without the #R$5E6C test.
  $B39C,$03 Decrease *#REGix+#N$05 by one.
  $B39F,$01 Return if the result is above zero.
  $B3A0,$03 Jump to #R$A8B5.

c $B3A3 Message: Teleporting
@ $B3A3 label=MessageTeleporting
D $B3A3 Blanks the play area, then prints the "TELEPORTING" message
. repeatedly while cycling its INK colour, playing a tone on each pass.
N $B3A3 Blank the play area and start the TELEPORTING cycle.
  $B3A3,$01 Disable interrupts.
  $B3A4,$03 Call #R$8BA5.
  $B3A7,$02 Set a colour cycle counter in #REGb for #N$10 loops.
@ $B3A9 label=MessageTeleporting_Loop
  $B3A9,$01 Stash #REGbc (the colour cycling counter) on the stack.
N $B3AA Handle printing "#FONTaddr=$D347,attr=$41,chars=0(TELEPORTING)(teleporting)" messaging.
  $B3AA,$03 #REGhl=#N$7058 (screen location).
  $B3AD,$03 #REGde=#R$B3D0.
  $B3B0,$03 Call #R$8A11.
N $B3B3 Pause so the player can read the message. This
. inner loop runs once per INK change, so the wait is
. #N($2000,$04,$04)*#N$10.
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
@ $B3C4 label=MessageTeleporting_SetBright
  $B3C4,$02,b$01 Set bit 6 (BRIGHT).
  $B3C6,$03 Store #REGa at #R$B3D0 to overwrite the attribute byte.
N $B3C9 Restore the counter, play the repeated tone and loop until
. the counter is zero.
  $B3C9,$01 Restore #REGbc (the colour cycling counter) from the stack.
  $B3CA,$03 Call #R$B8E8.
  $B3CD,$02 Decrease the counter by one and jump back to
. #R$B3A9 until it is zero.
  $B3CF,$01 Return.

t $B3D0 Messaging: Teleporting
N $B3D0 #FONTaddr=$D347,attr=$41,chars=0(TELEPORTING)(teleporting)
@ $B3D0 label=String_Teleporting
  $B3D0,$0C,h$01,$0A:$01 Attribute: #COLOUR(#PEEK(#PC)) + "TELEPORTING".

c $B3DC Initialise Terrain
@ $B3DC label=Terrain_Initialise
D $B3DC Copy the default terrain data into #R$7000.
  $B3DC,$0B Copy the #N$0400 bytes of default terrain data from #R$F6CE to
. #R$7000.
  $B3E7,$01 Return.

c $B3E8 Handler: Jetman Death
@ $B3E8 label=Handler_JetmanDeath
D $B3E8 Flash the dying actor from the frame timer, then convert
. the slot to type #N$85.
R $B3E8 IX Actor slot
N $B3E8 Flash the dying actor from the frame timer.
  $B3E8,$03 Fetch #R$5E42.
  $B3EB,$01 Invert the bits.
  $B3EC,$02,b$01 Keep only bit 0.
  $B3EE,$02 Jump to #R$B3F5 if this is an odd frame.
  $B3F0,$05 Jump to #R$B441 if the death timer is now zero.
@ $B3F5 label=Handler_JetmanDeath_TripleTimer
N $B3F5 Pick a death-frame triplet and apply its X/Y offsets.
  $B3F5,$03 Fetch the death timer.
  $B3F8,$01 Stash it in #REGc.
  $B3F9,$01 Double it.
  $B3FA,$01 Add the original.
  $B3FB,$03 Create an offset in #REGhl.
  $B3FE,$04 Point #REGhl at that triplet, offset from #R$B451.
N $B402 Fetch the frame byte and write it as the actor type.
  $B402,$01 Switch the table pointer into #REGde.
  $B403,$02 Copy the next table byte.
N $B405 Sprite IDs begin at #R$EA8D(#N$E0) (#SPRITENAME$E0).
  $B405,$02 Add #N$E0 for the dying frames.
  $B407,$03 Write it to the actor type.
N $B40A Offset the actor world X by the table value.
  $B40A,$03 Fetch the actor world X.
  $B40D,$03 Fetch the high byte.
  $B410,$01 Stash the world X on the stack.
N $B411 Fetch the X offset and sign-extend it.
  $B411,$02 Copy the next table byte.
  $B413,$01 Copy the X offset into #REGc.
  $B414,$02 Clear #REGb.
  $B416,$04 Jump to #R$B41B if the offset is positive.
  $B41A,$01 Sign-extend into #REGb.
@ $B41B label=Handler_JetmanDeath_WriteX
  $B41B,$03 Call #R$A002.
  $B41E,$03 Write the low byte as the actor world X.
  $B421,$03 Write the high byte.
N $B424 Offset the actor Y by the table value.
  $B424,$03 Fetch the actor Y.
  $B427,$01 Stash it on the stack.
  $B428,$01 Fetch the Y offset.
  $B429,$03 Add the actor Y.
  $B42C,$03 Write it back.
N $B42F Draw the dying frame, then restore the stored position.
  $B42F,$03 Call #R$8787.
  $B432,$03 Call #R$8733.
  $B435,$01 Restore the actor Y from the stack.
  $B436,$03 Write it back.
  $B439,$01 Restore the world X from the stack.
  $B43A,$03 Write the low byte back.
  $B43D,$03 Write the high byte back.
  $B440,$01 Return.
@ $B441 label=Handler_JetmanDeath_NoLives
N $B441 Clear the lives count and become type #N$85.
  $B441,$03 Call #R$864F.
  $B444,$04 Write #N$00 to #R$5EA1.
  $B448,$04 Write #N$85 to the actor type.
  $B44C,$04 Write #N$40 to the actor speed.
  $B450,$01 Return.
@ $B451 label=Handler_JetmanDeath_Offsets
B $B451,$0F Death-frame offsets.

c $B460 Handler: Falling Sprite
@ $B460 label=Handler_FallingSprite
D $B460 Tick the sprite delay, move the debris and, once the thrust reaches
. #N($01), play #R$B8CD and become type #N$E7.
R $B460 IX Actor slot
N $B460 Reload the delay from *#REGix+#N$11 when it expires.
  $B460,$03 Decrease *#REGix+#N$10 by one.
  $B463,$02 Jump to #R$B475 if it is not zero.
  $B465,$03 #REGa=*#REGix+#N$11.
  $B468,$03 Write #REGa to *#REGix+#N$10.
N $B46B Increase the thrust and land once it reaches #N$01.
  $B46B,$03 Increment *#REGix+#N$06 by one.
  $B46E,$03 #REGa=*#REGix+#N$06.
  $B471,$02 Compare #REGa with #N$01.
  $B473,$02 Jump to #R$B48B if they are equal.
@ $B475 label=Handler_FallingSprite_CycleType
N $B475 Step the type (#N$E6 becomes #N($E7), else reset to #N$E4), then move.
  $B475,$03 #REGa=*#REGix+#N$00.
  $B478,$01 Increment #REGa by one.
  $B479,$02 Compare #REGa with #N$E7.
  $B47B,$02 Jump to #R$B47F if #REGa is #N$E7 or higher.
N $B47D "#SPRITENAME$E4".
  $B47D,$02 #REGa=#N$E4.
@ $B47F label=Handler_FallingSprite_MoveDown
  $B47F,$03 Write #REGa to *#REGix+#N$00.
  $B482,$03 Call #R$B6AE.
  $B485,$03 Write #REGa to *#REGix+#N$04.
  $B488,$03 Jump to #R$ABB4.
@ $B48B label=Handler_FallingSprite_Land
N $B48B Play #R$B8CD and become type #N$E7.
  $B48B,$03 #REGc=*#REGix+#N$04.
  $B48E,$02 #REGd=#N$04.
  $B490,$03 Call #R$B8CD.
N $B493 "#SPRITENAME$E7".
  $B493,$04 Write #N$E7 to *#REGix+#N$00.
  $B497,$03 Jump to #R$ABB4.
@ $B49A label=Handler_FallingSprite_StepType
N $B49A Step the type on and redraw.
  $B49A,$03 Increase the actor type by one.
  $B49D,$03 Jump to #R$ABB4.
@ $B4A0 label=Handler_FallingSprite_FlipType
N $B4A0 Flip the type every eighth frame, then drop.
  $B4A0,$03 Fetch #R$5E42.
  $B4A3,$02,b$01 Keep only bits 0-2.
  $B4A5,$02 Jump to #R$B4AF if the result is not zero.
  $B4A7,$03 Fetch the actor type.
  $B4AA,$02,b$01 Flip bit 0.
  $B4AC,$03 Write it back.
@ $B4AF label=Handler_FallingSprite_IncreaseY
  $B4AF,$03 Increase the actor Y by one.
N $B4B2 Remove the sprite once it reaches the ground line.
  $B4B2,$03 Fetch the actor Y.
  $B4B5,$05 Jump to #R$ABB4 if it is still above the ground
. line.
  $B4BA,$03 Call #R$8640.
  $B4BD,$04 Write #N$00 to the actor type.
  $B4C1,$01 Return.

c $B4C2 Fill Debris Slots
@ $B4C2 label=FillDebrisSlots
D $B4C2 Write #N$11 type-#N$E4 slots from #R$60A8 using the
. actor X/Y at #REGde and ROM bytes addressed by #R$5E40.
R $B4C2 DE Address of the actor world X and Y
N $B4C2 Point #REGhl at the first world slot.
  $B4C2,$03 #REGhl=#R$60A8.
  $B4C5,$03 Set #REGb to #N$07 bytes to clear and #REGc to #N$11 slots.
N $B4C8 Point #REGhl' at ROM using #R$5E40 as the low byte.
  $B4C8,$01 Switch to the shadow registers.
  $B4C9,$03 Fetch #R$5E40.
  $B4CC,$01 Copy it into the low byte of #REGhl'.
  $B4CD,$02 Clear the high byte of #REGhl'.
  $B4CF,$01 Switch back.
N $B4D0 Write type #N$E4 and copy the three-byte X/Y seed.
@ $B4D0 label=FillDebrisSlots_Loop
  $B4D0,$01 Stash the slot counters on the stack.
  $B4D1,$02 Write type #N$E4.
  $B4D3,$02 Skip the screen-column byte.
  $B4D5,$01 Fetch the low world X.
  $B4D6,$01 Write it.
  $B4D7,$01 Advance the seed pointer.
  $B4D8,$01 Advance the slot pointer.
  $B4D9,$01 Fetch the high world X.
  $B4DA,$01 Write it.
  $B4DB,$01 Advance the slot pointer.
  $B4DC,$01 Advance the seed pointer.
  $B4DD,$01 Fetch the Y.
  $B4DE,$01 Write it.
  $B4DF,$02 Rewind the seed pointer by two bytes.
  $B4E1,$01 Advance to the speed byte.
N $B4E2 Take the next ROM byte as the speed.
  $B4E2,$01 Switch to the shadow registers.
  $B4E3,$01 Fetch the next ROM byte from *#REGhl'.
  $B4E4,$01 Advance #REGhl'.
  $B4E5,$04 Jump to #R$B529 if it is positive.
  $B4E9,$02,b$01 Set bits 2-7.
@ $B4EB label=FillDebrisSlots_WriteSpeed
  $B4EB,$01 Switch back.
  $B4EC,$01 Write the speed.
  $B4ED,$01 Advance to the thrust byte.
N $B4EE Force the thrust into the range #N$FB-#N$FE.
  $B4EE,$01 Switch to the shadow registers.
  $B4EF,$01 Fetch the next ROM byte from *#REGhl'.
  $B4F0,$01 Advance #REGhl'.
  $B4F1,$02,b$01 Keep only bits 0-1.
  $B4F3,$02,b$01 Set bits 2-7.
  $B4F5,$02 Subtract #N$01.
  $B4F7,$01 Switch back.
  $B4F8,$01 Write the thrust.
  $B4F9,$01 Advance to the colour byte.
N $B4FA Colour is bits 0-2 of the next ROM byte (#N$00 and #N$01 become
. #INK$07), plus BRIGHT.
  $B4FA,$01 Switch to the shadow registers.
  $B4FB,$01 Fetch the next ROM byte from *#REGhl'.
  $B4FC,$01 Advance #REGhl'.
  $B4FD,$02,b$01 Keep only bits 0-2.
  $B4FF,$04 Jump to #R$B505 if it is at least #N$02.
  $B503,$02 #REGa=#INK$07.
@ $B505 label=FillDebrisSlots_SetBright
  $B505,$02,b$01 Set bit 6.
  $B507,$01 Switch back.
  $B508,$01 Write the colour.
  $B509,$02 Skip the flags byte.
N $B50B Clear the next #N$07 bytes.
@ $B50B label=FillDebrisSlots_ClearBytes
  $B50B,$02 Write #N$00.
  $B50D,$01 Advance the slot pointer.
  $B50E,$02 Decrease the counter by one and jump back to
. #R$B50B until it is zero.
N $B510 Write the sprite delay and its reload value, then step to the
. next slot.
  $B510,$01 Switch to the shadow registers.
  $B511,$01 Fetch the next ROM byte from *#REGhl'.
  $B512,$01 Advance #REGhl'.
  $B513,$02,b$01 Keep only bits 0-2.
  $B515,$01 Increase it by one.
  $B516,$01 Switch back.
  $B517,$01 Write the sprite delay.
  $B518,$01 Advance the slot pointer.
  $B519,$01 Write the same value as the delay reload.
  $B51A,$08 Advance #REGhl by #N$07 to the next slot.
N $B522 Loop until every slot has been written, then
. initialise the explosion.
  $B522,$01 Restore the slot counters from the stack.
  $B523,$01 Decrease the remaining slot count by one.
  $B524,$02 Jump back to #R$B4D0 if there are slots left.
  $B526,$03 Jump to #R$B986.
N $B529 Positive ROM speeds become #N$01-#N$04.
@ $B529 label=FillDebrisSlots_PositiveSpeed
  $B529,$02,b$01 Keep only bits 0-1.
  $B52B,$01 Increase it by one.
  $B52C,$02 Jump to #R$B4EB.

c $B52E Show Laser Estimate
@ $B52E label=ShowLaserEstimate
D $B52E Queue the briefing tune, write the hit count into the
. banner, then flash the warning while beeping.
N $B52E Queue the briefing tune and write the hit-count digit.
  $B52E,$01 Disable interrupts.
  $B52F,$03 #REGde=#R$BA2A.
  $B532,$03 Call #R$B9BC.
  $B535,$01 Call the ROM interrupt routine at #SKOOLKID$0038(MASK-INT).
  $B536,$03 Fetch the hit count from #R$6108(#N$611E).
  $B539,$03 Call #R$B699.
N $B53C Here we alter "#FONTaddr=$D347,attr=$47,chars=0(IT IS ESTIMATED THAT XX
. LASER)(hits)" to update with the number of hits.
  $B53C,$03 #REGhl=#R$B64A(#N$B660).
N $B53F Write the tens digit, or a space when it is zero.
  $B53F,$01 Stash the converted count in #REGc.
  $B540,$04 Rotate the tens digit into the low nibble.
  $B544,$02,b$01 Keep only bits 0-3.
  $B546,$02 Jump to #R$B54A if the tens digit is not zero.
  $B548,$02 #REGa=#N$F0 (becomes a space after +#N$30).
@ $B54A label=ShowLaserEstimate_WriteDigit
  $B54A,$02 Add #N$30 to make an ASCII digit.
  $B54C,$01 Write the tens character.
  $B54D,$01 Advance to the units position.
N $B54E Write the units digit.
  $B54E,$01 Copy the converted count into #REGa.
  $B54F,$02,b$01 Keep only bits 0-3.
  $B551,$02 Add #N$30 to make an ASCII digit.
  $B553,$01 Write the units character.
N $B554 Flash the warning twelve times, beeping each time.
  $B554,$03 Call #R$8BA5.
  $B557,$02 Set a flash counter in #REGb for #N$0C loops.
@ $B559 label=ShowLaserEstimate_Loop
  $B559,$01 Stash #REGbc on the stack.
  $B55A,$03 Call #R$8298.
  $B55D,$03 Call #R$B594.
N $B560 #HTML(#AUDIO0(laser-estimate.wav)(#INCLUDE(LaserEstimate)))
  $B560,$02 #REGc=#N$80 (pitch).
  $B562,$02 #REGd=#N$80 (duration).
@ $B564 label=ShowLaserEstimate_Beep
  $B564,$03 Call #R$B8DA.
  $B567,$01 Decrease the duration by one.
  $B568,$02 Jump back to #R$B564 until it is zero.
N $B56A Show the warning in the alternate colour, restore
. the original colour and pause.
  $B56A,$02 #REGa=#COLOUR$42.
  $B56C,$03 Write it to #R$B5DC.
  $B56F,$03 Call #R$B594.
  $B572,$02 #REGa=#COLOUR$56.
  $B574,$03 Write it to #R$B5DC.
N $B577 Pause before the next flash.
  $B577,$03 #REGhl=#N$8000.
@ $B57A label=ShowLaserEstimate_Delay
  $B57A,$01 Decrease #REGhl by one.
  $B57B,$04 Jump back to #R$B57A if #REGhl is not zero.
  $B57F,$01 Restore #REGbc from the stack.
  $B580,$02 Decrease the flash count by one and jump back to
. #R$B559 until it is zero.
N $B582 Queue a jingle, blank the play area and reset the laser beam
. slots and alien states before clearing the sprite caches.
  $B582,$03 #REGde=#R$B9DA.
  $B585,$03 Call #R$B9BC.
  $B588,$03 Call #R$8BA5.
  $B58B,$03 Call #R$A317.
  $B58E,$03 Call #R$B385.
  $B591,$03 Jump to #R$A2F5.

c $B594 Messaging: Missile Launch
@ $B594 label=Message_MissileLaunch
D $B594 Prints the missile launch warning message one line at a time,
. each at its own screen location.
N $B594 Handle displaying "WARNING" messaging.
  $B594,$03 #REGde=#R$B5DC.
  $B597,$03 #REGhl=#N($2860, $04, $04) (screen location).
  $B59A,$03 Call #R$8A11.
N $B59D Handle displaying "A MISSILE HAS BEEN LAUNCHED" messaging.
  $B59D,$03 #REGde=#R$B5E4.
  $B5A0,$03 #REGhl=#N($3808, $04, $04) (screen location).
  $B5A3,$03 Call #R$8A11.
N $B5A6 Handle displaying "FROM THE ENEMY BASE." messaging.
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
N $B5DC #FONTaddr=$D347,attr=$56,chars=0(WARNING)(warning)
  $B5DC,$08,h$01,$06:$01 "WARNING".
@ $B5E4 label=String_Launched
N $B5E4 #FONTaddr=$D347,attr=$46,chars=0(A MISSILE HAS BEEN LAUNCHED)(launched)
  $B5E4,$1D,h$01,$1B:$01 "A MISSILE HAS BEEN LAUNCHED "
@ $B601 label=String_EnemyBase
N $B601 #FONTaddr=$D347,attr=$46,chars=0(FROM THE ENEMY BASE.)(enemy-base)
  $B601,$16,h$01,$14:$01 "FROM THE ENEMY BASE. "
@ $B617 label=String_Danger
N $B617 #FONTaddr=$D347,attr=$44,chars=0(YOUR LUNAR ROVER IS IN DANGER)(danger)
  $B617,$1F,h$01,$1D:$01 "YOUR LUNAR ROVER IS IN DANGER ".
@ $B636 label=String_BeingDestroyed
N $B636 #FONTaddr=$D347,attr=$44,chars=0(OF BEING DESTROYED)(being-destroyed)
  $B636,$14,h$01,$12:$01 "OF BEING DESTROYED ".
@ $B64A label=String_Estimated
N $B64A #FONTaddr=$D347,attr=$47,chars=0(IT IS ESTIMATED THAT    LASER)(estimated)
  $B64A,$1F,h$01,$1D:$01 "IT IS ESTIMATED THAT    LASER ".
@ $B669 label=String_Required
N $B669 #FONTaddr=$D347,attr=$47,chars=0(HITS WILL BE REQUIRED TO)(required)
  $B669,$1A,h$01,$18:$01 "HITS WILL BE REQUIRED TO ".
@ $B683 label=String_DestroyMissile
N $B683 #FONTaddr=$D347,attr=$47,chars=0(DESTROY THE MISSILE.)(missile)
  $B683,$16,h$01,$14:$01 "DESTROY THE MISSILE. ".

c $B699 Convert To Base 10
@ $B699 label=Convert_Base10
D $B699 Converts #REGa into packed decimal, with the tens in the high
. nibble and the units in the low nibble.
R $B699 A Input number
R $B699 O:A Output number
N $B699 For an example, given #REGa=#N$16 - the output is #EVAL($22,$02,$08).
N $B699 First count the number of "10's" in #REGa.
  $B699,$03 Set the tens counter in #REGb to zero and the divisor in #REGc
. to #N$0A.
@ $B69C label=Convert_Base10_Loop
  $B69C,$01 Increment #REGb counter.
  $B69D,$01 #REGa-=#N$0A.
  $B69E,$02 Jump back to #R$B69C until there's a carry amount.
N $B6A0 Restore the units and correct the tens count.
  $B6A0,$01 #REGa+=#REGc.
  $B6A1,$01 Decrease the counter in #REGb by one to account for the carry.
N $B6A2 Move the tens into the high nibble and merge in the units.
  $B6A2,$08 Shift and rotate #REGb four times.
  $B6AA,$02,b$01 Keep only bits 0-3.
  $B6AC,$01 Set the bits from #REGb.
  $B6AD,$01 Return.

c $B6AE Move By Speed
@ $B6AE label=MoveBySpeed
D $B6AE Add the actor's horizontal speed to its world X and return
. the Y plus thrust in #REGa.
R $B6AE IX Actor slot
N $B6AE Add the actor's horizontal speed to its world X.
  $B6AE,$04 Copy the actor speed into #REGc.
  $B6B2,$02 Clear #REGb.
  $B6B4,$04 Jump to #R$B6B9 if the speed is positive.
  $B6B8,$01 Sign-extend the speed into #REGbc.
N $B6B9 Add the sign-extended speed to the world X and wrap it.
@ $B6B9 label=MoveBySpeed_AddWorldX
  $B6B9,$03 Fetch the actor world X.
  $B6BC,$03 Fetch the high byte.
  $B6BF,$03 Call #R$A002.
  $B6C2,$03 Write the wrapped low byte back.
  $B6C5,$03 Write the wrapped high byte back.
N $B6C8 Return the actor Y plus its thrust.
  $B6C8,$03 Fetch the actor Y.
  $B6CB,$03 Add the actor thrust.
  $B6CE,$01 Return.

c $B6CF Dispatch Object State
@ $B6CF label=DispatchObjectState
D $B6CF Use bits 0-3 of *#REGix+#N$08 as an index into #R$B6DB.
R $B6CF IX Actor slot
N $B6CF Use bits 0-3 of the actor flags as an index into #R$B6DB.
  $B6CF,$03 Point #REGbc at the state table at #R$B6DB.
  $B6D2,$03 #REGa=*#REGix+#N$08.
  $B6D5,$02,b$01 Keep only bits 0-3.
  $B6D7,$01 #REGl=#REGa.
  $B6D8,$03 Jump to #R$81FE.
@ $B6DB label=Object_State_Table
W $B6DB,$02 #R$B785.
W $B6DD,$02 #R$B7BC.
W $B6DF,$02 #R$B810.
W $B6E1,$02 #R$B6EB.
W $B6E3,$08 #R$B6EC.

c $B6EB Ignore Object State
@ $B6EB label=IgnoreObjectState
D $B6EB No-op handler for object-state index #N$03 in
. #R$B6DB.
  $B6EB,$01 Return.

c $B6EC Handler: Armed Bomb
@ $B6EC label=Handler_ArmedBomb
D $B6EC Animate the bomb and, on action, collect it and play
. #R$B8BD.
R $B6EC IX Actor slot
N $B6EC Animate the bomb and test the action key.
  $B6EC,$03 Call #R$B7A8.
  $B6EF,$03 Call #R$945C.
  $B6F2,$02 Jump to #R$B6F8 if action is pressed.
  $B6F4,$04 Reset bit 7 of the actor flags.
@ $B6F8 label=Handler_ArmedBomb_TestRover
N $B6F8 Collect the bomb when the rover type is in
. #N$1A-#N$29.
  $B6F8,$03 Fetch #R$6090.
  $B6FB,$02 Subtract #N$1A.
  $B6FD,$02 Compare it with #N$10.
  $B6FF,$02 Jump to #R$B71C if it is out of range.
  $B701,$03 Call #R$A4E7.
  $B704,$02 Jump to #R$B719 if Jetman cannot collect it.
N $B706 Mark the bomb as carried and play the take sound.
  $B706,$04 Write #N$81 to the actor flags.
  $B70A,$03 Fetch #R$6080.
  $B70D,$02,b$01 Set bit 0.
  $B70F,$03 Write it back.
  $B712,$04 Write #N$00 to #R$5EA3.
  $B716,$03 Call #R$B8BD.
@ $B719 label=Handler_ArmedBomb_DrawHeld
  $B719,$03 Jump to #R$A431.
N $B71C Hang the bomb beside Jetman. Type #N$16 and
. above is seated facing right; hang it on the left.
@ $B71C label=Handler_ArmedBomb_HangBeside
  $B71C,$03 Fetch #R$6078.
  $B71F,$02 Compare it with #N$16.
  $B721,$02 Jump to #R$B72C if it is lower.
  $B723,$03 Set the offset in #REGbc to #N$FFF4 (-#N$0C).
@ $B726 label=Handler_ArmedBomb_Loop
  $B726,$03 Fetch #R$607A.
  $B729,$03 Jump to #R$A43E.
@ $B72C label=Handler_ArmedBomb_OnFootOffset
  $B72C,$03 Set the offset in #REGbc to #N($0012,$04,$04).
  $B72F,$02 Jump to #R$B726.

c $B731 Handler: Bombs
@ $B731 label=Handler_Bombs
D $B731 Copy the template into #R$6198 when that slot is empty,
. then place the bomb from the rover or Jetman.
N $B731 Copy the bomb template into #R$6198 when that slot is empty.
  $B731,$03 #REGde=#R$6198.
  $B734,$03 Return if a bomb is already active.
  $B737,$03 #REGhl=#R$B76D.
  $B73A,$05 Copy the #N$18-byte template into the bomb slot.
N $B73F Take the spawn X from the rover or from Jetman.
  $B73F,$03 Fetch #R$6090.
  $B742,$02 Subtract #N$1A.
  $B744,$02 Compare it with #N$10.
  $B746,$02 Jump to #R$B763 if the rover type is in range.
  $B748,$03 Fetch #R$607A.
N $B74B Offset the spawn X by #N$30 to the right, or to the
. left when the rover is outside the alien base range.
@ $B74B label=Handler_Bombs_Loop
  $B74B,$01 Stash the spawn X on the stack.
  $B74C,$03 Fetch #R$6092.
  $B74F,$04 Fetch #R$6182.
  $B753,$03 Call #R$AD3F.
  $B756,$02 Jump to #R$B768 if the rover is outside the
. #N$1000 range of #R$6182.
  $B758,$03 Set the offset in #REGbc to #N($0030,$04,$04).
N $B75B Add the offset to the spawn X and write it to the bomb slot.
@ $B75B label=Handler_Bombs_PlaceX
  $B75B,$01 Restore the spawn X from the stack.
  $B75C,$03 Call #R$A002.
  $B75F,$03 Write it to #R$6198(#N$619A).
  $B762,$01 Return.
@ $B763 label=Handler_Bombs_FromRover
  $B763,$03 Fetch #R$6092.
  $B766,$02 Jump to #R$B74B.
@ $B768 label=Handler_Bombs_OffsetLeft
  $B768,$03 Set the offset in #REGbc to #N$FFD0 (-#N$30).
  $B76B,$02 Jump to #R$B75B.
@ $B76D label=Bomb_Actor_Template
B $B76D,$18 Bomb actor template.

c $B785 Collect Bomb
@ $B785 label=CollectBomb
D $B785 On action, mark the bomb carried and play #R$B8BD.
R $B785 IX Actor slot
N $B785 On action, mark the bomb carried and play #R$B8BD.
  $B785,$03 Call #R$945C.
  $B788,$02 Jump to #R$B78E if action is pressed.
  $B78A,$04 Reset bit 7 of the actor flags.
N $B78E Mark the bomb as carried if Jetman can collect it.
@ $B78E label=CollectBomb_TestRange
  $B78E,$03 Call #R$A4E7.
  $B791,$02 Jump to #R$B7A2 if Jetman cannot collect it.
  $B793,$04 Write #N$81 to the actor flags.
  $B797,$03 Fetch #R$6080.
  $B79A,$02,b$01 Set bit 0.
  $B79C,$03 Write it back.
  $B79F,$03 Call #R$B8BD.
@ $B7A2 label=CollectBomb_Loop
  $B7A2,$03 Call #R$B7A8.
  $B7A5,$03 Jump to #R$ABB4.

c $B7A8 Handler: Bomb
@ $B7A8 label=Handler_Bomb
D $B7A8 Steps the bomb through its four sprite frames and flips bit 0 of
. #REGix+#N$07.
R $B7A8 IX Animation object
N $B7A8 Animate the sprite.
  $B7A8,$03 #REGa=*#REGix+#N$00.
  $B7AB,$01 Increment #REGa by one.
N $B7AC The bomb has four frames of animation.
  $B7AC,$02,b$01 Keep only bits 0-1.
N $B7AE With sprite IDs beginning from #R$EE17(#N$EC) (#SPRITENAME$EC).
  $B7AE,$02 #REGa=#REGa+#N$EC.
  $B7B0,$03 Write #REGa back to *#REGix+#N$00.
  $B7B3,$03 #REGa=*#REGix+#N$07.
  $B7B6,$02,b$01 Flip bit 0.
  $B7B8,$03 Write #REGa back to *#REGix+#N$07.
  $B7BB,$01 Return.

c $B7BC Carry Bomb
@ $B7BC label=CarryBomb
D $B7BC Stick the bomb to Jetman, or on action drop it with his
. current X speed and play #R$B8C3.
R $B7BC IX Actor slot
N $B7BC Stick the bomb to Jetman, or drop it on action.
  $B7BC,$03 Call #R$945C.
  $B7BF,$02 Jump to #R$B7DE if action is pressed.
  $B7C1,$04 Reset bit 7 of the actor flags.
@ $B7C5 label=CarryBomb_Loop
N $B7C5 Keep the bomb under Jetman.
  $B7C5,$03 Fetch #R$607A.
  $B7C8,$03 Write the low world X.
  $B7CB,$03 Write the high world X.
  $B7CE,$03 Fetch #R$607C.
  $B7D1,$02 Add #N$10.
  $B7D3,$04 Jump to #R$B7D9 if it is still above the ground
. line.
N $B7D7 #N$AF is the ground line.
  $B7D7,$02 #REGa=#N$AF.
@ $B7D9 label=CarryBomb_WriteY
  $B7D9,$03 Write the actor Y.
  $B7DC,$02 Jump to #R$B7A2.
N $B7DE Drop the bomb, throwing it with a share of Jetman's
. speed unless it is on the ground line.
@ $B7DE label=CarryBomb_TestDrop
  $B7DE,$06 Jump to #R$B7C5 if bit 7 of the actor flags is
. set.
  $B7E4,$03 Fetch the actor Y.
  $B7E7,$04 Jump to #R$B80A if it is on the ground line.
N $B7EB Mark the bomb as thrown with a share of Jetman's speed.
  $B7EB,$04 Write #N$82 to the actor flags.
  $B7EF,$03 Fetch #R$607D.
  $B7F2,$08 Divide it by #N$10.
  $B7FA,$03 Write it as the bomb speed.
N $B7FD Clear bit 0 of Jetman's flags and play the drop sound.
@ $B7FD label=CarryBomb_ClearCarrying
  $B7FD,$03 Fetch #R$6080.
  $B800,$02,b$01 Clear bit 0.
  $B802,$03 Write it back.
  $B805,$03 Call #R$B8C3.
  $B808,$02 Jump to #R$B7A2.
@ $B80A label=CarryBomb_OnGround
  $B80A,$04 Write #N$80 to the actor flags.
  $B80E,$02 Jump to #R$B7FD.

c $B810 Fly Thrown Bomb
@ $B810 label=FlyThrownBomb
D $B810 Move the bomb by its speed. A hit on the alien base scores
. #N$3000 and writes #N$01 to #R$6195.
R $B810 IX Actor slot
N $B810 Move the thrown bomb by its speed.
  $B810,$03 Call #R$B89A.
  $B813,$03 Fetch #R$5EA3.
  $B816,$03 Jump to #R$B81E if it is not zero.
  $B819,$03 Call #R$A4BA.
  $B81C,$02 Jump to #R$B848 if the bomb is close to the rover.
N $B81E Move the bomb along and check the ground line.
@ $B81E label=FlyThrownBomb_Move
  $B81E,$03 Call #R$B6AE.
  $B821,$04 Jump to #R$B83C if the new Y is on or below the
. ground line.
N $B825 Test the bomb against the alien base.
  $B825,$03 Write the actor Y.
  $B828,$03 Call #R$B854.
  $B82B,$03 Jump to #R$B7A2 if the bomb missed the base.
N $B82E Turn the object slots into craters and explosions and record
. the hit on the base.
  $B82E,$03 Call #R$B16F.
  $B831,$05 Write #N$01 to #R$6195.
N $B836 Destroying the alien base adds #N$3000 points.
  $B836,$03 Set the points to award in #REGbc to #N$3000.
  $B839,$03 Call #R$899C.
N $B83C Put the bomb on the ground line and change its type
. to #N$C0.
@ $B83C label=FlyThrownBomb_Land
  $B83C,$04 Write #N$AF to the actor Y.
  $B840,$03 Call #R$ABB4.
N $B843 "#SPRITENAME$C0".
  $B843,$04 Write type #N$C0.
  $B847,$01 Return.
N $B848 Flag the bomb as collected by the rover.
@ $B848 label=FlyThrownBomb_CollectRover
  $B848,$04 Set bit 2 of the actor flags.
  $B84C,$05 Write #N$01 to #R$5EA3.
  $B851,$03 Jump to #R$ABB4.
N $B854 Test the bomb against the alien-base slot.
@ $B854 label=FlyThrownBomb_TestBase
  $B854,$02 #REGe=#N$18.
  $B856,$03 Fetch the bomb world X.
  $B859,$03 Fetch the high byte.
  $B85C,$04 Add a #N$18 window.
  $B860,$04 Fetch #R$6182.
  $B864,$03 Subtract the alien base world X.
  $B867,$01 Copy the high byte of the difference.
  $B868,$02,b$01 Keep only bits 0-4.
  $B86A,$01 Return if the result is not zero.
  $B86B,$01 Copy the low byte of the difference.
  $B86C,$03 Return if it is at least #N$20.
  $B86F,$03 Fetch the base Y from #R$6180(#N$6184).
  $B872,$02 Subtract #N$04.
  $B874,$03 Subtract the bomb Y.
  $B877,$03 Jump to #R$B87C if the result is positive.
  $B87A,$02 Negate it.
@ $B87C label=FlyThrownBomb_CompareY
  $B87C,$01 Compare it with the window.
  $B87D,$01 Return.

c $B87E Colourise Rover Lights
@ $B87E label=ColouriseRoverLights
D $B87E Write the rover lamp attributes at #R$BCA9 from the Jetman
. type.
N $B87E Write the rover lamp attributes from the Jetman
. type. Type #N$16 and above is seated facing right.
  $B87E,$03 Fetch #R$6078.
  $B881,$02 Compare it with #N$16.
  $B883,$03 #REGhl=#R$BCA9.
  $B886,$02 Jump to #R$B891 if the type is lower.
N $B888 Write the lamp attributes for type #N$16 and above:
. #COLOUR$57, #COLOUR$57, then #COLOUR$47.
  $B888,$02 #REGa=#COLOUR$57.
  $B88A,$01 Write #REGa to *#REGhl.
  $B88B,$01 Increment #REGhl by one.
  $B88C,$01 Write #REGa to *#REGhl.
  $B88D,$01 Increment #REGhl by one.
  $B88E,$02 Write #COLOUR$47 to *#REGhl.
  $B890,$01 Return.
N $B891 Write the lamp attributes for the lower types:
. #COLOUR$47, #COLOUR$57, then #COLOUR$57.
@ $B891 label=ColouriseRoverLights_OnFoot
  $B891,$02 #REGa=#COLOUR$57.
  $B893,$02 Write #COLOUR$47 to *#REGhl.
  $B895,$01 Increment #REGhl by one.
  $B896,$01 Write #REGa to *#REGhl.
  $B897,$01 Increment #REGhl by one.
  $B898,$01 Write #REGa to *#REGhl.
  $B899,$01 Return.

c $B89A Tick Object Timer
@ $B89A label=TickObjectTimer
D $B89A Decrease *#REGix+#N$11 and, when it hits zero, reload it
. and increase the vertical thrust in *#REGix+#N$06.
R $B89A IX Actor slot
N $B89A Decrease the object timer and increase the thrust on zero.
  $B89A,$03 Decrease *#REGix+#N$11 by one.
  $B89D,$01 Return if the result is not zero.
  $B89E,$03 #REGa=*#REGix+#N$12.
  $B8A1,$03 Write #REGa to *#REGix+#N$11.
  $B8A4,$03 Increment *#REGix+#N$06 by one.
  $B8A7,$01 Return.

c $B8A8 Sounds: Laser Beam
@ $B8A8 label=SoundsLaserBeam
D $B8A8 #HTML(#AUDIO0(laser-beam.wav)(#INCLUDE(LaserBeam)))
E $B8A8 View the equivalent code in;
. #LIST
. { #JETPAC$681E }
. LIST#
  $B8A8,$02 #REGc=#N$08 (pitch).
@ $B8AA label=SoundsLaserBeam_Loop
  $B8AA,$03 Call #R$B8DA.
  $B8AD,$01 Increase the pitch by one.
  $B8AE,$01 Copy it into #REGa.
  $B8AF,$04 Jump back to #R$B8AA if it is not #N$38.
  $B8B3,$01 Return.

c $B8B4 Sounds: Laser Missile Hit
@ $B8B4 label=SoundsLaserMissileHit
D $B8B4 #HTML(#AUDIO0(laser-missile-hit.wav)(#INCLUDE(LaserMissileHit)))
  $B8B4,$02 #REGc=#N$38 (pitch).
@ $B8B6 label=SoundsLaserMissileHit_Loop
  $B8B6,$03 Call #R$B8DA.
  $B8B9,$03 Decrease the pitch by one and jump back to
. #R$B8B6 until it is zero.
  $B8BC,$01 Return.

c $B8BD Sounds: Take Object
@ $B8BD label=SoundsTakeObject
D $B8BD Short tone played when Jetman takes hold of something, such as
. boarding the rover or picking up a platform or a bomb.
.
. #HTML(#AUDIO0(board-rover.wav)(#INCLUDE(BoardRover)))
  $B8BD,$02 #REGd=#N$20 (duration).
  $B8BF,$02 #REGc=#N$50 (pitch).
  $B8C1,$02 Jump to #R$B8CD.

c $B8C3 Sounds: Drop Item
@ $B8C3 label=SoundsDropItem
D $B8C3 Tone played when a carried object is thrown.
.
. #HTML(#AUDIO0(drop-item.wav)(#INCLUDE(DropItem)))
E $B8C3 View the equivalent code in;
. #LIST
. { #ATICATAC$A3C2 }
. LIST#
  $B8C3,$02 #REGd=#N$30 (duration).
  $B8C5,$02 #REGc=#N$40 (pitch).
  $B8C7,$02 Jump to #R$B8CD.

c $B8C9 Sounds: Pickup Item
E $B8C9 View the equivalent code in;
. #LIST
. { #JETPAC$6809 }
. LIST#
@ $B8C9 label=SoundsPickupItem
D $B8C9 #HTML(#AUDIO0(pickup-item.wav)(#INCLUDE(PickupItem)))
  $B8C9,$02 #REGd=#N$40 (duration).
  $B8CB,$02 #REGc=#N$30 (pitch).
@ $B8CD label=SquareWave_Loop
  $B8CD,$03 Call #R$B8DA.
  $B8D0,$03 Decrease the duration by one and jump back to
. #R$B8CD until it is zero.
  $B8D3,$01 Return.

c $B8D4 Sounds: Short Beep
@ $B8D4 label=SoundsShortBeep
D $B8D4 Brief high-pitched square wave.
.
. #HTML(#AUDIO0(short-beep.wav)(#INCLUDE(ShortBeep)))
  $B8D4,$02 #REGd=#N$10 (duration).
  $B8D6,$02 #REGc=#N$60 (pitch).
  $B8D8,$02 Jump to #R$B8CD.

c $B8DA Play Square Wave
@ $B8DA label=PlaySquareWave
D $B8DA Plays one cycle of a square wave through the speaker, with
. #REGc setting the length of each half of the cycle.
R $B8DA C Pitch (length of each half of the wave)
E $B8DA View the equivalent code in;
. #LIST
. { #COOKIE$68B1 }
. { #JETPAC$680D }
. { #PSSST$64AA }
. { #SABREWULF$BF74 }
. { #TRANZAM$614B }
. LIST#
  $B8DA,$03 Copy the pitch into #REGb, then decrease it by one and jump back to
. #R$B8DB until it is zero.
@ $B8DB label=Silence_Loop
  $B8DD,$04 Write #N$10 to port #N$FE to turn the speaker on (bit 4).
  $B8E1,$03 Copy the pitch into #REGb, then decrease it by one and jump back to
. #R$B8E2 until it is zero.
@ $B8E2 label=PlaySquareWave_Loop
  $B8E4,$03 Write #N$00 to port #N$FE to turn the speaker off.
  $B8E7,$01 Return.

c $B8E8 Play Repeated Tone
@ $B8E8 label=PlayRepeatedTone
D $B8E8 Call #R$B8DA, using #REGb as the repeat count.
R $B8E8 B Repeat count
R $B8E8 C Pitch
N $B8E8 Play #R$B8DA using #REGb as the repeat count.
  $B8E8,$01 Copy #REGb into the repeat count.
  $B8E9,$01 Stash #REGbc on the stack.
@ $B8EA label=PlayRepeatedTone_Loop
  $B8EA,$03 Call #R$B8DA.
  $B8ED,$01 Decrease the repeat count by one.
  $B8EE,$02 Jump back to #R$B8EA until it is zero.
  $B8F0,$01 Restore #REGbc from the stack.
  $B8F1,$01 Return.

c $B8F2 Sounds: Debris
@ $B8F2 label=SoundsDebris
D $B8F2 Three clicks pitched from #R$5E7B.
.
. #HTML(#AUDIO0(debris.wav)(#INCLUDE(Debris)))
  $B8F2,$03 Fetch #R$5E7B.
  $B8F5,$01 Copy it into the pitch.
  $B8F6,$02 #REGd=#N$03.
@ $B8F8 label=SoundsDebris_Loop
  $B8F8,$03 Call #R$B8DA.
  $B8FB,$01 Decrease the repeat count by one.
  $B8FC,$02 Jump back to #R$B8F8 until it is zero.
  $B8FE,$01 Return.

c $B8FF Sounds: Explosion
@ $B8FF label=SoundsExplosion
D $B8FF Falling pitch played when an explosion animation ends.
.
. #HTML(#AUDIO0(explosion.wav)(#INCLUDE(Explosion)))
E $B8FF View the equivalent code in;
. #LIST
. { #JETPAC$685F }
. LIST#
N $B8FF Play a falling-pitch explosion, stepping #REGd down from #N$07.
  $B8FF,$02 #REGd=#N$07.
@ $B901 label=SoundsExplosion_Loop
  $B901,$01 Copy the step into #REGa.
  $B902,$01 Convert it to packed BCD.
  $B903,$02,b$01 Flip bits 4-7.
  $B905,$01 Rotate it left.
  $B906,$01 Copy it into the pitch.
N $B907 Mix two bits of #R$5E42 into the pitch to add noise.
  $B907,$03 Fetch #R$5E42.
  $B90A,$03 Rotate it right three times.
  $B90D,$02,b$01 Keep only bits 5-6.
  $B90F,$01 Flip the bits from the pitch.
  $B910,$01 Write the mixed pitch.
N $B911 Play the note, then repeat for the next step.
  $B911,$03 Call #R$B8DA.
  $B914,$01 Decrease the step by one.
  $B915,$02 Jump back to #R$B901 until it is zero.
  $B917,$01 Return.

c $B918 Play Inverted Tone
@ $B918 label=PlayInvertedTone
D $B918 Play #R$B8DA, invert the pitch, and repeat #REGd times.
R $B918 C Pitch
R $B918 D Number of times to repeat
N $B918 Play #R$B8DA, invert the pitch, and repeat #REGd times.
  $B918,$03 Call #R$B8DA.
  $B91B,$01 #REGa=#REGc.
  $B91C,$01 Flip the bits.
  $B91D,$01 #REGc=#REGa.
  $B91E,$01 Decrease #REGd by one.
  $B91F,$02 Jump to #R$B918 until #REGd is zero.
  $B921,$01 Return.

c $B922 Tick Wave Duration
@ $B922 label=TickWaveDuration
D $B922 Decrease the current wave's pitch and finish the effect
. when it reaches zero.
E $B922 Continue on to #R$B92D.
R $B922 IX Sound slot
N $B922 Decrease the current wave pitch and finish if it is zero.
  $B922,$03 Decrease *#REGix+#N$03 by one.
  $B925,$02 Jump to #R$B94B if zero.
  $B927,$03 #REGc=*#REGix+#N$03 (pitch).
  $B92A,$03 #REGd=*#REGix+#N$02 (repeat count).

c $B92D Play Wave Sequence
@ $B92D label=PlayWaveSequence
D $B92D Plays the square wave from #R$B8DA, repeating it #REGd times.
R $B92D C Pitch
R $B92D D Number of times to repeat
E $B92D View the equivalent code in;
. #LIST
. { #SABREWULF$BF6D }
. LIST#
  $B92D,$03 Call #R$B8DA.
  $B930,$01 Decrease #REGd by one.
  $B931,$02 Jump to #R$B92D until #REGd is zero.
  $B933,$01 Return.

c $B934 Tick Wave Table
@ $B934 label=TickWaveTable
D $B934 Actor handler for type #N$A1. Plays one note of a sound whose pitches
. are held in a table, so the sound moves on by one note each time the main
. loop reaches the slot.
.
. The slot is filled by #R$B953 from a template such as #R$B965, and holds:
. #TABLE(default,centre,centre)
. { =h Byte | =h Holds }
. { *#REGix+#N$00 | The actor type, #N$A1. }
. { *#REGix+#N$01 | Counter. Starts at the number of notes plus one. }
. { *#REGix+#N$02 | Address of the pitch table minus one (low byte). }
. { *#REGix+#N$03 | Address of the pitch table minus one (high byte). }
. { *#REGix+#N$04 | Repeat count, i.e. how many times each note is played. }
. TABLE#
.
. The counter is also the index into the pitch table, and it counts down, so
. the table is played backwards: the last pitch is the first one heard. The
. pitch is the half-wave delay used by #R$B8DA, so the larger the value the
. lower the note. When the counter reaches zero the sound ends and the slot
. is freed by #R$B94B.
R $B934 IX Explosion slot (#R$6060)
N $B934 Count down, and end the sound when the table has been played.
  $B934,$03 Decrease the counter in *#REGix+#N$01 by one.
  $B937,$02 Jump to #R$B94B if the counter is now zero.
N $B939 Use the counter as an index into the pitch table to find this
. note. The table address is stored minus one, so that an index of #N$01 picks
. the first byte.
. #TABLE(default,centre,centre,centre,centre)
. { =h Call | =h Counter | =h Address | =h Pitch }
. { #N$01 | #N$07 | #N$B971 | #N$48 }
. { #N$02 | #N$06 | #N$B970 | #N$50 }
. { #N$03 | #N$05 | #N$B96F | #N$58 }
. { #N$04 | #N$04 | #N$B96E | #N$60 }
. { #N$05 | #N$03 | #N$B96D | #N$68 }
. { #N$06 | #N$02 | #N$B96C | #N$70 }
. { #N$07 | #N$01 | #N$B96B | #N$78 }
. { #N$08 | #N$00 | - | The sound ends. }
. TABLE#
. The example above is the template at #R$B965, which starts with a counter
. of #N$08 and a table address of #N$B96A.
  $B939,$05 Set #REGbc to the counter, to use as the index.
  $B93E,$06 Fetch the pitch table address from *#REGix+#N$02 into #REGhl.
  $B944,$01 Add the index to find the pitch for this note.
  $B945,$01 Fetch the pitch into #REGc.
N $B946 Play the note, repeated for the number of times held in the slot.
  $B946,$03 Fetch the repeat count from *#REGix+#N$04 into #REGd.
  $B949,$02 Jump to #R$B92D to play the note #REGd times.

c $B94B End Sound
@ $B94B label=EndSound
D $B94B Ends the sound by clearing the type in the sound slot, which
. frees the slot.
E $B94B View the equivalent code in;
. #LIST
. { #JETPAC$6870 }
. LIST#
R $B94B IX Sound slot
  $B94B,$04 Write #N$00 to *#REGix+#N$00.
  $B94F,$01 Return.

c $B950 Initialise Explosion
@ $B950 label=InitialiseExplosion
D $B950 Copy an 8-byte explosion template into #R$6060, which starts a sound.
. The entry point at #R$B953 takes the template address in #REGhl.
.
. There are five templates. The first is read by #R$B922 (type #N$A5) and the
. other four by #R$B934 (type #N$A1).
  $B950,$03 #REGhl=#R$B95C.
@ $B953 label=InitialiseExplosion_Copy
  $B953,$03 #REGde=#R$6060.
  $B956,$05 Copy #N$08 bytes from #REGhl to #REGde.
  $B95B,$01 Return.
N $B95C Template for #R$B922. It plays one note on each pass, starting from
. the pitch below and counting down to #N$01, so the sound rises over #N$27
. notes. Nothing calls #R$B950, so this one is never used.
. The copy at #R$B953 takes four more bytes than this, which are the first
. instructions at #R$B960, but #R$B922 never reads them.
@ $B95C label=Explosion_Template_1
B $B95C,$01 Actor type, handled by #R$B922.
B $B95D,$01 Not read by #R$B922.
B $B95E,$01 Repeat count: each note is played #N$08 times.
B $B95F,$01 Starting pitch.
@ $B960 label=Copy_Explosion_Template
  $B960,$03 #REGhl=#R$B965.
  $B963,$02 Jump to #R$B953.
N $B965 Template for #R$B934: seven notes of falling pitch, each played
. #N$08 times.
.
. #HTML(#AUDIO0(falling-tone.wav)(#INCLUDE(FallingTone)))
@ $B965 label=Explosion_Template_2
B $B965,$01 Actor type, handled by #R$B934.
B $B966,$01 Counter: a value of #N$08 gives seven notes.
W $B967,$02 Address of the pitch table minus one.
B $B969,$01 Repeat count: each note is played #N$08 times.
B $B96A,$01 Index #N$00 of the pitch table, which is never read.
B $B96B,$07 Pitch table, played from the last byte back to the first.
B $B972,$01 Never played, as the counter reaches zero first.

N $B973
@ $B973 label=InitialiseExplosion_2
  $B973,$03 #REGhl=#R$B978.
  $B976,$02 Jump to #R$B953.
N $B978 Template for #R$B934: seven notes of rising pitch, each played
. #N$10 times.
.
. #HTML(#AUDIO0(rising-tone.wav)(#INCLUDE(RisingTone)))
@ $B978 label=Explosion_Template_Burst
B $B978,$01 Actor type, handled by #R$B934.
B $B979,$01 Counter: a value of #N$08 gives seven notes.
W $B97A,$02 Address of the pitch table minus one.
B $B97C,$01 Repeat count: each note is played #N$10 times.
B $B97D,$01 Index #N$00 of the pitch table, which is never read.
B $B97E,$07 Pitch table, played from the last byte back to the first.
B $B985,$01 Never played, as the counter reaches zero first.

N $B986
@ $B986 label=InitialiseExplosion_3
  $B986,$03 #REGhl=#R$B98B.
  $B989,$02 Jump to #R$B953.
N $B98B Template for #R$B934: fifteen notes that swap between two pitches in
. runs of up to four, each note played #N$06 times.
.
. #HTML(#AUDIO0(warble.wav)(#INCLUDE(Warble)))
@ $B98B label=Explosion_Template_3
B $B98B,$01 Actor type, handled by #R$B934.
B $B98C,$01 Counter: a value of #N$10 gives fifteen notes.
W $B98D,$02 Address of the pitch table minus one.
B $B98F,$01 Repeat count: each note is played #N$06 times.
B $B990,$01 Index #N$00 of the pitch table, which is never read.
B $B991,$0F Pitch table, played from the last byte back to the first.
B $B9A0,$01 Never played, as the counter reaches zero first.

N $B9A1
@ $B9A1 label=InitialiseExplosion_4
  $B9A1,$03 #REGhl=#R$B9A6.
  $B9A4,$02 Jump to #R$B953.
N $B9A6 Template for #R$B934: fifteen notes of falling pitch, each played
. #N$06 times.
.
. #HTML(#AUDIO0(falling-slide.wav)(#INCLUDE(FallingSlide)))
@ $B9A6 label=Explosion_Template_4
B $B9A6,$01 Actor type, handled by #R$B934.
B $B9A7,$01 Counter: a value of #N$10 gives fifteen notes.
W $B9A8,$02 Address of the pitch table minus one.
B $B9AA,$01 Repeat count: each note is played #N$06 times.
B $B9AB,$01 Index #N$00 of the pitch table, which is never read.
B $B9AC,$0F Pitch table, played from the last byte back to the first.
B $B9BB,$01 Never played, as the counter reaches zero first.

c $B9BC Queue Tune
@ $B9BC label=QueueTune
D $B9BC Copy a bit-7-terminated tune from #REGde into the sound
. buffer, working downwards from #R$FF51.
R $B9BC DE Tune data
N $B9BC Copy a bit-7-terminated tune from #REGde into the buffer.
  $B9BC,$01 Disable interrupts.
  $B9BD,$03 #REGhl=#R$FF51.
@ $B9C0 label=QueueTune_Copy
N $B9C0 Copy bytes until bit 7 marks the terminator.
  $B9C0,$01 #REGa=*#REGde.
  $B9C1,$01 Increment #REGde by one.
  $B9C2,$04 Jump to #R$B9CA if bit 7 of #REGa is set.
  $B9C6,$01 Write #REGa to *#REGhl.
  $B9C7,$01 Decrease #REGhl by one.
  $B9C8,$02 Jump to #R$B9C0.
N $B9CA Store the terminator byte with bit 7 cleared.
@ $B9CA label=QueueTune_Terminator
  $B9CA,$02,b$01 Keep only bits 0-6.
  $B9CC,$01 Write #REGa to *#REGhl.
N $B9CD Save the buffer pointer and enable interrupts.
  $B9CD,$03 Write #REGhl to #R$FF54.
  $B9D0,$01 Enable interrupts.
  $B9D1,$01 Return.

b $B9D2 Tune Data
@ $B9D2 label=Tune_Game_Over
D $B9D2 Note lists queued by #R$B9BC. Bit 7 of a byte
. marks the terminator.
B $B9D2,$08
N $B9DA
@ $B9DA label=Tune_Laser_Estimate
B $B9DA,$14
N $B9EE
@ $B9EE label=Tune_1UP
B $B9EE,$0E
N $B9FC
@ $B9FC label=Tune_2UP
B $B9FC,$0D
N $BA09
@ $BA09 label=Tune_Menu_1
B $BA09,$06
N $BA0F
@ $BA0F label=Tune_Menu_2
B $BA0F,$0E
N $BA1D
@ $BA1D label=Tune_Menu_3
B $BA1D,$0D
N $BA2A
@ $BA2A label=Tune_Briefing
B $BA2A,$03
N $BA2D
@ $BA2D label=Tune_Out_Of_Fuel
B $BA2D,$08
N $BA35
@ $BA35 label=Tune_Start_Game
B $BA35,$09
N $BA3E
@ $BA3E label=Tune_Jingle_1
B $BA3E,$15
N $BA53
@ $BA53 label=Tune_Jingle_2
B $BA53,$0B
N $BA5E
@ $BA5E label=Tune_Jingle_3
B $BA5E,$11
N $BA6F
@ $BA6F label=Tune_Jingle_4
B $BA6F,$0B
N $BA7A
@ $BA7A label=Tune_Jingle_5
B $BA7A,$09
N $BA83
@ $BA83 label=Tune_Jingle_6
B $BA83,$05
N $BA88
@ $BA88 label=Tune_Jingle_7
B $BA88,$16

w $BA9E Menu Tune Table
@ $BA9E label=Menu_Tune_Table
D $BA9E Pointers to #R$BA09, #R$BA0F and #R$BA1D.
W $BA9E,$06,$02

w $BAA4 Player Tune Table
@ $BAA4 label=Player_Tune_Table
D $BAA4 Pointers to the 1UP and 2UP jingles.
W $BAA4,$04,$02

b $BAA8 Tune Data Extra
@ $BAA8 label=Tune_Extra_1
D $BAA8 Two short tunes immediately before the sprite
. table.
B $BAA8,$0C
@ $BAB4 label=Tune_Extra_2
B $BAB4,$0A

w $BABE Sprite Table Origin
@ $BABE label=Sprite_Table_Origin
D $BABE Word before #R$BAC0 so sprite IDs are 1-based.

w $BAC0 Sprite Table
@ $BAC0 label=SpritesTable
E $BAC0 View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #JETPAC$6945 }
. { #PSSST$761A }
. LIST#
  $BAC0,$02 Sprite ID: #R(#PEEK(#PC)+#PEEK(#PC+$01)*$100)(#N((#PC-$BABE)/$02)) #SPRITENAME((#PC-$BABE)/$02).
L $BAC0,$02,$EF

b $BC9E Graphic: Moon Rover Attributes
@ $BC9E label=Graphic_Moon_Rover_Attributes
D $BC9E Colour block painted over the moon rover by #R$890A. A width and
. height in attribute cells, then one colour byte per cell, row by row.
. The three lamp colours at #R$BCA9 are rewritten by #R$B87E.
  $BC9E,$01 Width = #N(#PEEK(#PC)) columns.
  $BC9F,$01 Height = #N(#PEEK(#PC)) rows.
  $BCA0,$09,$07
@ $BCA9 label=Rover_Lamp_Attributes
B $BCA9,$13

b $BCBC Sprite: None
@ $BCBC label=Sprite_None
  $BCBC,$01 Width = #N(#PEEK(#PC)) bytes.
  $BCBD,$01 Height = #N(#PEEK(#PC)) pixels.

b $BCBE Sprite: Jetman Walking
@ $BCBE label=Sprite_Jetman_Walking_1
N $BCBE Walking left frame 1.
  $BCBE,$01 Height = #N(#PEEK(#PC)) pixels.
  $BCBF,$2C,$02 #SPRITE$09(jetman-walk-left-01*)

N $BCEB Walking left frame 2.
@ $BCEB label=Sprite_Jetman_Walking_2
  $BCEB,$01 Height = #N(#PEEK(#PC)) pixels.
  $BCEC,$2C,$02 #SPRITE$0A(jetman-walk-left-02*)

N $BD18 Walking left frame 3.
@ $BD18 label=Sprite_Jetman_Walking_3
  $BD18,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD19,$2C,$02 #SPRITE$0B(jetman-walk-left-03*)

N $BD45 Walking right frame 1.
@ $BD45 label=Sprite_Jetman_Walking_4
  $BD45,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD46,$2C,$02 #SPRITE$0D(jetman-walk-right-01*)

N $BD72 Walking right frame 2.
@ $BD72 label=Sprite_Jetman_Walking_5
  $BD72,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD73,$2C,$02 #SPRITE$0E(jetman-walk-right-02*)

N $BD9F Walking right frame 3.
@ $BD9F label=Sprite_Jetman_Walking_6
  $BD9F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BDA0,$2C,$02 #SPRITE$0F(jetman-walk-right-03*)

b $BDCC Sprite: Jetman Flying
@ $BDCC label=Sprite_Jetman_Flying_1
N $BDCC Flying left frame 1.
  $BDCC,$01 Height = #N(#PEEK(#PC)) pixels.
  $BDCD,$30,$02 #SPRITE$01(jetman-fly-left-01)

N $BDFD Flying left frame 2.
@ $BDFD label=Sprite_Jetman_Flying_2
  $BDFD,$01 Height = #N(#PEEK(#PC)) pixels.
  $BDFE,$30,$02 #SPRITE$02(jetman-fly-left-02)

N $BE2E Flying right frame 1.
@ $BE2E label=Sprite_Jetman_Flying_3
  $BE2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $BE2F,$30,$02 #SPRITE$05(jetman-fly-right-01)

N $BE5F Flying right frame 2.
@ $BE5F label=Sprite_Jetman_Flying_4
  $BE5F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BE60,$30,$02 #SPRITE$06(jetman-fly-right-02)

b $BE90 Graphic: Moon Rover
@ $BE90 label=Graphic_Moon_Rover_Right_1
N $BE90 Right frame 1.
  $BE90,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $BE91,$01 Height = #N(#PEEK(#PC)) pixels.
  $BE92,$BD,$07 #GRAPHIC$16(rover-right-01)

N $BF4F Right frame 2.
@ $BF4F label=Graphic_Moon_Rover_Right_2
  $BF4F,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $BF50,$01 Height = #N(#PEEK(#PC)) pixels.
  $BF51,$BD,$07 #GRAPHIC$17(rover-right-02)

N $C00E Right frame 3.
@ $C00E label=Graphic_Moon_Rover_Right_3
  $C00E,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C00F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C010,$BD,$07 #GRAPHIC$18(rover-right-03)

N $C0CD Right frame 4.
@ $C0CD label=Graphic_Moon_Rover_Right_4
  $C0CD,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C0CE,$01 Height = #N(#PEEK(#PC)) pixels.
  $C0CF,$BD,$07 #GRAPHIC$19(rover-right-04)

N $C18C Right frame 5.
@ $C18C label=Graphic_Moon_Rover_Right_5
  $C18C,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C18D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C18E,$D8,$08 #GRAPHIC$23(rover-right-05)

N $C266 Right frame 6.
@ $C266 label=Graphic_Moon_Rover_Right_6
  $C266,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C267,$01 Height = #N(#PEEK(#PC)) pixels.
  $C268,$D8,$08 #GRAPHIC$24(rover-right-06)

N $C340 Right frame 7.
@ $C340 label=Graphic_Moon_Rover_Right_7
  $C340,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C341,$01 Height = #N(#PEEK(#PC)) pixels.
  $C342,$D8,$08 #GRAPHIC$25(rover-right-07)

N $C41A Right frame 8.
@ $C41A label=Graphic_Moon_Rover_Right_8
  $C41A,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C41B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C41C,$D8,$08 #GRAPHIC$26(rover-right-08)

N $C4F4 Right frame 9.
@ $C4F4 label=Graphic_Moon_Rover_Right_9
  $C4F4,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C4F5,$01 Height = #N(#PEEK(#PC)) pixels.
  $C4F6,$D8,$08 #GRAPHIC$27(rover-right-09)

N $C5CE Right frame 10.
@ $C5CE label=Graphic_Moon_Rover_Right_10
  $C5CE,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C5CF,$01 Height = #N(#PEEK(#PC)) pixels.
  $C5D0,$D8,$08 #GRAPHIC$28(rover-right-10)

N $C6A8 Right frame 11.
@ $C6A8 label=Graphic_Moon_Rover_Right_11
  $C6A8,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C6A9,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6AA,$D8,$08 #GRAPHIC$29(rover-right-11)

N $C782 Left frame 1.
@ $C782 label=Graphic_Moon_Rover_Left_1
  $C782,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C783,$01 Height = #N(#PEEK(#PC)) pixels.
  $C784,$BD,$07 #GRAPHIC$15(rover-left-04*)

N $C841 Left frame 2.
@ $C841 label=Graphic_Moon_Rover_Left_2
  $C841,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C842,$01 Height = #N(#PEEK(#PC)) pixels.
  $C843,$BD,$07 #GRAPHIC$14(rover-left-03*)

N $C900 Left frame 3.
@ $C900 label=Graphic_Moon_Rover_Left_3
  $C900,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C901,$01 Height = #N(#PEEK(#PC)) pixels.
  $C902,$BD,$07 #GRAPHIC$13(rover-left-02*)

N $C9BF Left frame 4.
@ $C9BF label=Graphic_Moon_Rover_Left_4
  $C9BF,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $C9C0,$01 Height = #N(#PEEK(#PC)) pixels.
  $C9C1,$BD,$07 #GRAPHIC$12(rover-left-01*)

N $CA7E Left frame 5.
@ $CA7E label=Graphic_Moon_Rover_Left_5
  $CA7E,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CA7F,$01 Height = #N(#PEEK(#PC)) pixels.
  $CA80,$D8,$08 #GRAPHIC$1B(rover-left-05)

N $CB58 Left frame 6.
@ $CB58 label=Graphic_Moon_Rover_Left_6
  $CB58,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CB59,$01 Height = #N(#PEEK(#PC)) pixels.
  $CB5A,$D8,$08 #GRAPHIC$1C(rover-left-06)

N $CC32 Left frame 7.
@ $CC32 label=Graphic_Moon_Rover_Left_7
  $CC32,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CC33,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC34,$D8,$08 #GRAPHIC$1D(rover-left-07)

N $CD0C Left frame 8.
@ $CD0C label=Graphic_Moon_Rover_Left_8
  $CD0C,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CD0D,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD0E,$D8,$08 #GRAPHIC$1E(rover-left-08)

N $CDE6 Left frame 9.
@ $CDE6 label=Graphic_Moon_Rover_Left_9
  $CDE6,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CDE7,$01 Height = #N(#PEEK(#PC)) pixels.
  $CDE8,$D8,$08 #GRAPHIC$1F(rover-left-09)

N $CEC0 Left frame 10.
@ $CEC0 label=Graphic_Moon_Rover_Left_10
  $CEC0,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CEC1,$01 Height = #N(#PEEK(#PC)) pixels.
  $CEC2,$D8,$08 #GRAPHIC$20(rover-left-10)

N $CF9A Left frame 11.
@ $CF9A label=Graphic_Moon_Rover_Left_11
  $CF9A,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $CF9B,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF9C,$D8,$08 #GRAPHIC$21(rover-left-11)

b $D074 Sprite: Teleporter
@ $D074 label=Sprite_Teleporter_1
E $D074 #UDGTABLE(default) { #FRAMES(teleporter-01,15;teleporter-02;teleporter-03;teleporter-04)(teleporter) } UDGTABLE#
N $D074 Frame 1.
  $D074,$01 Height = #N(#PEEK(#PC)) pixels.
  $D075,$36,$02 #SPRITE$2A(teleporter-01*)

N $D0AB Frame 2.
@ $D0AB label=Sprite_Teleporter_2
  $D0AB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D0AC,$36,$02 #SPRITE$2B(teleporter-02*)

N $D0E2 Frame 3.
@ $D0E2 label=Sprite_Teleporter_3
  $D0E2,$01 Height = #N(#PEEK(#PC)) pixels.
  $D0E3,$36,$02 #SPRITE$2C(teleporter-03*)

N $D119 Frame 4.
@ $D119 label=Sprite_Teleporter_4
  $D119,$01 Height = #N(#PEEK(#PC)) pixels.
  $D11A,$36,$02 #SPRITE$2D(teleporter-04*)

u $D150 Unused
@ $D150 label=Unused_Before_Lives_Icon
B $D150,$01

b $D151 The UDG for the lives icon
@ $D151 label=UDG_Life
  $D151,$08,b$01 #UDGTABLE(default,centre) { #UDG#(#PC),attr=$07 } UDGTABLE#

b $D159 Sprite: Player Shot
@ $D159 label=Sprite_Player_Shot_1
N $D159 Frame 1.
  $D159,$01 Height = #N(#PEEK(#PC)) pixels.
  $D15A,$06,$01 #SPRITE$5A,$BAC0,$01(sprite-5a)

N $D160 Frame 2.
@ $D160 label=Sprite_Player_Shot_2
  $D160,$01 Height = #N(#PEEK(#PC)) pixels.
  $D161,$06,$01 #SPRITE$5B,$BAC0,$01(sprite-5b)

b $D167 Sprite: Turret
@ $D167 label=Sprite_Turret_1
N $D167 Left frame 1.
  $D167,$01 Height = #N(#PEEK(#PC)) pixels.
  $D168,$16,$02 #SPRITE$30(turret-left-01)

N $D17E Left frame 2.
@ $D17E label=Sprite_Turret_2
  $D17E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D17F,$16,$02 #SPRITE$31(turret-left-02)

N $D195 Left frame 3.
@ $D195 label=Sprite_Turret_3
  $D195,$01 Height = #N(#PEEK(#PC)) pixels.
  $D196,$18,$02 #SPRITE$32(turret-left-03)

N $D1AE Left frame 4.
@ $D1AE label=Sprite_Turret_4
  $D1AE,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1AF,$1C,$02 #SPRITE$33(turret-left-04)

N $D1CB Left frame 5.
@ $D1CB label=Sprite_Turret_5
  $D1CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1CC,$1E,$02 #SPRITE$34(turret-left-05)

N $D1EA Left frame 6.
@ $D1EA label=Sprite_Turret_6
  $D1EA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1EB,$22,$02 #SPRITE$35(turret-left-06)

N $D20D Left frame 7.
@ $D20D label=Sprite_Turret_7
  $D20D,$01 Height = #N(#PEEK(#PC)) pixels.
  $D20E,$24,$02 #SPRITE$36(turret-left-07)

N $D232 Left frame 8.
@ $D232 label=Sprite_Turret_8
  $D232,$01 Height = #N(#PEEK(#PC)) pixels.
  $D233,$24,$02 #SPRITE$37(turret-left-08)

N $D257 Right frame 1.
@ $D257 label=Sprite_Turret_9
  $D257,$01 Height = #N(#PEEK(#PC)) pixels.
  $D258,$16,$02 #SPRITE$38(turret-right-01)

N $D26E Right frame 2.
@ $D26E label=Sprite_Turret_10
  $D26E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D26F,$16,$02 #SPRITE$39(turret-right-02)

N $D285 Right frame 3.
@ $D285 label=Sprite_Turret_11
  $D285,$01 Height = #N(#PEEK(#PC)) pixels.
  $D286,$18,$02 #SPRITE$3A(turret-right-03)

N $D29E Right frame 4.
@ $D29E label=Sprite_Turret_12
  $D29E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D29F,$1C,$02 #SPRITE$3B(turret-right-04)

N $D2BB Right frame 5.
@ $D2BB label=Sprite_Turret_13
  $D2BB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2BC,$1E,$02 #SPRITE$3C(turret-right-05)

N $D2DA Right frame 6.
@ $D2DA label=Sprite_Turret_14
  $D2DA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2DB,$22,$02 #SPRITE$3D(turret-right-06)

N $D2FD Right frame 7.
@ $D2FD label=Sprite_Turret_15
  $D2FD,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2FE,$24,$02 #SPRITE$3E(turret-right-07)

N $D322 Right frame 8.
@ $D322 label=Sprite_Turret_16
  $D322,$01 Height = #N(#PEEK(#PC)) pixels.
  $D323,$24,$02 #SPRITE$3F(turret-right-08)

b $D347 Main Font
@ $D347 label=MainFont
  $D347,$08 #UDG(#PC)
L $D347,$08,$4B
@ $D51F label=Font_Gradient

b $D59F Sprite: The Blob
@ $D59F label=Sprite_The_Blob_1
D $D59F The Blob appears from level 4 onwards.
N $D59F Frame 1.
  $D59F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5A0,$20,$02 #SPRITE$48(blob-01*)

N $D5C0 Frame 2.
@ $D5C0 label=Sprite_The_Blob_2
  $D5C0,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5C1,$20,$02 #SPRITE$49(blob-02*)

N $D5E1 Frame 3.
@ $D5E1 label=Sprite_The_Blob_3
  $D5E1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5E2,$20,$02 #SPRITE$4A(blob-03*)

N $D602 Frame 4.
@ $D602 label=Sprite_The_Blob_4
  $D602,$01 Height = #N(#PEEK(#PC)) pixels.
  $D603,$1C,$02 #SPRITE$4B(blob-04*)

N $D61F Frame 5.
@ $D61F label=Sprite_The_Blob_5
  $D61F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D620,$18,$02 #SPRITE$4C(blob-05*)

N $D638 Frame 6.
@ $D638 label=Sprite_The_Blob_6
  $D638,$01 Height = #N(#PEEK(#PC)) pixels.
  $D639,$1C,$02 #SPRITE$4D(blob-06*)

N $D655 Frame 7.
@ $D655 label=Sprite_The_Blob_7
  $D655,$01 Height = #N(#PEEK(#PC)) pixels.
  $D656,$20,$02 #SPRITE$4E(blob-07*)

N $D676 Frame 8.
@ $D676 label=Sprite_The_Blob_8
  $D676,$01 Height = #N(#PEEK(#PC)) pixels.
  $D677,$20,$02 #SPRITE$4F(blob-08*)

b $D697 Sprite: Meteor
@ $D697 label=Sprite_Meteor_1
D $D697 Meteors appear from level 1 onwards.
E $D697 #UDGTABLE(default) { #FRAMES(meteor-01,15;meteor-02;meteor-03;meteor-04;meteor-05;meteor-06;meteor-07;meteor-08)(meteor) } UDGTABLE#
N $D697 Frame 1.
  $D697,$01 Height = #N(#PEEK(#PC)) pixels.
  $D698,$20,$02 #SPRITE$50(meteor-01*)

N $D6B8 Frame 2.
@ $D6B8 label=Sprite_Meteor_2
  $D6B8,$01 Height = #N(#PEEK(#PC)) pixels.
  $D6B9,$20,$02 #SPRITE$51(meteor-02*)

N $D6D9 Frame 3.
@ $D6D9 label=Sprite_Meteor_3
  $D6D9,$01 Height = #N(#PEEK(#PC)) pixels.
  $D6DA,$20,$02 #SPRITE$52(meteor-03*)

N $D6FA Frame 4.
@ $D6FA label=Sprite_Meteor_4
  $D6FA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D6FB,$20,$02 #SPRITE$53(meteor-04*)

N $D71B Frame 5.
@ $D71B label=Sprite_Meteor_5
  $D71B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D71C,$20,$02 #SPRITE$54(meteor-05*)

N $D73C Frame 6.
@ $D73C label=Sprite_Meteor_6
  $D73C,$01 Height = #N(#PEEK(#PC)) pixels.
  $D73D,$20,$02 #SPRITE$55(meteor-06*)

N $D75D Frame 7.
@ $D75D label=Sprite_Meteor_7
  $D75D,$01 Height = #N(#PEEK(#PC)) pixels.
  $D75E,$20,$02 #SPRITE$56(meteor-07*)

N $D77E Frame 8.
@ $D77E label=Sprite_Meteor_8
  $D77E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D77F,$20,$02 #SPRITE$57(meteor-08*)

b $D79F Sprite: Sparkle Burst
@ $D79F label=Sprite_SparkleBurst_1
D $D79F Explosion animation for a destroyed alien or missile.
N $D79F Frame 1.
  $D79F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7A0,$12,$02 #SPRITE$5C(sparkle-burst-01*)

N $D7B2 Frame 2.
@ $D7B2 label=Sprite_SparkleBurst_2
  $D7B2,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7B3,$18,$02 #SPRITE$5D(sparkle-burst-02*)

N $D7CB Frame 3.
@ $D7CB label=Sprite_SparkleBurst_3
  $D7CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7CC,$20,$02 #SPRITE$5E(sparkle-burst-03*)

N $D7EC Frame 4.
@ $D7EC label=Sprite_SparkleBurst_4
  $D7EC,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7ED,$20,$02 #SPRITE$5F(sparkle-burst-04*)

N $D80D Frame 5.
@ $D80D label=Sprite_SparkleBurst_5
  $D80D,$01 Height = #N(#PEEK(#PC)) pixels.
  $D80E,$20,$02 #SPRITE$60(sparkle-burst-05*)

N $D82E Frame 6.
@ $D82E label=Sprite_SparkleBurst_6
  $D82E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D82F,$20,$02 #SPRITE$61(sparkle-burst-06*)

N $D84F Frame 7.
@ $D84F label=Sprite_SparkleBurst_7
  $D84F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D850,$20,$02 #SPRITE$62(sparkle-burst-07*)

b $D870 Sprite: Player Shot
@ $D870 label=Sprite_Player_Shot_3
N $D870 Frame 1.
  $D870,$01 Height = #N(#PEEK(#PC)) pixels.
  $D871,$05,$01 #SPRITE$58,$BAC0,$01(sprite-58)

N $D876 Frame 2.
@ $D876 label=Sprite_Player_Shot_4
  $D876,$01 Height = #N(#PEEK(#PC)) pixels.
  $D877,$07,$01 #SPRITE$59,$BAC0,$01(sprite-59)

b $D87E Sprite: Small Explosion
@ $D87E label=Sprite_Small_Explosion_1
D $D87E Frames used by #R$A73C. Type #N$66 reuses frame 1.
N $D87E Frame 1.
  $D87E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D87F,$09,$01 #SPRITE$64,$BAC0,$01(small-explosion-01)

N $D888 Frame 2.
@ $D888 label=Sprite_Small_Explosion_2
  $D888,$01 Height = #N(#PEEK(#PC)) pixels.
  $D889,$0B,$01 #SPRITE$65,$BAC0,$01(small-explosion-02)

b $D894 Sprite: Mr Magnetic Brella
@ $D894 label=Sprite_Mr_Magnetic_Brella_1
D $D894 Mr Magnetic Brella appears from level 6 onwards.
N $D894 Frame 1.
  $D894,$01 Height = #N(#PEEK(#PC)) pixels.
  $D895,$20,$02 #SPRITE$40(brella-01*)

N $D8B5 Frame 2.
@ $D8B5 label=Sprite_Mr_Magnetic_Brella_2
  $D8B5,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8B6,$1E,$02 #SPRITE$41(brella-02*)

N $D8D4 Frame 3.
@ $D8D4 label=Sprite_Mr_Magnetic_Brella_3
  $D8D4,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8D5,$1C,$02 #SPRITE$42(brella-03*)

N $D8F1 Frame 4.
@ $D8F1 label=Sprite_Mr_Magnetic_Brella_4
  $D8F1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8F2,$1A,$02 #SPRITE$43(brella-04*)

N $D90C Frame 5.
@ $D90C label=Sprite_Mr_Magnetic_Brella_5
  $D90C,$01 Height = #N(#PEEK(#PC)) pixels.
  $D90D,$18,$02 #SPRITE$44(brella-05*)

N $D925 Frame 6.
@ $D925 label=Sprite_Mr_Magnetic_Brella_6
  $D925,$01 Height = #N(#PEEK(#PC)) pixels.
  $D926,$16,$02 #SPRITE$45(brella-06*)

N $D93C Frame 7.
@ $D93C label=Sprite_Mr_Magnetic_Brella_7
  $D93C,$01 Height = #N(#PEEK(#PC)) pixels.
  $D93D,$1A,$02 #SPRITE$46(brella-07*)

N $D957 Frame 8.
@ $D957 label=Sprite_Mr_Magnetic_Brella_8
  $D957,$01 Height = #N(#PEEK(#PC)) pixels.
  $D958,$1E,$02 #SPRITE$47(brella-08*)

b $D976 Sprite: Platform
@ $D976 label=Sprite_Platform
  $D976,$01 Height = #N(#PEEK(#PC)) pixels.
  $D977,$10,$02 #SPRITE$2E(platform)

b $D987 Sprite: Missile Launcher
@ $D987 label=Sprite_Missile_Launcher_1
E $D987 #UDGTABLE(default) { #FRAMES(missile-launcher-01,15;missile-launcher-02;missile-launcher-03;missile-launcher-04;missile-launcher-05;missile-launcher-06;missile-launcher-07;missile-launcher-08;missile-launcher-09;missile-launcher-10;missile-launcher-11;missile-launcher-12;missile-launcher-13;missile-launcher-14;missile-launcher-15;missile-launcher-16)(missile-launcher) } UDGTABLE#
N $D987 Frame 1.
  $D987,$01 Height = #N(#PEEK(#PC)) pixels.
  $D988,$40,$02 #SPRITE$70(missile-launcher-01*)

N $D9C8 Frame 2.
@ $D9C8 label=Sprite_Missile_Launcher_2
  $D9C8,$01 Height = #N(#PEEK(#PC)) pixels.
  $D9C9,$40,$02 #SPRITE$71(missile-launcher-02*)

N $DA09 Frame 3.
@ $DA09 label=Sprite_Missile_Launcher_3
  $DA09,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA0A,$40,$02 #SPRITE$72(missile-launcher-03*)

N $DA4A Frame 4.
@ $DA4A label=Sprite_Missile_Launcher_4
  $DA4A,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA4B,$40,$02 #SPRITE$73(missile-launcher-04*)

N $DA8B Frame 5.
@ $DA8B label=Sprite_Missile_Launcher_5
  $DA8B,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA8C,$40,$02 #SPRITE$74(missile-launcher-05*)

N $DACC Frame 6.
@ $DACC label=Sprite_Missile_Launcher_6
  $DACC,$01 Height = #N(#PEEK(#PC)) pixels.
  $DACD,$40,$02 #SPRITE$75(missile-launcher-06*)

N $DB0D Frame 7.
@ $DB0D label=Sprite_Missile_Launcher_7
  $DB0D,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB0E,$40,$02 #SPRITE$76(missile-launcher-07*)

N $DB4E Frame 8.
@ $DB4E label=Sprite_Missile_Launcher_8
  $DB4E,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB4F,$40,$02 #SPRITE$77(missile-launcher-08*)

N $DB8F Frame 9.
@ $DB8F label=Sprite_Missile_Launcher_9
  $DB8F,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB90,$40,$02 #SPRITE$78(missile-launcher-09*)

N $DBD0 Frame 10.
@ $DBD0 label=Sprite_Missile_Launcher_10
  $DBD0,$01 Height = #N(#PEEK(#PC)) pixels.
  $DBD1,$40,$02 #SPRITE$79(missile-launcher-10*)

N $DC11 Frame 11.
@ $DC11 label=Sprite_Missile_Launcher_11
  $DC11,$01 Height = #N(#PEEK(#PC)) pixels.
  $DC12,$40,$02 #SPRITE$7A(missile-launcher-11*)

N $DC52 Frame 12.
@ $DC52 label=Sprite_Missile_Launcher_12
  $DC52,$01 Height = #N(#PEEK(#PC)) pixels.
  $DC53,$40,$02 #SPRITE$7B(missile-launcher-12*)

N $DC93 Frame 13.
@ $DC93 label=Sprite_Missile_Launcher_13
  $DC93,$01 Height = #N(#PEEK(#PC)) pixels.
  $DC94,$40,$02 #SPRITE$7C(missile-launcher-13*)

N $DCD4 Frame 14.
@ $DCD4 label=Sprite_Missile_Launcher_14
  $DCD4,$01 Height = #N(#PEEK(#PC)) pixels.
  $DCD5,$40,$02 #SPRITE$7D(missile-launcher-14*)

N $DD15 Frame 15.
@ $DD15 label=Sprite_Missile_Launcher_15
  $DD15,$01 Height = #N(#PEEK(#PC)) pixels.
  $DD16,$40,$02 #SPRITE$7E(missile-launcher-15*)

N $DD56 Frame 16.
@ $DD56 label=Sprite_Missile_Launcher_16
  $DD56,$01 Height = #N(#PEEK(#PC)) pixels.
  $DD57,$40,$02 #SPRITE$7F(missile-launcher-16*)

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

@ $DED7 label=HUDPanelAttributes_Row2
b $DF13 Graphic: Alien Base
@ $DF13 label=Graphic_Alien_Base_1
N $DF13 Frame 1.
  $DF13,$01 Width = #N(#PEEK(#PC)) bytes.
  $DF14,$01 Height = #N(#PEEK(#PC)) pixels.
  $DF15,$40,$04 #GRAPHIC$68(base-01)

N $DF55 Frame 2.
@ $DF55 label=Graphic_Alien_Base_2
  $DF55,$01 Width = #N(#PEEK(#PC)) bytes.
  $DF56,$01 Height = #N(#PEEK(#PC)) pixels.
  $DF57,$50,$05 #GRAPHIC$69(base-02)

N $DFA7 Frame 3.
@ $DFA7 label=Graphic_Alien_Base_3
  $DFA7,$01 Width = #N(#PEEK(#PC)) bytes.
  $DFA8,$01 Height = #N(#PEEK(#PC)) pixels.
  $DFA9,$50,$05 #GRAPHIC$6A(base-03)

N $DFF9 Frame 4.
@ $DFF9 label=Graphic_Alien_Base_4
  $DFF9,$01 Width = #N(#PEEK(#PC)) bytes.
  $DFFA,$01 Height = #N(#PEEK(#PC)) pixels.
  $DFFB,$50,$05 #GRAPHIC$6B(base-04)

N $E04B Frame 5.
@ $E04B label=Graphic_Alien_Base_5
  $E04B,$01 Width = #N(#PEEK(#PC)) bytes.
  $E04C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E04D,$50,$05 #GRAPHIC$6C(base-05)

N $E09D Frame 6.
@ $E09D label=Graphic_Alien_Base_6
  $E09D,$01 Width = #N(#PEEK(#PC)) bytes.
  $E09E,$01 Height = #N(#PEEK(#PC)) pixels.
  $E09F,$50,$05 #GRAPHIC$6D(base-06)

N $E0EF Frame 7.
@ $E0EF label=Graphic_Alien_Base_7
  $E0EF,$01 Width = #N(#PEEK(#PC)) bytes.
  $E0F0,$01 Height = #N(#PEEK(#PC)) pixels.
  $E0F1,$50,$05 #GRAPHIC$6E(base-07)

N $E141 Frame 8.
@ $E141 label=Graphic_Alien_Base_8
  $E141,$01 Width = #N(#PEEK(#PC)) bytes.
  $E142,$01 Height = #N(#PEEK(#PC)) pixels.
  $E143,$50,$05 #GRAPHIC$6F(base-08)

b $E193 Sprite: Missile
@ $E193 label=Sprite_Missile_Up_Left
N $E193 Frame Up-Left.
  $E193,$01 Height = #N(#PEEK(#PC)) pixels.
  $E194,$20,$02 #SPRITE$80(missile-up-left)

N $E1B4 Frame Up-Right.
@ $E1B4 label=Sprite_Missile_Up_Right
  $E1B4,$01 Height = #N(#PEEK(#PC)) pixels.
  $E1B5,$20,$02 #SPRITE$84(missile-up-right)

b $E1D5 Sprite: Unused
@ $E1D5 label=Sprite_Unused_9B
N $E1D5 Frame 1.
  $E1D5,$01 Height = #N(#PEEK(#PC)) pixels.
  $E1D6,$32,$02 #SPRITE$9B(unused-9b)

N $E208 Frame 2.
  $E208,$01 Height = #N(#PEEK(#PC)) pixels.
  $E209,$32,$02 #SPRITEDATA(unused-e208)

b $E23B Sprite: Missile Flame
@ $E23B label=Sprite_Missile_Flame_Up_1
N $E23B Frame 1.
  $E23B,$01 Height = #N(#PEEK(#PC)) pixels.
  $E23C,$1A,$02 #SPRITE$82(missile-flame-01*)

N $E256 Frame 2.
@ $E256 label=Sprite_Missile_Flame_Up_2
  $E256,$01 Height = #N(#PEEK(#PC)) pixels.
  $E257,$1A,$02 #SPRITE$83(missile-flame-02*)

N $E271 Frame 3.
@ $E271 label=Sprite_Missile_Flame_Up_3
  $E271,$01 Height = #N(#PEEK(#PC)) pixels.
  $E272,$1A,$02 #SPRITE$86(missile-flame-03*)

N $E28C Frame 4.
@ $E28C label=Sprite_Missile_Flame_Up_4
  $E28C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E28D,$1A,$02 #SPRITE$87(missile-flame-04*)

b $E2A7 Sprite: The Block
@ $E2A7 label=Sprite_The_Block_1
D $E2A7 The Block appears from level 1 onwards.
N $E2A7 Frame 1.
  $E2A7,$01 Height = #N(#PEEK(#PC)) pixels.
  $E2A8,$20,$02 #SPRITE$88(block-01)

N $E2C8 Frame 2.
@ $E2C8 label=Sprite_The_Block_2
  $E2C8,$01 Height = #N(#PEEK(#PC)) pixels.
  $E2C9,$20,$02 #SPRITE$89(block-02)

N $E2E9 Frame 3.
@ $E2E9 label=Sprite_The_Block_3
  $E2E9,$01 Height = #N(#PEEK(#PC)) pixels.
  $E2EA,$1C,$02 #SPRITE$8A(block-03)

N $E306 Frame 4.
@ $E306 label=Sprite_The_Block_4
  $E306,$01 Height = #N(#PEEK(#PC)) pixels.
  $E307,$18,$02 #SPRITE$8B(block-04)

N $E31F Frame 5.
@ $E31F label=Sprite_The_Block_5
  $E31F,$01 Height = #N(#PEEK(#PC)) pixels.
  $E320,$18,$02 #SPRITE$8C(block-05)

N $E338 Frame 6.
@ $E338 label=Sprite_The_Block_6
  $E338,$01 Height = #N(#PEEK(#PC)) pixels.
  $E339,$18,$02 #SPRITE$8D(block-06)

N $E351 Frame 7.
@ $E351 label=Sprite_The_Block_7
  $E351,$01 Height = #N(#PEEK(#PC)) pixels.
  $E352,$1C,$02 #SPRITE$8E(block-07)

N $E36E Frame 8.
@ $E36E label=Sprite_The_Block_8
  $E36E,$01 Height = #N(#PEEK(#PC)) pixels.
  $E36F,$20,$02 #SPRITE$8F(block-08)

b $E38F Sprite: Missile
@ $E38F label=Sprite_Missile_Left
N $E38F Left frame.
  $E38F,$01 Height = #N(#PEEK(#PC)) pixels.
  $E390,$12,$02 #SPRITE$A0(missile-left)

N $E3A2 Right frame.
@ $E3A2 label=Sprite_Missile_Right
  $E3A2,$01 Height = #N(#PEEK(#PC)) pixels.
  $E3A3,$12,$02 #SPRITE$A4(missile-right)

b $E3B5 Sprite: Missile Flame
@ $E3B5 label=Sprite_Missile_Flame_Left_1
N $E3B5 Left frame 1.
  $E3B5,$01 Height = #N(#PEEK(#PC)) pixels.
  $E3B6,$14,$02 #SPRITE$A2(missile-flame-left-01)

N $E3CA Left frame 2.
@ $E3CA label=Sprite_Missile_Flame_Left_2
  $E3CA,$01 Height = #N(#PEEK(#PC)) pixels.
  $E3CB,$10,$02 #SPRITE$A3(missile-flame-left-02)

N $E3DB Right frame 1.
@ $E3DB label=Sprite_Missile_Flame_Right_1
  $E3DB,$01 Height = #N(#PEEK(#PC)) pixels.
  $E3DC,$14,$02 #SPRITE$A6(missile-flame-right-01)

N $E3F0 Right frame 2.
@ $E3F0 label=Sprite_Missile_Flame_Right_2
  $E3F0,$01 Height = #N(#PEEK(#PC)) pixels.
  $E3F1,$10,$02 #SPRITE$A7(missile-flame-right-02)

b $E401 Sprite: Unused
@ $E401 label=Sprite_Unused_98
  $E401,$01 Height = #N(#PEEK(#PC)) pixels.
  $E402,$32,$02 #SPRITE$98(unused-98)

N $E434
@ $E434 label=Sprite_Unused_99
  $E434,$01 Height = #N(#PEEK(#PC)) pixels.
  $E435,$32,$02 #SPRITE$99(unused-99)

N $E467
@ $E467 label=Sprite_Unused_9A
  $E467,$01 Height = #N(#PEEK(#PC)) pixels.
  $E468,$32,$02 #SPRITE$9A(unused-9a)

b $E49A Sprite: Unused
@ $E49A label=Sprite_Unused_9C
  $E49A,$01 Height = #N(#PEEK(#PC)) pixels.
  $E49B,$32,$02 #SPRITE$9C(unused-9c)

N $E4CD
@ $E4CD label=Sprite_Unused_9D
  $E4CD,$01 Height = #N(#PEEK(#PC)) pixels.
  $E4CE,$32,$02 #SPRITE$9D(unused-9d)

N $E500
@ $E500 label=Sprite_Unused_9E
  $E500,$01 Height = #N(#PEEK(#PC)) pixels.
  $E501,$32,$02 #SPRITE$9E(unused-9e)

b $E533 Sprite: Alien Base Plasma
@ $E533 label=Sprite_Alien_Base_Plasma_1
E $E533 #UDGTABLE(default) { #FRAMES(alien-base-plasma-01,5;alien-base-plasma-01;alien-base-plasma-02;alien-base-plasma-03;alien-base-plasma-04;alien-base-plasma-04;alien-base-plasma-03;alien-base-plasma-02)(alien-base-plasma) } UDGTABLE#
N $E533 Frame 1.
  $E533,$01 Height = #N(#PEEK(#PC)) pixels.
  $E534,$2A,$02 #SPRITE$90(alien-base-plasma-01*)

N $E55E Frame 2.
@ $E55E label=Sprite_Alien_Base_Plasma_2
  $E55E,$01 Height = #N(#PEEK(#PC)) pixels.
  $E55F,$2A,$02 #SPRITE$92(alien-base-plasma-02*)

N $E589 Frame 3.
@ $E589 label=Sprite_Alien_Base_Plasma_3
  $E589,$01 Height = #N(#PEEK(#PC)) pixels.
  $E58A,$2A,$02 #SPRITE$93(alien-base-plasma-03*)

N $E5B4 Frame 4.
@ $E5B4 label=Sprite_Alien_Base_Plasma_4
  $E5B4,$01 Height = #N(#PEEK(#PC)) pixels.
  $E5B5,$2A,$02 #SPRITE$94(alien-base-plasma-04*)

b $E5DF Sprite: Crater
@ $E5DF label=Sprite_Crater_1
N $E5DF Frame 1.
  $E5DF,$01 Height = #N(#PEEK(#PC)) pixels.
  $E5E0,$18,$02 #SPRITE$C0(unused-c0)

N $E5F8 Frame 2.
@ $E5F8 label=Sprite_Crater_2
  $E5F8,$01 Height = #N(#PEEK(#PC)) pixels.
  $E5F9,$20,$02 #SPRITE$C1(unused-c1)

N $E619 Frame 3.
@ $E619 label=Sprite_Crater_3
  $E619,$01 Height = #N(#PEEK(#PC)) pixels.
  $E61A,$20,$02 #SPRITE$C2(unused-c2)

N $E63A Frame 4.
@ $E63A label=Sprite_Crater_4
  $E63A,$01 Height = #N(#PEEK(#PC)) pixels.
  $E63B,$20,$02 #SPRITE$C3(unused-c3)

N $E65B Frame 5.
@ $E65B label=Sprite_Crater_5
  $E65B,$01 Height = #N(#PEEK(#PC)) pixels.
  $E65C,$20,$02 #SPRITE$C4(unused-c4)

N $E67C Frame 6.
@ $E67C label=Sprite_Crater_6
  $E67C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E67D,$20,$02 #SPRITE$C5(unused-c5)

N $E69D Frame 7.
@ $E69D label=Sprite_Crater_7
  $E69D,$01 Height = #N(#PEEK(#PC)) pixels.
  $E69E,$20,$02 #SPRITEDATA(unused-e69d)

N $E6BE Frame 8.
@ $E6BE label=Sprite_Crater_8
  $E6BE,$01 Height = #N(#PEEK(#PC)) pixels.
  $E6BF,$20,$02 #SPRITE$C7(unused-c7)

b $E6DF Sprite: Linked Object
@ $E6DF label=Sprite_Linked_Object_1
N $E6DF Frame 1.
  $E6DF,$01 Height = #N(#PEEK(#PC)) pixels.
  $E6E0,$08,$01 #SPRITE$C8,$BAC0,$01(unused-c8)

N $E6E8 Frame 2.
@ $E6E8 label=Sprite_Linked_Object_2
  $E6E8,$01 Height = #N(#PEEK(#PC)) pixels.
  $E6E9,$08,$01 #SPRITE$C9,$BAC0,$01(unused-c9)

N $E6F1 Frame 3.
@ $E6F1 label=Sprite_Linked_Object_3
  $E6F1,$01 Height = #N(#PEEK(#PC)) pixels.
  $E6F2,$08,$01 #SPRITE$CA,$BAC0,$01(sprite-ca)

N $E6FA Frame 4.
@ $E6FA label=Sprite_Linked_Object_4
  $E6FA,$01 Height = #N(#PEEK(#PC)) pixels.
  $E6FB,$08,$01 #SPRITE$CB,$BAC0,$01(sprite-cb)

b $E703 Sprite: Saturn
@ $E703 label=Sprite_Saturn_1
D $E703 Saturn appears from level 10 onwards.
E $E703 #UDGTABLE(default) { #FRAMES(saturn-01,15;saturn-02;saturn-03;saturn-04;saturn-05;saturn-06;saturn-07;saturn-02;saturn-01;saturn-08;saturn-09;saturn-10;saturn-11;saturn-12;saturn-13;saturn-08)(saturn) } UDGTABLE#
N $E703 Frame 1.
  $E703,$01 Height = #N(#PEEK(#PC)) pixels.
  $E704,$18,$02 #SPRITE$CC(saturn-01*)

N $E71C Frame 2.
@ $E71C label=Sprite_Saturn_2
  $E71C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E71D,$18,$02 #SPRITE$CD(saturn-02*)

N $E735 Frame 3.
@ $E735 label=Sprite_Saturn_3
  $E735,$01 Height = #N(#PEEK(#PC)) pixels.
  $E736,$18,$02 #SPRITE$CE(saturn-03*)

N $E74E Frame 4.
@ $E74E label=Sprite_Saturn_4
  $E74E,$01 Height = #N(#PEEK(#PC)) pixels.
  $E74F,$18,$02 #SPRITE$CF(saturn-04*)

N $E767 Frame 5.
@ $E767 label=Sprite_Saturn_5
  $E767,$01 Height = #N(#PEEK(#PC)) pixels.
  $E768,$18,$02 #SPRITE$D0(saturn-05*)

N $E780 Frame 6.
@ $E780 label=Sprite_Saturn_6
  $E780,$01 Height = #N(#PEEK(#PC)) pixels.
  $E781,$18,$02 #SPRITE$D1(saturn-06*)

N $E799 Frame 7.
@ $E799 label=Sprite_Saturn_7
  $E799,$01 Height = #N(#PEEK(#PC)) pixels.
  $E79A,$18,$02 #SPRITE$D2(saturn-07*)

N $E7B2 Frame 8.
@ $E7B2 label=Sprite_Saturn_8
  $E7B2,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7B3,$18,$02 #SPRITE$D5(saturn-08*)

N $E7CB Frame 9.
@ $E7CB label=Sprite_Saturn_9
  $E7CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7CC,$18,$02 #SPRITE$D6(saturn-09*)

N $E7E4 Frame 10.
@ $E7E4 label=Sprite_Saturn_10
  $E7E4,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7E5,$18,$02 #SPRITE$D7(saturn-10*)

N $E7FD Frame 11.
@ $E7FD label=Sprite_Saturn_11
  $E7FD,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7FE,$18,$02 #SPRITE$D8(saturn-11*)

N $E816 Frame 12.
@ $E816 label=Sprite_Saturn_12
  $E816,$01 Height = #N(#PEEK(#PC)) pixels.
  $E817,$18,$02 #SPRITE$D9(saturn-12*)

N $E82F Frame 13.
@ $E82F label=Sprite_Saturn_13
  $E82F,$01 Height = #N(#PEEK(#PC)) pixels.
  $E830,$18,$02 #SPRITE$DA(saturn-13*)

b $E848 Sprite: Spinner
@ $E848 label=Sprite_Spinner_1
D $E848 Spinner appears from level 2 onwards.
N $E848 Frame 1.
  $E848,$01 Height = #N(#PEEK(#PC)) pixels.
  $E849,$26,$02 #SPRITE$B0(spinner-01)

N $E86F Frame 2.
@ $E86F label=Sprite_Spinner_2
  $E86F,$01 Height = #N(#PEEK(#PC)) pixels.
  $E870,$26,$02 #SPRITE$B1(spinner-02)

N $E896 Frame 3.
@ $E896 label=Sprite_Spinner_3
  $E896,$01 Height = #N(#PEEK(#PC)) pixels.
  $E897,$24,$02 #SPRITE$B2(spinner-03)

N $E8BB Frame 4.
@ $E8BB label=Sprite_Spinner_4
  $E8BB,$01 Height = #N(#PEEK(#PC)) pixels.
  $E8BC,$1E,$02 #SPRITE$B3(spinner-04)

N $E8DA Frame 5.
@ $E8DA label=Sprite_Spinner_5
  $E8DA,$01 Height = #N(#PEEK(#PC)) pixels.
  $E8DB,$16,$02 #SPRITE$B4(spinner-05)

N $E8F1 Frame 6.
@ $E8F1 label=Sprite_Spinner_6
  $E8F1,$01 Height = #N(#PEEK(#PC)) pixels.
  $E8F2,$1E,$02 #SPRITE$B5(spinner-06)

b $E910 Sprite: Jetman Falling
@ $E910 label=Sprite_Jetman_Falling_1
E $E910 #UDGTABLE(default) { #FRAMES(jetman-falling-01,15;jetman-falling-02;jetman-falling-03;jetman-falling-04)(jetman-falling) } UDGTABLE#
N $E910 Frame 1.
  $E910,$01 Height = #N(#PEEK(#PC)) pixels.
  $E911,$22,$02 #SPRITE$DC(jetman-falling-01*)

N $E933 Frame 2.
@ $E933 label=Sprite_Jetman_Falling_2
  $E933,$01 Height = #N(#PEEK(#PC)) pixels.
  $E934,$22,$02 #SPRITE$DD(jetman-falling-02*)

N $E956 Frame 3.
@ $E956 label=Sprite_Jetman_Falling_3
  $E956,$01 Height = #N(#PEEK(#PC)) pixels.
  $E957,$22,$02 #SPRITE$DE(jetman-falling-03*)

N $E979 Frame 4.
@ $E979 label=Sprite_Jetman_Falling_4
  $E979,$01 Height = #N(#PEEK(#PC)) pixels.
  $E97A,$22,$02 #SPRITE$DF(jetman-falling-04*)

b $E99C Sprite: Shooter
@ $E99C label=Sprite_Shooter_1
E $E99C #UDGTABLE(default) { #FRAMES(shooter-01,15;shooter-02;shooter-03;shooter-04;shooter-05;shooter-06;shooter-07)(shooter) } UDGTABLE#
D $E99C Shooters appear from level 8 onwards.
N $E99C Frame 1.
  $E99C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E99D,$20,$02 #SPRITE$B8(shooter-01*)

N $E9BD Frame 2.
@ $E9BD label=Sprite_Shooter_2
  $E9BD,$01 Height = #N(#PEEK(#PC)) pixels.
  $E9BE,$20,$02 #SPRITE$B9(shooter-02*)

N $E9DE Frame 3.
@ $E9DE label=Sprite_Shooter_3
  $E9DE,$01 Height = #N(#PEEK(#PC)) pixels.
  $E9DF,$20,$02 #SPRITE$BA(shooter-03*)

N $E9FF Frame 4.
@ $E9FF label=Sprite_Shooter_4
  $E9FF,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA00,$20,$02 #SPRITE$BB(shooter-04*)

N $EA20 Frame 5.
@ $EA20 label=Sprite_Shooter_5
  $EA20,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA21,$20,$02 #SPRITE$BC(shooter-05*)

N $EA41 Frame 6.
@ $EA41 label=Sprite_Shooter_6
  $EA41,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA42,$20,$02 #SPRITE$BD(shooter-06*)

N $EA62 Frame 7.
@ $EA62 label=Sprite_Shooter_7
  $EA62,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA63,$20,$02 #SPRITE$BE(shooter-07*)

b $EA83 Sprite: The Pip
@ $EA83 label=Sprite_ThePip_1
N $EA83 Frame 1.
  $EA83,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA84,$04,$01 #SPRITE$B6,$BAC0,$01(the-pip-01)

N $EA88 Frame 2.
@ $EA88 label=Sprite_ThePip_2
  $EA88,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA89,$04,$01 #SPRITE$B7,$BAC0,$01(the-pip-02)

b $EA8D Graphic: Explosion
@ $EA8D label=Graphic_Explosion_1
N $EA8D Frame 1.
  $EA8D,$01 Width = #N(#PEEK(#PC)) bytes.
  $EA8E,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA8F,$1C,$02 #GRAPHIC$E0(explosion-01)

N $EAAB Frame 2.
@ $EAAB label=Graphic_Explosion_2
  $EAAB,$01 Width = #N(#PEEK(#PC)) bytes.
  $EAAC,$01 Height = #N(#PEEK(#PC)) pixels.
  $EAAD,$40,$04 #GRAPHIC$E1(explosion-02)

N $EAED Frame 3.
@ $EAED label=Graphic_Explosion_3
  $EAED,$01 Width = #N(#PEEK(#PC)) bytes.
  $EAEE,$01 Height = #N(#PEEK(#PC)) pixels.
  $EAEF,$78,$05 #GRAPHIC$E2(explosion-03)

N $EB67 Frame 4.
@ $EB67 label=Graphic_Explosion_4
  $EB67,$01 Width = #N(#PEEK(#PC)) bytes.
  $EB68,$01 Height = #N(#PEEK(#PC)) pixels.
  $EB69,$E0,$07 #GRAPHIC$E3(explosion-04)

N $EC49 Frame 5.
@ $EC49 label=Graphic_Explosion_5
  $EC49,$01 Height = #N(#PEEK(#PC)) pixels.
  $EC4A,$20,$02 #SPRITE$E4(explosion-05)

N $EC6A Frame 6.
@ $EC6A label=Graphic_Explosion_6
  $EC6A,$01 Height = #N(#PEEK(#PC)) pixels.
  $EC6B,$20,$02 #SPRITE$E5(explosion-06)

N $EC8B Frame 7.
@ $EC8B label=Graphic_Explosion_7
  $EC8B,$01 Height = #N(#PEEK(#PC)) pixels.
  $EC8C,$20,$02 #SPRITE$E6(explosion-07)

N $ECAC Frame 8.
@ $ECAC label=Graphic_Explosion_8
  $ECAC,$01 Height = #N(#PEEK(#PC)) pixels.
  $ECAD,$20,$02 #SPRITE$E7(explosion-08)

N $ECCD Frame 9.
@ $ECCD label=Graphic_Explosion_9
  $ECCD,$01 Height = #N(#PEEK(#PC)) pixels.
  $ECCE,$20,$02 #SPRITE$E8(explosion-09)

N $ECEE Frame 10.
@ $ECEE label=Graphic_Explosion_10
  $ECEE,$01 Height = #N(#PEEK(#PC)) pixels.
  $ECEF,$20,$02 #SPRITE$E9(explosion-10)

N $ED0F Frame 11.
@ $ED0F label=Graphic_Explosion_11
  $ED0F,$01 Height = #N(#PEEK(#PC)) pixels.
  $ED10,$20,$02 #SPRITE$EA(explosion-11)

N $ED30 Frame 12.
@ $ED30 label=Graphic_Explosion_12
  $ED30,$01 Height = #N(#PEEK(#PC)) pixels.
  $ED31,$20,$02 #SPRITE$EB(explosion-12)

b $ED51 Sprite: Bouncing Wheel
@ $ED51 label=Sprite_Bouncing_Wheel_1
E $ED51 #UDGTABLE(default) { #FRAMES(bouncing-wheel-01,5;bouncing-wheel-02;bouncing-wheel-03;bouncing-wheel-04;bouncing-wheel-05;bouncing-wheel-06)(bouncing-wheel) } UDGTABLE#
D $ED51 Bouncing Wheels appear from level 1 onwards.
N $ED51 Frame 1.
  $ED51,$01 Height = #N(#PEEK(#PC)) pixels.
  $ED52,$20,$02 #SPRITE$A8(bouncing-wheel-01*)

N $ED72 Frame 2.
@ $ED72 label=Sprite_Bouncing_Wheel_2
  $ED72,$01 Height = #N(#PEEK(#PC)) pixels.
  $ED73,$20,$02 #SPRITE$A9(bouncing-wheel-02*)

N $ED93 Frame 3.
@ $ED93 label=Sprite_Bouncing_Wheel_3
  $ED93,$01 Height = #N(#PEEK(#PC)) pixels.
  $ED94,$20,$02 #SPRITE$AA(bouncing-wheel-03*)

N $EDB4 Frame 4.
@ $EDB4 label=Sprite_Bouncing_Wheel_4
  $EDB4,$01 Height = #N(#PEEK(#PC)) pixels.
  $EDB5,$20,$02 #SPRITE$AB(bouncing-wheel-04*)

N $EDD5 Frame 5.
@ $EDD5 label=Sprite_Bouncing_Wheel_5
  $EDD5,$01 Height = #N(#PEEK(#PC)) pixels.
  $EDD6,$20,$02 #SPRITE$AC(bouncing-wheel-05*)

N $EDF6 Frame 6.
@ $EDF6 label=Sprite_Bouncing_Wheel_6
  $EDF6,$01 Height = #N(#PEEK(#PC)) pixels.
  $EDF7,$20,$02 #SPRITE$AD(bouncing-wheel-06*)

b $EE17 Sprite: Bomb
@ $EE17 label=Sprite_Bomb_1
E $EE17 #UDGTABLE(default) { #FRAMES(bomb-01,25;bomb-02;bomb-03;bomb-02)(bomb) } UDGTABLE#
N $EE17 Frame 1.
  $EE17,$01 Height = #N(#PEEK(#PC)) pixels.
  $EE18,$20,$02 #SPRITE$EC(bomb-01*)

N $EE38 Frame 2.
@ $EE38 label=Sprite_Bomb_2
  $EE38,$01 Height = #N(#PEEK(#PC)) pixels.
  $EE39,$20,$02 #SPRITE$ED(bomb-02*)

N $EE59 Frame 3.
@ $EE59 label=Sprite_Bomb_3
  $EE59,$01 Height = #N(#PEEK(#PC)) pixels.
  $EE5A,$20,$02 #SPRITE$EE(bomb-03*)

w $EE7A Odd-Level Sprite Table
@ $EE7A label=Sprite_Band_Table
D $EE7A Word pointers used by #R$853D on odd levels. The 1-based
. index it returns selects one of these frames instead of
. #R$BAC0.
. #TABLE(default,centre,centre,centre)
. { =h Sprite IDs | =h Family | =h #R$EE7A Index }
. { #N$40-#N$47 | Brella | #N$01-#N$08 }
. { #N$48-#N$4F | Blob | #N$09-#N$10 }
. { #N$88-#N$8F | Block | #N$11-#N$18 }
. { #N$B0-#N$B5 | Spinner | #N$19-#N$1E }
. TABLE#
N $EE7A Brella frames #N$01-#N$08.
W $EE7A,$02 #R$EEBA.
W $EE7C,$02 #R$EED7.
W $EE7E,$02 #R$EEF4.
W $EE80,$02 #R$EF11.
W $EE82,$02 #R$EF2E.
W $EE84,$02 #R$EF4B.
W $EE86,$02 #R$EF68.
W $EE88,$02 #R$EF85.
N $EE8A Blob frames #N$09-#N$10.
W $EE8A,$02 #R$F16A.
W $EE8C,$02 #R$F183.
W $EE8E,$02 #R$F19C.
W $EE90,$02 #R$F1B5.
W $EE92,$02 #R$F1CE.
W $EE94,$02 #R$F1E7.
W $EE96,$02 #R$F200.
W $EE98,$02 #R$F219.
N $EE9A Block frames #N$11-#N$18. Frames #N$16 and #N$17
. share #R$F068.
W $EE9A,$02 #R$EFA2.
W $EE9C,$02 #R$EFC3.
W $EE9E,$02 #R$EFE4.
W $EEA0,$02 #R$F005.
W $EEA2,$02 #R$F026.
W $EEA4,$02 #R$F068.
W $EEA6,$02 #R$F068.
W $EEA8,$02 #R$F089.
N $EEAA Spinner frames #N$19-#N$1E.
W $EEAA,$02 #R$F0AA.
W $EEAC,$02 #R$F0C7.
W $EEAE,$02 #R$F0E6.
W $EEB0,$02 #R$F107.
W $EEB2,$02 #R$F12A.
W $EEB4,$02 #R$F14B.

u $EEB6 Unused
@ $EEB6 label=Unused_After_Sprite_Band_Table
D $EEB6 Two unused pointers to #R$BCBC immediately after #R$EE7A.
W $EEB6,$02 #R$BCBC.
W $EEB8,$02 #R$BCBC.

b $EEBA Sprite: Tubular Grabber
@ $EEBA label=Sprite_TubularGrabber
D $EEBA Odd-level frames of Tubular Grabber, which replaces Mr Magnetic
. Brella. #R$853D maps IDs #N$40-#N$47 here.
N $EEBA Frame 1.
  $EEBA,$01 Height = #N(#PEEK(#PC)) pixels.
  $EEBB,$1C,$02 #SPRITE$01,$EE7A(tubular-grabber-01*)
N $EED7 Frame 2.
@ $EED7 label=Sprite_TubularGrabber_2
  $EED7,$01 Height = #N(#PEEK(#PC)) pixels.
  $EED8,$1C,$02 #SPRITE$02,$EE7A(tubular-grabber-02*)
N $EEF4 Frame 3.
@ $EEF4 label=Sprite_TubularGrabber_3
  $EEF4,$01 Height = #N(#PEEK(#PC)) pixels.
  $EEF5,$1C,$02 #SPRITE$03,$EE7A(tubular-grabber-03*)
N $EF11 Frame 4.
@ $EF11 label=Sprite_TubularGrabber_4
  $EF11,$01 Height = #N(#PEEK(#PC)) pixels.
  $EF12,$1C,$02 #SPRITE$04,$EE7A(tubular-grabber-04*)
N $EF2E Frame 5.
@ $EF2E label=Sprite_TubularGrabber_5
  $EF2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $EF2F,$1C,$02 #SPRITE$05,$EE7A(tubular-grabber-05*)
N $EF4B Frame 6.
@ $EF4B label=Sprite_TubularGrabber_6
  $EF4B,$01 Height = #N(#PEEK(#PC)) pixels.
  $EF4C,$1C,$02 #SPRITE$06,$EE7A(tubular-grabber-06*)
N $EF68 Frame 7.
@ $EF68 label=Sprite_TubularGrabber_7
  $EF68,$01 Height = #N(#PEEK(#PC)) pixels.
  $EF69,$1C,$02 #SPRITE$07,$EE7A(tubular-grabber-07*)
N $EF85 Frame 8.
@ $EF85 label=Sprite_TubularGrabber_8
  $EF85,$01 Height = #N(#PEEK(#PC)) pixels.
  $EF86,$1C,$02 #SPRITE$08,$EE7A(tubular-grabber-08*)

b $EFA2 Sprite: The Cross
@ $EFA2 label=Sprite_TheCross
D $EFA2 Odd-level frames of The Cross, which replaces The Block.
. #R$853D maps IDs #N$88-#N$8F here. Frames 6 and 7 share #R$F068.
N $EFA2 Frame 1.
  $EFA2,$01 Height = #N(#PEEK(#PC)) pixels.
  $EFA3,$20,$02 #SPRITE$11,$EE7A(cross-01)
N $EFC3 Frame 2.
@ $EFC3 label=Sprite_TheCross_2
  $EFC3,$01 Height = #N(#PEEK(#PC)) pixels.
  $EFC4,$20,$02 #SPRITE$12,$EE7A(cross-02)
N $EFE4 Frame 3.
@ $EFE4 label=Sprite_TheCross_3
  $EFE4,$01 Height = #N(#PEEK(#PC)) pixels.
  $EFE5,$20,$02 #SPRITE$13,$EE7A(cross-03)
N $F005 Frame 4.
@ $F005 label=Sprite_TheCross_4
  $F005,$01 Height = #N(#PEEK(#PC)) pixels.
  $F006,$20,$02 #SPRITE$14,$EE7A(cross-04)
N $F026 Frame 5.
@ $F026 label=Sprite_TheCross_5
  $F026,$01 Height = #N(#PEEK(#PC)) pixels.
  $F027,$20,$02 #SPRITE$15,$EE7A(cross-05)
N $F047 Unused frame. Not referenced by #R$EE7A.
@ $F047 label=Sprite_TheCross_Unused
  $F047,$01 Height = #N(#PEEK(#PC)) pixels.
  $F048,$20,$02 #SPRITEDATA(cross-unused)
N $F068 Frame 6 and frame 7.
@ $F068 label=Sprite_TheCross_6
  $F068,$01 Height = #N(#PEEK(#PC)) pixels.
  $F069,$20,$02 #SPRITE$16,$EE7A(cross-06)
N $F089 Frame 8.
@ $F089 label=Sprite_TheCross_8
  $F089,$01 Height = #N(#PEEK(#PC)) pixels.
  $F08A,$20,$02 #SPRITE$18,$EE7A(cross-08)

b $F0AA Sprite: Sparkle
@ $F0AA label=Sprite_Sparkle
D $F0AA Odd-level frames of Sparkle, which replaces the Spinner.
. #R$853D maps IDs #N$B0-#N$B5 here.
N $F0AA Frame 1.
  $F0AA,$01 Height = #N(#PEEK(#PC)) pixels.
  $F0AB,$1C,$02 #SPRITE$19,$EE7A(sparkle-01)
N $F0C7 Frame 2.
@ $F0C7 label=Sprite_Sparkle_2
  $F0C7,$01 Height = #N(#PEEK(#PC)) pixels.
  $F0C8,$1E,$02 #SPRITE$1A,$EE7A(sparkle-02)
N $F0E6 Frame 3.
@ $F0E6 label=Sprite_Sparkle_3
  $F0E6,$01 Height = #N(#PEEK(#PC)) pixels.
  $F0E7,$20,$02 #SPRITE$1B,$EE7A(sparkle-03)
N $F107 Frame 4.
@ $F107 label=Sprite_Sparkle_4
  $F107,$01 Height = #N(#PEEK(#PC)) pixels.
  $F108,$22,$02 #SPRITE$1C,$EE7A(sparkle-04)
N $F12A Frame 5.
@ $F12A label=Sprite_Sparkle_5
  $F12A,$01 Height = #N(#PEEK(#PC)) pixels.
  $F12B,$20,$02 #SPRITE$1D,$EE7A(sparkle-05)
N $F14B Frame 6.
@ $F14B label=Sprite_Sparkle_6
  $F14B,$01 Height = #N(#PEEK(#PC)) pixels.
  $F14C,$1E,$02 #SPRITE$1E,$EE7A(sparkle-06)

b $F16A Sprite: The Dog
@ $F16A label=Sprite_TheDog
D $F16A Odd-level frames of The Dog, which replaces The Blob.
. #R$853D maps IDs #N$48-#N$4F here.
N $F16A Frame 1.
  $F16A,$01 Height = #N(#PEEK(#PC)) pixels.
  $F16B,$18,$02 #SPRITE$09,$EE7A(dog-01*)
N $F183 Frame 2.
@ $F183 label=Sprite_TheDog_2
  $F183,$01 Height = #N(#PEEK(#PC)) pixels.
  $F184,$18,$02 #SPRITE$0A,$EE7A(dog-02*)
N $F19C Frame 3.
@ $F19C label=Sprite_TheDog_3
  $F19C,$01 Height = #N(#PEEK(#PC)) pixels.
  $F19D,$18,$02 #SPRITE$0B,$EE7A(dog-03*)
N $F1B5 Frame 4.
@ $F1B5 label=Sprite_TheDog_4
  $F1B5,$01 Height = #N(#PEEK(#PC)) pixels.
  $F1B6,$18,$02 #SPRITE$0C,$EE7A(dog-04*)
N $F1CE Frame 5.
@ $F1CE label=Sprite_TheDog_5
  $F1CE,$01 Height = #N(#PEEK(#PC)) pixels.
  $F1CF,$18,$02 #SPRITE$0D,$EE7A(dog-05*)
N $F1E7 Frame 6.
@ $F1E7 label=Sprite_TheDog_6
  $F1E7,$01 Height = #N(#PEEK(#PC)) pixels.
  $F1E8,$18,$02 #SPRITE$0E,$EE7A(dog-06*)
N $F200 Frame 7.
@ $F200 label=Sprite_TheDog_7
  $F200,$01 Height = #N(#PEEK(#PC)) pixels.
  $F201,$18,$02 #SPRITE$0F,$EE7A(dog-07*)
N $F219 Frame 8.
@ $F219 label=Sprite_TheDog_8
  $F219,$01 Height = #N(#PEEK(#PC)) pixels.
  $F21A,$18,$02 #SPRITE$10,$EE7A(dog-08*)

c $F232 Print Rank Message
@ $F232 label=NewHighScore_Suffix
D $F232 Prints "TOP SCORE" for first place. Otherwise prints the rank
. with its "ND", "RD" or "TH" suffix, followed by "HIGHEST SCORE".
N $F232 Check whether the new score takes first place.
  $F232,$07 If #R$5E77 is zero, jump to #R$F26B.
N $F239 #N$00 is the "Top Score" so we +#N$01 to make it human readable.
  $F239,$02 #REGa=#REGa+#N$31 (convert to ASCII + #N$01).
  $F23B,$03 #REGhl=#N$5007 (screen buffer location).
  $F23E,$01 Stash the ASCII highscore position on the stack.
  $F23F,$03 Call #R$89EF.
  $F242,$01 Restore the ASCII highscore position from the stack.
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
N $F274 #FONTaddr=$D347,attr=$46,chars=0(TH)(th)
@ $F274 label=HighScore_Suffixes_TH
  $F274,$03,h$01,$01:$01 Attribute: #COLOUR(#PEEK(#PC)) + "TH".
N $F277 #FONTaddr=$D347,attr=$46,chars=0(TOP SCORE)(top-score)
@ $F277 label=HighScore_Top_Score
  $F277,$0A,h$01,$08:$01 Attribute: #COLOUR(#PEEK(#PC)) + "TOP SCORE".
N $F281 #FONTaddr=$D347,attr=$46,chars=0(ND)(nd)
@ $F281 label=HighScore_Suffixes_ND
  $F281,$03,h$01,$01:$01 Attribute: #COLOUR(#PEEK(#PC)) + "ND".
N $F284 #FONTaddr=$D347,attr=$46,chars=0(RD)(rd)
@ $F284 label=HighScore_Suffixes_RD
  $F284,$03,h$01,$01:$01 Attribute: #COLOUR(#PEEK(#PC)) + "RD".
N $F287 #FONTaddr=$D347,attr=$46,chars=0(HIGHEST SCORE)(highest-score)
@ $F287 label=HighScore_Highest_Score
  $F287,$0E,h$01,$0C:$01 Attribute: #COLOUR(#PEEK(#PC)) + "HIGHEST SCORE".

c $F295 Handle Name Input
@ $F295 label=HallOfFame_Input
D $F295 Countdown #R$5E6D and read the controls while a name is
. being entered.
  $F295,$03 Fetch #R$5E6D.
  $F298,$01 Decrease it by one.
  $F299,$03 Write it back.
  $F29C,$05 Jump to #R$F345 if the timer is now zero.
  $F2A1,$03 Call #R$8F90.
  $F2A4,$05 Jump to #R$F2D6 if fire is pressed.
N $F2A9 Only check Left and Right once every sixteen ticks.
  $F2A9,$03 Fetch the low byte of #R$5E6D.
  $F2AC,$02,b$01 Keep only bits 0-3.
  $F2AE,$03 Jump to #R$F2C2 if the result is not zero.
N $F2B1 Release the fire lock, then read Left and Right.
  $F2B1,$04 Write #N$00 to #R$5E70.
  $F2B5,$03 Call #R$8F90.
  $F2B8,$05 Jump to #R$F2FE if Right is pressed.
  $F2BD,$05 Jump to #R$F31C if Left is pressed.
@ $F2C2 label=HallOfFame_Input_DrawLetter
N $F2C2 Draw the current letter and restart the input wait.
  $F2C2,$03 Fetch #R$5E6F.
  $F2C5,$03 #REGhl=#R$5E78.
  $F2C8,$01 Copy the index into #REGc.
  $F2C9,$02 Clear #REGb.
  $F2CB,$01 Point #REGhl at the current letter.
  $F2CC,$01 Fetch the letter.
  $F2CD,$03 Fetch #R$5E75.
  $F2D0,$03 Call #R$89EF.
  $F2D3,$03 Jump to #R$F5E3.
@ $F2D6 label=HallOfFame_Input_AcceptFire
N $F2D6 Fire accepts the letter and advances the cursor.
  $F2D6,$03 Fetch #R$5E70.
  $F2D9,$04 Jump to #R$F2C2 if fire is still locked.
  $F2DD,$03 Call #R$B8C3.
  $F2E0,$05 Write #N$01 to #R$5E70.
N $F2E5 Advance to the next letter, finishing after three.
  $F2E5,$03 Fetch #R$5E6F.
  $F2E8,$01 Increase the index by one.
  $F2E9,$05 Jump to #R$F345 if all three letters are done.
  $F2EE,$03 Write the new index.
N $F2F1 Move the screen pointer on to the next letter.
  $F2F1,$03 Fetch #R$5E75.
  $F2F4,$02 #REGa=#N$40 (unused).
  $F2F6,$02 Advance the screen pointer by two columns.
  $F2F8,$03 Write it back.
  $F2FB,$03 Jump to #R$F2C2.
@ $F2FE label=HallOfFame_Input_StepForward
N $F2FE Right steps the letter forward.
  $F2FE,$03 Call #R$B8BD.
N $F301 Fetch the current letter and step it forward.
  $F301,$03 Fetch #R$5E6F.
  $F304,$01 Copy the index into #REGc.
  $F305,$02 Clear #REGb.
  $F307,$03 #REGhl=#R$5E78.
  $F30A,$01 Point #REGhl at the current letter.
  $F30B,$01 Fetch the letter.
  $F30C,$01 Increase it by one.
N $F30D Wrap the letter around: after "Z" comes a space, and
. after a space comes "A".
  $F30D,$04 Jump to #R$F33A if it wrapped past "Z".
  $F311,$05 Jump to #R$F318 if it is not "!".
  $F316,$02 #REGa=#N$41.
@ $F318 label=HallOfFame_Input_WriteLetter
  $F318,$01 Write the letter.
  $F319,$03 Jump to #R$F2C2.
@ $F31C label=HallOfFame_Input_StepBackward
N $F31C Left steps the letter backward.
  $F31C,$03 Call #R$B8BD.
N $F31F Fetch the current letter and step it backward.
  $F31F,$03 Fetch #R$5E6F.
  $F322,$01 Copy the index into #REGc.
  $F323,$02 Clear #REGb.
  $F325,$03 #REGhl=#R$5E78.
  $F328,$01 Point #REGhl at the current letter.
  $F329,$01 Fetch the letter.
  $F32A,$01 Decrease it by one.
N $F32B Wrap the letter around: before "A" comes a space, and
. before a space comes "Z".
  $F32B,$04 Jump to #R$F33A if it wrapped past "A".
  $F32F,$05 Jump to #R$F336 if it is not #N$1F.
  $F334,$02 #REGa=#N$5A.
@ $F336 label=HallOfFame_Input_Loop
  $F336,$01 Write the letter.
  $F337,$03 Jump to #R$F2C2.
@ $F33A label=HallOfFame_Input_Space
  $F33A,$02 #REGa=#N$20.
  $F33C,$02 Jump to #R$F336.

c $F33E Return To Restart
@ $F33E label=ReturnToRestart
D $F33E Clear #R$5E73 and restart the game from #R$802C.
N $F33E Clear #R$5E73 and restart the game from #R$802C.
  $F33E,$04 Write #N$00 to #R$5E73.
  $F342,$03 Jump to #R$802C.

c $F345 Insert High Score
@ $F345 label=InsertHighScore
D $F345 Open a slot in the name table at #R$5E20, copy the new
. 3-letter name from #R$5E78, then insert the matching score
. into #R$5E06.
.
. If the other player also made the table, rank their score too and
. start name entry for them.
N $F345 #REGde is the byte after the name table and #REGhl is three
. bytes before that, so copying backwards moves each byte on by three
. bytes, which is one name row.
  $F345,$03 #REGde=#R$5E38.
  $F348,$03 #REGhl=#R$5E35.
N $F34B Work out how many bytes lie from the insert row down.
. #R$5E77 holds #N$08 minus the rank, so this gives back the row count
. that #R$F3BF returned in #REGb (#N$08 is first place).
  $F34B,$03 Fetch #R$5E77.
  $F34E,$02 Negate it.
  $F350,$02 Add #N$08.
  $F352,$01 Copy the row count into #REGb.
  $F353,$02 Double it.
  $F355,$01 Add the original count.
  $F356,$01 Copy the byte count into #REGc.
  $F357,$02 Clear #REGb.
N $F359 Move the names from the insert row down one row. The old last
. name is overwritten, and #REGde is left pointing at the freed slot.
  $F359,$02 Shuffle the table down.
N $F35B Copy the new name into the freed slot.
  $F35B,$03 #REGhl=#R$5E78.
  $F35E,$05 Copy the new #N$03-byte name into the table.
N $F363 Note which player is being ranked. This also acts as the
. insert flag for #R$F3BF, as it is never zero for 1UP or 2UP.
  $F363,$03 Fetch #R$5E71.
  $F366,$03 Write it to #R$5E74.
N $F369 Pick the score of the player who has just entered a name.
  $F369,$04 Jump to #R$F372 if this is 1UP.
  $F36D,$03 #REGde=#R$5E62.
  $F370,$02 Jump to #R$F375.
@ $F372 label=InsertHighScore_1UP
  $F372,$03 #REGde=#R$5E5F.
N $F375 Insert the score into the table at the rank found by #R$F3BF.
@ $F375 label=InsertHighScore_Compare
  $F375,$03 Call #R$F3BF.
N $F378 Check whether the other player also needs a name.
. #R$5E72 holds the number of the other player, or zero if there is
. nobody else waiting.
  $F378,$03 Fetch #R$5E72.
  $F37B,$04 Jump to #R$F33E if the other player is not pending.
N $F37F Send 2UP to its own handling, otherwise it is 1UP.
  $F37F,$05 Jump to #R$F39F if the other player is 2UP.
N $F384 Switch to the pending 1UP score and compare it
. with the table.
  $F384,$03 Write it to #R$5E71.
  $F387,$04 Write #N$00 to #R$5E72.
N $F38B Clearing #R$5E74 means that #R$F3BF only returns the rank and
. leaves the table alone. The score is inserted later, once this
. player has entered a name.
  $F38B,$03 #REGde=#R$5E5F.
  $F38E,$03 Write #N$00 to #R$5E74.
  $F391,$03 Call #R$F3BF.
N $F394 Restart if the score is too low, otherwise start name entry.
  $F394,$05 Jump to #R$F33E if the score is not high enough.
  $F399,$03 Call #R$F535.
  $F39C,$03 Jump to #R$F5E3.
N $F39F Switch to the pending 2UP score and compare it
. with the table.
@ $F39F label=InsertHighScore_2UPPending
  $F39F,$03 Write it to #R$5E71.
  $F3A2,$04 Write #N$00 to #R$5E72.
N $F3A6 As above, only rank the score; it is inserted after name entry.
  $F3A6,$03 #REGde=#R$5E62.
  $F3A9,$03 Write #N$00 to #R$5E74.
  $F3AC,$03 Call #R$F3BF.
N $F3AF Restart if the score is too low.
  $F3AF,$05 Jump to #R$F33E if the score is not high enough.
N $F3B4 Make 2UP the active player and start name entry.
  $F3B4,$05 Write #N$01 to #R$5E65.
  $F3B9,$03 Call #R$F535.
  $F3BC,$03 Jump to #R$F5E3.

c $F3BF Compare High Scores
@ $F3BF label=CompareHighScores
D $F3BF Compare the 3-byte score in #REGde against the table at
. #R$5E06 and return the insert rank in #REGb.
R $F3BF DE Pointer to the 3-byte score to test
R $F3BF O:B Rows from the insert point (#N$08 = top) or #N$00 if too low
N $F3BF Walk the eight high-score rows and return the insert rank.
  $F3BF,$02 Set a rank counter in #REGb for #N$08 loops.
  $F3C1,$01 Stash the score pointer on the stack.
  $F3C2,$03 #REGhl=#R$5E06.
N $F3C5 Compare the first byte of the score with the table row.
@ $F3C5 label=CompareHighScores_Loop
  $F3C5,$01 Fetch the table byte.
  $F3C6,$01 Fetch the score byte.
  $F3C7,$04 Jump to #R$F3D5 if the bytes match.
  $F3CB,$03 Jump to #R$F3F1 if the score is higher.
N $F3CE Move the table pointer on to the next row.
  $F3CE,$01 Advance the table pointer.
@ $F3CF label=CompareHighScores_AdvanceTable
  $F3CF,$01 Advance the table pointer.
@ $F3D0 label=CompareHighScores_NextRank
  $F3D0,$01 Advance the table pointer.
  $F3D1,$02 Decrease the rank by one and jump back to #R$F3C5
. until it is zero.
N $F3D3 Return with #REGb zero as the score is too low.
  $F3D3,$01 Restore the score pointer from the stack.
  $F3D4,$01 Return.
N $F3D5 Compare the second bytes when the first bytes match.
@ $F3D5 label=CompareHighScores_SecondByte
  $F3D5,$01 Advance the score pointer.
  $F3D6,$01 Advance the table pointer.
  $F3D7,$01 Fetch the table byte.
  $F3D8,$01 Fetch the score byte.
  $F3D9,$04 Jump to #R$F3E3 if the bytes match.
  $F3DD,$03 Jump to #R$F3F1 if the score is higher.
  $F3E0,$01 Rewind the score pointer.
  $F3E1,$02 Jump to #R$F3CF.
N $F3E3 Compare the third bytes when the second bytes match.
@ $F3E3 label=CompareHighScores_ThirdByte
  $F3E3,$01 Advance the table pointer.
  $F3E4,$01 Advance the score pointer.
  $F3E5,$01 Fetch the table byte.
  $F3E6,$01 Fetch the score byte.
  $F3E7,$03 Jump to #R$F3EC if the bytes match.
  $F3EA,$02 Jump to #R$F3F1 if the score is higher.
N $F3EC Rewind the score pointer and try the next row.
@ $F3EC label=CompareHighScores_RewindScore
  $F3EC,$02 Rewind the score pointer by two bytes.
  $F3EE,$03 Jump to #R$F3D0.
@ $F3F1 label=CompareHighScores_InsertScore
N $F3F1 Shuffle the table and insert the new score when
. #R$5E74 is set.
  $F3F1,$03 #REGde=#R$5E09(#N$5E1E).
  $F3F4,$01 Restore the score pointer from the stack.
  $F3F5,$03 Fetch #R$5E74.
  $F3F8,$02 Return if it is zero.
N $F3FA Work out how many bytes lie below the insert row.
  $F3FA,$02 Stash the rank and score pointer on the stack.
  $F3FC,$03 #REGhl=#R$5E09(#N$5E1B).
  $F3FF,$01 Copy the rank into #REGa.
  $F400,$02 Double it.
  $F402,$01 Add the original rank.
  $F403,$01 Copy the byte count into #REGc.
  $F404,$02 Clear #REGb.
  $F406,$02 Shuffle the lower scores down.
N $F408 Copy the new score into the freed row.
  $F408,$01 Restore the score pointer from the stack.
  $F409,$05 Copy the new #N$03-byte score into the table.
  $F40E,$01 Restore the rank from the stack.
  $F40F,$01 Return.

c $F410 Show Hall Of Fame
@ $F410 label=HallOfFame
D $F410 Paint the hall of fame page, print the ranks, names and
. scores, then wait for a number key or the timer.
N $F410 Paint the hall of fame attribute rows.
  $F410,$02 #REGa=#COLOUR$47.
  $F412,$02 Set a row counter in #REGc for #N$08 loops.
  $F414,$03 #REGhl=#N$5900.
@ $F417 label=HallOfFame_Loop
  $F417,$02 Set an attribute counter in #REGb for #N$40 loops.
@ $F419 label=HallOfFame_WriteAttribute
  $F419,$01 Write the attribute.
  $F41A,$01 Advance the attribute pointer.
  $F41B,$02 Decrease the column count by one and jump back to
. #R$F419 until it is zero.
N $F41D Step to the next band colour, going back to #COLOUR$44
. after #COLOUR$42.
  $F41D,$01 Decrease the attribute by one.
  $F41E,$04 Jump to #R$F424 if it is not #COLOUR$41.
  $F422,$02 #REGa=#COLOUR$44.
@ $F424 label=HallOfFame_NextRow
  $F424,$01 Decrease the row count by one.
  $F425,$02 Jump back to #R$F417 until it is zero.
N $F427 Handle printing "THE ULTIMATE" messaging.
  $F427,$03 #REGhl=#N$1850 (screen location).
  $F42A,$03 #REGde=#R$F4AA.
  $F42D,$03 Call #R$8A11.
N $F430 Handle printing "HALL OF FAME" messaging.
  $F430,$03 #REGhl=#N$2850 (screen location).
  $F433,$03 #REGde=#R$F4B8.
  $F436,$03 Call #R$8A11.
N $F439 Print the rank numbers down the page.
  $F439,$03 #REGhl=#N$4048 (screen location).
  $F43C,$01 Clear #REGa.
  $F43D,$02 #REGc=#N$31.
  $F43F,$02 Set a rank counter in #REGb for #N$08 loops.
@ $F441 label=HallOfFame_Rank_Loop
  $F441,$01 Stash the row address on the stack.
  $F442,$03 Call #R$851E.
  $F445,$01 Copy the rank character into #REGa.
  $F446,$03 Call #R$89EF.
  $F449,$01 Restore the row address from the stack.
  $F44A,$04 Move down two character rows.
  $F44E,$01 Increase the rank character by one.
  $F44F,$02 Decrease the rank count by one and jump back to
. #R$F441 until it is zero.
N $F451 Print the eight names.
  $F451,$03 #REGhl=#N$4060 (screen location).
  $F454,$03 #REGde=#R$5E20.
  $F457,$02 Set a name counter in #REGc for #N$08 loops.
@ $F459 label=HallOfFame_PrintName
  $F459,$01 Stash the row address on the stack.
  $F45A,$03 Call #R$851E.
N $F45D Print the three letters of the name.
  $F45D,$02 Set a letter counter in #REGb for #N$03 loops.
@ $F45F label=HallOfFame_PrintLetter
  $F45F,$01 Fetch the next name letter.
  $F460,$03 Call #R$89EF.
  $F463,$01 Advance the name pointer.
  $F464,$02 Decrease the letter count by one and jump back to
. #R$F45F until it is zero.
N $F466 Move down to the row for the next name.
  $F466,$01 Restore the row address from the stack.
  $F467,$04 Move down two character rows.
  $F46B,$01 Decrease the name count by one.
  $F46C,$02 Jump back to #R$F459 until it is zero.
N $F46E Print the eight scores.
  $F46E,$02 Set a score counter in #REGc for #N$08 loops.
  $F470,$03 #REGde=#R$5E06.
  $F473,$03 #REGhl=#N$4088.
@ $F476 label=HallOfFame_PrintScore
  $F476,$02 Set a score byte counter in #REGb for #N$03 loops.
  $F478,$01 Stash #REGhl on the stack.
  $F479,$03 Call #R$851E.
  $F47C,$03 Call #R$89D7.
  $F47F,$01 Restore #REGhl from the stack.
  $F480,$04 #REGh=#REGh+#N$10.
  $F484,$01 Decrease #REGc by one.
  $F485,$02 Jump back to #R$F476 until #REGc is zero.
N $F487 Set the timeout and wait for a number key.
  $F487,$05 Write #N$01 to #R$5E74.
  $F48C,$06 Write #N$0400 to #R$5E6D.
@ $F492 label=HallOfFame_WaitKey
  $F492,$01 Enable interrupts.
  $F493,$01 Wait for the next interrupt.
N $F494 Count the timeout down.
  $F494,$03 Fetch #R$5E6D.
  $F497,$01 Decrease it by one.
  $F498,$03 Write it back.
N $F49B Read the number keys and return if any is pressed.
  $F49B,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$E7 | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 }
. TABLE#
  $F4A1,$01 Flip the bits.
  $F4A2,$02,b$01 Keep only bits 0-4.
  $F4A4,$01 Return if any number key is pressed.
  $F4A5,$04 Jump back to #R$F492 if the timer is not zero.
  $F4A9,$01 Return.

t $F4AA Messaging: Hall Of Fame
N $F4AA #FONTaddr=$D347,attr=$45,chars=0(THE ULTIMATE)(ultimate)
@ $F4AA label=String_Ultimate
  $F4AA,$0E,h$01,$0C:$01 Attribute: #COLOUR(#PEEK(#PC)) + "THE ULTIMATE ".
N $F4B8 #FONTaddr=$D347,attr=$45,chars=0(HALL OF FAME)(hall-of-fame)
@ $F4B8 label=String_HallOfFame
  $F4B8,$0E,h$01,$0C:$01 Attribute: #COLOUR(#PEEK(#PC)) + "HALL OF FAME ".

c $F4C6 Handler: High Score Messaging
@ $F4C6 label=HighScoreMessaging
D $F4C6 Prints the "CONGRATULATIONS PLAYER" message with the player
. number from #R$5E71, then "TODAYS" followed by the rank text from
. #R$F232, and "JETMAN WILL REMEMBER YOU". Finally draws three
. six-pixel dashes where the player's initials will go.
. #PUSHS #UDGTABLE { #SIM(start=$800A,stop=$8024,sp=$5E00)
. #SIM(start=$81BB,stop=$81D6,sp=$5E00)
. #POKES$5E71,$01
. #SIM(start=$F535,stop=$F56D,bc=$0800,sp=$5E00)
. #SCR$02(high-score-entry) } UDGTABLE# #POPS
N $F4C6 Handle printing "CONGRATULATIONS PLAYER ..." messaging.
  $F4C6,$03 #REGde=#R$F4FB.
  $F4C9,$03 #REGhl=#N$6020 (screen location).
  $F4CC,$03 Call #R$8A11.
N $F4CF Handle printing the player "number".
  $F4CF,$05 #REGa=*#R$5E71 + #N$30 (convert to ASCII).
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
N $F4EF Draw a dash for each of the three initials.
  $F4EF,$03 #REGhl=#N$53AD (screen buffer location).
  $F4F2,$02 Set a dash counter in #REGb for #N$03 loops.
@ $F4F4 label=HighScoreMessaging_Loop
  $F4F4,$02,b$01 Write #N$7E to *#REGhl.
  $F4F6,$02 Move on two columns, the spacing of the initials.
  $F4F8,$02 Decrease the counter by one and jump back to
. #R$F4F4 until it is zero.
  $F4FA,$01 Return.

t $F4FB Messaging: High Score
N $F4FB #FONTaddr=$D347,attr=$47,chars=0(CONGRATULATIONS PLAYER X)(congratulations)
@ $F4FB label=String_Congratulations
  $F4FB,$18,h$01,$16:$01 Attribute: #COLOUR(#PEEK(#PC)) + "CONGRATULATIONS PLAYER ".
@ $F510 label=String_Congratulations_Player
N $F513 #FONTaddr=$D347,attr=$47,chars=0(TODAYS)(todays)
@ $F513 label=String_Todays
  $F513,$08,h$01,$06:$01 Attribute: #COLOUR(#PEEK(#PC)) + "TODAYS ".
N $F51B #FONTaddr=$D347,attr=$47,chars=0(JETMAN WILL REMEMBER YOU)(remember)
@ $F51B label=String_Remember
  $F51B,$1A,h$01,$18:$01 Attribute: #COLOUR(#PEEK(#PC)) + "JETMAN WILL REMEMBER YOU ".

c $F535 Prepare Name Entry
@ $F535 label=PrepareNameEntry
D $F535 Store the high-score position, blank the screen and show the
. congratulations banner, then seed the name as "AAA" and reset the
. name entry timer, cursor and index.
R $F535 B Insert row count from #R$F3BF
N $F535 Store the rank and paint the congratulations page.
  $F535,$01 Copy the rank into #REGa.
  $F536,$02 Subtract #N$08.
  $F538,$02 Negate it.
  $F53A,$03 Write it to #R$5E77.
  $F53D,$03 Call #R$84D8.
N $F540 Set the attributes for the congratulations page.
  $F540,$03 #REGhl=#N$5900.
  $F543,$02 Set a row counter in #REGc for #N$02 loops.
  $F545,$02 #REGa=#COLOUR$46.
@ $F547 label=PrepareNameEntry_Loop
  $F547,$02 Set an attribute counter in #REGb for #N$100 loops.
@ $F549 label=PrepareNameEntry_FillAttributes
  $F549,$01 Write #REGa to *#REGhl.
  $F54A,$01 Increment #REGhl by one.
  $F54B,$02 Decrease the counter by one and jump back to
. #R$F549 until it is zero.
  $F54D,$01 Decrease #REGc by one.
  $F54E,$02 Jump back to #R$F547 until #REGc is zero.
N $F550 Print the congratulations banner.
  $F550,$03 Call #R$F4C6.
N $F553 Reset the name entry timer, screen pointer and
. letter index.
  $F553,$06 Write #N($1000,$04,$04) to #R$5E6D.
  $F559,$06 Write #N$50AD to #R$5E75.
  $F55F,$04 Write #N$00 to #R$5E6F.
N $F563 Seed the name with "AAA".
  $F563,$03 #REGhl=#R$5E78.
  $F566,$02 Set a letter counter in #REGb for #N$03 loops.
@ $F568 label=PrepareNameEntry_FillLetters
  $F568,$02 Write #N$41 to *#REGhl.
  $F56A,$01 Increment #REGhl by one.
  $F56B,$02 Decrease the counter by one and jump back to
. #R$F568 until it is zero.
  $F56D,$01 Return.

c $F56E Handler: New High Score
@ $F56E label=NewHighScore
D $F56E Compare #R$5E5F with #R$5E62 and start name entry for the
. higher score.
  $F56E,$03 #REGde=#R$5E5F.
  $F571,$03 #REGhl=#R$5E62.
N $F574 Compare the first bytes of the 1UP and 2UP scores.
  $F574,$01 Fetch the 1UP score byte.
  $F575,$01 Compare it with the 2UP score byte.
  $F576,$03 Jump to #R$F5BF if 2UP is higher.
  $F579,$02 Jump to #R$F57D if the bytes match.
  $F57B,$02 Jump to #R$F58F.
N $F57D Compare the second bytes when the first bytes match.
@ $F57D label=NewHighScore_SecondByte
  $F57D,$01 Advance the 1UP pointer.
  $F57E,$01 Fetch the next 1UP byte.
  $F57F,$01 Advance the 2UP pointer.
  $F580,$01 Compare it with the 2UP byte.
  $F581,$03 Jump to #R$F5BF if 2UP is higher.
  $F584,$02 Jump to #R$F588 if the bytes match.
  $F586,$02 Jump to #R$F58F.
N $F588 Compare the third bytes when the second bytes match.
@ $F588 label=NewHighScore_ThirdByte
  $F588,$01 Advance the 1UP pointer.
  $F589,$01 Advance the 2UP pointer.
  $F58A,$01 Fetch the last 1UP byte.
  $F58B,$01 Compare it with the 2UP byte.
  $F58C,$03 Jump to #R$F5BF if 2UP is higher.
@ $F58F label=NewHighScore_Rank1UP
N $F58F Rank 1UP first.
  $F58F,$05 Write #N$02 to #R$5E72.
  $F594,$05 Write #N$01 to #R$5E71.
N $F599 Clear the pending player if this is a one-player game.
  $F599,$03 Fetch #R$5E00.
  $F59C,$05 Jump to #R$F5A5 if bit 0 is set.
  $F5A1,$04 Write #N$00 to #R$5E72.
N $F5A5 Test the 1UP score against the table and start name
. entry if it is high enough.
@ $F5A5 label=NewHighScore_Compare1UP
  $F5A5,$03 #REGde=#R$5E5F.
  $F5A8,$04 Write #N$00 to #R$5E74.
  $F5AC,$03 Call #R$F3BF.
  $F5AF,$05 Jump to #R$F33E if the score is not high enough.
  $F5B4,$05 Write #N$01 to #R$5E73.
  $F5B9,$03 Call #R$F535.
  $F5BC,$03 Jump to #R$F295.
@ $F5BF label=NewHighScore_Rank2UP
N $F5BF Rank 2UP first.
  $F5BF,$02 #REGc=#N$4A.
N $F5C1 Test the 2UP score against the table.
  $F5C1,$03 #REGde=#R$5E62.
  $F5C4,$04 Write #N$00 to #R$5E74.
  $F5C8,$03 Call #R$F3BF.
  $F5CB,$05 Jump to #R$F33E if the score is not high enough.
N $F5D0 Make 2UP the player entering a name with 1UP pending,
. then start name entry.
  $F5D0,$05 Write #N$02 to #R$5E71.
  $F5D5,$05 Write #N$01 to #R$5E72.
  $F5DA,$03 Write it to #R$5E73.
  $F5DD,$03 Call #R$F535.
  $F5E0,$03 Jump to #R$F295.

c $F5E3 Start Name Entry
@ $F5E3 label=StartNameEntry
D $F5E3 Pause briefly, enable interrupts, wait for the next interrupt
. and jump back to the hall of fame input loop.
N $F5E3 Pause briefly, then wait for the next interrupt.
  $F5E3,$02 #REGb=#N$00.
@ $F5E5 label=StartNameEntry_Loop
  $F5E5,$02 Delay until #REGb is zero.
  $F5E7,$01 Enable interrupts.
  $F5E8,$01 Wait for the next interrupt.
  $F5E9,$03 Jump to #R$F295.

c $F5EC Print 1UP/ 2UP Levels
@ $F5EC label=PrintPlayerLevels
D $F5EC Colours the level display for each player green, then prints
. each player's level as "L" followed by two digits (1UP on the left,
. 2UP on the right). #R$5E65 decides which of the active and inactive
. player levels is used for each.
N $F5EC Colour the 1UP level green. Both levels are on pixel row #N$08
. (character row #N$01): 1UP starts at X=#N$48 (column #N$09) and 2UP starts
. at X=#N$A0 (column #N$14).
  $F5EC,$03 Set the 1UP level pixel co-ordinates in #REGhl (Y=#N$08, X=#N$48).
  $F5EF,$03 Call #R$F662 to colour the three level characters green.
N $F5F2 Colour the 2UP level green.
  $F5F2,$03 Set the 2UP level pixel co-ordinates in #REGhl (Y=#N$08, X=#N$A0).
  $F5F5,$03 Call #R$F662 to colour the three level characters green.
N $F5F8 Is the active player 1UP or 2UP?
  $F5F8,$06 If #R$5E65 is not zero, jump to #R$F609.
N $F5FE Handler for printing the 1UP (active) level followed by the 2UP
. (inactive) level.
  $F5FE,$03 Set the 1UP level pixel co-ordinates in #REGhl (Y=#N$08, X=#N$48).
  $F601,$03 Call #R$F612.
  $F604,$03 Set the 2UP level pixel co-ordinates in #REGhl (Y=#N$08, X=#N$A0).
  $F607,$02 Jump to #R$F628.
N $F609 Handler for printing the 1UP (inactive) level followed by the 2UP
. (active) level.
@ $F609 label=Handler_PrintPlayerLevels
  $F609,$03 Set the 1UP level pixel co-ordinates in #REGhl (Y=#N$08, X=#N$48).
  $F60C,$03 Call #R$F628.
N $F60F Handles the 2UP level.
  $F60F,$03 Set the 2UP level pixel co-ordinates in #REGhl (Y=#N$08, X=#N$A0).
N $F612 Handles displaying "#FONTaddr=$D347,attr=$47,chars=0(L)(level)" for
. the active player.
@ $F612 label=Print_ActivePlayerLevel
  $F612,$02 #REGa=#N$4C.
  $F614,$03 Call #R$F632.
  $F617,$03 Call #R$F641.
N $F61A Prints the first digit (held in #REGa from #REGb).
@ $F61A label=PrintLevel
  $F61A,$01 Stash #REGbc on the stack.
  $F61B,$02 Add #N$30 to convert to an ASCII character
. (starting at "0").
  $F61D,$03 Call #R$F632.
  $F620,$01 Restore #REGbc from the stack.
N $F621 Now move onto the second digit held in #REGc.
  $F621,$01 #REGa=#REGc.
  $F622,$02 Add #N$30 to convert to an ASCII character
. (starting at "0").
  $F624,$03 Call #R$F632.
  $F627,$01 Return.
N $F628 Handles displaying "#FONTaddr=$D347,attr=$47,chars=0(L)(level)" for
. the inactive player.
@ $F628 label=Print_InactivePlayerLevel
  $F628,$02 #REGa=#N$4C.
  $F62A,$03 Call #R$F632.
  $F62D,$03 Call #R$F658.
  $F630,$02 Jump to #R$F61A.
N $F632 Keep #REGhl (pixel co-ordinates) and #REGaf
. (the ASCII character to print) for later.
@ $F632 label=PrintLevelMessaging
  $F632,$02 Stash #REGhl and #REGaf on the stack.
  $F634,$03 Call #R$851E.
N $F637 Fetch the ASCII character we want to print from the stack.
  $F637,$01 Restore #REGaf from the stack.
  $F638,$03 Call #R$89EF.
N $F63B Restore the pixel co-ordinates from the stack, and
. move onto the next character column.
  $F63B,$01 Restore #REGhl from the stack.
  $F63C,$04 #REGl=#REGl+#N$08.
  $F640,$01 Return.

c $F641 Get Level Digits
@ $F641 label=Calculate_ActivePlayer_Level
D $F641 Converts the level of the active player into two digits using
. #R$B699, with a level of #N($FF) treated as #N$00. The units digit is
. returned in #REGc and the tens digit in #REGa.
R $F641 O:A Tens digit of the level
R $F641 O:C Units digit of the level
N $F641 Convert the active player's level into two digits.
  $F641,$07 If #R$5EA0 is not #N($FF), jump to #R$F649.
  $F648,$01 #REGa=#N$00.
N $F649 This reads #REGa into #REGbc as two nibbles, e.g. level 21 would be #EVAL($15,$02,$08) which returns #N$2101.
@ $F649 label=Calculate_Player_Level
  $F649,$03 Call #R$B699.
  $F64C,$01 #REGb=#REGa.
  $F64D,$02,b$01 Keep only bits 0-3.
  $F64F,$01 #REGc=#REGa.
N $F650 Shift the tens digit down into #REGa.
  $F650,$01 #REGa=#REGb.
  $F651,$04 Rotate the bits of #REGa right four times.
  $F655,$02,b$01 Keep only bits 0-3.
  $F657,$01 Return.

c $F658 Get Inactive Level Digits
@ $F658 label=Calculate_InactivePlayer_Level
D $F658 Converts the level of the inactive player into two digits in the
. same way as #R$F641, with a level of #N($FF) treated as #N$00.
R $F658 O:A Tens digit of the level
R $F658 O:C Units digit of the level
  $F658,$07 If #R$5EA4 is not #N($FF), jump to #R$F649.
  $F65F,$01 #REGa=#N$00.
  $F660,$02 Jump to #R$F649.

c $F662 Helper: Colour Levels Messaging Green
@ $F662 label=ColourLevelsGreen
D $F662 Colour the level digits green at the given pixel address.
R $F662 HL Pixel address co-ordinates
  $F662,$03 Call #R$8506.
  $F665,$02 Set a character counter in #REGb for #N$03 loops.
  $F667,$02 #REGa=#COLOUR$44.
@ $F669 label=ColourLevelsGreen_Loop
  $F669,$01 Write #REGa to *#REGhl.
  $F66A,$01 Increment #REGhl by one.
  $F66B,$02 Decrease the counter by one and jump back to
. #R$F669 until it is zero.
  $F66D,$01 Return.

b $F66E Terrain UDGs
@ $F66E label=TerrainUDGs
  $F66E,$08 #UDG(#PC,attr=$43)
L $F66E,$08,$0C

b $F6CE Default Terrain Data
@ $F6CE label=TerrainData_Default
  $F6CE,$10 #FOR($00,$0F)||n|#UDG($F66E + #PEEK(#PC + n) * $08,attr=$43)||
L $F6CE,$10,$40

u $FACE Unused
@ $FACE label=Unused_After_Terrain_Data
D $FACE Leftover bytes after #R$F6CE.

i $FC00

b $FF44 Tune Buffer
@ $FF44 label=Tune_Buffer
D $FF44 #R$B9BC writes note bytes downwards from #R$FF51.
@ $FF51 label=Tune_Buffer_End
B $FF44,$10,$01

w $FF54 Tune Pointer
@ $FF54 label=Tune_Pointer
D $FF54 Address of the next note in #R$FF44.
W $FF54,$02

u $FF56 Unused
@ $FF56 label=Unused_After_Tune_Pointer

u $FF88 Unused
@ $FF88 label=Unused_At_Top_Of_Memory
D $FF88 Unused. #R$9359 adds the constant #N$FF88 (minus #N$78) to the
. scroll position, but this memory is never read or written.
