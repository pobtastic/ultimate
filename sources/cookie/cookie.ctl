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
D $4000 #UDGTABLE { =h Cookie Loading Screen } { #SCR$02(loading) } UDGTABLE#
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

c $5B80 Game Entry Point
@ $5B80 label=GameEntry
D $5B80 The address which the game is started from. It moves the main body of
. the game down by one byte, and then jumps to it.
E $5B80 View the equivalent code in;
. #LIST
. { #JETPAC$5B80 }
. { #PSSST$5B80 }
. { #SABREWULF$6000 }
. { #TRANZAM$5B80 }
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

c $5F00 Security Check
@ $5F00 label=SecurityCheck
D $5F00 The game only starts when the second byte of #SKOOLKID$5C78(FRAMES) is
. #N$32. If it is any other value then this returns to the caller instead.
E $5F00 View the equivalent code in;
. #LIST
. { #ATICATAC$6000 }
. { #JETPAC$61E5 }
. { #LUNARJETMAN$8000 }
. { #PSSST$61C6 }
. { #SABREWULF$995A }
. { #TRANZAM$5F00 }
. LIST#
  $5F00,$03 Fetch the second byte of #SKOOLKID$5C78(FRAMES).
  $5F03,$03 Return if the second byte of #SKOOLKID$5C78(FRAMES) is not "2".
  $5F06,$03 Start the game by jumping to #R$6298.

g $5F09 High Score
@ $5F09 label=High_Score
D $5F09 3-byte representation of the score.
E $5F09 View the equivalent code in;
. #LIST
. { #JETPAC$5CF0 }
. { #LUNARJETMAN$5E06 }
. { #PSSST$5E00 }
. { #TRANZAM$5E49 }
. LIST#
B $5F09,$01 Byte #1.
@ $5F0A label=High_Score_2
B $5F0A,$01 Byte #2.
@ $5F0B label=High_Score_3
B $5F0B,$01 Byte #3.

g $5F0C Game Options
@ $5F0C label=GameOptions
D $5F0C #TABLE(default,centre,centre)
. { =h Byte | =h Binary | =h Option }
. { #N$00 | #EVAL($00, 2, 8) | 1UP Game + Keyboard }
. { #N$01 | #EVAL($01, 2, 8) | 2UP Game + Keyboard }
. { #N$02 | #EVAL($02, 2, 8) | 1UP Game + Kempston Joystick }
. { #N$03 | #EVAL($03, 2, 8) | 2UP Game + Kempston Joystick }
. { #N$04 | #EVAL($04, 2, 8) | 1UP Game + Cursor Joystick }
. { #N$05 | #EVAL($05, 2, 8) | 2UP Game + Cursor Joystick }
. TABLE#
.
. Bit 0 is set for a two player game. The number in bits 1-2 chooses the
. controls; #N$00 is the keyboard, #N$01 is the Kempston joystick and #N$02 is
. the cursor joystick.
E $5F0C View the equivalent code in;
. #LIST
. { #JETPAC$5CF3 }
. { #PSSST$5E03 }
. { #UNDERWURLDE$8ED5 }
. LIST#
B $5F0C,$01
g $5F0D Sound Mute Flag
@ $5F0D label=Sound_Enable
D $5F0D Zero when the sound is on. Any other value means the sound is muted, and
. the tunes which are played by #R$6568 are skipped. It is set by #R$6298 from
. a checksum of the #SKOOLKID$03B5(BEEPER) routine.
B $5F0D,$01

g $5F0E 1UP Score
@ $5F0E label=1UP_Score_1
D $5F0E 3-byte representation of the score.
B $5F0E,$01 Byte #1.
@ $5F0F label=1UP_Score_2
B $5F0F,$01 Byte #2.
@ $5F10 label=1UP_Score_3
B $5F10,$01 Byte #3.

g $5F11 2UP Score
@ $5F11 label=2UP_Score_1
D $5F11 3-byte representation of the score.
B $5F11,$01 Byte #1.
@ $5F12 label=2UP_Score_2
B $5F12,$01 Byte #2.
@ $5F13 label=2UP_Score_3
B $5F13,$01 Byte #3.

g $5F14 Old Sprite
@ $5F14 label=OldSprite_X
D $5F14 The position and sprite ID of the actor, as recorded by #R$76D0 before
. the actor was moved. The sprite is erased from here by #R$75CC.
B $5F14,$01 Horizontal co-ordinate.
@ $5F15 label=OldSprite_Y
B $5F15,$01 Vertical co-ordinate (the bottom edge of the sprite).
@ $5F16 label=OldSprite_ID
B $5F16,$01 Sprite ID.

g $5F17 Actor Sprite Rows
@ $5F17 label=ActorSprite_Rows
D $5F17 The number of rows of the actor sprite which are on the screen. This is
. used to work out how many rows of attribute cells to colour.
B $5F17,$01

g $5F18 Actor Sprite Width
@ $5F18 label=ActorSprite_Width
D $5F18 The width of the actor sprite in character cells; #N$02 when it is
. aligned to a character cell, otherwise #N$03.
B $5F18,$01

g $5F19 Sprite Rows Remaining
@ $5F19 label=OldSprite_RowsRemaining
D $5F19 The number of rows of the old sprite which have not yet been drawn.
B $5F19,$01
@ $5F1A label=ActorSprite_RowsRemaining
D $5F1A The number of rows of the actor sprite which have not yet been drawn.
B $5F1A,$01

g $5F1B Actors In Play
@ $5F1B label=ActorsInPlay
D $5F1B Set to zero at the start of each pass through the actors, and increased
. by one by the handlers of the actors which are in play.
B $5F1B,$01
@ $5F1C label=ActorsInPlay_Last
D $5F1C The value of #R$5F1B at the end of the last pass through the actors.
B $5F1C,$01

g $5F1D Frame Counter
@ $5F1D label=FrameCounter
D $5F1D Increased by one after each pass through the actors.
W $5F1D,$02

g $5F1F Actor Sprite Position
@ $5F1F label=ActorSprite_Position
D $5F1F The position of the actor sprite, used by #R$74EE to find the first
. attribute cell to colour.
W $5F1F,$02

g $5F21 Active Player
@ $5F21 label=Flag_ActivePlayer
D $5F21 The currently active player. It is toggled with a CPL command by
. #R$6BAF when the turn changes, so it is either #N$00 or #N$FF.
. #TABLE(default,centre,centre)
. { =h Value | =h Player }
. { #N$00 | 1UP }
. { #N$FF | 2UP }
. TABLE#
B $5F21,$01

g $5F22 Last Frame
@ $5F22 label=LastFrame
D $5F22 The low byte of #SKOOLKID$5C78(FRAMES) at the last frame update. The
. main loop at #R$6463 runs #R$7160 whenever this is different from the current
. value (#SKOOLKID$5C78(FRAMES) is increased by every interrupt).
B $5F22,$01

g $5F23 Frame Updated
@ $5F23 label=FrameUpdated
D $5F23 Has the frame been updated? #N$00=No #N$01=Yes.
B $5F23,$01

g $5F24 Current menu item colour attribute
@ $5F24 label=Current_MenuAttribute
D $5F24 Current menu item colour attribute.
B $5F24,$01

g $5F25 Game Delay Timer
@ $5F25 label=GameDelayTimer
D $5F25 At the beginning of each player turn there is a delay to allow the
. player to be ready for play. It is counted down by #R$7048, and no actors
. are created by #R$71D8 until it reaches zero.
. #TABLE(default,centre,centre)
. { =h Value | =h Game Mode }
. { #N$80 | 1UP }
. { #N$FF | 2UP }
. TABLE#
. The larger delay for a 2UP game is useful for swapping players controls.
B $5F25,$01

g $5F26 Unused
@ $5F26 label=Unused_5F26
D $5F26 This byte is not used by the game.
B $5F26,$01

g $5F27 Pantry Shelf Colour
@ $5F27 label=PantryShelfColour
D $5F27 The colour attribute of the ingredient for the shelf which is being
. drawn in the pantry. It is set by #R$6002, from the table at #R$6011.
B $5F27,$01

g $5F28 Tile Block Width
@ $5F28 label=TileBlockWidth
D $5F28 The number of tiles in each row of the block which is being drawn by
. #R$60E2 or coloured by #R$60A4.
B $5F28,$01

g $5F29 Charlie Running Flag
@ $5F29 label=CharlieRunningFlag
D $5F29 Used in the introduction to a level. It is set to zero by #R$6D38, and
. then to #N$01 by #R$6E11 when the ingredient has moved far enough to the left
. for Charlie to start running after it.
B $5F29,$01

g $5F2A Pantry Highlight Mask
@ $5F2A label=PantryHighlightMask
D $5F2A Has one bit set to show which shelf of the pantry is highlighted, which
. is bit #N$05 for the top shelf down to bit #N$01 for the bottom shelf. It is
. made by #R$6017 by shifting #N$20 right by the level (modulo #N$08), so for
. the levels which have no ingredient no shelf is highlighted.
B $5F2A,$01

g $5F2B Charlie Last Movement
@ $5F2B label=CharlieLastMovement
D $5F2B The last direction in which Charlie moved. The low byte is the
. horizontal speed and the high byte is the vertical speed. It is updated by
. #R$706B each time Charlie moves and is set to #N($0002, $04, $04) (moving
. right) by #R$7378. Flour shots are fired in this direction, at three times
. the speed.
W $5F2B,$02

g $5F2D Active Player Level
@ $5F2D label=ActivePlayer_Level
D $5F2D The level of the active player. Bits 0-2 are the level within a set of
. five, and bits 3-5 are the set. It is #N$FF for a player who has not started
. yet, so that #R$6C3C (which adds one to the level) starts them on level
. #N$00. Swapped with #R$5F31 by #R$6416.
B $5F2D,$01

g $5F2E Active Player Lives
@ $5F2E label=ActivePlayer_Lives
D $5F2E The lives which the active player has left. Swapped with #R$5F32 by
. #R$6416.
N $5F2E See #POKE(lives,Lives).
B $5F2E,$01

g $5F2F Active Player Ingredients Needed
@ $5F2F label=ActivePlayer_IngredientsNeeded
D $5F2F The number of ingredients which are still needed (in BCD). It is shown
. inside the mixing bowl. The level is finished when it reaches zero and there
. are no actors left in play. Swapped with #R$5F33 by #R$6416.
N $5F2F See #POKE(ingredients,Ingredients).
B $5F2F,$01

g $5F30 Active Player Level Number
@ $5F30 label=ActivePlayer_LevelNumber
D $5F30 The level number (in BCD) which is shown in the "LEV" box. Swapped with
. #R$5F34 by #R$6416.
B $5F30,$01

g $5F31 Inactive Player Level
@ $5F31 label=InactivePlayer_Level
D $5F31 The level of the player who is not active, in the same format as
. #R$5F2D.
B $5F31,$01

g $5F32 Inactive Player Lives
@ $5F32 label=InactivePlayer_Lives
D $5F32 The lives which the inactive player has left.
B $5F32,$01

g $5F33 Inactive Player Ingredients Needed
@ $5F33 label=InactivePlayer_IngredientsNeeded
D $5F33 The number of ingredients which are still needed by the inactive
. player (in BCD).
B $5F33,$01

g $5F34 Inactive Player Level Number
@ $5F34 label=InactivePlayer_LevelNumber
D $5F34 The level number (in BCD) of the inactive player.
B $5F34,$01

g $5F35 Charlie
@ $5F35 label=ActorCharlie
D $5F35 The first of the ten actor slots (up to #R$5F85), which is always
. Charlie. Every actor has the same eight byte format, and is processed once
. for each pass through the game loop.
. #TABLE(default,centre,centre)
. { =h Offset | =h Contents }
. { #N$00 | ID (sprite ID and handler, see #R$6486) }
. { #N$01 | Horizontal co-ordinate }
. { #N$02 | Vertical co-ordinate }
. { #N$03 | Colour attribute }
. { #N$04-#N$07 | Used by the handler }
. TABLE#
B $5F35,$01 ID.
@ $5F36 label=ActorCharlie_X
B $5F36,$01 Horizontal co-ordinate.
B $5F37,$01 Vertical co-ordinate.
B $5F38,$01 Colour attribute.
B $5F39,$04 Used by the handler.

g $5F3D Flour Shot Slots
@ $5F3D label=ActorFlourShots
D $5F3D The two actor slots for flour shots, in the same format as the actor at
. #R$5F35. A shot is made in one of these by #R$706B when Charlie fires, and
. handled by #R$6F78.
B $5F3D,$10,$08

g $5F4D Sound Effect Actor
@ $5F4D label=SoundEffectActor
D $5F4D The actor slot which is used to play sound effects (see #R$68C7).
B $5F4D,$08

g $5F55 Spawn Slots
@ $5F55 label=ActorSpawnSlots
D $5F55 The six actor slots which are used for the ingredients, the nasties and
. the other actors which are created while the game is played (the last one,
. #N$5F7D, is where the monster is made by #R$67E2). They are in the same
. format as the actor at #R$5F35. A slot is empty when its ID is zero.
B $5F55,$08,$08
@ $5F5D label=ActorSpawnSlot_2
B $5F5D,$20,$08
@ $5F7D label=ActorMonsterSlot
B $5F7D,$08,$08

t $5F85 Messaging: Copyright
D $5F85 The copyright messages. The second message is printed on the game menu
. by #R$6332; the first is not used by the game.
@ $5F85 label=Message_Copyright
E $5F85 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$9174 }
. LIST#
  $5F85,$09 "COPYRIGHT".
N $5F8E #N(#PEEK(#PC)) is the text colour. #N(#PEEK(#PC + $01)) is the font code for the "©" symbol.
@ $5F8E label=Message_Rights
  $5F8E,$21,h$01,c$01,$1E:$01 "© 1983 A.C.G. ALL RIGHTS RESERVED".

b $5FAF Charlie Template
@ $5FAF label=CharlieTemplate
D $5FAF The data for Charlie at the start of each life, which #R$6FFD copies to
. #R$5F35. The ID is #N$01, the horizontal co-ordinate is #N$60, the vertical
. co-ordinate is #N$78 and the colour is #N$47 (white).
B $5FAF,$08,$01

c $5FB7 Create Game Window
@ $5FB7 label=CreateWindow
D $5FB7 Clears the screen and draws the top line of the game window: the 1UP,
. HI and 2UP labels, the colours for the lives icons, and the three scores.
. #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$62B5,stop=$62BC,sp=$5F00)
. #SCR$02(game-window) } UDGTABLE# #POPS
E $5FB7 View the equivalent code in;
. #LIST
. { #JETPAC$608A }
. { #LUNARJETMAN$84D8 }
. LIST#
N $5FB7 Blank the screen and write the banner.
  $5FB7,$03 Blank the attribute buffer using #R$74E2.
  $5FBA,$03 Blank the screen buffer using #R$74D4.
  $5FBD,$03 Print the "1UP", "HI" and "2UP" labels using #R$74AE.
N $5FC0 Set the attributes for the 1UP lives graphic.
  $5FC0,$03 Set the attribute buffer address of the 1UP lives.
  $5FC3,$02 Set the colour of the lives to #COLOUR$47.
  $5FC5,$01 Colour the 1UP lives digit.
  $5FC6,$01 Move onto the next column.
  $5FC7,$01 Colour the 1UP lives icon.
N $5FC8 Set the attributes for the 2UP lives graphic.
  $5FC8,$03 Set the attribute buffer address of the 2UP lives.
  $5FCB,$01 Colour the 2UP lives digit.
  $5FCC,$01 Move onto the next column.
  $5FCD,$01 Colour the 2UP lives icon.
N $5FCE Set the attributes for the score line (the whole line is #COLOUR$45).
  $5FCE,$03 Set the attribute buffer address of the score line.
  $5FD1,$03 Set the column counter to #N$20 (the width of the screen) and the
. colour of the score line to #COLOUR$45.
@ $5FD4 label=CreateWindow_Loop
  $5FD4,$01 Colour a cell of the score line.
  $5FD5,$01 Move onto the next column.
  $5FD6,$02 Decrease the column counter by one and loop back to #R$5FD4 until
. the whole score line has been coloured.
N $5FD8 Write the 1UP, 2UP and HI scores.
  $5FD8,$03 Print the 1UP score using #R$7438.
  $5FDB,$03 Print the 2UP score using #R$7440.
  $5FDE,$03 Jump to #R$7448 to print the high score.

c $5FE1 Start Level
@ $5FE1 label=StartLevel
D $5FE1 Redraws the playing area for the active player, shows the pantry and
. puts Charlie in his starting position.
N $5FE1 #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$6428,stop=$6457,sp=$5F00)
. #SIM(start=$5FE1,stop=$6001,sp=$5F00)
. #SCR$02(new-level) }
. { #SCR$01,$00,$15,$04,$02(pillar-strip) } UDGTABLE# #POPS
N $5FE1 #R$6FFD takes a life away, so the life it is about to remove is added
. back first.
  $5FE1,$04 Add one to the lives of the active player (#R$5F2E).
  $5FE5,$03 Take a life away from the active player using #R$6FFD.
@ $5FE8 label=StartLevel_TestLevel
N $5FE8 The level is #N$FF when there is no second player in a one player game,
. so there is nothing to start.
  $5FE8,$03 Fetch the level of the active player.
  $5FEB,$01 Add one, so that a level of #N$FF becomes zero.
  $5FEC,$01 Return if there is no player to start.
N $5FED Draw the window, then the pantry, then the remaining lives.
  $5FED,$03 Draw the window using #R$5FB7.
  $5FF0,$03 Draw the pantry using #R$6017.
  $5FF3,$03 Show the lives of both players using #R$7378.
N $5FF6 #HTML(Self modifying code; this updates the command at #R$74EE(#N$7515) to <strong>"CP #N$1A"</strong>.)
  $5FF6,$05 Write #N$1A to #R$74EE(#N$7516).
  $5FFB,$06 Record the current frame at #R$5F22, so that the frame update does
. not run straight away.
  $6001,$01 Return.

c $6002 Set Pantry Fill Colour
@ $6002 label=PantryFillColour
D $6002 Picks the attribute used for the blank tiles of one pantry shelf.
R $6002 B Shelf number
  $6002,$01 Fetch the shelf number.
  $6003,$01 Switch to the shadow registers.
  $6004,$03 Use the shelf number as an offset into the table of fill colours.
  $6007,$04 Find the fill colour for the shelf in #R$6011.
  $600B,$04 Write the fill colour to #R$5F27.
  $600F,$01 Switch back to the normal registers.
  $6010,$01 Return.

b $6011 Pantry Fill Colours
@ $6011 label=PantryFillColours
D $6011 One attribute per shelf number (#N$00 is not used). The colours match
. the colours used to draw the ingredients.
B $6011,$01 #COLOUR(#PEEK(#PC)).
L $6011,$01,$06

c $6017 Draw Pantry
@ $6017 label=DrawPantry
D $6017 Draws the pantry down the right hand side of the screen, and the mixing
. bowl and pillars along the bottom. The scenery is built from the tiles at
. #R$7B4A, which are printed as if they were a font.
.
. The pantry has five shelves, each with a drawer. The drawer for the current
. level's ingredient is drawn highlighted, and has the colour of the
. ingredient inside it. The level number is printed in the bottom right
. corner.
N $6017 #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$6428,stop=$6457,sp=$5F00)
. #SIM(start=$5FB7,stop=$5FDE,sp=$5F00)
. #SIM(start=$6017,stop=$60A3,sp=$5F00)
. #SCR$02(pantry) } UDGTABLE# #POPS
N $6017 The pantry is constructed like it is a font.
  $6017,$04 Stash the address of the character set (#SKOOLKID$5C36(CHARS)) on
. the stack.
  $601B,$06 Use the pantry tiles as the character set by writing #R$7B4A to
. #SKOOLKID$5C36(CHARS).
N $6021 Make a mask which has a single bit set for the shelf that is
. highlighted. Shelf #N$05 is at the top and shelf #N$01 is at the bottom, so
. the mask is #N$20 shifted right by the level (modulo #N$08).
  $6021,$03 Fetch the level of the active player.
  $6024,$02,b$01 Keep only bits 0-2 (the level within the set of five).
  $6026,$01 Use the level as the counter for moving the highlight down.
  $6027,$02 Start with the mask for the top shelf.
  $6029,$02 Jump to #R$602F if the top shelf is highlighted.
@ $602B label=DrawPantry_Shift_Loop
  $602B,$02 Move the highlight down by one shelf.
  $602D,$02 Decrease the level counter by one and loop back to #R$602B until the
. highlight is on the shelf for this level.
@ $602F label=DrawPantry_SetMask
  $602F,$03 Write the mask of the highlighted shelf to #R$5F2A.
N $6032 Print the sign at the top of the pantry; it is in two rows.
  $6032,$03 Point #REGde at #R$613B.
  $6035,$03 Set the position of the top row of the sign (#N($10D0, $04, $04)).
  $6038,$03 Print the top row of the sign using #R$7488.
  $603B,$01 Switch back to the normal registers.
  $603C,$01 Point #REGde at the bottom row of the "PANTRY" sign.
  $603D,$03 Set the position of the bottom row of the sign
. (#N($18D0, $04, $04)).
  $6040,$03 Print the bottom row of the sign using #R$7488.
  $6043,$01 Switch back to the normal registers.
N $6044 Draw the tiles for each of the five shelves, from the top.
  $6044,$03 Set the position of the top shelf (#N($20D0, $04, $04)).
  $6047,$01 Point #REGde at the tiles for the shelves.
  $6048,$02 Set the shelf counter to #N$05, which is also the number of the top
. shelf.
@ $604A label=DrawPantry_Shelves_Loop
  $604A,$03 Draw a shelf using #R$60BD.
  $604D,$02 Decrease the shelf counter by one and loop back to #R$604A until all
. five shelves have been drawn.
N $604F Print the base of the pantry.
  $604F,$03 Point #REGde at #R$616D.
  $6052,$03 Set the position of the base of the pantry (#N($98D0, $04, $04)).
  $6055,$03 Print the base of the pantry using #R$7488.
N $6058 Colour each of the five shelves, from the top.
  $6058,$03 Point #REGde at #R$6174.
  $605B,$03 Set the position of the top shelf (#N($20D0, $04, $04)).
  $605E,$02 Set the shelf counter to #N$05, which is also the number of the top
. shelf.
@ $6060 label=DrawPantry_Colours_Loop
  $6060,$03 Set the fill colour for the shelf using #R$6002.
  $6063,$03 Colour the shelf using #R$60FD.
  $6066,$02 Decrease the shelf counter by one and loop back to #R$6060 until all
. five shelves have been coloured.
N $6068 Draw the mixing bowl and pillars along the bottom of the screen; this
. is #N$20 tiles wide and #N$04 tiles tall.
  $6068,$03 Set the position of the mixing bowl and pillars
. (#N($A000, $04, $04)).
  $606B,$03 Point #REGde at #R$6198.
  $606E,$02 Set the number of rows to #N$04.
  $6070,$02 Set the width to #N$20 tiles.
  $6072,$03 Print the mixing bowl and pillars using #R$60E2.
N $6075 Colour the mixing bowl and pillars.
  $6075,$03 Point #REGde at #R$6218.
  $6078,$03 Set the position of the mixing bowl and pillars
. (#N($A000, $04, $04)).
  $607B,$02 Set the number of rows to #N$04.
  $607D,$03 Colour the mixing bowl and pillars using #R$60A4.
  $6080,$01 Restore the address of the original character set from the stack.
  $6081,$03 Write it back to #SKOOLKID$5C36(CHARS).
N $6084 Print the number of ingredients which are needed inside the bowl.
  $6084,$02 Set the number of ingredients collected to #N$00.
  $6086,$03 Print the number of ingredients needed inside the bowl using
. #R$6C88.
N $6089 Print the level number, which is in BCD, in the bottom right corner of
. the screen.
  $6089,$04 Fetch the level number of the active player and keep a copy of the
. level number in #REGc.
  $608D,$04 Shift the tens digit into the low four bits.
  $6091,$02,b$01 Keep only the tens digit.
  $6093,$02 Convert the digit to an ASCII character.
  $6095,$03 Set the screen address of the first digit of the level number.
  $6098,$03 Print the tens digit using #R$7468.
  $609B,$01 Fetch the level number again.
  $609C,$02,b$01 Keep only the units digit.
  $609E,$02 Convert the digit to an ASCII character.
  $60A0,$03 Print the units digit using #R$7468.
  $60A3,$01 Return.

c $60A4 Write Attribute Block
@ $60A4 label=WriteAttributeBlock
D $60A4 Copies a block of colour attributes, which has the width in #R$5F28,
. into the attribute buffer.
R $60A4 C Number of rows
R $60A4 DE Address of the attributes
R $60A4 HL Position of the block
R $60A4 O:DE Address of the attributes after the block
  $60A4,$03 Fetch the width of the block.
  $60A7,$01 Set the column counter to the width.
  $60A8,$01 Stash the position of the row on the stack.
  $60A9,$01 Stash the width on the stack.
  $60AA,$03 Convert the position to an attribute address using #R$7534.
  $60AD,$01 Restore the column counter from the stack.
@ $60AE label=WriteAttributeBlock_Loop
  $60AE,$02 Copy an attribute from #REGde to the attribute buffer.
  $60B0,$01 Move onto the next column.
  $60B1,$01 Move onto the next attribute.
  $60B2,$02 Decrease the column counter by one and loop back to #R$60AE until
. the row has been copied.
  $60B4,$01 Restore the position of the row from the stack.
  $60B5,$01 Fetch the vertical position of the row.
  $60B6,$02 Add #N$08 to move down one row of tiles.
  $60B8,$01 Update the vertical position of the row.
  $60B9,$01 Decrease the row counter by one.
  $60BA,$02 Loop back to #R$60A4 until all of the rows have been done.
  $60BC,$01 Return.

c $60BD Draw Shelf
@ $60BD label=DrawShelf
D $60BD Draws the tiles for one shelf of the pantry. A shelf is #N$06 tiles wide
. and #N$03 tiles tall. There are two graphics for a shelf; the normal one and
. the highlighted one, which is used when the shelf's bit is set in #R$5F2A.
. The example below is for the top shelf (shelf #N$05). Its colours are
. set first, so that the tiles can be seen.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$6428,stop=$6457,sp=$5F00)
. #SIM(start=$5FED,stop=$5FF0,sp=$5F00)
. #SIM(start=$6017,stop=$604A,sp=$5F00)
. #SIM(start=$6002,stop=$0000,bc=$0500,sp=$5E00)
. #SIM(start=$60FD,stop=$0000,bc=$0500,de=$6174,hl=$20D0,sp=$5E00)
. #SCR$04,$1A,$04,$06,$03(draw-shelf-before)
. | #SIM(start=$60BD,stop=$0000,bc=$0500,de=$6149,hl=$20D0,sp=$5E00)
. #SCR$04,$1A,$04,$06,$03(draw-shelf-after) } UDGTABLE# #POPS
R $60BD B Shelf number
R $60BD DE Address of the normal graphic
R $60BD HL Position of the shelf
R $60BD O:HL Position of the shelf below
N $60BD Make the second byte of a BIT command from the shelf number.
  $60BD,$01 Stash the shelf number and #REGc on the stack.
  $60BE,$01 Stash the address of the normal graphic on the stack.
  $60BF,$01 Fetch the shelf number.
  $60C0,$03 Multiply by #N$08, so that the shelf number is in bits 3-5.
  $60C3,$02,b$01 Keep only bits 3-5.
  $60C5,$02,b$01 Set bits 0-2 and bit 6.
  $60C7,$03 Write #REGa to #R$60CD(#N$60CE).
  $60CA,$03 Fetch the mask of the highlighted shelf.
N $60CD #HTML(Self modifying code; the command which is here is made into
. <strong>BIT n,A</strong>, where n is the shelf number, by the instructions
. above. It is shown as <strong>RLC B</strong> as that is how it is stored.)
@ $60CD label=DrawShelf_TestBit
  $60CD,$02 Test the bit for the shelf in the mask.
  $60CF,$02 Jump to #R$60D8 if this shelf is not highlighted.
  $60D1,$07 Move #REGde on to the highlighted graphic, which is #N$12 bytes
. further on (preserving #REGhl).
@ $60D8 label=DrawShelf_Print
  $60D8,$02 Set the number of rows to #N$03.
  $60DA,$02 Set the width to #N$06 tiles.
  $60DC,$03 Print the tiles for the shelf using #R$60E2.
  $60DF,$01 Restore the address of the normal graphic from the stack.
  $60E0,$01 Restore the shelf number and #REGc from the stack.
  $60E1,$01 Return.

c $60E2 Print Tile Block
@ $60E2 label=PrintTileBlock
D $60E2 Prints a block of tiles (using the font set up by #R$6017).
R $60E2 A Width of the block in tiles
R $60E2 C Number of rows
R $60E2 DE Address of the tile numbers
R $60E2 HL Position of the block
R $60E2 O:DE Address of the tile numbers after the block
R $60E2 O:HL Position of the row below the block
  $60E2,$03 Record the width of the block at #R$5F28.
@ $60E5 label=PrintTileBlock_Row
  $60E5,$03 Fetch the width of the block.
  $60E8,$01 Set the column counter to the width.
  $60E9,$01 Stash the position of the row on the stack.
  $60EA,$03 Convert the position to a screen address using #R$76E3.
@ $60ED label=PrintTileBlock_Loop
  $60ED,$01 Fetch the tile number.
  $60EE,$03 Print the tile using #R$7468.
  $60F1,$01 Move onto the next tile.
  $60F2,$02 Decrease the column counter by one and loop back to #R$60ED until
. the row has been printed.
  $60F4,$01 Restore the position of the row from the stack.
  $60F5,$01 Fetch the vertical position of the row.
  $60F6,$02 Add #N$08 to move down one row of tiles.
  $60F8,$01 Update the vertical position of the row.
  $60F9,$01 Decrease the row counter by one.
  $60FA,$02 Loop back to #R$60E5 until all of the rows have been done.
  $60FC,$01 Return.

c $60FD Colour Shelf
@ $60FD label=ColourShelf
D $60FD Colours the cells of one shelf of the pantry. The cells which have an
. attribute of #N$00 are given the colour of the ingredient for the shelf,
. which was fetched by #R$6002. As in #R$60BD there are two sets of attributes;
. the second is used when the shelf's bit is set in #R$5F2A.
R $60FD B Shelf number
R $60FD DE Address of the attributes for the normal graphic
R $60FD HL Position of the shelf
R $60FD O:HL Position of the shelf below
N $60FD Make the second byte of a BIT command from the shelf number.
  $60FD,$01 Stash the shelf number and #REGc on the stack.
  $60FE,$01 Stash the address of the normal attributes on the stack.
  $60FF,$01 Fetch the shelf number.
  $6100,$03 Multiply by #N$08, so that the shelf number is in bits 3-5.
  $6103,$02,b$01 Keep only bits 3-5.
  $6105,$02,b$01 Set bits 0-2 and bit 6.
  $6107,$03 Write #REGa to #R$610D(#N$610E).
  $610A,$03 Fetch the mask of the highlighted shelf.
N $610D #HTML(Self modifying code; the command which is here is made into
. <strong>BIT n,A</strong>, where n is the shelf number, by the instructions
. above. It is stored as <strong>BIT 0,A</strong>.)
@ $610D label=ColourShelf_TestBit
  $610D,$04 Jump to #R$6118 if this shelf is not highlighted.
  $6111,$07 Move #REGde on to the highlighted attributes, which are #N$12
. bytes further on (preserving #REGhl).
@ $6118 label=ColourShelf_Rows
  $6118,$02 Set the number of rows to #N$03.
@ $611A label=ColourShelf_Row
  $611A,$02 Set the column counter to #N$06 (the width of the shelf).
  $611C,$01 Stash the position of the row on the stack.
  $611D,$01 Stash the counters on the stack.
  $611E,$03 Convert the position to an attribute address using #R$7534.
  $6121,$01 Restore the counters from the stack.
@ $6122 label=ColourShelf_Loop
  $6122,$01 Fetch the attribute.
  $6123,$01 Does the attribute need the colour of the ingredient (is it zero)?
  $6124,$03 Call #R$6137 if it is, to get the colour of the ingredient.
  $6127,$01 Write the attribute to the attribute buffer.
  $6128,$01 Move onto the next attribute.
  $6129,$01 Move onto the next column.
  $612A,$02 Decrease the column counter by one and loop back to #R$6122 until
. the row has been coloured.
  $612C,$01 Restore the position of the row from the stack.
  $612D,$01 Fetch the vertical position of the row.
  $612E,$02 Add #N$08 to move down one row of tiles.
  $6130,$01 Update the vertical position of the row.
  $6131,$01 Decrease the row counter by one.
  $6132,$02 Loop back to #R$611A until all of the rows have been done.
  $6134,$01 Restore the address of the normal attributes from the stack.
  $6135,$01 Restore the shelf number and #REGc from the stack.
  $6136,$01 Return.

c $6137 Fetch Shelf Colour
@ $6137 label=FetchShelfColour
D $6137 Fetches the colour of the ingredient for the shelf which is being drawn.
R $6137 O:A Colour attribute
  $6137,$03 Fetch the colour of the ingredient for the shelf.
  $613A,$01 Return.

b $613B Pantry Graphic
@ $613B label=CupboardData
D $613B The tiles and colour attributes which #R$6017 uses to draw the pantry.
. The tile numbers are for the font at #R$7B4A. The strings are printed by
. #R$7488, so they start with an attribute and the last tile has bit 7 set.
N $613B The top row of the "PANTRY" sign.
  $613B,$01 Attribute = #COLOUR(#PEEK(#PC)).
  $613C,$06 Tile numbers.
N $6142 The bottom row of the "PANTRY" sign.
  $6142,$01 Attribute = #COLOUR(#PEEK(#PC)).
  $6143,$06 Tile numbers.
N $6149 The tiles for a shelf, which is six tiles wide and three tiles tall.
. This is the normal graphic.
  $6149,$12,$06
N $615B The tiles for the highlighted shelf.
  $615B,$12,$06
N $616D The base of the pantry.
@ $616D label=PantryBase
  $616D,$01 Attribute = #COLOUR(#PEEK(#PC)).
  $616E,$06 Tile numbers.
N $6174 The attributes for the normal shelf. An attribute of #N$00 is replaced
. by the colour of the ingredient for the shelf.
@ $6174 label=PantryAttributes
  $6174,$12,$06
N $6186 The attributes for the highlighted shelf.
  $6186,$12,$06
N $6198 The tiles for the mixing bowl and pillars along the bottom of the
. screen, which are #N$20 tiles wide and #N$04 tiles tall.
@ $6198 label=BottomStrip_Tiles
  $6198,$80,$20
N $6218 The attributes for the mixing bowl and pillars.
@ $6218 label=BottomStrip_Attributes
  $6218,$80,$20

c $6298 Game Initialisation
@ $6298 label=GameInitialisation
D $6298 Blanks the high score and the scores for both players, and works out
. whether the sound should be muted. It then runs the game selection menu,
. which is shown until "0" is pressed to start the game.
.
. The game comes back to #R$62B5 to show the menu again when a game is over.
E $6298 View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #JETPAC$61EB }
. { #LUNARJETMAN$800A }
. { #PSSST$61CD }
. { #TRANZAM$5F07 }
. LIST#
N $6298 Blank the high score, the 1UP score and the 2UP score.
  $6298,$03 Point #REGhl at the high score.
  $629B,$03 Set the counter to #N$0B
. (the high score, the game options, the sound flag and both scores) and the
. byte to write to #N$00.
@ $629E label=GameInitialisation_Loop
  $629E,$01 Blank a byte.
  $629F,$01 Move onto the next byte.
  $62A0,$02 Decrease the byte counter by one and loop back to #R$629E until
. everything has been blanked.
N $62A2 This calculates a "checksum" of the #SKOOLKID$03B5(BEEPER) routine. The
. expected value at the end is #N$00, and if #R$5F0D does not contain #N$00
. then the game is muted.
  $62A2,$03 Point #REGhl at the start of the #SKOOLKID$03B5(BEEPER) routine.
  $62A5,$02 Set the counter to #N$43 (the number of bytes to add).
  $62A7,$01 Clear the checksum.
@ $62A8 label=Mute_Loop
  $62A8,$01 Add a byte of the routine to the checksum.
  $62A9,$01 Move onto the next byte.
  $62AA,$02 Decrease the byte counter by one and loop back to #R$62A8 until the
. whole routine has been added.
  $62AC,$02 Add #N$68, which makes the checksum zero in the original ROM.
  $62AE,$03 Store the result as the sound mute flag at #R$5F0D.
  $62B1,$04 Write #N$00 to #SKOOLKID$5C48(BORDCR).
N $62B5 This is where the game restarts after a game is over.
@ $62B5 label=Game_Restart
  $62B5,$01 Disable interrupts.
  $62B6,$03 Set the stack pointer to #R$5F00.
  $62B9,$03 Draw the window using #R$5FB7.
N $62BC This is the game selection loop. It draws the menu, reads the keys
. which change the options and then updates the flashing of the menu.
@ $62BC label=GameSelect_Loop
  $62BC,$03 Print the game selection menu using #R$6332.
  $62BF,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $62C5,$01 Flip the bits, so that a pressed key is a set bit.
  $62C6,$01 Keep the pressed keys in #REGe.
  $62C7,$03 Fetch the game options.
N $62CA Handle 1UP selection.
  $62CA,$04 Jump to #R$62D0 if key "1" has not been pressed ("1 PLAYER GAME").
  $62CE,$02 Select a one player game by resetting bit 0.
N $62D0 Handle 2UP selection.
@ $62D0 label=GameSelect_CheckP2
  $62D0,$04 Jump to #R$62D6 if key "2" has not been pressed ("2 PLAYER GAME").
  $62D4,$02 Set bit 0, which selects a two player game.
N $62D6 Handle Keyboard selection.
@ $62D6 label=GameSelect_CheckKeyboard
  $62D6,$04 Jump to #R$62DC if key "3" has not been pressed ("KEYBOARD").
  $62DA,$02,b$01 Keep only bits 0, 3-7, which selects the keyboard.
N $62DC Handle Kempston Joystick selection.
@ $62DC label=GameSelect_CheckKempston
  $62DC,$04 Jump to #R$62E4 if key "4" has not been pressed ("KEMPSTON
. JOYSTICK").
  $62E0,$02,b$01 Keep only bits 0, 3-7.
  $62E2,$02,b$01 Set bit 1, which selects the Kempston joystick.
N $62E4 Handle Cursor Joystick selection.
@ $62E4 label=GameSelect_CheckCursor
  $62E4,$04 Jump to #R$62EC if key "5" has not been pressed ("CURSOR JOYSTICK").
  $62E8,$02,b$01 Keep only bits 0, 3-7.
  $62EA,$02,b$01 Set bit 2, which selects the cursor joystick.
@ $62EC label=GameSelect_CheckStart
  $62EC,$03 Update the game options at #R$5F0C.
N $62EF "0" for "Start Game" is on a different port.
  $62EF,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $62F5,$01 Flip the bits, so that a pressed key is a set bit.
N $62F6 Handle starting a new game.
  $62F6,$05 Jump to #R$6428 if key "0" has been pressed ("START GAME").
N $62FB Handle flashing each selection. The first line of the menu is the
. title, so the attributes for the options start at #R$635E(#N$635F).
  $62FB,$03 Point #REGhl at #R$635F.
  $62FE,$04 Fetch the game options and keep a copy of the options in #REGc.
  $6302,$04 Jump to #R$631F if a two player game is selected.
  $6306,$03 Flash the "1 PLAYER GAME" line, and stop the "2 PLAYER GAME" line
. flashing, using #R$6324.
@ $6309 label=MenuAttributeHandler
  $6309,$02 Set the control line counter to #N$03
. (keyboard, Kempston joystick and cursor joystick).
  $630B,$01 Fetch the game options.
  $630C,$01 Shift the control selection into bits 0-1.
@ $630D label=MenuAttributeHandler_Loop
  $630D,$02,b$01 Keep only bits 0-1 (the selected control).
  $630F,$02 Jump to #R$631A if this line is the selected control.
  $6311,$03 Stop this control line flashing using #R$6327.
@ $6314 label=MenuAttributeHandler_Next
  $6314,$01 Move on to the next control.
  $6315,$02 Decrease the control line counter by one and loop back to #R$630D
. until all three lines have been done.
  $6317,$03 Jump back to #R$62BC to print the menu again.
N $631A Flash the line of the selected control.
@ $631A label=MenuAttributeFlashControl
  $631A,$03 Flash the selected control line using #R$632E.
  $631D,$02 Jump back to #R$6314.
N $631F A two player game is selected, so flash that line instead of the one
. player line.
@ $631F label=MenuAttributeFlashTwoPlayer
  $631F,$03 Flash the "2 PLAYER GAME" line, and stop the "1 PLAYER GAME" line
. flashing, using #R$632B.
  $6322,$02 Jump back to #R$6309.
N $6324 Set FLASH on the first menu line, and clear it on the second.
@ $6324 label=MenuAttributeSetUnset
  $6324,$02 Set the FLASH attribute for the menu attribute.
  $6326,$01 Move onto the next menu attribute.
@ $6327 label=MenuAttributeUnSetFirst
N $6327 Clear FLASH on a menu line.
  $6327,$02 Unset the FLASH attribute for the menu attribute.
  $6329,$01 Move onto the next menu attribute.
  $632A,$01 Return.
N $632B Clear FLASH on the first menu line, and set it on the second.
@ $632B label=MenuAttributeUnsetSet
  $632B,$02 Unset the FLASH attribute for the menu attribute.
  $632D,$01 Move onto the next menu attribute.
@ $632E label=MenuAttributeSetFirst
N $632E Set FLASH on a menu line.
  $632E,$02 Set the FLASH attribute for the menu attribute.
  $6330,$01 Move onto the next menu attribute.
  $6331,$01 Return.

c $6332 Game Selection Menu
@ $6332 label=GameMenu
D $6332 Prints the seven lines of the game selection menu, and then the
. copyright message at the bottom of the screen. Each line of the menu has an
. attribute (from #R$635E), a vertical position (from #R$6365) and some text
. (from #R$636C), and all of them are printed starting at column #N$07.
. #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$62B5,stop=$62BC,sp=$5F00)
. #SIM(start=$62BC,stop=$62BF,sp=$5F00)
. #SCR$02(game-menu) } UDGTABLE# #POPS
E $6332 View the equivalent code in;
. #LIST
. { #ATICATAC$7CAF }
. { #JETPAC$6260 }
. { #LUNARJETMAN$80D1 }
. { #PSSST$6250 }
. { #SABREWULF$B473 }
. { #TRANZAM$5F6C }
. { #UNDERWURLDE$90E4 }
. LIST#
N $6332 The attributes are fetched using #REGde, and the positions and the text
. use #REGhl' and #REGde'.
  $6332,$03 Point #REGde at the table of menu line attributes.
  $6335,$01 Switch to the shadow registers.
  $6336,$03 Point #REGhl' at #R$6365.
  $6339,$03 Point #REGde' at #R$636C.
N $633C There are seven lines of text.
  $633C,$02 Set the menu line counter to #N$07.
@ $633E label=GameMenu_Loop
  $633E,$01 Switch back to the normal registers.
  $633F,$04 Copy the attribute of this menu line to #R$5F24.
  $6343,$01 Move onto the attribute for the next menu line.
  $6344,$01 Switch to the shadow registers.
  $6345,$01 Stash the menu line counter on the stack.
  $6346,$01 Fetch the vertical position of this menu line.
  $6347,$01 Move onto the position for the next menu line.
  $6348,$01 Stash the position pointer on the stack.
  $6349,$03 Set the position of this menu line; the vertical position from the
. table and the horizontal position of #N$38.
  $634C,$03 Print the menu line using #R$63E0.
  $634F,$01 Switch to the shadow registers.
  $6350,$02 Restore the position pointer and the menu line counter from the
. stack.
  $6352,$01 Move onto the text of the next menu line.
  $6353,$02 Decrease the menu line counter by one and loop back to #R$633E until
. all seven lines have been printed.
N $6355 Print the copyright message at the bottom of the screen.
  $6355,$03 Set the position of the copyright message (#N($B800, $04, $04)).
  $6358,$03 Point #REGde at #R$5F8E.
  $635B,$03 Print the copyright message using #R$7488.

b $635E Game Select Attribute Table
@ $635E label=GameSelection_Attributes
@ $635F label=GameSelection_Attributes_Options
D $635E One attribute byte per menu line. The routines that flash the
. selected line set or clear FLASH in the byte for the line being
. updated. The first byte belongs to the title, so the flashing code
. starts at #R$635E(#N$635F).
E $635E View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #JETPAC$628D }
. { #LUNARJETMAN$810E }
. { #PSSST$627C }
. { #TRANZAM$5FA7 }
. { #UNDERWURLDE$9119 }
. LIST#
  $635E,$07,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | Game Selection }
. { #N$02 | 1 Player Game }
. { #N$03 | 2 Player Game }
. { #N$04 | Keyboard }
. { #N$05 | Kempston Joystick }
. { #N$06 | Cursor Joystick }
. { #N$07 | Start Game }
. TABLE#

b $6365 Game Select Y Position Table
@ $6365 label=GameSelection_Position
D $6365 The vertical position of each menu line, in pixels. Dividing it by
. #N$08 gives the row of the screen.
E $6365 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF1 }
. { #JETPAC$6293 }
. { #LUNARJETMAN$8115 }
. { #PSSST$6282 }
. { #TRANZAM$5FAC }
. { #UNDERWURLDE$911F }
. LIST#
  $6365,$07,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | Game Selection }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | 1 Player Game }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | 2 Player Game }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | Keyboard }
. { #N$05 | #EVAL(#PEEK(#PC+$04) / $08) | Kempston Joystick }
. { #N$06 | #EVAL(#PEEK(#PC+$05) / $08) | Cursor Joystick }
. { #N$07 | #EVAL(#PEEK(#PC+$06) / $08) | Start Game }
. TABLE#

t $636C Messaging: Game Selection Screen Text
@ $636C label=GameSelection_Text
D $636C The text for each line of the menu. The last character of each line has
. bit 7 set to show that it is the end of the string.
E $636C View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #JETPAC$6299 }
. { #LUNARJETMAN$811C }
. { #PSSST$6288 }
. { #SABREWULF$B4B0 }
. { #TRANZAM$5FB1 }
. { #UNDERWURLDE$9125 }
. LIST#
  $636C,$0E,$0D:$01 "GAME SELECTION".
  $637A,$11,$10:$01 "1   1 PLAYER GAME".
  $638B,$11,$10:$01 "2   2 PLAYER GAME".
  $639C,$0C,$0B:$01 "3   KEYBOARD".
  $63A8,$15,$14:$01 "4   KEMPSTON JOYSTICK".
  $63BD,$15,$14:$01 "5   CURSOR   JOYSTICK".
  $63D2,$0E,$0D:$01 "0   START GAME".

c $63E0 Write Menu Line
@ $63E0 label=MenuWriteText
D $63E0 Prints one line of the game selection menu. This works in the same way
. as #R$7488, except that the text is pointed to by #REGde' and the screen
. position is in #REGhl', and the attribute is not part of the string, it is
. taken from #R$5F24.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$62B5,stop=$62BC,sp=$5F00)
. #POKES$5F24,$47
. #SCR$02,$06,$06,$14,$03(menu-line-before)
. | #SIM(start=$63E0,stop=$0000,hl=$3838,de=$637A,sp=$5E00)
. #SCR$02,$06,$06,$14,$03(menu-line-after) } UDGTABLE# #POPS
E $63E0 View the equivalent code in;
. #LIST
. { #ATICATAC$7D8A }
. { #JETPAC$62FF }
. { #LUNARJETMAN$81AB }
. { #PSSST$62E7 }
. { #SABREWULF$B52D }
. { #TRANZAM$5F97 }
. { #UNDERWURLDE$91B0 }
. LIST#
R $63E0 DE' Address of the text
R $63E0 HL' Position of the line
  $63E0,$01 Stash the position on the stack.
  $63E1,$03 Convert the position to a screen address using #R$76E3.
  $63E4,$03 Fetch the menu attribute byte from #R$5F24.
  $63E7,$01 Switch to the shadow #REGaf register.
  $63E8,$01 Switch to the normal registers.
  $63E9,$01 Restore the position from the stack.
  $63EA,$03 Convert the position to an attribute address using #R$7534.
  $63ED,$03 Jump to #R$7494 to print the text.

c $63F0 Initialise New Game
@ $63F0 label=NewGame
D $63F0 Sets up the data for both players at the start of a game. Both players
. start with level #N$00 and four lives. The data for the player who is not
. active is then changed; the level is set to #N$FF, so that when it is the
. turn of that player #R$6C3C (which adds one to the level) starts them on
. level #N$00, and the lives are made #N$05 for a two player game or #N$00 for
. a one player game.
E $63F0 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$A84C }
. { #TRANZAM$6391 }
. LIST#
N $63F0 Set the level and the lives for both players.
  $63F0,$02 Set the player counter to #N$02 (one for each player).
@ $63F2 label=NewGame_Loop
  $63F2,$01 Stash the player counter on the stack.
  $63F3,$04 Write #N$00 to #R$5F2D.
N $63F7 Set both players starting lives.
  $63F7,$05 Write #N$04 to #R$5F2E.
  $63FC,$03 Call #R$6416 to swap the player data between 1UP and 2UP players.
  $63FF,$01 Restore the player counter from the stack.
  $6400,$02 Decrease the player counter by one and loop back to #R$63F2 until
. both players have been set up.
N $6402 Note this is +#N$01 to #R$63F7 as you "spend a life", and 1UP goes first.
  $6402,$05 Write #N$05 to #R$5F32.
N $6407 The level for the other player starts at #N$FF.
  $6407,$05 Write #N$FF to #R$5F31.
N $640C Handle a one player game; the other player has no lives.
  $640C,$03 Fetch the game options.
  $640F,$02,b$01 Keep only bit 0 (set for a two player game).
  $6411,$01 Return if this is a two player game.
  $6412,$03 Write #N$00 to the lives of the inactive player (#R$5F32).
  $6415,$01 Return.

c $6416 1UP/ 2UP Swapper
@ $6416 label=ChangePlayer
D $6416 Swaps the data for the active player (#R$5F2D) with the data for the
. other player (#R$5F31).
E $6416 View the equivalent code in;
. #LIST
. { #JETPAC$616A }
. { #LUNARJETMAN$A880 }
. { #PSSST$613B }
. { #SABREWULF$B235 }
. LIST#
N $6416 This routine "swaps" the data between #REGde and #REGhl.
  $6416,$03 Point #REGhl at the data for the active player.
  $6419,$03 Point #REGde at #R$5F31.
  $641C,$02 Set the counter to #N$04
. (the level, lives, ingredients needed and level number).
N $641E This looks complicated but it's just grabbing the data from #REGde,
. grabbing the data from #REGhl, and writing the others data to each one.
@ $641E label=ChangePlayer_States
  $641E,$01 Fetch a byte of the data for the inactive player.
  $641F,$01 Fetch the matching byte of the data for the active player.
  $6420,$01 Give the active player the byte from the inactive player.
  $6421,$02 Give the inactive player the byte from the active player.
  $6423,$02 Move onto the next byte of data for both players.
  $6425,$02 Decrease the counter by one and loop back to #R$641E until all four
. bytes have been swapped.
  $6427,$01 Return.

c $6428 Start Game
@ $6428 label=StartGame
D $6428 Starts a new game when "0" is pressed on the game selection menu. The
. screen is blanked, the opening tune is played (unless the sound is muted)
. and the data for the game is reset. Then the first level is set up, and the
. game carries on in the main loop.
E $6428 Continue on to #R$6457.
E $6428 View the equivalent code in;
. #LIST
. { #ATICATAC$7D9A }
. { #JETPAC$6333 }
. { #LUNARJETMAN$81BB }
. { #PSSST$632D }
. { #TRANZAM$5FEF }
. LIST#
  $6428,$03 Blank the attribute buffer using #R$74E2.
  $642B,$03 Blank the screen buffer using #R$74D4.
N $642E Play the opening tune, unless the sound is muted.
  $642E,$06 Jump to #R$643A if #R$5F0D is not zero.
  $6434,$03 Point #REGde at #R$65C8.
  $6437,$03 Play the tune using #R$6568.
@ $643A label=SkipMusic
N $643A Reset both of the level numbers which are shown on the screen.
  $643A,$07 Write #N$00 to; #LIST { #R$5F30 } { #R$5F34 } LIST#
N $6441 Blank everything from the 1UP score to the end of the last actor slot,
. which resets the scores, the sprite data and all of the actors.
  $6441,$0D Write #N$00 to every byte from #R$5F0E to #N$5F84 (#N$0077 bytes).
  $644E,$03 Set up the data for both players using #R$63F0.
  $6451,$03 Reset the self modifying code using #R$7186.
  $6454,$03 Set up the first level using #R$6C58.

c $6457 Run Main Loop
@ $6457 label=MainLoop_NewPass
D $6457 The main loop of the game. Each pass through the loop runs the handler
. for one actor. The handler is chosen by the actor ID, using the table at
. #R$6486. The address of #R$71A3 is put on the stack first, so that when
. the handler returns, the game moves on to the next actor.
.
. A pass is started at #R$6457 with the first of the six actors which start at
. #R$5F55. Whenever the frame counter has changed, #R$7160 runs an extra pass
. over the first four actors (which are Charlie and the sound effect actor).
R $6457 IX Actor
  $6457,$03 Set the stack pointer to #R$5F00.
  $645A,$01 Enable interrupts.
  $645B,$04 Start with the first of the six spawn slots (#R$5F55).
  $645F,$04 Write #N$00 to #R$5F1B to reset the current nasties.
N $6463 Run the frame update if the frame counter has changed.
@ $6463 label=MainLoop
  $6463,$07 Compare #SKOOLKID$5C78(FRAMES) and #R$5F22.
N $646A If interrupts are enabled, then #R$7160 will be called and DI executed.
  $646A,$04 If they are not equal call #R$7160.
N $646E Make the handler return to #R$71A3, then find the handler.
  $646E,$03 Point #REGhl at #R$71A3 (the routine for the next actor).
  $6471,$01 Stash it on the stack, so that the handler returns to it.
  $6472,$03 Point #REGhl at #R$6486.
  $6475,$03 Fetch the actor ID.
@ $6478 label=MainLoop_Dispatch
  $6478,$01 Double the ID, as there are two bytes for each handler.
  $6479,$02,b$01 Keep only bits 1-6 (bits 0-5 of the ID, doubled).
  $647B,$03 Use the result as an offset into the table of handlers.
  $647E,$01 Find the entry for the handler of this actor.
  $647F,$01 Fetch the low byte of the handler address.
  $6480,$01 Move onto the high byte.
  $6481,$01 Fetch the high byte of the handler address.
  $6482,$01 Put the low byte in #REGl, so that #REGhl is the address of the
. handler.
  $6483,$03 Jump to #SKOOLKID$5CB0(NMIADD) which should just jump to the address in #REGhl.

w $6486 Actor Handler Table
@ $6486 label=ActorHandlers
D $6486 The code which handles an actor is chosen by bits 0-5 of its ID (byte
. #N$00 of the actor). The ID is also used to choose the sprite (see #R$7702).
. #TABLE(default,centre,centre,centre)
. { =h IDs | =h Actor | =h Handler }
. { #N$00, #N$0C, #N$17 | Empty slot (#N$0C is hatless Charlie) | #R$7152 }
. { #N$01-#N$02 | Charlie | #R$7048 }
. { #N$03 | Flour shot | #R$6F78 }
. { #N$04-#N$05 | Custard | #R$7281 }
. { #N$06-#N$07 | Level introduction | #R$6D89 }
. { #N$08-#N$09 | Sugar | #R$6CB7 }
. { #N$0A-#N$0B | Level timer | #R$6C31 }
. { #N$0D | Charlie's hat | #R$6AA0 }
. { #N$0E | Falling Charlie | #R$6B8B }
. { #N$0F | Cleared actor | #R$6B18 }
. { #N$10-#N$11 | Chocolate | #R$69D4 }
. { #N$12-#N$13 | Cheese | #R$6930 }
. { #N$14-#N$15 | Peel | #R$669B }
. { #N$16 | Sound effect (notes) | #R$689A }
. { #N$18 | End of life | #R$6BAF }
. { #N$19 | Sound effect (sweep) | #R$6888 }
. { #N$1A-#N$1D | Pike and tin can | #R$6765 }
. { #N$1E-#N$23 | Tack, washer and bolt | #R$6996 }
. { #N$24-#N$25 | Monster | #R$6607 }
. { #N$26-#N$27 | Explosion | #R$65E8 }
. { #N$28-#N$2A | Batter | #R$654C }
. { #N$2B | Batter | #R$655C }
. { #N$2C-#N$30 | Cake | #R$64F4 }
. TABLE#
W $6486,$62,$02

c $64E8 Start Cake
@ $64E8 label=StartCake
D $64E8 Copies the templates for the five pieces of the cake into the actor
. slots which start at #R$5F55. This happens when the fifth level of a set of
. five has been completed (see #R$6C3C).
E $64E8 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$A3DD }
. LIST#
  $64E8,$03 Point #REGhl at the templates for the five pieces of the cake.
  $64EB,$03 Point #REGde at #R$5F55.
  $64EE,$03 Set the number of bytes to copy to #N$0028
. (five actors of eight bytes).
  $64F1,$02 Copy the templates to the actor slots.
  $64F3,$01 Return.

c $64F4 Handle Cake
@ $64F4 label=HandleCake
D $64F4 The handler for the five pieces of the cake (IDs #N$2C to #N$30). Each
. piece rises until its vertical co-ordinate is #N$A0. Then the music is played
. (unless the sound is off), and the next level is set up.
R $64F4 IX Actor
  $64F4,$03 Record the position of the sprite using #R$76D0.
  $64F7,$04 Increase the number of actors in play (#R$5F1B) by one.
  $64FB,$03 Fetch the vertical co-ordinate of the piece of cake.
  $64FE,$04 Jump to #R$650B if the piece has risen as far as it goes.
  $6502,$03 Raise the piece of cake by decreasing the vertical co-ordinate by
. one.
  $6505,$03 Erase the sprite and draw it in its new position using #R$75CC.
  $6508,$03 Jump to #R$74EE to colour the sprite.
N $650B All of the pieces of the cake stop at the same height, so the first one
. to be handled does the following; it plays the tune for a level finishing and
. then goes on to the next level.
@ $650B label=HandleCake_Finished
  $650B,$03 Fetch the sound mute flag.
  $650E,$01 Is the sound switched off?
  $650F,$02 Jump to #R$651D if it is.
  $6511,$03 Point #REGde at #R$65DA.
  $6514,$03 Play the tune using #R$6568.
N $6517 Remove all of the actors, and then set up the next level.
@ $6517 label=HandleCake_NextLevel
  $6517,$03 Remove all of the actors using #R$713D.
  $651A,$03 Jump to #R$6C58.
N $651D If the sound is switched off, pause instead of playing the tune.
@ $651D label=HandleCake_Pause
  $651D,$02 Set the number of times to count down for the pause to #N$08.
  $651F,$03 Pause using #R$6BF3.
  $6522,$02 Jump to #R$6517.

b $6524 Cake Template
@ $6524 label=CakeTemplate
D $6524 The five pieces of the cake. Each is an actor, with the ID, horizontal
. co-ordinate, vertical co-ordinate and colour (bright yellow), followed by four
. bytes which the handler does not use.
B $6524,$28,$08

c $654C Handle Batter
@ $654C label=HandleBatter
D $654C The handler for the first three frames of the batter (IDs #N$28 to
. #N$2A). Each time it is called, the actor moves on to the next frame.
R $654C IX Actor
  $654C,$03 Record the position of the sprite using #R$76D0.
  $654F,$04 Increase the number of actors in play (#R$5F1B) by one.
  $6553,$03 Increase the actor ID by one, which chooses the next frame.
  $6556,$03 Erase the sprite and draw the next frame using #R$75CC.
  $6559,$03 Jump to #R$74EE to colour the sprite.

c $655C Handle Final Batter
@ $655C label=HandleBatter_Final
D $655C The handler for the last frame of the batter (ID #N$2B), which removes
. the batter from the screen and then the actor.
R $655C IX Actor
  $655C,$03 Erase the sprite using #R$7617.
  $655F,$04 Increase the number of actors in play (#R$5F1B) by one.
  $6563,$04 Write #N$00 to the actor ID.
  $6567,$01 Return.

c $6568 Play Music
@ $6568 label=PlayMusic
D $6568 Plays a tune using the #SKOOLKID$03B5(BEEPER) routine. Each byte of
. the tune is a note number, in bits 0-4, which chooses the pitch and length of
. the note from the table at #R$6594. The tune ends at the byte #N$FF.
E $6568 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B2CF }
. { #SABREWULF$BD6E }
. LIST#
R $6568 DE Address of the tune
  $6568,$01 Fetch the next note of the tune.
  $6569,$03 Return if the end of the tune (#N$FF) has been reached.
  $656C,$02,b$01 Keep only bits 0-4 (the note number).
  $656E,$01 Decrease the note number by one (note numbers start from #N$01).
  $656F,$02 Double the note number, as there are two bytes for each note.
  $6571,$03 Use the result as an offset into the table of notes.
  $6574,$04 Find the entry for the note in #R$6594.
  $6578,$01 Stash the pointer to the tune on the stack.
  $6579,$01 Fetch the pitch of the note.
  $657A,$01 Increment #REGhl by one.
  $657B,$01 Fetch the length of the note into #REGe.
  $657C,$02 Set the high byte of the length to #N$00.
  $657E,$01 Put the pitch in #REGl.
  $657F,$02 Set the high byte of the pitch to #N$00.
  $6581,$08 Multiply the pitch by #N$04, for the #SKOOLKID$03B5(BEEPER) routine.
  $6589,$02 Stash #REGix on the stack.
  $658B,$03 Play the note using #SKOOLKID$03B5(BEEPER).
  $658E,$02 Restore #REGix from the stack.
  $6590,$01 Restore the pointer to the tune from the stack.
  $6591,$01 Move on to the next note of the tune.
  $6592,$02 Jump back to #R$6568 to play the next note (the tune only ends when
. the terminator is reached).

b $6594 Music Note Table
@ $6594 label=MusicNotes
D $6594 The pitch and the length of each note which can be played by #R$6568.
. The first byte is multiplied by #N$04 to give the pitch for the ROM routine,
. and the second byte is the length.
E $6594 View the equivalent code in;
. #LIST
. { #SABREWULF$BDD2 }
. LIST#
.
. Notes #N$01 to #N$0D have a full length, and notes #N$0E to #N$1A are the
. same pitches but are about half the length.
N $6594 Notes #N$01 to #N$0D.
B $6594,$1A,$02
N $65AE Notes #N$0E to #N$1A.
B $65AE,$1A,$02

b $65C8 Music Data
@ $65C8 label=MusicData
D $65C8 Three tunes. Each is a list of note numbers, ended by #N$FF. The first
. is played when a game starts, the second when Charlie loses a life and the
. third when a level is finished.
N $65C8 The tune which is played when a game starts.
. #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune)))
B $65C8,$09
N $65D1 The tune which is played when Charlie loses a life.
. #HTML(#AUDIO0(lose-life-tune.wav)(#INCLUDE(LoseLifeTune)))
@ $65D1 label=MusicData_LoseLife
B $65D1,$09
N $65DA The tune which is played when a level is finished.
. #HTML(#AUDIO0(level-finished-tune.wav)(#INCLUDE(LevelFinishedTune)))
@ $65DA label=MusicData_LevelFinished
B $65DA,$0E

c $65E8 Handle Explosion
@ $65E8 label=HandleExplosion
D $65E8 The handler for the explosion (IDs #N$26 and #N$27) which is shown when
. a flour shot ends. The sprite is chosen by the lowest bit of a counter in byte
. #N$07 of the actor, which starts at #N$03 and counts down to zero.
.
. The sprite is drawn each time without the previous one being erased. As the
. sprites are drawn using exclusive OR, drawing the two frames in turn leaves
. the screen blank after the fourth time, so the explosion is removed when the
. counter reaches zero.
R $65E8 IX Actor
  $65E8,$03 Fetch the explosion counter.
  $65EB,$02,b$01 Keep only bit 0
. (which of the two frames of the explosion to show).
  $65ED,$02 Add #N$26 to get the ID of the frame.
  $65EF,$03 Set the actor ID to the ID of the frame.
  $65F2,$03 Draw the explosion using #R$7617.
  $65F5,$03 Colour the sprite using #R$74EE.
  $65F8,$03 Fetch the explosion counter.
  $65FB,$01 Has the explosion finished (is the counter zero)?
  $65FC,$02 Jump to #R$6602 if it has.
  $65FE,$03 Decrease the explosion counter by one.
  $6601,$01 Return.
@ $6602 label=HandleExplosion_Remove
  $6602,$04 Remove the explosion by writing #N$00 to the actor ID.
  $6606,$01 Return.

c $6607 Handle Monster
@ $6607 label=HandleMonster
D $6607 The handler for the monster (IDs #N$24 and #N$25), which pops up out of
. one of the dustbins at the bottom of the screen (it is created by #R$67E2).
. Byte #N$06 of the actor is its state, which chooses which code at #R$6639 is
. run using the table at #R$6631. If a flour shot hits the monster it is
. coloured white (see #R$7317), the points are added to the score, and it goes
. straight to the state in which it drops back into the dustbin.
R $6607 IX Actor
  $6607,$03 Point #REGhl at the number of actors in play (#R$5F1B).
  $660A,$01 Increase it by one.
  $660B,$03 Record the position of the sprite using #R$76D0.
  $660E,$03 Fetch the colour of the monster.
  $6611,$04 Jump to #R$6628 if it has been hit already.
  $6615,$03 Test whether a flour shot has hit the actor using #R$7317.
  $6618,$06 Jump to #R$6628 if the monster has not been hit by the flour shot
. (is bit 7 of the actor ID set).
  $661E,$04 Write #N$02 to the state of the monster, so that it drops back into
. the dustbin.
  $6622,$03 Set the points for hitting the monster (#N$0125 in BCD).
  $6625,$03 Add the points to the score using #R$7415.
@ $6628 label=HandleMonster_State
  $6628,$03 Point #REGhl at the table of monster states.
  $662B,$03 Fetch the state of the monster.
  $662E,$03 Jump to #R$6478 to run the code for the state.

w $6631 Monster State Table
@ $6631 label=MonsterStates
D $6631 The code for each state of the monster.
. #TABLE(default,centre,centre)
. { =h State | =h Handler }
. { #N$00 | #R$6639 }
. { #N$01 | #R$6653 }
. { #N$02 | #R$6669 }
. { #N$03 | #R$6681 }
. TABLE#
W $6631,$08,$02

c $6639 Handle Monster Rising
@ $6639 label=HandleMonster_Rising
D $6639 State #N$00 of the monster; it moves up one pixel at a time until it
. has come out of the dustbin.
R $6639 IX Actor
  $6639,$03 Fetch the vertical co-ordinate.
  $663C,$01 Raise the monster by one pixel.
  $663D,$04 Jump to #R$664A if the monster has come out of the dustbin.
@ $6641 label=HandleMonster_Move
  $6641,$03 Update the vertical co-ordinate.
@ $6644 label=HandleMonster_Draw
  $6644,$03 Erase the sprite and draw it in its new position using #R$75CC.
  $6647,$03 Jump to #R$74EE to colour the sprite.
N $664A Start the pause while the monster is out of the dustbin.
@ $664A label=HandleMonster_StartWait
  $664A,$04 Write #N$10 to byte #N$07 of the actor (the timer).
@ $664E label=HandleMonster_NextState
  $664E,$03 Increase the actor state by one.
  $6651,$02 Jump to #R$6644.

c $6653 Handle Monster Waiting
@ $6653 label=HandleMonster_Waiting
D $6653 State #N$01 of the monster; it stays where it is for a short time,
. changing between its two frames every #N$08 frames.
R $6653 IX Actor
N $6653 See #POKE(infinite_lives,Infinite Lives).
  $6653,$03 Decrease the timer in byte #N$07 of the actor by one.
  $6656,$02 Jump to #R$664E if the timer is zero.
  $6658,$03 Fetch the frame counter.
  $665B,$02,b$01 Keep only bits 0-2.
  $665D,$02 Jump to #R$6644 unless the frame counter is a multiple of #N$08.
  $665F,$03 Fetch the actor ID.
  $6662,$02,b$01 Flip bit 0, which chooses the other frame of the monster.
  $6664,$03 Update the actor ID with the other frame of the monster.
  $6667,$02 Jump to #R$6644.

c $6669 Handle Monster Falling
@ $6669 label=HandleMonster_Falling
D $6669 State #N$02 of the monster; it moves down four pixels at a time until
. it is back inside the dustbin. A random delay (#N$01 to #N$0F frames) is then
. set, and the monster moves on to the next state.
R $6669 IX Actor
  $6669,$03 Fetch the vertical co-ordinate.
  $666C,$02 Lower the monster by #N$04 pixels.
  $666E,$04 Jump to #R$6674 if the monster is back inside the dustbin.
  $6672,$02 Jump to #R$6641 to move the monster.
@ $6674 label=HandleMonster_StartDelay
  $6674,$02 Fetch a random number.
  $6676,$02,b$01 Keep only bits 0-3.
  $6678,$02,b$01 Set bit 0, so that the timer is never zero.
  $667A,$03 Write the random number to the timer (byte #N$07 of the actor).
  $667D,$03 Increase the actor state by one.
  $6680,$01 Return.

c $6681 Handle Monster Throwing
@ $6681 label=HandleMonster_Throwing
D $6681 State #N$03 of the monster; it waits for the timer to run out and then
. turns into something else. If the monster has been hit by a flour shot (and
. so is white) it is removed. Otherwise it becomes the pike (ID #N$1A) or the
. tin can (ID #N$1C), depending on bit 1 of the number of ingredients needed,
. and a sound is started.
R $6681 IX Actor
  $6681,$03 Decrease the timer in byte #N$07 of the actor by one.
  $6684,$01 Return if the timer is not zero.
  $6685,$03 Fetch the colour of the monster.
  $6688,$02 Is the monster white (#COLOUR$47), which means it has been hit?
  $668A,$02 Set the actor ID to #N$00 (the actor will be removed).
  $668C,$02 Jump to #R$6695 if the monster has been hit.
  $668E,$03 Fetch the number of ingredients needed.
  $6691,$02,b$01 Keep only bit 1.
  $6693,$02 Add #N$1A, to choose between the pike and the tin can.
@ $6695 label=HandleMonster_SetID
  $6695,$03 Set the actor ID to the new nasty.
  $6698,$03 Jump to #R$6915.

c $669B Handle Peel
@ $669B label=HandlePeel
D $669B The handler for the orange peel (IDs #N$14 and #N$15). It wanders about
. in a wavy path. Byte #N$06 of the actor holds the direction (bit 0 is set for
. right, bit 1 is set for down) and which byte of each pair in the table at
. #R$6745 is used for which direction (bit 2). Byte #N$07 is a counter, which
. chooses the speeds to use from the table, and changes the sprite frame.
.
. While the peel is entering from the right of the screen (a horizontal
. co-ordinate of #N$C4 or more) it can't hit Charlie or be hit.
R $669B IX Actor
  $669B,$03 Record the position of the sprite using #R$76D0.
  $669E,$04 Increase #R$5F1B by one.
  $66A2,$03 Fetch the horizontal co-ordinate.
  $66A5,$04 Jump to #R$66ED if the peel is still entering from the right.
  $66A9,$03 Test whether the peel has hit Charlie using #R$6A46.
  $66AC,$01 Has the peel hit Charlie (is #REGe now zero)?
  $66AD,$03 Jump to #R$6A73 if Charlie has been hit.
  $66B0,$03 Test whether a flour shot has hit the peel using #R$7317.
  $66B3,$07 Jump to #R$730D if the peel has been hit.
N $66BA Every #N$10 frames pick a new random direction.
  $66BA,$03 Fetch the direction counter.
  $66BD,$01 Increase the direction counter by one.
  $66BE,$02,b$01 Keep only bits 0-3.
  $66C0,$03 Update the direction counter.
  $66C3,$02 Jump to #R$66CC if the counter is not zero.
  $66C5,$02 Fetch a random number.
  $66C7,$02,b$01 Keep only bits 0-2.
  $66C9,$03 Write the random number to the direction of the peel
. (byte #N$06 of the actor).
N $66CC Move vertically.
@ $66CC label=HandlePeel_Vertical
  $66CC,$03 Find the speeds for the counter using #R$6735.
  $66CF,$04 Set the colour to #N$43.
  $66D3,$02 Jump to #R$66D6 if bit 2 of the actor state is set.
  $66D5,$01 Use the second byte of the pair.
@ $66D6 label=HandlePeel_VerticalSpeed
  $66D6,$01 Fetch the speed.
  $66D7,$06 Jump to #R$66DF if the peel is moving down.
  $66DD,$02 Make the speed negative.
@ $66DF label=HandlePeel_VerticalMove
  $66DF,$03 Add the speed to the vertical co-ordinate.
  $66E2,$04 Jump to #R$6719 if the peel has reached the bottom.
  $66E6,$04 Jump to #R$6723 if the peel has reached the top.
  $66EA,$03 Update the vertical co-ordinate.
N $66ED Move horizontally.
@ $66ED label=HandlePeel_Horizontal
  $66ED,$03 Find the speeds for the counter using #R$6735.
  $66F0,$02 Jump to #R$66F3 if bit 2 of the actor state is not set.
  $66F2,$01 Use the second byte of the pair.
@ $66F3 label=HandlePeel_HorizontalSpeed
  $66F3,$01 Fetch the speed.
  $66F4,$06 Jump to #R$66FC if the peel is moving right.
  $66FA,$02 Make the speed negative.
@ $66FC label=HandlePeel_HorizontalMove
  $66FC,$03 Add the speed to the horizontal co-ordinate.
  $66FF,$04 Jump to #R$6729 if the peel has reached the left edge.
  $6703,$04 Jump to #R$672F if the peel has reached the right edge.
@ $6707 label=HandlePeel_Animate
  $6707,$03 Update the horizontal co-ordinate.
  $670A,$03 Fetch the direction counter.
  $670D,$01 Shift the counter right by one.
  $670E,$02,b$01 Keep only bit 0.
  $6710,$03 Flip the bit 0 of the actor ID, when bit 1 of the counter is set.
  $6713,$03 Update the actor ID.
  $6716,$03 Jump to #R$72D4 to move and colour the sprite.
N $6719 The peel has reached the bottom, so move it up.
@ $6719 label=HandlePeel_Bottom
  $6719,$04 Write #N$A0 to the vertical co-ordinate.
  $671D,$04 Reset bit 1 of the actor state.
  $6721,$02 Jump to #R$66ED.
N $6723 The peel has reached the top, so move it down.
@ $6723 label=HandlePeel_Top
  $6723,$04 Set bit 1 of the actor state.
  $6727,$02 Jump to #R$66ED.
N $6729 The peel has reached the left edge, so move it right.
@ $6729 label=HandlePeel_LeftEdge
  $6729,$04 Set bit 0 of the actor state.
  $672D,$02 Jump to #R$6707.
N $672F The peel has reached the right edge, so move it left.
@ $672F label=HandlePeel_RightEdge
  $672F,$04 Reset bit 0 of the actor state.
  $6733,$02 Jump to #R$6707.

c $6735 Find Wander Speeds
@ $6735 label=FindWanderSpeeds
D $6735 Finds the pair of speeds in the table at #R$6745 which are used for the
. current value of the counter in byte #N$07 of the actor.
R $6735 IX Actor
R $6735 O:HL Address of the pair of speeds
R $6735 O:F The Z flag is set when bit 2 of the actor state is not set
  $6735,$03 Fetch the counter (byte #N$07 of the actor).
  $6738,$02 Multiply by #N$02, as there are two bytes for each speed.
  $673A,$02 Set the high byte of the offset to #N$00.
  $673C,$03 Point #REGhl at #R$6745.
  $673F,$01 Find the pair of speeds for the counter.
  $6740,$04 Test bit 2 of the actor state.
  $6744,$01 Return.

b $6745 Wander Speeds
@ $6745 label=WanderSpeeds
D $6745 Pairs of speeds, in pixels, for the peel; one pair for each value of the
. counter (#N$00 to #N$0F). Bit 2 of the actor state chooses which of the two
. speeds is used for the vertical movement, and which is used for the
. horizontal movement.
B $6745,$20,$02

c $6765 Handle Pike And Tin Can
@ $6765 label=HandlePikeAndTinCan
D $6765 The handler for the pike and the tin can (IDs #N$1A to #N$1D), which are
. thrown out of a dustbin by the monster (see #R$6681). They fly in an arc;
. byte #N$04 of the actor is the horizontal speed, and byte #N$05 is the
. vertical speed, which is increased by one every #N$08 frames to make them
. fall. They bounce off the sides and the top of the play area, and are removed
. when they drop below the bottom of the screen. When they reach the floor they
. are handled in the same way as an actor which has been hit (see #R$6E25).
R $6765 IX Actor
  $6765,$03 Record the position of the sprite using #R$76D0.
  $6768,$04 Increase the number of actors in play (#R$5F1B) by one.
  $676C,$03 Test whether the actor has hit Charlie using #R$6A46.
  $676F,$01 Has the actor hit Charlie (is #REGe now zero)?
  $6770,$03 Jump to #R$6A73 if Charlie has been hit.
  $6773,$03 Test whether a flour shot has hit the actor using #R$7317.
  $6776,$07 Jump to #R$730D if the actor has been hit.
  $677D,$02 Set the colour to #N$44.
  $677F,$03 Update the colour of the actor.
  $6782,$03 Fetch the vertical co-ordinate.
  $6785,$05 Jump to #R$730D if the actor has reached the floor.
N $678A Every #N$08 frames, increase the vertical speed.
  $678A,$03 Fetch the frame counter.
  $678D,$02,b$01 Keep only bits 0-2.
  $678F,$02 Jump to #R$6794 if the frame counter is not a multiple of #N$08.
  $6791,$03 Increase the vertical speed by one.
N $6794 Move vertically.
@ $6794 label=HandlePikeAndTinCan_Vertical
  $6794,$03 Fetch the vertical speed.
  $6797,$03 Add the vertical co-ordinate to get the new position.
  $679A,$04 Jump to #R$67CB if the actor has dropped below the bottom of the
. screen.
  $679E,$03 Update the vertical co-ordinate.
  $67A1,$02 Compare with #N$24 (the top of the play area).
  $67A3,$03 Call #R$67D9 if the actor has reached the top of the play area.
N $67A6 Move horizontally.
  $67A6,$03 Fetch the horizontal speed.
  $67A9,$01 Is the actor moving left (is the speed negative)?
  $67AA,$03 Jump to #R$67BE if the actor is moving left.
  $67AD,$03 Add the horizontal co-ordinate to get the new position.
  $67B0,$03 Update the horizontal co-ordinate.
  $67B3,$02 Compare with #N$BC (the right edge of the play area).
  $67B5,$03 Call #R$67D0 if the actor has reached the right edge.
@ $67B8 label=HandlePikeAndTinCan_Draw
  $67B8,$03 Erase the sprite and draw it in its new position using #R$75CC.
  $67BB,$03 Jump to #R$74EE to colour the sprite.
@ $67BE label=HandlePikeAndTinCan_Left
  $67BE,$03 Add the horizontal co-ordinate to get the new position.
  $67C1,$03 Update the horizontal co-ordinate.
  $67C4,$02 Compare with #N$04 (the left edge of the play area).
  $67C6,$03 Call #R$67D0 if the actor has reached the left edge.
  $67C9,$02 Jump to #R$67B8.
N $67CB The actor has dropped below the bottom of the screen.
@ $67CB label=HandlePikeAndTinCan_Remove
  $67CB,$04 Write #N$00 to the actor ID.
  $67CF,$01 Return.

c $67D0 Reverse Horizontal Speed
@ $67D0 label=ReverseHorizontalSpeed
D $67D0 Makes the actor move the other way horizontally.
R $67D0 IX Actor
  $67D0,$03 Fetch the horizontal speed.
  $67D3,$02 Reverse the direction by negating the speed.
  $67D5,$03 Update the horizontal speed.
  $67D8,$01 Return.

c $67D9 Reverse Vertical Speed
@ $67D9 label=ReverseVerticalSpeed
D $67D9 Makes the actor move the other way vertically.
R $67D9 IX Actor
  $67D9,$03 Fetch the vertical speed.
  $67DC,$02 Reverse the direction by negating the speed.
  $67DE,$03 Update the vertical speed.
  $67E1,$01 Return.

c $67E2 Create Monster
@ $67E2 label=CreateMonster
D $67E2 Creates the monster in the last of the six actor slots (#N$5F7D), unless
. that slot is already in use. The ID is #N$24 or #N$25, depending on bit 0 of
. the number of ingredients that are needed. The monster is put at the bottom
. of one of the four dustbins, which is chosen at random from the table at
. #R$6821, and is coloured green. Bytes #N$04 and #N$05 are the speeds which
. are used when the monster throws something (see #R$6681); they are made from
. the frame counter and a random number. A warble sound is then started.
  $67E2,$03 Point #REGde at the monster slot (#R$5F7D).
  $67E5,$01 Fetch the actor ID.
  $67E6,$01 Is the slot in use?
  $67E7,$01 Return if it is.
  $67E8,$03 Fetch the number of ingredients needed.
  $67EB,$02,b$01 Keep only bit 0 (which frame the monster starts on).
  $67ED,$02 Add #N$24 to get the ID of the monster.
  $67EF,$01 Set the actor ID.
  $67F0,$01 Move on to the horizontal co-ordinate.
  $67F1,$02 Fetch a random number.
  $67F3,$02,b$01 Keep only bits 0-1 (to choose one of the four dustbins).
  $67F5,$01 Use the result as an offset into the dustbin positions.
  $67F6,$02 Set the high byte of the offset to #N$00.
  $67F8,$03 Point #REGhl at #R$6821.
  $67FB,$01 Find the dustbin.
  $67FC,$01 Fetch the horizontal co-ordinate of the dustbin.
  $67FD,$01 Set the horizontal co-ordinate of the monster.
  $67FE,$01 Move on to the vertical co-ordinate.
  $67FF,$02 Fetch the vertical co-ordinate of the bottom of the dustbin.
  $6801,$01 Set the vertical co-ordinate of the monster.
  $6802,$01 Move on to the colour.
  $6803,$02 Fetch the colour of the monster (#COLOUR$44).
  $6805,$01 Set the colour of the monster.
  $6806,$01 Move on to the horizontal speed.
  $6807,$03 Fetch the frame counter.
  $680A,$02,b$01 Keep only bits 0-1.
  $680C,$02 Negate the result, so that the monster is thrown to the left.
  $680E,$01 Set the horizontal speed.
  $680F,$01 Move on to the vertical speed.
  $6810,$01 Keep the horizontal speed in #REGb.
  $6811,$02 Fetch a random number.
  $6813,$01 Add the horizontal speed.
  $6814,$02,b$01 Keep only bits 0-1.
  $6816,$02 Add #N$04, so that the monster is always thrown upwards quickly.
  $6818,$02 Negate the result, so that it is an upward speed.
  $681A,$01 Set the vertical speed.
  $681B,$01 Move on to the state.
  $681C,$01 Set the state to #N$00 (rising out of the dustbin).
  $681D,$01 Set the state of the monster.
  $681E,$03 Jump to #R$68FA.

b $6821 Dustbin Positions
@ $6821 label=DustbinPositions
D $6821 The horizontal co-ordinate of each of the four dustbins at the bottom of
. the screen.
B $6821,$04,$01

c $6825 Play Chirp
@ $6825 label=PlayChirp
D $6825 Plays a short chirp of seven square wave cycles. The period of each
. cycle depends on a counter, and on the value of #R$5F1D.
. #HTML(#AUDIO0(chirp.wav)(#INCLUDE(Chirp)))
  $6825,$02 Set the cycle counter to #N$07.
@ $6827 label=PlayChirp_Loop
  $6827,$01 Fetch the cycle counter.
  $6828,$01 Decimal adjust the counter, to vary the period of the cycle.
  $6829,$02,b$01 Flip bits 4-7.
  $682B,$01 Rotate #REGa left.
  $682C,$01 Put the result in #REGd (the period).
  $682D,$03 Fetch the frame counter.
  $6830,$03 Divide by #N$08 (rotating the bits).
  $6833,$02,b$01 Keep only bits 5-6.
  $6835,$01 Combine with the period.
  $6836,$01 Update the period.
  $6837,$03 Play a cycle using #R$68B1.
  $683A,$01 Decrease the cycle counter by one.
  $683B,$02 Loop back to #R$6827 until the cycle counter is zero.
  $683D,$01 Return.

c $683E Play Rising Tone
@ $683E label=PlayRisingTone
D $683E Plays a tone which rises in pitch. The more actors there are in play
. (#R$5F1B), the longer the tone. The audio is for #N$04 actors in play.
. #HTML(#AUDIO0(rising-tone.wav)(#INCLUDE(RisingTone)))
  $683E,$03 Fetch the number of actors in play.
  $6841,$03 Multiply by #N$08 (rotating the bits).
  $6844,$02,b$01 Set bits 0-2.
  $6846,$01 Set the cycle counter; the more actors in play, the longer the tone.
@ $6847 label=PlayRisingTone_Loop
  $6847,$01 Fetch the cycle counter.
  $6848,$02,b$01 Flip bit 6.
  $684A,$01 Use the result as the period.
  $684B,$03 Play a cycle using #R$68B1.
  $684E,$01 Decrease the cycle counter by one.
  $684F,$01 Return if all of the cycles have been played.
  $6850,$01 Decrease the cycle counter by one.
  $6851,$01 Return if all of the cycles have been played.
  $6852,$02 Jump back to #R$6847 to play the next cycle.

c $6854 Play Level Tone
@ $6854 label=LevelStartJingle
D $6854 Plays eight cycles of a square wave. The period of the wave is taken
. from the table at #R$686A, using byte #N$06 of the actor as the index, which
. is then increased by one ready for the next call. This is used by the actor
. for the level introduction parade (see #R$6D87). The audio is three calls,
. which are eight frames apart.
. #HTML(#AUDIO0(level-tone.wav)(#INCLUDE(LevelTone)))
R $6854 IX Actor
  $6854,$03 Fetch the index (byte #N$06 of the actor).
  $6857,$03 Increase the index by one, ready for the next call.
  $685A,$06 Find the period in the table at #R$686A using the index.
  $6860,$01 Fetch the period of the wave.
  $6861,$02 Set the cycle counter to #N$08.
@ $6863 label=LevelStartJingle_Loop
  $6863,$03 Play a cycle using #R$68B1.
  $6866,$01 Decrease the cycle counter by one.
  $6867,$02 Loop back to #R$6863 until the cycle counter is zero.
  $6869,$01 Return.

b $686A Level Tone Periods
@ $686A label=LevelTonePeriods
D $686A The period of the wave for each call of #R$6854. Every entry is #N$80,
. so the tone does not change in pitch.
B $686A,$18,$01

c $6882 Play Game Start Tone
@ $6882 label=GameStartJingle
D $6882 Plays a beep of #N$40 cycles.
. #HTML(#AUDIO0(game-start-beep.wav)(#INCLUDE(GameStartBeep)))
  $6882,$02 Set the period to #N$30.
  $6884,$02 Set the cycle counter to #N$40.
  $6886,$02 Jump to #R$6863.

c $6888 Handle Rising Sweep
@ $6888 label=Handler_RisingSweep
D $6888 The handler for sound effect actors with the ID #N$19. Each time it is
. called it plays a number of cycles (#REGix+#N$02), and then makes the period
. (#REGix+#N$03) shorter, which raises the pitch. The actor is removed when the
. period reaches zero.
R $6888 IX Sound actor
  $6888,$03 Decrease the period by one, which raises the pitch.
  $688B,$02 Jump to #R$68BF if the period is zero.
  $688D,$03 Fetch the period.
  $6890,$03 Fetch the number of cycles.
@ $6893 label=Handler_PlayCycles
  $6893,$03 Play a cycle using #R$68B1.
  $6896,$01 Decrease the cycle counter by one.
  $6897,$02 Loop back to #R$6893 until all of the cycles have been played.
  $6899,$01 Return.

c $689A Handle Notes
@ $689A label=Handler_Notes
D $689A The handler for sound effect actors with the ID #N$16. Each time it is
. called it plays the next note from a table of periods. The table address is
. held in the actor (#REGix+#N$02 and #REGix+#N$03), and the notes are played
. from the end of the table towards the start. The number of cycles in each
. note is held in #REGix+#N$04. The actor is removed after the first entry of
. the table.
R $689A IX Sound actor
  $689A,$03 Decrease the note counter by one.
  $689D,$02 Jump to #R$68BF if there are no more notes to play.
  $689F,$03 Fetch the note counter.
  $68A2,$02 Set the high byte of the offset to #N$00.
  $68A4,$03 Fetch the low byte of the address of the table of periods.
  $68A7,$03 Fetch the high byte of the address of the table of periods.
  $68AA,$01 Find the note in the table using the note counter.
  $68AB,$01 Fetch the period of the note.
  $68AC,$03 Fetch the number of cycles in each note.
  $68AF,$02 Jump to #R$6893.

c $68B1 Play Square Wave
@ $68B1 label=PlaySquareWave
D $68B1 Plays one cycle of a square wave; the speaker is switched on for a
. period of time and then switched off for the same amount of time.
E $68B1 View the equivalent code in;
. #LIST
. { #JETPAC$680D }
. { #LUNARJETMAN$B8DA }
. { #PSSST$64AA }
. LIST#
R $68B1 D Duration of wave
  $68B1,$07 Play square wave sound.
@ $68B6 label=PlaySquareWave_Loop
  $68B8,$06 Play "silence".
@ $68BC label=Silence_Loop
  $68BE,$01 Return.

c $68BF Remove Actor
@ $68BF label=RemoveActor
D $68BF Removes an actor by setting its ID to zero, which frees the slot.
R $68BF IX Actor
  $68BF,$04 Write #N$00 to the actor ID.
  $68C3,$01 Return.

c $68C4 Start Rising Sweep
@ $68C4 label=StartRisingSweep
D $68C4 The sound effects are played by an actor which lives in the slot at
. #R$5F4D. This copies the template for the effect into the slot, and the
. handler then plays it a bit at a time. Eight bytes are always copied, so the
. bytes of a template which are beyond the ones used are really the code which
. follows it.
. #HTML(#AUDIO0(rising-sweep.wav)(#INCLUDE(RisingSweep)))
  $68C4,$03 Point #REGhl at the template for the rising sweep.
@ $68C7 label=StartSoundEffect
  $68C7,$03 Point #REGde at the sound effect actor (#R$5F4D).
  $68CA,$03 Set the number of bytes to copy to #N$0008.
  $68CD,$02 Copy the template to the sound effect actor.
  $68CF,$01 Return.

b $68D0 Template: Rising Sweep
@ $68D0 label=Template_RisingSweep
D $68D0 Handled by #R$6888.
  $68D0,$01 Actor ID.
  $68D1,$01 Not used.
  $68D2,$01 Number of cycles.
  $68D3,$01 Period of the first cycle.

c $68D4 Start Falling Notes
@ $68D4 label=StartFallingNotes
D $68D4 #HTML(#AUDIO0(falling-notes.wav)(#INCLUDE(FallingNotes)))
  $68D4,$03 Point #REGhl at the template for the falling notes.
  $68D7,$02 Jump to #R$68C7.

b $68D9 Template: Falling Notes
@ $68D9 label=Template_FallingNotes
D $68D9 Handled by #R$689A.
  $68D9,$01 Actor ID.
  $68DA,$01 Note counter.
  $68DB,$02 Address of the table of periods.
  $68DD,$01 Number of cycles in each note.
@ $68DE label=Notes_FallingNotes
B $68DE,$09

c $68E7 Start Rising Notes
@ $68E7 label=StartRisingNotes
D $68E7 #HTML(#AUDIO0(rising-notes.wav)(#INCLUDE(RisingNotes)))
  $68E7,$03 Point #REGhl at the template for the rising notes.
  $68EA,$02 Jump to #R$68C7.

b $68EC Template: Rising Notes
@ $68EC label=Template_RisingNotes
D $68EC Handled by #R$689A.
  $68EC,$01 Actor ID.
  $68ED,$01 Note counter.
  $68EE,$02 Address of the table of periods.
  $68F0,$01 Number of cycles in each note.
@ $68F1 label=Notes_RisingNotes
B $68F1,$09

c $68FA Start Warble
@ $68FA label=StartWarble
D $68FA #HTML(#AUDIO0(warble.wav)(#INCLUDE(Warble)))
  $68FA,$03 Point #REGhl at the template for the warble.
  $68FD,$02 Jump to #R$68C7.

b $68FF Template: Warble
@ $68FF label=Template_Warble
D $68FF Handled by #R$689A.
  $68FF,$01 Actor ID.
  $6900,$01 Note counter.
  $6901,$02 Address of the table of periods.
  $6903,$01 Number of cycles in each note.
@ $6904 label=Notes_Warble
B $6904,$11

c $6915 Start Falling Slide
@ $6915 label=StartFallingSlide
D $6915 #HTML(#AUDIO0(falling-slide.wav)(#INCLUDE(FallingSlide)))
  $6915,$03 Point #REGhl at the template for the falling slide.
  $6918,$02 Jump to #R$68C7.

b $691A Template: Falling Slide
@ $691A label=Template_FallingSlide
D $691A Handled by #R$689A.
  $691A,$01 Actor ID.
  $691B,$01 Note counter.
  $691C,$02 Address of the table of periods.
  $691E,$01 Number of cycles in each note.
@ $691F label=Notes_FallingSlide
B $691F,$11

c $6930 Handle Cheese
@ $6930 label=HandleCheese
D $6930 The handler for the cheese (IDs #N$12 and #N$13), which bounces up and
. down the screen like a ball. Byte #N$05 of the actor is the vertical speed;
. it is increased by one every eight frames (up to a maximum of #N$08), and half
. of it is added to the vertical co-ordinate. When the cheese reaches the top
. of the play area its vertical speed is reversed, and when it reaches the
. bottom it is thrown back up with a random speed, and a random horizontal
. speed. The horizontal movement is done by #R$72B4.
.
. While the cheese is still entering from the right of the screen (a horizontal
. co-ordinate of #N$C4 or more) it only moves horizontally.
R $6930 IX Actor
  $6930,$03 Record the position of the sprite using #R$76D0.
  $6933,$03 Point #REGhl at #R$5F1B.
  $6936,$01 Increase the number of actors in play by one.
  $6937,$03 Fetch the horizontal co-ordinate.
  $693A,$04 Jump to #R$6977 if the cheese is still entering from the right.
  $693E,$03 Test whether the cheese has hit Charlie using #R$6A46.
  $6941,$01 Has Charlie been hit (is #REGe now zero)?
  $6942,$03 Jump to #R$6A73 if Charlie has been hit.
  $6945,$03 Test whether a flour shot has hit the cheese using #R$7317.
  $6948,$07 Jump to #R$730D if the cheese has been hit.
N $694F Every eight frames, increase the vertical speed (up to a maximum of
. #N$08).
  $694F,$03 Fetch the frame counter (byte #N$07 of the actor).
  $6952,$02,b$01 Keep only bits 0-2.
  $6954,$02 Jump to #R$6960 if the counter is not a multiple of #N$08.
  $6956,$03 Fetch the vertical speed.
  $6959,$04 Jump to #R$6960 if the vertical speed is already at the maximum.
  $695D,$03 Increase the vertical speed by one.
@ $6960 label=HandleCheese_Vertical
  $6960,$03 Fetch the vertical speed.
  $6963,$04 Set the actor colour to #N$46 (yellow).
  $6967,$02 Halve the vertical speed.
  $6969,$03 Add the vertical co-ordinate.
  $696C,$04 Jump to #R$697A if the cheese has reached the top.
  $6970,$04 Jump to #R$6988 if the cheese has reached the bottom.
  $6974,$03 Update the vertical co-ordinate.
@ $6977 label=HandleCheese_Horizontal
  $6977,$03 Move the actor horizontally using #R$72B4.
N $697A The cheese has reached the top, so reverse the vertical speed.
@ $697A label=HandleCheese_Top
  $697A,$04 Put the cheese at the top of the play area (#N$20).
  $697E,$03 Fetch the vertical speed.
  $6981,$02 Reverse the direction by negating the vertical speed.
@ $6983 label=HandleCheese_SetSpeed
  $6983,$03 Update the vertical speed.
  $6986,$02 Jump to #R$6977.
N $6988 The cheese has reached the bottom, so throw it back up.
@ $6988 label=HandleCheese_Bottom
  $6988,$04 Put the cheese on the floor (#N$A0).
  $698C,$03 Set random horizontal and vertical speeds using #R$6EAC.
  $698F,$02 Fetch a random number.
  $6991,$02,b$01 Keep only bits 0-2.
  $6993,$01 Invert #REGa, so it is in the range #N$F8 to #N$FF (-8 to -1).
  $6994,$02 Jump to #R$6983.

c $6996 Handle Tack, Washer And Bolt
@ $6996 label=HandleTackWasherBolt
D $6996 The handler for the tack, the washer and the bolt (IDs #N$1E to #N$23),
. which chase Charlie. Every #N$10 frames the actor works out which way Charlie
. is from it, and stores this in byte #N$06 of the actor (bit 0 is set when
. Charlie is below the actor, bit 1 is set when Charlie is to the right). The
. horizontal and vertical speeds are then changed by one every other frame
. towards that direction, up to a maximum speed of #N$02 in either direction.
R $6996 IX Actor
  $6996,$03 Record the position of the sprite using #R$76D0.
  $6999,$03 Point #REGhl at #R$5F1B.
  $699C,$01 Increase the number of actors in play by one.
  $699D,$03 Test whether the actor has hit Charlie using #R$6A46.
  $69A0,$01 Has Charlie been hit (is #REGe now zero)?
  $69A1,$03 Jump to #R$6A73 if Charlie has been hit.
  $69A4,$03 Test whether a flour shot has hit the actor using #R$7317.
  $69A7,$07 Jump to #R$730D if the actor has been hit.
  $69AE,$04 Set the actor colour to #N$45 (cyan).
  $69B2,$03 Fetch the frame counter (byte #N$07 of the actor).
  $69B5,$02,b$01 Keep only bits 0-3.
  $69B7,$02 Jump to #R$6A05 if the counter is not a multiple of #N$10.
N $69B9 Work out which direction Charlie is in.
  $69B9,$02 Set the direction to #N$00 (left and up).
  $69BB,$03 Point #REGhl at #R$5F36.
  $69BE,$03 Fetch the horizontal co-ordinate.
  $69C1,$01 Subtract Charlie's horizontal co-ordinate.
  $69C2,$02 Jump to #R$69C6 if the actor is to the right of Charlie.
  $69C4,$02 The actor is left of Charlie, so set the direction to #N$02 (right).
@ $69C6 label=HandleTackWasherBolt_Vertical
  $69C6,$01 Move on to Charlie's vertical co-ordinate.
  $69C7,$03 Fetch the vertical co-ordinate.
  $69CA,$01 Subtract Charlie's vertical co-ordinate.
  $69CB,$02 Jump to #R$69CF if the actor is below Charlie.
  $69CD,$02,b$01 The actor is above Charlie, so set bit 0 of the direction
. (down).
@ $69CF label=HandleTackWasherBolt_SetDirection
  $69CF,$03 Set the direction of the actor (byte #N$06 of the actor).
  $69D2,$02 Jump to #R$6A05.

c $69D4 Handle Chocolate
@ $69D4 label=HandleChocolate
D $69D4 The handler for the chocolate (IDs #N$10 and #N$11), which drifts about
. in random directions. Every #N$10 frames a new random direction is picked
. and stored in byte #N$06 of the actor (bit 0 is set for down, and bit 1 is
. set for right). The speeds are changed by one every other frame towards that
. direction, up to a maximum speed of #N$02 in either direction.
.
. While the chocolate is still entering from the right of the screen (a
. horizontal co-ordinate of #N$C4 or more) it is only moved.
R $69D4 IX Actor
  $69D4,$03 Record the position of the sprite using #R$76D0.
  $69D7,$03 Point #REGhl at #R$5F1B.
  $69DA,$01 Increase the number of actors in play by one.
  $69DB,$03 Fetch the horizontal co-ordinate.
  $69DE,$04 Jump to #R$6A2B if the chocolate is still entering from the right.
  $69E2,$03 Test whether the actor has hit Charlie using #R$6A46.
  $69E5,$01 Has Charlie been hit (is #REGe now zero)?
  $69E6,$03 Jump to #R$6A73 if Charlie has been hit.
  $69E9,$03 Test whether a flour shot has hit the actor using #R$7317.
  $69EC,$07 Jump to #R$730D if the actor has been hit.
  $69F3,$04 Set the actor colour to #N$42 (red).
  $69F7,$03 Fetch the frame counter (byte #N$07 of the actor).
  $69FA,$02,b$01 Keep only bits 0-3.
  $69FC,$02 Jump to #R$6A05 if the counter is not a multiple of #N$10.
  $69FE,$02 Fetch a random number.
  $6A00,$02,b$01 Keep only bits 0-1.
  $6A02,$03 Set a random direction (byte #N$06 of the actor).
c $6A05 Change Actor Speeds
@ $6A05 label=ChangeActorSpeeds
D $6A05 Changes the speeds of the actor by one towards the direction in byte
. #N$06 of the actor (bit 0 is set for down, and bit 1 is set for right), but
. only every other frame. The speeds are limited to #N$02 in either direction.
. The actor is then moved by #R$72A3.
R $6A05 IX Actor
  $6A05,$06 Jump to #R$6A2B if bit 0 of the frame counter is set.
  $6A0B,$06 Jump to #R$6A2E if the actor is not moving down.
  $6A11,$03 Fetch the vertical speed.
  $6A14,$04 Jump to #R$6A1B if it is already at the limit.
  $6A18,$03 Increase the vertical speed by one.
@ $6A1B label=ChangeActorSpeeds_Horizontal
  $6A1B,$06 Jump to #R$6A3A if the actor is not moving right.
  $6A21,$03 Fetch the horizontal speed.
  $6A24,$04 Jump to #R$6A2B if it is already at the limit.
  $6A28,$03 Increase the horizontal speed by one.
@ $6A2B label=ChangeActorSpeeds_Move
  $6A2B,$03 Move the actor using #R$72A3.
@ $6A2E label=ChangeActorSpeeds_Up
  $6A2E,$03 Fetch the vertical speed.
  $6A31,$04 Jump to #R$6A1B if it is already at the limit.
  $6A35,$03 Decrease the vertical speed by one.
  $6A38,$02 Jump to #R$6A1B.
@ $6A3A label=ChangeActorSpeeds_Left
  $6A3A,$03 Fetch the horizontal speed.
  $6A3D,$04 Jump to #R$6A2B if it is already at the limit.
  $6A41,$03 Decrease the horizontal speed by one.
  $6A44,$02 Jump to #R$6A2B.

c $6A46 Test Charlie Collision
@ $6A46 label=TestCharlieCollision
D $6A46 Tests whether the actor is within #N$0C pixels of Charlie, both
. horizontally and vertically. Charlie can only be hit while he has his hat on
. (his ID is #N$01 or #N$02). If he has been hit then the rising sweep sound is
. started.
R $6A46 IX Actor
R $6A46 O:E #N$01 if the actor has collided with Charlie, otherwise #N$00
N $6A46 See #POKE(immunity,Immunity).
  $6A46,$03 Point #REGhl at Charlie's actor ID.
  $6A49,$02 Assume that there is no collision (#REGe=#N$00).
  $6A4B,$01 Fetch Charlie's ID.
  $6A4C,$02,b$01 Keep only bits 0-5.
  $6A4E,$01 Is Charlie's ID #N$01?
  $6A4F,$02 Jump to #R$6A53 if Charlie's ID is #N$01.
  $6A51,$01 Is Charlie's ID #N$02?
  $6A52,$01 Return if Charlie's ID is not #N$02.
@ $6A53 label=TestCharlieCollision_Horizontal
  $6A53,$01 Move on to Charlie's horizontal co-ordinate.
  $6A54,$01 Fetch Charlie's horizontal co-ordinate.
  $6A55,$03 Subtract the horizontal co-ordinate of the actor.
  $6A58,$03 Jump to #R$6A5D if the result is positive.
  $6A5B,$02 Make the result positive.
@ $6A5D label=TestCharlieCollision_HorizontalDistance
  $6A5D,$02 Compare with #N$0C (the width of the collision area).
  $6A5F,$01 Return if the actor is too far away.
  $6A60,$01 Move on to Charlie's vertical co-ordinate.
  $6A61,$01 Fetch Charlie's vertical co-ordinate.
  $6A62,$03 Subtract the vertical co-ordinate of the actor.
  $6A65,$03 Jump to #R$6A6A if the result is positive.
  $6A68,$02 Make the result positive.
@ $6A6A label=TestCharlieCollision_VerticalDistance
  $6A6A,$02 Compare with #N$0C (the height of the collision area).
  $6A6C,$01 Return if the actor is too far away.
  $6A6D,$03 Start the rising sweep sound using #R$68C4.
  $6A70,$02 Flag that Charlie has been hit (#REGe=#N$01).
  $6A72,$01 Return.

c $6A73 Lose Hat
@ $6A73 label=LoseHat
D $6A73 Called when an actor has hit Charlie. Charlie is replaced with Charlie
. without his hat (ID #N$0C), and the hat (ID #N$0D) is put #N$10 pixels above
. him. Charlie's co-ordinates are saved in bytes #N$04 and #N$05 of the actor.
. The hat is then handled by #R$6AA0, and all of the other actors are cleared
. away by #R$6AFC.
  $6A73,$02 Save the pointer to the current actor on the stack.
  $6A75,$04 Point #REGix at #R$5F35.
  $6A79,$03 Erase Charlie using #R$7617.
  $6A7C,$04 Change Charlie's ID to #N$0C (Charlie without his hat).
  $6A80,$03 Draw Charlie without his hat using #R$7617.
  $6A83,$04 Change the ID to #N$0D (the hat).
  $6A87,$03 Fetch the horizontal co-ordinate.
  $6A8A,$03 Save Charlie's horizontal co-ordinate in byte #N$04 of the actor.
  $6A8D,$03 Fetch the vertical co-ordinate.
  $6A90,$03 Save Charlie's vertical co-ordinate in byte #N$05 of the actor.
  $6A93,$02 Subtract #N$10, to put the hat above Charlie's head.
  $6A95,$03 Update the vertical co-ordinate.
  $6A98,$03 Draw the hat using #R$7617.
  $6A9B,$02 Restore the pointer to the current actor from the stack.
  $6A9D,$03 Jump to #R$6AFC.

c $6AA0 Handle Hat
@ $6AA0 label=HandleHat
D $6AA0 The handler for Charlie's hat (ID #N$0D), which is in Charlie's actor
. slot. Charlie's co-ordinates were saved in bytes #N$04 and #N$05 of the
. actor by #R$6A73. Each pass the hat moves up two pixels, and Charlie is
. redrawn without his hat. When the hat reaches the top of the screen it is
. erased, and Charlie is replaced with falling Charlie (ID #N$0E), who is
. handled by #R$6B8B.
R $6AA0 IX Actor
  $6AA0,$03 Record the position of the sprite using #R$76D0.
  $6AA3,$03 Fetch the vertical co-ordinate.
  $6AA6,$02 Subtract #N$02 to move the hat up the screen.
  $6AA8,$02 Jump to #R$6ADF if the hat has reached the top of the screen.
  $6AAA,$03 Update the vertical co-ordinate.
  $6AAD,$03 Erase the sprite and draw it in its new position using #R$75CC.
  $6AB0,$03 Colour the sprite using #R$74EE.
N $6AB3 Redraw Charlie without his hat, and then put the position of the hat
. back.
  $6AB3,$03 Fetch the horizontal co-ordinate of the hat.
  $6AB6,$03 Fetch the vertical co-ordinate of the hat.
  $6AB9,$01 Stash the position of the hat on the stack.
  $6ABA,$03 Fetch Charlie's horizontal co-ordinate (byte #N$04 of the actor).
  $6ABD,$03 Update the horizontal co-ordinate.
  $6AC0,$03 Fetch Charlie's vertical co-ordinate (byte #N$05 of the actor).
  $6AC3,$03 Update the vertical co-ordinate.
  $6AC6,$04 Change the ID to #N$0C (Charlie without his hat).
  $6ACA,$03 Record the position of the sprite using #R$76D0.
  $6ACD,$03 Erase the sprite and draw it in its new position using #R$75CC.
  $6AD0,$03 Colour the sprite using #R$74EE.
  $6AD3,$01 Restore the position of the hat from the stack.
  $6AD4,$03 Put the hat back at its horizontal co-ordinate.
  $6AD7,$03 Put the hat back at its vertical co-ordinate.
  $6ADA,$04 Change the ID back to #N$0D (the hat).
  $6ADE,$01 Return.
N $6ADF The hat has reached the top of the screen, so erase it and replace
. Charlie with falling Charlie.
@ $6ADF label=HandleHat_Finished
  $6ADF,$03 Erase the hat using #R$7617.
  $6AE2,$03 Fetch Charlie's horizontal co-ordinate (byte #N$04 of the actor).
  $6AE5,$03 Update the horizontal co-ordinate.
  $6AE8,$03 Fetch Charlie's vertical co-ordinate (byte #N$05 of the actor).
  $6AEB,$03 Update the vertical co-ordinate.
  $6AEE,$04 Change the ID to #N$0C (Charlie without his hat).
  $6AF2,$03 Erase Charlie without his hat using #R$7617.
  $6AF5,$04 Change the ID to #N$0E (falling Charlie).
  $6AF9,$03 Draw falling Charlie using #R$7617.

c $6AFC Convert Actors
@ $6AFC label=ConvertActors
D $6AFC Changes every actor in the six slots from #R$5F55 into ID #N$0F, so
. they can be cleared away by #R$6B18. The original ID is kept in byte #N$04
. of the actor, and byte #N$05 is set to #N$01.
  $6AFC,$03 Point #REGhl at the first spawned actor.
  $6AFF,$03 Set the offset to byte #N$04 of an actor.
  $6B02,$02 Set the actor counter to #N$06.
@ $6B04 label=ConvertActors_Loop
  $6B04,$01 Fetch the actor ID.
  $6B05,$01 Is the slot empty?
  $6B06,$02 Jump to #R$6B13 if it is.
  $6B08,$01 Keep the actor ID in #REGc.
  $6B09,$02 Change the ID to #N$0F (the cleared actor).
  $6B0B,$01 Move on to byte #N$04 of the actor.
  $6B0C,$01 Write the original ID to byte #N$04 of the actor.
  $6B0D,$01 Move on to byte #N$05 of the actor.
  $6B0E,$02 Write #N$01 to byte #N$05 of the actor.
  $6B10,$01 Move back to byte #N$04 of the actor.
  $6B11,$02 Jump to #R$6B14.
@ $6B13 label=ConvertActors_Empty
  $6B13,$01 Move on to byte #N$04 of the actor.
@ $6B14 label=ConvertActors_Next
  $6B14,$01 Move on to the next actor.
  $6B15,$02 Decrease the actor counter by one and loop back to #R$6B04 until
. all six actors have been done.
  $6B17,$01 Return.

c $6B18 Handle Cleared Actor
@ $6B18 label=HandleClearedActor
D $6B18 The handler for an actor which has been cleared away (ID #N$0F) after
. Charlie has lost his hat (see #R$6AFC). The original ID of the actor is in
. byte #N$04, and is used to draw the actor; bit 0 of it is flipped every
. four frames. While byte #N$05 is not zero the actor moves sideways away from
. the middle of the screen four pixels at a time, until it reaches a side (and,
. if it is on the floor, it stops moving sideways at once). Then it drops four
. pixels at a time, and is removed when it reaches the bottom of the screen.
R $6B18 IX Actor
  $6B18,$03 Point #REGhl at the number of actors in play.
  $6B1B,$01 Increase the number of actors in play by one.
  $6B1C,$03 Fetch the actor ID.
  $6B1F,$01 Stash the actor ID on the stack.
  $6B20,$03 Fetch the original ID (byte #N$04 of the actor).
  $6B23,$03 Update the actor ID.
  $6B26,$03 Record the position of the sprite using #R$76D0.
  $6B29,$03 Fetch the movement of the actor (byte #N$05 of the actor).
  $6B2C,$01 Is the actor moving sideways?
  $6B2D,$02 Jump to #R$6B4E if it is not.
  $6B2F,$03 Fetch the vertical co-ordinate.
  $6B32,$04 Jump to #R$6B3A if the actor is above the floor.
  $6B36,$04 Write #N$00 to byte #N$05 of the actor.
@ $6B3A label=HandleClearedActor_Sideways
  $6B3A,$03 Fetch the horizontal co-ordinate.
  $6B3D,$04 Jump to #R$6B7D if the actor is in the right half of the screen.
  $6B41,$02 Subtract #N$04, to move the actor to the left.
  $6B43,$02 Jump to #R$6B49 if the actor has not reached the left side.
  $6B45,$01 Set #REGa to #N$00 (the left edge).
  $6B46,$03 Stop the actor moving sideways (byte #N$05 of the actor).
@ $6B49 label=HandleClearedActor_SetPosition
  $6B49,$03 Update the horizontal co-ordinate.
  $6B4C,$02 Jump to #R$6B5A.
N $6B4E The actor is dropping.
@ $6B4E label=HandleClearedActor_Drop
  $6B4E,$03 Fetch the vertical co-ordinate.
  $6B51,$02 Add #N$04, to drop the actor.
  $6B53,$04 Jump to #R$6B77 if the actor has reached the bottom of the screen.
  $6B57,$03 Update the vertical co-ordinate.
@ $6B5A label=HandleClearedActor_Flip
  $6B5A,$03 Fetch the frame counter.
  $6B5D,$02,b$01 Keep only bits 0-1.
  $6B5F,$03 Fetch the sprite ID (byte #N$04 of the actor).
  $6B62,$02 Jump to #R$6B69 if the frame counter is not a multiple of #N$04.
  $6B64,$02,b$01 Flip bit 0.
  $6B66,$03 Update the sprite ID (byte #N$04 of the actor).
@ $6B69 label=HandleClearedActor_Draw
  $6B69,$03 Update the actor ID.
  $6B6C,$03 Erase the sprite and draw it in its new position using #R$75CC.
  $6B6F,$03 Colour the sprite using #R$74EE.
  $6B72,$01 Restore the actor ID from the stack.
  $6B73,$03 Update the actor ID.
  $6B76,$01 Return.
N $6B77 The actor has dropped off the bottom of the screen.
@ $6B77 label=HandleClearedActor_Remove
  $6B77,$04 Write #N$00 to the actor ID.
  $6B7B,$01 Discard the saved actor ID from the stack.
  $6B7C,$01 Return.
N $6B7D The actor is in the right half of the screen.
@ $6B7D label=HandleClearedActor_Right
  $6B7D,$02 Add #N$04, to move the actor to the right.
  $6B7F,$04 Jump to #R$6B49 if the actor has not reached the right side.
  $6B83,$01 Set #REGa to #N$00.
  $6B84,$03 Stop the actor moving sideways (byte #N$05 of the actor).
  $6B87,$02 Set #REGa to #N$C0 (the right edge).
  $6B89,$02 Jump to #R$6B49.

c $6B8B Handle Falling Charlie
@ $6B8B label=HandleFallingCharlie
D $6B8B The handler for Charlie as he falls (ID #N$0E), after his hat has gone
. (see #R$6AA0). Charlie falls one pixel at a time until his vertical
. co-ordinate reaches #N$B4. Then the actor ID is changed to #N$18, which is
. handled by #R$6BAF, and the tune for losing a life is played (unless the tunes
. are muted).
R $6B8B IX Actor
  $6B8B,$03 Record the position of the sprite using #R$76D0.
  $6B8E,$03 Fetch the vertical co-ordinate.
  $6B91,$02 Add #N$01, to make Charlie fall by one pixel.
  $6B93,$04 Jump to #R$6BA0 if Charlie has fallen far enough.
  $6B97,$03 Update the vertical co-ordinate.
  $6B9A,$03 Erase the sprite and draw it in its new position using #R$75CC.
  $6B9D,$03 Jump to #R$74EE to colour the sprite.
@ $6BA0 label=HandleFallingCharlie_Finished
  $6BA0,$04 Write #N$18 to the actor ID.
  $6BA4,$03 Fetch the sound mute flag.
  $6BA7,$01 Are the tunes muted?
  $6BA8,$01 Return if they are.
  $6BA9,$03 Point #REGde at the tune for losing a life (#R$65D1).
  $6BAC,$03 Jump to #R$6568 to play the tune.

c $6BAF Handle End Of Life
@ $6BAF label=HandleEndOfLife
D $6BAF The handler for Charlie's actor slot once he has fallen to the bottom
. of the screen (ID #N$18). Nothing happens until all of the other actors have
. gone. Then, if the game is for one player, or the other player has no lives
. left, the game goes on with #R$6FFD if the active player has a life left, and
. is over (see #R$6C0A) if not. In a two player game, when both players have
. lives left, the players swap. If the active player has just lost the last
. life then "GAME OVER PLAYER n" is shown for that player first.
R $6BAF IX Actor
  $6BAF,$03 Fetch the number of actors which were in play on the last pass.
  $6BB2,$01 Were there any actors in play on the last pass?
  $6BB3,$01 Return if there were.
  $6BB4,$03 Fetch the game options.
  $6BB7,$01 Are the game options zero (a 1UP game with the keyboard)?
  $6BB8,$02 Jump to #R$6BC3 if the options are not zero.
@ $6BBA label=HandleEndOfLife_OnePlayer
  $6BBA,$03 Fetch the lives of the active player.
  $6BBD,$01 Has the active player run out of lives?
  $6BBE,$02 Jump to #R$6C0A if so.
  $6BC0,$03 Jump to #R$6FFD to start the next life.
@ $6BC3 label=HandleEndOfLife_TwoPlayer
  $6BC3,$03 Fetch the lives of the inactive player.
  $6BC6,$01 Has the other player run out of lives?
  $6BC7,$02 Jump to #R$6BBA if so.
  $6BC9,$03 Fetch the lives of the active player.
  $6BCC,$01 Has the active player run out of lives?
  $6BCD,$03 Call #R$6C02 if so, to show the "GAME OVER" message.
  $6BD0,$03 Swap the data for the two players using #R$6416.
  $6BD3,$03 Fetch the active player (#N$00 for 1UP, #N$FF for 2UP).
  $6BD6,$01 Invert #REGa, so the other player is active.
  $6BD7,$03 Update the active player (#R$5F21).
  $6BDA,$03 Draw the window, the pantry and the lives using #R$5FE8.
  $6BDD,$03 Jump to #R$6FFD to start the next life.

c $6BE0 Game Over
@ $6BE0 label=GameOver_1UP_Messaging
D $6BE0 Shows "GAME OVER PLAYER 1" in the play area, and waits for a while.
. The example below stops before the pause.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$6428,stop=$6457,sp=$5F00)
. #SIM(start=$5FE1,stop=$6001,sp=$5F00)
. #SCR$01(game-over-before)
. | #SIM(start=$6BE0,stop=$6BF1,sp=$5F00)
. #SCR$01(game-over-1up) } UDGTABLE# #POPS
E $6BE0 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$A8E3 }
. { #TRANZAM$6353 }
. LIST#
  $6BE0,c,$02 Fetch the player number "1", with bit 7 set to end the message.
N $6BE2 Print the messaging and pause to show it for a period of time.
@ $6BE2 label=GameOver_Write
  $6BE2,$03 Write the player number into the message at #R$6C1E(#N$6C30).
  $6BE5,$03 Clear the screen and draw the game window using #R$5FB7.
  $6BE8,$03 Point #REGde at #R$6C1E.
  $6BEB,$03 #REGhl=#N$7038.
  $6BEE,$03 Print the message using #R$7488.
N $6BF1 Introduce a pause by counting down from #N$10000 four times.
  $6BF1,$02 Set the repeat counter to #N$04.
@ $6BF3 label=PauseForCount
  $6BF3,$03 Set the delay counter to #N$0000, so that it counts down from
. #N$10000.
@ $6BF6 label=GameOver_Pause
  $6BF6,$01 Decrease the delay counter by one.
  $6BF7,$04 Loop back to #R$6BF6 until the delay counter is zero.
  $6BFB,$02 Decrease the repeat counter by one and loop back to #R$6BF6 until
. the delay has been done four times.
  $6BFD,$01 Return.

c $6BFE Show Game Over 2UP
@ $6BFE label=GameOver_2UP
D $6BFE Shows "GAME OVER PLAYER 2" in the play area, and waits for a while.
. The example below stops before the pause.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$6428,stop=$6457,sp=$5F00)
. #SIM(start=$5FE1,stop=$6001,sp=$5F00)
. #SCR$01(game-over-before)
. | #SIM(start=$6BFE,stop=$6BF1,sp=$5F00)
. #SCR$01(game-over-2up) } UDGTABLE# #POPS
  $6BFE,c,$02 Fetch the player number "2", with bit 7 set to end the message.
  $6C00,$02 Jump to #R$6BE2.

c $6C02 Show Current Game Over
@ $6C02 label=GameOver_Controller
D $6C02 Shows the "GAME OVER" message for the active player, using #R$5F21 to
. choose between 1UP and 2UP.
  $6C02,$06 If #R$5F21 is zero, jump to #R$6BE0.
  $6C08,$02 Else, jump to #R$6BFE.

c $6C0A End Game
@ $6C0A label=GameOver_ControllerRestart
D $6C0A Called when the last life has been lost in a one player game, or by the
. last player of a two player game. Checks the high score, shows the "GAME OVER"
. message for the active player, and then goes back to the game selection
. screen using #R$62B5.
  $6C0A,$03 Check for a new high score using #R$73D3.
  $6C0D,$06 If #R$5F21 is not zero, jump to #R$6C19.
  $6C13,$03 Show the 1UP game over message using #R$6BE0.
@ $6C16 label=GameOver_Restart
  $6C16,$03 Jump to #R$62B5.
@ $6C19 label=GameOver_Restart2UP
  $6C19,$03 Show the 2UP game over message using #R$6BFE.
  $6C1C,$02 Jump to #R$6C16.

t $6C1E Messaging: Game Over
@ $6C1E label=GameOver_Text
D $6C1E The message for #R$6BE0 and #R$6BFE. The first byte is the text colour
. and the last byte is the player number (changed to #N$B1 or #N$B2 by #R$6BE0
. or #R$6BFE).
  $6C1E,$13,h$01,$11:$01 #HTML("GAME OVER PLAYER <em>X</em>" (#COLOUR(#PEEK(#PC)) is the attribute).)

c $6C31 Handle Level Timer
@ $6C31 label=HandleLevelTimer
D $6C31 The handler for the actor which is created by #R$6C58 at the start of a
. level (IDs #N$0A and #N$0B). It is not drawn; its horizontal co-ordinate is
. used as a timer, which is decreased by one each pass. When it reaches zero the
. introduction to the level is started by #R$6D38.
R $6C31 IX Actor
  $6C31,$03 Fetch the timer (held in the horizontal co-ordinate).
  $6C34,$01 Decrease the timer by one.
  $6C35,$03 Update the timer.
  $6C38,$03 Call #R$6D38 if the timer is zero.
  $6C3B,$01 Return.

c $6C3C Next Level
@ $6C3C label=NextLevel
D $6C3C Moves on to the next level, when all of the ingredients for a level have
. been collected. Bits 0-2 of the level (#R$5F2D) are the level within a set of
. five, and bits 3-5 are the set. After the fifth level of a set the cake is
. made; the level is moved on to the start of the next set, the player gets an
. extra life and #N$2500 (BCD) points, and the cake is started by #R$64E8.
. Otherwise the level is set up by #R$6C58.
  $6C3C,$03 Point #REGhl at the level (#R$5F2D).
  $6C3F,$01 Increase the level by one.
  $6C40,$01 Fetch the level.
  $6C41,$02,b$01 Keep only bits 0-2.
  $6C43,$04 Jump to #R$6C58 if the set has not been finished.
  $6C47,$01 Fetch the level.
  $6C48,$02 Add #N$03, to get to the start of the next set.
  $6C4A,$01 Update the level.
  $6C4B,$03 Point #REGhl at the lives of the active player (#R$5F2E).
  $6C4E,$01 Increase the number of lives by one.
  $6C4F,$03 Set the bonus points for finishing a set to #N$2500 (in BCD).
  $6C52,$03 Add the points to the score using #R$7415.
  $6C55,$03 Jump to #R$64E8 to start the cake.

c $6C58 Set Up Level
@ $6C58 label=SetUpLevel
D $6C58 Sets up the active player for the level in #R$5F2D. The number of
. ingredients needed (in BCD) is #N$10 for the first set of five levels, #N$20
. for the second set, and so on. An actor with ID #N$0A is created in the first
. of the six slots, with a horizontal co-ordinate of #N$20; it is the timer
. which is handled by #R$6C31. The level number which is shown on the screen
. (in BCD, up to a maximum of #N$99) is also increased.
  $6C58,$03 Fetch the level.
  $6C5B,$01 Rotate #REGa left.
  $6C5C,$02,b$01 Keep only bits 4-6, which is the set (from bits 3-5 of the
. level) multiplied by #N$10.
  $6C5E,$02 Add #N$10.
  $6C60,$03 Set the number of ingredients needed (#R$5F2F).
  $6C63,$05 Write #N$0A to the actor ID of #R$5F55.
  $6C68,$03 Write #N$20 to the horizontal co-ordinate of the actor.
N $6C6B The level number (in BCD) maxes out at #N$99.
  $6C6B,$03 Point #REGhl at the level number (#R$5F30).
  $6C6E,$01 Fetch the level number.
  $6C6F,$02 Add #N$01 to the level number.
  $6C71,$01 Adjust #REGa to BCD.
  $6C72,$04 Jump to #R$6C78 if the level number is less than #N$99.
  $6C76,$02 Set the level number to the maximum, #N$99.
@ $6C78 label=SetUpLevel_Return
  $6C78,$01 Update the level number.
  $6C79,$01 Return.

c $6C7A Catch Actor
@ $6C7A label=CatchActor
D $6C7A Called when an actor has fallen into the mixing bowl (see #R$6E25). If
. it is one of the ingredients (an ID below #N$18) the rising notes are started
. and one ingredient is taken away from the number which is needed. Otherwise
. it is one of the nasties, so the falling notes are started and five is added
. to the number of ingredients which is needed (up to a maximum of #N$99).
R $6C7A IX Actor
  $6C7A,$03 Fetch the actor ID.
  $6C7D,$02,b$01 Keep only bits 0-5.
  $6C7F,$04 Jump to #R$6CA7 if the actor is not an ingredient.
  $6C83,$03 Start the rising notes using #R$68E7.
  $6C86,$02 Take one ingredient (#REGb=#N$01).

c $6C88 Take Ingredients
@ $6C88 label=TakeIngredients
D $6C88 Takes some away from the number of ingredients which are needed, and
. shows the new number in the mixing bowl. The number is never less than zero.
. When it reaches zero the actors which are left are cleared away (see
. #R$6AFC).
R $6C88 B Number of ingredients to take away
  $6C88,$03 Fetch the number of ingredients which the active player needs.
  $6C8B,$01 Subtract the number of ingredients taken.
  $6C8C,$02 Jump to #R$6CA1 if more are being taken away than are needed.
  $6C8E,$01 Adjust #REGa to BCD.
  $6C8F,$03 Update the number of ingredients needed (#R$5F2F).
  $6C92,$01 Are there any more ingredients needed?
  $6C93,$03 Call #R$6AFC if there are not, to clear away the actors.
@ $6C96 label=TakeIngredients_Print
  $6C96,$03 Point #REGhl at the screen address in the mixing bowl.
  $6C99,$03 Point #REGde at #R$5F2F.
  $6C9C,$02 Set the number of bytes to print to #N$01.
  $6C9E,$03 Print the number using #R$7450.
@ $6CA1 label=TakeIngredients_None
  $6CA1,$01 Set the number of ingredients needed to #N$00.
@ $6CA2 label=TakeIngredients_Store
  $6CA2,$03 Update the number of ingredients needed (#R$5F2F).
  $6CA5,$02 Jump to #R$6C96.

c $6CA7 Catch Nasty
@ $6CA7 label=CatchNasty
D $6CA7 Part of #R$6C7A, used when the actor which has fallen into the mixing
. bowl is one of the nasties. The falling notes are started and five more
. ingredients are needed, up to a maximum of #N$99.
  $6CA7,$03 Start the falling notes using #R$68D4.
  $6CAA,$02 Set the penalty to #N$05 ingredients.
  $6CAC,$03 Fetch the number of ingredients which the active player needs.
  $6CAF,$01 Add the penalty to the number of ingredients needed.
  $6CB0,$01 Adjust #REGa to BCD.
  $6CB1,$02 Jump to #R$6CA2 if the number has not gone above #N$99.
  $6CB3,$02 Set the number of ingredients needed to the maximum, #N$99.
  $6CB5,$02 Jump to #R$6CA2.

c $6CB7 Handle Sugar
@ $6CB7 label=HandleSugar
D $6CB7 The handler for the sugar (IDs #N$08 and #N$09), which drifts about
. the screen. Byte #N$04 of the actor is the horizontal speed, and byte #N$05
. is the vertical speed. Every #N$20 frames new random speeds are chosen (see
. #R$6EAC); they are both either #N$02 or #N$FE (-2). The sugar bounces off
. the sides and the top and bottom of the play area, and as it goes it also
. moves up and down in a wave, which is made from the frame counter in byte
. #N$07 of the actor.
.
. While the sugar is still entering from the right of the screen (a horizontal
. co-ordinate of #N$C4 or more) it can't hit Charlie or be hit.
R $6CB7 IX Actor
  $6CB7,$03 Record the position of the sprite using #R$76D0.
  $6CBA,$03 Point #REGhl at #R$5F1B.
  $6CBD,$01 Increase the number of actors in play by one.
  $6CBE,$03 Fetch the horizontal co-ordinate.
  $6CC1,$04 Jump to #R$6CD6 if the sugar is still entering from the right.
  $6CC5,$03 Test whether the sugar has hit Charlie using #R$6A46.
  $6CC8,$01 Has Charlie been hit (is #REGe now zero)?
  $6CC9,$03 Jump to #R$6A73 if Charlie has been hit.
  $6CCC,$03 Test whether a flour shot has hit the sugar using #R$7317.
  $6CCF,$07 Jump to #R$730D if the sugar has been hit.
@ $6CD6 label=HandleSugar_Move
  $6CD6,$03 Increase the frame counter in byte #N$07 of the actor by one.
  $6CD9,$04 Set the actor colour to #N$44 (green).
  $6CDD,$03 Fetch the frame counter.
  $6CE0,$02,b$01 Keep only bits 0-4.
  $6CE2,$02 Jump to #R$6D33 if the counter is a multiple of #N$20, to change
. speed.
  $6CE4,$03 Fetch the horizontal co-ordinate.
  $6CE7,$03 Add the horizontal speed.
  $6CEA,$03 Update the horizontal co-ordinate.
  $6CED,$04 Jump to #R$6D1B if the sugar has reached the right edge.
  $6CF1,$04 Jump to #R$6D21 if the sugar has reached the left edge.
N $6CF5 Make the offset for the wave from the frame counter. For each of the
. eight values of bits 0-2 of the counter it is #N$03, #N$FC, #N$FD, #N$FE,
. #N$00, #N$01, #N$02 and #N$03.
@ $6CF5 label=HandleSugar_Wave
  $6CF5,$03 Fetch the frame counter.
  $6CF8,$02,b$01 Keep only bits 0-1.
  $6CFA,$06 Jump to #R$6D04 if bit 2 of the frame counter is set.
  $6D00,$02 Negate #REGa.
  $6D02,$02,b$01 Flip bits 0-1.
@ $6D04 label=HandleSugar_Vertical
  $6D04,$03 Add the vertical speed.
  $6D07,$03 Add the vertical co-ordinate.
  $6D0A,$04 Jump to #R$6D27 if the sugar has reached the top.
  $6D0E,$04 Jump to #R$6D2D if the sugar has reached the bottom.
  $6D12,$03 Update the vertical co-ordinate.
@ $6D15 label=HandleSugar_Draw
  $6D15,$03 Erase the sprite and draw it in its new position using #R$75CC.
  $6D18,$03 Jump to #R$74EE to colour the sprite.
N $6D1B The sugar has reached the right edge, so move it left.
@ $6D1B label=HandleSugar_RightEdge
  $6D1B,$04 Set the horizontal speed to #N$FE (-2, moving left).
  $6D1F,$02 Jump to #R$6CF5.
N $6D21 The sugar has reached the left edge, so move it right.
@ $6D21 label=HandleSugar_LeftEdge
  $6D21,$04 Write #N$02 to the horizontal speed.
  $6D25,$02 Jump to #R$6CF5.
N $6D27 The sugar has reached the top, so move it down.
@ $6D27 label=HandleSugar_Top
  $6D27,$04 Write #N$02 to the vertical speed.
  $6D2B,$02 Jump to #R$6D15.
N $6D2D The sugar has reached the bottom, so move it up.
@ $6D2D label=HandleSugar_Bottom
  $6D2D,$04 Write #N$FE to the vertical speed.
  $6D31,$02 Jump to #R$6D15.
N $6D33 Choose new speeds. #REGa is the new vertical speed, so it is added to
. the vertical co-ordinate twice.
@ $6D33 label=HandleSugar_NewSpeeds
  $6D33,$03 Set random horizontal and vertical speeds using #R$6EAC.
  $6D36,$02 Jump to #R$6D04.

c $6D38 Start Level Introduction
@ $6D38 label=StartLevelIntroduction
D $6D38 Starts the introduction to a level, which is when the level timer has
. run out (see #R$6C31). The screen is cleared, and then the ingredient which
. is needed for the level runs across the screen from right to left, followed
. by Charlie. When Charlie has left the screen the level is started (see
. #R$5FE1). The actors for the ingredient and for Charlie are handled by
. #R$6D89.
  $6D38,$03 Clear the screen and create the actor for the ingredient using
. #R$6D45.
  $6D3B,$03 Point #REGhl at #R$5F35.
  $6D3E,$03 Point #REGde at #R$6D87.
  $6D41,$02 #REGc=#N$07 (the ID for Charlie).
  $6D43,$02 Jump to #R$6D67 to create the actor for Charlie.

c $6D45 Create Introduction Ingredient
@ $6D45 label=CreateIntroductionIngredient
D $6D45 Clears the screen and the attributes, and creates the actor for the
. ingredient which is needed for the level in the first of the six actor slots,
. using the data at #R$6D7D for the level (bits 0-2 of #R$5F2D). The actor
. is created by #R$6D67.
  $6D45,$04 Clear the flag which says whether Charlie is running (#R$5F29).
N $6D49 #HTML(Self modifying code; this updates the command at
. #R$74EE(#N$7515) to <strong>"CP #N$1E"</strong>, so the colouring can go
. further to the right.)
  $6D49,$05 Write #N$1E to #R$74EE(#N$7516).
  $6D4E,$03 Reset the attribute buffer using #R$74E2.
  $6D51,$03 Reset the screen buffer using #R$74D4.
  $6D54,$03 Point #REGhl at #R$6D7D.
  $6D57,$03 Fetch the level of the active player.
  $6D5A,$02 #REGc=#N$06 (the ID for the ingredient).
  $6D5C,$01 Multiply the level by two, as there are two bytes of data for each
. level.
  $6D5D,$02,b$01 Keep only bits 0-3.
  $6D5F,$03 Use the result as the offset into the table.
  $6D62,$01 Find the data for the level.
  $6D63,$01 #REGde=the address of the data for the level.
  $6D64,$03 Point #REGhl at the first spawned actor slot (#R$5F55).

c $6D67 Create Introduction Actor
@ $6D67 label=CreateIntroductionActor
D $6D67 Creates an actor for the level introduction, at the right of the screen
. (horizontal co-ordinate #N$F0, vertical co-ordinate #N$68). Bytes #N$05 and
. #N$06 of the actor are cleared.
R $6D67 C ID of the actor
R $6D67 DE Address of the sprite ID and the colour
R $6D67 HL Address of the actor
  $6D67,$01 Write the ID to the actor.
  $6D68,$01 Move on to the horizontal co-ordinate.
  $6D69,$02 Set the horizontal co-ordinate to #N$F0
. (off the right of the screen).
  $6D6B,$01 Move on to the vertical co-ordinate.
  $6D6C,$02 Write #N$68 to the vertical co-ordinate.
  $6D6E,$01 Move on to the colour.
  $6D6F,$01 Fetch the sprite ID.
  $6D70,$01 Keep the sprite ID in #REGc.
  $6D71,$01 Move on to the colour in the data.
  $6D72,$01 Fetch the colour.
  $6D73,$01 Update the actor colour.
  $6D74,$01 Move on to byte #N$04 of the actor.
  $6D75,$01 Write the sprite ID to byte #N$04 of the actor.
  $6D76,$01 Move on to byte #N$05 of the actor.
  $6D77,$02 Write #N$00 to byte #N$05 of the actor.
  $6D79,$01 Move on to byte #N$06 of the actor.
  $6D7A,$02 Write #N$00 to byte #N$06 of the actor.
  $6D7C,$01 Return.

b $6D7D Introduction Ingredients
@ $6D7D label=IntroductionIngredients
D $6D7D The sprite ID and the colour of the ingredient which runs across the
. screen in the introduction to each of the five levels in a set.
B $6D7D,$02,$01 Level #N$00: custard (yellow).
B $6D7F,$02,$01 Level #N$01: sugar (green).
B $6D81,$02,$01 Level #N$02: chocolate (red).
B $6D83,$02,$01 Level #N$03: cheese (yellow).
B $6D85,$02,$01 Level #N$04: orange peel (magenta).

b $6D87 Introduction Charlie
@ $6D87 label=IntroductionCharlie
D $6D87 The sprite ID and the colour of Charlie in the introduction to a level.
B $6D87,$02,$01

c $6D89 Handle Level Introduction
@ $6D89 label=HandleLevelIntroduction
D $6D89 The handler for the actors in the introduction to a level; the
. ingredient (ID #N$06) and Charlie (ID #N$07). While they are handled the ID
. is changed to the sprite which is in byte #N$04 of the actor. Byte #N$05 of
. the actor is zero until it has been drawn for the first time. The actors move
. left two pixels each pass, and change to their other frame every four passes.
.
. Charlie waits (and is not drawn) until the ingredient has gone past the point
. at which #R$5F29 is set by #R$6E11. When an actor goes off the left side of
. the screen it is removed; and if it was Charlie then the level is started.
. A tone is played by #R$6854 every eight frames for Charlie.
R $6D89 IX Actor
  $6D89,$03 Fetch the actor ID.
  $6D8C,$01 Stash the actor ID on the stack.
  $6D8D,$04 Jump to #R$6D97 if this is the ingredient.
  $6D91,$03 Fetch the flag which says whether Charlie is running.
  $6D94,$01 Has Charlie started to run yet?
  $6D95,$02 Jump to #R$6DF0 if he has not.
@ $6D97 label=HandleLevelIntroduction_Draw
  $6D97,$03 Fetch the flag which says whether the actor has been drawn.
  $6D9A,$01 Has the actor been drawn?
  $6D9B,$02 Jump to #R$6DB6 if it has.
  $6D9D,$03 Flag that the actor has been drawn.
  $6DA0,$03 Fetch the sprite ID (byte #N$04 of the actor).
  $6DA3,$03 Update the actor ID.
  $6DA6,$03 Draw the sprite using #R$7617.
  $6DA9,$01 Restore the actor ID from the stack.
  $6DAA,$03 Update the actor ID.
  $6DAD,$01 Return.
N $6DAE Charlie changes to his second frame.
@ $6DAE label=HandleLevelIntroduction_SecondFrame
  $6DAE,$02 Set the sprite ID for Charlie's second frame, #N$02.
  $6DB0,$02 Jump to #R$6DD3.
N $6DB2 Charlie changes to his first frame.
@ $6DB2 label=HandleLevelIntroduction_FirstFrame
  $6DB2,$02 Set the sprite ID for Charlie's first frame, #N$01.
  $6DB4,$02 Jump to #R$6DD3.
N $6DB6 The actor has been drawn already.
@ $6DB6 label=HandleLevelIntroduction_Animate
  $6DB6,$03 Fetch the sprite ID (byte #N$04 of the actor).
  $6DB9,$03 Update the actor ID.
  $6DBC,$03 Record the position of the sprite using #R$76D0.
  $6DBF,$03 Fetch the frame counter.
  $6DC2,$02,b$01 Keep only bits 0-1.
  $6DC4,$02 Jump to #R$6DD9 if the frame counter is not a multiple of #N$04.
  $6DC6,$03 Fetch the sprite ID (byte #N$04 of the actor).
  $6DC9,$04 Jump to #R$6DAE if the sprite is Charlie's first frame.
  $6DCD,$04 Jump to #R$6DB2 if the sprite is Charlie's second frame.
  $6DD1,$02,b$01 Flip bit 0, to change to the other frame of the ingredient.
@ $6DD3 label=HandleLevelIntroduction_SetFrame
  $6DD3,$03 Update the sprite ID (byte #N$04 of the actor).
  $6DD6,$03 Update the actor ID.
@ $6DD9 label=HandleLevelIntroduction_Move
  $6DD9,$03 Fetch the horizontal co-ordinate.
  $6DDC,$02 Subtract #N$02, to move the actor to the left.
  $6DDE,$03 Update the horizontal co-ordinate.
  $6DE1,$02 Compare with #N$90 (the point at which Charlie starts to run).
  $6DE3,$03 Call #R$6E11 if the actor is to the left of #N$90.
  $6DE6,$04 Jump to #R$6E03 if the actor has gone off the left of the screen.
  $6DEA,$03 Erase the sprite and draw it in its new position using #R$75CC.
  $6DED,$03 Colour the sprite using #R$74EE.
N $6DF0 Put the actor ID back, and play the tone if this is Charlie.
@ $6DF0 label=HandleLevelIntroduction_Finish
  $6DF0,$01 Restore the actor ID from the stack.
  $6DF1,$03 Update the actor ID.
  $6DF4,$03 Fetch the first byte of #SKOOLKID$5C78(FRAMES).
  $6DF7,$02,b$01 Keep only bits 0-2.
  $6DF9,$01 Return if the frame counter is not a multiple of #N$08.
  $6DFA,$03 Fetch the actor colour.
  $6DFD,$02 Compare with #N$47 (white, the colour of Charlie).
  $6DFF,$01 Return if this is not Charlie.
  $6E00,$03 Jump to #R$6854 to play the tone.
N $6E03 The actor has gone off the left of the screen.
@ $6E03 label=HandleLevelIntroduction_Remove
  $6E03,$03 Erase the sprite using #R$7607.
  $6E06,$04 Write #N$00 to the actor ID.
  $6E0A,$01 Restore the original actor ID from the stack.
  $6E0B,$05 Jump to #R$5FE1 to start the level if this was Charlie.
  $6E10,$01 Return.

c $6E11 Start Charlie Running
@ $6E11 label=StartCharlieRunning
D $6E11 Called when the ingredient in the introduction to a level has moved
. left of #N$90. The first time this happens #R$5F29 is set, so Charlie starts
. to run, and the actor for Charlie is created again.
  $6E11,$03 Fetch the flag which says whether Charlie is running.
  $6E14,$01 Has Charlie started to run?
  $6E15,$01 Return if he has.
  $6E16,$01 #REGa=#N$01.
  $6E17,$03 Flag that Charlie is running (#R$5F29).
  $6E1A,$03 Point #REGhl at #R$5F35.
  $6E1D,$03 Point #REGde at #R$6D87.
  $6E20,$02 #REGc=#N$07 (the ID for Charlie).
  $6E22,$03 Jump to #R$6D67 to create the actor for Charlie.

c $6E25 Move Hit Actor
@ $6E25 label=MoveHitActor
D $6E25 Moves an actor which has been hit by a flour shot (see #R$7317). The
. actor moves by the speeds in bytes #N$04 and #N$05, which were taken from the
. flour shot. Byte #N$07 of the actor is a counter which was set to #N$40; each
. time this is called it is decreased, and when it reaches zero the actor
. recovers (see #R$6EA8). The speed is changed to #N$04 (or #N$FC) when the
. actor reaches the left (or right) edge of the play area or the top of it, and
. if the other speed is zero it is changed to a random one. When the actor
. reaches the bottom of the play area then #R$6EC0 deals with it.
.
. Two bits of byte #N$06 of the actor are changed; bit 1 is set if the actor is
. less than #N$34 pixels from the middle of the screen (#N$68), and bit 7 is
. set if the actor is moving towards the middle of the screen (which is when it
. is in the left half and moving right, or in the right half and moving left).
R $6E25 IX Actor
  $6E25,$03 Decrease the counter in byte #N$07 of the actor by one.
  $6E28,$02 Jump to #R$6EA8 if the counter is zero.
  $6E2A,$03 Fetch the horizontal co-ordinate.
  $6E2D,$03 Add the horizontal speed.
  $6E30,$04 Jump to #R$6E7A if the actor has reached the left edge.
  $6E34,$04 Jump to #R$6E8F if the actor has reached the right edge.
  $6E38,$03 Update the horizontal co-ordinate.
@ $6E3B label=MoveHitActor_Vertical
  $6E3B,$03 Fetch the vertical co-ordinate.
  $6E3E,$03 Add the vertical speed.
  $6E41,$04 Jump to #R$6E95 if the actor has reached the top.
  $6E45,$04 Jump to #R$6EC0 if the actor has reached the bottom.
  $6E49,$03 Update the vertical co-ordinate.
N $6E4C Work out which half of the screen the actor is in, and how far it is
. from the middle.
  $6E4C,$03 Fetch the horizontal co-ordinate.
  $6E4F,$02 Subtract #N$68 (the middle of the screen).
  $6E51,$03 Jump to #R$6E5C if the actor is in the right half.
  $6E54,$04 Set bit 7 of byte #N$06 of the actor.
  $6E58,$02 Make the distance positive.
  $6E5A,$02 Jump to #R$6E60.
@ $6E5C label=MoveHitActor_RightHalf
  $6E5C,$04 Reset bit 7 of byte #N$06 of the actor.
@ $6E60 label=MoveHitActor_Distance
  $6E60,$04 Jump to #R$6E6A if the actor is #N$34 pixels or more from the
. middle.
  $6E64,$04 Set bit 1 of byte #N$06 of the actor.
  $6E68,$02 Jump to #R$6E6E.
@ $6E6A label=MoveHitActor_Far
  $6E6A,$04 Reset bit 1 of byte #N$06 of the actor.
N $6E6E Make bit 7 of byte #N$06 of the actor show whether the actor is moving
. towards the middle, by combining it with the direction of the horizontal
. speed.
@ $6E6E label=MoveHitActor_Direction
  $6E6E,$03 Fetch the horizontal speed.
  $6E71,$02,b$01 Keep only bit 7.
  $6E73,$03 Combine with byte #N$06 of the actor.
  $6E76,$03 Update byte #N$06 of the actor with the result.
  $6E79,$01 Return.
N $6E7A The actor has reached the left edge, so make it move to the right.
@ $6E7A label=MoveHitActor_LeftEdge
  $6E7A,$04 Set the horizontal speed to #N$04 (moving right).
@ $6E7E label=MoveHitActor_TestVerticalSpeed
  $6E7E,$03 Fetch the vertical speed.
  $6E81,$01 Is the vertical speed zero?
  $6E82,$02 Jump to #R$6E3B if it is not.
  $6E84,$02 Fetch a random number.
  $6E86,$02,b$01 Keep only bit 2.
  $6E88,$02 Subtract #N$02, so that the speed is #N$FE or #N$02.
  $6E8A,$03 Update the vertical speed.
  $6E8D,$02 Jump to #R$6E3B.
N $6E8F The actor has reached the right edge, so make it move to the left.
@ $6E8F label=MoveHitActor_RightEdge
  $6E8F,$04 Set the horizontal speed to #N$FC (moving left).
  $6E93,$02 Jump to #R$6E7E.
N $6E95 The actor has reached the top, so make it move down.
@ $6E95 label=MoveHitActor_Top
  $6E95,$04 Set the vertical speed to #N$04 (moving down).
@ $6E99 label=MoveHitActor_TestHorizontalSpeed
  $6E99,$03 Fetch the horizontal speed.
  $6E9C,$01 Is the horizontal speed zero?
  $6E9D,$01 Return if it is not.
  $6E9E,$02 Fetch a random number.
  $6EA0,$02,b$01 Keep only bit 2.
  $6EA2,$02 Subtract #N$02, so that the speed is #N$FE or #N$02.
  $6EA4,$03 Update the horizontal speed.
  $6EA7,$01 Return.

c $6EA8 Recover Hit Actor
@ $6EA8 label=RecoverHitActor
D $6EA8 Called when the counter for an actor which has been hit has run out.
. Bit 7 of the actor ID is reset, so the actor is handled normally again, and
. it is given new random speeds by #R$6EAC.
R $6EA8 IX Actor
  $6EA8,$04 Reset bit 7 of the actor ID, so that the actor is no longer hit.

c $6EAC Set Random Speeds
@ $6EAC label=SetRandomSpeeds
D $6EAC Sets the horizontal speed and the vertical speed of an actor to either
. #N$02 or #N$FE (-2), at random. The new vertical speed is also left in
. #REGa.
R $6EAC IX Actor
R $6EAC O:A The new vertical speed
  $6EAC,$02 Fetch a random number.
  $6EAE,$02,b$01 Keep only bit 2.
  $6EB0,$02 Subtract #N$02, so that the speed is #N$FE or #N$02.
  $6EB2,$03 Update the horizontal speed.
  $6EB5,$02 Fetch a random number.
  $6EB7,$01 Shift the random number right.
  $6EB8,$02,b$01 Keep only bit 2.
  $6EBA,$02 Subtract #N$02, so that the speed is #N$FE or #N$02.
  $6EBC,$03 Update the vertical speed.
  $6EBF,$01 Return.

c $6EC0 Land Hit Actor
@ $6EC0 label=LandHitActor
D $6EC0 Part of #R$6E25, used when the actor has reached the bottom of the play
. area (a vertical co-ordinate of #N$A0 or more). The mixing bowl and the four
. dustbins are along the bottom of the screen, and the actor is tested against
. them with #R$6F57. This depends on the vertical co-ordinate of the actor:
. #TABLE(default,centre,centre)
. { =h Vertical co-ordinate | =h What happens }
. { #N$A0 to #N$B7 | Nothing, if the actor is over the bowl or a dustbin;
. otherwise it bounces off the gap (see #R$6ED2) }
. { #N$B8 to #N$BF | The actor is over the bowl (see #R$6EF5), over a dustbin
. (see #R$6F1E), or bounces off the gap (see #R$6ED2) }
. { #N$C0 or more | See #R$6F39 }
. TABLE#
R $6EC0 A The new vertical co-ordinate
R $6EC0 IX Actor
  $6EC0,$03 Update the vertical co-ordinate.
  $6EC3,$03 Increase the counter in byte #N$07 of the actor by one, to make up
. for it being decreased.
  $6EC6,$04 Jump to #R$6F39 if the actor has gone as far as the bottom.
  $6ECA,$04 Jump to #R$6EEC if the actor is on the bottom row.
  $6ECE,$03 Test the position of the actor using #R$6F57.
  $6ED1,$01 Return if the actor is over the bowl or a dustbin.
N $6ED2 The actor is over a gap, so make it bounce.
@ $6ED2 label=LandHitActor_Bounce
  $6ED2,$03 Fetch the vertical co-ordinate.
  $6ED5,$04 Jump to #R$6EDF if the actor is #N$A8 or lower.
  $6ED9,$04 Set the vertical speed to #N$FC (-4, to bounce the actor upwards).
  $6EDD,$02 Jump to #R$6E99.
N $6EDF The actor is low down in the gap, so make it move the other way.
@ $6EDF label=LandHitActor_Rebound
  $6EDF,$03 Fetch the horizontal speed.
  $6EE2,$02 Reverse the direction by negating the horizontal speed.
  $6EE4,$03 Update the horizontal speed.
  $6EE7,$04 Set the vertical speed to #N$04 (moving down).
  $6EEB,$01 Return.
N $6EEC The actor is on the bottom row.
@ $6EEC label=LandHitActor_BottomRow
  $6EEC,$03 Test the position of the actor using #R$6F57.
  $6EEF,$02 Jump to #R$6ED2 if the actor is over a gap.
  $6EF1,$01 Fetch the result of the landing test (zero for the bowl).
  $6EF2,$01 Is the actor over the bowl?
  $6EF3,$02 Jump to #R$6F1E if it is over a dustbin.

c $6EF5 Catch Hit Actor
@ $6EF5 label=CatchHitActor
D $6EF5 The actor which was hit has landed in the mixing bowl. #R$6C7A deals
. with the number of ingredients which are needed, and the points for catching
. it are added to the score using the table at #R$6F47 (the nasties are worth
. nothing). The actor then becomes the batter (ID #N$28) at the bottom of the
. bowl, which is handled by #R$654C.
R $6EF5 IX Actor
  $6EF5,$03 Take away or add ingredients using #R$6C7A.
  $6EF8,$03 Fetch the actor ID.
  $6EFB,$01 Rotate the actor ID right, to halve it.
  $6EFC,$02,b$01 Keep only bits 0-3.
  $6EFE,$01 Use the result as the offset into the table of points.
  $6EFF,$02 Set the high byte of the offset to #N$00.
  $6F01,$03 Point #REGhl at #R$6F47.
  $6F04,$01 Find the points for the ingredient.
  $6F05,$01 Fetch the points.
  $6F06,$03 Add the points to the score using #R$7415.
  $6F09,$04 Write #N$28 to the actor ID.
  $6F0D,$04 Set the vertical co-ordinate to #N$A0 (the floor).
  $6F11,$04 Set the actor colour to #N$46 (yellow).
  $6F15,$01 Return.

c $6F16 Remove Fallen Actor
@ $6F16 label=RemoveFallenActor
D $6F16 Removes an actor which has hit the bottom of the play area, somewhere
. other than the mixing bowl. An ingredient makes the falling notes sound. A
. nasty which has been hit (it is white) is worth #N$0150 points, and makes the
. rising notes sound.
R $6F16 IX Actor
  $6F16,$03 Start the falling notes using #R$68D4.
@ $6F19 label=RemoveFallenActor_Remove
  $6F19,$04 Make the actor ID #N$00, which removes the actor.
  $6F1D,$01 Return.
N $6F1E An actor which is over a dustbin comes here.
@ $6F1E label=RemoveFallenActor_Pillar
  $6F1E,$03 Fetch the actor ID.
  $6F21,$02,b$01 Keep only bits 0-5.
  $6F23,$04 Jump to #R$6F16 if the actor is an ingredient.
  $6F27,$03 Fetch the actor colour.
  $6F2A,$04 Jump to #R$6F34 if the nasty has not been hit.
  $6F2E,$03 Set the points for a nasty which has been hit to #N$0150 (in BCD).
  $6F31,$03 Add the points to the score using #R$7415.
@ $6F34 label=RemoveFallenActor_Notes
  $6F34,$03 Start the rising notes using #R$68E7.
  $6F37,$02 Jump to #R$6F19.

c $6F39 Test Fallen Actor
@ $6F39 label=TestFallenActor
D $6F39 Part of #R$6E25, used when the actor has gone as far as the bottom of
. the screen. If the actor is near the middle of the screen (bit 1 of byte
. #N$06 is set) and is not moving towards the middle (bit 7 is not set) then it
. is caught by the mixing bowl (see #R$6EF5). Otherwise it is removed (see
. #R$6F1E).
R $6F39 IX Actor
  $6F39,$06 Jump to #R$6F1E if the actor is not near the middle.
  $6F3F,$06 Jump to #R$6EF5 if the actor is not moving towards the middle.
  $6F45,$02 Jump to #R$6F1E.

b $6F47 Bowl Points
@ $6F47 label=BowlPoints
D $6F47 The points (in BCD) for catching an actor in the mixing bowl, chosen by
. bits 1-4 of the actor ID. Only the ingredients are worth anything.
. #TABLE(default,centre,centre)
. { =h Actor | =h Points }
. { Custard | #N$55 }
. { Sugar | #N$65 }
. { Chocolate | #N$75 }
. { Cheese | #N$85 }
. { Orange peel | #N$95 }
. TABLE#
B $6F47,$10,$01

c $6F57 Test Landing Position
@ $6F57 label=TestLandingPosition
D $6F57 Tests whether the horizontal co-ordinate of an actor is over the mixing
. bowl, over one of the four dustbins or over one of the gaps between them.
. The screen is the same on both sides, so a co-ordinate in the right half is
. changed to the equivalent one in the left half first.
. #TABLE(default,centre,centre,centre)
. { =h Horizontal co-ordinate | =h Over | =h Carry flag }
. { #N$00 to #N$11, #N$AF to #N$BF | Outer dustbin | Reset }
. { #N$20 to #N$31, #N$8F to #N$A0 | Inner dustbin | Reset }
. { #N$41 to #N$7F | Mixing bowl | Reset }
. { Everywhere else | Gap | Set }
. TABLE#
R $6F57 IX Actor
R $6F57 O:B Zero if the actor is over the mixing bowl
R $6F57 O:F The carry flag is set if the actor is over a gap
  $6F57,$02 Set the position counter to #N$03.
  $6F59,$03 Fetch the horizontal co-ordinate.
  $6F5C,$04 Jump to #R$6F76 if the actor is off to the right.
  $6F60,$01 Test the horizontal co-ordinate.
  $6F61,$03 Jump to #R$6F6A if the actor is in the left half.
  $6F64,$02 Negate #REGa.
  $6F66,$02 Subtract #N$40.
  $6F68,$02,b$01 Keep only bits 0-6.
@ $6F6A label=TestLandingPosition_Loop
  $6F6A,$01 Decrease the position counter by one.
  $6F6B,$02 Jump to #R$6F71 if the position counter is zero.
  $6F6D,$02 Subtract #N$20.
  $6F6F,$02 Jump to #R$6F6A if there was no carry.
@ $6F71 label=TestLandingPosition_Finish
  $6F71,$02 Negate #REGa.
  $6F73,$02 Compare with #N$0F.
  $6F75,$01 Return.
@ $6F76 label=TestLandingPosition_Gap
  $6F76,$01 Set the carry flag.
  $6F77,$01 Return.

c $6F78 Handle Flour Shot
@ $6F78 label=HandleFlourShot
D $6F78 The handler for the flour shot (ID #N$03), which is fired by Charlie
. (see #R$710D). Byte #N$04 of the actor is the horizontal speed and byte #N$05
. is the vertical speed. The shot moves until it reaches the right, left,
. bottom or top of the play area, and then it explodes (see #R$6FA4).
R $6F78 IX Actor
  $6F78,$03 Record the position of the sprite using #R$76D0.
  $6F7B,$03 Fetch the horizontal co-ordinate.
  $6F7E,$03 Add the horizontal speed.
  $6F81,$04 Jump to #R$6FA4 if the shot has reached the right edge.
  $6F85,$04 Jump to #R$6FA4 if the shot has reached the left edge.
  $6F89,$01 Keep the new horizontal co-ordinate in #REGc.
  $6F8A,$03 Fetch the vertical co-ordinate.
  $6F8D,$03 Add the vertical speed.
  $6F90,$04 Jump to #R$6FA4 if the shot has reached the bottom.
  $6F94,$04 Jump to #R$6FA4 if the shot has reached the top.
  $6F98,$03 Update the vertical co-ordinate.
  $6F9B,$03 Update the horizontal co-ordinate.
  $6F9E,$03 Erase the sprite and draw it in its new position using #R$75CC.
  $6FA1,$03 Jump to #R$74EE to colour the sprite.

c $6FA4 Explode Flour Shot
@ $6FA4 label=ExplodeFlourShot
D $6FA4 Erases the flour shot, and changes it into an explosion (ID #N$26) which
. is handled by #R$65E8.
R $6FA4 IX Flour shot
  $6FA4,$03 Erase the sprite using #R$7617.
  $6FA7,$04 Change the actor ID to #N$26 (an exploding flour shot).
  $6FAB,$04 Write #N$03 to byte #N$07 of the actor (the explosion counter).
  $6FAF,$01 Return.

c $6FB0 Controls: Kempston Joystick
@ $6FB0 label=ReadKempstonJoystick
D $6FB0 Reads the Kempston joystick. The bits are flipped so that they are the
. same as those which are returned by #R$6FB4.
E $6FB0 View the equivalent code in;
. #LIST
. { #JETPAC$733A }
. { #SABREWULF$B0D9 }
. LIST#
R $6FB0 O:A The controls (see #R$6FB4)
  $6FB0,$02 Fetch the state of the Kempston joystick.
  $6FB2,$01 Flip the bits, to match the keyboard (a zero bit means pressed).
  $6FB3,$01 Return.

c $6FB4 Read Controls
@ $6FB4 label=ReadControls
D $6FB4 Reads the controls which have been chosen in #R$5F0C; the keyboard, the
. Kempston joystick or the cursor joystick. The bits of the result are reset
. for the directions (and fire) which are being pressed.
. #TABLE(default,centre,centre,centre)
. { =h Bit | =h Control | =h Keyboard }
. { #N$00 | Right | W }
. { #N$01 | Left | Q }
. { #N$02 | Down | E }
. { #N$03 | Up | R }
. { #N$04 | Fire | T }
. TABLE#
E $6FB4 View the equivalent code in;
. #LIST
. { #ATICATAC$93BE }
. { #UNDERWURLDE$AE17 }
. LIST#
R $6FB4 O:A The controls
  $6FB4,$03 Fetch the game options.
  $6FB7,$02,b$01 Keep only bits 1-2 (the choice of controls).
  $6FB9,$04 Jump to #R$6FB0 if the Kempston joystick is being used.
  $6FBD,$04 Jump to #R$6FD7 if the cursor joystick is being used.
  $6FC1,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FB | Q | W | E | R | T }
. TABLE#
  $6FC7,$01 Keep the key states in #REGc.
  $6FC8,$01 Move the "W" key into bit 0.
  $6FC9,$02,b$01 Keep only bit 0.
  $6FCB,$01 Keep the result in #REGe.
  $6FCC,$01 Fetch the key states.
  $6FCD,$01 Move the "Q" key into bit 1.
  $6FCE,$02,b$01 Keep only bit 1.
  $6FD0,$01 Combine with #REGe.
  $6FD1,$01 Keep the result in #REGe.
  $6FD2,$01 Fetch the key states.
  $6FD3,$02,b$01 Keep only bits 2-4 ("E", "R" and "T").
  $6FD5,$01 Combine with #REGe.
  $6FD6,$01 Return.

c $6FD7 Controls: Cursor Joystick
@ $6FD7 label=ReadCursorJoystick
D $6FD7 Reads the cursor joystick, which uses the keys "5" (left), "6" (down),
. "7" (up), "8" (right) and "0" (fire). The bits of the result are the same as
. those which are returned by #R$6FB4.
E $6FD7 View the equivalent code in;
. #LIST
. { #SABREWULF$B103 }
. LIST#
R $6FD7 O:A The controls (see #R$6FB4)
  $6FD7,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $6FDD,$01 Keep the key states in #REGc.
  $6FDE,$02,b$01 Keep only bit 3 ("7", up).
  $6FE0,$01 Keep the result in #REGe.
  $6FE1,$01 Fetch the key states.
  $6FE2,$02 Rotate #REGa right twice.
  $6FE4,$02,b$01 Keep only bit 0 ("8", right), bit 2 ("6", down) and bit 6
. ("0", fire).
  $6FE6,$01 Combine with #REGe.
  $6FE7,$01 Keep the result in #REGe.
  $6FE8,$02 Rotate #REGa right twice, which moves the fire bit to bit 4.
  $6FEA,$02,b$01 Keep only bit 4.
  $6FEC,$01 Combine with #REGe.
  $6FED,$02,b$01 Keep only bits 0-4.
  $6FEF,$01 Keep the result in #REGe.
  $6FF0,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $6FF6,$03 Move the "5" key (left) into bit 1.
  $6FF9,$02,b$01 Keep only bit 1.
  $6FFB,$01 Combine with #REGe.
  $6FFC,$01 Return.

c $6FFD Start Life
@ $6FFD label=StartLife
D $6FFD Puts Charlie in his starting position, and takes a life away from the
. active player. Charlie will not appear until a delay has run out (see
. #R$7048); it is shorter for a one player game than a two player game, so
. that the players have time to swap controls.
  $6FFD,$03 Point #REGhl at the data for Charlie at the start of a life
. (#R$5FAF).
  $7000,$03 Point #REGde at #R$5F35.
  $7003,$03 Set the number of bytes to copy to #N$0008.
  $7006,$02 Copy the data for Charlie into the first actor slot.
  $7008,$02 Set the delay for a one player game to #N$80.
  $700A,$03 Point #REGhl at #R$5F0C.
  $700D,$04 Jump to #R$7013 if this is a one player game.
  $7011,$02 Add #N$7F, so the delay is #N$FF for a two player game.
@ $7013 label=StartLife_SetDelay
  $7013,$03 Set the game delay timer (#R$5F25).
  $7016,$07 Take a life away from the active player (#R$5F2E).
  $701D,$03 Jump to #R$7378 to show the lives.

c $7020 Flash Score Label
@ $7020 label=ScoreLabelFlash
D $7020 Makes the score label of the active player ("1UP" or "2UP") flash. This
. is done while the delay before Charlie appears is running (see #R$7048).
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$6428,stop=$6457,sp=$5F00)
. #SIM(start=$5FE1,stop=$6001,sp=$5F00)
. #SCR$04,$00,$00,$0A,$02(flash-score-before)
. | #SIM(start=$7020,stop=$0000,sp=$5E00)
. #SCR$04,$00,$00,$0A,$02(flash-score-after) } UDGTABLE# #POPS
E $7020 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$8C3E }
. { #SABREWULF$AEA1 }
. LIST#
  $7020,$03 Fetch the active player (#N$00 for 1UP, #N$FF for 2UP).
  $7023,$03 If the current player is 2UP then jump to #R$7043.
N $7026 Flash 1UP score label.
  $7026,$03 #REGhl=#N($00,$02,$03),#N($18,$02,$03) (position of the 1UP score label).

N $7029 Set flash state for the 3-attributes of the score label.
@ $7029 label=FlashText
  $7029,$03 Calculate the attribute buffer address using #R$7534.
  $702C,$02 Set the letter counter to #N$03
. (the three letters in a score label).
@ $702E label=FlashText_Loop
  $702E,$01 Fetch the attribute byte.
  $702F,$02,b$01 Ensure bit 7 is set (the flash bit).
  $7031,$01 Write the attribute byte back.
  $7032,$01 Move on to the next attribute.
  $7033,$02 Decrease the letter counter by one and loop back to #R$702E until
. all three letters have been done.
  $7035,$01 Return.

N $7036 Unset flash state for the 3-attributes of the score label.
@ $7036 label=UnsetFlashText
  $7036,$03 Calculate the attribute buffer address using #R$7534.
  $7039,$02 Set the letter counter to #N$03
. (the three letters in a score label).
@ $703B label=UnsetFlashText_Loop
  $703B,$01 Fetch the attribute byte.
  $703C,$02,b$01 Keep only bits 0-6 (i.e. everything except the flash bit).
  $703E,$01 Write the attribute byte back.
  $703F,$01 Increase the attribute pointer by one.
  $7040,$02 Decrease the letter counter by one and loop back to #R$703B until
. all three letters have been done.
  $7042,$01 Return.

N $7043 Flash 2UP score label.
@ $7043 label=FlashScoreLabel2UP
  $7043,$03 #REGhl=#N($00,$02,$03),#N($D8,$02,$03) (position of the 2UP score label).
  $7046,$02 Jump to #R$7029.

c $7048 Game Play Entry
@ $7048 label=GamePlayEntry
D $7048 The handler for Charlie (IDs #N$01 and #N$02). At the start of each life
. there is a delay (#R$5F25) before Charlie appears, and while it runs the
. score label of the active player flashes (see #R$7020). When it has run out
. the label stops flashing, Charlie is drawn and a tone is played (see
. #R$6882). After that Charlie is moved by #R$706B.
E $7048 View the equivalent code in;
. #LIST
. { #PSSST$6DBA }
. { #SABREWULF$AECF }
. LIST#
  $7048,$07 If #R$5F25 is zero, jump to #R$706B.
  $704F,$01 Decrease the game delay timer by one.
  $7050,$02 Jump to #R$7020 if the delay timer is still active.
  $7052,$06 If #R$5F21 says this is a 2UP game, jump to #R$7066.

N $7058 Handle turning off flash for 1UP score label.
  $7058,$03 #REGhl=#N($00,$02,$03),#N($18,$02,$03) (position of the 1UP score label).
@ $705B label=Game_UnsetFlash
  $705B,$03 Turn off the flash using #R$7036.
  $705E,$03 Draw Charlie using #R$7617.
  $7061,$03 Play the game start tone using #R$6882.
  $7064,$02 Jump to #R$706B.
N $7066 Handle turning off flash for 2UP score label.
@ $7066 label=Game2UP_UnsetFlash
  $7066,$03 #REGhl=#N($00,$02,$03),#N($D8,$02,$03) (position of the 2UP score label).
  $7069,$02 Jump to #R$705B.

c $706B Game Play Start
@ $706B label=GamePlay_Start
D $706B Moves Charlie, using the controls which are read by #R$6FB4. Byte #N$04
. of the actor is the horizontal speed and byte #N$05 is the vertical speed;
. each is #N$02 (or #N$FE) while the control is pressed, and zero otherwise.
. Charlie can't move past the edges of the play area. While he is moving his
. ID changes between #N$01 and #N$02 every four frames, which animates him. The
. last direction in which he moved is kept in #R$5F2B.
.
. While fire is being held down, a flour shot is fired every eight frames, if
. there is one of the two slots for the shots free. The shot goes in the last
. direction in which Charlie moved, at three times his speed.
R $706B IX Actor
  $706B,$03 Record the position of the sprite using #R$76D0.
  $706E,$03 Read the controls using #R$6FB4.
  $7071,$04 Jump to #R$70EF if fire is being pressed.
  $7075,$04 Write #N$00 to byte #N$06 of the actor (the fire counter).
@ $7079 label=ControlCharlie_Movement
  $7079,$02 Test bit 0 (right).
  $707B,$03 Clear Charlie's movement (#REGde=#N$0000).
  $707E,$02 Jump to #R$70D9 if right is being pressed.
  $7080,$04 Jump to #R$70E0 if left is being pressed.
  $7084,$04 Write #N$00 to the horizontal speed.
@ $7088 label=ControlCharlie_Vertical
  $7088,$04 Jump to #R$70E4 if up is being pressed.
  $708C,$04 Jump to #R$70EB if down is being pressed.
  $7090,$04 Write #N$00 to the vertical speed.
N $7094 Move Charlie horizontally. #REGe is the speed if he has moved, and
. zero if he has not.
@ $7094 label=ControlCharlie_MoveHorizontal
  $7094,$03 Fetch the horizontal co-ordinate.
  $7097,$03 Add the horizontal speed.
  $709A,$02 Assume that Charlie has not moved horizontally (#REGe=#N$00).
  $709C,$04 Jump to #R$70AA if Charlie has reached the left edge.
  $70A0,$04 Jump to #R$70AA if Charlie has reached the right edge.
  $70A4,$03 Update the horizontal co-ordinate.
  $70A7,$03 Set the horizontal movement to the horizontal speed.
N $70AA Move Charlie vertically. #REGd is the speed if he has moved, and zero if
. he has not.
@ $70AA label=ControlCharlie_MoveVertical
  $70AA,$03 Fetch the vertical co-ordinate.
  $70AD,$03 Add the vertical speed.
  $70B0,$02 Assume that Charlie has not moved vertically (#REGd=#N$00).
  $70B2,$04 Jump to #R$70C0 if Charlie has reached the top.
  $70B6,$04 Jump to #R$70C0 if Charlie has reached the bottom.
  $70BA,$03 Update the vertical co-ordinate.
  $70BD,$03 Set the vertical movement to the vertical speed.
@ $70C0 label=ControlCharlie_Animate
  $70C0,$01 Fetch the horizontal movement.
  $70C1,$01 Combine with the vertical movement.
  $70C2,$02 Jump to #R$70D3 if Charlie has not moved.
  $70C4,$04 Save the movement in #R$5F2B, which sets the direction of flour
. shots.
  $70C8,$03 Fetch the first byte of #SKOOLKID$5C78(FRAMES).
  $70CB,$02 Shift #REGa right twice.
  $70CD,$02,b$01 Keep only bit 0.
  $70CF,$01 Add #N$01, to get Charlie's running frame (#N$01 or #N$02).
  $70D0,$03 Update the actor ID.
@ $70D3 label=ControlCharlie_Draw
  $70D3,$03 Erase the sprite and draw it in its new position using #R$75CC.
  $70D6,$03 Jump to #R$74EE to colour the sprite.
N $70D9 Right is being pressed.
@ $70D9 label=ControlCharlie_Right
  $70D9,$02 Set the speed to #N$02 (moving right).
@ $70DB label=ControlCharlie_SetHorizontalSpeed
  $70DB,$03 Set the horizontal speed.
  $70DE,$02 Jump to #R$7088.
N $70E0 Left is being pressed.
@ $70E0 label=ControlCharlie_Left
  $70E0,$02 Set the speed to #N$FE (moving left).
  $70E2,$02 Jump to #R$70DB.
N $70E4 Up is being pressed.
@ $70E4 label=ControlCharlie_Up
  $70E4,$02 Set the speed to #N$FE (moving up).
@ $70E6 label=ControlCharlie_SetVerticalSpeed
  $70E6,$03 Set the vertical speed.
  $70E9,$02 Jump to #R$7094.
N $70EB Down is being pressed.
@ $70EB label=ControlCharlie_Down
  $70EB,$02 Set the speed to #N$02 (moving down).
  $70ED,$02 Jump to #R$70E6.
N $70EF Fire is being pressed. A shot is fired when the fire counter in byte
. #N$06 of the actor is a multiple of #N$08, so the first one is fired at once.
@ $70EF label=ControlCharlie_Fire
  $70EF,$01 Save the controls on the stack.
  $70F0,$03 Fetch the fire counter (byte #N$06 of the actor).
  $70F3,$03 Increase the fire counter by one.
  $70F6,$02,b$01 Keep only bits 0-2.
  $70F8,$02 Jump to #R$7109 if the fire counter was not a multiple of #N$08.
  $70FA,$03 Point #REGhl at #R$5F3D.
  $70FD,$02 Set the slot counter to #N$02 (the number of slots for flour shots).
  $70FF,$03 Set the size of an actor to #N$0008.
@ $7102 label=ControlCharlie_FindSlot
  $7102,$01 Fetch the actor ID.
  $7103,$01 Is the slot empty?
  $7104,$02 Jump to #R$710D if it is.
  $7106,$01 Move on to the next slot.
  $7107,$02 Decrease the slot counter by one and loop back to #R$7102 until
. both slots have been tried.
@ $7109 label=ControlCharlie_FireFinished
  $7109,$01 Restore the controls from the stack.
  $710A,$03 Jump to #R$7079.
N $710D Create the flour shot, which starts at Charlie's position.
@ $710D label=ControlCharlie_CreateShot
  $710D,$02 Set the actor ID to #N$03 (a flour shot).
  $710F,$01 Save the address of the flour shot on the stack.
  $7110,$01 Move on to the horizontal co-ordinate.
  $7111,$03 Fetch Charlie's horizontal co-ordinate.
  $7114,$01 Update the horizontal co-ordinate of the flour shot.
  $7115,$01 Move on to the vertical co-ordinate.
  $7116,$03 Fetch Charlie's vertical co-ordinate.
  $7119,$01 Update the vertical co-ordinate of the flour shot.
  $711A,$01 Move on to the colour.
  $711B,$02 Set the colour of the flour shot to #N$47 (white).
  $711D,$01 Move on to the horizontal speed.
  $711E,$04 Fetch Charlie's last movement (#R$5F2B).
  $7122,$01 Fetch the horizontal movement.
  $7123,$02 Multiply #REGa by two.
  $7125,$01 Add #REGe, to multiply it by three.
  $7126,$01 Update the horizontal speed of the flour shot.
  $7127,$01 Move on to the vertical speed.
  $7128,$01 Fetch the vertical movement.
  $7129,$02 Multiply #REGa by two.
  $712B,$01 Add #REGd, to multiply it by three.
  $712C,$01 Update the vertical speed of the flour shot.
  $712D,$01 Restore the address of the flour shot from the stack.
  $712E,$02 Save the pointer to the current actor on the stack.
  $7130,$01 Save the address of the flour shot on the stack.
  $7131,$02 Restore #REGix from the stack (this is now the flour shot).
  $7133,$03 Draw the flour shot using #R$7617.
  $7136,$02 Restore the pointer to the current actor from the stack.
  $7138,$03 Play the chirp using #R$6825.
  $713B,$02 Jump to #R$7109.

c $713D Remove All Actors
@ $713D label=RemoveAllActors
D $713D Removes all ten of the actors, by writing zero to each of the IDs.
  $713D,$03 Point #REGhl at the first actor (Charlie's slot).
  $7140,$02 Set the actor counter to #N$0A (the number of actors).
  $7142,$02 Jump to #R$7149.

u $7144 Unused Remove Actors
@ $7144 label=Unused_RemoveActors
D $7144 Not used by the game. It would remove nine actors, starting at #N$5F5D,
. by using #R$7149.
C $7144,$03 #REGhl=#N$5F5D.
C $7147,$02 #REGb=#N$09 (the number of actors).

c $7149 Remove Actors
@ $7149 label=RemoveActors
D $7149 Removes a number of actors, by writing zero to each of the IDs.
R $7149 B Number of actors
R $7149 HL Address of the first actor
  $7149,$03 Set the size of an actor to #N$0008.
@ $714C label=RemoveActors_Loop
  $714C,$02 Write #N$00 to the actor ID.
  $714E,$01 Move on to the next actor.
  $714F,$02 Decrease the actor counter by one and loop back to #R$714C until
. all of the actors have been done.
  $7151,$01 Return.

c $7152 Limit Frame Rate
@ $7152 label=LimitFrameRate
D $7152 The handler for empty actor slots (IDs #N$00, #N$0C and #N$17). It adds
. a short pause, which slows the game down when there are few actors. The pause
. is skipped while the frame update (#R$7160) is running.
E $7152 View the equivalent code in;
. #LIST
. { #JETPAC$691B }
. { #LUNARJETMAN$824A }
. { #PSSST$70DF }
. LIST#
  $7152,$05 Return if #R$5F23 is set (the frame update is running).
  $7157,$03 Set the pause counter to #N$0100.
@ $715A label=LimitFrameRate_Loop
  $715A,$01 Decrease the pause counter by one.
  $715B,$04 Keep jumping back to #R$715A until the counter is zero.
  $715F,$01 Return.

c $7160 Frame Update
@ $7160 label=FrameUpdate
D $7160 Called by #R$6463 when the frame counter has changed since the last
. frame update. Runs an extra pass over only the first four actor slots, which
. include Charlie and the sound effect actor, before carrying on with the pass
. which was in progress.
E $7160 View the equivalent code in;
. #LIST
. { #JETPAC$6965 }
. { #LUNARJETMAN$8209 }
. { #PSSST$70ED }
. LIST#
  $7160,$01 Disable interrupts.
  $7161,$06 Store #SKOOLKID$5C78(FRAMES) at #R$5F22.
  $7167,$05 Set #R$5F23 to #N$01 (frame has updated).
  $716C,$02 Save the pointer to the current actor on the stack.
  $716E,$06 Write #R$5F55 to #N$71AC.
N $7174 #HTML(Self modifying code; this changes the command at #R$71A3(#N$71BE)
. to <strong>JP #R$7198</strong>, so that the extra pass ends there.)
  $7174,$0B #HTML(Write #N$C3 to #R$71A3(#N$71BE) and #R$7198 to
. #R$71A3(#N$71BF), i.e. <strong>JP #R$7198</strong>).
  $717F,$04 Point #REGix at #R$5F35.
  $7183,$03 Jump to #R$6463.

c $7186 Reset Modified Code
@ $7186 label=ResetModifiedCode
D $7186 Puts back the two changes which #R$7160 makes to #R$71A3, so that
. the passes through the actors are normal again.
E $7186 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$822F }
. { #PSSST$7113 }
. LIST#
N $7186 Self modifying code; this updates the address for #REGbc (at
. #R$71A3(#N$71AB)).
  $7186,$06 Write #R$5F85 to #R$71A3(#N$71AC).
N $718C Self modifying code; this updates the command at #R$71A3(#N$71BE) to
. "LD HL, (xx)".
  $718C,$05 Write #N$2A to #R$71A3(#N$71BE).
N $7191 Self modifying code; this updates the address for #REGhl (at
. #R$71A3(#N$71BE)).
  $7191,$06 Write #R$5F1D to #R$71A3(#N$71BF).
  $7197,$01 Return.

c $7198 End Frame Update
@ $7198 label=FrameUpdateEnd
D $7198 Ends the extra pass which was started by #R$7160, putting back the
. changes which were made to the code.
  $7198,$03 Reset the self-modifying code using #R$7186.
  $719B,$02 Restore the pointer to the current actor from the stack.
  $719D,$04 Write #N$00 to #R$5F23.
  $71A1,$01 Enable interrupts.
  $71A2,$01 Return.

c $71A3 Next Actor
@ $71A3 label=NextActor
D $71A3 Every actor handler returns here. Moves on to the next actor, and
. goes back to #R$6463 until the last one has been done. After the last actor
. the game is paused while "SHIFT" is held down, the frame counter at #R$5F1D is
. increased, and the number of actors which were in play is saved in #R$5F1C.
. If there are no actors in play and no ingredients are needed then the level is
. finished. Otherwise the actors are created by #R$71D8.
  $71A3,$05 Move on to the next actor by adding #N$0008 to #REGix.
  $71A8,$03 Copy the pointer to the actor into #REGhl, using the stack.
N $71AB #HTML(Self modifying code; the operand of this command is written
. as #N$5F55 by #R$7160 (for the extra pass over the first four actors) and
. as #N$5F85 by #R$7186 (the end of the last actor).)
  $71AB,$03 Fetch the address of the end of the actors (#N$5F85).
  $71AE,$03 Subtract the end of the actors from the pointer.
  $71B1,$03 Jump to #R$6463 if the last actor has not been done yet.
N $71B4 Holding "SHIFT" pauses the game.
@ $71B4 label=NextActor_Pause
  $71B4,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $71BA,$04 Jump to #R$71B4 if key "SHIFT" has been pressed.
N $71BE #HTML(Self modifying code; this command is changed to <strong>JP
. #R$7198</strong> by #R$7160, to end the extra pass over the first four actors,
. and is put back by #R$7186.)
@ $71BE label=NextActor_FrameCounter
  $71BE,$03 Fetch the frame counter.
  $71C1,$01 Increase the frame counter by one.
  $71C2,$03 Update the frame counter.
  $71C5,$03 Fetch the number of actors in play.
  $71C8,$03 Remember the number of actors in play for the next pass (#R$5F1C).
  $71CB,$01 Keep the number of actors in play in #REGb.
  $71CC,$03 Fetch the number of ingredients which the active player needs.
  $71CF,$01 Combine with the number of actors in play.
  $71D0,$02 Jump to #R$71D8 if there are still actors in play, or ingredients
. needed.
N $71D2 The level has been finished, so remove all of the actors, and move on to
. the next level.
  $71D2,$03 Remove all of the actors using #R$713D.
  $71D5,$03 Set up the next level using #R$6C3C.

c $71D8 Create Actor
@ $71D8 label=CreateActor
D $71D8 Creates a new actor from the pantry, if the conditions are right. It is
. not done if six or more actors are in play, if the delay at the start of a
. life is running, if no more ingredients are needed, or if Charlie is not in
. his normal form (ID #N$01 or #N$02). It is also done on average only one pass
. in every #N$20, which is decided with the frame counter and a random number.
. The new actor is made from the template at #R$7279, in the first of the six
. slots from #R$5F55 which is empty. It starts at the right, at the height of
. the shelf in the pantry for the level (#N$2F, #N$47, #N$5F, #N$77 or #N$8F).
.
. Usually it is the ingredient for the level (see #R$6D7D), but it is one of the
. nasties (the tack, the washer or the bolt) if the number of slots which are
. left (including this one) is not more than the set the level is in (up to a
. maximum of #N$04) plus one. So there are more nasties in the later sets of
. levels. The monster is also created by #R$67E2, if it is not already.
  $71D8,$03 Fetch the number of actors in play.
  $71DB,$04 Jump to #R$7211 if there are six actors in play.
  $71DF,$04 Fetch the frame counter and keep it in #REGb.
  $71E3,$02 Fetch a random number.
  $71E5,$01 Add the frame counter.
  $71E6,$02,b$01 Keep only bits 0-4.
  $71E8,$02 Jump to #R$7211 if the result is not zero.
  $71EA,$03 Fetch the game delay timer.
  $71ED,$01 Is the delay at the start of a life still running?
  $71EE,$02 Jump to #R$7211 if it is.
  $71F0,$03 Fetch the number of ingredients which the active player needs.
  $71F3,$01 Are any more ingredients needed?
  $71F4,$02 Jump to #R$7211 if not.
  $71F6,$03 Fetch Charlie's ID.
  $71F9,$02,b$01 Keep only bits 0-5.
  $71FB,$01 Is Charlie's ID #N$01?
  $71FC,$02 Jump to #R$7201 if Charlie's ID is #N$01.
  $71FE,$01 Is Charlie's ID #N$02?
  $71FF,$02 Jump to #R$7211 if Charlie's ID is not #N$02.
N $7201 Find the first empty slot out of the six.
@ $7201 label=CreateActor_FindSlot
  $7201,$03 Point #REGhl at the first slot for spawned actors.
  $7204,$02 Set the slot counter to #N$06 (the number of slots).
  $7206,$03 Set the size of an actor to #N$0008.
@ $7209 label=CreateActor_FindSlotLoop
  $7209,$01 Fetch the actor ID.
  $720A,$01 Is the slot empty?
  $720B,$03 Jump to #R$7214 if it is.
  $720E,$01 Move on to the next slot.
  $720F,$02 Decrease the slot counter by one and loop back to #R$7209 until all
. of the slots have been tried.
@ $7211 label=CreateActor_Finished
  $7211,$03 Jump to #R$6457.
N $7214 Make the new actor from the template.
@ $7214 label=CreateActor_Create
  $7214,$01 Point #REGde at the empty slot.
  $7215,$03 Point #REGhl at #R$7279.
  $7218,$01 Save the slot counter on the stack.
  $7219,$03 Set the number of bytes to copy to #N$0008.
  $721C,$01 Save the address of the slot on the stack.
  $721D,$02 Copy the template into the slot.
  $721F,$02 Point #REGix at the new actor.
  $7221,$02 #REGa=#N$08.
  $7223,$03 Update the actor ID.
N $7226 Work out the height of the shelf in the pantry for the level; it is
. #N$2F + ((#N$18 * the level within the set) AND #N$78).
  $7226,$03 Fetch the level of the active player.
  $7229,$02,b$01 Keep only bits 0-2.
  $722B,$01 Keep the level within the set in #REGc.
  $722C,$02 Multiply the level within the set by two.
  $722E,$01 Add the level within the set, to multiply it by three.
  $722F,$03 Rotate left three times, to multiply it by eight.
  $7232,$02,b$01 Keep only bits 3-6.
  $7234,$02 Add #N$2F, to get the height of the shelf.
  $7236,$03 Set the vertical co-ordinate to the height of the shelf.
N $7239 Use the ID and the colour of the ingredient for the level.
  $7239,$03 Point #REGhl at #R$6D7D.
  $723C,$02 Multiply the level within the set by two.
  $723E,$02 Set the high byte of the offset to #N$00.
  $7240,$01 Find the ingredient for the level.
  $7241,$01 Fetch the sprite ID of the ingredient.
  $7242,$03 Update the actor ID.
  $7245,$01 Move on to the colour.
  $7246,$01 Fetch the colour of the ingredient.
  $7247,$03 Update the actor colour.
N $724A Decide whether to make it one of the nasties.
  $724A,$03 Fetch the level of the active player.
  $724D,$06 Divide the level by eight, to get the set of levels.
  $7253,$01 Restore the slot counter from the stack.
  $7254,$04 Jump to #R$725A if the set is less than #N$04.
  $7258,$02 Limit the set to #N$04.
@ $725A label=CreateActor_TestNasty
  $725A,$01 Add #N$01.
  $725B,$01 Subtract the slot counter.
  $725C,$03 Jump to #R$7271 if this is an ingredient.
  $725F,$02 Fetch a random number.
  $7261,$02,b$01 Keep only bits 0-1.
  $7263,$02 Jump to #R$7266 if the result is not zero.
  $7265,$01 Increase #REGa by one, so it is in the range #N$01 to #N$03.
@ $7266 label=CreateActor_Nasty
  $7266,$02 Multiply the result by two.
  $7268,$02 Add #N$1C, to get the ID of the tack (#N$1E), the washer (#N$20) or
. the bolt (#N$22).
  $726A,$03 Update the actor ID.
  $726D,$04 Set the actor colour to #N$45 (cyan).
@ $7271 label=CreateActor_Draw
  $7271,$03 Draw the actor using #R$7617.
  $7274,$03 Create the monster using #R$67E2.
  $7277,$02 Jump to #R$7211.

b $7279 Actor Template
@ $7279 label=Template_NewActor
D $7279 The template for a new actor, which is copied into one of the six slots
. from #R$5F55 by #R$71D8. The ID, the vertical co-ordinate and the colour are
. replaced.
B $7279,$01 Actor ID.
B $727A,$01 Horizontal co-ordinate.
B $727B,$01 Vertical co-ordinate (replaced).
B $727C,$01 Colour.
B $727D,$01 Horizontal speed (-2).
B $727E,$01 Vertical speed.
B $727F,$01 Not used.
B $7280,$01 Not used.

c $7281 Handle Custard
@ $7281 label=HandleCustard
D $7281 The handler for the custard (IDs #N$04 and #N$05), which bounces around
. the play area diagonally. It is moved by #R$72A3. While the custard is still
. entering from the right of the screen (a horizontal co-ordinate of #N$C8 or
. more) it can't hit Charlie or be hit, and it is given a random vertical
. speed.
R $7281 IX Actor
  $7281,$03 Record the position of the sprite using #R$76D0.
  $7284,$03 Point #REGhl at #R$5F1B.
  $7287,$01 Increase the number of actors in play by one.
  $7288,$03 Fetch the horizontal co-ordinate.
  $728B,$04 Jump to #R$7302 if the custard is still entering from the right.
  $728F,$03 Test whether the custard has hit Charlie using #R$6A46.
  $7292,$01 Has Charlie been hit (is #REGe now zero)?
  $7293,$03 Jump to #R$6A73 if Charlie has been hit.
  $7296,$03 Test whether a flour shot has hit the custard using #R$7317.
  $7299,$06 Jump to #R$730D if the custard has been hit.
  $729F,$04 Set the actor colour to #N$46 (yellow).

c $72A3 Move Bouncing Actor
@ $72A3 label=MoveBouncingActor
D $72A3 Moves the actor by the speeds in bytes #N$04 and #N$05 of the actor,
. changing them to #N$02 or #N$FE (-2) when the actor reaches the edge of the
. play area. Bit 0 of byte #N$06 is set while the actor is moving down, and
. bit 1 is set while it is moving right. The ID of the actor is changed
. between its two frames, and the sprite is then drawn in its new position.
R $72A3 IX Actor
  $72A3,$03 Fetch the vertical co-ordinate.
  $72A6,$03 Add the vertical speed.
  $72A9,$04 Jump to #R$72DA if the actor has reached the top.
  $72AD,$04 Jump to #R$72EE if the actor has reached the bottom.
  $72B1,$03 Update the vertical co-ordinate.
@ $72B4 label=MoveBouncingActor_Horizontal
  $72B4,$03 Fetch the horizontal co-ordinate.
  $72B7,$03 Add the horizontal speed.
  $72BA,$03 Update the horizontal co-ordinate.
  $72BD,$04 Jump to #R$72E4 if the actor has reached the left edge.
  $72C1,$04 Jump to #R$72F8 if the actor has reached the right edge.
@ $72C5 label=MoveBouncingActor_Animate
  $72C5,$03 Increase the frame counter (byte #N$07 of the actor) by one.
  $72C8,$03 Fetch the frame counter.
  $72CB,$01 Shift #REGa right.
  $72CC,$02,b$01 Keep only bit 0.
  $72CE,$03 Flip bit 0 of the actor ID if bit 1 of the frame counter is set.
  $72D1,$03 Update the actor ID.
@ $72D4 label=MoveBouncingActor_Draw
  $72D4,$03 Erase the sprite and draw it in its new position using #R$75CC.
  $72D7,$03 Jump to #R$74EE to colour the sprite.
N $72DA The actor has reached the top, so make it move down.
@ $72DA label=MoveBouncingActor_Top
  $72DA,$04 Set the vertical speed to #N$02 (moving down).
  $72DE,$04 Set bit 0 of byte #N$06 of the actor.
  $72E2,$02 Jump to #R$72B4.
N $72E4 The actor has reached the left edge, so make it move right.
@ $72E4 label=MoveBouncingActor_LeftEdge
  $72E4,$04 Set the horizontal speed to #N$02 (moving right).
  $72E8,$04 Set bit 1 of byte #N$06 of the actor.
  $72EC,$02 Jump to #R$72C5.
N $72EE The actor has reached the bottom, so make it move up.
@ $72EE label=MoveBouncingActor_Bottom
  $72EE,$04 Set the vertical speed to #N$FE (moving up).
  $72F2,$04 Reset bit 0 of byte #N$06 of the actor.
  $72F6,$02 Jump to #R$72B4.
N $72F8 The actor has reached the right edge, so make it move left.
@ $72F8 label=MoveBouncingActor_RightEdge
  $72F8,$04 Set the horizontal speed to #N$FE (moving left).
  $72FC,$04 Reset bit 1 of byte #N$06 of the actor.
  $7300,$02 Jump to #R$72C5.

c $7302 Set Custard Vertical Speed
@ $7302 label=SetCustardVerticalSpeed
D $7302 Part of #R$7281, used while the custard is still entering from the
. right of the screen. Gives the actor a random vertical speed (#N$02 or #N$FE),
. and then only moves it horizontally.
R $7302 IX Actor
  $7302,$02 Fetch a random number.
  $7304,$02,b$01 Keep only bit 2.
  $7306,$02 Subtract #N$02, so that the speed is #N$FE or #N$02.
  $7308,$03 Update the vertical speed.
  $730B,$02 Jump to #R$72B4.

c $730D Handle Hit Actor
@ $730D label=HandleHitActor
D $730D Moves an actor which has been hit by a flour shot using #R$6E25. If the
. actor has not been removed then it is drawn in its new position.
R $730D IX Actor
  $730D,$03 Move the actor using #R$6E25.
  $7310,$03 Fetch the actor ID.
  $7313,$01 Has the actor been removed?
  $7314,$01 Return if it has.
  $7315,$02 Jump to #R$72D4.

c $7317 Test Flour Collision
@ $7317 label=TestFlourCollision
D $7317 Tests whether the actor has been hit by a flour shot (they are in the
. two actor slots after Charlie). A shot is within range if it is between #N$0A
. pixels to the left and #N$12 pixels to the right of the actor, and between
. #N$12 pixels above and #N$0A pixels below it. If it is then the actor is
. coloured white, bit 7 of its ID is set and the counter in byte #N$07 is set
. to #N$40. The speeds of the shot are copied to the actor, the shot is made to
. explode, and the rising tone is played.
R $7317 IX Actor
  $7317,$03 Set the size of an actor to #N$0008.
  $731A,$03 Point #REGhl at #R$5F3D.
  $731D,$02 Set the slot counter to #N$02 (the number of slots for flour shots).
@ $731F label=TestFlourCollision_Loop
  $731F,$01 Stash the address of the slot on the stack.
  $7320,$01 Fetch the actor ID of the slot.
  $7321,$01 Is the slot empty?
  $7322,$02 Jump to #R$734E if it is.
  $7324,$04 Jump to #R$734E if the shot has exploded.
  $7328,$01 Move on to the horizontal co-ordinate of the shot.
  $7329,$01 Fetch the horizontal co-ordinate of the shot.
  $732A,$03 Subtract the horizontal co-ordinate of the actor.
  $732D,$03 Jump to #R$7336 if the shot is to the right of the actor.
  $7330,$02 Make the distance positive.
  $7332,$02 Set the distance which is allowed to the left to #N$0A.
  $7334,$02 Jump to #R$7338.
@ $7336 label=TestFlourCollision_Right
  $7336,$02 Set the distance which is allowed to the right to #N$12.
@ $7338 label=TestFlourCollision_Horizontal
  $7338,$01 Compare the distance with the distance which is allowed.
  $7339,$02 Jump to #R$734E if the shot is too far away.
  $733B,$01 Move on to the vertical co-ordinate of the shot.
  $733C,$01 Fetch the vertical co-ordinate of the shot.
  $733D,$03 Subtract the vertical co-ordinate of the actor.
  $7340,$03 Jump to #R$7349 if the shot is below the actor.
  $7343,$02 Make the distance positive.
  $7345,$02 Set the distance which is allowed above to #N$12.
  $7347,$02 Jump to #R$734B.
@ $7349 label=TestFlourCollision_Below
  $7349,$02 Set the distance which is allowed below to #N$0A.
@ $734B label=TestFlourCollision_Vertical
  $734B,$01 Compare the distance with the distance which is allowed.
  $734C,$02 Jump to #R$7353 if the shot has hit the actor.
@ $734E label=TestFlourCollision_Next
  $734E,$01 Restore the address of the slot from the stack.
  $734F,$01 Move on to the next slot.
  $7350,$02 Decrease the slot counter by one and loop back to #R$731F until
. both slots have been tried.
  $7352,$01 Return.
N $7353 The shot has hit the actor.
@ $7353 label=TestFlourCollision_Hit
  $7353,$04 Set the actor colour to #N$47 (white).
  $7357,$04 Set bit 7 of the actor ID.
  $735B,$04 Set the hit counter (byte #N$07 of the actor) to #N$40.
  $735F,$02 Move on to the horizontal speed of the shot.
  $7361,$01 Fetch the horizontal speed of the shot.
  $7362,$03 Update the horizontal speed of the actor.
  $7365,$01 Move on to the vertical speed of the shot.
  $7366,$01 Fetch the vertical speed of the shot.
  $7367,$03 Update the vertical speed of the actor.
  $736A,$01 Restore the address of the shot from the stack.
  $736B,$02 Save the pointer to the current actor on the stack.
  $736D,$01 Save the address of the shot on the stack.
  $736E,$02 Point #REGix at the shot.
  $7370,$03 Make the shot explode using #R$6FA4.
  $7373,$02 Restore the pointer to the current actor from the stack.
  $7375,$03 Jump to #R$683E to play the rising tone.

c $7378 Display Lives
@ $7378 label=DisplayPlayerLives
D $7378 Shows the number of lives which each of the players has, at the top of
. the screen; the number is followed by the icon for a life. If a player has no
. lives then their space is blanked. Charlie's last movement (#R$5F2B) is also
. reset to be #N$02 pixels to the right.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$6428,stop=$6457,sp=$5F00)
. #SIM(start=$5FED,stop=$5FF0,sp=$5F00)
. #SCR$04,$00,$00,$0C,$02(display-lives-before)
. | #SIM(start=$7378,stop=$0000,sp=$5E00)
. #SCR$04,$00,$00,$0C,$02(display-lives-after) } UDGTABLE# #POPS
E $7378 View the equivalent code in;
. #LIST
. { #JETPAC$70A4 }
. { #LUNARJETMAN$894F }
. { #PSSST$7325 }
. { #SABREWULF$B7CD }
. { #TRANZAM$687B }
. LIST#
  $7378,$06 Write #N($0002, $04, $04) to #R$5F2B (Charlie's last movement).
@ $737E label=DisplayPlayerLives_1UP
N $737E Controller for 1UP lives.
  $737E,$06 Call #R$76E3 with #N($0040, $04, $04) (the pixel co-ordinates for
. the 1UP lives) to get the screen address.
  $7384,$03 Fetch the lives of 1UP using #R$73BD.
  $7387,$03 If 1UP lives are zero, jump to #R$73A6.
  $738A,$03 Else, there are lives to display so call #R$7399.
N $738D Controller for 2UP lives.
@ $738D label=Controller2UPLives
  $738D,$06 Call #R$76E3 with #N($00B0, $04, $04) (the pixel co-ordinates for
. the 2UP lives) to get the screen address.
  $7393,$03 Fetch the lives of 2UP using #R$73CB.
  $7396,$03 If 2UP lives are zero, jump to #R$73AB.
N $7399 Handles displaying the lives count and UDG character.
@ $7399 label=HandlerDisplayLives
  $7399,$02 Add #N$30 to convert to an ASCII character (starting at "0").
  $739B,$03 Print the digit using #R$7468.
  $739E,$03 Point #REGde at the lives icon (#R$73B5).
  $73A1,$02 Stash #REGbc and #REGde on the stack.
  $73A3,$03 Jump to #R$7478 to print the icon.
N $73A6 1UP has no lives.
@ $73A6 label=Handler1UPNoLives
  $73A6,$03 Print two spaces using #R$73AB.
  $73A9,$02 Jump to #R$738D.
N $73AB 2UP has no lives.
@ $73AB label=Handler2UPNoLives
  $73AB,$02 Fetch a space.
  $73AD,$03 Print the space using #R$7468.
  $73B0,$02 Fetch a space.
  $73B2,$03 Print a second space using #R$7468.

b $73B5 The UDG for the lives icon
@ $73B5 label=UDG_Life
D $73B5 The icon for a life, which is printed after the number of lives.
B $73B5,$08,b$01 #UDGTABLE(default,centre) { #UDG#(#PC),attr=$07 } UDGTABLE#

c $73BD Fetch 1UP Lives
@ $73BD label=FetchLives_1UP
D $73BD Returns the number of lives which the 1UP player has.
R $73BD O:A Lives
  $73BD,$06 If #R$5F21 is not zero then jump to #R$73C7.
N $73C3 Return currently active players lives left.
@ $73C3 label=ActivePlayerLives
  $73C3,$03 Fetch the lives of the active player.
  $73C6,$01 Return.
N $73C7 Return inactive players lives left.
@ $73C7 label=InactivePlayerLives
  $73C7,$03 Fetch the lives of the inactive player.
  $73CA,$01 Return.

c $73CB Fetch 2UP Lives
@ $73CB label=FetchLives_2UP
D $73CB Returns the number of lives which the 2UP player has.
R $73CB O:A Lives
  $73CB,$06 If #R$5F21 is zero then jump to #R$73C7.
  $73D1,$02 Jump to #R$73C3.

c $73D3 Check High Score
@ $73D3 label=CheckHighScore
D $73D3 Finds which of the 1UP score and the 2UP score is higher, and if it is
. higher than the high score (#R$5F09) then it becomes the new high score.
E $73D3 View the equivalent code in;
. #LIST
. { #JETPAC$6398 }
. { #TRANZAM$605B }
. LIST#
  $73D3,$03 Fetch the first two bytes of the 1UP score.
  $73D6,$04 Fetch the first two bytes of the 2UP score.
  $73DA,$06 Swap the bytes of #REGhl and #REGde, so the most significant byte of
. each is first.
  $73E0,$03 Subtract the 2UP score from the 1UP score.
  $73E3,$02 Jump to #R$73F1 if the 2UP score is higher.
  $73E5,$02 Jump to #R$7410 if the 1UP score is higher.
  $73E7,$08 Compare #R$5F10 against #R$5F13.
  $73EF,$02 Jump to #R$7410 if the 1UP score is higher.
@ $73F1 label=CheckHighScore_2UP
  $73F1,$03 Point #REGhl at the 2UP score.
@ $73F4 label=CheckHighScore_Compare
  $73F4,$01 Stash the address of the score on the stack.
  $73F5,$03 Point #REGde at #R$5F09.
  $73F8,$02 Set the byte counter to #N$03 (scores are held in three bytes).
@ $73FA label=CheckHighScore_Loop
  $73FA,$01 Fetch a byte of the high score.
  $73FB,$01 Compare with the same byte of the score.
  $73FC,$02 Jump to #R$7406 if the high score is lower.
  $73FE,$02 Jump to #R$7404 if the high score is higher.
  $7400,$01 Move on to the next byte of the score.
  $7401,$01 Move on to the next byte of the high score.
  $7402,$02 Decrease the byte counter by one and loop back to #R$73FA until all
. of the bytes have been compared.
@ $7404 label=CheckHighScore_Finish
  $7404,$01 Restore the address of the score from the stack.
  $7405,$01 Return.
N $7406 The high score has been beaten.
@ $7406 label=CheckHighScore_New
  $7406,$01 Restore the address of the score from the stack.
  $7407,$03 Point #REGde at #R$5F09.
  $740A,$03 Set the number of bytes to copy to #N$0003.
  $740D,$02 Copy the score to the high score.
  $740F,$01 Return.
@ $7410 label=CheckHighScore_1UP
  $7410,$03 Point #REGhl at the 1UP score.
  $7413,$02 Jump to #R$73F4.

c $7415 Add Points To Score
@ $7415 label=AddPointsToScore
D $7415 Adds points to the score of the active player, and then prints that
. score.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #N$0250 points }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$62B5,stop=$62BC,sp=$5F00)
. #SCR$04,$00,$00,$0A,$02(add-points-before)
. | #SIM(start=$7415,stop=$0000,bc=$0250,sp=$5E00)
. #SCR$04,$00,$00,$0A,$02(add-points-after) } UDGTABLE# #POPS
E $7415 View the equivalent code in;
. #LIST
. { #ATICATAC$A19C }
. { #BUBBLER$9662 }
. { #CYBERUN$925E }
. { #JETPAC$70F9 }
. { #LUNARJETMAN$899C }
. { #MARTIANOIDS$B573 }
. { #NIGHTSHADE$C2ED }
. { #PENTAGRAM$BB29 }
. { #PSSST$737A }
. { #SABREWULF$B5A9 }
. { #TRANZAM$6046 }
. { #UNDERWURLDE$A045 }
. LIST#
R $7415 BC Points to add to score (in BCD)
N $7415 Check the active player.
  $7415,$06 If #R$5F21 is not zero, jump to #R$7420.
N $741B Set the score address for 1UP.
  $741B,$03 Point #REGhl at the last byte of the 1UP score.
  $741E,$02 Jump to #R$7423.
N $7420 Set the score address for 2UP.
@ $7420 label=AddPointsToScore_2UP
  $7420,$03 Point #REGhl at the last byte of the 2UP score.
N $7423 Process adding the points to the appropriate score.
@ $7423 label=AddPointsToScore_Start
  $7423,$01 Fetch the last byte of the score.
  $7424,$02 Add the points in #REGc (in BCD).
  $7426,$01 Update the last byte of the score.
  $7427,$01 Move on to the middle byte of the score.
  $7428,$01 Fetch the middle byte of the score.
  $7429,$02 Add the points in #REGb (in BCD), with the carry.
  $742B,$01 Update the middle byte of the score.
  $742C,$01 Move on to the first byte of the score.
  $742D,$01 Fetch the first byte of the score.
  $742E,$03 Add the carry (in BCD).
  $7431,$01 Update the first byte of the score.
N $7432 Check the active player.
  $7432,$06 If #R$5F21 is not zero, jump to #R$7440.

c $7438 Print Scores
@ $7438 label=Score_1UP
D $7438 Prints a score, as six digits, on the screen. This routine is entered
. at #R$7438 to print the 1UP score, at #R$7440 to print the 2UP score and at
. #R$7448 to print the high score.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$62B5,stop=$62BC,sp=$5F00)
. #SCR$02,$00,$00,$20,$02(print-scores-before) }
. { =h After }
. { #POKES$5F0F,$12;$5F10,$50;$5F0A,$99;$5F0B,$50;$5F12,$08
. #SIM(start=$7438,stop=$0000,sp=$5E00)
. #SIM(start=$7440,stop=$0000,sp=$5E00)
. #SIM(start=$7448,stop=$0000,sp=$5E00)
. #SCR$02,$00,$00,$20,$02(print-scores-after) } UDGTABLE# #POPS
E $7438 View the equivalent code in;
. #LIST
. { #ATICATAC$A1AE }
. { #JETPAC$711C }
. { #LUNARJETMAN$89BF }
. { #PSSST$739D }
. { #SABREWULF$B5CC }
. { #TRANZAM$6CB6 }
. LIST#
N $7438 Sets up the 1UP score.
  $7438,$03 Set the screen buffer address for the 1UP score (#N$4021).
  $743B,$03 Point #REGde at #R$5F0E.
  $743E,$02 Jump to #R$744E.

N $7440 Sets up the 2UP score.
@ $7440 label=Score_2UP
  $7440,$03 Set the screen buffer address for the 2UP score (#N$4039).
  $7443,$03 Point #REGde at #R$5F11.
  $7446,$02 Jump to #R$744E.

N $7448 Sets up the HI score.
@ $7448 label=Score_HI
  $7448,$03 Set the screen buffer address for the HI score (#N$402D).
  $744B,$03 Point #REGde at #R$5F09.

N $744E Prints the score.
@ $744E label=PrintScore
  $744E,$02 Set the byte counter to #N$03.
@ $7450 label=PrintScore_Loop
  $7450,$01 Fetch a byte of the score.
  $7451,$04 Shift the tens digit down (divide by #N$10).
  $7455,$02,b$01 Keep only bits 0-3.
  $7457,$02 Convert the digit to ASCII (add #N$30, which is "0").
  $7459,$03 Print the digit using #R$7468.
  $745C,$01 Fetch the byte of the score again.
  $745D,$02,b$01 Keep only bits 0-3.
  $745F,$02 Convert the digit to ASCII (add #N$30, which is "0").
  $7461,$03 Print the digit using #R$7468.
  $7464,$01 Move on to the next byte of the score.
  $7465,$02 Decrease the byte counter by one and loop back to #R$7450 until all
. three bytes have been printed.
  $7467,$01 Return.

c $7468 Print Character
@ $7468 label=PrintScreen
D $7468 Prints a character on the screen, using the character set at #N$5C36
. (CHARS), as eight rows of pixels. The screen address is then moved on by one
. column, ready to print the next character.
E $7468 View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #MARTIANOIDS$B5CB }
. { #NIGHTSHADE$CB19 }
. { #PSSST$73CD }
. { #SABREWULF$B589 }
. { #TRANZAM$6C96 }
. { #UNDERWURLDE$98DF }
. LIST#
R $7468 A ASCII value to print
R $7468 HL Screen address
R $7468 O:HL Screen address of the next character
  $7468,$03 Save the registers on the stack.
  $746B,$03 Create an offset in #REGhl.
  $746E,$03 Multiply by #N$08, as there are eight bytes for each character.
  $7471,$04 Fetch the address of the font (#SKOOLKID$5C36(CHARS)).
  $7475,$02 #REGde=#REGhl + #N$3C00. For examples of usage;
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Letter | =h ASCII Value | =h * 8 (offset) | =h CHARS + offset }
. #FOREACH($55,$4C,$54,$49,$4D,$41,$54,$45)(value,
. { #LET(result=$3C00 + value * $08) "#CHR(value)" | #N(value) | #N(value * 8) | #SKOOLKID($3D00,{result})(#N({result})) }
. )
. TABLE#
N $7477 Print the character to the screen.
  $7477,$01 Restore #REGhl, containing the screen buffer location, from the stack.
@ $7478 label=PrintCharacter_Draw
  $7478,$02 Set the pixel row counter to #N$08 (#N$08 rows of pixels).
@ $747A label=PrintScreen_Loop
  $747A,$02 Copy a byte from the font data to the screen buffer.
  $747C,$01 Move on to the next byte of the font data.
  $747D,$01 Move onto the next pixel line.
  $747E,$02 Decrease the pixel row counter by one and loop back to #R$747A until
. all eight rows have been copied.
  $7480,$02 Restore the registers from the stack.
N $7482 Reset #REGhl and move to the next column, ready to print the next character.
  $7482,$04 Move back to the top pixel row of the character cell
. (subtract #N$08 from #REGh).
  $7486,$01 Increment screen column by one.
  $7487,$01 Return.

c $7488 Print Colour String
@ $7488 label=PrintStringColour
D $7488 Prints a string of text, in colour, at the given position. The first
. byte of the string is the colour attribute, followed by the characters of the
. text. The last character of the string has bit 7 set.
E $7488 View the equivalent code in;
. #LIST
. { #ATICATAC$A1F3 }
. { #JETPAC$716C }
. { #LUNARJETMAN$8A11 }
. { #PSSST$73ED }
. { #SABREWULF$B53D }
. { #TRANZAM$6518 }
. { #UNDERWURLDE$9C3C }
. LIST#
R $7488 DE Pointer to string data
R $7488 HL Pixel co-ordinates (horizontal in #REGl, vertical in #REGh)
  $7488,$01 Save the position of the string on the stack.
  $7489,$03 Convert the pixel co-ordinates into a screen buffer address using
. #R$76E3.
  $748C,$01 Fetch the attribute byte.
  $748D,$01 Switch to the shadow #REGaf register.
  $748E,$01 Move on to the text of the string.
  $748F,$01 Switch to the shadow registers.
  $7490,$01 Restore the position of the string from the stack.
  $7491,$03 Calculate the attribute buffer address using #R$7534.

@ $7494 label=PrintString_Loop
  $7494,$01 Switch back to the normal registers.
  $7495,$01 Fetch the character to print.
  $7496,$04 If bit 7 is set (which signifies the end of the string), jump to #R$74A5.
  $749A,$03 Print the character using #R$7468.
  $749D,$01 Move on to the next character of the string.
  $749E,$01 Switch to the shadow registers.
  $749F,$01 Switch to the shadow #REGaf register.
  $74A0,$01 Write the colour to the attribute buffer.
  $74A1,$01 Move on to the next attribute cell.
  $74A2,$01 Switch to the shadow #REGaf register.
  $74A3,$02 Jump to #R$7494.
N $74A5 Because the last character contains the terminator, it needs to be handled separately.
@ $74A5 label=PrintString_LastCharacter
  $74A5,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $74A7,$03 Print the last character using #R$7468.
  $74AA,$01 Switch to the shadow registers.
  $74AB,$01 Switch to the shadow #REGaf register.
  $74AC,$01 Write the colour to the attribute buffer.
  $74AD,$01 Return.

c $74AE Print Banner
@ $74AE label=PrintBanner
D $74AE Prints the "1UP", "HI" and "2UP" labels at the top of the screen.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$5FB7,stop=$5FBD,sp=$5F00)
. #SCR$02,$00,$00,$20,$01(print-banner-before) }
. { =h After }
. { #SIM(start=$74AE,stop=$0000,sp=$5E00)
. #SCR$02,$00,$00,$20,$01(print-banner-after) } UDGTABLE# #POPS
E $74AE View the equivalent code in;
. #LIST
. { #JETPAC$7192 }
. { #LUNARJETMAN$8A37 }
. { #PSSST$7413 }
. { #SABREWULF$B563 }
. LIST#
N $74AE Prints "1UP".
  $74AE,$03 Set the position of the "1UP" label to #N($0018, 4, 4).
  $74B1,$03 Point #REGde at #R$74C9.
  $74B4,$03 Print the "1UP" label using #R$7488.
N $74B7 Prints "HI".
  $74B7,$03 Set the position of the "HI" label to #N($0078, 4, 4).
  $74BA,$03 Point #REGde at #R$74D1.
  $74BD,$03 Print the "HI" label using #R$7488.
N $74C0 Prints "2UP".
  $74C0,$03 Set the position of the "2UP" label to #N($00D8, 4, 4).
  $74C3,$03 Point #REGde at #R$74CD.
  $74C6,$03 Print the "2UP" label using #R$7488.

t $74C9 Messaging: Banner Text
@ $74C9 label=1UP_Text
D $74C9 The text of the labels printed by #R$74AE. Each string starts with its
. colour attribute, and the last character has bit 7 set.
  $74C9,$04,h$01,$02:$01 "1UP" (#COLOUR(#PEEK(#PC)) is the attribute).
@ $74CD label=2UP_Text
  $74CD,$04,h$01,$02:$01 "2UP" (#COLOUR(#PEEK(#PC)) is the attribute).
@ $74D1 label=HI_Text
  $74D1,$03,h$01,$01:$01 "HI" (#COLOUR(#PEEK(#PC)) is the attribute).

c $74D4 Reset Screen Buffer
@ $74D4 label=ResetScreen
D $74D4 Clears the screen buffer by filling it with zero.
E $74D4 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE60 }
. { #ATICATAC$80B4 }
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
E $74D4 Continue on to #R$74DB to blank the screen buffer.
  $74D4,$03 Point #REGhl at the start of the screen buffer.
  $74D7,$02 Set the end of the screen buffer
. (#N$58, the start of the attributes).
@ $74D9 label=ResetScreen_Fill
  $74D9,$02 Set the byte to write to #N$00 (blank).

c $74DB Fill Memory
@ $74DB label=ResetCopier
D $74DB Writes the same byte to every address from the target address up to
. the end address.
E $74DB View the equivalent code in;
. #LIST
. { #ATICATAC$80BB }
. { #JETPAC$71BF }
. { #LUNARJETMAN$84B4 }
. { #PSSST$7440 }
. { #SABREWULF$BB88 }
. { #TRANZAM$7218 }
. LIST#
R $74DB HL Target address
R $74DB B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $74DB C Value to write
  $74DB,$01 Write the byte to the buffer.
  $74DC,$01 Move on to the next address.
  $74DD,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $74DF,$02 Keep looping back to #R$74DB until there is no carry-over.
  $74E1,$01 Return.

c $74E2 Reset Attribute Buffer
@ $74E2 label=ResetAttributes
D $74E2 Sets the border to black, and clears the attribute buffer by filling it
. with zero (black ink on a black paper).
E $74E2 View the equivalent code in;
. #LIST
. { #ATICATAC$80C2 }
. { #JETPAC$71C6 }
. { #LUNARJETMAN$84BB }
. { #PSSST$7447 }
. { #TRANZAM$7200 }
. LIST#
  $74E2,$03 Set the border to #INK$00.
  $74E5,$03 Point #REGhl at the start of the attribute buffer.
  $74E8,$02 Set the end of the attribute buffer (#N$5B).
  $74EA,$02 Set the byte to write to #N$00 (black).
  $74EC,$02 Jump to #R$74DB.

c $74EE Colour Sprite
@ $74EE label=ColourSprite
D $74EE Colours the character cells covered by the actor sprite prepared by
. #R$7584, using the colour in byte #N$03 of the actor. Cells outside of the
. attribute buffer, or to the right of the play area, are left alone.
R $74EE IX Actor
N $74EE Fetch the address of the first attribute cell, and the size of the
. area to colour.
  $74EE,$01 Switch to the shadow registers.
  $74EF,$03 Fetch the position of the actor sprite (#R$5F1F).
  $74F2,$03 Calculate the attribute buffer address using #R$7534.
  $74F5,$03 Fetch the width of the actor sprite (#R$5F18).
  $74F9,$03 Fetch the number of rows of the actor sprite (#R$5F17).
  $74FC,$02 Divide by #N$04 (rotating the bits).
  $74FE,$01 Increment #REGa by one.
  $74FF,$01 Divide by #N$02 (rotating the bits).
  $7500,$02,b$01 Keep only bits 0-4.
  $7502,$01 Increment #REGa by one.
  $7503,$01 Store the number of attribute rows to colour in #REGc.
  $7504,$03 Fetch the actor colour.
  $7507,$01 Store the number of columns in #REGe.
@ $7508 label=ColourSprite_Row
  $7508,$01 Stash the address of the start of the row on the stack.
@ $7509 label=ColourSprite_Column
  $7509,$01 Fetch the high byte of the attribute address.
  $750A,$02 Jump to #R$7526 if the address is beyond the end of the attribute
. buffer (#N$5B or higher).
  $750E,$02 Jump to #R$7526 if the address is before the start of the attribute
. buffer.
  $7512,$01 Fetch the low byte of the attribute address.
  $7513,$02,b$01 Keep only bits 0-4.
N $7515 #HTML(Self modifying code; the operand of this command is written by
. #R$5FE1(#N$5FF6) and #R$6D38(#N$6D49), and sets the column which the colouring
. stops at.)
  $7515,$04 Jump to #R$7526 if the column is beyond the right edge.
  $7519,$01 Write the colour to the attribute cell.
  $751A,$01 Move onto the next column.
  $751B,$01 Fetch the low byte of the attribute address.
  $751C,$02,b$01 Keep only bits 0-4.
  $751E,$02 Jump to #R$7524 if the row has not wrapped.
  $7520,$04 Move back to the start of the row so it doesn't wrap onto the next
. one.
@ $7524 label=ColourSprite_NextColumn
  $7524,$02 Decrease the column counter by one and loop back to #R$7509 until
. all of the columns have been done.
@ $7526 label=ColourSprite_NextRow
  $7526,$01 Retrieve the address of the start of the row.
  $7527,$01 Stash the row counter on the stack.
  $7528,$01 Clear the carry flag.
  $7529,$03 Set the size of a row of attributes to #N$0020.
  $752C,$02 Move up one row.
  $752E,$01 Restore the row counter.
  $752F,$01 Restore the column counter.
  $7530,$01 Decrease the row counter by one.
  $7531,$02 Loop back to #R$7508 until all of the rows have been done.
  $7533,$01 Return.

c $7534 Calculate Attribute Address
@ $7534 label=AttributeAddress
D $7534 Converts the pixel co-ordinates to the address of the attribute buffer
. byte for the character cell containing them.
E $7534 View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #JETPAC$720E }
. { #LUNARJETMAN$8506 }
. { #PSSST$748F }
. { #SABREWULF$B8DD }
. { #TRANZAM$7097 }
. { #UNDERWURLDE$ADE0 }
. LIST#
R $7534 HL Pixel address co-ordinates
R $7534 O:HL Attribute buffer address
  $7534,$01 Fetch the horizontal co-ordinate.
  $7535,$03 Divide by #N$08 (to get the column).
  $7538,$02,b$01 Keep only bits 0-4 (#N$00-#N$1F, the range of the columns).
  $753A,$01 Store this back in #REGl.
  $753B,$01 Fetch the vertical co-ordinate.
  $753C,$02 Multiply by #N$04 (the row is the vertical co-ordinate divided by
. #N$08, and there are #N$20 columns in each row).
  $753E,$01 Store this in #REGc temporarily.
  $753F,$02,b$01 Keep only bits 5-7.
  $7541,$01 Combine with the column in #REGl.
  $7542,$01 Store this back in #REGl.
  $7543,$01 Fetch the stored value from #REGc.
  $7544,$02,b$01 Keep only bits 0-1.
  $7546,$02,b$01 Set the MSB of the attribute buffer address (#N$58). This
. ensures that the address is at least #N$5800.
  $7548,$01 Store this in #REGh.
  $7549,$01 Return.

c $754A Clip Sprite
@ $754A label=ClipSprite
D $754A The vertical co-ordinate is the bottom edge of a sprite. This stops
. sprites being drawn below the play area, which ends at #N$9F.
R $754A H Vertical co-ordinate
R $754A O:C The number of pixel rows which are below the play area
R $754A O:H The vertical co-ordinate (limited to #N$9F)
  $754A,$01 Fetch the vertical co-ordinate.
  $754B,$02 Subtract #N$9F (the bottom of the play area).
  $754D,$03 Jump to #R$7554 if the sprite is above the bottom of the play area.
  $7550,$02 Limit the vertical co-ordinate to #N$9F.
  $7552,$01 Keep the number of rows to clip in #REGc.
  $7553,$01 Return.
@ $7554 label=ClipSprite_Visible
  $7554,$02 Flag that no rows need to be clipped (#REGc=#N$00).
  $7556,$01 Return.

c $7557 Prepare Old Sprite
@ $7557 label=PrepareOldSprite
D $7557 Gets everything ready to draw (or erase) the sprite at the position
. which was last recorded by #R$76D0. Sprites are drawn using the exclusive OR
. operation, so drawing a sprite for a second time erases it.
E $7557 View the equivalent code in;
. #LIST
. { #TRANZAM$70B2 }
. LIST#
.
. The number of rows which can be drawn is written to #R$5F19. The shifting
. routine at #R$7671 is set up to move the sprite right by the horizontal
. co-ordinate MOD #N$08 pixels.
R $7557 O:C #N$00
R $7557 O:DE Address of the first row of sprite data to draw
R $7557 O:HL Screen address of the bottom row of the sprite
  $7557,$03 Fetch the address of the recorded sprite using #R$7623.
@ $755A label=PrepareOldSprite_Position
  $755A,$03 Fetch the recorded position (#R$5F14).
  $755D,$01 Fetch the horizontal co-ordinate.
  $755E,$01 Decrease #REGa by one.
  $755F,$01 Multiply by #N$02.
  $7560,$02,b$01 Keep only bits 1-3.
  $7562,$04 Jump to #R$7568 if this is not the maximum offset.
  $7566,$02 Use the offset which jumps to the code for sprites which are aligned
. to a character cell.
@ $7568 label=PrepareOldSprite_Shift
N $7568 Self modifying code; this updates the operand of the JR command at
. #R$766D(#N$767A).
  $7568,$03 Write the offset to #R$766D(#N$767B).
  $756B,$03 Clip the sprite using #R$754A.
  $756E,$03 Convert the position into a screen address using #R$76E3.
  $7571,$01 Fetch the height of the sprite.
  $7572,$01 Subtract the number of rows which are not visible.
  $7573,$02 Jump to #R$7576 if there are any rows to draw.
  $7575,$01 There are no rows to draw.
@ $7576 label=PrepareOldSprite_Rows
  $7576,$03 Set the number of rows of the old sprite to draw (#R$5F19).
  $7579,$02 Multiply the number of hidden rows by #N$02 (as there are two bytes
. in each row).
  $757B,$02 #REGb=#N$00.
  $757D,$03 Skip the hidden rows in the sprite data.
@ $7580 label=PrepareSprite_Finish
  $7580,$02 #REGc=#N$00.
  $7582,$01 Move past the height byte.
  $7583,$01 Return.

c $7584 Prepare Actor Sprite
@ $7584 label=PrepareActorSprite
D $7584 Does the same as #R$7557 for the sprite of the actor in #REGix. As well
. as the screen address, it records the address of the first attribute cell in
. #R$5F1F, the width in character cells in #R$5F18 and the number of rows to
. draw in #R$5F1A and #R$5F17. This is set up for the shifting routine at
. #R$76AF.
E $7584 View the equivalent code in;
. #LIST
. { #TRANZAM$70D2 }
. LIST#
R $7584 IX Actor
R $7584 O:C #N$00
R $7584 O:DE Address of the first row of sprite data to draw
R $7584 O:HL Screen address of the bottom row of the sprite
  $7584,$03 Fetch the address of the actor sprite using #R$7635.
@ $7587 label=PrepareActorSprite_Position
  $7587,$03 Fetch the horizontal co-ordinate of the actor.
  $758A,$03 Fetch the vertical co-ordinate of the actor.
  $758D,$01 Fetch the horizontal co-ordinate.
  $758E,$01 Decrease #REGa by one.
  $758F,$01 Multiply by #N$02.
  $7590,$02,b$01 Keep only bits 1-3.
  $7592,$04 Jump to #R$7598 if this is not the maximum offset.
  $7596,$02 Use the offset which jumps to the code for sprites which are aligned
. to a character cell.
@ $7598 label=PrepareActorSprite_Shift
N $7598 Self modifying code; this updates the operand of the JR command at
. #R$76AB(#N$76B8).
  $7598,$03 Write the offset to the JR command at #R$76AB(#N$76B9).
N $759B A sprite which is aligned to a character cell is two cells wide,
. otherwise it is three cells wide.
  $759B,$02 Set the width to #N$02.
  $759D,$02 Jump to #R$75A0 if the sprite is aligned to a character cell.
  $759F,$01 Set the width to #N$03.
@ $75A0 label=PrepareActorSprite_Width
  $75A0,$03 Write the width to the actor sprite width (#R$5F18).
  $75A3,$03 Clip the sprite using #R$754A.
  $75A6,$03 Save the position of the actor sprite (#R$5F1F).
  $75A9,$03 Convert the position into a screen address using #R$76E3.
  $75AC,$01 Fetch the height of the sprite.
  $75AD,$01 Subtract the number of rows which are not visible.
  $75AE,$02 Jump to #R$75B1 if there are any rows to draw.
  $75B0,$01 There are no rows to draw.
@ $75B1 label=PrepareActorSprite_Rows
  $75B1,$03 Set the number of rows of the actor sprite to draw (#R$5F1A).
  $75B4,$03 Set the number of rows of the actor sprite on the screen (#R$5F17).
  $75B7,$02 Set the high byte of the offset to #N$00.
  $75B9,$02 Multiply the number of hidden rows by #N$02.
  $75BB,$03 Skip the hidden rows in the sprite data.
  $75BE,$02 Jump to #R$7580 to finish.

u $75C0 Unused Move Sprite Without Fetch
@ $75C0 label=Unused_MoveSprite_NoFetch
D $75C0 Not used by the game. It is like #R$75CC, but skips the code which
. finds the data for the sprites (#R$7623 and #R$7635), by entering the
. routines which prepare the sprites after that code. It then carries on at
. #R$75D3.
C $75C0,$01 Stash #REGde on the stack.
C $75C1,$03 Call #R$755A (part of #R$7557).
C $75C4,$01 Switch to the shadow registers.
C $75C5,$01 Restore #REGde from the stack.
C $75C6,$03 Call #R$7587 (part of #R$7584).
C $75C9,$01 Switch to the normal registers.
C $75CA,$02 Jump to #R$75D3.

c $75CC Display Entity
@ $75CC label=DisplayEntity
D $75CC Erases the sprite from the position recorded by #R$76D0 and draws it at
. the new position held by the actor. The old and the new sprite are processed
. together so that the screen lines which they share are updated in step.
E $75CC View the equivalent code in;
. #LIST
. { #ATICATAC$9FCA }
. { #JETPAC$726A }
. { #PSSST$74EB }
. { #SABREWULF$B9A9 }
. { #TRANZAM$7101 }
. { #TRANZAM$7108 }
. { #UNDERWURLDE$96F7 }
. LIST#
R $75CC IX Actor
N $75CC #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$6428,stop=$6457,sp=$5F00)
. #SIM(start=$5FE1,stop=$6001,sp=$5F00)
. #SIM(start=$7617,stop=$0000,ix=$5F35,sp=$5E00)
. #SIM(start=$74EE,stop=$0000,ix=$5F35,sp=$5E00)
. #SCR$04,$08,$0A,$0A,$08(sprite-move-before) |
. #SIM(start=$76D0,stop=$0000,ix=$5F35,sp=$5E00)
. #POKES$5F36,$70
. #SIM(start=$75CC,stop=$0000,ix=$5F35,sp=$5E00)
. #SIM(start=$74EE,stop=$0000,ix=$5F35,sp=$5E00)
. #SCR$04,$08,$0A,$0A,$08(sprite-move-after) } UDGTABLE# #POPS
  $75CC,$03 Prepare the actor sprite using #R$7584.
  $75CF,$01 Switch to the shadow registers.
  $75D0,$03 Prepare the old sprite using #R$7557.
N $75D3 Compare the vertical position of the old sprite with the new one.
@ $75D3 label=DisplayEntity_Compare
  $75D3,$03 Fetch the vertical co-ordinate of the old sprite (#R$5F15).
  $75D6,$03 Subtract the new vertical co-ordinate.
  $75D9,$03 Jump to #R$7654 if they are the same.
  $75DC,$03 Jump to #R$75EE if the new sprite is lower down the screen.
N $75DF The old sprite is lower down. Draw the rows of it which the new sprite
. does not cover first.
  $75DF,$01 Keep the number of rows in #REGc.
  $75E0,$03 Fetch the sprite rows remaining.
  $75E3,$01 Compare with the number of rows.
  $75E4,$03 Jump to #R$7654 if the sprites do not overlap.
  $75E7,$01 Subtract the rows which are about to be drawn.
  $75E8,$03 Update the number of rows remaining for the old sprite (#R$5F19).
  $75EB,$03 Jump to #R$763A.
@ $75EE label=DisplayEntity_NewLower
N $75EE The new sprite is lower down. Draw the rows of it which the old sprite
. does not cover first.
  $75EE,$01 Switch to the shadow registers.
  $75EF,$02 Make the number of rows positive.
  $75F1,$01 Keep the number of rows in #REGc.
  $75F2,$03 Fetch the number of rows remaining for the actor sprite (#R$5F1A).
  $75F5,$01 Compare with the number of rows.
  $75F6,$03 Jump to #R$7653 if the sprites do not overlap.
  $75F9,$01 Subtract the rows which are about to be drawn.
  $75FA,$03 Jump to #R$7667.

u $75FD Unused Sprite Entry Points
@ $75FD label=Unused_SpriteEntryPoints
D $75FD Not used by the game. These are versions of #R$7617 and #R$7607 which
. skip the code that finds the data for the sprite, for use when #REGde already
. holds the address of the sprite data.
N $75FD Draws the sprite of the actor, without fetching the sprite data.
C $75FD,$03 Call #R$7587 (part of #R$7584).
C $7600,$02 Jump to #R$761A.
N $7602 Erases the sprite at the recorded position, without fetching the sprite
. data.
C $7602,$03 Call #R$755A (part of #R$7557).
C $7605,$02 Jump to #R$760A.

c $7607 Remove Entity
@ $7607 label=RemoveEntity
D $7607 Erases the sprite at the position recorded by #R$76D0.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$6428,stop=$6457,sp=$5F00)
. #SIM(start=$5FE1,stop=$6001,sp=$5F00)
. #SIM(start=$7617,stop=$0000,ix=$5F35,sp=$5E00)
. #SIM(start=$74EE,stop=$0000,ix=$5F35,sp=$5E00)
. #SIM(start=$76D0,stop=$0000,ix=$5F35,sp=$5E00)
. #SCR$04,$08,$0A,$0A,$08(remove-entity-before)
. | #SIM(start=$7607,stop=$0000,ix=$5F35,sp=$5E00)
. #SCR$04,$08,$0A,$0A,$08(remove-entity-after) } UDGTABLE# #POPS
E $7607 View the equivalent code in;
. #LIST
. { #JETPAC$72A5 }
. { #PSSST$7526 }
. { #SABREWULF$B8F5 }
. { #TRANZAM$7139 }
. { #UNDERWURLDE$9636 }
. LIST#
  $7607,$03 Prepare the recorded sprite using #R$7557.
@ $760A label=RemoveEntity_Fetched
  $760A,$01 Switch to the shadow registers.
  $760B,$01 #REGa=#N$00.
  $760C,$01 #REGc=#N$00.
  $760D,$03 Write #N$00 to #R$5F1A.
  $7610,$03 Write #N$00 to #R$5F17.
  $7613,$01 Switch to the normal registers.
  $7614,$03 Jump to #R$763A.

c $7617 Draw Entity
@ $7617 label=DrawEntity
D $7617 Draws the sprite of the actor in #REGix at its current position.
E $7617 View the equivalent code in;
. #LIST
. { #ATICATAC$9F4A }
. { #JETPAC$72B5 }
. { #SABREWULF$B919 }
. { #TRANZAM$7149 }
. { #UNDERWURLDE$962A }
. LIST#
R $7617 IX Actor
N $7617 #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$6298,stop=$62B5,clear=1,sp=$5F00)
. #POKES$5F0D,$01
. #SIM(start=$6428,stop=$6457,sp=$5F00)
. #SIM(start=$5FE1,stop=$6001,sp=$5F00)
. #SCR$04,$08,$0A,$0A,$08(sprite-draw-before) |
. #SIM(start=$7617,stop=$0000,ix=$5F35,sp=$5E00)
. #SIM(start=$74EE,stop=$0000,ix=$5F35,sp=$5E00)
. #SCR$04,$08,$0A,$0A,$08(sprite-draw-after) } UDGTABLE# #POPS
  $7617,$03 Prepare the actor sprite using #R$7584.
@ $761A label=DrawEntity_Fetched
  $761A,$01 Switch to the shadow registers.
  $761B,$01 #REGa=#N$00.
  $761C,$03 Write #N$00 to #R$5F19.
  $761F,$01 #REGc=#N$00.
  $7620,$03 Jump to #R$763A.

c $7623 Fetch Sprite
@ $7623 label=FetchSprite
D $7623 Looks up the address of a sprite graphic in the table at #R$7702. This
. entry point uses the sprite ID which was last recorded by #R$76D0.
E $7623 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$8568 }
. { #TRANZAM$7155 }
. { #UNDERWURLDE$9646 }
. LIST#
R $7623 O:DE The sprite memory address
  $7623,$03 Fetch the sprite ID of the recorded sprite (#R$5F16).
@ $7626 label=GetSprite
  $7626,$01 Decrease the sprite ID by one, as the table starts at ID #N$01.
  $7627,$01 Multiply by 2 as the table contains addresses.
  $7628,$02,b$01 Keep only bits 1-6.
  $762A,$03 Point #REGhl at the sprite table (#R$7702).
  $762D,$04 Calculate the lookup address (#REGhl + offset).
  $7631,$03 #REGde=fetch sprite address pointed to by #REGhl.
  $7634,$01 Return.

N $7635 Fetch the sprite for the actor, rather than the recorded sprite.
@ $7635 label=FetchActorSprite
R $7635 IX Actor
R $7635 O:DE The sprite memory address
  $7635,$03 Load the sprite ID from the currently active actor.
  $7638,$02 Jump to #R$7626.

c $763A XOR Sprite Loop
@ $763A label=XORSpriteLoop
D $763A Draws the old sprite and the new sprite one row at a time, using the
. row counters in #REGc and #REGc' (in the normal and the shadow register sets).
. When the counters are used up, any rows remaining in #R$5F19 and #R$5F1A
. are drawn.
E $763A View the equivalent code in;
. #LIST
. { #ATICATAC$9E9B }
. { #LUNARJETMAN$858E }
. { #SABREWULF$B9DA }
. { #UNDERWURLDE$9728 }
. LIST#
  $763A,$01 Fetch the row counter.
  $763B,$01 Is it zero?
  $763C,$02 Jump to #R$764E if there are no rows to draw.
  $763E,$01 Decrease the row counter by one.
  $763F,$03 Draw a row of the old sprite using #R$7671.
  $7642,$01 Switch to the shadow registers.
  $7643,$01 Fetch the row counter.
  $7644,$01 Is it zero?
  $7645,$02 Jump to #R$764B if there are no rows to draw.
@ $7647 label=XORSpriteLoop_Actor
  $7647,$01 Decrease the row counter by one.
  $7648,$03 Draw a row of the actor sprite using #R$76AF.
@ $764B label=XORSpriteLoop_Next
  $764B,$01 Switch to the normal registers.
  $764C,$02 Jump to #R$763A.
@ $764E label=XORSpriteLoop_Swap
  $764E,$01 Switch to the shadow registers.
  $764F,$01 Fetch the row counter.
  $7650,$01 Is it zero?
  $7651,$02 Jump to #R$7647 if there are more rows to draw.
@ $7653 label=XORSpriteLoop_Restore
  $7653,$01 Switch to the normal registers.
@ $7654 label=XORSpriteLoop_Remaining
N $7654 Fetch the number of rows left over from the old sprite and the new
. sprite. If there are none then the drawing is finished.
  $7654,$04 Fetch the sprite rows remaining and keep the old sprite rows
. remaining in #REGc.
  $7658,$03 Fetch the actor sprite rows remaining (#R$5F1A).
  $765B,$01 Combine the counters.
  $765C,$01 Return if there are no rows left to draw.
  $765D,$01 Set #REGa to #N$00.
  $765E,$03 Update the old sprite rows remaining (#R$5F19).
  $7661,$01 Switch to the shadow registers.
  $7662,$04 Fetch the actor sprite rows remaining (#R$5F1A) and keep it in
. #REGc.
  $7666,$01 Set #REGa to #N$00.
@ $7667 label=XORSpriteLoop_Continue
  $7667,$03 Update the actor sprite rows remaining (#R$5F1A).
  $766A,$01 Switch to the normal registers.
  $766B,$02 Jump to #R$763A.

c $766D Draw Old Sprite Row
@ $766D label=DrawOldSpriteRow_Aligned
D $766D Draws one row of the sprite prepared by #R$7557 by exclusive ORing it
. onto the screen, then moves on to the row above.
R $766D DE Address of the sprite data
R $766D HL Screen address
R $766D O:DE Address of the next row of sprite data
R $766D O:HL Screen address of the row above
N $766D The entry point for a sprite which is aligned to a character cell.
  $766D,$01 #REGde=the row of sprite data, and #REGhl=the address of the next
. row.
  $766E,$01 #REGhl=the screen address, and the address of the next row of sprite
. data is stored on the stack.
  $766F,$02 Jump to #R$768F.
@ $7671 label=DrawOldSpriteRow
N $7671 The entry point for a sprite which is not aligned to a character cell.
  $7671,$01 Stash the screen address on the stack.
  $7672,$01 #REGhl=the address of the sprite data, and #REGde=the screen
. address.
  $7673,$01 Stash the screen address on the stack again.
  $7674,$01 #REGd=the first byte of the row.
  $7675,$01 Move to the next byte of sprite data.
  $7676,$01 #REGe=the second byte of the row.
  $7677,$01 Move on to the next row of sprite data.
  $7678,$01 #REGhl=the row of sprite data, and #REGde=the address of the next
. row.
  $7679,$01 #REGa=#N$00.
N $767A #HTML(Self modifying code; the operand of this command is written by
. #R$7557(#N$7568). It jumps into the sequence of shifts below, so that the row
. is moved right by the right number of pixels.)
@ $767A label=DrawOldSpriteRow_Shift
  $767A,$02 Jump to the first shift to do.
N $767C Shift the row left by up to seven bits; the bits which are shifted out
. of the row end up in #REGa.
  $767C,$02 Shift #REGhl left by one, moving the bit shifted out into #REGa.
L $767C,$02,$07
  $768A,$01 #REGde=the shifted row, and #REGhl=the address of the next row of
. sprite data.
  $768B,$01 #REGhl=the screen address, and the address of the next row of sprite
. data is stored on the stack.
  $768C,$01 Exclusive OR the first byte (in #REGa) onto the screen.
  $768D,$01 Write the result to the screen.
  $768E,$01 Move to the next byte on the screen.
@ $768F label=DrawSpriteRow_Write
  $768F,$01 Fetch the second byte.
  $7690,$01 Exclusive OR it onto the screen.
  $7691,$01 Write the result to the screen.
  $7692,$01 Move to the next byte on the screen.
  $7693,$01 Fetch the third byte.
  $7694,$01 Exclusive OR it onto the screen.
  $7695,$01 Write the result to the screen.
  $7696,$01 #REGde=the address of the next row of sprite data.
  $7697,$01 #REGhl=the screen address of the row which was just drawn.
N $7698 Move up one pixel row on the screen.
  $7698,$01 Move up one pixel row on the screen (decrease #REGh by one).
  $7699,$01 Fetch the high byte of the screen address.
  $769A,$01 Flip the bits.
  $769B,$02,b$01 Keep only bits 0-2.
  $769D,$01 Return if still inside the same character row.
  $769E,$01 Fetch the low byte of the screen address.
  $769F,$02 Subtract #N$20 to move up a character row.
  $76A1,$01 Update the low byte of the screen address.
  $76A2,$01 Flip the bits.
  $76A3,$02,b$01 Keep only bits 5-7.
  $76A5,$01 Return if still inside the same third of the screen.
  $76A6,$01 Fetch the high byte of the screen address.
  $76A7,$02 Add #N$08.
  $76A9,$01 Update the high byte of the screen address.
  $76AA,$01 Return.

c $76AB Draw Actor Sprite Row
@ $76AB label=DrawActorSpriteRow_Aligned
D $76AB Does the same as #R$766D, but for the sprite prepared by #R$7584.
R $76AB DE Address of the sprite data
R $76AB HL Screen address
R $76AB O:DE Address of the next row of sprite data
R $76AB O:HL Screen address of the row above
N $76AB The entry point for a sprite which is aligned to a character cell.
  $76AB,$01 #REGde=the row of sprite data, and #REGhl=the address of the next
. row.
  $76AC,$01 #REGhl=the screen address, and the address of the next row of sprite
. data is stored on the stack.
  $76AD,$02 Jump to #R$768F.
@ $76AF label=DrawActorSpriteRow
N $76AF The entry point for a sprite which is not aligned to a character cell.
  $76AF,$01 Stash the screen address on the stack.
  $76B0,$01 #REGhl=the address of the sprite data, and #REGde=the screen
. address.
  $76B1,$01 Stash the screen address on the stack again.
  $76B2,$01 #REGd=the first byte of the row.
  $76B3,$01 Move to the next byte of sprite data.
  $76B4,$01 #REGe=the second byte of the row.
  $76B5,$01 Move on to the next row of sprite data.
  $76B6,$01 #REGhl=the row of sprite data, and #REGde=the address of the next
. row.
  $76B7,$01 #REGa=#N$00.
N $76B8 Self modifying code; the operand of this command is written by
. #R$7584(#N$7598). It jumps into the sequence of shifts below, so that the row
. is moved right by the right number of pixels.
@ $76B8 label=DrawActorSpriteRow_Shift
  $76B8,$02 Jump to the first shift to do.
N $76BA Shift the row left by up to seven bits; the bits which are shifted out
. of the row end up in #REGa. The fourth shift is done with a longer command,
. but the jumps still land on the start of a shift.
  $76BA,$02 Shift #REGhl left by one, moving the bit shifted out into #REGa.
L $76BA,$02,$03
  $76C0,$03 Shift #REGhl left by one, moving the bit shifted out into #REGa.
  $76C3,$02 Shift #REGhl left by one, moving the bit shifted out into #REGa.
L $76C3,$02,$03
  $76C9,$01 #REGde=the shifted row, and #REGhl=the address of the next row of
. sprite data.
  $76CA,$01 #REGhl=the screen address, and the address of the next row of sprite
. data is stored on the stack.
  $76CB,$01 Exclusive OR the first byte (in #REGa) onto the screen.
  $76CC,$01 Write the result to the screen.
  $76CD,$01 Move to the next byte on the screen.
  $76CE,$02 Jump to #R$768F.

c $76D0 Store Entity
@ $76D0 label=StoreEntity
D $76D0 Copies the sprite ID and position of the actor into #R$5F14, so that
. when the actor is moved, #R$7557 knows where the old sprite has to be erased
. from.
E $76D0 View the equivalent code in;
. #LIST
. { #JETPAC$7327 }
. { #SABREWULF$BB0B }
. { #TRANZAM$71ED }
. { #UNDERWURLDE$989F }
. LIST#
R $76D0 IX Actor
  $76D0,$06 Copy the horizontal co-ordinate to #R$5F14.
  $76D6,$06 Copy the vertical co-ordinate to #R$5F15.
  $76DC,$06 Copy the sprite ID to #R$5F16.
  $76E2,$01 Return.

c $76E3 Calculate Screen Address
@ $76E3 label=ScreenAddress
D $76E3 Converts the pixel co-ordinates to the address in the screen buffer of
. the byte which contains that pixel.
E $76E3 View the equivalent code in;
. #LIST
. { #ATICATAC$9BA2 }
. { #JETPAC$7308 }
. { #LUNARJETMAN$851E }
. { #PSSST$759A }
. { #SABREWULF$B8AD }
. { #TRANZAM$6F10 }
. { #UNDERWURLDE$ADF8 }
. LIST#
R $76E3 HL Pixel co-ordinates (horizontal in #REGl, vertical in #REGh)
R $76E3 O:HL Screen address
  $76E3,$01 Fetch the horizontal co-ordinate.
  $76E4,$03 Divide by #N$08 (to get the column).
  $76E7,$02,b$01 Keep only bits 0-4.
  $76E9,$01 Store the column in #REGl.
  $76EA,$01 Fetch the vertical co-ordinate.
  $76EB,$02 #REGa=#REGa * #N$04.
  $76ED,$02,b$01 Keep only bits 5-7.
  $76EF,$01 Combine with the column in #REGl.
  $76F0,$01 Store the result in #REGl.
  $76F1,$01 Fetch the vertical co-ordinate.
  $76F2,$02,b$01 Keep only bits 0-2 (the pixel row within the character cell).
  $76F4,$01 Switch to the shadow #REGaf register to hold the pixel row.
  $76F5,$01 Fetch the vertical co-ordinate.
  $76F6,$03 Divide by #N$08 (to get the third of the screen).
  $76F9,$02,b$01 Keep only bits 3-4.
  $76FB,$02,b$01 Set bit 6.
  $76FD,$01 Store the result in #REGh.
  $76FE,$01 Switch to the shadow #REGaf register to fetch the pixel row.
  $76FF,$01 Combine with #REGh.
  $7700,$01 Store the result in #REGh.
  $7701,$01 Return.

w $7702 Sprite Table
@ $7702 label=SpritesTable
D $7702 Maps each sprite ID to the address of its graphic. The table starts at
. ID #N$01 (there is no ID #N$00), so the lookup in #R$7626 subtracts one
. before indexing the table. The same ID is also used as the index into the
. actor handler table at #R$6486, so an actor's ID selects both what is drawn
. and the code that moves it.
.
. Several IDs point at the same graphic. Where they do, the extra IDs are not
. extra frames.
E $7702 View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #LUNARJETMAN$BAC0 }
. { #PSSST$761A }
. { #SABREWULF$BF84 }
. { #TRANZAM$7F06 }
. LIST#
  $7702,$02 Sprite ID:
. #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100)(#N((#PC - $7702) / $02 + $01)).
L $7702,$02,$30

b $7762 Sprites: Cake
@ $7762 label=Sprite_Cake_1
D $7762 The five pieces of the cake (sprite IDs #N$2C to #N$30). They are drawn
. side by side to make a single cake.
N $7762 Piece 1.
  $7762,$01 Height = #N(#PEEK(#PC)) pixels.
  $7763,$20,$02 #SPRITE$2C(cake-01)

N $7783 Piece 2.
@ $7783 label=Sprite_Cake_2
  $7783,$01 Height = #N(#PEEK(#PC)) pixels.
  $7784,$20,$02 #SPRITE$2D(cake-02)

N $77A4 Piece 3.
@ $77A4 label=Sprite_Cake_3
  $77A4,$01 Height = #N(#PEEK(#PC)) pixels.
  $77A5,$20,$02 #SPRITE$2E(cake-03)

N $77C5 Piece 4.
@ $77C5 label=Sprite_Cake_4
  $77C5,$01 Height = #N(#PEEK(#PC)) pixels.
  $77C6,$20,$02 #SPRITE$2F(cake-04)

N $77E6 Piece 5.
@ $77E6 label=Sprite_Cake_5
  $77E6,$01 Height = #N(#PEEK(#PC)) pixels.
  $77E7,$20,$02 #SPRITE$30(cake-05)

b $7807 Sprites: Batter
@ $7807 label=Sprite_Batter_1
D $7807 The four frames of the batter (sprite IDs #N$28 to #N$2B). The first
. frame is also pointed at by sprite IDs #N$06, #N$07, #N$0A, #N$0B, #N$0F and
. #N$16 to #N$19.
E $7807 #UDGTABLE(default) {
. #FRAMES(batter-01,50;batter-02;batter-03;batter-04)(batter) } UDGTABLE#
N $7807 Frame 1.
  $7807,$01 Height = #N(#PEEK(#PC)) pixels.
  $7808,$14,$02 #SPRITE$28(batter-01*)

N $781C Frame 2.
@ $781C label=Sprite_Batter_2
  $781C,$01 Height = #N(#PEEK(#PC)) pixels.
  $781D,$14,$02 #SPRITE$29(batter-02*)

N $7831 Frame 3.
@ $7831 label=Sprite_Batter_3
  $7831,$01 Height = #N(#PEEK(#PC)) pixels.
  $7832,$14,$02 #SPRITE$2A(batter-03*)

N $7846 Frame 4.
@ $7846 label=Sprite_Batter_4
  $7846,$01 Height = #N(#PEEK(#PC)) pixels.
  $7847,$14,$02 #SPRITE$2B(batter-04*)

b $785B Sprites: Flour Explosion
@ $785B label=Sprite_Explosion_1
D $785B The two frames of the explosion (sprite IDs #N$26 and #N$27) which is
. shown when a flour shot ends.
E $785B #UDGTABLE(default) {
. #FRAMES(explosion-02,50;explosion-01)(explosion) } UDGTABLE#
N $785B Frame 1.
  $785B,$01 Height = #N(#PEEK(#PC)) pixels.
  $785C,$10,$02 #SPRITE$26(explosion-01*)

N $786C Frame 2.
@ $786C label=Sprite_Explosion_2
  $786C,$01 Height = #N(#PEEK(#PC)) pixels.
  $786D,$16,$02 #SPRITE$27(explosion-02*)

b $7883 Sprites: Charlie the Chef
@ $7883 label=Sprite_Charlie_1
D $7883 The two walking frames (sprite IDs #N$01 and #N$02) are twenty pixels
. tall, and include Charlie's hat. The three sprites which follow them are used
. when Charlie loses a life; the hat, the body without the hat, and Charlie
. falling.
E $7883 #UDGTABLE(default) {
. #FRAMES(charlie-01,50;charlie-02)(charlie) } UDGTABLE#
N $7883 Frame 1.
  $7883,$01 Height = #N(#PEEK(#PC)) pixels.
  $7884,$28,$02 #SPRITE$01(charlie-01*)

N $78AC Frame 2.
@ $78AC label=Sprite_Charlie_2
  $78AC,$01 Height = #N(#PEEK(#PC)) pixels.
  $78AD,$28,$02 #SPRITE$02(charlie-02*)

N $78D5 The hat (sprite ID #N$0D).
@ $78D5 label=Sprite_Hat_1
  $78D5,$01 Height = #N(#PEEK(#PC)) pixels.
  $78D6,$0C,$02 #SPRITE$0D(charlie-hat)

N $78E2 Charlie without his hat (sprite ID #N$0C).
@ $78E2 label=Sprite_Hatless_1
  $78E2,$01 Height = #N(#PEEK(#PC)) pixels.
  $78E3,$1C,$02 #SPRITE$0C(charlie-hatless)

N $78FF Charlie falling (sprite ID #N$0E).
@ $78FF label=Sprite_Falling_1
  $78FF,$01 Height = #N(#PEEK(#PC)) pixels.
  $7900,$1C,$02 #SPRITE$0E(charlie-falling)

b $791C Sprite: Flour Bag
@ $791C label=Sprite_Flour_1
D $791C The flour which Charlie throws (sprite ID #N$03).
  $791C,$01 Height = #N(#PEEK(#PC)) pixels.
  $791D,$16,$02 #SPRITE$03(flour)

b $7933 Sprites: Colonel Custard
@ $7933 label=Sprite_Custard_1
D $7933 The two frames of Colonel Custard (sprite IDs #N$04 and #N$05), which
. is the ingredient for level 1.
E $7933 #UDGTABLE(default) {
. #FRAMES(custard-02,50;custard-01)(custard) } UDGTABLE#
N $7933 Frame 1.
  $7933,$01 Height = #N(#PEEK(#PC)) pixels.
  $7934,$1A,$02 #SPRITE$04(custard-01*)

N $794E Frame 2.
@ $794E label=Sprite_Custard_2
  $794E,$01 Height = #N(#PEEK(#PC)) pixels.
  $794F,$1E,$02 #SPRITE$05(custard-02*)

b $796D Sprites: Chunky Chocolate
@ $796D label=Sprite_Chocolate_1
D $796D The two frames of Chunky Chocolate (sprite IDs #N$10 and #N$11), which
. is the ingredient for level 3.
E $796D #UDGTABLE(default) {
. #FRAMES(chocolate-01,50;chocolate-02)(chocolate) } UDGTABLE#
N $796D Frame 1.
  $796D,$01 Height = #N(#PEEK(#PC)) pixels.
  $796E,$20,$02 #SPRITE$10(chocolate-01*)

N $798E Frame 2.
@ $798E label=Sprite_Chocolate_2
  $798E,$01 Height = #N(#PEEK(#PC)) pixels.
  $798F,$20,$02 #SPRITE$11(chocolate-02*)

b $79AF Sprites: Sneaky Sugar
@ $79AF label=Sprite_Sugar_1
D $79AF The two frames of Sneaky Sugar (sprite IDs #N$08 and #N$09), which is
. the ingredient for level 2.
E $79AF #UDGTABLE(default) {
. #FRAMES(sugar-01,50;sugar-02)(sugar) } UDGTABLE#
N $79AF Frame 1.
  $79AF,$01 Height = #N(#PEEK(#PC)) pixels.
  $79B0,$1E,$02 #SPRITE$08(sugar-01*)

N $79CE Frame 2.
@ $79CE label=Sprite_Sugar_2
  $79CE,$01 Height = #N(#PEEK(#PC)) pixels.
  $79CF,$1E,$02 #SPRITE$09(sugar-02*)

b $79ED Sprites: Mixed Peel
@ $79ED label=Sprite_Peel_1
D $79ED The two frames of Mixed Peel (sprite IDs #N$14 and #N$15), which is the
. ingredient for level 5.
E $79ED #UDGTABLE(default) {
. #FRAMES(peel-01,50;peel-02)(peel) } UDGTABLE#
N $79ED Frame 1.
  $79ED,$01 Height = #N(#PEEK(#PC)) pixels.
  $79EE,$1E,$02 #SPRITE$14(peel-01*)

N $7A0C Frame 2.
@ $7A0C label=Sprite_Peel_2
  $7A0C,$01 Height = #N(#PEEK(#PC)) pixels.
  $7A0D,$1C,$02 #SPRITE$15(peel-02*)

b $7A29 Sprites: Crafty Cheese
@ $7A29 label=Sprite_Cheese_1
D $7A29 The two frames of Crafty Cheese (sprite IDs #N$12 and #N$13), which is
. the ingredient for level 4.
E $7A29 #UDGTABLE(default) {
. #FRAMES(cheese-01,50;cheese-02)(cheese) } UDGTABLE#
N $7A29 Frame 1.
  $7A29,$01 Height = #N(#PEEK(#PC)) pixels.
  $7A2A,$22,$02 #SPRITE$12(cheese-01*)

N $7A4C Frame 2.
@ $7A4C label=Sprite_Cheese_2
  $7A4C,$01 Height = #N(#PEEK(#PC)) pixels.
  $7A4D,$22,$02 #SPRITE$13(cheese-02*)

b $7A6F Sprite: Bernie Bolt
@ $7A6F label=Sprite_Bolt_1
D $7A6F Used by sprite IDs #N$22 and #N$23.
  $7A6F,$01 Height = #N(#PEEK(#PC)) pixels.
  $7A70,$20,$02 #SPRITE$22(bolt)

b $7A90 Sprite: Wally Washer
@ $7A90 label=Sprite_Washer_1
D $7A90 Used by sprite IDs #N$20 and #N$21.
  $7A90,$01 Height = #N(#PEEK(#PC)) pixels.
  $7A91,$20,$02 #SPRITE$20(washer)

b $7AB1 Sprite: Terry Tack
@ $7AB1 label=Sprite_Tack_1
D $7AB1 Used by sprite IDs #N$1E and #N$1F.
  $7AB1,$01 Height = #N(#PEEK(#PC)) pixels.
  $7AB2,$20,$02 #SPRITE$1E(tack)

b $7AD2 Sprite: Mike The Pike
@ $7AD2 label=Sprite_Pike_1
D $7AD2 Used by sprite IDs #N$1A and #N$1B.
  $7AD2,$01 Height = #N(#PEEK(#PC)) pixels.
  $7AD3,$20,$02 #SPRITE$1A(pike)

b $7AF3 Sprite: Tin Tin Can
@ $7AF3 label=Sprite_Tin_Can_1
D $7AF3 Used by sprite IDs #N$1C and #N$1D.
  $7AF3,$01 Height = #N(#PEEK(#PC)) pixels.
  $7AF4,$20,$02 #SPRITE$1C(tin-can)

b $7B14 Sprites: Bin Monster
@ $7B14 label=Sprite_Monster_1
D $7B14 The two frames of the bin monster (sprite IDs #N$24 and #N$25).
E $7B14 #UDGTABLE(default) {
. #FRAMES(monster-01,50;monster-02)(monster) } UDGTABLE#
N $7B14 Frame 1.
  $7B14,$01 Height = #N(#PEEK(#PC)) pixels.
  $7B15,$1A,$02 #SPRITE$24(monster-01*)

N $7B2F Frame 2.
@ $7B2F label=Sprite_Monster_2
  $7B2F,$01 Height = #N(#PEEK(#PC)) pixels.
  $7B30,$1A,$02 #SPRITE$25(monster-02*)

b $7B4A Cupboard Graphic
@ $7B4A label=CupboardGraphic
D $7B4A The #N$60 tiles which the pantry is drawn from. #R$6017 sets
. #SKOOLKID$5C36(CHARS) to this address, so that printing a character draws the
. tile with the same ID as the character code.
N $7B4A ID: "#EVAL((#PC - $7B4A) / $08)".
  $7B4A,b,$01 #UDG(#PC)
L $7B4A,$08,$60

b $7E4A Unused Copy Of Code
@ $7E4A label=Unused_CodeCopy
D $7E4A Not used by the game. Apart from the last byte, these bytes are a copy
. of the bytes from #R$7562 to #N$7716.
B $7E4A,$01B6,$08


i $8000
b $B800
i $B801
