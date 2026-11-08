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
D $4000 #UDGTABLE { =h PSSST Loading Screen } { #SCR$02(loading) } UDGTABLE#
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

@ $5B00 replace=/#DIMENSIONS/Dimensions #EVAL(#PEEK(#PC + $01) * $08) pixels x #EVAL(#PEEK(#PC + $02), $0A, $02) pixels.
@ $5B00 expand=#DEF(#FONT(id) #EVAL($7B4A + $id * $08))

c $5B80 Game Entry Point
@ $5B80 label=GameEntry
D $5B80 Moves the whole game image down by one byte, then jumps to the
. security check. The #N$2114 bytes from #N$5EED up to the end of the game
. at #N$7FFF are copied to #N$5EEC onwards.
E $5B80 View the equivalent code in;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #TRANZAM$5B80 }
. { #UNDERWURLDE$67F2 }
. LIST#
E $5B80 Later Ultimate games use more advanced decryption mechanisms;
. #LIST
. { #ATICATAC$5B80 }
. { #LUNARJETMAN$5B80 }
. LIST#
  $5B80,$01 Disable interrupts.
  $5B81,$0B Copy #N$2114 bytes of the game from #N$5EED to #N$5EEC.
  $5B8C,$03 Jump to #R$61C6.

i $5B8F

c $5CB0 Indirect Jump
@ $5CB0 label=IndirectJump
D $5CB0 Jumps to the routine whose address is held in #REGhl.
E $5CB0 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$5CB0 }
. { #LUNARJETMAN$5CB0 }
. { #SABREWULF$5CB0 }
. LIST#
R $5CB0 HL Jump address
  $5CB0,$01 Jump to the address held in #REGhl.

g $5CB1 Stack
@ $5CB1 label=Stack
D $5CB1 The game's stack. The stack pointer is set to #N$5D00 by #R$61EA and
. #R$634F and the stack grows downwards from there. The bytes held here in
. the snapshot are left over from the BASIC loader.
B $5CB1,$4F,$10

u $5D00 Unused
@ $5D00 label=Unused_After_Stack
D $5D00 Not used by the game. The bytes held here in the snapshot are left
. over from the BASIC loader.

g $5E00 High Score
@ $5E00 label=High_Score
D $5E00 3-byte representation of the score.
E $5E00 View the equivalent code in;
. #LIST
. { #COOKIE$5F09 }
. { #JETPAC$5CF0 }
. { #LUNARJETMAN$5E06 }
. { #SABREWULF$B304 }
. { #TRANZAM$5E49 }
. LIST#

g $5E03 Game Options
@ $5E03 label=GameOptions
D $5E03 Holds the number of players and the chosen control method.
. #TABLE(default,centre,centre)
. { =h Byte | =h Binary | =h Option }
. { #N$00 | #EVAL($00, $02, $08) | 1UP Game + Keyboard }
. { #N$01 | #EVAL($01, $02, $08) | 2UP Game + Keyboard }
. { #N$02 | #EVAL($02, $02, $08) | 1UP Game + Kempston Joystick }
. { #N$03 | #EVAL($03, $02, $08) | 2UP Game + Kempston Joystick }
. TABLE#
E $5E03 View the equivalent code in;
. #LIST
. { #ATICATAC$5E00 }
. { #COOKIE$5F0C }
. { #JETPAC$5CF3 }
. { #LUNARJETMAN$5E00 }
. { #UNDERWURLDE$8ED5 }
. LIST#
N $5E03 "Number of Players" on Bit #N$00.
N $5E03 "Control Method" on Bit #N$01.

g $5E04 Sound Mute Flag
@ $5E04 label=Sound_Enable
D $5E04 Tunes are only played if this is #N$00, and are muted if it is not (see
. #R$66DF). It is set from the checksum of the BEEPER routine in the ROM,
. which is stored by #R$61E3.
B $5E04,$01

g $5E05 1UP Score
@ $5E05 label=1UP_Score_1
D $5E05 3-byte representation of the score.
B $5E05,$01 Byte #1.
@ $5E06 label=1UP_Score_2
B $5E06,$01 Byte #2.
@ $5E07 label=1UP_Score_3
B $5E07,$01 Byte #3.

g $5E08 2UP Score
@ $5E08 label=2UP_Score_1
D $5E08 3-byte representation of the score.
B $5E08,$01 Byte #1.
@ $5E09 label=2UP_Score_2
B $5E09,$01 Byte #2.
@ $5E0A label=2UP_Score_3
B $5E0A,$01 Byte #3.

g $5E0B Temporary Sprite State
@ $5E0B label=Actor
D $5E0B The saved position and state of the object which is being drawn, and the
. details of the sprites being drawn. The object position and state are saved
. by #R$75B9 and the sprite details are set by #R$74A5 and #R$74C0. #R$5E0F is
. also used as a dummy object when drawing the items in the cubby holes, so
. that #R$7450 can fetch the colour from #R$5E12.
  $5E0B,$01 Saved X position of the object.
  $5E0C,$01 Saved Y position of the object.
  $5E0D,$01 Saved state of the object.
  $5E0E,$01 Height of the new sprite in pixel rows (set by #R$74C0).
@ $5E0F label=NewSprite_Width
  $5E0F,$01 Width of the new sprite in bytes (set by #R$74C0).
  $5E10,$01 Rows of the previous sprite still to be erased.
  $5E11,$01 Rows of the new sprite still to be drawn.
  $5E12,$01 Colour attribute of the cubby hole item being drawn (set by
. #R$5FDE).

g $5E13 Bug Start Cubby Hole
@ $5E13 label=BugStart_CubbyHole
D $5E13 The number of the cubby hole that the next bug will start from, which is
. written by #R$7164 and read by #R$7262.
B $5E13,$01

u $5E14 Unused
@ $5E14 label=Unused_After_Bug_Start_Cubby_Hole
D $5E14 Not referenced by any code.

g $5E15 Leaf Growth Flags
@ $5E15 label=LeafGrowth_Flags
D $5E15 Used to grow the leaves of the flower (see #R$6C0E and #R$6D0C).
. #LIST
. { Bit 6 is flipped each time a leaf is added, so that the leaves alternate
. between the right and the left of the flower. }
. { Bit 0 is set when a leaf is added and is reset when the flower moves, to
. stop another leaf being added until then. }
. LIST#
B $5E15,$01

g $5E16 Bug Count
@ $5E16 label=CurrentBug_ID
D $5E16 The number of bugs found in the current pass through the objects. It is
. set to #N$00 at the start of each pass (#R$6358), added to by every bug that
. is updated (#R$64ED) and used by #R$7164 to decide whether a new bug should
. be added. The most there can be is #N$06.
B $5E16,$01

g $5E17 Game Timer
@ $5E17 label=GameTimer
D $5E17 A 16-bit counter which is increased by one at the end of every full pass
. through the objects (see #R$7145). It is used for timing, such as when leaves
. grow and when the bonus item flashes. It goes back to #N$0000 after
. #N$FFFF.
W $5E17,$02

g $5E19 Random Number
@ $5E19 label=RandomNumber
D $5E19 The random number is added to every time an object has been updated
. (#R$7130). At the end of each pass it is also added to the byte of the ROM
. at the address given by the low byte of the game timer, and to the refresh
. register (#R$7156).
B $5E19,$01

g $5E1A Sprite Screen Position
@ $5E1A label=SpritePosition
D $5E1A The position of the sprite most recently set up by #R$74C0 (X in
. #REGl, Y in #REGh), after the horizontal offset from the sprite data has
. been added.
W $5E1A,$02

g $5E1C Free Weapon Slot
@ $5E1C label=FreeWeaponSlot
D $5E1C The address of the first free weapon object, which is either #R$5E7C or
. #R$5E84 (each #N$08 bytes), set by #R$6B70.
W $5E1C,$02

g $5E1E Current Player
@ $5E1E label=Current_Player
D $5E1E Either #N$00 for 1UP or #N$FF for 2UP.
B $5E1E,$01

g $5E1F Last Frame
@ $5E1F label=LastFrame
D $5E1F Holds a copy of the last #SKOOLKID$5C78(FRAMES) counter.
B $5E1F,$01

g $5E20 Frame Updated
@ $5E20 label=FrameUpdated
D $5E20 Has the frame been updated? #N$00=No #N$01=Yes.
B $5E20,$01

g $5E21 Menu Item Attribute
@ $5E21 label=Current_MenuAttribute
D $5E21 Current menu item colour attribute.
B $5E21,$01

g $5E22 "Get Ready" Delay Counter
@ $5E22 label=PlayDelay_Counter
D $5E22 Counts down while Robbie waits at the start of a turn (set by #R$6191,
. to #N$80 for a 1UP game and #N$FF for a 2UP game), during which the label of
. the active player flashes and no bugs are added.
B $5E22,$01

g $5E23 Cubby Holes
@ $5E23 label=CubbyHoles
D $5E23 The contents of the ten cubby holes of the active player. Holes #N$00 to
. #N$04 are on the left (X position #N$08) and holes #N$05 to #N$09 are on the
. right (X position #N$E8), each going down the screen from the top.
. .
. An empty hole is #N$00. For a spray can, bits 0-2 are the colour and bit 3
. is set. A hole is #N$FF when a bonus item is waiting there (see #R$71BE) and
. is set to #N$80 when Robbie collects it.
B $5E23,$05,$01 Left-hand holes.
B $5E28,$05,$01 Right-hand holes.

g $5E2D Inactive Player Cubby Holes
@ $5E2D label=InactivePlayer_CubbyHoles
D $5E2D The cubby holes of the player who is not active in a two player game.
. They are swapped with the holes at #R$5E23 when the active player changes
. (see #R$6146).
B $5E2D,$0A,$01

g $5E37 Active Player Level
@ $5E37 label=ActivePlayer_Level
D $5E37 Note that level 1 is #N$00.
B $5E37,$01

g $5E38 Active Player Lives
@ $5E38 label=CurrentPlayer_Lives
D $5E38 The currently active players remaining lives.
B $5E38,$01

g $5E39 Inactive Player Level
@ $5E39 label=InactivePlayer_Level
D $5E39 Note that level 1 is #N$00.
B $5E39,$01

g $5E3A Inactive Player Lives
@ $5E3A label=InactivePlayer_Lives
D $5E3A The inactive players remaining lives.
B $5E3A,$01

g $5E3B Bugs Eating Flower
@ $5E3B label=BugsEating_Flower
D $5E3B The number of bugs which have been eating the flower during the current
. pass through the objects. Each bug that is eating adds one (#R$6B3A), and the
. flower uses the total and then resets it to #N$00 (#R$6D84).
B $5E3B,$01

g $5E3C Bonus Item State
@ $5E3C label=State_BonusItem
D $5E3C The bonus item, which sits in a cubby hole until Robbie collects it (see
. #R$71BE and #R$721A). It is an object which is not in the main table.
  $5E3C,$01 State: #N$00 when there is no bonus item, or the type #N$0B, #N$0C
. or #N$0D.
  $5E3D,$01 X position (#N$08 or #N$E8).
  $5E3E,$01 Y position.
  $5E3F,$01 Colour attribute (it flashes).
  $5E40,$01 What the cubby hole contains while the bonus item is waiting
. (#N$FF).
  $5E41,$01 The number of the cubby hole.
  $5E42,$02,$01 Not used.

g $5E44 Inactive Player Flower And Leaves
@ $5E44 label=InactivePlayer_Flower
D $5E44 The flower and the four leaves of the player who is not active in a two
. player game. They are swapped with the objects at #R$5E8C when the active
. player changes (see #R$6151).
  $5E44,$08,$01 Flower.
  $5E4C,$08,$01 Leaf 1.
  $5E54,$08,$01 Leaf 2.
  $5E5C,$08,$01 Leaf 3.
  $5E64,$08,$01 Leaf 4.

g $5E6C Robbie State
@ $5E6C label=State_Robbie_Active
D $5E6C Robbie is the first of the objects which are updated in each pass.
  $5E6C,$01 State: #N$00 inactive, #N$01 empty-handed or #N$02 carrying a can
. of pesticide.
@ $5E6D label=State_Robbie_Pos_X
  $5E6D,$01 X position.
@ $5E6E label=State_Robbie_Pos_Y
  $5E6E,$01 Y position.
@ $5E6F label=State_Robbie_Colour
  $5E6F,$01 Colour attribute.
@ $5E70 label=State_Robbie_Flags
  $5E70,$01 Flags: bit 0 is set when Robbie faces left, bit 2 is set while he
. cannot pick up an item and bit 3 is set when he has just picked up a can.
  $5E71,$01 Not used.
@ $5E72 label=State_Robbie_LastItem
  $5E72,$01 The last item that Robbie dropped, so that he does not pick it up
. again straight away.
  $5E73,$01 Not used.

g $5E74 Spray Can State
@ $5E74 label=State_SprayCan
D $5E74 The spray can which Robbie is carrying (see #R$6ED2).
  $5E74,$01 State: #N$00 inactive or #N$03 active.
  $5E75,$01 X position.
  $5E76,$01 Y position.
  $5E77,$01 Colour attribute.
  $5E78,$01 Bit 0 is set when the can is being put away in a cubby hole.
  $5E79,$01 New X position, which Robbie works out.
  $5E7A,$01 New Y position, which Robbie works out.
  $5E7B,$01 Not used.

g $5E7C Weapon 1 State
@ $5E7C label=State_Weapon_1
D $5E7C The first of the two weapons that Robbie can fire at once (see #R$6B70).
  $5E7C,$01 State: #N$00 inactive, or the type of weapon and its direction.
  $5E7D,$01 X position.
  $5E7E,$01 Y position.
  $5E7F,$01 Colour attribute.
  $5E80,$01 Age of a smoke bomb.
  $5E81,$01 Set when the weapon has hit a bug.
  $5E82,$02,$01 Not used.

g $5E84 Weapon 2 State
@ $5E84 label=State_Weapon_2
D $5E84 The second of the two weapons that Robbie can fire at once. It has the
. same fields as #R$5E7C.
  $5E84,$08,$01

g $5E8C Flower State
@ $5E8C label=State_Flower
D $5E8C The flower (see #R$6D0C).
  $5E8C,$01 State: #N$10 growing or #N$13 blooming.
@ $5E8D label=State_Flower_Pos_X
  $5E8D,$01 X position.
@ $5E8E label=State_Flower_Pos_Y
  $5E8E,$01 Y position.
@ $5E8F label=State_Flower_Colour
  $5E8F,$01 Colour attribute.
@ $5E90 label=State_Flower_Leaves
  $5E90,$01 The number of leaves on the flower.
  $5E91,$01 Timer until the flower next moves.
  $5E92,$01 The number of bugs seen eating the flower the last time.
  $5E93,$01 Not used.

g $5E94 Leaf Data
@ $5E94 label=Leaf_1_State
D $5E94 The four leaves of the flower (see #R$6C53). Each leaf is an object of
. eight bytes. Bit 6 of the state is set when the leaf is on the left of the
. flower. The other fields are the position, the colour, a flag which is set
. while the leaf is animating, a flag which is set once it is being eaten, and
. the frame.
N $5E94 Leaf 1 data.
  $5E94,$01 Leaf "1" state.
. #TABLE(default,centre,centre) { =h Value | =h State }
. { #N$00 | Inactive }
. { #N$11 | Right-hand side }
. { #N$51 | Left-hand side }
. TABLE#
@ $5E95 label=Leaf_1_Pos_X
  $5E95,$01 Leaf "1" X position in pixels.
@ $5E96 label=Leaf_1_Pos_Y
  $5E96,$01 Leaf "1" Y position in pixels.
@ $5E97 label=Leaf_1_Colour
  $5E97,$01 Leaf "1" colour attribute.
@ $5E98 label=Leaf_1_Animating
  $5E98,$01 Leaf "1" animating flag (#N$01 while it is growing or shrinking).
@ $5E99 label=Leaf_1_Eaten
  $5E99,$01 Leaf "1" eaten flag (#N$01 once the leaf is being eaten).
@ $5E9A label=Leaf_1_Frame
  $5E9A,$01 Leaf "1" frame ID.
  $5E9B,$01 Not used.

N $5E9C Leaf 2 data.
@ $5E9C label=Leaf_2_State
  $5E9C,$01 Leaf "2" state.
. #TABLE(default,centre,centre) { =h Value | =h State }
. { #N$00 | Inactive }
. { #N$11 | Right-hand side }
. { #N$51 | Left-hand side }
. TABLE#
@ $5E9D label=Leaf_2_Pos_X
  $5E9D,$01 Leaf "2" X position in pixels.
@ $5E9E label=Leaf_2_Pos_Y
  $5E9E,$01 Leaf "2" Y position in pixels.
@ $5E9F label=Leaf_2_Colour
  $5E9F,$01 Leaf "2" colour attribute.
@ $5EA0 label=Leaf_2_Animating
  $5EA0,$01 Leaf "2" animating flag (#N$01 while it is growing or shrinking).
@ $5EA1 label=Leaf_2_Eaten
  $5EA1,$01 Leaf "2" eaten flag (#N$01 once the leaf is being eaten).
@ $5EA2 label=Leaf_2_Frame
  $5EA2,$01 Leaf "2" frame ID.
  $5EA3,$01 Not used.

N $5EA4 Leaf 3 data.
@ $5EA4 label=Leaf_3_State
  $5EA4,$01 Leaf "3" state.
. #TABLE(default,centre,centre) { =h Value | =h State }
. { #N$00 | Inactive }
. { #N$11 | Right-hand side }
. { #N$51 | Left-hand side }
. TABLE#
@ $5EA5 label=Leaf_3_Pos_X
  $5EA5,$01 Leaf "3" X position.
@ $5EA6 label=Leaf_3_Pos_Y
  $5EA6,$01 Leaf "3" Y position.
@ $5EA7 label=Leaf_3_Colour
  $5EA7,$01 Leaf "3" colour attribute.
@ $5EA8 label=Leaf_3_Animating
  $5EA8,$01 Leaf "3" animating flag (#N$01 while it is growing or shrinking).
@ $5EA9 label=Leaf_3_Eaten
  $5EA9,$01 Leaf "3" eaten flag (#N$01 once the leaf is being eaten).
@ $5EAA label=Leaf_3_Frame
  $5EAA,$01 Leaf "3" frame ID.
  $5EAB,$01 Not used.

N $5EAC Leaf 4 data.
@ $5EAC label=Leaf_4_State
  $5EAC,$01 Leaf "4" state.
. #TABLE(default,centre,centre) { =h Value | =h State }
. { #N$00 | Inactive }
. { #N$11 | Right-hand side }
. { #N$51 | Left-hand side }
. TABLE#
@ $5EAD label=Leaf_4_Pos_X
  $5EAD,$01 Leaf "4" X position.
@ $5EAE label=Leaf_4_Pos_Y
  $5EAE,$01 Leaf "4" Y position.
@ $5EAF label=Leaf_4_Colour
  $5EAF,$01 Leaf "4" colour attribute.
@ $5EB0 label=Leaf_4_Animating
  $5EB0,$01 Leaf "4" animating flag (#N$01 while it is growing or shrinking).
@ $5EB1 label=Leaf_4_Eaten
  $5EB1,$01 Leaf "4" eaten flag (#N$01 once the leaf is being eaten).
@ $5EB2 label=Leaf_4_Frame
  $5EB2,$01 Leaf "4" frame ID.
  $5EB3,$01 Not used.

g $5EB4 Bug State
@ $5EB4 label=State_Bugs
D $5EB4 The six bugs, each an object of eight bytes. A bug is inactive (state
. #N$00) or is a slug (#N$07), a swarm of midges (#N$09) or a leech (#N$0A).
. The fields of a bug are:
. #TABLE(default,centre)
. { =h Field | =h Use }
. { +0 | State, with the direction of movement in bits 6 and 7 }
. { +1 | X position }
. { +2 | Y position }
. { +3 | Colour attribute }
. { +4 | Bit 2 is set when the bug is stunned, bit 3 when it is eating the
. flower and (for a leech) bit 0 when it is moving vertically }
. { +5 | The stun timer, the horizontal motion of midges or a counter used
. while eating }
. { +6 | The vertical movement counter, the vertical motion of midges or the
. Y position where the bug started eating }
. { +7 | The height of the sprite in pixels, used to find collisions }
. TABLE#
  $5EB4,$08,$01 Bug 1.
  $5EBC,$08,$01 Bug 2.
  $5EC4,$08,$01 Bug 3.
  $5ECC,$08,$01 Bug 4.
  $5ED4,$08,$01 Bug 5.
  $5EDC,$08,$01 Bug 6.

g $5EE4 Explosion State
@ $5EE4 label=State_Explosion
D $5EE4 The explosion, which is the last of the objects (see #R$65F7). It is
. state #N$15 (which does nothing) until an object explodes.
  $5EE4,$01 State: #N$15 inactive or #N$14 exploding.
  $5EE5,$01 X position.
  $5EE6,$01 Y position.
  $5EE7,$01 Colour attribute.
  $5EE8,$01 The frame of the explosion.
  $5EE9,$01 The mask which sets the speed of the explosion.
  $5EEA,$01 The state of the object which exploded, so that it can be put back.
  $5EEB,$01 Not used.

t $5EEC Messaging: Unused Text
@ $5EEC label=Unused_Text
D $5EEC Not referenced by any code. This is the end of the objects.
  $5EEC,$09 "COPYRIGHT"

t $5EF5 Messaging: Copyright
@ $5EF5 label=Message_Copyright
D $5EF5 The copyright message, which is printed on the game menu (see #R$6276).
E $5EF5 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$9174 }
. LIST#
  $5EF5,$21,h$01,c$01,$1E:$01 Attribute: #COLOUR(#PEEK(#PC)) + "© 1983 A.C.G. ALL RIGHTS RESERVED".

g $5F16 Default Bug State
@ $5F16 label=DefaultState_Bug
D $5F16 Copied into a bug when it is created (see #R$7262), which then changes
. its type and colour.
  $5F16,$01 State: #N$07 (a slug).
  $5F17,$02,$01 X and Y position.
  $5F19,$01 Colour attribute.
  $5F1A,$03,$01 Not used.
  $5F1D,$01 The height of the sprite in pixels.

g $5F1E Default Robbie State
@ $5F1E label=DefaultState_Robbie
D $5F1E Copied into Robbie at the start of a turn (see #R$6176).
  $5F1E,$01 State: #N$01 (empty-handed).
  $5F1F,$01 X position.
  $5F20,$01 Y position.
  $5F21,$01 Colour attribute (bright white).
  $5F22,$04,$01 Not used.

g $5F26 Default Flower State
@ $5F26 label=DefaultState_Flower
D $5F26 Copied into the flower at the start of a level (see #R$5F40).
  $5F26,$01 State: #N$10 (growing).
  $5F27,$01 X position.
  $5F28,$01 Y position.
  $5F29,$01 Colour attribute (bright white).
  $5F2A,$01 The number of leaves.
  $5F2B,$01 Timer until the flower next moves.
  $5F2C,$02,$01 Not used.

g $5F2E Default Cubby Holes
@ $5F2E label=DefaultState_CubbyHoles
D $5F2E Copied into the cubby holes at the start of a level (see #R$5FA0). Three
. of the holes hold a spray can: cyan in hole #N$00, yellow in hole #N$03 and
. red in hole #N$06.
  $5F2E,$0A,$01

g $5F38 Default Leaf State
@ $5F38 label=DefaultState_Leaf
D $5F38 Copied into a leaf when it starts to grow (see #R$6C0E).
  $5F38,$01 State: #N$11 (a leaf on the right of the flower).
  $5F39,$02,$01 X and Y position.
  $5F3B,$01 Colour attribute.
  $5F3C,$01 Animating flag (#N$01, so the leaf starts to grow).
  $5F3D,$03,$01 Not used.

c $5F40 Reset Flower And Leaves
@ $5F40 label=ResetFlowerLeaf
D $5F40 Restores the flower from its default state at #R$5F26 and sets the
. four leaf objects inactive.
  $5F40,$0B Copy #N$08 bytes of data from #R$5F26 to #R$5E8C.
  $5F4B,$03 #REGhl=#R$5E94 (the first leaf object).
  $5F4E,$02 Set the leaf counter to #N$04.
  $5F50,$03 Jump to #R$70D6 to set all four leaf objects inactive.

c $5F53 Create Game Window
@ $5F53 label=CreateWindow
D $5F53 Blanks the screen, draws the banner, colours the score line and
. prints the 1UP, 2UP and HI scores. The in-game text is drawn using the ROM
. character set, so the screenshots on this page and the others load the ROM
. and set #SKOOLKID$5C36(CHARS) to #N$3C00 (the snapshot does not hold the
. value that the ROM would have set).
E $5F53 View the equivalent code in;
. #LIST
. { #JETPAC$608A }
. { #LUNARJETMAN$84D8 }
. LIST#
N $5F53 #PUSHS #UDGTABLE { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$61EE,stop=$61F1,sp=$5D00)
. #SCR$02(game-window) } UDGTABLE# #POPS
N $5F53 Blank the screen and write the banner.
  $5F53,$03 Set the border to #INK$00.
  $5F56,$03 Blank the attribute buffer using #R$7447.
  $5F59,$03 Blank the screen buffer using #R$7439.
  $5F5C,$03 Print the "1UP", "HI" and "2UP" banner using #R$7413.
N $5F5F Set the attributes for the 1UP lives graphic.
  $5F5F,$03 Point #REGhl at the first cell of the 1UP lives graphic in the
. attribute buffer (#N$5808).
  $5F62,$02 Set the colour to #COLOUR$47.
  $5F64,$01 Colour the first cell of the 1UP lives graphic.
  $5F65,$01 Move onto the second cell.
  $5F66,$01 Colour the second cell of the 1UP lives graphic.
N $5F67 Set the attributes for the 2UP lives graphic.
  $5F67,$03 Point #REGhl at the first cell of the 2UP lives graphic in the
. attribute buffer (#N$5816).
  $5F6A,$01 Colour the first cell of the 2UP lives graphic.
  $5F6B,$01 Move onto the second cell.
  $5F6C,$01 Colour the second cell of the 2UP lives graphic.
N $5F6D Set the attributes for the score line (the whole line is #COLOUR$46).
  $5F6D,$03 Point #REGhl at the start of the score line in the attribute buffer
. (#N$5820).
  $5F70,$03 Set the column counter to #N$20 and the colour to #COLOUR$46.
@ $5F73 label=CreateWindow_Loop
  $5F73,$01 Colour a cell of the score line.
  $5F74,$01 Move onto the next column.
  $5F75,$02 Decrease the column counter by one and loop back to #R$5F73 until
. the whole score line has been coloured.
N $5F77 Print the three scores.
  $5F77,$03 Print the 1UP score using #R$739D.
  $5F7A,$03 Print the 2UP score using #R$73A5.
  $5F7D,$03 Jump to #R$73AD to print the HI score.

c $5F80 Initialise New Level
@ $5F80 label=LevelNew
D $5F80 Starts a new level for the active player: refills the cubby holes,
. resets the flower and leaves, sets up the player and then draws the game
. window ready for the level to start.
E $5F80 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$A826 }
. LIST#
N $5F80 #PUSHS #UDGTABLE { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$6339,stop=$634F,sp=$5D00)
. #SCR$02(new-level) } UDGTABLE# #POPS
N $5F80 Give the player a life, as #R$6176 is about to "spend" one.
  $5F80,$04 Increment #R$5E38 by one.
N $5F84 Reset the cubby holes, the flower and the leaves, then set up the
. player.
  $5F84,$03 Call #R$5FA0.
  $5F87,$03 Call #R$5F40.
  $5F8A,$03 Call #R$6176.
N $5F8D Draw the game window; this entry point is also used to continue the
. game after a turn.
@ $5F8D label=LevelInit
  $5F8D,$03 Create the game window using #R$5F53.
  $5F90,$03 Draw the play area using #R$602E.
  $5F93,$03 Draw the cubby hole items using #R$5FB0.
  $5F96,$03 Display the lives using #R$7325.
  $5F99,$06 Write #SKOOLKID$5C78(FRAMES) to #R$5E1F.
  $5F9F,$01 Return.

c $5FA0 Reset Cubby Holes
@ $5FA0 label=ResetCubbyHoles
D $5FA0 Copies the default contents of the ten cubby holes (five down each
. side of the play area) from #R$5F2E to #R$5E23, and cancels any bonus item
. object at #R$5E3C.
  $5FA0,$0B Copy #N$0A bytes of data from #R$5F2E to #R$5E23.
  $5FAB,$04 Write #N$00 to #R$5E3C.
  $5FAF,$01 Return.

c $5FB0 Draw Cubby Hole Items
@ $5FB0 label=DrawCubbyHoleItems
D $5FB0 Draws the contents of all ten cubby holes: first the five down the
. left-hand side (X position #N$08) and then the five down the right-hand side
. (X position #N$E8). Each hole is drawn by #R$5FDE.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$61EE,stop=$61F1,sp=$5D00)
. #SIM(start=$5F84,stop=$5F87,sp=$5D00)
. #SIM(start=$5F90,stop=$5F93,sp=$5D00)
. #SCR$01(cubby-items-before)
. | #SIM(start=$5F93,stop=$5F96,sp=$5D00)
. #SCR$01(cubby-items-after) } UDGTABLE# #POPS
  $5FB0,$02 Start with the first row of shelves by setting the row counter in
. #REGc to #N$01.
  $5FB2,$03 Point #REGde at the first cubby hole (#R$5E23).
N $5FB5 Draw the left-hand side.
@ $5FB5 label=DrawCubbyHoleItems_Left
  $5FB5,$02 Set the X position in #REGl to #N$08 (the left-hand side).
  $5FB7,$02 Stash #REGde and #REGbc on the stack.
  $5FB9,$03 Call #R$5FDE.
  $5FBC,$02 Restore #REGbc and #REGde from the stack.
  $5FBE,$01 Move onto the next cubby hole.
  $5FBF,$01 Increment the row counter by one.
  $5FC0,$05 Loop back to #R$5FB5 until all five cubby holes down the left-hand
. side have been drawn (the row counter reaches #N$06).
N $5FC5 Draw the right-hand side.
  $5FC5,$02 Reset the row counter in #REGc to #N$01 for the right-hand side.
@ $5FC7 label=DrawCubbyHoleItems_Right
  $5FC7,$02 Set the X position in #REGl to #N$E8 (the right-hand side).
  $5FC9,$02 Stash #REGde and #REGbc on the stack.
  $5FCB,$03 Call #R$5FDE.
  $5FCE,$02 Restore #REGbc and #REGde from the stack.
  $5FD0,$01 Move onto the next cubby hole.
  $5FD1,$01 Increment the row counter by one.
  $5FD2,$05 Loop back to #R$5FC7 until all five cubby holes down the right-hand
. side have been drawn (the row counter reaches #N$06).
  $5FD7,$01 Return.

c $5FD8 Clear Cubby Hole
@ $5FD8 label=ClearCubbyHole
D $5FD8 Empties a cubby hole that has a bonus item in it, and cancels the
. bonus item object at #R$5E3C.
R $5FD8 DE Address of the cubby hole
  $5FD8,$02 Write #N$00 to *#REGde.
  $5FDA,$03 Write #N$00 to #R$5E3C.
  $5FDD,$01 Return.

c $5FDE Draw Cubby Hole Item
@ $5FDE label=DrawCubbyHoleItem
D $5FDE Draws the item held in one cubby hole. The item type is held in bits
. 3-7 of the cubby hole and the item colour in bits 0-2. The sprite for the
. item type is fetched from #R$601B, and the item is drawn standing on the
. shelf at the position given by the row counter.
. If bit 7 of the cubby hole is set it holds a bonus item and the hole is
. emptied using #R$5FD8 instead.
R $5FDE C Row counter (#N$01-#N$05)
R $5FDE DE Address of the cubby hole
R $5FDE L X position (#N$08 on the left, #N$E8 on the right)
  $5FDE,$01 #REGa=*#REGde (the contents of the cubby hole).
  $5FDF,$02,b$01 Keep only bits 3-7 (the item type).
  $5FE1,$01 Return if the cubby hole is empty.
  $5FE2,$04 Jump to #R$5FD8 if bit 7 is set.
  $5FE6,$01 #REGa=*#REGde (the contents of the cubby hole).
  $5FE7,$01 Stash the cubby hole contents on the stack.
N $5FE8 Use the item type to look up the sprite.
  $5FE8,$02 Rotate the item type (held in bits 3-7) down into bits 1-5.
  $5FEA,$02,b$01 Keep only bits 1-5
. (the item type multiplied by two, as each sprite pointer is two bytes).
  $5FEC,$03 Make this the offset into the table in #REGde.
  $5FEF,$01 Stash the X position (in #REGl) on the stack.
  $5FF0,$03 #REGhl=#R$601B.
  $5FF3,$01 Add the offset to #REGhl.
  $5FF4,$03 #REGde=the sprite address for the item type from the table.
  $5FF7,$01 Restore the X position from the stack.
N $5FF8 Work out the Y position from the row counter.
  $5FF8,$04 Rotate the row counter right three times (multiplying it by #N$20).
  $5FFC,$02,b$01 Keep only bits 5-7
. (so each row of shelves is #N$20 pixels lower).
  $5FFE,$02,b$01 Set bits 0-2 and bit 4
. (adding #N$17 so that the item stands on the shelf).
  $6000,$01 Store the Y position in #REGh.
N $6001 Work out the colour attribute.
  $6001,$01 Restore the cubby hole contents from the stack.
  $6002,$02,b$01 Keep only bits 0-2 (the item colour).
  $6004,$02,b$01 Set bit 6 (BRIGHT).
  $6006,$03 Write the colour attribute to #R$5E12.
N $6009 Draw and colour the sprite.
  $6009,$02 Stash #REGix on the stack.
  $600B,$04 #REGix=#R$5E0F (so that the colour is fetched from #R$5E12).
  $600F,$03 Set up the sprite at the position in #REGhl using #R$74C6.
  $6012,$03 Draw the sprite using #R$7539.
  $6015,$03 Colour the sprite using #R$7450.
  $6018,$02 Restore #REGix from the stack.
  $601A,$01 Return.

w $601B Cubby Hole Item Sprites
@ $601B label=CubbyHoleItem_Sprites
D $601B Indexed by the item type held in bits 3-7 of a cubby hole. An empty
. hole is item type #N$00, so its entry is never used.
  $601B,$02,$02 Item type #N$00: not used.
  $601D,$02,$02 Item type #N$01: #R$7711 (the spray can).

c $601F Draw Cubby Hole Shelves
@ $601F label=DrawCubbyHoleShelves
D $601F Draws the five shelves of the cubby holes down one side of the play
. area, each made of three bricks and each #N$20 pixels below the last.
R $601F DE Pointer to the string for the shelf
R $601F HL Screen position of the first shelf
  $601F,$02 Set the shelf counter in #REGc to #N$05.
@ $6021 label=DrawCubbyHoleShelves_Loop
  $6021,$02 Set the brick counter in #REGb to #N$01
. (one row of bricks per shelf).
  $6023,$03 Print the shelf using #R$6077.
  $6026,$01 #REGa=the Y position, which #R$6077 has moved down by #N$08.
  $6027,$02 Add #N$18 to move down to the next shelf
. (#N$20 pixels below the last).
  $6029,$01 Store the Y position in #REGh.
  $602A,$01 Decrease the shelf counter by one.
  $602B,$02 Loop back to #R$6021 until all five shelves have been drawn.
  $602D,$01 Return.

c $602E Draw Play Area
@ $602E label=DrawPlayArea
D $602E Draws the brick walls, the cubby hole shelves either side of the play
. area and the floor using the UDGs at #R$76D6.
N $602E #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$61EE,stop=$61F1,sp=$5D00)
. #SCR$01(play-area-before)
. | #SIM(start=$602E,stop=$6076,sp=$5D00)
. #SCR$01(play-area-after) }
. { =c2 #SCR$02,$00,$17,$20,$01(floor-strip) } UDGTABLE# #POPS
  $602E,$04 Stash #SKOOLKID$5C36(CHARS) on the stack.
  $6032,$06 Write #R$76D6 to #SKOOLKID$5C36(CHARS).
N $6038 Create the left-hand wall.
  $6038,$03 #REGde=#R$6087.
  $603B,$03 #REGhl=#N$1800 (screen position).
  $603E,$02 Set the brick counter to #N$14 (the wall is #N$14 bricks high).
  $6040,$03 Print the wall using #R$6077.
N $6043 Create the right-hand wall.
  $6043,$03 #REGhl=#N$18F8 (screen position).
  $6046,$02 Set the brick counter to #N$14 (the wall is #N$14 bricks high).
  $6048,$03 Print the wall using #R$6077.
N $604B Create the left-hand cubby hole shelves.
  $604B,$03 #REGde=#R$6089.
  $604E,$03 #REGhl=#N$1800 (screen position).
  $6051,$03 Draw the shelves using #R$601F.
N $6054 Create the right-hand cubby hole shelves.
  $6054,$03 #REGhl=#N$18E8 (screen position).
  $6057,$03 Draw the shelves using #R$601F.
N $605A Create the floor, which is #N$10 tiles wide.
  $605A,$03 #REGhl=#N$B800 (screen position).
  $605D,$03 #REGde=#R$608D.
  $6060,$02 Set the tile counter in #REGc to #N$10.
@ $6062 label=DrawPlayArea_FloorLoop
  $6062,$02 Set the row counter in #REGb to #N$01 (the tile is one row high).
  $6064,$03 Print the tile using #R$6077.
  $6067,$08 Move the screen position #N$10 pixels to the right and back up #N$08
. pixels to the row it was printed on.
  $606F,$03 Decrease the tile counter by one and loop back to #R$6062 until the
. whole floor has been drawn.
  $6072,$04 Restore #SKOOLKID$5C36(CHARS) from the stack, and write it back to
. #N$5C36.
  $6076,$01 Return.

c $6077 Print String Rows
@ $6077 label=PrintString_Wrapper
D $6077 Prints the same string on a number of consecutive character rows,
. so that a UDG is repeated down the screen.
R $6077 B Number of rows
R $6077 DE Pointer to string data
R $6077 HL Screen position of the first row
R $6077 O:HL Screen position of the row below the last one printed
  $6077,$03 Stash #REGhl, #REGde and #REGbc on the stack.
  $607A,$03 Print the string using #R$73ED.
  $607D,$03 Restore #REGbc, #REGde and #REGhl from the stack.
  $6080,$04 Move down #N$08 pixels onto the next row.
  $6084,$02 Decrease the row counter by one and loop back to #R$6077 until all
. of the rows have been printed.
  $6086,$01 Return.

b $6087 Play Area Strings
@ $6087 label=Message_Bricks_LR
D $6087 Strings used by #R$602E. Each is an attribute byte followed by UDG IDs
. (see #R$76D6), where the last UDG ID has bit 7 set to mark the end of the
. string.
  $6087,$02,$01 A brick wall string: #COLOUR$7A, one brick (UDG ID #N$00 with
. bit 7 set).
@ $6089 label=Message_Bricks_Cubby
  $6089,$04,$01 A cubby hole shelf string: #COLOUR$7A, three bricks (UDG ID
. #N$00, with bit 7 set on the last).
@ $608D label=Message_Floor
  $608D,$03,$01 A floor tile string: #COLOUR$32, UDG ID #N$01 and UDG ID #N$02
. (with bit 7 set).

t $6090 Messaging: Plant Eaten
@ $6090 label=Message_Eaten
D $6090 Shown by #R$60AA when the flower has been eaten away.
  $6090,$1A,h$01,$18:$01 Attribute: #COLOUR(#PEEK(#PC)) + "YOUR PLANT HAS BEEN EATEN".

c $60AA Player Turn Ends
@ $60AA label=PlayerTurnEnds
D $60AA Runs when Robbie has been killed. If the flower has also been eaten
. away then the "YOUR PLANT HAS BEEN EATEN" message is shown first and the
. flower is reset. All of the bugs are removed, and then either the current
. player starts another turn, the other player takes over, or the game is
. over.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After (flower eaten) }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$6339,stop=$634F,sp=$5D00)
. #SCR$01(turn-ends-before)
. | #POKES$5E8E,$B7
. #SIM(start=$60AA,stop=$610E,sp=$5D00)
. #SCR$01(turn-ends-after) } UDGTABLE# #POPS
  $60AA,$04 Write #N$00 to #R$5E3C.
N $60AE Check whether the flower has been eaten right down to the ground.
  $60AE,$03 Point #REGhl at the flower's Y position (#R$5E8E).
  $60B1,$01 #REGa=the flower Y position.
  $60B2,$04 Jump to #R$60C4 if the flower Y position is less than #N$B7.
  $60B6,$02 Reset the flower Y position to #N$A7.
  $60B8,$03 Create the game window using #R$5F53.
  $60BB,$03 #REGde=the "YOUR PLANT HAS BEEN EATEN" message (#R$6090).
  $60BE,$03 #REGhl=#N$7020 (screen position).
  $60C1,$03 Print the message and pause using #R$610B.
N $60C4 Remove all of the bugs and the explosion object.
@ $60C4 label=PlayerTurnEnds_RemoveBugs
  $60C4,$03 #REGhl=#R$5EB4 (the first bug).
  $60C7,$02 Set the object counter to #N$07 (the bugs and the explosion).
  $60C9,$03 Set the objects inactive using #R$70D6.
N $60CC Is this a 2UP game?
  $60CC,$03 #REGa=the game options from #R$5E03.
  $60CF,$02,b$01 Keep only bit 0 (the player count).
  $60D1,$02 Jump to #R$60E0 if this is a 2UP game.
N $60D3 Handle 1UP player.
@ $60D3 label=PlayerTurnEnds_1UP
  $60D3,$07 Jump to #R$6127 if the current player is out of lives (using
. #R$5E38).
  $60DA,$03 Create the game window using #R$5F8D.
  $60DD,$03 Jump to #R$6176 to start the player's next turn.
N $60E0 Handle 2UP player.
@ $60E0 label=PlayerTurnEnds_2UP
  $60E0,$06 Jump to #R$60D3 if the other player is out of lives (using
. #R$5E3A).
  $60E6,$07 Call #R$611F if the current player is out of lives (using
. #R$5E38).
  $60ED,$03 Swap the two players' data using #R$613B.
  $60F0,$07 Change current player at #R$5E1E (flip bits between #N$00 and #N$FF).
  $60F7,$03 Create the game window using #R$5F8D.
  $60FA,$03 Jump to #R$6176 to start the other player's turn.

c $60FD Show Game Over For 1UP
@ $60FD label=GameOver_1UP
D $60FD Shows "GAME OVER PLAYER 1" or "GAME OVER PLAYER 2" on a blank game
. window and pauses for a couple of seconds. The player number is written
. over the last character of the message at #R$6163.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$6339,stop=$634F,sp=$5D00)
. #SCR$01(game-over-1up-before)
. | #SIM(start=$60FD,stop=$610E,sp=$5D00)
. #SCR$01(game-over-1up-after) } UDGTABLE# #POPS
N $60FD #HTML(Set up altering the "GAME OVER PLAYER <em>X</em>" message for 1UP.)
  $60FD,c,$02 #REGa="1" + #N$80 (escape character).
N $60FF Print the messaging and pause to show it for a period of time.
@ $60FF label=GameOver_Write
  $60FF,$03 Write ASCII player number to #R$6163(#N$6175).
  $6102,$03 Create the game window using #R$5F53.
  $6105,$03 #REGde=#R$6163.
  $6108,$03 #REGhl=#N$7038 (screen position).
N $610B Print message and pause, also used by #R$60AA and #R$632D.
@ $610B label=GameOverPrint_Pause
  $610B,$03 Print the message using #R$73ED.
N $610E Introduce a pause by counting down from #N$10000 four times.
  $610E,$02 Set the number of countdowns to #N$04.
@ $6110 label=PauseForCount
  $6110,$03 #REGhl=#N$0000 (the start of a countdown of #N$10000 steps).
@ $6113 label=GameOver_Pause
  $6113,$01 Decrease the countdown by one.
  $6114,$04 Loop back to #R$6113 until the countdown has reached zero.
  $6118,$02 Decrease the number of countdowns by one and loop back to #R$6113
. until the pause is over.
  $611A,$01 Return.

c $611B Show Game Over For 2UP
@ $611B label=GameOver_2UP
D $611B Sets up the "GAME OVER PLAYER 2" message and then shows it using
. #R$60FF.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$6339,stop=$634F,sp=$5D00)
. #SCR$01(game-over-2up-before)
. | #SIM(start=$611B,stop=$610E,sp=$5D00)
. #SCR$01(game-over-2up-after) } UDGTABLE# #POPS
N $611B #HTML(Set up altering the "GAME OVER PLAYER <em>X</em>" message for 2UP.)
  $611B,c,$02 #REGa="2" + #N$80 (escape character).
  $611D,$02 Jump to #R$60FF.

c $611F Show Game Over For Active Player
@ $611F label=GameOver_Controller
D $611F Shows the "GAME OVER" message for whichever player is currently
. active.
  $611F,$06 Jump to #R$60FD if the current player (#R$5E1E) is #N$00 (1UP).
  $6125,$02 Else, jump to #R$611B.

c $6127 End Game
@ $6127 label=GameOver_ControllerRestart
D $6127 Both players are out of lives. Updates the high score, shows the
. "GAME OVER" message for the current player and then returns to the game
. selection screen.
N $6127 This is a controller with a jump to #R$61EA to return to the game selection screen.
  $6127,$03 Update the high score using #R$708F.
  $612A,$06 Jump to #R$6136 if the current player (#R$5E1E) is not #N$00 (2UP).
  $6130,$03 Show the "GAME OVER PLAYER 1" message using #R$60FD.
@ $6133 label=GameOver_Restart
  $6133,$03 Jump to #R$61EA.
@ $6136 label=GameOver_Restart2UP
  $6136,$03 Show the "GAME OVER PLAYER 2" message using #R$611B.
  $6139,$02 Jump to #R$6133.

c $613B 1UP/ 2UP Swapper
@ $613B label=ChangePlayer
D $613B Swaps the data of the active player with that of the inactive player:
. the level and lives, the cubby holes, and the flower and leaf objects.
E $613B View the equivalent code in;
. #LIST
. { #COOKIE$6416 }
. { #JETPAC$616A }
. { #LUNARJETMAN$A880 }
. { #SABREWULF$B235 }
. LIST#
N $613B This routine "swaps" the data between #REGde and #REGhl.
N $613B Swap the levels and lives.
  $613B,$03 #REGhl=#R$5E37.
  $613E,$03 #REGde=#R$5E39.
  $6141,$02 Set the byte counter to #N$02 (the level and the lives).
  $6143,$03 Swap the data using #R$6159.
N $6146 Swap the cubby holes.
  $6146,$03 #REGhl=#R$5E23.
  $6149,$03 #REGde=#R$5E2D.
  $614C,$02 Set the byte counter to #N$0A (the ten cubby holes).
  $614E,$03 Swap the data using #R$6159.
N $6151 Swap the flower and leaves.
  $6151,$03 #REGhl=#R$5E44.
  $6154,$03 #REGde=#R$5E8C.
  $6157,$02 Set the byte counter to #N$28 (the flower and the four leaves).
N $6159 Swap the bytes at #REGhl and #REGde, then move onto the next pair of
. bytes.
@ $6159 label=ChangePlayer_Loop
  $6159,$01 Fetch the byte of the inactive player.
  $615A,$01 Fetch the byte of the active player.
  $615B,$01 Write the inactive player's byte over the active player's.
  $615C,$01 #REGa=the active player's byte.
  $615D,$01 Write the active player's byte over the inactive player's.
  $615E,$02 Move both pointers onto the next byte.
  $6160,$02 Decrease the byte counter by one and loop back to #R$6159 until all
. of the bytes have been swapped.
  $6162,$01 Return.

t $6163 Messaging: Game Over
@ $6163 label=GameOver_Text
D $6163 The message shown when a player has lost all of their lives. The last
. character is replaced with the number of the player (see #R$60FD).
  $6163,$13,h$01,$11:$01 "GAME OVER PLAYER X".

c $6176 Initialise Player
@ $6176 label=PlayerInit
D $6176 Sets up the active player for a turn: puts Robbie at his default
. position, sets how long the "get ready" delay lasts and takes a life.
  $6176,$05 Write #N$15 to #R$5EE4.
  $617B,$0B Copy #N$08 bytes of data from #R$5F1E to #R$5E6C.
N $6186 Set default "begin play" delay period.
  $6186,$02 #REGa=#N$80 (the length of the "get ready" delay).
  $6188,$07 Jump to #R$6191 if #R$5E03 says this is a 1UP game.
  $618F,$02 Else, add #N$7F to make the delay #N$FF for a two player game
. (giving more time for "passing over" the controls).
@ $6191 label=PlayerInit_WriteDelay
  $6191,$03 Write the delay to #R$5E22.
N $6194 "Spend" a life.
N $6194 See #POKE(infinite_lives,Infinite Lives).
  $6194,$07 Decrease #R$5E38 by one.
  $619B,$03 Jump to #R$7325 to display the lives.

c $619E Flash Player Label
@ $619E label=FlashPlayerLabel
D $619E Sets the FLASH attribute on the three cells of the active player's
. "1UP" or "2UP" label in the banner. Called while the "get ready" delay at
. #R$5E22 is running.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$61EE,stop=$61F1,sp=$5D00)
. #SCR$04,$00,$00,$08,$02(flash-label-before)
. | #POKES$5E1E,$00;$5D00,$00,$02
. #SIM(start=$619E,stop=$0000,sp=$5D00)
. #SCR$04,$00,$00,$08,$02(flash-label-after) } UDGTABLE# #POPS
  $619E,$03 Fetch the current player from #R$5E1E.
  $61A1,$03 Jump to #R$61C1 if the current player is not #N$00 (2UP).
  $61A4,$03 #REGhl=#N($0018, 4, 4) (the position of "1UP").
N $61A7 Set the FLASH bit on each of the three attribute cells.
@ $61A7 label=FlashPlayerLabel_Set
  $61A7,$03 Convert the position to an attribute buffer address using #R$748F.
  $61AA,$02 Set the cell counter to #N$03 (the three characters of the label).
@ $61AC label=FlashPlayerLabel_Loop
  $61AC,$01 Fetch the attribute of the cell.
  $61AD,$02,b$01 Set bit 7 (FLASH).
  $61AF,$01 Write the attribute back.
  $61B0,$01 Move onto the next cell.
  $61B1,$02 Decrease the cell counter by one and loop back to #R$61AC until all
. three cells are flashing.
  $61B3,$01 Return.

c $61B4 Stop Flashing Player Label
@ $61B4 label=StopFlashingPlayerLabel
D $61B4 Clears the FLASH attribute on the three cells of a "1UP" or "2UP"
. label.
R $61B4 HL Position of the label (X in #REGl, Y in #REGh)
  $61B4,$03 Convert the position to an attribute buffer address using #R$748F.
  $61B7,$02 Set the cell counter to #N$03 (the three characters of the label).
@ $61B9 label=StopFlashingPlayerLabel_Loop
  $61B9,$01 Fetch the attribute of the cell.
  $61BA,$02,b$01 Keep only bits 0-6 (reset the FLASH bit).
  $61BC,$01 Write the attribute back.
  $61BD,$01 Move onto the next cell.
  $61BE,$02 Decrease the cell counter by one and loop back to #R$61B9 until all
. three cells have stopped flashing.
  $61C0,$01 Return.
N $61C1 Use the position of "2UP" instead.
@ $61C1 label=FlashPlayerLabel_2UP
  $61C1,$03 #REGhl=#N($00D8, 4, 4) (the position of "2UP").
  $61C4,$02 Jump to #R$61A7.

c $61C6 Security Check
@ $61C6 label=SecurityCheck
D $61C6 Returns to the caller (BASIC) without starting the game unless the
. second byte of #SKOOLKID$5C78(FRAMES) is #N$65.
E $61C6 Continue on to #R$61CD.
E $61C6 View the equivalent code in;
. #LIST
. { #ATICATAC$6000 }
. { #COOKIE$5F00 }
. { #JETPAC$61E5 }
. { #LUNARJETMAN$8000 }
. { #SABREWULF$995A }
. { #TRANZAM$5F00 }
. LIST#
  $61C6,$01 Disable interrupts.
  $61C7,$03 #REGa=the second byte of #SKOOLKID$5C78(FRAMES).
  $61CA,$03 Return if #REGa is not #N$65.

c $61CD Game Initialisation
@ $61CD label=GameInitialisation
D $61CD Clears the high score, the game options, the sound flag and the 1UP
. and 2UP scores, calculates a checksum of the ROM #SKOOLKID$03B5(BEEPER)
. routine to set the sound flag, and sets the border colour system variable.
E $61CD Continue on to #R$61EA.
E $61CD View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #COOKIE$6298 }
. { #JETPAC$61EB }
. { #LUNARJETMAN$800A }
. { #SABREWULF$9960 }
. { #TRANZAM$5F07 }
. LIST#
N $61CD Blank the high score, game options, sound flag, 1UP and 2UP scores.
  $61CD,$06 #REGhl=#N$5E00 (the high score), #REGb=#N$0B (the byte counter) and
. #REGc=#N$00 (the value to write).
@ $61D3 label=GameInitialisation_Loop
  $61D3,$01 Clear the byte.
  $61D4,$01 Move onto the next byte.
  $61D5,$02 Decrease the byte counter by one and loop back to #R$61D3 until all
. #N$0B bytes have been cleared.
N $61D7 This calculates a "checksum" of the #SKOOLKID$03B5(BEEPER) routine.
. The expected value at the end is #N$00, and if #R$5E04 does not contain
. #N$00 then the tunes are not played.
  $61D7,$03 #REGhl=#SKOOLKID$03B5(BEEPER).
  $61DA,$02 Set the byte counter to #N$43 (the length of the routine).
  $61DC,$01 #REGa=#N$00 (the start of the checksum).
@ $61DD label=Mute_Loop
  $61DD,$01 Add the byte of the routine to the checksum.
  $61DE,$01 Move onto the next byte of the routine.
  $61DF,$02 Decrease the byte counter by one and loop back to #R$61DD until the
. whole routine has been added.
  $61E1,$02 Add #N$68 to the checksum
. (which gives #N$00 if the routine is unchanged).
  $61E3,$03 Store the checksum at #R$5E04 (the sound flag).
  $61E6,$04 Write #N$00 to #SKOOLKID$5C48(BORDCR).

c $61EA Select Game
@ $61EA label=Game_Restart
D $61EA Shows the game selection menu and reads the keys "1" to "5" until the
. player starts the game by pressing "5". Keys "1" and "2" choose the number
. of players, keys "3" and "4" choose the control method, and the chosen
. options are shown by flashing the menu lines.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After pressing "2" and "4" (the chosen lines flash) }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$61EE,stop=$61F1,sp=$5D00)
. #SIM(start=$61F1,stop=$61F4,sp=$5D00)
. #SCR$02,$05,$03,$18,$0D(select-before)
. | #POKES$5E03,$03
. #SIM(start=$6220,stop=$61F1,sp=$5D00)
. #SIM(start=$61F1,stop=$61F4,sp=$5D00)
. #SCR$02,$05,$03,$18,$0D(select-after) } UDGTABLE# #POPS
  $61EA,$01 Disable interrupts.
  $61EB,$03 Reset the stack pointer to #N$5D00 (the top of the game's stack).
  $61EE,$03 Create the game window using #R$5F53.
@ $61F1 label=GameSelect_Loop
  $61F1,$03 Print the menu using #R$6250.
  $61F4,$04 Fetch the game options from #R$5E03 into #REGd.
  $61F8,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $61FE,$01 Flip the bits, so that a key being pressed is a set bit.
N $61FF Handle 1UP selection.
  $61FF,$04 Jump to #R$6205 if key "1" ("1 PLAYER GAME") is not being pressed.
  $6203,$02 Reset bit 0 of #REGd (a 1UP game).
N $6205 Handle 2UP selection.
@ $6205 label=GameSelect_CheckP2
  $6205,$04 Jump to #R$620B if key "2" ("2 PLAYER GAME") is not being pressed.
  $6209,$02 Set bit 0 of #REGd (a 2UP game).
N $620B Handle Keyboard selection.
@ $620B label=GameSelect_CheckKeyboard
  $620B,$04 Jump to #R$6211 if key "3" ("KEYBOARD") is not being pressed.
  $620F,$02 Reset bit 1 of #REGd (keyboard control).
N $6211 Handle Kempston Joystick selection.
@ $6211 label=GameSelect_CheckKempston
  $6211,$04 Jump to #R$6217 if key "4" ("KEMPSTON JOYSTICK") is not being
. pressed.
  $6215,$02 Set bit 1 of #REGd (joystick control).
N $6217 Handle starting a new game.
@ $6217 label=GameSelect_StartGame
  $6217,$05 Jump to #R$632D if key "5" ("START GAME") is being pressed.
N $621C Handle flashing each selection.
  $621C,$04 Write #REGd to #R$5E03.
  $6220,$03 #REGhl=#R$627D (the first selectable line, skipping the title).
  $6223,$04 Fetch the game options from #R$5E03 into #REGc.
@ $6227 label=MenuAttributeCheckPlayer
  $6227,$04 Jump to #R$6238 if a 2UP game is selected.
  $622B,$03 Else, flash the first line using #R$6242.
N $622E Check control method.
@ $622E label=MenuAttributeCheckControl
  $622E,$04 Jump to #R$623D if joystick control is selected.
  $6232,$03 Else, flash the first line using #R$6242.
@ $6235 label=GameSelect_End
  $6235,$03 Jump back to #R$61F1.
N $6238 Handle flashing 2UP.
@ $6238 label=MenuAttributeHandle2UP
  $6238,$03 Flash the second line using #R$6249.
  $623B,$02 Jump to #R$622E.
N $623D Handle flashing joystick.
@ $623D label=MenuAttributeHandleJoystick
  $623D,$03 Flash the second line using #R$6249.
  $6240,$02 Jump to #R$6235.

c $6242 Flash First Menu Line
@ $6242 label=MenuAttributeSetFirst
D $6242 Sets the FLASH attribute for the first of two menu lines and resets
. it for the second.
R $6242 HL Pointer to the attribute byte of the first line
R $6242 O:HL Pointer to the attribute byte after the second line
  $6242,$02 Set the FLASH attribute for the first selection.
  $6244,$01 Move onto the next menu attribute.
  $6245,$02 Unset the FLASH attribute for the second selection.
  $6247,$01 Move onto the next menu selection attribute.
  $6248,$01 Return.

c $6249 Flash Second Menu Line
@ $6249 label=MenuAttributeSetSecond
D $6249 Resets the FLASH attribute for the first of two menu lines and sets
. it for the second.
R $6249 HL Pointer to the attribute byte of the first line
R $6249 O:HL Pointer to the attribute byte after the second line
  $6249,$02 Unset the FLASH attribute for the first selection.
  $624B,$01 Move onto the next menu attribute.
  $624C,$02 Set the FLASH attribute for the second selection.
  $624E,$01 Move onto the next menu selection attribute.
  $624F,$01 Return.

c $6250 Game Selection Menu
@ $6250 label=GameMenu
D $6250 Prints the six lines of the game selection menu, each with its own
. attribute byte and Y position, and then the copyright message at the
. bottom of the screen. The main registers hold the pointer to the attribute
. table, and the shadow registers hold the pointer to the Y position table
. (#REGhl'), the pointer to the text (#REGde') and the line counter (#REGb').
. #PUSHS #UDGTABLE { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$61EE,stop=$61F1,sp=$5D00)
. #SIM(start=$61F1,stop=$61F4,sp=$5D00)
. #SCR$02(game-menu) } UDGTABLE# #POPS
E $6250 View the equivalent code in;
. #LIST
. { #ATICATAC$7CAF }
. { #COOKIE$6332 }
. { #JETPAC$6260 }
. { #LUNARJETMAN$80D1 }
. { #SABREWULF$B473 }
. { #TRANZAM$5F6C }
. { #UNDERWURLDE$90E4 }
. LIST#
  $6250,$03 Point #REGde at the table of menu attributes (#R$627C).
  $6253,$01 Switch to the shadow registers.
  $6254,$03 #REGhl'=#R$6282 (the table of Y positions).
  $6257,$03 #REGde'=#R$6288 (the text of the menu).
N $625A There are six lines of text.
  $625A,$02 Set the line counter in #REGb' to #N$06.
@ $625C label=GameMenu_Loop
  $625C,$01 Switch back to the normal registers.
  $625D,$04 Store the attribute byte of the line to #R$5E21.
  $6261,$01 Move onto the next menu attribute.
  $6262,$01 Switch to the shadow registers.
  $6263,$01 Stash the line counter (#REGbc') on the stack.
  $6264,$01 Fetch the Y position of the line from the table.
  $6265,$01 Move onto the next Y position in the table.
  $6266,$01 Stash the table pointer on the stack.
  $6267,$03 Set the Y position of the line in #REGh' and the X position (#N$38)
. in #REGl'.
  $626A,$03 Print the line using #R$62E7.
  $626D,$01 Switch to the shadow registers.
  $626E,$02 Restore the table pointer and the line counter from the stack.
  $6270,$01 Move #REGde' onto the next line of text.
  $6271,$02 Decrease the line counter by one and loop back to #R$625C until all
. six lines have been printed.
N $6273 Print the copyright footer.
  $6273,$03 #REGhl=#N$B800 (the screen position of the copyright message).
  $6276,$03 #REGde=the copyright message (#R$5EF5).
  $6279,$03 Jump to #R$73ED.

b $627C Game Select Attribute Table
@ $627C label=GameSelection_Attributes
D $627C One attribute byte per menu line. The routines that flash the
. selected line set or clear FLASH in the byte for the line being
. updated. The first byte belongs to the title, so the flashing code
. starts at #R$627D.
. #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | Game Selection }
. { #N$02 | 1 Player Game }
. { #N$03 | 2 Player Game }
. { #N$04 | Keyboard }
. { #N$05 | Kempston Joystick }
. { #N$06 | Start Game }
. TABLE#
E $627C View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #COOKIE$635E }
. { #JETPAC$628D }
. { #LUNARJETMAN$810E }
. { #SABREWULF$B498 }
. { #TRANZAM$5FA7 }
. { #UNDERWURLDE$9119 }
. LIST#
  $627C,$01 Attribute for "GAME SELECTION": #COLOUR(#PEEK(#PC)).
@ $627D label=GameSelection_Attributes_Options
  $627D,$02,$01 Attributes for "1 PLAYER GAME" and "2 PLAYER GAME".
  $627F,$02,$01 Attributes for "KEYBOARD" and "KEMPSTON JOYSTICK".
  $6281,$01 Attribute for "START GAME": #COLOUR(#PEEK(#PC)).

b $6282 Game Select Y Position Table
@ $6282 label=GameSelection_Position
D $6282 The Y position of each menu line in pixels, with the X position of
. each line being fixed at #N$38.
E $6282 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF1 }
. { #COOKIE$6365 }
. { #JETPAC$6293 }
. { #LUNARJETMAN$8115 }
. { #SABREWULF$B4A0 }
. { #TRANZAM$5FAC }
. { #UNDERWURLDE$911F }
. LIST#
  $6282,$06,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | Game Selection }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | 1 Player Game }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | 2 Player Game }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | Keyboard }
. { #N$05 | #EVAL(#PEEK(#PC+$04) / $08) | Kempston Joystick }
. { #N$06 | #EVAL(#PEEK(#PC+$05) / $08) | Start Game }
. TABLE#

t $6288 Messaging: Game Selection Screen Text
@ $6288 label=GameSelection_Text
D $6288 The text of each menu line. There is no attribute byte as that comes
. from #R$627C, and the last character of each string has bit 7 set.
E $6288 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #COOKIE$636C }
. { #JETPAC$6299 }
. { #LUNARJETMAN$811C }
. { #SABREWULF$B4B0 }
. { #TRANZAM$5FB1 }
. { #UNDERWURLDE$9125 }
. LIST#
  $6288,$0E,$0D:$01 "GAME SELECTION".
  $6296,$11,$10:$01 "1   1 PLAYER GAME".
  $62A7,$11,$10:$01 "2   2 PLAYER GAME".
  $62B8,$0C,$0B:$01 "3   KEYBOARD".
  $62C4,$15,$14:$01 "4   KEMPSTON JOYSTICK".
  $62D9,$0E,$0D:$01 "5   START GAME".

c $62E7 Write Menu Line
@ $62E7 label=MenuWriteText
D $62E7 Prints one line of the game selection menu. This is similar to
. #R$73ED, but the attribute comes from #R$5E21 and the text has no
. attribute byte. It is called with the shadow registers selected, so
. that #REGhl' and #REGde' hold the position and the text.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$61EE,stop=$61F1,sp=$5D00)
. #SCR$02,$05,$03,$18,$03(menu-line-before) }
. { =h After }
. { #POKES$5E21,$47;$5D00,$00,$02
. #SIM(start=$62E7,stop=$0000,hl=$2038,de=$6288,sp=$5D00)
. #SCR$02,$05,$03,$18,$03(menu-line-after) } UDGTABLE# #POPS
E $62E7 View the equivalent code in;
. #LIST
. { #ATICATAC$7D8A }
. { #COOKIE$63E0 }
. { #LUNARJETMAN$81AB }
. { #SABREWULF$B52D }
. { #TRANZAM$5F97 }
. { #UNDERWURLDE$91B0 }
. LIST#
R $62E7 DE' Pointer to the text
R $62E7 HL' Position (X in #REGl', Y in #REGh')
  $62E7,$01 Stash the position (#REGhl) on the stack.
  $62E8,$03 Convert the co-ordinate to a screen address using #R$759A.
  $62EB,$03 #REGa=the menu attribute byte from #R$5E21.
  $62EE,$01 Keep the attribute in the shadow #REGaf register.
  $62EF,$01 Switch to the shadow registers.
  $62F0,$01 Restore #REGhl from the stack.
  $62F1,$03 Convert the co-ordinate to an attribute buffer address using
. #R$748F.
  $62F4,$03 Jump to #R$73F9 to print the text and write the attributes.

c $62F7 Reset Player Data
@ $62F7 label=ResetPlayerData
D $62F7 Gives both players their starting level and lives, and resets their
. cubby holes, flower and leaves. The data is set up for one player and then
. swapped using #R$613B, and then the same is done for the other.
  $62F7,$02 Set the player counter to #N$02 (a game has at most two players).
@ $62F9 label=ResetPlayerData_Loop
  $62F9,$01 Stash the player counter on the stack.
  $62FA,$04 Reset #R$5E37 to #N$00 (level 1).
  $62FE,$05 Set #R$5E38 to #N$04.
  $6303,$03 Reset the cubby holes using #R$5FA0.
  $6306,$03 Reset the flower and leaves using #R$5F40.
  $6309,$03 Swap the players using #R$613B.
  $630C,$01 Restore the player counter from the stack.
  $630D,$02 Decrease the player counter by one and loop back to #R$62F9 until
. both players have been set up.
N $630F 2UP has one "extra" life, due to the way the game "spends" a life
. when your turn starts.
  $630F,$05 Write #N$05 to #R$5E3A.
  $6314,$03 #REGa=the game options from #R$5E03.
  $6317,$02,b$01 Keep only bit 0 (1 or 2 players).
  $6319,$01 Return if this is a two player game.
  $631A,$03 Else, write #N$00 to #R$5E3A (2UP has no lives).
  $631D,$01 Return.

t $631E Messaging: Spray The Bugs
@ $631E label=Message_SprayBugs
D $631E Shown when a new game is about to start.
  $631E,$0F,h$01,$0D:$01 Attribute: #COLOUR(#PEEK(#PC)) + "SPRAY THE BUGS".

c $632D Start Game
@ $632D label=StartGame
D $632D Shows the "SPRAY THE BUGS" message, clears the scores and all of the
. game variables and objects, sets up the data for both players and then
. starts the first level. Continues on to the main loop.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$61EE,stop=$61F1,sp=$5D00)
. #SIM(start=$61F1,stop=$61F4,sp=$5D00)
. #SCR$01(start-game-before)
. | #SIM(start=$632D,stop=$610E,sp=$5D00)
. #SCR$01(start-game-after) } UDGTABLE# #POPS
E $632D Continue on to #R$634F.
E $632D View the equivalent code in;
. #LIST
. { #ATICATAC$7D9A }
. { #COOKIE$6428 }
. { #JETPAC$6333 }
. { #LUNARJETMAN$81BB }
. { #TRANZAM$5FEF }
. LIST#
  $632D,$03 Create the game window using #R$5F53.
  $6330,$03 #REGhl=#N($7048, 4, 4) (screen position).
  $6333,$03 #REGde=#R$631E.
  $6336,$03 Print the message and pause using #R$610B.
  $6339,$0D Write #N$00 to every byte from #R$5E05 to #N$5EEB (the scores,
. the game variables and the objects).
  $6346,$03 Reset the player data using #R$62F7.
  $6349,$03 Reset the modified code using #R$7113.
  $634C,$03 Start the first level using #R$5F80.

c $634F Run Main Loop
@ $634F label=MainLoop_NewPass
D $634F The main game loop. The objects from #R$5E6C onwards are #N$08 bytes
. each, and the loop calls the update routine for the type of each object
. in turn (see #R$637E). Every update routine returns to #R$7130, which
. moves on to the next object.
. .
. A pass starts here with the flower object at #R$5E8C and carries on up to
. the last object (the explosion at #R$5EE4), then the next pass is started
. here again. Whenever the frame counter has changed, #R$70ED is called to
. update the first four objects (Robbie, the spray can and the two weapons)
. once. This means that these are updated on every frame no matter how long
. a pass through the other objects takes.
N $634F Start a new pass through the objects.
  $634F,$03 #REGsp=#N$5D00.
  $6352,$01 Enable interrupts.
  $6353,$04 #REGix=#R$5E8C (the flower object).
  $6357,$04 Write #N$00 to #R$5E16 to reset the enemy counter.
@ $635B label=MainLoop
N $635B Check whether the frame counter has changed.
  $635B,$07 Compare #SKOOLKID$5C78(FRAMES) and #R$5E1F.
  $6362,$04 If they are not equal call #R$70ED to update the fast objects.
N $6366 Every update routine returns to #R$7130.
  $6366,$03 #REGhl=#R$7130 (the routine which moves onto the next object).
  $6369,$01 Stash the return address on the stack.
N $636A Find the update routine for the type of the object.
  $636A,$03 #REGhl=#R$637E.
  $636D,$03 #REGa=*#REGix+#N$00 (the object state).
  $6370,$01 Rotate #REGa left once.
  $6371,$02,b$01 Keep only bits 1-6 (the object type, held in bits 0-5 of the
. state, multiplied by two).
@ $6373 label=PerformJump
  $6373,$03 #REGbc=the offset into the jump table.
  $6376,$01 #REGhl=the address of the entry in the jump table.
  $6377,$04 #REGhl=the address of the update routine from the jump table.
  $637B,$03 Jump to #R$5CB0 which does an indirect jump to the jump address.

w $637E Main Jump Table
@ $637E label=JumpTable_Main
D $637E The update routine for each object type, indexed by the type held in
. bits 0-5 of the state byte of an object. Bits 6 and 7 of the state byte
. are flags used by the update routines for the type.
  $637E,$02 Type #N$00: an inactive object, handled by #R$70DF.
  $6380,$02 Type #N$01: Robbie without a spray can, handled by #R$6DBA.
  $6382,$02 Type #N$02: Robbie carrying a spray can, handled by #R$6EF1.
  $6384,$02 Type #N$03: the spray can being carried, handled by #R$6ED2.
  $6386,$02 Type #N$04: a smoke bomb, handled by #R$6BD0.
  $6388,$02 Type #N$05: a smoke bomb, handled by #R$6BD0.
  $638A,$02 Type #N$06: a smoke bomb, handled by #R$6BD0.
  $638C,$02 Type #N$07: a space slug, handled by #R$6A98.
  $638E,$02 Type #N$08: insect repellent, handled by #R$698F.
  $6390,$02 Type #N$09: midges, handled by #R$67AE.
  $6392,$02 Type #N$0A: a leech, handled by #R$64FA.
  $6394,$02 Type #N$0B: a bonus item, which is never in the main loop,
. handled by #R$70DF.
  $6396,$02 Type #N$0C: a bonus item, which is never in the main loop,
. handled by #R$70DF.
  $6398,$02 Type #N$0D: a bonus item, which is never in the main loop,
. handled by #R$70DF.
  $639A,$02 Type #N$0E: not used, handled by #R$70DF.
  $639C,$02 Type #N$0F: not used, handled by #R$70DF.
  $639E,$02 Type #N$10: the flower, handled by #R$6D0C.
  $63A0,$02 Type #N$11: a leaf, handled by #R$6C53.
  $63A2,$02 Type #N$12: a streamer, handled by #R$69E8.
  $63A4,$02 Type #N$13: the flower in bloom, handled by #R$66A6.
  $63A6,$02 Type #N$14: an explosion, handled by #R$65F7.
  $63A8,$02 Type #N$15: an idle object, handled by #R$63DB (which just
. returns).

c $63AA Check Bug Leaf Collision
@ $63AA label=LeafCollision
D $63AA Checks whether the bug being updated (#REGix) is touching any of the
. four leaf objects. If it is on top of an active leaf, the leaf is marked as
. being eaten and it returns straight away, so only one leaf is eaten at a
. time.
  $63AA,$03 #REGhl=#R$5E94 (the first leaf object).
  $63AD,$02 Set the leaf counter to #N$04.
  $63AF,$03 #REGde=#N$0008
. (the size of an object, used to move onto the next leaf).
@ $63B2 label=LeafCollision_Loop
  $63B2,$01 Stash the address of the leaf on the stack.
  $63B3,$04 If the current leaf is not active, jump to #R$63DC.
N $63B7 Is the leaf within #N$09 pixels of the bug horizontally?
  $63B7,$02 #REGa=the X position of the leaf.
  $63B9,$03 Subtract the X position of the bug.
  $63BC,$05 Make the horizontal distance positive.
@ $63C1 label=LeafCollision_Test_X
  $63C1,$04 Jump to #R$63DC if the leaf is #N$0A or more pixels away.
N $63C5 Is the leaf within #N$09 pixels of the bug vertically?
  $63C5,$02 #REGa=the Y position of the leaf.
  $63C7,$03 Subtract the Y position of the bug.
  $63CA,$05 Make the vertical distance positive.
@ $63CF label=LeafCollision_Test_Y
  $63CF,$04 Jump to #R$63DC if the leaf is #N$0A or more pixels away.
N $63D3 The bug is on the leaf, so the leaf starts to shrink away.
  $63D3,$02 Skip the colour attribute to point to the leaf animating flag.
  $63D5,$05 Write #N$01 to the animating flag and the "being eaten" flag of the
. leaf (see #R$6C53).
  $63DA,$01 Restore the address of the leaf from the stack.
  $63DB,$01 Return.
N $63DC Move onto the next leaf object.
@ $63DC label=LeafCollision_Next
  $63DC,$01 Restore #REGhl from the stack.
  $63DD,$01 Add the object size to move onto the next leaf.
  $63DE,$02 Decrease the leaf counter by one and loop back to #R$63B2 until all
. four leaves have been checked.
  $63E0,$01 Return.

c $63E1 Play Tune
@ $63E1 label=PlayMusic
D $63E1 Plays a tune one note at a time until the terminator is reached. The
. low five bits of each byte in the tune data are a note number from #N$01
. to #N$08, which is used to look up the pitch and the duration of the note
. in the table at #R$640D for the ROM #SKOOLKID$03B5(BEEPER) routine.
R $63E1 DE Pointer to the tune data
  $63E1,$01 Fetch the next note of the tune.
  $63E2,$03 Return if the terminator (#N$FF) has been reached.
  $63E5,$02,b$01 Keep only bits 0-4 (the note number).
  $63E7,$01 Decrease the note number by one (the notes are numbered from one).
  $63E8,$02 Double it, as there are two bytes for each note in the table.
  $63EA,$03 Make this the offset into the note table in #REGbc.
  $63ED,$03 #REGhl=#R$640D (the note table).
  $63F0,$01 Add the offset to find the note.
  $63F1,$01 Stash the tune pointer on the stack.
  $63F2,$01 Fetch the pitch of the note.
  $63F3,$01 Move onto the duration of the note.
  $63F4,$01 #REGe=the duration of the note.
  $63F5,$02 Set the high byte of the duration (#REGd) to #N$00.
  $63F7,$03 #REGhl=the pitch of the note.
  $63FA,$08 Multiply #REGhl by four to make the pitch for the beeper.
  $6402,$02 Stash #REGix on the stack, as the beeper routine overwrites it.
  $6404,$03 Call #SKOOLKID$03B5(BEEPER).
  $6407,$03 Restore #REGix and the tune pointer from the stack.
  $640A,$01 Move onto the next note of the tune.
  $640B,$02 Loop back round to #R$63E1 to play the next note
. (the tune only ends when the terminator is reached).

b $640D Note Table
@ $640D label=NoteTable
D $640D The pitch and the duration for each of the eight notes of a scale,
. which are used as the inputs for the ROM #SKOOLKID$03B5(BEEPER) routine.
. The pitch is multiplied by four by #R$63E1 and, as the pitch gets
. higher, the duration gets longer so that every note lasts for about the
. same time.
  $640D,$10,$02 Note #N$01 to note #N$08 (pitch, duration).

b $641D Level Complete Tune
@ $641D label=Tune_Scale
D $641D A rising scale with each note played twice. The data has no
. terminator, so it runs straight on into the tune at #R$642D.
.
. #HTML(#AUDIO0(level-complete-tune.wav)(#INCLUDE(LevelCompleteTune)))
  $641D,$10,$02 Notes #N$01 to #N$08, two of each.

b $642D Jingle Tune
@ $642D label=Tune_Jingle
D $642D A short jingle, ending with the terminator (#N$FF) that stops
. #R$63E1.
.
. #HTML(#AUDIO0(jingle-tune.wav)(#INCLUDE(JingleTune)))
  $642D,$1F,$08 Note numbers (#N$04, #N$06, #N$08 and so on).
  $644C,$01 Terminator.

c $644D Check Bug Flower Collision
@ $644D label=BugFlowerCollision
D $644D Checks whether a bug is touching the flower, using a window that is
. wider for a slug than it is for the midges and the leech. It also only
. counts when the bug is below the top of the flower.
R $644D IX Bug object
R $644D O:E #N$00 No collision
R $644D O:E #N$01 Collision
  $644D,$02 #REGe=#N$00 (no collision).
  $644F,$03 #REGhl=#R$5E8D (the X position of the flower).
N $6452 Calculate the horizontal distance between the flower and the bug.
  $6452,$01 #REGa=flower X position.
  $6453,$03 Subtract the bug X position.
  $6456,$02 Add #N$09 (so a bug up to #N$09 pixels to the right of the flower
. gives zero).
  $6458,$06 Jump to #R$6462 if the bug is not a slug (bit 3 of the type is
. set for the midges and the leech).
  $645E,$02 Compare #REGa with #N$24 (the width of the window for a slug).
  $6460,$02 Jump to #R$6464.
@ $6462 label=BugFlowerCollision_Narrow
  $6462,$02 Compare #REGa with #N$1C (the width of the window for the other
. bugs).
@ $6464 label=BugFlowerCollision_TestX
  $6464,$01 Return if the bug is too far away horizontally.
N $6465 Is the bug below the top of the flower?
  $6465,$01 Increment #REGhl by one to point to the flower Y position.
  $6466,$03 Halve the flower Y position.
  $6469,$05 Halve the bug Y position into #REGd.
  $646E,$01 Subtract the halved bug Y position from the halved flower Y
. position.
  $646F,$01 Return if the flower is not above the bug.
  $6470,$02 #REGe=#N$01 (collision).
  $6472,$01 Return.

c $6473 Play Repellent Hit Sound
@ $6473 label=PlayRepellentHitSound
D $6473 Plays #N$0F square waves of nearly constant pitch.
.
. #HTML(#AUDIO0(repellent-hit.wav)(#INCLUDE(RepellentHit)))
  $6473,$02 Set the wave counter in #REGc to #N$0F.
@ $6475 label=PlayRepellentHitSound_Loop
  $6475,$01 Fetch the wave counter.
  $6476,$03 Rotate the wave counter right three times.
  $6479,$02,b$01 Keep only bits 0-2.
  $647B,$01 Invert all of the bits in #REGa.
  $647C,$01 Decimal adjust #REGa.
  $647D,$01 Use the result as the duration of the wave in #REGd.
  $647E,$03 Call #R$64AA.
  $6481,$01 Decrease the wave counter by one.
  $6482,$02 Loop back to #R$6475 until all of the waves have been played.
  $6484,$01 Return.

c $6485 Play Explosion Sound
@ $6485 label=PlayExplosionSound
D $6485 Plays #N$20 square waves of falling pitch. A random value from
. #R$5E19 is written over the operand of the instruction at #R$6494, which
. changes the durations, so this isn't the same twice.
.
. #HTML(#AUDIO0(explosion.wav)(#INCLUDE(Explosion)))
  $6485,$03 Fetch the random value from #R$5E19.
  $6488,$02,b$01 Keep only bits 0-6.
  $648A,$02,b$01 Set bits 4-5.
  $648C,$03 Write this over the operand of the instruction at #R$6494.
  $648F,$02 Set the wave counter in #REGc to #N$20.
@ $6491 label=PlayExplosionSound_Loop
  $6491,$01 Fetch the wave counter.
  $6492,$02,b$01 Flip bits 0-3.
  $6494,$02,b$01 Keep only the bits set in the operand written at #R$648C.
  $6496,$01 Set the duration of the wave in #REGd.
  $6497,$03 Call #R$64AA.
  $649A,$01 Decrease the wave counter by one.
  $649B,$02 Loop back to #R$6491 until all of the waves have been played.
  $649D,$01 Return.

c $649E Play Repellent Sound
@ $649E label=PlayRepellentSound
D $649E Plays #N$10 square waves, alternating between a high and a low pitch.
.
. #HTML(#AUDIO0(repellent.wav)(#INCLUDE(Repellent)))
  $649E,$02 Set the wave counter in #REGc to #N$10.
@ $64A0 label=PlayRepellentSound_Loop
  $64A0,$01 Fetch the wave counter.
  $64A1,$01 Rotate #REGa right once.
  $64A2,$01 Set the duration of the wave in #REGd.
  $64A3,$03 Call #R$64AA.
  $64A6,$01 Decrease the wave counter by one.
  $64A7,$02 Loop back to #R$64A0 until all of the waves have been played.
  $64A9,$01 Return.

c $64AA Play Square Wave
@ $64AA label=PlaySquareWave
D $64AA Plays one square wave: the speaker is switched on for the duration,
. then off for the same duration.
E $64AA View the equivalent code in;
. #LIST
. { #COOKIE$68B1 }
. { #LUNARJETMAN$B8DA }
. { #MARTIANOIDS$C062 }
. { #SABREWULF$BF74 }
. LIST#
R $64AA D Duration of wave
  $64AA,$04 Switch the speaker on (bit 4) and write it to the port.
  $64AE,$01 Set the delay counter in #REGb to the duration of the wave.
@ $64AF label=PlaySquareWave_Loop
  $64AF,$02 Decrease the delay counter by one and loop back to #R$64AF until the
. speaker has been on for the whole duration.
  $64B1,$03 Switch the speaker off and write it to the port.
  $64B4,$01 Set the delay counter in #REGb to the duration of the wave.
@ $64B5 label=Silence_Loop
  $64B5,$02 Decrease the delay counter by one and loop back to #R$64B5 until the
. speaker has been off for the whole duration.
  $64B7,$01 Return.

c $64B8 Play Streamer Sound
@ $64B8 label=PlayStreamerSound
D $64B8 Plays #N$08 square waves of varying pitch.
.
. #HTML(#AUDIO0(streamer.wav)(#INCLUDE(Streamer)))
  $64B8,$02 Set the wave counter in #REGc to #N$08.
@ $64BA label=PlayStreamerSound_Loop
  $64BA,$01 Fetch the wave counter.
  $64BB,$02 Rotate #REGa left twice.
  $64BD,$02,b$01 Flip bits 0-2.
  $64BF,$02 Rotate #REGa left twice.
  $64C1,$01 Set the duration of the wave in #REGd.
  $64C2,$03 Call #R$64AA.
  $64C5,$01 Decrease the wave counter by one.
  $64C6,$02 Loop back to #R$64BA until all of the waves have been played.
  $64C8,$01 Return.

c $64C9 Play Smoke Sound
@ $64C9 label=PlaySmokeSound
D $64C9 Plays #N$08 square waves of falling pitch.
.
. #HTML(#AUDIO0(smoke.wav)(#INCLUDE(Smoke)))
  $64C9,$02 Set the wave counter in #REGc to #N$08.
@ $64CB label=PlaySmokeSound_Loop
  $64CB,$01 Fetch the wave counter.
  $64CC,$01 Invert all of the bits in #REGa.
  $64CD,$01 Rotate #REGa left once.
  $64CE,$01 Set the duration of the wave in #REGd.
  $64CF,$03 Call #R$64AA.
  $64D2,$01 Decrease the wave counter by one.
  $64D3,$02 Loop back to #R$64CB until all of the waves have been played.
  $64D5,$01 Return.

c $64D6 Play High Tone
@ $64D6 label=PlayHighTone
D $64D6 Plays #N$50 square waves with a duration of #N$20.
.
. #HTML(#AUDIO0(high-tone.wav)(#INCLUDE(HighTone)))
  $64D6,$02 Set the duration of the wave in #REGd to #N$20.
  $64D8,$02 Set the wave counter in #REGc to #N$50.
  $64DA,$02 Jump to #R$64E0.

c $64DC Play Low Tone
@ $64DC label=PlayLowTone
D $64DC Plays #N$28 square waves with a duration of #N$50.
.
. #HTML(#AUDIO0(low-tone.wav)(#INCLUDE(LowTone)))
  $64DC,$02 Set the duration of the wave in #REGd to #N$50.
  $64DE,$02 Set the wave counter in #REGc to #N$28.
N $64E0 Play each wave until all of the waves have been played.
@ $64E0 label=PlayTone_Loop
  $64E0,$03 Play a wave using #R$64AA.
  $64E3,$01 Decrease the wave counter by one.
  $64E4,$02 Loop back to #R$64E0 until all of the waves have been played.
  $64E6,$01 Return.

c $64E7 Play Mid Tone
@ $64E7 label=PlayMidTone
D $64E7 Plays #N$40 square waves with a duration of #N$30.
.
. #HTML(#AUDIO0(mid-tone.wav)(#INCLUDE(MidTone)))
  $64E7,$02 Set the duration of the wave in #REGd to #N$30.
  $64E9,$02 Set the wave counter in #REGc to #N$40.
  $64EB,$02 Jump to #R$64E0.

c $64ED Update Bug Common
@ $64ED label=UpdateBugCommon
D $64ED The checks which are made at the start of the update of every bug.
. This counts the bug (the bug counter at #R$5E16 is used to decide when to
. spawn more bugs), remembers the position and state of the bug so that
. it can be erased, checks the bug against the leaves and finally checks
. whether the bug is touching Robbie by jumping to #R$72F5, which returns
. to the caller.
R $64ED IX Bug object
R $64ED O:E #N$00 The bug is not touching Robbie
R $64ED O:E #N$01 The bug is touching Robbie
  $64ED,$03 #REGhl=#R$5E16 (the bug counter).
  $64F0,$01 Increment the bug counter by one.
  $64F1,$03 Remember the position and state of the bug using #R$75B9.
  $64F4,$03 Call #R$63AA.
  $64F7,$03 Jump to #R$72F5.

c $64FA Update Leech
@ $64FA label=UpdateLeech
D $64FA Updates a leech. If the leech is touching Robbie then both explode. A
. weapon hitting the leech either kills it (a streamer, worth #N$75 points)
. or stuns it for a while (the repellent spray), and smoke bombs have no
. effect. When the leech touches the flower it starts to eat it. Otherwise
. it crawls horizontally along the ground in steps of two pixels, bouncing
. off the sides of the play area, and every so often it also moves
. vertically for a random period.
R $64FA IX Leech object
N $64FA The object fields used are:
. #TABLE(default,centre)
. { =h Field | =h Use }
. { +0 bit 6 | Moving right }
. { +0 bit 7 | Moving down }
. { +4 bit 0 | Moving vertically }
. { +4 bit 2 | Stunned }
. { +4 bit 3 | Eating the flower }
. { +5 | Stun timer }
. { +6 | Vertical movement counter }
. TABLE#
  $64FA,$03 Do the common bug checks using #R$64ED.
  $64FD,$01 Decrease the collision result in #REGe by one
. (zero means that the leech is touching Robbie).
  $64FE,$03 Jump to #R$6A73 if the leech is touching Robbie.
N $6501 Check whether a weapon has hit the leech.
  $6501,$03 Check whether a weapon has hit the leech using #R$6A42.
  $6504,$01 Decrease the collision result in #REGe by one
. (zero means that a weapon has hit the leech).
  $6505,$02 Jump to #R$650C if there was no hit.
  $6507,$05 #REGa=the state of the weapon, and jump to #R$65BA if the weapon
. is active.
@ $650C label=UpdateLeech_NoWeaponHit
  $650C,$07 Jump to #R$6B3A if the leech is eating the flower.
  $6513,$03 Check whether the leech has reached the flower using #R$644D.
  $6516,$01 Decrease the collision result in #REGe by one
. (zero means that the leech has reached the flower).
  $6517,$03 Jump to #R$679C if the leech has reached the flower, to start
. eating it.
N $651A Is the leech stunned?
  $651A,$06 Jump to #R$652A if the leech is not stunned.
  $6520,$03 Decrease the stun timer in #REGix+#N$05 by one.
  $6523,$03 Jump to #R$659F if the leech is still stunned, to redraw it
. without moving.
  $6526,$04 Reset bit 2 of #REGix+#N$04 (the stun has ended).
N $652A If the leech is not moving vertically there is a one in thirty-two
. chance of it starting to.
@ $652A label=UpdateLeech_Vertical
  $652A,$06 Jump to #R$6555 if it is moving vertically.
  $6530,$04 #REGe=the random number from #R$5E19.
  $6534,$04 Jump to #R$6555 unless the random number is a multiple of #N$20.
  $6538,$04 Set bit 0 of #REGix+#N$04 (moving vertically).
  $653C,$03 #REGa=#R$5E17.
  $653F,$02,b$01 Keep only bits 0-4.
  $6541,$02 Add #N$10 (this value is not stored, as the next instruction
. overwrites it).
  $6543,$03 #REGa=#REGix+#N$06 (the vertical movement counter).
  $6546,$01 #REGa=the random number.
  $6547,$02,b$01 Keep only bit 7 (the direction).
  $6549,$01 Keep the direction bit in #REGe.
  $654A,$03 #REGa=#REGix+#N$00 (the state).
  $654D,$02,b$01 Reset bit 7 (move up).
  $654F,$04 Set bit 7 if the random number had bit 7 set, and write the state
. back.
  $6553,$02 Jump to #R$650C.
@ $6555 label=UpdateLeech_MoveVertical
  $6555,$06 Jump to #R$6587 if the leech is not moving vertically.
  $655B,$03 #REGa=leech X position.
  $655E,$04 Jump to #R$6587 if the leech is too far left to move vertically.
  $6562,$04 Jump to #R$6587 if the leech is too far right to move vertically.
  $6566,$03 #REGa=leech Y position.
  $6569,$06 Jump to #R$65A2 if the leech is moving up (bit 7 is not set).
  $656F,$02 Add #N$02 to move down.
  $6571,$04 Jump to #R$657B if this is above the bottom of the play area.
  $6575,$04 Reset bit 7 of #REGix+#N$00 (turn the leech upwards).
  $6579,$02 Jump to #R$657E.
@ $657B label=UpdateLeech_StoreY
  $657B,$03 Write the new Y position.
@ $657E label=UpdateLeech_Countdown
  $657E,$03 Decrease the vertical movement counter by one.
  $6581,$02 Jump to #R$6587 if the counter is not zero.
  $6583,$04 Reset bit 0 of #REGix+#N$04 (stop moving vertically).
N $6587 Move the leech horizontally.
@ $6587 label=UpdateLeech_MoveHorizontal
  $6587,$03 #REGa=leech X position.
  $658A,$06 Jump to #R$65AE if the leech is moving left (bit 6 is not set).
  $6590,$02 Add #N$02 to move right.
  $6592,$04 Jump to #R$659C if this is not past the right edge.
  $6596,$04 Reset bit 6 of #REGix+#N$00 (turn the leech to the left).
  $659A,$02 Jump to #R$659F.
@ $659C label=UpdateLeech_StoreX
  $659C,$03 Write the new X position.
@ $659F label=UpdateLeech_Draw
  $659F,$03 Jump to #R$6F31 to draw the leech.
N $65A2 Moving up.
@ $65A2 label=UpdateLeech_MoveUp
  $65A2,$02 Subtract #N$02 to move up.
  $65A4,$04 Jump to #R$657B if this is not above the top limit.
  $65A8,$04 Set bit 7 of #REGix+#N$00 (turn the leech downwards).
  $65AC,$02 Jump to #R$657B.
N $65AE Moving left.
@ $65AE label=UpdateLeech_MoveLeft
  $65AE,$02 Subtract #N$02 to move left.
  $65B0,$04 Jump to #R$659C if this is not past the left edge.
  $65B4,$04 Set bit 6 of #REGix+#N$00 (turn the leech to the right).
  $65B8,$02 Jump to #R$659F.

c $65BA Handle Leech Weapon Hit
@ $65BA label=LeechWeaponHit
D $65BA A weapon has hit the leech. A streamer kills it, the repellent spray
. stuns it and a smoke bomb has no effect.
R $65BA A State of the weapon
R $65BA IX Leech object
  $65BA,$02,b$01 Keep only bits 0-5 (the type of the weapon).
  $65BC,$04 Jump to #R$65D6 if the weapon is a streamer.
  $65C0,$05 Jump to #R$650C if it is not the repellent spray.
  $65C5,$03 Call #R$65CB to stun the leech.
  $65C8,$03 Jump to #R$650C.

c $65CB Stun Bug
@ $65CB label=StunBug
D $65CB Stuns a bug for #N$10 updates and plays the sound for a weapon hit.
R $65CB IX Bug object
  $65CB,$04 Set bit 2 of #REGix+#N$04 (stunned).
  $65CF,$04 Write #N$10 to #REGix+#N$05 (the stun timer).
  $65D3,$03 Jump to #R$6473 (which returns to the caller).

c $65D6 Kill Leech
@ $65D6 label=KillLeech
D $65D6 Adds #N$75 points to the score and then explodes the leech.
R $65D6 IX Leech object
  $65D6,$03 #REGbc=#N$0075 (the points for the kill).
@ $65D9 label=KillLeech_AddPoints
  $65D9,$03 Add the points to the score using #R$737A.

c $65DC Explode Bug
@ $65DC label=ExplodeBug
D $65DC Turns a bug into an explosion. The state of the bug is kept in
. #REGix+#N$06 so that the object can be put back to how it was once the
. explosion has finished (see #R$65F7), and the explosion sound plays.
.
. #HTML(#AUDIO0(explosion.wav)(#INCLUDE(Explosion)))
R $65DC IX Bug object
  $65DC,$03 #REGa=the state of the bug.
  $65DF,$04 Write #N$00 to #REGix+#N$05 (the speed of the animation, which is
. the fastest).
@ $65E3 label=ExplodeBug_RememberState
  $65E3,$03 Remember the old state in #REGix+#N$06.
  $65E6,$04 Write #N$14 (an explosion) to #REGix+#N$00.
  $65EA,$04 Write #N$00 to #REGix+#N$04 (the first frame of the animation).
  $65EE,$03 Jump to #R$6485 to play the explosion sound (which returns to the
. caller).

c $65F1 Start Explosion
@ $65F1 label=StartExplosion
D $65F1 Starts a slower explosion for Robbie, used by #R$6A73.
.
. #HTML(#AUDIO0(explosion.wav)(#INCLUDE(Explosion)))
R $65F1 A State to restore when the explosion is over
R $65F1 IX Explosion object
  $65F1,$04 Write #N$01 to #REGix+#N$05 (the speed of the animation, which is
. every other update).
  $65F5,$02 Jump to #R$65E3.

c $65F7 Animate Explosion
@ $65F7 label=AnimateExplosion
D $65F7 Animates an explosion through three frames of a growing explosion
. (drawn in random colours) and then three frames to erase it again. At the
. end of the animation the object is restored to its old state (kept in
. #REGix+#N$06), then:
. #LIST
. { if it is a bug, the object is removed; }
. { if it was Robbie with an empty hand, the player's turn ends; }
. { if it was Robbie carrying a can, the can is put back into a random
. empty cubby hole and then the player's turn ends. }
. LIST#
R $65F7 IX Explosion object
  $65F7,$03 #REGhl=#R$5E16.
  $65FA,$01 Increment the bug counter by one.
  $65FB,$03 #REGc=the animation frame from #REGix+#N$04.
  $65FE,$03 #REGb=the animation speed mask from #REGix+#N$05.
  $6601,$03 #REGa=the game timer from #R$5E17.
  $6604,$01 Keep only the bits set in the speed mask.
  $6605,$02 Jump to #R$660A if the result is not zero.
  $6607,$03 Increment the animation frame by one.
@ $660A label=ExplosionFetchSpriteFrame
  $660A,$01 #REGa=the current explosion animation frame.
  $660B,$02 Double the frame to make an offset into the table.
  $660D,$02 Clear the high byte of the offset in #REGb.
  $660F,$03 #REGhl=#R$6682 (the table of explosion sprites).
  $6612,$01 Add the offset to find the sprite for the frame.
  $6613,$03 #REGde=the sprite address for the frame from the table.
  $6616,$03 #REGl=the X position of the explosion.
  $6619,$03 #REGh=the Y position of the explosion.
  $661C,$04 If the current frame >= #N$06 then the animation has finished.
  $6620,$04 If the current frame >= #N$03 then we are erasing it.
  $6624,$03 Call #R$751C.
  $6627,$03 #REGa=#R$5E19.
  $662A,$02,b$01 Keep only bits 0-2.
  $662C,$02,b$01 Set bits 1 and 6 (BRIGHT).
  $662E,$03 Write the random colour to #REGix+#N$03
. (the colour of the explosion).
  $6631,$03 Jump to #R$7450.
N $6634 After an explosion, we check if it was the player that died!
@ $6634 label=AnimateExplosion_End
  $6634,$06 Restore the old state of the object from #REGix+#N$06.
  $663A,$03 Call #R$75B9.
  $663D,$03 Call #R$7526.
  $6640,$04 Write #N$00 to #REGix+#N$00 (make the object inactive).
  $6644,$03 #REGa=the old state.
  $6647,$02,b$01 Keep only bits 0-5.
  $6649,$03 Return if it was not Robbie (#REGa >= #N$03).
  $664C,$05 Jump to #R$60AA if Robbie was not carrying a can (the type is not
. #N$02).
N $6651 Robbie was carrying a can, so put it back in an empty cubby hole. A
. random hole is tried first, and then the following holes until an empty
. one is found.
  $6651,$03 #REGhl=#R$5E23 (the first cubby hole).
  $6654,$03 #REGbc=#R$5E2D (the end of the cubby holes).
  $6657,$03 #REGa=#R$5E19.
  $665A,$02,b$01 Keep only bits 0-2.
  $665C,$01 #REGe=the random offset.
  $665D,$02 Clear the high byte of the offset in #REGd.
  $665F,$01 Add the random offset to #REGhl.
@ $6660 label=ExplosionCubbyHole_Loop
  $6660,$01 #REGa=the cubby hole.
  $6661,$03 Jump to #R$6671 if the hole is empty.
  $6664,$01 Move on to the next hole.
  $6665,$01 Stash #REGhl on the stack.
  $6666,$03 Compare #REGhl with the end of the cubby holes.
  $6669,$01 Restore #REGhl from the stack.
  $666A,$02 Jump back to #R$6660 if the end has not been reached.
  $666C,$03 #REGhl=#R$5E23 (wrap round to the first hole).
  $666F,$02 Jump to #R$6660.
@ $6671 label=ExplosionCubbyHole_Found
  $6671,$03 #REGa=the colour of the spray can from #R$5E77.
  $6674,$02,b$01 Keep only bits 0-2.
  $6676,$02,b$01 Set bit 3 (the type of the item is a spray can).
  $6678,$01 Write the item to the cubby hole.
  $6679,$03 Jump to #R$60AA.
N $667C Erase the explosion.
@ $667C label=AnimateExplosion_Erase
  $667C,$03 Call #R$74AB.
  $667F,$03 Jump to #R$7529.

w $6682 Explosion Sprite Table
@ $6682 label=ExplosionLookupTable
D $6682 The sprite for each frame of an explosion. The addresses are
. repeated because on first use the sprites are drawn in a bright colour
. as the explosion grows, and then are erased in the same order, so as to
. make the explosion disappear.
  $6682,$02 Frame 0: small explosion.
  $6684,$02 Frame 1: medium explosion.
  $6686,$02 Frame 2: large explosion.
  $6688,$02 Frame 3: small explosion (erase).
  $668A,$02 Frame 4: medium explosion (erase).
  $668C,$02 Frame 5: large explosion (erase).

c $668E Start Flower Bloom
@ $668E label=StartFlowerBloom
D $668E The flower has grown to the top of the play area. This turns the
. flower into a blooming flower, then removes every other object
. (Robbie, the spray can, the weapons, the leaves, the bugs and the
. explosion).
R $668E IX Flower object
  $668E,$04 Write #N$13 (the flower in bloom) to #REGix+#N$00.
  $6692,$04 Write #N$00 to #REGix+#N$04 (the first stage of blooming).
  $6696,$02 Set the object counter to #N$04.
  $6698,$03 #REGhl=#R$5E6C (Robbie, the spray can and the weapons).
  $669B,$03 Set the objects inactive using #R$70D6.
  $669E,$02 Set the object counter to #N$0B.
  $66A0,$03 #REGhl=#R$5E94 (the leaves, the bugs and the explosion).
  $66A3,$03 Jump to #R$70D6 to set the objects inactive (which returns to the
. caller).

c $66A6 Update Blooming Flower
@ $66A6 label=UpdateBloomingFlower
D $66A6 Opens the flower once the "get ready" delay has finished. Every eighth
. update the flower moves on to the next stage, using the sprite for the
. stage from #R$6787. At stage #N$04 the flower is coloured in using
. #R$670E, and at stage #N$05 the level is complete (#R$66D7).
. #PUSHS #UDGTABLE(default,centre,centre,centre,centre,centre)
. { =h Stage #N$00 | =h Stage #N$01 | =h Stage #N$02 | =h Stage #N$03
. | =h Stage #N$04 }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$6339,stop=$634F,sp=$5D00)
. #POKES$5E22,$00;$5E03,$00;$5D00,$00,$02
. #POKES$5E8C,$13;$5E8E,$6F;$5E90,$00
. #SIM(start=$6D07,stop=$0000,de=$769A,ix=$5E8C,sp=$5D00)
. #SCR$02,$0A,$05,$0B,$0B(bloom-stage-0)
. | #POKES$5E17,$00
. #SIM(start=$66A6,stop=$0000,ix=$5E8C,sp=$5D00)
. #SCR$02,$0A,$05,$0B,$0B(bloom-stage-1)
. | #POKES$5E17,$00
. #SIM(start=$66A6,stop=$0000,ix=$5E8C,sp=$5D00)
. #SCR$02,$0A,$05,$0B,$0B(bloom-stage-2)
. | #POKES$5E17,$00
. #SIM(start=$66A6,stop=$0000,ix=$5E8C,sp=$5D00)
. #SCR$02,$0A,$05,$0B,$0B(bloom-stage-3)
. | #POKES$5E17,$00
. #SIM(start=$66A6,stop=$0000,ix=$5E8C,sp=$5D00)
. #SCR$02,$0A,$05,$0B,$0B(bloom-stage-4) } UDGTABLE# #POPS
R $66A6 IX Flower object
  $66A6,$03 Remember the position and state using #R$75B9.
  $66A9,$06 Return if the "get ready" delay in #R$5E22 is not finished.
  $66AF,$03 #REGa=the game timer from #R$5E17.
  $66B2,$02,b$01 Keep only bits 0-2
. (so that the flower only changes stage every eighth update).
  $66B4,$02 Return if it is not time for the next stage.
  $66B6,$03 Get the sprite for the current stage using #R$6791.
  $66B9,$03 Set up the previous sprite using #R$74A8.
  $66BC,$01 Switch to the shadow registers.
  $66BD,$03 Increment the stage in #REGix+#N$04 by one.
  $66C0,$03 #REGa=the stage.
  $66C3,$02 Compare the stage with #N$04 (the open flower).
  $66C5,$03 Call #R$670E if this is stage #N$04 to colour the flower in.
  $66C8,$04 Jump to #R$66D7 if the stage is #N$05 (note that #REGa has been
. overwritten if the flower was just coloured).
  $66CC,$03 Get the sprite for the new stage using #R$6791.
  $66CF,$03 Set up the new sprite using #R$74C0.
  $66D2,$01 Switch to the shadow registers.
  $66D3,$03 Draw the new sprite and erase the previous one using #R$74F2.
@ $66D6 label=UpdateBloomingFlower_Return
  $66D6,$01 Return.

c $66D7 Complete Level
@ $66D7 label=LevelComplete
D $66D7 Clears all of the objects from the play area, plays a tune (unless the
. tunes are switched off, when there is a pause instead) and then starts the
. next level using #R$5F80.
. .
. Every fourth level (the fifth, the ninth and so on) earns an extra life
. and the longer tune at #R$641D, and the other levels just play the
. jingle at #R$642D.
  $66D7,$03 #REGhl=#R$5E6C (Robbie).
  $66DA,$02 Set the object counter to #N$10.
  $66DC,$03 Set all of the objects inactive using #R$70D6.
  $66DF,$06 Jump to #R$6705 if the tunes are switched off (#R$5E04 is not
. zero).
  $66E5,$06 Jump to #R$6700 if this is the first level (#R$5E37 is zero).
  $66EB,$04 Jump to #R$6700 if the level is not a multiple of four.
  $66EF,$03 #REGde=#R$641D.
  $66F2,$03 #REGhl=#R$5E38 (the lives of the active player).
  $66F5,$01 Give the player an extra life.
@ $66F6 label=LevelComplete_PlayTune
  $66F6,$03 Play the tune using #R$63E1.
@ $66F9 label=LevelComplete_NextLevel
  $66F9,$03 #REGhl=#R$5E37 (the level of the active player).
  $66FC,$01 Increment the level by one.
  $66FD,$03 Jump to #R$5F80.
@ $6700 label=LevelComplete_Jingle
  $6700,$03 #REGde=#R$642D.
  $6703,$02 Jump to #R$66F6.
@ $6705 label=LevelComplete_Pause
  $6705,$01 Disable interrupts.
  $6706,$02 Set the number of countdowns to #N$0A.
  $6708,$03 Pause using #R$6110.
  $670B,$01 Enable interrupts.
  $670C,$02 Jump to #R$66F9.

c $670E Colour Open Flower
@ $670E label=ColouriseFlower
D $670E Writes the attributes of the open flower into the attribute buffer,
. using the table at #R$6748, which is nine cells wide and seven cells high.
. The colour of the centre of the flower changes from yellow to magenta,
. unless the level is a multiple of four (and not the first level), which
. are the levels that award an extra life.
R $670E IX Flower object
  $670E,$06 #REGl=the X position of the flower - #N$20.
  $6714,$06 #REGh=the Y position of the flower - #N$30.
  $671A,$03 Convert the position to an attribute buffer address using #R$748F.
  $671D,$03 #REGde=#R$6748.
  $6720,$03 #REGb=#N$09 (the number of columns) and #REGc=#N$07
. (the number of rows).
@ $6723 label=ColouriseFlower_Row
  $6723,$01 Stash the column and row counters on the stack.
  $6724,$01 Stash the attribute address on the stack.
@ $6725 label=ColouriseFlower_Column
  $6725,$06 Jump to #R$673F if this is the first level (#R$5E37 is zero).
  $672B,$04 Jump to #R$673F if the level is not a multiple of four.
@ $672F label=ColouriseFlower_Write
  $672F,$01 #REGa=the attribute from the table.
@ $6730 label=ColouriseFlower_Store
  $6730,$01 Write it to the attribute buffer.
  $6731,$01 Move onto the next attribute buffer cell.
  $6732,$01 Move onto the next attribute in the table.
  $6733,$02 Decrease the column counter by one and loop back to #R$6725 until
. the row has been coloured.
  $6735,$01 Restore the attribute address from the stack.
  $6736,$03 #REGbc=#N$0020 (the size of a row).
  $6739,$01 Move down one row.
  $673A,$01 Restore the column and row counters from the stack.
  $673B,$01 Decrease the row counter by one.
  $673C,$02 Loop back to #R$6723 until all of the rows have been coloured.
  $673E,$01 Return.
N $673F For any other level, the yellow in the centre of the flower is replaced.
@ $673F label=ColouriseFlower_Replace
  $673F,$01 #REGa=the attribute from the table.
  $6740,$04 Jump to #R$6730 if it is not #N$5E (yellow on magenta).
  $6744,$02 #REGa=#N$5B (magenta on magenta).
  $6746,$02 Jump to #R$6730.

b $6748 Flower Attributes
@ $6748 label=FlowerAttributes
D $6748 The attributes of the open flower, nine cells wide and seven cells
. high.
  $6748,$3F,$09

w $6787 Flower Sprite Table
@ $6787 label=FlowerSpriteTable
D $6787 The sprite for each stage of the flower: stages #N$00 to #N$04.
  $6787,$0A,$02

c $6791 Get Flower Sprite
@ $6791 label=GetFlowerSprite
D $6791 Looks up the sprite for the stage of the flower.
R $6791 IX Flower object
R $6791 O:DE Sprite data
  $6791,$03 #REGa=the stage from #REGix+#N$04.
  $6794,$02 Double the stage to make an offset into the table.
  $6796,$03 #REGhl=#R$6787.
  $6799,$03 Jump to #R$6CD9 to read the address from the table.

c $679C Start Eating Flower
@ $679C label=StartEatingFlower
D $679C A bug has reached the flower and starts eating it. The flag in bit 3
. of #REGix+#N$04 marks that the bug is eating, #REGix+#N$05 is set to a
. random number and #REGix+#N$06 remembers the Y position of the bug (see
. #R$6B3A).
R $679C IX Bug object
  $679C,$02 #REGa=the refresh register (a random number).
  $679E,$03 Write it to #REGix+#N$05.
  $67A1,$03 #REGa=the Y position of the bug.
  $67A4,$03 Write it to #REGix+#N$06.
  $67A7,$04 Set bit 3 of #REGix+#N$04 (eating the flower).
  $67AB,$03 Jump to #R$6F31 to draw the bug.

c $67AE Update Midges
@ $67AE label=UpdateMidges
D $67AE Updates a swarm of midges. If the midges touch Robbie then both
. explode. A repellent spray kills them (worth #N$50 points), a smoke bomb
. stuns them, and a streamer has no effect. When they reach the flower they
. start to eat it.
. .
. Otherwise they fly towards a target (Robbie, or the flower if that is
. closer) and use a speed and a direction in each axis, so that they speed
. up when flying towards the target and slow down, stop and turn round when
. flying away from it. #REGix+#N$05 holds the horizontal motion and
. #REGix+#N$06 holds the vertical motion. In each of them the low nibble is
. the speed (#N$00 to #N$0F) and the high nibble is the fraction of a pixel
. left over from the last move (see #R$68DD).
R $67AE IX Midges object
N $67AE The object fields used are:
. #TABLE(default,centre)
. { =h Field | =h Use }
. { +0 bit 6 | Moving left (the midges move right if this is not set) }
. { +0 bit 7 | Moving down (the midges move up if this is not set) }
. { +4 bit 2 | Stunned }
. { +4 bit 3 | Eating the flower }
. { +5 | Horizontal motion (or the stun timer while stunned) }
. { +6 | Vertical motion }
. TABLE#
  $67AE,$03 Do the common bug checks using #R$64ED.
  $67B1,$01 Decrease the collision result in #REGe by one
. (zero means that the midges are touching Robbie).
  $67B2,$03 Jump to #R$6A73 if the midges are touching Robbie.
  $67B5,$03 Call #R$6A42 to check whether a weapon has hit the midges.
  $67B8,$01 Decrease the collision result in #REGe by one
. (zero means that a weapon has hit the midges).
  $67B9,$02 Jump to #R$67C0 if there was no hit.
  $67BB,$05 #REGa=the state of the weapon, and jump to #R$68ED if the weapon
. is active.
@ $67C0 label=UpdateMidges_NoWeaponHit
  $67C0,$07 Jump to #R$6B3A if the midges are eating the flower.
  $67C7,$03 Check whether the midges have reached the flower using #R$644D.
  $67CA,$01 Decrease the collision result in #REGe by one
. (zero means that the midges have reached the flower).
  $67CB,$02 Jump to #R$679C if the midges have reached the flower, to start
. eating it.
N $67CD Are the midges stunned?
  $67CD,$06 Jump to #R$67DD if the midges are not stunned.
  $67D3,$03 Decrease the stun timer in #REGix+#N$05 by one.
  $67D6,$03 Jump to #R$6F31 if the midges are still stunned, to draw them
. without moving.
  $67D9,$04 Reset bit 2 of #REGix+#N$04 (the stun has ended).
N $67DD Horizontal movement. Find the target and see which side of it the
. midges are on.
@ $67DD label=UpdateMidges_Horizontal
  $67DD,$03 Find the target using #R$690F, returning #REGhl pointing to the X
. position of the target.
  $67E0,$04 #REGb=the horizontal motion from #REGix+#N$05.
  $67E4,$03 #REGc=the speed (the low nibble).
  $67E7,$04 #REGb=the fraction (the high nibble).
  $67EB,$01 #REGa=the X position of the target.
  $67EC,$03 Subtract the X position of the midges.
  $67EF,$03 Jump to #R$686E if the target is to the right.
  $67F2,$07 Jump to #R$689A if the midges are moving right.
N $67F9 The target is to the left and the midges are moving left, so speed
. up (to a maximum of #N$0F) and move left.
@ $67F9 label=UpdateMidges_AccelerateLeft
  $67F9,$01 #REGa=the speed.
  $67FA,$05 Increase the speed by one, up to a maximum of #N$0F.
@ $67FF label=UpdateMidges_MoveLeft
  $67FF,$01 #REGc=the new speed.
  $6800,$03 #REGh=the X position of the midges.
  $6803,$03 Work out the distance to move using #R$68DD.
  $6806,$03 Subtract the distance from the position.
  $6809,$01 #REGa=the new X position.
  $680A,$04 Jump to #R$6812 if the midges have not reached the left edge.
  $680E,$04 Reset bit 6 of #REGix+#N$00 (turn the midges round to move right).
@ $6812 label=UpdateMidges_StoreX
  $6812,$03 Write the new X position.
  $6815,$03 #REGa=the fraction (the high nibble of #REGl).
  $6818,$01 Add the speed.
  $6819,$03 Write the horizontal motion to #REGix+#N$05.
  $681C,$03 #REGa=the X position of the midges.
  $681F,$05 Jump to #R$6F31 to draw the midges without moving vertically if
. they are too far to the left.
  $6824,$05 Jump to #R$6F31 to draw the midges without moving vertically if
. they are too far to the right.
N $6829 Vertical movement works in the same way, with the target being above
. or below the midges.
@ $6829 label=UpdateMidges_Vertical
  $6829,$03 Find the target using #R$690F.
  $682C,$04 #REGb=the vertical motion from #REGix+#N$06.
  $6830,$03 #REGc=the speed (the low nibble).
  $6833,$04 #REGb=the fraction (the high nibble).
  $6837,$01 Move #REGhl onto the Y position of the target.
  $6838,$01 #REGa=the Y position of the target.
  $6839,$03 Subtract the Y position of the midges.
  $683C,$03 Jump to #R$68A6 if the target is below.
  $683F,$07 Jump to #R$68D3 if the midges are moving up.
  $6846,$01 #REGa=the speed.
  $6847,$01 Decrease the speed by one.
  $6848,$02 Jump to #R$68B3 if the midges have not stopped.
  $684A,$04 Reset bit 7 of #REGix+#N$00 (turn the midges to move up).
@ $684E label=UpdateMidges_MoveUp
  $684E,$01 #REGc=the new speed.
  $684F,$03 #REGh=the Y position of the midges.
  $6852,$03 Work out the distance to move using #R$68DD.
  $6855,$03 Subtract the distance from the position.
  $6858,$01 #REGa=the new Y position.
  $6859,$04 Jump to #R$6861 if the midges have not reached the top.
  $685D,$04 Set bit 7 of #REGix+#N$00 (turn the midges to move down).
@ $6861 label=UpdateMidges_StoreY
  $6861,$03 Write the new Y position.
  $6864,$03 #REGa=the fraction (the high nibble of #REGl).
  $6867,$01 Add the speed.
  $6868,$03 Write the vertical motion to #REGix+#N$06.
  $686B,$03 Jump to #R$6F31 to draw the midges.
N $686E The target is to the right.
@ $686E label=UpdateMidges_TargetRight
  $686E,$06 Jump to #R$6892 if the midges are moving right.
  $6874,$02 The midges are moving left, so slow down: #REGa=the speed - #N$01.
  $6876,$03 Jump to #R$67FF if the speed is not zero.
  $6879,$04 Reset bit 6 of #REGix+#N$00 (turn the midges to move right).
@ $687D label=UpdateMidges_MoveRight
  $687D,$01 #REGc=the new speed.
  $687E,$03 #REGh=the X position of the midges.
  $6881,$03 Work out the distance to move using #R$68DD.
  $6884,$01 Add the distance to the position.
  $6885,$01 #REGa=the new X position.
  $6886,$05 Jump to #R$6812 if the midges have not reached the right edge.
  $688B,$04 Set bit 6 of #REGix+#N$00 (turn the midges round to move left).
  $688F,$03 Jump to #R$6812.
N $6892 The target is to the right and the midges are moving right, so speed up.
@ $6892 label=UpdateMidges_AccelerateRight
  $6892,$01 #REGa=the speed.
  $6893,$04 Jump to #R$687D if the speed is already at the maximum (#N$0F).
  $6897,$01 Increase the speed by one.
  $6898,$02 Jump to #R$687D.
N $689A The target is to the left but the midges are moving right, so slow
. down and turn round when they have stopped.
@ $689A label=UpdateMidges_TargetLeft
  $689A,$02 #REGa=the speed - #N$01.
  $689C,$03 Jump to #R$687D if the speed is not zero.
  $689F,$04 Set bit 6 of #REGix+#N$00 (turn the midges to move left).
  $68A3,$03 Jump to #R$67FF.
N $68A6 The target is below the midges.
@ $68A6 label=UpdateMidges_TargetBelow
  $68A6,$06 Jump to #R$68C8 if the midges are moving up.
  $68AC,$01 #REGa=the speed.
  $68AD,$05 Jump to #R$68B3 if the speed is already at the maximum (#N$0F).
  $68B2,$01 Increase the speed by one.
@ $68B3 label=UpdateMidges_MoveDown
  $68B3,$01 #REGc=the new speed.
  $68B4,$03 #REGh=the Y position of the midges.
  $68B7,$03 Work out the distance to move using #R$68DD.
  $68BA,$01 Add the distance to the position.
  $68BB,$01 #REGa=the new Y position.
  $68BC,$05 Jump to #R$6861 if the midges have not reached the bottom.
  $68C1,$04 Reset bit 7 of #REGix+#N$00 (turn the midges to move up).
  $68C5,$03 Jump to #R$6861.
N $68C8 The target is below the midges but they are moving up, so slow down and
. turn round when they have stopped.
@ $68C8 label=UpdateMidges_TargetBelowMovingUp
  $68C8,$02 #REGa=the speed - #N$01.
  $68CA,$03 Jump to #R$684E if the speed is not zero.
  $68CD,$04 Set bit 7 of #REGix+#N$00 (turn the midges to move down).
  $68D1,$02 Jump to #R$68B3.
N $68D3 The target is above the midges and they are moving up, so speed up.
@ $68D3 label=UpdateMidges_AccelerateUp
  $68D3,$01 #REGa=the speed.
  $68D4,$05 Jump to #R$684E if the speed is already at the maximum (#N$0F).
  $68D9,$01 Increase the speed by one.
  $68DA,$03 Jump to #R$684E.

c $68DD Calculate Midges Movement
@ $68DD label=CalculateMidgesMovement
D $68DD Prepares for the movement of the midges along one axis: a 16-bit
. value which has the position in #REGh and the fraction of a pixel in
. #REGl, and a distance to move which is #N$20 times the speed (so the
. distance is up to #N$01E0 which is just under two pixels).
R $68DD B The fraction of a pixel (in the high nibble)
R $68DD C The speed
R $68DD H The position
R $68DD O:DE The distance to move
R $68DD O:HL The position and the fraction
  $68DD,$01 #REGl=the fraction.
  $68DE,$07 Multiply the speed by sixteen.
  $68E5,$01 #REGe=the speed multiplied by sixteen.
  $68E6,$02 Clear the high byte of the distance in #REGd.
  $68E8,$04 Double #REGde.
  $68EC,$01 Return.

c $68ED Handle Midges Weapon Hit
@ $68ED label=MidgesWeaponHit
D $68ED A weapon has hit the midges. The repellent spray kills them, a
. streamer has no effect and a smoke bomb stuns them (and stops them dead).
R $68ED A State of the weapon
R $68ED IX Midges object
  $68ED,$02,b$01 Keep only bits 0-5 (the type of the weapon).
  $68EF,$04 Jump to #R$6909 if it is the repellent spray.
  $68F3,$05 Jump to #R$67C0 if it is a streamer.
  $68F8,$07 Jump to #R$6B3A if the midges are eating the flower.
  $68FF,$04 Write #N$00 to #REGix+#N$06 (stop the vertical movement).
  $6903,$03 Stun the midges using #R$65CB.
  $6906,$03 Jump to #R$67C0.
@ $6909 label=MidgesWeaponHit_Kill
  $6909,$03 #REGbc=#N$0050 (the points for the kill).
  $690C,$03 Add the points to the score and explode the midges using #R$65D9.

c $690F Find Bug Target
@ $690F label=FindBugTarget
D $690F Finds the object that the midges are chasing. This is Robbie, unless
. he is too close to either edge of the play area or the flower is nearer. The
. distances are measured as the sum of the horizontal and vertical distances
. at half resolution.
R $690F IX Midges object
R $690F O:HL Address of the X position of the target (Robbie or the flower)
  $690F,$03 #REGa=the X position of Robbie.
  $6912,$04 Jump to #R$6967 to use the flower if Robbie is too far to the
. left.
  $6916,$04 Jump to #R$6967 to use the flower if Robbie is too far to the
. right.
N $691A Distance from the midges to Robbie.
  $691A,$03 #REGb=the X position of Robbie / #N$02.
  $691D,$05 #REGa=the X position of the midges / #N$02.
  $6922,$01 Subtract the X position of Robbie.
  $6923,$05 Make sure we have a positive byte.
@ $6928 label=FindBugTarget_Robbie_X
  $6928,$01 #REGb=the horizontal distance.
  $6929,$03 #REGa=the Y position of Robbie.
  $692C,$03 #REGc=the Y position of Robbie / #N$02.
  $692F,$05 #REGa=the Y position of the midges / #N$02.
  $6934,$01 Subtract the Y position of Robbie.
  $6935,$05 Make sure we have a positive byte.
@ $693A label=FindBugTarget_Robbie_Y
  $693A,$01 Add the horizontal distance to get the distance to Robbie.
  $693B,$01 #REGd=the distance to Robbie.
N $693C Distance from the midges to the flower.
  $693C,$03 #REGa=the X position of the flower.
  $693F,$03 #REGb=the X position of the flower / #N$02.
  $6942,$05 #REGa=the X position of the midges / #N$02.
  $6947,$01 Subtract the X position of the flower.
  $6948,$05 Make sure we have a positive byte.
@ $694D label=FindBugTarget_Flower_X
  $694D,$01 #REGb=the horizontal distance.
  $694E,$03 #REGa=the Y position of the flower.
  $6951,$03 #REGc=the Y position of the flower / #N$02.
  $6954,$05 #REGa=the Y position of the midges / #N$02.
  $6959,$01 Subtract the Y position of the flower.
  $695A,$05 Make sure we have a positive byte.
@ $695F label=FindBugTarget_Flower_Y
  $695F,$01 Add the horizontal distance to get the distance to the flower.
  $6960,$01 Compare the distance to the flower with the distance to Robbie.
  $6961,$02 Jump to #R$6967 if the flower is nearer.
  $6963,$03 #REGhl=#R$5E6D (Robbie).
  $6966,$01 Return.
@ $6967 label=FindBugTarget_Flower
  $6967,$03 #REGhl=#R$5E8D (the flower).
  $696A,$01 Return.

c $696B Get Robbie Direction
@ $696B label=GetRobbieDirection
D $696B Used when a weapon is fired. This gets the X position of Robbie and
. tests bit 0 of #R$5E70, which decides the direction of the weapon: the
. weapon is fired to the right when the bit is clear.
R $696B DE #R$5E6F (the colour of Robbie)
R $696B O:A The X position of Robbie
R $696B O:DE #R$5E6D (the X position of Robbie)
R $696B O:F The zero flag is set if the weapon goes to the right
  $696B,$01 Move #REGde onto #R$5E70.
  $696C,$01 #REGa=the direction byte of Robbie.
  $696D,$03 Move #REGde back onto the X position of Robbie.
  $6970,$02,b$01 Keep only bit 0.
  $6972,$01 #REGa=the X position of Robbie.
  $6973,$01 Return.

c $6974 Fire Repellent Spray
@ $6974 label=FireRepellentSpray
D $6974 Starts a repellent spray in the weapon slot held in #R$5E1C, in front
. of Robbie. It is not fired if Robbie is too close to the edge of the play
. area.
R $6974 DE #R$5E6F (the colour of Robbie)
R $6974 HL The weapon object
  $6974,$03 Get the X position and the direction using #R$696B.
  $6977,$02 Jump to #R$6985 if the spray goes to the right.
  $6979,$03 Return if Robbie is too close to the left edge.
  $697C,$02 Subtract #N$0C from the X position (so it starts to the left of
. Robbie).
  $697E,$02 Write #N$48 (a repellent spray moving left) to the state of the
. weapon.
@ $6980 label=FireRepellentSpray_Colour
  $6980,$02 #REGb=#N$45 (the colour of the spray).
  $6982,$03 Jump to #R$6BA5 to create the weapon.
@ $6985 label=FireRepellentSpray_Right
  $6985,$03 Return if Robbie is too close to the right edge.
  $6988,$02 Add #N$18 to the X position (so it starts to the right of Robbie).
  $698A,$02 Write #N$08 (a repellent spray moving right) to the state of the
. weapon.
  $698C,$03 Jump to #R$6980.

c $698F Update Repellent Spray
@ $698F label=UpdateRepellentSpray
D $698F Moves a repellent spray #N$04 pixels at a time in the direction it was
. fired. The spray is removed if it hits a bug (see #R$6A42) or reaches the
. edge of the play area.
R $698F IX Repellent spray object
  $698F,$03 Remember the position and state using #R$75B9.
  $6992,$06 Jump to #R$69B3 to remove the spray if it has hit a bug.
  $6998,$02 #REGa=#N$04 (the distance to move).
  $699A,$06 Jump to #R$69A2 if the spray is moving right (bit 6 is not set).
  $69A0,$02 Negate the distance (move left).
@ $69A2 label=UpdateRepellentSpray_Move
  $69A2,$03 Add the X position of the spray.
  $69A5,$04 Jump to #R$69B3 to remove the spray if it is past the left edge.
  $69A9,$04 Jump to #R$69B3 to remove the spray if it is past the right edge.
  $69AD,$03 Write the new X position.
  $69B0,$03 Jump to #R$6F31 to draw the spray.

c $69B3 Remove Weapon
@ $69B3 label=RemoveWeapon
D $69B3 Erases a weapon and makes the object inactive.
R $69B3 IX Weapon object
  $69B3,$03 Erase the previous sprite using #R$7526.
  $69B6,$04 Write #N$00 to #REGix+#N$00 (the object is inactive).
  $69BA,$01 Return.

c $69BB Fire Streamer
@ $69BB label=FireStreamer
D $69BB Starts a streamer in the weapon slot held in #R$5E1C, in front of
. Robbie. It is not fired if Robbie is too close to the edge of the play
. area. The colour of the streamer is chosen at random.
R $69BB DE #R$5E6F (the colour of Robbie)
R $69BB HL The weapon object
  $69BB,$03 Get the X position and the direction using #R$696B.
  $69BE,$02 Jump to #R$69DF if the streamer goes to the right.
  $69C0,$03 Return if Robbie is too close to the left edge.
  $69C3,$02 Subtract #N$0C from the X position (so it starts to the left of
. Robbie).
  $69C5,$02 Write #N$52 (a streamer moving left) to the state of the weapon.
@ $69C7 label=FireStreamer_Colour
  $69C7,$01 Stash the X position on the stack.
  $69C8,$01 Stash the weapon object on the stack.
  $69C9,$03 #REGa=the random number from #R$5E19.
  $69CC,$02,b$01 Keep only bits 0-1
. (a random colour number from #N$00 to #N$03).
  $69CE,$01 #REGc=the random colour number.
  $69CF,$02 Clear the high byte of the offset in #REGb.
  $69D1,$03 #REGhl=#R$69DB.
  $69D4,$01 Add the offset to find the colour in the table.
  $69D5,$01 #REGb=the colour of the streamer.
  $69D6,$01 Restore the weapon object from the stack.
  $69D7,$01 Restore the X position from the stack.
  $69D8,$03 Jump to #R$6BA5 to create the weapon.

b $69DB Streamer Colours
@ $69DB label=StreamerColours
D $69DB The colours that a streamer can be.
B $69DB,$01 #COLOUR(#PEEK(#PC)).
L $69DB,$01,$04

c $69DF Fire Streamer Right
@ $69DF label=FireStreamer_Right
D $69DF Fires a streamer to the right of Robbie, if he is not too close to
. the right edge of the play area.
R $69DF A The X position of Robbie
R $69DF HL The weapon object
  $69DF,$03 Return if Robbie is too close to the right edge.
  $69E2,$02 Add #N$18 to the X position (so it starts to the right of Robbie).
  $69E4,$02 Write #N$12 (a streamer moving right) to the state of the weapon.
  $69E6,$02 Jump to #R$69C7.

c $69E8 Update Streamer
@ $69E8 label=UpdateStreamer
D $69E8 Moves a streamer #N$08 pixels at a time in the direction it was
. fired. The streamer alternates between two sprites as it travels, and is
. removed if it hits a bug (see #R$6A42) or reaches the edge of the play
. area.
R $69E8 IX Streamer object
  $69E8,$03 Remember the position and state using #R$75B9.
  $69EB,$06 Jump to #R$6A31 to remove the streamer if it has hit a bug.
  $69F1,$02 #REGa=#N$08 (the distance to move).
  $69F3,$06 Jump to #R$69FB if the streamer is moving right (bit 6 is not
. set).
  $69F9,$02 Negate the distance (move left).
@ $69FB label=UpdateStreamer_Move
  $69FB,$03 Add the X position of the streamer.
  $69FE,$04 Jump to #R$6A31 to remove the streamer if it is past the left
. edge.
  $6A02,$04 Jump to #R$6A31 to remove the streamer if it is past the right
. edge.
  $6A06,$03 Write the new X position.
N $6A09 Choose the sprite for the new position, using bit 3 of the X position.
  $6A09,$04 Jump to #R$6A27 if bit 3 of the X position is not set.
  $6A0D,$03 #REGde=#R$7991 (the first sprite).
@ $6A10 label=UpdateStreamer_Draw
  $6A10,$03 Set up the new sprite using #R$74C0.
  $6A13,$01 Switch to the shadow registers.
N $6A14 Choose the sprite for the previous position in the same way.
  $6A14,$03 #REGa=the previous X position from #R$5E0B.
  $6A17,$04 Jump to #R$6A2C if bit 3 of the previous X position is not set.
  $6A1B,$03 #REGde=#R$7991 (the first sprite).
@ $6A1E label=UpdateStreamer_Previous
  $6A1E,$03 Set up the previous sprite using #R$74A8.
  $6A21,$03 Erase the previous sprite and draw the new one using #R$74F2.
  $6A24,$03 Jump to #R$7450 to colour the sprite.
@ $6A27 label=UpdateStreamer_SecondSprite
  $6A27,$03 #REGde=#R$79A2 (the second sprite).
  $6A2A,$02 Jump to #R$6A10.
@ $6A2C label=UpdateStreamer_PreviousSecondSprite
  $6A2C,$03 #REGde=#R$79A2 (the second sprite).
  $6A2F,$02 Jump to #R$6A1E.

c $6A31 Remove Streamer
@ $6A31 label=RemoveStreamer
D $6A31 Erases a streamer, which could be using either of the two sprites, and
. makes the object inactive.
R $6A31 IX Streamer object
  $6A31,$03 #REGde=#R$7991 (the first sprite).
  $6A34,$03 Erase the sprite using #R$7521.
  $6A37,$03 #REGde=#R$79A2 (the second sprite).

c $6A3A Remove Object
@ $6A3A label=RemoveObject
D $6A3A Erases the sprite of an object at its previous position and makes the
. object inactive.
R $6A3A DE Sprite data
R $6A3A IX Object
  $6A3A,$03 Erase the sprite using #R$7521.
  $6A3D,$04 Write #N$00 to #REGix+#N$00 (the object is inactive).
  $6A41,$01 Return.

c $6A42 Check Weapon Hit
@ $6A42 label=CheckWeaponHit
D $6A42 Checks whether a bug is touching either of the two weapon objects (the
. weapon has to be within #N$0F pixels horizontally and #N$0C pixels
. vertically). If it is, the "hit" flag of the weapon (#REGix+#N$05 of the
. weapon) is set so that the weapon removes itself. This does not check
. whether the weapon is active, so the caller does that using the state
. which is returned in #REGc.
R $6A42 IX Bug object
R $6A42 O:C The state of the weapon which was checked
R $6A42 O:E #N$00 No weapon hit the bug
R $6A42 O:E #N$01 A weapon hit the bug
  $6A42,$03 #REGhl=#R$5E7C (the first weapon object).
  $6A45,$02 Set the weapon counter to #N$02.
@ $6A47 label=CheckWeaponHit_Loop
  $6A47,$03 #REGa=the X position of the bug.
  $6A4A,$01 #REGc=the state of the weapon.
  $6A4B,$01 Move onto the X position of the weapon.
  $6A4C,$01 Subtract the X position of the weapon.
  $6A4D,$05 Make sure we have a positive byte.
@ $6A52 label=CheckWeaponHit_Test_X
  $6A52,$04 Jump to #R$6A6B if the weapon is #N$10 pixels or more away.
  $6A56,$03 #REGa=the Y position of the bug.
  $6A59,$01 Move onto the Y position of the weapon.
  $6A5A,$01 Subtract the Y position of the weapon.
  $6A5B,$05 Make sure we have a positive byte.
@ $6A60 label=CheckWeaponHit_Test_Y
  $6A60,$04 Jump to #R$6A6B if the weapon is #N$0D pixels or more away.
  $6A64,$03 Move onto the "hit" flag of the weapon.
  $6A67,$02 #REGe=#N$01 (a weapon has hit the bug).
  $6A69,$01 Set the "hit" flag of the weapon.
  $6A6A,$01 Return.
@ $6A6B label=CheckWeaponHit_Next
  $6A6B,$03 #REGhl=#R$5E84 (the second weapon object).
  $6A6E,$02 Decrease the weapon counter by one and loop back to #R$6A47 until
. both weapons have been checked.
  $6A70,$02 #REGe=#N$00 (no hit).
  $6A72,$01 Return.

c $6A73 Explode Robbie
@ $6A73 label=ExplodeRobbie
D $6A73 A bug has touched Robbie. The bug explodes, and then so does Robbie:
. the position and state of Robbie are copied to the explosion object, and
. Robbie and the spray can are made inactive.
R $6A73 IX Bug object
  $6A73,$03 Explode the bug using #R$65DC.
@ $6A76 label=ExplodeRobbie_Flower
  $6A76,$02 Stash #REGix on the stack.
  $6A78,$04 #REGix=#R$5EE4 (the explosion object).
  $6A7C,$04 #REGc=the state of Robbie from #R$5E6C.
  $6A80,$02 #REGa=the X position of Robbie.
  $6A82,$03 Write it to the explosion object.
  $6A85,$02 #REGa=the Y position of Robbie.
  $6A87,$03 Write it to the explosion object.
  $6A8A,$01 #REGa=the old state of Robbie.
  $6A8B,$03 Start the explosion using #R$65F1.
  $6A8E,$02 Restore #REGix from the stack.
  $6A90,$07 Write #N$00 to #R$5E6C and #R$5E74 to make Robbie and the spray
. can inactive.
  $6A97,$01 Return.

c $6A98 Update Slug
@ $6A98 label=UpdateSlug
D $6A98 Updates a slug. If the slug is touching Robbie then both explode. A
. weapon hitting the slug either kills it (a smoke bomb, worth #N$35
. points) or stuns it (a streamer), and the repellent spray has no effect.
. When the slug reaches the flower it starts to eat it.
. .
. Otherwise it crawls around, moving once every four updates: #N$04 pixels
. horizontally, bouncing off the sides of the play area, and #N$01 pixel
. vertically (but only when it is in the middle of the play area).
R $6A98 IX Slug object
N $6A98 The object fields used are:
. #TABLE(default,centre)
. { =h Field | =h Use }
. { +0 bit 6 | Moving right }
. { +0 bit 7 | Moving down }
. { +4 bit 3 | Eating the flower }
. { +5 | Stun timer }
. { +6 | Y position when the slug started eating }
. TABLE#
  $6A98,$03 Do the common bug checks using #R$64ED.
  $6A9B,$01 Decrease the collision result in #REGe by one
. (zero means that the slug is touching Robbie).
  $6A9C,$03 Jump to #R$6A73 if the slug is touching Robbie.
  $6A9F,$03 Call #R$6A42 to check whether a weapon has hit the slug.
  $6AA2,$01 Decrease the collision result in #REGe by one
. (zero means that a weapon has hit the slug).
  $6AA3,$02 Jump to #R$6AAA if there was no hit.
  $6AA5,$05 #REGa=the state of the weapon, and jump to #R$6B20 if the weapon
. is active.
@ $6AAA label=UpdateSlug_NoWeaponHit
  $6AAA,$07 Jump to #R$6B3A if the slug is eating the flower.
  $6AB1,$03 Check whether the slug has reached the flower using #R$644D.
  $6AB4,$01 Decrease the collision result in #REGe by one
. (zero means that the slug has reached the flower).
  $6AB5,$03 Jump to #R$679C if the slug has reached the flower, to start
. eating it.
  $6AB8,$06 Jump to #R$6AC3 if the stun timer in #REGix+#N$05 is zero.
N $6ABE See #POKE(worms_stay_stunned,Worms stay stunned).
  $6ABE,$03 Decrease the stun timer by one.
  $6AC1,$02 Jump to #R$6AF9 to draw the slug without moving it.
@ $6AC3 label=UpdateSlug_Move
  $6AC3,$03 #REGa=the game timer from #R$5E17.
  $6AC6,$02,b$01 Keep only bits 0-1 (the slug only moves every fourth update).
  $6AC8,$02 Jump to #R$6AF9 to draw the slug if it is not time to move.
  $6ACA,$03 #REGa=the X position of the slug.
  $6ACD,$04 Jump to #R$6AE7 if the slug is too far to the left to move
. vertically.
  $6AD1,$04 Jump to #R$6AE7 if the slug is too far to the right to move
. vertically.
  $6AD5,$03 #REGa=the Y position of the slug.
  $6AD8,$06 Jump to #R$6AFC if the slug is moving up (bit 7 is not set).
  $6ADE,$02 Add #N$01 to move down.
  $6AE0,$04 Jump to #R$6B08 if the slug has reached the bottom.
@ $6AE4 label=UpdateSlug_StoreY
  $6AE4,$03 Write the new Y position.
@ $6AE7 label=UpdateSlug_Horizontal
  $6AE7,$03 #REGa=the X position of the slug.
  $6AEA,$06 Jump to #R$6B0E if the slug is moving left (bit 6 is not set).
  $6AF0,$02 Add #N$04 to move right.
  $6AF2,$04 Jump to #R$6B1A if the slug has reached the right edge.
@ $6AF6 label=UpdateSlug_StoreX
  $6AF6,$03 Write the new X position.
@ $6AF9 label=UpdateSlug_Draw
  $6AF9,$03 Jump to #R$6F31 to draw the slug.
@ $6AFC label=UpdateSlug_MoveUp
  $6AFC,$02 Subtract #N$01 to move up.
  $6AFE,$04 Jump to #R$6AE4 if the slug has not reached the top.
  $6B02,$04 Set bit 7 of #REGix+#N$00 (turn the slug downwards).
  $6B06,$02 Jump to #R$6AE7.
@ $6B08 label=UpdateSlug_TurnUp
  $6B08,$04 Reset bit 7 of #REGix+#N$00 (turn the slug upwards).
  $6B0C,$02 Jump to #R$6AE7.
@ $6B0E label=UpdateSlug_MoveLeft
  $6B0E,$02 Subtract #N$04 to move left.
  $6B10,$04 Jump to #R$6AF6 if the slug has not reached the left edge.
  $6B14,$04 Set bit 6 of #REGix+#N$00 (turn the slug to the right).
  $6B18,$02 Jump to #R$6AF9.
@ $6B1A label=UpdateSlug_TurnLeft
  $6B1A,$04 Reset bit 6 of #REGix+#N$00 (turn the slug to the left).
  $6B1E,$02 Jump to #R$6AF9.

c $6B20 Handle Slug Weapon Hit
@ $6B20 label=SlugWeaponHit
D $6B20 A weapon has hit the slug. A smoke bomb kills it, a streamer stuns it
. and the repellent spray has no effect.
R $6B20 A State of the weapon
R $6B20 IX Slug object
  $6B20,$02,b$01 Keep only bits 0-5 (the type of the weapon).
  $6B22,$04 Jump to #R$6B34 if the weapon is a streamer.
  $6B26,$05 Jump to #R$6AAA if the weapon is the repellent spray.
  $6B2B,$03 #REGbc=#N$0035 (the points for the kill).
  $6B2E,$03 Add the points to the score using #R$737A.
  $6B31,$03 Jump to #R$65DC to explode the slug.
@ $6B34 label=SlugWeaponHit_Stun
  $6B34,$03 Stun the slug using #R$65CB.
  $6B37,$03 Jump to #R$6AAA.

c $6B3A Eat Flower
@ $6B3A label=EatFlower
D $6B3A Updates a bug which is eating the flower. Every update adds one to the
. count of the bugs that are eating in #R$5E3B (which the flower uses to
. decide whether to sink, see #R$6D0C), and the bug wobbles up and down. When
. the flower has sunk below the bug, it stops eating.
R $6B3A IX Bug object
  $6B3A,$03 Increment the eating counter in #REGix+#N$05 by one.
  $6B3D,$07 Increment #R$5E3B by one.
  $6B44,$04 Test bit 3 of #REGix+#N$05 (the bug moves up and down as it eats).
  $6B48,$03 #REGa=the Y position the bug started eating at, from
. #REGix+#N$06.
  $6B4B,$02 Jump to #R$6B4E if bit 3 is set.
  $6B4D,$01 Move the bug up by one pixel.
@ $6B4E label=EatFlower_StoreY
  $6B4E,$03 Write the new Y position.
  $6B51,$03 #REGa=the Y position of the flower.
  $6B54,$02 Halve it.
  $6B56,$02 Subtract #N$02.
  $6B58,$01 #REGc=the position of the top of the flower.
  $6B59,$03 #REGa=the Y position of the bug.
  $6B5C,$02 Halve it.
  $6B5E,$01 Subtract the flower position.
  $6B5F,$03 Jump to #R$6AF9 to draw the bug if it is not above the flower.
  $6B62,$04 Reset bit 3 of #REGix+#N$04 (the bug stops eating).
  $6B66,$01 #REGa=#N$00.
  $6B67,$03 Write #N$00 to #REGix+#N$05.
  $6B6A,$03 Write #N$00 to #REGix+#N$06.
  $6B6D,$03 Jump to #R$6AF9 to draw the bug.

c $6B70 Fire Weapon
@ $6B70 label=FireWeapon
D $6B70 Fires a weapon from Robbie's spray can into an empty weapon slot, but
. only on every eighth frame. The colour in #R$5E6F decides which weapon it
. is: #N$42 fires a streamer, #N$46 fires the repellent spray and anything
. else fires a smoke bomb.
  $6B70,$03 #REGa=#SKOOLKID$5C78(FRAMES).
  $6B73,$02,b$01 Keep only bits 0-2.
  $6B75,$01 Return if the frame is not a multiple of eight.
  $6B76,$03 #REGhl=#R$5E7C (the first weapon object).
  $6B79,$03 #REGde=#N$0008 (the size of an object).
  $6B7C,$02 Set the weapon counter to #N$02.
@ $6B7E label=FireWeapon_Loop
  $6B7E,$04 Jump to #R$6B86 if the weapon slot is empty.
  $6B82,$01 Move onto the next weapon object.
  $6B83,$02 Decrease the weapon counter by one and loop back to #R$6B7E until
. both weapon slots have been checked.
  $6B85,$01 Return.
@ $6B86 label=FireWeapon_Slot
  $6B86,$03 Write the weapon slot to #R$5E1C.
  $6B89,$03 #REGde=#R$5E6F (the colour of Robbie).
  $6B8C,$01 #REGa=the colour of Robbie (which tells us which weapon he has).
  $6B8D,$05 Jump to #R$69BB to fire a streamer if it matches.
  $6B92,$05 Jump to #R$6974 to fire the repellent spray if it matches.
N $6B97 Fire a smoke bomb.
  $6B97,$03 Get the X position and the direction using #R$696B.
  $6B9A,$02 Jump to #R$6BC7 if the smoke bomb goes to the right.
  $6B9C,$03 Return if Robbie is too close to the left edge.
  $6B9F,$02 Subtract #N$0C from the X position (so it starts to the left of
. Robbie).
  $6BA1,$02 Write #N$44 (a smoke bomb moving left) to the state of the weapon.
@ $6BA3 label=FireWeapon_SmokeColour
  $6BA3,$02 #REGb=#N$47 (the colour of the smoke bomb).

c $6BA5 Create Weapon
@ $6BA5 label=CreateWeapon
D $6BA5 Writes the position and the colour of a new weapon into its object and
. plays the sound for the type of the weapon. The weapon starts #N$0C pixels
. above Robbie.
R $6BA5 A The X position of the weapon
R $6BA5 B The colour of the weapon
R $6BA5 DE #R$5E6D (the X position of Robbie)
R $6BA5 HL The weapon object (which has the state already written)
  $6BA5,$01 Move onto the X position of the weapon.
  $6BA6,$01 Write the X position.
  $6BA7,$01 Move onto the Y position of Robbie.
  $6BA8,$01 Move onto the Y position of the weapon.
  $6BA9,$01 #REGa=the Y position of Robbie.
  $6BAA,$02 Subtract #N$0C.
  $6BAC,$01 Write the Y position.
  $6BAD,$01 Move onto the colour of the weapon.
  $6BAE,$01 Write the colour.
  $6BAF,$01 Move onto #REGix+#N$04 of the weapon.
  $6BB0,$01 #REGa=#N$00.
  $6BB1,$01 Write #N$00 to #REGix+#N$04.
  $6BB2,$01 Move onto #REGix+#N$05 of the weapon (the "hit" flag).
  $6BB3,$01 Write #N$00 to #REGix+#N$05.
  $6BB4,$03 #REGhl=the weapon object from #R$5E1C.
  $6BB7,$01 #REGa=the state of the weapon.
  $6BB8,$02,b$01 Keep only bits 0-5 (the type of the weapon).
  $6BBA,$05 Jump to #R$649E to play the repellent sound if it matches.
  $6BBF,$05 Jump to #R$64B8 to play the streamer sound if it matches.
  $6BC4,$03 Jump to #R$64C9 to play the smoke sound.

c $6BC7 Fire Smoke Bomb Right
@ $6BC7 label=FireSmokeBomb_Right
D $6BC7 Fires a smoke bomb to the right of Robbie, if he is not too close to
. the right edge of the play area.
R $6BC7 A The X position of Robbie
R $6BC7 HL The weapon object
  $6BC7,$03 Return if Robbie is too close to the right edge.
  $6BCA,$02 Add #N$18 to the X position (so it starts to the right of Robbie).
  $6BCC,$02 Write #N$04 (a smoke bomb moving right) to the state of the weapon.
  $6BCE,$02 Jump to #R$6BA3.

c $6BD0 Update Smoke Bomb
@ $6BD0 label=UpdateSmokeBomb
D $6BD0 Moves a smoke bomb #N$04 pixels at a time in the direction it was
. fired. Every sixteen updates it grows into the next size of cloud (types
. #N$04 to #N$06). The bomb is removed if it hits a bug (see #R$6A42) or
. reaches the edge of the play area.
R $6BD0 IX Smoke bomb object
  $6BD0,$03 Remember the position and state using #R$75B9.
  $6BD3,$07 Jump to #R$69B3 to remove the bomb if it has hit a bug.
  $6BDA,$03 Increment the age of the bomb in #REGix+#N$04 by one.
  $6BDD,$03 #REGa=the age of the bomb.
  $6BE0,$02,b$01 Keep only bits 0-3 (every sixteenth update).
  $6BE2,$03 Call #R$6C02 every sixteen updates.
  $6BE5,$02 #REGa=#N$04 (the distance to move).
  $6BE7,$06 Jump to #R$6BEF if the bomb is moving right (bit 6 is not set).
  $6BED,$02 Negate the distance (move left).
@ $6BEF label=UpdateSmokeBomb_Move
  $6BEF,$03 Add the X position of the bomb.
  $6BF2,$05 Jump to #R$69B3 to remove the bomb if it is past the left edge.
  $6BF7,$05 Jump to #R$69B3 to remove the bomb if it is past the right edge.
  $6BFC,$03 Write the new X position.
  $6BFF,$03 Jump to #R$6F31 to draw the bomb.

c $6C02 Grow Smoke Bomb
@ $6C02 label=GrowSmokeBomb
D $6C02 Moves a smoke bomb onto the next size of cloud, up to type #N$06.
R $6C02 IX Smoke bomb object
  $6C02,$03 #REGa=the state of the bomb.
  $6C05,$02,b$01 Keep only bits 0-5 (the type).
  $6C07,$02 Compare the type with #N$06 (the largest cloud).
  $6C09,$01 Return if the bomb is already the largest cloud.
  $6C0A,$03 Increment the state of the bomb by one.
  $6C0D,$01 Return.

c $6C0E Grow Leaf
@ $6C0E label=GrowLeaf
D $6C0E Looks for an inactive leaf object and, if there is one, starts a new
. leaf growing on the flower. The leaves alternate between the right and the
. left of the flower using bit 6 of #R$5E15, and bit 0 of #R$5E15 is set to
. stop another leaf being added until the flower has moved again.
  $6C0E,$03 #REGhl=#R$5E94 (the first leaf object).
  $6C11,$02 Set the leaf counter to #N$04.
  $6C13,$03 #REGde=#N$0008 (the size of an object).
@ $6C16 label=GrowLeaf_Loop
  $6C16,$04 Jump to #R$6C1E if the leaf is inactive.
  $6C1A,$01 Move onto the next leaf object.
  $6C1B,$02 Decrease the leaf counter by one and loop back to #R$6C16 until all
. four leaves have been checked.
  $6C1D,$01 Return.
@ $6C1E label=GrowLeaf_Found
  $6C1E,$03 #REGa=#R$5E15.
  $6C21,$02,b$01 Flip bit 6.
  $6C23,$02,b$01 Set bit 0.
  $6C25,$03 Write it back to #R$5E15.
  $6C28,$01 Stash the leaf object on the stack.
  $6C29,$01 #REGde=the leaf object.
  $6C2A,$03 #REGhl=#R$5F38 (the default leaf).
  $6C2D,$03 #REGbc=#N$0008 (the size of an object).
  $6C30,$02 Copy the default leaf into the leaf object.
  $6C32,$01 Restore the leaf object from the stack.
  $6C33,$03 #REGa=#R$5E15.
  $6C36,$02,b$01 Keep only bit 6.
  $6C38,$03 #REGde=#R$5E8D (the X position of the flower).
  $6C3B,$01 #REGa=the X position of the flower.
  $6C3C,$02 Jump to #R$6C4D if bit 6 was not set, to put the leaf on the left.
  $6C3E,$02 Add #N$08.
@ $6C40 label=GrowLeaf_Position
  $6C40,$01 Move onto the X position of the leaf.
  $6C41,$01 Write the X position.
  $6C42,$01 Move onto the Y position of the flower.
  $6C43,$01 Move onto the Y position of the leaf.
  $6C44,$01 #REGa=the Y position of the flower.
  $6C45,$02 Add #N$07.
  $6C47,$01 Write the Y position.
  $6C48,$03 #REGhl=#R$5E90 (the number of leaves on the flower).
  $6C4B,$01 Increment the number of leaves by one.
  $6C4C,$01 Return.
@ $6C4D label=GrowLeaf_Left
  $6C4D,$02 Set bit 6 of the state of the leaf (so it faces left).
  $6C4F,$02 Subtract #N$10.
  $6C51,$02 Jump to #R$6C40.

c $6C53 Update Leaf
@ $6C53 label=UpdateLeaf
D $6C53 Updates a leaf of the flower. A new leaf grows through four frames
. (one every eight updates), an eaten leaf shrinks back through them (one
. every four updates) and is then removed. A leaf is eaten if the
. flower sinks down to the level of the leaf, or when a bug touches it (see
. #R$63AA).
R $6C53 IX Leaf object
N $6C53 The object fields used are:
. #TABLE(default,centre)
. { =h Field | =h Use }
. { +0 bit 6 | The leaf is on the left of the flower }
. { +4 | The leaf is growing or shrinking }
. { +5 | The leaf is being eaten (shrinking) }
. { +6 | The frame of the leaf (#N$00 to #N$03) }
. TABLE#
  $6C53,$03 Remember the position and state using #R$75B9.
  $6C56,$03 #REGa=the Y position of the flower.
  $6C59,$03 Compare it with the Y position of the leaf.
  $6C5C,$02 Jump to #R$6C66 if the flower is above the leaf.
  $6C5E,$04 Write #N$01 to #REGix+#N$05 (the leaf is being eaten).
  $6C62,$04 Write #N$01 to #REGix+#N$04 (the leaf is animating).
@ $6C66 label=UpdateLeaf_Animate
  $6C66,$06 Jump to #R$6CBE if the leaf is not animating.
  $6C6C,$06 Jump to #R$6C9C if the leaf is being eaten.
N $6C72 The leaf is growing, which is done every eighth update.
  $6C72,$03 #REGa=#R$5E17.
  $6C75,$01 Invert all of the bits in #REGa.
  $6C76,$02,b$01 Keep only bits 0-2.
  $6C78,$02 Jump to #R$6CBE if it is not time for the next frame.
  $6C7A,$03 Get the sprite of the current frame using #R$6CC7.
  $6C7D,$03 Set up the previous sprite using #R$74A8.
  $6C80,$01 Switch to the shadow registers.
  $6C81,$03 Increment the frame in #REGix+#N$06 by one.
  $6C84,$03 #REGa=the frame.
  $6C87,$04 Jump to #R$6C8F if it is not the last frame.
  $6C8B,$04 Write #N$00 to #REGix+#N$04 (the leaf stops animating).
@ $6C8F label=UpdateLeaf_Draw
  $6C8F,$03 Get the sprite of the new frame using #R$6CC7.
  $6C92,$03 Set up the new sprite using #R$74C0.
  $6C95,$01 Switch to the shadow registers.
  $6C96,$03 Erase the previous sprite and draw the new one using #R$74F2.
  $6C99,$03 Jump to #R$7450 to colour the sprite.
N $6C9C The leaf is being eaten, which is done every fourth update.
@ $6C9C label=UpdateLeaf_Eaten
  $6C9C,$03 #REGa=#R$5E17.
  $6C9F,$02,b$01 Keep only bits 0-1.
  $6CA1,$02 Jump to #R$6CBE if it is not time for the next frame.
  $6CA3,$03 Get the sprite of the current frame using #R$6CC7.
  $6CA6,$03 Set up the previous sprite using #R$74A8.
  $6CA9,$01 Switch to the shadow registers.
  $6CAA,$03 Decrease the frame in #REGix+#N$06 by one.
  $6CAD,$03 Jump to #R$6C8F to draw the new frame if there is one.
N $6CB0 The leaf has gone, so remove it.
  $6CB0,$03 Put the frame back to #N$00.
  $6CB3,$03 Get the sprite of the first frame using #R$6CC7.
  $6CB6,$03 Erase the leaf and make it inactive using #R$6A3A.
  $6CB9,$03 #REGhl=#R$5E90 (the number of leaves on the flower).
  $6CBC,$01 Decrease the number of leaves by one.
  $6CBD,$01 Return.
@ $6CBE label=UpdateLeaf_Static
  $6CBE,$03 Get the sprite of the current frame using #R$6CC7.
  $6CC1,$03 Draw the sprite using #R$751C.
  $6CC4,$03 Jump to #R$7450 to colour the sprite.

c $6CC7 Get Leaf Sprite
@ $6CC7 label=GetLeafSprite
D $6CC7 Finds the sprite for the frame of a leaf. There are four frames for a
. leaf on the right and four for a leaf on the left.
R $6CC7 IX Leaf object
R $6CC7 O:DE Sprite data
  $6CC7,$03 #REGa=the state of the leaf.
  $6CCA,$03 Rotate bit 6 round to bit 3.
  $6CCD,$02,b$01 Keep only bit 3.
  $6CCF,$01 #REGc=#N$08 if the leaf is on the left, or #N$00 if not.
  $6CD0,$03 #REGa=the frame of the leaf.
  $6CD3,$02 Double the frame to make an offset into the table.
  $6CD5,$01 Add the offset for the side of the flower.
  $6CD6,$03 #REGhl=#R$6CE1.
@ $6CD9 label=GetSpriteFromTable
  $6CD9,$01 #REGc=the offset.
  $6CDA,$02 #REGb=#N$00.
  $6CDC,$01 Add the offset to #REGhl.
  $6CDD,$01 #REGe=the low byte of the sprite address.
  $6CDE,$01 Move onto the high byte.
  $6CDF,$01 #REGd=the high byte of the sprite address.
  $6CE0,$01 Return.

w $6CE1 Leaf Sprite Table
@ $6CE1 label=LeafSpriteTable
D $6CE1 The sprite for each frame of a leaf: four for a leaf on the right of
. the flower and then four for a leaf on the left.
  $6CE1,$10,$02

c $6CF1 Sink Flower
@ $6CF1 label=SinkFlower
D $6CF1 Moves the flower down one pixel, and sets the time until the next move
. to #N$0F minus twice the number of bugs eating the flower. If the flower
. reaches the bottom of the play area it has been eaten, and Robbie is
. blown up using #R$6A76.
R $6CF1 IX Flower object
  $6CF1,$03 #REGa=the Y position of the flower.
  $6CF4,$05 Jump to #R$6A76 if the flower has reached the bottom.
  $6CF9,$03 Increment the Y position of the flower by one.
  $6CFC,$03 #REGa=the number of bugs eating the flower from #R$5E3B.
  $6CFF,$02 Double it.
  $6D01,$02 Negate it.
  $6D03,$02 Add #N$0F.
  $6D05,$02 Jump to #R$6D52.

c $6D07 Draw Flower
@ $6D07 label=DrawFlower
D $6D07 Draws the flower without moving it.
R $6D07 DE Sprite data
R $6D07 IX Flower object
  $6D07,$03 Draw the sprite using #R$751C.
  $6D0A,$02 Jump to #R$6D60.

c $6D0C Update Flower
@ $6D0C label=UpdateFlower
D $6D0C Updates the flower. Nothing happens until Robbie is active and the
. "get ready" delay has finished. The number of bugs which were eating the
. flower in the last pass of the main loop is in #R$5E3B (which is reset
. here once it has been read), and the flower then does one of three things
. each time the timer in #REGix+#N$05 runs out:
. #LIST
. { grows by one pixel if no bugs are eating it, and the time until the next
. step is #N$20 minus four times the number of leaves (see #R$6D3E); }
. { stays where it is if one bug is eating it; }
. { sinks by one pixel if more than one bug is eating it (see #R$6CF1). }
. LIST#
. Every time the flower reaches a multiple of sixteen pixels in height, a new
. leaf is grown using #R$6C0E. If the flower reaches the top it blooms using
. #R$668E.
R $6D0C IX Flower object
N $6D0C The object fields used are:
. #TABLE(default,centre)
. { =h Field | =h Use }
. { +4 | The number of leaves on the flower }
. { +5 | The timer until the flower next moves }
. { +6 | The number of bugs that were eating the flower last time }
. TABLE#
  $6D0C,$03 Remember the position and state using #R$75B9.
  $6D0F,$03 #REGde=#R$769A (the flower sprite).
  $6D12,$06 Jump to #R$6D07 to draw the flower if Robbie is inactive.
  $6D18,$06 Jump to #R$6D07 to draw the flower if the "get ready" delay in
. #R$5E22 is not finished.
  $6D1E,$03 #REGa=the number of bugs eating the flower from #R$5E3B.
  $6D21,$03 Compare it with the number in #REGix+#N$06.
  $6D24,$02 Jump to #R$6D2D if it has not changed.
  $6D26,$03 Remember the new number in #REGix+#N$06.
  $6D29,$04 Write #N$01 to #REGix+#N$05 so that the timer runs out straight
. away.
@ $6D2D label=UpdateFlower_Timer
  $6D2D,$03 Decrease the timer in #REGix+#N$05 by one.
  $6D30,$02 Jump to #R$6D07 to draw the flower if the timer has not run out.
  $6D32,$03 #REGa=the number of bugs eating the flower from #R$5E3B.
  $6D35,$01 Test the number.
  $6D36,$02 Jump to #R$6D3E if no bugs are eating the flower.
  $6D38,$04 Jump to #R$6D07 to draw the flower if only one bug is eating it.
  $6D3C,$02 Jump to #R$6CF1 to sink the flower.
@ $6D3E label=UpdateFlower_Grow
  $6D3E,$03 Decrease the Y position of the flower by one.
  $6D41,$03 #REGa=the number of leaves from #REGix+#N$04.
  $6D44,$02 Multiply it by four.
  $6D46,$01 #REGb=four times the number of leaves.
  $6D47,$03 #REGa=the Y position of the flower.
  $6D4A,$05 Jump to #R$668E if the flower has reached the top.
  $6D4F,$02 #REGa=#N$20.
  $6D51,$01 Subtract four times the number of leaves.
@ $6D52 label=UpdateFlower_SetTimer
  $6D52,$03 Write the time until the next move to #REGix+#N$05.
  $6D55,$03 #REGa=#R$5E15.
  $6D58,$02,b$01 Keep only bit 6.
  $6D5A,$03 Write it back to #R$5E15 (so bit 0 is reset and a leaf can be
. added).
  $6D5D,$03 Move the flower sprite using #R$74DF.
@ $6D60 label=UpdateFlower_Colour
  $6D60,$03 Colour the sprite using #R$7450.
N $6D63 Draw the stem of the flower from the flower down to the ground.
  $6D63,$03 #REGl=the X position of the flower.
  $6D66,$03 #REGh=the Y position of the flower.
@ $6D69 label=UpdateFlower_Stem_Loop
  $6D69,$01 #REGa=the Y position.
  $6D6A,$04 Jump to #R$6D84 if the bottom of the stem has been reached.
  $6D6E,$01 Invert all of the bits in #REGa.
  $6D6F,$02,b$01 Keep only bits 0-2.
  $6D71,$02 Jump to #R$6D7A unless this is the last pixel row in a cell.
  $6D73,$01 Stash the position on the stack.
  $6D74,$03 Convert the position to an attribute buffer address using #R$748F.
  $6D77,$02 Write #N$7C (bright green on white) to the attribute buffer.
  $6D79,$01 Restore the position from the stack.
@ $6D7A label=UpdateFlower_Stem_Pixels
  $6D7A,$01 Stash the position on the stack.
  $6D7B,$03 Convert the position to a screen address using #R$759A.
  $6D7E,$02 Write #N$B9 to the screen.
  $6D80,$01 Restore the position from the stack.
  $6D81,$01 Move down one pixel row.
  $6D82,$02 Jump to #R$6D69.
@ $6D84 label=UpdateFlower_Finish
  $6D84,$04 Write #N$00 to #R$5E3B (the number of bugs eating the flower).
  $6D88,$03 #REGa=the number of leaves from #REGix+#N$04.
  $6D8B,$01 Test the number.
  $6D8C,$01 Return if it is negative.
  $6D8D,$03 #REGa=#R$5E15.
  $6D90,$02,b$01 Keep only bit 0.
  $6D92,$01 Return if a leaf has already been added.
  $6D93,$03 #REGa=the Y position of the flower.
  $6D96,$02,b$01 Keep only bits 0-3.
  $6D98,$01 Return unless the Y position is a multiple of sixteen.
  $6D99,$03 Jump to #R$6C0E to grow a leaf.

c $6D9C Read Player Input
@ $6D9C label=ReadInput
D $6D9C Reads the controls, using either the Kempston joystick or the keyboard
. depending on the option chosen on the game selection screen. The bits of the
. result are reset when the control is being used:
. #TABLE(default,centre,centre,centre)
. { =h Bit | =h Joystick | =h Key }
. { 0 | Right | W }
. { 1 | Left | Q }
. { 2 | Down | E }
. { 3 | Up | R }
. { 4 | Fire | T }
. TABLE#
R $6D9C O:A The controls
  $6D9C,$08 Jump to #R$75CC if #R$5E03 is set to joystick controls.
N $6DA4 Read keyboard input.
  $6DA4,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { $FB | Q | W | E | R | T }
. TABLE#
N $6DAA Convert the bits into game compatible bits (as in, see #R$75CC - as this is what is being matched).
  $6DAA,$01 Remember the keys that have been read in #REGc.
  $6DAB,$01 Rotate the keys right once, so that the W key (right) is in bit 0.
  $6DAC,$02,b$01 Keep only bit 0 (right).
  $6DAE,$01 Store the right key in #REGe.
  $6DAF,$01 Restore the keys that were read.
  $6DB0,$01 Rotate the keys left once, so that the Q key (left) is in bit 1.
  $6DB1,$02,b$01 Keep only bit 1 (left).
  $6DB3,$01 Combine it with the right key.
  $6DB4,$01 Store the right and left keys in #REGe.
  $6DB5,$01 Restore the keys that were read.
  $6DB6,$02,b$01 Keep only bits 2-4 (the E, R and T keys: down, up and fire).
  $6DB8,$01 Combine them with the right and left keys.
  $6DB9,$01 Return.

c $6DBA Game Play Entry
@ $6DBA label=GamePlayEntry
D $6DBA Handles Robbie while he is not carrying a spray can (Robbie state
. #N$01). While the "get ready" delay in #R$5E22 counts down, Robbie does
. nothing and the label for the player flashes. After that, the controls move
. him around the play area. When he walks into a cubby hole which contains a
. spray can he picks it up and becomes Robbie carrying a can (see #R$6EF1).
. Walking into a cubby hole which has a bonus item in it collects the item
. (see #R$721A).
E $6DBA View the equivalent code in;
. #LIST
. { #COOKIE$7048 }
. { #JETPAC$73B2 }
. { #SABREWULF$AECF }
. LIST#
R $6DBA IX Robbie object
N $6DBA The Robbie object fields used (here and in #R$6EF1) are:
. #TABLE(default,centre)
. { =h Field | =h Use }
. { +0 | The state: #N$01 when empty-handed and #N$02 when carrying a can }
. { +3 | The colour (white when empty-handed, otherwise the colour of the can) }
. { +4 bit 0 | Facing left (Robbie faces right if this is not set) }
. { +4 bit 2 | Cannot pick up or drop a can (until he has moved away) }
. { +4 bit 3 | Has just picked up a can }
. { +6 | The item last dropped into a cubby hole }
. TABLE#
  $6DBA,$03 #REGhl=#R$5E22 (the "get ready" delay).
  $6DBD,$04 Jump to #R$6DDB if the delay is zero.
  $6DC1,$01 Decrease the delay by one.
  $6DC2,$03 Jump to #R$619E to flash the player label if the delay has not run
. out (which returns to the main loop).
  $6DC5,$03 #REGa=the current player from #R$5E1E.
  $6DC8,$03 Jump to #R$6DD6 if it is the second player.
  $6DCB,$03 #REGhl=#N$0018 (the position of the label for 1UP).
@ $6DCE label=Robbie_EmptyHanded_GetReady
  $6DCE,$03 Stop the player label flashing using #R$61B4.
  $6DD1,$03 Play a tone using #R$64E7.
  $6DD4,$02 Jump to #R$6DDB.
@ $6DD6 label=Robbie_EmptyHanded_GetReady2UP
  $6DD6,$03 #REGhl=#N$00D8 (the position of the label for 2UP).
  $6DD9,$02 Jump to #R$6DCE.
N $6DDB Once Robbie is away from the cubby holes he can pick up and drop things
. again.
@ $6DDB label=Robbie_EmptyHanded_Move
  $6DDB,$03 #REGa=the X position of Robbie.
  $6DDE,$04 Jump to #R$6DEA if Robbie is too far to the left.
  $6DE2,$04 Jump to #R$6DEA if Robbie is too far to the right.
  $6DE6,$04 Reset bit 2 of #REGix+#N$04.
@ $6DEA label=Robbie_EmptyHanded_Input
  $6DEA,$03 Remember the position and state using #R$75B9.
  $6DED,$03 Read the controls using #R$6D9C.
  $6DF0,$04 Jump to #R$6E11 if right is being pressed.
  $6DF4,$04 Jump to #R$6E1F if left is being pressed.
@ $6DF8 label=Robbie_EmptyHanded_Vertical
  $6DF8,$03 #REGa=the X position of Robbie.
  $6DFB,$04 Jump to #R$6E0E if Robbie is in the cubby hole column on the left.
  $6DFF,$04 Jump to #R$6E0E if Robbie is in the cubby hole column on the
. right.
  $6E03,$03 Read the controls using #R$6D9C.
  $6E06,$04 Jump to #R$6E2A if up is being pressed.
  $6E0A,$04 Jump to #R$6E38 if down is being pressed.
@ $6E0E label=Robbie_EmptyHanded_Draw
  $6E0E,$03 Jump to #R$6F31 to draw Robbie.
N $6E11 Move right.
@ $6E11 label=Robbie_EmptyHanded_Right
  $6E11,$03 #REGa=the X position of Robbie.
  $6E14,$02 Add #N$02.
  $6E16,$04 Jump to #R$6E43 if Robbie has reached the cubby hole column on the
. right.
@ $6E1A label=Robbie_EmptyHanded_StoreX
  $6E1A,$03 Write the new X position.
  $6E1D,$02 Jump to #R$6DF8.
N $6E1F Move left.
@ $6E1F label=Robbie_EmptyHanded_Left
  $6E1F,$03 #REGa=the X position of Robbie.
  $6E22,$02 Subtract #N$02.
  $6E24,$04 Jump to #R$6E43 if Robbie has reached the cubby hole column on the
. left.
  $6E28,$02 Jump to #R$6E1A.
N $6E2A Move up.
@ $6E2A label=Robbie_EmptyHanded_Up
  $6E2A,$03 #REGa=the Y position of Robbie.
  $6E2D,$02 Subtract #N$02.
  $6E2F,$04 Jump to #R$6E0E if Robbie has reached the top.
@ $6E33 label=Robbie_EmptyHanded_StoreY
  $6E33,$03 Write the new Y position.
  $6E36,$02 Jump to #R$6E0E.
N $6E38 Move down.
@ $6E38 label=Robbie_EmptyHanded_Down
  $6E38,$03 #REGa=the Y position of Robbie.
  $6E3B,$02 Add #N$02.
  $6E3D,$04 Jump to #R$6E0E if Robbie has reached the bottom.
  $6E41,$02 Jump to #R$6E33.
N $6E43 Robbie has reached one of the cubby hole columns.
@ $6E43 label=Robbie_EmptyHanded_CubbyColumn
  $6E43,$03 Check for a cubby hole using #R$7049.
  $6E46,$04 Jump to #R$6DF8 if Robbie is not level with a cubby hole.
  $6E4A,$02 Test bit 1 of #REGe (the right hand side).
  $6E4C,$03 #REGa=the X position of Robbie.
  $6E4F,$02 Jump to #R$6E60 if Robbie is on the left hand side.
  $6E51,$02 Add #N$02.
  $6E53,$04 Jump to #R$6E0E if Robbie has reached the edge of the play area.
@ $6E57 label=Robbie_EmptyHanded_CubbyHole
  $6E57,$04 Jump to #R$6E68 if the cubby hole is not empty.
  $6E5B,$03 Write the new X position.
  $6E5E,$02 Jump to #R$6E0E.
@ $6E60 label=Robbie_EmptyHanded_CubbyHoleLeft
  $6E60,$02 Subtract #N$02.
  $6E62,$04 Jump to #R$6E0E if Robbie has reached the edge of the play area.
  $6E66,$02 Jump to #R$6E57.
N $6E68 Robbie has walked into a cubby hole which is not empty.
@ $6E68 label=Robbie_EmptyHanded_Pickup
  $6E68,$01 #REGa=the contents of the cubby hole.
  $6E69,$04 Jump to #R$6EC0 if bit 7 is set (a bonus item is in the hole).
  $6E6D,$06 Jump to #R$6E79 if Robbie is free to pick the item up.
  $6E73,$06 Jump to #R$6E0E if this is the item that Robbie has just dropped.
@ $6E79 label=Robbie_EmptyHanded_TakeCan
  $6E79,$02,b$01 Keep only bits 0-2 (the colour of the can).
  $6E7B,$02,b$01 Set bit 6 (BRIGHT).
  $6E7D,$03 Write it to the colour of Robbie.
  $6E80,$03 Write it to the colour of the spray can object.
  $6E83,$02 #REGa=#N$02 (the state of Robbie when he is carrying a can).
  $6E85,$03 Make Robbie carry a can (state #N$02).
  $6E88,$01 Increment the state by one (the state of the spray can object).
  $6E89,$03 Make the spray can object active (state #N$03).
  $6E8C,$03 Play a tone using #R$64D6.
  $6E8F,$04 Test bit 7 of the X position of Robbie.
  $6E93,$03 #REGa=the X position of Robbie.
  $6E96,$02 Jump to #R$6EC5 if Robbie is on the left hand side.
  $6E98,$04 Reset bit 0 of #REGix+#N$04 (Robbie faces right).
  $6E9C,$02 Add #N$14.
  $6E9E,$03 Write it to the X position of the spray can object.
  $6EA1,$02 Subtract #N$04.
@ $6EA3 label=Robbie_EmptyHanded_PlaceCan
  $6EA3,$03 Write it to the new X position of the spray can.
  $6EA6,$03 #REGa=the Y position of Robbie.
  $6EA9,$03 Write it to the Y position of the spray can object.
  $6EAC,$03 Write it to the new Y position of the spray can.
  $6EAF,$04 Write #N$00 to #REGix+#N$0C (the can is not being put away).
  $6EB3,$02 Empty the cubby hole.
  $6EB5,$04 Set bit 2 of #REGix+#N$04.
  $6EB9,$04 Set bit 3 of #REGix+#N$04.
  $6EBD,$03 Jump to #R$6E0E.
@ $6EC0 label=Robbie_EmptyHanded_Bonus
  $6EC0,$02 Write #N$80 to the cubby hole to mark the bonus item as collected.
  $6EC2,$03 Jump to #R$6E0E.
@ $6EC5 label=Robbie_EmptyHanded_TakeCanLeft
  $6EC5,$02 Subtract #N$0D.
  $6EC7,$03 Write it to the X position of the spray can object.
  $6ECA,$02 Add #N$01.
  $6ECC,$04 Set bit 0 of #REGix+#N$04 (Robbie faces left).
  $6ED0,$02 Jump to #R$6EA3.

c $6ED2 Update Spray Can
@ $6ED2 label=UpdateSprayCan
D $6ED2 Moves the spray can which Robbie is carrying to its new position, which
. Robbie works out in #REGix+#N$05 and #REGix+#N$06. When Robbie puts the can
. in a cubby hole, #REGix+#N$04 is set to #N$01 and the can is made inactive
. after it has been drawn for the last time.
R $6ED2 IX Spray can object
  $6ED2,$03 Remember the position and state using #R$75B9.
  $6ED5,$03 #REGa=the new X position from #REGix+#N$05.
  $6ED8,$03 Write it to the X position.
  $6EDB,$03 #REGa=the new Y position from #REGix+#N$06.
  $6EDE,$03 Write it to the Y position.
  $6EE1,$03 Erase the sprite at the previous position and draw it at the new
. position using #R$74EB.
  $6EE4,$03 Colour the sprite using #R$7450.
  $6EE7,$04 Test bit 0 of #REGix+#N$04 (the can is being put away).
  $6EEB,$01 Return if it is not.
  $6EEC,$04 Write #N$00 to #REGix+#N$00 (the can is inactive).
  $6EF0,$01 Return.

c $6EF1 Update Robbie Carrying Can
@ $6EF1 label=Robbie_CarryingCan
D $6EF1 Handles Robbie while he is carrying a spray can (Robbie state #N$02).
. The controls move Robbie and the can together, and the can is held out in
. front of him. Robbie can turn round, and he can fire a weapon when fire is
. pressed (see #R$6B70). If Robbie walks all the way into an empty cubby hole
. then he drops the can into it, and becomes Robbie empty-handed (see
. #R$6DBA).
R $6EF1 IX Robbie object
  $6EF1,$03 Remember the position and state using #R$75B9.
  $6EF4,$06 Jump to #R$6F00 unless Robbie has just picked up the can.
  $6EFA,$04 Reset bit 3 of #REGix+#N$04.
  $6EFE,$02 Jump to #R$6F29.
@ $6F00 label=Robbie_CarryingCan_Input
  $6F00,$03 Read the controls using #R$6D9C.
  $6F03,$04 Jump to #R$6F41 if right is being pressed.
  $6F07,$04 Jump to #R$6F77 if left is being pressed.
@ $6F0B label=Robbie_CarryingCan_Vertical
  $6F0B,$03 #REGa=the X position of Robbie.
  $6F0E,$06 Jump to #R$6F37 if Robbie is facing right.
  $6F14,$04 Jump to #R$6F29 if Robbie is too far to the right to move
. vertically.
  $6F18,$04 Jump to #R$6F29 if Robbie is too far to the left to move
. vertically.
@ $6F1C label=Robbie_CarryingCan_VerticalInput
  $6F1C,$03 Read the controls using #R$6D9C.
  $6F1F,$05 Jump to #R$6FAA if up is being pressed.
  $6F24,$05 Jump to #R$6FBD if down is being pressed.
@ $6F29 label=Robbie_CarryingCan_Fire
  $6F29,$03 Read the controls using #R$6D9C.
  $6F2C,$02 Test bit 4 of #REGa (fire).
  $6F2E,$03 Fire a weapon using #R$6B70 if fire is being pressed.

c $6F31 Draw Object
@ $6F31 label=DrawObject
D $6F31 Erases the sprite of an object from its previous position, draws it at
. the new position and then colours it. This is the end of the update routines
. for most of the objects.
R $6F31 IX Object
  $6F31,$03 Erase the sprite at the previous position and draw it at the new
. position using #R$74EB.
  $6F34,$03 Jump to #R$7450 to colour the sprite.

c $6F37 Check Vertical Movement Facing Right
@ $6F37 label=Robbie_CarryingCan_FacingRight
D $6F37 Robbie is carrying a can and is facing right. He can only move up or
. down when he is away from the cubby hole columns.
R $6F37 A The X position of Robbie
  $6F37,$04 Jump to #R$6F29 if Robbie is too far to the left to move
. vertically.
  $6F3B,$04 Jump to #R$6F29 if Robbie is too far to the right to move
. vertically.
  $6F3F,$02 Jump to #R$6F1C.

c $6F41 Move Robbie Right
@ $6F41 label=Robbie_CarryingCan_Right
D $6F41 Right is being pressed while Robbie is carrying a can. If he is facing
. left then he turns round, otherwise he moves two pixels to the right. The
. can moves with him.
R $6F41 IX Robbie object
  $6F41,$06 Jump to #R$6F61 if Robbie is facing right.
  $6F47,$03 #REGa=the X position of Robbie.
  $6F4A,$02 Subtract #N$0C.
  $6F4C,$03 Write the new X position.
  $6F4F,$03 #REGa=the X position of the spray can.
  $6F52,$02 Add #N$10.
  $6F54,$03 Write it to the new X position of the spray can.
  $6F57,$04 Reset bit 0 of #REGix+#N$04 (Robbie faces right).
  $6F5B,$04 Reset bit 2 of #REGix+#N$04.
  $6F5F,$02 Jump to #R$6F72.
@ $6F61 label=Robbie_CarryingCan_MoveRight
  $6F61,$03 #REGa=the X position of Robbie.
  $6F64,$02 Add #N$02.
  $6F66,$04 Jump to #R$6FC9 if Robbie has reached the cubby hole column.
  $6F6A,$03 Write the new X position.
  $6F6D,$03 #REGa=the X position of the spray can.
  $6F70,$02 Add #N$02.
@ $6F72 label=Robbie_CarryingCan_StoreCanX
  $6F72,$03 Write it to the new X position of the spray can.
  $6F75,$02 Jump to #R$6F0B.

c $6F77 Move Robbie Left
@ $6F77 label=Robbie_CarryingCan_Left
D $6F77 Left is being pressed while Robbie is carrying a can. If he is facing
. right then he turns round, otherwise he moves two pixels to the left. The
. can moves with him.
R $6F77 IX Robbie object
  $6F77,$06 Jump to #R$6F97 if Robbie is facing left.
  $6F7D,$03 #REGa=the X position of Robbie.
  $6F80,$02 Add #N$0C.
  $6F82,$03 Write the new X position.
  $6F85,$03 #REGa=the X position of the spray can.
  $6F88,$02 Subtract #N$10.
  $6F8A,$03 Write it to the new X position of the spray can.
  $6F8D,$04 Set bit 0 of #REGix+#N$04 (Robbie faces left).
  $6F91,$04 Reset bit 2 of #REGix+#N$04.
  $6F95,$02 Jump to #R$6F72.
@ $6F97 label=Robbie_CarryingCan_MoveLeft
  $6F97,$03 #REGa=the X position of Robbie.
  $6F9A,$02 Subtract #N$02.
  $6F9C,$04 Jump to #R$6FC9 if Robbie has reached the cubby hole column.
  $6FA0,$03 Write the new X position.
  $6FA3,$03 #REGa=the X position of the spray can.
  $6FA6,$02 Subtract #N$02.
  $6FA8,$02 Jump to #R$6F72.

c $6FAA Move Robbie Up
@ $6FAA label=Robbie_CarryingCan_Up
D $6FAA Moves Robbie, and the can, up two pixels unless he is at the top.
R $6FAA IX Robbie object
  $6FAA,$03 #REGa=the Y position of Robbie.
  $6FAD,$05 Jump to #R$6F29 if Robbie is at the top.
  $6FB2,$02 Subtract #N$02.
@ $6FB4 label=Robbie_CarryingCan_StoreY
  $6FB4,$03 Write the new Y position.
  $6FB7,$03 Write it to the new Y position of the spray can.
  $6FBA,$03 Jump to #R$6F29.

c $6FBD Move Robbie Down
@ $6FBD label=Robbie_CarryingCan_Down
D $6FBD Moves Robbie, and the can, down two pixels unless he is at the bottom.
R $6FBD IX Robbie object
  $6FBD,$03 #REGa=the Y position of Robbie.
  $6FC0,$02 Add #N$02.
  $6FC2,$05 Jump to #R$6F29 if Robbie is at the bottom.
  $6FC7,$02 Jump to #R$6FB4.

c $6FC9 Move Robbie Into Cubby Hole
@ $6FC9 label=Robbie_CarryingCan_CubbyColumn
D $6FC9 Robbie has walked into one of the cubby hole columns while carrying a
. can. If he is level with a cubby hole which is empty, he keeps on going
. until he reaches the edge and puts the can in the hole.
R $6FC9 IX Robbie object
  $6FC9,$03 Check for a cubby hole using #R$7049.
  $6FCC,$03 #REGa=the Y position of Robbie.
  $6FCF,$03 Write it to the new Y position of the spray can.
  $6FD2,$05 Jump to #R$6F0B if Robbie is not level with a cubby hole.
  $6FD7,$05 Jump to #R$6F29 if the cubby hole is not empty.
  $6FDC,$03 #REGa=the X position of Robbie.
  $6FDF,$04 Jump to #R$6FF7 if Robbie is on the left hand side.
  $6FE3,$02 Add #N$02.
  $6FE5,$04 Jump to #R$7007 if Robbie has reached the edge.
@ $6FE9 label=Robbie_CarryingCan_StoreX
  $6FE9,$03 Write the new X position.
  $6FEC,$03 #REGa=the X position of the spray can.
  $6FEF,$02 Add #N$02.
@ $6FF1 label=Robbie_CarryingCan_StoreCanX_Left
  $6FF1,$03 Write it to the new X position of the spray can.
  $6FF4,$03 Jump to #R$6F29.
@ $6FF7 label=Robbie_CarryingCan_CubbyColumnLeft
  $6FF7,$02 Subtract #N$02.
  $6FF9,$04 Jump to #R$7007 if Robbie has reached the edge.
  $6FFD,$03 Write the new X position.
  $7000,$03 #REGa=the X position of the spray can.
  $7003,$02 Subtract #N$02.
  $7005,$02 Jump to #R$6FF1.

c $7007 Put Can In Cubby Hole
@ $7007 label=PutCanInCubbyHole
D $7007 Robbie puts the spray can into the cubby hole in #REGhl, and becomes
. Robbie empty-handed. The can is moved to the cubby hole and, with
. #REGix+#N$0C set to #N$01, is then made inactive by #R$6ED2.
R $7007 HL The cubby hole
R $7007 IX Robbie object
  $7007,$07 Jump to #R$6F29 if Robbie cannot drop the can yet.
  $700E,$03 #REGa=the colour of Robbie.
  $7011,$02,b$01 Keep only bits 0-2 (the colour of the can).
  $7013,$02,b$01 Set bit 3 (the item is a spray can).
  $7015,$03 Remember the item in #REGix+#N$06 so it is not picked up again
. straight away.
  $7018,$01 Write the item to the cubby hole.
  $7019,$04 Set bit 2 of #REGix+#N$04.
  $701D,$04 Write #N$01 to #REGix+#N$00 (Robbie is empty-handed).
  $7021,$04 Write #N$47 (white) to the colour of Robbie.
  $7025,$03 #REGa=the X position of the spray can.
  $7028,$04 Jump to #R$703B if the can is on the right hand side.
  $702C,$02 Subtract #N$02.
@ $702E label=PutCanInCubbyHole_Move
  $702E,$03 Write it to the new X position of the spray can.
  $7031,$04 Write #N$01 to #REGix+#N$0C (the can is being put away).
  $7035,$03 Play a tone using #R$64DC.
  $7038,$03 Jump to #R$6F29.
@ $703B label=PutCanInCubbyHole_Right
  $703B,$02 Add #N$04.
  $703D,$02 Jump to #R$702E.

c $703F Release Item Lock
@ $703F label=ReleaseItemLock
D $703F Used when Robbie is not level with a cubby hole: if he is empty-handed
. then he is allowed to pick up or drop an item again.
R $703F IX Robbie object
R $703F O:E #N$00
  $703F,$03 #REGa=the state of Robbie.
  $7042,$01 Decrease the state by one (zero if Robbie is empty-handed).
  $7043,$01 Return if Robbie is carrying a can.
  $7044,$04 Reset bit 2 of #REGix+#N$04
. (Robbie can pick up and drop a can again).
  $7048,$01 Return.

c $7049 Check Cubby Hole
@ $7049 label=CheckCubbyHole
D $7049 Checks whether Robbie is level with one of the rows of cubby holes.
. If he is then his Y position is made exactly level with the row. #REGe holds
. whether there is a cubby hole, which side it is on and whether it has
. something in it.
R $7049 IX Robbie object
R $7049 O:E Bit 0 is set if Robbie is level with a cubby hole
R $7049 O:E Bit 1 is set if the cubby hole is on the right hand side
R $7049 O:E Bit 2 is set if the cubby hole is not empty
R $7049 O:HL The cubby hole
  $7049,$02 #REGe=#N$00 (no cubby hole).
  $704B,$03 #REGa=the Y position of Robbie.
  $704E,$02,b$01 Keep only bits 0-4.
  $7050,$02 Subtract #N$17 (the cubby holes are at Y positions which are a
. multiple of #N$20 plus #N$17).
  $7052,$05 Make sure we have a positive byte.
@ $7057 label=CheckCubbyHole_Test_Row
  $7057,$04 Jump to #R$703F if Robbie is #N$05 pixels or more away from a row.
  $705B,$03 #REGa=the Y position of Robbie.
  $705E,$02,b$01 Keep only bits 5-7.
  $7060,$02,b$01 Set bits 0-2 and 4.
  $7062,$03 Write the new Y position.
  $7065,$06 Jump to #R$708B if Robbie is on the left hand side.
  $706B,$02 #REGe=#N$03 (Robbie is on the right hand side).
@ $706D label=CheckCubbyHole_Row
  $706D,$03 #REGa=the Y position of Robbie.
  $7070,$03 Rotate bits 5-7 round to bits 0-2.
  $7073,$02,b$01 Keep only bits 0-2.
  $7075,$01 Decrease #REGa by one to give the row number (0 to 4).
  $7076,$06 Jump to #R$707E if Robbie is on the left hand side.
  $707C,$02 Add #N$05 to select the cubby holes on the right.
@ $707E label=CheckCubbyHole_Hole
  $707E,$01 #REGc=the cubby hole number.
  $707F,$02 Clear the high byte of the number in #REGb.
  $7081,$03 #REGhl=#R$5E23.
  $7084,$01 Add the cubby hole number to find its contents.
  $7085,$01 #REGa=the contents of the cubby hole.
  $7086,$01 Test the contents.
  $7087,$01 Return if the cubby hole is empty.
  $7088,$02 Set bit 2 of #REGe (the cubby hole is not empty).
  $708A,$01 Return.
@ $708B label=CheckCubbyHole_Left
  $708B,$02 #REGe=#N$01 (Robbie is on the left hand side).
  $708D,$02 Jump to #R$706D.

c $708F Update High Score
@ $708F label=UpdateHighScore
D $708F Finds the higher of the scores of the two players and, if that is
. higher than the high score at #R$5E00, makes it the new high score. The
. scores are stored as three BCD bytes with the most significant byte first.
  $708F,$03 #REGhl=the first two bytes of the score of 1UP.
  $7092,$04 #REGde=the first two bytes of the score of 2UP.
  $7096,$03 Swap #REGh and #REGl so that the most significant byte is in
. #REGh.
  $7099,$03 Swap #REGd and #REGe so that the most significant byte is in
. #REGd.
  $709C,$03 Compare the first two bytes of the scores.
  $709F,$02 Jump to #R$70AD if 2UP has the higher score.
  $70A1,$02 Jump to #R$70CC if 1UP has the higher score.
  $70A3,$04 #REGe=the last byte of the score of 1UP.
  $70A7,$03 #REGa=the last byte of the score of 2UP.
  $70AA,$01 Compare the last bytes of the scores.
  $70AB,$02 Jump to #R$70CC if 1UP has the higher score.
@ $70AD label=UpdateHighScore_2UP
  $70AD,$03 #REGhl=#R$5E08 (the score of 2UP).
@ $70B0 label=UpdateHighScore_Compare
  $70B0,$01 Stash the pointer to the score on the stack.
  $70B1,$03 #REGde=#R$5E00 (the high score).
  $70B4,$02 Set the byte counter to #N$03.
@ $70B6 label=UpdateHighScore_Loop
  $70B6,$04 Jump to #R$70C2 if the high score is lower than the score.
  $70BA,$02 Jump to #R$70C0 if the high score is higher than the score.
  $70BC,$02 Move onto the next byte of each.
  $70BE,$02 Decrease the byte counter by one and loop back to #R$70B6 until all
. three bytes have been compared.
@ $70C0 label=UpdateHighScore_Done
  $70C0,$01 Restore the pointer from the stack.
  $70C1,$01 Return.
@ $70C2 label=UpdateHighScore_Copy
  $70C2,$01 Restore the pointer from the stack.
  $70C3,$03 #REGde=#R$5E00 (the high score).
  $70C6,$03 #REGbc=#N$0003.
  $70C9,$02 Copy the score to the high score.
  $70CB,$01 Return.
@ $70CC label=UpdateHighScore_1UP
  $70CC,$03 #REGhl=#R$5E05 (the score of 1UP).
  $70CF,$02 Jump to #R$70B0.

c $70D1 Set Leaves Bugs And Explosion Inactive
@ $70D1 label=Reset
D $70D1 Sets the leaves, the bugs and the explosion objects to inactive. Nothing
. calls this entry point; the game uses #R$70D6 directly.
  $70D1,$03 #REGhl=#R$5E94.
  $70D4,$02 Set the object counter to #N$0B.

c $70D6 Set Objects Inactive
@ $70D6 label=SetObjectInactive
D $70D6 Writes #N$00 to the state of a number of objects, which makes them
. inactive.
R $70D6 B Loop counter
R $70D6 HL Object to be updated
  $70D6,$03 #REGde=#N$0008 (the size of an object).
@ $70D9 label=SetObjectInactive_Loop
  $70D9,$02 Set the state of the object to inactive.
  $70DB,$01 Move onto the next object.
  $70DC,$02 Decrease the object counter by one and loop back to #R$70D9 until
. all of the objects have been made inactive.
  $70DE,$01 Return.

c $70DF Limit Frame Rate
@ $70DF label=LimitFrameRate
D $70DF The update routine for the objects which do nothing (type #N$00 and
. types #N$0B to #N$0F). This also slows down the main loop in the slow pass
. when there are not many objects, by making a short pause.
E $70DF View the equivalent code in;
. #LIST
. { #COOKIE$7152 }
. { #JETPAC$691B }
. { #LUNARJETMAN$824A }
. LIST#
  $70DF,$05 Return if the fast pass is being done (#R$5E20 is marked as being
. updated), so there is no pause.
  $70E4,$03 Set the delay counter for a slight pause
. (so that the game does not run too fast).
@ $70E7 label=LimitFrameRate_Loop
  $70E7,$01 Decrease the delay counter by one.
  $70E8,$04 Keep looping back to #R$70E7 until the delay is over.
  $70EC,$01 Return.

c $70ED Frame Update
@ $70ED label=FrameUpdate
D $70ED Called from the main loop when a new frame has started. It does a
. "fast pass" over the first four objects (Robbie, the spray can and the two
. weapons) so that they are updated once per frame, and then returns to the
. slow pass. It does this by changing the code at #R$713C so that the pass
. ends after the weapons, and at #R$714F so that the end of the pass jumps to
. #R$7125, and then running the main loop from #R$635B.
E $70ED View the equivalent code in;
. #LIST
. { #COOKIE$7160 }
. { #LUNARJETMAN$8209 }
. LIST#
  $70ED,$01 Disable interrupts.
  $70EE,$06 Update #R$5E1F with #SKOOLKID$5C78(FRAMES).
  $70F4,$05 Set #R$5E20 as "being updated" (i.e. #N$01).
  $70F9,$02 Stash #REGix on the stack.
  $70FB,$06 Write #R$5E8C to #R$713C(#N$713D).
  $7101,$0B #HTML(Write #N$C3 to #R$714F and #R$7125 to #R$714F(#N$7150), i.e. <code>JP #R$7125</code>).
  $710C,$04 #REGix=#R$5E6C.
  $7110,$03 Jump to #R$635B.

c $7113 Reset Modified Code
@ $7113 label=ResetModifiedCode
D $7113 Puts back the code which is changed by #R$70ED, so that the slow pass
. goes up to the end of the objects at #R$5EEC and the end of the pass does
. the normal housekeeping.
E $7113 View the equivalent code in;
. #LIST
. { #COOKIE$7186 }
. { #LUNARJETMAN$822F }
. LIST#
  $7113,$06 Write #R$5EEC to #R$713C(#N$713D).
  $7119,$05 Write #N$2A to #R$714F.
  $711E,$06 Write #R$5E17 to #R$714F(#N$7150).
  $7124,$01 Return.

c $7125 Reset Modified Code In Frame
@ $7125 label=ResetModifiedInFrame
D $7125 The end of the fast pass, which is reached from #R$714F. It puts back
. the code changed by #R$70ED, gets the old #REGix back and returns to the
. main loop.
E $7125 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$823F }
. LIST#
  $7125,$03 Call #R$7113.
  $7128,$02 Restore #REGix, saved during frame update.
  $712A,$04 Set #R$5E20 as "not updated" (i.e. #N$00).
  $712E,$01 Enable interrupts.
  $712F,$01 Return.

c $7130 Next Object
@ $7130 label=NewActor
D $7130 Every update routine returns here. This moves onto the next object and
. goes round the main loop again, unless it was the last object of the pass.
. Then the pass ends by continuing at #R$7145.
R $7130 IX Object
  $7130,$04 Increment #R$5E19 by one (this changes the random number).
  $7134,$03 #REGde=#N$0008 (the size of an object).
  $7137,$02 Set #REGix to the next object.
  $7139,$03 Copy #REGix to #REGhl using the stack.
N $713C The self-modifying code routines change the address here to be either;
. #TABLE(default,centre,centre)
. { =h Altering Routine | =h Alteration }
. { #R$7113 | #N$5EEC }
. { #R$70ED | #N$5E8C }
. TABLE#
  $713C,$03 #REGbc=#R$5EEC (the end of the objects).
  $713F,$03 Subtract the end of the objects from the address of the object.
  $7142,$03 Jump to #R$635B if there are more objects to update.

c $7145 End Of Pass
@ $7145 label=Pause_Loop
D $7145 The housekeeping which is done at the end of every pass through the
. objects: this pauses the game while "SHIFT" is held down, adds one to the
. game timer and updates the random number. In the fast pass the instruction at
. #R$714F is changed to jump to #R$7125 instead.
N $7145 Holding "SHIFT" pauses the game.
  $7145,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $714B,$04 Jump to #R$7145 if the "SHIFT" key has been pressed.
  $714F,$03 #REGhl=#R$5E17(see #R$711E).
  $7152,$01 Increment the game timer by one.
  $7153,$03 Write the game timer back to #R$5E17.
N $7156 The random number is the old random number added to the byte of the ROM
. found using the low byte of the game timer, and added to the refresh
. register.
  $7156,$02 #REGh=#N$00.
  $7158,$02 #REGa=the refresh register.
  $715A,$01 #REGc=#REGa.
  $715B,$03 #REGa=#R$5E19.
  $715E,$01 Add the byte from the ROM.
  $715F,$01 Add the refresh register.
  $7160,$03 Write the new random number to #R$5E19.
  $7163,$01 Keep a copy of the random number in #REGaf'.

c $7164 Spawn Bug
@ $7164 label=SpawnBug
D $7164 Decides whether to add a new bug to the play area. A bug is added when
. all of the following are true:
. #LIST
. { there are fewer than three bugs, or the level is #N$06 or more, or there
. are fewer than six bugs and the low five bits of the random number are
. zero (a one in thirty-two chance); }
. { the "get ready" delay is over; }
. { the cubby hole picked by the game timer (one of the first ten) is empty; }
. { the flower is not blooming; }
. { Robbie is alive; }
. { there is an inactive bug object. }
. LIST#
. The cubby hole is where the new bug starts. If a bug is not added then this
. carries on at #R$71BE.
  $7164,$03 #REGa=the number of bugs from #R$5E16.
  $7167,$04 Jump to #R$717E if there are fewer than three bugs.
  $716B,$03 #REGa=the level from #R$5E37.
  $716E,$04 Jump to #R$717E if the level is #N$06 or more.
  $7172,$01 Get the random number back from #REGaf'.
  $7173,$02,b$01 Keep only bits 0-4 (a one in thirty-two chance).
  $7175,$02 Jump to #R$71BE unless the result is zero.
  $7177,$03 #REGa=the number of bugs from #R$5E16.
  $717A,$04 Jump to #R$71BE if there are six bugs.
@ $717E label=SpawnBug_Delay
  $717E,$03 #REGa=#R$5E22 (the "get ready" delay).
  $7181,$01 Test the delay.
  $7182,$02 Jump to #R$71BE if the delay is not over.
  $7184,$03 #REGa=the game timer from #R$5E17.
  $7187,$02,b$01 Keep only bits 0-3.
  $7189,$04 Jump to #R$71BE if it is #N$0A or more.
  $718D,$01 #REGc=the cubby hole number.
  $718E,$02 #REGb=#N$00.
  $7190,$03 #REGhl=#R$5E23.
  $7193,$01 Add the cubby hole number.
  $7194,$01 #REGa=the contents of the cubby hole.
  $7195,$01 Test the contents.
  $7196,$02 Jump to #R$71BE if the cubby hole is not empty.
  $7198,$03 #REGa=the state of the flower from #R$5E8C.
  $719B,$04 Jump to #R$71BE if the flower is blooming.
  $719F,$01 #REGa=the cubby hole number.
  $71A0,$03 Write it to #R$5E13.
  $71A3,$03 #REGa=the state of Robbie from #R$5E6C.
  $71A6,$02,b$01 Keep only bits 0-5.
  $71A8,$01 Decrease the state of Robbie by one (zero if he is empty-handed).
  $71A9,$02 Jump to #R$71AE if Robbie is empty-handed.
  $71AB,$01 Decrease the state of Robbie by one again
. (zero if he is carrying a can).
  $71AC,$02 Jump to #R$71BE unless Robbie is carrying a can.
@ $71AE label=SpawnBug_FindSlot
  $71AE,$03 #REGhl=#R$5EB4 (the first bug object).
  $71B1,$02 Set the bug counter to #N$06.
  $71B3,$03 #REGde=#N$0008 (the size of an object).
@ $71B6 label=SpawnBug_FindSlot_Loop
  $71B6,$01 #REGa=the state of the bug.
  $71B7,$01 Test the state.
  $71B8,$03 Jump to #R$7262 if the bug is inactive.
  $71BB,$01 Move onto the next bug.
  $71BC,$02 Decrease the bug counter by one and loop back to #R$71B6 until all
. six bug slots have been checked.

c $71BE Spawn Bonus Item
@ $71BE label=SpawnBonusItem
D $71BE Updates the bonus item if there is one. Otherwise, it puts a new bonus
. item into a cubby hole, with a chance of one in two hundred and fifty-six. The
. hole is chosen using the game timer, from the first ten, and has to be empty.
. The hole is marked with #N$FF, and the type of the bonus item is a random
. one of #N$0B, #N$0C or #N$0D (with #N$0B more likely). It goes back to the
. start of the main loop at #R$634F.
  $71BE,$03 #REGa=the state of the bonus item from #R$5E3C.
  $71C1,$01 Test the state.
  $71C2,$03 Jump to #R$721A if there is a bonus item.
  $71C5,$03 #REGa=the random number from #R$5E19.
  $71C8,$01 Test the random number.
  $71C9,$03 Jump to #R$634F to start another pass unless it is zero.
  $71CC,$03 #REGa=the game timer from #R$5E17.
  $71CF,$02,b$01 Keep only bits 0-3.
  $71D1,$05 Jump to #R$634F if it is #N$0A or more.
  $71D6,$01 #REGc=the cubby hole number.
  $71D7,$02 #REGb=#N$00.
  $71D9,$03 #REGhl=#R$5E23.
  $71DC,$01 Add the cubby hole number.
  $71DD,$01 #REGa=the contents of the cubby hole.
  $71DE,$01 Test the contents.
  $71DF,$03 Jump to #R$634F if the cubby hole is not empty.
  $71E2,$02 Write #N$FF to the cubby hole.
  $71E4,$04 #REGix=#R$5E3C (the bonus item).
  $71E8,$01 #REGa=the cubby hole number.
  $71E9,$04 Jump to #R$725A if the cubby hole is on the right.
  $71ED,$04 Write #N$08 to the X position of the bonus item.
@ $71F1 label=SpawnBonusItem_Row
  $71F1,$03 Rotate the row number round so it is in bits 5-7.
  $71F4,$02,b$01 Keep only bits 5-7.
  $71F6,$02 Add #N$37.
  $71F8,$03 Write it to the Y position of the bonus item.
  $71FB,$02 #REGa=the refresh register.
  $71FD,$02,b$01 Keep only bits 0-1.
  $71FF,$04 Jump to #R$7204 unless it is #N$03.
  $7203,$01 #REGa=#N$00.
@ $7204 label=SpawnBonusItem_Type
  $7204,$02 Add #N$0B to give the type of the bonus item.
  $7206,$04 Write #N$FF to #REGix+#N$04 (the contents the cubby hole should
. have).
  $720A,$03 Write the type to the state of the bonus item.
  $720D,$04 Write #N$43 (magenta) to the colour of the bonus item.
  $7211,$03 Write the cubby hole number to #REGix+#N$05.
@ $7214 label=SpawnBonusItem_Tone
  $7214,$03 Play a tone using #R$64E7.
  $7217,$03 Jump to #R$634F.

c $721A Update Bonus Item
@ $721A label=UpdateBonusItem
D $721A Updates the bonus item. It sits in a cubby hole and flashes, and when
. Robbie touches it the cubby hole is changed (see #R$6E68) and so the bonus
. item is collected by #R$7249. It goes back to the start of the main loop at
. #R$634F.
  $721A,$04 #REGix=#R$5E3C.
  $721E,$03 Remember the position and state using #R$75B9.
  $7221,$03 #REGc=the cubby hole number from #REGix+#N$05.
  $7224,$02 #REGb=#N$00.
  $7226,$03 #REGhl=#R$5E23.
  $7229,$01 Add the cubby hole number.
  $722A,$01 #REGa=the contents of the cubby hole.
  $722B,$03 Compare it with #REGix+#N$04.
  $722E,$02 Jump to #R$7249 if it has changed.
  $7230,$03 Erase the sprite at the previous position and draw it at the new
. position using #R$74EB.
  $7233,$03 Colour the sprite using #R$7450.
  $7236,$03 #REGa=the game timer from #R$5E17.
  $7239,$02,b$01 Keep only bits 0-1 (every fourth update).
  $723B,$03 Jump to #R$634F unless the result is zero.
  $723E,$03 #REGa=the colour of the bonus item.
  $7241,$02,b$01 Flip bit 2 (so the item flashes).
  $7243,$03 Write it back to the colour of the bonus item.
  $7246,$03 Jump to #R$634F.

c $7249 Collect Bonus Item
@ $7249 label=CollectBonusItem
D $7249 Empties the cubby hole and removes the bonus item, and adds #N$1000
. points (as BCD) to the score. Then it plays a tone, and goes back to the start
. of the main loop at #R$634F.
R $7249 HL The cubby hole
R $7249 IX The bonus item
  $7249,$02 Write #N$00 to the cubby hole.
  $724B,$03 Erase the previous sprite using #R$7526.
  $724E,$03 #REGbc=#N$1000 (the points).
  $7251,$03 Add the points to the score using #R$737A.
  $7254,$04 Write #N$00 to the state of the bonus item.
  $7258,$02 Jump to #R$7214.

c $725A Place Bonus Item Right
@ $725A label=SpawnBonusItem_Right
D $725A The cubby hole is on the right, so the bonus item is put at the right
. hand side.
R $725A A The cubby hole number
R $725A IX The bonus item
  $725A,$04 Write #N$E8 to the X position of the bonus item.
  $725E,$02 Subtract #N$05 to give the row number.
  $7260,$02 Jump to #R$71F1.

c $7262 Create Bug
@ $7262 label=CreateBug
D $7262 Creates a new bug in an inactive bug object, at the cubby hole whose
. number is in #R$5E13. The type and the colour are chosen using the level, and
. the random number (see #R$72E9). The bug is cancelled if Robbie is too
. close to it.
R $7262 HL The inactive bug object
  $7262,$01 Stash #REGhl on the stack.
  $7263,$01 Switch #REGde and #REGhl.
  $7264,$08 Copy #N$0008 bytes of data from #R$5F16 to #REGde.
  $726C,$02 Restore #REGix from the stack (the old value in #REGhl).
  $726E,$03 #REGa=#R$5E13.
  $7271,$04 Jump to #R$72CC if the cubby hole is on the right.
  $7275,$04 Write #N$08 to the X position of the bug.
  $7279,$04 Set bit 6 of the state of the bug (this has no effect as the
. state is overwritten at #R$72AA).
@ $727D label=CreateBug_Row
  $727D,$03 Rotate the row number round so it is in bits 5-7.
  $7280,$02,b$01 Keep only bits 5-7.
  $7282,$02 Add #N$37.
  $7284,$03 Write it to the Y position of the bug.
  $7287,$03 #REGa=the level from #R$5E37.
  $728A,$04 Jump to #R$72D4 if it is level #N$01.
  $728E,$04 Jump to #R$72DA if it is level #N$02.
  $7292,$04 Jump to #R$72E1 if it is level #N$03.
  $7296,$04 Jump to #R$729C if it is a lower level.
  $729A,$02 #REGa=the refresh register.
@ $729C label=CreateBug_Type
  $729C,$02,b$01 Keep only bits 0-1.
  $729E,$01 #REGc=#REGa.
  $729F,$02 Multiply #REGa by two.
  $72A1,$01 Add #REGc to make it three times the bug type.
  $72A2,$01 #REGc=the offset into the table (three bytes for each type of bug).
  $72A3,$02 Clear the high byte of the offset in #REGb.
  $72A5,$03 #REGhl=#R$72E9.
  $72A8,$01 Add the offset.
  $72A9,$01 #REGa=the type of the bug.
  $72AA,$03 Write it to the state of the bug.
  $72AD,$01 Move onto the first colour.
  $72AE,$03 #REGa=the random number from #R$5E19.
  $72B1,$04 Jump to #R$72B6 if bit 6 is not set.
  $72B5,$01 Move onto the second colour.
@ $72B6 label=CreateBug_Colour
  $72B6,$01 #REGa=the colour of the bug.
  $72B7,$03 Write it to the colour of the bug.
  $72BA,$02 #REGe=#N$00 (no collision).
  $72BC,$03 #REGhl=#R$5E6E (the Y position of Robbie).
  $72BF,$03 Check whether the bug is on top of Robbie using #R$7310.
  $72C2,$01 Decrease the collision result in #REGe by one
. (zero means that the bug is on top of Robbie).
  $72C3,$02 Jump to #R$72C9 if the bug is not on top of Robbie.
  $72C5,$04 Write #N$00 to the state of the bug (cancel it).
@ $72C9 label=CreateBug_Done
  $72C9,$03 Jump to #R$71BE.

c $72CC Create Bug Right
@ $72CC label=CreateBug_Right
D $72CC The cubby hole is on the right, so the bug is put at the right hand
. side.
R $72CC A The cubby hole number
R $72CC IX The bug
  $72CC,$04 Write #N$E0 to the X position of the bug.
  $72D0,$02 Subtract #N$05 to give the row number.
  $72D2,$02 Jump to #R$727D.

c $72D4 Create Bug Level 1
@ $72D4 label=CreateBug_Level1
D $72D4 On level #N$01 the type of bug is a slug or a leech.
  $72D4,$02 #REGa=the refresh register.
  $72D6,$02,b$01 Keep only bit 0.
  $72D8,$02 Jump to #R$729C.

c $72DA Create Bug Level 2
@ $72DA label=CreateBug_Level2
D $72DA On level #N$02 the type of bug is a leech or midges.
  $72DA,$02 #REGa=the refresh register.
  $72DC,$02,b$01 Keep only bit 0.
  $72DE,$01 Add one.
  $72DF,$02 Jump to #R$729C.

c $72E1 Create Bug Level 3
@ $72E1 label=CreateBug_Level3
D $72E1 On level #N$03 the type of bug is midges or a slug.
  $72E1,$02 #REGa=the refresh register.
  $72E3,$02,b$01 Keep only bit 0.
  $72E5,$02,b$01 Set bit 1.
  $72E7,$02 Jump to #R$729C.

b $72E9 Bug Type Table
@ $72E9 label=BugTypeTable
D $72E9 For each of four sets of bugs, the type of the bug and then its two
. possible colours. The type is #N$07 for a slug, #N$0A for a leech and
. #N$09 for midges.
. #TABLE(default,centre,centre,centre)
. { =h Set | =h Bug | =h Used when #R$5E37 is }
. { #N$00 | Slug | #N$00, #N$01, and #N$04 or more }
. { #N$01 | Leech | #N$01, #N$02, and #N$04 or more }
. { #N$02 | Midges | #N$02, #N$03, and #N$04 or more }
. { #N$03 | Slug | #N$03, and #N$04 or more }
. TABLE#
  $72E9,$0C,$03

c $72F5 Check Bug Robbie Collision
@ $72F5 label=BugCollision
D $72F5 Tests whether a bug is touching Robbie. Robbie only counts when his
. state is #N$01 or #N$02 (empty-handed or carrying a can), so a collision
. cannot happen while he is exploding.
. .
. The two collide when their X positions differ by less than #N$10 and their
. Y positions are close enough. The vertical limit is #N$12 when Robbie is
. lower down the screen than the bug, or the bug's height (from
. *#REGix+#N$07) when the bug is lower down.
R $72F5 IX Bug object
R $72F5 O:E #N$00 No collision
R $72F5 O:E #N$01 Collision
  $72F5,$03 #REGhl=#R$5E6C (Robbie).
  $72F8,$02 #REGe=#N$00 (the default result, no collision).
  $72FA,$01 Fetch Robbie's state.
  $72FB,$02,b$01 Keep only bits 0-5.
  $72FD,$01 Decrease the state of Robbie by one (zero if he is empty-handed).
  $72FE,$02 Jump to #R$7302 if Robbie is empty-handed (state #N$01).
  $7300,$01 Decrease #REGa by one again.
  $7301,$01 Return if Robbie is not carrying a can (state #N$02).
N $7302 Check the horizontal distance.
@ $7302 label=BugCollision_X
  $7302,$02 #REGa=Robbie's X position (from #R$5E6D).
  $7304,$03 Subtract the bug's X position.
  $7307,$05 Make sure the difference is positive.
@ $730C label=BugCollision_Test_X
  $730C,$03 Return if the difference is #N$10 or more.
N $730F Check the vertical distance.
  $730F,$01 Move on to Robbie's Y position.
@ $7310 label=BugCollision_Y
  $7310,$01 #REGa=Robbie's Y position (from #R$5E6E).
  $7311,$03 Subtract the bug's Y position.
  $7314,$03 Jump to #R$731E if Robbie is lower down the screen than the bug.
  $7317,$02 Make the difference positive.
  $7319,$03 #REGd=the bug's height (from *#REGix+#N$07).
  $731C,$02 Jump to #R$7320.
@ $731E label=BugCollision_SetHeight
  $731E,$02 #REGd=#N$12.
@ $7320 label=BugCollision_Test_Y
  $7320,$02 Return if the difference is #REGd or more.
N $7322 A collision has been detected.
N $7322 See #POKE(immunity,Immunity).
  $7322,$02 #REGe=#N$01.
  $7324,$01 Return.

c $7325 Display Lives
@ $7325 label=DisplayPlayerLives
D $7325 Prints the number of lives each player has left at the top of the
. screen, each followed by a small life icon. A player with no lives left gets
. two spaces instead.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$6339,stop=$5F96,sp=$5D00)
. #SCR$02,$00,$00,$20,$02(lives-before) }
. { =h After (with #N$03 lives given to 2UP) }
. { #POKES$5E3A,$03
. #SIM(start=$5F96,stop=$5F99,sp=$5D00)
. #SCR$02,$00,$00,$20,$02(lives-after) } UDGTABLE# #POPS
E $7325 View the equivalent code in;
. #LIST
. { #COOKIE$7378 }
. { #JETPAC$70A4 }
. { #LUNARJETMAN$894F }
. { #SABREWULF$B7CD }
. { #TRANZAM$687B }
. LIST#
N $7325 Controller for 1UP lives.
  $7325,$06 Call #R$759A with #N($0040, $04, $04) (screen buffer address) for 1UP lives.
  $732B,$03 #REGa=1UP lives remaining (by calling #R$7364).
  $732E,$03 If 1UP lives are zero, jump to #R$734D.
  $7331,$03 Else, there are lives to display so call #R$7340.
N $7334 Controller for 2UP lives.
@ $7334 label=Controller2UPLives
  $7334,$06 Call #R$759A with #N($00B0, $04, $04) (screen buffer address) for 2UP lives.
  $733A,$03 #REGa=2UP lives remaining (by calling #R$7372).
  $733D,$03 If 2UP lives are zero, jump to #R$7352.
N $7340 Handles displaying the lives count and UDG character.
@ $7340 label=HandlerDisplayLives
  $7340,$02 Add #N$30 to convert to an ASCII character (starting at "0" character).
  $7342,$03 Call #R$73CD.
  $7345,$03 #REGde=#R$735C.
  $7348,$02 Stash #REGbc and #REGde on the stack.
  $734A,$03 Jump to #R$73DD.
N $734D 1UP has no lives.
@ $734D label=Handler1UPNoLives
  $734D,$03 Call #R$7352.
  $7350,$02 Jump to #R$7334.
N $7352 2UP has no lives.
@ $7352 label=Handler2UPNoLives
  $7352,$02 #REGa=ASCII " " (SPACE).
  $7354,$03 Call #R$73CD.
  $7357,$02 #REGa=ASCII " " (SPACE).
  $7359,$03 Jump to #R$73CD.

N $735C The UDG for the lives icon.
@ $735C label=UDG_Life
B $735C,$08,b$01 #UDGTABLE(default,centre) { #UDG#(#PC),attr=$07 } UDGTABLE#

N $7364 Return the 1UP player's lives left.
@ $7364 label=FetchLives_1UP
  $7364,$06 If #R$5E1E is not zero then jump to #R$736E.
N $736A Return currently active players Lives left.
@ $736A label=ActivePlayerLives
  $736A,$03 #REGa=#R$5E38.
  $736D,$01 Return.
N $736E Return inactive players Lives left.
@ $736E label=InactivePlayerLives
  $736E,$03 #REGa=#R$5E3A.
  $7371,$01 Return.
N $7372 Return the 2UP player's lives left.
@ $7372 label=FetchLives_2UP
  $7372,$06 If #R$5E1E is zero then jump to #R$736E.
  $7378,$02 Jump to #R$736A.

c $737A Add Points To Score
@ $737A label=AddPointsToScore
D $737A Adds a number of points to the score of the active player. The points
. are given as a two byte BCD number and the score is stored as three BCD bytes
. with the most significant byte first.
E $737A View the equivalent code in;
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
. { #SABREWULF$B5A9 }
. { #TRANZAM$6046 }
. { #UNDERWURLDE$A045 }
. LIST#
R $737A BC Points to add to score
N $737A Check the active player.
  $737A,$06 If #R$5E1E is not zero, jump to #R$7385.
N $7380 Set the score address for 1UP.
  $7380,$03 #REGhl=#R$5E07.
  $7383,$02 Jump to #R$7388.
N $7385 Set the score address for 2UP.
@ $7385 label=AddPointsToScore_2UP
  $7385,$03 #REGhl=#R$5E0A.
N $7388 Process adding the points to the appropriate score.
@ $7388 label=AddPointsToScore_Start
  $7388,$01 #REGa=score byte #3.
  $7389,$02 Add #REGc to score byte #3 with BCD conversion.
  $738B,$01 Update score byte #3.
  $738C,$01 Move onto the next score byte.
  $738D,$01 #REGa=score byte #2.
  $738E,$02 Add (with carry) #REGb to score byte #2 with BCD conversion.
  $7390,$01 Update score byte #2.
  $7391,$01 Move onto the next score byte.
  $7392,$01 #REGa=score byte #1.
  $7393,$03 Add #N$00 (i.e. just the carry flag) to score byte #1 with BCD conversion.
  $7396,$01 Update score byte #1.
N $7397 Check the active player.
  $7397,$06 If #R$5E1E is not zero (the active player is 2UP), jump to #R$73A5.

c $739D Print Scores
@ $739D label=Score_1UP
D $739D Prints the 1UP, 2UP and high scores as six digit numbers at the top of
. the screen. Entry points set up the screen address and the score address, and
. #R$73B3 prints the three BCD bytes as six digits.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$5F53,stop=$5F77,sp=$5D00)
. #SCR$02,$00,$00,$20,$02(scores-before) }
. { =h After }
. { #POKES$5E00,$01;$5E01,$23;$5E02,$40;$5E06,$12;$5E07,$34
. #POKES$5E09,$05;$5E0A,$60;$5D00,$00,$02
. #SIM(start=$5F77,stop=$0000,sp=$5D00)
. #SCR$02,$00,$00,$20,$02(scores-after) } UDGTABLE# #POPS
E $739D View the equivalent code in;
. #LIST
. { #ATICATAC$A1AE }
. { #COOKIE$7438 }
. { #JETPAC$711C }
. { #LUNARJETMAN$89BF }
. { #SABREWULF$B5CC }
. { #TRANZAM$6CB6 }
. LIST#
N $739D Sets up the 1UP score.
  $739D,$03 #REGhl=#N$4021 (screen buffer address).
  $73A0,$03 #REGde=#R$5E05.
  $73A3,$02 Jump to #R$73B3.

N $73A5 Sets up the 2UP score.
@ $73A5 label=Score_2UP
  $73A5,$03 #REGhl=#N$4039 (screen buffer address).
  $73A8,$03 #REGde=#R$5E08.
  $73AB,$02 Jump to #R$73B3.

N $73AD Sets up the HI score.
@ $73AD label=Score_HI
  $73AD,$03 #REGhl=#N$402D (screen buffer address).
  $73B0,$03 #REGde=#R$5E00.

N $73B3 Prints the score.
@ $73B3 label=PrintScore
  $73B3,$02 Set the byte counter to #N$03
. (each byte of the score holds two digits).
@ $73B5 label=PrintScore_Loop
  $73B5,$01 Fetch a byte of the score.
  $73B6,$04 Move the high digit down into the low nibble.
  $73BA,$02,b$01 Keep only bits 0-3 (the high digit).
  $73BC,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $73BE,$03 Call #R$73CD.
  $73C1,$01 Fetch the same byte of the score again.
  $73C2,$02,b$01 Keep only bits 0-3 (the low digit).
  $73C4,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $73C6,$03 Call #R$73CD.
  $73C9,$01 Increment #REGde by one.
  $73CA,$02 Decrease the byte counter by one and loop back to #R$73B5 until all
. six digits have been printed.
  $73CC,$01 Return.

c $73CD Print Character
@ $73CD label=PrintScreen
D $73CD Prints a single character from the ROM character set at a screen
. address, then moves on to the next column. #R$73DD is also used on its own to
. print the eight byte graphic at #REGde.
E $73CD View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #MARTIANOIDS$B5CB }
. { #NIGHTSHADE$CB19 }
. { #SABREWULF$B589 }
. { #TRANZAM$6C96 }
. { #UNDERWURLDE$98DF }
. LIST#
R $73CD A ASCII value to print
R $73CD HL Screen address
  $73CD,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $73D0,$03 Create an offset in #REGhl.
  $73D3,$03 #REGhl=#REGhl * 8.
  $73D6,$04 #REGde=#SKOOLKID$5C36(CHARS).
  $73DA,$02 #REGde=#REGhl + #N$3C00. For examples of usage;
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Letter | =h ASCII Value | =h * 8 (offset) | =h CHARS + offset }
. #FOREACH($55,$4C,$54,$49,$4D,$41,$54,$45)(value,
. { #LET(result=$3C00 + value * $08) "#CHR(value)" | #N(value) | #N(value * 8) | #SKOOLKID($3D00,{result})(#N({result})) }
. )
. TABLE#
N $73DC Print the character to the screen.
  $73DC,$01 Restore #REGhl, containing the screen buffer location, from the stack.
@ $73DD label=PrintScreen_Draw
  $73DD,$02 #REGb=#N$08 (#N$08 rows of pixels).
@ $73DF label=PrintScreen_Loop
  $73DF,$02 Copy a byte from the font data to the screen buffer.
  $73E1,$01 Increment the font data by one.
  $73E2,$01 Move onto the next pixel line.
  $73E3,$02 Decrease the row counter by one and loop back to #R$73DF until all
. eight pixel rows have been copied.
  $73E5,$02 Restore #REGde and #REGbc from the stack.
N $73E7 Reset #REGhl and move to the next column, ready to print the next character.
  $73E7,$04 #REGh=#REGh - #N$08 (reset the display line).
  $73EB,$01 Increment screen column by one.
  $73EC,$01 Return.

c $73ED Print Colour String
@ $73ED label=PrintStringColour
D $73ED Prints a string, with its colour, at a pixel position. The first byte of
. the string is the colour attribute and the characters that follow are printed
. until one with bit 7 set, which is the last character of the string.
E $73ED View the equivalent code in;
. #LIST
. { #ATICATAC$A1F3 }
. { #COOKIE$7488 }
. { #JETPAC$716C }
. { #LUNARJETMAN$8A11 }
. { #MARTIANOIDS$BD99 }
. { #SABREWULF$B53D }
. { #TRANZAM$6518 }
. { #UNDERWURLDE$9C3C }
. LIST#
R $73ED DE Pointer to string data
  $73ED,$01 Stash #REGhl on the stack.
  $73EE,$03 Call #R$759A.
  $73F1,$01 Fetch the attribute byte.
  $73F2,$01 Switch to the shadow #REGaf register.
  $73F3,$01 Increment #REGde by one to point to the text of the string.
  $73F4,$01 Switch to the shadow registers.
  $73F5,$01 Restore #REGhl' from the stack.
  $73F6,$03 Call #R$748F.

@ $73F9 label=PrintString_Loop
  $73F9,$01 Switch back to the normal registers.
  $73FA,$01 Fetch the character to print.
  $73FB,$04 If bit 7 is set (which signifies the end of the string), jump to #R$740A.
  $73FF,$03 Call #R$73CD.
  $7402,$01 Increment #REGde by one.
  $7403,$01 Switch to the shadow registers.
  $7404,$01 Switch to the shadow #REGaf register.
  $7405,$01 Copy the attribute byte to the screen.
  $7406,$01 Increment #REGl by one.
  $7407,$01 Switch to the shadow #REGaf register.
  $7408,$02 Jump to #R$73F9.
N $740A Because the last character contains the terminator, it needs to be handled separately.
@ $740A label=PrintString_LastCharacter
  $740A,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $740C,$03 Call #R$73CD.
  $740F,$01 Switch to the shadow registers.
  $7410,$01 Switch to the shadow #REGaf register.
  $7411,$01 Copy the attribute byte to the screen.
  $7412,$01 Return.

c $7413 Print Banner
@ $7413 label=PrintBanner
D $7413 Prints the "1UP", "HI" and "2UP" captions along the top of the screen.
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$61CD,stop=$61EA,clear=1,sp=$5D00)
. #POKES$5C37,$3C
. #SIM(start=$5F53,stop=$5F5C,sp=$5D00)
. #SCR$02,$00,$00,$20,$01(banner-before) }
. { =h After }
. { #SIM(start=$5F5C,stop=$5F5F,sp=$5D00)
. #SCR$02,$00,$00,$20,$01(banner-after) } UDGTABLE# #POPS
E $7413 View the equivalent code in;
. #LIST
. { #COOKIE$74AE }
. { #JETPAC$7192 }
. { #LUNARJETMAN$8A37 }
. { #SABREWULF$B563 }
. LIST#
N $7413 Prints "1UP".
  $7413,$03 #REGhl=#N($0018, 4, 4).
  $7416,$03 #REGde=#R$742E.
  $7419,$03 Call #R$73ED.
N $741C Prints "HI".
  $741C,$03 #REGhl=#N($0078, 4, 4).
  $741F,$03 #REGde=#R$7436.
  $7422,$03 Call #R$73ED.
N $7425 Prints "2UP".
  $7425,$03 #REGhl=#N($00D8, 4, 4).
  $7428,$03 #REGde=#R$7432.
  $742B,$03 Jump to #R$73ED.
N $742E Banner text data.
@ $742E label=1UP_Text
T $742E,$04,h$01,$02:$01 "1UP" (#COLOUR(#PEEK(#PC)) is the attribute).
@ $7432 label=2UP_Text
T $7432,$04,h$01,$02:$01 "2UP" (#COLOUR(#PEEK(#PC)) is the attribute).
@ $7436 label=HI_Text
T $7436,$03,h$01,$01:$01 "HI" (#COLOUR(#PEEK(#PC)) is the attribute).

c $7439 Reset Screen Buffer
@ $7439 label=ResetScreen
D $7439 Clears the screen buffer to zero, but leaves the attribute buffer alone.
E $7439 View the equivalent code in;
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
. { #SABREWULF$BB81 }
. { #TRANZAM$7211 }
. LIST#
E $7439 Continue on to #R$7440 to blank the screen buffer.
  $7439,$03 #REGhl=#N$4000 (the start of the screen buffer).
  $743C,$02 #REGb=#N$58 (i.e. finish once we reach the start of the attribute
. buffer at #N$5800).
  $743E,$02 #REGc=#N$00 (value to write).

c $7440 Fill Memory
@ $7440 label=ResetCopier
D $7440 Writes a single byte over a block of memory, from the start address up
. to (but not including) the page whose MSB is in #REGb.
E $7440 View the equivalent code in;
. #LIST
. { #ATICATAC$80BB }
. { #COOKIE$74DB }
. { #JETPAC$71B8 }
. { #JETPAC$71BF }
. { #LUNARJETMAN$84B4 }
. { #SABREWULF$BB88 }
. { #TRANZAM$7218 }
. LIST#
R $7440 HL Target address
R $7440 B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $7440 C Value to write
  $7440,$01 Write #REGc to the target address.
  $7441,$01 Increment the target address by one.
  $7442,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $7444,$02 Keep looping back to #R$7440 until there is no carry-over.
  $7446,$01 Return.

c $7447 Reset Attribute Buffer
@ $7447 label=ResetAttributes
D $7447 Clears the attribute buffer to zero (black ink on a black paper).
E $7447 View the equivalent code in;
. #LIST
. { #ATICATAC$80C2 }
. { #COOKIE$74E2 }
. { #JETPAC$71C6 }
. { #LUNARJETMAN$84BB }
. { #SABREWULF$BB8F }
. { #TRANZAM$7200 }
. LIST#
  $7447,$03 #REGhl=#N$5800 (the start of the attribute buffer).
  $744A,$02 #REGb=#N$5B (i.e. finish once we reach the end of the attribute
. buffer).
  $744C,$02 #REGc=#N$00 (value to write).
  $744E,$02 Jump to #R$7440.

c $7450 Colourise Sprite
@ $7450 label=ColouriseSprite
D $7450 Writes the colour of an actor into the attribute buffer, covering the
. character cells that its sprite has just been drawn over. The pixels are
. drawn first (see #R$74EB), so until this routine runs the sprite is drawn in
. the attribute that was already there.
E $7450 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$8733 }
. LIST#
R $7450 IX Actor object
N $7450 #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$6339,stop=$634F,sp=$5D00)
. #POKES$5E22,$00;$5E03,$00
. #SIM(start=$6DBA,stop=$6F31,ix=$5E6C,sp=$5D00)
. #SIM(start=$6F31,stop=$7450,ix=$5E6C,sp=$5D00)
. #SCR$03,$0D,$0B,$07,$06(colourise-before)
. | #SIM(start=$7450,stop=$748E,ix=$5E6C,sp=$5D00)
. #SCR$03,$0D,$0B,$07,$06(colourise-after) } UDGTABLE# #POPS
  $7450,$01 Switch to the shadow registers.
  $7451,$03 Fetch the screen position of the sprite from #R$5E1A.
  $7454,$03 Convert it to an attribute buffer address using #R$748F.
  $7457,$04 Set the column counter in #REGb' to the sprite width, from
. #R$5E0F.
  $745B,$03 Fetch the sprite height in pixels from #R$5E0E.
  $745E,$04 Divide the height by #N$04, add #N$01, then divide by #N$02.
  $7462,$02,b$01 Keep only bits 0-4.
  $7464,$01 Increment #REGa by one.
  $7465,$01 Set the row counter in #REGc' to the result.
  $7466,$03 Fetch the colour attribute from *#REGix+#N$03.
  $7469,$01 Remember the sprite width in #REGe' so that the column counter can
. be reset for each row.
N $746A Colour one row of attribute cells.
@ $746A label=ColouriseSprite_Loop1
  $746A,$01 Stash the address of the start of the row on the stack.
@ $746B label=ColouriseSprite_Loop2
  $746B,$01 Fetch the MSB of the attribute buffer address.
  $746C,$04 Jump to #R$7481 if the address is beyond the attribute buffer
. (#REGh is at least #N$5B).
  $7470,$04 Jump to #R$7481 if the address is before the attribute buffer
. (#REGh is less than #N$58).
  $7474,$01 Write the colour to the attribute buffer.
  $7475,$01 Move onto the next column.
  $7476,$01 Fetch the low byte of the address.
  $7477,$02,b$01 Keep only bits 0-4 (the column).
  $7479,$02 Jump to #R$747F if the column has not wrapped onto the next row.
  $747B,$04 Move back to the start of the same row of attribute cells.
@ $747F label=ColouriseSprite_NextColumn
  $747F,$02 Decrease the column counter by one and loop back to #R$746B until
. it is zero.
N $7481 Move up one row of attribute cells.
@ $7481 label=ColouriseSprite_NextRow
  $7481,$01 Restore the address of the start of the row from the stack.
  $7482,$08 Subtract #N$20 from #REGhl, preserving #REGbc.
  $748A,$01 Reset the column counter from #REGe'.
  $748B,$03 Decrease the row counter by one and loop back to #R$746A until it
. is zero.
  $748E,$01 Return.

c $748F Calculate Attribute Address
@ $748F label=AttributeAddress
D $748F Converts a pixel position into the address of the attribute cell that
. covers it. This is the attribute equivalent of #R$759A.
E $748F View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #COOKIE$7534 }
. { #JETPAC$720E }
. { #LUNARJETMAN$8506 }
. { #SABREWULF$B8DD }
. { #TRANZAM$7097 }
. { #UNDERWURLDE$ADE0 }
. LIST#
N $748F Converts a given pixel address to the associated attribute buffer address.
R $748F HL Pixel address co-ordinates
R $748F O:HL Attribute buffer address
  $748F,$01 Horizontal co-ordinate.
  $7490,$03 Divide by #N08.
  $7493,$02,b$01 Keep only bits 0-4 (#N$00-#N$1F / minimum-maximum horizontal screen values).
  $7495,$01 Store this back in #REGl.
  $7496,$01 Vertical co-ordinate.
  $7497,$02 Multiply by #N$04.
  $7499,$01 Store this in #REGc temporarily.
  $749A,$02,b$01 Keep only bits 5-7.
  $749C,$01 Set the bits from #REGl.
  $749D,$01 #REGl=#REGa.
  $749E,$01 Fetch the stored value from #REGc.
  $749F,$02,b$01 Keep only bits 0-1.
  $74A1,$02,b$01 Set MSB of the attribute buffer #N$58. This ensures our value is
. >= #N$5800.
  $74A3,$01 Store this back in #REGh.
  $74A4,$01 Return.

c $74A5 Set Up Previous Sprite
@ $74A5 label=SetUpPreviousSprite
D $74A5 Sprites are drawn by erasing the previous image and drawing the new
. one at the same time, a row at a time. The routines from here to #R$74F2
. prepare the two images: the main registers hold one sprite and the shadow
. registers hold the other. Each is set up with the screen address in
. #REGhl, the sprite width in #REGb, a row count of zero in #REGc and the
. sprite data pointer in #REGde.
.
. This entry point finds the previous sprite from the temporary actor state
. at #R$5E0B, using #R$7542 to get its graphic.
  $74A5,$03 Call #R$7542.
N $74A8 Sets up the previous sprite using the sprite data address in #REGde,
. rather than looking it up.
@ $74A8 label=SetUpPreviousSprite_Address
  $74A8,$03 Fetch the previous X and Y position from #R$5E0B.
N $74AB The first byte of the sprite is a horizontal offset in pixels.
@ $74AB label=SetUpPreviousSprite_Offset
  $74AB,$01 Fetch the horizontal offset.
  $74AC,$01 Move onto the sprite width.
  $74AD,$01 Add the horizontal offset to the X position.
  $74AE,$01 Store the result back in #REGl.
  $74AF,$03 Convert the position into a screen address using #R$759A.
  $74B2,$01 Fetch the sprite width.
  $74B3,$01 Set the width counter in #REGb to the sprite width.
  $74B4,$01 Move onto the sprite height.
  $74B5,$01 Fetch the sprite height.
  $74B6,$03 Store it in #R$5E10 as the height of the previous sprite.
@ $74B9 label=SetUpSprite_Finish
  $74B9,$02 Set the row count in #REGc to #N$00 (no rows have been drawn yet).
  $74BB,$01 Move onto the first byte of the sprite graphic data.
  $74BC,$01 Return.
N $74BD Sets up the sprite of the actor in #REGix, using #R$757A to get its
. graphic.
@ $74BD label=SetUpSprite
  $74BD,$03 Call #R$757A.
N $74C0 Sets up the sprite using the sprite data address in #REGde, at the
. position held in the actor object.
@ $74C0 label=SetUpSprite_Address
  $74C0,$06 Fetch the X and Y position from *#REGix+#N$01 and
. *#REGix+#N$02.
@ $74C6 label=SetUpSprite_Offset
  $74C6,$01 Fetch the horizontal offset.
  $74C7,$01 Move onto the sprite width.
  $74C8,$01 Add the horizontal offset to the X position.
  $74C9,$01 Store the result back in #REGl.
  $74CA,$03 Store the screen position in #R$5E1A.
  $74CD,$03 Convert the position into a screen address using #R$759A.
  $74D0,$01 Fetch the sprite width.
  $74D1,$01 Set the width counter in #REGb to the sprite width.
  $74D2,$03 Store it in #R$5E0F.
  $74D5,$01 Move onto the sprite height.
  $74D6,$01 Fetch the sprite height.
  $74D7,$03 Store it in #R$5E11 as the height of the new sprite.
  $74DA,$03 Store it in #R$5E0E.
  $74DD,$02 Jump to #R$74B9.
N $74DF Moves a sprite using the same sprite data in #REGde for both the
. previous image (erased) and the new image (drawn).
@ $74DF label=ReplaceSprite
  $74DF,$01 Stash the sprite data pointer on the stack.
  $74E0,$03 Set up the previous sprite using #R$74A8.
  $74E3,$01 Switch to the shadow registers.
  $74E4,$01 Restore the sprite data pointer from the stack.
  $74E5,$03 Set up the new sprite using #R$74C0.
  $74E8,$01 Switch to the shadow registers.
  $74E9,$02 Jump to #R$74F2.
N $74EB Display Entity. Erases the previous sprite of the actor in
. #REGix and draws the new one.
.
. #PUSHS #UDGTABLE(default,centre,centre,centre)
. { =h Before | =h After #R$74EB | =h After #R$7450 }
. { #SIM(start=$6339,stop=$634F,sp=$5D00)
. #POKES$5E22,$00;$5E03,$00
. #SIM(start=$6DBA,stop=$6F31,ix=$5E6C,sp=$5D00)
. #SCR$03,$0D,$0B,$07,$06(move-sprite-before)
. | #SIM(start=$6F31,stop=$7450,ix=$5E6C,sp=$5D00)
. #SCR$03,$0D,$0B,$07,$06(move-sprite-drawn)
. | #SIM(start=$7450,stop=$748E,ix=$5E6C,sp=$5D00)
. #SCR$03,$0D,$0B,$07,$06(move-sprite-coloured) } UDGTABLE# #POPS
@ $74EB label=DisplayEntity
E $74EB View the equivalent code in;
. #LIST
. { #ATICATAC$9FCA }
. { #COOKIE$75CC }
. { #JETPAC$726A }
. { #SABREWULF$B9A9 }
. { #TRANZAM$7101 }
. { #UNDERWURLDE$96F7 }
. LIST#
R $74EB IX Actor object
  $74EB,$03 Set up the new sprite using #R$74BD.
  $74EE,$01 Switch to the shadow registers.
  $74EF,$03 Set up the previous sprite using #R$74A5.
N $74F2 Work out how many rows of one sprite lie beyond the other.
@ $74F2 label=DisplayEntity_Compare
  $74F2,$03 Fetch the previous Y position from #R$5E0C.
  $74F5,$03 Subtract the new Y position.
  $74F8,$03 Jump to #R$7601 if the two sprites start on the same row.
  $74FB,$03 Jump to #R$750D if the new sprite starts lower down the screen.
  $74FE,$01 Store the number of extra rows in #REGc.
  $74FF,$03 Fetch the height of the previous sprite from #R$5E10.
  $7502,$01 Compare it with the number of extra rows.
  $7503,$03 Jump to #R$7601 if the sprites do not overlap.
  $7506,$01 Subtract the extra rows from the height of the previous sprite.
  $7507,$03 Write it back to #R$5E10.
  $750A,$03 Jump to #R$75D0 to erase the extra rows of the previous sprite
. first.
N $750D The new sprite starts lower down the screen, so its extra rows are
. drawn first.
@ $750D label=DisplayEntity_NewLower
  $750D,$01 Switch to the shadow registers.
  $750E,$02 Make the number of extra rows positive.
  $7510,$01 Store the number of extra rows in #REGc.
  $7511,$03 Fetch the height of the new sprite from #R$5E11.
  $7514,$01 Compare it with the number of extra rows.
  $7515,$03 Jump to #R$7600 if the sprites do not overlap.
  $7518,$01 Subtract the extra rows from the height of the new sprite.
  $7519,$03 Jump to #R$7614.

c $751C Draw Sprite
@ $751C label=DrawSprite
D $751C Draws a sprite without erasing anything, or erases a sprite without
. drawing anything.
R $751C DE Sprite data
R $751C IX Actor object
  $751C,$03 Set up the sprite using #R$74C0.
  $751F,$02 Jump to #R$7539.
N $7521 Erases the sprite at #REGde from the previous position.
@ $7521 label=RemoveEntity_Address
  $7521,$03 Set up the previous sprite using #R$74A8.
  $7524,$02 Jump to #R$7529.
N $7526 Remove Entity. Erases the previous sprite of an actor.
@ $7526 label=RemoveEntity
  $7526,$03 Set up the previous sprite using #R$74A5.
N $7529 Clears the height of the new sprite so that nothing is drawn.
@ $7529 label=RemoveEntity_ClearNew
  $7529,$01 Switch to the shadow registers.
  $752A,$01 Set #REGa to #N$00.
  $752B,$01 Set the row count in #REGc to #N$00.
  $752C,$03 Write #N$00 to #R$5E11.
  $752F,$03 Write #N$00 to #R$5E0E.
  $7532,$01 Switch to the shadow registers.
  $7533,$03 Jump to #R$75D0.
N $7536 Draw Entity. This entry point is not used.
@ $7536 label=DrawEntity
  $7536,$03 Set up the sprite of the actor in #REGix using #R$74BD.
N $7539 Clears the height of the previous sprite so that nothing is erased.
@ $7539 label=DrawSprite_ClearPrevious
  $7539,$01 Switch to the shadow registers.
  $753A,$01 Set #REGa to #N$00.
  $753B,$03 Write #N$00 to #R$5E10.
  $753E,$01 Set the row count in #REGc to #N$00.
  $753F,$03 Jump to #R$75D0.

c $7542 Prepare Old Sprite
@ $7542 label=PrepareOldSprite
D $7542 Finds the graphic for the previous state of an object, using the copy
. of its X position and state that #R$75B9 saved at #R$5E0B. The rest of the
. routine, from #R$754B, is shared with #R$757A.
. .
. The sprite is looked up in #R$761A (for types #N$01-#N$03) or #R$764A (for
. types #N$04-#N$0D). The entry is chosen by the object type (the state with
. bits 6 and 7 removed), by the X position within a character cell and by bit
. 6 of the state, which selects the second set of sprites.
E $7542 View the equivalent code in;
. #LIST
. { #TRANZAM$70B2 }
. LIST#
R $7542 O:DE Address of the sprite
  $7542,$03 #REGa=the saved X position (from #R$5E0B).
  $7545,$02,b$01 Keep only bits 1-2 (the X position within a character cell, in
. steps of two pixels).
  $7547,$01 Keep the X position bits in #REGc.
  $7548,$03 #REGa=the saved state (from #R$5E0D).
N $754B Find the sprite from the state in #REGa and the X position bits in
. #REGc.
@ $754B label=ActorGetSpriteAddress
  $754B,$04 Jump to #R$7551 if bit 6 of the state is clear.
  $754F,$02 Set bit 3 of #REGc to select the second set of sprites.
@ $7551 label=ActorGetSpriteAddress_Type
  $7551,$01 Decrease the state by one (so that type #N$01 becomes #N$00).
  $7552,$04 Jump to #R$7568 if the result is #N$03 or more.
N $7556 Types #N$01-#N$03 have eight sprites each (four X positions for each of
. the two directions).
  $7556,$04 Multiply the type by #N$10 (the length of a type's entries in the
. table).
  $755A,$02,b$01 Keep only bits 4-7.
  $755C,$01 Add in the X position and direction bits from #REGc.
  $755D,$03 #REGhl=#R$761A.
@ $7560 label=ActorGetSpriteAddress_Lookup
  $7560,$01 Store the offset in #REGc.
  $7561,$02 #REGb=#N$00.
  $7563,$01 #REGhl=the table address + the offset.
  $7564,$03 Fetch the sprite address into #REGde.
  $7567,$01 Return.
N $7568 Types #N$04 and above have four sprites each, which only change with bit
. 2 of the X position and with the direction.
@ $7568 label=ActorGetSpriteAddress_OtherTypes
  $7568,$02 Subtract #N$03 from the type (it is already one less than the real
. type), so that type #N$04 becomes #N$00.
  $756A,$03 Multiply the type by #N$08 (the length of a type's entries in the
. table).
  $756D,$02,b$01 Keep only bits 3-7.
  $756F,$01 Store the result in #REGb.
  $7570,$01 #REGa=#REGc.
  $7571,$01 Move the X position bits and the direction bit down by one place.
  $7572,$02,b$01 Keep only bits 1-2.
  $7574,$01 Add in the type offset.
  $7575,$03 #REGhl=#R$764A.
  $7578,$02 Jump to #R$7560.

c $757A Find Object Sprite
@ $757A label=ActorMoveSprite
D $757A Finds the graphic for the current state of an object. This is the same
. as #R$7542 except that the X position and state are taken from the object.
R $757A IX Object
R $757A O:DE Address of the sprite
  $757A,$03 #REGa=the object's X position.
  $757D,$02,b$01 Keep only bits 1-2.
  $757F,$01 Keep the X position bits in #REGc.
  $7580,$03 #REGa=the object's state.
  $7583,$02 Jump to #R$754B.

c $7585 Screen Address One Pixel Above
@ $7585 label=ScreenPosition1PixelAbove
D $7585 Moves a screen address up by one pixel row, allowing for the layout of
. the screen buffer.
E $7585 View the equivalent code in;
. #LIST
. { #ATICATAC$9F03 }
. { #LUNARJETMAN$85F6 }
. { #UNDERWURLDE$AE71 }
. LIST#
R $7585 HL Screen address
R $7585 O:HL Screen address one pixel row above
  $7585,$01 Decrease #REGh by one to move up one pixel row within the character
. cell.
  $7586,$01 Store the result in #REGa.
  $7587,$02,b$01 Keep only bits 0-2.
  $7589,$03 Return if the top of the character cell has not been crossed.
  $758C,$04 Subtract #N$20 from #REGl to move up one character row.
  $7590,$02,b$01 Keep only bits 5-7.
  $7592,$03 Return if the move crossed into the previous third of the screen
. (the address is then already correct).
  $7595,$05 Add #N$08 to #REGh to move to the bottom pixel row of the character
. row above, then return.

c $759A Calculate Screen Address
@ $759A label=ScreenAddress
D $759A Converts a pixel position into an address in the screen buffer.
E $759A View the equivalent code in;
. #LIST
. { #ATICATAC$9BA2 }
. { #COOKIE$76E3 }
. { #JETPAC$7308 }
. { #LUNARJETMAN$851E }
. { #MARTIANOIDS$BD4B }
. { #SABREWULF$B8AD }
. { #TRANZAM$6F10 }
. { #UNDERWURLDE$ADF8 }
. LIST#
R $759A H Y position (pixel row)
R $759A L X position (pixel column)
R $759A O:HL Screen buffer address
  $759A,$01 #REGa=the X position.
  $759B,$03 Divide by #N$08 (to give the character column).
  $759E,$02,b$01 Keep only bits 0-4.
  $75A0,$01 Store the column in #REGl.
  $75A1,$01 #REGa=the Y position.
  $75A2,$02 Multiply by #N$04, so that bits 3-5 of the Y position are in bits
. 5-7.
  $75A4,$02,b$01 Keep only bits 5-7 (the character row within the third).
  $75A6,$01 Combine with the column.
  $75A7,$01 Store the result in #REGl.
  $75A8,$01 #REGa=the Y position.
  $75A9,$02,b$01 Keep only bits 0-2 (the pixel row within the character cell).
  $75AB,$01 Switch to the shadow #REGaf register to keep the result.
  $75AC,$01 #REGa=the Y position.
  $75AD,$03 Divide by #N$08.
  $75B0,$02,b$01 Keep only bits 3-4 (the third of the screen).
  $75B2,$02,b$01 Set bit 6 to point at the screen buffer.
  $75B4,$01 Store the result in #REGh.
  $75B5,$01 Switch back to the saved pixel row.
  $75B6,$01 Combine with the third of the screen.
  $75B7,$01 Store the result in #REGh.
  $75B8,$01 Return.

c $75B9 Store Entity
@ $75B9 label=StoreEntity
D $75B9 Saves the position and state of an object, so that its sprite can be
. erased from the old position when it is next drawn.
E $75B9 View the equivalent code in;
. #LIST
. { #ATICATAC$9FFB }
. { #JETPAC$7327 }
. { #SABREWULF$BB0B }
. { #TRANZAM$71ED }
. { #UNDERWURLDE$989F }
. LIST#
R $75B9 IX Object
  $75B9,$06 Save the object's X position in #R$5E0B.
  $75BF,$06 Save the object's Y position in #R$5E0C.
  $75C5,$06 Save the object's state in #R$5E0D.
  $75CB,$01 Return.

c $75CC Controls: Kempston Joystick
@ $75CC label=ReadKempstonJoystick
D $75CC Reads the Kempston joystick port. The bits are inverted so that a
. pressed direction or fire button reads as a clear bit, in the same way as
. the keyboard controls.
E $75CC View the equivalent code in;
. #LIST
. { #JETPAC$733A }
. { #LUNARJETMAN$8F9B }
. { #SABREWULF$B0D9 }
. LIST#
R $75CC O:A Joystick controls
  $75CC,$02 Read the joystick from the Kempston port.
  $75CE,$01 Flip the bits.
  $75CF,$01 Return.

c $75D0 Draw Sprite Rows
@ $75D0 label=MaskSprite
D $75D0 Erases the previous sprite and draws the new one, one pixel row at a
. time, working up the screen from the bottom row. The main registers hold the
. previous sprite and the shadow registers hold the new sprite. A row of the
. previous sprite is cleared by ANDing the screen with the inverted sprite
. data. A row of the new sprite is ORed onto the screen.
. .
. The first pass handles the rows where only one of the two sprites has any
. data. The heights at #R$5E10 and #R$5E11 then give the rows both sprites
. have in common, which are done on the second pass.
R $75D0 B Sprite width in bytes
R $75D0 C Number of rows left to process
R $75D0 DE Address into a sprite
R $75D0 HL Address in the screen buffer
  $75D0,$01 #REGa=the number of rows left of the previous sprite.
  $75D1,$01 Set the flags.
  $75D2,$02 Jump to #R$75FB if there are no more rows of the previous sprite.
  $75D4,$01 Decrease the row counter by one.
  $75D5,$02 Stash the counter and the screen address on the stack.
N $75D7 Clear one row of the previous sprite from the screen.
@ $75D7 label=MaskSprite_Erase
  $75D7,$01 Fetch a byte of the sprite.
  $75D8,$01 Invert it.
  $75D9,$01 Remove the sprite pixels from the screen.
  $75DA,$01 Write the result back to the screen.
  $75DB,$01 Move onto the next byte of the sprite.
  $75DC,$01 Move onto the next column.
  $75DD,$02 Decrease the width counter by one and loop back to #R$75D7 until the
. whole row of the sprite has been erased.
  $75DF,$01 Restore the screen address from the stack.
  $75E0,$03 Move up one pixel row.
  $75E3,$01 Restore the counter from the stack.
N $75E4 Switch to the new sprite.
@ $75E4 label=MaskSprite_Draw
  $75E4,$01 Switch to the shadow registers.
  $75E5,$01 #REGa=the number of rows left of the new sprite.
  $75E6,$01 Set the flags.
  $75E7,$02 Jump to #R$75F8 if there are no more rows of the new sprite.
@ $75E9 label=MaskSprite_Draw_Row
  $75E9,$01 Decrease the row counter by one.
  $75EA,$02 Stash the counter and the screen address on the stack.
N $75EC Draw one row of the new sprite onto the screen.
@ $75EC label=MaskSprite_Draw_Loop
  $75EC,$01 Fetch a byte of the sprite.
  $75ED,$01 Combine it with the screen.
  $75EE,$01 Write the result back to the screen.
  $75EF,$01 Move onto the next byte of the sprite.
  $75F0,$01 Move onto the next column.
  $75F1,$02 Decrease the width counter by one and loop back to #R$75EC until the
. whole row of the sprite has been drawn.
  $75F3,$01 Restore the screen address from the stack.
  $75F4,$03 Move up one pixel row.
  $75F7,$01 Restore the counter from the stack.
@ $75F8 label=MaskSprite_Next
  $75F8,$01 Switch back to the previous sprite.
  $75F9,$02 Jump back to #R$75D0 to do the next pair of rows.
N $75FB There are no more rows of the previous sprite, so only the new sprite
. is left to draw.
@ $75FB label=MaskSprite_NewOnly
  $75FB,$01 Switch to the new sprite.
  $75FC,$01 #REGa=the number of rows left of the new sprite.
  $75FD,$01 Set the flags.
  $75FE,$02 Jump to #R$75E9 if there are rows to draw.
N $7600 Both sprites have been drawn as far as their rows go.
@ $7600 label=MaskSprite_Finish
  $7600,$01 Switch back to the previous sprite.
@ $7601 label=MaskSprite_Finish_Previous
  $7601,$04 Fetch the remaining row count of the previous sprite from #R$5E10
. and keep it in #REGc.
  $7605,$03 Fetch the remaining row count of the new sprite from #R$5E11.
  $7608,$01 Combine them.
  $7609,$01 Return if there are no rows left on either sprite.
  $760A,$04 Clear #R$5E10 so that it is only used once.
  $760E,$01 Switch to the new sprite.
  $760F,$04 Fetch the remaining row count from #R$5E11 and keep the remaining
. row count of the new sprite in #REGc.
  $7613,$01 #REGa=#N$00.
@ $7614 label=MaskSprite_Finish_ClearNew
  $7614,$03 Write #N$00 to #R$5E11 so that it is only used once.
  $7617,$01 Switch back to the previous sprite.
  $7618,$02 Jump to #R$75D0 to process the rows both sprites have.

w $761A Sprite Table
@ $761A label=SpritesTable
D $761A The addresses of the sprites for each object type, which are found by
. #R$7542 and #R$757A. Types #N$01-#N$03 (Robbie and the spray can) have eight
. words each. The first four are for the X position within a character cell
. (bits 1-2) when bit 6 of the state is clear. The second four are for when bit
. 6 is set, and have the same four images in the reverse order. Types #N$01
. and #N$02 (Robbie) share the same images.
. .
. Types #N$04-#N$0D (from #R$764A: smoke bombs, a slug, repellent, midges, a
. leech and the bonus items) have four words each. Bit 2 of the X position
. gives the first or the second image of a pair, and then the same pair is used
. again when bit 6 of the state is set (or a different pair for the slug,
. repellent and leech).
E $761A View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #LUNARJETMAN$BAC0 }
. { #SABREWULF$BF84 }
. { #TRANZAM$7F06 }
. LIST#
  $761A,$02 Sprite ID: #R(#PEEK(#PC)+#PEEK(#PC+$01)*$100)(#N((#PC-$761A)/$02)).
L $761A,$02,$18
@ $764A label=SpritesTable_Other
  $764A,$02 Sprite ID: #R(#PEEK(#PC)+#PEEK(#PC+$01)*$100)(#N((#PC-$761A)/$02)).
L $764A,$02,$28

b $769A Sprite: Flower (Bud)
@ $769A label=Sprite_Flower_1
D $769A The sprite of the flower when it is a bud, which is used while the
. flower is growing (see #R$6D0C) and for the first stage of blooming (see
. #R$6787).
N $769A #DIMENSIONS
  $769A,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $769B,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $769C,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $769D,$39,$03 #SPRITE$769A(flower-01)

b $76D6 UDG Graphics
@ $76D6 label=UDG_Brick
D $76D6 The graphics (which are not sprites) that are used to build the brick
. walls, the cubby hole shelves and the floor of the play area (see #R$602E).
N $76D6 ID: "#N(#EVAL((#PC - $76D6) / $08))".
  $76D6,b$08,$01 #UDG(#PC,attr=$7A)
N $76DE ID: "#N(#EVAL((#PC - $76D6) / $08))".
@ $76DE label=UDG_Floor_1
  $76DE,b$08,$01 #UDG(#PC,attr=$32)
N $76E6 ID: "#N(#EVAL((#PC - $76D6) / $08))".
@ $76E6 label=UDG_Floor_2
  $76E6,b$08,$01 #UDG(#PC,attr=$32)

b $76EE Sprite: Pesticide Spray Can
@ $76EE label=Sprite_Spray_Can_1
D $76EE The four images of the spray can, one for each X position within a
. character cell (see #R$761A). The second image is also used for the spray cans
. in the cubby holes (see #R$601B).
N $76EE #DIMENSIONS
  $76EE,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $76EF,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $76F0,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $76F1,$20,$02 #SPRITE$76EE(can-01)

N $7711 #DIMENSIONS
@ $7711 label=Sprite_Spray_Can_2
  $7711,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7712,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7713,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7714,$20,$02 #SPRITE$7711(can-02)

N $7734 #DIMENSIONS
@ $7734 label=Sprite_Spray_Can_3
  $7734,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7735,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7736,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7737,$20,$02 #SPRITE$7734(can-03)

N $7757 #DIMENSIONS
@ $7757 label=Sprite_Spray_Can_4
  $7757,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7758,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7759,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $775A,$30,$03 #SPRITE$7757(can-04)

b $778A Sprite: Robbie the robot
@ $778A label=Sprite_Robbie_1
D $778A The four images of Robbie, one for each X position within a character
. cell (see #R$761A). The same images are used when he is carrying a can.
N $778A #DIMENSIONS
  $778A,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $778B,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $778C,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $778D,$39,$03 #SPRITE$778A(robbie-01*)

N $77C6 #DIMENSIONS
@ $77C6 label=Sprite_Robbie_2
  $77C6,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $77C7,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $77C8,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $77C9,$39,$03 #SPRITE$77C6(robbie-02*)

N $7802 #DIMENSIONS
@ $7802 label=Sprite_Robbie_3
  $7802,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7803,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7804,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7805,$39,$03 #SPRITE$7802(robbie-03*)

N $783E #DIMENSIONS
@ $783E label=Sprite_Robbie_4
  $783E,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $783F,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7840,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7841,$39,$03 #SPRITE$783E(robbie-04*)

b $787A Sprite: Leaves
@ $787A label=Sprite_Leaf_1
D $787A The eight images of the leaves. The first four are for a leaf on the
. right of the flower and the second four are for a leaf on the left, with each
. going from the smallest to the largest (see #R$6CE1).
N $787A #DIMENSIONS
  $787A,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $787B,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $787C,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $787D,$05,$01 #SPRITE$787A(leaf-01)

N $7882 #DIMENSIONS
@ $7882 label=Sprite_Leaf_2
  $7882,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7883,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7884,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7885,$08,$01 #SPRITE$7882(leaf-02)

N $788D #DIMENSIONS
@ $788D label=Sprite_Leaf_3
  $788D,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $788E,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $788F,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7890,$16,$02 #SPRITE$788D(leaf-03)

N $78A6 #DIMENSIONS
@ $78A6 label=Sprite_Leaf_4
  $78A6,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $78A7,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $78A8,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $78A9,$20,$02 #SPRITE$78A6(leaf-04)

N $78C9 #DIMENSIONS
@ $78C9 label=Sprite_Leaf_5
  $78C9,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $78CA,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $78CB,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $78CC,$05,$01 #SPRITE$78C9(leaf-05)

N $78D1 #DIMENSIONS
@ $78D1 label=Sprite_Leaf_6
  $78D1,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $78D2,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $78D3,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $78D4,$08,$01 #SPRITE$78D1(leaf-06)

N $78DC #DIMENSIONS
@ $78DC label=Sprite_Leaf_7
  $78DC,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $78DD,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $78DE,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $78DF,$16,$02 #SPRITE$78DC(leaf-07)

N $78F5 #DIMENSIONS
@ $78F5 label=Sprite_Leaf_8
  $78F5,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $78F6,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $78F7,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $78F8,$20,$02 #SPRITE$78F5(leaf-08)

b $7918 Sprite: Smoke Bomb
@ $7918 label=Sprite_Smoke_Bomb_1
D $7918 The six images of the smoke bomb, which gets larger as it ages. Each of
. the types #N$04-#N$06 has two images, one for each position of bit 2 of the X
. position (see #R$764A).
N $7918 #DIMENSIONS
  $7918,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7919,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $791A,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $791B,$07,$01 #SPRITE$7918(smoke-01)

N $7922 #DIMENSIONS
@ $7922 label=Sprite_Smoke_Bomb_2
  $7922,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7923,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7924,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7925,$0E,b$02 #SPRITE$7922(smoke-02)

N $7933 #DIMENSIONS
@ $7933 label=Sprite_Smoke_Bomb_3
  $7933,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7934,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7935,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7936,$10,$02 #SPRITE$7933(smoke-03)

N $7946 #DIMENSIONS
@ $7946 label=Sprite_Smoke_Bomb_4
  $7946,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7947,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7948,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7949,$10,$02 #SPRITE$7946(smoke-04)

N $7959 #DIMENSIONS
@ $7959 label=Sprite_Smoke_Bomb_5
  $7959,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $795A,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $795B,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $795C,$12,$02 #SPRITE$7959(smoke-05)
  $796E,$02,$01 Unused?

N $7970 #DIMENSIONS
@ $7970 label=Sprite_Smoke_Bomb_6
  $7970,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7971,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7972,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7973,$1B,$03 #SPRITE$7970(smoke-06)
  $798E,$03,$01 Unused?

b $7991 Sprite: Streamer/ Leech Laser
@ $7991 label=Sprite_Streamer_1
D $7991 The two images of the streamer, which is fired by Robbie (see #R$69E8).
N $7991 #DIMENSIONS
  $7991,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7992,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7993,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7994,$0E,b$02 #SPRITE$7991(streamer-01)

N $79A2 #DIMENSIONS
@ $79A2 label=Sprite_Streamer_2
  $79A2,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $79A3,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $79A4,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $79A5,$0E,b$02 #SPRITE$79A2(streamer-02)

b $79B3 Sprite: Scuttling Leech
@ $79B3 label=Sprite_Leech_1
D $79B3 The four images of the leech, two for each direction (see #R$764A).
N $79B3 #DIMENSIONS
  $79B3,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $79B4,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $79B5,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $79B6,$2D,$03 #SPRITE$79B3(leech-01)

N $79E3 #DIMENSIONS
@ $79E3 label=Sprite_Leech_2
  $79E3,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $79E4,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $79E5,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $79E6,$2D,$03 #SPRITE$79E3(leech-02)

N $7A13 #DIMENSIONS
@ $7A13 label=Sprite_Leech_3
  $7A13,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7A14,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7A15,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7A16,$2D,$03 #SPRITE$7A13(leech-03)

N $7A43 #DIMENSIONS
@ $7A43 label=Sprite_Leech_4
  $7A43,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7A44,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7A45,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7A46,$2D,$03 #SPRITE$7A43(leech-04)

b $7A73 Sprite: Interstellar Space Slug
@ $7A73 label=Sprite_Slug_1
D $7A73 The four images of the slug, two for each direction (see #R$764A).
N $7A73 #DIMENSIONS
  $7A73,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7A74,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7A75,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7A76,$24,$03 #SPRITE$7A73(slug-01)

N $7A9A #DIMENSIONS
@ $7A9A label=Sprite_Slug_2
  $7A9A,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7A9B,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7A9C,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7A9D,$20,$04 #SPRITE$7A9A(slug-02)

N $7ABD #DIMENSIONS
@ $7ABD label=Sprite_Slug_3
  $7ABD,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7ABE,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7ABF,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7AC0,$24,$03 #SPRITE$7ABD(slug-03)

N $7AE4 #DIMENSIONS
@ $7AE4 label=Sprite_Slug_4
  $7AE4,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7AE5,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7AE6,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7AE7,$20,$04 #SPRITE$7AE4(slug-04)

b $7B07 Sprite: Menacing Midges
@ $7B07 label=Sprite_Midges_1
D $7B07 The four images of the swarm of midges (see #R$764A).
N $7B07 #DIMENSIONS
  $7B07,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7B08,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7B09,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7B0A,$39,$03 #SPRITE$7B07(midges-01)

N $7B43 #DIMENSIONS
@ $7B43 label=Sprite_Midges_2
  $7B43,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7B44,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7B45,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7B46,$36,$03 #SPRITE$7B43(midges-02)

N $7B7C #DIMENSIONS
@ $7B7C label=Sprite_Midges_3
  $7B7C,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7B7D,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7B7E,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7B7F,$39,$03 #SPRITE$7B7C(midges-03)

N $7BB8 #DIMENSIONS
@ $7BB8 label=Sprite_Midges_4
  $7BB8,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7BB9,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7BBA,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7BBB,$36,$03 #SPRITE$7BB8(midges-04)

b $7BF1 Sprite: Insect Repellent/ Super Space Slug Spray
@ $7BF1 label=Sprite_Repellent_1
D $7BF1 The four images of the repellent spray, two for each direction (see
. #R$764A).
N $7BF1 #DIMENSIONS
  $7BF1,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7BF2,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7BF3,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7BF4,$0E,b$02 #SPRITE$7BF1(repellent-01)

N $7C02 #DIMENSIONS
@ $7C02 label=Sprite_Repellent_2
  $7C02,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7C03,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7C04,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7C05,$10,b$02 #SPRITE$7C02(repellent-02)

N $7C15 #DIMENSIONS
@ $7C15 label=Sprite_Repellent_3
  $7C15,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7C16,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7C17,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7C18,$0E,b$02 #SPRITE$7C15(repellent-03)

N $7C26 #DIMENSIONS
@ $7C26 label=Sprite_Repellent_4
  $7C26,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7C27,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7C28,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7C29,$10,b$02 #SPRITE$7C26(repellent-04)

b $7C39 Sprite: Flower (Others)
@ $7C39 label=Sprite_Flower_2
D $7C39 The sprites of the later stages of the flower, the last of which is the
. open flower (see #R$6787).
N $7C39 #DIMENSIONS
  $7C39,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7C3A,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7C3B,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7C3C,$36,$03 #SPRITE$7C39(flower-02)

N $7C72 #DIMENSIONS
@ $7C72 label=Sprite_Flower_3
  $7C72,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7C73,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7C74,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7C75,$5A,$03 #SPRITE$7C72(flower-03)

N $7CCF For attributes see #R$6748. #DIMENSIONS
@ $7CCF label=Sprite_Flower_4
  $7CCF,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7CD0,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7CD1,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7CD2,$1F8,$09 #UDGARRAY9,scale=4,step=9,flip=2((#PC)-(#PC + ({height} * {width}) - {width})-$01-({width} * $08))[$6775-$6786;$676C-$6774;$6763-$676B;$6751-$6762;$6748-$6750](flower-04)

b $7ECA Sprite: Explosions
@ $7ECA label=Sprite_Explosion_1
D $7ECA The three images of an explosion, which grows through each of them (see
. #R$6682).
N $7ECA #DIMENSIONS
  $7ECA,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7ECB,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7ECC,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7ECD,$30,$03 #SPRITE$7ECA(explosion-01*)

N $7EFD #DIMENSIONS
@ $7EFD label=Sprite_Explosion_2
  $7EFD,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7EFE,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7EFF,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7F00,$30,$03 #SPRITE$7EFD(explosion-02*)

N $7F30 #DIMENSIONS
@ $7F30 label=Sprite_Explosion_3
  $7F30,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7F31,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7F32,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7F33,$30,$03 #SPRITE$7F30(explosion-03*)

b $7F63 Sprite: Fertiliser
@ $7F63 label=Sprite_Fertiliser_1
D $7F63 The image of the fertiliser, which is the bonus item of type #N$0B
. (see #R$764A).
N $7F63 #DIMENSIONS
  $7F63,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7F64,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7F65,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7F66,$24,b$02 #SPRITE$7F63(fertiliser*)

b $7F8A Sprite: Fly Swat
@ $7F8A label=Sprite_Fly_Swat_1
D $7F8A The image of the fly swat, which is the bonus item of type #N$0C
. (see #R$764A).
N $7F8A #DIMENSIONS
  $7F8A,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7F8B,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7F8C,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7F8D,$20,b$02 #SPRITE$7F8A(swatter*)

b $7FAD Sprite: Watering Can
@ $7FAD label=Sprite_Watering_Can_1
D $7FAD The image of the watering can, which is the bonus item of type
. #N$0D (see #R$764A).
N $7FAD #DIMENSIONS
  $7FAD,$01 Horizontal offset in pixels (signed), added to the actor X position.
  $7FAE,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $7FAF,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $7FB0,$22,b$02 #SPRITE$7FAD(watering-can*)

t $7FD2 Messaging: Copyright
@ $7FD2 label=Message_Copyright_Reserved
D $7FD2 The text is not referenced by any code.
  $7FD2,$29,$29 "COPYRIGHT 1983 A.C.G. ALL RIGHTS RESERVED".

i $7FFB
