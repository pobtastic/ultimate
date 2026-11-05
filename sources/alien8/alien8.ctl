; Copyright Ashby Computers & Graphics Ltd 1985, Rare Ltd, 2026 ArcadeGeek LTD.
> $4000 @org=$4000
> $4000 @rom
> $4000 @expand=#DEF(#POKE()(anchor,text) #LINK(Pokes#$anchor)($text))
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))
b $4000 Loading screen
D $4000 #UDGTABLE { =h Alien 8 Loading Screen }
. { #SCR$02(loading) } UDGTABLE#
N $4000 The frame around the loading screen is used as the border of every
. page of this disassembly.
. #HTML(<div hidden>)
. #SCR$02,$00,$00,$20,$15(screen-frame)
. #HTML(</div>)
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

g $5B00 Random Seed 1
@ $5B00 label=RandomSeed1
D $5B00 The first random number seed. It is set from the low byte of
. #SKOOLKID$5C78(FRAMES) when the game is loaded, goes up by one every time
. the menu is redrawn, and is used to choose where the special objects are
. placed and where the player starts.
B $5B00,$01

u $5B01 Unused
D $5B01 This byte is never used.
B $5B01,$01

g $5B02 Frame Counter
@ $5B02 label=FrameCounter
D $5B02 Counts the frames of the game, which also makes it an address that moves
. through the ROM, so that the byte found there is added into #R$5B05 to stir it
. up. The low byte times the animations and the sound effects and is used as a
. source of random numbers.
W $5B02,$02

g $5B04 Control Method
@ $5B04 label=ControlMethod
D $5B04 The control method chosen in the menu.
. #TABLE(default,centre,left)
. { =h Bits | =h Meaning }
. { #N$01-#N$02 | #N$00 keyboard, #N$01 Kempston,
. #N$02 cursor, #N$03 Interface II }
. { #N$03 | Set when directional control is on }
. TABLE#
B $5B04,$01

g $5B05 Random Seed 2
@ $5B05 label=RandomSeed2
D $5B05 The second random number seed, which is the one the game normally asks
. for when it needs a random number. It is stirred up once on every pass of the
. main loop.
B $5B05,$01

g $5B06 Previous Control Method
@ $5B06 label=PreviousControlMethod
D $5B06 The value of #R$5B04 when the menu was last scanned, used to make a
. sound when the selection changes.
B $5B06,$01

u $5B07 Unused
D $5B07 This byte is never used.
B $5B07,$01

g $5B08 Wiped Area Count
@ $5B08 label=WipedAreaCount
D $5B08 The number of regions of the screen buffer which have been wiped by
. #R$CEAB and are waiting on the stack to be copied to the screen. This is the
. first of the variables which are cleared at the start of every game.
B $5B08,$01

g $5B09 Saved Stack Pointer
@ $5B09 label=SavedStackPointer
D $5B09 The stack pointer, saved while #R$D027 uses it to read the sprite data.
W $5B09,$02

g $5B0B Room Size X
@ $5B0B label=RoomSize_X
D $5B0B The distance from the middle of the current room to its east and west
. walls.
B $5B0B,$01

g $5B0C Room Size Y
@ $5B0C label=RoomSize_Y
D $5B0C The distance from the middle of the current room to its north and south
. walls.
B $5B0C,$01

g $5B0D Room Colour
@ $5B0D label=RoomColour
D $5B0D The colour of the current room (an ink colour from #N$00 to #N$07),
. which is used for the whole of the attribute file.
B $5B0D,$01

g $5B0E Floor Height
@ $5B0E label=FloorHeight
D $5B0E The level of the floor of the current room: an object which would sink
. below this height lands on the floor instead.
B $5B0E,$01

u $5B0F Unused
D $5B0F These bytes are never used.
B $5B0F,$03

g $5B12 Room Flags
@ $5B12 label=RoomFlags
D $5B12 Bit 0 is set on every pass of the main loop and is cleared again when
. the objects of the room have been saved to the special objects table by
. #R$AF05. It is clear at the start of a game so that nothing is saved before
. the first room has been built.
B $5B12,$01

g $5B13 Pickup Drop Pressed Flag
@ $5B13 label=PickupDropPressedFlag
D $5B13 Set while the pick up and drop key is held down, so that an object is
. only picked up or dropped once for each press.
B $5B13,$01

g $5B14 Objects Carried Changed Flag
@ $5B14 label=ObjectsCarriedChangedFlag
D $5B14 Set when the player picks up or drops an object, to say that the carried
. objects shown in the panel have to be redrawn.
B $5B14,$01

g $5B15 Controls Pressed
@ $5B15 label=ControlsPressed
D $5B15 The directions and actions chosen by
. the player on this pass, as read by #R$C8FF.
. #TABLE(default,centre,left)
. { =h Bit | =h Control }
. { #N$00 | Left }
. { #N$01 | Right }
. { #N$02 | Forward }
. { #N$03 | Jump }
. { #N$04 | Pick up or drop }
. { #N$05 | Set by #R$C9EE }
. TABLE#
B $5B15,$01

g $5B16 Text Attribute
@ $5B16 label=TextAttribute
D $5B16 The attribute used when printing text.
B $5B16,$01

g $5B17 Redraw Panel Flag
@ $5B17 label=RedrawPanelFlag
D $5B17 Set when a new room has been built, or an ending scene is being shown,
. to say that the status panel and the colours have to be redrawn on this pass
. of the main loop.
B $5B17,$01

g $5B18 Border Drawn Flag
@ $5B18 label=BorderDrawnFlag
D $5B18 Set by #R$BC31 once it has printed the border, so that the border is
. only drawn the first time that a list of text is displayed. It is cleared by
. the menu (#R$BA7E) and by the game completed scene (#R$B8A9).
B $5B18,$01

g $5B19 Position Offset
@ $5B19 label=PositionOffset
D $5B19 The offset applied to the positions of the objects as #R$CCA7 builds a
. room, set by the objects of type #N$00 in the data for the room (see #R$6469).
. Bit 0 moves the objects half a place along the x axis, bit 1 half a place
. along the y axis, and bits 2 to 7 up the z axis.
B $5B19,$01

g $5B1A Lives
@ $5B1A label=Lives
D $5B1A The number of lives the player has left (as a BCD number).
B $5B1A,$01

g $5B1B Saved Position
@ $5B1B label=SavedPosition
D $5B1B A copy of the x, y and z coordinates of a block, which #R$B2D9 saves and
. #R$B2EB compares with the current position to find out whether the block has
. moved.
B $5B1B,$03

g $5B1E Objects Drawn
@ $5B1E label=ObjectsDrawn
D $5B1E The number of objects drawn on this pass of the main loop. It is used to
. slow the game down when there are only a few objects.
B $5B1E,$01

u $5B1F Unused
D $5B1F This byte is never used.
B $5B1F,$01

g $5B20 Object Type Table Address
@ $5B20 label=ObjectTypeTableAddress
D $5B20 While a room is built by #R$CCA7 this word holds the address of the
. table of object types that is in use: #R$73C8 at first, and #R$7408 once an
. object of type #N$1F has been met in the data for the room. Its high byte is
. also used by #R$C296 to hold the vertical speed of the player before it was
. adjusted by the collision routines.
B $5B20,$01 The low byte of the address.
@ $5B21 label=PreviousVerticalSpeed
B $5B21,$01 The high byte of the address, or the previous vertical speed.

u $5B22 Unused
D $5B22 This byte is never used.
B $5B22,$01

g $5B23 Game Completed Flag
@ $5B23 label=GameCompletedFlag
D $5B23 Set when all of the cryogenic chambers have been activated.
B $5B23,$01

g $5B24 Game Over Flag
@ $5B24 label=GameOverFlag
D $5B24 Set when the scene for the end of the game is about to be shown (see
. #R$B761), and not cleared again until the game restarts. While it is set the
. pixel positions of the objects are left as the scene set them (#R$CFD2), no
. controls are read (#R$C8FF) and the main loop only refreshes the screen when
. the panel needs to be redrawn (#R$A6F7).
B $5B24,$01

g $5B25 Block Scratch
@ $5B25 label=BlockScratch
D $5B25 The height (Z coordinate) up to which a block that is being moved by
. #R$B31F or #R$B33F rises after it has been pushed down. It is set from the
. block that is handled first while it is zero (#R$B31F adds #N$30 to the height
. of its block) and it is cleared when a room is built. The use of the height is
. inferred from #R$B38C, where the rising stops once a block is higher than it.
B $5B25,$01

u $5B26 Unused
D $5B26 This byte is never used.
B $5B26,$01

g $5B27 Font Pointer
@ $5B27 label=FontPointer
D $5B27 The address of the font used by #R$BBEB when printing text.
W $5B27,$02

u $5B29 Unused
D $5B29 These bytes are never used.
B $5B29,$02

g $5B2B Drawing List Pointer
@ $5B2B label=DrawingListPointer
D $5B2B The address of the next entry in the list of objects to draw, which
. #R$CEAB and #R$C78D step through.
W $5B2B,$02

g $5B2D First List Position
@ $5B2D label=FirstListPosition
D $5B2D The address in the list at #R$C745 just after the entry of the first
. object of the pair that #R$C78D is comparing (the object at #REGix). When that
. object is drawn, #R$C8D5 uses this address to flag its entry as drawn.
W $5B2D,$02

g $5B2F Second List Position
@ $5B2F label=SecondListPosition
D $5B2F The address in the list at #R$C745 just after the entry of the other
. object of the pair that #R$C78D is comparing (the object at #REGiy). If that
. object has to be drawn first, #R$C86F copies this address to #R$5B2D.
W $5B2F,$02

g $5B31 Tune Played Flag
@ $5B31 label=TunePlayedFlag
D $5B31 Set to one when the menu tune has been played, so that it is only played
. once (see #R$B4A1).
B $5B31,$01

g $5B32 Directional Key Pressed Flag
@ $5B32 label=DirectionalKeyPressedFlag
D $5B32 Bit 0 is set while the key for directional control is held down in the
. menu, so that the setting is only switched once for each press.
B $5B32,$01

g $5B33 No Room To Drop Flag
@ $5B33 label=NoRoomToDropFlag
D $5B33 Set when the player is not allowed to drop an object where they are
. standing.
B $5B33,$01

g $5B34 Chamber Address
@ $5B34 label=ChamberAddress
D $5B34 The address, in the data for the rooms, of the chamber in the current
. room. When a chamber is activated #R$AF79 sets the three lowest bits of the
. byte at this address to show that the chamber has been used.
W $5B34,$02

g $5B36 Light Years Remaining
@ $5B36 label=LightYearsRemaining
D $5B36 The four digits of the light years remaining counter. Each byte holds a
. digit in its upper four bits and in its lower three bits the stage of the
. rolling animation that is used when the digit changes (see #R$ADC9). The game
. is over when all four digits are zero.
B $5B36,$02 Upper two digits.
B $5B38,$01 Third digit.
@ $5B39 label=LightYearsRemaining_LastDigit
B $5B39,$01 Last digit.

g $5B3A Egg Top Flag
@ $5B3A label=EggTopFlag
D $5B3A Set while an egg top (object #N$49) is falling, so that only one of them
. falls at a time.
B $5B3A,$01

g $5B3B Egg Top Disabled Flag
@ $5B3B label=EggTopDisabledFlag
D $5B3B Set when a room is built if the room number is even, and cleared when
. the player picks up an object or an extra life. While it is set the egg top
. (object #N$49) does not move.
B $5B3B,$01

g $5B3C Cryonauts Lost
@ $5B3C label=CryonautsLost
D $5B3C The number of cryonauts who will be lost, as a four digit BCD number.
. #R$AC6B counts the cryonauts in the chambers which have not been activated,
. for the game over display.
B $5B3C,$01 Upper two digits.
@ $5B3D label=CryonautsLost_LowerDigits
B $5B3D,$01 Lower two digits.

g $5B3E Chambers Found Activated
@ $5B3E label=ChambersFoundActivated
D $5B3E The number of chambers found to be activated by #R$AC6B, as a BCD
. number.
B $5B3E,$01

g $5B3F Chambers Not Activated
@ $5B3F label=ChambersNotActivated
D $5B3F The number of chambers found not to be activated by #R$AC6B, as a BCD
. number.
B $5B3F,$01

g $5B40 Chambers Activated
@ $5B40 label=ChambersActivated
D $5B40 The number of cryogenic chambers that the player has activated so far,
. as a BCD number. The game is completed when it reaches #N$24.
B $5B40,$01

g $5B41 Game Over Scene Stage
@ $5B41 label=GameOverSceneStage
D $5B41 Zero until the alarm in the game over scene has flashed #N$10 times (see
. #R$ABF5). Then it is set to #N($01), and is used by the objects which
. attack the robot: bit 7 is set while one of them is moving, and the
. lower bits count the attacks that have been made. The game restarts when
. the count reaches #N$10.
B $5B41,$01

g $5B42 Remote Control Command
@ $5B42 label=RemoteControlCommand
D $5B42 The command sent to the remote control robot by the pads in the room:
. #N$01 to stop, or #N$02 to #N$05 to go west, north, east or south. Bit 7 is
. set while a robot is listening for commands (see #R$A9C7).
B $5B42,$01

g $5B43 Land Mine Flag
@ $5B43 label=LandMineFlag
D $5B43 Set while one of the land mines is leaping, so that only one of them
. leaps at a time (see #R$A8F9).
B $5B43,$01

u $5B44 Unused
D $5B44 These bytes are never used.
B $5B44,$14

g $5B58 Rooms Visited Bitmap
@ $5B58 label=RoomsVisitedBitmap
D $5B58 One bit for each of the #N$0100 rooms, set when the player has been into
. the room. They are counted for the game over display.
B $5B58,$20

g $5B78 Objects Carried Header
@ $5B78 label=ObjectsCarriedHeader
D $5B78 The record of the object that was picked up last, with the same layout
. as the entries that follow (see #R$5B7C). It is written by #R$BE76 from the
. object number, the flags and the two bytes at offsets #N$10 and #N$11 of the
. record of the object that has been picked up (the byte which they address is
. cleared), and it is cleared by #R$BE6B. Why the record is kept here is not yet
. known.
B $5B78,$04

g $5B7C Objects Carried
@ $5B7C label=ObjectsCarried
D $5B7C The objects that the player is carrying. There is room for three, each
. using four bytes: the first byte of each is the number of the object (or zero
. for an empty space), the second is its flags and the other two are an address
. that was held in the record of the object. The status panel shows the objects
. by drawing their sprites.
B $5B7C,$04 The first object.
@ $5B80 label=ObjectsCarried_Second
B $5B80,$03 The second object.
@ $5B83 label=ObjectsCarried_SecondEnd
B $5B83,$01 The last byte of the second object.
@ $5B84 label=ObjectsCarried_Third
B $5B84,$03 The third object.
@ $5B87 label=ObjectsCarried_ThirdEnd
B $5B87,$01 The last byte of the third object.

g $5B88 Player Bottom Object
@ $5B88 label=PlayerBottomObject
D $5B88 The object for the lower half of the robot. Every object in the game is
. held in a block of #N$20 bytes: byte #N$00 is the number of the sprite (zero
. if the slot is unused), #N$01 to #N$03 are the x, y and z coordinates, #N$04
. to #N$06 the width, depth and height, #N$07 the flags, #N$09 to #N$0B the
. speeds along each axis, #N$0C and #N$0D more flags, #N$10 and #N$11 are for
. use by the update routine of the object, #N$12 and #N$13 are the pixel offsets
. of the sprite and #N$18 to #N$1B are the size and position of the sprite on
. the screen.
B $5B88,$01 Number of the sprite.
@ $5B89 label=PlayerBottomObject_X
B $5B89,$01 X coordinate.
B $5B8A,$05 Y and Z coordinates, and the width, depth and height.
@ $5B8F label=PlayerBottomObject_Flags
B $5B8F,$01 Flags.
B $5B90,$18 The rest of the record of the object.

g $5BA8 Player Top Object
@ $5BA8 label=PlayerTopObject
D $5BA8 The object for the upper half of the robot.
B $5BA8,$20

g $5BC8 Special Object Slots
@ $5BC8 label=SpecialObjectSlots
D $5BC8 The objects for the special objects (the valves and the extra lives)
. which are in the current room. They are copied from the table at #R$76E3 when
. the room is built by #R$AE99, and back again by #R$AF05.
B $5BC8,$40

g $5C08 Room Objects
@ $5C08 label=RoomObjects
D $5C08 The rest of the objects in the current room, which are built by #R$CCA7:
. the walls, the blocks and anything else that was put there by the data for the
. room.
B $5C08,$0680

u $6288 Unused
@ $6288 label=UnusedAfterObjects
D $6288 These bytes are never used. They hold whatever the tape loader left
. behind.
B $6288,$78,$08

c $6300 Game Entry Point
@ $6300 label=GameEntry
D $6300 The address which the tape loader
. jumps to once the game has been loaded. It
. disables interrupts, puts the stack just
. below #R$F100, and starts the game.
E $6300 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$6100 }
. LIST#
N $6300 Disable interrupts and start the game.
  $6300,$01 Disable interrupts.
  $6301,$03 Set the stack pointer to #N$F100.
  $6304,$01 No operation.
  $6305,$03 Jump to #R$A631.

b $6308 Font
@ $6308 label=Font
D $6308 The font used for all of the text in the game, which has a glyph for
. each of the characters from "0" (ASCII #N$30) to "Z" (ASCII #N$5A), eight
. bytes per glyph. Between "9" and "A" the characters are used for other things:
. ":" is a second zero, ";" is a full stop, "<" is a hyphen, "=" is the space,
. ">" is the copyright symbol and "?" and "@" are blank. Text is printed by
. using the character code as an index from
. #N($6188), which is where glyph #N$00
. would be if the font started at ASCII #N$00. The digits of the numbers are
. printed with codes #N$00 to #N$09 and the font address set to #R$6308.
E $6308 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$6108 }
. { #MARTIANOIDS$C33C }
. { #NIGHTSHADE$6CDE }
. { #PENTAGRAM$8355 }
. { #UNDERWURLDE$EEA4 }
. LIST#
B $6308,$08,$08 #UDG(#PC)
L $6308,$08,$2B

b $6460 Room Sizes
@ $6460 label=RoomSizes
D $6460 The three sizes of room. Each
. has the distance from the middle of the
. room to its east and west walls, the
. distance to its north and south walls,
. and the level of the floor. The size is
. chosen by the top two bits of the
. second byte of the data for each room
. (see #R$6469).
B $6460,$03,$03 Size #N$00: a square room.
B $6463,$03,$03 Size #N$01: a room which
. is narrow from east to west.
B $6466,$03,$03 Size #N$02: a room which
. is narrow from north to south.

b $6469 Room Data
@ $6469 label=RoomData
D $6469 The data for the rooms, in #N$80
. variable length blocks. Each starts with
. the number of the room and the length of
. the block (which counts the length byte
. but not the room number). Next comes a
. byte for the colour and size of the
. room: bits 0 to 2 hold the colour, bits
. 3 to 5 hold a second colour (which
. #R$CAD2 copies over the first when the
. game starts) and bits 6 and 7 choose the
. size of the room from #R$6460.
.
. After that come the types of the blocks
. that make up the walls, doors and other
. fixtures of the room (see #R$7519),
. ending with #N$FF.
.
. The rest of the block lists the other
. objects in the room. Each starts with a
. byte holding the type of the object in
. its upper five bits (see #R$73C8) and
. the number of places it appears in, less
. one, in its lower three bits. Then there
. is a byte for each of the places, with
. the x position in bits 0 to 2, the y
. position in bits 3 to 5 and the height
. in bits 6 and 7. An object of type #N$00
. does not appear at all: the byte after
. it is an offset (bit 0 moves later
. objects half a place along the x axis,
. bit 1 half a place along the y axis, and
. bits 2 to 7 up the z axis). An object of
. type #N$1F switches to the second table
. of object types. The objects are built
. by #R$CCA7.
B $6469,$21 Room #N$02.
B $648A,$18 Room #N$03.
B $64A2,$1A Room #N$04.
B $64BC,$1B Room #N$05.
B $64D7,$22 Room #N$0A.
B $64F9,$24 Room #N$0B.
B $651D,$28 Room #N$0C.
B $6545,$22 Room #N$0D.
B $6567,$1D Room #N$12.
B $6584,$21 Room #N$13.
B $65A5,$26 Room #N$14.
B $65CB,$1D Room #N$15.
B $65E8,$1D Room #N$1A.
B $6605,$1B Room #N$1B.
B $6620,$22 Room #N$1C.
B $6642,$2C Room #N$1D.
B $666E,$1B Room #N$20.
B $6689,$24 Room #N$23.
B $66AD,$10 Room #N$24.
B $66BD,$23 Room #N$27.
B $66E0,$2E Room #N$28.
B $670E,$06 Room #N$2B.
B $6714,$06 Room #N$2C.
B $671A,$23 Room #N$2F.
B $673D,$17 Room #N$30.
B $6754,$23 Room #N$31.
B $6777,$15 Room #N$33.
B $678C,$26 Room #N$34.
B $67B2,$23 Room #N$36.
B $67D5,$1E Room #N$37.
B $67F3,$25 Room #N$38.
B $6818,$16 Room #N$39.
B $682E,$28 Room #N$3B.
B $6856,$0C Room #N$3C.
B $6862,$2B Room #N$3E.
B $688D,$23 Room #N$3F.
B $68B0,$1C Room #N$40.
B $68CC,$29 Room #N$41.
B $68F5,$17 Room #N$42.
B $690C,$2A Room #N$43.
B $6936,$36 Room #N$44.
B $696C,$1A Room #N$45.
B $6986,$23 Room #N$46.
B $69A9,$06 Room #N$47.
B $69AF,$26 Room #N$48.
B $69D5,$10 Room #N$49.
B $69E5,$1C Room #N$4A.
B $6A01,$31 Room #N$4B.
B $6A32,$2C Room #N$4C.
B $6A5E,$0A Room #N$4D.
B $6A68,$21 Room #N$4E.
B $6A89,$25 Room #N$4F.
B $6AAE,$06 Room #N$51.
B $6AB4,$21 Room #N$54.
B $6AD5,$30 Room #N$56.
B $6B05,$13 Room #N$57.
B $6B18,$2D Room #N$58.
B $6B45,$1D Room #N$59.
B $6B62,$1A Room #N$5B.
B $6B7C,$09 Room #N$5E.
B $6B85,$2A Room #N$61.
B $6BAF,$2A Room #N$62.
B $6BD9,$2C Room #N$64.
B $6C05,$27 Room #N$65.
B $6C2C,$13 Room #N$67.
B $6C3F,$06 Room #N$68.
B $6C45,$32 Room #N$6A.
B $6C77,$2C Room #N$6B.
B $6CA3,$07 Room #N$6D.
B $6CAA,$2F Room #N$6E.
B $6CD9,$2D Room #N$72.
B $6D06,$35 Room #N$74.
B $6D3B,$29 Room #N$75.
B $6D64,$23 Room #N$76.
B $6D87,$2F Room #N$77.
B $6DB6,$1D Room #N$78.
B $6DD3,$06 Room #N$79.
B $6DD9,$22 Room #N$7A.
B $6DFB,$1D Room #N$7B.
B $6E18,$1F Room #N$7D.
B $6E37,$23 Room #N$82.
B $6E5A,$08 Room #N$83.
B $6E62,$1E Room #N$84.
B $6E80,$06 Room #N$85.
B $6E86,$20 Room #N$86.
B $6EA6,$2E Room #N$87.
B $6ED4,$21 Room #N$88.
B $6EF5,$09 Room #N$89.
B $6EFE,$12 Room #N$8A.
B $6F10,$25 Room #N$8B.
B $6F35,$22 Room #N$8C.
B $6F57,$2B Room #N$8D.
B $6F82,$2A Room #N$93.
B $6FAC,$22 Room #N$94.
B $6FCE,$16 Room #N$95.
B $6FE4,$30 Room #N$96.
B $7014,$12 Room #N$97.
B $7026,$19 Room #N$98.
B $703F,$28 Room #N$99.
B $7067,$1C Room #N$9A.
B $7083,$08 Room #N$9B.
B $708B,$1E Room #N$9C.
B $70A9,$2D Room #N$A4.
B $70D6,$2E Room #N$A5.
B $7104,$12 Room #N$A6.
B $7116,$1C Room #N$A7.
B $7132,$06 Room #N$A8.
B $7138,$1A Room #N$A9.
B $7152,$25 Room #N$AA.
B $7177,$22 Room #N$AB.
B $7199,$2E Room #N$B5.
B $71C7,$1D Room #N$B6.
B $71E4,$13 Room #N$B7.
B $71F7,$22 Room #N$B8.
B $7219,$1C Room #N$B9.
B $7235,$28 Room #N$BA.
B $725D,$2B Room #N$C6.
B $7288,$1C Room #N$C7.
B $72A4,$1D Room #N$C8.
B $72C1,$27 Room #N$C9.
B $72E8,$22 Room #N$D6.
B $730A,$1E Room #N$D7.
B $7328,$12 Room #N$D8.
B $733A,$28 Room #N$D9.
B $7362,$20 Room #N$E7.
B $7382,$06 Room #N$E8.
B $7388,$20 Room #N$F7.
B $73A8,$20 Room #N$F8.

w $73C8 Object Types
@ $73C8 label=ObjectTypes
D $73C8 The addresses of the templates
. for the types of object that can appear
. in the data for a room (see #R$6469),
. indexed by the type. Objects of type
. #N$1F switch to the second table at
. #R$7408 for the objects which follow in
. the room.
W $73C8,$02 Type #N$00: unused.
W $73CA,$02 Type #N$01: a block (#R$7418).
W $73CC,$02 Type #N$02: a block which is fat at the bottom (#R$741E).
W $73CE,$02 Type #N$03: a block which is fat at the top (#R$7424).
W $73D0,$02 Type #N$04: a block which moves up and down (#R$742A).
W $73D2,$02 Type #N$05: a block which falls when touched (#R$7430).
W $73D4,$02 Type #N$06: a block which collapses (#R$7436).
W $73D6,$02 Type #N$07: a broken egg (#R$743C).
W $73D8,$02 Type #N$08: a conveyor which carries objects north (#R$7442).
W $73DA,$02 Type #N$09: a conveyor which carries objects east (#R$7448).
W $73DC,$02 Type #N$0A: a conveyor which carries objects south (#R$744E).
W $73DE,$02 Type #N$0B: a conveyor which carries objects west (#R$7454).
W $73E0,$02 Type #N$0C: a block which moves up and down while the player is on
. it (#R$745A).
W $73E2,$02 Type #N$0D: a block which moves east and west (#R$7460).
W $73E4,$02 Type #N$0E: a block which moves north and south (#R$7466).
W $73E6,$02 Type #N$0F: a deadly pyramid (#R$746C).
W $73E8,$02 Type #N$10: a sparkle (#R$7472).
W $73EA,$02 Type #N$11: a robot mouse which runs in a circuit (#R$748E).
W $73EC,$02 Type #N$12: a robot mouse which runs east and west (#R$7478).
W $73EE,$02 Type #N$13: a robot mouse which runs north and south (#R$7483).
W $73F0,$02 Type #N$14: the top of a broken egg (#R$7499).
W $73F2,$02 Type #N$15: a cryonaut looking east (#R$749F).
W $73F4,$02 Type #N$16: a cryonaut looking south (#R$74A5).
W $73F6,$02 Type #N$17: deadly tubes (#R$74AB).
W $73F8,$02 Type #N$18: a socket for a cylinder (#R$74B1).
W $73FA,$02 Type #N$19: a socket for a cube (#R$74BC).
W $73FC,$02 Type #N$1A: a socket for a pyramid (#R$74C7).
W $73FE,$02 Type #N$1B: a socket for a half sphere (#R$74D2).
W $7400,$02 Type #N$1C: a clockwork mouse (#R$74DD).
W $7402,$02 Type #N$1D: a chasing dome (#R$74E3).
W $7404,$02 Type #N$1E: the remote control robot (#R$74E9).
W $7406,$02 Type #N$1F: the switch to the second table.

w $7408 Second Object Types
@ $7408 label=SecondObjectTypes
D $7408 The second table of types of
. object, which is used after an object of
. type #N$1F in the data for a room. It
. has room for #N$20 entries but only the
. first eight are used, since the
. templates start at #R$7418.
W $7408,$02 Type #N$00: unused.
W $740A,$02 Type #N$01: a remote control arrow pointing west (#R$74EF).
W $740C,$02 Type #N$02: a remote control arrow pointing north (#R$74F5).
W $740E,$02 Type #N$03: a remote control arrow pointing east (#R$74FB).
W $7410,$02 Type #N$04: a remote control arrow pointing south (#R$7501).
W $7412,$02 Type #N$05: the remote control block (#R$7507).
W $7414,$02 Type #N$06: the spiked dome (#R$750D).
W $7416,$02 Type #N$07: the land mine (#R$7513).

b $7418 Object Templates
@ $7418 label=ObjectTemplates
D $7418 The templates for the objects.
. Each is a list of one or more objects,
. each of five bytes: the sprite number,
. the width, the depth, the height and the
. flags which are copied into the object
. (see #R$5B88). A list ends with #N($00),
. and when there is more than one object
. in a list the later ones are attached to
. the first (a mouse for example has a
. second part which follows it around).
. Bit 6 of the flags flips the sprite
. left to right.
B $7418,$06,$05:$01 Template for a block.
. #UDGTABLE { #SPRITE$1E,attr=$47(block-01-colour*) } UDGTABLE#
@ $741E label=ObjectTemplate_FatBottomBlock
B $741E,$06,$05:$01 Template for a block which is fat at the bottom.
. #UDGTABLE { #SPRITE$1C,attr=$47(block-fat-bottom-01-colour*) }
. UDGTABLE#
@ $7424 label=ObjectTemplate_FatTopBlock
B $7424,$06,$05:$01 Template for a block which is fat at the top.
. #UDGTABLE { #SPRITE$1D,attr=$47(block-fat-top-01-colour*) } UDGTABLE#
@ $742A label=ObjectTemplate_BlockMovingUpDown
B $742A,$06,$05:$01 Template for a block which moves up and down.
. #UDGTABLE { #SPRITE$1F,attr=$47(block-01-colour*) } UDGTABLE#
@ $7430 label=ObjectTemplate_FallingBlock
B $7430,$06,$05:$01 Template for a block which falls when touched.
. #UDGTABLE { #SPRITE$2C,attr=$47(block-01-colour*) } UDGTABLE#
@ $7436 label=ObjectTemplate_CollapsingBlock
B $7436,$06,$05:$01 Template for a block which collapses.
. #UDGTABLE { #SPRITE$2D,attr=$47(block-01-colour*) } UDGTABLE#
@ $743C label=ObjectTemplate_BrokenEgg
B $743C,$06,$05:$01 Template for a broken egg.
. #UDGTABLE { #SPRITE$2E,attr=$47(egg-bottom-01-colour*) } UDGTABLE#
@ $7442 label=ObjectTemplate_ConveyorNorth
B $7442,$06,$05:$01 Template for a conveyor which carries objects north.
. #UDGTABLE { #SPRITE$44,attr=$47(block-01-colour*) } UDGTABLE#
@ $7448 label=ObjectTemplate_ConveyorEast
B $7448,$06,$05:$01 Template for a conveyor which carries objects east.
. #UDGTABLE { #SPRITE$45,attr=$47(block-01-colour*) } UDGTABLE#
@ $744E label=ObjectTemplate_ConveyorSouth
B $744E,$06,$05:$01 Template for a conveyor which carries objects south.
. #UDGTABLE { #SPRITE$46,attr=$47(block-01-colour*) } UDGTABLE#
@ $7454 label=ObjectTemplate_ConveyorWest
B $7454,$06,$05:$01 Template for a conveyor which carries objects west.
. #UDGTABLE { #SPRITE$47,attr=$47(block-01-colour*) } UDGTABLE#
@ $745A label=ObjectTemplate_BlockMovingUpDownWithPlayer
B $745A,$06,$05:$01 Template for a block which moves up and down while the
. player is on it.
. #UDGTABLE { #SPRITE$2F,attr=$47(block-01-colour*) } UDGTABLE#
@ $7460 label=ObjectTemplate_BlockMovingEastWest
B $7460,$06,$05:$01 Template for a block which moves east and west.
. #UDGTABLE { #SPRITE$42,attr=$47(block-01-colour*) } UDGTABLE#
@ $7466 label=ObjectTemplate_BlockMovingNorthSouth
B $7466,$06,$05:$01 Template for a block which moves north and south.
. #UDGTABLE { #SPRITE$43,attr=$47(block-01-colour*) } UDGTABLE#
@ $746C label=ObjectTemplate_DeadlyPyramid
B $746C,$06,$05:$01 Template for a deadly pyramid.
. #UDGTABLE { #SPRITE$48,attr=$47(deadly-pyramid-01-colour*) }
. UDGTABLE#
@ $7472 label=ObjectTemplate_Sparkle
B $7472,$06,$05:$01 Template for a sparkle.
. #UDGTABLE { #SPRITE$4C,attr=$47(sparkle-06-colour*) } UDGTABLE#
@ $7478 label=ObjectTemplate_RobotMouseEastWest
B $7478,$05 Template for a robot mouse which runs east and west.
. #UDGTABLE { #SPRITE$56,attr=$47(robot-mouse-01-colour*) } UDGTABLE#
B $747D,$06,$05:$01 The part which follows it.
. #UDGTABLE { #SPRITE$0B,attr=$47(robot-mouse-base-01-colour*) }
. UDGTABLE#
@ $7483 label=ObjectTemplate_RobotMouseNorthSouth
B $7483,$05 Template for a robot mouse which runs north and south.
. #UDGTABLE { #SPRITE$57,attr=$47(robot-mouse-02-colour*) } UDGTABLE#
B $7488,$06,$05:$01 The part which follows it.
. #UDGTABLE { #SPRITE$0B,attr=$47(robot-mouse-base-01-colour*) }
. UDGTABLE#
@ $748E label=ObjectTemplate_RobotMouseCircuit
B $748E,$05 Template for a robot mouse which runs in a circuit.
. #UDGTABLE { #SPRITE$5E,attr=$47(robot-mouse-01-colour*) } UDGTABLE#
B $7493,$06,$05:$01 The part which follows it.
. #UDGTABLE { #SPRITE$0B,attr=$47(robot-mouse-base-01-colour*) }
. UDGTABLE#
@ $7499 label=ObjectTemplate_EggTop
B $7499,$06,$05:$01 Template for the top of a broken egg.
. #UDGTABLE { #SPRITE$49,attr=$47(egg-top-01-colour*) } UDGTABLE#
@ $749F label=ObjectTemplate_CryonautEast
B $749F,$06,$05:$01 Template for a cryonaut looking east.
. #UDGTABLE { #SPRITE$4A,attr=$47(cryonaut-01-colour*) } UDGTABLE#
@ $74A5 label=ObjectTemplate_CryonautSouth
B $74A5,$06,$05:$01 Template for a cryonaut looking south.
. #UDGTABLE { #SPRITE$4A,attr=$47(cryonaut-01-colour*) } UDGTABLE#
@ $74AB label=ObjectTemplate_DeadlyTubes
B $74AB,$06,$05:$01 Template for deadly tubes.
. #UDGTABLE { #SPRITE$4B,attr=$47(deadly-tubes-01-colour*) } UDGTABLE#
@ $74B1 label=ObjectTemplate_SocketCylinder
B $74B1,$05 Template for a socket for a cylinder.
. #UDGTABLE { #SPRITE$70,attr=$47(valve-socket-01-colour*) } UDGTABLE#
B $74B6,$06,$05:$01 The sparkle of the valve which it needs.
. #UDGTABLE { #SPRITE$6C,attr=$47(sparkle-04-colour*) } UDGTABLE#
@ $74BC label=ObjectTemplate_SocketCube
B $74BC,$05 Template for a socket for a cube.
. #UDGTABLE { #SPRITE$71,attr=$47(valve-socket-01-colour*) } UDGTABLE#
B $74C1,$06,$05:$01 The sparkle of the valve which it needs.
. #UDGTABLE { #SPRITE$6D,attr=$47(sparkle-05-colour*) } UDGTABLE#
@ $74C7 label=ObjectTemplate_SocketPyramid
B $74C7,$05 Template for a socket for a pyramid.
. #UDGTABLE { #SPRITE$72,attr=$47(valve-socket-01-colour*) } UDGTABLE#
B $74CC,$06,$05:$01 The sparkle of the valve which it needs.
. #UDGTABLE { #SPRITE$6E,attr=$47(sparkle-06-colour*) } UDGTABLE#
@ $74D2 label=ObjectTemplate_SocketHalfSphere
B $74D2,$05 Template for a socket for a half sphere.
. #UDGTABLE { #SPRITE$73,attr=$47(valve-socket-01-colour*) } UDGTABLE#
B $74D7,$06,$05:$01 The sparkle of the valve which it needs.
. #UDGTABLE { #SPRITE$6F,attr=$47(sparkle-05-colour*) } UDGTABLE#
@ $74DD label=ObjectTemplate_ClockworkMouse
B $74DD,$06,$05:$01 Template for a clockwork mouse.
. #UDGTABLE { #SPRITE$74,attr=$47(clockwork-mouse-01-colour*) }
. UDGTABLE#
@ $74E3 label=ObjectTemplate_ChasingDome
B $74E3,$06,$05:$01 Template for a chasing dome.
. #UDGTABLE { #SPRITE$78,attr=$47(chasing-dome-01-colour*) } UDGTABLE#
@ $74E9 label=ObjectTemplate_RemoteControlRobot
B $74E9,$06,$05:$01 Template for the remote control robot.
. #UDGTABLE { #SPRITE$7C,attr=$47(remote-control-robot-01-colour*) }
. UDGTABLE#
@ $74EF label=ObjectTemplate_RemoteControlArrowWest
B $74EF,$06,$05:$01 Template for a remote control arrow pointing west.
. #UDGTABLE { #SPRITE$7A,attr=$47(remote-control-arrow-01-colour*) }
. UDGTABLE#
@ $74F5 label=ObjectTemplate_RemoteControlArrowNorth
B $74F5,$06,$05:$01 Template for a remote control arrow pointing north.
. #UDGTABLE { #SPRITE$7A,attr=$47(remote-control-arrow-01-colour*) }
. UDGTABLE#
@ $74FB label=ObjectTemplate_RemoteControlArrowEast
B $74FB,$06,$05:$01 Template for a remote control arrow pointing east.
. #UDGTABLE { #SPRITE$7B,attr=$47(remote-control-arrow-02-colour*) }
. UDGTABLE#
@ $7501 label=ObjectTemplate_RemoteControlArrowSouth
B $7501,$06,$05:$01 Template for a remote control arrow pointing south.
. #UDGTABLE { #SPRITE$7B,attr=$47(remote-control-arrow-02-colour*) }
. UDGTABLE#
@ $7507 label=ObjectTemplate_RemoteControlBlock
B $7507,$06,$05:$01 Template for the remote control block.
. #UDGTABLE { #SPRITE$80,attr=$47(block-01-colour*) } UDGTABLE#
@ $750D label=ObjectTemplate_SpikedDome
B $750D,$06,$05:$01 Template for the spiked dome.
. #UDGTABLE { #SPRITE$81,attr=$47(spiked-dome-01-colour*) } UDGTABLE#
@ $7513 label=ObjectTemplate_LandMine
B $7513,$06,$05:$01 Template for the land mine.
. #UDGTABLE { #SPRITE$82,attr=$47(land-mine-01-colour*) } UDGTABLE#

w $7519 Block Types
@ $7519 label=BlockTypes
D $7519 The addresses of the templates
. for the types of block that make up the
. walls, doors and other fixtures of a
. room, indexed by the type (see
. #R$6469).
W $7519,$02 Type #N$00: a door in the north wall (#R$7535).
W $751B,$02 Type #N$01: a door in the east wall (#R$7546).
W $751D,$02 Type #N$02: a door in the south wall (#R$7579).
W $751F,$02 Type #N$03: a door in the west wall (#R$75AC).
W $7521,$02 Type #N$04: a full wall along the west side (#R$75BD).
W $7523,$02 Type #N$05: a full wall along the north side (#R$75EE).
W $7525,$02 Type #N$06: a wall along the west side with an opening (#R$761F).
W $7527,$02 Type #N$07: a wall along the north side with an opening (#R$7640).
W $7529,$02 Type #N$08: a long wall along the west side of a narrow room
. (#R$7661).
W $752B,$02 Type #N$09: a long wall along the north side of a narrow room
. (#R$76A2).
W $752D,$02 Type #N$0A: a tall door in the east wall (#R$7557).
W $752F,$02 Type #N$0B: a tall door in the south wall (#R$758A).
W $7531,$02 Type #N$0C: a tall door with a platform in the east wall (#R$7568).
W $7533,$02 Type #N$0D: a tall door with a platform in the south wall (#R$759B).

b $7535 Block Templates
@ $7535 label=BlockTemplates
D $7535 The templates for the blocks.
. Each is a list of one or more objects of
. eight bytes (the sprite number, the x, y
. and z coordinates, the width, depth and
. height and the flags) which are copied
. into the objects table. A list ends with
. #N$00.
B $7535,$08 Template for a door in the north wall.
. #UDGTABLE { #SPRITE$02,attr=$47(arch-near-01-colour*) } UDGTABLE#
B $753D,$09,$08:$01 The far side of the arch.
. #UDGTABLE { #SPRITE$03,attr=$47(arch-far-01-colour*) } UDGTABLE#
@ $7546 label=BlockTemplate_DoorEast
B $7546,$08 Template for a door in the east wall.
. #UDGTABLE { #SPRITE$02,attr=$47(arch-near-01-colour*) } UDGTABLE#
B $754E,$09,$08:$01 The far side of the arch.
. #UDGTABLE { #SPRITE$03,attr=$47(arch-far-01-colour*) } UDGTABLE#
@ $7557 label=BlockTemplate_TallDoorEast
B $7557,$08 Template for a tall door in the east wall.
. #UDGTABLE { #SPRITE$02,attr=$47(arch-near-01-colour*) } UDGTABLE#
B $755F,$09,$08:$01 The far side of the arch.
. #UDGTABLE { #SPRITE$03,attr=$47(arch-far-01-colour*) } UDGTABLE#
@ $7568 label=BlockTemplate_TallDoorWithPlatformEast
B $7568,$08 Template for a tall door with a platform in the east wall.
. #UDGTABLE { #SPRITE$1E,attr=$47(block-01-colour*) } UDGTABLE#
B $7570,$09,$08:$01 A block.
. #UDGTABLE { #SPRITE$1E,attr=$47(block-01-colour*) } UDGTABLE#
@ $7579 label=BlockTemplate_DoorSouth
B $7579,$08 Template for a door in the south wall.
. #UDGTABLE { #SPRITE$02,attr=$47(arch-near-01-colour*) } UDGTABLE#
B $7581,$09,$08:$01 The far side of the arch.
. #UDGTABLE { #SPRITE$03,attr=$47(arch-far-01-colour*) } UDGTABLE#
@ $758A label=BlockTemplate_TallDoorSouth
B $758A,$08 Template for a tall door in the south wall.
. #UDGTABLE { #SPRITE$02,attr=$47(arch-near-01-colour*) } UDGTABLE#
B $7592,$09,$08:$01 The far side of the arch.
. #UDGTABLE { #SPRITE$03,attr=$47(arch-far-01-colour*) } UDGTABLE#
@ $759B label=BlockTemplate_TallDoorWithPlatformSouth
B $759B,$08 Template for a tall door with a platform in the south wall.
. #UDGTABLE { #SPRITE$1E,attr=$47(block-01-colour*) } UDGTABLE#
B $75A3,$09,$08:$01 A block.
. #UDGTABLE { #SPRITE$1E,attr=$47(block-01-colour*) } UDGTABLE#
@ $75AC label=BlockTemplate_DoorWest
B $75AC,$08 Template for a door in the west wall.
. #UDGTABLE { #SPRITE$02,attr=$47(arch-near-01-colour*) } UDGTABLE#
B $75B4,$09,$08:$01 The far side of the arch.
. #UDGTABLE { #SPRITE$03,attr=$47(arch-far-01-colour*) } UDGTABLE#
@ $75BD label=BlockTemplate_FullWallWest
B $75BD,$08 Template for a full wall along the west side.
. #UDGTABLE { #SPRITE$0E,attr=$47(wall-corner-01-colour*) } UDGTABLE#
B $75C5,$08 A section of wall at (#N($40), #N$54).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $75CD,$08 A section of wall at (#N($40), #N$6C).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $75D5,$08 A section of wall at (#N($40), #N$84).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $75DD,$08 A section of wall at (#N($40), #N$9C).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $75E5,$09,$08:$01 A section of wall at (#N($40), #N$B4).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
@ $75EE label=BlockTemplate_FullWallNorth
B $75EE,$08 Template for a full wall along the north side.
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $75F6,$08 A section of wall at (#N($64), #N$C0).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $75FE,$08 A section of wall at (#N($7C), #N$C0).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $7606,$08 A section of wall at (#N($94), #N$C0).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $760E,$08 A section of wall at (#N($AC), #N$C0).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $7616,$09,$08:$01 The corner of the wall at (#N($BC), #N$C0).
. #UDGTABLE { #SPRITE$0E,attr=$47(wall-corner-01-colour*) } UDGTABLE#
@ $761F label=BlockTemplate_WallWestWithOpening
B $761F,$08 Template for a wall along the west side with an opening.
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $7627,$08 A section of wall at (#N($40), #N$64).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $762F,$08 A section of wall at (#N($40), #N$9C).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $7637,$09,$08:$01 A section of wall at (#N($40), #N$B4).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
@ $7640 label=BlockTemplate_WallNorthWithOpening
B $7640,$08 Template for a wall along the north side with an opening.
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $7648,$08 A section of wall at (#N($64), #N$C0).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $7650,$08 A section of wall at (#N($9C), #N$C0).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $7658,$09,$08:$01 A section of wall at (#N($B4), #N$C0).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
@ $7661 label=BlockTemplate_LongWallWest
B $7661,$08 Template for a long wall along the west side of a narrow room.
. #UDGTABLE { #SPRITE$0E,attr=$47(wall-corner-01-colour*) } UDGTABLE#
B $7669,$08 A section of wall at (#N($60), #N$54).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $7671,$08 A section of wall at (#N($60), #N$6C).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $7679,$08 A section of wall at (#N($60), #N$84).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $7681,$08 A section of wall at (#N($60), #N$9C).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $7689,$08 A section of wall at (#N($60), #N$B4).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $7691,$08 The end of the wall at (#N($68), #N$C0).
. #UDGTABLE { #SPRITE$0F,attr=$47(wall-end-01-colour*) } UDGTABLE#
B $7699,$09,$08:$01 The end of the wall at (#N($98), #N$C0).
. #UDGTABLE { #SPRITE$0F,attr=$47(wall-end-01-colour*) } UDGTABLE#
@ $76A2 label=BlockTemplate_LongWallNorth
B $76A2,$08 Template for a long wall along the north side of a narrow room.
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $76AA,$08 A section of wall at (#N($64), #N$A0).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $76B2,$08 A section of wall at (#N($7C), #N$A0).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $76BA,$08 A section of wall at (#N($94), #N$A0).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $76C2,$08 A section of wall at (#N($AC), #N$A0).
. #UDGTABLE { #SPRITE$0D,attr=$47(wall-section-01-colour*) } UDGTABLE#
B $76CA,$08 The corner of the wall at (#N($BC), #N$A0).
. #UDGTABLE { #SPRITE$0E,attr=$47(wall-corner-01-colour*) } UDGTABLE#
B $76D2,$08 The end of the wall at (#N($40), #N$68).
. #UDGTABLE { #SPRITE$0F,attr=$47(wall-end-01-colour*) } UDGTABLE#
B $76DA,$09,$08:$01 The end of the wall at (#N($40), #N$98).
. #UDGTABLE { #SPRITE$0F,attr=$47(wall-end-01-colour*) } UDGTABLE#

g $76E3 Special Objects
@ $76E3 label=SpecialObjects
D $76E3 The table of the #N$24 special
. objects: the valves which have to be
. found and put on the sockets, and the
. extra lives. Each entry has nine bytes.
. The first is the number of the object
. and starts as zero, because the objects
. are chosen at random when a game starts
. (by #R$AF3F). The next four are the
. starting position of the object (its x,
. y and z coordinates and the number of
. the room), which are copied by #R$AF3F
. to the last four bytes, where the
. current position is kept (see #R$AF05).
B $76E3,$09,$01:$03:$01:$04 Special object #N$00: room #N$04.
B $76EC,$09,$01:$03:$01:$04 Special object #N$01: room #N$05.
B $76F5,$09,$01:$03:$01:$04 Special object #N$02: room #N$0B.
B $76FE,$09,$01:$03:$01:$04 Special object #N$03: room #N$0D.
B $7707,$09,$01:$03:$01:$04 Special object #N$04: room #N$15.
B $7710,$09,$01:$03:$01:$04 Special object #N$05: room #N$1B.
B $7719,$09,$01:$03:$01:$04 Special object #N$06: room #N$1C.
B $7722,$09,$01:$03:$01:$04 Special object #N$07: room #N$20.
B $772B,$09,$01:$03:$01:$04 Special object #N$08: room #N$27.
B $7734,$09,$01:$03:$01:$04 Special object #N$09: room #N$2F.
B $773D,$09,$01:$03:$01:$04 Special object #N$0A: room #N$30.
B $7746,$09,$01:$03:$01:$04 Special object #N$0B: room #N$34.
B $774F,$09,$01:$03:$01:$04 Special object #N$0C: room #N$37.
B $7758,$09,$01:$03:$01:$04 Special object #N$0D: room #N$39.
B $7761,$09,$01:$03:$01:$04 Special object #N$0E: room #N$3E.
B $776A,$09,$01:$03:$01:$04 Special object #N$0F: room #N$45.
B $7773,$09,$01:$03:$01:$04 Special object #N$10: room #N$46.
B $777C,$09,$01:$03:$01:$04 Special object #N$11: room #N$56.
B $7785,$09,$01:$03:$01:$04 Special object #N$12: room #N$58.
B $778E,$09,$01:$03:$01:$04 Special object #N$13: room #N$59.
B $7797,$09,$01:$03:$01:$04 Special object #N$14: room #N$61.
B $77A0,$09,$01:$03:$01:$04 Special object #N$15: room #N$64.
B $77A9,$09,$01:$03:$01:$04 Special object #N$16: room #N$6A.
B $77B2,$09,$01:$03:$01:$04 Special object #N$17: room #N$6B.
B $77BB,$09,$01:$03:$01:$04 Special object #N$18: room #N$75.
B $77C4,$09,$01:$03:$01:$04 Special object #N$19: room #N$7B.
B $77CD,$09,$01:$03:$01:$04 Special object #N$1A: room #N$87.
B $77D6,$09,$01:$03:$01:$04 Special object #N$1B: room #N$8A.
B $77DF,$09,$01:$03:$01:$04 Special object #N$1C: room #N$95.
B $77E8,$09,$01:$03:$01:$04 Special object #N$1D: room #N$9A.
B $77F1,$09,$01:$03:$01:$04 Special object #N$1E: room #N$9C.
B $77FA,$09,$01:$03:$01:$04 Special object #N$1F: room #N$A9.
B $7803,$09,$01:$03:$01:$04 Special object #N$20: room #N$AB.
B $780C,$09,$01:$03:$01:$04 Special object #N$21: room #N$B7.
B $7815,$09,$01:$03:$01:$04 Special object #N$22: room #N$C8.
B $781E,$09,$01:$03:$01:$04 Special object #N$23: room #N$D9.

w $7827 Sprite Pointers
@ $7827 label=SpritePointers
D $7827 The addresses of the sprites,
. indexed by the sprite number of an
. object. The sprites follow from
. #R$792F. Many of the sprite numbers
. share a sprite, and the numbers #N$00
. and #N$01 are the sprite that draws
. nothing.
W $7827,$02 Sprite #N($00), an empty slot, which draws nothing (#R$792F).
W $7829,$02 Sprite #N($01), a retired object, which draws nothing (#R$792F).
W $782B,$02 Sprite #N($02), the near side of an arch (#R$8EE7).
W $782D,$02 Sprite #N($03), the far side of an arch (#R$8FE1).
W $782F,$02 Sprite #N($04), a corner of the border of the screen (#R$9327).
W $7831,$02 Sprite #N($05), the left or right side of the border of the screen
. (#R$945B).
W $7833,$02 Sprite #N($06), the top or bottom edge of the border of the screen
. (#R$9429).
W $7835,$02 Sprite #N($07), the upper edge of the panel (#R$9475).
W $7837,$02 Sprite #N($08), the lower edge of the panel (#R$94A7).
W $7839,$02 Sprite #N($09), a diagonal piece of the panel (#R$94E9).
W $783B,$02 Sprite #N($0A), a column of the panel (#R$9463).
W $783D,$02 Sprite #N($0B), the base of a robot mouse (#R$874B).
W $783F,$02 Sprite #N($0C), an extra life (#R$95CD).
W $7841,$02 Sprite #N($0D), a section of wall (#R$9103).
W $7843,$02 Sprite #N($0E), the corner of a wall (#R$9FB7).
W $7845,$02 Sprite #N($0F), the end of a long wall (#R$9255).
W $7847,$02 Sprite #N($10), the bottom half of the robot, walking west or north
. (#R$9C7B).
W $7849,$02 Sprite #N($11), the bottom half of the robot, walking west or north
. (#R$9D8F).
W $784B,$02 Sprite #N($12), the bottom half of the robot, walking west or north
. (#R$9EA3).
W $784D,$02 Sprite #N($13), the bottom half of the robot, walking west or north
. (#R$9D8F).
W $784F,$02 Sprite #N($14), the bottom half of the robot, walking east or south
. (#R$993F).
W $7851,$02 Sprite #N($15), the bottom half of the robot, walking east or south
. (#R$9A53).
W $7853,$02 Sprite #N($16), the bottom half of the robot, walking east or south
. (#R$9B67).
W $7855,$02 Sprite #N($17), the bottom half of the robot, walking east or south
. (#R$9A53).
W $7857,$02 Sprite #N($18), the bottom half of the robot, turning (#R$971F).
W $7859,$02 Sprite #N($19), the bottom half of the robot, turning (#R$9613).
W $785B,$02 Sprite #N($1A), the bottom half of the robot, turning (#R$982B).
W $785D,$02 Sprite #N($1B), the bottom half of the robot, turning (#R$982B).
W $785F,$02 Sprite #N($1C), a block which is fat at the bottom (#R$8AD7).
W $7861,$02 Sprite #N($1D), a block which is fat at the top (#R$8BC1).
W $7863,$02 Sprite #N($1E), a block (#R$8C9B).
W $7865,$02 Sprite #N($1F), a block which moves up and down (#R$8C9B).
W $7867,$02 Sprite #N($20), the top half of the robot, walking west or north
. (#R$9D05).
W $7869,$02 Sprite #N($21), the top half of the robot, walking west or north
. (#R$9E19).
W $786B,$02 Sprite #N($22), the top half of the robot, walking west or north
. (#R$9F2D).
W $786D,$02 Sprite #N($23), the top half of the robot, walking west or north
. (#R$9E19).
W $786F,$02 Sprite #N($24), the top half of the robot, walking east or south
. (#R$99C9).
W $7871,$02 Sprite #N($25), the top half of the robot, walking east or south
. (#R$9ADD).
W $7873,$02 Sprite #N($26), the top half of the robot, walking east or south
. (#R$9BF1).
W $7875,$02 Sprite #N($27), the top half of the robot, walking east or south
. (#R$9ADD).
W $7877,$02 Sprite #N($28), the top half of the robot, turning (#R$97A9).
W $7879,$02 Sprite #N($29), the top half of the robot, turning (#R$969D).
W $787B,$02 Sprite #N($2A), the top half of the robot, turning (#R$98B5).
W $787D,$02 Sprite #N($2B), the top half of the robot, turning (#R$98B5).
W $787F,$02 Sprite #N($2C), a block which falls when touched (#R$8C9B).
W $7881,$02 Sprite #N($2D), a block which collapses (#R$8C9B).
W $7883,$02 Sprite #N($2E), a broken egg (#R$8821).
W $7885,$02 Sprite #N($2F), a block which moves up and down while the player
. stands on it (#R$8C9B).
W $7887,$02 Sprite #N($30), a sparkle (#R$A2C3).
W $7889,$02 Sprite #N($31), a sparkle (#R$A231).
W $788B,$02 Sprite #N($32), a sparkle (#R$A2C3).
W $788D,$02 Sprite #N($33), a sparkle (#R$A231).
W $788F,$02 Sprite #N($34), a sparkle (#R$A19F).
W $7891,$02 Sprite #N($35), a sparkle (#R$A113).
W $7893,$02 Sprite #N($36), a sparkle (#R$A093).
W $7895,$02 Sprite #N($37), a sparkle (#R$A019).
W $7897,$02 Sprite #N($38), a sparkle (#R$A019).
W $7899,$02 Sprite #N($39), a sparkle (#R$A093).
W $789B,$02 Sprite #N($3A), a sparkle (#R$A113).
W $789D,$02 Sprite #N($3B), a sparkle (#R$A19F).
W $789F,$02 Sprite #N($3C), a sparkle (#R$A231).
W $78A1,$02 Sprite #N($3D), a sparkle (#R$A2C3).
W $78A3,$02 Sprite #N($3E), a sparkle (#R$A231).
W $78A5,$02 Sprite #N($3F), a sparkle (#R$A2C3).
W $78A7,$02 Sprite #N($40), a sparkle (#R$A2C3).
W $78A9,$02 Sprite #N($41), a sparkle, which is not used (#R$A231).
W $78AB,$02 Sprite #N($42), a block which moves east and west (#R$8C9B).
W $78AD,$02 Sprite #N($43), a block which moves north and south (#R$8C9B).
W $78AF,$02 Sprite #N($44), a conveyor (#R$8C9B).
W $78B1,$02 Sprite #N($45), a conveyor (#R$8C9B).
W $78B3,$02 Sprite #N($46), a conveyor (#R$8C9B).
W $78B5,$02 Sprite #N($47), a conveyor (#R$8C9B).
W $78B7,$02 Sprite #N($48), a deadly pyramid (#R$950B).
W $78B9,$02 Sprite #N($49), the top of a broken egg (#R$87AD).
W $78BB,$02 Sprite #N($4A), a cryonaut (#R$897D).
W $78BD,$02 Sprite #N($4B), deadly tubes (#R$8E1D).
W $78BF,$02 Sprite #N($4C), a sparkle which flies towards the player (#R$A2C3).
W $78C1,$02 Sprite #N($4D), a sparkle which flies towards the player (#R$A231).
W $78C3,$02 Sprite #N($4E), a sparkle which flies towards the player (#R$A19F).
W $78C5,$02 Sprite #N($4F), a sparkle which flies towards the player (#R$A231).
W $78C7,$02 Sprite #N($50), the alarm in the game over scene (#R$8571).
W $78C9,$02 Sprite #N($51), the boxing glove in the game over scene (#R$84DF).
W $78CB,$02 Sprite #N($52), the hammer in the game over scene (#R$845D).
W $78CD,$02 Sprite #N($53), the hook in the game over scene (#R$85B5).
W $78CF,$02 Sprite #N($54), the bracket of the panel (#R$86C5).
W $78D1,$02 Sprite #N($55), the pot of
. oil in the game completed scene
. (#R$79AB).
W $78D3,$02 Sprite #N($56), a robot mouse (#R$8A3F).
W $78D5,$02 Sprite #N($57), a robot mouse (#R$8D85).
W $78D7,$02 Sprite #N($58), the left side of the robot in the game over scene
. (#R$8661).
W $78D9,$02 Sprite #N($59), the right side of the robot in the game over scene
. (#R$8693).
W $78DB,$02 Sprite #N($5A), the bottom half of the robot in the game over scene
. (#R$9613).
W $78DD,$02 Sprite #N($5B), the top half of the robot in the game over scene
. (#R$969D).
W $78DF,$02 Sprite #N($5C), the bottom half of the robot in the game completed
. scene (#R$9613).
W $78E1,$02 Sprite #N($5D), the top half
. of the robot in the game completed
. scene (#R$969D).
W $78E3,$02 Sprite #N($5E), a robot mouse (#R$8A3F).
W $78E5,$02 Sprite #N($5F), a robot mouse (#R$8D85).
W $78E7,$02 Sprite #N($60), a valve lying about (#R$A41F).
W $78E9,$02 Sprite #N($61), a valve lying about (#R$A4B1).
W $78EB,$02 Sprite #N($62), a valve lying about (#R$A53D).
W $78ED,$02 Sprite #N($63), a valve lying about (#R$A5B1).
W $78EF,$02 Sprite #N($64), a valve on a socket (#R$A41F).
W $78F1,$02 Sprite #N($65), a valve on a socket (#R$A4B1).
W $78F3,$02 Sprite #N($66), a valve on a socket (#R$A53D).
W $78F5,$02 Sprite #N($67), a valve on a socket (#R$A5B1).
W $78F7,$02 Sprite #N($68), the ghost of
. the valve which a socket needs
. (#R$A41F).
W $78F9,$02 Sprite #N($69), the ghost of
. the valve which a socket needs
. (#R$A4B1).
W $78FB,$02 Sprite #N($6A), the ghost of
. the valve which a socket needs
. (#R$A53D).
W $78FD,$02 Sprite #N($6B), the ghost of
. the valve which a socket needs
. (#R$A5B1).
W $78FF,$02 Sprite #N($6C), a sparkle used while the ghost of a valve appears
. (#R$A19F).
W $7901,$02 Sprite #N($6D), a sparkle used while the ghost of a valve appears
. (#R$A231).
W $7903,$02 Sprite #N($6E), a sparkle used while the ghost of a valve appears
. (#R$A2C3).
W $7905,$02 Sprite #N($6F), a sparkle used while the ghost of a valve appears
. (#R$A231).
W $7907,$02 Sprite #N($70), a valve socket (#R$A355).
W $7909,$02 Sprite #N($71), a valve socket (#R$A355).
W $790B,$02 Sprite #N($72), a valve socket (#R$A355).
W $790D,$02 Sprite #N($73), a valve socket (#R$A355).
W $790F,$02 Sprite #N($74), a clockwork mouse (#R$8117).
W $7911,$02 Sprite #N($75), a clockwork mouse (#R$81B5).
W $7913,$02 Sprite #N($76), a clockwork mouse (#R$8079).
W $7915,$02 Sprite #N($77), a clockwork mouse (#R$8253).
W $7917,$02 Sprite #N($78), a chasing dome (#R$82F1).
W $7919,$02 Sprite #N($79), a chasing dome (#R$83A7).
W $791B,$02 Sprite #N($7A), a remote control arrow (#R$7EA5).
W $791D,$02 Sprite #N($7B), a remote control arrow (#R$7F8F).
W $791F,$02 Sprite #N($7C), the remote control robot (#R$7C5D).
W $7921,$02 Sprite #N($7D), the remote control robot (#R$7CEF).
W $7923,$02 Sprite #N($7E), the remote control robot (#R$7D81).
W $7925,$02 Sprite #N($7F), the remote control robot (#R$7E13).
W $7927,$02 Sprite #N($80), the remote control block (#R$8C9B).
W $7929,$02 Sprite #N($81), the spiked dome (#R$7BC5).
W $792B,$02 Sprite #N($82), the land mine (#R$7B0B).
W $792D,$02 Sprite #N($83), the decoration of the panel (#R$7931).

b $792F Sprite: Null Sprite
@ $792F label=SpriteNullSprite
D $792F The sprite that has no width and
. no height, which draws nothing. The
. sprite numbers #N$00 and #N$01 both find
. it: #N$00 is the one that an object has
. when it is not there, and #N$01 is the
. one that an object is given to take it
. away. Every sprite starts with its
. width in bytes, in bits 0 to 3 (bits 6
. and 7 hold whether it has been flipped
. from left to right and top to bottom,
. and are changed by #R$D174 as the
. objects are drawn), and its height in
. lines. The pixels follow, one line at a
. time and from the bottom line to the
. top, with a pair of bytes for each byte
. of the line. The first byte of a pair is
. the mask, which has a bit set for every
. pixel that is cleared, and the second is
. the data, which has a bit set for every
. pixel that is set. The sprites are found
. from their sprite numbers by the table
. at #R$7827.
B $792F,$01 Width = #N(#PEEK(#PC)) bytes.
B $7930,$01 Height = #N(#PEEK(#PC)) lines.

b $7931 Sprite: Panel Decoration
@ $7931 label=SpritePanelDecoration
D $7931 The decoration at the left of
. the panel (see #R$CB5A).
B $7931,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7932,$01 Height = #N(#PEEK(#PC)) lines.
B $7933,$78,$02 #SPRITEDATA(panel-decoration-01*)

b $79AB Sprite: Pot Of Oil
@ $79AB label=SpritePotOfOil
D $79AB The pot of oil which is shown
. in the game completed scene.
B $79AB,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $79AC,$01 Height = #N(#PEEK(#PC)) lines.
B $79AD,$15E,$02 #SPRITEDATA(pot-of-oil-01*)

b $7B0B Sprite: Land Mine
@ $7B0B label=SpriteLandMine
D $7B0B The land mine, which is deadly
. to touch and leaps up every so often
. (see #R$A8F9).
B $7B0B,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7B0C,$01 Height = #N(#PEEK(#PC)) lines.
B $7B0D,$B8,$02 #SPRITEDATA(land-mine-01*)

b $7BC5 Sprite: Spiked Dome
@ $7BC5 label=SpriteSpikedDome
D $7BC5 The spiked dome, which kills
. the player that touches it.
B $7BC5,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7BC6,$01 Height = #N(#PEEK(#PC)) lines.
B $7BC7,$96,$02 #SPRITEDATA(spiked-dome-01*)

b $7C5D Sprite: Remote Control Robot
@ $7C5D label=SpriteRemoteControlRobot_1
D $7C5D The four frames of the remote
. control robot, which is moved by the
. pads that the player steps on (see
. #R$A9C7).
N $7C5D Remote Control Robot Frame 1.
B $7C5D,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7C5E,$01 Height = #N(#PEEK(#PC)) lines.
B $7C5F,$90,$02 #SPRITEDATA(remote-control-robot-01*)
@ $7CEF label=SpriteRemoteControlRobot_2
N $7CEF Remote Control Robot Frame 2.
B $7CEF,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7CF0,$01 Height = #N(#PEEK(#PC)) lines.
B $7CF1,$90,$02 #SPRITEDATA(remote-control-robot-02*)
@ $7D81 label=SpriteRemoteControlRobot_3
N $7D81 Remote Control Robot Frame 3.
B $7D81,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7D82,$01 Height = #N(#PEEK(#PC)) lines.
B $7D83,$90,$02 #SPRITEDATA(remote-control-robot-03*)
@ $7E13 label=SpriteRemoteControlRobot_4
N $7E13 Remote Control Robot Frame 4.
B $7E13,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7E14,$01 Height = #N(#PEEK(#PC)) lines.
B $7E15,$90,$02 #SPRITEDATA(remote-control-robot-04*)

b $7EA5 Sprite: Remote Control Arrow
@ $7EA5 label=SpriteRemoteControlArrow_1
D $7EA5 The two sprites of the remote
. control arrows, which are the pads that
. send the robot off in a direction (see
. #R$AA63). The first sprite is the arrow
. that points west, or north when it is
. flipped, and the second is the arrow
. that points east, or south when it is
. flipped.
N $7EA5 Remote Control Arrow Frame 1.
B $7EA5,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7EA6,$01 Height = #N(#PEEK(#PC)) lines.
B $7EA7,$E8,$02 #SPRITEDATA(remote-control-arrow-01*)
@ $7F8F label=SpriteRemoteControlArrow_2
N $7F8F Remote Control Arrow Frame 2.
B $7F8F,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7F90,$01 Height = #N(#PEEK(#PC)) lines.
B $7F91,$E8,$02 #SPRITEDATA(remote-control-arrow-02*)

b $8079 Sprite: Clockwork Mouse
@ $8079 label=SpriteClockworkMouse_3
D $8079 The four frames of the
. clockwork mouse. The frames are stored
. in the order 3, 1, 2 and 4.
N $8079 Clockwork Mouse Frame 3.
B $8079,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $807A,$01 Height = #N(#PEEK(#PC)) lines.
B $807B,$9C,$02 #SPRITEDATA(clockwork-mouse-03*)
@ $8117 label=SpriteClockworkMouse_1
N $8117 Clockwork Mouse Frame 1.
B $8117,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8118,$01 Height = #N(#PEEK(#PC)) lines.
B $8119,$9C,$02 #SPRITEDATA(clockwork-mouse-01*)
@ $81B5 label=SpriteClockworkMouse_2
N $81B5 Clockwork Mouse Frame 2.
B $81B5,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $81B6,$01 Height = #N(#PEEK(#PC)) lines.
B $81B7,$9C,$02 #SPRITEDATA(clockwork-mouse-02*)
@ $8253 label=SpriteClockworkMouse_4
N $8253 Clockwork Mouse Frame 4.
B $8253,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8254,$01 Height = #N(#PEEK(#PC)) lines.
B $8255,$9C,$02 #SPRITEDATA(clockwork-mouse-04*)

b $82F1 Sprite: Chasing Dome
@ $82F1 label=SpriteChasingDome_1
D $82F1 The two frames of the chasing
. dome, which is deadly to touch and
. moves towards the player.
N $82F1 Chasing Dome Frame 1.
B $82F1,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $82F2,$01 Height = #N(#PEEK(#PC)) lines.
B $82F3,$B4,$02 #SPRITEDATA(chasing-dome-01*)
@ $83A7 label=SpriteChasingDome_2
N $83A7 Chasing Dome Frame 2.
B $83A7,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $83A8,$01 Height = #N(#PEEK(#PC)) lines.
B $83A9,$B4,$02 #SPRITEDATA(chasing-dome-02*)

b $845D Sprite: Hammer
@ $845D label=SpriteHammer
D $845D The hammer in the game over scene.
B $845D,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $845E,$01 Height = #N(#PEEK(#PC)) lines.
B $845F,$80,$02 #SPRITEDATA(hammer-01*)

b $84DF Sprite: Boxing Glove
@ $84DF label=SpriteBoxingGlove
D $84DF The boxing glove in the game over scene.
B $84DF,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $84E0,$01 Height = #N(#PEEK(#PC)) lines.
B $84E1,$90,$02 #SPRITEDATA(boxing-glove-01*)

b $8571 Sprite: Alarm
@ $8571 label=SpriteAlarm
D $8571 The alarm in the game over scene.
B $8571,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8572,$01 Height = #N(#PEEK(#PC)) lines.
B $8573,$42,$02 #SPRITEDATA(alarm-01*)

b $85B5 Sprite: Hook
@ $85B5 label=SpriteHook
D $85B5 The hook in the game over scene.
B $85B5,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $85B6,$01 Height = #N(#PEEK(#PC)) lines.
B $85B7,$AA,$02 #SPRITEDATA(hook-01*)

b $8661 Sprite: Robot Arm
@ $8661 label=SpriteRobotArmLeft
D $8661 The sides of the robot in the
. game over scene, which are drawn at the
. left and the right of its body.
N $8661 Robot Arm Left.
B $8661,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8662,$01 Height = #N(#PEEK(#PC)) lines.
B $8663,$30,$02 #SPRITEDATA(robot-arm-left-01*)
@ $8693 label=SpriteRobotArmRight
N $8693 Robot Arm Right.
B $8693,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8694,$01 Height = #N(#PEEK(#PC)) lines.
B $8695,$30,$02 #SPRITEDATA(robot-arm-right-01*)

b $86C5 Sprite: Panel Bracket
@ $86C5 label=SpritePanelBracket
D $86C5 The bracket in the panel, which
. is drawn twice, at the right of the
. panel, and the second time flipped (see
. #R$CB5A).
B $86C5,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $86C6,$01 Height = #N(#PEEK(#PC)) lines.
B $86C7,$84,$02 #SPRITEDATA(panel-bracket-01*)

b $874B Sprite: Robot Mouse Base
@ $874B label=SpriteRobotMouseBase
D $874B The base of a robot mouse,
. which is the second object of the mouse
. (see #R$7478).
B $874B,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $874C,$01 Height = #N(#PEEK(#PC)) lines.
B $874D,$60,$02 #SPRITEDATA(robot-mouse-base-01*)

b $87AD Sprite: Broken Egg
@ $87AD label=SpriteEggTop
D $87AD The two sprites of a broken
. egg: the bottom, which stays where it
. is, and the top, which is deadly to
. touch and falls to the floor every so
. often (see #R$AD13).
N $87AD Egg Top.
B $87AD,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $87AE,$01 Height = #N(#PEEK(#PC)) lines.
B $87AF,$72,$02 #SPRITEDATA(egg-top-01*)
@ $8821 label=SpriteEggBottom
N $8821 Egg Bottom.
B $8821,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8822,$01 Height = #N(#PEEK(#PC)) lines.
B $8823,$90,$02 #SPRITEDATA(egg-bottom-01*)

b $88B3 Sprite: Unused Ramp
@ $88B3 label=SpriteUnusedRamp
D $88B3 A sprite of a ramp, which does
. not have a sprite number and is not
. used by the game.
B $88B3,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $88B4,$01 Height = #N(#PEEK(#PC)) lines.
B $88B5,$C8,$02 #SPRITEDATA(unused-ramp-01*)

b $897D Sprite: Cryonaut
@ $897D label=SpriteCryonaut
D $897D The cryonaut, who looks out of
. a cryogenic chamber.
B $897D,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $897E,$01 Height = #N(#PEEK(#PC)) lines.
B $897F,$C0,$02 #SPRITEDATA(cryonaut-01*)

b $8A3F Sprite: Robot Mouse Frame 1
@ $8A3F label=SpriteRobotMouse_1
D $8A3F The first frame of the robot
. mouse.
B $8A3F,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8A40,$01 Height = #N(#PEEK(#PC)) lines.
B $8A41,$96,$02 #SPRITEDATA(robot-mouse-01*)

b $8AD7 Sprite: Blocks
@ $8AD7 label=SpriteBlockFatBottom
D $8AD7 The sprites of the blocks. The
. block that is fat at the bottom and the
. one that is fat at the top have a
. sprite each, and all of the other
. blocks, which behave in different ways,
. share the third.
N $8AD7 Block Fat Bottom.
B $8AD7,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8AD8,$01 Height = #N(#PEEK(#PC)) lines.
B $8AD9,$E8,$02 #SPRITEDATA(block-fat-bottom-01*)
@ $8BC1 label=SpriteBlockFatTop
N $8BC1 Block Fat Top.
B $8BC1,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8BC2,$01 Height = #N(#PEEK(#PC)) lines.
B $8BC3,$D8,$02 #SPRITEDATA(block-fat-top-01*)
@ $8C9B label=SpriteBlock
N $8C9B Block.
B $8C9B,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8C9C,$01 Height = #N(#PEEK(#PC)) lines.
B $8C9D,$E8,$02 #SPRITEDATA(block-01*)

b $8D85 Sprite: Robot Mouse Frame 2
@ $8D85 label=SpriteRobotMouse_2
D $8D85 The second frame of the robot
. mouse.
B $8D85,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8D86,$01 Height = #N(#PEEK(#PC)) lines.
B $8D87,$96,$02 #SPRITEDATA(robot-mouse-02*)

b $8E1D Sprite: Deadly Tubes
@ $8E1D label=SpriteDeadlyTubes
D $8E1D The deadly tubes, which kill
. the player that touches them.
B $8E1D,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8E1E,$01 Height = #N(#PEEK(#PC)) lines.
B $8E1F,$C8,$02 #SPRITEDATA(deadly-tubes-01*)

b $8EE7 Sprite: Arch
@ $8EE7 label=SpriteArchNear
D $8EE7 The two sides of an arch, which
. is the way out of a room. The near side
. is drawn at the front of the room and
. the far side at the back.
N $8EE7 Arch Near.
B $8EE7,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8EE8,$01 Height = #N(#PEEK(#PC)) lines.
B $8EE9,$F8,$02 #SPRITEDATA(arch-near-01*)
@ $8FE1 label=SpriteArchFar
N $8FE1 Arch Far.
B $8FE1,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8FE2,$01 Height = #N(#PEEK(#PC)) lines.
B $8FE3,$120,$02 #SPRITEDATA(arch-far-01*)

b $9103 Sprite: Wall
@ $9103 label=SpriteWallSection
D $9103 The sprites of the walls: a
. section of wall, and the end of the
. long walls.
N $9103 Wall Section.
B $9103,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9104,$01 Height = #N(#PEEK(#PC)) lines.
B $9105,$150,$02 #SPRITEDATA(wall-section-01*)
@ $9255 label=SpriteWallEnd
N $9255 Wall End.
B $9255,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9256,$01 Height = #N(#PEEK(#PC)) lines.
B $9257,$D0,$02 #SPRITEDATA(wall-end-01*)

b $9327 Sprite: Border
@ $9327 label=SpriteBorderCorner
D $9327 The sprites of the border of
. the screen: the corner, the top and
. bottom edge, and the left and right
. side. They are put together by #R$CB8A.
N $9327 Border Corner.
B $9327,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9328,$01 Height = #N(#PEEK(#PC)) lines.
B $9329,$100,$02 #SPRITEDATA(border-corner-01*)
@ $9429 label=SpriteBorderEdge
N $9429 Border Edge.
B $9429,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $942A,$01 Height = #N(#PEEK(#PC)) lines.
B $942B,$30,$02 #SPRITEDATA(border-edge-01*)
@ $945B label=SpriteBorderSide
N $945B Border Side.
B $945B,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $945C,$01 Height = #N(#PEEK(#PC)) lines.
B $945D,$06,$02 #SPRITEDATA(border-side-01*)

b $9463 Sprite: Panel
@ $9463 label=SpritePanelColumn
D $9463 The sprites of the panel at the
. bottom of the screen, which are put
. together by #R$CB0F.
N $9463 Panel Column.
B $9463,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9464,$01 Height = #N(#PEEK(#PC)) lines.
B $9465,$10,$02 #SPRITEDATA(panel-column-01*)
@ $9475 label=SpritePanelUpperEdge
N $9475 Panel Upper Edge.
B $9475,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9476,$01 Height = #N(#PEEK(#PC)) lines.
B $9477,$30,$02 #SPRITEDATA(panel-upper-edge-01*)
@ $94A7 label=SpritePanelLowerEdge
N $94A7 Panel Lower Edge.
B $94A7,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $94A8,$01 Height = #N(#PEEK(#PC)) lines.
B $94A9,$40,$02 #SPRITEDATA(panel-lower-edge-01*)
@ $94E9 label=SpritePanelDiagonal
N $94E9 Panel Diagonal.
B $94E9,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $94EA,$01 Height = #N(#PEEK(#PC)) lines.
B $94EB,$20,$02 #SPRITEDATA(panel-diagonal-01*)

b $950B Sprite: Deadly Pyramid
@ $950B label=SpriteDeadlyPyramid
D $950B The deadly pyramid, which
. kills the player that touches it.
B $950B,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $950C,$01 Height = #N(#PEEK(#PC)) lines.
B $950D,$C0,$02 #SPRITEDATA(deadly-pyramid-01*)

b $95CD Sprite: Extra Life
@ $95CD label=SpriteExtraLife
D $95CD The extra life, which is picked
. up to make another life, and which
. shows the number of lives in the panel.
B $95CD,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $95CE,$01 Height = #N(#PEEK(#PC)) lines.
B $95CF,$44,$02 #SPRITEDATA(extra-life-01*)

b $9613 Sprite: Robot Turning
@ $9613 label=SpriteRobotBottomTurning_2
D $9613 The sprites of the robot when
. it is turning. There are three frames,
. each made of a bottom half and a top
. half. The second frame is also used for
. the robot in the game over and the game
. completed scenes.
N $9613 Robot Bottom Turning Frame 2.
B $9613,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9614,$01 Height = #N(#PEEK(#PC)) lines.
B $9615,$88,$02 #SPRITEDATA(robot-bottom-turning-02*)
@ $969D label=SpriteRobotTopTurning_2
N $969D Robot Top Turning Frame 2.
B $969D,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $969E,$01 Height = #N(#PEEK(#PC)) lines.
B $969F,$80,$02 #SPRITEDATA(robot-top-turning-02*)
@ $971F label=SpriteRobotBottomTurning_1
N $971F Robot Bottom Turning Frame 1.
B $971F,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9720,$01 Height = #N(#PEEK(#PC)) lines.
B $9721,$88,$02 #SPRITEDATA(robot-bottom-turning-01*)
@ $97A9 label=SpriteRobotTopTurning_1
N $97A9 Robot Top Turning Frame 1.
B $97A9,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $97AA,$01 Height = #N(#PEEK(#PC)) lines.
B $97AB,$80,$02 #SPRITEDATA(robot-top-turning-01*)
@ $982B label=SpriteRobotBottomTurning_3
N $982B Robot Bottom Turning Frame 3.
B $982B,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $982C,$01 Height = #N(#PEEK(#PC)) lines.
B $982D,$88,$02 #SPRITEDATA(robot-bottom-turning-03*)
@ $98B5 label=SpriteRobotTopTurning_3
N $98B5 Robot Top Turning Frame 3.
B $98B5,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $98B6,$01 Height = #N(#PEEK(#PC)) lines.
B $98B7,$88,$02 #SPRITEDATA(robot-top-turning-03*)

b $993F Sprite: Robot Walking
@ $993F label=SpriteRobotBottomEast_1
D $993F The sprites of the robot when
. it is walking. There are three frames
. in each direction, each made of a
. bottom half and a top half. The second
. frame is used twice in the cycle of
. walking. The sprites for walking east
. are flipped to walk south, and the
. sprites for walking west are flipped to
. walk north.
N $993F Robot Bottom East Frame 1.
B $993F,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9940,$01 Height = #N(#PEEK(#PC)) lines.
B $9941,$88,$02 #SPRITEDATA(robot-bottom-east-01*)
@ $99C9 label=SpriteRobotTopEast_1
N $99C9 Robot Top East Frame 1.
B $99C9,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $99CA,$01 Height = #N(#PEEK(#PC)) lines.
B $99CB,$88,$02 #SPRITEDATA(robot-top-east-01*)
@ $9A53 label=SpriteRobotBottomEast_2
N $9A53 Robot Bottom East Frame 2.
B $9A53,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9A54,$01 Height = #N(#PEEK(#PC)) lines.
B $9A55,$88,$02 #SPRITEDATA(robot-bottom-east-02*)
@ $9ADD label=SpriteRobotTopEast_2
N $9ADD Robot Top East Frame 2.
B $9ADD,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9ADE,$01 Height = #N(#PEEK(#PC)) lines.
B $9ADF,$88,$02 #SPRITEDATA(robot-top-east-02*)
@ $9B67 label=SpriteRobotBottomEast_3
N $9B67 Robot Bottom East Frame 3.
B $9B67,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9B68,$01 Height = #N(#PEEK(#PC)) lines.
B $9B69,$88,$02 #SPRITEDATA(robot-bottom-east-03*)
@ $9BF1 label=SpriteRobotTopEast_3
N $9BF1 Robot Top East Frame 3.
B $9BF1,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9BF2,$01 Height = #N(#PEEK(#PC)) lines.
B $9BF3,$88,$02 #SPRITEDATA(robot-top-east-03*)
@ $9C7B label=SpriteRobotBottomWest_1
N $9C7B Robot Bottom West Frame 1.
B $9C7B,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9C7C,$01 Height = #N(#PEEK(#PC)) lines.
B $9C7D,$88,$02 #SPRITEDATA(robot-bottom-west-01*)
@ $9D05 label=SpriteRobotTopWest_1
N $9D05 Robot Top West Frame 1.
B $9D05,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9D06,$01 Height = #N(#PEEK(#PC)) lines.
B $9D07,$88,$02 #SPRITEDATA(robot-top-west-01*)
@ $9D8F label=SpriteRobotBottomWest_2
N $9D8F Robot Bottom West Frame 2.
B $9D8F,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9D90,$01 Height = #N(#PEEK(#PC)) lines.
B $9D91,$88,$02 #SPRITEDATA(robot-bottom-west-02*)
@ $9E19 label=SpriteRobotTopWest_2
N $9E19 Robot Top West Frame 2.
B $9E19,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9E1A,$01 Height = #N(#PEEK(#PC)) lines.
B $9E1B,$88,$02 #SPRITEDATA(robot-top-west-02*)
@ $9EA3 label=SpriteRobotBottomWest_3
N $9EA3 Robot Bottom West Frame 3.
B $9EA3,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9EA4,$01 Height = #N(#PEEK(#PC)) lines.
B $9EA5,$88,$02 #SPRITEDATA(robot-bottom-west-03*)
@ $9F2D label=SpriteRobotTopWest_3
N $9F2D Robot Top West Frame 3.
B $9F2D,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9F2E,$01 Height = #N(#PEEK(#PC)) lines.
B $9F2F,$88,$02 #SPRITEDATA(robot-top-west-03*)

b $9FB7 Sprite: Wall Corner
@ $9FB7 label=SpriteWallCorner
D $9FB7 The corner of a wall, which is
. put at the end of a run of wall
. sections (see #R$75BD).
B $9FB7,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9FB8,$01 Height = #N(#PEEK(#PC)) lines.
B $9FB9,$60,$02 #SPRITEDATA(wall-corner-01*)

b $A019 Sprite: Sparkle
@ $A019 label=SpriteSparkle_1
D $A019 The six sizes of the sparkle,
. from the smallest to the largest. As
. the sprite numbers #N$30 to #N$40 go
. by, the sparkle shrinks to the smallest
. and then grows again.
N $A019 Sparkle 1.
B $A019,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A01A,$01 Height = #N(#PEEK(#PC)) lines.
B $A01B,$78,$02 #SPRITEDATA(sparkle-01*)
@ $A093 label=SpriteSparkle_2
N $A093 Sparkle 2.
B $A093,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A094,$01 Height = #N(#PEEK(#PC)) lines.
B $A095,$7E,$02 #SPRITEDATA(sparkle-02*)
@ $A113 label=SpriteSparkle_3
N $A113 Sparkle 3.
B $A113,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A114,$01 Height = #N(#PEEK(#PC)) lines.
B $A115,$8A,$02 #SPRITEDATA(sparkle-03*)
@ $A19F label=SpriteSparkle_4
N $A19F Sparkle 4.
B $A19F,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A1A0,$01 Height = #N(#PEEK(#PC)) lines.
B $A1A1,$90,$02 #SPRITEDATA(sparkle-04*)
@ $A231 label=SpriteSparkle_5
N $A231 Sparkle 5.
B $A231,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A232,$01 Height = #N(#PEEK(#PC)) lines.
B $A233,$90,$02 #SPRITEDATA(sparkle-05*)
@ $A2C3 label=SpriteSparkle_6
N $A2C3 Sparkle 6.
B $A2C3,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A2C4,$01 Height = #N(#PEEK(#PC)) lines.
B $A2C5,$90,$02 #SPRITEDATA(sparkle-06*)

b $A355 Sprite: Valve Socket
@ $A355 label=SpriteValveSocket
D $A355 The socket that a valve is put
. on.
B $A355,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A356,$01 Height = #N(#PEEK(#PC)) lines.
B $A357,$C8,$02 #SPRITEDATA(valve-socket-01*)

b $A41F Sprite: Valve
@ $A41F label=SpriteValveCylinder
D $A41F The four valves: the cylinder,
. the cube, the pyramid and the half
. sphere. The same sprites are used for
. the valves that are lying about, the
. valves on the sockets and the ghosts of
. the valves that the sockets need.
N $A41F Valve Cylinder.
B $A41F,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A420,$01 Height = #N(#PEEK(#PC)) lines.
B $A421,$90,$02 #SPRITEDATA(valve-cylinder-01*)
@ $A4B1 label=SpriteValveCube
N $A4B1 Valve Cube.
B $A4B1,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A4B2,$01 Height = #N(#PEEK(#PC)) lines.
B $A4B3,$8A,$02 #SPRITEDATA(valve-cube-01*)
@ $A53D label=SpriteValvePyramid
N $A53D Valve Pyramid.
B $A53D,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A53E,$01 Height = #N(#PEEK(#PC)) lines.
B $A53F,$72,$02 #SPRITEDATA(valve-pyramid-01*)
@ $A5B1 label=SpriteValveHalfSphere
N $A5B1 Valve Half Sphere.
B $A5B1,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A5B2,$01 Height = #N(#PEEK(#PC)) lines.
B $A5B3,$7E,$02 #SPRITEDATA(valve-half-sphere-01*)

c $A631 Start Game
@ $A631 label=StartGame
D $A631 Clears every game variable from #R$5B00
. up to #R$6288, keeps the low byte of
. #SKOOLKID$5C78(FRAMES) as #R$5B00, checks that
. the loader started the game, and then carries
. on into #R$A650.
E $A631 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$AF6C }
. LIST#
N $A631 Clear the variables and keep the seed.
  $A631,$03 Point #REGhl at #R$5B00.
  $A634,$03 Set the number of bytes to #N$0788.
  $A637,$03 Fetch the low byte of #SKOOLKID$5C78(FRAMES).
  $A63A,$01 Stash the seed on the stack.
  $A63B,$03 Call #R$CE56.
  $A63E,$01 Restore the seed from the stack.
  $A63F,$03 Set #R$5B00.
  $A642,$03 Call #R$A8F1.
  $A645,$02 Jump to #R$A650.

c $A647 Restart Game
@ $A647 label=RestartGame
D $A647 Clears the game variables from #R$5B08
. onwards, so #R$5B00, #R$5B02, #R$5B04 and
. #R$5B05 are kept.
E $A647 Continue on to #R$A650.
N $A647 Clear the variables of the last game.
  $A647,$03 Point #REGhl at #R$5B08.
  $A64A,$03 Set the number of bytes to #N$0780.
  $A64D,$03 Call #R$CE56.

c $A650 Initialise Game
@ $A650 label=InitialiseGame
D $A650 Prepares a new game: builds the lookup
. tables, gives the player five lives, shows
. the menu, plays the start tune, and places
. the player and the special objects.
E $A650 Continue on to #R$A688.
N $A650 Build the tables and set the starting state.
  $A650,$03 Call #R$CFA7.
  $A653,$04 Write #N$00 to #R$5B12.
  $A657,$03 Write #N$00 to #R$CA1D(#N$CA29).
  $A65A,$05 Set #R$5B1A to #N$05.
  $A65F,$06 Set #R$5B36 to #N($0060,$04,$04).
  $A665,$06 Write #N($0000,$04,$04) to #R$5B38.
N $A66B Stir #R$5B00 with #R$5B02.
  $A66B,$03 Point #REGhl at #R$5B00.
  $A66E,$03 Fetch the low byte of #R$5B02.
  $A671,$02 Add it to #R$5B00.
N $A673 Show the menu and wait for the player to start.
  $A673,$03 Call #R$CE73.
  $A676,$03 Call #R$BA7E.
N $A679 #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune)))
  $A679,$03 Point #REGde at #R$B3C5.
  $A67C,$03 Call #R$B4BA.
N $A67F Place the player and set up the rooms.
  $A67F,$03 Call #R$CA6D.
  $A682,$03 Call #R$AF3F.
  $A685,$03 Call #R$CAD2.

c $A688 Start Life
@ $A688 label=StartLife
D $A688 Starts a new life: puts the player
. objects back at the start location and takes
. a life off. If the player has none left the
. game is over.
E $A688 Continue on to #R$A68B.
E $A688 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$AFB7 }
. LIST#
N $A688 Restore the player and take a life.
  $A688,$03 Call #R$CA07.

c $A68B Run Game
@ $A68B label=RunGame
D $A68B The main game loop. The first call
. builds the objects of the room. Every pass
. through #R$A68E is one frame: each object is
. updated, the visible objects are sorted and
. drawn, the screen is refreshed and the panel
. is updated.
.
. #PUSHS #UDGTABLE { =h After the first pass }
. { #SIM(start=$A631,stop=$A676,sp=$F100,r=$80,clear=1)
. #SIM(start=$BA7E,stop=$BA95)
. #SIM(start=$A67F,stop=$A6FE)
. #SIM(start=$A715,stop=$A72E)
. #SIM(start=$CE85,stop=$0000,sp=$EC00)
. #SCR$02(run-game) } UDGTABLE# #POPS
E $A68B View the equivalent code in;
. #LIST
. { #KNIGHTLORE$AFBA }
. LIST#
N $A68B Build the objects of the room.
  $A68B,$03 Call #R$CAA2.
N $A68E Give every object a chance to update itself.
@ $A68E label=RunGame_Frame
  $A68E,$04 Point #REGix at #R$5B88.
@ $A692 label=RunGame_NextObject
  $A692,$03 Set the stack pointer to #N$F100.
  $A695,$03 Point #REGhl at #R$A6C0.
  $A698,$01 Stash the return address on the stack.
  $A699,$03 Fetch the width of the sprite.
  $A69C,$03 Store it as the previous width.
  $A69F,$03 Fetch the height of the sprite.
  $A6A2,$03 Store it as the previous height.
  $A6A5,$03 Fetch the pixel x position of the sprite.
  $A6A8,$03 Store it as the previous x position.
  $A6AB,$03 Fetch the pixel y position of the sprite.
  $A6AE,$03 Store it as the previous y position.
N $A6B1 Jump to the update routine for the sprite.
@ $A6B1 label=RunGame_UpdateObject
  $A6B1,$03 Fetch the sprite number into #REGl.
  $A6B4,$03 Point #REGbc at #R$A7EA.
@ $A6B7 label=RunGame_JumpToHandler
  $A6B7,$02 Clear the high byte of #REGhl.
  $A6B9,$01 Double the sprite number.
  $A6BA,$01 Add the address of the table.
  $A6BB,$01 Fetch the low byte of the routine.
  $A6BC,$01 Move on to the high byte.
  $A6BD,$01 Fetch the high byte of the routine.
  $A6BE,$01 Put the low byte in #REGl.
  $A6BF,$01 Jump to the update routine.
N $A6C0 Stir #R$5B05 from the refresh register.
@ $A6C0 label=RunGame_ObjectUpdated
  $A6C0,$02 Fetch the refresh register.
  $A6C2,$01 Copy it to #REGc.
  $A6C3,$03 Fetch #R$5B05.
  $A6C6,$01 Add the refresh register to it.
  $A6C7,$03 Set #R$5B05.
N $A6CA Move on to the next object.
  $A6CA,$05 Move #REGix on by #N($0020,$04,$04) bytes.
  $A6CF,$03 Copy #REGix to #REGhl (using the stack).
  $A6D2,$03 Point #REGbc at #R$6288.
  $A6D5,$03 Subtract #R$6288 from #REGhl.
  $A6D8,$02 Jump to #R$A6DC if there are no more objects.
  $A6DA,$02 Jump to #R$A692.
N $A6DC Stir #R$5B05 from the ROM byte at #R$5B02.
@ $A6DC label=RunGame_FinishFrame
  $A6DC,$03 Fetch #R$5B02.
  $A6DF,$01 Move on to the next address.
  $A6E0,$03 Set #R$5B02.
  $A6E3,$03 Fetch #R$5B05.
  $A6E6,$01 Add the byte of ROM.
  $A6E7,$01 Add the low byte of the address.
  $A6E8,$01 Add the high byte of the address.
  $A6E9,$03 Set #R$5B05.
  $A6EC,$03 Point #REGhl at #R$5B12.
  $A6EF,$02 Set bit 0 of #R$5B12.
N $A6F1 Draw the room into the screen buffer.
  $A6F1,$03 Call #R$C71C.
  $A6F4,$03 Call #R$CEAB.
  $A6F7,$03 Fetch #R$5B24.
  $A6FA,$04 Jump to #R$A741 if it is set.
N $A6FE Slow the game down when few objects are drawn.
  $A6FE,$03 Fetch #R$5B1E.
  $A701,$02 Negate it.
  $A703,$02 Add #N$06.
  $A705,$01 Keep the number of delay loops in #REGb.
  $A706,$03 Jump to #R$A715 if there were more than #N$06 objects.
  $A709,$02 Jump to #R$A715 if there were exactly #N$06 objects.
@ $A70B label=RunGame_Delay
  $A70B,$03 Set the delay counter to #N$0300.
@ $A70E label=RunGame_DelayLoop
  $A70E,$01 Decrease the delay counter.
  $A70F,$04 Jump to #R$A70E until the delay counter is zero.
  $A713,$02 Jump to #R$A70B until all of the delay loops are done.
N $A715 Update the status panel.
@ $A715 label=RunGame_UpdateDisplay
  $A715,$03 Call #R$AD66.
  $A718,$03 Fetch #R$5B17.
  $A71B,$03 Jump to #R$A72E if it is not set.
  $A71E,$03 Call #R$CB0F.
  $A721,$03 Call #R$A749.
@ $A724 label=RunGame_RefreshScreen
  $A724,$04 Write #N$00 to #R$5B17.
  $A728,$03 Call #R$CE85.
  $A72B,$03 Call #R$A7DC.
N $A72E Check whether the game is paused and whether the player is alive.
@ $A72E label=RunGame_Continue
  $A72E,$03 Call #R$CE22.
  $A731,$04 Point #REGix at #R$5B88.
  $A735,$03 Fetch the sprite number of the player.
  $A738,$03 Combine it with the sprite number of #R$5BA8.
  $A73B,$03 Jump to #R$A688 if both are zero.
  $A73E,$03 Jump to #R$A68E.
N $A741 Only refresh the screen if the panel needs to be redrawn.
@ $A741 label=RunGame_GameOver
  $A741,$03 Fetch #R$5B17.
  $A744,$03 Jump to #R$A72E if it is not set.
  $A747,$02 Jump to #R$A724.

c $A749 Update Panel
@ $A749 label=UpdatePanel
D $A749 Colours the screen and the status
. panel after #R$CB0F has drawn it, then prints
. the carried objects, the "LIGHT YEARS"
. caption, the chambers activated and the
. lives. The colour of the room is made bright
. and used for the whole attribute file.
N $A749 Fill the attribute file with the colour of the room.
  $A749,$03 Fetch #R$5B0D.
  $A74C,$02,b$01 Make it bright.
  $A74E,$03 Call #R$CE6A.
N $A751 Colour the lives icon and the lives count.
  $A751,$02 Set the attribute to #COLOUR$47.
  $A753,$03 Point #REGde at #N$5ACE (in the attribute buffer).
  $A756,$02 Set the number of cells to #N$02.
  $A758,$03 Call #R$CE1D.
  $A75B,$03 Point #REGde at #N$5AEE (in the attribute buffer).
  $A75E,$02 Set the number of cells to #N$04.
  $A760,$03 Call #R$CE1D.
N $A763 Colour the light years box and draw the objects carried.
  $A763,$03 Call #R$A7AE.
  $A766,$03 Call #R$BCAB.
N $A769 Print the "LIGHT YEARS" caption.
  $A769,$03 Fetch #R$5B0D.
  $A76C,$01 Invert it.
  $A76D,$02,b$01 Keep only the ink colour.
  $A76F,$02 Add #N$42.
  $A771,$03 Set #R$A797.
  $A774,$03 Point #REGde at #R$A797.
  $A777,$03 Point #REGhl at the position of the caption.
  $A77A,$03 Call #R$BBB1.
N $A77D Print the number of chambers activated.
  $A77D,$03 Call #R$A7A3.
  $A780,$03 Point #REGhl at #N$5A84 (in the attribute buffer).
  $A783,$02 Colour the first digit bright white.
  $A785,$01 Move on to the second digit.
  $A786,$02 Colour the second digit bright white.
N $A788 Colour the icon of the chamber.
  $A788,$03 Point #REGhl at #N$5A41 (in the attribute buffer).
  $A78B,$03 Set the width and the height to #N$03.
  $A78E,$03 Fetch #R$A797.
  $A791,$03 Call #R$BF83.
  $A794,$03 Jump to #R$BA57.

t $A797 Messaging: Light Years Caption
@ $A797 label=LightYearsCaption
D $A797 The attribute and the text of the
. "LIGHT YEARS" caption. #R$A749 sets the
. attribute each time the panel is coloured.
. The last character has bit 7 set.
B $A797,$01 #COLOUR(#PEEK(#PC)).
  $A798,$0B,$0A:$01 "LIGHT YEARS"

c $A7A3 Print Activated Chambers
@ $A7A3 label=PrintActivatedChambers
D $A7A3 Prints #R$5B40 as two digits next to
. the chamber icon.
N $A7A3 Print the number in the screen buffer.
  $A7A3,$03 Point #REGde at #R$5B40.
  $A7A6,$03 Point #REGhl at #R$D5E4.
  $A7A9,$02 Set the number of bytes to #N$01.
  $A7AB,$03 Jump to #R$BA62.

c $A7AE Colour Counter Box
@ $A7AE label=ColourCounterBox
D $A7AE Copies #R$A7CA to the attribute file.
. The box is six cells wide and three cells
. high.
N $A7AE Copy the attributes of the box.
  $A7AE,$03 Point #REGhl at #N$5A99 (in the attribute buffer).
  $A7B1,$03 Point #REGde at #R$A7CA.
  $A7B4,$03 Set the width to #N$06 and the height to #N$03.
@ $A7B7 label=ColourCounterBox_Row
  $A7B7,$02 Stash the size and the address of the row.
@ $A7B9 label=ColourCounterBox_Cell
  $A7B9,$01 Fetch the attribute of the cell.
  $A7BA,$01 Move on to the next attribute.
  $A7BB,$01 Write it to the attribute file.
  $A7BC,$01 Move on to the next cell.
  $A7BD,$02 Jump to #R$A7B9 until the row is done.
  $A7BF,$01 Restore the address of the row from the stack.
  $A7C0,$02 Set #REGa to #N$20.
  $A7C2,$03 Call #R$CE06.
  $A7C5,$01 Restore the size of the box from the stack.
  $A7C6,$03 Jump to #R$A7B7 until all of the rows are done.
  $A7C9,$01 Return.

b $A7CA Counter Box Attributes
@ $A7CA label=CounterBoxAttributes
D $A7CA The attributes for the box around the
. light years remaining counter, six cells
. wide and three high. The box is red with a
. white centre.
B $A7CA,$12,$06

c $A7DC Reset Wipe Flags
@ $A7DC label=ResetWipeFlags
D $A7DC Clears bit 5 of the flags of every
. object, once the screen has been refreshed.
E $A7DC View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B088 }
. { #PENTAGRAM$BF0D }
. LIST#
N $A7DC Clear the wipe flag of every object.
  $A7DC,$02 Set the number of objects to #N$38.
  $A7DE,$03 Set #REGde to #N($0020,$04,$04).
  $A7E1,$03 Point #REGhl at #R$5B8F.
@ $A7E4 label=ResetWipeFlags_Loop
  $A7E4,$02 Reset bit 5 of the flags.
  $A7E6,$01 Move on to the next object.
  $A7E7,$02 Jump to #R$A7E4 until all of the objects are done.
  $A7E9,$01 Return.

w $A7EA Object Update Routines
@ $A7EA label=ObjectUpdateRoutines
D $A7EA The table of update routines, one
. entry for each sprite number from #N$00 to
. #N$82. #R$A68B calls the routine for each
. object, with #REGix pointing at it, and
. pushes #R$A6C0 as the return address.
W $A7EA,$04,$02 Objects #N$00 and #N$01: nothing to do (#R$A8F0). Slots which
. are empty have sprite #N$00 and objects that have been retired have sprite
. #N$01.
W $A7EE,$02 Object #N($02), the near side of an arch (#R$BFEA).
W $A7F0,$02 Object #N($03), the far side of an arch (#R$BFD8).
W $A7F2,$06,$02 Objects #N$04 to #N$06: parts of the border of the screen, which
. are only drawn (#R$A8F0).
W $A7F8,$08,$02 Objects #N$07 to #N$0A: parts of the status panel, which are
. only drawn (#R$A8F0).
W $A800,$02 Object #N($0B), the second part of a robot mouse, which follows the
. object in front of it in the table (#R$B055).
W $A802,$02 Object #N($0C), an extra life (#R$BEE0).
W $A804,$02 Object #N($0D), part of a wall (#R$BF51).
W $A806,$02 Object #N($0E), part of a wall (#R$BF74).
W $A808,$02 Object #N($0F), part of a wall (#R$BF65).
W $A80A,$10,$02 Objects #N$10 to #N$17: the lower half of the robot in each of
. its walking positions (#R$C0BE).
W $A81A,$08,$02 Objects #N$18 to #N$1B: the lower half of the robot when it is
. standing still, facing the front and the side (#R$C1E2).
W $A822,$02 Object #N($1C), a block which is fat at the bottom (#R$B2FF).
W $A824,$02 Object #N($1D), a block which is fat at the top (#R$B31A).
W $A826,$02 Object #N($1E), a block (#R$BF3D).
W $A828,$02 Object #N($1F), a block which moves up and down (#R$B33F).
W $A82A,$18,$02 Objects #N$20 to #N$2B: the upper half of the robot in each of
. its positions (#R$C6E4).
W $A842,$02 Object #N($2C), a block which falls when something touches it
. (#R$B2B6).
W $A844,$02 Object #N($2D), a block which collapses (#R$B28C).
W $A846,$02 Object #N($2E), a broken egg, which is deadly to touch (#R$B2A4).
W $A848,$02 Object #N($2F), a block which moves up and down while the player is
. standing on it (#R$B31F).
W $A84A,$0E,$02 Objects #N$30 to #N$36: sparkles (#R$B3A4).
W $A858,$02 Object #N$37: sparkles (#R$B3B8).
W $A85A,$0E,$02 Objects #N$38 to #N$3E: sparkles (#R$BC70).
W $A868,$02 Object #N$3F: sparkles (#R$BC83).
W $A86A,$02 Object #N$40: sparkles (#R$B3A4).
W $A86C,$02 Object #N($41), which
. clears the object it points to and
. turns into a sparkle (#R$B3B0).
W $A86E,$02 Object #N($42), a block which moves east and west (#R$B224).
W $A870,$02 Object #N($43), a block which moves north and south (#R$B21C).
W $A872,$02 Object #N($44), a conveyor which carries objects north (#R$B267).
W $A874,$02 Object #N($45), a conveyor which carries objects east (#R$B27A).
W $A876,$02 Object #N($46), a conveyor which carries objects south (#R$B280).
W $A878,$02 Object #N($47), a conveyor which carries objects west (#R$B286).
W $A87A,$02 Object #N($48), a deadly pyramid (#R$B29F).
W $A87C,$02 Object #N($49), the top of a broken egg, which is deadly to touch
. (#R$AD13).
W $A87E,$02 Object #N($4A), a cryonaut looking out of a chamber (#R$AE96).
W $A880,$02 Object #N($4B), deadly tubes (#R$B29F).
W $A882,$08,$02 Objects #N$4C to #N$4F: sparkles which fly towards the player
. (#R$B19C).
W $A88A,$02 Object #N($50), the alarm in the game over scene (#R$ABF5).
W $A88C,$06,$02 Objects #N$51 to #N$53: the boxing glove, hammer and hook in the
. game over scene (#R$AB61).
W $A892,$02 Object #N($54), part of the status panel, which is only drawn
. (#R$A8F0).
W $A894,$02 Object #N($55), the pot of oil in the game completed scene, which is
. only coloured (#R$AC21).
W $A896,$04,$02 Objects #N$56 and #N$57: a robot mouse (#R$B110).
W $A89A,$08,$02 Objects #N$58 to #N$5B: the sides, the bottom half and the top
. half of the robot in the game over scene, which are only coloured (#R$AC21).
W $A8A2,$02 Object #N($5C), the bottom half of the robot in the game completed
. scene (#R$A971).
W $A8A4,$02 Object #N($5D), the top half
. of the robot in the game completed
. scene (#R$A95A).
W $A8A6,$04,$02 Objects #N$5E and #N$5F: a robot mouse (#R$B06B).
W $A8AA,$08,$02 Objects #N$60 to #N$63: a valve lying about in a room, in the
. shape of a cylinder, a cube, a pyramid or a half sphere (#R$AF79).
W $A8B2,$08,$02 Objects #N$64 to #N$67: a valve in place on a socket (#R$AE5D).
W $A8BA,$08,$02 Objects #N$68 to #N$6B: the ghost of the valve which a socket
. needs (#R$AE17).
W $A8C2,$08,$02 Objects #N$6C to #N$6F: sparkles used while the ghost of a valve
. appears (#R$AE33).
W $A8CA,$08,$02 Objects #N$70 to #N$73: a socket for a cylinder, cube, pyramid
. or half sphere (#R$AE68).
W $A8D2,$08,$02 Objects #N$74 to #N$77: a clockwork mouse (#R$AAA1).
W $A8DA,$04,$02 Objects #N$78 and #N$79: a chasing dome (#R$AA89).
W $A8DE,$04,$02 Objects #N$7A and #N$7B: a remote control arrow (#R$AA63).
W $A8E2,$08,$02 Objects #N$7C to #N$7F: the remote control robot (#R$A9C7).
W $A8EA,$02 Object #N($80), the remote control block (#R$AA4D).
W $A8EC,$02 Object #N($81), the spiked dome, which is deadly to touch (#R$A9B1).
W $A8EE,$02 Object #N($82), the land mine, which is deadly to touch (#R$A8F9).

c $A8F0 Do Nothing
@ $A8F0 label=NoUpdate
D $A8F0 The update routine for objects which
. have nothing to do on each pass, such as the
. walls, the backdrop of an arch and the
. panel.
  $A8F0,$01 Return.

c $A8F1 Check Protection
@ $A8F1 label=CheckProtection
D $A8F1 Part of the tape protection. The Z80
. keeps bit 7 of #REGr as it was last written,
. and the tape loader leaves it set. If the
. game was started any other way then bit 7 is
. clear and the machine is reset.
N $A8F1 Reset the machine if bit 7 of #REGr is clear.
  $A8F1,$03 Point #REGhl at #SKOOLKID$0000(START).
  $A8F4,$02 Fetch #REGr.
  $A8F6,$01 Move bit 7 into the carry flag.
  $A8F7,$01 Return if the bit is set.
  $A8F8,$01 Jump to #SKOOLKID$0000(START).

c $A8F9 Handle Land Mine
@ $A8F9 label=HandleLandMine
D $A8F9 The update routine for the land mine
. (object #N$82). It sits on the floor and is
. deadly to touch. Every so often one mine in
. the room leaps and falls. Bit 0 of
. #REGix+#N$10 is set while it is leaping, bit
. 1 while it is falling. #REGix+#N$11 is the
. height at the top of the leap. #R$5B43 is
. set while any mine is leaping.
R $A8F9 IX The address of the object
N $A8F9 Start a leap if no other mine is leaping.
  $A8F9,$03 Call #R$BF3D.
  $A8FC,$03 Call #R$B2A7.
  $A8FF,$06 Jump to #R$A921 if the mine is already leaping.
  $A905,$05 Return if #R$5B43 is set.
  $A90A,$03 Fetch #R$5B05.
  $A90D,$01 Add one to it.
  $A90E,$02,b$01 Keep bits 0 and 1.
  $A910,$01 Return if they are not zero.
  $A911,$02 Set #REGa to #N$01.
  $A913,$03 Set #R$5B43.
  $A916,$03 Mark this mine as leaping.
  $A919,$03 Fetch the height of the mine.
  $A91C,$02 Add #N$30.
  $A91E,$03 Store the height at the top of the leap.
N $A921 Move the mine for this pass.
@ $A921 label=HandleLandMine_MoveMine
  $A921,$06 Jump to #R$A93D if the mine is not falling.
  $A927,$03 Call #R$BFB6.
  $A92A,$06 Jump to #R$A937 if the mine has not landed.
  $A930,$01 Write #N$00.
  $A931,$03 Clear the state of the mine.
  $A934,$03 Write #N$00 to #R$5B43.
N $A937 Play a sound and redraw the mine.
@ $A937 label=HandleLandMine_SoundAndRedraw
  $A937,$03 Call #R$B63C.
  $A93A,$03 Jump to #R$BFAB.
N $A93D The mine is rising.
@ $A93D label=HandleLandMine_Rising
  $A93D,$04 Set the vertical speed to #N$03.
  $A941,$03 Call #R$BFB6.
  $A944,$03 Fetch the height of the mine.
  $A947,$05 Jump to #R$A954 if it has reached the top.
  $A94C,$06 Jump to #R$A954 if it has hit something above.
  $A952,$02 Jump to #R$A937.
N $A954 The mine starts falling.
@ $A954 label=HandleLandMine_StartFalling
  $A954,$04 Mark the mine as falling.
  $A958,$02 Jump to #R$A937.

c $A95A Handle Ending Robot Top
@ $A95A label=HandleEndingRobotTop
D $A95A The update routine for the top half of
. the robot in the game completed scene
. (object #N$5D). The bottom half (object
. #N$5C) is the previous object, handled by
. #R$A971. This copies its pixel y position,
. colour and flags, #N$10 pixels higher.
R $A95A IX The address of the object
N $A95A Sit on top of the bottom half and colour the cells.
  $A95A,$03 Fetch the pixel y position of the previous object.
  $A95D,$02 Add #N$10.
  $A95F,$03 Store it as the pixel y position.
  $A962,$03 Fetch the colour of the previous object.
  $A965,$03 Use the same colour.
  $A968,$03 Fetch the flags of the previous object.
  $A96B,$03 Use the same flags.
  $A96E,$03 Jump to #R$AC21.

c $A971 Handle Ending Robot Bottom
@ $A971 label=HandleEndingRobotBottom
D $A971 The update routine for the bottom
. half of the robot in the game completed
. scene (object #N$5C). The counter in
. #REGix+#N$11 waits for #N$40 passes, then
. the robot goes down three pixels a pass
. into the pot of oil at row #N$28. After
. #N$80 it comes back up, bright white. At
. row #N$80 the end tune is played and a new
. game is started.
R $A971 IX The address of the object
N $A971 Wait, go down, or come back up.
  $A971,$03 Fetch the counter.
  $A974,$04 Jump to #R$A991 if it is less than #N$40.
  $A978,$04 Jump to #R$A996 if it is #N$80 or more.
N $A97C The robot is going down into the pot of oil.
  $A97C,$03 Fetch the pixel y position.
  $A97F,$04 Jump to #R$A991 if it has reached row #N$28.
  $A983,$02 Take #N$03 off it.
  $A985,$03 Store the pixel y position.
N $A988 Play a sound and redraw the robot.
@ $A988 label=HandleEndingRobotBottom_SoundAndRedraw
  $A988,$03 Call #R$B63F.
  $A98B,$03 Call #R$BFAB.
@ $A98E label=HandleEndingRobotBottom_ColourCells
  $A98E,$03 Jump to #R$AC21.
N $A991 Count another pass.
@ $A991 label=HandleEndingRobotBottom_CountPass
  $A991,$03 Increment the counter.
  $A994,$02 Jump to #R$A98E.
N $A996 The robot is coming back up.
@ $A996 label=HandleEndingRobotBottom_ComingUp
  $A996,$03 Fetch the pixel y position.
  $A999,$04 Jump to #R$A9A8 if it has reached row #N$80.
  $A99D,$02 Add #N$03.
  $A99F,$03 Store the pixel y position.
  $A9A2,$04 Set the colour to bright white.
  $A9A6,$02 Jump to #R$A988.
N $A9A8 The robot has come out of the oil.
N $A9A8 #HTML(#AUDIO0(robot-tune.wav)(#INCLUDE(RobotTune)))
@ $A9A8 label=HandleEndingRobotBottom_Landed
  $A9A8,$03 Point #REGde at #R$B3D7.
  $A9AB,$03 Call #R$B4BA.
  $A9AE,$03 Jump to #R$A647.

c $A9B1 Handle Spiked Dome
@ $A9B1 label=HandleSpikedDome
D $A9B1 The update routine for the spiked
. dome (object #N$81), which is deadly to
. touch and does not move. If it is ever set
. moving it is replaced with a sparkle
. (object #N$36).
R $A9B1 IX The address of the object
N $A9B1 Vanish if the dome is moving.
  $A9B1,$03 Call #R$BF6A.
  $A9B4,$09 Combine the speeds in every direction.
  $A9BD,$03 Jump to #R$B2A7 if it is not moving.
  $A9C0,$04 Turn it into a sparkle.
  $A9C4,$03 Jump to #R$B2B0.

c $A9C7 Handle Remote Control Robot
@ $A9C7 label=HandleRemoteControlRobot
D $A9C7 The update routine for the remote
. control robot (objects #N$7C to #N$7F). The
. pads at #R$AA63 and #R$AA4D leave a command
. in #R$5B42: bit 7 says a robot is listening,
. and bits 0 to 5 hold the command. The first
. robot to be updated claims bit 7 of #R$5B42
. and bit 7 of #REGix+#N$10. When a command
. arrives it sets bit 6 instead and follows
. the pad until it is released.
R $A9C7 IX The address of the object
N $A9C7 See whether this robot is listening or following.
  $A9C7,$03 Call #R$BF3D.
  $A9CA,$03 Point #REGhl at #R$5B42.
  $A9CD,$01 Fetch the command.
  $A9CE,$02,b$01 Keep bit 7.
  $A9D0,$02 Jump to #R$A9FE if no robot is listening.
  $A9D2,$03 Fetch the state of this robot.
  $A9D5,$02,b$01 Keep bits 6 and 7.
  $A9D7,$02 Jump to #R$A9F1 if this robot is neither.
  $A9D9,$06 Jump to #R$AA06 if this robot is listening.
N $A9DF This robot is following the pad.
  $A9DF,$01 Fetch the command.
  $A9E0,$02,b$01 Keep bits 0 to 5.
  $A9E2,$02 Jump to #R$AA15 if there is a command.
  $A9E4,$02 Reset bit 7 of #R$5B42.
  $A9E6,$04 Reset bit 6 of the state.
  $A9EA,$01 Write #N$00.
  $A9EB,$03 Stop the speed along the x axis.
  $A9EE,$03 Stop the speed along the y axis.
N $A9F1 Move the robot and redraw it if it is moving.
@ $A9F1 label=HandleRemoteControlRobot_Move
  $A9F1,$03 Call #R$BFB6.
  $A9F4,$04 Return if the robot is not moving.
  $A9F8,$03 Call #R$B63C.
  $A9FB,$03 Jump to #R$BFAB.
N $A9FE Make this robot the listener.
@ $A9FE label=HandleRemoteControlRobot_BecomeListener
  $A9FE,$02 Set bit 7 of #R$5B42.
  $AA00,$04 Set bit 7 of the state.
  $AA04,$02 Jump to #R$A9F1.
N $AA06 This robot is listening.
@ $AA06 label=HandleRemoteControlRobot_Listening
  $AA06,$01 Fetch the command.
  $AA07,$02,b$01 Keep bits 0 to 6.
  $AA09,$02 Jump to #R$A9F1 if there is no command.
  $AA0B,$03 Fetch the state of this robot.
  $AA0E,$02,b$01 Keep bits 0 to 5.
  $AA10,$02,b$01 Set bit 6.
  $AA12,$03 Store the state.
N $AA15 Carry out a command from #R$AA43.
@ $AA15 label=HandleRemoteControlRobot_CarryOutCommand
  $AA15,$01 Fetch the command.
  $AA16,$02 Set #R$5B42 to #N$80.
  $AA18,$01 Take one off the command.
  $AA19,$01 Double it.
  $AA1A,$02,b$01 Keep bits 1 to 6.
  $AA1C,$03 Point #REGhl at #R$AA43.
  $AA1F,$03 Call #R$CE06.
  $AA22,$01 Fetch the speed along the x axis.
  $AA23,$01 Move on to the speed along the y axis.
  $AA24,$03 Set the speed along the x axis.
  $AA27,$01 Fetch the speed along the y axis.
  $AA28,$01 Move #REGhl back.
  $AA29,$03 Set the speed along the y axis.
  $AA2C,$03 Call #R$B18C.
  $AA2F,$08 Jump to #R$AA3A if the robot is not moving.
  $AA37,$03 Call #R$BFB6.
@ $AA3A label=HandleRemoteControlRobot_PlaySound
  $AA3A,$03 Point #REGhl at #R$B6A9.
  $AA3D,$03 Call #R$B690.
  $AA40,$03 Jump to #R$BFAB.

b $AA43 Remote Control Robot Speeds
@ $AA43 label=RemoteControlRobotSpeeds
D $AA43 The speeds along the x and y axes
. given to the remote control robot for
. commands #N$01 to #N$05.
B $AA43,$02,$02 Command #N$01: stop
B $AA45,$02,$02 Command #N$02: move west
B $AA47,$02,$02 Command #N$03: move north
B $AA49,$02,$02 Command #N$04: move east
B $AA4B,$02,$02 Command #N$05: move south

c $AA4D Handle Remote Control Block
@ $AA4D label=HandleRemoteControlBlock
D $AA4D The update routine for the remote
. control block (object #N$80), the pad which
. tells the robot to stop. It is pressed when
. its vertical speed is not zero. The command
. is #N$01; bit 7 of #R$5B42 is left as it
. was.
R $AA4D IX The address of the object
N $AA4D Send the stop command if something has landed.
  $AA4D,$03 Call #R$BF3D.
  $AA50,$03 Fetch the vertical speed.
  $AA53,$02 Return if nothing has landed.
  $AA55,$04 Write #N$00 to the vertical speed.
  $AA59,$03 Point #REGhl at #R$5B42.
  $AA5C,$01 Fetch the command.
  $AA5D,$02,b$01 Keep bit 7.
  $AA5F,$02,b$01 Set the command to #N$01.
  $AA61,$01 Set #R$5B42.
  $AA62,$01 Return.

c $AA63 Handle Remote Control Arrow
@ $AA63 label=HandleRemoteControlArrow
D $AA63 The update routine for the remote
. control arrows (objects #N$7A and #N$7B).
. Object #N$7A is west, or north when flipped;
. object #N$7B is east, or south when flipped,
. giving commands #N$02 to #N$05.
R $AA63 IX The address of the object
N $AA63 Send a direction if something has landed.
  $AA63,$03 Call #R$BF3D.
  $AA66,$03 Fetch the vertical speed.
  $AA69,$02 Return if nothing has landed.
  $AA6B,$04 Write #N$00 to the vertical speed.
  $AA6F,$03 Fetch the flags of the pad.
  $AA72,$01 Move the flip into bit 7.
  $AA73,$02,b$01 Keep bit 7.
  $AA75,$01 Keep it in #REGc.
  $AA76,$03 Fetch the sprite number.
  $AA79,$02,b$01 Keep bit 0.
  $AA7B,$01 Combine it with the flip.
  $AA7C,$01 Move the bits into a command.
  $AA7D,$02 Add #N$02.
  $AA7F,$01 Keep the command in #REGc.
  $AA80,$03 Point #REGhl at #R$5B42.
  $AA83,$01 Fetch the command.
  $AA84,$02,b$01 Keep bit 7.
  $AA86,$01 Combine it with the new command.
  $AA87,$01 Set #R$5B42.
  $AA88,$01 Return.

c $AA89 Handle Chasing Dome
@ $AA89 label=HandleChasingDome
D $AA89 The update routine for the chasing
. dome (objects #N$78 and #N$79), which is
. deadly to touch. It moves towards the
. player at one unit per pass in each
. direction.
R $AA89 IX The address of the object
N $AA89 Head towards the player and redraw the dome.
  $AA89,$03 Call #R$BF6A.
  $AA8C,$03 Set the speed along each axis to #N$01.
  $AA8F,$03 Call #R$B165.
  $AA92,$03 Call #R$BFB6.
  $AA95,$03 Call #R$B185.
  $AA98,$03 Point #REGhl at #R$B6AD.
  $AA9B,$03 Call #R$B690.
  $AA9E,$03 Jump to #R$B2B0.

c $AAA1 Handle Clockwork Mouse
@ $AAA1 label=HandleClockworkMouse
D $AAA1 The update routine for the clockwork
. mouse (objects #N$74 to #N$77), which is
. deadly to touch. It runs along one axis for
. a random number of passes in #REGix+#N($10),
. or until it hits something. Then it chooses
. a new random speed and turns through a right
. angle, alternating between the x and y axes.
. The sprite number says which way it faces,
. and the flip flag says which axis it uses.
R $AAA1 IX The address of the object
N $AAA1 Move the mouse, or choose a new direction.
  $AAA1,$03 Call #R$BF5B.
  $AAA4,$03 Call #R$BFB6.
  $AAA7,$08 Jump to #R$AAC1 if the mouse is not moving.
  $AAAF,$03 Fetch the collision flags.
  $AAB2,$02,b$01 Keep bits 0 and 1.
  $AAB4,$02 Jump to #R$AAC1 if the mouse has hit something.
  $AAB6,$03 Count down the remaining passes.
  $AAB9,$02 Jump to #R$AAC1 if they have run out.
N $AABB Animate the mouse and redraw it.
@ $AABB label=HandleClockworkMouse_Animate
  $AABB,$03 Call #R$B185.
  $AABE,$03 Jump to #R$B2B0.
N $AAC1 Choose a new direction.
@ $AAC1 label=HandleClockworkMouse_ChooseDirection
  $AAC1,$03 Call #R$B6BB.
  $AAC4,$03 Fetch #R$5B02(#N$5B03).
  $AAC7,$01 Keep it in #REGc.
  $AAC8,$03 Fetch #R$5B05.
  $AACB,$01 Combine the two.
  $AACC,$02,b$01 Keep bits 0 to 3.
  $AACE,$03 Set the remaining passes.
  $AAD1,$03 Fetch the flags of the mouse.
  $AAD4,$02,b$01 Flip bit 6.
  $AAD6,$03 Store the flags.
  $AAD9,$03 Fetch #R$5B05.
  $AADC,$02,b$01 Keep bit 0.
  $AADE,$02 Jump to #R$AB0C if it is zero.
  $AAE0,$06 Jump to #R$AAEE if the mouse is not flipped.
N $AAE6 Turn the mouse round.
@ $AAE6 label=HandleClockworkMouse_TurnRound
  $AAE6,$03 Fetch the sprite number.
  $AAE9,$02,b$01 Flip bit 1.
  $AAEB,$03 Store the sprite number.
N $AAEE Choose a speed of #N$02 to #N$05.
@ $AAEE label=HandleClockworkMouse_ChooseSpeed
  $AAEE,$03 Fetch #R$5B02.
  $AAF1,$02,b$01 Keep bits 0 and 1.
  $AAF3,$02 Add #N$02.
  $AAF5,$06 Jump to #R$AAFD if the mouse is facing forwards.
  $AAFB,$02 Make the speed negative.
@ $AAFD label=HandleClockworkMouse_CheckFlipped
  $AAFD,$06 Jump to #R$AB14 if the mouse is flipped.
  $AB03,$03 Set the speed along the x axis.
  $AB06,$04 Write #N$00 as the speed along the y axis.
  $AB0A,$02 Jump to #R$AABB.
@ $AB0C label=HandleClockworkMouse_CheckFlippedForward
  $AB0C,$06 Jump to #R$AAE6 if the mouse is not flipped.
  $AB12,$02 Jump to #R$AAEE.
@ $AB14 label=HandleClockworkMouse_NegativeSpeed
  $AB14,$02 Make the speed negative.
  $AB16,$03 Set the speed along the y axis.
  $AB19,$04 Write #N$00 as the speed along the x axis.
  $AB1D,$02 Jump to #R$AABB.

c $AB1F Face Direction Of Travel
@ $AB1F label=FaceDirectionOfTravel
D $AB1F Turns an object to face the
. direction it is moving in. Nothing in the
. game calls this routine.
R $AB1F IX The address of the object
N $AB1F Compare the sizes of the two speeds.
  $AB1F,$03 Fetch the speed along the x axis.
  $AB22,$04 Jump to #R$AB28 if it is not negative.
  $AB26,$02 Make it positive.
@ $AB28 label=FaceDirectionOfTravel_SizeOfSpeedX
  $AB28,$01 Keep the size of the x speed in #REGc.
  $AB29,$03 Fetch the speed along the y axis.
  $AB2C,$04 Jump to #R$AB32 if it is not negative.
  $AB30,$02 Make it positive.
@ $AB32 label=FaceDirectionOfTravel_CompareSpeeds
  $AB32,$01 Compare it with the size of the x speed.
  $AB33,$02 Jump to #R$AB4B if the y speed is smaller.
N $AB35 Face along the x axis.
  $AB35,$03 Fetch the speed along the x axis.
  $AB38,$04 Jump to #R$AB45 if it is not negative.
  $AB3C,$04 Reset bit 1 of the sprite number.
@ $AB40 label=FaceDirectionOfTravel_Unflip
  $AB40,$04 Reset bit 6 of the flags.
  $AB44,$01 Return.
@ $AB45 label=FaceDirectionOfTravel_FaceForwards
  $AB45,$04 Set bit 1 of the sprite number.
  $AB49,$02 Jump to #R$AB40.
N $AB4B Face along the y axis.
@ $AB4B label=FaceDirectionOfTravel_CheckSpeedY
  $AB4B,$03 Fetch the speed along the y axis.
  $AB4E,$04 Jump to #R$AB5B if it is not negative.
  $AB52,$04 Set bit 1 of the sprite number.
@ $AB56 label=FaceDirectionOfTravel_Flip
  $AB56,$04 Set bit 6 of the flags.
  $AB5A,$01 Return.
@ $AB5B label=FaceDirectionOfTravel_FaceBackwards
  $AB5B,$04 Reset bit 1 of the sprite number.
  $AB5F,$02 Jump to #R$AB56.

c $AB61 Handle Attacking Tool
@ $AB61 label=HandleAttackingTool
D $AB61 The handler for the boxing glove,
. hammer and hook (objects #N$51 to #N$53).
. In the game over scene they take it in
. turns to beat the robot, once the alarm has
. finished flashing (see #R$ABF5).
.
. A tool swings towards the robot for six
. frames, makes a noise, and swings back for
. six frames. Bit 7 of the state holds the
. direction and bit 0 is set while it is
. attacking. The game restarts after #N$10
. attacks, or if a number key is pressed.
R $AB61 IX The address of the object
N $AB61 Start an attack, or keep one going.
  $AB61,$03 Point #REGhl at #R$5B41.
  $AB64,$04 Jump to #R$ABDA if #R$5B41 is zero.
  $AB68,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$E7 | 1 / 0 | 2 / 9 | 3 / 8 | 4 / 7 | 5 / 6 }
. TABLE#
  $AB6D,$03 Jump to #R$A647 if a key is pressed.
  $AB70,$06 Jump to #R$AB91 if this tool is already attacking.
  $AB76,$04 Jump to #R$ABDA if another tool is attacking.
  $AB7A,$03 Fetch #R$5B05.
  $AB7D,$01 Invert it.
  $AB7E,$02,b$01 Keep bits 0 and 1.
  $AB80,$02 Jump to #R$ABDA unless both bits were set.
  $AB82,$05 Call #R$B619, preserving #REGhl.
  $AB87,$04 Set bit 0 of the state.
  $AB8B,$02 Set bit 7 of #R$5B41.
  $AB8D,$04 Write #N$06 to the frame counter.
N $AB91 The boxing glove and the hook move
. along the x axis by #N$08; the hammer moves
. along the y axis by #N$04.
@ $AB91 label=HandleAttackingTool_Swing
  $AB91,$03 Fetch the sprite number.
  $AB94,$02,b$01 Keep bit 0.
  $AB96,$02 Jump to #R$ABDD if the tool is the hammer.
  $AB98,$06 Compare bit 7 of the pixel x with bit 7 of the direction.
  $AB9E,$02,b$01 Keep bit 7.
  $ABA0,$02 Set the step to #N$08.
  $ABA2,$02 Jump to #R$ABA6 if the step already points the right way.
  $ABA4,$02 Make the step negative.
@ $ABA6 label=HandleAttackingTool_MoveAlongX
  $ABA6,$06 Add the step to the pixel x position.
@ $ABAC label=HandleAttackingTool_CountFrame
  $ABAC,$05 Jump to #R$ABD7 if this swing has not finished.
  $ABB1,$04 Write #N$06 to the frame counter.
  $ABB5,$03 Fetch the state of the tool.
  $ABB8,$02,b$01 Flip bit 7.
  $ABBA,$03 Store the state.
  $ABBD,$02,b$01 Keep bit 7.
  $ABBF,$02 Jump to #R$ABC6 if the tool has finished swinging back.
  $ABC1,$03 Call #R$B676.
  $ABC4,$02 Jump to #R$ABD7.
N $ABC6 The swing back has finished.
@ $ABC6 label=HandleAttackingTool_AttackFinished
  $ABC6,$04 Reset bit 0 of the state.
  $ABCA,$02 Reset bit 7 of #R$5B41.
  $ABCC,$01 Increment #R$5B41.
  $ABCD,$01 Fetch #R$5B41.
  $ABCE,$02,b$01 Keep bits 0 to 6.
  $ABD0,$04 Jump to #R$ABD7 unless #N$10 attacks have been made.
  $ABD4,$03 Jump to #R$A647.
@ $ABD7 label=HandleAttackingTool_Redraw
  $ABD7,$03 Call #R$BFAB.
@ $ABDA label=HandleAttackingTool_ColourCells
  $ABDA,$03 Jump to #R$AC21.
N $ABDD Move the hammer along the y axis.
@ $ABDD label=HandleAttackingTool_MoveAlongY
  $ABDD,$03 Fetch the pixel y position.
  $ABE0,$02 Add #N$20.
  $ABE2,$03 Compare bit 7 with bit 7 of the direction.
  $ABE5,$02,b$01 Keep bit 7.
  $ABE7,$02 Set the step to #N$04.
  $ABE9,$02 Jump to #R$ABED if the step already points the right way.
  $ABEB,$02 Make the step negative.
@ $ABED label=HandleAttackingTool_AddStepToY
  $ABED,$06 Add the step to the pixel y position.
  $ABF3,$02 Jump to #R$ABAC.

c $ABF5 Handle Alarm
@ $ABF5 label=HandleAlarm
D $ABF5 The handler for the alarm (object
. #N$50) in the game over scene. Every eight
. frames it changes colour between black and
. bright yellow and beeps. After #N$10
. changes it retires itself and starts the
. attacks on the robot by setting #R$5B41.
R $ABF5 IX The address of the object
N $ABF5 Flash the alarm every eight frames.
  $ABF5,$03 Fetch #R$5B02.
  $ABF8,$01 Keep it in #REGc.
  $ABF9,$02,b$01 Keep bits 0 to 2.
  $ABFB,$02 Jump to #R$AC21 if this is not the eighth frame.
  $ABFD,$04 Jump to #R$AC03 if bit 3 of the frame counter is clear.
  $AC01,$02 Add #N$46.
@ $AC03 label=HandleAlarm_SetColour
  $AC03,$03 Set the colour of the alarm.
  $AC06,$03 Call #R$B6B1.
  $AC09,$03 Increment the colour-change count.
  $AC0C,$07 Jump to #R$AC21 unless there have been #N$10 changes.
  $AC13,$05 Write #N$01 to #R$5B41.
  $AC18,$03 Set the sprite number to #N$01.
  $AC1B,$03 Call #R$AC21.
  $AC1E,$03 Jump to #R$BFAB.

c $AC21 Colour Cells
@ $AC21 label=ColourCells
D $AC21 Colours the attribute cells covered
. by an object, using the colour in the
. object record. Cells which already have the
. colour #N$44 are left alone.
R $AC21 IX The address of the object
N $AC21 Work out the cells covered by the sprite.
  $AC21,$07 Return if the sprite has no width and no height.
  $AC28,$03 Fetch the pixel x position.
  $AC2B,$03 Fetch the width in cells.
  $AC2E,$01 Copy the pixel x position to #REGa.
  $AC2F,$02,b$01 Keep bits 0 to 2.
  $AC31,$02 Jump to #R$AC34 if the sprite starts on a cell edge.
  $AC33,$01 Increment the width.
@ $AC34 label=ColourCells_FindRows
  $AC34,$03 Fetch the pixel y position.
  $AC37,$04 Divide the pixel y position by eight.
  $AC3B,$02,b$01 Keep bits 0 to 4.
  $AC3D,$01 Keep the first row in #REGc.
  $AC3E,$05 Find the pixel y of the other end.
  $AC43,$03 Divide it by eight.
  $AC46,$02,b$01 Keep bits 0 to 4.
  $AC48,$03 Work out the number of rows.
  $AC4B,$03 Call #R$D157.
  $AC4E,$01 Copy the address to #REGhl.
  $AC4F,$03 Fetch the colour of the object.
  $AC52,$03 Set #REGde to #N($0020,$04,$04).
N $AC55 Colour each row of cells.
@ $AC55 label=ColourCells_ColourRow
  $AC55,$02 Stash the counters and the address on the stack.
  $AC57,$01 Keep the colour in #REGc.
@ $AC58 label=ColourCells_ColourCell
  $AC58,$05 Jump to #R$AC5E if the cell is already #N$44.
  $AC5D,$01 Colour the cell.
@ $AC5E label=ColourCells_NextCell
  $AC5E,$01 Move on to the next cell in the row.
  $AC5F,$02 Jump to #R$AC58 until the row is done.
  $AC61,$01 Put the colour back in #REGa.
  $AC62,$02 Restore the address and the counters from the stack.
  $AC64,$03 Move to the next row, which is above this one.
  $AC67,$03 Jump to #R$AC55 until all of the rows are done.
  $AC6A,$01 Return.

c $AC6B Count Statistics
@ $AC6B label=CountStatistics
D $AC6B Goes through the data for all of the
. rooms and counts those whose first object is
. a cryonaut. If the room holds a placed valve
. (objects #N$64 to #N$67) it is counted in
. #R$5B3E; otherwise it is counted in #R$5B3F
. and its cryonauts are added to #R$5B3C. All
. of the totals are BCD. They are shown when
. the game is over.
N $AC6B Clear the totals and start at the first room.
  $AC6B,$03 Point #REGde at #R$5B3C.
  $AC6E,$02 Set a counter of four.
  $AC70,$03 Call #R$CE1C.
  $AC73,$03 Point #REGhl at #R$6469.
@ $AC76 label=CountStatistics_NextRoom
  $AC76,$01 Fetch the room number.
  $AC77,$01 Move on to the length.
  $AC78,$01 Fetch the length.
N $AC79 Look for the #N$FF that ends the blocks.
@ $AC79 label=CountStatistics_ScanBlocks
  $AC79,$01 Fetch a byte of the data.
  $AC7A,$01 Move on.
  $AC7B,$01 Add one so that #N$FF becomes zero.
  $AC7C,$02 Jump to #R$AC8A if it was the end of the list.
  $AC7E,$02 Jump to #R$AC79 until the length runs out.
@ $AC80 label=CountStatistics_SkipRoom
  $AC80,$03 Point #REGbc at #R$73C8.
  $AC83,$03 Subtract #R$73C8 from #REGhl.
  $AC86,$01 Return if all of the rooms have been done.
  $AC87,$01 Restore the address.
  $AC88,$02 Jump to #R$AC76.
N $AC8A The objects of the room follow. Only the first is looked at.
@ $AC8A label=CountStatistics_FirstObject
  $AC8A,$01 Count the end of the list of blocks.
  $AC8B,$01 Fetch the type of the first object.
  $AC8C,$02,b$01 Keep bits 3 to 7.
  $AC8E,$04 Jump to #R$AC9C if it is a cryonaut facing east.
  $AC92,$04 Jump to #R$AC9C if it is a cryonaut facing south.
@ $AC96 label=CountStatistics_NextRoomFromHere
  $AC96,$01 Fetch the remaining length.
  $AC97,$03 Call #R$CE06.
  $AC9A,$02 Jump to #R$AC80.
N $AC9C Search #R$76E3 for a valve placed in this room.
@ $AC9C label=CountStatistics_FindPlacedValve
  $AC9C,$04 Point #REGiy at #R$76E3.
@ $ACA0 label=CountStatistics_TestSpecialObject
  $ACA0,$03 Fetch the room of the special object.
  $ACA3,$03 Jump to #R$ACC2 if it is this room.
@ $ACA6 label=CountStatistics_NextSpecialObject
  $ACA6,$03 Set #REGde to #N($0009,$04,$04).
  $ACA9,$02 Move on to the next special object.
  $ACAB,$01 Stash the room pointer on the stack.
  $ACAC,$03 Copy #REGiy to #REGhl (using the stack).
  $ACAF,$03 Point #REGde at #R$7827.
  $ACB2,$03 Subtract #R$7827 from #REGhl.
  $ACB5,$03 Copy the result to #REGiy (using the stack).
  $ACB8,$01 Restore the room pointer from the stack.
  $ACB9,$02 Jump to #R$ACD6 if the table has been searched.
  $ACBB,$03 Point #REGde at #R$7827.
  $ACBE,$02 Add it back to #REGiy.
  $ACC0,$02 Jump to #R$ACA0.
@ $ACC2 label=CountStatistics_TestPlacedValve
  $ACC2,$03 Fetch the special object number.
  $ACC5,$02 Subtract #N$64.
  $ACC7,$04 Jump to #R$ACA6 unless it is one of the four placed valves.
  $ACCB,$09 Add one to #R$5B3E.
  $ACD4,$02 Jump to #R$AC96.
N $ACD6 There is no valve in the room, so its cryonauts are lost.
@ $ACD6 label=CountStatistics_CountCryonauts
  $ACD6,$04 Point #REGhl at #R$5B3D and #REGde at the object.
  $ACDA,$01 Fetch the type and number of places.
  $ACDB,$02,b$01 Keep bits 0 to 2.
  $ACDD,$01 Add one.
  $ACDE,$03 Add it to the low two digits.
  $ACE1,$02 Fetch the high two digits.
  $ACE3,$04 Add the carry to them.
  $ACE7,$01 Put the object pointer back in #REGhl.
  $ACE8,$01 Fetch the type and number of places.
  $ACE9,$02,b$01 Keep bits 0 to 2.
  $ACEB,$02 Add #N$02.
  $ACED,$01 Keep the length in #REGe.
  $ACEE,$03 Call #R$CE06.
  $ACF1,$01 Fetch the length.
  $ACF2,$02 Make it negative.
  $ACF4,$02 Subtract it from the bytes left.
  $ACF6,$02 Jump to #R$AD07 if nothing is left.
  $ACF8,$01 Fetch the type of the next object.
  $ACF9,$02,b$01 Keep bits 3 to 7.
  $ACFB,$04 Jump to #R$ACD6 if it is another cryonaut facing east.
  $ACFF,$04 Jump to #R$ACD6 if it is another cryonaut facing south.
  $AD03,$04 Skip the rest of the room.
@ $AD07 label=CountStatistics_CountChamberNotActivated
  $AD07,$09 Add one to #R$5B3F.
  $AD10,$03 Jump to #R$AC80.

c $AD13 Handle Egg Top
@ $AD13 label=HandleEggTop
D $AD13 The handler for the top half of a
. broken egg (object #N$49), which is deadly
. to touch. Only one is active at a time
. (#R$5B3A is set), and none are while
. #R$5B3B is set. An inactive egg top becomes
. active with a chance of one in sixteen on
. each frame. While it is active it is moved
. with gravity and makes a sound when it
. lands. Until then it hangs in the air.
E $AD13 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B7A9 }
. LIST#
R $AD13 IX The address of the object
N $AD13 Hang in the air until this egg is chosen to drop.
  $AD13,$03 Call #R$B2A7.
  $AD16,$03 Call #R$BF47.
  $AD19,$05 Return if #R$5B3B is set.
  $AD1E,$06 Jump to #R$AD37 if this egg top is already active.
  $AD24,$03 Point #REGhl at #R$5B3A.
  $AD27,$03 Return if #R$5B3A is set.
  $AD2A,$03 Fetch #R$5B05.
  $AD2D,$03 Return unless it is less than #N$10.
  $AD30,$04 Set bit 2 of the state.
  $AD34,$02 Write #N$01 to #R$5B3A.
  $AD36,$01 Return.
N $AD37 The egg top is active, so let it fall.
@ $AD37 label=HandleEggTop_MoveActive
  $AD37,$03 Call #R$BFB6.
  $AD3A,$03 Call #R$AD54.
  $AD3D,$06 Jump to #R$AD49 if it has landed.
  $AD43,$03 Call #R$B63C.
@ $AD46 label=HandleEggTop_Redraw
  $AD46,$03 Jump to #R$BFAB.
N $AD49 The egg top has landed, so another one may drop.
@ $AD49 label=HandleEggTop_Landed
  $AD49,$04 Reset bit 2 of the state.
  $AD4D,$03 Point #REGhl at #R$5B3A.
  $AD50,$02 Write #N$00 to #R$5B3A.
  $AD52,$02 Jump to #R$AD46.

c $AD54 Play Landing Sound Once
@ $AD54 label=PlayLandingSoundOnce
D $AD54 Plays a random noise when the
. object has just landed, which is when bit 2
. of its collision flags is set and was not
. set the last time. The last state is kept
. at offset #N$0F of the object.
R $AD54 IX The address of the object
N $AD54 Play a noise only on the first landed frame.
  $AD54,$03 Fetch the collision flags.
  $AD57,$02,b$01 Keep bit 2.
  $AD59,$01 Keep it in #REGc.
  $AD5A,$01 Return if the object has not landed.
  $AD5B,$03 Fetch the state recorded last time.
  $AD5E,$01 Compare it with the current state.
  $AD5F,$03 Record the current state.
  $AD62,$03 Call #R$B676 if the state has changed.
  $AD65,$01 Return.

c $AD66 Update Light Years
@ $AD66 label=UpdateLightYears
D $AD66 Counts the light years down, prints
. the four digits in the counter box, inverts
. the last of them and copies the counter to
. the screen. When all of the digits and
. their animation steps are zero the game is
. over. The light years go down by one every
. eight frames.
N $AD66 Print the four digits into the buffer.
  $AD66,$03 Call #R$ADC9.
  $AD69,$03 Call #R$ADE5.
  $AD6C,$03 Point #REGhl at #R$D4FA.
  $AD6F,$03 Point #REGde at #R$5B36.
  $AD72,$02 Set a counter of four digits.
  $AD74,$01 Stash the buffer address on the stack.
  $AD75,$03 Point #REGhl at #R$6308.
  $AD78,$03 Set #R$5B27.
  $AD7B,$01 Restore the buffer address from the stack.
@ $AD7C label=UpdateLightYears_PrintDigit
  $AD7C,$01 Fetch the digit and its animation step.
  $AD7D,$01 Move on to the next digit.
  $AD7E,$03 Call #R$ADB0.
  $AD81,$02 Jump to #R$AD7C until all four digits have been printed.
N $AD83 Invert the last digit and copy the counter to the screen.
  $AD83,$03 Point #REGhl at #R$D41D.
  $AD86,$02 Set a counter of eight pixel rows.
  $AD88,$03 Set #REGde to #N($0020,$04,$04).
@ $AD8B label=UpdateLightYears_InvertRow
  $AD8B,$01 Fetch a row of the last digit.
  $AD8C,$01 Invert it.
  $AD8D,$01 Store it.
  $AD8E,$01 Move up to the next row.
  $AD8F,$02 Jump to #R$AD8B until all eight rows have been inverted.
  $AD91,$03 Set the pixel position to #N($D0), #N$10.
  $AD94,$03 Call #R$D135.
  $AD97,$03 Call #R$D120.
  $AD9A,$02 Copy the buffer address to #REGhl.
  $AD9C,$03 Set the size to eight rows of four bytes.
  $AD9F,$03 Call #R$CF85.
N $ADA2 End the game if every digit is zero.
  $ADA2,$03 Point #REGhl at #R$5B36.
  $ADA5,$02 Set a counter of four digits.
  $ADA7,$01 Set #REGa to #N$00.
@ $ADA8 label=UpdateLightYears_TestDigit
  $ADA8,$01 Combine the digit with the others.
  $ADA9,$01 Move on to the next digit.
  $ADAA,$02 Jump to #R$ADA8 until all four have been combined.
  $ADAC,$03 Jump to #R$B761 if all of the digits are zero.
  $ADAF,$01 Return.

c $ADB0 Print Counter Digit
@ $ADB0 label=PrintCounterDigit
D $ADB0 Prints one digit of the light years
. counter. The upper four bits of the byte
. hold the digit and the lower three bits are
. an animation step. The glyph is taken from
. the font that number of rows later than the
. start of the glyph, so that the digit
. scrolls up like an odometer as it changes.
R $ADB0 A Digit and animation step
R $ADB0 HL Address in the screen buffer
R $ADB0 O:HL Address of the next character
N $ADB0 Find the glyph and print it.
  $ADB0,$03 Stash the registers on the stack.
  $ADB3,$01 Copy the digit and step to #REGl.
  $ADB4,$08 Divide it by sixteen.
  $ADBC,$02 Set #REGh to #N$00.
  $ADBE,$03 Multiply the digit by eight.
  $ADC1,$02,b$01 Keep bits 0 to 3.
  $ADC3,$03 Call #R$CE06.
  $ADC6,$03 Jump to #R$BBFA.

c $ADC9 Decrement Light Years
@ $ADC9 label=DecrementLightYears
D $ADC9 Subtracts one from #R$5B36 when the
. animation step of its last digit has
. reached zero. A digit which is already
. zero becomes nine, with the next digit up
. borrowed from.
N $ADC9 See #POKE(infinite_light_years,Infinite Light Years).
  $ADC9,$03 Point #REGhl at #R$5B39.
  $ADCC,$02 Set a counter of four digits.
  $ADCE,$01 Fetch the digit and its animation step.
  $ADCF,$02,b$01 Keep bits 0 to 2.
  $ADD1,$01 Return if the digit is still rolling.
@ $ADD2 label=DecrementLightYears_SubtractFromDigit
  $ADD2,$01 Fetch the digit and its animation step.
  $ADD3,$01 Keep it in #REGc.
  $ADD4,$02,b$01 Keep bits 4 to 7.
  $ADD6,$02 Jump to #R$ADDE if the digit is zero.
  $ADD8,$02 Subtract #N$10.
  $ADDA,$02,b$01 Set bits 0 to 2.
  $ADDC,$01 Store the digit and its step.
  $ADDD,$01 Return.
@ $ADDE label=DecrementLightYears_Borrow
  $ADDE,$02 Set the digit to #N$97.
  $ADE0,$01 Store it.
  $ADE1,$01 Move on to the next digit up.
  $ADE2,$02 Jump to #R$ADD2.
  $ADE4,$01 Return.

c $ADE5 Roll Counter Digits
@ $ADE5 label=RollCounterDigits
D $ADE5 Reduces the animation steps of the
. digits of #R$5B36 that are rolling,
. starting with the last digit. It stops at
. the first digit which is not rolling.
N $ADE5 Roll from the last digit upwards.
  $ADE5,$03 Point #REGhl at #R$5B39.
  $ADE8,$02 Set a counter of four digits.
@ $ADEA label=RollCounterDigits_RollDigit
  $ADEA,$01 Fetch the digit and its animation step.
  $ADEB,$02,b$01 Keep bits 0 to 2.
  $ADED,$01 Return if the digit is not rolling.
  $ADEE,$01 Reduce the animation step.
  $ADEF,$01 Move on to the next digit up.
  $ADF0,$02 Jump to #R$ADEA until all four digits have been done.
  $ADF2,$01 Return.

c $ADF3 Set Wipe And Draw Flags For Object
@ $ADF3 label=SetWipeAndDrawFlagsForObject
D $ADF3 Marks the object at #REGiy to be
. wiped and redrawn, preserving #REGix and
. #REGiy.
E $ADF3 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C69D }
. { #PENTAGRAM$BF56 }
. LIST#
R $ADF3 IY The address of the object
N $ADF3 Call #R$BFAB for the object at #REGiy.
  $ADF3,$04 Stash #REGiy and #REGix on the stack.
  $ADF7,$04 Copy #REGiy to #REGix (using the stack).
  $ADFB,$03 Call #R$BFAB.
  $ADFE,$04 Restore #REGix and #REGiy from the stack.
  $AE02,$01 Return.

c $AE03 Find Object
@ $AE03 label=FindObject
D $AE03 Searches the objects of the room
. for one whose sprite number is in a range.
R $AE03 H Number of sprite numbers in the range
R $AE03 L First sprite number in the range
R $AE03 O:IY The address of the object, if one was found
R $AE03 O:F Carry flag set if an object was found
N $AE03 Test each room object.
  $AE03,$04 Point #REGiy at #R$5C08.
  $AE07,$03 Set #REGde to #N($0020,$04,$04).
  $AE0A,$02 Set a counter of #N$34.
@ $AE0C label=FindObject_TestObject
  $AE0C,$03 Fetch the sprite number.
  $AE0F,$01 Subtract the first sprite number in the range.
  $AE10,$01 Compare it with the number of sprite numbers.
  $AE11,$01 Return if the object is in the range.
  $AE12,$02 Move on to the next object.
  $AE14,$02 Jump to #R$AE0C until all of the objects have been tested.
  $AE16,$01 Return.

c $AE17 Handle Valve Ghost
@ $AE17 label=HandleValveGhost
D $AE17 The handler for the ghost of a
. valve (objects #N$68 to #N$6B). It hovers
. over the socket which comes before it in
. the table of objects, and is created by
. #R$AE68. It retires itself if there are
. special objects in the room. It stays for a
. couple of frames in #REGix+#N($10), then
. changes into its sparkle form (see
. #R$AE33).
R $AE17 IX The address of the object
N $AE17 Hover over the socket, then become a sparkle.
  $AE17,$03 Call #R$BF60.
  $AE1A,$03 Call #R$AE81.
  $AE1D,$03 Jump to #R$B3BB if there are special objects in the room.
  $AE20,$03 Fetch the height of the socket.
  $AE23,$02 Add #N$0D.
  $AE25,$03 Set the height of the ghost.
  $AE28,$04 Return if there are frames left.
  $AE2C,$04 Set bit 2 of the sprite number.
  $AE30,$03 Jump to #R$BFAB.

c $AE33 Handle Valve Ghost Sparkle
@ $AE33 label=HandleValveGhostSparkle
D $AE33 The handler for the sparkles shown
. between appearances of the valve ghost
. (objects #N$6C to #N$6F). They hover over
. the socket in the same way as the ghost
. (see #R$AE17). The sparkle steps through
. the four shapes, and when it matches the
. socket it changes back into the ghost.
R $AE33 IX The address of the object
N $AE33 Hover over the socket and step the shape.
  $AE33,$03 Call #R$BF60.
  $AE36,$03 Call #R$AE81.
  $AE39,$03 Jump to #R$B3BB if there are special objects in the room.
  $AE3C,$03 Fetch the height of the socket.
  $AE3F,$02 Add #N$0D.
  $AE41,$03 Set the height of the sparkle.
  $AE44,$03 Call #R$B18C.
  $AE47,$02,b$01 Keep bits 0 and 1.
  $AE49,$01 Keep it in #REGc.
  $AE4A,$03 Fetch the sprite number of the socket.
  $AE4D,$02,b$01 Keep bits 0 and 1.
  $AE4F,$03 Jump to #R$AE5A if the shapes are different.
  $AE52,$04 Reset bit 2 of the sprite number.
  $AE56,$04 Write #N$02 to the frame count.
@ $AE5A label=HandleValveGhostSparkle_Redraw
  $AE5A,$03 Jump to #R$BFAB.

c $AE5D Handle Placed Valve
@ $AE5D label=HandlePlacedValve
D $AE5D The handler for a valve which has
. been placed on a socket (objects #N$64 to
. #N$67). It stays where it is.
R $AE5D IX The address of the object
N $AE5D Stop the valve moving.
  $AE5D,$03 Call #R$BF60.
  $AE60,$01 Set #REGa to #N$00.
  $AE61,$03 Stop the speed along the x axis.
  $AE64,$03 Stop the speed along the y axis.
  $AE67,$01 Return.

c $AE68 Handle Socket
@ $AE68 label=HandleSocket
D $AE68 The handler for the sockets
. (objects #N$70 to #N$73). When there are no
. special objects in the room and the next
. object slot is free, it creates the
. sparkle form of the ghost of the valve
. which fits the socket (see #R$AE33).
R $AE68 IX The address of the object
N $AE68 Create a sparkle in the next object slot.
  $AE68,$03 Call #R$BF4C.
  $AE6B,$04 Return if there are special objects in the room.
  $AE6F,$03 Fetch the sprite number of the next object.
  $AE72,$02 Return if the next object slot is in use.
  $AE74,$03 Fetch the sprite number of the socket.
  $AE77,$02,b$01 Keep bits 0 and 1.
  $AE79,$02,b$01 Make it a sparkle of that shape.
  $AE7B,$03 Set the sprite number of the next object.
  $AE7E,$03 Jump to #R$AE8A.

c $AE81 Test Valves In Play
@ $AE81 label=TestValvesInPlay
D $AE81 Tests whether either of the two
. slots for special objects is in use. They
. hold the valves and extra lives which are
. in the room.
R $AE81 O:F Zero flag set if both slots are empty
N $AE81 Combine the two special object slots.
  $AE81,$03 Fetch #R$5BC8.
  $AE84,$01 Keep it in #REGc.
  $AE85,$03 Fetch #R$5BC8(#N$5BE8).
  $AE88,$01 Combine it with the first.
  $AE89,$01 Return.

c $AE8A Calculate Pixel Position Of Other Object
@ $AE8A label=CalculatePixelPositionOfOtherObject
D $AE8A Works out the pixel position of the
. object at #REGiy by calling #R$CFD2 with
. #REGix pointing at it. Neither #REGix nor
. #REGiy is changed.
R $AE8A IY The address of the object
N $AE8A Call #R$CFD2 for the object at #REGiy.
  $AE8A,$02 Stash #REGix on the stack.
  $AE8C,$04 Copy #REGiy to #REGix (using the stack).
  $AE90,$03 Call #R$CFD2.
  $AE93,$02 Restore #REGix from the stack.
  $AE95,$01 Return.

c $AE96 Handle Cryonaut
@ $AE96 label=HandleCryonaut
D $AE96 The handler for a cryonaut looking
. out of a chamber (object #N$4A). It only
. sets the pixel offsets used to draw it.
R $AE96 IX The address of the object
N $AE96 Set the pixel offsets.
  $AE96,$03 Jump to #R$BF6A.

c $AE99 Place Special Objects In Room
@ $AE99 label=PlaceSpecialObjectsInRoom
D $AE99 Copies each of the special objects
. at #R$76E3 which is in the room of the
. object at #REGix into the slots from
. #R$5BC8, then clears the slots which are
. left over (up to #R$5C08). The address of
. the entry is kept in the new object so that
. #R$AF05 can copy its position back. Each
. special object is given a width and depth
. of #N($05), a height of #N$0C and flags of
. #N$14.
E $AE99 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C525 }
. LIST#
R $AE99 IX The address of the player
N $AE99 Copy each special object that is in this room.
  $AE99,$03 Point #REGde at #R$5BC8.
  $AE9C,$01 Switch to the shadow registers.
  $AE9D,$04 Point #REGiy at #R$76E3.
  $AEA1,$03 Fetch the room number into the high byte of #REGbc'.
@ $AEA4 label=PlaceSpecialObjectsInRoom_TestEntry
  $AEA4,$03 Fetch the special object number.
  $AEA7,$03 Jump to #R$AEE6 if the entry is not in use.
  $AEAA,$03 Fetch the room of the special object.
  $AEAD,$03 Jump to #R$AEE6 if it is not this room.
  $AEB0,$02 Stash the entry address on the stack.
  $AEB2,$01 Switch back to the main registers.
  $AEB3,$01 Restore the entry address from the stack.
  $AEB4,$01 Stash it on the stack again.
  $AEB5,$04 Copy the object number to the slot.
  $AEB9,$04 Skip to the current position.
  $AEBD,$03 Set #REGbc to #N($0003,$04,$04).
  $AEC0,$02 Copy the x, y and z coordinates to the slot.
  $AEC2,$01 Point #REGhl at the slot and #REGde at the room.
  $AEC3,$03 Write #N$05 as the width.
  $AEC6,$03 Write #N$05 as the depth.
  $AEC9,$03 Write #N$0C as the height.
  $AECC,$02 Write #N$14 as the flags.
  $AECE,$01 Move on to the room.
  $AECF,$01 Point #REGhl at the entry and #REGde at the slot.
  $AED0,$04 Copy the room to the slot.
  $AED4,$02 Set a counter of seven.
  $AED6,$03 Call #R$CE1C.
  $AED9,$01 Restore the entry address from the stack.
  $AEDA,$03 Store the low byte of the address in the slot.
  $AEDD,$03 Store the high byte of the address in the slot.
  $AEE0,$02 Set a counter of #N$0E.
  $AEE2,$03 Call #R$CE1C.
  $AEE5,$01 Switch to the shadow registers.
@ $AEE6 label=PlaceSpecialObjectsInRoom_NextEntry
  $AEE6,$03 Set #REGde to #N($0009,$04,$04).
  $AEE9,$02 Move on to the next entry.
  $AEEB,$03 Copy #REGiy to #REGhl (using the stack).
  $AEEE,$03 Point #REGde at #R$7827.
  $AEF1,$03 Subtract #R$7827 from #REGhl.
  $AEF4,$02 Jump to #R$AEA4 if there are more entries.
  $AEF6,$01 Switch back to the main registers.
N $AEF7 Clear any slots that were not filled.
@ $AEF7 label=PlaceSpecialObjectsInRoom_ClearSlots
  $AEF7,$03 Point #REGhl at #R$5C08.
  $AEFA,$03 Subtract the next slot from #REGhl.
  $AEFD,$01 Return if all of the slots have been done.
  $AEFE,$02 Set a counter of #N$20.
  $AF00,$03 Call #R$CE1C.
  $AF03,$02 Jump to #R$AEF7.

c $AF05 Update Special Objects
@ $AF05 label=UpdateSpecialObjects
D $AF05 Copies the number, position and
. room of each valve in #R$5BC8 back to its
. entry in #R$76E3, so that they are
. remembered when the player leaves the room.
. Other special objects, such as extra lives,
. are not copied.
E $AF05 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C591 }
. LIST#
N $AF05 Copy each valve back to the table.
  $AF05,$04 Point #REGiy at #R$5BC8.
@ $AF09 label=UpdateSpecialObjects_TestSlot
  $AF09,$03 Fetch the object number.
  $AF0C,$02 Subtract #N$60.
  $AF0E,$04 Jump to #R$AF2E unless the object is a valve.
  $AF12,$03 Fetch the low byte of the entry address.
  $AF15,$03 Fetch the high byte of the entry address.
  $AF18,$03 Fetch the object number.
  $AF1B,$01 Store it in the entry.
  $AF1C,$05 Move on to the current x position.
  $AF21,$03 Copy #REGiy to #REGhl (using the stack).
  $AF24,$01 Move on to the x position of the object.
  $AF25,$03 Set #REGbc to #N($0003,$04,$04).
  $AF28,$02 Copy the x, y and z coordinates to the entry.
  $AF2A,$03 Fetch the room.
  $AF2D,$01 Store it in the entry.
@ $AF2E label=UpdateSpecialObjects_NextSlot
  $AF2E,$03 Set #REGbc to #N($0020,$04,$04).
  $AF31,$02 Move on to the next slot.
  $AF33,$03 Copy #REGiy to #REGhl (using the stack).
  $AF36,$03 Point #REGbc at #R$5C08.
  $AF39,$03 Subtract #R$5C08 from #REGhl.
  $AF3C,$02 Jump to #R$AF09 if there are more slots.
  $AF3E,$01 Return.

c $AF3F Initialise Special Objects
@ $AF3F label=InitialiseSpecialObjects
D $AF3F Chooses the objects in #R$76E3 at
. the start of a game. Each is given a random
. shape of valve (#N$60 to #N$63), except
. that every sixteenth entry, counting from a
. number taken from the random number seed,
. is an extra life (object #N$0C). The
. starting position of each entry is copied
. to the current position.
E $AF3F View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C47E }
. LIST#
N $AF3F Stir the seeds and fill the table.
  $AF3F,$03 Point #REGhl at #R$76E3.
  $AF42,$03 Fetch #R$5B00.
  $AF45,$01 Keep it in #REGe.
  $AF46,$02 Fetch the refresh register.
  $AF48,$01 Add the seed to it.
  $AF49,$01 Keep the result in #REGe.
  $AF4A,$03 Fetch #R$5B05.
  $AF4D,$01 Keep it in #REGd.
@ $AF4E label=InitialiseSpecialObjects_NextEntry
  $AF4E,$01 Count down.
  $AF4F,$01 Copy the counter to #REGa.
  $AF50,$02,b$01 Keep bits 0 to 3.
  $AF52,$02 Jump to #R$AF75 if every sixteenth entry has been reached.
  $AF54,$01 Fetch the random number.
  $AF55,$02,b$01 Keep bits 0 and 1.
  $AF57,$02,b$01 Make it a valve.
@ $AF59 label=InitialiseSpecialObjects_StoreNumber
  $AF59,$01 Store the object number.
  $AF5A,$01 Move on to the starting position.
  $AF5B,$01 Change the random number.
  $AF5C,$01 Stash the counter and the random number on the stack.
  $AF5D,$01 Swap the entry pointer into #REGde.
  $AF5E,$03 Set #REGhl to #N($0004,$04,$04).
  $AF61,$01 Add it to the starting position.
  $AF62,$01 Swap the pointers back.
  $AF63,$03 Set #REGbc to #N($0004,$04,$04).
  $AF66,$02 Copy the starting position and room.
  $AF68,$01 Point #REGhl at the next entry.
  $AF69,$01 Stash the next entry on the stack.
  $AF6A,$03 Point #REGbc at #R$7827.
  $AF6D,$03 Subtract #R$7827 from #REGhl.
  $AF70,$01 Restore the next entry from the stack.
  $AF71,$01 Restore the counter and the random number from the stack.
  $AF72,$02 Jump to #R$AF4E if there are more entries.
  $AF74,$01 Return.
@ $AF75 label=InitialiseSpecialObjects_ExtraLife
  $AF75,$02 Set the object number to #N$0C.
  $AF77,$02 Jump to #R$AF59.

c $AF79 Handle Valve
@ $AF79 label=HandleValve
D $AF79 The handler for a valve lying about
. in a room (objects #N$60 to #N$63). If the
. room has a socket of the same shape the
. valve moves towards it one step at a time
. along the x and y axes, and is pulled down
. by gravity. When it sits on the socket it
. is placed: the object number goes up by
. four (#N$64 to #N$67), the screen colours
. cycle sixteen times with a sparkle, the
. chamber ink is set to white, and one is
. added to #R$5B40. If that makes #N$24 the
. game is completed.
.
. A valve which is not on its way to a
. socket is just moved with gravity, and
. stopped and redrawn if it has been dropped.
R $AF79 IX The address of the object
N $AF79 Look for a matching socket.
  $AF79,$03 Call #R$BF60.
  $AF7C,$03 Set #REGhl to #N$0470.
  $AF7F,$03 Call #R$AE03.
  $AF82,$02 Jump to #R$AFD0 if there is no socket.
  $AF84,$03 Fetch the sprite number of the socket.
  $AF87,$02,b$01 Keep bits 0 and 1.
  $AF89,$01 Keep it in #REGc.
  $AF8A,$03 Fetch the object number of the valve.
  $AF8D,$02,b$01 Keep bits 0 and 1.
  $AF8F,$03 Jump to #R$AFD0 if the shapes are different.
N $AF92 Set the speed towards the socket.
  $AF92,$06 Subtract the socket x from the valve x.
  $AF98,$02 Jump to #R$AFA1 if they are the same.
  $AF9A,$02 Set the speed to #N$01.
  $AF9C,$03 Jump to #R$AFA1 if the valve is west of the socket.
  $AF9F,$02 Make the speed negative.
@ $AFA1 label=HandleValve_SetSpeedX
  $AFA1,$03 Set the speed along the x axis.
  $AFA4,$06 Subtract the socket y from the valve y.
  $AFAA,$02 Jump to #R$AFB3 if they are the same.
  $AFAC,$02 Set the speed to #N$01.
  $AFAE,$03 Jump to #R$AFB3 if the valve is south of the socket.
  $AFB1,$02 Make the speed negative.
@ $AFB3 label=HandleValve_SetSpeedY
  $AFB3,$03 Set the speed along the y axis.
N $AFB6 Place the valve if it is on the socket.
  $AFB6,$06 Compare the x positions.
  $AFBC,$02 Jump to #R$AFD0 if they differ.
  $AFBE,$06 Compare the y positions.
  $AFC4,$02 Jump to #R$AFD0 if they differ.
  $AFC6,$03 Fetch the height of the socket.
  $AFC9,$02 Add #N$0C.
  $AFCB,$03 Compare it with the height of the valve.
  $AFCE,$02 Jump to #R$AFE7 if the valve is on the socket.
N $AFD0 Move the valve if it is not placed yet.
@ $AFD0 label=HandleValve_Fall
  $AFD0,$03 Call #R$BFB6.
  $AFD3,$06 Jump to #R$AFDD if the valve has been dropped.
  $AFD9,$04 Return if the valve is not moving.
@ $AFDD label=HandleValve_Dropped
  $AFDD,$04 Reset bit 0 of the state.
  $AFE1,$03 Call #R$C2EE.
  $AFE4,$03 Jump to #R$B3BF.
N $AFE7 Place the valve on the socket.
@ $AFE7 label=HandleValve_Arrived
  $AFE7,$03 Fetch the object number of the valve.
  $AFEA,$03 Combine it with that of the socket.
  $AFED,$02,b$01 Keep bits 0 and 1.
  $AFEF,$02 Jump to #R$AFF8 if the shapes are the same.
  $AFF1,$04 Write #N$40 as the sprite number.
  $AFF5,$03 Jump to #R$BFAB.
@ $AFF8 label=HandleValve_PlaceValve
  $AFF8,$03 Fetch the object number of the valve.
  $AFFB,$02,b$01 Set bit 2.
  $AFFD,$03 Store the object number.
  $B000,$03 Call #R$B3BF.
  $B003,$02 Set a counter of #N$10.
N $B005 Cycle the screen colours.
@ $B005 label=HandleValve_CycleColours
  $B005,$03 Point #REGhl at #N$5800 (in the attribute buffer).
  $B008,$03 Set #REGbc to #N$0300.
@ $B00B label=HandleValve_CycleAttribute
  $B00B,$01 Fetch an attribute.
  $B00C,$02,b$01 Keep bits 3 to 7.
  $B00E,$01 Keep it in #REGe.
  $B00F,$02 Fetch the attribute and add one.
  $B011,$02,b$01 Keep bits 0 to 2.
  $B013,$01 Combine it with the rest of the attribute.
  $B014,$01 Store the new attribute.
  $B015,$01 Move on to the next attribute.
  $B016,$01 Count down the attributes.
  $B017,$04 Jump to #R$B00B until all of them have been changed.
  $B01B,$03 Call #R$B5EE.
  $B01E,$03 Set #REGbc to #N$0200.
@ $B021 label=HandleValve_Delay
  $B021,$05 Jump to #R$B021 until the delay is done.
  $B026,$03 Jump to #R$B005 until all of the colours have been cycled.
  $B029,$03 Fetch #R$5B34.
  $B02C,$01 Fetch the colour of the room.
  $B02D,$02,b$01 Set bits 0 to 2.
  $B02F,$01 Store the colour of the chamber.
  $B030,$02,b$01 Keep bits 0 to 2.
  $B032,$03 Set #R$5B0D.
  $B035,$03 Call #R$A749.
  $B038,$03 Point #REGhl at #R$5B40.
  $B03B,$05 Add one to #R$5B40.
  $B040,$04 Jump to #R$B04C unless it is #N$24.
  $B044,$05 Write #N$01 to #R$5B23.
  $B049,$03 Jump to #R$B761.
@ $B04C label=HandleValve_Finish
  $B04C,$03 Call #R$A7A3.
  $B04F,$03 Set the pixel position to #N($20), #N$18.
  $B052,$03 Jump to #R$BF2F.

c $B055 Handle Mouse Second Part
@ $B055 label=HandleMouseSecondPart
D $B055 The handler for the second part of
. a robot mouse (object #N$0B). It takes its
. position from the first part, which comes
. before it in the table of objects, and sits
. #N$0C lower. When the first part is moving
. it makes a noise and is redrawn.
R $B055 IX The address of the object
N $B055 Follow the first part and redraw if it moves.
  $B055,$03 Call #R$BF5B.
  $B058,$03 Call #R$B1E5.
  $B05B,$0A Return if the first part is not moving.
  $B065,$03 Call #R$B6C0.
  $B068,$03 Jump to #R$BFAB.

c $B06B Handle Circuit Mouse
@ $B06B label=HandleCircuitMouse
D $B06B The handler for the robot mice
. (objects #N$5E and #N$5F) which run in
. circuits. When a mouse is blocked, or is
. not moving, it makes a noise and turns a
. quarter turn one way or the other, chosen
. at random. Its speed is then set from the
. way it faces, and doubled.
R $B06B IX The address of the object
N $B06B Move, or turn if the mouse is blocked.
  $B06B,$03 Call #R$BF5B.
  $B06E,$03 Call #R$B1FA.
  $B071,$08 Jump to #R$B08A if the mouse is not moving.
  $B079,$03 Call #R$BFB6.
  $B07C,$07 Call #R$B63C if it is rising or falling.
  $B083,$03 Fetch the collision flags.
  $B086,$02,b$01 Keep bits 0 and 1.
  $B088,$02 Jump to #R$B0A2 if the mouse has not been blocked.
@ $B08A label=HandleCircuitMouse_Turn
  $B08A,$03 Call #R$B619.
  $B08D,$03 Fetch #R$5B05.
  $B090,$02,b$01 Keep bit 0.
  $B092,$02 Jump to #R$B0A8 if it is zero.
  $B094,$03 Call #R$B0DD.
@ $B097 label=HandleCircuitMouse_SetSpeed
  $B097,$03 Call #R$B0E7.
  $B09A,$04 Double the speed along the x axis.
  $B09E,$04 Double the speed along the y axis.
@ $B0A2 label=HandleCircuitMouse_Finish
  $B0A2,$03 Call #R$B20B.
  $B0A5,$03 Jump to #R$B2B0.
@ $B0A8 label=HandleCircuitMouse_TurnOneWay
  $B0A8,$03 Call #R$B0AD.
  $B0AB,$02 Jump to #R$B097.

c $B0AD Turn Mouse One Way
@ $B0AD label=TurnMouseOneWay
D $B0AD Turns a robot mouse a quarter turn.
. The way it faces is held in bit 0 of its
. sprite number and bit 6 of its flags. They
. go west, south, east, north: (bit 0, bit 6)
. = (#N($00), #N($00)), (#N($01), #N($01)),
. (#N($01), #N$00) and (#N($00), #N$01).
R $B0AD IX The address of the object
N $B0AD The mouse is facing west or north.
  $B0AD,$06 Jump to #R$B0C2 if bit 0 of the sprite number is set.
  $B0B3,$06 Jump to #R$B0CE if the sprite is flipped.
  $B0B9,$04 Set bit 0 of the sprite number.
@ $B0BD label=TurnMouseOneWay_Flip
  $B0BD,$04 Set bit 6 of the flags.
  $B0C1,$01 Return.
N $B0C2 The mouse is facing south or east.
@ $B0C2 label=TurnMouseOneWay_BitSet
  $B0C2,$06 Jump to #R$B0D7 if the sprite is flipped.
  $B0C8,$04 Reset bit 0 of the sprite number.
  $B0CC,$02 Jump to #R$B0BD.
N $B0CE The mouse is facing north.
@ $B0CE label=TurnMouseOneWay_FlippedBitClear
  $B0CE,$04 Reset bit 0 of the sprite number.
@ $B0D2 label=TurnMouseOneWay_Unflip
  $B0D2,$04 Reset bit 6 of the flags.
  $B0D6,$01 Return.
N $B0D7 The mouse is facing south.
@ $B0D7 label=TurnMouseOneWay_FlippedBitSet
  $B0D7,$04 Set bit 0 of the sprite number.
  $B0DB,$02 Jump to #R$B0D2.

c $B0DD Turn Mouse Other Way
@ $B0DD label=TurnMouseOtherWay
D $B0DD Turns a robot mouse a quarter turn
. the other way round the cycle used by
. #R$B0AD.
R $B0DD IX The address of the object
N $B0DD Flip bit 0, then turn one way.
  $B0DD,$03 Fetch the sprite number.
  $B0E0,$02,b$01 Flip bit 0.
  $B0E2,$03 Store the sprite number.
  $B0E5,$02 Jump to #R$B0AD.

c $B0E7 Set Mouse Speed
@ $B0E7 label=SetMouseSpeed
D $B0E7 Sets the speed of a robot mouse
. along the x and y axes from the way it
. faces, using the table at #R$B108.
R $B0E7 IX The address of the object
N $B0E7 Build a direction index from the facing bits.
  $B0E7,$03 Fetch the flags.
  $B0EA,$03 Move bit 6 to bit 1.
  $B0ED,$02,b$01 Keep bit 1.
  $B0EF,$01 Keep it in #REGb.
  $B0F0,$03 Fetch the sprite number.
  $B0F3,$02,b$01 Keep bit 0.
  $B0F5,$01 Combine it with the flip flag.
  $B0F6,$02 Double it.
  $B0F8,$03 Point #REGhl at #R$B108.
  $B0FB,$03 Call #R$CE06.
  $B0FE,$02 Fetch the speed along the x axis.
  $B100,$03 Set the speed along the x axis.
  $B103,$01 Fetch the speed along the y axis.
  $B104,$03 Set the speed along the y axis.
  $B107,$01 Return.

b $B108 Mouse Speeds
@ $B108 label=MouseSpeeds
D $B108 The speeds along the x and y axes
. given to a robot mouse for each of the
. directions it can face.
B $B108,$02,$01 Facing west: dX=#N($FF), dY=#N$00
B $B10A,$02,$01 Facing east: dX=#N($01), dY=#N$00
B $B10C,$02,$01 Facing north: dX=#N($00), dY=#N$01
B $B10E,$02,$01 Facing south: dX=#N($00), dY=#N$FF

c $B110 Handle Bouncing Mouse
@ $B110 label=HandleBouncingMouse
D $B110 The handler for the robot mice
. (objects #N$56 and #N$57) which run to and
. fro along one axis. A mouse which is not
. moving is given a speed from the way it
. faces, doubled. When it is blocked it
. reverses its speed, makes a noise and turns
. to face the other way.
R $B110 IX The address of the object
N $B110 Move along the x axis, and reverse if blocked.
  $B110,$03 Call #R$BF5B.
  $B113,$03 Call #R$B1FA.
@ $B116 label=HandleBouncingMouse_Move
  $B116,$03 Fetch the speed along the x axis.
  $B119,$03 Jump to #R$B13C if it is zero.
  $B11C,$03 Remember the speed.
  $B11F,$03 Call #R$BFB6.
  $B122,$06 Jump to #R$B136 if the mouse has not been blocked along the x axis.
  $B128,$03 Fetch the speed which was remembered.
  $B12B,$02 Make the speed negative.
  $B12D,$03 Set the speed along the x axis.
@ $B130 label=HandleBouncingMouse_Bounce
  $B130,$03 Call #R$B619.
  $B133,$03 Call #R$B1AE.
@ $B136 label=HandleBouncingMouse_Finish
  $B136,$03 Call #R$B20B.
  $B139,$03 Jump to #R$B2B0.
N $B13C Move along the y axis, and reverse if blocked.
@ $B13C label=HandleBouncingMouse_MoveAlongY
  $B13C,$03 Fetch the speed along the y axis.
  $B13F,$03 Jump to #R$B158 if it is zero.
  $B142,$03 Remember the speed.
  $B145,$03 Call #R$BFB6.
  $B148,$06 Jump to #R$B136 if the mouse has not been blocked along the y axis.
  $B14E,$03 Fetch the speed which was remembered.
  $B151,$02 Make the speed negative.
  $B153,$03 Set the speed along the y axis.
  $B156,$02 Jump to #R$B130.
N $B158 The mouse is not moving.
@ $B158 label=HandleBouncingMouse_StartMoving
  $B158,$03 Call #R$B0E7.
  $B15B,$04 Double the speed along the x axis.
  $B15F,$04 Double the speed along the y axis.
  $B163,$02 Jump to #R$B116.

c $B165 Set Speed Towards Player
@ $B165 label=SetSpeedTowardsPlayer
D $B165 Sets the speed of an object along
. the x and y axes so that it heads towards
. the player.
E $B165 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B965 }
. LIST#
R $B165 B Speed along the y axis
R $B165 C Speed along the x axis
R $B165 IX The address of the object
N $B165 Head towards the player along each axis.
  $B165,$03 Point #REGhl at #R$5B88(#N$5B89).
  $B168,$03 Fetch the x position of the object.
  $B16B,$01 Subtract the player's x position.
  $B16C,$01 Move on to the y position.
  $B16D,$01 Fetch the speed along the x axis.
  $B16E,$03 Jump to #R$B173 if the object is west of the player.
  $B171,$02 Make the speed negative.
@ $B173 label=SetSpeedTowardsPlayer_SetX
  $B173,$03 Set the speed along the x axis.
  $B176,$03 Fetch the y position of the object.
  $B179,$01 Subtract the player's y position.
  $B17A,$01 Move on.
  $B17B,$01 Fetch the speed along the y axis.
  $B17C,$03 Jump to #R$B181 if the object is south of the player.
  $B17F,$02 Make the speed negative.
@ $B181 label=SetSpeedTowardsPlayer_SetY
  $B181,$03 Set the speed along the y axis.
  $B184,$01 Return.

c $B185 Toggle Sprite Number
@ $B185 label=ToggleSpriteNumber
D $B185 Flips the lowest bit of the sprite
. number of the object, to change the way it
. is facing or its animation frame.
R $B185 IX The address of the object
N $B185 Flip bit 0 and store the sprite number.
  $B185,$03 Fetch the sprite number.
  $B188,$02,b$01 Flip bit 0.
  $B18A,$02 Jump to #R$B198.

c $B18C Next Sprite Number
@ $B18C label=NextSpriteNumber
D $B18C Steps on to the next of the four
. animation frames of the object, by adding
. one to the lowest two bits of its sprite
. number (wrapping from three to zero).
E $B18C View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CCAE }
. { #KNIGHTLORE$B98C }
. { #NIGHTSHADE$CEF8 }
. LIST#
R $B18C IX The address of the object
R $B18C O:A The new sprite number
N $B18C Keep the upper bits and step the frame.
  $B18C,$03 Fetch the sprite number.
  $B18F,$01 Keep it in #REGc.
  $B190,$02,b$01 Keep bits 2 to 7.
  $B192,$01 Keep them in #REGb.
  $B193,$02 Fetch it again and add one.
  $B195,$02,b$01 Keep bits 0 and 1.
  $B197,$01 Combine them with the upper bits.
@ $B198 label=NextSpriteNumber_StoreSpriteNumber
  $B198,$03 Store the sprite number.
  $B19B,$01 Return.

c $B19C Handle Homing Sparkle
@ $B19C label=HandleHomingSparkle
D $B19C The handler for the sparkles which
. fly towards the player (objects #N$4C to
. #N$4F). They move at a speed of four along
. each axis and step through their four
. animation frames.
R $B19C IX The address of the object
N $B19C Head towards the player and redraw.
  $B19C,$03 Call #R$BF6A.
  $B19F,$03 Set the speed along each axis to #N$04.
  $B1A2,$03 Call #R$B165.
  $B1A5,$03 Call #R$BFB6.
  $B1A8,$03 Call #R$B18C.
  $B1AB,$03 Jump to #R$B3BF.

c $B1AE Face Direction Of Movement
@ $B1AE label=FaceDirectionOfMovement
D $B1AE Sets the way a robot mouse faces to
. match the direction in which it is moving,
. if it is moving along one axis. The way it
. faces is held in bit 0 of its sprite number
. and bit 6 of its flags (see #R$B0AD).
E $B1AE View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B76C }
. LIST#
R $B1AE IX The address of the object
N $B1AE Face along the axis with the larger speed.
  $B1AE,$07 Return if the mouse is not moving.
  $B1B5,$03 Fetch the speed along the x axis.
  $B1B8,$05 Jump to #R$B1D0 if the mouse is moving along the y axis.
  $B1BD,$04 Jump to #R$B1CA if the mouse is moving west.
  $B1C1,$04 Set bit 0 of the sprite number.
@ $B1C5 label=FaceDirectionOfMovement_Unflip
  $B1C5,$04 Reset bit 6 of the flags.
  $B1C9,$01 Return.
N $B1CA The mouse is moving west.
@ $B1CA label=FaceDirectionOfMovement_West
  $B1CA,$04 Reset bit 0 of the sprite number.
  $B1CE,$02 Jump to #R$B1C5.
N $B1D0 The mouse is moving along the y axis.
@ $B1D0 label=FaceDirectionOfMovement_MovingAlongY
  $B1D0,$06 Jump to #R$B1DF if the mouse is moving north.
  $B1D6,$04 Set bit 0 of the sprite number.
@ $B1DA label=FaceDirectionOfMovement_Flip
  $B1DA,$04 Set bit 6 of the flags.
  $B1DE,$01 Return.
N $B1DF The mouse is moving north.
@ $B1DF label=FaceDirectionOfMovement_North
  $B1DF,$04 Reset bit 0 of the sprite number.
  $B1E3,$02 Jump to #R$B1DA.

c $B1E5 Copy Previous Position
@ $B1E5 label=CopyPreviousPosition
D $B1E5 Copies the position of the object
. before this one in the table to this
. object, with the height lowered by #N$0C.
R $B1E5 IX The address of the object
N $B1E5 Copy x, y and height from the previous object.
  $B1E5,$03 Fetch the x position of the previous object.
  $B1E8,$03 Set the x position of this object.
  $B1EB,$03 Fetch the y position of the previous object.
  $B1EE,$03 Set the y position of this object.
  $B1F1,$03 Fetch the height of the previous object.
  $B1F4,$02 Subtract #N$0C.
  $B1F6,$03 Set the height of this object.
  $B1F9,$01 Return.

c $B1FA Extend Object Downwards
@ $B1FA label=ExtendObjectDownwards
D $B1FA Lowers the object by #N$0C and
. doubles its height, so that it covers both
. parts of a robot mouse. It also sets bit 1
. of the flags of the next object, so that
. collision tests ignore it. #R$B20B undoes
. this.
R $B1FA IX The address of the object
N $B1FA Cover both parts of the mouse.
  $B1FA,$03 Fetch the height of the object.
  $B1FD,$02 Subtract #N$0C.
  $B1FF,$03 Set the height of the object.
  $B202,$04 Double the height of the object.
  $B206,$04 Set bit 1 of the next object's flags.
  $B20A,$01 Return.

c $B20B Restore Object Height
@ $B20B label=RestoreObjectHeight
D $B20B Undoes #R$B1FA by raising the
. object by #N$0C and halving its height.
R $B20B IX The address of the object
N $B20B Restore the height and the next object's flags.
  $B20B,$03 Fetch the height of the object.
  $B20E,$02 Add #N$0C.
  $B210,$03 Set the height of the object.
  $B213,$04 Halve the height of the object.
  $B217,$04 Reset bit 1 of the next object's flags.
  $B21B,$01 Return.

c $B21C Handle Block Moving North South
@ $B21C label=HandleBlockMovingNorthSouth
D $B21C The handler for a block which
. moves north and south (object #N$43). It
. chooses the y axis and joins #R$B224.
R $B21C IX The address of the object
N $B21C Choose the y axis.
  $B21C,$03 Call #R$B64F.
  $B21F,$03 Set #REGhl to #N$020A.
  $B222,$02 Jump to #R$B22A.

c $B224 Handle Block Moving East West
@ $B224 label=HandleBlockMovingEastWest
D $B224 The handler for a block which
. moves east and west (object #N$42), and the
. code shared with #R$B21C. The block follows
. a target that swings over #N$20 frames from
. #R$5B02. Neighbouring blocks are out of
. step because the low byte of the object
. address is added in. It moves by #N$01 each
. frame, with gravity cancelled out.
.
. The axis is chosen by changing the
. operands of #R$B249 and #R$B25A.
E $B224 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B6B9 }
. LIST#
R $B224 IX The address of the object
N $B224 Choose the x axis.
  $B224,$03 Call #R$B64A.
  $B227,$03 Set #REGhl to #N$0109.
N $B22A Change the later instructions to use the chosen axis.
@ $B22A label=HandleBlockMoving
  $B22A,$04 Write #REGh to #R$B249(#N$B24B).
  $B22E,$04 Write #REGl to #R$B25A(#N$B25C).
  $B232,$03 Call #R$BF3D.
N $B235 Work out a target from #N$00 to #N$0F.
  $B235,$03 Copy #REGix to #REGbc (using the stack).
  $B238,$02 Fetch the low byte and move bit 5 to bit 4.
  $B23A,$02,b$01 Keep bit 4.
  $B23C,$01 Keep it in #REGc.
  $B23D,$03 Fetch #R$5B02.
  $B240,$01 Add the difference between neighbouring objects.
  $B241,$04 Jump to #R$B246 if bit 4 is clear.
  $B245,$01 Invert it.
@ $B246 label=HandleBlockMoving_Target
  $B246,$02,b$01 Keep bits 0 to 3.
  $B248,$01 Keep the target in #REGc.
N $B249 Set a speed of #N$01 towards the target.
@ $B249 label=HandleBlockMoving_Compare
  $B249,$03 Fetch the position along the chosen axis.
  $B24C,$02 Add #N$08.
  $B24E,$02,b$01 Keep bits 0 to 3.
  $B250,$04 Jump to #R$BFAB if the block is at the target.
  $B254,$02 Set the speed to #N$01.
  $B256,$02 Jump to #R$B25A if the block is below the target.
  $B258,$02 Make the speed negative.
N $B25A Set that speed, cancel gravity, and move the block.
@ $B25A label=HandleBlockMoving_SetSpeed
  $B25A,$03 Set the speed along the chosen axis.
  $B25D,$04 Write #N$01 as the speed along the z axis.
  $B261,$03 Call #R$BFB6.
  $B264,$03 Jump to #R$BFAB.

c $B267 Handle Conveyor North
@ $B267 label=HandleConveyorNorth
D $B267 The handler for a conveyor which
. carries objects north (object #N$44). The
. conveyor does not move but is given a
. speed of #N$02 along the y axis, which is
. used for the objects which stand on it.
. The other conveyors set a different speed
. and continue from #R$B26B.
R $B267 IX The address of the object
N $B267 Set the northward speed.
  $B267,$04 Write #N$02 as the speed along the y axis.
N $B26B Draw the conveyor and stop it falling.
@ $B26B label=HandleConveyor
  $B26B,$03 Call #R$BF3D.
  $B26E,$03 Fetch the speed along the z axis.
  $B271,$04 Call #R$B6BB if something has landed on it.
  $B275,$04 Write #N$00 as the speed along the z axis.
  $B279,$01 Return.

c $B27A Handle Conveyor East
@ $B27A label=HandleConveyorEast
D $B27A The handler for a conveyor which
. carries objects east (object #N$45).
R $B27A IX The address of the object
N $B27A Set the eastward speed.
  $B27A,$04 Write #N$02 as the speed along the x axis.
  $B27E,$02 Jump to #R$B26B.

c $B280 Handle Conveyor South
@ $B280 label=HandleConveyorSouth
D $B280 The handler for a conveyor which
. carries objects south (object #N$46).
R $B280 IX The address of the object
N $B280 Set the southward speed.
  $B280,$04 Write #N$FE as the speed along the y axis.
  $B284,$02 Jump to #R$B26B.

c $B286 Handle Conveyor West
@ $B286 label=HandleConveyorWest
D $B286 The handler for a conveyor which
. carries objects west (object #N$47).
R $B286 IX The address of the object
N $B286 Set the westward speed.
  $B286,$04 Write #N$FE as the speed along the x axis.
  $B28A,$02 Jump to #R$B26B.

c $B28C Handle Collapsing Block
@ $B28C label=HandleCollapsingBlock
D $B28C The handler for a block which
. collapses (object #N$2D). When something
. stands on it the block turns into a
. sparkle (object #N$40) and disappears.
E $B28C View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B6A2 }
. LIST#
R $B28C IX The address of the object
N $B28C Collapse if something is standing on the block.
  $B28C,$03 Call #R$BF3D.
  $B28F,$04 Test bit 3 of the state.
  $B293,$04 Reset bit 3 of the state.
  $B297,$01 Return if nothing was standing on the block.
  $B298,$04 Write #N$40 as the sprite number.
  $B29C,$03 Jump to #R$B3A4.

c $B29F Handle Deadly Object
@ $B29F label=HandleDeadlyObject
D $B29F The handler for the deadly pyramid
. and tubes (objects #N$48 and #N$4B). They
. are made deadly to touch (see #R$B2A7).
R $B29F IX The address of the object
N $B29F Set the pixel offsets and make the object deadly.
  $B29F,$03 Call #R$BF3D.
  $B2A2,$02 Jump to #R$B2A7.

c $B2A4 Handle Broken Egg
@ $B2A4 label=HandleBrokenEgg
D $B2A4 The handler for a broken egg
. (object #N$2E), which is deadly to touch.
E $B2A4 Continue on to #R$B2A7.
R $B2A4 IX The address of the object
N $B2A4 Set the pixel offsets.
  $B2A4,$03 Call #R$BF6A.

c $B2A7 Set Deadly Flags
@ $B2A7 label=SetDeadlyFlags
D $B2A7 Makes the object deadly to touch
. by setting bits 5 and 7 of its flags.
E $B2A7 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B85C }
. { #PENTAGRAM$C291 }
. LIST#
R $B2A7 IX The address of the object
N $B2A7 Set bits 5 and 7 of the flags.
  $B2A7,$03 Fetch the flags.
  $B2AA,$02,b$01 Set bits 5 and 7.
  $B2AC,$03 Store the flags.
  $B2AF,$01 Return.

c $B2B0 Set Deadly Flags And Draw
@ $B2B0 label=SetDeadlyFlagsAndDraw
D $B2B0 Makes the object deadly to touch
. (see #R$B2A7) and marks it to be wiped and
. redrawn.
R $B2B0 IX The address of the object
N $B2B0 Make the object deadly and redraw it.
  $B2B0,$03 Call #R$B2A7.
  $B2B3,$03 Jump to #R$BFAB.

c $B2B6 Handle Falling Block
@ $B2B6 label=HandleFallingBlock
D $B2B6 The handler for a block which
. falls when something stands on it (object
. #N$2C). It falls by one step on each frame
. that something is standing on it, and
. makes a sound unless it has landed.
R $B2B6 IX The address of the object
N $B2B6 Fall if something is standing on the block.
  $B2B6,$03 Call #R$BF3D.
  $B2B9,$04 Test bit 3 of the state.
  $B2BD,$04 Reset bit 3 of the state.
  $B2C1,$01 Return if nothing was standing on the block.
  $B2C2,$04 Write #N$00 as the speed along the z axis.
  $B2C6,$03 Call #R$BFB6.
  $B2C9,$04 Write #N$00 as the speed along the z axis.
  $B2CD,$06 Jump to #R$B2D6 if the block has landed.
  $B2D3,$03 Call #R$B63C.
@ $B2D6 label=HandleFallingBlock_Redraw
  $B2D6,$03 Jump to #R$BFAB.

c $B2D9 Save Position
@ $B2D9 label=SavePosition
D $B2D9 Saves the position of the object
. in #R$5B1B.
R $B2D9 IX The address of the object
N $B2D9 Copy x, y and z to #R$5B1B.
  $B2D9,$03 Point #REGhl at #R$5B1B.
  $B2DC,$03 Fetch the x position.
  $B2DF,$01 Store it.
  $B2E0,$01 Move on.
  $B2E1,$03 Fetch the y position.
  $B2E4,$01 Store it.
  $B2E5,$01 Move on.
  $B2E6,$03 Fetch the z position.
  $B2E9,$01 Store it.
  $B2EA,$01 Return.

c $B2EB Compare Position
@ $B2EB label=ComparePosition
D $B2EB Compares the position of the
. object with the one saved by #R$B2D9.
R $B2EB IX The address of the object
R $B2EB O:F Zero flag set if the position is the same
N $B2EB Compare x, y and z with #R$5B1B.
  $B2EB,$03 Point #REGhl at #R$5B1B.
  $B2EE,$03 Fetch the x position.
  $B2F1,$01 Compare it with the saved x position.
  $B2F2,$01 Return if it is different.
  $B2F3,$01 Move on.
  $B2F4,$03 Fetch the y position.
  $B2F7,$01 Compare it with the saved y position.
  $B2F8,$01 Return if it is different.
  $B2F9,$01 Move on.
  $B2FA,$03 Fetch the z position.
  $B2FD,$01 Compare it with the saved z position.
  $B2FE,$01 Return.

c $B2FF Handle Fat Bottom Block
@ $B2FF label=HandleFatBottomBlock
D $B2FF The handler for a block which is
. fat at the bottom (object #N$1C). The
. block is moved with gravity. If it is
. still moving its x and y speeds are
. cleared and it makes a sound. Otherwise it
. is only redrawn if it has been moved.
. #R$B31A joins this routine at #R$B302.
R $B2FF IX The address of the object
N $B2FF Move the block and redraw it if it has changed.
  $B2FF,$03 Call #R$BF3D.
@ $B302 label=HandleFatBottomBlock_Move
  $B302,$03 Call #R$B2D9.
  $B305,$03 Call #R$BFB6.
  $B308,$05 Jump to #R$B314 if the block is moving.
  $B30D,$04 Return if the position is the same.
  $B311,$03 Jump to #R$BFAB.
N $B314 The block is still moving.
@ $B314 label=HandleFatBottomBlock_Stop
  $B314,$03 Call #R$C2EE.
  $B317,$03 Jump to #R$B3BF.

c $B31A Handle Fat Top Block
@ $B31A label=HandleFatTopBlock
D $B31A The handler for a block which is
. fat at the top (object #N$1D). It is dealt
. with in the same way as #R$B2FF.
R $B31A IX The address of the object
N $B31A Set the pixel offsets and join #R$B302.
  $B31A,$03 Call #R$BF56.
  $B31D,$02 Jump to #R$B302.

c $B31F Handle Rising Block
@ $B31F label=HandleRisingBlock
D $B31F The handler for a block which
. moves up and down when the player is
. standing on it (object #N$2F). The highest
. point it reaches is #N$30 above its height
. when it was first handled, which is kept
. in #R$5B25. A block which has not been
. touched and has not landed is left alone.
E $B31F Continue on to #R$B33F.
R $B31F IX The address of the object
N $B31F Set #R$5B25 the first time this block is handled.
  $B31F,$03 Call #R$BF3D.
  $B322,$03 Fetch #R$5B25.
  $B325,$03 Jump to #R$B330 if it is not zero.
  $B328,$03 Fetch the height of the block.
  $B32B,$02 Add #N$30.
  $B32D,$03 Set #R$5B25.
N $B330 Leave the block alone unless it has been touched or has landed.
@ $B330 label=HandleRisingBlock_TestTouched
  $B330,$04 Test bit 3 of the state.
  $B334,$04 Reset bit 3 of the state.
  $B338,$02 Jump to #R$B34E if something touched the block.
  $B33A,$05 Return if the block has not landed.

c $B33F Handle Moving Block
@ $B33F label=HandleMovingBlock
D $B33F The handler for a block which
. moves up and down (object #N$1F), and the
. code which moves the block for #R$B31F. It
. falls with gravity until it lands, then
. rises at #N$03 until it is higher than
. #R$5B25, when it falls again. The first
. block sets #R$5B25 to its own height. Bit
. 2 of the state remembers whether it is
. rising.
R $B33F IX The address of the object
N $B33F Set #R$5B25 the first time a block is handled.
  $B33F,$03 Call #R$BF3D.
  $B342,$03 Fetch #R$5B25.
  $B345,$03 Jump to #R$B34E if it is not zero.
  $B348,$03 Fetch the height of the block.
  $B34B,$03 Set #R$5B25.
N $B34E Fall with gravity until the block lands, then start rising.
@ $B34E label=HandleMovingBlock_Move
  $B34E,$03 Call #R$B63C.
  $B351,$01 Set #REGa to #N$00.
  $B352,$03 Stop the speed along the x axis.
  $B355,$03 Stop the speed along the y axis.
  $B358,$06 Jump to #R$B371 if the block is rising.
  $B35E,$03 Set the speed along the z axis to #N$00.
  $B361,$03 Call #R$BFB6.
  $B364,$06 Jump to #R$B36E if the block has not landed.
  $B36A,$04 Set bit 2 of the state.
@ $B36E label=HandleMovingBlock_Redraw
  $B36E,$03 Jump to #R$BFAB.
N $B371 The block is rising.
@ $B371 label=HandleMovingBlock_Rising
  $B371,$04 Write #N$03 as the speed along the z axis.
  $B375,$03 Call #R$BFB6.
  $B378,$06 Jump to #R$B38C if the block is not blocked.
  $B37E,$04 Write #N$04 as the speed along the z axis.
  $B382,$01 Set #REGa to #N$00.
  $B383,$03 Stop the speed along the x axis.
  $B386,$03 Stop the speed along the y axis.
  $B389,$03 Call #R$BFB6.
@ $B38C label=HandleMovingBlock_TestHighestPoint
  $B38C,$03 Fetch #R$5B25.
  $B38F,$05 Jump to #R$B36E if the block has not gone above it.
  $B394,$04 Reset bit 2 of the state.
  $B398,$02 Jump to #R$B36E.

c $B39A Turn Into Sparkle
@ $B39A label=TurnIntoSparkle
D $B39A Changes the object into the first
. frame of a sparkle (object #N$30) and
. makes collision tests ignore it, then
. carries on to deal with the sparkle.
R $B39A IX The address of the object
N $B39A Become a sparkle and play the sound.
  $B39A,$04 Write #N$30 as the sprite number.
  $B39E,$04 Set bit 1 of the flags.
  $B3A2,$02 Jump to #R$B3AA.

c $B3A4 Handle Sparkle
@ $B3A4 label=HandleSparkle
D $B3A4 The handler for the sparkles
. (objects #N$30 to #N$36 and #N$40). Each
. time it is called the sparkle moves on to
. the next of its animation frames and a
. sparkle sound is played.
R $B3A4 IX The address of the object
N $B3A4 Step the frame and play the sparkle.
  $B3A4,$03 Call #R$BF6A.
  $B3A7,$03 Increment the sprite number.
@ $B3AA label=HandleSparkle_PlaySound
  $B3AA,$03 Call #R$B5EE.
  $B3AD,$03 Jump to #R$BFAB.

c $B3B0 Remove Object
@ $B3B0 label=RemoveObject
D $B3B0 Clears the byte whose address is
. held at offset #N$10 of the object, which
. is the number of a special object in
. #R$76E3, so that the object does not come
. back.
E $B3B0 Continue on to #R$B3B8.
R $B3B0 IX The address of the object
N $B3B0 Clear the special object entry.
  $B3B0,$03 Fetch the low byte of the address.
  $B3B3,$03 Fetch the high byte of the address.
  $B3B6,$02 Write #N$00.

c $B3B8 Retire Object
@ $B3B8 label=RetireObject
D $B3B8 The handler for the last of the
. sparkles (object #N$37). It sets the pixel
. offsets and makes the object a retired
. object (object #N$01).
E $B3B8 Continue on to #R$B3BF.
R $B3B8 IX The address of the object
N $B3B8 Become a retired object.
  $B3B8,$03 Call #R$BF6A.
@ $B3BB label=RetireObject_Retire
  $B3BB,$04 Write #N$01 as the sprite number.

c $B3BF Play Sound And Redraw
@ $B3BF label=PlaySoundAndRedraw
D $B3BF Plays a sound whose pitch depends
. on the position of the object, and marks
. it to be wiped and redrawn.
R $B3BF IX The address of the object
N $B3BF Play a sound and redraw the object.
  $B3BF,$03 Call #R$B654.
  $B3C2,$03 Jump to #R$BFAB.

b $B3C5 Start Game Tune
@ $B3C5 label=StartGameTune
D $B3C5 The tune played when a game
. starts. Each byte is a note: bits 0 to 5
. are the note number (see #R$B51D) and bits
. 6 and 7 are the length less one. The tune
. ends with #N$FF.
.
. #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune)))
B $B3C5,$12,$08*2,$02

b $B3D7 Robot Tune
@ $B3D7 label=RobotTune
D $B3D7 The tune played when the robot has
. come back up out of the pot of oil. Each
. byte is a note: bits 0 to 5 are the note
. number (see #R$B51D) and bits 6 and 7 are
. the length less one. The tune ends with
. #N$FF.
.
. #HTML(#AUDIO0(robot-tune.wav)(#INCLUDE(RobotTune)))
B $B3D7,$20,$08*4

b $B3F7 Game Over Tune
@ $B3F7 label=GameOverTune
D $B3F7 The tune played when the game is
. over. Each byte is a note: bits 0 to 5 are
. the note number (see #R$B51D) and bits 6
. and 7 are the length less one. The tune
. ends with #N$FF.
.
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
B $B3F7,$40,$08*8

b $B437 Game Complete Tune
@ $B437 label=GameCompleteTune
D $B437 The tune played when the game has
. been completed. Each byte is a note: bits
. 0 to 5 are the note number (see #R$B51D)
. and bits 6 and 7 are the length less one.
. The tune ends with #N$FF.
.
. #HTML(#AUDIO0(game-complete-tune.wav)(#INCLUDE(GameCompleteTune)))
B $B437,$1A,$08*3,$02

b $B451 Menu Tune
@ $B451 label=MenuTune
D $B451 The tune played while the menu is
. displayed. Each byte is a note: bits 0 to
. 5 are the note number (see #R$B51D) and
. bits 6 and 7 are the length less one. The
. tune ends with #N$FF.
.
. #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune)))
B $B451,$50,$08*10

c $B4A1 Play Music Once
@ $B4A1 label=PlayMusicOnce
D $B4A1 Plays a tune, but only if this
. routine has not played one before. Bit 0
. of #R$5B31 is set the first time and
. nothing clears it. The tune stops when a
. key is pressed (see #R$B4A9).
E $B4A1 Continue on to #R$B4A9.
E $B4A1 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$AF76 }
. { #KNIGHTLORE$B2B6 }
. { #NIGHTSHADE$C63D }
. { #PENTAGRAM$D69C }
. LIST#
R $B4A1 DE Address of the tune
N $B4A1 Play only if #R$5B31 is clear.
  $B4A1,$03 Point #REGhl at #R$5B31.
  $B4A4,$03 Return if #R$5B31 is set.
  $B4A7,$02 Set bit 0 of #R$5B31.

c $B4A9 Play Music Until Key Pressed
@ $B4A9 label=PlayMusic_WaitKey
D $B4A9 Plays a tune, which stops when a
. key is pressed. A tune is a list of notes
. (see #R$B4C5) which ends with #N$FF.
E $B4A9 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B2BE }
. LIST#
R $B4A9 DE Address of the tune
N $B4A9 Stop if a key is pressed.
  $B4A9,$01 Select all of the keyboard rows.
  $B4AA,$03 Call #R$B759.
  $B4AD,$02 Jump to #R$B4B0 if no key is pressed.
  $B4AF,$01 Return.
N $B4B0 Play the next note.
@ $B4B0 label=PlayMusic_WaitKey_TestEnd
  $B4B0,$01 Fetch the next note.
  $B4B1,$04 Jump to #R$B4C4 if it is #N$FF.
  $B4B5,$03 Call #R$B4C5.
  $B4B8,$02 Jump to #R$B4A9.

c $B4BA Play Music
@ $B4BA label=PlayMusic
D $B4BA Plays a tune, which cannot be
. stopped. A tune is a list of notes (see
. #R$B4C5) which ends with #N$FF.
.
. The tunes played by this routine are:
. #TABLE(default,centre,centre)
. { =h Tune | =h Sound }
. { Start-up Tune |
. #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune))) }
. { Robot Tune | #HTML(#AUDIO0(robot-tune.wav)(#INCLUDE(RobotTune))) }
. { Game Complete Tune |
. #HTML(#AUDIO0(game-complete-tune.wav)(#INCLUDE(GameCompleteTune))) }
. TABLE#
E $B4BA View the equivalent code in;
. #LIST
. { #CYBERUN$9AA9 }
. { #GUNFRIGHT$AF8F }
. { #KNIGHTLORE$B2CF }
. { #MARTIANOIDS$C0CF }
. { #NIGHTSHADE$C656 }
. { #PENTAGRAM$D6B5 }
. LIST#
R $B4BA DE Address of the tune
N $B4BA Play each note until #N$FF.
  $B4BA,$01 Fetch the next note.
  $B4BB,$04 Jump to #R$B4C4 if it is #N$FF.
  $B4BF,$03 Call #R$B4C5.
  $B4C2,$02 Jump to #R$B4BA.
@ $B4C4 label=PlayMusic_End
  $B4C4,$01 Return.

c $B4C5 Play Note
@ $B4C5 label=PlayNote
D $B4C5 Plays a note of a tune, or a rest
. if the note number is zero. Bits 0 to 5
. select the entry in #R$B51D that holds the
. two delays of a cycle and the number of
. cycles. Bits 6 and 7 are the length less
. one, which multiplies the number of
. cycles, so the note is one to four times
. as long.
E $B4C5 View the equivalent code in;
. #LIST
. { #CYBERUN$9AB4 }
. { #GUNFRIGHT$AF9A }
. { #KNIGHTLORE$B2DA }
. { #MARTIANOIDS$C0DA }
. { #NIGHTSHADE$C661 }
. { #PENTAGRAM$D6C0 }
. LIST#
R $B4C5 A The note
R $B4C5 DE Address of the note
R $B4C5 O:DE Address of the next note
N $B4C5 Look up the delays and the number of cycles.
  $B4C5,$02,b$01 Keep bits 0 to 5.
  $B4C7,$02 Jump to #R$B507 if the note is a rest.
  $B4C9,$01 Copy the note number to #REGl.
  $B4CA,$02 Set #REGh to #N$00.
  $B4CC,$01 Double the number.
  $B4CD,$03 Call #R$CE06.
  $B4D0,$03 Point #REGbc at #R$B51D.
  $B4D3,$01 Find the entry for the note.
  $B4D4,$01 Fetch the first delay.
  $B4D5,$01 Move on.
  $B4D6,$01 Fetch the second delay.
  $B4D7,$01 Move on.
  $B4D8,$01 Fetch the number of cycles.
  $B4D9,$02 Set #REGh to #N$00.
N $B4DB Bits 6 and 7 are the length, less one.
  $B4DB,$01 Fetch the note again.
  $B4DC,$02 Move bits 6 and 7 to bits 0 and 1.
  $B4DE,$02,b$01 Keep bits 0 and 1.
  $B4E0,$01 Add one.
  $B4E1,$01 Stash the note address on the stack.
  $B4E2,$02 Copy the number of cycles to #REGde.
N $B4E4 Multiply the number of cycles by the length.
@ $B4E4 label=PlayNote_MultiplyLength
  $B4E4,$01 Count down the length.
  $B4E5,$02 Jump to #R$B4EA if the length has been used up.
  $B4E7,$01 Add the number of cycles again.
  $B4E8,$02 Jump to #R$B4E4.
@ $B4EA label=PlayNote_PlayCycle
  $B4EA,$01 Restore the note address from the stack.
N $B4EB Each pass makes one cycle of the note.
@ $B4EB label=PlayNote_Cycle
  $B4EB,$01 Stash the delays on the stack.
  $B4EC,$01 Set #REGa to #N$00.
  $B4ED,$02 Turn the speaker off.
@ $B4EF label=PlayNote_FirstDelay
  $B4EF,$02 Wait for the first half of the cycle.
  $B4F1,$01 Count down the second delay.
  $B4F2,$02 Jump to #R$B4EF until it has finished.
  $B4F4,$01 Restore the delays from the stack.
  $B4F5,$01 Stash the delays on the stack.
  $B4F6,$02 Set bit 4.
  $B4F8,$02 Turn the speaker on.
@ $B4FA label=PlayNote_SecondDelay
  $B4FA,$02 Wait for the second half of the cycle.
  $B4FC,$01 Count down the second delay.
  $B4FD,$02 Jump to #R$B4FA until it has finished.
  $B4FF,$01 Restore the delays from the stack.
  $B500,$01 Count down the cycles.
  $B501,$04 Jump to #R$B4EB until all of the cycles have been played.
  $B505,$01 Move on to the next note.
  $B506,$01 Return.
N $B507 A rest is a silent pause of one to four units.
@ $B507 label=PlayNote_Rest
  $B507,$01 Fetch the length of the rest.
  $B508,$01 Move on to the next note.
  $B509,$02 Move bits 6 and 7 to bits 0 and 1.
  $B50B,$02,b$01 Keep bits 0 and 1.
  $B50D,$01 Add one.
  $B50E,$01 Keep it in #REGl.
  $B50F,$03 Set #REGbc to #N$430B.
@ $B512 label=PlayNote_RestUnit
  $B512,$01 Stash the pause length on the stack.
@ $B513 label=PlayNote_Pause
  $B513,$01 Count down the pause.
  $B514,$04 Jump to #R$B513 until it has finished.
  $B518,$01 Restore the pause length from the stack.
  $B519,$01 Count down the units of the rest.
  $B51A,$02 Jump to #R$B512 until the rest has finished.
  $B51C,$01 Return.

b $B51D Music Note Table
@ $B51D label=MusicNotes
D $B51D The note table. Each entry has
. three bytes: two delays for the halves of
. a cycle (#REGb and #REGc) and one that is
. a multiple of the length. Note zero is
. not used.
B $B51D,$03,$01:$01:$01 Note #N$00.
B $B520,$03,$01:$01:$01 Note #N$01.
B $B523,$03,$01:$01:$01 Note #N$02.
B $B526,$03,$01:$01:$01 Note #N$03.
B $B529,$03,$01:$01:$01 Note #N$04.
B $B52C,$03,$01:$01:$01 Note #N$05.
B $B52F,$03,$01:$01:$01 Note #N$06.
B $B532,$03,$01:$01:$01 Note #N$07.
B $B535,$03,$01:$01:$01 Note #N$08.
B $B538,$03,$01:$01:$01 Note #N$09.
B $B53B,$03,$01:$01:$01 Note #N$0A.
B $B53E,$03,$01:$01:$01 Note #N$0B.
B $B541,$03,$01:$01:$01 Note #N$0C.
B $B544,$03,$01:$01:$01 Note #N$0D.
B $B547,$03,$01:$01:$01 Note #N$0E.
B $B54A,$03,$01:$01:$01 Note #N$0F.
B $B54D,$03,$01:$01:$01 Note #N$10.
B $B550,$03,$01:$01:$01 Note #N$11.
B $B553,$03,$01:$01:$01 Note #N$12.
B $B556,$03,$01:$01:$01 Note #N$13.
B $B559,$03,$01:$01:$01 Note #N$14.
B $B55C,$03,$01:$01:$01 Note #N$15.
B $B55F,$03,$01:$01:$01 Note #N$16.
B $B562,$03,$01:$01:$01 Note #N$17.
B $B565,$03,$01:$01:$01 Note #N$18.
B $B568,$03,$01:$01:$01 Note #N$19.
B $B56B,$03,$01:$01:$01 Note #N$1A.
B $B56E,$03,$01:$01:$01 Note #N$1B.
B $B571,$03,$01:$01:$01 Note #N$1C.
B $B574,$03,$01:$01:$01 Note #N$1D.
B $B577,$03,$01:$01:$01 Note #N$1E.
B $B57A,$03,$01:$01:$01 Note #N$1F.
B $B57D,$03,$01:$01:$01 Note #N$20.
B $B580,$03,$01:$01:$01 Note #N$21.
B $B583,$03,$01:$01:$01 Note #N$22.
B $B586,$03,$01:$01:$01 Note #N$23.
B $B589,$03,$01:$01:$01 Note #N$24.
B $B58C,$03,$01:$01:$01 Note #N$25.
B $B58F,$03,$01:$01:$01 Note #N$26.
B $B592,$03,$01:$01:$01 Note #N$27.
B $B595,$03,$01:$01:$01 Note #N$28.
B $B598,$03,$01:$01:$01 Note #N$29.
B $B59B,$03,$01:$01:$01 Note #N$2A.
B $B59E,$03,$01:$01:$01 Note #N$2B.
B $B5A1,$03,$01:$01:$01 Note #N$2C.
B $B5A4,$03,$01:$01:$01 Note #N$2D.
B $B5A7,$03,$01:$01:$01 Note #N$2E.
B $B5AA,$03,$01:$01:$01 Note #N$2F.
B $B5AD,$03,$01:$01:$01 Note #N$30.
B $B5B0,$03,$01:$01:$01 Note #N$31.
B $B5B3,$03,$01:$01:$01 Note #N$32.
B $B5B6,$03,$01:$01:$01 Note #N$33.
B $B5B9,$03,$01:$01:$01 Note #N$34.
B $B5BC,$03,$01:$01:$01 Note #N$35.
B $B5BF,$03,$01:$01:$01 Note #N$36.
B $B5C2,$03,$01:$01:$01 Note #N$37.
B $B5C5,$03,$01:$01:$01 Note #N$38.
B $B5C8,$03,$01:$01:$01 Note #N$39.
B $B5CB,$03,$01:$01:$01 Note #N$3A.
B $B5CE,$03,$01:$01:$01 Note #N$3B.
B $B5D1,$03,$01:$01:$01 Note #N$3C.

c $B5D4 Play Pitch From Table
@ $B5D4 label=PlayPitchFromTable
D $B5D4 Plays four beeps at a pitch taken
. from #R$B5E6, using bits 0 to 2 of
. #R$5B02. Nothing in the game uses this
. routine.
E $B5D4 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B3E9 }
. LIST#
N $B5D4 Choose a pitch from the table.
N $B5D4 #HTML(#AUDIO0(block-sound.wav)(#INCLUDE(BlockSound)))
  $B5D4,$03 Fetch #R$5B02.
  $B5D7,$02,b$01 Keep bits 0 to 2.
  $B5D9,$03 Set #REGhl to the entry number.
  $B5DC,$04 Point #REGhl at the entry in #R$B5E6.
  $B5E0,$01 Fetch the pitch.
  $B5E1,$02 Set the number of beeps to #N$04.
  $B5E3,$03 Jump to #R$B6FB.

b $B5E6 Pitch Table
@ $B5E6 label=PitchTable
D $B5E6 The pitches used by #R$B5D4.
B $B5E6,$08,$08

c $B5EE Play Sparkle Sound
@ $B5EE label=PlaySparkleSound
D $B5EE Plays a burst of noise for a
. sparkle, using bytes of the ROM from
. #N$1234 as the pitches of beeps. The
. number of beeps is taken from the sprite
. number, so it changes as the sparkle goes
. through its frames.
E $B5EE View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B403 }
. LIST#
R $B5EE IX The address of the object
N $B5EE Play a beep for each remaining frame.
N $B5EE #HTML(#AUDIO0(sparkles-sound.wav)(#INCLUDE(SparklesSound)))
  $B5EE,$03 Fetch the sprite number.
  $B5F1,$01 Invert it.
  $B5F2,$02,b$01 Keep bits 0 to 4.
  $B5F4,$01 Keep the number of beeps in #REGe.
  $B5F5,$03 Point #REGhl at #N$1234.
@ $B5F8 label=PlaySparkleSound_NextBeep
  $B5F8,$03 Fetch a ROM byte as the pitch.
  $B5FB,$02 Set the number of beeps to #N$02.
  $B5FD,$03 Call #R$B6FB.
  $B600,$03 Jump to #R$B5F8 until all of the beeps have been played.
  $B603,$01 Return.

c $B604 Play Appearing Sound
@ $B604 label=PlayAppearingSound
D $B604 Plays a sound for the sparkles
. which appear around the player. The length
. and the pitches depend on the sprite
. number of the object.
E $B604 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B419 }
. LIST#
R $B604 IX The address of the object
N $B604 Make a beep for each remaining frame.
N $B604 #HTML(#AUDIO0(appearing-sound.wav)(#INCLUDE(AppearingSound)))
  $B604,$03 Fetch the sprite number.
  $B607,$02 Rotate it twice.
  $B609,$02,b$01 Keep bits 0 to 4.
  $B60B,$02,b$01 Set bits 0 and 1.
  $B60D,$01 Keep the number of beeps in #REGc.
@ $B60E label=PlayAppearingSound_NextBeep
  $B60E,$01 Copy the number of beeps to #REGa.
  $B60F,$02 Rotate it twice.
  $B611,$01 Keep the pitch in #REGb.
  $B612,$03 Call #R$B702.
  $B615,$01 Count down the beeps.
  $B616,$02 Jump to #R$B60E until all of them have been played.
  $B618,$01 Return.

c $B619 Play Bump Sound
@ $B619 label=PlayBumpSound
D $B619 Plays a burst of noise, using the
. bytes at #SKOOLKID$0000(START) as the
. pitches of beeps. It is the sound of one
. object bumping into another.
E $B619 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B42E }
. LIST#
N $B619 Play four bursts of three beeps.
N $B619 #HTML(#AUDIO0(bounce-sound.wav)(#INCLUDE(BounceSound)))
  $B619,$03 Point #REGhl at #SKOOLKID$0000(START).
  $B61C,$02 Set a counter of four bursts.
@ $B61E label=PlayBumpSound_NextBurst
  $B61E,$02 Set the number of beeps to #N$03.
  $B620,$01 Fetch a byte of the ROM.
  $B621,$01 Move on.
  $B622,$02,b$01 Set bits 6 and 7.
  $B624,$01 Keep the pitch in #REGb.
  $B625,$03 Call #R$B6FB.
  $B628,$01 Count down the bursts.
  $B629,$02 Jump to #R$B61E until all of them have been played.
  $B62B,$01 Return.

c $B62C Play Jump Sound
@ $B62C label=PlayJumpSound
D $B62C Plays the sound of the player
. jumping, which goes through a series of
. pitches.
E $B62C View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B441 }
. LIST#
N $B62C Play #N$20 beeps of falling pitch.
N $B62C #HTML(#AUDIO0(jump-sound.wav)(#INCLUDE(JumpSound)))
  $B62C,$02 Set the counter to #N$20.
@ $B62E label=PlayJumpSound_NextBeep
  $B62E,$01 Copy the counter to #REGa.
  $B62F,$05 Rotate it five times.
  $B634,$01 Keep the pitch in #REGb.
  $B635,$03 Call #R$B702.
  $B638,$01 Count down.
  $B639,$02 Jump to #R$B62E until all of the beeps have been played.
  $B63B,$01 Return.

c $B63C Play Sound From Height
@ $B63C label=PlaySoundFromHeight
D $B63C Plays a tone for an object that is
. falling or rising, with a pitch taken from
. the height of the object.
E $B63C Continue on to #R$B63F.
E $B63C View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B451 }
. LIST#
R $B63C IX The address of the object
N $B63C Use the height as the pitch source.
N $B63C #HTML(#AUDIO0(falling-sound.wav)(#INCLUDE(FallingSound)))
  $B63C,$03 Fetch the height of the object.

c $B63F Play Sound From Value
@ $B63F label=PlaySoundFromHeight_PlaySoundFromValue
D $B63F Plays six beeps of a tone whose
. pitch is worked out from the value in
. #REGa. #R$B63C uses the height, #R$B64A
. the x position, #R$B64F the y position and
. #R$B654 the sum of the three coordinates.
E $B63F View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B454 }
. LIST#
R $B63F A Value that the pitch is made from
N $B63F Turn the value into a pitch and play six beeps.
N $B63F #HTML(#AUDIO0(rising-sound.wav)(#INCLUDE(RisingSound)))
  $B63F,$02 Add #N$40.
  $B641,$01 Invert it.
  $B642,$02 Rotate it twice.
  $B644,$01 Keep the pitch in #REGb.
  $B645,$02 Set the number of beeps to #N$06.
  $B647,$03 Jump to #R$B6FB.

c $B64A Play Sound From X Position
@ $B64A label=PlaySoundFromXPosition
D $B64A Plays a short sound whose pitch
. depends on the x position of the object
. (see #R$B63F).
R $B64A IX The address of the object
N $B64A Use the x position as the pitch source.
N $B64A
. #HTML(#AUDIO0(block-east-west-sound.wav)(#INCLUDE(BlockEastWestSound)))
  $B64A,$03 Fetch the x position.
  $B64D,$02 Jump to #R$B63F.

c $B64F Play Sound From Y Position
@ $B64F label=PlaySoundFromYPosition
D $B64F Plays a short sound whose pitch
. depends on the y position of the object
. (see #R$B63F).
R $B64F IX The address of the object
N $B64F Use the y position as the pitch source.
N $B64F
. #HTML(#AUDIO0(block-north-south-sound.wav)(#INCLUDE(BlockNorthSouthSound)))
  $B64F,$03 Fetch the y position.
  $B652,$02 Jump to #R$B63F.

c $B654 Play Sound From Position
@ $B654 label=PlaySoundFromPosition
D $B654 Plays a short sound whose pitch
. depends on the sum of the coordinates of
. the object (see #R$B63F).
E $B654 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B467 }
. LIST#
R $B654 IX The address of the object
N $B654 Add x, y and z and play the sound.
N $B654 #HTML(#AUDIO0(moving-sound.wav)(#INCLUDE(MovingSound)))
  $B654,$03 Fetch the x position.
  $B657,$03 Add the y position.
  $B65A,$03 Add the z position.
  $B65D,$02 Jump to #R$B63F.

c $B65F Play Sound From Object Number
@ $B65F label=PlaySoundFromObjectNumber
D $B65F Plays a sound whose length and
. pitches depend on the sprite number of
. the object. Nothing in the game uses this
. routine.
E $B65F View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B472 }
. LIST#
R $B65F IX The address of the object
N $B65F Work out the number of beeps from the
. sprite number.
N $B65F #HTML(#AUDIO0(transform-sound.wav)(#INCLUDE(TransformSound)))
  $B65F,$03 Fetch the sprite number.
  $B662,$03 Rotate it three times.
  $B665,$02,b$01 Keep only bits 3 and 4.
  $B667,$02 Add #N$10.
  $B669,$01 Keep the number of beeps in #REGc.
N $B66A Play a beep of a pitch made from the
. remaining count.
@ $B66A label=PlaySoundFromObjectNumber_NextBeep
  $B66A,$01 Copy the number of beeps to #REGa.
  $B66B,$02,b$01 Flip every other bit.
  $B66D,$01 Add the number of beeps.
  $B66E,$01 Keep the pitch in #REGb.
  $B66F,$03 Call #R$B702.
  $B672,$01 Count down the beeps.
  $B673,$02 Jump to #R$B66A until all of them have
. been played.
  $B675,$01 Return.

c $B676 Play Random Noise
@ $B676 label=PlayRandomNoise
D $B676 Plays a burst of noise, using #N$10
. bytes of the ROM as the pitches of beeps.
. The ROM address is taken from #R$5B05 and
. #R$5B02.
E $B676 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B489 }
. LIST#
N $B676 Point at a random stretch of the ROM.
N $B676 #HTML(#AUDIO0(explosion.wav)(#INCLUDE(Explosion)))
  $B676,$03 Fetch #R$5B05.
  $B679,$01 Use it as the low byte of a ROM
. address.
  $B67A,$03 Fetch #R$5B02.
  $B67D,$02,b$01 Keep only bits 0 to 4.
  $B67F,$01 Use them as the high byte of the
. address.
  $B680,$02 Set a counter of #N$10 beeps.
N $B682 Play a beep from each ROM byte.
@ $B682 label=PlayRandomNoise_NextBeep
  $B682,$01 Fetch a byte of the ROM.
  $B683,$01 Move on.
  $B684,$02,b$01 Keep only bits 0 to 6.
  $B686,$01 Keep the pitch in #REGb.
  $B687,$02 Set the number of beeps to #N$02.
  $B689,$03 Call #R$B6FB.
  $B68C,$01 Count down the beeps.
  $B68D,$02 Jump to #R$B682 until all of them have
. been played.
  $B68F,$01 Return.

c $B690 Play Moving Sound
@ $B690 label=PlayMovingSound
D $B690 Plays the sound of a moving robot.
. The length comes from a table of four
. values, using bits 0 and 1 of #R$5B02, and
. the pitch changes with the frame.
R $B690 HL Address of a table of four lengths
N $B690 Fetch a length from the table.
N $B690 #HTML(#AUDIO0(robot-moving-sound.wav)(#INCLUDE(RobotMovingSound)))
  $B690,$03 Fetch #R$5B02.
  $B693,$02,b$01 Keep only bits 0 and 1.
  $B695,$03 Call #R$CE06.
  $B698,$01 Fetch the length of the sound.
N $B699 Play a beep of a pitch made from the
. frame and the length.
@ $B699 label=PlayMovingSound_NextBeep
  $B699,$03 Fetch #R$5B02.
  $B69C,$01 Combine it with the length.
  $B69D,$02,b$01 Keep only bits 0 to 4.
  $B69F,$02,b$01 Set bit 6.
  $B6A1,$01 Keep the pitch in #REGb.
  $B6A2,$03 Call #R$B702.
  $B6A5,$01 Count down.
  $B6A6,$02 Jump to #R$B699 until all of the beeps
. have been played.
  $B6A8,$01 Return.

b $B6A9 Moving Sound Lengths
@ $B6A9 label=MovingSoundLengths
D $B6A9 The lengths of the sound made by
. the remote control robot (see #R$A9C7)
. and by the chasing dome (see #R$AA89).
B $B6A9,$04,$04 Lengths for the remote control robot.
@ $B6AD label=MovingSoundLengths_ChasingDome
B $B6AD,$04,$04 Lengths for the chasing dome.

c $B6B1 Play Low Beep
@ $B6B1 label=PlayLowBeep
D $B6B1 Plays a low beep, which is #N$10
. beeps at a pitch of #N$80.
N $B6B1 Set the pitch and the beep count.
N $B6B1 #HTML(#AUDIO0(beep-sound.wav)(#INCLUDE(BeepSound)))
  $B6B1,$03 Set the pitch to #N$80 and the number
. of beeps to #N$10.
  $B6B4,$02 Jump to #R$B6FB.

c $B6B6 Play Middle Beep
@ $B6B6 label=PlayMiddleBeep
D $B6B6 Plays a middle beep, which is
. #N$18 beeps at a pitch of #N$50 (higher
. than the low beep at #R$B6B1). It is the
. sound of the game being paused and of it
. carrying on again.
N $B6B6 Set the pitch and the beep count.
N $B6B6 #HTML(#AUDIO0(pause-sound.wav)(#INCLUDE(PauseSound)))
  $B6B6,$03 Set the pitch to #N$50 and the number
. of beeps to #N$18.
  $B6B9,$02 Jump to #R$B6FB.

c $B6BB Play High Beep
@ $B6BB label=PlayHighBeep
D $B6BB Plays a high beep, which is #N$20
. beeps at a pitch of #N$30 (higher than
. the middle beep at #R$B6B6).
N $B6BB Set the pitch and the beep count.
N $B6BB #HTML(#AUDIO0(high-beep-sound.wav)(#INCLUDE(HighBeepSound)))
  $B6BB,$03 Set the pitch to #N$30 and the number
. of beeps to #N$20.
  $B6BE,$02 Jump to #R$B6FB.

c $B6C0 Play Mouse Sound
@ $B6C0 label=PlayMouseSound
D $B6C0 Plays the sound of a moving robot
. mouse, but only if the sprite number of
. the object is even.
E $B6C0 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B4AD }
. LIST#
R $B6C0 IX The address of the object
N $B6C0 Return unless this is an even sprite.
N $B6C0 #HTML(#AUDIO0(mouse-footstep-sound.wav)(#INCLUDE(MouseFootstepSound)))
  $B6C0,$03 Fetch the sprite number.
  $B6C3,$02,b$01 Keep only bit 0.
  $B6C5,$01 Return if the sprite number is odd.
N $B6C6 Set a fixed pitch and join the
. footstep player.
  $B6C6,$02 Set the pitch to #N$80.
  $B6C8,$03 Fetch #R$5B02.
  $B6CB,$01 Invert it.
  $B6CC,$02 Jump to #R$B6D9.

c $B6CE Play Footsteps Sound
@ $B6CE label=PlayFootstepsSound
D $B6CE Plays the footsteps of the player
. walking, but only on every other frame of
. the walking animation, which is when the
. sprite number of the object is even.
E $B6CE Continue on to #R$B6D4.
E $B6CE View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B4BB }
. LIST#
R $B6CE IX The address of the object
N $B6CE Return unless this is an even sprite.
N $B6CE #HTML(#AUDIO0(footstep-sound.wav)(#INCLUDE(FootstepSound)))
  $B6CE,$03 Fetch the sprite number.
  $B6D1,$02,b$01 Keep only bit 0.
  $B6D3,$01 Return if the sprite number is odd.

c $B6D4 Play Footsteps Sound Every Frame
@ $B6D4 label=PlayFootstepsSound_EveryFrame
D $B6D4 Plays the footsteps of the player
. walking, on every frame of the walking
. animation. The pitch starts as #N$60.
. When bit 1 of #REGa is set it is made
. from the height of the object instead.
. The number of beeps depends on the
. position of the object on the screen.
E $B6D4 Continue on to #R$B6FB.
R $B6D4 IX The address of the object
N $B6D4 Start with a fixed pitch.
  $B6D4,$02 Set the pitch to #N$60.
  $B6D6,$03 Fetch #R$5B02.
N $B6D9 Use the height when bit 1 is set.
@ $B6D9 label=PlayFootstepsSound_EveryFrame_TestPitch
  $B6D9,$04 Jump to #R$B6E6 if bit 1 of the value
. is clear.
  $B6DD,$03 Fetch the height of the object.
  $B6E0,$02 Add #N$40.
  $B6E2,$01 Invert it.
  $B6E3,$02 Halve it.
  $B6E5,$01 Use it as the pitch.
N $B6E6 Make the beep count from the
. on-screen position.
@ $B6E6 label=PlayFootstepsSound_EveryFrame_CountBeeps
  $B6E6,$03 Fetch the x position of the object.
  $B6E9,$02 Halve it.
  $B6EB,$01 Keep it in #REGc.
  $B6EC,$03 Fetch the y position of the object.
  $B6EF,$02 Make it negative.
  $B6F1,$02 Halve it.
  $B6F3,$01 Add the halved x position.
  $B6F4,$04 Move the upper four bits to the
. lowest four.
  $B6F8,$02,b$01 Keep only bits 0 to 3.
  $B6FA,$01 Keep the number of beeps in #REGc.

c $B6FB Play Wave Sequence
@ $B6FB label=PlayWaveSequence
D $B6FB Plays a number of beeps of the
. same pitch.
E $B6FB View the equivalent code in;
. #LIST
. { #GUNFRIGHT$AF5F }
. { #KNIGHTLORE$B4E6 }
. { #PENTAGRAM$D67B }
. LIST#
R $B6FB B Pitch
R $B6FB C Number of beeps
N $B6FB Play one beep per count.
  $B6FB,$03 Call #R$B702.
  $B6FE,$03 Jump to #R$B6FB until all of the
. beeps have been played.
  $B701,$01 Return.

c $B702 Play Square Wave
@ $B702 label=PlaySquareWave
D $B702 Plays a single beep by switching
. the speaker on, waiting, switching it off
. and waiting again. The bigger the pitch,
. the longer the beep.
E $B702 View the equivalent code in;
. #LIST
. { #CYBERUN$71E0 }
. { #GUNFRIGHT$AF66 }
. { #KNIGHTLORE$B4ED }
. { #NIGHTSHADE$C471 }
. { #PENTAGRAM$D682 }
. LIST#
R $B702 B Pitch
N $B702 Hold the speaker on, then off.
  $B702,$04 Turn the speaker on.
  $B706,$01 Keep the pitch in #REGa.
@ $B707 label=PlaySquareWave_FirstDelay
  $B707,$02 Wait for the first half of the beep.
  $B709,$01 Restore the pitch.
  $B70A,$03 Turn the speaker off.
  $B70D,$01 Keep the pitch in #REGa.
@ $B70E label=PlaySquareWave_SecondDelay
  $B70E,$02 Wait for the second half of the beep.
  $B710,$01 Restore the pitch.
  $B711,$01 Return.

c $B712 Test Object Intersections
@ $B712 label=TestObjectIntersections
D $B712 Tests whether an object overlaps
. any other solid object in the table that
. starts at #R$5B88, without moving. The
. object itself is ignored while the table
. is searched.
E $B712 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B4FD }
. { #PENTAGRAM$BF1B }
. LIST#
R $B712 IX The address of the object
R $B712 O:F Carry flag set if the object intersects another object
N $B712 Start at the first object with no
. movement.
  $B712,$05 Stash the registers on the stack.
  $B717,$04 Point #REGiy at #R$5B88.
  $B71B,$02 Set a counter of #N$38 objects.
  $B71D,$02 Set the x speed to #N$00.
  $B71F,$02 Set the y and z speeds to #N$00.
  $B721,$04 Set bit 1 of the object flags.
N $B725 Test whether this object overlaps on
. all three axes.
@ $B725 label=TestObjectIntersections_TestObject
  $B725,$03 Call #R$B74D.
  $B728,$02 Jump to #R$B743 if the object is not
. used or is ignored.
  $B72A,$03 Call #R$C5A9.
  $B72D,$02 Jump to #R$B743 if they do not
. overlap along x.
  $B72F,$03 Call #R$C5BE.
  $B732,$02 Jump to #R$B743 if they do not
. overlap along y.
  $B734,$03 Call #R$C5D3.
  $B737,$02 Jump to #R$B743 if they do not
. overlap along z.
N $B739 The objects overlap on all three
. axes (and the carry flag is set), or
. there are none left to try (and it is
. not).
@ $B739 label=TestObjectIntersections_Done
  $B739,$05 Restore #REGiy, #REGhl, #REGde and #REGbc from the stack.
  $B73E,$04 Reset bit 1 of the object flags.
  $B742,$01 Return.
N $B743 Move on to the next object.
@ $B743 label=TestObjectIntersections_NextObject
  $B743,$03 Set the size of an object record to
. #N$20.
  $B746,$02 Move on to the next object.
  $B748,$02 Jump to #R$B725 until all of the
. objects have been tested.
  $B74A,$01 Clear the carry flag.
  $B74B,$02 Jump to #R$B739.

c $B74D Test Object Solid
@ $B74D label=TestObjectSolid
D $B74D Tests whether collision tests
. should take any notice of an object. The
. zero flag is set if the slot is unused or
. bit 1 of the flags is set.
E $B74D View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B538 }
. { #PENTAGRAM$B99B }
. LIST#
R $B74D IY The address of the object
R $B74D O:F Zero flag set if the slot is not used or the object is ignored
N $B74D Return if the slot is empty.
  $B74D,$03 Fetch the sprite number of the
. object.
  $B750,$02 Return if the slot is not used.
N $B752 After invert, bit 1 is set when the
. object is not ignored.
  $B752,$03 Fetch the flags of the object.
  $B755,$01 Invert them.
  $B756,$02,b$01 Keep only bit 1.
  $B758,$01 Return.

c $B759 Read Keyboard Port
@ $B759 label=ReadKeyboardPort
D $B759 Reads some rows of the keyboard.
. The row selector is also written to port
. #N$FD (with the selector as the high byte
. of the address), which does nothing on a
. 48K Spectrum and is not part of any
. sound; the keyboard is read with the same
. selector straight afterwards.
E $B759 View the equivalent code in;
. #LIST
. { #CYBERUN$9BC3 }
. { #GUNFRIGHT$D0DB }
. { #KNIGHTLORE$B5F7 }
. { #NIGHTSHADE$E239 }
. { #PENTAGRAM$B952 }
. LIST#
R $B759 A Row selector (a bit which is reset selects the row)
R $B759 O:A Keys pressed, in bits 0 to 4 (a bit is set when a key is pressed)
R $B759 O:F Zero flag set if no key is pressed
N $B759 Write the selector, then read the
. keys.
  $B759,$02 Write the row selector to port
. #N$FD.
  $B75B,$02 Read the rows of the keyboard.
  $B75D,$01 Invert the bits, so that a bit is
. set for a key which is pressed.
  $B75E,$02,b$01 Keep only bits 0 to 4.
  $B760,$01 Return.

c $B761 Game Over
@ $B761 label=GameOver
D $B761 Ends the game. #R$AF05 is called,
. and then if #R$5B23 is set the completed
. message is shown first (see #R$B8A9). The
. game over screen shows "GAME OVER", a
. rating that depends on the rooms visited
. (#N$20 rooms to each of four ratings) and
. on #R$5B23, and the statistics. When a
. key has been pressed the screen is
. cleared and the objects of an ending
. scene are placed (see #R$B804). If the
. game was not completed this is the scene
. of the robot being beaten up, otherwise
. it is the scene of the robot ending its
. journey. The main loop is then entered
. at #R$A68E to run the scene.
.
. #PUSHS #UDGTABLE { =h Game over screen }
. { #SIM(start=$A631,stop=$A676,sp=$F100,r=$80,clear=1)
. #SIM(start=$BA7E,stop=$BA95)
. #SIM(start=$A67F,stop=$A6FE)
. #SIM(start=$A715,stop=$A72E)
. #SIM(start=$B761,stop=$B7AE)
. #SCR$02(game-over) } UDGTABLE# #POPS
N $B761 Update the valves and test whether
. the game is finished.
  $B761,$03 Call #R$AF05.
  $B764,$03 Fetch #R$5B23.
  $B767,$04 Jump to #R$B8A9 if it is not zero.
N $B76B Show the game over screen.
@ $B76B label=GameOver_ShowStatistics
  $B76B,$03 Call #R$CE7B.
  $B76E,$03 Call #R$CE73.
  $B771,$03 Point #REGde at #R$B94F.
  $B774,$01 Switch to the shadow registers.
  $B775,$03 Point #REGhl at #R$B956.
  $B778,$03 Point #REGde at #R$B964.
  $B77B,$02 Set the number of lines to #N$07.
  $B77D,$03 Call #R$BC31.
N $B780 Work out the rating from the rooms
. visited and from #R$5B23.
  $B780,$03 Call #R$B881.
  $B783,$01 Rotate the count.
  $B784,$02,b$01 Keep only bits 6 and 7.
  $B786,$01 Keep it in #REGc.
  $B787,$03 Fetch #R$5B23.
  $B78A,$02,b$01 Keep only bit 0.
  $B78C,$01 Combine it with the room count.
  $B78D,$03 Rotate the result three times.
  $B790,$02,b$01 Keep only bits 1 to 3.
  $B792,$01 Keep it in #REGl.
  $B793,$02 Set #REGh to #N$00.
  $B795,$03 Point #REGbc at #R$B9DD.
  $B798,$01 Add the table address.
  $B799,$03 Fetch the address of the message.
  $B79C,$03 Set the position of the message to
. #N$2758.
  $B79F,$03 Call #R$BBB1.
N $B7A2 Print the statistics.
  $B7A2,$03 Call #R$AC6B.
  $B7A5,$03 Call #R$BA36.
  $B7A8,$03 Call #R$CB8A.
  $B7AB,$03 Call #R$CE85.
N $B7AE Play the tune and wait for a key.
@ $B7AE label=GameOver_WaitForKeysReleased
  $B7AE,$01 Select all of the keyboard rows.
  $B7AF,$03 Call #R$B759.
  $B7B2,$02 Jump to #R$B7AE if a key is pressed.
N $B7B4 #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
  $B7B4,$03 Point #REGde at #R$B3F7.
  $B7B7,$03 Call #R$B4A9.
  $B7BA,$02 Set the length of the wait to #N$08.
  $B7BC,$03 Call #R$B899.
N $B7BF Start the ending scene.
  $B7BF,$05 Write #N$01 to *#R$5B24.
  $B7C4,$03 Call #R$CE7B.
  $B7C7,$03 Call #R$CB8A.
  $B7CA,$03 Call #R$CE85.
  $B7CD,$03 Call #R$CE4E.
  $B7D0,$03 Call #R$CE68.
  $B7D3,$03 Fetch #R$5B23.
  $B7D6,$03 Jump to #R$B7F0 if it is not zero.
N $B7D9 The game was not completed.
  $B7D9,$03 Set the position of the message to
. #N$9F48.
  $B7DC,$03 Point #REGde at #R$B7F5.
  $B7DF,$03 Call #R$BBB1.
  $B7E2,$03 Point #REGde at #R$B82A.
N $B7E5 Place the objects of the scene and
. run it.
@ $B7E5 label=GameOver_StartScene
  $B7E5,$03 Call #R$B804.
  $B7E8,$05 Write #N$01 to *#R$5B17.
  $B7ED,$03 Jump to #R$A68E.
N $B7F0 The game was completed.
@ $B7F0 label=GameOver_CompletedScene
  $B7F0,$03 Point #REGde at #R$B853.
  $B7F3,$02 Jump to #R$B7E5.

t $B7F5 Messaging: Reprogramming
@ $B7F5 label=ReprogrammingMessage
D $B7F5 The message that is shown while
. the thrusters are being reprogrammed,
. starting with its attribute. It is
. printed with #R$BBB1, and the last
. character has bit 7 set. In this font
. the character "<" is a hyphen.
B $B7F5,$01 #COLOUR(#PEEK(#PC)).
  $B7F6,$0E,$0D:$01 "RE<PROGRAMMING"

c $B804 Place Scene Objects
@ $B804 label=PlaceSceneObjects
D $B804 Places the objects of an ending
. scene in the table of objects, starting
. at #R$5B88. Each is described by five
. bytes: the sprite number, the flags, the
. colour, the pixel x position and the
. pixel y position. The list ends with a
. sprite number of zero.
R $B804 DE Address of the list of objects
N $B804 Start at the first object.
  $B804,$04 Point #REGiy at #R$5B88.
  $B808,$03 Set the size of an object record to
. #N$20.
N $B80B Copy the next object, or return at
. the terminator.
@ $B80B label=PlaceSceneObjects_NextObject
  $B80B,$01 Fetch the sprite number.
  $B80C,$01 Move on.
  $B80D,$02 Return if the list has ended.
  $B80F,$03 Set the sprite number of the object.
  $B812,$01 Fetch the flags.
  $B813,$01 Move on.
  $B814,$03 Set the flags of the object.
  $B817,$01 Fetch the colour.
  $B818,$01 Move on.
  $B819,$03 Set the colour of the object.
  $B81C,$01 Fetch the pixel x position.
  $B81D,$01 Move on.
  $B81E,$03 Set the pixel x position of the
. object.
  $B821,$01 Fetch the pixel y position.
  $B822,$01 Move on.
  $B823,$03 Set the pixel y position of the
. object.
  $B826,$02 Move on to the next object.
  $B828,$02 Jump to #R$B80B.

b $B82A Game Over Scene
@ $B82A label=GameOverScene
D $B82A The objects in the game over scene
. (see #R$B761). Each entry has five bytes:
. the sprite number, the flags, the colour,
. and the pixel x and y coordinates. The
. table ends with #N$00.
B $B82A,$05,$01:$01:$01:$01:$01 Sprite #N($51), flags #N($10), colour
. #COLOUR$42, at pixel position (#N($B8), #N$50).
. #UDGTABLE { #SPRITE$51,attr=$42(boxing-glove-01-colour*) } UDGTABLE#
B $B82F,$05,$01:$01:$01:$01:$01 Sprite #N($53), flags #N($10), colour
. #COLOUR$47, at pixel position (#N($20), #N$50).
. #UDGTABLE { #SPRITE$53,attr=$47(hook-01-colour*) } UDGTABLE#
B $B834,$05,$01:$01:$01:$01:$01 Sprite #N($52), flags #N($10), colour
. #COLOUR$44, at pixel position (#N($78), #N$7C).
. #UDGTABLE { #SPRITE$52,attr=$44(hammer-01-colour*) } UDGTABLE#
B $B839,$05,$01:$01:$01:$01:$01 Sprite #N($58), flags #N($10), colour
. #COLOUR$45, at pixel position (#N($68), #N$40).
. #UDGTABLE { #SPRITE$58,attr=$45(robot-arm-left-01-colour*) } UDGTABLE#
B $B83E,$05,$01:$01:$01:$01:$01 Sprite #N($59), flags #N($10), colour
. #COLOUR$45, at pixel position (#N($80), #N$40).
. #UDGTABLE { #SPRITE$59,attr=$45(robot-arm-right-01-colour*) }
. UDGTABLE#
B $B843,$05,$01:$01:$01:$01:$01 Sprite #N($5A), flags #N($10), colour
. #COLOUR$45, at pixel position (#N($70), #N$45).
. #UDGTABLE
. { #SPRITE$5A,attr=$45(robot-bottom-turning-02-colour*) }
. UDGTABLE#
B $B848,$05,$01:$01:$01:$01:$01 Sprite #N($5B), flags #N($10), colour
. #COLOUR$45, at pixel position (#N($70), #N$55).
. #UDGTABLE
. { #SPRITE$5B,attr=$45(robot-top-turning-02-colour*) }
. UDGTABLE#
B $B84D,$05,$01:$01:$01:$01:$01 Sprite #N($50), flags #N($10), colour
. #COLOUR$46, at pixel position (#N($74), #N$68).
. #UDGTABLE { #SPRITE$50,attr=$46(alarm-01-colour*) } UDGTABLE#
B $B852,$01 Terminator.

b $B853 Game Completed Scene
@ $B853 label=GameCompletedScene
D $B853 The objects in the game completed
. scene (see #R$B8A9). Each entry has five
. bytes: the sprite number, the flags, the
. colour, and the pixel x and y
. coordinates. The table ends with #N$00.
B $B853,$05,$01:$01:$01:$01:$01 Sprite #N($5C), flags #N($10), colour
. #COLOUR$07, at pixel position (#N($70), #N$80).
. #UDGTABLE
. { #SPRITE$5C,attr=$07(robot-bottom-turning-02-completed*) }
. UDGTABLE#
B $B858,$05,$01:$01:$01:$01:$01 Sprite #N($5D), flags #N($10), colour
. #COLOUR$07, at pixel position (#N($70), #N$90).
. #UDGTABLE
. { #SPRITE$5D,attr=$07(robot-top-turning-02-completed*) }
. UDGTABLE#
B $B85D,$05,$01:$01:$01:$01:$01 Sprite #N($55), flags #N($10), colour
. #COLOUR$44, at pixel position (#N($6C), #N$20).
. #UDGTABLE { #SPRITE$55,attr=$44(pot-of-oil-01-colour*) } UDGTABLE#
B $B862,$01 Terminator.

c $B863 Visit Room
@ $B863 label=VisitRoom
D $B863 Sets the bit for the room that
. the player is in, in #R$5B58. The bit to
. set is chosen by changing the opcode of
. the instruction at #R$B87E.
E $B863 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D219 }
. LIST#
N $B863 #HTML(Work out the byte and the <code>SET n,(#REGhl)</code> opcode.)
  $B863,$03 Fetch the room from
. #R$5B88(#N$5B90).
  $B866,$01 Keep it in #REGc.
  $B867,$03 Divide the room by eight.
  $B86A,$02,b$01 Keep only bits 0 to 4.
  $B86C,$01 Keep it in #REGl.
  $B86D,$02 Set #REGh to #N$00.
  $B86F,$01 Fetch the room again.
  $B870,$03 Rotate the room three times.
  $B873,$02,b$01 Keep only bits 3 to 5.
  $B875,$02,b$01 #HTML(Make it a <code>SET n,(#REGhl)</code> opcode.)
  $B877,$03 Write the opcode to
. #R$B87E(#N$B87F).
N $B87A Set the bit in the bitmap.
  $B87A,$04 Point #REGhl at #R$5B58 plus the byte offset.
N $B87E #HTML(This <code>SET n,(#REGhl)</code> is self-modifying.)
@ $B87E label=VisitRoom_Set
  $B87E,$02 Set the bit for the room.
  $B880,$01 Return.

c $B881 Count Rooms Visited
@ $B881 label=CountRoomsVisited
D $B881 Counts the bits which are set in
. #R$5B58.
R $B881 O:A The number of rooms visited, less one
N $B881 Count every set bit.
  $B881,$02 Set the count to #N$00.
  $B883,$03 Set a counter of #N$08 bits and
. #N$20 bytes.
  $B886,$03 Point #REGhl at #R$5B58.
@ $B889 label=CountRoomsVisited_NextByte
  $B889,$01 Stash the counters on the stack.
  $B88A,$01 Fetch a byte of the table.
  $B88B,$01 Move on.
@ $B88C label=CountRoomsVisited_NextBit
  $B88C,$01 Move a bit into the carry flag.
  $B88D,$02 Jump to #R$B890 if the bit is not
. set.
  $B88F,$01 Count the room.
@ $B890 label=CountRoomsVisited_CountBits
  $B890,$02 Jump to #R$B88C until all of the
. bits have been done.
  $B892,$01 Restore the counters from the stack.
  $B893,$01 Count down the bytes.
  $B894,$02 Jump to #R$B889 until all of the
. bytes have been done.
  $B896,$01 Copy the count to #REGa.
  $B897,$01 Subtract one from it.
  $B898,$01 Return.

c $B899 Wait For Key Press
@ $B899 label=WaitForKeyPress
D $B899 Waits until a key is pressed or a
. time has passed. The time is #REGb counts
. of #REGhl from #N($0000,$04,$04) back to
. #N($0000,$04,$04).
E $B899 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BA9B }
. LIST#
R $B899 B Length of the wait
N $B899 Count down, reading the keyboard
. each time.
  $B899,$03 Set #REGhl to #N($0000,$04,$04).
@ $B89C label=WaitForKeyPress_Wait
  $B89C,$01 Select all of the keyboard rows.
  $B89D,$03 Call #R$B759.
  $B8A0,$01 Return if a key is pressed.
  $B8A1,$01 Count down.
  $B8A2,$04 Jump to #R$B89C if #REGhl is not
. zero.
  $B8A6,$02 Jump to #R$B89C.
  $B8A8,$01 Return.

c $B8A9 Game Completed
@ $B8A9 label=GameCompleted
D $B8A9 Shows the message that the
. station has arrived, and plays the tune
. for the game being completed. It then
. carries on with the game over screen
. (see #R$B761(#N$B76B)).
.
. #PUSHS #UDGTABLE { =h Game completed message }
. { #SIM(start=$A631,stop=$A676,sp=$F100,r=$80,clear=1)
. #SIM(start=$BA7E,stop=$BA95)
. #SIM(start=$B8A9,stop=$B8C2)
. #SCR$02(game-completed) } UDGTABLE# #POPS
E $B8A9 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BAAB }
. LIST#
N $B8A9 Show the game completed message.
  $B8A9,$03 Call #R$CE7B.
  $B8AC,$03 Call #R$CE73.
  $B8AF,$03 Point #REGde at #R$B8D0.
  $B8B2,$01 Switch to the shadow registers.
  $B8B3,$03 Point #REGhl at #R$B8D7.
  $B8B6,$03 Point #REGde at #R$B8E5.
  $B8B9,$02 Set the number of lines to #N$07.
  $B8BB,$04 Write #N$00 to *#R$5B18.
  $B8BF,$03 Call #R$BC31.
N $B8C2 Play the tune and wait for a key.
N $B8C2 #HTML(#AUDIO0(game-complete-tune.wav)(#INCLUDE(GameCompleteTune)))
  $B8C2,$03 Point #REGde at #R$B437.
  $B8C5,$03 Call #R$B4BA.
  $B8C8,$02 Set the length of the wait to #N$08.
  $B8CA,$03 Call #R$B899.
  $B8CD,$03 Jump to #R$B76B.

b $B8D0 Game Completed Colours
@ $B8D0 label=GameCompletedColours
D $B8D0 The attributes of the lines of
. the game completed message.
B $B8D0,$01 #COLOUR(#PEEK(#PC)).
L $B8D0,$01,$07

b $B8D7 Game Completed Coordinates
@ $B8D7 label=GameCompletedCoordinates
D $B8D7 The pixel positions of the lines
. of the game completed message, as an x
. and a y coordinate.
B $B8D7,$02,$01 Line 0: (#N($20), #N$8F).
B $B8D9,$02,$01 Line 1: (#N($58), #N$7F).
B $B8DB,$02,$01 Line 2: (#N($28), #N$6F).
B $B8DD,$02,$01 Line 3: (#N($48), #N$5F).
B $B8DF,$02,$01 Line 4: (#N($48), #N$4F).
B $B8E1,$02,$01 Line 5: (#N($48), #N$3F).
B $B8E3,$02,$01 Line 6: (#N($58), #N$2F).

t $B8E5 Messaging: Game Completed Text
@ $B8E5 label=GameCompletedText
D $B8E5 The lines of the game completed
. message. The last character of each line
. has bit 7 set.
  $B8E5,$17,$16:$01 "THE STATION HAS ARRIVED"
  $B8FC,$0A,$09:$01 "FROM SPACE"
  $B906,$15,$14:$01 "THRUSTERS GENTLY SLOW"
  $B91B,$0E,$0D:$01 "THE ACTIVATION"
  $B929,$0E,$0D:$01 "CIRCUITS HELD"
  $B937,$0E,$0D:$01 "ALL CRYONAUGHT"
  $B945,$0A,$09:$01 "SYSTEMS GO"

b $B94F Game Over Colours
@ $B94F label=GameOverColours
D $B94F The attributes of the lines of
. the game over screen.
B $B94F,$01 #COLOUR(#PEEK(#PC)).
L $B94F,$01,$07

b $B956 Game Over Coordinates
@ $B956 label=GameOverCoordinates
D $B956 The pixel positions of the lines
. of the game over screen, as an x and a y
. coordinate.
B $B956,$02,$01 Line 0: (#N($58), #N$9F).
B $B958,$02,$01 Line 1: (#N($30), #N$8F).
B $B95A,$02,$01 Line 2: (#N($30), #N$7F).
B $B95C,$02,$01 Line 3: (#N($28), #N$6F).
B $B95E,$02,$01 Line 4: (#N($30), #N$5F).
B $B960,$02,$01 Line 5: (#N($28), #N$4F).
B $B962,$02,$01 Line 6: (#N($48), #N$37).

t $B964 Messaging: Game Over Text
@ $B964 label=GameOverText
D $B964 The lines of the game over
. screen. The last character of each line
. has bit 7 set.
  $B964,$09,$08:$01 "GAME OVER"
  $B96D,$13,$12:$01 "ACTIVATED CRYOGENIC"
  $B980,$13,$12:$01 "CHAMBERS;;;;;;;;; "
  $B993,$15,$14:$01 "UNACTIVATED CRYOGENIC"
  $B9A8,$13,$12:$01 "CHAMBERS;;;;;;;;; "
  $B9BB,$14,$13:$01 "CRYONAUGHTS LOST; "
  $B9CF,$0E,$0D:$01 "OVERALL RATING"

w $B9DD Rating Messages
@ $B9DD label=RatingMessages
D $B9DD The addresses of the rating
. messages, from the worst rating to the
. best.
W $B9DD,$02 Rating #N$00: #R$B9ED.
W $B9DF,$02 Rating #N$01: #R$B9F5.
W $B9E1,$02 Rating #N$02: #R$B9FE.
W $B9E3,$02 Rating #N$03: #R$BA06.
W $B9E5,$02 Rating #N$04: #R$BA0E.
W $B9E7,$02 Rating #N$05: #R$BA18.
W $B9E9,$02 Rating #N$06: #R$BA23.
W $B9EB,$02 Rating #N$07: #R$BA2B.

t $B9ED Messaging: Rating Text
@ $B9ED label=RatingMessagesText
D $B9ED The rating messages. Each starts
. with its attribute, and the last
. character of each has bit 7 set.
B $B9ED,$01 #COLOUR(#PEEK(#PC)).
  $B9EE,$07,$06:$01 " POOR"
@ $B9F5 label=RatingMessage_Average
B $B9F5,$01 #COLOUR(#PEEK(#PC)).
  $B9F6,$08,$07:$01 " AVERAGE"
@ $B9FE label=RatingMessage_Fair
B $B9FE,$01 #COLOUR(#PEEK(#PC)).
  $B9FF,$07,$06:$01 " FAIR"
@ $BA06 label=RatingMessage_Good
B $BA06,$01 #COLOUR(#PEEK(#PC)).
  $BA07,$07,$06:$01 " GOOD"
@ $BA0E label=RatingMessage_Excellent
B $BA0E,$01 #COLOUR(#PEEK(#PC)).
  $BA0F,$09,$08:$01 "EXCELLENT"
@ $BA18 label=RatingMessage_Marvellous
B $BA18,$01 #COLOUR(#PEEK(#PC)).
  $BA19,$0A,$09:$01 "MARVELLOUS"
@ $BA23 label=RatingMessage_Hero
B $BA23,$01 #COLOUR(#PEEK(#PC)).
  $BA24,$07,$06:$01 " HERO"
@ $BA2B label=RatingMessage_Adventurer
B $BA2B,$01 #COLOUR(#PEEK(#PC)).
  $BA2C,$0A,$09:$01 "ADVENTURER"

c $BA36 Print Statistics
@ $BA36 label=PrintStatistics
D $BA36 Prints the statistics for the
. game which has ended, using #R$6308: three
. digits of #R$5B3C, and two digits each of
. #R$5B3E and #R$5B3F. They are counted by
. #R$AC6B.
N $BA36 Print the cryonauts that were lost.
  $BA36,$06 Set #R$5B27 to #R$6308.
  $BA3C,$03 Point #REGde at #R$5B3C.
  $BA3F,$03 Point #REGhl at #R$DBF6.
  $BA42,$02 Set the number of bytes to #N$02.
  $BA44,$03 Call #R$BA74.
N $BA47 Print the chambers that were found
. activated.
  $BA47,$03 Point #REGhl at #R$E1F7.
  $BA4A,$02 Set the number of bytes to #N$01.
  $BA4C,$03 Call #R$BA6A.
N $BA4F Print the chambers that were not
. activated.
  $BA4F,$03 Point #REGhl at #R$DDF7.
  $BA52,$02 Set the number of bytes to #N$01.
  $BA54,$03 Jump to #R$BA6A.

c $BA57 Print Lives
@ $BA57 label=PrintLives
D $BA57 Prints the number of lives
. remaining in the panel.
E $BA57 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BCA3 }
. LIST#
N $BA57 Print #R$5B1A at the panel.
  $BA57,$03 Point #REGde at #R$5B1A.
  $BA5A,$02 Set the number of bytes to #N$01.
  $BA5C,$03 Point #REGhl at #R$D2F0.
  $BA5F,$03 Jump to #R$BA62.

c $BA62 Print BCD Number
@ $BA62 label=PrintBCDNumber
D $BA62 Prints a number which is held in
. BCD, using the font with the digits.
E $BA62 Continue on to #R$BA6A.
E $BA62 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BCAE }
. { #MARTIANOIDS$B5AF }
. { #NIGHTSHADE$C314 }
. { #PENTAGRAM$BB48 }
. LIST#
R $BA62 B Number of bytes
R $BA62 DE Address of the number
R $BA62 HL Address in the screen buffer
N $BA62 Point at the digit font.
  $BA62,$01 Stash the screen buffer address on
. the stack.
  $BA63,$06 Set #R$5B27 to #R$6308.
  $BA69,$01 Restore the screen buffer address from the stack.

c $BA6A Print BCD Bytes
@ $BA6A label=PrintBCDBytes
D $BA6A Prints the digits of a number
. held in BCD, two to each byte.
E $BA6A Continue on to #R$BA74.
R $BA6A B Number of bytes
R $BA6A DE Address of the number
R $BA6A HL Address in the screen buffer
N $BA6A Print the upper digit of the byte.
  $BA6A,$01 Fetch a byte of the number.
  $BA6B,$04 Move the upper digit to the lowest
. four bits.
  $BA6F,$02,b$01 Keep only bits 0 to 3.
  $BA71,$03 Call #R$BBEB.

c $BA74 Print Low Digit
@ $BA74 label=PrintLowDigit
D $BA74 Prints the lower digit of a byte
. of a number held in BCD, and goes on to
. the next byte (see #R$BA6A).
R $BA74 B Number of bytes
R $BA74 DE Address of the number
R $BA74 HL Address in the screen buffer
N $BA74 Print the lower digit and move on.
  $BA74,$01 Fetch a byte of the number.
  $BA75,$02,b$01 Keep only bits 0 to 3.
  $BA77,$03 Call #R$BBEB.
  $BA7A,$01 Move on to the next byte.
  $BA7B,$02 Jump to #R$BA6A until all of the
. bytes have been printed.
  $BA7D,$01 Return.

c $BA7E Game Selection Menu
@ $BA7E label=GameMenu
D $BA7E Displays the menu and waits for the
. control method to be chosen and the game to
. be started. The keys "1" to "4" choose the
. keyboard, the Kempston joystick, the cursor
. joystick and Interface II, "5" turns
. directional control on or off, and "0"
. starts the game. A low beep sounds when the
. choice changes. The menu tune is played
. once. The choice is held in #R$5B04.
.
. #PUSHS #UDGTABLE
. { #SIM(start=$A631,stop=$A676,sp=$F100,r=$80,clear=1)
. #SIM(start=$BA7E,stop=$BA95)
. #SCR$02(game-selection-menu) } UDGTABLE# #POPS
E $BA7E View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BD0C }
. { #MARTIANOIDS$BB12 }
. { #NIGHTSHADE$C8CA }
. { #PENTAGRAM$BB74 }
. LIST#
N $BA7E Prepare the menu.
  $BA7E,$04 Write #N$00 to #R$5B18.
  $BA82,$03 Point #REGhl at #R$BB14.
  $BA85,$02 Set the number of lines to #N$08.
@ $BA87 label=GameMenu_StopFlashing
  $BA87,$02 Stop the line flashing.
  $BA89,$01 Move on to the next line.
  $BA8A,$02 Jump to #R$BA87 until all of the lines are done.
  $BA8C,$03 Call #R$CE7B.
  $BA8F,$03 Call #R$BC25.
  $BA92,$03 Call #R$BAFB.
N $BA95 Read the keys that choose the control method.
@ $BA95 label=GameMenu_MenuLoop
  $BA95,$03 Call #R$BC25.
N $BA98 #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune)))
  $BA98,$03 Point #REGde at #R$B451.
  $BA9B,$03 Call #R$B4A1.
  $BA9E,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $BAA3,$01 Keep the keys that are pressed in #REGe.
  $BAA4,$03 Fetch #R$5B04.
  $BAA7,$03 Set #R$5B06.
  $BAAA,$04 Jump to #R$BAB0 if "1" is not pressed.
  $BAAE,$02,b$01 Choose the keyboard.
N $BAB0 Choose a joystick if one of those keys is pressed.
@ $BAB0 label=GameMenu_TestKempston
  $BAB0,$04 Jump to #R$BAB8 if "2" is not pressed.
  $BAB4,$02,b$01 Clear bits 1 and 2.
  $BAB6,$02,b$01 Choose the Kempston joystick.
@ $BAB8 label=GameMenu_TestCursor
  $BAB8,$04 Jump to #R$BAC0 if "3" is not pressed.
  $BABC,$02,b$01 Clear bits 1 and 2.
  $BABE,$02,b$01 Choose the cursor joystick.
@ $BAC0 label=GameMenu_TestInterface
  $BAC0,$04 Jump to #R$BAC6 if "4" is not pressed.
  $BAC4,$02,b$01 Choose Interface II.
@ $BAC6 label=GameMenu_SetMethod
  $BAC6,$03 Set #R$5B04.
N $BAC9 Toggle directional control once for each press of "5".
  $BAC9,$03 Point #REGhl at #R$5B32.
  $BACC,$04 Jump to #R$BAF7 if "5" is not pressed.
  $BAD0,$04 Jump to #R$BADE if "5" was pressed last time as well.
  $BAD4,$02 Set bit 0 of #R$5B32.
  $BAD6,$03 Fetch #R$5B04.
  $BAD9,$02,b$01 Toggle directional control.
  $BADB,$03 Set #R$5B04.
N $BADE Start the game if "0" is pressed.
@ $BADE label=GameMenu_TestStart
  $BADE,$03 Point #REGhl at #R$5B06.
  $BAE1,$04 Call #R$B6B1 if the control method has changed.
  $BAE5,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $BAEA,$03 Return if "0" is pressed.
  $BAED,$03 Point #REGhl at #R$5B00.
  $BAF0,$01 Increment #R$5B00.
  $BAF1,$03 Call #R$BAFB.
  $BAF4,$03 Jump to #R$BA95.
N $BAF7 "5" has been released.
@ $BAF7 label=GameMenu_KeyReleased
  $BAF7,$02 Reset bit 0 of #R$5B32.
  $BAF9,$02 Jump to #R$BADE.

c $BAFB Flash Menu Options
@ $BAFB label=FlashMenuOptions
D $BAFB Makes the line of the menu for
. the selected control method flash, and
. the line for directional control if that
. is on.
E $BAFB View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BD89 }
. { #NIGHTSHADE$C949 }
. { #PENTAGRAM$BBD8 }
. LIST#
N $BAFB Flash the chosen control method.
  $BAFB,$03 Point #REGhl at #R$BB15.
  $BAFE,$03 Fetch #R$5B04.
  $BB01,$01 Move the method to bits 0 and 1.
  $BB02,$02,b$01 Keep only bits 0 and 1.
  $BB04,$02 Set a counter of #N$04 lines.
  $BB06,$03 Call #R$BC15.
N $BB09 Flash directional control if it is
. on.
  $BB09,$02 Reset bit 7 of the attribute.
  $BB0B,$03 Fetch #R$5B04.
  $BB0E,$02,b$01 Keep only bit 3.
  $BB10,$01 Return if it is off.
  $BB11,$02 Set bit 7 of the attribute.
  $BB13,$01 Return.

b $BB14 Menu Colours
@ $BB14 label=MenuColours
D $BB14 The attributes of the lines of
. the menu.
B $BB14,$01 #COLOUR(#PEEK(#PC)).
@ $BB15 label=MenuColours_FirstOption
B $BB15,$01 #COLOUR(#PEEK(#PC)).
L $BB15,$01,$07

b $BB1C Menu Coordinates
@ $BB1C label=MenuCoordinates
D $BB1C The pixel positions of the lines
. of the menu, as an x and a y coordinate.
B $BB1C,$02,$01 Line 0: (#N($68), #N$9F).
B $BB1E,$02,$01 Line 1: (#N($30), #N$8F).
B $BB20,$02,$01 Line 2: (#N($30), #N$7F).
B $BB22,$02,$01 Line 3: (#N($30), #N$6F).
B $BB24,$02,$01 Line 4: (#N($30), #N$5F).
B $BB26,$02,$01 Line 5: (#N($30), #N$4F).
B $BB28,$02,$01 Line 6: (#N($30), #N$3F).
B $BB2A,$02,$01 Line 7: (#N($50), #N$27).

t $BB2C Messaging: Menu Text
@ $BB2C label=MenuText
D $BB2C The lines of the menu. The last
. character of each line has bit 7 set.
  $BB2C,$07,$06:$01 "ALIEN 8"
  $BB33,$0A,$09:$01 "1 KEYBOARD"
  $BB3D,$13,$12:$01 "2 KEMPSTON JOYSTICK"
  $BB50,$11,$10:$01 "3 CURSOR JOYSTICK"
  $BB61,$0E,$0D:$01 "4 INTERFACE II"
  $BB6F,$15,$14:$01 "5 DIRECTIONAL CONTROL"
  $BB84,$0C,$0B:$01 "0 START GAME"
  $BB90,$0D,$0C:$01 "> 1985 A;C;G;"

c $BB9D Print Text Single Colour
@ $BB9D label=PrintTextSingleColour
D $BB9D Prints a line of text in the
. colour held in #R$5B16, using the ASCII
. font at #N$6188. The last character of
. the text has bit 7 set. Each character
. cell has its attribute set as well.
E $BB9D View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BE31 }
. { #PENTAGRAM$BC66 }
. LIST#
R $BB9D DE Address of the text
R $BB9D HL Pixel position
N $BB9D Point at the ASCII font and keep
. #R$5B16.
  $BB9D,$01 Stash the pixel position on the
. stack.
  $BB9E,$03 Point #REGhl at #N$6188.
  $BBA1,$03 Set #R$5B27.
  $BBA4,$02 Copy the pixel position to #REGbc
. (using the stack).
  $BBA6,$03 Call #R$D120.
  $BBA9,$02 Copy it to #REGhl.
  $BBAB,$03 Fetch #R$5B16.
  $BBAE,$01 Keep the colour in #REGaf'.
  $BBAF,$02 Jump to #R$BBC2.

c $BBB1 Print Text Standard Font
@ $BBB1 label=PrintTextStandardFont
D $BBB1 Prints a line of text, which
. starts with its attribute, using the
. ASCII font at #N$6188. The last
. character of the text has bit 7 set.
. Each character cell has its attribute
. set as well.
E $BBB1 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BE45 }
. { #PENTAGRAM$BC7A }
. LIST#
R $BBB1 DE Address of the text
R $BBB1 HL Pixel position
N $BBB1 Point at the ASCII font and fetch
. the attribute from the text.
  $BBB1,$01 Stash the pixel position on the
. stack.
  $BBB2,$03 Point #REGhl at #N$6188.
  $BBB5,$03 Set #R$5B27.
  $BBB8,$02 Copy the pixel position to #REGbc
. (using the stack).
  $BBBA,$03 Call #R$D120.
  $BBBD,$02 Copy it to #REGhl.
  $BBBF,$01 Fetch the attribute of the text.
  $BBC0,$01 Keep the attribute in #REGaf'.
  $BBC1,$01 Move on to the first character.
N $BBC2 Find the attribute address.
@ $BBC2 label=PrintTextStandardFont_PrintLine
  $BBC2,$01 Switch to the shadow registers.
  $BBC3,$01 Fetch the pixel position.
  $BBC4,$01 Stash the address of the text on
. the stack.
  $BBC5,$03 Call #R$D157.
  $BBC8,$02 Copy it to #REGhl.
  $BBCA,$01 Restore the address of the text from the stack.
N $BBCB Print each character and set its
. attribute.
@ $BBCB label=PrintTextStandardFont_NextCharacter
  $BBCB,$01 Switch back to the main registers.
  $BBCC,$01 Fetch a character of the text.
  $BBCD,$04 Jump to #R$BBDE if it is the last.
  $BBD1,$01 Stash the address of the text on
. the stack.
  $BBD2,$03 Call #R$BBEB.
  $BBD5,$01 Restore the address of the text from the stack.
  $BBD6,$01 Move on to the next character.
  $BBD7,$01 Switch to the shadow registers.
  $BBD8,$01 Fetch the attribute.
  $BBD9,$01 Set the attribute of the cell.
  $BBDA,$01 Move on to the next cell.
  $BBDB,$01 Keep the attribute in #REGaf'.
  $BBDC,$02 Jump to #R$BBCB.
N $BBDE Print the last character.
@ $BBDE label=PrintTextStandardFont_LastCharacter
  $BBDE,$02,b$01 Keep only bits 0 to 6.
  $BBE0,$01 Stash the address of the text on
. the stack.
  $BBE1,$03 Call #R$BBEB.
  $BBE4,$01 Restore the address of the text from the stack.
  $BBE5,$01 Move on past the text.
  $BBE6,$01 Switch to the shadow registers.
  $BBE7,$01 Fetch the attribute.
  $BBE8,$01 Set the attribute of the last
. cell.
  $BBE9,$01 Switch back to the main registers.
  $BBEA,$01 Return.

c $BBEB Print Character
@ $BBEB label=PrintCharacter
D $BBEB Prints a character in the screen
. buffer, using the font whose address is
. held in #R$5B27. A space is drawn as
. #N$3D, which is blank in this font. The
. eight rows are written going down the
. buffer (see #R$D200), #N$20 bytes apart,
. and the address is left at the top of
. the next character.
E $BBEB View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BE7F }
. { #PENTAGRAM$BAEA }
. LIST#
R $BBEB A The character
R $BBEB HL Address in the screen buffer of the top row
R $BBEB O:HL Address of the top row of the next character
N $BBEB Turn a space into the font space.
  $BBEB,$04 Jump to #R$BBF1 if it is not a space.
  $BBEF,$02 Use the font space (#N$3D).
N $BBF1 Find the glyph.
@ $BBF1 label=PrintCharacter_Find
  $BBF1,$03 Stash #REGbc, #REGde and the
. screen buffer address on the stack.
  $BBF4,$03 Set #REGhl to the character.
  $BBF7,$03 Multiply the character by eight.
N $BBFA Add the font address.
@ $BBFA label=PrintCharacter_Offset
  $BBFA,$04 Fetch #R$5B27.
  $BBFE,$01 Add it to get the glyph address.
  $BBFF,$01 Point #REGde at the glyph.
  $BC00,$01 Restore the screen buffer address from the stack.
N $BC01 Copy eight rows down the buffer.
  $BC01,$02 Set a counter of #N$08 rows.
@ $BC03 label=PrintCharacter_NextRow
  $BC03,$02 Copy a row of the glyph to the buffer.
  $BC05,$01 Move on to the next row of the glyph.
  $BC06,$01 Stash the row counter on the stack.
  $BC07,$04 Move #REGhl down a row.
  $BC0B,$01 Restore the row counter from the stack.
  $BC0C,$02 Jump to #R$BC03 until all eight
. rows have been written.
N $BC0E Move on to the next character, eight
. lines up and one byte to the right.
  $BC0E,$01 Restore #REGde from the stack.
  $BC0F,$04 Move #REGhl on by #N($0101,$04,$04).
  $BC13,$01 Restore #REGbc from the stack.
  $BC14,$01 Return.

c $BC15 Set Flashing Attribute
@ $BC15 label=SetFlashingAttribute
D $BC15 Sets bit 7 of the attribute of
. one line of text in a list of lines, and
. resets it for the other lines.
E $BC15 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BEA3 }
. { #MARTIANOIDS$BB73 }
. { #NIGHTSHADE$CA1B }
. { #PENTAGRAM$BB64 }
. LIST#
R $BC15 A The number of the line
R $BC15 B Number of lines
R $BC15 HL Address of the attributes
N $BC15 Flash one line and steady the rest.
  $BC15,$03 Jump to #R$BC1F if the line is not
. the first.
@ $BC18 label=SetFlashingAttribute_Flash
  $BC18,$02 Set bit 7 of the attribute.
  $BC1A,$02 Jump to #R$BC21.
@ $BC1C label=SetFlashingAttribute_NextLine
  $BC1C,$03 Jump to #R$BC18 if this is the
. line.
@ $BC1F label=SetFlashingAttribute_Steady
  $BC1F,$02 Reset bit 7 of the attribute.
@ $BC21 label=SetFlashingAttribute_Next
  $BC21,$01 Move on to the next line.
  $BC22,$02 Jump to #R$BC1C until all of the
. lines have been done.
  $BC24,$01 Return.

c $BC25 Display Menu
@ $BC25 label=DisplayMenu
D $BC25 Displays the menu, which is a
. list of eight lines of text (see
. #R$BC31).
E $BC25 Continue on to #R$BC31.
E $BC25 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BEB3 }
. { #NIGHTSHADE$CA2B }
. { #PENTAGRAM$BCB4 }
. LIST#
N $BC25 Point at the menu colours,
. positions and text.
  $BC25,$03 Point #REGde at #R$BB14.
  $BC28,$01 Switch to the shadow registers.
  $BC29,$03 Point #REGhl at #R$BB1C.
  $BC2C,$03 Point #REGde at #R$BB2C.
  $BC2F,$02 Set the number of lines to #N$08.

c $BC31 Display Text List
@ $BC31 label=DisplayTextList
D $BC31 Prints a list of lines of text
. in the screen buffer, each in its own
. colour. #REGde' points at the attributes,
. #REGhl at pairs of pixel x and y
. positions, and #REGde at the text. After
. the lines have been printed the border
. is drawn and the buffer is copied to the
. screen, unless #R$5B18 is already set.
E $BC31 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BEBF }
. LIST#
R $BC31 B Number of lines
R $BC31 DE Address of the text
R $BC31 HL Address of the list of positions
R $BC31 DE' Address of the list of attributes
N $BC31 Print one line from the three lists.
  $BC31,$01 Switch to the shadow registers.
  $BC32,$01 Fetch the attribute of the line.
  $BC33,$03 Set #R$5B16.
  $BC36,$01 Move on to the next attribute.
  $BC37,$01 Switch back to the main registers.
  $BC38,$01 Stash the number of lines on the stack.
  $BC39,$01 Fetch the x position.
  $BC3A,$02 Move on to the next pair of positions.
  $BC3C,$01 Stash the address of the next pair on the stack.
  $BC3D,$01 Point #REGhl at the y position.
  $BC3E,$01 Fetch the y position.
  $BC3F,$01 Set the x position.
  $BC40,$03 Call #R$BB9D.
  $BC43,$01 Restore the address of the next pair from the stack.
  $BC44,$01 Restore the number of lines from the stack.
  $BC45,$02 Jump to #R$BC31 until all of the lines have been printed.
N $BC47 Draw the border the first time.
  $BC47,$05 Return if #R$5B18 is set.
  $BC4C,$04 Write #N$01 to *#R$5B18.
  $BC50,$03 Call #R$CB8A.
  $BC53,$03 Jump to #R$CE85.

c $BC56 Print Sprites
@ $BC56 label=PrintSprites
D $BC56 Prints the sprite of an object a
. number of times, moving the pixel
. position of the object by a step each
. time, so that it makes a row of sprites.
. #REGbc, #REGde and #REGhl are preserved
. while each sprite is printed.
E $BC56 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BEE4 }
. { #PENTAGRAM$BDDE }
. LIST#
R $BC56 B Number of times
R $BC56 D Step along the y axis in pixels
R $BC56 E Step along the x axis in pixels
R $BC56 IX The address of the object
N $BC56 Print one sprite and step the
. position.
  $BC56,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $BC59,$03 Call #R$D027.
  $BC5C,$03 Restore #REGhl, #REGde and #REGbc from the stack.
  $BC5F,$03 Fetch the pixel x position of the
. object.
  $BC62,$01 Add the step along the x axis.
  $BC63,$03 Set the pixel x position of the
. object.
  $BC66,$03 Fetch the pixel y position of the
. object.
  $BC69,$01 Add the step along the y axis.
  $BC6A,$03 Set the pixel y position of the
. object.
  $BC6D,$02 Jump to #R$BC56 until all of the
. sprites have been printed.
  $BC6F,$01 Return.

c $BC70 Handle Player Appearing
@ $BC70 label=HandlePlayerAppearing
D $BC70 The handler for the sparkles in
. which the player appears at the start of
. a life (objects #N$38 to #N$3E). On every
. other frame it moves on to the next of
. the animation frames and plays a sound.
E $BC70 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BEFE }
. LIST#
R $BC70 IX The address of the object
N $BC70 Advance the sparkle on every other
. frame.
  $BC70,$03 Call #R$BF47.
  $BC73,$03 Fetch #R$5B02.
  $BC76,$01 Invert it.
  $BC77,$02,b$01 Keep only bit 0.
  $BC79,$01 Return on every other frame.
  $BC7A,$03 Move on to the next sprite number.
  $BC7D,$03 Call #R$B604.
  $BC80,$03 Jump to #R$BFAB.

c $BC83 Handle Last Appearing Sparkle
@ $BC83 label=HandleLastAppearingSparkle
D $BC83 The handler for the last of the
. sparkles in which the player appears
. (object #N$3F). The object stops moving
. and gets back the sprite number which
. was kept at offset #N$10 of its record,
. and the object is handled again straight
. away with that sprite number.
R $BC83 IX The address of the object
N $BC83 Stop the sparkle and restore the
. object.
  $BC83,$03 Call #R$BF47.
  $BC86,$0A Set the x, y and z speeds to #N$00.
  $BC90,$04 Reset bit 6 of the flags.
  $BC94,$03 Fetch the sprite number which was
. kept.
  $BC97,$03 Restore the sprite number of the
. object.
  $BC9A,$03 Jump to #R$A6B1.

c $BC9D Display Objects Carried
@ $BC9D label=DisplayObjectsCarried
D $BC9D Displays the objects which the
. player is carrying in the panel, if they
. have changed (see #R$5B14). Each of the
. three places takes three cells across
. and is #N$18 pixels apart from the next.
. The place is cleared, the sprite of the
. object is printed in the screen buffer
. and copied to the screen, and the cells
. are coloured according to the shape of
. the object (see #R$BD34). #R$BCAB
. displays the objects whether they have
. changed or not.
.
. #PUSHS #UDGTABLE { =h After #R$BC9D }
. { #SIM(start=$A631,stop=$A676,sp=$F100,r=$80,clear=1)
. #SIM(start=$CE73,stop=$0000,sp=$EC00)
. #POKES$5B7C,$60;$5B80,$63;$5B84,$61;$5B14,$01
. #SIM(start=$BC9D,stop=$0000,sp=$EC00)
. #SCR$02,$00,$14,$10,$04(display-objects-carried) } UDGTABLE# #POPS
E $BC9D View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BF45 }
. { #PENTAGRAM$BA3D }
. LIST#
N $BC9D Return unless the objects have
. changed.
  $BC9D,$05 Return if #R$5B23 is set.
  $BCA2,$05 Return if #R$5B14 is zero.
  $BCA7,$04 Write #N$00 to *#R$5B14.
N $BCAB Draw the three places in the panel.
@ $BCAB label=DisplayObjectsCarried_Display
  $BCAB,$02 Stash #REGix on the stack.
  $BCAD,$04 Point #REGix at #R$BD38.
  $BCB1,$02 Set a counter of #N$03 places.
  $BCB3,$03 Point #REGhl at #R$5B7C.
N $BCB6 Work out the pixel x of this place
. (#N$18 times the place, plus #N$08).
@ $BCB6 label=DisplayObjectsCarried_NextPlace
  $BCB6,$01 Stash the counter on the stack.
  $BCB7,$01 Stash the address of the object on
. the stack.
  $BCB8,$01 Copy the counter to #REGa.
  $BCB9,$02 Make it negative.
  $BCBB,$02 Add #N$03.
  $BCBD,$06 Multiply it by eight.
  $BCC3,$01 Keep it in #REGc.
  $BCC4,$02 Double it.
  $BCC6,$01 Add the eight times.
  $BCC7,$02 Add #N$08.
  $BCC9,$03 Set the pixel x position of the
. place.
  $BCCC,$04 Set the pixel y position of the
. place to #N$00.
N $BCD0 Clear the place and print the
. sprite.
  $BCD0,$03 Fetch the pixel x position into
. #REGc.
  $BCD3,$03 Fetch the pixel y position into
. #REGb.
  $BCD6,$01 Stash the address of the object on
. the stack.
  $BCD7,$03 Call #R$D120.
  $BCDA,$02 Copy it to #REGhl.
  $BCDC,$03 Set #REGbc to #N$0318.
  $BCDF,$01 Set #REGa to #N$00.
  $BCE0,$03 Call #R$BF83.
  $BCE3,$01 Restore the address of the object from the stack.
  $BCE4,$01 Fetch the number of the object
. carried.
  $BCE5,$03 Jump to #R$BCF2 if it is zero.
  $BCE8,$04 Reset bit 6 of the flags.
  $BCEC,$03 Set the sprite number of the
. object.
  $BCEF,$03 Call #R$D027.
N $BCF2 Copy the place to the screen.
@ $BCF2 label=DisplayObjectsCarried_CopyPlace
  $BCF2,$03 Fetch the pixel x position into
. #REGc.
  $BCF5,$03 Fetch the pixel y position into
. #REGb.
  $BCF8,$03 Call #R$D135.
  $BCFB,$03 Call #R$D120.
  $BCFE,$02 Copy it to #REGhl.
  $BD00,$03 Set #REGbc to #N$1803.
  $BD03,$03 Call #R$CF85.
N $BD06 Colour the cells from the shape.
  $BD06,$01 Restore the address of the object from the stack.
  $BD07,$02 Keep the counter on the stack.
  $BD09,$01 Stash the address of the object on
. the stack.
  $BD0A,$01 Fetch the number of the object
. carried.
  $BD0B,$02,b$01 Keep only bits 0 to 3.
  $BD0D,$03 Copy the shape into #REGde.
  $BD10,$04 Point #REGhl at the entry of #R$BD34 for the shape.
  $BD14,$01 Fetch the colour into #REGc.
  $BD15,$03 Fetch the pixel x position of the
. place into #REGl.
  $BD18,$03 Fetch the pixel y position of the
. place.
  $BD1B,$02 Add #N$17.
  $BD1D,$01 Keep it in #REGh.
  $BD1E,$03 Call #R$D157.
  $BD21,$01 Swap it into #REGhl.
  $BD22,$01 Fetch the colour.
  $BD23,$03 Set #REGbc to #N$0303.
  $BD26,$03 Call #R$BF83.
  $BD29,$02 Restore the address of the object and the counter from the stack.
  $BD2B,$04 Move on to the next object
. carried.
  $BD2F,$02 Jump to #R$BCB6 until all three
. places have been done.
  $BD31,$02 Restore #REGix from the stack.
  $BD33,$01 Return.

b $BD34 Carried Object Colours
@ $BD34 label=CarriedObjectColours
D $BD34 The attributes of the cells under
. the objects which are carried, for each
. of the four shapes of valve.
B $BD34,$01 #COLOUR(#PEEK(#PC)).
L $BD34,$01,$04

g $BD38 Sprite Object
@ $BD38 label=SpriteObject
D $BD38 An object which is used for
. printing sprites in the panel and the
. border.
B $BD38,$20,$08

c $BD58 Test Pickup Drop Key
@ $BD58 label=TestPickupDropKey
D $BD58 Tests whether the control for
. picking up or dropping an object is
. pressed. If a joystick is used with
. directional control then the other of
. the two bits for this is used.
E $BD58 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BFFB }
. { #PENTAGRAM$BF66 }
. LIST#
R $BD58 O:F Zero flag set if the control is not pressed
N $BD58 Use the directional bit when a
. joystick has directional control.
  $BD58,$03 Point #REGhl at #R$5B04.
  $BD5B,$01 Fetch it.
  $BD5C,$02,b$01 Keep only bits 1 and 2.
  $BD5E,$03 Fetch #R$5B15.
  $BD61,$02 Jump to #R$BD68 if the keyboard is
. in use.
  $BD63,$04 Jump to #R$BD68 if directional
. control is off.
  $BD67,$01 Move the bit for directional
. control into place.
@ $BD68 label=TestPickupDropKey_Test
  $BD68,$02,b$01 Keep only bit 4.
  $BD6A,$01 Return.

c $BD6B Handle Pickup And Drop
@ $BD6B label=HandlePickupAndDrop
D $BD6B Picks up or drops an object when
. the player presses the control for it. A
. valve which is close enough is picked
. up. If the player is carrying three
. objects already then the one that has
. been carried longest is dropped where
. the new one was. Otherwise, if the
. player is carrying something and there
. is a free place for a special object in
. the room, the object that has been
. carried longest is dropped where the
. player stands, and the player is lifted
. up by #N$0C to stand on it.
.
. The routine looks for objects by making
. the player a little wider, deeper and
. taller, which is put right when the
. routine ends.
.
. The objects carried are four lots of
. four bytes from #R$5B78: the object
. number, the flags and the address of the
. entry in #R$76E3. The first is the place
. for a new object and the last is the one
. that has been carried longest.
E $BD6B View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C00E }
. { #PENTAGRAM$BF79 }
. LIST#
R $BD6B IX The address of the bottom half of the player
N $BD6B Return unless this is a new press
. while the player is standing in the
. room.
  $BD6B,$07 Jump to #R$BDFD if #R$5B13 is set.
  $BD72,$03 Call #R$BD58.
  $BD75,$01 Return if the control is not pressed.
  $BD76,$03 Call #R$C117.
  $BD79,$01 Return if the player is not inside the room.
N $BD7A Return if the player is jumping.
  $BD7A,$05 Return if the player is jumping.
N $BD7F Return if the player is in the air.
  $BD7F,$05 Return if the player is in the air.
N $BD84 Test whether there is room to drop
. an object, by raising the player by
. #N$0C.
  $BD84,$04 Write #N$00 to *#R$5B33.
  $BD88,$03 Fetch the height of the player.
  $BD8B,$01 Keep it in #REGb.
  $BD8C,$02 Add #N$0C.
  $BD8E,$03 Set the new height of the player.
  $BD91,$03 Call #R$B712.
  $BD94,$03 Restore the height of the player.
  $BD97,$02 Jump to #R$BD9E if there is room.
  $BD99,$05 Write #N$01 to *#R$5B33.
N $BD9E Mark the press and enlarge the
. player.
@ $BD9E label=HandlePickupAndDrop_Pressed
  $BD9E,$03 Call #R$B6B1.
  $BDA1,$08 Write #N$01 to *#R$5B13 and
. *#R$5B14.
  $BDA9,$02 Set a counter of #N$02 special
. objects.
  $BDAB,$03 Fetch the width of the player.
  $BDAE,$01 Copy it into #REGa.
  $BDAF,$02 Add #N$04.
  $BDB1,$03 Set the new width.
  $BDB4,$03 Fetch the depth of the player.
  $BDB7,$01 Copy it into #REGa.
  $BDB8,$02 Add #N$04.
  $BDBA,$03 Set the new depth.
  $BDBD,$01 Stash the old width and depth.
  $BDBE,$03 Fetch the height of the player.
  $BDC1,$01 Copy it into #REGa.
  $BDC2,$02 Add #N$04.
  $BDC4,$03 Set the new height.
  $BDC7,$01 Stash the old height.
  $BDC8,$04 Point #REGiy at #R$5BC8.
N $BDCC Try to pick up a nearby valve.
@ $BDCC label=HandlePickupAndDrop_LookForObject
  $BDCC,$03 Call #R$BEA7.
  $BDCF,$03 Jump to #R$BE76 if it can be
. picked up.
  $BDD2,$05 Point #REGiy at the next special object.
  $BDD7,$02 Jump to #R$BDCC until both have
. been tried.
N $BDD9 Look for a free slot to drop into.
  $BDD9,$03 Call #R$BD58.
  $BDDC,$02 Jump to #R$BDF1 if it is zero.
  $BDDE,$02 Set a counter of #N$02 special
. objects.
  $BDE0,$04 Point #REGiy at #R$5BC8.
  $BDE4,$03 Set #REGde to #N($0020,$04,$04).
@ $BDE7 label=HandlePickupAndDrop_TestSlot
  $BDE7,$03 Fetch the object number of the
. special object.
  $BDEA,$03 Jump to #R$BE06 if it is zero.
  $BDED,$02 Point #REGiy at the next special
. object.
  $BDEF,$02 Jump to #R$BDE7 until all of them
. have been tried.
N $BDF1 Put the size of the player back.
@ $BDF1 label=HandlePickupAndDrop_Done
  $BDF1,$01 Restore the old height from the stack.
  $BDF2,$03 Set the height of the player.
  $BDF5,$01 Restore the old width and depth from the stack.
  $BDF6,$03 Set the width of the player.
  $BDF9,$03 Set the depth of the player.
  $BDFC,$01 Return.
N $BDFD Wait until the control is released.
@ $BDFD label=HandlePickupAndDrop_WaitForRelease
  $BDFD,$03 Call #R$BD58.
  $BE00,$01 Return if it is not zero.
  $BE01,$04 Write #N$00 to *#R$5B13.
  $BE05,$01 Return.
N $BE06 Drop the object that has been
. carried longest.
@ $BE06 label=HandlePickupAndDrop_Drop
  $BE06,$03 Point #REGhl at #R$5B84.
  $BE09,$01 Fetch its object number.
  $BE0A,$01 Move on to the flags.
  $BE0B,$03 Jump to #R$BE60 if it is zero.
  $BE0E,$03 Fetch #R$5B33.
  $BE11,$03 Jump to #R$BDF1 if it is not zero.
  $BE14,$01 Point #REGhl at the object number.
  $BE15,$01 Fetch it.
  $BE16,$01 Move on to the flags.
  $BE17,$03 Set it as the object number of the
. special object.
N $BE1A Put the object where the player is,
. and lift the player on top of it.
@ $BE1A label=HandlePickupAndDrop_Place
  $BE1A,$01 Stash the address of the flags of
. the object carried.
  $BE1B,$03 Set #REGbc to #N($0003,$04,$04).
  $BE1E,$03 Copy #REGix to #REGhl (using the
. stack).
  $BE21,$03 Copy #REGiy to #REGde (using the
. stack).
  $BE24,$01 Point #REGde at the x position of
. the object.
  $BE25,$01 Point #REGhl at the x position of
. the player.
  $BE26,$02 Copy the position of the player to
. the object.
  $BE28,$03 Fetch the height of the player.
  $BE2B,$02 Add #N$0C.
  $BE2D,$03 Set the new height of the player.
  $BE30,$03 Fetch the height of the top half
. of the player.
  $BE33,$02 Add #N$0C.
  $BE35,$03 Set the new height of the top half
. of the player.
  $BE38,$03 Call #R$AE8A.
N $BE3B Set up the rest of the object.
@ $BE3B label=HandlePickupAndDrop_SetObject
  $BE3B,$04 Set the width of the object to
. #N$05.
  $BE3F,$04 Set the depth of the object to
. #N$05.
  $BE43,$04 Set the height of the object to
. #N$0C.
  $BE47,$01 Restore the address of the flags
. of the object carried from the stack.
  $BE48,$01 Fetch the flags.
  $BE49,$01 Move on to the address of the
. table entry.
  $BE4A,$03 Set the flags of the object.
  $BE4D,$03 Fetch the room of the player.
  $BE50,$03 Set the room of the object.
  $BE53,$01 Fetch the low byte of the table
. entry address.
  $BE54,$01 Move on to the high byte.
  $BE55,$03 Set the low byte of the table
. entry address of the object.
  $BE58,$01 Fetch the high byte of the table
. entry address.
  $BE59,$03 Set the high byte of the table
. entry address of the object.
  $BE5C,$04 Set bit 0 of the object flags.
N $BE60 Shift the carried list along and
. clear #R$5B78.
@ $BE60 label=HandlePickupAndDrop_Shift
  $BE60,$03 Point #REGhl at #R$5B83.
  $BE63,$03 Point #REGde at #R$5B87.
  $BE66,$03 Set #REGbc to #N($000C,$04,$04).
  $BE69,$02 Move the objects.
  $BE6B,$03 Point #REGde at #R$5B78.
  $BE6E,$02 Set the number of bytes to clear
. to #N$04.
  $BE70,$03 Call #R$CE1C.
  $BE73,$03 Jump to #R$BDF1.
N $BE76 Pick up the object that #REGiy
. points at.
@ $BE76 label=HandlePickupAndDrop_PickUp
  $BE76,$03 Point #REGhl at #R$5B78.
  $BE79,$04 Write #N$00 to *#R$5B3B.
  $BE7D,$03 Fetch the object number of the
. object.
  $BE80,$01 Store it.
  $BE81,$01 Move on to the flags.
  $BE82,$03 Fetch the flags of the object.
  $BE85,$01 Store them.
  $BE86,$01 Move on to the address of the
. table entry.
  $BE87,$03 Fetch the low byte of the table
. entry address of the object.
  $BE8A,$03 Fetch the high byte.
  $BE8D,$02 Write #N$00 to the table entry.
  $BE8F,$01 Store the low byte of the table
. entry address.
  $BE90,$01 Move on to the high byte.
  $BE91,$01 Store it.
  $BE92,$03 Call #R$ADF3.
  $BE95,$04 Set the sprite number to #N$01.
  $BE99,$03 Point #REGhl at #R$5B84.
  $BE9C,$01 Fetch its object number.
  $BE9D,$01 Move on to the flags.
  $BE9E,$03 Jump to #R$BE60 if it is zero.
  $BEA1,$03 Set it as the object number of the
. special object.
  $BEA4,$01 Stash the address of the flags.
  $BEA5,$02 Jump to #R$BE3B.

c $BEA7 Test Object Can Be Picked Up
@ $BEA7 label=TestObjectCanBePickedUp
D $BEA7 Tests whether an object is one of
. the four valves (objects #N$60 to #N$63)
. that the player is on or close to.
E $BEA7 Continue on to #R$BEAF.
E $BEA7 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C172 }
. { #PENTAGRAM$C0D4 }
. LIST#
R $BEA7 IX The address of the player
R $BEA7 IY The address of the object
R $BEA7 O:F Carry flag set if the object can be picked up
N $BEA7 Return unless the object is a
. valve.
  $BEA7,$03 Fetch the object number of the
. object.
  $BEAA,$02 Subtract #N$60.
  $BEAC,$03 Return if it is not a valve.

c $BEAF Test Near Object
@ $BEAF label=TestNearObject
D $BEAF Tests whether the player is
. standing on, or next to, the object.
R $BEAF IX The address of the player
R $BEAF IY The address of the object
R $BEAF O:F Carry flag set if the objects overlap
N $BEAF Test x and y with no movement, then
. z with the player #N$04 lower.
  $BEAF,$01 Stash #REGbc.
  $BEB0,$03 Set #REGbc to #N($0000,$04,$04).
  $BEB3,$02 Set the y and z speeds to #N$00.
  $BEB5,$03 Call #R$C5A9.
  $BEB8,$02 Jump to #R$BED4 if they do not
. overlap along x.
  $BEBA,$03 Call #R$C5BE.
  $BEBD,$02 Jump to #R$BED4 if they do not
. overlap along y.
  $BEBF,$03 Fetch the height of the player.
  $BEC2,$02 Subtract #N$04.
  $BEC4,$03 Set the new height.
  $BEC7,$03 Call #R$C5D3.
  $BECA,$01 Stash the result.
  $BECB,$03 Fetch the height of the player.
  $BECE,$02 Add #N$04.
  $BED0,$03 Set the old height.
  $BED3,$01 Restore the result from the stack.
@ $BED4 label=TestNearObject_Done
  $BED4,$01 Restore #REGbc from the stack.
  $BED5,$01 Return.

c $BED6 Test Object Moving
@ $BED6 label=TestObjectMoving
D $BED6 Tests whether the object is
. moving.
E $BED6 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C1A1 }
. LIST#
R $BED6 IX The address of the object
R $BED6 O:F Zero flag set if the object is not moving
N $BED6 Combine the three speeds.
  $BED6,$03 Fetch the speed along the x axis.
  $BED9,$03 Combine it with the speed along
. the y axis.
  $BEDC,$03 Combine it with the speed along
. the z axis.
  $BEDF,$01 Return.

c $BEE0 Handle Extra Life
@ $BEE0 label=HandleExtraLife
D $BEE0 The handler for an extra life
. (object #N$0C). When the player touches
. it the object turns into a sparkle, it
. is removed from the table of special
. objects, the egg tops are allowed to
. move again and a life is added and
. printed in the panel. An extra life
. which has not been touched is moved
. with gravity and makes a sound when it
. moves.
E $BEE0 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C1AB }
. LIST#
R $BEE0 IX The address of the object
N $BEE0 Test whether the player is near.
  $BEE0,$03 Call #R$BF7E.
  $BEE3,$04 Copy #REGix to #REGiy (using the
. stack).
  $BEE7,$04 Point #REGix at #R$5B88.
  $BEEB,$03 Make the player a little wider.
  $BEEE,$03 Make the player a little deeper.
  $BEF1,$03 Call #R$BEAF.
  $BEF4,$03 Put the width of the player back.
  $BEF7,$03 Put the depth of the player back.
  $BEFA,$04 Copy #REGiy to #REGix (using the
. stack).
  $BEFE,$02 Jump to #R$BF22 if the player is
. not near.
N $BF00 Collect the extra life.
  $BF00,$04 Set the sprite number to #N$40.
  $BF04,$03 Call #R$BF6A.
  $BF07,$03 Fetch the low byte of the table
. entry address.
  $BF0A,$03 Fetch the high byte.
  $BF0D,$05 Write #N$00 to the table entry and
. to *#R$5B3B.
  $BF12,$04 Add one life to #R$5B1A.
  $BF16,$03 Call #R$B6B1.
  $BF19,$03 Call #R$BA57.
  $BF1C,$06 Copy the lives to the screen at (#N($80), #N$00).
N $BF22 Move the extra life if it was not
. collected.
@ $BF22 label=HandleExtraLife_Move
  $BF22,$03 Call #R$BFB6.
  $BF25,$03 Call #R$BED6.
  $BF28,$01 Return if the object is not moving.
  $BF29,$03 Call #R$C2EE.
  $BF2C,$03 Jump to #R$B3BF.

c $BF2F Copy Area To Screen
@ $BF2F label=CopyAreaToScreen
D $BF2F Copies an area of the screen
. buffer, two bytes wide and eight rows
. high, to the screen at a pixel position.
E $BF2F View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C432 }
. LIST#
R $BF2F BC Pixel position
N $BF2F Find both addresses.
  $BF2F,$03 Call #R$D135.
  $BF32,$03 Call #R$D120.
  $BF35,$02 Copy it to #REGhl.
  $BF37,$06 Jump to #R$CF85 with #N$08 lines of #N$02 bytes.

c $BF3D Set Pixel Adjustments
@ $BF3D label=SetPixelAdjustments
D $BF3D Sets how many pixels the sprite of
. an object is moved, in x and y, from the
. position that #R$CFD2 works out. The
. isometric formula finds a corner of the
. object; these offsets sit the graphic on
. that box. There is an entry point for
. each pair of offsets, and the one that
. is used depends on the sprite. #REGl is
. the offset in x and #REGh is the offset
. in y. A plain block (object #N$1E) and
. the wall parts (objects #N$0D to #N$0F)
. have no other work, so their update
. routine is one of these entries.
E $BF3D View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C4D3 }
. LIST#
R $BF3D IX The address of the object
N $BF3D The adjustments of blocks,
. conveyors, land mines, deadly pyramids
. and the remote control objects: #N$F0
. in x and #N$F7 in y.
  $BF3D,$03 Set the adjustments.
  $BF40,$02 Jump to #R$BF77.
N $BF42 The adjustments of #N$F4 in x and
. #N$F7 in y.
@ $BF42 label=SetPixelAdjustments_F4F7
  $BF42,$03 Set the adjustments.
  $BF45,$02 Jump to #R$BF77.
N $BF47 The adjustments of the top of a
. broken egg and of the sparkles while
. the player appears: #N$F4 in x and
. #N$F8 in y.
@ $BF47 label=SetPixelAdjustments_Appearing
  $BF47,$03 Set the adjustments.
  $BF4A,$02 Jump to #R$BF77.
N $BF4C The adjustments of the legs of
. the player and of a socket: #N$F0 in x
. and #N$F9 in y.
@ $BF4C label=SetPixelAdjustments_Legs
  $BF4C,$03 Set the adjustments.
  $BF4F,$02 Jump to #R$BF77.
N $BF51 The adjustments of wall object
. #N$0D: #N$F4 in x and #N$F9 in y.
@ $BF51 label=SetPixelAdjustments_Wall_0D
  $BF51,$03 Set the adjustments.
  $BF54,$02 Jump to #R$BF77.
N $BF56 The adjustments of a block which
. is fat at the top: #N$F0 in x and #N$FA
. in y.
@ $BF56 label=SetPixelAdjustments_FatTop
  $BF56,$03 Set the adjustments.
  $BF59,$02 Jump to #R$BF77.
N $BF5B The adjustments of a mouse:
. #N$F4 in x and #N$FA in y.
@ $BF5B label=SetPixelAdjustments_Mouse
  $BF5B,$03 Set the adjustments.
  $BF5E,$02 Jump to #R$BF77.
N $BF60 The adjustments of a valve and of
. its ghost: #N$F4 in x and #N$FB in y.
@ $BF60 label=SetPixelAdjustments_Valve
  $BF60,$03 Set the adjustments.
  $BF63,$02 Jump to #R$BF77.
N $BF65 The adjustments of wall object
. #N$0F: #N$F8 in x and #N$FB in y.
@ $BF65 label=SetPixelAdjustments_Wall_0F
  $BF65,$03 Set the adjustments.
  $BF68,$02 Jump to #R$BF77.
N $BF6A The adjustments of sparkles,
. domes, a broken egg and a cryonaut:
. #N$F4 in x and #N$FC in y.
@ $BF6A label=SetPixelAdjustments_Sparkle
  $BF6A,$03 Set the adjustments.
  $BF6D,$02 Jump to #R$BF77.
N $BF6F The adjustments of the top half
. of the player: #N$F0 in x and #N$FD in
. y.
@ $BF6F label=SetPixelAdjustments_PlayerTop
  $BF6F,$03 Set the adjustments.
  $BF72,$02 Jump to #R$BF77.
N $BF74 The adjustments of wall object
. #N$0E: #N$FC in x and #N$FD in y.
@ $BF74 label=SetPixelAdjustments_Wall_0E
  $BF74,$03 Set the adjustments.
N $BF77 Store the adjustments in the object.
@ $BF77 label=SetPixelAdjustments_Store
  $BF77,$06 Set the pixel adjustments of the object.
  $BF7D,$01 Return.
N $BF7E The adjustments of an extra life:
. #N$F8 in x and #N$FE in y.
@ $BF7E label=SetPixelAdjustments_ExtraLife
  $BF7E,$03 Set the adjustments.
  $BF81,$02 Jump to #R$BF77.

c $BF83 Fill Window
@ $BF83 label=FillWindow
D $BF83 Fills a rectangle of the screen
. buffer, or of the attribute buffer, with
. a byte. The rows of the rectangle are
. #N$20 bytes apart. The loop is unrolled
. into eight stores, and the code jumps
. into the middle of them to store only as
. many bytes as the width of the rectangle
. (which can be no more than eight): the
. number of stores to skip is worked out
. and written into the operand of the jump
. at #R$BF95.
R $BF83 A Byte to fill the rectangle with
R $BF83 B Width of the rectangle in bytes
R $BF83 C Height of the rectangle in lines
R $BF83 HL Address of the first byte
N $BF83 Work out how many stores to skip.
  $BF83,$01 Stash the byte on the stack.
  $BF84,$01 Fetch the width.
  $BF85,$02 Make it negative.
  $BF87,$02,b$01 Keep only bits 0 to 2.
  $BF89,$01 Multiply it by two.
  $BF8A,$03 Write the offset to
. #R$BF95(#N$BF96).
  $BF8D,$02 Set #REGa to #N$20.
  $BF8F,$01 Subtract the width.
  $BF90,$01 Keep it in #REGe.
  $BF91,$02 Set #REGd to #N$00.
  $BF93,$01 Set #REGb to the height.
  $BF94,$01 Restore the byte from the stack.
N $BF95 Fill one line, then step to the
. next.
@ $BF95 label=FillWindow_Line
  $BF95,$02 Jump into the stores.
  $BF97,$01 Store the byte.
  $BF98,$01 Move on to the next byte.
  $BF99,$01 Store the byte.
  $BF9A,$01 Move on to the next byte.
  $BF9B,$01 Store the byte.
  $BF9C,$01 Move on to the next byte.
  $BF9D,$01 Store the byte.
  $BF9E,$01 Move on to the next byte.
  $BF9F,$01 Store the byte.
  $BFA0,$01 Move on to the next byte.
  $BFA1,$01 Store the byte.
  $BFA2,$01 Move on to the next byte.
  $BFA3,$01 Store the byte.
  $BFA4,$01 Move on to the next byte.
  $BFA5,$01 Store the byte.
  $BFA6,$01 Move on to the next byte.
  $BFA7,$01 Move on to the start of the next
. line.
  $BFA8,$02 Jump to #R$BF95 until all of the
. lines have been filled.
  $BFAA,$01 Return.

c $BFAB Set Wipe And Draw Flags
@ $BFAB label=SetWipeAndDrawFlags
D $BFAB Flags an object to be wiped and
. drawn again, and flags every other
. object that overlaps it to be drawn too.
E $BFAB View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C692 }
. { #PENTAGRAM$CCDE }
. LIST#
R $BFAB IX The address of the object
N $BFAB Set the wipe and draw bits, then
. flag overlaps.
  $BFAB,$03 Fetch the flags of the object.
  $BFAE,$02,b$01 Set bits 4 and 5.
  $BFB0,$03 Store the flags.
  $BFB3,$03 Jump to #R$C657.

c $BFB6 Apply Gravity And Move
@ $BFB6 label=ApplyGravityAndMove
D $BFB6 Makes an object fall faster, then
. moves it. #R$BFBC only moves the object.
E $BFB6 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C700 }
. { #PENTAGRAM$B979 }
. LIST#
R $BFB6 IX The address of the object
N $BFB6 Speed the fall, then stay clear of
. walls and other objects.
  $BFB6,$03 Take one off the z speed of the
. object.
  $BFB9,$03 Call #R$C442.
N $BFBC Add the speeds to the position.
@ $BFBC label=MoveObject
  $BFBC,$03 Fetch the x position of the
. object.
  $BFBF,$03 Add the speed along the x axis.
  $BFC2,$03 Set the new x position.
  $BFC5,$03 Fetch the y position of the
. object.
  $BFC8,$03 Add the speed along the y axis.
  $BFCB,$03 Set the new y position.
  $BFCE,$03 Fetch the z position of the
. object.
  $BFD1,$03 Add the speed along the z axis.
  $BFD4,$03 Set the new z position.
  $BFD7,$01 Return.

c $BFD8 Handle Far Arch
@ $BFD8 label=HandleFarArch
D $BFD8 The handler for the far side of
. an arch (object #N$03). It only needs to
. set the adjustments to the pixel
. position of the sprite, which are not
. the same when the sprite is flipped.
E $BFD8 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C722 }
. LIST#
R $BFD8 IX The address of the object
N $BFD8 Choose the adjustments from the
. flip flag.
  $BFD8,$06 Jump to #R$BFE4 if the sprite is flipped.
  $BFDE,$03 Set #REGhl to #N$FBF0.
  $BFE1,$03 Jump to #R$BF77.
@ $BFE4 label=HandleFarArch_Flipped
  $BFE4,$03 Set #REGhl to #N$FCF8.
  $BFE7,$03 Jump to #R$BF77.

c $BFEA Handle Near Arch
@ $BFEA label=HandleNearArch
D $BFEA The handler for the near side of
. an arch (object #N$02). As an arch does
. not move, its speeds are used to keep
. the position of the middle of the
. doorway: the middle is #N$0D further
. along the y axis than the arch, or #N$0D
. further back along the x axis if the
. sprite is flipped. The player is flagged
. if near the arch, and is nudged towards
. the middle of the doorway.
E $BFEA View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C73C }
. { #PENTAGRAM$C7AD }
. LIST#
R $BFEA IX The address of the object
N $BFEA Unflipped: doorway #N$0D along y.
  $BFEA,$06 Jump to #R$C013 if the sprite is flipped.
  $BFF0,$03 Set #REGhl to #N$F9FA.
  $BFF3,$03 Call #R$BF77.
  $BFF6,$03 Fetch the y position of the arch.
  $BFF9,$02 Add #N$0D.
  $BFFB,$03 Set it as the y of the doorway
. middle.
  $BFFE,$03 Fetch the x position of the arch.
  $C001,$03 Set it as the x of the doorway
. middle.
  $C004,$03 Set #REGhl to #N$060F.
N $C007 Keep z and flag or nudge the
. player.
@ $C007 label=HandleNearArch_Near
  $C007,$03 Fetch the z position of the arch.
  $C00A,$03 Set it as the z of the doorway
. middle.
  $C00D,$03 Call #R$C082.
  $C010,$03 Jump to #R$C02C.
N $C013 Flipped: doorway #N$0D back along
. x.
@ $C013 label=HandleNearArch_Flipped
  $C013,$03 Set #REGhl to #N$FAF6.
  $C016,$03 Call #R$BF77.
  $C019,$03 Fetch the x position of the arch.
  $C01C,$02 Subtract #N$0D.
  $C01E,$03 Set it as the x of the doorway
. middle.
  $C021,$03 Fetch the y position of the arch.
  $C024,$03 Set it as the y of the doorway
. middle.
  $C027,$03 Set #REGhl to #N$0F06.
  $C02A,$02 Jump to #R$C007.

c $C02C Nudge Player To Arch
@ $C02C label=NudgePlayerToArch
D $C02C Nudges the player towards the
. middle of the doorway of an arch, if
. close to it, by jumping to the routine
. for the direction of the arch (see
. #R$C048).
E $C02C View the equivalent code in;
. #LIST
. { #PENTAGRAM$C8D2 }
. LIST#
R $C02C IX The address of the arch object
N $C02C Test that the player is flagged
. to be adjusted and is near the doorway.
  $C02C,$03 Set #REGhl to #N$0F0F.
  $C02F,$04 Point #REGiy at #R$5B88.
  $C033,$03 Fetch the sprite number of the
. player.
  $C036,$02 Return if the slot is not used.
  $C038,$05 Return if the player is not flagged
. to be adjusted near arches.
  $C03D,$03 Call #R$C099.
  $C040,$01 Return if the player is not near.
N $C041 Jump by the direction of the
. arch.
  $C041,$01 Stash #REGbc on the stack.
  $C042,$03 Point #REGbc at #R$C048.
  $C045,$03 Jump to #R$C312.

w $C048 Arch Direction Table
@ $C048 label=ArchDirectionTable
D $C048 The routines that nudge the
. player towards the middle of a doorway,
. by the direction of the arch (see
. #R$C319).
W $C048,$04,$02 Arch not flipped: #R$C050.
W $C04C,$04,$02 Arch flipped: #R$C069.

c $C050 Nudge Player East West
@ $C050 label=NudgePlayerEastWest
D $C050 Sets the adjustment to the speed
. of the player along the y axis, to bring
. the player a step closer to the middle
. line of an arch that goes east and west.
. Nothing is done if the sprite of the
. player is flipped.
E $C050 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C7B1 }
. { #PENTAGRAM$C907 }
. LIST#
R $C050 IX The address of the arch object
R $C050 IY The address of the player
N $C050 Skip if flipped or already in the
. middle.
  $C050,$06 Jump to #R$C080 if the player is flipped.
  $C056,$03 Fetch the y of the doorway
. middle.
  $C059,$05 Jump to #R$C080 if the player is
. in the middle.
N $C05E Step toward the middle along y.
  $C05E,$02 Set #REGa to #N$01.
  $C060,$02 Jump to #R$C064 if carry is not
. set.
  $C062,$02 Negate #REGa.
@ $C064 label=NudgePlayerEastWest_Set
  $C064,$03 Set the y-speed adjustment of
. the player.
  $C067,$02 Jump to #R$C080.

c $C069 Nudge Player North South
@ $C069 label=NudgePlayerNorthSouth
D $C069 Sets the adjustment to the speed
. of the player along the x axis, to bring
. the player a step closer to the middle
. line of an arch that goes north and
. south. Nothing is done unless the sprite
. of the player is flipped.
R $C069 IX The address of the arch object
R $C069 IY The address of the player
N $C069 Skip if not flipped or already in
. the middle.
  $C069,$06 Jump to #R$C080 if the player is not flipped.
  $C06F,$03 Fetch the x of the doorway
. middle.
  $C072,$05 Jump to #R$C080 if the player is
. in the middle.
N $C077 Step toward the middle along x.
  $C077,$02 Set #REGa to #N$01.
  $C079,$02 Jump to #R$C07D if carry is not
. set.
  $C07B,$02 Negate #REGa.
@ $C07D label=NudgePlayerNorthSouth_Set
  $C07D,$03 Set the x-speed adjustment of
. the player.
@ $C080 label=NudgePlayerNorthSouth_Done
N $C080 Finish the nudge.
  $C080,$01 Restore #REGbc from the stack.
  $C081,$01 Return.

c $C082 Flag Player Near Arch
@ $C082 label=FlagPlayerNearArch
D $C082 Flags the player as being near an
. arch (bit 0 of the flags), if close to
. the middle of the doorway.
R $C082 H Reach along the y axis
R $C082 L Reach along the x axis
R $C082 IX The address of the arch object
N $C082 Test that the player is flagged
. to be adjusted and is near the doorway.
  $C082,$04 Point #REGiy at #R$5B88.
  $C086,$03 Fetch the sprite number of the
. player.
  $C089,$02 Return if the slot is not used.
  $C08B,$05 Return if the player is not flagged
. to be adjusted near arches.
  $C090,$03 Call #R$C099.
  $C093,$01 Return if the player is not near.
  $C094,$04 Flag the player as near an arch.
  $C098,$01 Return.

c $C099 Test Near To
@ $C099 label=TestNearTo
D $C099 Tests whether an object is close
. to the point that the arch keeps as the
. middle of its doorway: less than #REGl
. away along the x axis, less than #REGh
. away along the y axis and less than
. #N$04 away along the z axis.
E $C099 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C7FE }
. { #PENTAGRAM$C8AD }
. LIST#
R $C099 H Reach along the y axis
R $C099 L Reach along the x axis
R $C099 IX The address of the arch object
R $C099 IY The address of the object
R $C099 O:F Carry flag set if the object is near
N $C099 Compare along x.
  $C099,$03 Fetch the x of the doorway
. middle.
  $C09C,$03 Subtract the x of the object.
  $C09F,$02 Jump to #R$C0A3 if carry is not
. set.
  $C0A1,$02 Negate #REGa.
@ $C0A3 label=TestNearTo_Y
  $C0A3,$02 Return if the object is too far
. along the x axis.
N $C0A5 Compare along y.
  $C0A5,$03 Fetch the y of the doorway
. middle.
  $C0A8,$03 Subtract the y of the object.
  $C0AB,$02 Jump to #R$C0AF if carry is not
. set.
  $C0AD,$02 Negate #REGa.
@ $C0AF label=TestNearTo_Z
  $C0AF,$02 Return if the object is too far
. along the y axis.
N $C0B1 Compare along z against #N$04.
  $C0B1,$03 Fetch the z of the doorway
. middle.
  $C0B4,$03 Subtract the z of the object.
  $C0B7,$02 Jump to #R$C0BB if carry is not
. set.
  $C0B9,$02 Negate #REGa.
@ $C0BB label=TestNearTo_Done
  $C0BB,$02 Compare it with #N$04.
  $C0BD,$01 Return.

c $C0BE Handle Player Legs
@ $C0BE label=HandlePlayerLegs
D $C0BE The handler for the lower half of
. the robot while it is walking (objects
. #N$10 to #N$17). The upper half of the
. player is only a copy of this one placed
. above it (see #R$C6E4), so this routine
. does all of the work for the player. If
. the player has been killed it is turned
. into a sparkle. Otherwise the input is
. read, the pickup and drop, turning,
. jumping and walking are dealt with, and
. the player is moved. While the player is
. outside the room (walking through an
. exit) it can fall but is not allowed to
. rise.
E $C0BE View the equivalent code in;
. #LIST
. { #PENTAGRAM$C440 }
. LIST#
R $C0BE IX The address of the object
N $C0BE Turn into a sparkle if killed.
  $C0BE,$03 Call #R$BF4C.
  $C0C1,$06 Jump to #R$C0CE if the player has not been killed.
  $C0C7,$04 Set bit 6 of the top half extra
. flags.
  $C0CB,$03 Jump to #R$B39A.
N $C0CE Make the bottom half as tall as
. the whole player while it moves.
@ $C0CE label=HandlePlayerLegs_Alive
  $C0CE,$04 Set the height of the bottom
. half to #N$17.
  $C0D2,$04 Write #N$00 to the height of the
. top half.
  $C0D6,$03 Call #R$C8FF.
  $C0D9,$03 Call #R$BD6B.
  $C0DC,$03 Call #R$C13C.
  $C0DF,$03 Call #R$C23D.
  $C0E2,$03 Call #R$C25E.
  $C0E5,$05 Jump to #R$C10A if the player is
. not inside the room.
N $C0EA Ignore the top half while the
. player moves.
@ $C0EA label=HandlePlayerLegs_Move
  $C0EA,$04 Set bit 1 of the top half
. flags.
  $C0EE,$03 Call #R$C296.
  $C0F1,$04 Reset bit 1 of the top half
. flags.
  $C0F5,$03 Fetch the collision flags.
  $C0F8,$02 Subtract #N$10.
  $C0FA,$02 Jump to #R$C0FF if carry is set.
  $C0FC,$03 Store the collision flags.
N $C0FF Restore the two heights and draw.
@ $C0FF label=HandlePlayerLegs_Draw
  $C0FF,$04 Set the height of the bottom
. half to #N$0C.
  $C103,$04 Set the height of the top half
. to #N$0B.
  $C107,$03 Jump to #R$BFAB.
N $C10A The player is outside the room.
@ $C10A label=HandlePlayerLegs_Outside
  $C10A,$03 Fetch the speed along the z
. axis.
  $C10D,$04 Jump to #R$C0EA if the player is
. falling.
  $C111,$04 Write #N$00 to the speed along
. the z axis.
  $C115,$02 Jump to #R$C0EA.

c $C117 Test Player In Room
@ $C117 label=TestPlayerInRoom
D $C117 Tests whether the player is
. inside the room. The distance from the
. middle of the room (#N$80) has to be
. smaller than the distance to the wall,
. less the width of the player along x and
. less the depth of the player along y.
E $C117 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C87A }
. { #PENTAGRAM$C4A3 }
. LIST#
R $C117 IX The address of the object
R $C117 O:F Carry flag set if the player is inside the room
N $C117 Limits from the wall distances.
  $C117,$03 Fetch #R$5B0B and #R$5B0C.
  $C11A,$01 Copy the distance along x to
. #REGa.
  $C11B,$03 Subtract the width of the
. player.
  $C11E,$01 Store the limit along x in
. #REGl.
  $C11F,$01 Copy the distance along y to
. #REGa.
  $C120,$03 Subtract the depth of the
. player.
  $C123,$01 Store the limit along y in
. #REGh.
N $C124 Compare the x distance from the
. middle.
  $C124,$03 Fetch the x position of the
. player.
  $C127,$02 Subtract #N$80.
  $C129,$03 Jump to #R$C12E if the sign flag
. is clear.
  $C12C,$02 Negate #REGa.
@ $C12E label=TestPlayerInRoom_LimitX
  $C12E,$02 Return if the player is outside
. along x.
N $C130 Compare the y distance from the
. middle.
  $C130,$03 Fetch the y position of the
. player.
  $C133,$02 Subtract #N$80.
  $C135,$03 Jump to #R$C13A if the sign flag
. is clear.
  $C138,$02 Negate #REGa.
@ $C13A label=TestPlayerInRoom_LimitY
  $C13A,$01 Compare it with the limit along
. y.
  $C13B,$01 Return.

c $C13C Handle Turning
@ $C13C label=HandleTurning
D $C13C Turns the player to face the
. direction that was asked for. Where a
. joystick with directional control is in
. use the walk control is set when the
. player is already facing the direction
. that is pressed, and otherwise the
. player is turned. With the other methods
. of control the left and right controls
. turn the player. The routine returns
. early while the player is entering the
. room, jumping or not standing on
. something.
.
. Turning starts by showing one of the
. sprites of objects #N$18 to #N$1B (see
. #R$C1D2 and #R$C1DA); #R$C1E2 finishes
. the turn.
E $C13C Continue on to #R$C1BD.
E $C13C View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C89F }
. { #PENTAGRAM$C4C8 }
. LIST#
R $C13C C The controls
R $C13C IX The address of the object
R $C13C O:C The controls, with the walk control changed
N $C13C Use rotational control unless a
. joystick is directional.
  $C13C,$03 Point #REGhl at #R$5B04.
  $C13F,$01 Fetch it.
  $C140,$02,b$01 Keep only bits 1 and 2.
  $C142,$02 Jump to #R$C18F if they are
. zero.
  $C144,$04 Jump to #R$C18F if directional
. control is off.
N $C148 Directional control. The player
. cannot turn while entering the room, or
. while it is not standing on something.
  $C148,$03 Fetch the collision flags.
  $C14B,$02,b$01 Keep only bits 4-7.
  $C14D,$01 Return if the player is entering the room.
  $C14E,$05 Return if the player is in the air.
N $C153 Find the direction that is
. pressed. Left (west) is tried before up
. (north). Down is bit 4 of the controls.
  $C153,$04 Jump to #R$C15B if left is
. pressed.
  $C157,$04 Jump to #R$C16A if up is
. pressed.
@ $C15B label=HandleTurning_Right
  $C15B,$04 Jump to #R$C176 if right is
. pressed.
  $C15F,$04 Jump to #R$C17D if down is
. pressed.
  $C163,$04 Jump to #R$C186 if left is
. pressed.
  $C167,$02 Clear the walk control, as no
. direction is pressed.
  $C169,$01 Return.
N $C16A The facing of the player is #N$00
. west, #N$01 east, #N$02 north and #N$03
. south. If the player already faces the
. direction that is pressed, the walk
. control is set. Otherwise bit 0 of the
. direction (inverted for north and east)
. chooses which way to turn.
@ $C16A label=HandleTurning_North
  $C16A,$05 Test whether the player is facing north.
@ $C16F label=HandleTurning_Facing
  $C16F,$02 Jump to #R$C18C if it is.
  $C171,$01 Invert the direction.
@ $C172 label=HandleTurning_Turn
  $C172,$02,b$01 Keep bit 0, which decides
. which way to turn.
  $C174,$02 Jump to #R$C1A0.
@ $C176 label=HandleTurning_East
  $C176,$05 Test whether the player is facing east.
  $C17B,$02 Jump to #R$C16F.
@ $C17D label=HandleTurning_South
  $C17D,$05 Test whether the player is facing south.
@ $C182 label=HandleTurning_TestFacing
  $C182,$02 Jump to #R$C18C if it is.
  $C184,$02 Jump to #R$C172.
@ $C186 label=HandleTurning_West
  $C186,$04 Test whether the player is facing west.
  $C18A,$02 Jump to #R$C182.
@ $C18C label=HandleTurning_Walk
  $C18C,$02 Set the walk control, as the
. player is facing the direction that is
. pressed.
  $C18E,$01 Return.
N $C18F Rotational control. The player
. cannot turn while entering the room or
. while jumping.
@ $C18F label=HandleTurning_Rotate
  $C18F,$01 Copy #REGc to #REGa.
  $C190,$02,b$01 Keep only bits 0 and 1.
  $C192,$01 Return if they are zero.
  $C193,$03 Fetch the collision flags.
  $C196,$02,b$01 Keep only bits 4-7.
  $C198,$01 Return if the player is entering the room.
  $C199,$05 Return if the player is jumping.
  $C19E,$02 Test the right control.
@ $C1A0 label=HandleTurning_Start
  $C1A0,$02 Jump to #R$C1AB if the player is to turn right.
  $C1A2,$04 Reset bit 0 of the extra flags.
  $C1A6,$03 Point #REGhl at #R$C1DA.
  $C1A9,$02 Jump to #R$C1B2.
@ $C1AB label=HandleTurning_TurnRight
  $C1AB,$04 Set bit 0 of the extra flags.
  $C1AF,$03 Point #REGhl at #R$C1D2.
@ $C1B2 label=HandleTurning_SetSprite
  $C1B2,$03 Fetch the extra flags.
  $C1B5,$02,b$01 Set bit 1.
  $C1B7,$03 Store the extra flags.
  $C1BA,$03 Call #R$C319.

c $C1BD Set Sprite From Table
@ $C1BD label=SetSpriteFromTable
D $C1BD Sets the sprite of the player and
. its flip flag from a table of pairs of
. bytes. The entry is picked by the lowest
. two bits of #REGa.
R $C1BD A The index into the table
R $C1BD HL The address of the table
R $C1BD IX The address of the object
N $C1BD Pick the pair and set the sprite.
  $C1BD,$01 Double the index.
  $C1BE,$02,b$01 Keep only bits 1 and 2.
  $C1C0,$03 Call #R$CE06.
  $C1C3,$01 Fetch the sprite number.
  $C1C4,$01 Move on to the flags.
  $C1C5,$03 Set the sprite number.
  $C1C8,$03 Fetch the flags of the player.
  $C1CB,$02,b$01 Clear bit 6.
  $C1CD,$01 Merge the flags from the table.
  $C1CE,$03 Store the flags.
  $C1D1,$01 Return.

b $C1D2 Turning Right Sprite Table
@ $C1D2 label=TurningRightSpriteTable
D $C1D2 The sprite number and the flags
. of the player when it starts to turn
. right, picked by the direction that the
. player is facing (see #R$C319). The
. sprite is one of objects #N$18 to #N$1B.
B $C1D2,$02,$02 Facing west: sprite #N($18),
. not flipped.
B $C1D4,$02,$02 Facing east: sprite #N($19),
. not flipped.
B $C1D6,$02,$02 Facing north: sprite
. #N($1A), not flipped.
B $C1D8,$02,$02 Facing south: sprite
. #N($1B), flipped.

b $C1DA Turning Left Sprite Table
@ $C1DA label=TurningLeftSpriteTable
D $C1DA The sprite number and the flags
. of the player when it starts to turn
. left, picked by the direction that the
. player is facing (see #R$C319). The
. sprite is one of objects #N$18 to #N$1B.
B $C1DA,$02,$02 Facing west: sprite #N($1B),
. flipped.
B $C1DC,$02,$02 Facing east: sprite #N($1A),
. not flipped.
B $C1DE,$02,$02 Facing north: sprite
. #N($18), not flipped.
B $C1E0,$02,$02 Facing south: sprite
. #N($19), not flipped.

c $C1E2 Handle Turning Legs
@ $C1E2 label=HandleTurningLegs
D $C1E2 The handler for the lower half of
. the robot while it is turning (objects
. #N$18 to #N$1B). The turn takes two
. passes: the first counts the turn down
. while the player is moved, and the
. second sets the sprite that the player
. ends up with (see #R$C22D and #R$C235)
. and plays a footstep.
R $C1E2 C The controls
R $C1E2 IX The address of the object
N $C1E2 Count the turn down and move.
  $C1E2,$03 Call #R$BF4C.
  $C1E5,$04 Set the height of the bottom
. half to #N$17.
  $C1E9,$04 Write #N$00 to the height of the
. top half.
  $C1ED,$03 Call #R$C8FF.
  $C1F0,$03 Fetch the extra flags.
  $C1F3,$02,b$01 Keep only bits 1 and 2.
  $C1F5,$02 Jump to #R$C208 if they are
. zero.
  $C1F7,$03 Fetch the extra flags.
  $C1FA,$02 Subtract #N$02.
  $C1FC,$03 Store the extra flags.
  $C1FF,$04 Set bit 1 of the top half
. flags.
  $C203,$03 Call #R$C2BC.
  $C206,$02 Jump to #R$C221.
N $C208 Finish the turn with the new
. sprite.
@ $C208 label=HandleTurningLegs_Finish
  $C208,$06 Jump to #R$C228 if bit 0 of the
. extra flags is clear.
  $C20E,$03 Point #REGhl at #R$C22D.
@ $C211 label=HandleTurningLegs_Set
  $C211,$03 Fetch the sprite number of the
. player.
  $C214,$03 Call #R$C1BD.
  $C217,$03 Call #R$B6D4.
  $C21A,$04 Set bit 1 of the top half
. flags.
  $C21E,$03 Call #R$C2B3.
@ $C221 label=HandleTurningLegs_Done
  $C221,$04 Reset bit 1 of the top half
. flags.
  $C225,$03 Jump to #R$C0FF.
@ $C228 label=HandleTurningLegs_Left
  $C228,$03 Point #REGhl at #R$C235.
  $C22B,$02 Jump to #R$C211.

b $C22D Turned Right Sprite Table
@ $C22D label=TurnedRightSpriteTable
D $C22D The sprite number and the flags
. of the player when it has finished
. turning right, picked by the sprite that
. it turned with (objects #N$18 to #N$1B).
B $C22D,$02,$02 From #N$18: sprite #N($11),
. flipped.
B $C22F,$02,$02 From #N$19: sprite #N($15),
. flipped.
B $C231,$02,$02 From #N$1A: sprite #N($15),
. not flipped.
B $C233,$02,$02 From #N$1B: sprite #N($11),
. not flipped.

b $C235 Turned Left Sprite Table
@ $C235 label=TurnedLeftSpriteTable
D $C235 The sprite number and the flags
. of the player when it has finished
. turning left, picked by the sprite that
. it turned with (objects #N$18 to #N$1B).
B $C235,$02,$02 From #N$18: sprite #N($11),
. not flipped.
B $C237,$02,$02 From #N$19: sprite #N($15),
. not flipped.
B $C239,$02,$02 From #N$1A: sprite #N($11),
. flipped.
B $C23B,$02,$02 From #N$1B: sprite #N($15),
. flipped.

c $C23D Handle Jump
@ $C23D label=HandleJump
D $C23D Makes the player jump if the jump
. control is pressed. The player cannot
. jump while entering a room, while
. already jumping, or while falling
. quickly.
E $C23D View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C948 }
. LIST#
R $C23D C The controls
R $C23D IX The address of the object
N $C23D Return unless a jump is allowed.
  $C23D,$03 Return if the jump control is not pressed.
  $C240,$03 Fetch the collision flags.
  $C243,$02,b$01 Keep only bits 4-7.
  $C245,$01 Return if the player is entering the room.
  $C246,$05 Return if the player is already jumping.
  $C24B,$03 Fetch the speed along the z
. axis.
  $C24E,$01 Increment #REGa.
  $C24F,$01 Return if the sign flag is set.
N $C250 Start the jump.
  $C250,$04 Flag the player as jumping.
  $C254,$04 Set the speed along the z axis
. to #N$08.
  $C258,$01 Stash #REGbc on the stack.
  $C259,$03 Call #R$B62C.
  $C25C,$01 Restore #REGbc from the stack.
  $C25D,$01 Return.

c $C25E Handle Walking
@ $C25E label=HandleWalking
D $C25E Animates the legs of the player,
. with a footstep sound, while the player
. is walking, entering the room or
. jumping. The frame of the animation is
. in the lowest two bits of the sprite
. number. When the player stops walking
. the legs carry on until they reach frame
. #N($01), where the feet are together. The
. routine does nothing while the player is
. turning (objects #N$18 to #N$1B).
E $C25E View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C969 }
. LIST#
R $C25E C The controls
R $C25E IX The address of the object
N $C25E Return while turning.
  $C25E,$03 Fetch the sprite number of the
. player.
  $C261,$02 Subtract #N$18.
  $C263,$03 Return if the player is turning.
N $C266 Step while entering, jumping or
. walking.
  $C266,$03 Fetch the collision flags.
  $C269,$02,b$01 Keep only bits 4-7.
  $C26B,$02 Jump to #R$C277 if the player is
. entering the room.
  $C26D,$06 Jump to #R$C277 if the player is jumping.
  $C273,$04 Jump to #R$C28C if bit 2 of
. #REGc is clear.
@ $C277 label=HandleWalking_Step
  $C277,$01 Stash #REGbc on the stack.
  $C278,$03 Call #R$B6CE.
  $C27B,$01 Restore #REGbc from the stack.
N $C27C Go on to the next frame, which is
. #N$00 to #N$03.
@ $C27C label=HandleWalking_Animate
  $C27C,$03 Fetch the sprite number of the
. player.
  $C27F,$01 Copy it to #REGe.
  $C280,$01 Increment #REGa.
  $C281,$02,b$01 Keep only bits 0 and 1.
  $C283,$01 Copy the frame to #REGd.
  $C284,$01 Copy #REGe to #REGa.
  $C285,$02,b$01 Keep only bits 2-7.
  $C287,$01 Merge the new frame.
  $C288,$03 Set the sprite number of the
. player.
  $C28B,$01 Return.
@ $C28C label=HandleWalking_Stop
  $C28C,$03 Fetch the sprite number of the
. player.
  $C28F,$02,b$01 Keep only bits 0 and 1.
  $C291,$03 Return if it is #N$01.
  $C294,$02 Jump to #R$C27C.

c $C296 Move Player
@ $C296 label=MovePlayer
D $C296 Moves the player by one frame.
. The speeds along x and y are only set up
. while the player walks, is jumping or is
. entering the room, and they are cleared
. again afterwards. The speed along z has
. gravity taken off it, which is more if
. the player is not rising with the jump
. control held down. If the player lands
. the jump is over.
E $C296 Continue on to #R$C2EE.
E $C296 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C9A1 }
. { #PENTAGRAM$C61D }
. LIST#
R $C296 C The controls
R $C296 IX The address of the object
N $C296 Drop if the game is over.
  $C296,$03 Fetch #R$5B24.
  $C299,$03 Jump to #R$C2A0 if the game is not over.
  $C29C,$04 Set the speed along the z axis
. to #N$02.
N $C2A0 Set the walk speeds unless the
. player is turning.
@ $C2A0 label=MovePlayer_Speed
  $C2A0,$06 Jump to #R$C2B7 if the player is jumping.
  $C2A6,$03 Fetch the collision flags.
  $C2A9,$02,b$01 Keep only bits 4-7.
  $C2AB,$02 Jump to #R$C2B7 if the player is
. entering the room.
  $C2AD,$06 Jump to #R$C2BC if bit 3 of the
. sprite number is set.
@ $C2B3 label=MovePlayer_WalkControl
  $C2B3,$04 Jump to #R$C2BC if bit 2 of
. #REGc is clear.
@ $C2B7 label=MovePlayer_Forward
  $C2B7,$01 Stash #REGbc on the stack.
  $C2B8,$03 Call #R$C2F6.
  $C2BB,$01 Restore #REGbc from the stack.
N $C2BC Gravity takes one off the speed
. along z when the player is rising with
. the jump control held down, and two
. otherwise.
@ $C2BC label=MovePlayer_Gravity
  $C2BC,$03 Fetch the speed along the z
. axis.
  $C2BF,$04 Jump to #R$C2C7 if the player is
. falling.
  $C2C3,$04 Jump to #R$C2C8 if bit 3 of
. #REGc is set.
@ $C2C7 label=MovePlayer_Fall
  $C2C7,$01 Decrement #REGa.
@ $C2C8 label=MovePlayer_Store
  $C2C8,$01 Decrement #REGa.
  $C2C9,$03 Store the speed along the z
. axis.
  $C2CC,$03 Set #R$5B21.
  $C2CF,$02 Add #N$02.
  $C2D1,$03 Call #R$B63C if the sign flag is
. set.
  $C2D4,$03 Call #R$C442.
  $C2D7,$03 Call #R$C36D.
  $C2DA,$03 Call #R$BFBC.
  $C2DD,$06 Jump to #R$C2EE if the player is in the air.
  $C2E3,$03 Fetch #R$5B21.
  $C2E6,$04 Jump to #R$C2EE if the player
. was rising.
  $C2EA,$04 Clear the jumping flag.

c $C2EE Clear Speed
@ $C2EE label=ClearSpeed
D $C2EE Sets the speeds of the object
. along the x and y axes to zero.
R $C2EE IX The address of the object
  $C2EE,$07 Write #N$00 to the speeds along
. x and y.
  $C2F5,$01 Return.

c $C2F6 Set Player Speed
@ $C2F6 label=SetPlayerSpeed
D $C2F6 Sets the speeds along x and y of
. the player to walk forward. The
. adjustments of the speeds that arches
. make to nudge the player into doorways
. are added first, then the speed of #N$03
. in the direction that the player is
. facing.
E $C2F6 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C9FB }
. { #PENTAGRAM$C66A }
. LIST#
R $C2F6 IX The address of the object
N $C2F6 Add the doorway nudges.
  $C2F6,$03 Fetch the speed along the x
. axis.
  $C2F9,$03 Add the adjustment along x.
  $C2FC,$03 Store the speed along the x
. axis.
  $C2FF,$03 Fetch the speed along the y
. axis.
  $C302,$03 Add the adjustment along y.
  $C305,$03 Store the speed along the y
. axis.
  $C308,$07 Write #N$00 to the adjustments
. along x and y.
N $C30F Jump by the facing direction.
  $C30F,$03 Point #REGbc at #R$C32F.
@ $C312 label=SetPlayerSpeed_Direction
  $C312,$03 Call #R$C319.
  $C315,$01 Copy it to #REGl.
  $C316,$03 Jump to #R$A6B7.

c $C319 Get Facing Direction
@ $C319 label=GetFacingDirection
D $C319 Works out the direction that an
. object is facing from the horizontal
. flip flag and bit 2 of the sprite
. number: bit 6 of the flags of the object
. is made into bit 1 of the direction, and
. bit 2 of the sprite number into bit 0.
. The direction is #N$00 west, #N$01 east,
. #N$02 north and #N$03 south.
E $C319 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA1E }
. { #PENTAGRAM$C5BD }
. LIST#
R $C319 IX The address of the object
R $C319 O:A The direction
N $C319 Bit 6 of the flags to bit 1.
  $C319,$01 Stash #REGhl on the stack.
  $C31A,$03 Fetch the flags of the object.
  $C31D,$03 Rotate bit 6 into bit 3.
  $C320,$02,b$01 Keep only bit 3.
  $C322,$01 Copy it to #REGl.
N $C323 Bit 2 of the sprite to bit 0.
  $C323,$03 Fetch the sprite number of the
. object.
  $C326,$02,b$01 Keep only bit 2.
  $C328,$01 Merge #REGl.
  $C329,$02 Rotate the two bits into place.
  $C32B,$02,b$01 Keep only bits 0 and 1.
  $C32D,$01 Restore #REGhl from the stack.
  $C32E,$01 Return.

w $C32F Player Movement Table
@ $C32F label=PlayerMovementTable
D $C32F The routines that set the speed
. of the player, by the direction that the
. player is facing (see #R$C319).
W $C32F,$02,$02 Facing west: #R$C337.
W $C331,$02,$02 Facing east: #R$C340.
W $C333,$02,$02 Facing north: #R$C347.
W $C335,$02,$02 Facing south: #R$C350.

c $C337 Move Player West
@ $C337 label=MovePlayerWest
D $C337 Takes #N$03 off the speed along
. the x axis of the object.
E $C337 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA3A }
. { #PENTAGRAM$C695 }
. LIST#
R $C337 IX The address of the object
  $C337,$03 Fetch the speed along the x
. axis.
  $C33A,$02 Add #N$FD.
@ $C33C label=MovePlayer_SetX
  $C33C,$03 Store the speed along the x
. axis.
  $C33F,$01 Return.

c $C340 Move Player East
@ $C340 label=MovePlayerEast
D $C340 Adds #N$03 to the speed along the
. x axis of the object.
E $C340 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA43 }
. { #PENTAGRAM$C69E }
. LIST#
R $C340 IX The address of the object
  $C340,$03 Fetch the speed along the x
. axis.
  $C343,$02 Add #N$03.
  $C345,$02 Jump to #R$C33C.

c $C347 Move Player North
@ $C347 label=MovePlayerNorth
D $C347 Adds #N$03 to the speed along the
. y axis of the object.
E $C347 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA4A }
. { #PENTAGRAM$C6A5 }
. LIST#
R $C347 IX The address of the object
  $C347,$03 Fetch the speed along the y
. axis.
  $C34A,$02 Add #N$03.
@ $C34C label=MovePlayer_SetY
  $C34C,$03 Store the speed along the y
. axis.
  $C34F,$01 Return.

c $C350 Move Player South
@ $C350 label=MovePlayerSouth
D $C350 Takes #N$03 off the speed along
. the y axis of the object.
E $C350 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA53 }
. { #PENTAGRAM$C6AE }
. LIST#
R $C350 IX The address of the object
  $C350,$03 Fetch the speed along the y
. axis.
  $C353,$02 Add #N$FD.
  $C355,$02 Jump to #R$C34C.

c $C357 Stop Object At Floor
@ $C357 label=StopObjectAtFloor
D $C357 Stops an object from going
. through the floor. If the z position of
. the object after it has moved is below
. the floor of the room, the object is
. flagged as blocked along z, and its
. speed along z is brought closer to zero
. until the object no longer goes through
. the floor.
E $C357 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA5A }
. { #PENTAGRAM$B963 }
. LIST#
R $C357 H Speed along the z axis
R $C357 IX The address of the object
R $C357 O:H The new speed along the z axis
N $C357 Test the floor and slow z.
  $C357,$03 Fetch #R$5B0E.
  $C35A,$01 Copy it to #REGd.
@ $C35B label=StopObjectAtFloor_Test
  $C35B,$03 Fetch the z position of the
. object.
  $C35E,$03 Return if the object does not
. end up below the floor.
  $C361,$04 Set bit 2 of the collision
. flags.
  $C365,$01 Copy #REGh to #REGa.
  $C366,$03 Call #R$C386.
  $C369,$01 Copy it to #REGh.
  $C36A,$02 Jump to #R$C35B if it is not
. zero.
  $C36C,$01 Return.

c $C36D Handle Room Exit
@ $C36D label=HandleRoomExit
D $C36D Sends the player to the next room
. if it has walked out through an arch.
. Only a player that is near an arch can
. leave the room, and not while it is
. still entering the room. The edge that
. counts is the one in the direction that
. the player is facing.
E $C36D View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA70 }
. LIST#
R $C36D IX The address of the object
N $C36D Return unless near an arch and
. not entering.
  $C36D,$03 Fetch the collision flags.
  $C370,$02,b$01 Keep only bits 4-7.
  $C372,$01 Return if the player is entering the room.
  $C373,$05 Return if the player is not near an arch.
  $C378,$04 Clear the near-an-arch flag.
  $C37C,$03 Point #REGbc at #R$C38F.
  $C37F,$03 Fetch #R$5B0B and #R$5B0C.
  $C382,$01 Stash #REGhl on the stack.
  $C383,$03 Jump to #R$C312.

c $C386 Bring Speed Closer To Zero
@ $C386 label=BringSpeedCloserToZero
D $C386 Takes one off the size of a
. speed.
E $C386 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA89 }
. { #PENTAGRAM$B95A }
. LIST#
R $C386 A The speed
R $C386 O:A The new speed
R $C386 O:F Zero flag set if the speed is zero
  $C386,$02 Return if the speed is zero.
  $C388,$03 Jump to #R$C38D if the sign flag
. is clear.
  $C38B,$02 Add two to the negative speed.
@ $C38D label=BringSpeedCloserToZero_Step
  $C38D,$01 Decrement #REGa.
  $C38E,$01 Return.

w $C38F Room Exit Table
@ $C38F label=RoomExitTable
D $C38F The routines that take the player
. to the next room, by the direction that
. the player is facing (see #R$C319).
W $C38F,$02,$02 Facing west: #R$C397.
W $C391,$02,$02 Facing east: #R$C3F0.
W $C393,$02,$02 Facing north: #R$C40B.
W $C395,$02,$02 Facing south: #R$C426.

c $C397 Leave Room To The West
@ $C397 label=LeaveRoomToWest
D $C397 Sends the player to the room to
. the west if it has gone past the west
. edge of the room. The x position is set
. to #N($00), which #R$CC01 takes as the
. sign that the player has come out of the
. west and puts it at the east side of the
. new room.
E $C397 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA9A }
. LIST#
R $C397 HL Distances to the walls along x and y
R $C397 IX The address of the object
N $C397 Leave if past the west edge.
  $C397,$01 Restore #REGhl from the stack.
  $C398,$02 Set #REGa to #N$80.
  $C39A,$01 Subtract #REGl.
  $C39B,$01 Copy it to #REGl.
  $C39C,$03 Fetch the x position of the
. player.
  $C39F,$03 Add the speed along the x axis.
  $C3A2,$03 Add the width of the player.
  $C3A5,$02 Return if the player is still in
. the room.
  $C3A7,$04 Write #N$00 to the x position.
  $C3AB,$03 Fetch the room number.
  $C3AE,$01 Copy it to #REGl.
  $C3AF,$01 Decrement #REGa.
N $C3B0 Change the column. The room
. number has the row in the high nibble
. and the column in the low nibble.
@ $C3B0 label=ChangeRoomEastWest
  $C3B0,$02,b$01 Keep only bits 0-3.
  $C3B2,$01 Copy it to #REGh.
  $C3B3,$01 Copy #REGl to #REGa.
  $C3B4,$02,b$01 Keep only bits 4-7.
  $C3B6,$01 Merge #REGh.
N $C3B7 Change the room of the player.
. Bit 6 of the collision flags starts the
. entering-room counter at #N$04. If the
. object is the player then it is copied
. and replaced by sparkles, and the game
. loop is started again.
@ $C3B7 label=ChangeRoom
  $C3B7,$03 Store the room number.
  $C3BA,$03 Fetch the collision flags.
  $C3BD,$02,b$01 Set bit 6.
  $C3BF,$03 Store the collision flags.
  $C3C2,$03 Fetch the sprite number of the
. object.
  $C3C5,$02 Subtract #N$10.
  $C3C7,$03 Return if it is not the player.
  $C3CA,$04 Drop two return addresses from
. the stack.
  $C3CE,$03 Copy #REGix to #REGhl (using
. the stack).
  $C3D1,$03 Point #REGde at #R$CA1D.
  $C3D4,$03 Set #REGbc to #N($0040,$04,$04).
  $C3D7,$02 Copy the player.
N $C3D9 Remember the sprites, then turn
. the copy into sparkles.
  $C3D9,$03 Fetch the sprite of the bottom half.
  $C3DC,$03 Keep it as the sprite that the bottom half will appear as.
  $C3DF,$03 Fetch the sprite of the top half.
  $C3E2,$03 Keep it as the sprite that the top half will appear as.
  $C3E5,$08 Write #N$38 to #R$CA1D and
. #R$CA3D.
  $C3ED,$03 Jump to #R$A68B.

c $C3F0 Leave Room To The East
@ $C3F0 label=LeaveRoomToEast
D $C3F0 Sends the player to the room to
. the east if it has gone past the east
. edge of the room. The x position is set
. to #N($FF), which #R$CC01 takes as the
. sign that the player has come out of the
. east and puts it at the west side of the
. new room.
E $C3F0 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CAF3 }
. LIST#
R $C3F0 HL Distances to the walls along x and y
R $C3F0 IX The address of the object
N $C3F0 Leave if past the east edge.
  $C3F0,$01 Restore #REGhl from the stack.
  $C3F1,$01 Copy #REGl to #REGa.
  $C3F2,$02 Add #N$80.
  $C3F4,$01 Copy it to #REGl.
  $C3F5,$03 Fetch the x position of the
. player.
  $C3F8,$03 Add the speed along the x axis.
  $C3FB,$03 Subtract the width of the
. player.
  $C3FE,$02 Return if the player is still in
. the room.
  $C400,$04 Write #N$FF to the x position.
  $C404,$03 Fetch the room number.
  $C407,$01 Copy it to #REGl.
  $C408,$01 Increment #REGa.
  $C409,$02 Jump to #R$C3B0.

c $C40B Leave Room To The North
@ $C40B label=LeaveRoomToNorth
D $C40B Sends the player to the room to
. the north if it has gone past the north
. edge of the room. The y position is set
. to #N($FF), which #R$CC01 takes as the
. sign that the player has come out of the
. north and puts it at the south side of
. the new room.
E $C40B View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CB0E }
. LIST#
R $C40B HL Distances to the walls along x and y
R $C40B IX The address of the object
N $C40B Leave if past the north edge.
  $C40B,$01 Restore #REGhl from the stack.
  $C40C,$01 Copy #REGh to #REGa.
  $C40D,$02 Add #N$80.
  $C40F,$01 Copy it to #REGh.
  $C410,$03 Fetch the y position of the
. player.
  $C413,$03 Add the speed along the y axis.
  $C416,$03 Subtract the depth of the
. player.
  $C419,$02 Return if the player is still in
. the room.
  $C41B,$04 Write #N$FF to the y position.
  $C41F,$03 Fetch the room number.
  $C422,$02 Add #N$10.
  $C424,$02 Jump to #R$C3B7.

c $C426 Leave Room To The South
@ $C426 label=LeaveRoomToSouth
D $C426 Sends the player to the room to
. the south if it has gone past the south
. edge of the room. The y position is set
. to #N($00), which #R$CC01 takes as the
. sign that the player has come out of the
. south and puts it at the north side of
. the new room.
E $C426 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CB29 }
. LIST#
R $C426 HL Distances to the walls along x and y
R $C426 IX The address of the object
N $C426 Leave if past the south edge.
  $C426,$01 Restore #REGhl from the stack.
  $C427,$02 Set #REGa to #N$80.
  $C429,$01 Subtract #REGh.
  $C42A,$01 Copy it to #REGh.
  $C42B,$03 Fetch the y position of the
. player.
  $C42E,$03 Add the speed along the y axis.
  $C431,$03 Add the depth of the player.
  $C434,$02 Return if the player is still in
. the room.
  $C436,$04 Write #N$00 to the y position.
  $C43A,$03 Fetch the room number.
  $C43D,$02 Subtract #N$10.
  $C43F,$03 Jump to #R$C3B7.

c $C442 Block Movement
@ $C442 label=BlockMovement
D $C442 Stops an object moving through
. the walls of the room or through other
. objects. The speeds along x, y and z of
. the object are each brought closer to
. zero until the object can move without
. hitting anything. Whichever direction is
. hit is flagged in the low bits of the
. collision flags: bit 0 for x, bit 1 for
. y and bit 2 for z. For z that means the
. object is standing on something. An
. object that is flagged to be ignored is
. not adjusted.
E $C442 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CB45 }
. { #PENTAGRAM$B6ED }
. LIST#
R $C442 IX The address of the object
N $C442 Ignore the object so that it does
. not hit itself, and clear the blocked
. flags.
  $C442,$05 Return if the object is ignored.
  $C447,$04 Flag the object to be ignored, so that it does not hit itself.
  $C44B,$03 Fetch the collision flags.
  $C44E,$02,b$01 Clear the blocked flags of x, y and z.
  $C450,$03 Store the collision flags.
  $C453,$03 Write #N$00 to the new speeds
. along x and y.
N $C456 The new speeds are kept in #REGh
. for z, #REGc for x and #REGl for y. Test
. z against the floor, then other objects.
  $C456,$04 Fetch the speed along z and test
. whether it is zero.
  $C45A,$01 Copy it to #REGh.
  $C45B,$02 Jump to #R$C467 if it is zero.
  $C45D,$03 Stop the object going through the floor.
  $C460,$04 Jump to #R$C467 if the speed along z is now zero.
  $C464,$03 Stop the object going through other objects.
N $C467 Test x against the walls of the
. room, then other objects.
@ $C467 label=BlockMovement_X
  $C467,$04 Fetch the speed along x and test
. whether it is zero.
  $C46B,$01 Copy it to #REGc.
  $C46C,$02 Jump to #R$C478 if it is zero.
  $C46E,$03 Stop the object going through the walls of the room.
  $C471,$04 Jump to #R$C478 if the speed along x is now zero.
  $C475,$03 Stop the object going through other objects.
N $C478 Test y against the walls of the
. room, then other objects.
@ $C478 label=BlockMovement_Y
  $C478,$04 Fetch the speed along y and test
. whether it is zero.
  $C47C,$01 Copy it to #REGl.
  $C47D,$02 Jump to #R$C489 if it is zero.
  $C47F,$03 Stop the object going through the walls of the room.
  $C482,$04 Jump to #R$C489 if the speed along y is now zero.
  $C486,$03 Stop the object going through other objects.
N $C489 Store the new speeds and stop
. ignoring the object.
@ $C489 label=BlockMovement_Store
  $C489,$09 Store the new speeds along x, y and z.
  $C492,$04 Stop ignoring the object.
  $C496,$01 Return.

c $C497 Block Movement In X
@ $C497 label=BlockMovementInX
D $C497 Brings the speed along x of an
. object closer to zero until it does not
. run into any other object. If the object
. does run into another, the objects may
. be killed: bit 7 of the extra flags
. means that it kills whatever it runs
. into, and bit 5 means that it kills
. whatever runs into it. Bit 6 is set to
. flag an object as killed. An object that
. is hit and can be moved takes on the
. speed along x of the object that hit it.
E $C497 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CB9A }
. { #PENTAGRAM$B742 }
. LIST#
R $C497 C Speed along x
R $C497 L Speed along y
R $C497 H Speed along z
R $C497 IX The address of the object
R $C497 O:C The new speed along x
N $C497 Walk the object table.
  $C497,$04 Point #REGiy at #R$5B88.
  $C49B,$02 Set a counter of #N$38 objects.
N $C49D Skip unless the object is solid
. and already overlaps along y and z.
@ $C49D label=BlockMovementInX_Next
  $C49D,$05 Jump to #R$C4DE if the object is
. not present or is ignored.
  $C4A2,$05 Jump to #R$C4DE if the objects
. do not overlap along y.
  $C4A7,$05 Jump to #R$C4DE if the objects
. do not overlap along z.
N $C4AC Test whether they overlap along
. x after the move.
@ $C4AC label=BlockMovementInX_Test
  $C4AC,$05 Jump to #R$C4DE if the objects
. do not overlap along x after the move.
N $C4B1 Flag the object as blocked along
. x, then apply the kill flags.
  $C4B1,$04 Flag the object as blocked along x.
  $C4B5,$04 Fetch the extra flags and move
. the bit that it kills what it hits into
. bit 6.
  $C4B9,$02,b$01 Keep the bit that flags the
. other object as killed.
  $C4BB,$06 Set it in the extra flags of the
. other object, if the object kills what
. it runs into.
  $C4C1,$01 Move the bit that the other
. object kills what hits it into bit 6.
  $C4C2,$02,b$01 Keep the bit that flags the
. object as killed.
  $C4C4,$06 Set it in the extra flags of the
. object, if the other object kills what
. runs into it.
N $C4CA Pass the speed along x to the
. other object if it can be moved.
  $C4CA,$06 Jump to #R$C4D6 if the other object cannot be moved.
  $C4D0,$06 Give the speed along x to the other object.
N $C4D6 Slow the move along x and test
. this object again.
@ $C4D6 label=BlockMovementInX_Slow
  $C4D6,$01 Fetch the speed along x.
  $C4D7,$03 Bring it closer to zero.
  $C4DA,$01 Store it.
  $C4DB,$01 Return if the speed is now zero.
  $C4DC,$02 Jump to #R$C4AC.
N $C4DE Move on to the next object.
@ $C4DE label=BlockMovementInX_Advance
  $C4DE,$05 Point #REGiy at the next object.
  $C4E3,$02 Jump to #R$C49D until all of the
. objects have been tested.
  $C4E5,$01 Return.

c $C4E6 Block Movement In Y
@ $C4E6 label=BlockMovementInY
D $C4E6 Brings the speed along y of an
. object closer to zero until it does not
. run into any other object. This works in
. the same way as #R$C497.
E $C4E6 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CBE9 }
. { #PENTAGRAM$B791 }
. LIST#
R $C4E6 C Speed along x
R $C4E6 L Speed along y
R $C4E6 H Speed along z
R $C4E6 IX The address of the object
R $C4E6 O:L The new speed along y
N $C4E6 Walk the object table.
  $C4E6,$04 Point #REGiy at #R$5B88.
  $C4EA,$02 Set a counter of #N$38 objects.
N $C4EC Skip unless the object is solid
. and already overlaps along x and z.
@ $C4EC label=BlockMovementInY_Next
  $C4EC,$05 Jump to #R$C52D if the object is
. not present or is ignored.
  $C4F1,$05 Jump to #R$C52D if the objects
. do not overlap along x.
  $C4F6,$05 Jump to #R$C52D if the objects
. do not overlap along z.
N $C4FB Test whether they overlap along
. y after the move.
@ $C4FB label=BlockMovementInY_Test
  $C4FB,$05 Jump to #R$C52D if the objects
. do not overlap along y after the move.
N $C500 Flag the object as blocked along
. y, then apply the kill flags.
  $C500,$04 Flag the object as blocked along y.
  $C504,$04 Fetch the extra flags and move
. the bit that it kills what it hits into
. bit 6.
  $C508,$02,b$01 Keep the bit that flags the
. other object as killed.
  $C50A,$06 Set it in the extra flags of the
. other object, if the object kills what
. it runs into.
  $C510,$01 Move the bit that the other
. object kills what hits it into bit 6.
  $C511,$02,b$01 Keep the bit that flags the
. object as killed.
  $C513,$06 Set it in the extra flags of the
. object, if the other object kills what
. runs into it.
N $C519 Pass the speed along y to the
. other object if it can be moved.
  $C519,$06 Jump to #R$C525 if the other object cannot be moved.
  $C51F,$06 Give the speed along y to the other object.
N $C525 Slow the move along y and test
. this object again.
@ $C525 label=BlockMovementInY_Slow
  $C525,$01 Fetch the speed along y.
  $C526,$03 Bring it closer to zero.
  $C529,$01 Store it.
  $C52A,$01 Return if the speed is now zero.
  $C52B,$02 Jump to #R$C4FB.
N $C52D Move on to the next object.
@ $C52D label=BlockMovementInY_Advance
  $C52D,$05 Point #REGiy at the next object.
  $C532,$02 Jump to #R$C4EC until all of the
. objects have been tested.
  $C534,$01 Return.

c $C535 Block Movement In Z
@ $C535 label=BlockMovementInZ
D $C535 Brings the speed along z of an
. object closer to zero until it does not
. run into any other object. This works in
. the same way as #R$C497, except that the
. object that is hit is flagged as touched
. (bit 3 of its extra flags) if the player
. is the object that hit it. An object
. which can be moved gives its speed along
. z to the other object, and takes on the
. speeds along x and y of the other object
. if it has none of its own.
E $C535 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CC38 }
. LIST#
R $C535 C Speed along x
R $C535 L Speed along y
R $C535 H Speed along z
R $C535 IX The address of the object
R $C535 O:H The new speed along z
N $C535 Walk the object table.
  $C535,$04 Point #REGiy at #R$5B88.
  $C539,$02 Set a counter of #N$38 objects.
N $C53B Skip unless the object is solid
. and already overlaps along x and y.
@ $C53B label=BlockMovementInZ_Next
  $C53B,$05 Jump to #R$C5A1 if the object is
. not present or is ignored.
  $C540,$05 Jump to #R$C5A1 if the objects
. do not overlap along x.
  $C545,$05 Jump to #R$C5A1 if the objects
. do not overlap along y.
N $C54A Test whether they overlap along
. z after the move.
@ $C54A label=BlockMovementInZ_Test
  $C54A,$05 Jump to #R$C5A1 if the objects
. do not overlap along z after the move.
N $C54F Flag the object as blocked along
. z, then apply the kill flags.
  $C54F,$04 Flag the object as blocked along z.
  $C553,$04 Fetch the extra flags and move
. the bit that it kills what it hits into
. bit 6.
  $C557,$02,b$01 Keep the bit that flags the
. other object as killed.
  $C559,$06 Set it in the extra flags of the
. other object, if the object kills what
. it runs into.
  $C55F,$01 Move the bit that the other
. object kills what hits it into bit 6.
  $C560,$02,b$01 Keep the bit that flags the
. object as killed.
  $C562,$06 Set it in the extra flags of the
. object, if the other object kills what
. runs into it.
N $C568 Pass speeds if this object can
. be moved. Flag the other object as
. touched if the player is standing on it.
  $C568,$06 Jump to #R$C599 if the object cannot be moved.
  $C56E,$05 Fetch the sprite number and
. subtract #N$10.
  $C573,$04 Jump to #R$C57B if it is not
. the player.
  $C577,$04 Flag the other object as touched.
N $C57B Give the speed along z to the
. other object, and take its speeds along
. x and y if this object has none.
@ $C57B label=BlockMovementInZ_Carry
  $C57B,$06 Give the speed along z to the other object.
  $C581,$04 Fetch the speed along x and test it.
  $C585,$02 Jump to #R$C58D if it has one.
  $C587,$06 Take the speed along x of the other object.
@ $C58D label=BlockMovementInZ_Y
  $C58D,$04 Fetch the speed along y and test it.
  $C591,$02 Jump to #R$C599 if it has one.
  $C593,$06 Take the speed along y of the other object.
N $C599 Slow the move along z and test
. this object again.
@ $C599 label=BlockMovementInZ_Slow
  $C599,$01 Fetch the speed along z.
  $C59A,$03 Bring it closer to zero.
  $C59D,$01 Store it.
  $C59E,$01 Return if the speed is now zero.
  $C59F,$02 Jump to #R$C54A.
N $C5A1 Move on to the next object.
@ $C5A1 label=BlockMovementInZ_Advance
  $C5A1,$05 Point #REGiy at the next object.
  $C5A6,$02 Jump to #R$C53B until all of the
. objects have been tested.
  $C5A8,$01 Return.

c $C5A9 Test Overlap In X
@ $C5A9 label=TestOverlapInX
D $C5A9 Tests whether two objects overlap
. along x, once the first has moved by its
. new speed along x. They overlap when the
. distance between the x positions is
. smaller than the two widths added
. together.
E $C5A9 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CC9D }
. { #PENTAGRAM$B8A2 }
. LIST#
R $C5A9 C New speed along x of the first object
R $C5A9 IX The address of the first object
R $C5A9 IY The address of the second object
R $C5A9 O:F Carry flag set if the objects overlap
N $C5A9 Compare the x distance with the
. widths.
  $C5A9,$03 Fetch the width of the first
. object.
  $C5AC,$03 Add the width of the second
. object.
  $C5AF,$01 Copy the total to #REGd.
  $C5B0,$03 Fetch the x position of the
. first object.
  $C5B3,$01 Add #REGc.
  $C5B4,$03 Subtract the x position of the
. second object.
  $C5B7,$03 Jump to #R$C5BC if the sign flag
. is clear.
  $C5BA,$02 Negate #REGa.
@ $C5BC label=TestOverlapInX_Compare
  $C5BC,$01 Subtract #REGd.
  $C5BD,$01 Return.

c $C5BE Test Overlap In Y
@ $C5BE label=TestOverlapInY
D $C5BE Tests whether two objects overlap
. along y, once the first has moved by its
. new speed along y. They overlap when the
. distance between the y positions is
. smaller than the two depths added
. together.
E $C5BE View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CCB2 }
. { #PENTAGRAM$B8B7 }
. LIST#
R $C5BE L New speed along y of the first object
R $C5BE IX The address of the first object
R $C5BE IY The address of the second object
R $C5BE O:F Carry flag set if the objects overlap
N $C5BE Compare the y distance with the
. depths.
  $C5BE,$03 Fetch the depth of the first
. object.
  $C5C1,$03 Add the depth of the second
. object.
  $C5C4,$01 Copy the total to #REGd.
  $C5C5,$03 Fetch the y position of the
. first object.
  $C5C8,$01 Add #REGl.
  $C5C9,$03 Subtract the y position of the
. second object.
  $C5CC,$03 Jump to #R$C5D1 if the sign flag
. is clear.
  $C5CF,$02 Negate #REGa.
@ $C5D1 label=TestOverlapInY_Compare
  $C5D1,$01 Subtract #REGd.
  $C5D2,$01 Return.

c $C5D3 Test Overlap In Z
@ $C5D3 label=TestOverlapInZ
D $C5D3 Tests whether two objects overlap
. along z, once the first has moved by its
. new speed along z. They overlap when the
. distance between the z positions is
. smaller than the height of whichever of
. the objects is lower.
E $C5D3 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CCC7 }
. { #PENTAGRAM$B8CC }
. LIST#
R $C5D3 H New speed along z of the first object
R $C5D3 IX The address of the first object
R $C5D3 IY The address of the second object
R $C5D3 O:F Carry flag set if the objects overlap
N $C5D3 Use the height of the lower
. object.
  $C5D3,$03 Fetch the z position of the
. first object.
  $C5D6,$01 Add #REGh.
  $C5D7,$03 Subtract the z position of the
. second object.
  $C5DA,$03 Jump to #R$C5E4 if the sign flag
. is clear.
  $C5DD,$02 Negate #REGa.
  $C5DF,$03 Fetch the height of the first
. object.
@ $C5E2 label=TestOverlapInZ_Compare
  $C5E2,$01 Subtract #REGd.
  $C5E3,$01 Return.
@ $C5E4 label=TestOverlapInZ_Second
  $C5E4,$03 Fetch the height of the second
. object.
  $C5E7,$02 Jump to #R$C5E2.

c $C5E9 Keep Object In Room In X
@ $C5E9 label=KeepObjectInRoomInX
D $C5E9 Brings the speed along x of an
. object closer to zero until the object
. stays within the walls of the room.
. Nothing is done while the object is
. entering the room, or while it is near
. an arch, as it can then go out through
. the wall.
E $C5E9 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CCDD }
. { #PENTAGRAM$B8E2 }
. LIST#
R $C5E9 C Speed along x
R $C5E9 IX The address of the object
R $C5E9 O:C The new speed along x
N $C5E9 Return while entering or near an
. arch.
  $C5E9,$03 Fetch the collision flags.
  $C5EC,$02,b$01 Keep only bits 4-7.
  $C5EE,$01 Return if the object is entering the room.
  $C5EF,$05 Return if the object is near an arch.
  $C5F4,$03 Fetch #R$5B0B.
  $C5F7,$01 Copy it to #REGb.
N $C5F8 Slow x until the object stays in
. the room.
@ $C5F8 label=KeepObjectInRoomInX_Test
  $C5F8,$03 Fetch the x position of the
. object.
  $C5FB,$01 Add #REGc.
  $C5FC,$02 Subtract #N$80.
  $C5FE,$02 Jump to #R$C602 if carry is not
. set.
  $C600,$02 Negate #REGa.
@ $C602 label=KeepObjectInRoomInX_Compare
  $C602,$03 Add the width of the object.
  $C605,$02 Return if the object stays in
. the room.
  $C607,$04 Set bit 0 of the collision
. flags.
  $C60B,$01 Copy #REGc to #REGa.
  $C60C,$03 Call #R$C386.
  $C60F,$01 Copy it to #REGc.
  $C610,$02 Jump to #R$C5F8 if it is not
. zero.
  $C612,$01 Return.

c $C613 Keep Object In Room In Y
@ $C613 label=KeepObjectInRoomInY
D $C613 Brings the speed along y of an
. object closer to zero until the object
. stays within the walls of the room.
. Nothing is done while the object is
. entering the room, or while it is near
. an arch, as it can then go out through
. the wall.
E $C613 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CD08 }
. { #PENTAGRAM$B90D }
. LIST#
R $C613 L Speed along y
R $C613 IX The address of the object
R $C613 O:L The new speed along y
N $C613 Return while entering or near an
. arch.
  $C613,$03 Fetch the collision flags.
  $C616,$02,b$01 Keep only bits 4-7.
  $C618,$01 Return if the object is entering the room.
  $C619,$05 Return if the object is near an arch.
  $C61E,$03 Fetch #R$5B0C.
  $C621,$01 Copy it to #REGb.
N $C622 Slow y until the object stays in
. the room.
@ $C622 label=KeepObjectInRoomInY_Test
  $C622,$03 Fetch the y position of the
. object.
  $C625,$01 Add #REGl.
  $C626,$02 Subtract #N$80.
  $C628,$02 Jump to #R$C62C if carry is not
. set.
  $C62A,$02 Negate #REGa.
@ $C62C label=KeepObjectInRoomInY_Compare
  $C62C,$03 Add the depth of the object.
  $C62F,$02 Return if the object stays in
. the room.
  $C631,$04 Set bit 1 of the collision
. flags.
  $C635,$01 Copy #REGl to #REGa.
  $C636,$03 Call #R$C386.
  $C639,$01 Copy it to #REGl.
  $C63A,$02 Jump to #R$C622 if it is not
. zero.
  $C63C,$01 Return.

c $C63D Calculate Sprite Size
@ $C63D label=CalculateSpriteSize
D $C63D Works out where an object is on
. the screen and how much of the screen
. its sprite covers. The width in bytes is
. one more than the width of the sprite if
. the sprite does not start on a byte
. boundary, because it has to be shifted
. across.
E $C63D View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CD33 }
. { #PENTAGRAM$B938 }
. LIST#
R $C63D IX The address of the object
N $C63D Widen the sprite if it is shifted.
  $C63D,$03 Call #R$CFD2.
  $C640,$03 Call #R$CFFE.
  $C643,$03 Fetch the pixel x position.
  $C646,$02,b$01 Keep only bits 0-2.
  $C648,$01 Fetch the width of the sprite
. in bytes.
  $C649,$01 Move on to the height.
  $C64A,$02 Jump to #R$C64D if they were
. zero.
  $C64C,$01 Increment #REGa.
@ $C64D label=CalculateSpriteSize_Store
  $C64D,$02,b$01 Keep only bits 0-3.
  $C64F,$03 Store the width in bytes.
  $C652,$01 Fetch the height of the sprite
. in lines.
  $C653,$03 Store the height in lines.
  $C656,$01 Return.

c $C657 Flag Overlapping Objects
@ $C657 label=FlagOverlappingObjects
D $C657 Flags every object that overlaps
. the area of the screen covered by an
. object to be drawn again. The area is
. the one that is covered by the old and
. the new position of the sprite of the
. object together, so that the whole of it
. is redrawn.
E $C657 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CD4D }
. { #PENTAGRAM$B9A7 }
. LIST#
R $C657 IX The address of the object
N $C657 The left edge, in bytes, is the
. lower of the old and new positions. It
. is kept in #REGe.
  $C657,$04 Point #REGiy at #R$5B88.
  $C65B,$03 Call #R$C63D.
  $C65E,$02 Set #REGb to #N$38.
  $C660,$03 Fetch the new pixel x position.
  $C663,$03 Divide it by eight.
  $C666,$02,b$01 Keep only bits 0-4.
  $C668,$01 Copy it to #REGl.
  $C669,$03 Fetch the old pixel x position.
  $C66C,$03 Divide it by eight.
  $C66F,$02,b$01 Keep only bits 0-4.
  $C671,$01 Copy it to #REGh.
  $C672,$03 Jump to #R$C676 if the old is
. lower.
  $C675,$01 Copy #REGl to #REGa.
@ $C676 label=FlagOverlappingObjects_RightEdge
  $C676,$01 Copy it to #REGe.
N $C677 The width is the higher right
. edge less the left edge. It is kept in
. #REGd.
  $C677,$01 Copy #REGl to #REGa.
  $C678,$03 Add the new width.
  $C67B,$01 Copy it to #REGl.
  $C67C,$01 Copy #REGh to #REGa.
  $C67D,$03 Add the old width.
  $C680,$03 Jump to #R$C684 if it is
. higher.
  $C683,$01 Copy #REGl to #REGa.
@ $C684 label=FlagOverlappingObjects_AreaWidth
  $C684,$01 Subtract #REGe.
  $C685,$01 Copy it to #REGd.
N $C686 The bottom edge is the lower of
. the old and new pixel y. It is kept in
. #REGl.
  $C686,$03 Fetch the new pixel y position.
  $C689,$03 Compare it with the old one.
  $C68C,$02 Jump to #R$C691 if the new one
. is lower.
  $C68E,$03 Fetch the old pixel y position.
@ $C691 label=FlagOverlappingObjects_TopEdge
  $C691,$01 Copy it to #REGl.
N $C692 The height is the higher top edge
. less the bottom edge. It is kept in
. #REGh.
  $C692,$03 Fetch the new pixel y position.
  $C695,$03 Add the new height.
  $C698,$01 Copy it to #REGh.
  $C699,$03 Fetch the old pixel y position.
  $C69C,$03 Add the old height.
  $C69F,$03 Jump to #R$C6A3 if it is
. higher.
  $C6A2,$01 Copy #REGh to #REGa.
@ $C6A3 label=FlagOverlappingObjects_AreaHeight
  $C6A3,$01 Subtract #REGl.
  $C6A4,$01 Copy it to #REGh.
N $C6A5 Flag any object that overlaps the
. area.
@ $C6A5 label=FlagOverlappingObjects_Next
  $C6A5,$03 Fetch the sprite number of the
. other object.
  $C6A8,$03 Jump to #R$C6CC if it is zero.
  $C6AB,$06 Jump to #R$C6CC if the object is already flagged to be drawn.
  $C6B1,$03 Fetch the pixel x position of
. the other object.
  $C6B4,$03 Divide it by eight.
  $C6B7,$02,b$01 Keep only bits 0-4.
  $C6B9,$01 Subtract #REGe.
  $C6BA,$02 Jump to #R$C6D6 if carry is
. set.
  $C6BC,$01 Compare it with #REGd.
@ $C6BD label=FlagOverlappingObjects_Right
  $C6BD,$02 Jump to #R$C6CC if carry is not
. set.
  $C6BF,$03 Fetch the pixel y position of
. the other object.
  $C6C2,$01 Subtract #REGl.
  $C6C3,$02 Jump to #R$C6DD if carry is
. set.
  $C6C5,$01 Compare it with #REGh.
@ $C6C6 label=FlagOverlappingObjects_Top
  $C6C6,$02 Jump to #R$C6CC if carry is not
. set.
  $C6C8,$04 Set bit 4 of the flags.
@ $C6CC label=FlagOverlappingObjects_Advance
  $C6CC,$01 Switch to the shadow registers.
  $C6CD,$03 Set #REGde' to #N($0020,$04,$04).
  $C6D0,$02 Add #REGde' to #REGiy.
  $C6D2,$01 Switch to the main registers.
  $C6D3,$02 Jump to #R$C6A5 until #REGb is
. zero.
  $C6D5,$01 Return.
N $C6D6 The object starts to the left of
. the area, so it overlaps only if it is
. wide enough to reach the area.
@ $C6D6 label=FlagOverlappingObjects_Left
  $C6D6,$02 Negate #REGa.
  $C6D8,$03 Compare it with the width of
. the other object.
  $C6DB,$02 Jump to #R$C6BD.
N $C6DD The object starts below the area,
. so it overlaps only if it is tall enough
. to reach the area.
@ $C6DD label=FlagOverlappingObjects_Below
  $C6DD,$02 Negate #REGa.
  $C6DF,$03 Compare it with the height of
. the other object.
  $C6E2,$02 Jump to #R$C6C6.

c $C6E4 Handle Player Top
@ $C6E4 label=HandlePlayerTop
D $C6E4 Does all of the work for the top
. half of the robot (objects #N$20 to
. #N$2B), which is a copy of the bottom
. half placed #N$0C above it. The top half
. is one unit shorter than the bottom
. half. If the top half has been flagged
. as killed this flags the bottom half as
. killed too and turns the player into a
. sparkle.
R $C6E4 IX The address of the object
N $C6E4 Turn into a sparkle if killed.
  $C6E4,$03 Call #R$BF6F.
  $C6E7,$06 Jump to #R$C6F4 if the player has not been killed.
  $C6ED,$04 Set bit 6 of the bottom half
. extra flags.
  $C6F1,$03 Jump to #R$B39A.
N $C6F4 Copy the bottom half and raise it.
@ $C6F4 label=HandlePlayerTop_Copy
  $C6F4,$03 Copy #REGix to #REGde (using
. the stack).
  $C6F7,$04 Point #REGhl at the bottom half.
  $C6FB,$03 Copy #REGhl to #REGiy (using
. the stack).
  $C6FE,$01 Increment #REGde.
  $C6FF,$01 Increment #REGhl.
  $C700,$03 Set #REGbc to #N($0007,$04,$04).
  $C703,$02 Copy the position, size and
. flags.
  $C705,$03 Decrement the height of the top
. half.
  $C708,$03 Fetch the sprite number of the
. bottom half.
  $C70B,$02 Add #N$10.
  $C70D,$03 Set the sprite number of the
. top half.
  $C710,$03 Fetch the z position of the
. bottom half.
  $C713,$02 Add #N$0C.
  $C715,$03 Set the z position of the top
. half.
  $C718,$03 Call #R$C657.
  $C71B,$01 Return.

c $C71C List Objects To Draw
@ $C71C label=ListObjectsToDraw
D $C71C Makes the list at #R$C745 of the
. objects that have to be drawn again.
. Each entry is the index of an object in
. the table of objects (#R$5B88), and the
. list ends with #N$FF. An object is in
. the list if it is present and flagged to
. be drawn.
E $C71C View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CE62 }
. { #PENTAGRAM$B531 }
. LIST#
N $C71C Point at the first object and
. the start of the list.
  $C71C,$02 Stash #REGix on the stack.
  $C71E,$02 Set a counter of #N$38 objects.
  $C720,$03 Set #REGde to #N($0020,$04,$04).
  $C723,$04 Point #REGix at #R$5B88.
  $C727,$03 Point #REGhl at #R$C745.
  $C72A,$02 Set the index to #N$00.
N $C72C Add the object if it is present
. and flagged to be drawn.
@ $C72C label=ListObjectsToDraw_Next
  $C72C,$04 Fetch the sprite number and test
. whether the slot is used.
  $C730,$02 Jump to #R$C73A if it is not.
  $C732,$06 Jump to #R$C73A if the object is not flagged to be drawn.
  $C738,$01 Add the index of the object to the list.
  $C739,$01 Move on to the next place in the list.
N $C73A Move on to the next object.
@ $C73A label=ListObjectsToDraw_Advance
  $C73A,$01 Go to the next index.
  $C73B,$02 Point #REGix at the next object.
  $C73D,$02 Jump to #R$C72C until all of the
. objects have been tested.
N $C73F Mark the end of the list.
  $C73F,$03 Store the end marker.
  $C742,$02 Restore #REGix from the stack.
  $C744,$01 Return.

b $C745 List Of Objects To Draw
@ $C745 label=ObjectsToDrawList
D $C745 The indexes of the objects that
. have to be drawn, made by #R$C71C and
. ending with #N$FF. As an object is drawn
. bit 7 of its entry is set.
B $C745,$40,$08

c $C785 Draw Objects In Order
@ $C785 label=DrawObjectsInOrder
D $C785 Draws the objects in the list at
. #R$C745 so that the objects at the back
. are drawn before the objects in front of
. them. It takes the first object in the
. list that has not been drawn yet and
. compares it with each of the other
. objects that are waiting. If another
. object has to be drawn first, that
. object takes the place of the first
. object and is compared with the others
. in its turn. This carries on until an
. object is found that does not have to
. wait for any other object, and that one
. is drawn. This is repeated until the
. list is empty. The objects drawn are
. counted in #R$5B1E.
E $C785 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CEBB }
. { #PENTAGRAM$B58A }
. LIST#
N $C785 Clear the count and find the
. first object that is still waiting.
  $C785,$04 Write #N$00 to #R$5B1E.
  $C789,$04 Stash #REGix and #REGiy on the
. stack.
@ $C78D label=DrawObjectsInOrder_First
  $C78D,$03 Point #REGde at #R$C745.
N $C790 Skip entries that have already
. been drawn.
@ $C790 label=DrawObjectsInOrder_FindFirst
  $C790,$01 Fetch an index from the list.
  $C791,$01 Move on to the next entry.
  $C792,$05 Jump to #R$C8EA if it is the end of the list.
  $C797,$04 Jump to #R$C790 if the object has been drawn.
  $C79B,$03 Find the address of the object.
  $C79E,$04 Remember the place in the list.
  $C7A2,$03 Point #REGix at the object.
N $C7A5 Compare it with each later
. object that is still waiting.
@ $C7A5 label=DrawObjectsInOrder_FindSecond
  $C7A5,$01 Fetch an index from the list.
  $C7A6,$01 Move on to the next entry.
  $C7A7,$05 Jump to #R$C8D5 if it is the
. end of the list, as nothing has to be
. drawn before the first object.
  $C7AC,$04 Jump to #R$C7A5 if the object has been drawn.
  $C7B0,$03 Find the address of the object.
  $C7B3,$04 Remember the place in the list.
  $C7B7,$03 Point #REGiy at the other object.
  $C7BA,$03 Copy #REGix to #REGbc (using
. the stack).
  $C7BD,$05 Jump to #R$C7A5 if they are the same object.
N $C7C2 Each of the three directions
. gives a number. The number along z is
. #N$00 if the first object is above the
. other, #N$01 if the objects overlap
. along z and #N$02 if the first object is
. below. The number along y is #N$00 if
. the first object is to the north of the
. other, #N$03 if the objects overlap
. along y and #N$06 if the first object is
. to the south. The number along x is
. #N$00 if the first object is to the east
. of the other, #N$09 if the objects
. overlap along x and #N$12 if the first
. object is to the west. The three numbers
. are added together in #REGc.
  $C7C2,$02 Set the number to #N$00.
  $C7C4,$07 Work out where the top of the
. other object is.
  $C7CB,$04 Take it off the z position of
. the first object.
  $C7CF,$02 Jump to #R$C7E0 if the first
. object is above the other.
  $C7D1,$07 Work out where the top of the
. first object is.
  $C7D8,$04 Take it off the z position of
. the other object.
  $C7DC,$02 Jump to #R$C7DF if the objects
. overlap along z.
  $C7DE,$01 Add one to the number along z.
@ $C7DF label=DrawObjectsInOrder_Overlap
  $C7DF,$01 Add one to the number along z.
N $C7E0 Add the number along y.
@ $C7E0 label=DrawObjectsInOrder_Y
  $C7E0,$07 Work out where the north edge
. of the other object is.
  $C7E7,$07 Work out where the south edge
. of the first object is, and take the
. north edge of the other object off it.
  $C7EE,$02 Jump to #R$C806 if the first
. object is to the north of the other.
  $C7F0,$07 Work out where the north edge
. of the first object is.
  $C7F7,$07 Work out where the south edge
. of the other object is, and take the
. north edge of the first object off it.
  $C7FE,$01 Fetch the number so far.
  $C7FF,$02 Jump to #R$C803 if the objects
. overlap along y.
  $C801,$02 Add #N$03 to the number along y.
@ $C803 label=DrawObjectsInOrder_OverlapY
  $C803,$02 Add #N$03 to the number along y.
  $C805,$01 Store the number.
N $C806 Add the number along x.
@ $C806 label=DrawObjectsInOrder_X
  $C806,$07 Work out where the east edge
. of the other object is.
  $C80D,$07 Work out where the west edge
. of the first object is, and take the
. east edge of the other object off it.
  $C814,$02 Jump to #R$C82C if the first
. object is to the east of the other.
  $C816,$07 Work out where the east edge
. of the first object is.
  $C81D,$07 Work out where the west edge
. of the other object is, and take the
. east edge of the first object off it.
  $C824,$01 Fetch the number so far.
  $C825,$02 Jump to #R$C829 if the objects
. overlap along x.
  $C827,$02 Add #N$09 to the number along x.
@ $C829 label=DrawObjectsInOrder_OverlapX
  $C829,$02 Add #N$09 to the number along x.
  $C82B,$01 Store the number.
N $C82C Jump to the routine for the
. number.
@ $C82C label=DrawObjectsInOrder_Jump
  $C82C,$01 Use the number as the index into the table.
  $C82D,$03 Point #REGbc at #R$C833.
  $C830,$03 Jump to #R$A6B7.

w $C833 Drawing Order Table
@ $C833 label=DrawingOrderTable
D $C833 The routines that decide what is
. done about a pair of objects, by the
. number made from the directions in
. #R$C7C2. The number is the number along
. z plus the number along y plus the
. number along x. Either the first object
. is not held up by the other, or the
. other object has to be drawn first, or
. the objects fill the same space.
W $C833,$06,$02 #N$00 to #N$02: the first object is not held up.
W $C839,$04,$02 #N$03 and #N$04: the other object is drawn first.
W $C83D,$02,$02 #N$05: the first object is not held up.
W $C83F,$04,$02 #N$06 and #N$07: the other object is drawn first.
W $C843,$04,$02 #N$08 and #N$09: the first object is not held up.
W $C847,$04,$02 #N$0A and #N$0B: the first object is not held up.
W $C84B,$02,$02 #N$0C: the other object is drawn first.
W $C84D,$02,$02 #N$0D: the objects fill the same space.
W $C84F,$02,$02 #N$0E: the first object is not held up.
W $C851,$04,$02 #N$0F and #N$10: the other object is drawn first.
W $C855,$04,$02 #N$11 and #N$12: the first object is not held up.
W $C859,$04,$02 #N$13 and #N$14: the first object is not held up.
W $C85D,$02,$02 #N$15: the first object is not held up.
W $C85F,$04,$02 #N$16 and #N$17: the first object is not held up.
W $C863,$06,$02 #N$18 to #N$1A: the first object is not held up.

c $C869 Continue Comparing Objects
@ $C869 label=ContinueComparingObjects
D $C869 The first object is not held up
. by the other object, so go on to compare
. it with the next one. The table at
. #R$C833 has two entries that come here.
N $C869 Compare the first object with the
. next one.
  $C869,$03 Jump to #R$C7A5.
N $C86C The other table entry does the
. same.
@ $C86C label=ContinueComparingObjects_Alternate
  $C86C,$03 Jump to #R$C7A5.

c $C86F Compare With Other Object
@ $C86F label=CompareWithOtherObject
D $C86F Makes the other object the first
. object and starts the comparisons again
. from the beginning of the list.
E $C86F View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CFA5 }
. LIST#
R $C86F IY The address of the other object
N $C86F Fetch the index of the other
. object.
  $C86F,$03 Fetch #R$5B2F.
  $C872,$01 Point #REGhl at the entry of
. the other object.
  $C873,$01 Fetch the index of the other
. object.
  $C874,$03 Point #REGde at #R$C8EF.
N $C877 Look for it in #R$C8EF.
@ $C877 label=CompareWithOtherObject_Find
  $C877,$01 Fetch an entry.
  $C878,$04 Jump to #R$C882 if it is the
. end of the list.
  $C87C,$03 Jump to #R$C898 if it is the
. other object.
  $C87F,$01 Move on to the next entry.
  $C880,$02 Jump to #R$C877.
N $C882 Add it to the list.
@ $C882 label=CompareWithOtherObject_Add
  $C882,$01 Fetch the index of the other
. object.
  $C883,$01 Add it to the list.
  $C884,$01 Move on to the next entry.
  $C885,$03 Mark the end of the list.
N $C888 Make it the first object and
. start the comparisons again.
  $C888,$04 Copy #REGiy to #REGix (using
. the stack).
  $C88C,$03 Fetch #R$5B2F.
  $C88F,$03 Set #R$5B2D.
  $C892,$03 Point #REGde at #R$C745.
  $C895,$03 Jump to #R$C7A5.
N $C898 The objects hold each other up,
. so draw the other object to break the
. loop.
@ $C898 label=CompareWithOtherObject_Loop
  $C898,$03 Point #REGhl at #R$C745.
@ $C89B label=CompareWithOtherObject_Search
  $C89B,$01 Fetch an entry.
  $C89C,$01 Move on to the next entry.
  $C89D,$05 Jump to #R$C78D if it is the
. end of the list.
  $C8A2,$03 Jump to #R$C89B if it is not
. the other object.
  $C8A5,$04 Copy #REGiy to #REGix (using
. the stack).
  $C8A9,$02 Jump to #R$C8D8.

c $C8AB Replace Overlapping Special Object
@ $C8AB label=ReplaceOverlappingSpecialObject
D $C8AB Handles two objects that fill
. the same space. If neither of them is
. ignored and one of them is a valve
. (objects #N$60 to #N$63) it is replaced
. by a sparkle.
R $C8AB IX The address of the first object
R $C8AB IY The address of the other object
N $C8AB Skip if either object is
. ignored.
  $C8AB,$03 Fetch the flags of the first
. object.
  $C8AE,$03 Merge the flags of the other
. object.
  $C8B1,$02,b$01 Keep only bit 1.
  $C8B3,$03 Jump to #R$C7A5 if either object is ignored.
N $C8B6 Replace a valve with a sparkle.
  $C8B6,$03 Fetch the sprite number of the
. first object.
  $C8B9,$02 Take #N$60 off it, to get the
. number of the valve.
  $C8BB,$04 Jump to #R$C8C5 if it is not a
. valve.
  $C8BF,$04 Replace it with a sparkle.
  $C8C3,$02 Jump to #R$C8D2.
N $C8C5 Try the other object.
@ $C8C5 label=ReplaceOverlappingSpecialObject_Other
  $C8C5,$03 Fetch the sprite number of the
. other object.
  $C8C8,$02 Take #N$60 off it, to get the
. number of the valve.
  $C8CA,$04 Jump to #R$C8D2 if it is not a
. valve.
  $C8CE,$04 Replace it with a sparkle.
N $C8D2 Compare the first object with the
. next one.
@ $C8D2 label=ReplaceOverlappingSpecialObject_Next
  $C8D2,$03 Jump to #R$C7A5.

c $C8D5 Draw Next Object
@ $C8D5 label=DrawNextObject
D $C8D5 Draws an object that does not
. have to wait for any other object, and
. flags it as drawn in the list.
E $C8D5 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D000 }
. LIST#
R $C8D5 IX The address of the object
N $C8D5 Flag it drawn and print it.
  $C8D5,$03 Fetch the place in the list after the first object.
@ $C8D8 label=DrawNextObject_Flag
  $C8D8,$01 Point #REGhl at the entry of the object.
  $C8D9,$02 Flag the object as drawn.
  $C8DB,$05 Mark the end of the list of
. objects that have taken the first place.
  $C8E0,$03 Point #REGhl at #R$5B1E.
  $C8E3,$01 Add one to it.
  $C8E4,$03 Draw the object into the buffer.
  $C8E7,$03 Jump to #R$C78D to find the next object.
N $C8EA There are no objects left to
. draw.
@ $C8EA label=DrawNextObject_Finish
  $C8EA,$04 Restore #REGiy and #REGix from
. the stack.
  $C8EE,$01 Return.

b $C8EF List Of Replaced Objects
@ $C8EF label=ReplacedObjectsList
D $C8EF The indexes of the objects that
. have taken the place of the first object
. while the order of drawing is worked out
. (see #R$C86F), ending with #N$FF.
B $C8EF,$10,$08

c $C8FF Read Controls
@ $C8FF label=ReadControls
D $C8FF Reads the controls that the
. player is using and stores them in
. #R$5B15. The controls are made into a
. byte, with bit 0 for left, bit 1 for
. right, bit 2 for walking forward, bit 3
. for jumping and bit 4 for picking up
. and dropping an object. Bit 5 is set by
. #R$C9EE. No controls are read while the
. game over scene is shown or the game has
. been completed.
E $C8FF Continue on to #R$C91B.
E $C8FF View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D0E3 }
. { #KNIGHTLORE$D022 }
. { #NIGHTSHADE$E241 }
. { #PENTAGRAM$BDF8 }
. LIST#
R $C8FF O:C The controls
N $C8FF Pick the reader from #R$5B04.
  $C8FF,$03 Fetch #R$5B23.
  $C902,$01 Copy it to #REGc.
  $C903,$03 Fetch #R$5B24.
  $C906,$01 Merge #REGc.
  $C907,$02 Set #REGc to #N$00.
  $C909,$03 Jump to #R$C9EE if they are not
. zero.
  $C90C,$03 Fetch #R$5B04.
  $C90F,$01 Rotate bits 1 and 2 into bits
. 0 and 1.
  $C910,$02,b$01 Keep only bits 0 and 1.
  $C912,$03 Jump to #R$C9A5 if they are
. zero.
  $C915,$01 Decrement #REGa.
  $C916,$02 Jump to #R$C954 if it is zero.
  $C918,$01 Decrement #REGa.
  $C919,$02 Jump to #R$C979 if it is zero.

c $C91B Read Interface 2 Joystick
@ $C91B label=ReadInterface2Joystick
D $C91B Reads the controls from the
. Interface 2 joysticks, which are the
. keys 1 to 5 for the first joystick and 6
. to 0 for the second joystick. The
. joysticks use the keys left, right,
. down, up and fire in that order, so the
. keys of the first joystick are reversed
. to put them in the same order as the
. keys of the second joystick.
E $C91B View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D0F2 }
. { #KNIGHTLORE$D03E }
. { #NIGHTSHADE$E250 }
. LIST#
R $C91B O:C The controls
N $C91B Reverse the keys 1 to 5.
  $C91B,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $C920,$01 Stash #REGbc on the stack.
  $C921,$02 Set #REGb to #N$05.
@ $C923 label=ReadInterface2Joystick_Reverse
  $C923,$01 Rotate #REGa right.
  $C924,$02 Rotate #REGc left.
  $C926,$02 Jump to #R$C923 until #REGb is
. zero.
  $C928,$01 Copy #REGc to #REGa.
  $C929,$01 Restore #REGbc from the stack.
  $C92A,$01 Copy it to #REGc.
N $C92B Merge the keys 6 to 0.
  $C92B,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $C930,$01 Merge #REGc.
  $C931,$02 Set #REGc to #N$00.
  $C933,$06 Set bit 3 of #REGc if bit 0 of
. #REGa is set.
@ $C939 label=ReadInterface2Joystick_TestUp
  $C939,$06 Set bit 2 of #REGc if bit 1 of
. #REGa is set.
@ $C93F label=ReadInterface2Joystick_TestDown
  $C93F,$06 Set bit 4 of #REGc if bit 2 of
. #REGa is set.
@ $C945 label=ReadInterface2Joystick_TestRight
  $C945,$06 Set bit 1 of #REGc if bit 3 of
. #REGa is set.
@ $C94B label=ReadInterface2Joystick_TestLeft
  $C94B,$06 Set bit 0 of #REGc if bit 4 of
. #REGa is set.
@ $C951 label=ReadInterface2Joystick_Finish
  $C951,$03 Jump to #R$C9EE.

c $C954 Read Kempston Joystick
@ $C954 label=ReadKempstonJoystick
D $C954 Reads the controls from a
. Kempston joystick.
E $C954 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D12B }
. { #KNIGHTLORE$D077 }
. { #NIGHTSHADE$E289 }
. LIST#
R $C954 O:C The controls
  $C954,$02 Read port #N$1F.
  $C956,$02 Set #REGc to #N$00.
  $C958,$06 Set bit 1 of #REGc if bit 0 of
. #REGa is set.
@ $C95E label=ReadKempstonJoystick_TestLeft
  $C95E,$06 Set bit 0 of #REGc if bit 1 of
. #REGa is set.
@ $C964 label=ReadKempstonJoystick_TestDown
  $C964,$06 Set bit 4 of #REGc if bit 2 of
. #REGa is set.
@ $C96A label=ReadKempstonJoystick_TestUp
  $C96A,$06 Set bit 2 of #REGc if bit 3 of
. #REGa is set.
@ $C970 label=ReadKempstonJoystick_TestFire
  $C970,$06 Set bit 3 of #REGc if bit 4 of
. #REGa is set.
@ $C976 label=ReadKempstonJoystick_Finish
  $C976,$03 Jump to #R$C9EE.

c $C979 Read Cursor Joystick
@ $C979 label=ReadCursorJoystick
D $C979 Reads the controls from a cursor
. joystick, which uses the keys 5 for
. left, 8 for right, 7 for up, 6 for down
. and 0 for fire.
E $C979 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D150 }
. { #KNIGHTLORE$D09C }
. { #NIGHTSHADE$E2AE }
. LIST#
R $C979 O:C The controls
  $C979,$02 Set #REGc to #N$00.
  $C97B,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $C980,$06 Set bit 0 of #REGc if bit 4 of
. #REGa is set.
@ $C986 label=ReadCursorJoystick_SecondRow
  $C986,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $C98B,$06 Set bit 3 of #REGc if bit 0 of
. #REGa is set.
@ $C991 label=ReadCursorJoystick_TestUp
  $C991,$06 Set bit 2 of #REGc if bit 3 of
. #REGa is set.
@ $C997 label=ReadCursorJoystick_TestRight
  $C997,$06 Set bit 1 of #REGc if bit 2 of
. #REGa is set.
@ $C99D label=ReadCursorJoystick_TestDown
  $C99D,$04 Jump to #R$C9EE if bit 4 of
. #REGa is clear.
  $C9A1,$02 Set bit 4 of #REGc.
  $C9A3,$02 Jump to #R$C9EE.

c $C9A5 Read Keyboard
@ $C9A5 label=ReadKeyboard
D $C9A5 Reads the controls from the
. keyboard. Left is Z, C, M or B, right is
. X, V, symbol shift or N, walking
. forward is any key of the rows A to G
. and H to ENTER, jumping is any key of
. the rows Q to T and Y to P, and picking
. up and dropping an object is any key of
. the rows 1 to 5 and 6 to 0.
E $C9A5 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D0C8 }
. LIST#
R $C9A5 O:C The controls
N $C9A5 Left and right from the bottom
. row.
  $C9A5,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $C9AA,$01 Rotate Z into bit 0.
  $C9AB,$01 Copy it to #REGc.
  $C9AC,$02,b$01 Keep only bits 0 and 1.
  $C9AE,$04 Shift C and V into bits 0 and
. 1.
  $C9B2,$01 Merge #REGc.
  $C9B3,$02,b$01 Keep only bits 0 and 1.
  $C9B5,$01 Copy them to #REGc.
  $C9B6,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | SYMBOL SHIFT | M | N | B }
. TABLE#
  $C9BB,$06 Set bit 1 of #REGc if bit 1 of
. #REGa is set.
@ $C9C1 label=ReadKeyboard_TestM
  $C9C1,$06 Set bit 0 of #REGc if bit 2 of
. #REGa is set.
@ $C9C7 label=ReadKeyboard_TestN
  $C9C7,$06 Set bit 1 of #REGc if bit 3 of
. #REGa is set.
@ $C9CD label=ReadKeyboard_TestB
  $C9CD,$06 Set bit 0 of #REGc if bit 4 of
. #REGa is set.
@ $C9D3 label=ReadKeyboard_WalkKeys
  $C9D3,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$BD | A / ENTER | S / L | D / K | F / J | G / H }
. TABLE#
  $C9D8,$04 Set bit 2 of #REGc if a key is
. pressed.
@ $C9DC label=ReadKeyboard_JumpKeys
  $C9DC,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DB | Q / P | W / O | E / I | R / U | T / Y }
. TABLE#
  $C9E1,$04 Set bit 3 of #REGc if a key is
. pressed.
@ $C9E5 label=ReadKeyboard_PickUpKeys
  $C9E5,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$E7 | 1 / 0 | 2 / 9 | 3 / 8 | 4 / 7 | 5 / 6 }
. TABLE#
  $C9EA,$04 Set bit 4 of #REGc if a key is
. pressed.
N $C9EE Read the keys that pick up and
. drop an object when a joystick with
. directional control is in use. The keys
. that count are Z, X, C, V, A to G, H to
. ENTER, Q to T and Y to P.
@ $C9EE label=ReadControls_Finish
  $C9EE,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SHIFT / SPACE | Z / SYM | X / M | C / N | V / B }
. TABLE#
  $C9F3,$02,b$01 Keep only bits 1-4.
  $C9F5,$01 Stash #REGbc on the stack.
  $C9F6,$01 Copy the keys to #REGb.
  $C9F7,$05 Read the keys A to G, Q to T,
. Y to P and H to ENTER.
  $C9FC,$01 Merge #REGb.
  $C9FD,$01 Restore #REGbc from the stack.
  $C9FE,$02 Jump to #R$CA02 if no key is
. pressed.
  $CA00,$02 Set bit 5 of #REGc.
@ $CA02 label=ReadControls_Store
  $CA02,$01 Copy #REGc to #REGa.
  $CA03,$03 Set #R$5B15.
  $CA06,$01 Return.

c $CA07 Lose Life
@ $CA07 label=LoseLife
D $CA07 Puts the player back as it was
. when it entered the room (see #R$CA1D),
. and takes a life off. If there are no
. lives left the game is over.
E $CA07 View the equivalent code in;
. #LIST
. { #PENTAGRAM$C2EC }
. LIST#
N $CA07 Restore the player and take a
. life.
  $CA07,$03 Point #REGhl at #R$CA1D.
  $CA0A,$03 Point #REGde at #R$5B88.
  $CA0D,$03 Copy #REGde to #REGix (using
. the stack).
  $CA10,$03 Set #REGbc to #N($0040,$04,$04).
  $CA13,$02 Copy the player back.
  $CA15,$03 Point #REGhl at #R$5B1A.
N $CA18 See #POKE(infinite_lives,Infinite
. Lives).
  $CA18,$01 Decrement it.
  $CA19,$03 Jump to #R$B761 if the sign
. flag is set.
  $CA1C,$01 Return.

g $CA1D Copy Of Player
@ $CA1D label=PlayerCopy
D $CA1D A copy of the two objects of the
. player, as they were when the player
. entered the room (or as they are at the
. start of the game), which is put back by
. #R$CA07 when a life is lost. The first
. #N$20 bytes are the bottom half and the
. last #N$20 bytes are the top half. The
. byte at #R$CA1D(#N$CA25) is the room
. number of the bottom half, and the byte
. at #R$CA3D(#N$CA45) that of the top
. half. The byte at #R$CA1D(#N$CA2D) is
. the sprite that the bottom half will
. have when it appears, and the byte at
. #R$CA3D(#N$CA4D) is the sprite that the
. top half will have.
B $CA1D,$20,$08 The bottom half.
@ $CA3D label=PlayerCopy_TopHalf
B $CA3D,$20,$08 The top half.

b $CA5D Initial Player Data
@ $CA5D label=InitialPlayerData
D $CA5D The first eight bytes of each
. object of the player at the start of the
. game: the sprite number, the x, y and z
. positions, the width, the depth, the
. height and the flags.
B $CA5D,$08,$08 The bottom half, which is
. a sparkle, at the middle of the room,
. with a height of #N$0C.
B $CA65,$08,$08 The top half, which is a
. sparkle too, #N$0C higher than the
. bottom half and with a height of #N$0B.

c $CA6D Initialise Player
@ $CA6D label=InitialisePlayer
D $CA6D Sets up the copy of the player
. at the start of the game. The player
. appears in a room that is picked at
. random from four rooms.
E $CA6D View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D1B1 }
. LIST#
N $CA6D Copy the sparkle and pick a
. start room.
  $CA6D,$03 Point #REGhl at #R$CA5D.
  $CA70,$03 Point #REGde at #R$CA1D.
  $CA73,$03 Set #REGbc to #N($0008,$04,$04).
  $CA76,$02 Copy the bottom half.
  $CA78,$03 Point #REGde at #R$CA3D.
  $CA7B,$03 Set #REGbc to #N($0008,$04,$04).
  $CA7E,$02 Copy the top half.
  $CA80,$05 Write #N$16 to
. #R$CA1D(#N$CA2D).
  $CA85,$05 Write #N$26 to
. #R$CA3D(#N$CA4D).
  $CA8A,$03 Fetch #R$5B00.
  $CA8D,$02,b$01 Keep only bits 0 and 1.
  $CA8F,$01 Copy it to #REGl.
  $CA90,$02 Set #REGh to #N$00.
  $CA92,$03 Point #REGbc at #R$CA9E.
  $CA95,$01 Add #REGbc to #REGhl.
  $CA96,$01 Fetch the start room.
  $CA97,$03 Set #R$CA1D(#N$CA25).
  $CA9A,$03 Set #R$CA3D(#N$CA45).
  $CA9D,$01 Return.

b $CA9E Start Rooms
@ $CA9E label=StartRooms
D $CA9E The rooms that the player may
. start in.
B $CA9E,$04,$01

c $CAA2 Build Room Objects
@ $CAA2 label=BuildRoomObjects
D $CAA2 Builds the objects of the room
. that the player is in, and sets the game
. up to start again in it.
N $CAA2 Save the room that was left,
. unless this is the first.
  $CAA2,$03 Fetch #R$5B12.
  $CAA5,$03 Jump to #R$CAAB if it is zero.
  $CAA8,$03 Call #R$AF05.
N $CAAB Build the new room.
@ $CAAB label=BuildRoomObjects_Clear
  $CAAB,$03 Call #R$CCA7.
  $CAAE,$03 Call #R$CE7B.
  $CAB1,$03 Call #R$AE99.
  $CAB4,$03 Call #R$CC01.
  $CAB7,$0A Write #N$00 to #R$5B3A, #R$5B42
. and #R$5B43.
  $CAC1,$03 Fetch #R$5B88(#N$5B90).
  $CAC4,$01 Invert #REGa.
  $CAC5,$02,b$01 Keep only bit 0.
  $CAC7,$03 Set #R$5B3B.
  $CACA,$05 Write #N$01 to #R$5B17.
  $CACF,$03 Jump to #R$B863.

c $CAD2 Set Room Attributes
@ $CAD2 label=SetRoomAttributes
D $CAD2 Goes through the data for all of
. the rooms, which is held from #R$6469 to
. #R$73C8, and copies the second colour in
. the size and colours byte of each into
. the first so that both colours are the
. same.
N $CAD2 Copy the second colour over the
. first.
  $CAD2,$03 Point #REGhl at #R$6469.
  $CAD5,$03 Point #REGbc at #R$73C8.
  $CAD8,$01 Increment #REGhl.
@ $CAD9 label=SetRoomAttributes_Next
  $CAD9,$01 Fetch the length of the data.
  $CADA,$01 Increment #REGhl.
  $CADB,$01 Fetch the size and colours.
  $CADC,$03 Rotate the second colour into
. bits 0-2.
  $CADF,$02,b$01 Keep only bits 0-2.
  $CAE1,$01 Copy it to #REGd.
  $CAE2,$01 Fetch the size and colours.
  $CAE3,$02,b$01 Keep only bits 3-7.
  $CAE5,$01 Merge #REGd.
  $CAE6,$01 Store the size and colours.
  $CAE7,$02 Set #REGd to #N$00.
  $CAE9,$01 Add #REGde to #REGhl.
  $CAEA,$04 Return if the end of the room
. data has been reached.
  $CAEE,$01 Add #REGbc to #REGhl.
  $CAEF,$02 Jump to #R$CAD9.

c $CAF1 Set Sprite Details
@ $CAF1 label=SetSpriteDetails
D $CAF1 Sets the sprite number, the
. flags and the pixel position of an
. object from four bytes of data.
E $CAF1 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D237 }
. { #PENTAGRAM$BDC0 }
. LIST#
R $CAF1 HL The address of the data
R $CAF1 IX The address of the object
R $CAF1 O:HL The address of the byte after the data
  $CAF1,$02 Fetch the sprite number and
. move on.
  $CAF3,$03 Set the sprite number.
  $CAF6,$02 Fetch the flags and move on.
  $CAF8,$03 Set the flags.
  $CAFB,$02 Fetch the pixel x and move on.
  $CAFD,$03 Set the pixel x position.
  $CB00,$02 Fetch the pixel y and move on.
  $CB02,$03 Set the pixel y position.
  $CB05,$01 Return.

c $CB06 Print Table Sprite
@ $CB06 label=PrintTableSprite
D $CB06 Sets the details of an object
. from four bytes of data, and prints its
. sprite.
E $CB06 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D24C }
. { #PENTAGRAM$BDD5 }
. LIST#
R $CB06 HL The address of the data
R $CB06 IX The address of the object
R $CB06 O:HL The address of the byte after the data
  $CB06,$03 Call #R$CAF1.
  $CB09,$01 Stash #REGhl on the stack.
  $CB0A,$03 Call #R$D027.
  $CB0D,$01 Restore #REGhl from the stack.
  $CB0E,$01 Return.

c $CB0F Draw Panel
@ $CB0F label=DrawPanel
D $CB0F Draws the sprites of the panel
. at the bottom of the screen, using the
. table at #R$CB5A. On each side there is
. a run of five sprites that go up in
. steps, a column of six sprites and two
. more sprites, and the middle of the
. panel has the extra life that is the
. symbol for the lives and four more
. sprites. The right side is the left side
. flipped.
.
. #PUSHS #UDGTABLE { =h After #R$CB0F and #R$CE85 }
. { #SIM(start=$A631,stop=$A676,sp=$F100,r=$80,clear=1)
. #SIM(start=$CE73,stop=$0000,sp=$EC00)
. #SIM(start=$CB0F,stop=$0000,sp=$EC00)
. #SIM(start=$CE85,stop=$0000,sp=$EC00)
. #SCR$02,$00,$10,$20,$08(draw-panel) } UDGTABLE# #POPS
N $CB0F Left side, then right, then the
. middle.
  $CB0F,$04 Point #REGix at #R$BD38.
  $CB13,$03 Point #REGhl at #R$CB5A.
  $CB16,$03 Call #R$CAF1.
  $CB19,$03 Set #REGde to #N$F810.
  $CB1C,$02 Set #REGb to #N$05.
  $CB1E,$03 Call #R$BC56.
  $CB21,$03 Call #R$CAF1.
  $CB24,$03 Set #REGde to #N$0800.
  $CB27,$02 Set #REGb to #N$06.
  $CB29,$03 Call #R$BC56.
  $CB2C,$03 Call #R$CB06.
  $CB2F,$03 Call #R$CB06.
  $CB32,$03 Call #R$CAF1.
  $CB35,$03 Set #REGde to #N$F8F0.
  $CB38,$02 Set #REGb to #N$05.
  $CB3A,$03 Call #R$BC56.
  $CB3D,$03 Call #R$CAF1.
  $CB40,$03 Set #REGde to #N$0800.
  $CB43,$02 Set #REGb to #N$06.
  $CB45,$03 Call #R$BC56.
  $CB48,$03 Call #R$CB06.
  $CB4B,$03 Call #R$CB06.
  $CB4E,$03 Call #R$CB06.
  $CB51,$03 Call #R$CB06.
  $CB54,$03 Call #R$CB06.
  $CB57,$03 Jump to #R$CB06.

b $CB5A Panel Sprites
@ $CB5A label=PanelSprites
D $CB5A The sprites for the panel. Each
. has four bytes: the sprite number, the
. flags, and the pixel x and y
. coordinates.
B $CB5A,$04,$01 Sprite #N($09), flags
. #N($00), at (#N($10), #N$30).
. #UDGTABLE { #SPRITE$09,attr=$47(panel-diagonal-01-colour*) }
. UDGTABLE#
B $CB5E,$04,$01 Sprite #N($0A), flags
. #N($00), at (#N($00), #N$00).
. #UDGTABLE { #SPRITE$0A,attr=$47(panel-column-01-colour*) } UDGTABLE#
B $CB62,$04,$01 Sprite #N($07), flags
. #N($00), at (#N($00), #N$30).
. #UDGTABLE
. { #SPRITE$07,attr=$47(panel-upper-edge-01-colour*) }
. UDGTABLE#
B $CB66,$04,$01 Sprite #N($08), flags
. #N($00), at (#N($60), #N$00).
. #UDGTABLE
. { #SPRITE$08,attr=$47(panel-lower-edge-01-colour*) }
. UDGTABLE#
B $CB6A,$04,$01 Sprite #N($09), flags
. #N($40), at (#N($E0), #N$30).
. #UDGTABLE { #SPRITE$09,attr=$47(panel-diagonal-01-colour*) }
. UDGTABLE#
B $CB6E,$04,$01 Sprite #N($0A), flags
. #N($40), at (#N($F8), #N$00).
. #UDGTABLE { #SPRITE$0A,attr=$47(panel-column-01-colour*) } UDGTABLE#
B $CB72,$04,$01 Sprite #N($07), flags
. #N($40), at (#N($F0), #N$30).
. #UDGTABLE
. { #SPRITE$07,attr=$47(panel-upper-edge-01-colour*) }
. UDGTABLE#
B $CB76,$04,$01 Sprite #N($08), flags
. #N($40), at (#N($90), #N$00).
. #UDGTABLE
. { #SPRITE$08,attr=$47(panel-lower-edge-01-colour*) }
. UDGTABLE#
B $CB7A,$04,$01 Sprite #N($0C), flags
. #N($00), at (#N($70), #N$00).
. #UDGTABLE { #SPRITE$0C,attr=$47(extra-life-01-colour*) } UDGTABLE#
B $CB7E,$04,$01 Sprite #N($54), flags
. #N($00), at (#N($E0), #N$09).
. #UDGTABLE { #SPRITE$54,attr=$47(panel-bracket-01-colour*) } UDGTABLE#
B $CB82,$04,$01 Sprite #N($54), flags
. #N($40), at (#N($C8), #N$09).
. #UDGTABLE { #SPRITE$54,attr=$47(panel-bracket-01-colour*) } UDGTABLE#
B $CB86,$04,$01 Sprite #N($83), flags
. #N($00), at (#N($08), #N$18).
. #UDGTABLE
. { #SPRITE$83,attr=$47(panel-decoration-01-colour*) }
. UDGTABLE#

c $CB8A Print Border
@ $CB8A label=PrintBorder
D $CB8A Draws the border around the
. playing area, using the sprites in the
. table at #R$CBC3. The four corners are
. drawn first, then the top and bottom
. edges, which are each made of #N$18
. sprites that are eight pixels wide, and
. the left and right edges, which are each
. made of #N$80 sprites that are one pixel
. high.
.
. #PUSHS #UDGTABLE { =h After #R$CB8A and #R$CE85 }
. { #SIM(start=$A631,stop=$A676,sp=$F100,r=$80,clear=1)
. #SIM(start=$CE73,stop=$0000,sp=$EC00)
. #SIM(start=$CB8A,stop=$0000,sp=$EC00)
. #SIM(start=$CE85,stop=$0000,sp=$EC00)
. #SCR$02(print-border) } UDGTABLE# #POPS
E $CB8A View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D296 }
. { #PENTAGRAM$BD59 }
. LIST#
N $CB8A Corners, then the four edges.
  $CB8A,$04 Point #REGix at #R$BD38.
  $CB8E,$03 Point #REGhl at #R$CBC3.
  $CB91,$03 Call #R$CB06.
  $CB94,$03 Call #R$CB06.
  $CB97,$03 Call #R$CB06.
  $CB9A,$03 Call #R$CB06.
  $CB9D,$03 Call #R$CAF1.
  $CBA0,$03 Set #REGde to #N($0008,$04,$04).
  $CBA3,$02 Set #REGb to #N$18.
  $CBA5,$03 Call #R$BC56.
  $CBA8,$03 Call #R$CAF1.
  $CBAB,$02 Set #REGb to #N$18.
  $CBAD,$03 Call #R$BC56.
  $CBB0,$03 Call #R$CAF1.
  $CBB3,$03 Set #REGde to #N$0100.
  $CBB6,$02 Set #REGb to #N$80.
  $CBB8,$03 Call #R$BC56.
  $CBBB,$03 Call #R$CAF1.
  $CBBE,$02 Set #REGb to #N$80.
  $CBC0,$03 Jump to #R$BC56.

b $CBC3 Border Sprites
@ $CBC3 label=BorderSprites
D $CBC3 The sprites for the border. Each
. has four bytes: the sprite number, the
. flags, and the pixel x and y
. coordinates.
B $CBC3,$04,$01 Sprite #N($04), flags
. #N($00), at (#N($00), #N$A0).
. #UDGTABLE { #SPRITE$04,attr=$47(border-corner-01-colour*) } UDGTABLE#
B $CBC7,$04,$01 Sprite #N($04), flags
. #N($40), at (#N($E0), #N$A0).
. #UDGTABLE { #SPRITE$04,attr=$47(border-corner-01-colour*) } UDGTABLE#
B $CBCB,$04,$01 Sprite #N($04), flags
. #N($C0), at (#N($E0), #N$00).
. #UDGTABLE { #SPRITE$04,attr=$47(border-corner-01-colour*) } UDGTABLE#
B $CBCF,$04,$01 Sprite #N($04), flags
. #N($80), at (#N($00), #N$00).
. #UDGTABLE { #SPRITE$04,attr=$47(border-corner-01-colour*) } UDGTABLE#
B $CBD3,$04,$01 Sprite #N($06), flags
. #N($00), at (#N($20), #N$A8).
. #UDGTABLE { #SPRITE$06,attr=$47(border-edge-01-colour*) } UDGTABLE#
B $CBD7,$04,$01 Sprite #N($06), flags
. #N($80), at (#N($20), #N$00).
. #UDGTABLE { #SPRITE$06,attr=$47(border-edge-01-colour*) } UDGTABLE#
B $CBDB,$04,$01 Sprite #N($05), flags
. #N($00), at (#N($00), #N$20).
. #UDGTABLE { #SPRITE$05,attr=$47(border-side-01-colour*) } UDGTABLE#
B $CBDF,$04,$01 Sprite #N($05), flags
. #N($40), at (#N($E8), #N$20).
. #UDGTABLE { #SPRITE$05,attr=$47(border-side-01-colour*) } UDGTABLE#

c $CBE3 Set Border Attributes
@ $CBE3 label=SetBorderAttributes
D $CBE3 Sets the colours of the panel at
. the bottom of the screen: black for the
. two columns at the sides of the window,
. and bright red for the window itself.
E $CBE3 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D2EF }
. LIST#
N $CBE3 Colour the sides black, then the
. window bright red.
  $CBE3,$01 Set #REGa to #N$00.
  $CBE4,$03 Point #REGhl at #N$5AB6 (in the attribute buffer).
  $CBE7,$03 Set #REGbc to #N$0103.
  $CBEA,$03 Call #R$BF83.
  $CBED,$03 Point #REGhl at #N$5ABD (in the attribute buffer).
  $CBF0,$03 Set #REGbc to #N$0103.
  $CBF3,$03 Call #R$BF83.
  $CBF6,$02 Set #REGa to #N$42.
  $CBF8,$03 Point #REGhl at #N$5A97 (in the attribute buffer).
  $CBFB,$03 Set #REGbc to #N$0604.
  $CBFE,$03 Jump to #R$BF83.

c $CC01 Place Player At Door
@ $CC01 label=PlacePlayerAtDoor
D $CC01 Puts the player in the right place
. when it has come into a room through an
. arch. The routine that moved the player
. out of the last room set one of its
. positions to #N$00 or #N($FF), which tells
. which way the player came. The player is
. put at the opposite edge of the room,
. just outside the wall, and at the height
. of the arch. If the positions are not
. one of these, as when the player starts
. the game or starts again after losing a
. life, nothing is changed.
E $CC01 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D320 }
. { #PENTAGRAM$CA82 }
. LIST#
R $CC01 IX Address of the player
N $CC01 Fetch the wall distances, then
. see which way the player came.
  $CC01,$03 Fetch #R$5B0B.
  $CC04,$02 Subtract #N$02.
  $CC06,$01 Copy it to #REGl.
  $CC07,$03 Fetch #R$5B0C.
  $CC0A,$02 Subtract #N$02.
  $CC0C,$01 Copy it to #REGh.
  $CC0D,$03 Fetch the x position of the
. player.
  $CC10,$03 Jump to #R$CC60 if it is zero.
  $CC13,$03 Jump to #R$CC50 if it is #N$FF.
  $CC16,$03 Fetch the y position of the
. player.
  $CC19,$03 Jump to #R$CC43 if it is zero.
  $CC1C,$03 Jump to #R$CC20 if it is #N$FF.
  $CC1F,$01 Return.
@ $CC20 label=PlacePlayerAtDoor_South
N $CC20 The player came from the north.
  $CC20,$02 Set #REGc to #N$C8.
  $CC22,$03 Call #R$CC6D.
  $CC25,$02 Set #REGa to #N$80.
  $CC27,$01 Subtract #REGh.
  $CC28,$03 Subtract the depth of the
. player.
@ $CC2B label=PlacePlayerAtDoor_SetY
  $CC2B,$03 Set the y position of the
. player.
@ $CC2E label=PlacePlayerAtDoor_Draw
  $CC2E,$04 Set bit 4 of the flags.
  $CC32,$04 Set bit 4 of the flags of the
. top half.
  $CC36,$03 Fetch the x position of the
. player.
  $CC39,$03 Set the x position of the top
. half.
  $CC3C,$03 Fetch the y position of the
. player.
  $CC3F,$03 Set the y position of the top
. half.
  $CC42,$01 Return.
@ $CC43 label=PlacePlayerAtDoor_North
N $CC43 The player came from the south.
  $CC43,$02 Set #REGc to #N$52.
  $CC45,$03 Call #R$CC6D.
  $CC48,$01 Fetch #REGh.
  $CC49,$02 Add #N$80.
  $CC4B,$03 Add the depth of the player.
  $CC4E,$02 Jump to #R$CC2B.
@ $CC50 label=PlacePlayerAtDoor_West
N $CC50 The player came from the east.
  $CC50,$02 Set #REGc to #N$AE.
  $CC52,$03 Call #R$CC6D.
  $CC55,$02 Set #REGa to #N$80.
  $CC57,$01 Subtract #REGl.
  $CC58,$03 Subtract the width of the
. player.
@ $CC5B label=PlacePlayerAtDoor_SetX
  $CC5B,$03 Set the x position of the
. player.
  $CC5E,$02 Jump to #R$CC2E.
@ $CC60 label=PlacePlayerAtDoor_East
N $CC60 The player came from the west.
  $CC60,$02 Set #REGc to #N$38.
  $CC62,$03 Call #R$CC6D.
  $CC65,$01 Fetch #REGl.
  $CC66,$02 Add #N$80.
  $CC68,$03 Add the width of the player.
  $CC6B,$02 Jump to #R$CC5B.

c $CC6D Find Door Height
@ $CC6D label=FindDoorHeight
D $CC6D Looks through the first four pairs
. of objects of the room for an arch (a
. sprite number below #N$04) whose x and y
. positions add up to a given number. When
. it finds one it gives the player the
. height of the arch.
E $CC6D View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D38C }
. LIST#
R $CC6D C Sum of the x and y positions of the arch
R $CC6D IX Address of the player
N $CC6D Walk the first four pairs.
  $CC6D,$04 Point #REGiy at #R$5C08.
  $CC71,$03 Set #REGde to #N($0040,$04,$04).
  $CC74,$02 Set #REGb to #N$04.
@ $CC76 label=FindDoorHeight_Next
  $CC76,$03 Fetch the sprite number of the
. object.
  $CC79,$03 Return if it is #N$04 or more.
  $CC7C,$03 Fetch the x position of the
. object.
  $CC7F,$03 Add the y position of the
. object.
  $CC82,$03 Jump to #R$CC8A if it is equal
. to #REGc.
  $CC85,$02 Add #REGde to #REGiy.
  $CC87,$02 Jump to #R$CC76 until #REGb is
. zero.
  $CC89,$01 Return.
@ $CC8A label=FindDoorHeight_Found
N $CC8A Give the player the height of the
. arch.
  $CC8A,$03 Fetch the z position of the
. arch.
  $CC8D,$03 Set the z position of the
. player.
  $CC90,$02 Add #N$0C.
  $CC92,$03 Set the z position of the top
. half.
  $CC95,$01 Return.

c $CC96 Find Object Address
@ $CC96 label=FindObjectAddress
D $CC96 Works out the address of an object
. from its index in the table of objects.
E $CC96 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D3B5 }
. { #PENTAGRAM$B520 }
. LIST#
R $CC96 A Index of the object (bit 7 is ignored)
R $CC96 O:HL Address of the object record
  $CC96,$01 Stash #REGbc on the stack.
  $CC97,$02,b$01 Keep bits 0 to 6.
  $CC99,$01 Copy it to #REGl.
  $CC9A,$02 Set #REGh to #N$00.
  $CC9C,$05 Multiply #REGhl by #N$20.
  $CCA1,$03 Point #REGbc at #R$5B88.
  $CCA4,$01 Add #REGbc to #REGhl.
  $CCA5,$01 Restore #REGbc from the stack.
  $CCA6,$01 Return.

c $CCA7 Retrieve Room
@ $CCA7 label=RetrieveRoom
D $CCA7 Builds the objects of the room that
. the player is in from the room data. It
. looks for the room in the room data (see
. #R$6469), which has a variable length
. entry for each room. The objects are put
. in the objects table from #R$5C08, which
. is the first one after the player and
. the special objects. If the room is not
. in the data, none are made.
E $CCA7 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D3C6 }
. { #PENTAGRAM$C92C }
. LIST#
R $CCA7 IX Address of the player
N $CCA7 Point at the room data, then find
. the entry for this room.
  $CCA7,$03 Point #REGhl at #R$73C8.
  $CCAA,$03 Set #R$5B20.
  $CCAD,$07 Write #N$00 to #R$5B19 and
. #R$5B25.
  $CCB4,$03 Point #REGde at #R$5C08.
  $CCB7,$03 Point #REGbc at #R$73C8.
  $CCBA,$03 Point #REGhl at #R$6469.
@ $CCBD label=RetrieveRoom_Find
  $CCBD,$05 Fetch the room number and
. compare it with the player's room.
  $CCC2,$02 Jump to #R$CCDE if they match.
  $CCC4,$01 Fetch the length of the entry.
  $CCC5,$03 Call #R$CE06.
  $CCC8,$05 Jump to #R$CCD0 if #REGhl has
. reached #REGbc.
  $CCCD,$01 Add #REGbc to #REGhl.
  $CCCE,$02 Jump to #R$CCBD.

c $CCD0 Clear Remaining Objects
@ $CCD0 label=ClearRemainingObjects
D $CCD0 Clears the objects in the objects
. table from a given place to the end of
. the table.
E $CCD0 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D3E2 }
. LIST#
R $CCD0 DE Address of the first object to clear
  $CCD0,$03 Point #REGhl at #R$6288.
  $CCD3,$04 Return if #REGhl is equal to
. #REGde.
  $CCD7,$02 Set #REGb to #N$20.
  $CCD9,$03 Call #R$CE1C.
  $CCDC,$02 Jump to #R$CCD0.

c $CCDE Make Room Objects
@ $CCDE label=MakeRoomObjects
D $CCDE Makes the objects of a room from
. its entry in the room data. The colour
. of the room is the low three bits of the
. byte after the length, and the size of
. the room is the high two bits. The size
. gives the distance to the walls and the
. floor level, from the table at #R$6460.
. Each type of block is the number of an
. entry in the table at #R$7519, which
. holds the address of a template of one
. or more objects. These are copied into
. the objects table, along with the number
. of the room. The types of block end with
. a #N($FF), or at the end of the entry if
. there are no more objects. After the
. #N$FF come the groups of other objects,
. each with a type and a number of places
. (see #R$6469).
E $CCDE View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D3F0 }
. LIST#
R $CCDE DE Address of the first object to make
R $CCDE HL Address of the length of the entry of the room
R $CCDE IX Address of the player
N $CCDE Set the colour, the size and the
. floor.
  $CCDE,$01 Fetch the length of the entry.
  $CCDF,$01 Increment #REGhl.
  $CCE0,$01 Fetch the colour and size.
  $CCE1,$02,b$01 Keep bits 0 to 2.
  $CCE3,$03 Set #R$5B0D.
  $CCE6,$03 Set #R$5B34.
  $CCE9,$01 Stash #REGde on the stack.
  $CCEA,$01 Exchange #REGde and #REGhl.
  $CCEB,$01 Fetch the colour and size.
  $CCEC,$01 Increment #REGde.
  $CCED,$02 Rotate the size into the low
. two bits.
  $CCEF,$02,b$01 Keep bits 0 and 1.
  $CCF1,$01 Copy it to #REGc.
  $CCF2,$02 Multiply it by three.
  $CCF4,$03 Point #REGhl at #R$6460.
  $CCF7,$03 Call #R$CE06.
  $CCFA,$02 Fetch the east and west
. distance and increment #REGhl.
  $CCFC,$03 Set #R$5B0B.
  $CCFF,$02 Fetch the north and south
. distance and increment #REGhl.
  $CD01,$03 Set #R$5B0C.
  $CD04,$01 Fetch the floor level.
  $CD05,$03 Set #R$5B0E.
  $CD08,$02 Subtract #N$02 from #REGb.
  $CD0A,$01 Exchange #REGde and #REGhl.
  $CD0B,$01 Restore #REGde from the stack.
@ $CD0C label=MakeRoomObjects_Background
N $CD0C Copy each type of block from
. #R$7519.
  $CD0C,$02 Fetch the type and increment
. #REGhl.
  $CD0E,$04 Jump to #R$CD3A if it is #N$FF.
  $CD12,$02 Stash #REGbc and #REGhl on the
. stack.
  $CD14,$01 Copy it to #REGl.
  $CD15,$02 Set #REGh to #N$00.
  $CD17,$01 Double #REGhl.
  $CD18,$03 Point #REGbc at #R$7519.
  $CD1B,$01 Add #REGbc to #REGhl.
  $CD1C,$04 Fetch the address of the
. template.
@ $CD20 label=MakeRoomObjects_BackgroundCopy
  $CD20,$03 Set #REGbc to #N($0008,$04,$04).
  $CD23,$02 Copy #N$08 bytes from #REGhl to
. #REGde.
  $CD25,$03 Fetch the room number of the
. player.
  $CD28,$01 Set the room number of the
. object.
  $CD29,$01 Increment #REGde.
  $CD2A,$02 Set #REGb to #N$17.
  $CD2C,$03 Call #R$CE1C.
  $CD2F,$04 Jump to #R$CD20 if the next
. byte is not zero.
  $CD33,$02 Restore #REGhl and #REGbc from
. the stack.
  $CD35,$02 Jump to #R$CD0C until #REGb is
. zero.
  $CD37,$03 Jump to #R$CCD0.
@ $CD3A label=MakeRoomObjects_Foreground
N $CD3A The other objects. #REGiy points
. at the object that is being made.
  $CD3A,$01 Decrement #REGb.
  $CD3B,$02 Stash #REGiy on the stack.
  $CD3D,$03 Copy #REGde to #REGiy (using
. the stack).
@ $CD40 label=MakeRoomObjects_ForegroundObject
  $CD40,$01 Fetch the type and the number
. of places.
  $CD41,$02,b$01 Keep bits 0 to 2.
  $CD43,$01 Increment #REGa.
  $CD44,$01 Copy it to #REGc.
  $CD45,$01 Fetch the type and the number
. of places again.
  $CD46,$01 Increment #REGhl.
  $CD47,$01 Decrement #REGb.
  $CD48,$01 Fetch the first place.
  $CD49,$01 Increment #REGhl.
  $CD4A,$01 Stash #REGhl on the stack.
  $CD4B,$02 Move the type into bits 1 to
. 5.
  $CD4D,$02,b$01 Keep bits 1 to 5.
  $CD4F,$03 Jump to #R$CE00 if it is zero.
  $CD52,$05 Jump to #R$CDF0 if it is #N$3E.
  $CD57,$03 Fetch #R$5B20.
  $CD5A,$03 Call #R$CE06.
  $CD5D,$04 Fetch the address of the
. template.
@ $CD61 label=MakeRoomObjects_ForegroundPlace
  $CD61,$01 Stash #REGhl on the stack.
@ $CD62 label=MakeRoomObjects_ForegroundSprite
  $CD62,$02 Fetch the sprite number and
. increment #REGhl.
  $CD64,$03 Set the sprite number of the
. object.
  $CD67,$02 Fetch the width and increment
. #REGhl.
  $CD69,$03 Set the width of the object.
  $CD6C,$02 Fetch the depth and increment
. #REGhl.
  $CD6E,$03 Set the depth of the object.
  $CD71,$02 Fetch the height and increment
. #REGhl.
  $CD73,$03 Set the height of the object.
  $CD76,$02 Fetch the flags and increment
. #REGhl.
  $CD78,$03 Set the flags of the object.
  $CD7B,$03 Fetch the room number of the
. player.
  $CD7E,$03 Set the room number of the
. object.
N $CD81 The offset has the half step along
. the x axis in bit 0, the half step along
. the y axis in bit 1, and the offset up
. the z axis in bits 2 to 7. The place has
. the x position in bits 0 to 2, the y
. position in bits 3 to 5 and the height
. in bits 6 and 7. The x position of the
. object is the x position times #N($10),
. plus #N$08 if the half step is set, plus
. #N$48.
  $CD81,$03 Fetch #R$5B19.
  $CD84,$03 Move the half step along x
. into bit 3.
  $CD87,$02,b$01 Keep bit 3.
  $CD89,$01 Copy it to #REGe.
  $CD8A,$01 Fetch the place.
  $CD8B,$04 Move the x position into bits
. 4 to 6.
  $CD8F,$02,b$01 Keep bits 4 to 6.
  $CD91,$01 Add #REGe.
  $CD92,$02 Add #N$48.
  $CD94,$03 Set the x position of the
. object.
N $CD97 The y position is worked out in
. the same way from the y position and the
. half step along y.
  $CD97,$03 Fetch #R$5B19.
  $CD9A,$02 Move the half step along y
. into bit 3.
  $CD9C,$02,b$01 Keep bit 3.
  $CD9E,$01 Copy it to #REGe.
  $CD9F,$01 Fetch the place.
  $CDA0,$01 Move the y position into bits
. 4 to 6.
  $CDA1,$02,b$01 Keep bits 4 to 6.
  $CDA3,$01 Add #REGe.
  $CDA4,$02 Add #N$48.
  $CDA6,$03 Set the y position of the
. object.
N $CDA9 The z position is the height times
. #N($0C), plus the offset up the z axis,
. plus the floor.
  $CDA9,$01 Fetch the place.
  $CDAA,$02 Move the height into the low
. two bits.
  $CDAC,$02,b$01 Keep bits 0 and 1.
  $CDAE,$02 Multiply it by four.
  $CDB0,$01 Copy it to #REGe.
  $CDB1,$01 Double it.
  $CDB2,$01 Add #REGe.
  $CDB3,$01 Copy it to #REGe.
  $CDB4,$03 Fetch #R$5B19.
  $CDB7,$01 Add #REGe.
  $CDB8,$02,b$01 Keep bits 2 to 7.
  $CDBA,$01 Copy it to #REGe.
  $CDBB,$03 Fetch #R$5B0E.
  $CDBE,$01 Add #REGe.
  $CDBF,$03 Set the z position of the
. object.
  $CDC2,$01 Stash #REGbc on the stack.
  $CDC3,$03 Set #REGbc to #N($0009,$04,$04).
  $CDC6,$02 Add #REGbc to #REGiy.
  $CDC8,$02 Set #REGb to #N$17.
@ $CDCA label=MakeRoomObjects_ForegroundClear
  $CDCA,$04 Write #N$00.
  $CDCE,$02 Increment #REGiy.
  $CDD0,$02 Jump to #R$CDCA until #REGb is
. zero.
  $CDD2,$01 Restore #REGbc from the stack.
  $CDD3,$04 Jump to #R$CD62 if the next
. byte is not zero.
  $CDD7,$02 Restore #REGde and #REGhl from
. the stack.
  $CDD9,$01 Decrement #REGb.
  $CDDA,$02 Jump to #R$CDE8 if it is zero.
  $CDDC,$04 Jump to #R$CD40 if #REGc is
. zero.
  $CDE0,$02 Fetch the next place and
. increment #REGhl.
  $CDE2,$01 Stash #REGhl on the stack.
  $CDE3,$01 Exchange #REGde and #REGhl.
  $CDE4,$01 Copy it to #REGd.
  $CDE5,$03 Jump to #R$CD61.
@ $CDE8 label=MakeRoomObjects_Finish
  $CDE8,$03 Copy #REGiy to #REGde (using
. the stack).
  $CDEB,$02 Restore #REGiy from the stack.
  $CDED,$03 Jump to #R$CCD0.
@ $CDF0 label=MakeRoomObjects_SwitchTable
N $CDF0 Switch to the second table of
. object types.
  $CDF0,$03 Fetch #R$5B20.
  $CDF3,$02 Set #REGa to #N$40.
  $CDF5,$03 Call #R$CE06.
  $CDF8,$03 Set #R$5B20.
@ $CDFB label=MakeRoomObjects_Next
  $CDFB,$01 Decrement #REGb.
  $CDFC,$01 Restore #REGhl from the stack.
  $CDFD,$03 Jump to #R$CD40.
@ $CE00 label=MakeRoomObjects_SetOffset
N $CE00 Type #N$00 sets the position
. offset.
  $CE00,$01 Fetch #REGd.
  $CE01,$03 Set #R$5B19.
  $CE04,$02 Jump to #R$CDFB.

c $CE06 Add A To HL
@ $CE06 label=AddAToHL
D $CE06 Adds an unsigned number to
. #REGhl.
E $CE06 View the equivalent code in;
. #LIST
. { #CYBERUN$9BCF }
. { #GUNFRIGHT$D275 }
. { #KNIGHTLORE$D4F2 }
. { #NIGHTSHADE$E596 }
. { #PENTAGRAM$B519 }
. LIST#
R $CE06 A The number
R $CE06 HL The address
R $CE06 O:HL The new address
  $CE06,$01 Add #REGa to #REGl.
  $CE07,$01 Copy it to #REGl.
  $CE08,$01 Fetch #REGh.
  $CE09,$02 Add #N$00 with carry.
  $CE0B,$01 Copy it to #REGh.
  $CE0C,$01 Return.

c $CE0D Multiply A By DE
@ $CE0D label=MultiplyAByDE
D $CE0D Multiplies #REGa by #REGde.
E $CE0D View the equivalent code in;
. #LIST
. { #ATICATAC$9AAD }
. { #GUNFRIGHT$D03E }
. { #KNIGHTLORE$D4F9 }
. { #NIGHTSHADE$E0EE }
. { #TRANZAM$6F2F }
. { #UNDERWURLDE$AC68 }
. LIST#
R $CE0D A The multiplier
R $CE0D DE The multiplicand
R $CE0D O:HL The product
  $CE0D,$01 Stash #REGbc on the stack.
  $CE0E,$03 Set #REGhl to #N($0000,$04,$04).
  $CE11,$02 Set #REGb to #N$08.
@ $CE13 label=MultiplyAByDE_Loop
  $CE13,$01 Double #REGhl.
  $CE14,$03 Jump to #R$CE18 if the carry
. flag is not set.
  $CE17,$01 Add #REGde to #REGhl.
@ $CE18 label=MultiplyAByDE_Next
  $CE18,$02 Jump to #R$CE13 until #REGb is
. zero.
  $CE1A,$01 Restore #REGbc from the stack.
  $CE1B,$01 Return.

c $CE1C Clear Bytes
@ $CE1C label=ClearBytes
D $CE1C Fills a number of bytes with
. zero. The entry point at #R$CE1D fills
. them with the byte in #REGa.
E $CE1C View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D508 }
. { #PENTAGRAM$B513 }
. LIST#
R $CE1C B Number of bytes
R $CE1C DE Address of the first byte
  $CE1C,$01 Set #REGa to #N$00.
@ $CE1D label=FillBytes
  $CE1D,$01 Write #REGa.
  $CE1E,$01 Increment #REGde.
  $CE1F,$02 Jump to #R$CE1D until #REGb is
. zero.
  $CE21,$01 Return.

c $CE22 Pause Game
@ $CE22 label=PauseGame
D $CE22 Pauses the game if CAPS SHIFT or
. SPACE is pressed on its own. The game
. waits for the key to be let go of, then
. for it to be pressed again and let go of
. again. There is a beep for the start and
. for the end of the pause.
E $CE22 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D206 }
. { #KNIGHTLORE$D50E }
. { #NIGHTSHADE$E32C }
. LIST#
N $CE22 Return unless CAPS SHIFT or SPACE
. is pressed on its own.
  $CE22,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SHIFT / SPACE | Z / SYM | X / M | C / N | V / B }
. TABLE#
  $CE27,$03 Return if bit 0 is not set.
  $CE2A,$02,b$01 Keep bits 1 to 4.
  $CE2C,$01 Return if any of them is set.
@ $CE2D label=PauseGame_Release
N $CE2D Wait for the key to be let go of,
. then pressed and let go of again.
  $CE2D,$05 Read the keys.
  $CE32,$04 Jump to #R$CE2D if bit 0 is
. set.
  $CE36,$03 Call #R$B6B6.
@ $CE39 label=PauseGame_Wait
  $CE39,$05 Read the keys.
  $CE3E,$04 Jump to #R$CE39 if bit 0 is
. not set.
@ $CE42 label=PauseGame_Finish
  $CE42,$05 Read the keys.
  $CE47,$04 Jump to #R$CE42 if bit 0 is
. set.
  $CE4B,$03 Jump to #R$B6B6.

c $CE4E Clear Objects
@ $CE4E label=ClearObjects
D $CE4E Clears the objects table, which
. includes the player.
E $CE4E View the equivalent code in;
. #LIST
. { #PENTAGRAM$CB54 }
. LIST#
  $CE4E,$03 Point #REGhl at #R$5B88.
  $CE51,$03 Set #REGbc to #N$0700.
  $CE54,$02 Jump to #R$CE56.

c $CE56 Fill Memory
@ $CE56 label=FillMemory
D $CE56 Fills an area of memory with
. zero. The entry point at #R$CE58 fills
. it with the byte in #REGe.
E $CE56 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D6E1 }
. { #KNIGHTLORE$D53A }
. { #MARTIANOIDS$B1A3 }
. { #NIGHTSHADE$E5BA }
. { #PENTAGRAM$CB77 }
. { #UNDERWURLDE$9569 }
. LIST#
R $CE56 BC Number of bytes
R $CE56 HL Address of the first byte
  $CE56,$02 Set #REGe to #N$00.
@ $CE58 label=FillMemory_WithValue
  $CE58,$01 Write #REGe.
  $CE59,$01 Increment #REGhl.
  $CE5A,$01 Decrement #REGbc.
  $CE5B,$04 Jump to #R$CE58 if #REGbc is
. not zero.
  $CE5F,$01 Return.

c $CE60 Clear Screen Bitmap
@ $CE60 label=ClearScreenBitmap
D $CE60 Clears the bitmap of the screen.
E $CE60 View the equivalent code in;
. #LIST
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
. { #TRANZAM$7211 }
. LIST#
  $CE60,$03 Point #REGhl at #N$4000 (in the screen buffer).
  $CE63,$03 Set #REGbc to #N$1800.
  $CE66,$02 Jump to #R$CE56.

c $CE68 Clear Attributes
@ $CE68 label=ClearAttributes
D $CE68 Sets the attributes of the screen
. to bright red on black. The entry point
. at #R$CE6A sets them to the value in
. #REGa.
  $CE68,$02 Set #REGa to #N$42.
@ $CE6A label=FillAttributes
  $CE6A,$01 Copy it to #REGe.
  $CE6B,$03 Point #REGhl at #N$5800 (in the attribute buffer).
  $CE6E,$03 Set #REGbc to #N$0300.
  $CE71,$02 Jump to #R$CE58.

c $CE73 Clear Screen
@ $CE73 label=ClearScreen
D $CE73 Clears the screen to bright red
. on black, with a black border.
.
. #PUSHS #UDGTABLE { =h Before | =h After #R$CE73 }
. { #SIM(start=$A631,stop=$A676,sp=$F100,r=$80,clear=1)
. #SIM(start=$BA7E,stop=$BA95)
. #SCR$02(clear-screen-before)
. | #SIM(start=$CE73,stop=$0000,sp=$EC00)
. #SCR$02(clear-screen-after) } UDGTABLE# #POPS
E $CE73 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D55F }
. LIST#
  $CE73,$03 Set the border to black.
  $CE76,$03 Call #R$CE68.
  $CE79,$02 Jump to #R$CE60.

c $CE7B Clear Screen Buffer
@ $CE7B label=ClearScreenBuffer
D $CE7B Clears the buffer that the
. playing area is drawn in before it is
. copied to the screen.
  $CE7B,$03 Set #REGbc to #N$1800.
  $CE7E,$03 Point #REGhl at #R$D200.
  $CE81,$02 Set #REGe to #N$00.
  $CE83,$02 Jump to #R$CE58.

c $CE85 Update Screen
@ $CE85 label=UpdateScreen
D $CE85 Copies the screen buffer to the
. screen. The buffer holds the lines of
. the screen from the bottom up, #N$20
. bytes to a line, so the lines are copied
. from the bottom of the screen to the
. top.
.
. #PUSHS #UDGTABLE { =h Before | =h After #R$CE85 }
. { #SIM(start=$A631,stop=$A676,sp=$F100,r=$80,clear=1)
. #SIM(start=$BA7E,stop=$BA95)
. #SCR$02(update-screen-before)
. | #SIM(start=$A67F,stop=$A6FE)
. #SIM(start=$A715,stop=$A72E)
. #SIM(start=$CE85,stop=$0000,sp=$EC00)
. #SCR$02(update-screen-after) } UDGTABLE# #POPS
E $CE85 View the equivalent code in;
. #LIST
. { #PENTAGRAM$B178 }
. LIST#
N $CE85 Copy from #R$D200 to the last
. line of the bitmap.
  $CE85,$03 Point #REGhl at #R$D200.
  $CE88,$03 Point #REGde at #N$57E0 (in the screen buffer).
  $CE8B,$03 Set #REGbc to #N$C020.
@ $CE8E label=UpdateScreen_Line
  $CE8E,$02 Stash #REGbc and #REGde on the
. stack.
  $CE90,$02 Set #REGb to #N$00.
  $CE92,$02 Copy #REGc bytes from #REGhl
. to #REGde.
  $CE94,$01 Restore #REGde from the stack.
  $CE95,$01 Decrement #REGd.
  $CE96,$02 Fetch #REGd and invert it.
  $CE98,$02,b$01 Keep bits 0 to 2.
  $CE9A,$02 Jump to #R$CEA6 if it is not
. zero.
  $CE9C,$04 Subtract #N$20 from #REGe.
  $CEA0,$02 Jump to #R$CEA6 if carry is
. set.
  $CEA2,$04 Add #N$08 to #REGd.
@ $CEA6 label=UpdateScreen_Next
  $CEA6,$01 Restore #REGbc from the stack.
  $CEA7,$01 Decrement #REGb.
  $CEA8,$02 Jump to #R$CE8E until #REGb is
. zero.
  $CEAA,$01 Return.

c $CEAB Draw Changed Objects
@ $CEAB label=DrawChangedObjects
D $CEAB Updates the playing area for the
. objects that have changed. First the
. sprites of the objects that moved are
. wiped out of the screen buffer: for each
. object in the list at #R$C745 that is
. flagged to be wiped, the area covered by
. the old and the new position of its
. sprite is cleared, and the area is kept
. on the stack. Then the objects are drawn
. in order and the objects that the player
. is carrying are shown. Last, each of the
. areas that were kept is copied from the
. buffer to the screen. When the panel is
. to be drawn again, the whole screen is
. going to be drawn, so none of the areas
. are wiped.
E $CEAB View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D59F }
. { #PENTAGRAM$B19E }
. LIST#
N $CEAB Wipe each flagged sprite, unless
. the panel is to be drawn again.
  $CEAB,$04 Write #N$00 to #R$5B08.
  $CEAF,$02 Stash #REGix on the stack.
  $CEB1,$03 Fetch #R$5B17.
  $CEB4,$04 Jump to #R$CF5F if it is not
. zero.
  $CEB8,$03 Point #REGhl at #R$C745.
  $CEBB,$03 Set #R$5B2B.
@ $CEBE label=DrawChangedObjects_Wipe
  $CEBE,$03 Fetch #R$5B2B.
  $CEC1,$01 Fetch the index of the object.
  $CEC2,$01 Increment #REGhl.
  $CEC3,$03 Set #R$5B2B.
  $CEC6,$05 Jump to #R$CF5F if it is #N$FF.
  $CECB,$03 Call #R$CC96.
  $CECE,$03 Copy #REGhl to #REGix (using
. the stack).
  $CED1,$06 Jump to #R$CEBE if the object is not flagged to be wiped.
  $CED7,$04 Reset bit 5 of the flags.
N $CEDB The left edge of the area is the
. lower of the old and the new pixel x
. position. The width is worked out in
. bytes of the screen from there to the
. higher of the old and the new right
. edge.
  $CEDB,$06 Subtract the old pixel x from
. the new.
  $CEE1,$03 Jump to #R$CF55 if carry is
. set.
  $CEE4,$03 Copy the old pixel x to #REGc.
@ $CEE7 label=DrawChangedObjects_Width
  $CEE7,$03 Fetch the old pixel x
. position.
  $CEEA,$03 Divide it by eight.
  $CEED,$02,b$01 Keep bits 0 to 4.
  $CEEF,$03 Add the old width in bytes.
  $CEF2,$01 Copy it to #REGe.
  $CEF3,$03 Fetch the new pixel x
. position.
  $CEF6,$03 Divide it by eight.
  $CEF9,$02,b$01 Keep bits 0 to 4.
  $CEFB,$03 Add the new width in bytes.
  $CEFE,$03 Jump to #R$CF02 if it is lower
. than #REGe.
  $CF01,$01 Copy it to #REGe.
@ $CF02 label=DrawChangedObjects_WidthFetchLeft
  $CF02,$01 Fetch #REGc.
  $CF03,$03 Divide it by eight.
  $CF06,$02,b$01 Keep bits 0 to 4.
  $CF08,$01 Copy it to #REGb.
  $CF09,$01 Fetch #REGe.
  $CF0A,$01 Subtract #REGb.
  $CF0B,$01 Copy it to #REGh.
N $CF0C The bottom edge of the area is
. the lower of the old and the new pixel y
. position. The height is worked out from
. there to the higher of the old and the
. new top edge.
  $CF0C,$03 Fetch the new pixel y
. position.
  $CF0F,$03 Subtract the old pixel y.
  $CF12,$02 Jump to #R$CF5A if carry is
. set.
  $CF14,$03 Copy the old pixel y to #REGb.
@ $CF17 label=DrawChangedObjects_Height
  $CF17,$03 Fetch the old pixel y
. position.
  $CF1A,$03 Add the old height in lines.
  $CF1D,$01 Copy it to #REGe.
  $CF1E,$03 Fetch the new pixel y
. position.
  $CF21,$03 Add the new height in lines.
  $CF24,$01 Compare it with #REGe.
  $CF25,$02 Jump to #R$CF28 if it is #REGe
. or more.
  $CF27,$01 Fetch #REGe.
@ $CF28 label=DrawChangedObjects_HeightTakeBottom
  $CF28,$01 Subtract #REGb.
  $CF29,$01 Copy it to #REGl.
  $CF2A,$01 Fetch #REGb.
  $CF2B,$04 Jump to #R$CEBE if it is #N$C0
. or more.
  $CF2F,$01 Add #REGl.
  $CF30,$02 Subtract #N$C0.
  $CF32,$02 Jump to #R$CF38 if carry is
. set.
  $CF34,$02 Negate #REGa.
  $CF36,$01 Add #REGl.
  $CF37,$01 Copy it to #REGl.
@ $CF38 label=DrawChangedObjects_Keep
N $CF38 Wipe the area and keep it on the
. stack.
  $CF38,$03 Call #R$D135.
  $CF3B,$03 Call #R$D120.
  $CF3E,$03 Exchange #REGl and #REGc.
  $CF41,$03 Exchange #REGh and #REGb.
  $CF44,$03 Fetch #R$5B08.
  $CF47,$01 Increment #REGa.
  $CF48,$03 Set #R$5B08.
  $CF4B,$03 Stash #REGbc, #REGde and
. #REGhl on the stack.
  $CF4E,$01 Set #REGa to #N$00.
  $CF4F,$03 Call #R$BF83.
  $CF52,$03 Jump to #R$CEBE.
@ $CF55 label=DrawChangedObjects_Left
  $CF55,$03 Copy the new pixel x to #REGc.
  $CF58,$02 Jump to #R$CEE7.
@ $CF5A label=DrawChangedObjects_Bottom
  $CF5A,$03 Copy the new pixel y to #REGb.
  $CF5D,$02 Jump to #R$CF17.
@ $CF5F label=DrawChangedObjects_Draw
N $CF5F Draw the objects, then copy the
. wiped areas to the screen.
  $CF5F,$03 Call #R$C785.
  $CF62,$03 Call #R$BC9D.
  $CF65,$03 Point #REGhl at #R$5B08.
  $CF68,$03 Fetch #R$5B1E.
  $CF6B,$01 Add #R$5B08.
  $CF6C,$03 Set #R$5B1E.
@ $CF6F label=DrawChangedObjects_Copy
  $CF6F,$03 Point #REGhl at #R$5B08.
  $CF72,$04 Jump to #R$CF82 if it is zero.
  $CF76,$01 Decrement #R$5B08.
  $CF77,$03 Restore #REGhl, #REGde and
. #REGbc from the stack.
  $CF7A,$03 Exchange #REGb and #REGc.
  $CF7D,$03 Call #R$CF85.
  $CF80,$02 Jump to #R$CF6F.
@ $CF82 label=DrawChangedObjects_Finish
  $CF82,$02 Restore #REGix from the stack.
  $CF84,$01 Return.

c $CF85 Copy Block To Screen
@ $CF85 label=CopyBlockToScreen
D $CF85 Copies an area of the screen
. buffer to the screen, a line at a time.
E $CF85 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D67C }
. { #PENTAGRAM$B278 }
. LIST#
R $CF85 B Number of lines
R $CF85 C Number of bytes in a line
R $CF85 DE Address of the first line on the screen
R $CF85 HL Address of the first line in the buffer
N $CF85 Copy one line, then move up.
  $CF85,$03 Stash #REGbc, #REGde and
. #REGhl on the stack.
  $CF88,$02 Set #REGb to #N$00.
  $CF8A,$02 Copy #REGc bytes from #REGhl
. to #REGde.
  $CF8C,$01 Restore #REGhl from the stack.
  $CF8D,$04 Move #REGhl up by #N($0020,$04,$04) bytes.
  $CF91,$01 Restore #REGde from the stack.
  $CF92,$01 Decrement #REGd.
  $CF93,$02 Fetch #REGd and invert it.
  $CF95,$02,b$01 Keep bits 0 to 2.
  $CF97,$02 Jump to #R$CFA3 if it is not
. zero.
  $CF99,$04 Subtract #N$20 from #REGe.
  $CF9D,$02 Jump to #R$CFA3 if carry is
. set.
  $CF9F,$04 Add #N$08 to #REGd.
@ $CFA3 label=CopyBlockToScreen_Next
  $CFA3,$01 Restore #REGbc from the stack.
  $CFA4,$02 Jump to #R$CF85 until #REGb is
. zero.
  $CFA6,$01 Return.

c $CFA7 Build Lookup Tables
@ $CFA7 label=BuildLookupTables
D $CFA7 Builds the two tables that the
. sprite routines use. The first is the
. set of tables of shifted bytes (#R$F200)
. in pages #N$F2 to #N$FF: for each shift
. of one to seven bits there is a page
. with the inverse of every byte shifted,
. and a page after it with the inverse of
. the bits that are pushed out into the
. next byte. The second is the table of
. every byte with its bits reversed
. (#R$F100).
E $CFA7 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D69E }
. { #PENTAGRAM$B29A }
. LIST#
N $CFA7 Build the tables of shifted
. bytes.
  $CFA7,$02 Set #REGl to #N$00.
@ $CFA9 label=BuildLookupTables_Shift
  $CFA9,$02 Set #REGd to #N$00.
  $CFAB,$01 Copy #REGl to #REGe.
  $CFAC,$02 Set #REGh to #N$FF.
  $CFAE,$02 Set #REGb to #N$07.
@ $CFB0 label=BuildLookupTables_ShiftStep
  $CFB0,$02 Shift #REGe left.
  $CFB2,$02 Rotate #REGd left.
  $CFB4,$01 Fetch #REGe.
  $CFB5,$01 Invert it.
  $CFB6,$01 Write it.
  $CFB7,$01 Decrement #REGh.
  $CFB8,$01 Fetch #REGd.
  $CFB9,$01 Invert it.
  $CFBA,$01 Write it.
  $CFBB,$01 Decrement #REGh.
  $CFBC,$02 Jump to #R$CFB0 until #REGb is
. zero.
  $CFBE,$01 Increment #REGl.
  $CFBF,$02 Jump to #R$CFA9 if #REGl is
. not zero.
N $CFC1 Build the table of reversed
. bytes.
  $CFC1,$03 Point #REGhl at #R$F100.
@ $CFC4 label=BuildLookupTables_Reverse
  $CFC4,$01 Copy #REGl to #REGd.
  $CFC5,$02 Set #REGb to #N$08.
@ $CFC7 label=BuildLookupTables_ReverseBit
  $CFC7,$02 Shift #REGd right.
  $CFC9,$02 Rotate #REGe left.
  $CFCB,$02 Jump to #R$CFC7 until #REGb is
. zero.
  $CFCD,$01 Write #REGe.
  $CFCE,$01 Increment #REGl.
  $CFCF,$02 Jump to #R$CFC4 if #REGl is
. not zero.
  $CFD1,$01 Return.

c $CFD2 Calculate Pixel Coordinates
@ $CFD2 label=CalculatePixelCoordinates
D $CFD2 Works out the pixel position of an
. object on the screen from its x, y and z
. positions. The pixel x position is x + y
. - #N$80 and the pixel y position (from
. the bottom of the screen) is half of y -
. x + #N($80), plus z, less #N($28), each with
. the adjustments of the object added.
. While #R$5B24 is set the pixel positions
. are left as the scene has set them.
E $CFD2 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D6C9 }
. { #PENTAGRAM$B2C5 }
. LIST#
R $CFD2 IX The address of the object
R $CFD2 O:F The carry flag is set if the sprite is on the screen
N $CFD2 Return if the scene has set the
. positions.
  $CFD2,$03 Fetch #R$5B24.
  $CFD5,$03 Return with the carry flag
. set if it is not zero.
N $CFD8 Work out the pixel x position.
  $CFD8,$03 Fetch the x position of the
. object.
  $CFDB,$03 Add the y position.
  $CFDE,$02 Subtract #N$80.
  $CFE0,$03 Add the pixel x adjustment.
  $CFE3,$03 Set the pixel x position.
N $CFE6 Work out the pixel y position.
  $CFE6,$03 Fetch the y position of the
. object.
  $CFE9,$03 Subtract the x position.
  $CFEC,$02 Add #N$80.
  $CFEE,$02 Halve it.
  $CFF0,$03 Add the z position.
  $CFF3,$02 Subtract #N$28.
  $CFF5,$03 Add the pixel y adjustment.
  $CFF8,$03 Set the pixel y position.
  $CFFB,$02 Compare it with #N$C0.
  $CFFD,$01 Return.

c $CFFE Get Sprite Address
@ $CFFE label=GetSpriteAddress
D $CFFE Fetches the sprite for the sprite
. number of an object from #R$7827. The
. data of the sprite is flipped, in place,
. if it is not the same way round as the
. flags of the object say. If there is no
. sprite for the sprite number, this
. returns to the routine that called the
. routine that called it.
E $CFFE View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D6EF }
. { #PENTAGRAM$B2EE }
. LIST#
R $CFFE IX The address of the object
R $CFFE O:DE The address of the sprite
N $CFFE Find the address of the sprite.
  $CFFE,$03 Fetch the sprite number.
  $D001,$02 Set #REGh to #N$00.
  $D003,$01 Double #REGhl.
  $D004,$03 Point #REGbc at #R$7827.
  $D007,$01 Add #REGbc to #REGhl.
  $D008,$03 Fetch the address of the
. sprite.
N $D00B Flip it if there is a sprite.
  $D00B,$02 Fetch the width and test it.
  $D00D,$03 Jump to #R$D174 if it is not
. zero.
  $D010,$02 Drop the return address.
  $D012,$01 Return.

c $D013 Draw Object
@ $D013 label=DrawObject
D $D013 Draws an object into #R$D200. An
. object that has the sprite number #N$01
. is removed instead, by making it null.
E $D013 Continue on to #R$D027.
E $D013 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D704 }
. { #PENTAGRAM$B3D3 }
. LIST#
R $D013 IX The address of the object
N $D013 Remove the object if it is
. retired.
  $D013,$03 Fetch the sprite number.
  $D016,$04 Jump to #R$D01F if it is not
. #N$01.
  $D01A,$04 Write #N$00 to the sprite
. number.
  $D01E,$01 Return.
N $D01F Find the position and draw the
. sprite.
@ $D01F label=DrawObject_Draw
  $D01F,$04 Reset bit 4 of the flags.
  $D023,$03 Call #R$CFD2.
  $D026,$01 Return if the sprite is not on the screen.

c $D027 Print Sprite
@ $D027 label=PrintSprite
D $D027 Draws the sprite of an object
. into #R$D200, at the pixel position of
. the object. A sprite has a width byte
. (the vertical flip in bit 7, the
. horizontal flip in bit 6 and the width
. in columns in the low bits), a height
. byte, and then the data for each line
. from the top. Each column of a line is a
. pair of bytes: a mask byte, then a data
. byte. The mask clears the bits of the
. background and the data sets bits. A
. sprite that does not start on a byte
. boundary has each pair shifted across
. two bytes of the buffer, with the tables
. built by #R$CFA7. The routine copies the
. sprite with unrolled code, which it
. enters part of the way along, so that it
. does as many columns as the sprite has.
. To do this it changes the code, and it
. uses the stack pointer to read the data
. of the sprite.
E $D027 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D718 }
. LIST#
R $D027 IX The address of the object
N $D027 Find the sprite and choose the
. draw path.
  $D027,$03 Call #R$CFFE.
  $D02A,$03 Fetch the pixel x position.
  $D02D,$02,b$01 Keep bits 0 to 2.
  $D02F,$02 Jump to #R$D07E if it is zero.
N $D031 Choose the page of the shift
. table.
  $D031,$01 Double it.
  $D032,$02,b$01 Keep bits 1 to 3.
  $D034,$02,b$01 Set bits 4 to 7.
  $D036,$01 Copy it to #REGh.
  $D037,$01 Fetch the width byte of the
. sprite.
  $D038,$01 Increment #REGde.
  $D039,$02,b$01 Keep bits 0 to 2.
  $D03B,$01 Increment #REGa.
  $D03C,$01 Copy it to #REGb.
  $D03D,$03 Set the width in bytes of the
. object.
  $D040,$01 Decrement #REGa.
  $D041,$02,b$01 Keep bits 0 to 2.
  $D043,$04 Multiply it by sixteen.
  $D047,$02 Negate it.
  $D049,$02 Add #N$50.
N $D04B Change the jump and the step.
@ $D04B label=PrintSprite_Patch
  $D04B,$03 Write it to #R$D0BB(#N$D0BC).
  $D04E,$01 Fetch #REGb.
  $D04F,$01 Invert it.
  $D050,$02 Add #N$22.
  $D052,$03 Write it to #R$D10F(#N$D110).
N $D055 Clip the sprite to the top of the
. screen.
  $D055,$01 Fetch the height of the
. sprite.
  $D056,$01 Increment #REGde.
  $D057,$03 Set the height in lines of the
. object.
  $D05A,$03 Add the pixel y position.
  $D05D,$02 Subtract #N$C0.
  $D05F,$02 Jump to #R$D069 if carry is
. set.
  $D061,$02 Negate #REGa.
  $D063,$03 Add the height in lines.
  $D066,$03 Set the height in lines of the
. object.
N $D069 Draw the rows that are on the
. screen.
@ $D069 label=PrintSprite_Draw
  $D069,$03 Fetch the pixel x position.
  $D06C,$03 Fetch the pixel y position.
  $D06F,$03 Call #R$D120.
  $D072,$04 Set #R$5B09.
  $D076,$03 Point the stack at the sprite
. data.
  $D079,$03 Fetch the number of lines.
  $D07C,$02 Jump to #R$D0B9.
N $D07E The sprite is aligned, so the
. bytes do not need to be shifted.
@ $D07E label=PrintSprite_Aligned
  $D07E,$01 Fetch the width byte of the
. sprite.
  $D07F,$01 Increment #REGde.
  $D080,$02,b$01 Keep bits 0 to 3.
  $D082,$03 Set the width in bytes of the
. object.
  $D085,$01 Copy it to #REGb.
  $D086,$03 Multiply it by eight.
  $D089,$02 Negate it.
  $D08B,$02 Subtract #N$06.
  $D08D,$02 Jump to #R$D04B.

c $D08F Draw Aligned Columns
@ $D08F label=DrawAlignedColumns
D $D08F Unrolled code that draws the
. columns of a sprite that is on a byte
. boundary. Each column of a line takes a
. pair of bytes off the stack, which are
. the mask and the data, clears the bits
. of the mask in the byte of the buffer
. and sets the bits of the data. The code
. is entered at the column that gives the
. number of columns that the sprite has,
. and the last column carries on at
. #R$D10E.
E $D08F View the equivalent code in;
. #LIST
. { #GUNFRIGHT$BE5B }
. { #KNIGHTLORE$D780 }
. { #NIGHTSHADE$E49F }
. { #PENTAGRAM$B44F }
. LIST#
N $D08F Draw the five unrolled columns.
  $D08F,$08 Draw the first column of a
. sprite that has five.
  $D097,$08 Draw the second column of a
. sprite that has four or five.
  $D09F,$08 Draw the third column of a
. sprite that has three or more.
  $D0A7,$08 Draw the fourth column of a
. sprite that has two or more.
  $D0AF,$07 Draw the last column.
  $D0B6,$03 Jump to #R$D10E.

c $D0B9 Draw Lines
@ $D0B9 label=DrawLines
D $D0B9 Draws the lines of a sprite one
. after the other. For each line the code
. jumps into the unrolled code, at a place
. that depends on the width of the sprite,
. and that is set by the jump that is
. changed by #R$D027. The code for a
. sprite that is not on a byte boundary
. takes a pair of bytes off the stack,
. which are the mask and the data, shifts
. them across the two bytes of the buffer
. that they fall into with the table of
. shifted bytes in #REGh, and keeps what
. is left of the second byte to go with
. the next pair. A sprite on a byte
. boundary jumps into #R$D08F instead.
E $D0B9 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D7AA }
. { #PENTAGRAM$B479 }
. LIST#
N $D0B9 Jump into the unrolled columns.
  $D0B9,$01 Copy #REGa to #REGa'.
  $D0BA,$01 Fetch the first byte of the
. buffer.
@ $D0BB label=DrawLines_Jump
  $D0BB,$02 Jump into the unrolled
. columns.
N $D0BD The patched jump at #R$D0BB lands
. here when the sprite is five columns
. wide.
@ $D0BD label=DrawLines_FirstPair
  $D0BD,$10 Draw the first pair of a
. sprite that has five.
  $D0CD,$10 Draw the second pair of a
. sprite that has four or five.
  $D0DD,$10 Draw the third pair of a
. sprite that has three or more.
  $D0ED,$10 Draw the fourth pair of a
. sprite that has two or more.
  $D0FD,$10 Draw the last pair.
  $D10D,$01 Write the last byte of the
. line.
N $D10E Step on to the next line. The
. aligned columns jump here after their
. last column.
@ $D10E label=DrawLines_Next
  $D10E,$01 Fetch #REGc.
@ $D10F label=DrawLines_Step
  $D10F,$02 Add the step, which is
. changed for the width of the sprite.
  $D111,$01 Copy it to #REGc.
  $D112,$01 Fetch #REGb.
  $D113,$02 Add #N$00 with carry.
  $D115,$01 Copy it to #REGb.
  $D116,$01 Fetch #REGa'.
  $D117,$01 Decrement #REGa.
  $D118,$03 Jump to #R$D0B9 if it is not
. zero.
  $D11B,$05 Fetch #R$5B09 and return.

c $D120 Calculate Buffer Address
@ $D120 label=CalculateBufferAddress
D $D120 Finds the address in #R$D200 of
. the byte that holds a pixel. The buffer
. has the lines of the screen from the
. bottom, #N$20 bytes to a line.
E $D120 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D811 }
. { #PENTAGRAM$B37F }
. LIST#
R $D120 B The pixel y position
R $D120 C The pixel x position
R $D120 O:BC The address in the buffer
N $D120 Work out the byte from the
. position.
  $D120,$01 Stash #REGhl on the stack.
  $D121,$04 Divide #REGbc by two.
  $D125,$04 Divide #REGbc by four.
  $D129,$04 Divide #REGbc by eight.
  $D12D,$03 Point #REGhl at #R$D200.
  $D130,$01 Add #REGbc to #REGhl.
  $D131,$02 Copy #REGhl to #REGbc.
  $D133,$02 Restore #REGhl from the stack
. and return.

c $D135 Calculate Screen Address
@ $D135 label=CalculateScreenAddress
D $D135 Finds the address on the screen of
. the byte that holds a pixel. The pixel y
. position is from the bottom of the
. screen.
E $D135 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D24F }
. { #KNIGHTLORE$D826 }
. { #NIGHTSHADE$E556 }
. { #PENTAGRAM$B394 }
. LIST#
R $D135 B The pixel y position
R $D135 C The pixel x position
R $D135 O:DE The address on the screen
N $D135 Work out the byte from the
. position.
  $D135,$04 Divide #REGc by eight.
  $D139,$02,b$01 Keep bits 0 to 4.
  $D13B,$01 Copy it to #REGe.
  $D13C,$02 Fetch #REGb and invert it.
  $D13E,$02,b$01 Keep bits 0 to 2.
  $D140,$01 Copy it to #REGa'.
  $D141,$02 Fetch #REGb and invert it.
  $D143,$02 Move the character row into
. bits 5 to 7.
  $D145,$02,b$01 Keep bits 5 to 7.
  $D147,$01 Merge #REGe.
  $D148,$01 Copy it to #REGe.
  $D149,$02 Fetch #REGb and invert it.
  $D14B,$03 Move the third into bits 3 and
. 4.
  $D14E,$02,b$01 Keep bits 3 and 4.
  $D150,$01 Copy it to #REGd.
  $D151,$01 Fetch #REGa'.
  $D152,$01 Merge #REGd.
  $D153,$02 Add #N$38.
  $D155,$01 Copy it to #REGd.
  $D156,$01 Return.

c $D157 Calculate Attribute Address
@ $D157 label=CalculateAttributeAddress
D $D157 Finds the address in the
. attribute file of the character square
. that holds a pixel. The pixel y position
. is from the bottom of the screen.
E $D157 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D848 }
. { #PENTAGRAM$B3B6 }
. LIST#
R $D157 H The pixel y position
R $D157 L The pixel x position
R $D157 O:DE The address of the attribute
N $D157 Work out the square from the
. position.
  $D157,$01 Stash #REGhl on the stack.
  $D158,$03 Fetch #REGh, invert it and
. copy it to #REGh.
  $D15B,$08 Shift #REGh right four times.
  $D163,$02 Rotate #REGl right.
  $D165,$04 Shift the next bit into
. #REGl.
  $D169,$04 Shift the next bit into
. #REGl.
  $D16D,$03 Point #REGde at #N$5700.
  $D170,$01 Add #REGde to #REGhl.
  $D171,$01 Exchange #REGde and #REGhl.
  $D172,$01 Restore #REGhl from the stack.
  $D173,$01 Return.

c $D174 Flip Sprite
@ $D174 label=FlipSprite
D $D174 Flips the data of a sprite in
. place, if its flags are not the same as
. the flags of the object that is going to
. be drawn. The width byte of a sprite has
. the vertical flip in bit 7 and the
. horizontal flip in bit 6. The sprite is
. flipped vertically by swapping its
. lines, and horizontally by reversing the
. bits of each byte and the order of the
. bytes of each line, with #R$F100.
E $D174 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D865 }
. { #NIGHTSHADE$E353 }
. LIST#
R $D174 DE The address of the sprite
R $D174 IX The address of the object
R $D174 O:DE The address of the sprite
N $D174 Flip the sprite from top to
. bottom if needed.
  $D174,$01 Stash #REGde on the stack.
  $D175,$01 Fetch the width byte of the
. sprite.
  $D176,$03 Merge the flags of the object.
  $D179,$02,b$01 Keep bit 7.
  $D17B,$02 Jump to #R$D1AF if it is zero.
  $D17D,$01 Fetch the width byte again.
  $D17E,$02,b$01 Toggle bit 7.
  $D180,$01 Write the width byte.
  $D181,$01 Double it.
  $D182,$02,b$01 Keep bits 1 to 6.
  $D184,$01 Copy it to #REGb.
  $D185,$01 Increment #REGde.
  $D186,$01 Fetch the height.
  $D187,$01 Copy it to #REGc.
  $D188,$01 Increment #REGde.
  $D189,$01 Stash #REGde on the stack.
  $D18A,$03 Set #REGde to the line length.
  $D18D,$03 Call #R$CE0D.
  $D190,$01 Restore #REGde from the stack.
  $D191,$01 Add #REGde to #REGhl.
  $D192,$01 Exchange #REGde and #REGhl.
  $D193,$01 Fetch #REGb.
  $D194,$03 Call #R$CE06.
  $D197,$01 Decrement #REGde.
  $D198,$01 Decrement #REGhl.
  $D199,$02 Halve #REGc.
@ $D19B label=FlipSprite_Lines
  $D19B,$01 Stash #REGbc on the stack.
@ $D19C label=FlipSprite_Bytes
  $D19C,$01 Fetch a byte of the last line.
  $D19D,$01 Fetch a byte of the first
. line.
  $D19E,$01 Write the last-line byte.
  $D19F,$01 Fetch the first-line byte.
  $D1A0,$01 Write it to the last line.
  $D1A1,$01 Decrement #REGhl.
  $D1A2,$01 Decrement #REGde.
  $D1A3,$02 Jump to #R$D19C until #REGb is
. zero.
  $D1A5,$01 Restore #REGbc from the stack.
  $D1A6,$01 Fetch #REGb.
  $D1A7,$02 Double it.
  $D1A9,$03 Call #R$CE06.
  $D1AC,$01 Decrement #REGc.
  $D1AD,$02 Jump to #R$D19B if it is not
. zero.
N $D1AF Flip the sprite from left to
. right if needed.
@ $D1AF label=FlipSprite_Horizontal
  $D1AF,$02 Restore #REGde from the stack
. and stash it again.
  $D1B1,$01 Fetch the width byte of the
. sprite.
  $D1B2,$03 Merge the flags of the object.
  $D1B5,$02,b$01 Keep bit 6.
  $D1B7,$02 Jump to #R$D1E9 if it is zero.
  $D1B9,$01 Fetch the width byte again.
  $D1BA,$02,b$01 Toggle bit 6.
  $D1BC,$01 Write the width byte.
  $D1BD,$02,b$01 Keep bits 0 to 3.
  $D1BF,$01 Copy it to #REGb.
  $D1C0,$01 Copy it to #REGc.
  $D1C1,$01 Increment #REGde.
  $D1C2,$01 Fetch the height.
  $D1C3,$01 Copy it to #REGa'.
  $D1C4,$01 Increment #REGde.
  $D1C5,$01 Exchange #REGde and #REGhl.
  $D1C6,$01 Stash #REGhl on the stack.
  $D1C7,$01 Switch to the shadow
. registers.
  $D1C8,$01 Restore #REGhl' from the
. stack.
  $D1C9,$02 Set #REGb' to #N$F1.
  $D1CB,$01 Switch back to the main
. registers.
@ $D1CC label=FlipSprite_Line
  $D1CC,$01 Switch to the shadow
. registers.
  $D1CD,$01 Fetch the mask byte.
  $D1CE,$01 Fetch the reversed byte.
  $D1CF,$01 Copy it to #REGe.
  $D1D0,$01 Increment #REGhl.
  $D1D1,$01 Fetch the data byte.
  $D1D2,$01 Fetch the reversed byte.
  $D1D3,$01 Copy it to #REGd.
  $D1D4,$01 Increment #REGhl.
  $D1D5,$01 Stash #REGde on the stack.
  $D1D6,$01 Switch back to the main
. registers.
  $D1D7,$02 Jump to #R$D1CC until #REGb is
. zero.
  $D1D9,$01 Copy #REGc to #REGb.
@ $D1DA label=FlipSprite_Column
  $D1DA,$01 Restore #REGde from the stack.
  $D1DB,$01 Write #REGe.
  $D1DC,$01 Increment #REGhl.
  $D1DD,$01 Write #REGd.
  $D1DE,$01 Increment #REGhl.
  $D1DF,$02 Jump to #R$D1DA until #REGb is
. zero.
  $D1E1,$01 Fetch #REGa'.
  $D1E2,$01 Decrement #REGa.
  $D1E3,$02 Jump to #R$D1E9 if it is zero.
  $D1E5,$01 Copy it to #REGa'.
  $D1E6,$01 Copy #REGc to #REGb.
  $D1E7,$02 Jump to #R$D1CC.
@ $D1E9 label=FlipSprite_Finish
  $D1E9,$01 Restore #REGde from the stack.
  $D1EA,$01 Return.

t $D1EB Messaging: Copyright
@ $D1EB label=CopyrightMessage
D $D1EB The copyright message, which is
. not used by the game.
  $D1EB,$15,$15 "COPYRIGHT 1984 A.C.G."

g $D200 Screen Buffer
@ $D200 label=ScreenBuffer
D $D200 The buffer in which the screen is
. built (see #R$CE85), one byte for each
. eight pixels. The buffer is built from
. the bottom of the screen up.
S $D200,$F0,$20 The start of the bottom
. lines of the screen.
@ $D2F0 label=ScreenBuffer_Lives
S $D2F0,$012D,$20 The position of the
. lives in the panel.
@ $D41D label=ScreenBuffer_LightYearsLastDigit
S $D41D,$DD,$20 The position of the
. bottom row of the last digit of the
. light years remaining counter in the
. panel.
@ $D4FA label=ScreenBuffer_LightYears
S $D4FA,$EA,$20 The position of the light
. years remaining counter in the panel.
@ $D5E4 label=ScreenBuffer_ChambersActivated
S $D5E4,$0612,$20 The position of the
. number of chambers that have been
. activated in the panel.
@ $DBF6 label=ScreenBuffer_CryonautsLost
S $DBF6,$0201,$20 The position of the
. number of cryonauts lost in the game
. over display.
@ $DDF7 label=ScreenBuffer_ChambersNotActivated
S $DDF7,$0400,$20 The position of the
. number of chambers not activated in the
. game over display.
@ $E1F7 label=ScreenBuffer_ChambersFoundActivated
S $E1F7,$0809,$20 The position of the
. number of chambers activated in the game
. over display, and the rest of the
. buffer.

u $EA00 Unused
S $EA00,$03FA,$08

i $EDFA

g $F100 Reversed Byte Table
@ $F100 label=ReversedByteTable
D $F100 The table of every byte with its
. bits in the opposite order, which is
. built by #R$CFA7. It is used to flip
. sprites from left to right.
S $F100,$0100,$20 The reversed byte for
. each value from #N$00 to #N$FF.

g $F200 Shifted Byte Tables
@ $F200 label=ShiftedByteTables
D $F200 The tables of shifted bytes that
. are built by #R$CFA7 and used to draw a
. sprite that does not start on a byte
. boundary. There are two pages for each
. shift of one to seven bits to the right,
. with the first page of the pair at #N$F0
. plus twice the shift, so the table for a
. shift of one bit starts at #N$F200 and
. the table for a shift of seven bits
. starts at #N$FE00. The first page of a
. pair has the inverse of the byte after
. it has been shifted to the right, and
. the second has the inverse of the bits
. that were pushed out of the byte, which
. go into the next byte of the line.
S $F200,$0E00,$0200 Two pages for each of
. the seven shifts, from one bit to
. seven.
