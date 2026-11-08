; Copyright Ashby Computers & Graphics Ltd 1984, Rare Ltd, 2026 ArcadeGeek LTD.
; NOTE: Disassembly is Work-In-Progress.
; Labels are named after the routine or table, with a suffix for each part.

> $4000 @org=$4000
> $4000 @rom
> $4000 @start
> $4000 @expand=#DEF(#POKE()(anchor,text) #LINK(Pokes#$anchor)($text))
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))
> $4000 @set-handle-unsupported-macros=1
b $4000 Loading Screen
@ $4000 label=Loading
D $4000 #UDGTABLE { =h Knight Lore Loading Screen. }
. { #SCR$02(loading) } UDGTABLE#
B $4000,$1800,$20 Pixels.
B $5800,$0300,$20 Attributes.

i $5B00

g $5BA0 Random Seed 1
@ $5BA0 label=RandomSeed1
D $5BA0 The first seed that the game uses for random numbers. At the start of a
. game it is set to the low byte of the FRAMES system variable, and it counts up
. while the menu waits for the player to start. The game uses it to choose the
. room that the player starts in, the starting places of the special objects and
. the number of times that the objects that the player must collect are
. shuffled. This is the top of the stack, which grows down from here.
B $5BA0,$01

u $5BA1 Unused
B $5BA1,$01

g $5BA2 Frame Counter
@ $5BA2 label=FrameCounter
D $5BA2 Counts the frames of the game, which also makes it an address that moves
. through the ROM, so that the bytes that it finds there can be used as random
. numbers. The low bits of it time the animations of the game.
W $5BA2,$02

g $5BA4 Control Method
@ $5BA4 label=ControlMethod
D $5BA4 The way that the player chose to control the game on the menu.
. #TABLE(default,centre,left)
. { =h Bits | =h Meaning }
. { #N$03 | The controls are directional (a joystick that moves the player in
. the direction that it is pushed) }
. { #N$01-#N$02 | #N$00 is the keyboard, #N$01 is the Kempston joystick, #N$02
. is the Cursor joystick and #N$03 is the Interface II joystick }
. TABLE#
B $5BA4,$01

g $5BA5 Random Seed 2
@ $5BA5 label=RandomSeed2
D $5BA5 The second seed that the game uses for random numbers. It changes every
. time that the game updates an object, and every frame, by adding in the
. refresh register, the frame counter and the byte that the frame counter points
. at.
B $5BA5,$01

g $5BA6 Previous Control Method
@ $5BA6 label=PreviousControlMethod
D $5BA6 The control method as it was before the keys of the menu were read, so
. that the menu can tell when a key has changed it and beep.
B $5BA6,$01

u $5BA7 Unused
B $5BA7,$01

g $5BA8 Wiped Area Count
@ $5BA8 label=WipedAreaCount
D $5BA8 The number of areas of the screen that the game has to copy to the
. screen at the end of this frame, because the objects in them moved. The
. variables from here onwards are cleared at the start of every game.
B $5BA8,$01

g $5BA9 Saved Stack Pointer
@ $5BA9 label=SavedStackPointer
D $5BA9 The stack pointer, which is kept here while the sprite routine is using
. the stack pointer to read the data of a sprite.
W $5BA9,$02

g $5BAB Room Size X
@ $5BAB label=RoomSizeX
D $5BAB The distance in the X direction from the middle of the room (#N$80) to
. its walls, which comes from the table of room sizes at #R$6248.
B $5BAB,$01

g $5BAC Room Size Y
@ $5BAC label=RoomSizeY
D $5BAC The distance in the Y direction from the middle of the room (#N$80) to
. its walls, which comes from the table of room sizes at #R$6248.
B $5BAC,$01

g $5BAD Room Attribute
@ $5BAD label=RoomAttribute
D $5BAD The attribute that the room is coloured with, which is the bright colour
. that is stored in the room data.
B $5BAD,$01

g $5BAE Floor Height
@ $5BAE label=FloorHeight
D $5BAE The Z coordinate of the floor of the room, which comes from the table of
. room sizes at #R$6248. It is #N$80 in every room.
B $5BAE,$01

g $5BAF Portcullis Moving Flag
@ $5BAF label=PortcullisMovingFlag
D $5BAF Is non-zero while a portcullis is moving up or down.
B $5BAF,$01

g $5BB0 Portcullis Lower Count
@ $5BB0 label=PortcullisLowerCount
D $5BB0 The number of times that the portcullis in the room has been lowered
. since the room was entered.
B $5BB0,$01

g $5BB1 Transform Flag
@ $5BB1 label=TransformFlag
D $5BB1 Is zero when the player is not changing form. The sun and the moon set
. it to #N$01 when it is time for the player to change from a human to a wulf or
. back. Then, when the transformation starts, it is set to the graphic number of
. the legs of the player, which is used to give the player the right form again
. when it ends.
B $5BB1,$01

g $5BB2 Not First Room Flag
@ $5BB2 label=NotFirstRoomFlag
D $5BB2 Is zero until the first frame of the game has been run, and non-zero
. after that. The game uses it to avoid saving the special objects of a room
. that the player has not been in yet when it builds the first room.
B $5BB2,$01

g $5BB3 Pickup Drop Pressed Flag
@ $5BB3 label=PickupDropPressedFlag
D $5BB3 Is non-zero while the control for picking up or dropping an object is
. held down, so that holding it does not pick up and drop an object on every
. frame.
B $5BB3,$01

g $5BB4 Objects Carried Changed Flag
@ $5BB4 label=ObjectsCarriedChangedFlag
D $5BB4 Is non-zero when the objects that the player is carrying have changed,
. to tell the game that it has to show them in the panel again.
B $5BB4,$01

g $5BB5 Controls Pressed
@ $5BB5 label=ControlsPressed
D $5BB5 The controls that are pressed, which are read by #R$D022 and tested by
. the routines that need them.
. #TABLE(default,centre,left)
. { =h Bit | =h Control }
. { #N$00 | Left }
. { #N$01 | Right }
. { #N$02 | Forward }
. { #N$03 | Jump }
. { #N$04 | Pick up or drop (or down, with the directional controls) }
. { #N$05 | Pick up or drop, with the directional controls }
. TABLE#
B $5BB5,$01

g $5BB6 Text Attribute
@ $5BB6 label=TextAttribute
D $5BB6 The attribute that the text that is being printed is coloured with.
B $5BB6,$01

g $5BB7 Redraw Panel Flag
@ $5BB7 label=RedrawPanelFlag
D $5BB7 Is non-zero when the panel, the border, the sun or moon and the other
. information of the screen have to be drawn again, which is when a new room has
. been built. It is cleared when the game loop has drawn them.
B $5BB7,$01

g $5BB8 Border Drawn Flag
@ $5BB8 label=BorderDrawnFlag
D $5BB8 Is non-zero when the border has been drawn around the message on the
. screen. It is cleared when the menu and the end of the game are started, so
. that they draw the border.
B $5BB8,$01

g $5BB9 Days
@ $5BB9 label=Days
D $5BB9 The number of days that have passed, as two binary coded decimal digits.
B $5BB9,$01

g $5BBA Lives
@ $5BBA label=Lives
D $5BBA The number of lives that the player has left. It is printed as two
. binary coded decimal digits, but #R$D13F and #R$C1DD change it with DEC and
. INC, so it is only right while it is below #N$0A.
B $5BBA,$01

g $5BBB Charms
@ $5BBB label=Charms
D $5BBB The number of objects that have been put into the cauldron.
B $5BBB,$01

g $5BBC Fire Seed
@ $5BBC label=FireSeed
D $5BBC A number that is set to the frame counter at the start of every frame
. and goes up by one for each object that is updated. A fire that stays where it
. is uses its lowest bit to decide whether to change its graphic.
B $5BBC,$01

g $5BBD Ball Bounce Height
@ $5BBD label=BallBounceHeight
D $5BBD The Z coordinate that a ball that bounces up and down reaches before it
. falls again. It is zero until the ball starts to bounce.
B $5BBD,$01

g $5BBE Objects Drawn
@ $5BBE label=ObjectsDrawn
D $5BBE The number of objects that were drawn on this frame, which the game uses
. to work out how long to wait before the next frame, so that every frame takes
. about the same time.
B $5BBE,$01

g $5BBF Spiked Ball Dropping Flag
@ $5BBF label=SpikedBallDroppingFlag
D $5BBF Is non-zero while the spiked ball is falling.
B $5BBF,$01

g $5BC0 Spiked Ball Hold Flag
@ $5BC0 label=SpikedBallHoldFlag
D $5BC0 Is non-zero when the spiked ball is not allowed to drop. It is set from
. the first bit of the room number when the room is built, and it is cleared
. when the player picks up an object.
B $5BC0,$01

g $5BC1 Player Fall Speed
@ $5BC1 label=PlayerFallSpeed
D $5BC1 The speed of the player in the Z direction on the last frame, which is
. kept while the player moves, to find out if it has landed.
B $5BC1,$01

g $5BC2 Ball Fall Speed
@ $5BC2 label=BallFallSpeed
D $5BC2 The speed of the ball that bounces in the Z direction on the last frame,
. which is kept while the ball moves, to find out if it has landed.
B $5BC2,$01

g $5BC3 Final Animation Flag
@ $5BC3 label=FinalAnimationFlag
D $5BC3 Is non-zero when all of the objects have been put into the cauldron and
. the game is ending.
B $5BC3,$01

g $5BC4 Object In Cauldron Flag
@ $5BC4 label=ObjectInCauldronFlag
D $5BC4 Is non-zero while an object that the player has dropped is falling into
. the cauldron.
B $5BC4,$01

g $5BC5 Sparkle Height
@ $5BC5 label=SparkleHeight
D $5BC5 The Z coordinate of a sparkle that has moved up on this frame, which the
. game loop uses to play the sound of rising sparkles. It is cleared on every
. frame.
B $5BC5,$01

g $5BC6 Rooms Visited
@ $5BC6 label=RoomsVisited
D $5BC6 The number of rooms that the player has been in, not counting the first
. one, which is worked out by #R$BC10 for the results screen.
B $5BC6,$01

g $5BC7 Font Pointer
@ $5BC7 label=FontPointer
D $5BC7 The address of the font that the text routines use, which is the font at
. #R$6108.
W $5BC7,$02

g $5BC9 Percent Complete
@ $5BC9 label=PercentComplete
D $5BC9 The percentage of the game that has been completed. It is stored as four
. binary coded decimal digits, with the digits of hundreds at #R$5BC9 and the
. digits of tens and units at #R$5BC9(#N$5BCA).
B $5BC9,$02,$01

g $5BCB Drawing List Pointer
@ $5BCB label=DrawingListPointer
D $5BCB A pointer into the list of objects to draw, which the routine that wipes
. the sprites keeps while it works.
W $5BCB,$02

g $5BCD First List Position
@ $5BCD label=FirstListPosition
D $5BCD The place in the list of objects that are drawn of the first of the two
. objects that the depth sort is comparing.
W $5BCD,$02

g $5BCF Second List Position
@ $5BCF label=SecondListPosition
D $5BCF The place in the list of objects that are drawn of the second of the two
. objects that the depth sort is comparing.
W $5BCF,$02

g $5BD1 Tune Played Flag
@ $5BD1 label=TunePlayedFlag
D $5BD1 Is non-zero when the tune that was started with #R$B2B6 has been played
. once.
B $5BD1,$01

g $5BD2 Directional Key Pressed Flag
@ $5BD2 label=DirectionalKeyPressedFlag
D $5BD2 Bit 0 is set while the key that switches on the directional controls is
. held on the menu, so that holding it does not switch it on and off again.
B $5BD2,$01

g $5BD3 No Room To Drop Flag
@ $5BD3 label=NoRoomToDropFlag
D $5BD3 Is non-zero when there is not enough room to drop an object where the
. player stands.
B $5BD3,$01

u $5BD4 Unused
B $5BD4,$04,$04

g $5BD8 Objects Carried
@ $5BD8 label=ObjectsCarried
D $5BD8 The objects that the player is carrying. There is a place for four of
. them, each with four bytes, but the first is only used while an object is
. being picked up, so that the player can carry three. The last of the three is
. the one that has been carried for longest, and the one that is dropped first.
. #TABLE(default,centre,left)
. { =h Byte | =h Contents }
. { #N$00 | The graphic number of the object, or #N$00 if there is not one }
. { #N$01 | The flags of the object }
. { #N$02-#N$03 | The address of the object in the table of special objects }
. TABLE#
B $5BD8,$04,$04 The object that has just been picked up.
@ $5BDC label=ObjectsCarried_Newest
B $5BDC,$04,$04 The object that has been carried for the least time.
B $5BE0,$04,$04 The object that has been carried for a time between the others.
@ $5BE4 label=ObjectsCarried_Oldest
B $5BE4,$04,$04 The object that has been carried for the longest time.

g $5BE8 Rooms Visited Bitmap
@ $5BE8 label=RoomsVisitedBitmap
D $5BE8 A bit for each of the #N$0100 rooms of the game, which is set when the
. player has been in the room. The room number is split in two, with the top
. five bits choosing the byte and the low three bits choosing the bit in the
. byte. The bits are counted by #R$BC10 for the results screen.
B $5BE8,$20,$08

g $5C08 Objects Table
@ $5C08 label=ObjectsTable
D $5C08 The table of the objects in the room, with #N$20 bytes for each of up to
. #N$28 objects. The last object in the table has its final eight bytes in the
. same place as the code of #R$6100, which is not needed once the game has
. started. The table is cleared at the start of the game, and the room objects
. are built by #R$D3C6. The first two objects are the two halves of the player,
. the next two are the objects that the player can pick up in the room, and
. after those are the objects that make up the room.
. The bytes of an object are:
. #TABLE(default,centre,left)
. { =h Byte | =h Contents }
. { #N$00 | The graphic number (#N$00 if there is no object) }
. { #N$01-#N$03 | The X, Y and Z coordinates }
. { #N$04-#N$06 | The width, depth and height }
. { #N$07 | The flags: bit 0 is set near an arch, bit 1 if the object is
. ignored, bit 2 if it can be moved, bit 4 to draw it, bit 5 to wipe it, bit 6
. to flip it from left to right and bit 7 to flip it upside down }
. { #N$08 | The number of the room }
. { #N$09-#N$0B | The speeds in the X, Y and Z directions }
. { #N$0C | Bits 0-2 are set if the object is blocked in the X, Y and Z
. directions, bit 3 if it is jumping, and bits 4-7 count while it is entering
. the room }
. { #N$0D | Bit 7 is set if the object destroys what it hits, bit 5 if it is
. destroyed by what hits it, bit 6 if it has been destroyed and bit 3 if
. something stands on it }
. { #N$0E-#N$0F | The speed of the object in the X and Y direction as changed by
. an arch }
. { #N$10-#N$11 | The graphic to use while the player appears, or the address of
. the object in the table of special objects }
. { #N$12-#N$13 | The adjustments to the pixel X and Y coordinates of the sprite
. }
. { #N$18-#N$19 | The width in bytes and the height in lines of the sprite }
. { #N$1A-#N$1B | The pixel X and Y coordinates of the sprite }
. { #N$1C-#N$1F | The width, height, pixel X and pixel Y coordinates that the
. sprite had when it was last drawn }
. TABLE#
S $5C08,$20,$20 The bottom half of the player.
S $5C28,$20,$20 The top half of the player.
@ $5C48 label=ObjectsTable_FirstSpecial
S $5C48,$20,$20 The first special object of the room.
@ $5C68 label=ObjectsTable_SecondSpecial
S $5C68,$20,$20 The second special object of the room.
@ $5C88 label=ObjectsTable_RoomObjects
S $5C88,$0460,$20 The objects of the room, which are built from the room data.
S $60E8,$18,$18 The first part of the last object in the table.

c $6100 Game Entry Point
@ $6100 label=GameEntry
D $6100 The first instruction run by the tape loader once the game has been
. loaded. The game uses #R$5BA0 as the top of its stack, so the stack grows down
. into the printer buffer, and then it jumps to #R$AF6C to start a new game.
E $6100 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$6300 }
. LIST#
  $6100,$01 Disable interrupts.
  $6101,$03 Set the stack pointer to #R$5BA0.
  $6104,$01 No operation.
  $6105,$03 Jump to #R$AF6C.

b $6108 Font
@ $6108 label=Font
D $6108 The font that the game prints its text with, which has #N$28 characters
. of eight bytes each. A character in a message is its number in the font: #N$00
. to #N$09 are the digits, #N$0A to #N$23 are the letters A to Z, #N$24 is a
. full stop, #N$25 is the copyright symbol, #N$26 is a space and #N$27 is a
. percent sign.
E $6108 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$6308 }
. { #MARTIANOIDS$C33C }
. { #NIGHTSHADE$6CDE }
. { #PENTAGRAM$8355 }
. { #UNDERWURLDE$EEA4 }
. LIST#
B $6108,$08,$08 #UDG(#PC)
L $6108,$08,$28

b $6248 Room Size Table
@ $6248 label=RoomSizeTable
D $6248 The sizes that a room can have, each as three bytes. The first two are
. the distances in X and Y from the middle of the room (#N$80) to its walls, and
. the third is the Z coordinate of the floor. The size of a room is chosen by
. the high five bits of the colour and size byte of its entry in the table of
. rooms at #R$6251.
B $6248,$03,$03 Size #N$00: a room that is square.
B $624B,$03,$03 Size #N$01: a room that is narrow in X.
B $624E,$03,$03 Size #N$02: a room that is narrow in Y.

b $6251 Room Table
@ $6251 label=RoomTable
D $6251 The objects of each of the #N$80 rooms of the game, in a table of
. entries that are of different lengths. Each entry is for a room number, in
. which the high four bits are the row of the room (the rows to the north have
. the larger numbers) and the low four bits are the column (the columns to the
. east have the larger numbers). #R$D3C6 finds the entry of a room and #R$D3F0
. builds the objects of the room from it.
. #TABLE(default,centre,left)
. { =h Bytes | =h Contents }
. { #N$00 | The room number }
. { #N$01 | The length of the rest of the entry, including this byte }
. { #N$02 | The colour of the room in bits 0-2, and the size of the room in bits
. 3-7 (see #R$6248) }
. { #N$03... | The types of background object, which are the entries of the
. table at #R$6CE2 }
. { #N$FF | Marks the end of the background objects. It is not there if the
. entry ends with them }
. { Then | The groups of foreground objects }
. TABLE#
. A group of foreground objects is a byte that has the block type in bits 3-7
. (see #R$6BD1) and the number of times it is used, less one, in bits 0-2,
. followed by a position for each time. A position has the X coordinate in bits
. 0-2, the Y coordinate in bits 3-5 and the Z coordinate in bits 6-7, where each
. step of X and Y is #N$10 from #N($48), and each step of Z is #N$0C above the
. floor.
N $6251 Room #N$00.
B $6251,$02,$01 Room #N($00), and the length of the entry.
B $6253,$01 The colour is magenta and the size is #N$00.
B $6254,$03,$01 Background objects: Arch North, Arch East, Walls Size 0.
B $6257,$01 The end of the background objects.
B $6258,$09,$01 Block at (0,2,0), (0,2,1), (0,2,2), (1,2,0), (1,2,1), (1,2,2),
. (2,1,0), (2,1,1).
B $6261,$08,$01 Block at (2,1,2), (2,0,0), (2,0,1), (2,0,2), (0,1,3), (1,0,3),
. (0,0,3).
B $6269,$02,$01 Dropping Block at (1,1,3).
N $626B Room #N$01.
B $626B,$02,$01 Room #N($01), and the length of the entry.
B $626D,$01 The colour is green and the size is #N$02.
B $626E,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $6271,$01 The end of the background objects.
B $6272,$05,$01 Block at (3,5,0), (4,5,0), (3,2,0), (4,2,0).
B $6277,$05,$01 Gargoyle at (3,5,1), (4,5,1), (3,2,1), (4,2,1).
B $627C,$02,$01 Guard East West at (4,3,0).
B $627E,$02,$01 Ghost at (0,5,0).
N $6280 Room #N$02.
B $6280,$02,$01 Room #N($02), and the length of the entry.
B $6282,$01 The colour is magenta and the size is #N$00.
B $6283,$04,$01 Background objects: Arch North, Arch East, Arch West, Walls Size
. 0.
N $6287 Room #N$03.
B $6287,$02,$01 Room #N($03), and the length of the entry.
B $6289,$01 The colour is yellow and the size is #N$02.
B $628A,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $628D,$01 The end of the background objects.
B $628E,$05,$01 Block at (2,4,0), (2,3,0), (5,4,0), (5,3,0).
B $6293,$05,$01 Spikes at (3,4,0), (3,3,0), (4,4,0), (4,3,0).
B $6298,$05,$01 Spiked Ball at (3,5,0), (4,5,0), (3,2,0), (4,2,0).
B $629D,$05,$01 Collapsing Block at (3,4,1), (4,4,1), (3,3,1), (4,3,1).
N $62A2 Room #N$04.
B $62A2,$02,$01 Room #N($04), and the length of the entry.
B $62A4,$01 The colour is cyan and the size is #N$00.
B $62A5,$03,$01 Background objects: Arch North, Arch West, Walls Size 0.
B $62A8,$01 The end of the background objects.
B $62A9,$05,$01 Spikes at (3,4,0), (2,3,0), (4,3,0), (3,2,0).
B $62AE,$04,$01 Collapsing Block at (2,3,1), (4,3,1), (3,2,1).
B $62B2,$04,$01 Block at (3,4,1), (3,3,2), (3,3,3).
N $62B6 Room #N$08.
B $62B6,$02,$01 Room #N($08), and the length of the entry.
B $62B8,$01 The colour is magenta and the size is #N$00.
B $62B9,$04,$01 Background objects: Tree Arch North, Tree Arch East, Trees Size
. 0, Trees Size 1.
B $62BD,$01 The end of the background objects.
B $62BE,$05,$01 Rock at (3,3,0), (3,3,1), (3,3,2), (3,3,3).
B $62C3,$05,$01 Spikes at (3,4,0), (2,3,0), (4,3,0), (3,2,0).
B $62C8,$05,$01 Spiked Ball at (3,4,1), (2,3,1), (4,3,1), (3,2,1).
B $62CD,$02,$01 Bouncing Ball at (1,1,0).
B $62CF,$02,$01 Moveable Block at (1,1,1).
N $62D1 Room #N$09.
B $62D1,$02,$01 Room #N($09), and the length of the entry.
B $62D3,$01 The colour is yellow and the size is #N$00.
B $62D4,$06,$01 Background objects: Tree Arch East, Tree Arch West, Trees Size
. 0, Trees Size 2, Gate East, Gate West.
B $62DA,$01 The end of the background objects.
B $62DB,$02,$01 Ghost at (3,4,0).
N $62DD Room #N$0A.
B $62DD,$02,$01 Room #N($0A), and the length of the entry.
B $62DF,$01 The colour is magenta and the size is #N$00.
B $62E0,$04,$01 Background objects: Tree Arch East, Tree Arch West, Trees Size
. 0, Trees Size 2.
B $62E4,$01 The end of the background objects.
B $62E5,$07,$01 Rock at (2,4,0), (2,4,1), (2,4,2), (4,4,0), (4,4,1), (4,4,2).
B $62EC,$09,$01 Spikes at (2,5,0), (3,5,0), (3,5,1), (4,5,0), (2,3,0), (3,3,0),
. (3,3,1), (4,3,0).
B $62F5,$02,$01 Table at (6,1,0).
N $62F7 Room #N$0B.
B $62F7,$02,$01 Room #N($0B), and the length of the entry.
B $62F9,$01 The colour is yellow and the size is #N$00.
B $62FA,$04,$01 Background objects: Tree Arch East, Tree Arch West, Trees Size
. 0, Trees Size 2.
N $62FE Room #N$0C.
B $62FE,$02,$01 Room #N($0C), and the length of the entry.
B $6300,$01 The colour is magenta and the size is #N$00.
B $6301,$04,$01 Background objects: Tree Arch East, Tree Arch West, Trees Size
. 0, Trees Size 2.
B $6305,$01 The end of the background objects.
B $6306,$09,$01 Spikes at (5,7,0), (2,6,0), (0,5,0), (4,5,0), (7,5,0), (2,4,0),
. (4,3,0), (0,2,0).
B $630F,$05,$01 Spikes at (2,2,0), (7,2,0), (5,1,0), (4,0,0).
B $6314,$02,$01 Bouncing Ball at (4,4,0).
N $6316 Room #N$0D.
B $6316,$02,$01 Room #N($0D), and the length of the entry.
B $6318,$01 The colour is green and the size is #N$00.
B $6319,$04,$01 Background objects: Arch North, Arch East, Arch West, Walls Size
. 0.
N $631D Room #N$0E.
B $631D,$02,$01 Room #N($0E), and the length of the entry.
B $631F,$01 The colour is cyan and the size is #N$02.
B $6320,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $6323,$01 The end of the background objects.
B $6324,$05,$01 Fire North South at (2,2,0), (5,3,0), (4,5,0), (3,4,0).
N $6329 Room #N$0F.
B $6329,$02,$01 Room #N($0F), and the length of the entry.
B $632B,$01 The colour is green and the size is #N$00.
B $632C,$03,$01 Background objects: Arch North, Arch West, Walls Size 0.
B $632F,$01 The end of the background objects.
B $6330,$09,$01 Block at (3,4,0), (5,4,0), (3,2,0), (5,2,0), (3,4,1), (4,4,1),
. (5,4,1), (3,3,1).
B $6339,$06,$01 Block at (5,3,1), (3,2,1), (4,2,1), (5,2,1), (4,3,0).
B $633F,$05,$01 High Spiked Ball at (4,4,2), (3,3,2), (5,3,2), (4,2,2).
B $6344,$02,$01 Collapsing Block at (4,3,2).
N $6346 Room #N$10.
B $6346,$02,$01 Room #N($10), and the length of the entry.
B $6348,$01 The colour is cyan and the size is #N$01.
B $6349,$04,$01 Background objects: Arch North, High Arch South, High Arch South
. Base, Walls Size 2.
B $634D,$01 The end of the background objects.
B $634E,$03,$01 Block at (3,0,3), (4,0,3).
B $6351,$05,$01 High Block at (5,0,0), (4,1,0), (3,1,0), (2,1,0).
B $6356,$05,$01 High Spiked Ball at (5,0,1), (4,1,1), (3,1,1), (2,1,1).
B $635B,$02,$01 Dropping Block at (2,0,3).
B $635D,$02,$01 Fire North South at (2,3,1).
N $635F Room #N$12.
B $635F,$02,$01 Room #N($12), and the length of the entry.
B $6361,$01 The colour is green and the size is #N$01.
B $6362,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6365,$01 The end of the background objects.
B $6366,$09,$01 Spiked Ball at (2,7,3), (5,7,3), (3,6,3), (4,6,3), (3,5,3),
. (4,5,3), (3,4,3), (4,4,3).
B $636F,$09,$01 Spiked Ball at (3,3,3), (4,3,3), (3,2,3), (4,2,3), (3,1,3),
. (4,1,3), (2,0,3), (5,0,3).
N $6378 Room #N$14.
B $6378,$02,$01 Room #N($14), and the length of the entry.
B $637A,$01 The colour is yellow and the size is #N$01.
B $637B,$04,$01 Background objects: Arch North, High Arch South, High Arch South
. Base, Walls Size 2.
B $637F,$01 The end of the background objects.
B $6380,$03,$01 Block at (3,0,3), (4,0,3).
B $6383,$07,$01 Dropping Block at (2,0,3), (2,1,3), (2,2,3), (2,3,3), (3,3,3),
. (4,3,3).
B $638A,$06,$01 Dropping Block at (5,3,3), (5,4,3), (5,5,2), (5,6,1), (5,7,0).
B $6390,$03,$01 Spikes at (3,1,0), (4,1,0).
N $6393 Room #N$18.
B $6393,$02,$01 Room #N($18), and the length of the entry.
B $6395,$01 The colour is cyan and the size is #N$01.
B $6396,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6399,$01 The end of the background objects.
B $639A,$09,$01 Spikes at (2,5,0), (3,5,0), (4,5,0), (5,5,0), (2,2,0), (3,2,0),
. (4,2,0), (5,2,0).
B $63A3,$02,$01 Bouncing Ball at (3,3,0).
N $63A5 Room #N$1D.
B $63A5,$02,$01 Room #N($1D), and the length of the entry.
B $63A7,$01 The colour is yellow and the size is #N$01.
B $63A8,$04,$01 Background objects: Arch North, High Arch South, High Arch South
. Base, Walls Size 2.
B $63AC,$01 The end of the background objects.
B $63AD,$09,$01 Block at (3,0,3), (4,0,3), (4,1,0), (4,1,1), (4,1,2), (4,1,3),
. (4,4,0), (4,4,1).
B $63B6,$04,$01 Block at (4,5,0), (4,5,1), (4,6,0).
B $63BA,$03,$01 Spikes at (4,2,0), (4,3,0).
B $63BD,$02,$01 High Block at (4,1,0).
B $63BF,$02,$01 Block North South at (4,2,1).
N $63C1 Room #N$1F.
B $63C1,$02,$01 Room #N($1F), and the length of the entry.
B $63C3,$01 The colour is magenta and the size is #N$01.
B $63C4,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $63C7,$01 The end of the background objects.
B $63C8,$05,$01 Block at (2,2,0), (5,2,0), (2,5,0), (5,5,0).
B $63CD,$09,$01 Spikes at (2,2,1), (3,2,0), (4,2,0), (5,2,1), (2,5,1), (3,5,0),
. (4,5,0), (5,5,1).
B $63D6,$03,$01 Ball Offset X at (3,2,2), (3,5,1).
N $63D9 Room #N$20.
B $63D9,$02,$01 Room #N($20), and the length of the entry.
B $63DB,$01 The colour is magenta and the size is #N$00.
B $63DC,$05,$01 Background objects: Arch North, Arch East, High Arch South, High
. Arch South Base, Walls Size 0.
B $63E1,$01 The end of the background objects.
B $63E2,$04,$01 Block at (0,3,0), (3,0,3), (4,0,3).
B $63E6,$04,$01 Dropping Block at (0,2,1), (0,1,2), (0,0,3).
B $63EA,$02,$01 Spikes at (2,0,0).
N $63EC Room #N$21.
B $63EC,$02,$01 Room #N($21), and the length of the entry.
B $63EE,$01 The colour is yellow and the size is #N$02.
B $63EF,$04,$01 Background objects: High Arch East, High Arch East Base, Arch
. West, Walls Size 1.
B $63F3,$01 The end of the background objects.
B $63F4,$09,$01 Block at (1,4,0), (1,4,1), (2,4,2), (3,4,2), (4,4,0), (4,4,1),
. (5,4,0), (5,4,1).
B $63FD,$05,$01 Block at (6,4,0), (6,4,1), (7,4,3), (7,3,3).
B $6402,$03,$01 Spikes at (4,4,2), (6,4,2).
B $6405,$02,$01 Chest at (2,4,3).
B $6407,$02,$01 Ball at (5,4,2).
N $6409 Room #N$22.
B $6409,$02,$01 Room #N($22), and the length of the entry.
B $640B,$01 The colour is magenta and the size is #N$00.
B $640C,$03,$01 Background objects: Arch South, Arch West, Walls Size 0.
B $640F,$01 The end of the background objects.
B $6410,$05,$01 Block at (0,6,0), (0,7,1), (1,7,2), (2,7,3).
B $6415,$09,$01 Spikes at (1,7,0), (2,7,0), (5,7,0), (6,7,0), (7,7,0), (3,6,0),
. (3,5,0), (3,4,0).
B $641E,$04,$01 Spikes at (4,6,0), (4,5,0), (4,4,0).
B $6422,$02,$01 Dropping Block at (3,7,3).
N $6424 Room #N$24.
B $6424,$02,$01 Room #N($24), and the length of the entry.
B $6426,$01 The colour is magenta and the size is #N$00.
B $6427,$03,$01 Background objects: Arch North, Arch South, Walls Size 0.
B $642A,$01 The end of the background objects.
B $642B,$09,$01 Spikes at (2,0,0), (5,0,0), (2,1,0), (7,1,0), (0,2,0), (5,2,0),
. (1,3,0), (3,3,0).
B $6434,$09,$01 Spikes at (4,3,0), (7,3,0), (0,5,0), (2,5,0), (4,5,0), (6,5,0),
. (2,7,0), (5,7,0).
N $643D Room #N$27.
B $643D,$02,$01 Room #N($27), and the length of the entry.
B $643F,$01 The colour is yellow and the size is #N$00.
B $6440,$02,$01 Background objects: Arch North, Walls Size 0.
B $6442,$01 The end of the background objects.
B $6443,$05,$01 Block at (3,3,0), (4,3,0), (3,4,0), (4,4,0).
B $6448,$05,$01 Ghost at (2,2,0), (5,2,0), (2,5,0), (5,5,0).
N $644D Room #N$28.
B $644D,$02,$01 Room #N($28), and the length of the entry.
B $644F,$01 The colour is yellow and the size is #N$01.
B $6450,$04,$01 Background objects: Arch North, High Arch South, Walls Size 2,
. High Arch South Base.
B $6454,$01 The end of the background objects.
B $6455,$03,$01 Table at (3,4,0), (3,4,1).
B $6458,$03,$01 Spikes at (3,1,0), (4,1,0).
B $645B,$03,$01 Block at (3,0,3), (4,0,3).
N $645E Room #N$2D.
B $645E,$02,$01 Room #N($2D), and the length of the entry.
B $6460,$01 The colour is green and the size is #N$00.
B $6461,$04,$01 Background objects: High Arch East, Arch South, High Arch East
. Base, Walls Size 0.
B $6465,$01 The end of the background objects.
B $6466,$09,$01 Block at (7,3,3), (7,4,3), (3,2,0), (3,3,0), (3,4,0), (3,3,1),
. (3,4,1), (3,4,2).
B $646F,$05,$01 Spikes at (6,3,0), (6,4,0), (2,4,0), (4,4,0).
B $6474,$02,$01 Block East West at (3,4,3).
N $6476 Room #N$2E.
B $6476,$02,$01 Room #N($2E), and the length of the entry.
B $6478,$01 The colour is cyan and the size is #N$02.
B $6479,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $647C,$01 The end of the background objects.
B $647D,$09,$01 Spikes at (3,5,0), (4,5,0), (2,4,0), (5,4,0), (2,3,0), (5,3,0),
. (3,2,0), (4,2,0).
B $6486,$02,$01 Guard Square at (3,4,0).
N $6488 Room #N$2F.
B $6488,$02,$01 Room #N($2F), and the length of the entry.
B $648A,$01 The colour is green and the size is #N$00.
B $648B,$04,$01 Background objects: Arch North, Arch South, Arch West, Walls
. Size 0.
N $648F Room #N$30.
B $648F,$02,$01 Room #N($30), and the length of the entry.
B $6491,$01 The colour is cyan and the size is #N$01.
B $6492,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6495,$01 The end of the background objects.
B $6496,$09,$01 Spikes at (3,6,0), (4,6,0), (2,5,0), (5,5,0), (2,4,0), (5,4,0),
. (2,3,0), (5,3,0).
B $649F,$05,$01 Spikes at (2,2,0), (5,2,0), (3,1,0), (4,1,0).
B $64A4,$02,$01 Bouncing Ball at (3,3,0).
N $64A6 Room #N$34.
B $64A6,$02,$01 Room #N($34), and the length of the entry.
B $64A8,$01 The colour is yellow and the size is #N$01.
B $64A9,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $64AC,$01 The end of the background objects.
B $64AD,$09,$01 Table at (2,3,0), (3,3,0), (4,3,0), (5,3,0), (2,3,1), (3,3,1),
. (4,3,1), (5,3,1).
B $64B6,$09,$01 Spiked Ball at (2,3,2), (3,3,2), (4,3,2), (5,3,2), (2,3,3),
. (3,3,3), (4,3,3), (5,3,3).
N $64BF Room #N$37.
B $64BF,$02,$01 Room #N($37), and the length of the entry.
B $64C1,$01 The colour is cyan and the size is #N$01.
B $64C2,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $64C5,$01 The end of the background objects.
B $64C6,$02,$01 Block North South at (4,2,0).
B $64C8,$02,$01 Block at (4,5,0).
B $64CA,$03,$01 Ghost at (5,4,0), (2,3,0).
N $64CD Room #N$38.
B $64CD,$02,$01 Room #N($38), and the length of the entry.
B $64CF,$01 The colour is magenta and the size is #N$01.
B $64D0,$04,$01 Background objects: Arch North, High Arch South, High Arch South
. Base, Walls Size 2.
B $64D4,$01 The end of the background objects.
B $64D5,$07,$01 Block at (2,7,1), (2,6,3), (2,3,3), (2,0,3), (3,0,3), (4,0,3).
B $64DC,$05,$01 Collapsing Block at (2,5,3), (2,4,3), (2,2,3), (2,1,3).
B $64E1,$06,$01 Spikes at (2,5,0), (2,4,0), (2,3,0), (2,2,0), (2,1,0).
N $64E7 Room #N$3F.
B $64E7,$02,$01 Room #N($3F), and the length of the entry.
B $64E9,$01 The colour is magenta and the size is #N$00.
B $64EA,$04,$01 Background objects: Tree Arch North, Tree Arch South, Trees Size
. 0, Trees Size 1.
B $64EE,$01 The end of the background objects.
B $64EF,$09,$01 Rock at (0,3,0), (1,3,0), (2,3,0), (2,3,1), (5,3,0), (5,3,1),
. (6,3,0), (7,3,0).
B $64F8,$07,$01 Spikes at (0,3,1), (1,3,1), (2,3,2), (5,3,2), (6,3,1), (7,3,1).
B $64FF,$02,$01 Portcullis Along X at (3,3,0).
N $6501 Room #N$40.
B $6501,$02,$01 Room #N($40), and the length of the entry.
B $6503,$01 The colour is yellow and the size is #N$00.
B $6504,$05,$01 Background objects: High Arch East, High Arch South, High Arch
. East Base, High Arch South Base, Walls Size 0.
B $6509,$01 The end of the background objects.
B $650A,$07,$01 Block at (7,7,0), (6,0,0), (3,0,3), (4,0,3), (7,3,3), (7,4,3).
B $6511,$02,$01 Guard Square at (0,7,0).
B $6513,$02,$01 Moveable Block at (0,7,2).
N $6515 Room #N$41.
B $6515,$02,$01 Room #N($41), and the length of the entry.
B $6517,$01 The colour is green and the size is #N$02.
B $6518,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $651B,$01 The end of the background objects.
B $651C,$07,$01 Block at (2,2,0), (4,2,0), (6,2,0), (2,5,0), (4,5,0), (6,5,0).
B $6523,$07,$01 Gargoyle at (2,2,1), (4,2,1), (6,2,1), (2,5,1), (4,5,1),
. (6,5,1).
B $652A,$03,$01 Fire North South at (5,2,0), (3,5,0).
N $652D Room #N$42.
B $652D,$02,$01 Room #N($42), and the length of the entry.
B $652F,$01 The colour is cyan and the size is #N$00.
B $6530,$03,$01 Background objects: Arch East, Arch West, Walls Size 0.
B $6533,$01 The end of the background objects.
B $6534,$03,$01 Block at (3,3,0), (4,3,3).
B $6537,$03,$01 Dropping Block at (3,4,1), (4,4,2).
B $653A,$09,$01 Spikes at (2,2,0), (2,3,0), (2,4,0), (3,5,0), (4,5,0), (5,4,0),
. (5,3,0), (4,2,0).
N $6543 Room #N$43.
B $6543,$02,$01 Room #N($43), and the length of the entry.
B $6545,$01 The colour is yellow and the size is #N$02.
B $6546,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $6549,$01 The end of the background objects.
B $654A,$09,$01 Block at (6,3,0), (6,4,0), (5,3,1), (5,4,1), (1,3,0), (1,4,0),
. (2,3,1), (2,4,1).
B $6553,$05,$01 Block at (3,5,0), (4,5,0), (3,2,0), (4,2,0).
B $6558,$05,$01 Spikes at (3,5,1), (4,5,1), (3,2,1), (4,2,1).
B $655D,$02,$01 Ball Offset XY at (3,3,0).
N $655F Room #N$44.
B $655F,$02,$01 Room #N($44), and the length of the entry.
B $6561,$01 The colour is green and the size is #N$00.
B $6562,$05,$01 Background objects: Arch North, Arch East, Arch South, Arch
. West, Walls Size 0.
N $6567 Room #N$45.
B $6567,$02,$01 Room #N($45), and the length of the entry.
B $6569,$01 The colour is cyan and the size is #N$00.
B $656A,$03,$01 Background objects: Arch East, Arch West, Walls Size 0.
B $656D,$01 The end of the background objects.
B $656E,$09,$01 Block at (3,4,0), (5,4,0), (3,2,0), (5,2,0), (3,4,1), (4,4,1),
. (5,4,1), (3,3,1).
B $6577,$05,$01 Block at (5,3,1), (3,2,1), (4,2,1), (5,2,1).
B $657C,$05,$01 High Spiked Ball at (4,4,2), (3,3,2), (5,3,2), (4,2,2).
B $6581,$02,$01 Collapsing Block at (4,3,2).
B $6583,$02,$01 Spikes at (4,3,0).
N $6585 Room #N$46.
B $6585,$02,$01 Room #N($46), and the length of the entry.
B $6587,$01 The colour is yellow and the size is #N$02.
B $6588,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $658B,$01 The end of the background objects.
B $658C,$09,$01 Block at (3,4,0), (3,3,0), (4,5,0), (4,5,1), (4,2,0), (4,2,1),
. (5,4,0), (5,3,0).
B $6595,$05,$01 Gargoyle at (5,4,1), (5,3,1), (3,4,1), (3,3,1).
B $659A,$03,$01 Spiked Ball at (4,4,0), (4,3,0).
B $659D,$05,$01 Collapsing Block at (4,4,2), (4,4,3), (4,3,2), (4,3,3).
N $65A2 Room #N$47.
B $65A2,$02,$01 Room #N($47), and the length of the entry.
B $65A4,$01 The colour is magenta and the size is #N$00.
B $65A5,$04,$01 Background objects: Arch North, Arch South, Arch West, Walls
. Size 0.
N $65A9 Room #N$48.
B $65A9,$02,$01 Room #N($48), and the length of the entry.
B $65AB,$01 The colour is yellow and the size is #N$01.
B $65AC,$04,$01 Background objects: Arch North, High Arch South, High Arch South
. Base, Walls Size 2.
B $65B0,$01 The end of the background objects.
B $65B1,$09,$01 Block at (3,0,3), (4,0,3), (4,1,3), (4,5,0), (5,5,0), (5,4,0),
. (4,5,1), (5,5,1).
B $65BA,$02,$01 Block at (4,5,2).
B $65BC,$03,$01 Spikes at (3,1,0), (4,2,0).
B $65BF,$02,$01 Block North South at (4,1,2).
N $65C1 Room #N$4F.
B $65C1,$02,$01 Room #N($4F), and the length of the entry.
B $65C3,$01 The colour is yellow and the size is #N$00.
B $65C4,$04,$01 Background objects: Tree Arch North, Tree Arch South, Trees Size
. 0, Trees Size 1.
B $65C8,$01 The end of the background objects.
B $65C9,$09,$01 High Spiked Ball at (0,3,3), (1,3,3), (2,3,3), (3,3,3), (4,3,3),
. (5,3,3), (6,3,3), (7,3,3).
B $65D2,$05,$01 High Spiked Ball at (3,0,3), (4,0,3), (3,7,3), (4,7,3).
N $65D7 Room #N$54.
B $65D7,$02,$01 Room #N($54), and the length of the entry.
B $65D9,$01 The colour is cyan and the size is #N$01.
B $65DA,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $65DD,$01 The end of the background objects.
B $65DE,$03,$01 Block at (4,1,0), (3,6,0).
B $65E1,$05,$01 Spikes at (2,3,0), (2,3,1), (5,4,0), (5,4,1).
B $65E6,$05,$01 Spiked Ball at (3,2,0), (3,1,0), (4,5,0), (4,4,0).
B $65EB,$03,$01 Block North South at (4,2,0), (3,4,0).
N $65EE Room #N$57.
B $65EE,$02,$01 Room #N($57), and the length of the entry.
B $65F0,$01 The colour is cyan and the size is #N$01.
B $65F1,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $65F4,$01 The end of the background objects.
B $65F5,$09,$01 Block at (5,5,0), (5,5,1), (5,5,2), (4,4,0), (4,4,1), (4,4,2),
. (3,3,0), (3,3,1).
B $65FE,$05,$01 Block at (3,3,2), (2,2,0), (2,2,1), (2,2,2).
N $6603 Room #N$58.
B $6603,$02,$01 Room #N($58), and the length of the entry.
B $6605,$01 The colour is cyan and the size is #N$01.
B $6606,$04,$01 Background objects: Arch North, High Arch South, High Arch South
. Base, Walls Size 2.
B $660A,$01 The end of the background objects.
B $660B,$02,$01 Ghost at (5,3,0).
B $660D,$02,$01 Moveable Block at (5,3,1).
N $660F Room #N$5E.
B $660F,$02,$01 Room #N($5E), and the length of the entry.
B $6611,$01 The colour is yellow and the size is #N$00.
B $6612,$04,$01 Background objects: Tree Arch North, Tree Arch East, Trees Size
. 0, Trees Size 1.
B $6616,$01 The end of the background objects.
B $6617,$09,$01 Rock at (2,6,0), (5,6,0), (1,5,0), (6,5,0), (1,2,0), (6,2,0),
. (2,1,0), (5,1,0).
B $6620,$02,$01 Repel Spell at (5,5,0).
N $6622 Room #N$5F.
B $6622,$02,$01 Room #N($5F), and the length of the entry.
B $6624,$01 The colour is magenta and the size is #N$00.
B $6625,$04,$01 Background objects: Tree Arch North, Tree Arch South, Tree Arch
. West, Trees Size 0.
N $6629 Room #N$64.
B $6629,$02,$01 Room #N($64), and the length of the entry.
B $662B,$01 The colour is yellow and the size is #N$01.
B $662C,$04,$01 Background objects: Arch North, High Arch South, High Arch South
. Base, Walls Size 2.
B $6630,$01 The end of the background objects.
B $6631,$09,$01 Block at (3,0,0), (4,0,0), (3,1,0), (4,1,0), (3,4,0), (4,4,0),
. (3,5,0), (4,5,0).
B $663A,$02,$01 Chest at (3,4,1).
N $663C Room #N$67.
B $663C,$02,$01 Room #N($67), and the length of the entry.
B $663E,$01 The colour is green and the size is #N$01.
B $663F,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6642,$01 The end of the background objects.
B $6643,$03,$01 Block at (2,5,0), (5,5,0).
B $6646,$05,$01 Spikes at (2,5,1), (5,5,1), (2,3,0), (5,3,0).
B $664B,$02,$01 Portcullis Along X at (3,5,0).
B $664D,$02,$01 Guard Square at (5,4,0).
N $664F Room #N$68.
B $664F,$02,$01 Room #N($68), and the length of the entry.
B $6651,$01 The colour is magenta and the size is #N$01.
B $6652,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6655,$01 The end of the background objects.
B $6656,$09,$01 Block at (2,7,0), (2,7,1), (2,7,2), (2,7,3), (5,7,0), (5,7,1),
. (5,7,2), (5,7,3).
B $665F,$05,$01 Block at (2,6,0), (3,6,0), (4,6,0), (5,6,0).
B $6664,$03,$01 Spikes at (2,6,1), (5,6,1).
B $6667,$02,$01 Ball Offset XY at (3,4,2).
N $6669 Room #N$6A.
B $6669,$02,$01 Room #N($6A), and the length of the entry.
B $666B,$01 The colour is yellow and the size is #N$00.
B $666C,$03,$01 Background objects: Arch North, Arch East, Walls Size 0.
N $666F Room #N$6B.
B $666F,$02,$01 Room #N($6B), and the length of the entry.
B $6671,$01 The colour is green and the size is #N$02.
B $6672,$04,$01 Background objects: High Arch East, Arch West, High Arch East
. Base, Walls Size 1.
B $6676,$01 The end of the background objects.
B $6677,$07,$01 Block at (4,4,0), (4,3,0), (4,4,1), (4,3,1), (7,4,3), (7,3,3).
B $667E,$03,$01 Fire North South at (6,2,3), (5,5,3).
N $6681 Room #N$6C.
B $6681,$02,$01 Room #N($6C), and the length of the entry.
B $6683,$01 The colour is magenta and the size is #N$02.
B $6684,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $6687,$01 The end of the background objects.
B $6688,$09,$01 Chest at (3,5,0), (3,4,0), (3,3,0), (3,2,0), (3,5,1), (3,4,1),
. (3,3,1), (3,2,1).
B $6691,$09,$01 High Spiked Ball at (3,5,2), (3,4,2), (3,3,2), (3,2,2), (3,5,3),
. (3,4,3), (3,3,3), (3,2,3).
N $669A Room #N$6D.
B $669A,$02,$01 Room #N($6D), and the length of the entry.
B $669C,$01 The colour is yellow and the size is #N$00.
B $669D,$04,$01 Background objects: Tree Arch East, Tree Arch West, Trees Size
. 0, Trees Size 2.
B $66A1,$01 The end of the background objects.
B $66A2,$09,$01 Rock at (4,2,0), (4,5,0), (4,2,1), (4,5,1), (4,2,2), (4,3,2),
. (4,4,2), (4,5,2).
B $66AB,$03,$01 Gargoyle at (4,2,3), (4,5,3).
B $66AE,$02,$01 Table at (1,1,0).
B $66B0,$02,$01 Guard East West at (6,3,0).
N $66B2 Room #N$6E.
B $66B2,$02,$01 Room #N($6E), and the length of the entry.
B $66B4,$01 The colour is magenta and the size is #N$00.
B $66B5,$05,$01 Background objects: Tree Arch East, Tree Arch South, Tree Arch
. West, Trees Size 0, Trees Size 2.
N $66BA Room #N$6F.
B $66BA,$02,$01 Room #N($6F), and the length of the entry.
B $66BC,$01 The colour is yellow and the size is #N$00.
B $66BD,$04,$01 Background objects: Tree Arch South, Tree Arch West, Trees Size
. 0, Trees Size 2.
B $66C1,$01 The end of the background objects.
B $66C2,$04,$01 Rock at (5,5,0), (6,5,0), (7,5,0).
B $66C6,$04,$01 Gargoyle at (5,5,1), (6,5,1), (7,5,1).
B $66CA,$05,$01 High Spiked Ball at (5,7,0), (5,6,0), (5,7,1), (5,6,1).
N $66CF Room #N$74.
B $66CF,$02,$01 Room #N($74), and the length of the entry.
B $66D1,$01 The colour is green and the size is #N$00.
B $66D2,$03,$01 Background objects: Arch East, Arch South, Walls Size 0.
B $66D5,$01 The end of the background objects.
B $66D6,$04,$01 Spikes at (1,7,0), (0,6,0), (1,6,0).
B $66DA,$09,$01 Block at (2,7,0), (2,7,1), (2,6,0), (2,6,1), (0,5,0), (0,5,1),
. (1,5,0), (1,5,1).
B $66E3,$05,$01 Collapsing Block at (0,7,2), (1,7,2), (0,6,2), (1,6,2).
N $66E8 Room #N$75.
B $66E8,$02,$01 Room #N($75), and the length of the entry.
B $66EA,$01 The colour is magenta and the size is #N$02.
B $66EB,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $66EE,$01 The end of the background objects.
B $66EF,$03,$01 Block at (3,4,0), (4,3,0).
B $66F2,$03,$01 Spikes at (4,4,0), (3,3,0).
B $66F5,$02,$01 Repel Spell at (3,5,0).
N $66F7 Room #N$76.
B $66F7,$02,$01 Room #N($76), and the length of the entry.
B $66F9,$01 The colour is yellow and the size is #N$02.
B $66FA,$04,$01 Background objects: High Arch East, Arch West, High Arch East
. Base, Walls Size 1.
B $66FE,$01 The end of the background objects.
B $66FF,$08,$01 Block at (7,3,3), (7,4,3), (7,5,3), (6,5,2), (5,5,1), (4,5,0),
. (7,2,3).
B $6707,$07,$01 Spikes at (6,2,0), (6,3,0), (6,4,0), (5,2,0), (5,3,0), (5,4,0).
N $670E Room #N$77.
B $670E,$02,$01 Room #N($77), and the length of the entry.
B $6710,$01 The colour is magenta and the size is #N$00.
B $6711,$05,$01 Background objects: Arch North, Arch East, Arch South, Arch
. West, Walls Size 0.
N $6716 Room #N$78.
B $6716,$02,$01 Room #N($78), and the length of the entry.
B $6718,$01 The colour is green and the size is #N$00.
B $6719,$05,$01 Background objects: Arch North, Arch East, Arch South, Arch
. West, Walls Size 0.
B $671E,$01 The end of the background objects.
B $671F,$09,$01 Spikes at (1,7,0), (7,7,0), (5,6,0), (0,5,0), (4,5,0), (7,5,0),
. (3,4,0), (5,3,0).
B $6728,$06,$01 Spikes at (1,2,0), (3,2,0), (2,1,0), (5,1,0), (6,1,0).
B $672E,$02,$01 Guard Square at (7,2,0).
N $6730 Room #N$79.
B $6730,$02,$01 Room #N($79), and the length of the entry.
B $6732,$01 The colour is magenta and the size is #N$02.
B $6733,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $6736,$01 The end of the background objects.
B $6737,$05,$01 Collapsing Block at (2,4,0), (2,3,0), (5,4,0), (5,3,0).
B $673C,$09,$01 Spikes at (3,5,0), (4,5,0), (3,4,0), (4,4,0), (3,3,0), (4,3,0),
. (3,2,0), (4,2,0).
B $6745,$02,$01 Ball Offset XY at (3,3,3).
N $6747 Room #N$7A.
B $6747,$02,$01 Room #N($7A), and the length of the entry.
B $6749,$01 The colour is cyan and the size is #N$00.
B $674A,$03,$01 Background objects: Arch South, Arch West, Walls Size 0.
B $674D,$01 The end of the background objects.
B $674E,$06,$01 Block at (0,5,0), (0,6,1), (0,7,2), (1,7,2), (7,7,3).
B $6754,$07,$01 Spikes at (2,7,2), (4,7,2), (6,7,2), (7,6,0), (7,5,0), (7,4,0).
B $675B,$03,$01 Dropping Block at (3,7,3), (5,7,3).
N $675E Room #N$83.
B $675E,$02,$01 Room #N($83), and the length of the entry.
B $6760,$01 The colour is yellow and the size is #N$00.
B $6761,$03,$01 Background objects: Arch North, Arch East, Walls Size 0.
N $6764 Room #N$84.
B $6764,$02,$01 Room #N($84), and the length of the entry.
B $6766,$01 The colour is cyan and the size is #N$02.
B $6767,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $676A,$01 The end of the background objects.
B $676B,$09,$01 Block at (2,5,0), (2,5,1), (5,5,0), (5,5,1), (2,2,0), (2,2,1),
. (5,2,0), (5,2,1).
B $6774,$05,$01 Gargoyle at (2,5,2), (5,5,2), (2,2,2), (5,2,2).
B $6779,$03,$01 Ball Offset Y at (5,3,0), (2,3,2).
N $677C Room #N$85.
B $677C,$02,$01 Room #N($85), and the length of the entry.
B $677E,$01 The colour is green and the size is #N$02.
B $677F,$04,$01 Background objects: High Arch East, Arch West, High Arch East
. Base, Walls Size 1.
B $6783,$01 The end of the background objects.
B $6784,$07,$01 Block at (0,5,0), (1,5,1), (2,5,2), (3,5,3), (7,4,3), (7,3,3).
B $678B,$09,$01 Spikes at (3,3,0), (3,4,0), (4,3,0), (4,4,0), (5,3,0), (5,4,0),
. (6,3,0), (6,4,0).
B $6794,$02,$01 Block North South at (3,3,3).
N $6796 Room #N$86.
B $6796,$02,$01 Room #N($86), and the length of the entry.
B $6798,$01 The colour is magenta and the size is #N$02.
B $6799,$04,$01 Background objects: High Arch East, Arch West, High Arch East
. Base, Walls Size 1.
B $679D,$01 The end of the background objects.
B $679E,$02,$01 Moveable Block at (3,4,1).
B $67A0,$02,$01 Bouncing Ball at (3,4,0).
N $67A2 Room #N$87.
B $67A2,$02,$01 Room #N($87), and the length of the entry.
B $67A4,$01 The colour is cyan and the size is #N$00.
B $67A5,$05,$01 Background objects: Arch North, Arch East, Arch South, Arch
. West, Walls Size 0.
B $67AA,$01 The end of the background objects.
B $67AB,$05,$01 Block at (2,5,0), (5,5,0), (2,2,0), (5,2,0).
B $67B0,$05,$01 Spikes at (2,5,1), (5,5,1), (2,2,1), (5,2,1).
B $67B5,$03,$01 Portcullis Along X at (3,5,0), (3,2,0).
B $67B8,$03,$01 Portcullis Along Y at (2,3,0), (5,3,0).
N $67BB Room #N$88.
B $67BB,$02,$01 Room #N($88), and the length of the entry.
B $67BD,$01 The colour is yellow and the size is #N$00.
B $67BE,$07,$01 Background objects: Arch North, Arch East, Arch South, Arch
. West, Wizard, Cauldron, Walls Size 0.
B $67C5,$01 The end of the background objects.
B $67C6,$09,$01 Block at (2,6,0), (1,5,0), (5,6,0), (6,5,0), (6,2,0), (5,1,0),
. (1,2,0), (2,1,0).
N $67CF Room #N$89.
B $67CF,$02,$01 Room #N($89), and the length of the entry.
B $67D1,$01 The colour is cyan and the size is #N$02.
B $67D2,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $67D5,$01 The end of the background objects.
B $67D6,$09,$01 Block at (4,5,0), (4,5,1), (4,5,2), (4,4,0), (4,3,0), (4,2,0),
. (4,2,1), (4,2,2).
B $67DF,$03,$01 Gargoyle at (4,5,3), (4,2,3).
B $67E2,$02,$01 Fire North South at (4,4,1).
N $67E4 Room #N$8A.
B $67E4,$02,$01 Room #N($8A), and the length of the entry.
B $67E6,$01 The colour is magenta and the size is #N$02.
B $67E7,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $67EA,$01 The end of the background objects.
B $67EB,$09,$01 High Block at (2,5,0), (2,4,0), (2,3,0), (2,2,0), (5,5,0),
. (5,4,0), (5,3,0), (5,2,0).
B $67F4,$09,$01 Spiked Ball at (2,5,3), (2,4,3), (2,3,3), (2,2,3), (5,5,3),
. (5,4,3), (5,3,3), (5,2,3).
N $67FD Room #N$8B.
B $67FD,$02,$01 Room #N($8B), and the length of the entry.
B $67FF,$01 The colour is cyan and the size is #N$00.
B $6800,$04,$01 Background objects: Arch North, Arch East, Arch West, Walls Size
. 0.
N $6804 Room #N$8C.
B $6804,$02,$01 Room #N($8C), and the length of the entry.
B $6806,$01 The colour is green and the size is #N$02.
B $6807,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $680A,$01 The end of the background objects.
B $680B,$09,$01 Block at (2,5,0), (2,5,1), (5,5,0), (5,5,1), (2,2,0), (2,2,1),
. (5,2,0), (5,2,1).
B $6814,$05,$01 Spikes at (2,5,2), (5,5,2), (2,2,2), (5,2,2).
B $6819,$03,$01 Portcullis Along Y at (2,3,0), (5,3,0).
B $681C,$02,$01 Guard East West at (3,3,0).
N $681E Room #N$8D.
B $681E,$02,$01 Room #N($8D), and the length of the entry.
B $6820,$01 The colour is cyan and the size is #N$00.
B $6821,$03,$01 Background objects: Arch East, Arch West, Walls Size 0.
B $6824,$01 The end of the background objects.
B $6825,$09,$01 Block at (4,6,0), (4,6,1), (4,5,1), (4,6,2), (4,7,2), (3,7,3),
. (5,7,3), (3,6,3).
B $682E,$05,$01 Block at (4,7,3), (5,6,3), (3,5,3), (5,5,3).
B $6833,$02,$01 High Block at (4,7,0).
B $6835,$02,$01 Spikes at (4,4,0).
B $6837,$02,$01 Ball Offset Y at (4,4,3).
N $6839 Room #N$8E.
B $6839,$02,$01 Room #N($8E), and the length of the entry.
B $683B,$01 The colour is magenta and the size is #N$02.
B $683C,$04,$01 Background objects: High Arch East, Arch West, High Arch East
. Base, Walls Size 1.
B $6840,$01 The end of the background objects.
B $6841,$03,$01 Table at (3,4,0), (3,4,1).
B $6844,$02,$01 Ghost at (3,5,0).
N $6846 Room #N$8F.
B $6846,$02,$01 Room #N($8F), and the length of the entry.
B $6848,$01 The colour is yellow and the size is #N$00.
B $6849,$03,$01 Background objects: Arch North, Arch West, Walls Size 0.
N $684C Room #N$93.
B $684C,$02,$01 Room #N($93), and the length of the entry.
B $684E,$01 The colour is green and the size is #N$01.
B $684F,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6852,$01 The end of the background objects.
B $6853,$09,$01 Block at (2,3,0), (3,3,0), (4,3,0), (5,3,0), (2,3,1), (2,3,2),
. (5,3,1), (5,3,2).
B $685C,$03,$01 Gargoyle at (2,3,3), (5,3,3).
B $685F,$02,$01 Fire East West at (3,3,1).
N $6861 Room #N$97.
B $6861,$02,$01 Room #N($97), and the length of the entry.
B $6863,$01 The colour is green and the size is #N$01.
B $6864,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6867,$01 The end of the background objects.
B $6868,$05,$01 Block at (2,3,0), (3,3,0), (4,3,0), (5,3,0).
B $686D,$05,$01 Gargoyle at (2,3,1), (3,3,1), (4,3,1), (5,3,1).
N $6872 Room #N$98.
B $6872,$02,$01 Room #N($98), and the length of the entry.
B $6874,$01 The colour is magenta and the size is #N$01.
B $6875,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6878,$01 The end of the background objects.
B $6879,$03,$01 Block at (3,6,0), (4,1,0).
B $687C,$03,$01 Dropping Block at (3,5,1), (4,2,1).
B $687F,$09,$01 Spikes at (2,4,0), (3,4,0), (4,4,0), (5,4,0), (2,3,0), (3,3,0),
. (4,3,0), (5,3,0).
B $6888,$05,$01 Collapsing Block at (3,4,2), (4,4,2), (3,3,2), (4,3,2).
N $688D Room #N$9B.
B $688D,$02,$01 Room #N($9B), and the length of the entry.
B $688F,$01 The colour is magenta and the size is #N$01.
B $6890,$04,$01 Background objects: Arch North, High Arch South, High Arch South
. Base, Walls Size 2.
B $6894,$01 The end of the background objects.
B $6895,$09,$01 Block at (5,7,0), (5,7,1), (5,6,0), (5,6,1), (5,6,2), (5,6,3),
. (3,0,3), (4,0,3).
B $689E,$02,$01 Block North South at (5,3,3).
B $68A0,$02,$01 Block East West at (3,3,3).
B $68A2,$03,$01 Spikes at (4,3,0), (5,3,0).
N $68A5 Room #N$9F.
B $68A5,$02,$01 Room #N($9F), and the length of the entry.
B $68A7,$01 The colour is cyan and the size is #N$01.
B $68A8,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $68AB,$01 The end of the background objects.
B $68AC,$09,$01 Block at (2,3,0), (3,3,0), (4,3,0), (5,3,0), (2,3,1), (3,3,1),
. (4,3,1), (5,3,1).
B $68B5,$05,$01 Block at (2,3,2), (3,3,2), (4,3,2), (5,3,2).
B $68BA,$04,$01 Spikes at (3,3,3), (4,3,3), (5,3,3).
N $68BE Room #N$A3.
B $68BE,$02,$01 Room #N($A3), and the length of the entry.
B $68C0,$01 The colour is magenta and the size is #N$01.
B $68C1,$04,$01 Background objects: Arch North, High Arch South, High Arch South
. Base, Walls Size 2.
B $68C5,$01 The end of the background objects.
B $68C6,$07,$01 Block at (5,7,0), (5,7,1), (4,6,0), (4,6,1), (3,0,3), (4,0,3).
B $68CD,$05,$01 Spikes at (2,2,0), (4,2,0), (3,4,0), (5,4,0).
B $68D2,$05,$01 Spiked Ball at (2,2,1), (4,2,1), (3,4,1), (5,4,1).
B $68D7,$02,$01 Bouncing Ball at (5,6,0).
B $68D9,$02,$01 Moveable Block at (5,6,1).
N $68DB Room #N$A7.
B $68DB,$02,$01 Room #N($A7), and the length of the entry.
B $68DD,$01 The colour is magenta and the size is #N$00.
B $68DE,$03,$01 Background objects: Arch North, Arch South, Walls Size 0.
N $68E1 Room #N$A8.
B $68E1,$02,$01 Room #N($A8), and the length of the entry.
B $68E3,$01 The colour is yellow and the size is #N$00.
B $68E4,$02,$01 Background objects: Arch South, Walls Size 0.
B $68E6,$01 The end of the background objects.
B $68E7,$09,$01 Block at (2,5,0), (2,5,1), (2,6,0), (2,6,1), (2,6,2), (2,6,3),
. (6,6,0), (6,6,1).
B $68F0,$07,$01 Block at (6,6,2), (6,6,3), (6,2,0), (6,2,1), (6,2,2), (6,2,3).
B $68F7,$03,$01 Spikes at (5,6,0), (6,3,0).
N $68FA Room #N$AA.
B $68FA,$02,$01 Room #N($AA), and the length of the entry.
B $68FC,$01 The colour is magenta and the size is #N$00.
B $68FD,$03,$01 Background objects: Arch North, Arch East, Walls Size 0.
B $6900,$01 The end of the background objects.
B $6901,$09,$01 Block at (0,0,0), (0,1,1), (0,2,2), (0,3,0), (0,3,1), (0,3,2),
. (0,3,3), (1,4,0).
B $690A,$04,$01 Block at (1,4,1), (0,5,0), (0,5,1).
B $690E,$03,$01 Spikes at (0,5,2), (1,4,2).
B $6911,$02,$01 Dropping Block at (0,4,3).
N $6913 Room #N$AB.
B $6913,$02,$01 Room #N($AB), and the length of the entry.
B $6915,$01 The colour is green and the size is #N$00.
B $6916,$04,$01 Background objects: Arch North, Arch South, Arch West, Walls
. Size 0.
N $691A Room #N$AF.
B $691A,$02,$01 Room #N($AF), and the length of the entry.
B $691C,$01 The colour is green and the size is #N$01.
B $691D,$04,$01 Background objects: Arch North, High Arch South, High Arch South
. Base, Walls Size 2.
B $6921,$01 The end of the background objects.
B $6922,$05,$01 Block at (3,3,0), (4,3,0), (3,6,0), (4,6,0).
B $6927,$02,$01 Chest at (4,6,1).
N $6929 Room #N$B3.
B $6929,$02,$01 Room #N($B3), and the length of the entry.
B $692B,$01 The colour is yellow and the size is #N$00.
B $692C,$04,$01 Background objects: Arch North, Arch East, Arch South, Walls
. Size 0.
N $6930 Room #N$B4.
B $6930,$02,$01 Room #N($B4), and the length of the entry.
B $6932,$01 The colour is green and the size is #N$00.
B $6933,$02,$01 Background objects: Arch West, Walls Size 0.
B $6935,$01 The end of the background objects.
B $6936,$09,$01 Block at (3,2,0), (4,2,0), (5,2,0), (3,3,0), (3,4,0), (3,4,1),
. (3,4,2), (3,4,3).
B $693F,$02,$01 Chest at (5,2,1).
B $6941,$03,$01 Table at (6,5,0), (6,5,1).
N $6944 Room #N$B7.
B $6944,$02,$01 Room #N($B7), and the length of the entry.
B $6946,$01 The colour is green and the size is #N$01.
B $6947,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $694A,$01 The end of the background objects.
B $694B,$05,$01 Block at (3,6,0), (4,6,0), (3,1,0), (4,1,0).
B $6950,$03,$01 Ghost at (3,4,0), (4,3,0).
N $6953 Room #N$BA.
B $6953,$02,$01 Room #N($BA), and the length of the entry.
B $6955,$01 The colour is cyan and the size is #N$00.
B $6956,$03,$01 Background objects: Arch East, Arch South, Walls Size 0.
B $6959,$01 The end of the background objects.
B $695A,$07,$01 Block at (3,5,0), (3,5,1), (3,5,2), (3,3,0), (3,3,1), (3,3,2).
B $6961,$09,$01 Spikes at (2,5,0), (2,4,0), (2,4,1), (2,4,2), (2,3,0), (4,5,0),
. (4,4,0), (4,4,1).
B $696A,$03,$01 Spikes at (4,4,2), (4,3,0).
N $696D Room #N$BB.
B $696D,$02,$01 Room #N($BB), and the length of the entry.
B $696F,$01 The colour is yellow and the size is #N$00.
B $6970,$03,$01 Background objects: Arch South, Arch West, Walls Size 0.
B $6973,$01 The end of the background objects.
B $6974,$02,$01 Ghost at (4,4,0).
B $6976,$03,$01 Moveable Block at (4,4,1), (4,4,2).
N $6979 Room #N$BF.
B $6979,$02,$01 Room #N($BF), and the length of the entry.
B $697B,$01 The colour is magenta and the size is #N$00.
B $697C,$04,$01 Background objects: Arch North, High Arch South, High Arch South
. Base, Walls Size 0.
B $6980,$01 The end of the background objects.
B $6981,$06,$01 Block at (5,7,0), (6,7,1), (6,7,2), (3,0,3), (4,0,3).
B $6987,$09,$01 Spikes at (7,7,0), (7,6,0), (7,5,0), (6,5,0), (5,5,0), (5,4,0),
. (5,3,0), (5,2,0).
B $6990,$03,$01 Spikes at (4,2,0), (4,1,0).
B $6993,$02,$01 Bouncing Ball at (7,7,1).
B $6995,$02,$01 Moveable Block at (7,7,2).
N $6997 Room #N$C3.
B $6997,$02,$01 Room #N($C3), and the length of the entry.
B $6999,$01 The colour is magenta and the size is #N$01.
B $699A,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $699D,$01 The end of the background objects.
B $699E,$09,$01 Block at (2,3,0), (3,3,0), (4,3,0), (5,3,0), (2,3,1), (3,3,1),
. (4,3,1), (5,3,1).
B $69A7,$05,$01 Block at (2,3,2), (3,3,2), (4,3,2), (5,3,2).
N $69AC Room #N$C7.
B $69AC,$02,$01 Room #N($C7), and the length of the entry.
B $69AE,$01 The colour is cyan and the size is #N$00.
B $69AF,$04,$01 Background objects: Arch North, High Arch South, High Arch South
. Base, Walls Size 0.
B $69B3,$01 The end of the background objects.
B $69B4,$02,$01 Moveable Block at (3,3,1).
B $69B6,$02,$01 Ghost at (3,3,0).
N $69B8 Room #N$CF.
B $69B8,$02,$01 Room #N($CF), and the length of the entry.
B $69BA,$01 The colour is green and the size is #N$01.
B $69BB,$05,$01 Background objects: Arch North, Arch South, Gate North, Gate
. South, Walls Size 2.
B $69C0,$01 The end of the background objects.
B $69C1,$02,$01 Ghost at (4,3,0).
N $69C3 Room #N$D0.
B $69C3,$02,$01 Room #N($D0), and the length of the entry.
B $69C5,$01 The colour is cyan and the size is #N$00.
B $69C6,$03,$01 Background objects: Arch North, Arch East, Walls Size 0.
B $69C9,$01 The end of the background objects.
B $69CA,$09,$01 Block at (3,0,0), (2,0,1), (1,0,2), (0,0,3), (0,1,3), (0,2,3),
. (0,3,3), (0,4,3).
B $69D3,$05,$01 Block at (4,3,0), (4,3,1), (4,3,2), (4,3,3).
B $69D8,$05,$01 Spikes at (3,3,0), (4,4,0), (5,3,0), (4,2,0).
N $69DD Room #N$D1.
B $69DD,$02,$01 Room #N($D1), and the length of the entry.
B $69DF,$01 The colour is green and the size is #N$02.
B $69E0,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $69E3,$01 The end of the background objects.
B $69E4,$02,$01 Guard Square at (6,2,0).
B $69E6,$09,$01 Spikes at (6,3,0), (6,4,0), (3,3,0), (4,3,0), (3,4,0), (4,4,0),
. (1,3,0), (1,4,0).
N $69EF Room #N$D2.
B $69EF,$02,$01 Room #N($D2), and the length of the entry.
B $69F1,$01 The colour is cyan and the size is #N$00.
B $69F2,$03,$01 Background objects: Arch North, Arch West, Walls Size 0.
B $69F5,$01 The end of the background objects.
B $69F6,$09,$01 Block at (3,0,0), (7,4,0), (4,0,1), (7,3,1), (5,0,2), (7,2,2),
. (6,0,3), (7,1,3).
B $69FF,$03,$01 Block at (6,1,3), (7,0,3).
B $6A02,$03,$01 High Spiked Ball at (7,1,0), (6,0,0).
N $6A05 Room #N$D3.
B $6A05,$02,$01 Room #N($D3), and the length of the entry.
B $6A07,$01 The colour is cyan and the size is #N$01.
B $6A08,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6A0B,$01 The end of the background objects.
B $6A0C,$03,$01 Block at (2,5,0), (5,5,0).
B $6A0F,$05,$01 Spikes at (2,5,1), (5,5,1), (2,3,0), (5,3,0).
B $6A14,$02,$01 Portcullis Along X at (3,5,0).
B $6A16,$02,$01 Guard Square at (5,4,0).
N $6A18 Room #N$D6.
B $6A18,$02,$01 Room #N($D6), and the length of the entry.
B $6A1A,$01 The colour is yellow and the size is #N$00.
B $6A1B,$04,$01 Background objects: Tree Arch North, Tree Arch East, Trees Size
. 0, Trees Size 1.
B $6A1F,$01 The end of the background objects.
B $6A20,$09,$01 Rock at (4,5,0), (4,5,1), (4,5,2), (4,5,3), (4,4,0), (4,3,0),
. (4,2,0), (4,2,1).
B $6A29,$02,$01 Rock at (4,2,2).
B $6A2B,$03,$01 Ball Offset Y at (5,3,1), (3,3,0).
N $6A2E Room #N$D7.
B $6A2E,$02,$01 Room #N($D7), and the length of the entry.
B $6A30,$01 The colour is magenta and the size is #N$00.
B $6A31,$05,$01 Background objects: Tree Arch North, Tree Arch East, Tree Arch
. South, Tree Arch West, Trees Size 0.
B $6A36,$01 The end of the background objects.
B $6A37,$03,$01 Fire North South at (3,3,0), (4,4,0).
B $6A3A,$03,$01 Fire East West at (3,4,0), (4,3,0).
N $6A3D Room #N$D8.
B $6A3D,$02,$01 Room #N($D8), and the length of the entry.
B $6A3F,$01 The colour is magenta and the size is #N$00.
B $6A40,$04,$01 Background objects: Tree Arch North, Tree Arch East, Tree Arch
. West, Trees Size 0.
N $6A44 Room #N$D9.
B $6A44,$02,$01 Room #N($D9), and the length of the entry.
B $6A46,$01 The colour is yellow and the size is #N$00.
B $6A47,$03,$01 Background objects: Tree Arch North, Tree Arch West, Trees Size
. 0.
N $6A4A Room #N$DD.
B $6A4A,$02,$01 Room #N($DD), and the length of the entry.
B $6A4C,$01 The colour is yellow and the size is #N$00.
B $6A4D,$04,$01 Background objects: Arch North, High Arch East, High Arch East
. Base, Walls Size 0.
B $6A51,$01 The end of the background objects.
B $6A52,$03,$01 Block at (7,4,3), (7,3,3).
B $6A55,$05,$01 High Block at (7,5,0), (6,4,0), (6,3,0), (7,2,0).
B $6A5A,$05,$01 Table at (2,3,0), (2,3,1), (2,3,2), (2,3,3).
N $6A5F Room #N$DE.
B $6A5F,$02,$01 Room #N($DE), and the length of the entry.
B $6A61,$01 The colour is magenta and the size is #N$02.
B $6A62,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
N $6A65 Room #N$DF.
B $6A65,$02,$01 Room #N($DF), and the length of the entry.
B $6A67,$01 The colour is yellow and the size is #N$00.
B $6A68,$04,$01 Background objects: Arch North, Arch South, Arch West, Walls
. Size 0.
B $6A6C,$01 The end of the background objects.
B $6A6D,$06,$01 Block at (3,3,0), (3,3,1), (3,3,2), (3,3,3), (2,4,3).
B $6A73,$05,$01 Spikes at (3,2,0), (4,3,0), (3,4,0), (2,3,0).
B $6A78,$04,$01 Collapsing Block at (2,2,0), (4,2,1), (4,4,2).
N $6A7C Room #N$E0.
B $6A7C,$02,$01 Room #N($E0), and the length of the entry.
B $6A7E,$01 The colour is yellow and the size is #N$01.
B $6A7F,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6A82,$01 The end of the background objects.
B $6A83,$09,$01 Spikes at (2,7,0), (5,7,0), (3,5,0), (4,5,0), (3,2,0), (4,2,0),
. (2,0,0), (5,0,0).
B $6A8C,$02,$01 Repel Spell at (4,4,0).
N $6A8E Room #N$E2.
B $6A8E,$02,$01 Room #N($E2), and the length of the entry.
B $6A90,$01 The colour is yellow and the size is #N$01.
B $6A91,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6A94,$01 The end of the background objects.
B $6A95,$09,$01 Spiked Ball at (5,0,0), (2,1,0), (4,1,0), (3,2,0), (5,2,0),
. (2,3,0), (4,3,0), (3,4,0).
B $6A9E,$07,$01 Spiked Ball at (5,4,0), (2,5,0), (4,5,0), (3,6,0), (5,6,0),
. (2,7,0).
N $6AA5 Room #N$E3.
B $6AA5,$02,$01 Room #N($E3), and the length of the entry.
B $6AA7,$01 The colour is yellow and the size is #N$01.
B $6AA8,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6AAB,$01 The end of the background objects.
B $6AAC,$09,$01 Dropping Block at (2,0,0), (5,0,0), (2,1,1), (5,1,1), (2,2,2),
. (5,2,2), (2,5,2), (5,5,2).
B $6AB5,$05,$01 Dropping Block at (2,6,1), (5,6,1), (2,7,0), (5,7,0).
B $6ABA,$05,$01 Collapsing Block at (2,3,3), (5,3,3), (2,4,3), (5,4,3).
B $6ABF,$02,$01 Ball Offset XY at (3,3,0).
N $6AC1 Room #N$E6.
B $6AC1,$02,$01 Room #N($E6), and the length of the entry.
B $6AC3,$01 The colour is magenta and the size is #N$00.
B $6AC4,$05,$01 Background objects: Tree Arch North, Tree Arch East, Tree Arch
. South, Trees Size 0, Trees Size 1.
N $6AC9 Room #N$E7.
B $6AC9,$02,$01 Room #N($E7), and the length of the entry.
B $6ACB,$01 The colour is yellow and the size is #N$00.
B $6ACC,$05,$01 Background objects: Tree Arch North, Tree Arch East, Tree Arch
. South, Tree Arch West, Trees Size 0.
B $6AD1,$01 The end of the background objects.
B $6AD2,$09,$01 Spikes at (3,6,0), (4,6,0), (1,4,0), (1,3,0), (6,4,0), (6,3,0),
. (3,1,0), (4,1,0).
N $6ADB Room #N$E8.
B $6ADB,$02,$01 Room #N($E8), and the length of the entry.
B $6ADD,$01 The colour is yellow and the size is #N$00.
B $6ADE,$05,$01 Background objects: Tree Arch North, Tree Arch East, Tree Arch
. South, Tree Arch West, Trees Size 0.
B $6AE3,$01 The end of the background objects.
B $6AE4,$09,$01 Rock at (3,6,0), (1,4,0), (3,4,0), (3,4,1), (3,4,2), (3,4,3),
. (5,4,0), (3,2,0).
B $6AED,$05,$01 Spikes at (3,5,0), (4,4,0), (3,3,0), (2,4,0).
N $6AF2 Room #N$E9.
B $6AF2,$02,$01 Room #N($E9), and the length of the entry.
B $6AF4,$01 The colour is magenta and the size is #N$00.
B $6AF5,$04,$01 Background objects: Tree Arch North, Tree Arch South, Tree Arch
. West, Trees Size 0.
N $6AF9 Room #N$ED.
B $6AF9,$02,$01 Room #N($ED), and the length of the entry.
B $6AFB,$01 The colour is green and the size is #N$01.
B $6AFC,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
B $6AFF,$01 The end of the background objects.
B $6B00,$09,$01 Block at (2,3,0), (3,3,0), (4,3,0), (5,3,0), (2,3,1), (3,3,1),
. (4,3,1), (5,3,1).
B $6B09,$05,$01 Block at (2,3,2), (3,3,2), (4,3,2), (5,3,2).
N $6B0E Room #N$EF.
B $6B0E,$02,$01 Room #N($EF), and the length of the entry.
B $6B10,$01 The colour is cyan and the size is #N$01.
B $6B11,$03,$01 Background objects: Arch North, Arch South, Walls Size 2.
N $6B14 Room #N$F0.
B $6B14,$02,$01 Room #N($F0), and the length of the entry.
B $6B16,$01 The colour is cyan and the size is #N$00.
B $6B17,$05,$01 Background objects: High Arch East, High Arch South, High Arch
. East Base, High Arch South Base, Walls Size 0.
B $6B1C,$01 The end of the background objects.
B $6B1D,$09,$01 Block at (7,3,3), (7,4,3), (7,7,3), (6,7,3), (0,7,1), (0,5,2),
. (0,2,3), (0,0,3).
B $6B26,$05,$01 Block at (1,0,3), (2,0,3), (3,0,3), (4,0,3).
B $6B2B,$03,$01 Spikes at (1,7,0), (3,7,0).
B $6B2E,$02,$01 Block East West at (3,7,3).
N $6B30 Room #N$F1.
B $6B30,$02,$01 Room #N($F1), and the length of the entry.
B $6B32,$01 The colour is magenta and the size is #N$02.
B $6B33,$05,$01 Background objects: Arch East, Arch West, Gate East, Gate West,
. Walls Size 1.
B $6B38,$01 The end of the background objects.
B $6B39,$02,$01 Bouncing Ball at (3,4,0).
N $6B3B Room #N$F2.
B $6B3B,$02,$01 Room #N($F2), and the length of the entry.
B $6B3D,$01 The colour is cyan and the size is #N$00.
B $6B3E,$04,$01 Background objects: Arch East, Arch South, Arch West, Walls Size
. 0.
N $6B42 Room #N$F3.
B $6B42,$02,$01 Room #N($F3), and the length of the entry.
B $6B44,$01 The colour is magenta and the size is #N$00.
B $6B45,$03,$01 Background objects: Arch South, Arch West, Walls Size 0.
B $6B48,$01 The end of the background objects.
B $6B49,$09,$01 Block at (2,6,0), (2,7,0), (2,6,1), (2,7,1), (4,6,0), (4,7,0),
. (4,6,1), (4,7,1).
B $6B52,$03,$01 Block at (3,6,2), (3,7,2).
B $6B55,$02,$01 Ghost at (3,6,0).
B $6B57,$03,$01 Chest at (3,5,0), (3,5,1).
N $6B5A Room #N$F6.
B $6B5A,$02,$01 Room #N($F6), and the length of the entry.
B $6B5C,$01 The colour is yellow and the size is #N$00.
B $6B5D,$05,$01 Background objects: Tree Arch East, Tree Arch South, Trees Size
. 0, Trees Size 1, Trees Size 2.
B $6B62,$01 The end of the background objects.
B $6B63,$05,$01 Rock at (3,3,0), (3,3,1), (3,3,2), (3,3,3).
B $6B68,$02,$01 Collapsing Block at (4,3,0).
B $6B6A,$02,$01 Chest at (2,2,0).
B $6B6C,$02,$01 Table at (4,6,0).
N $6B6E Room #N$F7.
B $6B6E,$02,$01 Room #N($F7), and the length of the entry.
B $6B70,$01 The colour is magenta and the size is #N$00.
B $6B71,$05,$01 Background objects: Tree Arch East, Tree Arch South, Tree Arch
. West, Trees Size 0, Trees Size 2.
B $6B76,$01 The end of the background objects.
B $6B77,$09,$01 Rock at (2,4,0), (3,4,0), (4,4,0), (2,3,0), (4,3,0), (2,2,0),
. (3,2,0), (4,2,0).
B $6B80,$02,$01 Bouncing Ball at (3,3,0).
B $6B82,$02,$01 Chest at (3,3,1).
N $6B84 Room #N$F8.
B $6B84,$02,$01 Room #N($F8), and the length of the entry.
B $6B86,$01 The colour is magenta and the size is #N$00.
B $6B87,$05,$01 Background objects: Tree Arch East, Tree Arch South, Tree Arch
. West, Trees Size 0, Trees Size 2.
N $6B8C Room #N$F9.
B $6B8C,$02,$01 Room #N($F9), and the length of the entry.
B $6B8E,$01 The colour is yellow and the size is #N$00.
B $6B8F,$04,$01 Background objects: Tree Arch South, Tree Arch West, Trees Size
. 0, Trees Size 2.
B $6B93,$01 The end of the background objects.
B $6B94,$09,$01 High Spiked Ball at (7,7,3), (6,7,3), (6,6,3), (7,6,3), (5,7,3),
. (7,5,3), (3,0,3), (4,0,3).
B $6B9D,$03,$01 High Spiked Ball at (0,3,3), (0,4,3).
N $6BA0 Room #N$FD.
B $6BA0,$02,$01 Room #N($FD), and the length of the entry.
B $6BA2,$01 The colour is yellow and the size is #N$00.
B $6BA3,$03,$01 Background objects: Arch East, Arch South, Walls Size 0.
B $6BA6,$01 The end of the background objects.
B $6BA7,$09,$01 Block at (0,5,0), (1,5,0), (2,5,0), (2,6,0), (2,7,0), (0,6,1),
. (1,6,1), (1,7,1).
B $6BB0,$02,$01 Block at (0,7,2).
N $6BB2 Room #N$FE.
B $6BB2,$02,$01 Room #N($FE), and the length of the entry.
B $6BB4,$01 The colour is magenta and the size is #N$02.
B $6BB5,$03,$01 Background objects: Arch East, Arch West, Walls Size 1.
B $6BB8,$01 The end of the background objects.
B $6BB9,$05,$01 Spikes at (5,4,0), (5,3,0), (2,4,0), (2,3,0).
B $6BBE,$05,$01 Gargoyle at (3,5,0), (4,5,0), (3,2,0), (4,2,0).
B $6BC3,$02,$01 Ball Offset XY at (3,3,1).
N $6BC5 Room #N$FF.
B $6BC5,$02,$01 Room #N($FF), and the length of the entry.
B $6BC7,$01 The colour is yellow and the size is #N$00.
B $6BC8,$03,$01 Background objects: Arch South, Arch West, Walls Size 0.
B $6BCB,$01 The end of the background objects.
B $6BCC,$05,$01 Spikes at (6,5,0), (5,6,0), (7,6,0), (6,7,0).

w $6BD1 Block Type Table
@ $6BD1 label=BlockTypeTable
D $6BD1 The address of the list of objects that makes up each type of block that
. the rooms can have, which #R$D3F0 uses to build the foreground objects of a
. room.
W $6BD1,$02,$02 Type #N$00: Block.
W $6BD3,$02,$02 Type #N$01: Fire.
W $6BD5,$02,$02 Type #N$02: Ball Offset Y.
W $6BD7,$02,$02 Type #N$03: Rock.
W $6BD9,$02,$02 Type #N$04: Gargoyle.
W $6BDB,$02,$02 Type #N$05: Spikes.
W $6BDD,$02,$02 Type #N$06: Chest.
W $6BDF,$02,$02 Type #N$07: Table.
W $6BE1,$02,$02 Type #N$08: Guard East West.
W $6BE3,$02,$02 Type #N$09: Ghost.
W $6BE5,$02,$02 Type #N$0A: Fire North South.
W $6BE7,$02,$02 Type #N$0B: High Block.
W $6BE9,$02,$02 Type #N$0C: Ball Offset XY.
W $6BEB,$02,$02 Type #N$0D: Guard Square.
W $6BED,$02,$02 Type #N$0E: Block East West.
W $6BEF,$02,$02 Type #N$0F: Block North South.
W $6BF1,$02,$02 Type #N$10: Moveable Block.
W $6BF3,$02,$02 Type #N$11: High Spikes.
W $6BF5,$02,$02 Type #N$12: Spiked Ball.
W $6BF7,$02,$02 Type #N$13: High Spiked Ball.
W $6BF9,$02,$02 Type #N$14: Fire East West.
W $6BFB,$02,$02 Type #N$15: Dropping Block.
W $6BFD,$02,$02 Type #N$16: Collapsing Block.
W $6BFF,$02,$02 Type #N$17: Bouncing Ball.
W $6C01,$02,$02 Type #N$18: Ball.
W $6C03,$02,$02 Type #N$19: Repel Spell.
W $6C05,$02,$02 Type #N$1A: Portcullis Along X.
W $6C07,$02,$02 Type #N$1B: Portcullis Along Y.
W $6C09,$02,$02 Type #N$1C: Ball Offset X.

b $6C0B Block Types
@ $6C0B label=BlockTypes
D $6C0B The objects that make up each type of block, which are in the table at
. #R$6BD1. A list has a group of six bytes for every object, which ends with a
. zero byte. The bytes of an object are described by this table.
. #TABLE(default,centre,left)
. { =h Byte | =h Contents }
. { #N$00 | The graphic number }
. { #N$01-#N$03 | The width, depth and height }
. { #N$04 | The flags }
. { #N$05 | The offsets of the position: bit 0 is half a step of X, bit 1 is
. half a step of Y, and bits 2-7 are added to the Z coordinate }
. TABLE#
@ $6C0B label=BlockType_Block
N $6C0B Block.
B $6C0B,$06,$06 Graphic #N$07 (block), #N$08 by #N$08 by #N($0C), flags: drawn.
B $6C11,$01 Terminator.
@ $6C12 label=BlockType_High_Block
N $6C12 High Block.
B $6C12,$06,$06 Graphic #N$07 (block), #N$08 by #N$08 by #N($0C), flags: drawn,
. offsets #N$30.
B $6C18,$01 Terminator.
@ $6C19 label=BlockType_Block_East_West
N $6C19 Block East West.
B $6C19,$06,$06 Graphic #N$36 (block), #N$08 by #N$08 by #N($0C), flags: drawn.
B $6C1F,$01 Terminator.
@ $6C20 label=BlockType_Block_North_South
N $6C20 Block North South.
B $6C20,$06,$06 Graphic #N$37 (block), #N$08 by #N$08 by #N($0C), flags: drawn.
B $6C26,$01 Terminator.
@ $6C27 label=BlockType_Moveable_Block
N $6C27 Moveable Block.
B $6C27,$06,$06 Graphic #N$3E (block), #N$08 by #N$08 by #N($0C), flags: drawn,
. moveable.
B $6C2D,$01 Terminator.
@ $6C2E label=BlockType_Dropping_Block
N $6C2E Dropping Block.
B $6C2E,$06,$06 Graphic #N$5B (block), #N$08 by #N$08 by #N($0C), flags: drawn.
B $6C34,$01 Terminator.
@ $6C35 label=BlockType_Collapsing_Block
N $6C35 Collapsing Block.
B $6C35,$06,$06 Graphic #N$8F (block), #N$08 by #N$08 by #N($0C), flags: drawn.
B $6C3B,$01 Terminator.
@ $6C3C label=BlockType_Fire
N $6C3C Fire.
B $6C3C,$06,$06 Graphic #N$B0 (fire), #N$06 by #N$06 by #N($0C), flags: drawn.
B $6C42,$01 Terminator.
@ $6C43 label=BlockType_Ball_Offset_Y
N $6C43 Ball Offset Y.
B $6C43,$06,$06 Graphic #N$B2 (ball), #N$07 by #N$07 by #N($0C), flags: drawn,
. offsets #N$02.
B $6C49,$01 Terminator.
@ $6C4A label=BlockType_Ball_Offset_XY
N $6C4A Ball Offset XY.
B $6C4A,$06,$06 Graphic #N$B2 (ball), #N$07 by #N$07 by #N($0C), flags: drawn,
. offsets #N$03.
B $6C50,$01 Terminator.
@ $6C51 label=BlockType_Ball
N $6C51 Ball.
B $6C51,$06,$06 Graphic #N$B2 (ball), #N$07 by #N$07 by #N($0C), flags: drawn.
B $6C57,$01 Terminator.
@ $6C58 label=BlockType_Ball_Offset_X
N $6C58 Ball Offset X.
B $6C58,$06,$06 Graphic #N$B2 (ball), #N$07 by #N$07 by #N($0C), flags: drawn,
. offsets #N$01.
B $6C5E,$01 Terminator.
@ $6C5F label=BlockType_Bouncing_Ball
N $6C5F Bouncing Ball.
B $6C5F,$06,$06 Graphic #N$B6 (ball), #N$07 by #N$07 by #N($0C), flags: drawn.
B $6C65,$01 Terminator.
@ $6C66 label=BlockType_Rock
N $6C66 Rock.
B $6C66,$06,$06 Graphic #N$06 (rock), #N$08 by #N$08 by #N($0C), flags: drawn.
B $6C6C,$01 Terminator.
@ $6C6D label=BlockType_Gargoyle
N $6C6D Gargoyle.
B $6C6D,$06,$06 Graphic #N$16 (gargoyle), #N$06 by #N$06 by #N($0C), flags:
. drawn.
B $6C73,$01 Terminator.
@ $6C74 label=BlockType_Spikes
N $6C74 Spikes.
B $6C74,$06,$06 Graphic #N$17 (spikes), #N$06 by #N$06 by #N($0C), flags: drawn,
. flipped.
B $6C7A,$01 Terminator.
@ $6C7B label=BlockType_High_Spikes
N $6C7B High Spikes.
B $6C7B,$06,$06 Graphic #N$17 (spikes), #N$06 by #N$06 by #N($0C), flags: drawn,
. flipped, offsets #N$30.
B $6C81,$01 Terminator.
@ $6C82 label=BlockType_Spiked_Ball
N $6C82 Spiked Ball.
B $6C82,$06,$06 Graphic #N$3F (spiked ball), #N$06 by #N$06 by #N($0C), flags:
. drawn.
B $6C88,$01 Terminator.
@ $6C89 label=BlockType_High_Spiked_Ball
N $6C89 High Spiked Ball.
B $6C89,$06,$06 Graphic #N$3F (spiked ball), #N$06 by #N$06 by #N($0C), flags:
. drawn, offsets #N$30.
B $6C8F,$01 Terminator.
@ $6C90 label=BlockType_Chest
N $6C90 Chest.
B $6C90,$06,$06 Graphic #N$55 (chest), #N$09 by #N$06 by #N($0C), flags: drawn,
. moveable.
B $6C96,$01 Terminator.
@ $6C97 label=BlockType_Table
N $6C97 Table.
B $6C97,$06,$06 Graphic #N$54 (table), #N$06 by #N$0A by #N($0C), flags: drawn,
. moveable.
B $6C9D,$01 Terminator.
@ $6C9E label=BlockType_Guard_East_West
N $6C9E Guard East West.
B $6C9E,$06,$06 Graphic #N$96 (guard top half), #N$06 by #N$06 by #N($18),
. flags: drawn, offsets #N$02.
B $6CA4,$06,$06 Graphic #N$90 (human legs west), #N$06 by #N$06 by #N($00),
. flags: drawn, ignored in 3D, offsets #N$02.
B $6CAA,$01 Terminator.
@ $6CAB label=BlockType_Guard_Square
N $6CAB Guard Square.
B $6CAB,$06,$06 Graphic #N$1E (guard top half), #N$06 by #N$06 by #N($18),
. flags: drawn.
B $6CB1,$06,$06 Graphic #N$90 (human legs west), #N$06 by #N$06 by #N($00),
. flags: drawn, ignored in 3D.
B $6CB7,$01 Terminator.
@ $6CB8 label=BlockType_Ghost
N $6CB8 Ghost.
B $6CB8,$06,$06 Graphic #N$52 (ghost), #N$06 by #N$06 by #N($0C), flags: drawn.
B $6CBE,$01 Terminator.
@ $6CBF label=BlockType_Fire_North_South
N $6CBF Fire North South.
B $6CBF,$06,$06 Graphic #N$B5 (fire), #N$06 by #N$06 by #N($0C), flags: drawn.
B $6CC5,$01 Terminator.
@ $6CC6 label=BlockType_Fire_East_West
N $6CC6 Fire East West.
B $6CC6,$06,$06 Graphic #N$56 (fire), #N$06 by #N$06 by #N($0C), flags: drawn.
B $6CCC,$01 Terminator.
@ $6CCD label=BlockType_Repel_Spell
N $6CCD Repel Spell.
B $6CCD,$06,$06 Graphic #N$A4 (sparkle), #N$05 by #N$05 by #N($0C), flags:
. drawn.
B $6CD3,$01 Terminator.
@ $6CD4 label=BlockType_Portcullis_Along_X
N $6CD4 Portcullis Along X.
B $6CD4,$06,$06 Graphic #N$08 (portcullis), #N$0C by #N$01 by #N($20), flags:
. drawn, flipped, offsets #N$01.
B $6CDA,$01 Terminator.
@ $6CDB label=BlockType_Portcullis_Along_Y
N $6CDB Portcullis Along Y.
B $6CDB,$06,$06 Graphic #N$08 (portcullis), #N$01 by #N$0C by #N($20), flags:
. drawn, offsets #N$02.
B $6CE1,$01 Terminator.

w $6CE2 Background Type Table
@ $6CE2 label=BackgroundTypeTable
D $6CE2 The address of the list of objects that makes up each type of background
. object, which #R$D3F0 uses to build the objects of a room that are not
. foreground objects.
W $6CE2,$02,$02 Type #N$00: Arch North.
W $6CE4,$02,$02 Type #N$01: Arch East.
W $6CE6,$02,$02 Type #N$02: Arch South.
W $6CE8,$02,$02 Type #N$03: Arch West.
W $6CEA,$02,$02 Type #N$04: Tree Arch North.
W $6CEC,$02,$02 Type #N$05: Tree Arch East.
W $6CEE,$02,$02 Type #N$06: Tree Arch South.
W $6CF0,$02,$02 Type #N$07: Tree Arch West.
W $6CF2,$02,$02 Type #N$08: Gate North.
W $6CF4,$02,$02 Type #N$09: Gate East.
W $6CF6,$02,$02 Type #N$0A: Gate South.
W $6CF8,$02,$02 Type #N$0B: Gate West.
W $6CFA,$02,$02 Type #N$0C: Walls Size 0.
W $6CFC,$02,$02 Type #N$0D: Walls Size 1.
W $6CFE,$02,$02 Type #N$0E: Walls Size 2.
W $6D00,$02,$02 Type #N$0F: Trees Size 0.
W $6D02,$02,$02 Type #N$10: Trees Size 1.
W $6D04,$02,$02 Type #N$11: Trees Size 2.
W $6D06,$02,$02 Type #N$12: Wizard.
W $6D08,$02,$02 Type #N$13: Cauldron.
W $6D0A,$02,$02 Type #N$14: High Arch East.
W $6D0C,$02,$02 Type #N$15: High Arch South.
W $6D0E,$02,$02 Type #N$16: High Arch East Base.
W $6D10,$02,$02 Type #N$17: High Arch South Base.

b $6D12 Background Types
@ $6D12 label=BackgroundTypes
D $6D12 The objects that make up each type of background object, which are in
. the table at #R$6CE2. A list has a group of eight bytes for every object,
. which ends with a zero byte. The bytes of an object are described by this
. table.
. #TABLE(default,centre,left)
. { =h Byte | =h Contents }
. { #N$00 | The graphic number }
. { #N$01-#N$03 | The X, Y and Z coordinates }
. { #N$04-#N$06 | The width, depth and height }
. { #N$07 | The flags }
. TABLE#
@ $6D12 label=BackgroundType_Arch_North
N $6D12 Arch North.
B $6D12,$08,$08 Graphic #N$02 (stone arch near) at (#N($8D),#N($C4),#N$80),
. #N$03 by #N$05 by #N($28), flags: drawn, flipped.
B $6D1A,$08,$08 Graphic #N$03 (stone arch far) at (#N($73),#N($C4),#N$80), #N$03
. by #N$05 by #N($28), flags: drawn, flipped.
B $6D22,$01 Terminator.
@ $6D23 label=BackgroundType_Arch_East
N $6D23 Arch East.
B $6D23,$08,$08 Graphic #N$02 (stone arch near) at (#N($C4),#N($73),#N$80),
. #N$05 by #N$03 by #N($28), flags: drawn.
B $6D2B,$08,$08 Graphic #N$03 (stone arch far) at (#N($C4),#N($8D),#N$80), #N$05
. by #N$03 by #N($28), flags: drawn.
B $6D33,$01 Terminator.
@ $6D34 label=BackgroundType_High_Arch_East
N $6D34 High Arch East.
B $6D34,$08,$08 Graphic #N$02 (stone arch near) at (#N($C4),#N($73),#N$B0),
. #N$05 by #N$03 by #N($28), flags: drawn.
B $6D3C,$08,$08 Graphic #N$03 (stone arch far) at (#N($C4),#N($8D),#N$B0), #N$05
. by #N$03 by #N($28), flags: drawn.
B $6D44,$01 Terminator.
@ $6D45 label=BackgroundType_Arch_South
N $6D45 Arch South.
B $6D45,$08,$08 Graphic #N$02 (stone arch near) at (#N($8D),#N($3B),#N$80),
. #N$03 by #N$05 by #N($28), flags: drawn, flipped.
B $6D4D,$08,$08 Graphic #N$03 (stone arch far) at (#N($73),#N($3B),#N$80), #N$03
. by #N$05 by #N($28), flags: drawn, flipped.
B $6D55,$01 Terminator.
@ $6D56 label=BackgroundType_High_Arch_South
N $6D56 High Arch South.
B $6D56,$08,$08 Graphic #N$02 (stone arch near) at (#N($8D),#N($3B),#N$B0),
. #N$03 by #N$05 by #N($28), flags: drawn, flipped.
B $6D5E,$08,$08 Graphic #N$03 (stone arch far) at (#N($73),#N($3B),#N$B0), #N$03
. by #N$05 by #N($28), flags: drawn, flipped.
B $6D66,$01 Terminator.
@ $6D67 label=BackgroundType_Arch_West
N $6D67 Arch West.
B $6D67,$08,$08 Graphic #N$02 (stone arch near) at (#N($3B),#N($73),#N$80),
. #N$05 by #N$03 by #N($28), flags: drawn.
B $6D6F,$08,$08 Graphic #N$03 (stone arch far) at (#N($3B),#N($8D),#N$80), #N$05
. by #N$03 by #N($28), flags: drawn.
B $6D77,$01 Terminator.
@ $6D78 label=BackgroundType_Tree_Arch_North
N $6D78 Tree Arch North.
B $6D78,$08,$08 Graphic #N$04 (tree arch near) at (#N($8D),#N($C4),#N$80), #N$03
. by #N$05 by #N($28), flags: drawn, flipped.
B $6D80,$08,$08 Graphic #N$05 (tree arch far) at (#N($73),#N($C4),#N$80), #N$03
. by #N$05 by #N($28), flags: drawn, flipped.
B $6D88,$01 Terminator.
@ $6D89 label=BackgroundType_Tree_Arch_East
N $6D89 Tree Arch East.
B $6D89,$08,$08 Graphic #N$04 (tree arch near) at (#N($C4),#N($73),#N$80), #N$05
. by #N$03 by #N($28), flags: drawn.
B $6D91,$08,$08 Graphic #N$05 (tree arch far) at (#N($C4),#N($8D),#N$80), #N$05
. by #N$03 by #N($28), flags: drawn.
B $6D99,$01 Terminator.
@ $6D9A label=BackgroundType_Tree_Arch_South
N $6D9A Tree Arch South.
B $6D9A,$08,$08 Graphic #N$04 (tree arch near) at (#N($8D),#N($3B),#N$80), #N$03
. by #N$05 by #N($28), flags: drawn, flipped.
B $6DA2,$08,$08 Graphic #N$05 (tree arch far) at (#N($73),#N($3B),#N$80), #N$03
. by #N$05 by #N($28), flags: drawn, flipped.
B $6DAA,$01 Terminator.
@ $6DAB label=BackgroundType_Tree_Arch_West
N $6DAB Tree Arch West.
B $6DAB,$08,$08 Graphic #N$04 (tree arch near) at (#N($3B),#N($73),#N$80), #N$05
. by #N$03 by #N($28), flags: drawn.
B $6DB3,$08,$08 Graphic #N$05 (tree arch far) at (#N($3B),#N($8D),#N$80), #N$05
. by #N$03 by #N($28), flags: drawn.
B $6DBB,$01 Terminator.
@ $6DBC label=BackgroundType_Gate_North
N $6DBC Gate North.
B $6DBC,$08,$08 Graphic #N$08 (portcullis) at (#N($80),#N($BE),#N$A0), #N$0C by
. #N$01 by #N($20), flags: drawn, flipped.
B $6DC4,$01 Terminator.
@ $6DC5 label=BackgroundType_Gate_East
N $6DC5 Gate East.
B $6DC5,$08,$08 Graphic #N$08 (portcullis) at (#N($BE),#N($80),#N$A0), #N$01 by
. #N$0C by #N($20), flags: drawn.
B $6DCD,$01 Terminator.
@ $6DCE label=BackgroundType_Gate_South
N $6DCE Gate South.
B $6DCE,$08,$08 Graphic #N$08 (portcullis) at (#N($80),#N($41),#N$A0), #N$0C by
. #N$01 by #N($20), flags: drawn, flipped.
B $6DD6,$01 Terminator.
@ $6DD7 label=BackgroundType_Gate_West
N $6DD7 Gate West.
B $6DD7,$08,$08 Graphic #N$08 (portcullis) at (#N($41),#N($80),#N$A0), #N$01 by
. #N$0C by #N($20), flags: drawn.
B $6DDF,$01 Terminator.
@ $6DE0 label=BackgroundType_Walls_Size_0
N $6DE0 Walls Size 0.
B $6DE0,$08,$08 Graphic #N$0D (wall bricks) at (#N($3F),#N($B8),#N$80), #N$00 by
. #N$08 by #N($28), flags: drawn.
B $6DE8,$08,$08 Graphic #N$0E (wall bricks) at (#N($47),#N($C0),#N$80), #N$08 by
. #N$00 by #N($28), flags: drawn.
B $6DF0,$08,$08 Graphic #N$0F (wall bricks) at (#N($3F),#N($49),#N$80), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6DF8,$08,$08 Graphic #N$0F (wall bricks) at (#N($B8),#N($C0),#N$80), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6E00,$08,$08 Graphic #N$0F (wall bricks) at (#N($3F),#N($49),#N$AC), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6E08,$08,$08 Graphic #N$0F (wall bricks) at (#N($B8),#N($C0),#N$AC), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6E10,$08,$08 Graphic #N$0A (wall bricks) at (#N($5C),#N($C0),#N$80), #N$14 by
. #N$00 by #N($14), flags: drawn, flipped.
B $6E18,$08,$08 Graphic #N$0B (wall bricks) at (#N($3F),#N($5C),#N$98), #N$00 by
. #N$0C by #N($14), flags: drawn.
B $6E20,$08,$08 Graphic #N$0C (wall bricks) at (#N($3F),#N($A0),#N$98), #N$00 by
. #N$0C by #N($0C), flags: drawn.
B $6E28,$08,$08 Graphic #N$0B (wall bricks) at (#N($A4),#N($C0),#N$98), #N$0C by
. #N$00 by #N($14), flags: drawn, flipped.
B $6E30,$08,$08 Graphic #N$0A (wall bricks) at (#N($3F),#N($6D),#N$B1), #N$00 by
. #N$14 by #N($14), flags: drawn.
B $6E38,$08,$08 Graphic #N$0C (wall bricks) at (#N($60),#N($C0),#N$A0), #N$0C by
. #N$00 by #N($0C), flags: drawn, flipped.
B $6E40,$08,$08 Graphic #N$0A (wall bricks) at (#N($90),#N($C0),#N$B0), #N$14 by
. #N$00 by #N($14), flags: drawn, flipped.
B $6E48,$01 Terminator.
@ $6E49 label=BackgroundType_Walls_Size_1
N $6E49 Walls Size 1.
B $6E49,$08,$08 Graphic #N$0D (wall bricks) at (#N($3F),#N($98),#N$80), #N$00 by
. #N$08 by #N($28), flags: drawn.
B $6E51,$08,$08 Graphic #N$0E (wall bricks) at (#N($47),#N($A0),#N$80), #N$08 by
. #N$00 by #N($28), flags: drawn.
B $6E59,$08,$08 Graphic #N$0F (wall bricks) at (#N($3F),#N($63),#N$80), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6E61,$08,$08 Graphic #N$0F (wall bricks) at (#N($B8),#N($A0),#N$80), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6E69,$08,$08 Graphic #N$0F (wall bricks) at (#N($3F),#N($63),#N$AC), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6E71,$08,$08 Graphic #N$0F (wall bricks) at (#N($B8),#N($A0),#N$AC), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6E79,$08,$08 Graphic #N$0D (wall bricks) at (#N($3F),#N($98),#N$A8), #N$00 by
. #N$08 by #N($28), flags: drawn.
B $6E81,$08,$08 Graphic #N$0E (wall bricks) at (#N($47),#N($A0),#N$A8), #N$08 by
. #N$00 by #N($28), flags: drawn.
B $6E89,$08,$08 Graphic #N$0F (wall bricks) at (#N($B8),#N($A0),#N$D0), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6E91,$08,$08 Graphic #N$0A (wall bricks) at (#N($80),#N($A0),#N$80), #N$14 by
. #N$00 by #N($14), flags: drawn, flipped.
B $6E99,$08,$08 Graphic #N$0A (wall bricks) at (#N($3F),#N($7E),#N$B0), #N$00 by
. #N$14 by #N($14), flags: drawn.
B $6EA1,$08,$08 Graphic #N$0B (wall bricks) at (#N($60),#N($A0),#N$90), #N$0C by
. #N$00 by #N($14), flags: drawn, flipped.
B $6EA9,$08,$08 Graphic #N$0A (wall bricks) at (#N($60),#N($A0),#N$B8), #N$14 by
. #N$00 by #N($14), flags: drawn, flipped.
B $6EB1,$08,$08 Graphic #N$0C (wall bricks) at (#N($A0),#N($A0),#N$B0), #N$0C by
. #N$00 by #N($0C), flags: drawn, flipped.
B $6EB9,$01 Terminator.
@ $6EBA label=BackgroundType_Walls_Size_2
N $6EBA Walls Size 2.
B $6EBA,$08,$08 Graphic #N$0D (wall bricks) at (#N($5F),#N($B8),#N$80), #N$00 by
. #N$08 by #N($28), flags: drawn.
B $6EC2,$08,$08 Graphic #N$0E (wall bricks) at (#N($67),#N($C0),#N$80), #N$08 by
. #N$00 by #N($28), flags: drawn.
B $6ECA,$08,$08 Graphic #N$0F (wall bricks) at (#N($5F),#N($48),#N$80), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6ED2,$08,$08 Graphic #N$0F (wall bricks) at (#N($9D),#N($C0),#N$80), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6EDA,$08,$08 Graphic #N$0D (wall bricks) at (#N($5F),#N($B8),#N$A8), #N$00 by
. #N$08 by #N($28), flags: drawn.
B $6EE2,$08,$08 Graphic #N$0E (wall bricks) at (#N($67),#N($C0),#N$A8), #N$08 by
. #N$00 by #N($28), flags: drawn.
B $6EEA,$08,$08 Graphic #N$0F (wall bricks) at (#N($5F),#N($48),#N$AC), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6EF2,$08,$08 Graphic #N$0F (wall bricks) at (#N($9D),#N($C0),#N$AC), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6EFA,$08,$08 Graphic #N$0F (wall bricks) at (#N($5F),#N($48),#N$D0), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6F02,$08,$08 Graphic #N$0A (wall bricks) at (#N($5F),#N($90),#N$80), #N$00 by
. #N$14 by #N($14), flags: drawn.
B $6F0A,$08,$08 Graphic #N$0A (wall bricks) at (#N($84),#N($C0),#N$B0), #N$14 by
. #N$00 by #N($14), flags: drawn, flipped.
B $6F12,$08,$08 Graphic #N$0B (wall bricks) at (#N($5F),#N($60),#N$90), #N$00 by
. #N$0C by #N($14), flags: drawn.
B $6F1A,$08,$08 Graphic #N$0A (wall bricks) at (#N($5F),#N($68),#N$B8), #N$00 by
. #N$14 by #N($14), flags: drawn.
B $6F22,$08,$08 Graphic #N$0C (wall bricks) at (#N($5F),#N($A0),#N$B0), #N$00 by
. #N$0C by #N($0C), flags: drawn.
B $6F2A,$01 Terminator.
@ $6F2B label=BackgroundType_Trees_Size_0
N $6F2B Trees Size 0.
B $6F2B,$08,$08 Graphic #N$80 (tree wall) at (#N($3F),#N($49),#N$80), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6F33,$08,$08 Graphic #N$81 (tree wall) at (#N($3F),#N($58),#N$80), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6F3B,$08,$08 Graphic #N$82 (tree wall) at (#N($3F),#N($68),#N$80), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6F43,$08,$08 Graphic #N$80 (tree wall) at (#N($3F),#N($98),#N$80), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6F4B,$08,$08 Graphic #N$81 (tree wall) at (#N($3F),#N($A8),#N$80), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6F53,$08,$08 Graphic #N$82 (tree wall) at (#N($3F),#N($B8),#N$80), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6F5B,$08,$08 Graphic #N$80 (tree wall) at (#N($48),#N($C0),#N$80), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6F63,$08,$08 Graphic #N$81 (tree wall) at (#N($58),#N($C0),#N$80), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6F6B,$08,$08 Graphic #N$82 (tree wall) at (#N($68),#N($C0),#N$80), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6F73,$08,$08 Graphic #N$80 (tree wall) at (#N($98),#N($C0),#N$80), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6F7B,$08,$08 Graphic #N$81 (tree wall) at (#N($A8),#N($C0),#N$80), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6F83,$08,$08 Graphic #N$82 (tree wall) at (#N($B8),#N($C0),#N$80), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6F8B,$01 Terminator.
@ $6F8C label=BackgroundType_Trees_Size_1
N $6F8C Trees Size 1.
B $6F8C,$08,$08 Graphic #N$80 (tree wall) at (#N($3F),#N($78),#N$80), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6F94,$08,$08 Graphic #N$81 (tree wall) at (#N($3F),#N($88),#N$80), #N$00 by
. #N$08 by #N($2C), flags: drawn.
B $6F9C,$01 Terminator.
@ $6F9D label=BackgroundType_Trees_Size_2
N $6F9D Trees Size 2.
B $6F9D,$08,$08 Graphic #N$80 (tree wall) at (#N($78),#N($C0),#N$80), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6FA5,$08,$08 Graphic #N$81 (tree wall) at (#N($88),#N($C0),#N$80), #N$08 by
. #N$00 by #N($2C), flags: drawn, flipped.
B $6FAD,$01 Terminator.
@ $6FAE label=BackgroundType_Wizard
N $6FAE Wizard.
B $6FAE,$08,$08 Graphic #N$9E (wizard top half) at (#N($98),#N($68),#N$80),
. #N$05 by #N$05 by #N($18), flags: drawn.
B $6FB6,$08,$08 Graphic #N$90 (human legs west) at (#N($A0),#N($60),#N$80),
. #N$05 by #N$05 by #N($00), flags: drawn, ignored in 3D.
B $6FBE,$01 Terminator.
@ $6FBF label=BackgroundType_Cauldron
N $6FBF Cauldron.
B $6FBF,$08,$08 Graphic #N$8D (cauldron bottom) at (#N($80),#N($80),#N$80),
. #N$0A by #N$0A by #N($18), flags: drawn.
B $6FC7,$08,$08 Graphic #N$8E (cauldron top) at (#N($80),#N($88),#N$80), #N$00
. by #N$00 by #N($00), flags: drawn, ignored in 3D.
B $6FCF,$01 Terminator.
@ $6FD0 label=BackgroundType_High_Arch_East_Base
N $6FD0 High Arch East Base.
B $6FD0,$08,$08 Graphic #N$07 (block) at (#N($C8),#N($78),#N$A4), #N$08 by #N$08
. by #N($0C), flags: drawn.
B $6FD8,$08,$08 Graphic #N$07 (block) at (#N($C8),#N($88),#N$A4), #N$08 by #N$08
. by #N($0C), flags: drawn.
B $6FE0,$01 Terminator.
@ $6FE1 label=BackgroundType_High_Arch_South_Base
N $6FE1 High Arch South Base.
B $6FE1,$08,$08 Graphic #N$07 (block) at (#N($78),#N($38),#N$A4), #N$08 by #N$08
. by #N($0C), flags: drawn.
B $6FE9,$08,$08 Graphic #N$07 (block) at (#N($88),#N($38),#N$A4), #N$08 by #N$08
. by #N($0C), flags: drawn.
B $6FF1,$01 Terminator.

g $6FF2 Special Objects Table
@ $6FF2 label=SpecialObjectsTable
D $6FF2 The special objects of the game, which are the seven objects that the
. player has to take to the cauldron and the extra life, four of each. Each one
. has nine bytes, which are described by this table. The graphic numbers are
. given out at random at the start of a game by #R$C47E, and the current place
. of each object is copied from where it starts, so that the objects are in a
. different room each time.
. #TABLE(default,centre,left)
. { =h Byte | =h Contents }
. { #N$00 | The graphic number, which is #N$00 while the player is carrying the
. object or after it has been put in the cauldron }
. { #N$01-#N$04 | The X, Y and Z coordinates and the room number where the
. object starts }
. { #N$05-#N$08 | The X, Y and Z coordinates and the room number where the
. object is now }
. TABLE#
B $6FF2,$09,$01 Starts at (#N($88),#N($80),#N$A4) in room #N$6D.
B $6FFB,$09,$01 Starts at (#N($80),#N($80),#N$8C) in room #N$27.
B $7004,$09,$01 Starts at (#N($88),#N($78),#N$B0) in room #N$D0.
B $700D,$09,$01 Starts at (#N($78),#N($88),#N$80) in room #N$0A.
B $7016,$09,$01 Starts at (#N($78),#N($88),#N$80) in room #N$BA.
B $701F,$09,$01 Starts at (#N($88),#N($78),#N$B0) in room #N$42.
B $7028,$09,$01 Starts at (#N($88),#N($B8),#N$BC) in room #N$8D.
B $7031,$09,$01 Starts at (#N($A8),#N($A8),#N$80) in room #N$FF.
B $703A,$09,$01 Starts at (#N($80),#N($80),#N$80) in room #N$87.
B $7043,$09,$01 Starts at (#N($78),#N($B8),#N$80) in room #N$F3.
B $704C,$09,$01 Starts at (#N($A8),#N($68),#N$B0) in room #N$A8.
B $7055,$09,$01 Starts at (#N($B8),#N($48),#N$B0) in room #N$D2.
B $705E,$09,$01 Starts at (#N($48),#N($48),#N$80) in room #N$00.
B $7067,$09,$01 Starts at (#N($88),#N($B8),#N$80) in room #N$22.
B $7070,$09,$01 Starts at (#N($B8),#N($B8),#N$B0) in room #N$7A.
B $7079,$09,$01 Starts at (#N($B8),#N($B8),#N$80) in room #N$F9.
B $7082,$09,$01 Starts at (#N($88),#N($98),#N$B0) in room #N$D6.
B $708B,$09,$01 Starts at (#N($78),#N($88),#N$B0) in room #N$E8.
B $7094,$09,$01 Starts at (#N($78),#N($78),#N$B0) in room #N$F6.
B $709D,$09,$01 Starts at (#N($88),#N($78),#N$8C) in room #N$0F.
B $70A6,$09,$01 Starts at (#N($B8),#N($B8),#N$80) in room #N$6F.
B $70AF,$09,$01 Starts at (#N($48),#N($B8),#N$A4) in room #N$FD.
B $70B8,$09,$01 Starts at (#N($78),#N($78),#N$B0) in room #N$08.
B $70C1,$09,$01 Starts at (#N($88),#N($88),#N$A4) in room #N$BB.
B $70CA,$09,$01 Starts at (#N($78),#N($78),#N$B0) in room #N$DF.
B $70D3,$09,$01 Starts at (#N($80),#N($80),#N$80) in room #N$5E.
B $70DC,$09,$01 Starts at (#N($78),#N($88),#N$B0) in room #N$B4.
B $70E5,$09,$01 Starts at (#N($78),#N($78),#N$B0) in room #N$04.
B $70EE,$09,$01 Starts at (#N($48),#N($B8),#N$80) in room #N$74.
B $70F7,$09,$01 Starts at (#N($80),#N($80),#N$80) in room #N$40.
B $7100,$09,$01 Starts at (#N($68),#N($78),#N$B0) in room #N$38.
B $7109,$09,$01 Starts at (#N($48),#N($B8),#N$98) in room #N$F0.

w $7112 Sprite Table
@ $7112 label=SpriteTable
D $7112 The address of the sprite of each of the graphic numbers #N$00 to
. #N($BB), which is found by #R$D6EF. Graphic numbers that use the same
. sprite have the same address.
W $7112,$04,$02 #N$00-#N$01: Null sprites, for an object that is not there and
. for one that is being removed.
W $7116,$02,$02 #N$02: Stone arch, near side.
W $7118,$02,$02 #N$03: Stone arch, far side.
W $711A,$02,$02 #N$04: Tree arch, near side.
W $711C,$02,$02 #N$05: Tree arch, far side.
W $711E,$02,$02 #N$06: Rock.
W $7120,$02,$02 #N$07: Block.
W $7122,$04,$02 #N$08-#N$09: Portcullis.
W $7126,$0C,$02 #N$0A-#N$0F: Wall bricks.
W $7132,$0C,$02 #N$10-#N$15: Legs of the human, facing west or north.
W $713E,$02,$02 #N$16: Gargoyle.
W $7140,$02,$02 #N$17: Spikes.
W $7142,$0C,$02 #N$18-#N$1D: Legs of the human, facing east or south.
W $714E,$04,$02 #N$1E-#N$1F: Top half of a guard that walks in a square.
W $7152,$0C,$02 #N$20-#N$25: Top half of the human, facing west or north.
W $715E,$04,$02 #N$26-#N$27: Top half of the human looking about, facing west or
. north.
W $7162,$0C,$02 #N$28-#N$2D: Top half of the human, facing east or south.
W $716E,$04,$02 #N$2E-#N$2F: Top half of the human looking about, facing east or
. south.
W $7172,$0C,$02 #N$30-#N$35: Legs of the wulf, facing west or north.
W $717E,$04,$02 #N$36-#N$37: Block, moving east and west or north and south.
W $7182,$0C,$02 #N$38-#N$3D: Legs of the wulf, facing east or south.
W $718E,$02,$02 #N$3E: Block that can be moved.
W $7190,$02,$02 #N$3F: Spiked ball.
W $7192,$0C,$02 #N$40-#N$45: Top half of the wulf, facing west or north.
W $719E,$04,$02 #N$46-#N$47: Top half of the wulf looking about, facing west or
. north.
W $71A2,$0C,$02 #N$48-#N$4D: Top half of the wulf, facing east or south.
W $71AE,$04,$02 #N$4E-#N$4F: Top half of the wulf looking about, facing east or
. south.
W $71B2,$08,$02 #N$50-#N$53: Ghost.
W $71BA,$02,$02 #N$54: Table.
W $71BC,$02,$02 #N$55: Chest.
W $71BE,$04,$02 #N$56-#N$57: Fire, moving east and west.
W $71C2,$02,$02 #N$58: Sun.
W $71C4,$02,$02 #N$59: Moon.
W $71C6,$02,$02 #N$5A: Left half of the frame of the sun and moon.
W $71C8,$02,$02 #N$5B: Block that drops.
W $71CA,$08,$02 #N$5C-#N$5F: The player changing between the human and the wulf.
W $71D2,$0E,$02 #N$60-#N$66: The special objects, in a room.
W $71E0,$02,$02 #N$67: Extra life.
W $71E2,$0E,$02 #N$68-#N$6E: The special objects, when they have been dropped
. over the cauldron.
W $71F0,$02,$02 #N$6F: Sparkle of an object that has been put in the cauldron.
W $71F2,$0E,$02 #N$70-#N$76: Sparkles of the player dying.
W $7200,$02,$02 #N$77: Last sparkle of the player dying.
W $7202,$0E,$02 #N$78-#N$7E: Sparkles of the player appearing.
W $7210,$02,$02 #N$7F: Last sparkle of the player appearing.
W $7212,$06,$02 #N$80-#N$82: Tree wall.
W $7218,$06,$02 #N$83-#N$85: Sparkles of the cauldron room when the game is
. finished.
W $721E,$02,$02 #N$86: Step of the panel.
W $7220,$02,$02 #N$87: Side of the panel.
W $7222,$02,$02 #N$88: Corner of the panel.
W $7224,$02,$02 #N$89: Corner of the border.
W $7226,$02,$02 #N$8A: Side of the border.
W $7228,$02,$02 #N$8B: Top and bottom of the border.
W $722A,$02,$02 #N$8C: Extra life, which is not used.
W $722C,$02,$02 #N$8D: Bottom half of the cauldron.
W $722E,$02,$02 #N$8E: Top half of the cauldron.
W $7230,$02,$02 #N$8F: Block that collapses.
W $7232,$0C,$02 #N$90-#N$95: Legs of a guard or the wizard, facing west or
. north.
W $723E,$04,$02 #N$96-#N$97: Top half of a guard that walks east and west.
W $7242,$0C,$02 #N$98-#N$9D: Legs of a guard or the wizard, facing east or
. south.
W $724E,$04,$02 #N$9E-#N$9F: Top half of the wizard.
W $7252,$08,$02 #N$A0-#N$A3: Bubbles of the cauldron.
W $725A,$08,$02 #N$A4-#N$A7: Spell that repels the player.
W $7262,$10,$02 #N$A8-#N$AF: The special objects and the extra life, when they
. have just been put in the cauldron.
W $7272,$04,$02 #N$B0-#N$B1: Fire, that stays where it is.
W $7276,$04,$02 #N$B2-#N$B3: Ball, that bounces up and down.
W $727A,$04,$02 #N$B4-#N$B5: Fire, moving north and south.
W $727E,$04,$02 #N$B6-#N$B7: Ball, that bounces around.
W $7282,$02,$02 #N$B8: Sparkle of the player dying.
W $7284,$02,$02 #N$B9: Sparkle of an object that has been put in the cauldron.
W $7286,$02,$02 #N$BA: Right half of the frame of the sun and moon.
W $7288,$02,$02 #N$BB: Sparkle of an object that has been put in the cauldron.

b $728A Sprite: Null Sprite
@ $728A label=Sprite_Null_Sprite
D $728A The sprite that has no width and no height, which draws nothing. The
. graphic number #N$00 is the one that an object has when it is not there, and
. #N$01 is the one that an object is given to take it away, so both of them find
. this sprite. Every sprite starts with its width in bytes, in bits 0 to 3 (bits
. 6 and 7 hold whether it has been flipped from left to right and top to bottom,
. and are changed by #R$D865 as the objects are drawn), and its height in lines.
. The pixels follow, one line at a time and from the bottom line to the top,
. with a pair of bytes for each byte of the line. The first byte of a pair is
. the mask, which has a bit set for every pixel that is cleared, and the second
. is the data, which has a bit set for every pixel that is set. The sprites are
. found from their graphic numbers by the table at #R$7112.
B $728A,$01 Width = #N(#PEEK(#PC)) bytes.
B $728B,$01 Height = #N(#PEEK(#PC)) lines.

b $728C Sprite: Sun Moon Frame
@ $728C label=Sprite_Sun_Moon_Frame_Left
D $728C The two halves of the frame of the window of the sun and the moon, in
. the panel. The left half is drawn at the left of the window and the right half
. at the right of the window.
N $728C Sun Moon Frame Left.
B $728C,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $728D,$01 Height = #N(#PEEK(#PC)) lines.
B $728E,$BA,$02 #SPRITEDATA(sun-moon-frame-left-01*)
@ $7348 label=Sprite_Sun_Moon_Frame_Right
N $7348 Sun Moon Frame Right.
B $7348,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7349,$01 Height = #N(#PEEK(#PC)) lines.
B $734A,$BA,$02 #SPRITEDATA(sun-moon-frame-right-01*)

b $7404 Sprite: Spikes
@ $7404 label=Sprite_Spikes
D $7404 The spikes, which kill the player that touches them.
B $7404,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7405,$01 Height = #N(#PEEK(#PC)) lines.
B $7406,$E0,$02 #SPRITEDATA(spikes-01*)

b $74E6 Sprite: Spiked Ball
@ $74E6 label=Sprite_Spiked_Ball
D $74E6 The spiked ball, which bounces about and kills the player that touches
. it.
B $74E6,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $74E7,$01 Height = #N(#PEEK(#PC)) lines.
B $74E8,$C8,$02 #SPRITEDATA(spiked-ball-01*)

b $75B0 Sprite: Guard Top Half
@ $75B0 label=Sprite_Guard_Top_Half_2
D $75B0 The two frames of the top half of a guard, which is the head and the
. shoulders. The guard that walks east and west uses the graphic numbers #N$96
. and #N($97), and the guard that walks in a square uses #N$1E and #N$1F. The
. bottom half is made of the legs of the human form of the player.
N $75B0 Guard Top Half frame 2.
B $75B0,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $75B1,$01 Height = #N(#PEEK(#PC)) lines.
B $75B2,$8A,$02 #SPRITEDATA(guard-top-half-02*)
@ $763C label=Sprite_Guard_Top_Half_1
N $763C Guard Top Half frame 1.
B $763C,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $763D,$01 Height = #N(#PEEK(#PC)) lines.
B $763E,$8A,$02 #SPRITEDATA(guard-top-half-01*)

b $76C8 Sprite: Ball
@ $76C8 label=Sprite_Ball_1
D $76C8 The two frames of the ball that bounces up and down, or around, which
. are the graphic numbers #N$B2 and #N$B3 for the one that bounces up and down
. and #N$B6 and #N$B7 for the one that bounces around.
N $76C8 Ball frame 1.
B $76C8,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $76C9,$01 Height = #N(#PEEK(#PC)) lines.
B $76CA,$72,$02 #SPRITEDATA(ball-01*)
@ $773C label=Sprite_Ball_2
N $773C Ball frame 2.
B $773C,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $773D,$01 Height = #N(#PEEK(#PC)) lines.
B $773E,$6C,$02 #SPRITEDATA(ball-02*)

b $77AA Sprite: Rock
@ $77AA label=Sprite_Rock
D $77AA The rock, which is used as a block that cannot be moved.
B $77AA,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $77AB,$01 Height = #N(#PEEK(#PC)) lines.
B $77AC,$E8,$02 #SPRITEDATA(rock-01*)

b $7894 Sprite: Gargoyle
@ $7894 label=Sprite_Gargoyle
D $7894 The gargoyle, which is a block with a face.
B $7894,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7895,$01 Height = #N(#PEEK(#PC)) lines.
B $7896,$90,$02 #SPRITEDATA(gargoyle-01*)

b $7926 Sprite: Fire
@ $7926 label=Sprite_Fire_1
D $7926 The two frames of the fire. The fire that moves east and west uses the
. graphic numbers #N$56 and #N($57), the one that stays where it is uses #N$B0
. and #N$B1 and the one that moves north and south uses #N$B4 and #N$B5.
N $7926 Fire frame 1.
B $7926,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7927,$01 Height = #N(#PEEK(#PC)) lines.
B $7928,$3C,$02 #SPRITEDATA(fire-01*)
@ $7964 label=Sprite_Fire_2
N $7964 Fire frame 2.
B $7964,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7965,$01 Height = #N(#PEEK(#PC)) lines.
B $7966,$40,$02 #SPRITEDATA(fire-02*)

b $79A6 Sprite: Wizard Top Half
@ $79A6 label=Sprite_Wizard_Top_Half_2
D $79A6 The two frames of the top half of the wizard, which is the graphic
. numbers #N$9E and #N$9F. The bottom half is made of the legs of the human form
. of the player.
N $79A6 Wizard Top Half frame 2.
B $79A6,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $79A7,$01 Height = #N(#PEEK(#PC)) lines.
B $79A8,$EA,$02 #SPRITEDATA(wizard-top-half-02*)
@ $7A92 label=Sprite_Wizard_Top_Half_1
N $7A92 Wizard Top Half frame 1.
B $7A92,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7A93,$01 Height = #N(#PEEK(#PC)) lines.
B $7A94,$C6,$02 #SPRITEDATA(wizard-top-half-01*)

b $7B5A Sprite: Border
@ $7B5A label=Sprite_Border_Corner
D $7B5A The three sprites that are used by #R$D296 to draw the border around the
. playing area.
N $7B5A Border Corner.
B $7B5A,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7B5B,$01 Height = #N(#PEEK(#PC)) lines.
B $7B5C,$100,$02 #SPRITEDATA(border-corner-01*)
@ $7C5C label=Sprite_Border_Side
N $7C5C Border Side.
B $7C5C,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7C5D,$01 Height = #N(#PEEK(#PC)) lines.
B $7C5E,$06,$02 #SPRITEDATA(border-side-01*)
@ $7C64 label=Sprite_Border_Top_Bottom
N $7C64 Border Top Bottom.
B $7C64,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7C65,$01 Height = #N(#PEEK(#PC)) lines.
B $7C66,$30,$02 #SPRITEDATA(border-top-bottom-01*)

b $7C96 Sprite: Panel
@ $7C96 label=Sprite_Panel_Side
D $7C96 The three sprites that are used by #R$D255 to draw the panel at the
. bottom of the screen. The step is repeated to make the diagonal edge of the
. panel.
B $7C96,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7C97,$01 Height = #N(#PEEK(#PC)) lines.
B $7C98,$100,$02 #SPRITEDATA(panel-side-01*)

u $7D98 Unused
B $7D98,$0C,$06 Zero bytes between two sprites.

b $7DA4 Sprite: Panel
@ $7DA4 label=Sprite_Panel_Corner
D $7DA4 The three sprites that are used by #R$D255 to draw the panel at the
. bottom of the screen. The step is repeated to make the diagonal edge of the
. panel.
N $7DA4 Panel Corner.
B $7DA4,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7DA5,$01 Height = #N(#PEEK(#PC)) lines.
B $7DA6,$40,$02 #SPRITEDATA(panel-corner-01*)
@ $7DE6 label=Sprite_Panel_Step
N $7DE6 Panel Step.
B $7DE6,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7DE7,$01 Height = #N(#PEEK(#PC)) lines.
B $7DE8,$20,$02 #SPRITEDATA(panel-step-01*)

b $7E08 Sprite: Block
@ $7E08 label=Sprite_Block
D $7E08 The block, which is the graphic number #N$07. The same sprite is also
. used for the blocks that move, the blocks that drop and the blocks that
. collapse, which are the graphic numbers #N($36), #N($37), #N($3E), #N$5B and
. #N$8F.
B $7E08,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7E09,$01 Height = #N(#PEEK(#PC)) lines.
B $7E0A,$E0,$02 #SPRITEDATA(block-01*)

b $7EEA Sprite: Extra Life
@ $7EEA label=Sprite_Extra_Life
D $7EEA The sprite of the extra life, which is the graphic number #N$67. It is
. also used for #N$8C and #N$AF.
B $7EEA,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7EEB,$01 Height = #N(#PEEK(#PC)) lines.
B $7EEC,$44,$02 #SPRITEDATA(extra-life-01*)

b $7F30 Sprite: Boot
@ $7F30 label=Sprite_Boot
D $7F30 The sprite of the boot, which is one of the special objects that the
. player has to take to the cauldron. The graphic numbers #N$62 and #N$6A are
. the boot in the room and when it has been dropped over the cauldron, and #N$AA
. is the boot when it has just been put in the cauldron.
B $7F30,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7F31,$01 Height = #N(#PEEK(#PC)) lines.
B $7F32,$7E,$02 #SPRITEDATA(boot-01*)

b $7FB0 Sprite: Tree Arch
@ $7FB0 label=Sprite_Tree_Arch_Near
D $7FB0 The two sprites of the arch made of trees, one for the near side of the
. room and one for the far side. They are the graphic numbers #N$04 and #N$05.
N $7FB0 Tree Arch Near.
B $7FB0,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7FB1,$01 Height = #N(#PEEK(#PC)) lines.
B $7FB2,$F0,$02 #SPRITEDATA(tree-arch-near-01*)
@ $80A2 label=Sprite_Tree_Arch_Far
N $80A2 Tree Arch Far.
B $80A2,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $80A3,$01 Height = #N(#PEEK(#PC)) lines.
B $80A4,$C0,$02 #SPRITEDATA(tree-arch-far-01*)

b $8164 Sprite: Sparkle
@ $8164 label=Sprite_Sparkle_1
D $8164 The six sprites of the sparkles, from the smallest to the biggest. The
. sparkles are used when the player appears, when the player dies, for the
. bubbles of the cauldron and for the spell that repels the player. The sparkles
. that grow are made of the graphic numbers #N$78 to #N($7E), and the ones that
. shrink of #N$70 to #N$76.
N $8164 Sparkle frame 1.
B $8164,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8165,$01 Height = #N(#PEEK(#PC)) lines.
B $8166,$78,$02 #SPRITEDATA(sparkle-01*)
@ $81DE label=Sprite_Sparkle_2
N $81DE Sparkle frame 2.
B $81DE,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $81DF,$01 Height = #N(#PEEK(#PC)) lines.
B $81E0,$7E,$02 #SPRITEDATA(sparkle-02*)
@ $825E label=Sprite_Sparkle_3
N $825E Sparkle frame 3.
B $825E,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $825F,$01 Height = #N(#PEEK(#PC)) lines.
B $8260,$8A,$02 #SPRITEDATA(sparkle-03*)
@ $82EA label=Sprite_Sparkle_4
N $82EA Sparkle frame 4.
B $82EA,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $82EB,$01 Height = #N(#PEEK(#PC)) lines.
B $82EC,$90,$02 #SPRITEDATA(sparkle-04*)
@ $837C label=Sprite_Sparkle_5
N $837C Sparkle frame 5.
B $837C,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $837D,$01 Height = #N(#PEEK(#PC)) lines.
B $837E,$90,$02 #SPRITEDATA(sparkle-05*)
@ $840E label=Sprite_Sparkle_6
N $840E Sparkle frame 6.
B $840E,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $840F,$01 Height = #N(#PEEK(#PC)) lines.
B $8410,$90,$02 #SPRITEDATA(sparkle-06*)

b $84A0 Sprite: Special Objects
@ $84A0 label=Sprite_Diamond
D $84A0 The sprites of the special objects that the player has to take to the
. cauldron, other than the boot. Each one is used by three graphic numbers:
. #N$60 to #N$66 when it is in a room, #N$68 to #N$6E when it has been dropped
. over the cauldron and #N$A8 to #N$AE when it has just been put in the
. cauldron.
N $84A0 Diamond.
B $84A0,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $84A1,$01 Height = #N(#PEEK(#PC)) lines.
B $84A2,$72,$02 #SPRITEDATA(diamond-01*)
@ $8514 label=Sprite_Poison
N $8514 Poison.
B $8514,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8515,$01 Height = #N(#PEEK(#PC)) lines.
B $8516,$84,$02 #SPRITEDATA(poison-01*)
@ $859A label=Sprite_Chalice
N $859A Chalice.
B $859A,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $859B,$01 Height = #N(#PEEK(#PC)) lines.
B $859C,$8A,$02 #SPRITEDATA(chalice-01*)
@ $8626 label=Sprite_Cup
N $8626 Cup.
B $8626,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8627,$01 Height = #N(#PEEK(#PC)) lines.
B $8628,$6C,$02 #SPRITEDATA(cup-01*)
@ $8694 label=Sprite_Bottle
N $8694 Bottle.
B $8694,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8695,$01 Height = #N(#PEEK(#PC)) lines.
B $8696,$90,$02 #SPRITEDATA(bottle-01*)
@ $8726 label=Sprite_Crystal_Ball
N $8726 Crystal Ball.
B $8726,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8727,$01 Height = #N(#PEEK(#PC)) lines.
B $8728,$7E,$02 #SPRITEDATA(crystal-ball-01*)

b $87A6 Sprite: Sun And Moon
@ $87A6 label=Sprite_Sun
D $87A6 The sun and the moon, which are shown in the window of the panel. They
. are the graphic numbers #N$58 and #N$59.
N $87A6 Sun.
B $87A6,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $87A7,$01 Height = #N(#PEEK(#PC)) lines.
B $87A8,$40,$02 #SPRITEDATA(sun-01*)
@ $87E8 label=Sprite_Moon
N $87E8 Moon.
B $87E8,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $87E9,$01 Height = #N(#PEEK(#PC)) lines.
B $87EA,$40,$02 #SPRITEDATA(moon-01*)

b $882A Sprite: Ghost
@ $882A label=Sprite_Ghost_1
D $882A The four frames of the ghost, which are the graphic numbers #N$50 to
. #N$53.
N $882A Ghost frame 1.
B $882A,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $882B,$01 Height = #N(#PEEK(#PC)) lines.
B $882C,$78,$02 #SPRITEDATA(ghost-01*)
@ $88A4 label=Sprite_Ghost_2
N $88A4 Ghost frame 2.
B $88A4,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $88A5,$01 Height = #N(#PEEK(#PC)) lines.
B $88A6,$72,$02 #SPRITEDATA(ghost-02*)
@ $8918 label=Sprite_Ghost_3
N $8918 Ghost frame 3.
B $8918,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8919,$01 Height = #N(#PEEK(#PC)) lines.
B $891A,$78,$02 #SPRITEDATA(ghost-03*)
@ $8992 label=Sprite_Ghost_4
N $8992 Ghost frame 4.
B $8992,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8993,$01 Height = #N(#PEEK(#PC)) lines.
B $8994,$78,$02 #SPRITEDATA(ghost-04*)

b $8A0C Sprite: Portcullis
@ $8A0C label=Sprite_Portcullis
D $8A0C The portcullis, which is the graphic numbers #N$08 and #N$09. The first
. is the one that is drawn in a room and the second is the one that is used by
. the portcullis when it moves.
B $8A0C,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8A0D,$01 Height = #N(#PEEK(#PC)) lines.
B $8A0E,$FC,$02 #SPRITEDATA(portcullis-01*)

b $8B0A Sprite: Chest
@ $8B0A label=Sprite_Chest
D $8B0A The chest, which is the graphic number #N$55.
B $8B0A,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8B0B,$01 Height = #N(#PEEK(#PC)) lines.
B $8B0C,$E8,$02 #SPRITEDATA(chest-01*)

b $8BF4 Sprite: Table
@ $8BF4 label=Sprite_Table
D $8BF4 The table, which is the graphic number #N$54.
B $8BF4,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8BF5,$01 Height = #N(#PEEK(#PC)) lines.
B $8BF6,$F8,$02 #SPRITEDATA(table-01*)

b $8CEE Sprite: Human Top Halves
@ $8CEE label=Sprite_Human_Top_West_3
D $8CEE The sprites of the top half of the human form of the player. The graphic
. numbers #N$20 to #N$25 are the frames of the top half walking, facing west (or
. north if it is flipped), #N$26 and #N$27 are the head looking about when it
. faces west, #N$28 to #N$2D are the frames walking and facing east (or south),
. and #N$2E and #N$2F are the head looking about when it faces east.
N $8CEE Human Top West frame 3.
B $8CEE,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8CEF,$01 Height = #N(#PEEK(#PC)) lines.
B $8CF0,$90,$02 #SPRITEDATA(human-top-west-03*)
@ $8D80 label=Sprite_Human_Top_East_2
N $8D80 Human Top East frame 2.
B $8D80,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8D81,$01 Height = #N(#PEEK(#PC)) lines.
B $8D82,$96,$02 #SPRITEDATA(human-top-east-02*)
@ $8E18 label=Sprite_Human_Top_Looking_West_1
N $8E18 Human Top Looking West frame 1.
B $8E18,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8E19,$01 Height = #N(#PEEK(#PC)) lines.
B $8E1A,$96,$02 #SPRITEDATA(human-top-looking-west-01*)
@ $8EB0 label=Sprite_Human_Top_West_4
N $8EB0 Human Top West frame 4.
B $8EB0,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8EB1,$01 Height = #N(#PEEK(#PC)) lines.
B $8EB2,$90,$02 #SPRITEDATA(human-top-west-04*)
@ $8F42 label=Sprite_Human_Top_West_1
N $8F42 Human Top West frame 1.
B $8F42,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8F43,$01 Height = #N(#PEEK(#PC)) lines.
B $8F44,$90,$02 #SPRITEDATA(human-top-west-01*)
@ $8FD4 label=Sprite_Human_Top_West_2
N $8FD4 Human Top West frame 2.
B $8FD4,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8FD5,$01 Height = #N(#PEEK(#PC)) lines.
B $8FD6,$90,$02 #SPRITEDATA(human-top-west-02*)
@ $9066 label=Sprite_Human_Top_East_1
N $9066 Human Top East frame 1.
B $9066,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9067,$01 Height = #N(#PEEK(#PC)) lines.
B $9068,$96,$02 #SPRITEDATA(human-top-east-01*)
@ $90FE label=Sprite_Human_Top_East_4
N $90FE Human Top East frame 4.
B $90FE,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $90FF,$01 Height = #N(#PEEK(#PC)) lines.
B $9100,$96,$02 #SPRITEDATA(human-top-east-04*)
@ $9196 label=Sprite_Human_Top_East_3
N $9196 Human Top East frame 3.
B $9196,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9197,$01 Height = #N(#PEEK(#PC)) lines.
B $9198,$96,$02 #SPRITEDATA(human-top-east-03*)

b $922E Sprite: Human Legs
@ $922E label=Sprite_Human_Legs_West_1
D $922E The sprites of the legs of the human form of the player, which are also
. the bottom half of a guard and of the wizard. The graphic numbers #N$10 to
. #N$15 are the six frames of the legs walking when facing west (or north if
. flipped from left to right), and #N$18 to #N$1D are the frames when facing
. east (or south). The frames are in the order 1, 2, 3, 4, 3 and 2, so that the
. sprites are used more than once. The guard and the wizard use the graphic
. numbers #N$90 to #N$95 and #N$98 to #N$9D.
N $922E Human Legs West frame 1.
B $922E,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $922F,$01 Height = #N(#PEEK(#PC)) lines.
B $9230,$60,$02 #SPRITEDATA(human-legs-west-01*)
@ $9290 label=Sprite_Human_Legs_West_2
N $9290 Human Legs West frame 2.
B $9290,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9291,$01 Height = #N(#PEEK(#PC)) lines.
B $9292,$60,$02 #SPRITEDATA(human-legs-west-02*)
@ $92F2 label=Sprite_Human_Legs_West_3
N $92F2 Human Legs West frame 3.
B $92F2,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $92F3,$01 Height = #N(#PEEK(#PC)) lines.
B $92F4,$60,$02 #SPRITEDATA(human-legs-west-03*)
@ $9354 label=Sprite_Human_Legs_West_4
N $9354 Human Legs West frame 4.
B $9354,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9355,$01 Height = #N(#PEEK(#PC)) lines.
B $9356,$60,$02 #SPRITEDATA(human-legs-west-04*)
@ $93B6 label=Sprite_Human_Legs_East_1
N $93B6 Human Legs East frame 1.
B $93B6,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $93B7,$01 Height = #N(#PEEK(#PC)) lines.
B $93B8,$60,$02 #SPRITEDATA(human-legs-east-01*)
@ $9418 label=Sprite_Human_Legs_East_2
N $9418 Human Legs East frame 2.
B $9418,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9419,$01 Height = #N(#PEEK(#PC)) lines.
B $941A,$60,$02 #SPRITEDATA(human-legs-east-02*)
@ $947A label=Sprite_Human_Legs_East_3
N $947A Human Legs East frame 3.
B $947A,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $947B,$01 Height = #N(#PEEK(#PC)) lines.
B $947C,$60,$02 #SPRITEDATA(human-legs-east-03*)
@ $94DC label=Sprite_Human_Legs_East_4
N $94DC Human Legs East frame 4.
B $94DC,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $94DD,$01 Height = #N(#PEEK(#PC)) lines.
B $94DE,$60,$02 #SPRITEDATA(human-legs-east-04*)

b $953E Sprite: Human Top Halves
@ $953E label=Sprite_Human_Top_Looking_West_2
D $953E The sprites of the top half of the human form of the player. The graphic
. numbers #N$20 to #N$25 are the frames of the top half walking, facing west (or
. north if it is flipped), #N$26 and #N$27 are the head looking about when it
. faces west, #N$28 to #N$2D are the frames walking and facing east (or south),
. and #N$2E and #N$2F are the head looking about when it faces east.
N $953E Human Top Looking West frame 2.
B $953E,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $953F,$01 Height = #N(#PEEK(#PC)) lines.
B $9540,$90,$02 #SPRITEDATA(human-top-looking-west-02*)
@ $95D0 label=Sprite_Human_Top_Looking_East_2
N $95D0 Human Top Looking East frame 2.
B $95D0,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $95D1,$01 Height = #N(#PEEK(#PC)) lines.
B $95D2,$96,$02 #SPRITEDATA(human-top-looking-east-02*)
@ $9668 label=Sprite_Human_Top_Looking_East_1
N $9668 Human Top Looking East frame 1.
B $9668,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9669,$01 Height = #N(#PEEK(#PC)) lines.
B $966A,$96,$02 #SPRITEDATA(human-top-looking-east-01*)

b $9700 Sprite: Tree Wall
@ $9700 label=Sprite_Tree_Wall_1
D $9700 The three sprites of the wall of trees, which are the graphic numbers
. #N$80 to #N$82.
N $9700 Tree Wall frame 1.
B $9700,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9701,$01 Height = #N(#PEEK(#PC)) lines.
B $9702,$C0,$02 #SPRITEDATA(tree-wall-01*)
@ $97C2 label=Sprite_Tree_Wall_2
N $97C2 Tree Wall frame 2.
B $97C2,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $97C3,$01 Height = #N(#PEEK(#PC)) lines.
B $97C4,$C0,$02 #SPRITEDATA(tree-wall-02*)
@ $9884 label=Sprite_Tree_Wall_3
N $9884 Tree Wall frame 3.
B $9884,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9885,$01 Height = #N(#PEEK(#PC)) lines.
B $9886,$C0,$02 #SPRITEDATA(tree-wall-03*)

b $9946 Sprite: Wall Bricks
@ $9946 label=Sprite_Wall_Bricks_4
D $9946 The six sprites of the bricks that make up the walls of the room, which
. are the graphic numbers #N$0A to #N$0F.
N $9946 Wall Bricks frame 4.
B $9946,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9947,$01 Height = #N(#PEEK(#PC)) lines.
B $9948,$C0,$02 #SPRITEDATA(wall-bricks-04*)
@ $9A08 label=Sprite_Wall_Bricks_5
N $9A08 Wall Bricks frame 5.
B $9A08,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9A09,$01 Height = #N(#PEEK(#PC)) lines.
B $9A0A,$C0,$02 #SPRITEDATA(wall-bricks-05*)

b $9ACA Sprite: Stone Arch
@ $9ACA label=Sprite_Stone_Arch_Near
D $9ACA The two sprites of the arch made of stone, one for the near side of the
. room and one for the far side. They are the graphic numbers #N$02 and #N$03.
N $9ACA Stone Arch Near.
B $9ACA,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9ACB,$01 Height = #N(#PEEK(#PC)) lines.
B $9ACC,$138,$02 #SPRITEDATA(stone-arch-near-01*)
@ $9C04 label=Sprite_Stone_Arch_Far
N $9C04 Stone Arch Far.
B $9C04,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9C05,$01 Height = #N(#PEEK(#PC)) lines.
B $9C06,$8C,$02 #SPRITEDATA(stone-arch-far-01*)

b $9C92 Sprite: Wall Bricks
@ $9C92 label=Sprite_Wall_Bricks_6
D $9C92 The six sprites of the bricks that make up the walls of the room, which
. are the graphic numbers #N$0A to #N$0F.
B $9C92,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9C93,$01 Height = #N(#PEEK(#PC)) lines.
B $9C94,$C0,$02 #SPRITEDATA(wall-bricks-06*)

b $9D54 Sprite: Cauldron
@ $9D54 label=Sprite_Cauldron_Bottom
D $9D54 The two sprites of the cauldron, with the bottom half first. They are
. the graphic numbers #N$8D and #N$8E.
N $9D54 Cauldron Bottom.
B $9D54,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9D55,$01 Height = #N(#PEEK(#PC)) lines.
B $9D56,$108,$02 #SPRITEDATA(cauldron-bottom-01*)
@ $9E5E label=Sprite_Cauldron_Top
N $9E5E Cauldron Top.
B $9E5E,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9E5F,$01 Height = #N(#PEEK(#PC)) lines.
B $9E60,$58,$02 #SPRITEDATA(cauldron-top-01*)

b $9EB8 Sprite: Wall Bricks
@ $9EB8 label=Sprite_Wall_Bricks_1
D $9EB8 The six sprites of the bricks that make up the walls of the room, which
. are the graphic numbers #N$0A to #N$0F.
N $9EB8 Wall Bricks frame 1.
B $9EB8,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9EB9,$01 Height = #N(#PEEK(#PC)) lines.
B $9EBA,$FA,$02 #SPRITEDATA(wall-bricks-01*)
@ $9FB4 label=Sprite_Wall_Bricks_2
N $9FB4 Wall Bricks frame 2.
B $9FB4,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9FB5,$01 Height = #N(#PEEK(#PC)) lines.
B $9FB6,$90,$02 #SPRITEDATA(wall-bricks-02*)
@ $A046 label=Sprite_Wall_Bricks_3
N $A046 Wall Bricks frame 3.
B $A046,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A047,$01 Height = #N(#PEEK(#PC)) lines.
B $A048,$6C,$02 #SPRITEDATA(wall-bricks-03*)

b $A0B4 Sprite: Wulf Legs
@ $A0B4 label=Sprite_Wulf_Legs_West_1
D $A0B4 The sprites of the legs of the wulf form of the player. The graphic
. numbers #N$30 to #N$35 are the six frames of the legs walking when facing west
. (or north if flipped from left to right), and #N$38 to #N$3D are the frames
. when facing east (or south). The frames are in the order 1, 2, 3, 4, 3 and 2,
. so that the sprites are used more than once.
N $A0B4 Wulf Legs West frame 1.
B $A0B4,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A0B5,$01 Height = #N(#PEEK(#PC)) lines.
B $A0B6,$60,$02 #SPRITEDATA(wulf-legs-west-01*)
@ $A116 label=Sprite_Wulf_Legs_West_2
N $A116 Wulf Legs West frame 2.
B $A116,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A117,$01 Height = #N(#PEEK(#PC)) lines.
B $A118,$60,$02 #SPRITEDATA(wulf-legs-west-02*)
@ $A178 label=Sprite_Wulf_Legs_West_3
N $A178 Wulf Legs West frame 3.
B $A178,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A179,$01 Height = #N(#PEEK(#PC)) lines.
B $A17A,$60,$02 #SPRITEDATA(wulf-legs-west-03*)
@ $A1DA label=Sprite_Wulf_Legs_West_4
N $A1DA Wulf Legs West frame 4.
B $A1DA,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A1DB,$01 Height = #N(#PEEK(#PC)) lines.
B $A1DC,$60,$02 #SPRITEDATA(wulf-legs-west-04*)
@ $A23C label=Sprite_Wulf_Legs_East_1
N $A23C Wulf Legs East frame 1.
B $A23C,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A23D,$01 Height = #N(#PEEK(#PC)) lines.
B $A23E,$60,$02 #SPRITEDATA(wulf-legs-east-01*)
@ $A29E label=Sprite_Wulf_Legs_East_2
N $A29E Wulf Legs East frame 2.
B $A29E,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A29F,$01 Height = #N(#PEEK(#PC)) lines.
B $A2A0,$60,$02 #SPRITEDATA(wulf-legs-east-02*)
@ $A300 label=Sprite_Wulf_Legs_East_3
N $A300 Wulf Legs East frame 3.
B $A300,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A301,$01 Height = #N(#PEEK(#PC)) lines.
B $A302,$60,$02 #SPRITEDATA(wulf-legs-east-03*)
@ $A362 label=Sprite_Wulf_Legs_East_4
N $A362 Wulf Legs East frame 4.
B $A362,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A363,$01 Height = #N(#PEEK(#PC)) lines.
B $A364,$60,$02 #SPRITEDATA(wulf-legs-east-04*)

b $A3C4 Sprite: Wulf Top Halves
@ $A3C4 label=Sprite_Wulf_Top_West_1
D $A3C4 The sprites of the top half of the wulf form of the player. The graphic
. numbers #N$40 to #N$45 are the frames of the top half walking, facing west (or
. north if it is flipped), #N$46 and #N$47 are the head looking about when it
. faces west, #N$48 to #N$4D are the frames walking and facing east (or south),
. and #N$4E and #N$4F are the head looking about when it faces east.
N $A3C4 Wulf Top West frame 1.
B $A3C4,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A3C5,$01 Height = #N(#PEEK(#PC)) lines.
B $A3C6,$AE,$02 #SPRITEDATA(wulf-top-west-01*)
@ $A474 label=Sprite_Wulf_Top_West_2
N $A474 Wulf Top West frame 2.
B $A474,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A475,$01 Height = #N(#PEEK(#PC)) lines.
B $A476,$AE,$02 #SPRITEDATA(wulf-top-west-02*)
@ $A524 label=Sprite_Wulf_Top_West_3
N $A524 Wulf Top West frame 3.
B $A524,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A525,$01 Height = #N(#PEEK(#PC)) lines.
B $A526,$AE,$02 #SPRITEDATA(wulf-top-west-03*)
@ $A5D4 label=Sprite_Wulf_Top_West_4
N $A5D4 Wulf Top West frame 4.
B $A5D4,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A5D5,$01 Height = #N(#PEEK(#PC)) lines.
B $A5D6,$AE,$02 #SPRITEDATA(wulf-top-west-04*)
@ $A684 label=Sprite_Wulf_Top_East_4
N $A684 Wulf Top East frame 4.
B $A684,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A685,$01 Height = #N(#PEEK(#PC)) lines.
B $A686,$B4,$02 #SPRITEDATA(wulf-top-east-04*)
@ $A73A label=Sprite_Wulf_Top_East_3
N $A73A Wulf Top East frame 3.
B $A73A,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A73B,$01 Height = #N(#PEEK(#PC)) lines.
B $A73C,$B4,$02 #SPRITEDATA(wulf-top-east-03*)
@ $A7F0 label=Sprite_Wulf_Top_East_2
N $A7F0 Wulf Top East frame 2.
B $A7F0,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A7F1,$01 Height = #N(#PEEK(#PC)) lines.
B $A7F2,$B4,$02 #SPRITEDATA(wulf-top-east-02*)
@ $A8A6 label=Sprite_Wulf_Top_East_1
N $A8A6 Wulf Top East frame 1.
B $A8A6,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A8A7,$01 Height = #N(#PEEK(#PC)) lines.
B $A8A8,$B4,$02 #SPRITEDATA(wulf-top-east-01*)
@ $A95C label=Sprite_Wulf_Top_Looking_West_1
N $A95C Wulf Top Looking West frame 1.
B $A95C,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A95D,$01 Height = #N(#PEEK(#PC)) lines.
B $A95E,$AE,$02 #SPRITEDATA(wulf-top-looking-west-01*)
@ $AA0C label=Sprite_Wulf_Top_Looking_West_2
N $AA0C Wulf Top Looking West frame 2.
B $AA0C,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $AA0D,$01 Height = #N(#PEEK(#PC)) lines.
B $AA0E,$AE,$02 #SPRITEDATA(wulf-top-looking-west-02*)
@ $AABC label=Sprite_Wulf_Top_Looking_East_1
N $AABC Wulf Top Looking East frame 1.
B $AABC,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $AABD,$01 Height = #N(#PEEK(#PC)) lines.
B $AABE,$B4,$02 #SPRITEDATA(wulf-top-looking-east-01*)
@ $AB72 label=Sprite_Wulf_Top_Looking_East_2
N $AB72 Wulf Top Looking East frame 2.
B $AB72,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $AB73,$01 Height = #N(#PEEK(#PC)) lines.
B $AB74,$B4,$02 #SPRITEDATA(wulf-top-looking-east-02*)

b $AC28 Sprite: Transformation
@ $AC28 label=Sprite_Transformation_1
D $AC28 The four sprites that are shown when the player changes between the
. human and wulf forms, which are the graphic numbers #N$5C to #N$5F.
N $AC28 Transformation frame 1.
B $AC28,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $AC29,$01 Height = #N(#PEEK(#PC)) lines.
B $AC2A,$C0,$02 #SPRITEDATA(transformation-01*)
@ $ACEA label=Sprite_Transformation_2
N $ACEA Transformation frame 2.
B $ACEA,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $ACEB,$01 Height = #N(#PEEK(#PC)) lines.
B $ACEC,$C6,$02 #SPRITEDATA(transformation-02*)
@ $ADB2 label=Sprite_Transformation_3
N $ADB2 Transformation frame 3.
B $ADB2,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $ADB3,$01 Height = #N(#PEEK(#PC)) lines.
B $ADB4,$E4,$02 #SPRITEDATA(transformation-03*)
@ $AE98 label=Sprite_Transformation_4
N $AE98 Transformation frame 4.
B $AE98,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $AE99,$01 Height = #N(#PEEK(#PC)) lines.
B $AE9A,$D2,$02 #SPRITEDATA(transformation-04*)

c $AF6C Start Game
@ $AF6C label=StartGame
D $AF6C Clears the whole game variables area (from #R$5BA0 up to the end of the
. objects table at #R$6108) and then carries on to set up a new game. The low
. byte of the system FRAMES counter is kept across the clear and used as the
. first random seed, so that every game plays differently.
E $AF6C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$A631 }
. LIST#
N $AF6C Clear the variables and keep the seed.
  $AF6C,$03 Point #REGhl at #R$5BA0.
  $AF6F,$03 Set the number of bytes to #N$0568.
  $AF72,$03 Fetch the low byte of #SKOOLKID$5C78(FRAMES).
  $AF75,$01 Stash the seed on the stack.
  $AF76,$03 Call #R$D53A.
  $AF79,$01 Restore the seed from the stack.
  $AF7A,$03 Write it to #R$5BA0.
  $AF7D,$02 Jump to #R$AF88.

c $AF7F Restart Game
@ $AF7F label=RestartGame
D $AF7F Clears the variables that belong to a single game, leaving the random
. seeds and the chosen control method alone. This is used to go back to the
. game selection menu after a game has finished.
E $AF7F Continue on to #R$AF88.
N $AF7F Clear the variables of the last game.
  $AF7F,$03 Point #REGhl at #R$5BA8.
  $AF82,$03 Set the number of bytes to #N$0560.
  $AF85,$03 Call #R$D53A.

c $AF88 Initialise Game
@ $AF88 label=InitialiseGame
D $AF88 Sets up everything needed to start a new game: builds the lookup tables,
. gives the player five lives, lets the player choose the control method on the
. menu, plays the start tune and then picks the random start location of the
. player and of the special objects.
E $AF88 Continue on to #R$AFB7.
N $AF88 Build the tables and set the starting state.
  $AF88,$03 Call #R$D69E.
  $AF8B,$04 Write #N$00 to #R$5BB2.
  $AF8F,$03 Write #N$00 to the counter and flags byte of the player copy
. at #R$D161(#N$D16D).
  $AF92,$05 Set #R$5BBA to #N$05.
N $AF97 Stir #R$5BA0 with #R$5BA2.
  $AF97,$03 Point #REGhl at #R$5BA0.
  $AF9A,$03 Fetch the low byte of #R$5BA2.
  $AF9D,$02 Add it to #R$5BA0.
N $AF9F Show the menu and wait for the player to start.
  $AF9F,$03 Call #R$D55F.
  $AFA2,$03 Call #R$BD0C.
N $AFA5 #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune)))
  $AFA5,$03 Point #REGde at #R$B20E.
  $AFA8,$03 Call #R$B2CF.
N $AFAB Place the player and set up the rooms.
  $AFAB,$03 Call #R$B544.
  $AFAE,$03 Call #R$D1B1.
  $AFB1,$03 Call #R$C46D.
  $AFB4,$03 Call #R$C47E.

c $AFB7 Start Life
@ $AFB7 label=StartLife
D $AFB7 Starts a new life: puts the player objects back into the objects table
. and takes a life off the total. If the player has none left the game is over.
E $AFB7 Continue on to #R$AFBA.
E $AFB7 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$A688 }
. LIST#
  $AFB7,$03 Restore the player objects, take a life off and choose the player's
. graphics.

c $AFBA Run Game
@ $AFBA label=RunGame
D $AFBA The main game loop. The first call builds the objects of the room the
. player is in. Then every pass of the loop visits each of the #N$28 objects in
. the objects table in turn, calling the routine for its graphic number from the
. jump table at #R$B096 to move and update it. Once every object has been dealt
. with the objects are sorted and drawn, the screen is brought up to date and
. the game waits a little (the more objects in view, the shorter the wait)
. before the next pass.
.
. #PUSHS #UDGTABLE { =h After the first pass }
. { #SIM(start=$AF6C,stop=$AFA2,sp=$5BA0,clear=1)
. #SIM(start=$BD0C,stop=$BD23)
. #SIM(start=$AFAB,stop=$B02F,sp=$5BA0)
. #SIM(start=$B03F,stop=$B06E)
. #SIM(start=$D56F,stop=$0000,sp=$5B80)
. #SCR$02(run-game) } UDGTABLE# #POPS
E $AFBA View the equivalent code in;
. #LIST
. { #ALIENEIGHT$A68B }
. LIST#
  $AFBA,$03 Build the objects for the room the player is in.
@ $AFBD label=RunGame_Frame
N $AFBD Every pass of the main loop starts here. The random seed used by the
. fire is refreshed, then each object in the table is updated in turn.
  $AFBD,$03 Fetch the frame counter from #R$5BA2.
  $AFC0,$03 Store it as the seed for the fire at #R$5BBC (it is stepped for
. every object).
  $AFC3,$04 Point #REGix at #R$5C08.
@ $AFC7 label=RunGame_NextObject
N $AFC7 Update the object that #REGix points at.
  $AFC7,$03 Reset the stack pointer to #R$5BA0, as the update routines do not
. have to tidy up the stack.
  $AFCA,$03 Point #REGhl at #R$5BBC.
  $AFCD,$01 Step the fire seed on.
  $AFCE,$03 Point #REGhl at #R$AFE4.
  $AFD1,$01 Stash it on the stack, so that the update routine returns there.
  $AFD2,$03 Work out the screen position and size of the object, and keep a note
. of its old ones.
@ $AFD5 label=RunGame_UpdateObject
  $AFD5,$03 Fetch the graphic number of the object into #REGl.
  $AFD8,$03 Point #REGbc at #R$B096.
@ $AFDB label=RunGame_JumpToHandler
N $AFDB Jump to the routine whose address is held in word #REGl of the table
. that #REGbc points at (#REGh is cleared first).
  $AFDB,$02 Clear #REGh, so that #REGhl holds the graphic number.
  $AFDD,$01 Double it to get the offset of a word in the table.
  $AFDE,$01 Add the address of the table.
  $AFDF,$01 Read the low byte of the routine address.
  $AFE0,$01 Move on to the high byte.
  $AFE1,$01 Read the high byte into #REGh.
  $AFE2,$01 Put the low byte into #REGl.
  $AFE3,$01 Jump to the update routine.
@ $AFE4 label=RunGame_ObjectUpdated
N $AFE4 The update routine of each object returns here.
  $AFE4,$02 Read the refresh register, which is as good as random.
  $AFE6,$01 Move it into #REGc.
  $AFE7,$03 Fetch the second random seed from #R$5BA5.
  $AFEA,$01 Add the random value to it.
  $AFEB,$03 Store it back as the new second seed at #R$5BA5.
  $AFEE,$03 Set #REGbc to the size of an object.
  $AFF1,$02 Move #REGix on to the next object.
  $AFF3,$03 Copy #REGix to #REGhl (using the stack).
  $AFF6,$03 Set #REGbc to the address just beyond the objects table, #R$6108.
  $AFF9,$03 Subtract it from #REGhl, to see if #REGix is past the end of the
. table.
  $AFFC,$02 Jump to #R$B000 if every object has been updated.
  $AFFE,$02 Jump to #R$AFC7 for the next object.
@ $B000 label=RunGame_FinishFrame
N $B000 Every object has been updated; now finish the frame.
  $B000,$03 Fetch the frame counter from #R$5BA2.
  $B003,$01 Increase it.
  $B004,$03 Store it again at #R$5BA2.
  $B007,$03 Fetch the second random seed from #R$5BA5.
  $B00A,$03 Add the byte of the ROM that the frame counter points at, and the
. frame counter itself, to it.
  $B00D,$03 Store it as the new second seed at #R$5BA5.
  $B010,$03 Point #REGhl at #R$5BB2.
  $B013,$02 Set bit 0, so that the special objects table gets updated the next
. time round.
  $B015,$03 Check for the pause key.
  $B018,$03 Create the bubbles of the cauldron if the player is in the cauldron
. room.
  $B01B,$03 Make a list of the objects that need to be drawn.
  $B01E,$03 Draw the objects of the list into the screen buffer.
  $B021,$03 Fetch the rising blocks flag from #R$5BC5.
  $B024,$01 Test it.
  $B025,$03 Play the sound of rising blocks if there are any.
N $B028 Slow the game down when few objects were drawn this frame: the delay is
. made up of as many short delay loops as the number of objects drawn is below
. #N$06.
  $B028,$03 Fetch the number of objects that were drawn from #R$5BBE.
  $B02B,$02 Negate it.
  $B02D,$02 Add #N$06 to it, to get the number of delay loops.
  $B02F,$01 Copy it into #REGb.
  $B030,$03 Jump to #R$B03F if it is negative (more than #N$06 objects were
. drawn).
  $B033,$02 Jump to #R$B03F if it is zero.
@ $B035 label=RunGame_Delay
  $B035,$03 Set #REGhl to the number of times to count down for each delay loop.
@ $B038 label=RunGame_DelayLoop
  $B038,$01 Decrement the counter.
  $B039,$02 Check whether the counter has reached zero.
  $B03B,$02 Jump to #R$B038 until the counter is zero.
  $B03D,$02 Jump to #R$B035 until all of the delay loops are done.
@ $B03F label=RunGame_UpdateDisplay
N $B03F If a new room has just been entered, draw the panel and the scenery.
  $B03F,$03 Fetch the flag which says that the room has just been drawn from
. #R$5BB7.
  $B042,$03 Jump to #R$B074 if it is zero.
  $B045,$04 Reset the flag at #R$5BB7.
  $B049,$03 Fetch the attribute of the room from #R$5BAD.
  $B04C,$03 Colour the whole screen with it.
  $B04F,$03 Draw the objects the player is carrying.
  $B052,$03 Colour the panel.
  $B055,$03 Colour the sun and moon window.
  $B058,$03 Draw the panel.
  $B05B,$04 Point #REGix at #R$C44D.
  $B05F,$03 Draw the sun or moon.
  $B062,$03 Draw the day number.
  $B065,$03 Draw the number of days.
  $B068,$03 Draw the lives graphics.
  $B06B,$03 Print the number of lives.
  $B06E,$03 Copy the screen buffer to the display.
  $B071,$03 Reset the wipe flag of all of the objects.
@ $B074 label=RunGame_Continue
N $B074 Start another frame, or lose a life if the player is gone.
  $B074,$04 Write #N$00 to *#R$5BC5 (the rising blocks flag).
  $B078,$04 Point #REGix at #R$5C08.
  $B07C,$03 Fetch the graphic number of the bottom half of the player.
  $B07F,$03 Combine it with the graphic number of the top half of the player.
  $B082,$03 Jump to #R$AFB7 if neither half is present, as the player has been
. killed.
  $B085,$03 Jump to #R$AFBD for another pass of the game loop.

c $B088 Reset Wipe Flags
@ $B088 label=ResetWipeFlags
D $B088 Clears the wipe flag (bit 5 of the flags byte) of every object in the
. objects table, now that the whole screen has been redrawn.
E $B088 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$A7DC }
. { #PENTAGRAM$BF0D }
. LIST#
  $B088,$02 Set #REGb to the number of objects in the table.
  $B08A,$03 Set #REGde to the size of an object.
  $B08D,$03 Point #REGhl at the flags byte of the first object.
@ $B090 label=ResetWipeFlags_Loop
  $B090,$02 Reset the wipe flag of the object.
  $B092,$01 Move on to the flags byte of the next object.
  $B093,$02 Decrease the object counter and loop back to #R$B090 until all of
. the objects have been done.
  $B095,$01 Return.

w $B096 Update Routine Table
@ $B096 label=UpdateRoutineTable
D $B096 One routine address for each of the graphic numbers #N$00 to #N$BB that
. an object in the objects table can have. #R$AFDB jumps to the entry for the
. object being updated.
W $B096,$04,$02 Graphic numbers #N$00 and #N$01 have nothing to update.
W $B09A,$02,$02 Stone arch, near side.
W $B09C,$02,$02 Stone arch, far side.
W $B09E,$02,$02 Tree arch, near side.
W $B0A0,$02,$02 Tree arch, far side.
W $B0A2,$04,$02 Rock and block.
W $B0A6,$02,$02 Portcullis, stationary.
W $B0A8,$02,$02 Portcullis, moving.
W $B0AA,$02,$02 Bricks.
W $B0AC,$02,$02 More bricks.
W $B0AE,$08,$02 Even more bricks.
W $B0B6,$0C,$02 Legs of the human form of the player.
W $B0C2,$02,$02 Gargoyle.
W $B0C4,$02,$02 Spikes.
W $B0C6,$0C,$02 More legs of the human form of the player.
W $B0D2,$04,$02 Top half of a moving guard.
W $B0D6,$20,$02 Top half of the human form of the player.
W $B0F6,$0C,$02 Legs of the wulf form of the player.
W $B102,$02,$02 Block, moving east and west.
W $B104,$02,$02 Block, moving north and south.
W $B106,$0C,$02 More legs of the wulf form of the player.
W $B112,$02,$02 Block.
W $B114,$02,$02 Spiked ball.
W $B116,$20,$02 Top half of the wulf form of the player.
W $B136,$08,$02 Ghost.
W $B13E,$02,$02 Table.
W $B140,$02,$02 Chest.
W $B142,$04,$02 Fire, moving east and west.
W $B146,$06,$02 Sun, moon and the frame of the sun and moon window.
W $B14C,$02,$02 Block, dropping.
W $B14E,$08,$02 The player changing between the human and wulf forms.
W $B156,$0E,$02 The seven special objects as they are found in the rooms.
W $B164,$02,$02 Extra life.
W $B166,$0E,$02 The seven special objects as they are carried by the player and
. thrown into the cauldron.
W $B174,$02,$02 Final sparkles in the cauldron.
W $B176,$0E,$02 Sparkles shown when the player dies.
W $B184,$02,$02 Last of the death sparkles.
W $B186,$0E,$02 Sparkles shown when the player appears.
W $B194,$02,$02 Last of the sparkles of the player appearing.
W $B196,$06,$02 Tree wall.
W $B19C,$06,$02 Sparkles of the cauldron room at the end of the game.
W $B1A2,$0E,$02 Unused graphic numbers, with nothing to update.
W $B1B0,$02,$02 Cauldron, bottom half.
W $B1B2,$02,$02 Cauldron, top half.
W $B1B4,$02,$02 Block, collapsing.
W $B1B6,$0C,$02 Bottom half of a guard or the wizard.
W $B1C2,$04,$02 Top half of a guard, moving east and west.
W $B1C6,$0C,$02 More bottom halves of a guard or the wizard.
W $B1D2,$04,$02 Top half of the wizard.
W $B1D6,$08,$02 Bubbles of the cauldron.
W $B1DE,$08,$02 Spell that repels the player.
W $B1E6,$10,$02 The special objects, when first put into the cauldron.
W $B1F6,$04,$02 Fire, stationary (not used in the game).
W $B1FA,$04,$02 Ball, bouncing up and down.
W $B1FE,$04,$02 Fire, moving north and south.
W $B202,$04,$02 Ball, bouncing around.
W $B206,$02,$02 Sparkles shown when the player dies.
W $B208,$02,$02 Last sparkle of an object in the cauldron.
W $B20A,$02,$02 Unused graphic number, with nothing to update.
W $B20C,$02,$02 Last sparkle of an object in the cauldron.

b $B20E Start Game Tune
@ $B20E label=StartGameTune
D $B20E The tune played just before a new game starts. Each byte holds a note in
. bits 0-5 (the index of a note in #R$B332, where #N$00 is a rest) and the
. length of the note in bits 6-7 (#N$00 to #N$03 for one to four times the basic
. length of the note). The tune ends with #N$FF. #R$B2CF plays it.
.
. #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune)))
B $B20E,$0A,$05

b $B218 Game Over Tune
@ $B218 label=GameOverTune
D $B218 The tune played when the game is over, in the same note format as
. #R$B20E.
.
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
B $B218,$21,$08

b $B239 Game Complete Tune
@ $B239 label=GameCompleteTune
D $B239 The tune played when the player has completed the game, in the same note
. format as #R$B20E.
.
. #HTML(#AUDIO0(game-complete-tune.wav)(#INCLUDE(GameCompleteTune)))
B $B239,$1A,$08

b $B253 Menu Tune
@ $B253 label=MenuTune
D $B253 The tune that plays while the game selection menu is shown, in the same
. note format as #R$B20E.
.
. #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune)))
B $B253,$63,$08

c $B2B6 Play Music Once
@ $B2B6 label=PlayMusicOnce
D $B2B6 Plays a tune, but only if this routine has not played one before. Bit 0
. of #R$5BD1 is set the first time and nothing clears it. The tune stops when a
. key is pressed (see #R$B2BE).
.
. The tunes played by this routine are:
. #TABLE(default,centre,centre)
. { =h Tune | =h Sound }
. { Menu Tune |
. #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune))) }
. TABLE#
E $B2B6 Continue on to #R$B2BE.
E $B2B6 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4A1 }
. { #GUNFRIGHT$AF76 }
. { #NIGHTSHADE$C63D }
. { #PENTAGRAM$D69C }
. LIST#
R $B2B6 DE Address of the tune
N $B2B6 Play only if #R$5BD1 is clear.
  $B2B6,$03 Point #REGhl at #R$5BD1.
  $B2B9,$03 Return if #R$5BD1 is set.
  $B2BC,$02 Set bit 0 of #R$5BD1.

c $B2BE Play Music Until Key Pressed
@ $B2BE label=PlayMusic_WaitKey
D $B2BE Plays a tune, which stops when a
. key is pressed. A tune is a list of
. notes (see #R$B2DA) which ends with
. #N$FF.
E $B2BE View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4A9 }
. LIST#
R $B2BE DE Address of the tune
N $B2BE Stop if a key is pressed.
  $B2BE,$01 Select all of the keyboard rows.
  $B2BF,$03 Call #R$B5F7.
  $B2C2,$02 Jump to #R$B2C5 if no key is
. pressed.
  $B2C4,$01 Return.
N $B2C5 Play the next note.
@ $B2C5 label=PlayMusic_WaitKey_Process
  $B2C5,$01 Fetch the next note.
  $B2C6,$04 Jump to #R$B2D9 if it is #N$FF.
  $B2CA,$03 Call #R$B2DA.
  $B2CD,$02 Jump to #R$B2BE.

c $B2CF Play Music
@ $B2CF label=PlayMusic
D $B2CF Plays a tune, which cannot be
. stopped. A tune is a list of notes (see
. #R$B2DA) which ends with #N$FF.
.
. The tunes played by this routine are:
. #TABLE(default,centre,centre)
. { =h Tune | =h Sound }
. { Start-up Tune |
. #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune))) }
. { Game Over Tune |
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune))) }
. { Game Complete Tune |
. #HTML(#AUDIO0(game-complete-tune.wav)(#INCLUDE(GameCompleteTune))) }
. { Main Tune |
. #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune))) }
. TABLE#
E $B2CF View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4BA }
. { #CYBERUN$9AA9 }
. { #GUNFRIGHT$AF8F }
. { #NIGHTSHADE$C656 }
. { #PENTAGRAM$D6B5 }
. { #SABREWULF$BD6E }
. { #COOKIE$6568 }
. LIST#
R $B2CF DE Address of the tune
N $B2CF Play each note until #N$FF.
  $B2CF,$01 Fetch the next note.
  $B2D0,$04 Jump to #R$B2D9 if it is #N$FF.
  $B2D4,$03 Call #R$B2DA.
  $B2D7,$02 Jump to #R$B2CF.
@ $B2D9 label=PlayMusic_Return
  $B2D9,$01 Return.

c $B2DA Play Note
@ $B2DA label=PlayNote
D $B2DA Plays a note of a tune, or a rest if the note number is zero.
. Bits 0 to 5 select the entry in #R$B332 that holds the two delays of a cycle
. and the number of cycles. Bits 6 and 7 are the length less one, which
. multiplies the number of cycles, so the note is one to four times as long.
E $B2DA View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4C5 }
. { #CYBERUN$9AB4 }
. { #GUNFRIGHT$AF9A }
. { #NIGHTSHADE$C661 }
. { #PENTAGRAM$D6C0 }
. { #SABREWULF$BD7B }
. LIST#
R $B2DA A The note
R $B2DA DE Address of the note
R $B2DA O:DE Address of the next note
N $B2DA Look up the delays and the number of cycles.
  $B2DA,$02,b$01 Isolate the number of the note.
  $B2DC,$02 Jump to #R$B31C if the note is a rest.
  $B2DE,$03 Set #REGhl to the note number.
  $B2E1,$01 Double the number.
  $B2E2,$03 Call #R$D4F2.
N $B2E5 Point #REGhl at the entry of the note in the table, #R$B332.
  $B2E5,$03 Point #REGbc at #R$B332.
  $B2E8,$01 Find the entry for the note.
N $B2E9 Fetch the first byte of the delay between the clicks of the speaker.
  $B2E9,$01 Fetch the first delay.
  $B2EA,$01 Move on.
N $B2EB Fetch the second byte of the delay.
  $B2EB,$01 Fetch the second delay.
  $B2EC,$01 Move on.
N $B2ED Fetch the basic length of the note.
  $B2ED,$01 Fetch the number of cycles.
  $B2EE,$02 Set #REGh to #N$00.
N $B2F0 Bits 6 and 7 are the length, less one.
  $B2F0,$01 Fetch the note again.
  $B2F1,$02 Move bits 6 and 7 to bits 0 and 1.
N $B2F3 Isolate the length of the note.
  $B2F3,$02,b$01 Isolate the length of the note.
N $B2F5 Make it #N$01 to #N$04.
  $B2F5,$01 Add one.
  $B2F6,$01 Stash the note address on the stack.
  $B2F7,$02 Copy the number of cycles to #REGde.
N $B2F9 Multiply the number of cycles by the length.
@ $B2F9 label=PlayNote_Multiply
  $B2F9,$01 Count down the length.
  $B2FA,$02 Jump to #R$B2FF if the length has been used up.
  $B2FC,$01 Add the number of cycles again.
  $B2FD,$02 Jump to #R$B2F9.
@ $B2FF label=PlayNote_MultiplyDone
  $B2FF,$01 Restore the note address from the stack.
N $B300 Each pass makes one cycle of the note.
@ $B300 label=PlayNote_Cycle
  $B300,$01 Stash the delays on the stack.
  $B301,$01 Set #REGa to #N$00.
  $B302,$02 Turn the speaker off.
@ $B304 label=PlayNote_OffDelay
  $B304,$02 Wait with the speaker off, using the first byte of the delay for the
. first pass and #N$0100 for each pass after it.
  $B306,$01 Count down the second delay.
  $B307,$02 Jump to #R$B304 until it has finished.
  $B309,$01 Restore the delays from the stack.
  $B30A,$01 Stash the delays on the stack.
  $B30B,$02 Set bit 4.
  $B30D,$02 Turn the speaker on.
@ $B30F label=PlayNote_OnDelay
  $B30F,$02 Wait with the speaker on for the same length of time.
  $B311,$01 Count down the second delay.
  $B312,$02 Jump to #R$B30F until it has finished.
  $B314,$01 Restore the delays from the stack.
  $B315,$01 Decrease the number of cycles left to play.
  $B316,$04 Jump to #R$B300 until there are none left.
  $B31A,$01 Point at the next note.
  $B31B,$01 Return.
N $B31C A rest is a silent pause of one to four units.
@ $B31C label=PlayNote_Rest
  $B31C,$01 Fetch the length of the rest.
  $B31D,$01 Point at the next note.
  $B31E,$02 Rotate bits 6-7 of the note into the low bits.
  $B320,$02,b$01 Keep bits 0 and 1.
  $B322,$01 Add one.
  $B323,$01 Keep it in #REGl.
  $B324,$03 Set #REGbc to #N$430B.
@ $B327 label=PlayNote_RestUnit
  $B327,$01 Stash the pause length on the stack.
@ $B328 label=PlayNote_RestDelay
  $B328,$01 Count down the pause.
  $B329,$04 Jump to #R$B328 until the length of the wait is zero.
  $B32D,$01 Restore the pause length from the stack.
  $B32E,$01 Count down the units of the rest.
  $B32F,$02 Jump to #R$B327 until it is zero.
  $B331,$01 Return.

b $B332 Music Note Table
@ $B332 label=MusicNotes
D $B332 The three bytes for each of the notes, where the notes are numbered from
. #N$00. The first two bytes are the delay between the clicks of the speaker,
. which is shorter for the higher notes, and the third is the basic length of
. the note, which is the number of cycles of the note to play. #R$B2DA uses it.
B $B332,$03,$03 The rest has no delay and no length, as the rest does not use
. the table.
B $B335,$B4,$03 The notes #N$01 to #N$3C.

c $B3E9 Play Pitch From Table
@ $B3E9 label=PlayPitchFromTable
D $B3E9 Plays four cycles of a tone whose pitch is taken from the eight values
. of #R$B3FB, which is chosen by the lowest three bits of the frame counter.
E $B3E9 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B5D4 }
. LIST#
N $B3E9 Choose a pitch from the table.
N $B3E9 #HTML(#AUDIO0(block-sound.wav)(#INCLUDE(BlockSound)))
  $B3E9,$03 Fetch #R$5BA2.
  $B3EC,$02,b$01 Keep bits 0 to 2.
  $B3EE,$03 Set #REGhl to the entry number.
  $B3F1,$03 Point #REGbc at #R$B3FB.
  $B3F4,$01 Add the entry number to the address of the table.
  $B3F5,$01 Fetch the pitch.
  $B3F6,$02 Set the number of cycles to #N$04.
  $B3F8,$03 Jump to #R$B4E6.

b $B3FB Pitch Table
@ $B3FB label=PitchTable
D $B3FB The eight pitches that #R$B3E9 picks from.
B $B3FB,$08,$08

c $B403 Play Sparkle Sound
@ $B403 label=PlaySparkleSound
D $B403 Plays a burst of noise for the sparkles of a dying player. The pitch of
. each cycle comes from the bytes of the ROM, starting at #N($1234), and the
. number of cycles depends on the sprite number of the sparkle, so each stage of
. the sparkles sounds different.
E $B403 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B5EE }
. LIST#
R $B403 IX Address of the sparkle object
N $B403 Play a beep for each remaining frame.
N $B403 #HTML(#AUDIO0(sparkles-sound.wav)(#INCLUDE(SparklesSound)))
  $B403,$03 Fetch the graphic number of the sparkle.
  $B406,$01 Invert it.
  $B407,$02,b$01 Keep the lowest five bits to get the number of notes to play.
  $B409,$01 Set #REGe to the number of notes.
  $B40A,$03 Point #REGhl at the ROM bytes that are used as noise.
@ $B40D label=PlaySparkleSound_NextBeep
  $B40D,$01 Fetch the next byte of noise.
  $B40E,$01 Move on to the next one.
  $B40F,$01 Use it as the pitch.
  $B410,$02 Set the number of cycles to play.
  $B412,$03 Play the tone.
  $B415,$03 Decrease the note counter and loop back to #R$B40D until all of the
. notes have been played.
  $B418,$01 Return.

c $B419 Play Appearing Sound
@ $B419 label=PlayAppearingSound
D $B419 Plays the rising sound of the sparkles that show the player appearing.
. The number of cycles depends on the sprite number of the sparkle.
E $B419 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B604 }
. LIST#
R $B419 IX Address of the sparkle object
N $B419 Make a beep for each remaining frame.
N $B419 #HTML(#AUDIO0(appearing-sound.wav)(#INCLUDE(AppearingSound)))
  $B419,$03 Fetch the graphic number of the sparkle.
  $B41C,$02 Rotate it left twice.
  $B41E,$02,b$01 Keep the lowest five bits.
  $B420,$02,b$01 Make sure that there are at least three cycles.
  $B422,$01 Set #REGc to the number of cycles.
@ $B423 label=PlayAppearingSound_NextBeep
  $B423,$01 Fetch the cycle counter.
  $B424,$02 Multiply it by four to get the pitch.
  $B426,$01 Set #REGb to the pitch.
  $B427,$03 Play a single cycle of the tone.
  $B42A,$03 Decrease the cycle counter and loop back to #R$B423 until it is
. zero.
  $B42D,$01 Return.

c $B42E Play Bump Sound
@ $B42E label=PlayBumpSound
D $B42E Plays four short bursts of a tone, whose pitches come from the first
. four bytes of the ROM, for a ball hitting the floor.
E $B42E View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B619 }
. LIST#
N $B42E Play four bursts of three beeps.
N $B42E #HTML(#AUDIO0(bounce-sound.wav)(#INCLUDE(BounceSound)))
  $B42E,$03 Point #REGhl at the start of the ROM.
  $B431,$02 Set the number of bursts to play.
@ $B433 label=PlayBumpSound_NextBurst
  $B433,$02 Set the number of cycles of each burst.
  $B435,$01 Fetch the next byte of the ROM.
  $B436,$01 Move on to the next one.
  $B437,$02,b$01 Make it a high pitch by setting its top two bits.
  $B439,$01 Set #REGb to the pitch.
  $B43A,$03 Play the tone.
  $B43D,$03 Decrease the burst counter and loop back to #R$B433 until all of the
. bursts have been played.
  $B440,$01 Return.

c $B441 Play Jump Sound
@ $B441 label=PlayJumpSound
D $B441 Plays the sound of the player jumping, which goes through a series of
. pitches.
E $B441 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B62C }
. LIST#
N $B441 Play #N$20 beeps of falling pitch.
N $B441 #HTML(#AUDIO0(jump-sound.wav)(#INCLUDE(JumpSound)))
  $B441,$02 Set the number of cycles.
@ $B443 label=PlayJumpSound_NextBeep
  $B443,$01 Fetch the cycle counter.
  $B444,$05 Rotate it to get the pitch.
  $B449,$01 Set #REGb to the pitch.
  $B44A,$03 Play a single cycle of the tone.
N $B44D Decrease the cycle counter and loop back to #R$B443 until it is zero.
  $B44D,$01 Count down.
  $B44E,$02 Jump to #R$B443 until all of the beeps have been played.
  $B450,$01 Return.

c $B451 Play Sound From Height
@ $B451 label=PlaySoundFromHeight
D $B451 Plays a tone for an object that is falling, with a pitch taken from the
. height of the object (its Z coordinate).
E $B451 Continue on to #R$B454.
E $B451 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B63C }
. LIST#
R $B451 IX Address of the object
N $B451 Use the height as the pitch source.
N $B451 #HTML(#AUDIO0(falling-sound.wav)(#INCLUDE(FallingSound)))
  $B451,$03 Fetch the Z coordinate of the object.

c $B454 Play Sound From Value
@ $B454 label=PlaySoundFromHeight_PlaySoundFromValue
D $B454 Plays six cycles of a tone whose pitch is worked out from the value in
. #REGa.
E $B454 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B63F }
. LIST#
R $B454 A Value that the pitch is made from
N $B454 Turn the value into a pitch and play six beeps.
N $B454 #HTML(#AUDIO0(rising-sound.wav)(#INCLUDE(RisingSound)))
  $B454,$01 Invert the value.
  $B455,$02 Multiply it by four to get the pitch.
  $B457,$01 Set #REGb to the pitch.
  $B458,$02 Set the number of cycles.
  $B45A,$03 Play the tone.

c $B45D Play Sound From X Position
@ $B45D label=PlaySoundFromXPosition
D $B45D Plays the tone for an object that is moving east or west, with a pitch
. taken from its X coordinate.
R $B45D IX Address of the object
N $B45D Use the X coordinate as the pitch source.
N $B45D #HTML(#AUDIO0(block-east-west-sound.wav)(#INCLUDE(BlockEastWestSound)))
  $B45D,$03 Fetch the X coordinate of the object.
  $B460,$02 Jump to #R$B454.

c $B462 Play Sound From Y Position
@ $B462 label=PlaySoundFromYPosition
D $B462 Plays the tone for an object that is moving north or south, with a pitch
. taken from its Y coordinate.
R $B462 IX Address of the object
N $B462 Use the Y coordinate as the pitch source.
. #HTML(#AUDIO0(block-north-south-sound.wav)(#INCLUDE(BlockNorthSouthSound)))
  $B462,$03 Fetch the Y coordinate of the object.
  $B465,$02 Jump to #R$B454.

c $B467 Play Sound From Position
@ $B467 label=PlaySoundFromPosition
D $B467 Plays the tone for a special object, a ghost or a portcullis that is
. moving, with a pitch made from the sum of its three coordinates.
E $B467 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B654 }
. LIST#
R $B467 IX Address of the object
N $B467 Sum the three coordinates for the pitch.
N $B467 #HTML(#AUDIO0(moving-sound.wav)(#INCLUDE(MovingSound)))
  $B467,$03 Fetch the X coordinate of the object.
  $B46A,$03 Add the Y coordinate.
  $B46D,$03 Add the Z coordinate.
  $B470,$02 Jump to #R$B454.

c $B472 Play Sound From Object Number
@ $B472 label=PlaySoundFromObjectNumber
D $B472 Plays the warbling sound of the player turning into a wulf or back into
. a human. The number of cycles depends on the sprite number of the
. transformation.
E $B472 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B65F }
. LIST#
R $B472 IX Address of the object
N $B472 Work the number of cycles from the sprite number.
N $B472 #HTML(#AUDIO0(transform-sound.wav)(#INCLUDE(TransformSound)))
  $B472,$03 Fetch the graphic number of the object.
  $B475,$03 Rotate it left three times.
  $B478,$02,b$01 Keep bits 3 and 4.
  $B47A,$02 Add #N$10 to get the number of cycles.
  $B47C,$01 Set #REGc to the number of cycles.
@ $B47D label=PlaySoundFromObjectNumber_NextBeep
  $B47D,$01 Fetch the cycle counter.
  $B47E,$02,b$01 Mix it up to get a wide range of pitches.
  $B480,$01 Add the cycle counter again.
  $B481,$01 Set #REGb to the pitch.
  $B482,$03 Play a single cycle of the tone.
  $B485,$03 Decrease the cycle counter and loop back to #R$B47D until it is
. zero.
  $B488,$01 Return.

c $B489 Play Random Noise
@ $B489 label=PlayRandomNoise
D $B489 Plays sixteen short bursts of a tone for the portcullis coming to rest.
. The pitches come from a random place in the first #N$2000 bytes of the ROM.
E $B489 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B676 }
. { #SABREWULF$BEEE }
. LIST#
N $B489 Pick a random ROM address and play sixteen bursts.
N $B489 #HTML(#AUDIO0(explosion.wav)(#INCLUDE(Explosion)))
  $B489,$03 Fetch the second random seed from #R$5BA5.
  $B48C,$01 Use it as the low byte of a ROM address.
  $B48D,$03 Fetch the frame counter from #R$5BA2.
  $B490,$02,b$01 Keep the lowest five bits.
  $B492,$01 Use it as the high byte of the ROM address.
  $B493,$02 Set the number of bursts to play.
@ $B495 label=PlayRandomNoise_NextBeep
  $B495,$01 Fetch the next byte of the ROM.
  $B496,$01 Move on to the next one.
  $B497,$02,b$01 Keep the lowest seven bits.
  $B499,$01 Use it as the pitch.
  $B49A,$02 Set the number of cycles of each burst.
  $B49C,$03 Play the tone.
  $B49F,$03 Decrease the burst counter and loop back to #R$B495 until all of the
. bursts have been played.
  $B4A2,$01 Return.

c $B4A3 Play Low Beep
@ $B4A3 label=PlayLowBeep
D $B4A3 Plays a low beep, which is sixteen cycles of a low tone. It tells the
. player that something has happened.
N $B4A3 Play sixteen cycles of a low tone.
N $B4A3 #HTML(#AUDIO0(beep-sound.wav)(#INCLUDE(BeepSound)))
  $B4A3,$03 Set the pitch and the number of cycles.
  $B4A6,$02 Play the tone.

c $B4A8 Play Middle Beep
@ $B4A8 label=PlayMiddleBeep
D $B4A8 Plays a beep of twenty-four cycles, with a higher pitch than #R$B4A3. It
. is the sound of the game being paused and of it carrying on again.
N $B4A8 Play twenty-four cycles of a middle tone.
N $B4A8 #HTML(#AUDIO0(pause-sound.wav)(#INCLUDE(PauseSound)))
  $B4A8,$03 Set the pitch and the number of cycles.
  $B4AB,$02 Play the tone.

c $B4AD Play Guard Footsteps Sound
@ $B4AD label=PlayGuardFootstepsSound
D $B4AD Plays the footsteps of a guard or the wizard, but only on every other
. frame of the walking animation. It carries on into #R$B4C6 with a fixed pitch.
E $B4AD View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B6C0 }
. LIST#
R $B4AD IX Address of the object
N $B4AD Play on even frames of the walking animation.
N $B4AD #HTML(#AUDIO0(guard-footstep-sound.wav)(#INCLUDE(GuardFootstepSound)))
  $B4AD,$03 Fetch the graphic number of the object.
  $B4B0,$02,b$01 Test whether it is an odd frame of the animation.
  $B4B2,$01 Return if it is.
  $B4B3,$02 Set the pitch.
  $B4B5,$03 Fetch the frame counter from #R$5BA2.
  $B4B8,$01 Invert it.
  $B4B9,$02 Jump to #R$B4C6.

c $B4BB Play Footsteps Sound
@ $B4BB label=PlayFootstepsSound
D $B4BB Plays the footsteps of the player walking, but only on every other frame
. of the walking animation. The number of cycles comes from the position of the
. player on the screen. The entry point at #R$B4C1 plays them on every frame.
E $B4BB View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B6CE }
. LIST#
R $B4BB IX Address of the object
N $B4BB Play on even frames of the walking animation.
N $B4BB #HTML(#AUDIO0(footstep-sound.wav)(#INCLUDE(FootstepSound)))
  $B4BB,$03 Fetch the graphic number of the object.
  $B4BE,$02,b$01 Test whether it is an odd frame of the animation.
  $B4C0,$01 Return if it is.
@ $B4C1 label=PlayFootstepsSound_EveryFrame
  $B4C1,$02 Set the pitch.
  $B4C3,$03 Fetch the frame counter from #R$5BA2.
@ $B4C6 label=PlayFootstepsSound_Position
N $B4C6 One time in two the pitch is made from the height of the object instead.
  $B4C6,$04 Jump to #R$B4D1 if a random bit of the seed is not set.
  $B4CA,$03 Fetch the Z coordinate of the object.
  $B4CD,$01 Invert it.
  $B4CE,$02 Halve it.
  $B4D0,$01 Use it as the pitch.
@ $B4D1 label=PlayFootstepsSound_Cycles
N $B4D1 The number of cycles is the high nibble of half of the X coordinate
. added to half of the negated Y coordinate, which is the horizontal position on
. the screen.
  $B4D1,$03 Fetch the X coordinate of the object.
  $B4D4,$02 Halve it.
  $B4D6,$01 Stash it in #REGc.
  $B4D7,$03 Fetch the Y coordinate of the object.
  $B4DA,$02 Negate it.
  $B4DC,$02 Halve it.
  $B4DE,$01 Add the halved X coordinate.
  $B4DF,$04 Move the high nibble into the low nibble.
  $B4E3,$02,b$01 Keep the low nibble.
  $B4E5,$01 Use it as the number of cycles.

c $B4E6 Play Wave Sequence
@ $B4E6 label=PlayWaveSequence
D $B4E6 Plays a tone made of a number of cycles with the same pitch.
E $B4E6 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B6FB }
. { #GUNFRIGHT$AF5F }
. { #PENTAGRAM$D67B }
. LIST#
R $B4E6 B Pitch of the tone (smaller values are higher)
R $B4E6 C Number of cycles
  $B4E6,$03 Play a single cycle of the tone.
  $B4E9,$03 Decrease the cycle counter and loop back to #R$B4E6 until all of the
. cycles have been played.
  $B4EC,$01 Return.

c $B4ED Play Square Wave
@ $B4ED label=PlaySquareWave
D $B4ED Plays a single beep by switching the speaker on, waiting, switching it
. off and waiting again. The bigger the pitch, the longer the beep.
E $B4ED View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B702 }
. { #CYBERUN$71E0 }
. { #GUNFRIGHT$AF66 }
. { #NIGHTSHADE$C471 }
. { #PENTAGRAM$D682 }
. { #SABREWULF$BF74 }
. LIST#
R $B4ED B Pitch of the tone (smaller values are higher)
N $B4ED Hold the speaker on, then off.
  $B4ED,$04 Set the speaker output high.
  $B4F1,$01 Keep the pitch in #REGa.
@ $B4F2 label=PlaySquareWave_FirstDelay
  $B4F2,$02 Wait for the high part of the cycle.
  $B4F4,$01 Restore the pitch.
  $B4F5,$03 Set the speaker output low.
  $B4F8,$01 Keep the pitch in #REGa.
@ $B4F9 label=PlaySquareWave_SecondDelay
  $B4F9,$02 Wait for the low part of the cycle.
  $B4FB,$01 Restore the pitch.
  $B4FC,$01 Return.

c $B4FD Test Object Intersections
@ $B4FD label=TestObjectIntersections
D $B4FD Tests whether the object that #REGix points at overlaps any other solid
. object in the objects table, without it moving. The object itself is flagged
. to be ignored while the table is searched. All registers are preserved.
E $B4FD View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B712 }
. { #PENTAGRAM$BF1B }
. LIST#
R $B4FD IX Address of the object
R $B4FD O:F Carry flag set if the object intersects another object
  $B4FD,$05 Stash the registers on the stack.
  $B502,$04 Point #REGiy at #R$5C08.
  $B506,$02 Set #REGb to the number of objects in the table.
  $B508,$02 Set the speed in X to test with to zero.
  $B50A,$01 Set the speed in Y to zero.
  $B50B,$01 Set the speed in Z to zero.
  $B50C,$04 Flag the object as ignored in the 3D calculations, so that it does
. not intersect itself.
N $B510 Test whether this object overlaps on all three axes.
@ $B510 label=TestObjectIntersections_TestObject
  $B510,$03 Test whether the object of the table is solid.
  $B513,$02 Jump to #R$B52E if it is not.
  $B515,$03 Test whether the objects overlap in X.
  $B518,$02 Jump to #R$B52E if they do not.
  $B51A,$03 Test whether the objects overlap in Y.
  $B51D,$02 Jump to #R$B52E if they do not.
  $B51F,$03 Test whether the objects overlap in Z.
  $B522,$02 Jump to #R$B52E if they do not.
N $B524 The objects overlap on all three axes (and the carry flag is set), or
. there are none left to try (and it is not).
@ $B524 label=TestObjectIntersections_Done
  $B524,$05 Restore the registers from the stack.
  $B529,$04 Stop the object being ignored in the 3D calculations.
  $B52D,$01 Return.
N $B52E Move on to the next object.
@ $B52E label=TestObjectIntersections_NextObject
  $B52E,$03 Set #REGde to the size of an object.
  $B531,$02 Move on to the next object in the table.
  $B533,$02 Decrease the object counter and loop back to #R$B510 until all of
. the objects have been tested.
  $B535,$01 Clear the carry flag, as nothing intersects.
  $B536,$02 Jump to #R$B524.

c $B538 Test Object Solid
@ $B538 label=TestObjectSolid
D $B538 Tests whether the object that #REGiy points at is present and is not
. flagged to be ignored in the 3D calculations. The zero flag is set if the slot
. is unused or bit 1 of the flags is set.
E $B538 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B74D }
. { #PENTAGRAM$B99B }
. LIST#
R $B538 IY The address of the object
R $B538 O:F Zero flag set if the slot is not used or the object is ignored
N $B538 Return if the slot is empty.
  $B538,$03 Fetch the graphic number of the object.
N $B53B Test it, as zero means that there is no object.
  $B53B,$02 Return if the slot is not used.
N $B53D After invert, bit 1 is set when the object is not ignored.
  $B53D,$03 Fetch the flags of the object.
  $B540,$01 Invert them.
  $B541,$02,b$01 Keep the ignore flag, which is now clear if the object is
. ignored.
  $B543,$01 Return.

c $B544 Shuffle Required Objects
@ $B544 label=ShuffleRequiredObjects
D $B544 Changes the order in which the special objects have to be taken to the
. cauldron. The list of #N$0E objects at #R$C27D is rotated by four to seven
. places, depending on the first random seed.
N $B544 Work out how many times to rotate the list.
  $B544,$03 Fetch #R$5BA0.
  $B547,$02,b$01 Keep the lowest two bits.
  $B549,$02,b$01 Make it four to seven.
  $B54B,$01 Use it as the number of times to rotate the list.
N $B54C Rotate the list one place.
@ $B54C label=ShuffleRequiredObjects_Loop
  $B54C,$02 Set the number of objects to move.
  $B54E,$04 Point #REGiy at #R$C27D.
  $B552,$03 Keep the first object in #REGe.
@ $B555 label=ShuffleRequiredObjects_Move
  $B555,$03 Fetch the next object in the list.
  $B558,$03 Store it one place earlier.
  $B55B,$02 Move on to the next object.
  $B55D,$02 Decrease the object counter and loop back to #R$B555 until all of
. them have moved.
  $B55F,$03 Put the first object at the end of the list.
  $B562,$03 Decrease the rotation counter and loop back to #R$B54C until the
. list has been rotated enough.
  $B565,$01 Return.

c $B566 Handle Ending Sparkles
@ $B566 label=HandleEndingSparkles
D $B566 Handles one of the sparkles that fly off the blocks when the cauldron
. room is shown at the end of the game. A sparkle rises until it is high enough,
. in one of four diagonal directions that depend on the part of the room it is
. in, and then flies at the player.
R $B566 IX Address of the sparkle object
N $B566 Rise until the sparkle is high enough, then fly at the player.
  $B566,$03 Set the pixel adjustments for a sparkle.
  $B569,$03 Fetch the height of the sparkle.
  $B56C,$04 Jump to #R$B5C4 if it has reached the top.
N $B570 Pick a diagonal from the part of the room the sparkle is in.
  $B570,$04 Make the sparkle rise at a speed of #N$03.
  $B574,$03 Fetch the X coordinate of the sparkle.
  $B577,$01 Rotate bit 7 into bit 0.
  $B578,$02,b$01 Keep only that bit.
  $B57A,$01 Stash it in #REGl.
  $B57B,$03 Fetch the Y coordinate of the sparkle.
  $B57E,$02,b$01 Keep bit 7 of it.
  $B580,$01 Add the bit from the X coordinate.
  $B581,$01 Rotate the two bits into bits 0 and 1.
  $B582,$02,b$01 Keep only those two bits.
  $B584,$01 Use them as the number of the entry of the direction table.
  $B585,$03 Point #REGbc at #R$B58B.
  $B588,$03 Jump to the routine for the direction.

w $B58B Sparkle Direction Table
@ $B58B label=SparkleDirectionTable
D $B58B The routines that give a sparkle its speeds in X and Y, chosen by the
. part of the room that the sparkle is in (bit 7 of the X coordinate and bit 7
. of the Y coordinate).
W $B58B,$02,$02 X below #N$80 and Y below #N$80: X speed #N($FC), Y speed #N$04.
W $B58D,$02,$02 X below #N$80 and Y at least #N$80: X speed #N($04), Y speed
. #N$04.
W $B58F,$02,$02 X at least #N$80 and Y below #N$80: X speed #N($FC), Y speed
. #N$FC.
W $B591,$02,$02 X and Y both at least #N$80: X speed #N($04), Y speed #N$FC.

c $B593 Set Sparkle Speed
@ $B593 label=SetSparkleSpeed
D $B593 Gives a sparkle its speeds in X and Y and picks one of its sparkle
. graphics at random. There are four entry points, one for each combination of
. the speeds #N$04 and #N$FC. They load #REGl with the X speed and #REGh with
. the Y speed and carry on at #R$B596.
R $B593 IX Address of the sparkle object
  $B593,$03 Set the X speed to #N$FC and the Y speed to #N$04.
@ $B596 label=SetSparkleSpeed_Store
N $B596 Store the speeds and pick the graphic.
  $B596,$03 Store the X speed in the object.
  $B599,$03 Store the Y speed in the object.
  $B59C,$03 Fetch the second random seed from #R$5BA5.
  $B59F,$02,b$01 Keep the lowest two bits to get a random number from #N$00 to
. #N$03.
  $B5A1,$02 Jump to #R$B5A4 if it is not zero.
  $B5A3,$01 Make zero into one.
@ $B5A4 label=SetSparkleSpeed_Graphic
  $B5A4,$02 Add #N$82 to get one of the three sparkle graphic numbers.
  $B5A6,$03 Store it as the graphic number of the object.
@ $B5A9 label=SetSparkleSpeed_Move
  $B5A9,$03 Fetch the height of the sparkle.
  $B5AC,$03 Store it, so that the sound of rising blocks can use it at #R$5BC5.
@ $B5AF label=MoveAndDrawObject
N $B5AF Move the object by its speeds, applying gravity, and flag it to be
. redrawn.
  $B5AF,$03 Update the position of the object.
  $B5B2,$03 Flag the object to be wiped and drawn again.
@ $B5B5 label=SetSparkleSpeed_PositivePositive
  $B5B5,$03 Set the X speed to #N$04 and the Y speed to #N$04.
  $B5B8,$02 Jump to #R$B596.
@ $B5BA label=SetSparkleSpeed_NegativeNegative
  $B5BA,$03 Set the X speed to #N$FC and the Y speed to #N$FC.
  $B5BD,$02 Jump to #R$B596.
@ $B5BF label=SetSparkleSpeed_NegativePositive
  $B5BF,$03 Set the X speed to #N$04 and the Y speed to #N$FC.
  $B5C2,$02 Jump to #R$B596.

c $B5C4 Send Sparkle At Player
@ $B5C4 label=SendSparkleAtPlayer
D $B5C4 Handles a sparkle that has risen to the top. If the sparkle is close to
. the player the game ends, otherwise the sparkle is made deadly and set off
. towards the player.
R $B5C4 IX Address of the sparkle object
N $B5C4 End the game if the sparkle is close to the player.
  $B5C4,$03 Fetch the X coordinate of the player.
  $B5C7,$03 Subtract the X coordinate of the sparkle.
  $B5CA,$03 Jump to #R$B5CF if the result is positive.
  $B5CD,$02 Make it positive.
@ $B5CF label=SendSparkleAtPlayer_TestX
  $B5CF,$04 Jump to #R$B5E3 if the sparkle is #N$06 or more away from the player
. in X.
  $B5D3,$03 Fetch the Y coordinate of the player.
  $B5D6,$03 Subtract the Y coordinate of the sparkle.
  $B5D9,$03 Jump to #R$B5DE if the result is positive.
  $B5DC,$02 Make it positive.
@ $B5DE label=SendSparkleAtPlayer_TestY
  $B5DE,$05 Jump to #R$BA22 if the sparkle is less than #N$06 away from the
. player in Y too, as the sparkle has caught the player.
@ $B5E3 label=SendSparkleAtPlayer_Fly
N $B5E3 Make the sparkle deadly and send it towards the player.
  $B5E3,$04 Flag the sparkle as fatal if it hits the player.
  $B5E7,$04 Flag the sparkle as ignored in the 3D calculations.
  $B5EB,$04 Make the sparkle drop at a speed of #N$01.
  $B5EF,$03 Set the speed towards the player to #N$04 in X and in Y.
  $B5F2,$03 Move the sparkle towards the player.
  $B5F5,$02 Jump to #R$B5A9.

c $B5F7 Read Keyboard Port
@ $B5F7 label=ReadKeyboardPort
D $B5F7 Reads some rows of the keyboard. The row selector is also written to
. port #N$FD (with the selector as the high byte of the address), which does
. nothing on a 48K Spectrum and is not part of any sound; the keyboard is read
. with the same selector straight afterwards.
E $B5F7 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B759 }
. { #CYBERUN$9BC3 }
. { #GUNFRIGHT$D0DB }
. { #NIGHTSHADE$E239 }
. { #PENTAGRAM$B952 }
. LIST#
R $B5F7 A Row selector (a bit which is reset selects the row)
R $B5F7 O:A Keys pressed, in bits 0 to 4 (a bit is set when a key is pressed)
R $B5F7 O:F Zero flag set if no key is pressed
N $B5F7 Write the selector, then read the keys.
  $B5F7,$02 Put the half-row selector on the high byte of the address bus.
  $B5F9,$02 Read the rows of the keyboard.
  $B5FB,$01 Invert the bits so that the pressed keys are set.
  $B5FC,$02,b$01 Keep only bits 0 to 4.
  $B5FE,$01 Return.

c $B5FF Handle Bouncing Ball
@ $B5FF label=HandleBouncingBall
D $B5FF Handles a ball that bounces around the room. Every time the ball hits
. the floor it bounces up again and sets off at a speed of #N$02 along either
. the X axis or the Y axis, towards the player if the player is the wulf and
. away from the player if the player is the human. In rooms with an odd number
. the height of the bounce is random.
D $B5FF The test for which way to go is a self-modifying one: this routine
. changes the conditional jumps at #R$B65D and #R$B676 into JR NC when the
. player is the wulf and JR C when the player is the human.
R $B5FF IX Address of the ball object
  $B5FF,$03 Set the pixel adjustments of the ball.
  $B602,$03 Fetch the speed in X of the ball.
  $B605,$03 Fetch the speed in Y of the ball.
  $B608,$01 Stash the speeds on the stack.
  $B609,$03 Fetch the speed in Z of the ball.
  $B60C,$03 Keep it, so that the bounce can be told from the ball rising at
. #R$5BC2.
  $B60F,$03 Apply gravity to the ball and move it.
  $B612,$01 Restore the speeds in X and Y from the stack.
  $B613,$03 Put the speed in X back.
  $B616,$03 Put the speed in Y back.
N $B619 Work out which way the ball should go from the form the player is in.
  $B619,$03 Fetch the graphic number of the player's legs from #R$5C08.
  $B61C,$02 Take off the first graphic number of the legs.
  $B61E,$02 Compare the result with #N($20), which is where the legs of the wulf
. start. The carry flag is set if the player is a human.
  $B620,$02 Get the opcode of JR NC.
  $B622,$02 Jump to #R$B626 if the player is the wulf.
  $B624,$02 Turn the opcode into the one of JR C.
@ $B626 label=HandleBouncingBall_SetCondition
  $B626,$03 Change the jump at #R$B65D.
  $B629,$03 Change the jump at #R$B676.
N $B62C Work out how fast the ball bounces up.
  $B62C,$03 Fetch the room that the player is in.
  $B62F,$02,b$01 Test whether the number of the room is odd.
  $B631,$02 Set the speed to #N$04.
  $B633,$02 Jump to #R$B63C if it is even.
  $B635,$01 Stash the minimum speed in #REGb.
  $B636,$03 Fetch the second random seed from #R$5BA5.
  $B639,$02,b$01 Keep the lowest two bits.
  $B63B,$01 Add them to the minimum speed.
@ $B63C label=HandleBouncingBall_TestFloor
  $B63C,$06 Jump to #R$B668 if the ball has not hit the floor.
  $B642,$03 Make the ball bounce up.
  $B645,$03 Fetch the old speed in Z of the ball from #R$5BC2.
  $B648,$01 Test whether it was rising.
  $B649,$03 Jump to #R$B64F if it was.
  $B64C,$03 Play the sound of the ball bouncing.
N $B64F Choose the axis that the ball goes along at random.
@ $B64F label=HandleBouncingBall_Direction
  $B64F,$02 Read the refresh register for a random number.
  $B651,$02,b$01 Keep the lowest bit.
  $B653,$02 Jump to #R$B66E if it is zero, to go along the X axis.
  $B655,$03 Fetch the Y coordinate of the player.
  $B658,$03 Compare it with the Y coordinate of the ball.
  $B65B,$02 Set the speed to #N$02.
@ $B65D label=HandleBouncingBall_ConditionY
  $B65D,$02 Jump to #R$B661 if the ball is to go in the positive direction. This
. is the instruction that is changed.
  $B65F,$02 Make the speed negative.
@ $B661 label=HandleBouncingBall_SetSpeedY
  $B661,$03 Set the speed in Y of the ball.
  $B664,$04 Clear the speed in X of the ball.
@ $B668 label=HandleBouncingBall_Draw
  $B668,$03 Toggle the graphic number of the ball between its two frames.
  $B66B,$03 Make the ball deadly and flag it to be drawn.
@ $B66E label=HandleBouncingBall_DirectionX
  $B66E,$03 Fetch the X coordinate of the player.
  $B671,$03 Compare it with the X coordinate of the ball.
  $B674,$02 Set the speed to #N$02.
@ $B676 label=HandleBouncingBall_ConditionX
  $B676,$02 Jump to #R$B67A if the ball is to go in the positive direction. This
. is the instruction that is changed.
  $B678,$02 Make the speed negative.
@ $B67A label=HandleBouncingBall_SetSpeedX
  $B67A,$03 Set the speed in X of the ball.
  $B67D,$04 Clear the speed in Y of the ball.
  $B681,$02 Jump to #R$B668.

c $B683 Handle Dropping Block
@ $B683 label=HandleDroppingBlock
D $B683 Handles a block that sinks while something is standing on it. The
. collision routines set the triggered flag of the block (bit 3 of its flags
. byte) for as long as something rests on it.
R $B683 IX Address of the block object
  $B683,$03 Set the pixel adjustments of a block.
N $B686 Sink while something is standing on the block.
  $B686,$04 Test whether something is standing on the block.
  $B68A,$01 Return if nothing is.
  $B68B,$04 Reset the triggered flag.
  $B68F,$04 Clear the speed in Z of the block.
  $B693,$03 Apply gravity to the block and move it.
  $B696,$06 Jump to #R$B69F if the block has hit the floor.
  $B69C,$03 Play the sound of a falling object.
@ $B69F label=HandleDroppingBlock_Draw
  $B69F,$03 Flag the block to be drawn again.

c $B6A2 Handle Collapsing Block
@ $B6A2 label=HandleCollapsingBlock
D $B6A2 Handles a block that crumbles into sparkles when something stands on it.
E $B6A2 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B28C }
. LIST#
R $B6A2 IX Address of the block object
  $B6A2,$03 Set the pixel adjustments of a block.
  $B6A5,$04 Test whether something is standing on the block.
  $B6A9,$01 Return if nothing is.
  $B6AA,$04 Change the block into a sparkle.
  $B6AE,$03 Carry on as the sparkles of a death.

c $B6B1 Handle Block Moving North South
@ $B6B1 label=HandleBlockMovingNorthSouth
D $B6B1 Handles a block that slides to and fro along the Y axis. The block
. follows a triangle wave that is worked out from the frame counter, so that it
. keeps in step however long the room has been on the screen. The code of
. #R$B6BF is modified to use the Y coordinate and Y speed of the block.
R $B6B1 IX Address of the block object
  $B6B1,$03 Play the sound of a block moving along the Y axis.
  $B6B4,$03 Set #REGh to the offset of the Y coordinate and #REGl to the offset
. of the speed in Y.
  $B6B7,$02 Jump to #R$B6BF.

c $B6B9 Handle Block Moving East West
@ $B6B9 label=HandleBlockMovingEastWest
D $B6B9 Handles a block that slides to and fro along the X axis. It works in the
. same way as #R$B6B1 but with the X coordinate and the speed in X.
E $B6B9 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B224 }
. LIST#
R $B6B9 IX Address of the block object
  $B6B9,$03 Play the sound of a block moving along the X axis.
  $B6BC,$03 Set #REGh to the offset of the X coordinate and #REGl to the offset
. of the speed in X.
N $B6BF Modify the instructions that fetch the coordinate and store the speed.
@ $B6BF label=HandleMovingBlock
  $B6BF,$01 Fetch the offset of the coordinate.
  $B6C0,$03 Change the instruction at #R$B6DE to use it.
  $B6C3,$01 Fetch the offset of the speed.
  $B6C4,$03 Change the instruction at #R$B6EF to use it.
  $B6C7,$03 Set the pixel adjustments of a block.
N $B6CA Work out where the block should be: a position from #N$00 to #N$0F that
. goes up and down with the frame counter. The two blocks of a room are half a
. cycle apart, depending on the address of the object.
  $B6CA,$03 Copy #REGix to #REGbc (using the stack).
  $B6CD,$01 Fetch the low byte of the address of the object.
  $B6CE,$01 Rotate it right.
  $B6CF,$02,b$01 Keep the bit which is different for the neighbouring objects.
  $B6D1,$01 Stash it in #REGc.
  $B6D2,$03 Fetch the frame counter from #R$5BA2.
  $B6D5,$01 Add the offset of this block.
  $B6D6,$04 Jump to #R$B6DB if bit 4, which is the direction of the wave, is
. clear.
  $B6DA,$01 Invert the value, so that the wave goes down again.
@ $B6DB label=HandleMovingBlock_Target
  $B6DB,$02,b$01 Keep the lowest four bits as the position to go to.
  $B6DD,$01 Stash it in #REGc.
N $B6DE Compare the block with the target. Redraw it if it is already
. there, otherwise set a speed of #N$01 towards the target.
@ $B6DE label=HandleMovingBlock_Coordinate
  $B6DE,$03 Fetch the coordinate of the block. This is the instruction that is
. modified.
  $B6E1,$02 Add #N$08 to it.
  $B6E3,$02,b$01 Keep the position of the block within its #N$10 steps.
  $B6E5,$01 Compare it with the position that it should go to.
  $B6E6,$03 Jump to #R$C692 if it is already there.
  $B6E9,$02 Set the speed to #N$01.
  $B6EB,$02 Jump to #R$B6EF if the block is below the position that it should go
. to.
  $B6ED,$02 Make the speed negative.
N $B6EF Set that speed, hold the block up, and move it.
@ $B6EF label=HandleMovingBlock_Speed
  $B6EF,$03 Set the speed of the block. This is the instruction that is
. modified.
  $B6F2,$04 Set the speed in Z to #N($01), so that the block does not fall.
  $B6F6,$03 Move the block and flag it to be drawn again.

c $B6F9 Handle Guard Or Wizard Bottom Half
@ $B6F9 label=HandleGuardBottomHalf
D $B6F9 Handles the bottom half of a guard that moves in any direction or of the
. wizard. The graphic of the bottom half follows the direction in which the
. guard is moving: the lowest bit of the graphic number says which of two frames
. of the walking animation is shown, bit 3 says whether the guard faces towards
. or away from the player, and the horizontal flip flag of the object is set for
. the directions that mirror the sprites.
R $B6F9 IX Address of the bottom half of the guard
N $B6F9 Face the legs in the direction the guard is moving.
  $B6F9,$03 Set the pixel adjustments of a guard.
  $B6FC,$03 Fetch the speed in X.
  $B6FF,$03 Combine it with the speed in Y.
  $B702,$01 Return if the guard is not moving.
  $B703,$03 Play the sound of the guard's footsteps.
  $B706,$03 Fetch the speed in X.
  $B709,$03 Compare it with the speed in Y.
  $B70C,$02 Jump to #R$B726 if it is smaller.
  $B70E,$04 Jump to #R$B720 if the speed in X is negative.
  $B712,$04 Select the graphic of a guard facing in the positive X direction.
@ $B716 label=HandleGuardBottomHalf_ClearFlip
  $B716,$04 Clear the horizontal flip flag.
@ $B71A label=HandleGuardBottomHalf_Draw
  $B71A,$03 Set the direction of the legs.
  $B71D,$03 Flag the object to be drawn again.
@ $B720 label=HandleGuardBottomHalf_NegativeX
  $B720,$04 Select the graphic of a guard facing in the negative X direction.
  $B724,$02 Jump to #R$B716.
@ $B726 label=HandleGuardBottomHalf_Y
  $B726,$06 Jump to #R$B736 if the speed in Y is not negative.
  $B72C,$04 Select the graphic of a guard facing in the negative Y direction.
@ $B730 label=HandleGuardBottomHalf_SetFlip
  $B730,$04 Set the horizontal flip flag.
  $B734,$02 Jump to #R$B71A.
@ $B736 label=HandleGuardBottomHalf_PositiveY
  $B736,$04 Select the graphic of a guard facing in the positive Y direction.
  $B73A,$02 Jump to #R$B730.

c $B73C Handle Guard Moving East West
@ $B73C label=HandleGuardMovingEastWest
D $B73C Handles the top half of a guard that patrols east and west. The guard
. walks at a speed of #N$02 and turns round when it hits something. The bottom
. half of the guard, which is the next object in the table, is kept in step.
R $B73C IX Address of the top half of the guard
N $B73C Walk east or west and turn when the guard hits something.
  $B73C,$03 Set the pixel adjustments of a guard.
  $B73F,$04 Test whether the guard is heading east.
  $B743,$02 Set the speed to #N$02.
  $B745,$02 Jump to #R$B749 if the guard is heading east.
  $B747,$02 Make the speed negative.
@ $B749 label=HandleGuardMovingEastWest_Speed
  $B749,$03 Set the speed in X of the guard.
  $B74C,$03 Set the speed in X of the bottom half of the guard too.
  $B74F,$03 Choose the graphic of the guard from its direction.
  $B752,$03 Apply gravity to the guard and move it.
  $B755,$06 Jump to #R$B763 if the guard has not hit something along the X axis.
  $B75B,$03 Fetch the direction flags of the guard.
  $B75E,$02,b$01 Turn the guard round.
  $B760,$03 Store them.
@ $B763 label=HandleGuardMovingEastWest_BottomHalf
N $B763 Keep the bottom half in step and make the guard deadly.
  $B763,$03 Fetch the X coordinate of the guard.
  $B766,$03 Give it to the bottom half of the guard.
  $B769,$03 Make the guard deadly and flag it to be drawn again.

c $B76C Face Direction Of Movement
@ $B76C label=FaceDirectionOfMovement
D $B76C Chooses the graphic of a guard or of the wizard from the direction that
. it is moving in. The lowest bit of the graphic number is changed to pick one
. of two graphics and the horizontal flip flag is set or cleared to mirror it.
E $B76C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B1AE }
. LIST#
R $B76C IX Address of the object
N $B76C Choose the graphic from the larger of the X and Y speeds.
  $B76C,$03 Fetch the speed in X.
  $B76F,$03 Combine it with the speed in Y.
  $B772,$01 Return if the guard is not moving.
  $B773,$03 Fetch the speed in X.
  $B776,$03 Compare it with the speed in Y.
  $B779,$02 Jump to #R$B78E if it is smaller.
  $B77B,$04 Jump to #R$B788 if the speed in X is negative.
  $B77F,$04 Select the graphic that faces in the positive X direction.
@ $B783 label=FaceDirectionOfMovement_ClearFlip
  $B783,$04 Clear the horizontal flip flag.
  $B787,$01 Return.
@ $B788 label=FaceDirectionOfMovement_NegativeX
  $B788,$04 Select the graphic that faces in the negative X direction.
  $B78C,$02 Jump to #R$B783.
@ $B78E label=FaceDirectionOfMovement_MovingAlongY
  $B78E,$06 Jump to #R$B79D if the speed in Y is not negative.
  $B794,$04 Select the graphic that faces in the negative Y direction.
@ $B798 label=FaceDirectionOfMovement_SetFlip
  $B798,$04 Set the horizontal flip flag.
  $B79C,$01 Return.
@ $B79D label=FaceDirectionOfMovement_PositiveY
  $B79D,$04 Select the graphic that faces in the positive Y direction.
  $B7A1,$02 Jump to #R$B798.

c $B7A3 Handle Gargoyle
@ $B7A3 label=HandleGargoyle
D $B7A3 Handles a gargoyle, which does not move but is deadly.
R $B7A3 IX Address of the gargoyle object
  $B7A3,$03 Make the gargoyle deadly.
  $B7A6,$03 Set the pixel adjustments of a gargoyle.

c $B7A9 Handle Spiked Ball
@ $B7A9 label=HandleSpikedBall
D $B7A9 Handles a spiked ball. It hangs in the air until, one time in sixteen,
. it is chosen to drop (only one ball drops at a time), and then it falls to the
. floor and stays there. Nothing happens while the balls are not allowed to
. drop.
E $B7A9 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$AD13 }
. LIST#
R $B7A9 IX Address of the spiked ball object
  $B7A9,$03 Make the spiked ball deadly.
  $B7AC,$03 Set the pixel adjustments of a spiked ball.
N $B7AF Hang in the air until this ball is chosen to drop.
  $B7AF,$03 Fetch the flag that stops the balls from dropping from #R$5BC0.
  $B7B2,$01 Test it.
  $B7B3,$01 Return if the balls may not drop.
  $B7B4,$06 Jump to #R$B7CD if this ball is dropping.
  $B7BA,$03 Point #REGhl at #R$5BBF.
  $B7BD,$01 Fetch it.
  $B7BE,$01 Test it.
  $B7BF,$01 Return if another ball is dropping.
  $B7C0,$03 Fetch the second random seed from #R$5BA5.
  $B7C3,$02 Compare it with #N$10 for a one in sixteen chance.
  $B7C5,$01 Return if it is not that time.
  $B7C6,$04 Flag this ball as dropping.
  $B7CA,$02 Flag that a ball is dropping.
  $B7CC,$01 Return.
N $B7CD Make the ball fall.
@ $B7CD label=HandleSpikedBall_Drop
  $B7CD,$03 Apply gravity to the ball and move it.
  $B7D0,$06 Jump to #R$B7DC if the ball has hit the floor.
  $B7D6,$03 Play the sound of a falling object.
@ $B7D9 label=HandleSpikedBall_Draw
  $B7D9,$03 Flag the ball to be drawn again.
@ $B7DC label=HandleSpikedBall_Landed
  $B7DC,$04 Flag this ball as no longer dropping.
  $B7E0,$03 Point #REGhl at #R$5BBF.
  $B7E3,$02 Flag that no ball is dropping.
  $B7E5,$02 Jump to #R$B7D9.

c $B7E7 Handle Spikes
@ $B7E7 label=HandleSpikes
D $B7E7 Handles a set of spikes, which do not move but are deadly.
R $B7E7 IX Address of the spikes object
  $B7E7,$03 Make the spikes deadly.
  $B7EA,$03 Set the pixel adjustments of a block.

c $B7ED Handle Fire Moving East West
@ $B7ED label=HandleFireMovingEastWest
D $B7ED Handles a fire that moves to and fro along the X axis at a speed of
. #N($02), turning round when it hits something.
R $B7ED IX Address of the fire object
N $B7ED Move along X and turn if the fire hits something.
  $B7ED,$03 Set the pixel adjustments of a ball.
  $B7F0,$04 Set the speed in Z to #N($01), so that the fire does not fall.
  $B7F4,$04 Test whether the fire is heading east.
  $B7F8,$02 Set the speed to #N$02.
  $B7FA,$02 Jump to #R$B7FE if it is.
  $B7FC,$02 Make the speed negative.
@ $B7FE label=HandleFireMovingEastWest_Speed
  $B7FE,$03 Set the speed in X of the fire.
  $B801,$03 Play the sound of a block moving along the X axis.
  $B804,$03 Apply gravity to the fire and move it.
  $B807,$04 Test whether the fire has hit something along the X axis.
  $B80B,$02 Set the direction bit to flip to bit 0.
  $B80D,$02 Jump to #R$B82F.

c $B80F Handle Fire Moving North South
@ $B80F label=HandleFireMovingNorthSouth
D $B80F Handles a fire that moves to and fro along the Y axis at a speed of
. #N($02), turning round when it hits something.
R $B80F IX Address of the fire object
  $B80F,$03 Set the pixel adjustments of a ball.
  $B812,$04 Set the speed in Z to #N($01), so that the fire does not fall.
  $B816,$04 Test whether the fire is heading north.
  $B81A,$02 Set the speed to #N$02.
  $B81C,$02 Jump to #R$B820 if it is.
  $B81E,$02 Make the speed negative.
@ $B820 label=HandleFireMovingNorthSouth_Speed
  $B820,$03 Set the speed in Y of the fire.
  $B823,$03 Play the sound of a block moving along the Y axis.
  $B826,$03 Apply gravity to the fire and move it.
  $B829,$04 Test whether the fire has hit something along the Y axis.
  $B82D,$02 Set the direction bit to flip to bit 1.
N $B82F Turn the fire round if it hit something.
@ $B82F label=HandleFire_Turn
  $B82F,$02 Jump to #R$B83A if the fire did not hit anything.
  $B831,$03 Flip the direction of the fire.
  $B834,$03 Store the direction.
  $B837,$03 Play the sound of a bounce.
@ $B83A label=HandleFire_Draw
  $B83A,$03 Toggle the graphic of the fire between its two frames.
  $B83D,$02 Jump to #R$B856.

c $B83F Handle Stationary Fire
@ $B83F label=HandleStationaryFire
D $B83F Handles a fire that stays where it is, flickering by changing frame and
. mirroring itself on every other pass. No fire like this appears in the game.
R $B83F IX Address of the fire object
N $B83F Flicker the fire on every other pass.
  $B83F,$03 Set the pixel adjustments of a ball.
  $B842,$03 Fetch the fire seed from #R$5BBC.
  $B845,$02,b$01 Test the lowest bit.
  $B847,$01 Return on every other pass.
  $B848,$03 Fetch the second random seed from #R$5BA5.
  $B84B,$02,b$01 Keep the bit that flips the sprite.
  $B84D,$03 Combine it with the flags of the object.
  $B850,$03 Store the flags, which makes the fire flip at random.
  $B853,$03 Toggle the graphic of the fire between its two frames.

c $B856 Set Deadly Flags And Draw
@ $B856 label=SetDeadlyFlagsAndDraw
D $B856 Makes the object deadly and flags it to be wiped and drawn again.
R $B856 IX Address of the object
  $B856,$03 Make the object deadly.
  $B859,$03 Flag the object to be drawn again.

c $B85C Set Deadly Flags
@ $B85C label=SetDeadlyFlags
D $B85C Makes an object deadly, so that the player dies if it touches the object
. or if the object touches the player.
E $B85C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B2A7 }
. { #PENTAGRAM$C291 }
. LIST#
R $B85C IX Address of the object
  $B85C,$03 Fetch the flags that go with the object.
  $B85F,$02,b$01 Set the bits that make the object fatal for the player to hit
. and for it to hit the player.
  $B861,$03 Store the flags.
  $B864,$01 Return.

c $B865 Handle Ball Up Down
@ $B865 label=HandleBallUpDown
D $B865 Handles a ball that bounces straight up and down. It falls until it hits
. the floor, then it rises at a speed of #N$03 until it reaches the top of its
. bounce, which is #N$20 above the height at which it was first seen, and starts
. to fall again.
R $B865 IX Address of the ball object
N $B865 Work out the top of the bounce if it is not already stored.
  $B865,$03 Set the pixel adjustments of a ball.
  $B868,$03 Fetch the height of the bounce from #R$5BBD.
  $B86B,$01 Test whether it has been worked out.
  $B86C,$02 Jump to #R$B876 if it has.
  $B86E,$03 Fetch the height of the ball.
  $B871,$02 Add #N$20 to get the height of the bounce.
  $B873,$03 Store it at #R$5BBD.
@ $B876 label=HandleBallUpDown_Frame
N $B876 Fall until the ball hits the floor, then rise.
  $B876,$03 Toggle the graphic of the ball between its two frames.
  $B879,$03 Play the sound of a falling object.
  $B87C,$06 Jump to #R$B894 if the ball is rising.
  $B882,$03 Apply gravity to the ball and move it.
  $B885,$06 Jump to #R$B892 if the ball has not hit the floor.
  $B88B,$04 Flag the ball as rising.
  $B88F,$03 Play the sound of a bounce.
@ $B892 label=HandleBallUpDown_Draw
  $B892,$02 Make the ball deadly and flag it to be drawn again.
@ $B894 label=HandleBallUpDown_Rise
  $B894,$04 Set the speed in Z to #N$03.
  $B898,$03 Move the ball.
  $B89B,$03 Fetch the height of the bounce from #R$5BBD.
  $B89E,$03 Compare it with the height of the ball.
  $B8A1,$02 Jump to #R$B892 if the ball is still below the top of the bounce.
  $B8A3,$04 Flag the ball as falling.
  $B8A7,$02 Jump to #R$B892.

c $B8A9 Spawn Cauldron Bubbles
@ $B8A9 label=SpawnCauldronBubbles
D $B8A9 Starts the bubbles that rise out of the cauldron. Nothing happens unless
. the player is in the cauldron room, the second slot for special objects is
. empty and the final animation is not under way. The bubbles are copied into
. the slot from #R$B8C8.
N $B8A9 Copy the bubbles into the empty special-object slot.
  $B8A9,$03 Fetch the room that the player is in.
  $B8AC,$02 Compare it with the number of the cauldron room.
  $B8AE,$01 Return if the player is in another room.
  $B8AF,$03 Point #REGde at #R$5C68.
  $B8B2,$01 Fetch the graphic number of the object.
  $B8B3,$01 Test whether the slot is empty.
  $B8B4,$01 Return if it is in use.
  $B8B5,$03 Fetch the flag that is set when the final animation starts from
. #R$5BC3.
  $B8B8,$01 Test it.
  $B8B9,$01 Return if the final animation has started.
  $B8BA,$03 Point #REGhl at #R$B8C8.
  $B8BD,$03 Set the number of bytes to copy to #N$12.
  $B8C0,$03 Copy #REGde to #REGix (using the stack).
  $B8C3,$02 Copy the bubbles into the slot.
  $B8C5,$03 Set the pixel adjustments of a sparkle.

b $B8C8 Cauldron Bubbles
@ $B8C8 label=CauldronBubbles
D $B8C8 The first #N$12 bytes of the object that is copied into the table of
. special objects by #R$B8A9.
B $B8C8,$01,$01 Graphic number.
B $B8C9,$01,$01 X coordinate.
B $B8CA,$01,$01 Y coordinate.
B $B8CB,$01,$01 Z coordinate.
B $B8CC,$01,$01 Width.
B $B8CD,$01,$01 Depth.
B $B8CE,$01,$01 Height.
B $B8CF,$01,$01 Flags.
B $B8D0,$01,$01 Room number.
B $B8D1,$04,$04 Speeds in X, Y and Z, and the counter.
B $B8D5,$01,$01 Flags that tell how deadly the object is.
B $B8D6,$04,$04 Adjustments to the speeds and the address of the table entry
. (unused).

c $B8DA Handle Cauldron Bubbles
@ $B8DA label=HandleCauldronBubbles
D $B8DA Handles the bubbles that rise from the cauldron. They are replaced by
. the object that is needed next, shown once in four frames, when they are at
. the top, unless the player is Wulf, when they turn into the spell that repels
. him. The bubbles vanish once a special object appears in the first slot.
R $B8DA IX Address of the bubbles object
N $B8DA Rise and show the next required object, or the repel spell.
  $B8DA,$03 Set the pixel adjustments of a sparkle.
  $B8DD,$03 Fetch the graphic number of the first special object of the room
. from #R$5C48.
  $B8E0,$01 Test whether the slot is empty.
  $B8E1,$03 Jump to #R$B95E if the slot is in use, to remove the bubbles.
  $B8E4,$04 Flag the bubbles to be ignored in the 3D calculations.
  $B8E8,$03 Apply gravity to the bubbles and move them.
  $B8EB,$03 Change to the next graphic of the bubbles.
  $B8EE,$03 Fetch the Z coordinate of the bubbles.
  $B8F1,$02 Compare it with #N$A0.
  $B8F3,$04 Set the speed in Z to #N$02.
  $B8F7,$02 Jump to #R$B916 if the bubbles have not reached the top.
  $B8F9,$04 Set the speed in Z to #N$01.
  $B8FD,$03 Fetch the graphic number of the legs of the player from #R$5C08.
  $B900,$02 Take off the first graphic number of Wulf.
  $B902,$04 Jump to #R$B919 if the player is Wulf.
  $B906,$03 Fetch the graphic number of the bubbles.
  $B909,$02,b$01 Keep the frame of the animation.
  $B90B,$02 Jump to #R$B916 if it is not the first frame.
  $B90D,$03 Find the next object that is needed.
  $B910,$01 Fetch its graphic number.
  $B911,$02,b$01 Make it the graphic number of the object that shows through the
. bubbles.
  $B913,$03 Store the graphic number.
@ $B916 label=HandleCauldronBubbles_Draw
N $B916 Flag the bubbles to be redrawn.
  $B916,$03 Flag the bubbles to be drawn again.
@ $B919 label=HandleCauldronBubbles_Repel
N $B919 Turn the bubbles into the spell that repels Wulf.
  $B919,$04 Turn the bubbles into the spell that repels Wulf.
  $B91D,$04 Make the spell take part in the 3D calculations.
  $B921,$02 Jump to #R$B916.

c $B923 Handle Special Object In Cauldron
@ $B923 label=HandleSpecialObjectInCauldron
D $B923 Handles the graphics #N$A8 to #N($AF), which show the object that is
. needed next above the cauldron. The object lasts for a single frame, as it is
. changed back to the bubbles.
R $B923 IX Address of the object
  $B923,$03 Set the pixel adjustments of a sparkle.
  $B926,$04 Change the graphic of the object to the bubbles.
  $B92A,$02 Jump to #R$B916.

c $B92C Handle Repel Spell
@ $B92C label=HandleRepelSpell
D $B92C Handles the spell that chases Wulf in the cauldron room and repels him.
. It moves towards the player, and it moves slowly if the player is near an
. arch. In the cauldron room it vanishes when the graphic number of the legs of
. the player is not in the range #N$10 to #N$4F.
R $B92C IX Address of the spell object
  $B92C,$03 Set the pixel adjustments of a sparkle.
  $B92F,$03 Fetch the room that the spell is in.
  $B932,$04 Jump to #R$B942 if the spell is in the cauldron room.
  $B936,$03 Fetch the flags of the player.
  $B939,$04 Jump to #R$B942 if the player is not.
  $B93D,$03 Set the speeds in X and Y to #N$01.
  $B940,$02 Jump to #R$B945.
@ $B942 label=HandleRepelSpell_Fast
  $B942,$03 Set the speeds in X and Y to #N$04.
@ $B945 label=HandleRepelSpell_Move
  $B945,$03 Set the speeds of the spell to take it towards the player.
  $B948,$03 Apply gravity to the spell and move it.
  $B94B,$03 Change to the next graphic of the spell.
  $B94E,$03 Fetch the room that the spell is in.
  $B951,$04 Jump to #R$B962 if the spell is not in the cauldron room.
  $B955,$03 Fetch the graphic number of the legs of the player from #R$5C08.
  $B958,$02 Take off #N$10.
  $B95A,$04 Jump to #R$B962 if the graphic number of the player is in the range.
@ $B95E label=HandleRepelSpell_Vanish
N $B95E Remove the object, by changing it to a graphic that is not shown.
  $B95E,$04 Change the graphic of the object to #N$01.
@ $B962 label=HandleRepelSpell_Update
  $B962,$03 Update the object.

c $B965 Set Speed Towards Player
@ $B965 label=SetSpeedTowardsPlayer
D $B965 Sets the speeds of an object so that it moves towards the player.
E $B965 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B165 }
. LIST#
R $B965 B Speed in Y
R $B965 C Speed in X
R $B965 IX Address of the object
N $B965 Set the X speed towards the player, then the Y speed.
  $B965,$03 Point #REGhl at the X coordinate of the player.
  $B968,$03 Fetch the X coordinate of the object.
  $B96B,$01 Subtract the X coordinate of the player.
  $B96C,$01 Point #REGhl at the Y coordinate of the player.
  $B96D,$01 Fetch the speed in X.
  $B96E,$03 Jump to #R$B973 if the object is on the west side of the player.
  $B971,$02 Make the speed negative.
@ $B973 label=SetSpeedTowardsPlayer_SetX
  $B973,$03 Set the speed in X of the object.
  $B976,$03 Fetch the Y coordinate of the object.
  $B979,$01 Subtract the Y coordinate of the player.
  $B97A,$01 Point #REGhl at the Z coordinate of the player.
  $B97B,$01 Fetch the speed in Y.
  $B97C,$03 Jump to #R$B981 if the object is on the south side of the player.
  $B97F,$02 Make the speed negative.
@ $B981 label=SetSpeedTowardsPlayer_SetY
  $B981,$03 Set the speed in Y of the object.
  $B984,$01 Return.

c $B985 Toggle Graphic
@ $B985 label=ToggleGraphic
D $B985 Changes the graphic of an object between the two graphics of a pair, by
. flipping the lowest bit of the graphic number.
R $B985 IX Address of the object
  $B985,$03 Fetch the graphic number.
  $B988,$02,b$01 Flip the lowest bit.
  $B98A,$02 Jump to #R$B998.

c $B98C Next Sprite Number
@ $B98C label=NextSpriteNumber
D $B98C Changes the graphic of an object to the next of a group of four, by
. adding one to the lowest two bits of the graphic number and ignoring the
. carry.
E $B98C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B18C }
. { #GUNFRIGHT$CCAE }
. { #NIGHTSHADE$CEF8 }
. LIST#
R $B98C IX Address of the object
N $B98C Advance the lowest two bits of the graphic number.
  $B98C,$03 Fetch the graphic number.
  $B98F,$01 Stash it in #REGc.
  $B990,$02,b$01 Keep the highest six bits.
  $B992,$01 Stash them in #REGb.
  $B993,$01 Fetch the graphic number.
  $B994,$01 Add one.
  $B995,$02,b$01 Keep the lowest two bits.
  $B997,$01 Combine them with the highest six bits.
@ $B998 label=SetGraphic
  $B998,$03 Store the new graphic number.
  $B99B,$01 Return.

c $B99C Handle Cauldron Bottom
@ $B99C label=HandleCauldronBottom
D $B99C Handles the bottom half of the cauldron.
R $B99C IX Address of the object
  $B99C,$03 Set the pixel adjustments of the cauldron and update it.

c $B99F Handle Cauldron Top
@ $B99F label=HandleCauldronTop
D $B99F Handles the top half of the cauldron, which is drawn #N$18 pixels to the
. left of and #N$0C pixels above where it is.
R $B99F IX Address of the object
  $B99F,$03 Set the pixel adjustments of #N$18 to the left and #N$0C up.
  $B9A2,$03 Apply them and update the object.

c $B9A5 Handle Guard Or Wizard
@ $B9A5 label=HandleGuardOrWizard
D $B9A5 Handles the top half of a guard or of the wizard, who patrol round the
. room, following the walls. The bottom half is the next object in the table and
. it is moved with the top half.
R $B9A5 IX Address of the top half of the guard
N $B9A5 Move the guard and keep the bottom half in step.
  $B9A5,$03 Set the pixel adjustments of a guard.
  $B9A8,$03 Apply gravity to the guard and move it.
  $B9AB,$03 Work out the speeds of the guard from its direction.
  $B9AE,$03 Set the speed in X of the guard.
  $B9B1,$03 Set the speed in X of the bottom half.
  $B9B4,$03 Set the speed in Y of the guard.
  $B9B7,$03 Set the speed in Y of the bottom half.
  $B9BA,$03 Fetch the X coordinate of the guard.
  $B9BD,$03 Set the X coordinate of the bottom half.
  $B9C0,$03 Fetch the Y coordinate of the guard.
  $B9C3,$03 Set the Y coordinate of the bottom half.
  $B9C6,$03 Choose the graphic of the guard from its direction.
  $B9C9,$03 Make the guard deadly and flag it to be drawn again.

c $B9CC Get Guard Speeds
@ $B9CC label=GetGuardSpeeds
D $B9CC Works out the speeds that make a guard follow the wall of the room,
. using the direction in the two lowest bits of its flags: #N$00 is west, #N$01
. is north, #N$02 is east and #N$03 is south.
R $B9CC IX Address of the guard
R $B9CC O:H Speed in Y
R $B9CC O:L Speed in X
  $B9CC,$03 Point #REGbc at the table of routines, #R$B9D8.
  $B9CF,$03 Fetch the direction flags of the guard.
  $B9D2,$02,b$01 Keep the direction.
  $B9D4,$01 Use it as the number of the routine.
  $B9D5,$03 Jump to the routine.

w $B9D8 Guard Direction Table
@ $B9D8 label=GuardDirectionTable
D $B9D8 The routines that give the speeds of a guard heading in each direction.
W $B9D8,$02,$02 West: #R$B9E0.
W $B9DA,$02,$02 North: #R$B9FB.
W $B9DC,$02,$02 East: #R$BA08.
W $B9DE,$02,$02 South: #R$BA15.

c $B9E0 Guard Heading West
@ $B9E0 label=GuardHeadingWest
D $B9E0 Keeps a guard heading west, at a speed of #N($02), until it hits
. something. It then turns north.
R $B9E0 IX Address of the guard
R $B9E0 O:H Speed in Y
R $B9E0 O:L Speed in X
  $B9E0,$03 Set the speed in X to #N$FE and the speed in Y to #N$00.
  $B9E3,$04 Test whether the guard has hit something along the X axis.
  $B9E7,$01 Return if it has not.
  $B9E8,$03 Set the speed in X to #N$00 and the speed in Y to #N$02.
@ $B9EB label=TurnGuard
N $B9EB Turn the guard, to follow the wall.
  $B9EB,$03 Fetch the direction flags of the guard.
  $B9EE,$01 Stash them in #REGc.
  $B9EF,$01 Move to the next direction.
  $B9F0,$02,b$01 Keep the direction.
  $B9F2,$01 Stash it in #REGb.
  $B9F3,$01 Fetch the direction flags.
  $B9F4,$02,b$01 Keep the other flags.
  $B9F6,$01 Combine them with the new direction.
  $B9F7,$03 Store the flags.
  $B9FA,$01 Return.

c $B9FB Guard Heading North
@ $B9FB label=GuardHeadingNorth
D $B9FB Keeps a guard heading north, at a speed of #N($02), until it hits
. something. It then turns east.
R $B9FB IX Address of the guard
R $B9FB O:H Speed in Y
R $B9FB O:L Speed in X
  $B9FB,$03 Set the speed in X to #N$00 and the speed in Y to #N$02.
  $B9FE,$04 Test whether the guard has hit something along the Y axis.
  $BA02,$01 Return if it has not.
  $BA03,$03 Set the speed in X to #N$02 and the speed in Y to #N$00.
  $BA06,$02 Jump to #R$B9EB to turn the guard.

c $BA08 Guard Heading East
@ $BA08 label=GuardHeadingEast
D $BA08 Keeps a guard heading east, at a speed of #N($02), until it hits
. something. It then turns south.
R $BA08 IX Address of the guard
R $BA08 O:H Speed in Y
R $BA08 O:L Speed in X
  $BA08,$03 Set the speed in X to #N$02 and the speed in Y to #N$00.
  $BA0B,$04 Test whether the guard has hit something along the X axis.
  $BA0F,$01 Return if it has not.
  $BA10,$03 Set the speed in X to #N$00 and the speed in Y to #N$FE.
  $BA13,$02 Jump to #R$B9EB to turn the guard.

c $BA15 Guard Heading South
@ $BA15 label=GuardHeadingSouth
D $BA15 Keeps a guard heading south, at a speed of #N($02), until it hits
. something. It then turns west.
R $BA15 IX Address of the guard
R $BA15 O:H Speed in Y
R $BA15 O:L Speed in X
  $BA15,$03 Set the speed in X to #N$00 and the speed in Y to #N$FE.
  $BA18,$04 Test whether the guard has hit something along the Y axis.
  $BA1C,$01 Return if it has not.
  $BA1D,$03 Set the speed in X to #N$FE and the speed in Y to #N$00.
  $BA20,$02 Jump to #R$B9EB to turn the guard.

c $BA22 Game Over
@ $BA22 label=GameOver
D $BA22 Ends the game, whether the player has run out of lives, the forty days
. have passed or the final sparkles have caught the player. If the game was
. completed, the message of the potion is shown first. The results screen shows
. the days that have passed, the percentage of the quest that was completed, the
. number of charms collected and a rating. The game then returns to the menu
. when a key is pressed.
.
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
.
. #PUSHS #UDGTABLE { =h Game over screen }
. { #SIM(start=$AF6C,stop=$AFA2,sp=$5BA0,clear=1)
. #SIM(start=$BD0C,stop=$BD23)
. #SIM(start=$AFAB,stop=$B02F,sp=$5BA0)
. #SIM(start=$B03F,stop=$B06E)
. #SIM(start=$BA22,stop=$BA87,sp=$5BA0)
. #SCR$02(game-over) } UDGTABLE# #POPS
  $BA22,$03 Fetch the flag that is set when the game has been completed from
. #R$5BC3.
  $BA25,$01 Test it.
  $BA26,$03 Show the message of the potion first if the game has been completed.
@ $BA29 label=GameOver_ShowResults
N $BA29 Show the results screen.
  $BA29,$03 Clear the screen buffer.
  $BA2C,$03 Clear the screen and make the border black.
  $BA2F,$03 Point #REGde at #R$BB4C.
  $BA32,$01 Switch to the alternate registers to keep it there.
  $BA33,$03 Point #REGhl at #R$BB52.
  $BA36,$03 Point #REGde at #R$BB5E.
  $BA39,$02 Set the number of lines of text to #N$06.
  $BA3B,$03 Print the lines of text.
  $BA3E,$03 Point #REGhl at #R$E8E2.
  $BA41,$03 Point #REGde at #R$5BB9.
  $BA44,$02 Set the number of bytes to print to #N$01.
  $BA46,$03 Print the number of days.
  $BA49,$03 Print the percentage of the quest that was completed.
N $BA4C Work out the rating from the number of rooms visited and from whether
. the game was completed.
  $BA4C,$03 Fetch the number of rooms visited, less one from #R$5BC6.
  $BA4F,$01 Rotate the highest bit round to the lowest.
  $BA50,$02,b$01 Keep the next two highest bits (the number of rooms divided by
. #N$20).
  $BA52,$01 Stash them in #REGc.
  $BA53,$03 Fetch the flag that is set when the game has been completed from
. #R$5BC3.
  $BA56,$02,b$01 Keep only the lowest bit.
  $BA58,$01 Combine it with the number of rooms.
  $BA59,$03 Rotate the bits into place to make the number of a word.
  $BA5C,$02,b$01 Keep the bits of the number of the word.
  $BA5E,$03 Set #REGhl to the number of bytes into the table of ratings.
  $BA61,$03 Point #REGbc at #R$BBB7.
  $BA64,$01 Point #REGhl at the entry for the rating.
  $BA65,$01 Fetch the low byte of the address of the text of the rating.
  $BA66,$01 Move on to the high byte.
  $BA67,$01 Fetch the high byte.
  $BA68,$03 Set #REGhl to the position of the rating.
  $BA6B,$03 Print the rating.
N $BA6E Print the number of charms collected, which is the number of objects
. that were put into the cauldron.
  $BA6E,$03 Point #REGde at #R$5BBB.
  $BA71,$01 Fetch the number of charms.
  $BA72,$02 Take off #N$0A to see if the number is in double digits.
  $BA74,$02 Jump to #R$BA79 if it is not.
  $BA76,$02,b$01 Convert it to a BCD number between #N$10 and #N$14.
  $BA78,$01 Store the BCD number.
@ $BA79 label=GameOver_PrintCharms
  $BA79,$03 Point #REGhl at the position of the charms in the screen buffer,
. #R$E2EA.
  $BA7C,$02 Set the number of bytes to print to #N$01.
  $BA7E,$03 Print the number of charms collected.
  $BA81,$03 Draw the border.
  $BA84,$03 Copy the screen buffer to the display.
@ $BA87 label=GameOver_WaitForKeyRelease
N $BA87 Play the tune, wait for a key to be pressed and then go back to the
. menu.
  $BA87,$01 Select all the half-rows of the keyboard.
  $BA88,$03 Read the keyboard.
  $BA8B,$02 Jump to #R$BA87 until all the keys are released.
  $BA8D,$03 Point #REGde at #R$B218.
  $BA90,$03 Play the tune, until a key is pressed.
  $BA93,$02 Set the number of times to wait to #N$08.
  $BA95,$03 Wait for a key to be pressed, up to a limit.
  $BA98,$03 Go back to the menu, to start another game.

c $BA9B Wait For Key Press
@ $BA9B label=WaitForKeyPress
D $BA9B Waits until any key is pressed or until a time limit passes. The time is
. #REGb times the time that it takes to count #N$FFFF down to zero.
E $BA9B View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B899 }
. LIST#
R $BA9B B Number of times to count down
R $BA9B O:F Zero flag clear if a key was pressed
N $BA9B Wait for a key, or count down #N$10000 times.
  $BA9B,$03 Set the counter to zero, to count #N$10000 times.
@ $BA9E label=WaitForKeyPress_Wait
  $BA9E,$01 Select all the half-rows of the keyboard.
  $BA9F,$03 Read the keyboard.
  $BAA2,$01 Return if a key is pressed.
  $BAA3,$01 Decrease the counter.
  $BAA4,$02 Check whether the counter has reached zero.
  $BAA6,$02 Jump to #R$BA9E until the counter is zero.
  $BAA8,$02 Jump to #R$BA9E until the time limit has passed.
  $BAAA,$01 Return.

c $BAAB Game Completed
@ $BAAB label=GameCompleted
D $BAAB Shows the message of the potion that is given when the player has
. completed the game, while the game complete tune plays, and then goes on to
. show the results.
E $BAAB View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B8A9 }
. LIST#
.
. #HTML(#AUDIO0(game-complete-tune.wav)(#INCLUDE(GameCompleteTune)))
.
. #PUSHS #UDGTABLE { =h Game complete message }
. { #SIM(start=$AF6C,stop=$AFA2,sp=$5BA0,clear=1)
. #SIM(start=$BD0C,stop=$BD23)
. #SIM(start=$BAAB,stop=$BAC4,sp=$5BA0)
. #SCR$02(game-completed) } UDGTABLE# #POPS
N $BAAB Show the game completed message.
  $BAAB,$03 Clear the screen buffer.
  $BAAE,$03 Clear the screen and make the border black.
  $BAB1,$03 Point #REGde at #R$BAD2.
  $BAB4,$01 Switch to the alternate registers to keep it there.
  $BAB5,$03 Point #REGhl at #R$BAD8.
  $BAB8,$03 Point #REGde at #R$BAE4.
  $BABB,$02 Set the number of lines of text to #N$06.
  $BABD,$01 Clear #REGa.
  $BABE,$03 Flag that the border has to be drawn at #R$5BB8.
  $BAC1,$03 Print the lines of text.
N $BAC4 Play the tune and wait for a key to be pressed.
  $BAC4,$03 Point #REGde at #R$B239.
  $BAC7,$03 Play the tune.
  $BACA,$02 Set the number of times to wait to #N$08.
  $BACC,$03 Wait for a key to be pressed, up to a limit.
  $BACF,$03 Jump to #R$BA29 to show the results screen.

b $BAD2 Game Complete Colours
@ $BAD2 label=GameCompleteColours
D $BAD2 The attributes of the six lines of the message that is shown when the
. game has been completed.
B $BAD2,$01 #COLOUR(#PEEK(#PC)).
L $BAD2,$01,$06

b $BAD8 Game Complete Coordinates
@ $BAD8 label=GameCompleteCoordinates
D $BAD8 The X and Y coordinates of the six lines of the message that is shown
. when the game has been completed.
B $BAD8,$0C,$02 One pair for each line.

b $BAE4 Game Complete Text
@ $BAE4 label=GameCompleteText
D $BAE4 The six lines of the message that is shown when the game has been
. completed. Each character is stored as its number in the font at #R$6108:
. #N$00 to #N$09 are the digits, #N$0A to #N$23 are the letters, #N$26 is a
. space and #N$27 is a percent sign. Bit 7 of the last character of each line is
. set.
B $BAE4,$10,$08 "THE POTION CASTS"
B $BAF4,$10,$08 "ITS MAGIC STRONG"
B $BB04,$14,$08 "ALL EVIL MUST BEWARE"
B $BB18,$14,$08 "THE SPELL HAS BROKEN"
B $BB2C,$0C,$08 "YOU ARE FREE"
B $BB38,$14,$08 "GO FORTH TO MIREMARE"

b $BB4C Game Over Colours
@ $BB4C label=GameOverColours
D $BB4C The attributes of the six lines of the results screen.
B $BB4C,$01 #COLOUR(#PEEK(#PC)).
L $BB4C,$01,$06

b $BB52 Game Over Coordinates
@ $BB52 label=GameOverCoordinates
D $BB52 The X and Y coordinates of the six lines of the results screen.
B $BB52,$0C,$02 One pair for each line.

b $BB5E Game Over Text
@ $BB5E label=GameOverText
D $BB5E The six lines of the results screen, in the same format as #R$BAE4. The
. numbers of days, percent and charms that go with the lines are printed
. separately, by #R$BA22.
B $BB5E,$0A,$08 "GAME OVER"
B $BB68,$0C,$08 "TIME DAYS"
B $BB74,$13,$08 "PERCENTAGE OF QUEST"
B $BB87,$0F,$08 "COMPLETED %"
B $BB96,$13,$08 "CHARMS COLLECTED "
B $BBA9,$0E,$08 "OVERALL RATING"

w $BBB7 Rating Table
@ $BBB7 label=RatingTable
D $BBB7 The addresses of the eight ratings that can be given on the results
. screen. The rating is chosen by the number of rooms that have been visited (in
. steps of #N$20) and by whether the game was completed. A completed game always
. gets at least the fifth rating.
W $BBB7,$02,$02 Fewer than #N$21 rooms visited: #R$BBC7.
W $BBB9,$02,$02 #N$21 to #N$40 rooms visited: #R$BBCF.
W $BBBB,$02,$02 #N$41 to #N$60 rooms visited: #R$BBD8.
W $BBBD,$02,$02 More than #N$60 rooms visited: #R$BBE0.
W $BBBF,$02,$02 Game completed, with fewer than #N$21 rooms visited: #R$BBE8.
W $BBC1,$02,$02 Game completed, with #N$21 to #N$40 rooms visited: #R$BBF2.
W $BBC3,$02,$02 Game completed, with #N$41 to #N$60 rooms visited: #R$BBFD.
W $BBC5,$02,$02 Game completed, with more than #N$60 rooms visited: #R$BC05.

b $BBC7 Rating Text
@ $BBC7 label=RatingText
D $BBC7 The text of the eight ratings, in the same format as #R$BAE4, except
. that each one starts with an attribute (bright red) and is padded with spaces.
B $BBC7,$08,$08 Bright red, " POOR"
@ $BBCF label=RatingText_Average
B $BBCF,$09,$09 Bright red, " AVERAGE"
@ $BBD8 label=RatingText_Fair
B $BBD8,$08,$08 Bright red, " FAIR"
@ $BBE0 label=RatingText_Good
B $BBE0,$08,$08 Bright red, " GOOD"
@ $BBE8 label=RatingText_Excellent
B $BBE8,$0A,$0A Bright red, "EXCELLENT"
@ $BBF2 label=RatingText_Marvellous
B $BBF2,$0B,$0B Bright red, "MARVELLOUS"
@ $BBFD label=RatingText_Hero
B $BBFD,$08,$08 Bright red, " HERO"
@ $BC05 label=RatingText_Adventurer
B $BC05,$0B,$0B Bright red, "ADVENTURER"

c $BC10 Print Percentage Complete
@ $BC10 label=PrintPercentageComplete
D $BC10 Works out how much of the quest has been completed and prints the
. percentage in the screen buffer. Each room that has been visited counts for
. one point and each charm that has been put in the cauldron counts for two. The
. most that can be scored is #N$9C points (#N$80 rooms and #N$0E charms counted
. twice), so each point is worth about 0.64 percent. The percentage is worked
. out as a BCD number and is printed with the hundreds digit only if the quest
. has been completed in full.
  $BC10,$02 Set the count of rooms to zero.
  $BC12,$03 Set #REGb to the number of bits in a byte and #REGc to the number of
. bytes of flags.
  $BC15,$03 Point #REGhl at the flags for the rooms that have been visited,
. #R$5BE8.
@ $BC18 label=PrintPercentageComplete_CountByte
  $BC18,$01 Stash the counters on the stack.
  $BC19,$01 Fetch a byte of flags.
  $BC1A,$01 Move on to the next byte.
@ $BC1B label=PrintPercentageComplete_CountBit
  $BC1B,$01 Move a flag into the carry flag.
  $BC1C,$02 Jump to #R$BC1F if the room has not been visited.
  $BC1E,$01 Count the room.
@ $BC1F label=PrintPercentageComplete_NextBit
  $BC1F,$02 Jump to #R$BC1B until the whole byte has been counted.
  $BC21,$01 Restore the counters from the stack.
  $BC22,$01 Decrease the number of bytes left.
  $BC23,$02 Jump to #R$BC18 until all of the bytes have been counted.
N $BC25 Keep the number of rooms visited for the rating, and work out the number
. of points.
  $BC25,$01 Fetch the number of rooms visited.
  $BC26,$01 Take off one, so that the first room does not count towards the
. rating.
  $BC27,$03 Store it for the rating at #R$5BC6.
  $BC2A,$03 Fetch the number of charms collected from #R$5BBB.
  $BC2D,$02 Double it.
  $BC2F,$01 Add the number of rooms visited.
  $BC30,$01 Stash the number of points in #REGe.
N $BC31 Add up the percentage as a BCD number. The percentage that each point is
. worth is the 16-bit fraction #N$A41A (about 0.64 percent).
  $BC31,$03 Set #REGbc to the percentage that each point is worth.
  $BC34,$03 Clear the fraction of the percentage.
  $BC37,$01 Clear the whole percentage.
@ $BC38 label=PrintPercentageComplete_AddPoint
  $BC38,$01 Add the percentage for a point to the fraction.
  $BC39,$02 Carry into the whole percentage.
  $BC3B,$01 Keep the whole percentage as a BCD number.
  $BC3C,$01 Decrease the number of points left.
  $BC3D,$02 Jump to #R$BC38 until every point has been added.
  $BC3F,$03 Set #REGbc to the amount that makes up for the rounding. The 24-bit
. total for all of the points is #N$63FF in the high word and #N$D8 in
. the low byte, and this takes it up to #N$6400 in the high word.
  $BC42,$01 Add it to the fraction.
  $BC43,$02 Carry into the whole percentage.
  $BC45,$01 Keep the whole percentage as a BCD number.
  $BC46,$03 Store the lowest two digits of the percentage.
  $BC49,$02 Clear #REGa without changing the carry flag.
  $BC4B,$02 Carry into the hundreds digit.
  $BC4D,$01 Keep the hundreds digit as a BCD number.
  $BC4E,$03 Store the hundreds digit at #R$5BC9.
N $BC51 Print the digits.
  $BC51,$03 Point #REGhl at #R$E4E6.
  $BC54,$03 Point #REGde at #R$5BC9.
  $BC57,$02 Set the number of bytes to print to #N$01.
  $BC59,$01 Fetch the hundreds digit.
  $BC5A,$01 Test whether it is zero.
  $BC5B,$02 Jump to #R$BC61 if the quest is not complete.
  $BC5D,$01 Set the number of bytes to print to #N$02.
  $BC5E,$03 Jump to #R$BCC0 to print the hundreds digit and then the rest.
@ $BC61 label=PrintPercentageComplete_TwoDigits
  $BC61,$01 Move the position past the space for the hundreds digit.
  $BC62,$01 Move on to the lowest two digits.
  $BC63,$03 Jump to #R$BCAE to print them.

c $BC66 Print Days
@ $BC66 label=PrintDays
D $BC66 Prints the number of days that have passed on the panel, and makes the
. attributes there bright white.
N $BC66 Print the days and make their attributes bright white.
  $BC66,$03 Point #REGhl at the position of the days in the screen buffer,
. #R$D9E2.
  $BC69,$03 Point #REGde at #R$5BB9.
  $BC6C,$02 Set the number of bytes to print to #N$01.
  $BC6E,$03 Print the number of days.
  $BC71,$03 Point #REGhl at the attributes of the days.
  $BC74,$02 Make the first one bright white.
  $BC76,$01 Move on to the next one.
  $BC77,$02 Make it bright white as well.
  $BC79,$01 Return.

c $BC7A Print Lives Graphic
@ $BC7A label=PrintLivesGraphic
D $BC7A Draws the graphic that goes next to the number of lives on the panel,
. and makes the attributes there bright white.
N $BC7A Draw the lives graphic and colour its attributes.
  $BC7A,$04 Point #REGix at the object that is used to draw the panel, #R$BFDB.
  $BC7E,$04 Set the graphic number to #N$8C.
  $BC82,$04 Clear the flags.
  $BC86,$04 Set the pixel X coordinate to #N$10.
  $BC8A,$04 Set the pixel Y coordinate to #N$20.
  $BC8E,$03 Draw the graphic.
  $BC91,$02 Set the attribute to bright white.
  $BC93,$03 Point #REGde at the attributes of the first row.
  $BC96,$02 Set the number of attributes to #N$02.
  $BC98,$03 Fill the attributes.
  $BC9B,$03 Point #REGde at the attributes of the second row.
  $BC9E,$02 Set the number of attributes to #N$04.
  $BCA0,$03 Fill the attributes.

c $BCA3 Print Lives
@ $BCA3 label=PrintLives
D $BCA3 Prints the number of lives that the player has left on the panel.
E $BCA3 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BA57 }
. LIST#
  $BCA3,$03 Point #REGde at the number of lives, #R$5BBA.
  $BCA6,$02 Set the number of bytes to print to #N$01.
  $BCA8,$03 Point #REGhl at #R$DDD7.
  $BCAB,$03 Print the number of lives.

c $BCAE Print BCD Number
@ $BCAE label=PrintBCDNumber
D $BCAE Prints a number which is held in
. BCD, using the font with the digits.
. Every digit is printed, including
. leading zeroes.
E $BCAE View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BA62 }
. { #NIGHTSHADE$C314 }
. { #PENTAGRAM$BB48 }
. LIST#
R $BCAE B Number of bytes
R $BCAE DE Address of the number
R $BCAE HL Address in the screen buffer
N $BCAE Point at the digit font.
  $BCAE,$01 Stash the screen buffer address on
. the stack.
  $BCAF,$06 Set #R$5BC7 to #R$6108.
  $BCB5,$01 Restore the screen buffer address from the stack.
N $BCB6 Print the upper digit of the byte.
@ $BCB6 label=PrintBCDNumber_NextByte
  $BCB6,$01 Fetch a byte of the number.
  $BCB7,$04 Move the upper digit to the lowest
. four bits.
  $BCBB,$02,b$01 Keep only bits 0 to 3.
  $BCBD,$03 Call #R$BE7F.
N $BCC0 Print the lower digit and move on.
@ $BCC0 label=PrintBCDNumber_SecondDigit
  $BCC0,$01 Fetch a byte of the number.
  $BCC1,$02,b$01 Keep only bits 0 to 3.
  $BCC3,$03 Call #R$BE7F.
  $BCC6,$01 Move on to the next byte.
  $BCC7,$02 Jump to #R$BCB6 until all of the
. bytes have been printed.
  $BCC9,$01 Return.

c $BCCA Print Day Caption
@ $BCCA label=PrintDayCaption
D $BCCA Prints the caption "DAY" on the panel. The colour of the caption is made
. to stand out against the colour of the room.
N $BCCA Choose a colour that stands out, then print "DAY".
  $BCCA,$03 Fetch the attribute of the room from #R$5BAD.
  $BCCD,$01 Invert it.
  $BCCE,$02 Add #N$02 to it.
  $BCD0,$02,b$01 Keep the ink colour.
  $BCD2,$02,b$01 Make it bright.
  $BCD4,$03 Store the caption attribute at #R$BCE7.
  $BCD7,$03 Point #REGhl at #R$BCEC.
  $BCDA,$03 Set #R$5BC7.
  $BCDD,$03 Point #REGde at #R$BCE7.
  $BCE0,$03 Set the pixel position to
. (#N($70), #N$0F).
  $BCE3,$01 Stash the coordinates on the
. stack, as #R$BE4C expects to find them
. there.
  $BCE4,$03 Call #R$BE4C.

b $BCE7 Day Caption
@ $BCE7 label=DayCaption
D $BCE7 The text that #R$BCCA prints.
B $BCE7,$01,$01 Attribute (set when the caption is printed).
B $BCE8,$04,$04 The four characters of the caption, from #R$BCEC.

b $BCEC Day Caption Font
@ $BCEC label=DayCaptionFont
D $BCEC The four characters that make up the caption "DAY".
. #UDGARRAY4,56,4($BCEC-$BD0B-8)(day)
B $BCEC,$20,$08

c $BD0C Game Selection Menu
@ $BD0C label=GameMenu
D $BD0C Displays the menu and waits for
. the control method to be chosen and the
. game to be started. The keys "1" to "4"
. choose the keyboard, the Kempston
. joystick, the cursor joystick and
. Interface II, "5" turns directional
. control on or off, and "0" starts the
. game. A low beep sounds when the choice
. changes. The menu tune is played once.
. The choice is held in #R$5BA4.
.
. #PUSHS #UDGTABLE
. { #SIM(start=$AF6C,stop=$AFA2,sp=$5BA0,clear=1)
. #SIM(start=$BD0C,stop=$BD23)
. #SCR$02(game-selection-menu) } UDGTABLE# #POPS
E $BD0C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BA7E }
. { #MARTIANOIDS$BB12 }
. { #NIGHTSHADE$C8CA }
. { #PENTAGRAM$BB74 }
. LIST#
N $BD0C Prepare the menu.
  $BD0C,$04 Write #N$00 to #R$5BB8.
  $BD10,$03 Point #REGhl at #R$BDA2.
  $BD13,$02 Set the number of lines to #N$08.
@ $BD15 label=GameMenu_StopFlashing
  $BD15,$02 Stop the line flashing.
  $BD17,$01 Move on to the next line.
  $BD18,$02 Jump to #R$BD15 until all of the
. lines are done.
  $BD1A,$03 Call #R$D567.
  $BD1D,$03 Call #R$BEB3.
  $BD20,$03 Call #R$BD89.
N $BD23 Read the keys that choose the
. control method.
@ $BD23 label=GameMenu_MenuLoop
  $BD23,$03 Call #R$BEB3.
N $BD26 #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune)))
  $BD26,$03 Point #REGde at #R$B253.
  $BD29,$03 Call #R$B2B6.
  $BD2C,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $BD31,$01 Keep the keys that are pressed in
. #REGe.
  $BD32,$03 Fetch #R$5BA4.
  $BD35,$03 Set #R$5BA6.
  $BD38,$04 Jump to #R$BD3E if "1" is not
. pressed.
  $BD3C,$02,b$01 Choose the keyboard.
N $BD3E Choose a joystick if one of those
. keys is pressed.
@ $BD3E label=GameMenu_TestKempston
  $BD3E,$04 Jump to #R$BD46 if "2" is not
. pressed.
  $BD42,$02,b$01 Clear bits 1 and 2.
  $BD44,$02,b$01 Choose the Kempston joystick.
@ $BD46 label=GameMenu_TestCursor
  $BD46,$04 Jump to #R$BD4E if "3" is not
. pressed.
  $BD4A,$02,b$01 Clear bits 1 and 2.
  $BD4C,$02,b$01 Choose the cursor joystick.
@ $BD4E label=GameMenu_TestInterface
  $BD4E,$04 Jump to #R$BD54 if "4" is not
. pressed.
  $BD52,$02,b$01 Choose Interface II.
@ $BD54 label=GameMenu_SetMethod
  $BD54,$03 Set #R$5BA4.
N $BD57 Toggle directional control once for
. each press of "5".
  $BD57,$03 Point #REGhl at #R$5BD2.
  $BD5A,$04 Jump to #R$BD85 if "5" is not
. pressed.
  $BD5E,$04 Jump to #R$BD6C if "5" was
. pressed last time as well.
  $BD62,$02 Set bit 0 of #R$5BD2.
  $BD64,$03 Fetch #R$5BA4.
  $BD67,$02,b$01 Toggle directional control.
  $BD69,$03 Set #R$5BA4.
N $BD6C Start the game if "0" is pressed.
@ $BD6C label=GameMenu_TestStart
  $BD6C,$03 Point #REGhl at #R$5BA6.
  $BD6F,$04 Call #R$B4A3 if the control
. method has changed.
  $BD73,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $BD78,$03 Return if "0" is pressed.
  $BD7B,$03 Point #REGhl at #R$5BA0.
  $BD7E,$01 Increment #R$5BA0.
  $BD7F,$03 Call #R$BD89.
  $BD82,$03 Jump to #R$BD23.
N $BD85 "5" has been released.
@ $BD85 label=GameMenu_ReleaseKey5
  $BD85,$02 Reset bit 0 of #R$5BD2.
  $BD87,$02 Jump to #R$BD6C.

c $BD89 Flash Menu Options
@ $BD89 label=FlashMenuOptions
D $BD89 Makes the line of the menu for
. the selected control method flash, and
. the line for directional control if that
. is on.
E $BD89 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BAFB }
. { #NIGHTSHADE$C949 }
. { #PENTAGRAM$BBD8 }
. LIST#
N $BD89 Flash the chosen control method.
  $BD89,$03 Point #REGhl at #R$BDA3.
  $BD8C,$03 Fetch #R$5BA4.
  $BD8F,$01 Move the method to bits 0 and 1.
  $BD90,$02,b$01 Keep only bits 0 and 1.
  $BD92,$02 Set a counter of #N$04 lines.
  $BD94,$03 Call #R$BEA3.
N $BD97 Flash directional control if it is
. on.
  $BD97,$02 Reset bit 7 of the attribute.
  $BD99,$03 Fetch #R$5BA4.
  $BD9C,$02,b$01 Keep only bit 3.
  $BD9E,$01 Return if it is off.
  $BD9F,$02 Set bit 7 of the attribute.
  $BDA1,$01 Return.

b $BDA2 Menu Colours
@ $BDA2 label=MenuColours
D $BDA2 The attributes of the eight lines of the menu.
B $BDA2,$01 The title: #COLOUR(#PEEK(#PC)).
@ $BDA3 label=MenuColours_ControlMethods
B $BDA3,$01 The four control methods: #COLOUR(#PEEK(#PC)).
L $BDA3,$01,$04
B $BDA7,$01 Directional control: #COLOUR(#PEEK(#PC)).
B $BDA8,$01 Starting the game and the copyright message:
. #COLOUR(#PEEK(#PC)).
L $BDA8,$01,$02

b $BDAA Menu Coordinates
@ $BDAA label=MenuCoordinates
D $BDAA The X and Y coordinates of the eight lines of the menu.
B $BDAA,$10,$02 One pair for each line.

b $BDBA Menu Text
@ $BDBA label=MenuText
D $BDBA The eight lines of the menu, in the same format as #R$BAE4. Character
. #N$25 is the copyright symbol and #N$24 is a full stop.
B $BDBA,$0B,$08 "KNIGHT LORE"
B $BDC5,$0A,$08 "1 KEYBOARD"
B $BDCF,$13,$08 "2 KEMPSTON JOYSTICK"
B $BDE2,$13,$08 "3 CURSOR JOYSTICK"
B $BDF5,$0E,$08 "4 INTERFACE II"
B $BE03,$15,$08 "5 DIRECTIONAL CONTROL"
B $BE18,$0C,$08 "0 START GAME"
B $BE24,$0D,$08 "(c) 1984 A.C.G."

c $BE31 Print Text Single Colour
@ $BE31 label=PrintTextSingleColour
D $BE31 Prints a line of text in the
. colour held in #R$5BB6, using the font
. at #R$6108. The last character of the
. text has bit 7 set.
E $BE31 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BB9D }
. { #PENTAGRAM$BC66 }
. LIST#
R $BE31 DE Address of the text
R $BE31 HL Pixel position
N $BE31 Point at the standard font and keep
. #R$5BB6.
  $BE31,$01 Stash the pixel position on the
. stack.
  $BE32,$03 Point #REGhl at #R$6108.
  $BE35,$03 Set #R$5BC7.
  $BE38,$02 Copy the pixel position to #REGbc
. (using the stack).
  $BE3A,$03 Call #R$D811.
  $BE3D,$02 Copy it to #REGhl.
  $BE3F,$03 Fetch #R$5BB6.
  $BE42,$01 Keep the colour in #REGaf'.
  $BE43,$02 Jump to #R$BE56.

c $BE45 Print Text Standard Font
@ $BE45 label=PrintTextStandardFont
D $BE45 Prints a line of text, which
. starts with its attribute, using the
. font at #R$6108. The last character of
. the text has bit 7 set.
E $BE45 Continue on to #R$BE4C.
E $BE45 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BBB1 }
. { #PENTAGRAM$BC7A }
. LIST#
R $BE45 DE Address of the text
R $BE45 HL Pixel position
N $BE45 Point at the standard font.
  $BE45,$01 Stash the pixel position on the
. stack.
  $BE46,$03 Point #REGhl at #R$6108.
  $BE49,$03 Set #R$5BC7.

c $BE4C Print Text
@ $BE4C label=PrintText
D $BE4C Prints a line of text, which
. starts with its attribute, using the
. font whose address is held in #R$5BC7.
. The last character of the text has bit
. 7 set. Each character cell has its
. attribute set as well. The pixel
. position is on the stack.
R $BE4C DE Address of the text
N $BE4C Fetch the attribute from the text.
  $BE4C,$02 Copy the pixel position to #REGbc
. (using the stack).
  $BE4E,$03 Call #R$D811.
  $BE51,$02 Copy it to #REGhl.
  $BE53,$01 Fetch the attribute of the text.
  $BE54,$01 Keep the attribute in #REGaf'.
  $BE55,$01 Move on to the first character.
N $BE56 Find the attribute address.
@ $BE56 label=PrintText_Setup
  $BE56,$01 Switch to the shadow registers.
  $BE57,$01 Fetch the pixel position.
  $BE58,$01 Stash the address of the text on
. the stack.
  $BE59,$03 Call #R$D848.
  $BE5C,$02 Copy it to #REGhl.
  $BE5E,$01 Restore the address of the text from the stack.
N $BE5F Print each character and set its
. attribute.
@ $BE5F label=PrintText_NextCharacter
  $BE5F,$01 Switch back to the main registers.
  $BE60,$01 Fetch a character of the text.
  $BE61,$04 Jump to #R$BE72 if it is the last.
  $BE65,$01 Stash the address of the text on
. the stack.
  $BE66,$03 Call #R$BE7F.
  $BE69,$01 Restore the address of the text from the stack.
  $BE6A,$01 Move on to the next character.
  $BE6B,$01 Switch to the shadow registers.
  $BE6C,$01 Fetch the attribute.
  $BE6D,$01 Set the attribute of the cell.
  $BE6E,$01 Move on to the next cell.
  $BE6F,$01 Keep the attribute in #REGaf'.
  $BE70,$02 Jump to #R$BE5F.
N $BE72 Print the last character.
@ $BE72 label=PrintText_LastCharacter
  $BE72,$02,b$01 Keep only bits 0 to 6.
  $BE74,$01 Stash the address of the text on
. the stack.
  $BE75,$03 Call #R$BE7F.
  $BE78,$01 Restore the address of the text from the stack.
  $BE79,$01 Move on past the text.
  $BE7A,$01 Switch to the shadow registers.
  $BE7B,$01 Fetch the attribute.
  $BE7C,$01 Set the attribute of the last
. cell.
  $BE7D,$01 Switch back to the main registers.
  $BE7E,$01 Return.

c $BE7F Print Character
@ $BE7F label=PrintCharacter
D $BE7F Prints a character in the screen
. buffer, using the font whose address is
. held in #R$5BC7. The eight rows are
. written going down the buffer (see
. #R$D8F3), #N$20 bytes apart, and the
. address is left at the top of the next
. character.
E $BE7F View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BBEB }
. { #PENTAGRAM$BAEA }
. LIST#
R $BE7F A The character
R $BE7F HL Address in the screen buffer of the top row
R $BE7F O:HL Address of the top row of the next character
N $BE7F Find the glyph.
  $BE7F,$03 Stash #REGbc, #REGde and the
. screen buffer address on the stack.
  $BE82,$03 Set #REGhl to the character.
  $BE85,$03 Multiply the character by eight.
N $BE88 Add the font address.
  $BE88,$04 Fetch #R$5BC7.
  $BE8C,$01 Add it to get the glyph address.
  $BE8D,$01 Point #REGde at the glyph.
  $BE8E,$01 Restore the screen buffer address from the stack.
N $BE8F Copy eight rows down the buffer.
  $BE8F,$02 Set a counter of #N$08 rows.
@ $BE91 label=PrintCharacter_NextRow
  $BE91,$02 Copy a row of the glyph to the
. buffer.
  $BE93,$01 Move on to the next row of the
. glyph.
  $BE94,$01 Stash the row counter on the
. stack.
  $BE95,$04 Move #REGhl down a row.
  $BE99,$01 Restore the row counter from the stack.
  $BE9A,$02 Jump to #R$BE91 until all eight
. rows have been written.
N $BE9C Move on to the next character, eight
. lines up and one byte to the right.
  $BE9C,$01 Restore #REGde from the stack.
  $BE9D,$04 Move #REGhl on by #N($0101,$04,$04).
  $BEA1,$01 Restore #REGbc from the stack.
  $BEA2,$01 Return.

c $BEA3 Set Flashing Attribute
@ $BEA3 label=SetFlashingAttribute
D $BEA3 Sets bit 7 of the attribute of
. one line of text in a list of lines, and
. resets it for the other lines.
E $BEA3 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BC15 }
. { #PENTAGRAM$BB64 }
. LIST#
R $BEA3 A The number of the line
R $BEA3 B Number of lines
R $BEA3 HL Address of the attributes
N $BEA3 Flash one line and steady the rest.
  $BEA3,$03 Jump to #R$BEAD if the line is not
. the first.
@ $BEA6 label=SetFlashingAttribute_Flash
  $BEA6,$02 Set bit 7 of the attribute.
  $BEA8,$02 Jump to #R$BEAF.
@ $BEAA label=SetFlashingAttribute_NextLine
  $BEAA,$03 Jump to #R$BEA6 if this is the
. line.
@ $BEAD label=SetFlashingAttribute_Steady
  $BEAD,$02 Reset bit 7 of the attribute.
@ $BEAF label=SetFlashingAttribute_Advance
  $BEAF,$01 Move on to the next line.
  $BEB0,$02 Jump to #R$BEAA until all of the
. lines have been done.
  $BEB2,$01 Return.

c $BEB3 Display Menu
@ $BEB3 label=DisplayMenu
D $BEB3 Displays the menu, which is a
. list of eight lines of text (see
. #R$BEBF).
E $BEB3 Continue on to #R$BEBF.
E $BEB3 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BC25 }
. { #NIGHTSHADE$CA2B }
. { #PENTAGRAM$BCB4 }
. LIST#
N $BEB3 Point at the menu colours,
. positions and text.
  $BEB3,$03 Point #REGde at #R$BDA2.
  $BEB6,$01 Switch to the shadow registers.
  $BEB7,$03 Point #REGhl at #R$BDAA.
  $BEBA,$03 Point #REGde at #R$BDBA.
  $BEBD,$02 Set the number of lines to #N$08.

c $BEBF Display Text List
@ $BEBF label=DisplayTextList
D $BEBF Prints a list of lines of text
. in the screen buffer, each in its own
. colour. #REGde' points at the
. attributes, #REGhl at pairs of pixel x
. and y positions, and #REGde at the text.
. After the lines have been printed the
. border is drawn and the buffer is copied
. to the screen, unless #R$5BB8 is already
. set.
E $BEBF View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BC31 }
. LIST#
R $BEBF B Number of lines
R $BEBF DE Address of the text
R $BEBF HL Address of the list of positions
R $BEBF DE' Address of the list of attributes
N $BEBF Print one line from the three lists.
  $BEBF,$01 Switch to the shadow registers.
  $BEC0,$01 Fetch the attribute of the line.
  $BEC1,$03 Set #R$5BB6.
  $BEC4,$01 Move on to the next attribute.
  $BEC5,$01 Switch back to the main registers.
  $BEC6,$01 Stash the number of lines on the
. stack.
  $BEC7,$01 Fetch the x position.
  $BEC8,$02 Move on to the next pair of
. positions.
  $BECA,$01 Stash the address of the next pair
. on the stack.
  $BECB,$01 Point #REGhl at the y position.
  $BECC,$01 Fetch the y position.
  $BECD,$01 Set the x position.
  $BECE,$03 Call #R$BE31.
  $BED1,$01 Restore the address of the next pair from the stack.
  $BED2,$01 Restore the number of lines from the stack.
  $BED3,$02 Jump to #R$BEBF until all of the
. lines have been printed.
N $BED5 Draw the border the first time.
  $BED5,$05 Return if #R$5BB8 is set.
  $BEDA,$04 Write #N$01 to *#R$5BB8.
  $BEDE,$03 Call #R$D296.
  $BEE1,$03 Jump to #R$D56F.

c $BEE4 Print Sprites
@ $BEE4 label=PrintSprites
D $BEE4 Prints the sprite of an object a
. number of times, moving the pixel
. position of the object by a step each
. time, so that it makes a row of sprites.
. #REGbc, #REGde and #REGhl are preserved
. while each sprite is printed.
E $BEE4 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BC56 }
. { #PENTAGRAM$BDDE }
. LIST#
R $BEE4 B Number of times
R $BEE4 D Step along the y axis in pixels
R $BEE4 E Step along the x axis in pixels
R $BEE4 IX The address of the object
N $BEE4 Print one sprite and step the
. position.
  $BEE4,$03 Stash #REGbc, #REGde and #REGhl on
. the stack.
  $BEE7,$03 Call #R$D718.
  $BEEA,$03 Restore #REGhl, #REGde and #REGbc from the stack.
  $BEED,$03 Fetch the pixel x position of the
. object.
  $BEF0,$01 Add the step along the x axis.
  $BEF1,$03 Set the pixel x position of the
. object.
  $BEF4,$03 Fetch the pixel y position of the
. object.
  $BEF7,$01 Add the step along the y axis.
  $BEF8,$03 Set the pixel y position of the
. object.
  $BEFB,$02 Jump to #R$BEE4 until all of the
. sprites have been printed.
  $BEFD,$01 Return.

c $BEFE Handle Player Appearing
@ $BEFE label=HandlePlayerAppearing
D $BEFE The handler for the sparkles in
. which the player appears at the start of
. a life (graphics #N$78 to #N$7E). On
. every other frame it moves on to the
. next of the animation frames and plays a
. sound.
E $BEFE View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BC70 }
. LIST#
R $BEFE IX The address of the object
N $BEFE Advance the sparkle on every other
. frame.
  $BEFE,$03 Call #R$C4D8.
  $BF01,$03 Fetch #R$5BA2.
  $BF04,$01 Invert it.
  $BF05,$02,b$01 Keep only bit 0.
  $BF07,$01 Return on every other frame.
  $BF08,$03 Move on to the next sprite number.
  $BF0B,$03 Call #R$B419.
  $BF0E,$03 Jump to #R$C692.

c $BF11 Handle Last Appearing Sparkle
@ $BF11 label=HandleLastAppearingSparkle
D $BF11 The handler for the last of the
. sparkles in which the player appears.
. The object turns into the player, who is
. no longer dead, and is updated as the
. player right away.
R $BF11 IX The address of the object
N $BF11 Stop the sparkle and restore the
. player.
  $BF11,$03 Call #R$C4D8.
  $BF14,$04 Reset bit 6 of the flags.
  $BF18,$03 Fetch the sprite number which was
. kept.
  $BF1B,$03 Restore the sprite number of the
. object.
  $BF1E,$03 Jump to #R$AFD5.

c $BF21 Start Death Sparkles
@ $BF21 label=StartDeathSparkles
D $BF21 Turns the object into the first of the sparkles that show the player
. dying, which go through the graphic numbers #N$70 to #N$76.
R $BF21 IX Address of the object
  $BF21,$04 Set the graphic number to #N$70.
  $BF25,$04 Flag the object to be ignored in the 3D calculations.
  $BF29,$02 Jump to #R$BF31.

c $BF2B Handle Death Sparkles
@ $BF2B label=HandleDeathSparkles
D $BF2B Handles the sparkles that show the player dying, which go through the
. graphic numbers #N$70 to #N$76 (and #N$B8). The graphic changes on every
. frame.
R $BF2B IX Address of the sparkle object
  $BF2B,$03 Set the pixel adjustments of a sparkle.
  $BF2E,$03 Change to the next graphic.
@ $BF31 label=HandleDeathSparkles_Draw
  $BF31,$03 Play the sound of the sparkles.
  $BF34,$03 Flag the object to be drawn again.

c $BF37 Handle Vanishing Object Sparkles
@ $BF37 label=HandleVanishingObjectSparkles
D $BF37 Handles the graphic numbers #N$B9 to #N($BB), which are for sparkles of
. an object that is going away for good. The entry in the table that the object
. points to is cleared, and then the object is removed in the same way as the
. last of the death sparkles.
R $BF37 IX Address of the sparkle object
  $BF37,$03 Fetch the low byte of the address of the table entry that the object
. comes from.
  $BF3A,$03 Fetch the high byte.
  $BF3D,$02 Clear the graphic number of that entry.
@ $BF3F label=HandleLastDeathSparkle
N $BF3F Remove the last of the death sparkles.
  $BF3F,$03 Set the pixel adjustments of a sparkle.
  $BF42,$03 Remove the object.

c $BF45 Display Objects Carried
@ $BF45 label=DisplayObjectsCarried
D $BF45 Draws the objects that the player is carrying on the panel, but only if
. they have changed since they were last drawn. The panel has room for three
. objects, which are drawn from the left: the object that was picked up last
. comes first. Each object is drawn in a space of #N$18 by #N$18 pixels, with a
. colour that goes with it.
E $BF45 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BC9D }
. { #PENTAGRAM$BA3D }
. LIST#
.
. #PUSHS #UDGTABLE { =h After #R$BF45 }
. { #SIM(start=$AF6C,stop=$AFA2,sp=$5BA0,clear=1)
. #SIM(start=$D55F,stop=$0000,sp=$5B80)
. #POKES$5BDC,$60;$5BE0,$63;$5BE4,$61;$5BB4,$01
. #SIM(start=$BF45,stop=$0000,sp=$5B80)
. #SCR$02,$00,$14,$10,$04(display-objects-carried) } UDGTABLE# #POPS
  $BF45,$03 Fetch the flag that says the objects carried have changed from
. #R$5BB4.
  $BF48,$01 Test it.
  $BF49,$01 Return if they have not changed.
  $BF4A,$01 Clear #REGa.
  $BF4B,$03 Clear the flag at #R$5BB4.
@ $BF4E label=DisplayObjects
N $BF4E The objects are drawn using an object that is kept just for drawing the
. panel.
  $BF4E,$02 Stash #REGix on the stack.
  $BF50,$04 Point #REGix at #R$BFDB.
  $BF54,$02 Set the number of objects to #N$03.
  $BF56,$03 Point #REGhl at #R$5BDC.
@ $BF59 label=DisplayObjects_Next
  $BF59,$01 Stash the number of objects left on the stack.
  $BF5A,$01 Stash the address of the object carried on the stack.
  $BF5B,$01 Copy the number of objects left into #REGa.
  $BF5C,$02 Negate it.
  $BF5E,$02 Add #N($03), to get the number of objects done.
  $BF60,$06 Multiply it by eight.
  $BF66,$01 Stash it in #REGc.
  $BF67,$02 Multiply it by two.
  $BF69,$01 Add the number multiplied by eight, to get it multiplied by #N$18.
  $BF6A,$02 Add #N$10 to get the pixel X coordinate.
  $BF6C,$03 Set the pixel X coordinate.
  $BF6F,$04 Set the pixel Y coordinate to #N$00.
  $BF73,$03 Fetch the pixel X coordinate into #REGc.
  $BF76,$03 Fetch the pixel Y coordinate into #REGb.
  $BF79,$01 Stash the address of the object carried on the stack.
  $BF7A,$03 Find the address in the screen buffer.
  $BF7D,$02 Copy it to #REGhl.
  $BF7F,$03 Set the width to #N$03 bytes and the height to #N$18 lines.
  $BF82,$01 Set the fill byte to #N$00.
  $BF83,$03 Clear the area.
  $BF86,$01 Restore the address of the object carried from the stack.
  $BF87,$01 Fetch the graphic number of the object.
  $BF88,$01 Test it.
  $BF89,$02 Jump to #R$BF91 if there is no object.
  $BF8B,$03 Set the graphic number of the panel object.
  $BF8E,$03 Draw the object.
@ $BF91 label=DisplayObjectsCarried_CopyPlace
N $BF91 Copy the area from the screen buffer to the display.
  $BF91,$03 Fetch the pixel X coordinate into #REGc.
  $BF94,$03 Fetch the pixel Y coordinate into #REGb.
  $BF97,$03 Find the address in the display.
  $BF9A,$03 Find the address in the screen buffer.
  $BF9D,$02 Copy it to #REGhl.
  $BF9F,$03 Set the number of lines to #N$18 and the number of bytes to #N$03.
  $BFA2,$03 Copy the area to the display.
N $BFA5 Colour the area.
  $BFA5,$01 Restore the address of the object carried from the stack.
  $BFA6,$01 Restore the number of objects left from the stack.
  $BFA7,$01 Stash the number of objects left on the stack.
  $BFA8,$01 Stash the address of the object carried on the stack.
  $BFA9,$01 Fetch the graphic number of the object.
  $BFAA,$02,b$01 Keep the number of the object.
  $BFAC,$01 Copy it into #REGe.
  $BFAD,$02 Clear #REGd.
  $BFAF,$03 Point #REGhl at #R$BFD3.
  $BFB2,$01 Find the attribute of the object.
  $BFB3,$01 Fetch it into #REGc.
  $BFB4,$03 Set #REGl to the pixel X coordinate.
  $BFB7,$03 Fetch the pixel Y coordinate.
  $BFBA,$02 Add #N($17), to get the top of the area.
  $BFBC,$01 Use it as the Y coordinate of the position.
  $BFBD,$03 Find the address in the attribute file.
  $BFC0,$01 Copy it to #REGhl.
  $BFC1,$01 Fetch the attribute.
  $BFC2,$03 Set the width to #N$03 and the height to #N$03.
  $BFC5,$03 Colour the area.
  $BFC8,$01 Restore the address of the object carried from the stack.
  $BFC9,$01 Restore the number of objects left from the stack.
  $BFCA,$04 Move on to the next object carried.
  $BFCE,$02 Jump to #R$BF59 until all of the objects have been drawn.
  $BFD0,$02 Restore #REGix from the stack.
  $BFD2,$01 Return.

b $BFD3 Object Attributes
@ $BFD3 label=ObjectAttributes
D $BFD3 The attributes that are used for the objects on the panel, in the order
. of the graphic numbers #N$60 to #N$67 (the last of which is the extra life).
B $BFD3,$01 #COLOUR(#PEEK(#PC)).
L $BFD3,$01,$08

g $BFDB Panel Object
@ $BFDB label=PanelObject
D $BFDB An object that is used for drawing the graphics of the panel (the
. objects that are carried and the lives). Only its graphic number, its flags
. and its pixel coordinates are used.
B $BFDB,$20,$08

c $BFFB Test Pickup Drop Key
@ $BFFB label=TestPickupDropKey
D $BFFB Tests whether the control for picking up or dropping an object is
. pressed. If the joystick is used with the directional control, the other of
. the two bits for this is used.
E $BFFB View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BD58 }
. { #PENTAGRAM$BF66 }
. LIST#
R $BFFB O:F Zero flag set if the control is not pressed
N $BFFB Choose the pickup bit, then test whether it is pressed.
  $BFFB,$03 Point #REGhl at the control method, #R$5BA4.
  $BFFE,$01 Fetch it.
  $BFFF,$02,b$01 Keep the choice of joystick.
  $C001,$03 Fetch the controls that are pressed from #R$5BB5.
  $C004,$02 Jump to #R$C00B if the keyboard is in use.
  $C006,$04 Jump to #R$C00B if the directional control is not on.
  $C00A,$01 Move the bit for the directional control into place.
@ $C00B label=TestPickupDropKey_Test
  $C00B,$02,b$01 Keep the bit for picking up and dropping.
  $C00D,$01 Return.

c $C00E Handle Pickup And Drop
@ $C00E label=HandlePickupAndDrop
D $C00E Picks up or drops an object when the player presses the control for it.
. A special object that is close enough is picked up. If the player carries
. three objects already, the one that has been carried longest is dropped in the
. place of the new one. Otherwise, if the player is carrying something and there
. is a free place for a special object in the room, the object that has been
. carried longest is dropped where the player stands, and the player is lifted
. up by #N$0C to stand on it. If the player is in the cauldron room and jumping
. above the cauldron, the object is dropped into the cauldron.
D $C00E The routine looks for objects by making the player a little wider,
. deeper and taller, which is put right when the routine ends.
E $C00E View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BD6B }
. { #PENTAGRAM$BF79 }
. LIST#
R $C00E IX Address of the bottom half of the player
  $C00E,$03 Fetch the flag that says the control has been pressed and not yet
. released from #R$5BB3.
  $C011,$01 Test it.
  $C012,$03 Jump to #R$C0A9 if it was pressed on a frame before.
  $C015,$03 Test whether the control is pressed.
  $C018,$01 Return if it is not.
  $C019,$03 Test whether the player is in the room.
  $C01C,$01 Return if the player is out of bounds.
  $C01D,$04 Test whether the player is jumping.
  $C021,$01 Return if so.
  $C022,$04 Test whether the player has hit something below.
  $C026,$01 Return if the player is in the air.
N $C027 Find out whether there is room to drop an object, by raising the player
. by #N$0C to see if it hits anything.
  $C027,$01 Clear #REGa.
  $C028,$03 Flag that an object can be dropped at #R$5BD3.
  $C02B,$03 Fetch the Z coordinate of the player.
  $C02E,$01 Stash it in #REGb.
  $C02F,$02 Add #N$0C to it.
  $C031,$03 Set it as the Z coordinate of the player.
  $C034,$03 Test whether the player intersects another object.
  $C037,$03 Restore the Z coordinate of the player.
  $C03A,$02 Jump to #R$C041 if there is room.
  $C03C,$02 Get the value that sets a flag.
  $C03E,$03 Flag that no object can be dropped at #R$5BD3.
@ $C041 label=HandlePickupAndDrop_Pressed
  $C041,$03 Play a beep.
  $C044,$02 Get the value that sets a flag.
  $C046,$03 Flag that the control has been pressed at #R$5BB3.
  $C049,$03 Flag that the objects carried have changed at #R$5BB4.
N $C04C Make the player wider, deeper and taller, to find an object to pick up.
  $C04C,$02 Set the number of special objects in the room to #N$02.
  $C04E,$03 Fetch the width of the player.
  $C051,$01 Copy it into #REGa.
  $C052,$02 Add #N$04 to it.
  $C054,$03 Set the new width.
  $C057,$03 Fetch the depth of the player.
  $C05A,$01 Copy it into #REGa.
  $C05B,$02 Add #N$04 to it.
  $C05D,$03 Set the new depth.
  $C060,$01 Stash the old width and depth on the stack.
  $C061,$03 Fetch the height of the player.
  $C064,$01 Copy it into #REGa.
  $C065,$02 Add #N$04 to it.
  $C067,$03 Set the new height.
  $C06A,$01 Stash the old height on the stack.
  $C06B,$04 Point #REGiy at #R$5C48.
@ $C06F label=HandlePickupAndDrop_LookForObject
  $C06F,$03 Test whether the object can be picked up.
  $C072,$03 Pick it up if it can.
  $C075,$03 Set #REGde to the size of an object.
  $C078,$02 Point #REGiy at the next special object.
  $C07A,$02 Jump to #R$C06F until both have been tried.
N $C07C There is nothing to pick up. Look for a free place to drop an object.
  $C07C,$03 Test whether the control is still pressed.
  $C07F,$02 Finish if it is not.
  $C081,$02 Set the number of special objects to look at to #N$02.
  $C083,$03 Fetch the room that the player is in.
  $C086,$04 Jump to #R$C08C if it is another room.
  $C08A,$02 Set the number of special objects to look at to #N$01.
@ $C08C label=HandlePickupAndDrop_LookForSpace
  $C08C,$04 Point #REGiy at the first special object of the room, #R$5C48.
  $C090,$03 Set #REGde to the size of an object.
@ $C093 label=HandlePickupAndDrop_TestSlot
  $C093,$03 Fetch the graphic number of the special object.
  $C096,$01 Test whether it is zero.
  $C097,$02 Jump to #R$C0B2 if the place is free.
  $C099,$02 Point #REGiy at the next special object.
  $C09B,$02 Jump to #R$C093 until all of them have been tried.
@ $C09D label=HandlePickupAndDrop_Done
N $C09D Put the size of the player back.
  $C09D,$01 Restore the old height from the stack.
  $C09E,$03 Set the height of the player.
  $C0A1,$01 Restore the old width and depth from the stack.
  $C0A2,$03 Set the width of the player.
  $C0A5,$03 Set the depth of the player.
  $C0A8,$01 Return.
@ $C0A9 label=HandlePickupAndDrop_WaitForRelease
N $C0A9 The control was pressed on a frame before: wait until it is let go.
  $C0A9,$03 Test whether the control is still pressed.
  $C0AC,$01 Return if it is.
  $C0AD,$01 Clear #REGa.
  $C0AE,$03 Flag that the control is not pressed at #R$5BB3.
  $C0B1,$01 Return.
@ $C0B2 label=HandlePickupAndDrop_Drop
N $C0B2 Drop the object that has been carried longest in the free place.
  $C0B2,$03 Point #REGhl at the object that has been carried longest, #R$5BE4.
  $C0B5,$01 Fetch its graphic number.
  $C0B6,$01 Move on to the flags.
  $C0B7,$01 Test whether there is an object.
  $C0B8,$02 Jump to #R$C12B if there is not.
  $C0BA,$03 Fetch the flag that says no object can be dropped from #R$5BD3.
  $C0BD,$01 Test it.
  $C0BE,$02 Finish if there is no room.
  $C0C0,$01 Point #REGhl at the graphic number.
  $C0C1,$01 Fetch it.
  $C0C2,$01 Move on to the flags.
  $C0C3,$03 Set it as the graphic number of the special object.
  $C0C6,$03 Fetch the room that the player is in.
  $C0C9,$04 Jump to #R$C0DD if it is another room.
  $C0CD,$03 Fetch the Z coordinate of the player.
  $C0D0,$04 Jump to #R$C0DD if the player is below that.
  $C0D4,$04 Make the object drop into the cauldron.
  $C0D8,$02 Get the value that sets a flag.
  $C0DA,$03 Flag that an object is being put into the cauldron at #R$5BC4.
@ $C0DD label=HandlePickupAndDrop_Place
N $C0DD Put the object where the player is, and lift the player on top of it.
  $C0DD,$01 Stash the address of the flags of the object carried on the stack.
  $C0DE,$03 Set the number of bytes to copy to #N$03.
  $C0E1,$03 Copy #REGix to #REGhl (using the stack).
  $C0E4,$03 Copy #REGiy to #REGde (using the stack).
  $C0E7,$01 Point #REGde at the X coordinate of the object.
  $C0E8,$01 Point #REGhl at the X coordinate of the player.
  $C0E9,$02 Copy the coordinates of the player to the object.
  $C0EB,$03 Fetch the Z coordinate of the player.
  $C0EE,$02 Add #N$0C to it.
  $C0F0,$03 Set the new Z coordinate of the player.
  $C0F3,$03 Fetch the Z coordinate of the top half of the player.
  $C0F6,$02 Add #N$0C to it.
  $C0F8,$03 Set the new Z coordinate of the top half of the player.
  $C0FB,$02 Stash #REGix on the stack.
  $C0FD,$04 Copy #REGiy to #REGix (using the stack), to point at the object.
  $C101,$03 Work out the pixel coordinates of the object.
  $C104,$02 Restore #REGix from the stack.
@ $C106 label=HandlePickupAndDrop_SetObject
N $C106 Set up the rest of the object.
  $C106,$04 Set the width of the object to #N$05.
  $C10A,$04 Set the depth of the object to #N$05.
  $C10E,$04 Set the height of the object to #N$0C.
  $C112,$01 Restore the address of the flags
. of the object carried from the stack.
  $C113,$01 Fetch the flags.
  $C114,$01 Move on to the address of the table entry.
  $C115,$03 Set the flags of the object.
  $C118,$03 Fetch the room that the player is in.
  $C11B,$03 Set the room of the object.
  $C11E,$01 Fetch the low byte of the address of the table entry.
  $C11F,$01 Move on to the high byte.
  $C120,$03 Set the low byte of the address of the table entry of the object.
  $C123,$01 Fetch the high byte of the address of the table entry.
  $C124,$03 Set the high byte of the address of the table entry of the object.
  $C127,$04 Flag that the object has just been dropped.
@ $C12B label=HandlePickupAndDrop_Shift
N $C12B Remove the object that was carried longest from the list, by moving the
. others along.
  $C12B,$03 Point #REGhl at the last byte of the next to last object carried.
  $C12E,$03 Point #REGde at the last byte of the last object carried.
  $C131,$03 Set the number of bytes to move to #N$0C.
  $C134,$02 Move the objects.
  $C136,$03 Point #REGde at #R$5BD8.
  $C139,$02 Set the number of bytes to clear to #N$04.
  $C13B,$03 Clear them.
  $C13E,$03 Jump to #R$C09D to finish.
@ $C141 label=HandlePickupAndDrop_PickUp
N $C141 Pick up the object that #REGiy points at.
  $C141,$03 Point #REGhl at the space for a new object carried, #R$5BD8.
  $C144,$01 Clear #REGa.
  $C145,$03 Allow the spiked balls to drop again at #R$5BC0.
  $C148,$03 Fetch the graphic number of the object.
  $C14B,$01 Store it.
  $C14C,$01 Move on to the flags.
  $C14D,$03 Fetch the flags of the object.
  $C150,$01 Store them.
  $C151,$01 Move on to the address of the table entry.
  $C152,$03 Fetch the low byte of the address of the table entry of the object.
  $C155,$03 Fetch the high byte.
  $C158,$01 Clear #REGa.
  $C159,$01 Clear the graphic number of the table entry, so that the object is
. not built again.
  $C15A,$01 Store the low byte of the address of the table entry.
  $C15B,$01 Move on to the high byte.
  $C15C,$01 Store it.
  $C15D,$03 Flag the object to be wiped and drawn.
  $C160,$04 Make the graphic of the object one that is not shown.
  $C164,$03 Point #REGhl at #R$5BE4.
  $C167,$01 Fetch its graphic number.
  $C168,$01 Move on to the flags.
  $C169,$01 Test whether there is an object.
  $C16A,$02 Jump to #R$C12B if there is not.
  $C16C,$03 Make it the graphic of the object that was picked up.
  $C16F,$01 Stash the address of the flags on the stack.
  $C170,$02 Jump to #R$C106 to drop it where the other object was.

c $C172 Test Object Can Be Picked Up
@ $C172 label=TestObjectCanBePickedUp
D $C172 Tests whether an object is a special object that the player is on or
. close to. The routine continues at #R$C17A.
E $C172 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BEA7 }
. { #PENTAGRAM$C0D4 }
. LIST#
R $C172 IX Address of the player
R $C172 IY Address of the object
R $C172 O:F Carry flag set if the object can be picked up
  $C172,$03 Fetch the graphic number of the object.
  $C175,$02 Take off the graphic number of the first special object.
  $C177,$02 Compare it with the number of special objects.
  $C179,$01 Return if the object is not a special object.
@ $C17A label=TestNearObject
N $C17A Test whether the player is standing on, or next to, the object.
  $C17A,$01 Stash #REGbc on the stack.
  $C17B,$03 Set the offset in X to zero.
  $C17E,$02 Set the offsets in Y and Z to zero.
  $C180,$03 Test whether the objects overlap in X.
  $C183,$02 Jump to #R$C19F if they do not.
  $C185,$03 Test whether the objects overlap in Y.
  $C188,$02 Jump to #R$C19F if they do not.
  $C18A,$03 Fetch the Z coordinate of the player.
  $C18D,$02 Take off #N$04.
  $C18F,$03 Set the new Z coordinate.
  $C192,$03 Test whether the objects overlap in Z.
  $C195,$01 Stash the result on the stack.
  $C196,$03 Fetch the Z coordinate of the player.
  $C199,$02 Add #N$04 to it.
  $C19B,$03 Set the old Z coordinate.
  $C19E,$01 Restore the result from the stack.
@ $C19F label=TestNearObject_Done
  $C19F,$01 Restore #REGbc from the stack.
  $C1A0,$01 Return.

c $C1A1 Test Object Moving
@ $C1A1 label=TestObjectMoving
D $C1A1 Tests whether an object is moving, which is when its speed in any of the
. three axes is not zero.
E $C1A1 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BED6 }
. LIST#
R $C1A1 IX Address of the object
R $C1A1 O:F Zero flag set if the object is not moving
  $C1A1,$03 Fetch the speed in X.
  $C1A4,$03 Combine it with the speed in Y.
  $C1A7,$03 Combine it with the speed in Z.
  $C1AA,$01 Return.

c $C1AB Handle Extra Life
@ $C1AB label=HandleExtraLife
D $C1AB Handles an extra life, which is an object that the player gets by
. touching it. When it is touched the object turns into the graphic that removes
. it, the table entry that it came from is cleared so that the object does not
. come back, and the player gets an extra life.
R $C1AB IX Address of the extra life object
N $C1AB Test whether the player is touching the extra life.
  $C1AB,$03 Set the pixel adjustments of an extra life.
  $C1AE,$04 Copy #REGix to #REGiy (using the stack).
  $C1B2,$04 Point #REGix at #R$5C08.
  $C1B6,$03 Make the player wider by one.
  $C1B9,$03 Make the player deeper by one.
  $C1BC,$03 Test whether the player is on or next to the extra life.
  $C1BF,$03 Put the width of the player right.
  $C1C2,$03 Put the depth of the player right.
  $C1C5,$04 Copy #REGiy to #REGix (using the stack).
  $C1C9,$02 Jump to #R$C1EE if the player is not touching the extra life.
N $C1CB Award the extra life and remove the object.
  $C1CB,$04 Change the graphic of the object to the one that removes it.
  $C1CF,$03 Set the pixel adjustments of a sparkle.
  $C1D2,$03 Fetch the low byte of the address of the table entry that the object
. comes from.
  $C1D5,$03 Fetch the high byte.
  $C1D8,$02 Clear the graphic number of the table entry.
  $C1DA,$03 Point #REGhl at #R$5BBA.
  $C1DD,$01 Give the player an extra life.
  $C1DE,$01 Clear #REGa.
  $C1DF,$03 Allow the spiked balls to drop again at #R$5BC0.
  $C1E2,$03 Play a beep.
  $C1E5,$03 Print the number of lives.
  $C1E8,$03 Set the position of the number of lives on the panel.
  $C1EB,$03 Copy the number of lives from the screen buffer to the display.
@ $C1EE label=HandleExtraLife_Update
  $C1EE,$03 Update the object, making it move if it has to.

c $C1F1 Handle Object Dropped In Cauldron
@ $C1F1 label=HandleObjectDroppedInCauldron
D $C1F1 Handles the graphic numbers #N$68 to #N($6E), which are the special
. objects once the player has dropped them above the cauldron. The object moves
. towards the centre of the room in X and Y at a speed of one. While it does so
. it is kept at a height of about #N$98: it is lifted if it is below that, and
. it hangs there if it is not. Once it is at the centre of the room, it falls
. into the cauldron.
R $C1F1 IX Address of the object
N $C1F1 Move the object towards the centre of the room.
  $C1F1,$03 Set the pixel adjustments of a sparkle.
  $C1F4,$03 Fetch the X coordinate of the object.
  $C1F7,$02 Subtract the X coordinate of the centre of the room.
  $C1F9,$02 Jump to #R$C202 if the object is at the centre of the room.
  $C1FB,$02 Set the speed to #N$01.
  $C1FD,$03 Jump to #R$C202 if the object is on the west side of the centre.
  $C200,$02 Make the speed negative.
@ $C202 label=HandleObjectDroppedInCauldron_SetX
  $C202,$03 Set the speed in X, towards the centre of the room.
  $C205,$03 Fetch the Y coordinate of the object.
  $C208,$02 Subtract the Y coordinate of the centre of the room.
  $C20A,$02 Jump to #R$C213 if the object is at the centre of the room.
  $C20C,$02 Set the speed to #N$01.
  $C20E,$03 Jump to #R$C213 if the object is on the south side of the centre.
  $C211,$02 Make the speed negative.
@ $C213 label=HandleObjectDroppedInCauldron_SetY
  $C213,$03 Set the speed in Y, towards the centre of the room.
  $C216,$03 Fetch the X coordinate of the object.
  $C219,$04 Jump to #R$C222 if the object is not at the centre of the room in X.
  $C21D,$03 Combine the X coordinate of the object with the Y coordinate.
  $C220,$02 Jump to #R$C238 if the object is at the centre of the room in Y too.
@ $C222 label=HandleObjectDroppedInCauldron_Lift
  $C222,$03 Fetch the Z coordinate of the object.
  $C225,$02 Compare it with #N$98.
  $C227,$02 Set the speed in Z to #N$01.
  $C229,$02 Jump to #R$C22C if the object is as high as that.
  $C22B,$01 Set the speed in Z to #N$02.
@ $C22C label=HandleObjectDroppedInCauldron_SetZ
  $C22C,$03 Set the speed in Z.
@ $C22F label=HandleObjectDroppedInCauldron_Move
  $C22F,$03 Apply gravity to the object and move it.

c $C232 Draw Moving Object
@ $C232 label=DrawMovingObject
D $C232 Plays the sound of an object that is moving, and flags it to be wiped
. and drawn again.
R $C232 IX Address of the object
  $C232,$03 Play the sound of a moving object.
  $C235,$03 Flag the object to be drawn again.

c $C238 Handle Object At Centre Of Room
@ $C238 label=HandleObjectAtCentreOfRoom
D $C238 Handles an object that has been dropped in the cauldron once it is at
. the centre of the room. If it is above the cauldron it is flagged to be
. ignored in the 3D calculations and left to fall. When it has dropped to the
. bottom the object is added to the cauldron.
R $C238 IX Address of the object
  $C238,$02 Set #REGa to the height of the bottom of the cauldron.
  $C23A,$03 Compare it with the Z coordinate of the object.
  $C23D,$02 Jump to #R$C245 if the object is at the bottom of the cauldron.
  $C23F,$04 Flag the object to be ignored in the 3D calculations.
  $C243,$02 Jump to #R$C22F to let it fall.
@ $C245 label=AddObjectToCauldron
N $C245 The object is in the cauldron. If it is the one that is needed next,
. count it and show that something happens.
  $C245,$04 Set the Z coordinate of the object to the height of the bottom of
. the cauldron.
  $C249,$03 Find the number of the object that is needed next.
  $C24C,$03 Fetch the graphic number of the object.
  $C24F,$02,b$01 Convert it to the number of the object.
  $C251,$01 Compare it with the number that is needed.
  $C252,$02 Jump to #R$C265 if it is not the one that is needed.
  $C254,$03 Point #REGhl at #R$5BBB.
  $C257,$01 Count one more.
  $C258,$03 Make the colours of the screen cycle.
  $C25B,$03 Fetch the number of charms in the cauldron from #R$5BBB.
  $C25E,$04 Jump to #R$C265 if there are more to come.
  $C262,$03 Start the final animation.
@ $C265 label=AddObjectToCauldron_Remove
N $C265 Remove the object.
  $C265,$01 Clear #REGa.
  $C266,$03 Flag that no object is being put into the cauldron at #R$5BC4.
  $C269,$03 Fetch the low byte of the address of the table entry that the object
. comes from.
  $C26C,$03 Fetch the high byte.
  $C26F,$02 Clear the graphic number of the table entry.
  $C271,$03 Jump to #R$B95E to remove the object.

c $C274 Find Next Object Required
@ $C274 label=FindNextObjectRequired
D $C274 Finds the number of the object that the player has to put into the
. cauldron next.
R $C274 O:HL Address of the number of the object in the list at #R$C27D
  $C274,$03 Fetch the number of charms in the cauldron from #R$5BBB.
  $C277,$03 Point #REGhl at #R$C27D.
  $C27A,$03 Find the address of the object that is needed.

b $C27D Required Objects
@ $C27D label=RequiredObjects
D $C27D The order in which the objects have to be put into the cauldron. Each
. number is that of an object (the graphic number less #N$60). The order is
. changed at the start of each game by #R$B544.
B $C27D,$0E,$07

c $C28B Handle Special Object
@ $C28B label=HandleSpecialObject
D $C28B Handles the graphic numbers #N$60 to #N($66), which are the special
. objects that the player has to carry to the cauldron. An object that has just
. been dropped, or is moving, has its speed in X and Y cleared so that it falls
. straight down.
R $C28B IX Address of the object
N $C28B Fall straight down if the object was dropped or is moving.
  $C28B,$03 Set the pixel adjustments of a sparkle.
  $C28E,$03 Apply gravity to the object and move it.
  $C291,$06 Jump to #R$C29B if the object has just been dropped.
  $C297,$03 Test whether the object is moving.
  $C29A,$01 Return if it is not.
@ $C29B label=HandleSpecialObject_Fall
  $C29B,$04 Clear the flag that says the object has just been dropped.
  $C29F,$03 Clear the speeds in X and Y.
  $C2A2,$03 Play the sound of a moving object and flag the object to be drawn
. again.

c $C2A5 Cycle Colours With Sound
@ $C2A5 label=CycleColoursWithSound
D $C2A5 Changes the ink colour of every attribute on the screen to the next
. colour, sixteen times, with a sound and a short delay each time.
N $C2A5 Cycle every attribute, then play a sound and wait.
  $C2A5,$02 Set the number of times to cycle to #N$10.
@ $C2A7 label=CycleColoursWithSound_Cycle
  $C2A7,$03 Point #REGhl at the attribute file.
  $C2AA,$03 Set the number of attributes to #N$0300.
@ $C2AD label=CycleColoursWithSound_Attribute
  $C2AD,$01 Fetch the attribute.
  $C2AE,$02,b$01 Keep the paper, brightness and flash.
  $C2B0,$01 Stash them in #REGe.
  $C2B1,$01 Fetch the attribute again.
  $C2B2,$01 Add one to the ink colour.
  $C2B3,$02,b$01 Keep the ink colour.
  $C2B5,$01 Combine it with the rest of the attribute.
  $C2B6,$01 Set the attribute.
  $C2B7,$01 Move on to the next attribute.
  $C2B8,$01 Decrease the number of attributes left.
  $C2B9,$02 Check whether any attributes are left to change.
  $C2BB,$02 Jump to #R$C2AD until all of the attributes have been changed.
  $C2BD,$03 Play the sound of sparkles.
  $C2C0,$03 Set the delay counter to #N$2000.
@ $C2C3 label=CycleColoursWithSound_Delay
  $C2C3,$01 Decrease the delay counter.
  $C2C4,$02 Check whether the delay counter has reached zero.
  $C2C6,$02 Jump to #R$C2C3 until the delay is over.
  $C2C8,$01 Decrease the number of times left.
  $C2C9,$02 Jump to #R$C2A7 until all of the cycles are done.
@ $C2CB label=DoNothing
  $C2CB,$01 Return.

c $C2CC Prepare Final Animation
@ $C2CC label=PrepareFinalAnimation
D $C2CC Gets the cauldron room ready for the final animation, once the last of
. the charms has been put into the cauldron. The second special object of the
. room, the background objects and the foreground objects (eleven objects in
. all) are removed, and every block that is left in the objects table is changed
. into a sparkle.
N $C2CC Remove the extra objects of the cauldron room.
  $C2CC,$02 Get the value that sets a flag.
  $C2CE,$03 Flag that the final animation has started at #R$5BC3.
  $C2D1,$02 Stash #REGix on the stack.
  $C2D3,$04 Point #REGix at #R$5C68.
  $C2D7,$03 Set #REGde to the size of an object.
  $C2DA,$02 Set the number of objects to #N$0B.
@ $C2DC label=PrepareFinalAnimation_Remove
  $C2DC,$01 Stash the number of objects left on the stack.
  $C2DD,$01 Stash the size of an object on the stack.
  $C2DE,$03 Flag the object to be wiped and drawn.
  $C2E1,$01 Restore the size of an object from the stack.
  $C2E2,$01 Restore the number of objects left from the stack.
  $C2E3,$04 Set the graphic number of the object to #N($01), so it is not shown.
  $C2E7,$02 Move on to the next object.
  $C2E9,$02 Jump to #R$C2DC until all of the objects have been removed.
  $C2EB,$03 Point #REGbc at the end of the objects table, #R$6108.
N $C2EE Change every remaining block into a sparkle.
@ $C2EE label=PrepareFinalAnimation_Next
  $C2EE,$03 Fetch the graphic number of the object.
  $C2F1,$04 Jump to #R$C2F9 if it is not a block.
  $C2F5,$04 Change the graphic of the block to the first of the sparkles.
@ $C2F9 label=PrepareFinalAnimation_Advance
  $C2F9,$02 Move on to the next object.
  $C2FB,$03 Copy #REGix to #REGhl (using the stack).
  $C2FE,$03 Subtract the address of the end of the table.
  $C301,$02 Jump to #R$C2EE until every object has been looked at.
  $C303,$02 Restore #REGix from the stack.
  $C305,$01 Return.

c $C306 Start Transformation
@ $C306 label=StartTransformation
D $C306 Starts the transformation of the player from human to wulf, or the other
. way round, when it is time to change (at the start of each day and each
. night). Nothing happens unless the change is due, and the player has been in
. the room for a while and is not jumping. Once the change starts the routine
. does not return to its caller, but to the one before, which skips the rest of
. the update of the player. The legs of the player are changed into the sparkles
. of #R$C337 and the top half is hidden.
R $C306 IX Address of the legs of the player
N $C306 Return unless the change is due and the player is ready.
  $C306,$03 Fetch the flag that says the player has to transform from #R$5BB1.
  $C309,$01 Test it.
  $C30A,$01 Return if the player does not have to transform.
  $C30B,$03 Fetch the counter and flags of the player.
  $C30E,$02,b$01 Keep the counter that runs when the player enters the room.
  $C310,$01 Return if the player has only just entered the room.
  $C311,$04 Test whether the player is jumping.
  $C315,$01 Return if so.
N $C316 Hide the top half and start the sparkle transformation.
  $C316,$02 Drop the return address from the stack.
  $C318,$03 Fetch the graphic number of the player.
  $C31B,$03 Keep it, as the flag that the player is transforming at #R$5BB1.
  $C31E,$04 Set the number of steps of the transformation to #N$08.
  $C322,$02 Stash #REGix on the stack.
  $C324,$03 Set #REGde to the size of an object.
  $C327,$02 Point #REGix at the top half of the player.
  $C329,$04 Change the graphic of the top half to one that is not shown.
  $C32D,$03 Flag the top half to be wiped and drawn.
  $C330,$02 Restore #REGix from the stack.
  $C332,$03 Set the pixel adjustments of a transforming player.
  $C335,$02 Jump to #R$C357.

c $C337 Handle Transformation
@ $C337 label=HandleTransformation
D $C337 Handles the graphic numbers #N$5C to #N($5F), which are the legs of the
. player while the player transforms. Every fourth frame a different one of
. these graphics is chosen at random, and the sound of a transformation is
. played. When the number of steps has run out the player becomes human or wulf.
. If the player is killed during the transformation, the death sparkles start.
R $C337 IX Address of the legs of the player
  $C337,$03 Set the pixel adjustments of a transforming player.
  $C33A,$06 Jump to #R$C349 if not.
  $C340,$03 Fetch the flag that says the game has been completed from #R$5BC3.
  $C343,$01 Test it.
  $C344,$02 Jump to #R$C349 if it has been.
  $C346,$03 Start the death sparkles.
@ $C349 label=HandleTransformation_Step
  $C349,$03 Fetch the frame counter from #R$5BA2.
  $C34C,$02,b$01 Keep the lowest two bits.
  $C34E,$01 Return unless it is one frame in four.
  $C34F,$03 Play the sound of a transformation.
  $C352,$03 Decrease the number of steps left.
  $C355,$02 Jump to #R$C377 when the transformation is done.
@ $C357 label=HandleTransformation_Flicker
N $C357 Choose a graphic for the legs at random, and turn it round.
  $C357,$02 Fetch a random number from the refresh register.
  $C359,$01 Stash it in #REGc.
  $C35A,$03 Fetch the second random seed from #R$5BA5.
  $C35D,$01 Add the random number.
  $C35E,$02,b$01 Keep the lowest two bits.
  $C360,$02,b$01 Make it one of the graphic numbers #N$5C to #N$5F.
  $C362,$03 Compare it with the graphic of the legs.
  $C365,$02 Jump to #R$C369 if it is different.
  $C367,$02,b$01 Change to the other graphic of the pair.
@ $C369 label=HandleTransformation_SetGraphic
  $C369,$03 Set the graphic number of the legs.
  $C36C,$03 Fetch the flags of the legs.
  $C36F,$02,b$01 Flip the sprite horizontally.
  $C371,$03 Store the flags.
  $C374,$03 Flag the object to be wiped and drawn.
@ $C377 label=HandleTransformation_Finish
N $C377 The transformation is over. Change the player from human to wulf, or
. from wulf to human.
  $C377,$03 Fetch the graphic number that the legs had before the transformation
. from #R$5BB1.
  $C37A,$02,b$01 Change it from human to wulf, or back.
  $C37C,$03 Set the graphic number of the legs.
  $C37F,$02 Work out the graphic number of the top half.
  $C381,$03 Set the graphic number of the top half.
  $C384,$01 Clear #REGa.
  $C385,$03 Flag that the player is not transforming at #R$5BB1.
  $C388,$03 Set the pixel adjustments of the legs.
  $C38B,$06 Jump to #R$C394 if not.
  $C391,$03 Lower the pixel adjustment in Y by one.
@ $C394 label=HandleTransformation_Draw
  $C394,$03 Flag the object to be wiped and drawn.

c $C397 Move Sun Moon
@ $C397 label=MoveSunMoon
D $C397 Moves the sun or moon along the arc in the window of the panel by one
. pixel, on one frame in eight, and shows it.
  $C397,$03 Fetch the frame counter from #R$5BA2.
  $C39A,$02,b$01 Keep the lowest three bits.
  $C39C,$01 Return unless it is one frame in eight.
  $C39D,$04 Point #REGix at #R$C44D.
  $C3A1,$03 Move the sun/moon one pixel to the right.

c $C3A4 Display Sun Moon Frame
@ $C3A4 label=DisplaySunMoonFrame
D $C3A4 Shows the window of the panel that holds the sun or the moon, and the
. sun or moon in it. The sun and the moon go along an arc from pixel X
. coordinate #N$B0 to #N($E0), which is the height from the table at #R$C440.
. When one of them gets to the end the other takes over, the player
. transforms, and each time the sun comes back a day is added and the day is
. shown on the panel.
. When #N$40 days have passed the game is over. Nothing is done when the final
. animation is under way.
R $C3A4 IX Address of the sun/moon object
  $C3A4,$03 Fetch the flag that says the final animation has started from
. #R$5BC3.
  $C3A7,$01 Test it.
  $C3A8,$01 Return if the final animation has started.
  $C3A9,$03 Fetch the pixel X coordinate of the sun/moon.
  $C3AC,$04 Jump to #R$C3FF if the sun/moon has got there.
  $C3B0,$03 Fetch the pixel X coordinate.
  $C3B3,$02 Add #N$10 to it.
  $C3B5,$03 Point #REGhl at #R$C440.
  $C3B8,$02 Divide the number by four.
  $C3BA,$02,b$01 Keep the lowest four bits.
  $C3BC,$03 Find the address of the height.
  $C3BF,$01 Fetch the height.
  $C3C0,$03 Set the pixel Y coordinate of the sun/moon.
@ $C3C3 label=DisplaySunMoonFrame_Draw
N $C3C3 Draw the window in the screen buffer, wiping what was there first.
  $C3C3,$03 Set the number of lines to #N$1F and the number of bytes to #N$06.
  $C3C6,$03 Point #REGhl at #R$D90A.
  $C3C9,$01 Stash the size of the window on the stack.
  $C3CA,$01 Stash the position of the window on the stack.
  $C3CB,$03 Swap #REGb and #REGc, so that #REGb is the width and #REGc is the
. height.
  $C3CE,$01 Clear #REGa.
  $C3CF,$03 Clear the window.
  $C3D2,$03 Draw the sun/moon.
  $C3D5,$04 Point #REGix at #R$BFDB.
  $C3D9,$04 Clear the flags.
  $C3DD,$04 Set the graphic number to the left of the frame.
  $C3E1,$04 Set the pixel X coordinate to #N$B8.
  $C3E5,$04 Set the pixel Y coordinate to #N$00.
  $C3E9,$03 Draw the left of the frame.
  $C3EC,$04 Set the pixel X coordinate to #N$D0.
  $C3F0,$04 Set the graphic number to the right of the frame.
  $C3F4,$03 Draw the right of the frame.
  $C3F7,$01 Restore the position of the window from the stack.
  $C3F8,$01 Restore the size of the window from the stack.
  $C3F9,$03 Point #REGde at the position of the window on the display.
  $C3FC,$03 Copy the window from the screen buffer to the display.
@ $C3FF label=DisplaySunMoonFrame_Toggle
N $C3FF The sun or the moon has gone round: change to the other one, which makes
. the player transform. Add a day when it is the sun that is coming back.
  $C3FF,$03 Fetch the graphic number of the sun/moon.
  $C402,$02,b$01 Change the sun to the moon, or the moon to the sun.
  $C404,$03 Set the graphic number of the sun/moon.
  $C407,$03 Colour the sun/moon.
  $C40A,$04 Set the pixel X coordinate of the sun/moon back to the start.
  $C40E,$02 Get the value that sets a flag.
  $C410,$03 Flag that the player has to transform at #R$5BB1.
  $C413,$03 Fetch the graphic number of the sun/moon from #R$C44D.
  $C416,$02,b$01 Keep the lowest bit.
  $C418,$01 Return if it is the moon.
@ $C419 label=DisplaySunMoonFrame_AddDay
  $C419,$03 Point #REGhl at #R$5BB9.
  $C41C,$01 Fetch it.
  $C41D,$02 Add one.
  $C41F,$01 Keep it as a BCD number.
  $C420,$01 Store it.
  $C421,$05 Jump to #R$BA22 if they have all gone.
  $C426,$03 Print the number of days.
  $C429,$03 Set the position of the days on the panel.
  $C42C,$03 Copy the number of days from the screen buffer to the display.
  $C42F,$03 Jump to #R$C3C3.

c $C432 Copy Area To Screen
@ $C432 label=CopyAreaToScreen
D $C432 Copies a block of the screen buffer, which is two bytes wide and eight
. lines high, to the display.
E $C432 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BF2F }
. LIST#
R $C432 B Pixel Y coordinate
R $C432 C Pixel X coordinate
  $C432,$03 Find the address in the display.
  $C435,$03 Find the address in the screen buffer.
  $C438,$02 Copy it to #REGhl.
  $C43A,$03 Set the number of lines to #N$08 and the number of bytes to #N$02.
  $C43D,$03 Copy the block to the display.

b $C440 Sun Moon Heights
@ $C440 label=SunMoonHeights
D $C440 The pixel Y coordinates of the sun and moon as they move along the arc
. of the window, one for every four pixels.
B $C440,$0D,$0D

g $C44D Sun Moon Object
@ $C44D label=SunMoonObject
D $C44D The object that is used to draw the sun and the moon.
B $C44D,$20,$08

c $C46D Initialise Sun
@ $C46D label=InitialiseSun
D $C46D Sets the sun/moon object to the sun at the start of the arc.
  $C46D,$04 Point #REGix at the sun/moon object, #R$C44D.
  $C471,$04 Set the graphic number to #N($58), which is the sun.
  $C475,$04 Set the pixel X coordinate to #N$B0.
  $C479,$04 Set the pixel Y coordinate to #N$09.
  $C47D,$01 Return.

c $C47E Initialise Special Objects
@ $C47E label=InitialiseSpecialObjects
D $C47E Chooses the objects in #R$6FF2 at the start of a game. Each is given a
. graphic number from #N$60 to #N$67, taken from a number made from the random
. number seed and the refresh register. The starting position of each entry is
. copied to the current position.
E $C47E View the equivalent code in;
. #LIST
. { #ALIENEIGHT$AF3F }
. LIST#
N $C47E Stir the seed and fill the table.
  $C47E,$03 Point #REGhl at the first special object, #R$6FF2.
  $C481,$03 Fetch the first random seed from #R$5BA0.
  $C484,$01 Keep it in #REGe.
  $C485,$02 Fetch the refresh register.
  $C487,$01 Add the seed to it.
  $C488,$01 Keep the result in #REGe.
@ $C489 label=InitialiseSpecialObjects_Next
  $C489,$01 Copy the number to #REGa.
  $C48A,$02,b$01 Keep bits 0 to 2.
  $C48C,$02,b$01 Make it a graphic number from #N$60 to #N$67.
  $C48E,$01 Set the graphic number of the object.
  $C48F,$01 Move on to the starting position.
  $C490,$01 Change the number, for the next object.
  $C491,$01 Stash the number on the stack.
  $C492,$01 Swap the entry pointer into #REGde.
  $C493,$03 Set #REGhl to #N($0004,$04,$04).
  $C496,$01 Add it to the starting position.
  $C497,$01 Swap the pointers back.
  $C498,$03 Set #REGbc to #N($0004,$04,$04).
  $C49B,$02 Copy the starting position and room.
  $C49D,$01 Point #REGhl at the next object.
  $C49E,$01 Stash the next entry on the stack.
  $C49F,$03 Point #REGbc at #R$7112.
  $C4A2,$03 Subtract #R$7112 from #REGhl.
  $C4A5,$01 Restore the address of the next object from the stack.
  $C4A6,$01 Restore the number from the stack.
  $C4A7,$02 Jump to #R$C489 until every object has been done.
  $C4A9,$01 Return.

c $C4AA Handle Block
@ $C4AA label=HandleBlock
D $C4AA Handles the graphic number #N($3E), which is a block that can fall. Its
. speeds in X and Y are cleared, so that it only falls, and the sound of a block
. is played.
R $C4AA IX Address of the block object
  $C4AA,$03 Set the pixel adjustments of a block.
  $C4AD,$03 Clear the speeds in X and Y.
  $C4B0,$03 Play the sound of a block.
  $C4B3,$03 Move the block and flag it to be drawn again.

c $C4B6 Handle Chest
@ $C4B6 label=HandleChest
D $C4B6 Handles a chest, which falls when there is nothing below it. It plays
. the sound of a moving object, and is drawn again, only when it is moving.
R $C4B6 IX Address of the chest object
  $C4B6,$03 Set the pixel adjustments of a block.
  $C4B9,$03 Apply gravity to the chest and move it.
  $C4BC,$03 Test whether the chest is moving.
  $C4BF,$01 Return if it is not.
  $C4C0,$03 Play the sound of a moving object and flag the chest to be drawn
. again.

c $C4C3 Handle Table
@ $C4C3 label=HandleTable
D $C4C3 Handles a table, which falls when there is nothing below it. It plays
. the sound of a moving object, and is drawn again, only when it is moving, with
. its speeds in X and Y cleared.
R $C4C3 IX Address of the table object
  $C4C3,$03 Set the pixel adjustments of a block.
@ $C4C6 label=HandleTable_Fall
  $C4C6,$03 Apply gravity to the object and move it.
  $C4C9,$03 Test whether the object is moving.
  $C4CC,$01 Return if it is not.
  $C4CD,$03 Clear the speeds in X and Y.
  $C4D0,$03 Play the sound of a moving object and flag the object to be drawn
. again.

c $C4D3 Set Pixel Adjustments
@ $C4D3 label=SetPixelAdjustments
D $C4D3 Sets the number of pixels that the sprite of an object is moved by, in X
. and Y, from its position. There is an entry point for each of the sets of
. adjustments that are used, and the one that is used for an object depends on
. its sprite. The adjustment in X goes in #REGl and the adjustment in Y goes in
. #REGh.
R $C4D3 IX Address of the object
  $C4D3,$03 Set the adjustments of a tree wall, which are #N$F8 in X and #N$FE
. in Y.
  $C4D6,$02 Jump to #R$C4E0.
@ $C4D8 label=SetPixelAdjustments_Sparkle
N $C4D8 The adjustments of sparkles and special objects: #N$F4 in X and #N$FC in
. Y.
  $C4D8,$03 Set the adjustments.
  $C4DB,$02 Jump to #R$C4E0.
@ $C4DD label=SetPixelAdjustments_Legs
N $C4DD The adjustments of the bottom half of a guard or of a human: #N$F4 in X
. and #N$FA in Y.
  $C4DD,$03 Set the adjustments.
@ $C4E0 label=SetPixelAdjustments_Set
  $C4E0,$03 Set the adjustments of the object.
@ $C4E3 label=SetPixelAdjustments_Block
N $C4E3 The adjustments of rocks and blocks: #N$F0 in X and #N$F8 in Y.
  $C4E3,$03 Set the adjustments.
  $C4E6,$02 Jump to #R$C4E0.
@ $C4E8 label=SetPixelAdjustments_Bricks10
N $C4E8 The adjustments of the bricks of graphic number #N$0A: #N$EC in X and
. #N$FF in Y.
  $C4E8,$03 Set the adjustments.
  $C4EB,$02 Jump to #R$C4E0.
@ $C4ED label=SetPixelAdjustments_Bricks11
N $C4ED The adjustments of the bricks of graphic number #N$0B and of a
. transforming player: #N$F4 in X and #N$FE in Y.
  $C4ED,$03 Set the adjustments.
  $C4F0,$02 Jump to #R$C4E0.
@ $C4F2 label=SetPixelAdjustments_Ball
N $C4F2 The adjustments of bricks of graphic numbers #N$0C to #N($0F), balls and
. fire: #N$F8 in X and #N$FC in Y.
  $C4F2,$03 Set the adjustments.
  $C4F5,$02 Jump to #R$C4E0.
@ $C4F7 label=SetPixelAdjustments_Wide
N $C4F7 The adjustments of #N$F4 in X and #N$F8 in Y.
  $C4F7,$03 Set the adjustments.
  $C4FA,$02 Jump to #R$C4E0.
@ $C4FC label=SetPixelAdjustments_Wulf
N $C4FC The adjustments of the legs of the wulf and of a gargoyle: #N$F4 in X
. and #N$F9 in Y.
  $C4FC,$03 Set the adjustments.
  $C4FF,$02 Jump to #R$C4E0.
@ $C501 label=SetPixelAdjustments_Wider
N $C501 The adjustments of #N$F4 in X and #N$F4 in Y.
  $C501,$03 Set the adjustments.
  $C504,$02 Jump to #R$C4E0.
@ $C506 label=SetPixelAdjustments_Cauldron
N $C506 The adjustments of the bottom half of the cauldron: #N$F0 in X and #N$F4
. in Y.
  $C506,$03 Set the adjustments.
  $C509,$02 Jump to #R$C4E0.
@ $C50B label=SetPixelAdjustments_Guard
N $C50B The adjustments of a guard that moves east and west: #N$F4 in X and
. #N$07 in Y.
  $C50B,$03 Set the adjustments.
  $C50E,$02 Jump to #R$C4E0.
@ $C510 label=SetPixelAdjustments_GuardTop
N $C510 The adjustments of the top half of a guard: #N$F4 in X and #N$03 in Y.
  $C510,$03 Set the adjustments.
  $C513,$02 Jump to #R$C4E0.

c $C515 Fill Window
@ $C515 label=FillWindow
D $C515 Fills a rectangle of the screen buffer, or of the attribute file, with
. one byte. The rows of the rectangle are #N$20 bytes apart.
E $C515 View the equivalent code in;
. #LIST
. { #PENTAGRAM$B6DD }
. LIST#
R $C515 A Byte to fill the rectangle with
R $C515 B Width of the rectangle in bytes
R $C515 C Height of the rectangle in lines
R $C515 HL Address of the first byte
N $C515 Fill each line of the rectangle, then move down a row.
  $C515,$03 Set #REGde to the length of a line.
@ $C518 label=FillWindow_Line
  $C518,$01 Stash the width and height on the stack.
  $C519,$01 Stash the address of the start of the line on the stack.
@ $C51A label=FillWindow_Byte
  $C51A,$01 Fill a byte.
  $C51B,$01 Move on to the next byte.
  $C51C,$02 Jump to #R$C51A until the line is filled.
  $C51E,$01 Restore the address of the start of the line from the stack.
  $C51F,$01 Move on to the next line.
  $C520,$01 Restore the width and height from the stack.
  $C521,$01 Decrease the number of lines left.
  $C522,$02 Jump to #R$C518 until all of the lines have been filled.
  $C524,$01 Return.

c $C525 Place Special Objects In Room
@ $C525 label=PlaceSpecialObjectsInRoom
D $C525 Makes the list of the special objects that are in the room that the
. player is in, ready to be updated like any other object. Every entry of the
. table of special objects at #R$6FF2 that is in the room is copied to the
. objects table (up to two of them), with the width and depth of #N($05), the
. height of #N$0C and the flags for drawing and for being able to move. The
. address of the entry is kept at #N$10 bytes into the object, so that it can be
. updated by #R$C591. The rest of the objects table for the special objects is
. cleared.
E $C525 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$AE99 }
. LIST#
R $C525 IX Address of the player
  $C525,$03 Point #REGde at the first special object of the room, #R$5C48.
  $C528,$01 Switch to the alternate registers to keep it there.
  $C529,$04 Point #REGiy at #R$6FF2.
  $C52D,$03 Fetch the room that the player is in.
@ $C530 label=PlaceSpecialObjectsInRoom_TestEntry
  $C530,$03 Fetch the graphic number of the entry.
  $C533,$01 Test whether there is an object.
  $C534,$02 Jump to #R$C572 if there is not.
  $C536,$03 Fetch the room that the object is in.
  $C539,$01 Compare it with the room that the player is in.
  $C53A,$02 Jump to #R$C572 if they are different.
  $C53C,$02 Stash the address of the entry on the stack.
  $C53E,$01 Switch back to the registers that hold the address of the special
. object of the room.
  $C53F,$01 Restore the address of the entry from the stack.
  $C540,$01 Stash it again on the stack.
  $C541,$01 Fetch the graphic number.
  $C542,$01 Move on to the starting position.
  $C543,$01 Set the graphic number of the special object of the room.
  $C544,$01 Move on to the X coordinate.
  $C545,$04 Point #REGhl at the current position of the object.
  $C549,$03 Set the number of bytes to copy to #N$03.
  $C54C,$02 Copy the coordinates.
  $C54E,$01 Point #REGhl at the width of the special object of the room.
  $C54F,$02 Set the width to #N$05.
  $C551,$01 Move on to the depth.
  $C552,$02 Set the depth to #N$05.
  $C554,$01 Move on to the height.
  $C555,$02 Set the height to #N$0C.
  $C557,$01 Move on to the flags.
  $C558,$02 Set the flags to draw and to be able to move.
  $C55A,$01 Move on to the room.
  $C55B,$01 Point #REGhl at the room of the entry and #REGde at the room of the
. special object of the room.
  $C55C,$01 Fetch the room.
  $C55D,$01 Move on to the next byte.
  $C55E,$01 Set the room.
  $C55F,$01 Move on to the speeds.
  $C560,$02 Set the number of bytes to clear to #N$07.
  $C562,$03 Clear them.
  $C565,$01 Restore the address of the entry from the stack.
  $C566,$01 Fetch the low byte.
  $C567,$01 Store it.
  $C568,$01 Move on to the high byte.
  $C569,$01 Fetch the high byte.
  $C56A,$01 Store it.
  $C56B,$01 Move on.
  $C56C,$02 Set the number of bytes to clear to #N$0E.
  $C56E,$03 Clear them.
  $C571,$01 Switch to the alternate registers.
@ $C572 label=PlaceSpecialObjectsInRoom_NextEntry
  $C572,$03 Set #REGde to the size of an entry.
  $C575,$02 Point #REGiy at the next entry.
  $C577,$03 Copy #REGiy to #REGhl (using the stack).
  $C57A,$03 Point #REGde at the end of the table, #R$7112.
  $C57D,$03 Subtract the address of the end of the table.
  $C580,$02 Jump to #R$C530 until all of the entries have been done.
  $C582,$01 Switch to the registers that hold the address of the special object
. of the room.
@ $C583 label=PlaceSpecialObjectsInRoom_ClearSlots
N $C583 Clear what is left of the special objects of the room.
  $C583,$03 Point #REGhl at the end of the special objects of the room, #R$5C88.
  $C586,$03 Subtract the address of the object that is next.
  $C589,$01 Return if there is no more room.
  $C58A,$02 Set the number of bytes to clear to #N$20.
  $C58C,$03 Clear them.
  $C58F,$02 Jump to #R$C583.

c $C591 Update Special Objects
@ $C591 label=UpdateSpecialObjects
D $C591 Copies the graphic number and the current position of each special
. object of the room back to the table of special objects, so that they are not
. lost when the player leaves the room.
E $C591 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$AF05 }
. LIST#
N $C591 Copy each special object of the room back to the table.
  $C591,$04 Point #REGiy at the first special object of the room, #R$5C48.
@ $C595 label=UpdateSpecialObjects_Next
  $C595,$03 Fetch the graphic number of the object.
  $C598,$01 Test whether there is an object.
  $C599,$02 Jump to #R$C5B7 if there is not.
  $C59B,$03 Fetch the low byte of the address of the entry in the table of
. special objects.
  $C59E,$03 Fetch the high byte.
  $C5A1,$03 Fetch the graphic number of the object.
  $C5A4,$01 Store it in the entry.
  $C5A5,$05 Point #REGde at the current X coordinate of the entry.
  $C5AA,$03 Copy #REGiy to #REGhl (using the stack).
  $C5AD,$01 Point #REGhl at the X coordinate of the object.
  $C5AE,$03 Set the number of bytes to copy to #N$03.
  $C5B1,$02 Copy the position of the object to the entry.
  $C5B3,$03 Fetch the room of the object.
  $C5B6,$01 Store it in the entry.
@ $C5B7 label=UpdateSpecialObjects_NextSlot
  $C5B7,$03 Set #REGbc to the size of an object.
  $C5BA,$02 Point #REGiy at the next object.
  $C5BC,$03 Copy #REGiy to #REGhl (using the stack).
  $C5BF,$03 Point #REGbc at the end of the special objects of the room, #R$5C88.
  $C5C2,$03 Subtract the address of the end.
  $C5C5,$02 Jump to #R$C595 until both of the objects have been done.
  $C5C7,$01 Return.

c $C5C8 Handle Ghost
@ $C5C8 label=HandleGhost
D $C5C8 Handles the graphic numbers #N$50 to #N($53), which are a ghost. The
. ghost moves in a straight line until it hits something, or does not move at
. all, and then it picks a new direction at random: its speed in X and in Y
. is #N$03 or #N($04), in either direction. The graphic of the ghost shows
. the way it moves, and is changed between its two frames each time. The
. ghost is deadly.
R $C5C8 IX Address of the ghost object
  $C5C8,$03 Set the pixel adjustments of the bottom half of a guard.
  $C5CB,$03 Apply gravity to the ghost and move it.
  $C5CE,$03 Fetch the speed in X.
  $C5D1,$03 Combine it with the speed in Y.
  $C5D4,$02 Jump to #R$C5DD if the ghost is not moving.
  $C5D6,$03 Fetch the flags that say what the ghost has hit.
  $C5D9,$02,b$01 Keep the bits for X and Y.
  $C5DB,$02 Jump to #R$C5FD if the ghost has not hit anything.
@ $C5DD label=HandleGhost_NewDirection
N $C5DD Choose a new direction.
  $C5DD,$03 Fetch the second random seed from #R$5BA5.
  $C5E0,$02,b$01 Keep the lowest two bits.
  $C5E2,$02 Add #N($04), to get a number from #N$04 to #N$07.
  $C5E4,$03 Look up the speed.
  $C5E7,$03 Set the speed in X.
  $C5EA,$03 Fetch the frame counter from #R$5BA2.
  $C5ED,$02,b$01 Keep the lowest two bits.
  $C5EF,$02 Add #N($04), to get a number from #N$04 to #N$07.
  $C5F1,$03 Look up the speed.
  $C5F4,$03 Set the speed in Y.
  $C5F7,$03 Choose the graphic of the ghost from its direction.
  $C5FA,$03 Play the sound of a moving object.
@ $C5FD label=HandleGhost_Draw
  $C5FD,$03 Toggle the graphic of the ghost between its two frames.
  $C600,$03 Make the ghost deadly and flag it to be drawn again.

c $C603 Set Ghost Direction Graphic
@ $C603 label=SetGhostDirectionGraphic
D $C603 Chooses the graphic of the ghost from the direction in which it moves,
. by setting bit 1 of the graphic number and the flag that flips the sprite. Of
. the two speeds the larger decides it.
R $C603 IX Address of the ghost object
N $C603 Choose the graphic from the larger of the two speeds.
  $C603,$03 Fetch the speed in X.
  $C606,$01 Test it.
  $C607,$03 Jump to #R$C60C if it is positive.
  $C60A,$02 Make it positive.
@ $C60C label=SetGhostDirectionGraphic_Y
  $C60C,$01 Stash it in #REGc.
  $C60D,$03 Fetch the speed in Y.
  $C610,$01 Test it.
  $C611,$03 Jump to #R$C616 if it is positive.
  $C614,$02 Make it positive.
@ $C616 label=SetGhostDirectionGraphic_Compare
  $C616,$01 Compare the speed in X with the speed in Y.
  $C617,$02 Jump to #R$C62F if the ghost moves more in Y than in X.
  $C619,$03 Fetch the speed in X.
  $C61C,$01 Test it.
  $C61D,$03 Jump to #R$C629 if it is negative.
  $C620,$04 Select the first pair of graphics.
@ $C624 label=SetGhostDirectionGraphic_SetFlip
  $C624,$04 Flip the sprite.
  $C628,$01 Return.
@ $C629 label=SetGhostDirectionGraphic_SecondPair
  $C629,$04 Select the second pair of graphics.
  $C62D,$02 Jump to #R$C624.
@ $C62F label=SetGhostDirectionGraphic_MoreInY
  $C62F,$03 Fetch the speed in Y.
  $C632,$01 Test it.
  $C633,$03 Jump to #R$C63F if it is negative.
  $C636,$04 Select the second pair of graphics.
@ $C63A label=SetGhostDirectionGraphic_ClearFlip
  $C63A,$04 Stop the sprite from being flipped.
  $C63E,$01 Return.
@ $C63F label=SetGhostDirectionGraphic_FirstPair
  $C63F,$04 Select the first pair of graphics.
  $C643,$02 Jump to #R$C63A.

c $C645 Look Up Ghost Speed
@ $C645 label=LookUpGhostSpeed
D $C645 Looks up a speed from the table at #R$C64E.
E $C645 View the equivalent code in;
. #LIST
. { #SABREWULF$9E53 }
. LIST#
R $C645 A Number of the entry
R $C645 O:A Speed
  $C645,$03 Point #REGbc at the table of speeds, #R$C64E.
  $C648,$01 Use the number of the entry as the low byte of the offset.
  $C649,$02 Clear the high byte of the offset.
  $C64B,$01 Point #REGhl at the entry.
  $C64C,$01 Fetch the speed.
  $C64D,$01 Return.

b $C64E Ghost Speeds
@ $C64E label=GhostSpeeds
D $C64E The speeds that a ghost can be given, from #N$FF and #N$01 to #N$F8 and
. #N($08), in pairs. Only the entries #N$04 to #N$07 are used.
B $C64E,$10,$08

c $C65E Handle Portcullis
@ $C65E label=HandlePortcullis
D $C65E Handles a portcullis that is not moving. Nothing happens while another
. portcullis in the room is moving. A portcullis that is on the floor of the
. room, or no more than #N$1F above it, starts to rise on one frame in
. thirty-two. One that is higher than that starts to come down: at once for the
. first four times that a portcullis comes down, and after that on one frame in
. thirty-two.
R $C65E IX Address of the portcullis object
N $C65E Start the portcullis rising or lowering when it is time.
  $C65E,$03 Set the pixel adjustments of the bottom half of a guard.
  $C661,$03 Point #REGhl at #R$5BAF.
  $C664,$01 Fetch it.
  $C665,$01 Test it.
  $C666,$01 Return if a portcullis is moving.
  $C667,$03 Fetch the Z coordinate of the floor of the room from #R$5BAE.
  $C66A,$03 Compare it with the Z coordinate of the portcullis.
  $C66D,$02 Jump to #R$C6AD if the portcullis is on the floor.
  $C66F,$02 Add #N$1F to the height.
  $C671,$03 Compare it with the Z coordinate of the portcullis.
  $C674,$02 Jump to #R$C6AD if the portcullis is no more than #N$1F above the
. floor of the room.
  $C676,$03 Fetch the number of times that a portcullis has come down from
. #R$5BB0.
  $C679,$04 Jump to #R$C685 if it is fewer, to set off at once.
  $C67D,$03 Fetch the second random seed from #R$5BA5.
  $C680,$02,b$01 Keep the lowest five bits.
  $C682,$01 Return unless it is the time to set off.
  $C683,$02,b$01 Set #REGa to a large number, so that it stays above four.
@ $C685 label=HandlePortcullis_Lower
  $C685,$01 Add one to the number of times that a portcullis has come down.
  $C686,$03 Store it at #R$5BB0.
  $C689,$04 Change the graphic of the portcullis to the moving one.
  $C68D,$04 Set the speed in Z to move it down.
@ $C691 label=HandlePortcullis_Flag
  $C691,$01 Flag that a portcullis is moving.

c $C692 Set Wipe And Draw Flags
@ $C692 label=SetWipeAndDrawFlags
D $C692 Flags an object to be wiped and drawn again, and flags every other
. object that overlaps it to be drawn too.
E $C692 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BFAB }
. { #PENTAGRAM$CCDE }
. LIST#
R $C692 IX Address of the object
  $C692,$03 Fetch the flags of the object.
  $C695,$02,b$01 Set the bits that flag the object to be wiped and drawn.
  $C697,$03 Store the flags.
  $C69A,$03 Flag the objects that overlap it to be drawn.

c $C69D Set Wipe And Draw Flags For Object
@ $C69D label=SetWipeAndDrawFlagsForObject
D $C69D Flags the object that #REGiy points at to be wiped and drawn again, as
. #R$C692 does.
E $C69D View the equivalent code in;
. #LIST
. { #ALIENEIGHT$ADF3 }
. { #PENTAGRAM$BF56 }
. LIST#
R $C69D IY Address of the object
  $C69D,$02 Stash #REGiy on the stack.
  $C69F,$02 Stash #REGix on the stack.
  $C6A1,$04 Copy #REGiy to #REGix (using the stack).
  $C6A5,$03 Flag the object to be wiped and drawn.
  $C6A8,$02 Restore #REGix from the stack.
  $C6AA,$02 Restore #REGiy from the stack.
  $C6AC,$01 Return.

c $C6AD Start Portcullis Rising
@ $C6AD label=StartPortcullisRising
D $C6AD Starts a portcullis rising, on one frame in thirty-two.
R $C6AD IX Address of the portcullis object
  $C6AD,$03 Fetch the second random seed from #R$5BA5.
  $C6B0,$02,b$01 Keep the lowest five bits.
  $C6B2,$01 Return unless it is the time to set off.
  $C6B3,$04 Change the graphic of the portcullis to the moving one.
  $C6B7,$04 Set the speed in Z to move it up.
  $C6BB,$02 Jump to #R$C691.

c $C6BD Handle Moving Portcullis
@ $C6BD label=HandleMovingPortcullis
D $C6BD Handles a portcullis that is moving. A portcullis that is coming down is
. deadly. It speeds up as it falls until it hits the floor, and the sound of a
. portcullis is played. One that is going up moves at a speed of #N$02 until it
. is #N$1F above the floor of the room. When it is done the portcullis stops,
. and the next one is free to start.
R $C6BD IX Address of the portcullis object
N $C6BD Fall and speed up, or rise, until the portcullis is done.
  $C6BD,$03 Set the pixel adjustments of the bottom half of a guard.
  $C6C0,$04 Make the portcullis deadly.
  $C6C4,$03 Fetch the counter and flags of the player.
  $C6C7,$02,b$01 Keep the counter that runs when the player enters the room.
  $C6C9,$01 Return if the player has only just entered the room.
  $C6CA,$03 Fetch the speed in Z.
  $C6CD,$01 Test it.
  $C6CE,$03 Jump to #R$C6EA if the portcullis is going up.
  $C6D1,$03 Increase the speed of the fall.
  $C6D4,$03 Apply gravity to the portcullis and move it.
  $C6D7,$06 Jump to #R$C692 if the portcullis has not hit the floor.
  $C6DD,$03 Play the sound of a portcullis.
@ $C6E0 label=HandleMovingPortcullis_Stop
N $C6E0 Stop the portcullis and free the next one to start.
  $C6E0,$01 Clear #REGa.
  $C6E1,$03 Flag that no portcullis is moving at #R$5BAF.
  $C6E4,$04 Change the graphic of the portcullis to the stationary one.
  $C6E8,$02 Jump to #R$C692.
@ $C6EA label=HandleMovingPortcullis_Rise
N $C6EA Rise until the portcullis is #N$1F above the floor.
  $C6EA,$04 Set the speed in Z to #N$02.
  $C6EE,$03 Play the sound of a moving object.
  $C6F1,$03 Apply gravity to the portcullis and move it.
  $C6F4,$03 Fetch the Z coordinate of the floor of the room from #R$5BAE.
  $C6F7,$02 Add #N$1F to it.
  $C6F9,$03 Compare it with the Z coordinate of the portcullis.
  $C6FC,$02 Jump to #R$C692 if the portcullis has not yet reached the top.
  $C6FE,$02 Jump to #R$C6E0 to stop it.

c $C700 Apply Gravity And Move
@ $C700 label=ApplyGravityAndMove
D $C700 Makes an object fall faster, then moves it. #R$C706 only moves the
. object.
E $C700 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BFB6 }
. { #PENTAGRAM$B979 }
. LIST#
R $C700 IX The address of the object
N $C700 Speed the fall, then stay clear of walls and other objects.
  $C700,$03 Take one off the z speed of the object.
  $C703,$03 Stop the object moving through other objects and the walls of the
. room.
N $C706 Add the speeds to the position.
@ $C706 label=MoveObject
  $C706,$03 Fetch the x position of the object.
  $C709,$03 Add the speed along the x axis.
  $C70C,$03 Set the new x position.
  $C70F,$03 Fetch the y position of the object.
  $C712,$03 Add the speed along the y axis.
  $C715,$03 Set the new y position.
  $C718,$03 Fetch the z position of the object.
  $C71B,$03 Add the speed along the z axis.
  $C71E,$03 Set the new z position.
  $C721,$01 Return.

c $C722 Handle Far Arch
@ $C722 label=HandleFarArch
D $C722 Handles the graphic numbers #N$03 and #N($05), which are the far side of
. an arch. They only need the pixel adjustments of the sprite, which are not the
. same when the sprite is flipped.
R $C722 IX Address of the arch object
  $C722,$06 Jump to #R$C732 if the arch is flipped horizontally.
  $C728,$03 Set the adjustments of #N$F7 in X and #N$FD in Y.

c $C72B Store Pixel Adjustments
@ $C72B label=StorePixelAdjustments
D $C72B Sets the adjustments to the position of the sprite of an object.
E $C72B View the equivalent code in;
. #LIST
. { #PENTAGRAM$C76E }
. LIST#
R $C72B H Adjustment in Y
R $C72B L Adjustment in X
R $C72B IX Address of the object
  $C72B,$03 Set the adjustment in X.
  $C72E,$03 Set the adjustment in Y.
  $C731,$01 Return.

c $C732 Adjust Flipped Far Arch
@ $C732 label=AdjustFlippedFarArch
D $C732 Sets the adjustments for the far side of an arch whose sprite is
. flipped.
R $C732 IX Address of the arch object
  $C732,$03 Set #REGhl to the adjustments of #N$F9 in X and #N$FE in Y.
  $C735,$02 Jump to #R$C72B.

c $C737 Adjust Tree Arch
@ $C737 label=AdjustTreeArch
D $C737 Sets the adjustments for the near side of a tree arch, and carries on to
. find where the middle of the arch is.
R $C737 IX Address of the arch object
  $C737,$03 Set #REGhl to the adjustments of #N$01 in X and #N$FD in Y.
  $C73A,$02 Jump to #R$C74C.

c $C73C Handle Near Arch
@ $C73C label=HandleNearArch
D $C73C The handler for the near side of an arch (objects #N$02 and #N$04). As
. an arch does not move, its speeds are used to keep the position of the middle
. of the doorway: the middle is #N$0D further along the y axis than the arch, or
. #N$0D further back along the x axis if the sprite is flipped. The player, and
. any special object, is flagged if near the arch, and is nudged towards the
. middle of the doorway.
E $C73C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BFEA }
. { #PENTAGRAM$C7AD }
. LIST#
R $C73C IX The address of the object
N $C73C Unflipped: doorway #N$0D along y.
  $C73C,$06 Jump to #R$C76C if the arch is flipped horizontally.
  $C742,$03 Fetch the graphic number of the arch.
  $C745,$04 Jump to #R$C737 if it is a tree arch.
  $C749,$03 Set #REGhl to #N$FDF9.
N $C74C The doorway is thirteen units further along the Y axis than the arch.
@ $C74C label=HandleNearArch_Position
  $C74C,$03 Call #R$C72B.
  $C74F,$03 Fetch the y position of the arch.
  $C752,$02 Add #N$0D.
  $C754,$03 Keep it as the Y coordinate of the middle of the doorway.
  $C757,$03 Fetch the x position of the arch.
  $C75A,$03 Keep it as the X coordinate of the middle of the doorway.
  $C75D,$03 Set #REGhl to #N$060F.
N $C760 Keep z and flag or nudge the player.
@ $C760 label=HandleNearArch_Near
  $C760,$03 Fetch the z position of the arch.
  $C763,$03 Keep it as the Z coordinate of the middle of the doorway.
  $C766,$03 Flag the objects that are near the arch.
  $C769,$03 Jump to #R$C785.

c $C76C Handle Flipped Near Arch
@ $C76C label=HandleFlippedNearArch
D $C76C Sets up the near side of an arch whose sprite is flipped. The middle of
. the doorway is thirteen units back along the X axis.
R $C76C IX Address of the arch object
N $C76C Set the doorway middle and the distances that count as near.
  $C76C,$03 Set #REGhl to the adjustments of #N$EF in X and #N$FE in Y.
  $C76F,$03 Set the adjustments.
  $C772,$03 Fetch the X coordinate of the arch.
  $C775,$02 Take #N$0D off it.
  $C777,$03 Keep it as the X coordinate of the middle of the doorway.
  $C77A,$03 Fetch the Y coordinate of the arch.
  $C77D,$03 Keep it as the Y coordinate of the middle of the doorway.
  $C780,$03 Set #REGh to the distance in Y that counts as near and #REGl to the
. distance in X.
  $C783,$02 Jump to #R$C760.

c $C785 Nudge Objects To Arch
@ $C785 label=NudgeObjectsToArch
D $C785 Nudges the player and the special objects towards the middle of a
. doorway, if they are close enough to the arch and are flagged to be adjusted.
. The way in which they are nudged is picked from the table at #R$C7A9, by the
. direction in which the arch faces.
R $C785 IX Address of the arch object
N $C785 Nudge each nearby object towards the middle of the doorway.
  $C785,$03 Set the distances that count as near to #N$0F in X and in Y.
  $C788,$04 Point #REGiy at #R$5C08.
  $C78C,$03 Set #REGde to the size of an object.
  $C78F,$02 Set the number of objects to #N($04), which is the player and the
. special objects.
@ $C791 label=NudgeObjectsToArch_Next
  $C791,$03 Fetch the graphic number of the object.
  $C794,$01 Test whether there is an object.
  $C795,$02 Jump to #R$C7D6 if there is not.
  $C797,$06 Jump to #R$C7D6 if the object is not flagged to be adjusted near
. arches.
  $C79D,$03 Test whether the object is near the arch.
  $C7A0,$02 Jump to #R$C7D6 if it is not.
  $C7A2,$01 Stash the number of objects left on the stack.
  $C7A3,$03 Point #REGbc at #R$C7A9.
  $C7A6,$03 Jump to the routine for the direction of the arch.

w $C7A9 Arch Direction Table
@ $C7A9 label=ArchDirectionTable
D $C7A9 The routines that nudge an object towards the middle of a doorway, by
. the direction of the arch: the lowest bit is bit 3 of the graphic number of
. the arch, and the next is whether the sprite is flipped.
W $C7A9,$04,$02 Not flipped: #R$C7B1.
W $C7AD,$04,$02 Flipped: #R$C7C4.

c $C7B1 Nudge Object East West
@ $C7B1 label=NudgeObjectEastWest
D $C7B1 Sets the adjustment of the speed in Y of an object, to bring it a step
. closer to the middle line of an arch that goes east and west.
E $C7B1 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C050 }
. { #PENTAGRAM$C907 }
. LIST#
R $C7B1 IX Address of the arch object
R $C7B1 IY Address of the object
N $C7B1 Step the object towards the east-west middle line.
  $C7B1,$03 Fetch the Y coordinate of the middle of the doorway.
  $C7B4,$03 Compare it with the Y coordinate of the object.
  $C7B7,$02 Jump to #R$C7D5 if the object is in the middle.
  $C7B9,$02 Set the adjustment to #N$01.
  $C7BB,$02 Jump to #R$C7BF if the object is south of the middle.
  $C7BD,$02 Make the adjustment negative.
@ $C7BF label=NudgeObjectEastWest_Set
  $C7BF,$03 Set the adjustment of the speed in Y of the object.
  $C7C2,$02 Jump to #R$C7D5.

c $C7C4 Nudge Object North South
@ $C7C4 label=NudgeObjectNorthSouth
D $C7C4 Sets the adjustment of the speed in X of an object, to bring it a step
. closer to the middle line of an arch that goes north and south.
R $C7C4 IX Address of the arch object
R $C7C4 IY Address of the object
N $C7C4 Step the object towards the north-south middle line.
  $C7C4,$03 Fetch the X coordinate of the middle of the doorway.
  $C7C7,$03 Compare it with the X coordinate of the object.
  $C7CA,$02 Jump to #R$C7D5 if the object is in the middle.
  $C7CC,$02 Set the adjustment to #N$01.
  $C7CE,$02 Jump to #R$C7D2 if the object is west of the middle.
  $C7D0,$02 Make the adjustment negative.
@ $C7D2 label=NudgeObjectNorthSouth_Set
  $C7D2,$03 Set the adjustment of the speed in X of the object.
@ $C7D5 label=NudgeObjectsToArch_Restore
  $C7D5,$01 Restore the number of objects left from the stack.
@ $C7D6 label=NudgeObjectsToArch_Advance
  $C7D6,$02 Point #REGiy at the next object.
  $C7D8,$02 Jump to #R$C791 until all of the objects have been done.
  $C7DA,$01 Return.

c $C7DB Flag Objects Near Arch
@ $C7DB label=FlagObjectsNearArch
D $C7DB Flags the player and the special objects that are close to an arch, and
. are flagged to be adjusted near arches, as being near an arch.
R $C7DB H Distance in Y that counts as near
R $C7DB L Distance in X that counts as near
R $C7DB IX Address of the arch object
N $C7DB Flag each nearby object as being near an arch.
  $C7DB,$04 Point #REGiy at the player, #R$5C08.
  $C7DF,$03 Set #REGde to the size of an object.
  $C7E2,$02 Set the number of objects to #N($04), which is the player and the
. special objects.
@ $C7E4 label=FlagObjectsNearArch_Next
  $C7E4,$03 Fetch the graphic number of the object.
  $C7E7,$01 Test whether there is an object.
  $C7E8,$02 Jump to #R$C7F9 if there is not.
  $C7EA,$06 Jump to #R$C7F9 if the object is not flagged to be adjusted near
. arches.
  $C7F0,$03 Test whether the object is near the arch.
  $C7F3,$02 Jump to #R$C7F9 if it is not.
  $C7F5,$04 Flag the object as being near an arch.
@ $C7F9 label=FlagObjectsNearArch_Advance
  $C7F9,$02 Point #REGiy at the next object.
  $C7FB,$02 Jump to #R$C7E4 until all of the objects have been done.
  $C7FD,$01 Return.

c $C7FE Test Near To
@ $C7FE label=TestNearTo
D $C7FE Tests whether an object is close to the point that the arch keeps as the
. middle of its doorway: less than #REGl away in X, less than #REGh away in Y
. and less than #N$04 away in Z.
E $C7FE View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C099 }
. { #PENTAGRAM$C8AD }
. LIST#
R $C7FE H Distance in Y that counts as near
R $C7FE L Distance in X that counts as near
R $C7FE IX Address of the arch object
R $C7FE IY Address of the object
R $C7FE O:F Carry flag set if the object is near
N $C7FE Test the distance in X, then in Y, then in Z.
  $C7FE,$03 Fetch the X coordinate of the middle of the doorway.
  $C801,$03 Subtract the X coordinate of the object.
  $C804,$02 Jump to #R$C808 if it is positive.
  $C806,$02 Make it positive.
@ $C808 label=TestNearTo_Y
  $C808,$01 Compare it with the distance in X.
  $C809,$01 Return if it is too far.
  $C80A,$03 Fetch the Y coordinate of the middle of the doorway.
  $C80D,$03 Subtract the Y coordinate of the object.
  $C810,$02 Jump to #R$C814 if it is positive.
  $C812,$02 Make it positive.
@ $C814 label=TestNearTo_Z
  $C814,$01 Compare it with the distance in Y.
  $C815,$01 Return if it is too far.
  $C816,$03 Fetch the Z coordinate of the middle of the doorway.
  $C819,$03 Subtract the Z coordinate of the object.
  $C81C,$02 Jump to #R$C820 if it is positive.
  $C81E,$02 Make it positive.
@ $C820 label=TestNearTo_Done
  $C820,$02 Compare it with #N$04.
  $C822,$01 Return.

c $C823 Handle Human Legs
@ $C823 label=HandleHumanLegs
D $C823 Handles the bottom half of the player while it is in the form of a
. human, which is the graphic numbers #N$10 to #N$15 and #N$18 to #N$1D.
R $C823 IX Address of the object
  $C823,$03 Set the pixel adjustments of the legs of a human.
  $C826,$02 Jump to #R$C82B.

c $C828 Handle Wulf Legs
@ $C828 label=HandleWulfLegs
D $C828 Handles the bottom half of the player while it is in the form of a wulf,
. which is the graphic numbers #N$30 to #N$35 and #N$38 to #N$3D.
R $C828 IX Address of the object
  $C828,$03 Set the pixel adjustments of the legs of a wulf.

c $C82B Handle Player Legs
@ $C82B label=HandlePlayerLegs
D $C82B Does all of the work for the player, as the top half of the player is
. only a copy of the bottom half placed above it (see #R$CDDA). If the player
. has been killed this starts the death sparkles. Otherwise it reads the
. controls, lets the player pick up or drop an object, turn, jump and walk, and
. then moves the player.
R $C82B IX Address of the object
  $C82B,$06 Jump to #R$C83E if the player is alive.
  $C831,$04 Fetch the final animation flag from #R$5BC3.
  $C835,$02 Jump to #R$C83E if it is set, as the player is not killed during the
. final animation.
  $C837,$04 Flag the top half of the player as dead too.
  $C83B,$03 Start the death sparkles.
@ $C83E label=HandlePlayerLegs_Alive
N $C83E The player is alive. The controls are kept in #REGc while they are
. handled.
  $C83E,$03 Start the transformation if it is due. If it does start, this does
. not return here but to the routine that called this one.
  $C841,$03 Read the controls.
  $C844,$03 Handle picking up and dropping an object.
  $C847,$03 Handle turning.
  $C84A,$03 Handle jumping.
  $C84D,$03 Handle walking.
  $C850,$03 Test whether the player is inside the room.
  $C853,$02 Jump to #R$C86D if the player is not.
@ $C855 label=HandlePlayerLegs_Move
N $C855 The top half of the player is flagged to be ignored in the 3D
. calculations while the player moves, so that the two halves do not get in each
. other's way.
  $C855,$04 Flag the top half of the player to be ignored.
  $C859,$03 Move the player.
  $C85C,$04 Stop ignoring the top half of the player.
  $C860,$03 Fetch the flags, which hold the counter of the player entering the
. room in the high nibble.
  $C863,$02 Take one off the counter.
  $C865,$02 Jump to #R$C86A if the counter was already zero.
  $C867,$03 Store the new counter.
@ $C86A label=HandlePlayerLegs_Draw
  $C86A,$03 Jump to #R$C692.

c $C86D Handle Player Outside Room
@ $C86D label=HandlePlayerOutsideRoom
D $C86D Handles the player being outside the room, which happens while the
. player walks through an arch. The player may fall, but is not allowed to rise.
R $C86D IX Address of the object
  $C86D,$03 Fetch the speed in Z of the player.
  $C870,$01 Test whether it is negative.
  $C871,$03 Jump to #R$C855 if it is, as the player is falling.
  $C874,$04 Set the speed in Z to zero.
  $C878,$02 Jump to #R$C855.

c $C87A Test Player In Room
@ $C87A label=TestPlayerInRoom
D $C87A Tests whether the player is inside the room. The distance from the
. middle of the room (#N$80) has to be smaller than the distance to the wall,
. less the width of the player along x and less the depth of the player along y.
E $C87A View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C117 }
. { #PENTAGRAM$C4A3 }
. LIST#
R $C87A IX The address of the object
R $C87A O:F Carry flag set if the player is inside the room
N $C87A Limits from the wall distances.
  $C87A,$03 Fetch the size of the room in X and Y from #R$5BAB.
N $C87D Take the width of the player off the size in X.
  $C87D,$01 Copy the distance along x to #REGa.
  $C87E,$03 Subtract the width of the player.
  $C881,$01 Store the limit along x in #REGl.
N $C882 Take the depth of the player off the size in Y.
  $C882,$01 Copy the distance along y to #REGa.
  $C883,$03 Subtract the depth of the player.
  $C886,$01 Store the limit along y in #REGh.
N $C887 Compare the x distance from the middle.
  $C887,$03 Fetch the x position of the player.
  $C88A,$02 Subtract #N$80.
  $C88C,$03 Jump to #R$C891 if it is not negative.
  $C88F,$02 Negate #REGa.
@ $C891 label=TestPlayerInRoom_LimitX
  $C891,$02 Return if the player is outside along x.
N $C893 Compare the y distance from the middle.
  $C893,$03 Fetch the y position of the player.
  $C896,$02 Subtract #N$80.
  $C898,$03 Jump to #R$C89D if it is not negative.
  $C89B,$02 Negate #REGa.
@ $C89D label=TestPlayerInRoom_CompareY
  $C89D,$01 Compare it with the limit in Y, which sets the carry flag if the
. player is inside.
  $C89E,$01 Return.

c $C89F Handle Turning
@ $C89F label=HandleTurning
D $C89F Turns the player, using the left and right controls or, if a joystick
. with directional control is in use, the direction that is pressed. The
. directional controls turn the player a quarter turn at a time towards the
. direction pressed along the shortest way, and flag the player to walk once it
. is facing that direction. The facing of the player is stored as the horizontal
. flip flag and bit 3 of the graphic number.
E $C89F View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C13C }
. { #PENTAGRAM$C4C8 }
. LIST#
R $C89F C The controls
R $C89F IX Address of the object
R $C89F O:C The controls, with the walk control changed if directional control is in use
  $C89F,$04 Fetch the control method, #R$5BA4.
  $C8A3,$02,b$01 Keep the joystick bits.
  $C8A5,$02 Jump to #R$C8F2 if the keyboard is in use.
  $C8A7,$04 Jump to #R$C8F2 if directional control is not in use.
N $C8AB Directional control. The player cannot turn while entering the room, or
. while it is not standing on something.
  $C8AB,$03 Fetch the flags of the player.
  $C8AE,$02,b$01 Keep the counter of the player entering the room.
  $C8B0,$01 Return if the player is entering the room.
  $C8B1,$04 Test whether the player is standing on something.
  $C8B5,$01 Return if it is not.
N $C8B6 Find the direction that is pressed. Left takes priority over up.
  $C8B6,$04 Jump to #R$C8BE if it is pressed.
  $C8BA,$04 Jump to #R$C8CD if it is pressed.
@ $C8BE label=HandleTurning_Right
  $C8BE,$04 Jump to #R$C8D9 if it is pressed.
  $C8C2,$04 Jump to #R$C8E0 if it is pressed.
  $C8C6,$04 Jump to #R$C8E9 if it is pressed.
  $C8CA,$02 Clear the walk control, as no direction is pressed.
  $C8CC,$01 Return.
@ $C8CD label=HandleTurning_North
N $C8CD The facing of the player is #N$00 for west, #N$01 for east, #N$02 for
. north and #N$03 for south.
  $C8CD,$03 Fetch the direction the player is facing.
  $C8D0,$02 Test whether it is north.
@ $C8D2 label=HandleTurning_North_Test
  $C8D2,$02 Jump to #R$C8EF if it is.
  $C8D4,$01 Invert the direction.
@ $C8D5 label=HandleTurning_North_Direction
  $C8D5,$02,b$01 Keep bit 0, which decides which way to turn.
  $C8D7,$02 Jump to #R$C91F.
@ $C8D9 label=HandleTurning_East
  $C8D9,$03 Fetch the direction the player is facing.
  $C8DC,$02 Test whether it is east.
  $C8DE,$02 Jump to #R$C8D2.
@ $C8E0 label=HandleTurning_South
  $C8E0,$03 Fetch the direction the player is facing.
  $C8E3,$02 Test whether it is south.
@ $C8E5 label=HandleTurning_South_Test
  $C8E5,$02 Jump to #R$C8EF if it is.
  $C8E7,$02 Jump to #R$C8D5.
@ $C8E9 label=HandleTurning_West
  $C8E9,$03 Fetch the direction the player is facing.
  $C8EC,$01 Test whether it is west.
  $C8ED,$02 Jump to #R$C8E5.
@ $C8EF label=HandleTurning_Walk
  $C8EF,$02 Set the walk control, as the player is facing the direction that is
. pressed.
  $C8F1,$01 Return.
@ $C8F2 label=HandleTurning_Rotate
N $C8F2 Rotational control. After each turn the player has to wait before it can
. turn again.
  $C8F2,$03 Fetch the flags.
  $C8F5,$02,b$01 Keep the turning delay counter, which is in the low three bits.
  $C8F7,$02 Jump to #R$C8FD if it has run out.
  $C8F9,$03 Count it down.
  $C8FC,$01 Return.
@ $C8FD label=HandleTurning_Rotate_ReadControls
  $C8FD,$01 Fetch the controls.
  $C8FE,$02,b$01 Keep left and right.
  $C900,$01 Return if neither is pressed.
  $C901,$03 Fetch the flags of the player.
  $C904,$02,b$01 Keep the counter of the player entering the room.
  $C906,$01 Return if the player is entering the room.
  $C907,$04 Test whether the player is jumping.
  $C90B,$01 Return if it is.
  $C90C,$04 Jump to #R$C915 if it is pressed.
  $C910,$01 Stash the controls on the stack.
  $C911,$03 Play the sound of the footsteps.
  $C914,$01 Restore the controls from the stack.
@ $C915 label=HandleTurning_Rotate_Reset
  $C915,$03 Fetch the flags.
  $C918,$02,b$01 Set the turning delay counter, which has run out, to #N$02.
  $C91A,$03 Store it.
  $C91D,$02 Test the right control.
@ $C91F label=HandleTurning_Turn
  $C91F,$02 Jump to #R$C940 if the player is to turn right.
  $C921,$06 Jump to #R$C92F if the sprite is flipped horizontally.
@ $C927 label=HandleTurning_ToggleGraphic
  $C927,$03 Fetch the graphic number.
  $C92A,$02,b$01 Toggle bit 3 of it.
  $C92C,$03 Store it.
@ $C92F label=HandleTurning_ToggleFlip
  $C92F,$03 Fetch the flags.
  $C932,$02,b$01 Toggle the horizontal flip flag.
  $C934,$03 Store the flags.
  $C937,$05 Fetch the graphic number, and add #N$10 to get the top half.
  $C93C,$03 Set the graphic number of the top half of the player.
  $C93F,$01 Return.
@ $C940 label=HandleTurning_ToggleFlip_Test
  $C940,$06 Jump to #R$C927 if the sprite is flipped horizontally.
  $C946,$02 Jump to #R$C92F.

c $C948 Handle Jump
@ $C948 label=HandleJump
D $C948 Makes the player jump if the jump control is pressed. The player cannot
. jump while entering a room, while already jumping, or while falling quickly.
E $C948 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C23D }
. LIST#
R $C948 C The controls
R $C948 IX Address of the object
N $C948 Start a jump if the control is pressed and the player is ready.
  $C948,$02 Test the jump control.
  $C94A,$01 Return if it is not pressed.
  $C94B,$03 Fetch the flags of the player.
  $C94E,$02,b$01 Keep the counter of the player entering the room.
  $C950,$01 Return if the player is entering the room.
  $C951,$04 Test whether the player is already jumping.
  $C955,$01 Return if it is.
  $C956,$04 Fetch the speed in Z and add one to it.
  $C95A,$01 Return if it was lower than #N($FF), as the player is falling.
  $C95B,$04 Flag the player as jumping.
  $C95F,$04 Set the speed in Z to #N$08.
  $C963,$01 Stash the controls on the stack.
  $C964,$03 Play the sound of a jump.
  $C967,$01 Restore the controls from the stack.
  $C968,$01 Return.

c $C969 Handle Walking
@ $C969 label=HandleWalking
D $C969 Animates the legs of the player. The legs are only animated while the
. player is walking, entering the room or jumping. When the player stops, the
. legs carry on until they reach a frame in which the feet are together.
E $C969 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C25E }
. LIST#
R $C969 C The controls
R $C969 IX Address of the object
  $C969,$03 Fetch the flags.
  $C96C,$02,b$01 Keep the counter of the player entering the room.
  $C96E,$02 Jump to #R$C97A if it is.
  $C970,$06 Jump to #R$C97A if the player is jumping.
  $C976,$04 Jump to #R$C994 if it is not pressed.
@ $C97A label=HandleWalking_Step
  $C97A,$01 Stash the controls on the stack.
  $C97B,$03 Play the sound of the footsteps.
  $C97E,$01 Restore the controls from the stack.
@ $C97F label=HandleWalking_Animate
N $C97F The frame of the animation is in the low three bits of the graphic
. number and goes from #N$00 to #N$05.
  $C97F,$04 Fetch the graphic number and stash it in #REGe.
  $C983,$01 Go to the next frame.
  $C984,$02,b$01 Keep the frame in the low three bits.
  $C986,$04 Jump to #R$C98B if it has not.
  $C98A,$01 Go back to the first frame.
@ $C98B label=HandleWalking_Animate_StashFrame
  $C98B,$01 Stash the frame in #REGd.
  $C98C,$01 Fetch the graphic number.
  $C98D,$02,b$01 Take the frame off it.
  $C98F,$01 Put the new frame back.
  $C990,$03 Update the graphic number.
  $C993,$01 Return.
@ $C994 label=HandleWalking_Stop
  $C994,$03 Fetch the graphic number.
  $C997,$02,b$01 Keep the frame of the animation.
  $C999,$02 Test whether it is frame #N$02.
  $C99B,$01 Return if it is.
  $C99C,$02 Test whether it is frame #N$04.
  $C99E,$01 Return if it is.
  $C99F,$02 Jump to #R$C97F to carry on animating the legs.

c $C9A1 Move Player
@ $C9A1 label=MovePlayer
D $C9A1 Moves the player by one frame. The speeds in X and Y are only set up
. while the player walks or is jumping, and they are cleared again afterwards.
. The speed in Z has gravity taken off it, which is more if the player is
. falling or has let go of the jump control.
E $C9A1 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C296 }
. { #PENTAGRAM$C61D }
. LIST#
R $C9A1 C The controls
R $C9A1 IX Address of the object
  $C9A1,$04 Fetch the flag that is set while an object is put into the cauldron
. from #R$5BC4.
  $C9A5,$02 Jump to #R$C9AB if it is not set.
  $C9A7,$04 Set the speed in Z to #N$02.
@ $C9AB label=MovePlayer_Speed
  $C9AB,$06 Jump to #R$C9BC if the player is jumping.
  $C9B1,$03 Fetch the flags.
  $C9B4,$02,b$01 Keep the counter of the player entering the room.
  $C9B6,$02 Jump to #R$C9BC if it is.
  $C9B8,$04 Jump to #R$C9C1 if it is not pressed.
@ $C9BC label=MovePlayer_Forward
  $C9BC,$01 Stash the controls on the stack.
  $C9BD,$03 Set the speeds in X and Y from the direction of the player.
  $C9C0,$01 Restore the controls from the stack.
@ $C9C1 label=MovePlayer_Gravity
N $C9C1 Gravity takes one off the speed in Z when the player is rising with the
. jump control held down, and two otherwise.
  $C9C1,$04 Fetch the speed in Z and test it.
  $C9C5,$03 Jump to #R$C9CC if it is negative.
  $C9C8,$04 Jump to #R$C9CD if it is pressed.
@ $C9CC label=MovePlayer_Fall
  $C9CC,$01 Take one off the speed in Z.
@ $C9CD label=MovePlayer_Store
  $C9CD,$01 Take one off the speed in Z.
  $C9CE,$03 Store the new speed in Z.
  $C9D1,$03 Store it as the last speed in Z of the player too at #R$5BC1.
  $C9D4,$02 Add two to it.
  $C9D6,$03 Play the sound of falling if the player is falling fast enough.
  $C9D9,$03 Stop the player moving through other objects and the walls of the
. room.
  $C9DC,$03 Change room if the player has gone through an arch.
  $C9DF,$03 Add the speeds to the position of the player.
  $C9E2,$06 Jump to #R$C9F3 if the player is not blocked in Z.
  $C9E8,$04 Fetch the last speed in Z and test it from #R$5BC1.
  $C9EC,$03 Jump to #R$C9F3 if the player was rising.
  $C9EF,$04 Flag the player as no longer jumping, as it has landed.
@ $C9F3 label=MovePlayer_Stop
  $C9F3,$07 Set the speeds in X and Y to zero.
  $C9FA,$01 Return.

c $C9FB Set Player Speed
@ $C9FB label=SetPlayerSpeed
D $C9FB Sets the speeds along x and y of the player to walk forward. The
. adjustments of the speeds that arches make to nudge the player into doorways
. are added first, then the speed of #N$03 in the direction that the player is
. facing.
E $C9FB View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C2F6 }
. { #PENTAGRAM$C66A }
. LIST#
R $C9FB IX The address of the object
N $C9FB Add the doorway nudges.
  $C9FB,$03 Fetch the speed along the x axis.
  $C9FE,$03 Add the adjustment along x.
  $CA01,$03 Store the speed along the x axis.
  $CA04,$03 Fetch the speed along the y axis.
  $CA07,$03 Add the adjustment along y.
  $CA0A,$03 Store the speed along the y axis.
  $CA0D,$07 Write #N$00 to the adjustments along x and y.
N $CA14 Jump by the facing direction.
  $CA14,$03 Point #REGbc at #R$CA32.
@ $CA17 label=SetPlayerSpeed_Direction
  $CA17,$03 Fetch the direction the player is facing.
  $CA1A,$01 Copy it to #REGl.
  $CA1B,$03 Jump to the routine for the direction.

c $CA1E Get Facing Direction
@ $CA1E label=GetFacingDirection
D $CA1E Works out the direction that an object is facing from the horizontal
. flip flag and bit 3 of the graphic number: bit 6 of the flags of the object is
. made into bit 1 of the direction, and bit 3 of the graphic number into bit 0.
. The direction is #N($00) west, #N($01) east, #N$02 north and #N$03 south.
E $CA1E View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C319 }
. LIST#
R $CA1E IX The address of the object
R $CA1E O:A The direction
N $CA1E Bit 6 of the flags to bit 1.
  $CA1E,$03 Fetch the flags of the object.
  $CA21,$02 Rotate bit 6 into bit 4.
  $CA23,$02,b$01 Keep only bit 4.
  $CA25,$01 Copy it to #REGl.
N $CA26 Bit 3 of the graphic number to bit 0.
  $CA26,$03 Fetch the graphic number of the object.
  $CA29,$02,b$01 Keep only bit 3.
  $CA2B,$01 Merge #REGl.
  $CA2C,$03 Rotate the two bits into place.
  $CA2F,$02,b$01 Keep only bits 0 and 1.
  $CA31,$01 Return.

w $CA32 Player Movement Table
@ $CA32 label=PlayerMovementTable
D $CA32 The routines that set the speed of the player, by the direction the
. player is facing.
W $CA32,$02,$02 Facing west: #R$CA3A.
W $CA34,$02,$02 Facing east: #R$CA43.
W $CA36,$02,$02 Facing north: #R$CA4A.
W $CA38,$02,$02 Facing south: #R$CA53.

c $CA3A Move Player West
@ $CA3A label=MovePlayerWest
D $CA3A Takes #N$03 off the speed along the x axis of the object.
E $CA3A View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C337 }
. { #PENTAGRAM$C695 }
. LIST#
R $CA3A IX The address of the object
  $CA3A,$03 Fetch the speed along the x axis.
  $CA3D,$02 Add #N$FD.
@ $CA3F label=MovePlayer_SetX
  $CA3F,$03 Store the speed along the x axis.
  $CA42,$01 Return.

c $CA43 Move Player East
@ $CA43 label=MovePlayerEast
D $CA43 Adds #N$03 to the speed along the x axis of the object.
E $CA43 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C340 }
. { #PENTAGRAM$C69E }
. LIST#
R $CA43 IX The address of the object
  $CA43,$03 Fetch the speed along the x axis.
  $CA46,$02 Add #N$03.
  $CA48,$02 Jump to #R$CA3F.

c $CA4A Move Player North
@ $CA4A label=MovePlayerNorth
D $CA4A Adds #N$03 to the speed along the y axis of the object.
E $CA4A View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C347 }
. { #PENTAGRAM$C6A5 }
. LIST#
R $CA4A IX The address of the object
  $CA4A,$03 Fetch the speed along the y axis.
  $CA4D,$02 Add #N$03.
@ $CA4F label=MovePlayer_SetY
  $CA4F,$03 Store the speed along the y axis.
  $CA52,$01 Return.

c $CA53 Move Player South
@ $CA53 label=MovePlayerSouth
D $CA53 Takes #N$03 off the speed along the y axis of the object.
E $CA53 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C350 }
. { #PENTAGRAM$C6AE }
. LIST#
R $CA53 IX The address of the object
  $CA53,$03 Fetch the speed along the y axis.
  $CA56,$02 Add #N$FD.
  $CA58,$02 Jump to #R$CA4F.

c $CA5A Stop Object At Floor
@ $CA5A label=StopObjectAtFloor
D $CA5A Stops an object from going through the floor. If the z position of the
. object after it has moved is below the floor of the room, the object is
. flagged as blocked along z, and its speed along z is brought closer to zero
. until the object no longer goes through the floor.
E $CA5A View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C357 }
. { #PENTAGRAM$B963 }
. LIST#
R $CA5A H Speed along the z axis
R $CA5A IX The address of the object
R $CA5A O:H The new speed along the z axis
N $CA5A Test the floor and slow z.
  $CA5A,$03 Fetch #R$5BAE.
  $CA5D,$01 Copy it to #REGd.
N $CA5E Test whether the object ends up below the floor.
@ $CA5E label=StopObjectAtFloor_Test
  $CA5E,$03 Fetch the z position of the object.
  $CA61,$03 Return if the object does not end up below the floor.
  $CA64,$04 Flag the object as blocked in Z.
  $CA68,$01 Copy #REGh to #REGa.
  $CA69,$03 Call #R$CA89.
  $CA6C,$01 Copy it to #REGh.
  $CA6D,$02 Jump to #R$CA5E if it is not yet zero.
  $CA6F,$01 Return.

c $CA70 Handle Room Exit
@ $CA70 label=HandleRoomExit
D $CA70 Sends the player to the next room if it has walked out through an arch.
. Only a player that is near an arch can leave the room, and not while it is
. still entering the room. The edge that counts is the one in the direction that
. the player is facing.
E $CA70 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C36D }
. LIST#
R $CA70 IX Address of the object
N $CA70 Leave through the arch the player is facing, if it is near one.
  $CA70,$03 Fetch the flags of the player.
  $CA73,$02,b$01 Keep the counter of the player entering the room.
  $CA75,$01 Return if the player is entering the room.
  $CA76,$04 Test whether the player is near an arch.
  $CA7A,$01 Return if it is not.
  $CA7B,$04 Clear the flag.
  $CA7F,$03 Point #REGbc at #R$CA92.
  $CA82,$03 Fetch the size of the room in X and Y from #R$5BAB.
  $CA85,$01 Stack it for the routine to take off.
  $CA86,$03 Jump to the routine for the direction the player is facing.

c $CA89 Bring Speed Closer To Zero
@ $CA89 label=BringSpeedCloserToZero
D $CA89 Takes one off the size of a speed.
E $CA89 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C386 }
. { #PENTAGRAM$B95A }
. LIST#
R $CA89 A The speed
R $CA89 O:A The new speed
R $CA89 O:F The zero flag is set if the new speed is zero
  $CA89,$01 Test whether the speed is zero.
  $CA8A,$01 Return if it is.
  $CA8B,$03 Jump to #R$CA90 if it is positive.
  $CA8E,$02 Add two to the negative speed.
@ $CA90 label=BringSpeedCloserToZero_Step
  $CA90,$01 Take one off the speed.
  $CA91,$01 Return.

w $CA92 Room Exit Table
@ $CA92 label=RoomExitTable
D $CA92 The routines that take the player to the next room, by the direction the
. player is facing.
W $CA92,$02,$02 Facing west: #R$CA9A.
W $CA94,$02,$02 Facing east: #R$CAF3.
W $CA96,$02,$02 Facing north: #R$CB0E.
W $CA98,$02,$02 Facing south: #R$CB29.

c $CA9A Leave Room To The West
@ $CA9A label=LeaveRoomToWest
D $CA9A Sends the player to the room to the west if it has gone past the west
. edge of the room. The x position is set to #N($00), which #R$D320 takes as the
. sign that the player has come out of the west and puts it at the east side of
. the new room.
E $CA9A View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C397 }
. LIST#
R $CA9A HL Distances to the walls along x and y
R $CA9A IX The address of the object
N $CA9A Leave if past the west edge.
  $CA9A,$01 Unstack the size of the room in X and Y.
N $CA9B Work out the coordinate of the west edge of the room.
  $CA9B,$02 Set #REGa to #N$80.
  $CA9D,$01 Subtract #REGl.
  $CA9E,$01 Copy it to #REGl.
N $CA9F Add the speed in X and the width of the player to the X coordinate.
  $CA9F,$03 Fetch the x position of the player.
  $CAA2,$03 Add the speed along the x axis.
  $CAA5,$03 Add the width of the player.
N $CAA8 Compare it with the west edge.
  $CAA8,$02 Return if the player is still in the room.
  $CAAA,$04 Write #N$00 to the x position.
N $CAAE Fetch the room number and stash it in #REGl.
  $CAAE,$03 Fetch the room number.
  $CAB1,$01 Copy it to #REGl.
  $CAB2,$01 Go to the room to the west.
N $CAB3 Change the column. The room number has the row in the high nibble and
. the column in the low nibble.
@ $CAB3 label=ChangeRoomEastWest
  $CAB3,$02,b$01 Keep the column of the new room number.
  $CAB5,$01 Copy it to #REGh.
  $CAB6,$01 Fetch the old room number.
  $CAB7,$02,b$01 Keep only bits 4-7.
  $CAB9,$01 Combine the row with the new column.
N $CABA Change the room of the player. Bits 4 and 5 of the collision flags start
. the entering-room counter at #N$03. If the object is the player then it is
. copied and replaced by sparkles, and the game loop is started again.
@ $CABA label=ChangeRoom
  $CABA,$03 Store the new room number.
  $CABD,$03 Fetch the collision flags.
  $CAC0,$02,b$01 Set the counter of the player entering the room to #N$03.
  $CAC2,$03 Store the collision flags.
N $CAC5 Fetch the graphic number and take #N$10 off it.
  $CAC5,$03 Fetch the graphic number of the object.
  $CAC8,$02 Subtract #N$10.
  $CACA,$02 Compare it with #N$40.
  $CACC,$01 Return if it is not one of the graphics of the human or the wulf.
  $CACD,$04 Drop the two return addresses on the stack, as the game loop starts
. again.
  $CAD1,$03 Point #REGhl at the player (using the stack).
  $CAD4,$03 Point #REGde at #R$D161.
  $CAD7,$03 Set the length to #N($40), for the two halves of the player.
  $CADA,$02 Copy the player.
N $CADC Remember the sprites, then turn the copy into sparkles.
  $CADC,$03 Fetch the sprite of the bottom half.
  $CADF,$03 Keep it as the sprite that the bottom half will appear as.
N $CAE2 Copy the graphic number of the top half into the same field of the top
. half from #R$D181.
  $CAE2,$03 Fetch the sprite of the top half.
  $CAE5,$03 Keep it as the sprite that the top half will appear as.
N $CAE8 Fetch the graphic number of the first of the sparkles that show the
. player appearing.
  $CAE8,$08 Write #N$78 to #R$D161 and #R$D181.
  $CAF0,$03 Start the game loop again, which builds the new room.

c $CAF3 Leave Room To The East
@ $CAF3 label=LeaveRoomToEast
D $CAF3 Sends the player to the room to the east if it has gone past the east
. edge of the room. The x position is set to #N($FF), which #R$D320 takes as the
. sign that the player has come out of the east and puts it at the west side of
. the new room.
E $CAF3 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C3F0 }
. LIST#
R $CAF3 HL Distances to the walls along x and y
R $CAF3 IX The address of the object
N $CAF3 Leave if past the east edge.
  $CAF3,$01 Unstack the size of the room in X and Y.
N $CAF4 Work out the coordinate of the east edge of the room.
  $CAF4,$01 Copy #REGl to #REGa.
  $CAF5,$02 Add #N$80.
  $CAF7,$01 Copy it to #REGl.
N $CAF8 Add the speed in X to the X coordinate, and take the width of the player
. off it.
  $CAF8,$03 Fetch the x position of the player.
  $CAFB,$03 Add the speed along the x axis.
  $CAFE,$03 Subtract the width of the player.
N $CB01 Compare it with the east edge.
  $CB01,$02 Return if the player is still in the room.
  $CB03,$04 Write #N$FF to the x position.
N $CB07 Fetch the room number and stash it in #REGl.
  $CB07,$03 Fetch the room number.
  $CB0A,$01 Copy it to #REGl.
  $CB0B,$01 Go to the room to the east.
  $CB0C,$02 Jump to #R$CAB3.

c $CB0E Leave Room To The North
@ $CB0E label=LeaveRoomToNorth
D $CB0E Sends the player to the room to the north if it has gone past the north
. edge of the room. The y position is set to #N($FF), which #R$D320 takes as the
. sign that the player has come out of the north and puts it at the south side
. of the new room.
E $CB0E View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C40B }
. LIST#
R $CB0E HL Distances to the walls along x and y
R $CB0E IX The address of the object
N $CB0E Leave if past the north edge.
  $CB0E,$01 Unstack the size of the room in X and Y.
N $CB0F Work out the coordinate of the north edge of the room.
  $CB0F,$01 Copy #REGh to #REGa.
  $CB10,$02 Add #N$80.
  $CB12,$01 Copy it to #REGh.
N $CB13 Add the speed in Y to the Y coordinate, and take the depth of the player
. off it.
  $CB13,$03 Fetch the y position of the player.
  $CB16,$03 Add the speed along the y axis.
  $CB19,$03 Subtract the depth of the player.
N $CB1C Compare it with the north edge.
  $CB1C,$02 Return if the player is still in the room.
  $CB1E,$04 Write #N$FF to the y position.
N $CB22 Fetch the room number and add #N$10 to go to the room to the north.
  $CB22,$03 Fetch the room number.
  $CB25,$02 Add #N$10.
  $CB27,$02 Jump to #R$CABA.

c $CB29 Leave Room To The South
@ $CB29 label=LeaveRoomToSouth
D $CB29 Sends the player to the room to the south if it has gone past the south
. edge of the room. The y position is set to #N($00), which #R$D320 takes as the
. sign that the player has come out of the south and puts it at the north side
. of the new room.
E $CB29 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C426 }
. LIST#
R $CB29 HL Distances to the walls along x and y
R $CB29 IX The address of the object
N $CB29 Leave if past the south edge.
  $CB29,$01 Unstack the size of the room in X and Y.
N $CB2A Work out the coordinate of the south edge of the room.
  $CB2A,$02 Set #REGa to #N$80.
  $CB2C,$01 Subtract #REGh.
  $CB2D,$01 Copy it to #REGh.
N $CB2E Add the speed in Y and the depth of the player to the Y coordinate.
  $CB2E,$03 Fetch the y position of the player.
  $CB31,$03 Add the speed along the y axis.
  $CB34,$03 Add the depth of the player.
N $CB37 Compare it with the south edge.
  $CB37,$02 Return if the player is still in the room.
  $CB39,$04 Write #N$00 to the y position.
N $CB3D Fetch the room number and take #N$10 off it to go to the room to the
. south.
  $CB3D,$03 Fetch the room number.
  $CB40,$02 Subtract #N$10.
  $CB42,$03 Jump to #R$CABA.

c $CB45 Block Movement
@ $CB45 label=BlockMovement
D $CB45 Stops an object moving through the walls of the room or through other
. objects. The speeds in X, Y and Z of the object are each brought closer to
. zero until the object can move without hitting anything. Whichever direction
. is hit is flagged in the low bits of the flags in byte #N$0C of the object:
. bit 0 for X, bit 1 for Y and bit 2 for Z. For the Z direction that means that
. the object is standing on something. An object that is flagged to be ignored
. in the 3D calculations is not adjusted.
E $CB45 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C442 }
. { #PENTAGRAM$B6ED }
. LIST#
R $CB45 IX Address of the object
  $CB45,$04 Test whether the object is flagged to be ignored.
  $CB49,$01 Return if it is.
  $CB4A,$04 Flag the object to be ignored, so that it does not hit itself.
  $CB4E,$03 Fetch the flags.
  $CB51,$02,b$01 Clear the blocked flags of X, Y and Z.
  $CB53,$03 Store the flags.
  $CB56,$02 Set the new speed in Y to zero.
  $CB58,$01 Set the new speed in X to zero.
N $CB59 The new speeds are kept in #REGh for Z, #REGc for X and #REGl for Y. The
. Z direction goes first, and the floor of the room is tried before the objects.
  $CB59,$03 Fetch the speed in Z.
  $CB5C,$01 Test whether it is zero.
  $CB5D,$01 Stash it in #REGh.
  $CB5E,$02 Jump to #R$CB6A if it is zero.
  $CB60,$03 Stop the object going through the floor.
  $CB63,$02 Test whether the speed in Z is now zero.
  $CB65,$02 Jump to #R$CB6A if it is.
  $CB67,$03 Stop the object going through other objects.
@ $CB6A label=BlockMovement_X
  $CB6A,$04 Fetch the speed in X and test whether it is zero.
  $CB6E,$01 Stash it in #REGc.
  $CB6F,$02 Jump to #R$CB7B if it is zero.
  $CB71,$03 Stop the object going through the walls of the room.
  $CB74,$02 Test whether the speed in X is now zero.
  $CB76,$02 Jump to #R$CB7B if it is.
  $CB78,$03 Stop the object going through other objects.
@ $CB7B label=BlockMovement_Y
  $CB7B,$04 Fetch the speed in Y and test whether it is zero.
  $CB7F,$01 Stash it in #REGl.
  $CB80,$02 Jump to #R$CB8C if it is zero.
  $CB82,$03 Stop the object going through the walls of the room.
  $CB85,$02 Test whether the speed in Y is now zero.
  $CB87,$02 Jump to #R$CB8C if it is.
  $CB89,$03 Stop the object going through other objects.
@ $CB8C label=BlockMovement_Store
  $CB8C,$03 Store the new speed in X.
  $CB8F,$03 Store the new speed in Y.
  $CB92,$03 Store the new speed in Z.
  $CB95,$04 Stop ignoring the object.
  $CB99,$01 Return.

c $CB9A Block Movement In X
@ $CB9A label=BlockMovementInX
D $CB9A Brings the speed in X of an object closer to zero until it does not run
. into any other object. If the object does run into another, the objects may
. destroy each other: bit 7 of the flags in byte #N$0D of an object means that
. it destroys whatever it runs into, bit 5 means that it destroys whatever runs
. into it, and bit 6 means that the object is destroyed. An object that can be
. moved is pushed along at the same speed in X.
E $CB9A View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C497 }
. { #PENTAGRAM$B742 }
. LIST#
R $CB9A C Speed in X
R $CB9A L Speed in Y
R $CB9A H Speed in Z
R $CB9A IX Address of the object
R $CB9A O:C The new speed in X
N $CB9A Test each object, then slow the X speed if they overlap.
  $CB9A,$04 Point #REGiy at the first object in the table, #R$5C08.
  $CB9E,$02 Set the number of objects to #N$28.
@ $CBA0 label=BlockMovementInX_Next
  $CBA0,$03 Test whether the object is present and not ignored.
  $CBA3,$02 Jump to #R$CBE1 if it is not.
  $CBA5,$03 Test whether the objects overlap in Y.
  $CBA8,$02 Jump to #R$CBE1 if they do not.
  $CBAA,$03 Test whether the objects overlap in Z.
  $CBAD,$02 Jump to #R$CBE1 if they do not.
@ $CBAF label=BlockMovementInX_Test
  $CBAF,$03 Test whether the objects overlap in X after the move.
  $CBB2,$02 Jump to #R$CBE1 if they do not.
  $CBB4,$04 Flag the object as blocked in X.
  $CBB8,$04 Fetch the flags of the object and move the bit that it destroys what
. it hits into bit 6.
  $CBBC,$02,b$01 Keep the bit that flags the other object as destroyed.
  $CBBE,$06 Set it in the flags of the other object, if the object destroys what
. it runs into.
  $CBC4,$01 Move the bit that the other object destroys what it hits into bit 6.
  $CBC5,$02,b$01 Keep the bit that flags the object as destroyed.
  $CBC7,$06 Set it in the flags of the object, if the other object destroys what
. runs into it.
  $CBCD,$06 Jump to #R$CBD9 if the other object cannot be moved.
  $CBD3,$03 Fetch the speed in X of the object.
  $CBD6,$03 Give it to the other object.
@ $CBD9 label=BlockMovementInX_Slow
  $CBD9,$01 Fetch the speed in X.
  $CBDA,$03 Bring it closer to zero.
  $CBDD,$01 Store it.
  $CBDE,$01 Return if it is zero.
  $CBDF,$02 Jump to #R$CBAF to test it again.
@ $CBE1 label=BlockMovementInX_Advance
  $CBE1,$03 Set #REGde to the size of an object.
  $CBE4,$02 Point #REGiy at the next object.
  $CBE6,$02 Jump to #R$CBA0 until all of the objects have been tested.
  $CBE8,$01 Return.

c $CBE9 Block Movement In Y
@ $CBE9 label=BlockMovementInY
D $CBE9 Brings the speed in Y of an object closer to zero until it does not run
. into any other object. This works in the same way as #R$CB9A.
E $CBE9 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C4E6 }
. { #PENTAGRAM$B791 }
. LIST#
R $CBE9 C Speed in X
R $CBE9 L Speed in Y
R $CBE9 H Speed in Z
R $CBE9 IX Address of the object
R $CBE9 O:L The new speed in Y
N $CBE9 Test each object, then slow the Y speed if they overlap.
  $CBE9,$04 Point #REGiy at the first object in the table, #R$5C08.
  $CBED,$02 Set the number of objects to #N$28.
@ $CBEF label=BlockMovementInY_Next
  $CBEF,$03 Test whether the object is present and not ignored.
  $CBF2,$02 Jump to #R$CC30 if it is not.
  $CBF4,$03 Test whether the objects overlap in X.
  $CBF7,$02 Jump to #R$CC30 if they do not.
  $CBF9,$03 Test whether the objects overlap in Z.
  $CBFC,$02 Jump to #R$CC30 if they do not.
@ $CBFE label=BlockMovementInY_Test
  $CBFE,$03 Test whether the objects overlap in Y after the move.
  $CC01,$02 Jump to #R$CC30 if they do not.
  $CC03,$04 Flag the object as blocked in Y.
  $CC07,$04 Fetch the flags of the object and move the bit that it destroys what
. it hits into bit 6.
  $CC0B,$02,b$01 Keep the bit that flags the other object as destroyed.
  $CC0D,$06 Set it in the flags of the other object, if the object destroys what
. it runs into.
  $CC13,$01 Move the bit that the other object destroys what it hits into bit 6.
  $CC14,$02,b$01 Keep the bit that flags the object as destroyed.
  $CC16,$06 Set it in the flags of the object, if the other object destroys what
. runs into it.
  $CC1C,$06 Jump to #R$CC28 if the other object cannot be moved.
  $CC22,$03 Fetch the speed in Y of the object.
  $CC25,$03 Give it to the other object.
@ $CC28 label=BlockMovementInY_Slow
  $CC28,$01 Fetch the speed in Y.
  $CC29,$03 Bring it closer to zero.
  $CC2C,$01 Store it.
  $CC2D,$01 Return if it is zero.
  $CC2E,$02 Jump to #R$CBFE to test it again.
@ $CC30 label=BlockMovementInY_Advance
  $CC30,$03 Set #REGde to the size of an object.
  $CC33,$02 Point #REGiy at the next object.
  $CC35,$02 Jump to #R$CBEF until all of the objects have been tested.
  $CC37,$01 Return.

c $CC38 Block Movement In Z
@ $CC38 label=BlockMovementInZ
D $CC38 Brings the speed in Z of an object closer to zero until it does not run
. into any other object. This works in the same way as #R$CB9A, except that the
. object that is hit is flagged as triggered (bit 3 of its flags in byte #N$0D)
. as something is standing on it. An object that can be moved takes on the
. speeds in X and Y of the object that it stands on, if it has none of its own.
E $CC38 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C535 }
. LIST#
R $CC38 C Speed in X
R $CC38 L Speed in Y
R $CC38 H Speed in Z
R $CC38 IX Address of the object
R $CC38 O:H The new speed in Z
N $CC38 Test each object, then slow the Z speed if they overlap.
  $CC38,$04 Point #REGiy at the first object in the table, #R$5C08.
  $CC3C,$02 Set the number of objects to #N$28.
@ $CC3E label=BlockMovementInZ_Next
  $CC3E,$03 Test whether the object is present and not ignored.
  $CC41,$02 Jump to #R$CC95 if it is not.
  $CC43,$03 Test whether the objects overlap in X.
  $CC46,$02 Jump to #R$CC95 if they do not.
  $CC48,$03 Test whether the objects overlap in Y.
  $CC4B,$02 Jump to #R$CC95 if they do not.
@ $CC4D label=BlockMovementInZ_Test
  $CC4D,$03 Test whether the objects overlap in Z after the move.
  $CC50,$02 Jump to #R$CC95 if they do not.
  $CC52,$04 Flag the object as blocked in Z.
  $CC56,$04 Fetch the flags of the object and move the bit that it destroys what
. it hits into bit 6.
  $CC5A,$02,b$01 Keep the bit that flags the other object as destroyed.
  $CC5C,$06 Set it in the flags of the other object, if the object destroys what
. it runs into.
  $CC62,$01 Move the bit that the other object destroys what it hits into bit 6.
  $CC63,$02,b$01 Keep the bit that flags the object as destroyed.
  $CC65,$06 Set it in the flags of the object, if the other object destroys what
. runs into it.
  $CC6B,$04 Flag the other object as triggered.
  $CC6F,$06 Jump to #R$CC8D if the object cannot be moved.
  $CC75,$04 Fetch the speed in X of the object and test it.
  $CC79,$02 Jump to #R$CC81 if it has one.
  $CC7B,$06 Take the speed in X of the other object.
@ $CC81 label=BlockMovementInZ_Y
  $CC81,$04 Fetch the speed in Y of the object and test it.
  $CC85,$02 Jump to #R$CC8D if it has one.
  $CC87,$06 Take the speed in Y of the other object.
@ $CC8D label=BlockMovementInZ_Slow
  $CC8D,$01 Fetch the speed in Z.
  $CC8E,$03 Bring it closer to zero.
  $CC91,$01 Store it.
  $CC92,$01 Return if it is zero.
  $CC93,$02 Jump to #R$CC4D to test it again.
@ $CC95 label=BlockMovementInZ_Advance
  $CC95,$03 Set #REGde to the size of an object.
  $CC98,$02 Point #REGiy at the next object.
  $CC9A,$02 Jump to #R$CC3E until all of the objects have been tested.
  $CC9C,$01 Return.

c $CC9D Test Overlap In X
@ $CC9D label=TestOverlapInX
D $CC9D Tests whether two objects overlap along x, once the first has moved by
. its new speed along x. They overlap when the distance between the x positions
. is smaller than the two widths added together.
E $CC9D View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C5A9 }
. { #PENTAGRAM$B8A2 }
. LIST#
R $CC9D C New speed along x of the first object
R $CC9D IX The address of the first object
R $CC9D IY The address of the second object
R $CC9D O:F Carry flag set if the objects overlap
N $CC9D Compare the x distance with the widths.
  $CC9D,$03 Fetch the width of the first object.
  $CCA0,$03 Add the width of the second object.
  $CCA3,$01 Copy the total to #REGd.
N $CCA4 Take the X coordinate of the second object off the X coordinate of the
. first object plus the new speed.
  $CCA4,$03 Fetch the x position of the first object.
  $CCA7,$01 Add #REGc.
  $CCA8,$03 Subtract the x position of the second object.
  $CCAB,$03 Jump to #R$CCB0 if it is not negative.
  $CCAE,$02 Negate #REGa.
@ $CCB0 label=TestOverlapInX_TakeWidths
  $CCB0,$01 Take the total widths off it, which sets the carry flag if the
. objects overlap.
  $CCB1,$01 Return.

c $CCB2 Test Overlap In Y
@ $CCB2 label=TestOverlapInY
D $CCB2 Tests whether two objects overlap along y, once the first has moved by
. its new speed along y. They overlap when the distance between the y positions
. is smaller than the two depths added together.
E $CCB2 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C5BE }
. { #PENTAGRAM$B8B7 }
. LIST#
R $CCB2 L New speed along y of the first object
R $CCB2 IX The address of the first object
R $CCB2 IY The address of the second object
R $CCB2 O:F Carry flag set if the objects overlap
N $CCB2 Compare the y distance with the depths.
  $CCB2,$03 Fetch the depth of the first object.
  $CCB5,$03 Add the depth of the second object.
  $CCB8,$01 Copy the total to #REGd.
N $CCB9 Take the Y coordinate of the second object off the Y coordinate of the
. first object plus the new speed.
  $CCB9,$03 Fetch the y position of the first object.
  $CCBC,$01 Add #REGl.
  $CCBD,$03 Subtract the y position of the second object.
  $CCC0,$03 Jump to #R$CCC5 if it is not negative.
  $CCC3,$02 Negate #REGa.
@ $CCC5 label=TestOverlapInY_TakeDepths
  $CCC5,$01 Take the total depths off it, which sets the carry flag if the
. objects overlap.
  $CCC6,$01 Return.

c $CCC7 Test Overlap In Z
@ $CCC7 label=TestOverlapInZ
D $CCC7 Tests whether two objects overlap along z, once the first has moved by
. its new speed along z. They overlap when the distance between the z positions
. is smaller than the height of whichever of the objects is lower.
E $CCC7 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C5D3 }
. { #PENTAGRAM$B8CC }
. LIST#
R $CCC7 H New speed along z of the first object
R $CCC7 IX The address of the first object
R $CCC7 IY The address of the second object
R $CCC7 O:F Carry flag set if the objects overlap
N $CCC7 Use the height of the lower object.
  $CCC7,$03 Fetch the z position of the first object.
  $CCCA,$01 Add #REGh.
  $CCCB,$03 Subtract the z position of the second object.
  $CCCE,$03 Jump to #R$CCD8 if it is not negative.
  $CCD1,$02 Negate #REGa.
  $CCD3,$03 Fetch the height of the first object, which is the lower.
@ $CCD6 label=TestOverlapInZ_Compare
  $CCD6,$01 Take the height off it, which sets the carry flag if the objects
. overlap.
  $CCD7,$01 Return.
@ $CCD8 label=TestOverlapInZ_Second
  $CCD8,$03 Fetch the height of the second object, which is the lower.
  $CCDB,$02 Jump to #R$CCD6.

c $CCDD Keep Object In Room In X
@ $CCDD label=KeepObjectInRoomInX
D $CCDD Brings the speed in X of an object closer to zero until the object stays
. within the walls of the room. Nothing is done while the object is entering the
. room, or while it is near an arch, as it can then go out through the wall.
E $CCDD View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C5E9 }
. { #PENTAGRAM$B8E2 }
. LIST#
R $CCDD C Speed in X
R $CCDD IX Address of the object
R $CCDD O:C The new speed in X
N $CCDD Slow the X speed until the object stays inside the walls.
  $CCDD,$03 Fetch the flags of the object.
  $CCE0,$02,b$01 Keep the counter of the object entering the room.
  $CCE2,$01 Return if the object is entering the room.
  $CCE3,$04 Test whether the object is near an arch.
  $CCE7,$01 Return if it is.
  $CCE8,$04 Fetch the size of the room in X and stash it in #REGb from #R$5BAB.
@ $CCEC label=KeepObjectInRoomInX_Test
  $CCEC,$06 Work out where the X coordinate would be, with the speed added.
  $CCF2,$02 Jump to #R$CCF6 if it is not negative.
  $CCF4,$02 Make it positive.
@ $CCF6 label=KeepObjectInRoomInX_Test_AddWidth
  $CCF6,$03 Add the width of the object.
  $CCF9,$01 Compare it with the size of the room.
  $CCFA,$02 Return if it is smaller, as the object stays in the room.
  $CCFC,$04 Flag the object as blocked in X.
  $CD00,$01 Fetch the speed in X.
  $CD01,$03 Bring it closer to zero.
  $CD04,$01 Store it.
  $CD05,$02 Jump to #R$CCEC if it is not zero yet.
@ $CD07 label=KeepObjectInRoomInX_Test_Return
  $CD07,$01 Return.

c $CD08 Keep Object In Room In Y
@ $CD08 label=KeepObjectInRoomInY
D $CD08 Brings the speed in Y of an object closer to zero until the object stays
. within the walls of the room. Nothing is done while the object is entering the
. room, or while it is near an arch, as it can then go out through the wall.
E $CD08 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C613 }
. { #PENTAGRAM$B90D }
. LIST#
R $CD08 L Speed in Y
R $CD08 IX Address of the object
R $CD08 O:L The new speed in Y
N $CD08 Slow the Y speed until the object stays inside the walls.
  $CD08,$03 Fetch the flags of the object.
  $CD0B,$02,b$01 Keep the counter of the object entering the room.
  $CD0D,$01 Return if the object is entering the room.
  $CD0E,$04 Test whether the object is near an arch.
  $CD12,$01 Return if it is.
  $CD13,$04 Fetch the size of the room in Y and stash it in #REGb from #R$5BAC.
@ $CD17 label=KeepObjectInRoomInY_Test
  $CD17,$06 Work out where the Y coordinate would be, with the speed added.
  $CD1D,$02 Jump to #R$CD21 if it is not negative.
  $CD1F,$02 Make it positive.
@ $CD21 label=KeepObjectInRoomInY_Test_AddDepth
  $CD21,$03 Add the depth of the object.
  $CD24,$01 Compare it with the size of the room.
  $CD25,$02 Return if it is smaller, as the object stays in the room.
  $CD27,$04 Flag the object as blocked in Y.
  $CD2B,$01 Fetch the speed in Y.
  $CD2C,$03 Bring it closer to zero.
  $CD2F,$01 Store it.
  $CD30,$02 Jump to #R$CD17 if it is not zero yet.
@ $CD32 label=KeepObjectInRoomInY_Test_Return
  $CD32,$01 Return.

c $CD33 Calculate Sprite Size
@ $CD33 label=CalculateSpriteSize
D $CD33 Works out where an object is on the screen and how much of the screen
. its sprite covers. The width in bytes is one more than the width of the sprite
. if the sprite does not start on a byte boundary, because it has to be shifted
. across.
E $CD33 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C63D }
. { #PENTAGRAM$B938 }
. LIST#
R $CD33 IX Address of the object
N $CD33 Work out the pixel position, then the width and height of the sprite.
  $CD33,$03 Work out the pixel coordinates of the object.
  $CD36,$03 Find the sprite of the object, and flip it if it needs it.
  $CD39,$03 Fetch the pixel X coordinate.
  $CD3C,$02,b$01 Keep the offset of the bit within the byte.
  $CD3E,$01 Fetch the width of the sprite in bytes.
  $CD3F,$01 Point #REGde at the height of the sprite.
  $CD40,$02 Jump to #R$CD43 if the sprite starts on a byte boundary.
  $CD42,$01 Add one byte to the width.
@ $CD43 label=CalculateSpriteSize_Store
  $CD43,$02,b$01 Keep the low nibble of the width.
  $CD45,$03 Store the width in bytes.
  $CD48,$01 Fetch the height of the sprite in lines.
  $CD49,$03 Store the height in lines.
  $CD4C,$01 Return.

c $CD4D Flag Overlapping Objects
@ $CD4D label=FlagOverlappingObjects
D $CD4D Flags every object that overlaps the area of the screen covered by an
. object to be drawn again. The area is the one that is covered by the old and
. the new position of the sprite of the object together, so that the whole of it
. is redrawn.
E $CD4D View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C657 }
. { #PENTAGRAM$B9A7 }
. LIST#
R $CD4D IX Address of the object
  $CD4D,$04 Point #REGiy at the first object in the table, #R$5C08.
  $CD51,$03 Work out where the object is on the screen, and how big it is.
  $CD54,$02 Set the number of objects to #N$28.
N $CD56 The left edge of the area, in bytes of the screen, is the lower of the
. byte of the old and of the new position. It is kept in #REGe.
  $CD56,$03 Fetch the new pixel X coordinate of the object.
  $CD59,$03 Divide it by eight.
  $CD5C,$02,b$01 Keep the byte of the screen.
  $CD5E,$01 Stash it in #REGl.
  $CD5F,$03 Fetch the old pixel X coordinate of the object.
  $CD62,$03 Divide it by eight.
  $CD65,$02,b$01 Keep the byte of the screen.
  $CD67,$01 Stash it in #REGh.
  $CD68,$01 Compare the old with the new.
  $CD69,$02 Jump to #R$CD6C if the old is lower.
  $CD6B,$01 Take the new one instead.
@ $CD6C label=FlagOverlappingObjects_RightEdge
  $CD6C,$01 Stash the left edge in #REGe.
N $CD6D The width of the area is the higher of the right edge of the old and of
. the new position, less the left edge. It is kept in #REGd.
  $CD6D,$01 Fetch the new byte of the screen.
  $CD6E,$03 Add the width of the new position.
  $CD71,$01 Stash the right edge in #REGl.
  $CD72,$01 Fetch the old byte of the screen.
  $CD73,$03 Add the width of the old position.
  $CD76,$01 Compare it with the new right edge.
  $CD77,$02 Jump to #R$CD7A if it is higher.
  $CD79,$01 Take the new one instead.
@ $CD7A label=FlagOverlappingObjects_AreaWidth
  $CD7A,$01 Take the left edge off it.
  $CD7B,$01 Stash the width of the area in #REGd.
N $CD7C The bottom edge of the area is the lower of the old and the new pixel Y
. coordinate. It is kept in #REGl.
  $CD7C,$03 Fetch the new pixel Y coordinate.
  $CD7F,$03 Compare it with the old one.
  $CD82,$02 Jump to #R$CD87 if the new one is lower.
  $CD84,$03 Take the old one instead.
@ $CD87 label=FlagOverlappingObjects_TopEdge
  $CD87,$01 Stash the bottom edge in #REGl.
N $CD88 The height of the area is the higher of the top edge of the old and of
. the new position, less the bottom edge. It is kept in #REGh.
  $CD88,$03 Fetch the new pixel Y coordinate.
  $CD8B,$03 Add the height of the new position.
  $CD8E,$01 Stash the top edge in #REGh.
  $CD8F,$03 Fetch the old pixel Y coordinate.
  $CD92,$03 Add the height of the old position.
  $CD95,$01 Compare it with the new top edge.
  $CD96,$02 Jump to #R$CD99 if it is higher.
  $CD98,$01 Take the new one instead.
@ $CD99 label=FlagOverlappingObjects_AreaHeight
  $CD99,$01 Take the bottom edge off it.
  $CD9A,$01 Stash the height of the area in #REGh.
@ $CD9B label=FlagOverlappingObjects_Next
  $CD9B,$03 Fetch the graphic number of the other object.
  $CD9E,$01 Test whether it is null.
  $CD9F,$02 Jump to #R$CDC2 if it is.
  $CDA1,$06 Jump to #R$CDC2 if the other object is already flagged to be drawn.
  $CDA7,$03 Fetch the pixel X coordinate of the other object.
  $CDAA,$03 Divide it by eight.
  $CDAD,$02,b$01 Keep the byte of the screen.
  $CDAF,$01 Take the left edge of the area off it.
  $CDB0,$02 Jump to #R$CDCC if the object starts to the left of the area.
@ $CDB2 label=FlagOverlappingObjects_Right
  $CDB2,$01 Compare it with the width of the area.
@ $CDB3 label=FlagOverlappingObjects_Right_Test
  $CDB3,$02 Jump to #R$CDC2 if the object starts to the right of the area.
  $CDB5,$03 Fetch the pixel Y coordinate of the other object.
  $CDB8,$01 Take the bottom edge of the area off it.
  $CDB9,$02 Jump to #R$CDD3 if the object starts below the area.
@ $CDBB label=FlagOverlappingObjects_Top
  $CDBB,$01 Compare it with the height of the area.
@ $CDBC label=FlagOverlappingObjects_Top_Test
  $CDBC,$02 Jump to #R$CDC2 if the object starts above the area.
  $CDBE,$04 Flag the other object to be drawn.
@ $CDC2 label=FlagOverlappingObjects_Advance
  $CDC2,$01 Switch to the alternate registers.
  $CDC3,$03 Set #REGde to the size of an object.
  $CDC6,$02 Point #REGiy at the next object.
  $CDC8,$01 Switch back to the main registers.
  $CDC9,$02 Jump to #R$CD9B until all of the objects have been tested.
  $CDCB,$01 Return.
@ $CDCC label=FlagOverlappingObjects_Left
N $CDCC The object starts to the left of the area, so it overlaps only if it is
. wide enough to reach the area.
  $CDCC,$02 Make the distance positive.
  $CDCE,$03 Compare it with the width of the sprite of the other object.
  $CDD1,$02 Jump to #R$CDB3.
@ $CDD3 label=FlagOverlappingObjects_Below
N $CDD3 The object starts below the area, so it overlaps only if it is tall
. enough to reach the area.
  $CDD3,$02 Make the distance positive.
  $CDD5,$03 Compare it with the height of the sprite of the other object.
  $CDD8,$02 Jump to #R$CDBC.

c $CDDA Handle Human Top
@ $CDDA label=HandleHumanTop
D $CDDA Handles the top half of the player while it is in the form of a human,
. which is the graphic numbers #N$20 to #N$2F.
R $CDDA IX Address of the object
  $CDDA,$03 Set the pixel adjustments of the top half of a human.
  $CDDD,$02 Jump to #R$CDE2.

c $CDDF Handle Wulf Top
@ $CDDF label=HandleWulfTop
D $CDDF Handles the top half of the player while it is in the form of a wulf,
. which is the graphic numbers #N$40 to #N$4F.
E $CDDF View the equivalent code in;
. #LIST
. { #PENTAGRAM$C5D3 }
. LIST#
R $CDDF IX Address of the object
  $CDDF,$03 Set the pixel adjustments of the top half of a wulf.

c $CDE2 Handle Player Top
@ $CDE2 label=HandlePlayerTop
D $CDE2 Does all of the work for the top half of the player, which is a copy of
. the bottom half, placed #N$0C above it. The top half has no height, and is
. ignored in the 3D calculations. If it has been flagged as dead, this starts
. the death sparkles. Every so often the player looks to one side or the other:
. this picks a head that looks that way and keeps it for eight frames.
R $CDE2 IX Address of the object
N $CDE2 Start the death sparkles if the top half is flagged as dead.
  $CDE2,$04 Fetch the final animation flag from #R$5BC3.
  $CDE6,$02 Jump to #R$CDEF if it is set.
  $CDE8,$07 Jump to #R$BF21 to start the death sparkles if the top half is
. flagged as dead.
@ $CDEF label=HandlePlayerTop_Copy
N $CDEF Copy the bottom half and place the top half #N$0C above it.
  $CDEF,$03 Point #REGde at the top half (using the stack).
  $CDF2,$04 Point #REGhl at the bottom half, which is #N$20 bytes before.
  $CDF6,$03 Point #REGiy at the bottom half (using the stack).
  $CDF9,$01 Point #REGde at the X coordinate of the top half.
  $CDFA,$01 Point #REGhl at the X coordinate of the bottom half.
  $CDFB,$03 Set the number of bytes to #N$07.
  $CDFE,$02 Copy the coordinates, the size and the flags.
  $CE00,$04 Set the height of the top half to zero.
  $CE04,$04 Flag the top half to be ignored in the 3D calculations.
  $CE08,$03 Fetch the flags.
  $CE0B,$02,b$01 Keep the counter for looking to one side.
  $CE0D,$02 Jump to #R$CE14 if the counter has run out.
  $CE0F,$03 Count it down.
  $CE12,$02 Jump to #R$CE27.
@ $CE14 label=HandlePlayerTop_Look
N $CE14 Pick a head that looks to one side, or keep the current one.
  $CE14,$03 Fetch a random number from #R$5BA5.
  $CE17,$04 Jump to #R$CE33 if it is less than #N$02.
  $CE1B,$04 Jump to #R$CE40 if it is at least #N$FE.
  $CE1F,$03 Fetch the graphic number of the bottom half.
@ $CE22 label=HandlePlayerTop_SetGraphic
  $CE22,$02 Add #N$10 to it to get the graphic number of the top half.
  $CE24,$03 Set the graphic number of the top half.
@ $CE27 label=HandlePlayerTop_SetZ
  $CE27,$03 Fetch the Z coordinate of the bottom half.
  $CE2A,$02 Add #N$0C to it.
  $CE2C,$03 Set the Z coordinate of the top half.
  $CE2F,$03 Flag the objects that overlap the player to be drawn.
  $CE32,$01 Return.
@ $CE33 label=HandlePlayerTop_LookOneWay
  $CE33,$03 Fetch the graphic number of the bottom half.
  $CE36,$02,b$01 Keep the direction the player is facing.
  $CE38,$02,b$01 Choose the head that looks one way.
@ $CE3A label=HandlePlayerTop_SetCounter
  $CE3A,$04 Make the player look that way for eight frames.
  $CE3E,$02 Jump to #R$CE22.
@ $CE40 label=HandlePlayerTop_LookOtherWay
  $CE40,$03 Fetch the graphic number of the bottom half.
  $CE43,$02,b$01 Keep the direction the player is facing.
  $CE45,$02,b$01 Choose the head that looks the other way.
  $CE47,$02 Jump to #R$CE3A.

c $CE49 Save Sprite Info
@ $CE49 label=SaveSpriteInfo
D $CE49 Keeps the size and the pixel coordinates of the sprite of an object as
. its old values, so that the area that it covered can be redrawn when it moves.
R $CE49 IX Address of the object
  $CE49,$06 Save the width of the sprite in bytes.
  $CE4F,$06 Save the height of the sprite in lines.
  $CE55,$06 Save the pixel X coordinate.
  $CE5B,$06 Save the pixel Y coordinate.
  $CE61,$01 Return.

c $CE62 List Objects To Draw
@ $CE62 label=ListObjectsToDraw
D $CE62 Makes the list at #R$CE8B of the objects that have to be drawn again.
. Each entry is the index of an object in the objects table, and the list ends
. with #N$FF. An object is in the list if it is present and flagged to be drawn.
E $CE62 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C71C }
. { #PENTAGRAM$B531 }
. LIST#
N $CE62 Add each object that is present and flagged to be drawn.
  $CE62,$02 Stash #REGix on the stack.
  $CE64,$02 Set the number of objects to #N$28.
  $CE66,$03 Set #REGde to the size of an object.
  $CE69,$04 Point #REGix at #R$5C08.
  $CE6D,$03 Point #REGhl at #R$CE8B.
  $CE70,$02 Set the index of the object to zero.
@ $CE72 label=ListObjectsToDraw_Next
  $CE72,$04 Fetch the graphic number of the object and test whether it is null.
  $CE76,$02 Jump to #R$CE80 if it is.
  $CE78,$06 Jump to #R$CE80 if the object is not flagged to be drawn.
  $CE7E,$01 Add the index of the object to the list.
  $CE7F,$01 Move on to the next place in the list.
@ $CE80 label=ListObjectsToDraw_Advance
  $CE80,$01 Go to the next index.
  $CE81,$02 Point #REGix at the next object.
  $CE83,$02 Jump to #R$CE72 until all of the objects have been tested.
  $CE85,$02 Fetch the end marker.
  $CE87,$01 Store it at the end of the list.
  $CE88,$02 Restore #REGix from the stack.
  $CE8A,$01 Return.

b $CE8B List Of Objects To Draw
@ $CE8B label=ObjectsToDrawList
D $CE8B The indexes of the objects that have to be drawn, made by #R$CE62. As an
. object is drawn bit 7 of its entry is set.
B $CE8B,$30,$10

c $CEBB Draw Objects In Order
@ $CEBB label=DrawObjectsInOrder
D $CEBB Draws the objects in the list at #R$CE8B so that the objects at the back
. are drawn before the objects in front of them. It takes the first object in
. the list that has not been drawn yet and compares it with each of the other
. objects that are waiting. If another object has to be drawn first, that object
. takes the place of the first object and is compared with the others in its
. turn. This carries on until an object is found that does not have to wait for
. any other object, and that one is drawn. This is repeated until the list is
. empty. The objects drawn are counted in #R$5BBE.
E $CEBB View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C785 }
. { #PENTAGRAM$B58A }
. LIST#
  $CEBB,$04 Set the number of objects drawn to zero at #R$5BBE.
  $CEBF,$04 Stash #REGix and #REGiy on the stack.
@ $CEC3 label=DrawObjectsInOrder_First
  $CEC3,$03 Point #REGde at the list, #R$CE8B.
@ $CEC6 label=DrawObjectsInOrder_FindFirst
  $CEC6,$01 Fetch the index of an object from the list.
  $CEC7,$01 Move on to the next entry.
  $CEC8,$05 Jump to #R$D015 if it is the end of the list.
  $CECD,$04 Jump to #R$CEC6 if the object has been drawn.
  $CED1,$03 Find the address of the object.
  $CED4,$04 Remember the place in the list at #R$5BCD.
  $CED8,$03 Point #REGix at the object (using the stack).
@ $CEDB label=DrawObjectsInOrder_FindSecond
  $CEDB,$01 Fetch the index of another object from the list.
  $CEDC,$01 Move on to the next entry.
  $CEDD,$05 Jump to #R$D000 if it is, as nothing has to be drawn before the
. first object.
  $CEE2,$04 Jump to #R$CEDB if the object has been drawn.
  $CEE6,$03 Find the address of the object.
  $CEE9,$04 Remember the place in the list at #R$5BCF.
  $CEED,$03 Point #REGiy at the other object (using the stack).
  $CEF0,$03 Copy the address of the first object to #REGbc (using the
. stack).
  $CEF3,$01 Clear the carry flag.
  $CEF4,$02 Test whether the other object is the first object.
  $CEF6,$02 Jump to #R$CEDB if it is.
N $CEF8 Each of the three directions gives a number. The number in Z is #N$00 if
. the first object is above the other, #N$01 if the objects overlap in Z and
. #N$02 if the first object is below. The number in Y is #N$00 if the first
. object is to the north of the other, #N$03 if the objects overlap in Y and
. #N$06 if the first object is to the south. The number in X is #N$00 if the
. first object is to the east of the other, #N$09 if the objects overlap in X
. and #N$12 if the first object is to the west. The three numbers are added
. together in #REGc.
  $CEF8,$02 Set the number to zero.
  $CEFA,$07 Work out where the top of the other object is.
  $CF01,$04 Take it off the Z coordinate of the first object.
  $CF05,$02 Jump to #R$CF16 if the first object is above the other.
  $CF07,$07 Work out where the top of the first object is.
  $CF0E,$04 Take it off the Z coordinate of the other object.
  $CF12,$02 Jump to #R$CF15 if the objects overlap in Z.
  $CF14,$01 Add one to the number in Z.
@ $CF15 label=DrawObjectsInOrder_Overlap
  $CF15,$01 Add one to the number in Z.
@ $CF16 label=DrawObjectsInOrder_Y
  $CF16,$07 Work out where the north edge of the other object is.
  $CF1D,$07 Work out where the south edge of the first object is, and take the
. north edge of the other object off it.
  $CF24,$02 Jump to #R$CF3C if the first object is to the north of the other.
  $CF26,$07 Work out where the north edge of the first object is.
  $CF2D,$07 Work out where the south edge of the other object is, and take the
. north edge of the first object off it.
  $CF34,$01 Fetch the number so far.
  $CF35,$02 Jump to #R$CF39 if the objects overlap in Y.
  $CF37,$02 Add #N$03 to the number in Y.
@ $CF39 label=DrawObjectsInOrder_OverlapY
  $CF39,$02 Add #N$03 to the number in Y.
  $CF3B,$01 Store the number.
@ $CF3C label=DrawObjectsInOrder_X
  $CF3C,$07 Work out where the east edge of the other object is.
  $CF43,$07 Work out where the west edge of the first object is, and take the
. east edge of the other object off it.
  $CF4A,$02 Jump to #R$CF62 if the first object is to the east of the other.
  $CF4C,$07 Work out where the east edge of the first object is.
  $CF53,$07 Work out where the west edge of the other object is, and take the
. east edge of the first object off it.
  $CF5A,$01 Fetch the number so far.
  $CF5B,$02 Jump to #R$CF5F if the objects overlap in X.
  $CF5D,$02 Add #N$09 to the number in X.
@ $CF5F label=DrawObjectsInOrder_OverlapX
  $CF5F,$02 Add #N$09 to the number in X.
  $CF61,$01 Store the number.
@ $CF62 label=DrawObjectsInOrder_Jump
  $CF62,$01 Use the number as the index into the table.
  $CF63,$03 Point #REGbc at #R$CF69.
  $CF66,$03 Jump to the routine for the number.

w $CF69 Drawing Order Table
@ $CF69 label=DrawingOrderTable
D $CF69 The routines that decide what is done about a pair of objects, by the
. number made from the directions in #R$CEF8. The number is the number in Z plus
. the number in Y plus the number in X. Either the first object is not held up
. by the other, or the other object has to be drawn first, or the objects fill
. the same space.
W $CF69,$06,$02 #N$00 to #N$02: the first object is not held up.
W $CF6F,$04,$02 #N$03 and #N$04: the other object is drawn first.
W $CF73,$02,$02 #N$05: the first object is not held up.
W $CF75,$04,$02 #N$06 and #N$07: the other object is drawn first.
W $CF79,$04,$02 #N$08 and #N$09: the first object is not held up.
W $CF7D,$04,$02 #N$0A and #N$0B: the first object is not held up.
W $CF81,$02,$02 #N$0C: the other object is drawn first.
W $CF83,$02,$02 #N$0D: the objects fill the same space.
W $CF85,$02,$02 #N$0E: the first object is not held up.
W $CF87,$04,$02 #N$0F and #N$10: the other object is drawn first.
W $CF8B,$04,$02 #N$11 and #N$12: the first object is not held up.
W $CF8F,$04,$02 #N$13 and #N$14: the first object is not held up.
W $CF93,$02,$02 #N$15: the first object is not held up.
W $CF95,$04,$02 #N$16 and #N$17: the first object is not held up.
W $CF99,$06,$02 #N$18 to #N$1A: the first object is not held up.

c $CF9F Continue Comparing Objects
@ $CF9F label=ContinueComparingObjects
D $CF9F The first object is not held up by the other object, so go on to compare
. it with the next one.
  $CF9F,$03 Jump to #R$CEDB.
@ $CFA2 label=ContinueComparingObjects_Alternate
  $CFA2,$03 Jump to #R$CEDB.

c $CFA5 Compare With Other Object
@ $CFA5 label=CompareWithOtherObject
D $CFA5 Handles the other object having to be drawn first. It becomes the first
. object, and the comparisons start again from the beginning of the list. The
. objects that have taken the place of the first object are kept in the list at
. #R$D01A. If the other object is already there the objects hold each other up,
. and the other object is drawn to break the loop.
E $CFA5 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C86F }
. LIST#
R $CFA5 IY Address of the other object
N $CFA5 Draw the other object first, or break a loop if it is already
. in the chain.
  $CFA5,$03 Fetch the place in the list after the other object from #R$5BCF.
  $CFA8,$01 Point #REGhl at the entry of the other object.
  $CFA9,$01 Fetch the index of the other object.
  $CFAA,$03 Point #REGde at #R$D01A.
@ $CFAD label=CompareWithOtherObject_Find
  $CFAD,$01 Fetch an entry.
  $CFAE,$04 Jump to #R$CFB8 if it is the end of the list.
  $CFB2,$01 Test whether it is the other object.
  $CFB3,$02 Jump to #R$CFCE if it is.
  $CFB5,$01 Move on to the next entry.
  $CFB6,$02 Jump to #R$CFAD.
@ $CFB8 label=CompareWithOtherObject_Add
  $CFB8,$01 Fetch the index of the other object.
  $CFB9,$01 Add it to the list.
  $CFBA,$01 Move on to the next entry.
  $CFBB,$03 Mark the end of the list.
  $CFBE,$04 Make the other object the first object (using the stack).
  $CFC2,$03 Fetch the place in the list after the other object from #R$5BCF.
  $CFC5,$03 Make it the place in the list after the first object at #R$5BCD.
  $CFC8,$03 Point #REGde at #R$CE8B.
  $CFCB,$03 Jump to #R$CEDB.
@ $CFCE label=CompareWithOtherObject_Loop
  $CFCE,$03 Point #REGhl at the list of objects to draw, #R$CE8B.
@ $CFD1 label=CompareWithOtherObject_Search
  $CFD1,$01 Fetch an entry.
  $CFD2,$01 Move on to the next entry.
  $CFD3,$05 Jump to #R$CEC3 if it is the end of the list.
  $CFD8,$01 Test whether it is the other object.
  $CFD9,$02 Jump to #R$CFD1 if it is not.
  $CFDB,$04 Make the other object the first object (using the stack).
  $CFDF,$02 Jump to #R$D003 to draw it.

c $CFE1 Replace Overlapping Special Object
@ $CFE1 label=ReplaceOverlappingSpecialObject
D $CFE1 Handles two objects that fill the same space. If one of them is a
. special object, it is replaced by a twinkling sprite.
R $CFE1 IX Address of the first object
R $CFE1 IY Address of the other object
N $CFE1 Replace a special object that fills the same space with a
. twinkling sprite.
  $CFE1,$03 Fetch the graphic number of the first object.
  $CFE4,$02 Take #N$60 off it, to get the number of the special object.
  $CFE6,$04 Jump to #R$CFF0 if it is not a special object.
  $CFEA,$04 Replace it with the twinkling sprite.
  $CFEE,$02 Jump to #R$CFFD.
@ $CFF0 label=ReplaceOverlappingSpecialObject_Other
  $CFF0,$03 Fetch the graphic number of the other object.
  $CFF3,$02 Take #N$60 off it, to get the number of the special object.
  $CFF5,$04 Jump to #R$CFFD if it is not a special object.
  $CFF9,$04 Replace it with the twinkling sprite.
@ $CFFD label=ReplaceOverlappingSpecialObject_Next
  $CFFD,$03 Jump to #R$CEDB.

c $D000 Draw Next Object
@ $D000 label=DrawNextObject
D $D000 Draws an object that does not have to wait for any other object, and
. flags it as drawn in the list.
E $D000 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C8D5 }
. LIST#
R $D000 IX Address of the object
  $D000,$03 Fetch the place in the list after the first object from #R$5BCD.
@ $D003 label=DrawNextObject_Flag
  $D003,$01 Point #REGhl at the entry of the object.
  $D004,$02 Flag the object as drawn.
  $D006,$05 Mark the end of the list of objects that have taken the place of the
. first object at #R$D01A.
  $D00B,$03 Point #REGhl at #R$5BBE.
  $D00E,$01 Add one to it.
  $D00F,$03 Draw the object into the buffer.
  $D012,$03 Jump to #R$CEC3 to find the next object.
@ $D015 label=DrawNextObject_Finish
N $D015 There are no objects left to draw.
  $D015,$04 Restore #REGiy and #REGix from the stack.
  $D019,$01 Return.

b $D01A Chain Of Objects
@ $D01A label=ObjectChain
D $D01A The indexes of the objects that have been compared, used by #R$CFA5, and
. ending with #N$FF.
B $D01A,$08,$08

c $D022 Read Controls
@ $D022 label=ReadControls
D $D022 Reads the controls that the player is using and stores them in #R$5BB5.
. #TABLE(default,centre,centre)
. { =h Bit | =h Meaning }
. { #N$00 | Left }
. { #N$01 | Right }
. { #N$02 | Walk }
. { #N$03 | Jump }
. { #N$04 | Pick up (or down on a directional stick) }
. { #N$05 | Directional pick up }
. TABLE#
. No control is read during the final animation or while an object is being put
. into the cauldron.
E $D022 Continue on to #R$D03E.
E $D022 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C8FF }
. { #GUNFRIGHT$D0E3 }
. { #NIGHTSHADE$E241 }
. LIST#
R $D022 O:C The controls
N $D022 Jump to the reader for the chosen control method.
  $D022,$03 Fetch the final animation flag from #R$5BC3.
  $D025,$01 Stash it in #REGc.
  $D026,$03 Fetch the flag for an object being put into the cauldron from
. #R$5BC4.
  $D029,$01 Combine the two flags.
  $D02A,$02 Set the controls to none.
  $D02C,$03 Jump to #R$D111 if either flag is set.
  $D02F,$03 Fetch the control method from #R$5BA4.
  $D032,$01 Move the keyboard and joystick choice into bits 0 and 1.
  $D033,$02,b$01 Keep it.
  $D035,$03 Jump to #R$D0C8 if the keyboard is in use.
  $D038,$01 Test for the Kempston joystick.
  $D039,$02 Jump to #R$D077 if it is in use.
  $D03B,$01 Test for the cursor joystick.
  $D03C,$02 Jump to #R$D09C if it is in use.

c $D03E Read Interface 2 Joystick
@ $D03E label=ReadInterface2Joystick
D $D03E Reads the controls from the Interface 2 joysticks, which are the keys 1
. to 5 for the first joystick and 6 to 0 for the second joystick. The joysticks
. use the keys left, right, down, up and fire in that order, so the keys of the
. first joystick are reversed to put them in the same order as the keys of the
. second joystick.
E $D03E View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C91B }
. { #GUNFRIGHT$D0F2 }
. { #NIGHTSHADE$E250 }
. LIST#
R $D03E O:C The controls
N $D03E Reverse the keys 1 to 5.
  $D03E,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $D043,$01 Stash #REGbc on the stack.
  $D044,$02 Set the number of keys to #N$05.
N $D046 Reverse the order of the five keys into #REGc.
@ $D046 label=ReadInterface2Joystick_Reverse
  $D046,$01 Rotate #REGa right.
  $D047,$02 Rotate #REGc left.
  $D049,$02 Jump to #R$D046 until #REGb is zero.
N $D04B Take the reversed keys and restore #REGbc.
  $D04B,$01 Copy #REGc to #REGa.
  $D04C,$01 Restore #REGbc from the stack.
  $D04D,$01 Copy it to #REGc.
N $D04E Merge the keys 6 to 0.
  $D04E,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $D053,$01 Combine the keys of the two joysticks.
  $D054,$02 Set the controls to none.
  $D056,$06 Set the jump control if the fire key is pressed.
@ $D05C label=ReadInterface2Joystick_TestUp
  $D05C,$06 Set the walk control if the up key is pressed.
@ $D062 label=ReadInterface2Joystick_TestDown
  $D062,$06 Set the pick up control if the down key is pressed.
@ $D068 label=ReadInterface2Joystick_TestRight
  $D068,$06 Set the right control if the right key is pressed.
@ $D06E label=ReadInterface2Joystick_TestLeft
  $D06E,$06 Set the left control if the left key is pressed.
@ $D074 label=ReadInterface2Joystick_Done
  $D074,$03 Jump to #R$D111.

c $D077 Read Kempston Joystick
@ $D077 label=ReadKempstonJoystick
D $D077 Reads the controls from a Kempston joystick.
E $D077 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C954 }
. { #GUNFRIGHT$D12B }
. { #NIGHTSHADE$E289 }
. LIST#
R $D077 O:C The controls
N $D077 Set each control bit from the Kempston port.
  $D077,$02 Read the joystick.
  $D079,$02 Set the controls to none.
  $D07B,$06 Set the right control if the joystick is pushed right.
@ $D081 label=ReadKempstonJoystick_TestLeft
  $D081,$06 Set the left control if the joystick is pushed left.
@ $D087 label=ReadKempstonJoystick_TestDown
  $D087,$06 Set the pick up control if the joystick is pushed down.
@ $D08D label=ReadKempstonJoystick_TestUp
  $D08D,$06 Set the walk control if the joystick is pushed up.
@ $D093 label=ReadKempstonJoystick_TestFire
  $D093,$06 Set the jump control if the fire button is pressed.
@ $D099 label=ReadKempstonJoystick_Done
  $D099,$03 Jump to #R$D111.

c $D09C Read Cursor Joystick
@ $D09C label=ReadCursorJoystick
D $D09C Reads the controls from a cursor joystick, which uses the keys 5 for
. left, 8 for right, 7 for up, 6 for down and 0 for fire.
E $D09C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C979 }
. { #GUNFRIGHT$D150 }
. { #NIGHTSHADE$E2AE }
. LIST#
R $D09C O:C The controls
N $D09C Left from the 1-5 row.
  $D09C,$02 Set the controls to none.
  $D09E,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $D0A3,$06 Set the left control if 5 is pressed.
N $D0A9 Fire, up, right and down from the 0-9 row.
@ $D0A9 label=ReadCursorJoystick_SecondRow
  $D0A9,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $D0AE,$06 Set the jump control if 0 is pressed.
@ $D0B4 label=ReadCursorJoystick_TestUp
  $D0B4,$06 Set the walk control if 7 is pressed.
@ $D0BA label=ReadCursorJoystick_TestRight
  $D0BA,$06 Set the right control if 8 is pressed.
@ $D0C0 label=ReadCursorJoystick_TestDown
  $D0C0,$04 Jump to #R$D111 if 6 is not pressed.
  $D0C4,$02 Set the pick up control.
  $D0C6,$02 Jump to #R$D111.

c $D0C8 Read Keyboard
@ $D0C8 label=ReadKeyboard
D $D0C8 Reads the controls from the keyboard. Left is Z, C, M or B, right is X,
. V, symbol shift or N, walking forward is any key of the rows A to G and H to
. ENTER, jumping is any key of the rows Q to T and Y to P, and picking up and
. dropping an object is any key of the rows 1 to 5 and 6 to 0.
E $D0C8 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C9A5 }
. LIST#
R $D0C8 O:C The controls
N $D0C8 Left and right from the bottom row.
  $D0C8,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $D0CD,$01 Move Z into bit 0.
  $D0CE,$01 Stash the keys in #REGc.
  $D0CF,$02,b$01 Keep Z and X.
  $D0D1,$04 Move C and V into bits 0 and 1.
  $D0D5,$01 Combine them with Z and X.
  $D0D6,$02,b$01 Keep the left and right bits.
  $D0D8,$01 Stash them in #REGc.
  $D0D9,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | SYMBOL SHIFT | M | N | B }
. TABLE#
  $D0DE,$06 Set the right control if symbol shift is pressed.
@ $D0E4 label=ReadKeyboard_TestM
  $D0E4,$06 Set the left control if M is pressed.
@ $D0EA label=ReadKeyboard_TestN
  $D0EA,$06 Set the right control if N is pressed.
@ $D0F0 label=ReadKeyboard_TestB
  $D0F0,$06 Set the left control if B is pressed.
@ $D0F6 label=ReadKeyboard_WalkKeys
  $D0F6,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$BD | A / ENTER | S / L | D / K | F / J | G / H }
. TABLE#
  $D0FB,$04 Set the walk control if any of them is pressed.
@ $D0FF label=ReadKeyboard_JumpKeys
  $D0FF,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DB | Q / P | W / O | E / I | R / U | T / Y }
. TABLE#
  $D104,$04 Set the jump control if any of them is pressed.
@ $D108 label=ReadKeyboard_PickUpKeys
  $D108,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$E7 | 1 / 0 | 2 / 9 | 3 / 8 | 4 / 7 | 5 / 6 }
. TABLE#
  $D10D,$04 Set the pick up control if any of them is pressed.
@ $D111 label=ReadControls_Finish
N $D111 Reads the keys that pick up and drop an object when a joystick with
. directional control is in use. The keys that count are Z, X, C, V, A to G, H
. to ENTER, Q to T and Y to P.
  $D111,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SHIFT / SPACE | Z / SYM | X / M | C / N | V / B }
. TABLE#
  $D116,$02,b$01 Keep the keys Z, X, C, V, symbol shift, M, N and B.
  $D118,$01 Stash #REGbc on the stack.
  $D119,$01 Stash the keys in #REGb.
  $D11A,$05 Read the keys SHIFT to V, 1 to 5, 6 to 0 and SPACE to B.
  $D11F,$01 Combine the keys.
  $D120,$01 Restore #REGbc from the stack.
  $D121,$02 Jump to #R$D125 if no key is pressed.
  $D123,$02 Set the directional pick up control.
@ $D125 label=ReadControls_Store
  $D125,$01 Fetch the controls.
  $D126,$03 Store them at #R$5BB5.
  $D129,$01 Return.

c $D12A Lose Life
@ $D12A label=LoseLife
D $D12A Puts the player back as it was when it entered the room, and takes a
. life off. If there are no lives left the game is over. The player is a human
. if the sun is out, or a wulf if the moon is out.
  $D12A,$03 Point #REGhl at the copy of the player, #R$D161.
  $D12D,$03 Point #REGde at #R$5C08.
  $D130,$03 Point #REGix at the objects table (using the stack).
  $D133,$03 Set the length to #N($40), for the two halves of the player.
  $D136,$02 Copy the player back.
  $D138,$04 Clear the flag that says the player has to transform, #R$5BB1.
N $D13C See #POKE(infinite_lives,Infinite Lives).
  $D13C,$04 Take a life off #R$5BBA.
  $D140,$03 Jump to #R$BA22 if there are none left.
  $D143,$03 Fetch the graphic number of the sun/moon from #R$C44D.
  $D146,$03 Move bit 0 into bit 5.
  $D149,$02,b$01 Keep it, which is #N$20 if the moon is out.
  $D14B,$01 Stash it in #REGc.
  $D14C,$03 Fetch the graphic number that the legs of the player will have when
. it appears.
  $D14F,$02,b$01 Keep the number of the legs of a human.
  $D151,$01 Add #N$20 if the moon is out, to make the legs of a wulf.
  $D152,$03 Store it.
  $D155,$03 Fetch the graphic number that the top half of the player will have
. when it appears.
  $D158,$02,b$01 Keep the number of the top half without the form.
  $D15A,$01 Add #N$20 if the moon is out.
  $D15B,$02 Add #N$20 to make the top half of a human or of a wulf.
  $D15D,$03 Store it.
  $D160,$01 Return.

g $D161 Copy Of Player
@ $D161 label=PlayerCopy
D $D161 A copy of the two objects of the player, as they were when the player
. entered the room (or as they are at the start of the game), which is put back
. by #R$D12A when a life is lost. The first #N$20 bytes are the legs and the
. last #N$20 bytes are the top half. The byte at #R$D169 is the room number of
. the legs, and the byte at #R$D189 that of the top half.
B $D161,$08,$08 The legs: the graphic number, the coordinates, the size and the
. flags.
@ $D169 label=PlayerCopy_LegsRoom
B $D169,$01,$01 The room number of the legs.
B $D16A,$17,$08 The rest of the legs.
@ $D181 label=PlayerCopy_TopHalf
B $D181,$08,$08 The top half: the graphic number, the coordinates, the size and
. the flags.
@ $D189 label=PlayerCopy_TopHalfRoom
B $D189,$01,$01 The room number of the top half.
B $D18A,$17,$08 The rest of the top half.

b $D1A1 Initial Player Data
@ $D1A1 label=InitialPlayerData
D $D1A1 The first eight bytes of each object of the player at the start of the
. game: the graphic number, the X, Y and Z coordinates, the width, the depth,
. the height and the flags.
B $D1A1,$08,$08 The legs, which are a sparkle, at the middle of the room, with a
. height of #N$17.
B $D1A9,$08,$08 The top half, which is a sparkle too, #N$0C higher than the legs
. and with no height.

c $D1B1 Initialise Player
@ $D1B1 label=InitialisePlayer
D $D1B1 Sets up the copy of the player at the start of the game. The player
. appears in a room that is picked at random from four rooms.
E $D1B1 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CA6D }
. LIST#
N $D1B1 Copy the initial player and pick a start room.
  $D1B1,$03 Point #REGhl at the initial data of the player, #R$D1A1.
  $D1B4,$03 Point #REGde at #R$D161.
  $D1B7,$03 Set the number of bytes to #N$08.
  $D1BA,$02 Copy the initial data of the legs.
  $D1BC,$03 Point #REGde at #R$D181.
  $D1BF,$03 Set the number of bytes to #N$08.
  $D1C2,$02 Copy the initial data of the top half.
  $D1C4,$02 Fetch the graphic number of the legs of a human.
  $D1C6,$03 Store it as the graphic that the legs have when the player appears.
  $D1C9,$02 Fetch the graphic number of the top half of a human.
  $D1CB,$03 Store it as the graphic that the top half has when the player
. appears.
  $D1CE,$03 Fetch the first random seed from #R$5BA0.
  $D1D1,$02,b$01 Keep two bits.
  $D1D3,$03 Make it an offset.
  $D1D6,$03 Point #REGbc at #R$D1E2.
  $D1D9,$01 Add the offset.
  $D1DA,$01 Fetch the start room.
  $D1DB,$03 Set the room of the legs at #R$D169.
  $D1DE,$03 Set the room of the top half at #R$D189.
  $D1E1,$01 Return.

b $D1E2 Start Rooms
@ $D1E2 label=StartRooms
D $D1E2 The rooms that the player may start in.
B $D1E2,$04,$04

c $D1E6 Build Room Objects
@ $D1E6 label=BuildRoomObjects
D $D1E6 Builds the objects of the room that the player is in, and sets the game
. up to start again in it.
N $D1E6 Build the room, place the player, and reset the room flags.
  $D1E6,$04 Fetch the flag that says it is not the first room of the game from
. #R$5BB2.
  $D1EA,$02 Jump to #R$D1EF if it is the first room.
  $D1EC,$03 Store the special objects of the room that the player has left.
@ $D1EF label=BuildRoomObjects_Clear
  $D1EF,$03 Clear the objects of the room, apart from the player.
  $D1F2,$03 Make the objects of the room from the room data.
  $D1F5,$03 Find the special objects that are in the room.
  $D1F8,$03 Move the player to the right place for the way it came in.
  $D1FB,$01 Get a zero to clear the flags with.
  $D1FC,$03 Clear the flag that says a portcullis is moving at #R$5BAF.
  $D1FF,$03 Clear the number of times a portcullis has come down at #R$5BB0.
  $D202,$03 Clear the height of the bounce of a ball at #R$5BBD.
  $D205,$03 Clear the flag that says a spiked ball is dropping at #R$5BBF.
  $D208,$02 Get the value that sets a flag.
  $D20A,$03 Flag the panel to be drawn again at #R$5BB7.
  $D20D,$03 Fetch the room number.
  $D210,$02,b$01 Keep bit 0.
  $D212,$03 Set the flag that stops the spiked balls from dropping at #R$5BC0.
  $D215,$03 Flag the room as visited.
  $D218,$01 Return.

c $D219 Visit Room
@ $D219 label=VisitRoom
D $D219 Flags the room that the player is in as visited, in the bitmap of the
. rooms at #R$5BE8. The bit that is set is chosen by changing the instruction at
. #R$D234, which is a SET instruction, by changing the byte that follows it.
E $D219 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B863 }
. { #SABREWULF$9D23 }
. LIST#
N $D219 Set the bit of this room in #R$5BE8.
  $D219,$03 Fetch the room number.
  $D21C,$01 Stash it in #REGc.
  $D21D,$03 Divide it by eight.
  $D220,$02,b$01 Keep the offset of the byte.
  $D222,$01 Stash it in #REGl.
  $D223,$02 Clear the high byte of the offset.
  $D225,$01 Fetch the room number.
  $D226,$03 Move the low three bits to bits 3 to 5.
  $D229,$02,b$01 Keep them.
  $D22B,$02,b$01 Make them into the second byte of an instruction to set that
. bit.
  $D22D,$03 Put the byte into the instruction at #R$D234.
  $D230,$03 Point #REGbc at #R$5BE8.
  $D233,$01 Add the offset of the byte.
@ $D234 label=VisitRoom_Set
  $D234,$02 Set the bit of the room.
  $D236,$01 Return.

c $D237 Set Sprite Details
@ $D237 label=SetSpriteDetails
D $D237 Sets the graphic number, the flags and the pixel coordinates of an
. object from four bytes of data.
E $D237 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CAF1 }
. { #PENTAGRAM$BDC0 }
. LIST#
R $D237 HL Address of the data
R $D237 IX Address of the object
R $D237 O:HL Address of the byte after the data
N $D237 Copy the graphic, flags and pixel coordinates from the data.
  $D237,$02 Fetch the graphic number and move on.
  $D239,$03 Set the graphic number of the object.
  $D23C,$02 Fetch the flags and move on.
  $D23E,$03 Set the flags of the object.
  $D241,$02 Fetch the pixel X coordinate and move on.
  $D243,$03 Set the pixel X coordinate of the object.
  $D246,$02 Fetch the pixel Y coordinate and move on.
  $D248,$03 Set the pixel Y coordinate of the object.
  $D24B,$01 Return.

c $D24C Print Table Sprite
@ $D24C label=PrintTableSprite
D $D24C Sets the details of an object from four bytes of data, and draws it.
E $D24C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CB06 }
. { #PENTAGRAM$BDD5 }
. LIST#
R $D24C HL Address of the data
R $D24C IX Address of the object
R $D24C O:HL Address of the byte after the data
  $D24C,$03 Set the details of the object.
  $D24F,$01 Stash the address of the data on the stack.
  $D250,$03 Draw the sprite.
  $D253,$01 Restore the address of the data from the stack.
  $D254,$01 Return.

c $D255 Draw Panel
@ $D255 label=DrawPanel
D $D255 Draws the shapes of the panel at the bottom of the screen, using the
. sprites in the table at #R$D27E. On each side there is a run of five sprites
. that go up or down in steps, followed by two more sprites. The right side is
. the left side flipped.
.
. #PUSHS #UDGTABLE { =h After #R$D255 and #R$D56F }
. { #SIM(start=$AF6C,stop=$AFA2,sp=$5BA0,clear=1)
. #SIM(start=$D55F,stop=$0000,sp=$5B80)
. #SIM(start=$D255,stop=$0000,sp=$5B80)
. #SIM(start=$D56F,stop=$0000,sp=$5B80)
. #SCR$02,$00,$10,$20,$08(draw-panel) } UDGTABLE# #POPS
N $D255 Draw the left side of the panel, then the flipped right side.
  $D255,$04 Point #REGix at the object that holds the details of the sprites of
. the panel, #R$BFDB.
  $D259,$03 Point #REGhl at #R$D27E.
  $D25C,$03 Set the details of the first sprite.
  $D25F,$03 Set the offsets to #N$10 in X and #N$F8 in Y, which is #N$08 down.
  $D262,$02 Set the number of sprites to #N$05.
  $D264,$03 Draw the run of sprites on the left.
  $D267,$03 Draw the second sprite on the left.
  $D26A,$03 Draw the third sprite on the left.
  $D26D,$03 Set the details of the first sprite on the right.
  $D270,$03 Set the offsets to #N$10 in X and #N$08 in Y, which is #N$08 up.
  $D273,$02 Set the number of sprites to #N$05.
  $D275,$03 Draw the run of sprites on the right.
  $D278,$03 Draw the second sprite on the right.
  $D27B,$03 Jump to #R$D24C.

b $D27E Panel Sprites
@ $D27E label=PanelSprites
D $D27E The sprites of the panel. Each entry is the graphic number, the flags,
. the pixel X coordinate and the pixel Y coordinate.
B $D27E,$04,$04 Left side: the run of five.
B $D282,$04,$04 Left side: the second sprite.
B $D286,$04,$04 Left side: the third sprite.
B $D28A,$04,$04 Right side, flipped horizontally: the run of five.
B $D28E,$04,$04 Right side, flipped horizontally: the second sprite.
B $D292,$04,$04 Right side, flipped horizontally: the third sprite.

c $D296 Print Border
@ $D296 label=PrintBorder
D $D296 Draws the border around the playing area, using the sprites in the table
. at #R$D2CF. The four corners are drawn first, then the top and bottom edges,
. which are each made of #N$18 sprites that are eight pixels wide, and the left
. and right edges, which are each made of #N$80 sprites that are one pixel high.
E $D296 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CB8A }
. { #PENTAGRAM$BD59 }
. LIST#
.
. #PUSHS #UDGTABLE { =h After #R$D296 and #R$D56F }
. { #SIM(start=$AF6C,stop=$AFA2,sp=$5BA0,clear=1)
. #SIM(start=$D55F,stop=$0000,sp=$5B80)
. #SIM(start=$D296,stop=$0000,sp=$5B80)
. #SIM(start=$D56F,stop=$0000,sp=$5B80)
. #SCR$02(print-border) } UDGTABLE# #POPS
N $D296 Draw the four corners, then the edges.
  $D296,$04 Point #REGix at the object that holds the details of the sprites of
. the panel, #R$BFDB.
  $D29A,$03 Point #REGhl at #R$D2CF.
  $D29D,$03 Draw the top left corner.
  $D2A0,$03 Draw the top right corner.
  $D2A3,$03 Draw the bottom right corner.
  $D2A6,$03 Draw the bottom left corner.
  $D2A9,$03 Set the details of the top edge.
  $D2AC,$03 Set the offsets to #N$08 in X and #N$00 in Y.
  $D2AF,$02 Set the number of sprites to #N$18.
  $D2B1,$03 Draw the top edge.
  $D2B4,$03 Set the details of the bottom edge.
  $D2B7,$02 Set the number of sprites to #N$18.
  $D2B9,$03 Draw the bottom edge.
  $D2BC,$03 Set the details of the left edge.
  $D2BF,$03 Set the offsets to #N$00 in X and #N$01 in Y.
  $D2C2,$02 Set the number of sprites to #N$80.
  $D2C4,$03 Draw the left edge.
  $D2C7,$03 Set the details of the right edge.
  $D2CA,$02 Set the number of sprites to #N$80.
  $D2CC,$03 Jump to #R$BEE4.

b $D2CF Border Sprites
@ $D2CF label=BorderSprites
D $D2CF The sprites of the border. Each entry is the graphic number, the flags,
. the pixel X coordinate and the pixel Y coordinate.
B $D2CF,$04,$04 Top left corner.
B $D2D3,$04,$04 Top right corner, flipped horizontally.
B $D2D7,$04,$04 Bottom right corner, flipped horizontally and vertically.
B $D2DB,$04,$04 Bottom left corner, flipped vertically.
B $D2DF,$04,$04 Top edge.
B $D2E3,$04,$04 Bottom edge.
B $D2E7,$04,$04 Left edge.
B $D2EB,$04,$04 Right edge.

c $D2EF Set Border Attributes
@ $D2EF label=SetBorderAttributes
D $D2EF Sets the colours of the panel at the bottom of the screen: black for the
. two columns at the sides of the window of the sun and moon, and bright red for
. the window itself.
E $D2EF View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CBE3 }
. LIST#
N $D2EF Colour the sides black and the sun/moon window bright red.
  $D2EF,$01 Set #REGa to the attribute for black on black.
  $D2F0,$03 Point #REGhl at the attributes of the left side.
  $D2F3,$03 Set the width to #N$01 and the height to #N$03.
  $D2F6,$03 Colour the left side.
  $D2F9,$03 Point #REGhl at the attributes of the right side.
  $D2FC,$03 Set the width to #N$01 and the height to #N$03.
  $D2FF,$03 Colour the right side.
  $D302,$02 Set #REGa to the attribute for bright red on black.
  $D304,$03 Point #REGhl at the attributes of the window.
  $D307,$03 Set the width to #N$06 and the height to #N$04.
  $D30A,$03 Jump to #R$C515.

c $D30D Colour Sun Moon
@ $D30D label=ColourSunMoon
D $D30D Sets the colour of the sun or the moon in its window: bright yellow for
. the sun, or bright white for the moon.
N $D30D Colour the window yellow for the sun, or white for the moon.
  $D30D,$03 Fetch the graphic number of the sun/moon from #R$C44D.
  $D310,$02,b$01 Keep bit 0, which is set for the moon.
  $D312,$02 Set #REGa to the attribute for bright yellow on black.
  $D314,$02 Jump to #R$D317 if it is the sun.
  $D316,$01 Change it to bright white on black.
@ $D317 label=ColourSunMoon_Fill
  $D317,$03 Point #REGhl at the attributes of the sun/moon.
  $D31A,$03 Set the width to #N$04 and the height to #N$02.
  $D31D,$03 Jump to #R$C515.

c $D320 Place Player At Door
@ $D320 label=PlacePlayerAtDoor
D $D320 Puts the player in the right place when it has come into a room through
. an arch. The routine that moved the player out of the last room set one of its
. positions to #N$00 or #N($FF), which tells which way the player came. The
. player is put at the opposite edge of the room, just outside the wall, and at
. the height of the arch. If the positions are not one of these, as when the
. player starts the game or starts again after losing a life, nothing is
. changed.
E $D320 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CC01 }
. { #PENTAGRAM$CA82 }
. LIST#
R $D320 IX Address of the player
N $D320 Fetch the wall distances, then see which way the player came.
  $D320,$03 Fetch #R$5BAB.
  $D323,$02 Subtract #N$02.
  $D325,$01 Copy it to #REGl.
N $D326 Fetch the size of the room in Y and take #N$02 off it from #R$5BAC.
  $D326,$03 Fetch #R$5BAC.
  $D329,$02 Subtract #N$02.
  $D32B,$01 Copy it to #REGh.
  $D32C,$03 Fetch the x position of the player.
  $D32F,$03 Jump to #R$D37F if it is zero.
  $D332,$03 Jump to #R$D36F if it is #N$FF.
  $D335,$03 Fetch the y position of the player.
  $D338,$03 Jump to #R$D362 if it is zero.
  $D33B,$03 Jump to #R$D33F if it is #N$FF.
  $D33E,$01 Return.
@ $D33F label=PlacePlayerAtDoor_South
N $D33F The player came from the north.
  $D33F,$02 Set the sum of the coordinates of the arch to look for.
  $D341,$03 Find the arch and set the height of the player to it.
  $D344,$02 Set #REGa to #N$80.
  $D346,$01 Take the size of the room in Y off it.
  $D347,$03 Take the depth of the player off it.
@ $D34A label=PlacePlayerAtDoor_SetY
  $D34A,$03 Set the y position of the player.
@ $D34D label=PlacePlayerAtDoor_Draw
  $D34D,$04 Flag the legs of the player to be drawn.
  $D351,$04 Flag the top half of the player to be drawn.
N $D355 Give the top half the X coordinate of the legs.
  $D355,$03 Fetch the x position of the player.
  $D358,$03 Set the x position of the top half.
N $D35B Give the top half the Y coordinate of the legs.
  $D35B,$03 Fetch the y position of the player.
  $D35E,$03 Set the y position of the top half.
  $D361,$01 Return.
@ $D362 label=PlacePlayerAtDoor_North
N $D362 The player came from the south.
  $D362,$02 Set the sum of the coordinates of the arch to look for.
  $D364,$03 Find the arch and set the height of the player to it.
  $D367,$01 Fetch the size of the room in Y.
  $D368,$02 Add #N$80.
  $D36A,$03 Add the depth of the player.
  $D36D,$02 Jump to #R$D34A.
@ $D36F label=PlacePlayerAtDoor_West
N $D36F The player came from the east.
  $D36F,$02 Set the sum of the coordinates of the arch to look for.
  $D371,$03 Find the arch and set the height of the player to it.
  $D374,$02 Set #REGa to #N$80.
  $D376,$01 Take the size of the room in X off it.
  $D377,$03 Take the width of the player off it.
@ $D37A label=PlacePlayerAtDoor_SetX
  $D37A,$03 Set the x position of the player.
  $D37D,$02 Jump to #R$D34D.
@ $D37F label=PlacePlayerAtDoor_East
N $D37F The player came from the west.
  $D37F,$02 Set the sum of the coordinates of the arch to look for.
  $D381,$03 Find the arch and set the height of the player to it.
  $D384,$01 Fetch the size of the room in X.
  $D385,$02 Add #N$80.
  $D387,$03 Add the width of the player.
  $D38A,$02 Jump to #R$D37A.

c $D38C Find Door Height
@ $D38C label=FindDoorHeight
D $D38C Looks through the first four pairs of objects of the room for an arch (a
. graphic number below #N$06) whose X and Y coordinates add up to a given
. number. When it finds one it gives the player the height of the arch.
E $D38C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CC6D }
. LIST#
R $D38C C Sum of the X and Y coordinates of the arch
R $D38C IX Address of the player
N $D38C Find the matching arch and copy its height to the player.
  $D38C,$04 Point #REGiy at the first object of the room, #R$5C88.
  $D390,$03 Set the distance between pairs of objects to #N$40.
  $D393,$02 Set the number of pairs to #N$04.
@ $D395 label=FindDoorHeight_Next
  $D395,$03 Fetch the graphic number of the object.
  $D398,$02 Compare it with #N$06.
  $D39A,$01 Return if it is not an arch.
  $D39B,$06 Add the Y coordinate to the X coordinate.
  $D3A1,$01 Compare the sum with the one that is wanted.
  $D3A2,$02 Jump to #R$D3A9 if it matches.
  $D3A4,$02 Point #REGiy at the next pair.
  $D3A6,$02 Jump to #R$D395 until all of the pairs have been tried.
  $D3A8,$01 Return.
@ $D3A9 label=FindDoorHeight_Found
  $D3A9,$03 Fetch the Z coordinate of the arch.
  $D3AC,$03 Set the Z coordinate of the legs of the player.
  $D3AF,$02 Add #N$0C to it.
  $D3B1,$03 Set the Z coordinate of the top half of the player.
  $D3B4,$01 Return.

c $D3B5 Find Object Address
@ $D3B5 label=FindObjectAddress
D $D3B5 Finds the address of an object in the objects table from its index.
E $D3B5 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CC96 }
. { #PENTAGRAM$B520 }
. LIST#
R $D3B5 A Index of the object (bit 7 is ignored)
R $D3B5 O:HL Address of the object
N $D3B5 Multiply the index by #N$20 and add it to #R$5C08.
  $D3B5,$01 Stash #REGbc on the stack.
  $D3B6,$02,b$01 Keep bits 0 to 6.
  $D3B8,$01 Copy it to #REGl.
  $D3B9,$02 Set #REGh to #N$00.
  $D3BB,$05 Multiply #REGhl by #N$20.
  $D3C0,$03 Point #REGbc at #R$5C08.
  $D3C3,$01 Add #REGbc to #REGhl.
  $D3C4,$01 Restore #REGbc from the stack.
  $D3C5,$01 Return.

c $D3C6 Retrieve Room
@ $D3C6 label=RetrieveRoom
D $D3C6 Builds the objects of the room that the player is in from the room data.
. It looks for the room in the table of rooms at #R$6251, which has a variable
. length entry for each room. The entry has the number of the room, the length
. of the rest of the entry, the colour and size of the room, the types of
. background object that it has (which end with a #N$FF if there are groups of
. foreground objects after them) and the groups of foreground objects. The
. objects are put in the objects table from #R$5C88, which is the first one after
. the player and the special objects. If the room is not in the table, none are
. made.
E $D3C6 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CCA7 }
. { #PENTAGRAM$C92C }
. LIST#
R $D3C6 IX Address of the player
N $D3C6 Point at the room data, then find the entry for this room.
  $D3C6,$03 Point #REGde at the first object of the room in the objects table,
. #R$5C88.
  $D3C9,$03 Point #REGbc at the end of the table of rooms, #R$6BD1.
  $D3CC,$03 Point #REGhl at #R$6251.
@ $D3CF label=RetrieveRoom_Find
  $D3CF,$05 Test whether the entry is the room of the player.
  $D3D4,$02 Jump to #R$D3F0 if they match.
  $D3D6,$01 Fetch the length of the entry.
  $D3D7,$03 Call #R$D4F2.
  $D3DA,$05 Jump to #R$D3E2 if #REGhl has reached #REGbc.
  $D3DF,$01 Add #REGbc to #REGhl.
  $D3E0,$02 Jump to #R$D3CF.

c $D3E2 Clear Remaining Objects
@ $D3E2 label=ClearRemainingObjects
D $D3E2 Clears the objects in the objects table from a given place to the end of
. the table.
E $D3E2 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CCD0 }
. LIST#
R $D3E2 DE Address of the first object to clear
  $D3E2,$03 Point #REGhl at the end of the objects table, #R$6108.
  $D3E5,$03 Compare it with the address.
  $D3E8,$01 Return if the end has been reached.
  $D3E9,$02 Set the number of bytes to the size of an object.
  $D3EB,$03 Clear the object.
  $D3EE,$02 Jump to #R$D3E2.

c $D3F0 Make Room Objects
@ $D3F0 label=MakeRoomObjects
D $D3F0 Makes the objects of a room from its entry in the table of rooms. The
. colour of the room is the low three bits of the byte after the length, with
. bright added, and the size of the room is the high five bits. The size gives
. the size of the room in X, Y and Z, from the table at #R$6248. Each type of
. background object is the number of an entry in the table at #R$6CE2, which
. holds the address of a list of objects that already have their coordinates.
. Each of these is copied into the objects table, along with the number of the
. room. The background objects end at a #N($FF), or at the end of the entry if
. there are no foreground objects. Each group of foreground objects starts with
. a byte that has the number of a block in bits 3 to 7 and one less than the
. number of times it is used in bits 0 to 2, followed by that many positions. A
. block is a list of objects from the table at #R$6BD1, each with a graphic, a
. size, flags and an offset, but no coordinates. A position has the X coordinate
. in bits 0 to 2, the Y coordinate in bits 3 to 5 and the Z coordinate in bits
. 6 and 7.
E $D3F0 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CCDE }
. { #PENTAGRAM$C92C }
. LIST#
R $D3F0 DE Address of the first object to make
R $D3F0 HL Address of the entry of the room (the byte after the number of the room)
R $D3F0 IX Address of the player
N $D3F0 Set the colour of the room, the size and the floor.
  $D3F0,$01 Fetch the length of the entry.
  $D3F1,$01 Point #REGhl at the colour and size.
  $D3F2,$01 Fetch the colour and size.
  $D3F3,$02,b$01 Keep the colour.
  $D3F5,$02,b$01 Make it bright.
  $D3F7,$03 Store it as the colour of the room at #R$5BAD.
  $D3FA,$01 Stash the address of the object to make on the stack.
  $D3FB,$01 Point #REGde at the colour and size.
  $D3FC,$01 Fetch the colour and size.
  $D3FD,$01 Point #REGde at the types of background object.
  $D3FE,$03 Move the size into the low five bits.
  $D401,$02,b$01 Keep it.
  $D403,$01 Stash it in #REGc.
  $D404,$02 Multiply it by three.
  $D406,$03 Point #REGhl at #R$6248.
  $D409,$03 Add the offset to find the size.
  $D40C,$02 Fetch the size of the room in X, and move on.
  $D40E,$03 Store it at #R$5BAB.
  $D411,$02 Fetch the size of the room in Y, and move on.
  $D413,$03 Store it at #R$5BAC.
  $D416,$01 Fetch the size of the room in Z, which is the floor of the room.
  $D417,$03 Store it at #R$5BAE.
  $D41A,$02 Take two off the length that is left.
  $D41C,$01 Point #REGhl at the types of background object.
  $D41D,$01 Restore the address of the object to make from the stack.
N $D41E Copy each type of background object from #R$6CE2.
@ $D41E label=MakeRoomObjects_Background
  $D41E,$02 Fetch the type of background object, and move on.
  $D420,$04 Jump to #R$D44C if it is the end of the types.
  $D424,$02 Stash the length that is left and the address of the next type on
. the stack.
N $D426 Look up the list of objects of this type.
  $D426,$03 Make the type into an offset.
  $D429,$01 Double it.
  $D42A,$03 Point #REGbc at #R$6CE2.
  $D42D,$01 Add the two.
  $D42E,$04 Fetch the address of the list of objects of the background.
N $D432 Copy one background object into the objects table.
@ $D432 label=MakeRoomObjects_Background_Copy
  $D432,$03 Set the number of bytes to copy to #N$08.
  $D435,$02 Copy the graphic number, the coordinates, the size and the flags of
. the object.
  $D437,$03 Fetch the room number of the player.
  $D43A,$02 Set the room number of the object, and move on.
  $D43C,$02 Set the number of bytes to #N$17.
  $D43E,$03 Clear the rest of the object.
  $D441,$04 Jump to #R$D432 if the list has not ended.
  $D445,$02 Restore the address of the next type and the length that is left
. from the stack.
  $D447,$02 Jump to #R$D41E until all of the types have been used.
  $D449,$03 Jump to #R$D3E2 to clear the rest of the objects table.
N $D44C The foreground objects. #REGiy points at the object that is being made.
@ $D44C label=MakeRoomObjects_Foreground
  $D44C,$01 Take one off the length that is left, for the end of the types.
  $D44D,$02 Stash #REGiy on the stack.
  $D44F,$03 Point #REGiy at the object to make (using the stack).
N $D452 Decode the block type and the number of places.
@ $D452 label=MakeRoomObjects_Block
  $D452,$01 Fetch the block and the count.
  $D453,$02,b$01 Keep the count.
  $D455,$01 Add one to get the number of times.
  $D456,$01 Stash it in #REGc.
  $D457,$02 Fetch the block and the count again, and move on.
  $D459,$01 Take one off the length that is left.
  $D45A,$02 Fetch the position of the first block, and move on.
  $D45C,$01 Stash the address of the next byte on the stack.
  $D45D,$02 Move the block into bits 1 to 5.
  $D45F,$02,b$01 Keep it, to make it twice the number of the block.
  $D461,$03 Point #REGhl at #R$6BD1.
  $D464,$03 Add the offset to find the block.
  $D467,$04 Fetch the address of the list of objects of the block.
@ $D46B label=MakeRoomObjects_Block_Object
  $D46B,$01 Stash the address of the list of objects on the stack.
N $D46C Copy the graphic, the size and the flags from the block.
@ $D46C label=MakeRoomObjects_Object
  $D46C,$02 Fetch the graphic number, and move on.
  $D46E,$03 Set the graphic number of the object.
  $D471,$02 Fetch the width, and move on.
  $D473,$03 Set the width of the object.
  $D476,$02 Fetch the depth, and move on.
  $D478,$03 Set the depth of the object.
  $D47B,$02 Fetch the height, and move on.
  $D47D,$03 Set the height of the object.
  $D480,$02 Fetch the flags, and move on.
  $D482,$03 Set the flags of the object.
  $D485,$03 Fetch the room number of the player.
  $D488,$03 Set the room number of the object.
N $D48B The byte of offsets has the half step in X in bit 0, the half step in Y
. in bit 1, and the offset in Z in bits 2 to 7. The X coordinate is the X
. position times #N($10), plus eight if the half step is set, plus #N$48.
  $D48B,$01 Fetch the offsets.
  $D48C,$03 Move the half step in X into bit 3.
  $D48F,$02,b$01 Keep it.
  $D491,$01 Stash it in #REGe.
  $D492,$01 Fetch the position.
  $D493,$04 Move the X position into bits 4 to 6.
  $D497,$02,b$01 Keep it.
  $D499,$01 Add the half step.
  $D49A,$02 Add #N$48.
  $D49C,$03 Set the X coordinate of the object.
N $D49F The Y coordinate is worked out in the same way from the Y position and
. the half step in Y.
  $D49F,$01 Fetch the offsets.
  $D4A0,$02 Move the half step in Y into bit 3.
  $D4A2,$02,b$01 Keep it.
  $D4A4,$01 Stash it in #REGe.
  $D4A5,$01 Fetch the position.
  $D4A6,$01 Move the Y position into bits 4 to 6.
  $D4A7,$02,b$01 Keep it.
  $D4A9,$01 Add the half step.
  $D4AA,$02 Add #N$48.
  $D4AC,$03 Set the Y coordinate of the object.
N $D4AF The Z coordinate is the Z position times #N($0C), plus the offset in Z,
. plus the floor of the room.
  $D4AF,$01 Fetch the position.
  $D4B0,$02 Move the Z position into the low two bits.
  $D4B2,$02,b$01 Keep it.
  $D4B4,$02 Multiply it by four.
  $D4B6,$01 Stash it in #REGe.
  $D4B7,$01 Multiply it by eight.
  $D4B8,$01 Add the four times to make twelve times.
  $D4B9,$01 Add the offsets, which includes the offset in Z.
  $D4BA,$01 Move on.
  $D4BB,$02,b$01 Clear the two bits of the half steps.
  $D4BD,$01 Stash it in #REGe.
  $D4BE,$03 Fetch the floor of the room from #R$5BAE.
  $D4C1,$01 Add it.
  $D4C2,$03 Set the Z coordinate of the object.
N $D4C5 Clear the rest of the object.
  $D4C5,$01 Stash the count on the stack.
  $D4C6,$03 Set the length of the part of the object that has been made to
. #N$09.
  $D4C9,$02 Point #REGiy at the rest of the object.
  $D4CB,$02 Set the number of bytes to clear to #N$17.
@ $D4CD label=MakeRoomObjects_Clear
  $D4CD,$04 Clear a byte.
  $D4D1,$02 Move on.
  $D4D3,$02 Jump to #R$D4CD until the object is clear.
N $D4D5 Move on to the next object of the block, or the next place, or the next
. group.
  $D4D5,$01 Restore the count from the stack.
  $D4D6,$04 Jump to #R$D46C if the block has not ended.
  $D4DA,$02 Restore the address of the block and the address of the next byte
. from the stack.
  $D4DC,$03 Jump to #R$D4EA if the entry has ended.
  $D4DF,$04 Jump to #R$D452 if the block has been used the number of times.
  $D4E3,$02 Fetch the position for the next use of the block, and move on.
  $D4E5,$01 Stash the address of the next byte on the stack.
  $D4E6,$01 Point #REGhl at the list of objects of the block.
  $D4E7,$01 Put the position in #REGd.
  $D4E8,$02 Jump to #R$D46B.
N $D4EA Finish, and clear any objects that were not made.
@ $D4EA label=MakeRoomObjects_Finish
  $D4EA,$03 Point #REGde at the next object to make (using the stack).
  $D4ED,$02 Restore #REGiy from the stack.
  $D4EF,$03 Jump to #R$D3E2 to clear the rest of the objects table.

c $D4F2 Add A To HL
@ $D4F2 label=AddAToHL
D $D4F2 Adds an unsigned number to #REGhl.
E $D4F2 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE06 }
. { #CYBERUN$9BCF }
. { #NIGHTSHADE$E596 }
. { #PENTAGRAM$B519 }
. { #SABREWULF$9B37 }
. LIST#
R $D4F2 A The number
R $D4F2 HL The address
R $D4F2 O:HL The new address
  $D4F2,$01 Add #REGa to #REGl.
  $D4F3,$01 Copy it to #REGl.
  $D4F4,$01 Fetch #REGh.
  $D4F5,$02 Add #N$00 with carry.
  $D4F7,$01 Copy it to #REGh.
  $D4F8,$01 Return.

c $D4F9 Multiply A By DE
@ $D4F9 label=MultiplyAByDE
D $D4F9 Multiplies #REGa by #REGde.
E $D4F9 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE0D }
. { #ATICATAC$9AAD }
. { #GUNFRIGHT$D03E }
. { #NIGHTSHADE$E0EE }
. { #TRANZAM$6F2F }
. { #UNDERWURLDE$AC68 }
. LIST#
R $D4F9 A The first number
R $D4F9 DE The second number
R $D4F9 O:HL The product
N $D4F9 Shift and add for each of the eight bits.
  $D4F9,$01 Stash #REGbc on the stack.
  $D4FA,$03 Set the product to zero.
  $D4FD,$02 Set the number of bits to #N$08.
@ $D4FF label=MultiplyAByDE_Loop
  $D4FF,$01 Double the product.
  $D500,$01 Move the next bit of the first number into the carry.
  $D501,$02 Jump to #R$D504 if it is not set.
  $D503,$01 Add the second number.
@ $D504 label=MultiplyAByDE_Next
  $D504,$02 Jump to #R$D4FF until all of the bits are done.
  $D506,$01 Restore #REGbc from the stack.
  $D507,$01 Return.

c $D508 Clear Bytes
@ $D508 label=ClearBytes
D $D508 Fills a number of bytes with zero. The entry point at #R$D509 fills them
. with the byte in #REGa.
E $D508 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE1C }
. { #PENTAGRAM$B513 }
. LIST#
R $D508 B Number of bytes
R $D508 DE Address of the first byte
  $D508,$01 Set #REGa to #N$00.
@ $D509 label=FillBytes
  $D509,$01 Write #REGa.
  $D50A,$01 Increment #REGde.
  $D50B,$02 Jump to #R$D509 until all of the bytes are filled.
  $D50D,$01 Return.

c $D50E Pause Game
@ $D50E label=PauseGame
D $D50E Pauses the game if CAPS SHIFT or SPACE is pressed on its own. The game
. waits for the key to be let go of, then for it to be pressed again and let go
. of again. There is a beep for the start and for the end of the pause.
E $D50E View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE22 }
. { #GUNFRIGHT$D206 }
. { #NIGHTSHADE$E32C }
. LIST#
N $D50E Return unless CAPS SHIFT or SPACE is pressed on its own.
  $D50E,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SHIFT / SPACE | Z / SYM | X / M | C / N | V / B }
. TABLE#
  $D513,$03 Return if neither CAPS SHIFT nor SPACE is pressed.
  $D516,$02,b$01 Keep bits 1 to 4.
  $D518,$01 Return if any of them is pressed.
N $D519 Wait for the key to be released.
@ $D519 label=PauseGame_Release
  $D519,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SHIFT / SPACE | Z / SYM | X / M | C / N | V / B }
. TABLE#
  $D51E,$04 Jump to #R$D519 while CAPS SHIFT or SPACE is pressed.
  $D522,$03 Play the sound of the pause.
N $D525 Wait for the key to be pressed.
@ $D525 label=PauseGame_Wait
  $D525,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SHIFT / SPACE | Z / SYM | X / M | C / N | V / B }
. TABLE#
  $D52A,$04 Jump to #R$D525 until CAPS SHIFT or SPACE is pressed.
N $D52E Wait for the key to be released.
@ $D52E label=PauseGame_Finish
  $D52E,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SHIFT / SPACE | Z / SYM | X / M | C / N | V / B }
. TABLE#
  $D533,$04 Jump to #R$D52E while CAPS SHIFT or SPACE is pressed.
  $D537,$03 Jump to #R$B4A8.

c $D53A Fill Memory
@ $D53A label=FillMemory
D $D53A Fills an area of memory with zero. The entry point at #R$D53C fills it
. with the byte in #REGe.
E $D53A View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE56 }
. { #GUNFRIGHT$D6E1 }
. { #MARTIANOIDS$B1A3 }
. { #NIGHTSHADE$E5BA }
. { #PENTAGRAM$CB77 }
. { #UNDERWURLDE$9569 }
. LIST#
R $D53A BC Number of bytes
R $D53A HL Address of the first byte
  $D53A,$02 Set #REGe to #N$00.
@ $D53C label=FillMemory_WithValue
  $D53C,$01 Write #REGe.
  $D53D,$01 Increment #REGhl.
  $D53E,$01 Decrement #REGbc.
  $D53F,$04 Jump to #R$D53C if #REGbc is not zero.
  $D543,$01 Return.

c $D544 Clear Screen Bitmap
@ $D544 label=ClearScreenBitmap
D $D544 Clears the bitmap of the screen.
E $D544 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE60 }
. { #ATICATAC$80B4 }
. { #COOKIE$74D4 }
. { #CYBERUN$9A7E }
. { #GUNFRIGHT$D6DB }
. { #JETPAC$71B8 }
. { #LUNARJETMAN$84AD }
. { #NIGHTSHADE$E5A8 }
. { #PSSST$7439 }
. { #SABREWULF$BB81 }
. { #TRANZAM$7211 }
. LIST#
  $D544,$03 Point #REGhl at the bitmap of the screen, #R$4000.
  $D547,$03 Set the number of bytes to #N$1800.
  $D54A,$02 Jump to #R$D53A.

c $D54C Clear Attributes
@ $D54C label=ClearAttributes
D $D54C Sets the attributes of the screen to bright yellow on black.
  $D54C,$03 Point #REGhl at the attributes of the screen.
  $D54F,$03 Set the number of bytes to #N$0300.
  $D552,$02 Set the byte to the attribute for bright yellow on black.
  $D554,$02 Jump to #R$D53C.

c $D556 Fill Attributes
@ $D556 label=FillAttributes
D $D556 Sets the attributes of the whole screen to one value.
R $D556 A The attribute
  $D556,$03 Point #REGhl at the attributes of the screen.
  $D559,$03 Set the number of bytes to #N$0300.
  $D55C,$01 Set the byte to the attribute.
  $D55D,$02 Jump to #R$D53C.

c $D55F Clear Screen
@ $D55F label=ClearScreen
D $D55F Clears the screen to bright yellow on black, with a black border.
E $D55F View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE73 }
. LIST#
.
. #PUSHS #UDGTABLE { =h Before | =h After #R$D55F }
. { #SIM(start=$AF6C,stop=$AFA2,sp=$5BA0,clear=1)
. #SIM(start=$BD0C,stop=$BD23)
. #SCR$02(clear-screen-before)
. | #SIM(start=$D55F,stop=$0000,sp=$5B80)
. #SCR$02(clear-screen-after) } UDGTABLE# #POPS
  $D55F,$03 Make the border black.
  $D562,$03 Set the attributes of the screen to bright yellow on black.
  $D565,$02 Jump to #R$D544 to clear the bitmap of the screen.

c $D567 Clear Screen Buffer
@ $D567 label=ClearScreenBuffer
D $D567 Clears the buffer that the playing area is drawn in before it is copied
. to the screen.
E $D567 View the equivalent code in;
. #LIST
. { #PENTAGRAM$CB81 }
. LIST#
  $D567,$03 Set the number of bytes to #N$1800.
  $D56A,$03 Point #REGhl at #R$D8F3.
  $D56D,$02 Jump to #R$D53A.

c $D56F Update Screen
@ $D56F label=UpdateScreen
D $D56F Copies the screen buffer to the screen, and clears the buffer as it
. goes. The buffer holds the lines of the screen from the bottom up, #N$20 bytes
. to a line, so the lines are copied from the bottom of the screen to the top.
.
. #PUSHS #UDGTABLE { =h Before | =h After #R$D56F }
. { #SIM(start=$AF6C,stop=$AFA2,sp=$5BA0,clear=1)
. #SIM(start=$BD0C,stop=$BD23)
. #SCR$02(update-screen-before)
. | #SIM(start=$AFAB,stop=$B02F,sp=$5BA0)
. #SIM(start=$B03F,stop=$B06E)
. #SIM(start=$D56F,stop=$0000,sp=$5B80)
. #SCR$02(update-screen-after) } UDGTABLE# #POPS
N $D56F Copy each line from the buffer to the display, then clear the buffer.
  $D56F,$03 Point #REGhl at the screen buffer, #R$D8F3.
  $D572,$03 Point #REGde at the last line of the bitmap of the screen.
  $D575,$03 Set the width to #N$20 bytes and the number of lines to #N$C0.
@ $D578 label=UpdateScreen_Line
  $D578,$01 Stash the counters on the stack.
  $D579,$01 Stash the address of the line on the screen on the stack.
  $D57A,$01 Stash the address of the line in the buffer on the stack.
@ $D57B label=UpdateScreen_Byte
  $D57B,$01 Fetch a byte from the buffer.
  $D57C,$01 Copy it to the screen.
  $D57D,$02 Clear the byte in the buffer.
  $D57F,$01 Move on in the buffer.
  $D580,$01 Move on in the screen.
  $D581,$02 Jump to #R$D57B until the line is copied.
  $D583,$01 Restore the address of the line in the buffer from the stack.
  $D584,$03 Set #REGbc to the length of a line.
  $D587,$01 Move on to the next line in the buffer.
  $D588,$01 Restore the address of the line on the screen from the stack.
  $D589,$01 Go up one line on the screen.
  $D58A,$02 Test whether that has gone into the character row above.
  $D58C,$02,b$01 Keep the bits of the line within the character row.
  $D58E,$02 Jump to #R$D59A if it has not.
  $D590,$03 Go up one character row.
  $D593,$01 Store it.
  $D594,$02 Jump to #R$D59A if that has gone into the third of the screen above.
  $D596,$03 Put the line at the bottom of the character row.
  $D599,$01 Store it.
@ $D59A label=UpdateScreen_Next
  $D59A,$01 Restore the counters from the stack.
  $D59B,$01 Count down the lines.
  $D59C,$02 Jump to #R$D578 until all of the lines are copied.
  $D59E,$01 Return.

c $D59F Draw Changed Objects
@ $D59F label=DrawChangedObjects
D $D59F Updates the playing area for the objects that have changed. First the
. sprites of the objects that moved are wiped out of the screen buffer: for each
. object in the list at #R$CE8B that is flagged to be wiped, the area covered by
. the old and the new position of its sprite is cleared, and the area is kept on
. the stack. Then the objects are drawn in order, the sun or moon is moved, and
. the objects the player is carrying are shown. Last, each of the areas that
. were kept is copied from the buffer to the screen. When the whole room has to
. be drawn there is nothing to wipe, and the screen is updated by the game loop.
E $D59F View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CEAB }
. { #PENTAGRAM$B19E }
. LIST#
  $D59F,$01 Get a zero.
  $D5A0,$03 Set the number of areas wiped to zero at #R$5BA8.
  $D5A3,$02 Stash #REGix on the stack.
  $D5A5,$04 Fetch the flag that says the whole screen is to be drawn from
. #R$5BB7.
  $D5A9,$03 Jump to #R$D653 if it is set.
  $D5AC,$03 Point #REGhl at #R$CE8B.
  $D5AF,$03 Keep it as the place in the list at #R$5BCB.
@ $D5B2 label=DrawChangedObjects_Wipe
  $D5B2,$03 Fetch the place in the list from #R$5BCB.
  $D5B5,$01 Fetch the index of the object.
  $D5B6,$01 Move on.
  $D5B7,$03 Store the place in the list at #R$5BCB.
  $D5BA,$05 Jump to #R$D653 if it is the end of the list.
  $D5BF,$03 Find the address of the object.
  $D5C2,$03 Point #REGix at the object (using the stack).
  $D5C5,$06 Jump to #R$D5B2 if the object is not flagged to be wiped.
  $D5CB,$04 Clear the flag.
N $D5CF The left edge of the area is the lower of the old and the new pixel X
. coordinate. The width is worked out in bytes of the screen from there to the
. higher of the old and the new right edge.
  $D5CF,$06 Take the old pixel X coordinate off the new one.
  $D5D5,$03 Jump to #R$D649 if the new one is lower.
  $D5D8,$03 Take the old pixel X coordinate as the left edge.
@ $D5DB label=DrawChangedObjects_Width
  $D5DB,$03 Fetch the old pixel X coordinate.
  $D5DE,$03 Divide it by eight.
  $D5E1,$02,b$01 Keep the byte of the screen.
  $D5E3,$03 Add the old width in bytes.
  $D5E6,$01 Stash the old right edge in #REGe.
  $D5E7,$03 Fetch the new pixel X coordinate.
  $D5EA,$03 Divide it by eight.
  $D5ED,$02,b$01 Keep the byte of the screen.
  $D5EF,$03 Add the new width in bytes.
  $D5F2,$01 Compare it with the old right edge.
  $D5F3,$02 Jump to #R$D5F6 if the new right edge is lower.
  $D5F5,$01 Take the new right edge instead.
@ $D5F6 label=DrawChangedObjects_Width_FetchLeft
  $D5F6,$01 Fetch the left edge.
  $D5F7,$03 Divide it by eight.
  $D5FA,$02,b$01 Keep the byte of the screen.
  $D5FC,$01 Stash it in #REGb.
  $D5FD,$01 Fetch the right edge.
  $D5FE,$01 Take the left edge off it.
  $D5FF,$01 Stash the width in bytes in #REGh.
N $D600 The bottom edge of the area is the lower of the old and the new pixel Y
. coordinate. The height is worked out from there to the higher of the old and
. the new top edge.
  $D600,$03 Fetch the new pixel Y coordinate.
  $D603,$03 Take the old pixel Y coordinate off it.
  $D606,$02 Jump to #R$D64E if the new one is lower.
  $D608,$03 Take the old pixel Y coordinate as the bottom edge.
@ $D60B label=DrawChangedObjects_Height
  $D60B,$03 Fetch the old pixel Y coordinate.
  $D60E,$03 Add the old height in lines.
  $D611,$01 Stash the old top edge in #REGe.
  $D612,$03 Fetch the new pixel Y coordinate.
  $D615,$03 Add the new height in lines.
  $D618,$01 Compare it with the old top edge.
  $D619,$02 Jump to #R$D61C if the new top edge is higher.
  $D61B,$01 Take the old top edge instead.
@ $D61C label=DrawChangedObjects_Height_TakeBottom
  $D61C,$01 Take the bottom edge off it.
  $D61D,$01 Stash the height in lines in #REGl.
  $D61E,$01 Fetch the bottom edge.
  $D61F,$04 Jump to #R$D5B2 if it is off the screen.
  $D623,$01 Add the height to get the top edge.
  $D624,$02 Take the number of lines on the screen off it.
  $D626,$02 Jump to #R$D62C if the area does not go off the top of the screen.
  $D628,$02 Make the number of lines that are off the screen positive.
  $D62A,$01 Take it off the height.
  $D62B,$01 Stash the new height.
@ $D62C label=DrawChangedObjects_Keep
  $D62C,$03 Find the address of the area on the screen.
  $D62F,$03 Find the address of the area in the buffer.
  $D632,$03 Swap the address of the area in the buffer with the size in #REGhl,
. so that #REGhl is the address and #REGbc is the width and height.
  $D635,$03 Swap the rest.
  $D638,$04 Fetch the number of areas wiped and add one to it from #R$5BA8.
  $D63C,$03 Store it at #R$5BA8.
  $D63F,$01 Stash the width and height on the stack.
  $D640,$01 Stash the address on the screen on the stack.
  $D641,$01 Stash the address in the buffer on the stack.
  $D642,$01 Get a zero to wipe the area with.
  $D643,$03 Wipe the area.
  $D646,$03 Jump to #R$D5B2 for the next object.
@ $D649 label=DrawChangedObjects_Left
  $D649,$03 Take the new pixel X coordinate as the left edge.
  $D64C,$02 Jump to #R$D5DB.
@ $D64E label=DrawChangedObjects_Bottom
  $D64E,$03 Take the new pixel Y coordinate as the bottom edge.
  $D651,$02 Jump to #R$D60B.
@ $D653 label=DrawChangedObjects_Draw
N $D653 Draw the objects, and then copy the areas that were wiped to the screen.
  $D653,$03 Draw the objects in order.
  $D656,$03 Move the sun or moon.
  $D659,$03 Show the objects the player is carrying.
  $D65C,$03 Point #REGhl at #R$5BA8.
  $D65F,$03 Fetch the number of objects drawn from #R$5BBE.
  $D662,$01 Add the number of areas wiped to it.
  $D663,$03 Store it at #R$5BBE.
@ $D666 label=DrawChangedObjects_Copy
  $D666,$03 Point #REGhl at the number of areas wiped, #R$5BA8.
  $D669,$02 Fetch it and test whether it is zero.
  $D66B,$02 Jump to #R$D679 if it is.
  $D66D,$01 Count it down.
  $D66E,$01 Restore the address in the buffer from the stack.
  $D66F,$01 Restore the address on the screen from the stack.
  $D670,$01 Restore the width and height from the stack.
  $D671,$03 Swap the width and the height.
  $D674,$03 Copy the area to the screen.
  $D677,$02 Jump to #R$D666.
@ $D679 label=DrawChangedObjects_Copy_RestoreIX
  $D679,$02 Restore #REGix from the stack.
  $D67B,$01 Return.

c $D67C Copy Block To Screen
@ $D67C label=CopyBlockToScreen
D $D67C Copies an area of the screen buffer to the screen, a line at a time.
E $D67C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CF85 }
. { #PENTAGRAM$B278 }
. LIST#
R $D67C B Number of lines
R $D67C C Number of bytes in a line
R $D67C DE Address of the first line on the screen
R $D67C HL Address of the first line in the buffer
N $D67C Copy one line, then step up a pixel line on the display.
  $D67C,$01 Stash the number of lines and the number of bytes on the stack.
  $D67D,$01 Stash the address on the screen on the stack.
  $D67E,$01 Stash the address in the buffer on the stack.
  $D67F,$02 Clear #REGb.
  $D681,$02 Copy the line.
  $D683,$01 Restore the address in the buffer from the stack.
  $D684,$03 Set #REGde to the length of a line.
  $D687,$01 Move on to the next line in the buffer.
  $D688,$01 Restore the address on the screen from the stack.
  $D689,$01 Go up one line on the screen.
  $D68A,$02 Test whether that has gone into the character row above.
  $D68C,$02,b$01 Keep the bits of the line within the character row.
  $D68E,$02 Jump to #R$D69A if it has not.
  $D690,$03 Go up one character row.
  $D693,$01 Store it.
  $D694,$02 Jump to #R$D69A if that has gone into the third of the screen above.
  $D696,$03 Put the line at the bottom of the character row.
  $D699,$01 Store it.
@ $D69A label=CopyBlockToScreen_Next
  $D69A,$01 Restore the number of lines and the number of bytes from the stack.
  $D69B,$02 Jump to #R$D67C until all of the lines are copied.
  $D69D,$01 Return.

c $D69E Build Lookup Tables
@ $D69E label=BuildLookupTables
D $D69E Builds the two tables that the sprite routines use. The first is the set
. of tables of shifted bytes in pages #N$F2 to #N$FF: for each shift of one to
. seven bits to the right there is a page with the inverse of every byte
. shifted, and a page after it with the inverse of the bits that are pushed out
. into the next byte. The second is the table at #R$F100 of every byte with its
. bits reversed.
E $D69E View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CFA7 }
. { #PENTAGRAM$B29A }
. LIST#
N $D69E Build the shifted-byte tables, then the reversed-byte table.
  $D69E,$02 Start with the byte zero.
@ $D6A0 label=BuildLookupTables_Shift
  $D6A0,$02 Clear the high byte of the shifted value.
  $D6A2,$01 Set the low byte of the shifted value to the byte.
  $D6A3,$02 Point #REGh at the last page of the table.
  $D6A5,$02 Set the number of shifts to #N$07.
@ $D6A7 label=BuildLookupTables_Shift_Step
  $D6A7,$02 Shift the value left one bit.
  $D6A9,$02 Shift the carry into the high byte.
  $D6AB,$01 Fetch the low byte.
  $D6AC,$01 Invert it.
  $D6AD,$01 Store it in the table.
  $D6AE,$01 Go to the page before.
  $D6AF,$01 Fetch the high byte.
  $D6B0,$01 Invert it.
  $D6B1,$01 Store it in the table.
  $D6B2,$01 Go to the page before.
  $D6B3,$02 Jump to #R$D6A7 until all of the shifts are done.
  $D6B5,$01 Go on to the next byte.
  $D6B6,$02 Jump to #R$D6A0 until all of the bytes are done.
  $D6B8,$03 Point #REGhl at #R$F100.
N $D6BB Reverse the bits of every byte into #R$F100.
@ $D6BB label=BuildLookupTables_Reverse
  $D6BB,$01 Take the byte that is to be reversed.
  $D6BC,$02 Set the number of bits to #N$08.
@ $D6BE label=BuildLookupTables_Reverse_Bit
  $D6BE,$02 Shift a bit out of the byte.
  $D6C0,$02 Shift it into the reversed byte.
  $D6C2,$02 Jump to #R$D6BE until all of the bits are done.
  $D6C4,$01 Store the reversed byte in the table.
  $D6C5,$01 Go on to the next byte.
  $D6C6,$02 Jump to #R$D6BB until all of the bytes are done.
  $D6C8,$01 Return.

c $D6C9 Calculate Pixel Coordinates
@ $D6C9 label=CalculatePixelCoordinates
D $D6C9 Works out the pixel position of an object on the screen from its x, y
. and z positions. The pixel x position is x + y - #N$80 and the pixel y
. position (from the bottom of the screen) is half of y - x + #N($80), plus z,
. less #N($68), each with the adjustments of the object added.
E $D6C9 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CFD2 }
. { #PENTAGRAM$B2C5 }
. LIST#
R $D6C9 IX The address of the object
R $D6C9 O:F The carry flag is set if the sprite is on the screen
N $D6C9 Work out the pixel x position.
  $D6C9,$03 Fetch the x position of the object.
  $D6CC,$03 Add the y position.
  $D6CF,$02 Subtract #N$80.
  $D6D1,$03 Add the pixel x adjustment.
  $D6D4,$03 Set the pixel x position.
N $D6D7 Work out the pixel y position.
  $D6D7,$03 Fetch the y position of the object.
  $D6DA,$03 Subtract the x position.
  $D6DD,$02 Add #N$80.
  $D6DF,$02 Halve it.
  $D6E1,$03 Add the z position.
  $D6E4,$02 Subtract #N$68.
  $D6E6,$03 Add the pixel y adjustment.
  $D6E9,$03 Set the pixel y position.
  $D6EC,$02 Compare it with the number of lines of the screen.
  $D6EE,$01 Return.

c $D6EF Get Sprite Address
@ $D6EF label=GetSpriteAddress
D $D6EF Finds the sprite for the graphic number of an object. The data of the
. sprite is flipped, in place, if it is not the same way round as the flags of
. the object say. If there is no sprite for the graphic number, this returns to
. the routine that called the routine that called it.
E $D6EF View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CFFE }
. { #PENTAGRAM$B2EE }
. LIST#
R $D6EF IX The address of the object
R $D6EF O:DE The address of the sprite
N $D6EF Find the address of the sprite.
  $D6EF,$03 Fetch the sprite number.
  $D6F2,$02 Set #REGh to #N$00.
  $D6F4,$01 Double #REGhl.
  $D6F5,$03 Point #REGbc at #R$7112.
  $D6F8,$01 Add #REGbc to #REGhl.
  $D6F9,$03 Fetch the address of the sprite.
N $D6FC Flip it if there is a sprite.
  $D6FC,$02 Fetch the width of the sprite and test it.
  $D6FE,$03 Jump to #R$D865 if there is a sprite, to flip it if needed.
  $D701,$02 Drop the return address.
  $D703,$01 Return.

c $D704 Draw Object
@ $D704 label=DrawObject
D $D704 Draws an object into the screen buffer. An object that has the graphic
. number #N$01 is removed instead, by making it null.
E $D704 Continue on to #R$D718.
E $D704 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D013 }
. { #PENTAGRAM$B3D3 }
. LIST#
R $D704 IX Address of the object
  $D704,$05 Fetch the graphic number and test whether it is the one that removes
. the object.
  $D709,$02 Jump to #R$D710 if it is not.
  $D70B,$04 Make the graphic number null.
  $D70F,$01 Return.
@ $D710 label=DrawNextObject_Draw
  $D710,$04 Flag the object as not to be drawn.
  $D714,$03 Work out the pixel coordinates.
  $D717,$01 Return if the sprite is off the top of the screen.

c $D718 Print Sprite
@ $D718 label=PrintSprite
D $D718 Draws the sprite of an object into #R$D8F3, at the pixel position of the
. object. A sprite has a width byte (the vertical flip in bit 7, the horizontal
. flip in bit 6 and the width in columns in the low bits), a height byte, and
. then the data for each line from the top. Each column of a line is a pair of
. bytes: a mask byte, then a data byte. The mask clears the bits of the
. background and the data sets bits. A sprite that does not start on a byte
. boundary has each pair shifted across two bytes of the buffer, with the tables
. built by #R$D69E. The routine copies the sprite with unrolled code, which it
. enters part of the way along, so that it does as many columns as the sprite
. has. To do this it changes the code, and it uses the stack pointer to read the
. data of the sprite.
E $D718 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D027 }
. LIST#
R $D718 IX The address of the object
N $D718 Find the sprite and choose the draw path.
  $D718,$03 Find the sprite.
  $D71B,$03 Fetch the pixel x position.
  $D71E,$02,b$01 Keep the bits of the position in the byte.
  $D720,$02 Jump to #R$D76F if the sprite is on a byte boundary.
N $D722 Choose the page of the shift table.
  $D722,$01 Double it.
  $D723,$02,b$01 Keep bits 1 to 3.
  $D725,$02,b$01 Make it the page of the table of shifted bytes.
  $D727,$01 Copy it to #REGh.
N $D728 Fetch the width of the sprite, and move on to the height.
  $D728,$01 Fetch the width byte of the sprite.
  $D729,$01 Increment #REGde.
  $D72A,$02,b$01 Keep the width.
  $D72C,$01 Add one for the byte that the shifted sprite spills into.
  $D72D,$01 Copy it to #REGb.
  $D72E,$03 Set the width in bytes of the object.
  $D731,$01 Take one off it to work out the number of pairs, less one.
  $D732,$02,b$01 Keep bits 0 to 2.
  $D734,$04 Multiply it by sixteen, which is the size of the code for a pair.
  $D738,$02 Negate it.
  $D73A,$02 Add #N$50.
N $D73C Change the jump and the step.
@ $D73C label=PrintSprite_Patch
  $D73C,$03 Change the offset of the jump into the unrolled code.
  $D73F,$01 Fetch the width in bytes.
  $D740,$01 Invert it.
  $D741,$02 Add #N$22.
  $D743,$03 Write it to #R$D7FF(#N$D801).
N $D746 Clip the sprite to the top of the screen.
  $D746,$01 Fetch the height of the sprite.
  $D747,$01 Increment #REGde.
  $D748,$03 Set the height in lines of the object.
  $D74B,$03 Add the pixel y position.
  $D74E,$02 Take the number of lines on the screen off it.
  $D750,$02 Jump to #R$D75A if the sprite does not go off the top of the screen.
  $D752,$02 Make the number of lines that are off the screen positive.
  $D754,$03 Take it off the height.
  $D757,$03 Set the height in lines of the object.
N $D75A Draw the rows that are on the screen.
@ $D75A label=PrintSprite_Draw
  $D75A,$03 Fetch the pixel x position.
  $D75D,$03 Fetch the pixel y position.
  $D760,$03 Find the address in the screen buffer.
  $D763,$04 Set #R$5BA9.
  $D767,$03 Point the stack pointer at the data of the sprite.
  $D76A,$03 Fetch the number of lines.
  $D76D,$02 Jump to #R$D7AA.
N $D76F The sprite is aligned, so the bytes do not need to be shifted.
@ $D76F label=PrintSprite_Aligned
  $D76F,$01 Fetch the width byte of the sprite.
  $D770,$01 Increment #REGde.
  $D771,$02,b$01 Keep the width.
  $D773,$03 Set the width in bytes of the object.
  $D776,$01 Copy it to #REGb.
  $D777,$03 Multiply it by eight, which is the size of the code for a column.
  $D77A,$02 Negate it.
  $D77C,$02 Take #N$06 off it to get the offset from the end of the unrolled
. code.
  $D77E,$02 Jump to #R$D73C.

c $D780 Draw Aligned Columns
@ $D780 label=DrawAlignedColumns
D $D780 Unrolled code that draws the columns of a sprite that is on a byte
. boundary. Each column of a line takes a pair of bytes off the stack, which are
. the mask and the data, clears the bits of the mask in the byte of the buffer
. and sets the bits of the data. The code is entered at the column that gives
. the number of columns that the sprite has, and the last column carries on at
. #R$D7FF.
E $D780 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D08F }
. { #GUNFRIGHT$BE5B }
. { #NIGHTSHADE$E49F }
. { #PENTAGRAM$B44F }
. LIST#
N $D780 The first column of a sprite that has five.
  $D780,$01 Take the mask and the data of the column off the stack.
  $D781,$01 Fetch the byte of the buffer.
  $D782,$04 Clear the bits of the mask and set the bits of the data.
  $D786,$02 Store the byte and move on to the next one.
N $D788 The second column of a sprite that has four or five.
  $D788,$01 Take the mask and the data of the column off the stack.
  $D789,$01 Fetch the byte of the buffer.
  $D78A,$04 Clear the bits of the mask and set the bits of the data.
  $D78E,$02 Store the byte and move on to the next one.
N $D790 The third column of a sprite that has three or more.
  $D790,$01 Take the mask and the data of the column off the stack.
  $D791,$01 Fetch the byte of the buffer.
  $D792,$04 Clear the bits of the mask and set the bits of the data.
  $D796,$02 Store the byte and move on to the next one.
N $D798 The fourth column of a sprite that has two or more.
  $D798,$01 Take the mask and the data of the column off the stack.
  $D799,$01 Fetch the byte of the buffer.
  $D79A,$04 Clear the bits of the mask and set the bits of the data.
  $D79E,$02 Store the byte and move on to the next one.
N $D7A0 The last column.
  $D7A0,$01 Take the mask and the data of the column off the stack.
  $D7A1,$01 Fetch the byte of the buffer.
  $D7A2,$04 Clear the bits of the mask and set the bits of the data.
  $D7A6,$01 Store the byte.
  $D7A7,$03 Jump to #R$D7FF.

c $D7AA Draw Lines
@ $D7AA label=DrawLines
D $D7AA Draws the lines of a sprite one after the other. For each line the code
. jumps into the unrolled code, at a place that depends on the width of the
. sprite, and that is set by the jump that is changed by #R$D718. The code for a
. sprite that is not on a byte boundary takes a pair of bytes off the stack,
. which are the mask and the data, shifts them across the two bytes of the
. buffer that they fall into with the table of shifted bytes in #REGh, and keeps
. what is left of the second byte to go with the next pair.
E $D7AA View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D0B9 }
. { #PENTAGRAM$B479 }
. LIST#
  $D7AA,$01 Stash the number of lines left.
  $D7AB,$01 Fetch the first byte of the buffer.
@ $D7AC label=DrawLines_Jump
  $D7AC,$02 Jump into the unrolled code. The jump is changed to go to the right
. place.
N $D7AE The first pair of a sprite that has five.
  $D7AE,$01 Take the mask and the data of the pair off the stack.
  $D7AF,$05 Combine the byte that is carried with the first part of the shifted
. mask and data.
  $D7B4,$02 Store the byte in the buffer and move on to the next one.
  $D7B6,$02 Switch to the table of the part that spills over into the next byte.
  $D7B8,$01 Fetch the next byte of the buffer.
  $D7B9,$04 Combine it with the second part of the shifted mask and data.
  $D7BD,$01 Switch back to the first table.
N $D7BE The second pair of a sprite that has four or five.
  $D7BE,$01 Take the mask and the data of the pair off the stack.
  $D7BF,$05 Combine the byte that is carried with the first part of the shifted
. mask and data.
  $D7C4,$02 Store the byte in the buffer and move on to the next one.
  $D7C6,$02 Switch to the table of the part that spills over into the next byte.
  $D7C8,$01 Fetch the next byte of the buffer.
  $D7C9,$04 Combine it with the second part of the shifted mask and data.
  $D7CD,$01 Switch back to the first table.
N $D7CE The third pair of a sprite that has three or more.
  $D7CE,$01 Take the mask and the data of the pair off the stack.
  $D7CF,$05 Combine the byte that is carried with the first part of the shifted
. mask and data.
  $D7D4,$02 Store the byte in the buffer and move on to the next one.
  $D7D6,$02 Switch to the table of the part that spills over into the next byte.
  $D7D8,$01 Fetch the next byte of the buffer.
  $D7D9,$04 Combine it with the second part of the shifted mask and data.
  $D7DD,$01 Switch back to the first table.
N $D7DE The fourth pair of a sprite that has two or more.
  $D7DE,$01 Take the mask and the data of the pair off the stack.
  $D7DF,$05 Combine the byte that is carried with the first part of the shifted
. mask and data.
  $D7E4,$02 Store the byte in the buffer and move on to the next one.
  $D7E6,$02 Switch to the table of the part that spills over into the next byte.
  $D7E8,$01 Fetch the next byte of the buffer.
  $D7E9,$04 Combine it with the second part of the shifted mask and data.
  $D7ED,$01 Switch back to the first table.
N $D7EE The last pair.
  $D7EE,$01 Take the mask and the data of the pair off the stack.
  $D7EF,$05 Combine the byte that is carried with the first part of the shifted
. mask and data.
  $D7F4,$02 Store the byte in the buffer and move on to the next one.
  $D7F6,$02 Switch to the table of the part that spills over into the next byte.
  $D7F8,$01 Fetch the next byte of the buffer.
  $D7F9,$04 Combine it with the second part of the shifted mask and data.
  $D7FD,$01 Switch back to the first table.
  $D7FE,$01 Store the last byte of the line.
@ $D7FF label=DrawLines_Next
  $D7FF,$01 Fetch the low byte of the address in the buffer.
  $D800,$02 Add the step to the start of the next line, which is changed for the
. width of the sprite.
  $D802,$01 Store it.
  $D803,$01 Fetch the high byte of the address in the buffer.
  $D804,$02 Add the carry, as the step is a single byte.
  $D806,$01 Store it.
  $D807,$01 Restore the number of lines left.
  $D808,$01 Count down the lines.
  $D809,$03 Jump to #R$D7AA until all of the lines are drawn.
  $D80C,$04 Restore the stack pointer from #R$5BA9.
  $D810,$01 Return.

c $D811 Calculate Buffer Address
@ $D811 label=CalculateBufferAddress
D $D811 Finds the address in the screen buffer of the byte that holds a pixel.
. The buffer has the lines of the screen from the bottom, #N$20 bytes to a line.
E $D811 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D120 }
. { #PENTAGRAM$B37F }
. LIST#
R $D811 B Pixel Y coordinate
R $D811 C Pixel X coordinate
R $D811 O:BC Address in the buffer
N $D811 Divide the pixel position by eight and add it to #R$D8F3.
  $D811,$01 Stash #REGhl on the stack.
  $D812,$04 Divide #REGbc by two.
  $D816,$04 Divide #REGbc by four.
  $D81A,$04 Divide #REGbc by eight, to make the number of the byte.
  $D81E,$03 Point #REGhl at #R$D8F3.
  $D821,$01 Add the two.
  $D822,$02 Copy #REGhl to #REGbc.
  $D824,$02 Restore #REGhl from the stack and return.

c $D826 Calculate Screen Address
@ $D826 label=CalculateScreenAddress
D $D826 Finds the address on the screen of the byte that holds a pixel.
E $D826 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D135 }
. { #PENTAGRAM$B394 }
. LIST#
R $D826 B Pixel Y coordinate (from the bottom of the screen)
R $D826 C Pixel X coordinate
R $D826 O:DE Address on the screen
N $D826 Build the display-file address from the pixel X and Y.
  $D826,$04 Fetch the pixel X coordinate and move it right by three bits.
  $D82A,$02,b$01 Keep the byte of the line.
  $D82C,$01 Stash it in #REGe.
  $D82D,$02 Fetch the pixel Y coordinate, inverted to get the line from the top.
  $D82F,$02,b$01 Keep the line within the character row.
  $D831,$01 Stash it in the alternate #REGa.
  $D832,$04 Invert the pixel Y coordinate again and move it left by two bits.
  $D836,$02,b$01 Keep the character row within the third, in the high bits.
  $D838,$01 Add the byte of the line.
  $D839,$01 Store the low byte of the address in #REGe.
  $D83A,$02 Invert the pixel Y coordinate again.
  $D83C,$03 Move the third of the screen into bits 3 and 4.
  $D83F,$02,b$01 Keep it.
  $D841,$01 Stash it in #REGd.
  $D842,$01 Fetch the line within the character row.
  $D843,$01 Add the third of the screen.
  $D844,$02 Add #N($38), to make the high byte of the address.
  $D846,$01 Store the high byte of the address in #REGd.
  $D847,$01 Return.

c $D848 Calculate Attribute Address
@ $D848 label=CalculateAttributeAddress
D $D848 Finds the address in the attributes of the character square that holds a
. pixel.
E $D848 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D157 }
. { #PENTAGRAM$B3B6 }
. LIST#
R $D848 H Pixel Y coordinate (from the bottom of the screen)
R $D848 L Pixel X coordinate
R $D848 O:DE Address of the attribute
N $D848 Convert the pixel position into a character-square address.
  $D848,$01 Stash #REGhl on the stack.
  $D849,$03 Invert the pixel Y coordinate, to get the line from the top.
  $D84C,$08 Move the line into the low bits of the high byte.
  $D854,$02 Move the lowest bit of the line into the low byte.
  $D856,$04 Move the next bit.
  $D85A,$04 Move the next bit, so that #REGhl holds the number of the square.
  $D85E,$03 Point #REGde at the attributes of the screen, less one page.
  $D861,$01 Add the two.
  $D862,$01 Put the address in #REGde.
  $D863,$01 Restore #REGhl from the stack.
  $D864,$01 Return.

c $D865 Flip Sprite
@ $D865 label=FlipSprite
D $D865 Flips the data of a sprite in place, if its flags are not the same as
. the flags of the object that is going to be drawn. The width byte of a sprite
. has the vertical flip in bit 7 and the horizontal flip in bit 6. The sprite is
. flipped vertically by swapping its lines, and horizontally by reversing the
. bits of each byte and the order of the bytes of each line, with the table of
. reversed bytes.
E $D865 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D174 }
. { #NIGHTSHADE$E353 }
. LIST#
R $D865 DE Address of the sprite
R $D865 IX Address of the object
R $D865 O:DE Address of the sprite
N $D865 Flip the sprite vertically if the object's flags say so.
  $D865,$01 Stash the address of the sprite on the stack.
  $D866,$01 Fetch the width of the sprite.
  $D867,$03 Compare the vertical flip with the one of the object.
  $D86A,$02,b$01 Keep it.
  $D86C,$02 Jump to #R$D8A2 if they are the same.
  $D86E,$01 Fetch the width byte of the sprite.
  $D86F,$02,b$01 Toggle the vertical flip.
  $D871,$01 Store the width.
  $D872,$01 Double the width, for the mask and the data.
  $D873,$02,b$01 Keep the doubled width and drop the flags.
  $D875,$01 Stash it in #REGb.
  $D876,$01 Point #REGde at the height of the sprite.
N $D877 Fetch the height and stash it in #REGc.
  $D877,$01 Fetch the height.
  $D878,$01 Copy it to #REGc.
  $D879,$01 Point #REGde at the data.
  $D87A,$01 Stash the address of the data on the stack.
  $D87B,$03 Set #REGde to the number of bytes in a line.
  $D87E,$03 Multiply it by the height.
  $D881,$01 Restore the address of the data from the stack.
  $D882,$01 Add the number of bytes of data.
  $D883,$01 Point #REGde at the end of the data, and #REGhl at the start.
  $D884,$01 Fetch #REGb.
  $D885,$03 Call #R$D4F2.
  $D888,$01 Point #REGde at the last byte of the last line.
  $D889,$01 Point #REGhl at the last byte of the first line.
  $D88A,$02 Halve the height to get the number of pairs of lines.
@ $D88C label=FlipSprite_Lines
  $D88C,$01 Stash the number of bytes in a
. line and the number of pairs on the
. stack.
@ $D88D label=FlipSprite_Bytes
  $D88D,$01 Fetch a byte of the last line.
  $D88E,$01 Fetch a byte of the first line.
  $D88F,$01 Store the byte of the last line in the first line.
  $D890,$01 Fetch the byte of the first line.
  $D891,$01 Store it in the last line.
  $D892,$01 Go back a byte in the first line.
  $D893,$01 Go back a byte in the last line.
  $D894,$02 Jump to #R$D88D until the lines are swapped.
  $D896,$01 Restore the number of bytes in a
. line and the number of pairs from the
. stack.
  $D897,$01 Fetch #REGb.
  $D898,$03 Call #R$D4F2.
  $D89B,$04 Add it again, to go to the end of the next line.
  $D89F,$01 Count down the pairs of lines.
  $D8A0,$02 Jump to #R$D88C until all of the pairs are swapped.
@ $D8A2 label=FlipSprite_Horizontal
N $D8A2 Flip the sprite horizontally if the object's flags say so.
  $D8A2,$02 Fetch the address of the sprite and keep it on the stack.
  $D8A4,$01 Fetch the width of the sprite.
  $D8A5,$03 Compare the horizontal flip with the one of the object.
  $D8A8,$02,b$01 Keep it.
  $D8AA,$02 Jump to #R$D8DC if they are the same.
  $D8AC,$01 Fetch the width byte of the sprite.
  $D8AD,$02,b$01 Toggle the horizontal flip.
  $D8AF,$01 Store the width.
  $D8B0,$02,b$01 Keep the width.
  $D8B2,$01 Copy it to #REGb.
  $D8B3,$01 Copy it to #REGc.
  $D8B4,$01 Point #REGde at the height of the sprite.
  $D8B5,$01 Fetch the height.
  $D8B6,$01 Stash it in the alternate #REGa.
  $D8B7,$01 Point #REGde at the data.
  $D8B8,$01 Point #REGhl at the data.
  $D8B9,$01 Stash the address of the data on the stack.
  $D8BA,$01 Switch to the alternate registers.
  $D8BB,$01 Restore the address of the data from the stack.
  $D8BC,$02 Point #REGbc at the table of reversed bytes.
  $D8BE,$01 Switch back to the main registers.
@ $D8BF label=FlipSprite_Line
N $D8BF Reverse the bits of each pair and store the line back in reverse order.
  $D8BF,$01 Switch to the alternate registers.
  $D8C0,$01 Fetch the mask byte of a pair.
  $D8C1,$01 Find the reversed byte.
  $D8C2,$01 Stash it in #REGe.
  $D8C3,$01 Move on.
  $D8C4,$01 Fetch the data byte of the pair.
  $D8C5,$01 Find the reversed byte.
  $D8C6,$01 Stash it in #REGd.
  $D8C7,$01 Move on.
  $D8C8,$01 Stash the reversed pair on the stack.
  $D8C9,$01 Switch back to the main registers.
  $D8CA,$02 Jump to #R$D8BF until all of the pairs of the line are on the
. stack.
  $D8CC,$01 Set the number of pairs.
@ $D8CD label=FlipSprite_Store
  $D8CD,$01 Restore a reversed pair from the
. stack, which comes off in the opposite
. order.
N $D8CE Store the mask byte, and move on.
  $D8CE,$01 Store the mask byte.
  $D8CF,$01 Move on.
  $D8D0,$01 Store the data byte.
  $D8D1,$01 Move on.
  $D8D2,$02 Jump to #R$D8CD until the line is stored.
  $D8D4,$01 Fetch the number of lines left.
  $D8D5,$01 Count down the lines.
  $D8D6,$02 Jump to #R$D8DC if all of the lines are done.
  $D8D8,$01 Stash the number of lines left.
  $D8D9,$01 Set the number of pairs.
  $D8DA,$02 Jump to #R$D8BF.
@ $D8DC label=FlipSprite_Done
  $D8DC,$01 Restore the address of the sprite from the stack.
  $D8DD,$01 Return.

t $D8DE Messaging: Copyright
@ $D8DE label=CopyrightMessage
D $D8DE The copyright message of the programmers, which is never printed or used
. by the game. The text is stored as plain ASCII, unlike the text that the game
. does print, which is stored as numbers in the font.
  $D8DE,$15 "COPYRIGHT 1984 A.C.G."

g $D8F3 Screen Buffer
@ $D8F3 label=ScreenBuffer
D $D8F3 The buffer that the game draws into before it is copied to the screen by
. #R$D56F. It has a byte for every eight pixels of the screen, with #N$20 bytes
. to a line, and the lines are in the order from the bottom of the screen to the
. top, so the first byte is at the bottom left of the screen and a line above is
. #N$20 bytes further on. The pixels of the buffer are #N$00 for a pixel that is
. not set.
S $D8F3,$17,$17 The start of the bottom line of the screen.
@ $D90A label=ScreenBuffer_SunMoonWindow
S $D90A,$D8,$20 The position of the window of the sun and the moon.
@ $D9E2 label=ScreenBuffer_PanelDays
S $D9E2,$03F5,$20 The position of the days in the panel.
@ $DDD7 label=ScreenBuffer_PanelLives
S $DDD7,$0513,$20 The position of the lives in the panel.
@ $E2EA label=ScreenBuffer_ResultsCharms
S $E2EA,$01FC,$20 The position of the charms on the results screen.
@ $E4E6 label=ScreenBuffer_ResultsPercentage
S $E4E6,$03FC,$20 The position of the percentage on the results screen.
@ $E8E2 label=ScreenBuffer_ResultsDays
S $E8E2,$0811,$20 The position of the days on the results screen, and the rest
. of the bitmap.

i $F0F3

g $F100 Reversed Byte Table
@ $F100 label=ReversedByteTable
D $F100 The table of every byte with its bits in the opposite order, which is
. built by #R$D69E. It is used to flip sprites from left to right.
S $F100,$0100,$20 The reversed byte for each value from #N$00 to #N$FF.

g $F200 Shifted Byte Tables
@ $F200 label=ShiftedByteTables
D $F200 The tables of shifted bytes that are built by #R$D69E and used to draw a
. sprite that does not start on a byte boundary. There are two pages for each
. shift of one to seven bits to the right, with the first page of the pair at
. #N$F0 plus twice the shift, so the table for a shift of one bit starts at
. #R$F200 and the table for a shift of seven bits starts at
. #R$F200(#N$FE00). The first page of a pair has the inverse of the byte
. after it has been shifted to the
. right, and the second has the inverse of the bits that were pushed out of the
. byte, which go into the next byte of the line.
S $F200,$0E00,$0200 Two pages for each of the seven shifts, from one bit to
. seven.
