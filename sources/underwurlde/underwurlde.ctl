; Copyright Ashby Computers & Graphics Ltd 1984, Rare Ltd, 2026 ArcadeGeek LTD.
> $4000 @org=$4000
> $4000 @rom
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))

b $4000 Loading screen
@ $4000 label=Loading
D $4000 #UDGTABLE { =h Underwurlde Loading Screen }
. { #SCR$02(loading) } UDGTABLE#
N $4000 The frame around the loading screen is used as the border of every
. page of this disassembly.
. #HTML(<div hidden>)
. #SCR$02,$00,$00,$20,$15(screen-frame)
. #HTML(</div>)
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

g $6000 Room Visit Table
@ $6000 label=Room_Visit_Table
D $6000 Two bytes per room, laid out in the same way as the #R$7000 world
. map. The first byte of a room's entry is zero until the room has been
. visited; #R$9FA3 counts the non-zero entries to work out how much of the
. map has been explored. The table is cleared by #R$9C62 when a new game
. starts.
.
. In a cave room that has no floor the two bytes of the entry also describe the
. two stalactites of the room (see #R$E6EE). #R$E6A5 reads an entry.
B $6000,$07F2,$20

c $67F2 Game Entry Point
@ $67F2 label=GameEntry
D $67F2 The stub that the tape loader runs after loading the game. The
. loader leaves the game one byte higher than it is meant to be, so the stub
. moves the whole image (#N$8800 bytes) down by one byte and then jumps to
. #R$7680 to start the game.
.
. The last operand byte of the final JP instruction lies at #R$6800, which
. is the first byte of the moved image. That byte is #N$76 (the sprite id of
. the first decoration in #R$6800), so after the move the JP still lands on
. #R$7680. Only the first two bytes of the JP are kept in this routine so
. that it does not overlap the #R$6800 table. The stub is wiped when
. #R$9C62 clears the #R$6000 table.
E $67F2 View the equivalent code in;
. #LIST
. { #ATICATAC$5B80 }
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #LUNARJETMAN$5B80 }
. { #PSSST$5B80 }
. { #TRANZAM$5B80 }
. LIST#
  $67F2,$01 Disable interrupts.
  $67F3,$03 Set #REGhl to #N$6801 (the source address).
  $67F6,$03 Set #REGde to #N$6800 (the destination address).
  $67F9,$03 Set #REGbc to #N$8800 (the number of bytes to move).
  $67FC,$02 Move the game down by one byte.
B $67FE,$02 The opcode (#N$C3) and the low operand byte (#N$80) of the final
. instruction, JP #N$7680. The high operand byte is at #R$6800.

b $6800 Room Decoration Table
@ $6800 label=Room_Decoration_Table
D $6800 Eight bytes per room: four pairs of bytes, one pair for each
. decoration (furniture, pictures and so on) in the room. The first byte
. of each pair is the sprite id of the decoration and the second packs its
. position. #R$EAA2 reads these pairs when a room is entered. Unused pairs
. are zero.
B $6800,$0800,$08

b $7000 World Map
@ $7000 label=World_Map
D $7000 Two bytes per room, #N$20 bytes per row of rooms. The first byte
. holds the room's edge flags, the second byte is cleared at the start of
. each game by #R$9588. #R$98B2 works out the address of a room's entry.
B $7000,$0680,$10

c $7680 Start Game Selection
@ $7680 label=Start_Game_Selection
D $7680 The entry point of the game. It disables interrupts, puts the stack
. just below the #R$6000 room visit table and starts the game selection
. screen.
E $7680 View the equivalent code in;
. #LIST
. { #SABREWULF$6000 }
. LIST#
  $7680,$01 Disable interrupts.
  $7681,$03 Set the stack pointer to #N$6000.
  $7684,$03 Jump to #R$9052.

b $7687 Special Room Pictures
@ $7687 label=Room_Graphics
D $7687 The pictures that make up the frame of the special rooms (the rooms
. with a room y below #N$10), which are drawn by #R$9DA0. There are no tiles
. here: each part of the frame is a ready-made picture that is copied to the
. screen. \p A corner picture is three bytes wide and #N$20 lines high and
. starts with its twelve attribute bytes (three cells wide by four cells
. high), followed by the pixels, top line first. The ceiling and the floor
. are #N$1A bytes wide and #N$20 lines high and the walls are three bytes
. wide and #N$70 lines high; these have no attribute bytes, because their
. attributes are filled in by the code that draws them.
N $7687 Bottom left corner, used for code #N$03 of the table at
. #R$9DF6.
B $7687,$0C,$03
B $7693,$60,$03
@ $76F3 label=Room_Graphics_Bottom_Right_Corner_6
N $76F3 Bottom right corner, used for code #N$06 of the table at
. #R$9DE6.
B $76F3,$0C,$03
B $76FF,$60,$03
@ $775F label=Room_Graphics_Bottom_Left_Corner_6
N $775F Bottom left corner, used for code #N$06 of the table at
. #R$9DF6.
B $775F,$0C,$03
B $776B,$60,$03
@ $77CB label=Room_Graphics_Bottom_Right_Corner_3
N $77CB Bottom right corner, used for code #N$03 of the table at
. #R$9DE6.
B $77CB,$0C,$03
B $77D7,$60,$03
@ $7837 label=Room_Graphics_Bottom_Left_Corner_7
N $7837 Bottom left corner, used for code #N$07 of the table at
. #R$9DF6.
B $7837,$0C,$03
B $7843,$60,$03
@ $78A3 label=Room_Graphics_Floor
N $78A3 Floor picture, #N$1A bytes wide and #N$20 lines high.
B $78A3,$0340,$1A
@ $7BE3 label=Room_Graphics_Bottom_Right_Corner_7
N $7BE3 Bottom right corner, used for code #N$07 of the table at
. #R$9DE6.
B $7BE3,$0C,$03
B $7BEF,$60,$03
@ $7C4F label=Room_Graphics_Top_Left_Corner_7
N $7C4F Top left corner, used for code #N$07 of the table at #R$9E06.
B $7C4F,$0C,$03
B $7C5B,$60,$03
@ $7CBB label=Room_Graphics_Top_Right_Corner_7
N $7CBB Top right corner, used for code #N$07 of the table at #R$9DD6.
B $7CBB,$0C,$03
B $7CC7,$60,$03
@ $7D27 label=Room_Graphics_Ceiling
N $7D27 Ceiling picture, #N$1A bytes wide and #N$20 lines high.
B $7D27,$0340,$1A
@ $8067 label=Room_Graphics_Top_Left_Corner_3
N $8067 Top left corner, used for code #N$03 of the table at #R$9E06.
B $8067,$0C,$03
B $8073,$60,$03
@ $80D3 label=Room_Graphics_Top_Right_Corner_6
N $80D3 Top right corner, used for code #N$06 of the table at #R$9DD6.
B $80D3,$0C,$03
B $80DF,$60,$03
@ $813F label=Room_Graphics_Top_Left_Corner_6
N $813F Top left corner, used for code #N$06 of the table at #R$9E06.
B $813F,$0C,$03
B $814B,$60,$03
@ $81AB label=Room_Graphics_Top_Right_Corner_3
N $81AB Top right corner, used for code #N$03 of the table at #R$9DD6.
B $81AB,$0C,$03
B $81B7,$60,$03
@ $8217 label=Room_Graphics_Right_Wall
N $8217 Right wall picture, three bytes wide and #N$70 lines high.
B $8217,$0150,$03
@ $8367 label=Room_Graphics_Left_Wall
N $8367 Left wall picture, three bytes wide and #N$70 lines high.
B $8367,$0150,$03
@ $84B7 label=Room_Graphics_Bottom_Right_Corner_0_And_2
N $84B7 Bottom right corner, used for codes #N$00 and #N$02 of the table at
. #R$9DE6.
B $84B7,$0C,$03
B $84C3,$60,$03
@ $8523 label=Room_Graphics_Bottom_Left_Corner_0_And_2
N $8523 Bottom left corner, used for codes #N$00 and #N$02 of the table at
. #R$9DF6.
B $8523,$0C,$03
B $852F,$60,$03
@ $858F label=Room_Graphics_Top_Right_Corner_0_And_2
N $858F Top right corner, used for codes #N$00 and #N$02 of the table at
. #R$9DD6.
B $858F,$0C,$03
B $859B,$60,$03
@ $85FB label=Room_Graphics_Top_Left_Corner_0_And_2
N $85FB Top left corner, used for codes #N$00 and #N$02 of the table at
. #R$9E06.
B $85FB,$0C,$03
B $8607,$60,$03

b $8667 Sprite: Torch
@ $8667 label=Sprite_Torch_1
. The pixel data follows, one row at a time, with the bottom row first. The
. sprites are drawn using XOR, so they have no mask. Sprite ids are looked up
. in #R$9332.
  $8667,$01 Width = #N(#PEEK(#PC)) bytes.
  $8668,$01 Height = #N(#PEEK(#PC)) pixels.
  $8669,$50,$02 #SPRITEDATA(torch-01*)

b $86B9 Sprite: Flower Bowl
@ $86B9 label=Sprite_Flower_Bowl_1
D $86B9 The sprite of the bowl of flowers in a special room, which is the object
. type #N$7D. #R$EB39 draws it.
  $86B9,$01 Width = #N(#PEEK(#PC)) bytes.
  $86BA,$01 Height = #N(#PEEK(#PC)) pixels.
  $86BB,$60,$04 #SPRITEDATA(flower-bowl-01*)

b $871B Sprite: Hanging Bowl
@ $871B label=Sprite_Hanging_Bowl_1
D $871B The sprite of the bowl that hangs from the ceiling of a special room,
. which is the object type #N$7C. #R$EB39 draws it.
  $871B,$01 Width = #N(#PEEK(#PC)) bytes.
  $871C,$01 Height = #N(#PEEK(#PC)) pixels.
  $871D,$48,$03 #SPRITEDATA(hanging-bowl-01*)

b $8765 Sprite: Bookshelf
@ $8765 label=Sprite_Bookshelf_1
D $8765 The sprite of the bookshelf in a special room, which is the object type
. #N$7B. #R$EB39 draws it.
  $8765,$01 Width = #N(#PEEK(#PC)) bytes.
  $8766,$01 Height = #N(#PEEK(#PC)) pixels.
  $8767,$90,$06 #SPRITEDATA(bookshelf-01*)

b $87F7 Sprite: Sparkle
@ $87F7 label=Sprite_Sparkle_1
D $87F7 The two frames of the sparkle, which are the object types #N$72 and
. #N$73 (see #R$E18C).
N $87F7 Frame 1.
  $87F7,$01 Width = #N(#PEEK(#PC)) bytes.
  $87F8,$01 Height = #N(#PEEK(#PC)) pixels.
  $87F9,$20,$02 #SPRITEDATA(sparkle-01*)
N $8819 Frame 2.
@ $8819 label=Sprite_Sparkle_2
  $8819,$01 Width = #N(#PEEK(#PC)) bytes.
  $881A,$01 Height = #N(#PEEK(#PC)) pixels.
  $881B,$20,$02 #SPRITEDATA(sparkle-02*)

b $883B Sprite: Tapestry
@ $883B label=Sprite_Tapestry_1
D $883B The sprite of the tapestry in a special room, which is the object type
. #N$75. #R$EAF9 draws it.
  $883B,$01 Width = #N(#PEEK(#PC)) bytes.
  $883C,$01 Height = #N(#PEEK(#PC)) pixels.
  $883D,$60,$03 #SPRITEDATA(tapestry-01*)

b $889D Sprite: Clock
@ $889D label=Sprite_Clock_1
D $889D The sprite of the clock in a special room, which is the object type
. #N$74. #R$EAF9 draws it.
  $889D,$01 Width = #N(#PEEK(#PC)) bytes.
  $889E,$01 Height = #N(#PEEK(#PC)) pixels.
  $889F,$9C,$03 #SPRITEDATA(clock-01*)

b $893B Sprite: Bird
@ $893B label=Sprite_Bird_1
D $893B The sprite of the bird in a special room, which is the object type
. #N$78. #R$EAF9 draws it.
  $893B,$01 Width = #N(#PEEK(#PC)) bytes.
  $893C,$01 Height = #N(#PEEK(#PC)) pixels.
  $893D,$60,$04 #SPRITEDATA(bird-01*)

b $899D Sprite: Sideboard
@ $899D label=Sprite_Sideboard_1
D $899D The sprite of the sideboard in a special room, which is the object type
. #N$77. #R$EAF9 draws it.
  $899D,$01 Width = #N(#PEEK(#PC)) bytes.
  $899E,$01 Height = #N(#PEEK(#PC)) pixels.
  $899F,$1B0,$09 #SPRITEDATA(sideboard-01*)

b $8B4F Sprite: Table
@ $8B4F label=Sprite_Table_1
D $8B4F The sprite of the table in a special room, which is the object type
. #N$76. #R$EAF9 draws it.
  $8B4F,$01 Width = #N(#PEEK(#PC)) bytes.
  $8B50,$01 Height = #N(#PEEK(#PC)) pixels.
  $8B51,$118,$07 #SPRITEDATA(table-01*)

b $8C69 Sprite: Picture
@ $8C69 label=Sprite_Picture_1
D $8C69 The sprites of the two pictures that hang on the wall of a special room.
. The first is the object type #N$7A and the second is the object type #N$79.
. #R$EB39 draws them.
N $8C69 Frame 1.
  $8C69,$01 Width = #N(#PEEK(#PC)) bytes.
  $8C6A,$01 Height = #N(#PEEK(#PC)) pixels.
  $8C6B,$80,$04 #SPRITEDATA(picture-01*)
N $8CEB Frame 2.
@ $8CEB label=Sprite_Picture_2
  $8CEB,$01 Width = #N(#PEEK(#PC)) bytes.
  $8CEC,$01 Height = #N(#PEEK(#PC)) pixels.
  $8CED,$A0,$04 #SPRITEDATA(picture-02*)

b $8D8D Sprite: Menu Joystick
@ $8D8D label=Sprite_Menu_Joystick_1
D $8D8D The icon of the joystick on the game selection screen, which is the
. sprite id #N$8D (see #R$95A3).
  $8D8D,$01 Width = #N(#PEEK(#PC)) bytes.
  $8D8E,$01 Height = #N(#PEEK(#PC)) pixels.
  $8D8F,$5C,$04 #SPRITEDATA(menu-joystick-01*)

b $8DEB Sprite: Menu Cursor
@ $8DEB label=Sprite_Menu_Cursor_1
D $8DEB The icon of the cursor keys on the game selection screen, which is the
. sprite id #N$8E (see #R$95A3).
  $8DEB,$01 Width = #N(#PEEK(#PC)) bytes.
  $8DEC,$01 Height = #N(#PEEK(#PC)) pixels.
  $8DED,$50,$04 #SPRITEDATA(menu-cursor-01*)

b $8E3D Sprite: Menu Keyboard
@ $8E3D label=Sprite_Menu_Keyboard_1
D $8E3D The icon of the keyboard on the game selection screen, which is the
. sprite id #N$8C (see #R$95A3).
  $8E3D,$01 Width = #N(#PEEK(#PC)) bytes.
  $8E3E,$01 Height = #N(#PEEK(#PC)) pixels.
  $8E3F,$40,$04 #SPRITEDATA(menu-keyboard-01*)

b $8E7F Sprite: Menu Interface
@ $8E7F label=Sprite_Menu_Interface_1
D $8E7F The icon of the Interface II joystick on the game selection screen,
. which is the sprite id #N$8F (see #R$95A3).
  $8E7F,$01 Width = #N(#PEEK(#PC)) bytes.
  $8E80,$01 Height = #N(#PEEK(#PC)) pixels.
  $8E81,$54,$04 #SPRITEDATA(menu-interface-01*)

g $8ED5 Game Options
@ $8ED5 label=GameOptions
D $8ED5 The options that were chosen on the game selection screen (see
. #R$9052). Only the low two bits are used, as there is only one player. They
. are the controls that #R$AE17 reads:
. #TABLE(default,centre,left)
. { =h Bits 0-1 | =h Controls }
. { #N$00 | Keyboard }
. { #N$01 | Kempston Joystick }
. { #N$02 | Cursor Joystick }
. { #N$03 | Interface II Joystick }
. TABLE#
E $8ED5 View the equivalent code in;
. #LIST
. { #ATICATAC$5E00 }
. { #COOKIE$5F0C }
. { #JETPAC$5CF3 }
. { #LUNARJETMAN$5E00 }
. { #PSSST$5E03 }
. { #SABREWULF$9692 }
. { #TRANZAM$5E3E }
. LIST#
B $8ED5,$01

g $8ED6 Game Timer
@ $8ED6 label=GameTimer
D $8ED6 The game timer. It is incremented by #R$9459 each time every object
. record has been handled. The low bits of the counter time many of the game's
. events, for example the gem timer, the animation of the creatures and the
. release of new creatures.
W $8ED6,$02

u $8ED8 Unused
@ $8ED8 label=Unused_After_Tick_Counter
D $8ED8 Cleared when the game starts. The game does not use it.
B $8ED8,$02

g $8EDA Lives
@ $8EDA label=PlayerLives
D $8EDA The number of lives that Sabreman has left, held as a BCD value. It is
. set to #N$06 on the game selection screen, goes up by one when Sabreman
. collects an extra life (type #N$7F) and goes down by one when he dies.
B $8EDA,$01

g $8EDB Saved Position
@ $8EDB label=Saved_Position
D $8EDB Holds Sabreman's x position and room x (the two bytes of #R$8EDB), and
. his y position and room y (the two bytes of #R$8EDD), while #R$E7E3 resets his
. object record after he has lost a life. The values are then put back, so he
. restarts where he died.
W $8EDB,$02
@ $8EDD label=Saved_Position_Y
W $8EDD,$02

g $8EDF Last Frame
@ $8EDF label=LastFrame
D $8EDF The last value of the system variable FRAMES (#N$5C78) that #R$9459 saw.
. When FRAMES has changed, the priority objects are handled.
W $8EDF,$02

g $8EE1 Previous Sprite Id
@ $8EE1 label=Previous_Sprite_Id
D $8EE1 The sprite id of the object that #R$989F last saved. #R$9657 uses it,
. with the saved position, to find the sprite that has to be erased.
B $8EE1,$01

g $8EE2 Old Sprite Row Count
@ $8EE2 label=Old_Sprite_Row_Count
D $8EE2 The number of rows of the old sprite that the sprite routines have still
. to draw (see #R$9728). It is set up by #R$9657.
B $8EE2,$01

g $8EE3 New Sprite Row Count
@ $8EE3 label=New_Sprite_Row_Count
D $8EE3 The number of rows of the new sprite that the sprite routines have still
. to draw (see #R$9728). It is set up by #R$9689.
B $8EE3,$01

g $8EE4 Previous X Position
@ $8EE4 label=Previous_X_Position
D $8EE4 The x position of the object that #R$989F last saved.
B $8EE4,$01

g $8EE5 Previous Y Position
@ $8EE5 label=Previous_Y_Position
D $8EE5 The y position of the object that #R$989F last saved.
B $8EE5,$01

g $8EE6 New Sprite Width
@ $8EE6 label=New_Sprite_Width
D $8EE6 The number of character cells that each row of the new sprite covers. It
. is one more than the width of the sprite in bytes when the sprite is not
. aligned to a character boundary. It is set up by #R$9689 and used by #R$9867.
B $8EE6,$01

g $8EE7 New Sprite Height
@ $8EE7 label=New_Sprite_Height
D $8EE7 The height in pixel lines of the new sprite. It is set up by #R$9689 and
. used by #R$9867.
B $8EE7,$01

g $8EE8 Menu Item Attribute
@ $8EE8 label=Current_MenuAttribute
D $8EE8 The attribute that #R$91B0 gives to the characters that it prints.
B $8EE8,$01

g $8EE9 Action Key Held Flag
@ $8EE9 label=Action_Key_Held_Flag
D $8EE9 Set to #N$FF while one of the action keys (SPACE, SYMBOL SHIFT, M, N and
. B) is held down and set to #N$00 when none is. #R$9459 maintains it.
B $8EE9,$01

g $8EEA New Action Key Press Flag
@ $8EEA label=New_Action_Key_Press_Flag
D $8EEA Set to #N$FF for one pass of the main loop when one of the action keys
. is first pressed, and to #N$00 otherwise. The handlers of the weapons
. (#R$E8D7) use it to pick up a weapon, move it along the weapon slots or drop
. it, and set it to #N$FE once they have used it.
B $8EEA,$01

g $8EEB Weapon Slots
@ $8EEB label=Weapon_Slots
D $8EEB The type of the weapon (#N$68 to #N$6B) that Sabreman carries in each of
. three slots, or #N$00 for an empty slot. #R$9459 empties the slots when an
. action key is first pressed and the handlers of the carried weapons (#R$E8D7)
. fill them in again. #R$B4D1 throws the first weapon that it finds.
B $8EEB,$01 The first slot.
@ $8EEC label=Weapon_Slots_Second
B $8EEC,$01 The second slot.
B $8EED,$01 The third slot.

g $8EEE Gem Timer
@ $8EEE label=Gem_Timer
D $8EEE A BCD value that is printed next to the word GEMS. It is set to #N$50
. when Sabreman collects a gem (see #R$E751), which also turns him cyan, and
. #R$9459 reduces it by one every fourth tick. While it is not zero Sabreman
. survives landing after a long fall (see #R$A8A0) and a falling
. stalactite does not hurt him (see #R$E825(#N$E83B)). When it reaches zero he
. turns white again.
B $8EEE,$01

g $8EEF Depth
@ $8EEF label=Depth
D $8EEF The depth of the room that Sabreman is in, held as a BCD value and
. printed by #R$9E58.
B $8EEF,$01

g $8EF0 Room Redrawn Flag
@ $8EF0 label=Room_Redrawn_Flag
D $8EF0 Set to a non-zero value by #R$9906 when a room has been drawn and
. cleared at the end of the next pass of the main loop (see #R$9459).
B $8EF0,$01

g $8EF1 Type 5C Active Flag
@ $8EF1 label=Type_5C_Active_Flag
D $8EF1 Set to #N$01 by the handler for the object types #N$5C to #N$5F
. (#R$E2CB) each time it runs. #R$9459 copies it to #R$8EF2 and clears it at the
. end of every pass.
B $8EF1,$01

g $8EF2 Previous Type 5C Active Flag
@ $8EF2 label=Previous_Type_5C_Active_Flag
D $8EF2 Holds the value of #R$8EF1 from the last complete pass of the main loop.
. It is also set by #R$B079 when an object changes into type #N$5C. #R$E570
. reads it.
B $8EF2,$01

g $8EF3 Score
@ $8EF3 label=Score
D $8EF3 The score, held as six BCD digits in three bytes. #R$A045 adds to it and
. prints it.
B $8EF3,$01 The high byte (the two highest digits).
B $8EF4,$01 The middle byte.
@ $8EF5 label=Score_Low_Byte
B $8EF5,$01 The low byte (the two lowest digits).

g $8EF6 Sound Counter
@ $8EF6 label=Sound_Counter
D $8EF6 Incremented by #R$A087 each time it is called, to alternate the pitch of
. the tones that it plays.
B $8EF6,$01

g $8EF7 Menu Icons Drawn
@ $8EF7 label=Menu_Icons_Drawn
D $8EF7 Set to #N$01 once #R$95A3 has drawn the icons on the game selection
. screen.
B $8EF7,$01

g $8EF8 Completion Percentage
@ $8EF8 label=Completion_Percentage
D $8EF8 The percentage of the Underwurlde that has been explored, held as a BCD
. value. #R$9FA3 works it out and prints it.
B $8EF8,$01

g $8EF9 Creature Spawn Flag
@ $8EF9 label=Creature_Spawn_Flag
D $8EF9 Set to #N$01 by #R$ECCA(#N$ED10). #R$AFDA tests it when it decides how a
. new flying creature enters the room.
B $8EF9,$01

g $8EFA Object Records
@ $8EFA label=Object_Records
D $8EFA Nineteen records of #N$10 bytes each. #R$91C0 works through them one by
. one, using byte #N$00 of each record (the type of the object, which is also
. its sprite id) as an index into the handler table at #R$921A. A type of #N$00
. marks a record that is not in use.
.
. The first two records are the weapons that Sabreman throws. They are handled
. only as priority records (see #R$9459). The third record is Sabreman. #R$A3DD
. fills it in using the template at #R$AA3C.
.
. Some of the other records have fixed uses: the fourth is the rope (type #N$17,
. which #R$AE81 sets up when the room has a rope) and the fifth is a falling
. stalactite (see #R$DF58).
.
. #TABLE(default,centre,centre)
. { =h Byte | =h Contents }
. { #N$00 | Type of the object (the sprite id) }
. { #N$01 | X position }
. { #N$02 | Room x }
. { #N$03 | Y position }
. { #N$04 | Room y }
. { #N$05 | Attribute }
. { #N$06-#N$0F | Used differently by each type of handler }
. TABLE#
. Most handlers use bit 0 of byte #N$0F (or of byte #N$07) as a flag to say
. that the sprite has no old image to erase (see #R$96CB). Byte #N$09 is
. often a vertical speed and bytes #N$0A and #N$0D are often the fractions of
. the x and y positions.
B $8EFA,$0F,$0F Record 0: the first thrown weapon.
@ $8F09 label=First_Weapon_Redraw_Flags
B $8F09,$01 Record 0: the redraw flags.
@ $8F0A label=Second_Weapon_Record
B $8F0A,$10,$10 Record 1: the second thrown weapon.
@ $8F1A label=Sabreman_Record
B $8F1A,$01 Record 2: the sprite id of Sabreman.
@ $8F1B label=Sabreman_X_Position
B $8F1B,$01 The x position of Sabreman.
@ $8F1C label=Sabreman_Room_X
B $8F1C,$01 The room x of Sabreman.
@ $8F1D label=Sabreman_Y_Position
B $8F1D,$01 The y position of Sabreman.
@ $8F1E label=Sabreman_Room_Y
B $8F1E,$01 The room y of Sabreman.
@ $8F1F label=Sabreman_Attribute
B $8F1F,$01 The attribute of Sabreman.
@ $8F20 label=Sabreman_X_Velocity
B $8F20,$01 The x velocity of Sabreman.
B $8F21,$01 Byte #N$07.
@ $8F22 label=Sabreman_Carried_X_Position
B $8F22,$01 Byte #N$08, where an eagle puts the x position of Sabreman.
@ $8F23 label=Sabreman_Carried_Y_Position
B $8F23,$01 Byte #N$09, where an eagle puts the y position of Sabreman.
B $8F24,$01 Byte #N$0A.
@ $8F25 label=Sabreman_Contact_Flags
B $8F25,$01 The contact flags of Sabreman.
B $8F26,$03,$03 Bytes #N$0C to #N$0E.
@ $8F29 label=Sabreman_Redraw_Flags
B $8F29,$01 The redraw flags of Sabreman.
@ $8F2A label=Rope_Record
B $8F2A,$06,$06 Record 3: the rope.
@ $8F30 label=Rope_X_Velocity
B $8F30,$01 The x velocity of the rope.
B $8F31,$08,$08 Bytes #N$07 to #N$0E.
@ $8F39 label=Rope_Redraw_Flags
B $8F39,$01 The redraw flags of the rope.
@ $8F3A label=Falling_Stalactite_Record
B $8F3A,$01 Record 4: the type of the falling stalactite.
@ $8F3B label=Falling_Stalactite_X_Position
B $8F3B,$01 The x position of the stalactite.
@ $8F3C label=Falling_Stalactite_Room_X
B $8F3C,$01 The room x of the stalactite.
@ $8F3D label=Falling_Stalactite_Y_Position
B $8F3D,$01 The y position of the stalactite.
@ $8F3E label=Falling_Stalactite_Room_Y
B $8F3E,$01 The room y of the stalactite.
B $8F3F,$04,$04 Bytes #N$05 to #N$08.
@ $8F43 label=Falling_Stalactite_Y_Velocity
B $8F43,$01 The y velocity of the stalactite.
B $8F44,$05,$05 Bytes #N$0A to #N$0E.
@ $8F49 label=Falling_Stalactite_Redraw_Flags
B $8F49,$01 The redraw flags of the stalactite.
@ $8F4A label=Dust_Record
B $8F4A,$08,$08 Record 5: the puff of dust.
@ $8F52 label=Dust_Counter
B $8F52,$01 The counter of the puff of dust.
B $8F53,$06,$06 Bytes #N$09 to #N$0E.
@ $8F59 label=Dust_Redraw_Flags
B $8F59,$01 The redraw flags of the puff of dust.
@ $8F5A label=First_Bubble_Record
B $8F5A,$03,$03 Records 6 to 9: the four bubbles. This is the first.
@ $8F5D label=First_Bubble_Y_Position
B $8F5D,$01 The y position of the first bubble.
B $8F5E,$01 The room y of the first bubble.
@ $8F5F label=First_Bubble_Attribute
B $8F5F,$01 The attribute of the first bubble.
B $8F60,$09,$09 Bytes #N$06 to #N$0E.
@ $8F69 label=First_Bubble_Redraw_Flags
B $8F69,$01 The redraw flags of the first bubble.
B $8F6A,$10,$10 Record 7: the second bubble.
@ $8F7A label=Object_Record_8
B $8F7A,$01 Record 8: the third bubble, or the first decoration.
@ $8F7B label=Object_Record_8_X_Position
B $8F7B,$01 The x position of record #N$08.
B $8F7C,$01 The room x of record #N$08.
@ $8F7D label=Object_Record_8_Y_Position
B $8F7D,$01 The y position of record #N$08.
B $8F7E,$0B,$0B Bytes #N$04 to #N$0E.
@ $8F89 label=Object_Record_8_Redraw_Flags
B $8F89,$01 The redraw flags of record #N$08.
@ $8F8A label=Object_Record_9
B $8F8A,$10,$10 Record 9: the fourth bubble, or the second decoration.
@ $8F9A label=Object_Record_10
B $8F9A,$01 Record 10: the third decoration.
@ $8F9B label=Object_Record_10_X_Position
B $8F9B,$01 The x position of record #N$0A.
B $8F9C,$0D,$0D Bytes #N$02 to #N$0E.
@ $8FA9 label=Object_Record_10_Redraw_Flags
B $8FA9,$01 The redraw flags of record #N$0A.
@ $8FAA label=Object_Record_11
B $8FAA,$10,$10 Record 11: the fourth decoration.
@ $8FBA label=First_Special_Object_Record
B $8FBA,$01 Record 12: the first special object.
@ $8FBB label=First_Special_Object_X_Position
B $8FBB,$01 The x position of the first special object.
B $8FBC,$04,$04 Bytes #N$02 to #N$05.
@ $8FC0 label=First_Special_Object_Entry_Number
B $8FC0,$01 The number of the table entry of the first special object.
B $8FC1,$09,$09 Bytes #N$07 to #N$0F.
B $8FCA,$10,$10 Record 13: the second special object.
@ $8FDA label=First_Creature_Record
B $8FDA,$40,$10 Records 14 to 17: the four creatures.
B $901A,$10,$10 Record 18.

g $902A Small Object Records
@ $902A label=Small_Object_Records
D $902A Five records of #N$08 bytes each. They are handled in the same way as
. the larger records, after all of those have been handled (see #R$9459).
.
. The first four are the weapons that Sabreman can pick up. #R$E8BE copies their
. starting positions from #R$E9FD at the start of the game.
B $902A,$07,$07 Records 0 to 3: the four weapons. This is the first.
@ $9031 label=Small_Object_Record_0_Redraw_Flags
B $9031,$01 The redraw flags of the first weapon.
B $9032,$18,$08 The other three weapons.
@ $904A label=Small_Object_Record_4
B $904A,$08,$08 Record 4.

c $9052 Select Game Options
@ $9052 label=Select_Game_Options
D $9052 Sets up the game selection screen and waits for the player to choose a
. control method and start the game.
.
. The method is chosen with the keys 1 to 4 (see #R$9119) and is stored in
. #R$8ED5. Pressing 0 starts the game at #R$91C0.
.
. Everything from #R$8ED5 up to #R$9052 is cleared first, so this routine also
. gives every object record and every game variable its starting value of zero.
N $9052 Set the border to black, build the shift tables and clear the game
. variables, the object records and the attributes.
  $9052,$03 Set the border to black by writing #N$00 to port #N$FE.
  $9055,$03 Build the shift tables used to draw the sprites.
  $9058,$03 Point at the start of the game variables (#R$8ED5).
  $905B,$03 Set the number of bytes to #N$017D, which reaches #R$9052.
  $905E,$03 Fill the variables and the object records with zero.
  $9061,$03 Point at the start of the attribute buffer (#N$5800).
  $9064,$03 Set the size of the attribute buffer to #N$0300.
  $9067,$03 Set every attribute to black ink on black paper.
@ $906A label=Select_Game_Options_Restart
  $906A,$03 Clear the screen.
  $906D,$03 Clear the second byte of every room in the world map.
  $9070,$03 Choose where the four weapons are hidden.
  $9073,$05 Set the number of lives to #N$06.
@ $9078 label=Select_Game_Options_Loop
N $9078 Draw the selection menu and the icons, and read the keys 1 to 4.
  $9078,$03 Draw the five lines of the menu, the title and the copyright
. message.
  $907B,$03 Draw the icons next to the menu lines.
  $907E,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $9084,$01 Flip the bits so that a pressed key gives a set bit.
  $9085,$01 Keep the state of the keys for the tests below.
  $9086,$03 Fetch the control method from #R$8ED5.
N $9089 Key 1 selects the keyboard (#N$00).
  $9089,$04 Jump to #R$908F if key 1 is not pressed.
  $908D,$02,b$01 Clear the control method bits (bits 0 and 1).
@ $908F label=Select_Game_Options_Test_Key_2
N $908F Key 2 selects a Kempston joystick (#N$01).
  $908F,$04 Jump to #R$9097 if key 2 is not pressed.
  $9093,$02,b$01 Clear the control method bits (bits 0 and 1).
  $9095,$02,b$01 Set the control method to #N$01.
@ $9097 label=Select_Game_Options_Test_Key_3
N $9097 Key 3 selects a cursor joystick (#N$02).
  $9097,$04 Jump to #R$909F if key 3 is not pressed.
  $909B,$02,b$01 Clear the control method bits (bits 0 and 1).
  $909D,$02,b$01 Set the control method to #N$02.
@ $909F label=Select_Game_Options_Test_Key_4
N $909F Key 4 selects an Interface II joystick (#N$03).
  $909F,$04 Jump to #R$90A7 if key 4 is not pressed.
  $90A3,$02,b$01 Clear the control method bits (bits 0 and 1).
  $90A5,$02,b$01 Set the control method to #N$03.
@ $90A7 label=Select_Game_Options_Store_Method
N $90A7 Store the control method and test key 0 which starts the game.
  $90A7,$01 Keep the control method while the keys are read.
  $90A8,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $90AE,$01 Flip the bits so that a pressed key gives a set bit.
  $90AF,$01 Keep the state of the keys for the test below.
  $90B0,$04 Store the control method in #R$8ED5.
  $90B4,$01 Keep the control method while key 0 is tested.
  $90B5,$05 Jump to #R$91C0 if key 0 is pressed.
N $90BA Highlight the line of the chosen control method and go round again.
  $90BA,$03 Point at the attributes of the menu lines (#R$9119).
  $90BD,$02 Set the number of control methods to #N$04.
  $90BF,$01 Fetch the control method as the number of the chosen line.
  $90C0,$03 Flash the attribute of the chosen line.
  $90C3,$03 Jump back to #R$9078.

c $90C6 Highlight Selected Option
@ $90C6 label=Highlight_Selected_Option
D $90C6 Flashes the menu line of the chosen control method and stops the other
. lines from flashing. It does this by setting or resetting bit 7 (FLASH) of
. each of the line attributes that start at #REGhl.
.
. The two small routines at #R$90D9 and #R$90E0 reset or set the bit for one
. line and move on to the next one. The loop is entered again at
. #R$90C6(#N$90C8) with the zero flag set by the #REGa decrease at
. #R$90CD.
R $90C6 A Control method
R $90C6 B Number of control methods (#N$04)
R $90C6 HL Address of the attribute of the first line
  $90C6,$02,b$01 Keep only the control method bits (bits 0 and 1).
  $90C8,$02 Jump to #R$90D1 if this is the line of the chosen method.
  $90CA,$03 Clear the flash bit of this line and move on to the next line.
@ $90CD label=Highlight_Selected_Option_Loop
  $90CD,$01 Decrease the line count in #REGa (it is zero when the chosen line is
. reached).
  $90CE,$02 Repeat for each of the four lines.
  $90D0,$01 Return.
@ $90D1 label=Highlight_Selected_Option_Flash_Line
  $90D1,$03 Set the flash bit of this line and move on to the next line.
  $90D4,$02 Jump back to #R$90CD.

u $90D6 Unused
D $90D6 Sets bit 7 of the attribute at #REGhl and moves on. Nothing calls it.
C $90D6,$02 Set the flash bit (bit 7) of the line attribute.
C $90D8,$01 Move on to the next attribute.

c $90D9 Clear Flash Attribute
@ $90D9 label=Clear_Flash_Attribute
D $90D9 Resets bit 7 (FLASH) of the attribute at #REGhl and moves on to the next
. attribute.
R $90D9 HL Address of the attribute
R $90D9 O:HL Address of the next attribute
  $90D9,$02 Reset the flash bit (bit 7) of the line attribute.
  $90DB,$01 Move on to the next attribute.
  $90DC,$01 Return.

u $90DD Unused
D $90DD Resets bit 7 of the attribute at #REGhl and moves on. Nothing calls it.
C $90DD,$02 Reset the flash bit (bit 7) of the line attribute.
C $90DF,$01 Move on to the next attribute.

c $90E0 Set Flash Attribute
@ $90E0 label=Set_Flash_Attribute
D $90E0 Sets bit 7 (FLASH) of the attribute at #REGhl and moves on to the next
. attribute.
R $90E0 HL Address of the attribute
R $90E0 O:HL Address of the next attribute
  $90E0,$02 Set the flash bit (bit 7) of the line attribute.
  $90E2,$01 Move on to the next attribute.
  $90E3,$01 Return.

c $90E4 Game Selection Menu
@ $90E4 label=GameMenu
D $90E4 Prints the five lines of the game selection menu, the copyright message
. and the title.
.
. The attributes of the lines are read through #REGde from #R$9119, while the y
. positions and the strings are read through #REGhl' and #REGde'.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Game Selection Menu }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$9078,stop=$907B,sp=$5B40)
. #SCR$02(game-menu) } UDGTABLE# #POPS
E $90E4 View the equivalent code in;
. #LIST
. { #ATICATAC$7CAF }
. { #COOKIE$6332 }
. { #JETPAC$6260 }
. { #LUNARJETMAN$80D1 }
. { #PSSST$6250 }
. { #SABREWULF$B473 }
. { #TRANZAM$5F6C }
. LIST#
N $90E4 Set up the pointers and the counter of the five lines.
  $90E4,$03 Point at the attributes of the lines (#R$9119).
  $90E7,$01 Switch to the shadow registers.
  $90E8,$03 #REGhl'=#R$911F (the y positions of the lines).
  $90EB,$03 #REGde'=#R$9125 (the first string).
  $90EE,$02 #REGb'=#N$05 (the number of lines).
@ $90F0 label=GameMenu_Loop
  $90F0,$01 Switch to the main registers.
N $90F1 Print each of the lines.
  $90F1,$01 Fetch the attribute of the line.
  $90F2,$03 Store it in the print attribute (#R$8EE8).
  $90F5,$01 Move on to the next attribute.
  $90F6,$01 Switch to the shadow registers.
  $90F7,$01 Stash the counter on the stack.
  $90F8,$01 Fetch the y position of the line.
  $90F9,$01 Move on to the next y position.
  $90FA,$01 Stash the pointer to the y positions on the stack.
  $90FB,$01 Use it as the y position of the line.
  $90FC,$02 #REGl'=#N$58 (the x position of the lines).
  $90FE,$03 Print the string.
  $9101,$01 Switch to the shadow registers.
  $9102,$01 Restore the pointer to the y positions.
  $9103,$01 Restore the counter.
  $9104,$01 Move on to the next string.
  $9105,$02 Repeat for each of the lines.
N $9107 Print the copyright message and the title.
  $9107,$03 Set the x position to #N$00 and the y position to #N$B8 (#N$B800).
  $910A,$03 Point at the copyright message (#R$9174).
  $910D,$03 Print the copyright message.
  $9110,$03 Set the x position to #N$10 and the y position to #N$00 (#N$0010).
  $9113,$03 Point at the title (#R$9195).
  $9116,$03 Jump to #R$9C3C.
b $9119 Game Select Attribute Table
@ $9119 label=GameSelection_Attributes
D $9119 The attribute for each of the five menu lines. The sixth entry is not
. used.
E $9119 View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #COOKIE$635E }
. { #JETPAC$628D }
. { #LUNARJETMAN$810E }
. { #PSSST$627C }
. { #SABREWULF$B498 }
. { #TRANZAM$5FA7 }
. LIST#
  $9119,$05,$01 Lines 1 to 5.
  $911E,$01 Not used.

b $911F Game Select Y Position Table
@ $911F label=GameSelection_Position
D $911F The y pixel position for each of the five menu lines. Each line is
. printed starting at an x position of #N$58. The sixth entry is not used.
E $911F View the equivalent code in;
. #LIST
. { #ATICATAC$7CF1 }
. { #COOKIE$6365 }
. { #JETPAC$6293 }
. { #LUNARJETMAN$8115 }
. { #PSSST$6282 }
. { #SABREWULF$B4A0 }
. { #TRANZAM$5FAC }
. LIST#
  $911F,$05,$01 Lines 1 to 5.
  $9124,$01 Not used.

t $9125 Messaging: Game Selection Screen Text
@ $9125 label=GameSelection_Text
D $9125 The text of each of the five menu lines. Each string ends with a
. character that has bit 7 set, which tells #R$9C3C where it finishes.
E $9125 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #COOKIE$636C }
. { #JETPAC$6299 }
. { #PSSST$6288 }
. { #TRANZAM$5FB1 }
. LIST#
  $9125,$0B,$0A:$01 "1  KEYBOARD"
  $9130,$14,$13:$01 "2  KEMPSTON JOYSTICK"
  $9144,$14,$13:$01 "3  CURSOR   JOYSTICK"
  $9158,$0F,$0E:$01 "4  INTERFACE II"
  $9167,$0D,$0C:$01 "0  START GAME"

t $9174 Messaging: Copyright
@ $9174 label=Message_Copyright
D $9174 The first byte is the attribute used for the whole message, followed by
. the text, which ends with a character that has bit 7 set. The character
. #CHR(60) is the copyright symbol and #CHR(58) is a full stop.
E $9174 View the equivalent code in;
. #LIST
. { #ATICATAC$7D51 }
. { #COOKIE$5F85 }
. { #JETPAC$6061 }
. { #PSSST$5EF5 }
. LIST#
B $9174,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $9175,$20,$1F:$01 "<1984 A:C:G: ALL RIGHTS RESERVED"

t $9195 Messaging: Game Selection Title Text
@ $9195 label=GameSelection_Title
D $9195 The first byte is the attribute used for the whole title, followed by
. the text, which ends with a character that has bit 7 set.
E $9195 View the equivalent code in;
. #LIST
. { #ATICATAC$7D72 }
. LIST#
B $9195,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $9196,$1A,$19:$01 "UNDERWURLDE GAME SELECTION"

c $91B0 Write Menu Line
@ $91B0 label=MenuWriteText
D $91B0 Prints a string at a pixel position, giving every character the
. attribute that is held in #R$8EE8. The last character of the string has bit 7
. set.
.
. The work is done by #R$9C48, which prints through #REGhl (the screen
. address) while the attribute buffer address is kept in #REGhl' and the
. attribute in #REGaf'.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$91B0 }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$9078,stop=$90FE,sp=$5B40)
. #SCR$02,$0A,$04,$16,$03(menu-line-before)
. | #SIM(start=$90FE,stop=$9101,sp=$5B40)
. #SCR$02,$0A,$04,$16,$03(menu-line-after) } UDGTABLE# #POPS
E $91B0 View the equivalent code in;
. #LIST
. { #ATICATAC$7D8A }
. { #COOKIE$63E0 }
. { #JETPAC$62FF }
. { #LUNARJETMAN$81AB }
. { #PSSST$62E7 }
. { #SABREWULF$B52D }
. { #TRANZAM$5F97 }
. LIST#
R $91B0 HL Position (#REGl is the x position, #REGh is the y position)
R $91B0 DE Pointer to the string
  $91B0,$01 Stash the position on the stack.
  $91B1,$03 Convert the position into the screen address (in #REGhl).
  $91B4,$03 Fetch the attribute from #R$8EE8.
  $91B7,$01 Keep the attribute for the characters of the string.
  $91B8,$01 Switch to the shadow registers.
  $91B9,$01 Restore the position into #REGhl'.
  $91BA,$03 Convert the position into the address in the attribute buffer.
  $91BD,$03 Jump to #R$9C48 to print the string.

c $91C0 Run Game
@ $91C0 label=Run_Game
D $91C0 Starts a new game and then runs the main loop forever.
.
. The loop at #R$91E5 goes through the object records one at a time. Byte #N$00
. of a record is the type of the object, which is used as an index into the
. #R$921A handler table. The handler is run with #REGix pointing at the record
. and with #R$9459 stacked as its return address, so every handler ends by
. returning to #R$9459 which moves on to the next record.
N $91C0 Start a new game: empty the room table, clear the workspace and the
. objects, and clear the screen.
  $91C0,$03 Empty the room visit table.
  $91C3,$03 Clear the sprite workspace, the score and the other variables.
  $91C6,$03 Clear all of the object records except the first two.
  $91C9,$03 Set every attribute to white ink on black paper.
  $91CC,$03 Clear the screen.
  $91CF,$03 Set up the fifth small object record.
N $91D2 Set up Sabreman and draw the status panel and the room.
  $91D2,$03 Copy the template of Sabreman into his object record.
  $91D5,$04 Point at the object record of Sabreman (#R$8F1A).
  $91D9,$03 Draw the lives icon and the number of lives.
  $91DC,$03 Print the status panel.
  $91DF,$03 Print the word SCORE and the score.
  $91E2,$03 Draw the room. This does not return: it resets the stack and jumps
. to #R$91E5.
@ $91E5 label=Main_Loop
N $91E5 This is the main loop. The normal pass starts with Sabreman's record,
. unless his type is from #N$09 to #N$1B. Those types are handled with the
. priority records (see #R$951D), so then the pass starts with the
. record after his. The first two records are only ever handled as priority
. records.
  $91E5,$01 Enable interrupts.
  $91E6,$04 Point at the object record of Sabreman (#R$8F1A).
  $91EA,$03 Fetch the type of Sabreman.
  $91ED,$04 Jump to #R$91F9 if the type is greater than or equal to
. #N$1C.
  $91F1,$04 Jump to #R$91F9 if the type is less than #N$09.
  $91F5,$04 Point at the record after Sabreman's (#R$8F2A).
@ $91F9 label=Run_Game_Spawn_Creatures
N $91F9 Give the creature spawners a chance to run, then run the handler of the
. object that #REGix points at.
  $91F9,$03 Maybe spawn a stalactite.
  $91FC,$03 Maybe spawn a flying creature.
  $91FF,$03 Fetch the room flags from #R$AAAC.
  $9202,$02,b$01 Keep only bit 4.
  $9204,$03 Maybe spawn a bubble if bit 4 is not set.
@ $9207 label=Run_Object_Handler
N $9207 Run the handler of the object that #REGix points at.
  $9207,$03 Point at the return address of the handler (#R$9459).
@ $920A label=Run_Object_Handler_Stash_Return
  $920A,$01 Stash it on the stack.
  $920B,$03 Point at the handler table (#R$921A).
  $920E,$03 Fetch the type of the object.
@ $9211 label=Run_Object_Handler_Look_Up
  $9211,$02 Clear #REGh so that #REGhl holds the type.
  $9213,$01 Double the type to get the offset of its handler in the table.
  $9214,$01 Add the address of the table.
  $9215,$01 Fetch the low byte of the handler address.
  $9216,$01 Move on to the high byte.
  $9217,$01 Fetch the high byte of the handler address.
  $9218,$01 Copy the low byte of the handler address to #REGl.
  $9219,$01 Jump to the handler.

w $921A Object Handler Table
@ $921A label=Object_Handler_Table
D $921A The address of the handler for every type of object, indexed by the type
. (the first byte of an object record). Several types share a handler. The
. handler for type #N$00 (an empty record) is #R$9454, which only wastes a
. little time.
W $921A,$10,$10 Handlers for the object types #N$00 to #N$07.
W $922A,$10,$10 Handlers for the object types #N$08 to #N$0F.
W $923A,$10,$10 Handlers for the object types #N$10 to #N$17.
W $924A,$10,$10 Handlers for the object types #N$18 to #N$1F.
W $925A,$10,$10 Handlers for the object types #N$20 to #N$27.
W $926A,$10,$10 Handlers for the object types #N$28 to #N$2F.
W $927A,$10,$10 Handlers for the object types #N$30 to #N$37.
W $928A,$10,$10 Handlers for the object types #N$38 to #N$3F.
W $929A,$10,$10 Handlers for the object types #N$40 to #N$47.
W $92AA,$10,$10 Handlers for the object types #N$48 to #N$4F.
W $92BA,$10,$10 Handlers for the object types #N$50 to #N$57.
W $92CA,$10,$10 Handlers for the object types #N$58 to #N$5F.
W $92DA,$10,$10 Handlers for the object types #N$60 to #N$67.
W $92EA,$10,$10 Handlers for the object types #N$68 to #N$6F.
W $92FA,$10,$10 Handlers for the object types #N$70 to #N$77.
W $930A,$10,$10 Handlers for the object types #N$78 to #N$7F.
W $931A,$10,$10 Handlers for the object types #N$80 to #N$87.
W $932A,$08,$10 Handlers for the object types #N$88 to #N$8B.

w $9332 Sprite Address Table
@ $9332 label=Sprite_Address_Table
D $9332 The address of the data of each sprite, indexed by the sprite id (which
. is also the type of the object). Several ids share the same sprite data; they
. are drawn with different attributes or by different handlers.
W $9332,$10,$10 Sprites #N$00 to #N$07.
W $9342,$10,$10 Sprites #N$08 to #N$0F.
W $9352,$10,$10 Sprites #N$10 to #N$17.
W $9362,$10,$10 Sprites #N$18 to #N$1F.
W $9372,$10,$10 Sprites #N$20 to #N$27.
W $9382,$10,$10 Sprites #N$28 to #N$2F.
W $9392,$10,$10 Sprites #N$30 to #N$37.
W $93A2,$10,$10 Sprites #N$38 to #N$3F.
W $93B2,$10,$10 Sprites #N$40 to #N$47.
W $93C2,$10,$10 Sprites #N$48 to #N$4F.
W $93D2,$10,$10 Sprites #N$50 to #N$57.
W $93E2,$10,$10 Sprites #N$58 to #N$5F.
W $93F2,$10,$10 Sprites #N$60 to #N$67.
W $9402,$10,$10 Sprites #N$68 to #N$6F.
W $9412,$10,$10 Sprites #N$70 to #N$77.
W $9422,$10,$10 Sprites #N$78 to #N$7F.
W $9432,$10,$10 Sprites #N$80 to #N$87.
W $9442,$10,$10 Sprites #N$88 to #N$8F.
W $9452,$02,$10 Sprites #N$90.

c $9454 Pause Briefly
@ $9454 label=Pause_Briefly
D $9454 A short delay loop. It is the handler of type #N$00, the type of an
. empty object record, so a record that is not in use costs a little time
. instead of none. It is also used to debounce the pause key.
  $9454,$01 Start the delay counter at #N$00, which makes #N$0100 passes round
. the loop.
@ $9455 label=Pause_Briefly_Loop
  $9455,$03 Decrease the delay counter and loop back until it is zero.
  $9458,$01 Return.

c $9459 Finish Object Pass
@ $9459 label=Finish_Object_Pass
D $9459 The return address of every object handler.
.
. It moves #REGix on to the next object record. If the frame counter has changed
. since the last time (that is, an interrupt has happened) the priority records
. are handled first: the two projectile records and, while Sabreman's type is
. from #N$09 to #N$1B, Sabreman himself.
.
. When all of the object records have been handled it adds one to the tick
. counter, counts down the gem timer, checks for the pause key and for a new
. press of an action key, runs the handlers of the small object records and then
. starts the main loop again.
N $9459 Move on to the next object record and see if the frame counter has
. changed.
  $9459,$03 Set the size of an object record to #N$10.
  $945C,$02 Move #REGix on to the next object record.
  $945E,$02 Stash the pointer to the next record on the stack.
  $9460,$03 Fetch the frame counter (the low word of FRAMES) from #N$5C78.
  $9463,$04 Fetch the last frame counter from #R$8EDF.
  $9467,$03 Store the new frame counter in #R$8EDF.
  $946A,$03 Subtract the last frame counter from the new one.
  $946D,$03 Jump to #R$951D if the frame counter has changed.
@ $9470 label=Finish_Object_Pass_Next_Record
N $9470 If there are more object records, run the handler of the next one.
  $9470,$01 Restore the pointer to the next record into #REGhl.
  $9471,$03 Point at the end of the object records (#R$902A).
  $9474,$03 Subtract the end of the records from the pointer.
  $9477,$03 Jump to #R$9207 if there are more records to handle.
N $947A All of the records have been handled, so count a tick.
  $947A,$03 Fetch the tick counter from #R$8ED6.
  $947D,$01 Add one to the tick counter.
  $947E,$03 Store the tick counter.
  $9481,$03 Fetch the byte at #R$8EF1.
  $9484,$03 Store it in #R$8EF2.
  $9487,$04 Write #N$00 to #R$8EF1.
  $948B,$03 Fetch the low byte of the tick counter.
  $948E,$02,b$01 Keep only bits 0 and 1.
  $9490,$02 Jump to #R$94A9 if the tick counter is not a multiple of
. four.
N $9492 Every fourth tick the gem timer counts down.
  $9492,$03 Fetch the gem timer from #R$8EEE.
  $9495,$03 Jump to #R$94A9 if the gem timer is zero.
  $9498,$02 Count down the gem timer, keeping it as a BCD value.
  $949A,$03 Store the gem timer.
  $949D,$01 Stash the timer flags on the stack.
  $949E,$03 Print the gem timer.
  $94A1,$01 Restore the timer flags.
  $94A2,$02 Jump to #R$94A9 if the gem timer has not run out.
  $94A4,$05 Make Sabreman bright white again.
@ $94A9 label=Finish_Object_Pass_Check_Pause
N $94A9 Check for the ENTER key which pauses the game.
  $94A9,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$BF | ENTER | L | K | J | H }
. TABLE#
  $94AF,$02,b$01 Keep only the bit for ENTER.
  $94B1,$02 Jump to #R$94DC if ENTER is not pressed.
  $94B3,$01 Disable interrupts.
@ $94B4 label=Finish_Object_Pass_Wait_For_Release
N $94B4 Wait for ENTER to be released.
  $94B4,$07 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$BF | ENTER | L | K | J | H }
. TABLE#
  $94BB,$02 Read from port #N$FE.
  $94BD,$02,b$01 Keep only the bit for ENTER.
  $94BF,$02 Jump to #R$94B4 if ENTER is still pressed.
@ $94C1 label=Finish_Object_Pass_Wait_For_Resume
N $94C1 The game is paused. Wait for ENTER to be pressed again.
  $94C1,$07 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$BF | ENTER | L | K | J | H }
. TABLE#
  $94C8,$02 Read from port #N$FE.
  $94CA,$02,b$01 Keep only the bit for ENTER.
  $94CC,$02 Jump to #R$94C1 if ENTER is not pressed.
@ $94CE label=Finish_Object_Pass_Wait_For_Final_Release
N $94CE Wait for ENTER to be released and carry on with the game.
  $94CE,$07 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$BF | ENTER | L | K | J | H }
. TABLE#
  $94D5,$02 Read from port #N$FE.
  $94D7,$02,b$01 Keep only the bit for ENTER.
  $94D9,$02 Jump to #R$94CE if ENTER is still pressed.
  $94DB,$01 Enable interrupts.
@ $94DC label=Finish_Object_Pass_Check_Action_Keys
N $94DC Check for the keys that pick up, drop or throw weapons (SPACE, SYMBOL
. SHIFT, M, N and B). A new press is recorded in #R$8EEA and a held key in
. #R$8EE9.
  $94DC,$03 Fetch the room redrawn flag from #R$8EF0.
  $94DF,$03 Jump to #R$950C if the room has just been redrawn.
  $94E2,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | SYMBOL SHIFT | M | N | B }
. TABLE#
  $94E8,$01 Flip the bits so that a pressed key gives a set bit.
  $94E9,$02,b$01 Keep only the bits of the five keys.
  $94EB,$02 Jump to #R$94F5 if one of the keys is pressed.
@ $94ED label=Finish_Object_Pass_Store_Key_Flags
  $94ED,$03 Store the key held flag in #R$8EE9.
  $94F0,$03 Store the new key press flag in #R$8EEA.
  $94F3,$02 Jump to #R$950C.
@ $94F5 label=Finish_Object_Pass_Key_Is_Pressed
  $94F5,$03 Fetch the key held flag from #R$8EE9.
  $94F8,$03 Jump to #R$9508 if the key was already pressed.
N $94FB This is a new press, so empty the table of the weapons that Sabreman
. holds; the handlers of the weapons fill it in again.
  $94FB,$09 Empty the three slots of the weapons table at #R$8EEB.
  $9504,$04 Jump to #R$94ED with #N$FF to set the key held and new key press
. flags.
@ $9508 label=Finish_Object_Pass_Key_Is_Held
  $9508,$04 The key is only being held, so clear the new key press flag in
. #R$8EEA.
@ $950C label=Handle_Small_Objects
N $950C Run the handlers of the small object records.
  $950C,$04 Point at the first small object record (#R$902A).
@ $9510 label=Finish_Object_Pass_Small_Object_Loop
  $9510,$03 Point at the return address of the handler (#R$954C).
  $9513,$01 Stash it on the stack.
  $9514,$03 Fetch the type of the object.
  $9517,$03 Point at the handler table (#R$921A).
  $951A,$03 Jump to #R$9211 to run the handler.
@ $951D label=Finish_Object_Pass_Priority_Records
N $951D The frame counter has changed, so handle the priority records: the first
. two object records (the projectiles) and, when Sabreman's type is from #N$09
. to #N$1B, Sabreman's record too.
  $951D,$04 Point at the first object record (#R$8EFA).
@ $9521 label=Finish_Object_Pass_Priority_Loop
  $9521,$03 Point at the return address of the handler (#R$9527).
  $9524,$03 Jump to #R$920A to run the handler.
@ $9527 label=Finish_Object_Pass_Priority_Return
  $9527,$03 Set the size of an object record to #N$10.
  $952A,$02 Move #REGix on to the next object record.
  $952C,$03 Point at the record of Sabreman (#R$8F1A).
  $952F,$03 Fetch the type of Sabreman.
  $9532,$04 Jump to #R$953D if the type is greater than or equal to
. #N$1C.
  $9536,$04 Jump to #R$953D if the type is less than #N$09.
  $953A,$03 Point at the record after Sabreman's (#R$8F2A).
@ $953D label=Finish_Object_Pass_Priority_Limit
  $953D,$03 Copy #REGix to #REGhl (using the stack).
  $9540,$03 Subtract the limit from the pointer.
  $9543,$02 Jump to #R$9521 if there are more priority records to
. handle.
  $9545,$02 Restore #REGix to the pointer to the next record.
  $9547,$02 Stash it on the stack again.
  $9549,$03 Jump to #R$9470 to carry on with the normal pass.
@ $954C label=Finish_Object_Pass_Small_Object_Return
N $954C Return address of the handlers of the small object records.
  $954C,$03 Set the size of a small object record to #N$08.
  $954F,$02 Move #REGix on to the next small object record.
  $9551,$03 Copy #REGix to #REGhl (using the stack).
  $9554,$03 Point at the end of the small object records (#R$9052).
  $9557,$03 Subtract the end of the records from the pointer.
  $955A,$02 Jump to #R$9510 if there are more small object records to
. handle.
  $955C,$04 Write #N$00 to #R$8EF0 to clear the room redrawn flag.
  $9560,$03 Jump back to the main loop.

c $9563 Clear Workspace
@ $9563 label=Clear_Workspace
D $9563 Sets up the registers to clear the #N$19 bytes of the sprite drawing
. workspace and the other variables from #R$8EE1 to #R$8EF9 (which includes the
. score and the completion percentage).
E $9563 Continue on to #R$9569.
  $9563,$03 Set the number of bytes of the workspace to clear to #N$0019.
  $9566,$03 Point at the start of the workspace (#R$8EE1).

c $9569 Fill Memory
@ $9569 label=FillMemory
D $9569 Writes a value to a block of memory. Entering at #R$9569 writes #N$00;
. entering at #R$956B writes the value in #REGe.
E $9569 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE56 }
. { #GUNFRIGHT$D6E1 }
. { #KNIGHTLORE$D53A }
. { #MARTIANOIDS$B1A3 }
. { #NIGHTSHADE$E5BA }
. { #PENTAGRAM$CB77 }
. LIST#
R $9569 HL Start address
R $9569 BC Number of bytes
R $9569 E Value to write (entry point #R$956B only)
  $9569,$02 Set the value to write to #N$00.
@ $956B label=FillMemory_WithValue
  $956B,$01 Write the value to the address.
  $956C,$01 Move on to the next address.
  $956D,$05 Decrease the byte counter and loop back to #R$956B until all of the
. bytes have been written.
  $9572,$01 Return.

c $9573 Clear Attributes
@ $9573 label=Clear_Attributes
D $9573 Sets the whole of the attribute buffer to white ink on black paper.
  $9573,$03 Point at the start of the attribute buffer (#N$5800).
  $9576,$03 Set the size of the attribute buffer (#N$0300 bytes).
  $9579,$02 Use bright white ink on black paper (#N$47) as the attribute to
. write.
  $957B,$02 Jump to #R$956B to fill the attribute buffer.

c $957D Clear Screen
@ $957D label=Clear_Screen
D $957D Sets the attributes of the play area to white ink on black paper and
. then clears the pixels of the whole screen.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$957D }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #SCR$01(clear-screen-before)
. | #SIM(start=$957D,stop=$0000,sp=$5B40)
. #SCR$01(clear-screen-after) } UDGTABLE# #POPS
  $957D,$03 Set the attributes of the play area.
  $9580,$03 Point at the start of the display file (#N$4000).
  $9583,$03 Set the size of the display file (#N$1800 bytes).
  $9586,$02 Jump to #R$9569 to clear the display file.

c $9588 Reset World Map
@ $9588 label=Reset_World_Map
D $9588 Writes #N$00 to the second byte of each of the first #N$0240 entries of
. the #R$7000 world map. The second byte of an entry holds the data of a rope
. (see #R$AE81), which changes during the game.
.
. The counters are set up so that the loop runs #N$40 times on the first pass
. and #N$0100 times on each of the next two passes. The last #N$0100 entries of
. the map (the last sixteen rows of rooms) are not reset.
  $9588,$03 Point at the end of the world map (#R$7680).
  $958B,$03 Point at the start of the world map (#R$7000).
  $958E,$03 Subtract the start from the end of the map to get the size of the
. map in bytes.
  $9591,$01 Exchange the registers so that #REGde holds the size and #REGhl the
. address.
  $9592,$01 Move to the second byte of the first entry.
  $9593,$04 Halve the size of the map to get the number of entries.
  $9597,$02 Copy the number of entries into the loop counters (the high byte
. into #REGc and the low byte into #REGb).
@ $9599 label=Reset_World_Map_Loop
  $9599,$02 Write #N$00 to the second byte of the entry.
  $959B,$02 Move on to the second byte of the next entry.
  $959D,$02 Decrease the entry counter (low byte) and loop back until it is
. zero.
  $959F,$03 Decrease the high byte of the entry counter and loop back until the
. second byte of every entry has been cleared.
  $95A2,$01 Return.

c $95A3 Draw Menu Icons
@ $95A3 label=Draw_Menu_Icons
D $95A3 Draws the four icons (keyboard, joystick, cursor keys and Interface II)
. down the side of the game selection screen, using the object record at #R$95D8
. and the sprite ids #N$8C to #N$8F. The attributes of the icons are red,
. magenta, green and cyan, like the lines of the menu.
.
. It only does anything the first time it is called.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$95A3 }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$9078,stop=$907B,sp=$5B40)
. #SCR$02,$00,$04,$0A,$10(menu-icons-before)
. | #SIM(start=$907B,stop=$907E,sp=$5B40)
. #SCR$02,$00,$04,$0A,$10(menu-icons-after) } UDGTABLE# #POPS
  $95A3,$03 Fetch the icons drawn flag from #R$8EF7.
  $95A6,$02 Return if the icons have already been drawn.
  $95A8,$04 Point at the record of the menu icon (#R$95D8).
  $95AC,$04 Set the sprite id to #N$8C.
  $95B0,$04 Set the attribute to #N$42 (red).
  $95B4,$04 Set the y position to #N$38.
  $95B8,$02 Set the number of menu icons to draw to #N$04.
@ $95BA label=Draw_Menu_Icons_Loop
  $95BA,$01 Stash the icon counter on the stack.
  $95BB,$03 Draw the icon.
  $95BE,$03 Set the attributes of the icon.
  $95C1,$01 Restore the icon counter.
  $95C2,$03 Fetch the y position of the icon.
  $95C5,$02 Move down by #N$18 pixels.
  $95C7,$03 Store the new y position.
  $95CA,$03 Move on to the next sprite id.
  $95CD,$03 Move on to the next attribute.
  $95D0,$02 Decrease the icon counter and loop back until all of the icons are
. drawn.
  $95D2,$05 Write #N$01 to #R$8EF7 to show that the icons have been drawn.
  $95D7,$01 Return.

b $95D8 Menu Icon Record
@ $95D8 label=Menu_Icon_Record
D $95D8 The object record that #R$95A3 uses to draw each of the four menu icons.
. The sprite id, the y position and the attribute are changed for each icon.
B $95D8,$01 Sprite id (the keyboard icon).
B $95D9,$01 X position.
B $95DA,$01 Room x.
B $95DB,$01 Y position (set by #R$95A3).
B $95DC,$01 Room y.
B $95DD,$01 Attribute: #COLOUR(#PEEK(#PC)).

c $95DE Show Game Over
@ $95DE label=Show_Game_Over
D $95DE Clears the screen, prints how much of the Underwurlde has been explored,
. prints GAME OVER, waits for key 0 (or a timeout) and then goes back to the
. game selection screen.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$95DE }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #SCR$01(game-over-before)
. | #SIM(start=$95DE,stop=$95ED,sp=$5B40)
. #SCR$01(game-over-after) } UDGTABLE# #POPS
  $95DE,$03 Clear the screen.
  $95E1,$03 Print the percentage of the Underwurlde that has been explored.
  $95E4,$03 Set the position of the text (x position #N$58, y position #N$30).
  $95E7,$03 Point at the text GAME OVER (#R$9609).
  $95EA,$03 Print the text.
  $95ED,$03 Wait for key 0.
  $95F0,$03 Jump to #R$906A to go back to the selection screen.

c $95F3 Wait For Key
@ $95F3 label=Wait_For_Key
D $95F3 Waits until key 0 is pressed. It gives up after #N$0C times #N$010000
. passes round the inner loop if no key is pressed.
  $95F3,$02 Set the outer counter to #N$0C.
  $95F5,$03 Set the inner counter to #N$0000, which makes #N$010000 passes round
. the inner loop.
@ $95F8 label=Wait_For_Key_Inner_Loop
  $95F8,$01 Decrease the inner counter.
  $95F9,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $95FF,$02,b$01 Keep only the bit for key 0.
  $9601,$01 Return if key 0 is pressed.
  $9602,$04 Jump back to #R$95F8 until the inner counter is zero.
  $9606,$02 Decrease the outer counter and loop back until it is zero.
  $9608,$01 Return.

t $9609 Messaging: Game Over Text
@ $9609 label=Game_Over_Text
D $9609 The text GAME OVER, with its attribute first. The last character has bit
. 7 set.
B $9609,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $960A,$09,$08:$01 "GAME OVER"

c $9613 Build Shift Table
@ $9613 label=BuildShiftTable
D $9613 Builds the tables that the sprite routines use to shift a byte of sprite
. data to any pixel position.
.
. For every byte value #REGl from #N$00 to #N$FF the table holds eight words,
. which are the byte shifted left by zero to seven bits. For a shift of n
. bits, the low byte of the word is stored at #N$FF00 less #N$0200 times n, plus
. #REGl, and the high byte is stored in the page below it. The tables use the
. pages from #N$F0 to #N$FF.
.
. The sprite routines select a table with #REGb (which is always an even page)
. and read the high byte with #REGb and the low byte with #REGb+#N$01.
E $9613 View the equivalent code in;
. #LIST
. { #SABREWULF$B902 }
. LIST#
  $9613,$02 Start with the byte value #N$00.
@ $9615 label=BuildShiftTable_Value
  $9615,$02 Clear the high byte of the shifted word.
  $9617,$01 Start the low byte of the shifted word with the byte value.
  $9618,$02 Start at the page of the first low byte (#N$FF).
  $961A,$02 Set the number of pixel offsets to build to #N$08.
@ $961C label=BuildShiftTable_Offset
  $961C,$01 Store the low byte of the shifted word.
  $961D,$01 Move down to the page of the high byte.
  $961E,$01 Store the high byte of the shifted word.
  $961F,$01 Move down to the page of the next low byte.
  $9620,$04 Shift the word left by one bit.
  $9624,$02 Decrease the shift counter and loop back until all eight shifts are
. stored.
  $9626,$01 Move on to the next byte value.
  $9627,$02 Jump back to #R$9615 until all of the byte values have been
. done.
  $9629,$01 Return.

c $962A Draw Entity
@ $962A label=DrawEntity
D $962A Draws the sprite of the object that #REGix points at, using XOR. Nothing
. is erased.
.
. The #R$9728 routine works through two sets of registers: the set that is
. current when it is entered belongs to the sprite at the old position and the
. other set belongs to the sprite at the new position. Here there is no old
. sprite, so its row count is zero.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$962A }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #SIM(start=$989F,stop=$0000,ix=$8F1A,sp=$5B40)
. #SIM(start=$9636,stop=$0000,ix=$8F1A,sp=$5B40)
. #SCR$03,$06,$0E,$09,$06(draw-entity-before)
. | #SIM(start=$962A,stop=$0000,ix=$8F1A,sp=$5B40)
. #SCR$03,$06,$0E,$09,$06(draw-entity-after) } UDGTABLE# #POPS
E $962A View the equivalent code in;
. #LIST
. { #ATICATAC$9F4A }
. { #COOKIE$7617 }
. { #LUNARJETMAN$8634 }
. { #PSSST$7536 }
. { #SABREWULF$B919 }
. { #TRANZAM$7149 }
. LIST#
R $962A IX Object record
  $962A,$03 Prepare the registers for the sprite at its new position.
  $962D,$01 Switch to the registers of the old sprite.
  $962E,$04 Write #N$00 to #R$8EE2 as there are no rows of the old sprite to
. draw.
  $9632,$01 #REGc=#N$00.
  $9633,$03 Jump to #R$9728 to draw the sprite.

c $9636 Remove Entity
@ $9636 label=RemoveEntity
D $9636 Draws the sprite of the object at the position that was stored by
. #R$989F, which removes it from the screen because the drawing uses XOR.
. Nothing new is drawn, so the row count of the new sprite is zero.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$9636 }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #SIM(start=$989F,stop=$0000,ix=$8F1A,sp=$5B40)
. #SCR$03,$06,$0E,$09,$06(remove-entity-before)
. | #SIM(start=$9636,stop=$0000,ix=$8F1A,sp=$5B40)
. #SCR$03,$06,$0E,$09,$06(remove-entity-after) } UDGTABLE# #POPS
E $9636 View the equivalent code in;
. #LIST
. { #ATICATAC$9F56 }
. { #COOKIE$7607 }
. { #SABREWULF$B8F5 }
. { #TRANZAM$7139 }
. LIST#
R $9636 IX Object record
  $9636,$03 Prepare the registers for the sprite at its old position.
  $9639,$01 Switch to the registers of the new sprite.
  $963A,$02 Write #N$00 to #R$8EE3 as there are no rows of the new sprite to
. draw.
  $963C,$03 Store #REGa in the second row counter (#R$8EE3).
  $963F,$01 Switch back to the registers of the old sprite.
  $9640,$03 Jump to #R$9728 to draw the sprite.

c $9643 Get Sprite "A"
@ $9643 label=GetSpriteA
D $9643 Fetches the address of the graphic for the sprite id that was
. recorded in #R$8EE1 by #R$989F.
E $9643 View the equivalent code in;
. #LIST
. { #ATICATAC$9E86 }
. { #SABREWULF$B925 }
. LIST#
R $9643 O:DE Address of the sprite data
  $9643,$03 Fetch the previous sprite id from #R$8EE1.

c $9646 Fetch Sprite
@ $9646 label=FetchSprite
D $9646 Looks up the address of the graphic for a sprite in the table at
. #R$9332. The table has a two byte entry for each sprite id, starting at id
. #N$00.
E $9646 View the equivalent code in;
. #LIST
. { #ATICATAC$9E89 }
. { #COOKIE$7623 }
. { #LUNARJETMAN$8568 }
. { #SABREWULF$B928 }
. { #TRANZAM$7155 }
. LIST#
R $9646 A Sprite id
R $9646 O:DE Address of the sprite data
  $9646,$01 Use the sprite id as the low byte of the offset.
  $9647,$02 Clear the high byte of the offset.
  $9649,$01 Double the sprite id to get the offset into the table.
  $964A,$03 Point at the sprite address table (#R$9332).
  $964D,$01 Add the offset to the address of the table.
  $964E,$01 Fetch the low byte of the address of the sprite data.
  $964F,$01 Move on to the high byte.
  $9650,$01 Fetch the high byte of the address of the sprite data.
  $9651,$01 Return.

c $9652 Fetch Actor Sprite
@ $9652 label=FetchActorSprite
D $9652 Fetches the address of the graphic for the sprite of an object. The type
. of the object is also the id of its sprite. It uses #R$9646 to look the
. address up.
E $9652 View the equivalent code in;
. #LIST
. { #ATICATAC$9E96 }
. { #LUNARJETMAN$857F }
. { #SABREWULF$B934 }
. { #TRANZAM$7168 }
. LIST#
R $9652 IX Object record
R $9652 O:DE Address of the sprite data
  $9652,$03 Fetch the type of the object (which is also its sprite id).
  $9655,$02 Jump to #R$9646 to look up the address.

c $9657 Prepare Draw 2/ 3 Byte Sprite
@ $9657 label=PrepDraw23
D $9657 Gets the registers ready to draw the sprite at its old position, which
. was stored by #R$989F.
.
. The shift table page is put in #REGb, the screen address of the bottom row is
. put in #REGhl, and the pointer to the pixel data is put in #REGde. The operand
. of the jump at #R$9760 is changed so that the unrolled code at #R$975B draws
. the right number of bytes for each row, and the number of rows is stored in
. #R$8EE2.
E $9657 View the equivalent code in;
. #LIST
. { #ATICATAC$9F80 }
. { #SABREWULF$B939 }
. LIST#
R $9657 O:B Page of the shift table
R $9657 O:C #N$00
R $9657 O:DE Address of the pixel data
R $9657 O:HL Screen address of the bottom row
  $9657,$03 Fetch the address of the sprite data in #REGde.
  $965A,$03 Fetch the old x position into #REGl and the old y position into
. #REGh.
  $965D,$01 Copy the x position to #REGa.
  $965E,$01 Subtract one.
  $965F,$01 Multiply by two (rotate left).
  $9660,$02,b$01 Keep only the bits of the pixel offset (bits 1-3).
  $9662,$02,b$01 Set bits 4-7 to point at the pages #N$F0 to #N$FF.
  $9664,$01 Store the page of the shift table in #REGb.
  $9665,$01 Fetch the width of the sprite in bytes.
  $9666,$01 Move on to the height of the sprite.
  $9667,$02 Negate the width.
  $9669,$02,b$01 Keep only the low four bits.
  $966B,$02 Subtract #N$07 (which leaves #N$09 minus the width, the number of
. unused pieces of the unrolled code).
  $966D,$02 Multiply by four.
  $966F,$01 Store the result in #REGc.
  $9670,$01 Multiply by two.
  $9671,$01 Add the result so that it is multiplied by twelve (the size of the
. code for one byte of the row).
  $9672,$01 Store the offset in #REGc.
  $9673,$01 Copy the x position to #REGa.
  $9674,$02,b$01 Keep only the pixel offset.
  $9676,$01 Fetch the offset.
  $9677,$02 Jump to #R$967B if the sprite does not start on a character
. boundary.
  $9679,$02 Add #N$06 to the offset to skip the first six bytes of the code for
. the first byte of the row, as no cell to the left is needed.
@ $967B label=PrepDraw23_SetJump
  $967B,$03 Change the operand of the jump at #R$9760.
  $967E,$01 Fetch the height of the sprite.
  $967F,$01 Move on to the pixel data.
  $9680,$03 Store the number of rows of the old sprite in #R$8EE2.
  $9683,$03 Convert the position into the screen address.
  $9686,$02 #REGc=#N$00.
  $9688,$01 Return.

c $9689 Prepare Draw 2 Byte Sprite
@ $9689 label=PrepDraw2
D $9689 Gets the registers ready to draw the sprite of the object that #REGix
. points at, at its current position.
.
. It does what #R$9657 does for the old sprite, but it uses the position and the
. type of the object, patches the jump at #R$97E6 (used by the unrolled code at
. #R$97E1), and stores the number of rows in #R$8EE3 and #R$8EE7. The number of
. character cells that the sprite covers in each row (one more than the width if
. the sprite is not aligned to a character boundary) is stored in #R$8EE6.
E $9689 View the equivalent code in;
. #LIST
. { #ATICATAC$9F9F }
. { #SABREWULF$B969 }
. LIST#
R $9689 IX Object record
R $9689 O:B Page of the shift table
R $9689 O:C #N$00
R $9689 O:DE Address of the pixel data
R $9689 O:HL Screen address of the bottom row
  $9689,$03 Fetch the address of the sprite data in #REGde.
  $968C,$03 Fetch the x position of the object into #REGl.
  $968F,$03 Fetch the y position of the object into #REGh.
  $9692,$01 Copy the x position to #REGa.
  $9693,$01 Subtract one.
  $9694,$01 Multiply by two (rotate left).
  $9695,$02,b$01 Keep only the bits of the pixel offset (bits 1-3).
  $9697,$02,b$01 Set bits 4-7 to point at the pages #N$F0 to #N$FF.
  $9699,$01 Store the page of the shift table in #REGb.
  $969A,$01 Copy the x position to #REGa.
  $969B,$02,b$01 Keep only the pixel offset.
  $969D,$01 Fetch the width of the sprite in bytes.
  $969E,$02 Jump to #R$96A1 if the sprite starts on a character
. boundary.
  $96A0,$01 Add one for the extra cell that the shifted sprite needs.
@ $96A1 label=PrepDraw2_StoreCells
  $96A1,$03 Store the number of cells in each row in #R$8EE6.
  $96A4,$01 Fetch the width of the sprite in bytes.
  $96A5,$01 Move on to the height of the sprite.
  $96A6,$02 Negate the width.
  $96A8,$02,b$01 Keep only the low four bits.
  $96AA,$02 Subtract #N$07 (which leaves #N$09 minus the width, the number of
. unused pieces of the unrolled code).
  $96AC,$02 Multiply by four.
  $96AE,$01 Store the result in #REGc.
  $96AF,$01 Multiply by two.
  $96B0,$01 Add the result so that it is multiplied by twelve (the size of the
. code for one byte of the row).
  $96B1,$01 Store the offset in #REGc.
  $96B2,$01 Copy the x position to #REGa.
  $96B3,$02,b$01 Keep only the pixel offset.
  $96B5,$01 Fetch the offset.
  $96B6,$02 Jump to #R$96BA if the sprite does not start on a character
. boundary.
  $96B8,$02 Add #N$06 to the offset to skip the first six bytes of the code for
. the first byte of the row, as no cell to the left is needed.
@ $96BA label=PrepDraw2_SetJump
  $96BA,$03 Change the operand of the jump at #R$97E6.
  $96BD,$01 Fetch the height of the sprite.
  $96BE,$01 Move on to the pixel data.
  $96BF,$03 Store the number of rows of the new sprite in #R$8EE3.
  $96C2,$03 Store the height of the sprite in #R$8EE7.
  $96C5,$03 Convert the position into the screen address.
  $96C8,$02 #REGc=#N$00.
  $96CA,$01 Return.

c $96CB Update Object Sprite
@ $96CB label=Update_Object_Sprite
D $96CB Redraws the sprite of the object that #REGix points at and sets its
. attributes.
.
. If bit 0 of byte #N$0F of the object is clear, the sprite is moved with
. #R$96F7. If the bit is set, the sprite has no old image on the screen to erase
. (for example because the room has just been drawn), so the bit is cleared and
. the sprite is just drawn.
.
. The entry at #R$96E1 does the same using bit 0 of byte #N$07 of the object.
R $96CB IX Object record
  $96CB,$06 Jump to #R$96D7 if the flag is set.
  $96D1,$03 Erase the sprite at its old position and draw it at the new one.
  $96D4,$03 Jump to #R$9867.
@ $96D7 label=Update_Object_Sprite_Reset_Redraw_Flag
  $96D7,$04 Reset bit 0 of the redraw flags of the object.
@ $96DB label=Update_Object_Sprite_Draw
  $96DB,$03 Draw the sprite.
  $96DE,$03 Jump to #R$9867.
@ $96E1 label=Update_Object_Sprite_Using_Flags
  $96E1,$06 Jump to #R$96ED if the flag is set.
  $96E7,$03 Erase the sprite at its old position and draw it at the new one.
  $96EA,$03 Jump to #R$9867.
@ $96ED label=Update_Object_Sprite_Reset_Flag
  $96ED,$04 Reset bit 0 of the flags of the object.
  $96F1,$03 Draw the sprite.
  $96F4,$03 Jump to #R$9867.

c $96F7 Display Entity
@ $96F7 label=DisplayEntity
D $96F7 Erases the sprite at its old position and draws it at the new one.
.
. Both sprites are drawn with XOR, a row at a time, so that the rows are
. alternated between the two sprites and the screen is never without the sprite
. for long. If the sprites are offset vertically, the rows of the sprite that
. has no matching row in the other one are drawn first.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$96F7 }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #SIM(start=$989F,stop=$0000,ix=$8F1A,sp=$5B40)
. #SCR$03,$06,$0E,$09,$06(display-entity-before)
. | #POKES$8F1B,$50;$8F1D,$97
. #SIM(start=$96F7,stop=$0000,ix=$8F1A,sp=$5B40)
. #SIM(start=$9867,stop=$0000,ix=$8F1A,sp=$5B40)
. #SCR$03,$06,$0E,$09,$06(display-entity-after) } UDGTABLE# #POPS
E $96F7 View the equivalent code in;
. #LIST
. { #ATICATAC$9FCA }
. { #COOKIE$75CC }
. { #JETPAC$726A }
. { #PSSST$74EB }
. { #SABREWULF$B9A9 }
. { #TRANZAM$7101 }
. LIST#
R $96F7 IX Object record
  $96F7,$03 Prepare the registers for the sprite at its new position.
  $96FA,$01 Switch to the registers of the old sprite.
  $96FB,$03 Prepare the registers for the sprite at its old position.
  $96FE,$03 Fetch the old y position from #R$8EE5.
  $9701,$03 Subtract the new y position of the object.
  $9704,$03 Jump to #R$9742 if the y position has not changed.
  $9707,$03 Jump to #R$9719 if the sprite has moved down the screen.
N $970A The old sprite is lower than the new one, so draw the bottom rows of the
. old sprite on their own first.
  $970A,$01 Copy the number of rows that stand alone to #REGc.
  $970B,$03 Fetch the number of rows of the old sprite from #R$8EE2.
  $970E,$01 Compare it with the number of rows that stand alone.
  $970F,$03 Jump to #R$9742 if the old sprite has no more rows than that, so
. that the sprites do not overlap and are each drawn in full.
  $9712,$01 Subtract the number of rows that stand alone.
  $9713,$03 Store the number of rows that remain.
  $9716,$03 Jump to #R$9728 to draw those rows of the old sprite on their own.

c $9719 Display Entity Moved Down
@ $9719 label=DisplayEntity_NewLower
D $9719 Draws the bottom rows of the new sprite on their own first, because the
. new sprite is lower than the old one (the old sprite has moved up the screen).
E $9719 View the equivalent code in;
. #LIST
. { #SABREWULF$B9CB }
. LIST#
R $9719 A Old y position minus the new y position (negative)
  $9719,$01 Switch to the registers of the new sprite.
  $971A,$02 Make the difference positive.
  $971C,$01 Copy the number of rows that stand alone to #REGc.
  $971D,$03 Fetch the number of rows of the new sprite from #R$8EE3.
  $9720,$01 Compare it with the number of rows that stand alone.
  $9721,$03 Jump to #R$9741 if the new sprite has no more rows than that, so
. that the sprites do not overlap and are each drawn in full.
  $9724,$01 Subtract the number of rows that stand alone.
  $9725,$03 Jump to #R$9755 to store the number of rows that remain and draw
. those rows of the new sprite on their own.

c $9728 XOR Sprite Loop
@ $9728 label=XORSpriteLoop
D $9728 Draws the old sprite and the new sprite a row at a time, alternating
. between the two, until every row of both has been drawn. The set of registers
. that is current on entry belongs to the old sprite, which is drawn by #R$975B.
. The other set belongs to the new sprite, which is drawn by #R$97E1.
.
. In each set #REGhl is the screen address of the next row (the sprites are
. drawn from the bottom row upwards), #REGde points at the pixel data and #REGb
. is the page of the shift table. #REGc counts the rows that remain.
.
. When both counts reach zero, the counts that are held in #R$8EE2 (old sprite)
. and #R$8EE3 (new sprite) are loaded and the whole process repeats. The routine
. returns when those are zero as well. This allows the rows that have no partner
. to be drawn first (see #R$96F7).
E $9728 View the equivalent code in;
. #LIST
. { #ATICATAC$9E9B }
. { #COOKIE$763A }
. { #LUNARJETMAN$858E }
. { #SABREWULF$B9DA }
. LIST#
N $9728 Draw a row of the old sprite, if it has any rows left.
  $9728,$01 Fetch the row count of the old sprite.
  $9729,$03 Jump to #R$973C if there are no rows left.
  $972C,$01 Decrease the row count.
  $972D,$03 Draw a row of the old sprite.
N $9730 Draw a row of the new sprite, if it has any rows left.
  $9730,$01 Switch to the registers of the new sprite.
  $9731,$01 Fetch the row count of the new sprite.
  $9732,$03 Jump to #R$9739 if there are no rows left.
@ $9735 label=XORSpriteLoop_NewRow
  $9735,$01 Decrease the row count.
  $9736,$03 Draw a row of the new sprite.
@ $9739 label=XORSpriteLoop_OldRow
  $9739,$01 Switch to the registers of the old sprite.
  $973A,$02 Jump back to #R$9728 to draw the next pair of rows.
@ $973C label=XORSpriteLoop_NewOnly
  $973C,$01 Switch to the registers of the new sprite.
  $973D,$01 Fetch the row count of the new sprite.
  $973E,$03 Jump to #R$9735 if there are rows left.
@ $9741 label=XORSpriteLoop_Done
  $9741,$01 Switch to the registers of the old sprite.
@ $9742 label=XORSpriteLoop_Reload
N $9742 Both of the counts are zero. Load the row counts that were stored by the
. preparation routines and go round again, unless they are zero too.
  $9742,$03 Fetch the number of rows of the old sprite from #R$8EE2.
  $9745,$01 Copy the number of rows to #REGc.
  $9746,$03 Fetch the number of rows of the new sprite from #R$8EE3.
  $9749,$01 Combine it with the number of rows of the old sprite.
  $974A,$01 Return if there are no rows left to draw.
  $974B,$04 Write #N$00 to #R$8EE2.
  $974F,$01 Switch to the registers of the new sprite.
  $9750,$03 Fetch the number of rows of the new sprite from #R$8EE3.
  $9753,$01 Copy the number of rows to #REGc.
  $9754,$01 Set the number of rows to store to #N$00.
@ $9755 label=XORSpriteLoop_StoreNew
  $9755,$03 Store #REGa in #R$8EE3.
  $9758,$01 Switch to the registers of the old sprite.
  $9759,$02 Jump back to #R$9728 to start drawing rows.

c $975B Draw Old Entity Row
@ $975B label=DrawOldEntityRow
D $975B Draws one row of the old sprite, using XOR, and moves up to the next
. row.
.
. The row is drawn by unrolled code with one piece of #N$0C bytes for each byte
. of the row (up to nine bytes). The operand of the jump at #R$9760 is changed
. by #R$9657 so that the jump lands on the first piece that is needed. If the
. sprite is aligned to a character boundary the jump goes six bytes further in,
. which leaves out the first write.
E $975B View the equivalent code in;
. #LIST
. { #SABREWULF$BA0D }
. LIST#
R $975B B Page of the shift table
R $975B DE Pointer to the pixel data
R $975B HL Screen address of the row
R $975B C Number of rows left
R $975B O:C Number of rows left
R $975B O:DE Pointer to the next row of pixel data
R $975B O:HL Screen address of the next row
  $975B,$01 Copy the row count to #REGa.
  $975C,$01 Store the row count in #REGaf'.
  $975D,$01 Fetch the first byte of the row.
  $975E,$01 Copy it to #REGc to use as the index into the shift table.
  $975F,$01 Stash the screen address on the stack.
@ $9760 label=DrawOldEntityRow_Jump
  $9760,$02 Jump into the unrolled code. The operand of this instruction is
. changed by #R$9657.
@ $9762 label=DrawOldEntityRow_Byte_1
  $9762,$06 Byte 1 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $9768 label=DrawOldEntityRow_Byte_1_Right
  $9768,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $976E label=DrawOldEntityRow_Byte_2
  $976E,$06 Byte 2 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $9774 label=DrawOldEntityRow_Byte_2_Right
  $9774,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $977A label=DrawOldEntityRow_Byte_3
  $977A,$06 Byte 3 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $9780 label=DrawOldEntityRow_Byte_3_Right
  $9780,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $9786 label=DrawOldEntityRow_Byte_4
  $9786,$06 Byte 4 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $978C label=DrawOldEntityRow_Byte_4_Right
  $978C,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $9792 label=DrawOldEntityRow_Byte_5
  $9792,$06 Byte 5 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $9798 label=DrawOldEntityRow_Byte_5_Right
  $9798,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $979E label=DrawOldEntityRow_Byte_6
  $979E,$06 Byte 6 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $97A4 label=DrawOldEntityRow_Byte_6_Right
  $97A4,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $97AA label=DrawOldEntityRow_Byte_7
  $97AA,$06 Byte 7 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $97B0 label=DrawOldEntityRow_Byte_7_Right
  $97B0,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $97B6 label=DrawOldEntityRow_Byte_8
  $97B6,$06 Byte 8 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $97BC label=DrawOldEntityRow_Byte_8_Right
  $97BC,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $97C2 label=DrawOldEntityRow_Byte_9
  $97C2,$06 Byte 9 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $97C8 label=DrawOldEntityRow_Byte_9_Right
  $97C8,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $97CE label=DrawOldEntityRow_Byte_9_Next
  $97CE,$01 Fetch the row count from #REGaf'.
  $97CF,$01 Copy the row count to #REGc.
  $97D0,$01 Restore the screen address from the stack.
  $97D1,$01 Move up one pixel line.
  $97D2,$02 Fetch the inverse of the high byte of the address in #REGa.
  $97D4,$02,b$01 Keep only the pixel line bits (bits 0-2).
  $97D6,$01 Return if the move up stayed inside the same character cell.
  $97D7,$04 Subtract #N$20 from the low byte to move up to the previous
. character row.
  $97DB,$01 Return if the move up stayed inside the same third of the screen.
  $97DC,$04 Add #N$08 to the high byte to move up to the previous third of the
. screen.
  $97E0,$01 Return.

c $97E1 Draw New Entity Row
@ $97E1 label=DrawNewEntityRow
D $97E1 Draws one row of the new sprite, using XOR, and moves up to the next
. row. It is a copy of #R$975B that uses the jump at #R$97E6, which is changed
. by #R$9689.
E $97E1 View the equivalent code in;
. #LIST
. { #SABREWULF$BA8C }
. LIST#
R $97E1 B Page of the shift table
R $97E1 DE Pointer to the pixel data
R $97E1 HL Screen address of the row
R $97E1 C Number of rows left
R $97E1 O:C Number of rows left
R $97E1 O:DE Pointer to the next row of pixel data
R $97E1 O:HL Screen address of the next row
  $97E1,$01 Copy the row count to #REGa.
  $97E2,$01 Store the row count in #REGaf'.
  $97E3,$01 Fetch the first byte of the row.
  $97E4,$01 Copy it to #REGc to use as the index into the shift table.
  $97E5,$01 Stash the screen address on the stack.
@ $97E6 label=DrawNewEntityRow_Jump
  $97E6,$02 Jump into the unrolled code. The operand of this instruction is
. changed by #R$9689.
@ $97E8 label=DrawNewEntityRow_Byte_1
  $97E8,$06 Byte 1 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $97EE label=DrawNewEntityRow_Byte_1_Right
  $97EE,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $97F4 label=DrawNewEntityRow_Byte_2
  $97F4,$06 Byte 2 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $97FA label=DrawNewEntityRow_Byte_2_Right
  $97FA,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $9800 label=DrawNewEntityRow_Byte_3
  $9800,$06 Byte 3 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $9806 label=DrawNewEntityRow_Byte_3_Right
  $9806,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $980C label=DrawNewEntityRow_Byte_4
  $980C,$06 Byte 4 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $9812 label=DrawNewEntityRow_Byte_4_Right
  $9812,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $9818 label=DrawNewEntityRow_Byte_5
  $9818,$06 Byte 5 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $981E label=DrawNewEntityRow_Byte_5_Right
  $981E,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $9824 label=DrawNewEntityRow_Byte_6
  $9824,$06 Byte 6 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $982A label=DrawNewEntityRow_Byte_6_Right
  $982A,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $9830 label=DrawNewEntityRow_Byte_7
  $9830,$06 Byte 7 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $9836 label=DrawNewEntityRow_Byte_7_Right
  $9836,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $983C label=DrawNewEntityRow_Byte_8
  $983C,$06 Byte 8 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $9842 label=DrawNewEntityRow_Byte_8_Right
  $9842,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $9848 label=DrawNewEntityRow_Byte_9
  $9848,$06 Byte 9 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $984E label=DrawNewEntityRow_Byte_9_Right
  $984E,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $9854 label=DrawNewEntityRow_Byte_9_Next
  $9854,$01 Fetch the row count from #REGaf'.
  $9855,$01 Copy the row count to #REGc.
  $9856,$01 Restore the screen address from the stack.
  $9857,$01 Move up one pixel line.
  $9858,$02 Fetch the inverse of the high byte of the address in #REGa.
  $985A,$02,b$01 Keep only the pixel line bits (bits 0-2).
  $985C,$01 Return if the move up stayed inside the same character cell.
  $985D,$04 Subtract #N$20 from the low byte to move up to the previous
. character row.
  $9861,$01 Return if the move up stayed inside the same third of the screen.
  $9862,$04 Add #N$08 to the high byte to move up to the previous third of the
. screen.
  $9866,$01 Return.

c $9867 Colour Entity
@ $9867 label=ColourEntity
D $9867 Sets the attributes of the character cells that the sprite of the object
. covers to the attribute of the object. The width in cells and the height in
. pixels come from #R$8EE6 and #R$8EE7, which are set when the sprite is
. prepared. It works upwards from the bottom row of cells.
.
. The number of rows of cells is worked out from the number of pixel lines of
. the sprite and the position of the bottom of the sprite within its character
. cell.
E $9867 View the equivalent code in;
. #LIST
. { #SABREWULF$BB24 }
. LIST#
E $9867 Continue on to #R$9888.
R $9867 IX Object record
  $9867,$03 Fetch the x position of the object into #REGl.
  $986A,$03 Fetch the y position of the object into #REGh.
  $986D,$03 Fetch the attribute of the object into #REGd.
  $9870,$02 Copy the y position to #REGa and flip the bits.
  $9872,$02,b$01 Keep only the pixel line within the character cell.
  $9874,$01 Store it in #REGb.
  $9875,$03 Fetch the height of the sprite from #R$8EE7.
  $9878,$02 Add #N$08.
  $987A,$01 Add the pixel line.
  $987B,$03 Divide by eight.
  $987E,$02,b$01 Keep only the low five bits.
  $9880,$01 Store the number of rows of cells in #REGc.
  $9881,$03 Fetch the width of the sprite in cells from #R$8EE6.
  $9884,$01 Store it in #REGb.
  $9885,$03 Convert the position into the address in the attribute buffer.

c $9888 Colour Rows
@ $9888 label=ColourRows
D $9888 Sets the attributes of #REGc rows of #REGb character cells, working
. upwards from the attribute address in #REGhl. A row that is above the start of
. the attribute buffer is skipped.
E $9888 View the equivalent code in;
. #LIST
. { #SABREWULF$BB45 }
. LIST#
R $9888 B Number of cells in each row
R $9888 C Number of rows
R $9888 D Attribute to write
R $9888 HL Address in the attribute buffer of the bottom left cell
  $9888,$01 Stash the counters on the stack.
  $9889,$01 Stash the address on the stack.
  $988A,$03 Fetch the high byte of the address and compare it with #N$58 (the
. start of the attribute buffer).
  $988D,$02 Jump to #R$9893 if the row is above the attribute buffer.
@ $988F label=ColourRows_Loop
  $988F,$01 Write the attribute to the cell.
  $9890,$01 Move on to the next cell.
  $9891,$02 Decrease the cell counter and loop back until the row is done.
@ $9893 label=ColourRows_Next
  $9893,$01 Restore the address from the stack.
  $9894,$03 Set the size of a row of cells to #N$0020.
  $9897,$03 Move up to the row above.
  $989A,$01 Restore the counters from the stack.
  $989B,$03 Decrease the row counter and loop back until all of the rows are
. done.
  $989E,$01 Return.

c $989F Store Entity
@ $989F label=StoreEntity
D $989F Stores the position and the sprite id of the object that #REGix points
. at, so that the sprite can be found and erased later.
E $989F View the equivalent code in;
. #LIST
. { #ATICATAC$9FFB }
. { #COOKIE$76D0 }
. { #JETPAC$7327 }
. { #PSSST$75B9 }
. { #SABREWULF$BB0B }
. { #TRANZAM$71ED }
. LIST#
R $989F IX Object record
  $989F,$03 Fetch the x position of the object.
  $98A2,$03 Store it in #R$8EE4.
  $98A5,$03 Fetch the y position of the object.
  $98A8,$03 Store it in #R$8EE5.
  $98AB,$03 Fetch the type of the object (its sprite id).
  $98AE,$03 Store it in #R$8EE1.
  $98B1,$01 Return.

c $98B2 Find World Map Address
@ $98B2 label=Find_World_Map_Address
D $98B2 Works out the address in the #R$7000 world map of the entry for the room
. that the object at #REGix is in. The address is #N$7000 plus #N$20 times the
. room y plus twice the room x.
.
. The multiplication of the room y by #N$20 is done as a multiplication of the
. low three bits of the room y by #N$20, plus #N$0100 times the rest of the room
. y.
R $98B2 IX Object record
R $98B2 O:HL Address of the world map entry
  $98B2,$01 Stash #REGbc on the stack.
  $98B3,$03 Fetch the room y of the object into #REGh.
  $98B6,$01 Start the offset at zero.
  $98B7,$03 Move bit 0 of the room y into #REGa.
  $98BA,$03 Move bit 1 of the room y into #REGa.
  $98BD,$03 Move bit 2 of the room y into #REGa. (#REGa is now #N$20 times the
. low three bits.)
  $98C0,$03 Fetch the room x of the object into #REGl.
  $98C3,$01 Add the room x to #REGa.
  $98C4,$01 Add the room x to #REGa again, to make twice the room x.
  $98C5,$01 Store the low byte of the offset in #REGl.
  $98C6,$03 Point at the world map (#R$7000).
  $98C9,$01 Add the address of the world map to the offset.
  $98CA,$01 Restore #REGbc from the stack.
  $98CB,$01 Return.

c $98CC Read World Map
@ $98CC label=Read_World_Map
D $98CC Reads the world map entry of the room that the object at #REGix is in.
. The first byte of an entry is made up of eight flags that say which parts of
. the frame of the room are present (see #R$9906).
R $98CC IX Object record
R $98CC O:E First byte of the entry (the frame flags of the room)
R $98CC O:D Second byte of the entry
  $98CC,$01 Stash #REGhl on the stack.
  $98CD,$03 Find the address of the entry.
  $98D0,$01 Fetch the first byte of the entry.
  $98D1,$01 Move on to the second byte.
  $98D2,$01 Fetch the second byte of the entry.
  $98D3,$01 Restore #REGhl from the stack.
  $98D4,$01 Return.

c $98D5 Move Down Row
@ $98D5 label=MoveDownRow
D $98D5 Moves a screen address down by one character row.
E $98D5 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D64F }
. { #MARTIANOIDS$B6B2 }
. { #NIGHTSHADE$CB71 }
. LIST#
R $98D5 HL Screen address
R $98D5 O:HL Screen address of the character cell below
  $98D5,$01 Fetch the low byte of the address.
  $98D6,$02 Add #N$20 to move down one row of the character cells.
  $98D8,$01 Store the low byte of the address.
  $98D9,$01 Return if the move did not cross into the next third of the screen.
  $98DA,$01 Fetch the high byte of the address.
  $98DB,$02 Add #N$08 to move on to the next third of the screen.
  $98DD,$01 Store the high byte of the address.
  $98DE,$01 Return.

c $98DF Print Character
@ $98DF label=PrintScreen
D $98DF Draws a character at a screen address and moves on to the next cell to
. the right. The attribute is not changed.
.
. The shape of the character comes from the font at #R$EEA4, which has
. eight bytes for each code. The address is worked out as #N$ED24 plus eight
. times the code, so the glyph for code #N$30 (the digit 0) is the first one of
. the font. A space (#N$20) is replaced by code #N$3D, which is the blank
. character of the font.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$98DF }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(character-before)
. | #SIM(start=$98DF,stop=$0000,a=$53,hl=$4010,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(character-after) } UDGTABLE# #POPS
E $98DF View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #MARTIANOIDS$B5CB }
. { #NIGHTSHADE$CB19 }
. { #PSSST$73CD }
. { #SABREWULF$B589 }
. { #TRANZAM$6C96 }
. LIST#
R $98DF A Character code
R $98DF HL Screen address
R $98DF O:HL Screen address of the cell to the right
  $98DF,$01 Stash #REGaf on the stack.
  $98E0,$01 Stash #REGbc on the stack.
  $98E1,$01 Stash #REGde on the stack.
  $98E2,$01 Stash #REGhl on the stack.
  $98E3,$04 Jump to #R$98E9 if it is not a space.
  $98E7,$02 Use the code of the blank character (#N$3D) instead.
@ $98E9 label=PrintScreen_Not_Space
  $98E9,$01 Copy the character code to #REGl.
  $98EA,$02 Clear the high byte of the character code.
  $98EC,$03 Multiply the character code by eight.
  $98EF,$03 Point at the character set (less #N$0180, as the character codes
. start at #N$20).
  $98F2,$01 Add the address of the character set.
  $98F3,$01 Exchange the registers so that #REGde points at the shape of the
. character.
  $98F4,$01 Restore the screen address into #REGhl.
@ $98F5 label=PrintScreen_Write
  $98F5,$02 Set the number of pixel lines in a character to #N$08.
@ $98F7 label=PrintScreen_Loop
  $98F7,$01 Fetch a line of the character.
  $98F8,$01 Write it to the screen.
  $98F9,$01 Move on to the next line of the character.
  $98FA,$01 Move down one pixel line.
  $98FB,$02 Decrease the line counter and loop back until all eight lines are
. done.
  $98FD,$01 Restore #REGde from the stack.
  $98FE,$01 Restore #REGbc from the stack.
  $98FF,$01 Fetch the high byte of the screen address.
  $9900,$02 Subtract #N$08 to move back to the top of the cell.
  $9902,$01 Store the high byte of the address.
  $9903,$01 Move on to the next cell to the right.
  $9904,$01 Restore #REGaf from the stack.
  $9905,$01 Return.

c $9906 Draw Room
@ $9906 label=Draw_Room
D $9906 Draws the room that Sabreman is in and then carries on with the main
. loop. It does not return to its caller: it resets the stack.
.
. First the play area is cleared. Then, for the rooms in the lower part of the
. map (the room y is #N$10 or more), the eight parts of the frame of the room
. are drawn, in the order of the bits of the first byte of the world map entry
. (see #R$99F5), the objects of the room are set up and the room is marked as
. visited.
.
. The rooms with a room y below #N$10 are special rooms, which are drawn by
. #R$9DA0, and which get their decorations from #R$EAA2. A room y of #N$FF is
. the way out of the Underwurlde and shows the ending (see #R$9EA0).
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$9906 }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #SCR$01(draw-room-before)
. | #POKES$8F1C,$09;$8F1E,$12
. #SIM(start=$9906,stop=$91E5,ix=$8F1A,sp=$5B40)
. #SCR$01(draw-room-after) } UDGTABLE# #POPS
  $9906,$01 Disable interrupts.
  $9907,$03 Clear the play area.
  $990A,$06 Clear the word at #R$AA97.
  $9910,$03 Read the world map entry of the room into #REGde.
  $9913,$03 Fetch the room y of Sabreman.
  $9916,$05 Show the ending screen if the room y is #N$FF.
  $991B,$05 Jump to #R$997D if the room y is below #N$10.
N $9920 Draw the eight parts of the frame of the room. Each of the routines
. draws its part if the matching bit of #REGe is set and clears the area if it
. is not.
  $9920,$03 Draw the ceiling (bit 0).
  $9923,$03 Draw the top right corner (bit 1).
  $9926,$03 Draw the right wall (bit 2).
  $9929,$03 Draw the bottom right corner (bit 3).
  $992C,$03 Draw the floor (bit 4).
  $992F,$03 Draw the bottom left corner (bit 5).
  $9932,$03 Draw the left wall (bit 6).
  $9935,$03 Draw the top left corner (bit 7).
  $9938,$03 Set up the objects of the room (see #R$AF56).
@ $993B label=Finish_Room
N $993B Mark the room as visited and set up the rest of the room.
  $993B,$03 Find the entry of the room in the room visit table.
  $993E,$01 Fetch the first byte of the entry.
  $993F,$03 Jump to #R$9944 if the room has been visited before.
  $9942,$02 Mark the room as visited.
@ $9944 label=Draw_Room_Print_Depth
  $9944,$03 Print the depth of the room.
  $9947,$03 Flag all of the object records for redrawing.
  $994A,$03 Flag the small object records for redrawing.
  $994D,$03 Place the collectable of the room, if it has one and it has not been
. collected.
  $9950,$04 Write #N$00 to #R$AAAC.
  $9954,$03 Fetch the redraw flags of Sabreman.
  $9957,$02,b$01 Set bit 0 so that he is drawn without erasing.
  $9959,$03 Store the redraw flags of Sabreman.
  $995C,$03 Store them in the redraw flags of the rope record too.
  $995F,$03 Store them in the room redrawn flag at #R$8EF0.
  $9962,$03 Fetch the type of Sabreman.
  $9965,$04 Jump to #R$996C if the type is below #N$09.
  $9969,$03 Set up the rope of the room.
@ $996C label=Draw_Room_Reset_Stack
  $996C,$03 Reset the stack pointer to #N$6000 as this routine does not return.
  $996F,$04 Point at the object record of the rope (#R$8F2A).
  $9973,$03 Fetch the frame counter.
  $9976,$01 Subtract one.
  $9977,$03 Store it in #R$8EDF so that the priority records are handled.
  $997A,$03 Jump to #R$9207 to handle the rope record.
@ $997D label=Draw_Room_Draw_Special_Room
N $997D The room is a special room.
  $997D,$03 Draw the special room.
  $9980,$03 Point at the twelfth object record (#R$8F9A).
  $9983,$02 Set the size of four records to #N$40.
@ $9985 label=Draw_Room_Clear_Records_Loop
  $9985,$02 Write #N$00 to the byte.
  $9987,$01 Move on to the next byte.
  $9988,$02 Decrease the counter and loop back until the four records are empty.
  $998A,$03 Load the decorations of the room.
  $998D,$02 Jump to #R$993B.

c $998F Flag Objects For Redraw
@ $998F label=Flag_Objects_For_Redraw
D $998F Writes #N$01 to byte #N$0F of each of the nineteen object records, so
. that each of the sprites is drawn without being erased first (see #R$96CB).
  $998F,$03 Point at byte #N$0F of the first record (#R$8F09).
  $9992,$03 Set the size of a record to #N$0010.
  $9995,$03 Set the number of records to #N$13 and the value to flag them with
. to #N$01.
@ $9998 label=Flag_Objects_For_Redraw_Loop
  $9998,$01 Set byte #N$0F of the record.
  $9999,$01 Move on to the next record.
  $999A,$02 Decrease the counter and loop back until all of the records are
. flagged.
  $999C,$01 Return.

c $999D Flag Small Objects For Redraw
@ $999D label=Flag_Small_Objects_For_Redraw
D $999D Sets bit 0 of byte #N$07 of the first four small object records, so that
. their sprites are drawn without being erased first.
  $999D,$03 Point at byte #N$07 of the first small record (#R$9031).
  $99A0,$03 Set the size of a small record to #N$0008.
  $99A3,$02 Set the number of records to #N$04.
@ $99A5 label=Flag_Small_Objects_For_Redraw_Loop
  $99A5,$02 Set bit 0 of byte #N$07.
  $99A7,$01 Move on to the next record.
  $99A8,$02 Decrease the counter and loop back until all of the records are
. flagged.
  $99AA,$01 Return.

c $99AB Clear Play Area
@ $99AB label=Clear_Play_Area
D $99AB Clears the pixels of the #N$B0 lines of the play area and then sets the
. attributes of its #N$16 rows to white. The entry at #R$99C2 only sets
. the attributes.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$99AB }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #SCR$01(clear-play-area-before)
. | #SIM(start=$99AB,stop=$0000,sp=$5B40)
. #SCR$01(clear-play-area-after) } UDGTABLE# #POPS
  $99AB,$03 Set the x position to #N$00 and the y position to #N$BF (#N$BF00).
  $99AE,$03 Convert the position into a screen address.
  $99B1,$02 Set the number of lines to clear to #N$B0.
@ $99B3 label=Clear_Play_Area_Line_Loop
  $99B3,$01 Stash the screen address on the stack.
  $99B4,$02 Set the number of bytes in a line to #N$20.
@ $99B6 label=Clear_Play_Area_Byte_Loop
  $99B6,$02 Clear a byte of the line.
  $99B8,$01 Move on to the next byte.
  $99B9,$02 Decrease the byte counter and loop back until the line is clear.
  $99BB,$01 Restore the screen address from the stack.
  $99BC,$03 Move up one pixel line.
  $99BF,$03 Decrease the line counter and loop back until all of the lines are
. clear.
@ $99C2 label=Clear_Play_Area_Attributes
  $99C2,$03 Point at the second row of the attribute buffer (#N$5840).
  $99C5,$02 Set the number of rows to #N$16.
@ $99C7 label=Clear_Play_Area_Row_Loop
  $99C7,$02 Set the number of cells in a row to #N$20.
@ $99C9 label=Clear_Play_Area_Cell_Loop
  $99C9,$02 Set the attribute of the cell to white ink on black paper (bright).
  $99CB,$01 Move on to the next cell.
  $99CC,$02 Decrease the cell counter and loop back until the row is done.
  $99CE,$03 Decrease the row counter and loop back until all of the rows are
. done.
  $99D1,$01 Return.

c $99D2 Clear Panel
@ $99D2 label=Clear_Panel
D $99D2 Clears a rectangle of the screen to the right of the position in #REGhl.
. There are three entry points, which select the size of the rectangle. They
. stand in for the parts of the frame of the room (see #R$9906) that are not
. present.
.
. Each of those routines stashed #REGde on the stack, so this routine ends by
. restoring it. The caller is returned to by the last instruction.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$99D2 }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #SCR$01,$00,$02,$20,$14(clear-panel-before)
. | #SIM(start=$99D7,stop=$0000,hl=$3090,sp=$5B40)
. #SCR$01,$00,$02,$20,$14(clear-panel-after) } UDGTABLE# #POPS
R $99D2 HL Position (#REGl is the x position, #REGh is the y position)
  $99D2,$03 Set the size of the area to #N$03 bytes wide and #N$04 lines high
. (#N$0304).
  $99D5,$02 Jump to #R$99DF.
@ $99D7 label=Clear_Tall_Panel
  $99D7,$03 Set the size of the area to #N$03 bytes wide and #N$70 lines high
. (#N$0370).
  $99DA,$02 Jump to #R$99DF.
@ $99DC label=Clear_Wide_Panel
  $99DC,$03 Set the size of the area to #N$1A bytes wide and #N$20 lines high
. (#N$1A20).
@ $99DF label=Clear_Panel_Rectangle
  $99DF,$03 Convert the position into a screen address.
  $99E2,$02 Set the byte to write to #N$00.
  $99E4,$01 Keep the width of the rectangle for the next line.
@ $99E5 label=Clear_Panel_Loop
  $99E5,$01 Clear a byte of the line.
  $99E6,$01 Move on to the next byte.
  $99E7,$02 Decrease the width counter and loop back until the line is clear.
  $99E9,$01 Fetch the width of the rectangle again.
  $99EA,$01 Fetch the low byte of the screen address.
  $99EB,$01 Subtract the width to move back to the start of the line.
  $99EC,$01 Store the low byte of the address.
  $99ED,$03 Move down one pixel line.
  $99F0,$03 Decrease the line counter and loop back until all of the lines are
. clear.
  $99F3,$01 Restore #REGde from the stack.
  $99F4,$01 Return.

c $99F5 Draw Ceiling
@ $99F5 label=Draw_Ceiling
D $99F5 Draws the ceiling of the room if bit 0 of the frame flags is set, or
. clears its area if it is not.
.
. The ceiling is made of thirteen tiles of two bytes by #N$20 lines, which are
. drawn from left to right starting at x position #N$18 and y position #N$10.
. Each tile is chosen from the table at #R$9A33. The first tile that is used
. depends on the sum of the room x and the room y, which makes the ceiling look
. different from room to room, and the next tiles come from the following
. entries of the table.
.
. Finally the attributes of the area are set (see #R$9C10). The floor, drawn by
. #R$9B38, uses this code too.
R $99F5 DE Frame flags of the room in #REGe
R $99F5 IX Object record of Sabreman
  $99F5,$01 Stash the frame flags on the stack.
  $99F6,$02 Test bit 0 of the frame flags (the ceiling).
  $99F8,$03 Set the x position to #N$18 and the y position to #N$10 (#N$1018).
  $99FB,$03 Point at the table of ceiling tiles (#R$9A33).
@ $99FE label=Draw_Ceiling_Check_Present
  $99FE,$03 Jump to #R$99DC if there is no ceiling.
@ $9A01 label=Draw_Row_Of_Tiles
N $9A01 Draw the row of tiles. The same code draws the floor, which jumps to
. #R$99FE.
  $9A01,$02 Set the number of tiles to #N$0D.
  $9A03,$01 Stash the screen position on the stack.
  $9A04,$03 Convert the position into a screen address.
  $9A07,$03 Fetch the room x of Sabreman.
  $9A0A,$03 Add the room y of Sabreman.
  $9A0D,$01 Double the sum to make an offset into the table of word pointers.
@ $9A0E label=Draw_Ceiling_Tile_Loop
  $9A0E,$02,b$01 Keep the offset within the table (sixteen entries).
  $9A10,$01 Store the offset in #REGc.
  $9A11,$01 Stash the tile counter and the offset on the stack.
  $9A12,$01 Exchange the registers so that #REGhl holds the address of the
. table.
  $9A13,$01 Stash the address of the table on the stack.
  $9A14,$02 Clear the high byte of the offset.
  $9A16,$01 Add the offset to the address of the table.
  $9A17,$01 Fetch the low byte of the address of the tile.
  $9A18,$01 Move on to the high byte.
  $9A19,$01 Fetch the high byte of the address of the tile.
  $9A1A,$01 Copy the low byte to #REGl.
  $9A1B,$01 Exchange the registers so that #REGde holds the address of the tile
. and #REGhl the screen address.
  $9A1C,$01 Stash the screen address on the stack.
  $9A1D,$03 Draw the tile.
  $9A20,$01 Restore the screen address from the stack.
  $9A21,$02 Move on two cells to the right.
  $9A23,$01 Restore the address of the table into #REGde.
  $9A24,$01 Restore the tile counter and the offset.
  $9A25,$01 Copy the offset to #REGa.
  $9A26,$02 Move on to the next entry of the table.
  $9A28,$02 Decrease the tile counter and loop back until all of the tiles are
. drawn.
  $9A2A,$01 Restore the position of the area.
  $9A2B,$03 Set the size of the area to #N$1A20.
  $9A2E,$03 Set the attributes of the area.
  $9A31,$01 Restore the frame flags from the stack.
  $9A32,$01 Return.

w $9A33 Ceiling Tile Table
@ $9A33 label=Ceiling_Tile_Table
D $9A33 The addresses of the tiles of the ceiling, indexed by twice the sum of
. the room x and the room y. The eight tiles in the first half are repeated in
. the second half. Each tile is two bytes wide and #N$20 lines high, and is
. preceded by its height and width (see #R$9BF8).
W $9A33,$20,$10

c $9A53 Draw Top Right Corner
@ $9A53 label=Draw_Top_Right_Corner
D $9A53 Draws the top right corner of the frame of the room if bit 1 of the
. frame flags is set, or clears its area if it is not.
.
. The corner is three bytes wide and #N$20 lines high and is drawn at x position
. #N$E8, y position #N$10. The shape depends on whether the ceiling (bit 0) and
. the right wall (bit 2) are present, and on the room x and y: the table at
. #R$9A96 has a set of four shapes for each of four combinations of the room
. coordinates. The routine also draws the other corners, which jump to
. #R$9A70.
R $9A53 DE Frame flags of the room in #REGe
R $9A53 IX Object record of Sabreman
  $9A53,$01 Stash the frame flags on the stack.
  $9A54,$03 Set the x position to #N$E8 and the y position to #N$10 (#N$10E8).
  $9A57,$01 Copy the frame flags to #REGa.
  $9A58,$03 Point at the table of corner shapes (#R$9A96).
  $9A5B,$04 Jump to #R$9A62 to clear the area if the corner is not present.
@ $9A60 label=Draw_Corner
  $9A60,$01 Stash the position on the stack.
  $9A61,$01 Exchange the registers so that #REGhl holds the address of the
. table.
  $9A62,$04 Jump to #R$9A68 if the ceiling is not present.
  $9A66,$02 Skip the shapes for a ceiling.
@ $9A68 label=Draw_Top_Right_Corner_Check_Right_Wall
  $9A68,$04 Jump to #R$9A70 if the right wall is not present.
  $9A6C,$04 Skip the shapes for a right wall.
@ $9A70 label=Draw_Corner_Shape
  $9A70,$03 Fetch the room x of Sabreman.
  $9A73,$03 Add the room y of Sabreman.
  $9A76,$03 Multiply the sum by eight.
  $9A79,$02,b$01 Keep only bits 3 and 4.
  $9A7B,$01 Store the offset in #REGc.
  $9A7C,$02 Clear the high byte of the offset.
  $9A7E,$01 Add the offset to the address in the table.
  $9A7F,$01 Fetch the low byte of the address of the shape.
  $9A80,$01 Move on to the high byte.
  $9A81,$01 Fetch the high byte of the address of the shape.
  $9A82,$01 Copy the low byte to #REGl.
  $9A83,$01 Exchange the registers so that #REGde holds the address of the
. shape.
  $9A84,$03 Set the size of the area to three bytes wide, #N$20 lines high
. (#N$0320).
  $9A87,$03 Convert the position into a screen address.
  $9A8A,$03 Draw the shape.
  $9A8D,$01 Restore the position from the stack.
  $9A8E,$03 Set the size of the area to #N$0320.
  $9A91,$03 Set the attributes of the area.
  $9A94,$01 Restore the frame flags from the stack.
  $9A95,$01 Return.

w $9A96 Top Right Corner Table
@ $9A96 label=Top_Right_Corner_Table
D $9A96 The addresses of the shapes of the top right corner. Each shape is three
. bytes wide and #N$20 lines high and has no header. There are four sets of four
. shapes, one set for each value of the sum of the room x and the room y (modulo
. four). Within a set the shapes are for: no ceiling and no right wall, ceiling
. only, right wall only, and both.
W $9A96,$20,$10

c $9AB6 Draw Right Wall
@ $9AB6 label=Draw_Right_Wall
D $9AB6 Draws the right wall of the room if bit 2 of the frame flags is set, or
. clears its area if it is not.
.
. The wall is made of two tiles, each three bytes wide and #N$38 lines high,
. which are drawn from top to bottom at x position #N$E8 and y position #N$30.
. The tiles come from the table at #R$9BB0, indexed by the sum of the room x and
. the room y. The routine is also used to draw the left wall (see #R$9BA4).
R $9AB6 DE Frame flags of the room in #REGe
R $9AB6 IX Object record of Sabreman
  $9AB6,$01 Stash the frame flags on the stack.
  $9AB7,$02 Test bit 2 of the frame flags (the right wall).
  $9AB9,$03 Set the x position to #N$E8 and the y position to #N$30 (#N$30E8).
  $9ABC,$03 Point at the table of wall tiles (#R$9BB0).
@ $9ABF label=Draw_Right_Wall_Check_Present
  $9ABF,$03 Jump to #R$99D7 if the wall is not present.
@ $9AC2 label=Draw_Wall_Tiles
  $9AC2,$02 Set the number of tiles to #N$02.
  $9AC4,$01 Stash the position on the stack.
  $9AC5,$03 Convert the position into a screen address.
  $9AC8,$03 Fetch the room x of Sabreman.
  $9ACB,$03 Add the room y of Sabreman.
  $9ACE,$01 Double the sum to make an offset into the table of word pointers.
@ $9ACF label=Draw_Right_Wall_Tile_Loop
  $9ACF,$02,b$01 Keep the offset within the table (four entries).
  $9AD1,$01 Store the offset in #REGc.
  $9AD2,$01 Stash the tile counter and the offset on the stack.
  $9AD3,$01 Exchange the registers so that #REGhl holds the address of the
. table.
  $9AD4,$01 Stash the address of the table on the stack.
  $9AD5,$02 Clear the high byte of the offset.
  $9AD7,$01 Add the offset to the address of the table.
  $9AD8,$01 Fetch the low byte of the address of the tile.
  $9AD9,$01 Move on to the high byte.
  $9ADA,$01 Fetch the high byte of the address of the tile.
  $9ADB,$01 Copy the low byte to #REGl.
  $9ADC,$01 Exchange the registers so that #REGde holds the address of the tile
. and #REGhl the screen address.
  $9ADD,$03 Draw the tile.
  $9AE0,$01 Restore the address of the table into #REGde.
  $9AE1,$01 Restore the tile counter and the offset.
  $9AE2,$01 Copy the offset to #REGa.
  $9AE3,$02 Move on to the next entry of the table.
  $9AE5,$02 Decrease the tile counter and loop back until both tiles are drawn.
  $9AE7,$01 Restore the position of the area.
  $9AE8,$03 Set the size of the area to #N$0370.
  $9AEB,$03 Set the attributes of the area.
  $9AEE,$01 Restore the frame flags from the stack.
  $9AEF,$01 Return.

w $9AF0 Left Wall Tile Table
@ $9AF0 label=Left_Wall_Tile_Table
D $9AF0 The addresses of the tiles of the left wall, indexed by twice the sum of
. the room x and the room y. Each tile is three bytes wide and #N$38 lines high,
. and is preceded by its height and width (see #R$9BF8).
W $9AF0,$08,$08

c $9AF8 Draw Bottom Right Corner
@ $9AF8 label=Draw_Bottom_Right_Corner
D $9AF8 Draws the bottom right corner of the frame of the room if bit 3 of the
. frame flags is set, or clears its area if it is not.
.
. The corner is drawn at x position #N$E8, y position #N$A0 by #R$9A70.
. Its shape depends on whether the floor (bit 4) and the right wall (bit 2) are
. present.
R $9AF8 DE Frame flags of the room in #REGe
R $9AF8 IX Object record of Sabreman
  $9AF8,$01 Stash the frame flags on the stack.
  $9AF9,$03 Set the x position to #N$E8 and the y position to #N$A0 (#N$A0E8).
  $9AFC,$01 Copy the frame flags to #REGa.
  $9AFD,$03 Point at the table of corner shapes (#R$9B18).
  $9B00,$04 Jump to #R$9B07 to clear the area if the corner is not present.
  $9B05,$01 Stash the position on the stack.
  $9B06,$01 Exchange the registers so that #REGhl holds the address of the
. table.
  $9B07,$04 Jump to #R$9B0D if the floor is not present.
  $9B0B,$02 Skip the shapes for a floor.
@ $9B0D label=Draw_Bottom_Right_Corner_Check_Right_Wall
  $9B0D,$04 Jump to #R$9B15 if the right wall is not present.
  $9B11,$04 Skip the shapes for a right wall.
@ $9B15 label=Draw_Bottom_Right_Corner_Draw_Shape
  $9B15,$03 Jump to #R$9A70 to draw the shape.

w $9B18 Bottom Right Corner Table
@ $9B18 label=Bottom_Right_Corner_Table
D $9B18 The addresses of the shapes of the bottom right corner, arranged in the
. same way as the table at #R$9A96. Each shape is three bytes wide and #N$20
. lines high and has no header.
W $9B18,$20,$10

c $9B38 Draw Floor
@ $9B38 label=Draw_Floor
D $9B38 Draws the floor of the room if bit 4 of the frame flags is set, or
. clears its area if it is not.
.
. The floor is drawn at x position #N$18 and y position #N$A0 by the code that
. draws the ceiling (see #R$99F5), using the tiles of the table at #R$9B44.
R $9B38 DE Frame flags of the room in #REGe
R $9B38 IX Object record of Sabreman
  $9B38,$01 Stash the frame flags on the stack.
  $9B39,$02 Test bit 4 of the frame flags (the floor).
  $9B3B,$03 Set the x position to #N$18 and the y position to #N$A0 (#N$A018).
  $9B3E,$03 Point at the table of floor tiles (#R$9B44).
  $9B41,$03 Jump to #R$99FE to draw the floor.

w $9B44 Floor Tile Table
@ $9B44 label=Floor_Tile_Table
D $9B44 The addresses of the tiles of the floor, indexed by twice the sum of the
. room x and the room y. The eight tiles in the first half are repeated in the
. second half. Each tile is two bytes wide and #N$20 lines high, and is preceded
. by its height and width (see #R$9BF8).
W $9B44,$20,$10

c $9B64 Draw Bottom Left Corner
@ $9B64 label=Draw_Bottom_Left_Corner
D $9B64 Draws the bottom left corner of the frame of the room if bit 5 of the
. frame flags is set, or clears its area if it is not.
.
. The corner is drawn at x position #N$00, y position #N$A0 by #R$9A70.
. Its shape depends on whether the floor (bit 4) and the left wall (bit 6) are
. present.
R $9B64 DE Frame flags of the room in #REGe
R $9B64 IX Object record of Sabreman
  $9B64,$01 Stash the frame flags on the stack.
  $9B65,$03 Set the x position to #N$00 and the y position to #N$A0 (#N$A000).
  $9B68,$01 Copy the frame flags to #REGa.
  $9B69,$03 Point at the table of corner shapes (#R$9B84).
  $9B6C,$04 Jump to #R$9B73 to clear the area if the corner is not present.
  $9B71,$01 Stash the position on the stack.
  $9B72,$01 Exchange the registers so that #REGhl holds the address of the
. table.
  $9B73,$04 Jump to #R$9B79 if the floor is not present.
  $9B77,$02 Skip the shapes for a floor.
@ $9B79 label=Draw_Bottom_Left_Corner_Check_Left_Wall
  $9B79,$04 Jump to #R$9B81 if the left wall is not present.
  $9B7D,$04 Skip the shapes for a left wall.
@ $9B81 label=Draw_Bottom_Left_Corner_Draw_Shape
  $9B81,$03 Jump to #R$9A70 to draw the shape.

w $9B84 Bottom Left Corner Table
@ $9B84 label=Bottom_Left_Corner_Table
D $9B84 The addresses of the shapes of the bottom left corner, arranged in the
. same way as the table at #R$9A96. Each shape is three bytes wide and #N$20
. lines high and has no header.
W $9B84,$20,$10

c $9BA4 Draw Left Wall
@ $9BA4 label=Draw_Left_Wall
D $9BA4 Draws the left wall of the room if bit 6 of the frame flags is set, or
. clears its area if it is not.
.
. The wall is drawn at x position #N$00 and y position #N$30 by
. #R$9ABF, using the tiles of the table at #R$9AF0.
R $9BA4 DE Frame flags of the room in #REGe
R $9BA4 IX Object record of Sabreman
  $9BA4,$01 Stash the frame flags on the stack.
  $9BA5,$02 Test bit 6 of the frame flags (the left wall).
  $9BA7,$03 Set the x position to #N$00 and the y position to #N$30 (#N$3000).
  $9BAA,$03 Point at the table of wall tiles (#R$9AF0).
  $9BAD,$03 Jump to #R$9ABF to draw the left wall.

w $9BB0 Right Wall Tile Table
@ $9BB0 label=Right_Wall_Tile_Table
D $9BB0 The addresses of the tiles of the right wall, indexed by twice the sum
. of the room x and the room y. Each tile is three bytes wide and #N$38 lines
. high, and is preceded by its height and width (see #R$9BF8).
W $9BB0,$08,$08

c $9BB8 Draw Top Left Corner
@ $9BB8 label=Draw_Top_Left_Corner
D $9BB8 Draws the top left corner of the frame of the room if bit 7 of the frame
. flags is set, or clears its area if it is not.
.
. The corner is drawn at x position #N$00, y position #N$10 by #R$9A70.
. Its shape depends on whether the ceiling (bit 0) and the left wall (bit 6) are
. present.
R $9BB8 DE Frame flags of the room in #REGe
R $9BB8 IX Object record of Sabreman
  $9BB8,$01 Stash the frame flags on the stack.
  $9BB9,$03 Set the x position to #N$00 and the y position to #N$10 (#N$1000).
  $9BBC,$01 Copy the frame flags to #REGa.
  $9BBD,$03 Point at the table of corner shapes (#R$9BD8).
  $9BC0,$04 Jump to #R$9BC7 to clear the area if the corner is not present.
  $9BC5,$01 Stash the position on the stack.
  $9BC6,$01 Exchange the registers so that #REGhl holds the address of the
. table.
  $9BC7,$04 Jump to #R$9BCD if the ceiling is not present.
  $9BCB,$02 Skip the shapes for a ceiling.
@ $9BCD label=Draw_Top_Left_Corner_Check_Left_Wall
  $9BCD,$04 Jump to #R$9BD5 if the left wall is not present.
  $9BD1,$04 Skip the shapes for a left wall.
@ $9BD5 label=Draw_Top_Left_Corner_Draw_Shape
  $9BD5,$03 Jump to #R$9A70 to draw the shape.

w $9BD8 Top Left Corner Table
@ $9BD8 label=Top_Left_Corner_Table
D $9BD8 The addresses of the shapes of the top left corner, arranged in the same
. way as the table at #R$9A96. Each shape is three bytes wide and #N$20 lines
. high and has no header.
W $9BD8,$20,$10

c $9BF8 Draw Tile
@ $9BF8 label=Draw_Tile
D $9BF8 Draws a tile that starts with its height and width, at the screen
. address in #REGhl. The entry at #R$9BFE draws a tile that has no
. header, using the size in #REGbc.
.
. The pixel data is drawn from left to right and from top to bottom, one row at
. a time, moving down one pixel line for each row. When it returns #REGhl is the
. screen address of the line below the tile.
R $9BF8 DE Address of the tile (height, width, then pixel data)
R $9BF8 HL Screen address of the top left corner
R $9BF8 O:DE Address of the byte after the tile
R $9BF8 O:HL Screen address of the line below the tile
  $9BF8,$03 Fetch the height of the tile as the row counter.
  $9BFB,$03 Fetch the width of the tile as the width counter.
@ $9BFE label=Draw_Tile_Without_Header
  $9BFE,$01 Stash the width of the tile on the stack.
@ $9BFF label=Draw_Tile_Loop
  $9BFF,$01 Fetch a byte of the tile.
  $9C00,$01 Move on to the next byte.
  $9C01,$01 Write it to the screen.
  $9C02,$01 Move on to the next cell.
  $9C03,$02 Decrease the width counter and loop back until the row is done.
  $9C05,$01 Restore the width of the tile.
  $9C06,$01 Fetch the low byte of the screen address.
  $9C07,$01 Subtract the width to move back to the start of the row.
  $9C08,$01 Store the low byte of the address.
  $9C09,$03 Move down one pixel line.
  $9C0C,$03 Decrease the row counter and loop back until all of the rows of the
. tile are drawn.
  $9C0F,$01 Return.

c $9C10 Set Area Attributes
@ $9C10 label=Set_Area_Attributes
D $9C10 Sets the attributes of a rectangle of character cells to yellow ink on
. black paper (bright). The rectangle is given in pixels.
R $9C10 BC Size (#REGb is the width in cells, #REGc is the height in pixels)
R $9C10 HL Position (#REGl is the x position, #REGh is the y position)
  $9C10,$02 Set the attribute to #N$46.
  $9C12,$03 Convert the position into an address in the attribute buffer.
  $9C15,$06 Divide the height by eight to get the number of rows of cells.
@ $9C1B label=Set_Area_Attributes_Row_Loop
  $9C1B,$01 Stash the counters on the stack.
  $9C1C,$01 Stash the address on the stack.
@ $9C1D label=Set_Area_Attributes_Cell_Loop
  $9C1D,$01 Set the attribute of the cell.
  $9C1E,$01 Move on to the next cell.
  $9C1F,$02 Decrease the width counter and loop back until the row is done.
  $9C21,$01 Restore the address from the stack.
  $9C22,$03 Set the size of a row of cells to #N$0020.
  $9C25,$01 Move down to the next row of cells.
  $9C26,$01 Restore the counters from the stack.
  $9C27,$03 Decrease the row counter and loop back until all of the rows of
. cells are done.
  $9C2A,$01 Return.

c $9C2B Screen Address One Pixel Below
@ $9C2B label=ScreenPosition1PixelBelow
D $9C2B Moves a screen address down by one pixel line.
E $9C2B View the equivalent code in;
. #LIST
. { #ATICATAC$9BC1 }
. { #MARTIANOIDS$BD3A }
. { #SABREWULF$B8CC }
. LIST#
R $9C2B HL Screen address
R $9C2B O:HL Screen address of the next line down
  $9C2B,$01 Move down a line within the character.
  $9C2C,$01 Fetch the high byte of the screen address.
  $9C2D,$02 Keep only the line number.
  $9C2F,$01 Return unless the character boundary has been crossed.
  $9C30,$01 Fetch the low byte of the screen address.
  $9C31,$02 Move on to the next character row.
  $9C33,$01 Store the low byte of the screen address.
  $9C34,$02 Keep only the row bits.
  $9C36,$01 Return if the third of the screen has not been crossed.
  $9C37,$01 Copy #REGh to #REGa.
  $9C38,$02 Go back up to the first line of the character.
  $9C3A,$01 Store the high byte of the screen address.
  $9C3B,$01 Return.

c $9C3C Print Colour String
@ $9C3C label=PrintStringColour
D $9C3C Prints a string whose first byte is the attribute for every
. character. The last character of the string has bit 7 set. Entering at
. #N$9C48 prints the characters with the attribute that is already in
. #REGaf'.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$9C3C }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$9078,stop=$9110,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(colour-string-before)
. | #SIM(start=$9C3C,stop=$0000,hl=$0010,de=$9195,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(colour-string-after) } UDGTABLE# #POPS
E $9C3C View the equivalent code in;
. #LIST
. { #ATICATAC$A1F3 }
. { #COOKIE$7488 }
. { #JETPAC$716C }
. { #LUNARJETMAN$8A11 }
. { #PSSST$73ED }
. { #SABREWULF$B53D }
. { #TRANZAM$6518 }
. LIST#
R $9C3C HL Position (#REGl is the x position, #REGh is the y position)
R $9C3C DE Pointer to the string
  $9C3C,$01 Stash the position on the stack.
  $9C3D,$03 Convert the position into a screen address.
  $9C40,$01 Fetch the attribute from the start of the string.
  $9C41,$01 Keep it as the attribute of every character of the string (in
. #REGaf').
  $9C42,$01 Move on to the first character.
  $9C43,$01 Switch to the shadow registers.
  $9C44,$01 Restore the position from the stack.
  $9C45,$03 Convert the position into an attribute buffer address.
@ $9C48 label=PrintString_Loop
  $9C48,$01 Switch to the shadow registers.
  $9C49,$01 Fetch a character.
  $9C4A,$04 Jump to #R$9C59 if this is the last character of the string (bit 7
. is set).
  $9C4E,$03 Print the character.
  $9C51,$01 Move on to the next character.
  $9C52,$01 Switch to the shadow registers.
  $9C53,$01 Fetch the attribute from #REGaf'.
  $9C54,$01 Write it to the attribute buffer.
  $9C55,$01 Move on to the next cell.
  $9C56,$01 Store the attribute in #REGaf' again.
  $9C57,$02 Jump back to #R$9C48.
@ $9C59 label=PrintString_LastCharacter
  $9C59,$02 Clear bit 7 of the last character.
  $9C5B,$03 Print the character.
  $9C5E,$01 Switch to the shadow registers.
  $9C5F,$01 Fetch the attribute from #REGaf'.
  $9C60,$01 Write it to the attribute buffer.
  $9C61,$01 Return.

c $9C62 Reset Room Table
@ $9C62 label=Reset_Room_Table
D $9C62 Writes #N$00 to #N$07FF bytes starting at #R$6000, which empties the
. room visit table.
  $9C62,$03 Point at the start of the room visit table (#R$6000).
  $9C65,$03 #REGde=#N$6001 (the second byte of the table, which is the
. destination of the copy).
  $9C68,$03 Set the byte count to #N$07FF.
  $9C6B,$02 Write #N$00 to the first byte.
  $9C6D,$02 Copy the byte through the rest of the area.
  $9C6F,$01 Return.

c $9C70 Draw Ceiling Picture
@ $9C70 label=Draw_Ceiling_Picture
D $9C70 Draws the picture of the ceiling of a special room, at x position #N$18
. and y position #N$10. The picture is #N$1A bytes wide and #N$20 lines high
. (see #R$7D27).
.
. The attributes of the picture are bright red (#N$42). The shared code from
. #R$9C78 onwards also draws the floor (see #R$9CA7).
  $9C70,$03 Set the x position to #N$18 and the y position to #N$10 (#N$1018).
  $9C73,$03 Point at the picture (#N$7D27).
  $9C76,$02 Set the attribute of the picture to #N$42.
@ $9C78 label=Draw_Wide_Picture
N $9C78 Fill in the attributes of the picture, four rows of #N$1A cells.
  $9C78,$01 Stash the position on the stack.
  $9C79,$01 Stash the address of the picture on the stack.
  $9C7A,$03 Convert the position into an attribute buffer address.
  $9C7D,$03 Set the size of a row of cells to #N$0020.
  $9C80,$01 Copy the attribute to #REGa.
  $9C81,$02 Set the number of rows to #N$04.
@ $9C83 label=Draw_Ceiling_Picture_Row_Loop
  $9C83,$01 Stash the address of the start of the row on the stack.
  $9C84,$02 Set the number of cells in a row to #N$1A.
@ $9C86 label=Draw_Ceiling_Picture_Cell_Loop
  $9C86,$01 Write the attribute to the cell.
  $9C87,$01 Move on to the next cell.
  $9C88,$02 Decrease the cell counter and loop back until the row is filled.
  $9C8A,$01 Restore the address of the start of the row.
  $9C8B,$01 Move down to the next row.
  $9C8C,$03 Decrease the row counter and loop back until all of the rows of
. attributes are filled.
N $9C8F Copy the pixels of the picture, #N$20 lines of #N$1A bytes.
  $9C8F,$01 Restore the address of the picture from the stack.
  $9C90,$01 Restore the position from the stack.
  $9C91,$03 Convert the position into a screen address.
  $9C94,$02 Set the number of lines to #N$20.
@ $9C96 label=Draw_Ceiling_Picture_Line_Loop
  $9C96,$01 Stash the screen address of the start of the line on the stack.
  $9C97,$02 Set the number of bytes in a line to #N$1A.
@ $9C99 label=Draw_Ceiling_Picture_Byte_Loop
  $9C99,$01 Fetch a byte of the picture.
  $9C9A,$01 Write it to the screen.
  $9C9B,$01 Move on to the next byte of the picture.
  $9C9C,$01 Move on to the next screen address.
  $9C9D,$02 Decrease the byte counter and loop back until the line is drawn.
  $9C9F,$01 Restore the screen address of the start of the line.
  $9CA0,$03 Move down a line.
  $9CA3,$03 Decrease the line counter and loop back until all of the lines of
. the picture are drawn.
  $9CA6,$01 Return.

c $9CA7 Draw Floor Picture
@ $9CA7 label=Draw_Floor_Picture
D $9CA7 Draws the picture of the floor of a special room, at x position #N$18
. and y position #N$A0. The picture is #N$1A bytes wide and #N$20 lines high
. (see #R$78A3).
.
. The attributes of the picture are bright magenta (#N$4B). The picture is drawn
. by #R$9C78.
  $9CA7,$03 Set the x position to #N$18 and the y position to #N$A0 (#N$A018).
  $9CAA,$03 Point at the picture (#N$78A3).
  $9CAD,$02 Set the attribute of the picture to #N$4B.
  $9CAF,$02 Jump to #R$9C78 to draw the picture.

c $9CB1 Draw Left Wall Picture
@ $9CB1 label=Draw_Left_Wall_Picture
D $9CB1 Draws the picture of the left wall of a special room, at x position
. #N$00 and y position #N$30. The picture is three bytes wide and #N$70 lines
. high (see #R$8367).
.
. The attributes of the picture are bright cyan (#N$4D). The shared code from
. #R$9CB9 onwards also draws the right wall (see #R$9CE8).
  $9CB1,$03 Set the x position to #N$00 and the y position to #N$30 (#N$3000).
  $9CB4,$03 Point at the picture (#N$8367).
  $9CB7,$02 Set the attribute of the picture to #N$4D.
@ $9CB9 label=Draw_Wall_Picture
N $9CB9 Fill in the attributes of the picture, #N$0E rows of three cells.
  $9CB9,$01 Stash the position on the stack.
  $9CBA,$01 Stash the address of the picture on the stack.
  $9CBB,$03 Convert the position into an attribute buffer address.
  $9CBE,$03 Set the size of a row of cells to #N$0020.
  $9CC1,$01 Copy the attribute to #REGa.
  $9CC2,$02 Set the number of rows to #N$0E.
@ $9CC4 label=Draw_Left_Wall_Picture_Row_Loop
  $9CC4,$01 Stash the address of the start of the row on the stack.
  $9CC5,$02 Set the number of cells in a row to #N$03.
@ $9CC7 label=Draw_Left_Wall_Picture_Cell_Loop
  $9CC7,$01 Write the attribute to the cell.
  $9CC8,$01 Move on to the next cell.
  $9CC9,$02 Decrease the cell counter and loop back until the row is filled.
  $9CCB,$01 Restore the address of the start of the row.
  $9CCC,$01 Move down to the next row.
  $9CCD,$03 Decrease the row counter and loop back until all of the rows of
. attributes are filled.
N $9CD0 Copy the pixels of the picture, #N$70 lines of three bytes.
  $9CD0,$01 Restore the address of the picture from the stack.
  $9CD1,$01 Restore the position from the stack.
  $9CD2,$03 Convert the position into a screen address.
  $9CD5,$02 Set the number of lines to #N$70.
@ $9CD7 label=Draw_Three_Byte_Lines
  $9CD7,$01 Stash the screen address of the start of the line on the stack.
  $9CD8,$02 Set the number of bytes in a line to #N$03.
@ $9CDA label=Draw_Left_Wall_Picture_Byte_Loop
  $9CDA,$01 Fetch a byte of the picture.
  $9CDB,$01 Write it to the screen.
  $9CDC,$01 Move on to the next byte of the picture.
  $9CDD,$01 Move on to the next screen address.
  $9CDE,$02 Decrease the byte counter and loop back until the line is drawn.
  $9CE0,$01 Restore the screen address of the start of the line.
  $9CE1,$03 Move down a line.
  $9CE4,$03 Decrease the line counter and loop back until all of the lines of
. the picture are drawn.
  $9CE7,$01 Return.

c $9CE8 Draw Right Wall Picture
@ $9CE8 label=Draw_Right_Wall_Picture
D $9CE8 Draws the picture of the right wall of a special room, at x position
. #N$E8 and y position #N$30. The picture is three bytes wide and #N$70 lines
. high (see #R$8217).
.
. The attributes of the picture are bright cyan (#N$4D). The picture is drawn by
. #R$9CB9.
  $9CE8,$03 Set the x position to #N$E8 and the y position to #N$30 (#N$30E8).
  $9CEB,$03 Point at the picture (#N$8217).
  $9CEE,$02 Set the attribute of the picture to #N$4D.
  $9CF0,$02 Jump to #R$9CB9 to draw the picture.

c $9CF2 Draw Top Left Corner Picture
@ $9CF2 label=Draw_Top_Left_Corner_Picture
D $9CF2 Draws a picture of a corner of the frame of a special room at x position
. #N$00 and y position #N$10, which is the top left corner. The picture is three
. bytes wide and #N$20 lines high, and starts with its attributes (see #R$7687).
.
. The entries at #R$9D19, #R$9D1E and #R$9D23 draw the other three corners,
. using the shared code from #R$9CF5 onwards.
R $9CF2 DE Address of the picture
  $9CF2,$03 Set the x position to #N$00 and the y position to #N$10 (#N$1000).
@ $9CF5 label=Draw_Corner_Picture
N $9CF5 Copy the attributes of the picture, four rows of three cells.
  $9CF5,$01 Stash the position on the stack.
  $9CF6,$03 Convert the position into an attribute buffer address.
  $9CF9,$02 Set the number of rows to #N$04.
@ $9CFB label=Draw_Top_Left_Corner_Picture_Row_Loop
  $9CFB,$01 Stash the address of the start of the row on the stack.
  $9CFC,$02 Set the number of cells in a row to #N$03.
@ $9CFE label=Draw_Top_Left_Corner_Picture_Cell_Loop
  $9CFE,$01 Fetch an attribute from the picture.
  $9CFF,$01 Write it to the cell.
  $9D00,$01 Move on to the next attribute of the picture.
  $9D01,$01 Move on to the next cell.
  $9D02,$02 Decrease the cell counter and loop back until the row is copied.
  $9D04,$01 Restore the address of the start of the row.
  $9D05,$01 Fetch the low byte of the address.
  $9D06,$02 Add the size of a row of cells.
  $9D08,$01 Store the low byte of the address.
  $9D09,$01 Fetch the high byte of the address.
  $9D0A,$02 Add the carry.
  $9D0C,$01 Store the high byte of the address.
  $9D0D,$03 Decrease the row counter and loop back until all of the rows of
. attributes are copied.
  $9D10,$01 Restore the position from the stack.
  $9D11,$03 Convert the position into a screen address.
  $9D14,$02 Set the number of lines to #N$20.
  $9D16,$03 Jump to #R$9CD7 to copy the pixels.

c $9D19 Draw Top Right Corner Picture
@ $9D19 label=Draw_Top_Right_Corner_Picture
D $9D19 Draws a picture of the top right corner of the frame of a special room,
. at x position #N$E8 and y position #N$10 (see #R$9CF2).
R $9D19 DE Address of the picture
  $9D19,$03 Set the x position to #N$E8 and the y position to #N$10 (#N$10E8).
  $9D1C,$02 Jump to #R$9CF5 to draw the picture.

c $9D1E Draw Bottom Left Corner Picture
@ $9D1E label=Draw_Bottom_Left_Corner_Picture
D $9D1E Draws a picture of the bottom left corner of the frame of a special
. room, at x position #N$00 and y position #N$A0 (see #R$9CF2).
R $9D1E DE Address of the picture
  $9D1E,$03 Set the x position to #N$00 and the y position to #N$A0 (#N$A000).
  $9D21,$02 Jump to #R$9CF5 to draw the picture.

c $9D23 Draw Bottom Right Corner Picture
@ $9D23 label=Draw_Bottom_Right_Corner_Picture
D $9D23 Draws a picture of the bottom right corner of the frame of a special
. room, at x position #N$E8 and y position #N$A0 (see #R$9CF2).
R $9D23 DE Address of the picture
  $9D23,$03 Set the x position to #N$E8 and the y position to #N$A0 (#N$A0E8).
  $9D26,$02 Jump to #R$9CF5 to draw the picture.

c $9D28 Draw Special Room Parts
@ $9D28 label=Draw_Special_Room_Parts
D $9D28 The routines that draw the parts of the frame of a special room that are
. chosen by the four tables at #R$9DD6. Each entry draws one to three pictures
. (see #R$7687) and returns to the code that called it. The entries are in the
. order of their addresses: they are not grouped by table.
N $9D28 Top right: the ceiling and a corner. Used for code #N$03 of the first
. table.
  $9D28,$03 Draw the ceiling.
  $9D2B,$03 Point at the top right corner picture (#N$81AB).
  $9D2E,$02 Jump to #R$9D19 to draw the corner.
@ $9D30 label=Draw_Top_Right_Corner_And_Right_Wall
N $9D30 Top right: a corner and the right wall. Used for code #N$06 of the first
. table.
  $9D30,$03 Point at the top right corner picture (#N$80D3).
  $9D33,$03 Draw the corner.
  $9D36,$03 Jump to #R$9CE8 to draw the right wall.
@ $9D39 label=Draw_Top_Right_Ceiling_Corner_And_Wall
N $9D39 Top right: the ceiling, a corner and the right wall. Used for code #N$07
. of the first table.
  $9D39,$03 Draw the ceiling.
  $9D3C,$03 Point at the top right corner picture (#N$7CBB).
  $9D3F,$03 Draw the corner.
  $9D42,$03 Jump to #R$9CE8 to draw the right wall.
N $9D45 Bottom right: a corner. Used for code #N$03 of the second table.
  $9D45,$03 Point at the bottom right corner picture (#N$77CB).
  $9D48,$02 Jump to #R$9D23 to draw the corner.
@ $9D4A label=Draw_Bottom_Right_Corner_And_Floor
N $9D4A Bottom right: a corner and the floor. Used for code #N$06 of the second
. table.
  $9D4A,$03 Point at the bottom right corner picture (#N$76F3).
  $9D4D,$03 Draw the corner.
  $9D50,$03 Jump to #R$9CA7 to draw the floor.
N $9D53 Bottom right: a corner and the floor. Used for code #N$07 of the second
. table.
  $9D53,$03 Point at the bottom right corner picture (#N$7BE3).
  $9D56,$03 Draw the corner.
  $9D59,$03 Jump to #R$9CA7 to draw the floor.
@ $9D5C label=Draw_Floor_And_Bottom_Left_Corner
N $9D5C Bottom left: the floor and a corner. Used for code #N$03 of the third
. table.
  $9D5C,$03 Draw the floor.
  $9D5F,$03 Point at the bottom left corner picture (#N$7687).
  $9D62,$02 Jump to #R$9D1E to draw the corner.
@ $9D64 label=Draw_Bottom_Left_Corner_And_Left_Wall
N $9D64 Bottom left: a corner and the left wall. Used for code #N$06 of the
. third table.
  $9D64,$03 Point at the bottom left corner picture (#N$775F).
  $9D67,$03 Draw the corner.
  $9D6A,$03 Jump to #R$9CB1 to draw the left wall.
N $9D6D Bottom left: a corner and the left wall. Used for code #N$07 of the
. third table.
  $9D6D,$03 Point at the bottom left corner picture (#N$7837).
  $9D70,$03 Draw the corner.
  $9D73,$03 Jump to #R$9CB1 to draw the left wall.
N $9D76 Top left: a corner. Used for code #N$03 of the fourth table.
  $9D76,$03 Point at the top left corner picture (#N$8067).
  $9D79,$03 Jump to #R$9CF2 to draw the corner.
N $9D7C Top left: a corner. Used for code #N$06 of the fourth table.
  $9D7C,$03 Point at the top left corner picture (#N$813F).
  $9D7F,$03 Jump to #R$9CF2 to draw the corner.
N $9D82 Top left: a corner. Used for code #N$07 of the fourth table.
  $9D82,$03 Point at the top left corner picture (#N$7C4F).
  $9D85,$03 Jump to #R$9CF2 to draw the corner.
N $9D88 Top right: a corner. Used for codes #N$00 and #N$02 of the first table.
  $9D88,$03 Point at the top right corner picture (#N$858F).
  $9D8B,$03 Jump to #R$9D19 to draw the corner.
N $9D8E Bottom right: a corner. Used for codes #N$00 and #N$02 of the second
. table.
  $9D8E,$03 Point at the bottom right corner picture (#N$84B7).
  $9D91,$03 Jump to #R$9D23 to draw the corner.
N $9D94 Bottom left: a corner. Used for codes #N$00 and #N$02 of the third
. table.
  $9D94,$03 Point at the bottom left corner picture (#N$8523).
  $9D97,$03 Jump to #R$9D1E to draw the corner.
N $9D9A Top left: a corner. Used for codes #N$00 and #N$02 of the fourth table.
  $9D9A,$03 Point at the top left corner picture (#N$85FB).
  $9D9D,$03 Jump to #R$9CF2 to draw the corner.

c $9DA0 Draw Special Room Frame
@ $9DA0 label=Draw_Special_Room_Frame
D $9DA0 Draws the frame of a special room (one with a room y below #N$10).
.
. In these rooms the first byte of the world map entry is not a set of flags
. (see #R$9906) but four codes of three bits each, which overlap by one bit.
. Each code selects one of eight routines from a table of eight addresses (see
. #R$9DD6) and each routine draws the pictures for one part of the frame. The
. codes are:
.
. #TABLE(default,centre) { =h Bits | =h Part of the frame | =h Table } { 0 to 2
. | Top right | #R$9DD6 } { 2 to 4 | Bottom right | #R$9DE6 } { 4 to 6
. | Bottom left | #R$9DF6 } { 6, 7 and 0 | Top left | #R$9E06
. } TABLE#
.
. The first three routines run with the shadow registers, which keeps #REGde
. safe, and the last runs with the main registers.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$9DA0 }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$997D,sp=$5B40)
. #SCR$01(special-frame-before)
. | #SIM(start=$997D,stop=$9980,sp=$5B40)
. #SCR$01(special-frame-after) } UDGTABLE# #POPS
R $9DA0 E First byte of the world map entry
  $9DA0,$01 Fetch the first byte of the world map entry.
  $9DA1,$01 Switch to the shadow registers.
  $9DA2,$02,b$01 Keep bits 0 to 2 (the code for the top right).
  $9DA4,$03 Point at the table for the top right (#R$9DD6).
  $9DA7,$03 Draw the top right of the frame.
  $9DAA,$01 Switch to the main registers.
  $9DAB,$01 Fetch the first byte of the world map entry.
  $9DAC,$01 Switch to the shadow registers.
  $9DAD,$02 Move bits 2 to 4 down to bits 0 to 2.
  $9DAF,$03 Point at the table for the bottom right (#R$9DE6).
  $9DB2,$03 Draw the bottom right of the frame.
  $9DB5,$01 Switch to the main registers.
  $9DB6,$01 Fetch the first byte of the world map entry.
  $9DB7,$01 Switch to the shadow registers.
  $9DB8,$04 Move bits 4 to 6 down to bits 0 to 2.
  $9DBC,$03 Point at the table for the bottom left (#R$9DF6).
  $9DBF,$03 Draw the bottom left of the frame.
  $9DC2,$01 Switch to the main registers.
  $9DC3,$01 Fetch the first byte of the world map entry.
  $9DC4,$02 Rotate bits 6, 7 and 0 into bits 0 to 2.
  $9DC6,$03 Point at the table for the top left (#R$9E06).
@ $9DC9 label=Draw_Frame_Part
N $9DC9 Run the routine that the code selects from the table. The routine
. returns to the caller of this one.
  $9DC9,$02,b$01 Keep bits 0 to 2 (the code).
  $9DCB,$03 Make the code into an offset in #REGde.
  $9DCE,$01 Add the code to the address of the table.
  $9DCF,$01 Add the code to the address of the table again, as the entries are
. two bytes long.
  $9DD0,$01 Fetch the low byte of the address of the routine.
  $9DD1,$01 Move on to the high byte.
  $9DD2,$01 Fetch the high byte of the address of the routine.
  $9DD3,$01 Copy the low byte into #REGl.
  $9DD4,$01 Jump to the routine.
@ $9DD5 label=Draw_Nothing
N $9DD5 Several codes in the tables lead here, so nothing is drawn.
  $9DD5,$01 Return.

w $9DD6 Special Room Frame Tables
@ $9DD6 label=Special_Room_Frame_Tables
D $9DD6 Four tables of eight routines, one table for each part of the frame of a
. special room (see #R$9DA0). The code from the world map selects the entry. The
. tables are for the top right, the bottom right, the bottom left and the top
. left, in that order.
N $9DD6 Top right.
W $9DD6,$02 Code 0: a corner (#R$9D88).
W $9DD8,$02 Code 1: the ceiling (#R$9C70).
W $9DDA,$02 Code 2: a corner (#R$9D88).
W $9DDC,$02 Code 3: the ceiling and a corner (#R$9D28).
W $9DDE,$02 Code 4: the right wall (#R$9CE8).
W $9DE0,$02 Code 5: nothing (#R$9DD5).
W $9DE2,$02 Code 6: a corner and the right wall (#R$9D30).
W $9DE4,$02 Code 7: the ceiling, a corner and the right wall (#R$9D39).
@ $9DE6 label=Special_Room_Frame_Tables_Bottom_Right
N $9DE6 Bottom right.
W $9DE6,$02 Code 0: a corner (#R$9D8E).
W $9DE8,$02 Code 1: nothing (#R$9DD5).
W $9DEA,$02 Code 2: a corner (#R$9D8E).
W $9DEC,$02 Code 3: a corner (#R$9D45).
W $9DEE,$02 Code 4: nothing (#R$9DD5).
W $9DF0,$02 Code 5: nothing (#R$9DD5).
W $9DF2,$02 Code 6: a corner and the floor (#R$9D4A).
W $9DF4,$02 Code 7: a corner and the floor (#R$9D53).
@ $9DF6 label=Special_Room_Frame_Tables_Bottom_Left
N $9DF6 Bottom left.
W $9DF6,$02 Code 0: a corner (#R$9D94).
W $9DF8,$02 Code 1: nothing (#R$9DD5).
W $9DFA,$02 Code 2: a corner (#R$9D94).
W $9DFC,$02 Code 3: the floor and a corner (#R$9D5C).
W $9DFE,$02 Code 4: nothing (#R$9DD5).
W $9E00,$02 Code 5: nothing (#R$9DD5).
W $9E02,$02 Code 6: a corner and the left wall (#R$9D64).
W $9E04,$02 Code 7: a corner and the left wall (#R$9D6D).
@ $9E06 label=Special_Room_Frame_Tables_Top_Left
N $9E06 Top left.
W $9E06,$02 Code 0: a corner (#R$9D9A).
W $9E08,$02 Code 1: nothing (#R$9DD5).
W $9E0A,$02 Code 2: a corner (#R$9D9A).
W $9E0C,$02 Code 3: a corner (#R$9D76).
W $9E0E,$02 Code 4: nothing (#R$9DD5).
W $9E10,$02 Code 5: nothing (#R$9DD5).
W $9E12,$02 Code 6: a corner (#R$9D7C).
W $9E14,$02 Code 7: a corner (#R$9D82).

c $9E16 Print Status Panel
@ $9E16 label=Print_Status_Panel
D $9E16 Prints the depth, the GEMS label and the gem counter. The entry at
. #N$9E27 only prints the gem counter, and the entry at #N$9E32 prints a
. number of BCD digits.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$9E16 }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91DC,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(status-panel-before)
. | #SIM(start=$91DC,stop=$91DF,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(status-panel-after) } UDGTABLE# #POPS
R $9E16 IX Object record of Sabreman
  $9E16,$03 Call #R$9E58.
  $9E19,$02 Set the attribute to cyan (#N$45).
  $9E1B,$03 Store it in #R$8EE8.
  $9E1E,$03 Point at the text GEMS (#R$9E97).
  $9E21,$03 Set the position to x=#N$00, y=#N$08.
  $9E24,$03 Call #R$91B0.
@ $9E27 label=Print_Status_Panel_Gem_Timer
  $9E27,$03 Set the screen position to x=#N$28, y=#N$08.
  $9E2A,$03 Convert the position into a screen address.
  $9E2D,$03 Point at the gem counter (#R$8EEE).
  $9E30,$02 Set the number of digits to print to #N$01.
@ $9E32 label=Print_Status_Panel_Digits
  $9E32,$01 Fetch a BCD byte.
  $9E33,$04 Move the high digit down.
  $9E37,$02 Keep only the digit.
  $9E39,$02 Convert it into a character code.
  $9E3B,$03 Print the digit.
  $9E3E,$01 Fetch the BCD byte again.
  $9E3F,$02 Keep only the low digit.
  $9E41,$02 Convert it into a character code.
  $9E43,$03 Print the digit.
  $9E46,$01 Move on to the next byte.
  $9E47,$02 Repeat for each of the bytes.
  $9E49,$01 Return.

c $9E4A Print Score Label
@ $9E4A label=Print_Score_Label
D $9E4A Prints the text SCORE and six zeroes at the top left of the screen.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$9E4A }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91DF,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(score-label-before)
. | #SIM(start=$91DF,stop=$91E2,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(score-label-after) } UDGTABLE# #POPS
  $9E4A,$02 Set the attribute to yellow (#N$46).
  $9E4C,$03 Store it in #R$8EE8.
  $9E4F,$03 Point at the text SCORE (#R$9F3F).
  $9E52,$03 Set the position to x=#N$00, y=#N$00.
  $9E55,$03 Jump to #R$91B0.

c $9E58 Print Depth
@ $9E58 label=Print_Depth
D $9E58 Prints the text DEPTH and the depth of the room that Sabreman is
. in. The depth is worked out from the room y by adding one to the BCD
. base held in #R$9E93 for each row in the band. The entry at #N$9E66
. leaves out the text.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$9E58 }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91DC,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(depth-before)
. | #SIM(start=$9E58,stop=$0000,ix=$8F1A,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(depth-after) } UDGTABLE# #POPS
R $9E58 IX Object record of Sabreman
  $9E58,$02 Set the attribute to cyan (#N$45).
  $9E5A,$03 Store it in #R$8EE8.
  $9E5D,$03 Point at the text DEPTH (#R$9E9B).
  $9E60,$03 Set the position to x=#N$40, y=#N$08.
  $9E63,$03 Call #R$91B0.
@ $9E66 label=Print_Depth_From_Object
  $9E66,$03 Fetch the room y of the object.
  $9E69,$04 Move the high nibble down.
  $9E6D,$02 Keep only the nibble.
  $9E6F,$03 Use the band number as the offset into the table of bases.
  $9E72,$03 Point at the table of bases (#R$9E93).
  $9E75,$01 Add the offset.
  $9E76,$01 Fetch the BCD base.
  $9E77,$03 Fetch the room y of the object again.
  $9E7A,$02 Keep only the low nibble.
  $9E7C,$01 Add one.
  $9E7D,$01 Store the number of rows in the band as the row counter.
  $9E7E,$01 Start from the BCD depth of the top of the band.
@ $9E7F label=Print_Depth_Row_Loop
  $9E7F,$02 Add one to the depth, keeping it as a BCD value.
  $9E81,$02 Repeat until the depth of the room has been counted up from the top
. of the band.
  $9E83,$03 Store the depth in #N$8EEF.
  $9E86,$03 Set the screen position to x=#N$70, y=#N$08.
  $9E89,$03 Convert the position into a screen address.
  $9E8C,$03 Point at the depth (#R$8EEF).
  $9E8F,$02 Set the number of digits to print to #N$01.
  $9E91,$02 Jump to #R$9E32.

b $9E93 Status Panel Data
@ $9E93 label=Status_Panel_Data
D $9E93 The BCD depth at the top of each band of sixteen room rows, followed
. by the text for the status panel.
B $9E93,$04,$04
@ $9E97 label=Status_Panel_Text_Gems
T $9E97,$04,$03:$01 "GEMS"
@ $9E9B label=Status_Panel_Text_Depth
T $9E9B,$05,$04:$01 "DEPTH"

c $9EA0 Show Ending Screen
@ $9EA0 label=Show_Ending_Screen
D $9EA0 Shows the screen for escaping from the Underwurlde and then shows the
. game over screen. It does not return.
.
. The screen says CONGRATULATIONS and YOU HAVE ESCAPED FROM THE UNDERWURLDE, and
. then gives the name of the next adventure, which depends on the room x of
. Sabreman: #N$03 for KNIGHT LORE, #N$09 for PENTAGRAM and anything else for
. MIRE MARE. The two letters A of PENTAGRAM are drawn as star sprites (see
. #R$9F07).
.
. This is where the game ends if Sabreman reaches room y #N$FF (see #R$9906).
.
. #PUSHS #UDGTABLE(default,centre)
. { =h PENTAGRAM | =h KNIGHT LORE | =h MIRE MARE }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #POKES$8F1E,$FF
. #SIM(start=$9906,stop=$9EDE,ix=$8F1A,sp=$5B40)
. #SCR$01(ending-pentagram)
. | #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #POKES$8F1C,$03;$8F1E,$FF
. #SIM(start=$9906,stop=$9EDE,ix=$8F1A,sp=$5B40)
. #SCR$01(ending-knight-lore)
. | #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #POKES$8F1C,$05;$8F1E,$FF
. #SIM(start=$9906,stop=$9EDE,ix=$8F1A,sp=$5B40)
. #SCR$01(ending-mire-mare) } UDGTABLE# #POPS
  $9EA0,$02 Set the attribute to bright white (#N$47).
  $9EA2,$03 Store it as the attribute for printing (#R$8EE8).
  $9EA5,$03 Point at the text CONGRATULATIONS (#R$9F0D).
  $9EA8,$03 Set the x position to #N$40 and the y position to #N$30 (#N$3040).
  $9EAB,$03 Print the text.
  $9EAE,$03 Point at the text YOU HAVE ESCAPED FROM (#R$9F4B).
  $9EB1,$03 Set the x position to #N$28 and the y position to #N$48 (#N$4828).
  $9EB4,$03 Print the text.
  $9EB7,$03 Point at the text THE UNDERWURLDE (#R$9F61).
  $9EBA,$03 Set the x position to #N$40 and the y position to #N$60 (#N$6040).
  $9EBD,$03 Print the text.
  $9EC0,$03 Point at the text YOUR NEXT ADVENTURE IS (#R$9F71).
  $9EC3,$03 Set the x position to #N$28 and the y position to #N$78 (#N$7828).
  $9EC6,$03 Print the text.
  $9EC9,$02 Set the y position for the name of the next adventure to #N$90.
  $9ECB,$03 Fetch the room x of Sabreman.
  $9ECE,$04 Jump to #R$9EE4 if the room x is #N$03.
  $9ED2,$04 Jump to #R$9EEB if the room x is #N$09.
  $9ED6,$03 Point at the text MIRE MARE (#R$9F35).
  $9ED9,$02 Set the x position to #N$58.
@ $9EDB label=Show_Ending_Screen_Print_Text
  $9EDB,$03 Print the text.
@ $9EDE label=Show_Ending_Screen_Wait_For_Key
  $9EDE,$03 Wait for key 0 to be pressed.
  $9EE1,$03 Jump to #R$95DE to show the game over screen.
@ $9EE4 label=Show_Ending_Screen_Knight_Lore
N $9EE4 The room x is #N$03.
  $9EE4,$03 Point at the text KNIGHT LORE (#R$9F1C).
  $9EE7,$02 Set the x position to #N$50.
  $9EE9,$02 Jump to #R$9EDB to print the text.
@ $9EEB label=Show_Ending_Screen_Pentagram
N $9EEB The room x is #N$09. The text PENTAGRAM leaves a gap of two cells for
. each A, which is filled by a star.
  $9EEB,$03 Point at the attribute and the text PENT GR M (#R$9F28).
  $9EEE,$02 Set the x position to #N$50.
  $9EF0,$03 Print the text using the attribute at the start of the string.
  $9EF3,$04 Point at the object record of the star (#R$9F07).
  $9EF7,$04 Set the x position of the star to #N$70.
  $9EFB,$03 Draw the first star.
  $9EFE,$04 Set the x position of the star to #N$90.
  $9F02,$03 Draw the second star.
  $9F05,$02 Jump to #R$9EDE to wait for a key.

t $9F07 Messaging: Ending Text
@ $9F07 label=Ending_Text
D $9F07 The object record of the star that is drawn for each letter A of
. PENTAGRAM, followed by the text for the ending screen and for the game over
. screen. The last character of each string has bit 7 set. #R$9C3C prints the
. strings that start with an attribute byte, and #R$91B0 prints the others using
. the attribute in #R$8EE8.
B $9F07,$01 Sprite id of the star.
B $9F08,$01 X position (set to #N$70 and then #N$90 before the star is drawn).
B $9F09,$01 Room x.
B $9F0A,$01 Y position.
B $9F0B,$01 Room y.
B $9F0C,$01 Attribute: #COLOUR(#PEEK(#PC)).
@ $9F0D label=Ending_Text_Congratulations
  $9F0D,$0F,$0E:$01 "CONGRATULATIONS"
@ $9F1C label=Ending_Text_Knight_Lore
  $9F1C,$0C,$0B:$01 "KNIGHT LORE"
@ $9F28 label=Ending_Text_Pentagram
N $9F28 PENTAGRAM, with an attribute first. Each of the two gaps is where a star
. is drawn in place of an A.
B $9F28,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $9F29,$0C,$0B:$01 "PENT  GR  M"
@ $9F35 label=Ending_Text_Mire_Mare
  $9F35,$0A,$09:$01 "MIRE MARE"
@ $9F3F label=Ending_Text_Score
  $9F3F,$0C,$0B:$01 "SCORE 000000"
@ $9F4B label=Ending_Text_You_Have_Escaped_From
  $9F4B,$16,$15:$01 "YOU HAVE ESCAPED FROM"
@ $9F61 label=Ending_Text_The_Underwurlde
  $9F61,$10,$0F:$01 "THE UNDERWURLDE"
@ $9F71 label=Ending_Text_Your_Next_Adventure_Is
  $9F71,$17,$16:$01 "YOUR NEXT ADVENTURE IS"
@ $9F88 label=Ending_Text_You_Have_Completed
  $9F88,$13,$12:$01 "YOU HAVE COMPLETED"
@ $9F9B label=Ending_Text_Percent_Sign
N $9F9B The percent sign (character code #N$3B), followed by the text 100 and
. the word OF.
B $9F9B,$01
@ $9F9C label=Ending_Text_One_Hundred
  $9F9C,$04,$03:$01 "100 "
@ $9FA0 label=Ending_Text_Of
  $9FA0,$03,$02:$01 "OF "

c $9FA3 Print Completion Percentage
@ $9FA3 label=Print_Completion_Percentage
D $9FA3 Prints YOU HAVE COMPLETED, the percentage of the Underwurlde that has
. been explored, and OF THE UNDERWURLDE.
.
. The percentage comes from the room visit table at #R$6000. The first byte of
. each of the first #N$0240 pairs of bytes is non-zero if the room has been
. visited, and the number of those is the count. The count is multiplied by
. #N$20 and has #N$80 added, so that its high byte is the count divided by eight
. and rounded. The division routine at #R$AC75 then divides that by
. #N$00C0 after multiplying it by #N$0100, which makes the result about one
. sixth of the count. The result is held as two BCD digits in #R$8EF8.
.
. The count and the result are also stored at #N$5E00, #N$5E02 and #N$5E04,
. which nothing reads.
.
. With #N$0240 entries the result can not be more than 96, so the text 100 is
. never printed.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$9FA3 }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #POKES$6000,$01,$0480,$01
. #SIM(start=$95DE,stop=$95E1,sp=$5B40)
. #SCR$01(percentage-before)
. | #SIM(start=$95E1,stop=$95E4,sp=$5B40)
. #SCR$01(percentage-after) } UDGTABLE# #POPS
  $9FA3,$03 Point at the text YOU HAVE COMPLETED (#R$9F88).
  $9FA6,$03 Set the x position to #N$38 and the y position to #N$48 (#N$4838).
  $9FA9,$03 Print the text.
  $9FAC,$03 Point at the text OF (#R$9FA0).
  $9FAF,$03 Set the x position to #N$78 and the y position to #N$78 (#N$7878).
  $9FB2,$03 Print the text.
  $9FB5,$03 Point at the text THE UNDERWURLDE (#R$9F61).
  $9FB8,$03 Set the x position to #N$48 and the y position to #N$90 (#N$9048).
  $9FBB,$03 Print the text.
N $9FBE Count the rooms that have been visited.
  $9FBE,$03 Point at the room visit table (#R$6000).
  $9FC1,$03 Set the count to #N$0000.
  $9FC4,$03 #REGbc=#N$4003 (#REGb is #N$40 and #REGc is #N$03, which gives #N$40
. passes of the loop and then #N$0100 twice).
@ $9FC7 label=Count_Visited_Rooms
  $9FC7,$01 Fetch the first byte of an entry.
  $9FC8,$01 Move on to the second byte of the entry.
  $9FC9,$01 Move on to the next entry.
  $9FCA,$03 Jump to #R$9FCE if the room has not been visited.
  $9FCD,$01 Add one to the count.
@ $9FCE label=Print_Completion_Percentage_Next_Room
  $9FCE,$02 Decrease the inner room counter and loop back until it is zero.
  $9FD0,$03 Decrease the outer room counter and loop back until every entry of
. the room visit table has been checked.
N $9FD3 Work out the percentage.
  $9FD3,$04 Store the count (nothing reads it).
  $9FD7,$03 Set the divisor to #N$00C0.
  $9FDA,$01 Exchange the registers so that #REGde holds the divisor and #REGhl
. the count.
  $9FDB,$05 Multiply the count by #N$20.
  $9FE0,$03 Set the amount to add for rounding to #N$0080.
  $9FE3,$01 Add #N$80 to round the result.
  $9FE4,$03 Divide the high byte by #REGde (see above).
  $9FE7,$03 Store the result (nothing reads it).
  $9FEA,$01 Fetch the result.
  $9FEB,$04 Jump to #R$A016 if the result is 100 (#N$64) or more.
  $9FEF,$02 Set the percentage counter to the result and clear the BCD
. percentage.
  $9FF1,$01 Add one to the loop counter, as the loop is entered at the end.
  $9FF2,$02 Jump to #R$9FF7 to start the loop.
@ $9FF4 label=Print_Completion_Percentage_Convert_Loop
  $9FF4,$02 Add one.
  $9FF6,$01 Adjust the result to a BCD value.
@ $9FF7 label=Print_Completion_Percentage_Convert_Check
  $9FF7,$02 Decrease the percentage counter and loop back until the percentage
. has been converted to BCD.
  $9FF9,$03 Store the percentage.
  $9FFC,$03 Store the percentage again (nothing reads it).
  $9FFF,$03 Set the x position to #N$70 and the y position to #N$60 (#N$6070).
  $A002,$03 Convert the position into a screen address.
  $A005,$03 Point at the percentage (#R$8EF8).
  $A008,$02 Set the number of digits to print to #N$01.
  $A00A,$03 Print the digits.
@ $A00D label=Print_Percent_Sign
  $A00D,$03 Point at the percent sign (#R$9F9B).
  $A010,$03 Set the x position to #N$88 and the y position to #N$60 (#N$6088).
  $A013,$03 Jump to #R$91B0 to print the percent sign.
@ $A016 label=Print_Completion_Percentage_Print_100
  $A016,$03 Point at the text 100 (#R$9F9C).
  $A019,$03 Set the x position to #N$68 and the y position to #N$60 (#N$6068).
  $A01C,$03 Print the text.
  $A01F,$02 Jump to #R$A00D to print the percent sign.

c $A021 Draw Lives
@ $A021 label=Draw_Lives
D $A021 Draws a small Sabreman icon and prints the number of lives left (see
. #R$8EDA) at the top right of the screen. The entry at #R$A02F only
. prints the number of lives.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$A021 }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91D9,sp=$5B40)
. #SCR$02,$18,$00,$08,$02(lives-before)
. | #SIM(start=$91D9,stop=$91DC,sp=$5B40)
. #SCR$02,$18,$00,$08,$02(lives-after) } UDGTABLE# #POPS
  $A021,$02 Stash #REGix on the stack.
  $A023,$04 Point at the object record of the icon (#R$A03D).
  $A027,$03 Draw the icon.
  $A02A,$03 Colour the icon.
  $A02D,$02 Restore #REGix from the stack.
@ $A02F label=Draw_Lives_Print_Number
  $A02F,$03 Set the x position to #N$F0 and the y position to #N$08 (#N$08F0).
  $A032,$03 Convert the position into a screen address.
  $A035,$03 Point at the number of lives (#R$8EDA).
  $A038,$02 Set the number of digits to print to #N$01.
  $A03A,$03 Jump to #R$9E32 to print the digits.

b $A03D Extra Life Icon Record
@ $A03D label=Extra_Life_Icon_Record
D $A03D The object record of the little Sabreman icon that is drawn next to the
. number of lives by #R$A021.
B $A03D,$01 Sprite id of the icon (#N$7F).
B $A03E,$01 X position.
B $A03F,$01 Room x.
B $A040,$01 Y position.
B $A041,$01 Room y.
B $A042,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $A043,$02,$02 Unused.

c $A045 Add Points To Score
@ $A045 label=AddPointsToScore
D $A045 Adds to the score (see #R$8EF3) and prints the new score at the top of
. the screen.
.
. The amount is a pair of BCD bytes: #REGb holds the hundreds and #REGc the
. units. One is taken off #REGc before it is added, so when #REGc is not zero
. the score goes up by #REGb hundreds plus #REGc minus one. When #REGc is #N$00
. it goes up by #REGb hundreds plus 99.
.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before | =h After #R$A045 }
. { #SIM(start=$9052,stop=$9078,clear=1,sp=$5B40)
. #SIM(start=$91C0,stop=$91E5,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(add-points-before)
. | #SIM(start=$A045,stop=$0000,bc=$0150,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(add-points-after) } UDGTABLE# #POPS
E $A045 View the equivalent code in;
. #LIST
. { #ATICATAC$A19C }
. { #COOKIE$7415 }
. { #JETPAC$70F9 }
. { #LUNARJETMAN$899C }
. { #PSSST$737A }
. { #SABREWULF$B5A9 }
. { #TRANZAM$6046 }
. LIST#
R $A045 B Hundreds to add, as two BCD digits
R $A045 C Units to add, as two BCD digits (see above)
  $A045,$03 Point at the low byte of the score (#R$8EF5).
  $A048,$01 Clear #REGa (which also clears the carry flag).
  $A049,$01 Fetch the low byte of the amount.
  $A04A,$02 Subtract one, in BCD.
  $A04C,$02 Add the low byte of the score and adjust the result to a BCD value.
  $A04E,$01 Store the new low byte of the score.
  $A04F,$01 Move on to the middle byte of the score.
  $A050,$01 Fetch the middle byte of the score.
  $A051,$01 Add the high byte of the amount and the carry.
  $A052,$01 Adjust the result to a BCD value.
  $A053,$01 Store the new middle byte of the score.
  $A054,$01 Move on to the high byte of the score.
  $A055,$01 Fetch the high byte of the score.
  $A056,$02 Add the carry.
  $A058,$01 Adjust the result to a BCD value.
  $A059,$01 Store the new high byte of the score.
  $A05A,$03 Set the x position to #N$30 and the y position to #N$00 (#N$0030).
  $A05D,$03 Point at the score (#R$8EF3).
  $A060,$02 Set the number of digits to print to #N$03.
  $A062,$03 Convert the position into a screen address.
  $A065,$03 Jump to #R$9E32 to print the digits.

c $A068 Sounds: Click
@ $A068 label=SoundsClick
D $A068 Plays a tone on the speaker by switching it on and off. Each cycle is a
. wait of the half period with the speaker on and the same wait with the speaker
. off.
.
. The entry at #R$A06A plays the number of cycles that is in #REGc. The
. code that follows plays other tones by loading #REGbc and jumping to that
. entry.
.
. Writing #N$10 to port #N$FE sets the speaker bit and leaves the border black.
E $A068 View the equivalent code in;
. #LIST
. { #ATICATAC$A3A8 }
. LIST#
R $A068 B Half period of the tone
  $A068,$02 #REGc=#N$01 (one cycle).
@ $A06A label=SoundsBeep
N $A06A Play #REGc cycles of the tone.
  $A06A,$04 Switch the speaker on.
  $A06E,$01 Stash the half period on the stack, as the wait counts #REGb down to
. zero.
@ $A06F label=SoundsBeep_Speaker_On_Wait
  $A06F,$02 Wait for the half period of the tone by counting down to zero.
  $A071,$01 Restore the half period from the stack.
  $A072,$01 Stash the half period on the stack again.
  $A073,$03 Switch the speaker off.
@ $A076 label=SoundsBeep_Speaker_Off_Wait
  $A076,$02 Wait for the other half of the period by counting down to zero.
  $A078,$01 Restore the half period from the stack.
  $A079,$03 Decrease the cycle counter and loop back until all of the cycles
. have been played.
  $A07C,$01 Return.

c $A07D Play Low Tone
@ $A07D label=Play_Low_Tone
D $A07D Plays a tone of #N$40 cycles with a half period of #N$40.
. #HTML(#AUDIO0(low-tone.wav)(#INCLUDE(LowTone)))
  $A07D,$03 #REGbc=#N$4040 (half period #N$40, #N$40 cycles).
  $A080,$02 Jump to #R$A06A to play the tone.

u $A082 Unused
@ $A082 label=Unused_Play_Tone_A082
D $A082 Never reached, as nothing jumps here. Plays a tone of #N$80 cycles with
. a half period of #N$20.
C $A082,$03 #REGbc=#N$2080 (half period #N$20, #N$80 cycles).
C $A085,$02 Jump to #R$A06A to play the tone.

c $A087 Play Alternating Tone
@ $A087 label=Play_Alternating_Tone
D $A087 Plays a short tone on one call in every four. Each call adds one to the
. sound counter (see #R$8EF6) and it returns at once unless the two low bits of
. the counter are zero. When it does play, it uses a half period of #N$40 if bit
. 2 of the counter is set and #N$60 if it is clear, and plays four cycles.
. #HTML(#AUDIO0(footstep-sound.wav)(#INCLUDE(FootstepSound)))
  $A087,$03 Point at the sound counter (#R$8EF6).
  $A08A,$01 Add one to the counter.
  $A08B,$01 Fetch the counter.
  $A08C,$02,b$01 Keep only the two low bits of the sound counter.
  $A08E,$01 Return unless the sound counter is a multiple of four.
  $A08F,$04 Jump to #R$A098 if bit 2 of the counter is clear.
  $A093,$03 #REGbc=#N$4004 (half period #N$40, four cycles).
  $A096,$02 Jump to #R$A06A to play the tone.
@ $A098 label=Play_Alternating_Tone_Lower
  $A098,$03 #REGbc=#N$6004 (half period #N$60, four cycles).
  $A09B,$02 Jump to #R$A06A to play the tone.

u $A09D Unused
@ $A09D label=Unused_Play_Tone_A09D
D $A09D Never reached, as nothing jumps here. Plays a tone of #N$60 cycles with
. a half period of #N$80.
C $A09D,$03 #REGbc=#N$8060 (half period #N$80, #N$60 cycles).
C $A0A0,$02 Jump to #R$A06A to play the tone.

u $A0A2 Unused
@ $A0A2 label=Unused_Start_Sound_Object_89
D $A0A2 Never reached, as nothing jumps here. Sets up a sound object of type
. #N$89 with a count of #N$10 in the fifth of the small object records (see
. #R$902A). The routine at #R$A0AC handles that type of object. The entry at
. #R$A0A5 sets up a sound object with the type in #REGb and the count
. in #REGc.
R $A0A2 B Type of the sound object (at #N$A0A5)
R $A0A2 C Count of the sound object (at #N$A0A5)
C $A0A2,$03 #REGbc=#N$8910 (type #N$89, count #N$10).
@ $A0A5 label=Unused_Set_Sound_Object
C $A0A5,$03 #REGhl=#R$904A (the fifth small object record).
C $A0A8,$01 Store the type of the object.
C $A0A9,$01 Move on to the count.
C $A0AA,$01 Store the count of the object.
C $A0AB,$01 Return.

c $A0AC Sound Effect
@ $A0AC label=SoundEffect
D $A0AC Handler for the object type #N$89, a sound object. Byte #N$01 of the
. object is a count, which it decreases. When the count reaches zero the object
. is removed. Until then it plays a tone of as many cycles as the count, with a
. half period of the count exclusive ORed with #N$43, so the pitch changes as
. the count falls.
. No object of this type is ever created (see #R$A0A2), so the game never
. plays this sound.
. #HTML(#AUDIO0(touching.wav)(#INCLUDE(Touching)))
E $A0AC View the equivalent code in;
. #LIST
. { #ATICATAC$A3EF }
. LIST#
R $A0AC IX Object record
  $A0AC,$05 Decrease the count of the sound and jump to #R$A0BB if it has run
. out.
  $A0B1,$03 Fetch the count of the sound.
  $A0B4,$01 Use it as the number of cycles.
  $A0B5,$02,b$01 Combine the count with #N$43 to make the half period.
  $A0B7,$01 Store the half period in #REGb.
  $A0B8,$03 Jump to #R$A06A to play the tone.
@ $A0BB label=ClearSound
N $A0BB Remove the object.
  $A0BB,$04 Set the type of the object to #N$00.
  $A0BF,$01 Return.

u $A0C0 Unused
@ $A0C0 label=Unused_Start_Sound_Object_8A
D $A0C0 Never reached, as nothing jumps here. Sets up a sound object of type
. #N$8A with a count of #N$0A (see #R$A0A2).
C $A0C0,$03 #REGbc=#N$8A0A (type #N$8A, count #N$0A).
C $A0C3,$02 Jump to #R$A0A5 to set up the object.

c $A0C5 Sound Effect Next Note
@ $A0C5 label=SoundEffectNext
D $A0C5 Handler for the object type #N$8A, a sound object. Byte #N$01 of the
. object is a count, which it decreases. When the count reaches zero the object
. is removed. Until then it plays a tone of as many cycles as the count, with a
. half period that is made from the count rotated left three times, inverted and
. exclusive ORed with #N$40.
. No object of this type is ever created (see #R$A0C0), so the game never
. plays this sound.
. #HTML(#AUDIO0(enter-room.wav)(#INCLUDE(EnterRoom)))
E $A0C5 View the equivalent code in;
. #LIST
. { #ATICATAC$A408 }
. LIST#
R $A0C5 IX Object record
  $A0C5,$05 Decrease the count of the sound and jump to #R$A0BB if it has run
. out.
  $A0CA,$03 Fetch the count of the sound.
  $A0CD,$01 Use it as the number of cycles.
  $A0CE,$03 Rotate the count left three times.
  $A0D1,$01 Invert the bits.
  $A0D2,$02,b$01 Flip bit 6 to make the half period.
  $A0D4,$01 Store the half period in #REGb.
  $A0D5,$03 Jump to #R$A06A to play the tone.

u $A0D8 Unused
@ $A0D8 label=Unused_Play_Falling_Tones
D $A0D8 Never reached, as nothing jumps here. Plays #N$0C tones of one cycle
. each. The half period is the counter rotated right by one bit.
C $A0D8,$02 #REGd=#N$0C (the number of tones).
@ $A0DA label=Unused_Play_Falling_Tones_Loop
C $A0DA,$01 Fetch the counter.
C $A0DB,$01 Rotate it right.
C $A0DC,$01 Use the result as the half period.
C $A0DD,$03 Play the tone.
C $A0E0,$03 Decrease the tone counter and loop back until all of the tones have
. been played.
C $A0E3,$01 Return.

c $A0E4 Sounds: Sword
@ $A0E4 label=SoundsSword
D $A0E4 Plays #N$10 tones of one cycle each. The half period of each tone is the
. counter multiplied by #N$10 and exclusive ORed with #N$1C.
. #HTML(#AUDIO0(sword.wav)(#INCLUDE(Sword)))
E $A0E4 View the equivalent code in;
. #LIST
. { #ATICATAC$A427 }
. LIST#
  $A0E4,$02 Set the number of tones to #N$10.
@ $A0E6 label=SoundsSword_Loop
  $A0E6,$01 Fetch the tone counter, which is used to work out the half period of
. the tone.
  $A0E7,$02 Rotate it left twice.
  $A0E9,$02,b$01 Flip the low three bits.
  $A0EB,$02 Rotate it left twice again, which makes the half period.
  $A0ED,$01 Store the half period in #REGb.
  $A0EE,$03 Play the tone.
  $A0F1,$03 Decrease the tone counter and loop back until all of the tones have
. been played.
  $A0F4,$01 Return.

c $A0F5 Play Position Sound
@ $A0F5 label=Play_Position_Sound
D $A0F5 Plays #N$08 tones of one cycle each. The half period of each tone
. depends on the y position of the object: it is made from the counter added to
. the y position, keeping the low four bits, inverted and rotated left.
. #HTML(#AUDIO0(contact-sound.wav)(#INCLUDE(ContactSound)))
R $A0F5 IX Object record
  $A0F5,$02 Set the number of tones to #N$08.
@ $A0F7 label=Play_Position_Sound_Loop
  $A0F7,$01 Fetch the tone counter.
  $A0F8,$03 Add the y position of the object, so that the pitch depends on its
. position.
  $A0FB,$02,b$01 Keep only the low four bits.
  $A0FD,$01 Invert the bits.
  $A0FE,$01 Rotate the result left.
  $A0FF,$01 Use the result as the half period.
  $A100,$03 Play the tone.
  $A103,$03 Decrease the tone counter and loop back until all of the tones have
. been played.
  $A106,$01 Return.

c $A107 Sounds: Weapon Pop
@ $A107 label=SoundsWeaponPop
D $A107 Handler for the object type #N$8B, which is also called directly to make
. a sound. It plays a run of tones of one cycle each, and the pitch of each one
. is made from a counter that falls by two each time.
.
. The counter starts at the low byte of the frame counter plus one with its
. nibbles swapped, with the low four bits set and bit 7 cleared, so the sound is
. not always the same length. The half period is the counter exclusive ORed with
. #N$20 and rotated left.
. #HTML(#AUDIO0(weapon-pop.wav)(#INCLUDE(WeaponPop)))
E $A107 View the equivalent code in;
. #LIST
. { #ATICATAC$A445 }
. LIST#
R $A107 IX Object record
  $A107,$03 Fetch the low byte of the frame counter.
  $A10A,$01 Add one.
  $A10B,$04 Rotate the result left four times, which swaps the nibbles.
  $A10F,$02,b$01 Set the low four bits.
  $A111,$02,b$01 Clear bit 7.
  $A113,$01 Store the result as the tone counter.
@ $A114 label=SoundsWeaponPop_Loop
  $A114,$01 Fetch the tone counter.
  $A115,$02,b$01 Flip bit 5.
  $A117,$01 Rotate the result left to make the half period.
  $A118,$01 Store the half period in #REGb.
  $A119,$03 Play the tone.
  $A11C,$02 Decrease the tone counter and return if all of the tones have been
. played.
  $A11E,$02 Decrease the tone counter again and return if all of the tones have
. been played.
  $A120,$02 Jump back to play the next tone.

u $A122 Unused
@ $A122 label=Unused_Play_Object_Tone
D $A122 Never reached, as nothing jumps here. Plays #N$10 cycles of a tone whose
. half period is made from byte #N$06 of the object: it is inverted, rotated
. left and cut down to the low six bits, and then bit 6 is set.
R $A122 IX Object record
C $A122,$03 Fetch byte #N$06 of the object.
C $A125,$01 Invert the bits.
C $A126,$01 Rotate it left.
C $A127,$02,b$01 Keep only the low six bits.
C $A129,$02,b$01 Set bit 6.
C $A12B,$01 Use the result as the half period.
C $A12C,$02 #REGc=#N$10 (the number of cycles).
C $A12E,$03 Jump to #R$A06A to play the tone.

c $A131 Sounds: Door
@ $A131 label=SoundsDoor
D $A131 Makes a burst of noise by sending the bits of the first #N$30 bytes of
. the ROM to the speaker. Bit 4 of the port is the speaker bit. The byte is
. rotated right before each of the eight writes, so every bit of it is sent to
. the speaker in turn.
. #HTML(#AUDIO0(door.wav)(#INCLUDE(Door)))
E $A131 View the equivalent code in;
. #LIST
. { #ATICATAC$A46E }
. LIST#
  $A131,$03 #REGbc=#N$0830 (#REGb counts the bits of a byte and #REGc counts
. #N$30 bytes).
  $A134,$03 Point at the start of the ROM (#N$0000).
@ $A137 label=SoundsDoor_Byte
  $A137,$01 Fetch a byte of the ROM.
  $A138,$01 Move on to the next byte.
  $A139,$01 Stash the counters on the stack.
@ $A13A label=SoundsDoor_Bit
  $A13A,$02 Rotate the byte right.
  $A13C,$01 Copy it to #REGa.
  $A13D,$02,b$01 Keep only the speaker bit.
  $A13F,$02 Send it to the speaker.
  $A141,$02 Decrease the bit counter and loop back until all eight bits are
. sent.
  $A143,$01 Restore the counters from the stack.
  $A144,$03 Decrease the byte counter and loop back until all of the bytes have
. been sent.
  $A147,$01 Return.

u $A148 Unused
@ $A148 label=Unused_Start_Sound_Object_A0
D $A148 Never reached, as nothing jumps here. Sets up a sound object of type
. #N$A0 with a count of #N$10 (see #R$A0A2). There is no handler for that type.
C $A148,$03 #REGbc=#N$A010 (type #N$A0, count #N$10).
C $A14B,$03 Jump to #R$A0A5 to set up the object.

u $A14E Unused
@ $A14E label=Unused_Handle_Sound_Object
D $A14E Never reached, as nothing jumps here. It would be a handler for a sound
. object, like #R$A0AC. It decreases byte #N$01 of the object and removes the
. object once the count has gone below zero. Until then it uses the count as an
. index into the table at #R$A163 to get the half period, and plays eight
. cycles.
R $A14E IX Object record
C $A14E,$03 Decrease the count.
C $A151,$03 Jump to #R$A0BB if the count has gone below zero.
C $A154,$03 Fetch the count.
C $A157,$02 #REGb=#N$00.
C $A159,$03 #REGhl=#R$A163 (the table of half periods).
C $A15C,$01 Add the count to the address of the table.
C $A15D,$01 Fetch the half period.
C $A15E,$02 #REGc=#N$08 (the number of cycles).
C $A160,$03 Jump to #R$A06A to play the tone.

b $A163 Unused Tone Table
@ $A163 label=Unused_Tone_Table
D $A163 Sixteen half periods, indexed by the count of a sound object. They are
. only used by the unused code at #R$A14E.
B $A163,$10,$08

c $A173 Sounds: Bounce
@ $A173 label=SoundsBounce
D $A173 Plays four cycles of a tone with a half period of #N$E7, which is a low
. pitch. The counter in #REGd is set to #N$40, and the tone is made from the
. counter after one has been taken off it.
.
. The routine jumps to the tone player, which returns to the caller.
. #HTML(#AUDIO0(bounce.wav)(#INCLUDE(Bounce)))
E $A173 View the equivalent code in;
. #LIST
. { #ATICATAC$A4B0 }
. { #TRANZAM$60E3 }
. LIST#
  $A173,$02 #REGd=#N$40 (the counter).
  $A175,$02 Decrease the tone counter and return if it is zero (this does not
. happen when the routine is entered at the start).
  $A177,$01 Fetch the counter.
  $A178,$03 Rotate the counter right three times.
  $A17B,$01 Use the result as the half period.
  $A17C,$02 Set the number of cycles to #N$04.
  $A17E,$03 Jump to #R$A06A to play the tone.

b $A181 Sprite: Star
@ $A181 label=Sprite_Star_1
D $A181 The star that is drawn for each letter A of PENTAGRAM on the ending
. screen, which is the sprite id #N$90 (see #R$9EA0).
  $A181,$01 Width = #N(#PEEK(#PC)) bytes.
  $A182,$01 Height = #N(#PEEK(#PC)) pixels.
  $A183,$20,$02 #SPRITEDATA(star-01*)

b $A1A3 Sprite: Extra Life
@ $A1A3 label=Sprite_Extra_Life_1
D $A1A3 The sprite of the extra life, which is the object type #N$7F (see
. #R$E751).
  $A1A3,$01 Width = #N(#PEEK(#PC)) bytes.
  $A1A4,$01 Height = #N(#PEEK(#PC)) pixels.
  $A1A5,$10,$01 #SPRITEDATA(extra-life-01*)

b $A1B5 Sprite: Imp
@ $A1B5 label=Sprite_Imp_1
D $A1B5 The two frames of the imp, which is a guardian (see #R$ECCA). The types
. #N$80 and #N$84 use the first frame and the types #N$81 and #N$85 use the
. second frame.
N $A1B5 Frame 1.
  $A1B5,$01 Width = #N(#PEEK(#PC)) bytes.
  $A1B6,$01 Height = #N(#PEEK(#PC)) pixels.
  $A1B7,$57,$03 #SPRITEDATA(imp-01*)
N $A20E Frame 2.
@ $A20E label=Sprite_Imp_2
  $A20E,$01 Width = #N(#PEEK(#PC)) bytes.
  $A20F,$01 Height = #N(#PEEK(#PC)) pixels.
  $A210,$57,$03 #SPRITEDATA(imp-02*)

b $A267 Sprite: Bat
@ $A267 label=Sprite_Bat_1
D $A267 The two frames of the bat, which is a guardian (see #R$ECCA). They are
. the types #N$86 and #N$87.
N $A267 Frame 1.
  $A267,$01 Width = #N(#PEEK(#PC)) bytes.
  $A268,$01 Height = #N(#PEEK(#PC)) pixels.
  $A269,$5D,$03 #SPRITEDATA(bat-01*)
N $A2C6 Frame 2.
@ $A2C6 label=Sprite_Bat_2
  $A2C6,$01 Width = #N(#PEEK(#PC)) bytes.
  $A2C7,$01 Height = #N(#PEEK(#PC)) pixels.
  $A2C8,$4E,$03 #SPRITEDATA(bat-02*)

c $A316 Handle Sabreman On Rope
@ $A316 label=Handle_Sabreman_On_Rope
D $A316 Handler for the object types #N$01 to #N$08, which Sabreman has while he
. hangs on and swings from the rope (the type #N$17 object, see #R$AA4C). The
. sprites are the ones that are called swimming (#N$01 to #N$04 when he moves to
. the left and #N$05 to #N$08 when he moves to the right; the frame follows the
. x position).
.
. If bit 3 or bit 6 of the redraw flags is set, he lets go at #R$A3A5.
. Otherwise the routine checks for contact with the bubbles, the creatures and
. the falling stalactite, any of which sends him to #R$E87B with
. #REGb=#N$10. Next it moves the rope with #R$AAB0 and, if he stays in
. the same room, reads the controls: a bottom row key (or the joystick fire
. button) makes him let go at #R$A3A5, and the fire key throws a
. weapon.
.
. The position and the velocity of the end of the rope (see #R$AA93) are then
. converted to the position and the velocity of Sabreman. If the y position is
. #N$9F or more and the room has a floor, he lets go and stands on the floor at
. #R$A8C9.
R $A316 IX Object record of Sabreman
  $A316,$03 Remember the position and sprite id of Sabreman (see #R$989F).
  $A319,$03 Fetch the redraw flags of Sabreman.
  $A31C,$02,b$01 Keep only bit 3 (the special state) and bit 6 (being carried).
  $A31E,$03 Jump to #R$A3A5 and let go of the rope if either of them is set.
  $A321,$03 Check for contact with the bubbles.
  $A324,$04 Jump to #R$A32D if Sabreman touches a bubble (bit 2 of
. #REGc).
  $A328,$03 Check for contact with the creatures.
  $A32B,$02 Test bit 2 of #REGc (set if Sabreman touches one).
@ $A32D label=Handle_Sabreman_On_Rope_Hit
  $A32D,$02 Set #REGb to #N$10 (this is not changed by the contact test above).
  $A32F,$03 Jump to #R$E87B to knock Sabreman off the rope if he touches a
. bubble or a creature.
  $A332,$03 Check for contact with the falling stalactite.
  $A335,$05 Jump to #R$E87B to knock Sabreman off the rope if the stalactite
. hits him.
  $A33A,$03 Fetch the room x of Sabreman.
  $A33D,$03 Fetch the room y of Sabreman.
  $A340,$01 Stash the room of Sabreman on the stack.
  $A341,$03 Move the rope (see #R$AAB0).
  $A344,$01 Restore the room that Sabreman was in before the rope moved.
  $A345,$03 Fetch the room x that Sabreman is in now.
  $A348,$03 Fetch the room y that Sabreman is in now.
  $A34B,$03 Compare the old room with the new room.
  $A34E,$02 Jump to #R$A365 if the swing of the rope has taken him to a
. different room.
  $A350,$03 Read the controls.
  $A353,$04 Jump to #R$A3A5 and let go of the rope if the "bottom row key" bit
. of the controls (bit 5) is clear.
  $A357,$04 Jump to #R$A360 if the fire key is not pressed (bit 4 of the
. controls is set).
  $A35B,$03 Throw a weapon (see #R$B4D1).
  $A35E,$02 Jump to #R$A365.
@ $A360 label=Handle_Sabreman_On_Rope_Fire_Released
  $A360,$05 Set the flag for the released fire key (#R$AAAB) to #N$FF.
@ $A365 label=Set_Position_From_Rope
N $A365 Set the position of Sabreman from the position of the end of the rope.
  $A365,$03 Fetch the position of the end of the rope (x position in #REGl, y
. position in #REGh).
  $A368,$03 Set the offset from the end of the rope to Sabreman (#N$0C pixels to
. the left and #N$08 pixels down).
  $A36B,$04 Work out the position of Sabreman from the end of the rope and stash
. it on the stack.
  $A36F,$03 Read the world map entry of the room.
  $A372,$01 Copy the room flags to #REGa.
  $A373,$03 Store the room flags in #R$AAAC.
  $A376,$01 Restore the position of Sabreman.
  $A377,$03 Set the x position of Sabreman.
  $A37A,$03 Set the y position of Sabreman.
  $A37D,$01 Copy the y position of Sabreman to #REGa.
  $A37E,$02 Is Sabreman at or below the height of the floor (y position #N$9F)?
  $A380,$03 Fetch the x velocity of the end of the rope.
  $A383,$03 Give Sabreman the x velocity of the end of the rope.
  $A386,$02 Jump to #R$A38D if Sabreman is still above the floor.
  $A388,$05 Jump to #R$A8C9 if the room has a floor and Sabreman has reached it
. (bit 4 of the room flags).
@ $A38D label=Handle_Sabreman_On_Rope_Choose_Frame
  $A38D,$01 Copy the x position of Sabreman to #REGa.
  $A38E,$03 Divide the x position by eight (the frame of the swimming animation
. follows the x position).
  $A391,$02,b$01 Keep only the two low bits.
  $A393,$01 Add one to make a frame from #N$01 to #N$04.
  $A394,$06 Jump to #R$A39C if he is swinging to the left (the x velocity is
. negative).
  $A39A,$02 Add four to use the frames for swinging to the right.
@ $A39C label=Handle_Sabreman_On_Rope_Set_Sprite
  $A39C,$03 Set the sprite id.
  $A39F,$03 Update the sprite of the object (see #R$96CB).
  $A3A2,$03 Jump to #R$AB54.
@ $A3A5 label=Handle_Sabreman_On_Rope_Let_Go
N $A3A5 Sabreman is hit or lets go of the rope, and starts to fall from the
. position of the end of the rope. The velocities are taken from the change in
. that position and the sprite id becomes #N$15 or #N$16 (falling).
  $A3A5,$03 Fetch the position of the end of the rope.
  $A3A8,$04 Fetch the previous position of the end of the rope.
  $A3AC,$01 Copy the y position of the end of the rope to #REGa.
  $A3AD,$01 Subtract the previous y position to get how far the end of the rope
. moved.
  $A3AE,$06 Multiply the movement by eight to get the y velocity.
  $A3B4,$03 Give Sabreman the y velocity.
  $A3B7,$01 Copy the x position of the end of the rope to #REGa.
  $A3B8,$01 Subtract the previous x position to get how far the end of the rope
. moved.
  $A3B9,$03 Give Sabreman that as his x velocity.
  $A3BC,$02 Use the sprite id for falling to the left (#N$15).
  $A3BE,$06 Jump to #R$A3C6 if he is moving to the left (the x velocity is
. negative).
  $A3C4,$02 Use the sprite id for falling to the right (#N$16).
@ $A3C6 label=Handle_Sabreman_On_Rope_Let_Go_Set_Sprite
  $A3C6,$03 Set the sprite id.
  $A3C9,$04 Set the countdown to #N$20.
  $A3CD,$03 Fetch the x velocity.
  $A3D0,$03 Combine it with the y velocity to see if Sabreman is moving at all.
  $A3D3,$03 Jump to #R$A8DA to start him falling if Sabreman is moving.
  $A3D6,$04 Set the y velocity to #N$10 so that he falls.
  $A3DA,$03 Jump to #R$A8DA.

c $A3DD Reset Sabreman
@ $A3DD label=Reset_Sabreman
D $A3DD Copies the template at #R$AA3C into the object record of Sabreman
. (#R$8F1A).
E $A3DD View the equivalent code in;
. #LIST
. { #ATICATAC$8D61 }
. { #COOKIE$64E8 }
. { #TRANZAM$6A09 }
. LIST#
  $A3DD,$03 Point at the template of Sabreman (#R$AA3C).
  $A3E0,$03 Point at the object record of Sabreman (#R$8F1A).
  $A3E3,$03 Set the number of bytes to copy to #N$0010.
  $A3E6,$02 Copy the template into the object record of Sabreman.
  $A3E8,$01 Return.

c $A3E9 Handle Stalactite Hit
@ $A3E9 label=Handle_Stalactite_Hit
D $A3E9 Handles Sabreman being touched by the falling stalactite. It is entered
. from #R$A433(#N$A475) with the result of #R$E833 in #REGc. Bit 7 of
. #REGc is set when the stalactite is on the right of Sabreman or level with
. him, and bit 0 is set when it is at least #N$0A pixels away horizontally.
.
. Sabreman is pushed away from the stalactite at a speed of #N$02. If bit 0 of
. #REGc is clear (a direct hit), the routine goes to #R$E7D0, which turns the
. sprite into the death sprite. Otherwise he starts to tumble with a jump
. upwards.
R $A3E9 C Result of the stalactite contact check
R $A3E9 IX Object record of Sabreman
  $A3E9,$04 Jump to #R$A3F1 if bit 7 of the contact result is set.
  $A3ED,$02 #REGa=#N$02 (move to the right).
  $A3EF,$02 Jump to #R$A3F3.
@ $A3F1 label=Handle_Stalactite_Hit_Move_Left
  $A3F1,$02 #REGa=#N$FE (move to the left).
@ $A3F3 label=Handle_Stalactite_Hit_Set_Velocity
  $A3F3,$03 Set the x velocity.
  $A3F6,$05 Jump to #R$E7D0 if the stalactite hit him directly.
  $A3FB,$04 Set the sprite id to #N$18 (tumbling).
  $A3FF,$04 Set the y velocity to #N$C0 (up).
  $A403,$03 Jump to #R$96CB.

c $A406 Start Tumbling
@ $A406 label=Start_Tumbling
D $A406 Makes Sabreman tumble. The sprite becomes #N$18 (the first of the
. tumbling frames) and the y velocity is set to #N$C0 so that he is thrown
. upwards. Bit 7 of the redraw flags is cleared.
.
. If the x velocity is zero it is set to #N$02 or #N$FE, depending on bit 7 of
. the system variable FRAMES (#N$5C78), which makes the direction random.
. Otherwise the x velocity is negated, so that he bounces back the way he came.
R $A406 IX Object record of Sabreman
  $A406,$04 Set the sprite id to #N$18 (tumbling).
  $A40A,$04 Set the y velocity to #N$C0 (up).
  $A40E,$04 Clear bit 7 of the redraw flags.
  $A412,$03 Fetch the x velocity.
  $A415,$03 Jump to #R$A42B if he is moving sideways.
  $A418,$04 Set the x velocity to #N$02.
  $A41C,$03 Fetch the low byte of FRAMES.
  $A41F,$02,b$01 Keep only bit 7.
  $A421,$03 Jump to #R$96CB if the bit is clear.
  $A424,$04 Set the x velocity to #N$FE.
  $A428,$03 Jump to #R$96CB.
@ $A42B label=Start_Tumbling_Reverse_Velocity
  $A42B,$02 Negate the x velocity.
  $A42D,$03 Set the new x velocity.
  $A430,$03 Jump to #R$96CB.

c $A433 Handle Sabreman Walking
@ $A433 label=Handle_Sabreman_Walking
D $A433 Handler for the object types #N$09 to #N$10, which are the walking
. sprites of Sabreman (#N$09 to #N$0C when he walks to the left and #N$0D to
. #N$10 when he walks to the right). It is also the state that he is in when he
. is standing still.
.
. Each time it saves the object state, handles being carried off (bit 6 of the
. redraw flags), tumbling (bit 7) and the special state at #R$E8A2 (bit
. 3), checks for contact with the bubbles, the stalactite and the creatures,
. reads the controls, moves him sideways, and finally keeps him inside the room,
. moving him to the next room when he walks off the edge.
R $A433 IX Object record of Sabreman
N $A433 Clear the countdown and the contact flags. In the top part of the room
. (y position less than #N$48) the contact flags are set to #N$44, which marks
. both side walls as solid.
  $A433,$03 Remember the position and sprite id of Sabreman (see #R$989F).
  $A436,$03 Fetch the redraw flags of Sabreman.
  $A439,$02,b$01 Keep only bit 6 (being carried).
  $A43B,$03 Jump to #R$B72C if Sabreman is being carried by an eagle (bit 6 of
. the redraw flags is set).
  $A43E,$04 Clear the countdown of Sabreman.
  $A442,$04 Clear the contact flags of Sabreman.
  $A446,$03 Fetch the y position of Sabreman.
  $A449,$04 Jump to #R$A451 if Sabreman is in the lower part of the room (y
. position #N$48 or more).
  $A44D,$04 Mark the walls on both sides as solid by setting the contact flags
. to #N$44, as he is in the upper part of the room.
@ $A451 label=Handle_Sabreman_Walking_Check_Special_States
N $A451 Check the special states.
  $A451,$06 Jump to #R$A406 if bit 7 of the redraw flags is set (Sabreman starts
. to tumble).
  $A457,$07 Jump to #R$E8A2 if bit 3 of the redraw flags is set.
N $A45E Check for contact with the bubbles, the stalactite and the creatures.
. The result of the bubble contact check is kept in byte #N$0E of the record
. of Sabreman.
  $A45E,$03 Read the world map entry of the room (the room flags are returned in
. #REGe).
  $A461,$03 Check for contact with the bubbles.
  $A464,$03 Store the bubble contact result in byte #N$0E of the record of
. Sabreman.
  $A467,$03 Check for contact with the falling stalactite.
  $A46A,$04 Jump to #R$A478 if the stalactite does not touch him (bit 2 of #REGc
. is clear).
  $A46E,$07 Jump to #R$E894 to knock Sabreman down if the stalactite hit him
. while he was touching a bubble.
  $A475,$03 Jump to #R$A3E9 to handle the stalactite hit.
@ $A478 label=Handle_Sabreman_Walking_Check_Creatures
  $A478,$06 Jump to #R$A48C if he is touching a bubble, as the creatures are
. only checked when he is not.
  $A47E,$03 Check for contact with the creatures.
  $A481,$01 Copy the creature contact result to #REGa.
  $A482,$02,b$01 Keep only bits 0 to 6 (ignore which side the creature is on).
  $A484,$05 Jump to #R$E272 to start tumbling downwards if a creature is
. touching him from the side (the contact result is #N$04).
  $A489,$03 Store the creature contact result in byte #N$0E of the record of
. Sabreman.
@ $A48C label=Handle_Sabreman_Walking_Read_Controls
N $A48C Read the controls. A clear fire bit throws a weapon, and a set fire bit
. sets the flag for the released fire key. Then bit 3 of the controls (clear)
. starts a jump, bit 0 (clear) moves him to the right and bit 1 (clear) moves
. him to the left.
  $A48C,$03 Read the controls.
  $A48F,$04 Jump to #R$A499 if bit 4 of the controls is set (the fire
. key is not pressed).
  $A493,$01 Keep the controls in #REGaf' while the weapon is thrown.
  $A494,$03 Throw a weapon (see #R$B4D1).
  $A497,$02 Jump to #R$A49F.
@ $A499 label=Handle_Sabreman_Walking_Fire_Released
  $A499,$01 Keep the controls in #REGaf'.
  $A49A,$05 Set the flag for the released fire key (#R$AAAB) to #N$FF.
@ $A49F label=Handle_Sabreman_Walking_Check_Movement
  $A49F,$01 Fetch the controls again from #REGaf'.
  $A4A0,$05 Jump to #R$A596 to start a jump if the up control is used (bit 3 of
. the controls is clear).
  $A4A5,$05 Jump to #R$A54A to walk to the right if the right control is used
. (bit 0 of the controls is clear).
  $A4AA,$05 Jump to #R$A56E to walk to the left if the left control is used (bit
. 1 of the controls is clear).
  $A4AF,$04 Set the x velocity to #N$00, as he is standing still.
@ $A4B3 label=Handle_Sabreman_Walking_Move_Sideways
N $A4B3 Move Sabreman sideways by the x velocity, unless the contact bits of the
. bubble or creature that he touches (bits 0 to 2) are all set, in which case
. the routine goes to #R$A5EB, which starts a jump with a y velocity of zero.
  $A4B3,$03 Fetch the bubble or creature contact result of Sabreman (byte
. #N$0E).
  $A4B6,$02,b$01 Keep only bits 0 to 2 (touching, on top and at the edge).
  $A4B8,$05 Jump to #R$A5EB if all three are set (he is standing on the edge of
. a bubble or a creature).
  $A4BD,$03 Fetch the x position of Sabreman.
  $A4C0,$03 Add the x velocity of Sabreman.
  $A4C3,$03 Store the new x position of Sabreman.
  $A4C6,$03 Read the world map entry of the room.
  $A4C9,$01 Copy the room flags to #REGa.
  $A4CA,$03 Store the room flags in #R$AAAC.
  $A4CD,$03 Combine the room flags with the contact flags of Sabreman.
  $A4D0,$01 Keep the combined flags in #REGe.
  $A4D1,$03 Fetch the x position of Sabreman.
  $A4D4,$04 Jump to #R$A4EB if Sabreman is at the left edge of the room (x
. position less than #N$10).
  $A4D8,$04 Jump to #R$A4EB if Sabreman is at the right edge of the room (x
. position #N$E8 or more).
  $A4DC,$01 Keep the controls in #REGaf' while the room redrawn flag is fetched.
  $A4DD,$03 Fetch the room redrawn flag from #R$8EF0.
  $A4E0,$01 Copy the flag to #REGd.
  $A4E1,$01 Fetch the controls again from #REGaf'.
  $A4E2,$04 Jump to #R$A4EB if the room has just been drawn (bit 0 of the flag
. is set).
  $A4E6,$05 Jump to #R$A5C3 if there is no floor under him (bit 4 of #REGe is
. clear), as he walks off the ledge.
@ $A4EB label=Handle_Sabreman_Walking_On_Ground
N $A4EB Sabreman is on the ground, so the y velocity is cleared. Then the x
. position is kept inside the room. Bit 2 of the sprite id less one tells which
. way he is facing (set for the right).
  $A4EB,$04 Set the y velocity to #N$00, as he is standing on the floor.
  $A4EF,$03 Fetch the sprite id of Sabreman.
  $A4F2,$01 Decrease it so that bit 2 tells which way he is facing.
  $A4F3,$04 Jump to #R$A520 if he is facing right (bit 2 is set).
  $A4F7,$07 Jump to #R$96CB if he is in the right half of the room (bit 7 of the
. x position is set), as he is far from the left wall.
  $A4FE,$05 Jump to #R$96CB if he has not reached the left wall (x position
. #N$18 or more).
  $A503,$04 Jump to #R$A50E if the left wall is not solid (bit 6 of #REGe is
. clear).
  $A507,$04 Stop him at the left wall by setting the x position to #N$18.
  $A50B,$03 Jump to #R$96CB.
@ $A50E label=Handle_Sabreman_Walking_Left_Room_Edge
  $A50E,$05 Jump to #R$96CB if he has not left the room (x position #N$08 or
. more).
  $A513,$04 Put him at the right edge of the next room (x position #N$F0).
  $A517,$03 Decrease the room x, to go to the room on the left.
  $A51A,$03 Draw the new room.
  $A51D,$03 Jump to #R$96CB.
@ $A520 label=Handle_Sabreman_Walking_Facing_Right
  $A520,$07 Jump to #R$96CB if he is in the left half of the room (bit 7 of the
. x position is clear), as he is far from the right wall.
  $A527,$05 Jump to #R$96CB if he has not reached the right wall (x position
. less than #N$D8).
  $A52C,$05 Jump to #R$A538 if the right wall is not solid (bit 2 of #REGe is
. clear).
  $A531,$04 Stop him at the right wall by setting the x position to #N$D8.
  $A535,$03 Jump to #R$96CB.
@ $A538 label=Handle_Sabreman_Walking_Right_Room_Edge
  $A538,$05 Jump to #R$96CB if he has not left the room (x position less than
. #N$F1).
  $A53D,$04 Put him at the left edge of the next room (x position #N$08).
  $A541,$03 Increase the room x, to go to the room on the right.
  $A544,$03 Draw the new room.
  $A547,$03 Jump to #R$96CB.
@ $A54A label=Handle_Sabreman_Walking_Right
N $A54A Walk to the right. If the contact bits of the bubble or creature that he
. touches (bits 1, 2 and 7) are exactly #N$04 he is blocked and stands still.
. Otherwise the x velocity is #N$02 and the sprite id is #N$0D plus bits 1 and 2
. of the animation counter.
  $A54A,$03 Fetch the bubble or creature contact result of Sabreman (byte
. #N$0E).
  $A54D,$02,b$01 Keep only bits 1, 2 and 7 (on top, touching and the side).
  $A54F,$04 Jump to #R$A55A if he is not blocked on the right (the result is not
. #N$04).
  $A553,$04 Set the x velocity to #N$00, as he is blocked.
  $A557,$03 Jump to #R$A4B3.
@ $A55A label=Handle_Sabreman_Walking_Right_Free
  $A55A,$04 Set the x velocity to #N$02 (walking right).
  $A55E,$03 Increase the animation counter of Sabreman.
  $A561,$03 Fetch the animation counter.
  $A564,$01 Halve the animation counter so that the frame changes every other
. pass.
  $A565,$02,b$01 Keep only the two low bits (one of four frames).
  $A567,$02 Add #N$0D to make the sprite id (the frames for walking right).
  $A569,$03 Set the sprite id.
  $A56C,$02 Jump to #R$A590 to play the footstep sound.
@ $A56E label=Handle_Sabreman_Walking_Left
N $A56E Walk to the left. If the contact bits of the bubble or creature that he
. touches (bits 1, 2 and 7) are exactly #N$84 he is blocked and stands still.
. Otherwise the x velocity is #N$FE and the sprite id is #N$09 plus bits 1 and 2
. of the animation counter.
  $A56E,$03 Fetch the bubble or creature contact result of Sabreman (byte
. #N$0E).
  $A571,$02,b$01 Keep only bits 1, 2 and 7 (on top, touching and the side).
  $A573,$04 Jump to #R$A57E if he is not blocked on the left (the result is not
. #N$84).
  $A577,$04 Set the x velocity to #N$00, as he is blocked.
  $A57B,$03 Jump to #R$A4B3.
@ $A57E label=Handle_Sabreman_Walking_Left_Free
  $A57E,$04 Set the x velocity to #N$FE (walking left).
  $A582,$03 Increase the animation counter of Sabreman.
  $A585,$03 Fetch the animation counter.
  $A588,$01 Halve the animation counter so that the frame changes every other
. pass.
  $A589,$02,b$01 Keep only the two low bits (one of four frames).
  $A58B,$02 Add #N$09 to make the sprite id (the frames for walking left).
  $A58D,$03 Set the sprite id.
@ $A590 label=Handle_Sabreman_Walking_Play_Tone
  $A590,$03 Play the footstep sound (see #R$A087).
  $A593,$03 Jump to #R$A4B3.
@ $A596 label=Handle_Sabreman_Walking_Jump
N $A596 Jump. The y velocity is set to #N$D0, the countdown to #N$08 and the
. sprite id becomes #N$11 (facing left) or #N$13 (facing right), according to
. the direction of the x velocity or, when he is not moving sideways, to the way
. that he faced.
  $A596,$04 Set the y velocity to #N$D0 (up) to start the jump.
@ $A59A label=Handle_Sabreman_Walking_Jump_Set_Countdown
  $A59A,$04 Set the jump countdown to #N$08.
  $A59E,$03 Fetch the sprite id of Sabreman.
  $A5A1,$01 Decrease it so that bit 2 tells which way he is facing.
  $A5A2,$02,b$01 Keep only bit 2 (set when he faces right).
  $A5A4,$02 Shift it right to make #N$00 (left) or #N$02 (right).
  $A5A6,$02 Add #N$11 to make the jumping sprite id.
  $A5A8,$03 Set the sprite id.
  $A5AB,$03 Fetch the x velocity of Sabreman.
  $A5AE,$04 Jump to #R$96CB if he is not moving sideways.
  $A5B2,$03 Jump to #R$A5BC if he is moving to the left.
  $A5B5,$04 Set the sprite id to #N$13 (jumping right).
  $A5B9,$03 Jump to #R$96CB.
@ $A5BC label=Handle_Sabreman_Walking_Jump_Left
  $A5BC,$04 Set the sprite id to #N$11 (jumping left).
  $A5C0,$03 Jump to #R$96CB.
@ $A5C3 label=Handle_Sabreman_Walking_No_Floor
N $A5C3 The room has no floor at this position. Sabreman jumps with a y velocity
. of #N$C0 and an x velocity of #N$02 (when his x position is below #N$80) or
. #N$FE.
  $A5C3,$04 Set the y velocity to #N$C0 (up), as he steps off the ledge.
  $A5C7,$06 Jump to #R$A5DC if bit 7 of the x position is set.
  $A5CD,$04 Set the x velocity to #N$02.
  $A5D1,$04 Set the countdown to #N$08.
  $A5D5,$04 Set the sprite id to #N$13 (jumping right).
  $A5D9,$03 Jump to #R$96CB.
@ $A5DC label=Handle_Sabreman_Walking_No_Floor_Left
  $A5DC,$04 Set the x velocity to #N$FE.
  $A5E0,$04 Set the countdown to #N$08.
  $A5E4,$04 Set the sprite id to #N$11 (jumping left).
  $A5E8,$03 Jump to #R$96CB.
@ $A5EB label=Handle_Sabreman_Walking_Jump_Straight_Up
  $A5EB,$04 Set the y velocity to #N$00, so that the jump has no height.
  $A5EF,$02 Jump to #R$A59A.

c $A5F1 Handle Sabreman Jumping
@ $A5F1 label=Handle_Sabreman_Jumping
D $A5F1 Handler for the object types #N$11 to #N$14, which are the jumping
. sprites of Sabreman (#N$11 and #N$12 when he jumps to the left and #N$13 and
. #N$14 when he jumps to the right).
.
. The countdown in the object record is decreased on every call. When it reaches
. #N$03 the sprite moves on to the next frame, and when it reaches zero the jump
. is over and the sprite becomes #N$15 or #N$16 (falling), so that #R$A6A6 takes
. over. The controls steer him left or right while he is in the air.
.
. At the end of the jump the y position is moved up by #N$04 and the countdown
. is set to #N$0C. If that takes him into the top part of the room and the room
. has a ceiling, he hits it and tumbles at #R$A928.
R $A5F1 IX Object record of Sabreman
N $A5F1 Save the state of the object, then deal with the special states in the
. same way as #R$A433.
  $A5F1,$03 Remember the position and sprite id of Sabreman.
  $A5F4,$07 Jump to #R$B72C if Sabreman is being carried (bit 6 of the redraw
. flags).
  $A5FB,$07 Jump to #R$A406 if Sabreman is tumbling (bit 7 of the redraw flags).
  $A602,$03 Read the world map entry of the room.
  $A605,$03 Check for contact with the bubbles.
N $A608 Decrease the countdown. When it reaches zero the jump ends at
. #R$A645.
  $A608,$05 Decrease the jump countdown and jump to #R$A645 if the jump is over.
  $A60D,$07 Fetch the jump countdown and jump to #R$A617 unless it has reached
. #N$03.
  $A614,$03 Move on to the next frame of the jumping sprite, as he is at the top
. of the jump.
@ $A617 label=Handle_Sabreman_Jumping_Read_Controls
N $A617 Read the controls. Bit 0 clear sets an x velocity of #N$02 and moves to
. the frames for jumping to the right. Bit 1 clear sets an x velocity of #N$FE
. and moves to the frames for jumping to the left. If neither is clear the
. velocity is unchanged.
  $A617,$03 Read the controls.
  $A61A,$04 Jump to #R$A634 if the right control is used (bit 0 of the controls
. is clear).
  $A61E,$05 Jump to #R$96CB if the left control is not used either (bit 1 of the
. controls is set).
  $A623,$04 Set the x velocity of Sabreman to #N$FE (moving left).
  $A627,$07 Switch to the frame for jumping to the left.
  $A62E,$03 Set the sprite id.
  $A631,$03 Jump to #R$96CB.
@ $A634 label=Handle_Sabreman_Jumping_Move_Right
  $A634,$04 Set the x velocity of Sabreman to #N$02 (moving right).
  $A638,$07 Switch to the frame for jumping to the right.
  $A63F,$03 Set the sprite id.
  $A642,$03 Jump to #R$96CB.
@ $A645 label=Handle_Sabreman_Jumping_Finish
N $A645 The jump is over. The sprite id becomes #N$15 (when the jump was to the
. left) or #N$16 (when it was to the right).
  $A645,$03 Fetch the sprite id of Sabreman.
  $A648,$01 Decrease the sprite id.
  $A649,$01 Rotate it right, which leaves the direction in bit 0.
  $A64A,$02,b$01 Keep only the direction (#N$00 for left, #N$01 for right).
  $A64C,$02 Add #N$15 to make the sprite id for falling in that direction.
  $A64E,$03 Set the sprite id.
  $A651,$03 Read the world map entry of the room.
  $A654,$03 Fetch the contact flags of Sabreman.
  $A657,$02 Combine the contact flags of Sabreman with the contact flags of the
. room.
  $A659,$03 Fetch the y position of Sabreman.
  $A65C,$02 Take #N$04 off the y position of Sabreman.
  $A65E,$04 Jump to #R$A66B if he is not in the top part of the room (y position
. of at least #N$49).
  $A662,$04 Mark the walls on both sides as solid by setting the contact flags
. to #N$44, as he is in the upper part of the room.
  $A666,$05 Jump to #R$A928 if he hits the ceiling (bit 0 of the contact flags
. is set).
@ $A66B label=Handle_Sabreman_Jumping_Land
  $A66B,$03 Store the new y position of Sabreman.
  $A66E,$04 Set the countdown of Sabreman to #N$0C.
  $A672,$03 Play the sword sound (see #R$A0E4).
  $A675,$03 Jump to #R$96CB.

c $A678 Handle Falling At Right Edge
@ $A678 label=Handle_Falling_At_Right_Edge
D $A678 Deals with Sabreman when he falls (or tumbles from a fall) and his x
. position has gone past the right-hand side of the room. It is entered from
. #R$A6A6(#N$A747) with the new x position in #REGa and the room flags in #REGe.
.
. If the x position is less than #N$D8 nothing happens and the routine goes on
. at #R$A77E. If the right wall is solid (bit 2 of #REGe), the x
. position is set to #N$D0 and the x velocity is reversed, which then makes him
. tumble. If it is not, the contact flags are given the bits #N$11 and, once the
. x position reaches #N$F0, he enters the room on the right.
R $A678 A New x position of Sabreman
R $A678 E Flags of the room
R $A678 IX Object record of Sabreman
  $A678,$05 Jump to #R$A77E if he has not reached the right wall (x position
. less than #N$D8).
  $A67D,$04 Jump to #R$A688 if the right wall is not solid (bit 2 of #REGe is
. clear).
  $A681,$04 Stop him at the right wall by setting the x position to #N$D0.
  $A685,$03 Jump to #R$A756.
@ $A688 label=Handle_Falling_At_Right_Edge_No_Wall
  $A688,$0A Mark the ceiling and the floor as solid (bits 0 and 4 of the contact
. flags of Sabreman), as he is in the gap in the wall, keeping the new x
. position in #REGaf'.
  $A692,$02 Mark the room as having a floor (bit 4 of #REGe).
  $A694,$05 Jump to #R$A77E if he has not left the room (x position less than
. #N$F0).
  $A699,$03 Increase the room x, to go to the room on the right.
  $A69C,$04 Put him at the left edge of the next room (x position #N$08).
  $A6A0,$03 Draw the new room.
  $A6A3,$03 Jump to #R$96CB.

c $A6A6 Handle Sabreman Falling
@ $A6A6 label=Handle_Sabreman_Falling
D $A6A6 Handler for the object types #N$15 and #N$16, which are the falling
. sprites of Sabreman (#N$15 when he falls to the left and #N$16 when he falls
. to the right). It is also where he lands from a jump or a fall.
.
. The routine checks for contact with the falling stalactite, deals with the
. special states in the same way as #R$A433, lets him steer while he is not
. moving sideways, checks for contact with the bubbles and the creatures, moves
. him sideways and then applies the pull of gravity to the y velocity, which is
. increased by #N$02 each time up to a limit of #N$4C. The y position changes by
. one sixteenth of the y velocity.
.
. He lands when the y position reaches #N$9F. Landing after a fall that reaches
. a y velocity of #N$74 or more kills him (see #R$E7D0).
R $A6A6 IX Object record of Sabreman
  $A6A6,$03 Remember the position and sprite id of Sabreman.
N $A6A9 Check for contact with the falling stalactite. If it touches him, the
. routine ends at #R$E898.
  $A6A9,$03 Check for contact with the falling stalactite.
  $A6AC,$05 Jump to #R$E898 to knock him down if the falling stalactite touches
. him (bit 2 of #REGc is set).
  $A6B1,$07 Jump to #R$B72C if Sabreman is being carried (bit 6 of the redraw
. flags).
  $A6B8,$07 Jump to #R$A406 if Sabreman is tumbling (bit 7 of the redraw flags).
  $A6BF,$07 Jump to #R$E8A2 if Sabreman is in the special state (bit 3 of the
. redraw flags is set).
N $A6C6 Read the controls. While he is not moving sideways, bit 0 clear makes
. the sprite id #N$16 and bit 1 clear makes it #N$15. A clear bit 4 throws a
. weapon, otherwise the flag for the released fire key is set.
  $A6C6,$03 Read the controls.
  $A6C9,$01 Keep the state of the controls in #REGc.
  $A6CA,$03 Fetch the x velocity of Sabreman.
  $A6CD,$03 Jump to #R$A6E0 if he is moving sideways (the x velocity is not
. zero).
  $A6D0,$04 Jump to #R$A6D8 if the right control is not used (bit 0 of the
. controls is set).
  $A6D4,$04 Set the sprite id to #N$16 (falling to the right).
@ $A6D8 label=Handle_Sabreman_Falling_Check_Left_Key
  $A6D8,$04 Jump to #R$A6E0 if the left control is not used (bit 1 of the
. controls is set).
  $A6DC,$04 Set the sprite id to #N$15 (falling to the left).
@ $A6E0 label=Handle_Sabreman_Falling_Check_Fire
  $A6E0,$04 Jump to #R$A6E9 if the fire control is not used (bit 4 of the
. controls is set).
  $A6E4,$03 Throw a weapon (see #R$B4D1).
  $A6E7,$02 Jump to #R$A6EE.
@ $A6E9 label=Handle_Sabreman_Falling_Fire_Released
  $A6E9,$05 Set the flag for the released fire key (#R$AAAB) to #N$FF.
@ $A6EE label=Handle_Sabreman_Falling_Check_Contact
N $A6EE Check for contact with the bubbles and then the creatures. The contact
. result is in #REGc. With bit 1 clear he is pushed away sideways with an x
. velocity of #N$02 or #N$FE, a tone is played and he tumbles at
. #R$A928. With bit 1 set he lands on top of the object at
. #R$A8A0 when bit 0 is clear, and nothing happens when bit 0 is set.
  $A6EE,$03 Read the world map entry of the room.
  $A6F1,$04 Store the room flags in #R$AAAC.
  $A6F5,$03 Check for contact with the bubbles.
  $A6F8,$04 Jump to #R$A705 if Sabreman touches a bubble (bit 2 of #REGc is
. set).
  $A6FC,$01 Stash the world map entry on the stack.
  $A6FD,$03 Check for contact with the creatures.
  $A700,$01 Restore the world map entry from the stack.
  $A701,$04 Jump to #R$A733 if Sabreman touches no creature (bit 2 of #REGc is
. not set).
@ $A705 label=Handle_Sabreman_Falling_Bubble_Contact
  $A705,$04 Jump to #R$A724 if he is touching the middle of it (bit 0 of #REGc
. is clear).
  $A709,$04 Jump to #R$A733 to carry on falling if he is on top of the edge of
. it (bit 1 of #REGc is set).
@ $A70D label=Handle_Sabreman_Falling_Push_Sideways
  $A70D,$03 Make Sabreman tumble inside the walls (see #R$EBC0).
  $A710,$04 Jump to #R$A71A if he is on the left of it (bit 7 of #REGc is
. clear).
  $A714,$04 Push him to the right by setting the x velocity to #N$02.
  $A718,$02 Jump to #R$A71E.
@ $A71A label=Handle_Sabreman_Falling_Push_Left
  $A71A,$04 Push him to the left by setting the x velocity to #N$FE.
@ $A71E label=Handle_Sabreman_Falling_Push_Play_Tone
  $A71E,$03 Play a low tone.
  $A721,$03 Jump to #R$A928.
@ $A724 label=Handle_Sabreman_Falling_Land_On_Bubble
  $A724,$04 Jump to #R$A70D and push him away sideways if he is not on top of it
. (bit 1 of #REGc is clear).
  $A728,$08 Set the y position so that Sabreman stands on top of the bubble.
  $A730,$03 Jump to #R$A8A0.
@ $A733 label=Handle_Sabreman_Falling_Move_Sideways
N $A733 Move Sabreman sideways by the x velocity. At the left-hand side of the
. room (x position less than #N$18) a solid left wall stops him and reverses the
. x velocity so that he tumbles. Without a wall, he enters the room on the left
. when the x position is less than #N$08.
  $A733,$05 Combine the contact flags of Sabreman with the contact flags of the
. room.
  $A738,$04 Clear the contact flags of Sabreman.
  $A73C,$03 Fetch the x position of Sabreman.
  $A73F,$03 Add the x velocity of Sabreman.
  $A742,$03 Store the new x position of Sabreman.
  $A745,$05 Jump to #R$A678 if he is in the right half of the room (bit 7 of the
. x position is set).
  $A74A,$04 Jump to #R$A77E if he is clear of the left wall (x position #N$18 or
. more).
  $A74E,$04 Jump to #R$A761 if the left wall is not solid (bit 6 of #REGe is
. clear).
  $A752,$04 Stop him at the left wall by setting the x position to #N$18.
@ $A756 label=Handle_Sabreman_Falling_Reverse_Velocity
  $A756,$08 Reverse the x velocity, so that he bounces off the wall.
  $A75E,$03 Jump to #R$A928 to tumble.
@ $A761 label=Handle_Sabreman_Falling_No_Left_Wall
  $A761,$0A Mark the ceiling and the floor as solid (bits 0 and 4 of the contact
. flags of Sabreman), as he is in the gap in the wall, keeping the new x
. position in #REGaf'.
  $A76B,$02 Mark the room as having a floor (bit 4 of #REGe).
  $A76D,$04 Jump to #R$A77E if he has not left the room (x position #N$08 or
. more).
  $A771,$03 Decrease the room x, to go to the room on the left.
  $A774,$04 Put him at the right edge of the next room (x position #N$F0).
  $A778,$03 Draw the new room.
  $A77B,$03 Jump to #R$96CB.
@ $A77E label=Handle_Sabreman_Falling_Apply_Gravity
N $A77E Apply gravity. If the y velocity is positive and has reached #N$4C it is
. left as it is, otherwise it is increased by #N$02. The y position is then
. changed by the y velocity divided by #N$10.
.
. If the new y position is #N$9F or more, the contact flags are given the bits
. #N$44, and he lands at #R$A89C when the room has a floor or goes down
. to the room below at #R$A86F when it does not.
  $A77E,$03 Fetch the y velocity of Sabreman.
  $A781,$04 Jump to #R$A78E if he is moving upwards (bit 7 of the y velocity is
. set).
  $A785,$04 Jump to #R$A78E if he is not yet falling at full speed (the y
. velocity is less than #N$4C).
  $A789,$03 Make Sabreman tumble inside the walls (see #R$EBC0).
  $A78C,$02 Jump to #R$A794.
@ $A78E label=Handle_Sabreman_Falling_Increase_Velocity
  $A78E,$03 Increase the y velocity (gravity pulls him down).
  $A791,$03 Increase the y velocity again.
@ $A794 label=Handle_Sabreman_Falling_Move_Vertically
  $A794,$08 Divide the y velocity by sixteen, keeping the sign.
  $A79C,$03 Add the y position of Sabreman to get the new y position.
  $A79F,$04 Jump to #R$A7B5 if he has not reached the bottom of the room (the
. new y position is less than #N$9F).
  $A7A3,$0A Set bits 2 and 6 of the contact flags of Sabreman (both side walls
. are solid), keeping the new y position in the alternate #REGaf'.
  $A7AD,$05 Jump to #R$A86F if the room has no floor (bit 4 of #REGe is clear),
. to go down to the room below.
  $A7B2,$03 Jump to #R$A89C to land on the floor.
@ $A7B5 label=Handle_Sabreman_Falling_Above_Floor
N $A7B5 The y position is above #N$9F. If it is less than #N$48 and the room has
. a ceiling (bit 0 of #REGe), a negative y velocity is made positive and the y
. position is set to #N$48. If it is less than #N$48 and the room has no
. ceiling, the contact flags are given the bits #N$44 and, when the y position
. is less than #N$28, he moves up to the room above.
  $A7B5,$04 Jump to #R$A7CE if he is below the top of the room (y position #N$48
. or more).
  $A7B9,$04 Jump to #R$A7E4 if the room has no ceiling (bit 0 of #REGe is
. clear).
  $A7BD,$03 Make Sabreman tumble inside the walls (see #R$EBC0).
  $A7C0,$03 Fetch the y velocity of Sabreman.
  $A7C3,$04 Jump to #R$A7CC if he is moving down (bit 7 of the y velocity is
. clear).
  $A7C7,$02 Negate the y velocity, so that he bounces off the ceiling.
  $A7C9,$03 Store the new y velocity of Sabreman.
@ $A7CC label=Handle_Sabreman_Falling_Set_Ceiling_Position
  $A7CC,$02 Set the y position to #N$48, just below the ceiling.
@ $A7CE label=Handle_Sabreman_Falling_Store_Y_Position
N $A7CE Store the y position and make #REGc the y position less #N$37 (with a
. minimum of #N$02). While the countdown is not zero it is decreased and the
. routine ends.
  $A7CE,$03 Store the y position of Sabreman.
  $A7D1,$04 Work out the length of rope needed to reach him (the y position less
. #N$37) and jump to #R$A7D7 unless that is negative.
  $A7D5,$02 Use the shortest length of #N$02 instead.
@ $A7D7 label=Handle_Sabreman_Falling_Set_Threshold
  $A7D7,$01 Keep the length of rope needed in #REGc.
  $A7D8,$03 Fetch the countdown of Sabreman.
  $A7DB,$03 Jump to #R$A7FF if the countdown is zero.
  $A7DE,$03 Decrease the countdown of Sabreman.
  $A7E1,$03 Jump to #R$96CB.
@ $A7E4 label=Handle_Sabreman_Falling_No_Ceiling
  $A7E4,$01 Switch to the shadow registers.
  $A7E5,$03 Fetch the contact flags of Sabreman.
  $A7E8,$02,b$01 Set bits 2 and 6 (both side walls are solid).
  $A7EA,$03 Store the contact flags of Sabreman.
  $A7ED,$01 Switch back to the main registers.
  $A7EE,$04 Jump to #R$A7CE if he has not left the top of the room (y position
. #N$28 or more).
  $A7F2,$03 Decrease the room y, to go to the room above.
  $A7F5,$04 Put him at the bottom of the room above (y position #N$BA).
  $A7F9,$03 Draw the new room.
  $A7FC,$03 Jump to #R$96CB.
@ $A7FF label=Handle_Sabreman_Falling_Check_Rope
N $A7FF The countdown is zero. Now the routine checks whether he is falling onto
. the rope (the type #N$17 object, see #R$AA4C). The conditions are that the
. room y is #N$10 or more, that the number in #R$AAA5 (the length of
. the rope) is not less than #REGc, that his x position is within #N$10 of #N$78
. (where the rope hangs), and that record 3 holds the rope and #R$AAA4
. is zero. When they hold, he grabs the rope: the sprite id is set to #N$01,
. record 3 is cleared (from then on #R$A316 looks after the rope), and the
. second byte of the world map entry of each room below him is cleared down to
. the first room that has a floor.
  $A7FF,$03 Fetch the room y of Sabreman.
  $A802,$05 Jump to #R$96CB if he is in a special room (the room y is less than
. #N$10), as there is no rope there.
  $A807,$03 Fetch the length of the rope from #R$AAA5.
  $A80A,$02,b$01 Keep only the length (bits 0 to 6).
  $A80C,$04 Jump to #R$96CB if the rope is too short to reach him (the length is
. less than #REGc).
  $A810,$03 Fetch the redraw flags of Sabreman.
  $A813,$02,b$01 Keep only bits 0, 1, 2, 5 and 7 (this clears bits 3, 4 and 6).
  $A815,$03 Store the redraw flags of Sabreman.
  $A818,$03 Fetch the x position of Sabreman.
  $A81B,$05 Work out how far he is from the rope (x position #N$78) and jump to
. #R$A822 if he is on the right of it.
  $A820,$02 Make the distance positive.
@ $A822 label=Handle_Sabreman_Falling_Check_Rope_Distance
  $A822,$05 Jump to #R$96CB if he is too far from the rope (the distance is
. #N$10 or more).
  $A827,$03 Fetch the type of record 3 (the rope).
  $A82A,$04 Jump to #R$A881 if the rope has not been set up.
  $A82E,$03 Fetch the displacement of the rope from #R$AAA4.
  $A831,$04 Jump to #R$96CB if the rope is swinging (the displacement is not
. zero).
@ $A835 label=Handle_Sabreman_Falling_Catch_Rope
  $A835,$01 Copy the length of rope needed to #REGb.
  $A836,$05 Jump to #R$96CB if the length of rope needed is too long (bit 7 of
. #REGb is set).
  $A83B,$03 Fetch the length of the rope from #R$AAA5.
  $A83E,$02,b$01 Keep only bit 7 (the flag of the rope).
  $A840,$01 Combine the flag with the length of rope needed.
  $A841,$03 Set the length of the rope to the length needed to reach him.
  $A844,$04 Set the sprite id to #N$01 (hanging on the rope).
  $A848,$03 Fetch the x velocity of Sabreman.
  $A84B,$06 Multiply the x velocity by eight.
  $A851,$03 Set the x velocity of the end of the rope (#R$AAA2) so that it
. swings the way that he was moving.
  $A854,$04 Clear the type of record 3 (the rope), as Sabreman is now holding
. it.
  $A858,$03 Find the world map entry of the room.
  $A85B,$03 Set the offset to the room below (#N$20).
@ $A85E label=Handle_Sabreman_Falling_Find_Rope_Row_Loop
  $A85E,$04 Jump to #R$A869 if this room has a floor (bit 4 of the room flags).
  $A862,$01 Add the offset to move to the entry of the room below.
  $A863,$01 Move on to the second byte of the entry.
  $A864,$02 Clear the second byte of the entry.
  $A866,$01 Move back to the first byte of the entry.
  $A867,$02 Jump to #R$A85E.
@ $A869 label=Handle_Sabreman_Falling_Move_Rope
  $A869,$03 Move the rope (see #R$AAB0).
  $A86C,$03 Jump to #R$A365 to position Sabreman on the rope.
@ $A86F label=Handle_Sabreman_Falling_Check_Bottom_Edge
  $A86F,$05 Jump to #R$A7B5 if he has not reached the bottom of the room (the y
. position is less than #N$BC).
  $A874,$03 Increase the room y, to go to the room below.
  $A877,$04 Put him at the top of the room below (y position #N$2A).
  $A87B,$03 Draw the new room.
  $A87E,$03 Jump to #R$A7B5.
@ $A881 label=Handle_Sabreman_Falling_No_Rope
N $A881 There is no rope in record 3. If the room has a ceiling (bit 0 of #REGe)
. and no floor (bit 4), the second byte of the world map entry of the room is
. set to #N$08, the rope end positions in #R$AA93 are cleared and the code above
. carries on, so that he grabs a rope that is just long enough.
  $A881,$05 Jump to #R$96CB if the room has no ceiling (bit 0 of #REGe is
. clear).
  $A886,$05 Jump to #R$96CB if the room has a floor (bit 4 of #REGe is set).
  $A88B,$03 Find the world map entry of the room.
  $A88E,$01 Move on to the second byte of the entry.
  $A88F,$02 Write #N$08 to the second byte of the entry.
  $A891,$09 Clear the length of the rope (#R$AAA5) and the word at #R$AA97.
  $A89A,$02 Jump to #R$A835 to grab the new rope.
@ $A89C label=Handle_Sabreman_Falling_Reach_Floor
  $A89C,$04 Put him on the floor by setting the y position to #N$9F.
@ $A8A0 label=Land_Sabreman
N $A8A0 Sabreman lands. If the y velocity is positive and #N$74 or more (and the
. gem timer at #R$8EEE is zero) he dies at #R$E7D0. Otherwise a low tone is
. played and the sprite id becomes #N$09 (when he faced left) or #N$0D (when he
. faced right), which are the walking sprites.
  $A8A0,$03 Fetch the gem timer from #R$8EEE.
  $A8A3,$03 Jump to #R$A8B2 if the gem timer is running (it is not zero), as he
. cannot be hurt.
  $A8A6,$03 Fetch the y velocity of Sabreman.
  $A8A9,$04 Jump to #R$A8B2 if he is moving up (bit 7 of the y velocity is set).
  $A8AD,$05 Jump to #R$E7D0 and kill him if he has fallen too fast (the y
. velocity is #N$74 or more).
@ $A8B2 label=Land_Sabreman_Play_Tone
  $A8B2,$03 Play a low tone.
  $A8B5,$03 Fetch the sprite id of Sabreman.
  $A8B8,$01 Decrease the sprite id so that bit 0 tells which way he was falling.
  $A8B9,$02 Rotate the direction up to bit 2.
  $A8BB,$02,b$01 Keep only bit 2 (set when he faced right).
  $A8BD,$02 Add #N$09 to make the sprite id for walking in that direction.
  $A8BF,$03 Set the sprite id of Sabreman.
  $A8C2,$04 Stop him tumbling by resetting bit 7 of the redraw flags.
  $A8C6,$03 Jump to #R$96CB.
@ $A8C9 label=Stand_Sabreman_On_Floor
N $A8C9 Sabreman comes down from the rope onto the floor at y position #N$9F.
. The sprite id becomes #N$09 (when the x velocity is negative) or #N$0D.
  $A8C9,$04 Put him on the floor by setting the y position to #N$9F.
  $A8CD,$02 Start with the sprite id #N$09 (walking to the left).
  $A8CF,$06 Jump to #R$A8D7 if he is moving to the left (bit 7 of the x velocity
. is set).
  $A8D5,$02 Add #N$04 to make the sprite id #N$0D (walking to the right).
@ $A8D7 label=Stand_Sabreman_On_Floor_Set_Sprite
  $A8D7,$03 Set the sprite id of Sabreman.
@ $A8DA label=Restore_Type_17_Object
N $A8DA Record 3 is made a type #N$17 object again, with its x velocity (byte
. #N$06) set to #N$03.
  $A8DA,$05 Set the type of record 3 (the rope) to #N$17.
  $A8DF,$05 Set the x velocity of the rope to #N$03.
  $A8E4,$03 Fetch the redraw flags of Sabreman.
  $A8E7,$02,b$01 Keep only bit 6 (being carried).
  $A8E9,$03 Jump to #R$B72C if Sabreman is being carried by an eagle.
  $A8EC,$03 Jump to #R$96CB.

c $A8EF Handle Tumbling At Right Edge
@ $A8EF label=Handle_Tumbling_At_Right_Edge
D $A8EF Deals with Sabreman when he tumbles and his x position has gone past the
. right-hand side of the room. It is entered from #R$A925(#N$A9BE) with the new
. x position in #REGa and the room flags in #REGe.
.
. If the x position is less than #N$CF nothing happens and the routine goes on
. at #R$A9F5. If the right wall is solid (bit 2 of #REGe), the x
. velocity is reversed and the x position is set to #N$CF. If it is not, the
. contact flags are given the bits #N$11 and, once the x position reaches #N$E8,
. he enters the room on the right.
R $A8EF A New x position of Sabreman
R $A8EF E Flags of the room
R $A8EF IX Object record of Sabreman
  $A8EF,$05 Jump to #R$A9F5 if he has not reached the right wall (x position
. less than #N$CF).
  $A8F4,$04 Jump to #R$A907 if the right wall is not solid (bit 2 of #REGe is
. clear).
  $A8F8,$08 Reverse the x velocity, so that he bounces off the wall.
  $A900,$04 Stop him at the right wall by setting the x position to #N$CF.
  $A904,$03 Jump to #R$A9F5.
@ $A907 label=Handle_Tumbling_At_Right_Edge_No_Wall
  $A907,$0A Mark the ceiling and the floor as solid (bits 0 and 4 of the contact
. flags of Sabreman), as he is in the gap in the wall, keeping the new x
. position in #REGaf'.
  $A911,$02 Mark the room as having a floor (bit 4 of #REGe).
  $A913,$05 Jump to #R$A9F5 if he has not left the room (x position less than
. #N$E8).
  $A918,$03 Increase the room x, to go to the room on the right.
  $A91B,$04 Put him at the left edge of the next room (x position #N$08).
  $A91F,$03 Draw the new room.
  $A922,$03 Jump to #R$96CB.

c $A925 Handle Sabreman Tumbling
@ $A925 label=Handle_Sabreman_Tumbling
D $A925 Handler for the object types #N$18 to #N$1B, which are the tumbling
. sprites of Sabreman. The sprite id is #N$18 plus bits 1 and 2 of the tick
. counter at #R$8ED6, so the frames follow each other as time passes.
.
. He tumbles after the stalactite or a creature has hit him and when he bumps
. into a side wall while he is falling. The routine decreases the countdown,
. checks for contact with the bubbles and the creatures (which push him sideways
. with an x velocity of #N$02 or #N$FE), moves him sideways and applies gravity
. in the same way as #R$A6A6, and goes on at #R$A7B5 once the y
. position is less than #N$9F.
.
. Unlike the falling handler the y velocity here has a limit of #N$76.
R $A925 IX Object record of Sabreman
  $A925,$03 Remember the position and sprite id of Sabreman.
@ $A928 label=Continue_Sabreman_Tumbling
N $A928 Deal with the special states in the same way as #R$A433.
  $A928,$07 Jump to #R$B72C if Sabreman is being carried (bit 6 of the redraw
. flags).
  $A92F,$07 Jump to #R$A406 if Sabreman is tumbling (bit 7 of the redraw flags).
N $A936 Read the world map entry and decrease the countdown unless it is zero.
  $A936,$03 Read the world map entry of the room.
  $A939,$03 Fetch the countdown of Sabreman.
  $A93C,$03 Jump to #R$A942 if the countdown is zero.
  $A93F,$03 Decrease the countdown of Sabreman.
@ $A942 label=Handle_Sabreman_Tumbling_Save_Room_Flags
  $A942,$04 Store the room flags in #R$AAAC.
N $A946 Check for contact with the bubbles and the creatures.
  $A946,$03 Check for contact with the bubbles.
  $A949,$04 Jump to #R$A97A if Sabreman touches a bubble (bit 2 of #REGc is
. set).
  $A94D,$01 Stash the world map entry on the stack.
  $A94E,$03 Check for contact with the creatures.
  $A951,$01 Restore the world map entry from the stack.
  $A952,$04 Jump to #R$A995 if Sabreman touches no creature (bit 2 of #REGc is
. not set).
@ $A956 label=Handle_Sabreman_Tumbling_Creature_Check_Side
  $A956,$04 Jump to #R$A96A if he is touching the middle of it (bit 0 of #REGc
. is clear).
  $A95A,$04 Jump to #R$A995 if he is on top of the edge of it (bit 1 of #REGc is
. set).
@ $A95E label=Handle_Sabreman_Tumbling_Creature_Bounce
  $A95E,$04 Jump to #R$A966 if he is on the left of it (bit 7 of #REGc is
. clear).
  $A962,$02 Set the new x velocity to #N$02 (pushed to the right).
  $A964,$02 Jump to #R$A987.
@ $A966 label=Handle_Sabreman_Tumbling_Creature_Bounce_Left
  $A966,$02 Set the new x velocity to #N$FE (pushed to the left).
  $A968,$02 Jump to #R$A987.
@ $A96A label=Handle_Sabreman_Tumbling_Creature_Check_Top
  $A96A,$04 Jump to #R$A95E and push him away sideways if he is not on top of it
. (bit 1 of #REGc is clear).
  $A96E,$09 Set the y position so that Sabreman stands on top of the creature.
  $A977,$03 Jump to #R$A8A0.
@ $A97A label=Handle_Sabreman_Tumbling_Bubble_Contact
  $A97A,$01 Copy the bubble contact result to #REGa.
  $A97B,$02,b$01 Keep only bits 0 and 1.
  $A97D,$04 Jump to #R$A956 unless he is on top of the middle of the bubble (the
. result is #N$02).
  $A981,$04 Stop him falling by setting the y velocity to #N$00.
  $A985,$02 Jump to #R$A96A.
@ $A987 label=Handle_Sabreman_Tumbling_Set_Velocity
  $A987,$01 Copy the new x velocity to #REGa.
  $A988,$03 Combine it with the old x velocity using XOR to find out if the
. direction has changed.
  $A98B,$03 Set the new x velocity of Sabreman.
  $A98E,$02,b$01 Keep only bit 7 (set when the direction has changed).
  $A990,$01 Switch to the shadow registers to keep #REGbc, #REGde and #REGhl.
  $A991,$03 Play a low tone if the direction has changed.
  $A994,$01 Switch back to the main registers.
@ $A995 label=Handle_Sabreman_Tumbling_Combine_Flags
N $A995 Combine the room flags with the contact flags and clear the contact
. flags. The sprite id is set to #N$18 plus bits 1 and 2 of the tick counter.
  $A995,$05 Combine the contact flags of Sabreman with the contact flags of the
. room.
  $A99A,$04 Clear the contact flags of Sabreman.
  $A99E,$03 Fetch the tick counter from #R$8ED6.
  $A9A1,$01 Rotate the tick counter right, so that the frame changes every other
. tick.
  $A9A2,$02,b$01 Keep only bits 0-1.
  $A9A4,$02 Add #N$18 to make the sprite id of a tumbling frame.
  $A9A6,$03 Set the sprite id of Sabreman.
  $A9A9,$03 Fetch the x velocity of Sabreman.
  $A9AC,$01 Test the x velocity.
N $A9AD Move Sabreman sideways. This is done when the x velocity is not zero or
. the x position is less than #N$80.
  $A9AD,$03 Fetch the x position of Sabreman.
  $A9B0,$02 Jump to #R$A9B6 if he is moving sideways (the x velocity is not
. zero).
  $A9B2,$04 Jump to #R$A9C1 if he is in the left half of the room (bit 7 of the
. x position is clear).
@ $A9B6 label=Handle_Sabreman_Tumbling_Move_Sideways
  $A9B6,$03 Add the x velocity of Sabreman.
  $A9B9,$03 Store the new x position of Sabreman.
  $A9BC,$05 Jump to #R$A8EF if he is in the right half of the room (bit 7 of the
. x position is set).
@ $A9C1 label=Handle_Sabreman_Tumbling_Check_Left_Edge
  $A9C1,$05 Jump to #R$A9F5 if he is clear of the left wall (x position #N$18 or
. more).
  $A9C6,$04 Jump to #R$A9D8 if the left wall is not solid (bit 6 of #REGe is
. clear).
  $A9CA,$03 Fetch the x velocity of Sabreman.
  $A9CD,$02 Negate the x velocity, so that he bounces off the wall.
  $A9CF,$03 Store the new x velocity of Sabreman.
  $A9D2,$04 Stop him at the left wall by setting the x position to #N$18.
  $A9D6,$02 Jump to #R$A9F5.
@ $A9D8 label=Handle_Sabreman_Tumbling_No_Left_Wall
  $A9D8,$0A Mark the ceiling and the floor as solid (bits 0 and 4 of the contact
. flags of Sabreman), as he is in the gap in the wall, keeping the new x
. position in #REGaf'.
  $A9E2,$02 Mark the room as having a floor (bit 4 of #REGe).
  $A9E4,$04 Jump to #R$A9F5 if he has not left the room (x position #N$08 or
. more).
  $A9E8,$03 Decrease the room x, to go to the room on the left.
  $A9EB,$04 Put him at the right edge of the next room (x position #N$E7).
  $A9EF,$03 Draw the new room.
  $A9F2,$03 Jump to #R$96CB.
@ $A9F5 label=Apply_Tumbling_Gravity
N $A9F5 Apply gravity. The y velocity is increased by #N$02 each time up to a
. limit of #N$76, and the y position is changed by the y velocity divided by
. #N$10. A y position of #N$9F or more sends him to #R$A89C when the
. room has a floor.
  $A9F5,$03 Fetch the y velocity of Sabreman.
  $A9F8,$04 Jump to #R$AA00 if he is moving up (bit 7 of the y velocity is set).
  $A9FC,$04 Jump to #R$AA06 if he is falling at full speed (the y velocity is
. #N$76 or more).
@ $AA00 label=Apply_Tumbling_Gravity_Increase_Velocity
  $AA00,$03 Increase the y velocity (gravity pulls him down).
  $AA03,$03 Increase the y velocity again.
@ $AA06 label=Apply_Tumbling_Gravity_Move_Vertically
  $AA06,$08 Divide the y velocity by sixteen, keeping the sign.
  $AA0E,$03 Add the y position of Sabreman to get the new y position.
  $AA11,$03 Store the new y position of Sabreman.
  $AA14,$05 Jump to #R$A7B5 if he has not reached the bottom of the room (the y
. position is less than #N$9F).
  $AA19,$0A Mark both side walls as solid (bits 2 and 6 of the contact flags of
. Sabreman), keeping the new y position in #REGaf'.
  $AA23,$04 Jump to #R$AA2A if the room has no floor (bit 4 of #REGe is clear).
  $AA27,$03 Jump to #R$A89C to land on the floor.
@ $AA2A label=Apply_Tumbling_Gravity_Check_Bottom_Edge
  $AA2A,$05 Jump to #R$96CB if he has not reached the bottom of the room (the y
. position is less than #N$BC).
  $AA2F,$03 Increase the room y, to go to the room below.
  $AA32,$04 Put him at the top of the room below (y position #N$2C).
  $AA36,$03 Draw the new room.
  $AA39,$03 Jump to #R$96CB.

g $AA3C Sabreman Template
@ $AA3C label=Sabreman_Template
D $AA3C The object record that #R$A3DD copies into the record of Sabreman.
. It sets his type to #N$09, his position to #N$40,#N$9F in the room with
. x=#N$09 and y=#N$0E, and his attribute to #N$47 (white).
B $AA3C,$10,$10

c $AA4C Handle Rope
@ $AA4C label=Handle_Rope
D $AA4C Handler for the object type #N$17, which is the rope that hangs from the
. ceiling of a room (see #R$AE81). It is the handler of record 3 while Sabreman
. is not holding the rope; when he grabs it the record is cleared and #R$A316
. takes over.
.
. Each call lengthens the rope by one (the length is the word at
. #R$AAA5) until its low seven bits reach #N$38, and sets bit 0 of the
. redraw flags so that the rope gets drawn.
.
. If the rope is swinging (the displacement in #R$AAA4 is not zero) the
. displacement moves back towards zero by #N$02 on each call and the counter in
. byte #N$06 of the record is set to #N$03. When the rope hangs straight down,
. the counter counts down to zero and the redraw flag is set for each count.
. Finally the position of the end of the rope is worked out (#R$AB78) and the
. rope is drawn (#R$AB54).
R $AA4C IX Object record of the rope (#R$8F2A)
N $AA4C Make the rope longer, up to a length of #N$38.
  $AA4C,$03 Fetch the length of the rope from #R$AAA5.
  $AA4F,$01 Copy the low byte to #REGa.
  $AA50,$02 Keep only the low seven bits.
  $AA52,$04 Jump to #R$AA5E if the rope is already full length (the length is
. #N$38 or more).
  $AA56,$01 Add one to the length, so that the rope grows.
  $AA57,$03 Store the new length of the rope.
  $AA5A,$04 Set bit 0 of the redraw flags, so that the rope is drawn.
@ $AA5E label=Handle_Rope_Fetch_Displacement
N $AA5E Make the swing die down.
  $AA5E,$03 Fetch the displacement of the end of the rope.
  $AA61,$03 Jump to #R$AA70 if the rope hangs straight down.
  $AA64,$04 Set the swing counter to #N$03.
  $AA68,$03 Jump to #R$AA8C if the end of the rope is displaced to the right
. (the displacement is positive).
  $AA6B,$02 Add two to the displacement, which moves it back towards zero.
  $AA6D,$03 Jump to #R$AA86 if the displacement has become zero or positive.
@ $AA70 label=Handle_Rope_Store_Displacement
  $AA70,$03 Store the displacement of the end of the rope.
  $AA73,$03 Fetch the swing counter.
  $AA76,$03 Jump to #R$AA80 if the swing counter is zero.
  $AA79,$03 Decrease the swing counter.
  $AA7C,$04 Set bit 0 of the redraw flags, so that the rope is drawn.
@ $AA80 label=Handle_Rope_Position_End
  $AA80,$03 Work out the position of the end of the rope.
  $AA83,$03 Jump to #R$AB54 to draw the rope.
@ $AA86 label=Handle_Rope_Zero_Displacement
  $AA86,$04 Set the displacement to zero, so that the rope hangs straight down.
  $AA8A,$02 Jump to #R$AA70.
@ $AA8C label=Handle_Rope_Reduce_Positive
  $AA8C,$02 Subtract two from the displacement, which moves it back towards
. zero.
  $AA8E,$03 Jump to #R$AA86 if the displacement has become negative.
  $AA91,$02 Jump to #R$AA70.

g $AA93 Line Step Count
@ $AA93 label=Line_Step_Count
D $AA93 The difference between the y positions of the two end points of the line
. that #R$ACAB sets up. It is the number of steps of the line, which has one
. step for each pixel row.
B $AA93,$01

g $AA94 Line Direction Flags
@ $AA94 label=Line_Direction_Flags
D $AA94 The direction of the line that #R$ACAB sets up. Bit 0 is set when the y
. position in #REGh is less than the y position in #REGd, and bit 1 is set when
. the x position in #REGl is less than the x position in #REGe.
B $AA94,$01,$01

g $AA95 Rope End Position
@ $AA95 label=Rope_End_Position
D $AA95 The position of the end of the rope, that #R$AB78 works out. The low
. byte is the x position and the high byte is the y position. The x position is
. the displacement of the rope (#R$AAA4) plus #N$80.
B $AA95,$01 The x position.
@ $AA96 label=Rope_End_Position_Y
B $AA96,$01 The y position.

g $AA97 Previous Rope End Position
@ $AA97 label=Previous_Rope_End_Position
D $AA97 The position of the end of the rope when it was last drawn by #R$AB54,
. which erases the rope there. The low byte is the x position and the high byte
. is the y position. It is set to zero when a rope is set up (see #R$AE81).
W $AA97,$02

g $AA99 Unused
D $AA99 Not used by the game.
B $AA99,$07,$07

g $AAA0 Main Line Fraction
@ $AAA0 label=Main_Line_Fraction
D $AAA0 The fraction that is carried from step to step by the line that #R$AD02
. draws with the main register set.
B $AAA0,$01

g $AAA1 Shadow Line Fraction
@ $AAA1 label=Shadow_Line_Fraction
D $AAA1 The fraction that is carried from step to step by the line that #R$AD02
. draws with the shadow register set.
B $AAA1,$01

g $AAA2 Rope Velocity
@ $AAA2 label=Rope_Velocity
D $AAA2 The horizontal velocity of the end of the rope. The left and right
. controls change it by #N$02 (see #R$AAB0) and #R$ABE5 moves it towards zero.
. #R$A365 gives it to Sabreman as his x velocity.
B $AAA2,$01

g $AAA3 Rope Displacement
@ $AAA3 label=Rope_Displacement
D $AAA3 The displacement of the end of the rope from the vertical, as a word.
. The low byte is a fraction. The high byte, at #N$AAA4, is the displacement in
. pixels (it is negative when the rope swings to the left). It is zero when the
. rope hangs straight down.
B $AAA3,$01 The fraction.
@ $AAA4 label=Rope_Displacement_Pixels
B $AAA4,$01 The displacement in pixels.

g $AAA5 Rope Length
@ $AAA5 label=Rope_Length
D $AAA5 The length of the rope, as a word. #R$AA4C makes the low byte grow to
. #N$38 when a rope is first drawn, and #R$AAF4 and #R$AB30 change it when
. Sabreman climbs down or up. Each time the length passes a multiple of #N$80
. the rope reaches the next room down.
B $AAA5,$01 The low byte.
@ $AAA6 label=Rope_Length_High_Byte
B $AAA6,$01 The high byte.

g $AAA7 Rope Anchor Position
@ $AAA7 label=Rope_Anchor_Position
D $AAA7 The position of the point where the rope hangs from, which #R$AB78 works
. out. The low byte is the x position (it is always #N$80) and the high byte is
. the y position.
W $AAA7,$02

g $AAA9 Previous Rope Anchor Position
@ $AAA9 label=Previous_Rope_Anchor_Position
D $AAA9 The position of the point where the rope hung from when #R$AB54 last
. drew it.
W $AAA9,$02

g $AAAB Fire Key Flag
@ $AAAB label=Fire_Key_Flag
D $AAAB The handlers of Sabreman set this to #N$FF while the fire key is not
. pressed. #R$B4D1 counts it up while a weapon is in flight and throws
. a new weapon only when its low three bits are zero.
B $AAAB,$01

g $AAAC Room Flags
@ $AAAC label=Room_Flags
D $AAAC The flags of the room that Sabreman is in, which are the first byte of
. its world map entry (see #R$7000). The handlers of Sabreman keep it up to
. date. The main loop tests bit 4 (the floor) at #R$91C0(#N$91FF) and #R$DF58
. tests bit 0 (the ceiling).
B $AAAC,$01

c $AAAD Skip Rope Push
@ $AAAD label=Skip_Rope_Push
D $AAAD Used by #R$AAB0 when the end of the rope has already swung as far as the
. length of the rope allows, so that the left and right controls are ignored. It
. restores the controls from #REGaf' and carries on at #R$AAE1.
  $AAAD,$01 Fetch the controls again from #REGaf'.
  $AAAE,$02 Jump to #R$AAE1 without pushing the rope.

c $AAB0 Update Rope
@ $AAB0 label=Update_Rope
D $AAB0 Reads the controls and updates the rope that Sabreman hangs from.
.
. The left and right controls (bits 0 and 1 of the controls, which are clear
. when the control is used) push the end of the rope by changing the velocity in
. #R$AAA2 by #N$02. That is only done while the displacement of the rope
. (#R$AAA4) is not more than the length of the rope divided by #N$08,
. with a maximum of #N$08.
.
. The down and up controls (bits 2 and 3) make the rope longer, which lowers
. Sabreman, and shorter, which raises him. Then #R$ABE5 moves the rope and
. #R$AB78 works out where its end is.
R $AAB0 IX Object record of Sabreman
N $AAB0 Read the controls and find out whether the rope may be pushed.
  $AAB0,$03 Read the controls.
  $AAB3,$03 Point at the velocity of the end of the rope (#R$AAA2).
  $AAB6,$01 Keep the controls in #REGaf'.
  $AAB7,$03 Fetch the displacement of the end of the rope.
  $AABA,$04 Jump to #R$AAC0 if the displacement is positive.
  $AABE,$02 Make the displacement positive.
@ $AAC0 label=Update_Rope_Check_Displacement
  $AAC0,$01 Keep the displacement in #REGb.
  $AAC1,$03 Fetch the high byte of the length of the rope.
  $AAC4,$01 Rotate bit 0 of the high byte into the carry.
  $AAC5,$03 Fetch the low byte of the length of the rope.
  $AAC8,$03 Divide the length by #N$08 to work out how far the rope may be
. pushed.
  $AACB,$02,b$01 Keep only six bits.
  $AACD,$04 Jump to #R$AAD3 if the limit is less than #N$08.
  $AAD1,$02 Limit the push to #N$08.
@ $AAD3 label=Update_Rope_Check_Limit
  $AAD3,$03 Jump to #R$AAAD if the displacement is larger than the limit, as the
. rope cannot be pushed any further.
N $AAD6 Use the left and right controls to push the end of the rope.
  $AAD6,$01 Fetch the controls again from #REGaf'.
  $AAD7,$05 Push the rope to the right if the right control is used (bit 0 of
. the controls is clear).
  $AADC,$05 Push the rope to the left if the left control is used (bit 1 of the
. controls is clear).
@ $AAE1 label=Update_Rope_Fetch_Length
N $AAE1 Use the down and up controls to change the length of the rope.
  $AAE1,$03 Fetch the length of the rope.
  $AAE4,$05 Lower the rope if the down control is used (bit 2 of the controls is
. clear).
  $AAE9,$05 Raise the rope if the up control is used (bit 3 of the controls is
. clear).
  $AAEE,$03 Move the rope (see #R$ABE5).
  $AAF1,$03 Jump to #R$AB78 to work out the position of the end of the rope.

c $AAF4 Lower Rope
@ $AAF4 label=Lower_Rope
D $AAF4 Makes the rope longer by two, which lowers Sabreman.
.
. When the length reaches a multiple of #N$80 he is at the bottom of the room.
. If the room has a floor he cannot go on and the length is only made longer by
. one. Otherwise the length is made longer by two more, the world map entries of
. the room and of the room below are given the second byte that marks where the
. rope runs (see #R$AE81), Sabreman moves down to the room below and the room is
. drawn.
R $AAF4 A Controls
R $AAF4 HL Length of the rope
R $AAF4 IX Object record of Sabreman
  $AAF4,$01 Keep the controls on the stack.
  $AAF5,$02 Make the length of the rope longer by two.
  $AAF7,$01 Copy the low byte of the length to #REGa.
  $AAF8,$02,b$01 Keep only bits 1 to 6.
  $AAFA,$02 Jump to #R$AB2B if the rope has not reached the bottom of the room
. (the length is not a multiple of #N$80).
  $AAFC,$03 Read the world map entry of the room.
  $AAFF,$01 Copy the room flags to #REGa.
  $AB00,$03 Store the room flags in #R$AAAC.
  $AB03,$04 Jump to #R$AB0A if the room has no floor (bit 4 of the room flags is
. clear).
  $AB07,$01 Make the length one shorter, as the floor stops the rope.
  $AB08,$02 Jump to #R$AB2B.
@ $AB0A label=Lower_Rope_Lengthen
  $AB0A,$02 Make the length longer by two, to lower the rope into the room
. below.
  $AB0C,$03 Store the new length of the rope.
  $AB0F,$01 Double the length.
  $AB10,$01 Copy the high byte (the number of the room along the rope) to #REGa.
  $AB11,$01 Stash it in #REGaf'.
  $AB12,$03 Find the address of the world map entry of the room.
  $AB15,$01 Point at the second byte of the entry.
  $AB16,$01 Fetch the number of the room along the rope.
  $AB17,$01 Subtract one.
  $AB18,$02,b$01 Set bits 2 and 3.
  $AB1A,$01 Store the result in the second byte of the entry of the room.
  $AB1B,$03 Set the offset to the room below (#N$0020).
  $AB1E,$01 Point at the entry of the room below.
  $AB1F,$01 Add one to make the number of the room along the rope for the room
. below.
  $AB20,$02,b$01 Reset bit 2.
  $AB22,$01 Store it in the second byte of the entry of the room below.
  $AB23,$03 Move Sabreman down to the room below.
  $AB26,$03 Draw the new room.
  $AB29,$01 Fetch the controls again from the stack.
  $AB2A,$01 Return.
@ $AB2B label=Lower_Rope_Store_Length
  $AB2B,$03 Store the new length of the rope.
  $AB2E,$01 Fetch the controls again from the stack.
  $AB2F,$01 Return.

c $AB30 Raise Rope
@ $AB30 label=Raise_Rope
D $AB30 Makes the rope shorter by two, which raises Sabreman. The length never
. gets below #N$20.
.
. When the length falls to a multiple of #N$80 he is at the top of the room. The
. length is then made shorter by two more, the second byte of the world map
. entry of the room is cleared, Sabreman moves up to the room above and the room
. is drawn.
R $AB30 A Controls
R $AB30 HL Length of the rope
R $AB30 IX Object record of Sabreman
  $AB30,$01 Keep the controls on the stack.
  $AB31,$01 Copy the high byte of the length to #REGa.
  $AB32,$03 Jump to #R$AB3A if the length is more than #N$FF.
  $AB35,$01 Copy the low byte of the length to #REGa.
  $AB36,$04 Jump to #R$AB2B if the rope is already at its shortest (the length
. is less than #N$20).
@ $AB3A label=Raise_Rope_Shorten
  $AB3A,$02 Make the length of the rope shorter by two.
  $AB3C,$01 Copy the low byte of the length to #REGa.
  $AB3D,$02,b$01 Keep only bits 1 to 6.
  $AB3F,$02 Jump to #R$AB2B if the rope has not reached the top of the room (the
. length is not a multiple of #N$80).
  $AB41,$02 Make the length shorter by two, to raise the rope into the room
. above.
  $AB43,$03 Store the new length of the rope.
  $AB46,$03 Find the address of the world map entry of the room.
  $AB49,$01 Point at the second byte of the entry.
  $AB4A,$02 Clear the second byte of the entry.
  $AB4C,$03 Move Sabreman up to the room above.
  $AB4F,$03 Draw the new room.
  $AB52,$01 Fetch the controls again from the stack.
  $AB53,$01 Return.

c $AB54 Draw Rope
@ $AB54 label=Draw_Rope
D $AB54 Draws the rope in its new position and erases it from its old position.
. The drawing of a line uses XOR, so drawing the old line again removes it.
.
. The old position of the anchor and the old end of the rope are put in the main
. register set and the new ones in the shadow register set. The new end of the
. rope is stored as the old one for the next time. #R$AD02 draws both lines.
  $AB54,$04 Fetch the previous position of the point where the rope hangs from
. (#R$AAA9).
  $AB58,$03 Fetch the previous position of the end of the rope (#R$AA97).
  $AB5B,$01 Switch to the shadow registers.
  $AB5C,$03 Fetch the new position of the end of the rope.
  $AB5F,$03 Store it as the previous position.
  $AB62,$04 Fetch the position of the point where the rope hangs from.
  $AB66,$04 Store it as the previous position.
  $AB6A,$03 Draw the old rope and the new rope (see #R$AD02).
  $AB6D,$01 Return.

c $AB6E Push Rope Right
@ $AB6E label=Push_Rope_Right
D $AB6E Adds two to the velocity of the end of the rope.
R $AB6E HL Address of the velocity (#R$AAA2)
R $AB6E A Controls
  $AB6E,$01 Keep the controls on the stack.
  $AB6F,$02 Push the rope to the right by adding two to the velocity of its end.
  $AB71,$02 Jump to #R$AB76.

c $AB73 Push Rope Left
@ $AB73 label=Push_Rope_Left
D $AB73 Subtracts two from the velocity of the end of the rope.
R $AB73 HL Address of the velocity (#R$AAA2)
R $AB73 A Controls
  $AB73,$01 Keep the controls on the stack.
  $AB74,$02 Push the rope to the left by subtracting two from the velocity of
. its end.
@ $AB76 label=Push_Rope_Left_Restore_Controls
  $AB76,$01 Fetch the controls again from the stack.
  $AB77,$01 Return.

c $AB78 Position Rope End
@ $AB78 label=Position_Rope_End
D $AB78 Works out the position of the end of the rope and the position of the
. point that it hangs from.
.
. The end of the rope is below the point that it hangs from by a depth that is
. found from the displacement of the rope (#R$AAA4) and its length
. (#R$AAA5). The routine squares the displacement, squares the length, subtracts
. the first square from the second and takes the square root of the result with
. #R$AE56. When the length is #N$100 or more, the length and the square of the
. displacement are halved before they are used.
.
. The x position is the displacement plus #N$80, and it is stored in #R$AA95.
. The y position is stored in the byte after it. The point that the rope hangs
. from is stored in #R$AAA7: it is #N$24 pixels down at an x position of
. #N$80 when the length is less than #N$80, and #N$10 pixels down when it is
. longer.
R $AB78 IX Object record
N $AB78 Square the displacement.
  $AB78,$02 Clear the high byte of the displacement.
  $AB7A,$03 Fetch the displacement of the end of the rope.
  $AB7D,$04 Jump to #R$AB83 if it is positive.
  $AB81,$02 Make it positive.
@ $AB83 label=Position_Rope_End_Square_Displacement
  $AB83,$01 Copy the displacement to #REGe.
  $AB84,$03 Multiply the displacement by itself.
  $AB87,$01 Stash the square of the displacement on the stack.
N $AB88 Square the length of the rope. If the high byte of the length is not
. zero, the square of the displacement and the length are halved first.
  $AB88,$02 Clear the high byte of the length.
  $AB8A,$03 Fetch the high byte of the length of the rope.
  $AB8D,$03 Jump to #R$ABA0 if the length is less than #N$100.
  $AB90,$01 Restore the square of the displacement from the stack.
  $AB91,$04 Halve it.
  $AB95,$01 Stash it on the stack again.
  $AB96,$03 Fetch the length of the rope.
  $AB99,$04 Halve it.
  $AB9D,$01 Copy the low byte of the halved length to #REGa.
  $AB9E,$02 Jump to #R$ABA3.
@ $ABA0 label=Position_Rope_End_Short_Rope
  $ABA0,$03 Fetch the low byte of the length of the rope.
@ $ABA3 label=Position_Rope_End_Square_Length
  $ABA3,$01 Copy the length to #REGe.
  $ABA4,$03 Square the length (or half of it).
  $ABA7,$01 Restore the square of the displacement from the stack.
  $ABA8,$03 Subtract the square of the displacement from the square of the
. length.
  $ABAB,$03 Take the square root, which is the depth of the end of the rope.
  $ABAE,$01 Keep the depth of the end of the rope in #REGa.
N $ABAF Work out the y position of the end of the rope and the position that the
. rope hangs from, which depend on the number of the room along the rope.
  $ABAF,$03 Fetch the length of the rope.
  $ABB2,$01 Double it.
  $ABB3,$01 Stash the depth in #REGaf'.
  $ABB4,$01 Copy the high byte (the number of the room along the rope) to #REGa.
  $ABB5,$01 Test the number of the room.
  $ABB6,$03 #REGde=#N$2480 (the position that the rope hangs from in the top
. room).
  $ABB9,$02 Jump to #R$ABD0 if it is the top room.
  $ABBB,$03 #REGde=#N$1080 (the position that the rope hangs from in the other
. rooms).
  $ABBE,$02 Set the offset to take off the depth to #N$D7.
  $ABC0,$04 Jump to #R$ABC6 if bit 0 of the number of the room is
. clear.
  $ABC4,$02 Set the offset to take off the depth to #N$58.
@ $ABC6 label=Position_Rope_End_Check_Room_Number
  $ABC6,$01 Fetch the depth again from #REGaf'.
  $ABC7,$04 Jump to #R$ABCD if bit 1 of the number of the room is
. clear.
  $ABCB,$02 Double the depth.
@ $ABCD label=Position_Rope_End_Subtract_Offset
  $ABCD,$01 Subtract the offset from the depth.
  $ABCE,$02 Jump to #R$ABD3.
@ $ABD0 label=Position_Rope_End_Top_Room
  $ABD0,$01 Fetch the depth again from #REGaf'.
  $ABD1,$02 Add #N$18 to the depth.
@ $ABD3 label=Position_Rope_End_Store_Position
  $ABD3,$02 Add #N$0C to the result.
  $ABD5,$03 Store it as the y position of the end of the rope.
  $ABD8,$04 Store the position that the rope hangs from.
  $ABDC,$03 Fetch the displacement of the end of the rope.
  $ABDF,$02 Add #N$80 (the middle of the room) to make the x position of the end
. of the rope.
  $ABE1,$03 Store it as the x position of the end of the rope.
  $ABE4,$01 Return.

c $ABE5 Move Rope
@ $ABE5 label=Move_Rope
D $ABE5 Makes the rope swing. The velocity of the end of the rope (#R$AAA2) is
. changed by four towards the middle of the swing (it is increased when the
. displacement is negative and decreased when it is positive) and then it is
. multiplied by #N$20 and added to the displacement (#R$AAA3).
.
. When the rope is already at rest nothing changes. When the end of the rope is
. moving towards the middle, the change of velocity is left out on one call in
. eight (the test is made on the tick counter at #R$8ED6 for a negative
. displacement and on FRAMES for a positive one).
.
. If the length of the rope is less than #N$80 the displacement is limited to
. the length multiplied by #N$B0 and divided by #N$100. When it would go
. further, the displacement is set to the limit and the velocity and the
. fraction are set to zero. For a longer rope the displacement is not limited.
R $ABE5 IX Object record
N $ABE5 Find out if the rope is at rest (no displacement and no velocity).
  $ABE5,$03 Fetch the displacement of the end of the rope.
  $ABE8,$03 Point at the velocity of the end of the rope.
  $ABEB,$03 Jump to #R$ABF3 if the rope is not hanging straight down (the
. displacement is not zero).
  $ABEE,$01 Keep the displacement in #REGaf'.
  $ABEF,$01 Fetch the velocity of the end of the rope.
  $ABF0,$02 Return if the rope is at rest (the velocity is zero).
  $ABF2,$01 Fetch the displacement again from #REGaf'.
@ $ABF3 label=Move_Rope_Change_Velocity
N $ABF3 Change the velocity. A negative displacement adds four to it and a
. positive one subtracts four.
  $ABF3,$02,b$01 Keep only bit 7 (the sign of the displacement).
  $ABF5,$02 Jump to #R$AC08 if the displacement is positive.
  $ABF7,$04 Jump to #R$AC02 if the velocity is negative.
  $ABFB,$03 Fetch the tick counter from #R$8ED6.
  $ABFE,$02,b$01 Keep only bits 0 to 2.
  $AC00,$02 Jump to #R$AC17 without changing the velocity if the result is zero
. (once in every eight passes).
@ $AC02 label=Move_Rope_Add_Four
  $AC02,$04 Add four to the velocity, to pull the end of the rope back towards
. the middle.
  $AC06,$02 Jump to #R$AC17.
@ $AC08 label=Move_Rope_Positive_Displacement
  $AC08,$04 Jump to #R$AC13 if the velocity is positive.
  $AC0C,$03 Fetch the low byte of FRAMES.
  $AC0F,$02,b$01 Keep only bits 0 to 2.
  $AC11,$02 Jump to #R$AC17 without changing the velocity if the result is zero
. (once in every eight passes).
@ $AC13 label=Move_Rope_Subtract_Four
  $AC13,$04 Subtract four from the velocity, to pull the end of the rope back
. towards the middle.
@ $AC17 label=Move_Rope_Move_End
N $AC17 Multiply the velocity by #N$20 and add it to the displacement.
  $AC17,$01 Fetch the velocity of the end of the rope.
  $AC18,$01 Test the sign of the velocity.
  $AC19,$02 Clear the high byte of the velocity.
  $AC1B,$03 Jump to #R$AC20 if the velocity is positive.
  $AC1E,$02 Set the high byte of the velocity to #N$FF to extend the sign.
@ $AC20 label=Move_Rope_Sign_Extended
  $AC20,$01 Copy the velocity to #REGe.
  $AC21,$01 Move the velocity (as a word) to #REGhl.
  $AC22,$05 Multiply the velocity by #N$20.
  $AC27,$04 Fetch the displacement (the fraction is in the low byte).
  $AC2B,$01 Add the velocity to the displacement.
  $AC2C,$01 Stash the new displacement on the stack.
  $AC2D,$03 Set the multiplier for the limit of the displacement to #N$00B0.
  $AC30,$03 Fetch the length of the rope.
  $AC33,$04 Halve the length of the rope.
  $AC37,$01 Copy the low byte to #REGa.
  $AC38,$02,b$01 Keep only bits 6 and 7.
  $AC3A,$02 Jump to #R$AC3F if the length is less than #N$80.
  $AC3C,$01 Fetch the new displacement again from the stack.
  $AC3D,$02 Jump to #R$AC59 to store it without a limit.
@ $AC3F label=Move_Rope_Find_Limit
N $AC3F Find the limit of the displacement, which is the length of the rope
. multiplied by #N$B0 and divided by #N$100.
  $AC3F,$03 Fetch the low byte of the length of the rope.
  $AC42,$03 Multiply it by #N$B0.
  $AC45,$01 Copy the high byte of the result (the limit) to #REGa.
  $AC46,$01 Fetch the new displacement again from the stack.
  $AC47,$04 Jump to #R$AC52 if the displacement is negative.
  $AC4B,$03 Jump to #R$AC5D if the displacement is beyond the limit.
  $AC4E,$03 Store the new displacement.
  $AC51,$01 Return.
@ $AC52 label=Move_Rope_Negative_Limit
  $AC52,$02 Make the limit negative.
  $AC54,$03 Jump to #R$AC59 if the displacement is at the limit.
  $AC57,$02 Jump to #R$AC5D if the displacement is beyond the limit.
@ $AC59 label=Move_Rope_Store_Displacement
  $AC59,$03 Store the new displacement.
  $AC5C,$01 Return.
@ $AC5D label=Move_Rope_Beyond_Limit
N $AC5D The displacement is beyond the limit. Set it to the limit and stop the
. swing.
  $AC5D,$03 Set the displacement to the limit.
  $AC60,$07 Clear the fraction of the displacement and the velocity.
  $AC67,$01 Return.

c $AC68 Multiply A By DE
@ $AC68 label=MultiplyAByDE
D $AC68 Multiplies #REGa by #REGde, by adding #REGde to the product for each bit
. of #REGa that is set. The product is a word.
E $AC68 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE0D }
. { #ATICATAC$9AAD }
. { #GUNFRIGHT$D03E }
. { #KNIGHTLORE$D4F9 }
. { #NIGHTSHADE$E0EE }
. { #SABREWULF$BC5A }
. { #TRANZAM$6F2F }
. LIST#
R $AC68 A Multiplier
R $AC68 DE Multiplicand
R $AC68 O:HL Product
  $AC68,$03 Set the product so far to #N$0000.
  $AC6B,$02 Set the number of bits to #N$08.
@ $AC6D label=MultiplyAByDE_Loop
  $AC6D,$01 Double the product.
  $AC6E,$01 Move the next bit of the multiplier into the carry.
  $AC6F,$02 Jump to #R$AC72 if the bit is clear.
  $AC71,$01 Add the multiplicand to the product.
@ $AC72 label=MultiplyAByDE_Next
  $AC72,$02 Decrease the bit counter and loop back until all eight bits of the
. multiplier have been used.
  $AC74,$01 Return.

c $AC75 Divide
@ $AC75 label=Divide
D $AC75 Divides #REGh multiplied by #N$100 by #REGde, one bit at a time. The
. quotient has eight bits, so #REGde must be greater than #REGh for the answer
. to be right. The quotient is built up in the shadow registers and the working
. is done in the main registers, so the shadow registers are not preserved.
.
. The line drawing code uses it to find how far to move across for each pixel
. moved down.
E $AC75 View the equivalent code in;
. #LIST
. { #ATICATAC$A379 }
. LIST#
R $AC75 H Dividend (it is multiplied by #N$100)
R $AC75 DE Divisor
R $AC75 O:HL Quotient
R $AC75 O:DE Remainder
  $AC75,$01 Copy the dividend to #REGl.
  $AC76,$02 Clear #REGh.
  $AC78,$01 Switch to the shadow registers.
  $AC79,$03 #REGhl'=#N$0000 (the quotient so far).
  $AC7C,$02 #REGb'=#N$08 (the number of bits).
@ $AC7E label=Divide_Loop
  $AC7E,$01 Switch to the main registers.
  $AC7F,$06 Shift the dividend left.
  $AC85,$02 Try to subtract the divisor.
  $AC87,$02 Jump to #R$AC95 if it does not go.
  $AC89,$01 Discard the stashed dividend.
  $AC8A,$01 Switch to the shadow registers.
  $AC8B,$01 Shift the quotient left.
  $AC8C,$01 Add one for the bit.
@ $AC8D label=Divide_Next
  $AC8D,$02 Decrease the bit counter and loop back until all eight bits have
. been done.
  $AC8F,$01 Stash the quotient on the stack.
  $AC90,$01 Switch to the main registers.
  $AC91,$01 Copy the remainder to #REGde.
  $AC92,$01 Copy #REGh to #REGd.
  $AC93,$01 Restore #REGhl from the stack.
  $AC94,$01 Restore the quotient from the stack.
@ $AC95 label=Divide_Restore
  $AC95,$01 Restore the stashed dividend (the subtraction is undone).
  $AC96,$01 Switch to the shadow registers.
  $AC97,$01 Shift the quotient left.
  $AC98,$02 Jump to #R$AC8D.

c $AC9A Plot Pixel
@ $AC9A label=Plot_Pixel
D $AC9A Plots a pixel in the display file by combining it with the byte that is
. already there using XOR, so plotting the same pixel again erases it. Nothing
. is plotted when the address is not in the display file (when the high byte is
. #N$58 or more).
.
. The pixel within the byte is bit #N$07 less the lowest three bits of the x
. position.
R $AC9A HL Display file address
R $AC9A C x position (only the lowest three bits are used)
  $AC9A,$01 Fetch the high byte of the address.
  $AC9B,$03 Return if it is not in the display file.
  $AC9E,$01 Fetch the x position.
  $AC9F,$02,b$01 Keep only the lowest three bits.
  $ACA1,$01 Add one to make the number of rotations.
  $ACA2,$01 Store the number in #REGb.
  $ACA3,$01 Start with an empty byte.
  $ACA4,$01 Set the carry flag, which is the pixel.
@ $ACA5 label=Plot_Pixel_Rotate_Loop
  $ACA5,$01 Rotate the pixel along the byte.
  $ACA6,$02 Decrease the rotation counter and loop back until the pixel is in
. the right place.
  $ACA8,$01 Combine the pixel with the display file byte using XOR.
  $ACA9,$01 Write the result back to the display file.
  $ACAA,$01 Return.

c $ACAB Set Up Line
@ $ACAB label=Set_Up_Line
D $ACAB Works out what is needed to draw a line that goes up the screen from the
. first point (the start) to the second point, one pixel row at a time. The
. number of steps is the difference between the y positions, and the amount that
. the x position changes for each step is the difference between the x positions
. multiplied by #N$100 and divided by the number of steps (see #R$AC75).
.
. The step count is stored in #R$AA93 and the direction flags in #R$AA94 (see
. there). The slope is made negative when the line goes to the left, and it is
. halved once for each room that the rope is long (the high byte of the length
. multiplied by two), which scales it to the length of the rope.
R $ACAB HL Start of the line (x position in #REGl, y position in #REGh)
R $ACAB DE End of the line (#REGe is the x position and #REGd is the y position)
R $ACAB O:A Low byte of the slope
R $ACAB O:B Number of steps
R $ACAB O:C Direction of the y position (#N$01 or #N$FF)
R $ACAB O:DE Slope (x position change per step, multiplied by #N$100)
R $ACAB O:HL Start of the line
N $ACAB Find the difference between the y positions (in #REGb) and between the x
. positions, and the direction flags.
  $ACAB,$02 Clear the direction flags.
  $ACAD,$01 Fetch the y position of the start.
  $ACAE,$03 Jump to #R$ACB5 if the difference is positive.
  $ACB1,$02 Make the difference positive.
  $ACB3,$02 Set bit 0 of the direction flags.
@ $ACB5 label=Set_Up_Line_Store_Y_Difference
  $ACB5,$01 Copy the difference to #REGb.
  $ACB6,$01 Fetch the x position of the start.
  $ACB7,$03 Jump to #R$ACBE if the difference is positive.
  $ACBA,$02 Make the difference positive.
  $ACBC,$02 Set bit 1 of the direction flags.
@ $ACBE label=Set_Up_Line_Store_X_Difference
  $ACBE,$01 Stash the difference between the x positions in #REGaf'.
  $ACBF,$01 Fetch the direction flags.
  $ACC0,$03 Store the direction flags.
  $ACC3,$01 Fetch the difference between the y positions.
  $ACC4,$03 Store the number of steps.
  $ACC7,$01 Restore the difference between the x positions from #REGaf'.
N $ACC8 Divide the difference between the x positions by the number of steps.
  $ACC8,$01 Stash the start of the line on the stack.
  $ACC9,$01 Copy the number of steps to #REGe.
  $ACCA,$02 Make #REGd zero.
  $ACCC,$01 Clear #REGl.
  $ACCD,$01 Copy the difference between the x positions to #REGh.
  $ACCE,$03 Divide the difference by the number of steps (the result is the
. slope).
  $ACD1,$03 Fetch the direction flags.
  $ACD4,$04 Jump to #R$ACDB if bit 1 is set (the line goes to the
. right).
  $ACD8,$03 Make the slope negative.
@ $ACDB label=Set_Up_Line_Check_Vertical_Direction
  $ACDB,$03 Fetch the direction flags.
  $ACDE,$02 Test bit 0 of the direction flags.
  $ACE0,$02 Set the vertical step of the line to #N$01.
  $ACE2,$02 Jump to #R$ACE6 if bit 0 is set.
  $ACE4,$02 Set the vertical step of the line to #N$FF.
@ $ACE6 label=Set_Up_Line_Store_Slope
  $ACE6,$01 Move the slope to #REGde and the remainder to #REGhl.
  $ACE7,$01 Restore the start of the line from the stack.
  $ACE8,$03 Fetch the number of steps.
  $ACEB,$01 Copy it to #REGb.
  $ACEC,$01 Stash the number of steps and the direction on the stack.
N $ACED Halve the slope once for each room that the rope is long.
  $ACED,$04 Fetch the length of the rope.
  $ACF1,$04 Double the length.
  $ACF5,$01 Copy the high byte to #REGa.
  $ACF6,$03 Jump to #R$ACFF if the rope is not longer than a room.
@ $ACF9 label=Set_Up_Line_Halve_Slope_Loop
  $ACF9,$04 Halve the slope.
  $ACFD,$02 Decrease the room counter and loop back until the slope has been
. halved for each room.
@ $ACFF label=Set_Up_Line_Finish
  $ACFF,$01 Restore the number of steps and the direction from the stack.
  $AD00,$01 Copy the low byte of the slope to #REGa.
  $AD01,$01 Return.

c $AD02 Draw Line
@ $AD02 label=Draw_Line
D $AD02 Draws two lines at the same time, both going up the screen. The main
. registers hold the start and the end of the first line, and the shadow
. registers hold the start and the end of the second line. The rope uses it to
. erase the old rope and draw the new one in the same pass (see #R$AB54), as
. every pixel is plotted with XOR.
.
. Each line is set up with #R$ACAB. The two lines are drawn together, one step
. each at a time, until one of them is finished, and then the other is finished
. on its own. Each step is the plotting of a pixel with #R$AC9A, a move of the x
. position by the slope and a move up by one pixel line with #R$AE71.
.
. When the object is the rope (type #N$17) and bit 0 of its redraw flags is
. clear, the lines are limited to one step each, and the flag is reset.
.
. At the end the attribute of every cell that the line goes through is set to
. #N$47 (white ink on black paper), starting at a cell near the end of the rope
. and moving up by one cell for each eight steps.
R $AD02 HL Start of the first line
R $AD02 DE End of the first line
R $AD02 HL' Start of the second line
R $AD02 DE' End of the second line
R $AD02 IX Object record
N $AD02 Set up the second line (the shadow registers) and then the first line
. (the main registers). The fractions of the lines are kept in #R$AAA1 and
. #R$AAA0.
  $AD02,$01 Stash the start of the first line on the stack.
  $AD03,$01 Stash the end of the first line on the stack.
  $AD04,$01 Switch to the shadow registers.
  $AD05,$03 Set up the second line.
  $AD08,$03 Store the low byte of the slope as the fraction of the second line.
  $AD0B,$01 Copy the x position of the start to #REGc.
  $AD0C,$03 Get the display file address of the start.
  $AD0F,$01 Switch to the main registers.
  $AD10,$01 Restore the end of the first line from the stack.
  $AD11,$01 Restore the start of the first line from the stack.
  $AD12,$01 Switch to the shadow registers.
  $AD13,$01 Stash the display file address of the second line on the stack.
  $AD14,$01 Stash the slope of the second line on the stack.
  $AD15,$01 Stash the steps of the second line on the stack.
  $AD16,$01 Switch to the main registers.
  $AD17,$03 Set up the first line.
  $AD1A,$03 Store the low byte of the slope as the fraction of the first line.
  $AD1D,$01 Copy the x position of the start to #REGc.
  $AD1E,$03 Get the display file address of the start.
  $AD21,$01 Switch to the shadow registers.
  $AD22,$01 Restore the steps of the second line from the stack.
  $AD23,$01 Restore the slope of the second line from the stack.
  $AD24,$01 Restore the display file address of the second line from the stack.
N $AD25 For the rope, limit both lines to one step unless bit 0 of the redraw
. flags is set. Then reset that bit.
  $AD25,$03 Fetch the sprite id.
  $AD28,$04 Jump to #R$AD3C if the object is not the rope.
  $AD2C,$06 Jump to #R$AD38 if bit 0 of the redraw flags is set.
  $AD32,$02 Limit the second line to one step.
  $AD34,$01 Switch to the main registers.
  $AD35,$02 Limit the first line to one step.
  $AD37,$01 Switch to the shadow registers.
@ $AD38 label=Draw_Line_Reset_Redraw_Flag
  $AD38,$04 Reset bit 0 of the redraw flags.
@ $AD3C label=Draw_Line_Step_Loop
N $AD3C Draw a step of each line in turn, until one of the lines has ended.
  $AD3C,$03 Draw a step of the second line.
  $AD3F,$01 Switch to the main registers.
  $AD40,$01 Stash the steps and the direction of the first line on the stack.
  $AD41,$03 Plot a pixel of the first line.
  $AD44,$02 Stash the high byte of the display file address in #REGaf'.
  $AD46,$03 Fetch the fraction of the first line.
  $AD49,$01 Copy the x position to #REGh.
  $AD4A,$01 Stash the low byte of the display file address in #REGb.
  $AD4B,$01 Copy the fraction to #REGl.
  $AD4C,$01 Add the slope to the x position and the fraction.
  $AD4D,$01 Copy the new fraction to #REGa.
  $AD4E,$03 Store it as the fraction of the first line.
  $AD51,$01 Copy the new x position to #REGc.
  $AD52,$01 Restore the low byte of the display file address.
  $AD53,$02,b$01 Keep only the row bits of the low byte.
  $AD55,$01 Store them in #REGb.
  $AD56,$01 Copy the new x position to #REGa.
  $AD57,$03 Divide the x position by #N$08.
  $AD5A,$02,b$01 Keep only five bits to make the column.
  $AD5C,$01 Combine the row bits with the column.
  $AD5D,$01 Store the new low byte of the display file address in #REGl.
  $AD5E,$01 Copy the new x position to #REGa.
  $AD5F,$01 Restore the steps and the direction of the first line from the
. stack.
  $AD60,$01 Store the new x position in #REGc.
  $AD61,$02 Restore the high byte of the display file address and store it in
. #REGh.
  $AD63,$03 Move up a pixel line.
  $AD66,$03 Jump to #R$AD75 if the first line has ended.
  $AD69,$01 Switch to the shadow registers.
  $AD6A,$02 Jump to #R$AD3C until the second line has ended.
N $AD6C The second line has ended first, so the remaining steps of the first
. line are drawn with its fraction in #R$AAA1.
  $AD6C,$03 Fetch the fraction of the first line.
  $AD6F,$03 Store it as the fraction used by #R$ADB0.
  $AD72,$01 Switch to the main registers.
  $AD73,$02 Jump to #R$AD79.
@ $AD75 label=Draw_Line_First_Line_Ended
N $AD75 The first line has ended first. Draw the remaining steps of the second
. line.
  $AD75,$01 Switch to the shadow registers.
  $AD76,$03 Jump to #R$AD7E if the second line has ended as well.
@ $AD79 label=Draw_Line_Finish_Line_Loop
  $AD79,$03 Draw a step of the line.
  $AD7C,$02 Repeat until the line has ended.
@ $AD7E label=Draw_Line_Set_Attributes
N $AD7E Set the attributes of the cells that the line goes through.
  $AD7E,$01 Move the slope to #REGhl.
  $AD7F,$03 #REGde=#N$2000 (one row of attribute cells, in the high byte).
  $AD82,$03 Subtract #N$2000 from the slope.
  $AD85,$01 Store the result in #REGde.
  $AD86,$03 Fetch the position of the end of the rope.
  $AD89,$04 Move the x position on by four pixels.
  $AD8D,$03 Get the attribute address of the position.
  $AD90,$02 Clear the fraction in #REGaf'.
  $AD92,$03 Fetch the number of steps.
  $AD95,$03 Divide the number of steps by eight.
  $AD98,$02,b$01 Keep only five bits to make the number of cells.
  $AD9A,$01 Return if there are no cells.
  $AD9B,$01 Copy the number of cells to #REGb.
@ $AD9C label=Draw_Line_Attribute_Loop
  $AD9C,$02 Set the attribute to #N$47 (white ink on black paper).
  $AD9E,$01 Stash the high byte of the attribute address in #REGc.
  $AD9F,$01 Copy the low byte to #REGh.
  $ADA0,$01 Restore the fraction from #REGaf'.
  $ADA1,$01 Copy it to #REGl.
  $ADA2,$01 Move the position by the slope and up by one row of cells.
  $ADA3,$01 Copy the new fraction to #REGa.
  $ADA4,$01 Stash it, with the carry flag, on the stack.
  $ADA5,$01 Keep the new fraction in #REGaf'.
  $ADA6,$01 Restore the carry flag from the stack.
  $ADA7,$01 Copy the new low byte of the attribute address to #REGl.
  $ADA8,$01 Fetch the stashed high byte of the attribute address.
  $ADA9,$01 Invert the carry flag.
  $ADAA,$02 Subtract the carry from the high byte, in case the address has
. crossed into another third of the screen.
  $ADAC,$01 Store it as the high byte of the attribute address.
  $ADAD,$02 Decrease the cell counter and loop back until all of the cells have
. been done.
  $ADAF,$01 Return.

c $ADB0 Draw Line Step
@ $ADB0 label=Draw_Line_Step
D $ADB0 Draws one step of a line. It plots a pixel with #R$AC9A, adds the slope
. in #REGde and the fraction in #R$AAA1 to the x position, and moves the display
. file address across by the new x position and up by one pixel line.
R $ADB0 HL Display file address
R $ADB0 C x position
R $ADB0 DE Slope
R $ADB0 O:HL New display file address
R $ADB0 O:C New x position
  $ADB0,$01 Stash the steps and the direction on the stack.
  $ADB1,$03 Plot a pixel.
  $ADB4,$02 Stash the high byte of the display file address in #REGaf'.
  $ADB6,$03 Fetch the fraction of the line.
  $ADB9,$01 Copy the x position to #REGh.
  $ADBA,$01 Stash the low byte of the display file address in #REGb.
  $ADBB,$01 Copy the fraction to #REGl.
  $ADBC,$01 Add the slope to the x position and the fraction.
  $ADBD,$01 Copy the new fraction to #REGa.
  $ADBE,$03 Store it as the fraction of the line.
  $ADC1,$01 Copy the new x position to #REGc.
  $ADC2,$01 Restore the low byte of the display file address.
  $ADC3,$02,b$01 Keep only the row bits of the low byte.
  $ADC5,$01 Store them in #REGb.
  $ADC6,$01 Copy the new x position to #REGa.
  $ADC7,$03 Divide the x position by #N$08.
  $ADCA,$02,b$01 Keep only five bits to make the column.
  $ADCC,$01 Combine the row bits with the column.
  $ADCD,$01 Store the new low byte of the display file address in #REGl.
  $ADCE,$01 Copy the new x position to #REGa.
  $ADCF,$01 Restore the steps and the direction from the stack.
  $ADD0,$01 Store the new x position in #REGc.
  $ADD1,$02 Restore the high byte of the display file address and store it in
. #REGh.
  $ADD3,$03 Jump to #R$AE71 to move up a pixel line.

c $ADD6 Negate HL
@ $ADD6 label=NegateHL
D $ADD6 Makes #REGhl negative by subtracting it from zero. #REGde is not
. changed.
E $ADD6 View the equivalent code in;
. #LIST
. { #ATICATAC$A39E }
. { #TRANZAM$6BF6 }
. LIST#
R $ADD6 HL Number
R $ADD6 O:HL Zero less the number
  $ADD6,$01 Stash #REGde on the stack.
  $ADD7,$01 Move the number to #REGde.
  $ADD8,$03 #REGhl=#N$0000.
  $ADDB,$03 Subtract the number from zero.
  $ADDE,$01 Restore #REGde from the stack.
  $ADDF,$01 Return.

c $ADE0 Calculate Attribute Address
@ $ADE0 label=AttributeAddress
D $ADE0 Converts a pixel position into the address of the matching cell of
. the attribute buffer.
E $ADE0 View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #COOKIE$7534 }
. { #JETPAC$720E }
. { #LUNARJETMAN$8506 }
. { #MARTIANOIDS$BD6A }
. { #PSSST$748F }
. { #SABREWULF$B8DD }
. { #TRANZAM$7097 }
. LIST#
R $ADE0 HL Position (#REGl is the x position, #REGh is the y position)
R $ADE0 O:HL Attribute buffer address
  $ADE0,$01 Stash #REGbc on the stack.
  $ADE1,$01 Fetch the x position.
  $ADE2,$03 Divide it by #N$08.
  $ADE5,$02 Keep only five bits.
  $ADE7,$01 Store the column in #REGl.
  $ADE8,$01 Fetch the y position.
  $ADE9,$02 Multiply it by #N$04.
  $ADEB,$01 Store the result in #REGc.
  $ADEC,$02 Keep only the bits that give the low part of the row.
  $ADEE,$01 Combine them with the column.
  $ADEF,$01 Store the low byte of the address in #REGl.
  $ADF0,$01 Fetch the multiplied y position.
  $ADF1,$02 Keep only the bits that give the high part of the row.
  $ADF3,$02 Add the start of the attribute buffer.
  $ADF5,$01 Store the high byte of the address in #REGh.
  $ADF6,$01 Restore #REGbc from the stack.
  $ADF7,$01 Return.

c $ADF8 Calculate Screen Address
@ $ADF8 label=ScreenAddress
D $ADF8 Converts a pixel position into the address of the matching byte of
. the display file.
E $ADF8 View the equivalent code in;
. #LIST
. { #ATICATAC$9BA2 }
. { #COOKIE$76E3 }
. { #JETPAC$7308 }
. { #LUNARJETMAN$851E }
. { #PSSST$759A }
. { #SABREWULF$B8AD }
. { #TRANZAM$6F10 }
. LIST#
R $ADF8 HL Position (#REGl is the x position, #REGh is the y position)
R $ADF8 O:HL Display file address
  $ADF8,$01 Fetch the x position.
  $ADF9,$03 Divide it by #N$08.
  $ADFC,$02 Keep only five bits.
  $ADFE,$01 Store the column in #REGl.
  $ADFF,$01 Fetch the y position.
  $AE00,$02 Multiply it by #N$04.
  $AE02,$02 Keep only the bits that give the character row within a third.
  $AE04,$01 Combine them with the column.
  $AE05,$01 Store the low byte of the address in #REGl.
  $AE06,$01 Fetch the y position.
  $AE07,$02 Keep only the pixel line within the character.
  $AE09,$01 Stash the line in #REGaf'.
  $AE0A,$01 Fetch the y position.
  $AE0B,$03 Divide it by #N$08.
  $AE0E,$02 Keep only the bits that give the third of the screen.
  $AE10,$02 Add the start of the display file.
  $AE12,$01 Store the result in #REGh.
  $AE13,$01 Retrieve the pixel line from #REGaf'.
  $AE14,$01 Combine it with the high byte of the address.
  $AE15,$01 Store the high byte of the address in #REGh.
  $AE16,$01 Return.

c $AE17 Read Controls
@ $AE17 label=ReadControls
D $AE17 Reads the controls that were chosen on the game selection screen (see
. #R$8ED5). A bit is reset when its control is used: bit 0 is right, bit 1 is
. left, bit 2 is down, bit 3 is up and bit 4 is fire. The keyboard uses W, Q, E,
. R and T.
.
. Bit 5 is reset when a key from the bottom row of the keyboard (CAPS SHIFT, Z,
. X, C or V) is pressed, whichever control method is in use.
.
. The cursor keys and the Interface II joystick are read by #R$EE00 and #R$EE29.
. The Kempston joystick is read directly.
E $AE17 View the equivalent code in;
. #LIST
. { #ATICATAC$93BE }
. { #COOKIE$6FB4 }
. LIST#
R $AE17 O:A The state of the controls
R $AE17 O:B The state of the controls
N $AE17 Pick the routine for the control method.
  $AE17,$03 Fetch the control method from #R$8ED5.
  $AE1A,$02,b$01 Keep only the control method bits (bits 0 and 1).
  $AE1C,$02 Jump to #R$AE3D if the keyboard is being used.
  $AE1E,$05 Jump to #R$EE00 if the cursor keys are being used.
  $AE23,$05 Jump to #R$EE29 if the Interface II joystick is being used.
N $AE28 Read the Kempston joystick.
  $AE28,$02 Read the Kempston joystick.
  $AE2A,$01 Flip the bits, so that a reset bit is a direction or fire which is
. used.
  $AE2B,$01 Store the state of the controls in #REGb.
@ $AE2C label=ReadControls_Bottom_Row
N $AE2C Read the bottom row of the keyboard, which sets bit 5 whichever control
. method is being used.
  $AE2C,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | CAPS SHIFT | Z | X | C | V }
. TABLE#
  $AE32,$01 Flip the bits so that a pressed key gives a set bit.
  $AE33,$02,b$01 Keep only the five keys.
  $AE35,$02 Set bit 5 of the controls.
  $AE37,$02 Jump to #R$AE3B if none of those keys is pressed.
  $AE39,$02 Reset bit 5 of the controls.
@ $AE3B label=ReadControls_Fetch_State
  $AE3B,$01 Fetch the state of the controls.
  $AE3C,$01 Return.
@ $AE3D label=ReadControls_Keyboard
N $AE3D Read the keyboard controls.
  $AE3D,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FB | Q | W | E | R | T }
. TABLE#
  $AE43,$01 Stash the state of the keys in #REGc.
  $AE44,$01 Move bit 1 (W) into bit 0.
  $AE45,$02,b$01 Keep only that bit (right).
  $AE47,$01 Store it in #REGb.
  $AE48,$01 Fetch the state of the keys.
  $AE49,$01 Move bit 0 (Q) into bit 1.
  $AE4A,$02,b$01 Keep only that bit (left).
  $AE4C,$01 Combine it with right.
  $AE4D,$01 Store the result in #REGb.
  $AE4E,$01 Fetch the state of the keys.
  $AE4F,$02,b$01 Keep only bits 2 to 4 (E, R and T: down, up and fire).
  $AE51,$01 Combine them with right and left.
  $AE52,$01 Store the result in #REGb.
  $AE53,$03 Jump to #R$AE2C to read the bottom row of the keyboard.

c $AE56 Calculate Square Root
@ $AE56 label=Calculate_Square_Root
D $AE56 Calculates the square root of a 16-bit number, rounded down. It works
. eight times through, taking two bits of the number each time.
R $AE56 HL Number
R $AE56 O:L Square root (#REGh is not meaningful)
  $AE56,$03 Set up the trial value: #REGd builds up the root and #REGe is #N$40.
  $AE59,$01 Copy the low byte of the number to #REGa.
  $AE5A,$01 Copy the high byte of the number to #REGl.
  $AE5B,$01 Clear #REGh.
  $AE5C,$02 Set a counter in #REGb for eight bits of the root.
  $AE5E,$01 Clear the carry flag.
@ $AE5F label=Calculate_Square_Root_Loop
  $AE5F,$02 Subtract the trial value (the root so far and #N$40) from the
. remainder.
  $AE61,$02 Jump to #R$AE64 if it fitted.
  $AE63,$01 Otherwise restore the remainder.
@ $AE64 label=Calculate_Square_Root_Fitted
  $AE64,$01 Invert the carry flag, so that it is set if the trial value fitted.
  $AE65,$02 Shift the new bit into the root.
  $AE67,$01 Shift the next bit of the number out of #REGa.
  $AE68,$02 Shift it into the remainder.
  $AE6A,$01 Shift the next bit of the number out of #REGa.
  $AE6B,$02 Shift it into the remainder.
  $AE6D,$02 Decrease the bit counter and loop back until all eight bits of the
. root have been found.
  $AE6F,$01 Copy the root to #REGl.
  $AE70,$01 Return.

c $AE71 Screen Address One Pixel Above
@ $AE71 label=ScreenPosition1PixelAbove
D $AE71 Moves a display file address up by one pixel line.
E $AE71 View the equivalent code in;
. #LIST
. { #ATICATAC$9F03 }
. { #LUNARJETMAN$85F6 }
. { #PSSST$7585 }
. { #TRANZAM$6ECB }
. LIST#
R $AE71 HL Display file address
R $AE71 O:HL Display file address of the line above
  $AE71,$01 Move up a pixel line.
  $AE72,$01 Copy #REGh to #REGa.
  $AE73,$01 Flip all of the bits.
  $AE74,$02 Keep only the line number within the character.
  $AE76,$01 Return if a character boundary has not been crossed.
  $AE77,$01 Copy #REGl to #REGa.
  $AE78,$02 Move up a character row.
  $AE7A,$01 Store the result in #REGl.
  $AE7B,$01 Return if the subtraction borrowed.
  $AE7C,$01 Copy #REGh to #REGa.
  $AE7D,$02 Add #N$08.
  $AE7F,$01 Store the result in #REGh.
  $AE80,$01 Return.

c $AE81 Set Up Rope
@ $AE81 label=Set_Up_Rope
D $AE81 Sets up the rope for the room that has just been drawn, using the map
. entry of the room (see #R$98CC). Bit 3 of the second byte says whether the
. room has a rope.
.
. The rope is the object in record 3 (type #N$17).
.
. The length of the rope is stored in #R$AAA5. It is half of the sum of #N$FF
. (or #N$A0 if bit 2 is reset) and #N$100 times the two low bits of the second
. byte.
  $AE81,$03 Read the world map entry of the room into #REGde.
  $AE84,$01 Copy the room flags to #REGa.
  $AE85,$03 Store the room flags in #R$AAAC.
  $AE88,$04 Clear the displacement of the end of the rope in pixels (#R$AAA4).
  $AE8C,$03 Clear the fraction of the displacement of the end of the rope
. (#R$AAA3).
  $AE8F,$04 Jump to #R$AEB0 if there is no rope in this room (bit 3 of the
. second byte of the world map entry is clear).
  $AE93,$02 Use the type of the rope (#N$17).
  $AE95,$03 Store it as the type of record 3 (the rope).
  $AE98,$06 Clear the previous position of the end of the rope (#R$AA97).
  $AE9E,$04 Jump to #R$AEB5 if the rope is a short one (bit 2 of the second byte
. of the world map entry is clear).
  $AEA2,$02 Set the low byte of the length of a long rope to #N$FF.
@ $AEA4 label=Set_Up_Rope_Fetch_Second_Byte
  $AEA4,$01 Fetch the second byte of the world map entry.
  $AEA5,$02,b$01 Keep only the two low bits (the number of rooms down the rope).
  $AEA7,$01 Store them in the high byte of the length.
  $AEA8,$04 Halve the length of the rope.
  $AEAC,$03 Store the length of the rope in #R$AAA5.
  $AEAF,$01 Return.
@ $AEB0 label=Set_Up_Rope_Remove_Rope
  $AEB0,$04 Remove the rope by clearing the type of record 3.
  $AEB4,$01 Return.
@ $AEB5 label=Set_Up_Rope_Set_Length
  $AEB5,$02 Set the low byte of the length of a short rope to #N$A0.
  $AEB7,$02 Jump to #R$AEA4.

c $AEB9 Handle Plant
@ $AEB9 label=Handle_Plant
D $AEB9 Handler for the object types #N$1C to #N$2B, the plants (mushrooms,
. pods, flytraps, weeds and bellflowers) that stand in some of the rooms. Each
. plant has two frames, and bit 0 of its type picks the frame.
.
. A plant is set up the first time that it is handled after its room has been
. drawn (see #R$AF12). After that it makes Sabreman tumble if he touches it, by
. setting bit 7 of his redraw flags (see #R$A406).
R $AEB9 IX Object record
  $AEB9,$06 Jump to #R$AF12 if the plant has just been created (bit 0 of the
. redraw flags is set).
  $AEBF,$03 Save the state of the plant (see #R$989F).
N $AEC2 Remove the plant if Sabreman is not in the same room.
  $AEC2,$03 Fetch the room x of Sabreman.
  $AEC5,$05 Jump to #R$AF0D if the plant is not in the same room x.
  $AECA,$03 Fetch the room y of Sabreman.
  $AECD,$05 Jump to #R$AF0D if the plant is not in the same room y.
N $AED2 See if Sabreman is touching the plant.
  $AED2,$03 Fetch the y position of Sabreman.
  $AED5,$03 Subtract the y position of the plant.
  $AED8,$04 Jump to #R$AEF5 if Sabreman is #N$14 or more pixels below the plant,
. or above it.
  $AEDC,$03 Fetch the x position of Sabreman.
  $AEDF,$03 Subtract the x position of the plant.
  $AEE2,$02 Subtract #N$04 to allow for the difference between the widths of the
. sprites.
  $AEE4,$03 Jump to #R$AEE9 if the difference is positive.
  $AEE7,$02 Make the difference positive.
@ $AEE9 label=Handle_Plant_Test_Width
  $AEE9,$04 Jump to #R$AEF5 if Sabreman is #N$14 or more pixels away from the
. plant sideways.
  $AEED,$03 Fetch the redraw flags of Sabreman.
  $AEF0,$02,b$01 Set bit 7, which makes him tumble.
  $AEF2,$03 Store the redraw flags of Sabreman.
@ $AEF5 label=Handle_Plant_Animate
N $AEF5 Choose the frame of the plant from bit 3 of a counter.
  $AEF5,$03 Add one to the animation counter of the plant.
  $AEF8,$03 Fetch the animation counter of the plant.
  $AEFB,$03 Shift bit 3 of the counter into bit 0 (rotate right three times).
  $AEFE,$02,b$01 Keep only the bit.
  $AF00,$01 Keep the frame number in #REGb.
  $AF01,$03 Fetch the type of the plant.
  $AF04,$02,b$01 Clear bit 0 of the type of the plant.
  $AF06,$01 Add the frame number to make the new type.
  $AF07,$03 Store the new type.
  $AF0A,$03 Jump to #R$96CB.
@ $AF0D label=Handle_Plant_Remove
  $AF0D,$04 Remove the plant by setting its type to zero.
  $AF11,$01 Return.
@ $AF12 label=Handle_Plant_Set_Up
N $AF12 Set up a new plant. Its type depends on its x position and on the room,
. and it takes its room from Sabreman.
  $AF12,$03 Fetch the room x of Sabreman.
  $AF15,$03 Store it as the room x of the plant.
  $AF18,$03 Fetch the room y of Sabreman.
  $AF1B,$03 Store it as the room y of the plant.
  $AF1E,$04 Set the attribute to #N$45 (bright cyan).
  $AF22,$03 Fetch the x position of the plant.
  $AF25,$02 Divide it by four.
  $AF27,$03 Add the room x.
  $AF2A,$02,b$01 Keep only bits 1 to 3, so that the type is even.
  $AF2C,$02 Add #N$1C, the first type of a plant.
  $AF2E,$03 Store it as the type of the plant.
  $AF31,$03 Store it as the animation counter of the plant.
  $AF34,$01 Divide the type by two.
  $AF35,$02,b$01 Keep only two bits.
  $AF37,$02 Add #N$42 to make a bright attribute.
  $AF39,$03 Store it as the attribute of the plant.
  $AF3C,$03 Jump to #R$96CB.

c $AF3F Handle Static Object
@ $AF3F label=Handle_Static_Object
D $AF3F Handler for the object types #N$2C to #N$2F (rocks) and #N$54 (spikes).
. These objects never move, so the sprite is only drawn when the room is drawn.
. On every other pass the routine just sets the attributes again (see #R$9867).
.
. An object of type #N$54 also lets out a bubble now and then (see #R$E0A9).
R $AF3F IX Object record
  $AF3F,$06 Jump to #R$AF53 if the object has just been created (bit 0 of the
. redraw flags is set).
  $AF45,$03 Fetch the type of the object.
  $AF48,$05 Call #R$E0A9 to let out a bubble if the type is #N$54.
  $AF4D,$03 Prepare the sprite of the object.
  $AF50,$03 Jump to #R$9867.
@ $AF53 label=Handle_Static_Object_Draw
  $AF53,$03 Jump to #R$96CB.

c $AF56 Set Up Room Objects
@ $AF56 label=Set_Up_Room_Objects
D $AF56 Sets up the objects of a room that is in the lower part of the map (the
. room y is #N$10 or more) when the room is drawn.
.
. The two decoration records that start at #R$8F9A are emptied. The two
. before them are emptied too, unless they hold a bubble. What happens next
. depends on the first byte of the world map entry of the room (see #R$99F5).
.
. A room with both a ceiling and a floor gets a plant and a rock. Their x
. positions come from the table at #R$B757, and the rock is one of the
. four templates at #R$B76B.
.
. A room with no floor gets the objects that are set up by #R$E6EE. A room with
. a floor but no ceiling gets the two objects of type #N$54 that start at
. #R$B7AB.
  $AF56,$03 Read the world map entry of the room. The flags of the room are
. returned in #REGe.
  $AF59,$04 Clear the type of the first room object record (#R$8F9A).
  $AF5D,$03 Clear the type of the second room object record (#R$8FAA).
  $AF60,$03 Fetch the type of the record at #R$8F7A.
  $AF63,$02,b$01 Ignore the low two bits.
  $AF65,$04 Jump to #R$AF6D if the record holds a bubble (#N$58 to #N$5B).
  $AF69,$04 Write #N$00 to the type of the record at #R$8F7A.
@ $AF6D label=Set_Up_Room_Objects_Next_Record
  $AF6D,$03 Fetch the type of the record at #R$8F8A.
  $AF70,$02,b$01 Ignore the low two bits.
  $AF72,$04 Jump to #R$AF7A if the record holds a bubble.
  $AF76,$04 Write #N$00 to the type of the record at #R$8F8A.
@ $AF7A label=Set_Up_Room_Objects_Test_Flags
  $AF7A,$01 Copy the flags of the room to #REGa.
  $AF7B,$02,b$01 Keep only the ceiling bit (bit 0) and the floor bit (bit 4).
  $AF7D,$04 Jump to #R$AFC9 if the room does not have both.
N $AF81 Put a plant and a rock in the room. The x positions come from the table
. at #R$B757, starting at an offset that is the sum of the room
. coordinates, modulo #N$10.
  $AF81,$03 Fetch the room x of Sabreman.
  $AF84,$01 Copy it to #REGl.
  $AF85,$03 Fetch the room y of Sabreman.
  $AF88,$01 Add the room x.
  $AF89,$02 Clear the high byte of the offset.
  $AF8B,$02,b$01 Keep only the low four bits.
  $AF8D,$01 Store the offset in #REGl.
  $AF8E,$03 Point at the table of x positions (#R$B757).
  $AF91,$01 Add the offset.
  $AF92,$01 Move the table address to #REGde.
  $AF93,$03 Point at the x position of the record (#R$8F7B).
  $AF96,$01 Fetch the x position of the plant from the table.
  $AF97,$01 Store it in the record.
  $AF98,$01 Move on to the x position of the rock.
  $AF99,$03 Point at the y position of the record (#R$8F7D).
  $AF9C,$02 Set the y position to #N$9F, which is the floor.
  $AF9E,$03 Point at the type of the record (#R$8F7A).
  $AFA1,$02 Set the type to #N$1C (a plant).
  $AFA3,$03 Point at the redraw flags of the record (#R$8F89).
  $AFA6,$02 Set the redraw flags to #N$01 so that the plant is drawn without
. being erased.
  $AFA8,$01 Stash the table address on the stack.
  $AFA9,$03 Point at the templates of the rocks (#R$B76B).
  $AFAC,$03 Fetch the room x of Sabreman.
  $AFAF,$01 Copy it to #REGc.
  $AFB0,$04 Multiply it by sixteen (rotate left four times).
  $AFB4,$02,b$01 Keep only bits 4 and 5, which pick one of the four templates.
  $AFB6,$01 Store the offset of the template in #REGl.
  $AFB7,$02 Clear the high byte of the offset.
  $AFB9,$01 Add the address of the first template.
  $AFBA,$03 #REGde=#R$8F9A (the first decoration record that is for a
. room object).
  $AFBD,$01 Copy the room x to #REGa (this is not used).
  $AFBE,$03 Set the size of a record to #N$0010.
  $AFC1,$02 Copy the template into the record.
  $AFC3,$01 Restore the table address from the stack.
  $AFC4,$01 Fetch the x position of the rock from the table.
  $AFC5,$03 Store it in the record.
  $AFC8,$01 Return.
@ $AFC9 label=Set_Up_Room_Objects_Test_Floor
  $AFC9,$05 Jump to #R$E6EE if the room has no floor.
N $AFCE The room has a floor but no ceiling.
  $AFCE,$03 #REGhl=#R$B7AB (the templates of the two objects of type
. #N$54).
  $AFD1,$03 #REGde=#R$8F9A (the first decoration record that is for a
. room object).
  $AFD4,$03 Set the size of two records to #N$0020.
  $AFD7,$02 Copy the templates into the two records.
  $AFD9,$01 Return.

c $AFDA Spawn Flying Creature
@ $AFDA label=Spawn_Flying_Creature
D $AFDA Lets a flying creature into the room every now and then. Nothing happens
. unless the sum of the tick counter and the frame counter is a multiple of
. eight.
.
. If one of the four creature records that start at #R$8FDA is free, it
. is filled in with a type that comes from bits 2 and 4 of the tick counter:
. #N$30 (eagle), #N$34 (gargoyle), #N$40 (vulture) or #N$44 (jellyfish). Only
. the vultures and the jellyfish appear until the flag at #R$8EF9 has been set,
. which happens when Sabreman kills a guardian.
.
. The creature starts in a room next to the one that Sabreman is in. It is on
. the left or the right if the room has a gap in that wall (the choice is made
. from bit 0 of the tick counter), and it is above or below otherwise. Its
. position inside the room, and its attribute, come from the frame counter.
.
. #R$B079 then makes the creature fly into the room that Sabreman is in.
  $AFDA,$04 Fetch the tick counter from #R$8ED6 and keep it in #REGb.
  $AFDE,$03 Fetch the low byte of FRAMES.
  $AFE1,$01 Add the tick counter to make a pseudo-random number.
  $AFE2,$02,b$01 Keep only the low three bits.
  $AFE4,$01 Return unless the result is zero (a creature can only appear on one
. pass in eight).
  $AFE5,$03 Point at the first of the four creature records (#R$8FDA).
  $AFE8,$03 Set the size of a record to #N$0010.
  $AFEB,$02 Set the number of records to #N$04.
@ $AFED label=Spawn_Flying_Creature_Find_Record
  $AFED,$01 Fetch the type of the record.
  $AFEE,$03 Jump to #R$AFF5 if the record is not in use (the type is zero).
  $AFF1,$01 Move on to the next record.
  $AFF2,$02 Loop back until all of the records have been tried.
  $AFF4,$01 Return as all of the records are in use.
@ $AFF5 label=Spawn_Flying_Creature_Choose_Type
  $AFF5,$03 Fetch the flags of the room that Sabreman is in.
  $AFF8,$01 Store them in #REGe.
  $AFF9,$03 Fetch the creature spawn flag.
  $AFFC,$01 Test the flag.
  $AFFD,$03 Fetch the tick counter.
  $B000,$02 Jump to #R$B004 if the flag is set.
  $B002,$02,b$01 Set bit 4, which limits the choice to the vulture and the
. jellyfish.
@ $B004 label=Spawn_Flying_Creature_Store_Type
  $B004,$01 Stash the tick counter on the stack.
  $B005,$02,b$01 Keep only bits 2 and 4.
  $B007,$02 Add #N$30 to make the type.
  $B009,$01 Store the type in the record.
  $B00A,$01 Restore the tick counter.
  $B00B,$01 Move on to the x position.
  $B00C,$04 Jump to #R$B03B if bit 0 of the tick counter is set.
N $B010 Bit 0 of the tick counter is reset, so use the right of the room if it
. has no right wall, and the left otherwise.
  $B010,$04 Jump to #R$B043 if the room has no right wall.
  $B014,$04 Jump to #R$B04F if the room has a left wall too.
@ $B018 label=Spawn_Flying_Creature_From_Left
N $B018 The creature comes in from the room on the left.
  $B018,$02,b$01 Keep only the low seven bits of the tick counter.
  $B01A,$02 Add #N$48 to make the x position.
  $B01C,$01 Store the x position.
  $B01D,$01 Move on to the room x.
  $B01E,$03 Fetch the room x of Sabreman.
  $B021,$01 Subtract one to get the room on the left.
@ $B022 label=Spawn_Flying_Creature_Store_Room_X
  $B022,$01 Store the room x.
  $B023,$01 Move on to the y position.
  $B024,$03 Fetch the low byte of the frame counter.
  $B027,$02,b$01 Keep only the low six bits.
  $B029,$02 Add #N$40 to make the y position.
  $B02B,$01 Store the y position.
  $B02C,$01 Move on to the room y.
  $B02D,$03 Fetch the room y of Sabreman.
  $B030,$01 Store it as the room y of the creature.
  $B031,$01 Move on to the attribute.
  $B032,$03 Fetch the low byte of the frame counter.
  $B035,$02,b$01 Keep only the low two bits.
  $B037,$02 Add #N$42 to make a bright attribute.
  $B039,$01 Store the attribute of the creature.
  $B03A,$01 Return.
@ $B03B label=Spawn_Flying_Creature_Test_Left
  $B03B,$04 Jump to #R$B018 if the room has no left wall.
  $B03F,$04 Jump to #R$B04F if the room has a right wall.
@ $B043 label=Spawn_Flying_Creature_From_Right
N $B043 The creature comes in from the room on the right.
  $B043,$02,b$01 Keep only the low six bits of the tick counter.
  $B045,$02 Add #N$40 to make the x position.
  $B047,$01 Store the x position.
  $B048,$01 Move on to the room x.
  $B049,$03 Fetch the room x of Sabreman.
  $B04C,$01 Add one to get the room on the right.
  $B04D,$02 Jump to #R$B022 to store the room x.
@ $B04F label=Spawn_Flying_Creature_Vertically
N $B04F The creature comes in from the room above or below.
  $B04F,$02,b$01 Keep only the low seven bits of the tick counter.
  $B051,$02 Add #N$48 to make the x position.
  $B053,$01 Store the x position.
  $B054,$01 Move on to the room x.
  $B055,$03 Fetch the room x of Sabreman.
  $B058,$01 Store it as the room x of the creature.
  $B059,$01 Move on to the y position.
  $B05A,$03 Fetch the low byte of the frame counter.
  $B05D,$02,b$01 Keep only the low six bits.
  $B05F,$02 Add #N$40 to make the y position.
  $B061,$01 Store the y position.
  $B062,$01 Move on to the room y.
  $B063,$03 Fetch the room y of Sabreman.
  $B066,$04 Jump to #R$B06D if the room has no ceiling.
  $B06A,$01 Add one to get the room below.
  $B06B,$02 Jump to #R$B06E to store the room y.
@ $B06D label=Spawn_Flying_Creature_From_Above
  $B06D,$01 Subtract one to get the room above.
@ $B06E label=Spawn_Flying_Creature_Store_Room_Y
  $B06E,$01 Store the room y.
  $B06F,$01 Move on to the attribute.
  $B070,$03 Fetch the low byte of the frame counter.
  $B073,$02,b$01 Keep only the low two bits.
  $B075,$02 Add #N$42 to make a bright attribute.
  $B077,$01 Store the attribute of the creature.
  $B078,$01 Return.

c $B079 Handle Flying Creature
@ $B079 label=Handle_Flying_Creature
D $B079 Handler for the object types #N$30 to #N$33 (eagles) and #N$40 to #N$43
. (vultures). The creature flies towards Sabreman, bounces off the decorations
. and the bubbles, bounces off the frame of the room and flies out of the room
. through its gaps.
.
. If the creature is in a different room from Sabreman it is moved by #R$B2CF
. (when the room x is different) or by #R$B358 (when the room y is different).
.
. In Sabreman's room, an eagle that is above him and touches him picks him up
. (the type changes to #N$5C and #R$E2CB takes over). Bit 0 of the type is the
. frame of the animation and changes every two ticks, and bit 1 follows the
. direction of the x velocity.
.
. The x velocity and the y velocity (bytes #N$08 and #N$09 of the record) each
. change by two on every call, in the direction of Sabreman, up to a limit of
. #N$40. A thrown weapon destroys the creature (see #R$B3D4). If the creature
. touches Sabreman he is pushed away with an x velocity of #N$03 and tumbles.
.
. The contact flags (byte #N$0B of the record) use the same bits as the flags of
. the room (see #R$9906), and they are combined with those flags in #REGe.
R $B079 IX Object record
  $B079,$03 Read the world map entry of the room that the creature is in. The
. flags of the room are returned in #REGe.
  $B07C,$03 Fetch the contact flags of the creature.
  $B07F,$01 Combine them with the flags of the room.
  $B080,$01 Store the result in #REGe.
  $B081,$03 Fetch the room x of Sabreman.
  $B084,$06 Jump to #R$B2CF if the creature is in a different room x.
  $B08A,$03 Fetch the room y of Sabreman.
  $B08D,$06 Jump to #R$B358 if the creature is in a different room y.
  $B093,$03 Save the state of the creature.
N $B096 Only an eagle that has been drawn and is inside the room can pick up
. Sabreman, and only if he is not hanging on the rope.
  $B096,$03 Fetch the type of the creature.
  $B099,$02,b$01 Ignore the low two bits.
  $B09B,$04 Jump to #R$B0E4 if the creature is not an eagle.
  $B09F,$06 Jump to #R$B0E4 if the creature has just been created.
  $B0A5,$03 Fetch the x position of the creature.
  $B0A8,$04 Jump to #R$B0E4 if the x position is #N$D0 or more.
  $B0AC,$04 Jump to #R$B0E4 if the x position is less than #N$18.
  $B0B0,$03 Fetch the y position of the creature.
  $B0B3,$04 Jump to #R$B0E4 if the y position is #N$A8 or more.
  $B0B7,$04 Jump to #R$B0E4 if the y position is less than #N$41.
  $B0BB,$03 Fetch the type of Sabreman.
  $B0BE,$04 Jump to #R$B0E4 if Sabreman is hanging on the rope (the type is less
. than #N$09).
  $B0C2,$03 Check for contact with Sabreman. Bit 2 of #REGc is set if the
. creature touches him and bit 1 is set if he is above the creature.
  $B0C5,$01 Copy the result to #REGa.
  $B0C6,$02,b$01 Keep only bits 1 and 2.
  $B0C8,$04 Jump to #R$B0E4 unless the creature touches Sabreman and he is not
. above it.
  $B0CC,$01 Disable interrupts while the frame counter is changed.
  $B0CD,$04 Change the type of the creature to #N$5C, which makes it carry
. Sabreman (see #R$E2CB).
  $B0D1,$05 Write #N$40 to the redraw flags of Sabreman (#R$8F29),
. which marks him as being carried (bit 6).
  $B0D6,$03 Fetch the low byte of the frame counter.
  $B0D9,$02,b$01 Set bit 6.
  $B0DB,$03 Store it. The carry ends when this byte next wraps round to zero
. (see #R$E2CB).
  $B0DE,$03 Store it in #R$8EF2 as well, as a non-zero value.
  $B0E1,$03 Jump to #R$E2F0 to carry on as an eagle that carries Sabreman.
@ $B0E4 label=Handle_Flying_Creature_Animate
N $B0E4 Work out the type of the creature. Bit 0 follows bit 1 of the tick
. counter and bit 1 is set when the x velocity is negative.
  $B0E4,$03 Fetch the tick counter.
  $B0E7,$01 Move bit 1 into bit 0.
  $B0E8,$02,b$01 Keep only that bit.
  $B0EA,$01 Keep the frame bit in #REGc.
  $B0EB,$03 Fetch the type of the creature.
  $B0EE,$02,b$01 Clear bit 0.
  $B0F0,$01 Add the frame bit.
  $B0F1,$06 Jump to #R$B0FB if the x velocity is positive.
  $B0F7,$02,b$01 Set bit 1.
  $B0F9,$02 Jump to #R$B0FD.
@ $B0FB label=Handle_Flying_Creature_Clear_Direction
  $B0FB,$02,b$01 Clear bit 1.
@ $B0FD label=Handle_Flying_Creature_Store_Type
  $B0FD,$03 Store the type of the creature.
N $B100 Change the x velocity by two in the direction of Sabreman, up to a limit
. of #N$40 in either direction.
  $B100,$03 Fetch the x position of Sabreman.
  $B103,$03 Subtract the x position of the creature.
  $B106,$03 Fetch the x velocity of the creature.
  $B109,$03 Jump to #R$B218 if Sabreman is on the left of the creature.
  $B10C,$02 Add two to the x velocity.
  $B10E,$04 Jump to #R$B116 if the x velocity is negative.
  $B112,$04 Jump to #R$B119 if the x velocity has reached #N$40.
@ $B116 label=Handle_Flying_Creature_Store_X_Velocity
  $B116,$03 Store the x velocity.
@ $B119 label=Handle_Flying_Creature_Steer_Vertically
N $B119 Do the same with the y velocity.
  $B119,$03 Fetch the y position of Sabreman.
  $B11C,$03 Subtract the y position of the creature.
  $B11F,$03 Fetch the y velocity of the creature.
  $B122,$03 Jump to #R$B227 if Sabreman is above the creature.
  $B125,$02 Add two to the y velocity.
  $B127,$04 Jump to #R$B12F if the y velocity is negative.
  $B12B,$04 Jump to #R$B132 if the y velocity has reached #N$40.
@ $B12F label=Handle_Flying_Creature_Store_Y_Velocity
  $B12F,$03 Store the y velocity.
@ $B132 label=Handle_Flying_Creature_Check_Contact
N $B132 Check for contact with a thrown weapon and with Sabreman. This is also
. the entry point for the jellyfish.
  $B132,$01 Stash the flags of the room on the stack.
  $B133,$06 Jump to #R$B161 if the creature has just been created.
  $B139,$03 Check whether a thrown weapon has hit the creature. #REGd is #N$FF
. if one has.
  $B13C,$01 Copy the result to #REGa.
  $B13D,$04 Jump to #R$B3D4 if a weapon has hit the creature.
  $B141,$03 Check for contact with Sabreman.
  $B144,$04 Jump to #R$B161 if the creature is not touching him.
  $B148,$01 Clear #REGa, which collects the new redraw flags of Sabreman.
  $B149,$02 Test bit 7 of #REGc, which is set when the creature is on the right
. of Sabreman.
  $B14B,$02 Use an x velocity of #N$03 to push Sabreman to the right.
  $B14D,$02 Jump to #R$B153 if the creature is on the left of Sabreman.
  $B14F,$02 Use an x velocity of #N$FD to push Sabreman to the left.
  $B151,$02 Set bit 4 of #REGa.
@ $B153 label=Handle_Flying_Creature_Push_Sabreman
  $B153,$02,b$01 Set bit 3 of #REGa.
  $B155,$01 Copy the new redraw flags to #REGc.
  $B156,$03 Fetch the redraw flags of Sabreman.
  $B159,$01 Combine them with the new bits. Bit 3 makes him tumble (see
. #R$E8A2).
  $B15A,$03 Store the redraw flags of Sabreman.
  $B15D,$01 Copy the x velocity to #REGa.
  $B15E,$03 Store it as the x velocity of Sabreman (#R$8F20).
@ $B161 label=Handle_Flying_Creature_Check_Obstacles
N $B161 Check for contact with the decorations and the bubbles, and bounce off
. them.
  $B161,$03 Check for contact with the decorations. #REGc holds the result.
  $B164,$01 Store the result in #REGd.
  $B165,$03 Check for contact with the bubbles.
  $B168,$01 Copy the result to #REGa.
  $B169,$01 Combine it with the result for the decorations.
  $B16A,$01 Store the combined result in #REGc.
  $B16B,$01 Restore #REGde from the stack.
  $B16C,$04 Jump to #R$B1B9 if the creature is not touching anything.
  $B170,$04 Jump to #R$B18E if the creature is not on top of the object.
  $B174,$04 Jump to #R$B19E if the object is a bubble and the creature is away
. from the middle of it.
  $B178,$03 Fetch the y velocity.
  $B17B,$02 Subtract two.
  $B17D,$03 Jump to #R$B1B9 if the result is negative, as the creature is
. already moving up.
  $B180,$01 Invert the y velocity, to send the creature up.
  $B181,$03 Store the y velocity.
  $B184,$03 Fetch the y position.
  $B187,$02 Subtract two.
  $B189,$03 Store the y position.
  $B18C,$02 Jump to #R$B1B9.
@ $B18E label=Handle_Flying_Creature_Test_Underside
  $B18E,$04 Jump to #R$B19E if the creature is away from the middle of the
. object.
  $B192,$03 Fetch the y velocity.
  $B195,$02 Add two.
  $B197,$03 Jump to #R$B19E if the result is positive, as the creature is
. already moving down.
  $B19A,$01 Invert the y velocity, to send the creature down.
  $B19B,$03 Store the y velocity.
@ $B19E label=Handle_Flying_Creature_Bounce_Sideways
  $B19E,$03 Fetch the x velocity.
  $B1A1,$04 Jump to #R$B1B0 if the creature is on the left of the object.
  $B1A5,$02 Add two.
  $B1A7,$03 Jump to #R$B1B9 if the result is positive, as the creature is
. already moving right.
  $B1AA,$01 Invert the x velocity, to send the creature right.
  $B1AB,$03 Store the x velocity.
  $B1AE,$02 Jump to #R$B1B9.
@ $B1B0 label=Handle_Flying_Creature_Bounce_Left
  $B1B0,$02 Subtract two.
  $B1B2,$03 Jump to #R$B1B9 if the result is negative, as the creature is
. already moving left.
  $B1B5,$01 Invert the x velocity, to send the creature left.
  $B1B6,$03 Store the x velocity.
@ $B1B9 label=Handle_Flying_Creature_Move_Sideways
N $B1B9 Move the creature sideways. Reset bits 0 and 4 of the contact flags
. first.
  $B1B9,$03 Fetch the contact flags.
  $B1BC,$02,b$01 Reset bits 0 and 4.
  $B1BE,$03 Store the contact flags.
  $B1C1,$03 Fetch the x velocity into #REGl.
  $B1C4,$02 Test the sign of the x velocity.
  $B1C6,$02 Clear the high byte of the x velocity (as a word).
  $B1C8,$02 Jump to #R$B1CC if the x velocity is positive.
  $B1CA,$02 Set the high byte of the x velocity to #N$FF to extend the sign.
@ $B1CC label=Handle_Flying_Creature_Add_X_Velocity
  $B1CC,$03 Add the x velocity to the x position (see #R$EE42). #REGa is the new
. x position, and the zero flag is set when it is less than #N$80.
  $B1CF,$03 Jump to #R$B236 if the x position is less than #N$80.
  $B1D2,$04 Jump to #R$B1E4 if the x position is less than #N$D0.
  $B1D6,$05 Jump to #R$B25E if the room has no right wall.
  $B1DB,$03 Fetch the x velocity.
  $B1DE,$01 Invert it, to bounce off the right wall.
  $B1DF,$03 Store the x velocity.
  $B1E2,$02 Set the x position to #N$CF.
@ $B1E4 label=Handle_Flying_Creature_Store_X
  $B1E4,$03 Store the x position.
N $B1E7 Move the creature up or down. Reset bits 2 and 6 of the contact flags
. first.
  $B1E7,$03 Fetch the contact flags.
  $B1EA,$02,b$01 Reset bits 2 and 6.
  $B1EC,$03 Store the contact flags.
  $B1EF,$03 Fetch the y velocity into #REGl.
  $B1F2,$02 Test the sign of the y velocity.
  $B1F4,$02 Clear the high byte of the y velocity (as a word).
  $B1F6,$02 Jump to #R$B1FA if the y velocity is positive.
  $B1F8,$02 Set the high byte of the y velocity to #N$FF to extend the sign.
@ $B1FA label=Handle_Flying_Creature_Add_Y_Velocity
  $B1FA,$03 Add the y velocity to the y position (see #R$EE54). #REGa is the new
. y position, and the zero flag is set when it is less than #N$80.
  $B1FD,$03 Jump to #R$B282 if the y position is less than #N$80.
  $B200,$04 Jump to #R$B212 if the y position is less than #N$9F.
  $B204,$05 Jump to #R$B2AA if the room has no floor.
  $B209,$03 Fetch the y velocity.
  $B20C,$01 Invert it, to bounce off the floor.
  $B20D,$03 Store the y velocity.
  $B210,$02 Set the y position to #N$9F.
@ $B212 label=Handle_Flying_Creature_Store_Y
  $B212,$03 Store the y position.
  $B215,$03 Jump to #R$96CB.
@ $B218 label=Handle_Flying_Creature_Steer_Left
N $B218 Sabreman is on the left of the creature, so subtract two from the x
. velocity, down to a limit of #N$C0.
  $B218,$02 Subtract two from the x velocity.
  $B21A,$05 Jump to #R$B116 if the x velocity is positive.
  $B21F,$05 Jump to #R$B119 if the x velocity is less than #N$C0.
  $B224,$03 Jump to #R$B116.
@ $B227 label=Handle_Flying_Creature_Steer_Up
N $B227 Sabreman is above the creature, so subtract two from the y velocity,
. down to a limit of #N$C0.
  $B227,$02 Subtract two from the y velocity.
  $B229,$05 Jump to #R$B12F if the y velocity is positive.
  $B22E,$05 Jump to #R$B132 if the y velocity is less than #N$C0.
  $B233,$03 Jump to #R$B12F.
@ $B236 label=Handle_Flying_Creature_Test_Left_Edge
N $B236 The x position is less than #N$80. The creature bounces off the left
. wall if there is one, and leaves the room by the gap otherwise.
  $B236,$05 Jump to #R$B1E4 if the x position is #N$18 or more.
  $B23B,$04 Jump to #R$B24B if the room has no left wall.
  $B23F,$03 Fetch the x velocity.
  $B242,$01 Invert it, to bounce off the left wall.
  $B243,$03 Store the x velocity.
  $B246,$02 Set the x position to #N$18.
  $B248,$03 Jump to #R$B1E4.
@ $B24B label=Handle_Flying_Creature_Test_Left_Gap
  $B24B,$04 Jump to #R$B271 if the x position is #N$08 or more.
  $B24F,$03 Move the creature to the room on the left.
  $B252,$04 Set the x position to #N$D0.
  $B256,$05 Return if the creature has not been drawn yet.
  $B25B,$03 Erase the sprite of the creature.
@ $B25E label=Handle_Flying_Creature_Test_Right_Gap
  $B25E,$04 Jump to #R$B271 if the x position is less than #N$E7.
  $B262,$03 Move the creature to the room on the right.
  $B265,$04 Set the x position to #N$18.
  $B269,$05 Return if the creature has not been drawn yet.
  $B26E,$03 Erase the sprite of the creature.
@ $B271 label=Handle_Flying_Creature_Set_Gap_Flags
N $B271 The creature is in a gap in the left or right wall, so set bits 0 and 4
. in the contact flags and in #REGe, which makes the ceiling and the floor seem
. to be present.
  $B271,$01 Save the new position in #REGaf'.
  $B272,$03 Fetch the contact flags.
  $B275,$02,b$01 Set bits 0 and 4.
  $B277,$03 Store the contact flags.
  $B27A,$01 Copy the flags of the room to #REGa.
  $B27B,$02,b$01 Set bits 0 and 4.
  $B27D,$01 Store them in #REGe.
  $B27E,$01 Restore the new position from #REGaf'.
  $B27F,$03 Jump to #R$B1E4.
@ $B282 label=Handle_Flying_Creature_Test_Top_Edge
N $B282 The y position is less than #N$80. The creature bounces off the ceiling
. if there is one, and leaves the room by the gap otherwise.
  $B282,$04 Jump to #R$B212 if the y position is #N$4C or more.
  $B286,$05 Jump to #R$B297 if the room has no ceiling.
  $B28B,$03 Fetch the y velocity.
  $B28E,$01 Invert it, to bounce off the ceiling.
  $B28F,$03 Store the y velocity.
  $B292,$02 Set the y position to #N$4C.
  $B294,$03 Jump to #R$B212.
@ $B297 label=Handle_Flying_Creature_Test_Top_Gap
  $B297,$04 Jump to #R$B2BD if the y position is #N$2A or more.
  $B29B,$03 Move the creature to the room above.
  $B29E,$04 Set the y position to #N$90.
  $B2A2,$05 Return if the creature has not been drawn yet.
  $B2A7,$03 Erase the sprite of the creature.
@ $B2AA label=Handle_Flying_Creature_Test_Bottom_Gap
  $B2AA,$04 Jump to #R$B2BD if the y position is less than #N$BF.
  $B2AE,$03 Move the creature to the room below.
  $B2B1,$04 Set the y position to #N$40.
  $B2B5,$05 Return if the creature has not been drawn yet.
  $B2BA,$03 Erase the sprite of the creature.
@ $B2BD label=Handle_Flying_Creature_Set_Vertical_Gap_Flags
N $B2BD The creature is in a gap in the ceiling or the floor, so set bits 2 and
. 6 in the contact flags and in #REGaf', which makes the side walls seem to be
. present.
  $B2BD,$01 Save the new position in #REGaf'.
  $B2BE,$03 Fetch the contact flags.
  $B2C1,$02,b$01 Set bits 2 and 6.
  $B2C3,$03 Store the contact flags.
  $B2C6,$01 Restore the new position from #REGaf'.
  $B2C7,$03 Jump to #R$B212.

u $B2CA Unused
@ $B2CA label=Unused_Set_Creature_Redraw_Flag
D $B2CA Never reached, as nothing jumps here. Sets bit 0 of the redraw flags of
. the object, so that its sprite is drawn without being erased first, and
. returns.
R $B2CA IX Object record
C $B2CA,$04 Set the redraw flags to #N$01.
C $B2CE,$01 Return.

c $B2CF Move Creature Horizontally
@ $B2CF label=Move_Creature_Horizontally
D $B2CF Moves a creature one step closer to Sabreman's room when it is in a
. different room x. It does not draw the creature. It is entered with the carry
. flag set if Sabreman's room x is less than the room x of the creature.
.
. The creature is flagged so that it will be drawn without being erased when it
. arrives. It accelerates by two on each call in the direction of Sabreman's
. room, up to a speed of #N$30, and its x position changes by a sixteenth of the
. speed. When the x position goes past #N$D0 (or below #N$18) it moves into the
. next room.
.
. The y position is kept at #N$40 or more, and when it is #N$80 or more it moves
. up two pixels each time.
.
. A creature cannot leave its room through a wall. If the wall is on the side
. that it is going to, it is removed when it is in the same room y as Sabreman,
. and otherwise #R$B358 moves it up or down.
R $B2CF IX Object record
R $B2CF E Flags of the room that the creature is in
  $B2CF,$04 Set the redraw flags to #N$01, so that the creature is drawn without
. being erased when it arrives.
  $B2D3,$04 Clear the contact flags.
  $B2D7,$02 Jump to #R$B31B if Sabreman is on the left of the creature.
  $B2D9,$04 Jump to #R$B34B if the room has a right wall.
  $B2DD,$03 Fetch the x velocity.
  $B2E0,$02 Accelerate to the right by adding two.
  $B2E2,$04 Jump to #R$B2EA if the x velocity is negative.
  $B2E6,$04 Jump to #R$B2ED if the x velocity has reached #N$31.
@ $B2EA label=Move_Creature_Horizontally_Store_Velocity
  $B2EA,$03 Store the x velocity.
@ $B2ED label=Move_Creature_Horizontally_Move_Right
  $B2ED,$03 Fetch the x velocity.
  $B2F0,$08 Divide it by sixteen, keeping the sign.
  $B2F8,$03 Add the x position of the creature.
  $B2FB,$04 Jump to #R$B304 if the x position is less than #N$D0.
  $B2FF,$03 Move the creature to the room on the right.
  $B302,$02 Set the x position to #N$08.
@ $B304 label=Move_Creature_Horizontally_Store_X
  $B304,$03 Store the x position.
@ $B307 label=Move_Creature_Horizontally_Adjust_Y
N $B307 Keep the y position between #N$40 and #N$80, and make it drift upwards
. when it is #N$80 or more.
  $B307,$03 Fetch the y position.
  $B30A,$04 Jump to #R$B312 if the y position is #N$40 or more.
  $B30E,$04 Set the y position to #N$40.
@ $B312 label=Move_Creature_Horizontally_Drift_Up
  $B312,$03 Return if the y position is less than #N$80.
  $B315,$02 Subtract two.
  $B317,$03 Store the y position.
  $B31A,$01 Return.
@ $B31B label=Move_Creature_Horizontally_Move_Left
N $B31B Sabreman is on the left of the creature.
  $B31B,$04 Jump to #R$B34B if the room has a left wall.
  $B31F,$03 Fetch the x velocity.
  $B322,$02 Accelerate to the left by subtracting two.
  $B324,$04 Jump to #R$B32C if the x velocity is positive.
  $B328,$04 Jump to #R$B32F if the x velocity is less than #N$D0.
@ $B32C label=Move_Creature_Horizontally_Store_Left_Velocity
  $B32C,$03 Store the x velocity.
@ $B32F label=Move_Creature_Horizontally_Add_Left_Velocity
  $B32F,$03 Fetch the x velocity.
  $B332,$08 Divide it by sixteen, keeping the sign.
  $B33A,$03 Add the x position of the creature.
  $B33D,$04 Jump to #R$B346 if the x position is #N$18 or more.
  $B341,$03 Move the creature to the room on the left.
  $B344,$02 Set the x position to #N$DF.
@ $B346 label=Move_Creature_Horizontally_Store_Left_X
  $B346,$03 Store the x position.
  $B349,$02 Jump to #R$B307.
@ $B34B label=Move_Creature_Horizontally_Blocked
N $B34B The creature cannot go that way.
  $B34B,$03 Fetch the room y of Sabreman.
  $B34E,$05 Jump to #R$B358 if the creature is in a different room y.
@ $B353 label=Move_Creature_Horizontally_Remove_Creature
  $B353,$04 Remove the creature.
  $B357,$01 Return.

c $B358 Move Creature Vertically
@ $B358 label=Move_Creature_Vertically
D $B358 Moves a creature one step closer to Sabreman's room when it is in a
. different room y (and the same room x). It works like #R$B2CF but vertically.
. It is entered with the carry flag set if Sabreman's room y is less than the
. room y of the creature.
.
. The creature is removed if the room has a floor and it is above Sabreman's
. room (or a ceiling and it is below), as it cannot get through. The x position
. is kept between #N$18 and #N$E0.
R $B358 IX Object record
R $B358 E Flags of the room that the creature is in
  $B358,$04 Set the redraw flags to #N$01, so that the creature is drawn without
. being erased when it arrives.
  $B35C,$04 Clear the contact flags.
  $B360,$02 Jump to #R$B3A3 if Sabreman is above the creature.
  $B362,$04 Jump to #R$B353 if the room has a floor.
  $B366,$03 Fetch the y velocity.
  $B369,$02 Accelerate downwards by adding two.
  $B36B,$04 Jump to #R$B373 if the y velocity is negative.
  $B36F,$04 Jump to #R$B376 if the y velocity has reached #N$31.
@ $B373 label=Move_Creature_Vertically_Store_Velocity
  $B373,$03 Store the y velocity.
@ $B376 label=Move_Creature_Vertically_Move_Down
  $B376,$03 Fetch the y velocity.
  $B379,$08 Divide it by sixteen, keeping the sign.
  $B381,$03 Add the y position of the creature.
  $B384,$04 Jump to #R$B38D if the y position is less than #N$9F.
  $B388,$03 Move the creature to the room below.
  $B38B,$02 Set the y position to #N$2C.
@ $B38D label=Move_Creature_Vertically_Store_Y
  $B38D,$03 Store the y position.
@ $B390 label=Move_Creature_Vertically_Adjust_X
N $B390 Keep the x position between #N$18 and #N$E0.
  $B390,$03 Fetch the x position.
  $B393,$04 Jump to #R$B39B if the x position is #N$18 or more.
  $B397,$04 Set the x position to #N$18.
@ $B39B label=Move_Creature_Vertically_Test_Right
  $B39B,$03 Return if the x position is less than #N$E0.
  $B39E,$04 Set the x position to #N$E0.
  $B3A2,$01 Return.
@ $B3A3 label=Move_Creature_Vertically_Move_Up
N $B3A3 Sabreman is above the creature.
  $B3A3,$05 Jump to #R$B353 if the room has a ceiling.
  $B3A8,$03 Fetch the y velocity.
  $B3AB,$02 Accelerate upwards by subtracting two.
  $B3AD,$04 Jump to #R$B3B5 if the y velocity is positive.
  $B3B1,$04 Jump to #R$B3B8 if the y velocity is less than #N$D0.
@ $B3B5 label=Move_Creature_Vertically_Store_Up_Velocity
  $B3B5,$03 Store the y velocity.
@ $B3B8 label=Move_Creature_Vertically_Add_Up_Velocity
  $B3B8,$03 Fetch the y velocity.
  $B3BB,$08 Divide it by sixteen, keeping the sign.
  $B3C3,$03 Add the y position of the creature.
  $B3C6,$04 Jump to #R$B3CF if the y position is #N$40 or more.
  $B3CA,$03 Move the creature to the room above.
  $B3CD,$02 Set the y position to #N$BF.
@ $B3CF label=Move_Creature_Vertically_Store_Up_Y
  $B3CF,$03 Store the y position.
  $B3D2,$02 Jump to #R$B390.

c $B3D4 Destroy Flying Creature
@ $B3D4 label=Destroy_Flying_Creature
D $B3D4 Reached when a thrown weapon has hit a creature. It restores the
. registers that #R$B132 stashed and goes on to destroy the creature at #R$DF42.
R $B3D4 IX Object record
  $B3D4,$01 Restore #REGde from the stack.
  $B3D5,$03 Destroy the creature.

c $B3D8 Handle Jellyfish
@ $B3D8 label=Handle_Jellyfish
D $B3D8 Handler for the object types #N$44 to #N$47 (jellyfish). A jellyfish is
. a flying creature that is handled like the eagles and vultures (see #R$B079),
. except that its x velocity is always #N$30 (to the right) or #N$D0 (to the
. left), and its y velocity only ever increases, up to #N$20, so that it sinks
. and bounces off the floor and the decorations.
.
. If the jellyfish is in a different room x from Sabreman, #R$B2CF moves it. If
. it is in a room that is below Sabreman's room, it is removed. If it is in a
. room that is above Sabreman's room, #R$B358 moves it down.
R $B3D8 IX Object record
  $B3D8,$03 Read the world map entry of the room that the jellyfish is in. The
. flags of the room are returned in #REGe.
  $B3DB,$03 Fetch the contact flags of the jellyfish.
  $B3DE,$01 Combine them with the flags of the room.
  $B3DF,$01 Store the result in #REGe.
  $B3E0,$03 Fetch the room x of Sabreman.
  $B3E3,$06 Jump to #R$B2CF if the jellyfish is in a different room x.
  $B3E9,$03 Fetch the room y of Sabreman.
  $B3EC,$05 Jump to #R$B3F9 if the jellyfish is in the same room y.
  $B3F1,$03 Jump to #R$B358 if Sabreman is in a room below the jellyfish.
  $B3F4,$04 Remove the jellyfish, as Sabreman is in a room above it.
  $B3F8,$01 Return.
@ $B3F9 label=Handle_Jellyfish_Animate
  $B3F9,$03 Animate the jellyfish.
  $B3FC,$03 Fetch the y velocity.
  $B3FF,$01 Add one to the y velocity, so that gravity slowly pulls the
. jellyfish down.
  $B400,$04 Jump to #R$B408 if the y velocity is negative.
  $B404,$04 Jump to #R$B40B if the y velocity has reached #N$21.
@ $B408 label=Handle_Jellyfish_Store_Y_Velocity
  $B408,$03 Store the y velocity.
@ $B40B label=Handle_Jellyfish_Set_X_Velocity
  $B40B,$06 Jump to #R$B418 if the x velocity is negative.
  $B411,$04 Set the x velocity to #N$30 (right).
  $B415,$03 Jump to #R$B132 to check for contact and to move the jellyfish.
@ $B418 label=Handle_Jellyfish_Move_Left
  $B418,$04 Set the x velocity to #N$D0 (left).
  $B41C,$03 Jump to #R$B132 to check for contact and to move the jellyfish.

c $B41F Animate Jellyfish
@ $B41F label=Animate_Jellyfish
D $B41F Counts a jellyfish through the six steps of its animation. The type of
. the jellyfish gets the counter divided by two (so #N$00, #N$01 or #N$02) in
. its low two bits, which gives three frames.
R $B41F IX Object record
  $B41F,$03 Save the state of the jellyfish.
  $B422,$03 Increase the animation counter of the jellyfish.
  $B425,$03 Fetch the animation counter of the jellyfish.
  $B428,$04 Jump to #R$B430 if the animation counter is less than #N$06.
  $B42C,$04 Reset the animation counter.
@ $B430 label=Animate_Jellyfish_Set_Type
  $B430,$01 Divide the animation counter by two.
  $B431,$02,b$01 Keep only the two low bits.
  $B433,$01 Keep the frame in #REGc.
  $B434,$03 Fetch the type of the jellyfish.
  $B437,$02,b$01 Reset the two low bits.
  $B439,$01 Combine the type with the frame.
  $B43A,$03 Store the type of the jellyfish.
  $B43D,$01 Return.

c $B43E Check Decoration Contact
@ $B43E label=Check_Decoration_Contact
D $B43E Checks whether an object touches one of the decorations, using #R$B46A.
. In the special rooms (a room y below #N$10) the four records that start at
. #R$8F7A are checked. In the cave rooms the two records that start at
. #R$8F9A are checked. The check stops at the first decoration that the
. object touches.
.
. Interrupts are disabled while the check is made, as the result is kept in
. #REGaf'.
R $B43E IX Object record
R $B43E O:B #N$A0 less the y position of the top of the decoration
R $B43E O:C Contact result (see #R$B46A)
  $B43E,$01 Disable interrupts.
  $B43F,$02 Stash #REGiy on the stack.
  $B441,$03 Fetch the room y of the object.
  $B444,$04 Jump to #R$B450 if the object is in a cave room.
  $B448,$04 Point #REGiy at #R$8F7A.
  $B44C,$02 Set a counter in #REGb for the four records.
  $B44E,$02 Jump to #R$B456.
@ $B450 label=Check_Decoration_Contact_Cave_Room
  $B450,$04 Point #REGiy at the first of the two records that are used in a cave
. room.
  $B454,$02 Set a counter in #REGb for the two records.
@ $B456 label=Check_Decoration_Contact_Set_Record_Size
  $B456,$03 Set the size of an object record.
@ $B459 label=Check_Decoration_Contact_Loop
  $B459,$03 Check for contact with the object.
  $B45C,$04 Jump to #R$B464 if the object touches the decoration.
  $B460,$02 Move on to the next record.
  $B462,$02 Decrease the record counter and loop back for the next record.
@ $B464 label=Check_Decoration_Contact_Done
  $B464,$02 Restore #REGiy from the stack.
  $B466,$01 Swap in the height that #R$B46A left in #REGaf'.
  $B467,$01 Copy it to #REGb.
  $B468,$01 Enable interrupts.
  $B469,$01 Return.

c $B46A Check Object Contact
@ $B46A label=Check_Object_Contact
D $B46A Checks whether the object at #REGix touches the object at #REGiy, which
. is an obstacle. The bytes #N$0A to #N$0E of the obstacle record are not used
. for movement. Instead they describe the size of the obstacle: its half width
. (byte #N$0A), the width of its middle (byte #N$0B), its height (byte #N$0C),
. the depth from the top at which the object counts as being beside it (byte
. #N$0D) and the offset of the middle from its x position (byte #N$0E). The y
. position of an obstacle is the position of its bottom.
.
. The result is returned in #REGc. Bit 2 is set if the objects touch. Bit 7 is
. set if #REGix is on the right of the middle of the obstacle. Bit 0 is set if
. #REGix is outside the width of the middle. Bit 1 is set if the bottom of
. #REGix is in the top part of the obstacle (so that it is standing or landing
. on it).
.
. When the object touches the top of the obstacle, bit 4 of its contact flags is
. set (so it is standing on it) unless it is a weapon pickup (see #R$E8D7) or it
. is outside the width of the middle. An obstacle of type #N$88 is handled by
. #R$ED8A instead.
R $B46A IX Object record
R $B46A IY Obstacle record
R $B46A O:C Contact result
R $B46A O:AF' #N$A0 less the y position of the top of the obstacle
  $B46A,$02 Clear the contact result.
  $B46C,$03 Fetch the type of the obstacle.
  $B46F,$02 Return if the obstacle record is empty.
  $B471,$05 Return if the obstacle has just been created.
  $B476,$05 Jump to #R$ED8A if the obstacle is a type #N$88 object.
  $B47B,$03 Fetch the x position of the obstacle.
  $B47E,$03 Add the offset of its middle.
  $B481,$06 Jump to #R$B48B if the object is on the left of the middle of the
. obstacle.
  $B487,$02 Make the distance positive.
  $B489,$02 Set bit 7 of the result, as the object is on the right.
@ $B48B label=Check_Object_Contact_Test_Distance
  $B48B,$05 Jump to #R$B4CA if the distance is too great for them to touch.
  $B490,$05 Jump to #R$B497 if the object is inside the width of the middle.
  $B495,$02 Set bit 0 of the result, as the object is outside the middle.
@ $B497 label=Check_Object_Contact_Test_Height
  $B497,$03 Fetch the y position of the obstacle.
  $B49A,$06 Jump to #R$B4CA if the object is below the bottom of the obstacle.
  $B4A0,$01 Stash the distance.
  $B4A1,$06 Work out the y position of the top of the obstacle.
  $B4A7,$04 Subtract it from #N$A0.
  $B4AB,$01 Keep the result in #REGaf'.
  $B4AC,$01 Restore the distance.
  $B4AD,$05 Jump to #R$B4CA if the distance is the height of the obstacle or
. more.
  $B4B2,$02 Set bit 2 of the result, as the objects touch.
  $B4B4,$04 Return if the distance is less than the depth in byte #N$0D of the
. obstacle.
  $B4B8,$02 Set bit 1 of the result, as the object is on top of the obstacle.
  $B4BA,$03 Fetch the type of the object.
  $B4BD,$02,b$01 Reset the two low bits.
  $B4BF,$03 Return if the object is a weapon pickup.
  $B4C2,$03 Return if the object is outside the width of the middle.
  $B4C5,$04 Set bit 4 of the contact flags of the object, as it is standing on
. the obstacle.
  $B4C9,$01 Return.
@ $B4CA label=Check_Object_Contact_None
  $B4CA,$02 Clear the result, as the objects do not touch.
  $B4CC,$01 Return.

c $B4CD Adjust Throw Facing
@ $B4CD label=Adjust_Throw_Facing
D $B4CD Subtracts two (instead of one) from the type of Sabreman when #R$B4D1
. works out which way he is facing, as his type is #N$15 or more. It carries on
. at #R$B538.
R $B4CD A Type of Sabreman
  $B4CD,$02 Subtract two from the type.
  $B4CF,$02 Jump to #R$B538.

c $B4D1 Throw Weapon
@ $B4D1 label=Throw_Weapon
D $B4D1 Throws a weapon that Sabreman is carrying. Nothing happens if bit 0 of
. the redraw flags of Sabreman is set or if he is not carrying a weapon (one of
. the types #N$68 to #N$6B in the three slots from #R$8EEB).
.
. One weapon at a time is thrown unless the counter in #R$AAAB allows another:
. the counter is reset while both weapon records are empty, and while a weapon
. is in flight it goes up each time this routine is called, so a weapon is
. thrown only when its low three bits are zero.
.
. The weapon record is a free one of the two records at #R$8EFA and #R$8F0A. The
. type, the position and the attribute are copied from Sabreman. The type of the
. weapon is then changed to the type of the projectile for the weapon that was
. carried (from the table at #R$B753), plus one if it is thrown to the left. The
. weapon starts #N$08 pixels to the side of Sabreman and #N$08 pixels higher,
. with an x velocity between #N$40 and #N$7F and an upward y velocity that comes
. from the frame counter. Bit 2 of the type of Sabreman, less one (or less two
. if his type is #N$15 or more), tells which way he is facing (set for the
. right). The weapon is not thrown if there is no room to its left.
R $B4D1 IX Object record of Sabreman
  $B4D1,$03 Fetch the redraw flags of Sabreman.
  $B4D4,$02,b$01 Keep only bit 0.
  $B4D6,$01 Return if Sabreman has only just appeared in the room (bit 0 is
. set).
  $B4D7,$03 Point #REGhl at the first of the three slots that hold the items
. that Sabreman carries.
  $B4DA,$02 Set a counter in #REGb for the three slots.
@ $B4DC label=Throw_Weapon_Find_Weapon
  $B4DC,$01 Fetch the type of the item.
  $B4DD,$02,b$01 Reset the two low bits.
  $B4DF,$04 Jump to #R$B4E7 if the item is a weapon.
  $B4E3,$01 Move on to the next slot.
  $B4E4,$02 Decrease the slot counter and loop back for the next slot.
  $B4E6,$01 Return, as Sabreman has no weapon.
@ $B4E7 label=Throw_Weapon_Found
  $B4E7,$01 Fetch the type of the weapon into #REGc.
  $B4E8,$04 Fetch the type of the first weapon record into #REGb.
  $B4EC,$06 Combine it with the type of the second weapon record, and jump to
. #R$B4F6 if both of the records are empty.
  $B4F2,$03 Fetch the fire key flag.
  $B4F5,$01 Increase it.
@ $B4F6 label=Throw_Weapon_Store_Counter
  $B4F6,$03 Store the counter.
  $B4F9,$02,b$01 Keep only the low three bits.
  $B4FB,$01 Return unless they are zero (a weapon can only be thrown on one pass
. in eight).
  $B4FC,$03 Point #REGde at #R$8EFA.
  $B4FF,$01 Fetch its type.
  $B500,$03 Jump to #R$B509 if the record is empty.
  $B503,$03 Point #REGde at #R$8F0A.
  $B506,$01 Fetch its type.
  $B507,$02 Return if the record is in use too.
@ $B509 label=Throw_Weapon_Copy_Position
  $B509,$03 Point #REGhl at the record of Sabreman.
  $B50C,$01 Stash the type of the weapon.
  $B50D,$03 Set the number of bytes to copy to #N$06.
  $B510,$01 Stash the address of the weapon record.
  $B511,$02 Copy the type, the position and the attribute of Sabreman to the
. weapon record.
  $B513,$01 Restore the address of the weapon record to #REGhl.
  $B514,$01 Restore the type of the weapon to #REGc.
  $B515,$03 Fetch the low byte of the frame counter.
  $B518,$01 Store it in #REGb.
  $B519,$03 Fetch the tick counter.
  $B51C,$01 Add the low byte of the frame counter.
  $B51D,$02,b$01 Keep only the low seven bits.
  $B51F,$02,b$01 Set bit 6.
  $B521,$01 Store the result in #REGb, to use as the x velocity of the weapon.
  $B522,$01 Fetch the type of the weapon.
  $B523,$02,b$01 Keep only the two low bits.
  $B525,$03 Point #REGde at #R$B753.
  $B528,$06 Add the weapon number to the address.
  $B52E,$02 Fetch the type of the projectile into #REGc.
  $B530,$03 Fetch the type of Sabreman.
  $B533,$04 Jump to #R$B4CD if the type is #N$15 or more.
  $B537,$01 Subtract one from the type.
@ $B538 label=Throw_Weapon_Test_Facing
  $B538,$01 Move to the x position in the weapon record.
  $B539,$03 Set #REGde to #N$0003.
  $B53C,$02,b$01 Test which way Sabreman is facing (bit 2 of the type that was
. worked out).
  $B53E,$01 Fetch the x position.
  $B53F,$02 Jump to #R$B545 if Sabreman is facing left.
  $B541,$02 Add #N$08, to start the weapon on his right.
  $B543,$02 Jump to #R$B54F.
@ $B545 label=Throw_Weapon_Face_Left
  $B545,$04 Jump to #R$B576 if the x position would be below zero.
  $B549,$05 Invert the x velocity in #REGb, so that it is negative.
  $B54E,$01 Use the next projectile type, for a weapon that travels to the left.
@ $B54F label=Throw_Weapon_Store_Position
  $B54F,$01 Store the x position.
  $B550,$01 Move back to the type.
  $B551,$01 Store the type of the projectile.
  $B552,$03 Move to the y position.
  $B555,$01 Fetch the y position.
  $B556,$02 Subtract #N$08.
  $B558,$01 Store the y position.
  $B559,$01 Move to byte #N$06 of the record.
  $B55A,$02 Clear byte #N$06 of the record.
  $B55C,$02 Move to the x velocity.
  $B55E,$01 Store the x velocity.
  $B55F,$01 Move to the y velocity.
  $B560,$03 Fetch the low byte of the frame counter.
  $B563,$02 Multiply it by four.
  $B565,$02,b$01 Keep only the low seven bits.
  $B567,$02 Negate it, to make an upward velocity.
  $B569,$01 Store the y velocity.
  $B56A,$03 Fetch the contact flags of Sabreman.
  $B56D,$02 Move to the contact flags.
  $B56F,$01 Store the contact flags.
  $B570,$02 Set #REGe to #N$04.
  $B572,$01 Move to the redraw flags.
  $B573,$02 Set bit 0 of the redraw flags, so that the weapon is drawn without
. being erased first.
  $B575,$01 Return.
@ $B576 label=Throw_Weapon_Cancel
  $B576,$01 Move back to the type.
  $B577,$02 Empty the weapon record.
  $B579,$01 Return.

c $B57A Handle Thrown Weapon
@ $B57A label=Handle_Thrown_Weapon
D $B57A Handler for the object types #N$38 to #N$3B (orbs). The two low bits of
. the type are set from the tick counter, which animates the orb. It carries on
. with #R$B58C.
R $B57A IX Object record
  $B57A,$03 Save the state of the orb.
  $B57D,$03 Fetch the tick counter from #R$8ED6.
  $B580,$02,b$01 Keep only the two low bits (the frame of the weapon).
  $B582,$01 Store the frame in #REGb.
  $B583,$03 Fetch the type.
  $B586,$02,b$01 Reset the two low bits.
  $B588,$01 Combine them with the frame.
  $B589,$03 Store the type.

c $B58C Move Thrown Weapon
@ $B58C label=Move_Thrown_Weapon
D $B58C Moves a weapon in flight. The projectiles (see #R$EA9C) and the fire
. (see #R$EA7D) are moved by this routine too.
.
. The object is removed if Sabreman is not in its room, or if bit 0 of byte
. #N$07 is set, which #R$B6F4 does when the weapon hits a creature. If it
. touches a decoration (see #R$B43E) it bursts into dust (see #R$DEDA) unless it
. lands on top, when it bounces.
.
. The y velocity increases by four each time, up to #N$78. The x and y positions
. are moved by the velocities (multiplied by sixteen, with the fractions in
. bytes #N$0A and #N$0D). The weapon bursts when it hits a wall, bounces off the
. floor (making a puff of dust) and off the ceiling, and is removed when it
. leaves the room through a gap. While it is in a gap the contact flags of the
. weapon and the flags of the room are changed, as for a creature (see #R$B271).
R $B58C IX Object record
  $B58C,$03 Fetch the room x of Sabreman.
  $B58F,$06 Jump to #R$B6E3 if the object is in a different room x.
  $B595,$03 Fetch the room y of Sabreman.
  $B598,$06 Jump to #R$B6E3 if the object is in a different room y.
  $B59E,$07 Jump to #R$B6D3 if the object has been marked for removal.
  $B5A5,$03 Check for contact with a decoration.
  $B5A8,$04 Jump to #R$B5C5 if the object does not touch one.
  $B5AC,$01 Copy the result to #REGa.
  $B5AD,$02,b$01 Keep only bit 1.
  $B5AF,$03 Jump to #R$DEDA if the object is not on top of the decoration, so
. that it bursts into dust.
  $B5B2,$03 Fetch the y velocity.
  $B5B5,$01 Invert it, to bounce.
  $B5B6,$03 Store the y velocity.
  $B5B9,$02 Start from the level of the floor (#N$A0).
  $B5BB,$01 Subtract #REGb to get the y position of the top of the decoration.
  $B5BC,$03 Store the y position, so that the object is on top.
  $B5BF,$03 Make a puff of dust.
  $B5C2,$03 Jump to #R$96CB.
@ $B5C5 label=Move_Thrown_Weapon_Move
N $B5C5 Move the object. First the y velocity is increased by four, up to a
. limit of #N$78.
  $B5C5,$03 Read the world map entry of the room that the object is in.
  $B5C8,$03 Fetch the contact flags.
  $B5CB,$01 Combine them with the flags of the room.
  $B5CC,$01 Store the result in #REGe.
  $B5CD,$04 Clear the contact flags.
  $B5D1,$03 Fetch the y velocity.
  $B5D4,$02 Add four to the y velocity, as gravity pulls the weapon down.
  $B5D6,$04 Jump to #R$B5E0 if the y velocity is negative.
  $B5DA,$04 Jump to #R$B5E0 if the y velocity is less than #N$78.
  $B5DE,$02 Limit the y velocity to #N$78.
@ $B5E0 label=Move_Thrown_Weapon_Store_Y_Velocity
  $B5E0,$03 Store the y velocity.
N $B5E3 Add the x velocity, multiplied by sixteen, to the x position and its
. fraction. #REGa is zero or one to say whether the velocity is positive or
. negative.
  $B5E3,$03 Fetch the x velocity into #REGl.
  $B5E6,$01 Set #REGa to zero.
  $B5E7,$02 Test the sign of the x velocity.
  $B5E9,$02 Clear the high byte of the x velocity (as a word).
  $B5EB,$02 Jump to #R$B5F0 if the x velocity is positive.
  $B5ED,$01 Set #REGa to one.
  $B5EE,$02 Set the high byte of the x velocity to #N$FF to extend the sign.
@ $B5F0 label=Move_Thrown_Weapon_Add_X_Velocity
  $B5F0,$04 Multiply the x velocity by sixteen.
  $B5F4,$03 Fetch the fraction of the x position.
  $B5F7,$03 Fetch the x position.
  $B5FA,$01 Add the x velocity.
  $B5FB,$03 Jump to #R$B5FF if the x velocity is negative.
  $B5FE,$01 Invert the carry flag.
@ $B5FF label=Move_Thrown_Weapon_Check_Wrap
  $B5FF,$03 Jump to #R$B6E3 if the x position has wrapped round.
  $B602,$03 Store the new fraction of the x position.
  $B605,$01 Fetch the new x position.
  $B606,$05 Jump to #R$B658 if the x position is less than #N$80.
  $B60B,$04 Jump to #R$B61B if the x position is less than #N$D8.
  $B60F,$05 Jump to #R$B676 if the room has no right wall.
  $B614,$04 Set the x position to #N$D7.
  $B618,$03 Jump to #R$DEDA, so that the object bursts into dust against the
. wall.
@ $B61B label=Move_Thrown_Weapon_Store_X
  $B61B,$03 Store the x position.
N $B61E Do the same with the y velocity and the y position.
  $B61E,$03 Fetch the y velocity into #REGl.
  $B621,$02 Test the sign of the y velocity.
  $B623,$02 Clear the high byte of the y velocity (as a word).
  $B625,$02 Jump to #R$B629 if the y velocity is positive.
  $B627,$02 Set the high byte of the y velocity to #N$FF to extend the sign.
@ $B629 label=Move_Thrown_Weapon_Add_Y_Velocity
  $B629,$04 Multiply the y velocity by sixteen.
  $B62D,$03 Fetch the fraction of the y position.
  $B630,$03 Fetch the y position.
  $B633,$01 Add the y velocity.
  $B634,$03 Store the new fraction of the y position.
  $B637,$01 Fetch the new y position.
  $B638,$05 Jump to #R$B695 if the y position is less than #N$80.
  $B63D,$04 Jump to #R$B652 if the y position is less than #N$9F.
  $B641,$05 Jump to #R$B6B8 if the room has no floor.
  $B646,$03 Fetch the y velocity.
  $B649,$01 Invert it, to bounce off the floor.
  $B64A,$03 Store the y velocity.
  $B64D,$03 Make a puff of dust.
  $B650,$02 Set the y position to #N$9F.
@ $B652 label=Move_Thrown_Weapon_Store_Y
  $B652,$03 Store the y position.
  $B655,$03 Jump to #R$96CB.
@ $B658 label=Move_Thrown_Weapon_Test_Left_Edge
  $B658,$05 Jump to #R$B61B if the x position is #N$18 or more.
  $B65D,$04 Jump to #R$B668 if the room has no left wall.
  $B661,$04 Set the x position to #N$18.
  $B665,$03 Jump to #R$DEDA, so that the object bursts into dust against the
. wall.
@ $B668 label=Move_Thrown_Weapon_Test_Left_Gap
  $B668,$04 Jump to #R$B684 if the x position is #N$08 or more.
  $B66C,$07 Jump to #R$B6E3 if the object has not been drawn yet, to remove it.
  $B673,$03 Remove the object and erase it.
@ $B676 label=Move_Thrown_Weapon_Test_Right_Gap
  $B676,$04 Jump to #R$B684 if the x position is less than #N$F0.
  $B67A,$07 Jump to #R$B6E3 if the object has not been drawn yet, to remove it.
  $B681,$03 Remove the object and erase it.
@ $B684 label=Move_Thrown_Weapon_Set_Gap_Flags
  $B684,$01 Save the x position in #REGaf'.
  $B685,$03 Fetch the contact flags.
  $B688,$02,b$01 Set bits 0 and 4, which makes the ceiling and the floor seem to
. be present.
  $B68A,$03 Store the contact flags.
  $B68D,$01 Copy the flags of the room to #REGa.
  $B68E,$02,b$01 Set bits 0 and 4 too.
  $B690,$01 Store them in #REGe.
  $B691,$01 Restore the x position from #REGaf'.
  $B692,$03 Jump to #R$B61B.
@ $B695 label=Move_Thrown_Weapon_Test_Top_Edge
  $B695,$04 Jump to #R$B652 if the y position is #N$40 or more.
  $B699,$05 Jump to #R$B6AA if the room has no ceiling.
  $B69E,$03 Fetch the y velocity.
  $B6A1,$01 Invert it, to bounce off the ceiling.
  $B6A2,$03 Store the y velocity.
  $B6A5,$02 Set the y position to #N$40.
  $B6A7,$03 Jump to #R$B652.
@ $B6AA label=Move_Thrown_Weapon_Test_Top_Gap
  $B6AA,$04 Jump to #R$B6C6 if the y position is #N$20 or more.
  $B6AE,$07 Jump to #R$B6E3 if the object has not been drawn yet, to remove it.
  $B6B5,$03 Remove the object and erase it.
@ $B6B8 label=Move_Thrown_Weapon_Test_Bottom_Gap
  $B6B8,$04 Jump to #R$B6C6 if the y position is less than #N$BF.
  $B6BC,$07 Jump to #R$B6E3 if the object has not been drawn yet, to remove it.
  $B6C3,$03 Remove the object and erase it.
@ $B6C6 label=Move_Thrown_Weapon_Set_Vertical_Gap_Flags
  $B6C6,$01 Save the y position in #REGaf'.
  $B6C7,$03 Fetch the contact flags.
  $B6CA,$02,b$01 Set bits 2 and 6, which makes the side walls seem to be
. present.
  $B6CC,$03 Store the contact flags.
  $B6CF,$01 Restore the y position from #REGaf'.
  $B6D0,$03 Jump to #R$B652.

c $B6D3 Remove Thrown Weapon
@ $B6D3 label=Remove_Thrown_Weapon
D $B6D3 Removes a weapon (or other object) that has been drawn, by emptying its
. record and erasing its sprite. If it has not been drawn there is nothing to
. erase.
R $B6D3 IX Object record
  $B6D3,$04 Empty the record by setting the type to zero.
  $B6D7,$04 Clear byte #N$07.
  $B6DB,$05 Return if the object has not been drawn yet.
  $B6E0,$03 Erase the sprite of the object.

c $B6E3 Remove Unseen Weapon
@ $B6E3 label=Remove_Unseen_Weapon
D $B6E3 Removes an object that does not have to be erased from the screen, by
. emptying its record.
R $B6E3 IX Object record
  $B6E3,$04 Empty the record by setting the type to zero.
  $B6E7,$01 Return.

c $B6E8 Check Weapon Hit
@ $B6E8 label=Check_Weapon_Hit
D $B6E8 Checks whether either of the two weapon records is touching an object.
.
. See #R$B6F4 for the details.
R $B6E8 IX Object record
R $B6E8 O:D #N$FF if a weapon has hit the object, otherwise #N$00
R $B6E8 O:E Type of the weapon that has hit the object
  $B6E8,$03 Point #REGhl at the first weapon record.
  $B6EB,$03 Check whether the weapon hits the object.
  $B6EE,$03 Return if it does.
  $B6F1,$03 Point #REGhl at #R$8F0A.

c $B6F4 Check Weapon Record Hit
@ $B6F4 label=Check_Weapon_Record_Hit
D $B6F4 Checks whether a weapon is touching an object. The weapon hits the
. object if it is in the same room, less than #N$10 pixels away horizontally and
. less than #N$10 pixels away vertically (allowing #N$04 pixels for the
. difference in their sizes). When it hits, bit 0 of byte #N$07 of the weapon is
. set, which makes #R$B58C remove the weapon.
R $B6F4 HL Weapon record
R $B6F4 IX Object record
R $B6F4 O:D #N$FF if the weapon hits the object, otherwise #N$00
R $B6F4 O:E Type of the weapon
  $B6F4,$02 Clear the hit flag in #REGd.
  $B6F6,$01 Fetch the type of the weapon.
  $B6F7,$02 Copy it to #REGe, testing it for zero.
  $B6F9,$01 Return if the record is empty.
  $B6FA,$01 Move to the x position of the weapon.
  $B6FB,$01 Fetch the x position of the weapon.
  $B6FC,$03 Subtract the x position of the object.
  $B6FF,$02 Add #N$04.
  $B701,$03 Jump to #R$B706 if the result is positive.
  $B704,$02 Make the result positive.
@ $B706 label=Check_Weapon_Record_Hit_Test_X
  $B706,$03 Return if they are #N$10 or more pixels apart horizontally.
  $B709,$01 Move to the room x of the weapon.
  $B70A,$01 Fetch the room x of the weapon.
  $B70B,$04 Return if it is not the room x of the object.
  $B70F,$01 Move to the y position of the weapon.
  $B710,$01 Fetch the y position of the weapon.
  $B711,$03 Subtract the y position of the object.
  $B714,$02 Add #N$04.
  $B716,$03 Jump to #R$B71B if the result is positive.
  $B719,$02 Make the result positive.
@ $B71B label=Check_Weapon_Record_Hit_Test_Y
  $B71B,$03 Return if they are #N$10 or more pixels apart vertically.
  $B71E,$01 Move to the room y of the weapon.
  $B71F,$01 Fetch the room y of the weapon.
  $B720,$04 Return if it is not the room y of the object.
  $B724,$02 Flag a hit by setting #REGd to #N$FF.
  $B726,$03 Move to byte #N$07.
  $B729,$02 Set bit 0 of byte #N$07, so that the weapon will be removed.
  $B72B,$01 Return.

c $B72C Start Being Carried
@ $B72C label=Start_Being_Carried
D $B72C Starts the part of the game in which an eagle carries Sabreman. The
. handler of Sabreman jumps here when bit 6 of his redraw flags has been set by
. the eagle (see #R$B079). The bits 5 and 6 of the redraw flags and the contact
. flags are cleared, the type becomes #N$60 and the routine carries on with the
. handler for that type at #R$E582.
R $B72C IX Object record of Sabreman
  $B72C,$04 Reset bit 6 of the redraw flags.
  $B730,$04 Reset bit 5 of the redraw flags.
  $B734,$04 Clear the contact flags.
  $B738,$04 Set the type to #N$60.
  $B73C,$03 Jump to #R$E582.

c $B73F Choose Eagle Target
@ $B73F label=Choose_Eagle_Target
D $B73F Chooses the point that an eagle flies towards while it carries Sabreman
. (see #R$E2CB). The x position (byte #N$0C) is a random number from #N$40 to
. #N$BF, from the frame counter. The y position (byte #N$0E) is a random number
. from #N$4C to #N$6B, from the refresh register.
R $B73F IX Object record of the eagle
  $B73F,$03 Fetch the low byte of the frame counter.
  $B742,$02,b$01 Keep only the low seven bits.
  $B744,$02 Add #N$40.
  $B746,$03 Store the target x position.
  $B749,$02 Fetch a random number from the refresh register.
  $B74B,$02,b$01 Keep only the low five bits.
  $B74D,$02 Add #N$4C.
  $B74F,$03 Store the target y position.
  $B752,$01 Return.

b $B753 Weapon Projectile Types
@ $B753 label=Weapon_Projectile_Types
D $B753 The type of the projectile that #R$B4D1 makes for each of the four kinds
. of weapon that Sabreman can carry (the types #N$68 to #N$6B). A weapon that is
. thrown to the left has a type that is one more.
B $B753,$01 Weapon #N$68 gives type #N$38 (see #R$B57A).
B $B754,$01 Weapon #N$69 gives type #N$6E (see #R$EA9C).
B $B755,$01 Weapon #N$6A gives type #N$70 (see #R$EA7D).
B $B756,$01 Weapon #N$6B gives type #N$6C (see #R$EA9C).

b $B757 Room Object X Positions
@ $B757 label=Room_Object_X_Positions
D $B757 The x positions of the plant and the rock that #R$AF56 puts in a room
. that has both a ceiling and a floor. The offset into the table is the sum of
. the room x and the room y, modulo #N$10. The plant gets the byte at that
. offset and the rock gets the byte after it.
B $B757,$14,$04

b $B76B Rock Templates
@ $B76B label=Rock_Templates
D $B76B The object records of the four rocks (the types #N$2C to #N$2F). #R$AF56
. copies one of them, chosen by the room x, into a decoration record, and then
. writes the x position that it takes from the table at #R$B757. The y position
. #N$A0 is the floor. Bytes #N$0A to #N$0E give the size of the rock as an
. obstacle, so that creatures and weapons bounce off it: its half width, the
. width of its middle, its height, its depth and the x offset of its middle (see
. #R$B46A). Bit 0 of the redraw flags is set so that the rock is drawn without
. being erased first.
N $B76B Rock of type #N$2C.
B $B76B,$06,$01 Type, x, room x, y, room y and attribute (yellow).
B $B771,$04,$04 Not used.
B $B775,$05,$01 Size of the obstacle (see #R$B46A).
B $B77A,$01 Redraw flags (bit 0 is set).
N $B77B Rock of type #N$2D.
B $B77B,$06,$01 Type, x, room x, y, room y and attribute (yellow).
B $B781,$04,$04 Not used.
B $B785,$05,$01 Size of the obstacle (see #R$B46A).
B $B78A,$01 Redraw flags (bit 0 is set).
N $B78B Rock of type #N$2E.
B $B78B,$06,$01 Type, x, room x, y, room y and attribute (yellow).
B $B791,$04,$04 Not used.
B $B795,$05,$01 Size of the obstacle (see #R$B46A).
B $B79A,$01 Redraw flags (bit 0 is set).
N $B79B Rock of type #N$2F.
B $B79B,$06,$01 Type, x, room x, y, room y and attribute (yellow).
B $B7A1,$04,$04 Not used.
B $B7A5,$05,$01 Size of the obstacle (see #R$B46A).
B $B7AA,$01 Redraw flags (bit 0 is set).

b $B7AB Spikes Templates
@ $B7AB label=Spikes_Templates
D $B7AB The object records of two objects of type #N$54, which stand on the
. floor at x positions #N$40 and #N$A0. #R$AF56 copies both of them into the
. decoration records of a room that has a floor but no ceiling. The routine at
. #R$AF3F handles them.
N $B7AB Object of type #N$54 at x position #N$40.
B $B7AB,$06,$01 Type, x, room x, y, room y and attribute (yellow).
B $B7B1,$04,$04 Not used.
B $B7B5,$05,$01 Size of the obstacle (see #R$B46A).
B $B7BA,$01 Redraw flags (bit 0 is set).
N $B7BB Object of type #N$54 at x position #N$A0.
B $B7BB,$06,$01 Type, x, room x, y, room y and attribute (yellow).
B $B7C1,$04,$04 Not used.
B $B7C5,$05,$01 Size of the obstacle (see #R$B46A).
B $B7CA,$01 Redraw flags (bit 0 is set).

b $B7CB Stalactite Templates
@ $B7CB label=Stalactite_Templates
D $B7CB The object records of the stalactites that hang from the ceiling of a
. cave (the types #N$55, #N$56, #N$57, #N$3C and #N$3D). #R$E6BE builds the
. stalactites of a room from them (see #R$E741 and #R$E749). The routine at
. #R$E622 handles them. Bytes #N$0A to #N$0E give the size of the stalactite as
. an obstacle (see #R$B46A).
N $B7CB Stalactite of type #N$55.
B $B7CB,$06,$01 Type, x, room x, y, room y and attribute (yellow).
B $B7D1,$04,$04 Not used.
B $B7D5,$05,$01 Size of the obstacle (see #R$B46A).
B $B7DA,$01 Redraw flags (bit 0 is set).
N $B7DB Stalactite of type #N$56.
B $B7DB,$06,$01 Type, x, room x, y, room y and attribute (yellow).
B $B7E1,$04,$04 Not used.
B $B7E5,$05,$01 Size of the obstacle (see #R$B46A).
B $B7EA,$01 Redraw flags (bit 0 is set).
N $B7EB Stalactite of type #N$57.
B $B7EB,$06,$01 Type, x, room x, y, room y and attribute (yellow).
B $B7F1,$04,$04 Not used.
B $B7F5,$05,$01 Size of the obstacle (see #R$B46A).
B $B7FA,$01 Redraw flags (bit 0 is set).
N $B7FB Stalactite of type #N$3C.
B $B7FB,$06,$01 Type, x, room x, y, room y and attribute (yellow).
B $B801,$04,$04 Not used.
B $B805,$05,$01 Size of the obstacle (see #R$B46A).
B $B80A,$01 Redraw flags (bit 0 is set).
N $B80B Stalactite of type #N$3D.
B $B80B,$06,$01 Type, x, room x, y, room y and attribute (yellow).
B $B811,$04,$04 Not used.
B $B815,$05,$01 Size of the obstacle (see #R$B46A).
B $B81A,$01 Redraw flags (bit 0 is set).

b $B81B Cave Frame Pictures
@ $B81B label=Cave_Frame_Pictures
D $B81B The pictures that make up the frame of a cave room (a room with a room y
. of #N$10 or more). Tiles for the ceiling, the floor and the walls are chosen
. by the tables at #R$9A33, #R$9B44, #R$9AF0 and #R$9BB0. Each tile starts with
. its height and its width (see #R$9BF8). The pictures of the corners have no
. header, are three bytes wide and #N$20 lines high and are chosen by the tables
. at #R$9A96, #R$9B18, #R$9B84 and #R$9BD8.
.
. The pixels of every picture come line by line, top line first. The walls are
. drawn by the tiles that hold them, and the pictures of the corners that have a
. wall are the first or the last #N$20 lines of those tiles.
.
. Two more pictures at the end are not used.
N $B81B Bottom left corner, with no floor and no left wall. It is used for the
. entries #N$00, #N$04, #N$08 and #N$0C of the table at #R$9B84.
B $B81B,$60,$03
N $B87B Bottom right corner, with no floor and no right wall. It is used for the
. entries #N$00, #N$04, #N$08 and #N$0C of the table at #R$9B18.
B $B87B,$60,$03
N $B8DB Floor tile 0, two bytes wide and #N$20 lines high.
B $B8DB,$02,$02 Height and width.
B $B8DD,$40,$02
N $B91D Floor tile 1, two bytes wide and #N$20 lines high.
B $B91D,$02,$02 Height and width.
B $B91F,$40,$02
N $B95F Floor tile 2, two bytes wide and #N$20 lines high.
B $B95F,$02,$02 Height and width.
B $B961,$40,$02
N $B9A1 Floor tile 3, two bytes wide and #N$20 lines high.
B $B9A1,$02,$02 Height and width.
B $B9A3,$40,$02
N $B9E3 Floor tile 4, two bytes wide and #N$20 lines high.
B $B9E3,$02,$02 Height and width.
B $B9E5,$40,$02
N $BA25 Floor tile 5, two bytes wide and #N$20 lines high.
B $BA25,$02,$02 Height and width.
B $BA27,$40,$02
N $BA67 Floor tile 6, two bytes wide and #N$20 lines high.
B $BA67,$02,$02 Height and width.
B $BA69,$40,$02
N $BAA9 Floor tile 7, two bytes wide and #N$20 lines high.
B $BAA9,$02,$02 Height and width.
B $BAAB,$40,$02
N $BAEB Ceiling tile 0, two bytes wide and #N$20 lines high.
B $BAEB,$02,$02 Height and width.
B $BAED,$40,$02
N $BB2D Ceiling tile 1, two bytes wide and #N$20 lines high.
B $BB2D,$02,$02 Height and width.
B $BB2F,$40,$02
N $BB6F Ceiling tile 2, two bytes wide and #N$20 lines high.
B $BB6F,$02,$02 Height and width.
B $BB71,$40,$02
N $BBB1 Ceiling tile 3, two bytes wide and #N$20 lines high.
B $BBB1,$02,$02 Height and width.
B $BBB3,$40,$02
N $BBF3 Ceiling tile 4, two bytes wide and #N$20 lines high.
B $BBF3,$02,$02 Height and width.
B $BBF5,$40,$02
N $BC35 Ceiling tile 5, two bytes wide and #N$20 lines high.
B $BC35,$02,$02 Height and width.
B $BC37,$40,$02
N $BC77 Ceiling tile 6, two bytes wide and #N$20 lines high.
B $BC77,$02,$02 Height and width.
B $BC79,$40,$02
N $BCB9 Ceiling tile 7, two bytes wide and #N$20 lines high.
B $BCB9,$02,$02 Height and width.
B $BCBB,$40,$02
N $BCFB Not used.
B $BCFB,$08,$08
N $BD03 Right wall tile 0, three bytes wide and #N$38 lines high. The first
. #N$20 lines (from #N$BD05) are the bottom right corner of a right wall with no
. floor, and the last #N$20 lines (from #N$BD4D) are the top right corner of a
. right wall with no ceiling. They are the entries #N$02 of the tables at
. #R$9B18 and #R$9A96.
B $BD03,$02,$02 Height and width.
B $BD05,$A8,$03
N $BDAD Right wall tile 1, three bytes wide and #N$38 lines high. The first
. #N$20 lines (from #N$BDAF) are the bottom right corner of a right wall with no
. floor, and the last #N$20 lines (from #N$BDF7) are the top right corner of a
. right wall with no ceiling. They are the entries #N$06 of the tables at
. #R$9B18 and #R$9A96.
B $BDAD,$02,$02 Height and width.
B $BDAF,$A8,$03
N $BE57 Right wall tile 2, three bytes wide and #N$38 lines high. The first
. #N$20 lines (from #N$BE59) are the bottom right corner of a right wall with no
. floor, and the last #N$20 lines (from #N$BEA1) are the top right corner of a
. right wall with no ceiling. They are the entries #N$0A of the tables at
. #R$9B18 and #R$9A96.
B $BE57,$02,$02 Height and width.
B $BE59,$A8,$03
N $BF01 Right wall tile 3, three bytes wide and #N$38 lines high. The first
. #N$20 lines (from #N$BF03) are the bottom right corner of a right wall with no
. floor, and the last #N$20 lines (from #N$BF4B) are the top right corner of a
. right wall with no ceiling. They are the entries #N$0E of the tables at
. #R$9B18 and #R$9A96.
B $BF01,$02,$02 Height and width.
B $BF03,$A8,$03
N $BFAB Left wall tile 0, three bytes wide and #N$38 lines high. The first #N$20
. lines (from #N$BFAD) are the bottom left corner of a left wall with no floor,
. and the last #N$20 lines (from #N$BFF5) are the top left corner of a left wall
. with no ceiling. They are the entries #N$02 of the tables at #R$9B84 and
. #R$9BD8.
B $BFAB,$02,$02 Height and width.
B $BFAD,$A8,$03
N $C055 Left wall tile 1, three bytes wide and #N$38 lines high. The first #N$20
. lines (from #N$C057) are the bottom left corner of a left wall with no floor,
. and the last #N$20 lines (from #N$C09F) are the top left corner of a left wall
. with no ceiling. They are the entries #N$06 of the tables at #R$9B84 and
. #R$9BD8.
B $C055,$02,$02 Height and width.
B $C057,$A8,$03
N $C0FF Left wall tile 2, three bytes wide and #N$38 lines high. The first #N$20
. lines (from #N$C101) are the bottom left corner of a left wall with no floor,
. and the last #N$20 lines (from #N$C149) are the top left corner of a left wall
. with no ceiling. They are the entries #N$0A of the tables at #R$9B84 and
. #R$9BD8.
B $C0FF,$02,$02 Height and width.
B $C101,$A8,$03
N $C1A9 Not used.
B $C1A9,$03,$03
N $C1AC Left wall tile 3, three bytes wide and #N$38 lines high. The first #N$20
. lines (from #N$C1AE) are the bottom left corner of a left wall with no floor.
. The top left corner (entry #N$0E of the table at #R$9BD8) is not the last
. #N$20 lines of the tile but starts at #N$C1F7, one byte later, and ends with
. the byte at #N$C256.
B $C1AC,$02,$02 Height and width.
B $C1AE,$A8,$03
B $C256,$01 The last byte of the top left corner picture that starts at #N$C1F7.
N $C257 Top left corner, with no ceiling and no left wall. It is used for the
. entries #N$00, #N$04, #N$08 and #N$0C of the table at #R$9BD8.
B $C257,$60,$03
N $C2B7 Top right corner, with no ceiling and no right wall. It is used for the
. entries #N$00, #N$04, #N$08 and #N$0C of the table at #R$9A96.
B $C2B7,$60,$03
N $C317 Not used. A picture of rock, three bytes wide and #N$20 lines high, with
. its height and width.
B $C317,$02,$02 Height and width.
B $C319,$60,$03
N $C379 Not used. Another picture of rock, with its height and width.
B $C379,$02,$02 Height and width.
B $C37B,$60,$03

b $C3DB Sprite: Blank
@ $C3DB label=Sprite_Blank_1
D $C3DB The empty sprite, which is only a width and a height. It is used for the
. sprite ids #N$00 and #N$17 (the rope, which has its own drawing code) and for
. the sound objects #N$89, #N$8A and #N$8B.
  $C3DB,$01 Width = #N(#PEEK(#PC)) bytes.
  $C3DC,$01 Height = #N(#PEEK(#PC)) pixels.

b $C3DD Sprite: Sabreman Walking
@ $C3DD label=Sprite_Sabreman_Walking_1
D $C3DD The three frames of Sabreman walking to the left, which are the sprite
. ids #N$09 to #N$0C (the second frame is used twice). Sabreman is drawn walking
. to the right with the sprites at #R$C58D.
N $C3DD Frame 1.
  $C3DD,$01 Width = #N(#PEEK(#PC)) bytes.
  $C3DE,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3DF,$2C,$02 #SPRITEDATA(sabreman-walking-01*)
N $C40B Frame 2.
@ $C40B label=Sprite_Sabreman_Walking_2
  $C40B,$01 Width = #N(#PEEK(#PC)) bytes.
  $C40C,$01 Height = #N(#PEEK(#PC)) pixels.
  $C40D,$2C,$02 #SPRITEDATA(sabreman-walking-02*)
N $C439 Frame 3.
@ $C439 label=Sprite_Sabreman_Walking_3
  $C439,$01 Width = #N(#PEEK(#PC)) bytes.
  $C43A,$01 Height = #N(#PEEK(#PC)) pixels.
  $C43B,$2C,$02 #SPRITEDATA(sabreman-walking-03*)

b $C467 Sprite: Sabreman Jumping
@ $C467 label=Sprite_Sabreman_Jumping_1
D $C467 The two frames of Sabreman jumping to the left, which are the sprite ids
. #N$11 and #N$12. Sabreman is drawn jumping to the right with the sprites at
. #R$C617.
N $C467 Frame 1.
  $C467,$01 Width = #N(#PEEK(#PC)) bytes.
  $C468,$01 Height = #N(#PEEK(#PC)) pixels.
  $C469,$28,$02 #SPRITEDATA(sabreman-jumping-01*)
N $C491 Frame 2.
@ $C491 label=Sprite_Sabreman_Jumping_2
  $C491,$01 Width = #N(#PEEK(#PC)) bytes.
  $C492,$01 Height = #N(#PEEK(#PC)) pixels.
  $C493,$32,$02 #SPRITEDATA(sabreman-jumping-02*)

b $C4C5 Sprite: Sabreman Falling
@ $C4C5 label=Sprite_Sabreman_Falling_1
D $C4C5 Sabreman falling to the left, which is the sprite id #N$15. Sabreman is
. drawn falling to the right with the sprite at #R$C675.
  $C4C5,$01 Width = #N(#PEEK(#PC)) bytes.
  $C4C6,$01 Height = #N(#PEEK(#PC)) pixels.
  $C4C7,$30,$02 #SPRITEDATA(sabreman-falling-01*)

b $C4F7 Sprite: Sabreman Swimming
@ $C4F7 label=Sprite_Sabreman_Swimming_1
D $C4F7 The three frames of Sabreman in the pose that he has on the rope (the
. sprite ids #N$01 to #N$04, where the second frame is used twice). The first
. two are also used for the types #N$62 and #N$63 of Sabreman when he is carried
. by an eagle (see #R$E570). The sprites at #R$C6A7 are the same poses the other
. way round.
N $C4F7 Frame 1.
  $C4F7,$01 Width = #N(#PEEK(#PC)) bytes.
  $C4F8,$01 Height = #N(#PEEK(#PC)) pixels.
  $C4F9,$30,$03 #SPRITEDATA(sabreman-swimming-01*)
N $C529 Frame 2.
@ $C529 label=Sprite_Sabreman_Swimming_2
  $C529,$01 Width = #N(#PEEK(#PC)) bytes.
  $C52A,$01 Height = #N(#PEEK(#PC)) pixels.
  $C52B,$30,$03 #SPRITEDATA(sabreman-swimming-02*)
N $C55B Frame 3.
@ $C55B label=Sprite_Sabreman_Swimming_3
  $C55B,$01 Width = #N(#PEEK(#PC)) bytes.
  $C55C,$01 Height = #N(#PEEK(#PC)) pixels.
  $C55D,$30,$03 #SPRITEDATA(sabreman-swimming-03*)

b $C58D Sprite: Sabreman Walking
@ $C58D label=Sprite_Sabreman_Walking_4
D $C58D The three frames of Sabreman walking to the right, which are the sprite
. ids #N$0D to #N$10 (the second frame is used twice).
N $C58D Frame 1.
  $C58D,$01 Width = #N(#PEEK(#PC)) bytes.
  $C58E,$01 Height = #N(#PEEK(#PC)) pixels.
  $C58F,$2C,$02 #SPRITEDATA(sabreman-walking-04*)
N $C5BB Frame 2.
@ $C5BB label=Sprite_Sabreman_Walking_5
  $C5BB,$01 Width = #N(#PEEK(#PC)) bytes.
  $C5BC,$01 Height = #N(#PEEK(#PC)) pixels.
  $C5BD,$2C,$02 #SPRITEDATA(sabreman-walking-05*)
N $C5E9 Frame 3.
@ $C5E9 label=Sprite_Sabreman_Walking_6
  $C5E9,$01 Width = #N(#PEEK(#PC)) bytes.
  $C5EA,$01 Height = #N(#PEEK(#PC)) pixels.
  $C5EB,$2C,$02 #SPRITEDATA(sabreman-walking-06*)

b $C617 Sprite: Sabreman Jumping
@ $C617 label=Sprite_Sabreman_Jumping_3
D $C617 The two frames of Sabreman jumping to the right, which are the sprite
. ids #N$13 and #N$14.
N $C617 Frame 1.
  $C617,$01 Width = #N(#PEEK(#PC)) bytes.
  $C618,$01 Height = #N(#PEEK(#PC)) pixels.
  $C619,$28,$02 #SPRITEDATA(sabreman-jumping-03*)
N $C641 Frame 2.
@ $C641 label=Sprite_Sabreman_Jumping_4
  $C641,$01 Width = #N(#PEEK(#PC)) bytes.
  $C642,$01 Height = #N(#PEEK(#PC)) pixels.
  $C643,$32,$02 #SPRITEDATA(sabreman-jumping-04*)

b $C675 Sprite: Sabreman Falling
@ $C675 label=Sprite_Sabreman_Falling_2
D $C675 Sabreman falling to the right, which is the sprite id #N$16.
  $C675,$01 Width = #N(#PEEK(#PC)) bytes.
  $C676,$01 Height = #N(#PEEK(#PC)) pixels.
  $C677,$30,$02 #SPRITEDATA(sabreman-falling-02*)

b $C6A7 Sprite: Sabreman Swimming
@ $C6A7 label=Sprite_Sabreman_Swimming_4
D $C6A7 The three frames of Sabreman in the pose that he has on the rope, the
. other way round from #R$C4F7 (the sprite ids #N$05 to #N$08, where the second
. frame is used twice). The first two are also used for the types #N$60 and
. #N$61 of Sabreman when he is carried by an eagle (see #R$E570).
N $C6A7 Frame 1.
  $C6A7,$01 Width = #N(#PEEK(#PC)) bytes.
  $C6A8,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6A9,$30,$03 #SPRITEDATA(sabreman-swimming-04*)
N $C6D9 Frame 2.
@ $C6D9 label=Sprite_Sabreman_Swimming_5
  $C6D9,$01 Width = #N(#PEEK(#PC)) bytes.
  $C6DA,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6DB,$30,$03 #SPRITEDATA(sabreman-swimming-05*)
N $C70B Frame 3.
@ $C70B label=Sprite_Sabreman_Swimming_6
  $C70B,$01 Width = #N(#PEEK(#PC)) bytes.
  $C70C,$01 Height = #N(#PEEK(#PC)) pixels.
  $C70D,$30,$03 #SPRITEDATA(sabreman-swimming-06*)

b $C73D Sprite: Sabreman Tumbling
@ $C73D label=Sprite_Sabreman_Tumbling_1
D $C73D The four frames of Sabreman tumbling, which are the sprite ids #N$18 to
. #N$1B. #R$E8A2 picks one of them when he starts to tumble.
N $C73D Frame 1.
  $C73D,$01 Width = #N(#PEEK(#PC)) bytes.
  $C73E,$01 Height = #N(#PEEK(#PC)) pixels.
  $C73F,$30,$03 #SPRITEDATA(sabreman-tumbling-01*)
N $C76F Frame 2.
@ $C76F label=Sprite_Sabreman_Tumbling_2
  $C76F,$01 Width = #N(#PEEK(#PC)) bytes.
  $C770,$01 Height = #N(#PEEK(#PC)) pixels.
  $C771,$27,$03 #SPRITEDATA(sabreman-tumbling-02*)
N $C798 Frame 3.
@ $C798 label=Sprite_Sabreman_Tumbling_3
  $C798,$01 Width = #N(#PEEK(#PC)) bytes.
  $C799,$01 Height = #N(#PEEK(#PC)) pixels.
  $C79A,$30,$03 #SPRITEDATA(sabreman-tumbling-03*)
N $C7CA Frame 4.
@ $C7CA label=Sprite_Sabreman_Tumbling_4
  $C7CA,$01 Width = #N(#PEEK(#PC)) bytes.
  $C7CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $C7CC,$2D,$03 #SPRITEDATA(sabreman-tumbling-04*)

b $C7F9 Cave Corner Pictures
@ $C7F9 label=Cave_Corner_Pictures
D $C7F9 More pictures of the corners of a cave room (see #R$B81B). Every picture
. is three bytes wide and #N$20 lines high, and has no header. The corners with
. a ceiling or a floor but no wall come in four versions, one for each value of
. the sum of the room x and the room y (modulo four). The corners with both a
. wall and a ceiling or a floor are the same in every room.
N $C7F9 Not used.
B $C7F9,$08,$08
B $C801,$08,$08
N $C809 Bottom right corner, with a floor and a right wall. It is used for the
. entries #N$03, #N$07, #N$0B and #N$0F of the table at #R$9B18.
B $C809,$60,$03
N $C869 Bottom left corner, with a floor and a left wall. It is used for the
. entries #N$03, #N$07, #N$0B and #N$0F of the table at #R$9B84.
B $C869,$60,$03
N $C8C9 Top right corner, with a ceiling and a right wall. It is used for the
. entries #N$03, #N$07, #N$0B and #N$0F of the table at #R$9A96.
B $C8C9,$60,$03
N $C929 Top left corner, with a ceiling and a left wall. It is used for the
. entries #N$03, #N$07, #N$0B and #N$0F of the table at #R$9BD8.
B $C929,$60,$03
N $C989 Top corner for a ceiling and no wall, version 0. It is used for the
. entry #N$01 of the tables at #R$9A96 and #R$9BD8.
B $C989,$60,$03
N $C9E9 Top corner for a ceiling and no wall, version 1. It is used for the
. entry #N$05 of the tables at #R$9A96 and #R$9BD8.
B $C9E9,$60,$03
N $CA49 Top corner for a ceiling and no wall, version 2. It is used for the
. entry #N$09 of the tables at #R$9A96 and #R$9BD8.
B $CA49,$60,$03
N $CAA9 Top corner for a ceiling and no wall, version 3. It is used for the
. entry #N$0D of the tables at #R$9A96 and #R$9BD8.
B $CAA9,$60,$03
N $CB09 Bottom corner for a floor and no wall, version 0. It is used for the
. entry #N$01 of the tables at #R$9B18 and #R$9B84.
B $CB09,$60,$03
N $CB69 Bottom corner for a floor and no wall, version 1. It is used for the
. entry #N$05 of the tables at #R$9B18 and #R$9B84.
B $CB69,$60,$03
N $CBC9 Bottom corner for a floor and no wall, version 2. It is used for the
. entry #N$09 of the tables at #R$9B18 and #R$9B84.
B $CBC9,$60,$03
N $CC29 Bottom corner for a floor and no wall, version 3. It is used for the
. entry #N$0D of the tables at #R$9B18 and #R$9B84.
B $CC29,$60,$03

b $CC89 Sprite: Mushroom
@ $CC89 label=Sprite_Mushroom_1
D $CC89 The two frames of the mushroom. The plants of the types #N$1C, #N$22 and
. #N$28 use the first frame and the plants of the types #N$1D, #N$23 and #N$29
. use the second frame. The plants have different attributes (see #R$AF12).
N $CC89 Frame 1.
  $CC89,$01 Width = #N(#PEEK(#PC)) bytes.
  $CC8A,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC8B,$5A,$03 #SPRITEDATA(mushroom-01*)
N $CCE5 Frame 2.
@ $CCE5 label=Sprite_Mushroom_2
  $CCE5,$01 Width = #N(#PEEK(#PC)) bytes.
  $CCE6,$01 Height = #N(#PEEK(#PC)) pixels.
  $CCE7,$5D,$03 #SPRITEDATA(mushroom-02*)

b $CD44 Sprite: Pod
@ $CD44 label=Sprite_Pod_1
D $CD44 The two frames of the pod. The plants of the types #N$1E and #N$2A use
. the first frame and the plants of the types #N$1F and #N$2B use the second
. frame (see #R$AEB9).
N $CD44 Frame 1.
  $CD44,$01 Width = #N(#PEEK(#PC)) bytes.
  $CD45,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD46,$5A,$03 #SPRITEDATA(pod-01*)
N $CDA0 Frame 2.
@ $CDA0 label=Sprite_Pod_2
  $CDA0,$01 Width = #N(#PEEK(#PC)) bytes.
  $CDA1,$01 Height = #N(#PEEK(#PC)) pixels.
  $CDA2,$5D,$03 #SPRITEDATA(pod-02*)

b $CDFF Sprite: Flytrap
@ $CDFF label=Sprite_Flytrap_1
D $CDFF The two frames of the flytrap, which are the plant types #N$20 and #N$21
. (see #R$AEB9).
N $CDFF Frame 1.
  $CDFF,$01 Width = #N(#PEEK(#PC)) bytes.
  $CE00,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE01,$57,$03 #SPRITEDATA(flytrap-01*)
N $CE58 Frame 2.
@ $CE58 label=Sprite_Flytrap_2
  $CE58,$01 Width = #N(#PEEK(#PC)) bytes.
  $CE59,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE5A,$5A,$03 #SPRITEDATA(flytrap-02*)

b $CEB4 Sprite: Bellflower
@ $CEB4 label=Sprite_Bellflower_1
D $CEB4 The two frames of the bellflower, which are the plant types #N$26 and
. #N$27 (see #R$AEB9).
N $CEB4 Frame 1.
  $CEB4,$01 Width = #N(#PEEK(#PC)) bytes.
  $CEB5,$01 Height = #N(#PEEK(#PC)) pixels.
  $CEB6,$60,$03 #SPRITEDATA(bellflower-01*)
N $CF16 Frame 2.
@ $CF16 label=Sprite_Bellflower_2
  $CF16,$01 Width = #N(#PEEK(#PC)) bytes.
  $CF17,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF18,$60,$03 #SPRITEDATA(bellflower-02*)

b $CF78 Sprite: Weed
@ $CF78 label=Sprite_Weed_1
D $CF78 The two frames of the weed, which are the plant types #N$24 and #N$25
. (see #R$AEB9).
N $CF78 Frame 1.
  $CF78,$01 Width = #N(#PEEK(#PC)) bytes.
  $CF79,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF7A,$60,$03 #SPRITEDATA(weed-01*)
N $CFDA Frame 2.
@ $CFDA label=Sprite_Weed_2
  $CFDA,$01 Width = #N(#PEEK(#PC)) bytes.
  $CFDB,$01 Height = #N(#PEEK(#PC)) pixels.
  $CFDC,$60,$03 #SPRITEDATA(weed-02*)
  $D03C,$03,$03

b $D03F Sprite: Rock
@ $D03F label=Sprite_Rock_1
D $D03F The four rocks, which are the object types #N$2C to #N$2F (see #R$AF3F).
N $D03F Frame 1.
  $D03F,$01 Width = #N(#PEEK(#PC)) bytes.
  $D040,$01 Height = #N(#PEEK(#PC)) pixels.
  $D041,$60,$03 #SPRITEDATA(rock-01*)
N $D0A1 Frame 2.
@ $D0A1 label=Sprite_Rock_2
  $D0A1,$01 Width = #N(#PEEK(#PC)) bytes.
  $D0A2,$01 Height = #N(#PEEK(#PC)) pixels.
  $D0A3,$60,$03 #SPRITEDATA(rock-02*)
N $D103 Frame 3.
@ $D103 label=Sprite_Rock_3
  $D103,$01 Width = #N(#PEEK(#PC)) bytes.
  $D104,$01 Height = #N(#PEEK(#PC)) pixels.
  $D105,$48,$03 #SPRITEDATA(rock-03*)
N $D14D Frame 4.
@ $D14D label=Sprite_Rock_4
  $D14D,$01 Width = #N(#PEEK(#PC)) bytes.
  $D14E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D14F,$1E,$02 #SPRITEDATA(rock-04*)

b $D16D Unreferenced Data
@ $D16D label=Unreferenced_Data
D $D16D These bytes are not referenced by the sprite address table.
B $D16D,$20,$10

b $D18D Sprite: Orb
@ $D18D label=Sprite_Orb_1
D $D18D The four frames of the orb that is thrown by a weapon, which are the
. object types #N$38 to #N$3B (see #R$B57A).
N $D18D Frame 1.
  $D18D,$01 Width = #N(#PEEK(#PC)) bytes.
  $D18E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D18F,$16,$02 #SPRITEDATA(orb-01*)
N $D1A5 Frame 2.
@ $D1A5 label=Sprite_Orb_2
  $D1A5,$01 Width = #N(#PEEK(#PC)) bytes.
  $D1A6,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1A7,$16,$02 #SPRITEDATA(orb-02*)
N $D1BD Frame 3.
@ $D1BD label=Sprite_Orb_3
  $D1BD,$01 Width = #N(#PEEK(#PC)) bytes.
  $D1BE,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1BF,$16,$02 #SPRITEDATA(orb-03*)
N $D1D5 Frame 4.
@ $D1D5 label=Sprite_Orb_4
  $D1D5,$01 Width = #N(#PEEK(#PC)) bytes.
  $D1D6,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1D7,$16,$02 #SPRITEDATA(orb-04*)

b $D1ED Sprite: Eagle
@ $D1ED label=Sprite_Eagle_1
D $D1ED The four frames of the eagle. The types #N$32 and #N$33 are the eagle
. flying to the left and the types #N$30 and #N$31 are the eagle flying to the
. right (see #R$B079). The types #N$5E and #N$5F (to the left) and #N$5C and
. #N$5D (to the right) use the same sprites for an eagle that carries Sabreman
. (see #R$E2CB). The frames at #R$D26C are the eagle flying to the right.
N $D1ED Frame 1.
  $D1ED,$01 Width = #N(#PEEK(#PC)) bytes.
  $D1EE,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1EF,$33,$03 #SPRITEDATA(eagle-01*)
N $D222 Frame 2.
@ $D222 label=Sprite_Eagle_2
  $D222,$01 Width = #N(#PEEK(#PC)) bytes.
  $D223,$01 Height = #N(#PEEK(#PC)) pixels.
  $D224,$48,$03 #SPRITEDATA(eagle-02*)
N $D26C Frame 3.
@ $D26C label=Sprite_Eagle_3
  $D26C,$01 Width = #N(#PEEK(#PC)) bytes.
  $D26D,$01 Height = #N(#PEEK(#PC)) pixels.
  $D26E,$33,$03 #SPRITEDATA(eagle-03*)
N $D2A1 Frame 4.
@ $D2A1 label=Sprite_Eagle_4
  $D2A1,$01 Width = #N(#PEEK(#PC)) bytes.
  $D2A2,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2A3,$48,$03 #SPRITEDATA(eagle-04*)

b $D2EB Sprite: Gargoyle
@ $D2EB label=Sprite_Gargoyle_1
D $D2EB The three frames of the gargoyle. They are the types #N$34 to #N$37,
. where the types #N$35 and #N$37 both use the middle frame (see #R$EE66).
N $D2EB Frame 1.
  $D2EB,$01 Width = #N(#PEEK(#PC)) bytes.
  $D2EC,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2ED,$4E,$03 #SPRITEDATA(gargoyle-01*)
N $D33B Frame 2.
@ $D33B label=Sprite_Gargoyle_2
  $D33B,$01 Width = #N(#PEEK(#PC)) bytes.
  $D33C,$01 Height = #N(#PEEK(#PC)) pixels.
  $D33D,$4E,$03 #SPRITEDATA(gargoyle-02*)
N $D38B Frame 3.
@ $D38B label=Sprite_Gargoyle_3
  $D38B,$01 Width = #N(#PEEK(#PC)) bytes.
  $D38C,$01 Height = #N(#PEEK(#PC)) pixels.
  $D38D,$4E,$03 #SPRITEDATA(gargoyle-03*)

b $D3DB Sprite: Jellyfish
@ $D3DB label=Sprite_Jellyfish_1
D $D3DB The three frames of the jellyfish, which are the types #N$44 to #N$47
. (see #R$B3D8). The types #N$45 and #N$47 both use the middle frame.
N $D3DB Frame 1.
  $D3DB,$01 Width = #N(#PEEK(#PC)) bytes.
  $D3DC,$01 Height = #N(#PEEK(#PC)) pixels.
  $D3DD,$48,$03 #SPRITEDATA(jellyfish-01*)
N $D425 Frame 2.
@ $D425 label=Sprite_Jellyfish_2
  $D425,$01 Width = #N(#PEEK(#PC)) bytes.
  $D426,$01 Height = #N(#PEEK(#PC)) pixels.
  $D427,$48,$03 #SPRITEDATA(jellyfish-02*)
N $D46F Frame 3.
@ $D46F label=Sprite_Jellyfish_3
  $D46F,$01 Width = #N(#PEEK(#PC)) bytes.
  $D470,$01 Height = #N(#PEEK(#PC)) pixels.
  $D471,$48,$03 #SPRITEDATA(jellyfish-03*)

b $D4B9 Sprite: Spider
@ $D4B9 label=Sprite_Spider_1
D $D4B9 The three frames of the spider, which is a guardian (see #R$ECCA). The
. first two are the types #N$82 and #N$83. The third frame is not used.
N $D4B9 Frame 1.
  $D4B9,$01 Width = #N(#PEEK(#PC)) bytes.
  $D4BA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D4BB,$48,$03 #SPRITEDATA(spider-01*)
N $D503 Frame 2.
@ $D503 label=Sprite_Spider_2
  $D503,$01 Width = #N(#PEEK(#PC)) bytes.
  $D504,$01 Height = #N(#PEEK(#PC)) pixels.
  $D505,$48,$03 #SPRITEDATA(spider-02*)
N $D54D Frame 3.
@ $D54D label=Sprite_Spider_3
  $D54D,$01 Width = #N(#PEEK(#PC)) bytes.
  $D54E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D54F,$48,$03 #SPRITEDATA(spider-03*)

b $D597 Sprite: Vulture
@ $D597 label=Sprite_Vulture_1
D $D597 The four frames of the vulture. The types #N$42 and #N$43 are the
. vulture flying to the left and the types #N$40 and #N$41 are the vulture
. flying to the right (see #R$B079).
N $D597 Frame 1.
  $D597,$01 Width = #N(#PEEK(#PC)) bytes.
  $D598,$01 Height = #N(#PEEK(#PC)) pixels.
  $D599,$3F,$03 #SPRITEDATA(vulture-01*)
N $D5D8 Frame 2.
@ $D5D8 label=Sprite_Vulture_2
  $D5D8,$01 Width = #N(#PEEK(#PC)) bytes.
  $D5D9,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5DA,$3F,$03 #SPRITEDATA(vulture-02*)
N $D619 Frame 3.
@ $D619 label=Sprite_Vulture_3
  $D619,$01 Width = #N(#PEEK(#PC)) bytes.
  $D61A,$01 Height = #N(#PEEK(#PC)) pixels.
  $D61B,$3F,$03 #SPRITEDATA(vulture-03*)
N $D65A Frame 4.
@ $D65A label=Sprite_Vulture_4
  $D65A,$01 Width = #N(#PEEK(#PC)) bytes.
  $D65B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D65C,$3F,$03 #SPRITEDATA(vulture-04*)

b $D69B Sprite: Explosion
@ $D69B label=Sprite_Explosion_1
D $D69B The four frames of the explosion that happens when a creature is
. destroyed, which are the object types #N$4C to #N$4F (see #R$DF15).
N $D69B Frame 1.
  $D69B,$01 Width = #N(#PEEK(#PC)) bytes.
  $D69C,$01 Height = #N(#PEEK(#PC)) pixels.
  $D69D,$39,$03 #SPRITEDATA(explosion-01*)
  $D6D6,$03,$03
N $D6D9 Frame 2.
@ $D6D9 label=Sprite_Explosion_2
  $D6D9,$01 Width = #N(#PEEK(#PC)) bytes.
  $D6DA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D6DB,$42,$03 #SPRITEDATA(explosion-02*)
N $D71D Frame 3.
@ $D71D label=Sprite_Explosion_3
  $D71D,$01 Width = #N(#PEEK(#PC)) bytes.
  $D71E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D71F,$48,$03 #SPRITEDATA(explosion-03*)
N $D767 Frame 4.
@ $D767 label=Sprite_Explosion_4
  $D767,$01 Width = #N(#PEEK(#PC)) bytes.
  $D768,$01 Height = #N(#PEEK(#PC)) pixels.
  $D769,$48,$03 #SPRITEDATA(explosion-04*)

b $D7B1 Sprite: Dust
@ $D7B1 label=Sprite_Dust_1
D $D7B1 The four frames of the puff of dust, which are the object types #N$48 to
. #N$4B (see #R$DEE8).
N $D7B1 Frame 1.
  $D7B1,$01 Width = #N(#PEEK(#PC)) bytes.
  $D7B2,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7B3,$1A,$02 #SPRITEDATA(dust-01*)
N $D7CD Frame 2.
@ $D7CD label=Sprite_Dust_2
  $D7CD,$01 Width = #N(#PEEK(#PC)) bytes.
  $D7CE,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7CF,$1E,$02 #SPRITEDATA(dust-02*)
N $D7ED Frame 3.
@ $D7ED label=Sprite_Dust_3
  $D7ED,$01 Width = #N(#PEEK(#PC)) bytes.
  $D7EE,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7EF,$0E,$02 #SPRITEDATA(dust-03*)
N $D7FD Frame 4.
@ $D7FD label=Sprite_Dust_4
  $D7FD,$01 Width = #N(#PEEK(#PC)) bytes.
  $D7FE,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7FF,$14,$02 #SPRITEDATA(dust-04*)
  $D813,$02,$02

b $D815 Sprite: Debris
@ $D815 label=Sprite_Debris_1
D $D815 The four pieces of debris. The first is the falling piece of stalactite,
. which is the object type #N$50 (see #R$DF98) and also the tile that is used to
. draw the structure of the type #N$88 (see #R$ED2E). The other three are the
. types #N$51 to #N$53, which are small pieces of rock (see #R$E027).
N $D815 Frame 1.
  $D815,$01 Width = #N(#PEEK(#PC)) bytes.
  $D816,$01 Height = #N(#PEEK(#PC)) pixels.
  $D817,$40,$02 #SPRITEDATA(debris-01*)
N $D857 Frame 2.
@ $D857 label=Sprite_Debris_2
  $D857,$01 Width = #N(#PEEK(#PC)) bytes.
  $D858,$01 Height = #N(#PEEK(#PC)) pixels.
  $D859,$34,$02 #SPRITEDATA(debris-02*)
N $D88D Frame 3.
@ $D88D label=Sprite_Debris_3
  $D88D,$01 Width = #N(#PEEK(#PC)) bytes.
  $D88E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D88F,$24,$02 #SPRITEDATA(debris-03*)
N $D8B3 Frame 4.
@ $D8B3 label=Sprite_Debris_4
  $D8B3,$01 Width = #N(#PEEK(#PC)) bytes.
  $D8B4,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8B5,$16,$02 #SPRITEDATA(debris-04*)

b $D8CB Sprite: Stalactite
@ $D8CB label=Sprite_Stalactite_1
D $D8CB The five stalactites. They are the object types #N$55, #N$56, #N$3C,
. #N$3D and #N$57, in that order (see #R$E622).
N $D8CB Frame 1.
  $D8CB,$01 Width = #N(#PEEK(#PC)) bytes.
  $D8CC,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8CD,$90,$03 #SPRITEDATA(stalactite-01*)
N $D95D Frame 2.
@ $D95D label=Sprite_Stalactite_2
  $D95D,$01 Width = #N(#PEEK(#PC)) bytes.
  $D95E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D95F,$90,$03 #SPRITEDATA(stalactite-02*)
N $D9EF Frame 3.
@ $D9EF label=Sprite_Stalactite_3
  $D9EF,$01 Width = #N(#PEEK(#PC)) bytes.
  $D9F0,$01 Height = #N(#PEEK(#PC)) pixels.
  $D9F1,$90,$03 #SPRITEDATA(stalactite-03*)
N $DA81 Frame 4.
@ $DA81 label=Sprite_Stalactite_4
  $DA81,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA82,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA83,$90,$03 #SPRITEDATA(stalactite-04*)
N $DB13 Frame 5.
@ $DB13 label=Sprite_Stalactite_5
  $DB13,$01 Width = #N(#PEEK(#PC)) bytes.
  $DB14,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB15,$60,$03 #SPRITEDATA(stalactite-05*)

b $DB75 Sprite: Spikes
@ $DB75 label=Sprite_Spikes_1
D $DB75 The sprite of the row of spikes, which is the object type #N$54 (see
. #R$AF3F).
  $DB75,$01 Width = #N(#PEEK(#PC)) bytes.
  $DB76,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB77,$28,$05 #SPRITEDATA(spikes-01*)

b $DB9F Sprite: Bubble
@ $DB9F label=Sprite_Bubble_1
D $DB9F The three frames of the bubble, which are the object types #N$58, #N$59
. and #N$5A (see #R$E117). The types #N$59 and #N$5B both use the middle frame.
N $DB9F Frame 1.
  $DB9F,$01 Width = #N(#PEEK(#PC)) bytes.
  $DBA0,$01 Height = #N(#PEEK(#PC)) pixels.
  $DBA1,$20,$02 #SPRITEDATA(bubble-01*)
N $DBC1 Frame 2.
@ $DBC1 label=Sprite_Bubble_2
  $DBC1,$01 Width = #N(#PEEK(#PC)) bytes.
  $DBC2,$01 Height = #N(#PEEK(#PC)) pixels.
  $DBC3,$22,$02 #SPRITEDATA(bubble-02*)
N $DBE5 Frame 3.
@ $DBE5 label=Sprite_Bubble_3
  $DBE5,$01 Width = #N(#PEEK(#PC)) bytes.
  $DBE6,$01 Height = #N(#PEEK(#PC)) pixels.
  $DBE7,$24,$02 #SPRITEDATA(bubble-03*)

b $DC0B Colour Data
@ $DC0B label=Colour_Data
D $DC0B The attributes of the cells that the stalactites and some of the
. decorations cover. #R$E622 and #R$EB39 copy them to the screen after the
. sprite has been drawn, using the pointers at #R$E69D and #R$EB72. The
. attributes of an object are in rows, with the bottom row first, and each row
. is as wide as the sprite is in cells.
N $DC0B Stalactites of the types #N$3D and #N$55 (three cells wide, six rows).
B $DC0B,$12,$03
N $DC1D Stalactites of the types #N$3C and #N$56 (three cells wide, six rows).
B $DC1D,$12,$03
N $DC2F Stalactite of the type #N$57 (three cells wide, four rows).
B $DC2F,$0C,$03
B $DC3B,$06,$06 Not used.
N $DC41 Bookshelf, the type #N$7B (six cells wide, three rows).
B $DC41,$12,$06
N $DC53 Torch, the type #N$7E (two cells wide, five rows).
B $DC53,$0A,$02
N $DC5D Flower bowl, the type #N$7D (four cells wide, three rows).
B $DC5D,$0C,$04
N $DC69 Hanging bowl, the type #N$7C (three cells wide, three rows).
B $DC69,$09,$03
N $DC72 Picture, the type #N$79 (four cells wide, five rows).
B $DC72,$14,$04
N $DC86 Picture, the type #N$7A (four cells wide, four rows).
B $DC86,$10,$04

b $DC96 Sprite: Death
@ $DC96 label=Sprite_Death_1
D $DC96 The two frames of the sprite that is drawn when Sabreman dies, which are
. the object types #N$3F and #N$3E (see #R$E7E3).
N $DC96 Frame 1.
  $DC96,$01 Width = #N(#PEEK(#PC)) bytes.
  $DC97,$01 Height = #N(#PEEK(#PC)) pixels.
  $DC98,$27,$03 #SPRITEDATA(death-01*)
N $DCBF Frame 2.
@ $DCBF label=Sprite_Death_2
  $DCBF,$01 Width = #N(#PEEK(#PC)) bytes.
  $DCC0,$01 Height = #N(#PEEK(#PC)) pixels.
  $DCC1,$27,$03 #SPRITEDATA(death-02*)

b $DCE8 Sprite: Gem
@ $DCE8 label=Sprite_Gem_1
D $DCE8 The four gems, which are the object types #N$64 to #N$67 (see #R$E751).
N $DCE8 Frame 1.
  $DCE8,$01 Width = #N(#PEEK(#PC)) bytes.
  $DCE9,$01 Height = #N(#PEEK(#PC)) pixels.
  $DCEA,$18,$02 #SPRITEDATA(gem-01*)
N $DD02 Frame 2.
@ $DD02 label=Sprite_Gem_2
  $DD02,$01 Width = #N(#PEEK(#PC)) bytes.
  $DD03,$01 Height = #N(#PEEK(#PC)) pixels.
  $DD04,$1C,$02 #SPRITEDATA(gem-02*)
N $DD20 Frame 3.
@ $DD20 label=Sprite_Gem_3
  $DD20,$01 Width = #N(#PEEK(#PC)) bytes.
  $DD21,$01 Height = #N(#PEEK(#PC)) pixels.
  $DD22,$20,$02 #SPRITEDATA(gem-03*)
N $DD42 Frame 4.
@ $DD42 label=Sprite_Gem_4
  $DD42,$01 Width = #N(#PEEK(#PC)) bytes.
  $DD43,$01 Height = #N(#PEEK(#PC)) pixels.
  $DD44,$20,$02 #SPRITEDATA(gem-04*)

b $DD64 Sprite: Fire
@ $DD64 label=Sprite_Fire_1
D $DD64 The two frames of the fire that is thrown by the torch, which are the
. object types #N$70 and #N$71 (see #R$EA7D).
N $DD64 Frame 1.
  $DD64,$01 Width = #N(#PEEK(#PC)) bytes.
  $DD65,$01 Height = #N(#PEEK(#PC)) pixels.
  $DD66,$20,$02 #SPRITEDATA(fire-01*)
N $DD86 Frame 2.
@ $DD86 label=Sprite_Fire_2
  $DD86,$01 Width = #N(#PEEK(#PC)) bytes.
  $DD87,$01 Height = #N(#PEEK(#PC)) pixels.
  $DD88,$20,$02 #SPRITEDATA(fire-02*)

b $DDA8 Sprite: Weapon
@ $DDA8 label=Sprite_Weapon_1
D $DDA8 The four weapons that Sabreman can pick up (see #R$E8D7). The first
. looks like a lamp (type #N$68), the second like a bow (type #N$69), the third
. like a dagger (type #N$6B) and the fourth like a torch (type #N$6A).
N $DDA8 Frame 1.
  $DDA8,$01 Width = #N(#PEEK(#PC)) bytes.
  $DDA9,$01 Height = #N(#PEEK(#PC)) pixels.
  $DDAA,$30,$03 #SPRITEDATA(weapon-01*)
N $DDDA Frame 2.
@ $DDDA label=Sprite_Weapon_2
  $DDDA,$01 Width = #N(#PEEK(#PC)) bytes.
  $DDDB,$01 Height = #N(#PEEK(#PC)) pixels.
  $DDDC,$30,$03 #SPRITEDATA(weapon-02*)
N $DE0C Frame 3.
@ $DE0C label=Sprite_Weapon_3
  $DE0C,$01 Width = #N(#PEEK(#PC)) bytes.
  $DE0D,$01 Height = #N(#PEEK(#PC)) pixels.
  $DE0E,$30,$03 #SPRITEDATA(weapon-03*)
N $DE3E Frame 4.
@ $DE3E label=Sprite_Weapon_4
  $DE3E,$01 Width = #N(#PEEK(#PC)) bytes.
  $DE3F,$01 Height = #N(#PEEK(#PC)) pixels.
  $DE40,$30,$03 #SPRITEDATA(weapon-04*)

b $DE70 Sprite: Projectile
@ $DE70 label=Sprite_Projectile_1
D $DE70 The four projectiles that are thrown by the daggers and the bows, which
. are the object types #N$6C to #N$6F (see #R$EA9C). The first two are daggers
. (to the right and to the left) and the last two are arrows.
N $DE70 Frame 1.
  $DE70,$01 Width = #N(#PEEK(#PC)) bytes.
  $DE71,$01 Height = #N(#PEEK(#PC)) pixels.
  $DE72,$10,$02 #SPRITEDATA(projectile-01*)
N $DE82 Frame 2.
@ $DE82 label=Sprite_Projectile_2
  $DE82,$01 Width = #N(#PEEK(#PC)) bytes.
  $DE83,$01 Height = #N(#PEEK(#PC)) pixels.
  $DE84,$10,$02 #SPRITEDATA(projectile-02*)
N $DE94 Frame 3.
@ $DE94 label=Sprite_Projectile_3
  $DE94,$01 Width = #N(#PEEK(#PC)) bytes.
  $DE95,$01 Height = #N(#PEEK(#PC)) pixels.
  $DE96,$10,$02 #SPRITEDATA(projectile-03*)
N $DEA6 Frame 4.
@ $DEA6 label=Sprite_Projectile_4
  $DEA6,$01 Width = #N(#PEEK(#PC)) bytes.
  $DEA7,$01 Height = #N(#PEEK(#PC)) pixels.
  $DEA8,$10,$02 #SPRITEDATA(projectile-04*)

c $DEB8 Make Dust Puff
@ $DEB8 label=Make_Dust_Puff
D $DEB8 Makes a puff of dust at the position of an object, by copying the object
. to the record at #R$8F4A and changing the type of the copy to #N$4A.
. Nothing happens if that record is already in use. The puff lasts for four
. frames (see #R$DEE8). The routine finishes by playing a deep tone.
R $DEB8 IX Object record of the object that makes the puff
  $DEB8,$03 Fetch the type of the dust record.
  $DEBB,$02 Return if the record is already in use.
  $DEBD,$03 Copy the address of the object record to #REGhl.
  $DEC0,$03 Point #REGde at #R$8F4A.
  $DEC3,$03 Set a counter of #N$0F bytes.
  $DEC6,$02 Copy the object to the dust record, except for its redraw flags.
  $DEC8,$05 Set the type of the new object to #N$4A, which is a puff of dust.
  $DECD,$05 Set the counter in byte #N$08 to #N$04.
  $DED2,$05 Set the redraw flags to #N$01, so that the puff is drawn without
. being erased first.
  $DED7,$03 Jump to #R$A173.

c $DEDA Burst Into Dust
@ $DEDA label=Burst_Into_Dust
D $DEDA Turns an object (a thrown weapon that has hit something) into a puff of
. dust of the type #N$48, which lasts for four frames (see #R$DEE8). A noise is
. made and the puff is drawn.
R $DEDA IX Object record
  $DEDA,$04 Change the object into a puff of dust.
  $DEDE,$04 Set the counter in byte #N$08 to #N$04.
  $DEE2,$03 Make a noise.
  $DEE5,$03 Jump to #R$96CB.

c $DEE8 Handle Dust
@ $DEE8 label=Handle_Dust
D $DEE8 Handler for the object types #N$48 to #N$4B (a puff of dust). The
. counter in byte #N$08 goes down on every call and the puff is removed, and
. erased, when it reaches zero. Bit 0 of the type follows bit 0 of the counter,
. which makes the puff flicker between two frames. The puff is removed if
. Sabreman is not in its room.
R $DEE8 IX Object record
  $DEE8,$03 Save the state of the puff.
  $DEEB,$03 Fetch the room x of Sabreman.
  $DEEE,$06 Jump to #R$B6E3 to remove the puff if it is in a different room x.
  $DEF4,$03 Fetch the room y of Sabreman.
  $DEF7,$06 Jump to #R$B6E3 to remove the puff if it is in a different room y.
  $DEFD,$06 Decrease the counter and jump to #R$B6D3 to remove the puff when it
. reaches zero.
  $DF03,$03 Fetch the counter.
  $DF06,$02,b$01 Keep only bit 0.
  $DF08,$01 Store it in #REGb.
  $DF09,$03 Fetch the type.
  $DF0C,$02,b$01 Reset bit 0.
  $DF0E,$01 Add bit 0 of the counter.
  $DF0F,$03 Store the type.
  $DF12,$03 Jump to #R$96CB.

c $DF15 Handle Explosion
@ $DF15 label=Handle_Explosion
D $DF15 Handler for the object types #N$4C to #N$4F (an explosion). It works
. like #R$DEE8, but the explosion starts with a counter of #N$09 and the two low
. bits of the type follow the two low bits of the counter, so the explosion goes
. through four frames.
R $DF15 IX Object record
  $DF15,$03 Save the state of the explosion.
  $DF18,$03 Fetch the room x of Sabreman.
  $DF1B,$06 Jump to #R$B6E3 to remove the explosion if it is in a different room
. x.
  $DF21,$03 Fetch the room y of Sabreman.
  $DF24,$06 Jump to #R$B6E3 to remove the explosion if it is in a different room
. y.
  $DF2A,$06 Decrease the counter and jump to #R$B6D3 to remove the explosion
. when it reaches zero.
  $DF30,$03 Fetch the counter.
  $DF33,$02,b$01 Keep only the two low bits.
  $DF35,$01 Store them in #REGb.
  $DF36,$03 Fetch the type.
  $DF39,$02,b$01 Reset the two low bits.
  $DF3B,$01 Add the two low bits of the counter.
  $DF3C,$03 Store the type.
  $DF3F,$03 Jump to #R$96CB.

c $DF42 Destroy Creature
@ $DF42 label=Destroy_Creature
D $DF42 Destroys a creature. The sound of the creature being destroyed is
. played, the type of the creature is added to the score (see #R$A045) and the
. creature turns into an explosion of the type #N$4C, which lasts for nine
. frames (see #R$DF15).
R $DF42 IX Object record of the creature
  $DF42,$03 Play the sound of a creature being destroyed.
  $DF45,$03 Fetch the type of the creature into #REGc.
  $DF48,$02 Clear #REGb, so that #REGbc holds the points for the creature.
  $DF4A,$03 Add the points for the creature (its type) to the score.
  $DF4D,$04 Change the creature into an explosion.
  $DF51,$04 Set the counter in byte #N$08 to #N$09.
  $DF55,$03 Jump to #R$96CB.

c $DF58 Spawn Falling Stalactite
@ $DF58 label=Spawn_Falling_Stalactite
D $DF58 Lets a stalactite fall from the ceiling of a cave room every now and
. then. Nothing happens in a special room, in a room that has no ceiling, or
. while the stalactite record at #R$8F3A is in use. The stalactite is
. only made when the low four bits of the tick counter and the frame counter,
. combined, are zero.
.
. The record is a copy of the record of Sabreman, so the stalactite falls from
. the same x position, with the type #N$50, the y position #N$40, the attribute
. #N$46 (yellow) and a y velocity of #N$10 (see #R$DF98).
  $DF58,$03 Fetch the room y of the object.
  $DF5B,$03 Return if it is a special room.
  $DF5E,$03 Fetch the flags of the room that Sabreman is in.
  $DF61,$02,b$01 Keep only bit 0 (the ceiling).
  $DF63,$01 Return if the room has no ceiling.
  $DF64,$03 Fetch the type of the stalactite record.
  $DF67,$02 Return if the record is already in use.
  $DF69,$04 Fetch the tick counter and keep it in #REGb.
  $DF6D,$03 Fetch the low byte of the frame counter.
  $DF70,$01 Combine it with the tick counter.
  $DF71,$02,b$01 Keep only the low four bits.
  $DF73,$01 Return unless they are zero.
  $DF74,$03 Point #REGhl at #R$8F1A.
  $DF77,$03 Point #REGde at #R$8F3A.
  $DF7A,$03 Set a counter of #N$10 bytes.
  $DF7D,$01 Stash the address of the stalactite record.
  $DF7E,$02 Copy the record of Sabreman to the stalactite record.
  $DF80,$01 Restore the address of the stalactite record to #REGhl.
  $DF81,$02 Set the type to #N$50.
  $DF83,$03 Move to the y position.
  $DF86,$02 Set the y position to #N$40.
  $DF88,$02 Move to the attribute.
  $DF8A,$02 Set the attribute to #N$46 (yellow).
  $DF8C,$04 Move to the y velocity.
  $DF90,$02 Set the y velocity to #N$10.
  $DF92,$05 Set the redraw flags of the stalactite to #N$01, so that it is drawn
. without being erased first.
  $DF97,$01 Return.

c $DF98 Handle Falling Stalactite
@ $DF98 label=Handle_Falling_Stalactite
D $DF98 Handler for the object type #N$50, a stalactite that falls from the
. ceiling towards Sabreman (see #R$DF58).
.
. The y velocity (byte #N$09) goes up by two on every call, to a limit of #N$6D,
. and the y position and its fraction (byte #N$0D) change by sixteen times the
. velocity. The stalactite lands on a decoration if it touches the top of one
. near the middle of it. It lands on the floor if the room has one, and if the
. room has no floor it falls into the room below. When it lands it becomes the
. type #N$51 (see #R$E027) and is not a stalactite any more.
.
. If Sabreman is not in the room the stalactite carries on falling but is not
. drawn. The countdown in byte #N$0A, which is reset to #N$50 while Sabreman is
. in the room, removes it when he has been away for long enough.
R $DF98 IX Object record
  $DF98,$03 Save the state of the stalactite.
  $DF9B,$03 Fetch the y velocity.
  $DF9E,$02 Add two to the y velocity, as gravity pulls the stalactite down.
  $DFA0,$04 Jump to #R$DFA7 if the stalactite is falling at full speed (the y
. velocity has reached #N$6E).
  $DFA4,$03 Store the y velocity.
@ $DFA7 label=Handle_Falling_Stalactite_Move
  $DFA7,$03 Fetch the y velocity into #REGl.
  $DFAA,$02 Clear the high byte of the y velocity (as a word).
  $DFAC,$04 Multiply the y velocity by sixteen.
  $DFB0,$03 Fetch the fraction of the y position.
  $DFB3,$03 Fetch the y position.
  $DFB6,$01 Add the y velocity.
  $DFB7,$03 Store the new fraction of the y position.
  $DFBA,$03 Store the new y position.
  $DFBD,$03 Read the world map entry of the room that the stalactite is in. The
. flags of the room are returned in #REGe.
  $DFC0,$01 Copy the flags of the room to #REGa.
  $DFC1,$02,b$01 Keep only bit 4 (the floor).
  $DFC3,$01 Fetch the new y position.
  $DFC4,$02 Jump to #R$DFCC if the room has no floor.
  $DFC6,$04 Jump to #R$DFE3 if the stalactite has reached the floor.
  $DFCA,$02 Jump to #R$DFD1.
@ $DFCC label=Handle_Falling_Stalactite_No_Floor
  $DFCC,$05 Jump to #R$E00D if the stalactite has fallen out of the bottom of
. the room.
@ $DFD1 label=Handle_Falling_Stalactite_Check_Decorations
  $DFD1,$03 Check for contact with the decorations.
  $DFD4,$04 Jump to #R$DFF4 if the stalactite is not on top of a decoration.
  $DFD8,$04 Jump to #R$DFF4 if the stalactite is not near the middle of the
. decoration.
  $DFDC,$01 Copy #N$A0 less the y position of the top of the decoration to
. #REGa.
  $DFDD,$02 Negate it.
  $DFDF,$02 Add #N$A1, to get the y position just below the top of the
. decoration.
  $DFE1,$02 Jump to #R$DFE9.
@ $DFE3 label=Handle_Falling_Stalactite_Land_On_Floor
  $DFE3,$03 Fetch the y position.
  $DFE6,$02,b$01 Round it down to a multiple of eight.
  $DFE8,$01 Subtract one.
@ $DFE9 label=Handle_Falling_Stalactite_Shatter
  $DFE9,$03 Store the y position.
  $DFEC,$04 Change the stalactite into the first piece of rock.
  $DFF0,$04 Reset the counter in byte #N$06.
@ $DFF4 label=Handle_Falling_Stalactite_Check_Room
  $DFF4,$03 Fetch the room x of Sabreman.
  $DFF7,$06 Jump to #R$E01C if the stalactite is in a different room x.
  $DFFD,$03 Fetch the room y of Sabreman.
  $E000,$06 Jump to #R$E01C if the stalactite is in a different room y.
  $E006,$04 Reset the countdown to #N$50.
  $E00A,$03 Jump to #R$96CB.
@ $E00D label=Handle_Falling_Stalactite_Next_Room
  $E00D,$04 Set the y position to #N$40.
  $E011,$03 Move the stalactite to the room below.
  $E014,$05 Return if the stalactite has not been drawn yet.
  $E019,$03 Erase the sprite of the stalactite.
@ $E01C label=Handle_Falling_Stalactite_Count_Down
  $E01C,$06 Decrease the countdown and jump to #R$B6E3 to remove the stalactite
. when it reaches zero.
  $E022,$04 Set bit 0 of the redraw flags, as the stalactite is not on the
. screen.
  $E026,$01 Return.

c $E027 Handle Rock Fragments
@ $E027 label=Handle_Rock_Fragments
D $E027 Handler for the object types #N$51 to #N$53 (the pieces of a stalactite
. that has landed). The counter in byte #N$06 goes up on every call. The type
. goes up by one on every second call, and when it would go past #N$53 the piece
. moves four pixels to the left and is destroyed (see #R$DF42). The piece is
. removed if Sabreman is not in the room.
R $E027 IX Object record
  $E027,$03 Save the state of the piece.
  $E02A,$03 Fetch the room x of Sabreman.
  $E02D,$06 Jump to #R$B6E3 to remove the piece if it is in a different room x.
  $E033,$03 Fetch the room y of Sabreman.
  $E036,$06 Jump to #R$B6E3 to remove the piece if it is in a different room y.
  $E03C,$03 Increase the counter.
  $E03F,$07 Jump to #R$96CB if the counter is odd.
  $E046,$03 Fetch the type.
  $E049,$01 Add one.
  $E04A,$04 Jump to #R$E054 if the type is past #N$53.
  $E04E,$03 Store the type.
  $E051,$03 Jump to #R$96CB.
@ $E054 label=Handle_Rock_Fragments_Explode
  $E054,$03 Fetch the x position.
  $E057,$02 Subtract four.
  $E059,$03 Store the x position.
  $E05C,$03 Destroy the piece.

c $E05F Spawn Bubble
@ $E05F label=Spawn_Bubble
D $E05F Starts a bubble at the bottom of the room every now and then.
.
. Nothing happens in a special room (a room y below #N$10), or when the type of
. Sabreman is #N$3C or more, which means that he is dying or being carried. The
. bubble takes one of the four bubble records that start at #R$8F5A, if
. one is free. A bubble is only made when the low byte of the frame counter plus
. #N$1A has its low six bits clear.
.
. The record is a copy of the record of Sabreman, so the bubble is in his room.
. Its type is #N$58, its y position is #N$BF (the bottom of the room), its
. attribute is #N$46 (yellow) and its x position is #N$40 or #N$C0, depending on
. bit 7 of the tick counter. The handler is #R$E117.
  $E05F,$03 Fetch the type of Sabreman.
  $E062,$03 Return if the type is #N$3C or more.
  $E065,$03 Fetch the room y of Sabreman.
  $E068,$03 Return if it is a special room.
  $E06B,$03 Point #REGhl at #R$8F5A.
  $E06E,$03 Set #REGde to the size of an object record.
  $E071,$02 Set a counter in #REGb for the four bubble records.
@ $E073 label=Spawn_Bubble_Find_Record
  $E073,$01 Fetch the type of the record.
  $E074,$03 Jump to #R$E07B if the record is free.
  $E077,$01 Move on to the next record.
  $E078,$02 Decrease the record counter and loop back for the next record.
  $E07A,$01 Return, as all four bubble records are in use.
@ $E07B label=Spawn_Bubble_Create
  $E07B,$01 Point #REGde at the free record.
  $E07C,$03 Point #REGhl at #R$8F1A.
  $E07F,$03 Fetch the low byte of the frame counter.
  $E082,$01 Add the low byte of the address of the record of Sabreman.
  $E083,$02,b$01 Keep only the low six bits.
  $E085,$01 Return unless they are zero.
  $E086,$03 Set a counter of #N$0F bytes.
  $E089,$01 Stash the address of the bubble record.
  $E08A,$02 Copy the record of Sabreman to the bubble record, except for the
. redraw flags.
  $E08C,$01 Restore the address of the bubble record to #REGhl.
  $E08D,$03 Set the type to #N$58.
  $E090,$03 Fetch the tick counter.
  $E093,$02,b$01 Keep only bit 7.
  $E095,$02 Add #N$40, which makes #N$40 or #N$C0.
  $E097,$01 Move to the x position.
  $E098,$01 Set the x position.
  $E099,$02 Move to the y position.
  $E09B,$02 Set the y position to #N$BF.
  $E09D,$02 Move to the attribute.
  $E09F,$02 Set the attribute to #N$46 (yellow).
  $E0A1,$02 #REGa=#N$01 (the value of the redraw flags).
  $E0A3,$03 Set the offset from the attribute to the redraw flags of the record
. (#N$000A).
  $E0A6,$01 Move to the redraw flags.
  $E0A7,$01 Set the redraw flags to #N$01, so that the bubble is drawn without
. being erased first.
  $E0A8,$01 Return.

c $E0A9 Release Bubble
@ $E0A9 label=Release_Bubble
D $E0A9 Lets an object (the object of type #N$54, see #R$AF3F) release a bubble
. every now and then. The bubble takes one of the four bubble records that start
. at #R$8F5A, if one is free. A bubble is only made when the low byte
. of the frame counter plus the low byte of the address of the object has its
. low six bits clear.
.
. The record is a copy of the record of the object, with the type #N$58 and an x
. position that is #N$0C more. The room is the room that Sabreman is in.
E $E0A9 View the equivalent code in;
. #LIST
. { #JETPAC$6F97 }
. { #LUNARJETMAN$9DC6 }
. LIST#
R $E0A9 IX Object record of the object that releases the bubble
  $E0A9,$03 Point #REGhl at the first bubble record.
  $E0AC,$03 Set #REGde to the size of an object record.
  $E0AF,$02 Set a counter in #REGb for the four bubble records.
@ $E0B1 label=Release_Bubble_Find_Record
  $E0B1,$01 Fetch the type of the record.
  $E0B2,$03 Jump to #R$E0B9 if the record is free.
  $E0B5,$01 Move on to the next record.
  $E0B6,$02 Decrease the record counter and loop back for the next record.
  $E0B8,$01 Return, as all four bubble records are in use.
@ $E0B9 label=Release_Bubble_Create
  $E0B9,$02 Point #REGhl at the record of the object, and #REGde at the free
. record.
  $E0BB,$01 Exchange #REGde and #REGhl.
  $E0BC,$01 Restore #REGhl from the stack.
  $E0BD,$03 Fetch the low byte of the frame counter.
  $E0C0,$01 Add the low byte of the address of the record of the object.
  $E0C1,$02,b$01 Keep only the low six bits.
  $E0C3,$01 Return unless they are zero.
  $E0C4,$03 Set a counter of #N$0F bytes.
  $E0C7,$01 Stash the address of the bubble record.
  $E0C8,$02 Copy the record of the object to the bubble record, except for the
. redraw flags.
  $E0CA,$01 Restore the address of the bubble record to #REGhl.
  $E0CB,$03 Set the type to #N$58.
  $E0CE,$03 Fetch the x position of the object.
  $E0D1,$02 Add #N$0C.
  $E0D3,$01 Move to the x position.
  $E0D4,$01 Set the x position.
  $E0D5,$01 Move to the room x.
  $E0D6,$03 Fetch the room x of Sabreman.
  $E0D9,$01 Set the room x.
  $E0DA,$02 Move to the room y.
  $E0DC,$03 Fetch the room y of Sabreman.
  $E0DF,$01 Set the room y.
  $E0E0,$02 #REGa=#N$01 (the value of the redraw flags).
  $E0E2,$03 Set the offset to the redraw flags of the record (#N$000B).
  $E0E5,$01 Move to the redraw flags.
  $E0E6,$01 Set the redraw flags to #N$01, so that the bubble is drawn without
. being erased first.
  $E0E7,$01 Return.

c $E0E8 Move Distant Bubble
@ $E0E8 label=Move_Distant_Bubble
D $E0E8 Moves a bubble that is not in the room that Sabreman is in. The bubble
. rises by two pixels each time. The countdown in byte #N$0A removes the bubble
. when it reaches zero. A bubble in a room with a ceiling is removed when it
. reaches the ceiling. A bubble in a room with no ceiling moves into the room
. above when it reaches the top.
R $E0E8 IX Object record
  $E0E8,$06 Decrease the countdown and jump to #R$B6E3 to remove the bubble when
. it reaches zero.
  $E0EE,$04 Set bit 0 of the redraw flags, as the bubble is not on the screen.
  $E0F2,$03 Fetch the y position.
  $E0F5,$02 Subtract two.
  $E0F7,$03 Store the y position.
  $E0FA,$06 Jump to #R$E106 if the room had no ceiling.
  $E100,$05 Remove the bubble if the y position is less than #N$42.
  $E105,$01 Return.
@ $E106 label=Move_Distant_Bubble_No_Ceiling
  $E106,$03 Return if the y position is #N$22 or more.
  $E109,$04 Set the y position to #N$BF.
  $E10D,$03 Move the bubble to the room above.
  $E110,$03 Read the world map entry of the room that the bubble is in now.
  $E113,$03 Store the flags of the room in the contact flags.
  $E116,$01 Return.

c $E117 Handle Bubble
@ $E117 label=Handle_Bubble
D $E117 Handler for the object types #N$58 to #N$5B (a bubble that rises). A
. bubble is made by #R$E05F, or by #R$E0A9.
.
. The bubble rises by two pixels on each call. The contact flags (byte #N$0B)
. are set to the flags of the room, which lets other objects stand on top of it
. (see #R$E1B4). The counter in byte #N$06 goes up on each call and makes the
. two low bits of the type, so the bubble goes through three frames.
.
. A bubble in a room with a ceiling bursts when it reaches the ceiling and
. becomes a sparkle (the type #N$72, see #R$E18C). A bubble in a room with no
. ceiling moves into the room above when it reaches the top. A bubble that has
. just been made in a room with a floor and a ceiling, and is #N$AF or more down
. the screen, is removed.
.
. If the bubble is in a different room from Sabreman, #R$E0E8 moves it.
R $E117 IX Object record
  $E117,$03 Save the state of the bubble.
  $E11A,$03 Fetch the room x of Sabreman.
  $E11D,$06 Jump to #R$E0E8 if the bubble is in a different room x.
  $E123,$03 Fetch the room y of Sabreman.
  $E126,$06 Jump to #R$E0E8 if the bubble is in a different room y.
  $E12C,$06 Move the bubble up two pixels.
  $E132,$04 Reset the countdown in byte #N$0A to #N$50.
  $E136,$03 Read the world map entry of the room that the bubble is in. The
. flags of the room are returned in #REGe.
  $E139,$03 Store the flags of the room in the contact flags.
  $E13C,$02 Test bit 0 of the flags (the ceiling).
  $E13E,$03 Fetch the y position.
  $E141,$02 Jump to #R$E16B if the room has no ceiling.
  $E143,$05 Jump to #R$E17A if the bubble has reached the ceiling.
  $E148,$04 Jump to #R$E15B if the y position is less than #N$AF.
  $E14C,$04 Jump to #R$E15B if the room has no floor.
  $E150,$06 Jump to #R$E15B if the bubble has been drawn already.
  $E156,$04 Remove the bubble.
  $E15A,$01 Return.
@ $E15B label=Handle_Bubble_Animate
  $E15B,$03 Add one to the animation counter of the bubble.
  $E15E,$03 Fetch the animation counter of the bubble.
  $E161,$02,b$01 Keep only the two low bits.
  $E163,$02 Add #N$58 to make the type.
  $E165,$03 Store the type.
  $E168,$03 Jump to #R$96CB.
@ $E16B label=Handle_Bubble_No_Ceiling
  $E16B,$04 Jump to #R$E15B if the bubble is still in the room.
  $E16F,$03 Move the bubble to the room above.
  $E172,$05 Return if the bubble has not been drawn yet.
  $E177,$03 Erase the sprite of the bubble.
@ $E17A label=Handle_Bubble_Pop
  $E17A,$07 Jump to #R$B6E3 to remove the bubble if it has not been drawn yet.
  $E181,$04 Change the bubble into a sparkle.
  $E185,$04 Set the counter in byte #N$08 to #N$03.
  $E189,$03 Jump to #R$96CB.

c $E18C Handle Sparkle
@ $E18C label=Handle_Sparkle
D $E18C Handler for the object types #N$72 and #N$73, the sparkle that shows
. where a bubble has burst (see #R$E117). The counter in byte #N$08 goes down on
. each call and the sprite id alternates between #N$72 and #N$73 with it. The
. sparkle is removed (and erased) when the counter reaches zero, and at once if
. Sabreman is not in the room.
R $E18C IX Object record
  $E18C,$03 Save the state of the sparkle.
  $E18F,$03 Fetch the room x of Sabreman.
  $E192,$06 Jump to #R$B6E3 to remove the sparkle if it is in a different room
. x.
  $E198,$03 Fetch the room y of Sabreman.
  $E19B,$06 Jump to #R$B6E3 to remove the sparkle if it is in a different room
. y.
  $E1A1,$06 Decrease the counter and jump to #R$B6D3 to remove and erase the
. sparkle when it reaches zero.
  $E1A7,$03 Fetch the counter.
  $E1AA,$02,b$01 Keep only bit 0.
  $E1AC,$02 Add #N$72 to make the sprite id.
  $E1AE,$03 Store the sprite id.
  $E1B1,$03 Jump to #R$96CB.

c $E1B4 Check Bubble Contact
@ $E1B4 label=Check_Bubble_Contact
D $E1B4 Checks whether an object is touching one of the four bubbles (the object
. records that start at #R$8F5A and have the type #N$58 to #N$5B).
.
. No bubble is touched if bit 4 or bit 5 of the countdown in byte #N$0A is set.
. This is the case for Sabreman for a while after he has started to fall, and it
. lets him get away from a bubble.
.
. An object touches a bubble when the two are in the same room, the x positions
. differ by less than #N$0D and the y position of the object is between zero and
. #N$0E pixels above the y position of the bubble.
.
. When there is contact the result in #REGc has bit 2 and bit 1 set (a bubble is
. always taken as being under the object). Bit 7 is set if the object is to the
. right of the bubble. Bits 5 and 0 are set if the x positions differ by #N$0A
. or more, which means that the object is not near the middle of the bubble.
. Otherwise the y position of the object is set to #N$0E less than that of the
. bubble so that it stands on it, and bit 4 of #REGe and bit 4 of the contact
. flags (byte #N$0B) are set.
.
. If the object is Sabreman (the type is between #N$09 and #N$1B) and he is
. touching a bubble while he is near the top of the room (the y position is less
. than #N$48) then the bubble pushes him up. In a room with a ceiling he starts
. tumbling (see #R$E272), which draws him and ends the handler that called this
. routine. In a room with no ceiling he moves into the room above, if his y
. position is less than #N$2C. The y position then becomes #N$AF, the first
. bubble record becomes a copy of the record of Sabreman as a bubble (#N$58) at
. the y position #N$B8, and the new room is drawn.
R $E1B4 IX Object record
R $E1B4 E Flags of the room (see #R$98CC)
R $E1B4 O:B #N$A0 less the y position of the object (valid when there is
. contact)
R $E1B4 O:C Contact result
R $E1B4 O:E Flags of the room, with bit 4 set if the object stands on a bubble
  $E1B4,$02 Set the contact result to zero.
  $E1B6,$03 Fetch the countdown.
  $E1B9,$02,b$01 Keep only bits 4 and 5.
  $E1BB,$01 Return if either of them is set.
  $E1BC,$01 Stash the flags of the room.
  $E1BD,$03 Point #REGhl at #R$8F5A.
  $E1C0,$03 Set #REGde to the size of an object record.
  $E1C3,$02 Set a counter in #REGb for the four bubble records.
@ $E1C5 label=Check_Bubble_Contact_Loop
  $E1C5,$01 Fetch the type of the record.
  $E1C6,$02,b$01 Ignore the two low bits.
  $E1C8,$04 Jump to #R$E1D6 if the record holds a bubble.
@ $E1CC label=Check_Bubble_Contact_Next_Record
  $E1CC,$01 Move on to the next record.
  $E1CD,$02 Decrease the record counter and loop back for the next record.
  $E1CF,$02 Clear the contact result, as no bubble was touched.
  $E1D1,$01 Restore the flags of the room.
  $E1D2,$01 Return.
@ $E1D3 label=Check_Bubble_Contact_Skip
  $E1D3,$01 Discard the address of the bubble record.
  $E1D4,$02 Jump to #R$E1CC to try the next bubble.
@ $E1D6 label=Check_Bubble_Contact_Found
  $E1D6,$01 Stash the address of the bubble record.
  $E1D7,$02 Clear the contact result.
  $E1D9,$01 Point #REGhl at the x position of the bubble.
  $E1DA,$01 Fetch the x position of the bubble.
  $E1DB,$06 Jump to #R$E1E5 if the object is not to the right of the bubble.
  $E1E1,$02 Make the difference positive.
  $E1E3,$02 Set bit 7 of the contact result, as the object is to the right of
. the bubble.
@ $E1E5 label=Check_Bubble_Contact_Check_Width
  $E1E5,$04 Jump to #R$E1D3 if the difference is #N$0D or more.
  $E1E9,$04 Jump to #R$E1F1 if the difference is less than #N$0A.
  $E1ED,$02 Set bit 5 of the contact result.
  $E1EF,$02 Set bit 0 of the contact result.
@ $E1F1 label=Check_Bubble_Contact_Check_Room
  $E1F1,$01 Point #REGhl at the room x of the bubble.
  $E1F2,$01 Fetch the room x of the bubble.
  $E1F3,$05 Jump to #R$E1D3 if the bubble is in a different room x.
  $E1F8,$01 Point #REGhl at the y position of the bubble.
  $E1F9,$01 Fetch the y position of the bubble.
  $E1FA,$03 Subtract the y position of the object.
  $E1FD,$04 Jump to #R$E1D3 if the object is more than #N$0E above the bubble,
. or below it.
  $E201,$01 Point #REGhl at the room y of the bubble.
  $E202,$01 Fetch the room y of the bubble.
  $E203,$05 Jump to #R$E1D3 if the bubble is in a different room y.
  $E208,$01 Point #REGhl at the y position of the bubble again.
  $E209,$02 Set bit 2 of the contact result (contact).
  $E20B,$02 Set bit 1 of the contact result (the object is on top).
  $E20D,$04 Jump to #R$E217 if the object is not near the middle of the bubble.
  $E211,$01 Fetch the y position of the bubble.
  $E212,$02 Subtract #N$0E.
  $E214,$03 Set the y position of the object, so that it stands on the bubble.
@ $E217 label=Check_Bubble_Contact_Set_Height
  $E217,$03 Fetch the y position of the object.
  $E21A,$02 Subtract #N$A0.
  $E21C,$02 Negate it.
  $E21E,$01 Store the result in #REGb.
  $E21F,$01 Discard the address of the bubble record.
  $E220,$01 Restore the flags of the room to #REGe.
  $E221,$04 Jump to #R$E22B if the object is not near the middle of the bubble.
  $E225,$02 Set bit 4 of the flags of the room (the floor).
  $E227,$04 Set bit 4 of the contact flags (standing).
@ $E22B label=Check_Bubble_Contact_Check_Type
  $E22B,$03 Fetch the type of the object.
  $E22E,$03 Return if the type is #N$1C or more.
  $E231,$03 Return if the type is less than #N$09.
  $E234,$03 Fetch the y position of the object.
  $E237,$03 Return if it is #N$48 or more.
  $E23A,$04 Jump to #R$E271 if the room has a ceiling.
  $E23E,$03 Return if the y position is #N$2C or more.
  $E241,$03 Move Sabreman to the room above.
  $E244,$04 Set his y position to #N$AF.
  $E248,$02 Set #REGb to #N$F1, which is #N$A0 less the new y position.
  $E24A,$01 Stash the flags of the room.
  $E24B,$01 Stash the contact result and #REGb.
  $E24C,$03 Point #REGde at #R$8F5A.
  $E24F,$03 Point #REGhl at #R$8F1A.
  $E252,$03 Set a counter of #N$0F bytes.
  $E255,$02 Copy the record of Sabreman to the bubble record.
  $E257,$02 Set the y position of the bubble to #N$B8.
  $E259,$03 Store the y position of the bubble.
  $E25C,$02 Set the type of the bubble to #N$58.
  $E25E,$03 Store the type of the bubble.
  $E261,$02 Set the redraw flags of the bubble to #N$01.
  $E263,$03 Store the redraw flags of the bubble.
  $E266,$02 Set the attribute of the bubble to #N$46 (yellow).
  $E268,$03 Store the attribute of the bubble.
  $E26B,$03 Draw the room.
  $E26E,$01 Restore the contact result and #REGb.
  $E26F,$01 Restore the flags of the room.
  $E270,$01 Return.
@ $E271 label=Check_Bubble_Contact_Tumble
  $E271,$01 Discard the return address, so that the handler of Sabreman that
. called this routine stops here.

c $E272 Start Tumbling Downwards
@ $E272 label=Start_Tumbling_Downwards
D $E272 Makes Sabreman tumble downwards, as when a bubble pushes him against a
. ceiling. The sprite becomes #N$18, the countdown (byte #N$0A) is set to #N$1A
. and the y velocity to #N$20.
.
. The routine ends by drawing Sabreman and returning to the main loop.
R $E272 IX Object record of Sabreman
  $E272,$04 Set the sprite id to #N$18 (tumbling).
  $E276,$04 Set the countdown to #N$1A.
  $E27A,$04 Set the y velocity to #N$20.
  $E27E,$04 Clear the contact flags.
  $E282,$03 Jump to #R$96CB.

c $E285 Check Sabreman Contact
@ $E285 label=Check_Sabreman_Contact
D $E285 Checks whether an object is touching Sabreman.
.
. Nothing is touched if the sprite id of Sabreman is #N$1D or more (he is dying
. or being carried), or if bit 6 of his redraw flags is set (he is being
. carried).
.
. There is contact when the two are in the same room, the x positions differ by
. less than #N$10 and the y position of Sabreman, less four, differs from that
. of the object by less than #N$0A. A tone is played on contact (see #R$A0F5).
R $E285 IX Object record
R $E285 O:C Contact result
  $E285,$02 Clear the contact result.
  $E287,$03 Fetch the sprite id of Sabreman.
  $E28A,$03 Return if it is #N$1D or more.
@ $E28D label=Check_Sabreman_Contact_Clear_Result
  $E28D,$02 Clear the contact result.
  $E28F,$03 Fetch the redraw flags of Sabreman.
  $E292,$02,b$01 Keep only bit 6.
  $E294,$01 Return if Sabreman is being carried.
  $E295,$03 Point #REGhl at #R$8F1B.
  $E298,$01 Fetch the x position of Sabreman.
  $E299,$06 Subtract the x position of the object, and jump to #R$E2A3 if
. Sabreman is not to the left of it.
  $E29F,$02 Set bit 7 of the contact result, as Sabreman is to the left of the
. object.
  $E2A1,$02 Make the difference positive.
@ $E2A3 label=Check_Sabreman_Contact_Check_Width
  $E2A3,$03 Return if the difference is #N$10 or more.
  $E2A6,$01 Point #REGhl at the room x of Sabreman.
  $E2A7,$01 Fetch the room x of Sabreman.
  $E2A8,$04 Return if Sabreman is in a different room x from the object.
  $E2AC,$01 Point #REGhl at the y position of Sabreman.
  $E2AD,$01 Fetch the y position of Sabreman.
  $E2AE,$02 Subtract four.
  $E2B0,$06 Subtract the y position of the object, and jump to #R$E2BA if
. Sabreman is not above it.
  $E2B6,$02 Make the difference positive.
  $E2B8,$02 Set bit 1 of the contact result, as Sabreman is above the object.
@ $E2BA label=Check_Sabreman_Contact_Check_Height
  $E2BA,$03 Return if the difference is #N$0A or more.
  $E2BD,$01 Point #REGhl at the room y of Sabreman.
  $E2BE,$01 Fetch the room y of Sabreman.
  $E2BF,$04 Return if Sabreman is in a different room y from the object.
  $E2C3,$02 Set bit 2 of the contact result (contact).
  $E2C5,$01 Stash the contact result.
  $E2C6,$03 Play a tone.
  $E2C9,$01 Restore the contact result.
  $E2CA,$01 Return.

c $E2CB Handle Carrying Eagle
@ $E2CB label=Handle_Carrying_Eagle
D $E2CB Handler for the object types #N$5C to #N$5F, an eagle that carries
. Sabreman (see #R$B079). Bit 0 of the type is the frame of the animation, which
. follows bit 1 of the tick counter, and bit 1 is set when the x velocity is
. negative.
.
. While Sabreman is being carried his record has the sprite id #N$60 to #N$63.
. The eagle puts his position in bytes #N$08 (x) and #N$09 (y) of his record (at
. #R$8F22 and #R$8F23), where #R$E570 picks it up. The y
. position is #N$10 more than that of the eagle, so he hangs below it.
.
. The eagle flies towards a target (byte #N$0C is the x position and byte #N$0E
. the y position, see #R$B73F). Each call changes each velocity by one towards
. the target. The x velocity is kept between #N$D0 and #N$37 and the y velocity
. between #N$C7 and #N$37. The target changes when the eagle bounces off a
. decoration, a bubble, the floor, the ceiling or a wall. The eagle can also fly
. through the gaps in the frame of a room, and into the next room. The player
. can nudge the eagle with the controls (see #R$E420).
.
. The eagle lets go (see #R$E51B) when the low byte of FRAMES is zero, or when
. Sabreman has set bit 5 of his redraw flags, if it is in the open part of the
. room. If the sprite id of Sabreman is less than #N$1C (he is not being
. carried), the eagle lets go at once (see #R$E556).
R $E2CB IX Object record of the eagle
  $E2CB,$03 Save the state of the eagle.
  $E2CE,$03 Fetch the sprite id of Sabreman.
  $E2D1,$05 Jump to #R$E556 if he is not being carried.
  $E2D6,$03 Nudge the eagle if the player presses a direction.
  $E2D9,$03 Read the world map entry of the room that the eagle is in. The flags
. of the room are returned in #REGe.
  $E2DC,$03 Fetch the low byte of FRAMES.
  $E2DF,$04 Call #R$E51B to let go of Sabreman if the low byte of FRAMES is
. zero.
  $E2E3,$03 Fetch the redraw flags of Sabreman.
  $E2E6,$02 Test bit 5, which Sabreman sets to ask the eagle to let go.
  $E2E8,$02 Reset bit 5.
  $E2EA,$03 Store the redraw flags of Sabreman.
  $E2ED,$03 Call #R$E51B to let go of Sabreman if bit 5 was set.
@ $E2F0 label=Handle_Carrying_Eagle_Carry
  $E2F0,$05 Set the flag at #R$8EF1 to show that an eagle is carrying Sabreman.
  $E2F5,$03 Fetch the y position of the eagle.
  $E2F8,$02 Add #N$10.
  $E2FA,$04 Jump to #R$E304 if the result is less than #N$9F.
  $E2FE,$04 Jump to #R$E304 if the room has no floor.
  $E302,$02 Limit the y position to #N$9F.
@ $E304 label=Handle_Carrying_Eagle_Set_Carry_Position
  $E304,$03 Set the y position of Sabreman.
  $E307,$03 Fetch the x position of the eagle.
  $E30A,$03 Set the x position of Sabreman.
N $E30D Work out the type of the eagle. Bit 0 follows bit 1 of the tick counter
. and bit 1 is set when the x velocity is negative.
  $E30D,$03 Fetch the type of the eagle.
  $E310,$02,b$01 Reset bit 0.
  $E312,$01 Keep the type without bit 0 in #REGc.
  $E313,$03 Fetch the tick counter.
  $E316,$01 Move bit 1 into bit 0.
  $E317,$02,b$01 Keep only that bit.
  $E319,$01 Add the type.
  $E31A,$06 Jump to #R$E324 if the x velocity is positive.
  $E320,$02,b$01 Set bit 1.
  $E322,$02 Jump to #R$E326.
@ $E324 label=Handle_Carrying_Eagle_Face_Right
  $E324,$02,b$01 Reset bit 1.
@ $E326 label=Handle_Carrying_Eagle_Store_Type
  $E326,$03 Store the type of the eagle.
N $E329 Change the x velocity by one towards the target.
  $E329,$03 Fetch the x position of the eagle.
  $E32C,$03 Compare it with the x position of the target.
  $E32F,$03 Fetch the x velocity.
  $E332,$03 Jump to #R$E443 if the eagle is at or to the right of the target.
  $E335,$01 Add one to the x velocity.
  $E336,$04 Jump to #R$E33E if the x velocity is negative.
  $E33A,$04 Jump to #R$E341 if the x velocity has reached #N$38.
@ $E33E label=Handle_Carrying_Eagle_Store_X_Velocity
  $E33E,$03 Store the x velocity.
@ $E341 label=Handle_Carrying_Eagle_Adjust_Y_Velocity
N $E341 Change the y velocity by one towards the target.
  $E341,$03 Fetch the y position of the eagle.
  $E344,$03 Compare it with the y position of the target.
  $E347,$03 Fetch the y velocity.
  $E34A,$03 Jump to #R$E451 if the eagle is at or below the target.
  $E34D,$01 Add one to the y velocity.
  $E34E,$04 Jump to #R$E356 if the y velocity is negative.
  $E352,$04 Jump to #R$E359 if the y velocity has reached #N$38.
@ $E356 label=Handle_Carrying_Eagle_Store_Y_Velocity
  $E356,$03 Store the y velocity.
@ $E359 label=Handle_Carrying_Eagle_Check_Contact
N $E359 Check for contact with the decorations and the bubbles, and bounce off
. them.
  $E359,$01 Stash the flags of the room.
  $E35A,$03 Check for contact with the decorations.
  $E35D,$01 Store the result in #REGd.
  $E35E,$03 Check for contact with the bubbles.
  $E361,$01 Copy the result to #REGa.
  $E362,$01 Combine it with the result for the decorations.
  $E363,$01 Store the combined result in #REGc.
  $E364,$01 Restore the flags of the room.
  $E365,$04 Jump to #R$E3AF if the eagle is not touching anything.
  $E369,$04 Jump to #R$E381 if the eagle is not on top of the object.
  $E36D,$04 Jump to #R$E390 if the object is a bubble and the eagle is away from
. the middle of it.
  $E371,$03 Fetch the y velocity.
  $E374,$04 Jump to #R$E3AF if the eagle is moving up already.
  $E378,$01 Invert the y velocity, to send the eagle up.
  $E379,$03 Store the y velocity.
  $E37C,$03 Choose a new target.
  $E37F,$02 Jump to #R$E3AF.
@ $E381 label=Handle_Carrying_Eagle_Check_Underside
  $E381,$04 Jump to #R$E390 if the eagle is not near the middle of the object.
  $E385,$03 Fetch the y velocity.
  $E388,$04 Jump to #R$E390 if the eagle is moving down already.
  $E38C,$01 Invert the y velocity, to send the eagle down.
  $E38D,$03 Store the y velocity.
@ $E390 label=Handle_Carrying_Eagle_Check_Sides
  $E390,$03 Fetch the x velocity.
  $E393,$04 Jump to #R$E3A4 if the eagle is not to the right of the object.
  $E397,$04 Jump to #R$E3AF if the eagle is moving to the right already.
  $E39B,$01 Invert the x velocity.
  $E39C,$03 Store the x velocity.
  $E39F,$03 Choose a new target.
  $E3A2,$02 Jump to #R$E3AF.
@ $E3A4 label=Handle_Carrying_Eagle_Bounce_Left
  $E3A4,$04 Jump to #R$E3AF if the eagle is moving to the left already.
  $E3A8,$01 Invert the x velocity.
  $E3A9,$03 Store the x velocity.
  $E3AC,$03 Choose a new target.
@ $E3AF label=Handle_Carrying_Eagle_Move_X
N $E3AF Move the eagle horizontally.
  $E3AF,$03 Fetch the contact flags.
  $E3B2,$02,b$01 Reset bits 0 and 4 (the ceiling and the floor).
  $E3B4,$03 Store the contact flags.
  $E3B7,$03 Fetch the x velocity into #REGl.
  $E3BA,$02 Test the sign of the x velocity.
  $E3BC,$02 Clear the high byte of the x velocity (as a word).
  $E3BE,$02 Jump to #R$E3C2 if the x velocity is positive.
  $E3C0,$02 Set the high byte of the x velocity to #N$FF to extend the sign.
@ $E3C2 label=Handle_Carrying_Eagle_Set_Sabreman_Velocity
  $E3C2,$01 Copy the x velocity to #REGa.
  $E3C3,$08 Divide it by sixteen, keeping its sign.
  $E3CB,$03 Set the x velocity of Sabreman.
  $E3CE,$03 Move the eagle horizontally (see #R$EE42). The new x position is
. returned in #REGa.
  $E3D1,$03 Jump to #R$E45F if the new x position is less than #N$80.
  $E3D4,$04 Jump to #R$E3E9 if the new x position is less than #N$D0.
  $E3D8,$05 Jump to #R$E47E if the room has no wall on the right.
  $E3DD,$03 Fetch the x velocity.
  $E3E0,$01 Invert it.
  $E3E1,$03 Store the x velocity.
  $E3E4,$03 Choose a new target.
  $E3E7,$02 Set the x position to #N$CF.
@ $E3E9 label=Handle_Carrying_Eagle_Store_X
  $E3E9,$03 Store the x position.
  $E3EC,$03 Fetch the contact flags.
  $E3EF,$02,b$01 Reset bits 2 and 6 (the right and left walls).
  $E3F1,$03 Store the contact flags.
N $E3F4 Move the eagle vertically.
  $E3F4,$03 Fetch the y velocity into #REGl.
  $E3F7,$02 Test the sign of the y velocity.
  $E3F9,$02 Clear the high byte of the y velocity (as a word).
  $E3FB,$02 Jump to #R$E3FF if the y velocity is positive.
  $E3FD,$02 Set the high byte of the y velocity to #N$FF to extend the sign.
@ $E3FF label=Handle_Carrying_Eagle_Move_Y
  $E3FF,$03 Move the eagle vertically (see #R$EE54). The new y position is
. returned in #REGa.
  $E402,$03 Jump to #R$E496 if the new y position is less than #N$80.
  $E405,$04 Jump to #R$E41A if the new y position is less than #N$9F.
  $E409,$05 Jump to #R$E4B6 if the room has no floor.
  $E40E,$03 Fetch the y velocity.
  $E411,$01 Invert it.
  $E412,$03 Store the y velocity.
  $E415,$03 Choose a new target.
  $E418,$02 Set the y position to #N$9F.
@ $E41A label=Handle_Carrying_Eagle_Store_Y
  $E41A,$03 Store the y position.
  $E41D,$03 Jump to #R$96CB.

c $E420 Steer Eagle
@ $E420 label=Steer_Eagle
D $E420 Moves the eagle by one pixel in the direction that the player is
. pressing. If more than one direction is pressed, right has priority, then
. left, up and down.
R $E420 IX Object record of the eagle
  $E420,$03 Read the controls (see #R$AE17).
  $E423,$04 Jump to #R$E433 if right is pressed.
  $E427,$04 Jump to #R$E437 if left is pressed.
  $E42B,$04 Jump to #R$E43B if up is pressed.
  $E42F,$04 Jump to #R$E43F if down is pressed.
@ $E433 label=Steer_Eagle_Right
  $E433,$03 Move the eagle one pixel to the right.
  $E436,$01 Return.
@ $E437 label=Steer_Eagle_Left
  $E437,$03 Move the eagle one pixel to the left.
  $E43A,$01 Return.
@ $E43B label=Steer_Eagle_Up
  $E43B,$03 Move the eagle one pixel up.
  $E43E,$01 Return.
@ $E43F label=Steer_Eagle_Down
  $E43F,$03 Move the eagle one pixel down.
  $E442,$01 Return.

c $E443 Accelerate Eagle Left
@ $E443 label=Accelerate_Eagle_Left
D $E443 Decreases the x velocity of the eagle by one, but not below #N$D0, as
. the eagle is to the right of its target.
R $E443 A X velocity of the eagle
R $E443 IX Object record of the eagle
  $E443,$01 Subtract one from the x velocity.
  $E444,$05 Jump to #R$E33E to store it if it is positive.
  $E449,$05 Jump to #R$E341 without storing it if it is less than #N$D0.
  $E44E,$03 Jump to #R$E33E to store it.

c $E451 Accelerate Eagle Up
@ $E451 label=Accelerate_Eagle_Up
D $E451 Decreases the y velocity of the eagle by one, but not below #N$C7, as
. the eagle is below its target.
R $E451 A Y velocity of the eagle
R $E451 IX Object record of the eagle
  $E451,$01 Subtract one from the y velocity.
  $E452,$05 Jump to #R$E356 to store it if it is positive.
  $E457,$05 Jump to #R$E359 without storing it if it is less than #N$C7.
  $E45C,$03 Jump to #R$E356 to store it.

c $E45F Limit Eagle Sideways Movement
@ $E45F label=Limit_Eagle_Sideways_Movement
D $E45F Deals with an eagle that has moved to a new x position that is outside
. the main part of the room.
.
. The first entry point is for an x position below #N$80, and the second
. (#R$E47E) for an x position of #N$D0 or more in a room that has no wall on the
. right. The eagle bounces off a wall on the left, flies through the gaps in the
. frame of the room and goes into the next room when it reaches the edge.
.
. A gap sets bits 0 and 4 of the contact flags and of the flags of the room, so
. that the eagle bounces off it like it would off a ceiling or a floor.
R $E45F A New x position of the eagle
R $E45F E Flags of the room
R $E45F IX Object record of the eagle
  $E45F,$05 Jump to #R$E3E9 to store the x position if it is #N$18 or more.
  $E464,$04 Jump to #R$E477 if the room has no wall on the left.
  $E468,$03 Fetch the x velocity.
  $E46B,$01 Invert it.
  $E46C,$03 Store the x velocity.
  $E46F,$03 Choose a new target.
  $E472,$02 Set the x position to #N$18.
  $E474,$03 Jump to #R$E3E9.
@ $E477 label=Limit_Eagle_Sideways_Movement_Left_Gap
  $E477,$04 Jump to #R$E485 if the x position is #N$08 or more, as the eagle is
. in the gap.
  $E47B,$03 Jump to #R$E4F6 to move the eagle into the next room on the left.
@ $E47E label=Limit_Eagle_Sideways_Movement_Right_Gap
  $E47E,$04 Jump to #R$E485 if the x position is less than #N$E7, as the eagle
. is in the gap.
  $E482,$03 Jump to #R$E50E to move the eagle into the next room on the right.
@ $E485 label=Limit_Eagle_Sideways_Movement_In_Gap
  $E485,$01 Save the x position.
  $E486,$03 Fetch the contact flags.
  $E489,$02,b$01 Set bits 0 and 4.
  $E48B,$03 Store the contact flags.
  $E48E,$01 Copy the flags of the room to #REGa.
  $E48F,$02,b$01 Set bits 0 and 4.
  $E491,$01 Store the result in #REGe.
  $E492,$01 Restore the x position.
  $E493,$03 Jump to #R$E3E9 to store the x position.

c $E496 Limit Eagle Vertical Movement
@ $E496 label=Limit_Eagle_Vertical_Movement
D $E496 Deals with an eagle that has moved to a new y position that is outside
. the main part of the room.
.
. The first entry point is for a y position of less than #N$80 (at the top of
. the room) and the second (#R$E4B6) for a y position of #N$9F or more in a room
. that has no floor. The eagle bounces off a ceiling, flies through the gaps in
. the frame of the room and goes into the next room when it reaches the edge.
.
. A gap sets bits 2 and 6 of the contact flags, so that the eagle bounces off it
. like it would off a wall.
R $E496 A New y position of the eagle
R $E496 E Flags of the room
R $E496 IX Object record of the eagle
  $E496,$05 Jump to #R$E41A to store the y position if it is #N$4C or more.
  $E49B,$05 Jump to #R$E4AF if the room has no ceiling.
  $E4A0,$03 Fetch the y velocity.
  $E4A3,$01 Invert it.
  $E4A4,$03 Store the y velocity.
  $E4A7,$03 Choose a new target.
  $E4AA,$02 Set the y position to #N$4C.
  $E4AC,$03 Jump to #R$E41A.
@ $E4AF label=Limit_Eagle_Vertical_Movement_Top_Gap
  $E4AF,$04 Jump to #R$E4BD if the y position is #N$28 or more, as the eagle is
. in the gap.
  $E4B3,$03 Jump to #R$E4CA to move the eagle into the next room above.
@ $E4B6 label=Limit_Eagle_Vertical_Movement_Bottom_Gap
  $E4B6,$04 Jump to #R$E4BD if the y position is less than #N$AF, as the eagle
. is in the gap.
  $E4BA,$03 Jump to #R$E4E7 to move the eagle into the next room below.
@ $E4BD label=Limit_Eagle_Vertical_Movement_In_Gap
  $E4BD,$01 Save the y position.
  $E4BE,$03 Fetch the contact flags.
  $E4C1,$02,b$01 Set bits 2 and 6.
  $E4C3,$03 Store the contact flags.
  $E4C6,$01 Restore the y position.
  $E4C7,$03 Jump to #R$E41A to store the y position.

c $E4CA Move Eagle To Next Room
@ $E4CA label=Move_Eagle_To_Next_Room
D $E4CA Moves the eagle and Sabreman into the next room. There is an entry point
. for each direction, and the first one (#R$E4CA) is for the room above. The
. eagle and Sabreman are put at the opposite edge of the new room, and the room
. is drawn.
R $E4CA IX Object record of the eagle
  $E4CA,$03 Move the eagle to the room above.
  $E4CD,$05 Set the y position of the eagle to #N$A8.
  $E4D2,$05 Set the y position of Sabreman to #N$B8.
@ $E4D7 label=Move_Eagle_To_Next_Room_Set_Room_Y
  $E4D7,$03 Fetch the room y of the eagle.
  $E4DA,$03 Set the room y of Sabreman.
@ $E4DD label=Move_Eagle_To_Next_Room_Draw
  $E4DD,$04 Set the redraw flags of the eagle to #N$01, so that it is drawn
. without being erased first.
  $E4E1,$03 Draw the eagle.
  $E4E4,$03 Jump to #R$9906.
@ $E4E7 label=Move_Eagle_To_Room_Below
  $E4E7,$03 Move the eagle to the room below.
  $E4EA,$05 Set the y position of the eagle to #N$28.
  $E4EF,$05 Set the y position of Sabreman to #N$38.
  $E4F4,$02 Jump to #R$E4D7.
@ $E4F6 label=Move_Eagle_To_Room_On_Left
  $E4F6,$03 Move the eagle to the room on the left.
  $E4F9,$08 Set the x position of the eagle and of Sabreman to #N$E7.
@ $E501 label=Move_Eagle_To_Next_Room_Set_Room_X
  $E501,$03 Fetch the room x of the eagle.
  $E504,$03 Set the room x of Sabreman.
  $E507,$05 Set the contact flags of Sabreman to #N$11.
  $E50C,$02 Jump to #R$E4DD.
@ $E50E label=Move_Eagle_To_Room_On_Right
  $E50E,$03 Move the eagle to the room on the right.
  $E511,$08 Set the x position of the eagle and of Sabreman to #N$08.
  $E519,$02 Jump to #R$E501.

c $E51B Check Eagle Release
@ $E51B label=Check_Eagle_Release
D $E51B Makes the eagle let go of Sabreman, if it is in the open part of the
. room (the x position is from #N$18 to #N$CF and the y position is from #N$48
. to #N$9F). If it is not, the routine returns and the eagle goes on carrying
. him.
.
. When the eagle lets go, the routine does not return to its caller but carries
. on at #R$E556, which ends the handler. The position of Sabreman is set to the
. position of the eagle, #N$10 further down but no lower than #N$9F if the room
. has a floor. The contact flags of Sabreman and the target of the eagle are
. cleared.
R $E51B IX Object record of the eagle
R $E51B E Flags of the room
  $E51B,$01 Disable interrupts.
  $E51C,$03 Fetch the x position of the eagle.
  $E51F,$03 Return if it is less than #N$18.
  $E522,$03 Return if it is #N$D0 or more.
  $E525,$03 Fetch the y position of the eagle.
  $E528,$03 Return if it is less than #N$48.
  $E52B,$03 Return if it is #N$A0 or more.
  $E52E,$01 Discard the return address.
  $E52F,$03 Fetch the contact flags.
  $E532,$01 Combine them with the flags of the room.
  $E533,$01 Store the result in #REGe.
  $E534,$03 Fetch the y position of the eagle.
  $E537,$02 Add #N$10.
  $E539,$04 Jump to #R$E543 if the room has no floor.
  $E53D,$04 Jump to #R$E543 if the result is less than #N$9F.
  $E541,$02 Limit the y position to #N$9F.
@ $E543 label=Check_Eagle_Release_Set_Position
  $E543,$03 Set the y position of Sabreman.
  $E546,$03 Fetch the x position of the eagle.
  $E549,$03 Set the x position of Sabreman.
  $E54C,$04 Clear the contact flags of Sabreman.
  $E550,$03 Clear the x position of the target.
  $E553,$03 Clear the y position of the target.

c $E556 Release Sabreman
@ $E556 label=Release_Sabreman
D $E556 Makes the eagle let go of Sabreman. Bit 6 of the redraw flags of
. Sabreman is set, and when #R$E570 sees that bit it makes him tumble.
.
. If bit 7 of the redraw flags of Sabreman is set (he has been hit while he was
. being carried) bit 7 is reset and the eagle is destroyed (see #R$DF42).
. Otherwise the eagle becomes the type #N$30 and flies away upwards, with a y
. velocity of #N$F0.
.
. The handler of the eagle also comes here when Sabreman is not being carried.
R $E556 IX Object record of the eagle
  $E556,$03 Fetch the redraw flags of Sabreman.
  $E559,$02,b$01 Set bit 6.
  $E55B,$02 Test bit 7.
  $E55D,$02 Reset bit 7.
  $E55F,$03 Store the redraw flags of Sabreman.
  $E562,$03 Jump to #R$DF42 to destroy the eagle if bit 7 was set.
  $E565,$04 Change the eagle into a flying eagle.
  $E569,$04 Set the y velocity to #N$F0.
  $E56D,$03 Jump to #R$96CB.

c $E570 Handle Carried Sabreman
@ $E570 label=Handle_Carried_Sabreman
D $E570 Handler for the object types #N$60 to #N$63, which are the sprites of
. Sabreman while an eagle carries him (see #R$E2CB). Bit 1 of the type is set
. when he moves to the left and bit 0 follows bit 1 of the tick counter.
.
. His position is taken from bytes #N$08 (x) and #N$09 (y) of his record, which
. the eagle sets. If bit 7 of the redraw flags is set (he has been hit) bit 5 is
. set to ask the eagle to let go, and the countdown in byte #N$0A is set to
. #N$0F.
.
. If no eagle was carrying him in the last pass of the main loop (see #R$8EF2)
. he drops, and so does he when bit 6 of the redraw flags is set (see #R$E556).
. He starts to tumble, with the sprite id #N$18 and a y velocity of #N$10.
.
. Touching a decoration puts him on top of it when he is on top of it or near
. its middle. If he touches the side of one he sets bit 5 to ask the eagle to
. let go. He is kept within the walls of the room. If the fire key is pressed he
. throws a weapon (see #R$B4D1).
R $E570 IX Object record of Sabreman
  $E570,$03 Save the state of Sabreman.
  $E573,$07 Jump to #R$E582 if bit 7 of the redraw flags is reset.
  $E57A,$04 Set bit 5 of the redraw flags, to ask the eagle to let go.
  $E57E,$04 Set the countdown to #N$0F.
@ $E582 label=Handle_Carried_Sabreman_Update
  $E582,$03 Fetch the x position that the eagle has set.
  $E585,$03 Subtract the current x position.
  $E588,$02 Rotate bit 6 of the result into bit 1.
  $E58A,$02,b$01 Keep only bit 1, which is set when he is moving to the left.
  $E58C,$01 Store the result in #REGc.
  $E58D,$03 Fetch the tick counter.
  $E590,$01 Move bit 1 into bit 0.
  $E591,$02,b$01 Keep only that bit.
  $E593,$01 Add the direction bit.
  $E594,$01 Store the result in #REGc.
  $E595,$03 Fetch the type.
  $E598,$02,b$01 Reset bits 0 and 1.
  $E59A,$01 Add the frame and direction bits.
  $E59B,$03 Store the type.
  $E59E,$03 Fetch the y position that the eagle has set.
  $E5A1,$03 Set the y position of Sabreman.
  $E5A4,$03 Fetch the x position that the eagle has set.
  $E5A7,$03 Set the x position of Sabreman.
  $E5AA,$03 Fetch the flag at #R$8EF2.
  $E5AD,$03 Jump to #R$E606 if no eagle was carrying him.
  $E5B0,$03 Check for contact with the decorations.
  $E5B3,$04 Jump to #R$E5C3 if he is not touching a decoration.
  $E5B7,$04 Jump to #R$E616 if he is on top of it.
  $E5BB,$04 Jump to #R$E616 if he is near the middle of it.
  $E5BF,$04 Set bit 5 of the redraw flags, to ask the eagle to let go.
@ $E5C3 label=Handle_Carried_Sabreman_Check_Walls
  $E5C3,$03 Read the world map entry of the room that he is in. The flags of the
. room are returned in #REGe.
  $E5C6,$03 Fetch the x position.
  $E5C9,$04 Jump to #R$E5DB if it is #N$CF or more.
  $E5CD,$04 Jump to #R$E5F2 if it is #N$18 or more.
  $E5D1,$04 Jump to #R$E5E3 if the room has no wall on the left.
  $E5D5,$04 Set the x position to #N$18.
  $E5D9,$02 Jump to #R$E5E3.
@ $E5DB label=Handle_Carried_Sabreman_Check_Right_Wall
  $E5DB,$04 Jump to #R$E5E3 if the room has no wall on the right.
  $E5DF,$04 Set the x position to #N$CF.
@ $E5E3 label=Handle_Carried_Sabreman_Check_Floor
  $E5E3,$04 Jump to #R$E5F2 if the room has a floor.
  $E5E7,$03 Fetch the y position.
  $E5EA,$04 Jump to #R$E5F2 if it is less than #N$9F.
  $E5EE,$04 Set the y position to #N$9F.
@ $E5F2 label=Handle_Carried_Sabreman_Check_Release
  $E5F2,$06 Jump to #R$E606 if bit 6 of the redraw flags is set, as the eagle
. has let go.
  $E5F8,$03 Read the controls.
  $E5FB,$05 Jump to #R$96CB if the fire key is not pressed.
  $E600,$03 Throw a weapon.
  $E603,$03 Jump to #R$96CB.
@ $E606 label=Handle_Carried_Sabreman_Drop
  $E606,$01 Disable interrupts.
  $E607,$04 Reset bit 6 of the redraw flags.
  $E60B,$04 Set the sprite id to #N$18 (tumbling).
  $E60F,$04 Set the y velocity to #N$10.
  $E613,$03 Jump to #R$96CB.
@ $E616 label=Handle_Carried_Sabreman_Stand
  $E616,$01 Copy #N$A0 less the y position of the top of the decoration to
. #REGa.
  $E617,$01 Subtract one.
  $E618,$02 Negate it.
  $E61A,$02 Add #N$A0, to get the y position just below the top of the
. decoration.
  $E61C,$03 Set the y position of Sabreman.
  $E61F,$03 Jump to #R$96CB.

c $E622 Handle Stalactite
@ $E622 label=Handle_Stalactite
D $E622 Handler for the object types #N$3C, #N$3D, #N$55, #N$56 and #N$57, the
. stalactites that hang from the ceiling of a cave room. They are made by
. #R$E6BE from the templates at #R$B7CB. A stalactite does not move.
.
. It is drawn once, when bit 0 of its redraw flags is set. At the same time, if
. bit 3 of byte #N$06 is set, the stalactite has a gem in it. The gem is made as
. a copy of the record of the stalactite in the record that is #N$20 bytes on,
. with the type #N$64 plus the two low bits of the sum of the room x, the room y
. and byte #N$06 (so there are four kinds of gem). Its y position is that of the
. stalactite less the height of the stalactite (byte #N$0C), its attribute is
. #N$45 (cyan) and it is handled by #R$E751. Byte #N$06 of the stalactite is
. then cleared, so that only one gem is made.
.
. The attributes of the cells that the stalactite covers are copied from the
. colour data on every call (see #R$DC0B), which keeps the stalactite coloured
. whatever passes in front of it. The colour data is chosen by the two low bits
. of the type, using the pointers at #R$E69D.
R $E622 IX Object record of the stalactite
  $E622,$03 Prepare the sprite of the stalactite.
  $E625,$06 Jump to #R$E665 if the stalactite has been drawn already.
  $E62B,$06 Jump to #R$E65E if the stalactite has no gem in it.
  $E631,$03 Copy the address of the record of the stalactite to #REGde.
  $E634,$03 Set #REGhl to #N$0020.
  $E637,$01 Point #REGhl at the record that is #N$20 bytes on.
  $E638,$03 Set a counter of #N$10 bytes.
  $E63B,$01 Swap the addresses, so that #REGde points at the other record.
  $E63C,$01 Stash the address of the other record.
  $E63D,$02 Copy the record of the stalactite to the other record.
  $E63F,$01 Restore the address of the other record to #REGhl.
  $E640,$03 Fetch the room x.
  $E643,$03 Add the room y.
  $E646,$03 Add byte #N$06.
  $E649,$02,b$01 Keep only the two low bits.
  $E64B,$02 Add #N$64, to make the type of one of the four gems.
  $E64D,$01 Set the type of the gem.
  $E64E,$03 Move on to the y position of the gem.
  $E651,$01 Fetch the y position of the gem.
  $E652,$03 Subtract the height of the stalactite.
  $E655,$01 Set the y position of the gem.
  $E656,$02 Move on to the attribute of the gem.
  $E658,$02 Set the attribute of the gem to #N$45 (cyan).
  $E65A,$04 Clear byte #N$06 of the stalactite.
@ $E65E label=Handle_Stalactite_Draw
  $E65E,$04 Reset bit 0 of the redraw flags.
  $E662,$03 Draw the stalactite.
@ $E665 label=Handle_Stalactite_Colour
  $E665,$02 Clear the high byte of the offset.
  $E667,$03 Fetch the type of the stalactite.
  $E66A,$02,b$01 Keep only the two low bits.
  $E66C,$01 Store the colour type in #REGe.
  $E66D,$03 Point #REGhl at #R$E69D.
  $E670,$02 Add the result twice, to point at the pointer for the type.
  $E672,$01 Fetch the low byte of the pointer.
  $E673,$01 Move on to the high byte.
  $E674,$01 Fetch the high byte of the pointer, which makes #REGde point at the
. colour data.
@ $E675 label=Handle_Stalactite_Colour_Copy
  $E675,$03 Fetch the x position of the object.
  $E678,$03 Fetch the y position of the object.
  $E67B,$03 Get the attribute address of the bottom left cell of the sprite
. in #REGhl.
  $E67E,$03 Fetch the number of cells in each row of the sprite.
  $E681,$01 Store it in #REGb.
  $E682,$03 Fetch the height of the sprite in pixels.
  $E685,$03 Divide it by eight.
  $E688,$02,b$01 Keep only the low five bits.
  $E68A,$01 Store the number of rows in #REGc.
@ $E68B label=Handle_Stalactite_Colour_Row
  $E68B,$01 Stash the number of rows and the number of cells in each row.
  $E68C,$01 Stash the attribute address of the start of the row.
@ $E68D label=Handle_Stalactite_Colour_Cell
  $E68D,$01 Fetch an attribute from the colour data.
  $E68E,$01 Set the attribute of the cell.
  $E68F,$01 Move on to the next cell.
  $E690,$01 Move on to the next attribute in the colour data.
  $E691,$02 Decrease the cell counter and loop back for the rest of the cells in
. the row.
  $E693,$01 Restore the attribute address of the start of the row.
  $E694,$03 Set #REGbc to #N$FFE0, which is minus the number of cells in a row
. of the screen.
  $E697,$01 Move up to the row above.
  $E698,$01 Restore the number of rows and the number of cells in each row.
  $E699,$03 Decrease the row counter and loop back until all of the rows have
. been done.
  $E69C,$01 Return.

w $E69D Stalactite Colour Pointers
@ $E69D label=Stalactite_Colour_Pointers
D $E69D Pointers into the colour data at #R$DC0B, which are chosen by the two
. low bits of the type of the stalactite (see #R$E622).
W $E69D,$02,$02 Type #N$3C: the colour data at #R$DC1D.
W $E69F,$02,$02 Types #N$3D and #N$55: the colour data at #R$DC0B.
W $E6A1,$02,$02 Type #N$56: the colour data at #R$DC1D.
W $E6A3,$02,$02 Type #N$57: the colour data at #R$DC2F.

c $E6A5 Read Room State
@ $E6A5 label=Read_Room_State
D $E6A5 Reads the entry of the room visit table (see #R$6000) for the room that
. an object is in. The address of the entry is worked out in the same way as the
. address of the world map entry (see #R$98B2), but from #N$6000 instead of
. #N$7000.
R $E6A5 IX Object record
R $E6A5 O:A First byte of the entry
R $E6A5 O:HL Address of the entry
  $E6A5,$03 Fetch the room y of the object into #REGh.
  $E6A8,$01 Clear #REGa.
  $E6A9,$09 Move the three low bits of the room y into the top of #REGa, so that
. #REGh holds the room y divided by eight.
  $E6B2,$03 Fetch the room x of the object into #REGl.
  $E6B5,$02 Add the room x twice to #REGa.
  $E6B7,$01 Store the result in #REGl.
  $E6B8,$03 Set #REGbc to #N$6000.
  $E6BB,$01 Add it to the offset.
  $E6BC,$01 Fetch the first byte of the entry.
  $E6BD,$01 Return.

c $E6BE Build Stalactite
@ $E6BE label=Build_Stalactite
D $E6BE Makes the object record of one stalactite from a template (see #R$B7CB).
.
. The byte that describes the stalactite (one of the two bytes of the entry of
. the room visit table, see #R$E6EE) is in #REGb. Bits 1 and 2 of it choose the
. template. Bits 4 and 5 give the x position, which is that number of sixteen
. pixels more than #REGc. Bits 6 and 7 give the y position, which is that number
. of sixteen pixels more than #N$77. Bit 3 is set if the stalactite has a gem in
. it (see #R$E622). Bit 0 tells the first stalactite of a room from the second.
.
. The room x and the room y are those of the object at #REGix. The attribute is
. #N$46 (yellow). The byte is also stored in byte #N$06 of the record.
R $E6BE A Template number multiplied by two (bits 1 and 2 of #REGb)
R $E6BE B Byte that describes the stalactite
R $E6BE C Smallest x position
R $E6BE DE Address of the stalactite record
R $E6BE HL Address of the table of pointers to the templates
R $E6BE IX Object record of Sabreman
  $E6BE,$01 Stash the byte that describes the stalactite and the smallest x
. position.
  $E6BF,$01 Copy the template number to #REGc.
  $E6C0,$02 Clear the high byte of the offset.
  $E6C2,$01 Point #REGhl at the pointer to the template.
  $E6C3,$01 Fetch the low byte of the pointer.
  $E6C4,$01 Move on to the high byte.
  $E6C5,$01 Fetch the high byte of the pointer.
  $E6C6,$01 Make #REGhl point at the template.
  $E6C7,$03 Set the number of bytes to copy to #N$10.
  $E6CA,$01 Stash the address of the stalactite record.
  $E6CB,$02 Copy the template to the stalactite record.
  $E6CD,$01 Restore the address of the stalactite record to #REGhl.
  $E6CE,$01 Restore the byte that describes the stalactite to #REGb and the
. smallest x position to #REGc.
  $E6CF,$01 Copy the byte that describes the stalactite to #REGa.
  $E6D0,$01 Move on to the x position.
  $E6D1,$02,b$01 Keep only bits 4 and 5.
  $E6D3,$01 Add the smallest x position.
  $E6D4,$01 Set the x position.
  $E6D5,$01 Move on to the room x.
  $E6D6,$03 Fetch the room x.
  $E6D9,$01 Set the room x.
  $E6DA,$01 Move on to the y position.
  $E6DB,$01 Fetch the byte that describes the stalactite.
  $E6DC,$02 Move bits 6 and 7 into bits 4 and 5.
  $E6DE,$02,b$01 Keep only bits 4 and 5.
  $E6E0,$02 Add #N$77.
  $E6E2,$01 Set the y position.
  $E6E3,$01 Move on to the room y.
  $E6E4,$03 Fetch the room y.
  $E6E7,$01 Set the room y.
  $E6E8,$01 Move on to the attribute.
  $E6E9,$02 Set the attribute to #N$46 (yellow).
  $E6EB,$01 Move on to byte #N$06.
  $E6EC,$01 Store the byte that describes the stalactite.
  $E6ED,$01 Return.

c $E6EE Set Up Stalactites
@ $E6EE label=Set_Up_Stalactites
D $E6EE Sets up the two stalactites of a cave room that has no floor when the
. room is drawn (see #R$AF56). The stalactites are the records at
. #R$8F9A and #R$8FAA.
.
. Each stalactite is described by one byte, and these are the two bytes of the
. entry of the room in the room visit table (see #R$6000). If the first byte is
. zero the room has not been visited before, so both bytes are made up.
.
. The first byte is the tick counter with bit 0 set, if bit 2 of that value is
. set, or otherwise #REGb with bits 4 and 5 reset (#REGb is whatever the
. routines that drew the room frame left in it). If the room has no wall on the
. left, bits 2, 5 and 7 are set. The second byte is the low byte of FRAMES with
. bit 0 reset, if bit 2 of that value is set, or otherwise #REGb with bits 4 and
. 5 set. If the room has no wall on the right, bits 2 and 7 are set and bit 5 is
. reset.
.
. The first stalactite is built with the smallest x position #N$18 and the first
. table of template pointers at #R$E741, and the second one with the smallest x
. position #N$A0 and the second table at #R$E749. Both are built by #R$E6BE.
R $E6EE E Flags of the room
R $E6EE IX Object record of Sabreman
  $E6EE,$03 Read the entry of the room in the room visit table. #REGhl holds the
. address of the entry and #REGa the first byte.
  $E6F1,$01 Stash the address of the entry.
  $E6F2,$03 Jump to #R$E714 if the room has not been visited before.
@ $E6F5 label=Set_Up_Stalactites_Build
  $E6F5,$01 Store the byte that describes the first stalactite in #REGb.
  $E6F6,$02,b$01 Keep only bits 1 and 2, which give the template number.
  $E6F8,$02 Set the smallest x position to #N$18.
  $E6FA,$03 Point #REGhl at #R$E741.
  $E6FD,$03 Point #REGde at #R$8F9A.
  $E700,$03 Build the first stalactite.
  $E703,$01 Restore the address of the entry to #REGhl.
  $E704,$01 Move on to the second byte.
  $E705,$01 Fetch the byte that describes the second stalactite.
  $E706,$01 Store it in #REGb.
  $E707,$02,b$01 Keep only bits 1 and 2, which give the template number.
  $E709,$02 Set the smallest x position to #N$A0.
  $E70B,$03 Point #REGhl at #R$E749.
  $E70E,$03 Point #REGde at #R$8FAA.
  $E711,$03 Jump to #R$E6BE.
@ $E714 label=Set_Up_Stalactites_Generate
N $E714 Make up the two bytes for a room that has not been visited.
  $E714,$03 Fetch the tick counter.
  $E717,$02,b$01 Set bit 0.
  $E719,$04 Jump to #R$E720 if it is set.
  $E71D,$01 Fetch #REGb.
  $E71E,$02,b$01 Reset bits 4 and 5.
@ $E720 label=Set_Up_Stalactites_Check_Left_Wall
  $E720,$04 Jump to #R$E726 if the room has a wall on the left.
  $E724,$02,b$01 Set bits 2, 5 and 7.
@ $E726 label=Set_Up_Stalactites_Store_First
  $E726,$01 Store the first byte of the entry.
  $E727,$03 Fetch the low byte of FRAMES.
  $E72A,$02,b$01 Reset bit 0.
  $E72C,$01 Move on to the second byte of the entry.
  $E72D,$04 Jump to #R$E734 if it is set.
  $E731,$01 Fetch #REGb.
  $E732,$02,b$01 Set bits 4 and 5.
@ $E734 label=Set_Up_Stalactites_Check_Right_Wall
  $E734,$04 Jump to #R$E73C if the room has a wall on the right.
  $E738,$02,b$01 Set bits 2 and 7.
  $E73A,$02,b$01 Reset bit 5.
@ $E73C label=Set_Up_Stalactites_Store_Second
  $E73C,$01 Store the second byte of the entry.
  $E73D,$01 Move back to the first byte of the entry.
  $E73E,$01 Fetch the first byte of the entry.
  $E73F,$02 Jump to #R$E6F5 to build the stalactites.

w $E741 Stalactite Template Pointers
@ $E741 label=Stalactite_Template_Pointers
D $E741 Two tables of four pointers to the templates of the stalactites at
. #R$B7CB, which are chosen by bits 1 and 2 of the byte that describes the
. stalactite (see #R$E6BE).
.
. The first table is used for the first stalactite of a room (on the left, with
. an x position from #N$18) and the second for the second stalactite (on the
. right, with an x position from #N$A0).
N $E741 The first table, with the templates of the types #N$55, #N$56, #N$57 and
. #N$57.
W $E741,$08,$02
@ $E749 label=Stalactite_Template_Pointers_Right
N $E749 The second table, with the templates of the types #N$3C, #N$3D, #N$57
. and #N$57.
W $E749,$08,$02

c $E751 Handle Collectable
@ $E751 label=Handle_Collectable
D $E751 Handler for the object types #N$64 to #N$67 (the four kinds of gem, see
. #R$E622) and #N$7F (an extra life, see #R$EDB4).
.
. An object that is in a different room from Sabreman is removed. When Sabreman
. touches the object (see #R$E285) it is erased and the pickup sound is played
. (see #R$A0E4). An extra life goes on at #R$E7AD. For a gem the score goes up
. (see #R$A045) by the type divided by two, as a number of hundreds, plus #N$99.
. Sabreman turns cyan, the gem timer at #R$8EEE is set to #N$50 and printed, and
. the gem is taken out of the entry of the room in the room visit table (see
. #R$E6EE), so that it does not come back when the room is drawn again. Bit 0 of
. byte #N$06 of the gem is taken to show which of the two bytes of the entry it
. came from.
R $E751 IX Object record of the gem or the extra life
  $E751,$03 Fetch the room x of Sabreman.
  $E754,$05 Jump to #R$E7A8 to remove the object if it is in a different room x.
  $E759,$03 Fetch the room y of Sabreman.
  $E75C,$05 Jump to #R$E7A8 to remove the object if it is in a different room y.
  $E761,$07 Jump to #R$96CB if it has not been drawn yet.
@ $E768 label=Handle_Collectable_Check_Contact
  $E768,$03 Check for contact with Sabreman.
  $E76B,$04 Jump to #R$E775 if Sabreman touches the object.
  $E76F,$03 Prepare the sprite of the object.
  $E772,$03 Jump to #R$9867.
@ $E775 label=Handle_Collectable_Collect
  $E775,$03 Save the state of the object.
  $E778,$03 Erase the sprite of the object.
  $E77B,$03 Play the pickup sound.
  $E77E,$03 Fetch the type of the object.
  $E781,$04 Jump to #R$E7AD if the object is an extra life.
  $E785,$03 Fetch the type of the object into #REGb.
  $E788,$02 Divide it by two.
  $E78A,$02 Clear #REGc, so that #REGbc holds the points for the object.
  $E78C,$03 Add to the score.
  $E78F,$05 Set the attribute of Sabreman to cyan (#N$45).
  $E794,$05 Set the gem timer to #N$50.
  $E799,$03 Print the gem timer.
  $E79C,$03 Read the entry of the room in the room visit table. #REGhl holds the
. address of the first byte.
  $E79F,$06 Jump to #R$E7A6 if the gem came from the first stalactite.
  $E7A5,$01 Move on to the second byte of the entry.
@ $E7A6 label=Handle_Collectable_Clear_Gem
  $E7A6,$02 Reset bit 3 of the byte, so that the stalactite has no gem in it any
. more.
@ $E7A8 label=Handle_Collectable_Remove
  $E7A8,$04 Remove the object.
  $E7AC,$01 Return.

c $E7AD Collect Extra Life
@ $E7AD label=Collect_Extra_Life
D $E7AD Adds a life when Sabreman has touched an extra life (see #R$E751),
. prints the number of lives, and marks the extra life as collected in the table
. at #R$EDC4. The routine ends by removing the object.
R $E7AD IX Object record of the extra life
  $E7AD,$03 Fetch the number of lives.
  $E7B0,$01 Add one.
  $E7B1,$01 Adjust the result to a BCD value.
  $E7B2,$03 Store the number of lives.
  $E7B5,$03 Print the number of lives.
  $E7B8,$02 Set the number of entries in the table to #N$10.
  $E7BA,$03 Point #REGhl at #R$EDC6.
  $E7BD,$03 Set the collected flag of the extra life.
  $E7C0,$02 Jump to #R$E7A8 to remove the object.

c $E7C2 Set Collected Flag
@ $E7C2 label=Set_Collected_Flag
D $E7C2 Sets the collected flag of the entry of a table that an object came
. from. The entries are three bytes long, and byte #N$06 of the object is the
. number of the entry counted from the end of the table, so the entry is the
. length of the table less that number.
.
. The routine has two entry points: #R$E7C2 for a table of #N$08 entries, and
. #R$E7C4 with the length in #REGa.
R $E7C2 HL Address of the collected flag of the first entry
R $E7C2 IX Object record
R $E7C4 A Number of entries in the table
R $E7C4 HL Address of the collected flag of the first entry
R $E7C4 IX Object record
  $E7C2,$02 #REGa=#N$08.
@ $E7C4 label=Set_Collected_Flag_Entry
  $E7C4,$03 Subtract byte #N$06 of the object, to get the number of the entry.
  $E7C7,$01 Store it in #REGe.
  $E7C8,$02 Clear the high byte of the number of the entry.
  $E7CA,$03 Add the number of the entry three times, to point at the collected
. flag.
  $E7CD,$02 Set the collected flag.
  $E7CF,$01 Return.

c $E7D0 Start Dying
@ $E7D0 label=Start_Dying
D $E7D0 Makes Sabreman die. The sprite id becomes #N$3E or #N$3F, depending on
. bit 2 of the sprite id that he has, and the countdown in byte #N$0A is set to
. #N$20. #R$E7E3 handles the rest.
R $E7D0 IX Object record of Sabreman
  $E7D0,$03 Fetch the sprite id.
  $E7D3,$02 Move bit 2 into bit 0.
  $E7D5,$02,b$01 Keep only that bit.
  $E7D7,$02 Add #N$3E.
  $E7D9,$03 Set the sprite id.
  $E7DC,$04 Set the countdown to #N$20.
  $E7E0,$03 Jump to #R$96CB.

c $E7E3 Handle Death
@ $E7E3 label=Handle_Death
D $E7E3 Handler for the object types #N$3E and #N$3F, the sprites that Sabreman
. has when he dies (see #R$E7D0). The sprite is drawn until the countdown in
. byte #N$0A reaches zero. Then he loses a life and the game is over if he has
. none left (see #R$95DE).
.
. Otherwise his position is saved (see #R$8EDB), all of the object records are
. cleared (see #R$E825), Sabreman is reset (see #R$A3DD), his position is put
. back and the room is drawn again, so he carries on where he died.
R $E7E3 IX Object record of Sabreman
  $E7E3,$03 Save the state of Sabreman.
  $E7E6,$06 Jump to #R$96CB if the countdown is not zero.
  $E7EC,$03 Fetch the number of lives.
  $E7EF,$04 Jump to #R$E821 if he had none left.
  $E7F3,$01 Adjust the result to a BCD value.
  $E7F4,$03 Store the number of lives.
  $E7F7,$03 Print the number of lives.
  $E7FA,$03 Fetch the x position and the room x of Sabreman.
  $E7FD,$03 Save them.
  $E800,$03 Fetch the y position and the room y of Sabreman.
  $E803,$03 Save them.
  $E806,$03 Clear the object records.
  $E809,$03 Reset Sabreman.
  $E80C,$03 Fetch the saved x position and room x.
  $E80F,$03 Put them back in the record of Sabreman.
  $E812,$03 Fetch the saved y position and room y.
  $E815,$03 Put them back in the record of Sabreman.
  $E818,$05 Set the contact flags of Sabreman to #N$10, so that he stands on a
. floor.
  $E81D,$03 Draw the room.
  $E820,$01 Return.
@ $E821 label=Handle_Death_Game_Over
  $E821,$01 Discard the return address.
  $E822,$03 Show the game over message.

c $E825 Clear Object Records
@ $E825 label=Clear_Object_Records
D $E825 Clears the object records from the record of Sabreman (at
. #R$8F1A) up to the end of the records at #R$902A, which are
. #N$110 bytes.
E $E825 Continue on to #R$E833.
  $E825,$03 Point #REGhl at the record of Sabreman.
  $E828,$03 Set the number of bytes to clear to #N$0110.
@ $E82B label=Clear_Object_Records_Loop
  $E82B,$02 Clear a byte.
  $E82D,$01 Move on to the next byte.
  $E82E,$05 Decrease the byte counter and loop back until all of the object
. records have been cleared.

c $E833 Check Stalactite Contact
@ $E833 label=Check_Stalactite_Contact
D $E833 Checks whether an object is touching the falling stalactite (the record
. at #R$8F3A, see #R$DF98).
.
. Nothing is touched when there is no falling stalactite, while the gem timer at
. #R$8EEE is not zero, or if the stalactite is in a different room. The two are
. touching when the x positions differ by less than #N$10 and the y positions by
. less than #N$14.
.
. The result in #REGc starts as #N$80 and is: bit 7 set if the stalactite is
. level with or to the right of the object, bit 0 set if the x positions differ
. by #N$0A or more, bit 1 set if the stalactite is above the object, and bit 2
. set if they are touching. #REGb is the y velocity of the stalactite.
R $E833 IX Object record
R $E833 O:B Y velocity of the stalactite (when they are touching)
R $E833 O:C Contact result
  $E833,$03 Set #REGbc to #N$0080.
  $E836,$03 Fetch the type of the stalactite.
  $E839,$02 Return if there is no falling stalactite.
  $E83B,$03 Fetch the gem timer.
  $E83E,$02 Return if it is not zero.
  $E840,$03 Fetch the room x of the stalactite.
  $E843,$04 Return if it is different.
  $E847,$03 Fetch the room y of the stalactite.
  $E84A,$04 Return if it is different.
  $E84E,$03 Fetch the x position of the stalactite.
  $E851,$06 Jump to #R$E85B if the stalactite is level with or to the right of
. the object.
  $E857,$02 Make the difference positive.
  $E859,$02 Reset bit 7 of the contact result.
@ $E85B label=Check_Stalactite_Contact_Check_Width
  $E85B,$03 Return if the difference is #N$10 or more.
  $E85E,$04 Jump to #R$E864 if the difference is less than #N$0A.
  $E862,$02 Set bit 0 of the contact result.
@ $E864 label=Check_Stalactite_Contact_Check_Height
  $E864,$03 Fetch the y position of the stalactite.
  $E867,$06 Jump to #R$E871 if the stalactite is below the object.
  $E86D,$02 Make the difference positive.
  $E86F,$02 Set bit 1 of the contact result.
@ $E871 label=Check_Stalactite_Contact_Check_Contact
  $E871,$03 Return if the difference is #N$14 or more.
  $E874,$02 Set bit 2 of the contact result (contact).
  $E876,$03 Fetch the y velocity of the stalactite.
  $E879,$01 Store it in #REGb.
  $E87A,$01 Return.

c $E87B Knock Sabreman Off Rope
@ $E87B label=Knock_Sabreman_Off_Rope
D $E87B Makes Sabreman fall off the rope when something hits him (a bubble, a
. creature or the falling stalactite). He tumbles, with the y velocity that is
. in #REGb. His x velocity is the distance that the end of the rope moved (see
. #R$AA95) and the countdown in byte #N$0A is set to #N$14. The rope is made a
. type #N$17 object again, and Sabreman is drawn, at #R$A8DA.
R $E87B B Y velocity
R $E87B IX Object record of Sabreman
  $E87B,$03 Fetch the previous position of the end of the rope.
  $E87E,$01 Store it in #REGe.
  $E87F,$03 Fetch the position of the end of the rope.
  $E882,$01 Subtract the previous position.
  $E883,$03 Set the x velocity.
  $E886,$03 Set the y velocity.
  $E889,$04 Set the sprite id to #N$18 (tumbling).
  $E88D,$04 Set the countdown to #N$14.
  $E891,$03 Jump to #R$A8DA.

c $E894 Knock Sabreman Down
@ $E894 label=Knock_Sabreman_Down
D $E894 Makes Sabreman tumble when he has been hit by a bubble. The y velocity
. is the value in #REGb, the countdown in byte #N$0A is set to #N$14 and the
. sprite id to #N$18 (tumbling). Sabreman is drawn and the routine returns to
. the main loop.
R $E894 B Y velocity
R $E894 IX Object record of Sabreman
  $E894,$04 Set the countdown to #N$14.
@ $E898 label=Knock_Sabreman_Down_Set_Velocity
  $E898,$03 Set the y velocity.
  $E89B,$04 Set the sprite id to #N$18 (tumbling).
  $E89F,$03 Jump to #R$96CB.

c $E8A2 Tumble Sabreman
@ $E8A2 label=Tumble_Sabreman
D $E8A2 Makes Sabreman tumble after a creature has hit him (see #R$B079), which
. sets bit 3 of his redraw flags. The sprite id is #N$18 plus a random number
. from zero to three (the low bits of FRAMES). Bits 3 and 4 of the redraw flags
. are reset, he moves up by one pixel, and the countdown in byte #N$0A is set to
. #N$14. The routine goes on at #R$A928 to carry on with the tumbling.
R $E8A2 IX Object record of Sabreman
  $E8A2,$03 Fetch the low byte of FRAMES.
  $E8A5,$02,b$01 Keep only the two low bits.
  $E8A7,$02 Add #N$18.
  $E8A9,$03 Set the sprite id.
  $E8AC,$03 Fetch the redraw flags.
  $E8AF,$02,b$01 Reset bits 3 and 4.
  $E8B1,$03 Store the redraw flags.
  $E8B4,$03 Move Sabreman up by one pixel.
  $E8B7,$04 Set the countdown to #N$14.
  $E8BB,$03 Jump to #R$A928.

c $E8BE Place Weapon Pickups
@ $E8BE label=Place_Weapon_Pickups
D $E8BE Puts the four weapons that Sabreman can pick up in their places at the
. start of a game (see #R$9052). It copies one of four sets of four records from
. the table at #R$E9FD to the small object records at #R$902A, and the set is
. chosen by bits 1 and 2 of the low byte of FRAMES.
  $E8BE,$03 Point #REGde at the first small object record.
  $E8C1,$03 Point #REGhl at #R$E9FD.
  $E8C4,$03 Fetch the low byte of FRAMES.
  $E8C7,$04 Shift it left four times.
  $E8CB,$02,b$01 Keep only bits 5 and 6, which are the old bits 1 and 2.
  $E8CD,$01 Store the result in #REGc.
  $E8CE,$02 Clear the high byte of the offset.
  $E8D0,$01 Point #REGhl at the chosen set of records.
  $E8D1,$03 Set the number of bytes to copy to #N$20 (four records).
  $E8D4,$02 Copy the records.
  $E8D6,$01 Return.

c $E8D7 Handle Weapon Pickup
@ $E8D7 label=Handle_Weapon_Pickup
D $E8D7 Handler for the object types #N$68 to #N$6B, the four weapons that
. Sabreman can pick up (see #R$DDA8). The weapons are the small object records
. at #R$902A. Byte #N$07 of a record holds the flags: bit 0 is set if there is
. no old image to erase, bit 1 is set while Sabreman carries the weapon and bit
. 2 is set while the weapon falls.
.
. A weapon that lies on the floor is drawn again and again. When an action key
. has just been pressed (the flag at #R$8EEA is #N$FF) and Sabreman is touching
. it (see #R$E285), he picks it up: the weapon moves to the x position #N$88 and
. the y position #N$0F, which is its place in the panel at the top of the
. screen, bit 1 of the flags is set, the flag at #R$8EEA is set to #N$FE to show
. that the key press has been used, and the type of the weapon is stored in the
. first of the weapon slots at #R$8EEB.
.
. Each later key press moves a carried weapon #N$18 pixels to the right in the
. panel and stores its type in the weapon slot that goes with the new x position
. (the x positions #N$A0 and #N$B8 both give the third slot, and none gives the
. second). A key press when the weapon has reached #N$B8 makes Sabreman drop it.
. It is put at his position, with bit 1 of the flags reset, bit 2 set and the
. counter in byte #N$06 set to #N$10, and it falls (see #R$E980).
.
. A weapon that is in a different room is dealt with by #R$E9DF.
R $E8D7 IX Small object record of the weapon
  $E8D7,$03 Save the state of the weapon.
  $E8DA,$06 Jump to #R$E92A if Sabreman is carrying the weapon.
  $E8E0,$03 Fetch the room x of Sabreman.
  $E8E3,$06 Jump to #R$E9DF if the weapon is in a different room x.
  $E8E9,$03 Fetch the room y of Sabreman.
  $E8EC,$06 Jump to #R$E9DF if the weapon is in a different room y.
  $E8F2,$07 Jump to #R$96E1 if it has no old image to erase.
  $E8F9,$07 Jump to #R$E980 if the weapon is falling.
  $E900,$03 Fetch the flag for a new action key press.
  $E903,$03 Jump to #R$E97A if no action key has been pressed.
  $E906,$03 Jump to #R$E97A if the key press has been used already (the flag is
. not #N$FF).
  $E909,$03 Check for contact with Sabreman.
  $E90C,$04 Jump to #R$E97A if Sabreman is not touching the weapon.
  $E910,$04 Set the x position of the weapon to #N$88.
  $E914,$04 Set the y position of the weapon to #N$0F.
  $E918,$04 Set bit 1 of the flags, as Sabreman carries the weapon.
  $E91C,$05 Mark the key press as used by writing #N$FE to #R$8EEA.
  $E921,$03 Fetch the type of the weapon.
  $E924,$03 Store it in the first weapon slot.
  $E927,$03 Jump to #R$96E1.
@ $E92A label=Handle_Weapon_Pickup_Carried
  $E92A,$04 Reset bit 0 of the flags.
  $E92E,$03 Fetch the flag for a new action key press.
  $E931,$03 Jump to #R$E97A if no action key has been pressed.
  $E934,$03 Fetch the x position of the weapon.
  $E937,$02 Add #N$18, to move it to the next place in the panel.
  $E939,$04 Jump to #R$E95E if the result is less than #N$C8.
  $E93D,$03 Fetch the x position and the room x of Sabreman.
  $E940,$03 Set the x position of the weapon.
  $E943,$03 Set the room x of the weapon.
  $E946,$03 Fetch the y position and the room y of Sabreman.
  $E949,$03 Set the y position of the weapon.
  $E94C,$03 Set the room y of the weapon.
  $E94F,$04 Reset bit 1 of the flags, as the weapon is dropped.
  $E953,$04 Set bit 2 of the flags, as the weapon falls.
  $E957,$04 Set the counter in byte #N$06 to #N$10.
  $E95B,$03 Jump to #R$96E1.
@ $E95E label=Handle_Weapon_Pickup_Next_Slot
  $E95E,$03 Set the x position of the weapon.
  $E961,$04 Shift the x position right four times.
  $E965,$02,b$01 Keep only the two low bits.
  $E967,$04 Jump to #R$E96C unless the result is #N$03.
  $E96B,$01 Change #N$03 to #N$02.
@ $E96C label=Handle_Weapon_Pickup_Store_Slot
  $E96C,$01 Store the weapon slot number in #REGe.
  $E96D,$02 Clear the high byte of the slot number.
  $E96F,$03 Point #REGhl at #R$8EEB.
  $E972,$01 Add the slot number to point at the weapon slot.
  $E973,$03 Fetch the type of the weapon.
  $E976,$01 Store it in the weapon slot.
  $E977,$03 Jump to #R$96E1.
@ $E97A label=Handle_Weapon_Pickup_Draw
  $E97A,$03 Prepare the sprite of the weapon.
  $E97D,$03 Jump to #R$9867.
@ $E980 label=Handle_Weapon_Pickup_Fall
N $E980 The weapon falls. The counter in byte #N$06 goes up on every call and
. one sixteenth of it is added to the y position.
  $E980,$03 Fetch the counter.
  $E983,$03 Add one to the counter.
  $E986,$04 Divide the old value by sixteen.
  $E98A,$02,b$01 Keep only the low four bits.
  $E98C,$03 Add the y position of the weapon.
  $E98F,$03 Set the y position of the weapon.
  $E992,$03 Check for contact with the decorations.
  $E995,$04 Jump to #R$E9A8 if the weapon is not touching a decoration.
  $E999,$01 Copy #N$A0 less the y position of the top of the decoration to
. #REGa.
  $E99A,$02 Negate it.
  $E99C,$02 Add #N$A1, to get the y position just below the top of the
. decoration.
  $E99E,$03 Set the y position of the weapon.
  $E9A1,$04 Reset bit 2 of the flags, as the weapon has stopped falling.
  $E9A5,$03 Jump to #R$96E1.
@ $E9A8 label=Handle_Weapon_Pickup_Check_Floor
  $E9A8,$03 Fetch the y position of the weapon.
  $E9AB,$05 Jump to #R$96E1 if it is less than #N$9F.
  $E9B0,$03 Read the world map entry of the room that the weapon is in. The
. flags of the room are returned in #REGe.
  $E9B3,$04 Jump to #R$E9C2 if the room has no floor.
  $E9B7,$04 Set the y position of the weapon to #N$9F, which is the floor.
  $E9BB,$04 Reset bit 2 of the flags, as the weapon has stopped falling.
  $E9BF,$03 Jump to #R$96E1.
@ $E9C2 label=Handle_Weapon_Pickup_Check_Bottom
  $E9C2,$03 Fetch the y position of the weapon.
  $E9C5,$05 Jump to #R$96E1 if it is less than #N$BF.
@ $E9CA label=Handle_Weapon_Pickup_Next_Room
  $E9CA,$03 Move the weapon to the room below.
  $E9CD,$03 Read the world map entry of the room that the weapon is in.
  $E9D0,$04 Jump back to #R$E9CA if the room has no floor.
  $E9D4,$04 Set the y position of the weapon to #N$9E.
  $E9D8,$04 Clear the counter in byte #N$06.
  $E9DC,$03 Erase the sprite of the weapon.

c $E9DF Handle Distant Weapon
@ $E9DF label=Handle_Distant_Weapon
D $E9DF Deals with a weapon that is in a different room from Sabreman (see
. #R$E8D7). Bit 0 of the flags is set, so that the weapon is drawn without an
. old image to erase when Sabreman comes back. If the weapon falls it moves down
. through the rooms below until it gets to one that has a floor, and it is put
. at the y position #N$9E with its counter cleared.
R $E9DF IX Small object record of the weapon
  $E9DF,$04 Set bit 0 of the flags.
  $E9E3,$06 Jump to #R$E9ED if the weapon is falling.
  $E9E9,$01 Return.
@ $E9EA label=Handle_Distant_Weapon_Next_Room
  $E9EA,$03 Move the weapon to the room below.
@ $E9ED label=Handle_Distant_Weapon_Find_Floor
  $E9ED,$03 Read the world map entry of the room that the weapon is in. The
. flags of the room are returned in #REGe.
  $E9F0,$04 Jump back to #R$E9EA if the room has no floor.
  $E9F4,$04 Set the y position of the weapon to #N$9E.
  $E9F8,$04 Clear the counter in byte #N$06.
  $E9FC,$01 Return.

b $E9FD Weapon Placement Table
@ $E9FD label=Weapon_Placement_Table
D $E9FD Four sets of four records of #N$08 bytes each, which #R$E8BE copies to
. the small object records at #R$902A (see #R$E8D7). A record has the type
. (#N$68 to #N$6B), the x position, the room x, the y position (#N$9F, which is
. the floor, or #N$8F for one of them), the room y and the attribute (#N$42 red,
. #N$43 magenta, #N$44 green or #N$45 cyan). Byte #N$06 (the counter) is zero
. and byte #N$07 holds the flags #N$05, which are bit 0 (no old image to erase)
. and bit 2 (falling). Each set has one weapon of each type, but in different
. places.
N $E9FD The first set.
B $E9FD,$20,$08
N $EA1D The second set.
B $EA1D,$20,$08
N $EA3D The third set.
B $EA3D,$20,$08
N $EA5D The fourth set.
B $EA5D,$20,$08

c $EA7D Handle Fire
@ $EA7D label=Handle_Fire
D $EA7D Handler for the object types #N$70 and #N$71, the fire that is thrown by
. the torch (see #R$B4D1). Bit 0 of the type and the attribute follow bit 0 of
. the tick counter, so the fire flickers between two frames and between red
. (#N$42) and magenta (#N$43). It moves in the same way as the other thrown
. weapons (see #R$B58C).
R $EA7D IX Object record of the fire
  $EA7D,$03 Save the state of the fire.
  $EA80,$03 Fetch the tick counter.
  $EA83,$02,b$01 Keep only bit 0.
  $EA85,$01 Store it in #REGb.
  $EA86,$03 Fetch the type of the fire.
  $EA89,$02,b$01 Reset bit 0.
  $EA8B,$01 Add bit 0 of the tick counter.
  $EA8C,$03 Set the type of the fire.
  $EA8F,$03 Fetch the tick counter.
  $EA92,$02,b$01 Keep only bit 0.
  $EA94,$02 Add #N$42.
  $EA96,$03 Set the attribute of the fire.
  $EA99,$03 Jump to #R$B58C to move the fire.

c $EA9C Handle Projectile
@ $EA9C label=Handle_Projectile
D $EA9C Handler for the object types #N$6C to #N$6F, which are the daggers and
. the arrows that Sabreman throws (see #R$B4D1). It saves the state of the
. object and moves it in the same way as the other thrown weapons (see #R$B58C).
R $EA9C IX Object record of the projectile
  $EA9C,$03 Save the state of the projectile.
  $EA9F,$03 Jump to #R$B58C to move the projectile.

c $EAA2 Load Room Decorations
@ $EAA2 label=Load_Room_Decorations
D $EAA2 Copies the four decorations of the room that Sabreman is in from the
. table at #R$6800 into the four object records that start at #R$8F7A.
. It is used for the special rooms (a room y below #N$10), where the decorations
. are the furniture and the pictures.
.
. The table has eight bytes for each room, and #N$80 bytes for each row of #N$10
. rooms. A pair of bytes describes each decoration. The first byte is the sprite
. id, which becomes the type of the object. The high nibble of the second byte
. is the x position in units of #N$10 pixels and the low nibble is the y
. position in units of #N$08 pixels.
.
. The records are set up with the attribute #N$45 (cyan) and bit 0 of the redraw
. flags set, so that the decorations are drawn when they are first handled (by
. #R$EAF9 or #R$EB39).
R $EAA2 IX Object record of Sabreman
  $EAA2,$03 Fetch the room y of Sabreman into #REGh.
  $EAA5,$03 Fetch the room x of Sabreman into #REGl.
  $EAA8,$06 Multiply the room x by eight, as there are eight bytes in an entry.
  $EAAE,$04 Clear #REGa and halve the room y, with the lowest bit going into bit
. 7 of #REGa. This makes the offset of the row of rooms (#N$80 bytes for each
. room y).
  $EAB2,$01 Add the offset for the room x.
  $EAB3,$01 #REGhl is now the offset of the entry in the table.
  $EAB4,$03 Point #REGde at #R$6800.
  $EAB7,$01 Make #REGhl point at the entry of the room.
  $EAB8,$01 Disable interrupts.
  $EAB9,$02 Save #REGiy.
  $EABB,$04 Point #REGiy at #R$8F7A.
  $EABF,$03 Set the size of an object record in #REGde.
  $EAC2,$02 Set the number of decorations to load to #N$04.
@ $EAC4 label=Load_Room_Decorations_Loop
  $EAC4,$01 Fetch the sprite id of the decoration.
  $EAC5,$03 Store it as the type of the object.
  $EAC8,$01 Move on to the position byte.
  $EAC9,$01 Fetch the position byte.
  $EACA,$02,b$01 Keep the high nibble.
  $EACC,$02 Add #N$08.
  $EACE,$03 Set the x position of the decoration.
  $EAD1,$01 Fetch the position byte again.
  $EAD2,$03 Shift it left three times, which moves the low nibble to bits 3 to
. 6.
  $EAD5,$02,b$01 Keep only those bits.
  $EAD7,$02 Add #N$3F.
  $EAD9,$03 Set the y position of the decoration.
  $EADC,$03 Fetch the room x.
  $EADF,$03 Set the room x of the decoration.
  $EAE2,$03 Fetch the room y.
  $EAE5,$03 Set the room y of the decoration.
  $EAE8,$04 Set bit 0 of the redraw flags, as the decoration has not been drawn
. yet.
  $EAEC,$04 Set the attribute of the decoration to #N$45 (cyan).
  $EAF0,$01 Move on to the next pair of bytes in the table.
  $EAF1,$02 Move on to the next object record.
  $EAF3,$02 Loop back until all four decorations have been loaded.
  $EAF5,$02 Restore #REGiy.
  $EAF7,$01 Enable interrupts.
  $EAF8,$01 Return.

c $EAF9 Handle Plain Decoration
@ $EAF9 label=Handle_Plain_Decoration
D $EAF9 Handler for the object types #N$74 to #N$78: the clock, the tapestry,
. the table, the sideboard and the bird (see #R$889D). These decorations are
. drawn in the single attribute of the record, which is cyan. The other
. decorations, which have colours of their own, are handled by #R$EB39.
.
. A decoration is removed (see #R$E7A8) when Sabreman is not in its room. The
. first time that it is handled #R$EB18 gives it the size of its obstacle, which
. #R$B46A uses to find out if an object touches it, and then #R$AF3F draws it.
. After that #R$AF3F only colours it.
R $EAF9 IX Object record of the decoration
  $EAF9,$03 Fetch the room x of Sabreman.
  $EAFC,$06 Jump to #R$E7A8 to remove the decoration if it is in a different
. room x.
  $EB02,$03 Fetch the room y of Sabreman.
  $EB05,$06 Jump to #R$E7A8 to remove the decoration if it is in a different
. room y.
  $EB0B,$07 Jump to #R$AF3F if the decoration has been drawn already (bit 0 of
. the redraw flags is clear).
  $EB12,$03 Copy the size of the obstacle to the object record.
  $EB15,$03 Jump to #R$AF3F to draw the decoration.

c $EB18 Set Decoration Size
@ $EB18 label=Set_Decoration_Size
D $EB18 Copies the five bytes that describe the size of the obstacle that a
. decoration makes (see #R$B46A) from the table at #R$EB7E to the bytes #N$0A to
. #N$0E of its object record. The entry is chosen by the type of the decoration,
. which is #N$74 for the first entry.
R $EB18 IX Object record of the decoration
  $EB18,$03 Fetch the type of the decoration.
  $EB1B,$02 Subtract #N$74 to make the number of the entry.
  $EB1D,$01 Store the number in #REGc.
  $EB1E,$04 Multiply the number by four.
  $EB22,$01 Add the number to make it five times the number.
  $EB23,$01 Store the offset of the entry in #REGe.
  $EB24,$02 Clear the high byte of the offset.
  $EB26,$03 Point #REGhl at #R$EB7E.
  $EB29,$01 Make #REGhl point at the entry.
  $EB2A,$01 Swap, so that #REGde points at the entry.
  $EB2B,$03 Copy the address of the object record into #REGhl.
  $EB2E,$03 Set the offset of byte #N$0A in #REGbc.
  $EB31,$01 Make #REGhl point at byte #N$0A of the object record.
  $EB32,$01 Swap, so that #REGhl points at the entry and #REGde at the record.
  $EB33,$03 Set the number of bytes to copy to #N$0005.
  $EB36,$02 Copy the size to the object record.
  $EB38,$01 Return.

c $EB39 Handle Coloured Decoration
@ $EB39 label=Handle_Coloured_Decoration
D $EB39 Handler for the object types #N$79 to #N$7E: the two pictures, the
. bookshelf, the hanging bowl, the bowl of flowers and the torch (see #R$8C69).
. They are coloured by copying the attributes from the colour data (see #R$DC0B)
. rather than from the single attribute of the record, so that they are not
. drawn in one colour only. The other decorations are handled by #R$EAF9.
.
. A decoration is removed (see #R$E7A8) when Sabreman is not in its room. The
. first time that it is handled #R$EB18 gives it the size of its obstacle and it
. is drawn. It is then coloured every time that it is handled, by #R$E675.
R $EB39 IX Object record of the decoration
  $EB39,$03 Fetch the room x of Sabreman.
  $EB3C,$06 Jump to #R$E7A8 to remove the decoration if it is in a different
. room x.
  $EB42,$03 Fetch the room y of Sabreman.
  $EB45,$06 Jump to #R$E7A8 to remove the decoration if it is in a different
. room y.
  $EB4B,$03 Prepare the sprite of the decoration.
  $EB4E,$06 Jump to #R$EB5E if the decoration has been drawn already (bit 0 of
. the redraw flags is clear).
  $EB54,$04 Reset bit 0 of the redraw flags.
  $EB58,$03 Copy the size of the obstacle to the object record.
  $EB5B,$03 Draw the decoration.
@ $EB5E label=Handle_Coloured_Decoration_Colour
  $EB5E,$03 Fetch the type of the decoration.
  $EB61,$02 Subtract #N$79 to make the number of the decoration.
  $EB63,$02 Double it, as the pointers are two bytes long.
  $EB65,$01 Store the result in #REGe.
  $EB66,$02 Clear the high byte of the offset.
  $EB68,$03 Point #REGhl at #R$EB72.
  $EB6B,$01 Make #REGhl point at the pointer for the decoration.
  $EB6C,$01 Fetch the low byte of the pointer.
  $EB6D,$01 Move on to the high byte.
  $EB6E,$01 Fetch the high byte, which makes #REGde point at the colour data.
  $EB6F,$03 Jump to #R$E675 to colour the decoration.

b $EB72 Decoration Colour Pointers
@ $EB72 label=Decoration_Colour_Pointers
D $EB72 One pointer to the colour data (see #R$DC0B) for each of the object
. types #N$79 to #N$7E, which #R$EB39 uses to colour the decorations.
W $EB72,$02,$02 The picture of type #N$79.
W $EB74,$02,$02 The picture of type #N$7A.
W $EB76,$02,$02 The bookshelf, the type #N$7B.
W $EB78,$02,$02 The hanging bowl, the type #N$7C.
W $EB7A,$02,$02 The bowl of flowers, the type #N$7D.
W $EB7C,$02,$02 The torch, the type #N$7E.

b $EB7E Decoration Size Table
@ $EB7E label=Decoration_Size_Table
D $EB7E Five bytes for each of the object types #N$74 to #N$7E, which #R$EB18
. copies to the bytes #N$0A to #N$0E of the object record. They are the half
. width of the decoration, the width of its middle, its height, the depth from
. the top at which an object counts as being beside it and the offset of its
. middle from its x position (see #R$B46A).
N $EB7E The clock, the type #N$74.
B $EB7E,$05,$05
N $EB83 The tapestry, the type #N$75.
B $EB83,$05,$05
N $EB88 The table, the type #N$76.
B $EB88,$05,$05
N $EB8D The sideboard, the type #N$77.
B $EB8D,$05,$05
N $EB92 The bird, the type #N$78.
B $EB92,$05,$05
N $EB97 The picture, the type #N$79.
B $EB97,$05,$05
N $EB9C The picture, the type #N$7A.
B $EB9C,$05,$05
N $EBA1 The bookshelf, the type #N$7B.
B $EBA1,$05,$05
N $EBA6 The hanging bowl, the type #N$7C.
B $EBA6,$05,$05
N $EBAB The bowl of flowers, the type #N$7D.
B $EBAB,$05,$05
N $EBB0 The torch, the type #N$7E.
B $EBB0,$05,$05

b $EBB5 Decoration Height Table
@ $EBB5 label=Decoration_Height_Table
D $EBB5 The height of each of the object types #N$74 to #N$7E, which is the same
. as the height in the #R$EB7E(size table). #R$EC3A uses it to put an extra life
. on top of a decoration.
B $EBB5,$0B,$0B

c $EBC0 Start Tumbling Inside Walls
@ $EBC0 label=Start_Tumbling_Inside_Walls
D $EBC0 Makes Sabreman tumble (see #R$A925) when he is knocked about while he
. jumps or falls. The type of the object is set to #N$18, which is the first
. frame of the tumbling Sabreman.
.
. The x position is then limited so that he does not tumble into the wall: it is
. kept below #N$C0 when the room has a wall on the right, and below #N$E8 when
. it does not.
R $EBC0 IX Object record of Sabreman
  $EBC0,$04 Set the type of the object to #N$18, the tumbling Sabreman.
  $EBC4,$03 Fetch the frame flags of the room into #REGe.
  $EBC7,$02 Test bit 2 of the frame flags, which is set when the room has a wall
. on the right.
  $EBC9,$03 Fetch the x position of the object.
  $EBCC,$02 Jump to #R$EBD6 if there is no wall on the right.
  $EBCE,$03 Return if the x position is less than #N$C0.
  $EBD1,$04 Limit the x position to #N$C0.
  $EBD5,$01 Return.
@ $EBD6 label=Start_Tumbling_Inside_Walls_No_Wall
  $EBD6,$03 Return if the x position is less than #N$E8.
  $EBD9,$04 Limit the x position to #N$E8.
  $EBDD,$01 Return.

c $EBDE Place Guardian
@ $EBDE label=Place_Guardian
D $EBDE Puts a guardian in the room, unless it has been destroyed already. It is
. the continuation of #R$EC3A when the room of Sabreman is that of an entry of
. the table of guardians at #R$EDF4.
.
. The rock formation is put in the room first (see #R$EC1C). The guardian is
. made from a copy of the template at #R$EDB4. Its type is #N$80, #N$86, #N$84
. or #N$82, which depends on the number of the entry, and it is placed at the x
. position #N$80 and the y position #N$9F with the attribute #N$03 (magenta).
. Byte #N$06 of the record holds the number of the entry, which #R$ECCA uses to
. set the collected flag of the entry when the guardian is destroyed.
.
. The record that is used is the first of the two special object records,
. #R$8FBA.
R $EBDE B Number of entries left in the table of guardians, including this one
R $EBDE C Room x of Sabreman
R $EBDE D Room y of Sabreman
R $EBDE HL Address of the room y of the entry
  $EBDE,$01 Switch to the alternate registers, to keep the registers that the
. caller uses.
  $EBDF,$03 Put the rock formation in the room.
  $EBE2,$01 Switch back to the main registers.
  $EBE3,$01 Move on to the collected flag of the entry.
  $EBE4,$01 Fetch the collected flag.
  $EBE5,$02 Return if the guardian has been destroyed already.
  $EBE7,$01 Fetch the number of the entry, counted from the end of the table.
  $EBE8,$01 Stash the room of Sabreman.
  $EBE9,$03 Point #REGhl at #R$EDB4.
  $EBEC,$03 Point #REGde at #R$8FBA.
  $EBEF,$03 Set the size of a record in #REGbc.
  $EBF2,$02 Copy the template to the record.
  $EBF4,$03 Store the number of the entry in byte #N$06 of the record.
  $EBF7,$01 Restore the room of Sabreman into #REGbc.
  $EBF8,$01 Disable interrupts.
  $EBF9,$02 Save #REGiy.
  $EBFB,$04 Point #REGiy at #R$8FBA.
  $EBFF,$01 Shift the number of the entry left, to double it.
  $EC00,$02,b$01 Keep the result in bits 1 and 2.
  $EC02,$02 Add #N$80 to make the type of the guardian.
  $EC04,$03 Set the type of the guardian.
  $EC07,$03 Set the room x of the guardian.
  $EC0A,$03 Set the room y of the guardian.
  $EC0D,$04 Set the x position of the guardian to #N$80.
  $EC11,$04 Set the y position of the guardian to #N$9F.
  $EC15,$04 Set the attribute of the guardian to #N$03 (magenta).
  $EC19,$02 Restore #REGiy.
  $EC1B,$01 Return.

c $EC1C Place Rock Formation
@ $EC1C label=Place_Rock_Formation
D $EC1C Puts the rock formation of the type #N$88 (see #R$ED2E) in the room of a
. guardian, if the room is a cave.
.
. The four object records that start at #R$8F7A are cleared. The third
. one, at #R$8F9A, becomes the rock formation and has bit 0 of its
. redraw flags set, so that it is drawn.
  $EC1C,$03 Fetch the room y of Sabreman.
  $EC1F,$03 Return if the room is a special room (the room y is below #N$10).
  $EC22,$03 Point #REGhl at #R$8F7A.
  $EC25,$03 Set the size of a record in #REGde.
  $EC28,$02 Set the number of records to clear to #N$04.
@ $EC2A label=Place_Rock_Formation_Clear
  $EC2A,$02 Clear the type of the record, which removes the object.
  $EC2C,$01 Move on to the next record.
  $EC2D,$02 Loop back until all four records have been cleared.
  $EC2F,$02 Set the type of the third record to #N$88.
  $EC31,$03 Store the type in the record.
  $EC34,$02 Set bit 0 of the redraw flags.
  $EC36,$03 Store the flags in the third record.
  $EC39,$01 Return.

c $EC3A Place Special Object
@ $EC3A label=Place_Special_Object
D $EC3A Puts an extra life or a guardian in the room that Sabreman has just
. entered, if there is one in it and it has not been collected or destroyed.
.
. The room of Sabreman is looked up in the table of the sixteen extra lives at
. #R$EDC4 and then in the table of the guardians at #R$EDF4 (the entries are
. three bytes long: the room x, the room y and a collected flag). A guardian is
. dealt with by #R$EBDE.
.
. An extra life is made from a copy of the template at #R$EDB4 in the first of
. the two special object records at #R$8FBA. Byte #N$06 of the record
. holds the number of the entry, counted from the end of the table, which
. #R$E7AD uses to set the collected flag when the extra life is picked up.
.
. The extra life sits on top of one of the two objects at #R$8F9A and
. #R$8FAA, which are the decorations of a special room or the
. stalactites of a cave: the first is used if the room y is odd, the second if
. it is even. In a special room the height of the object comes from the table at
. #R$EBB5.
.
. The loop over the guardians counts eight entries, but the table only has four,
. so it carries on into the code that follows the table.
  $EC3A,$03 Point #REGhl at the table of extra lives.
  $EC3D,$03 Fetch the room x of Sabreman.
  $EC40,$01 Store it in #REGe.
  $EC41,$03 Fetch the room y of Sabreman.
  $EC44,$01 Store it in #REGd.
  $EC45,$02 Set the number of extra lives to check to #N$10.
@ $EC47 label=Place_Special_Object_Find_Extra_Life
  $EC47,$01 Fetch the room x of the entry.
  $EC48,$01 Move on to the room y.
  $EC49,$03 Jump to #R$EC50 if it is not the room x of Sabreman.
  $EC4C,$01 Fetch the room y of the entry.
  $EC4D,$03 Jump to #R$EC68 if it is the room y of Sabreman.
@ $EC50 label=Place_Special_Object_Next_Extra_Life
  $EC50,$02 Move on to the next entry.
  $EC52,$02 Loop back until all the extra lives have been checked.
  $EC54,$03 Point #REGhl at #R$EDF4.
  $EC57,$02 Set the number of guardians to check to #N$08.
@ $EC59 label=Place_Special_Object_Find_Guardian
  $EC59,$01 Fetch the room x of the entry.
  $EC5A,$01 Move on to the room y.
  $EC5B,$03 Jump to #R$EC63 if it is not the room x of Sabreman.
  $EC5E,$01 Fetch the room y of the entry.
  $EC5F,$04 Jump to #R$EBDE if it is the room y of Sabreman, to place the
. guardian.
@ $EC63 label=Place_Special_Object_Next_Guardian
  $EC63,$02 Move on to the next entry.
  $EC65,$02 Loop back until all the entries have been checked.
  $EC67,$01 Return.
@ $EC68 label=Place_Special_Object_Extra_Life
  $EC68,$01 Move on to the collected flag of the entry.
  $EC69,$01 Fetch the collected flag.
  $EC6A,$02 Return if the extra life has been collected already.
  $EC6C,$01 Fetch the number of the entry, counted from the end of the table.
  $EC6D,$01 Stash the room of Sabreman.
  $EC6E,$03 Point #REGhl at #R$EDB4.
  $EC71,$03 Point #REGde at #R$8FBA.
  $EC74,$03 Set the size of a record in #REGbc.
  $EC77,$02 Copy the template to the record.
  $EC79,$03 Store the number of the entry in byte #N$06 of the record.
  $EC7C,$01 Restore the room of Sabreman into #REGbc.
  $EC7D,$01 Disable interrupts.
  $EC7E,$02 Save #REGiy.
  $EC80,$04 Point #REGiy at the object at #R$8F9A.
  $EC84,$04 Jump to #R$EC8C if the room y is odd.
  $EC88,$04 Point #REGiy at the object at #R$8FAA instead.
@ $EC8C label=Place_Special_Object_Set_Position
  $EC8C,$03 Point #REGde at the x position of the special object record.
  $EC8F,$03 Fetch the x position of the object.
  $EC92,$02 Add #N$08.
  $EC94,$01 Set the x position of the extra life.
  $EC95,$01 Move on to the room x.
  $EC96,$01 Fetch the room x.
  $EC97,$01 Set the room x of the extra life.
  $EC98,$01 Move on to the y position.
  $EC99,$01 Fetch the room y.
  $EC9A,$04 Jump to #R$ECB0 if the room is a cave (the room y is #N$10 or more).
@ $EC9E label=Place_Special_Object_Set_Height
  $EC9E,$03 Point #REGhl at #R$EBB5.
  $ECA1,$03 Fetch the type of the decoration.
  $ECA4,$02 Subtract #N$74 to make the number of the decoration.
  $ECA6,$01 Add the number to the address in #REGhl.
  $ECA7,$01 Store the low byte of the address.
  $ECA8,$01 Fetch the high byte of the address.
  $ECA9,$02 Add the carry.
  $ECAB,$01 Store the high byte of the address.
  $ECAC,$01 Fetch the height of the decoration.
  $ECAD,$03 Store it in byte #N$0C of the object, where the size of the obstacle
. is kept.
@ $ECB0 label=Place_Special_Object_Set_Top
  $ECB0,$03 Fetch the y position of the object.
  $ECB3,$03 Subtract its height to get the y position of its top.
  $ECB6,$01 Set the y position of the extra life.
  $ECB7,$01 Move on to the room y.
  $ECB8,$01 Fetch the room y.
  $ECB9,$01 Set the room y of the extra life.
  $ECBA,$02 Restore #REGiy.
  $ECBC,$01 Return.

c $ECBD Clear Collected Flags
@ $ECBD label=Clear_Collected_Flags
D $ECBD Clears the collected flags of the sixteen extra lives and the four
. guardians, which are in the two tables that start at #R$EDC4. It is used when
. a new game starts.
  $ECBD,$03 Point #REGhl at the collected flag of the first entry.
  $ECC0,$02 Set the number of entries to clear to #N$14.
@ $ECC2 label=Clear_Collected_Flags_Loop
  $ECC2,$02 Clear the collected flag.
  $ECC4,$03 Move on to the next entry.
  $ECC7,$02 Loop back until all the flags have been cleared.
  $ECC9,$01 Return.

c $ECCA Handle Guardian
@ $ECCA label=Handle_Guardian
D $ECCA Handler for the object types #N$80 to #N$87, the four guardians that
. stand in the caves: the imps (#N$80, #N$81, #N$84 and #N$85, see #R$A1B5), the
. spiders (#N$82 and #N$83, see #R$D4B9) and the bats (#N$86 and #N$87, see
. #R$A267). Bit 0 of the type is the frame of the animation and it is flipped
. whenever bit 0 of the tick counter is set. #R$EBDE puts a guardian in its
. room, where it stays until Sabreman leaves the room (see #R$E7A8).
.
. A guardian is destroyed by one kind of weapon, which depends on bits 1 and 2
. of its type: the daggers (the types #N$6C and #N$6D) destroy a spider, the
. arrows (#N$6E and #N$6F) destroy the imp of the type #N$84 and the fire (#N$70
. and #N$71) destroys a bat. The imp of the type #N$80 cannot be destroyed. When
. a guardian is destroyed its collected flag is set (see #R$E7C2), the flag at
. #R$8EF9 is set and the guardian explodes (see #R$DF42).
.
. A guardian that is touched by Sabreman makes him tumble (bit 7 of his redraw
. flags is set) and pushes him to the left (his x velocity is set to #N$FE).
R $ECCA IX Object record of the guardian
  $ECCA,$03 Save the state of the guardian.
  $ECCD,$03 Fetch the room x of Sabreman.
  $ECD0,$06 Jump to #R$E7A8 to remove the guardian if it is in a different room
. x.
  $ECD6,$03 Fetch the room y of Sabreman.
  $ECD9,$06 Jump to #R$E7A8 to remove the guardian if it is in a different room
. y.
  $ECDF,$03 Fetch the tick counter.
  $ECE2,$02,b$01 Test bit 0 of the tick counter.
  $ECE4,$02 Jump to #R$ECEE if it is not set.
  $ECE6,$03 Fetch the type of the guardian.
  $ECE9,$02,b$01 Flip the frame of the animation.
  $ECEB,$03 Store the type.
@ $ECEE label=Handle_Guardian_Check_Weapon
  $ECEE,$03 Check whether a weapon has hit the guardian.
  $ECF1,$04 Jump to #R$ED16 if no weapon has hit it.
  $ECF5,$01 Fetch the type of the weapon into #REGa.
  $ECF6,$04 Jump to #R$ED16 if the weapon is not a dagger, an arrow or fire.
  $ECFA,$01 Halve the type of the weapon.
  $ECFB,$01 Subtract one.
  $ECFC,$02,b$01 Keep the two low bits, which gives the kind of weapon (#N$01
. for the daggers, #N$02 for the arrows and #N$03 for the fire).
  $ECFE,$01 Store the kind in #REGe.
  $ECFF,$03 Fetch the type of the guardian.
  $ED02,$01 Halve it.
  $ED03,$02,b$01 Keep the two low bits, which gives the kind of weapon that
. destroys the guardian.
  $ED05,$03 Jump to #R$ED16 if the weapon is not the right one for the guardian.
  $ED08,$03 Point #REGhl at #R$EDF6.
  $ED0B,$03 Set the collected flag of this guardian.
  $ED0E,$05 Set the flag that shows that a guardian has been destroyed.
  $ED13,$03 Jump to #R$DF42 to make the guardian explode.
@ $ED16 label=Handle_Guardian_Check_Sabreman
  $ED16,$03 Check for contact with Sabreman, without testing his sprite id.
  $ED19,$05 Jump to #R$96CB to draw the guardian if Sabreman is not touching it.
  $ED1E,$03 Fetch the redraw flags of Sabreman.
  $ED21,$02,b$01 Set bit 7, which makes him tumble.
  $ED23,$03 Store the flags.
  $ED26,$02 Set the x velocity of Sabreman to #N$FE, which pushes him to the
. left.
  $ED28,$03 Store the velocity.
  $ED2B,$03 Jump to #R$96CB to draw the guardian.

c $ED2E Handle Rock Formation
@ $ED2E label=Handle_Rock_Formation
D $ED2E Handler for the object type #N$88, the rock formation that hangs from
. the ceiling of the cave of a guardian (see #R$EC1C).
.
. The formation is made from ten of the rocks of the sprite at #R$D815, in four
. rows of four, three, two and one rocks. They are drawn once, when bit 0 of the
. redraw flags is set. The rocks of a row are #N$08 pixels apart, and the rows
. are #N$18 pixels apart: the y positions of the rows are #N$30, #N$48, #N$60
. and #N$78, and the x positions of the first rocks are #N$78, #N$7A, #N$7E and
. #N$82. The bit is set again before each rock is drawn so that nothing is
. erased.
.
. After that the area that the formation covers is coloured on every call, with
. five cells in each of ten rows set to the attribute #N$46 (yellow).
.
. An object touches the formation according to #R$ED8A.
R $ED2E IX Object record of the rock formation
  $ED2E,$06 Jump to #R$ED73 to colour the formation if it has been drawn
. already.
  $ED34,$04 Set the x position of the first rock to #N$78.
  $ED38,$04 Set the y position of the first row to #N$30.
  $ED3C,$02 Set the number of rocks in the first row (and of rows) to four.
  $ED3E,$04 Set the attribute of the rocks to #N$46 (yellow).
@ $ED42 label=Handle_Rock_Formation_Row
  $ED42,$01 Set the number of rocks in the row.
@ $ED43 label=Handle_Rock_Formation_Rock
  $ED43,$01 Stash the counters.
  $ED44,$03 Draw the rock.
  $ED47,$04 Set bit 0 of the redraw flags, so that the next rock does not erase
. the last one.
  $ED4B,$03 Fetch the x position.
  $ED4E,$02 Move on to the next rock.
  $ED50,$03 Set the x position.
  $ED53,$01 Restore the counters.
  $ED54,$02 Loop back until the row has been drawn.
  $ED56,$01 Fetch the number of rows left.
  $ED57,$02 Double it.
  $ED59,$01 Subtract one.
  $ED5A,$02 Double it again.
  $ED5C,$02 Negate it.
  $ED5E,$02 Add #N$88 to make the x position of the first rock of the next row.
  $ED60,$03 Set the x position.
  $ED63,$03 Fetch the y position.
  $ED66,$02 Move on to the next row.
  $ED68,$03 Set the y position.
  $ED6B,$03 Jump back to #R$ED42 until all the rows have been drawn.
  $ED6E,$04 Reset bit 0 of the redraw flags.
  $ED72,$01 Return.
@ $ED73 label=Handle_Rock_Formation_Colour
  $ED73,$03 Set the x position #N$78 in #REGl and the y position #N$30 in #REGh.
  $ED76,$03 Get the attribute address of the cell.
  $ED79,$03 Set the offset to the start of the next row (the row is #N$20 cells
. long and five have been set).
  $ED7C,$02 Set the number of rows to colour to ten.
@ $ED7E label=Handle_Rock_Formation_Colour_Row
  $ED7E,$02 Set the number of cells in each row to five.
@ $ED80 label=Handle_Rock_Formation_Colour_Cell
  $ED80,$02 Set the attribute of the cell to #N$46 (yellow).
  $ED82,$01 Move on to the next cell.
  $ED83,$02 Loop back until the row has been coloured.
  $ED85,$01 Move on to the next row.
  $ED86,$03 Jump back to #R$ED7E until all the rows have been coloured.
  $ED89,$01 Return.

c $ED8A Check Rock Formation Contact
@ $ED8A label=Check_Rock_Formation_Contact
D $ED8A Checks whether an object touches the rock formation (see #R$ED2E). It is
. used by #R$B46A in place of the usual test when the obstacle is of the type
. #N$88.
.
. The formation is a triangle with its point at the bottom, which is centred on
. the x position #N$80. The half width of the triangle at the height of the
. object is #N$9A less the y position of the object, divided by four (the half
. width is larger when the object is higher) and then #N$08 is added. An object
. touches the formation when it is not below #N$90 and its distance from the
. centre is less than that.
.
. The result has bits 0 and 2 set when the object touches the formation, and bit
. 7 as well when the object is on the right of the centre. The object is never
. standing on the formation.
R $ED8A IX Object record
R $ED8A O:C Contact result (see #R$B46A)
  $ED8A,$02 Clear the contact result.
  $ED8C,$02 #REGb=#N$01.
  $ED8E,$03 Fetch the y position of the object.
  $ED91,$03 Return if the object is #N$90 or more pixels down, as it is below
. the formation.
  $ED94,$02 Negate the y position.
  $ED96,$02 Subtract #N$66, which gives #N$9A less the y position.
  $ED98,$04 Divide the result by four.
  $ED9C,$02 Add #N$08.
  $ED9E,$01 Store the half width in #REGd.
  $ED9F,$02 Set the centre of the formation, #N$80.
  $EDA1,$06 Jump to #R$EDAB if the object is on the left of the centre.
  $EDA7,$02 Make the distance positive.
  $EDA9,$02 Set bit 7 of the result, as the object is on the right.
@ $EDAB label=Check_Rock_Formation_Contact_Test_Width
  $EDAB,$04 Jump to #R$B4CA if the distance is the half width or more, as the
. objects do not touch.
  $EDAF,$02 Set bit 0 of the result, as the object is outside the middle.
  $EDB1,$02 Set bit 2 of the result, as the objects touch.
  $EDB3,$01 Return.

b $EDB4 Extra Life Template
@ $EDB4 label=Extra_Life_Template
D $EDB4 An object record that #R$EC3A copies to the first of the two special
. object records at #R$8FBA, to make an extra life. #R$EBDE uses it for
. a guardian too and changes the type, the attribute and the position.
B $EDB4,$01 The type, #N$7F (see #R$A1A3).
B $EDB5,$04,$04 The x position, the room x, the y position and the room y, which
. are set when the extra life is placed.
B $EDB9,$01 The attribute, #N$47 (bright white).
B $EDBA,$01 The number of the entry in the table of extra lives (or of
. guardians), which is set when the extra life is placed.
B $EDBB,$08,$08 Not used.
B $EDC3,$01 The redraw flags, with bit 0 set so that the extra life is drawn
. without erasing anything.

b $EDC4 Extra Life Table
@ $EDC4 label=Extra_Life_Table
D $EDC4 The sixteen places of the extra lives, with three bytes for each: the
. room x, the room y and the collected flag. The flag is set to #N$01 by #R$E7AD
. when Sabreman picks up the extra life and is cleared at the start of a game by
. #R$ECBD. #R$EC3A looks for the room of Sabreman in this table.
B $EDC4,$02,$02 The room x and room y of the first extra life.
@ $EDC6 label=Extra_Life_Table_First_Flag
B $EDC6,$01 The collected flag of the first extra life.
B $EDC7,$2D,$03 The other fifteen extra lives.

b $EDF4 Guardian Table
@ $EDF4 label=Guardian_Table
D $EDF4 The places of the four guardians, with three bytes for each: the room x,
. the room y and the destroyed flag (see #R$ECCA). The table follows the table
. of extra lives, so that the flags of both can be cleared together by #R$ECBD.
.
. The entries make the guardians of the types #N$80, #N$86, #N$84 and #N$82 in
. that order (see #R$EBDE).
N $EDF4 An imp, which no weapon can destroy.
B $EDF4,$02,$02 The room x and room y of the first guardian.
@ $EDF6 label=Guardian_Table_First_Flag
B $EDF6,$01 The destroyed flag of the first guardian.
N $EDF7 A bat.
B $EDF7,$03,$03
N $EDFA An imp.
B $EDFA,$03,$03
N $EDFD A spider.
B $EDFD,$03,$03

c $EE00 Read Cursor Keys
@ $EE00 label=Read_Cursor_Keys
D $EE00 Reads the cursor keys and puts the state of the controls in #REGb, to be
. completed by #R$AE2C (see #R$AE17). The keys are 5 (left), 6 (down), 7 (up), 8
. (right) and 0 (fire), and a bit is reset when its key is pressed.
R $EE00 O:B The state of the controls
  $EE00,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $EE06,$01 Stash the state of the keys in #REGc.
  $EE07,$02,b$01 Keep only bit 3, which is the key 7 (up).
  $EE09,$01 Store it in #REGe.
  $EE0A,$01 Fetch the state of the keys.
  $EE0B,$02 Rotate the keys right twice, which moves the key 0 into bit 6, the
. key 6 into bit 2 and the key 8 into bit 0.
  $EE0D,$02,b$01 Keep only those three bits.
  $EE0F,$01 Combine them with up.
  $EE10,$01 Store the result in #REGe.
  $EE11,$02 Rotate the result right twice, which moves fire from bit 6 into bit
. 4.
  $EE13,$02,b$01 Keep only bit 4.
  $EE15,$01 Combine it with the other directions.
  $EE16,$02,b$01 Keep only the five low bits, which are right, down, up and fire
. (the bit for left is not set yet).
  $EE18,$01 Store the result in #REGe.
  $EE19,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $EE1F,$03 Rotate the keys right three times, which moves the key 5 into bit 1.
  $EE22,$02,b$01 Keep only that bit (left).
  $EE24,$01 Combine it with the other controls.
  $EE25,$01 Store the state of the controls in #REGb.
  $EE26,$03 Jump to #R$AE2C to read the bottom row of the keyboard.

c $EE29 Read Interface II Joystick
@ $EE29 label=Read_Interface_II_Joystick
D $EE29 Reads the Interface II joystick, which acts as the keys 6 (left), 7
. (right), 8 (down), 9 (up) and 0 (fire), and puts the state of the controls in
. #REGb, to be completed by #R$AE2C (see #R$AE17). A bit is reset when its key
. is pressed.
R $EE29 O:B The state of the controls
  $EE29,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $EE2F,$01 Move the key 0 (fire) into the carry flag.
  $EE30,$02 Shift it into #REGb.
  $EE32,$01 Move the key 9 (up) into the carry flag.
  $EE33,$02 Shift it into #REGb.
  $EE35,$01 Move the key 8 (down) into the carry flag.
  $EE36,$02 Shift it into #REGb.
  $EE38,$02 Move the key 6 (left) into the carry flag, skipping the key 7.
  $EE3A,$02 Shift it into #REGb.
  $EE3C,$01 Move the key 7 (right) into the carry flag.
  $EE3D,$02 Shift it into #REGb, which makes bit 0 right, bit 1 left, bit 2
. down, bit 3 up and bit 4 fire.
  $EE3F,$03 Jump to #R$AE2C to read the bottom row of the keyboard.

c $EE42 Move Object Horizontally
@ $EE42 label=Move_Object_Horizontally
D $EE42 Adds a velocity to the x position of an object. The velocity is
. multiplied by sixteen and added to the x position and its fraction (byte #N$0A
. of the record), so that the position changes by a sixteenth of the velocity in
. each call. The new x position is returned, but it is not stored in the record:
. that is up to the caller.
R $EE42 HL The x velocity, with the sign extended to sixteen bits
R $EE42 IX Object record
R $EE42 O:A The new x position
R $EE42 O:F The zero flag is set if the new x position is less than #N$80
  $EE42,$04 Multiply the velocity by sixteen.
  $EE46,$03 Fetch the fraction of the x position.
  $EE49,$03 Fetch the x position.
  $EE4C,$01 Add the velocity to the position.
  $EE4D,$03 Store the new fraction.
  $EE50,$01 Fetch the new x position.
  $EE51,$02 Test bit 7 of the new x position.
  $EE53,$01 Return.

c $EE54 Move Object Vertically
@ $EE54 label=Move_Object_Vertically
D $EE54 Adds a velocity to the y position of an object. It works like #R$EE42,
. but with the y position and its fraction (byte #N$0D of the record).
R $EE54 HL The y velocity, with the sign extended to sixteen bits
R $EE54 IX Object record
R $EE54 O:A The new y position
R $EE54 O:F The zero flag is set if the new y position is less than #N$80
  $EE54,$04 Multiply the velocity by sixteen.
  $EE58,$03 Fetch the fraction of the y position.
  $EE5B,$03 Fetch the y position.
  $EE5E,$01 Add the velocity to the position.
  $EE5F,$03 Store the new fraction.
  $EE62,$01 Fetch the new y position.
  $EE63,$02 Test bit 7 of the new y position.
  $EE65,$01 Return.

c $EE66 Handle Gargoyle
@ $EE66 label=Handle_Gargoyle
D $EE66 Handler for the object types #N$34 to #N$37, the gargoyle (see #R$D2EB).
. It is a flying creature that is handled like the jellyfish (see #R$B3D8), and
. it shares the routines that animate and move it.
.
. When the gargoyle is in a different room x from Sabreman, its y velocity is
. set to a random #N$20 or #N$E0 (see #R$EE9A) and #R$B2CF moves it towards his
. room. When it is in the same room x but a different room y, its x velocity is
. set to a random #N$20 or #N$E0 and #R$B358 moves it towards his room. When it
. is in the same room as Sabreman it is animated and moves in the same way as
. the jellyfish (see #R$B40B).
R $EE66 IX Object record
  $EE66,$03 Read the world map entry of the room that the gargoyle is in. The
. flags of the room are returned in #REGe.
  $EE69,$03 Fetch the contact flags of the gargoyle.
  $EE6C,$01 Combine them with the flags of the room.
  $EE6D,$01 Store the result in #REGe.
  $EE6E,$03 Fetch the room x of Sabreman.
  $EE71,$05 Jump to #R$EE84 if the gargoyle is in a different room x.
  $EE76,$03 Fetch the room y of Sabreman.
  $EE79,$05 Jump to #R$EE8F if the gargoyle is in a different room y.
  $EE7E,$03 Animate the gargoyle.
  $EE81,$03 Jump to #R$B40B to set the x velocity and to move the gargoyle.
@ $EE84 label=Handle_Gargoyle_Different_Room_X
  $EE84,$01 Stash the result of the comparison, as the carry flag says which way
. Sabreman's room is.
  $EE85,$03 Choose a velocity.
  $EE88,$03 Set the y velocity.
  $EE8B,$01 Restore the result of the comparison.
  $EE8C,$03 Jump to #R$B2CF to move the gargoyle towards the room x of Sabreman.
@ $EE8F label=Handle_Gargoyle_Different_Room_Y
  $EE8F,$01 Stash the result of the comparison, as the carry flag says which way
. Sabreman's room is.
  $EE90,$03 Choose a velocity.
  $EE93,$03 Set the x velocity.
  $EE96,$01 Restore the result of the comparison.
  $EE97,$03 Jump to #R$B358 to move the gargoyle towards the room y of Sabreman.

c $EE9A Choose Random Velocity
@ $EE9A label=Choose_Random_Velocity
D $EE9A Returns either #N$20 or #N$E0 (that is, #N$20 or minus #N$20), which
. depends on bit 6 of the low byte of FRAMES.
R $EE9A O:A #N$20 if bit 6 of FRAMES is set, otherwise #N$E0
  $EE9A,$03 Fetch the low byte of FRAMES.
  $EE9D,$02,b$01 Keep only bit 6.
  $EE9F,$02,b$01 Set bit 5.
  $EEA1,$02 Subtract #N$40, which gives #N$20 if bit 6 was set and #N$E0 if it
. was not.
  $EEA3,$01 Return.

b $EEA4 Font
@ $EEA4 label=Font
D $EEA4 The glyphs for the characters #N$30 to #N$5A. #R$98DF finds the
. glyph for a character at #N$ED24 plus eight times the character code, so
. the glyphs for the codes below #N$30 would fall inside the code above.
E $EEA4 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$6308 }
. { #KNIGHTLORE$6108 }
. { #MARTIANOIDS$C33C }
. { #NIGHTSHADE$6CDE }
. { #PENTAGRAM$8355 }
. LIST#
  $EEA4,$08 #UDG(#PC)
L $EEA4,$08,$2B

i $EFFC
