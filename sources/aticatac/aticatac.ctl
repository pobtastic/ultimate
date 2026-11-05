; Copyright Ashby Computers & Graphics Ltd 1983, Rare Ltd, 2026 ArcadeGeek LTD.
> $4000 @org=$4000
> $4000 @start=$5B80
> $4000 @rom
> $4000 @expand=#DEF(#POKE()(anchor,text) #LINK(Pokes#$anchor)($text))
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))
b $4000 Loading screen
@ $4000 label=Loading
D $4000 #UDGTABLE { =h Atic Atac Loading Screen } { #SCR$02(loading) } UDGTABLE#
. #HTML(<div hidden>)
. #CHICKENSTRIP(/images/scr/chicken-strip)
. #HTML(</div>)
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

c $5B80 Decryption Routine
@ $5B80 label=GameEntry
D $5B80 Runs "RRD" on each of the #N($7C00,$04,$04) bytes that start at
. #N$5FFF, which decrypts the game, and then jumps to #R$6000.
E $5B80 View the equivalent code in #LUNARJETMAN$5B80.
E $5B80 Earlier Ultimate games use a much simpler mechanism;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #PSSST$5B80 }
. { #TRANZAM$5B80 }
. LIST#
N $5B80 Set up the address of the first byte to decrypt and the counters.
  $5B80,$03 #REGhl=#N$5FFF (the address of the first byte to decrypt).
  $5B83,$03 #REGbc=#N($007C,$04,$04) (#REGb=#N$00 so the inner loop runs #N$0100
. times, and #REGc counts the #N$7C outer passes).
  $5B86,$01 #REGa=#N$00 (and reset the flags).
N $5B87 Rotate the nibbles of each byte, chaining the low nibble of one byte
. into the high nibble of the next.
@ $5B87 label=Decryption_Loop
  $5B87,$02 RRD operation on *#REGhl.
  $5B89,$01 Move #REGhl on to the next byte to decrypt.
  $5B8A,$02 Decrease the byte counter (#REGb) by one and loop back to #R$5B87
. until all #N$0100 bytes have been done.
  $5B8C,$03 Decrease the pass counter (#REGc) by one and loop back to #R$5B87
. until all #N$7C passes have been done.
  $5B8F,$03 Jump to #R$6000 to run the security check.

i $5B92

g $5E00 Game Options
@ $5E00 label=GameOptions
D $5E00 #TABLE(default,centre,centre,centre,centre)
. { =h Byte | =h Binary | =h Character | =h Option }
. { #N$00 | #EVAL($00, $02, $08) | Knight | Keyboard }
. { #N$02 | #EVAL($02, $02, $08) | Knight | Kempston Joystick }
. { #N$04 | #EVAL($04, $02, $08) | Knight | Cursor Joystick }
. { #N$08 | #EVAL($08, $02, $08) | Wizard | Keyboard }
. { #N$0A | #EVAL($0A, $02, $08) | Wizard | Kempston Joystick }
. { #N$0C | #EVAL($0C, $02, $08) | Wizard | Cursor Joystick }
. { #N$10 | #EVAL($10, $02, $08) | Serf | Keyboard }
. { #N$12 | #EVAL($12, $02, $08) | Serf | Kempston Joystick }
. { #N$14 | #EVAL($14, $02, $08) | Serf | Cursor Joystick }
. TABLE#
E $5E00 View the equivalent code in;
. #LIST
. { #JETPAC$5CF3 }
. { #PSSST$5E03 }
. { #UNDERWURLDE$8ED5 }
. LIST#
B $5E00,$01

g $5E01 Font Pointer
@ $5E01 label=FontPointer
D $5E01 Holds a pointer to the currently used font data.
W $5E01,$02

g $5E03 Last Frame
@ $5E03 label=LastFrame
D $5E03 The low byte of FRAMES as it was when #R$7EB2 last ran. The main loop
. compares it with FRAMES to find out whether a new frame has started.
B $5E03,$01

g $5E04 In Handlers
@ $5E04 label=InHandlers
D $5E04 Set to #N$01 while #R$7EB2 runs the handlers of the fixed entities, and
. set back to #N$00 when it has finished. Nothing in the game reads it.
B $5E04,$01

g $5E05 Random Seed
@ $5E05 label=RandomSeed
D $5E05 A random number seed. At the end of every pass through #R$7E23 the value
. of FRAMES and the low byte of the counter at #R$5E12 are added to it. The low
. byte is tested by #R$91C5 to decide whether an open trapdoor closes.
W $5E05,$02

s $5E07 Unused
D $5E07 Nine bytes that the game does not use.
S $5E07,$09

g $5E10 Sprite Width
@ $5E10 label=SpriteWidth
D $5E10 The width in bytes of the sprite that is being drawn or removed, or of
. the item whose attribute cells are being set. It is #N$02 when the sprite
. starts on a multiple of eight pixels across, and #N$03 when it does not, as
. the sprite then covers a third byte once it has been shifted.
B $5E10,$01

g $5E11 Sprite Height
@ $5E11 label=SpriteHeight
D $5E11 The height in pixel rows of the sprite that is being drawn or removed,
. or of the item whose attribute cells are being set (#N$10 for the items that
. can be picked up).
B $5E11,$01

g $5E12 Counter Low
@ $5E12 label=CounterLow
D $5E12 The low byte of a 16-bit counter that is increased by #R$7E23 at the end
. of every pass through the main loop. The handlers use it to make things happen
. on every other pass (bit 0), and to choose the frames of animations.
B $5E12,$01

g $5E13 Counter High
@ $5E13 label=CounterHigh
D $5E13 The high byte of the counter that is held in #R$5E12. #R$9924 tests bit
. 0 of it, and #R$98D2 adds it to FRAMES to choose the room of the cyan key.
B $5E13,$01

g $5E14 Game Flags
@ $5E14 label=GameFlags
D $5E14 Bit 0 is set by #R$7E23 once the entities in the room have been drawn,
. and is reset by #R$9BEA when a new room is going to be drawn. The items in the
. room are only drawn (see #R$91FE) while it is zero. The game does not use any
. of the other bits.
B $5E14,$01

g $5E15 Previous Sprite Id
@ $5E15 label=Previous_Sprite_Id
D $5E15 The sprite ID of the entity that was last stored by #R$9FFB or #R$A00E.
. #R$9E86 uses it to find the old sprite to erase, and #R$8EA0 uses it to put
. the player back after a life has been lost.
B $5E15,$01

g $5E16 Previous X Position
@ $5E16 label=Previous_X_Position
D $5E16 The X position of the entity that was last stored by #R$9FFB or #R$A00E.
B $5E16,$01

g $5E17 Previous Y Position
@ $5E17 label=Previous_Y_Position
D $5E17 The Y position of the entity that was last stored by #R$9FFB or #R$A00E.
B $5E17,$01

g $5E18 Old Sprite Row Count
@ $5E18 label=Old_Sprite_Row_Count
D $5E18 The number of rows of the old sprite that are left to be drawn (erased)
. when the rows that overlap with the new sprite have been done. See #R$9E9B.
B $5E18,$01

g $5E19 New Sprite Row Count
@ $5E19 label=New_Sprite_Row_Count
D $5E19 The number of rows of the new sprite that are left to be drawn when the
. rows that overlap with the old sprite have been done. See #R$9E9B.
B $5E19,$01

g $5E1A Room Attribute
@ $5E1A label=CurrentRoom_Attribute
D $5E1A The attribute of the floor of the current room, which is read from the
. room attribute table by #R$9BEA. It is the attribute that #R$A01A gives to the
. cells that an entity has left behind.
B $5E1A,$01

g $5E1B Room Pointer
@ $5E1B label=CurrentRoom
D $5E1B The address of the next item to look at in the list of items for the
. current room (see #R$757D). #R$7E23 sets it to the start of the list and moves
. it on by two bytes for each item.
W $5E1B,$02

g $5E1D Room Width
@ $5E1D label=CurrentRoom_Width
D $5E1D The width of the floor of the current room, written by #R$9BEA from the
. shape of the room. It is stored just before the height, so that routines can
. read both with one #REGde or #REGhl load.
B $5E1D,$01

g $5E1E Room Height
@ $5E1E label=CurrentRoom_Height
D $5E1E The height of the floor of the current room, written by #R$9BEA from the
. shape of the room.
B $5E1E,$01

g $5E1F Pickup Flags
@ $5E1F label=PickupFlags
D $5E1F Stops a single press of the pick up key from picking up or dropping more
. than one item. Bits 0-1 are set by #R$92F5 when an item is picked up, and bit
. 1 is set by #R$93E3 when the inventory is dropped. While either bit is set the
. key does nothing. Bit 1 is reset by #R$92D8 and #R$9417 when the key is not
. pressed, and bit 0 is reset by #R$940E.
B $5E1F,$01

g $5E20 Pickup Pressed
@ $5E20 label=PickupPressed
D $5E20 Set to #N$02 while the pick up key is pressed, and to #N$00 when it is
. not. It is written by #R$938B.
B $5E20,$01

g $5E21 Lives
@ $5E21 label=PlayerLives
D $5E21 The number of lives that the player has left. It starts at #N$03 (see
. #R$7D9A), and is decreased by #R$8EA0 when a life is lost.
N $5E21 See #POKE(set_current_lives,Set Current Lives).
N $5E21 See #POKE(infinite_lives,Infinite Lives).
B $5E21,$01

g $5E22 Menu Item Attribute
@ $5E22 label=Current_MenuAttribute
D $5E22 The attribute of the line of text that #R$7D8A is printing on the game
. selection screen. #R$7CC1 copies it from the table of attributes at #R$7CEA.
B $5E22,$01

g $5E23 Line Distance
@ $5E23 label=LineDistance
D $5E23 The longer of the two distances of the line that #R$9C79 is drawing (the
. distance across or the distance up or down). One more than this is the number
. of steps that are taken.
B $5E23,$01

g $5E24 Line Flags
@ $5E24 label=LineFlags
D $5E24 The direction of the line that #R$9C79 is drawing. Bit 0 is set if the
. line goes down, and bit 1 is set if it goes right.
B $5E24,$01

g $5E25 Number Creatures
@ $5E25 label=NumCreatures
D $5E25 Number of creatures processed this frame.
B $5E25,$01

g $5E26 Last Creature Room
@ $5E26 label=LastCreatureRoom
D $5E26 The room that the player was in when #R$83EA last started the delay
. before a creature is created.
B $5E26,$01

g $5E27 Creature Delay
@ $5E27 label=CreatureDelay
D $5E27 The number of passes that #R$83EA waits before it starts to create
. creatures in a room. It is set to #N$20 when the player enters a new room, and
. counted down while the player stays in it.
B $5E27,$01

g $5E28 Player Energy
@ $5E28 label=PlayerEnergy
D $5E28 The energy of the player, which is shown as the chicken at the side of
. the screen. It starts at #N$F0 (see #R$9476). It is decreased when the player
. is hurt (see #R$8ED7) and increased by eating food (see #R$8C63). When it
. reaches zero a life is lost.
B $5E28,$01

g $5E29 Chicken Level
@ $5E29 label=ChickenLevel
D $5E29 The energy that was last drawn as the chicken, so that #R$8B8A only
. redraws it when the energy has changed enough to make a difference.
B $5E29,$01

g $5E2A Score
@ $5E2A label=Score_1
D $5E2A The score, which is six decimal digits held as three bytes of BCD. The
. most significant byte is first. #R$A19C adds to it and #R$A1AE prints it.
  $5E2A,$01 The most significant two digits.
@ $5E2B label=Score_2
  $5E2B,$01 The middle two digits.
@ $5E2C label=Score_3
  $5E2C,$01 The least significant two digits.

g $5E2D In Doorway
@ $5E2D label=InDoorway
D $5E2D The number of axes on which the player is outside the floor of the room,
. as counted by #R$957D. It is zero when the player is not in a doorway.
B $5E2D,$01

g $5E2E Door Timer
@ $5E2E label=DoorTimer
D $5E2E The time left before the doors that open and close (see #R$915F and
. #R$917D) change. It is counted down every other pass, and set to #N$5E when
. they change.
B $5E2E,$01

g $5E2F Walk Counter
@ $5E2F label=WalkCounter
D $5E2F Counts the footsteps of the player. #R$A3C7 increases it on every call
. and uses it to alternate the sound.
B $5E2F,$01

g $5E30 Inventory 1
@ $5E30 label=Inventory_Slot1
D $5E30 The slot of the inventory for the item that has been carried for the
. shortest time. A slot is the address of the entity of the item (two bytes, low
. byte first, or #N$0000 if the slot is empty), then the sprite ID and the
. attribute of the item.
W $5E30,$02
@ $5E32 label=Inventory_Slot1_Sprite_Id
B $5E32,$01 The sprite ID of the item.
B $5E33,$01 The attribute of the item.

g $5E34 Inventory 2
@ $5E34 label=Inventory_Slot2
D $5E34 The slot of the inventory for the item that has been carried for the
. second shortest time. A slot is the address of the entity of the item (two
. bytes, low byte first, or #N$0000 if the slot is empty), then the sprite ID
. and the attribute of the item.
W $5E34,$02
B $5E36,$01 The sprite ID of the item.
@ $5E37 label=Inventory_Slot2_Attribute
B $5E37,$01 The attribute of the item.

g $5E38 Inventory 3
@ $5E38 label=Inventory_Slot3
D $5E38 The slot of the inventory for the item that has been carried for the
. longest time. A slot is the address of the entity of the item (two bytes, low
. byte first, or #N$0000 if the slot is empty), then the sprite ID and the
. attribute of the item.
W $5E38,$02
B $5E3A,$01 The sprite ID of the item.
@ $5E3B label=Inventory_Slot3_Attribute
B $5E3B,$01 The attribute of the item.

g $5E3C Flash Timer
@ $5E3C label=FlashTimer
D $5E3C The time left before the player starts to appear at the start of a life.
. #R$9443 sets it to #N$68, and #R$8C8C counts it down (see #R$8CB7) while the
. score flashes.
B $5E3C,$01

g $5E3D Clock Hours
@ $5E3D label=ClockHours
D $5E3D The hours of the clock that is shown at the top of the screen, as BCD.
. See #R$95DA.
B $5E3D,$01

g $5E3E Clock Minutes
@ $5E3E label=ClockMinutes
D $5E3E The minutes of the clock that is shown at the top of the screen, as BCD.
. See #R$95DA.
B $5E3E,$01

g $5E3F Clock Seconds
@ $5E3F label=ClockSeconds
D $5E3F The seconds of the clock that is shown at the top of the screen, as BCD.
. See #R$95DA.
B $5E3F,$01

g $5E40 Visited Rooms
@ $5E40 label=VisitedRooms
D $5E40 One bit for each room, set by #R$96AF when the player has been in it.
. There are #N$08 rooms to a byte, so the bit for a room is bit (room MOD #N$08)
. of byte (room / #N$08). #R$96C9 counts the bits.
E $5E40 View the equivalent code in;
. #LIST
. { #SABREWULF$96BF }
. LIST#
B $5E40,$14,$01

g $5E54 Visited Percentage
@ $5E54 label=VisitedPercentage
D $5E54 The percentage of the rooms that the player has visited, as BCD. It is
. calculated by #R$96C9 and shown by #R$9641.
B $5E54,$01

g $5E55 Food Pointer
@ $5E55 label=FoodPointer
D $5E55 The address of the entity that #R$9924 will look at next, to see whether
. it can be made into a food item. It starts at #R$EB58 (see #R$7DA2).
W $5E55,$02

s $5E57 Unused
D $5E57 The rest of the game variables. These bytes are not used.
S $5E57,$01A9

c $6000 Security Check
@ $6000 label=SecurityCheck
D $6000 A short check on the second byte of FRAMES. The game only continues
. into #R$7C19 when it holds the expected value; otherwise the "RET" takes
. its return address from the game variables at #R$5E00.
E $6000 View the equivalent code in;
. #LIST
. { #COOKIE$5F00 }
. { #JETPAC$61E5 }
. { #LUNARJETMAN$8000 }
. { #PSSST$61C6 }
. { #TRANZAM$5F00 }
. LIST#
  $6000,$01 Disable interrupts.
  $6001,$03 Set the stack pointer to #N$5E00.
  $6004,$03 Fetch the second byte of FRAMES.
  $6007,$03 Return if the second byte of FRAMES is not #N$25, which is the value
. that the game expects.
  $600A,$03 Jump to #R$7C19 to initialise the game.

g $600D Player Initialisation Data
@ $600D label=Initialisation_Player
D $600D The entity for the player, which is copied to #R$EA90 when the game is
. reset (see #R$8D61). It is all zero because #R$9443 sets it up from the
. template at #R$9481 at the start of each life. #R$EA90 describes the layout of
. an entity.
B $600D,$08 Not set up yet.

g $6015 Weapon Initialisation Data
@ $6015 label=Initialisation_Weapon
D $6015 The entity for the weapon that the player throws, which is copied to
. #R$EA98. The weapon is a 16-byte record, and the sound entity that follows is
. its second half. The flags are at offset #N$02 and the velocities are at
. offsets #N$06 and #N$07, and the lifetime is at offset #N$0F (see #R$817C).
. The sprite ID is zero while the weapon is not in use.
B $6015,$08 Not in use.

g $601D Sound Initialisation Data
@ $601D label=Initialisation_Sound
D $601D The entity for the sound effects, which is copied to #R$EAA0. The first
. byte is the handler of the sound and the second byte is the count of notes
. left to play (see #R$A3E8). Both are zero when there is no sound. The last
. byte of it is the lifetime of the weapon.
B $601D,$08 No sound to play.

g $6025 A.C.G. Initialisation Data
@ $6025 label=Initialisation_Key_ACG
D $6025 The left, middle and right pieces of the A.C.G. key. The room of each is
. put in at the start of the game by #R$94B6, so the rooms here are not used.
. The three pieces open the A.C.G. door when they are all in the inventory (see
. #R$961B).
B $6025,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
@ $6026 label=Initialisation_Key_ACG_Room
B $6026,$01 Room: #N(#PEEK(#PC)).
B $6027,$01 Flags: #N(#PEEK(#PC)).
B $6028,$01 X position: #N(#PEEK(#PC)).
B $6029,$01 Y position: #N(#PEEK(#PC)).
B $602A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $602B,$02 Not used.
L $6025,$08,$03

g $603D Key Initialisation Data
@ $603D label=Initialisation_Key_Green
D $603D The green, red, cyan and yellow keys. The rooms of the green, red and
. cyan keys are chosen at the start of every game by #R$98D2, so the rooms here
. are not used for them. Each key opens the locked doors of its own colour (see
. #R$9222).
@ $6045 label=Initialisation_Key_Red
@ $604D label=Initialisation_Key_Cyan
@ $6055 label=Initialisation_Key_Yellow
B $603D,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $603E,$01 Room: #N(#PEEK(#PC)).
B $603F,$01 Flags: #N(#PEEK(#PC)).
B $6040,$01 X position: #N(#PEEK(#PC)).
B $6041,$01 Y position: #N(#PEEK(#PC)).
B $6042,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6043,$02 Not used.
L $603D,$08,$04

g $605D Leaf Initialisation Data
@ $605D label=Initialisation_Leaf
D $605D The initial state of the leaf, which can be picked up (see #R$92F5).
B $605D,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $605E,$01 Room: #N(#PEEK(#PC)).
B $605F,$01 Flags: #N(#PEEK(#PC)).
B $6060,$01 X position: #N(#PEEK(#PC)).
B $6061,$01 Y position: #N(#PEEK(#PC)).
B $6062,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6063,$02 Not used.

g $6065 Tombstone 1 Initialisation Data
@ $6065 label=Initialisation_Tombstone_1
D $6065 A tombstone that has not been made yet. #R$95A9 looks for an unused one
. of the four tombstones, to make one where the player has lost their last life.
B $6065,$08 Not in use.

g $606D Tombstone 2 Initialisation Data
@ $606D label=Initialisation_Tombstone_2
D $606D A tombstone that has not been made yet. #R$95A9 looks for an unused one
. of the four tombstones, to make one where the player has lost their last life.
B $606D,$08 Not in use.

g $6075 Tombstone 3 Initialisation Data
@ $6075 label=Initialisation_Tombstone_3
D $6075 A tombstone that has not been made yet. #R$95A9 looks for an unused one
. of the four tombstones, to make one where the player has lost their last life.
B $6075,$08 Not in use.

g $607D Tombstone 4 Initialisation Data
@ $607D label=Initialisation_Tombstone_4
D $607D A tombstone that has not been made yet. #R$95A9 looks for an unused one
. of the four tombstones, to make one where the player has lost their last life.
B $607D,$08 Not in use.

g $6085 Crucifix Initialisation Data
@ $6085 label=Initialisation_Crucifix
D $6085 The initial state of the crucifix, which can be picked up (see #R$92F5).
. While the player holds it, Dracula heads away from them (see #R$8906).
B $6085,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6086,$01 Room: #N(#PEEK(#PC)).
B $6087,$01 Flags: #N(#PEEK(#PC)).
B $6088,$01 X position: #N(#PEEK(#PC)).
B $6089,$01 Y position: #N(#PEEK(#PC)).
B $608A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $608B,$02 Not used.

g $608D Spanner Initialisation Data
@ $608D label=Initialisation_Spanner
D $608D The initial state of the spanner, which can be picked up (see #R$92F5).
. Frankenstein is hit if he touches a player who is holding it (see #R$8988).
B $608D,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $608E,$01 Room: #N(#PEEK(#PC)).
B $608F,$01 Flags: #N(#PEEK(#PC)).
B $6090,$01 X position: #N(#PEEK(#PC)).
B $6091,$01 Y position: #N(#PEEK(#PC)).
B $6092,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6093,$02 Not used.

g $6095 Wine Initialisation Data
@ $6095 label=Initialisation_Wine
D $6095 The initial state of the wine, which can be picked up (see #R$92F5).
B $6095,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6096,$01 Room: #N(#PEEK(#PC)).
B $6097,$01 Flags: #N(#PEEK(#PC)).
B $6098,$01 X position: #N(#PEEK(#PC)).
B $6099,$01 Y position: #N(#PEEK(#PC)).
B $609A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $609B,$02 Not used.

g $609D Coin Initialisation Data
@ $609D label=Initialisation_Coin
D $609D The initial state of the coin, which can be picked up (see #R$92F5).
B $609D,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $609E,$01 Room: #N(#PEEK(#PC)).
B $609F,$01 Flags: #N(#PEEK(#PC)).
B $60A0,$01 X position: #N(#PEEK(#PC)).
B $60A1,$01 Y position: #N(#PEEK(#PC)).
B $60A2,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $60A3,$02 Not used.

g $60A5 Wing Initialisation Data
@ $60A5 label=Initialisation_Wing
D $60A5 The initial state of the wing, which can be picked up (see #R$92F5).
B $60A5,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $60A6,$01 Room: #N(#PEEK(#PC)).
B $60A7,$01 Flags: #N(#PEEK(#PC)).
B $60A8,$01 X position: #N(#PEEK(#PC)).
B $60A9,$01 Y position: #N(#PEEK(#PC)).
B $60AA,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $60AB,$02 Not used.

g $60AD Whip Initialisation Data
@ $60AD label=Initialisation_Whip
D $60AD The initial state of the whip, which can be picked up (see #R$92F5).
B $60AD,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $60AE,$01 Room: #N(#PEEK(#PC)).
B $60AF,$01 Flags: #N(#PEEK(#PC)).
B $60B0,$01 X position: #N(#PEEK(#PC)).
B $60B1,$01 Y position: #N(#PEEK(#PC)).
B $60B2,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $60B3,$02 Not used.

g $60B5 Frog Leg Initialisation Data
@ $60B5 label=Initialisation_Frog_Leg
D $60B5 The initial state of the frog leg, which can be picked up (see #R$92F5).
B $60B5,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $60B6,$01 Room: #N(#PEEK(#PC)).
B $60B7,$01 Flags: #N(#PEEK(#PC)).
B $60B8,$01 X position: #N(#PEEK(#PC)).
B $60B9,$01 Y position: #N(#PEEK(#PC)).
B $60BA,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $60BB,$02 Not used.

g $60BD Gem Initialisation Data
@ $60BD label=Initialisation_Gem
D $60BD The initial state of the gem, which can be picked up (see #R$92F5).
B $60BD,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $60BE,$01 Room: #N(#PEEK(#PC)).
B $60BF,$01 Flags: #N(#PEEK(#PC)).
B $60C0,$01 X position: #N(#PEEK(#PC)).
B $60C1,$01 Y position: #N(#PEEK(#PC)).
B $60C2,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $60C3,$02 Not used.

g $60C5 Moneybag Initialisation Data
@ $60C5 label=Initialisation_Moneybag
D $60C5 The initial state of the moneybag, which can be picked up (see #R$92F5).
B $60C5,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $60C6,$01 Room: #N(#PEEK(#PC)).
B $60C7,$01 Flags: #N(#PEEK(#PC)).
B $60C8,$01 X position: #N(#PEEK(#PC)).
B $60C9,$01 Y position: #N(#PEEK(#PC)).
B $60CA,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $60CB,$02 Not used.

g $60CD Skull Initialisation Data
@ $60CD label=Initialisation_Skull
D $60CD The initial state of the skull, which can be picked up (see #R$92F5).
B $60CD,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $60CE,$01 Room: #N(#PEEK(#PC)).
B $60CF,$01 Flags: #N(#PEEK(#PC)).
B $60D0,$01 X position: #N(#PEEK(#PC)).
B $60D1,$01 Y position: #N(#PEEK(#PC)).
B $60D2,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $60D3,$02 Not used.

g $60D5 Can Initialisation Data
@ $60D5 label=Initialisation_Can
D $60D5 Six of the cans that are in the rooms at the start of the game, which
. restore energy when the player touches them (see #R$8C63).
B $60D5,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $60D6,$01 Room: #N(#PEEK(#PC)).
B $60D7,$01 Flags: #N(#PEEK(#PC)).
B $60D8,$01 X position: #N(#PEEK(#PC)).
B $60D9,$01 Y position: #N(#PEEK(#PC)).
B $60DA,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $60DB,$02 Not used.
L $60D5,$08,$06

g $6105 Candy Initialisation Data
@ $6105 label=Initialisation_Candy
D $6105 Six of the sweets that are in the rooms at the start of the game, which
. restore energy when the player touches them (see #R$8C63).
B $6105,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6106,$01 Room: #N(#PEEK(#PC)).
B $6107,$01 Flags: #N(#PEEK(#PC)).
B $6108,$01 X position: #N(#PEEK(#PC)).
B $6109,$01 Y position: #N(#PEEK(#PC)).
B $610A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $610B,$02 Not used.
L $6105,$08,$06

g $6135 Chop Initialisation Data
@ $6135 label=Initialisation_Chop
D $6135 Six of the chops that are in the rooms at the start of the game, which
. restore energy when the player touches them (see #R$8C63).
B $6135,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6136,$01 Room: #N(#PEEK(#PC)).
B $6137,$01 Flags: #N(#PEEK(#PC)).
B $6138,$01 X position: #N(#PEEK(#PC)).
B $6139,$01 Y position: #N(#PEEK(#PC)).
B $613A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $613B,$02 Not used.
L $6135,$08,$06

g $6165 Lollipop Initialisation Data
@ $6165 label=Initialisation_Lollipop
D $6165 Six of the lollipops that are in the rooms at the start of the game,
. which restore energy when the player touches them (see #R$8C63).
B $6165,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6166,$01 Room: #N(#PEEK(#PC)).
B $6167,$01 Flags: #N(#PEEK(#PC)).
B $6168,$01 X position: #N(#PEEK(#PC)).
B $6169,$01 Y position: #N(#PEEK(#PC)).
B $616A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $616B,$02 Not used.
L $6165,$08,$06

g $6195 Ice Cream Initialisation Data
@ $6195 label=Initialisation_Ice_Cream
D $6195 Six of the ice creams that are in the rooms at the start of the game,
. which restore energy when the player touches them (see #R$8C63).
B $6195,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6196,$01 Room: #N(#PEEK(#PC)).
B $6197,$01 Flags: #N(#PEEK(#PC)).
B $6198,$01 X position: #N(#PEEK(#PC)).
B $6199,$01 Y position: #N(#PEEK(#PC)).
B $619A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $619B,$02 Not used.
L $6195,$08,$06

g $61C5 Dessert Initialisation Data
@ $61C5 label=Initialisation_Dessert
D $61C5 Six of the desserts that are in the rooms at the start of the game,
. which restore energy when the player touches them (see #R$8C63).
B $61C5,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $61C6,$01 Room: #N(#PEEK(#PC)).
B $61C7,$01 Flags: #N(#PEEK(#PC)).
B $61C8,$01 X position: #N(#PEEK(#PC)).
B $61C9,$01 Y position: #N(#PEEK(#PC)).
B $61CA,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $61CB,$02 Not used.
L $61C5,$08,$06

g $61F5 Apple Initialisation Data
@ $61F5 label=Initialisation_Apple
D $61F5 Six of the apples that are in the rooms at the start of the game, which
. restore energy when the player touches them (see #R$8C63).
B $61F5,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $61F6,$01 Room: #N(#PEEK(#PC)).
B $61F7,$01 Flags: #N(#PEEK(#PC)).
B $61F8,$01 X position: #N(#PEEK(#PC)).
B $61F9,$01 Y position: #N(#PEEK(#PC)).
B $61FA,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $61FB,$02 Not used.
L $61F5,$08,$06

g $6225 Bottle Initialisation Data
@ $6225 label=Initialisation_Bottle
D $6225 Six of the bottles that are in the rooms at the start of the game, which
. restore energy when the player touches them (see #R$8C63).
B $6225,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6226,$01 Room: #N(#PEEK(#PC)).
B $6227,$01 Flags: #N(#PEEK(#PC)).
B $6228,$01 X position: #N(#PEEK(#PC)).
B $6229,$01 Y position: #N(#PEEK(#PC)).
B $622A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $622B,$02 Not used.
L $6225,$08,$06

g $6255 Extra Can Initialisation Data
@ $6255 label=Initialisation_Can_Extra
D $6255 Four more of the cans that are in the rooms at the start of the game,
. which restore energy when the player touches them (see #R$8C63).
B $6255,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6256,$01 Room: #N(#PEEK(#PC)).
B $6257,$01 Flags: #N(#PEEK(#PC)).
B $6258,$01 X position: #N(#PEEK(#PC)).
B $6259,$01 Y position: #N(#PEEK(#PC)).
B $625A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $625B,$02 Not used.
L $6255,$08,$04

g $6275 Extra Candy Initialisation Data
@ $6275 label=Initialisation_Candy_Extra
D $6275 Four more of the sweets that are in the rooms at the start of the game,
. which restore energy when the player touches them (see #R$8C63).
B $6275,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6276,$01 Room: #N(#PEEK(#PC)).
B $6277,$01 Flags: #N(#PEEK(#PC)).
B $6278,$01 X position: #N(#PEEK(#PC)).
B $6279,$01 Y position: #N(#PEEK(#PC)).
B $627A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $627B,$02 Not used.
L $6275,$08,$04

g $6295 Extra Chop Initialisation Data
@ $6295 label=Initialisation_Chop_Extra
D $6295 Four more of the chops that are in the rooms at the start of the game,
. which restore energy when the player touches them (see #R$8C63).
B $6295,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6296,$01 Room: #N(#PEEK(#PC)).
B $6297,$01 Flags: #N(#PEEK(#PC)).
B $6298,$01 X position: #N(#PEEK(#PC)).
B $6299,$01 Y position: #N(#PEEK(#PC)).
B $629A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $629B,$02 Not used.
L $6295,$08,$04

g $62B5 Extra Lollipop Initialisation Data
@ $62B5 label=Initialisation_Lollipop_Extra
D $62B5 Four more of the lollipops that are in the rooms at the start of the
. game, which restore energy when the player touches them (see #R$8C63).
B $62B5,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $62B6,$01 Room: #N(#PEEK(#PC)).
B $62B7,$01 Flags: #N(#PEEK(#PC)).
B $62B8,$01 X position: #N(#PEEK(#PC)).
B $62B9,$01 Y position: #N(#PEEK(#PC)).
B $62BA,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $62BB,$02 Not used.
L $62B5,$08,$04

g $62D5 Extra Ice Cream Initialisation Data
@ $62D5 label=Initialisation_Ice_Cream_Extra
D $62D5 Four more of the ice creams that are in the rooms at the start of the
. game, which restore energy when the player touches them (see #R$8C63).
B $62D5,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $62D6,$01 Room: #N(#PEEK(#PC)).
B $62D7,$01 Flags: #N(#PEEK(#PC)).
B $62D8,$01 X position: #N(#PEEK(#PC)).
B $62D9,$01 Y position: #N(#PEEK(#PC)).
B $62DA,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $62DB,$02 Not used.
L $62D5,$08,$04

g $62F5 Extra Dessert Initialisation Data
@ $62F5 label=Initialisation_Dessert_Extra
D $62F5 Four more of the desserts that are in the rooms at the start of the
. game, which restore energy when the player touches them (see #R$8C63).
B $62F5,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $62F6,$01 Room: #N(#PEEK(#PC)).
B $62F7,$01 Flags: #N(#PEEK(#PC)).
B $62F8,$01 X position: #N(#PEEK(#PC)).
B $62F9,$01 Y position: #N(#PEEK(#PC)).
B $62FA,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $62FB,$02 Not used.
L $62F5,$08,$04

g $6315 Extra Apple Initialisation Data
@ $6315 label=Initialisation_Apple_Extra
D $6315 Four more of the apples that are in the rooms at the start of the game,
. which restore energy when the player touches them (see #R$8C63).
B $6315,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6316,$01 Room: #N(#PEEK(#PC)).
B $6317,$01 Flags: #N(#PEEK(#PC)).
B $6318,$01 X position: #N(#PEEK(#PC)).
B $6319,$01 Y position: #N(#PEEK(#PC)).
B $631A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $631B,$02 Not used.
L $6315,$08,$04

g $6335 Extra Bottle Initialisation Data
@ $6335 label=Initialisation_Bottle_Extra
D $6335 Four more of the bottles that are in the rooms at the start of the game,
. which restore energy when the player touches them (see #R$8C63).
B $6335,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6336,$01 Room: #N(#PEEK(#PC)).
B $6337,$01 Flags: #N(#PEEK(#PC)).
B $6338,$01 X position: #N(#PEEK(#PC)).
B $6339,$01 Y position: #N(#PEEK(#PC)).
B $633A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $633B,$02 Not used.
L $6335,$08,$04

g $6355 Mushroom Initialisation Data
@ $6355 label=Initialisation_Mushroom
D $6355 The mushrooms that are in the rooms at the start of the game. The colour
. counter is what #R$988B uses to pick the attribute of the mushroom, so each
. one starts at a different colour. Touching a mushroom takes energy.
B $6355,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $6356,$01 Room: #N(#PEEK(#PC)).
B $6357,$01 Flags: #N(#PEEK(#PC)).
B $6358,$01 X position: #N(#PEEK(#PC)).
B $6359,$01 Y position: #N(#PEEK(#PC)).
B $635A,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $635B,$01 Colour counter: #N(#PEEK(#PC)).
B $635C,$01 Not used.
L $6355,$08,$10

g $63D5 Blank Initialisation Data
@ $63D5 label=Initialisation_Blank
D $63D5 An entity that is always in the same room as the player, because #R$8D77
. copies the room of the player to it. Its handler is #R$93E3, which drops the
. inventory. The room here is not used.
B $63D5,$01 Sprite ID: #N$31 (handled by #R$93E3).
B $63D6,$01 Room: #N(#PEEK(#PC)).
B $63D7,$01 Flags: #N(#PEEK(#PC)).
B $63D8,$01 X position: #N(#PEEK(#PC)).
B $63D9,$01 Y position: #N(#PEEK(#PC)).
B $63DA,$01 Attribute: #N(#PEEK(#PC)).
B $63DB,$02 Not used.

g $63DD Creature Initialisation Data
@ $63DD label=Initialisation_Creature
D $63DD The three 16-byte records that #R$83EA uses for the creatures that it
. makes. They are copied to #R$EE60. Each is zero until it is used, and then it
. is a copy of #R$8B6A, which describes the layout of the record.
B $63DD,$10,$10 Not in use.
L $63DD,$10,$03

g $640D Mummy Initialisation Data
@ $640D label=Initialisation_Mummy
D $640D The initial state of the mummy, which is a 16-byte entity that is
. handled by #R$8862. It is copied to #N$EE90. The room is chosen at the start
. of every game by #R$98D2, to be the room that the red key is in, so the room
. here is not used.
B $640D,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $640E,$01 Room: #N(#PEEK(#PC)).
B $640F,$01 Flags: #N(#PEEK(#PC)).
B $6410,$01 X position: #N(#PEEK(#PC)).
B $6411,$01 Y position: #N(#PEEK(#PC)).
B $6412,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6413,$02 Used by the handler.
B $6415,$01 X velocity: #N(#PEEK(#PC)).
B $6416,$01 Y velocity: #N(#PEEK(#PC)).
B $6417,$01 Used by the handler.
B $6418,$02 Waypoints (see #R$8862): #N(#PEEK(#PC)), #N(#PEEK(#PC + $01)).
B $641A,$03 Used by the handler.

g $641D Dracula Initialisation Data
@ $641D label=Initialisation_Dracula
D $641D The initial state of the dracula, which is a 16-byte entity that is
. handled by #R$8906. It is copied to #N$EEA0.
B $641D,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $641E,$01 Room: #N(#PEEK(#PC)).
B $641F,$01 Flags: #N(#PEEK(#PC)).
B $6420,$01 X position: #N(#PEEK(#PC)).
B $6421,$01 Y position: #N(#PEEK(#PC)).
B $6422,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6423,$02 Used by the handler.
B $6425,$01 X velocity: #N(#PEEK(#PC)).
B $6426,$01 Y velocity: #N(#PEEK(#PC)).
B $6427,$06 Used by the handler.

g $642D Devil Initialisation Data
@ $642D label=Initialisation_Devil
D $642D The initial state of the devil, which is a 16-byte entity that is
. handled by #R$89ED. It is copied to #N$EEB0.
B $642D,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $642E,$01 Room: #N(#PEEK(#PC)).
B $642F,$01 Flags: #N(#PEEK(#PC)).
B $6430,$01 X position: #N(#PEEK(#PC)).
B $6431,$01 Y position: #N(#PEEK(#PC)).
B $6432,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6433,$02 Used by the handler.
B $6435,$01 X velocity: #N(#PEEK(#PC)).
B $6436,$01 Y velocity: #N(#PEEK(#PC)).
B $6437,$06 Used by the handler.

g $643D Frankenstein Initialisation Data
@ $643D label=Initialisation_Frankenstein
D $643D The initial state of the frankenstein, which is a 16-byte entity that is
. handled by #R$8988. It is copied to #N$EEC0.
B $643D,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $643E,$01 Room: #N(#PEEK(#PC)).
B $643F,$01 Flags: #N(#PEEK(#PC)).
B $6440,$01 X position: #N(#PEEK(#PC)).
B $6441,$01 Y position: #N(#PEEK(#PC)).
B $6442,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6443,$02 Used by the handler.
B $6445,$01 X velocity: #N(#PEEK(#PC)).
B $6446,$01 Y velocity: #N(#PEEK(#PC)).
B $6447,$06 Used by the handler.

g $644D Hunchback Initialisation Data
@ $644D label=Initialisation_Hunchback
D $644D The initial state of the hunchback, which is a 16-byte entity that is
. handled by #R$8AFF. It is copied to #N$EED0.
B $644D,$01 Sprite ID: #SPRITENAME(#PEEK(#PC) - $01).
B $644E,$01 Room: #N(#PEEK(#PC)).
B $644F,$01 Flags: #N(#PEEK(#PC)).
B $6450,$01 X position: #N(#PEEK(#PC)).
B $6451,$01 Y position: #N(#PEEK(#PC)).
B $6452,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6453,$02 Used by the handler.
B $6455,$01 X velocity: #N(#PEEK(#PC)).
B $6456,$01 Y velocity: #N(#PEEK(#PC)).
B $6457,$06 Used by the handler.

g $645D Door: #N$07 / #N$00
@ $645D label=Door_07_00
D $645D The doorway between the top wall of room #N$07 and the bottom wall of
. room #N$00. Doors are made of two 8-byte room items, one in each of the rooms
. that they join, which are the two halves of the door (see #R$9286). Each half
. is in the list of items for its room (see #R$757D). The other doors, and the
. other pairs of items that follow, are laid out in the same way.
. #TABLE(default,centre,left)
. { =h Offset | =h Description }
. { #N$00 | Graphic ID (also the index of the handler in #R$802A) }
. { #N$01 | Room ID }
. { #N$02 | Exit offsets }
. { #N$03 | X position }
. { #N$04 | Y position }
. { #N$05 | Attribute (bits 5-7 are the orientation, see #R$9962) }
. { #N$06 | Obstacle X }
. { #N$07 | Obstacle Y }
. TABLE#
.
. The exit offsets are used by #R$9117 to put the player to the right of, and
. above, the position of the half that they come out of: the number of pixels to
. the right is twice the bottom four bits, and the number of pixels above is
. twice the top four bits. #R$900A uses the two obstacle bytes to make a
. rectangle, as long as bit 3 of the attribute is reset. An entity in the
. rectangle is blocked if bit 2 of the attribute is set, and is not blocked if
. it is reset. The left edge is in the top four bits of the X byte, and the top
. edge is in the top four bits of the Y byte (both signed). The width and height
. are in the bottom four bits of each. They are all in units of four pixels.
B $645D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $645E,$01 Room: #N(#PEEK(#PC)).
B $645F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6460,$01 X position: #N(#PEEK(#PC)).
B $6461,$01 Y position: #N(#PEEK(#PC)).
B $6462,$01 Attribute: #N(#PEEK(#PC)).
B $6463,$01 Obstacle X: #N(#PEEK(#PC)).
B $6464,$01 Obstacle Y: #N(#PEEK(#PC)).
L $645D,$08,$02

g $646D Door: #N$19 / #N$00
@ $646D label=Door_19_00
D $646D The doorway between the right wall of room #N$19 and the left wall of
. room #N$00.
B $646D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $646E,$01 Room: #N(#PEEK(#PC)).
B $646F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6470,$01 X position: #N(#PEEK(#PC)).
B $6471,$01 Y position: #N(#PEEK(#PC)).
B $6472,$01 Attribute: #N(#PEEK(#PC)).
B $6473,$01 Obstacle X: #N(#PEEK(#PC)).
B $6474,$01 Obstacle Y: #N(#PEEK(#PC)).
L $646D,$08,$02

g $647D Door: #N$01 / #N$00
@ $647D label=Door_01_00
D $647D The locked door between the bottom wall of room #N$01 and the top wall
. of room #N$00. It is opened by the cyan key (see #R$9222).
B $647D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $647E,$01 Room: #N(#PEEK(#PC)).
B $647F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6480,$01 X position: #N(#PEEK(#PC)).
B $6481,$01 Y position: #N(#PEEK(#PC)).
B $6482,$01 Attribute: #N(#PEEK(#PC)).
B $6483,$01 Obstacle X: #N(#PEEK(#PC)).
B $6484,$01 Obstacle Y: #N(#PEEK(#PC)).
L $647D,$08,$02

g $648D Door: #N$02 / #N$01
@ $648D label=Door_02_01
D $648D The doorway between the right wall of room #N$02 and the left wall of
. room #N$01.
B $648D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $648E,$01 Room: #N(#PEEK(#PC)).
B $648F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6490,$01 X position: #N(#PEEK(#PC)).
B $6491,$01 Y position: #N(#PEEK(#PC)).
B $6492,$01 Attribute: #N(#PEEK(#PC)).
B $6493,$01 Obstacle X: #N(#PEEK(#PC)).
B $6494,$01 Obstacle Y: #N(#PEEK(#PC)).
L $648D,$08,$02

g $649D Door: #N$03 / #N$02
@ $649D label=Door_03_02
D $649D The doorway between the right wall of room #N$03 and the left wall of
. room #N$02.
B $649D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $649E,$01 Room: #N(#PEEK(#PC)).
B $649F,$01 Exit offsets: #N(#PEEK(#PC)).
B $64A0,$01 X position: #N(#PEEK(#PC)).
B $64A1,$01 Y position: #N(#PEEK(#PC)).
B $64A2,$01 Attribute: #N(#PEEK(#PC)).
B $64A3,$01 Obstacle X: #N(#PEEK(#PC)).
B $64A4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $649D,$08,$02

g $64AD Door: #N$04 / #N$03
@ $64AD label=Door_04_03
D $64AD The doorway between the top wall of room #N$04 and the bottom wall of
. room #N$03.
B $64AD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $64AE,$01 Room: #N(#PEEK(#PC)).
B $64AF,$01 Exit offsets: #N(#PEEK(#PC)).
B $64B0,$01 X position: #N(#PEEK(#PC)).
B $64B1,$01 Y position: #N(#PEEK(#PC)).
B $64B2,$01 Attribute: #N(#PEEK(#PC)).
B $64B3,$01 Obstacle X: #N(#PEEK(#PC)).
B $64B4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $64AD,$08,$02

g $64BD Door: #N$19 / #N$04
@ $64BD label=Door_19_04
D $64BD The doorway between the left wall of room #N$19 and the right wall of
. room #N$04.
B $64BD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $64BE,$01 Room: #N(#PEEK(#PC)).
B $64BF,$01 Exit offsets: #N(#PEEK(#PC)).
B $64C0,$01 X position: #N(#PEEK(#PC)).
B $64C1,$01 Y position: #N(#PEEK(#PC)).
B $64C2,$01 Attribute: #N(#PEEK(#PC)).
B $64C3,$01 Obstacle X: #N(#PEEK(#PC)).
B $64C4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $64BD,$08,$02

g $64CD Door: #N$05 / #N$04
@ $64CD label=Door_05_04
D $64CD The doorway between the top wall of room #N$05 and the bottom wall of
. room #N$04.
B $64CD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $64CE,$01 Room: #N(#PEEK(#PC)).
B $64CF,$01 Exit offsets: #N(#PEEK(#PC)).
B $64D0,$01 X position: #N(#PEEK(#PC)).
B $64D1,$01 Y position: #N(#PEEK(#PC)).
B $64D2,$01 Attribute: #N(#PEEK(#PC)).
B $64D3,$01 Obstacle X: #N(#PEEK(#PC)).
B $64D4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $64CD,$08,$02

g $64DD Door: #N$06 / #N$05
@ $64DD label=Door_06_05
D $64DD The doorway between the left wall of room #N$06 and the right wall of
. room #N$05.
B $64DD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $64DE,$01 Room: #N(#PEEK(#PC)).
B $64DF,$01 Exit offsets: #N(#PEEK(#PC)).
B $64E0,$01 X position: #N(#PEEK(#PC)).
B $64E1,$01 Y position: #N(#PEEK(#PC)).
B $64E2,$01 Attribute: #N(#PEEK(#PC)).
B $64E3,$01 Obstacle X: #N(#PEEK(#PC)).
B $64E4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $64DD,$08,$02

g $64ED Door: #N$1A / #N$06
@ $64ED label=Door_1A_06
D $64ED The big doorway in the bottom wall of room #N$1A, which joins the
. doorway in the top wall of room #N$06.
B $64ED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $64EE,$01 Room: #N(#PEEK(#PC)).
B $64EF,$01 Exit offsets: #N(#PEEK(#PC)).
B $64F0,$01 X position: #N(#PEEK(#PC)).
B $64F1,$01 Y position: #N(#PEEK(#PC)).
B $64F2,$01 Attribute: #N(#PEEK(#PC)).
B $64F3,$01 Obstacle X: #N(#PEEK(#PC)).
B $64F4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $64ED,$08,$02

g $64FD Door: #N$08 / #N$06
@ $64FD label=Door_08_06
D $64FD The locked door between the top wall of room #N$08 and the bottom wall
. of room #N$06. It is opened by the green key (see #R$9222).
B $64FD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $64FE,$01 Room: #N(#PEEK(#PC)).
B $64FF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6500,$01 X position: #N(#PEEK(#PC)).
B $6501,$01 Y position: #N(#PEEK(#PC)).
B $6502,$01 Attribute: #N(#PEEK(#PC)).
B $6503,$01 Obstacle X: #N(#PEEK(#PC)).
B $6504,$01 Obstacle Y: #N(#PEEK(#PC)).
L $64FD,$08,$02

g $650D Door: #N$07 / #N$06
@ $650D label=Door_07_06
D $650D The doorway between the left wall of room #N$07 and the right wall of
. room #N$06.
B $650D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $650E,$01 Room: #N(#PEEK(#PC)).
B $650F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6510,$01 X position: #N(#PEEK(#PC)).
B $6511,$01 Y position: #N(#PEEK(#PC)).
B $6512,$01 Attribute: #N(#PEEK(#PC)).
B $6513,$01 Obstacle X: #N(#PEEK(#PC)).
B $6514,$01 Obstacle Y: #N(#PEEK(#PC)).
L $650D,$08,$02

g $651D Door: #N$09 / #N$08
@ $651D label=Door_09_08
D $651D The doorway between the top wall of room #N$09 and the bottom wall of
. room #N$08.
B $651D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $651E,$01 Room: #N(#PEEK(#PC)).
B $651F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6520,$01 X position: #N(#PEEK(#PC)).
B $6521,$01 Y position: #N(#PEEK(#PC)).
B $6522,$01 Attribute: #N(#PEEK(#PC)).
B $6523,$01 Obstacle X: #N(#PEEK(#PC)).
B $6524,$01 Obstacle Y: #N(#PEEK(#PC)).
L $651D,$08,$02

g $652D Door: #N$0A / #N$09
@ $652D label=Door_0A_09
D $652D The doorway between the right wall of room #N$0A and the left wall of
. room #N$09.
B $652D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $652E,$01 Room: #N(#PEEK(#PC)).
B $652F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6530,$01 X position: #N(#PEEK(#PC)).
B $6531,$01 Y position: #N(#PEEK(#PC)).
B $6532,$01 Attribute: #N(#PEEK(#PC)).
B $6533,$01 Obstacle X: #N(#PEEK(#PC)).
B $6534,$01 Obstacle Y: #N(#PEEK(#PC)).
L $652D,$08,$02

g $653D Door: #N$0B / #N$0A
@ $653D label=Door_0B_0A
D $653D The doorway between the right wall of room #N$0B and the left wall of
. room #N$0A.
B $653D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $653E,$01 Room: #N(#PEEK(#PC)).
B $653F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6540,$01 X position: #N(#PEEK(#PC)).
B $6541,$01 Y position: #N(#PEEK(#PC)).
B $6542,$01 Attribute: #N(#PEEK(#PC)).
B $6543,$01 Obstacle X: #N(#PEEK(#PC)).
B $6544,$01 Obstacle Y: #N(#PEEK(#PC)).
L $653D,$08,$02

g $654D Door: #N$0C / #N$0B
@ $654D label=Door_0C_0B
D $654D The doorway between the right wall of room #N$0C and the left wall of
. room #N$0B.
B $654D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $654E,$01 Room: #N(#PEEK(#PC)).
B $654F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6550,$01 X position: #N(#PEEK(#PC)).
B $6551,$01 Y position: #N(#PEEK(#PC)).
B $6552,$01 Attribute: #N(#PEEK(#PC)).
B $6553,$01 Obstacle X: #N(#PEEK(#PC)).
B $6554,$01 Obstacle Y: #N(#PEEK(#PC)).
L $654D,$08,$02

g $655D Door: #N$0D / #N$0C
@ $655D label=Door_0D_0C
D $655D The doorway between the right wall of room #N$0D and the left wall of
. room #N$0C.
B $655D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $655E,$01 Room: #N(#PEEK(#PC)).
B $655F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6560,$01 X position: #N(#PEEK(#PC)).
B $6561,$01 Y position: #N(#PEEK(#PC)).
B $6562,$01 Attribute: #N(#PEEK(#PC)).
B $6563,$01 Obstacle X: #N(#PEEK(#PC)).
B $6564,$01 Obstacle Y: #N(#PEEK(#PC)).
L $655D,$08,$02

g $656D Door: #N$0E / #N$0D
@ $656D label=Door_0E_0D
D $656D The doorway between the bottom wall of room #N$0E and the top wall of
. room #N$0D.
B $656D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $656E,$01 Room: #N(#PEEK(#PC)).
B $656F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6570,$01 X position: #N(#PEEK(#PC)).
B $6571,$01 Y position: #N(#PEEK(#PC)).
B $6572,$01 Attribute: #N(#PEEK(#PC)).
B $6573,$01 Obstacle X: #N(#PEEK(#PC)).
B $6574,$01 Obstacle Y: #N(#PEEK(#PC)).
L $656D,$08,$02

g $657D Door: #N$0F / #N$0E
@ $657D label=Door_0F_0E
D $657D The doorway between the bottom wall of room #N$0F and the top wall of
. room #N$0E.
B $657D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $657E,$01 Room: #N(#PEEK(#PC)).
B $657F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6580,$01 X position: #N(#PEEK(#PC)).
B $6581,$01 Y position: #N(#PEEK(#PC)).
B $6582,$01 Attribute: #N(#PEEK(#PC)).
B $6583,$01 Obstacle X: #N(#PEEK(#PC)).
B $6584,$01 Obstacle Y: #N(#PEEK(#PC)).
L $657D,$08,$02

g $658D Door: #N$10 / #N$0F
@ $658D label=Door_10_0F
D $658D The doorway between the bottom wall of room #N$10 and the top wall of
. room #N$0F.
B $658D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $658E,$01 Room: #N(#PEEK(#PC)).
B $658F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6590,$01 X position: #N(#PEEK(#PC)).
B $6591,$01 Y position: #N(#PEEK(#PC)).
B $6592,$01 Attribute: #N(#PEEK(#PC)).
B $6593,$01 Obstacle X: #N(#PEEK(#PC)).
B $6594,$01 Obstacle Y: #N(#PEEK(#PC)).
L $658D,$08,$02

g $659D Door: #N$11 / #N$10
@ $659D label=Door_11_10
D $659D The locked door between the bottom wall of room #N$11 and the top wall
. of room #N$10. It is opened by the red key (see #R$9222).
B $659D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $659E,$01 Room: #N(#PEEK(#PC)).
B $659F,$01 Exit offsets: #N(#PEEK(#PC)).
B $65A0,$01 X position: #N(#PEEK(#PC)).
B $65A1,$01 Y position: #N(#PEEK(#PC)).
B $65A2,$01 Attribute: #N(#PEEK(#PC)).
B $65A3,$01 Obstacle X: #N(#PEEK(#PC)).
B $65A4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $659D,$08,$02

g $65AD Door: #N$12 / #N$11
@ $65AD label=Door_12_11
D $65AD The doorway between the bottom wall of room #N$12 and the top wall of
. room #N$11.
B $65AD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $65AE,$01 Room: #N(#PEEK(#PC)).
B $65AF,$01 Exit offsets: #N(#PEEK(#PC)).
B $65B0,$01 X position: #N(#PEEK(#PC)).
B $65B1,$01 Y position: #N(#PEEK(#PC)).
B $65B2,$01 Attribute: #N(#PEEK(#PC)).
B $65B3,$01 Obstacle X: #N(#PEEK(#PC)).
B $65B4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $65AD,$08,$02

g $65BD Door: #N$13 / #N$12
@ $65BD label=Door_13_12
D $65BD The doorway between the bottom wall of room #N$13 and the top wall of
. room #N$12.
B $65BD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $65BE,$01 Room: #N(#PEEK(#PC)).
B $65BF,$01 Exit offsets: #N(#PEEK(#PC)).
B $65C0,$01 X position: #N(#PEEK(#PC)).
B $65C1,$01 Y position: #N(#PEEK(#PC)).
B $65C2,$01 Attribute: #N(#PEEK(#PC)).
B $65C3,$01 Obstacle X: #N(#PEEK(#PC)).
B $65C4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $65BD,$08,$02

g $65CD Door: #N$14 / #N$13
@ $65CD label=Door_14_13
D $65CD The doorway between the left wall of room #N$14 and the right wall of
. room #N$13.
B $65CD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $65CE,$01 Room: #N(#PEEK(#PC)).
B $65CF,$01 Exit offsets: #N(#PEEK(#PC)).
B $65D0,$01 X position: #N(#PEEK(#PC)).
B $65D1,$01 Y position: #N(#PEEK(#PC)).
B $65D2,$01 Attribute: #N(#PEEK(#PC)).
B $65D3,$01 Obstacle X: #N(#PEEK(#PC)).
B $65D4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $65CD,$08,$02

g $65DD Door: #N$15 / #N$14
@ $65DD label=Door_15_14
D $65DD The doorway between the left wall of room #N$15 and the right wall of
. room #N$14.
B $65DD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $65DE,$01 Room: #N(#PEEK(#PC)).
B $65DF,$01 Exit offsets: #N(#PEEK(#PC)).
B $65E0,$01 X position: #N(#PEEK(#PC)).
B $65E1,$01 Y position: #N(#PEEK(#PC)).
B $65E2,$01 Attribute: #N(#PEEK(#PC)).
B $65E3,$01 Obstacle X: #N(#PEEK(#PC)).
B $65E4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $65DD,$08,$02

g $65ED Door: #N$16 / #N$15
@ $65ED label=Door_16_15
D $65ED The doorway between the left wall of room #N$16 and the right wall of
. room #N$15.
B $65ED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $65EE,$01 Room: #N(#PEEK(#PC)).
B $65EF,$01 Exit offsets: #N(#PEEK(#PC)).
B $65F0,$01 X position: #N(#PEEK(#PC)).
B $65F1,$01 Y position: #N(#PEEK(#PC)).
B $65F2,$01 Attribute: #N(#PEEK(#PC)).
B $65F3,$01 Obstacle X: #N(#PEEK(#PC)).
B $65F4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $65ED,$08,$02

g $65FD Door: #N$17 / #N$16
@ $65FD label=Door_17_16
D $65FD The locked door between the left wall of room #N$17 and the right wall
. of room #N$16. It is opened by the red key (see #R$9222).
B $65FD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $65FE,$01 Room: #N(#PEEK(#PC)).
B $65FF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6600,$01 X position: #N(#PEEK(#PC)).
B $6601,$01 Y position: #N(#PEEK(#PC)).
B $6602,$01 Attribute: #N(#PEEK(#PC)).
B $6603,$01 Obstacle X: #N(#PEEK(#PC)).
B $6604,$01 Obstacle Y: #N(#PEEK(#PC)).
L $65FD,$08,$02

g $660D Door: #N$18 / #N$17
@ $660D label=Door_18_17
D $660D The locked door between the top wall of room #N$18 and the bottom wall
. of room #N$17. It is opened by the green key (see #R$9222).
B $660D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $660E,$01 Room: #N(#PEEK(#PC)).
B $660F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6610,$01 X position: #N(#PEEK(#PC)).
B $6611,$01 Y position: #N(#PEEK(#PC)).
B $6612,$01 Attribute: #N(#PEEK(#PC)).
B $6613,$01 Obstacle X: #N(#PEEK(#PC)).
B $6614,$01 Obstacle Y: #N(#PEEK(#PC)).
L $660D,$08,$02

g $661D Door: #N$18 / #N$02
@ $661D label=Door_18_02
D $661D The doorway between the bottom wall of room #N$18 and the top wall of
. room #N$02.
B $661D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $661E,$01 Room: #N(#PEEK(#PC)).
B $661F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6620,$01 X position: #N(#PEEK(#PC)).
B $6621,$01 Y position: #N(#PEEK(#PC)).
B $6622,$01 Attribute: #N(#PEEK(#PC)).
B $6623,$01 Obstacle X: #N(#PEEK(#PC)).
B $6624,$01 Obstacle Y: #N(#PEEK(#PC)).
L $661D,$08,$02

g $662D Door: #N$1A / #N$1B
@ $662D label=Door_1A_1B
D $662D The doorway between the top wall of room #N$1A and the bottom wall of
. room #N$1B.
B $662D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $662E,$01 Room: #N(#PEEK(#PC)).
B $662F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6630,$01 X position: #N(#PEEK(#PC)).
B $6631,$01 Y position: #N(#PEEK(#PC)).
B $6632,$01 Attribute: #N(#PEEK(#PC)).
B $6633,$01 Obstacle X: #N(#PEEK(#PC)).
B $6634,$01 Obstacle Y: #N(#PEEK(#PC)).
L $662D,$08,$02

g $663D Door: #N$1B / #N$1C
@ $663D label=Door_1B_1C
D $663D The doorway in the right wall of room #N$1B, which joins the big doorway
. in the left wall of room #N$1C.
B $663D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $663E,$01 Room: #N(#PEEK(#PC)).
B $663F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6640,$01 X position: #N(#PEEK(#PC)).
B $6641,$01 Y position: #N(#PEEK(#PC)).
B $6642,$01 Attribute: #N(#PEEK(#PC)).
B $6643,$01 Obstacle X: #N(#PEEK(#PC)).
B $6644,$01 Obstacle Y: #N(#PEEK(#PC)).
L $663D,$08,$02

g $664D Door: #N$1C / #N$1D
@ $664D label=Door_1C_1D
D $664D The doorway in the right wall of room #N$1C, which joins the cave
. doorway in the left wall of room #N$1D.
B $664D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $664E,$01 Room: #N(#PEEK(#PC)).
B $664F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6650,$01 X position: #N(#PEEK(#PC)).
B $6651,$01 Y position: #N(#PEEK(#PC)).
B $6652,$01 Attribute: #N(#PEEK(#PC)).
B $6653,$01 Obstacle X: #N(#PEEK(#PC)).
B $6654,$01 Obstacle Y: #N(#PEEK(#PC)).
L $664D,$08,$02

g $665D Door: #N$1E / #N$1F
@ $665D label=Door_1E_1F
D $665D The doorway between the top wall of room #N$1E and the bottom wall of
. room #N$1F.
B $665D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $665E,$01 Room: #N(#PEEK(#PC)).
B $665F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6660,$01 X position: #N(#PEEK(#PC)).
B $6661,$01 Y position: #N(#PEEK(#PC)).
B $6662,$01 Attribute: #N(#PEEK(#PC)).
B $6663,$01 Obstacle X: #N(#PEEK(#PC)).
B $6664,$01 Obstacle Y: #N(#PEEK(#PC)).
L $665D,$08,$02

g $666D Door: #N$1F / #N$20
@ $666D label=Door_1F_20
D $666D The doorway between the left wall of room #N$1F and the right wall of
. room #N$20.
B $666D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $666E,$01 Room: #N(#PEEK(#PC)).
B $666F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6670,$01 X position: #N(#PEEK(#PC)).
B $6671,$01 Y position: #N(#PEEK(#PC)).
B $6672,$01 Attribute: #N(#PEEK(#PC)).
B $6673,$01 Obstacle X: #N(#PEEK(#PC)).
B $6674,$01 Obstacle Y: #N(#PEEK(#PC)).
L $666D,$08,$02

g $667D Door: #N$20 / #N$21
@ $667D label=Door_20_21
D $667D The doorway between the left wall of room #N$20 and the right wall of
. room #N$21.
B $667D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $667E,$01 Room: #N(#PEEK(#PC)).
B $667F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6680,$01 X position: #N(#PEEK(#PC)).
B $6681,$01 Y position: #N(#PEEK(#PC)).
B $6682,$01 Attribute: #N(#PEEK(#PC)).
B $6683,$01 Obstacle X: #N(#PEEK(#PC)).
B $6684,$01 Obstacle Y: #N(#PEEK(#PC)).
L $667D,$08,$02

g $668D Door: #N$21 / #N$22
@ $668D label=Door_21_22
D $668D The doorway between the bottom wall of room #N$21 and the top wall of
. room #N$22.
B $668D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $668E,$01 Room: #N(#PEEK(#PC)).
B $668F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6690,$01 X position: #N(#PEEK(#PC)).
B $6691,$01 Y position: #N(#PEEK(#PC)).
B $6692,$01 Attribute: #N(#PEEK(#PC)).
B $6693,$01 Obstacle X: #N(#PEEK(#PC)).
B $6694,$01 Obstacle Y: #N(#PEEK(#PC)).
L $668D,$08,$02

g $669D Door: #N$22 / #N$23
@ $669D label=Door_22_23
D $669D The doorway between the bottom wall of room #N$22 and the top wall of
. room #N$23.
B $669D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $669E,$01 Room: #N(#PEEK(#PC)).
B $669F,$01 Exit offsets: #N(#PEEK(#PC)).
B $66A0,$01 X position: #N(#PEEK(#PC)).
B $66A1,$01 Y position: #N(#PEEK(#PC)).
B $66A2,$01 Attribute: #N(#PEEK(#PC)).
B $66A3,$01 Obstacle X: #N(#PEEK(#PC)).
B $66A4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $669D,$08,$02

g $66AD Door: #N$23 / #N$24
@ $66AD label=Door_23_24
D $66AD The doorway between the right wall of room #N$23 and the left wall of
. room #N$24.
B $66AD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $66AE,$01 Room: #N(#PEEK(#PC)).
B $66AF,$01 Exit offsets: #N(#PEEK(#PC)).
B $66B0,$01 X position: #N(#PEEK(#PC)).
B $66B1,$01 Y position: #N(#PEEK(#PC)).
B $66B2,$01 Attribute: #N(#PEEK(#PC)).
B $66B3,$01 Obstacle X: #N(#PEEK(#PC)).
B $66B4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $66AD,$08,$02

g $66BD Door: #N$24 / #N$25
@ $66BD label=Door_24_25
D $66BD The doorway between the right wall of room #N$24 and the left wall of
. room #N$25.
B $66BD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $66BE,$01 Room: #N(#PEEK(#PC)).
B $66BF,$01 Exit offsets: #N(#PEEK(#PC)).
B $66C0,$01 X position: #N(#PEEK(#PC)).
B $66C1,$01 Y position: #N(#PEEK(#PC)).
B $66C2,$01 Attribute: #N(#PEEK(#PC)).
B $66C3,$01 Obstacle X: #N(#PEEK(#PC)).
B $66C4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $66BD,$08,$02

g $66CD Door: #N$25 / #N$1E
@ $66CD label=Door_25_1E
D $66CD The locked door between the top wall of room #N$25 and the bottom wall
. of room #N$1E. It is opened by the cyan key (see #R$9222).
B $66CD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $66CE,$01 Room: #N(#PEEK(#PC)).
B $66CF,$01 Exit offsets: #N(#PEEK(#PC)).
B $66D0,$01 X position: #N(#PEEK(#PC)).
B $66D1,$01 Y position: #N(#PEEK(#PC)).
B $66D2,$01 Attribute: #N(#PEEK(#PC)).
B $66D3,$01 Obstacle X: #N(#PEEK(#PC)).
B $66D4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $66CD,$08,$02

g $66DD Door: #N$24 / #N$26
@ $66DD label=Door_24_26
D $66DD The doorway in the top wall of room #N$24, which joins the big doorway
. in the bottom wall of room #N$26.
B $66DD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $66DE,$01 Room: #N(#PEEK(#PC)).
B $66DF,$01 Exit offsets: #N(#PEEK(#PC)).
B $66E0,$01 X position: #N(#PEEK(#PC)).
B $66E1,$01 Y position: #N(#PEEK(#PC)).
B $66E2,$01 Attribute: #N(#PEEK(#PC)).
B $66E3,$01 Obstacle X: #N(#PEEK(#PC)).
B $66E4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $66DD,$08,$02

g $66ED Door: #N$02 / #N$26
@ $66ED label=Door_02_26
D $66ED The doorway between the bottom wall of room #N$02 and the top wall of
. room #N$26.
B $66ED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $66EE,$01 Room: #N(#PEEK(#PC)).
B $66EF,$01 Exit offsets: #N(#PEEK(#PC)).
B $66F0,$01 X position: #N(#PEEK(#PC)).
B $66F1,$01 Y position: #N(#PEEK(#PC)).
B $66F2,$01 Attribute: #N(#PEEK(#PC)).
B $66F3,$01 Obstacle X: #N(#PEEK(#PC)).
B $66F4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $66ED,$08,$02

g $66FD Door: #N$27 / #N$28
@ $66FD label=Door_27_28
D $66FD The doorway between the bottom wall of room #N$27 and the top wall of
. room #N$28.
B $66FD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $66FE,$01 Room: #N(#PEEK(#PC)).
B $66FF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6700,$01 X position: #N(#PEEK(#PC)).
B $6701,$01 Y position: #N(#PEEK(#PC)).
B $6702,$01 Attribute: #N(#PEEK(#PC)).
B $6703,$01 Obstacle X: #N(#PEEK(#PC)).
B $6704,$01 Obstacle Y: #N(#PEEK(#PC)).
L $66FD,$08,$02

g $670D Door: #N$28 / #N$29
@ $670D label=Door_28_29
D $670D The locked door between the bottom wall of room #N$28 and the top wall
. of room #N$29. It is opened by the cyan key (see #R$9222).
B $670D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $670E,$01 Room: #N(#PEEK(#PC)).
B $670F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6710,$01 X position: #N(#PEEK(#PC)).
B $6711,$01 Y position: #N(#PEEK(#PC)).
B $6712,$01 Attribute: #N(#PEEK(#PC)).
B $6713,$01 Obstacle X: #N(#PEEK(#PC)).
B $6714,$01 Obstacle Y: #N(#PEEK(#PC)).
L $670D,$08,$02

g $671D Door: #N$29 / #N$2A
@ $671D label=Door_29_2A
D $671D The doorway between the left wall of room #N$29 and the right wall of
. room #N$2A.
B $671D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $671E,$01 Room: #N(#PEEK(#PC)).
B $671F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6720,$01 X position: #N(#PEEK(#PC)).
B $6721,$01 Y position: #N(#PEEK(#PC)).
B $6722,$01 Attribute: #N(#PEEK(#PC)).
B $6723,$01 Obstacle X: #N(#PEEK(#PC)).
B $6724,$01 Obstacle Y: #N(#PEEK(#PC)).
L $671D,$08,$02

g $672D Door: #N$2A / #N$2B
@ $672D label=Door_2A_2B
D $672D The doorway between the left wall of room #N$2A and the right wall of
. room #N$2B.
B $672D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $672E,$01 Room: #N(#PEEK(#PC)).
B $672F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6730,$01 X position: #N(#PEEK(#PC)).
B $6731,$01 Y position: #N(#PEEK(#PC)).
B $6732,$01 Attribute: #N(#PEEK(#PC)).
B $6733,$01 Obstacle X: #N(#PEEK(#PC)).
B $6734,$01 Obstacle Y: #N(#PEEK(#PC)).
L $672D,$08,$02

g $673D Door: #N$2B / #N$2C
@ $673D label=Door_2B_2C
D $673D The doorway between the top wall of room #N$2B and the bottom wall of
. room #N$2C.
B $673D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $673E,$01 Room: #N(#PEEK(#PC)).
B $673F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6740,$01 X position: #N(#PEEK(#PC)).
B $6741,$01 Y position: #N(#PEEK(#PC)).
B $6742,$01 Attribute: #N(#PEEK(#PC)).
B $6743,$01 Obstacle X: #N(#PEEK(#PC)).
B $6744,$01 Obstacle Y: #N(#PEEK(#PC)).
L $673D,$08,$02

g $674D Door: #N$2C / #N$2D
@ $674D label=Door_2C_2D
D $674D The doorway between the top wall of room #N$2C and the bottom wall of
. room #N$2D.
B $674D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $674E,$01 Room: #N(#PEEK(#PC)).
B $674F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6750,$01 X position: #N(#PEEK(#PC)).
B $6751,$01 Y position: #N(#PEEK(#PC)).
B $6752,$01 Attribute: #N(#PEEK(#PC)).
B $6753,$01 Obstacle X: #N(#PEEK(#PC)).
B $6754,$01 Obstacle Y: #N(#PEEK(#PC)).
L $674D,$08,$02

g $675D Door: #N$2D / #N$2E
@ $675D label=Door_2D_2E
D $675D The locked door between the right wall of room #N$2D and the left wall
. of room #N$2E. It is opened by the green key (see #R$9222).
B $675D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $675E,$01 Room: #N(#PEEK(#PC)).
B $675F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6760,$01 X position: #N(#PEEK(#PC)).
B $6761,$01 Y position: #N(#PEEK(#PC)).
B $6762,$01 Attribute: #N(#PEEK(#PC)).
B $6763,$01 Obstacle X: #N(#PEEK(#PC)).
B $6764,$01 Obstacle Y: #N(#PEEK(#PC)).
L $675D,$08,$02

g $676D Door: #N$2E / #N$27
@ $676D label=Door_2E_27
D $676D The doorway between the right wall of room #N$2E and the left wall of
. room #N$27.
B $676D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $676E,$01 Room: #N(#PEEK(#PC)).
B $676F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6770,$01 X position: #N(#PEEK(#PC)).
B $6771,$01 Y position: #N(#PEEK(#PC)).
B $6772,$01 Attribute: #N(#PEEK(#PC)).
B $6773,$01 Obstacle X: #N(#PEEK(#PC)).
B $6774,$01 Obstacle Y: #N(#PEEK(#PC)).
L $676D,$08,$02

g $677D Door: #N$27 / #N$2F
@ $677D label=Door_27_2F
D $677D The doorway in the top wall of room #N$27, which joins the big doorway
. in the bottom wall of room #N$2F.
B $677D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $677E,$01 Room: #N(#PEEK(#PC)).
B $677F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6780,$01 X position: #N(#PEEK(#PC)).
B $6781,$01 Y position: #N(#PEEK(#PC)).
B $6782,$01 Attribute: #N(#PEEK(#PC)).
B $6783,$01 Obstacle X: #N(#PEEK(#PC)).
B $6784,$01 Obstacle Y: #N(#PEEK(#PC)).
L $677D,$08,$02

g $678D Door: #N$20 / #N$2F
@ $678D label=Door_20_2F
D $678D The locked door between the bottom wall of room #N$20 and the top wall
. of room #N$2F. It is opened by the yellow key (see #R$9222).
B $678D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $678E,$01 Room: #N(#PEEK(#PC)).
B $678F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6790,$01 X position: #N(#PEEK(#PC)).
B $6791,$01 Y position: #N(#PEEK(#PC)).
B $6792,$01 Attribute: #N(#PEEK(#PC)).
B $6793,$01 Obstacle X: #N(#PEEK(#PC)).
B $6794,$01 Obstacle Y: #N(#PEEK(#PC)).
L $678D,$08,$02

g $679D Door: #N$30 / #N$31
@ $679D label=Door_30_31
D $679D The cave doorway between the bottom wall of room #N$30 and the top wall
. of room #N$31.
B $679D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $679E,$01 Room: #N(#PEEK(#PC)).
B $679F,$01 Exit offsets: #N(#PEEK(#PC)).
B $67A0,$01 X position: #N(#PEEK(#PC)).
B $67A1,$01 Y position: #N(#PEEK(#PC)).
B $67A2,$01 Attribute: #N(#PEEK(#PC)).
B $67A3,$01 Obstacle X: #N(#PEEK(#PC)).
B $67A4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $679D,$08,$02

g $67AD Door: #N$31 / #N$32
@ $67AD label=Door_31_32
D $67AD The cave doorway between the bottom wall of room #N$31 and the top wall
. of room #N$32.
B $67AD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $67AE,$01 Room: #N(#PEEK(#PC)).
B $67AF,$01 Exit offsets: #N(#PEEK(#PC)).
B $67B0,$01 X position: #N(#PEEK(#PC)).
B $67B1,$01 Y position: #N(#PEEK(#PC)).
B $67B2,$01 Attribute: #N(#PEEK(#PC)).
B $67B3,$01 Obstacle X: #N(#PEEK(#PC)).
B $67B4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $67AD,$08,$02

g $67BD Door: #N$32 / #N$33
@ $67BD label=Door_32_33
D $67BD The cave doorway between the bottom wall of room #N$32 and the top wall
. of room #N$33.
B $67BD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $67BE,$01 Room: #N(#PEEK(#PC)).
B $67BF,$01 Exit offsets: #N(#PEEK(#PC)).
B $67C0,$01 X position: #N(#PEEK(#PC)).
B $67C1,$01 Y position: #N(#PEEK(#PC)).
B $67C2,$01 Attribute: #N(#PEEK(#PC)).
B $67C3,$01 Obstacle X: #N(#PEEK(#PC)).
B $67C4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $67BD,$08,$02

g $67CD Door: #N$33 / #N$34
@ $67CD label=Door_33_34
D $67CD The cave doorway between the bottom wall of room #N$33 and the top wall
. of room #N$34.
B $67CD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $67CE,$01 Room: #N(#PEEK(#PC)).
B $67CF,$01 Exit offsets: #N(#PEEK(#PC)).
B $67D0,$01 X position: #N(#PEEK(#PC)).
B $67D1,$01 Y position: #N(#PEEK(#PC)).
B $67D2,$01 Attribute: #N(#PEEK(#PC)).
B $67D3,$01 Obstacle X: #N(#PEEK(#PC)).
B $67D4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $67CD,$08,$02

g $67DD Door: #N$34 / #N$35
@ $67DD label=Door_34_35
D $67DD The cave doorway between the bottom wall of room #N$34 and the top wall
. of room #N$35.
B $67DD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $67DE,$01 Room: #N(#PEEK(#PC)).
B $67DF,$01 Exit offsets: #N(#PEEK(#PC)).
B $67E0,$01 X position: #N(#PEEK(#PC)).
B $67E1,$01 Y position: #N(#PEEK(#PC)).
B $67E2,$01 Attribute: #N(#PEEK(#PC)).
B $67E3,$01 Obstacle X: #N(#PEEK(#PC)).
B $67E4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $67DD,$08,$02

g $67ED Door: #N$33 / #N$36
@ $67ED label=Door_33_36
D $67ED The cave doorway between the right wall of room #N$33 and the left wall
. of room #N$36.
B $67ED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $67EE,$01 Room: #N(#PEEK(#PC)).
B $67EF,$01 Exit offsets: #N(#PEEK(#PC)).
B $67F0,$01 X position: #N(#PEEK(#PC)).
B $67F1,$01 Y position: #N(#PEEK(#PC)).
B $67F2,$01 Attribute: #N(#PEEK(#PC)).
B $67F3,$01 Obstacle X: #N(#PEEK(#PC)).
B $67F4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $67ED,$08,$02

g $67FD Door: #N$36 / #N$37
@ $67FD label=Door_36_37
D $67FD The cave doorway between the right wall of room #N$36 and the left wall
. of room #N$37.
B $67FD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $67FE,$01 Room: #N(#PEEK(#PC)).
B $67FF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6800,$01 X position: #N(#PEEK(#PC)).
B $6801,$01 Y position: #N(#PEEK(#PC)).
B $6802,$01 Attribute: #N(#PEEK(#PC)).
B $6803,$01 Obstacle X: #N(#PEEK(#PC)).
B $6804,$01 Obstacle Y: #N(#PEEK(#PC)).
L $67FD,$08,$02

g $680D Door: #N$37 / #N$38
@ $680D label=Door_37_38
D $680D The cave doorway between the right wall of room #N$37 and the left wall
. of room #N$38.
B $680D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $680E,$01 Room: #N(#PEEK(#PC)).
B $680F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6810,$01 X position: #N(#PEEK(#PC)).
B $6811,$01 Y position: #N(#PEEK(#PC)).
B $6812,$01 Attribute: #N(#PEEK(#PC)).
B $6813,$01 Obstacle X: #N(#PEEK(#PC)).
B $6814,$01 Obstacle Y: #N(#PEEK(#PC)).
L $680D,$08,$02

g $681D Door: #N$38 / #N$39
@ $681D label=Door_38_39
D $681D The cave doorway between the bottom wall of room #N$38 and the top wall
. of room #N$39.
B $681D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $681E,$01 Room: #N(#PEEK(#PC)).
B $681F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6820,$01 X position: #N(#PEEK(#PC)).
B $6821,$01 Y position: #N(#PEEK(#PC)).
B $6822,$01 Attribute: #N(#PEEK(#PC)).
B $6823,$01 Obstacle X: #N(#PEEK(#PC)).
B $6824,$01 Obstacle Y: #N(#PEEK(#PC)).
L $681D,$08,$02

g $682D Door: #N$38 / #N$3A
@ $682D label=Door_38_3A
D $682D The locked cave door between the right wall of room #N$38 and the left
. wall of room #N$3A. It is opened by the green key (see #R$9222).
B $682D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $682E,$01 Room: #N(#PEEK(#PC)).
B $682F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6830,$01 X position: #N(#PEEK(#PC)).
B $6831,$01 Y position: #N(#PEEK(#PC)).
B $6832,$01 Attribute: #N(#PEEK(#PC)).
B $6833,$01 Obstacle X: #N(#PEEK(#PC)).
B $6834,$01 Obstacle Y: #N(#PEEK(#PC)).
L $682D,$08,$02

g $683D Door: #N$39 / #N$3B
@ $683D label=Door_39_3B
D $683D The cave doorway between the right wall of room #N$39 and the left wall
. of room #N$3B.
B $683D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $683E,$01 Room: #N(#PEEK(#PC)).
B $683F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6840,$01 X position: #N(#PEEK(#PC)).
B $6841,$01 Y position: #N(#PEEK(#PC)).
B $6842,$01 Attribute: #N(#PEEK(#PC)).
B $6843,$01 Obstacle X: #N(#PEEK(#PC)).
B $6844,$01 Obstacle Y: #N(#PEEK(#PC)).
L $683D,$08,$02

g $684D Door: #N$3A / #N$3B
@ $684D label=Door_3A_3B
D $684D The cave doorway between the bottom wall of room #N$3A and the top wall
. of room #N$3B.
B $684D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $684E,$01 Room: #N(#PEEK(#PC)).
B $684F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6850,$01 X position: #N(#PEEK(#PC)).
B $6851,$01 Y position: #N(#PEEK(#PC)).
B $6852,$01 Attribute: #N(#PEEK(#PC)).
B $6853,$01 Obstacle X: #N(#PEEK(#PC)).
B $6854,$01 Obstacle Y: #N(#PEEK(#PC)).
L $684D,$08,$02

g $685D Door: #N$3B / #N$3C
@ $685D label=Door_3B_3C
D $685D The locked cave door between the bottom wall of room #N$3B and the top
. wall of room #N$3C. It is opened by the green key (see #R$9222).
B $685D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $685E,$01 Room: #N(#PEEK(#PC)).
B $685F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6860,$01 X position: #N(#PEEK(#PC)).
B $6861,$01 Y position: #N(#PEEK(#PC)).
B $6862,$01 Attribute: #N(#PEEK(#PC)).
B $6863,$01 Obstacle X: #N(#PEEK(#PC)).
B $6864,$01 Obstacle Y: #N(#PEEK(#PC)).
L $685D,$08,$02

g $686D Door: #N$3B / #N$3D
@ $686D label=Door_3B_3D
D $686D The cave doorway between the right wall of room #N$3B and the left wall
. of room #N$3D.
B $686D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $686E,$01 Room: #N(#PEEK(#PC)).
B $686F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6870,$01 X position: #N(#PEEK(#PC)).
B $6871,$01 Y position: #N(#PEEK(#PC)).
B $6872,$01 Attribute: #N(#PEEK(#PC)).
B $6873,$01 Obstacle X: #N(#PEEK(#PC)).
B $6874,$01 Obstacle Y: #N(#PEEK(#PC)).
L $686D,$08,$02

g $687D Door: #N$3C / #N$3E
@ $687D label=Door_3C_3E
D $687D The cave doorway between the right wall of room #N$3C and the left wall
. of room #N$3E.
B $687D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $687E,$01 Room: #N(#PEEK(#PC)).
B $687F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6880,$01 X position: #N(#PEEK(#PC)).
B $6881,$01 Y position: #N(#PEEK(#PC)).
B $6882,$01 Attribute: #N(#PEEK(#PC)).
B $6883,$01 Obstacle X: #N(#PEEK(#PC)).
B $6884,$01 Obstacle Y: #N(#PEEK(#PC)).
L $687D,$08,$02

g $688D Door: #N$3D / #N$3E
@ $688D label=Door_3D_3E
D $688D The cave doorway between the bottom wall of room #N$3D and the top wall
. of room #N$3E.
B $688D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $688E,$01 Room: #N(#PEEK(#PC)).
B $688F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6890,$01 X position: #N(#PEEK(#PC)).
B $6891,$01 Y position: #N(#PEEK(#PC)).
B $6892,$01 Attribute: #N(#PEEK(#PC)).
B $6893,$01 Obstacle X: #N(#PEEK(#PC)).
B $6894,$01 Obstacle Y: #N(#PEEK(#PC)).
L $688D,$08,$02

g $689D Door: #N$3D / #N$3F
@ $689D label=Door_3D_3F
D $689D The locked cave door between the right wall of room #N$3D and the left
. wall of room #N$3F. It is opened by the cyan key (see #R$9222).
B $689D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $689E,$01 Room: #N(#PEEK(#PC)).
B $689F,$01 Exit offsets: #N(#PEEK(#PC)).
B $68A0,$01 X position: #N(#PEEK(#PC)).
B $68A1,$01 Y position: #N(#PEEK(#PC)).
B $68A2,$01 Attribute: #N(#PEEK(#PC)).
B $68A3,$01 Obstacle X: #N(#PEEK(#PC)).
B $68A4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $689D,$08,$02

g $68AD Door: #N$3F / #N$40
@ $68AD label=Door_3F_40
D $68AD The cave doorway between the right wall of room #N$3F and the left wall
. of room #N$40.
B $68AD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $68AE,$01 Room: #N(#PEEK(#PC)).
B $68AF,$01 Exit offsets: #N(#PEEK(#PC)).
B $68B0,$01 X position: #N(#PEEK(#PC)).
B $68B1,$01 Y position: #N(#PEEK(#PC)).
B $68B2,$01 Attribute: #N(#PEEK(#PC)).
B $68B3,$01 Obstacle X: #N(#PEEK(#PC)).
B $68B4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $68AD,$08,$02

g $68BD Door: #N$40 / #N$41
@ $68BD label=Door_40_41
D $68BD The cave doorway between the right wall of room #N$40 and the left wall
. of room #N$41.
B $68BD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $68BE,$01 Room: #N(#PEEK(#PC)).
B $68BF,$01 Exit offsets: #N(#PEEK(#PC)).
B $68C0,$01 X position: #N(#PEEK(#PC)).
B $68C1,$01 Y position: #N(#PEEK(#PC)).
B $68C2,$01 Attribute: #N(#PEEK(#PC)).
B $68C3,$01 Obstacle X: #N(#PEEK(#PC)).
B $68C4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $68BD,$08,$02

g $68CD Door: #N$40 / #N$42
@ $68CD label=Door_40_42
D $68CD The cave doorway between the top wall of room #N$40 and the bottom wall
. of room #N$42.
B $68CD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $68CE,$01 Room: #N(#PEEK(#PC)).
B $68CF,$01 Exit offsets: #N(#PEEK(#PC)).
B $68D0,$01 X position: #N(#PEEK(#PC)).
B $68D1,$01 Y position: #N(#PEEK(#PC)).
B $68D2,$01 Attribute: #N(#PEEK(#PC)).
B $68D3,$01 Obstacle X: #N(#PEEK(#PC)).
B $68D4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $68CD,$08,$02

g $68DD Door: #N$42 / #N$43
@ $68DD label=Door_42_43
D $68DD The cave doorway between the top wall of room #N$42 and the bottom wall
. of room #N$43.
B $68DD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $68DE,$01 Room: #N(#PEEK(#PC)).
B $68DF,$01 Exit offsets: #N(#PEEK(#PC)).
B $68E0,$01 X position: #N(#PEEK(#PC)).
B $68E1,$01 Y position: #N(#PEEK(#PC)).
B $68E2,$01 Attribute: #N(#PEEK(#PC)).
B $68E3,$01 Obstacle X: #N(#PEEK(#PC)).
B $68E4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $68DD,$08,$02

g $68ED Door: #N$43 / #N$44
@ $68ED label=Door_43_44
D $68ED The cave doorway between the right wall of room #N$43 and the left wall
. of room #N$44.
B $68ED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $68EE,$01 Room: #N(#PEEK(#PC)).
B $68EF,$01 Exit offsets: #N(#PEEK(#PC)).
B $68F0,$01 X position: #N(#PEEK(#PC)).
B $68F1,$01 Y position: #N(#PEEK(#PC)).
B $68F2,$01 Attribute: #N(#PEEK(#PC)).
B $68F3,$01 Obstacle X: #N(#PEEK(#PC)).
B $68F4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $68ED,$08,$02

g $68FD Door: #N$44 / #N$45
@ $68FD label=Door_44_45
D $68FD The locked cave door between the right wall of room #N$44 and the left
. wall of room #N$45. It is opened by the red key (see #R$9222).
B $68FD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $68FE,$01 Room: #N(#PEEK(#PC)).
B $68FF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6900,$01 X position: #N(#PEEK(#PC)).
B $6901,$01 Y position: #N(#PEEK(#PC)).
B $6902,$01 Attribute: #N(#PEEK(#PC)).
B $6903,$01 Obstacle X: #N(#PEEK(#PC)).
B $6904,$01 Obstacle Y: #N(#PEEK(#PC)).
L $68FD,$08,$02

g $690D Door: #N$43 / #N$46
@ $690D label=Door_43_46
D $690D The cave doorway between the top wall of room #N$43 and the bottom wall
. of room #N$46.
B $690D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $690E,$01 Room: #N(#PEEK(#PC)).
B $690F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6910,$01 X position: #N(#PEEK(#PC)).
B $6911,$01 Y position: #N(#PEEK(#PC)).
B $6912,$01 Attribute: #N(#PEEK(#PC)).
B $6913,$01 Obstacle X: #N(#PEEK(#PC)).
B $6914,$01 Obstacle Y: #N(#PEEK(#PC)).
L $690D,$08,$02

g $691D Door: #N$46 / #N$47
@ $691D label=Door_46_47
D $691D The cave doorway between the left wall of room #N$46 and the right wall
. of room #N$47.
B $691D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $691E,$01 Room: #N(#PEEK(#PC)).
B $691F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6920,$01 X position: #N(#PEEK(#PC)).
B $6921,$01 Y position: #N(#PEEK(#PC)).
B $6922,$01 Attribute: #N(#PEEK(#PC)).
B $6923,$01 Obstacle X: #N(#PEEK(#PC)).
B $6924,$01 Obstacle Y: #N(#PEEK(#PC)).
L $691D,$08,$02

g $692D Door: #N$47 / #N$48
@ $692D label=Door_47_48
D $692D The locked cave door between the left wall of room #N$47 and the right
. wall of room #N$48. It is opened by the red key (see #R$9222).
B $692D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $692E,$01 Room: #N(#PEEK(#PC)).
B $692F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6930,$01 X position: #N(#PEEK(#PC)).
B $6931,$01 Y position: #N(#PEEK(#PC)).
B $6932,$01 Attribute: #N(#PEEK(#PC)).
B $6933,$01 Obstacle X: #N(#PEEK(#PC)).
B $6934,$01 Obstacle Y: #N(#PEEK(#PC)).
L $692D,$08,$02

g $693D Door: #N$48 / #N$49
@ $693D label=Door_48_49
D $693D The cave doorway between the bottom wall of room #N$48 and the top wall
. of room #N$49.
B $693D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $693E,$01 Room: #N(#PEEK(#PC)).
B $693F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6940,$01 X position: #N(#PEEK(#PC)).
B $6941,$01 Y position: #N(#PEEK(#PC)).
B $6942,$01 Attribute: #N(#PEEK(#PC)).
B $6943,$01 Obstacle X: #N(#PEEK(#PC)).
B $6944,$01 Obstacle Y: #N(#PEEK(#PC)).
L $693D,$08,$02

g $694D Door: #N$48 / #N$4A
@ $694D label=Door_48_4A
D $694D The locked cave door between the left wall of room #N$48 and the right
. wall of room #N$4A. It is opened by the cyan key (see #R$9222).
B $694D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $694E,$01 Room: #N(#PEEK(#PC)).
B $694F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6950,$01 X position: #N(#PEEK(#PC)).
B $6951,$01 Y position: #N(#PEEK(#PC)).
B $6952,$01 Attribute: #N(#PEEK(#PC)).
B $6953,$01 Obstacle X: #N(#PEEK(#PC)).
B $6954,$01 Obstacle Y: #N(#PEEK(#PC)).
L $694D,$08,$02

g $695D Door: #N$4A / #N$4B
@ $695D label=Door_4A_4B
D $695D The cave doorway between the left wall of room #N$4A and the right wall
. of room #N$4B.
B $695D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $695E,$01 Room: #N(#PEEK(#PC)).
B $695F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6960,$01 X position: #N(#PEEK(#PC)).
B $6961,$01 Y position: #N(#PEEK(#PC)).
B $6962,$01 Attribute: #N(#PEEK(#PC)).
B $6963,$01 Obstacle X: #N(#PEEK(#PC)).
B $6964,$01 Obstacle Y: #N(#PEEK(#PC)).
L $695D,$08,$02

g $696D Door: #N$4B / #N$4C
@ $696D label=Door_4B_4C
D $696D The cave doorway between the top wall of room #N$4B and the bottom wall
. of room #N$4C.
B $696D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $696E,$01 Room: #N(#PEEK(#PC)).
B $696F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6970,$01 X position: #N(#PEEK(#PC)).
B $6971,$01 Y position: #N(#PEEK(#PC)).
B $6972,$01 Attribute: #N(#PEEK(#PC)).
B $6973,$01 Obstacle X: #N(#PEEK(#PC)).
B $6974,$01 Obstacle Y: #N(#PEEK(#PC)).
L $696D,$08,$02

g $697D Door: #N$48 / #N$4D
@ $697D label=Door_48_4D
D $697D The cave doorway between the top wall of room #N$48 and the bottom wall
. of room #N$4D.
B $697D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $697E,$01 Room: #N(#PEEK(#PC)).
B $697F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6980,$01 X position: #N(#PEEK(#PC)).
B $6981,$01 Y position: #N(#PEEK(#PC)).
B $6982,$01 Attribute: #N(#PEEK(#PC)).
B $6983,$01 Obstacle X: #N(#PEEK(#PC)).
B $6984,$01 Obstacle Y: #N(#PEEK(#PC)).
L $697D,$08,$02

g $698D Door: #N$4D / #N$4E
@ $698D label=Door_4D_4E
D $698D The locked cave door between the top wall of room #N$4D and the bottom
. wall of room #N$4E. It is opened by the red key (see #R$9222).
B $698D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $698E,$01 Room: #N(#PEEK(#PC)).
B $698F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6990,$01 X position: #N(#PEEK(#PC)).
B $6991,$01 Y position: #N(#PEEK(#PC)).
B $6992,$01 Attribute: #N(#PEEK(#PC)).
B $6993,$01 Obstacle X: #N(#PEEK(#PC)).
B $6994,$01 Obstacle Y: #N(#PEEK(#PC)).
L $698D,$08,$02

g $699D Door: #N$4E / #N$4F
@ $699D label=Door_4E_4F
D $699D The cave doorway between the right wall of room #N$4E and the left wall
. of room #N$4F.
B $699D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $699E,$01 Room: #N(#PEEK(#PC)).
B $699F,$01 Exit offsets: #N(#PEEK(#PC)).
B $69A0,$01 X position: #N(#PEEK(#PC)).
B $69A1,$01 Y position: #N(#PEEK(#PC)).
B $69A2,$01 Attribute: #N(#PEEK(#PC)).
B $69A3,$01 Obstacle X: #N(#PEEK(#PC)).
B $69A4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $699D,$08,$02

g $69AD Door: #N$4F / #N$50
@ $69AD label=Door_4F_50
D $69AD The cave doorway between the right wall of room #N$4F and the left wall
. of room #N$50.
B $69AD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $69AE,$01 Room: #N(#PEEK(#PC)).
B $69AF,$01 Exit offsets: #N(#PEEK(#PC)).
B $69B0,$01 X position: #N(#PEEK(#PC)).
B $69B1,$01 Y position: #N(#PEEK(#PC)).
B $69B2,$01 Attribute: #N(#PEEK(#PC)).
B $69B3,$01 Obstacle X: #N(#PEEK(#PC)).
B $69B4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $69AD,$08,$02

g $69BD Door: #N$50 / #N$51
@ $69BD label=Door_50_51
D $69BD The cave doorway between the bottom wall of room #N$50 and the top wall
. of room #N$51.
B $69BD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $69BE,$01 Room: #N(#PEEK(#PC)).
B $69BF,$01 Exit offsets: #N(#PEEK(#PC)).
B $69C0,$01 X position: #N(#PEEK(#PC)).
B $69C1,$01 Y position: #N(#PEEK(#PC)).
B $69C2,$01 Attribute: #N(#PEEK(#PC)).
B $69C3,$01 Obstacle X: #N(#PEEK(#PC)).
B $69C4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $69BD,$08,$02

g $69CD Door: #N$50 / #N$52
@ $69CD label=Door_50_52
D $69CD The locked cave door between the right wall of room #N$50 and the left
. wall of room #N$52. It is opened by the green key (see #R$9222).
B $69CD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $69CE,$01 Room: #N(#PEEK(#PC)).
B $69CF,$01 Exit offsets: #N(#PEEK(#PC)).
B $69D0,$01 X position: #N(#PEEK(#PC)).
B $69D1,$01 Y position: #N(#PEEK(#PC)).
B $69D2,$01 Attribute: #N(#PEEK(#PC)).
B $69D3,$01 Obstacle X: #N(#PEEK(#PC)).
B $69D4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $69CD,$08,$02

g $69DD Door: #N$52 / #N$53
@ $69DD label=Door_52_53
D $69DD The cave doorway between the right wall of room #N$52 and the left wall
. of room #N$53.
B $69DD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $69DE,$01 Room: #N(#PEEK(#PC)).
B $69DF,$01 Exit offsets: #N(#PEEK(#PC)).
B $69E0,$01 X position: #N(#PEEK(#PC)).
B $69E1,$01 Y position: #N(#PEEK(#PC)).
B $69E2,$01 Attribute: #N(#PEEK(#PC)).
B $69E3,$01 Obstacle X: #N(#PEEK(#PC)).
B $69E4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $69DD,$08,$02

g $69ED Door: #N$1D / #N$43
@ $69ED label=Door_1D_43
D $69ED The cave doorway between the right wall of room #N$1D and the left wall
. of room #N$43.
B $69ED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $69EE,$01 Room: #N(#PEEK(#PC)).
B $69EF,$01 Exit offsets: #N(#PEEK(#PC)).
B $69F0,$01 X position: #N(#PEEK(#PC)).
B $69F1,$01 Y position: #N(#PEEK(#PC)).
B $69F2,$01 Attribute: #N(#PEEK(#PC)).
B $69F3,$01 Obstacle X: #N(#PEEK(#PC)).
B $69F4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $69ED,$08,$02

g $69FD Door: #N$46 / #N$51
@ $69FD label=Door_46_51
D $69FD The cave doorway between the top wall of room #N$46 and the bottom wall
. of room #N$51.
B $69FD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $69FE,$01 Room: #N(#PEEK(#PC)).
B $69FF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6A00,$01 X position: #N(#PEEK(#PC)).
B $6A01,$01 Y position: #N(#PEEK(#PC)).
B $6A02,$01 Attribute: #N(#PEEK(#PC)).
B $6A03,$01 Obstacle X: #N(#PEEK(#PC)).
B $6A04,$01 Obstacle Y: #N(#PEEK(#PC)).
L $69FD,$08,$02

g $6A0D Door: #N$4C / #N$55
@ $6A0D label=Door_4C_55
D $6A0D The cave doorway between the left wall of room #N$4C and the right wall
. of room #N$55.
B $6A0D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6A0E,$01 Room: #N(#PEEK(#PC)).
B $6A0F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6A10,$01 X position: #N(#PEEK(#PC)).
B $6A11,$01 Y position: #N(#PEEK(#PC)).
B $6A12,$01 Attribute: #N(#PEEK(#PC)).
B $6A13,$01 Obstacle X: #N(#PEEK(#PC)).
B $6A14,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6A0D,$08,$02

g $6A1D Door: #N$54 / #N$55
@ $6A1D label=Door_54_55
D $6A1D The cave doorway between the right wall of room #N$54 and the left wall
. of room #N$55.
B $6A1D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6A1E,$01 Room: #N(#PEEK(#PC)).
B $6A1F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6A20,$01 X position: #N(#PEEK(#PC)).
B $6A21,$01 Y position: #N(#PEEK(#PC)).
B $6A22,$01 Attribute: #N(#PEEK(#PC)).
B $6A23,$01 Obstacle X: #N(#PEEK(#PC)).
B $6A24,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6A1D,$08,$02

g $6A2D Door: #N$54 / #N$30
@ $6A2D label=Door_54_30
D $6A2D The cave doorway between the left wall of room #N$54 and the right wall
. of room #N$30.
B $6A2D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6A2E,$01 Room: #N(#PEEK(#PC)).
B $6A2F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6A30,$01 X position: #N(#PEEK(#PC)).
B $6A31,$01 Y position: #N(#PEEK(#PC)).
B $6A32,$01 Attribute: #N(#PEEK(#PC)).
B $6A33,$01 Obstacle X: #N(#PEEK(#PC)).
B $6A34,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6A2D,$08,$02

g $6A3D Door: #N$2D / #N$75
@ $6A3D label=Door_2D_75
D $6A3D The doorway between the left wall of room #N$2D and the right wall of
. room #N$75.
B $6A3D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6A3E,$01 Room: #N(#PEEK(#PC)).
B $6A3F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6A40,$01 X position: #N(#PEEK(#PC)).
B $6A41,$01 Y position: #N(#PEEK(#PC)).
B $6A42,$01 Attribute: #N(#PEEK(#PC)).
B $6A43,$01 Obstacle X: #N(#PEEK(#PC)).
B $6A44,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6A3D,$08,$02

g $6A4D Door: #N$75 / #N$76
@ $6A4D label=Door_75_76
D $6A4D The doorway between the bottom wall of room #N$75 and the top wall of
. room #N$76.
B $6A4D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6A4E,$01 Room: #N(#PEEK(#PC)).
B $6A4F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6A50,$01 X position: #N(#PEEK(#PC)).
B $6A51,$01 Y position: #N(#PEEK(#PC)).
B $6A52,$01 Attribute: #N(#PEEK(#PC)).
B $6A53,$01 Obstacle X: #N(#PEEK(#PC)).
B $6A54,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6A4D,$08,$02

g $6A5D Door: #N$76 / #N$77
@ $6A5D label=Door_76_77
D $6A5D The doorway between the right wall of room #N$76 and the left wall of
. room #N$77.
B $6A5D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6A5E,$01 Room: #N(#PEEK(#PC)).
B $6A5F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6A60,$01 X position: #N(#PEEK(#PC)).
B $6A61,$01 Y position: #N(#PEEK(#PC)).
B $6A62,$01 Attribute: #N(#PEEK(#PC)).
B $6A63,$01 Obstacle X: #N(#PEEK(#PC)).
B $6A64,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6A5D,$08,$02

g $6A6D Door: #N$77 / #N$78
@ $6A6D label=Door_77_78
D $6A6D The doorway between the right wall of room #N$77 and the left wall of
. room #N$78.
B $6A6D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6A6E,$01 Room: #N(#PEEK(#PC)).
B $6A6F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6A70,$01 X position: #N(#PEEK(#PC)).
B $6A71,$01 Y position: #N(#PEEK(#PC)).
B $6A72,$01 Attribute: #N(#PEEK(#PC)).
B $6A73,$01 Obstacle X: #N(#PEEK(#PC)).
B $6A74,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6A6D,$08,$02

g $6A7D Door: #N$78 / #N$79
@ $6A7D label=Door_78_79
D $6A7D The doorway between the bottom wall of room #N$78 and the top wall of
. room #N$79.
B $6A7D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6A7E,$01 Room: #N(#PEEK(#PC)).
B $6A7F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6A80,$01 X position: #N(#PEEK(#PC)).
B $6A81,$01 Y position: #N(#PEEK(#PC)).
B $6A82,$01 Attribute: #N(#PEEK(#PC)).
B $6A83,$01 Obstacle X: #N(#PEEK(#PC)).
B $6A84,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6A7D,$08,$02

g $6A8D Door: #N$79 / #N$7A
@ $6A8D label=Door_79_7A
D $6A8D The doorway between the bottom wall of room #N$79 and the top wall of
. room #N$7A.
B $6A8D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6A8E,$01 Room: #N(#PEEK(#PC)).
B $6A8F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6A90,$01 X position: #N(#PEEK(#PC)).
B $6A91,$01 Y position: #N(#PEEK(#PC)).
B $6A92,$01 Attribute: #N(#PEEK(#PC)).
B $6A93,$01 Obstacle X: #N(#PEEK(#PC)).
B $6A94,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6A8D,$08,$02

g $6A9D Door: #N$7A / #N$7B
@ $6A9D label=Door_7A_7B
D $6A9D The doorway between the left wall of room #N$7A and the right wall of
. room #N$7B.
B $6A9D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6A9E,$01 Room: #N(#PEEK(#PC)).
B $6A9F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6AA0,$01 X position: #N(#PEEK(#PC)).
B $6AA1,$01 Y position: #N(#PEEK(#PC)).
B $6AA2,$01 Attribute: #N(#PEEK(#PC)).
B $6AA3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6AA4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6A9D,$08,$02

g $6AAD Door: #N$7B / #N$7C
@ $6AAD label=Door_7B_7C
D $6AAD The locked door between the left wall of room #N$7B and the right wall
. of room #N$7C. It is opened by the yellow key (see #R$9222).
B $6AAD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6AAE,$01 Room: #N(#PEEK(#PC)).
B $6AAF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6AB0,$01 X position: #N(#PEEK(#PC)).
B $6AB1,$01 Y position: #N(#PEEK(#PC)).
B $6AB2,$01 Attribute: #N(#PEEK(#PC)).
B $6AB3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6AB4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6AAD,$08,$02

g $6ABD Door: #N$7C / #N$7D
@ $6ABD label=Door_7C_7D
D $6ABD The locked door between the top wall of room #N$7C and the bottom wall
. of room #N$7D. It is opened by the yellow key (see #R$9222).
B $6ABD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6ABE,$01 Room: #N(#PEEK(#PC)).
B $6ABF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6AC0,$01 X position: #N(#PEEK(#PC)).
B $6AC1,$01 Y position: #N(#PEEK(#PC)).
B $6AC2,$01 Attribute: #N(#PEEK(#PC)).
B $6AC3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6AC4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6ABD,$08,$02

g $6ACD Door: #N$7D / #N$76
@ $6ACD label=Door_7D_76
D $6ACD The doorway between the top wall of room #N$7D and the bottom wall of
. room #N$76.
B $6ACD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6ACE,$01 Room: #N(#PEEK(#PC)).
B $6ACF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6AD0,$01 X position: #N(#PEEK(#PC)).
B $6AD1,$01 Y position: #N(#PEEK(#PC)).
B $6AD2,$01 Attribute: #N(#PEEK(#PC)).
B $6AD3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6AD4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6ACD,$08,$02

g $6ADD Door: #N$7A / #N$7E
@ $6ADD label=Door_7A_7E
D $6ADD The locked door between the right wall of room #N$7A and the left wall
. of room #N$7E. It is opened by the red key (see #R$9222).
B $6ADD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6ADE,$01 Room: #N(#PEEK(#PC)).
B $6ADF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6AE0,$01 X position: #N(#PEEK(#PC)).
B $6AE1,$01 Y position: #N(#PEEK(#PC)).
B $6AE2,$01 Attribute: #N(#PEEK(#PC)).
B $6AE3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6AE4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6ADD,$08,$02

g $6AED Door: #N$7E / #N$29
@ $6AED label=Door_7E_29
D $6AED The doorway between the top wall of room #N$7E and the bottom wall of
. room #N$29.
B $6AED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6AEE,$01 Room: #N(#PEEK(#PC)).
B $6AEF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6AF0,$01 X position: #N(#PEEK(#PC)).
B $6AF1,$01 Y position: #N(#PEEK(#PC)).
B $6AF2,$01 Attribute: #N(#PEEK(#PC)).
B $6AF3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6AF4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6AED,$08,$02

g $6AFD Door: #N$21 / #N$88
@ $6AFD label=Door_21_88
D $6AFD The doorway between the top wall of room #N$21 and the bottom wall of
. room #N$88.
B $6AFD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6AFE,$01 Room: #N(#PEEK(#PC)).
B $6AFF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6B00,$01 X position: #N(#PEEK(#PC)).
B $6B01,$01 Y position: #N(#PEEK(#PC)).
B $6B02,$01 Attribute: #N(#PEEK(#PC)).
B $6B03,$01 Obstacle X: #N(#PEEK(#PC)).
B $6B04,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6AFD,$08,$02

g $6B0D Door: #N$7F / #N$80
@ $6B0D label=Door_7F_80
D $6B0D The locked door between the right wall of room #N$7F and the left wall
. of room #N$80. It is opened by the green key (see #R$9222).
B $6B0D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6B0E,$01 Room: #N(#PEEK(#PC)).
B $6B0F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6B10,$01 X position: #N(#PEEK(#PC)).
B $6B11,$01 Y position: #N(#PEEK(#PC)).
B $6B12,$01 Attribute: #N(#PEEK(#PC)).
B $6B13,$01 Obstacle X: #N(#PEEK(#PC)).
B $6B14,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6B0D,$08,$02

g $6B1D Door: #N$80 / #N$82
@ $6B1D label=Door_80_82
D $6B1D The doorway between the bottom wall of room #N$80 and the top wall of
. room #N$82.
B $6B1D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6B1E,$01 Room: #N(#PEEK(#PC)).
B $6B1F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6B20,$01 X position: #N(#PEEK(#PC)).
B $6B21,$01 Y position: #N(#PEEK(#PC)).
B $6B22,$01 Attribute: #N(#PEEK(#PC)).
B $6B23,$01 Obstacle X: #N(#PEEK(#PC)).
B $6B24,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6B1D,$08,$02

g $6B2D Door: #N$82 / #N$81
@ $6B2D label=Door_82_81
D $6B2D The doorway between the left wall of room #N$82 and the right wall of
. room #N$81.
B $6B2D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6B2E,$01 Room: #N(#PEEK(#PC)).
B $6B2F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6B30,$01 X position: #N(#PEEK(#PC)).
B $6B31,$01 Y position: #N(#PEEK(#PC)).
B $6B32,$01 Attribute: #N(#PEEK(#PC)).
B $6B33,$01 Obstacle X: #N(#PEEK(#PC)).
B $6B34,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6B2D,$08,$02

g $6B3D Door: #N$81 / #N$7F
@ $6B3D label=Door_81_7F
D $6B3D The doorway between the top wall of room #N$81 and the bottom wall of
. room #N$7F.
B $6B3D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6B3E,$01 Room: #N(#PEEK(#PC)).
B $6B3F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6B40,$01 X position: #N(#PEEK(#PC)).
B $6B41,$01 Y position: #N(#PEEK(#PC)).
B $6B42,$01 Attribute: #N(#PEEK(#PC)).
B $6B43,$01 Obstacle X: #N(#PEEK(#PC)).
B $6B44,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6B3D,$08,$02

g $6B4D Door: #N$82 / #N$87
@ $6B4D label=Door_82_87
D $6B4D The locked door between the right wall of room #N$82 and the left wall
. of room #N$87. It is opened by the cyan key (see #R$9222).
B $6B4D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6B4E,$01 Room: #N(#PEEK(#PC)).
B $6B4F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6B50,$01 X position: #N(#PEEK(#PC)).
B $6B51,$01 Y position: #N(#PEEK(#PC)).
B $6B52,$01 Attribute: #N(#PEEK(#PC)).
B $6B53,$01 Obstacle X: #N(#PEEK(#PC)).
B $6B54,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6B4D,$08,$02

g $6B5D Door: #N$87 / #N$88
@ $6B5D label=Door_87_88
D $6B5D The doorway between the right wall of room #N$87 and the left wall of
. room #N$88.
B $6B5D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6B5E,$01 Room: #N(#PEEK(#PC)).
B $6B5F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6B60,$01 X position: #N(#PEEK(#PC)).
B $6B61,$01 Y position: #N(#PEEK(#PC)).
B $6B62,$01 Attribute: #N(#PEEK(#PC)).
B $6B63,$01 Obstacle X: #N(#PEEK(#PC)).
B $6B64,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6B5D,$08,$02

g $6B6D Door: #N$87 / #N$8B
@ $6B6D label=Door_87_8B
D $6B6D The doorway between the bottom wall of room #N$87 and the top wall of
. room #N$8B.
B $6B6D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6B6E,$01 Room: #N(#PEEK(#PC)).
B $6B6F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6B70,$01 X position: #N(#PEEK(#PC)).
B $6B71,$01 Y position: #N(#PEEK(#PC)).
B $6B72,$01 Attribute: #N(#PEEK(#PC)).
B $6B73,$01 Obstacle X: #N(#PEEK(#PC)).
B $6B74,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6B6D,$08,$02

g $6B7D Door: #N$8B / #N$8C
@ $6B7D label=Door_8B_8C
D $6B7D The doorway between the bottom wall of room #N$8B and the top wall of
. room #N$8C.
B $6B7D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6B7E,$01 Room: #N(#PEEK(#PC)).
B $6B7F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6B80,$01 X position: #N(#PEEK(#PC)).
B $6B81,$01 Y position: #N(#PEEK(#PC)).
B $6B82,$01 Attribute: #N(#PEEK(#PC)).
B $6B83,$01 Obstacle X: #N(#PEEK(#PC)).
B $6B84,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6B7D,$08,$02

g $6B8D Door: #N$8C / #N$8D
@ $6B8D label=Door_8C_8D
D $6B8D The locked door between the bottom wall of room #N$8C and the top wall
. of room #N$8D. It is opened by the green key (see #R$9222).
B $6B8D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6B8E,$01 Room: #N(#PEEK(#PC)).
B $6B8F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6B90,$01 X position: #N(#PEEK(#PC)).
B $6B91,$01 Y position: #N(#PEEK(#PC)).
B $6B92,$01 Attribute: #N(#PEEK(#PC)).
B $6B93,$01 Obstacle X: #N(#PEEK(#PC)).
B $6B94,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6B8D,$08,$02

g $6B9D Door: #N$83 / #N$84
@ $6B9D label=Door_83_84
D $6B9D The locked door between the right wall of room #N$83 and the left wall
. of room #N$84. It is opened by the red key (see #R$9222).
B $6B9D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6B9E,$01 Room: #N(#PEEK(#PC)).
B $6B9F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6BA0,$01 X position: #N(#PEEK(#PC)).
B $6BA1,$01 Y position: #N(#PEEK(#PC)).
B $6BA2,$01 Attribute: #N(#PEEK(#PC)).
B $6BA3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6BA4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6B9D,$08,$02

g $6BAD Door: #N$84 / #N$86
@ $6BAD label=Door_84_86
D $6BAD The doorway between the bottom wall of room #N$84 and the top wall of
. room #N$86.
B $6BAD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6BAE,$01 Room: #N(#PEEK(#PC)).
B $6BAF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6BB0,$01 X position: #N(#PEEK(#PC)).
B $6BB1,$01 Y position: #N(#PEEK(#PC)).
B $6BB2,$01 Attribute: #N(#PEEK(#PC)).
B $6BB3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6BB4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6BAD,$08,$02

g $6BBD Door: #N$86 / #N$85
@ $6BBD label=Door_86_85
D $6BBD The doorway between the left wall of room #N$86 and the right wall of
. room #N$85.
B $6BBD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6BBE,$01 Room: #N(#PEEK(#PC)).
B $6BBF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6BC0,$01 X position: #N(#PEEK(#PC)).
B $6BC1,$01 Y position: #N(#PEEK(#PC)).
B $6BC2,$01 Attribute: #N(#PEEK(#PC)).
B $6BC3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6BC4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6BBD,$08,$02

g $6BCD Door: #N$85 / #N$83
@ $6BCD label=Door_85_83
D $6BCD The doorway between the top wall of room #N$85 and the bottom wall of
. room #N$83.
B $6BCD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6BCE,$01 Room: #N(#PEEK(#PC)).
B $6BCF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6BD0,$01 X position: #N(#PEEK(#PC)).
B $6BD1,$01 Y position: #N(#PEEK(#PC)).
B $6BD2,$01 Attribute: #N(#PEEK(#PC)).
B $6BD3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6BD4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6BCD,$08,$02

g $6BDD Door: #N$84 / #N$89
@ $6BDD label=Door_84_89
D $6BDD The locked door between the right wall of room #N$84 and the left wall
. of room #N$89. It is opened by the yellow key (see #R$9222).
B $6BDD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6BDE,$01 Room: #N(#PEEK(#PC)).
B $6BDF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6BE0,$01 X position: #N(#PEEK(#PC)).
B $6BE1,$01 Y position: #N(#PEEK(#PC)).
B $6BE2,$01 Attribute: #N(#PEEK(#PC)).
B $6BE3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6BE4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6BDD,$08,$02

g $6BED Door: #N$89 / #N$8D
@ $6BED label=Door_89_8D
D $6BED The doorway between the top wall of room #N$89 and the bottom wall of
. room #N$8D.
B $6BED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6BEE,$01 Room: #N(#PEEK(#PC)).
B $6BEF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6BF0,$01 X position: #N(#PEEK(#PC)).
B $6BF1,$01 Y position: #N(#PEEK(#PC)).
B $6BF2,$01 Attribute: #N(#PEEK(#PC)).
B $6BF3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6BF4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6BED,$08,$02

g $6BFD Door: #N$89 / #N$8A
@ $6BFD label=Door_89_8A
D $6BFD The doorway between the right wall of room #N$89 and the left wall of
. room #N$8A.
B $6BFD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6BFE,$01 Room: #N(#PEEK(#PC)).
B $6BFF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6C00,$01 X position: #N(#PEEK(#PC)).
B $6C01,$01 Y position: #N(#PEEK(#PC)).
B $6C02,$01 Attribute: #N(#PEEK(#PC)).
B $6C03,$01 Obstacle X: #N(#PEEK(#PC)).
B $6C04,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6BFD,$08,$02

g $6C0D Door: #N$8A / #N$23
@ $6C0D label=Door_8A_23
D $6C0D The locked door between the top wall of room #N$8A and the bottom wall
. of room #N$23. It is opened by the green key (see #R$9222).
B $6C0D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6C0E,$01 Room: #N(#PEEK(#PC)).
B $6C0F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6C10,$01 X position: #N(#PEEK(#PC)).
B $6C11,$01 Y position: #N(#PEEK(#PC)).
B $6C12,$01 Attribute: #N(#PEEK(#PC)).
B $6C13,$01 Obstacle X: #N(#PEEK(#PC)).
B $6C14,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6C0D,$08,$02

g $6C1D Door: #N$13 / #N$73
@ $6C1D label=Door_13_73
D $6C1D The doorway between the left wall of room #N$13 and the right wall of
. room #N$73.
B $6C1D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6C1E,$01 Room: #N(#PEEK(#PC)).
B $6C1F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6C20,$01 X position: #N(#PEEK(#PC)).
B $6C21,$01 Y position: #N(#PEEK(#PC)).
B $6C22,$01 Attribute: #N(#PEEK(#PC)).
B $6C23,$01 Obstacle X: #N(#PEEK(#PC)).
B $6C24,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6C1D,$08,$02

g $6C2D Door: #N$11 / #N$6B
@ $6C2D label=Door_11_6B
D $6C2D The doorway between the right wall of room #N$11 and the left wall of
. room #N$6B.
B $6C2D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6C2E,$01 Room: #N(#PEEK(#PC)).
B $6C2F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6C30,$01 X position: #N(#PEEK(#PC)).
B $6C31,$01 Y position: #N(#PEEK(#PC)).
B $6C32,$01 Attribute: #N(#PEEK(#PC)).
B $6C33,$01 Obstacle X: #N(#PEEK(#PC)).
B $6C34,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6C2D,$08,$02

g $6C3D Door: #N$6B / #N$6C
@ $6C3D label=Door_6B_6C
D $6C3D The doorway between the right wall of room #N$6B and the left wall of
. room #N$6C.
B $6C3D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6C3E,$01 Room: #N(#PEEK(#PC)).
B $6C3F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6C40,$01 X position: #N(#PEEK(#PC)).
B $6C41,$01 Y position: #N(#PEEK(#PC)).
B $6C42,$01 Attribute: #N(#PEEK(#PC)).
B $6C43,$01 Obstacle X: #N(#PEEK(#PC)).
B $6C44,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6C3D,$08,$02

g $6C4D Door: #N$6C / #N$03
@ $6C4D label=Door_6C_03
D $6C4D The locked door between the right wall of room #N$6C and the left wall
. of room #N$03. It is opened by the cyan key (see #R$9222).
B $6C4D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6C4E,$01 Room: #N(#PEEK(#PC)).
B $6C4F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6C50,$01 X position: #N(#PEEK(#PC)).
B $6C51,$01 Y position: #N(#PEEK(#PC)).
B $6C52,$01 Attribute: #N(#PEEK(#PC)).
B $6C53,$01 Obstacle X: #N(#PEEK(#PC)).
B $6C54,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6C4D,$08,$02

g $6C5D Door: #N$0F / #N$6D
@ $6C5D label=Door_0F_6D
D $6C5D The locked door between the right wall of room #N$0F and the left wall
. of room #N$6D. It is opened by the green key (see #R$9222).
B $6C5D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6C5E,$01 Room: #N(#PEEK(#PC)).
B $6C5F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6C60,$01 X position: #N(#PEEK(#PC)).
B $6C61,$01 Y position: #N(#PEEK(#PC)).
B $6C62,$01 Attribute: #N(#PEEK(#PC)).
B $6C63,$01 Obstacle X: #N(#PEEK(#PC)).
B $6C64,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6C5D,$08,$02

g $6C6D Door: #N$6D / #N$6E
@ $6C6D label=Door_6D_6E
D $6C6D The doorway between the right wall of room #N$6D and the left wall of
. room #N$6E.
B $6C6D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6C6E,$01 Room: #N(#PEEK(#PC)).
B $6C6F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6C70,$01 X position: #N(#PEEK(#PC)).
B $6C71,$01 Y position: #N(#PEEK(#PC)).
B $6C72,$01 Attribute: #N(#PEEK(#PC)).
B $6C73,$01 Obstacle X: #N(#PEEK(#PC)).
B $6C74,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6C6D,$08,$02

g $6C7D Door: #N$6E / #N$05
@ $6C7D label=Door_6E_05
D $6C7D The doorway between the right wall of room #N$6E and the left wall of
. room #N$05.
B $6C7D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6C7E,$01 Room: #N(#PEEK(#PC)).
B $6C7F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6C80,$01 X position: #N(#PEEK(#PC)).
B $6C81,$01 Y position: #N(#PEEK(#PC)).
B $6C82,$01 Attribute: #N(#PEEK(#PC)).
B $6C83,$01 Obstacle X: #N(#PEEK(#PC)).
B $6C84,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6C7D,$08,$02

g $6C8D Door: #N$0D / #N$6F
@ $6C8D label=Door_0D_6F
D $6C8D The locked door between the bottom wall of room #N$0D and the top wall
. of room #N$6F. It is opened by the cyan key (see #R$9222).
B $6C8D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6C8E,$01 Room: #N(#PEEK(#PC)).
B $6C8F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6C90,$01 X position: #N(#PEEK(#PC)).
B $6C91,$01 Y position: #N(#PEEK(#PC)).
B $6C92,$01 Attribute: #N(#PEEK(#PC)).
B $6C93,$01 Obstacle X: #N(#PEEK(#PC)).
B $6C94,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6C8D,$08,$02

g $6C9D Door: #N$6F / #N$70
@ $6C9D label=Door_6F_70
D $6C9D The doorway between the bottom wall of room #N$6F and the top wall of
. room #N$70.
B $6C9D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6C9E,$01 Room: #N(#PEEK(#PC)).
B $6C9F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6CA0,$01 X position: #N(#PEEK(#PC)).
B $6CA1,$01 Y position: #N(#PEEK(#PC)).
B $6CA2,$01 Attribute: #N(#PEEK(#PC)).
B $6CA3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6CA4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6C9D,$08,$02

g $6CAD Door: #N$70 / #N$71
@ $6CAD label=Door_70_71
D $6CAD The doorway in the top wall of room #N$70, which joins the big doorway
. in the bottom wall of room #N$71.
B $6CAD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6CAE,$01 Room: #N(#PEEK(#PC)).
B $6CAF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6CB0,$01 X position: #N(#PEEK(#PC)).
B $6CB1,$01 Y position: #N(#PEEK(#PC)).
B $6CB2,$01 Attribute: #N(#PEEK(#PC)).
B $6CB3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6CB4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6CAD,$08,$02

g $6CBD Door: #N$71 / #N$72
@ $6CBD label=Door_71_72
D $6CBD The doorway in the top wall of room #N$71, which joins the big doorway
. in the bottom wall of room #N$72.
B $6CBD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6CBE,$01 Room: #N(#PEEK(#PC)).
B $6CBF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6CC0,$01 X position: #N(#PEEK(#PC)).
B $6CC1,$01 Y position: #N(#PEEK(#PC)).
B $6CC2,$01 Attribute: #N(#PEEK(#PC)).
B $6CC3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6CC4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6CBD,$08,$02

g $6CCD Door: #N$72 / #N$35
@ $6CCD label=Door_72_35
D $6CCD The doorway in the top wall of room #N$72, which joins the cave doorway
. in the bottom wall of room #N$35.
B $6CCD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6CCE,$01 Room: #N(#PEEK(#PC)).
B $6CCF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6CD0,$01 X position: #N(#PEEK(#PC)).
B $6CD1,$01 Y position: #N(#PEEK(#PC)).
B $6CD2,$01 Attribute: #N(#PEEK(#PC)).
B $6CD3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6CD4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6CCD,$08,$02

g $6CDD Door: #N$30 / #N$74
@ $6CDD label=Door_30_74
D $6CDD The cave doorway between the left wall of room #N$30 and the right wall
. of room #N$74.
B $6CDD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6CDE,$01 Room: #N(#PEEK(#PC)).
B $6CDF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6CE0,$01 X position: #N(#PEEK(#PC)).
B $6CE1,$01 Y position: #N(#PEEK(#PC)).
B $6CE2,$01 Attribute: #N(#PEEK(#PC)).
B $6CE3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6CE4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6CDD,$08,$02

g $6CED Door: #N$56 / #N$57
@ $6CED label=Door_56_57
D $6CED The doorway between the right wall of room #N$56 and the left wall of
. room #N$57.
B $6CED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6CEE,$01 Room: #N(#PEEK(#PC)).
B $6CEF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6CF0,$01 X position: #N(#PEEK(#PC)).
B $6CF1,$01 Y position: #N(#PEEK(#PC)).
B $6CF2,$01 Attribute: #N(#PEEK(#PC)).
B $6CF3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6CF4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6CED,$08,$02

g $6CFD Door: #N$57 / #N$58
@ $6CFD label=Door_57_58
D $6CFD The locked door between the right wall of room #N$57 and the left wall
. of room #N$58. It is opened by the green key (see #R$9222).
B $6CFD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6CFE,$01 Room: #N(#PEEK(#PC)).
B $6CFF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6D00,$01 X position: #N(#PEEK(#PC)).
B $6D01,$01 Y position: #N(#PEEK(#PC)).
B $6D02,$01 Attribute: #N(#PEEK(#PC)).
B $6D03,$01 Obstacle X: #N(#PEEK(#PC)).
B $6D04,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6CFD,$08,$02

g $6D0D Door: #N$58 / #N$59
@ $6D0D label=Door_58_59
D $6D0D The doorway between the right wall of room #N$58 and the left wall of
. room #N$59.
B $6D0D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6D0E,$01 Room: #N(#PEEK(#PC)).
B $6D0F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6D10,$01 X position: #N(#PEEK(#PC)).
B $6D11,$01 Y position: #N(#PEEK(#PC)).
B $6D12,$01 Attribute: #N(#PEEK(#PC)).
B $6D13,$01 Obstacle X: #N(#PEEK(#PC)).
B $6D14,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6D0D,$08,$02

g $6D1D Door: #N$5A / #N$5B
@ $6D1D label=Door_5A_5B
D $6D1D The doorway between the right wall of room #N$5A and the left wall of
. room #N$5B.
B $6D1D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6D1E,$01 Room: #N(#PEEK(#PC)).
B $6D1F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6D20,$01 X position: #N(#PEEK(#PC)).
B $6D21,$01 Y position: #N(#PEEK(#PC)).
B $6D22,$01 Attribute: #N(#PEEK(#PC)).
B $6D23,$01 Obstacle X: #N(#PEEK(#PC)).
B $6D24,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6D1D,$08,$02

g $6D2D Door: #N$5B / #N$5C
@ $6D2D label=Door_5B_5C
D $6D2D The locked door between the right wall of room #N$5B and the left wall
. of room #N$5C. It is opened by the red key (see #R$9222).
B $6D2D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6D2E,$01 Room: #N(#PEEK(#PC)).
B $6D2F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6D30,$01 X position: #N(#PEEK(#PC)).
B $6D31,$01 Y position: #N(#PEEK(#PC)).
B $6D32,$01 Attribute: #N(#PEEK(#PC)).
B $6D33,$01 Obstacle X: #N(#PEEK(#PC)).
B $6D34,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6D2D,$08,$02

g $6D3D Door: #N$5C / #N$5D
@ $6D3D label=Door_5C_5D
D $6D3D The locked door between the right wall of room #N$5C and the left wall
. of room #N$5D. It is opened by the green key (see #R$9222).
B $6D3D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6D3E,$01 Room: #N(#PEEK(#PC)).
B $6D3F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6D40,$01 X position: #N(#PEEK(#PC)).
B $6D41,$01 Y position: #N(#PEEK(#PC)).
B $6D42,$01 Attribute: #N(#PEEK(#PC)).
B $6D43,$01 Obstacle X: #N(#PEEK(#PC)).
B $6D44,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6D3D,$08,$02

g $6D4D Door: #N$5E / #N$5F
@ $6D4D label=Door_5E_5F
D $6D4D The locked door between the right wall of room #N$5E and the left wall
. of room #N$5F. It is opened by the red key (see #R$9222).
B $6D4D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6D4E,$01 Room: #N(#PEEK(#PC)).
B $6D4F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6D50,$01 X position: #N(#PEEK(#PC)).
B $6D51,$01 Y position: #N(#PEEK(#PC)).
B $6D52,$01 Attribute: #N(#PEEK(#PC)).
B $6D53,$01 Obstacle X: #N(#PEEK(#PC)).
B $6D54,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6D4D,$08,$02

g $6D5D Door: #N$5F / #N$60
@ $6D5D label=Door_5F_60
D $6D5D The locked door between the right wall of room #N$5F and the left wall
. of room #N$60. It is opened by the red key (see #R$9222).
B $6D5D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6D5E,$01 Room: #N(#PEEK(#PC)).
B $6D5F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6D60,$01 X position: #N(#PEEK(#PC)).
B $6D61,$01 Y position: #N(#PEEK(#PC)).
B $6D62,$01 Attribute: #N(#PEEK(#PC)).
B $6D63,$01 Obstacle X: #N(#PEEK(#PC)).
B $6D64,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6D5D,$08,$02

g $6D6D Door: #N$60 / #N$61
@ $6D6D label=Door_60_61
D $6D6D The doorway between the right wall of room #N$60 and the left wall of
. room #N$61.
B $6D6D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6D6E,$01 Room: #N(#PEEK(#PC)).
B $6D6F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6D70,$01 X position: #N(#PEEK(#PC)).
B $6D71,$01 Y position: #N(#PEEK(#PC)).
B $6D72,$01 Attribute: #N(#PEEK(#PC)).
B $6D73,$01 Obstacle X: #N(#PEEK(#PC)).
B $6D74,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6D6D,$08,$02

g $6D7D Door: #N$62 / #N$63
@ $6D7D label=Door_62_63
D $6D7D The doorway between the right wall of room #N$62 and the left wall of
. room #N$63.
B $6D7D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6D7E,$01 Room: #N(#PEEK(#PC)).
B $6D7F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6D80,$01 X position: #N(#PEEK(#PC)).
B $6D81,$01 Y position: #N(#PEEK(#PC)).
B $6D82,$01 Attribute: #N(#PEEK(#PC)).
B $6D83,$01 Obstacle X: #N(#PEEK(#PC)).
B $6D84,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6D7D,$08,$02

g $6D8D Door: #N$63 / #N$64
@ $6D8D label=Door_63_64
D $6D8D The doorway between the right wall of room #N$63 and the left wall of
. room #N$64.
B $6D8D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6D8E,$01 Room: #N(#PEEK(#PC)).
B $6D8F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6D90,$01 X position: #N(#PEEK(#PC)).
B $6D91,$01 Y position: #N(#PEEK(#PC)).
B $6D92,$01 Attribute: #N(#PEEK(#PC)).
B $6D93,$01 Obstacle X: #N(#PEEK(#PC)).
B $6D94,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6D8D,$08,$02

g $6D9D Door: #N$64 / #N$65
@ $6D9D label=Door_64_65
D $6D9D The locked door between the right wall of room #N$64 and the left wall
. of room #N$65. It is opened by the yellow key (see #R$9222).
B $6D9D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6D9E,$01 Room: #N(#PEEK(#PC)).
B $6D9F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6DA0,$01 X position: #N(#PEEK(#PC)).
B $6DA1,$01 Y position: #N(#PEEK(#PC)).
B $6DA2,$01 Attribute: #N(#PEEK(#PC)).
B $6DA3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6DA4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6D9D,$08,$02

g $6DAD Door: #N$56 / #N$5A
@ $6DAD label=Door_56_5A
D $6DAD The doorway between the bottom wall of room #N$56 and the top wall of
. room #N$5A.
B $6DAD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6DAE,$01 Room: #N(#PEEK(#PC)).
B $6DAF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6DB0,$01 X position: #N(#PEEK(#PC)).
B $6DB1,$01 Y position: #N(#PEEK(#PC)).
B $6DB2,$01 Attribute: #N(#PEEK(#PC)).
B $6DB3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6DB4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6DAD,$08,$02

g $6DBD Door: #N$5A / #N$5E
@ $6DBD label=Door_5A_5E
D $6DBD The locked door between the bottom wall of room #N$5A and the top wall
. of room #N$5E. It is opened by the cyan key (see #R$9222).
B $6DBD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6DBE,$01 Room: #N(#PEEK(#PC)).
B $6DBF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6DC0,$01 X position: #N(#PEEK(#PC)).
B $6DC1,$01 Y position: #N(#PEEK(#PC)).
B $6DC2,$01 Attribute: #N(#PEEK(#PC)).
B $6DC3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6DC4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6DBD,$08,$02

g $6DCD Door: #N$5E / #N$62
@ $6DCD label=Door_5E_62
D $6DCD The doorway between the bottom wall of room #N$5E and the top wall of
. room #N$62.
B $6DCD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6DCE,$01 Room: #N(#PEEK(#PC)).
B $6DCF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6DD0,$01 X position: #N(#PEEK(#PC)).
B $6DD1,$01 Y position: #N(#PEEK(#PC)).
B $6DD2,$01 Attribute: #N(#PEEK(#PC)).
B $6DD3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6DD4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6DCD,$08,$02

g $6DDD Door: #N$57 / #N$5B
@ $6DDD label=Door_57_5B
D $6DDD The doorway between the bottom wall of room #N$57 and the top wall of
. room #N$5B.
B $6DDD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6DDE,$01 Room: #N(#PEEK(#PC)).
B $6DDF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6DE0,$01 X position: #N(#PEEK(#PC)).
B $6DE1,$01 Y position: #N(#PEEK(#PC)).
B $6DE2,$01 Attribute: #N(#PEEK(#PC)).
B $6DE3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6DE4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6DDD,$08,$02

g $6DED Door: #N$5B / #N$5F
@ $6DED label=Door_5B_5F
D $6DED The locked door between the bottom wall of room #N$5B and the top wall
. of room #N$5F. It is opened by the green key (see #R$9222).
B $6DED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6DEE,$01 Room: #N(#PEEK(#PC)).
B $6DEF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6DF0,$01 X position: #N(#PEEK(#PC)).
B $6DF1,$01 Y position: #N(#PEEK(#PC)).
B $6DF2,$01 Attribute: #N(#PEEK(#PC)).
B $6DF3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6DF4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6DED,$08,$02

g $6DFD Door: #N$5F / #N$63
@ $6DFD label=Door_5F_63
D $6DFD The locked door between the bottom wall of room #N$5F and the top wall
. of room #N$63. It is opened by the cyan key (see #R$9222).
B $6DFD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6DFE,$01 Room: #N(#PEEK(#PC)).
B $6DFF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6E00,$01 X position: #N(#PEEK(#PC)).
B $6E01,$01 Y position: #N(#PEEK(#PC)).
B $6E02,$01 Attribute: #N(#PEEK(#PC)).
B $6E03,$01 Obstacle X: #N(#PEEK(#PC)).
B $6E04,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6DFD,$08,$02

g $6E0D Door: #N$58 / #N$5C
@ $6E0D label=Door_58_5C
D $6E0D The doorway between the bottom wall of room #N$58 and the top wall of
. room #N$5C.
B $6E0D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6E0E,$01 Room: #N(#PEEK(#PC)).
B $6E0F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6E10,$01 X position: #N(#PEEK(#PC)).
B $6E11,$01 Y position: #N(#PEEK(#PC)).
B $6E12,$01 Attribute: #N(#PEEK(#PC)).
B $6E13,$01 Obstacle X: #N(#PEEK(#PC)).
B $6E14,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6E0D,$08,$02

g $6E1D Door: #N$5C / #N$60
@ $6E1D label=Door_5C_60
D $6E1D The locked door between the bottom wall of room #N$5C and the top wall
. of room #N$60. It is opened by the red key (see #R$9222).
B $6E1D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6E1E,$01 Room: #N(#PEEK(#PC)).
B $6E1F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6E20,$01 X position: #N(#PEEK(#PC)).
B $6E21,$01 Y position: #N(#PEEK(#PC)).
B $6E22,$01 Attribute: #N(#PEEK(#PC)).
B $6E23,$01 Obstacle X: #N(#PEEK(#PC)).
B $6E24,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6E1D,$08,$02

g $6E2D Door: #N$60 / #N$64
@ $6E2D label=Door_60_64
D $6E2D The locked door between the bottom wall of room #N$60 and the top wall
. of room #N$64. It is opened by the cyan key (see #R$9222).
B $6E2D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6E2E,$01 Room: #N(#PEEK(#PC)).
B $6E2F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6E30,$01 X position: #N(#PEEK(#PC)).
B $6E31,$01 Y position: #N(#PEEK(#PC)).
B $6E32,$01 Attribute: #N(#PEEK(#PC)).
B $6E33,$01 Obstacle X: #N(#PEEK(#PC)).
B $6E34,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6E2D,$08,$02

g $6E3D Door: #N$59 / #N$5D
@ $6E3D label=Door_59_5D
D $6E3D The locked door between the bottom wall of room #N$59 and the top wall
. of room #N$5D. It is opened by the yellow key (see #R$9222).
B $6E3D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6E3E,$01 Room: #N(#PEEK(#PC)).
B $6E3F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6E40,$01 X position: #N(#PEEK(#PC)).
B $6E41,$01 Y position: #N(#PEEK(#PC)).
B $6E42,$01 Attribute: #N(#PEEK(#PC)).
B $6E43,$01 Obstacle X: #N(#PEEK(#PC)).
B $6E44,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6E3D,$08,$02

g $6E4D Door: #N$5D / #N$61
@ $6E4D label=Door_5D_61
D $6E4D The doorway between the bottom wall of room #N$5D and the top wall of
. room #N$61.
B $6E4D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6E4E,$01 Room: #N(#PEEK(#PC)).
B $6E4F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6E50,$01 X position: #N(#PEEK(#PC)).
B $6E51,$01 Y position: #N(#PEEK(#PC)).
B $6E52,$01 Attribute: #N(#PEEK(#PC)).
B $6E53,$01 Obstacle X: #N(#PEEK(#PC)).
B $6E54,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6E4D,$08,$02

g $6E5D Door: #N$61 / #N$65
@ $6E5D label=Door_61_65
D $6E5D The doorway between the bottom wall of room #N$61 and the top wall of
. room #N$65.
B $6E5D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6E5E,$01 Room: #N(#PEEK(#PC)).
B $6E5F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6E60,$01 X position: #N(#PEEK(#PC)).
B $6E61,$01 Y position: #N(#PEEK(#PC)).
B $6E62,$01 Attribute: #N(#PEEK(#PC)).
B $6E63,$01 Obstacle X: #N(#PEEK(#PC)).
B $6E64,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6E5D,$08,$02

g $6E6D Door: #N$67 / #N$56
@ $6E6D label=Door_67_56
D $6E6D The locked door between the bottom wall of room #N$67 and the top wall
. of room #N$56. It is opened by the cyan key (see #R$9222).
B $6E6D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6E6E,$01 Room: #N(#PEEK(#PC)).
B $6E6F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6E70,$01 X position: #N(#PEEK(#PC)).
B $6E71,$01 Y position: #N(#PEEK(#PC)).
B $6E72,$01 Attribute: #N(#PEEK(#PC)).
B $6E73,$01 Obstacle X: #N(#PEEK(#PC)).
B $6E74,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6E6D,$08,$02

g $6E7D Door: #N$68 / #N$59
@ $6E7D label=Door_68_59
D $6E7D The locked door between the bottom wall of room #N$68 and the top wall
. of room #N$59. It is opened by the red key (see #R$9222).
B $6E7D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6E7E,$01 Room: #N(#PEEK(#PC)).
B $6E7F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6E80,$01 X position: #N(#PEEK(#PC)).
B $6E81,$01 Y position: #N(#PEEK(#PC)).
B $6E82,$01 Attribute: #N(#PEEK(#PC)).
B $6E83,$01 Obstacle X: #N(#PEEK(#PC)).
B $6E84,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6E7D,$08,$02

g $6E8D Door: #N$69 / #N$56
@ $6E8D label=Door_69_56
D $6E8D The locked door between the right wall of room #N$69 and the left wall
. of room #N$56. It is opened by the yellow key (see #R$9222).
B $6E8D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6E8E,$01 Room: #N(#PEEK(#PC)).
B $6E8F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6E90,$01 X position: #N(#PEEK(#PC)).
B $6E91,$01 Y position: #N(#PEEK(#PC)).
B $6E92,$01 Attribute: #N(#PEEK(#PC)).
B $6E93,$01 Obstacle X: #N(#PEEK(#PC)).
B $6E94,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6E8D,$08,$02

g $6E9D Door: #N$6A / #N$62
@ $6E9D label=Door_6A_62
D $6E9D The locked door between the right wall of room #N$6A and the left wall
. of room #N$62. It is opened by the green key (see #R$9222).
B $6E9D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6E9E,$01 Room: #N(#PEEK(#PC)).
B $6E9F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6EA0,$01 X position: #N(#PEEK(#PC)).
B $6EA1,$01 Y position: #N(#PEEK(#PC)).
B $6EA2,$01 Attribute: #N(#PEEK(#PC)).
B $6EA3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6EA4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6E9D,$08,$02

g $6EAD Door: #N$66 / #N$5B
@ $6EAD label=Door_66_5B
D $6EAD The locked door between the top wall of room #N$66 and the bottom wall
. of room #N$5B. It is opened by the yellow key (see #R$9222).
B $6EAD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6EAE,$01 Room: #N(#PEEK(#PC)).
B $6EAF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6EB0,$01 X position: #N(#PEEK(#PC)).
B $6EB1,$01 Y position: #N(#PEEK(#PC)).
B $6EB2,$01 Attribute: #N(#PEEK(#PC)).
B $6EB3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6EB4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6EAD,$08,$02

g $6EBD Door: #N$66 / #N$5C
@ $6EBD label=Door_66_5C
D $6EBD The locked door between the top wall of room #N$66 and the bottom wall
. of room #N$5C. It is opened by the yellow key (see #R$9222).
B $6EBD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6EBE,$01 Room: #N(#PEEK(#PC)).
B $6EBF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6EC0,$01 X position: #N(#PEEK(#PC)).
B $6EC1,$01 Y position: #N(#PEEK(#PC)).
B $6EC2,$01 Attribute: #N(#PEEK(#PC)).
B $6EC3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6EC4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6EBD,$08,$02

g $6ECD Door: #N$66 / #N$5F
@ $6ECD label=Door_66_5F
D $6ECD The locked door between the bottom wall of room #N$66 and the top wall
. of room #N$5F. It is opened by the yellow key (see #R$9222).
B $6ECD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6ECE,$01 Room: #N(#PEEK(#PC)).
B $6ECF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6ED0,$01 X position: #N(#PEEK(#PC)).
B $6ED1,$01 Y position: #N(#PEEK(#PC)).
B $6ED2,$01 Attribute: #N(#PEEK(#PC)).
B $6ED3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6ED4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6ECD,$08,$02

g $6EDD Door: #N$66 / #N$60
@ $6EDD label=Door_66_60
D $6EDD The locked door between the bottom wall of room #N$66 and the top wall
. of room #N$60. It is opened by the yellow key (see #R$9222).
B $6EDD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6EDE,$01 Room: #N(#PEEK(#PC)).
B $6EDF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6EE0,$01 X position: #N(#PEEK(#PC)).
B $6EE1,$01 Y position: #N(#PEEK(#PC)).
B $6EE2,$01 Attribute: #N(#PEEK(#PC)).
B $6EE3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6EE4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6EDD,$08,$02

g $6EED Door: #N$65 / #N$1B
@ $6EED label=Door_65_1B
D $6EED The doorway between the right wall of room #N$65 and the left wall of
. room #N$1B.
B $6EED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6EEE,$01 Room: #N(#PEEK(#PC)).
B $6EEF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6EF0,$01 X position: #N(#PEEK(#PC)).
B $6EF1,$01 Y position: #N(#PEEK(#PC)).
B $6EF2,$01 Attribute: #N(#PEEK(#PC)).
B $6EF3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6EF4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6EED,$08,$02

g $6EFD Door: #N$40 / #N$8F
@ $6EFD label=Door_40_8F
D $6EFD The cave doorway between the bottom wall of room #N$40 and the top wall
. of room #N$8F.
B $6EFD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6EFE,$01 Room: #N(#PEEK(#PC)).
B $6EFF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6F00,$01 X position: #N(#PEEK(#PC)).
B $6F01,$01 Y position: #N(#PEEK(#PC)).
B $6F02,$01 Attribute: #N(#PEEK(#PC)).
B $6F03,$01 Obstacle X: #N(#PEEK(#PC)).
B $6F04,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6EFD,$08,$02

g $6F0D Door: #N$54 / #N$90
@ $6F0D label=Door_54_90
D $6F0D The cave doorway between the bottom wall of room #N$54 and the top wall
. of room #N$90.
B $6F0D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6F0E,$01 Room: #N(#PEEK(#PC)).
B $6F0F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6F10,$01 X position: #N(#PEEK(#PC)).
B $6F11,$01 Y position: #N(#PEEK(#PC)).
B $6F12,$01 Attribute: #N(#PEEK(#PC)).
B $6F13,$01 Obstacle X: #N(#PEEK(#PC)).
B $6F14,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6F0D,$08,$02

g $6F1D Door: #N$90 / #N$91
@ $6F1D label=Door_90_91
D $6F1D The cave doorway between the bottom wall of room #N$90 and the top wall
. of room #N$91.
B $6F1D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6F1E,$01 Room: #N(#PEEK(#PC)).
B $6F1F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6F20,$01 X position: #N(#PEEK(#PC)).
B $6F21,$01 Y position: #N(#PEEK(#PC)).
B $6F22,$01 Attribute: #N(#PEEK(#PC)).
B $6F23,$01 Obstacle X: #N(#PEEK(#PC)).
B $6F24,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6F1D,$08,$02

g $6F2D Door: #N$91 / #N$92
@ $6F2D label=Door_91_92
D $6F2D The cave doorway between the right wall of room #N$91 and the left wall
. of room #N$92.
B $6F2D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6F2E,$01 Room: #N(#PEEK(#PC)).
B $6F2F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6F30,$01 X position: #N(#PEEK(#PC)).
B $6F31,$01 Y position: #N(#PEEK(#PC)).
B $6F32,$01 Attribute: #N(#PEEK(#PC)).
B $6F33,$01 Obstacle X: #N(#PEEK(#PC)).
B $6F34,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6F2D,$08,$02

g $6F3D Door: #N$92 / #N$93
@ $6F3D label=Door_92_93
D $6F3D The cave doorway between the right wall of room #N$92 and the left wall
. of room #N$93.
B $6F3D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6F3E,$01 Room: #N(#PEEK(#PC)).
B $6F3F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6F40,$01 X position: #N(#PEEK(#PC)).
B $6F41,$01 Y position: #N(#PEEK(#PC)).
B $6F42,$01 Attribute: #N(#PEEK(#PC)).
B $6F43,$01 Obstacle X: #N(#PEEK(#PC)).
B $6F44,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6F3D,$08,$02

g $6F4D Door: #N$93 / #N$94
@ $6F4D label=Door_93_94
D $6F4D The cave doorway between the right wall of room #N$93 and the left wall
. of room #N$94.
B $6F4D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6F4E,$01 Room: #N(#PEEK(#PC)).
B $6F4F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6F50,$01 X position: #N(#PEEK(#PC)).
B $6F51,$01 Y position: #N(#PEEK(#PC)).
B $6F52,$01 Attribute: #N(#PEEK(#PC)).
B $6F53,$01 Obstacle X: #N(#PEEK(#PC)).
B $6F54,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6F4D,$08,$02

g $6F5D Door: #N$3A / #N$94
@ $6F5D label=Door_3A_94
D $6F5D The cave doorway between the top wall of room #N$3A and the bottom wall
. of room #N$94.
B $6F5D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6F5E,$01 Room: #N(#PEEK(#PC)).
B $6F5F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6F60,$01 X position: #N(#PEEK(#PC)).
B $6F61,$01 Y position: #N(#PEEK(#PC)).
B $6F62,$01 Attribute: #N(#PEEK(#PC)).
B $6F63,$01 Obstacle X: #N(#PEEK(#PC)).
B $6F64,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6F5D,$08,$02

g $6F6D Trapdoor: #N$73 / #N$74
@ $6F6D label=Trapdoor_73_74
D $6F6D The trapdoor in room #N$73, which starts open, and the rug in room #N$74
. that the player lands on when they fall through it (see #R$91C5).
B $6F6D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6F6E,$01 Room: #N(#PEEK(#PC)).
B $6F6F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6F70,$01 X position: #N(#PEEK(#PC)).
B $6F71,$01 Y position: #N(#PEEK(#PC)).
B $6F72,$01 Attribute: #N(#PEEK(#PC)).
B $6F73,$01 Obstacle X: #N(#PEEK(#PC)).
B $6F74,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6F6D,$08,$02

g $6F7D Trapdoor: #N$03 / #N$65
@ $6F7D label=Trapdoor_03_65
D $6F7D The trapdoor in room #N$03, which starts open, and the rug in room #N$65
. that the player lands on when they fall through it (see #R$91C5).
B $6F7D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6F7E,$01 Room: #N(#PEEK(#PC)).
B $6F7F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6F80,$01 X position: #N(#PEEK(#PC)).
B $6F81,$01 Y position: #N(#PEEK(#PC)).
B $6F82,$01 Attribute: #N(#PEEK(#PC)).
B $6F83,$01 Obstacle X: #N(#PEEK(#PC)).
B $6F84,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6F7D,$08,$02

g $6F8D Trapdoor: #N$61 / #N$4B
@ $6F8D label=Trapdoor_61_4B
D $6F8D The trapdoor in room #N$61, which starts open, and the rug in room #N$4B
. that the player lands on when they fall through it (see #R$91C5).
B $6F8D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6F8E,$01 Room: #N(#PEEK(#PC)).
B $6F8F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6F90,$01 X position: #N(#PEEK(#PC)).
B $6F91,$01 Y position: #N(#PEEK(#PC)).
B $6F92,$01 Attribute: #N(#PEEK(#PC)).
B $6F93,$01 Obstacle X: #N(#PEEK(#PC)).
B $6F94,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6F8D,$08,$02

g $6F9D Trapdoor: #N$2D / #N$8D
@ $6F9D label=Trapdoor_2D_8D
D $6F9D The trapdoor in room #N$2D, which starts open, and the rug in room #N$8D
. that the player lands on when they fall through it (see #R$91C5).
B $6F9D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6F9E,$01 Room: #N(#PEEK(#PC)).
B $6F9F,$01 Exit offsets: #N(#PEEK(#PC)).
B $6FA0,$01 X position: #N(#PEEK(#PC)).
B $6FA1,$01 Y position: #N(#PEEK(#PC)).
B $6FA2,$01 Attribute: #N(#PEEK(#PC)).
B $6FA3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6FA4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6F9D,$08,$02

g $6FAD Trapdoor: #N$76 / #N$84
@ $6FAD label=Trapdoor_76_84
D $6FAD The trapdoor in room #N$76, which starts open, and the rug in room #N$84
. that the player lands on when they fall through it (see #R$91C5).
B $6FAD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6FAE,$01 Room: #N(#PEEK(#PC)).
B $6FAF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6FB0,$01 X position: #N(#PEEK(#PC)).
B $6FB1,$01 Y position: #N(#PEEK(#PC)).
B $6FB2,$01 Attribute: #N(#PEEK(#PC)).
B $6FB3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6FB4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6FAD,$08,$02

g $6FBD Trapdoor: #N$8B / #N$6C
@ $6FBD label=Trapdoor_8B_6C
D $6FBD The trapdoor in room #N$8B, which starts open, and the rug in room #N$6C
. that the player lands on when they fall through it (see #R$91C5).
B $6FBD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6FBE,$01 Room: #N(#PEEK(#PC)).
B $6FBF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6FC0,$01 X position: #N(#PEEK(#PC)).
B $6FC1,$01 Y position: #N(#PEEK(#PC)).
B $6FC2,$01 Attribute: #N(#PEEK(#PC)).
B $6FC3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6FC4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6FBD,$08,$02

g $6FCD Trapdoor: #N$8D / #N$6E
@ $6FCD label=Trapdoor_8D_6E
D $6FCD The trapdoor in room #N$8D, which starts open, and the rug in room #N$6E
. that the player lands on when they fall through it (see #R$91C5).
B $6FCD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6FCE,$01 Room: #N(#PEEK(#PC)).
B $6FCF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6FD0,$01 X position: #N(#PEEK(#PC)).
B $6FD1,$01 Y position: #N(#PEEK(#PC)).
B $6FD2,$01 Attribute: #N(#PEEK(#PC)).
B $6FD3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6FD4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6FCD,$08,$02

g $6FDD Trapdoor: #N$21 / #N$03
@ $6FDD label=Trapdoor_21_03
D $6FDD The trapdoor in room #N$21, which starts open, and the rug in room #N$03
. that the player lands on when they fall through it (see #R$91C5).
B $6FDD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6FDE,$01 Room: #N(#PEEK(#PC)).
B $6FDF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6FE0,$01 X position: #N(#PEEK(#PC)).
B $6FE1,$01 Y position: #N(#PEEK(#PC)).
B $6FE2,$01 Attribute: #N(#PEEK(#PC)).
B $6FE3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6FE4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6FDD,$08,$02

g $6FED Trapdoor: #N$15 / #N$66
@ $6FED label=Trapdoor_15_66
D $6FED The trapdoor in room #N$15, which starts open, and the rug in room #N$66
. that the player lands on when they fall through it (see #R$91C5).
B $6FED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6FEE,$01 Room: #N(#PEEK(#PC)).
B $6FEF,$01 Exit offsets: #N(#PEEK(#PC)).
B $6FF0,$01 X position: #N(#PEEK(#PC)).
B $6FF1,$01 Y position: #N(#PEEK(#PC)).
B $6FF2,$01 Attribute: #N(#PEEK(#PC)).
B $6FF3,$01 Obstacle X: #N(#PEEK(#PC)).
B $6FF4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6FED,$08,$02

g $6FFD Trapdoor: #N$78 / #N$8A
@ $6FFD label=Trapdoor_78_8A
D $6FFD The trapdoor in room #N$78, which starts open, and the rug in room #N$8A
. that the player lands on when they fall through it (see #R$91C5).
B $6FFD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $6FFE,$01 Room: #N(#PEEK(#PC)).
B $6FFF,$01 Exit offsets: #N(#PEEK(#PC)).
B $7000,$01 X position: #N(#PEEK(#PC)).
B $7001,$01 Y position: #N(#PEEK(#PC)).
B $7002,$01 Attribute: #N(#PEEK(#PC)).
B $7003,$01 Obstacle X: #N(#PEEK(#PC)).
B $7004,$01 Obstacle Y: #N(#PEEK(#PC)).
L $6FFD,$08,$02

g $700D Trapdoor: #N$29 / #N$09
@ $700D label=Trapdoor_29_09
D $700D The trapdoor in room #N$29, which starts open, and the rug in room #N$09
. that the player lands on when they fall through it (see #R$91C5).
B $700D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $700E,$01 Room: #N(#PEEK(#PC)).
B $700F,$01 Exit offsets: #N(#PEEK(#PC)).
B $7010,$01 X position: #N(#PEEK(#PC)).
B $7011,$01 Y position: #N(#PEEK(#PC)).
B $7012,$01 Attribute: #N(#PEEK(#PC)).
B $7013,$01 Obstacle X: #N(#PEEK(#PC)).
B $7014,$01 Obstacle Y: #N(#PEEK(#PC)).
L $700D,$08,$02

g $701D Ghost Picture Items
@ $701D label=RoomItems_GhostPictures
D $701D Two pictures of ghosts, which do nothing (see #R$91FE).
B $701D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $701E,$01 Room: #N(#PEEK(#PC)).
B $701F,$01 Not used.
B $7020,$01 X position: #N(#PEEK(#PC)).
B $7021,$01 Y position: #N(#PEEK(#PC)).
B $7022,$01 Attribute: #N(#PEEK(#PC)).
B $7023,$01 Obstacle X: #N(#PEEK(#PC)).
B $7024,$01 Obstacle Y: #N(#PEEK(#PC)).
L $701D,$08,$02

g $702D Barrel Stack Items
@ $702D label=RoomItems_BarrelStacks
D $702D Two stacks of barrels, which do nothing (see #R$91FE).
B $702D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $702E,$01 Room: #N(#PEEK(#PC)).
B $702F,$01 Not used.
B $7030,$01 X position: #N(#PEEK(#PC)).
B $7031,$01 Y position: #N(#PEEK(#PC)).
B $7032,$01 Attribute: #N(#PEEK(#PC)).
B $7033,$01 Obstacle X: #N(#PEEK(#PC)).
B $7034,$01 Obstacle Y: #N(#PEEK(#PC)).
L $702D,$08,$02

g $703D Suit Of Armour Items
@ $703D label=RoomItems_SuitsOfArmour
D $703D The suits of armour in the rooms, which do nothing (see #R$91FE).
B $703D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $703E,$01 Room: #N(#PEEK(#PC)).
B $703F,$01 Not used.
B $7040,$01 X position: #N(#PEEK(#PC)).
B $7041,$01 Y position: #N(#PEEK(#PC)).
B $7042,$01 Attribute: #N(#PEEK(#PC)).
B $7043,$01 Obstacle X: #N(#PEEK(#PC)).
B $7044,$01 Obstacle Y: #N(#PEEK(#PC)).
L $703D,$08,$24

g $715D Table Items
@ $715D label=RoomItems_Tables
D $715D The tables in the rooms. The obstacle rectangle for each one stops the
. player from walking through it (see #R$900A).
B $715D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $715E,$01 Room: #N(#PEEK(#PC)).
B $715F,$01 Not used.
B $7160,$01 X position: #N(#PEEK(#PC)).
B $7161,$01 Y position: #N(#PEEK(#PC)).
B $7162,$01 Attribute: #N(#PEEK(#PC)).
B $7163,$01 Obstacle X: #N(#PEEK(#PC)).
B $7164,$01 Obstacle Y: #N(#PEEK(#PC)).
L $715D,$08,$16

g $720D Wall Decoration Items
@ $720D label=RoomItems_Decorations
D $720D The shields, antlers, trophies and pictures on the walls of the rooms,
. which do nothing (see #R$91FE).
B $720D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $720E,$01 Room: #N(#PEEK(#PC)).
B $720F,$01 Not used.
B $7210,$01 X position: #N(#PEEK(#PC)).
B $7211,$01 Y position: #N(#PEEK(#PC)).
B $7212,$01 Attribute: #N(#PEEK(#PC)).
B $7213,$01 Obstacle X: #N(#PEEK(#PC)).
B $7214,$01 Obstacle Y: #N(#PEEK(#PC)).
L $720D,$08,$48

g $744D Clock: #N$0D / #N$13
@ $744D label=Clock_0D_13
D $744D The clock in room #N$0D and the clock in room #N$13. Together they are a
. secret door that only the knight can use (see #R$942F).
B $744D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $744E,$01 Room: #N(#PEEK(#PC)).
B $744F,$01 Exit offsets: #N(#PEEK(#PC)).
B $7450,$01 X position: #N(#PEEK(#PC)).
B $7451,$01 Y position: #N(#PEEK(#PC)).
B $7452,$01 Attribute: #N(#PEEK(#PC)).
B $7453,$01 Obstacle X: #N(#PEEK(#PC)).
B $7454,$01 Obstacle Y: #N(#PEEK(#PC)).
L $744D,$08,$02

g $745D Clock: #N$09 / #N$17
@ $745D label=Clock_09_17
D $745D The clock in room #N$09 and the clock in room #N$17. Together they are a
. secret door that only the knight can use (see #R$942F).
B $745D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $745E,$01 Room: #N(#PEEK(#PC)).
B $745F,$01 Exit offsets: #N(#PEEK(#PC)).
B $7460,$01 X position: #N(#PEEK(#PC)).
B $7461,$01 Y position: #N(#PEEK(#PC)).
B $7462,$01 Attribute: #N(#PEEK(#PC)).
B $7463,$01 Obstacle X: #N(#PEEK(#PC)).
B $7464,$01 Obstacle Y: #N(#PEEK(#PC)).
L $745D,$08,$02

g $746D Clock: #N$35 / #N$8F
@ $746D label=Clock_35_8F
D $746D The clock in room #N$35 and the clock in room #N$8F. Together they are a
. secret door that only the knight can use (see #R$942F).
B $746D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $746E,$01 Room: #N(#PEEK(#PC)).
B $746F,$01 Exit offsets: #N(#PEEK(#PC)).
B $7470,$01 X position: #N(#PEEK(#PC)).
B $7471,$01 Y position: #N(#PEEK(#PC)).
B $7472,$01 Attribute: #N(#PEEK(#PC)).
B $7473,$01 Obstacle X: #N(#PEEK(#PC)).
B $7474,$01 Obstacle Y: #N(#PEEK(#PC)).
L $746D,$08,$02

g $747D Clock: #N$67 / #N$68
@ $747D label=Clock_67_68
D $747D The clock in room #N$67 and the clock in room #N$68. Together they are a
. secret door that only the knight can use (see #R$942F).
B $747D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $747E,$01 Room: #N(#PEEK(#PC)).
B $747F,$01 Exit offsets: #N(#PEEK(#PC)).
B $7480,$01 X position: #N(#PEEK(#PC)).
B $7481,$01 Y position: #N(#PEEK(#PC)).
B $7482,$01 Attribute: #N(#PEEK(#PC)).
B $7483,$01 Obstacle X: #N(#PEEK(#PC)).
B $7484,$01 Obstacle Y: #N(#PEEK(#PC)).
L $747D,$08,$02

g $748D Clock: #N$8D / #N$22
@ $748D label=Clock_8D_22
D $748D The clock in room #N$8D and the clock in room #N$22. Together they are a
. secret door that only the knight can use (see #R$942F).
B $748D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $748E,$01 Room: #N(#PEEK(#PC)).
B $748F,$01 Exit offsets: #N(#PEEK(#PC)).
B $7490,$01 X position: #N(#PEEK(#PC)).
B $7491,$01 Y position: #N(#PEEK(#PC)).
B $7492,$01 Attribute: #N(#PEEK(#PC)).
B $7493,$01 Obstacle X: #N(#PEEK(#PC)).
B $7494,$01 Obstacle Y: #N(#PEEK(#PC)).
L $748D,$08,$02

g $749D Clock: #N$76 / #N$75
@ $749D label=Clock_76_75
D $749D The clock in room #N$76 and the clock in room #N$75. Together they are a
. secret door that only the knight can use (see #R$942F).
B $749D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $749E,$01 Room: #N(#PEEK(#PC)).
B $749F,$01 Exit offsets: #N(#PEEK(#PC)).
B $74A0,$01 X position: #N(#PEEK(#PC)).
B $74A1,$01 Y position: #N(#PEEK(#PC)).
B $74A2,$01 Attribute: #N(#PEEK(#PC)).
B $74A3,$01 Obstacle X: #N(#PEEK(#PC)).
B $74A4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $749D,$08,$02

g $74AD Bookcase: #N$0A / #N$16
@ $74AD label=Bookcase_0A_16
D $74AD The bookcase in room #N$0A and the bookcase in room #N$16. Together they
. are a secret door that only the wizard can use (see #R$9428).
B $74AD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $74AE,$01 Room: #N(#PEEK(#PC)).
B $74AF,$01 Exit offsets: #N(#PEEK(#PC)).
B $74B0,$01 X position: #N(#PEEK(#PC)).
B $74B1,$01 Y position: #N(#PEEK(#PC)).
B $74B2,$01 Attribute: #N(#PEEK(#PC)).
B $74B3,$01 Obstacle X: #N(#PEEK(#PC)).
B $74B4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $74AD,$08,$02

g $74BD Bookcase: #N$3D / #N$49
@ $74BD label=Bookcase_3D_49
D $74BD The bookcase in room #N$3D and the bookcase in room #N$49. Together they
. are a secret door that only the wizard can use (see #R$9428).
B $74BD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $74BE,$01 Room: #N(#PEEK(#PC)).
B $74BF,$01 Exit offsets: #N(#PEEK(#PC)).
B $74C0,$01 X position: #N(#PEEK(#PC)).
B $74C1,$01 Y position: #N(#PEEK(#PC)).
B $74C2,$01 Attribute: #N(#PEEK(#PC)).
B $74C3,$01 Obstacle X: #N(#PEEK(#PC)).
B $74C4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $74BD,$08,$02

g $74CD Bookcase: #N$69 / #N$6A
@ $74CD label=Bookcase_69_6A
D $74CD The bookcase in room #N$69 and the bookcase in room #N$6A. Together they
. are a secret door that only the wizard can use (see #R$9428).
B $74CD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $74CE,$01 Room: #N(#PEEK(#PC)).
B $74CF,$01 Exit offsets: #N(#PEEK(#PC)).
B $74D0,$01 X position: #N(#PEEK(#PC)).
B $74D1,$01 Y position: #N(#PEEK(#PC)).
B $74D2,$01 Attribute: #N(#PEEK(#PC)).
B $74D3,$01 Obstacle X: #N(#PEEK(#PC)).
B $74D4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $74CD,$08,$02

g $74DD Bookcase: #N$6C / #N$6E
@ $74DD label=Bookcase_6C_6E
D $74DD The bookcase in room #N$6C and the bookcase in room #N$6E. Together they
. are a secret door that only the wizard can use (see #R$9428).
B $74DD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $74DE,$01 Room: #N(#PEEK(#PC)).
B $74DF,$01 Exit offsets: #N(#PEEK(#PC)).
B $74E0,$01 X position: #N(#PEEK(#PC)).
B $74E1,$01 Y position: #N(#PEEK(#PC)).
B $74E2,$01 Attribute: #N(#PEEK(#PC)).
B $74E3,$01 Obstacle X: #N(#PEEK(#PC)).
B $74E4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $74DD,$08,$02

g $74ED Bookcase: #N$3E / #N$41
@ $74ED label=Bookcase_3E_41
D $74ED The bookcase in room #N$3E and the bookcase in room #N$41. Together they
. are a secret door that only the wizard can use (see #R$9428).
B $74ED,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $74EE,$01 Room: #N(#PEEK(#PC)).
B $74EF,$01 Exit offsets: #N(#PEEK(#PC)).
B $74F0,$01 X position: #N(#PEEK(#PC)).
B $74F1,$01 Y position: #N(#PEEK(#PC)).
B $74F2,$01 Attribute: #N(#PEEK(#PC)).
B $74F3,$01 Obstacle X: #N(#PEEK(#PC)).
B $74F4,$01 Obstacle Y: #N(#PEEK(#PC)).
L $74ED,$08,$02

g $74FD Barrel: #N$45 / #N$53
@ $74FD label=Barrel_45_53
D $74FD The barrel in room #N$45 and the barrel in room #N$53. Together they are
. a secret door that only the serf can use (see #R$9421).
B $74FD,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $74FE,$01 Room: #N(#PEEK(#PC)).
B $74FF,$01 Exit offsets: #N(#PEEK(#PC)).
B $7500,$01 X position: #N(#PEEK(#PC)).
B $7501,$01 Y position: #N(#PEEK(#PC)).
B $7502,$01 Attribute: #N(#PEEK(#PC)).
B $7503,$01 Obstacle X: #N(#PEEK(#PC)).
B $7504,$01 Obstacle Y: #N(#PEEK(#PC)).
L $74FD,$08,$02

g $750D Barrel: #N$4C / #N$4E
@ $750D label=Barrel_4C_4E
D $750D The barrel in room #N$4C and the barrel in room #N$4E. Together they are
. a secret door that only the serf can use (see #R$9421).
B $750D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $750E,$01 Room: #N(#PEEK(#PC)).
B $750F,$01 Exit offsets: #N(#PEEK(#PC)).
B $7510,$01 X position: #N(#PEEK(#PC)).
B $7511,$01 Y position: #N(#PEEK(#PC)).
B $7512,$01 Attribute: #N(#PEEK(#PC)).
B $7513,$01 Obstacle X: #N(#PEEK(#PC)).
B $7514,$01 Obstacle Y: #N(#PEEK(#PC)).
L $750D,$08,$02

g $751D Barrel: #N$38 / #N$4B
@ $751D label=Barrel_38_4B
D $751D The barrel in room #N$38 and the barrel in room #N$4B. Together they are
. a secret door that only the serf can use (see #R$9421).
B $751D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $751E,$01 Room: #N(#PEEK(#PC)).
B $751F,$01 Exit offsets: #N(#PEEK(#PC)).
B $7520,$01 X position: #N(#PEEK(#PC)).
B $7521,$01 Y position: #N(#PEEK(#PC)).
B $7522,$01 Attribute: #N(#PEEK(#PC)).
B $7523,$01 Obstacle X: #N(#PEEK(#PC)).
B $7524,$01 Obstacle Y: #N(#PEEK(#PC)).
L $751D,$08,$02

g $752D Barrel: #N$6B / #N$6D
@ $752D label=Barrel_6B_6D
D $752D The barrel in room #N$6B and the barrel in room #N$6D. Together they are
. a secret door that only the serf can use (see #R$9421).
B $752D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $752E,$01 Room: #N(#PEEK(#PC)).
B $752F,$01 Exit offsets: #N(#PEEK(#PC)).
B $7530,$01 X position: #N(#PEEK(#PC)).
B $7531,$01 Y position: #N(#PEEK(#PC)).
B $7532,$01 Attribute: #N(#PEEK(#PC)).
B $7533,$01 Obstacle X: #N(#PEEK(#PC)).
B $7534,$01 Obstacle Y: #N(#PEEK(#PC)).
L $752D,$08,$02

g $753D Barrel: #N$8A / #N$08
@ $753D label=Barrel_8A_08
D $753D The barrel in room #N$8A and the barrel in room #N$08. Together they are
. a secret door that only the serf can use (see #R$9421).
B $753D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $753E,$01 Room: #N(#PEEK(#PC)).
B $753F,$01 Exit offsets: #N(#PEEK(#PC)).
B $7540,$01 X position: #N(#PEEK(#PC)).
B $7541,$01 Y position: #N(#PEEK(#PC)).
B $7542,$01 Attribute: #N(#PEEK(#PC)).
B $7543,$01 Obstacle X: #N(#PEEK(#PC)).
B $7544,$01 Obstacle Y: #N(#PEEK(#PC)).
L $753D,$08,$02

g $754D A.C.G. Door: #N$00 / #N$8E
@ $754D label=ACGDoor_00_8E
D $754D The A.C.G. door in room #N$00 and the other half of it in room #N$8E
. (see #R$961B).
B $754D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $754E,$01 Room: #N(#PEEK(#PC)).
B $754F,$01 Exit offsets: #N(#PEEK(#PC)).
B $7550,$01 X position: #N(#PEEK(#PC)).
B $7551,$01 Y position: #N(#PEEK(#PC)).
B $7552,$01 Attribute: #N(#PEEK(#PC)).
B $7553,$01 Obstacle X: #N(#PEEK(#PC)).
B $7554,$01 Obstacle Y: #N(#PEEK(#PC)).
L $754D,$08,$02

g $755D Skeleton Items
@ $755D label=RoomItems_Skeletons
D $755D Four skeletons, which do nothing (see #R$91FE).
B $755D,$01 Graphic ID: #GRAPHICNAME(#PEEK(#PC) - $01).
B $755E,$01 Room: #N(#PEEK(#PC)).
B $755F,$01 Not used.
B $7560,$01 X position: #N(#PEEK(#PC)).
B $7561,$01 Y position: #N(#PEEK(#PC)).
B $7562,$01 Attribute: #N(#PEEK(#PC)).
B $7563,$01 Obstacle X: #N(#PEEK(#PC)).
B $7564,$01 Obstacle Y: #N(#PEEK(#PC)).
L $755D,$08,$04

b $757D Room Table
@ $757D label=RoomTable
D $757D The address of the list of items for each room, from #R$76A9 onwards.
. The table is indexed by the room ID, #N$00 to #N$94, and has one more entry
. for the room with no items. #R$7E23 and #R$900A both use it. The address of an
. item in a list is the address of its live record plus #N$757D (see #R$7E93).
W $757D,$02 Room ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#EVAL((#PC - $757D) / 2)).
L $757D,$02,$95
W $76A7,$02 Room ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(None).

w $76A9 Room: #N$00
@ $76A9 label=Room_00
D $76A9 The items in room #N$00. Each entry is the address of an item in #R$645D
. onwards (for a door, the address of both halves), and the list ends with
. #N$0000. #R$7E23 goes through the list for the room that the player is in, and
. #R$7E93 runs the handler of each item.
  $76A9,$02 #R$645D.
  $76AB,$02 #R$646D.
  $76AD,$02 #R$647D, opened by the cyan key.
  $76AF,$02 #R$754D.
  $76B1,$02 #R$705D(Suit Of Armour).
  $76B3,$02 #R$706D(Suit Of Armour).
  $76B5,$02 #R$728D(Pumpkin Picture).
  $76B7,$02 #R$729D(Ghost Picture).
  $76B9,$02 #R$72AD(A.C.G. Shield).
  $76BB,$02 #R$72BD(Wall Antlers).
  $76BD,$02 #R$735D(Wall Shield).
  $76BF,$02 #R$736D(Wall Trophy).
  $76C1,$02 Terminator.

w $76C3 Room: #N$01
@ $76C3 label=Room_01
D $76C3 The items in room #N$01.
  $76C3,$02 #R$647D, opened by the cyan key.
  $76C5,$02 #R$648D.
  $76C7,$02 #R$707D(Suit Of Armour).
  $76C9,$02 #R$731D(A.C.G. Shield).
  $76CB,$02 Terminator.

w $76CD Room: #N$02
@ $76CD label=Room_02
D $76CD The items in room #N$02.
  $76CD,$02 #R$648D.
  $76CF,$02 #R$649D.
  $76D1,$02 #R$661D.
  $76D3,$02 #R$66ED.
  $76D5,$02 Terminator.

w $76D7 Room: #N$03
@ $76D7 label=Room_03
D $76D7 The items in room #N$03.
  $76D7,$02 #R$649D.
  $76D9,$02 #R$64AD.
  $76DB,$02 #R$6C4D, opened by the cyan key.
  $76DD,$02 #R$6F7D.
  $76DF,$02 #R$6FDD.
  $76E1,$02 #R$707D(Suit Of Armour).
  $76E3,$02 Terminator.

w $76E5 Room: #N$04
@ $76E5 label=Room_04
D $76E5 The items in room #N$04.
  $76E5,$02 #R$64AD.
  $76E7,$02 #R$64BD.
  $76E9,$02 #R$64CD.
  $76EB,$02 #R$72CD(Ghost Picture).
  $76ED,$02 #R$72DD(Wall Trophy).
  $76EF,$02 Terminator.

w $76F1 Room: #N$05
@ $76F1 label=Room_05
D $76F1 The items in room #N$05.
  $76F1,$02 #R$64CD.
  $76F3,$02 #R$64DD.
  $76F5,$02 #R$6C7D.
  $76F7,$02 #R$708D(Suit Of Armour).
  $76F9,$02 Terminator.

w $76FB Room: #N$06
@ $76FB label=Room_06
D $76FB The items in room #N$06.
  $76FB,$02 #R$64DD.
  $76FD,$02 #R$64ED.
  $76FF,$02 #R$64FD, opened by the green key.
  $7701,$02 #R$650D.
  $7703,$02 #R$705D(Suit Of Armour).
  $7705,$02 #R$706D(Suit Of Armour).
  $7707,$02 #R$730D(Pumpkin Picture).
  $7709,$02 #R$731D(A.C.G. Shield).
  $770B,$02 Terminator.

w $770D Room: #N$07
@ $770D label=Room_07
D $770D The items in room #N$07.
  $770D,$02 #R$645D.
  $770F,$02 #R$650D.
  $7711,$02 #R$708D(Suit Of Armour).
  $7713,$02 #R$730D(Pumpkin Picture).
  $7715,$02 Terminator.

w $7717 Room: #N$08
@ $7717 label=Room_08
D $7717 The items in room #N$08.
  $7717,$02 #R$64FD, opened by the green key.
  $7719,$02 #R$651D.
  $771B,$02 #R$726D(A.C.G. Shield).
  $771D,$02 #R$753D.
  $771F,$02 Terminator.

w $7721 Room: #N$09
@ $7721 label=Room_09
D $7721 The items in room #N$09.
  $7721,$02 #R$651D.
  $7723,$02 #R$652D.
  $7725,$02 #R$700D.
  $7727,$02 #R$745D.
  $7729,$02 #R$713D(Suit Of Armour).
  $772B,$02 #R$714D(Suit Of Armour).
  $772D,$02 #R$73ED(Wall Trophy).
  $772F,$02 #R$73FD(Ghost Picture).
  $7731,$02 Terminator.

w $7733 Room: #N$0A
@ $7733 label=Room_0A
D $7733 The items in room #N$0A.
  $7733,$02 #R$652D.
  $7735,$02 #R$653D.
  $7737,$02 #R$74AD.
  $7739,$02 #R$72BD(Wall Antlers).
  $773B,$02 Terminator.

w $773D Room: #N$0B
@ $773D label=Room_0B
D $773D The items in room #N$0B.
  $773D,$02 #R$653D.
  $773F,$02 #R$654D.
  $7741,$02 #R$701D.
  $7743,$02 #R$729D(Ghost Picture).
  $7745,$02 Terminator.

w $7747 Room: #N$0C
@ $7747 label=Room_0C
D $7747 The items in room #N$0C.
  $7747,$02 #R$654D.
  $7749,$02 #R$655D.
  $774B,$02 #R$701D.
  $774D,$02 #R$73DD(Wall Shield).
  $774F,$02 Terminator.

w $7751 Room: #N$0D
@ $7751 label=Room_0D
D $7751 The items in room #N$0D.
  $7751,$02 #R$655D.
  $7753,$02 #R$656D.
  $7755,$02 #R$6C8D, opened by the cyan key.
  $7757,$02 #R$744D.
  $7759,$02 #R$715D.
  $775B,$02 #R$73CD(Wall Trophy).
  $775D,$02 Terminator.

w $775F Room: #N$0E
@ $775F label=Room_0E
D $775F The items in room #N$0E.
  $775F,$02 #R$656D.
  $7761,$02 #R$657D.
  $7763,$02 #R$723D(Wall Antlers).
  $7765,$02 #R$727D(Wall Antlers).
  $7767,$02 #R$72FD(A.C.G. Shield).
  $7769,$02 Terminator.

w $776B Room: #N$0F
@ $776B label=Room_0F
D $776B The items in room #N$0F.
  $776B,$02 #R$657D.
  $776D,$02 #R$658D.
  $776F,$02 #R$6C5D, opened by the green key.
  $7771,$02 #R$724D(A.C.G. Shield).
  $7773,$02 Terminator.

w $7775 Room: #N$10
@ $7775 label=Room_10
D $7775 The items in room #N$10.
  $7775,$02 #R$658D.
  $7777,$02 #R$659D, opened by the red key.
  $7779,$02 #R$725D(Wall Antlers).
  $777B,$02 Terminator.

w $777D Room: #N$11
@ $777D label=Room_11
D $777D The items in room #N$11.
  $777D,$02 #R$659D, opened by the red key.
  $777F,$02 #R$65AD.
  $7781,$02 #R$6C2D.
  $7783,$02 #R$724D(A.C.G. Shield).
  $7785,$02 Terminator.

w $7787 Room: #N$12
@ $7787 label=Room_12
D $7787 The items in room #N$12.
  $7787,$02 #R$65AD.
  $7789,$02 #R$65BD.
  $778B,$02 #R$723D(Wall Antlers).
  $778D,$02 Terminator.

w $778F Room: #N$13
@ $778F label=Room_13
D $778F The items in room #N$13.
  $778F,$02 #R$65BD.
  $7791,$02 #R$65CD.
  $7793,$02 #R$6C1D.
  $7795,$02 #R$715D.
  $7797,$02 #R$744D.
  $7799,$02 #R$70AD(Suit Of Armour).
  $779B,$02 Terminator.

w $779D Room: #N$14
@ $779D label=Room_14
D $779D The items in room #N$14.
  $779D,$02 #R$65CD.
  $779F,$02 #R$65DD.
  $77A1,$02 #R$722D(A.C.G. Shield).
  $77A3,$02 #R$72DD(Wall Trophy).
  $77A5,$02 Terminator.

w $77A7 Room: #N$15
@ $77A7 label=Room_15
D $77A7 The items in room #N$15.
  $77A7,$02 #R$65DD.
  $77A9,$02 #R$65ED.
  $77AB,$02 #R$6FED.
  $77AD,$02 #R$72CD(Ghost Picture).
  $77AF,$02 #R$709D(Suit Of Armour).
  $77B1,$02 #R$70AD(Suit Of Armour).
  $77B3,$02 Terminator.

w $77B5 Room: #N$16
@ $77B5 label=Room_16
D $77B5 The items in room #N$16.
  $77B5,$02 #R$65ED.
  $77B7,$02 #R$65FD, opened by the red key.
  $77B9,$02 #R$722D(A.C.G. Shield).
  $77BB,$02 #R$74AD.
  $77BD,$02 Terminator.

w $77BF Room: #N$17
@ $77BF label=Room_17
D $77BF The items in room #N$17.
  $77BF,$02 #R$65FD, opened by the red key.
  $77C1,$02 #R$660D, opened by the green key.
  $77C3,$02 #R$745D.
  $77C5,$02 #R$732D(Ghost Picture).
  $77C7,$02 #R$709D(Suit Of Armour).
  $77C9,$02 Terminator.

w $77CB Room: #N$18
@ $77CB label=Room_18
D $77CB The items in room #N$18.
  $77CB,$02 #R$660D, opened by the green key.
  $77CD,$02 #R$661D.
  $77CF,$02 #R$726D(A.C.G. Shield).
  $77D1,$02 #R$717D(Table).
  $77D3,$02 #R$719D(Table).
  $77D5,$02 #R$732D(Ghost Picture).
  $77D7,$02 Terminator.

w $77D9 Room: #N$19
@ $77D9 label=Room_19
D $77D9 The items in room #N$19.
  $77D9,$02 #R$646D.
  $77DB,$02 #R$64BD.
  $77DD,$02 #R$728D(Pumpkin Picture).
  $77DF,$02 #R$72AD(A.C.G. Shield).
  $77E1,$02 Terminator.

w $77E3 Room: #N$1A
@ $77E3 label=Room_1A
D $77E3 The items in room #N$1A.
  $77E3,$02 #R$64ED.
  $77E5,$02 #R$662D.
  $77E7,$02 Terminator.

w $77E9 Room: #N$1B
@ $77E9 label=Room_1B
D $77E9 The items in room #N$1B.
  $77E9,$02 #R$662D.
  $77EB,$02 #R$663D.
  $77ED,$02 #R$6EED.
  $77EF,$02 #R$71BD(Table).
  $77F1,$02 Terminator.

w $77F3 Room: #N$1C
@ $77F3 label=Room_1C
D $77F3 The items in room #N$1C.
  $77F3,$02 #R$663D.
  $77F5,$02 #R$664D.
  $77F7,$02 Terminator.

w $77F9 Room: #N$1D
@ $77F9 label=Room_1D
D $77F9 The items in room #N$1D.
  $77F9,$02 #R$664D.
  $77FB,$02 #R$69ED.
  $77FD,$02 Terminator.

w $77FF Room: #N$1E
@ $77FF label=Room_1E
D $77FF The items in room #N$1E.
  $77FF,$02 #R$665D.
  $7801,$02 #R$66CD, opened by the cyan key.
  $7803,$02 Terminator.

w $7805 Room: #N$1F
@ $7805 label=Room_1F
D $7805 The items in room #N$1F.
  $7805,$02 #R$665D.
  $7807,$02 #R$666D.
  $7809,$02 #R$703D.
  $780B,$02 Terminator.

w $780D Room: #N$20
@ $780D label=Room_20
D $780D The items in room #N$20.
  $780D,$02 #R$666D.
  $780F,$02 #R$667D.
  $7811,$02 #R$678D, opened by the yellow key.
  $7813,$02 Terminator.

w $7815 Room: #N$21
@ $7815 label=Room_21
D $7815 The items in room #N$21.
  $7815,$02 #R$667D.
  $7817,$02 #R$668D.
  $7819,$02 #R$6AFD.
  $781B,$02 #R$6FDD.
  $781D,$02 #R$703D.
  $781F,$02 Terminator.

w $7821 Room: #N$22
@ $7821 label=Room_22
D $7821 The items in room #N$22.
  $7821,$02 #R$668D.
  $7823,$02 #R$669D.
  $7825,$02 #R$748D.
  $7827,$02 Terminator.

w $7829 Room: #N$23
@ $7829 label=Room_23
D $7829 The items in room #N$23.
  $7829,$02 #R$669D.
  $782B,$02 #R$66AD.
  $782D,$02 #R$6C0D, opened by the green key.
  $782F,$02 #R$704D(Suit Of Armour).
  $7831,$02 Terminator.

w $7833 Room: #N$24
@ $7833 label=Room_24
D $7833 The items in room #N$24.
  $7833,$02 #R$66AD.
  $7835,$02 #R$66BD.
  $7837,$02 #R$66DD.
  $7839,$02 #R$70FD(Suit Of Armour).
  $783B,$02 #R$710D(Suit Of Armour).
  $783D,$02 Terminator.

w $783F Room: #N$25
@ $783F label=Room_25
D $783F The items in room #N$25.
  $783F,$02 #R$66BD.
  $7841,$02 #R$66CD, opened by the cyan key.
  $7843,$02 #R$704D(Suit Of Armour).
  $7845,$02 Terminator.

w $7847 Room: #N$26
@ $7847 label=Room_26
D $7847 The items in room #N$26.
  $7847,$02 #R$66DD.
  $7849,$02 #R$66ED.
  $784B,$02 Terminator.

w $784D Room: #N$27
@ $784D label=Room_27
D $784D The items in room #N$27.
  $784D,$02 #R$66FD.
  $784F,$02 #R$676D.
  $7851,$02 #R$677D.
  $7853,$02 #R$70DD(Suit Of Armour).
  $7855,$02 #R$70ED(Suit Of Armour).
  $7857,$02 #R$740D(Wall Antlers).
  $7859,$02 #R$741D(Wall Trophy).
  $785B,$02 Terminator.

w $785D Room: #N$28
@ $785D label=Room_28
D $785D The items in room #N$28.
  $785D,$02 #R$66FD.
  $785F,$02 #R$670D, opened by the cyan key.
  $7861,$02 Terminator.

w $7863 Room: #N$29
@ $7863 label=Room_29
D $7863 The items in room #N$29.
  $7863,$02 #R$670D, opened by the cyan key.
  $7865,$02 #R$671D.
  $7867,$02 #R$6AED.
  $7869,$02 #R$700D.
  $786B,$02 #R$742D(A.C.G. Shield).
  $786D,$02 #R$743D(Ghost Picture).
  $786F,$02 Terminator.

w $7871 Room: #N$2A
@ $7871 label=Room_2A
D $7871 The items in room #N$2A.
  $7871,$02 #R$671D.
  $7873,$02 #R$672D.
  $7875,$02 #R$71ED(Table).
  $7877,$02 #R$71FD(Table).
  $7879,$02 Terminator.

w $787B Room: #N$2B
@ $787B label=Room_2B
D $787B The items in room #N$2B.
  $787B,$02 #R$672D.
  $787D,$02 #R$673D.
  $787F,$02 #R$70DD(Suit Of Armour).
  $7881,$02 #R$70ED(Suit Of Armour).
  $7883,$02 Terminator.

w $7885 Room: #N$2C
@ $7885 label=Room_2C
D $7885 The items in room #N$2C.
  $7885,$02 #R$673D.
  $7887,$02 #R$674D.
  $7889,$02 Terminator.

w $788B Room: #N$2D
@ $788B label=Room_2D
D $788B The items in room #N$2D.
  $788B,$02 #R$674D.
  $788D,$02 #R$675D, opened by the green key.
  $788F,$02 #R$6A3D.
  $7891,$02 #R$6F9D.
  $7893,$02 #R$71ED(Table).
  $7895,$02 #R$71FD(Table).
  $7897,$02 Terminator.

w $7899 Room: #N$2E
@ $7899 label=Room_2E
D $7899 The items in room #N$2E.
  $7899,$02 #R$675D, opened by the green key.
  $789B,$02 #R$676D.
  $789D,$02 #R$71CD(Table).
  $789F,$02 #R$71DD(Table).
  $78A1,$02 Terminator.

w $78A3 Room: #N$2F
@ $78A3 label=Room_2F
D $78A3 The items in room #N$2F.
  $78A3,$02 #R$677D.
  $78A5,$02 #R$678D, opened by the yellow key.
  $78A7,$02 Terminator.

w $78A9 Room: #N$30
@ $78A9 label=Room_30
D $78A9 The items in room #N$30.
  $78A9,$02 #R$679D.
  $78AB,$02 #R$6A2D.
  $78AD,$02 #R$6CDD.
  $78AF,$02 Terminator.

w $78B1 Room: #N$31
@ $78B1 label=Room_31
D $78B1 The items in room #N$31.
  $78B1,$02 #R$679D.
  $78B3,$02 #R$67AD.
  $78B5,$02 Terminator.

w $78B7 Room: #N$32
@ $78B7 label=Room_32
D $78B7 The items in room #N$32.
  $78B7,$02 #R$67AD.
  $78B9,$02 #R$67BD.
  $78BB,$02 Terminator.

w $78BD Room: #N$33
@ $78BD label=Room_33
D $78BD The items in room #N$33.
  $78BD,$02 #R$67BD.
  $78BF,$02 #R$67CD.
  $78C1,$02 #R$67ED.
  $78C3,$02 #R$756D(Skeleton).
  $78C5,$02 Terminator.

w $78C7 Room: #N$34
@ $78C7 label=Room_34
D $78C7 The items in room #N$34.
  $78C7,$02 #R$67CD.
  $78C9,$02 #R$67DD.
  $78CB,$02 Terminator.

w $78CD Room: #N$35
@ $78CD label=Room_35
D $78CD The items in room #N$35.
  $78CD,$02 #R$67DD.
  $78CF,$02 #R$6CCD.
  $78D1,$02 #R$746D.
  $78D3,$02 Terminator.

w $78D5 Room: #N$36
@ $78D5 label=Room_36
D $78D5 The items in room #N$36.
  $78D5,$02 #R$67ED.
  $78D7,$02 #R$67FD.
  $78D9,$02 Terminator.

w $78DB Room: #N$37
@ $78DB label=Room_37
D $78DB The items in room #N$37.
  $78DB,$02 #R$67FD.
  $78DD,$02 #R$680D.
  $78DF,$02 Terminator.

w $78E1 Room: #N$38
@ $78E1 label=Room_38
D $78E1 The items in room #N$38.
  $78E1,$02 #R$680D.
  $78E3,$02 #R$681D.
  $78E5,$02 #R$682D, opened by the green key.
  $78E7,$02 #R$751D.
  $78E9,$02 Terminator.

w $78EB Room: #N$39
@ $78EB label=Room_39
D $78EB The items in room #N$39.
  $78EB,$02 #R$681D.
  $78ED,$02 #R$683D.
  $78EF,$02 Terminator.

w $78F1 Room: #N$3A
@ $78F1 label=Room_3A
D $78F1 The items in room #N$3A.
  $78F1,$02 #R$682D, opened by the green key.
  $78F3,$02 #R$684D.
  $78F5,$02 #R$6F5D.
  $78F7,$02 Terminator.

w $78F9 Room: #N$3B
@ $78F9 label=Room_3B
D $78F9 The items in room #N$3B.
  $78F9,$02 #R$683D.
  $78FB,$02 #R$684D.
  $78FD,$02 #R$685D, opened by the green key.
  $78FF,$02 #R$686D.
  $7901,$02 Terminator.

w $7903 Room: #N$3C
@ $7903 label=Room_3C
D $7903 The items in room #N$3C.
  $7903,$02 #R$685D, opened by the green key.
  $7905,$02 #R$687D.
  $7907,$02 Terminator.

w $7909 Room: #N$3D
@ $7909 label=Room_3D
D $7909 The items in room #N$3D.
  $7909,$02 #R$686D.
  $790B,$02 #R$688D.
  $790D,$02 #R$689D, opened by the cyan key.
  $790F,$02 #R$74BD.
  $7911,$02 #R$702D.
  $7913,$02 Terminator.

w $7915 Room: #N$3E
@ $7915 label=Room_3E
D $7915 The items in room #N$3E.
  $7915,$02 #R$687D.
  $7917,$02 #R$688D.
  $7919,$02 #R$74ED.
  $791B,$02 Terminator.

w $791D Room: #N$3F
@ $791D label=Room_3F
D $791D The items in room #N$3F.
  $791D,$02 #R$689D, opened by the cyan key.
  $791F,$02 #R$68AD.
  $7921,$02 Terminator.

w $7923 Room: #N$40
@ $7923 label=Room_40
D $7923 The items in room #N$40.
  $7923,$02 #R$68AD.
  $7925,$02 #R$68BD.
  $7927,$02 #R$68CD.
  $7929,$02 #R$6EFD.
  $792B,$02 Terminator.

w $792D Room: #N$41
@ $792D label=Room_41
D $792D The items in room #N$41.
  $792D,$02 #R$68BD.
  $792F,$02 #R$74ED.
  $7931,$02 Terminator.

w $7933 Room: #N$42
@ $7933 label=Room_42
D $7933 The items in room #N$42.
  $7933,$02 #R$68CD.
  $7935,$02 #R$68DD.
  $7937,$02 Terminator.

w $7939 Room: #N$43
@ $7939 label=Room_43
D $7939 The items in room #N$43.
  $7939,$02 #R$68DD.
  $793B,$02 #R$68ED.
  $793D,$02 #R$690D.
  $793F,$02 #R$69ED.
  $7941,$02 Terminator.

w $7943 Room: #N$44
@ $7943 label=Room_44
D $7943 The items in room #N$44.
  $7943,$02 #R$68ED.
  $7945,$02 #R$68FD, opened by the red key.
  $7947,$02 Terminator.

w $7949 Room: #N$45
@ $7949 label=Room_45
D $7949 The items in room #N$45.
  $7949,$02 #R$68FD, opened by the red key.
  $794B,$02 #R$74FD.
  $794D,$02 Terminator.

w $794F Room: #N$46
@ $794F label=Room_46
D $794F The items in room #N$46.
  $794F,$02 #R$690D.
  $7951,$02 #R$691D.
  $7953,$02 #R$69FD.
  $7955,$02 Terminator.

w $7957 Room: #N$47
@ $7957 label=Room_47
D $7957 The items in room #N$47.
  $7957,$02 #R$691D.
  $7959,$02 #R$692D, opened by the red key.
  $795B,$02 Terminator.

w $795D Room: #N$48
@ $795D label=Room_48
D $795D The items in room #N$48.
  $795D,$02 #R$692D, opened by the red key.
  $795F,$02 #R$693D.
  $7961,$02 #R$694D, opened by the cyan key.
  $7963,$02 #R$697D.
  $7965,$02 Terminator.

w $7967 Room: #N$49
@ $7967 label=Room_49
D $7967 The items in room #N$49.
  $7967,$02 #R$693D.
  $7969,$02 #R$74BD.
  $796B,$02 Terminator.

w $796D Room: #N$4A
@ $796D label=Room_4A
D $796D The items in room #N$4A.
  $796D,$02 #R$694D, opened by the cyan key.
  $796F,$02 #R$695D.
  $7971,$02 Terminator.

w $7973 Room: #N$4B
@ $7973 label=Room_4B
D $7973 The items in room #N$4B.
  $7973,$02 #R$695D.
  $7975,$02 #R$696D.
  $7977,$02 #R$6F8D.
  $7979,$02 #R$751D.
  $797B,$02 Terminator.

w $797D Room: #N$4C
@ $797D label=Room_4C
D $797D The items in room #N$4C.
  $797D,$02 #R$696D.
  $797F,$02 #R$6A0D.
  $7981,$02 #R$750D.
  $7983,$02 Terminator.

w $7985 Room: #N$4D
@ $7985 label=Room_4D
D $7985 The items in room #N$4D.
  $7985,$02 #R$697D.
  $7987,$02 #R$698D, opened by the red key.
  $7989,$02 Terminator.

w $798B Room: #N$4E
@ $798B label=Room_4E
D $798B The items in room #N$4E.
  $798B,$02 #R$698D, opened by the red key.
  $798D,$02 #R$699D.
  $798F,$02 #R$750D.
  $7991,$02 Terminator.

w $7993 Room: #N$4F
@ $7993 label=Room_4F
D $7993 The items in room #N$4F.
  $7993,$02 #R$699D.
  $7995,$02 #R$69AD.
  $7997,$02 Terminator.

w $7999 Room: #N$50
@ $7999 label=Room_50
D $7999 The items in room #N$50.
  $7999,$02 #R$69AD.
  $799B,$02 #R$69BD.
  $799D,$02 #R$69CD, opened by the green key.
  $799F,$02 Terminator.

w $79A1 Room: #N$51
@ $79A1 label=Room_51
D $79A1 The items in room #N$51.
  $79A1,$02 #R$69BD.
  $79A3,$02 #R$69FD.
  $79A5,$02 Terminator.

w $79A7 Room: #N$52
@ $79A7 label=Room_52
D $79A7 The items in room #N$52.
  $79A7,$02 #R$69CD, opened by the green key.
  $79A9,$02 #R$69DD.
  $79AB,$02 Terminator.

w $79AD Room: #N$53
@ $79AD label=Room_53
D $79AD The items in room #N$53.
  $79AD,$02 #R$69DD.
  $79AF,$02 #R$74FD.
  $79B1,$02 #R$755D.
  $79B3,$02 Terminator.

w $79B5 Room: #N$54
@ $79B5 label=Room_54
D $79B5 The items in room #N$54.
  $79B5,$02 #R$6A1D.
  $79B7,$02 #R$6A2D.
  $79B9,$02 #R$6F0D.
  $79BB,$02 Terminator.

w $79BD Room: #N$55
@ $79BD label=Room_55
D $79BD The items in room #N$55.
  $79BD,$02 #R$6A0D.
  $79BF,$02 #R$6A1D.
  $79C1,$02 #R$756D(Skeleton).
  $79C3,$02 Terminator.

w $79C5 Room: #N$56
@ $79C5 label=Room_56
D $79C5 The items in room #N$56.
  $79C5,$02 #R$6CED.
  $79C7,$02 #R$6DAD.
  $79C9,$02 #R$6E6D, opened by the cyan key.
  $79CB,$02 #R$6E8D, opened by the yellow key.
  $79CD,$02 #R$70FD(Suit Of Armour).
  $79CF,$02 #R$710D(Suit Of Armour).
  $79D1,$02 Terminator.

w $79D3 Room: #N$57
@ $79D3 label=Room_57
D $79D3 The items in room #N$57.
  $79D3,$02 #R$6CED.
  $79D5,$02 #R$6CFD, opened by the green key.
  $79D7,$02 #R$6DDD.
  $79D9,$02 Terminator.

w $79DB Room: #N$58
@ $79DB label=Room_58
D $79DB The items in room #N$58.
  $79DB,$02 #R$6CFD, opened by the green key.
  $79DD,$02 #R$6D0D.
  $79DF,$02 #R$6E0D.
  $79E1,$02 Terminator.

w $79E3 Room: #N$59
@ $79E3 label=Room_59
D $79E3 The items in room #N$59.
  $79E3,$02 #R$6D0D.
  $79E5,$02 #R$6E3D, opened by the yellow key.
  $79E7,$02 #R$6E7D, opened by the red key.
  $79E9,$02 Terminator.

w $79EB Room: #N$5A
@ $79EB label=Room_5A
D $79EB The items in room #N$5A.
  $79EB,$02 #R$6D1D.
  $79ED,$02 #R$6DAD.
  $79EF,$02 #R$6DBD, opened by the cyan key.
  $79F1,$02 #R$740D(Wall Antlers).
  $79F3,$02 #R$741D(Wall Trophy).
  $79F5,$02 Terminator.

w $79F7 Room: #N$5B
@ $79F7 label=Room_5B
D $79F7 The items in room #N$5B.
  $79F7,$02 #R$6D1D.
  $79F9,$02 #R$6D2D, opened by the red key.
  $79FB,$02 #R$6DDD.
  $79FD,$02 #R$6DED, opened by the green key.
  $79FF,$02 #R$6EAD, opened by the yellow key.
  $7A01,$02 #R$71AD(Table).
  $7A03,$02 Terminator.

w $7A05 Room: #N$5C
@ $7A05 label=Room_5C
D $7A05 The items in room #N$5C.
  $7A05,$02 #R$6D2D, opened by the red key.
  $7A07,$02 #R$6D3D, opened by the green key.
  $7A09,$02 #R$6E0D.
  $7A0B,$02 #R$6E1D, opened by the red key.
  $7A0D,$02 #R$6EBD, opened by the yellow key.
  $7A0F,$02 #R$71AD(Table).
  $7A11,$02 Terminator.

w $7A13 Room: #N$5D
@ $7A13 label=Room_5D
D $7A13 The items in room #N$5D.
  $7A13,$02 #R$6D3D, opened by the green key.
  $7A15,$02 #R$6E3D, opened by the yellow key.
  $7A17,$02 #R$6E4D.
  $7A19,$02 #R$716D(Table).
  $7A1B,$02 #R$738D(Wall Antlers).
  $7A1D,$02 Terminator.

w $7A1F Room: #N$5E
@ $7A1F label=Room_5E
D $7A1F The items in room #N$5E.
  $7A1F,$02 #R$6D4D, opened by the red key.
  $7A21,$02 #R$6DBD, opened by the cyan key.
  $7A23,$02 #R$6DCD.
  $7A25,$02 Terminator.

w $7A27 Room: #N$5F
@ $7A27 label=Room_5F
D $7A27 The items in room #N$5F.
  $7A27,$02 #R$6D4D, opened by the red key.
  $7A29,$02 #R$6D5D, opened by the red key.
  $7A2B,$02 #R$6DED, opened by the green key.
  $7A2D,$02 #R$6DFD, opened by the cyan key.
  $7A2F,$02 #R$6ECD, opened by the yellow key.
  $7A31,$02 Terminator.

w $7A33 Room: #N$60
@ $7A33 label=Room_60
D $7A33 The items in room #N$60.
  $7A33,$02 #R$6D5D, opened by the red key.
  $7A35,$02 #R$6D6D.
  $7A37,$02 #R$6E1D, opened by the red key.
  $7A39,$02 #R$6E2D, opened by the cyan key.
  $7A3B,$02 #R$6EDD, opened by the yellow key.
  $7A3D,$02 Terminator.

w $7A3F Room: #N$61
@ $7A3F label=Room_61
D $7A3F The items in room #N$61.
  $7A3F,$02 #R$6D6D.
  $7A41,$02 #R$6E4D.
  $7A43,$02 #R$6E5D.
  $7A45,$02 #R$6F8D.
  $7A47,$02 #R$737D(Ghost Picture).
  $7A49,$02 Terminator.

w $7A4B Room: #N$62
@ $7A4B label=Room_62
D $7A4B The items in room #N$62.
  $7A4B,$02 #R$6D7D.
  $7A4D,$02 #R$6DCD.
  $7A4F,$02 #R$6E9D, opened by the green key.
  $7A51,$02 #R$73BD(Ghost Picture).
  $7A53,$02 Terminator.

w $7A55 Room: #N$63
@ $7A55 label=Room_63
D $7A55 The items in room #N$63.
  $7A55,$02 #R$6D7D.
  $7A57,$02 #R$6D8D.
  $7A59,$02 #R$6DFD, opened by the cyan key.
  $7A5B,$02 #R$716D(Table).
  $7A5D,$02 #R$73BD(Ghost Picture).
  $7A5F,$02 Terminator.

w $7A61 Room: #N$64
@ $7A61 label=Room_64
D $7A61 The items in room #N$64.
  $7A61,$02 #R$6D8D.
  $7A63,$02 #R$6D9D, opened by the yellow key.
  $7A65,$02 #R$6E2D, opened by the cyan key.
  $7A67,$02 #R$73AD(A.C.G. Shield).
  $7A69,$02 Terminator.

w $7A6B Room: #N$65
@ $7A6B label=Room_65
D $7A6B The items in room #N$65.
  $7A6B,$02 #R$6D9D, opened by the yellow key.
  $7A6D,$02 #R$6E5D.
  $7A6F,$02 #R$6EED.
  $7A71,$02 #R$6F7D.
  $7A73,$02 #R$739D(Wall Trophy).
  $7A75,$02 Terminator.

w $7A77 Room: #N$66
@ $7A77 label=Room_66
D $7A77 The items in room #N$66.
  $7A77,$02 #R$6EAD, opened by the yellow key.
  $7A79,$02 #R$6EBD, opened by the yellow key.
  $7A7B,$02 #R$6ECD, opened by the yellow key.
  $7A7D,$02 #R$6EDD, opened by the yellow key.
  $7A7F,$02 #R$6FED.
  $7A81,$02 #R$737D(Ghost Picture).
  $7A83,$02 #R$738D(Wall Antlers).
  $7A85,$02 #R$739D(Wall Trophy).
  $7A87,$02 #R$73AD(A.C.G. Shield).
  $7A89,$02 Terminator.

w $7A8B Room: #N$67
@ $7A8B label=Room_67
D $7A8B The items in room #N$67.
  $7A8B,$02 #R$6E6D, opened by the cyan key.
  $7A8D,$02 #R$747D.
  $7A8F,$02 Terminator.

w $7A91 Room: #N$68
@ $7A91 label=Room_68
D $7A91 The items in room #N$68.
  $7A91,$02 #R$6E7D, opened by the red key.
  $7A93,$02 #R$747D.
  $7A95,$02 Terminator.

w $7A97 Room: #N$69
@ $7A97 label=Room_69
D $7A97 The items in room #N$69.
  $7A97,$02 #R$6E8D, opened by the yellow key.
  $7A99,$02 #R$74CD.
  $7A9B,$02 Terminator.

w $7A9D Room: #N$6A
@ $7A9D label=Room_6A
D $7A9D The items in room #N$6A.
  $7A9D,$02 #R$6E9D, opened by the green key.
  $7A9F,$02 #R$74CD.
  $7AA1,$02 #R$71BD(Table).
  $7AA3,$02 Terminator.

w $7AA5 Room: #N$6B
@ $7AA5 label=Room_6B
D $7AA5 The items in room #N$6B.
  $7AA5,$02 #R$6C2D.
  $7AA7,$02 #R$6C3D.
  $7AA9,$02 #R$752D.
  $7AAB,$02 Terminator.

w $7AAD Room: #N$6C
@ $7AAD label=Room_6C
D $7AAD The items in room #N$6C.
  $7AAD,$02 #R$6C3D.
  $7AAF,$02 #R$6C4D, opened by the cyan key.
  $7AB1,$02 #R$6FBD.
  $7AB3,$02 #R$74DD.
  $7AB5,$02 Terminator.

w $7AB7 Room: #N$6D
@ $7AB7 label=Room_6D
D $7AB7 The items in room #N$6D.
  $7AB7,$02 #R$6C5D, opened by the green key.
  $7AB9,$02 #R$6C6D.
  $7ABB,$02 #R$752D.
  $7ABD,$02 #R$72FD(A.C.G. Shield).
  $7ABF,$02 #R$719D(Table).
  $7AC1,$02 Terminator.

w $7AC3 Room: #N$6E
@ $7AC3 label=Room_6E
D $7AC3 The items in room #N$6E.
  $7AC3,$02 #R$6C6D.
  $7AC5,$02 #R$6C7D.
  $7AC7,$02 #R$6FCD.
  $7AC9,$02 #R$74DD.
  $7ACB,$02 #R$72ED(Ghost Picture).
  $7ACD,$02 Terminator.

w $7ACF Room: #N$6F
@ $7ACF label=Room_6F
D $7ACF The items in room #N$6F.
  $7ACF,$02 #R$6C8D, opened by the cyan key.
  $7AD1,$02 #R$6C9D.
  $7AD3,$02 #R$727D(Wall Antlers).
  $7AD5,$02 Terminator.

w $7AD7 Room: #N$70
@ $7AD7 label=Room_70
D $7AD7 The items in room #N$70.
  $7AD7,$02 #R$6C9D.
  $7AD9,$02 #R$6CAD.
  $7ADB,$02 #R$73CD(Wall Trophy).
  $7ADD,$02 #R$73DD(Wall Shield).
  $7ADF,$02 Terminator.

w $7AE1 Room: #N$71
@ $7AE1 label=Room_71
D $7AE1 The items in room #N$71.
  $7AE1,$02 #R$6CAD.
  $7AE3,$02 #R$6CBD.
  $7AE5,$02 Terminator.

w $7AE7 Room: #N$72
@ $7AE7 label=Room_72
D $7AE7 The items in room #N$72.
  $7AE7,$02 #R$6CBD.
  $7AE9,$02 #R$6CCD.
  $7AEB,$02 Terminator.

w $7AED Room: #N$73
@ $7AED label=Room_73
D $7AED The items in room #N$73.
  $7AED,$02 #R$6C1D.
  $7AEF,$02 #R$6F6D.
  $7AF1,$02 #R$725D(Wall Antlers).
  $7AF3,$02 #R$72ED(Ghost Picture).
  $7AF5,$02 Terminator.

w $7AF7 Room: #N$74
@ $7AF7 label=Room_74
D $7AF7 The items in room #N$74.
  $7AF7,$02 #R$6CDD.
  $7AF9,$02 #R$6F6D.
  $7AFB,$02 Terminator.

w $7AFD Room: #N$75
@ $7AFD label=Room_75
D $7AFD The items in room #N$75.
  $7AFD,$02 #R$6A3D.
  $7AFF,$02 #R$6A4D.
  $7B01,$02 #R$749D.
  $7B03,$02 Terminator.

w $7B05 Room: #N$76
@ $7B05 label=Room_76
D $7B05 The items in room #N$76.
  $7B05,$02 #R$6A4D.
  $7B07,$02 #R$6A5D.
  $7B09,$02 #R$6ACD.
  $7B0B,$02 #R$6FAD.
  $7B0D,$02 #R$749D.
  $7B0F,$02 Terminator.

w $7B11 Room: #N$77
@ $7B11 label=Room_77
D $7B11 The items in room #N$77.
  $7B11,$02 #R$6A5D.
  $7B13,$02 #R$6A6D.
  $7B15,$02 Terminator.

w $7B17 Room: #N$78
@ $7B17 label=Room_78
D $7B17 The items in room #N$78.
  $7B17,$02 #R$6A6D.
  $7B19,$02 #R$6A7D.
  $7B1B,$02 #R$6FFD.
  $7B1D,$02 Terminator.

w $7B1F Room: #N$79
@ $7B1F label=Room_79
D $7B1F The items in room #N$79.
  $7B1F,$02 #R$6A7D.
  $7B21,$02 #R$6A8D.
  $7B23,$02 Terminator.

w $7B25 Room: #N$7A
@ $7B25 label=Room_7A
D $7B25 The items in room #N$7A.
  $7B25,$02 #R$6A8D.
  $7B27,$02 #R$6A9D.
  $7B29,$02 #R$6ADD, opened by the red key.
  $7B2B,$02 #R$718D(Table).
  $7B2D,$02 #R$711D(Suit Of Armour).
  $7B2F,$02 #R$712D(Suit Of Armour).
  $7B31,$02 Terminator.

w $7B33 Room: #N$7B
@ $7B33 label=Room_7B
D $7B33 The items in room #N$7B.
  $7B33,$02 #R$6A9D.
  $7B35,$02 #R$6AAD, opened by the yellow key.
  $7B37,$02 Terminator.

w $7B39 Room: #N$7C
@ $7B39 label=Room_7C
D $7B39 The items in room #N$7C.
  $7B39,$02 #R$6AAD, opened by the yellow key.
  $7B3B,$02 #R$6ABD, opened by the yellow key.
  $7B3D,$02 #R$711D(Suit Of Armour).
  $7B3F,$02 #R$712D(Suit Of Armour).
  $7B41,$02 Terminator.

w $7B43 Room: #N$7D
@ $7B43 label=Room_7D
D $7B43 The items in room #N$7D.
  $7B43,$02 #R$6ABD, opened by the yellow key.
  $7B45,$02 #R$6ACD.
  $7B47,$02 #R$71CD(Table).
  $7B49,$02 #R$71DD(Table).
  $7B4B,$02 Terminator.

w $7B4D Room: #N$7E
@ $7B4D label=Room_7E
D $7B4D The items in room #N$7E.
  $7B4D,$02 #R$6ADD, opened by the red key.
  $7B4F,$02 #R$6AED.
  $7B51,$02 #R$742D(A.C.G. Shield).
  $7B53,$02 #R$743D(Ghost Picture).
  $7B55,$02 Terminator.

w $7B57 Room: #N$7F
@ $7B57 label=Room_7F
D $7B57 The items in room #N$7F.
  $7B57,$02 #R$6B0D, opened by the green key.
  $7B59,$02 #R$6B3D.
  $7B5B,$02 #R$713D(Suit Of Armour).
  $7B5D,$02 #R$714D(Suit Of Armour).
  $7B5F,$02 Terminator.

w $7B61 Room: #N$80
@ $7B61 label=Room_80
D $7B61 The items in room #N$80.
  $7B61,$02 #R$6B0D, opened by the green key.
  $7B63,$02 #R$6B1D.
  $7B65,$02 Terminator.

w $7B67 Room: #N$81
@ $7B67 label=Room_81
D $7B67 The items in room #N$81.
  $7B67,$02 #R$6B2D.
  $7B69,$02 #R$6B3D.
  $7B6B,$02 #R$718D(Table).
  $7B6D,$02 Terminator.

w $7B6F Room: #N$82
@ $7B6F label=Room_82
D $7B6F The items in room #N$82.
  $7B6F,$02 #R$6B1D.
  $7B71,$02 #R$6B2D.
  $7B73,$02 #R$6B4D, opened by the cyan key.
  $7B75,$02 #R$735D(Wall Shield).
  $7B77,$02 #R$736D(Wall Trophy).
  $7B79,$02 Terminator.

w $7B7B Room: #N$83
@ $7B7B label=Room_83
D $7B7B The items in room #N$83.
  $7B7B,$02 #R$6B9D, opened by the red key.
  $7B7D,$02 #R$6BCD.
  $7B7F,$02 Terminator.

w $7B81 Room: #N$84
@ $7B81 label=Room_84
D $7B81 The items in room #N$84.
  $7B81,$02 #R$6B9D, opened by the red key.
  $7B83,$02 #R$6BAD.
  $7B85,$02 #R$6BDD, opened by the yellow key.
  $7B87,$02 #R$6FAD.
  $7B89,$02 Terminator.

w $7B8B Room: #N$85
@ $7B8B label=Room_85
D $7B8B The items in room #N$85.
  $7B8B,$02 #R$6BBD.
  $7B8D,$02 #R$6BCD.
  $7B8F,$02 Terminator.

w $7B91 Room: #N$86
@ $7B91 label=Room_86
D $7B91 The items in room #N$86.
  $7B91,$02 #R$6BAD.
  $7B93,$02 #R$6BBD.
  $7B95,$02 Terminator.

w $7B97 Room: #N$87
@ $7B97 label=Room_87
D $7B97 The items in room #N$87.
  $7B97,$02 #R$6B4D, opened by the cyan key.
  $7B99,$02 #R$6B5D.
  $7B9B,$02 #R$6B6D.
  $7B9D,$02 #R$733D(Wall Antlers).
  $7B9F,$02 #R$734D(Wall Trophy).
  $7BA1,$02 Terminator.

w $7BA3 Room: #N$88
@ $7BA3 label=Room_88
D $7BA3 The items in room #N$88.
  $7BA3,$02 #R$6AFD.
  $7BA5,$02 #R$6B5D.
  $7BA7,$02 #R$717D(Table).
  $7BA9,$02 #R$70BD(Suit Of Armour).
  $7BAB,$02 #R$70CD(Suit Of Armour).
  $7BAD,$02 Terminator.

w $7BAF Room: #N$89
@ $7BAF label=Room_89
D $7BAF The items in room #N$89.
  $7BAF,$02 #R$6BDD, opened by the yellow key.
  $7BB1,$02 #R$6BED.
  $7BB3,$02 #R$6BFD.
  $7BB5,$02 #R$733D(Wall Antlers).
  $7BB7,$02 #R$734D(Wall Trophy).
  $7BB9,$02 Terminator.

w $7BBB Room: #N$8A
@ $7BBB label=Room_8A
D $7BBB The items in room #N$8A.
  $7BBB,$02 #R$6BFD.
  $7BBD,$02 #R$6C0D, opened by the green key.
  $7BBF,$02 #R$6FFD.
  $7BC1,$02 #R$753D.
  $7BC3,$02 #R$70BD(Suit Of Armour).
  $7BC5,$02 #R$70CD(Suit Of Armour).
  $7BC7,$02 Terminator.

w $7BC9 Room: #N$8B
@ $7BC9 label=Room_8B
D $7BC9 The items in room #N$8B.
  $7BC9,$02 #R$6B6D.
  $7BCB,$02 #R$6B7D.
  $7BCD,$02 #R$6FBD.
  $7BCF,$02 #R$721D(Wall Antlers).
  $7BD1,$02 Terminator.

w $7BD3 Room: #N$8C
@ $7BD3 label=Room_8C
D $7BD3 The items in room #N$8C.
  $7BD3,$02 #R$6B7D.
  $7BD5,$02 #R$6B8D, opened by the green key.
  $7BD7,$02 #R$720D.
  $7BD9,$02 #R$721D(Wall Antlers).
  $7BDB,$02 Terminator.

w $7BDD Room: #N$8D
@ $7BDD label=Room_8D
D $7BDD The items in room #N$8D.
  $7BDD,$02 #R$6B8D, opened by the green key.
  $7BDF,$02 #R$6BED.
  $7BE1,$02 #R$6F9D.
  $7BE3,$02 #R$6FCD.
  $7BE5,$02 #R$720D.
  $7BE7,$02 #R$748D.
  $7BE9,$02 Terminator.

w $7BEB Room: #N$8E
@ $7BEB label=Room_8E
D $7BEB The items in room #N$8E.
  $7BEB,$02 #R$754D.
  $7BED,$02 Terminator.

w $7BEF Room: #N$8F
@ $7BEF label=Room_8F
D $7BEF The items in room #N$8F.
  $7BEF,$02 #R$6EFD.
  $7BF1,$02 #R$746D.
  $7BF3,$02 #R$755D.
  $7BF5,$02 Terminator.

w $7BF7 Room: #N$90
@ $7BF7 label=Room_90
D $7BF7 The items in room #N$90.
  $7BF7,$02 #R$6F0D.
  $7BF9,$02 #R$6F1D.
  $7BFB,$02 Terminator.

w $7BFD Room: #N$91
@ $7BFD label=Room_91
D $7BFD The items in room #N$91.
  $7BFD,$02 #R$6F1D.
  $7BFF,$02 #R$6F2D.
  $7C01,$02 #R$702D.
  $7C03,$02 Terminator.

w $7C05 Room: #N$92
@ $7C05 label=Room_92
D $7C05 The items in room #N$92.
  $7C05,$02 #R$6F2D.
  $7C07,$02 #R$6F3D.
  $7C09,$02 Terminator.

w $7C0B Room: #N$93
@ $7C0B label=Room_93
D $7C0B The items in room #N$93.
  $7C0B,$02 #R$6F3D.
  $7C0D,$02 #R$6F4D.
  $7C0F,$02 Terminator.

w $7C11 Room: #N$94
@ $7C11 label=Room_94
D $7C11 The items in room #N$94.
  $7C11,$02 #R$6F4D.
  $7C13,$02 #R$6F5D.
  $7C15,$02 Terminator.

w $7C17 Room: None
@ $7C17 label=Room_None
D $7C17 The list for the room that has no items, which is just the terminator.
  $7C17,$02 Terminator.

c $7C19 Game Initialisation
@ $7C19 label=GameInitialisation
D $7C19 Clears the first #N$10 bytes of the game variables, selects the main
. font and then runs the game selection menu. The menu is drawn by #R$7CAF
. and the keyboard is scanned for the keys "1" to "6" and "0" until "0" is
. pressed. Each key changes the control method or the character stored in
. #R$5E00 and moves the highlight on the menu, and "0" starts the game at
. #R$7D9A. The entry point at #R$7C29 is also used to return to the menu when
. a game ends.
E $7C19 View the equivalent code in;
. #LIST
. { #COOKIE$6298 }
. { #JETPAC$61EB }
. { #LUNARJETMAN$800A }
. { #PSSST$61CD }
. { #SABREWULF$9960 }
. { #TRANZAM$5F07 }
. LIST#
N $7C19 Clear the first #N$10 bytes of the game variables.
  $7C19,$03 Point #REGhl at the game options at #R$5E00.
  $7C1C,$02 #REGb=#N$10 (the number of bytes to clear).
@ $7C1E label=GameInitialisation_Loop
  $7C1E,$02 Clear a byte of the game variables.
  $7C20,$01 Move #REGhl on to the next byte of the game variables.
  $7C21,$02 Decrease the byte counter by one and loop back to #R$7C1E until all
. #N$10 bytes have been cleared.
  $7C23,$06 Write #N$BE4C (the main font, see #R$BF4C) to #R$5E01.
@ $7C29 label=Game_Restart
N $7C29 Clear the screen and draw the icons for the menu.
  $7C29,$03 Call #R$80AA to clear the screen.
  $7C2C,$03 Call #R$A311 to draw the icons of the menu.
N $7C2F Each pass of this loop draws the menu and handles one scan of the
. keyboard.
@ $7C2F label=GameSelect_Loop
  $7C2F,$03 Call #R$7CAF to show the game selection menu.
  $7C32,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $7C38,$01 Flip the bits, so that a set bit is a key which is pressed.
  $7C39,$01 Keep the keys that are pressed in #REGe.
  $7C3A,$03 Fetch the game options.
N $7C3D Handle "Keyboard" selection.
  $7C3D,$04 Jump to #R$7C43 if key "1" is not being pressed ("KEYBOARD").
  $7C41,$02,b$01 Keep only bits 0 and 3-7, so the control method is the keyboard
. (#N$00).
N $7C43 Handle "Kempston Joystick" selection.
@ $7C43 label=GameSelect_CheckKempston
  $7C43,$04 Jump to #R$7C4B if key "2" is not being pressed ("KEMPSTON
. JOYSTICK").
  $7C47,$02,b$01 Keep only bits 0 and 3-7.
  $7C49,$02,b$01 Set the control method to Kempston joystick (#N$02).
N $7C4B Handle "Cursor Joystick" selection.
@ $7C4B label=GameSelect_CheckCursor
  $7C4B,$04 Jump to #R$7C53 if key "3" is not being pressed ("CURSOR JOYSTICK").
  $7C4F,$02,b$01 Keep only bits 0 and 3-7.
  $7C51,$02,b$01 Set the control method to cursor joystick (#N$04).
N $7C53 Handle "Knight" selection.
@ $7C53 label=GameSelect_CheckKnight
  $7C53,$04 Jump to #R$7C59 if key "4" is not being pressed ("KNIGHT").
  $7C57,$02,b$01 Keep only bits 0-2 and 5-7, so the character is the knight
. (#N$00).
N $7C59 Handle "Wizard" selection.
@ $7C59 label=GameSelect_CheckWizard
  $7C59,$04 Jump to #R$7C61 if key "5" is not being pressed ("WIZARD").
  $7C5D,$02,b$01 Keep only bits 0-2 and 5-7.
  $7C5F,$02,b$01 Set the character to the wizard (#N$08).
N $7C61 Save the options so far and read the second row of keys.
@ $7C61 label=GameSelect_SecondRow
  $7C61,$01 Keep the options so far in #REGd.
  $7C62,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $7C68,$01 Flip the bits, so that a set bit is a key which is pressed.
  $7C69,$01 Keep the keys that are pressed in #REGe.
  $7C6A,$01 Fetch the options so far.
N $7C6B Handle "Serf" selection.
@ $7C6B label=GameSelect_CheckSerf
  $7C6B,$04 Jump to #R$7C73 if key "6" is not being pressed ("SERF").
  $7C6F,$02,b$01 Keep only bits 0-2 and 5-7.
  $7C71,$02,b$01 Set the character to the serf (#N$10).
N $7C73 Write the options back and keep a copy in #REGc.
@ $7C73 label=GameSelect_StoreOptions
  $7C73,$03 Write the options back to #R$5E00.
  $7C76,$01 Keep a copy of the options in #REGc.
N $7C77 Handle starting a new game.
@ $7C77 label=GameSelect_Start
  $7C77,$05 Jump to #R$7D9A if key "0" is being pressed ("START GAME").
N $7C7C Highlight the selected control method, then the selected character.
  $7C7C,$03 Point #REGhl at the game select attribute table at #R$7CEA.
  $7C7F,$02 #REGb=#N$03 (the number of control method entries).
  $7C81,$01 Fetch the options.
  $7C82,$03 Call #R$7C90 to highlight the selected menu entry.
  $7C85,$02 #REGb=#N$03 (the number of character entries).
  $7C87,$01 Fetch the options.
  $7C88,$02 Rotate #REGa right twice, which brings the character bits into
. position.
  $7C8A,$03 Call #R$7C90 to highlight the selected menu entry.
  $7C8D,$03 Jump back to #R$7C2F to run the menu again.

c $7C90 Flash Menu Selection
@ $7C90 label=FlashSelection
D $7C90 Updates three consecutive entries of the menu attribute table so that
. only the selected entry has its flash (bit 7) set. After the first
. rotation, bits 0-1 of #REGa hold the number of the selected entry (#N$00 to
. #N$02), which counts down as each entry is processed; the entry where it
. reaches zero is flashed.
R $7C90 A Options, with the selection in bits 1-2
R $7C90 B Number of entries (always #N$03)
R $7C90 HL First attribute table entry
R $7C90 O:HL Entry after the last one updated
  $7C90,$01 Rotate #REGa right, which brings the selection into bits 0-1.
@ $7C91 label=FlashSelection_Loop
  $7C91,$02,b$01 Keep only bits 0-1.
  $7C93,$02 Jump to #R$7C9C if this is the selected entry, which is when the
. selection number has counted down to zero.
  $7C95,$03 Call #R$7CA4 to stop this entry flashing.
@ $7C98 label=FlashSelection_Next
  $7C98,$01 Decrease the selection number by one.
  $7C99,$02 Decrease the entry counter by one and loop back to #R$7C91 until all
. three entries have been updated.
  $7C9B,$01 Return.
@ $7C9C label=FlashSelection_Selected
  $7C9C,$03 Call #R$7CAB to make this entry flash.
  $7C9F,$02 Jump back to #R$7C98 to move on to the next menu entry.
N $7CA1 These instructions are never used.
  $7CA1,$02 Set bit 7 of *#REGhl.
  $7CA3,$01 Move #REGhl on to the next menu entry.
N $7CA4 Stop one entry flashing and move on to the next.
@ $7CA4 label=FlashSelection_Clear
  $7CA4,$02 Reset bit 7 of *#REGhl.
  $7CA6,$01 Move #REGhl on to the next menu entry.
  $7CA7,$01 Return.
N $7CA8 These instructions are never used.
  $7CA8,$02 Reset bit 7 of *#REGhl.
  $7CAA,$01 Move #REGhl on to the next menu entry.
N $7CAB Make one entry flash and move on to the next.
@ $7CAB label=FlashSelection_Set
  $7CAB,$02 Set bit 7 of *#REGhl.
  $7CAD,$01 Move #REGhl on to the next menu entry.
  $7CAE,$01 Return.

c $7CAF Game Selection Menu
@ $7CAF label=GameMenu
D $7CAF Prints the seven menu lines, then the copyright message and the title.
. The icons were drawn by #R$A311. The main registers are used to step
. through the attribute table at #R$7CEA, whilst the shadow registers step
. through the Y position table at #R$7CF1 and the text at #R$7CF8.
E $7CAF View the equivalent code in;
. #LIST
. { #COOKIE$6332 }
. { #JETPAC$6260 }
. { #LUNARJETMAN$80D1 }
. { #PSSST$6250 }
. { #SABREWULF$B473 }
. { #TRANZAM$5F6C }
. { #UNDERWURLDE$90E4 }
. LIST#
N $7CAF #PUSHS #UDGTABLE { #SIM(start=$7C19,stop=$7C32,clear=1,sp=$5E00)
. #SCR$02(game-menu) } UDGTABLE# #POPS
  $7CAF,$06 Write #N$BE4C (the main font, see #R$BF4C) to #R$5E01.
  $7CB5,$03 Point #REGde at the menu attribute table at #R$7CEA.
  $7CB8,$01 Switch to the shadow registers.
  $7CB9,$03 Point #REGhl' at the menu Y position table at #R$7CF1.
  $7CBC,$03 Point #REGde' at the menu text at #R$7CF8.
N $7CBF There are seven lines of text.
  $7CBF,$02 #REGb'=#N$07 (the number of lines to print).
@ $7CC1 label=GameMenu_Loop
  $7CC1,$01 Switch back to the normal registers.
  $7CC2,$04 Copy the attribute of the line from the menu attribute table to
. #R$5E22.
  $7CC6,$01 Move #REGde on to the text of the line.
  $7CC7,$01 Switch to the shadow registers.
  $7CC8,$01 Stash the line counter on the stack.
  $7CC9,$01 Fetch the Y position of the line.
  $7CCA,$01 Move #REGhl' on to the next Y position in the table.
  $7CCB,$01 Stash the position table pointer on the stack.
  $7CCC,$01 Set the Y position of the line in #REGh'.
  $7CCD,$02 Set the X position of the line to #N$58 in #REGl'.
  $7CCF,$03 Call #R$7D8A to print the line.
  $7CD2,$01 Switch to the shadow registers.
  $7CD3,$01 Restore the position table pointer from the stack.
  $7CD4,$01 Restore the line counter from the stack.
  $7CD5,$01 Move #REGde' on to the start of the next line of text.
  $7CD6,$02 Decrease the line counter by one and loop back to #R$7CC1 until all
. seven lines have been printed.
N $7CD8 Print the copyright message at the bottom of the screen.
  $7CD8,$03 #REGhl=#N($B800,$04,$04) (a Y position of #N$B8 and an X position of
. #N$00).
  $7CDB,$03 Point #REGde at the copyright messaging at #R$7D51.
  $7CDE,$03 Call #R$A1F3 to print the string.
N $7CE1 Print the title at the top of the screen.
  $7CE1,$03 #REGhl=#N($0020,$04,$04) (a Y position of #N$00 and an X position of
. #N$20).
  $7CE4,$03 Point #REGde at the game selection title text at #R$7D72.
  $7CE7,$03 Jump to #R$A1F3 to print the string.

b $7CEA Game Select Attribute Table
@ $7CEA label=GameSelection_Attributes
D $7CEA The attribute for each of the seven menu lines. Bit 7 (FLASH) is set
. by #R$7C90 for the control method and the character that are currently
. selected, which are held in #R$5E00.
E $7CEA View the equivalent code in;
. #LIST
. { #COOKIE$635E }
. { #JETPAC$628D }
. { #LUNARJETMAN$810E }
. { #PSSST$627C }
. { #SABREWULF$B498 }
. { #TRANZAM$5FA7 }
. { #UNDERWURLDE$9119 }
. LIST#
  $7CEA,$07,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | 1 Keyboard }
. { #N$02 | 2 Kempston Joystick }
. { #N$03 | 3 Cursor Joystick }
. { #N$04 | 4 Knight }
. { #N$05 | 5 Wizard }
. { #N$06 | 6 Serf }
. { #N$07 | 0 Start Game }
. TABLE#

b $7CF1 Game Select Y Position Table
@ $7CF1 label=GameSelection_Position
D $7CF1 The Y pixel position for each of the seven menu lines. Each line is
. printed starting at an X position of #N$58.
E $7CF1 View the equivalent code in;
. #LIST
. { #COOKIE$6365 }
. { #JETPAC$6293 }
. { #LUNARJETMAN$8115 }
. { #PSSST$6282 }
. { #SABREWULF$B4A0 }
. { #TRANZAM$5FAC }
. { #UNDERWURLDE$911F }
. LIST#
  $7CF1,$07,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | 1 Keyboard }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | 2 Kempston Joystick }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | 3 Cursor Joystick }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | 4 Knight }
. { #N$05 | #EVAL(#PEEK(#PC+$04) / $08) | 5 Wizard }
. { #N$06 | #EVAL(#PEEK(#PC+$05) / $08) | 6 Serf }
. { #N$07 | #EVAL(#PEEK(#PC+$06) / $08) | 0 Start Game }
. TABLE#

t $7CF8 Messaging: Game Selection Screen Text
@ $7CF8 label=GameSelection_Text
D $7CF8 The text of each of the seven menu lines. Each string ends with a
. character that has bit 7 set, which tells #R$A1F3 where it finishes.
E $7CF8 View the equivalent code in;
. #LIST
. { #COOKIE$636C }
. { #JETPAC$6299 }
. { #LUNARJETMAN$811C }
. { #PSSST$6288 }
. { #SABREWULF$B4B0 }
. { #TRANZAM$5FB1 }
. { #UNDERWURLDE$9125 }
. LIST#
  $7CF8,$0B,$0A:$01 "1  KEYBOARD".
  $7D03,$14,$13:$01 "2  KEMPSTON JOYSTICK".
  $7D17,$14,$13:$01 "3  CURSOR   JOYSTICK".
  $7D2B,$09,$08:$01 "4  KNIGHT".
  $7D34,$09,$08:$01 "5  WIZARD".
  $7D3D,$07,$06:$01 "6  SERF".
  $7D44,$0D,$0C:$01 "0  START GAME".

t $7D51 Messaging: Copyright
@ $7D51 label=Message_Copyright
D $7D51 The first byte is the attribute used for the whole message (#COLOUR$47),
. followed by the text, which ends with a character that has bit 7 set. It is
. printed by #R$7CAF.
E $7D51 View the equivalent code in #LUNARJETMAN$818A.
E $7D51 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$9174 }
. LIST#
  $7D51,$21,h$01,c$01,$1E:$01 Attribute: #COLOUR(#PEEK(#PC)) + "© 1983 A.C.G. ALL RIGHTS RESERVED".

t $7D72 Messaging: Game Selection Title Text
@ $7D72 label=GameSelection_Title
D $7D72 The first byte is the attribute used for the whole title, followed by
. the text, which ends with a character that has bit 7 set. It is printed by
. #R$7CAF.
E $7D72 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$9195 }
. LIST#
  $7D72,$18,h$01,$16:$01 Attribute: #COLOUR(#PEEK(#PC)) + "ATICATAC GAME SELECTION".

c $7D8A Write Menu Line
@ $7D8A label=MenuWriteText
D $7D8A Prints one line of text for the game selection menu. The screen address
. of the line is worked out in one register set and the attribute address in
. the other, using the attribute held in #R$5E22, and then the text is printed
. by #R$A1FF.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7C19,stop=$7C2F,clear=1,sp=$5E00)
. #SCR$02,$00,$00,$20,$06(menu-line-before)
. | #POKES$5E22,$45
. #SIM(start=$7D8A,stop=$0000,hl=$1858,de=$7CF8,sp=$5B60)
. #SCR$02,$00,$00,$20,$06(menu-line-after) } UDGTABLE# #POPS
E $7D8A View the equivalent code in;
. #LIST
. { #COOKIE$63E0 }
. { #LUNARJETMAN$81AB }
. { #PSSST$62E7 }
. { #SABREWULF$B52D }
. { #TRANZAM$5F97 }
. { #UNDERWURLDE$91B0 }
. LIST#
R $7D8A HL The Y position (in #REGh) and X position (in #REGl)
R $7D8A DE The address of the text
  $7D8A,$01 Stash the co-ordinates of the line on the stack.
  $7D8B,$03 Call #R$9BA2 to convert the co-ordinates to a screen address.
  $7D8E,$04 Fetch the attribute of the line and keep it in #REGaf'.
  $7D92,$01 Switch to the shadow registers.
  $7D93,$01 Restore the co-ordinates of the line from the stack.
  $7D94,$03 Call #R$9BD2 to convert the co-ordinates to an attribute address.
  $7D97,$03 Jump to #R$A1FF to print the menu line.

c $7D9A Start Game
@ $7D9A label=StartGame
D $7D9A Prepares a new game: the player data, the screen and side panel,
. the key pieces, the entity table and the doors. Then enters the
. starting room.
E $7D9A View the equivalent code in;
. #LIST
. { #COOKIE$6428 }
. { #JETPAC$6333 }
. { #LUNARJETMAN$81BB }
. { #PSSST$632D }
. { #TRANZAM$5FEF }
. LIST#
N $7D9A #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9 #UDGTABLE {
. #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SCR$02(start-game) } UDGTABLE# #POPS
  $7D9A,$03 Call #R$80CB to reset the game data.
N $7D9D See #POKE(set_starting_lives,Set Starting Lives).
  $7D9D,$05 Write #N$03 (the number of lives at the start of the game) to
. #R$5E21.
  $7DA2,$06 Set the food pointer in #R$5E55 to #R$EB58.
  $7DA8,$03 Call #R$80AA to clear the screen.
  $7DAB,$03 Call #R$A219 to draw the side panel.
  $7DAE,$03 Call #R$A2CE to display the lives.
  $7DB1,$03 Call #R$94B6 to place the key pieces.
  $7DB4,$03 Call #R$98D2 to set the positions of the keys.
  $7DB7,$03 Call #R$8D61 to reset the game state.
  $7DBA,$03 Call #R$94F5 to randomise the doors.
  $7DBD,$03 Call #R$9443 to prepare the player.
  $7DC0,$03 Jump to #R$9147 to enter the room.

c $7DC3 Run Main Loop
@ $7DC3 label=MainLoop
D $7DC3 Runs the game one entity at a time. Whenever FRAMES has changed
. since the last time, #R$7EB2 runs the handlers of the three fixed
. entities starting at #R$EA90. Each entity from #R$EAA8 onwards that
. is in the same room as the player is then given to #R$7E7E, and
. every 16-byte record from #R$EE60 onwards after that. Finally the
. room items are processed by #R$7E23.
. If the room has not been drawn yet (bit 0 of #R$5E14 is clear) the
. entities are skipped and #R$7E23 is run immediately.
  $7DC3,$03 Set stack pointer to #N$5E00.
  $7DC6,$01 Enable interrupts.
  $7DC7,$04 Reset the number of creatures in #R$5E25 to zero.
  $7DCB,$04 Point #REGix at the first entity after the three fixed entities at
. #R$EAA8.
  $7DCF,$07 Jump to #R$7DDC if the entities in the room have already been drawn
. (bit 0 of #R$5E14 is set).
  $7DD6,$04 Point #REGix at the end of the entity table, so that no entities are
. processed at #R$EEE0.
  $7DDA,$02 Jump to #R$7E23 to draw the room.
N $7DDC Each pass of this loop considers one of the 8-byte entities.
@ $7DDC label=MainLoop_Entities
  $7DDC,$04 Fetch the low byte of FRAMES into #REGc (using #REGa).
  $7DE0,$03 Fetch the FRAMES value from the previous pass.
  $7DE3,$04 Call #R$7EB2 if FRAMES has changed since it was last stored in
. #R$5E03.
  $7DE7,$03 Fetch the room of the player.
  $7DEA,$03 Compare it with the room of this entity.
  $7DED,$03 Point #REGhl at the address for the handler to return to at #R$7DF3.
  $7DF0,$03 Process the entity with #R$7E7E if it is in the same room as the
. player.
N $7DF3 Move on to the next 8-byte entity.
@ $7DF3 label=MainLoop_NextEntity
  $7DF3,$03 #REGde=#N($0008,$04,$04) (the size of an entity).
  $7DF6,$02 Move #REGix on to the next entity.
  $7DF8,$03 Copy #REGix to #REGhl (using the stack).
  $7DFB,$03 Point #REGde at the end of the 8-byte entities at #R$EE60.
  $7DFE,$05 Jump back to #R$7DDC until #REGix reaches #R$EE60.
N $7E03 Now work through the 16-byte records. These are processed no matter
. which room the player is in.
@ $7E03 label=MainLoop_Records
  $7E03,$04 Fetch the low byte of FRAMES into #REGc (using #REGa).
  $7E07,$03 Fetch the FRAMES value from the previous pass.
  $7E0A,$04 Call #R$7EB2 if FRAMES has changed since it was last stored in
. #R$5E03.
  $7E0E,$03 Point #REGhl at the address for the handler to return to at #R$7E13.
  $7E11,$02 Jump to #R$7E7E to process the record.
@ $7E13 label=MainLoop_NextRecord
  $7E13,$03 #REGde=#N($0010,$04,$04) (the size of a record).
  $7E16,$02 Move #REGix on to the next record.
  $7E18,$03 Copy #REGix to #REGhl (using the stack).
  $7E1B,$03 Point #REGde at the end of the entity table at #R$EEE0.
  $7E1E,$05 Jump back to #R$7E03 until #REGix reaches #R$EEE0.

c $7E23 Draw Room
@ $7E23 label=DrawRoom
D $7E23 Reached at the end of every pass of #R$7DC3. Looks up the list of
. items for the current room in #R$757D and runs the handler of each
. one through #R$7E93. Each entry in a list is the address of an item
. record in the initial entity data at #R$600D.
. Once the list is finished the counter at #R$5E12 is incremented and, on
. the first pass, #R$9291 draws all of the entities in the room and bit 0
. of #R$5E14 is set. The random number seed at #R$5E05 is then stirred,
. the pick-up key, the pause keys and the food are dealt with and the main
. loop is restarted, unless the player is in room #N$8E, which ends the game
. with #R$96EC.
N $7E23 #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DC3,clear=1,sp=$5E00)
. #SCR$01(draw-room-before)
. | #SIM(start=$7DC3,stop=$7DDC,sp=$5E00)
. #SCR$01(draw-room-after) } UDGTABLE# #POPS
  $7E23,$03 Fetch the room of the player.
  $7E26,$04 Double the room number to create an offset in #REGhl.
  $7E2A,$04 Find the entry for the room in the table of item lists at #R$757D.
  $7E2E,$04 Fetch the address of the list of items for the room.
  $7E32,$03 Update the room pointer in #R$5E1B.
N $7E35 Each pass of this loop reads one item from the list.
@ $7E35 label=Decor_Loop
  $7E35,$03 Fetch the pointer to the next entry in the list of items.
  $7E38,$01 Fetch the low byte of the item address.
  $7E39,$05 Move on to the next entry in the list and write the pointer to
. #R$5E1B.
  $7E3E,$03 Fetch the address of the item.
  $7E41,$03 Jump to #R$7E93 to process the item if the list has not ended (the
. item address is not zero).
N $7E44 The list is finished (it is terminated by an address of #N$0000).
  $7E44,$07 Increment the counter held in #R$5E12 by one.
  $7E4B,$07 Jump to #R$7E55 if bit 0 of #R$5E14 is set (the entities are drawn).
  $7E52,$03 Call #R$9291 to draw the entities in this room.
@ $7E55 label=DrawRoom_Finish
  $7E55,$05 Set bit 0 of #R$5E14.
N $7E5A Stir the random number seed with FRAMES and the counter.
  $7E5A,$03 Fetch the random seed.
  $7E5D,$04 Fetch FRAMES.
  $7E61,$01 Add FRAMES to the random seed.
  $7E62,$03 Fetch the low byte of the counter.
  $7E65,$02 Add the counter to the random seed.
  $7E67,$03 Store the new random seed.
N $7E6A Read the pick-up key, check for the game being paused and spawn food.
  $7E6A,$03 Call #R$938B to read the key to pick up an item.
  $7E6D,$03 Call #R$9489 to check whether the game is paused.
  $7E70,$03 Call #R$9924 to spawn the food.
N $7E73 Finish the game if the player has reached the final room.
  $7E73,$03 Fetch the room of the player.
  $7E76,$05 Jump to #R$96EC if the player is in room #N$8E.
  $7E7B,$03 Jump back to #R$7DC3 to run the next pass of the main loop.

c $7E7E Process Action
@ $7E7E label=ProcessAction
D $7E7E Calls the handler of an entity. The handler's address is read from
. #R$7EE6, indexed by the first byte of the entity record, and entered
. through the #N$E9 (JP (HL)) at #N$5CB0. The entry point at #R$7E7F is used
. when the return address has already been stacked, and the one at #R$7E82
. when the table of handlers in #REGhl is not #R$7EE6.
R $7E7E IX The entity
R $7E7E HL The address for the handler to return to
  $7E7E,$01 Stash the return address on the stack.
@ $7E7F label=ProcessAction_Dispatch
  $7E7F,$03 Point #REGhl at the handler table at #R$7EE6.
N $7E82 Double the first byte of the entity to create an offset in #REGbc.
@ $7E82 label=ProcessAction_Lookup
  $7E82,$03 Fetch the first byte of the entity, which is its sprite ID.
@ $7E85 label=ProcessAction_Offset
  $7E85,$02 #REGb=#N$00.
  $7E87,$04 Double #REGbc, which gives two bytes for each sprite ID.
  $7E8B,$01 Find the entry for the entity in the handler table.
  $7E8C,$04 Fetch the address of the handler.
  $7E90,$03 Jump to the handler, using the #N$E9 (JP (HL)) at #N$5CB0.

c $7E93 Process Room Item
@ $7E93 label=ProcessRoomItem
D $7E93 Runs the handler of one of the items in a room's list (see
. #R$7E23). The list entry is the address of the item in the initial
. entity data; subtracting #N$757D converts it to the address of the
. live record. Door records are two 8-byte halves (one for each of the
. two rooms they join), so the second half is used if the first is not
. for the current room. The handler is looked up in #R$802A and returns
. to #R$7E35.
R $7E93 HL The list entry
  $7E93,$04 Stash #R$7E35 on the stack as the address for the handler to return
. to.
  $7E97,$06 Subtract #N$757D from the address of the item to get the address of
. the live record.
  $7E9D,$03 Copy #REGhl to #REGix (using the stack).
  $7EA0,$03 Fetch the room of the player.
  $7EA3,$05 Jump to #R$7EAD if the item is in the same room as the player.
  $7EA8,$05 Move #REGix on to the second half of the record (#N$08 bytes on).
@ $7EAD label=ProcessRoomItem_Dispatch
  $7EAD,$03 Point #REGhl at the handler table 2 at #R$802A.
  $7EB0,$02 Jump to #R$7E82 to turn the first byte of the entity into an offset.

c $7EB2 Update Fixed Entities
@ $7EB2 label=UpdateFixedEntities
D $7EB2 Called whenever FRAMES has changed. Runs the handlers of the three
. entities at #R$EA90, ticks the clock with #R$95DA and records the
. new value of FRAMES in #R$5E03. #R$5E04 is set while the handlers
. are running.
  $7EB2,$01 Disable interrupts.
  $7EB3,$02 Stash #REGix on the stack.
  $7EB5,$05 Set the flag in #R$5E04 that shows the handlers are running.
  $7EBA,$04 Point #REGix at the player at #R$EA90.
@ $7EBE label=UpdateFixedEntities_Loop
  $7EBE,$03 Point #REGhl at the address for the handler to return to at #R$7EC5.
  $7EC1,$01 Stash the return address on the stack.
  $7EC2,$03 Jump to #R$7E7F to run the handler.
@ $7EC5 label=UpdateFixedEntities_Next
  $7EC5,$03 #REGde=#N($0008,$04,$04) (the size of an entity).
  $7EC8,$02 Move #REGix on to the next entity.
  $7ECA,$03 Copy #REGix to #REGhl (using the stack).
  $7ECD,$03 Point #REGde at the end of the fixed entities at #R$EAA8.
  $7ED0,$05 Loop back to #R$7EBE until all three entities are done.
  $7ED5,$03 Call #R$95DA to update the clock.
  $7ED8,$06 Write FRAMES to #R$5E03.
  $7EDE,$04 Clear the flag in #R$5E04 that shows the handlers are running.
  $7EE2,$02 Restore #REGix from the stack.
  $7EE4,$01 Enable interrupts.
  $7EE5,$01 Return.

w $7EE6 Handler Table
@ $7EE6 label=HandlerTable
D $7EE6 The address of the handler for each kind of 8-byte entity record,
. indexed by the first byte of the record (the sprite ID, see
. #R$A4BE). #R$7E7E reads the entry and calls the handler. The same handler is
. shared by all of the sprites of one kind of entity, so the knight sprites all
. point to #R$8E26, and so on. Entries that no entity uses point to #R$807A,
. which does nothing.
  $7EE6,$02 ID #N$00 (no sprite): #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
  $7EE8,$02 ID #N((#PC - $7EE6) / $02)
. (#SPRITENAME((#PC - $7EE6) / $02 - $01)):
. #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
L $7EE8,$02,$A1

w $802A Handler Table 2
@ $802A label=HandlerTable2
D $802A The address of the handler for each kind of room item, door or other
. fixture, indexed by the first byte of its record (the graphic ID, see
. #R$A600). #R$7E93 reads the entry and calls the handler. IDs that are not used
. point to #R$807A, which does nothing.
  $802A,$02 ID #N$00 (no graphic): #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
  $802C,$02 ID #N((#PC - $802A) / $02)
. (#GRAPHICNAME((#PC - $802A) / $02 - $01)):
. #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
L $802C,$02,$27

c $807A Create Delay
@ $807A label=CreateDelay
D $807A The handler for entities that have nothing to do. If the entity is one
. of the first three 16-byte records, which start at #R$EE60, then a short
. delay loop is run before returning. Otherwise it returns straight away.
R $807A IX The entity
  $807A,$03 Copy #REGix to #REGhl (using the stack).
  $807D,$03 Point #REGde at the creatures at #R$EE60.
  $8080,$03 Subtract #REGde from #REGhl, to get the offset of the entity into
. the 16-byte records.
  $8083,$03 Return if the high byte of the offset is not zero.
  $8086,$04 Return if the low byte of the offset is #N$30 or more.
  $808A,$03 #REGhl=#N($00C0,$04,$04) (the length of the delay).
@ $808D label=CreateDelay_Loop
  $808D,$01 Decrease the delay counter by one.
  $808E,$04 Loop back to #R$808D until the delay counter is zero.
  $8092,$01 Return.

c $8093 Clear Play Area
@ $8093 label=ClearPlayArea
D $8093 Clears the pixels of the play area, which is the left-hand #N$18 bytes
. of each of the #N$C0 rows of the screen buffer. The attributes are left
. alone.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SCR$01(clear-play-area-before)
. | #SIM(start=$8093,stop=$0000,sp=$5B60)
. #SCR$01(clear-play-area-after) } UDGTABLE# #POPS
  $8093,$03 #REGhl=#N$4000 (the start of the screen buffer).
  $8096,$03 #REGb=#N$18 (the number of bytes to clear in each row) and
. #REGc=#N$C0 (the number of rows).
  $8099,$01 #REGa=#N$00 (the value to write).
N $809A Each pass of this loop clears one row.
@ $809A label=ClearPlayArea_Row
  $809A,$01 Stash the counters on the stack.
  $809B,$01 Stash the row address on the stack.
  $809C,$03 #REGde=#N($0020,$04,$04) (the size of a row).
@ $809F label=ClearPlayArea_Byte
  $809F,$01 Write #REGa to *#REGhl.
  $80A0,$01 Move #REGhl on to the next byte.
  $80A1,$02 Decrease the byte counter by one and loop back to #R$809F until the
. whole row has been cleared.
  $80A3,$01 Restore the row address from the stack.
  $80A4,$01 Move #REGhl on to the next row.
  $80A5,$01 Restore the counters from the stack.
  $80A6,$03 Decrease the row counter by one and loop back to #R$809A until all
. #N$C0 rows have been cleared.
  $80A9,$01 Return.

c $80AA Clear Screen
@ $80AA label=ClearScreen
D $80AA Clears the attributes and the pixels of the whole screen, and sets the
. border to black.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SCR$01(clear-screen-before)
. | #SIM(start=$80AA,stop=$0000,sp=$5B60)
. #SCR$01(clear-screen-after) } UDGTABLE# #POPS
E $80AA View the equivalent code in;
. #LIST
. { #COOKIE$5FB7 }
. { #PSSST$5F53 }
. LIST#
  $80AA,$03 Call #R$80C2 to clear the attribute buffer.
  $80AD,$03 Call #R$80B4 to clear the screen buffer.
  $80B0,$03 Set the border to #INK$00.
  $80B3,$01 Return.

c $80B4 Reset Screen Buffer
@ $80B4 label=ResetScreen
D $80B4 Points at the start of the screen buffer and fills it with #N$00.
E $80B4 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE60 }
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
E $80B4 Continue on to #R$80BB to blank the screen buffer.
  $80B4,$03 #REGhl=#N$4000 (the start of the screen buffer).
  $80B7,$02 #REGb=#N$58 (i.e. finish once we reach the start of the attribute
. buffer at #N$5800).
@ $80B9 label=ResetScreen_Fill
  $80B9,$02 Set the value to write in #REGc to #N$00.

c $80BB Fill Memory
@ $80BB label=ResetCopier
D $80BB Writes a single byte to memory from the target address, up to (but not
. including) the first address whose high byte is the end value.
E $80BB View the equivalent code in;
. #LIST
. { #COOKIE$74DB }
. { #JETPAC$71BF }
. { #LUNARJETMAN$84B4 }
. { #PSSST$7440 }
. { #SABREWULF$BB88 }
. { #TRANZAM$7218 }
. LIST#
R $80BB HL Target address
R $80BB B The high byte of the end address (the fill stops at an LSB of #N$00)
R $80BB C Value to write
  $80BB,$01 Write the fill value to the byte at the target address.
  $80BC,$01 Move on to the next address.
  $80BD,$04 Loop back to #R$80BB until the target address has reached the end
. address.
  $80C1,$01 Return.

c $80C2 Reset Attribute Buffer
@ $80C2 label=ResetAttributes
D $80C2 Points at the attribute buffer and jumps into #R$80BB to fill it with
. #N$00.
E $80C2 View the equivalent code in;
. #LIST
. { #COOKIE$74E2 }
. { #JETPAC$71C6 }
. { #LUNARJETMAN$84BB }
. { #PSSST$7447 }
. { #SABREWULF$BB8F }
. { #TRANZAM$7200 }
. LIST#
  $80C2,$03 #REGhl=#N$5800 (the start of the attribute buffer).
  $80C5,$02 #REGb=#N$5B (i.e. finish once we reach the end of the attribute
. buffer).
  $80C7,$02 Set the value to write in #REGc to #N$00.
  $80C9,$02 Jump to #R$80BB to fill the memory.

c $80CB Reset Player Data
@ $80CB label=ResetPlayerData
D $80CB Clears the game variables by filling memory from #R$5E10 up to #N$5FFF
. with #N$00. This leaves the game options and font pointer alone.
  $80CB,$03 Point #REGhl at the sprite width at #R$5E10.
  $80CE,$02 #REGb=#N$60 (i.e. finish once we reach #N$6000).
  $80D0,$02 Jump to #R$80B9 to fill the memory with the value to write.

c $80D2 Handle Wizard
@ $80D2 label=HandlerWizard
D $80D2 The handler for the wizard, which has the sprite IDs #N$11 to #N$20.
. The speed limits and the friction are passed to #R$8D77, which reads the
. controls and moves the player. Then, every fourth frame while the player is
. moving, the walking frame is advanced and the sprite is turned to face the
. direction of the strongest movement. If the fire button is pressed then a
. fireball is thrown by #R$814B. The routine finishes by jumping to the code
. that is shared with the other characters at #R$8E78.
R $80D2 IX The player entity
N $80D2 Control the player. #REGbc holds the speed limits (#REGc for X and
. #REGb for Y, where #REGb is also the acceleration) and #REGde holds the
. friction (#REGe for X and #REGd for Y). #REGhl is not used by #R$8D77.
  $80D2,$03 Set the speed limits in #REGbc to #N$20 on both axes.
  $80D5,$03 Set the friction in #REGde to #N$20 on both axes.
  $80D8,$03 #REGhl=#N($2020,$04,$04), which is not used by #R$8D77.
  $80DB,$03 Call #R$8D77 to control the player.
N $80DE Only change the walking frame if the player is moving.
  $80DE,$03 Fetch the X velocity of the player into #REGe.
  $80E1,$03 Fetch the Y velocity of the player into #REGd.
  $80E4,$04 Jump to #R$811D if the player is not moving.
N $80E8 The walking frame only changes every fourth frame.
  $80E8,$03 Fetch FRAMES.
  $80EB,$02,b$01 Keep only bits 0-1.
  $80ED,$02 Jump to #R$811D if the result is not zero.
N $80EF Move on to the next of the four walking frames.
  $80EF,$03 Fetch the sprite ID of the player.
  $80F2,$02,b$01 Keep only bits 0-1.
  $80F4,$02 Add #N$11, which gives the next walking frame.
  $80F6,$03 Write the new sprite ID back to the player.
N $80F9 Make a copy of the Y speed, ignoring the direction.
  $80F9,$05 Fetch the Y velocity from #REGd, then jump to #R$8100 if it is
. positive.
  $80FE,$02 Make the Y speed positive.
@ $8100 label=HandlerWizard_AbsoluteX
  $8100,$01 Keep the Y speed in #REGc.
N $8101 Make a copy of the X speed, ignoring the direction.
  $8101,$05 Fetch the X velocity from #REGe, then jump to #R$8108 if it is
. positive.
  $8106,$02 Make the X speed positive.
@ $8108 label=HandlerWizard_CompareAxes
  $8108,$03 Jump to #R$8128 if the X speed is the strongest movement.
N $810B The Y movement is the strongest, so face up or down.
  $810B,$02 Test the sign of the Y velocity.
  $810D,$03 Fetch the sprite ID of the player.
  $8110,$03 Jump to #R$8115 if the player is moving up.
  $8113,$02 Add #N$04 to select the sprites for moving down.
@ $8115 label=HandlerWizard_Vertical
  $8115,$02 Add #N$08.
@ $8117 label=HandlerWizard_SetSprite
  $8117,$03 Write the new sprite ID back to the player.
  $811A,$03 Call #R$A3C7 to make the walking sound.
N $811D Check if the fire button is being pressed.
@ $811D label=HandlerWizard_Fire
  $811D,$03 Call #R$93BE to read the controls.
  $8120,$02,b$01 Keep only bit 4.
  $8122,$03 Call #R$814B if the fire button is pressed.
  $8125,$03 Jump to #R$8E78 to finish handling the character.
N $8128 The X movement is the strongest, so face left or right.
@ $8128 label=HandlerWizard_Horizontal
  $8128,$02 Test the sign of the X velocity.
  $812A,$03 Fetch the sprite ID of the player.
  $812D,$03 Jump to #R$8117 if the player is moving left.
  $8130,$02 Add #N$04 to select the sprites for moving right.
  $8132,$02 Jump to #R$8117 to set the sprite of the wizard.

c $8134 Throw Axe
@ $8134 label=ThrowAxe
D $8134 Launches an axe for the knight, unless a weapon is already in flight or
. the player is in a doorway. The axe sprites have the IDs #N$40 to #N$47
. and are animated by #R$81DB.
R $8134 IX The player entity
  $8134,$05 Return if a weapon is already in flight.
  $8139,$05 Return if the player is in a doorway.
  $813E,$03 Call #R$A41B to make the axe throwing sound.
  $8141,$03 Call #R$817C to set the velocity of the weapon.
  $8144,$03 Point #REGhl at the player weapon at #R$EA98.
  $8147,$02 Write #N$40 to the weapon, the sprite ID of the first axe frame.
  $8149,$02 Jump to #R$8160 to launch the axe.

c $814B Throw Fireball
@ $814B label=ThrowFireball
D $814B Launches a fireball for the wizard, unless a weapon is already in
. flight or the player is in a doorway. The fireball sprites have the IDs
. #N$34 to #N$37 and are animated by #R$81F0.
R $814B IX The player entity
  $814B,$05 Return if a weapon is already in flight.
  $8150,$05 Return if the player is in a doorway.
  $8155,$03 Call #R$A438 to make the fireball sound.
  $8158,$03 Call #R$817C to set the velocity of the weapon.
  $815B,$03 Point #REGhl at the player weapon at #R$EA98.
  $815E,$02 Write #N$34 to the weapon, the sprite ID of the first fireball
. frame.
N $8160 Place the weapon in the same room as the player, at the position of the
. player, and draw it.
@ $8160 label=LaunchWeapon
  $8160,$01 Move #REGhl on to the room of the weapon.
  $8161,$03 Fetch the room of the player.
  $8164,$01 Write the room of the player to the room of the weapon.
  $8165,$02 Move #REGhl on to the X position of the weapon.
  $8167,$03 Fetch the X position of the player.
  $816A,$01 Write the X position of the player to the X position of the weapon.
  $816B,$01 Move #REGhl on to the Y position of the weapon.
  $816C,$03 Fetch the Y position of the player.
  $816F,$01 Write the Y position of the player to the Y position of the weapon.
  $8170,$02 Stash the player entity on the stack.
  $8172,$04 Point #REGix at the weapon at #R$EA98.
  $8176,$03 Call #R$9F4A to draw the weapon.
  $8179,$02 Restore the player entity from the stack.
  $817B,$01 Return.

c $817C Set Weapon Velocity
@ $817C label=SetWeaponVelocity
D $817C Gets a weapon ready to be launched. The lifetime of the weapon is set
. to #N$30 and its flags are cleared. The velocity is #N$04 pixels per frame
. in the direction that the player is moving, or if the player is standing
. still then in the direction that the player is facing.
R $817C IX The player entity
N $817C Reset the weapon.
  $817C,$03 Point #REGhl at the X velocity of the weapon at #R$EA9E.
  $817F,$05 Write #N$30 to #N$EAA7 (the lifetime of the weapon).
  $8184,$05 Write #N$00 to #N$EA9A (the flags of the weapon).
N $8189 If the player is moving then the weapon follows the direction of the
. movement.
  $8189,$03 Fetch the X velocity of the player.
  $818C,$05 Jump to #R$81B3 if the player is not moving.
  $8191,$03 Fetch the X velocity of the player.
  $8194,$03 Jump to #R$81A0 if the player is not moving horizontally.
  $8197,$03 Jump to #R$819E if the player is moving left.
  $819A,$02 #REGa=#N$04 (the velocity for moving right).
  $819C,$02 Jump to #R$81A0 to store the X velocity of the weapon.
@ $819E label=SetWeaponVelocity_Left
  $819E,$02 #REGa=#N$FC (-#N$04, the velocity for moving left).
@ $81A0 label=SetWeaponVelocity_StoreX
  $81A0,$01 Update the X velocity of the weapon.
  $81A1,$01 Move #REGhl on to the Y velocity of the weapon.
  $81A2,$03 Fetch the Y velocity of the player.
  $81A5,$03 Jump to #R$81B1 if the player is not moving vertically.
  $81A8,$03 Jump to #R$81AF if the player is moving up.
  $81AB,$02 #REGa=#N$04 (the velocity for moving down).
  $81AD,$02 Jump to #R$81B1 to store the Y velocity of the weapon.
@ $81AF label=SetWeaponVelocity_Up
  $81AF,$02 #REGa=#N$FC (-#N$04, the velocity for moving up).
@ $81B1 label=SetWeaponVelocity_StoreY
  $81B1,$01 Update the Y velocity of the weapon.
  $81B2,$01 Return.
N $81B3 The player is standing still, so use the direction that the sprite is
. facing.
@ $81B3 label=SetWeaponVelocity_Facing
  $81B3,$03 Fetch the sprite ID of the player.
  $81B6,$01 Decrease #REGa by one.
  $81B7,$02,b$01 Keep only bits 2-3, which is the direction.
  $81B9,$02 Jump to #R$81C9 if the player is facing left.
  $81BB,$04 Jump to #R$81CF if the player is facing right.
  $81BF,$04 Jump to #R$81D5 if the player is not facing up.
  $81C3,$02 Write #N$00 to the X velocity of the weapon.
  $81C5,$01 Move #REGhl on to the Y velocity of the weapon.
  $81C6,$02 Write #N$FC (-#N$04) to the Y velocity of the weapon.
  $81C8,$01 Return.
@ $81C9 label=SetWeaponVelocity_FacingLeft
  $81C9,$02 Write #N$FC (-#N$04) to the X velocity of the weapon.
  $81CB,$01 Move #REGhl on to the Y velocity of the weapon.
  $81CC,$02 Write #N$00 to the Y velocity of the weapon.
  $81CE,$01 Return.
@ $81CF label=SetWeaponVelocity_FacingRight
  $81CF,$02 Write #N$04 to the X velocity of the weapon.
  $81D1,$01 Move #REGhl on to the Y velocity of the weapon.
  $81D2,$02 Write #N$00 to the Y velocity of the weapon.
  $81D4,$01 Return.
@ $81D5 label=SetWeaponVelocity_FacingDown
  $81D5,$02 Write #N$00 to the X velocity of the weapon.
  $81D7,$01 Move #REGhl on to the Y velocity of the weapon.
  $81D8,$02 Write #N$04 to the Y velocity of the weapon.
  $81DA,$01 Return.

c $81DB Handle Axe
@ $81DB label=HandlerAxe
D $81DB The handler for a thrown axe, which has the sprite IDs #N$40 to #N$47.
. Picks the animation frame from FRAMES, sets the attribute and then runs the
. movement code that is shared by all of the weapons at #R$8209.
R $81DB IX The weapon entity
  $81DB,$03 Call #R$9FFB to save the position of the weapon.
  $81DE,$03 Fetch FRAMES.
  $81E1,$01 Invert the bits.
  $81E2,$01 Rotate #REGa right (the frame changes on every other tick).
  $81E3,$02,b$01 Keep only bits 0-2 (there are 8 animation frames).
  $81E5,$02 Add #N$40 to point to the correct frame/ sprite ID (the axe base
. sprite ID is: #R($A4BC + $40 * $02)(#N$40)).
  $81E7,$03 Write the new frame/ sprite ID back to the entity.
  $81EA,$04 Set the attribute of the axe to #COLOUR$42.
  $81EE,$02 Jump to #R$8209 to move the weapon.

c $81F0 Handle Fireball
@ $81F0 label=HandlerFireball
D $81F0 The handler for a fireball, which has the sprite IDs #N$34 to #N$37.
. Advances the animation frame and flickers the colour.
E $81F0 Continue on to #R$8209.
R $81F0 IX The weapon entity
  $81F0,$03 Call #R$9FFB to save the position of the weapon.
  $81F3,$04 Fetch the sprite ID of the fireball and add one, to move on to the
. next frame.
  $81F7,$02,b$01 Keep only bits 0-1 (there are 4 animation frames).
  $81F9,$02 Add #N$34 to point to the correct frame/ sprite ID (the fireball
. base sprite ID is: #R($A4BC + $34 * $02)(#N$34)).
  $81FB,$03 Write the new frame/ sprite ID back to the entity.
  $81FE,$03 Fetch FRAMES.
  $8201,$01 Rotate #REGa left, which moves bit 0 into bit 1.
  $8202,$02,b$01 Keep only bit 1.
  $8204,$02 Add #N$45 to get an attribute of #COLOUR$45 or #COLOUR$47.
  $8206,$03 Set the attribute of the fireball.

c $8209 Handle Weapon
@ $8209 label=HandlerWeapon
D $8209 The movement code that is shared by the axe, the fireball and the
. sword. The weapon is removed if the player has left the room, if its
. lifetime (held in #N$EAA7) has run out, or if it has hit something (bit 0
. of the flags is set). Otherwise it moves by its velocity, bouncing off the
. walls of the room by reversing the velocity on the axis that was crossed.
R $8209 IX The weapon entity
N $8209 Remove the weapon if the player is not in the same room.
  $8209,$04 #REGde=*#R$5E1D (#REGe is the width of the room and #REGd is the
. height).
  $820D,$03 Fetch the room of the player.
  $8210,$05 Jump to #R$827E if the weapon is not in the same room as the player.
N $8215 Remove the weapon if it has run out of time, or it has hit something.
  $8215,$05 Decrease the lifetime of the weapon by one and jump to #R$826F if it
. is zero.
  $821A,$06 Jump to #R$826F if bit 0 of the flags of the weapon is set.
N $8220 Work out the new X position of the weapon and check it is inside the
. room.
  $8220,$03 Fetch the X position of the weapon.
  $8223,$03 Add the X velocity of the weapon.
  $8226,$01 Keep the new X position in #REGc.
  $8227,$02 Subtract #N$58 (the centre of the room).
  $8229,$05 Jump to #R$822E if the result is positive, otherwise make it
. positive.
@ $822E label=HandlerWeapon_CheckX
  $822E,$03 Jump to #R$825D if the weapon has crossed the left or right wall of
. the room.
N $8231 Work out the new Y position of the weapon and check it is inside the
. room.
@ $8231 label=HandlerWeapon_CheckY
  $8231,$03 Fetch the Y position of the weapon.
  $8234,$03 Add the Y velocity of the weapon.
  $8237,$01 Keep the new Y position in #REGb.
  $8238,$02 Subtract #N$68 (the centre of the room).
  $823A,$05 Jump to #R$823F if the result is positive, otherwise make it
. positive.
@ $823F label=HandlerWeapon_CheckYLimit
  $823F,$03 Jump to #R$824B if the weapon has crossed the top or bottom wall of
. the room.
N $8242 Move the weapon to its new position, and display it.
@ $8242 label=HandlerWeapon_Move
  $8242,$03 Update the X position of the weapon.
  $8245,$03 Update the Y position of the weapon.
  $8248,$03 Jump to #R$8E8E to display the weapon.
N $824B The weapon has hit the top or bottom wall, so bounce it back.
@ $824B label=HandlerWeapon_BounceY
  $824B,$03 Keep the current Y position in #REGb.
  $824E,$03 Fetch the Y velocity of the weapon.
  $8251,$02 Reverse the direction of the Y velocity.
  $8253,$03 Update the Y velocity of the weapon.
  $8256,$01 Stash the position on the stack.
  $8257,$03 Call #R$A4B0 to make the bounce sound.
  $825A,$01 Restore the position from the stack.
  $825B,$02 Jump to #R$8242 to move the weapon to its new position.
N $825D The weapon has hit the left or right wall, so bounce it back.
@ $825D label=HandlerWeapon_BounceX
  $825D,$03 Keep the current X position in #REGc.
  $8260,$03 Fetch the X velocity of the weapon.
  $8263,$02 Reverse the direction of the X velocity.
  $8265,$03 Update the X velocity of the weapon.
  $8268,$01 Stash the position on the stack.
  $8269,$03 Call #R$A4B0 to make the bounce sound.
  $826C,$01 Restore the position from the stack.
  $826D,$02 Jump to #R$8231 to check the new Y position of the weapon.
N $826F The weapon has finished, so remove it from the screen and restore the
. colour of the room.
@ $826F label=HandlerWeapon_Expire
  $826F,$03 Call #R$9F56 to remove the weapon from the screen.
  $8272,$03 Call #R$A445 to make the pop sound.
  $8275,$03 Fetch the room attribute.
  $8278,$03 Set the attribute of the weapon to the room attribute.
  $827B,$03 Call #R$A01A to set the attributes of the cells that the weapon
. covered.
N $827E The weapon is no longer in use.
@ $827E label=HandlerWeapon_Remove
  $827E,$04 Clear the sprite ID of the weapon, which means it is no longer in
. use.
  $8282,$01 Return.

c $8283 Throw Sword
@ $8283 label=ThrowSword
D $8283 Launches a sword for the serf, unless a weapon is already in flight or
. the player is in a doorway. The sprite ID of the sword depends on the
. direction that the weapon is travelling in (#N$38 to #N$3F), as worked out
. by the same method that #R$82C3 uses.
R $8283 IX The player entity
  $8283,$05 Return if a weapon is already in flight.
  $8288,$05 Return if the player is in a doorway.
  $828D,$03 Call #R$A427 to make the sword sound.
  $8290,$03 Call #R$817C to set the velocity of the weapon.
  $8293,$02 #REGc=#N$00 (the direction number for down).
N $8295 #REGhl points at the Y velocity of the weapon.
  $8295,$01 Fetch the Y velocity of the weapon.
  $8296,$03 Jump to #R$82B6 if the weapon is not moving vertically.
  $8299,$03 Jump to #R$829E if the weapon is moving down.
  $829C,$02 #REGc=#N$04 (the direction number for up).
@ $829E label=ThrowSword_CheckX
  $829E,$01 Point #REGhl at the X velocity of the weapon.
  $829F,$01 Fetch the X velocity of the weapon.
  $82A0,$03 Jump to #R$82A7 if the weapon is not moving horizontally.
  $82A3,$03 Jump to #R$82B3 if the weapon is moving right.
  $82A6,$01 Decrease the direction number by one, as the weapon is moving left.
@ $82A7 label=ThrowSword_SetSprite
  $82A7,$01 Fetch the direction number.
  $82A8,$02,b$01 Keep only bits 0-2 (there are 8 sword sprites).
  $82AA,$02 Add #N$38 to point to the correct sprite ID (the sword base sprite
. ID is: #R($A4BC + $38 * $02)(#N$38)).
  $82AC,$03 Point #REGhl at the player weapon at #R$EA98.
  $82AF,$01 Write the sprite ID to the weapon.
  $82B0,$03 Jump to #R$8160 to launch the sword.
@ $82B3 label=ThrowSword_Right
  $82B3,$01 Increase the direction number by one, as the weapon is moving right.
  $82B4,$02 Jump to #R$82A7 to set the sprite of the sword.
N $82B6 The weapon is moving horizontally only.
@ $82B6 label=ThrowSword_Horizontal
  $82B6,$01 Point #REGhl at the X velocity of the weapon.
  $82B7,$04 Jump to #R$82BF if the weapon is moving right.
  $82BB,$02 #REGc=#N$06 (the direction number for left).
  $82BD,$02 Jump to #R$82A7 to set the sprite of the sword.
@ $82BF label=ThrowSword_MovingRight
  $82BF,$02 #REGc=#N$02 (the direction number for right).
  $82C1,$02 Jump to #R$82A7 to set the sprite of the sword.

c $82C3 Set Sword Direction
@ $82C3 label=SwordDirection
D $82C3 Chooses the sprite of the sword in flight from its velocity. The sprite
. ID is #N$38 plus a direction number from #N$00 to #N$07, which is worked out
. in #REGc from the signs of the Y and X velocities of the weapon.
R $82C3 HL The address of the Y velocity of the weapon
  $82C3,$02 #REGc=#N$00 (the direction number for down).
  $82C5,$04 Jump to #R$82E4 if the weapon is not moving vertically.
  $82C9,$03 Jump to #R$82CE if the weapon is moving down.
  $82CC,$02 #REGc=#N$04 (the direction number for up).
@ $82CE label=SwordDirection_CheckX
  $82CE,$01 Point #REGhl at the X velocity of the weapon.
  $82CF,$01 Fetch the X velocity of the weapon.
  $82D0,$03 Jump to #R$82D7 if the weapon is not moving horizontally.
  $82D3,$03 Jump to #R$82E1 if the weapon is moving right.
  $82D6,$01 Decrease the direction number by one, as the weapon is moving left.
@ $82D7 label=SwordDirection_SetSprite
  $82D7,$01 Fetch the direction number.
  $82D8,$02,b$01 Keep only bits 0-2 (there are 8 animation frames).
  $82DA,$02 Add #N$38 to point to the correct frame/ sprite ID (the sword base
. sprite ID is: #R($A4BC + $38 * $02)(#N$38)).
  $82DC,$03 Point #REGhl at the player weapon at #R$EA98.
  $82DF,$01 Write the new frame/ sprite ID to the weapon.
  $82E0,$01 Return.
@ $82E1 label=SwordDirection_Right
  $82E1,$01 Increase the direction number by one, as the weapon is moving right.
  $82E2,$02 Jump to #R$82D7 to set the sprite of the sword.
N $82E4 The weapon is moving horizontally only.
@ $82E4 label=SwordDirection_Horizontal
  $82E4,$01 Point #REGhl at the X velocity of the weapon.
  $82E5,$04 Jump to #R$82ED if the weapon is moving right.
  $82E9,$02 #REGc=#N$06 (the direction number for left).
  $82EB,$02 Jump to #R$82D7 to set the sprite of the sword.
@ $82ED label=SwordDirection_MovingRight
  $82ED,$02 #REGc=#N$02 (the direction number for right).
  $82EF,$02 Jump to #R$82D7 to set the sprite of the sword.

c $82F1 Handle Sword
@ $82F1 label=HandlerSword
D $82F1 The handler for a thrown sword, which has the sprite IDs #N$38 to #N$3F.
. Sets the attribute, points the sprite in the direction of travel and then
. runs the movement code that is shared by all of the weapons.
R $82F1 IX The weapon entity
  $82F1,$03 Call #R$9FFB to save the position of the weapon.
  $82F4,$04 Set the attribute of the sword to #COLOUR$46.
  $82F8,$03 Point #REGhl at the Y velocity of the weapon at #R$EA9F.
  $82FB,$03 Call #R$82C3 to choose the sprite of the sword.
  $82FE,$03 Jump to #R$8209 to move the weapon.

c $8301 Handle Bat
@ $8301 label=HandlerBatlet
D $8301 The handler for a bat, which has the sprite IDs #N$6A and #N$6B. If the
. player is in another room then #R$85F0 counts the bat down until it is
. removed. Otherwise the bat is counted, tested for touching the player (see
. #R$85B2) and for being hit by a weapon (see #R$8566), and then it flies.
. The step it is on in its flight pattern is held at offset #N$09 of the
. entity, and #R$83CA holds the distance to fly on each axis for each step.
. The low bits of offset #N$08 hold the direction: bit 0 is set when moving
. right, bit 1 is set when moving down and bit 2 swaps which of the two
. distances is used for each axis. The bat turns around at the walls.
R $8301 IX The bat entity
  $8301,$03 Fetch the room of the player from #R$EA91.
  $8304,$06 Jump to #R$85F0 if the bat is not in the same room as the player.
  $830A,$03 Call #R$9FFB to save the position of the bat.
  $830D,$03 Point #REGhl at the number of creatures at #R$5E25.
  $8310,$01 Increment the number of creatures by one.
N $8311 Check whether the bat has touched the player or been hit by a weapon.
  $8311,$03 Call #R$85B2 to check whether the entity is touching the player.
  $8314,$04 Jump to #R$85EA if the bat touched the player.
  $8318,$03 Call #R$8566 to check whether the weapon has hit the entity.
  $831B,$04 Jump to #R$875F if the bat was hit by a weapon.
  $831F,$04 Write #N$00 to offset #N$0F of the bat, so it is not removed.
  $8323,$04 Fetch the size of the room from #R$5E1D.
N $8327 Move on to the next step of the pattern. A new direction is chosen every
. sixteen steps.
  $8327,$03 Fetch the step of the flight pattern.
  $832A,$01 Increment #REGa by one.
  $832B,$02,b$01 Keep only bits 0-3.
  $832D,$03 Write #REGa back to the bat.
  $8330,$03 Jump to #R$833A unless the pattern has restarted.
  $8333,$02 Fetch a random number (from the refresh register).
  $8335,$02,b$01 Keep only bits 0-2.
  $8337,$03 Update the direction of the bat.
N $833A Move the bat vertically.
@ $833A label=HandlerBatlet_Move
  $833A,$03 Call #R$83BA to get the table entry for this step.
  $833D,$04 Set the attribute of the entity to #COLOUR$43.
  $8341,$02 Jump to #R$8344 if the axes are not swapped.
  $8343,$01 Move on to the second distance.
@ $8344 label=HandlerBatlet_MoveY
  $8344,$01 Fetch the distance to fly.
  $8345,$06 Jump to #R$834D if the bat is moving down.
  $834B,$02 Reverse the distance, so that the bat flies up.
@ $834D label=HandlerBatlet_AddY
  $834D,$03 Add the Y position of the bat.
  $8350,$01 Keep the new Y position in #REGc.
  $8351,$02 Subtract #N$68 (the vertical centre of the room).
  $8353,$02 Jump to #R$835A if the new position is above the centre.
  $8355,$03 Jump to #R$83A2 if the new position is beyond the bottom wall.
  $8358,$02 Jump to #R$835F to set the Y position of the bat.
@ $835A label=HandlerBatlet_CheckTop
  $835A,$02 Make the distance from the centre positive.
  $835C,$03 Jump to #R$83A8 if the new position is beyond the top wall.
@ $835F label=HandlerBatlet_SetY
  $835F,$03 Update the Y position of the bat.
N $8362 Move the bat horizontally.
@ $8362 label=HandlerBatlet_Horizontal
  $8362,$03 Call #R$83BA to get the table entry for this step.
  $8365,$02 Jump to #R$8368 if the axes are swapped.
  $8367,$01 Move on to the second distance.
@ $8368 label=HandlerBatlet_MoveX
  $8368,$01 Fetch the distance to fly.
  $8369,$06 Jump to #R$8371 if the bat is moving right.
  $836F,$02 Reverse the distance, so that the bat flies left.
@ $8371 label=HandlerBatlet_AddX
  $8371,$03 Add the X position of the bat.
  $8374,$01 Keep the new X position in #REGc.
  $8375,$02 Subtract #N$58 (the horizontal centre of the room).
  $8377,$02 Jump to #R$837E if the new position is left of the centre.
  $8379,$03 Jump to #R$83B4 if the new position is beyond the right wall.
  $837C,$02 Jump to #R$8383 to set the X position of the bat.
@ $837E label=HandlerBatlet_CheckLeft
  $837E,$02 Make the distance from the centre positive.
  $8380,$03 Jump to #R$83AE if the new position is beyond the left wall.
@ $8383 label=HandlerBatlet_SetX
  $8383,$03 Update the X position of the bat.
N $8386 Flap the wings, by changing the sprite every fourth step.
  $8386,$03 Fetch the step of the flight pattern.
  $8389,$02 Divide the step by four, so that the wings flap every fourth step.
  $838B,$02,b$01 Keep only bit 0.
  $838D,$01 Keep the wing frame in #REGc.
  $838E,$03 Fetch the sprite ID of the bat.
  $8391,$02,b$01 Reset bit 0.
  $8393,$01 Add the wing frame to the sprite ID.
  $8394,$03 Update the sprite ID of the bat.
N $8397 Remove the bat if the player is no longer in play, otherwise display it.
  $8397,$03 Fetch the sprite ID of the player from #R$EA90.
  $839A,$05 Jump to #R$875F if the player is no longer in play (the sprite ID is
. #N$31 or more).
  $839F,$03 Jump to #R$8E8E to display the bat.
N $83A2 The bat has reached a wall so reverse its direction.
@ $83A2 label=HandlerBatlet_TurnUp
  $83A2,$04 Reset bit 1 of the direction of the bat, so it moves up.
  $83A6,$02 Jump to #R$8362 to move the bat horizontally.
@ $83A8 label=HandlerBatlet_TurnDown
  $83A8,$04 Set bit 1 of the direction of the bat, so it moves down.
  $83AC,$02 Jump to #R$8362 to move the bat horizontally.
@ $83AE label=HandlerBatlet_TurnRight
  $83AE,$04 Set bit 0 of the direction of the bat, so it moves right.
  $83B2,$02 Jump to #R$8383 to set the X position of the bat.
@ $83B4 label=HandlerBatlet_TurnLeft
  $83B4,$04 Reset bit 0 of the direction of the bat, so it moves left.
  $83B8,$02 Jump to #R$8383 to set the X position of the bat.

c $83BA Get Bat Step
@ $83BA label=GetBatStep
D $83BA Looks up the distances for the current step of the flight pattern of a
. bat in #R$83CA. Bit 2 of the direction of the bat is returned in the Z flag
. (which is set when the axes are not swapped).
R $83BA IX The bat entity
R $83BA O:HL The address of the first of the two distances
  $83BA,$03 Fetch the step of the flight pattern.
  $83BD,$02 Double the step number, to get an offset of two bytes for each step.
  $83BF,$02 Clear the high byte of the offset.
  $83C1,$03 Point #REGhl at the bat flight pattern at #R$83CA.
  $83C4,$01 Find the entry for this step in the flight pattern.
  $83C5,$05 Test bit 2 of the direction of the bat, and return.

b $83CA Bat Flight Pattern
@ $83CA label=BatFlightPattern
D $83CA The distance for each axis for each of the sixteen steps of the flight
. pattern of a bat, as pairs of bytes. #R$83BA picks the pair for the step.
B $83CA,$20,$02

c $83EA Spawn Creature
@ $83EA label=SpawnCreature
D $83EA Called by the handlers of the characters. When the player enters a new
. room a delay of #N$20 is started (see #R$5E27). Once the delay has run
. out, and then at random about one time in sixteen, a creature is created
. in a free one of the first three 16-byte records at #R$EE60. The new
. record is a copy of #R$8B6A, in the current room and with a random
. position. It starts as a sparkle (see #R$85F7) that turns into the
. creature chosen by FRAMES from #R$8B7A.
N $83EA See if the player is in a different room to the last one a creature was
. made in.
  $83EA,$04 Fetch the room of the last creature from #R$5E26 and keep it in
. #REGc.
  $83EE,$03 Fetch the room of the player from #R$EA91.
  $83F1,$03 Jump to #R$844F if the player is in a different room.
  $83F4,$03 Point #REGhl at the creature delay at #R$5E27.
  $83F7,$01 Fetch the creature delay.
  $83F8,$03 Jump to #R$8458 if the delay is zero.
  $83FB,$01 Decrease the delay by one.
  $83FC,$01 Return if the delay is not zero yet.
N $83FD Look for a free record for the creature, in the first three of the
. 16-byte records.
@ $83FD label=SpawnCreature_Find
  $83FD,$03 Point #REGhl at the creatures at #R$EE60.
  $8400,$03 #REGde=#N($0010,$04,$04) (the size of a record).
  $8403,$02 #REGb=#N$03 (the number of records to look at).
@ $8405 label=SpawnCreature_FindLoop
  $8405,$01 Fetch the sprite ID of the record.
  $8406,$03 Jump to #R$840D if the record is free.
  $8409,$01 Move #REGhl on to the next record.
  $840A,$02 Decrease the record counter by one and loop back to #R$8405 until
. all three records have been checked.
  $840C,$01 Return.
N $840D Copy the default creature into the free record.
@ $840D label=SpawnCreature_Copy
  $840D,$01 Swap #REGde and #REGhl, so that #REGde is the free record.
  $840E,$03 Point #REGhl at the creature defaults at #R$8B6A.
  $8411,$03 #REGbc=#N($0010,$04,$04) (the size of a record).
  $8414,$01 Stash the record on the stack.
  $8415,$02 Copy the default creature into the record.
  $8417,$01 Restore the record from the stack.
  $8418,$01 Stash the record on the stack again.
  $8419,$01 Move #REGhl on to the room of the creature.
  $841A,$03 Fetch the room of the player from #R$EA91.
  $841D,$01 Update the room of the creature.
  $841E,$01 Move #REGhl on to offset #N$02 of the creature.
  $841F,$01 Stash it on the stack.
N $8420 The creature that it turns into is chosen from the table using the
. bottom four bits of FRAMES.
  $8420,$03 Point #REGhl at the creatures at #R$8B7A.
  $8423,$03 Fetch FRAMES.
  $8426,$02,b$01 Keep only bits 0-3.
  $8428,$01 Set the offset in #REGe to the bottom four bits of FRAMES.
  $8429,$02 Clear the high byte of the offset in #REGd.
  $842B,$01 Find the entry in the table of creatures.
  $842C,$01 Fetch the sprite ID of the creature to make.
  $842D,$01 Restore the address of offset #N$02 from the stack.
  $842E,$01 Set the type of the creature at offset #N$02.
N $842F Choose a random X and Y position inside the room.
  $842F,$04 Fetch the size of the room from #R$5E1D.
  $8433,$01 Set the limit for the X position in #REGb to the width of the room.
  $8434,$03 Call #R$8598 to pick a random coordinate.
  $8437,$01 Update the X position of the creature.
  $8438,$01 Set the limit for the Y position in #REGb to the height of the room.
  $8439,$03 Call #R$8598 to pick a random coordinate.
  $843C,$01 Update the Y position of the creature.
N $843D Give the creature a random velocity and draw it.
  $843D,$01 Restore the address of the record from the stack.
  $843E,$02 Stash the current entity on the stack.
  $8440,$06 Make #REGix point at the new creature (copy #REGde to #REGix).
  $8446,$03 Call #R$86F2 to give the creature a new random velocity.
  $8449,$03 Call #R$9F4A to draw the sparkle.
  $844C,$02 Restore the current entity from the stack.
  $844E,$01 Return.
N $844F The player is in a new room, so remember the room and start the delay.
@ $844F label=SpawnCreature_NewRoom
  $844F,$03 Update the room of the last creature in #R$5E26.
  $8452,$05 Write #N$20 to #R$5E27.
  $8457,$01 Return.
N $8458 There is no delay, so only make a creature one time in sixteen.
@ $8458 label=SpawnCreature_Random
  $8458,$02 Fetch a random number (from the refresh register).
  $845A,$02,b$01 Keep only bits 0-3.
  $845C,$01 Return if the result is not zero.
  $845D,$02 Jump back to #R$83FD to look at the next record.

c $845F Handle Pumpkin And Spider
@ $845F label=HandlerPumpkin
D $845F The handler for the pumpkin (sprite IDs #N$4C and #N$4D) and the spider
. (#N$5C and #N$5D). If the player is in another room then #R$85F0 counts the
. creature down until it is removed. Otherwise the creature is counted and
. checked for being hit by a weapon (#R$8566) or touching the player
. (#R$85B2). Offset #N$06 of the creature holds the direction it is heading
. in (bit 0 is set for right and bit 1 is set for down). A new direction is
. chosen at random every sixteen steps, and the velocities at offsets #N$08
. and #N$09 build up by one every other step towards #N$02 or -#N$02.
. The movement itself is done by #R$84CD.
R $845F IX The creature entity
  $845F,$03 Call #R$9FFB to save the position of the creature.
  $8462,$03 Fetch the room of the player from #R$EA91.
  $8465,$06 Jump to #R$85F0 if the creature is not in the same room as the
. player.
  $846B,$03 Point #REGhl at the number of creatures at #R$5E25.
  $846E,$01 Increment the number of creatures by one.
N $846F Check whether the creature has been hit by a weapon or touched the
. player.
  $846F,$03 Call #R$8566 to check whether the weapon has hit the entity.
  $8472,$04 Jump to #R$875F if the creature was hit by a weapon.
  $8476,$03 Call #R$85B2 to check whether the entity is touching the player.
  $8479,$04 Jump to #R$85EA if the creature touched the player.
  $847D,$04 Fetch the size of the room from #R$5E1D.
  $8481,$04 Write #N$00 to offset #N$0F of the creature, so it is not removed.
  $8485,$04 Set the attribute of the entity to #COLOUR$46.
N $8489 Choose a new direction every sixteen steps.
  $8489,$03 Fetch the step counter of the creature.
  $848C,$02,b$01 Keep only bits 0-3.
  $848E,$02 Jump to #R$8497 if the result is not zero.
  $8490,$02 Fetch a random number (from the refresh register).
  $8492,$02,b$01 Keep only bits 0-1.
  $8494,$03 Update the direction of the creature.
N $8497 Only change the velocities on every other step.
@ $8497 label=HandlerPumpkin_Velocity
  $8497,$06 Jump to #R$84BF if bit 0 of the step counter is set.
  $849D,$07 Jump to #R$854A if the creature is not heading right.
  $84A4,$03 Fetch the X velocity of the creature.
  $84A7,$04 Jump to #R$84AE if it is already #N$02.
  $84AB,$03 Increment the X velocity by one.
@ $84AE label=HandlerPumpkin_VelocityY
  $84AE,$07 Jump to #R$8558 if the creature is not heading down.
  $84B5,$03 Fetch the Y velocity of the creature.
  $84B8,$04 Jump to #R$84BF if it is already #N$02.
  $84BC,$03 Increment the Y velocity by one.
N $84BF Move on to the next step, and animate the creature by changing its
. sprite.
@ $84BF label=HandlerPumpkin_Animate
  $84BF,$03 Increment the step counter of the creature.
  $84C2,$03 Fetch the step counter of the creature.
  $84C5,$02,b$01 Keep only bit 0.
  $84C7,$03 Exclusive-or the sprite ID with #REGa, which flips bit 0 of it on
. every other step.
  $84CA,$03 Write the new sprite ID back to the creature.

c $84CD Move Creature
@ $84CD label=MoveCreature
D $84CD Moves a creature by its velocities, and turns it around if it would
. leave the room. Then, if the player is in the room, the creature is displayed
. by #R$8E8E. The creatures that are not bosses are removed instead if the
. player is not a character sprite any more (the sprite ID is #N$31 or more).
. The creature is kept within the room by comparing its distance from the
. centre of the room (#N$58 across and #N$68 down) to the size of the room.
R $84CD IX The creature entity
R $84CD DE The size of the room (width in #REGe and height in #REGd)
N $84CD Move the creature horizontally. The X velocity is at offset #N$08.
  $84CD,$03 Fetch the X position of the creature.
  $84D0,$03 Add the X velocity of the creature.
  $84D3,$01 Keep the new X position in #REGc.
  $84D4,$02 Subtract #N$58 (the horizontal centre of the room).
  $84D6,$02 Jump to #R$84E8 if the creature is left of the centre.
  $84D8,$03 Jump to #R$84F8 if the new position is still inside the room.
  $84DB,$04 Reset bit 0 of the direction of the creature, so it is heading left.
  $84DF,$04 Set the X velocity of the creature to -#N$02.
  $84E3,$03 Keep the old X position in #REGc.
  $84E6,$02 Jump to #R$84F8 to move the creature vertically.
@ $84E8 label=MoveCreature_CheckLeft
  $84E8,$02 Negate #REGa.
  $84EA,$03 Jump to #R$84F8 if the new position is still inside the room.
  $84ED,$04 Set bit 0 of the direction of the creature, so it is heading right.
  $84F1,$03 Keep the old X position in #REGc.
  $84F4,$04 Set the X velocity of the creature to #N$02.
N $84F8 Move the creature vertically. The Y velocity is at offset #N$09.
@ $84F8 label=MoveCreature_Vertical
  $84F8,$03 Fetch the Y position of the creature.
  $84FB,$03 Add the Y velocity of the creature.
  $84FE,$01 Keep the new Y position in #REGb.
  $84FF,$02 Subtract #N$68 (the vertical centre of the room).
  $8501,$02 Jump to #R$8513 if the creature is above the centre.
  $8503,$03 Jump to #R$8523 if the new position is still inside the room.
  $8506,$04 Reset bit 1 of the direction of the creature, so it is heading up.
  $850A,$04 Set the Y velocity of the creature to -#N$02.
  $850E,$03 Keep the old Y position in #REGb.
  $8511,$02 Jump to #R$8523 to save the new position of the creature.
@ $8513 label=MoveCreature_CheckTop
  $8513,$02 Negate #REGa.
  $8515,$03 Jump to #R$8523 if the new position is still inside the room.
  $8518,$04 Set bit 1 of the direction of the creature, so it is heading down.
  $851C,$03 Keep the old Y position in #REGb.
  $851F,$04 Set the Y velocity of the creature to #N$02.
N $8523 Save the new position, and then display the creature if the player is in
. the same room.
@ $8523 label=MoveCreature_Store
  $8523,$03 Update the X position of the creature.
  $8526,$03 Update the Y position of the creature.
  $8529,$03 Fetch the room of the player from #R$EA91.
  $852C,$04 Return if the creature is not in the same room as the player.
  $8530,$03 Fetch the sprite ID of the creature.
  $8533,$02,b$01 Keep only bits 2-7.
  $8535,$04 Jump to #R$8547 if the creature is a hunchback (#N$9C to #N$9F).
  $8539,$02,b$01 Keep only bits 4-7.
  $853B,$04 Jump to #R$8547 if the creature is a boss (#N$70 to #N$7F).
  $853F,$03 Fetch the sprite ID of the player from #R$EA90.
  $8542,$05 Jump to #R$875F if the player sprite ID is #N$31 or more.
@ $8547 label=MoveCreature_Display
  $8547,$03 Jump to #R$8E8E to display the creature.
N $854A Speed up the X velocity towards -#N$02, which is used when the creature
. is heading left.
@ $854A label=MoveCreature_SlowLeft
  $854A,$03 Fetch the X velocity of the creature.
  $854D,$05 Jump to #R$84AE if it is already -#N$02.
  $8552,$03 Decrease the X velocity by one.
  $8555,$03 Jump to #R$84AE to work out the vertical velocity of the pumpkin.
N $8558 Speed up the Y velocity towards -#N$02, which is used when the creature
. is heading up.
@ $8558 label=MoveCreature_SlowUp
  $8558,$03 Fetch the Y velocity of the creature.
  $855B,$05 Jump to #R$84BF if it is already -#N$02.
  $8560,$03 Decrease the Y velocity by one.
  $8563,$03 Jump to #R$84BF to animate the pumpkin.

c $8566 Check Weapon Hit
@ $8566 label=CheckWeaponHit
D $8566 Checks whether the weapon of the player is touching an entity. The
. weapon touches an entity if it is in the same room and within #N$0B pixels of
. it on both axes. When it touches, the weapon is flagged by setting its
. byte at offset #N$02 to #N$01.
R $8566 IX The entity to check
R $8566 O:E #N$01 if the weapon touches the entity, otherwise #N$00
  $8566,$03 Fetch the room of the weapon from #N$EA99.
  $8569,$02 Set the result in #REGe to #N$00 (not touching).
  $856B,$03 Compare the room of the weapon with the room of the entity.
  $856E,$01 Return if they are in different rooms.
  $856F,$03 Fetch the sprite ID of the weapon from #R$EA98.
  $8572,$02 Return if there is no weapon.
  $8574,$03 Fetch the X position of the weapon from #N$EA9B.
  $8577,$03 Subtract the X position of the entity.
  $857A,$03 Jump to #R$857F if the difference is positive.
  $857D,$02 Make the difference positive.
@ $857F label=CheckWeaponHit_Test_X
  $857F,$03 Return if the weapon is too far away on the X axis.
  $8582,$03 Fetch the Y position of the weapon from #N$EA9C.
  $8585,$03 Subtract the Y position of the entity.
  $8588,$03 Jump to #R$858D if the difference is positive.
  $858B,$02 Make the difference positive.
@ $858D label=CheckWeaponHit_Test_Y
  $858D,$03 Return if the weapon is too far away on the Y axis.
  $8590,$05 Flag that the weapon has hit an entity.
  $8595,$02 Set the result in #REGe to #N$01 (touching).
  $8597,$01 Return.

c $8598 Get Random Coordinate
@ $8598 label=GetRandomCoordinate
D $8598 Chooses a random position along one axis of the room. A random number
. is reduced to less than the size of the room less #N$08, and then it is
. either added to or taken away from #N$60. This is used by #R$83EA to
. place a new creature.
R $8598 B The size of the room along the axis
R $8598 HL The address of the previous byte of the position in the entity
R $8598 O:A The coordinate
R $8598 O:HL The address of the next byte of the entity
  $8598,$01 Fetch the size of the room along the axis.
  $8599,$02 Take #N$08 off the size of the room.
  $859B,$01 Keep the result in #REGb as the limit for the random number.
  $859C,$02 Fetch a random number (from the refresh register).
  $859E,$01 Move #REGhl on to the next byte.
@ $859F label=GetRandomCoordinate_Reduce
  $859F,$03 Jump to #R$85A5 if the random number is less than the limit.
  $85A2,$01 Subtract the limit from the random number.
  $85A3,$02 Jump back to #R$859F to keep reducing the number.
@ $85A5 label=GetRandomCoordinate_Offset
  $85A5,$01 Keep the random offset in #REGc.
  $85A6,$02 Fetch a random number (from the refresh register).
  $85A8,$02 Test bit 1 of the random number, to choose which side of #N$60 to
. use.
  $85AA,$02 #REGa=#N$60.
  $85AC,$02 Jump to #R$85B0 if bit 1 was not set.
  $85AE,$01 Add the offset to #N$60.
  $85AF,$01 Return.
@ $85B0 label=GetRandomCoordinate_Negative
  $85B0,$01 Take the offset away from #N$60.
  $85B1,$01 Return.

c $85B2 Check Player Touch
@ $85B2 label=CheckPlayerTouch
D $85B2 Checks whether an entity is touching the player. The player is touching
. an entity if the player is a character sprite (a sprite ID of #N$01 to #N$30),
. is in the same room and is within #N$0B pixels of it on both axes. When
. it touches, the byte at offset #N$02 of the player is set to #N$01 and the
. sound of touching is made.
R $85B2 IX The entity to check
R $85B2 O:E #N$01 if the player touches the entity, otherwise #N$00
  $85B2,$03 Fetch the room of the player from #R$EA91.
  $85B5,$02 Set the result in #REGe to #N$00 (not touching).
  $85B7,$03 Compare the room of the player with the room of the entity.
  $85BA,$01 Return if they are in different rooms.
  $85BB,$03 Fetch the sprite ID of the player from #R$EA90.
  $85BE,$01 Test whether the player is in play.
  $85BF,$01 Return if not.
  $85C0,$03 Return if the player is not a character sprite.
  $85C3,$03 Fetch the X position of the player from #N$EA93.
  $85C6,$03 Subtract the X position of the entity.
  $85C9,$03 Jump to #R$85CE if the difference is positive.
  $85CC,$02 Make the difference positive.
@ $85CE label=CheckPlayerTouch_Test_X
  $85CE,$03 Return if the player is too far away on the X axis.
  $85D1,$03 Fetch the Y position of the player from #N$EA94.
  $85D4,$03 Subtract the Y position of the entity.
  $85D7,$03 Jump to #R$85DC if the difference is positive.
  $85DA,$02 Make the difference positive.
@ $85DC label=CheckPlayerTouch_Test_Y
  $85DC,$03 Return if the player is too far away on the Y axis.
  $85DF,$05 Flag that the player has been touched.
  $85E4,$03 Call #R$A3E5 to make the sound of touching.
  $85E7,$02 Set the result in #REGe to #N$01 (touching).
  $85E9,$01 Return.

c $85EA Handle Touching Creature
@ $85EA label=HandleTouchingCreature
D $85EA Called when a creature has touched the player. The player loses
. energy (see #R$8ED7) and the creature turns into a pop (see #R$875F).
R $85EA IX The creature entity
  $85EA,$03 Call #R$8ED7 to take energy from the player.
  $85ED,$03 Jump to #R$875F to turn the creature into a pop.

c $85F0 Count Down Creature
@ $85F0 label=CountDownCreature
D $85F0 Used by the handlers of the creatures when the player is not in the room
. of the creature. The counter at offset #N$0F of the entity is counted down
. and when it reaches zero the creature is removed (see #R$827E).
R $85F0 IX The creature entity
  $85F0,$03 Decrease the counter at offset #N$0F by one.
  $85F3,$01 Return if it is not zero.
  $85F4,$03 Jump to #R$827E to remove the creature.

c $85F7 Handle Sparkle
@ $85F7 label=HandlerSparkle
D $85F7 The handler for the sparkle (sprite IDs #N$58 to #N$5B) that appears
. when a creature is created by #R$83EA. The counter at offset #N$0E of the
. entity starts at #N$20 and the sprite is chosen from its bottom two bits to
. animate the sparkle. When the counter reaches zero the sparkle turns into the
. creature that is held at offset #N$02.
R $85F7 IX The sparkle entity
  $85F7,$03 Call #R$9FFB to save the position of the sparkle.
  $85FA,$03 Fetch the room of the player from #R$EA91.
  $85FD,$06 Jump to #R$85F0 if the sparkle is not in the same room as the
. player.
  $8603,$03 Point #REGhl at the number of creatures at #R$5E25.
  $8606,$01 Increment the number of creatures by one.
  $8607,$03 Decrease the counter at offset #N$0E by one.
  $860A,$02 Jump to #R$8625 if it has reached zero.
  $860C,$03 Fetch the counter.
  $860F,$02,b$01 Keep only bits 0-1.
  $8611,$02 Add #N$58 to get the sprite ID of the sparkle.
  $8613,$03 Update the sprite ID of the sparkle.
  $8616,$04 Write #N$80 to the counter at offset #N$0F.
  $861A,$03 Fetch the sprite ID of the player from #R$EA90.
  $861D,$05 Jump to #R$875F if the player sprite ID is #N$31 or more.
  $8622,$03 Jump to #R$8E8E to display the sparkle.
N $8625 The sparkle is finished, so it turns into the creature.
@ $8625 label=HandlerSparkle_Finish
  $8625,$03 Fetch the type of the creature from offset #N$02.
  $8628,$03 Update the sprite ID of the entity.
  $862B,$03 Jump to #R$8E8E to display the sparkle.


c $862E Handle Ghostlet
@ $862E label=HandlerGhostlet
D $862E The handler for the ghostlet (sprite IDs #N$4E and #N$4F). It is the
. same
. as #R$845F at the start, but the player is checked for touching before the
. weapon. The ghostlet changes to a new random velocity every time the counter
. at offset #N$07 wraps round to zero (every #N$100 steps) and then moves by
. #R$84CD.
R $862E IX The ghostlet entity
  $862E,$03 Call #R$9FFB to save the position of the ghostlet.
  $8631,$03 Fetch the room of the player from #R$EA91.
  $8634,$06 Jump to #R$85F0 if the ghostlet is not in the same room as the
. player.
  $863A,$03 Point #REGhl at the number of creatures at #R$5E25.
  $863D,$01 Increment the number of creatures by one.
  $863E,$03 Call #R$85B2 to check whether the entity is touching the player.
  $8641,$04 Jump to #R$85EA if the ghostlet touched the player.
  $8645,$03 Call #R$8566 to check whether the weapon has hit the entity.
  $8648,$04 Jump to #R$875F if the ghostlet was hit by a weapon.
  $864C,$04 Set the attribute of the entity to #COLOUR$45.
  $8650,$03 Increment the step counter at offset #N$07.
  $8653,$03 Call #R$86F2 if it has wrapped round to zero.
N $8656 Animate the ghostlet by changing the sprite every fourth step.
  $8656,$03 Fetch the step counter.
  $8659,$02 Divide the step counter by four, so that the sprite changes every
. fourth step.
  $865B,$02,b$01 Keep only bit 0.
  $865D,$01 Keep the animation frame in #REGc.
  $865E,$03 Fetch the sprite ID of the ghostlet.
  $8661,$02,b$01 Reset bit 0.
  $8663,$01 Add the animation frame to the sprite ID.
  $8664,$03 Update the sprite ID of the ghostlet.
  $8667,$04 Fetch the size of the room from #R$5E1D.
  $866B,$04 Write #N$00 to offset #N$0F of the ghostlet, so it is not removed.
  $866F,$03 Jump to #R$84CD to move the creature.

c $8672 Handle Spikey And Ghost
@ $8672 label=HandlerSpikey
D $8672 The handler for the spikey (sprite IDs #N$5E and #N$5F) and the ghost
. (#N$68 and #N$69). The counter at offset #N$0A runs from -#N$07 up to #N$06
. and half of it is added to the Y position, which makes the creature bob up
. and down as it moves. A new random velocity is chosen every time that
. the counter wraps round. The movement itself is done by #R$84CD.
R $8672 IX The creature entity
  $8672,$03 Call #R$9FFB to save the position of the creature.
  $8675,$03 Fetch the room of the player from #R$EA91.
  $8678,$06 Jump to #R$85F0 if the creature is not in the same room as the
. player.
  $867E,$03 Point #REGhl at the number of creatures at #R$5E25.
  $8681,$01 Increment the number of creatures by one.
  $8682,$04 Write #N$00 to offset #N$0F of the creature, so it is not removed.
  $8686,$03 Call #R$85B2 to check whether the entity is touching the player.
  $8689,$04 Jump to #R$85EA if the creature touched the player.
  $868D,$03 Call #R$8566 to check whether the weapon has hit the entity.
  $8690,$04 Jump to #R$875F if the creature was hit by a weapon.
N $8694 Animate the creature by changing the sprite every other step.
  $8694,$03 Fetch the bobbing counter from offset #N$0A.
  $8697,$01 Halve the bobbing counter.
  $8698,$02,b$01 Keep only bit 0.
  $869A,$01 Keep the animation frame in #REGc.
  $869B,$03 Fetch the sprite ID of the creature.
  $869E,$02,b$01 Reset bit 0.
  $86A0,$01 Add the animation frame to the sprite ID.
  $86A1,$03 Update the sprite ID of the creature.
  $86A4,$04 Fetch the size of the room from #R$5E1D.
N $86A8 Move on to the next step of the bobbing. A new velocity is chosen when
. the counter reaches #N$07.
  $86A8,$03 Increment the bobbing counter.
  $86AB,$03 Fetch the bobbing counter.
  $86AE,$04 Jump to #R$86B9 unless it has reached #N$07.
  $86B2,$03 Call #R$86F2 to give the creature a new random velocity.
  $86B5,$04 Set the bobbing counter to -#N$07.
N $86B9 Add half of the counter to the Y position of the creature and keep it
. inside the room.
@ $86B9 label=HandlerSpikey_Bob
  $86B9,$02 Halve the counter, keeping its sign.
  $86BB,$03 Add the Y position of the creature.
  $86BE,$01 Keep the new Y position in #REGc.
  $86BF,$02 Subtract #N$68 (the vertical centre of the room).
  $86C1,$03 Jump to #R$86E1 if the new position is below the centre.
  $86C4,$02 Make the distance from the centre positive.
  $86C6,$03 Jump to #R$86DB if the new position is still inside the room.
  $86C9,$04 Set the Y velocity of the creature to #N$02.
  $86CD,$04 Set bit 1 of the direction of the creature, so it is heading down.
  $86D1,$06 Jump to #R$86DB if the bobbing counter is positive.
  $86D7,$04 Reset the bobbing counter to #N$00.
@ $86DB label=HandlerSpikey_Store
  $86DB,$03 Update the Y position of the creature.
  $86DE,$03 Jump to #R$84CD to move the creature.
@ $86E1 label=HandlerSpikey_CheckBottom
  $86E1,$03 Jump to #R$86DB if the new position is still inside the room.
  $86E4,$04 Reset bit 1 of the direction of the creature, so it is heading up.
  $86E8,$04 Set the Y velocity of the creature to -#N$02.
  $86EC,$04 Set the bobbing counter to -#N$07.
  $86F0,$02 Jump to #R$86DB to store the Y position of the creature.

c $86F2 Randomise Velocity
@ $86F2 label=RandomiseVelocity
D $86F2 Gives a creature a new random velocity on each axis. The Y velocity is
. chosen first. Each velocity is either -#N$02 or #N$02, or else -#N$01 or
. #N$01. The random number comes from the refresh register.
R $86F2 IX The creature entity
  $86F2,$02 Fetch a random number (from the refresh register).
  $86F4,$04 Jump to #R$870E if bit 0 was not set.
  $86F8,$02,b$01 Keep only bit 2.
  $86FA,$02 Subtract #N$02, giving -#N$02 or #N$02.
@ $86FC label=RandomiseVelocity_SetY
  $86FC,$03 Update the Y velocity of the creature.
  $86FF,$02 Fetch a random number (from the refresh register).
  $8701,$01 Rotate the random number right, so that bit 1 becomes bit 0.
  $8702,$04 Jump to #R$8714 if bit 0 was not set.
  $8706,$02,b$01 Keep only bit 2.
  $8708,$02 Subtract #N$02, giving -#N$02 or #N$02.
@ $870A label=RandomiseVelocity_SetX
  $870A,$03 Update the X velocity of the creature.
  $870D,$01 Return.
@ $870E label=RandomiseVelocity_SlowY
  $870E,$02,b$01 Keep only bit 1.
  $8710,$02 Subtract #N$01, giving -#N$01 or #N$01.
  $8712,$02 Jump to #R$86FC to set the Y velocity of the creature.
@ $8714 label=RandomiseVelocity_SlowX
  $8714,$02,b$01 Keep only bit 1.
  $8716,$02 Subtract #N$01, giving -#N$01 or #N$01.
  $8718,$02 Jump to #R$870A to set the X velocity of the creature.

c $871A Handle Blob
@ $871A label=HandlerBlob
D $871A The handler for the blob (sprite IDs #N$60 and #N$61). A new random
. velocity is chosen every #N$11 steps, by counting down the counter at offset
. #N$0D. The movement itself is done by #R$84CD.
R $871A IX The blob entity
  $871A,$03 Call #R$9FFB to save the position of the blob.
  $871D,$03 Fetch the room of the player from #R$EA91.
  $8720,$06 Jump to #R$85F0 if the blob is not in the same room as the player.
  $8726,$03 Point #REGhl at the number of creatures at #R$5E25.
  $8729,$01 Increment the number of creatures by one.
  $872A,$04 Write #N$00 to offset #N$0F of the blob, so it is not removed.
  $872E,$03 Call #R$85B2 to check whether the entity is touching the player.
  $8731,$04 Jump to #R$85EA if the blob touched the player.
  $8735,$03 Call #R$8566 to check whether the weapon has hit the entity.
  $8738,$04 Jump to #R$875F if the blob was hit by a weapon.
  $873C,$04 Fetch the size of the room from #R$5E1D.
  $8740,$03 Decrease the counter at offset #N$0D by one.
  $8743,$02 Jump to #R$874C if it is not zero.
  $8745,$04 Set the counter to #N$11.
  $8749,$03 Call #R$86F2 to give the creature a new random velocity.
N $874C Animate the blob by changing the sprite every other step.
@ $874C label=HandlerBlob_Animate
  $874C,$03 Fetch the counter.
  $874F,$01 Halve the counter.
  $8750,$02,b$01 Keep only bit 0.
  $8752,$01 Keep the animation frame in #REGc.
  $8753,$03 Fetch the sprite ID of the blob.
  $8756,$02,b$01 Reset bit 0.
  $8758,$01 Add the animation frame to the sprite ID.
  $8759,$03 Update the sprite ID of the blob.
  $875C,$03 Jump to #R$84CD to move the creature.

c $875F Pop Creature
@ $875F label=PopCreature
D $875F Turns a creature into a pop, which is what happens when it is hit by a
. weapon or when it touches the player. The creature is removed from the
. screen and redrawn as the first frame of the pop with the room attribute
. under it (see #R$8787), and the player is given #N($0155,$04,$04) points.
R $875F IX The creature entity
  $875F,$03 Fetch the attribute of the creature.
  $8762,$01 Stash it on the stack.
  $8763,$03 Fetch the room attribute from #R$5E1A.
  $8766,$03 Update the attribute of the creature.
  $8769,$03 Call #R$9F56 to remove the creature from the screen.
  $876C,$03 Call #R$A01A to set the attributes of the cells that the creature
. covered.
  $876F,$01 Restore the attribute of the creature from the stack.
  $8770,$03 Write it to the attribute of the creature.
  $8773,$04 Write #N$6C to the sprite ID of the creature (the first frame of the
. pop).
  $8777,$04 Set the counter at offset #N$0E to #N$10.
  $877B,$03 #REGbc=#N($0155,$04,$04) (the points to add to the score).
  $877E,$03 Call #R$A19C to add the points to the score.
  $8781,$03 Call #R$9F4A to draw the pop.
  $8784,$03 Jump to #R$A01A to set the attributes.

c $8787 Handle Pop
@ $8787 label=HandlerPop
D $8787 The handler for the pop (sprite IDs #N$6C to #N$6F) that is left when
. a creature is hit. The counter at offset #N$0E, which was started at #N$10
. by #R$875F, is counted down and the bottom two bits choose the frame of the
. animation. The pop is removed when the counter reaches zero.
R $8787 IX The pop entity
  $8787,$03 Call #R$9FFB to save the position of the pop.
  $878A,$03 Fetch the room of the player from #R$EA91.
  $878D,$06 Jump to #R$85F0 if the pop is not in the same room as the player.
  $8793,$03 Decrease the counter at offset #N$0E by one.
  $8796,$03 Jump to #R$826F if it has reached zero, to remove the pop.
  $8799,$03 Fetch the counter.
  $879C,$02,b$01 Keep only bits 0-1.
  $879E,$02 Add #N$6C to get the sprite ID of the pop.
  $87A0,$03 Update the sprite ID of the pop.
  $87A3,$03 Jump to #R$8E8E to display the pop.

c $87A6 Handle Ghoul
@ $87A6 label=HandlerGhoul
D $87A6 The handler for the ghoul (sprite IDs #N$62 and #N$63). It is like
. #R$845F, but the weapon is checked before the player, and the direction
. at offset #N$06 is changed every eight steps. The velocities build up by
. one every other step towards #N$02 or -#N$02. The movement itself is
. done by #R$84CD.
R $87A6 IX The ghoul entity
  $87A6,$03 Call #R$9FFB to save the position of the ghoul.
  $87A9,$03 Fetch the room of the player from #R$EA91.
  $87AC,$06 Jump to #R$85F0 if the ghoul is not in the same room as the player.
  $87B2,$03 Point #REGhl at the number of creatures at #R$5E25.
  $87B5,$01 Increment the number of creatures by one.
  $87B6,$03 Call #R$8566 to check whether the weapon has hit the entity.
  $87B9,$04 Jump to #R$875F if the ghoul was hit by a weapon.
  $87BD,$03 Call #R$85B2 to check whether the entity is touching the player.
  $87C0,$04 Jump to #R$85EA if the ghoul touched the player.
  $87C4,$04 Fetch the size of the room from #R$5E1D.
  $87C8,$04 Write #N$00 to offset #N$0F of the ghoul, so it is not removed.
  $87CC,$04 Set the attribute of the entity to #COLOUR$46.
  $87D0,$03 Fetch the step counter from offset #N$07.
  $87D3,$02,b$01 Keep only bits 0-2.
  $87D5,$02 Jump to #R$87DE if the result is not zero.
  $87D7,$02 Fetch a random number (from the refresh register).
  $87D9,$02,b$01 Keep only bits 0-1.
  $87DB,$03 Update the direction of the ghoul.
@ $87DE label=HandlerGhoul_Velocity
  $87DE,$06 Jump to #R$8804 if bit 0 of the step counter is set.
  $87E4,$06 Jump to #R$8815 if the ghoul is not heading right.
  $87EA,$03 Fetch the X velocity of the ghoul.
  $87ED,$04 Jump to #R$87F4 if it is already #N$02.
  $87F1,$03 Increment the X velocity by one.
@ $87F4 label=HandlerGhoul_VelocityY
  $87F4,$06 Jump to #R$8821 if the ghoul is not heading down.
  $87FA,$03 Fetch the Y velocity of the ghoul.
  $87FD,$04 Jump to #R$8804 if it is already #N$02.
  $8801,$03 Increment the Y velocity by one.
N $8804 Move on to the next step, and animate the ghoul by changing its sprite.
@ $8804 label=HandlerGhoul_Animate
  $8804,$03 Increment the step counter.
  $8807,$03 Fetch the step counter.
  $880A,$02,b$01 Keep only bit 0.
  $880C,$03 Exclusive-or the sprite ID with #REGa, which flips bit 0 of it on
. every other step.
  $880F,$03 Write the new sprite ID back to the ghoul.
  $8812,$03 Jump to #R$84CD to move the creature.
N $8815 Speed up the X velocity towards -#N$02, which is used when the ghoul is
. heading left.
@ $8815 label=HandlerGhoul_SlowLeft
  $8815,$03 Fetch the X velocity of the ghoul.
  $8818,$04 Jump to #R$87F4 if it is already -#N$02.
  $881C,$03 Decrease the X velocity by one.
  $881F,$02 Jump to #R$87F4 to work out the vertical velocity of the ghoul.
N $8821 Speed up the Y velocity towards -#N$02, which is used when the ghoul is
. heading up.
@ $8821 label=HandlerGhoul_SlowUp
  $8821,$03 Fetch the Y velocity of the ghoul.
  $8824,$04 Jump to #R$8804 if it is already -#N$02.
  $8828,$03 Decrease the Y velocity by one.
  $882B,$02 Jump to #R$8804 to animate the ghoul.


c $882D Steer Creature
@ $882D label=SteerCreature
D $882D Sets the velocities of a creature so that it heads towards a target
. position, which is one pixel per step on each axis (or nothing on an axis
. where it has already arrived). Bit 0 of #REGc is set if the creature is at the
. Y position of the target and bit 1 is set if it is at the X position, so
. #REGc is #N$03 when it has arrived.
R $882D IX The creature entity
R $882D DE The target position (X in #REGe and Y in #REGd)
R $882D O:C Bit 0 set if the Y positions match, bit 1 set if the X ones do
  $882D,$02 Clear the result in #REGc, which flags which axes have been reached.
  $882F,$01 Fetch the target Y position.
  $8830,$03 Compare the target Y position with the Y position of the creature.
  $8833,$04 Jump to #R$8848 if they are the same.
  $8837,$04 Set the Y velocity of the creature to -#N$01 (the target is above).
@ $883B label=SteerCreature_X
  $883B,$01 Fetch the target X position.
  $883C,$03 Compare the target X position with the X position of the creature.
  $883F,$04 Jump to #R$8856 if they are the same.
  $8843,$04 Set the X velocity of the creature to -#N$01 (the target is to the
. left).
  $8847,$01 Return.
@ $8848 label=SteerCreature_SameY
  $8848,$04 Set the Y velocity of the creature to #N$00.
  $884C,$02 Flag that the creature is at the target Y position.
  $884E,$02 Jump to #R$883B to work out the X velocity.
@ $8850 label=SteerCreature_Below
  $8850,$04 Set the Y velocity of the creature to #N$01.
  $8854,$02 Jump to #R$883B to work out the X velocity.
@ $8856 label=SteerCreature_SameX
  $8856,$04 Set the X velocity of the creature to #N$00.
  $885A,$02 Flag that the creature is at the target X position.
  $885C,$01 Return.
@ $885D label=SteerCreature_Right
  $885D,$04 Set the X velocity of the creature to #N$01.
  $8861,$01 Return.

c $8862 Handle Mummy
@ $8862 label=HandlerMummy
D $8862 The handler for the mummy (sprite IDs #N$70 to #N$73). If the mummy
. touches the player then #R$8A1E takes some energy. Then the mummy picks a
. target to steer towards with #R$882D. If the leaf (#R$EAE0, the copy of
. #R$605D) is in the room then it is the target, and when the mummy reaches it
. the leaf is moved to room #N$6B. Otherwise, when bit 7 of offset #N$06 is
. reset and the red key (#R$EAC8, the copy of #R$6045) is in the room, the
. mummy goes backwards and forwards between two waypoints that are kept at
. offsets #N$0B and #N$0C, and when bit 7 is set (or the red key is not in the
. room) the target is the player.
. The sprite comes from the bottom two bits of the counter at #R$5E12, and then
. #R$89BB does the rest.
R $8862 IX The mummy entity
  $8862,$03 Call #R$9FFB to save the position of the mummy.
  $8865,$03 Call #R$85B2 to check whether the entity is touching the player.
  $8868,$04 Call #R$8A1E if the mummy touched the player.
N $886C See if the leaf (#R$EAE0) is in the room, and if so make it the target.
  $886C,$03 Point #REGhl at the leaf at #R$EAE0.
  $886F,$01 Fetch the sprite ID of the entity.
  $8870,$03 Jump to #R$8881 if the leaf is not in use.
  $8873,$01 Move #REGhl on to the room of the entity.
  $8874,$01 Fetch the room of the entity.
  $8875,$05 Jump to #R$8881 if the leaf is in a different room to the mummy.
  $887A,$02 Move #REGhl on to the X position of the entity.
  $887C,$01 Fetch the X position of the entity.
  $887D,$01 Move #REGhl on to the Y position of the entity.
  $887E,$01 Fetch the Y position of the entity.
  $887F,$02 Jump to #R$88D7 to steer the mummy towards its target.
N $8881 If bit 7 of the flags is set then the target is the player.
@ $8881 label=HandlerMummy_CheckFlags
  $8881,$06 Jump to #R$88FD if bit 7 of offset #N$06 is set.
N $8887 See if the red key (#R$EAC8) is in the room.
  $8887,$03 Point #REGhl at the red key at #R$EAC8.
  $888A,$01 Fetch the sprite ID of the entity.
  $888B,$03 Jump to #R$88F9 if the red key is not in use.
  $888E,$01 Move #REGhl on to the room of the entity.
  $888F,$01 Fetch the room of the entity.
  $8890,$05 Jump to #R$88F9 if the red key is in a different room to the mummy.
N $8895 Steer towards the current waypoint.
  $8895,$03 Fetch the Y position of the waypoint.
  $8898,$03 Fetch the X position of the waypoint.
  $889B,$03 Call #R$882D to steer the creature towards its target.
  $889E,$01 Fetch which of the axes have been reached.
  $889F,$04 Jump to #R$88B5 if the mummy is at the waypoint.
N $88A3 Choose the sprite and the area that the mummy can move in.
@ $88A3 label=HandlerMummy_SetSprite
  $88A3,$03 Fetch the counter from #R$5E12.
  $88A6,$02 Divide the counter by four.
  $88A8,$02,b$01 Keep only bits 0-1.
  $88AA,$02 Add #N$70 to get the sprite ID of the mummy.
  $88AC,$03 Update the sprite ID of the mummy.
  $88AF,$03 #REGde=#N($3838,$04,$04) (the area).
  $88B2,$03 Jump to #R$89BB to move the boss.
N $88B5 The mummy is at a waypoint, so change to the other one.
@ $88B5 label=HandlerMummy_NextWaypoint
  $88B5,$06 Jump to #R$88C9 if bit 6 of offset #N$06 is reset.
  $88BB,$04 Set the X position of the waypoint to #N$8C.
  $88BF,$04 Set the Y position of the waypoint to #N$68.
  $88C3,$04 Reset bit 6 of offset #N$06.
  $88C7,$02 Jump to #R$88A3 to choose the sprite of the mummy.
@ $88C9 label=HandlerMummy_FirstWaypoint
  $88C9,$04 Set the X position of the waypoint to #N$68.
  $88CD,$04 Set the Y position of the waypoint to #N$38.
  $88D1,$04 Set bit 6 of offset #N$06.
  $88D5,$02 Jump to #R$88A3 to choose the sprite of the mummy.
N $88D7 Steer towards the leaf, and when the mummy gets there move it out of the
. way.
@ $88D7 label=HandlerMummy_Target
  $88D7,$03 Call #R$882D to steer the creature towards its target.
  $88DA,$01 Fetch which of the axes have been reached.
  $88DB,$04 Jump to #R$88A3 if the mummy has not arrived.
  $88DF,$02 Stash the mummy on the stack.
  $88E1,$04 Point #REGix at the leaf at #R$EAE0.
  $88E5,$03 Fetch the room of the player from #R$EA91.
  $88E8,$05 Jump to #R$88F0 if the leaf is in a different room to the player.
  $88ED,$03 Call #R$9F4A to draw the entity.
@ $88F0 label=HandlerMummy_Moved
  $88F0,$02 Restore the mummy from the stack.
  $88F2,$05 Write #N$6B to the room of the leaf, to move it out of the way.
  $88F7,$02 Jump to #R$88B5 to change the mummy to its other waypoint.
N $88F9 There is nothing else to go for, so the target is the player.
@ $88F9 label=HandlerMummy_SeekPlayer
  $88F9,$04 Set bit 7 of offset #N$06.
@ $88FD label=HandlerMummy_Player
  $88FD,$04 Fetch the position of the player from #N$EA93.
  $8901,$03 Call #R$882D to steer the creature towards its target.
  $8904,$02 Jump to #R$88A3 to choose the sprite of the mummy.

c $8906 Handle Dracula
@ $8906 label=HandlerDracula
D $8906 The handler for Dracula (sprite IDs #N$7C to #N$7F). If Dracula
. touches the player then #R$8A1E takes some energy. When the player is
. holding the crucifix (sprite ID #N$8A with attribute #N$46) Dracula heads
. away from the player, otherwise he heads towards the player when they are
. in the same room. If they are not, then about once every #N$100 frames he
. goes to a random room, if the shape of that room (see #R$897D) is less than
. #N$03.
R $8906 IX The Dracula entity
  $8906,$03 Call #R$9FFB to save the position of Dracula.
  $8909,$03 Call #R$85B2 to check whether the entity is touching the player.
  $890C,$04 Call #R$8A1E if Dracula touched the player.
N $8910 See if the player is holding the crucifix.
  $8910,$03 #REGde=#N($468A,$04,$04) (the attribute and the sprite ID of the
. crucifix).
  $8913,$03 Call #R$9273 to look for the crucifix in the inventory.
  $8916,$02 Jump to #R$8931 if the player is not holding it.
N $8918 The player has the crucifix, so steer towards the player and then
. reverse the velocities to run away.
  $8918,$04 Fetch the position of the player from #N$EA93.
  $891C,$03 Call #R$882D to steer the creature towards its target.
  $891F,$03 Fetch the X velocity.
  $8922,$02 Reverse the direction of the X velocity.
  $8924,$03 Update the X velocity.
  $8927,$03 Fetch the Y velocity.
  $892A,$02 Reverse the direction of the Y velocity.
  $892C,$03 Update the Y velocity.
  $892F,$02 Jump to #R$8940 to choose the sprite of Dracula.
N $8931 Check whether Dracula is in the same room as the player.
@ $8931 label=HandlerDracula_CheckRoom
  $8931,$03 Fetch the room of the player from #R$EA91.
  $8934,$05 Jump to #R$8952 if Dracula is in a different room.
  $8939,$04 Fetch the position of the player from #N$EA93.
  $893D,$03 Call #R$882D to steer the creature towards its target.
N $8940 Choose the sprite and the area that Dracula can move in.
@ $8940 label=HandlerDracula_SetSprite
  $8940,$03 Fetch the counter from #R$5E12.
  $8943,$02 Divide the counter by four.
  $8945,$02,b$01 Keep only bits 0-1.
  $8947,$02 Add #N$7C to get the sprite ID of Dracula.
  $8949,$03 Update the sprite ID of Dracula.
  $894C,$03 #REGde=#N($3434,$04,$04) (the area).
  $894F,$03 Jump to #R$89BB to move the boss.
N $8952 Dracula is in a different room, so every so often send him to a random
. one.
@ $8952 label=HandlerDracula_OtherRoom
  $8952,$04 Set the X position of the waypoint to #N$68.
  $8956,$04 Set the Y position of the waypoint to #N$68.
  $895A,$03 Call #R$882D to steer the creature towards its target.
  $895D,$03 Fetch the low byte of FRAMES.
  $8960,$04 Jump to #R$8940 unless the low byte of FRAMES is zero, which happens
. once in every #N$100 frames.
  $8964,$02 Fetch a random number (from the refresh register).
  $8966,$02,b$01 Keep only bits 0-6.
  $8968,$01 Keep the random room in #REGc.
  $8969,$03 Call #R$897D to look up the value for the room.
  $896C,$05 Jump to #R$8940 if the value for the room is #N$03 or more.
  $8971,$03 Fetch the room of the player from #R$EA91.
  $8974,$04 Jump to #R$8940 if the random room is the room of the player.
  $8978,$03 Update the room of Dracula.
  $897B,$02 Jump to #R$8940 to choose the sprite of Dracula.

c $897D Get Room Value
@ $897D label=GetRoomValue
D $897D Reads the second byte of the entry for a room in #R$A854, which is the
. shape of the frame of the room (see #R$A982).
R $897D A The room
R $897D O:A The shape of the room
  $897D,$01 Set #REGl to the room.
  $897E,$02 Clear the high byte of the room in #REGh.
  $8980,$03 Point #REGde at the room attribute table at #R$A854.
  $8983,$01 Double #REGhl, as the entries are two bytes long.
  $8984,$01 Find the entry for the room.
  $8985,$01 Move #REGhl on to the second byte of the entry.
  $8986,$01 Fetch the second byte of the entry.
  $8987,$01 Return.

c $8988 Handle Frankenstein
@ $8988 label=HandlerFrankenstein
D $8988 The handler for Frankenstein (sprite IDs #N$74 to #N$77). He steers
. towards the player. If he touches the player while the player is holding
. the spanner (sprite ID #N$8B with attribute #N$45) then he is hit instead
. and the player is given #N($1000,$04,$04) points, otherwise #R$8A1E takes some
. energy. The sprite comes from the bottom two bits of the counter at
. #R$5E12. The tail at #R$89BB is also used by the other bosses.
R $8988 IX The Frankenstein entity
  $8988,$03 Call #R$9FFB to save the position of Frankenstein.
  $898B,$03 Call #R$85B2 to check whether the entity is touching the player.
  $898E,$03 Jump to #R$89A5 if Frankenstein did not touch the player.
  $8991,$03 #REGde=#N($458B,$04,$04) (the attribute and the sprite ID of the
. spanner).
  $8994,$03 Call #R$9273 to look for the spanner in the inventory.
  $8997,$02 Jump to #R$89A2 if the player is not holding it.
  $8999,$03 #REGbc=#N($1000,$04,$04) (the points to add to the score).
  $899C,$03 Call #R$A19C to add the points to the score.
  $899F,$03 Jump to #R$875F to turn the creature into a pop.
@ $89A2 label=HandlerFrankenstein_Hurt
  $89A2,$03 Call #R$8A1E to take energy from the player.
@ $89A5 label=HandlerFrankenstein_Steer
  $89A5,$04 Fetch the position of the player from #N$EA93.
  $89A9,$03 Call #R$882D to steer the creature towards its target.
  $89AC,$03 Fetch the counter from #R$5E12.
  $89AF,$02 Divide the counter by four.
  $89B1,$02,b$01 Keep only bits 0-1.
  $89B3,$02 Add #N$74 to get the sprite ID of Frankenstein.
  $89B5,$03 Update the sprite ID of Frankenstein.
  $89B8,$03 #REGde=#N($3434,$04,$04) (the area).
N $89BB The shared end of the handlers of the bosses. If the player is a
. character then the boss moves. If not, the boss moves away from the player.
@ $89BB label=HandlerBoss_Move
  $89BB,$03 Fetch the sprite ID of the player from #R$EA90.
  $89BE,$05 Jump to #R$84CD if the player is a character.
  $89C3,$04 Fetch the position of the player from #N$EA93.
  $89C7,$03 Call #R$882D to steer the creature towards its target.
  $89CA,$03 Fetch the X velocity.
  $89CD,$02 Reverse the direction of the X velocity.
  $89CF,$03 Update the X velocity.
  $89D2,$01 Keep the reversed X velocity in #REGc.
  $89D3,$03 Fetch the Y velocity.
  $89D6,$02 Reverse the direction of the Y velocity.
  $89D8,$03 Update the Y velocity.
  $89DB,$03 #REGde=#N($3434,$04,$04) (the area).
  $89DE,$04 Jump to #R$84CD if the AND of the two velocities is not zero.
  $89E2,$04 Set the X velocity to #N$01.
  $89E6,$04 Set the Y velocity to #N$01.
  $89EA,$03 Jump to #R$84CD to move the creature.

c $89ED Handle Devil
@ $89ED label=HandlerDevil
D $89ED The handler for the devil (sprite IDs #N$78 to #N$7B). If the devil
. touches the player then #R$8A1E takes some energy. The devil always steers
. towards the player. The sprite comes from the bottom two bits of the
. counter at #R$5E12, and then #R$89BB does the rest.
R $89ED IX The devil entity
  $89ED,$03 Call #R$9FFB to save the position of the devil.
  $89F0,$03 Call #R$85B2 to check whether the entity is touching the player.
  $89F3,$04 Call #R$8A1E if the devil touched the player.
  $89F7,$04 Fetch the position of the player from #N$EA93.
  $89FB,$03 Call #R$882D to steer the creature towards its target.
  $89FE,$03 Fetch the sprite ID of the devil.
  $8A01,$02,b$01 Keep only bits 2-7.
  $8A03,$01 Keep the base sprite ID in #REGc.
  $8A04,$03 Fetch the counter from #R$5E12.
  $8A07,$02 Divide the counter by four.
  $8A09,$02,b$01 Keep only bits 0-1.
  $8A0B,$01 Add the animation frame to the base sprite ID.
  $8A0C,$03 Update the sprite ID of the devil.
  $8A0F,$03 #REGde=#N($3434,$04,$04) (the area).
  $8A12,$03 Jump to #R$89BB to move the boss.


c $8A15 Take Energy From Player
@ $8A15 label=TakeEnergyFromPlayer
D $8A15 Called when a boss has touched the player. It takes #N$10 (at #R$8A15)
. or #N$08 (at #R$8A1E) from #R$5E28. The chicken is then redrawn by #R$8B8A,
. which returns to the caller. If the player did not have enough energy then
. the return address is discarded and #R$8EA0 is used to take a life.
R $8A15 IX The boss entity
  $8A15,$03 Fetch the energy of the player from #R$5E28.
  $8A18,$02 Take #N$10 off the energy of the player.
  $8A1A,$02 Jump to #R$8A2B if the player has run out of energy.
  $8A1C,$02 Jump to #R$8A25 to update the energy of the player.
@ $8A1E label=TakeEnergyFromPlayer_Small
  $8A1E,$03 Fetch the energy of the player from #R$5E28.
  $8A21,$02 Take #N$08 off the energy of the player.
  $8A23,$02 Jump to #R$8A2B if the player has run out of energy.
@ $8A25 label=TakeEnergyFromPlayer_Update
  $8A25,$03 Update the energy of the player in #R$5E28.
  $8A28,$03 Jump to #R$8B8A to update the roast chicken.
@ $8A2B label=TakeEnergyFromPlayer_Dead
  $8A2B,$01 Discard the return address.
  $8A2C,$03 Jump to #R$8EA0 to take a life from the player.

c $8A2F Handle Witch
@ $8A2F label=HandlerWitch
D $8A2F The handler for the witch (sprite IDs #N$90 to #N$93). The counter at
. offset #N$0D is counted down from #N$10 and when it reaches zero the witch
. gets a new random velocity (see #R$86F2) with the Y velocity halved. The
. sprite faces right when the X velocity is not negative, and the bottom bit of
. the counter animates it. The movement itself is done by #R$84CD.
R $8A2F IX The witch entity
  $8A2F,$03 Call #R$9FFB to save the position of the witch.
  $8A32,$03 Fetch the room of the player from #R$EA91.
  $8A35,$06 Jump to #R$85F0 if the witch is not in the same room as the player.
  $8A3B,$03 Point #REGhl at the number of creatures at #R$5E25.
  $8A3E,$01 Increment the number of creatures by one.
  $8A3F,$03 Call #R$85B2 to check whether the entity is touching the player.
  $8A42,$04 Jump to #R$85EA if the witch touched the player.
  $8A46,$03 Call #R$8566 to check whether the weapon has hit the entity.
  $8A49,$04 Jump to #R$875F if the witch was hit by a weapon.
  $8A4D,$03 Decrease the counter at offset #N$0D by one.
  $8A50,$02 Jump to #R$8A5D if it is not zero.
  $8A52,$03 Call #R$86F2 to give the creature a new random velocity.
  $8A55,$04 Halve the Y velocity, keeping its sign.
  $8A59,$04 Set the counter to #N$10.
N $8A5D Choose the sprite, which depends on the direction of travel and the
. counter.
@ $8A5D label=HandlerWitch_SetSprite
  $8A5D,$03 Fetch the sprite ID of the witch.
  $8A60,$02,b$01 Keep only bits 2-7.
  $8A62,$06 Jump to #R$8A6A if the X velocity is negative.
  $8A68,$02 Add #N$02 to use the sprites facing right.
@ $8A6A label=HandlerWitch_Animate
  $8A6A,$01 Keep the base sprite ID in #REGc.
  $8A6B,$03 Fetch the counter.
  $8A6E,$01 Halve the counter.
  $8A6F,$02,b$01 Keep only bit 0.
  $8A71,$01 Add the animation frame to the base sprite ID.
  $8A72,$03 Update the sprite ID of the witch.
  $8A75,$04 Fetch the size of the room from #R$5E1D.
  $8A79,$04 Set the attribute of the entity to #COLOUR$43.
  $8A7D,$03 Jump to #R$84CD to move the creature.

c $8A80 Handle Monk And Bat
@ $8A80 label=HandlerMonk
D $8A80 The handler for the monk (sprite IDs #N$94 to #N$97) and the second kind
. of bat (#N$98 to #N$9B). It is the same as #R$8A2F, but the counter is
. restarted at #N$20 and when it runs out the X velocity is also set to
. -#N$02 or #N$02, depending on the bottom bit of FRAMES. The attribute is
. #COLOUR$42.
R $8A80 IX The monk or bat entity
  $8A80,$03 Call #R$9FFB to save the position of the creature.
  $8A83,$03 Fetch the room of the player from #R$EA91.
  $8A86,$06 Jump to #R$85F0 if the creature is not in the same room as the
. player.
  $8A8C,$03 Point #REGhl at the number of creatures at #R$5E25.
  $8A8F,$01 Increment the number of creatures by one.
  $8A90,$03 Call #R$85B2 to check whether the entity is touching the player.
  $8A93,$04 Jump to #R$85EA if the creature touched the player.
  $8A97,$03 Call #R$8566 to check whether the weapon has hit the entity.
  $8A9A,$04 Jump to #R$875F if the creature was hit by a weapon.
  $8A9E,$03 Decrease the counter at offset #N$0D by one.
  $8AA1,$02 Jump to #R$8AB8 if it is not zero.
  $8AA3,$03 Call #R$86F2 to give the creature a new random velocity.
  $8AA6,$03 Fetch the low byte of FRAMES.
  $8AA9,$02,b$01 Keep only bit 2.
  $8AAB,$02 Subtract #N$02, giving -#N$02 or #N$02.
  $8AAD,$03 Update the X velocity of the creature.
  $8AB0,$04 Halve the Y velocity, keeping its sign.
  $8AB4,$04 Set the counter to #N$20.
@ $8AB8 label=HandlerMonk_SetSprite
  $8AB8,$03 Fetch the sprite ID of the creature.
  $8ABB,$02,b$01 Keep only bits 2-7.
  $8ABD,$06 Jump to #R$8AC5 if the X velocity is negative.
  $8AC3,$02 Add #N$02 to use the sprites facing right.
@ $8AC5 label=HandlerMonk_Animate
  $8AC5,$01 Keep the base sprite ID in #REGc.
  $8AC6,$03 Fetch the counter.
  $8AC9,$01 Halve the counter.
  $8ACA,$02,b$01 Keep only bit 0.
  $8ACC,$01 Add the animation frame to the base sprite ID.
  $8ACD,$03 Update the sprite ID of the creature.
  $8AD0,$04 Fetch the size of the room from #R$5E1D.
  $8AD4,$04 Set the attribute of the entity to #COLOUR$42.
  $8AD8,$03 Jump to #R$84CD to move the creature.

c $8ADB Find Item In Room
@ $8ADB label=FindItemInRoom
D $8ADB Searches the eight records that start at #R$EB18 for one that is in
. use and is in the same room as an entity. The records have eight bytes each,
. laid out in the same way as an entity.
R $8ADB IX The entity
R $8ADB O:C #N$01 if a record was found, otherwise #N$00
R $8ADB O:DE The position of the record that was found (X in #REGe and Y in
. #REGd)
R $8ADB O:HL The address of the Y position of the record that was found
  $8ADB,$03 Point #REGhl at the first of the item records at #R$EB18.
  $8ADE,$03 #REGde=#N($0008,$04,$04) (the size of each record).
  $8AE1,$02 #REGb=#N$08 (the number of records to look at).
@ $8AE3 label=FindItemInRoom_Loop
  $8AE3,$01 Stash the address of the record on the stack.
  $8AE4,$01 Fetch the sprite ID of the record.
  $8AE5,$01 Test whether the record is in use.
  $8AE6,$02 Jump to #R$8AF8 if it is not.
  $8AE8,$01 Move #REGhl on to the room of the record.
  $8AE9,$01 Fetch the room of the record.
  $8AEA,$03 Compare it with the room of the entity.
  $8AED,$02 Jump to #R$8AF8 if they are different.
  $8AEF,$01 Restore the address of the record into #REGde.
  $8AF0,$02 Move #REGhl on to the X position of the record.
  $8AF2,$01 Fetch the X position of the record.
  $8AF3,$01 Move #REGhl on to the Y position of the record.
  $8AF4,$01 Fetch the Y position of the record.
  $8AF5,$02 Set the result in #REGc to #N$01 (found).
  $8AF7,$01 Return.
@ $8AF8 label=FindItemInRoom_Next
  $8AF8,$01 Restore the address of the record from the stack.
  $8AF9,$01 Move #REGhl on to the next record.
  $8AFA,$02 Decrease the record counter by one and loop back to #R$8AE3 until
. all eight records have been checked.
  $8AFC,$02 Set the result in #REGc to #N$00 (not found).
  $8AFE,$01 Return.

c $8AFF Handle Hunchback
@ $8AFF label=HandlerHunchback
D $8AFF The handler for the hunchback (sprite IDs #N$9C to #N$9F). If he
. touches the player then #R$8A15 takes some energy. The velocities are
. set by #R$882D, as the hunchback goes for the first item that is in his
. room (see #R$8ADB). When he reaches it the item is removed. If there is
. nothing to go for he stays still, and if the player is not a character
. then he heads for a position in the room. The movement itself is done by
. #R$84CD.
R $8AFF IX The hunchback entity
  $8AFF,$03 Call #R$9FFB to save the position of the hunchback.
  $8B02,$03 Call #R$85B2 to check whether the entity is touching the player.
  $8B05,$04 Call #R$8A15 if the hunchback touched the player.
  $8B09,$01 #REGa=#N$00 (no velocity).
  $8B0A,$03 Set the Y velocity to zero.
  $8B0D,$03 Set the X velocity to zero.
  $8B10,$03 Call #R$8ADB to look for an item.
  $8B13,$04 Jump to #R$8B59 if there is no item.
  $8B17,$03 Call #R$882D to head for the item.
  $8B1A,$01 Fetch which of the axes have been reached.
  $8B1B,$04 Jump to #R$8B45 if the hunchback has not arrived.
N $8B1F The hunchback is at the item, so remove it.
  $8B1F,$03 Call #R$8ADB to find the item again.
  $8B22,$03 #REGde=#N($0004,$04,$04) (the offset of the Y position within a
. record).
  $8B25,$01 Reset the carry flag.
  $8B26,$02 Subtract #REGde from #REGhl to get the address of the item.
  $8B28,$02 Stash the hunchback on the stack.
  $8B2A,$07 Make #REGix point at the item (copy #REGhl to #REGix).
  $8B31,$03 Fetch the room of the player from #R$EA91.
  $8B34,$03 Compare it with the room of the item.
  $8B37,$02 Jump to #R$8B3C if they are different.
  $8B39,$03 Call #R$9F4A to draw the item.
@ $8B3C label=HandlerHunchback_Remove
  $8B3C,$04 Write #N$00 to the sprite ID of the item.
  $8B40,$02 Restore the hunchback from the stack.
  $8B42,$03 Jump to #R$8B59 to move the hunchback.
N $8B45 The hunchback is on the way, so choose the sprite.
@ $8B45 label=HandlerHunchback_SetSprite
  $8B45,$03 Fetch the sprite ID of the hunchback.
  $8B48,$02,b$01 Keep only bits 2-7.
  $8B4A,$01 Keep the base sprite ID in #REGc.
  $8B4B,$03 Fetch the counter from #R$5E12.
  $8B4E,$02 Divide the counter by four.
  $8B50,$02,b$01 Keep only bits 0-1.
  $8B52,$01 Add the animation frame to the base sprite ID.
  $8B53,$03 Update the sprite ID of the hunchback.
  $8B56,$03 #REGde=#N($3C3C,$04,$04) (the area).
N $8B59 If the player is a character then the hunchback moves, otherwise he
. heads for a position in the room.
@ $8B59 label=HandlerHunchback_Move
  $8B59,$03 Fetch the sprite ID of the player from #R$EA90.
  $8B5C,$05 Jump to #R$84CD if the player is a character.
  $8B61,$03 #REGde=#N($3A58,$04,$04) (the target position).
  $8B64,$03 Call #R$882D to steer the creature towards its target.
  $8B67,$03 Jump to #R$84CD to move the creature.

b $8B6A Creature Defaults
@ $8B6A label=CreatureDefaults
D $8B6A The 16-byte record that #R$83EA copies into a free record to make a new
. creature. It starts as a sparkle (see #R$85F7).
. #TABLE(default,centre,left)
. { =h Offset | =h Description }
. { #N$00 | Sprite ID: #N$58 (the first frame of the sparkle) }
. { #N$01 | Room ID (set to the room of the player) }
. { #N$02 | The creature that the sparkle turns into (set from #R$8B7A) }
. { #N$03 | X position (set at random) }
. { #N$04 | Y position (set at random) }
. { #N$05 | Attribute: #COLOUR$44 }
. { #N$06 | Direction: #N$00 }
. { #N$07 | Step counter: #N$00 }
. { #N$08 | X velocity: #N$02 (set at random) }
. { #N$09 | Y velocity: #N$02 (set at random) }
. { #N$0A | Bobbing counter: #N$00 }
. { #N$0B | Waypoint X position: #N$00 }
. { #N$0C | Waypoint Y position: #N$00 }
. { #N$0D | Counter: #N$10 }
. { #N$0E | Sparkle counter: #N$20 }
. { #N$0F | Removal counter: #N$00 }
. TABLE#
B $8B6A,$10,$08

b $8B7A Creatures
@ $8B7A label=Creatures
D $8B7A The creatures that #R$83EA can make. One is chosen using the bottom four
. bits of FRAMES, and the value is the sprite ID of the first frame of the
. creature.
  $8B7A,$01 #SPRITENAME(#PEEK(#PC) - $01)
L $8B7A,$01,$10

c $8B8A Draw Chicken
@ $8B8A label=DrawChicken
D $8B8A Updates the picture of the roast chicken so that it shows the energy of
. the player. The energy in #R$5E28 and the level that was last drawn in
. #R$5E29 are both divided by eight, and nothing is done if they are the
. same. When the energy has gone up, the picture of the full chicken is
. drawn with a height of the new level. When it has gone down, the part of
. the empty chicken (see #R$C48C) below that level is drawn, by pointing the
. entry for it in the graphics table at #N$A626 at the data for that row and
. temporarily writing a new width and height there.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SCR$04,$18,$0A,$08,$06(chicken-before)
. | #POKES$5E28,$30
. #SIM(start=$8B8A,stop=$0000,sp=$5B60)
. #SCR$04,$18,$0A,$08,$06(chicken-after) } UDGTABLE# #POPS
N $8B8A Work out the new level and the level that was last drawn.
  $8B8A,$03 Fetch the energy of the player from #R$5E28.
  $8B8D,$06 Divide the energy of the player by eight, to get the new level.
  $8B93,$01 Keep the new level in #REGc.
  $8B94,$03 Fetch the level of the chicken from #R$5E29.
  $8B97,$06 Divide the level that was drawn by eight.
  $8B9D,$01 Keep the level that was drawn in #REGb.
  $8B9E,$01 Compare it with the new level.
  $8B9F,$01 Return if they are the same.
N $8BA0 Stash the heights of the two chicken graphics, and the entity, as they
. are changed below.
  $8BA0,$04 Fetch the height of the full chicken from #R$C543 and keep it in
. #REGe.
  $8BA4,$04 Fetch the height of the empty chicken from #R$C48D and keep it in
. #REGd.
  $8BA8,$02 Stash the chicken entity on the stack.
  $8BAA,$04 Point #REGix at the entity for the chicken at #R$8C2D.
  $8BAE,$01 Stash the heights of the graphics on the stack.
  $8BAF,$02 Jump to #R$8C12 if the energy has gone up.
N $8BB1 The energy has gone down, so draw the part of the empty chicken that is
. below the new level. First find the data for the row.
  $8BB1,$04 Fetch the width of the graphics in bytes from #R$C48C and keep it
. in #REGe.
  $8BB5,$02 Clear the high byte of the width in #REGd.
  $8BB7,$01 Fetch the new level.
  $8BB8,$01 Stash the levels on the stack.
  $8BB9,$03 Call #R$9AAD to multiply the width by the new level.
  $8BBC,$01 Restore the levels from the stack.
  $8BBD,$04 Fetch the address of the graphic from #N$A626.
  $8BC1,$01 Stash it on the stack.
  $8BC2,$01 Add the offset to the address of the graphic.
  $8BC3,$03 Update the address of the graphic at #N$A626.
N $8BC6 Save the two bytes at that address, and replace them with the width and
. the height that is left.
  $8BC6,$01 Fetch the first byte.
  $8BC7,$01 Move #REGhl on to the second byte.
  $8BC8,$01 Fetch the second byte.
  $8BC9,$03 Fetch the height of the empty chicken from #R$C48D.
  $8BCC,$01 Subtract the new level to get the height that is left.
  $8BCD,$02 Jump to #R$8BFC if there is nothing left to draw.
  $8BCF,$01 Stash #REGde on the stack.
  $8BD0,$01 Write the height that is left to the second byte.
  $8BD1,$03 Fetch the width from #R$C48C.
  $8BD4,$01 Move #REGhl back to the first byte.
  $8BD5,$01 Write the width to the first byte.
  $8BD6,$01 Stash the address of the graphic on the stack.
N $8BD7 Draw the part of the empty chicken, which is moved up by the new level.
  $8BD7,$02 #REGa=#N$14 (the empty chicken).
  $8BD9,$03 Update the graphic of the entity.
  $8BDC,$03 #REGhl=#N$77C8 (the position of the chicken).
  $8BDF,$01 Fetch the Y position.
  $8BE0,$01 Subtract the new level.
  $8BE1,$01 Set the new Y position in #REGh.
  $8BE2,$03 Update the position of the entity.
  $8BE5,$03 Call #R$9213 to draw the entity.
  $8BE8,$03 Fetch the position of the entity.
  $8BEB,$03 Call #R$9BA2 to get the screen address of the position.
N $8BEE Clear a row of bytes at that address.
  $8BEE,$04 Fetch the width from #R$C48C and keep the number of bytes to clear,
. which is the width in #REGb.
@ $8BF2 label=DrawChicken_ClearRow
  $8BF2,$02 Clear a byte of the row.
  $8BF4,$01 Move on to the next byte.
  $8BF5,$02 Decrease the byte counter by one and loop back to #R$8BF2 until the
. whole row has been cleared.
N $8BF7 Put back the two bytes that were replaced.
  $8BF7,$01 Restore the address of the first byte from the stack.
  $8BF8,$01 Restore the two bytes from the stack.
  $8BF9,$01 Write the first byte.
  $8BFA,$01 Move #REGhl on to the second byte.
  $8BFB,$01 Write the second byte.
@ $8BFC label=DrawChicken_RestoreGraphic
  $8BFC,$01 Restore the address of the graphic from the stack.
  $8BFD,$03 Update the address of the graphic at #N$A626.
N $8C00 Put back the heights of the graphics, and remember the level that has
. been drawn.
@ $8C00 label=DrawChicken_Finish
  $8C00,$01 Restore the stashed heights from the stack.
  $8C01,$01 Fetch the height of the full chicken.
  $8C02,$03 Update the height of the full chicken in #R$C543.
  $8C05,$01 Fetch the height of the empty chicken.
  $8C06,$03 Update the height of the empty chicken in #R$C48D.
  $8C09,$02 Restore the chicken entity from the stack.
N $8C0B See #POKE(infinite_chicken,Infinite Chicken).
  $8C0B,$03 Fetch the energy of the player from #R$5E28.
  $8C0E,$03 Update the level of the chicken in #R$5E29.
  $8C11,$01 Return.
N $8C12 The energy has gone up, so draw the full chicken with the height of the
. new level.
@ $8C12 label=DrawChicken_Increase
  $8C12,$01 Keep the new level in #REGa.
  $8C13,$03 Update the height of the full chicken in #R$C543.
  $8C16,$02 #REGa=#N$13 (the full chicken).
  $8C18,$03 Update the graphic of the entity.
  $8C1B,$03 #REGhl=#N$77C8 (the position of the chicken).
  $8C1E,$03 Update the position of the entity.
  $8C21,$03 Call #R$9213 to draw the entity.
  $8C24,$02 #REGb=#N$06 (the number of bytes to clear).
@ $8C26 label=DrawChicken_ClearBytes
  $8C26,$02 Clear a byte of the chicken.
  $8C28,$01 Move on to the next byte.
  $8C29,$02 Decrease the byte counter by one and loop back to #R$8C26 until all
. six bytes have been cleared.
  $8C2B,$02 Jump to #R$8C00 to put back the heights of the graphics.

b $8C2D Chicken Entity
@ $8C2D label=Entity_Chicken
D $8C2D The entity that #R$8B8A uses to draw the chicken. Entities are 8-byte
. records, and the position is set before each use.
B $8C2D,$08

c $8C35 Game Over
@ $8C35 label=GameOver
D $8C35 Clears the play area, prints "GAME OVER" and the game statistics,
. waits for a while and then returns to the game selection menu.
E $8C35 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$A8E3 }
. { #TRANZAM$6353 }
. LIST#
N $8C35 #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$A1F3 | =h After #R$9641 }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SIM(start=$8C35,stop=$8C44,sp=$5E00)
. #SCR$01(game-over-before)
. | #SIM(start=$8C44,stop=$8C47,sp=$5E00)
. #SCR$01(game-over-text)
. | #SIM(start=$8C47,stop=$8C4A,sp=$5E00)
. #SCR$01(game-over-statistics) } UDGTABLE# #POPS
  $8C35,$03 Call #R$8093 to clear the play area.
  $8C38,$06 Write #N$BE4C (the main font, see #R$BF4C) to #R$5E01.
N $8C3E Handle printing "Game Over" messaging.
  $8C3E,$03 #REGhl=#N$3040 (a Y position of #N$30 and an X position of #N$40).
  $8C41,$03 Point #REGde at the "Game Over" text at #R$8C59.
  $8C44,$03 Call #R$A1F3 to print the string.
N $8C47 Handle printing the game statistics.
  $8C47,$03 Call #R$9641 to show the game statistics.
N $8C4A Provide a pause for us to reflect that the game has now ended.
@ $8C4A label=GameOverDelay
  $8C4A,$02 #REGb=#N$14 (the number of times to run the delay loop).
  $8C4C,$03 #REGhl=#N($0000, $04, $04) (the delay counter).
N $8C4F From #REGhl being set above (and for each loop), decrementing #N($0000, $04, $04) by one gives #N$FFFF.
@ $8C4F label=GameOverDelay_Loop
  $8C4F,$01 Count the delay down by one.
  $8C50,$04 Loop back to #R$8C4F until the delay has counted down to zero.
  $8C54,$02 Decrease the delay counter by one and loop back to #R$8C4F until the
. delay has finished.
  $8C56,$03 Jump to #R$7C29 to go back to the menu.
N $8C59 "Game Over" messaging.
@ $8C59 label=StringGameOver
T $8C59,$0A,h$01,$08:$01 Attribute: #COLOUR(#PEEK(#PC)) + "GAME OVER".

c $8C63 Handle Food Item
@ $8C63 label=HandlerFoodItem
D $8C63 The handler for the food and drink items (sprite IDs #N$50 to #N$57).
. If the player is not touching the item then the colour of its cells is set
. by #R$92E0. When the player touches it the item is removed, the eating sound
. is queued (see #R$A485), and #N$40 is added to the energy of the player
. in #R$5E28, up to a maximum of #N$F0. The chicken is then redrawn by
. #R$8B8A.
R $8C63 IX The food item entity
  $8C63,$03 Call #R$9FFB to save the position of the item.
  $8C66,$03 Call #R$90FB to check whether the player is touching the item.
  $8C69,$02 Jump to #R$8C6E if the player is touching it.
  $8C6B,$03 Jump to #R$92E0 to set the colour of the item.
N $8C6E The player has touched the item, so remove it and give the player some
. energy.
@ $8C6E label=HandlerFoodItem_Eat
  $8C6E,$03 Call #R$9F56 to remove the item from the screen.
  $8C71,$04 Write #N$00 to the sprite ID of the item.
  $8C75,$03 Call #R$A485 to queue the eating sound.
  $8C78,$02 #REGc=#N$40 (the energy that is gained).
  $8C7A,$03 Fetch the energy of the player from #R$5E28.
  $8C7D,$01 Add the energy that is gained to the energy of the player.
  $8C7E,$02 Jump to #R$8C84 if the energy has overflowed.
  $8C80,$04 Jump to #R$8C86 if the energy of the player is lower than #N$F0,
. which is the maximum.
@ $8C84 label=HandlerFoodItem_MaximumEnergy
  $8C84,$02 #REGa=#N$F0 (the maximum energy).
@ $8C86 label=HandlerFoodItem_SetEnergy
  $8C86,$03 Update the energy of the player in #R$5E28.
  $8C89,$03 Jump to #R$8B8A to redraw the chicken.

c $8C8C Flash Score
@ $8C8C label=FlashScore
D $8C8C Called by #R$8CB7 while the timer at #R$5E3C is running. The timer is
. counted down, the beep of the start is made every sixteen steps, and the
. six attribute cells of the score at the top of the screen are set to flash.
. When the timer reaches zero the flash is turned off again.
  $8C8C,$01 Decrease the timer.
  $8C8D,$03 Write the timer back to #R$5E3C.
  $8C90,$02 Jump to #R$8CA7 if the timer has reached zero.
  $8C92,$02,b$01 Keep only bits 0-3.
  $8C94,$03 Call #R$A3E0 to make the beep, if the bottom four bits are zero.
  $8C97,$03 #REGhl=#N$50C8 (the screen address of the score).
  $8C9A,$03 Call #R$9BD2 to convert it to an attribute address.
  $8C9D,$02 #REGb=#N$06 (the number of attribute cells of the score).
@ $8C9F label=FlashScore_Loop
  $8C9F,$01 Fetch the attribute.
  $8CA0,$02,b$01 Set bit 7 (flash).
  $8CA2,$01 Write #REGa back to the attribute.
  $8CA3,$01 Move on to the next attribute.
  $8CA4,$02 Decrease the cell counter by one and loop back to #R$8C9F until all
. six cells are flashing.
  $8CA6,$01 Return.
N $8CA7 The timer has finished, so turn the flash off.
@ $8CA7 label=FlashScore_Stop
  $8CA7,$03 #REGhl=#N$50C8 (the screen address of the score).
  $8CAA,$03 Call #R$9BD2 to convert it to an attribute address.
  $8CAD,$02 #REGb=#N$06 (the number of attribute cells of the score).
@ $8CAF label=FlashScore_StopLoop
  $8CAF,$01 Fetch the attribute.
  $8CB0,$02,b$01 Reset bit 7 (flash).
  $8CB2,$01 Write #REGa back to the attribute.
  $8CB3,$01 Move on to the next attribute.
  $8CB4,$02 Decrease the cell counter by one and loop back to #R$8CAF until the
. flash is off in all six cells.
  $8CB6,$01 Return.

c $8CB7 Handle Player Appearing
@ $8CB7 label=HandlerPlayerAppearing
D $8CB7 The handler for the player (sprite ID #N$66) while the player is
. appearing at the start of a life, which is set up by #R$9443. While the timer
. at #R$5E3C is running #R$8C8C counts it down. After that the sprite of the
. player (the sprite ID at offset #N$07) is drawn one row more every fourth
. frame by #R$8CD4, while the sound of appearing is made and the colour of the
. cells changes. When all the rows have been drawn the sprite ID is put back
. and the handler is no longer used.
R $8CB7 IX The player entity
  $8CB7,$03 Fetch the timer from #R$5E3C.
  $8CBA,$03 Jump to #R$8C8C if the timer is running.
  $8CBD,$03 Fetch FRAMES.
  $8CC0,$02,b$01 Keep only bits 0-1.
  $8CC2,$03 Jump to #R$8D12 unless this is every fourth frame.
  $8CC5,$03 Increment the number of rows to draw at offset #N$06.
  $8CC8,$03 Fetch the sprite ID of the player from offset #N$07.
  $8CCB,$03 Call #R$9E89 to get the address of the sprite data.
  $8CCE,$01 Fetch the height of the sprite.
  $8CCF,$05 Jump to #R$8D32 if all of the rows have been drawn.
N $8CD4 Draw the row of the sprite that is given by the number of rows. This is
. done by pointing the entry for the sprite in the table of sprites at the row,
. and temporarily changing the byte before it to a height of one row.
@ $8CD4 label=HandlerPlayerAppearing_DrawRow
  $8CD4,$01 Stash the address of the sprite data on the stack.
  $8CD5,$01 Stash the address of the entry in the table of sprites on the stack.
  $8CD6,$02 Keep the address of the table entry in #REGbc.
  $8CD8,$03 Fetch the Y position of the entity.
  $8CDB,$03 Save it at offset #N$02.
  $8CDE,$03 Subtract the number of rows.
  $8CE1,$03 Update the Y position of the entity.
  $8CE4,$03 Fetch the number of rows.
  $8CE7,$02 Clear the high byte of the number of rows in #REGh.
  $8CE9,$01 Double #REGhl, as there are two bytes in each row.
  $8CEA,$01 Add the address of the sprite data to #REGhl.
  $8CEB,$01 Fetch the high byte of the address of the row.
  $8CEC,$01 Write #REGa to the high byte of the table entry.
  $8CED,$01 Move #REGbc back to the low byte.
  $8CEE,$01 Fetch the low byte of the address of the row.
  $8CEF,$01 Write #REGa to the low byte of the table entry.
  $8CF0,$01 Stash the address of the row on the stack.
  $8CF1,$01 Fetch the byte at the address of the row.
  $8CF2,$03 Fetch the sprite ID of the entity.
  $8CF5,$01 Stash them on the stack.
  $8CF6,$02 Write #N$01 (the height of one row) to the address of the row.
  $8CF8,$03 Fetch the sprite ID of the player from offset #N$07.
  $8CFB,$03 Write it to the sprite ID of the entity.
  $8CFE,$03 Call #R$9F4A to draw the row.
  $8D01,$01 Restore the byte and the sprite ID from the stack.
  $8D02,$01 Restore the address of the row from the stack.
  $8D03,$01 Write the byte back.
  $8D04,$03 Write the sprite ID back to the entity.
  $8D07,$03 Fetch the saved Y position from offset #N$02.
  $8D0A,$03 Write it back to the Y position of the entity.
  $8D0D,$01 Restore the address of the table entry from the stack.
  $8D0E,$01 Restore the address of the sprite data from the stack.
  $8D0F,$01 Write the high byte back to the table entry.
  $8D10,$01 Move #REGhl back to the low byte.
  $8D11,$01 Write the low byte back to the table entry.
N $8D12 Set the colour of the cells that have been drawn so far, which cycles
. with FRAMES, and make the sound of appearing.
@ $8D12 label=HandlerPlayerAppearing_Colour
  $8D12,$03 Fetch the attribute of the entity.
  $8D15,$01 Stash it on the stack.
  $8D16,$03 Fetch FRAMES.
  $8D19,$02 Divide FRAMES by four.
  $8D1B,$02,b$01 Keep only bits 0-2.
  $8D1D,$02 Jump to #R$8D20 if the result is not zero.
  $8D1F,$01 Use #N$01 instead, to avoid black.
@ $8D20 label=HandlerPlayerAppearing_SetColour
  $8D20,$02,b$01 Set bit 6 (bright).
  $8D22,$03 Update the attribute of the entity.
  $8D25,$03 Fetch the number of rows.
  $8D28,$03 Call #R$92E2 to set the attributes of that many rows.
  $8D2B,$01 Restore the attribute of the entity from the stack.
  $8D2C,$03 Write it back to the entity.
  $8D2F,$03 Jump to #R$A45F to make the sound of appearing.
N $8D32 All of the rows have been drawn, so the player is back.
@ $8D32 label=HandlerPlayerAppearing_Finish
  $8D32,$03 Fetch the sprite ID of the player from offset #N$07.
  $8D35,$03 Write it to the sprite ID of the entity.
  $8D38,$04 Write #N$00 to offset #N$06.
  $8D3C,$04 Write #N$00 to offset #N$07.
  $8D40,$04 Write #N$00 to offset #N$02.
  $8D44,$01 Return.

c $8D45 Handle Player Vanishing
@ $8D45 label=HandlerPlayerVanishing
D $8D45 The handler for the player (sprite ID #N$67) while a life is being
. lost, which is set up by #R$8EA0. This is the opposite of #R$8CB7, with the
. number of rows at offset #N$06 starting at the height of the sprite. On
. three frames out of four the row is drawn again (which erases it) by
. #R$8CD4 and the number is decreased. After the last row a tombstone is
. made by #R$95A9 and the next life is set up by #R$9443.
R $8D45 IX The player entity
  $8D45,$03 Fetch FRAMES.
  $8D48,$02,b$01 Keep only bits 0-1.
  $8D4A,$02 Jump to #R$8D12 if this is every fourth frame.
  $8D4C,$03 Decrease the number of rows at offset #N$06.
  $8D4F,$03 Jump to #R$8D5B if all the rows have gone.
  $8D52,$03 Fetch the sprite ID of the player from offset #N$07.
  $8D55,$03 Call #R$9E89 to get the address of the sprite data.
  $8D58,$03 Jump to #R$8CD4 to draw the row of the sprite.
@ $8D5B label=HandlerPlayerVanishing_Finish
  $8D5B,$03 Call #R$95A9 to make the tombstone.
  $8D5E,$03 Jump to #R$9443 to set up the next life.

c $8D61 Reset Game State
@ $8D61 label=ResetGameState
D $8D61 Restores the entities and the other game data that start at #R$EA90 to
. their initial state, ready for a new game. The initial state is kept in
. the copy of the data that starts at #R$600D.
E $8D61 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$A3DD }
. LIST#
  $8D61,$03 Point #REGhl at the player initialisation data at #R$600D.
  $8D64,$03 Point #REGde at the player at #R$EA90.
  $8D67,$03 #REGbc=#N($1570,$04,$04) (the number of bytes of game data).
  $8D6A,$02 Copy the initial game data over the live game data.
  $8D6C,$01 Return.

c $8D6D Auto Walk Step
@ $8D6D label=AutoWalkStep
D $8D6D Counts down the bottom four bits of offset #N$02 of an entity, if they
. are not zero. While they are not zero #R$8EEF moves the entity by a fixed
. step in the direction it is going, rather than by the controls.
R $8D6D IX The entity
  $8D6D,$03 Fetch offset #N$02 of the entity.
  $8D70,$02,b$01 Keep only bits 0-3.
  $8D72,$01 Return if the result is zero.
  $8D73,$03 Decrease offset #N$02 of the entity by one.
  $8D76,$01 Return.

c $8D77 Control Player
@ $8D77 label=ControlPlayer
D $8D77 Moves the entity of a character, using the controls. Called by the
. handlers of the knight and the serf (and the wizard). The velocities of the
. entity are kept at offsets #N$06 (X) and #N$07 (Y), and have four bits after
. the point, so only the top four bits make up the whole pixels moved each
. frame. They are changed by #R$8EEF, slowed by #R$8F96 and limited by #R$8FCA
. and #R$900A before #R$8F66 moves the entity. The bits at offset #N$02 are
. the number of steps still to be taken in the bottom four, and in bits 4-5
. a flag that is set when movement is blocked along the X axis (bit 4) or
. the Y axis (bit 5).
R $8D77 B The change made to a velocity each frame by the controls
R $8D77 C The fastest X velocity
. (the Y velocity is limited by #REGb)
R $8D77 D The amount that the Y velocity is slowed by each frame
R $8D77 E The amount that the X velocity is slowed by each frame
R $8D77 IX The entity of the character
  $8D77,$03 Fetch the room of the player from #R$EA91.
  $8D7A,$03 Write #REGa to #N$EE59 (the room of the entity at #R$63D5).
  $8D7D,$03 Stash the speed limits (#REGbc), the slowing (#REGde) and #REGhl on
. the stack.
  $8D80,$03 Call #R$8D6D to take a step of the auto walk.
  $8D83,$03 Fetch offset #N$02 of the entity.
  $8D86,$02,b$01 Set bits 4-5, to stop all movement until a check shows it is
. possible.
  $8D88,$03 Update offset #N$02 of the entity.
  $8D8B,$03 Call #R$9FFB to save the position of the entity.
N $8D8E Read the controls (a bit is zero when the control is used) and work out
. the change in velocity for each axis.
  $8D8E,$03 Call #R$93BE to read the controls.
  $8D91,$01 Keep the controls in #REGc.
  $8D92,$01 Restore #REGhl from the stack.
  $8D93,$03 #REGde=#N($0000,$04,$04) (no change in either velocity).
  $8D96,$04 Jump to #R$8D9E if bit 1 (left) is not used.
  $8D9A,$01 Fetch the change in velocity.
  $8D9B,$02 Reverse the change, so that it is negative.
  $8D9D,$01 #REGe=#REGa (the X change is -#REGb).
@ $8D9E label=ControlPlayer_Right
  $8D9E,$04 Jump to #R$8DA3 if bit 0 (right) is not used.
  $8DA2,$01 #REGe=#REGb (the X change is #REGb).
@ $8DA3 label=ControlPlayer_Down
  $8DA3,$04 Jump to #R$8DA8 if bit 2 (down) is not used.
  $8DA7,$01 #REGd=#REGb (the Y change is #REGb).
@ $8DA8 label=ControlPlayer_Up
  $8DA8,$04 Jump to #R$8DB0 if bit 3 (up) is not used.
  $8DAC,$01 Fetch the change in velocity.
  $8DAD,$02 Reverse the change, so that it is negative.
  $8DAF,$01 #REGd=#REGa (the Y change is -#REGb).
N $8DB0 Slow the velocities, change them, check for obstacles and then move the
. entity.
@ $8DB0 label=ControlPlayer_Move
  $8DB0,$01 Restore the amounts of slowing from the stack into #REGhl.
  $8DB1,$03 Call #R$8F96 to slow the entity down.
  $8DB4,$01 Restore the fastest velocities from the stack into #REGhl.
  $8DB5,$03 Call #R$8EEF to update the velocities of the entity.
  $8DB8,$03 Call #R$8FCA to check whether the entity is inside the room.
  $8DBB,$03 Call #R$957D to check the doorway.
  $8DBE,$03 Call #R$900A to check whether the entity would hit an item.
  $8DC1,$03 Jump to #R$8F66 to move the entity by its velocities.

c $8DC4 Handle Serf
@ $8DC4 label=HandlerSerf
D $8DC4 The handler for the serf (sprite IDs #N$21 to #N$30) when it is the
. character being played. The serf is moved by #R$8D77, with a change in
. velocity of #N$20, a top speed of #N$20 and a slowing of #N$01 on each
. frame. When it is moving, every fourth frame the next frame of the
. animation is chosen for the direction of travel (the four sets are left,
. right, up and down) and the sound of walking is made. Then the fire
. button throws a sword (see #R$8283), and #R$8E78 does the rest.
R $8DC4 IX The serf entity
  $8DC4,$03 #REGbc=#N($2020,$04,$04) (the change in velocity and the top speed).
  $8DC7,$03 #REGde=#N($0101,$04,$04) (the slowing of each velocity).
  $8DCA,$03 #REGhl=#N($0707,$04,$04) (this is not used by #R$8D77).
  $8DCD,$03 Call #R$8D77 to move the serf.
  $8DD0,$03 Fetch the X velocity.
  $8DD3,$03 Fetch the Y velocity.
  $8DD6,$04 Jump to #R$8E0F if the serf is not moving (both velocities are
. zero).
  $8DDA,$03 Fetch FRAMES.
  $8DDD,$02,b$01 Keep only bits 0-1.
  $8DDF,$02 Jump to #R$8E0F unless this is every fourth frame.
N $8DE1 Move on to the next frame of the animation, for the left set of sprites.
  $8DE1,$03 Fetch the sprite ID of the serf.
  $8DE4,$02,b$01 Keep only bits 0-1.
  $8DE6,$02 Add #N$21 (the first of the sprites facing left).
  $8DE8,$03 Update the sprite ID of the serf.
N $8DEB Work out which axis the serf is moving fastest on, by comparing the
. sizes of the velocities.
  $8DEB,$01 Fetch the Y velocity.
  $8DEC,$04 Jump to #R$8DF2 if the Y velocity is positive.
  $8DF0,$02 Make it positive.
@ $8DF2 label=HandlerSerf_CompareAxes
  $8DF2,$01 Keep the Y speed in #REGc.
  $8DF3,$01 Fetch the X velocity.
  $8DF4,$04 Jump to #R$8DFA if the X velocity is positive.
  $8DF8,$02 Make it positive.
@ $8DFA label=HandlerSerf_Compare
  $8DFA,$03 Jump to #R$8E1A if the serf is moving more across than up or down.
N $8DFD The serf is moving up or down, so add #N$08 for the sprites facing up or
. #N$0C for those facing down.
  $8DFD,$01 Fetch the Y velocity.
  $8DFE,$01 Test the sign of the Y velocity.
  $8DFF,$03 Fetch the sprite ID of the serf.
  $8E02,$03 Jump to #R$8E07 if the serf is moving up.
  $8E05,$02 Add #N$04.
@ $8E07 label=HandlerSerf_Vertical
  $8E07,$02 Add #N$08.
@ $8E09 label=HandlerSerf_SetSprite
  $8E09,$03 Update the sprite ID of the serf.
  $8E0C,$03 Call #R$A3C7 to make the sound of walking.
N $8E0F See whether the fire button is pressed, and then do what every character
. does.
@ $8E0F label=HandlerSerf_Fire
  $8E0F,$03 Call #R$93BE to read the controls.
  $8E12,$02,b$01 Keep only bit 4 (fire).
  $8E14,$03 Call #R$8283 to throw a sword if the fire button is pressed.
  $8E17,$03 Jump to #R$8E78 to finish handling the character.
N $8E1A The serf is moving across, so add #N$04 for the sprites facing right.
@ $8E1A label=HandlerSerf_Horizontal
  $8E1A,$01 Fetch the X velocity.
  $8E1B,$01 Test the sign of the X velocity.
  $8E1C,$03 Fetch the sprite ID of the serf.
  $8E1F,$03 Jump to #R$8E09 if the serf is moving left.
  $8E22,$02 Add #N$04.
  $8E24,$02 Jump to #R$8E09 to set the sprite of the serf.

c $8E26 Handle Knight
@ $8E26 label=HandlerKnight
D $8E26 The handler for the knight (sprite IDs #N$01 to #N$10) when it is the
. character being played. It is the same as #R$8DC4, except that the slowing is
. #N$03 on each frame and the fire button throws an axe (see #R$8134). The
. second part of this routine is used by the other characters as well: it
. makes creatures (see #R$83EA), takes energy from the player every sixteen
. frames, and displays the character.
R $8E26 IX The knight entity
  $8E26,$03 #REGbc=#N($2020,$04,$04) (the change in velocity and the top speed).
  $8E29,$03 #REGde=#N($0303,$04,$04) (the slowing of each velocity).
  $8E2C,$03 #REGhl=#N($0707,$04,$04) (this is not used by #R$8D77).
  $8E2F,$03 Call #R$8D77 to move the knight.
  $8E32,$03 Fetch the X velocity.
  $8E35,$03 Fetch the Y velocity.
  $8E38,$04 Jump to #R$8E70 if the knight is not moving (both velocities are
. zero).
  $8E3C,$03 Fetch FRAMES.
  $8E3F,$02,b$01 Keep only bits 0-1.
  $8E41,$02 Jump to #R$8E70 unless this is every fourth frame.
N $8E43 Move on to the next frame of the animation, for the left set of sprites.
  $8E43,$03 Fetch the sprite ID of the knight.
  $8E46,$02,b$01 Keep only bits 0-1.
  $8E48,$01 Add #N$01 (the first of the sprites facing left).
  $8E49,$03 Update the sprite ID of the knight.
N $8E4C Work out which axis the knight is moving fastest on, by comparing the
. sizes of the velocities.
  $8E4C,$01 Fetch the Y velocity.
  $8E4D,$04 Jump to #R$8E53 if the Y velocity is positive.
  $8E51,$02 Make it positive.
@ $8E53 label=HandlerKnight_CompareAxes
  $8E53,$01 Keep the Y speed in #REGc.
  $8E54,$01 Fetch the X velocity.
  $8E55,$04 Jump to #R$8E5B if the X velocity is positive.
  $8E59,$02 Make it positive.
@ $8E5B label=HandlerKnight_Compare
  $8E5B,$03 Jump to #R$8E94 if the knight is moving more across than up or down.
N $8E5E The knight is moving up or down, so add #N$08 for the sprites facing up
. or #N$0C for those facing down.
  $8E5E,$01 Fetch the Y velocity.
  $8E5F,$01 Test the sign of the Y velocity.
  $8E60,$03 Fetch the sprite ID of the knight.
  $8E63,$03 Jump to #R$8E68 if the knight is moving up.
  $8E66,$02 Add #N$04.
@ $8E68 label=HandlerKnight_Vertical
  $8E68,$02 Add #N$08.
@ $8E6A label=HandlerKnight_SetSprite
  $8E6A,$03 Update the sprite ID of the knight.
  $8E6D,$03 Call #R$A3C7 to make the sound of walking.
N $8E70 See whether the fire button is pressed.
@ $8E70 label=HandlerKnight_Fire
  $8E70,$03 Call #R$93BE to read the controls.
  $8E73,$02,b$01 Keep only bit 4 (fire).
  $8E75,$03 Call #R$8134 to throw an axe if the fire button is pressed.
N $8E78 Make creatures, use up some energy and display the character. This is
. also where the serf and the wizard come in.
@ $8E78 label=HandlerCharacter_Finish
  $8E78,$03 Call #R$83EA to make a creature, if one is due.
  $8E7B,$03 Fetch the counter from #R$5E12.
  $8E7E,$02,b$01 Keep only bits 0-3.
  $8E80,$02 Jump to #R$8E8E unless this is every sixteenth frame.
  $8E82,$03 Fetch the energy of the player from #R$5E28.
  $8E85,$01 Decrease the energy by one.
  $8E86,$02 Jump to #R$8EA0 if there is no energy left.
  $8E88,$03 Update the energy of the player in #R$5E28.
  $8E8B,$03 Call #R$8B8A to redraw the chicken.
@ $8E8E label=HandlerCharacter_Display
  $8E8E,$03 Call #R$9FCA to display the character.
  $8E91,$03 Jump to #R$A01A to set the attributes of the cells it covers.
N $8E94 The knight is moving across, so add #N$04 for the sprites facing right.
@ $8E94 label=HandlerKnight_Horizontal
  $8E94,$01 Fetch the X velocity.
  $8E95,$01 Test the sign of the X velocity.
  $8E96,$03 Fetch the sprite ID of the knight.
  $8E99,$03 Jump to #R$8E6A if the knight is moving left.
  $8E9C,$02 Add #N$04.
  $8E9E,$02 Jump to #R$8E6A to set the sprite of the knight.

c $8EA0 Lose Life
@ $8EA0 label=LoseLife
D $8EA0 Takes one of the lives of the player, or ends the game if there are none
. left. The player is set to the vanishing sprite #N$67 (see #R$8D45), with the
. number of rows to erase (at offset #N$06) set to the height of the sprite
. and the sprite ID that it came from (at offset #N$07). If the entity is a
. character then the position that was saved by #R$9FFB is used first.
R $8EA0 IX The entity of the character
  $8EA0,$03 Fetch the number of lives from #R$5E21.
  $8EA3,$01 Test whether there are no lives left.
  $8EA4,$03 Jump to #R$8C35 if there are none.
N $8EA7 See #POKE(infinite_lives,Infinite Lives).
  $8EA7,$01 Decrease the number of lives by one.
  $8EA8,$03 Update the number of lives in #R$5E21.
  $8EAB,$03 Fetch the sprite ID of the entity.
  $8EAE,$01 Subtract one to get the ID that starts at zero.
  $8EAF,$04 Jump to #R$8EC6 if the entity is a character.
  $8EB3,$03 Fetch the sprite ID of the player from #R$EA90.
@ $8EB6 label=LoseLife_Vanish
  $8EB6,$03 Store the sprite ID of the player at offset #N$07.
  $8EB9,$03 Call #R$9E89 to get the address of the sprite data.
  $8EBC,$01 Fetch the height of the sprite.
  $8EBD,$03 Store the height of the sprite at offset #N$06, as the number of
. rows to draw.
  $8EC0,$02 #REGa=#N$67 (the vanishing player).
  $8EC2,$03 Update the sprite ID of the player.
  $8EC5,$01 Return.
N $8EC6 Use the position and the sprite that were saved.
@ $8EC6 label=LoseLife_Character
  $8EC6,$03 Fetch the previous X position from #R$5E16.
  $8EC9,$03 Update the X position of the player.
  $8ECC,$03 Fetch the previous Y position from #R$5E17.
  $8ECF,$03 Update the Y position of the player.
  $8ED2,$03 Fetch the previous sprite ID from #R$5E15.
  $8ED5,$02 Jump to #R$8EB6 to start the player vanishing.

c $8ED7 Hurt Player
@ $8ED7 label=HurtPlayer
D $8ED7 Takes #N$20 from the energy of the player in #R$5E28, which is what
. happens when a creature touches them (see #R$85EA). The chicken is redrawn
. by #R$8B8A. If the energy is gone then #R$8EA0 takes a life.
  $8ED7,$03 Fetch the energy of the player from #R$5E28.
  $8EDA,$02 Subtract #N$20.
  $8EDC,$02 Jump to #R$8EE1 if the energy is zero.
  $8EDE,$02 Jump to #R$8EE9 if there is some energy left.
  $8EE0,$01 #REGa=#N$00 (no energy left).
@ $8EE1 label=HurtPlayer_NoEnergy
  $8EE1,$03 Update the energy of the player in #R$5E28.
  $8EE4,$03 Call #R$8B8A to redraw the chicken.
  $8EE7,$02 Jump to #R$8EA0 to take a life from the player.
@ $8EE9 label=HurtPlayer_Update
  $8EE9,$03 Update the energy of the player in #R$5E28.
  $8EEC,$03 Jump to #R$8B8A to redraw the chicken.

c $8EEF Update Velocity
@ $8EEF label=UpdateVelocity
D $8EEF Changes the velocities of an entity that is controlled by #R$8D77, and
. works out how many whole pixels it will move this frame. Each velocity (at
. offsets #N$06 and #N$07) has the change added, and is then limited to the
. fastest speed in either direction. The top four bits of the velocity are
. the pixels to move, which is #R$8F80. While the steps of an automatic
. walk are being counted down by #R$8D6D (the bottom four bits of offset
. #N$02) the pixels moved are #N$00 or #N$02 instead, depending on whether
. the velocity is below #N$10, with the sign of the velocity.
R $8EEF DE The change in each velocity (X in #REGe and Y in #REGd)
R $8EEF HL The fastest velocity (X in #REGl and Y in #REGh)
R $8EEF IX The entity
R $8EEF O:DE The pixels to move (X in #REGe and Y in #REGd)
  $8EEF,$03 Fetch offset #N$02 of the entity.
  $8EF2,$02,b$01 Keep only bits 0-3.
  $8EF4,$02 Jump to #R$8F35 if an automatic walk is under way.
N $8EF6 Change the X velocity, and keep it within the fastest speed.
  $8EF6,$01 Fetch the change in the X velocity from #REGe.
  $8EF7,$03 Add the X velocity.
  $8EFA,$03 Jump to #R$8F21 if the result is negative.
  $8EFD,$03 Jump to #R$8F01 if the X velocity is slower than the fastest X
. velocity.
  $8F00,$01 Use the fastest X velocity.
@ $8F01 label=UpdateVelocity_SetX
  $8F01,$03 Update the X velocity.
N $8F04 Change the Y velocity, and keep it within the fastest speed.
  $8F04,$01 Fetch the change in the Y velocity from #REGd.
  $8F05,$03 Add the Y velocity.
  $8F08,$03 Jump to #R$8F2B if the result is negative.
  $8F0B,$03 Jump to #R$8F0F if the Y velocity is slower than the fastest Y
. velocity.
  $8F0E,$01 Use the fastest Y velocity.
@ $8F0F label=UpdateVelocity_SetY
  $8F0F,$03 Update the Y velocity.
N $8F12 Get the whole pixels from the velocities.
  $8F12,$03 Fetch the X velocity.
  $8F15,$03 Call #R$8F80 to convert the velocity to whole pixels.
  $8F18,$01 Keep the whole pixels of the X velocity in #REGe.
  $8F19,$03 Fetch the Y velocity.
  $8F1C,$03 Call #R$8F80 to convert the velocity to whole pixels.
  $8F1F,$01 Keep the whole pixels of the Y velocity in #REGd.
  $8F20,$01 Return.
N $8F21 The X velocity is negative, so limit it using its size.
@ $8F21 label=UpdateVelocity_NegativeX
  $8F21,$02 Make the X velocity positive.
  $8F23,$03 Jump to #R$8F27 if the X velocity is slower than the fastest X
. velocity.
  $8F26,$01 Use the fastest X velocity.
@ $8F27 label=UpdateVelocity_NegateX
  $8F27,$02 Make the X velocity negative again.
  $8F29,$02 Jump to #R$8F01 to set the X velocity.
N $8F2B The Y velocity is negative, so limit it using its size.
@ $8F2B label=UpdateVelocity_NegativeY
  $8F2B,$02 Make the Y velocity positive.
  $8F2D,$03 Jump to #R$8F31 if the Y velocity is slower than the fastest Y
. velocity.
  $8F30,$01 Use the fastest Y velocity.
@ $8F31 label=UpdateVelocity_NegateY
  $8F31,$02 Make the Y velocity negative again.
  $8F33,$02 Jump to #R$8F0F to set the Y velocity.
N $8F35 An automatic walk is under way, so move by two pixels on an axis if its
. velocity is #N$10 or more, or else not at all.
@ $8F35 label=UpdateVelocity_Walk
  $8F35,$03 Fetch the X velocity.
  $8F38,$04 Jump to #R$8F52 if the X velocity is negative.
  $8F3C,$02,b$01 Keep only bits 4-7.
  $8F3E,$02 Jump to #R$8F42 if the result is zero.
  $8F40,$02 #REGa=#N$02 (move two pixels right).
@ $8F42 label=UpdateVelocity_WalkY
  $8F42,$01 Keep the X move in #REGe.
  $8F43,$03 Fetch the Y velocity.
  $8F46,$04 Jump to #R$8F5C if the Y velocity is negative.
  $8F4A,$02,b$01 Keep only bits 4-7.
  $8F4C,$02 Jump to #R$8F50 if the result is zero.
  $8F4E,$02 #REGa=#N$02 (move two pixels down).
@ $8F50 label=UpdateVelocity_WalkEnd
  $8F50,$01 Keep the Y move in #REGd.
  $8F51,$01 Return.
@ $8F52 label=UpdateVelocity_WalkNegativeX
  $8F52,$02 Make the X velocity positive.
  $8F54,$02,b$01 Keep only bits 4-7.
  $8F56,$02 Jump to #R$8F42 if the result is zero.
  $8F58,$02 #REGa=-#N$02 (move two pixels left).
  $8F5A,$02 Jump to #R$8F42 to do the walk on the Y axis.
@ $8F5C label=UpdateVelocity_WalkNegativeY
  $8F5C,$02 Make the Y velocity positive.
  $8F5E,$02,b$01 Keep only bits 4-7.
  $8F60,$02 Jump to #R$8F50 if the result is zero.
  $8F62,$02 #REGa=-#N$02 (move two pixels up).
  $8F64,$02 Jump to #R$8F50 to finish the walk.

c $8F66 Apply Movement
@ $8F66 label=ApplyMovement
D $8F66 Moves an entity by whole pixels on each axis, unless the flag for the
. axis in bits 4-5 of offset #N$02 is set. The flags are set by #R$8D77 and
. cleared again by #R$8FCA and #R$900A if the move is possible.
R $8F66 DE The pixels to move (X in #REGe and Y in #REGd)
R $8F66 IX The entity
  $8F66,$06 Jump to #R$8F73 if the flag for the X axis (bit 4) is set.
  $8F6C,$01 Fetch the X move.
  $8F6D,$03 Add the X position of the entity.
  $8F70,$03 Update the X position of the entity.
@ $8F73 label=ApplyMovement_Y
  $8F73,$05 Return if the flag for the Y axis (bit 5) is set.
  $8F78,$01 Fetch the Y move.
  $8F79,$03 Add the Y position of the entity.
  $8F7C,$03 Update the Y position of the entity.
  $8F7F,$01 Return.

c $8F80 Get Whole Pixels
@ $8F80 label=GetWholePixels
D $8F80 Converts a velocity, which has four bits after the point, to the number
. of whole pixels to move. This is the velocity divided by sixteen, rounded
. towards zero.
E $8F80 View the equivalent code in;
. #LIST
. { #SABREWULF$B031 }
. LIST#
R $8F80 A The velocity (signed)
R $8F80 O:A The whole pixels
  $8F80,$01 Test the sign of the velocity.
  $8F81,$03 Jump to #R$8F8F if it is positive.
  $8F84,$02 Make the velocity positive.
  $8F86,$04 Shift the velocity right four times, to drop the bits after the
. point.
  $8F8A,$02,b$01 Keep only bits 0-3.
  $8F8C,$02 Make the result negative.
  $8F8E,$01 Return.
@ $8F8F label=GetWholePixels_Positive
  $8F8F,$04 Shift the velocity right four times, to drop the bits after the
. point.
  $8F93,$02,b$01 Keep only bits 0-3.
  $8F95,$01 Return.

c $8F96 Slow Velocity
@ $8F96 label=SlowVelocity
D $8F96 Takes some speed off both of the velocities of an entity, which are at
. offsets #N$06 and #N$07. Neither of them goes beyond zero. Nothing is
. done while an automatic walk is under way (see #R$8D6D).
R $8F96 HL The amount to take off each velocity (X in #REGl and Y in #REGh)
R $8F96 IX The entity
  $8F96,$03 Fetch offset #N$02 of the entity.
  $8F99,$02,b$01 Keep only bits 0-3.
  $8F9B,$01 Return if an automatic walk is under way.
  $8F9C,$03 Fetch the X velocity.
  $8F9F,$01 Test whether it is zero.
  $8FA0,$02 Jump to #R$8FAD if it is.
  $8FA2,$03 Jump to #R$8FBE if it is negative.
  $8FA5,$01 Subtract the amount from the velocity.
  $8FA6,$03 Jump to #R$8FAA if it is still positive.
@ $8FA9 label=SlowVelocity_ZeroX
  $8FA9,$01 #REGa=#N$00 (the velocity when it is stopped).
@ $8FAA label=SlowVelocity_SetX
  $8FAA,$03 Update the X velocity.
@ $8FAD label=SlowVelocity_Y
  $8FAD,$03 Fetch the Y velocity.
  $8FB0,$01 Test whether it is zero.
  $8FB1,$01 Return if it is.
  $8FB2,$03 Jump to #R$8FC4 if it is negative.
  $8FB5,$01 Subtract the amount from the velocity.
  $8FB6,$03 Jump to #R$8FBA if it is still positive.
@ $8FB9 label=SlowVelocity_ZeroY
  $8FB9,$01 #REGa=#N$00 (the velocity when it is stopped).
@ $8FBA label=SlowVelocity_SetY
  $8FBA,$03 Update the Y velocity.
  $8FBD,$01 Return.
@ $8FBE label=SlowVelocity_NegativeX
  $8FBE,$01 Add the amount to the velocity.
  $8FBF,$03 Jump to #R$8FAA if it is still negative.
  $8FC2,$02 Jump to #R$8FA9 to zero the X velocity.
@ $8FC4 label=SlowVelocity_NegativeY
  $8FC4,$01 Add the amount to the velocity.
  $8FC5,$03 Jump to #R$8FBA if it is still negative.
  $8FC8,$02 Jump to #R$8FB9 to zero the Y velocity.

c $8FCA Check Room Bounds
@ $8FCA label=CheckRoomBounds
D $8FCA Checks whether an entity could move along each axis without leaving the
. room. If the position it would be at is inside the room then the flag for
. the axis in offset #N$02 is cleared (bit 4 for X and bit 5 for Y), so that
. #R$8F66 will move it. The position is inside the room when the distance
. from the centre of the room (#N$58 across and #N$68 down) is less than the
. width and the height in #R$5E1D.
R $8FCA DE The pixels to move (X in #REGe and Y in #REGd)
R $8FCA IX The entity
  $8FCA,$01 Stash the moves on the stack.
  $8FCB,$01 Fetch the X move.
  $8FCC,$03 Add the X position of the entity.
  $8FCF,$01 Keep the new X position in #REGe.
  $8FD0,$03 Fetch the Y position of the entity.
  $8FD3,$02 #REGb=#N$10 (the flag for the X axis).
  $8FD5,$03 Call #R$8FE9 to check whether the position is inside the room.
  $8FD8,$01 Restore the moves from the stack.
  $8FD9,$01 Stash it on the stack again.
  $8FDA,$03 Fetch the X position of the entity.
  $8FDD,$01 Fetch the Y move.
  $8FDE,$03 Add the Y position of the entity.
  $8FE1,$01 Keep the new Y position in #REGd.
  $8FE2,$02 #REGb=#N$20 (the flag for the Y axis).
  $8FE4,$03 Call #R$8FE9 to check whether the position is inside the room.
  $8FE7,$01 Restore the moves from the stack.
  $8FE8,$01 Return.
N $8FE9 Clears a flag if a position is inside the room.
@ $8FE9 label=CheckRoomBounds_Position
  $8FE9,$03 Point #REGhl at the room width at #R$5E1D.
  $8FEC,$01 Fetch the X position to check.
  $8FED,$02 Subtract #N$58 (the horizontal centre of the room).
  $8FEF,$03 Jump to #R$8FF4 if the result is positive.
  $8FF2,$02 Make the result positive.
@ $8FF4 label=CheckRoomBounds_Width
  $8FF4,$01 Compare it with the width of the room.
  $8FF5,$01 Return if it is outside.
  $8FF6,$01 Move #REGhl on to the height of the room.
  $8FF7,$01 Fetch the Y position to check.
  $8FF8,$02 Subtract #N$68 (the vertical centre of the room).
  $8FFA,$03 Jump to #R$8FFF if the result is positive.
  $8FFD,$02 Make the result positive.
@ $8FFF label=CheckRoomBounds_Height
  $8FFF,$01 Compare it with the height of the room.
  $9000,$01 Return if it is outside.
  $9001,$01 Fetch the flag for the axis.
  $9002,$01 Invert the flag, to make a mask.
  $9003,$03 Clear the flag in offset #N$02 of the entity.
  $9006,$03 Write the result back to offset #N$02.
  $9009,$01 Return.

c $900A Check Obstacles
@ $900A label=CheckObstacles
D $900A Checks whether an entity would hit one of the items in the room if it
. moved along each axis. This is the same as #R$8FCA, but for each of the
. items in the list for the room (see #R$7E23) whose attribute does not have
. bit 3 set. The position that the entity would move to is tested against
. a rectangle for the item. The byte at offset #N$06 of the item gives the
. left side in its top four bits (signed) and the width in its bottom four
. bits, and the byte at offset #N$07 gives the top and the height in
. the same way, all in units of four pixels. If the position is in the
. rectangle then the flag for the axis in offset #N$02 of the entity is set
. if the attribute of the item has bit 2 set, and cleared if it does not.
R $900A DE The pixels to move (X in #REGe and Y in #REGd)
R $900A IX The entity
  $900A,$01 Stash the moves on the stack.
  $900B,$01 Fetch the X move.
  $900C,$03 Add the X position of the entity.
  $900F,$01 Keep the new X position in #REGe.
  $9010,$03 Fetch the Y position of the entity.
  $9013,$02 #REGa=#N$10 (the flag for the X axis).
  $9015,$01 Save the flag for the axis in #REGaf'.
  $9016,$03 Call #R$902B to test the position against the items for the room.
  $9019,$01 Restore the moves from the stack.
  $901A,$01 Stash it on the stack again.
  $901B,$03 Fetch the X position of the entity.
  $901E,$01 Fetch the Y move.
  $901F,$03 Add the Y position of the entity.
  $9022,$01 Keep the new Y position in #REGd.
  $9023,$02 #REGa=#N$20 (the flag for the Y axis).
  $9025,$01 Save the flag for the axis in #REGaf'.
  $9026,$03 Call #R$902B to test the position against the items for the room.
  $9029,$01 Restore the moves from the stack.
  $902A,$01 Return.
N $902B Test the position against the items for the room.
@ $902B label=CheckObstacles_Position
  $902B,$03 Fetch the room of the entity.
  $902E,$02 Clear the high byte of the room number.
  $9030,$03 #REGhl=#N$757D (the start of the lists of items for the rooms).
  $9033,$04 Double #REGbc, as there are two bytes for each room.
  $9037,$01 Find the entry for the room in the table of item lists.
  $9038,$01 Fetch the low byte of the address of the list.
  $9039,$01 Move #REGhl on to the high byte.
  $903A,$01 Fetch the high byte of the address of the list.
@ $903B label=CheckObstacles_Next
  $903B,$01 Fetch the low byte of the address of the item.
  $903C,$01 Move #REGbc on to the next byte.
  $903D,$01 Keep the low byte of the address of the item in #REGl.
  $903E,$01 Fetch the high byte of the address of the item.
  $903F,$01 Move #REGbc on to the next entry in the list.
  $9040,$01 Keep the high byte of the address of the item in #REGh.
  $9041,$02 Return if the address of the item is zero, which is the end of the
. list.
  $9043,$01 Stash the list pointer on the stack.
  $9044,$03 #REGbc=#N$757D.
  $9047,$03 Subtract #REGbc from #REGhl to get the address of the live record.
  $904A,$01 Move #REGhl on to the room of the item.
  $904B,$01 Fetch the room of the item.
  $904C,$03 Compare it with the room of the entity.
  $904F,$02 Jump to #R$9055 if they are the same.
  $9051,$03 #REGbc=#N($0008,$04,$04) (the size of half a record).
  $9054,$01 Move #REGhl on to the second half of the record.
@ $9055 label=CheckObstacles_Item
  $9055,$02 Move #REGhl on to offset #N$03 of the item.
  $9057,$01 Fetch the X position of the item.
  $9058,$01 Move #REGhl on to the next byte.
  $9059,$01 Fetch the Y position of the item.
  $905A,$01 Move #REGhl on to the next byte.
  $905B,$01 Fetch the attribute of the item.
  $905C,$01 Move #REGhl on to the next byte.
  $905D,$04 Jump to #R$909B if bit 2 of the attribute is set.
  $9061,$04 Jump to #R$9098 if bit 3 of the attribute is set.
N $9065 The item lets the entity through if the position is inside the
. rectangle, so clear the flag.
  $9065,$01 #REGa=offset #N$06 of the item (the left side and the width).
  $9066,$04 Shift #REGa right twice, keeping the sign.
  $906A,$02,b$01 Keep only bits 2-7.
  $906C,$01 Add the X position of the item.
  $906D,$01 Subtract the new X position of the entity.
  $906E,$02 Negate the result, to get the distance from the left side.
  $9070,$01 Keep the distance from the left in #REGc.
  $9071,$01 Fetch offset #N$06 of the item.
  $9072,$02 Rotate #REGa left twice.
  $9074,$02,b$01 Keep only bits 2-5 (the width).
  $9076,$01 Move #REGhl on to offset #N$07 of the item.
  $9077,$03 Jump to #R$9098 if the position is not inside the item.
  $907A,$01 #REGa=offset #N$07 of the item (the top and the height).
  $907B,$04 Shift #REGa right twice, keeping the sign.
  $907F,$02,b$01 Keep only bits 2-7.
  $9081,$01 Add the Y position of the item.
  $9082,$01 Subtract the new Y position of the entity.
  $9083,$01 Keep the distance from the top in #REGb.
  $9084,$01 Fetch offset #N$07 of the item.
  $9085,$01 Move #REGhl on to the next byte.
  $9086,$02 Rotate #REGa left twice.
  $9088,$02,b$01 Keep only bits 2-5 (the height).
  $908A,$03 Jump to #R$9098 if the position is not inside the item.
  $908D,$01 Swap #REGaf and #REGaf' to get the flag.
  $908E,$01 Keep the flag for the axis in #REGc.
  $908F,$01 Swap #REGaf and #REGaf' back again.
  $9090,$01 Fetch the flag for the axis.
  $9091,$01 Invert the flag, to make a mask.
  $9092,$03 Clear the flag in offset #N$02 of the entity.
@ $9095 label=CheckObstacles_SetFlags
  $9095,$03 Write #REGa to offset #N$02 of the entity.
@ $9098 label=CheckObstacles_Skip
  $9098,$01 Restore the list pointer from the stack.
  $9099,$02 Jump back to #R$903B to look at the next item.
N $909B The item blocks the entity if the position is inside the rectangle, so
. set the flag.
@ $909B label=CheckObstacles_Solid
  $909B,$01 #REGa=offset #N$06 of the item (the left side and the width).
  $909C,$04 Shift #REGa right twice, keeping the sign.
  $90A0,$02,b$01 Keep only bits 2-7.
  $90A2,$01 Add the X position of the item.
  $90A3,$01 Subtract the new X position of the entity.
  $90A4,$02 Negate the result, to get the distance from the left side.
  $90A6,$01 Keep the distance from the left in #REGc.
  $90A7,$01 Fetch offset #N$06 of the item.
  $90A8,$02 Rotate #REGa left twice.
  $90AA,$02,b$01 Keep only bits 2-5 (the width).
  $90AC,$01 Move #REGhl on to offset #N$07 of the item.
  $90AD,$03 Jump to #R$9098 if the position is not inside the item.
  $90B0,$01 #REGa=offset #N$07 of the item (the top and the height).
  $90B1,$04 Shift #REGa right twice, keeping the sign.
  $90B5,$02,b$01 Keep only bits 2-7.
  $90B7,$01 Add the Y position of the item.
  $90B8,$01 Subtract the new Y position of the entity.
  $90B9,$01 Keep the distance from the top in #REGb.
  $90BA,$01 Fetch offset #N$07 of the item.
  $90BB,$01 Move #REGhl on to the next byte.
  $90BC,$02 Rotate #REGa left twice.
  $90BE,$02,b$01 Keep only bits 2-5 (the height).
  $90C0,$03 Jump to #R$9098 if the position is not inside the item.
  $90C3,$01 Swap #REGaf and #REGaf' to get the flag.
  $90C4,$01 Keep the flag for the axis in #REGc.
  $90C5,$01 Swap #REGaf and #REGaf' back again.
  $90C6,$01 Fetch the flag for the axis.
  $90C7,$03 Set the flag in offset #N$02 of the entity.
  $90CA,$02 Jump to #R$9095 to set the flags of the entity.

c $90CC Check Player In Range
@ $90CC label=CheckPlayerInRange
D $90CC Checks whether the player is close to the entity of a door. It is only
. checked when the player is a character and the bottom four bits of offset
. #N$02 of the player are zero. The player is in range when it is to the right
. of the position of the entity by less than the range along the X axis, and
. above it by less than the range along the Y axis. The range along the X axis
. is halved if the attribute of the entity is bright, and the range along the
. Y axis is halved if it is not.
R $90CC B The range along the Y axis
R $90CC C The range along the X axis
R $90CC IX The entity
R $90CC O:F The carry flag is set if the player is in range
  $90CC,$03 Fetch offset #N$02 of the player.
  $90CF,$02,b$01 Keep only bits 0-3.
  $90D1,$01 Return if they are not all zero.
  $90D2,$03 Fetch the sprite ID of the player from #R$EA90.
  $90D5,$01 Subtract one to get the ID that starts at zero.
  $90D6,$03 Return if the player is not a character.
  $90D9,$06 Jump to #R$90E1 if the attribute of the entity is not bright.
  $90DF,$02 Halve the range along the X axis.
@ $90E1 label=CheckPlayerInRange_X
  $90E1,$03 Fetch the X position of the player from #N$EA93.
  $90E4,$03 Subtract the X position of the entity.
  $90E7,$02 Return if the player is not in range.
  $90E9,$06 Jump to #R$90F1 if the attribute of the entity is bright.
  $90EF,$02 Halve the range along the Y axis.
@ $90F1 label=CheckPlayerInRange_Y
  $90F1,$03 Fetch the Y position of the player from #N$EA94.
  $90F4,$03 Subtract the Y position of the entity.
  $90F7,$02 Negate the result.
  $90F9,$01 Compare it with the range.
  $90FA,$01 Return.

c $90FB Check Player Touching
@ $90FB label=CheckPlayerTouching
D $90FB Checks whether the player is touching an entity. The player is touching
. it when it is less than #N$0C pixels away on both axes.
R $90FB IX The entity
R $90FB O:F The carry flag is set if the player is touching the entity
  $90FB,$03 Fetch the X position of the player from #N$EA93.
  $90FE,$03 Subtract the X position of the entity.
  $9101,$03 Jump to #R$9106 if the result is positive.
  $9104,$02 Make the result positive.
@ $9106 label=CheckPlayerTouching_X
  $9106,$03 Return if the player is too far away on the X axis.
  $9109,$03 Fetch the Y position of the player from #N$EA94.
  $910C,$03 Subtract the Y position of the entity.
  $910F,$03 Jump to #R$9114 if the result is positive.
  $9112,$02 Make the result positive.
@ $9114 label=CheckPlayerTouching_Y
  $9114,$02 Compare it with #N$0C.
  $9116,$01 Return.

c $9117 Enter Door
@ $9117 label=EnterDoor
D $9117 Moves the player through the door that has been entered, to the room on
. the other side. The entity for the other half of the door is found with
. #R$9286. The room, the position, and the velocity of the player (from
. #R$986A) are set from it. The player is flagged as being in a doorway (the
. bottom four bits of offset #N$02 are set), and this carries on into
. #R$9147 to draw the room.
R $9117 IX The entity of the door
  $9117,$03 Call #R$9286 to point #REGix at the other half of the door.
  $911A,$03 Fetch the room of the other half of the door.
  $911D,$03 Update the room of the player in #R$EA91.
  $9120,$03 Fetch offset #N$02 of the door.
  $9123,$01 Rotate #REGa left.
  $9124,$02,b$01 Keep only bits 1-4.
  $9126,$03 Add the X position of the door.
  $9129,$03 Update the X position of the player.
  $912C,$03 Fetch offset #N$02 of the door.
  $912F,$03 Rotate #REGa right three times.
  $9132,$02,b$01 Keep only bits 1-4.
  $9134,$02 Make the offset negative.
  $9136,$03 Add the Y position of the door.
  $9139,$03 Update the Y position of the player.
  $913C,$03 Call #R$986A to set the velocity of the player to move out of the
. door.
  $913F,$03 Fetch offset #N$02 of the player.
  $9142,$02,b$01 Set bits 0-3.
  $9144,$03 Update offset #N$02 of the player.

c $9147 Enter Room
@ $9147 label=EnterRoom
D $9147 Enters the room held in #R$EA91: records the visit, clears the play
. area and draws the room frame, the side panel attributes and the
. inventory. Then jumps to the main loop.
  $9147,$03 Fetch the room of the player from #R$EA91.
  $914A,$03 Call #R$96AF to mark the room as visited.
  $914D,$03 Call #R$8093 to clear the play area.
  $9150,$03 Call #R$9BEA to draw the frame of the room.
  $9153,$03 Call #R$A240 to set the attributes of the side panel.
  $9156,$03 Call #R$A13B to draw the inventory.
  $9159,$03 Call #R$A403 to play the sound for entering a room.
  $915C,$03 Jump to #R$7DC3 to run the main loop.

c $915F Handle Door Open
@ $915F label=HandlerDoorOpen
D $915F The handler for the doors that are open (sprite IDs #N$21 and #N$23 in
. #R$802A) and that close after a time, as made by #R$94F5. On every other frame
. (when bit 0 of #R$5E12 is reset) the door timer at #R$5E2E is counted down.
. When it has reached zero, and the player is not in a doorway (see #R$957D),
. #R$9193 closes the door. Otherwise the door is just checked for being used as
. an exit (see #R$91F2).
R $915F IX The door entity
  $915F,$03 Fetch the counter from #R$5E12.
  $9162,$02,b$01 Keep only bit 0.
  $9164,$03 Jump to #R$91F2 on every other frame.
  $9167,$03 Fetch the door timer from #R$5E2E.
  $916A,$01 Test whether the door timer is zero.
  $916B,$02 Jump to #R$9174 if it is.
  $916D,$01 Decrease the door timer by one.
  $916E,$03 Update the door timer in #R$5E2E.
  $9171,$03 Jump to #R$91F2 to handle the exit of the door.
@ $9174 label=HandlerDoorOpen_CheckDoorway
  $9174,$03 Fetch the doorway flag from #R$5E2D.
  $9177,$01 Test whether the player is in a doorway.
  $9178,$03 Jump to #R$91F2 if the player is.
  $917B,$02 Jump to #R$9193 to restart the door timer and toggle both halves of
. the door.

c $917D Handle Door Closed
@ $917D label=HandlerDoorClosed
D $917D The handler for the doors that are closed (sprite IDs #N$20 and #N$22 in
. #R$802A) and that open after a time, as made by #R$94F5. This is the same as
. #R$915F, except that the door is shown (see #R$91FE) instead of being used
. as an exit, there is no check for the player being in a doorway, and #R$9193
. opens the door.
R $917D IX The door entity
  $917D,$03 Fetch the counter from #R$5E12.
  $9180,$02,b$01 Keep only bit 0.
  $9182,$03 Jump to #R$91FE on every other frame.
  $9185,$03 Fetch the door timer from #R$5E2E.
  $9188,$01 Test whether the door timer is zero.
  $9189,$03 Jump to #R$9193 if it is.
N $918C See #POKE(allow_doors_to_open_quickly,Allow Doors To Open Quickly).
  $918C,$01 Decrease the door timer by one.
  $918D,$03 Update the door timer in #R$5E2E.
  $9190,$03 Jump to #R$91FE to handle a room item that does nothing.
N $9193 Restart the door timer, and change both halves of the door from open to
. closed or the other way round. The door is erased and drawn again with a
. temporary attribute.
@ $9193 label=HandlerDoor_Toggle
  $9193,$05 Restart the door timer by writing #N$5E to #R$5E2E.
  $9198,$03 Fetch the attribute of the door.
  $919B,$01 Stash it on the stack.
  $919C,$02,b$01 Set bits 0-1, which is temporary.
  $919E,$03 Update the attribute of the door.
  $91A1,$03 Call #R$9213 to erase the door.
  $91A4,$03 Fetch the sprite ID of the door.
  $91A7,$02,b$01 Flip bit 0, which changes the door from open to closed or the
. other way round.
  $91A9,$03 Call #R$9260 to write #REGa to both halves of the door.
  $91AC,$03 Call #R$9213 to draw the door.
  $91AF,$01 Restore the attribute of the door from the stack.
  $91B0,$03 Write it to the attribute of the door.
  $91B3,$03 Call #R$9546 to set whether the doorway can be used.
  $91B6,$03 Call #R$91FE to handle a room item that does nothing.
  $91B9,$03 Jump to #R$A46E to make the sound of a door.

c $91BC Handle Trap Closed
@ $91BC label=HandlerTrapClosed
D $91BC The handler for a trapdoor that is closed (sprite ID #N$18). It is
. opened by #R$91CC when the counter in #R$5E12 is zero.
R $91BC IX The trapdoor entity
  $91BC,$03 Fetch the counter from #R$5E12.
  $91BF,$01 Test whether the counter is zero.
  $91C0,$03 Jump to #R$91FE if it is not.
  $91C3,$02 Jump to #R$91CC to toggle the trapdoor between open and closed.

c $91C5 Handle Trap Open
@ $91C5 label=HandlerTrapOpen
D $91C5 The handler for a trapdoor that is open (sprite ID #N$19). If the
. low byte of the random number seed at #R$5E05 is not zero then the trapdoor
. is used by #R$9731. Otherwise #R$91CC closes it.
R $91C5 IX The trapdoor entity
  $91C5,$03 Fetch the random seed from #R$5E05.
  $91C8,$01 Test whether it is zero.
  $91C9,$03 Jump to #R$9731 if it is not.
N $91CC Change the trapdoor from open to closed or the other way round. It is
. erased and drawn again with a temporary attribute.
@ $91CC label=HandlerTrap_Toggle
  $91CC,$03 Fetch the attribute of the trapdoor.
  $91CF,$01 Stash it on the stack.
  $91D0,$02,b$01 Set bits 0-1, which is temporary.
  $91D2,$03 Update the attribute of the trapdoor.
  $91D5,$03 Call #R$9213 to erase the trapdoor.
  $91D8,$03 Fetch the sprite ID of the trapdoor.
  $91DB,$02,b$01 Flip bit 0, which changes the trapdoor from open to closed or
. the other way round.
  $91DD,$03 Update the sprite ID of the trapdoor.
  $91E0,$03 Call #R$9213 to draw the trapdoor.
  $91E3,$01 Restore the attribute of the trapdoor from the stack.
  $91E4,$03 Write it to the attribute of the trapdoor.
  $91E7,$03 Call #R$91FE to handle a room item that does nothing.
  $91EA,$03 Jump to #R$A46E to make the sound of a door.

c $91ED Handle Big Door Exit
@ $91ED label=HandlerDoorBigExit
D $91ED The handler for the doors that are bigger than normal (sprite ID #N$03),
. which the player goes through from a greater distance than #R$91F2.
R $91ED IX The door entity
  $91ED,$03 #REGbc=#N($2020,$04,$04) (the range of the door).
  $91F0,$02 Jump to #R$91F5 to check whether the player is in range of the door.

c $91F2 Handle Door Exit
@ $91F2 label=HandlerDoorExit
D $91F2 The handler for the doors that are always open (sprite IDs #N$01 and
. #N$02 in #R$802A). It uses #R$90CC to check whether
. the player is in range of the door, and then #R$9117 takes them through it.
. Whether or not they do, the door is then shown by #R$91FE.
R $91F2 IX The door entity
  $91F2,$03 #REGbc=#N($1111,$04,$04) (the range of the door).
@ $91F5 label=HandlerDoorExit_Check
  $91F5,$03 Call #R$90CC to see whether the player is in range of the door.
  $91F8,$03 Call #R$9117 if the player is in range.
  $91FB,$03 Jump to #R$91FE to handle a room item that does nothing.

c $91FE Handle Room Item
@ $91FE label=HandlerRoomItem
D $91FE The handler for the items in a room that do nothing. The attributes of
. the cells that it covers are set by #R$9980 every time, but the graphic is
. only drawn (by #R$9213) when #R$5E14 is zero.
E $91FE Continue on to #R$9213.
R $91FE IX The item entity
  $91FE,$03 Fetch the X position of the item.
  $9201,$03 Fetch the Y position of the item.
  $9204,$01 Move up one pixel.
  $9205,$03 Fetch the graphic of the item.
  $9208,$03 Fetch the attribute of the item.
  $920B,$03 Call #R$9980 to set the attributes.
  $920E,$03 Fetch the game flags from #R$5E14.
  $9211,$01 Test whether any of the game flags are set.
  $9212,$01 Return if they are.

c $9213 Draw Item Graphic
@ $9213 label=DrawItemGraphic
D $9213 Draws the graphic of an entity at its position, using #R$9962.
R $9213 IX The entity
  $9213,$03 Fetch the X position of the entity.
  $9216,$03 Fetch the Y position of the entity.
  $9219,$03 Fetch the graphic of the entity.
  $921C,$03 Fetch the attribute of the entity.
  $921F,$03 Jump to #R$9962 to draw the graphic.

c $9222 Check Door Key
@ $9222 label=CheckDoorKey
D $9222 Checks whether the player has the key for a locked door. The colour of
. the key that is needed is found in #R$925C using bits 0-1 of the sprite ID of
. the door. If the player has it, then the doorway is opened by #R$954D and
. the player is checked for being in range of the door by #R$90CC. If the
. player does not have the key then the doorway is closed by #R$9565.
R $9222 IX The locked door entity
R $9222 O:F The carry flag is set if the player has the key and is in range
  $9222,$03 Fetch the sprite ID of the door.
  $9225,$02,b$01 Keep only bits 0-1.
  $9227,$03 Point #REGhl at the door key colours at #R$925C.
  $922A,$03 Call #R$926C to find the key that is needed in the table.
  $922D,$01 Fetch the attribute of the key that is needed.
  $922E,$02 #REGe=#N$81 (the sprite ID of the key).
  $9230,$03 Call #R$9273 to look for the key in the inventory.
  $9233,$03 Jump to #R$923F if the player does not have it.
  $9236,$03 Call #R$954D to open the doorway.
  $9239,$03 #REGbc=#N($1111,$04,$04) (the range of the door).
  $923C,$03 Jump to #R$90CC to check whether the player is in range of the door.
@ $923F label=CheckDoorKey_NoKey
  $923F,$03 Call #R$9565 to close the doorway.
  $9242,$01 Clear the carry flag.
  $9243,$01 Return.

c $9244 Handle Door Locked
@ $9244 label=HandlerDoorLocked
D $9244 The handler for the locked doors (sprite IDs #N$08 to #N$0B). When the
. player has the key and is in range of the door, both halves of the door
. become exits (sprite ID #N$02, see #R$91F2) and the player goes through
. it with #R$9117. The door is otherwise shown by #R$91FE.
R $9244 IX The door entity
  $9244,$03 Call #R$9222 to see whether the player has the key.
  $9247,$03 Jump to #R$91FE if not.
  $924A,$02 #REGa=#N$02 (the sprite ID of an unlocked door).
@ $924C label=HandlerDoorLocked_Unlock
  $924C,$03 Call #R$9260 to unlock both halves of the door.
  $924F,$03 Jump to #R$9117 to enter the door.

c $9252 Handle Cave Door Locked
@ $9252 label=HandlerCaveDoorLocked
D $9252 The handler for the locked cave doors (sprite IDs #N$0C to #N$0F). This
. is the same as #R$9244, but the doors become sprite ID #N$01.
R $9252 IX The door entity
  $9252,$03 Call #R$9222 to see whether the player has the key.
  $9255,$03 Jump to #R$91FE if not.
  $9258,$02 #REGa=#N$01 (the sprite ID of an unlocked cave door).
  $925A,$02 Jump to #R$924C to unlock the door.

b $925C Door Key Colours
@ $925C label=DoorKeyColours
D $925C The attribute of the key that is needed for each of the four colours of
. locked door. See #R$9222.
. #TABLE(default,centre,left)
. { =h Door | =h Key }
. { #N$00 | #COLOUR$42 }
. { #N$01 | #COLOUR$44 }
. { #N$02 | #COLOUR$45 }
. { #N$03 | #COLOUR$46 }
. TABLE#
B $925C,$04,$01

c $9260 Set Door Sprites
@ $9260 label=SetDoorSprites
D $9260 Writes a sprite ID to both halves of a door.
R $9260 A The sprite ID
R $9260 IX The door entity
  $9260,$03 Copy #REGix into #REGhl, as the address of this half of the door.
  $9263,$01 Update the sprite ID of this half of the door.
  $9264,$01 Hold the sprite ID in #REGaf'.
  $9265,$01 Fetch the low byte of the address of this half.
  $9266,$02,b$01 Flip bit 3, to get the address of the other half of the door.
  $9268,$01 Keep the address of the other half of the door in #REGl.
  $9269,$01 Fetch the sprite ID from #REGaf'.
  $926A,$01 Update the sprite ID of the other half of the door.
  $926B,$01 Return.

c $926C Add A To HL
@ $926C label=AddAToHL
D $926C Adds the byte in #REGa to #REGhl.
E $926C View the equivalent code in;
. #LIST
. { #CYBERUN$9BCF }
. { #NIGHTSHADE$E596 }
. { #PENTAGRAM$B519 }
. LIST#
R $926C A The value to add
R $926C HL The address
R $926C O:HL The address plus #REGa
  $926C,$01 Add the low byte of the address to the value.
  $926D,$01 Keep the new low byte in #REGl.
  $926E,$01 Fetch the high byte of the address.
  $926F,$02 Add the carry.
  $9271,$01 Keep the new high byte in #REGh.
  $9272,$01 Return.

c $9273 Find Inventory Item
@ $9273 label=FindInventoryItem
D $9273 Looks for an item in the three slots of the inventory (see #R$5E30). The
. sprite ID and the attribute of the item are at offsets #N$02 and #N$03 of
. each slot.
R $9273 D The attribute of the item
R $9273 E The sprite ID of the item
R $9273 O:F The Z flag is set if the player has the item
  $9273,$02 #REGb=#N$03 (the number of slots in the inventory).
  $9275,$03 Point #REGhl at the sprite ID of the first slot at #R$5E32.
@ $9278 label=FindInventoryItem_Loop
  $9278,$01 Fetch the sprite ID of the slot.
  $9279,$01 Is it the sprite ID of the item?
  $927A,$01 Move #REGhl on to the attribute of the slot.
  $927B,$02 Jump to #R$9280 if they are different.
  $927D,$01 Fetch the attribute of the slot.
  $927E,$02 Return if the attribute matches too, as the player has the item.
@ $9280 label=FindInventoryItem_Next
  $9280,$03 Move #REGhl on to the next slot.
  $9283,$02 Decrease the slot counter by one and loop back to #R$9278 until all
. three slots have been checked.
  $9285,$01 Return.

c $9286 Get Other Door Half
@ $9286 label=GetOtherDoorHalf
D $9286 A door is held as two 8-byte entities, one for each of the two rooms
. that it joins, and these are #N$08 bytes apart with one of them on an
. address that has bit 3 reset. This flips bit 3 of #REGix to get the other.
R $9286 IX One half of the door
R $9286 O:IX The other half of the door
  $9286,$03 Copy #REGix into #REGhl.
  $9289,$01 Fetch the low byte of the address of this half.
  $928A,$02,b$01 Flip bit 3.
  $928C,$01 Keep the address of the other half of the door in #REGl.
  $928D,$03 Copy #REGhl into #REGix, as the other half of the door.
  $9290,$01 Return.

c $9291 Draw Room Entities
@ $9291 label=DrawRoomEntities
D $9291 Draws every entity that is in the same room as the player and is in use.
. First the 8-byte entities from #R$EA90 up to #R$EE60 are done, and then
. the 16-byte ones up to #R$EEE0.
  $9291,$04 Point #REGix at the player at #R$EA90.
@ $9295 label=DrawRoomEntities_Loop
  $9295,$03 Fetch the sprite ID of the entity.
  $9298,$03 Jump to #R$92A6 if the entity is not in use.
  $929B,$03 Fetch the room of the player from #R$EA91.
  $929E,$05 Jump to #R$92A6 if the entity is in a different room.
  $92A3,$03 Call #R$9F4A to draw the entity.
@ $92A6 label=DrawRoomEntities_Next
  $92A6,$03 #REGde=#N($0008,$04,$04) (the size of an 8-byte entity).
  $92A9,$02 Move #REGix on to the next entity.
  $92AB,$03 Copy #REGix into #REGhl.
  $92AE,$03 Point #REGde at the end of the 8-byte entities at #R$EE60.
  $92B1,$03 Subtract #REGde from #REGhl, to check whether all of the 8-byte
. entities have been done.
  $92B4,$02 Loop back to #R$9295 until all of the 8-byte entities have been
. drawn.
@ $92B6 label=DrawRoomEntities_Large
  $92B6,$03 Fetch the sprite ID of the entity.
  $92B9,$03 Jump to #R$92C7 if the entity is not in use.
  $92BC,$03 Fetch the room of the player from #R$EA91.
  $92BF,$05 Jump to #R$92C7 if the entity is in a different room.
  $92C4,$03 Call #R$9F4A to draw the entity.
@ $92C7 label=DrawRoomEntities_NextLarge
  $92C7,$03 #REGde=#N($0010,$04,$04) (the size of a 16-byte entity).
  $92CA,$02 Move #REGix on to the next entity.
  $92CC,$03 Copy #REGix into #REGhl.
  $92CF,$03 Point #REGde at the end of the 16-byte entities at #R$EEE0.
  $92D2,$03 Subtract #REGde from #REGhl, to check whether all of the 16-byte
. entities have been done.
  $92D5,$02 Loop back to #R$92B6 until all of the 16-byte entities have been
. drawn.
  $92D7,$01 Return.

c $92D8 Clear Pickup Flag
@ $92D8 label=ClearPickupFlag
D $92D8 Resets bit 1 of #R$5E1F, which is set while an item is being picked up,
. and then sets the colour of the item with #R$92E0.
R $92D8 IX The item entity
  $92D8,$03 Fetch the pickup flags from #R$5E1F.
  $92DB,$02,b$01 Reset bit 1.
  $92DD,$03 Update the pickup flags in #R$5E1F.

c $92E0 Set Item Attributes
@ $92E0 label=SetItemAttributes
D $92E0 Sets the attributes of the cells that an item covers with #R$A01A. The
. item is #N$10 lines high (at #R$92E0), or the number of lines in #REGa (at
. #R$92E2), and it is two bytes wide or three if it is not on a multiple of
. eight pixels across.
R $92E2 A The number of lines
R $92E0 IX The item entity
  $92E0,$02 #REGa=#N$10 (the height of the item in lines).
@ $92E2 label=SetItemAttributes_Lines
  $92E2,$03 Update the sprite height in #R$5E11.
  $92E5,$03 Fetch the X position of the item.
  $92E8,$02,b$01 Keep only bits 0-2.
  $92EA,$02 #REGa=#N$02 (the width of the item in bytes).
  $92EC,$02 Jump to #R$92EF if the X position is a multiple of eight.
  $92EE,$01 #REGa=#N$03 (the item is one byte wider, as it straddles another
. cell).
@ $92EF label=SetItemAttributes_Width
  $92EF,$03 Update the sprite width in #R$5E10.
  $92F2,$03 Jump to #R$A01A to set the attributes of the item.

c $92F5 Handle Pickup Item
@ $92F5 label=HandlerPickupItem
D $92F5 The handler for the items that the player can pick up (sprite IDs
. #N$80 to #N$8E). If the pick up key is not pressed then #R$92D8 clears the
. flag for it. Otherwise nothing is done if another item has just been picked
. up (bits 0-1 of #R$5E1F), or if the player is not a character, or if the
. player is not touching the item (see #R$90FB). If they are, the flags are
. set, the item that has been carried the longest is dropped (see #R$9358),
. the others move along (see #R$934C), the item is picked up (see #R$9326)
. and the inventory is drawn by #R$A13B.
R $92F5 IX The item entity
  $92F5,$03 Call #R$9FFB to save the position of the item.
  $92F8,$03 Fetch the pickup pressed flag from #R$5E20.
  $92FB,$03 Jump to #R$92D8 if the pick up key is not pressed.
  $92FE,$03 Fetch the pickup flags from #R$5E1F.
  $9301,$02,b$01 Keep only bits 0-1.
  $9303,$02 Jump to #R$92E0 if an item has just been picked up.
  $9305,$03 Fetch the sprite ID of the player from #R$EA90.
  $9308,$01 Subtract one to get the ID that starts at zero.
  $9309,$04 Jump to #R$92E0 if the player is not a character.
  $930D,$03 Call #R$90FB to see whether the player is touching the item.
  $9310,$02 Jump to #R$92E0 if not.
  $9312,$03 Fetch the pickup flags from #R$5E1F.
  $9315,$02,b$01 Set bits 0-1.
  $9317,$03 Update the pickup flags in #R$5E1F.
  $931A,$03 Call #R$9358 to drop the third item.
  $931D,$03 Call #R$934C to move the other items along.
  $9320,$03 Call #R$9326 to pick up the item.
  $9323,$03 Jump to #R$A13B to draw the inventory.

c $9326 Pick Up Item
@ $9326 label=PickUpItem
D $9326 Puts an item in the first slot of the inventory (see #R$5E30) and takes
. it off the screen. A slot is the address of the entity (two bytes), the
. sprite ID and the attribute.
R $9326 IX The item entity
  $9326,$03 Point #REGhl at the first inventory slot at #R$5E30.
  $9329,$03 Copy #REGix into #REGde, as the address of the item.
  $932C,$01 Write the low byte of the address of the item to the first slot.
  $932D,$01 Move on to the next byte.
  $932E,$01 Write the high byte of the address of the item to the first slot.
  $932F,$01 Move on to the next byte.
  $9330,$03 Fetch the sprite ID of the item.
  $9333,$01 Write the sprite ID of the item to the first slot.
  $9334,$01 Move on to the next byte.
  $9335,$03 Fetch the attribute of the item.
  $9338,$01 Write the attribute of the item to the first slot.
  $9339,$03 Call #R$9F56 to remove the item from the screen.
  $933C,$03 Fetch the room attribute from #R$5E1A.
  $933F,$03 Update the attribute of the item.
  $9342,$03 Call #R$A01A to set the attributes of the cells it covered.
  $9345,$04 Write #N$00 to the sprite ID of the item, as it is not in the room
. now.
  $9349,$03 Jump to #R$A3BD to make the sound of picking up.

c $934C Shift Inventory
@ $934C label=ShiftInventory
D $934C Moves the first two slots of the inventory (see #R$5E30) along to be the
. second and third slots.
  $934C,$03 Point #REGhl at the end of the second slot at #R$5E37.
  $934F,$03 Point #REGde at the end of the third slot at #R$5E3B.
  $9352,$03 #REGbc=#N($0008,$04,$04) (the size of two slots).
  $9355,$02 Copy the two slots, working backwards.
  $9357,$01 Return.

c $9358 Drop Item
@ $9358 label=DropItem
D $9358 Puts the item in the third slot of the inventory (see #R$5E38) back into
. the room at the position of the player, and makes the sound of dropping.
. Nothing is done if the slot is empty.
  $9358,$03 Point #REGhl at the third inventory slot at #R$5E38.
  $935B,$01 Fetch the low byte of the address of the entity.
  $935C,$01 Move on to the next byte.
  $935D,$01 Fetch the high byte of the address of the entity.
  $935E,$01 Move on to the next byte.
  $935F,$03 Return if the slot is empty (the address of the entity is zero).
  $9362,$01 Stash the address of the entity on the stack.
  $9363,$01 Fetch the sprite ID in the slot.
  $9364,$01 Move on to the next byte.
  $9365,$01 Update the sprite ID of the entity.
  $9366,$01 Move on to the room of the entity.
  $9367,$03 Fetch the room of the player from #R$EA91.
  $936A,$01 Update the room of the entity.
  $936B,$01 Move on to offset #N$02 of the entity.
  $936C,$03 Write #N$80 to offset #N$02 of the entity.
  $936F,$01 Move on to the X position of the entity.
  $9370,$03 Fetch the X position of the player from #R$EA93.
  $9373,$01 Update the X position of the entity.
  $9374,$01 Move on to the Y position of the entity.
  $9375,$03 Fetch the Y position of the player from #R$EA94.
  $9378,$01 Update the Y position of the entity.
  $9379,$01 Move on to the attribute of the entity.
  $937A,$01 Fetch the attribute in the slot.
  $937B,$01 Update the attribute of the entity.
  $937C,$01 Restore the address of the entity from the stack.
  $937D,$03 Call #R$A3C2 to make the sound of dropping.
  $9380,$02 Stash #REGix on the stack.
  $9382,$03 Copy #REGde into #REGix, as the entity to draw.
  $9385,$03 Call #R$9F4A to draw the entity.
  $9388,$02 Restore #REGix from the stack.
  $938A,$01 Return.

c $938B Read Pickup Key
@ $938B label=ReadPickupKey
D $938B Reads the key to pick up an item, which is CAPS SHIFT or SPACE, and
. Z or SYMBOL SHIFT. The result is stored in #R$5E20.
  $938B,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | CAPS SHIFT / SPACE | Z / SYMBOL SHIFT | X / M | C / N | V / B }
. TABLE#
  $9391,$01 Flip the bits, so that a set bit is a key which is pressed.
  $9392,$02,b$01 Keep only bit 1.
  $9394,$03 Update the pickup pressed flag in #R$5E20.
  $9397,$01 Return.

c $9398 Read Cursor Keys
@ $9398 label=ReadCursorKeys
D $9398 Reads the cursor keys in the same way as the controls from #R$93BE are
. returned. Bit 0 is right (8), bit 1 is left (5), bit 2 is down (6), bit 3
. is up (7) and bit 4 is fire (0). A bit is reset when the key is pressed.
R $9398 O:A The state of the keys
  $9398,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $939E,$01 Keep the keys in #REGc.
  $939F,$02,b$01 Keep only bit 3 (up).
  $93A1,$01 Keep up in #REGe.
  $93A2,$01 Fetch the keys.
  $93A3,$02 Rotate #REGa right twice.
  $93A5,$02,b$01 Keep only bits 0, 2 and 6 (right, down and fire).
  $93A7,$01 Combine right, down and fire with up.
  $93A8,$01 Keep the keys so far in #REGe.
  $93A9,$02 Rotate #REGa right twice, which moves fire to bit 4.
  $93AB,$02,b$01 Keep only bit 4.
  $93AD,$01 Combine fire with the keys so far.
  $93AE,$02,b$01 Keep only bits 0-4.
  $93B0,$01 Keep the keys so far in #REGe.
  $93B1,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $93B7,$03 Rotate #REGa right three times, which moves left (5) to bit 1.
  $93BA,$02,b$01 Keep only bit 1.
  $93BC,$01 Combine left with the keys so far.
  $93BD,$01 Return.

c $93BE Read Controls
@ $93BE label=ReadControls
D $93BE Reads the controls that were chosen in #R$5E00. A bit is reset when the
. control is used: bit 0 is right, bit 1 is left, bit 2 is down, bit 3 is up and
. bit 4 is fire. The keyboard uses W, Q, E, R and T, the cursor keys are read by
. #R$9398 and otherwise the Kempston joystick is read.
E $93BE View the equivalent code in;
. #LIST
. { #COOKIE$6FB4 }
. { #UNDERWURLDE$AE17 }
. LIST#
R $93BE O:A The state of the controls
  $93BE,$03 Fetch the controls that were chosen from #R$5E00.
  $93C1,$02,b$01 Keep only bits 1-2.
  $93C3,$02 Jump to #R$93CD if the keyboard is used.
  $93C5,$04 Jump to #R$9398 if the cursor keys are used.
  $93C9,$02 Read the Kempston joystick.
  $93CB,$01 Flip the bits, so that a reset bit is a control which is used.
  $93CC,$01 Return.
@ $93CD label=ReadControls_Keyboard
  $93CD,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FB | Q | W | E | R | T }
. TABLE#
  $93D3,$01 Keep the keys in #REGc.
  $93D4,$01 Rotate #REGa right, to move W (right) to bit 0.
  $93D5,$02,b$01 Keep only bit 0.
  $93D7,$01 Keep right in #REGe.
  $93D8,$01 Fetch the keys.
  $93D9,$01 Rotate #REGa left, to move Q (left) to bit 1.
  $93DA,$02,b$01 Keep only bit 1.
  $93DC,$01 Combine left with right.
  $93DD,$01 Keep right and left in #REGe.
  $93DE,$01 Fetch the keys.
  $93DF,$02,b$01 Keep only bits 2-4 (E is down, R is up and T is fire).
  $93E1,$01 Combine down, up and fire with right and left.
  $93E2,$01 Return.

c $93E3 Handle Blank
@ $93E3 label=HandlerBlank
D $93E3 The handler for the entity with sprite ID #N$31, which is always
. there. While the player is a character it drops the inventory when the pick up
. key is pressed. The item in the third slot is dropped (see #R$9358), the
. other slots are moved along (see #R$934C) and the first slot is emptied.
. Bit 1 of #R$5E1F is set while the key is held down.
R $93E3 IX The entity
N $93E3 Return unless the player is a character.
  $93E3,$03 Fetch the sprite ID of the player from #R$EA90.
  $93E6,$01 Subtract one to get the ID that starts at zero.
  $93E7,$03 Return if the player is not a character.
N $93EA Test the pick up key.
  $93EA,$03 Fetch the pickup pressed flag from #R$5E20.
  $93ED,$03 Jump to #R$9417 if the pick up key is not pressed.
N $93F0 Skip the drop if this press has already picked up or dropped an
. item.
  $93F0,$03 Fetch the pickup flags from #R$5E1F.
  $93F3,$02,b$01 Keep only bits 0-1.
  $93F5,$02 Jump to #R$940E if this press has already been used.
N $93F7 Mark the key as used and drop the oldest item.
  $93F7,$02,b$01 Set bit 1.
  $93F9,$03 Update the pickup flags in #R$5E1F.
  $93FC,$03 Call #R$9358 to drop the third item.
  $93FF,$03 Call #R$934C to move the other items along.
N $9402 Empty the first slot and redraw the inventory.
  $9402,$09 Write #N($0000,$04,$04) to the first inventory slot, as the
. address of no entity and as the sprite ID and attribute.
  $940B,$03 Call #R$A13B to draw the inventory.
N $940E Clear the bit that is set when an item is picked up.
@ $940E label=HandlerBlank_Finish
  $940E,$03 Fetch the pickup flags from #R$5E1F.
  $9411,$02,b$01 Reset bit 0.
  $9413,$03 Update the pickup flags in #R$5E1F.
  $9416,$01 Return.
N $9417 The pick up key is up, so allow another drop on the next press.
@ $9417 label=HandlerBlank_KeyUp
  $9417,$03 Fetch the pickup flags from #R$5E1F.
  $941A,$02,b$01 Reset bit 1.
  $941C,$03 Update the pickup flags in #R$5E1F.
  $941F,$02 Jump to #R$940E to finish handling the blank item.

c $9421 Handle Barrel
@ $9421 label=HandlerBarrel
D $9421 The handler for the barrel stack, which is a secret door that only the
. serf can use. The doorway is opened by #R$954D when the player is the serf
. (sprite IDs #N$21 to #N$30), and then the door is used (see #R$91F2).
. For anyone else the doorway is closed by #R$9565 and the door is just shown
. (see #R$91FE).
R $9421 IX The door entity
  $9421,$03 Fetch the sprite ID of the player from #R$EA90.
  $9424,$02 Subtract #N$21, to make the serf's sprite IDs start at zero.
  $9426,$02 Jump to #R$9433 to check for the secret door.

c $9428 Handle Bookcase
@ $9428 label=HandlerBookcase
D $9428 The handler for the bookcase, which is a secret door that only the
. wizard can use. This is the same as #R$9421 but for the sprite IDs #N$11 to
. #N$20.
R $9428 IX The door entity
  $9428,$03 Fetch the sprite ID of the player from #R$EA90.
  $942B,$02 Subtract #N$11, to make the wizard's sprite IDs start at zero.
  $942D,$02 Jump to #R$9433 to check for the secret door.

c $942F Handle Clock
@ $942F label=HandlerClock
D $942F The handler for the clock, which is a secret door that only the knight
. can use. This is the same as #R$9421 but for the sprite IDs #N$01 to #N$10.
R $942F IX The door entity
  $942F,$03 Fetch the sprite ID of the player from #R$EA90.
  $9432,$01 Subtract one, to make the knight's sprite IDs start at zero.
@ $9433 label=HandlerSecretDoor_Check
  $9433,$04 Jump to #R$943D if the player is not the right character.
  $9437,$03 Call #R$954D to open the doorway.
  $943A,$03 Jump to #R$91F2 to handle the exit of the door.
@ $943D label=HandlerSecretDoor_Closed
  $943D,$03 Call #R$9565 to close the doorway.
  $9440,$03 Jump to #R$91FE to handle a room item that does nothing.

c $9443 Prepare Player
@ $9443 label=PreparePlayer
D $9443 Sets up the player entity at #R$EA90 for the start of a life. The
. template at #R$9481 is given the room that the player is in and the sprite ID
. of the character that was chosen in #R$5E00, and is then copied over the
. player. Then the timer for the player appearing is set, the player is
. drawn (unless the number of lives is #N$03), the energy is refilled, and the
. chicken and the lives are drawn.
N $9443 Work out the sprite ID to use.
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Byte | =h Character | =h * #N$02 | =h Only Bits 4-5 | =h + #N$08 }
. #LET(char=$00) #LET(id=#EVAL((({char} * $02) & $30) + $08)) { #N({char}) | Knight (+ Keyboard) | #N(#EVAL({char} * $02)) | #N(#EVAL(({char} * $02) & $30)) | Sprite ID: #R($A4BC + {id} * $02)(#N({id})) }
. #LET(char=$08) #LET(id=#EVAL((({char} * $02) & $30) + $08)) { #N({char}) | Wizard (+ Kempston Joystick) | #N(#EVAL({char} * $02)) | #N(#EVAL(({char} * $02) & $30)) | Sprite ID: #R($A4BC + {id} * $02)(#N({id})) }
. #LET(char=$14) #LET(id=#EVAL((({char} * $02) & $30) + $08)) { #N({char}) | Serf (+ Cursor Joystick) | #N(#EVAL({char} * $02)) | #N(#EVAL(({char} * $02) & $30)) | Sprite ID: #R($A4BC + {id} * $02)(#N({id})) }
. TABLE#
  $9443,$04 #REGa=#R$5E00 * #N$02.
M $9447,$04 Keep only bits 4-5 (the base character address) + #N$08 frames
. (for the character direction).
  $9447,$02,b$01
  $9449,$02
  $944B,$03 Write #REGa to #R$9481(#N$9488).
N $944E Update the current room.
  $944E,$06 Write #R$EA91 to #R$9481(#N$9482).
N $9454 Copy the template over the player.
  $9454,$0B Copy #N$08 bytes of data from #R$9481 to #R$EA90.
  $945F,$05 Write #N$68 to #R$5E3C, the timer for the player appearing.
  $9464,$03 Fetch the number of lives from #R$5E21.
  $9467,$04 Jump to #R$9476 if the number of lives is #N$03.
  $946B,$02 Stash #REGix on the stack.
  $946D,$04 Point #REGix at the player at #R$EA90.
  $9471,$03 Call #R$9F4A to draw the player.
  $9474,$02 Restore #REGix from the stack.
N $9476 Set starting energy.
@ $9476 label=PreparePlayer_Energy
  $9476,$05 Write #N$F0 to #R$5E28.
  $947B,$03 Call #R$8B8A to draw the chicken.
  $947E,$03 Jump to #R$A2CE to draw the lives.

b $9481 Player Template
@ $9481 label=PlayerTemplate
D $9481 The entity that #R$9443 copies to #R$EA90 for a new life. The room and
. the sprite ID at the end are filled in before it is copied.
B $9481,$01 Sprite ID: #N$66 (the player appearing, see #R$8CB7).
B $9482,$01 The room (written by #R$9443).
B $9483,$01 Offset #N$02.
B $9484,$01 The X position.
B $9485,$01 The Y position.
B $9486,$01 The attribute.
B $9487,$01 The number of rows drawn so far (see #R$8CB7).
B $9488,$01 The sprite ID of the character (written by #R$9443).

c $9489 Pause Game
@ $9489 label=PauseGame
D $9489 Called by the main loop to check for the game being paused. The game is
. paused when only the key for CAPS SHIFT or SPACE is pressed. It then waits
. until the key has been released, pressed again and released again, before
. returning.
  $9489,$01 Disable interrupts.
  $948A,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | CAPS SHIFT / SPACE | Z / SYMBOL SHIFT | X / M | C / N | V / B }
. TABLE#
  $9490,$03 Return if the key for bit 0 is not pressed.
  $9493,$01 Flip the bits, so that a set bit is a key which is pressed.
  $9494,$02,b$01 Keep only bits 1-4.
  $9496,$01 Return if any of the other keys are pressed.
N $9497 Wait for the key to be released.
@ $9497 label=PauseGame_Release
  $9497,$06 Read from the keyboard.
  $949D,$04 Loop back to #R$9497 until the key is released.
N $94A1 Wait for the key to be pressed again.
@ $94A1 label=PauseGame_Wait
  $94A1,$06 Read from the keyboard.
  $94A7,$04 Loop back to #R$94A1 until the key is pressed.
N $94AB Wait for the key to be released again.
@ $94AB label=PauseGame_Resume
  $94AB,$06 Read from the keyboard.
  $94B1,$04 Loop back to #R$94AB until the key is released.
  $94B5,$01 Return.

c $94B6 Place Key Pieces
@ $94B6 label=PlaceKeyPieces
D $94B6 Chooses which of the eight sets of rooms in #R$94DD will hold the three
. entities for the A.C.G. key at #R$6025, using FRAMES and #R$5E12, and writes
. the three rooms to them.
  $94B6,$04 Fetch FRAMES and keep FRAMES in #REGc.
  $94BA,$03 Fetch the counter from #R$5E12.
  $94BD,$01 Add FRAMES to the counter.
  $94BE,$02,b$01 Keep only bits 0-2.
  $94C0,$01 Keep the number of the set in #REGc.
  $94C1,$02 Multiply the number of the set by #N$03.
  $94C3,$01 Keep the offset of the set in #REGl.
  $94C4,$02 Clear the high byte of the offset.
  $94C6,$03 Point #REGbc at the key piece rooms at #R$94DD.
  $94C9,$01 Add the offset to the table, to find the chosen set.
  $94CA,$01 Keep the set of rooms in #REGde.
  $94CB,$03 Point #REGhl at the room of the first entity at #R$6026.
  $94CE,$03 #REGbc=#N($0008,$04,$04) (the distance between the entities).
  $94D1,$02 #REGa=#N$03 (the number of key pieces to place).
@ $94D3 label=PlaceKeyPieces_Loop
  $94D3,$01 Save the key piece counter in #REGaf'.
  $94D4,$01 Fetch the next room.
  $94D5,$01 Write it to the entity.
  $94D6,$01 Move #REGhl on to the next entity.
  $94D7,$01 Move #REGde on to the next room.
  $94D8,$01 Restore the key piece counter from #REGaf'.
  $94D9,$03 Decrease the key piece counter by one and loop back to #R$94D3 until
. all three have been placed.
  $94DC,$01 Return.

b $94DD Key Piece Rooms
@ $94DD label=KeyPieceRooms
D $94DD The eight sets of rooms for the three entities at #R$6025, used by
. #R$94B6.
. #TABLE(default,centre,centre,centre,centre)
. { =h Set | =h Room 1 | =h Room 2 | =h Room 3 }
. { #N$00 | #N$81 | #N$45 | #N$7C }
. { #N$01 | #N$85 | #N$49 | #N$2B }
. { #N$02 | #N$6A | #N$3B | #N$7C }
. { #N$03 | #N$69 | #N$71 | #N$2B }
. { #N$04 | #N$67 | #N$85 | #N$7C }
. { #N$05 | #N$68 | #N$7F | #N$2B }
. { #N$06 | #N$4D | #N$73 | #N$7C }
. { #N$07 | #N$17 | #N$10 | #N$2B }
. TABLE#
B $94DD,$18,$03

c $94F5 Randomise Doors
@ $94F5 label=RandomiseDoors
D $94F5 Called when a game starts. For each of the doors from #R$EEE0 onwards,
. a byte from the ROM (from an address that depends on FRAMES and #R$5E12) is
. used as a random number. If it is less than #N$70, and the sprite ID of both
. halves of the door is #N$01 then they are both changed to #N$22, or if it is
. #N$02 then to #N$20. Both of those are doors that open and close (see
. #R$915F and #R$917D). The doorway is then closed by setting bit 3 of the
. attribute of both halves (see #R$9565).
  $94F5,$04 Fetch the counter from #R$5E12 and keep the low byte of the ROM
. address in #REGl.
  $94F9,$03 Fetch FRAMES.
  $94FC,$02,b$01 Keep only bits 0-3.
  $94FE,$02,b$01 Set bit 4.
  $9500,$01 Keep the high byte of the ROM address in #REGh.
  $9501,$01 Switch to the shadow registers.
  $9502,$03 #REGhl'=#N$EEE0 (the first half of the first door).
  $9505,$03 Point #REGde' at the second half of the first door at #R$EEE8.
  $9508,$03 #REGbc'=#N($0010,$04,$04) (the distance between the doors).
@ $950B label=RandomiseDoors_Loop
  $950B,$01 Switch to the main registers.
  $950C,$01 Fetch the next random byte from the ROM.
  $950D,$01 Move #REGhl on to the next byte.
  $950E,$01 Switch to the shadow registers.
  $950F,$04 Jump to #R$951F if the byte is #N$70 or more.
  $9513,$01 Fetch the sprite ID of the second half of the door.
  $9514,$03 Jump to #R$951F if it is different to the first half.
  $9517,$04 Jump to #R$9526 if it is #N$01.
  $951B,$04 Jump to #R$9542 if it is #N$02.
@ $951F label=RandomiseDoors_Next
  $951F,$01 Move #REGhl on to the next door.
  $9520,$01 Switch #REGde and #REGhl.
  $9521,$01 Move #REGhl on to the next door.
  $9522,$01 Return if there are no more doors.
  $9523,$01 Switch #REGde and #REGhl back again.
  $9524,$02 Jump back to #R$950B to carry on with the loop through the doors.
@ $9526 label=RandomiseDoors_Close
  $9526,$02 #REGa=#N$22 (the new sprite ID of the closed door).
@ $9528 label=RandomiseDoors_Change
  $9528,$01 Update the sprite ID of the second half.
  $9529,$01 Update the sprite ID of the first half.
  $952A,$01 Stash #REGde on the stack.
  $952B,$05 Move #REGde on to the attribute of the second half.
  $9530,$01 Fetch the attribute.
  $9531,$02,b$01 Set bit 3, to close the doorway.
  $9533,$01 Write it back.
  $9534,$01 Restore #REGde from the stack.
  $9535,$01 Stash #REGhl on the stack.
  $9536,$05 Move #REGhl on to the attribute of the first half.
  $953B,$01 Fetch the attribute.
  $953C,$02,b$01 Set bit 3, to close the doorway.
  $953E,$01 Write it back.
  $953F,$01 Restore #REGhl from the stack.
  $9540,$02 Jump back to #R$951F to move on to the next door.
@ $9542 label=RandomiseDoors_Close_Alternate
  $9542,$02 #REGa=#N$20 (the new sprite ID of the closed door).
  $9544,$02 Jump to #R$9528 to change the door.

c $9546 Update Doorway
@ $9546 label=UpdateDoorway
D $9546 Opens the doorway of a door if bit 0 of its sprite ID is set (which is
. so for the doors that are open), and closes it if it is not. The other entry
. points open and close the doorway of a door whatever the sprite ID. The
. doorway is open when bit 3 of the attribute is reset for both halves of the
. door, because #R$900A skips the doors that have it set.
R $9546 IX One half of the door
  $9546,$03 Fetch the sprite ID of the door.
  $9549,$02,b$01 Keep only bit 0.
  $954B,$02 Jump to #R$9565 if it is reset.

c $954D Open Doorway
@ $954D label=OpenDoorway
D $954D Resets bit 3 of the attribute of both halves of a door.
R $954D IX One half of the door
  $954D,$03 Fetch the attribute of the door.
  $9550,$02,b$01 Reset bit 3.
  $9552,$03 Write it back.
  $9555,$02 Stash #REGix on the stack.
  $9557,$03 Call #R$9286 to point #REGix at the other half of the door.
  $955A,$03 Fetch the attribute of the other half.
  $955D,$02,b$01 Reset bit 3.
  $955F,$03 Write it back.
  $9562,$02 Restore #REGix from the stack.
  $9564,$01 Return.

c $9565 Close Doorway
@ $9565 label=CloseDoorway
D $9565 Sets bit 3 of the attribute of both halves of a door.
R $9565 IX One half of the door
  $9565,$03 Fetch the attribute of the door.
  $9568,$02,b$01 Set bit 3.
  $956A,$03 Write it back.
  $956D,$02 Stash #REGix on the stack.
  $956F,$03 Call #R$9286 to point #REGix at the other half of the door.
  $9572,$03 Fetch the attribute of the other half.
  $9575,$02,b$01 Set bit 3.
  $9577,$03 Write it back.
  $957A,$02 Restore #REGix from the stack.
  $957C,$01 Return.

c $957D Check Doorway
@ $957D label=CheckDoorway
D $957D Counts how many of the two axes an entity is beyond the edge of the
. floor of the room. The floor is centred on #N$58 across and #N$68 down, and on
. each axis it extends one more than the width in #R$5E1D or the height in
. #R$5E1E from the centre. The count is written to #R$5E2D, which is zero when
. the entity is not in a doorway.
R $957D IX The entity
  $957D,$01 Stash #REGde on the stack.
  $957E,$02 #REGb=#N$00 (the count).
  $9580,$03 #REGhl=*#R$5E1D (the width in #REGl and the height in #REGh).
  $9583,$01 Increment the width.
  $9584,$01 Increment the height.
  $9585,$03 Fetch the X position of the entity.
  $9588,$03 Fetch the Y position of the entity.
  $958B,$01 Fetch the X position.
  $958C,$02 Subtract #N$58, to get the distance from the centre of the floor.
  $958E,$03 Jump to #R$9593 if the result is positive.
  $9591,$02 Negate it, to make the distance positive.
@ $9593 label=CheckDoorway_X
  $9593,$03 Jump to #R$9597 if the entity is within the width of the floor.
  $9596,$01 Increment the count of axes that it is beyond.
@ $9597 label=CheckDoorway_Y
  $9597,$01 Fetch the Y position.
  $9598,$02 Subtract #N$68, to get the distance from the centre of the floor.
  $959A,$03 Jump to #R$959F if the result is positive.
  $959D,$02 Negate it, to make the distance positive.
@ $959F label=CheckDoorway_Compare
  $959F,$03 Jump to #R$95A3 if the entity is within the height of the floor.
  $95A2,$01 Increment the count of axes that it is beyond.
@ $95A3 label=CheckDoorway_Finish
  $95A3,$01 Fetch the count.
  $95A4,$03 Update the doorway flag in #R$5E2D.
  $95A7,$01 Restore #REGde from the stack.
  $95A8,$01 Return.

c $95A9 Make Tombstone
@ $95A9 label=MakeTombstone
D $95A9 Makes a tombstone (sprite ID #N$8F) where the player is. The four
. entities from #R$EAE8 are searched for one that is not in use. If there is
. one, it is made a copy of the player, apart from the sprite ID, and with the
. attribute of the player set to #N$45 first. Then it is drawn.
  $95A9,$03 #REGhl=#R$EAE8 (the first of the four entities to search).
  $95AC,$03 #REGde=#N($0008,$04,$04) (the size of an entity).
  $95AF,$02 #REGb=#N$04 (the number of entities to look at).
@ $95B1 label=MakeTombstone_Loop
  $95B1,$01 Fetch the sprite ID of the entity.
  $95B2,$03 Jump to #R$95B9 if the entity is not in use.
  $95B5,$01 Move #REGhl on to the next entity.
  $95B6,$02 Decrease the entity counter by one and loop back to #R$95B1 until
. all four have been checked.
  $95B8,$01 Return.
@ $95B9 label=MakeTombstone_Create
  $95B9,$05 Write #N$45 to the attribute of the player.
  $95BE,$01 Stash the address of the entity on the stack.
  $95BF,$02 Write #N$8F to the sprite ID of the entity.
  $95C1,$01 Swap #REGde and #REGhl, so that #REGde points at the entity.
  $95C2,$01 Move #REGde on to the room of the entity.
  $95C3,$03 Point #REGhl at the room of the player at #R$EA91.
  $95C6,$03 #REGbc=#N($0007,$04,$04).
  $95C9,$02 Copy the seven bytes from the player to the entity.
  $95CB,$01 Restore the address of the entity from the stack.
N $95CC Draw the entity that #REGhl points to.
@ $95CC label=DrawEntityAtHL
  $95CC,$02 Stash #REGix on the stack.
  $95CE,$03 Copy #REGhl into #REGix, as the entity to draw.
  $95D1,$03 Call #R$9F4A to draw the entity.
  $95D4,$02 Restore #REGix from the stack.
  $95D6,$01 Return.

c $95D7 Handle Tombstone
@ $95D7 label=HandlerTombstone
D $95D7 The handler for the tombstone (sprite ID #N$8F), which just sets the
. attributes with #R$92E0.
R $95D7 IX The tombstone entity
  $95D7,$03 Jump to #R$92E0 to set the attributes of the item.

c $95DA Update Clock
@ $95DA label=ClockTick
D $95DA Called whenever FRAMES has changed. Once #N$32 frames have passed,
. FRAMES is reduced by that, the seconds in #R$5E3F are increased (in BCD), the
. minutes in #R$5E3E when the seconds reach #N$60, and the hours in #R$5E3D when
. the minutes reach #N$60, and then the clock is printed on the screen.
  $95DA,$03 Fetch FRAMES.
  $95DD,$03 Return if fewer than #N$32 frames have passed.
  $95E0,$02 Subtract #N$32, as a second has passed.
  $95E2,$03 Update FRAMES.
  $95E5,$03 Point #REGhl at the clock seconds at #R$5E3F.
  $95E8,$01 Fetch the seconds.
  $95E9,$01 Increment the seconds.
  $95EA,$01 Convert it to BCD.
  $95EB,$01 Write it back.
  $95EC,$04 Jump to #R$9604 if the seconds have not reached #N$60.
  $95F0,$02 Reset the seconds to #N$00.
  $95F2,$01 Move #REGhl on to the minutes.
  $95F3,$01 Fetch the minutes.
  $95F4,$01 Increment the minutes.
  $95F5,$01 Convert it to BCD.
  $95F6,$01 Write it back.
  $95F7,$04 Jump to #R$9604 if the minutes have not reached #N$60.
  $95FB,$02 Reset the minutes to #N$00.
  $95FD,$01 Move #REGhl on to the hours.
  $95FE,$01 Fetch the hours.
  $95FF,$01 Increment the hours.
  $9600,$01 Convert it to BCD.
  $9601,$02,b$01 Keep only bits 0-3.
  $9603,$01 Write it back.
N $9604 Print the clock.
@ $9604 label=ClockTick_Print
  $9604,$03 #REGhl=#N$40C8 (screen buffer location).
@ $9607 label=PrintClock
  $9607,$03 Call #R$9BA2 to get the screen address.
  $960A,$03 Point #REGde at the clock hours at #R$5E3D.
  $960D,$02 #REGb=#N$02.
  $960F,$03 Call #R$A1C9 to print the last digit of the hours and both digits of
. the minutes.
  $9612,$03 Point #REGde at the clock seconds at #R$5E3F.
  $9615,$01 Move #REGhl on to the next character position.
  $9616,$02 #REGb=#N$01.
  $9618,$03 Jump to #R$A1BF to print both digits of the seconds.

c $961B Handle A.C.G. Door
@ $961B label=HandlerDoorACGExit
D $961B The handler for the A.C.G. door (sprite ID #N$24 in #R$802A). When the
. three slots of the inventory hold the three A.C.G. key pieces (sprite IDs
. #N$8C, #N$8D and #N$8E, in that order) the doorway is opened and the door is
. used as an exit with #R$91F5, with a bigger range than other doors.
. Otherwise the doorway is closed and the door is just shown by #R$91FE.
R $961B IX The door entity
  $961B,$03 Point #REGhl at the sprite ID in the first slot of the inventory at
. #R$5E32.
  $961E,$03 #REGde=#N($0004,$04,$04) (the size of a slot).
  $9621,$01 Fetch the sprite ID in the slot.
  $9622,$04 Jump to #R$963B if it is not #N$8C.
  $9626,$01 Move #REGhl on to the second slot.
  $9627,$01 Fetch the sprite ID in the slot.
  $9628,$04 Jump to #R$963B if it is not #N$8D.
  $962C,$01 Move #REGhl on to the third slot.
  $962D,$01 Fetch the sprite ID in the slot.
  $962E,$04 Jump to #R$963B if it is not #N$8E.
  $9632,$03 Call #R$954D to open the doorway.
  $9635,$03 #REGbc=#N($3020,$04,$04) (the range of the door).
  $9638,$03 Jump to #R$91F5 to check whether the player is in range of the door.
@ $963B label=HandlerDoorACGExit_Locked
  $963B,$03 Call #R$9565 to close the doorway.
  $963E,$03 Jump to #R$91FE to handle a room item that does nothing.

c $9641 Show Game Statistics
@ $9641 label=GameStats
D $9641 Prints the time, score and percentage of rooms visited, each with
. its label, on the game over screen.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #POKES$5E01,$4C;$5E02,$BE
. #SCR$02,$07,$07,$11,$07(statistics-before)
. | #SIM(start=$9641,stop=$0000,sp=$5B60)
. #SCR$02,$07,$07,$11,$07(statistics-after) } UDGTABLE# #POPS
  $9641,$03 Call #R$96C9 to calculate the percentage of rooms visited.
N $9644 Handle printing the time.
  $9644,$03 #REGhl=#N$4040 (screen buffer location).
  $9647,$03 Point #REGde at the label for the time at #R$967F.
  $964A,$03 Call #R$A1F3 to print the string.
N $964D Handle printing the score.
  $964D,$03 #REGhl=#N$5040 (screen buffer location).
  $9650,$03 Point #REGde at the label for the score at #R$968F.
  $9653,$03 Call #R$A1F3 to print the string.
N $9656 Handle printing the percentage label.
  $9656,$03 #REGhl=#N$6040 (screen buffer location).
  $9659,$03 Point #REGde at the label for the percentage at #R$969F.
  $965C,$03 Call #R$A1F3 to print the string.
N $965F Handle printing the clock.
  $965F,$06 Write #R$BFCC(main font "0") to #R$5E01.
  $9665,$03 #REGhl=#N$4080 (screen buffer location).
  $9668,$03 Call #R$9607 to print the clock.
N $966B Handle printing the score.
  $966B,$03 #REGhl=#N$5080 (screen buffer location).
  $966E,$03 Call #R$A1B7 to print the score.
N $9671 Handle printing the percentage of rooms visited.
  $9671,$03 #REGhl=#N$6080 (screen buffer location).
  $9674,$03 Call #R$9BA2 to get the screen address.
  $9677,$03 Point #REGde at the visited percentage at #R$5E54.
  $967A,$02 #REGb=#N$01.
  $967C,$03 Jump to #R$A1BF to print the score.
@ $967F label=StringTime
N $967F The strings for the three labels. Each is in the format that #R$A1F3
. prints: an attribute, followed by the characters, with bit 7 set on the last
. character.
T $967F,$10,h$01,$0E:$01 Attribute: #COLOUR(#PEEK(#PC)) + "TIME" and a colon
. (character code #N$23 is drawn as ":" in the font).
@ $968F label=StringScore
T $968F,$10,h$01,$0E:$01 Attribute: #COLOUR(#PEEK(#PC)) + "SCORE".
@ $969F label=StringPercentage
T $969F,$10,h$01,$0E:$01 Attribute: #COLOUR(#PEEK(#PC)) + a percent sign
. (character code #N$24 is drawn as "%" in the font).

c $96AF Visit Room
@ $96AF label=VisitRoom
D $96AF Marks a room as having been visited, by setting its bit in the table of
. visited rooms at #R$5E40. The table has one bit for each room, #N$08 rooms to
. a byte.
. The bit to set is worked out from the room ID and written into the SET
. instruction at #R$96C6 (self modifying code), which then sets it.
E $96AF View the equivalent code in;
. #LIST
. { #SABREWULF$9D23 }
. LIST#
R $96AF A The room ID
N $96AF Create an offset in #REGbc.
  $96AF,$01 Keep the room ID in #REGc.
  $96B0,$06 Divide by #N$08.
  $96B6,$02 #REGb=#N$00.
  $96B8,$04 #REGhl=#R$5E40 + #REGbc.
N $96BC Work out the bit to set, which is the bottom three bits of the room ID.
  $96BC,$03 Multiply by #N$08.
  $96BF,$02,b$01 Keep only bits 3-5.
  $96C1,$02,b$01 Set bits 1-2, 6-7. This makes the second byte of the
. instruction SET n,(HL) for the bit.
  $96C3,$03 Write this value to #R$96C6(#N$96C7), which updates the bit to set.
  $96C6,$02 Set the bit to mark the room as having been visited.
  $96C8,$01 Return.

c $96C9 Calculate Rooms Visited
@ $96C9 label=CalculateRoomsVisited
D $96C9 Works out the percentage of the rooms that have been visited, from the
. bits that are set in the table at #R$5E40, and writes it to #R$5E54 as BCD.
. Every third room that has been visited adds #N$02 to the percentage, and
. then #N$01 is added at the end.
E $96C9 View the equivalent code in;
. #LIST
. { #SABREWULF$9CC6 }
. LIST#
  $96C9,$03 Point #REGhl at the table of visited rooms at #R$5E40.
  $96CC,$03 #REGb=#N$08 (the number of bits in each byte) and #REGc=#N$13 (the
. number of bytes).
  $96CF,$02 #REGd=#N$03 (the number of rooms that are left before the next
. increase).
  $96D1,$01 #REGa=#N$00 (the percentage so far).
@ $96D2 label=CalculateRoomsVisited_Byte
  $96D2,$01 Stash the counters on the stack.
  $96D3,$01 Fetch the next byte of the table.
  $96D4,$01 Move on to the next byte.
@ $96D5 label=CalculateRoomsVisited_Bit
  $96D5,$02 Rotate the next bit into the carry flag.
  $96D7,$02 Jump to #R$96E1 if the room has not been visited.
  $96D9,$03 Jump to #R$96E1 if there are more rooms before the next increase.
  $96DC,$02 #REGd=#N$03.
  $96DE,$02 Add #N$02 to the percentage.
  $96E0,$01 Convert the result to BCD.
@ $96E1 label=CalculateRoomsVisited_Next
  $96E1,$02 Decrease the bit counter by one and loop back to #R$96D5 until the
. byte is done.
  $96E3,$01 Restore the counters from the stack.
  $96E4,$03 Decrease the byte counter by one and loop back to #R$96D2 until all
. of the bytes are done.
  $96E7,$01 Add one to the percentage.
  $96E8,$03 Write the percentage to #R$5E54.
  $96EB,$01 Return.

c $96EC Game Complete
@ $96EC label=GameComplete
D $96EC Called when the player has reached room #N$8E. The player is drawn, the
. messages are printed, and the game statistics are shown by #R$9641. The game
. then carries on as if it were over.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SCR$01(game-complete-before)
. | #SIM(start=$96EC,stop=$970D,sp=$5E00)
. #SCR$01(game-complete-after) } UDGTABLE# #POPS
  $96EC,$03 Point #REGhl at the player at #R$EA90.
  $96EF,$03 Call #R$95CC to draw the entity that #REGhl points to.
  $96F2,$06 Write #N$BE4C (the main font, see #R$BF4C) to #R$5E01, which sets
. the font.
N $96F8 Handle printing "CONGRATULATIONS".
  $96F8,$03 #REGhl=#N$2040 (screen buffer location).
  $96FB,$03 Point #REGde at the game complete messages at #R$9710.
  $96FE,$03 Call #R$A1F3 to print the string.
N $9701 Handle printing "YOU HAVE ESCAPED".
  $9701,$03 #REGhl=#N$3040 (screen buffer location).
  $9704,$03 Point #REGde at the message that the player has escaped at #R$9720.
  $9707,$03 Call #R$A1F3 to print the string.
N $970A Show the game statistics.
  $970A,$03 Call #R$9641 to show the game statistics.
N $970D Disappointingly cut into the "normal" game over routine.
  $970D,$03 Jump to #R$8C4A to wait for a moment.

t $9710 Messaging: Game Complete
@ $9710 label=GameCompleteMessages
D $9710 The messages that #R$96EC prints. Each one starts with the attribute to
. colour it with and ends with a character that has bit 7 set.
  $9710,$10,h$01,$0E:$01 Attribute: #COLOUR(#PEEK(#PC)) + "CONGRATULATIONS".
@ $9720 label=GameCompleteMessage_Escaped
  $9720,$11,h$01,$0F:$01 Attribute: #COLOUR(#PEEK(#PC)) + "YOU HAVE ESCAPED".

c $9731 Fall Through Trapdoor
@ $9731 label=FallThroughTrapdoor
D $9731 Used by #R$91C5 for a trapdoor that is open. If the player is in range
. of the trapdoor (#N$18 in each direction), the screen is cleared and the
. frame of room #N$96 is drawn. Then for #N$80 frames of rings of colour (see
. #R$9774) spread out from the centre of the screen, while the centre flashes
. and clicks are made. Then the player goes through the door with #R$9117.
. If the player is not in range then the trapdoor is just shown by #R$91FE.
R $9731 IX The trapdoor entity
  $9731,$03 #REGbc=#N($1818,$04,$04) (the range of the trapdoor).
  $9734,$03 Call #R$90CC to see whether the player is in range.
  $9737,$03 Jump to #R$91FE if the player is not.
  $973A,$03 Call #R$8093 to clear the play area.
  $973D,$02 #REGa=#N$96 (the room to draw the frame of).
  $973F,$02 Stash #REGix on the stack.
  $9741,$03 Call #R$9BF1 to draw the frame of the room.
  $9744,$02 Restore #REGix from the stack.
  $9746,$02 #REGb=#N$80 (the number of frames to fall for, which also sets the
. pitch of the clicks).
@ $9748 label=FallThroughTrapdoor_Loop
  $9748,$04 Fetch FRAMES and keep FRAMES in #REGc.
N $974C Make clicks until FRAMES has changed.
@ $974C label=FallThroughTrapdoor_Wait
  $974C,$01 Stash the fall counter and FRAMES on the stack.
  $974D,$01 Fetch the fall counter.
  $974E,$01 Flip the bits of the fall counter.
  $974F,$01 Keep the pitch of the click in #REGb.
  $9750,$03 Call #R$A3A8 to make a click.
  $9753,$01 Restore the fall counter and FRAMES from the stack.
  $9754,$03 Fetch FRAMES.
  $9757,$03 Jump to #R$974C if FRAMES has not changed.
N $975A Flash the centre of the screen on every eighth frame.
  $975A,$02,b$01 Keep only bits 0-2.
  $975C,$02 #REGa=#N$00 (the attribute for black).
  $975E,$02 Jump to #R$9762 if FRAMES is not a multiple of eight.
  $9760,$02 #REGa=#N$47 (the attribute for bright white ink on black).
@ $9762 label=FallThroughTrapdoor_Flash
  $9762,$01 Keep the attribute in #REGl.
  $9763,$01 Keep the attribute in #REGh.
  $9764,$03 Write the attribute to the two cells at #N$596B.
  $9767,$03 Write the attribute to the two cells at #N$598B.
  $976A,$01 Stash the fall counter on the stack.
  $976B,$03 Call #R$9774 to spread the colours out.
  $976E,$01 Restore the fall counter from the stack.
  $976F,$02 Decrease the fall counter by one and loop back to #R$9748 until the
. fall has finished.
  $9771,$03 Jump to #R$9117 to enter the door.

c $9774 Ripple Attributes
@ $9774 label=RippleAttributes
D $9774 Moves the colours of a set of #N$0B rings of the attribute buffer
. outwards. Each ring is a square with sides of #N$17 cells, starting from the
. bottom left of the screen (#N$5AE0) and moving one cell up and one to the
. right for each ring, so that the sides are #N$02 cells shorter. All of the
. cells of a ring are given the colour of the cell diagonally inside the first
. one.
  $9774,$03 #REGbc=#N$170B (#REGb is the length of the sides and #REGc is the
. number
. of rings).
  $9777,$03 #REGhl=#N$5AE0 (the start of the first ring).
  $977A,$03 #REGde=#N($0020,$04,$04) (the size of a row).
@ $977D label=RippleAttributes_Ring
  $977D,$01 Stash #REGhl on the stack.
  $977E,$03 Move up one row.
  $9781,$01 Move one cell to the right.
  $9782,$01 Fetch the attribute of that cell.
  $9783,$01 Restore #REGhl from the stack.
  $9784,$01 Stash the length on the stack.
N $9785 Draw the bottom of the ring, from left to right.
@ $9785 label=RippleAttributes_Bottom
  $9785,$01 Write #REGa to the attribute buffer.
  $9786,$01 Move one cell to the right.
  $9787,$02 Decrease the length by one and loop back to #R$9785 until it is
. zero.
  $9789,$01 Restore the length from the stack.
  $978A,$01 Stash it on the stack again.
N $978B Draw the right side of the ring, from bottom to top.
@ $978B label=RippleAttributes_Right
  $978B,$01 Write #REGa to the attribute buffer.
  $978C,$03 Move up one row.
  $978F,$02 Decrease the length by one and loop back to #R$978B until it is
. zero.
  $9791,$01 Restore the length from the stack.
  $9792,$01 Stash it on the stack again.
N $9793 Draw the top of the ring, from right to left.
@ $9793 label=RippleAttributes_Top
  $9793,$01 Write #REGa to the attribute buffer.
  $9794,$01 Move one cell to the left.
  $9795,$02 Decrease the length by one and loop back to #R$9793 until it is
. zero.
  $9797,$01 Restore the length from the stack.
  $9798,$01 Stash it on the stack again.
N $9799 Draw the left side of the ring, from top to bottom.
@ $9799 label=RippleAttributes_Left
  $9799,$01 Write #REGa to the attribute buffer.
  $979A,$01 Move down one row.
  $979B,$02 Decrease the length by one and loop back to #R$9799 until it is
. zero.
N $979D Move on to the next ring, which is inside this one.
  $979D,$01 Write #REGa to the attribute buffer.
  $979E,$03 Move up one row.
  $97A1,$01 Move one cell to the right.
  $97A2,$01 Restore the length from the stack.
  $97A3,$02 Make the sides two cells shorter.
  $97A5,$03 Decrease the number of rings by one and loop back to #R$977D until
. it is zero.
  $97A8,$01 Return.

b $97A9 Tunnel Frame Coordinates
@ $97A9 label=TunnelFrameCoordinates
D $97A9 The X and Y coordinates of the corners of the #N$0C squares that make up
. the frame of room #N$96, which is drawn by #R$9BEA (#N$04 pairs of coordinates
. for each square, from the smallest to the largest). The lines between the
. corners are listed in #R$9809.
B $97A9,$60,$08

b $9809 Tunnel Frame Lines
@ $9809 label=TunnelFrameLines
D $9809 The lines that join the corners in #R$97A9, which are drawn by #R$9BEA.
. For each square there are two lists, which each have the corner to start from
. followed by the corners to draw lines to, ending with #N$FF. The last byte is
. #N$FF to end all of the lists.
B $9809,$60,$04
B $9869,$01

c $986A Set Player Velocity
@ $986A label=SetPlayerVelocity
D $986A Sets the velocities of the player (offsets #N$06 and #N$07) from bits
. 6-7 of the attribute of a door, using #R$9883. This is done by #R$9117 so that
. the player moves out of the door.
R $986A IX The door entity
  $986A,$03 Fetch the attribute of the door.
  $986D,$03 Rotate #REGa left three times.
  $9870,$02,b$01 Keep only bits 1-2, which were bits 6-7.
  $9872,$01 Keep the velocity index in #REGc.
  $9873,$02 #REGb=#N$00.
  $9875,$03 Point #REGhl at the door velocities at #R$9883.
  $9878,$01 Find the velocities for the door in the table.
  $9879,$01 Fetch the X velocity.
  $987A,$01 Move #REGhl on to the next byte.
  $987B,$03 Update the X velocity of the player (offset #N$06).
  $987E,$01 Fetch the Y velocity.
  $987F,$03 Update the Y velocity of the player (offset #N$07).
  $9882,$01 Return.

b $9883 Door Velocities
@ $9883 label=DoorVelocities
D $9883 The velocities for the player when it comes out of a door, for each of
. the values of bits 6-7 of the attribute of the door (see #R$986A).
. #TABLE(default,centre,centre,centre)
. { =h Bits 6-7 | =h X Velocity | =h Y Velocity }
. { #N$00 | #N$00 | #N$20 }
. { #N$01 | #N$E0 | #N$00 }
. { #N$02 | #N$00 | #N$E0 }
. { #N$03 | #N$20 | #N$00 }
. TABLE#
B $9883,$08,$02

c $988B Handle Mushroom
@ $988B label=HandlerMushroom
D $988B The handler for the mushroom (sprite ID #N$A1). While the player is
. touching it (see #R$90FB), the energy in #R$5E28 is decreased by one every
. frame, the chicken is drawn again with #R$8B8A and a sound is made with
. #R$A3E5. When the energy reaches zero the mushroom is removed by #R$98C8. The
. attribute of the mushroom cycles round the colours in #R$98C4, changing every
. fourth frame (using offset #N$06), and the attributes are set by #R$92E0.
R $988B IX The mushroom entity
  $988B,$03 Call #R$9FFB to save the position of the mushroom.
  $988E,$03 Call #R$90FB to see whether the player is touching the mushroom.
  $9891,$02 Jump to #R$98B1 if it is.
@ $9893 label=HandlerMushroom_Colour
  $9893,$03 Fetch the counter from #R$5E12.
  $9896,$01 Flip the bits.
  $9897,$02,b$01 Keep only bits 0-1.
  $9899,$02 Jump to #R$989E unless this is every fourth frame.
  $989B,$03 Increment offset #N$06 of the mushroom.
@ $989E label=HandlerMushroom_Attribute
  $989E,$03 #REGa=offset #N$06 of the mushroom.
  $98A1,$02,b$01 Keep only bits 0-1.
  $98A3,$01 Keep the index in #REGc.
  $98A4,$02 #REGb=#N$00.
  $98A6,$03 Point #REGhl at the mushroom attributes at #R$98C4.
  $98A9,$01 Add #REGbc to #REGhl.
  $98AA,$01 Fetch the attribute.
  $98AB,$03 Update the attribute of the mushroom.
  $98AE,$03 Jump to #R$92E0 to set the attributes of the item.
N $98B1 The player is touching the mushroom, so decrease the energy.
@ $98B1 label=HandlerMushroom_Touching
  $98B1,$03 Fetch the energy of the player from #R$5E28.
N $98B4 See #POKE(infinite_energy,Infinite Energy).
  $98B4,$01 Decrease it by one.
  $98B5,$03 Update the energy of the player in #R$5E28.
  $98B8,$03 Jump to #R$98C8 if the energy is zero.
  $98BB,$03 Call #R$8B8A to draw the chicken.
  $98BE,$03 Call #R$A3E5 to make the sound of touching.
  $98C1,$03 Jump to #R$9893 to colour the mushroom.

b $98C4 Mushroom Attributes
@ $98C4 label=MushroomAttributes
D $98C4 The attributes that the mushroom cycles through (see #R$988B).
. #TABLE(default,centre,left)
. { =h Value | =h Colour }
. { #N$42 | #COLOUR$42 }
. { #N$43 | #COLOUR$43 }
. { #N$46 | #COLOUR$46 }
. { #N$43 | #COLOUR$43 }
. TABLE#
B $98C4,$04,$01

c $98C8 Remove Mushroom
@ $98C8 label=RemoveMushroom
D $98C8 Used by #R$988B when the player has no energy left. The mushroom is
. removed and a life is lost with #R$8EA0.
R $98C8 IX The mushroom entity
  $98C8,$03 Call #R$9F56 to remove the mushroom.
  $98CB,$04 Write #N$00 to the sprite ID of the mushroom.
  $98CF,$03 Jump to #R$8EA0 to take a life from the player.

c $98D2 Set Key Positions
@ $98D2 label=SetKeyPositions
D $98D2 Called when a game starts. Chooses the rooms for three of the keys from
. the three tables of rooms that follow, using FRAMES and the counter at
. #R$5E12. The green key (#R$603D) uses FRAMES, the red key (#R$6045) uses
. FRAMES plus the low byte of the counter, and the cyan key (#R$604D) uses the
. high bytes of both. The room of the red key is also given to the mummy (see
. #R$640D). The yellow key does not move.
  $98D2,$03 Fetch FRAMES.
  $98D5,$03 Point #REGhl at the green key rooms at #R$990C.
  $98D8,$03 Call #R$9904 to get a room.
  $98DB,$03 Update the room of the green key.
  $98DE,$04 Fetch FRAMES and keep FRAMES in #REGc.
  $98E2,$03 Fetch the counter from #R$5E12.
  $98E5,$01 Add FRAMES to the counter.
  $98E6,$03 Point #REGhl at the red key rooms at #R$9914.
  $98E9,$03 Call #R$9904 to get a room.
  $98EC,$03 Update the room of the red key.
  $98EF,$03 Update the room of the mummy (offset #N$01 of #R$640D).
  $98F2,$04 Fetch the second byte of FRAMES and keep it in #REGc.
  $98F6,$03 Fetch the high byte of the counter from #R$5E13.
  $98F9,$01 Add it to the high byte of the counter.
  $98FA,$03 Point #REGhl at the cyan key rooms at #R$991C.
  $98FD,$03 Call #R$9904 to get a room.
  $9900,$03 Update the room of the cyan key.
  $9903,$01 Return.

c $9904 Get Key Room
@ $9904 label=GetKeyRoom
D $9904 Looks up one of the eight rooms in a table using the bottom three bits
. of #REGa.
R $9904 A The value to use
R $9904 HL The table of eight rooms
R $9904 O:A The room
  $9904,$02,b$01 Keep only bits 0-2.
  $9906,$01 Keep the index in #REGc.
  $9907,$02 #REGb=#N$00.
  $9909,$01 Add #REGbc to #REGhl.
  $990A,$01 Fetch the room.
  $990B,$01 Return.

b $990C Green Key Rooms
@ $990C label=GreenKeyRooms
D $990C The eight rooms that the green key can start in (see #R$98D2).
B $990C,$08,$01

b $9914 Red Key Rooms
@ $9914 label=RedKeyRooms
D $9914 The eight rooms that the red key can start in (see #R$98D2).
B $9914,$08,$01

b $991C Cyan Key Rooms
@ $991C label=CyanKeyRooms
D $991C The eight rooms that the cyan key can start in (see #R$98D2).
B $991C,$08,$01

c $9924 Spawn Food
@ $9924 label=SpawnFood
D $9924 Called by the main loop. When the counter at #R$5E12 is zero and bit 0
. of #R$5E13 is reset, the next of the food items from #R$EB58 to #N$EDD8 is
. looked at (the food pointer in #R$5E55 moves on by #N$08 bytes, and starts
. again at #R$EB58 after the last one). If the item is not in the room of the
. player and is not already in use then it is made one of the foods (sprite IDs
. #N$50 to #N$57), using FRAMES.
  $9924,$04 Fetch the counter from #R$5E12 and keep the low byte of the counter
. in #REGc.
  $9928,$03 Fetch the high byte of the counter from #R$5E13.
  $992B,$02,b$01 Keep only bit 0.
  $992D,$02 Return unless the counter is zero and bit 0 of its high byte is
. reset.
  $992F,$03 #REGhl=*#R$5E55.
  $9932,$03 #REGde=#N($0008,$04,$04) (the size of a food item).
  $9935,$01 Move #REGhl on to the next food item.
  $9936,$03 Write #REGhl back to #R$5E55.
  $9939,$03 Copy #REGhl into #REGix, as the food item.
  $993C,$03 #REGde=#N$EDD8 (the end of the food items).
  $993F,$03 Subtract #REGde from #REGhl.
  $9942,$02 Jump to #R$995B if the food pointer is past the last item.
  $9944,$03 Fetch the room of the player from #R$EA91.
  $9947,$04 Return if the player is in the same room.
  $994B,$03 Fetch the sprite ID of the item.
  $994E,$02 Return if the item is in use.
  $9950,$03 Fetch FRAMES.
  $9953,$02,b$01 Keep only bits 0-2.
  $9955,$02 Add #N$50, to make the sprite ID of the food.
  $9957,$03 Update the sprite ID of the item.
  $995A,$01 Return.
@ $995B label=SpawnFood_Restart
  $995B,$03 #REGhl=#N$EB58.
  $995E,$03 Write #REGhl to #R$5E55.
  $9961,$01 Return.

c $9962 Draw Graphic
@ $9962 label=DrawGraphic
D $9962 Draws a graphic on the screen. The way that it is drawn depends on bits
. 5-7 of the attribute, which choose one of the handlers in #R$9970. Bits 0-1
. choose how it is mixed with what is already on the screen (see #R$9D19).
. #TABLE(default,centre,left)
. { =h Bits 5-7 | =h Handler | =h Orientation }
. { #N$00 | #R$99C9 | Upright }
. { #N$01 | #R$99E5 | Mirrored left to right }
. { #N$02 | #R$9A0A | Rotated a quarter turn anti-clockwise }
. { #N$03 | #R$9A50 | Transposed (flipped along the main diagonal) }
. { #N$04 | #R$9ACB | Flipped top to bottom }
. { #N$05 | #R$9AEF | Rotated a half turn }
. { #N$06 | #R$9B14 | Transposed (flipped along the other diagonal) }
. { #N$07 | #R$9B5D | Rotated a quarter turn clockwise }
. TABLE#
R $9962 B The attribute
R $9962 C The graphic ID
R $9962 D The Y position
R $9962 E The X position
  $9962,$03 Point #REGhl at the draw graphic handlers at #R$9970.
@ $9965 label=DrawGraphic_Dispatch
N $9965 This is also used by #R$9980, with a different table of handlers.
  $9965,$01 Stash the attribute and graphic ID on the stack.
  $9966,$01 Fetch the attribute.
  $9967,$03 Rotate #REGa left three times, to move bits 5-7 to bits 0-2.
  $996A,$02,b$01 Keep only bits 0-2.
  $996C,$01 Keep the type of handler in #REGc.
  $996D,$03 Jump to #R$7E85, which jumps to the handler in the table at #REGhl.

w $9970 Draw Graphic Handlers
@ $9970 label=DrawGraphicHandlers
D $9970 The handlers for the eight ways to draw a graphic, which are chosen by
. bits 5-7 of the attribute (see #R$9962).
W $9970,$10,$02

c $9980 Set Graphic Attributes
@ $9980 label=SetGraphicAttributes
D $9980 Sets the attributes of the cells that a graphic covers. This is the
. same as #R$9962 but with the handlers in #R$9985, which are the routines from
. #R$9D25 onwards.
R $9980 B The attribute
R $9980 C The graphic ID
R $9980 D The Y position
R $9980 E The X position
  $9980,$03 Point #REGhl at the set graphic attributes handlers at #R$9985.
  $9983,$02 Jump to #R$9965 to draw the graphic.

w $9985 Set Graphic Attributes Handlers
@ $9985 label=SetGraphicAttributesHandlers
D $9985 The handlers for the eight ways to set the attributes of a graphic,
. which are chosen by bits 5-7 of the attribute (see #R$9980).
W $9985,$10,$02

c $9995 Get Graphic Details
@ $9995 label=GetGraphicDetails
D $9995 Finds the details of a graphic from the table at #R$A600 (the entry is
. the graphic ID minus one). The first two bytes of the graphic are the width in
. bytes and the height in lines.
R $9995 C The graphic ID
R $9995 DE The position (#REGe is the X position and #REGd is the Y position)
R $9995 O:B The width of the graphic
R $9995 O:C The height of the graphic
R $9995 O:DE The address of the first byte of the graphic after the size
R $9995 O:HL The screen buffer address of the position
  $9995,$03 Point #REGhl at the graphics table at #R$A600.
  $9998,$01 Decrease the graphic ID by one.
  $9999,$02 Clear the high byte of the graphic ID.
  $999B,$02 Shift #REGc left.
  $999D,$02 Rotate #REGb left (so #REGbc=#REGbc * #N$02).
  $999F,$01 Find the entry for the graphic in the table.
  $99A0,$01 Fetch the low byte of the address of the graphic.
  $99A1,$01 Move #REGhl on to the high byte.
  $99A2,$01 Fetch the high byte of the address of the graphic.
  $99A3,$01 Keep the low byte of the address of the graphic in #REGl.
  $99A4,$01 Switch #REGde and #REGhl.
  $99A5,$03 Call #R$9BA2 to get the screen buffer address of the position.
  $99A8,$01 Fetch the width.
  $99A9,$01 Keep the width in #REGb.
  $99AA,$01 Move #REGde on to the next byte.
  $99AB,$01 Fetch the height.
  $99AC,$01 Keep the height in #REGc.
  $99AD,$01 Move #REGde on to the next byte.
  $99AE,$01 Return.

c $99AF Get Graphic Attribute Details
@ $99AF label=GetGraphicAttributeDetails
D $99AF This is the same as #R$9995 but for the attributes of a graphic, from
. the table at #R$A64E, and the position gives the address in the attribute
. buffer (see #R$9BD2).
R $99AF C The graphic ID
R $99AF DE The position (#REGe is the X position and #REGd is the Y position)
R $99AF O:B The width of the graphic
R $99AF O:C The height of the graphic
R $99AF O:DE The address of the first attribute of the graphic after the size
R $99AF O:HL The attribute buffer address of the position
  $99AF,$03 Point #REGhl at the graphics attributes table at #R$A64E.
  $99B2,$01 Decrease the graphic ID by one.
  $99B3,$02 Clear the high byte of the graphic ID.
  $99B5,$02 Shift #REGc left.
  $99B7,$02 Rotate #REGb left (so #REGbc=#REGbc * #N$02).
  $99B9,$01 Find the entry for the graphic in the table.
  $99BA,$01 Fetch the low byte of the address of the attributes.
  $99BB,$01 Move #REGhl on to the high byte.
  $99BC,$01 Fetch the high byte of the address of the attributes.
  $99BD,$01 Keep the low byte of the address of the attributes in #REGl.
  $99BE,$01 Switch #REGde and #REGhl.
  $99BF,$03 Call #R$9BD2 to get the attribute buffer address of the position.
  $99C2,$01 Fetch the width.
  $99C3,$01 Keep the width in #REGb.
  $99C4,$01 Move #REGde on to the next byte.
  $99C5,$01 Fetch the height.
  $99C6,$01 Keep the height in #REGc.
  $99C7,$01 Move #REGde on to the next byte.
  $99C8,$01 Return.

c $99C9 Draw Graphic Upright
@ $99C9 label=DrawGraphic_Upright
D $99C9 The handler of #R$9962 for a graphic that is drawn as it is stored. A
. row of bytes is copied at a time, and then #R$9F03 moves up a line.
  $99C9,$01 Restore the attribute and graphic ID from the stack.
  $99CA,$03 Call #R$9D19 to get the instruction to mix the graphic with the
. screen.
  $99CD,$03 Write it over the instruction at #R$99D7.
  $99D0,$03 Call #R$9995 to get the details of the graphic.
@ $99D3 label=DrawGraphic_Upright_Row
  $99D3,$01 Stash the width and height on the stack.
  $99D4,$01 Stash the screen address on the stack.
@ $99D5 label=DrawGraphic_Upright_Byte
  $99D5,$01 Fetch the next byte of the graphic.
  $99D6,$01 Move #REGde on to the next byte.
  $99D7,$01 This is replaced by an instruction that mixes #REGa with the screen.
  $99D8,$01 Write #REGa to the screen.
  $99D9,$01 Move #REGhl on to the next byte.
  $99DA,$02 Decrease the width by one and loop back to #R$99D5 until all of the
. bytes in the row have been drawn.
  $99DC,$01 Restore the screen address from the stack.
  $99DD,$03 Call #R$9F03 to move up a line.
  $99E0,$01 Restore the width and height from the stack.
  $99E1,$03 Decrease the height by one and loop back to #R$99D3 until all of the
. rows have been done.
  $99E4,$01 Return.

c $99E5 Draw Graphic Mirrored
@ $99E5 label=DrawGraphic_Mirrored
D $99E5 The handler of #R$9962 for a graphic that is mirrored from left to
. right. Each row is read from its end and the bits of each byte are
. reversed with #R$9A92.
  $99E5,$01 Restore the attribute and graphic ID from the stack.
  $99E6,$03 Call #R$9D19 to get the instruction to mix the graphic with the
. screen.
  $99E9,$03 Write it over the instruction at #R$99F9.
  $99EC,$03 Call #R$9995 to get the details of the graphic.
@ $99EF label=DrawGraphic_Mirrored_Row
  $99EF,$01 Stash the width and height on the stack.
  $99F0,$01 Stash the screen address on the stack.
  $99F1,$03 Call #R$9A9D to move #REGde on to the end of the row.
@ $99F4 label=DrawGraphic_Mirrored_Byte
  $99F4,$01 Move #REGde back one byte.
  $99F5,$01 Fetch the byte of the graphic.
  $99F6,$03 Call #R$9A92 to reverse the bits.
  $99F9,$01 This is replaced by an instruction that mixes #REGa with the screen.
  $99FA,$01 Write #REGa to the screen.
  $99FB,$01 Move #REGhl on to the next byte.
  $99FC,$02 Decrease the width by one and loop back to #R$99F4 until all of the
. bytes in the row have been drawn.
  $99FE,$01 Restore the screen address from the stack.
  $99FF,$03 Call #R$9F03 to move up a line.
  $9A02,$01 Restore the width and height from the stack.
  $9A03,$03 Call #R$9A9D to move #REGde on to the start of the next row.
  $9A06,$03 Decrease the height by one and loop back to #R$99EF until all of the
. rows have been done.
  $9A09,$01 Return.

c $9A0A Draw Graphic Rotated Left
@ $9A0A label=DrawGraphic_RotatedLeft
D $9A0A The handler of #R$9962 for a graphic that is turned a quarter turn
. anti-clockwise. Each row of the screen is made from a column of the graphic,
. from the right-hand side to the left-hand side. The bits for each byte come
. from eight rows of the graphic, which are gathered up in #REGh' using the
. mask in #REGl'.
  $9A0A,$01 Restore the attribute and graphic ID from the stack.
  $9A0B,$03 Call #R$9D19 to get the instruction to mix the graphic with the
. screen.
  $9A0E,$03 Write it over the instruction at #R$9A36.
  $9A11,$03 Call #R$9995 to get the details of the graphic.
  $9A14,$01 Fetch the width.
  $9A15,$01 Switch to the shadow registers.
  $9A16,$02 #REGl'=#N$01 (the mask for the first column).
  $9A18,$01 Keep the number of columns in #REGb'.
  $9A19,$01 Switch back to the main registers.
  $9A1A,$03 Call #R$9A9D to move #REGde on to the second row.
  $9A1D,$01 Move #REGde back to the last byte of the first row.
@ $9A1E label=DrawGraphic_RotatedLeft_Row
  $9A1E,$01 Stash the width and height on the stack.
  $9A1F,$01 Stash the position in the graphic on the stack.
  $9A20,$01 Stash the screen address on the stack.
@ $9A21 label=DrawGraphic_RotatedLeft_Bit
  $9A21,$01 Fetch the byte of the graphic.
  $9A22,$01 Switch to the shadow registers.
  $9A23,$01 Mask the column.
  $9A24,$02 Jump to #R$9A27 if the bit is not set.
  $9A26,$01 Set the carry flag.
@ $9A27 label=DrawGraphic_RotatedLeft_Shift
  $9A27,$02 Shift the bit into #REGh'.
  $9A29,$01 Switch back to the main registers.
  $9A2A,$03 Call #R$9A9D to move down to the next row of the graphic.
  $9A2D,$01 Decrease the height by one.
  $9A2E,$01 Fetch the number of rows left.
  $9A2F,$02,b$01 Keep only bits 0-2.
  $9A31,$02 Jump to #R$9A21 until eight bits have been gathered.
  $9A33,$01 Switch to the shadow registers.
  $9A34,$01 Fetch the byte that was built from the column.
  $9A35,$01 Switch back to the main registers.
  $9A36,$01 This is replaced by an instruction that mixes #REGa with the screen.
  $9A37,$01 Write #REGa to the screen.
  $9A38,$01 Move #REGhl on to the next byte.
  $9A39,$01 Fetch the number of rows left.
  $9A3A,$03 Jump to #R$9A21 if there are more bytes in this row of the screen.
  $9A3D,$01 Restore the screen address from the stack.
  $9A3E,$03 Call #R$9F03 to move up a line.
  $9A41,$01 Restore the position in the graphic from the stack.
  $9A42,$01 Restore the width and height from the stack.
  $9A43,$01 Switch to the shadow registers.
  $9A44,$02 Move the mask on to the next column.
  $9A46,$01 Switch back to the main registers.
  $9A47,$02 Jump to #R$9A1E if there are more columns in this byte.
  $9A49,$01 Switch to the shadow registers.
  $9A4A,$01 Decrease the number of columns by one.
  $9A4B,$01 Switch back to the main registers.
  $9A4C,$01 Return if all of the columns have been drawn.
  $9A4D,$01 Move #REGde back to the previous byte.
  $9A4E,$02 Jump back to #R$9A1E to draw the next row of the graphic.

c $9A50 Draw Graphic Transposed
@ $9A50 label=DrawGraphic_Transposed
D $9A50 The handler of #R$9962 for a graphic that is flipped along the diagonal
. from top left to bottom right. Each row of the screen is made from a column
. of the graphic, from the left-hand side to the right-hand side, from the top
. down. This is the same as #R$9A0A except for the direction of the columns.
  $9A50,$01 Restore the attribute and graphic ID from the stack.
  $9A51,$03 Call #R$9D19 to get the instruction to mix the graphic with the
. screen.
  $9A54,$03 Write it over the instruction at #R$9A78.
  $9A57,$03 Call #R$9995 to get the details of the graphic.
  $9A5A,$01 Fetch the width.
  $9A5B,$01 Switch to the shadow registers.
  $9A5C,$01 Keep the number of columns in #REGb'.
  $9A5D,$02 #REGl'=#N$80 (the mask for the first column).
  $9A5F,$01 Switch back to the main registers.
@ $9A60 label=DrawGraphic_Transposed_Row
  $9A60,$01 Stash the width and height on the stack.
  $9A61,$01 Stash the position in the graphic on the stack.
  $9A62,$01 Stash the screen address on the stack.
@ $9A63 label=DrawGraphic_Transposed_Bit
  $9A63,$01 Fetch the byte of the graphic.
  $9A64,$01 Switch to the shadow registers.
  $9A65,$01 Mask the column.
  $9A66,$02 Jump to #R$9A69 if the bit is not set.
  $9A68,$01 Set the carry flag.
@ $9A69 label=DrawGraphic_Transposed_Shift
  $9A69,$02 Shift the bit into #REGh'.
  $9A6B,$01 Switch back to the main registers.
  $9A6C,$03 Call #R$9A9D to move down to the next row of the graphic.
  $9A6F,$01 Decrease the height by one.
  $9A70,$01 Fetch the number of rows left.
  $9A71,$02,b$01 Keep only bits 0-2.
  $9A73,$02 Jump to #R$9A63 until eight bits have been gathered.
  $9A75,$01 Switch to the shadow registers.
  $9A76,$01 Fetch the byte that was built from the column.
  $9A77,$01 Switch back to the main registers.
  $9A78,$01 This is replaced by an instruction that mixes #REGa with the screen.
  $9A79,$01 Write #REGa to the screen.
  $9A7A,$01 Move #REGhl on to the next byte.
  $9A7B,$01 Fetch the number of rows left.
  $9A7C,$03 Jump to #R$9A63 if there are more bytes in this row of the screen.
  $9A7F,$01 Restore the screen address from the stack.
  $9A80,$03 Call #R$9F03 to move up a line.
  $9A83,$01 Restore the position in the graphic from the stack.
  $9A84,$01 Restore the width and height from the stack.
  $9A85,$01 Switch to the shadow registers.
  $9A86,$02 Move the mask on to the next column.
  $9A88,$01 Switch back to the main registers.
  $9A89,$02 Jump to #R$9A60 if there are more columns in this byte.
  $9A8B,$01 Switch to the shadow registers.
  $9A8C,$01 Decrease the number of columns by one.
  $9A8D,$01 Switch back to the main registers.
  $9A8E,$01 Return if all of the columns have been drawn.
  $9A8F,$01 Move #REGde on to the next byte.
  $9A90,$02 Jump back to #R$9A60 to draw the next row of the graphic.

c $9A92 Reverse Bits
@ $9A92 label=ReverseBits
D $9A92 Reverses the order of the bits in a byte.
R $9A92 A The byte
R $9A92 O:A The byte with its bits reversed
  $9A92,$01 Stash #REGbc on the stack.
  $9A93,$02 #REGb=#N$08 (the number of bits to reverse).
@ $9A95 label=ReverseBits_Loop
  $9A95,$01 Rotate the top bit of #REGa into the carry flag.
  $9A96,$02 Rotate the carry flag into the top of #REGc.
  $9A98,$02 Decrease the bit counter by one and loop back to #R$9A95 until all
. eight bits have been reversed.
  $9A9A,$01 Fetch the reversed byte.
  $9A9B,$01 Restore #REGbc from the stack.
  $9A9C,$01 Return.

c $9A9D Add Width To Address
@ $9A9D label=AddWidthToAddress
D $9A9D Adds the width of a graphic to #REGde, to move on one row.
R $9A9D B The width of the graphic
R $9A9D DE The address
R $9A9D O:DE The address plus the width
  $9A9D,$01 Fetch the width of the graphic.
  $9A9E,$01 Add the low byte of the address.
  $9A9F,$01 Keep the new low byte in #REGe.
  $9AA0,$01 Fetch the high byte of the address.
  $9AA1,$02 Add the carry.
  $9AA3,$01 Keep the new high byte in #REGd.
  $9AA4,$01 Return.

c $9AA5 Subtract Width From Address
@ $9AA5 label=SubtractWidthFromAddress
D $9AA5 Subtracts the width of a graphic from #REGde, to move back one row.
R $9AA5 B The width of the graphic
R $9AA5 DE The address
R $9AA5 O:DE The address minus the width
  $9AA5,$01 Fetch the low byte of the address.
  $9AA6,$01 Subtract the width.
  $9AA7,$01 Keep the new low byte in #REGe.
  $9AA8,$01 Fetch the high byte of the address.
  $9AA9,$02 Subtract the carry.
  $9AAB,$01 Keep the new high byte in #REGd.
  $9AAC,$01 Return.

c $9AAD Multiply A By DE
@ $9AAD label=MultiplyAByDE
D $9AAD Multiplies #REGa by #REGde.
E $9AAD View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE0D }
. { #GUNFRIGHT$D03E }
. { #KNIGHTLORE$D4F9 }
. { #NIGHTSHADE$E0EE }
. { #SABREWULF$BC5A }
. { #TRANZAM$6F2F }
. { #UNDERWURLDE$AC68 }
. LIST#
R $9AAD A The multiplier
R $9AAD DE The multiplicand
R $9AAD O:HL The result
  $9AAD,$03 #REGhl=#N($0000,$04,$04).
  $9AB0,$02 #REGb=#N$08 (the number of bits in the multiplier).
@ $9AB2 label=MultiplyAByDE_Loop
  $9AB2,$01 Shift the result left.
  $9AB3,$01 Rotate the next bit of #REGa into the carry flag.
  $9AB4,$02 Jump to #R$9AB7 if it was not set.
  $9AB6,$01 Add #REGde to the result.
@ $9AB7 label=MultiplyAByDE_Next
  $9AB7,$02 Decrease the bit counter by one and loop back to #R$9AB2 until every
. bit of the multiplier has been used.
  $9AB9,$01 Return.

c $9ABA Find Last Row
@ $9ABA label=FindLastRow
D $9ABA Moves #REGde on to the first byte of the last row of a graphic, which is
. the width multiplied by one less than the height.
R $9ABA B The width of the graphic
R $9ABA C The height of the graphic
R $9ABA DE The address of the graphic
R $9ABA O:DE The address of the last row
  $9ABA,$01 Stash #REGhl on the stack.
  $9ABB,$01 Stash #REGde on the stack.
  $9ABC,$01 Fetch the width of the graphic.
  $9ABD,$01 Fetch the height of the graphic.
  $9ABE,$01 Decrease it by one.
  $9ABF,$02 Clear the high byte of the height.
  $9AC1,$01 Stash #REGbc on the stack.
  $9AC2,$03 Call #R$9AAD to multiply the width by one less than the height.
  $9AC5,$01 Restore #REGbc from the stack.
  $9AC6,$01 Restore #REGde from the stack.
  $9AC7,$01 Add #REGde to the result.
  $9AC8,$01 Switch #REGde and #REGhl.
  $9AC9,$01 Restore #REGhl from the stack.
  $9ACA,$01 Return.

c $9ACB Draw Graphic Flipped
@ $9ACB label=DrawGraphic_Flipped
D $9ACB The handler of #R$9962 for a graphic that is flipped top to bottom. This
. is the same as #R$99C9, except that it starts from the last row and works up
. using #R$9AA5.
  $9ACB,$01 Restore the attribute and graphic ID from the stack.
  $9ACC,$03 Call #R$9D19 to get the instruction to mix the graphic with the
. screen.
  $9ACF,$03 Write it over the instruction at #R$9ADD.
  $9AD2,$03 Call #R$9995 to get the details of the graphic.
  $9AD5,$03 Call #R$9ABA to move on to the last row.
@ $9AD8 label=DrawGraphic_Flipped_Row
  $9AD8,$01 Stash the width and height on the stack.
  $9AD9,$01 Stash the position in the graphic on the stack.
  $9ADA,$01 Stash the screen address on the stack.
@ $9ADB label=DrawGraphic_Flipped_Byte
  $9ADB,$01 Fetch the next byte of the graphic.
  $9ADC,$01 Move #REGde on to the next byte.
  $9ADD,$01 This is replaced by an instruction that mixes #REGa with the screen.
  $9ADE,$01 Write #REGa to the screen.
  $9ADF,$01 Move #REGhl on to the next byte.
  $9AE0,$02 Decrease the width by one and loop back to #R$9ADB until all of the
. bytes in the row have been drawn.
  $9AE2,$01 Restore the screen address from the stack.
  $9AE3,$03 Call #R$9F03 to move up a line.
  $9AE6,$01 Restore the position in the graphic from the stack.
  $9AE7,$01 Restore the width and height from the stack.
  $9AE8,$03 Call #R$9AA5 to move back to the previous row of the graphic.
  $9AEB,$03 Decrease the height by one and loop back to #R$9AD8 until all of the
. rows have been done.
  $9AEE,$01 Return.

c $9AEF Draw Graphic Rotated Half
@ $9AEF label=DrawGraphic_RotatedHalf
D $9AEF The handler of #R$9962 for a graphic that is turned a half turn. This is
. the same as #R$99E5, except that it starts from the end of the last row.
  $9AEF,$01 Restore the attribute and graphic ID from the stack.
  $9AF0,$03 Call #R$9D19 to get the instruction to mix the graphic with the
. screen.
  $9AF3,$03 Write it over the instruction at #R$9B06.
  $9AF6,$03 Call #R$9995 to get the details of the graphic.
  $9AF9,$03 Call #R$9ABA to move on to the last row.
  $9AFC,$03 Call #R$9A9D to move on to the end of the last row.
@ $9AFF label=DrawGraphic_RotatedHalf_Row
  $9AFF,$01 Stash the width and height on the stack.
  $9B00,$01 Stash the screen address on the stack.
@ $9B01 label=DrawGraphic_RotatedHalf_Byte
  $9B01,$01 Move #REGde back one byte.
  $9B02,$01 Fetch the byte of the graphic.
  $9B03,$03 Call #R$9A92 to reverse the bits.
  $9B06,$01 This is replaced by an instruction that mixes #REGa with the screen.
  $9B07,$01 Write #REGa to the screen.
  $9B08,$01 Move #REGhl on to the next byte.
  $9B09,$02 Decrease the width by one and loop back to #R$9B01 until all of the
. bytes in the row have been drawn.
  $9B0B,$01 Restore the screen address from the stack.
  $9B0C,$03 Call #R$9F03 to move up a line.
  $9B0F,$01 Restore the width and height from the stack.
  $9B10,$03 Decrease the height by one and loop back to #R$9AFF until all of the
. rows have been done.
  $9B13,$01 Return.

c $9B14 Draw Graphic Transposed Flipped
@ $9B14 label=DrawGraphic_TransposedFlipped
D $9B14 The handler of #R$9962 for a graphic that is flipped along the diagonal
. from bottom left to top right. This is the same as #R$9A0A, except that it
. starts from the last row and works up using #R$9AA5.
  $9B14,$01 Restore the attribute and graphic ID from the stack.
  $9B15,$03 Call #R$9D19 to get the instruction to mix the graphic with the
. screen.
  $9B18,$03 Write it over the instruction at #R$9B43.
  $9B1B,$03 Call #R$9995 to get the details of the graphic.
  $9B1E,$01 Fetch the width.
  $9B1F,$01 Switch to the shadow registers.
  $9B20,$01 Keep the number of columns in #REGb'.
  $9B21,$02 #REGl'=#N$01 (the mask for the first column).
  $9B23,$01 Switch back to the main registers.
  $9B24,$03 Call #R$9A9D to move #REGde on to the end of the first row.
  $9B27,$01 Move #REGde back to the last byte of the first row.
  $9B28,$03 Call #R$9ABA to move on to the last row.
@ $9B2B label=DrawGraphic_TransposedFlipped_Row
  $9B2B,$01 Stash the width and height on the stack.
  $9B2C,$01 Stash the position in the graphic on the stack.
  $9B2D,$01 Stash the screen address on the stack.
@ $9B2E label=DrawGraphic_TransposedFlipped_Bit
  $9B2E,$01 Fetch the byte of the graphic.
  $9B2F,$01 Switch to the shadow registers.
  $9B30,$01 Mask the column.
  $9B31,$02 Jump to #R$9B34 if the bit is not set.
  $9B33,$01 Set the carry flag.
@ $9B34 label=DrawGraphic_TransposedFlipped_Shift
  $9B34,$02 Shift the bit into #REGh'.
  $9B36,$01 Switch back to the main registers.
  $9B37,$03 Call #R$9AA5 to move up to the previous row of the graphic.
  $9B3A,$01 Decrease the height by one.
  $9B3B,$01 Fetch the number of rows left.
  $9B3C,$02,b$01 Keep only bits 0-2.
  $9B3E,$02 Jump to #R$9B2E until eight bits have been gathered.
  $9B40,$01 Switch to the shadow registers.
  $9B41,$01 Fetch the byte that was built from the column.
  $9B42,$01 Switch back to the main registers.
  $9B43,$01 This is replaced by an instruction that mixes #REGa with the screen.
  $9B44,$01 Write #REGa to the screen.
  $9B45,$01 Move #REGhl on to the next byte.
  $9B46,$01 Fetch the number of rows left.
  $9B47,$03 Jump to #R$9B2E if there are more bytes in this row of the screen.
  $9B4A,$01 Restore the screen address from the stack.
  $9B4B,$03 Call #R$9F03 to move up a line.
  $9B4E,$01 Restore the position in the graphic from the stack.
  $9B4F,$01 Restore the width and height from the stack.
  $9B50,$01 Switch to the shadow registers.
  $9B51,$02 Move the mask on to the next column.
  $9B53,$01 Switch back to the main registers.
  $9B54,$02 Jump to #R$9B2B if there are more columns in this byte.
  $9B56,$01 Switch to the shadow registers.
  $9B57,$01 Decrease the number of columns by one.
  $9B58,$01 Switch back to the main registers.
  $9B59,$01 Return if all of the columns have been drawn.
  $9B5A,$01 Move #REGde back to the previous byte.
  $9B5B,$02 Jump back to #R$9B2B to draw the next row of the graphic.

c $9B5D Draw Graphic Rotated Right
@ $9B5D label=DrawGraphic_RotatedRight
D $9B5D The handler of #R$9962 for a graphic that is turned a quarter turn
. clockwise. This is the same as #R$9A50, except that it starts from the last
. row and works up using #R$9AA5.
  $9B5D,$01 Restore the attribute and graphic ID from the stack.
  $9B5E,$03 Call #R$9D19 to get the instruction to mix the graphic with the
. screen.
  $9B61,$03 Write it over the instruction at #R$9B88.
  $9B64,$03 Call #R$9995 to get the details of the graphic.
  $9B67,$01 Fetch the width.
  $9B68,$01 Switch to the shadow registers.
  $9B69,$01 Keep the number of columns in #REGb'.
  $9B6A,$02 #REGl'=#N$80 (the mask for the first column).
  $9B6C,$01 Switch back to the main registers.
  $9B6D,$03 Call #R$9ABA to move on to the last row.
@ $9B70 label=DrawGraphic_RotatedRight_Row
  $9B70,$01 Stash the width and height on the stack.
  $9B71,$01 Stash the position in the graphic on the stack.
  $9B72,$01 Stash the screen address on the stack.
@ $9B73 label=DrawGraphic_RotatedRight_Bit
  $9B73,$01 Fetch the byte of the graphic.
  $9B74,$01 Switch to the shadow registers.
  $9B75,$01 Mask the column.
  $9B76,$02 Jump to #R$9B79 if the bit is not set.
  $9B78,$01 Set the carry flag.
@ $9B79 label=DrawGraphic_RotatedRight_Shift
  $9B79,$02 Shift the bit into #REGh'.
  $9B7B,$01 Switch back to the main registers.
  $9B7C,$03 Call #R$9AA5 to move up to the previous row of the graphic.
  $9B7F,$01 Decrease the height by one.
  $9B80,$01 Fetch the number of rows left.
  $9B81,$02,b$01 Keep only bits 0-2.
  $9B83,$02 Jump to #R$9B73 until eight bits have been gathered.
  $9B85,$01 Switch to the shadow registers.
  $9B86,$01 Fetch the byte that was built from the column.
  $9B87,$01 Switch back to the main registers.
  $9B88,$01 This is replaced by an instruction that mixes #REGa with the screen.
  $9B89,$01 Write #REGa to the screen.
  $9B8A,$01 Move #REGhl on to the next byte.
  $9B8B,$01 Fetch the number of rows left.
  $9B8C,$03 Jump to #R$9B73 if there are more bytes in this row of the screen.
  $9B8F,$01 Restore the screen address from the stack.
  $9B90,$03 Call #R$9F03 to move up a line.
  $9B93,$01 Restore the position in the graphic from the stack.
  $9B94,$01 Restore the width and height from the stack.
  $9B95,$01 Switch to the shadow registers.
  $9B96,$02 Move the mask on to the next column.
  $9B98,$01 Switch back to the main registers.
  $9B99,$02 Jump to #R$9B70 if there are more columns in this byte.
  $9B9B,$01 Switch to the shadow registers.
  $9B9C,$01 Decrease the number of columns by one.
  $9B9D,$01 Switch back to the main registers.
  $9B9E,$01 Return if all of the columns have been drawn.
  $9B9F,$01 Move #REGde on to the next byte.
  $9BA0,$02 Jump back to #R$9B70 to draw the next row of the graphic.

c $9BA2 Calculate Screen Address
@ $9BA2 label=ScreenAddress
D $9BA2 Converts the pixel position of a point into the address in the screen
. buffer that holds it. The bits that are left over are not used here, so the
. address is the one for the left-hand pixel of the character cell.
E $9BA2 View the equivalent code in;
. #LIST
. { #COOKIE$76E3 }
. { #JETPAC$7308 }
. { #LUNARJETMAN$851E }
. { #PSSST$759A }
. { #SABREWULF$B8AD }
. { #TRANZAM$6F10 }
. { #UNDERWURLDE$ADF8 }
. LIST#
R $9BA2 H The Y position (the pixel line down from the top)
R $9BA2 L The X position (the pixel across from the left)
R $9BA2 O:HL The screen buffer address
  $9BA2,$01 Fetch the X position.
  $9BA3,$03 Rotate right three times, which divides the X position by #N$08.
  $9BA6,$02,b$01 Keep only bits 0-4.
  $9BA8,$01 Keep the column in #REGl.
  $9BA9,$01 Fetch the Y position.
  $9BAA,$02 Rotate left twice.
  $9BAC,$02,b$01 Keep only bits 5-7 (the character row within the third of the
. screen).
  $9BAE,$01 Combine it with the column.
  $9BAF,$01 Keep the low byte of the screen buffer address in #REGl.
  $9BB0,$01 Fetch the Y position.
  $9BB1,$02,b$01 Keep only bits 0-2 (the pixel line within the character).
  $9BB3,$01 Switch to the shadow #REGaf register.
  $9BB4,$01 Fetch the Y position.
  $9BB5,$03 Rotate right three times.
  $9BB8,$02,b$01 Keep only bits 3-4 (the third of the screen).
  $9BBA,$02,b$01 Set bit 6, so the address is in the screen buffer.
  $9BBC,$01 Keep the third of the screen in #REGh.
  $9BBD,$01 Switch back to the main #REGaf register.
  $9BBE,$01 Combine the pixel line with the third of the screen.
  $9BBF,$01 Keep the high byte of the screen buffer address in #REGh.
  $9BC0,$01 Return.

c $9BC1 Screen Address One Pixel Below
@ $9BC1 label=ScreenPosition1PixelBelow
D $9BC1 Moves a screen buffer address down by one pixel line.
E $9BC1 View the equivalent code in;
. #LIST
. { #MARTIANOIDS$BD3A }
. { #UNDERWURLDE$9C2B }
. LIST#
R $9BC1 HL The screen buffer address
R $9BC1 O:HL The screen buffer address of the line below
  $9BC1,$01 Move down a pixel line.
  $9BC2,$01 Fetch the high byte of the address.
  $9BC3,$02,b$01 Keep only bits 0-2.
  $9BC5,$01 Return if a character boundary has not been crossed.
  $9BC6,$01 Fetch the low byte of the address.
  $9BC7,$02 Move down a character row.
  $9BC9,$01 Keep the new low byte in #REGl.
  $9BCA,$02,b$01 Keep only bits 5-7.
  $9BCC,$01 Return if the next third of the screen has been reached.
  $9BCD,$01 Fetch the high byte of the address.
  $9BCE,$02 Subtract #N$08.
  $9BD0,$01 Keep the new high byte in #REGh.
  $9BD1,$01 Return.

c $9BD2 Calculate Attribute Address
@ $9BD2 label=AttributeAddress
D $9BD2 Converts the pixel position of a point into the address in the attribute
. buffer of the character cell that holds it.
E $9BD2 View the equivalent code in;
. #LIST
. { #COOKIE$7534 }
. { #JETPAC$720E }
. { #LUNARJETMAN$8506 }
. { #MARTIANOIDS$BD6A }
. { #PSSST$748F }
. { #SABREWULF$B8DD }
. { #TRANZAM$7097 }
. { #UNDERWURLDE$ADE0 }
. LIST#
R $9BD2 H The Y position (the pixel line down from the top)
R $9BD2 L The X position (the pixel across from the left)
R $9BD2 O:HL The attribute buffer address
  $9BD2,$01 Stash #REGbc on the stack.
  $9BD3,$01 Fetch the X position.
  $9BD4,$03 Rotate right three times, which divides the X position by #N$08.
  $9BD7,$02,b$01 Keep only bits 0-4 (the column).
  $9BD9,$01 Keep the column in #REGl.
  $9BDA,$01 Fetch the Y position.
  $9BDB,$02 Rotate left twice.
  $9BDD,$01 Keep the Y position, rotated, in #REGc.
  $9BDE,$02,b$01 Keep only bits 5-7 (the character row within the third of the
. screen).
  $9BE0,$01 Combine it with the column.
  $9BE1,$01 Keep the low byte of the attribute buffer address in #REGl.
  $9BE2,$01 Fetch the Y position, rotated.
  $9BE3,$02,b$01 Keep only bits 0-1 (the third of the screen).
  $9BE5,$02,b$01 Set bits 3-4 and 6, so the address is in the attribute buffer
. (#N$58).
  $9BE7,$01 Keep the high byte of the attribute buffer address in #REGh.
  $9BE8,$01 Restore #REGbc from the stack.
  $9BE9,$01 Return.

c $9BEA Draw Room Frame
@ $9BEA label=DrawRoomFrame
D $9BEA Clears #R$5E14 (so the next pass of #R$7DC3 draws the items in the
. room), reads the room's attribute from #R$A854 and draws the frame. The
. entry point at #R$9BF1 draws the frame of the room in #REGa, which is how
. #R$9731 draws the frame of room #N$96.
. The entry for the shape of the room in #R$A982 gives the width and height of
. the floor (written to #R$5E1D and #R$5E1E), the coordinates of the corners of
. the frame and the lists of the lines to draw between them (see #R$97A9 and
. #R$9809 for the frame of room #N$96). Each list has a corner to start from,
. followed by the corners to draw lines to, ending with #N$FF. The list of lists
. ends with #N$FF.
R $9BEA A The room (at the entry point #R$9BF1)
N $9BEA #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$9150,clear=1,sp=$5E00)
. #SCR$01(room-frame-before)
. | #SIM(start=$9150,stop=$9153,sp=$5E00)
. #SCR$01(room-frame-after) } UDGTABLE# #POPS
. The frame of a cave room (room #N$30):
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9 #UDGTABLE {
. #SIM(start=$7D9A,stop=$9147,clear=1,sp=$5E00)
. #POKES$EA91,$30
. #SIM(start=$9147,stop=$9153,sp=$5E00)
. #SCR$01(room-frame-cave) } UDGTABLE# #POPS
  $9BEA,$01 Reset #REGa.
  $9BEB,$03 Update the game flags in #R$5E14.
  $9BEE,$03 Fetch the room of the player from #R$EA91.
@ $9BF1 label=DrawRoomFrame_Room
  $9BF1,$03 Point #REGbc at the room attribute table at #R$A854.
  $9BF4,$01 Keep the room in #REGl.
  $9BF5,$02 Clear the high byte of the room.
  $9BF7,$01 Multiply #REGhl by #N$02.
  $9BF8,$01 Add #REGbc to #REGhl to get the entry for the room.
  $9BF9,$01 Fetch the attribute of the room.
  $9BFA,$01 Move on to the shape of the room.
  $9BFB,$03 Update the room attribute in #R$5E1A.
  $9BFE,$01 Switch to the shadow registers.
  $9BFF,$03 #REGhl'=#N$5800 (the attribute buffer).
  $9C02,$03 #REGbc'=#N($1818,$04,$04) (the size of the play area).
  $9C05,$03 Fetch the room attribute from #R$5E1A.
  $9C08,$03 Call #R$809A to fill the play area with the attribute.
  $9C0B,$01 Switch back to the main registers.
  $9C0C,$01 Fetch the shape of the room.
  $9C0D,$02 Clear the high byte of the shape.
  $9C0F,$01 Multiply #REGhl by #N$02.
  $9C10,$02 Keep the shape multiplied by two in #REGbc.
  $9C12,$01 Multiply #REGhl by #N$02.
  $9C13,$01 Add #REGbc to #REGhl, to multiply the shape by #N$06.
  $9C14,$03 Point #REGbc at the room shape table at #R$A982.
  $9C17,$01 Add #REGbc to #REGhl to get the entry for the shape.
  $9C18,$01 Fetch the width.
  $9C19,$01 Move on to the next byte.
  $9C1A,$03 Update the room width in #R$5E1D.
  $9C1D,$01 Fetch the height.
  $9C1E,$01 Move on to the next byte.
  $9C1F,$03 Update the room height in #R$5E1E.
  $9C22,$01 Fetch the low byte of the address of the coordinates.
  $9C23,$01 Move on to the next byte.
  $9C24,$01 Fetch the high byte of the address of the coordinates.
  $9C25,$01 Move on to the next byte.
  $9C26,$01 Fetch the low byte of the address of the lists of lines.
  $9C27,$01 Move on to the next byte.
  $9C28,$01 Fetch the high byte of the address of the lists of lines.
  $9C29,$01 Keep the low byte of the address of the lists of lines in #REGl.
  $9C2A,$03 Copy #REGde into #REGix, as the address of the coordinates.
N $9C2D Start a list. The corner to start from is found by changing the offsets
. in the instructions at #R$9C3D and #R$9C40.
  $9C2D,$01 Stash #REGbc on the stack.
@ $9C2E label=DrawRoomFrame_List
  $9C2E,$01 Restore #REGbc from the stack.
  $9C2F,$01 Fetch the corner to start from.
  $9C30,$01 Move #REGhl on to the next byte.
  $9C31,$03 Return if there are no more lists.
  $9C34,$02 Multiply the corner by #N$02.
  $9C36,$03 Write it as the offset in the instruction at #R$9C3D.
  $9C39,$01 Increment it.
  $9C3A,$03 Write it as the offset in the instruction at #R$9C40.
  $9C3D,$03 Fetch the X coordinate of the corner.
  $9C40,$03 Fetch the Y coordinate of the corner.
@ $9C43 label=DrawRoomFrame_Line
  $9C43,$01 Stash the coordinates of the corner on the stack.
  $9C44,$01 Fetch the corner to draw a line to.
  $9C45,$01 Move #REGhl on to the next byte.
  $9C46,$04 Jump to #R$9C2E if this is the end of the list.
  $9C4A,$02 Multiply the corner by #N$02.
  $9C4C,$03 Write it as the offset in the instruction at #R$9C53.
  $9C4F,$01 Increment it.
  $9C50,$03 Write it as the offset in the instruction at #R$9C56.
  $9C53,$03 Fetch the X coordinate of the corner.
  $9C56,$03 Fetch the Y coordinate of the corner.
  $9C59,$01 Stash #REGhl on the stack.
  $9C5A,$03 Call #R$9C79 to draw the line.
  $9C5D,$01 Restore #REGhl from the stack.
  $9C5E,$01 Restore the coordinates of the first corner from the stack.
  $9C5F,$02 Jump back to #R$9C43 to draw the next line of the frame.

c $9C61 Plot Pixel
@ $9C61 label=PlotPixel
D $9C61 Sets one pixel in the screen buffer.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SIM(start=$8093,stop=$0000,sp=$5B60)
. #SCR$08,$02,$09,$03,$03(plot-pixel-before)
. | #SIM(start=$9C61,stop=$0000,hl=$5018,sp=$5B60)
. #SCR$08,$02,$09,$03,$03(plot-pixel-after) } UDGTABLE# #POPS
R $9C61 H The Y position
R $9C61 L The X position
  $9C61,$01 Fetch the X position.
  $9C62,$02,b$01 Keep only bits 0-2.
  $9C64,$01 Add one, to get the number of shifts.
  $9C65,$01 Keep the number of shifts in #REGb.
  $9C66,$01 Clear #REGa, ready to make the mask for the pixel.
  $9C67,$01 Set the carry flag.
@ $9C68 label=PlotPixel_Mask
  $9C68,$01 Rotate the carry flag into #REGa.
  $9C69,$02 Decrease the shift counter by one and loop back to #R$9C68 until the
. pixel is in position.
  $9C6B,$01 Stash the position on the stack.
  $9C6C,$01 Stash the pixel on the stack.
  $9C6D,$01 Switch to the shadow #REGaf register.
  $9C6E,$01 Stash it on the stack.
  $9C6F,$03 Call #R$9BA2 to get the screen buffer address.
  $9C72,$01 Restore the shadow #REGaf register from the stack.
  $9C73,$01 Switch back to the main #REGaf register.
  $9C74,$01 Restore the pixel from the stack.
  $9C75,$01 Combine it with the byte in the screen buffer.
  $9C76,$01 Write it back.
  $9C77,$01 Restore the position from the stack.
  $9C78,$01 Return.

c $9C79 Draw Line
@ $9C79 label=DrawLine
D $9C79 Draws a line between two points with #R$9C61. The longer of the two
. distances is the number of steps, and the other changes by a fraction of
. a pixel at each step, which is worked out with #R$A379. The flags in #R$5E24
. have bit 0 set if the line goes down, and bit 1 set if it goes right.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SIM(start=$8093,stop=$0000,sp=$5B60)
. #SCR$02,$02,$03,$0C,$10(draw-line-before)
. | #SIM(start=$9C79,stop=$0000,bc=$2020,de=$9060,sp=$5B60)
. #SCR$02,$02,$03,$0C,$10(draw-line-after) } UDGTABLE# #POPS
R $9C79 B The Y position of the first point
R $9C79 C The X position of the first point
R $9C79 D The Y position of the second point
R $9C79 E The X position of the second point
  $9C79,$01 Keep the Y position of the first point in #REGh.
  $9C7A,$01 Keep the X position of the first point in #REGl.
  $9C7B,$02 #REGc=#N$00 (the flags).
  $9C7D,$01 Fetch the Y position of the first point.
  $9C7E,$01 Subtract the Y position of the second point.
  $9C7F,$02 Jump to #R$9C85 if the line does not go down.
  $9C81,$02 Negate it, to make the distance positive.
  $9C83,$02 Set bit 0 of the flags.
@ $9C85 label=DrawLine_Width
  $9C85,$01 Keep the distance up or down in #REGb.
  $9C86,$01 Fetch the X position of the first point.
  $9C87,$01 Subtract the X position of the second point.
  $9C88,$02 Jump to #R$9C8E if the line does not go right.
  $9C8A,$02 Negate it, to make the distance positive.
  $9C8C,$02 Set bit 1 of the flags.
@ $9C8E label=DrawLine_Direction
  $9C8E,$01 Compare the distance across with the distance up or down.
  $9C8F,$01 Switch to the shadow #REGaf register.
  $9C90,$01 Fetch the flags.
  $9C91,$03 Write the flags to #R$5E24.
  $9C94,$01 Switch back to the main #REGaf register.
  $9C95,$03 Jump to #R$9CD6 if the distance up or down is more.
N $9C98 The distance across is the most, so move one pixel across at each step.
  $9C98,$03 Write the distance across to #R$5E23.
  $9C9B,$01 Stash the second point on the stack.
  $9C9C,$01 Stash the first point on the stack.
  $9C9D,$01 Keep the distance across in #REGe.
  $9C9E,$02 Clear the high byte of the distance.
  $9CA0,$01 Clear #REGl.
  $9CA1,$01 #REGh=the distance up or down.
  $9CA2,$03 Call #R$A379 to work out the fraction of a pixel to move up or down.
  $9CA5,$03 Fetch the line flags from #R$5E24.
  $9CA8,$04 Jump to #R$9CAF if the line goes down.
  $9CAC,$03 Call #R$A39E to negate the fraction.
@ $9CAF label=DrawLine_StepAcross
  $9CAF,$03 Fetch the line flags from #R$5E24.
  $9CB2,$02 Test bit 1.
  $9CB4,$02 #REGc=#N$01 (the step to the right).
  $9CB6,$02 Jump to #R$9CBA if the line goes right.
  $9CB8,$02 #REGc=#N$FF (the step to the left).
@ $9CBA label=DrawLine_Across
  $9CBA,$01 Switch #REGde and #REGhl.
  $9CBB,$01 Restore the first point from the stack.
  $9CBC,$03 Fetch the line distance from #R$5E23.
  $9CBF,$01 Add one, to get the number of steps.
  $9CC0,$01 Keep the number of steps in #REGb.
  $9CC1,$01 #REGa=#REGe.
  $9CC2,$01 Switch to the shadow #REGaf register.
@ $9CC3 label=DrawLine_AcrossLoop
  $9CC3,$01 Stash the number of steps and the step across on the stack.
  $9CC4,$03 Call #R$9C61 to plot the pixel.
  $9CC7,$01 #REGa=#REGl.
  $9CC8,$01 Switch #REGa with the shadow #REGa.
  $9CC9,$01 #REGl=#REGa.
  $9CCA,$01 Add the fraction to the position.
  $9CCB,$01 #REGa=#REGl.
  $9CCC,$01 Switch #REGa with the shadow #REGa.
  $9CCD,$01 Restore the number of steps and the step across from the stack.
  $9CCE,$01 Move to the next pixel across.
  $9CCF,$01 #REGl=#REGa.
  $9CD0,$02 Decrease the number of steps by one and loop back to #R$9CC3 until
. every pixel of the line has been plotted.
  $9CD2,$01 Restore the second point from the stack.
  $9CD3,$03 Jump to #R$9C61 to plot the last pixel.
N $9CD6 The distance up or down is the most, so move one pixel up or down at
. each step.
@ $9CD6 label=DrawLine_Height
  $9CD6,$01 Switch to the shadow #REGaf register.
  $9CD7,$01 Fetch the distance up or down.
  $9CD8,$03 Write the distance up or down to #R$5E23.
  $9CDB,$01 Switch back to the main #REGaf register.
  $9CDC,$01 Stash the second point on the stack.
  $9CDD,$01 Stash the first point on the stack.
  $9CDE,$01 Keep the distance up or down in #REGe.
  $9CDF,$02 Clear the high byte of the distance.
  $9CE1,$01 Clear #REGl.
  $9CE2,$01 #REGh=the distance across.
  $9CE3,$03 Call #R$A379 to work out the fraction of a pixel to move across.
  $9CE6,$03 Fetch the line flags from #R$5E24.
  $9CE9,$04 Jump to #R$9CF0 if the line goes right.
  $9CED,$03 Call #R$A39E to negate the fraction.
@ $9CF0 label=DrawLine_StepDown
  $9CF0,$03 Fetch the line flags from #R$5E24.
  $9CF3,$02 Test bit 0.
  $9CF5,$02 #REGc=#N$01 (the step down).
  $9CF7,$02 Jump to #R$9CFB if the line goes down.
  $9CF9,$02 #REGc=#N$FF (the step up).
@ $9CFB label=DrawLine_Down
  $9CFB,$01 Switch #REGde and #REGhl.
  $9CFC,$01 Restore the first point from the stack.
  $9CFD,$03 Fetch the line distance from #R$5E23.
  $9D00,$01 Add one, to get the number of steps.
  $9D01,$01 Keep the number of steps in #REGb.
  $9D02,$01 #REGa=#REGe.
  $9D03,$01 Switch to the shadow #REGaf register.
@ $9D04 label=DrawLine_DownLoop
  $9D04,$01 Stash the number of steps and the step down on the stack.
  $9D05,$03 Call #R$9C61 to plot the pixel.
  $9D08,$01 #REGa=#REGh.
  $9D09,$01 Switch #REGa with the shadow #REGa.
  $9D0A,$01 #REGh=#REGl.
  $9D0B,$01 #REGl=#REGa.
  $9D0C,$01 Add the fraction to the position.
  $9D0D,$01 #REGa=#REGl.
  $9D0E,$01 #REGl=#REGh.
  $9D0F,$01 Switch #REGa with the shadow #REGa.
  $9D10,$01 Restore the number of steps and the step down from the stack.
  $9D11,$01 Move to the next pixel down.
  $9D12,$01 #REGh=#REGa.
  $9D13,$02 Decrease the number of steps by one and loop back to #R$9D04 until
. every pixel of the line has been plotted.
  $9D15,$01 Restore the second point from the stack.
  $9D16,$03 Jump to #R$9C61 to plot the last pixel.

c $9D19 Get Blend Instruction
@ $9D19 label=GetBlendInstruction
D $9D19 Gets the instruction that #R$9962 uses to mix a graphic with what is on
. the screen, from bits 0-1 of the attribute.
. #TABLE(default,centre,left)
. { =h Bits 0-1 | =h Instruction }
. { #N$00 | #N$00 (NOP), which replaces what is on the screen }
. { #N$01 | #N$B6 (OR (HL)) }
. { #N$02 | #N$AE (XOR (HL)) }
. { #N$03 | #N$AE (XOR (HL)) }
. TABLE#
R $9D19 B The attribute
R $9D19 O:A The instruction
  $9D19,$01 Fetch the attribute.
  $9D1A,$02,b$01 Keep only bits 0-1.
  $9D1C,$01 Return if #N$00 (no blending).
  $9D1D,$02 Compare #REGa with #N$01...
  $9D1F,$02 #REGa=#N$AE.
  $9D21,$01 Return if the comparison was not zero (XOR blending).
  $9D22,$02 #REGa+=#N$08.
  $9D24,$01 Return (OR blending).

c $9D25 Set Attributes Upright
@ $9D25 label=SetAttributes_Upright
D $9D25 The handler of #R$9980 for a graphic that is as it is stored. Each
. attribute byte is written to the attribute buffer, unless it is #N$00 (which
. leaves the attribute as it is) or #N$FF (which uses the attribute of the room
. from #R$5E1A). Each row is a line up from the last, as in #R$99C9.
  $9D25,$01 Restore the attribute and graphic ID from the stack.
  $9D26,$03 Call #R$99AF to get the details of the attributes.
@ $9D29 label=SetAttributes_Upright_Row
  $9D29,$01 Stash the width and height on the stack.
  $9D2A,$01 Stash the attribute buffer address on the stack.
@ $9D2B label=SetAttributes_Upright_Cell
  $9D2B,$01 Fetch the next attribute.
  $9D2C,$01 Move #REGde on to the next byte.
  $9D2D,$03 Jump to #R$9D38 if it is #N$00.
  $9D30,$04 Jump to #R$9D37 if it is not #N$FF.
  $9D34,$03 Fetch the room attribute from #R$5E1A.
@ $9D37 label=SetAttributes_Upright_Write
  $9D37,$01 Write #REGa to the attribute buffer.
@ $9D38 label=SetAttributes_Upright_Next
  $9D38,$01 Move #REGhl on to the next cell.
  $9D39,$02 Decrease the width by one and loop back to #R$9D2B until all of the
. cells in the row have been set.
  $9D3B,$01 Restore the attribute buffer address from the stack.
  $9D3C,$03 #REGbc=#N($0020,$04,$04) (the size of a row of the attribute
. buffer).
  $9D3F,$03 Move up a row.
  $9D42,$01 Restore the width and height from the stack.
  $9D43,$03 Decrease the height by one and loop back to #R$9D29 until all of the
. rows have been set.
  $9D46,$01 Return.
c $9D47 Set Attributes Mirrored
@ $9D47 label=SetAttributes_Mirrored
D $9D47 The handler of #R$9980 for a graphic that is mirrored from left to
. right.
. This is the same as #R$9D25, except that each row is read from its end.
  $9D47,$01 Restore the attribute and graphic ID from the stack.
  $9D48,$03 Call #R$99AF to get the details of the attributes.
  $9D4B,$01 Move #REGde back one byte.
@ $9D4C label=SetAttributes_Mirrored_Row
  $9D4C,$03 Call #R$9A9D to move #REGde on to the end of the row.
  $9D4F,$01 Stash the width and height on the stack.
  $9D50,$01 Stash the position in the attributes on the stack.
  $9D51,$01 Stash the attribute buffer address on the stack.
@ $9D52 label=SetAttributes_Mirrored_Cell
  $9D52,$01 Fetch the next attribute.
  $9D53,$01 Move #REGde back one byte.
  $9D54,$03 Jump to #R$9D5F if it is #N$00.
  $9D57,$04 Jump to #R$9D5E if it is not #N$FF.
  $9D5B,$03 Fetch the room attribute from #R$5E1A.
@ $9D5E label=SetAttributes_Mirrored_Write
  $9D5E,$01 Write #REGa to the attribute buffer.
@ $9D5F label=SetAttributes_Mirrored_Next
  $9D5F,$01 Move #REGhl on to the next cell.
  $9D60,$02 Decrease the width by one and loop back to #R$9D52 until all of the
. cells in the row have been set.
  $9D62,$01 Restore the attribute buffer address from the stack.
  $9D63,$03 #REGbc=#N($0020,$04,$04) (the size of a row of the attribute
. buffer).
  $9D66,$03 Move up a row.
  $9D69,$01 Restore the position in the attributes from the stack.
  $9D6A,$01 Restore the width and height from the stack.
  $9D6B,$03 Decrease the height by one and loop back to #R$9D4C until all of the
. rows have been set.
  $9D6E,$01 Return.
c $9D6F Set Attributes Rotated Left
@ $9D6F label=SetAttributes_RotatedLeft
D $9D6F The handler of #R$9980 for a graphic that is turned a quarter turn
. anti-clockwise. This is the same as #R$9D25, except that each row of the
. screen is made from a column of the attributes, from the right-hand side to
. the left-hand side.
  $9D6F,$01 Restore the attribute and graphic ID from the stack.
  $9D70,$03 Call #R$99AF to get the details of the attributes.
  $9D73,$01 Fetch the width.
  $9D74,$01 Switch to the shadow registers.
  $9D75,$01 Keep the number of columns in #REGb'.
  $9D76,$01 Switch back to the main registers.
  $9D77,$03 Call #R$9A9D to move #REGde on to the second row.
@ $9D7A label=SetAttributes_RotatedLeft_Row
  $9D7A,$01 Move #REGde back to the previous column (at first, the last byte of
. the first row).
  $9D7B,$01 Stash the width and height on the stack.
  $9D7C,$01 Stash the position in the attributes on the stack.
  $9D7D,$01 Stash the attribute buffer address on the stack.
@ $9D7E label=SetAttributes_RotatedLeft_Cell
  $9D7E,$01 Fetch the next attribute.
  $9D7F,$03 Jump to #R$9D8A if it is #N$00.
  $9D82,$04 Jump to #R$9D89 if it is not #N$FF.
  $9D86,$03 Fetch the room attribute from #R$5E1A.
@ $9D89 label=SetAttributes_RotatedLeft_Write
  $9D89,$01 Write #REGa to the attribute buffer.
@ $9D8A label=SetAttributes_RotatedLeft_Next
  $9D8A,$03 Call #R$9A9D to move down to the next row of the attributes.
  $9D8D,$01 Move #REGhl on to the next cell.
  $9D8E,$03 Decrease the height by one and loop back to #R$9D7E until all of the
. rows have been set.
  $9D91,$01 Restore the attribute buffer address from the stack.
  $9D92,$03 #REGbc=#N($0020,$04,$04) (the size of a row of the attribute
. buffer).
  $9D95,$03 Move up a row.
  $9D98,$01 Restore the position in the attributes from the stack.
  $9D99,$01 Restore the width and height from the stack.
  $9D9A,$01 Switch to the shadow registers.
  $9D9B,$01 Decrease the number of columns by one.
  $9D9C,$01 Switch back to the main registers.
  $9D9D,$02 Jump to #R$9D7A until all of the columns are done.
  $9D9F,$01 Return.
c $9DA0 Set Attributes Transposed
@ $9DA0 label=SetAttributes_Transposed
D $9DA0 The handler of #R$9980 for a graphic that is flipped along the diagonal
. from top left to bottom right. This is the same as #R$9D6F, except that the
. columns of the attributes are used from the left-hand side to the right-hand
. side.
  $9DA0,$01 Restore the attribute and graphic ID from the stack.
  $9DA1,$03 Call #R$99AF to get the details of the attributes.
  $9DA4,$01 Fetch the width.
  $9DA5,$01 Switch to the shadow registers.
  $9DA6,$01 Keep the number of columns in #REGb'.
  $9DA7,$01 Switch back to the main registers.
@ $9DA8 label=SetAttributes_Transposed_Row
  $9DA8,$01 Stash the width and height on the stack.
  $9DA9,$01 Stash the position in the attributes on the stack.
  $9DAA,$01 Stash the attribute buffer address on the stack.
@ $9DAB label=SetAttributes_Transposed_Cell
  $9DAB,$01 Fetch the next attribute.
  $9DAC,$03 Jump to #R$9DB7 if it is #N$00.
  $9DAF,$04 Jump to #R$9DB6 if it is not #N$FF.
  $9DB3,$03 Fetch the room attribute from #R$5E1A.
@ $9DB6 label=SetAttributes_Transposed_Write
  $9DB6,$01 Write #REGa to the attribute buffer.
@ $9DB7 label=SetAttributes_Transposed_Next
  $9DB7,$03 Call #R$9A9D to move down to the next row of the attributes.
  $9DBA,$01 Move #REGhl on to the next cell.
  $9DBB,$03 Decrease the height by one and loop back to #R$9DAB until all of the
. rows have been set.
  $9DBE,$01 Restore the attribute buffer address from the stack.
  $9DBF,$03 #REGbc=#N($0020,$04,$04) (the size of a row of the attribute
. buffer).
  $9DC2,$03 Move up a row.
  $9DC5,$01 Restore the position in the attributes from the stack.
  $9DC6,$01 Restore the width and height from the stack.
  $9DC7,$01 Move #REGde on to the next column.
  $9DC8,$01 Switch to the shadow registers.
  $9DC9,$01 Decrease the number of columns by one.
  $9DCA,$01 Switch back to the main registers.
  $9DCB,$02 Jump to #R$9DA8 until all of the columns are done.
  $9DCD,$01 Return.
c $9DCE Set Attributes Flipped
@ $9DCE label=SetAttributes_Flipped
D $9DCE The handler of #R$9980 for a graphic that is flipped from top to bottom.
. This is the same as #R$9D25, except that it starts from the last row and works
. back up with #R$9AA5.
  $9DCE,$01 Restore the attribute and graphic ID from the stack.
  $9DCF,$03 Call #R$99AF to get the details of the attributes.
  $9DD2,$03 Call #R$9ABA to move on to the last row.
@ $9DD5 label=SetAttributes_Flipped_Row
  $9DD5,$01 Stash the width and height on the stack.
  $9DD6,$01 Stash the position in the attributes on the stack.
  $9DD7,$01 Stash the attribute buffer address on the stack.
@ $9DD8 label=SetAttributes_Flipped_Cell
  $9DD8,$01 Fetch the next attribute.
  $9DD9,$01 Move #REGde on to the next byte.
  $9DDA,$03 Jump to #R$9DE5 if it is #N$00.
  $9DDD,$04 Jump to #R$9DE4 if it is not #N$FF.
  $9DE1,$03 Fetch the room attribute from #R$5E1A.
@ $9DE4 label=SetAttributes_Flipped_Write
  $9DE4,$01 Write #REGa to the attribute buffer.
@ $9DE5 label=SetAttributes_Flipped_Next
  $9DE5,$01 Move #REGhl on to the next cell.
  $9DE6,$02 Decrease the width by one and loop back to #R$9DD8 until all of the
. cells in the row have been set.
  $9DE8,$01 Restore the attribute buffer address from the stack.
  $9DE9,$03 #REGbc=#N($0020,$04,$04) (the size of a row of the attribute
. buffer).
  $9DEC,$03 Move up a row.
  $9DEF,$01 Restore the position in the attributes from the stack.
  $9DF0,$01 Restore the width and height from the stack.
  $9DF1,$03 Call #R$9AA5 to move back to the previous row of the attributes.
  $9DF4,$03 Decrease the height by one and loop back to #R$9DD5 until all of the
. rows have been set.
  $9DF7,$01 Return.
c $9DF8 Set Attributes Rotated Half
@ $9DF8 label=SetAttributes_RotatedHalf
D $9DF8 The handler of #R$9980 for a graphic that is turned a half turn. This is
. the same as #R$9D47, except that it starts from the end of the last row.
  $9DF8,$01 Restore the attribute and graphic ID from the stack.
  $9DF9,$03 Call #R$99AF to get the details of the attributes.
  $9DFC,$03 Call #R$9ABA to move on to the last row.
  $9DFF,$03 Call #R$9A9D to move on to the end of the last row.
  $9E02,$01 Move #REGde back one byte.
@ $9E03 label=SetAttributes_RotatedHalf_Row
  $9E03,$01 Stash the width and height on the stack.
  $9E04,$01 Stash the attribute buffer address on the stack.
@ $9E05 label=SetAttributes_RotatedHalf_Cell
  $9E05,$01 Fetch the next attribute.
  $9E06,$01 Move #REGde back one byte.
  $9E07,$03 Jump to #R$9E12 if it is #N$00.
  $9E0A,$04 Jump to #R$9E11 if it is not #N$FF.
  $9E0E,$03 Fetch the room attribute from #R$5E1A.
@ $9E11 label=SetAttributes_RotatedHalf_Write
  $9E11,$01 Write #REGa to the attribute buffer.
@ $9E12 label=SetAttributes_RotatedHalf_Next
  $9E12,$01 Move #REGhl on to the next cell.
  $9E13,$02 Decrease the width by one and loop back to #R$9E05 until all of the
. cells in the row have been set.
  $9E15,$01 Restore the attribute buffer address from the stack.
  $9E16,$03 #REGbc=#N($0020,$04,$04) (the size of a row of the attribute
. buffer).
  $9E19,$03 Move up a row.
  $9E1C,$01 Restore the width and height from the stack.
  $9E1D,$03 Decrease the height by one and loop back to #R$9E03 until all of the
. rows have been set.
  $9E20,$01 Return.
c $9E21 Set Attributes Transposed Flipped
@ $9E21 label=SetAttributes_TransposedFlipped
D $9E21 The handler of #R$9980 for a graphic that is flipped along the diagonal
. from bottom left to top right. This is the same as #R$9D6F, except that it
. starts from the last row and works back up with #R$9AA5.
  $9E21,$01 Restore the attribute and graphic ID from the stack.
  $9E22,$03 Call #R$99AF to get the details of the attributes.
  $9E25,$01 Fetch the width.
  $9E26,$01 Switch to the shadow registers.
  $9E27,$01 Keep the number of columns in #REGb'.
  $9E28,$01 Switch back to the main registers.
  $9E29,$03 Call #R$9ABA to move on to the last row.
  $9E2C,$03 Call #R$9A9D to move #REGde on to the end of the last row.
@ $9E2F label=SetAttributes_TransposedFlipped_Row
  $9E2F,$01 Move #REGde back to the previous column (at first, the last byte of
. the last row).
  $9E30,$01 Stash the width and height on the stack.
  $9E31,$01 Stash the position in the attributes on the stack.
  $9E32,$01 Stash the attribute buffer address on the stack.
@ $9E33 label=SetAttributes_TransposedFlipped_Cell
  $9E33,$01 Fetch the next attribute.
  $9E34,$03 Jump to #R$9E3F if it is #N$00.
  $9E37,$04 Jump to #R$9E3E if it is not #N$FF.
  $9E3B,$03 Fetch the room attribute from #R$5E1A.
@ $9E3E label=SetAttributes_TransposedFlipped_Write
  $9E3E,$01 Write #REGa to the attribute buffer.
@ $9E3F label=SetAttributes_TransposedFlipped_Next
  $9E3F,$03 Call #R$9AA5 to move up to the previous row of the attributes.
  $9E42,$01 Move #REGhl on to the next cell.
  $9E43,$03 Decrease the height by one and loop back to #R$9E33 until all of the
. rows have been set.
  $9E46,$01 Restore the attribute buffer address from the stack.
  $9E47,$03 #REGbc=#N($0020,$04,$04) (the size of a row of the attribute
. buffer).
  $9E4A,$03 Move up a row.
  $9E4D,$01 Restore the position in the attributes from the stack.
  $9E4E,$01 Restore the width and height from the stack.
  $9E4F,$01 Switch to the shadow registers.
  $9E50,$01 Decrease the number of columns by one.
  $9E51,$01 Switch back to the main registers.
  $9E52,$02 Jump to #R$9E2F until all of the columns are done.
  $9E54,$01 Return.
c $9E55 Set Attributes Rotated Right
@ $9E55 label=SetAttributes_RotatedRight
D $9E55 The handler of #R$9980 for a graphic that is turned a quarter turn
. clockwise. This is the same as #R$9DA0, except that it starts from the last
. row and works back up with #R$9AA5.
  $9E55,$01 Restore the attribute and graphic ID from the stack.
  $9E56,$03 Call #R$99AF to get the details of the attributes.
  $9E59,$01 Fetch the width.
  $9E5A,$01 Switch to the shadow registers.
  $9E5B,$01 Keep the number of columns in #REGb'.
  $9E5C,$01 Switch back to the main registers.
  $9E5D,$03 Call #R$9ABA to move on to the last row.
@ $9E60 label=SetAttributes_RotatedRight_Row
  $9E60,$01 Stash the width and height on the stack.
  $9E61,$01 Stash the position in the attributes on the stack.
  $9E62,$01 Stash the attribute buffer address on the stack.
@ $9E63 label=SetAttributes_RotatedRight_Cell
  $9E63,$01 Fetch the next attribute.
  $9E64,$03 Jump to #R$9E6F if it is #N$00.
  $9E67,$04 Jump to #R$9E6E if it is not #N$FF.
  $9E6B,$03 Fetch the room attribute from #R$5E1A.
@ $9E6E label=SetAttributes_RotatedRight_Write
  $9E6E,$01 Write #REGa to the attribute buffer.
@ $9E6F label=SetAttributes_RotatedRight_Next
  $9E6F,$03 Call #R$9AA5 to move up to the previous row of the attributes.
  $9E72,$01 Move #REGhl on to the next cell.
  $9E73,$03 Decrease the height by one and loop back to #R$9E63 until all of the
. rows have been set.
  $9E76,$01 Restore the attribute buffer address from the stack.
  $9E77,$03 #REGbc=#N($0020,$04,$04) (the size of a row of the attribute
. buffer).
  $9E7A,$03 Move up a row.
  $9E7D,$01 Restore the position in the attributes from the stack.
  $9E7E,$01 Restore the width and height from the stack.
  $9E7F,$01 Move #REGde on to the next column.
  $9E80,$01 Switch to the shadow registers.
  $9E81,$01 Decrease the number of columns by one.
  $9E82,$01 Switch back to the main registers.
  $9E83,$02 Jump to #R$9E60 until all of the columns are done.
  $9E85,$01 Return.

c $9E86 Get Sprite "A"
@ $9E86 label=GetSpriteA
D $9E86 Fetches the address of the graphic for the sprite ID that was recorded
. by #R$9FFB.
E $9E86 View the equivalent code in;
. #LIST
. { #SABREWULF$B925 }
. { #UNDERWURLDE$9643 }
. LIST#
E $9E86 Continue on to #R$9E89.
R $9E86 O:DE The sprite address
  $9E86,$03 #REGa=the sprite ID from #R$5E15.

c $9E89 Fetch Sprite
@ $9E89 label=FetchSprite
D $9E89 Looks up the address of the graphic for a sprite in the table at
. #R$A4BE. The table has a two byte entry for each sprite ID, starting at
. ID #N$01.
E $9E89 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$8568 }
. { #SABREWULF$B928 }
. { #SABREWULF$B934 }
. { #UNDERWURLDE$9646 }
. LIST#
R $9E89 A The sprite ID
R $9E89 O:DE The sprite address
  $9E89,$01 Decrease the sprite ID by one, as the table starts at ID #N$01.
  $9E8A,$03 Fetch the sprite ID.
  $9E8D,$01 Multiply by #N$02, as each entry in the table is a two byte address.
  $9E8E,$04 #REGhl=#R$A4BE + the offset of the entry.
  $9E92,$03 Fetch the sprite address.
  $9E95,$01 Return.

c $9E96 Fetch Actor Sprite
@ $9E96 label=FetchActorSprite
D $9E96 Fetches the address of the graphic for the sprite ID of an entity (held
. in the first byte of its record), by using #R$9E89.
E $9E96 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$857F }
. { #SABREWULF$B934 }
. { #UNDERWURLDE$9652 }
. LIST#
R $9E96 IX The entity
R $9E96 O:DE The sprite address
  $9E96,$03 #REGa=the sprite ID from *#REGix+#N$00.
  $9E99,$02 Jump to #R$9E89 to fetch the sprite.

c $9E9B XOR Sprite Loop
@ $9E9B label=XORSpriteLoop
D $9E9B XORs the old sprite and the new sprite onto the screen one row at a
. time, working up from the bottom row. The row counters are in #REGc and
. #REGc' (in the normal and the shadow register sets), and each register set
. holds the screen address in #REGhl and the sprite data address in #REGde for
. one of the two sprites. When the counters run out, any rows left over in
. #R$5E18 and #R$5E19 are drawn.
.
. Drawing a sprite a second time erases it, so the old sprite is removed
. from where it was and the new sprite is drawn where it is now.
E $9E9B View the equivalent code in;
. #LIST
. { #COOKIE$763A }
. { #SABREWULF$B9DA }
. { #UNDERWURLDE$9728 }
. LIST#
  $9E9B,$01 Fetch the number of rows of the old sprite that are left.
  $9E9C,$03 Jump to #R$9EAF if there are no rows of the old sprite left to draw.
  $9E9F,$01 Decrease the row counter by one.
  $9EA0,$03 Call #R$9EDC to draw the old sprite row.
  $9EA3,$01 Switch to the shadow registers.
  $9EA4,$01 Fetch the number of rows of the new sprite that are left.
  $9EA5,$03 Jump to #R$9EAC if there are no rows of the new sprite left to draw.
@ $9EA8 label=XORSpriteLoop_Actor
  $9EA8,$01 Decrease the row counter by one.
  $9EA9,$03 Call #R$9F21 to draw the new sprite row.
@ $9EAC label=XORSpriteLoop_Next
  $9EAC,$01 Switch to the normal registers.
  $9EAD,$02 Jump to #R$9E9B to draw the sprites onto the screen.
@ $9EAF label=XORSpriteLoop_Swap
  $9EAF,$01 Switch to the shadow registers.
  $9EB0,$01 Fetch the number of rows of the new sprite that are left.
  $9EB1,$03 Jump to #R$9EA8 if there are more rows of the new sprite to draw.
@ $9EB4 label=XORSpriteLoop_Restore
  $9EB4,$01 Switch to the normal registers.
@ $9EB5 label=XORSpriteLoop_Remaining
N $9EB5 Fetch the number of rows left over from the old sprite and the new
. sprite. If there are none then the drawing is finished.
  $9EB5,$04 Fetch the number of old sprite rows from #R$5E18 and keep it in
. #REGc.
  $9EB9,$03 Fetch the number of new sprite rows from #R$5E19.
  $9EBC,$02 Return if there are no rows left to draw.
  $9EBE,$01 #REGa=#N$00.
  $9EBF,$03 Update the number of old sprite rows in #R$5E18.
  $9EC2,$01 Switch to the shadow registers.
  $9EC3,$04 Fetch the number of new sprite rows from #R$5E19 and keep it in
. #REGc.
  $9EC7,$01 #REGa=#N$00.
@ $9EC8 label=XORSpriteLoop_Continue
  $9EC8,$03 Update the number of new sprite rows in #R$5E19.
  $9ECB,$01 Switch to the normal registers.
  $9ECC,$02 Jump to #R$9E9B to draw the sprites onto the screen.

c $9ECE Draw Old Sprite Row
@ $9ECE label=DrawOldSpriteRow_Aligned
D $9ECE XORs one row of the old sprite onto the screen, then moves up to the
. row above. The row is two bytes of graphic data, which are written to two
. bytes of the screen when the sprite is aligned to a character cell, and
. otherwise are shifted along and written to three bytes.
R $9ECE DE The address of the row of sprite data
R $9ECE HL The screen address
R $9ECE O:DE The address of the next row of sprite data
R $9ECE O:HL The screen address of the row above
N $9ECE The entry point for a sprite which is aligned to a character cell.
. #R$9EE4 jumps here when the shift is the one which does nothing.
  $9ECE,$01 #REGde=the row of sprite data, and #REGhl=the address of the next
. row.
  $9ECF,$01 Fetch the screen address, and the address of the next row of sprite
. data is stored on the stack.
  $9ED0,$01 Fetch the first byte of the row.
  $9ED1,$01 Exclusive OR it onto the screen.
  $9ED2,$01 Write the result to the screen.
  $9ED3,$01 Move to the next byte on the screen.
  $9ED4,$01 Fetch the second byte of the row.
  $9ED5,$01 Exclusive OR it onto the screen.
  $9ED6,$01 Write the result to the screen.
  $9ED7,$01 Fetch the address of the next row of sprite data.
  $9ED8,$01 Move back to the first byte on the screen.
  $9ED9,$03 Jump to #R$9F03 to move up one pixel row.
@ $9EDC label=DrawOldSpriteRow
N $9EDC The entry point for a sprite which is not aligned to a character cell.
  $9EDC,$01 #REGhl=the address of the sprite data, and #REGde=the screen
. address.
  $9EDD,$01 Stash the screen address on the stack.
  $9EDE,$01 Fetch the first byte of the row.
  $9EDF,$01 Move to the next byte of sprite data.
  $9EE0,$01 Fetch the second byte of the row.
  $9EE1,$01 Move on to the next row of sprite data.
  $9EE2,$01 #REGhl=the row of sprite data, and #REGde=the address of the next
. row.
  $9EE3,$01 #REGa=#N$00.
@ $9EE4 label=DrawOldSpriteRow_Shift
N $9EE4 Self modifying code; the operand of this command is written by
. #R$9F83(#N$9F91). It jumps into the run of shifts below so that the row is
. moved the right number of pixels, or to #R$9ECE for a sprite which does not
. need to be shifted.
  $9EE4,$02 Jump to the first shift to do.
N $9EE6 Shift the row left by up to seven bits; the bits which are shifted out
. of the row end up in #REGa.
  $9EE6,$0E Shift #REGhl left by one, moving the bit shifted out into #REGa
. (seven times).
  $9EF4,$01 #REGde=the shifted row, and #REGhl=the address of the next row of
. sprite data.
  $9EF5,$01 Fetch the screen address, and the address of the next row of sprite
. data is stored on the stack.
  $9EF6,$01 Exclusive OR the first byte (in #REGa) onto the screen.
  $9EF7,$01 Write the result to the screen.
  $9EF8,$01 Move to the next byte on the screen.
@ $9EF9 label=DrawSpriteRow_Write
N $9EF9 XOR the other two bytes onto the screen. #R$9F21 also finishes here.
  $9EF9,$01 Fetch the second byte.
  $9EFA,$01 Exclusive OR it onto the screen.
  $9EFB,$01 Write the result to the screen.
  $9EFC,$01 Move to the next byte on the screen.
  $9EFD,$01 Fetch the third byte.
  $9EFE,$01 Exclusive OR it onto the screen.
  $9EFF,$01 Write the result to the screen.
  $9F00,$01 Fetch the address of the next row of sprite data.
  $9F01,$02 Move back to the first byte on the screen.

c $9F03 Screen Address One Pixel Above
@ $9F03 label=ScreenPosition1PixelAbove
D $9F03 Moves a screen address up by one pixel row, allowing for the layout of
. the screen. The XOR sprite row routines continue here so that they finish
. with the screen address of the row above the one just drawn.
E $9F03 View the equivalent code in;
. #LIST
. { #CYBERUN$A1C3 }
. { #LUNARJETMAN$85F6 }
. { #PSSST$7585 }
. { #TRANZAM$6ECB }
. { #UNDERWURLDE$AE71 }
. LIST#
R $9F03 HL The screen address
R $9F03 O:HL The screen address one pixel row above
  $9F03,$01 Decrease #REGh by one to move up one pixel row within the character
. cell.
  $9F04,$01 #REGa=#REGh.
  $9F05,$01 Flip the bits.
  $9F06,$02,b$01 Keep only bits 0-2.
  $9F08,$01 Return if still inside the same character cell.
  $9F09,$01 #REGa=#REGl.
  $9F0A,$02 Subtract #N$20 to move up a character row.
  $9F0C,$01 #REGl=#REGa.
  $9F0D,$01 Return if that moved into the previous third of the screen (the
. address is then already correct).
  $9F0E,$01 #REGa=#REGh.
  $9F0F,$02 Add #N$08.
  $9F11,$01 #REGh=#REGa.
  $9F12,$01 Return.

c $9F13 Draw Actor Sprite Row
@ $9F13 label=DrawActorSpriteRow_Aligned
D $9F13 Does the same as #R$9ECE, but for the sprite prepared by #R$9FA2 (the
. new sprite).
R $9F13 DE The address of the row of sprite data
R $9F13 HL The screen address
R $9F13 O:DE The address of the next row of sprite data
R $9F13 O:HL The screen address of the row above
N $9F13 The entry point for a sprite which is aligned to a character cell.
. #R$9F29 jumps here when the shift is the one which does nothing.
  $9F13,$01 #REGde=the row of sprite data, and #REGhl=the address of the next
. row.
  $9F14,$01 Fetch the screen address, and the address of the next row of sprite
. data is stored on the stack.
  $9F15,$01 Fetch the first byte of the row.
  $9F16,$01 Exclusive OR it onto the screen.
  $9F17,$01 Write the result to the screen.
  $9F18,$01 Move to the next byte on the screen.
  $9F19,$01 Fetch the second byte of the row.
  $9F1A,$01 Exclusive OR it onto the screen.
  $9F1B,$01 Write the result to the screen.
  $9F1C,$01 Fetch the address of the next row of sprite data.
  $9F1D,$01 Move back to the first byte on the screen.
  $9F1E,$03 Jump to #R$9F03 to move up one pixel row.
@ $9F21 label=DrawActorSpriteRow
N $9F21 The entry point for a sprite which is not aligned to a character cell.
  $9F21,$01 #REGhl=the address of the sprite data, and #REGde=the screen
. address.
  $9F22,$01 Stash the screen address on the stack.
  $9F23,$01 Fetch the first byte of the row.
  $9F24,$01 Move to the next byte of sprite data.
  $9F25,$01 Fetch the second byte of the row.
  $9F26,$01 Move on to the next row of sprite data.
  $9F27,$01 #REGhl=the row of sprite data, and #REGde=the address of the next
. row.
  $9F28,$01 #REGa=#N$00.
@ $9F29 label=DrawActorSpriteRow_Shift
N $9F29 Self modifying code; the operand of this command is written by
. #R$9FA2(#N$9FB3). It jumps into the run of shifts below so that the row is
. moved the right number of pixels, or to #R$9F13 for a sprite which does not
. need to be shifted.
  $9F29,$02 Jump to the first shift to do.
N $9F2B Shift the row left by up to seven bits; the bits which are shifted out
. of the row end up in #REGa.
  $9F2B,$0E Shift #REGhl left by one, moving the bit shifted out into #REGa
. (seven times).
  $9F39,$01 #REGde=the shifted row, and #REGhl=the address of the next row of
. sprite data.
  $9F3A,$01 Fetch the screen address, and the address of the next row of sprite
. data is stored on the stack.
  $9F3B,$01 Exclusive OR the first byte (in #REGa) onto the screen.
  $9F3C,$01 Write the result to the screen.
  $9F3D,$01 Move to the next byte on the screen.
  $9F3E,$02 Jump to #R$9EF9 to XOR the other two bytes onto the screen.

u $9F40 Unused Sprite Entry Points
@ $9F40 label=Unused_SpriteEntryPoints
D $9F40 Not used by the game. These are versions of #R$9F4A and #R$9F56 which
. skip the code that finds the data for the sprite, for use when #REGde already
. holds the address of the sprite data.
N $9F40 Draws the sprite of the entity, without fetching the sprite data.
C $9F40,$03 Call #R$9FA2 (part of #R$9F9F).
C $9F43,$02 Jump to #R$9F4D.
N $9F45 Erases the sprite at the recorded position, without fetching the
. sprite data.
C $9F45,$03 Call #R$9F83 (part of #R$9F80).
C $9F48,$02 Jump to #R$9F59.

c $9F4A Draw Entity
@ $9F4A label=DrawEntity
D $9F4A Draws the sprite of an entity at its position. Only the pixels are
. drawn; the attributes are set by #R$A00E.
. The old sprite is given no rows, so only the new sprite is drawn.
E $9F4A View the equivalent code in;
. #LIST
. { #COOKIE$7617 }
. { #SABREWULF$B919 }
. { #TRANZAM$7149 }
. { #UNDERWURLDE$962A }
. LIST#
R $9F4A IX The entity
N $9F4A #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SCR$04,$0C,$0A,$05,$05(draw-entity-before)
. | #SIM(start=$9F4A,stop=$0000,ix=$EAC0,sp=$5B60)
. #SCR$04,$0C,$0A,$05,$05(draw-entity-after) } UDGTABLE# #POPS
  $9F4A,$03 Prepare the sprite of the entity with #R$9F9F.
@ $9F4D label=DrawEntity_Prepared
  $9F4D,$01 Switch to the shadow registers.
  $9F4E,$04 Write #N$00 to #R$5E18.
  $9F52,$01 Keep zero as the number of rows of the old sprite in #REGc.
  $9F53,$03 Jump to #R$9E9B to draw the sprites onto the screen.

c $9F56 Remove Entity
@ $9F56 label=RemoveEntity
D $9F56 Removes the image of an entity that was saved by #R$9FFB, by
. drawing it again (sprites are XORed onto the screen).
E $9F56 View the equivalent code in;
. #LIST
. { #SABREWULF$B8F5 }
. { #TRANZAM$7139 }
. { #UNDERWURLDE$9636 }
. LIST#
R $9F56 IX The entity
N $9F56 #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SIM(start=$9F4A,stop=$0000,ix=$EAC0,sp=$5B60)
. #SIM(start=$A00E,stop=$0000,ix=$EAC0,sp=$5B60)
. #SIM(start=$9FFB,stop=$0000,ix=$EAC0,sp=$5B60)
. #SCR$04,$0C,$0A,$05,$05(remove-entity-before)
. | #SIM(start=$9F56,stop=$0000,ix=$EAC0,sp=$5B60)
. #SCR$04,$0C,$0A,$05,$05(remove-entity-after) } UDGTABLE# #POPS
  $9F56,$03 Prepare the old sprite with #R$9F80.
@ $9F59 label=RemoveEntity_Prepared
  $9F59,$01 Switch to the shadow registers.
  $9F5A,$01 #REGa=#N$00.
  $9F5B,$01 Keep zero as the number of rows of the new sprite in #REGc.
  $9F5C,$03 Update the number of new sprite rows in #R$5E19.
  $9F5F,$03 Fetch the number of old sprite rows from #R$5E18.
  $9F62,$03 Update the sprite height in #R$5E11.
N $9F65 Work out the width of the sprite in bytes. The code uses #REGl from the
. shadow registers, which holds whatever an earlier routine left there.
  $9F65,$01 #REGa=#REGl.
  $9F66,$02,b$01 Keep only bits 0-2.
  $9F68,$02 #REGa=#N$02.
  $9F6A,$02 Jump to #R$9F6D if bits 0-2 were zero.
  $9F6C,$01 #REGa=#N$03.
@ $9F6D label=RemoveEntity_Width
  $9F6D,$03 Write the width to #R$5E10.
  $9F70,$01 Switch to the normal registers.
  $9F71,$03 Jump to #R$9E9B to draw the sprites onto the screen.

u $9F74 Unused Move Sprite Without Fetch
@ $9F74 label=Unused_MoveSprite_NoFetch
D $9F74 Not used by the game. It is like #R$9FCA, but skips the code which
. finds the data for the sprites (#R$9E86 and #R$9E96), by entering the
. routines which prepare the sprites after that code. It then carries on at
. #R$9FD1.
C $9F74,$01 Stash #REGde on the stack.
C $9F75,$03 Call #R$9F83 (part of #R$9F80).
C $9F78,$01 Switch to the shadow registers.
C $9F79,$01 Restore #REGde from the stack.
C $9F7A,$03 Call #R$9FA2 (part of #R$9F9F).
C $9F7D,$01 Switch to the normal registers.
C $9F7E,$02 Jump to #R$9FD1.

c $9F80 Prepare Draw 2/ 3 Byte Sprite
@ $9F80 label=PrepDraw23
D $9F80 Gets everything ready to draw (or erase) the sprite at the position
. which was last recorded by #R$9FFB. Sprites are drawn using the exclusive OR
. operation, so drawing a sprite for a second time erases it.
.
. The number of rows to draw is written to #R$5E18, and the shifting routine at
. #R$9ECE is set up to move the sprite along by the position MOD #N$08 pixels.
E $9F80 View the equivalent code in;
. #LIST
. { #SABREWULF$B939 }
. { #UNDERWURLDE$9657 }
. LIST#
R $9F80 O:C #N$00
R $9F80 O:DE The address of the first row of sprite data to draw
R $9F80 O:HL The screen address of the bottom row of the sprite
  $9F80,$03 Fetch the address of the old sprite with #R$9E86.
@ $9F83 label=PrepDraw23_NoFetch
  $9F83,$03 #REGhl=#R$5E16 (the saved X position in #REGl and the saved Y
. position in #REGh).
  $9F86,$01 Fetch the X position.
  $9F87,$01 Decrease #REGa by one.
  $9F88,$01 Multiply by #N$02.
  $9F89,$02,b$01 Keep only bits 1-3.
  $9F8B,$04 Jump to #R$9F91 if this is not the maximum offset.
  $9F8F,$02 Use the offset which jumps to the code for sprites which are aligned
. to a character cell.
@ $9F91 label=PrepDraw23_Shift
N $9F91 Self modifying code; this updates the operand of the JR command at
. #R$9EE4(#N$9EE5).
  $9F91,$03 Write the offset to #R$9EE4(#N$9EE5).
  $9F94,$03 Call #R$9BA2 to get the screen address of the position.
  $9F97,$01 Fetch the number of rows in the sprite (the first byte of the sprite
. data).
  $9F98,$03 Write the number of rows to #R$5E18.
@ $9F9B label=PrepDraw23_Finish
  $9F9B,$02 #REGc=#N$00.
  $9F9D,$01 Move past the height byte.
  $9F9E,$01 Return.

c $9F9F Prepare Draw 2 Byte Sprite
@ $9F9F label=PrepDraw2
D $9F9F Does the same as #R$9F80 for the sprite of the entity in #REGix (the new
. sprite). As well as the screen address, it records the width of the sprite in
. bytes in #R$5E10, the number of rows to draw in #R$5E19 and its height in
. #R$5E11. The shifting routine at #R$9F13 is set up for it.
E $9F9F View the equivalent code in;
. #LIST
. { #SABREWULF$B969 }
. { #UNDERWURLDE$9689 }
. LIST#
R $9F9F IX The entity
R $9F9F O:C #N$00
R $9F9F O:DE The address of the first row of sprite data to draw
R $9F9F O:HL The screen address of the bottom row of the sprite
  $9F9F,$03 Fetch the address of the sprite of the entity with #R$9E96.
@ $9FA2 label=PrepDraw2_NoFetch
  $9FA2,$06 #REGl=the entity X position, and #REGh=the entity Y position.
  $9FA8,$01 Fetch the X position.
  $9FA9,$01 Decrease #REGa by one.
  $9FAA,$01 Multiply by #N$02.
  $9FAB,$02,b$01 Keep only bits 1-3.
  $9FAD,$04 Jump to #R$9FB3 if this is not the maximum offset.
  $9FB1,$02 Use the offset which jumps to the code for sprites which are aligned
. to a character cell.
@ $9FB3 label=PrepDraw2_Shift
N $9FB3 Self modifying code; this updates the operand of the JR command at
. #R$9F29(#N$9F2A).
  $9FB3,$03 Write the offset to #R$9F29(#N$9F2A).
N $9FB6 A sprite which is aligned to a character cell is two bytes wide,
. otherwise it is three bytes wide.
  $9FB6,$02 #REGa=#N$02.
  $9FB8,$02 Jump to #R$9FBB if the offset was the maximum offset.
  $9FBA,$01 #REGa=#N$03.
@ $9FBB label=PrepDraw2_Width
  $9FBB,$03 Write the width to #R$5E10.
  $9FBE,$03 Call #R$9BA2 to get the screen address of the position.
  $9FC1,$01 Fetch the number of rows in the sprite (the first byte of the sprite
. data).
  $9FC2,$03 Write the number of rows to #R$5E19.
  $9FC5,$03 Write the number of rows to #R$5E11.
  $9FC8,$02 Jump to #R$9F9B to finish preparing the sprite.

c $9FCA Display Entity
@ $9FCA label=DisplayEntity
D $9FCA Erases the sprite from the position recorded by #R$9FFB and draws it at
. the new position held by the entity. The old and the new sprite are processed
. together so that the screen lines which they share are updated in step.
E $9FCA View the equivalent code in;
. #LIST
. { #COOKIE$75CC }
. { #JETPAC$726A }
. { #SABREWULF$B9A9 }
. { #TRANZAM$7101 }
. { #UNDERWURLDE$96F7 }
. LIST#
R $9FCA IX The entity
  $9FCA,$03 Prepare the new sprite with #R$9F9F.
  $9FCD,$01 Switch to the shadow registers.
  $9FCE,$03 Prepare the old sprite with #R$9F80.
@ $9FD1 label=DisplayEntity_Compare
N $9FD1 Compare the vertical position of the old sprite with the new one.
  $9FD1,$03 Fetch the previous Y position from #R$5E17.
  $9FD4,$03 Subtract the new vertical position.
  $9FD7,$03 Jump to #R$9EB5 if they are the same.
  $9FDA,$03 Jump to #R$9FEC if the new sprite is lower down the screen.
N $9FDD The old sprite is lower down. Draw the rows of it which the new sprite
. does not cover first.
  $9FDD,$01 Fetch the number of rows.
  $9FDE,$03 Fetch the number of old sprite rows from #R$5E18.
  $9FE1,$04 Jump to #R$9EB5 if the sprites do not overlap.
  $9FE5,$01 Subtract the rows which are about to be drawn.
  $9FE6,$03 Write the number of rows remaining to #R$5E18.
  $9FE9,$03 Jump to #R$9E9B to draw the sprites onto the screen.
@ $9FEC label=DisplayEntity_NewLower
N $9FEC The new sprite is lower down. Draw the rows of it which the old sprite
. does not cover first.
  $9FEC,$01 Switch to the shadow registers.
  $9FED,$02 Make the number of rows positive.
  $9FEF,$01 Fetch the number of rows.
  $9FF0,$03 Fetch the number of new sprite rows from #R$5E19.
  $9FF3,$04 Jump to #R$9EB4 if the sprites do not overlap.
  $9FF7,$01 Subtract the rows which are about to be drawn.
  $9FF8,$03 Jump to #R$9EC8 to write the number of rows remaining to #R$5E19.

c $9FFB Store Entity
@ $9FFB label=StoreEntity
D $9FFB Saves the position and sprite ID of an entity so that #R$9F56 and
. #R$A01A can use them after the entity has moved.
E $9FFB View the equivalent code in;
. #LIST
. { #JETPAC$7327 }
. { #PSSST$75B9 }
. { #SABREWULF$BB0B }
. { #TRANZAM$71ED }
. { #UNDERWURLDE$989F }
. LIST#
R $9FFB IX The entity
  $9FFB,$06 Write the entity X position to #R$5E16.
  $A001,$06 Write the entity Y position to #R$5E17.
  $A007,$06 Write the entity sprite ID to #R$5E15.
  $A00D,$01 Return.

c $A00E Set Entity Attributes
@ $A00E label=SetEntityAttributes
D $A00E Colours the attribute cells under an entity. This entry point first
. saves the position of the entity as if it has not moved; #R$A01A
. instead uses the position saved by #R$9FFB to work out which way the
. entity has moved.
.
. The cells under the entity are set to the attribute of the entity, and the
. cells which the entity has just left behind are put back to the attribute of
. the room (from #R$5E1A). Which way the entity has moved picks one of the
. routines in the table at #R$A064, and that routine is jumped to with the
. registers set up as follows:
. #TABLE(default,centre,left)
. { =h Register | =h Contents }
. { #REGb | The width of the sprite in cells }
. { #REGc | The number of rows of cells }
. { #REGd | The attribute of the entity }
. { #REGe | The attribute of the room }
. { #REGhl | The attribute address of the cell holding the position of the
. entity (the cell at the bottom left) }
. TABLE#
R $A00E IX The entity to colour
N $A00E #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SIM(start=$9F4A,stop=$0000,ix=$EAC0,sp=$5B60)
. #SCR$04,$0C,$0A,$05,$05(set-attributes-before)
. | #SIM(start=$A00E,stop=$0000,ix=$EAC0,sp=$5B60)
. #SCR$04,$0C,$0A,$05,$05(set-attributes-after) } UDGTABLE# #POPS
  $A00E,$06 Write the entity X position to #R$5E16.
  $A014,$06 Write the entity Y position to #R$5E17.
@ $A01A label=SetEntityAttributes_Moved
N $A01A Get the entity position, attribute and the room attribute.
  $A01A,$06 #REGl=the entity X position, and #REGh=the entity Y position.
  $A020,$03 Fetch the attribute of the entity.
  $A023,$04 #REGe=the room attribute from #R$5E1A.
  $A027,$04 #REGb=the width of the sprite from #R$5E10.
N $A02B Work out the number of rows of cells from the height of the sprite in
. pixels.
  $A02B,$03 #REGa=the height of the sprite from #R$5E11.
  $A02E,$02 Divide by #N$04.
  $A030,$01 Increment #REGa by one.
  $A031,$01 Divide by #N$02.
  $A032,$02,b$01 Keep only bits 0-4.
  $A034,$01 Increment #REGa by one.
  $A035,$01 Keep the number of rows of cells in #REGc.
N $A036 Work out which way the entity has moved. The horizontal movement gives
. #N$00 (none), #N$01 (right) or #N$02 (left), and the vertical movement adds
. #N$00 (none), #N$04 (down) or #N$08 (up).
  $A036,$01 Stash the width and the number of rows on the stack.
  $A037,$02 #REGb=#N$00 (the direction so far, which is no movement).
  $A039,$03 Fetch the previous X position from #R$5E16.
  $A03C,$03 Jump to #R$A043 if the X position is unchanged.
  $A03F,$02 Jump to #R$A042 if the entity has moved right.
  $A041,$01 Add #N$01 to #REGb (the entity has moved left).
@ $A042 label=SetEntityAttributes_Right
  $A042,$01 Add #N$01 to #REGb.
@ $A043 label=SetEntityAttributes_Vertical
  $A043,$03 Fetch the previous Y position from #R$5E17.
  $A046,$01 Compare the saved Y position against #REGh.
  $A047,$01 Fetch the horizontal direction from #REGb.
  $A048,$02 Jump to #R$A050 if the Y position is unchanged.
  $A04A,$02 Jump to #R$A04E if the entity has moved down.
  $A04C,$02 Add #N$04 to #REGa (the entity has moved up).
@ $A04E label=SetEntityAttributes_Down
  $A04E,$02 Add #N$04 to #REGa.
@ $A050 label=SetEntityAttributes_Select
  $A050,$01 Stash the direction in #REGb.
  $A051,$03 Call #R$9BD2 to get the attribute address of the position.
  $A054,$01 Restore the direction into #REGa.
  $A055,$01 Restore the width and the number of rows from the stack.
  $A056,$01 Stash the attribute address on the stack.
  $A057,$03 Point #REGhl at the attribute jump table at #R$A064.
  $A05A,$02 Multiply the direction by #N$02, as the table contains addresses.
  $A05C,$03 Call #R$926C to add it to the address of the table.
  $A05F,$04 Fetch the routine selected from the table.
  $A063,$01 Jump to the routine.

w $A064 Attribute Jump Table
@ $A064 label=AttributeJumpTable
D $A064 The routines which colour the attribute cells under an entity, chosen
. by #R$A01A from the way the entity has moved. The direction is the
. horizontal movement plus the vertical movement.
. #TABLE(default,centre,left,left)
. { =h Direction | =h Movement | =h Routine }
. { #N$00 | Unchanged | #R$A07A }
. { #N$01 | Right | #R$A08D }
. { #N$02 | Left | #R$A0A3 }
. { #N$03 | (not possible) | #R$807A }
. { #N$04 | Down | #R$A0B7 }
. { #N$05 | Down and right | #R$A0D2 }
. { #N$06 | Down and left | #R$A110 }
. { #N$07 | (not possible) | #R$807A }
. { #N$08 | Up | #R$A0EC }
. { #N$09 | Up and right | #R$A127 }
. { #N$0A | Up and left | #R$A0FE }
. TABLE#
W $A064,$16,$02

c $A07A Draw Attributes Unchanged
@ $A07A label=AttrDrawUnchanged
D $A07A The attribute routine for an entity which has not moved. Every cell
. under the entity is set to the attribute of the entity, a row at a time
. working up from the bottom row.
R $A07A B The width of the sprite in cells
R $A07A C The number of rows of cells
R $A07A D The attribute of the entity
R $A07A E The attribute of the room
  $A07A,$01 Restore the attribute address from the stack.
@ $A07B label=AttrDrawUnchanged_Row
  $A07B,$01 Stash the width and the number of rows on the stack.
  $A07C,$01 Stash the attribute address on the stack.
@ $A07D label=AttrDrawUnchanged_Cell
  $A07D,$01 Write the attribute of the entity to the cell.
  $A07E,$01 Move to the next cell.
  $A07F,$02 Decrease the width by one and loop back to #R$A07D until the row is
. done.
  $A081,$01 Restore the attribute address from the stack.
  $A082,$03 #REGbc=#N($0020,$04,$04).
  $A085,$03 Move up a row.
  $A088,$01 Restore the width and the number of rows from the stack.
  $A089,$03 Decrease the number of rows by one and loop back to #R$A07B until
. all of the rows have been set.
  $A08C,$01 Return.

c $A08D Draw Attributes Moving Right
@ $A08D label=AttrDrawMovingRight
D $A08D The attribute routine for an entity which has moved right. Each row of
. cells under the entity is set to the attribute of the entity, and the cell
. just to the left of it (which the entity has left) is put back to the
. attribute of the room.
R $A08D B The width of the sprite in cells
R $A08D C The number of rows of cells
R $A08D D The attribute of the entity
R $A08D E The attribute of the room
  $A08D,$01 Restore the attribute address from the stack.
@ $A08E label=AttrDrawMovingRight_Row
  $A08E,$01 Stash the width and the number of rows on the stack.
  $A08F,$01 Stash the attribute address on the stack.
  $A090,$01 Move to the cell on the left.
  $A091,$01 Write the attribute of the room to the cell.
  $A092,$01 Move back to the first cell.
@ $A093 label=AttrDrawMovingRight_Cell
  $A093,$01 Write the attribute of the entity to the cell.
  $A094,$01 Move to the next cell.
  $A095,$02 Decrease the width by one and loop back to #R$A093 until the row is
. done.
  $A097,$01 Restore the attribute address from the stack.
  $A098,$03 #REGbc=#N($0020,$04,$04).
  $A09B,$03 Move up a row.
  $A09E,$01 Restore the width and the number of rows from the stack.
  $A09F,$03 Decrease the number of rows by one and loop back to #R$A08E until
. all of the rows have been set.
  $A0A2,$01 Return.

c $A0A3 Draw Attributes Moving Left
@ $A0A3 label=AttrDrawMovingLeft
D $A0A3 The attribute routine for an entity which has moved left. Each row of
. cells under the entity is set to the attribute of the entity, and the cell
. just to the right of it (which the entity has left) is put back to the
. attribute of the room.
R $A0A3 B The width of the sprite in cells
R $A0A3 C The number of rows of cells
R $A0A3 D The attribute of the entity
R $A0A3 E The attribute of the room
  $A0A3,$01 Restore the attribute address from the stack.
@ $A0A4 label=AttrDrawMovingLeft_Row
  $A0A4,$01 Stash the width and the number of rows on the stack.
  $A0A5,$01 Stash the attribute address on the stack.
@ $A0A6 label=AttrDrawMovingLeft_Cell
  $A0A6,$01 Write the attribute of the entity to the cell.
  $A0A7,$01 Move to the next cell.
  $A0A8,$02 Decrease the width by one and loop back to #R$A0A6 until the row is
. done.
  $A0AA,$01 Write the attribute of the room to the cell on the right.
  $A0AB,$01 Restore the attribute address from the stack.
  $A0AC,$03 #REGbc=#N($0020,$04,$04).
  $A0AF,$03 Move up a row.
  $A0B2,$01 Restore the width and the number of rows from the stack.
  $A0B3,$03 Decrease the number of rows by one and loop back to #R$A0A4 until
. all of the rows have been set.
  $A0B6,$01 Return.

c $A0B7 Draw Attributes Moving Down
@ $A0B7 label=AttrDrawMovingDown
D $A0B7 The attribute routine for an entity which has moved down. Each row of
. cells under the entity is set to the attribute of the entity, and the row
. just above it (which the entity has left) is put back to the attribute of the
. room.
R $A0B7 B The width of the sprite in cells
R $A0B7 C The number of rows of cells
R $A0B7 D The attribute of the entity
R $A0B7 E The attribute of the room
  $A0B7,$01 Restore the attribute address from the stack.
@ $A0B8 label=AttrDrawMovingDown_Row
  $A0B8,$01 Stash the width and the number of rows on the stack.
  $A0B9,$01 Stash the attribute address on the stack.
@ $A0BA label=AttrDrawMovingDown_Cell
  $A0BA,$01 Write the attribute of the entity to the cell.
  $A0BB,$01 Move to the next cell.
  $A0BC,$02 Decrease the width by one and loop back to #R$A0BA until the row is
. done.
  $A0BE,$01 Restore the attribute address from the stack.
  $A0BF,$03 #REGbc=#N($0020,$04,$04).
  $A0C2,$03 Move up a row.
  $A0C5,$01 Restore the width and the number of rows from the stack.
  $A0C6,$03 Decrease the number of rows by one and loop back to #R$A0B8 until
. all of the rows have been set.
@ $A0C9 label=AttrDrawMovingDown_Above
N $A0C9 Put the row above the entity back to the attribute of the room, unless
. it is above the start of the attributes.
  $A0C9,$01 Fetch the high byte of the attribute address.
  $A0CA,$03 Return if the row is above the start of the attributes.
@ $A0CD label=AttrDrawMovingDown_Restore
  $A0CD,$01 Write the attribute of the room to the cell.
  $A0CE,$01 Move to the next cell.
  $A0CF,$02 Decrease the width by one and loop back to #R$A0CD until the row is
. done.
  $A0D1,$01 Return.

c $A0D2 Draw Attributes Moving Down-Right
@ $A0D2 label=AttrDrawMovingDownRight
D $A0D2 The attribute routine for an entity which has moved down and right.
. Each row of cells under the entity is set to the attribute of the entity, and
. the cell to the left of it is put back to the attribute of the room. So is
. the row above the entity, from one cell to the left of the entity.
R $A0D2 B The width of the sprite in cells
R $A0D2 C The number of rows of cells
R $A0D2 D The attribute of the entity
R $A0D2 E The attribute of the room
  $A0D2,$01 Restore the attribute address from the stack.
@ $A0D3 label=AttrDrawMovingDownRight_Row
  $A0D3,$01 Stash the width and the number of rows on the stack.
  $A0D4,$01 Stash the attribute address on the stack.
  $A0D5,$01 Move to the cell on the left.
  $A0D6,$01 Write the attribute of the room to the cell.
  $A0D7,$01 Move back to the first cell.
@ $A0D8 label=AttrDrawMovingDownRight_Cell
  $A0D8,$01 Write the attribute of the entity to the cell.
  $A0D9,$01 Move to the next cell.
  $A0DA,$02 Decrease the width by one and loop back to #R$A0D8 until the row is
. done.
  $A0DC,$01 Restore the attribute address from the stack.
  $A0DD,$03 #REGbc=#N($0020,$04,$04).
  $A0E0,$03 Move up a row.
  $A0E3,$01 Restore the width and the number of rows from the stack.
  $A0E4,$03 Decrease the number of rows by one and loop back to #R$A0D3 until
. all of the rows have been set.
  $A0E7,$01 Move to the cell on the left in the row above.
  $A0E8,$01 Write the attribute of the room to the cell.
  $A0E9,$01 Move back to the first cell.
  $A0EA,$02 Jump to #R$A0C9 to put the row above back to the attribute of the
. room.

c $A0EC Draw Attributes Moving Up
@ $A0EC label=AttrDrawMovingUp
D $A0EC The attribute routine for an entity which has moved up. The row just
. below the entity (which the entity has left) is put back to the attribute of
. the room, then each row of cells under the entity is set to the attribute of
. the entity.
R $A0EC B The width of the sprite in cells
R $A0EC C The number of rows of cells
R $A0EC D The attribute of the entity
R $A0EC E The attribute of the room
  $A0EC,$01 Restore the attribute address from the stack.
  $A0ED,$01 Stash the width and the number of rows on the stack.
  $A0EE,$01 Stash the attribute address on the stack.
  $A0EF,$01 Stash the width and the number of rows on the stack again.
  $A0F0,$03 #REGbc=#N($0020,$04,$04).
  $A0F3,$01 Move down a row.
  $A0F4,$01 Restore the width.
@ $A0F5 label=AttrDrawMovingUp_Cell
  $A0F5,$01 Write the attribute of the room to the cell.
  $A0F6,$01 Move to the next cell.
  $A0F7,$02 Decrease the width by one and loop back to #R$A0F5 until the row is
. done.
  $A0F9,$01 Restore the attribute address from the stack.
  $A0FA,$01 Restore the width and the number of rows from the stack.
  $A0FB,$03 Jump to #R$A07B to set the cells under the entity.

c $A0FE Draw Attributes Moving Up-Left
@ $A0FE label=AttrDrawMovingUpLeft
D $A0FE The attribute routine for an entity which has moved up and left. The
. row just below the entity, and one more cell to the right, is put back to the
. attribute of the room. Then each row of cells under the entity is set to the
. attribute of the entity, with the cell to the right of it put back to the
. attribute of the room.
R $A0FE B The width of the sprite in cells
R $A0FE C The number of rows of cells
R $A0FE D The attribute of the entity
R $A0FE E The attribute of the room
  $A0FE,$01 Restore the attribute address from the stack.
  $A0FF,$01 Stash the width and the number of rows on the stack.
  $A100,$01 Stash the attribute address on the stack.
  $A101,$01 Stash the width and the number of rows on the stack again.
  $A102,$03 #REGbc=#N($0020,$04,$04).
  $A105,$01 Move down a row.
  $A106,$01 Restore the width.
  $A107,$01 Add one more cell to the width.
@ $A108 label=AttrDrawMovingUpLeft_Cell
  $A108,$01 Write the attribute of the room to the cell.
  $A109,$01 Move to the next cell.
  $A10A,$02 Decrease the width by one and loop back to #R$A108 until the row is
. done.
  $A10C,$01 Restore the attribute address from the stack.
  $A10D,$01 Restore the width and the number of rows from the stack.
  $A10E,$02 Jump to #R$A0A4 to set the cells under the entity.

c $A110 Draw Attributes Moving Down-Left
@ $A110 label=AttrDrawMovingDownLeft
D $A110 The attribute routine for an entity which has moved down and left. Each
. row of cells under the entity is set to the attribute of the entity, and the
. cell to the right of it is put back to the attribute of the room. So is the
. row above the entity, with one more cell to the right.
R $A110 B The width of the sprite in cells
R $A110 C The number of rows of cells
R $A110 D The attribute of the entity
R $A110 E The attribute of the room
  $A110,$01 Restore the attribute address from the stack.
@ $A111 label=AttrDrawMovingDownLeft_Row
  $A111,$01 Stash the width and the number of rows on the stack.
  $A112,$01 Stash the attribute address on the stack.
@ $A113 label=AttrDrawMovingDownLeft_Cell
  $A113,$01 Write the attribute of the entity to the cell.
  $A114,$01 Move to the next cell.
  $A115,$02 Decrease the width by one and loop back to #R$A113 until the row is
. done.
  $A117,$01 Write the attribute of the room to the cell on the right.
  $A118,$01 Restore the attribute address from the stack.
  $A119,$03 #REGbc=#N($0020,$04,$04).
  $A11C,$03 Move up a row.
  $A11F,$01 Restore the width and the number of rows from the stack.
  $A120,$03 Decrease the number of rows by one and loop back to #R$A111 until
. all of the rows have been set.
  $A123,$01 Add one more cell to the width.
  $A124,$03 Jump to #R$A0C9 to put the row above back to the attribute of the
. room.

c $A127 Draw Attributes Moving Up-Right
@ $A127 label=AttrDrawMovingUpRight
D $A127 The attribute routine for an entity which has moved up and right. The
. row just below the entity, and one more cell to the left, is put back to the
. attribute of the room. Then each row of cells under the entity is set to the
. attribute of the entity, with the cell to the left of it put back to the
. attribute of the room.
R $A127 B The width of the sprite in cells
R $A127 C The number of rows of cells
R $A127 D The attribute of the entity
R $A127 E The attribute of the room
  $A127,$01 Restore the attribute address from the stack.
  $A128,$01 Stash the width and the number of rows on the stack.
  $A129,$01 Stash the attribute address on the stack.
  $A12A,$01 Stash the width and the number of rows on the stack again.
  $A12B,$03 #REGbc=#N($0020,$04,$04).
  $A12E,$01 Move down a row.
  $A12F,$01 Restore the width.
  $A130,$01 Move to the cell on the left.
  $A131,$01 Add one more cell to the width.
@ $A132 label=AttrDrawMovingUpRight_Cell
  $A132,$01 Write the attribute of the room to the cell.
  $A133,$01 Move to the next cell.
  $A134,$02 Decrease the width by one and loop back to #R$A132 until the row is
. done.
  $A136,$01 Restore the attribute address from the stack.
  $A137,$01 Restore the width and the number of rows from the stack.
  $A138,$03 Jump to #R$A08E to set the cells under the entity.

c $A13B Draw Inventory
@ $A13B label=DrawInventory
D $A13B Draws the three items that the player is carrying in the side panel,
. one for each slot of the inventory at #R$5E30. The slots are drawn #N$10
. pixels apart.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SCR$04,$18,$03,$08,$05(inventory-before)
. | #POKES$5E30,$01;$5E32,$8C;$5E33,$46;$5E34,$01;$5E36,$81;$5E37,$44
. #POKES$5E38,$01;$5E3A,$81;$5E3B,$42
. #SIM(start=$A13B,stop=$0000,sp=$5B60)
. #SCR$04,$18,$03,$08,$05(inventory-after) } UDGTABLE# #POPS
  $A13B,$03 #REGd=#N$2C (the Y position) and #REGe=#N$C8 (the X position) of the
. first slot.
  $A13E,$03 Point #REGhl at the first slot of the inventory at #R$5E30.
  $A141,$02 #REGb=#N$03 (the number of slots).
@ $A143 label=DrawInventory_Loop
  $A143,$03 Draw the item in the slot with #R$A14D.
  $A146,$01 Fetch the X position of the slot.
  $A147,$02 Add #N$10 to move on to the X position of the next slot.
  $A149,$01 Keep the X position of the next slot in #REGe.
  $A14A,$02 Decrease the slot counter by one and loop back to #R$A143 until all
. of the slots are drawn.
  $A14C,$01 Return.

c $A14D Draw Inventory Item
@ $A14D label=DrawInventoryItem
D $A14D Draws and colours the item in one slot of the inventory. The item is
. built up as an entity in the record at #R$A17D, so that it can be drawn with
. #R$9F4A and coloured with #R$A00E. An empty slot is drawn as the blank sprite
. (#N$31), which clears the position.
R $A14D D The Y position
R $A14D E The X position
R $A14D HL The inventory slot
  $A14D,$01 Stash the slot counter on the stack.
  $A14E,$01 Stash the position on the stack.
  $A14F,$02 Stash #REGix on the stack.
  $A151,$04 Point #REGix at the entity to draw at #R$A17D.
  $A155,$01 Fetch the low byte of the address of the item.
  $A156,$01 Move to the high byte.
  $A157,$01 Combine it with the high byte, which gives zero if the slot is
. empty.
  $A158,$01 Move to the sprite ID.
  $A159,$01 Fetch the sprite ID.
  $A15A,$02 Jump to #R$A15E if the slot is not empty.
  $A15C,$02 #REGa=#N$31 (the blank sprite).
@ $A15E label=DrawInventoryItem_Set
  $A15E,$01 Move to the attribute.
  $A15F,$03 Write the sprite ID to *#REGix+#N$00.
  $A162,$03 Write the X position to *#REGix+#N$03.
  $A165,$03 Write the Y position to *#REGix+#N$04.
  $A168,$01 Fetch the attribute.
  $A169,$01 Move to the next slot.
  $A16A,$03 Write the attribute to *#REGix+#N$05.
  $A16D,$01 Stash the pointer to the next slot on the stack.
  $A16E,$03 Clear the area with #R$A185.
  $A171,$03 Draw the sprite with #R$9F4A.
  $A174,$03 Set the attributes with #R$A00E.
  $A177,$01 Restore the pointer to the next slot from the stack.
  $A178,$02 Restore #REGix from the stack.
  $A17A,$01 Restore the position from the stack.
  $A17B,$01 Restore the slot counter from the stack.
  $A17C,$01 Return.

g $A17D Entity To Draw
@ $A17D label=EntityToDraw
D $A17D A scratch entity record, which the routines that draw the side panel
. fill
. in before drawing it as an entity. Only the sprite ID, the position and the
. attribute are used for drawing.
B $A17D,$01 The sprite ID.
B $A17E,$02 Not used when drawing.
B $A180,$01 The X position.
B $A181,$01 The Y position.
B $A182,$01 The attribute.
B $A183,$02 Not used when drawing.

c $A185 Clear Sprite
@ $A185 label=ClearSprite
D $A185 Clears the pixels in the area under a sprite, which is two bytes wide
. and
. #N$14 rows high, working up from the position of an entity.
R $A185 IX The entity
  $A185,$06 #REGl=the entity X position, and #REGh=the entity Y position.
  $A18B,$03 Call #R$9BA2 to get the screen address of the position.
  $A18E,$02 #REGb=#N$14 (the number of rows).
@ $A190 label=ClearSprite_Row
  $A190,$02 Clear the first byte of the row.
  $A192,$01 Move to the next byte.
  $A193,$02 Clear the second byte of the row.
  $A195,$01 Move back to the first byte.
  $A196,$03 Call #R$9F03 to move up one pixel row.
  $A199,$02 Decrease the row counter by one and loop back to #R$A190 until it is
. zero.
  $A19B,$01 Return.

c $A19C Add Points To Score
@ $A19C label=AddPointsToScore
D $A19C Adds some points to the score, which is held as three bytes of BCD
. starting at #R$5E2A (the most significant byte is first). It then carries on
. to print the score.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SCR$04,$18,$08,$08,$04(add-points-before)
. | #SIM(start=$A19C,stop=$0000,bc=$0050,sp=$5B60)
. #SIM(start=$A1AE,stop=$0000,sp=$5B60)
. #SCR$04,$18,$08,$08,$04(add-points-after) } UDGTABLE# #POPS
E $A19C View the equivalent code in;
. #LIST
. { #COOKIE$7415 }
. { #JETPAC$70F9 }
. { #PSSST$737A }
. { #TRANZAM$6046 }
. { #UNDERWURLDE$A045 }
. LIST#
R $A19C BC The points to add to the score (as BCD)
  $A19C,$03 Point #REGhl at the last byte of the score at #R$5E2C.
  $A19F,$01 Fetch the last byte of the score.
  $A1A0,$01 Add #REGc.
  $A1A1,$01 Convert the result to BCD.
  $A1A2,$01 Update the last byte of the score.
  $A1A3,$01 Move on to the middle byte of the score.
  $A1A4,$01 Fetch the middle byte of the score.
  $A1A5,$01 Add #REGb, with the carry.
  $A1A6,$01 Convert the result to BCD.
  $A1A7,$01 Update the middle byte of the score.
  $A1A8,$01 Move on to the first byte of the score.
  $A1A9,$01 Fetch the first byte of the score.
  $A1AA,$02 Add #N$00 (i.e. just the carry flag).
  $A1AC,$01 Convert the result to BCD.
  $A1AD,$01 Update the first byte of the score.

c $A1AE Print Scores
@ $A1AE label=Score_1UP
D $A1AE Prints the score, as six digits, in the side panel.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SCR$04,$18,$08,$08,$04(print-scores-before)
. | #POKES$5E2A,$12;$5E2B,$34;$5E2C,$56
. #SIM(start=$A1AE,stop=$0000,sp=$5B60)
. #SCR$04,$18,$08,$08,$04(print-scores-after) } UDGTABLE# #POPS
E $A1AE View the equivalent code in;
. #LIST
. { #COOKIE$7438 }
. { #JETPAC$711C }
. { #LUNARJETMAN$89BF }
. { #PSSST$739D }
. { #TRANZAM$6CB6 }
. LIST#
  $A1AE,$06 Write #R$BFCC to #R$5E01.
  $A1B4,$03 #REGhl=#N$50C8 (the Y position is #N$50 and the X position is
. #N$C8).
@ $A1B7 label=PrintScore
  $A1B7,$03 Call #R$9BA2 to get the screen address of the position.
  $A1BA,$03 Point #REGde at the first byte of the score at #R$5E2A.
  $A1BD,$02 #REGb=#N$03 (the number of bytes).
@ $A1BF label=PrintScore_Loop
  $A1BF,$01 Fetch the next byte of the score.
  $A1C0,$04 Rotate right four times, which moves the high digit into the low
. nibble.
  $A1C4,$02,b$01 Keep only bits 0-3.
  $A1C6,$03 Call #R$A1D3 to print the digit.
@ $A1C9 label=PrintScore_LowDigit
  $A1C9,$01 Fetch the byte of the score again.
  $A1CA,$02,b$01 Keep only bits 0-3.
  $A1CC,$03 Call #R$A1D3 to print the digit.
  $A1CF,$01 Move on to the next byte of the score.
  $A1D0,$02 Decrease the byte counter by one and loop back to #R$A1BF until all
. the bytes of the score have been printed.
  $A1D2,$01 Return.

c $A1D3 Print Character
@ $A1D3 label=PrintScreen
D $A1D3 Prints a character at a screen address, using the graphics in the font
. that #R$5E01 points to, and moves on to the next character cell.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SIM(start=$8093,stop=$0000,sp=$5B60)
. #POKES$5E01,$4C;$5E02,$BE
. #SCR$04,$06,$06,$08,$04(print-character-before)
. | #SIM(start=$A1D3,stop=$0000,a=$41,hl=$4808,sp=$5B60)
. #SIM(start=$A1D3,stop=$0000,a=$43,sp=$5B60)
. #SIM(start=$A1D3,stop=$0000,a=$47,sp=$5B60)
. #SCR$04,$06,$06,$08,$04(print-character-after) } UDGTABLE# #POPS
E $A1D3 View the equivalent code in;
. #LIST
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #MARTIANOIDS$B5CB }
. { #NIGHTSHADE$CB19 }
. { #PSSST$73CD }
. { #SABREWULF$B589 }
. { #TRANZAM$6C96 }
. { #UNDERWURLDE$98DF }
. LIST#
R $A1D3 A The character code (the number of its graphic in the font)
R $A1D3 HL The screen address
R $A1D3 O:HL The screen address of the next character cell
  $A1D3,$01 Stash #REGbc on the stack.
  $A1D4,$01 Stash #REGde on the stack.
  $A1D5,$01 Stash the screen address on the stack.
  $A1D6,$03 Fetch the character code.
  $A1D9,$03 Multiply by #N$08, as each character has eight bytes of graphics.
  $A1DC,$04 Fetch the address of the font from #R$5E01.
  $A1E0,$01 Fetch the address of the graphics of the character.
  $A1E1,$01 Fetch the address of the graphics of the character.
  $A1E2,$01 Restore the screen address from the stack.
  $A1E3,$02 #REGb=#N$08 (the number of rows).
@ $A1E5 label=PrintScreen_Loop
  $A1E5,$01 Fetch the next row of the graphics.
  $A1E6,$01 Write it to the screen.
  $A1E7,$01 Move on to the next row of the graphics.
  $A1E8,$01 Move down a pixel row on the screen.
  $A1E9,$02 Decrease the row counter by one and loop back to #R$A1E5 until it is
. zero.
  $A1EB,$01 Restore #REGde from the stack.
  $A1EC,$01 Restore #REGbc from the stack.
  $A1ED,$01 Fetch the high byte of the screen address.
  $A1EE,$02 Subtract #N$08 to move back to the top row of the character.
  $A1F0,$01 Keep the high byte of the top row in #REGh.
  $A1F1,$01 Move on to the next character cell.
  $A1F2,$01 Return.

c $A1F3 Print Colour String
@ $A1F3 label=PrintStringColour
D $A1F3 Prints a string of characters, and sets the attribute of each character
. cell it uses. The string data starts with the attribute, followed by the
. characters, and bit 7 of the last character is set to mark the end of the
. string.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SIM(start=$80AA,stop=$0000,sp=$5B60)
. #POKES$5E01,$4C;$5E02,$BE
. #SCR$02,$00,$00,$20,$04(print-string-before)
. | #SIM(start=$A1F3,stop=$0000,hl=$0020,de=$7D72,sp=$5B60)
. #SCR$02,$00,$00,$20,$04(print-string-after) } UDGTABLE# #POPS
E $A1F3 View the equivalent code in;
. #LIST
. { #COOKIE$7488 }
. { #JETPAC$716C }
. { #LUNARJETMAN$8A11 }
. { #PSSST$73ED }
. { #SABREWULF$B53D }
. { #TRANZAM$6518 }
. { #UNDERWURLDE$9C3C }
. LIST#
R $A1F3 DE Pointer to string data
R $A1F3 HL The position (the Y position in #REGh and the X position in #REGl)
  $A1F3,$01 Stash #REGhl on the stack.
  $A1F4,$03 Call #R$9BA2 to get the screen address.
  $A1F7,$01 Fetch the attribute byte.
  $A1F8,$01 Switch to the shadow #REGaf register.
  $A1F9,$01 Increment #REGde by one to point to the text of the string.
  $A1FA,$01 Switch to the shadow registers.
  $A1FB,$01 Restore #REGhl from the stack.
  $A1FC,$03 Call #R$9BD2 to get the attribute address.

@ $A1FF label=PrintString_Loop
  $A1FF,$01 Switch back to the normal registers.
  $A200,$01 Fetch the character to print.
  $A201,$04 If bit 7 is set (which signifies the end of the string), jump to #R$A210.
  $A205,$03 Call #R$A1D3 to print the character.
  $A208,$01 Move #REGde on to the next character of the string.
  $A209,$01 Switch to the shadow registers.
  $A20A,$01 Switch to the shadow #REGaf register.
  $A20B,$01 Copy the attribute byte to the screen.
  $A20C,$01 Move #REGl on to the next attribute cell.
  $A20D,$01 Switch to the shadow #REGaf register.
  $A20E,$02 Jump back to #R$A1FF to print the next character of the string.
N $A210 Because the last character contains the terminator, it needs to be handled separately.
@ $A210 label=PrintString_LastCharacter
  $A210,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $A212,$03 Call #R$A1D3 to print the character.
  $A215,$01 Switch to the shadow registers.
  $A216,$01 Switch to the shadow #REGaf register.
  $A217,$01 Copy the attribute byte to the screen.
  $A218,$01 Return.

c $A219 Draw Side Panel
@ $A219 label=DrawSidePanel
D $A219 Draws the side panel on the right of the screen. The panel is #N$08
. characters wide and #N$18 characters high, and the characters to use are
. listed in #R$B32A. They are drawn with the graphics at #R$B03A as the font.
. It then jumps to #R$A1AE to print the score.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SIM(start=$80B4,stop=$0000,sp=$5B60)
. #SCR$02,$18,$00,$08,$18(side-panel-before)
. | #SIM(start=$A219,stop=$0000,sp=$5B60)
. #SCR$02,$18,$00,$08,$18(side-panel-after) } UDGTABLE# #POPS
  $A219,$06 Write #R$B03A to #R$5E01.
  $A21F,$03 #REGhl=#N($00C0, $04, $04) (screen buffer location).
  $A222,$03 Point #REGde at the side panel data at #R$B32A.
  $A225,$03 #REGbc=#N$08 (width), #N$18 (height).
@ $A228 label=SidePanel_Loop_Y
  $A228,$02 Stash #REGbc and #REGhl on the stack.
  $A22A,$03 Call #R$9BA2 to get the screen address.
@ $A22D label=SidePanel_Loop_X
  $A22D,$01 Fetch the next character of the panel.
  $A22E,$01 Increment the character data pointer by one.
  $A22F,$03 Call #R$A1D3 to print the character.
  $A232,$02 Decrease the width counter by one and loop back to #R$A22D until the
. row of the panel has been printed.
  $A234,$01 Restore #REGhl from the stack.
  $A235,$04 Add #N$08 to #REGh, to move down one character row.
  $A239,$01 Restore #REGbc from the stack.
  $A23A,$03 Decrease the height counter by one and loop back to #R$A228 until
. all the rows of the panel have been printed.
  $A23D,$03 Jump to #R$A1AE to print the scores.

c $A240 Draw Side Panel Attributes
@ $A240 label=DrawSidePanelAttrs
D $A240 Sets the attributes of the side panel. The whole panel is filled with a
. colour that is picked from the attribute of the room, and then a shape and
. some bands of colour are put on top. #R$809A, which fills a block of cells
. with a value, does most of the work.
N $A240 #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$9153,clear=1,sp=$5E00)
. #SCR$01(panel-attributes-before)
. | #SIM(start=$9153,stop=$9156,sp=$5E00)
. #SCR$01(panel-attributes-after) } UDGTABLE# #POPS
  $A240,$03 #REGhl=#N$00C0 (the Y position is #N$00 and the X position is
. #N$C0), which is the top left of the side panel.
  $A243,$03 Call #R$9BD2 to get the attribute address of the position.
  $A246,$03 #REGb=#N$08 (the width of the panel in cells) and #REGc=#N$18 (the
. number of rows).
N $A249 Pick the colour for the panel. Take the inverse of bits 0-2 of the
. attribute of the room, unless that is less than #N$02, when #N$44 is used.
  $A249,$03 Fetch the room attribute from #R$5E1A.
  $A24C,$01 Flip the bits.
  $A24D,$02,b$01 Keep only bits 0-2.
  $A24F,$04 Jump to #R$A255 if the colour is #N$02 or more.
  $A253,$02 #REGa=#N$44.
@ $A255 label=DrawSidePanelAttrs_Colour
  $A255,$01 Keep the attribute of the panel in #REGe.
  $A256,$01 Stash the attribute of the panel on the stack.
@ $A257 label=DrawSidePanelAttrs_Row
  $A257,$01 Stash the width and the number of rows on the stack.
  $A258,$01 Stash the attribute address on the stack.
@ $A259 label=DrawSidePanelAttrs_Cell
  $A259,$01 Write the attribute of the panel to the cell.
  $A25A,$01 Move to the next cell.
  $A25B,$02 Decrease the width by one and loop back to #R$A259 until the row is
. done.
  $A25D,$01 Restore the attribute address from the stack.
  $A25E,$03 #REGbc=#N($0020,$04,$04).
  $A261,$01 Move down a row.
  $A262,$01 Restore the width and the number of rows from the stack.
  $A263,$03 Decrease the number of rows by one and loop back to #R$A257 until
. all of the rows have been set.
N $A266 Fill a square of three by three cells, and then a cell and a square of
. two by two cells below it, with the attribute of the room. Then put the
. attribute of the panel back in the middle of the three by three square.
  $A266,$03 #REGhl=#N$90C8 (the Y position is #N$90 and the X position is
. #N$C8).
  $A269,$03 Call #R$9BD2 to get the attribute address of the position.
  $A26C,$03 Fetch the room attribute from #R$5E1A.
  $A26F,$03 #REGb=#N$03 (the width) and #REGc=#N$03 (the number of rows).
  $A272,$03 Call #R$809A to fill the cells with the attribute of the room.
  $A275,$01 Move to the next cell.
  $A276,$01 Write the attribute of the room to the cell.
  $A277,$01 Move down a row (#REGde is #N($0020,$04,$04) after the call).
  $A278,$03 #REGb=#N$02 (the width) and #REGc=#N$02 (the number of rows).
  $A27B,$03 Call #R$809A to fill the cells with the attribute of the room.
  $A27E,$03 #REGhl=#N$98D0 (the Y position is #N$98 and the X position is
. #N$D0).
  $A281,$03 Call #R$9BD2 to get the attribute address of the position.
  $A284,$01 Restore the attribute of the panel from the stack.
  $A285,$01 Write it to the cell.
N $A286 Colour the bands of the panel from the bottom upwards. Each is filled
. with #R$809A.
  $A286,$03 #REGhl=#N$7DC8 (the Y position is #N$7D and the X position is
. #N$C8).
  $A289,$03 Call #R$9BD2 to get the attribute address of the position.
  $A28C,$03 #REGb=#N$06 (the width) and #REGc=#N$03 (the number of rows).
  $A28F,$02 #REGa=#N$47 (bright white).
  $A291,$03 Call #R$809A to fill the cells.
  $A294,$03 #REGhl=#N$5FC8 (the Y position is #N$5F and the X position is
. #N$C8).
  $A297,$03 Call #R$9BD2 to get the attribute address of the position.
  $A29A,$03 #REGb=#N$06 (the width) and #REGc=#N$04 (the number of rows).
  $A29D,$02 #REGa=#N$46 (bright yellow).
  $A29F,$03 Call #R$809A to fill the cells.
  $A2A2,$03 #REGhl=#N$48C8 (the Y position is #N$48 and the X position is
. #N$C8).
  $A2A5,$03 Call #R$9BD2 to get the attribute address of the position.
  $A2A8,$03 #REGb=#N$06 (the width) and #REGc=#N$01 (the number of rows).
  $A2AB,$02 #REGa=#N$45 (bright cyan).
  $A2AD,$03 Call #R$809A to fill the cells.
  $A2B0,$03 #REGb=#N$06 (the width) and #REGc=#N$01 (the number of rows).
  $A2B3,$02 #REGa=#N$47 (bright white).
  $A2B5,$03 Call #R$809A to fill the cells in the next row down.
  $A2B8,$03 #REGhl=#N$38C8 (the Y position is #N$38 and the X position is
. #N$C8).
  $A2BB,$03 Call #R$9BD2 to get the attribute address of the position.
  $A2BE,$03 #REGb=#N$06 (the width) and #REGc=#N$01 (the number of rows).
  $A2C1,$02 #REGa=#N$43 (bright magenta).
  $A2C3,$03 Call #R$809A to fill the cells.
  $A2C6,$03 #REGb=#N$06 (the width) and #REGc=#N$01 (the number of rows).
  $A2C9,$02 #REGa=#N$47 (bright white).
  $A2CB,$03 Jump to #R$809A to fill the cells in the next row down.

c $A2CE Display Lives
@ $A2CE label=DisplayPlayerLives
D $A2CE Draws an icon of the character for each life that the player has left
. (up to three) in the side panel, and clears the icon of each life that has
. been lost. The icon is the first sprite of the character that was chosen
. in the menu (#R$5E00 bits 3-4).
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7D9A,stop=$7DDC,clear=1,sp=$5E00)
. #SCR$04,$18,$10,$08,$03(display-lives-before)
. | #POKES$5E21,$01
. #SIM(start=$A2CE,stop=$0000,sp=$5B60)
. #SCR$04,$18,$10,$08,$03(display-lives-after) } UDGTABLE# #POPS
E $A2CE View the equivalent code in;
. #LIST
. { #LUNARJETMAN$894F }
. { #TRANZAM$687B }
. LIST#
  $A2CE,$02 Stash #REGix on the stack.
  $A2D0,$04 Point #REGix at the entity to draw at #R$A17D.
  $A2D4,$03 Fetch the character that was chosen from #R$5E00.
  $A2D7,$01 Rotate left once.
  $A2D8,$02,b$01 Keep only bits 4-5.
  $A2DA,$02,b$01 Set bit 0, to get the first sprite of the character (#N$01,
. #N$11 or #N$21).
  $A2DC,$03 Write the sprite ID to *#REGix+#N$00.
  $A2DF,$04 Write #N$47 (the attribute) to *#REGix+#N$05.
  $A2E3,$03 #REGhl=#N$8DC8 (the Y position is #N$8D and the X position is
. #N$C8).
  $A2E6,$03 Write the X position to *#REGix+#N$03.
  $A2E9,$03 Write the Y position to *#REGix+#N$04.
  $A2EC,$04 Fetch the number of lives from #R$5E21 and keep the number of lives
. left to draw in #REGc.
  $A2F0,$02 #REGb=#N$03 (the number of icons).
@ $A2F2 label=DisplayPlayerLives_Loop
  $A2F2,$01 Stash the counters on the stack.
  $A2F3,$03 Clear the icon with #R$A185.
  $A2F6,$01 Fetch the number of lives left to draw.
  $A2F7,$03 Jump to #R$A2FD if there are no lives left to draw.
  $A2FA,$03 Draw the icon with #R$9F4A.
@ $A2FD label=DisplayPlayerLives_Next
  $A2FD,$03 Fetch the X position.
  $A300,$02 Add #N$10 to move on to the next icon.
  $A302,$03 Write the X position back to *#REGix+#N$03.
  $A305,$01 Restore the counters from the stack.
  $A306,$04 Decrease the number of lives left to draw by one, and jump to
. #R$A30C if it is not negative.
  $A30A,$02 #REGc=#N$00 (no lives left to draw).
@ $A30C label=DisplayPlayerLives_Count
  $A30C,$02 Decrease the icon counter by one and loop back to #R$A2F2 until it
. is zero.
  $A30E,$02 Restore #REGix from the stack.
  $A310,$01 Return.

c $A311 Menu Icons
@ $A311 label=MenuIcons
D $A311 Draws the nine icons of the menu. The data for each one is the same as
. an entity record, which is copied from the table at #R$A331 to #R$A17D,
. drawn with #R$9F4A and then coloured with #R$A00E.
. #PUSHS #POKES$5C78,$34,$02 #POKES$5CB0,$E9
. #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$7C19,stop=$7C2C,clear=1,sp=$5E00)
. #SCR$03,$03,$08,$05,$0E(menu-icons-before)
. | #SIM(start=$A311,stop=$0000,sp=$5B60)
. #SCR$03,$03,$08,$05,$0E(menu-icons-after) } UDGTABLE# #POPS
  $A311,$04 Point #REGix at the entity to draw at #R$A17D.
  $A315,$03 Point #REGhl at the table of icons at #R$A331.
  $A318,$02 #REGb=#N$09 (the number of icons).
@ $A31A label=MenuIcons_Loop
  $A31A,$01 Stash the icon counter on the stack.
  $A31B,$08 Copy #N$08 bytes of data from #REGhl to #R$A17D.
  $A323,$02 Stash #REGhl and #REGde on the stack.
  $A325,$03 Call #R$9F4A to draw the entity.
  $A328,$03 Call #R$A00E to set the attributes of the entity.
  $A32B,$02 Restore #REGde and #REGhl from the stack.
  $A32D,$01 Restore the icon counter from the stack.
  $A32E,$02 Decrease the icon counter by one and loop back to #R$A31A until all
. nine icons have been drawn.
  $A330,$01 Return.
N $A331 The sprite IDs are stored +#N$01 higher than their actual value.
@ $A331 label=MenuEntities
B $A331,$48,$08
. #TABLE(default,centre,centre,centre,centre)
. { =h Address | =h Sprite | =h Attribute | =h Screen Buffer Location }
. { #N$A331 | #SPRITENAME(#PEEK($A331) - $01) | #N(#PEEK($A334)) | #N(#PEEK($A335) + #PEEK($A336) * $100) }
. { #N$A339 | #SPRITENAME(#PEEK($A339) - $01) | #N(#PEEK($A33C)) | #N(#PEEK($A33D) + #PEEK($A33E) * $100) }
. { #N$A341 | #SPRITENAME(#PEEK($A341) - $01) | #N(#PEEK($A344)) | #N(#PEEK($A335) + #PEEK($A346) * $100) }
. { #N$A349 | #SPRITENAME(#PEEK($A349) - $01) | #N(#PEEK($A34C)) | #N(#PEEK($A335) + #PEEK($A34E) * $100) }
. { #N$A351 | #SPRITENAME(#PEEK($A351) - $01) | #N(#PEEK($A354)) | #N(#PEEK($A335) + #PEEK($A356) * $100) }
. { #N$A359 | #SPRITENAME(#PEEK($A359) - $01) | #N(#PEEK($A35C)) | #N(#PEEK($A335) + #PEEK($A35E) * $100) }
. { #N$A361 | #SPRITENAME(#PEEK($A361) - $01) | #N(#PEEK($A364)) | #N(#PEEK($A335) + #PEEK($A366) * $100) }
. { #N$A369 | #SPRITENAME(#PEEK($A369) - $01) | #N(#PEEK($A36C)) | #N(#PEEK($A335) + #PEEK($A36E) * $100) }
. { #N$A371 | #SPRITENAME(#PEEK($A371) - $01) | #N(#PEEK($A374)) | #N(#PEEK($A375) + #PEEK($A376) * $100) }
. TABLE#

c $A379 Divide
@ $A379 label=Divide
D $A379 Divides a number by another and returns the answer as a fraction of
. #N$100, which is a number between #N$00 and #N$FF as long as the first
. number is the smaller. The answer is worked out one bit at a time (long
. division), with the answer in the shadow registers and the working in the
. normal registers.
. #R$9C79 uses it to work out how far to move across or up for every pixel
. moved in the other direction.
E $A379 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$AC75 }
. LIST#
R $A379 H The number to divide (the numerator)
R $A379 DE The number to divide by (the denominator)
R $A379 O:DE The remainder
R $A379 O:HL The answer (the numerator * #N$100 / the denominator)
  $A379,$01 Move the numerator into #REGl.
  $A37A,$02 #REGh=#N$00 (so that #REGhl is the numerator).
  $A37C,$01 Switch to the shadow registers.
  $A37D,$03 #REGhl'=#N$0000 (the answer so far).
  $A380,$02 #REGb'=#N$08 (the number of bits to work out).
@ $A382 label=Divide_Loop
  $A382,$01 Switch to the normal registers.
  $A383,$02 Shift #REGhl left by one.
  $A385,$02 Rotate the carry into #REGh.
  $A387,$01 Stash the working number on the stack.
  $A388,$03 Subtract the denominator.
  $A38B,$02 Jump to #R$A399 if it is bigger than the working number.
  $A38D,$01 Discard the stashed working number, as the subtraction can stay.
  $A38E,$01 Switch to the shadow registers.
  $A38F,$01 Shift the answer left by one.
  $A390,$01 Add one to the answer for this bit.
@ $A391 label=Divide_Next
  $A391,$02 Decrease the bit counter by one and loop back to #R$A382 until all
. eight bits of the answer have been worked out.
  $A393,$01 Stash the answer on the stack.
  $A394,$01 Switch to the normal registers.
  $A395,$01 #REGe=#REGl (the low byte of the remainder).
  $A396,$01 #REGd=#REGh (the high byte of the remainder).
  $A397,$01 Fetch the answer.
  $A398,$01 Return.
@ $A399 label=Divide_Restore
  $A399,$01 Restore the working number from the stack.
  $A39A,$01 Switch to the shadow registers.
  $A39B,$01 Shift the answer left by one.
  $A39C,$02 Jump to #R$A391 to move on to the next bit.

c $A39E Negate HL
@ $A39E label=NegateHL
D $A39E Replaces #REGhl with its two's complement (i.e. #REGhl=#N$0000 -
. #REGhl).
E $A39E View the equivalent code in;
. #LIST
. { #UNDERWURLDE$ADD6 }
. LIST#
R $A39E HL The value
R $A39E O:HL The negated value
  $A39E,$01 Stash #REGde on the stack.
  $A39F,$01 #REGde=#REGhl.
  $A3A0,$03 #REGhl=#N$0000.
  $A3A3,$03 Subtract the value.
  $A3A6,$01 Restore #REGde from the stack.
  $A3A7,$01 Return.

c $A3A8 Sounds: Click
@ $A3A8 label=SoundsClick
D $A3A8 Plays a tone on the speaker by switching it on and off. Each cycle is a
. wait of the half period with the speaker on and the same wait with the speaker
. off.
.
. This entry plays one cycle (a click). The entry at #R$A3AA plays the
. number of cycles that is in #REGc, and the routines which follow play other
. tones by loading #REGbc and jumping to it.
.
. Writing #N$10 to port #N$FE sets the speaker bit and leaves the border black.
.
. A single click is too short to be heard on its own, so there is no sample for
. it here. It is heard in the run of clicks played by #R$A445 (which has a
. sample), and in those played by #R$A41B, #R$A427 and #R$A438, and when the
. player falls through a trapdoor in #R$9731.
E $A3A8 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$A068 }
. LIST#
R $A3A8 B The half period of the tone (#N$00 is #N$100)
  $A3A8,$02 #REGc=#N$01 (one cycle).
@ $A3AA label=SoundsBeep
N $A3AA Play #REGc cycles of the tone.
  $A3AA,$02 #REGa=#N$10 (the speaker bit).
  $A3AC,$02 Switch the speaker on.
  $A3AE,$01 Stash the cycle counter and the half period on the stack, as the
. wait counts #REGb down to zero.
@ $A3AF label=SoundsClick_OnDelay
  $A3AF,$02 Wait for the half period.
  $A3B1,$01 Restore the cycle counter and the half period from the stack.
  $A3B2,$01 Stash them on the stack again.
  $A3B3,$01 #REGa=#N$00 (clear the speaker bit).
  $A3B4,$02 Switch the speaker off.
@ $A3B6 label=SoundsClick_OffDelay
  $A3B6,$02 Wait for the half period.
  $A3B8,$01 Restore the cycle counter and the half period from the stack.
  $A3B9,$01 Decrease the cycle counter by one.
  $A3BA,$02 Jump back to #R$A3AA until all of the cycles have been played.
  $A3BC,$01 Return.

c $A3BD Sounds: Inventory
@ $A3BD label=SoundsInventory
D $A3BD Plays the tone for picking up an item, which is #N$40 cycles with a
. half period of #N$40.
. #HTML(#AUDIO0(inventory-tone.wav)(#INCLUDE(InventoryTone)))
  $A3BD,$03 #REGb=#N$40 (the half period) and #REGc=#N$40 (the number of
. cycles).
  $A3C0,$02 Jump to #R$A3AA to play the tone.

c $A3C2 Sounds: Drop Item
@ $A3C2 label=SoundsDropItem
D $A3C2 Plays the tone for dropping an item, which is #N$80 cycles with a half
. period of #N$20.
. #HTML(#AUDIO0(drop-item.wav)(#INCLUDE(DropItem)))
E $A3C2 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$B8C3 }
. LIST#
  $A3C2,$03 #REGb=#N$20 (the half period) and #REGc=#N$80 (the number of
. cycles).
  $A3C5,$02 Jump to #R$A3AA to play the tone.

c $A3C7 Sounds: Walking
@ $A3C7 label=SoundsWalking
D $A3C7 Plays a footstep. The walk counter is increased each time this is
. called. A tone is only played when the counter is odd, which makes it
. every other call, and the half period alternates between #N$60 and #N$40.
. #HTML(#AUDIO0(footstep-sound.wav)(#INCLUDE(FootstepSound)))
  $A3C7,$03 Point #REGhl at the walk counter at #R$5E2F.
  $A3CA,$01 Increase the counter by one.
  $A3CB,$01 Fetch the counter.
  $A3CC,$04 Jump to #R$A3D8 if bit 1 of the walk counter is not set.
  $A3D0,$02,b$01 Keep only bit 0.
  $A3D2,$01 Return if the counter is even.
  $A3D3,$03 #REGb=#N$40 (the half period) and #REGc=#N$04 (the number of
. cycles).
  $A3D6,$02 Jump to #R$A3AA to play the tone.

c $A3D8 Sounds: Walk Low
@ $A3D8 label=SoundsWalkLow
D $A3D8 The second part of #R$A3C7, which plays the lower of the two footsteps.
. The sample for #R$A3C7 includes both footsteps, so there is no separate
. sample for this one.
  $A3D8,$02,b$01 Keep only bit 0.
  $A3DA,$01 Return if the counter is even.
  $A3DB,$03 #REGb=#N$60 (the half period) and #REGc=#N$04 (the number of
. cycles).
  $A3DE,$02 Jump to #R$A3AA to play the tone.

c $A3E0 Sounds: Start Beep
@ $A3E0 label=SoundsStart
D $A3E0 Plays a beep, which is #N$60 cycles with a half period of #N$80.
. #HTML(#AUDIO0(start-beep.wav)(#INCLUDE(StartBeep)))
  $A3E0,$03 #REGb=#N$80 (the half period) and #REGc=#N$60 (the number of
. cycles).
  $A3E3,$02 Jump to #R$A3AA to play the tone.

c $A3E5 Sounds: Touching
@ $A3E5 label=SoundsTouching
D $A3E5 Queues a sound that is played by #R$A3EF, one note on each pass of
. the main loop.
. #HTML(#AUDIO0(touching.wav)(#INCLUDE(Touching)))
  $A3E5,$03 #REGb=#N$64 (the sound handler) and #REGc=#N$10 (the count).

c $A3E8 Queue Sound
@ $A3E8 label=QueueSound
D $A3E8 Sets up the sound entity at #R$EAA0, so that its handler is called on
. each pass of the main loop to play the notes of the sound one by one.
R $A3E8 B The sound handler (the first byte of the entity)
R $A3E8 C The count of notes (the second byte of the entity)
  $A3E8,$03 Point #REGhl at the sound entity at #R$EAA0.
  $A3EB,$01 Write the sound handler to the first byte.
  $A3EC,$01 Move to the second byte.
  $A3ED,$01 Write the count to the second byte.
  $A3EE,$01 Return.

c $A3EF Sound Effect
@ $A3EF label=SoundEffect
D $A3EF The handler of the sound entity for the sound set up by #R$A3E5. The
. count in the second byte of the entity is decreased on each pass of the main
. loop. When the count reaches zero the entity is cleared. Until then it plays
. a tone of as many cycles as the count, with a half period of the count
. exclusive ORed with #N$43, so the pitch changes as the count falls.
E $A3EF View the equivalent code in;
. #LIST
. { #UNDERWURLDE$A0AC }
. LIST#
R $A3EF IX The sound entity
  $A3EF,$05 Decrease the count of notes, and jump to #R$A3FE if there are none
. left.
  $A3F4,$04 Fetch the count and keep the number of cycles in #REGc.
  $A3F8,$02,b$01 Combine the count with #N$43 to make the half period.
  $A3FA,$01 Keep the half period in #REGb.
  $A3FB,$03 Jump to #R$A3AA to play the tone.

c $A3FE Clear Sound
@ $A3FE label=ClearSound
D $A3FE Clears the first byte of the sound entity, so that it does nothing on
. the following passes of the main loop.
R $A3FE IX The sound entity
  $A3FE,$04 Write #N$00 to the first byte of the entity.
  $A402,$01 Return.

c $A403 Sounds: Entry
@ $A403 label=SoundsEntry
D $A403 Queues a sound that is played by #R$A408, one note on each pass of
. the main loop.
. #HTML(#AUDIO0(enter-room.wav)(#INCLUDE(EnterRoom)))
  $A403,$03 #REGb=#N$65 (the sound handler) and #REGc=#N$0A (the count).
  $A406,$02 Jump to #R$A3E8 to queue the sound.

c $A408 Sound Effect Next Note
@ $A408 label=SoundEffectNext
D $A408 The handler of the sound entity for the sound set up by #R$A403. The
. count in the second byte of the entity is decreased on each pass of the main
. loop. When the count reaches zero the entity is cleared. Until then it plays
. a tone of as many cycles as the count, and the half period is made from the
. count (rotated left three times, flipped and exclusive ORed with #N$40).
E $A408 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$A0C5 }
. LIST#
R $A408 IX The sound entity
  $A408,$05 Decrease the count of notes, and jump to #R$A3FE if there are none
. left.
  $A40D,$04 Fetch the count and keep the number of cycles in #REGc.
  $A411,$03 Rotate left three times.
  $A414,$01 Flip the bits.
  $A415,$02,b$01 Flip bit 6.
  $A417,$01 Keep the half period in #REGb.
  $A418,$03 Jump to #R$A3AA to play the tone.

c $A41B Sounds: Axe Throw
@ $A41B label=SoundsAxeThrow
D $A41B Plays #N$0C clicks, one straight after the other. The half period of
. each click is the counter rotated right once.
. #HTML(#AUDIO0(axe-throw.wav)(#INCLUDE(AxeThrow)))
  $A41B,$02 #REGd=#N$0C (the counter).
@ $A41D label=SoundsAxeThrow_Loop
  $A41D,$01 Fetch the click counter.
  $A41E,$01 Rotate right once.
  $A41F,$01 Keep the half period in #REGb.
  $A420,$03 Play a click with #R$A3A8.
  $A423,$03 Decrease the counter by one and loop back to #R$A41D until all of
. the clicks have been played.
  $A426,$01 Return.

c $A427 Sounds: Sword
@ $A427 label=SoundsSword
D $A427 Plays #N$10 clicks, one straight after the other. The half period of
. each click is the counter rotated left twice, exclusive ORed with #N$07 and
. rotated left twice again.
. #HTML(#AUDIO0(sword.wav)(#INCLUDE(Sword)))
E $A427 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$A0E4 }
. LIST#
  $A427,$02 #REGd=#N$10 (the counter).
@ $A429 label=SoundsSword_Loop
  $A429,$01 Fetch the click counter.
  $A42A,$02 Rotate left twice.
  $A42C,$02,b$01 Flip bits 0-2.
  $A42E,$02 Rotate left twice.
  $A430,$01 Keep the half period in #REGb.
  $A431,$03 Play a click with #R$A3A8.
  $A434,$03 Decrease the counter by one and loop back to #R$A429 until all of
. the clicks have been played.
  $A437,$01 Return.

c $A438 Sounds: Fireball
@ $A438 label=SoundsFireball
D $A438 Plays #N$08 clicks, one straight after the other. The half period of
. each click is the counter flipped and rotated left once.
. #HTML(#AUDIO0(fireball.wav)(#INCLUDE(Fireball)))
  $A438,$02 #REGd=#N$08 (the counter).
@ $A43A label=SoundsFireball_Loop
  $A43A,$01 Fetch the click counter.
  $A43B,$01 Flip the bits.
  $A43C,$01 Rotate left once.
  $A43D,$01 Keep the half period in #REGb.
  $A43E,$03 Play a click with #R$A3A8.
  $A441,$03 Decrease the counter by one and loop back to #R$A43A until all of
. the clicks have been played.
  $A444,$01 Return.

c $A445 Sounds: Weapon Pop
@ $A445 label=SoundsWeaponPop
D $A445 Plays a run of clicks. The number of clicks comes from #R$5E25, and the
. counter goes down by two each time.
. #HTML(#AUDIO0(weapon-pop.wav)(#INCLUDE(WeaponPop)))
E $A445 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$A107 }
. LIST#
  $A445,$03 Fetch the number of creatures from #R$5E25.
  $A448,$01 Increment #REGa by one.
  $A449,$04 Rotate left four times.
  $A44D,$02,b$01 Set bits 0-3.
  $A44F,$02,b$01 Keep only bits 0-6.
  $A451,$01 Keep the counter in #REGd.
@ $A452 label=SoundsWeaponPop_Loop
  $A452,$01 Fetch the counter.
  $A453,$02,b$01 Flip bit 5.
  $A455,$01 Keep the half period in #REGb.
  $A456,$03 Play a click with #R$A3A8.
  $A459,$02 Decrease the counter by one, and return if it is zero.
  $A45B,$02 Decrease the counter by one again, and return if it is zero.
  $A45D,$02 Jump back to #R$A452.

c $A45F Sounds: Appear
@ $A45F label=SoundsAppear
D $A45F Plays a tone of #N$10 cycles. The half period is made from the seventh
. byte of the entity (flipped, rotated left once and limited to the range
. #N$40 to #N$7F), so it changes as the byte does.
. #HTML(#AUDIO0(appearing-sound.wav)(#INCLUDE(AppearingSound)))
R $A45F IX The entity
  $A45F,$03 Fetch offset #N$06 of the entity.
  $A462,$01 Flip the bits.
  $A463,$01 Rotate left once.
  $A464,$02,b$01 Keep only bits 0-5.
  $A466,$02,b$01 Set bit 6.
  $A468,$01 Keep the half period in #REGb.
  $A469,$02 #REGc=#N$10 (the number of cycles).
  $A46B,$03 Jump to #R$A3AA to play the tone.

c $A46E Sounds: Door
@ $A46E label=SoundsDoor
D $A46E Makes a burst of noise by sending the bits of the first #N$30 bytes of
. the ROM to the speaker. Bit 4 of the port is the speaker bit.
. #HTML(#AUDIO0(door.wav)(#INCLUDE(Door)))
E $A46E View the equivalent code in;
. #LIST
. { #UNDERWURLDE$A131 }
. LIST#
  $A46E,$03 #REGb=#N$08 (the number of bits in a byte) and #REGc=#N$30 (the
. number of bytes).
  $A471,$03 #REGhl=#N$0000 (the start of the ROM).
@ $A474 label=SoundsDoor_Byte
  $A474,$01 Fetch the next byte of the ROM.
  $A475,$01 Move on to the next byte.
  $A476,$01 Stash the counters on the stack.
@ $A477 label=SoundsDoor_Bit
  $A477,$02 Rotate #REGe right by one.
  $A479,$01 #REGa=#REGe.
  $A47A,$02,b$01 Keep only bit 4 (the speaker bit).
  $A47C,$02 Send it to the speaker.
  $A47E,$02 Decrease the bit counter by one and loop back to #R$A477 until it is
. zero.
  $A480,$01 Restore the counters from the stack.
  $A481,$03 Decrease the byte counter by one and loop back to #R$A474 until all
. of the bytes have been sent.
  $A484,$01 Return.

c $A485 Sounds: Eating
@ $A485 label=SoundsEating
D $A485 Queues a sound that is played by #R$A48B, one note on each pass of
. the main loop.
. #HTML(#AUDIO0(eating.wav)(#INCLUDE(Eating)))
  $A485,$03 #REGb=#N$A0 (the sound handler) and #REGc=#N$10 (the count).
  $A488,$03 Jump to #R$A3E8 to queue the sound.

c $A48B Sound Effect Eating
@ $A48B label=SoundEffectEating
D $A48B The handler of the sound entity for the sound set up by #R$A485. The
. count in the second byte of the entity is decreased on each pass of the main
. loop. When it goes below zero the entity is cleared. Until then it plays a
. tone of #N$08 cycles, and the count picks the half period from the table at
. #R$A4A0.
R $A48B IX The sound entity
  $A48B,$06 Decrease the count of notes, and jump to #R$A3FE if it is below
. zero.
  $A491,$03 Fetch the count.
  $A494,$02 #REGb=#N$00.
  $A496,$03 Point #REGhl at the eating tones at #R$A4A0.
  $A499,$01 Add the count to the address of the table.
  $A49A,$01 Fetch the half period from the table.
  $A49B,$02 #REGc=#N$08 (the number of cycles).
  $A49D,$03 Jump to #R$A3AA to play the tone.

b $A4A0 Eating Tones
@ $A4A0 label=TableTonesEating
D $A4A0 The half period of each note of the eating sound. They are played from
. the last to the first, one on each pass of the main loop.
B $A4A0,$10,$08

c $A4B0 Sounds: Bounce
@ $A4B0 label=SoundsBounce
D $A4B0 Plays a tone of #N$04 cycles. The half period is made by rotating the
. counter right three times. The counter is set to #N$40 and decreased before it
. is tested for zero, so the routine always carries on and plays the tone, with
. a half period of #N$E7.
. #HTML(#AUDIO0(bounce.wav)(#INCLUDE(Bounce)))
E $A4B0 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$A173 }
. LIST#
  $A4B0,$02 #REGd=#N$40.
  $A4B2,$01 Decrease #REGd by one.
  $A4B3,$01 Return if it is zero.
  $A4B4,$01 #REGa=#REGd.
  $A4B5,$03 Rotate right three times.
  $A4B8,$01 Keep the half period in #REGb.
  $A4B9,$02 #REGc=#N$04 (the number of cycles).
  $A4BB,$03 Jump to #R$A3AA to play the tone.

w $A4BE Sprite Table
@ $A4BE label=SpritesTable
D $A4BE The address of the data for each sprite, starting with sprite ID #N$01
. (so the entry for an ID is at offset ID - #N$01 times #N$02). The ID is the
. first byte of an entity record, and is also its handler index (see
. #R$7EE6). #R$9E89 reads the table, and each sprite starts with its height
. (see #R$AD2E).
E $A4BE View the equivalent code in;
. #LIST
. { #COOKIE$7702 }
. { #JETPAC$67C3(Jetpac Collectables) }
. { #JETPAC$690F(Jetpac Explosions) }
. { #JETPAC$6945(Jetpac Aliens) }
. { #JETPAC$76FA(Jetpac Jetman) }
. { #LUNARJETMAN$BAC0 }
. { #PSSST$761A }
. { #SABREWULF$BF84 }
. { #TRANZAM$7F06 }
. LIST#
  $A4BE,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $A4BE) / 2 + 1)) #SPRITENAME((#PC - $A4BE) / 2).
L $A4BE,$02,$A1

w $A600 Graphics Table
@ $A600 label=GraphicsTable
D $A600 The address of the pixel data for each graphic, starting with graphic ID
. #N$01 (so the entry for an ID is at offset ID - #N$01 times #N$02). The ID is
. the first byte of a room item or door record, and is also its handler index
. (see #R$802A). #R$9995 reads the table. Each graphic starts with its width in
. bytes and its height in pixels, and the graphics are drawn by #R$9962. The
. colours are in the attributes of the same graphic (see #R$A64E).
  $A600,$02 Graphic ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $A600) / 2 + 1)) #GRAPHICNAME((#PC - $A600) / 2).
L $A600,$02,$27

w $A64E Graphics Attributes Table
@ $A64E label=GraphicsAttributesTable
D $A64E The address of the attribute data for each graphic, starting with
. graphic ID #N$01 (the same IDs as #R$A600). #R$99AF reads the table and
. #R$9980 sets the attributes. Each set starts with its width and height in
. character cells, followed by one attribute byte for each cell.
  $A64E,$02 Graphic ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $A64E) / 2 + 1)) #GRAPHICNAME((#PC - $A64E) / 2).
L $A64E,$02,$27

b $A69C Graphic: Door Locked
@ $A69C label=Graphic_Door_Locked
D $A69C The pixels of the Door Locked graphic, which are shared by graphic IDs
. #N$08 to #N$0B. It is #N$04 bytes wide and #N$18 pixels high. The width and
. height are the first two bytes of the data, and they are followed by the
. pixels. The IDs differ in their colours, which are set by the attributes at
. #R$A6FE, #R$A70C, #R$A71A and #R$A728 respectively.
  $A69C,$01 Width = #N(#PEEK(#PC)) bytes.
  $A69D,$01 Height = #N(#PEEK(#PC)) pixels.
  $A69E,$60,$04 #GRAPHIC$07(door-locked)

b $A6FE Graphic Attributes: Door Locked
@ $A6FE label=Graphic_Door_Locked_Attributes_Red
D $A6FE This block holds 4 sets of attributes, one for each of the graphic IDs
. #N$08 to #N$0B. Each set is #N$04 cells wide and #N$03 cells high, and starts
. with its width and height. They are followed by one attribute for each cell.
. The pixels are at #R$A69C.
N $A6FE Red.
  $A6FE,$01 Width = #N(#PEEK(#PC)) bytes.
  $A6FF,$01 Height = #N(#PEEK(#PC)) bytes.
  $A700,$0C,$04 #GRAPHIC$07,1(door-locked-red)

N $A70C Green.
@ $A70C label=Graphic_Door_Locked_Attributes_Green
  $A70C,$01 Width = #N(#PEEK(#PC)) bytes.
  $A70D,$01 Height = #N(#PEEK(#PC)) bytes.
  $A70E,$0C,$04 #GRAPHIC$08,1(door-locked-green)

N $A71A Cyan.
@ $A71A label=Graphic_Door_Locked_Attributes_Cyan
  $A71A,$01 Width = #N(#PEEK(#PC)) bytes.
  $A71B,$01 Height = #N(#PEEK(#PC)) bytes.
  $A71C,$0C,$04 #GRAPHIC$09,1(door-locked-cyan)

N $A728 Yellow.
@ $A728 label=Graphic_Door_Locked_Attributes_Yellow
  $A728,$01 Width = #N(#PEEK(#PC)) bytes.
  $A729,$01 Height = #N(#PEEK(#PC)) bytes.
  $A72A,$0C,$04 #GRAPHIC$0A,1(door-locked-yellow)

b $A736 Graphic Attributes: Cave Door Locked
@ $A736 label=Graphic_Cave_Door_Locked_Attributes_Red
D $A736 This block holds 4 sets of attributes, one for each of the graphic IDs
. #N$0C to #N$0F. Each set is #N$04 cells wide and #N$03 cells high, and starts
. with its width and height. They are followed by one attribute for each cell.
. The pixels are at #R$C2AE.
N $A736 Red.
  $A736,$01 Width = #N(#PEEK(#PC)) bytes.
  $A737,$01 Height = #N(#PEEK(#PC)) bytes.
  $A738,$0C,$04 #GRAPHIC$0B,1(cave-door-locked-red)

N $A744 Green.
@ $A744 label=Graphic_Cave_Door_Locked_Attributes_Green
  $A744,$01 Width = #N(#PEEK(#PC)) bytes.
  $A745,$01 Height = #N(#PEEK(#PC)) bytes.
  $A746,$0C,$04 #GRAPHIC$0C,1(cave-door-locked-green)

N $A752 Cyan.
@ $A752 label=Graphic_Cave_Door_Locked_Attributes_Cyan
  $A752,$01 Width = #N(#PEEK(#PC)) bytes.
  $A753,$01 Height = #N(#PEEK(#PC)) bytes.
  $A754,$0C,$04 #GRAPHIC$0D,1(cave-door-locked-cyan)

N $A760 Yellow.
@ $A760 label=Graphic_Cave_Door_Locked_Attributes_Yellow
  $A760,$01 Width = #N(#PEEK(#PC)) bytes.
  $A761,$01 Height = #N(#PEEK(#PC)) bytes.
  $A762,$0C,$04 #GRAPHIC$0E,1(cave-door-locked-yellow)

b $A76E Graphic: Door Frame
@ $A76E label=Graphic_Door_Frame
D $A76E The pixels of the Door Frame graphic, which are shared by graphic IDs
. #N$02 and #N$21. It is #N$04 bytes wide and #N$18 pixels high. The width and
. height are the first two bytes of the data, and they are followed by the
. pixels. The colours are set by the attributes at #R$A7D0.
  $A76E,$01 Width = #N(#PEEK(#PC)) bytes.
  $A76F,$01 Height = #N(#PEEK(#PC)) pixels.
  $A770,$60,$04 #GRAPHIC$01(door)

b $A7D0 Graphic Attributes: Door Frame
@ $A7D0 label=Graphic_Door_Frame_Attributes
D $A7D0 The attributes of the Door Frame graphic, which are shared by graphic
. IDs #N$02 and #N$21. It is #N$04 cells wide and #N$03 cells high, and these
. are the first two bytes of the data. They are followed by one attribute for
. each cell. The pixels are at #R$A76E.
  $A7D0,$01 Width = #N(#PEEK(#PC)) bytes.
  $A7D1,$01 Height = #N(#PEEK(#PC)) bytes.
  $A7D2,$0C,$04 #GRAPHIC$01,1(door-colour)

b $A7DE Graphic Attributes: Cave Door Frame
@ $A7DE label=Graphic_Cave_Door_Frame_Attributes
D $A7DE The attributes of the Cave Door Frame graphic, which are shared by
. graphic IDs #N$01 and #N$23. It is #N$04 cells wide and #N$03 cells high, and
. these are the first two bytes of the data. They are followed by one attribute
. for each cell. The pixels are at #R$BCCE.
  $A7DE,$01 Width = #N(#PEEK(#PC)) bytes.
  $A7DF,$01 Height = #N(#PEEK(#PC)) bytes.
  $A7E0,$0C,$04 #GRAPHIC$00,1(cave-door-colour)

b $A7EC Graphic: Table
@ $A7EC label=Graphic_Table
D $A7EC The pixels of the Table graphic, which is graphic ID #N$12. It is #N$04
. bytes wide and #N$16 pixels high. The width and height are the first two bytes
. of the data, and they are followed by the pixels. The colours are set by the
. attributes at #R$A846.
  $A7EC,$01 Width = #N(#PEEK(#PC)) bytes.
  $A7ED,$01 Height = #N(#PEEK(#PC)) pixels.
  $A7EE,$58,$04 #GRAPHIC$11(table)

b $A846 Graphic Attributes: Table
@ $A846 label=Graphic_Table_Attributes
D $A846 The attributes of the Table graphic (graphic ID #N$12). It is #N$04
. cells wide and #N$03 cells high, and these are the first two bytes of the
. data. They are followed by one attribute for each cell. The pixels are at
. #R$A7EC.
  $A846,$01 Width = #N(#PEEK(#PC)) bytes.
  $A847,$01 Height = #N(#PEEK(#PC)) bytes.
  $A848,$0C,$04 #GRAPHIC$11,1(table-colour)

b $A854 Room Attribute Table
@ $A854 label=RoomAttributes
D $A854 Two bytes for each of the #N$97 room IDs (#N$00 to #N$96): the attribute
. used to colour the room (read by #R$9BEA), and the shape of the frame of the
. room, which is the number of an entry in #R$A982. Room #N$96 has shape #N$0C,
. whose frame is the tunnel frame at #R$97A9.
B $A854,$02 Room #N((#PC - $A854) / $02): the attribute is #N(#PEEK(#PC)) and
. the shape is #N(#PEEK(#PC + $01)).
L $A854,$02,$97

b $A982 Room Shape Table
@ $A982 label=RoomShapeTable
D $A982 One entry of six bytes for each of the #N$0D shapes that the frame of a
. room can have, read by #R$9BEA. The entry has the width and the height of the
. floor, the address of the coordinates of the corners of the frame and the
. address of the lists of the lines to draw between those corners. The shape of
. a room comes from its entry in #R$A854. No room uses shapes #N$06 or #N$07.
B $A982,$01 Width: #N(#PEEK(#PC)).
B $A983,$01 Height: #N(#PEEK(#PC)).
W $A984,$02 Coordinates: #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
W $A986,$02 Lines: #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
L $A982,$06,$0D

b $A9D0 Room Shape #N$0B Coordinates
@ $A9D0 label=RoomShape_0B_Coordinates
D $A9D0 The coordinates of the corners of the frame of room shape #N$0B (see
. #R$A982), each of which is an X position followed by a Y position. The corners
. are numbered from #N$00, and the lines between them are listed at #R$A9D8. It
. is used by room #N$8E.
B $A9D0,$02 Corner #N((#PC - $A9D0) / $02).
L $A9D0,$02,$04

b $A9D8 Room Shape #N$0B Lines
@ $A9D8 label=RoomShape_0B_Lines
D $A9D8 The lines that join the corners of the frame of room shape #N$0B (see
. #R$A982). Each list has the corner to start from, followed by the corners to
. draw lines to, and ends with #N$FF. The last byte is #N$FF to end all of the
. lists, and the corners are those at #R$A9D0.
  $A9D8,$03 Start at corner #N$00 and draw lines to corner #N$01.
  $A9DB,$03 Start at corner #N$02 and draw lines to corner #N$03.
  $A9DE,$01 Terminator.

b $A9DF Room Shape #N$00 Coordinates
@ $A9DF label=RoomShape_00_Coordinates
D $A9DF The coordinates of the corners of the frame of room shape #N$00 (see
. #R$A982), each of which is an X position followed by a Y position. The corners
. are numbered from #N$00, and the lines between them are listed at #R$A9EF. It
. is used by 55 rooms.
B $A9DF,$02 Corner #N((#PC - $A9DF) / $02).
L $A9DF,$02,$08

b $A9EF Room Shapes #N$00, #N$03 and #N$04 Lines
@ $A9EF label=RoomShapes_00_03_04_Lines
D $A9EF The lines that join the corners of the frame of room shapes #N$00, #N$03
. and #N$04 (see #R$A982). Each list has the corner to start from, followed by
. the corners to draw lines to, and ends with #N$FF. The last byte is #N$FF to
. end all of the lists, and the corners are those in the coordinates of each
. shape (#R$A9DF for the first).
  $A9EF,$05 Start at corner #N$00 and draw lines to corners #N$01, #N$03 and
. #N$04.
  $A9F4,$05 Start at corner #N$02 and draw lines to corners #N$01, #N$03 and
. #N$06.
  $A9F9,$05 Start at corner #N$05 and draw lines to corners #N$01, #N$04 and
. #N$06.
  $A9FE,$05 Start at corner #N$07 and draw lines to corners #N$03, #N$04 and
. #N$06.
  $AA03,$01 Terminator.

b $AA04 Room Shape #N$01 Coordinates
@ $AA04 label=RoomShape_01_Coordinates
D $AA04 The coordinates of the corners of the frame of room shape #N$01 (see
. #R$A982), each of which is an X position followed by a Y position. The corners
. are numbered from #N$00, and the lines between them are listed at #R$AA78. It
. is used by 31 rooms.
B $AA04,$02 Corner #N((#PC - $AA04) / $02).
L $AA04,$02,$3A

b $AA78 Room Shape #N$01 Lines
@ $AA78 label=RoomShape_01_Lines
D $AA78 The lines that join the corners of the frame of room shape #N$01 (see
. #R$A982). Each list has the corner to start from, followed by the corners to
. draw lines to, and ends with #N$FF. The last byte is #N$FF to end all of the
. lists, and the corners are those at #R$AA04.
  $AA78,$05 Start at corner #N$00 and draw lines to corners #N$2F, #N$31 and
. #N$39.
  $AA7D,$02 Corner #N$01 has no lines to draw.
  $AA7F,$02 Corner #N$02 has no lines to draw.
  $AA81,$05 Start at corner #N$03 and draw lines to corners #N$01, #N$04 and
. #N$20.
  $AA86,$02 Corner #N$04 has no lines to draw.
  $AA88,$05 Start at corner #N$05 and draw lines to corners #N$06, #N$08 and
. #N$04.
  $AA8D,$02 Corner #N$06 has no lines to draw.
  $AA8F,$05 Start at corner #N$07 and draw lines to corners #N$06, #N$08 and
. #N$0B.
  $AA94,$02 Corner #N$08 has no lines to draw.
  $AA96,$05 Start at corner #N$09 and draw lines to corners #N$08, #N$04 and
. #N$02.
  $AA9B,$05 Start at corner #N$0A and draw lines to corners #N$0C, #N$0B and
. #N$06.
  $AAA0,$02 Corner #N$0B has no lines to draw.
  $AAA2,$02 Corner #N$0C has no lines to draw.
  $AAA4,$05 Start at corner #N$0D and draw lines to corners #N$13, #N$0C and
. #N$11.
  $AAA9,$05 Start at corner #N$0E and draw lines to corners #N$0F, #N$0C and
. #N$0B.
  $AAAE,$02 Corner #N$0F has no lines to draw.
  $AAB0,$02 Corner #N$10 has no lines to draw.
  $AAB2,$03 Start at corner #N$11 and draw lines to corner #N$10.
  $AAB5,$05 Start at corner #N$12 and draw lines to corners #N$15, #N$18 and
. #N$10.
  $AABA,$03 Start at corner #N$13 and draw lines to corner #N$10.
  $AABD,$04 Start at corner #N$14 and draw lines to corners #N$17 and #N$13.
  $AAC1,$02 Corner #N$15 has no lines to draw.
  $AAC3,$03 Start at corner #N$16 and draw lines to corner #N$19.
  $AAC6,$02 Corner #N$17 has no lines to draw.
  $AAC8,$02 Corner #N$18 has no lines to draw.
  $AACA,$02 Corner #N$19 has no lines to draw.
  $AACC,$04 Start at corner #N$1A and draw lines to corners #N$19 and #N$35.
  $AAD0,$05 Start at corner #N$1B and draw lines to corners #N$1A, #N$36 and
. #N$16.
  $AAD5,$05 Start at corner #N$1C and draw lines to corners #N$02, #N$1D and
. #N$1E.
  $AADA,$02 Corner #N$1D has no lines to draw.
  $AADC,$02 Corner #N$1E has no lines to draw.
  $AADE,$02 Corner #N$1F has no lines to draw.
  $AAE0,$03 Start at corner #N$20 and draw lines to corner #N$1F.
  $AAE3,$05 Start at corner #N$21 and draw lines to corners #N$1E, #N$22 and
. #N$25.
  $AAE8,$03 Start at corner #N$22 and draw lines to corner #N$1D.
  $AAEB,$05 Start at corner #N$23 and draw lines to corners #N$22, #N$24 and
. #N$25.
  $AAF0,$02 Corner #N$24 has no lines to draw.
  $AAF2,$02 Corner #N$25 has no lines to draw.
  $AAF4,$05 Start at corner #N$26 and draw lines to corners #N$24, #N$25 and
. #N$28.
  $AAF9,$05 Start at corner #N$27 and draw lines to corners #N$24, #N$29 and
. #N$28.
  $AAFE,$02 Corner #N$28 has no lines to draw.
  $AB00,$02 Corner #N$29 has no lines to draw.
  $AB02,$02 Corner #N$2A has no lines to draw.
  $AB04,$03 Start at corner #N$2B and draw lines to corner #N$29.
  $AB07,$04 Start at corner #N$2C and draw lines to corners #N$28 and #N$2D.
  $AB0B,$02 Corner #N$2D has no lines to draw.
  $AB0D,$04 Start at corner #N$2E and draw lines to corners #N$2A and #N$2D.
  $AB11,$04 Start at corner #N$2F and draw lines to corners #N$2D and #N$30.
  $AB15,$04 Start at corner #N$30 and draw lines to corners #N$31 and #N$2E.
  $AB19,$02 Corner #N$31 has no lines to draw.
  $AB1B,$05 Start at corner #N$32 and draw lines to corners #N$31, #N$33 and
. #N$39.
  $AB20,$02 Corner #N$33 has no lines to draw.
  $AB22,$04 Start at corner #N$34 and draw lines to corners #N$33 and #N$36.
  $AB26,$02 Corner #N$35 has no lines to draw.
  $AB28,$02 Corner #N$36 has no lines to draw.
  $AB2A,$02 Corner #N$37 has no lines to draw.
  $AB2C,$05 Start at corner #N$38 and draw lines to corners #N$33, #N$37 and
. #N$39.
  $AB31,$02 Corner #N$39 has no lines to draw.
  $AB33,$01 Terminator.

b $AB34 Room Shape #N$02 Coordinates
@ $AB34 label=RoomShape_02_Coordinates
D $AB34 The coordinates of the corners of the frame of room shape #N$02 (see
. #R$A982), each of which is an X position followed by a Y position. The corners
. are numbered from #N$00, and the lines between them are listed at #R$AB54. It
. is used by rooms #N$01, #N$03, #N$05, #N$07, #N$1F, #N$21, #N$23 and #N$25.
B $AB34,$02 Corner #N((#PC - $AB34) / $02).
L $AB34,$02,$10

b $AB54 Room Shape #N$02 Lines
@ $AB54 label=RoomShape_02_Lines
D $AB54 The lines that join the corners of the frame of room shape #N$02 (see
. #R$A982). Each list has the corner to start from, followed by the corners to
. draw lines to, and ends with #N$FF. The last byte is #N$FF to end all of the
. lists, and the corners are those at #R$AB34.
  $AB54,$05 Start at corner #N$00 and draw lines to corners #N$09, #N$07 and
. #N$01.
  $AB59,$05 Start at corner #N$02 and draw lines to corners #N$01, #N$03 and
. #N$0B.
  $AB5E,$05 Start at corner #N$04 and draw lines to corners #N$03, #N$05 and
. #N$0D.
  $AB63,$05 Start at corner #N$06 and draw lines to corners #N$05, #N$0F and
. #N$07.
  $AB68,$05 Start at corner #N$08 and draw lines to corners #N$07, #N$09 and
. #N$0F.
  $AB6D,$05 Start at corner #N$0A and draw lines to corners #N$01, #N$09 and
. #N$0B.
  $AB72,$05 Start at corner #N$0C and draw lines to corners #N$03, #N$0B and
. #N$0D.
  $AB77,$05 Start at corner #N$0E and draw lines to corners #N$05, #N$0D and
. #N$0F.
  $AB7C,$01 Terminator.

b $AB7D Room Shape #N$03 Coordinates
@ $AB7D label=RoomShape_03_Coordinates
D $AB7D The coordinates of the corners of the frame of room shape #N$03 (see
. #R$A982), each of which is an X position followed by a Y position. The corners
. are numbered from #N$00, and the lines between them are listed at #R$A9EF. It
. is used by 16 rooms.
B $AB7D,$02 Corner #N((#PC - $AB7D) / $02).
L $AB7D,$02,$08

b $AB8D Room Shape #N$04 Coordinates
@ $AB8D label=RoomShape_04_Coordinates
D $AB8D The coordinates of the corners of the frame of room shape #N$04 (see
. #R$A982), each of which is an X position followed by a Y position. The corners
. are numbered from #N$00, and the lines between them are listed at #R$A9EF. It
. is used by 18 rooms.
B $AB8D,$02 Corner #N((#PC - $AB8D) / $02).
L $AB8D,$02,$08

b $AB9D Room Shape #N$06 Coordinates
@ $AB9D label=RoomShape_06_Coordinates
D $AB9D The coordinates of the corners of the frame of room shape #N$06 (see
. #R$A982), each of which is an X position followed by a Y position. The corners
. are numbered from #N$00, and the lines between them are listed at #R$ABE9. No
. room uses this shape.
B $AB9D,$02 Corner #N((#PC - $AB9D) / $02).
L $AB9D,$02,$26

b $ABE9 Room Shapes #N$05 to #N$08 Lines
@ $ABE9 label=RoomShapes_05_to_08_Lines
D $ABE9 The lines that join the corners of the frame of room shapes #N$05,
. #N$06, #N$07 and #N$08 (see #R$A982). Each list has the corner to start from,
. followed by the corners to draw lines to, and ends with #N$FF. The last byte
. is #N$FF to end all of the lists, and the corners are those in the coordinates
. of each shape (#R$AC4A for the first).
  $ABE9,$02 Corner #N$01 has no lines to draw.
  $ABEB,$04 Start at corner #N$02 and draw lines to corners #N$03 and #N$01.
  $ABEF,$02 Corner #N$03 has no lines to draw.
  $ABF1,$04 Start at corner #N$04 and draw lines to corners #N$01 and #N$03.
  $ABF5,$03 Start at corner #N$05 and draw lines to corner #N$01.
  $ABF8,$04 Start at corner #N$06 and draw lines to corners #N$23 and #N$05.
  $ABFC,$02 Corner #N$07 has no lines to draw.
  $ABFE,$04 Start at corner #N$08 and draw lines to corners #N$21 and #N$07.
  $AC02,$02 Corner #N$09 has no lines to draw.
  $AC04,$04 Start at corner #N$0A and draw lines to corners #N$1F and #N$09.
  $AC08,$02 Corner #N$0B has no lines to draw.
  $AC0A,$04 Start at corner #N$0C and draw lines to corners #N$1D and #N$0B.
  $AC0E,$02 Corner #N$0D has no lines to draw.
  $AC10,$04 Start at corner #N$0E and draw lines to corners #N$1B and #N$0D.
  $AC14,$02 Corner #N$0F has no lines to draw.
  $AC16,$04 Start at corner #N$10 and draw lines to corners #N$19 and #N$0F.
  $AC1A,$02 Corner #N$11 has no lines to draw.
  $AC1C,$05 Start at corner #N$12 and draw lines to corners #N$17, #N$11 and
. #N$02.
  $AC21,$03 Start at corner #N$17 and draw lines to corner #N$03.
  $AC24,$03 Start at corner #N$18 and draw lines to corner #N$17.
  $AC27,$02 Corner #N$19 has no lines to draw.
  $AC29,$03 Start at corner #N$1A and draw lines to corner #N$19.
  $AC2C,$02 Corner #N$1B has no lines to draw.
  $AC2E,$03 Start at corner #N$1C and draw lines to corner #N$1B.
  $AC31,$02 Corner #N$1D has no lines to draw.
  $AC33,$03 Start at corner #N$1E and draw lines to corner #N$1D.
  $AC36,$02 Corner #N$1F has no lines to draw.
  $AC38,$03 Start at corner #N$20 and draw lines to corner #N$1F.
  $AC3B,$02 Corner #N$21 has no lines to draw.
  $AC3D,$03 Start at corner #N$22 and draw lines to corner #N$21.
  $AC40,$02 Corner #N$23 has no lines to draw.
  $AC42,$05 Start at corner #N$24 and draw lines to corners #N$04, #N$05 and
. #N$23.
  $AC47,$02 Corner #N$25 has no lines to draw.
  $AC49,$01 Terminator.

b $AC4A Room Shape #N$05 Coordinates
@ $AC4A label=RoomShape_05_Coordinates
D $AC4A The coordinates of the corners of the frame of room shape #N$05 (see
. #R$A982), each of which is an X position followed by a Y position. The corners
. are numbered from #N$00, and the lines between them are listed at #R$ABE9. It
. is used by rooms #N$1A, #N$26, #N$2F, #N$71 and #N$72.
B $AC4A,$02 Corner #N((#PC - $AC4A) / $02).
L $AC4A,$02,$26

b $AC96 Room Shape #N$07 Coordinates
@ $AC96 label=RoomShape_07_Coordinates
D $AC96 The coordinates of the corners of the frame of room shape #N$07 (see
. #R$A982), each of which is an X position followed by a Y position. The corners
. are numbered from #N$00, and the lines between them are listed at #R$ABE9. No
. room uses this shape.
B $AC96,$02 Corner #N((#PC - $AC96) / $02).
L $AC96,$02,$26

b $ACE2 Room Shape #N$08 Coordinates
@ $ACE2 label=RoomShape_08_Coordinates
D $ACE2 The coordinates of the corners of the frame of room shape #N$08 (see
. #R$A982), each of which is an X position followed by a Y position. The corners
. are numbered from #N$00, and the lines between them are listed at #R$ABE9. It
. is used by room #N$1C.
B $ACE2,$02 Corner #N((#PC - $ACE2) / $02).
L $ACE2,$02,$26

b $AD2E Sprite: Knight
@ $AD2E label=Sprite_Knight_Down_1
D $AD2E The Knight sprites. There are twelve frames in this block, each #N$12
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$01 to #N$10 (see
. #R$A4BE). There are more IDs than frames, as some of the frames are used by
. more than one ID.
E $AD2E #UDGTABLE(default,centre)
. { =h Down | =h Up | =h Left | =h Right }{
. #FRAMES(knight-down-01,25;knight-down-02;knight-down-03;knight-down-02)(knight-down) |
. #FRAMES(knight-up-01,25;knight-up-02;knight-up-03;knight-up-02)(knight-up) |
. #FRAMES(knight-left-01,25;knight-left-02;knight-left-03;knight-left-02)(knight-left) |
. #FRAMES(knight-right-01,25;knight-right-02;knight-right-03;knight-right-02)(knight-right)
. }
. UDGTABLE#
N $AD2E Down Frame 1.
  $AD2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $AD2F,$24,$02 #SPRITE$0C(knight-down-01*)

N $AD53 Down Frame 2.
@ $AD53 label=Sprite_Knight_Down_2
  $AD53,$01 Height = #N(#PEEK(#PC)) pixels.
  $AD54,$24,$02 #SPRITE$0D(knight-down-02*)

N $AD78 Down Frame 3.
@ $AD78 label=Sprite_Knight_Down_3
  $AD78,$01 Height = #N(#PEEK(#PC)) pixels.
  $AD79,$24,$02 #SPRITE$0E(knight-down-03*)

N $AD9D Up Frame 1.
@ $AD9D label=Sprite_Knight_Up_1
  $AD9D,$01 Height = #N(#PEEK(#PC)) pixels.
  $AD9E,$24,$02 #SPRITE$08(knight-up-01*)

N $ADC2 Up Frame 2.
@ $ADC2 label=Sprite_Knight_Up_2
  $ADC2,$01 Height = #N(#PEEK(#PC)) pixels.
  $ADC3,$24,$02 #SPRITE$09(knight-up-02*)

N $ADE7 Up Frame 3.
@ $ADE7 label=Sprite_Knight_Up_3
  $ADE7,$01 Height = #N(#PEEK(#PC)) pixels.
  $ADE8,$24,$02 #SPRITE$0A(knight-up-03*)

N $AE0C Left Frame 1.
@ $AE0C label=Sprite_Knight_Left_1
  $AE0C,$01 Height = #N(#PEEK(#PC)) pixels.
  $AE0D,$24,$02 #SPRITE$00(knight-left-01*)

N $AE31 Left Frame 2.
@ $AE31 label=Sprite_Knight_Left_2
  $AE31,$01 Height = #N(#PEEK(#PC)) pixels.
  $AE32,$24,$02 #SPRITE$01(knight-left-02*)

N $AE56 Left Frame 3.
@ $AE56 label=Sprite_Knight_Left_3
  $AE56,$01 Height = #N(#PEEK(#PC)) pixels.
  $AE57,$24,$02 #SPRITE$02(knight-left-03*)

N $AE7B Right Frame 1.
@ $AE7B label=Sprite_Knight_Right_1
  $AE7B,$01 Height = #N(#PEEK(#PC)) pixels.
  $AE7C,$24,$02 #SPRITE$04(knight-right-01*)

N $AEA0 Right Frame 2.
@ $AEA0 label=Sprite_Knight_Right_2
  $AEA0,$01 Height = #N(#PEEK(#PC)) pixels.
  $AEA1,$24,$02 #SPRITE$05(knight-right-02*)

N $AEC5 Right Frame 3.
@ $AEC5 label=Sprite_Knight_Right_3
  $AEC5,$01 Height = #N(#PEEK(#PC)) pixels.
  $AEC6,$24,$02 #SPRITE$06(knight-right-03*)

b $AEEA Sprite: None
@ $AEEA label=Sprite_None
D $AEEA A sprite with a height of #N$00, so nothing is drawn. It is used by
. sprite IDs #N$64, #N$65 and #N$A0 (which make sound effects), #N$66 (which
. makes the player appear) and #N$67 (which makes the player vanish), as these
. entities have nothing to draw.
.
. As its two bytes are both zero, it is also used as an empty graphic (a width
. and a height of #N$00) by the graphic IDs #N$04 to #N$07 and #N$1F in #R$A600,
. and as an empty set of attributes by the graphic IDs #N$04 to #N$07, #N$13,
. #N$14 and #N$1F in #R$A64E.
  $AEEA,$01 Height = #N(#PEEK(#PC)) pixels.
  $AEEB,$01

b $AEEC Sprite: Blank
@ $AEEC label=Sprite_Blank
D $AEEC The Blank sprite, which is a single frame that is #N$10 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$31 (see #R$A4BE).
  $AEEC,$01 Height = #N(#PEEK(#PC)) pixels.
  $AEED,$20,$02 #SPRITE$30(blank)

b $AF0D Sprite: Leaf
@ $AF0D label=Sprite_Leaf
D $AF0D The Leaf sprite, which is a single frame that is #N$10 pixels high. Each
. frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$80 (see #R$A4BE).
  $AF0D,$01 Height = #N(#PEEK(#PC)) pixels.
  $AF0E,$20,$02 #SPRITE$7F(leaf)

b $AF2E Sprite: Key
@ $AF2E label=Sprite_Key
D $AF2E The Key sprite, which is a single frame that is #N$0A pixels high. Each
. frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$81 (see #R$A4BE).
  $AF2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $AF2F,$14,$02 #SPRITE$80(key)

b $AF43 Sprite: Wine
@ $AF43 label=Sprite_Wine
D $AF43 The Wine sprite, which is a single frame that is #N$14 pixels high. Each
. frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$82 (see #R$A4BE).
  $AF43,$01 Height = #N(#PEEK(#PC)) pixels.
  $AF44,$28,$02 #SPRITE$81(wine)

b $AF6C Sprite: Bottle
@ $AF6C label=Sprite_Bottle
D $AF6C The Bottle sprite, which is a single frame that is #N$14 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$57 (see #R$A4BE).
  $AF6C,$01 Height = #N(#PEEK(#PC)) pixels.
  $AF6D,$28,$02 #SPRITE$56(bottle)

b $AF95 Sprite: Wing
@ $AF95 label=Sprite_Wing
D $AF95 The Wing sprite, which is a single frame that is #N$10 pixels high. Each
. frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$84 (see #R$A4BE).
  $AF95,$01 Height = #N(#PEEK(#PC)) pixels.
  $AF96,$20,$02 #SPRITE$83(wing)

b $AFB6 Sprite: Whip
@ $AFB6 label=Sprite_Whip
D $AFB6 The Whip sprite, which is a single frame that is #N$10 pixels high. Each
. frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$85 (see #R$A4BE).
  $AFB6,$01 Height = #N(#PEEK(#PC)) pixels.
  $AFB7,$20,$02 #SPRITE$84(whip)

b $AFD7 Sprite: Frog Leg
@ $AFD7 label=Sprite_Frog_Leg
D $AFD7 The Frog Leg sprite, which is a single frame that is #N$10 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$86 (see #R$A4BE).
  $AFD7,$01 Height = #N(#PEEK(#PC)) pixels.
  $AFD8,$20,$02 #SPRITE$85(frogleg)

b $AFF8 Sprite: Dessert
@ $AFF8 label=Sprite_Dessert
D $AFF8 The Dessert sprite, which is a single frame that is #N$10 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$55 (see #R$A4BE).
  $AFF8,$01 Height = #N(#PEEK(#PC)) pixels.
  $AFF9,$20,$02 #SPRITE$54(dessert)

b $B019 Sprite: Apple
@ $B019 label=Sprite_Apple
D $B019 The Apple sprite, which is a single frame that is #N$10 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$56 (see #R$A4BE).
  $B019,$01 Height = #N(#PEEK(#PC)) pixels.
  $B01A,$20,$02 #SPRITE$55(apple)

b $B03A Side Panel UDGs
@ $B03A label=SidePanelUDG
D $B03A The image is assembled by #R$A219 using the data held at #R$B32A.
  $B03A,$08 #UDG(#PC)
L $B03A,$08,$5E

b $B32A Side Panel Data
@ $B32A label=SidePanelData
D $B32A Uses the UDG data at #R$B03A. The image is assembled by #R$A219.
  $B32A,$08 #FOR($00,$07)||x|#UDG($B03A + (#PEEK(#PC + x) * $08))||
L $B32A,$08,$18

b $B3EA Graphic: Big Door Frame
@ $B3EA label=Graphic_Big_Door_Frame
D $B3EA The pixels of the Big Door Frame graphic, which is graphic ID #N$03. It
. is #N$06 bytes wide and #N$20 pixels high. The width and height are the first
. two bytes of the data, and they are followed by the pixels. The colours are
. set by the attributes at #R$B4AC.
  $B3EA,$01 Width = #N(#PEEK(#PC)) bytes.
  $B3EB,$01 Height = #N(#PEEK(#PC)) pixels.
  $B3EC,$C0,$04 #GRAPHIC$02(big-door)

b $B4AC Graphic Attributes: Big Door Frame
@ $B4AC label=Graphic_Big_Door_Frame_Attributes
D $B4AC The attributes of the Big Door Frame graphic (graphic ID #N$03). It is
. #N$06 cells wide and #N$04 cells high, and these are the first two bytes of
. the data. They are followed by one attribute for each cell. The pixels are at
. #R$B3EA.
  $B4AC,$01 Width = #N(#PEEK(#PC)) bytes.
  $B4AD,$01 Height = #N(#PEEK(#PC)) pixels.
  $B4AE,$18,$04 #GRAPHIC$02,1(big-door-colour)

b $B4C6 Graphic: Ghost Picture
@ $B4C6 label=Graphic_Ghost_Picture
D $B4C6 The pixels of the Ghost Picture graphic, which is graphic ID #N$11. It
. is #N$04 bytes wide and #N$18 pixels high. The width and height are the first
. two bytes of the data, and they are followed by the pixels. The colours are
. set by the attributes at #R$B528.
  $B4C6,$01 Width = #N(#PEEK(#PC)) bytes.
  $B4C7,$01 Height = #N(#PEEK(#PC)) pixels.
  $B4C8,$60,$04 #GRAPHIC$10(ghost-pic)

b $B528 Graphic Attributes: Ghost Picture
@ $B528 label=Graphic_Ghost_Picture_Attributes
D $B528 The attributes of the Ghost Picture graphic (graphic ID #N$11). It is
. #N$04 cells wide and #N$03 cells high, and these are the first two bytes of
. the data. They are followed by one attribute for each cell. The pixels are at
. #R$B4C6.
  $B528,$01 Width = #N(#PEEK(#PC)) bytes.
  $B529,$01 Height = #N(#PEEK(#PC)) bytes.
  $B52A,$0C,$04 #GRAPHIC$10,1(ghost-pic-colour)

b $B536 Sprite: Serf
@ $B536 label=Sprite_Serf_Down_1
D $B536 The Serf sprites. There are twelve frames in this block, each #N$12
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$21 to #N$30 (see
. #R$A4BE). There are more IDs than frames, as some of the frames are used by
. more than one ID.
E $B536 #UDGTABLE(default,centre)
. { =h Down | =h Up | =h Left | =h Right }{
. #FRAMES(serf-down-01,25;serf-down-02;serf-down-03;serf-down-02)(serf-down) |
. #FRAMES(serf-up-01,25;serf-up-02;serf-up-03;serf-up-02)(serf-up) |
. #FRAMES(serf-left-01,25;serf-left-02;serf-left-03;serf-left-02)(serf-left) |
. #FRAMES(serf-right-01,25;serf-right-02;serf-right-03;serf-right-02)(serf-right)
. }
. UDGTABLE#
N $B536 Down Frame 1.
  $B536,$01 Height = #N(#PEEK(#PC)) pixels.
  $B537 #SPRITE$2C(serf-down-01*)

N $B55B Down Frame 2.
@ $B55B label=Sprite_Serf_Down_2
  $B55B,$01 Height = #N(#PEEK(#PC)) pixels.
  $B55C #SPRITE$2D(serf-down-02*)

N $B580 Down Frame 3.
@ $B580 label=Sprite_Serf_Down_3
  $B580,$01 Height = #N(#PEEK(#PC)) pixels.
  $B581 #SPRITE$2E(serf-down-03*)

N $B5A5 Up Frame 1.
@ $B5A5 label=Sprite_Serf_Up_1
  $B5A5,$01 Height = #N(#PEEK(#PC)) pixels.
  $B5A6 #SPRITE$28(serf-up-01*)

N $B5CA Up Frame 2.
@ $B5CA label=Sprite_Serf_Up_2
  $B5CA,$01 Height = #N(#PEEK(#PC)) pixels.
  $B5CB #SPRITE$29(serf-up-02*)

N $B5EF Up Frame 3.
@ $B5EF label=Sprite_Serf_Up_3
  $B5EF,$01 Height = #N(#PEEK(#PC)) pixels.
  $B5F0 #SPRITE$2A(serf-up-03*)

N $B614 Left Frame 1.
@ $B614 label=Sprite_Serf_Left_1
  $B614,$01 Height = #N(#PEEK(#PC)) pixels.
  $B615 #SPRITE$20(serf-left-01*)

N $B639 Left Frame 2.
@ $B639 label=Sprite_Serf_Left_2
  $B639,$01 Height = #N(#PEEK(#PC)) pixels.
  $B63A #SPRITE$21(serf-left-02*)

N $B65E Left Frame 3.
@ $B65E label=Sprite_Serf_Left_3
  $B65E,$01 Height = #N(#PEEK(#PC)) pixels.
  $B65F #SPRITE$22(serf-left-03*)

N $B683 Right Frame 1.
@ $B683 label=Sprite_Serf_Right_1
  $B683,$01 Height = #N(#PEEK(#PC)) pixels.
  $B684 #SPRITE$24(serf-right-01*)

N $B6A8 Right Frame 2.
@ $B6A8 label=Sprite_Serf_Right_2
  $B6A8,$01 Height = #N(#PEEK(#PC)) pixels.
  $B6A9 #SPRITE$25(serf-right-02*)

N $B6CD Right Frame 3.
@ $B6CD label=Sprite_Serf_Right_3
  $B6CD,$01 Height = #N(#PEEK(#PC)) pixels.
  $B6CE #SPRITE$26(serf-right-03*)

b $B6F2 Graphic: Clock
@ $B6F2 label=Graphic_Clock
D $B6F2 The pixels of the Clock graphic, which is graphic ID #N$10. It is #N$04
. bytes wide and #N$20 pixels high. The width and height are the first two bytes
. of the data, and they are followed by the pixels. The colours are set by the
. attributes at #R$B774.
  $B6F2,$01 Width = #N(#PEEK(#PC)) bytes.
  $B6F3,$01 Height = #N(#PEEK(#PC)) pixels.
  $B6F4,$80,$04 #GRAPHIC$0F(clock)

b $B774 Graphic Attributes: Clock
@ $B774 label=Graphic_Clock_Attributes
D $B774 The attributes of the Clock graphic (graphic ID #N$10). It is #N$04
. cells wide and #N$04 cells high, and these are the first two bytes of the
. data. They are followed by one attribute for each cell. The pixels are at
. #R$B6F2.
  $B774,$01 Width = #N(#PEEK(#PC)) bytes.
  $B775,$01 Height = #N(#PEEK(#PC)) bytes.
  $B776,$10,$04 #GRAPHIC$0F,1(clock-colour)

b $B786 Sprite: Wizard
@ $B786 label=Sprite_Wizard_Down_1
D $B786 The Wizard sprites. There are twelve frames in this block, each #N$14
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$11 to #N$20 (see
. #R$A4BE). There are more IDs than frames, as some of the frames are used by
. more than one ID.
E $B786 #UDGTABLE(default,centre)
. { =h Down | =h Up | =h Left | =h Right }{
. #FRAMES(wizard-down-01,25;wizard-down-02;wizard-down-03;wizard-down-02)(wizard-down) |
. #FRAMES(wizard-up-01,25;wizard-up-02;wizard-up-03;wizard-up-02)(wizard-up) |
. #FRAMES(wizard-left-01,25;wizard-left-02;wizard-left-03;wizard-left-02)(wizard-left) |
. #FRAMES(wizard-right-01,25;wizard-right-02;wizard-right-03;wizard-right-02)(wizard-right)
. }
. UDGTABLE#
N $B786 Down Frame 1.
  $B786,$01 Height = #N(#PEEK(#PC)) pixels.
  $B787,$28,$02 #SPRITE$1C(wizard-down-01*)

N $B7AF Down Frame 2.
@ $B7AF label=Sprite_Wizard_Down_2
  $B7AF,$01 Height = #N(#PEEK(#PC)) pixels.
  $B7B0,$28,$02 #SPRITE$1D(wizard-down-02*)

N $B7D8 Down Frame 3.
@ $B7D8 label=Sprite_Wizard_Down_3
  $B7D8,$01 Height = #N(#PEEK(#PC)) pixels.
  $B7D9,$28,$02 #SPRITE$1E(wizard-down-03*)

N $B801 Up Frame 1.
@ $B801 label=Sprite_Wizard_Up_1
  $B801,$01 Height = #N(#PEEK(#PC)) pixels.
  $B802,$28,$02 #SPRITE$18(wizard-up-01*)

N $B82A Up Frame 2.
@ $B82A label=Sprite_Wizard_Up_2
  $B82A,$01 Height = #N(#PEEK(#PC)) pixels.
  $B82B,$28,$02 #SPRITE$19(wizard-up-02*)

N $B853 Up Frame 3.
@ $B853 label=Sprite_Wizard_Up_3
  $B853,$01 Height = #N(#PEEK(#PC)) pixels.
  $B854,$28,$02 #SPRITE$1A(wizard-up-03*)

N $B87C Left Frame 1.
@ $B87C label=Sprite_Wizard_Left_1
  $B87C,$01 Height = #N(#PEEK(#PC)) pixels.
  $B87D,$28,$02 #SPRITE$10(wizard-left-01*)

N $B8A5 Left Frame 2.
@ $B8A5 label=Sprite_Wizard_Left_2
  $B8A5,$01 Height = #N(#PEEK(#PC)) pixels.
  $B8A6,$28,$02 #SPRITE$11(wizard-left-02*)

N $B8CE Left Frame 3.
@ $B8CE label=Sprite_Wizard_Left_3
  $B8CE,$01 Height = #N(#PEEK(#PC)) pixels.
  $B8CF,$28,$02 #SPRITE$12(wizard-left-03*)

N $B8F7 Right Frame 1.
@ $B8F7 label=Sprite_Wizard_Right_1
  $B8F7,$01 Height = #N(#PEEK(#PC)) pixels.
  $B8F8,$28,$02 #SPRITE$14(wizard-right-01*)

N $B920 Right Frame 2.
@ $B920 label=Sprite_Wizard_Right_2
  $B920,$01 Height = #N(#PEEK(#PC)) pixels.
  $B921,$28,$02 #SPRITE$15(wizard-right-02*)

N $B949 Right Frame 3.
@ $B949 label=Sprite_Wizard_Right_3
  $B949,$01 Height = #N(#PEEK(#PC)) pixels.
  $B94A,$28,$02 #SPRITE$16(wizard-right-03*)

b $B972 Sprite: Sword
@ $B972 label=Sprite_Sword_7
D $B972 The Sword sprites. There are eight frames in this block, with heights of
. #N$0C, #N$0D, #N$10, #N$0D, #N$0C, #N$0C, #N$10 and #N$10 pixels. Each frame
. is its height, followed by two bytes for each row, so the sprite is #N$10
. pixels wide. The sprite IDs are #N$38 to #N$3F (see #R$A4BE). The frames are
. not stored in the order of their IDs.
N $B972 Frame 7.
  $B972,$01 Height = #N(#PEEK(#PC)) pixels.
  $B973,$18,$02 #SPRITE$3D(sword-07)

N $B98B Frame 4.
@ $B98B label=Sprite_Sword_4
  $B98B,$01 Height = #N(#PEEK(#PC)) pixels.
  $B98C,$1A,$02 #SPRITE$3A(sword-04)

N $B9A6 Frame 5.
@ $B9A6 label=Sprite_Sword_5
  $B9A6,$01 Height = #N(#PEEK(#PC)) pixels.
  $B9A7,$20,$02 #SPRITE$3B(sword-05)

N $B9C7 Frame 6.
@ $B9C7 label=Sprite_Sword_6
  $B9C7,$01 Height = #N(#PEEK(#PC)) pixels.
  $B9C8,$1A,$02 #SPRITE$3C(sword-06)

N $B9E2 Frame 3.
@ $B9E2 label=Sprite_Sword_3
  $B9E2,$01 Height = #N(#PEEK(#PC)) pixels.
  $B9E3,$18,$02 #SPRITE$39(sword-03)

N $B9FB Frame 2.
@ $B9FB label=Sprite_Sword_2
  $B9FB,$01 Height = #N(#PEEK(#PC)) pixels.
  $B9FC,$18,$02 #SPRITE$38(sword-02)
  $BA14,$02 Two more bytes after the last row. The height of this frame is
. #N$0C, so these are never drawn.

N $BA16 Frame 1.
@ $BA16 label=Sprite_Sword_1
  $BA16,$01 Height = #N(#PEEK(#PC)) pixels.
  $BA17,$20,$02 #SPRITE$37(sword-01)

N $BA37 Frame 8.
@ $BA37 label=Sprite_Sword_8
  $BA37,$01 Height = #N(#PEEK(#PC)) pixels.
  $BA38,$20,$02 #SPRITE$3E(sword-08)

b $BA58 Sprite: Axe
@ $BA58 label=Sprite_Axe_1
D $BA58 The Axe sprites. There are eight frames in this block, each #N$10 pixels
. high. Each frame is its height, followed by two bytes for each row, so the
. sprite is #N$10 pixels wide. The sprite IDs are #N$40 to #N$47 (see #R$A4BE).
E $BA58 #FRAMES(axe-01,25;axe-02;axe-03;axe-04;axe-05;axe-06;axe-07;axe-08)(axe)
N $BA58 Frame 1.
  $BA58,$01 Height = #N(#PEEK(#PC)) pixels.
  $BA59,$20,$02 #SPRITE$3F(axe-01*)

N $BA79 Frame 2.
@ $BA79 label=Sprite_Axe_2
  $BA79,$01 Height = #N(#PEEK(#PC)) pixels.
  $BA7A,$20,$02 #SPRITE$40(axe-02*)

N $BA9A Frame 3.
@ $BA9A label=Sprite_Axe_3
  $BA9A,$01 Height = #N(#PEEK(#PC)) pixels.
  $BA9B,$20,$02 #SPRITE$41(axe-03*)

N $BABB Frame 4.
@ $BABB label=Sprite_Axe_4
  $BABB,$01 Height = #N(#PEEK(#PC)) pixels.
  $BABC,$20,$02 #SPRITE$42(axe-04*)

N $BADC Frame 5.
@ $BADC label=Sprite_Axe_5
  $BADC,$01 Height = #N(#PEEK(#PC)) pixels.
  $BADD,$20,$02 #SPRITE$43(axe-05*)

N $BAFD Frame 6.
@ $BAFD label=Sprite_Axe_6
  $BAFD,$01 Height = #N(#PEEK(#PC)) pixels.
  $BAFE,$20,$02 #SPRITE$44(axe-06*)

N $BB1E Frame 7.
@ $BB1E label=Sprite_Axe_7
  $BB1E,$01 Height = #N(#PEEK(#PC)) pixels.
  $BB1F,$20,$02 #SPRITE$45(axe-07*)

N $BB3F Frame 8.
@ $BB3F label=Sprite_Axe_8
  $BB3F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BB40,$20,$02 #SPRITE$46(axe-08*)

b $BB60 Sprite: Fireball
@ $BB60 label=Sprite_Fireball_1
D $BB60 The Fireball sprites. There are four frames in this block, each #N$0F
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$34 to #N$37 (see
. #R$A4BE).
E $BB60 #FRAMES(fireball-01,25;fireball-02;fireball-03;fireball-04)(fireball)
N $BB60 Frame 1.
  $BB60,$01 Height = #N(#PEEK(#PC)) pixels.
  $BB61,$1E,$02 #SPRITE$33(fireball-01*)

N $BB7F Frame 2.
@ $BB7F label=Sprite_Fireball_2
  $BB7F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BB80,$1E,$02 #SPRITE$34(fireball-02*)

N $BB9E Frame 3.
@ $BB9E label=Sprite_Fireball_3
  $BB9E,$01 Height = #N(#PEEK(#PC)) pixels.
  $BB9F,$1E,$02 #SPRITE$35(fireball-03*)

N $BBBD Frame 4.
@ $BBBD label=Sprite_Fireball_4
  $BBBD,$01 Height = #N(#PEEK(#PC)) pixels.
  $BBBE,$1E,$02 #SPRITE$36(fireball-04*)

b $BBDC Sprite: Cursor
@ $BBDC label=Sprite_Cursor_Left
D $BBDC The Cursor sprites. There are two frames in this block, each #N$14
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$32 and #N$33 (see
. #R$A4BE).
E $BBDC #UDGTABLE(default) { =h Output: } { #SPRITE$31(cursor-left)#SPRITE$32(cursor-right) } UDGTABLE#
N $BBDC Left.
  $BBDC,$01 Height = #N(#PEEK(#PC)) pixels.
  $BBDD,$28,$02 #SPRITE$31(cursor-left)

N $BC05 Right.
@ $BC05 label=Sprite_Cursor_Right
  $BC05,$01 Height = #N(#PEEK(#PC)) pixels.
  $BC06,$28,$02 #SPRITE$32(cursor-right)

b $BC2E Sprite: Keyboard
@ $BC2E label=Sprite_Keyboard_Left
D $BC2E The Keyboard sprites. There are two frames in this block, each #N$10
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$48 and #N$49 (see
. #R$A4BE).
E $BC2E #UDGTABLE(default) { =h Output: } { #SPRITE$47(keyboard-left)#SPRITE$48(keyboard-right) } UDGTABLE#
N $BC2E Left.
  $BC2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $BC2F,$20,$02 #SPRITE$47(keyboard-left)

N $BC4F Right.
@ $BC4F label=Sprite_Keyboard_Right
  $BC4F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BC50,$20,$02 #SPRITE$48(keyboard-right)

b $BC70 Sprite: Kempston
@ $BC70 label=Sprite_Joystick_Left
D $BC70 The Kempston sprites. There are two frames in this block, each #N$17
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$4A and #N$4B (see
. #R$A4BE).
E $BC70 #UDGTABLE(default) { =h Output: } { #SPRITE$49(kempston-left)#SPRITE$4A(kempston-right) } UDGTABLE#
N $BC70 Left.
  $BC70,$01 Height = #N(#PEEK(#PC)) pixels.
  $BC71,$2E,$02 #SPRITE$49(kempston-left)

N $BC9F Right.
@ $BC9F label=Sprite_Joystick_Right
  $BC9F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BCA0,$2E,$02 #SPRITE$4A(kempston-right)

b $BCCE Graphic: Cave Door Frame
@ $BCCE label=Graphic_Cave_Door_Frame
D $BCCE The pixels of the Cave Door Frame graphic, which are shared by graphic
. IDs #N$01 and #N$23. It is #N$04 bytes wide and #N$18 pixels high. The width
. and height are the first two bytes of the data, and they are followed by the
. pixels. The colours are set by the attributes at #R$A7DE.
  $BCCE,$01 Width = #N(#PEEK(#PC)) bytes.
  $BCCF,$01 Height = #N(#PEEK(#PC)) pixels.
  $BCD0,$60,$04 #GRAPHIC$00(cave-door)

b $BD30 Sprite: Pumpkin
@ $BD30 label=Sprite_Pumpkin_1
D $BD30 The Pumpkin sprites. There are two frames in this block, each #N$13
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$4C and #N$4D (see
. #R$A4BE).
N $BD30 Frame 1.
  $BD30,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD31,$26,$02 #SPRITE$4B(pumpkin-01)

N $BD57 Frame 2.
@ $BD57 label=Sprite_Pumpkin_2
  $BD57,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD58,$26,$02 #SPRITE$4C(pumpkin-02)

b $BD7E Room Shapes #N$09 and #N$0A Lines
@ $BD7E label=RoomShapes_09_0A_Lines
D $BD7E The lines that join the corners of the frame of room shapes #N$09 and
. #N$0A (see #R$A982). Each list has the corner to start from, followed by the
. corners to draw lines to, and ends with #N$FF. The last byte is #N$FF to end
. all of the lists. The corners are in #R$BED0 for shape #N$09 and #R$BE54 for
. shape #N$0A.
  $BD7E,$05 Start at corner #N$00 and draw lines to corners #N$17, #N$01 and
. #N$04.
  $BD83,$02 Corner #N$01 has no lines to draw.
  $BD85,$05 Start at corner #N$02 and draw lines to corners #N$03, #N$19 and
. #N$01.
  $BD8A,$02 Corner #N$03 has no lines to draw.
  $BD8C,$02 Corner #N$04 has no lines to draw.
  $BD8E,$05 Start at corner #N$05 and draw lines to corners #N$06, #N$1B and
. #N$03.
  $BD93,$02 Corner #N$06 has no lines to draw.
  $BD95,$05 Start at corner #N$07 and draw lines to corners #N$08, #N$06 and
. #N$1D.
  $BD9A,$02 Corner #N$08 has no lines to draw.
  $BD9C,$05 Start at corner #N$09 and draw lines to corners #N$04, #N$33 and
. #N$0A.
  $BDA1,$02 Corner #N$0A has no lines to draw.
  $BDA3,$05 Start at corner #N$0B and draw lines to corners #N$0D, #N$1F and
. #N$08.
  $BDA8,$02 Corner #N$0C has no lines to draw.
  $BDAA,$02 Corner #N$0D has no lines to draw.
  $BDAC,$05 Start at corner #N$0E and draw lines to corners #N$0F, #N$0D and
. #N$0C.
  $BDB1,$02 Corner #N$0F has no lines to draw.
  $BDB3,$05 Start at corner #N$10 and draw lines to corners #N$31, #N$0A and
. #N$35.
  $BDB8,$05 Start at corner #N$11 and draw lines to corners #N$12, #N$23 and
. #N$0F.
  $BDBD,$02 Corner #N$12 has no lines to draw.
  $BDBF,$04 Start at corner #N$13 and draw lines to corners #N$36 and #N$35.
  $BDC3,$05 Start at corner #N$14 and draw lines to corners #N$25, #N$15 and
. #N$12.
  $BDC8,$02 Corner #N$15 has no lines to draw.
  $BDCA,$05 Start at corner #N$16 and draw lines to corners #N$17, #N$04 and
. #N$33.
  $BDCF,$02 Corner #N$17 has no lines to draw.
  $BDD1,$05 Start at corner #N$18 and draw lines to corners #N$19, #N$17 and
. #N$01.
  $BDD6,$02 Corner #N$19 has no lines to draw.
  $BDD8,$05 Start at corner #N$1A and draw lines to corners #N$1B, #N$19 and
. #N$03.
  $BDDD,$02 Corner #N$1B has no lines to draw.
  $BDDF,$05 Start at corner #N$1C and draw lines to corners #N$1D, #N$1B and
. #N$06.
  $BDE4,$02 Corner #N$1D has no lines to draw.
  $BDE6,$05 Start at corner #N$1E and draw lines to corners #N$1F, #N$1D and
. #N$08.
  $BDEB,$02 Corner #N$1F has no lines to draw.
  $BDED,$04 Start at corner #N$20 and draw lines to corners #N$0D and #N$1F.
  $BDF1,$02 Corner #N$21 has no lines to draw.
  $BDF3,$05 Start at corner #N$22 and draw lines to corners #N$23, #N$21 and
. #N$0F.
  $BDF8,$02 Corner #N$23 has no lines to draw.
  $BDFA,$05 Start at corner #N$24 and draw lines to corners #N$25, #N$23 and
. #N$12.
  $BDFF,$02 Corner #N$25 has no lines to draw.
  $BE01,$05 Start at corner #N$26 and draw lines to corners #N$25, #N$27 and
. #N$15.
  $BE06,$02 Corner #N$27 has no lines to draw.
  $BE08,$05 Start at corner #N$28 and draw lines to corners #N$27, #N$29 and
. #N$3C.
  $BE0D,$02 Corner #N$29 has no lines to draw.
  $BE0F,$05 Start at corner #N$2A and draw lines to corners #N$2B, #N$3A and
. #N$29.
  $BE14,$02 Corner #N$2B has no lines to draw.
  $BE16,$05 Start at corner #N$2C and draw lines to corners #N$2D, #N$2B and
. #N$38.
  $BE1B,$02 Corner #N$2D has no lines to draw.
  $BE1D,$05 Start at corner #N$2E and draw lines to corners #N$2F, #N$2D and
. #N$36.
  $BE22,$02 Corner #N$2F has no lines to draw.
  $BE24,$05 Start at corner #N$30 and draw lines to corners #N$13, #N$31 and
. #N$2F.
  $BE29,$02 Corner #N$31 has no lines to draw.
  $BE2B,$05 Start at corner #N$32 and draw lines to corners #N$33, #N$31 and
. #N$0A.
  $BE30,$02 Corner #N$33 has no lines to draw.
  $BE32,$02 Corner #N$34 has no lines to draw.
  $BE34,$03 Start at corner #N$35 and draw lines to corner #N$34.
  $BE37,$02 Corner #N$36 has no lines to draw.
  $BE39,$05 Start at corner #N$37 and draw lines to corners #N$2D, #N$38 and
. #N$36.
  $BE3E,$02 Corner #N$38 has no lines to draw.
  $BE40,$05 Start at corner #N$39 and draw lines to corners #N$2B, #N$38 and
. #N$3A.
  $BE45,$02 Corner #N$3A has no lines to draw.
  $BE47,$05 Start at corner #N$3B and draw lines to corners #N$3A, #N$29 and
. #N$3C.
  $BE4C,$02 Corner #N$3C has no lines to draw.
  $BE4E,$05 Start at corner #N$3D and draw lines to corners #N$15, #N$3C and
. #N$27.
  $BE53,$01 Terminator.

b $BE54 Room Shape #N$0A Coordinates
@ $BE54 label=RoomShape_0A_Coordinates
D $BE54 The coordinates of the corners of the frame of room shape #N$0A (see
. #R$A982), each of which is an X position followed by a Y position. The corners
. are numbered from #N$00, and the lines between them are listed at #R$BD7E. It
. is used by rooms #N$31, #N$32, #N$34, #N$42, #N$49, #N$4D and #N$51. These are
. the same corners as shape #N$09 (at #R$BED0) with the X and Y positions
. swapped. This data is held at the start of the font table, where the graphics
. for the characters below the space would be (see #R$BF4C).
B $BE54,$02 Corner #N((#PC - $BE54) / $02).
L $BE54,$02,$3E

b $BED0 Room Shape #N$09 Coordinates
@ $BED0 label=RoomShape_09_Coordinates
D $BED0 The coordinates of the corners of the frame of room shape #N$09 (see
. #R$A982), each of which is an X position followed by a Y position. The corners
. are numbered from #N$00, and the lines between them are listed at #R$BD7E. It
. is used by rooms #N$36, #N$37, #N$3F, #N$44, #N$47, #N$4A, #N$4F and #N$52.
. These are the same corners as shape #N$0A (at #R$BE54) with the X and Y
. positions swapped. This data is held at the start of the font table, where the
. graphics for the characters below the space would be (see #R$BF4C).
B $BED0,$02 Corner #N((#PC - $BED0) / $02).
L $BED0,$02,$3E

b $BF4C Main Font
@ $BF4C label=MainFont
D $BF4C The graphics for the characters #N$20 to #N$5A of the main font, which
. include the digits and the capital letters. The graphic for a character is
. eight bytes, one for each row. #R$A1D3 finds the graphic from the character
. code and the font pointer in #R$5E01, so the pointer for this font is #N$BE4C,
. which is #N$100 bytes before the first graphic. The digits can be printed from
. their numbers by pointing the font pointer at #R$BFCC, the graphic for "0"
. (see #R$A1AE).
  $BF4C,$08 #UDG(#PC)
@ $BFCC label=MainFont_Zero
L $BF4C,$08,$3B

b $C124 Sprite: Can
@ $C124 label=Sprite_Can
D $C124 The Can sprite, which is a single frame that is #N$14 pixels high. Each
. frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$50 (see #R$A4BE).
  $C124,$01 Height = #N(#PEEK(#PC)) pixels.
  $C125,$28,$02 #SPRITE$4F(can)

b $C14D Sprite: Money Bag
@ $C14D label=Sprite_Money_Bag
D $C14D The Money Bag sprite, which is a single frame that is #N$10 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$88 (see #R$A4BE).
  $C14D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C14E,$20,$02 #SPRITE$87(moneybag)

b $C16E Sprite: Coin
@ $C16E label=Sprite_Coin
D $C16E The Coin sprite, which is a single frame that is #N$10 pixels high. Each
. frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$83 (see #R$A4BE).
  $C16E,$01 Height = #N(#PEEK(#PC)) pixels.
  $C16F,$20,$02 #SPRITE$82(coin)

b $C18F Sprite: Gem
@ $C18F label=Sprite_Gem
D $C18F The Gem sprite, which is a single frame that is #N$0D pixels high. Each
. frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$87 (see #R$A4BE).
  $C18F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C190,$1A,$02 #SPRITE$86(gem)

b $C1AA Sprite: Candy
@ $C1AA label=Sprite_Candy
D $C1AA The Candy sprite, which is a single frame that is #N$10 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$51 (see #R$A4BE).
  $C1AA,$01 Height = #N(#PEEK(#PC)) pixels.
  $C1AB,$20,$02 #SPRITE$50(candy)

b $C1CB Sprite: Chop
@ $C1CB label=Sprite_Chop
D $C1CB The Chop sprite, which is a single frame that is #N$14 pixels high. Each
. frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$52 (see #R$A4BE).
  $C1CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $C1CC,$28,$02 #SPRITE$51(chop)

b $C1F4 Sprite: Lollipop
@ $C1F4 label=Sprite_Lollipop
D $C1F4 The Lollipop sprite, which is a single frame that is #N$12 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$53 (see #R$A4BE).
  $C1F4,$01 Height = #N(#PEEK(#PC)) pixels.
  $C1F5,$24,$02 #SPRITE$52(lollipop)

b $C219 Sprite: Ice Cream
@ $C219 label=Sprite_Ice_Cream
D $C219 The Ice Cream sprite, which is a single frame that is #N$10 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$54 (see #R$A4BE).
  $C219,$01 Height = #N(#PEEK(#PC)) pixels.
  $C21A,$20,$02 #SPRITE$53(icecream)

b $C23A Sprite: Sparkle
@ $C23A label=Sprite_Sparkle_1
D $C23A The Sparkle sprites. There are four frames in this block, with heights
. of #N$0C, #N$0D, #N$0F and #N$10 pixels. Each frame is its height, followed by
. two bytes for each row, so the sprite is #N$10 pixels wide. The sprite IDs are
. #N$58 to #N$5B (see #R$A4BE).
E $C23A #FRAMES(sparkle-04,25;sparkle-03;sparkle-02;sparkle-01)(sparkle)
N $C23A Frame 1.
  $C23A,$01 Height = #N(#PEEK(#PC)) pixels.
  $C23B,$18,$02 #SPRITE$57(sparkle-01*)

N $C253 Frame 2.
@ $C253 label=Sprite_Sparkle_2
  $C253,$01 Height = #N(#PEEK(#PC)) pixels.
  $C254,$1A,$02 #SPRITE$58(sparkle-02*)

N $C26E Frame 3.
@ $C26E label=Sprite_Sparkle_3
  $C26E,$01 Height = #N(#PEEK(#PC)) pixels.
  $C26F,$1E,$02 #SPRITE$59(sparkle-03*)

N $C28D Frame 4.
@ $C28D label=Sprite_Sparkle_4
  $C28D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C28E,$20,$02 #SPRITE$5A(sparkle-04*)

b $C2AE Graphic: Cave Door Locked
@ $C2AE label=Graphic_Cave_Door_Locked
D $C2AE The pixels of the Cave Door Locked graphic, which are shared by graphic
. IDs #N$0C to #N$0F. It is #N$04 bytes wide and #N$18 pixels high. The width
. and height are the first two bytes of the data, and they are followed by the
. pixels. The IDs differ in their colours, which are set by the attributes at
. #R$A736, #R$A744, #R$A752 and #R$A760 respectively.
  $C2AE,$01 Width = #N(#PEEK(#PC)) bytes.
  $C2AF,$01 Height = #N(#PEEK(#PC)) pixels.
  $C2B0,$60,$04 #GRAPHIC$0B(cave-door-locked)

b $C310 Sprite: Spider
@ $C310 label=Sprite_Spider_1
D $C310 The Spider sprites. There are two frames in this block, each #N$0E
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$5C and #N$5D (see
. #R$A4BE).
N $C310 Frame 1.
  $C310,$01 Height = #N(#PEEK(#PC)) pixels.
  $C311,$1C,$02 #SPRITE$5B(spider-01)

N $C32D Frame 2.
@ $C32D label=Sprite_Spider_2
  $C32D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C32E,$1C,$02 #SPRITE$5C(spider-02)

b $C34A Sprite: Spikey
@ $C34A label=Sprite_Spikey_1
D $C34A The Spikey sprites. There are two frames in this block, each #N$10
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$5E and #N$5F (see
. #R$A4BE).
N $C34A Frame 1.
  $C34A,$01 Height = #N(#PEEK(#PC)) pixels.
  $C34B,$20,$02 #SPRITE$5D(spikey-01)

N $C36B Frame 2.
@ $C36B label=Sprite_Spikey_2
  $C36B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C36C,$20,$02 #SPRITE$5E(spikey-02)

b $C38C Sprite: Blob
@ $C38C label=Sprite_Blob_1
D $C38C The Blob sprites. There are two frames in this block, with heights of
. #N$0B and #N$09 pixels. Each frame is its height, followed by two bytes for
. each row, so the sprite is #N$10 pixels wide. The sprite IDs are #N$60 and
. #N$61 (see #R$A4BE).
N $C38C Frame 1.
  $C38C,$01 Height = #N(#PEEK(#PC)) pixels.
  $C38D,$16,$02 #SPRITE$5F(blob-01)

N $C3A3 Frame 2.
@ $C3A3 label=Sprite_Blob_2
  $C3A3,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3A4,$12,$02 #SPRITE$60(blob-02)

b $C3B6 Sprite: Ghoul
@ $C3B6 label=Sprite_Ghoul_1
D $C3B6 The Ghoul sprites. There are two frames in this block, each #N$14 pixels
. high. Each frame is its height, followed by two bytes for each row, so the
. sprite is #N$10 pixels wide. The sprite IDs are #N$62 and #N$63 (see #R$A4BE).
N $C3B6 Frame 1.
  $C3B6,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3B7,$28,$02 #SPRITE$61(ghoul-01)

N $C3DF Frame 2.
@ $C3DF label=Sprite_Ghoul_2
  $C3DF,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3E0,$28,$02 #SPRITE$62(ghoul-02)

b $C408 Sprite: Ghost
@ $C408 label=Sprite_Ghost_1
D $C408 The Ghost sprites. There are two frames in this block, each #N$10 pixels
. high. Each frame is its height, followed by two bytes for each row, so the
. sprite is #N$10 pixels wide. The sprite IDs are #N$68 and #N$69 (see #R$A4BE).
N $C408 Frame 1.
  $C408,$01 Height = #N(#PEEK(#PC)) pixels.
  $C409,$20,$02 #SPRITE$67(ghost-01)

N $C429 Frame 2.
@ $C429 label=Sprite_Ghost_2
  $C429,$01 Height = #N(#PEEK(#PC)) pixels.
  $C42A,$20,$02 #SPRITE$68(ghost-02)

b $C44A Sprite: Bat
@ $C44A label=Sprite_Bat_1
D $C44A The Bat sprites. There are two frames in this block, with heights of
. #N$12 and #N$0E pixels. Each frame is its height, followed by two bytes for
. each row, so the sprite is #N$10 pixels wide. The sprite IDs are #N$6A and
. #N$6B (see #R$A4BE).
N $C44A Frame 1.
  $C44A,$01 Height = #N(#PEEK(#PC)) pixels.
  $C44B,$24,$02 #SPRITE$69(bat-01)

N $C46F Frame 2.
@ $C46F label=Sprite_Bat_2
  $C46F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C470,$1C,$02 #SPRITE$6A(bat-02)

b $C48C Graphic: Chicken
@ $C48C label=Graphic_Chicken_2
D $C48C This block holds two graphics: the one at #R$C48C (graphic ID #N$14) and
. the one at #R$C542 (graphic ID #N$13). Each is #N$06 bytes wide and #N$1E
. pixels high, and starts with its width and height, which are followed by the
. pixels. Neither has any attributes of its own, as the entries for them in
. #R$A64E are the empty set at #R$AEEA.
N $C48C Empty.
  $C48C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C48D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C48E,$B4,$06 #GRAPHIC$13(chicken-empty)

N $C542 Full.
@ $C542 label=Graphic_Chicken_1
  $C542,$01 Width = #N(#PEEK(#PC)) bytes.
  $C543,$01 Height = #N(#PEEK(#PC)) pixels.
  $C544,$B4,$06 #GRAPHIC$12(chicken-full)

b $C5F8 Sprite: Pop
@ $C5F8 label=Sprite_Pop_1
D $C5F8 The Pop sprites. There are four frames in this block, with heights of
. #N$0B, #N$0D, #N$0F and #N$10 pixels. Each frame is its height, followed by
. two bytes for each row, so the sprite is #N$10 pixels wide. The sprite IDs are
. #N$6C to #N$6F (see #R$A4BE).
N $C5F8 Frame 1.
  $C5F8,$01 Height = #N(#PEEK(#PC)) pixels.
  $C5F9,$16,$02 #SPRITE$6B(pop-01)

N $C60F Frame 2.
@ $C60F label=Sprite_Pop_2
  $C60F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C610,$1A,$02 #SPRITE$6C(pop-02)

N $C62A Frame 3.
@ $C62A label=Sprite_Pop_3
  $C62A,$01 Height = #N(#PEEK(#PC)) pixels.
  $C62B,$1E,$02 #SPRITE$6D(pop-03)

N $C649 Frame 4.
@ $C649 label=Sprite_Pop_4
  $C649,$01 Height = #N(#PEEK(#PC)) pixels.
  $C64A,$20,$02 #SPRITE$6E(pop-04)

b $C66A Graphic: Wall Antlers
@ $C66A label=Graphic_Wall_Antlers
D $C66A The pixels of the Wall Antlers graphic, which is graphic ID #N$15. It is
. #N$04 bytes wide and #N$10 pixels high. The width and height are the first two
. bytes of the data, and they are followed by the pixels. The colours are set by
. the attributes at #R$C960.
  $C66A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C66B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C66C,$40,$04 #GRAPHIC$14(wall-antlers)

b $C6AC Graphic: Wall Trophy
@ $C6AC label=Graphic_Wall_Trophy
D $C6AC The pixels of the Wall Trophy graphic, which is graphic ID #N$16. It is
. #N$02 bytes wide and #N$10 pixels high. The width and height are the first two
. bytes of the data, and they are followed by the pixels. The colours are set by
. the attributes at #R$C96A.
  $C6AC,$01 Width = #N(#PEEK(#PC)) bytes.
  $C6AD,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6AE,$20,$02 #GRAPHIC$15(wall-trophy)

b $C6CE Graphic: Bookcase
@ $C6CE label=Graphic_Bookcase
D $C6CE The pixels of the Bookcase graphic, which is graphic ID #N$17. It is
. #N$05 bytes wide and #N$20 pixels high. The width and height are the first two
. bytes of the data, and they are followed by the pixels. The colours are set by
. the attributes at #R$C970.
  $C6CE,$01 Width = #N(#PEEK(#PC)) bytes.
  $C6CF,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6D0,$A0,$05 #GRAPHIC$16(bookcase)

b $C770 Graphic: Trap
@ $C770 label=Graphic_Trap_2
D $C770 This block holds two graphics: the one at #R$C770 (graphic ID #N$19) and
. the one at #R$C7F2 (graphic ID #N$18). Each is #N$04 bytes wide and #N$20
. pixels high, and starts with its width and height, which are followed by the
. pixels. The colours are set by the attributes at #R$C986 and #R$C998
. respectively.
N $C770 Open.
  $C770,$01 Width = #N(#PEEK(#PC)) bytes.
  $C771,$01 Height = #N(#PEEK(#PC)) pixels.
  $C772,$80,$04 #GRAPHIC$18(trap-open)

N $C7F2 Closed.
@ $C7F2 label=Graphic_Trap_1
  $C7F2,$01 Width = #N(#PEEK(#PC)) bytes.
  $C7F3,$01 Height = #N(#PEEK(#PC)) pixels.
  $C7F4,$80,$04 #GRAPHIC$17(trap-closed)

b $C874 Graphic: Rug
@ $C874 label=Graphic_Rug
D $C874 The pixels of the Rug graphic, which is graphic ID #N$1B. It is #N$06
. bytes wide and #N$27 pixels high. The width and height are the first two bytes
. of the data, and they are followed by the pixels. The colours are set by the
. attributes at #R$C9AA.
  $C874,$01 Width = #N(#PEEK(#PC)) bytes.
  $C875,$01 Height = #N(#PEEK(#PC)) pixels.
  $C876,$EA,$06 #GRAPHIC$1A(rug)

b $C960 Graphic Attributes: Wall Antlers
@ $C960 label=Graphic_Wall_Antlers_Attributes
D $C960 The attributes of the Wall Antlers graphic (graphic ID #N$15). It is
. #N$04 cells wide and #N$02 cells high, and these are the first two bytes of
. the data. They are followed by one attribute for each cell. The pixels are at
. #R$C66A.
  $C960,$01 Width = #N(#PEEK(#PC)) bytes.
  $C961,$01 Height = #N(#PEEK(#PC)) bytes.
  $C962,$08,$04 #GRAPHIC$14,1(wall-antlers-colour)

b $C96A Graphic Attributes: Wall Trophy
@ $C96A label=Graphic_Wall_Trophy_Attributes
D $C96A The attributes of the Wall Trophy graphic (graphic ID #N$16). It is
. #N$02 cells wide and #N$02 cells high, and these are the first two bytes of
. the data. They are followed by one attribute for each cell. The pixels are at
. #R$C6AC.
  $C96A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C96B,$01 Height = #N(#PEEK(#PC)) bytes.
  $C96C,$04,$02 #GRAPHIC$15,1(wall-trophy-colour)

b $C970 Graphic Attributes: Bookcase
@ $C970 label=Graphic_Bookcase_Attributes
D $C970 The attributes of the Bookcase graphic (graphic ID #N$17). It is #N$05
. cells wide and #N$04 cells high, and these are the first two bytes of the
. data. They are followed by one attribute for each cell. The pixels are at
. #R$C6CE.
  $C970,$01 Width = #N(#PEEK(#PC)) bytes.
  $C971,$01 Height = #N(#PEEK(#PC)) bytes.
  $C972,$14,$05 #GRAPHIC$16,1(bookcase-colour)

b $C986 Graphic Attributes: Trap
@ $C986 label=Graphic_Trap_Attributes_2
D $C986 This block holds 2 sets of attributes, one for each of the graphic IDs
. #N$18 and #N$19. Each set is #N$04 cells wide and #N$04 cells high, and starts
. with its width and height. They are followed by one attribute for each cell.
. The pixels are at #R$C770 and #R$C7F2 respectively.
N $C986 Open.
  $C986,$01 Width = #N(#PEEK(#PC)) bytes.
  $C987,$01 Height = #N(#PEEK(#PC)) bytes.
  $C988,$10,$04 #GRAPHIC$18,1(trap-open-colour)

N $C998 Closed.
@ $C998 label=Graphic_Trap_Attributes_1
  $C998,$01 Width = #N(#PEEK(#PC)) bytes.
  $C999,$01 Height = #N(#PEEK(#PC)) pixels.
  $C99A,$10,$04 #GRAPHIC$17,1(trap-closed-colour)

b $C9AA Graphic Attributes: Rug
@ $C9AA label=Graphic_Rug_Attributes
D $C9AA The attributes of the Rug graphic (graphic ID #N$1B). It is #N$06 cells
. wide and #N$05 cells high, and these are the first two bytes of the data. They
. are followed by one attribute for each cell. The pixels are at #R$C874.
  $C9AA,$01 Width = #N(#PEEK(#PC)) bytes.
  $C9AB,$01 Height = #N(#PEEK(#PC)) bytes.
  $C9AC,$1E,$06 #GRAPHIC$1A,1(rug-colour)

b $C9CA Graphic: A.C.G. Shield
@ $C9CA label=Graphic_ACG_Shield
D $C9CA The pixels of the A.C.G. Shield graphic, which is graphic ID #N$1C. It
. is #N$02 bytes wide and #N$10 pixels high. The width and height are the first
. two bytes of the data, and they are followed by the pixels. The colours are
. set by the attributes at #R$CA50.
  $C9CA,$01 Width = #N(#PEEK(#PC)) bytes.
  $C9CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $C9CC,$20,$02 #GRAPHIC$1B(acg-shield)

b $C9EC Graphic: Wall Shield
@ $C9EC label=Graphic_Wall_Shield
D $C9EC The pixels of the Wall Shield graphic, which is graphic ID #N$1D. It is
. #N$02 bytes wide and #N$10 pixels high. The width and height are the first two
. bytes of the data, and they are followed by the pixels. The colours are set by
. the attributes at #R$CA56.
  $C9EC,$01 Width = #N(#PEEK(#PC)) bytes.
  $C9ED,$01 Height = #N(#PEEK(#PC)) pixels.
  $C9EE,$20,$02 #GRAPHIC$1C(wall-shield)

b $CA0E Graphic: Suit Of Armour
@ $CA0E label=Graphic_Suit_Of_Armour
D $CA0E The pixels of the Suit Of Armour graphic, which is graphic ID #N$1E. It
. is #N$02 bytes wide and #N$20 pixels high. The width and height are the first
. two bytes of the data, and they are followed by the pixels. The colours are
. set by the attributes at #R$CA5C.
  $CA0E,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA0F,$01 Height = #N(#PEEK(#PC)) pixels.
  $CA10,$40,$02 #GRAPHIC$1D(suit-armour)

b $CA50 Graphic Attributes: A.C.G. Shield
@ $CA50 label=Graphic_ACG_Shield_Attributes
D $CA50 The attributes of the A.C.G. Shield graphic (graphic ID #N$1C). It is
. #N$02 cells wide and #N$02 cells high, and these are the first two bytes of
. the data. They are followed by one attribute for each cell. The pixels are at
. #R$C9CA.
  $CA50,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA51,$01 Height = #N(#PEEK(#PC)) bytes.
  $CA52,$04,$02 #GRAPHIC$1B,1(acg-shield-colour)

b $CA56 Graphic Attributes: Wall Shield
@ $CA56 label=Graphic_Wall_Shield_Attributes
D $CA56 The attributes of the Wall Shield graphic (graphic ID #N$1D). It is
. #N$02 cells wide and #N$02 cells high, and these are the first two bytes of
. the data. They are followed by one attribute for each cell. The pixels are at
. #R$C9EC.
  $CA56,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA57,$01 Height = #N(#PEEK(#PC)) bytes.
  $CA58,$04,$02 #GRAPHIC$1C,1(wall-shield-colour)

b $CA5C Graphic Attributes: Suit Of Armour
@ $CA5C label=Graphic_Suit_Of_Armour_Attributes
D $CA5C The attributes of the Suit Of Armour graphic (graphic ID #N$1E). It is
. #N$02 cells wide and #N$04 cells high, and these are the first two bytes of
. the data. They are followed by one attribute for each cell. The pixels are at
. #R$CA0E.
  $CA5C,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA5D,$01 Height = #N(#PEEK(#PC)) bytes.
  $CA5E,$08,$02 #GRAPHIC$1D,1(suit-armour-colour)

b $CA66 Graphic Attributes: Cave Door Shut
@ $CA66 label=Graphic_Cave_Door_Shut_Attributes
D $CA66 The attributes of the Cave Door Shut graphic (graphic ID #N$22). It is
. #N$04 cells wide and #N$03 cells high, and these are the first two bytes of
. the data. They are followed by one attribute for each cell. The pixels are at
. #R$CAE4.
  $CA66,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA67,$01 Height = #N(#PEEK(#PC)) bytes.
  $CA68,$0C,$04 #GRAPHIC$21,1(cave-door-shut-colour)

b $CA74 Graphic Attributes: Door Shut
@ $CA74 label=Graphic_Door_Shut_Attributes
D $CA74 The attributes of the Door Shut graphic (graphic ID #N$20). It is #N$04
. cells wide and #N$03 cells high, and these are the first two bytes of the
. data. They are followed by one attribute for each cell. The pixels are at
. #R$CA82.
  $CA74,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA75,$01 Height = #N(#PEEK(#PC)) bytes.
  $CA76,$0C,$04 #GRAPHIC$1F,1(door-shut-colour)

b $CA82 Graphic: Door Shut
@ $CA82 label=Graphic_Door_Shut
D $CA82 The pixels of the Door Shut graphic, which is graphic ID #N$20. It is
. #N$04 bytes wide and #N$18 pixels high. The width and height are the first two
. bytes of the data, and they are followed by the pixels. The colours are set by
. the attributes at #R$CA74.
  $CA82,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA83,$01 Height = #N(#PEEK(#PC)) pixels.
  $CA84,$60,$04 #GRAPHIC$1F(door-shut)

b $CAE4 Graphic: Cave Door Shut
@ $CAE4 label=Graphic_Cave_Door_Shut
D $CAE4 The pixels of the Cave Door Shut graphic, which is graphic ID #N$22. It
. is #N$04 bytes wide and #N$18 pixels high. The width and height are the first
. two bytes of the data, and they are followed by the pixels. The colours are
. set by the attributes at #R$CA66.
  $CAE4,$01 Width = #N(#PEEK(#PC)) bytes.
  $CAE5,$01 Height = #N(#PEEK(#PC)) pixels.
  $CAE6,$60,$04 #GRAPHIC$21(cave-door-shut)

b $CB46 Sprite: Mummy
@ $CB46 label=Sprite_Mummy_1
D $CB46 The Mummy sprites. There are three frames in this block, each #N$18
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$70 to #N$73 (see
. #R$A4BE). There are more IDs than frames, as some of the frames are used by
. more than one ID.
N $CB46 Frame 1.
  $CB46,$01 Height = #N(#PEEK(#PC)) pixels.
  $CB47,$30,$02 #SPRITE$6F(mummy-01)

N $CB77 Frame 2.
@ $CB77 label=Sprite_Mummy_2
  $CB77,$01 Height = #N(#PEEK(#PC)) pixels.
  $CB78,$30,$02 #SPRITE$70(mummy-02)

N $CBA8 Frame 3.
@ $CBA8 label=Sprite_Mummy_3
  $CBA8,$01 Height = #N(#PEEK(#PC)) pixels.
  $CBA9,$30,$02 #SPRITE$71(mummy-03)

b $CBD9 Sprite: Frankenstein
@ $CBD9 label=Sprite_Frankenstein_1
D $CBD9 The Frankenstein sprites. There are three frames in this block, each
. #N$18 pixels high. Each frame is its height, followed by two bytes for each
. row, so the sprite is #N$10 pixels wide. The sprite IDs are #N$74 to #N$77
. (see #R$A4BE). There are more IDs than frames, as some of the frames are used
. by more than one ID.
N $CBD9 Frame 1.
  $CBD9,$01 Height = #N(#PEEK(#PC)) pixels.
  $CBDA,$30,$02 #SPRITE$73(franken-01)

N $CC0A Frame 2.
@ $CC0A label=Sprite_Frankenstein_2
  $CC0A,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC0B,$30,$02 #SPRITE$74(franken-02)

N $CC3B Frame 3.
@ $CC3B label=Sprite_Frankenstein_3
  $CC3B,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC3C,$30,$02 #SPRITE$75(franken-03)

b $CC6C Sprite: Devil
@ $CC6C label=Sprite_Devil_1
D $CC6C The Devil sprites. There are three frames in this block, each #N$18
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$78 to #N$7B (see
. #R$A4BE). There are more IDs than frames, as some of the frames are used by
. more than one ID.
N $CC6C Frame 1.
  $CC6C,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC6D,$30,$02 #SPRITE$77(devil-01)

N $CC9D Frame 2.
@ $CC9D label=Sprite_Devil_2
  $CC9D,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC9E,$30,$02 #SPRITE$78(devil-02)

N $CCCE Frame 3.
@ $CCCE label=Sprite_Devil_3
  $CCCE,$01 Height = #N(#PEEK(#PC)) pixels.
  $CCCF,$30,$02 #SPRITE$79(devil-03)

b $CCFF Sprite: Dracula
@ $CCFF label=Sprite_Dracula_1
D $CCFF The Dracula sprites. There are three frames in this block, each #N$18
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$7C to #N$7F (see
. #R$A4BE). There are more IDs than frames, as some of the frames are used by
. more than one ID.
N $CCFF Frame 1.
  $CCFF,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD00,$30,$02 #SPRITE$7B(dracula-01)

N $CD30 Frame 2.
@ $CD30 label=Sprite_Dracula_2
  $CD30,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD31,$30,$02 #SPRITE$7C(dracula-02)

N $CD61 Frame 3.
@ $CD61 label=Sprite_Dracula_3
  $CD61,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD62,$30,$02 #SPRITE$7D(dracula-03)

b $CD92 Sprite: Tombstone
@ $CD92 label=Sprite_Tombstone
D $CD92 The Tombstone sprite, which is a single frame that is #N$15 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$8F (see #R$A4BE).
  $CD92,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD93,$2A,$02 #SPRITE$8E(tombstone)

b $CDBD Sprite: Crucifix
@ $CDBD label=Sprite_Crucifix
D $CDBD The Crucifix sprite, which is a single frame that is #N$12 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$8A (see #R$A4BE).
  $CDBD,$01 Height = #N(#PEEK(#PC)) pixels.
  $CDBE,$24,$02 #SPRITE$89(crucifix)

b $CDE2 Sprite: Skull
@ $CDE2 label=Sprite_Skull
D $CDE2 The Skull sprite, which is a single frame that is #N$0F pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$89 (see #R$A4BE).
  $CDE2,$01 Height = #N(#PEEK(#PC)) pixels.
  $CDE3,$1E,$02 #SPRITE$88(skull)

b $CE01 Sprite: Witch
@ $CE01 label=Sprite_Witch_Left_1
D $CE01 The Witch sprites. There are four frames in this block, each #N$16
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$90 to #N$93 (see
. #R$A4BE).
E $CE01 #UDGTABLE(default,centre)
. { =h Left | =h Right }{
. #FRAMES(witch-left-01,25;witch-left-02)(witch-left) |
. #FRAMES(witch-right-01,25;witch-right-02)(witch-right)
. }
. UDGTABLE#
N $CE01 Left Frame 1.
  $CE01,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE02,$2C,$02 #SPRITE$8F(witch-left-01*)

N $CE2E Left Frame 2.
@ $CE2E label=Sprite_Witch_Left_2
  $CE2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE2F,$2C,$02 #SPRITE$90(witch-left-02*)

N $CE5B Right Frame 1.
@ $CE5B label=Sprite_Witch_Right_1
  $CE5B,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE5C,$2C,$02 #SPRITE$91(witch-right-01*)

N $CE88 Right Frame 2.
@ $CE88 label=Sprite_Witch_Right_2
  $CE88,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE89,$2C,$02 #SPRITE$92(witch-right-02*)

b $CEB5 Sprite: Monk
@ $CEB5 label=Sprite_Monk_Left_1
D $CEB5 The Monk sprites. There are four frames in this block, each #N$13 pixels
. high. Each frame is its height, followed by two bytes for each row, so the
. sprite is #N$10 pixels wide. The sprite IDs are #N$94 to #N$97 (see #R$A4BE).
E $CEB5 #UDGTABLE(default,centre)
. { =h Left | =h Right }{
. #FRAMES(monk-left-01,25;monk-left-02)(monk-left) |
. #FRAMES(monk-right-01,25;monk-right-02)(monk-right)
. }
. UDGTABLE#
N $CEB5 Left Frame 1.
  $CEB5,$01 Height = #N(#PEEK(#PC)) pixels.
  $CEB6,$26,$02 #SPRITE$93(monk-left-01*)

N $CEDC Left Frame 2.
@ $CEDC label=Sprite_Monk_Left_2
  $CEDC,$01 Height = #N(#PEEK(#PC)) pixels.
  $CEDD,$26,$02 #SPRITE$94(monk-left-02*)

N $CF03 Right Frame 1.
@ $CF03 label=Sprite_Monk_Right_1
  $CF03,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF04,$26,$02 #SPRITE$95(monk-right-01*)

N $CF2A Right Frame 2.
@ $CF2A label=Sprite_Monk_Right_2
  $CF2A,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF2B,$26,$02 #SPRITE$96(monk-right-02*)

b $CF51 Sprite: Flying Bat
@ $CF51 label=Sprite_Flying_Bat_Left_1
D $CF51 The Flying Bat sprites. There are four frames in this block, with
. heights of #N$13, #N$0D, #N$0D and #N$13 pixels. Each frame is its height,
. followed by two bytes for each row, so the sprite is #N$10 pixels wide. The
. sprite IDs are #N$98 to #N$9B (see #R$A4BE).
N $CF51 Left Frame 1.
  $CF51,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF52,$26,$02 #SPRITE$97(bat-left-01)

N $CF78 Left Frame 2.
@ $CF78 label=Sprite_Flying_Bat_Left_2
  $CF78,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF79,$1A,$02 #SPRITE$98(bat-left-02)

N $CF93 Right Frame 1.
@ $CF93 label=Sprite_Flying_Bat_Right_1
  $CF93,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF94,$1A,$02 #SPRITE$99(bat-right-01)

N $CFAE Right Frame 2.
@ $CFAE label=Sprite_Flying_Bat_Right_2
  $CFAE,$01 Height = #N(#PEEK(#PC)) pixels.
  $CFAF,$26,$02 #SPRITE$9A(bat-right-02)

b $CFD5 Graphic: Barrel
@ $CFD5 label=Graphic_Barrel
D $CFD5 The pixels of the Barrel graphic, which is graphic ID #N$1A. It is #N$04
. bytes wide and #N$20 pixels high. The width and height are the first two bytes
. of the data, and they are followed by the pixels. The colours are set by the
. attributes at #R$D057.
  $CFD5,$01 Width = #N(#PEEK(#PC)) bytes.
  $CFD6,$01 Height = #N(#PEEK(#PC)) pixels.
  $CFD7,$80,$04 #GRAPHIC$19(barrel)

b $D057 Graphic Attributes: Barrel
@ $D057 label=Graphic_Barrel_Attributes
D $D057 The attributes of the Barrel graphic (graphic ID #N$1A). It is #N$04
. cells wide and #N$04 cells high, and these are the first two bytes of the
. data. They are followed by one attribute for each cell. The pixels are at
. #R$CFD5.
  $D057,$01 Width = #N(#PEEK(#PC)) bytes.
  $D058,$01 Height = #N(#PEEK(#PC)) bytes.
  $D059,$10,$04 #GRAPHIC$19,1(barrel-colour)

b $D069 Graphic: A.C.G. Door
@ $D069 label=Graphic_ACG_Door
D $D069 The pixels of the A.C.G. Door graphic, which is graphic ID #N$24. It is
. #N$08 bytes wide and #N$28 pixels high. The width and height are the first two
. bytes of the data, and they are followed by the pixels. The colours are set by
. the attributes at #R$D1AB.
  $D069,$01 Width = #N(#PEEK(#PC)) bytes.
  $D06A,$01 Height = #N(#PEEK(#PC)) pixels.
  $D06B,$140,$08 #GRAPHIC$23(acg-door)

b $D1AB Graphic Attributes: A.C.G. Door
@ $D1AB label=Graphic_ACG_Door_Attributes
D $D1AB The attributes of the A.C.G. Door graphic (graphic ID #N$24). It is
. #N$08 cells wide and #N$05 cells high, and these are the first two bytes of
. the data. They are followed by one attribute for each cell. The pixels are at
. #R$D069.
  $D1AB,$01 Width = #N(#PEEK(#PC)) bytes.
  $D1AC,$01 Height = #N(#PEEK(#PC)) bytes.
  $D1AD,$28,$08 #GRAPHIC$23,1(acg-door-colour)

b $D1D5 Sprite: A.C.G. Key
@ $D1D5 label=Sprite_ACG_Key_Left
D $D1D5 The A.C.G. Key sprites. There are three frames in this block, with
. heights of #N$0B, #N$0F and #N$13 pixels. Each frame is its height, followed
. by two bytes for each row, so the sprite is #N$10 pixels wide. The sprite IDs
. are #N$8C to #N$8E (see #R$A4BE).
E $D1D5 #UDGTABLE(default) { =h Output: } { #SPRITE$8B(acg-01)#SPRITE$8C(acg-02)#SPRITE$8D(acg-03) } UDGTABLE#
N $D1D5 Key left.
  $D1D5,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1D6,$16,$02 #SPRITE$8B(acg-01)

N $D1EC Key middle.
@ $D1EC label=Sprite_ACG_Key_Middle
  $D1EC,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1ED,$1E,$02 #SPRITE$8C(acg-02)

N $D20B Key right.
@ $D20B label=Sprite_ACG_Key_Right
  $D20B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D20C,$26,$02 #SPRITE$8D(acg-03)

b $D232 Sprite: Mushroom
@ $D232 label=Sprite_Mushroom
D $D232 The Mushroom sprite, which is a single frame that is #N$10 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$A1 (see #R$A4BE).
  $D232,$01 Height = #N(#PEEK(#PC)) pixels.
  $D233,$20,$02 #SPRITE$A0(mushroom)

b $D253 Graphic: Pumpkin Picture
@ $D253 label=Graphic_Pumpkin_Picture
D $D253 The pixels of the Pumpkin Picture graphic, which is graphic ID #N$25. It
. is #N$04 bytes wide and #N$10 pixels high. The width and height are the first
. two bytes of the data, and they are followed by the pixels. The colours are
. set by the attributes at #R$D295.
  $D253,$01 Width = #N(#PEEK(#PC)) bytes.
  $D254,$01 Height = #N(#PEEK(#PC)) pixels.
  $D255,$40,$04 #GRAPHIC$24(pumpkin-picture)

b $D295 Graphic Attributes: Pumpkin Picture
@ $D295 label=Graphic_Pumpkin_Picture_Attributes
D $D295 The attributes of the Pumpkin Picture graphic (graphic ID #N$25). It is
. #N$04 cells wide and #N$02 cells high, and these are the first two bytes of
. the data. They are followed by one attribute for each cell. The pixels are at
. #R$D253.
  $D295,$01 Width = #N(#PEEK(#PC)) bytes.
  $D296,$01 Height = #N(#PEEK(#PC)) bytes.
  $D297,$08,$04 #GRAPHIC$24,1(pumpkin-picture-colour)

b $D29F Sprite: Spanner
@ $D29F label=Sprite_Spanner
D $D29F The Spanner sprite, which is a single frame that is #N$10 pixels high.
. Each frame is its height, followed by two bytes for each row, so the sprite is
. #N$10 pixels wide. The sprite ID is #N$8B (see #R$A4BE).
  $D29F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2A0,$20,$02 #SPRITE$8A(spanner)

b $D2C0 Sprite: Ghostlet
@ $D2C0 label=Sprite_Ghostlet_1
D $D2C0 The Ghostlet sprites. There are two frames in this block, each #N$0B
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$4E and #N$4F (see
. #R$A4BE).
N $D2C0 Frame 1.
  $D2C0,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2C1,$16,$02 #SPRITE$4D(ghostlet-01)

N $D2D7 Frame 2.
@ $D2D7 label=Sprite_Ghostlet_2
  $D2D7,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2D8,$16,$02 #SPRITE$4E(ghostlet-02)

b $D2EE Graphic: Skeleton
@ $D2EE label=Graphic_Skeleton
D $D2EE The pixels of the Skeleton graphic, which is graphic ID #N$26. It is
. #N$05 bytes wide and #N$28 pixels high. The width and height are the first two
. bytes of the data, and they are followed by the pixels. The colours are set by
. the attributes at #R$D3B8.
  $D2EE,$01 Width = #N(#PEEK(#PC)) bytes.
  $D2EF,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2F0,$C8,$05 #GRAPHIC$25(skeleton)

b $D3B8 Graphic Attributes: Skeleton
@ $D3B8 label=Graphic_Skeleton_Attributes
D $D3B8 The attributes of the Skeleton graphic (graphic ID #N$26). It is #N$05
. cells wide and #N$05 cells high, and these are the first two bytes of the
. data. They are followed by one attribute for each cell. The pixels are at
. #R$D2EE.
  $D3B8,$01 Width = #N(#PEEK(#PC)) bytes.
  $D3B9,$01 Height = #N(#PEEK(#PC)) bytes.
  $D3BA,$19,$05 #GRAPHIC$25,1(skeleton-colour)

b $D3D3 Sprite: Hunchback
@ $D3D3 label=Sprite_Hunchback_1
D $D3D3 The Hunchback sprites. There are three frames in this block, each #N$18
. pixels high. Each frame is its height, followed by two bytes for each row, so
. the sprite is #N$10 pixels wide. The sprite IDs are #N$9C to #N$9F (see
. #R$A4BE). There are more IDs than frames, as some of the frames are used by
. more than one ID.
E $D3D3 #FRAMES(hunchback-01,25;hunchback-02;hunchback-03;hunchback-02)(hunchback)
N $D3D3 Frame 1.
  $D3D3,$01 Height = #N(#PEEK(#PC)) pixels.
  $D3D4,$30,$02 #SPRITE$9B(hunchback-01*)

N $D404 Frame 2.
@ $D404 label=Sprite_Hunchback_2
  $D404,$01 Height = #N(#PEEK(#PC)) pixels.
  $D405,$30,$02 #SPRITE$9C(hunchback-02*)

N $D435 Frame 3.
@ $D435 label=Sprite_Hunchback_3
  $D435,$01 Height = #N(#PEEK(#PC)) pixels.
  $D436,$30,$02 #SPRITE$9D(hunchback-03*)

b $D466 Graphic: Barrel Stack
@ $D466 label=Graphic_Barrel_Stack
D $D466 The pixels of the Barrel Stack graphic, which is graphic ID #N$27. It is
. #N$05 bytes wide and #N$1B pixels high. The width and height are the first two
. bytes of the data, and they are followed by the pixels. The colours are set by
. the attributes at #R$D4EF.
  $D466,$01 Width = #N(#PEEK(#PC)) bytes.
  $D467,$01 Height = #N(#PEEK(#PC)) pixels.
  $D468,$87,$05 #GRAPHIC$26(barrel-stack)

b $D4EF Graphic Attributes: Barrel Stack
@ $D4EF label=Graphic_Barrel_Stack_Attributes
D $D4EF The attributes of the Barrel Stack graphic (graphic ID #N$27). It is
. #N$05 cells wide and #N$04 cells high, and these are the first two bytes of
. the data. They are followed by one attribute for each cell. The pixels are at
. #R$D466.
  $D4EF,$01 Width = #N(#PEEK(#PC)) bytes.
  $D4F0,$01 Height = #N(#PEEK(#PC)) bytes.
  $D4F1,$14,$05 #GRAPHIC$26,1(barrel-stack-colour)

s $D505 Unused
D $D505 The space between the last of the graphics and the entities. The game
. does not use it, and it is all zero apart from three bytes that no code refers
. to by address.
S $D505,$06
B $D50B,$01
S $D50C,$F2
B $D5FE,$02
S $D600,$1490

b $EA90 Player
@ $EA90 label=Player
D $EA90 Entities are 8-byte records, held in the table that starts here.
. #TABLE(default,centre,left)
. { =h Offset | =h Description }
. { #N$00 | Sprite ID (also the index of the handler in #R$7EE6) }
. { #N$01 | Room ID }
. { #N$02 | Used by the handler of the entity }
. { #N$03 | X position (pixels) }
. { #N$04 | Y position (pixels) }
. { #N$05 | Attribute }
. { #N$06 | Used by the handler of the entity }
. { #N$07 | Used by the handler of the entity }
. TABLE#
.
. The player is the first entity. Every entity from here up to #R$EEE0 is a copy
. of the data from #R$600D onwards, which #R$8D61 copies when a game starts, and
. this one is set up from #R$9481 for each life by #R$9443.
B $EA90,$01 Sprite ID (the frame that the player is drawn with).
@ $EA91 label=PlayerRoom
B $EA91,$01 Room ID (the room that the player is in).
B $EA92,$01 Used by the handler of the entity.
B $EA93,$01 X position.
B $EA94,$01 Y position.
B $EA95,$01 Attribute.
B $EA96,$01 Number of rows drawn so far while the player is appearing (see
. #R$8CB7).
B $EA97,$01 Sprite ID of the character (see #R$9443).

b $EA98 Player Weapon
@ $EA98 label=PlayerWeapon
D $EA98 The 16-byte record for the weapon that the player throws, which is a
. copy of #R$6015. The second half is the entity for the sound effects (see
. #R$601D).
B $EA98,$06 The sprite ID, room, flags, X position, Y position and attribute of
. the weapon.
@ $EA9E label=PlayerWeapon_X_Velocity
B $EA9E,$01 The X velocity of the weapon.
@ $EA9F label=PlayerWeapon_Y_Velocity
B $EA9F,$01 The Y velocity of the weapon.
@ $EAA0 label=PlayerWeapon_Sound
B $EAA0,$08 The second half, which is the sound entity.

b $EAA8 Item Entities
@ $EAA8 label=ItemEntities
D $EAA8 The 8-byte entities for the three pieces of the A.C.G. key, the four
. door keys, the leaf, the four tombstones, the crucifix, the spanner, and the
. wine, coin, wing, whip, frog leg, gem, moneybag and skull. They are copies of
. the data from #R$6025 to #R$60CD.
B $EAA8,$08 Copy of the entity at #R(#PC - $8A83).
L $EAA8,$08,$04
@ $EAC8 label=ItemEntity_Red_Key
B $EAC8,$08 Copy of the entity at #R(#PC - $8A83).
L $EAC8,$08,$03
@ $EAE0 label=ItemEntity_Leaf
B $EAE0,$08 Copy of the entity at #R(#PC - $8A83).
@ $EAE8 label=ItemEntity_Tombstone_1
B $EAE8,$08 Copy of the entity at #R(#PC - $8A83).
L $EAE8,$08,$06
@ $EB18 label=ItemEntity_Wine
B $EB18,$08 Copy of the entity at #R(#PC - $8A83).
L $EB18,$08,$08

b $EB58 Food Items
@ $EB58 label=FoodItems
D $EB58 The 8-byte entities for the food: six of each of the can, candy, chop,
. lollipop, ice cream, dessert, apple and bottle, and then four extra of each.
. They are copies of the data from #R$60D5 to #R$6335.
B $EB58,$08 Copy of the entity at #R(#PC - $8A83).
L $EB58,$08,$50

b $EDD8 Mushrooms
@ $EDD8 label=Mushrooms
D $EDD8 The 8-byte entities for the sixteen mushrooms. They are copies of the
. data at #R$6355.
B $EDD8,$08 Copy of the entity at #R(#PC - $8A83).
L $EDD8,$08,$10

b $EE58 Blank Entity
@ $EE58 label=BlankEntity
D $EE58 The blank entity, which is a copy of #R$63D5 and is handled by #R$93E3.
B $EE58,$08 Copy of the entity at #R$63D5.

b $EE60 Creatures
@ $EE60 label=CreatureRecords
D $EE60 The three 16-byte records for the creatures that #R$83EA makes, which
. are copies of the data at #R$63DD. Each is zero until it is used, and then it
. is a copy of #R$8B6A, which describes the layout of the record.
B $EE60,$10,$08 Copy of the record at #R(#PC - $8A83).
L $EE60,$10,$03

b $EE90 Bosses
@ $EE90 label=BossRecords
D $EE90 The 16-byte records for the five bosses, which are copies of the data
. from #R$640D onwards. They have the same layout as the creatures (see
. #R$8B6A).
B $EE90,$10,$08 The mummy, copied from #R$640D and handled by #R$8862.
B $EEA0,$10,$08 The dracula, copied from #R$641D and handled by #R$8906.
B $EEB0,$10,$08 The devil, copied from #R$642D and handled by #R$89ED.
B $EEC0,$10,$08 The frankenstein, copied from #R$643D and handled by #R$8988.
B $EED0,$10,$08 The hunchback, copied from #R$644D and handled by #R$8AFF.

b $EEE0 Room Items
@ $EEE0 label=RoomItemEntities
D $EEE0 The 8-byte records for the doors, traps, clocks, bookcases, barrels and
. the other room items, which are copies of the data from #R$645D to #R$757C.
. Each entry in the lists of room items (see #R$757D) is the address of a record
. here plus #N$757D, which is the address of the original data (see #R$7E93).
B $EEE0,$08 Copy of the item at #R(#PC - $8A83).
@ $EEE8 label=RoomItemEntities_Door_1_Second_Half
B $EEE8,$08 Copy of the item at #R(#PC - $8A83).
L $EEE8,$08,$223
