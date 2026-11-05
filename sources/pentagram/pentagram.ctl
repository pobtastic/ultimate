; Copyright Ashby Computers & Graphics Ltd 1986, Rare Ltd, 2026 ArcadeGeek LTD.
> $4000 @org=$4000
> $4000 @rom
> $4000 @expand=#DEF(#POKE()(anchor,text) #LINK(Pokes#$anchor)($text))
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))
b $4000 Loading Screen
@ $4000 label=Loading
D $4000 #UDGTABLE { =h Pentagram Loading Screen }
. { #SCR$02(loading) } UDGTABLE#
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

c $5E00 Game Entry Point
@ $5E00 label=GameEntry
D $5E00 The entry point of the game, called by the loader once the code has
. been loaded.
  $5E00,$01 Disable interrupts.
  $5E01,$03 Set the stack pointer to #R$5E00, so the stack grows downwards from
. the start of the game code.
  $5E04,$03 Jump to #R$AF87.

b $5E07 Room Sizes
@ $5E07 label=RoomSizeTable
D $5E07 The three sizes that a room can have, which are picked by the room data
. (see #R$C92C). Each is the distance from the centre of the room to its walls
. along x, then along y, and then the height of the floor.
B $5E07,$03,$03 Size #N$00: the walls are #N$40 from the centre along x and
. #N$40 along y, and the floor is at #N$80.
B $5E0A,$03,$03 Size #N$01: the walls are #N$20 from the centre along x and
. #N$40 along y, and the floor is at #N$80.
B $5E0D,$03,$03 Size #N$02: the walls are #N$40 from the centre along x and
. #N$20 along y, and the floor is at #N$80.

b $5E10 Room Data
D $5E10 The records of the rooms of the game, which #R$C92C reads when it builds
. a room. A record has the number of the room, a length byte, a byte for the ink
. colour and size of the room, and then the features of the room, which are
. pairs of a feature number and a parameter, ended by #N$FF. Any groups of
. templates come after that, each a byte and the cells that follow it. A room
. can end before the #N$FF, when it has no groups of templates.
@ $5E10 label=Room_00
B $5E10,$03,$03 Room #N$00, which has white ink and size #N$00, and is #N$1E
. bytes long.
B $5E13,$02,$02 Feature #N$18, the raised stone door and its frame in the wall
. at the high end of y, which leads to #R$692C.
B $5E15,$02,$02 Feature #N$1C, the slabs outside the raised door at the high end
. of y.
B $5E17,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $5E19,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $5E1B,$01,$01 The end of the features.
B $5E1C,$03,$03 Template #N$00 (stone slab), in 2 cells.
B $5E1F,$07,$07 Template #N$17 (cube), in 6 cells.
B $5E26,$07,$07 Template #N$03 (stalactites), in 6 cells.
B $5E2D,$02,$02 Template #N$11 (slider y), in 1 cell.
@ $5E2F label=Room_01
B $5E2F,$03,$03 Room #N$01, which has red ink and size #N$00, and is #N$12 bytes
. long.
B $5E32,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$5E6B.
B $5E34,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$5E42.
B $5E36,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $5E38,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $5E3A,$01,$01 The end of the features.
B $5E3B,$07,$07 Template #N$05 (spiked ring), in 6 cells.
@ $5E42 label=Room_02
B $5E42,$03,$03 Room #N$02, which has magenta ink and size #N$00, and is #N$28
. bytes long.
B $5E45,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$5E2F.
B $5E47,$02,$02 Feature #N$18, the raised stone door and its frame in the wall
. at the high end of y, which leads to #R$694F.
B $5E49,$02,$02 Feature #N$1C, the slabs outside the raised door at the high end
. of y.
B $5E4B,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $5E4D,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $5E4F,$01,$01 The end of the features.
B $5E50,$04,$04 Template #N$08 (pedestal), in 3 cells.
B $5E54,$08,$08 Template #N$08 (pedestal), in 7 cells.
B $5E5C,$02,$02 Template #N$10 (slider x), in 1 cell.
B $5E5E,$02,$02 Template #N$11 (slider y), in 1 cell.
B $5E60,$02,$02 Template #N$0C (lift), in 1 cell.
B $5E62,$03,$03 Template #N$00 (stone slab), in 2 cells.
B $5E65,$06,$06 Template #N$05 (spiked ring), in 5 cells.
@ $5E6B label=Room_03
B $5E6B,$03,$03 Room #N$03, which has green ink and size #N$00, and is #N$11
. bytes long.
B $5E6E,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$5EBA.
B $5E70,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$5E2F.
B $5E72,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $5E74,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $5E76,$01,$01 The end of the features.
B $5E77,$04,$04 Template #N$04 (falling pedestal), in 3 cells.
B $5E7B,$02,$02 Template #N$12 (wandering spark), in 1 cell.
@ $5E7D label=Room_04
B $5E7D,$03,$03 Room #N$04, which has cyan ink and size #N$00, and is #N$19
. bytes long.
B $5E80,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$5EEA.
B $5E82,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $5E84,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $5E86,$01,$01 The end of the features.
B $5E87,$08,$08 Template #N$05 (spiked ring), in 7 cells.
B $5E8F,$04,$04 Template #N$00 (stone slab), in 3 cells.
B $5E93,$02,$02 Template #N$18 (crumbling block), in 1 cell.
B $5E95,$02,$02 Template #N$10 (slider x), in 1 cell.
@ $5E97 label=Room_05
B $5E97,$03,$03 Room #N$05, which has yellow ink and size #N$00, and is #N$15
. bytes long.
B $5E9A,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$5EAD.
B $5E9C,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $5E9E,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $5EA0,$01,$01 The end of the features.
B $5EA1,$04,$04 Template #N$01 (round pedestal), in 3 cells.
B $5EA5,$05,$05 Template #N$05 (spiked ring), in 4 cells.
B $5EAA,$03,$03 Template #N$04 (falling pedestal), in 2 cells.
@ $5EAD label=Room_06
B $5EAD,$03,$03 Room #N$06, which has white ink and size #N$02, and is #N$0C
. bytes long.
B $5EB0,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$5EBA.
B $5EB2,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$5E97.
B $5EB4,$02,$02 Feature #N$11, a wall of roots that is inside the high end of y.
B $5EB6,$01,$01 The end of the features.
B $5EB7,$03,$03 Template #N$1E (harmful slider y), in 2 cells.
@ $5EBA label=Room_07
B $5EBA,$03,$03 Room #N$07, which has red ink and size #N$00, and is #N$1F bytes
. long.
B $5EBD,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$5EDA.
B $5EBF,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$5E6B.
B $5EC1,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$5EAD.
B $5EC3,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $5EC5,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $5EC7,$01,$01 The end of the features.
B $5EC8,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $5ED1,$09,$09 Template #N$03 (stalactites), in 8 cells.
@ $5EDA label=Room_08
B $5EDA,$03,$03 Room #N$08, which has green ink and size #N$00, and is #N$0F
. bytes long.
B $5EDD,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$5FEE.
B $5EDF,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$5EBA.
B $5EE1,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $5EE3,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $5EE5,$01,$01 The end of the features.
B $5EE6,$04,$04 Template #N$0E (falling stalactites), in 3 cells.
@ $5EEA label=Room_09
B $5EEA,$03,$03 Room #N$09, which has cyan ink and size #N$00, and is #N$18
. bytes long.
B $5EED,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6000.
B $5EEF,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$5F03.
B $5EF1,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$5E7D.
B $5EF3,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $5EF5,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $5EF7,$01,$01 The end of the features.
B $5EF8,$09,$09 Template #N$04 (falling pedestal), in 8 cells.
B $5F01,$02,$02 Template #N$12 (wandering spark), in 1 cell.
@ $5F03 label=Room_0A
B $5F03,$03,$03 Room #N$0A, which has cyan ink and size #N$02, and is #N$08
. bytes long.
B $5F06,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$5F0C.
B $5F08,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$5EEA.
B $5F0A,$02,$02 Feature #N$11, a wall of roots that is inside the high end of y.
@ $5F0C label=Room_0B
B $5F0C,$03,$03 Room #N$0B, which has yellow ink and size #N$02, and is #N$1D
. bytes long.
B $5F0F,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$5F2A.
B $5F11,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$5F03.
B $5F13,$02,$02 Feature #N$11, a wall of roots that is inside the high end of y.
B $5F15,$01,$01 The end of the features.
B $5F16,$09,$09 Template #N$01 (round pedestal), in 8 cells.
B $5F1F,$05,$05 Template #N$01 (round pedestal), in 4 cells.
B $5F24,$04,$04 Template #N$04 (falling pedestal), in 3 cells.
B $5F28,$02,$02 Template #N$0F (bobbing head), in 1 cell.
@ $5F2A label=Room_0C
B $5F2A,$03,$03 Room #N$0C, which has white ink and size #N$00, and is #N$22
. bytes long. The player may start in this room.
B $5F2D,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$601B.
B $5F2F,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$5F4D.
B $5F31,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$5F0C.
B $5F33,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $5F35,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $5F37,$01,$01 The end of the features.
B $5F38,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $5F41,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $5F4A,$03,$03 Template #N$03 (stalactites), in 2 cells.
@ $5F4D label=Room_0D
B $5F4D,$03,$03 Room #N$0D, which has red ink and size #N$02, and is #N$1C bytes
. long.
B $5F50,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$5F6A.
B $5F52,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$5F2A.
B $5F54,$02,$02 Feature #N$11, a wall of roots that is inside the high end of y.
B $5F56,$01,$01 The end of the features.
B $5F57,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $5F60,$07,$07 Template #N$04 (falling pedestal), in 6 cells.
B $5F67,$03,$03 Template #N$12 (wandering spark), in 3 cells, though the room
. ends after 2 of them.
@ $5F6A label=Room_0E
B $5F6A,$03,$03 Room #N$0E, which has magenta ink and size #N$00, and is #N$12
. bytes long.
B $5F6D,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$602A.
B $5F6F,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$5F4D.
B $5F71,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $5F73,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $5F75,$01,$01 The end of the features.
B $5F76,$05,$05 Template #N$0E (falling stalactites), in 4 cells.
B $5F7B,$02,$02 Template #N$12 (wandering spark), in 1 cell.
@ $5F7D label=Room_0F
B $5F7D,$03,$03 Room #N$0F, which has green ink and size #N$00, and is #N$20
. bytes long.
B $5F80,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$6035.
B $5F82,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $5F84,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $5F86,$01,$01 The end of the features.
B $5F87,$04,$04 Template #N$17 (cube), in 3 cells.
B $5F8B,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $5F94,$02,$02 Template #N$12 (wandering spark), in 1 cell.
B $5F96,$02,$02 Template #N$10 (slider x), in 1 cell.
B $5F98,$02,$02 Template #N$0A (sinking block), in 1 cell.
B $5F9A,$02,$02 Template #N$18 (crumbling block), in 1 cell.
B $5F9C,$02,$02 Template #N$03 (stalactites), in 1 cell.
@ $5F9E label=Room_10
B $5F9E,$03,$03 Room #N$10, which has cyan ink and size #N$00, and is #N$15
. bytes long.
B $5FA1,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$5FB4.
B $5FA3,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $5FA5,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $5FA7,$01,$01 The end of the features.
B $5FA8,$02,$02 Template #N$00 (stone slab), in 1 cell.
B $5FAA,$02,$02 Template #N$18 (crumbling block), in 1 cell.
B $5FAC,$06,$06 Template #N$03 (stalactites), in 5 cells.
B $5FB2,$02,$02 Template #N$07 (table), in 1 cell.
@ $5FB4 label=Room_11
B $5FB4,$03,$03 Room #N$11, which has yellow ink and size #N$00, and is #N$0A
. bytes long. It is where the object of the type #N$72 is at the start of the
. game.
B $5FB7,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$5F9E.
B $5FB9,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6053.
B $5FBB,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $5FBD,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
@ $5FBF label=Room_12
B $5FBF,$03,$03 Room #N$12, which has white ink and size #N$00, and is #N$1A
. bytes long.
B $5FC2,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$5FDA.
B $5FC4,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $5FC6,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $5FC8,$01,$01 The end of the features.
B $5FC9,$05,$05 Template #N$01 (round pedestal), in 4 cells.
B $5FCE,$03,$03 Template #N$04 (falling pedestal), in 2 cells.
B $5FD1,$09,$09 Template #N$03 (stalactites), in 8 cells.
@ $5FDA label=Room_13
B $5FDA,$03,$03 Room #N$13, which has red ink and size #N$00, and is #N$13 bytes
. long.
B $5FDD,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6078.
B $5FDF,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$5FEE.
B $5FE1,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$5FBF.
B $5FE3,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $5FE5,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $5FE7,$01,$01 The end of the features.
B $5FE8,$02,$02 Template #N$07 (table), in 1 cell.
B $5FEA,$02,$02 Template #N$0C (lift), in 1 cell.
B $5FEC,$02,$02 Template #N$0E (falling stalactites), in 1 cell.
@ $5FEE label=Room_14
B $5FEE,$03,$03 Room #N$14, which has magenta ink and size #N$00, and is #N$11
. bytes long.
B $5FF1,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6000.
B $5FF3,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$5EDA.
B $5FF5,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$5FDA.
B $5FF7,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $5FF9,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $5FFB,$01,$01 The end of the features.
B $5FFC,$02,$02 Template #N$05 (spiked ring), in 1 cell.
B $5FFE,$02,$02 Template #N$14 (flickering spark), in 1 cell.
@ $6000 label=Room_15
B $6000,$03,$03 Room #N$15, which has green ink and size #N$00, and is #N$1A
. bytes long.
B $6003,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$5EEA.
B $6005,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$5FEE.
B $6007,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $6009,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $600B,$01,$01 The end of the features.
B $600C,$09,$09 Template #N$05 (spiked ring), in 8 cells.
B $6015,$06,$06 Template #N$05 (spiked ring), in 5 cells.
@ $601B label=Room_16
B $601B,$03,$03 Room #N$16, which has cyan ink and size #N$00, and is #N$0E
. bytes long.
B $601E,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$5F2A.
B $6020,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$608B.
B $6022,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6024,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $6026,$01,$01 The end of the features.
B $6027,$03,$03 Template #N$04 (falling pedestal), in 2 cells.
@ $602A label=Room_17
B $602A,$03,$03 Room #N$17, which has yellow ink and size #N$00, and is #N$0A
. bytes long.
B $602D,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$5F6A.
B $602F,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$60AE.
B $6031,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6033,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
@ $6035 label=Room_18
B $6035,$03,$03 Room #N$18, which has white ink and size #N$00, and is #N$12
. bytes long.
B $6038,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$6048.
B $603A,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$5F7D.
B $603C,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $603E,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $6040,$01,$01 The end of the features.
B $6041,$05,$05 Template #N$06 (falling cube), in 4 cells.
B $6046,$02,$02 Template #N$12 (wandering spark), in 1 cell.
@ $6048 label=Room_19
B $6048,$03,$03 Room #N$19, which has red ink and size #N$00, and is #N$0A bytes
. long.
B $604B,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$60E6.
B $604D,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$6035.
B $604F,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $6051,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
@ $6053 label=Room_1A
B $6053,$03,$03 Room #N$1A, which has magenta ink and size #N$01, and is #N$0E
. bytes long.
B $6056,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$60F9.
B $6058,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$5FB4.
B $605A,$02,$02 Feature #N$10, a wall of roots that is inside the low end of x.
B $605C,$01,$01 The end of the features.
B $605D,$02,$02 Template #N$12 (wandering spark), in 1 cell.
B $605F,$03,$03 Template #N$01 (round pedestal), in 2 cells.
@ $6062 label=Room_1B
B $6062,$03,$03 Room #N$1B, which has green ink and size #N$00, and is #N$15
. bytes long.
B $6065,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6106.
B $6067,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6069,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $606B,$01,$01 The end of the features.
B $606C,$02,$02 Template #N$18 (crumbling block), in 1 cell.
B $606E,$03,$03 Template #N$00 (stone slab), in 2 cells.
B $6071,$02,$02 Template #N$10 (slider x), in 1 cell.
B $6073,$03,$03 Template #N$05 (spiked ring), in 2 cells.
B $6076,$02,$02 Template #N$0F (bobbing head), in 1 cell.
@ $6078 label=Room_1C
B $6078,$03,$03 Room #N$1C, which has cyan ink and size #N$01, and is #N$12
. bytes long.
B $607B,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$615A.
B $607D,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$5FDA.
B $607F,$02,$02 Feature #N$10, a wall of roots that is inside the low end of x.
B $6081,$01,$01 The end of the features.
B $6082,$09,$09 Template #N$05 (spiked ring), in 8 cells.
@ $608B label=Room_1D
B $608B,$03,$03 Room #N$1D, which has yellow ink and size #N$00, and is #N$19
. bytes long.
B $608E,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$601B.
B $6090,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6092,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $6094,$01,$01 The end of the features.
B $6095,$02,$02 Template #N$13 (well), in 1 cell.
B $6097,$08,$08 Template #N$05 (spiked ring), in 7 cells.
B $609F,$02,$02 Template #N$04 (falling pedestal), in 1 cell.
B $60A1,$02,$02 Template #N$1D (harmful slider x), in 1 cell.
B $60A3,$02,$02 Template #N$1E (harmful slider y), in 1 cell.
@ $60A5 label=Room_1E
B $60A5,$03,$03 Room #N$1E, which has white ink and size #N$00, and is #N$08
. bytes long.
B $60A8,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$60AE.
B $60AA,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $60AC,$02,$02 Feature #N$09, a wall of roots along the high end of y.
@ $60AE label=Room_1F
B $60AE,$03,$03 Room #N$1F, which has red ink and size #N$00, and is #N$1F bytes
. long.
B $60B1,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$60CE.
B $60B3,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$602A.
B $60B5,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$60A5.
B $60B7,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $60B9,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $60BB,$01,$01 The end of the features.
B $60BC,$09,$09 Template #N$00 (stone slab), in 8 cells.
B $60C5,$09,$09 Template #N$03 (stalactites), in 8 cells.
@ $60CE label=Room_20
B $60CE,$03,$03 Room #N$20, which has magenta ink and size #N$00, and is #N$0C
. bytes long.
B $60D1,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$61D0.
B $60D3,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$60DB.
B $60D5,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$60AE.
B $60D7,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $60D9,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
@ $60DB label=Room_21
B $60DB,$03,$03 Room #N$21, which has green ink and size #N$00, and is #N$0A
. bytes long. It is where the object of the type #N$73 is at the start of the
. game.
B $60DE,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$61EF.
B $60E0,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$60CE.
B $60E2,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $60E4,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
@ $60E6 label=Room_22
B $60E6,$03,$03 Room #N$22, which has cyan ink and size #N$00, and is #N$12
. bytes long.
B $60E9,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6205.
B $60EB,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$60F9.
B $60ED,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6048.
B $60EF,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $60F1,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $60F3,$01,$01 The end of the features.
B $60F4,$03,$03 Template #N$03 (stalactites), in 2 cells.
B $60F7,$02,$02 Template #N$1D (harmful slider x), in 1 cell.
@ $60F9 label=Room_23
B $60F9,$03,$03 Room #N$23, which has yellow ink and size #N$00, and is #N$0C
. bytes long.
B $60FC,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6106.
B $60FE,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6053.
B $6100,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$60E6.
B $6102,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $6104,$02,$02 Feature #N$09, a wall of roots along the high end of y.
@ $6106 label=Room_24
B $6106,$03,$03 Room #N$24, which has white ink and size #N$00, and is #N$0E
. bytes long.
B $6109,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6062.
B $610B,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$60F9.
B $610D,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $610F,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $6111,$01,$01 The end of the features.
B $6112,$03,$03 Template #N$05 (spiked ring), in 2 cells.
@ $6115 label=Room_25
B $6115,$03,$03 Room #N$25, which has red ink and size #N$00, and is #N$1C bytes
. long.
B $6118,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$625A.
B $611A,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $611C,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $611E,$01,$01 The end of the features.
B $611F,$04,$04 Template #N$00 (stone slab), in 3 cells.
B $6123,$04,$04 Template #N$19 (conveyor block plus x), in 3 cells.
B $6127,$04,$04 Template #N$1B (conveyor block plus y), in 3 cells.
B $612B,$07,$07 Template #N$03 (stalactites), in 6 cells.
@ $6132 label=Room_26
B $6132,$03,$03 Room #N$26, which has magenta ink and size #N$00, and is #N$1C
. bytes long.
B $6135,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$627E.
B $6137,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$614F.
B $6139,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $613B,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $613D,$01,$01 The end of the features.
B $613E,$06,$06 Template #N$00 (stone slab), in 5 cells.
B $6144,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $614D,$02,$02 Template #N$10 (slider x), in 1 cell.
@ $614F label=Room_27
B $614F,$03,$03 Room #N$27, which has green ink and size #N$00, and is #N$0A
. bytes long.
B $6152,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$629C.
B $6154,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$6132.
B $6156,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $6158,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
@ $615A label=Room_28
B $615A,$03,$03 Room #N$28, which has cyan ink and size #N$01, and is #N$08
. bytes long.
B $615D,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$62BC.
B $615F,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6078.
B $6161,$02,$02 Feature #N$10, a wall of roots that is inside the low end of x.
@ $6163 label=Room_29
B $6163,$03,$03 Room #N$29, which has magenta ink and size #N$00, and is #N$1E
. bytes long.
B $6166,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$62D4.
B $6168,$02,$02 Feature #N$1B, the raised stone door and its frame in the wall
. at the low end of x, which leads to #R$68AC.
B $616A,$02,$02 Feature #N$1F, the slabs outside the raised door at the low end
. of x.
B $616C,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $616E,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $6170,$01,$01 The end of the features.
B $6171,$08,$08 Template #N$00 (stone slab), in 7 cells.
B $6179,$02,$02 Template #N$07 (table), in 1 cell.
B $617B,$02,$02 Template #N$0E (falling stalactites), in 1 cell.
B $617D,$05,$05 Template #N$03 (stalactites), in 4 cells.
@ $6182 label=Room_2A
B $6182,$03,$03 Room #N$2A, which has white ink and size #N$00, and is #N$19
. bytes long.
B $6185,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$62E1.
B $6187,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $6189,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $618B,$01,$01 The end of the features.
B $618C,$09,$09 Template #N$00 (stone slab), in 8 cells.
B $6195,$02,$02 Template #N$00 (stone slab), in 1 cell.
B $6197,$03,$03 Template #N$0B (falling block), in 2 cells.
B $619A,$02,$02 Template #N$0F (bobbing head), in 1 cell.
@ $619C label=Room_2B
B $619C,$03,$03 Room #N$2B, which has red ink and size #N$00, and is #N$0A bytes
. long.
B $619F,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$62EE.
B $61A1,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$61A7.
B $61A3,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $61A5,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
@ $61A7 label=Room_2C
B $61A7,$03,$03 Room #N$2C, which has magenta ink and size #N$00, and is #N$1D
. bytes long.
B $61AA,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$6312.
B $61AC,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$619C.
B $61AE,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $61B0,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $61B2,$01,$01 The end of the features.
B $61B3,$09,$09 Template #N$01 (round pedestal), in 8 cells.
B $61BC,$09,$09 Template #N$03 (stalactites), in 8 cells.
@ $61C5 label=Room_2D
B $61C5,$03,$03 Room #N$2D, which has green ink and size #N$00, and is #N$0A
. bytes long.
B $61C8,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$631D.
B $61CA,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$61D0.
B $61CC,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $61CE,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
@ $61D0 label=Room_2E
B $61D0,$03,$03 Room #N$2E, which has cyan ink and size #N$00, and is #N$1E
. bytes long.
B $61D3,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$60CE.
B $61D5,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$61C5.
B $61D7,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $61D9,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $61DB,$01,$01 The end of the features.
B $61DC,$08,$08 Template #N$01 (round pedestal), in 7 cells.
B $61E4,$02,$02 Template #N$10 (slider x), in 1 cell.
B $61E6,$02,$02 Template #N$11 (slider y), in 1 cell.
B $61E8,$07,$07 Template #N$05 (spiked ring), in 6 cells.
@ $61EF label=Room_2F
B $61EF,$03,$03 Room #N$2F, which has yellow ink and size #N$01, and is #N$15
. bytes long.
B $61F2,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6330.
B $61F4,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$60DB.
B $61F6,$02,$02 Feature #N$10, a wall of roots that is inside the low end of x.
B $61F8,$01,$01 The end of the features.
B $61F9,$05,$05 Template #N$03 (stalactites), in 4 cells.
B $61FE,$05,$05 Template #N$18 (crumbling block), in 4 cells.
B $6203,$02,$02 Template #N$1D (harmful slider x), in 1 cell.
@ $6205 label=Room_30
B $6205,$03,$03 Room #N$30, which has white ink and size #N$00, and is #N$0A
. bytes long.
B $6208,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6210.
B $620A,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$60E6.
B $620C,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $620E,$02,$02 Feature #N$09, a wall of roots along the high end of y.
@ $6210 label=Room_31
B $6210,$03,$03 Room #N$31, which has red ink and size #N$02, and is #N$0C bytes
. long.
B $6213,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$621D.
B $6215,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$6205.
B $6217,$02,$02 Feature #N$11, a wall of roots that is inside the high end of y.
B $6219,$01,$01 The end of the features.
B $621A,$03,$03 Template #N$1E (harmful slider y), in 2 cells.
@ $621D label=Room_32
B $621D,$03,$03 Room #N$32, which has magenta ink and size #N$02, and is #N$08
. bytes long.
B $6220,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6226.
B $6222,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$6210.
B $6224,$02,$02 Feature #N$11, a wall of roots that is inside the high end of y.
@ $6226 label=Room_33
B $6226,$03,$03 Room #N$33, which has green ink and size #N$00, and is #N$22
. bytes long. The player may start in this room.
B $6229,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$634B.
B $622B,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6249.
B $622D,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$621D.
B $622F,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $6231,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $6233,$01,$01 The end of the features.
B $6234,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $623D,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $6246,$03,$03 Template #N$03 (stalactites), in 2 cells.
@ $6249 label=Room_34
B $6249,$03,$03 Room #N$34, which has cyan ink and size #N$02, and is #N$10
. bytes long.
B $624C,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$625A.
B $624E,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$6226.
B $6250,$02,$02 Feature #N$11, a wall of roots that is inside the high end of y.
B $6252,$01,$01 The end of the features.
B $6253,$05,$05 Template #N$05 (spiked ring), in 4 cells.
B $6258,$02,$02 Template #N$14 (flickering spark), in 1 cell.
@ $625A label=Room_35
B $625A,$03,$03 Room #N$35, which has yellow ink and size #N$00, and is #N$23
. bytes long.
B $625D,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$635A.
B $625F,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$627E.
B $6261,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$6115.
B $6263,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$6249.
B $6265,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $6267,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $6269,$01,$01 The end of the features.
B $626A,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $6273,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $627C,$02,$02 Template #N$12 (wandering spark), in 1 cell.
@ $627E label=Room_36
B $627E,$03,$03 Room #N$36, which has white ink and size #N$00, and is #N$1D
. bytes long.
B $6281,$02,$02 Feature #N$18, the raised stone door and its frame in the wall
. at the high end of y, which leads to #R$6372.
B $6283,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$6132.
B $6285,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$625A.
B $6287,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $6289,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $628B,$02,$02 Feature #N$1C, the slabs outside the raised door at the high end
. of y.
B $628D,$01,$01 The end of the features.
B $628E,$03,$03 Template #N$00 (stone slab), in 2 cells.
B $6291,$02,$02 Template #N$0C (lift), in 1 cell.
B $6293,$03,$03 Template #N$18 (crumbling block), in 2 cells.
B $6296,$06,$06 Template #N$03 (stalactites), in 5 cells.
@ $629C label=Room_37
B $629C,$03,$03 Room #N$37, which has red ink and size #N$00, and is #N$1F bytes
. long.
B $629F,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$614F.
B $62A1,$02,$02 Feature #N$19, the raised stone door and its frame in the wall
. at the high end of x, which leads to #R$68E7.
B $62A3,$02,$02 Feature #N$1D, the slabs outside the raised door at the high end
. of x.
B $62A5,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $62A7,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $62A9,$01,$01 The end of the features.
B $62AA,$05,$05 Template #N$00 (stone slab), in 4 cells.
B $62AF,$07,$07 Template #N$03 (stalactites), in 6 cells.
B $62B6,$02,$02 Template #N$18 (crumbling block), in 1 cell.
B $62B8,$02,$02 Template #N$0B (falling block), in 1 cell.
B $62BA,$02,$02 Template #N$0F (bobbing head), in 1 cell.
@ $62BC label=Room_38
B $62BC,$03,$03 Room #N$38, which has yellow ink and size #N$00, and is #N$17
. bytes long.
B $62BF,$02,$02 Feature #N$19, the raised stone door and its frame in the wall
. at the high end of x, which leads to #R$62D4.
B $62C1,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$615A.
B $62C3,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $62C5,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $62C7,$02,$02 Feature #N$1D, the slabs outside the raised door at the high end
. of x.
B $62C9,$01,$01 The end of the features.
B $62CA,$04,$04 Template #N$00 (stone slab), in 3 cells.
B $62CE,$02,$02 Template #N$10 (slider x), in 1 cell.
B $62D0,$02,$02 Template #N$0B (falling block), in 1 cell.
B $62D2,$02,$02 Template #N$03 (stalactites), in 1 cell.
@ $62D4 label=Room_39
B $62D4,$03,$03 Room #N$39, which has green ink and size #N$00, and is #N$0C
. bytes long.
B $62D7,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$62E1.
B $62D9,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$6163.
B $62DB,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$62BC.
B $62DD,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $62DF,$02,$02 Feature #N$0D, a stone wall along the high end of y.
@ $62E1 label=Room_3A
B $62E1,$03,$03 Room #N$3A, which has cyan ink and size #N$00, and is #N$0C
. bytes long.
B $62E4,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$62EE.
B $62E6,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$6182.
B $62E8,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$62D4.
B $62EA,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $62EC,$02,$02 Feature #N$0D, a stone wall along the high end of y.
@ $62EE label=Room_3B
B $62EE,$03,$03 Room #N$3B, which has yellow ink and size #N$00, and is #N$23
. bytes long.
B $62F1,$02,$02 Feature #N$18, the raised stone door and its frame in the wall
. at the high end of y, which leads to #R$637B.
B $62F3,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$6312.
B $62F5,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$619C.
B $62F7,$02,$02 Feature #N$1B, the raised stone door and its frame in the wall
. at the low end of x, which leads to #R$62E1.
B $62F9,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $62FB,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $62FD,$02,$02 Feature #N$1F, the slabs outside the raised door at the low end
. of x.
B $62FF,$02,$02 Feature #N$1C, the slabs outside the raised door at the high end
. of y.
B $6301,$01,$01 The end of the features.
B $6302,$07,$07 Template #N$00 (stone slab), in 6 cells.
B $6309,$02,$02 Template #N$10 (slider x), in 1 cell.
B $630B,$02,$02 Template #N$11 (slider y), in 1 cell.
B $630D,$05,$05 Template #N$03 (stalactites), in 4 cells.
@ $6312 label=Room_3C
B $6312,$03,$03 Room #N$3C, which has white ink and size #N$00, and is #N$0A
. bytes long.
B $6315,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$61A7.
B $6317,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$62EE.
B $6319,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $631B,$02,$02 Feature #N$0D, a stone wall along the high end of y.
@ $631D label=Room_3D
B $631D,$03,$03 Room #N$3D, which has red ink and size #N$01, and is #N$12 bytes
. long.
B $6320,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6384.
B $6322,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$61C5.
B $6324,$02,$02 Feature #N$10, a wall of roots that is inside the low end of x.
B $6326,$01,$01 The end of the features.
B $6327,$09,$09 Template #N$05 (spiked ring), in 8 cells.
@ $6330 label=Room_3E
B $6330,$03,$03 Room #N$3E, which has magenta ink and size #N$00, and is #N$1A
. bytes long.
B $6333,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$61EF.
B $6335,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6337,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $6339,$01,$01 The end of the features.
B $633A,$07,$07 Template #N$05 (spiked ring), in 6 cells.
B $6341,$04,$04 Template #N$00 (stone slab), in 3 cells.
B $6345,$03,$03 Template #N$0F (bobbing head), in 2 cells.
B $6348,$03,$03 Template #N$18 (crumbling block), in 2 cells.
@ $634B label=Room_3F
B $634B,$03,$03 Room #N$3F, which has green ink and size #N$01, and is #N$0E
. bytes long.
B $634E,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6398.
B $6350,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6226.
B $6352,$02,$02 Feature #N$10, a wall of roots that is inside the low end of x.
B $6354,$01,$01 The end of the features.
B $6355,$05,$05 Template #N$15 (floor trap 2), in 4 cells.
@ $635A label=Room_40
B $635A,$03,$03 Room #N$40, which has cyan ink and size #N$01, and is #N$17
. bytes long.
B $635D,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$63D8.
B $635F,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$625A.
B $6361,$02,$02 Feature #N$10, a wall of roots that is inside the low end of x.
B $6363,$01,$01 The end of the features.
B $6364,$09,$09 Template #N$05 (spiked ring), in 8 cells.
B $636D,$05,$05 Template #N$18 (crumbling block), in 4 cells.
@ $6372 label=Room_41
B $6372,$03,$03 Room #N$41, which has yellow ink and size #N$01, and is #N$08
. bytes long.
B $6375,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$63F8.
B $6377,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$627E.
B $6379,$02,$02 Feature #N$14, a stone wall that is inside the low end of x.
@ $637B label=Room_42
B $637B,$03,$03 Room #N$42, which has red ink and size #N$01, and is #N$08 bytes
. long.
B $637E,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$640B.
B $6380,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$62EE.
B $6382,$02,$02 Feature #N$14, a stone wall that is inside the low end of x.
@ $6384 label=Room_43
B $6384,$03,$03 Room #N$43, which has magenta ink and size #N$01, and is #N$13
. bytes long.
B $6387,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$644B.
B $6389,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$631D.
B $638B,$02,$02 Feature #N$10, a wall of roots that is inside the low end of x.
B $638D,$01,$01 The end of the features.
B $638E,$05,$05 Template #N$1B (conveyor block plus y), in 4 cells.
B $6393,$05,$05 Template #N$03 (stalactites), in 4 cells.
@ $6398 label=Room_45
B $6398,$03,$03 Room #N$45, which has cyan ink and size #N$00, and is #N$21
. bytes long.
B $639B,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$634B.
B $639D,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $639F,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $63A1,$01,$01 The end of the features.
B $63A2,$03,$03 Template #N$0B (falling block), in 2 cells.
B $63A5,$02,$02 Template #N$10 (slider x), in 1 cell.
B $63A7,$02,$02 Template #N$18 (crumbling block), in 1 cell.
B $63A9,$02,$02 Template #N$05 (spiked ring), in 1 cell.
B $63AB,$02,$02 Template #N$12 (wandering spark), in 1 cell.
B $63AD,$07,$07 Template #N$00 (stone slab), in 6 cells.
B $63B4,$06,$06 Template #N$00 (stone slab), in 5 cells.
@ $63BA label=Room_46
B $63BA,$03,$03 Room #N$46, which has yellow ink and size #N$00, and is #N$1D
. bytes long.
B $63BD,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$63D8.
B $63BF,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $63C1,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $63C3,$01,$01 The end of the features.
B $63C4,$09,$09 Template #N$01 (round pedestal), in 8 cells.
B $63CD,$09,$09 Template #N$05 (spiked ring), in 8 cells.
B $63D6,$02,$02 Template #N$04 (falling pedestal), in 1 cell.
@ $63D8 label=Room_47
B $63D8,$03,$03 Room #N$47, which has white ink and size #N$00, and is #N$1F
. bytes long.
B $63DB,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$63F8.
B $63DD,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$635A.
B $63DF,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$63BA.
B $63E1,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $63E3,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $63E5,$01,$01 The end of the features.
B $63E6,$02,$02 Template #N$13 (well), in 1 cell.
B $63E8,$03,$03 Template #N$04 (falling pedestal), in 2 cells.
B $63EB,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $63F4,$04,$04 Template #N$03 (stalactites), in 3 cells.
@ $63F8 label=Room_48
B $63F8,$03,$03 Room #N$48, which has red ink and size #N$00, and is #N$12 bytes
. long.
B $63FB,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$648E.
B $63FD,$02,$02 Feature #N$1A, the raised stone door and its frame in the wall
. at the low end of y, which leads to #R$6372.
B $63FF,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$63D8.
B $6401,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $6403,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $6405,$02,$02 Feature #N$1E, the slabs outside the raised door at the low end
. of y.
B $6407,$01,$01 The end of the features.
B $6408,$03,$03 Template #N$00 (stone slab), in 2 cells.
@ $640B label=Room_49
B $640B,$03,$03 Room #N$49, which has magenta ink and size #N$00, and is #N$19
. bytes long.
B $640E,$02,$02 Feature #N$18, the raised stone door and its frame in the wall
. at the high end of y, which leads to #R$64CA.
B $6410,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$6425.
B $6412,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$637B.
B $6414,$02,$02 Feature #N$1C, the slabs outside the raised door at the high end
. of y.
B $6416,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $6418,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $641A,$01,$01 The end of the features.
B $641B,$02,$02 Template #N$07 (table), in 1 cell.
B $641D,$03,$03 Template #N$01 (round pedestal), in 2 cells.
B $6420,$02,$02 Template #N$04 (falling pedestal), in 1 cell.
B $6422,$03,$03 Template #N$00 (stone slab), in 2 cells.
@ $6425 label=Room_4A
B $6425,$03,$03 Room #N$4A, which has green ink and size #N$00, and is #N$1A
. bytes long.
B $6428,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6440.
B $642A,$02,$02 Feature #N$1B, the raised stone door and its frame in the wall
. at the low end of x, which leads to #R$640B.
B $642C,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $642E,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $6430,$02,$02 Feature #N$1F, the slabs outside the raised door at the low end
. of x.
B $6432,$01,$01 The end of the features.
B $6433,$03,$03 Template #N$01 (round pedestal), in 2 cells.
B $6436,$03,$03 Template #N$04 (falling pedestal), in 2 cells.
B $6439,$03,$03 Template #N$00 (stone slab), in 2 cells.
B $643C,$04,$04 Template #N$05 (spiked ring), in 3 cells.
@ $6440 label=Room_4B
B $6440,$03,$03 Room #N$4B, which has cyan ink and size #N$00, and is #N$0A
. bytes long.
B $6443,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$64DF.
B $6445,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$6425.
B $6447,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $6449,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
@ $644B label=Room_4C
B $644B,$03,$03 Room #N$4C, which has yellow ink and size #N$00, and is #N$16
. bytes long.
B $644E,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$650A.
B $6450,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6462.
B $6452,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6384.
B $6454,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6456,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $6458,$01,$01 The end of the features.
B $6459,$07,$07 Template #N$0E (falling stalactites), in 6 cells.
B $6460,$02,$02 Template #N$14 (flickering spark), in 1 cell.
@ $6462 label=Room_4D
B $6462,$03,$03 Room #N$4D, which has white ink and size #N$00, and is #N$12
. bytes long.
B $6465,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$652D.
B $6467,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6475.
B $6469,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$644B.
B $646B,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $646D,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $646F,$01,$01 The end of the features.
B $6470,$05,$05 Template #N$15 (floor trap 2), in 4 cells.
@ $6475 label=Room_4E
B $6475,$03,$03 Room #N$4E, which has red ink and size #N$00, and is #N$18 bytes
. long.
B $6478,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$6462.
B $647A,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $647C,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $647E,$01,$01 The end of the features.
B $647F,$07,$07 Template #N$15 (floor trap 2), in 6 cells.
B $6486,$08,$08 Template #N$0D (floor trap 1), in 7 cells.
@ $648E label=Room_50
B $648E,$03,$03 Room #N$50, which has green ink and size #N$00, and is #N$27
. bytes long.
B $6491,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$6595.
B $6493,$02,$02 Feature #N$19, the raised stone door and its frame in the wall
. at the high end of x, which leads to #R$64B6.
B $6495,$02,$02 Feature #N$1A, the raised stone door and its frame in the wall
. at the low end of y, which leads to #R$63F8.
B $6497,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $6499,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $649B,$02,$02 Feature #N$1D, the slabs outside the raised door at the high end
. of x.
B $649D,$02,$02 Feature #N$1E, the slabs outside the raised door at the low end
. of y.
B $649F,$01,$01 The end of the features.
B $64A0,$09,$09 Template #N$00 (stone slab), in 8 cells.
B $64A9,$06,$06 Template #N$18 (crumbling block), in 5 cells.
B $64AF,$02,$02 Template #N$0A (sinking block), in 1 cell.
B $64B1,$05,$05 Template #N$03 (stalactites), in 4 cells.
@ $64B6 label=Room_51
B $64B6,$03,$03 Room #N$51, which has cyan ink and size #N$00, and is #N$0A
. bytes long.
B $64B9,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$65B7.
B $64BB,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$648E.
B $64BD,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $64BF,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
@ $64C1 label=Room_52
B $64C1,$03,$03 Room #N$52, which has yellow ink and size #N$00, and is #N$08
. bytes long. The pentagram is in this room.
B $64C4,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$65FB.
B $64C6,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $64C8,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
@ $64CA label=Room_53
B $64CA,$03,$03 Room #N$53, which has white ink and size #N$01, and is #N$14
. bytes long.
B $64CD,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$660A.
B $64CF,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$640B.
B $64D1,$02,$02 Feature #N$14, a stone wall that is inside the low end of x.
B $64D3,$01,$01 The end of the features.
B $64D4,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $64DD,$02,$02 Template #N$1D (harmful slider x), in 1 cell.
@ $64DF label=Room_54
B $64DF,$03,$03 Room #N$54, which has red ink and size #N$00, and is #N$1F bytes
. long.
B $64E2,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$661D.
B $64E4,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$64FF.
B $64E6,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6440.
B $64E8,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $64EA,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $64EC,$01,$01 The end of the features.
B $64ED,$09,$09 Template #N$05 (spiked ring), in 8 cells.
B $64F6,$09,$09 Template #N$05 (spiked ring), in 8 cells.
@ $64FF label=Room_55
B $64FF,$03,$03 Room #N$55, which has magenta ink and size #N$00, and is #N$0A
. bytes long.
B $6502,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$650A.
B $6504,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$64DF.
B $6506,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $6508,$02,$02 Feature #N$09, a wall of roots along the high end of y.
@ $650A label=Room_56
B $650A,$03,$03 Room #N$56, which has green ink and size #N$00, and is #N$22
. bytes long.
B $650D,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$644B.
B $650F,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$64FF.
B $6511,$02,$02 Feature #N$19, the raised stone door and its frame in the wall
. at the high end of x, which leads to #R$68FF.
B $6513,$02,$02 Feature #N$1D, the slabs outside the raised door at the high end
. of x.
B $6515,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $6517,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $6519,$01,$01 The end of the features.
B $651A,$03,$03 Template #N$00 (stone slab), in 2 cells.
B $651D,$06,$06 Template #N$05 (spiked ring), in 5 cells.
B $6523,$02,$02 Template #N$0A (sinking block), in 1 cell.
B $6525,$03,$03 Template #N$08 (pedestal), in 2 cells.
B $6528,$05,$05 Template #N$08 (pedestal), in 4 cells.
@ $652D label=Room_57
B $652D,$03,$03 Room #N$57, which has cyan ink and size #N$00, and is #N$26
. bytes long.
B $6530,$02,$02 Feature #N$19, the raised stone door and its frame in the wall
. at the high end of x, which leads to #R$6554.
B $6532,$02,$02 Feature #N$1A, the raised stone door and its frame in the wall
. at the low end of y, which leads to #R$6462.
B $6534,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $6536,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $6538,$02,$02 Feature #N$1D, the slabs outside the raised door at the high end
. of x.
B $653A,$02,$02 Feature #N$1E, the slabs outside the raised door at the low end
. of y.
B $653C,$01,$01 The end of the features.
B $653D,$09,$09 Template #N$00 (stone slab), in 8 cells.
B $6546,$06,$06 Template #N$18 (crumbling block), in 5 cells.
B $654C,$06,$06 Template #N$03 (stalactites), in 5 cells.
B $6552,$02,$02 Template #N$0C (lift), in 1 cell.
@ $6554 label=Room_58
B $6554,$03,$03 Room #N$58, which has yellow ink and size #N$00, and is #N$0E
. bytes long.
B $6557,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$6677.
B $6559,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$652D.
B $655B,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $655D,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $655F,$01,$01 The end of the features.
B $6560,$03,$03 Template #N$0F (bobbing head), in 2 cells.
@ $6563 label=Room_5B
B $6563,$03,$03 Room #N$5B, which has magenta ink and size #N$00, and is #N$0E
. bytes long.
B $6566,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$668A.
B $6568,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6572.
B $656A,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $656C,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $656E,$01,$01 The end of the features.
B $656F,$03,$03 Template #N$09 (block), in 2 cells.
@ $6572 label=Room_5C
B $6572,$03,$03 Room #N$5C, which has green ink and size #N$00, and is #N$22
. bytes long. The player may start in this room.
B $6575,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$669A.
B $6577,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$6595.
B $6579,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$6563.
B $657B,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $657D,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $657F,$01,$01 The end of the features.
B $6580,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $6589,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $6592,$03,$03 Template #N$03 (stalactites), in 2 cells.
@ $6595 label=Room_5D
B $6595,$03,$03 Room #N$5D, which has cyan ink and size #N$00, and is #N$21
. bytes long.
B $6598,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$648E.
B $659A,$02,$02 Feature #N$1B, the raised stone door and its frame in the wall
. at the low end of x, which leads to #R$6572.
B $659C,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $659E,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $65A0,$02,$02 Feature #N$1F, the slabs outside the raised door at the low end
. of x.
B $65A2,$01,$01 The end of the features.
B $65A3,$09,$09 Template #N$18 (crumbling block), in 8 cells.
B $65AC,$02,$02 Template #N$10 (slider x), in 1 cell.
B $65AE,$09,$09 Template #N$03 (stalactites), in 8 cells.
@ $65B7 label=Room_5E
B $65B7,$03,$03 Room #N$5E, which has yellow ink and size #N$00, and is #N$1F
. bytes long.
B $65BA,$02,$02 Feature #N$19, the raised stone door and its frame in the wall
. at the high end of x, which leads to #R$65D7.
B $65BC,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$64B6.
B $65BE,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $65C0,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $65C2,$02,$02 Feature #N$1D, the slabs outside the raised door at the high end
. of x.
B $65C4,$01,$01 The end of the features.
B $65C5,$03,$03 Template #N$00 (stone slab), in 2 cells.
B $65C8,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $65D1,$02,$02 Template #N$0C (lift), in 1 cell.
B $65D3,$02,$02 Template #N$11 (slider y), in 1 cell.
B $65D5,$02,$02 Template #N$18 (crumbling block), in 1 cell.
@ $65D7 label=Room_5F
B $65D7,$03,$03 Room #N$5F, which has white ink and size #N$00, and is #N$0A
. bytes long.
B $65DA,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$65E2.
B $65DC,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$65B7.
B $65DE,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $65E0,$02,$02 Feature #N$0D, a stone wall along the high end of y.
@ $65E2 label=Room_60
B $65E2,$03,$03 Room #N$60, which has red ink and size #N$00, and is #N$18 bytes
. long.
B $65E5,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$66BC.
B $65E7,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$65FB.
B $65E9,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$65D7.
B $65EB,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $65ED,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $65EF,$01,$01 The end of the features.
B $65F0,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $65F9,$02,$02 Template #N$14 (flickering spark), in 1 cell.
@ $65FB label=Room_61
B $65FB,$03,$03 Room #N$61, which has magenta ink and size #N$00, and is #N$0E
. bytes long.
B $65FE,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$66D8.
B $6600,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$660A.
B $6602,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$64C1.
B $6604,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$65E2.
B $6606,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $6608,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
@ $660A label=Room_62
B $660A,$03,$03 Room #N$62, which has green ink and size #N$00, and is #N$12
. bytes long.
B $660D,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$64CA.
B $660F,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$65FB.
B $6611,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $6613,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $6615,$01,$01 The end of the features.
B $6616,$05,$05 Template #N$06 (falling cube), in 4 cells.
B $661B,$02,$02 Template #N$12 (wandering spark), in 1 cell.
@ $661D label=Room_63
B $661D,$03,$03 Room #N$63, which has cyan ink and size #N$00, and is #N$14
. bytes long.
B $6620,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6632.
B $6622,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$64DF.
B $6624,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6626,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $6628,$01,$01 The end of the features.
B $6629,$03,$03 Template #N$01 (round pedestal), in 2 cells.
B $662C,$02,$02 Template #N$1D (harmful slider x), in 1 cell.
B $662E,$04,$04 Template #N$15 (floor trap 2), in 3 cells.
@ $6632 label=Room_64
B $6632,$03,$03 Room #N$64, which has yellow ink and size #N$00, and is #N$22
. bytes long. The player may start in this room.
B $6635,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$66F8.
B $6637,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6655.
B $6639,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$661D.
B $663B,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $663D,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $663F,$01,$01 The end of the features.
B $6640,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $6649,$09,$09 Template #N$03 (stalactites), in 8 cells.
B $6652,$03,$03 Template #N$03 (stalactites), in 2 cells.
@ $6655 label=Room_65
B $6655,$03,$03 Room #N$65, which has white ink and size #N$02, and is #N$14
. bytes long.
B $6658,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$666A.
B $665A,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$6632.
B $665C,$02,$02 Feature #N$11, a wall of roots that is inside the high end of y.
B $665E,$01,$01 The end of the features.
B $665F,$09,$09 Template #N$05 (spiked ring), in 8 cells.
B $6668,$02,$02 Template #N$10 (slider x), in 1 cell.
@ $666A label=Room_66
B $666A,$03,$03 Room #N$66, which has red ink and size #N$00, and is #N$0C bytes
. long.
B $666D,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6716.
B $666F,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6677.
B $6671,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$6655.
B $6673,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $6675,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
@ $6677 label=Room_67
B $6677,$03,$03 Room #N$67, which has magenta ink and size #N$00, and is #N$12
. bytes long.
B $667A,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$6554.
B $667C,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$666A.
B $667E,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $6680,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $6682,$01,$01 The end of the features.
B $6683,$03,$03 Template #N$0E (falling stalactites), in 2 cells.
B $6686,$04,$04 Template #N$15 (floor trap 2), in 3 cells.
@ $668A label=Room_6A
B $668A,$03,$03 Room #N$6A, which has yellow ink and size #N$00, and is #N$0F
. bytes long.
B $668D,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$669A.
B $668F,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6563.
B $6691,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6693,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $6695,$01,$01 The end of the features.
B $6696,$02,$02 Template #N$12 (wandering spark), in 1 cell.
B $6698,$02,$02 Template #N$14 (flickering spark), in 1 cell.
@ $669A label=Room_6B
B $669A,$03,$03 Room #N$6B, which has white ink and size #N$00, and is #N$21
. bytes long.
B $669D,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6734.
B $669F,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6572.
B $66A1,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$668A.
B $66A3,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $66A5,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $66A7,$01,$01 The end of the features.
B $66A8,$05,$05 Template #N$04 (falling pedestal), in 4 cells.
B $66AD,$03,$03 Template #N$0F (bobbing head), in 2 cells.
B $66B0,$09,$09 Template #N$05 (spiked ring), in 8 cells.
B $66B9,$03,$03 Template #N$05 (spiked ring), in 2 cells.
@ $66BC label=Room_6C
B $66BC,$03,$03 Room #N$6C, which has red ink and size #N$00, and is #N$1B bytes
. long.
B $66BF,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$65E2.
B $66C1,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $66C3,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $66C5,$01,$01 The end of the features.
B $66C6,$02,$02 Template #N$1B (conveyor block plus y), in 1 cell.
B $66C8,$02,$02 Template #N$1C (conveyor block minus y), in 1 cell.
B $66CA,$04,$04 Template #N$00 (stone slab), in 3 cells.
B $66CE,$03,$03 Template #N$03 (stalactites), in 2 cells.
B $66D1,$02,$02 Template #N$0F (bobbing head), in 1 cell.
B $66D3,$05,$05 Template #N$05 (spiked ring), in 5 cells, though the room ends
. after 4 of them.
@ $66D8 label=Room_6D
B $66D8,$03,$03 Room #N$6D, which has magenta ink and size #N$00, and is #N$1F
. bytes long.
B $66DB,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$674A.
B $66DD,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$65FB.
B $66DF,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $66E1,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $66E3,$01,$01 The end of the features.
B $66E4,$09,$09 Template #N$05 (spiked ring), in 8 cells.
B $66ED,$09,$09 Template #N$05 (spiked ring), in 8 cells.
B $66F6,$02,$02 Template #N$12 (wandering spark), in 1 cell.
@ $66F8 label=Room_6E
B $66F8,$03,$03 Room #N$6E, which has green ink and size #N$00, and is #N$0A
. bytes long.
B $66FB,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6703.
B $66FD,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6632.
B $66FF,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6701,$02,$02 Feature #N$09, a wall of roots along the high end of y.
@ $6703 label=Room_6F
B $6703,$03,$03 Room #N$6F, which has cyan ink and size #N$00, and is #N$12
. bytes long.
B $6706,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6755.
B $6708,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$66F8.
B $670A,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $670C,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $670E,$01,$01 The end of the features.
B $670F,$05,$05 Template #N$0E (falling stalactites), in 4 cells.
B $6714,$02,$02 Template #N$12 (wandering spark), in 1 cell.
@ $6716 label=Room_70
B $6716,$03,$03 Room #N$70, which has yellow ink and size #N$00, and is #N$1D
. bytes long.
B $6719,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$666A.
B $671B,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $671D,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $671F,$01,$01 The end of the features.
B $6720,$09,$09 Template #N$0D (floor trap 1), in 8 cells.
B $6729,$07,$07 Template #N$15 (floor trap 2), in 6 cells.
B $6730,$04,$04 Template #N$01 (round pedestal), in 3 cells.
@ $6734 label=Room_75
B $6734,$03,$03 Room #N$75, which has cyan ink and size #N$01, and is #N$15
. bytes long.
B $6737,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$677E.
B $6739,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$669A.
B $673B,$02,$02 Feature #N$10, a wall of roots that is inside the low end of x.
B $673D,$01,$01 The end of the features.
B $673E,$05,$05 Template #N$01 (round pedestal), in 4 cells.
B $6743,$05,$05 Template #N$05 (spiked ring), in 4 cells.
B $6748,$02,$02 Template #N$14 (flickering spark), in 1 cell.
@ $674A label=Room_76
B $674A,$03,$03 Room #N$76, which has yellow ink and size #N$00, and is #N$0A
. bytes long.
B $674D,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6787.
B $674F,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$66D8.
B $6751,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6753,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
@ $6755 label=Room_77
B $6755,$03,$03 Room #N$77, which has white ink and size #N$00, and is #N$0C
. bytes long.
B $6758,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$67ED.
B $675A,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6762.
B $675C,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6703.
B $675E,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6760,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
@ $6762 label=Room_78
B $6762,$03,$03 Room #N$78, which has red ink and size #N$00, and is #N$1B bytes
. long.
B $6765,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$6755.
B $6767,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $6769,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $676B,$01,$01 The end of the features.
B $676C,$08,$08 Template #N$01 (round pedestal), in 7 cells.
B $6774,$02,$02 Template #N$04 (falling pedestal), in 1 cell.
B $6776,$06,$06 Template #N$05 (spiked ring), in 5 cells.
B $677C,$02,$02 Template #N$1D (harmful slider x), in 1 cell.
@ $677E label=Room_7A
B $677E,$03,$03 Room #N$7A, which has green ink and size #N$00, and is #N$08
. bytes long. It is where the object of the type #N$70 is at the start of the
. game.
B $6781,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6734.
B $6783,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6785,$02,$02 Feature #N$09, a wall of roots along the high end of y.
@ $6787 label=Room_7B
B $6787,$03,$03 Room #N$7B, which has cyan ink and size #N$00, and is #N$20
. bytes long.
B $678A,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$67A8.
B $678C,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$674A.
B $678E,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6790,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $6792,$01,$01 The end of the features.
B $6793,$02,$02 Template #N$13 (well), in 1 cell.
B $6795,$09,$09 Template #N$0D (floor trap 1), in 8 cells.
B $679E,$06,$06 Template #N$15 (floor trap 2), in 5 cells.
B $67A4,$02,$02 Template #N$0A (sinking block), in 1 cell.
B $67A6,$02,$02 Template #N$01 (round pedestal), in 1 cell.
@ $67A8 label=Room_7C
B $67A8,$03,$03 Room #N$7C, which has yellow ink and size #N$00, and is #N$0A
. bytes long.
B $67AB,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$67B3.
B $67AD,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$6787.
B $67AF,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $67B1,$02,$02 Feature #N$09, a wall of roots along the high end of y.
@ $67B3 label=Room_7D
B $67B3,$03,$03 Room #N$7D, which has white ink and size #N$00, and is #N$16
. bytes long.
B $67B6,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$67CA.
B $67B8,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$67A8.
B $67BA,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $67BC,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $67BE,$01,$01 The end of the features.
B $67BF,$09,$09 Template #N$15 (floor trap 2), in 8 cells.
B $67C8,$02,$02 Template #N$14 (flickering spark), in 1 cell.
@ $67CA label=Room_7E
B $67CA,$03,$03 Room #N$7E, which has red ink and size #N$02, and is #N$17 bytes
. long.
B $67CD,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$67E2.
B $67CF,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$67B3.
B $67D1,$02,$02 Feature #N$11, a wall of roots that is inside the high end of y.
B $67D3,$01,$01 The end of the features.
B $67D4,$09,$09 Template #N$05 (spiked ring), in 8 cells.
B $67DD,$05,$05 Template #N$04 (falling pedestal), in 4 cells.
@ $67E2 label=Room_7F
B $67E2,$03,$03 Room #N$7F, which has magenta ink and size #N$00, and is #N$0A
. bytes long.
B $67E5,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6811.
B $67E7,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$67CA.
B $67E9,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $67EB,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
@ $67ED label=Room_80
B $67ED,$03,$03 Room #N$80, which has green ink and size #N$00, and is #N$08
. bytes long. It is where the object of the type #N$71 is at the start of the
. game.
B $67F0,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6755.
B $67F2,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $67F4,$02,$02 Feature #N$09, a wall of roots along the high end of y.
@ $67F6 label=Room_81
B $67F6,$03,$03 Room #N$81, which has cyan ink and size #N$00, and is #N$1A
. bytes long.
B $67F9,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$682A.
B $67FB,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $67FD,$02,$02 Feature #N$0B, a wall of roots along the high end of y, with a
. gap.
B $67FF,$01,$01 The end of the features.
B $6800,$02,$02 Template #N$00 (stone slab), in 1 cell.
B $6802,$02,$02 Template #N$10 (slider x), in 1 cell.
B $6804,$02,$02 Template #N$1E (harmful slider y), in 1 cell.
B $6806,$02,$02 Template #N$19 (conveyor block plus x), in 1 cell.
B $6808,$09,$09 Template #N$15 (floor trap 2), in 8 cells.
@ $6811 label=Room_82
B $6811,$03,$03 Room #N$82, which has yellow ink and size #N$01, and is #N$18
. bytes long.
B $6814,$02,$02 Feature #N$00, the root door and its frame in the wall at the
. high end of y, which leads to #R$6861.
B $6816,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$67E2.
B $6818,$02,$02 Feature #N$10, a wall of roots that is inside the low end of x.
B $681A,$01,$01 The end of the features.
B $681B,$04,$04 Template #N$01 (round pedestal), in 3 cells.
B $681F,$04,$04 Template #N$04 (falling pedestal), in 3 cells.
B $6823,$05,$05 Template #N$05 (spiked ring), in 4 cells.
B $6828,$02,$02 Template #N$1D (harmful slider x), in 1 cell.
@ $682A label=Room_83
B $682A,$03,$03 Room #N$83, which has white ink and size #N$00, and is #N$16
. bytes long.
B $682D,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6841.
B $682F,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$67F6.
B $6831,$02,$02 Feature #N$08, a wall of roots along the low end of x.
B $6833,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $6835,$01,$01 The end of the features.
B $6836,$09,$09 Template #N$15 (floor trap 2), in 8 cells.
B $683F,$02,$02 Template #N$14 (flickering spark), in 1 cell.
@ $6841 label=Room_84
B $6841,$03,$03 Room #N$84, which has red ink and size #N$02, and is #N$08 bytes
. long.
B $6844,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$684A.
B $6846,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$682A.
B $6848,$02,$02 Feature #N$11, a wall of roots that is inside the high end of y.
@ $684A label=Room_85
B $684A,$03,$03 Room #N$85, which has magenta ink and size #N$00, and is #N$16
. bytes long.
B $684D,$02,$02 Feature #N$01, the root door and its frame in the wall at the
. high end of x, which leads to #R$6861.
B $684F,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$6841.
B $6851,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $6853,$02,$02 Feature #N$09, a wall of roots along the high end of y.
B $6855,$01,$01 The end of the features.
B $6856,$09,$09 Template #N$04 (falling pedestal), in 8 cells.
B $685F,$02,$02 Template #N$12 (wandering spark), in 1 cell.
@ $6861 label=Room_86
B $6861,$03,$03 Room #N$86, which has green ink and size #N$00, and is #N$11
. bytes long.
B $6864,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$6873.
B $6866,$02,$02 Feature #N$02, the root door and its frame in the wall at the
. low end of y, which leads to #R$6811.
B $6868,$02,$02 Feature #N$03, the root door and its frame in the wall at the
. low end of x, which leads to #R$684A.
B $686A,$02,$02 Feature #N$0A, a wall of roots along the low end of x, with a
. gap.
B $686C,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $686E,$01,$01 The end of the features.
B $686F,$02,$02 Template #N$0D (floor trap 1), in 1 cell.
B $6871,$02,$02 Template #N$15 (floor trap 2), in 1 cell.
@ $6873 label=Room_87
B $6873,$03,$03 Room #N$87, which has cyan ink and size #N$00, and is #N$0C
. bytes long.
B $6876,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$688B.
B $6878,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$6880.
B $687A,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$6861.
B $687C,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $687E,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
@ $6880 label=Room_88
B $6880,$03,$03 Room #N$88, which has yellow ink and size #N$00, and is #N$0A
. bytes long.
B $6883,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$6896.
B $6885,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$6873.
B $6887,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $6889,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
@ $688B label=Room_89
B $688B,$03,$03 Room #N$89, which has white ink and size #N$00, and is #N$0A
. bytes long.
B $688E,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$6896.
B $6890,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$6873.
B $6892,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $6894,$02,$02 Feature #N$0D, a stone wall along the high end of y.
@ $6896 label=Room_8A
B $6896,$03,$03 Room #N$8A, which has red ink and size #N$00, and is #N$0A bytes
. long.
B $6899,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$6880.
B $689B,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$688B.
B $689D,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $689F,$02,$02 Feature #N$0D, a stone wall along the high end of y.
@ $68A1 label=Room_8B
B $68A1,$03,$03 Room #N$8B, which has magenta ink and size #N$00, and is #N$0A
. bytes long.
B $68A4,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$68CD.
B $68A6,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$68AC.
B $68A8,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $68AA,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
@ $68AC label=Room_8C
B $68AC,$03,$03 Room #N$8C, which has green ink and size #N$00, and is #N$0C
. bytes long.
B $68AF,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$68E7.
B $68B1,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$6163.
B $68B3,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$68A1.
B $68B5,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $68B7,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
@ $68B9 label=Room_8D
B $68B9,$03,$03 Room #N$8D, which has cyan ink and size #N$00, and is #N$13
. bytes long.
B $68BC,$02,$02 Feature #N$04, the stone door and its frame in the wall at the
. high end of y, which leads to #R$68F4.
B $68BE,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $68C0,$02,$02 Feature #N$0F, a stone wall along the high end of y, with a gap.
B $68C2,$01,$01 The end of the features.
B $68C3,$04,$04 Template #N$18 (crumbling block), in 3 cells.
B $68C7,$02,$02 Template #N$00 (stone slab), in 1 cell.
B $68C9,$04,$04 Template #N$03 (stalactites), in 3 cells.
@ $68CD label=Room_8E
B $68CD,$03,$03 Room #N$8E, which has yellow ink and size #N$00, and is #N$19
. bytes long.
B $68D0,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$68A1.
B $68D2,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $68D4,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $68D6,$01,$01 The end of the features.
B $68D7,$06,$06 Template #N$00 (stone slab), in 5 cells.
B $68DD,$04,$04 Template #N$18 (crumbling block), in 3 cells.
B $68E1,$03,$03 Template #N$09 (block), in 2 cells.
B $68E4,$03,$03 Template #N$12 (wandering spark), in 2 cells.
@ $68E7 label=Room_8F
B $68E7,$03,$03 Room #N$8F, which has white ink and size #N$00, and is #N$0C
. bytes long.
B $68EA,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$68F4.
B $68EC,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$68AC.
B $68EE,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$629C.
B $68F0,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $68F2,$02,$02 Feature #N$0D, a stone wall along the high end of y.
@ $68F4 label=Room_90
B $68F4,$03,$03 Room #N$90, which has red ink and size #N$00, and is #N$0A bytes
. long.
B $68F7,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$68B9.
B $68F9,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$68E7.
B $68FB,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $68FD,$02,$02 Feature #N$0D, a stone wall along the high end of y.
@ $68FF label=Room_91
B $68FF,$03,$03 Room #N$91, which has magenta ink and size #N$00, and is #N$0F
. bytes long.
B $6902,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$690F.
B $6904,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$650A.
B $6906,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $6908,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $690A,$01,$01 The end of the features.
B $690B,$02,$02 Template #N$12 (wandering spark), in 1 cell.
B $690D,$02,$02 Template #N$00 (stone slab), in 1 cell.
@ $690F label=Room_92
B $690F,$03,$03 Room #N$92, which has green ink and size #N$00, and is #N$1C
. bytes long.
B $6912,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$68FF.
B $6914,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $6916,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $6918,$01,$01 The end of the features.
B $6919,$05,$05 Template #N$18 (crumbling block), in 4 cells.
B $691E,$02,$02 Template #N$0A (sinking block), in 1 cell.
B $6920,$05,$05 Template #N$00 (stone slab), in 4 cells.
B $6925,$02,$02 Template #N$09 (block), in 1 cell.
B $6927,$05,$05 Template #N$03 (stalactites), in 4 cells.
@ $692C label=Room_93
B $692C,$03,$03 Room #N$93, which has cyan ink and size #N$00, and is #N$17
. bytes long.
B $692F,$02,$02 Feature #N$19, the raised stone door and its frame in the wall
. at the high end of x, which leads to #R$6944.
B $6931,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$5E10.
B $6933,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $6935,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $6937,$02,$02 Feature #N$1D, the slabs outside the raised door at the high end
. of x.
B $6939,$01,$01 The end of the features.
B $693A,$02,$02 Template #N$0C (lift), in 1 cell.
B $693C,$03,$03 Template #N$00 (stone slab), in 2 cells.
B $693F,$02,$02 Template #N$1E (harmful slider y), in 1 cell.
B $6941,$03,$03 Template #N$03 (stalactites), in 2 cells.
@ $6944 label=Room_94
B $6944,$03,$03 Room #N$94, which has yellow ink and size #N$00, and is #N$0A
. bytes long.
B $6947,$02,$02 Feature #N$05, the stone door and its frame in the wall at the
. high end of x, which leads to #R$694F.
B $6949,$02,$02 Feature #N$07, the stone door and its frame in the wall at the
. low end of x, which leads to #R$692C.
B $694B,$02,$02 Feature #N$0E, a stone wall along the low end of x, with a gap.
B $694D,$02,$02 Feature #N$0D, a stone wall along the high end of y.
@ $694F label=Room_95
B $694F,$03,$03 Room #N$95, which has white ink and size #N$00, and is #N$1D
. bytes long.
B $6952,$02,$02 Feature #N$06, the stone door and its frame in the wall at the
. low end of y, which leads to #R$5E42.
B $6954,$02,$02 Feature #N$1B, the raised stone door and its frame in the wall
. at the low end of x, which leads to #R$6944.
B $6956,$02,$02 Feature #N$0C, a stone wall along the low end of x.
B $6958,$02,$02 Feature #N$0D, a stone wall along the high end of y.
B $695A,$02,$02 Feature #N$1F, the slabs outside the raised door at the low end
. of x.
B $695C,$01,$01 The end of the features.
B $695D,$08,$08 Template #N$03 (stalactites), in 7 cells.
B $6965,$04,$04 Template #N$18 (crumbling block), in 3 cells.
B $6969,$02,$02 Template #N$0C (lift), in 1 cell.
B $696B,$02,$02 Template #N$0A (sinking block), in 1 cell.

w $696D Feature Table
@ $696D label=FeatureTable
D $696D The addresses of the features that the rooms use, which are numbered
. #N$00 to #N$1F. #R$C92C uses the feature numbers of a room to find them. Four
. of the entries are never used, and point at the table itself.
W $696D,$02,$02 Feature #N$00: The root door and its frame in the wall at the
. high end of y.
W $696F,$02,$02 Feature #N$01: The root door and its frame in the wall at the
. high end of x.
W $6971,$02,$02 Feature #N$02: The root door and its frame in the wall at the
. low end of y.
W $6973,$02,$02 Feature #N$03: The root door and its frame in the wall at the
. low end of x.
W $6975,$02,$02 Feature #N$04: The stone door and its frame in the wall at the
. high end of y.
W $6977,$02,$02 Feature #N$05: The stone door and its frame in the wall at the
. high end of x.
W $6979,$02,$02 Feature #N$06: The stone door and its frame in the wall at the
. low end of y.
W $697B,$02,$02 Feature #N$07: The stone door and its frame in the wall at the
. low end of x.
W $697D,$02,$02 Feature #N$08: A wall of roots along the low end of x.
W $697F,$02,$02 Feature #N$09: A wall of roots along the high end of y.
W $6981,$02,$02 Feature #N$0A: A wall of roots along the low end of x, with a
. gap.
W $6983,$02,$02 Feature #N$0B: A wall of roots along the high end of y, with a
. gap.
W $6985,$02,$02 Feature #N$0C: A stone wall along the low end of x.
W $6987,$02,$02 Feature #N$0D: A stone wall along the high end of y.
W $6989,$02,$02 Feature #N$0E: A stone wall along the low end of x, with a gap.
W $698B,$02,$02 Feature #N$0F: A stone wall along the high end of y, with a gap.
W $698D,$02,$02 Feature #N$10: A wall of roots that is inside the low end of x.
W $698F,$02,$02 Feature #N$11: A wall of roots that is inside the high end of y.
W $6991,$02,$02 Feature #N$12: Nothing, as it is never used.
W $6993,$02,$02 Feature #N$13: Nothing, as it is never used.
W $6995,$02,$02 Feature #N$14: A stone wall that is inside the low end of x.
W $6997,$02,$02 Feature #N$15: A stone wall that is inside the high end of y.
W $6999,$02,$02 Feature #N$16: Nothing, as it is never used.
W $699B,$02,$02 Feature #N$17: Nothing, as it is never used.
W $699D,$02,$02 Feature #N$18: The raised stone door and its frame in the wall
. at the high end of y.
W $699F,$02,$02 Feature #N$19: The raised stone door and its frame in the wall
. at the high end of x.
W $69A1,$02,$02 Feature #N$1A: The raised stone door and its frame in the wall
. at the low end of y.
W $69A3,$02,$02 Feature #N$1B: The raised stone door and its frame in the wall
. at the low end of x.
W $69A5,$02,$02 Feature #N$1C: The slabs outside the raised door at the high end
. of y.
W $69A7,$02,$02 Feature #N$1D: The slabs outside the raised door at the high end
. of x.
W $69A9,$02,$02 Feature #N$1E: The slabs outside the raised door at the low end
. of y.
W $69AB,$02,$02 Feature #N$1F: The slabs outside the raised door at the low end
. of x.

b $69AD Feature Data
D $69AD The features, each a list of objects of eight bytes, which are the type,
. the position along x, y and z, the half sizes along x and y, the size along z
. and the flags, and which ends with a #N$00 in place of the type of another
. object. #R$C92C copies each into an object record, and sets its room to the
. parameter of the feature in the room. Some of the features start in the middle
. of another, and are what is left of it when its first objects are left out.
@ $69AD label=Feature_Root_Doors_High_Y
N $69AD Feature #N$00: The root door and its frame in the wall at the high end
. of y.
B $69AD,$08,$08 The root door frame of the type #N$07, at #N$73, #N$C5 and #N$80
. along x, y and z.
B $69B5,$08,$08 The root door of the type #N$06, at #N$8D, #N$C5 and #N$80 along
. x, y and z.
B $69BD,$01,$01 The end of the feature.
@ $69BE label=Feature_Root_Doors_High_X
N $69BE Feature #N$01: The root door and its frame in the wall at the high end
. of x.
B $69BE,$08,$08 The root door frame of the type #N$07, at #N$C5, #N$8D and #N$80
. along x, y and z.
B $69C6,$08,$08 The root door of the type #N$06, at #N$C5, #N$73 and #N$80 along
. x, y and z.
B $69CE,$01,$01 The end of the feature.
@ $69CF label=Feature_Root_Doors_Low_Y
N $69CF Feature #N$02: The root door and its frame in the wall at the low end of
. y.
B $69CF,$08,$08 The root door frame of the type #N$07, at #N$73, #N$3B and #N$80
. along x, y and z.
B $69D7,$08,$08 The root door of the type #N$06, at #N$8D, #N$3B and #N$80 along
. x, y and z.
B $69DF,$01,$01 The end of the feature.
@ $69E0 label=Feature_Root_Doors_Low_X
N $69E0 Feature #N$03: The root door and its frame in the wall at the low end of
. x.
B $69E0,$08,$08 The root door frame of the type #N$07, at #N$3B, #N$8D and #N$80
. along x, y and z.
B $69E8,$08,$08 The root door of the type #N$06, at #N$3B, #N$73 and #N$80 along
. x, y and z.
B $69F0,$01,$01 The end of the feature.
@ $69F1 label=Feature_Stone_Doors_High_Y
N $69F1 Feature #N$04: The stone door and its frame in the wall at the high end
. of y.
B $69F1,$08,$08 The stone door frame of the type #N$09, at #N$73, #N$C5 and
. #N$80 along x, y and z.
B $69F9,$08,$08 The stone door of the type #N$08, at #N$8D, #N$C5 and #N$80
. along x, y and z.
B $6A01,$01,$01 The end of the feature.
@ $6A02 label=Feature_Stone_Doors_High_X
N $6A02 Feature #N$05: The stone door and its frame in the wall at the high end
. of x.
B $6A02,$08,$08 The stone door frame of the type #N$09, at #N$C5, #N$8D and
. #N$80 along x, y and z.
B $6A0A,$08,$08 The stone door of the type #N$08, at #N$C5, #N$73 and #N$80
. along x, y and z.
B $6A12,$01,$01 The end of the feature.
@ $6A13 label=Feature_Stone_Doors_Low_Y
N $6A13 Feature #N$06: The stone door and its frame in the wall at the low end
. of y.
B $6A13,$08,$08 The stone door frame of the type #N$09, at #N$73, #N$3B and
. #N$80 along x, y and z.
B $6A1B,$08,$08 The stone door of the type #N$08, at #N$8D, #N$3B and #N$80
. along x, y and z.
B $6A23,$01,$01 The end of the feature.
@ $6A24 label=Feature_Stone_Doors_Low_X
N $6A24 Feature #N$07: The stone door and its frame in the wall at the low end
. of x.
B $6A24,$08,$08 The stone door frame of the type #N$09, at #N$3B, #N$8D and
. #N$80 along x, y and z.
B $6A2C,$08,$08 The stone door of the type #N$08, at #N$3B, #N$73 and #N$80
. along x, y and z.
B $6A34,$01,$01 The end of the feature.
@ $6A35 label=Feature_Raised_Stone_Doors_High_Y
N $6A35 Feature #N$18: The raised stone door and its frame in the wall at the
. high end of y.
B $6A35,$08,$08 The stone door frame of the type #N$09, at #N$93, #N$C5 and
. #N$B0 along x, y and z.
B $6A3D,$08,$08 The stone door of the type #N$08, at #N$AD, #N$C5 and #N$B0
. along x, y and z.
B $6A45,$01,$01 The end of the feature.
@ $6A46 label=Feature_Raised_Stone_Doors_High_X
N $6A46 Feature #N$19: The raised stone door and its frame in the wall at the
. high end of x.
B $6A46,$08,$08 The stone door frame of the type #N$09, at #N$C5, #N$AD and
. #N$B0 along x, y and z.
B $6A4E,$08,$08 The stone door of the type #N$08, at #N$C5, #N$93 and #N$B0
. along x, y and z.
B $6A56,$01,$01 The end of the feature.
@ $6A57 label=Feature_Raised_Stone_Doors_Low_Y
N $6A57 Feature #N$1A: The raised stone door and its frame in the wall at the
. low end of y.
B $6A57,$08,$08 The stone door frame of the type #N$09, at #N$53, #N$3B and
. #N$B0 along x, y and z.
B $6A5F,$08,$08 The stone door of the type #N$08, at #N$6D, #N$3B and #N$B0
. along x, y and z.
B $6A67,$01,$01 The end of the feature.
@ $6A68 label=Feature_Raised_Stone_Doors_Low_X
N $6A68 Feature #N$1B: The raised stone door and its frame in the wall at the
. low end of x.
B $6A68,$08,$08 The stone door frame of the type #N$09, at #N$3B, #N$6D and
. #N$B0 along x, y and z.
B $6A70,$08,$08 The stone door of the type #N$08, at #N$3B, #N$53 and #N$B0
. along x, y and z.
B $6A78,$01,$01 The end of the feature.
@ $6A79 label=Feature_Doorstep_Slabs_High_Y
N $6A79 Feature #N$1C: The slabs outside the raised door at the high end of y.
B $6A79,$08,$08 The stone slab of the type #N$0B, at #N$98, #N$C8 and #N$A4
. along x, y and z.
B $6A81,$08,$08 The stone slab of the type #N$0B, at #N$A8, #N$C8 and #N$A4
. along x, y and z.
B $6A89,$01,$01 The end of the feature.
@ $6A8A label=Feature_Doorstep_Slabs_High_X
N $6A8A Feature #N$1D: The slabs outside the raised door at the high end of x.
B $6A8A,$08,$08 The stone slab of the type #N$0B, at #N$C8, #N$98 and #N$A4
. along x, y and z.
B $6A92,$08,$08 The stone slab of the type #N$0B, at #N$C8, #N$A8 and #N$A4
. along x, y and z.
B $6A9A,$01,$01 The end of the feature.
@ $6A9B label=Feature_Doorstep_Slabs_Low_Y
N $6A9B Feature #N$1E: The slabs outside the raised door at the low end of y.
B $6A9B,$08,$08 The stone slab of the type #N$0B, at #N$58, #N$39 and #N$A4
. along x, y and z.
B $6AA3,$08,$08 The stone slab of the type #N$0B, at #N$68, #N$39 and #N$A4
. along x, y and z.
B $6AAB,$01,$01 The end of the feature.
@ $6AAC label=Feature_Doorstep_Slabs_Low_X
N $6AAC Feature #N$1F: The slabs outside the raised door at the low end of x.
B $6AAC,$08,$08 The stone slab of the type #N$0B, at #N$38, #N$58 and #N$A4
. along x, y and z.
B $6AB4,$08,$08 The stone slab of the type #N$0B, at #N$38, #N$68 and #N$A4
. along x, y and z.
B $6ABC,$01,$01 The end of the feature.
@ $6ABD label=Feature_Root_Wall_Low_X
N $6ABD Feature #N$08: A wall of roots along the low end of x.
B $6ABD,$08,$08 The root wall piece of the type #N$0F, at #N$40, #N$78 and #N$80
. along x, y and z.
B $6AC5,$08,$08 The root wall piece of the type #N$0C, at #N$40, #N$88 and #N$80
. along x, y and z.
@ $6ACD label=Feature_Root_Wall_Low_X_Gap
N $6ACD Feature #N$0A: A wall of roots along the low end of x, with a gap.
B $6ACD,$08,$08 The root wall piece of the type #N$0C, at #N$40, #N$48 and #N$80
. along x, y and z.
B $6AD5,$08,$08 The root wall piece of the type #N$0D, at #N$40, #N$58 and #N$80
. along x, y and z.
B $6ADD,$08,$08 The root wall piece of the type #N$0E, at #N$40, #N$68 and #N$80
. along x, y and z.
B $6AE5,$08,$08 The root wall piece of the type #N$0D, at #N$40, #N$98 and #N$80
. along x, y and z.
B $6AED,$08,$08 The root wall piece of the type #N$0E, at #N$40, #N$A8 and #N$80
. along x, y and z.
B $6AF5,$08,$08 The root wall piece of the type #N$0F, at #N$40, #N$B8 and #N$80
. along x, y and z.
B $6AFD,$01,$01 The end of the feature.
@ $6AFE label=Feature_Root_Wall_High_Y
N $6AFE Feature #N$09: A wall of roots along the high end of y.
B $6AFE,$08,$08 The root wall piece of the type #N$0F, at #N$78, #N$C0 and #N$80
. along x, y and z.
B $6B06,$08,$08 The root wall piece of the type #N$0C, at #N$88, #N$C0 and #N$80
. along x, y and z.
@ $6B0E label=Feature_Root_Wall_High_Y_Gap
N $6B0E Feature #N$0B: A wall of roots along the high end of y, with a gap.
B $6B0E,$08,$08 The root wall piece of the type #N$0C, at #N$48, #N$C0 and #N$80
. along x, y and z.
B $6B16,$08,$08 The root wall piece of the type #N$0D, at #N$58, #N$C0 and #N$80
. along x, y and z.
B $6B1E,$08,$08 The root wall piece of the type #N$0E, at #N$68, #N$C0 and #N$80
. along x, y and z.
B $6B26,$08,$08 The root wall piece of the type #N$0D, at #N$98, #N$C0 and #N$80
. along x, y and z.
B $6B2E,$08,$08 The root wall piece of the type #N$0E, at #N$A8, #N$C0 and #N$80
. along x, y and z.
B $6B36,$08,$08 The root wall piece of the type #N$0F, at #N$B8, #N$C0 and #N$80
. along x, y and z.
B $6B3E,$01,$01 The end of the feature.
@ $6B3F label=Feature_Inner_Root_Wall_Low_X
N $6B3F Feature #N$10: A wall of roots that is inside the low end of x.
B $6B3F,$08,$08 The root wall piece of the type #N$0F, at #N$60, #N$78 and #N$80
. along x, y and z.
B $6B47,$08,$08 The root wall piece of the type #N$0C, at #N$60, #N$88 and #N$80
. along x, y and z.
B $6B4F,$08,$08 The root wall piece of the type #N$0C, at #N$60, #N$48 and #N$80
. along x, y and z.
B $6B57,$08,$08 The root wall piece of the type #N$0D, at #N$60, #N$58 and #N$80
. along x, y and z.
B $6B5F,$08,$08 The root wall piece of the type #N$0E, at #N$60, #N$68 and #N$80
. along x, y and z.
B $6B67,$08,$08 The root wall piece of the type #N$0D, at #N$60, #N$98 and #N$80
. along x, y and z.
B $6B6F,$08,$08 The root wall piece of the type #N$0E, at #N$60, #N$A8 and #N$80
. along x, y and z.
B $6B77,$08,$08 The root wall piece of the type #N$0F, at #N$60, #N$B8 and #N$80
. along x, y and z.
B $6B7F,$08,$08 The root wall piece of the type #N$0E, at #N$68, #N$C0 and #N$80
. along x, y and z.
B $6B87,$01,$01 The end of the feature.
@ $6B88 label=Feature_Inner_Root_Wall_High_Y
N $6B88 Feature #N$11: A wall of roots that is inside the high end of y.
B $6B88,$08,$08 The root wall piece of the type #N$0F, at #N$78, #N$A0 and #N$80
. along x, y and z.
B $6B90,$08,$08 The root wall piece of the type #N$0C, at #N$88, #N$A0 and #N$80
. along x, y and z.
B $6B98,$08,$08 The root wall piece of the type #N$0C, at #N$48, #N$A0 and #N$80
. along x, y and z.
B $6BA0,$08,$08 The root wall piece of the type #N$0D, at #N$58, #N$A0 and #N$80
. along x, y and z.
B $6BA8,$08,$08 The root wall piece of the type #N$0E, at #N$68, #N$A0 and #N$80
. along x, y and z.
B $6BB0,$08,$08 The root wall piece of the type #N$0D, at #N$98, #N$A0 and #N$80
. along x, y and z.
B $6BB8,$08,$08 The root wall piece of the type #N$0E, at #N$A8, #N$A0 and #N$80
. along x, y and z.
B $6BC0,$08,$08 The root wall piece of the type #N$0F, at #N$B8, #N$A0 and #N$80
. along x, y and z.
B $6BC8,$08,$08 The root wall piece of the type #N$0D, at #N$40, #N$98 and #N$80
. along x, y and z.
B $6BD0,$01,$01 The end of the feature.
@ $6BD1 label=Feature_Stone_Wall_Low_X
N $6BD1 Feature #N$0C: A stone wall along the low end of x.
B $6BD1,$08,$08 The stone wall piece of the type #N$34, at #N$40, #N$78 and
. #N$80 along x, y and z.
B $6BD9,$08,$08 The stone wall piece of the type #N$35, at #N$40, #N$88 and
. #N$80 along x, y and z.
@ $6BE1 label=Feature_Stone_Wall_Low_X_Gap
N $6BE1 Feature #N$0E: A stone wall along the low end of x, with a gap.
B $6BE1,$08,$08 The stone wall piece of the type #N$39, at #N$40, #N$48 and
. #N$80 along x, y and z.
B $6BE9,$08,$08 The stone wall piece of the type #N$37, at #N$40, #N$58 and
. #N$80 along x, y and z.
B $6BF1,$08,$08 The stone wall piece of the type #N$38, at #N$40, #N$68 and
. #N$80 along x, y and z.
B $6BF9,$08,$08 The stone wall piece of the type #N$37, at #N$40, #N$98 and
. #N$80 along x, y and z.
B $6C01,$08,$08 The stone wall piece of the type #N$36, at #N$40, #N$A8 and
. #N$80 along x, y and z.
B $6C09,$08,$08 The stone wall piece of the type #N$35, at #N$40, #N$B8 and
. #N$80 along x, y and z.
B $6C11,$01,$01 The end of the feature.
@ $6C12 label=Feature_Stone_Wall_High_Y
N $6C12 Feature #N$0D: A stone wall along the high end of y.
B $6C12,$08,$08 The stone wall piece of the type #N$37, at #N$78, #N$C0 and
. #N$80 along x, y and z.
B $6C1A,$08,$08 The stone wall piece of the type #N$38, at #N$88, #N$C0 and
. #N$80 along x, y and z.
@ $6C22 label=Feature_Stone_Wall_High_Y_Gap
N $6C22 Feature #N$0F: A stone wall along the high end of y, with a gap.
B $6C22,$08,$08 The stone wall piece of the type #N$36, at #N$48, #N$C0 and
. #N$80 along x, y and z.
B $6C2A,$08,$08 The stone wall piece of the type #N$35, at #N$58, #N$C0 and
. #N$80 along x, y and z.
B $6C32,$08,$08 The stone wall piece of the type #N$34, at #N$68, #N$C0 and
. #N$80 along x, y and z.
B $6C3A,$08,$08 The stone wall piece of the type #N$36, at #N$98, #N$C0 and
. #N$80 along x, y and z.
B $6C42,$08,$08 The stone wall piece of the type #N$37, at #N$A8, #N$C0 and
. #N$80 along x, y and z.
B $6C4A,$08,$08 The stone wall piece of the type #N$39, at #N$B8, #N$C0 and
. #N$80 along x, y and z.
B $6C52,$01,$01 The end of the feature.
@ $6C53 label=Feature_Inner_Stone_Wall_Low_X
N $6C53 Feature #N$14: A stone wall that is inside the low end of x.
B $6C53,$08,$08 The stone wall piece of the type #N$34, at #N$60, #N$78 and
. #N$80 along x, y and z.
B $6C5B,$08,$08 The stone wall piece of the type #N$35, at #N$60, #N$88 and
. #N$80 along x, y and z.
B $6C63,$08,$08 The stone wall piece of the type #N$39, at #N$60, #N$48 and
. #N$80 along x, y and z.
B $6C6B,$08,$08 The stone wall piece of the type #N$37, at #N$60, #N$58 and
. #N$80 along x, y and z.
B $6C73,$08,$08 The stone wall piece of the type #N$36, at #N$60, #N$68 and
. #N$80 along x, y and z.
B $6C7B,$08,$08 The stone wall piece of the type #N$37, at #N$60, #N$98 and
. #N$80 along x, y and z.
B $6C83,$08,$08 The stone wall piece of the type #N$35, at #N$60, #N$A8 and
. #N$80 along x, y and z.
B $6C8B,$08,$08 The stone wall piece of the type #N$34, at #N$60, #N$B8 and
. #N$80 along x, y and z.
B $6C93,$08,$08 The stone wall piece of the type #N$36, at #N$68, #N$C0 and
. #N$80 along x, y and z.
B $6C9B,$01,$01 The end of the feature.
@ $6C9C label=Feature_Inner_Stone_Wall_High_Y
N $6C9C Feature #N$15: A stone wall that is inside the high end of y.
B $6C9C,$08,$08 The stone wall piece of the type #N$34, at #N$78, #N$A0 and
. #N$80 along x, y and z.
B $6CA4,$08,$08 The stone wall piece of the type #N$37, at #N$88, #N$A0 and
. #N$80 along x, y and z.
B $6CAC,$08,$08 The stone wall piece of the type #N$36, at #N$48, #N$A0 and
. #N$80 along x, y and z.
B $6CB4,$08,$08 The stone wall piece of the type #N$35, at #N$58, #N$A0 and
. #N$80 along x, y and z.
B $6CBC,$08,$08 The stone wall piece of the type #N$36, at #N$68, #N$A0 and
. #N$80 along x, y and z.
B $6CC4,$08,$08 The stone wall piece of the type #N$37, at #N$98, #N$A0 and
. #N$80 along x, y and z.
B $6CCC,$08,$08 The stone wall piece of the type #N$35, at #N$A8, #N$A0 and
. #N$80 along x, y and z.
B $6CD4,$08,$08 The stone wall piece of the type #N$39, at #N$B8, #N$A0 and
. #N$80 along x, y and z.
B $6CDC,$08,$08 The stone wall piece of the type #N$36, at #N$40, #N$98 and
. #N$80 along x, y and z.
B $6CE4,$01,$01 The end of the feature.

w $6CE5 Template Table
@ $6CE5 label=TemplateTable
D $6CE5 The addresses of the templates that the rooms use, which are numbered
. #N$00 to #N$1E. #R$C92C uses the template number of a group in the room data
. to find them.
W $6CE5,$02,$02 Template #N$00: Stone Slab.
W $6CE7,$02,$02 Template #N$01: Round Pedestal.
W $6CE9,$02,$02 Template #N$02: Ghost.
W $6CEB,$02,$02 Template #N$03: Stalactites.
W $6CED,$02,$02 Template #N$04: Falling Pedestal.
W $6CEF,$02,$02 Template #N$05: Spiked Ring.
W $6CF1,$02,$02 Template #N$06: Falling Cube.
W $6CF3,$02,$02 Template #N$07: Table.
W $6CF5,$02,$02 Template #N$08: Pedestal.
W $6CF7,$02,$02 Template #N$09: Block.
W $6CF9,$02,$02 Template #N$0A: Sinking Block.
W $6CFB,$02,$02 Template #N$0B: Falling Block.
W $6CFD,$02,$02 Template #N$0C: Lift.
W $6CFF,$02,$02 Template #N$0D: Floor Trap 1.
W $6D01,$02,$02 Template #N$0E: Falling Stalactites.
W $6D03,$02,$02 Template #N$0F: Bobbing Head.
W $6D05,$02,$02 Template #N$10: Slider X.
W $6D07,$02,$02 Template #N$11: Slider Y.
W $6D09,$02,$02 Template #N$12: Wandering Spark.
W $6D0B,$02,$02 Template #N$13: Well.
W $6D0D,$02,$02 Template #N$14: Flickering Spark.
W $6D0F,$02,$02 Template #N$15: Floor Trap 2.
W $6D11,$02,$02 Template #N$16: Block.
W $6D13,$02,$02 Template #N$17: Cube.
W $6D15,$02,$02 Template #N$18: Crumbling Block.
W $6D17,$02,$02 Template #N$19: Conveyor Block Plus X.
W $6D19,$02,$02 Template #N$1A: Conveyor Block Minus X.
W $6D1B,$02,$02 Template #N$1B: Conveyor Block Plus Y.
W $6D1D,$02,$02 Template #N$1C: Conveyor Block Minus Y.
W $6D1F,$02,$02 Template #N$1D: Harmful Slider X.
W $6D21,$02,$02 Template #N$1E: Harmful Slider Y.

b $6D23 Template Data
D $6D23 The templates, each a list of objects of five bytes, which are the type,
. the half sizes along x and y, the size along z and the flags, and which ends
. with a #N$00 in place of the type of another object. The position of an object
. comes from the cell that #R$C92C is making it for. Two of the template numbers
. are for the same template.
@ $6D23 label=Template_Block
N $6D23 Template #N$09 and #N$16: A block that the player can push.
B $6D23,$05,$05 The object of the type #N$5B, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6D28,$01,$01 The end of the template.
@ $6D29 label=Template_Stone_Slab
N $6D29 Template #N$00: A stone slab.
B $6D29,$05,$05 The object of the type #N$0B, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6D2E,$01,$01 The end of the template.
@ $6D2F label=Template_Floor_Trap_1
N $6D2F Template #N$0D: A trap in the floor that harms the player.
B $6D2F,$05,$05 The object of the type #N$4A, with half sizes of #N$0C and
. #N$0C, a height of #N$01 and the flags #N$10.
B $6D34,$01,$01 The end of the template.
@ $6D35 label=Template_Floor_Trap_2
N $6D35 Template #N$15: A trap in the floor that harms the player.
B $6D35,$05,$05 The object of the type #N$4B, with half sizes of #N$0C and
. #N$0C, a height of #N$01 and the flags #N$10.
B $6D3A,$01,$01 The end of the template.
@ $6D3B label=Template_Round_Pedestal
N $6D3B Template #N$01: A round pedestal.
B $6D3B,$05,$05 The object of the type #N$0A, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6D40,$01,$01 The end of the template.
@ $6D41 label=Template_Ghost
N $6D41 Template #N$02: A ghost, which homes in on the player.
B $6D41,$05,$05 The object of the type #N$30, with half sizes of #N$05 and
. #N$05, a height of #N$05 and the flags #N$10.
B $6D46,$01,$01 The end of the template.
@ $6D47 label=Template_Stalactites
N $6D47 Template #N$03: Stalactites that harm the player.
B $6D47,$05,$05 The object of the type #N$17, with half sizes of #N$07 and
. #N$07, a height of #N$0A and the flags #N$10.
B $6D4C,$01,$01 The end of the template.
@ $6D4D label=Template_Falling_Pedestal
N $6D4D Template #N$04: A round pedestal that falls.
B $6D4D,$05,$05 The object of the type #N$48, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$14.
B $6D52,$01,$01 The end of the template.
@ $6D53 label=Template_Spiked_Ring
N $6D53 Template #N$05: A spiked ring that harms the player.
B $6D53,$05,$05 The object of the type #N$1E, with half sizes of #N$07 and
. #N$07, a height of #N$0A and the flags #N$10.
B $6D58,$01,$01 The end of the template.
@ $6D59 label=Template_Falling_Cube
N $6D59 Template #N$06: A stone cube that falls.
B $6D59,$05,$05 The object of the type #N$3F, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$14.
B $6D5E,$01,$01 The end of the template.
@ $6D5F label=Template_Table_Object
N $6D5F Template #N$07: A table that can be pushed.
B $6D5F,$05,$05 The object of the type #N$49, with half sizes of #N$08 and
. #N$0E, a height of #N$0C and the flags #N$14.
B $6D64,$01,$01 The end of the template.
@ $6D65 label=Template_Pedestal
N $6D65 Template #N$08: A round pedestal.
B $6D65,$05,$05 The object of the type #N$4C, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6D6A,$01,$01 The end of the template.
@ $6D6B label=Template_Sinking_Block
N $6D6B Template #N$0A: A block that sinks when it is stood on.
B $6D6B,$05,$05 The object of the type #N$4E, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6D70,$01,$01 The end of the template.
@ $6D71 label=Template_Falling_Block
N $6D71 Template #N$0B: A block that falls.
B $6D71,$05,$05 The object of the type #N$4F, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$14.
B $6D76,$01,$01 The end of the template.
@ $6D77 label=Template_Lift
N $6D77 Template #N$0C: A lift.
B $6D77,$05,$05 The object of the type #N$54, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6D7C,$01,$01 The end of the template.
@ $6D7D label=Template_Falling_Stalactites
N $6D7D Template #N$0E: Stalactites that fall and harm the player.
B $6D7D,$05,$05 The object of the type #N$1C, with half sizes of #N$07 and
. #N$07, a height of #N$0B and the flags #N$14.
B $6D82,$01,$01 The end of the template.
@ $6D83 label=Template_Bobbing_Head
N $6D83 Template #N$0F: A spiked head that bobs up and down.
B $6D83,$05,$05 The object of the type #N$56, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6D88,$01,$01 The end of the template.
@ $6D89 label=Template_Slider_X
N $6D89 Template #N$10: A block that slides along x.
B $6D89,$05,$05 The object of the type #N$57, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6D8E,$01,$01 The end of the template.
@ $6D8F label=Template_Slider_Y
N $6D8F Template #N$11: A block that slides along y.
B $6D8F,$05,$05 The object of the type #N$58, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6D94,$01,$01 The end of the template.
@ $6D95 label=Template_Wandering_Spark
N $6D95 Template #N$12: A spark that wanders about the room.
B $6D95,$05,$05 The object of the type #N$59, with half sizes of #N$08 and
. #N$08, a height of #N$0A and the flags #N$10.
B $6D9A,$01,$01 The end of the template.
@ $6D9B label=Template_Harmful_Slider_X
N $6D9B Template #N$1D: A spiked head that slides along x.
B $6D9B,$05,$05 The object of the type #N$5C, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6DA0,$01,$01 The end of the template.
@ $6DA1 label=Template_Harmful_Slider_Y
N $6DA1 Template #N$1E: A spiked head that slides along y.
B $6DA1,$05,$05 The object of the type #N$5D, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$50.
B $6DA6,$01,$01 The end of the template.
@ $6DA7 label=Template_Well
N $6DA7 Template #N$13: A well that makes a helper.
B $6DA7,$05,$05 The object of the type #N$78, with half sizes of #N$0A and
. #N$0A, a height of #N$0C and the flags #N$10.
B $6DAC,$01,$01 The end of the template.
@ $6DAD label=Template_Flickering_Spark
N $6DAD Template #N$14: A spark that wanders about the room.
B $6DAD,$05,$05 The object of the type #N$10, with half sizes of #N$08 and
. #N$08, a height of #N$0A and the flags #N$10.
B $6DB2,$01,$01 The end of the template.
@ $6DB3 label=Template_Cube
N $6DB3 Template #N$17: A stone cube.
B $6DB3,$05,$05 The object of the type #N$52, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6DB8,$01,$01 The end of the template.
@ $6DB9 label=Template_Crumbling_Block
N $6DB9 Template #N$18: A block that crumbles when it is stood on.
B $6DB9,$05,$05 The object of the type #N$88, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6DBE,$01,$01 The end of the template.
@ $6DBF label=Template_Conveyor_Block_Plus_X
N $6DBF Template #N$19: A block that pushes along x.
B $6DBF,$05,$05 The object of the type #N$8C, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6DC4,$01,$01 The end of the template.
@ $6DC5 label=Template_Conveyor_Block_Minus_X
N $6DC5 Template #N$1A: A block that pushes back along x.
B $6DC5,$05,$05 The object of the type #N$8D, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6DCA,$01,$01 The end of the template.
@ $6DCB label=Template_Conveyor_Block_Plus_Y
N $6DCB Template #N$1B: A block that pushes along y.
B $6DCB,$05,$05 The object of the type #N$8E, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6DD0,$01,$01 The end of the template.
@ $6DD1 label=Template_Conveyor_Block_Minus_Y
N $6DD1 Template #N$1C: A block that pushes back along y.
B $6DD1,$05,$05 The object of the type #N$8F, with half sizes of #N$08 and
. #N$08, a height of #N$0C and the flags #N$10.
B $6DD6,$01,$01 The end of the template.

w $6DD7 Sprite Table
@ $6DD7 label=SpriteTable
D $6DD7 The address of the sprite of each of the #N$AC object types, which
. #R$B2EE and #R$B3D3 use to draw an object. A lot of the types share a sprite.
. A sprite has a byte for its width in bytes in the lowest four bits (the
. highest four are never set), a byte for its height in pixels, and then, for
. each pixel row up from the bottom, and for each byte of the width across, a
. pair of a mask byte and a pixel byte. #R$B3D3 clears the bits of the
. background where the mask has a bit set, and merges in the pixel byte.
W $6DD7,$02,$02 Type #N$00: nothing, as it is a free object.
W $6DD9,$02,$02 Type #N$01: a marker that something has to be erased.
W $6DDB,$08,$02 Types #N$02 to #N$05: the pieces of the frame of the menu.
W $6DE3,$02,$02 Type #N$06: a root door.
W $6DE5,$02,$02 Type #N$07: a root door frame.
W $6DE7,$02,$02 Type #N$08: a stone door.
W $6DE9,$02,$02 Type #N$09: a stone door frame.
W $6DEB,$04,$02 Types #N$0A to #N$0B: scenery.
W $6DEF,$08,$02 Types #N$0C to #N$0F: pieces of a wall of roots.
W $6DF7,$04,$02 Types #N$10 to #N$11: a spark that flickers.
W $6DFB,$0A,$02 Types #N$12 to #N$16: pictures of the player, of which only the
. last, the icon of the lives, is used.
W $6E05,$02,$02 Type #N$17: stalactites.
W $6E07,$08,$02 Types #N$18 to #N$1B: nothing.
W $6E0F,$02,$02 Type #N$1C: falling stalactites.
W $6E11,$06,$02 Types #N$1D to #N$1F: objects that are not used.
W $6E17,$10,$02 Types #N$20 to #N$27: the legs of the player.
W $6E27,$10,$02 Types #N$28 to #N$2F: the body of the player.
W $6E37,$08,$02 Types #N$30 to #N$33: a ghost.
W $6E3F,$0A,$02 Types #N$34 to #N$38: pieces of a stone wall.
W $6E49,$02,$02 Type #N$39: the end of a stone wall.
W $6E4B,$0A,$02 Types #N$3A to #N$3E: the pieces of the frame of a room.
W $6E55,$02,$02 Type #N$3F: a cube that falls.
W $6E57,$10,$02 Types #N$40 to #N$47: the frames of an explosion.
W $6E67,$02,$02 Type #N$48: a pedestal that falls.
W $6E69,$02,$02 Type #N$49: a table.
W $6E6B,$04,$02 Types #N$4A to #N$4B: a trap in the floor.
W $6E6F,$04,$02 Types #N$4C to #N$4D: a pedestal.
W $6E73,$04,$02 Types #N$4E to #N$4F: a block that sinks, or one that falls.
W $6E77,$04,$02 Types #N$50 to #N$51: a creature that wanders about.
W $6E7B,$04,$02 Types #N$52 to #N$53: a cube, and an empty sprite.
W $6E7F,$04,$02 Types #N$54 to #N$55: a lift, and a block that bobs.
W $6E83,$02,$02 Type #N$56: a spiked head that bobs.
W $6E85,$04,$02 Types #N$57 to #N$58: blocks that slide.
W $6E89,$02,$02 Type #N$59: a spark that wanders.
W $6E8B,$02,$02 Type #N$5A: the helper.
W $6E8D,$02,$02 Type #N$5B: a block that can be pushed.
W $6E8F,$04,$02 Types #N$5C to #N$5D: spiked heads that slide.
W $6E93,$24,$02 Types #N$5E to #N$6F: nothing.
W $6EB7,$10,$02 Types #N$70 to #N$77: the four objects of the quest, before and
. after they are collected.
W $6EC7,$02,$02 Type #N$78: a well that makes a helper.
W $6EC9,$0E,$02 Types #N$79 to #N$7F: blocks that do nothing.
W $6ED7,$10,$02 Types #N$80 to #N$87: the arcs of the pentagram.
W $6EE7,$08,$02 Types #N$88 to #N$8B: the stages of a block that crumbles.
W $6EEF,$08,$02 Types #N$8C to #N$8F: blocks that push.
W $6EF7,$0A,$02 Types #N$90 to #N$94: the stones that go on the pentagram.
W $6F01,$06,$02 Types #N$95 to #N$97: the frames of a projectile.
W $6F07,$10,$02 Types #N$98 to #N$9F: the stones when they are in place, and
. nothing.
W $6F17,$10,$02 Types #N$A0 to #N$A7: a bat that homes in on the player.
W $6F27,$08,$02 Types #N$A8 to #N$AB: a creature that wanders about.

b $6F2F Sprite: Pentagram Arc 1
@ $6F2F label=Sprite_Pentagram_Arc_1
D $6F2F The sprite of the arc number 1 of the pentagram, which is used for the
. object type #N$80.
B $6F2F,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $6F30,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $6F31,$90,$06 #SPRITEDATA(pentagram-arc-1)

b $6FC1 Sprite: Pentagram Arc 2
@ $6FC1 label=Sprite_Pentagram_Arc_2
D $6FC1 The sprite of the arc number 2 of the pentagram, which is used for the
. object type #N$81.
B $6FC1,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $6FC2,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $6FC3,$90,$06 #SPRITEDATA(pentagram-arc-2)

b $7053 Sprite: Pentagram Arc 3
@ $7053 label=Sprite_Pentagram_Arc_3
D $7053 The sprite of the arc number 3 of the pentagram, which is used for the
. object type #N$82.
B $7053,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7054,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7055,$90,$06 #SPRITEDATA(pentagram-arc-3)

b $70E5 Sprite: Pentagram Arc 4
@ $70E5 label=Sprite_Pentagram_Arc_4
D $70E5 The sprite of the arc number 4 of the pentagram, which is used for the
. object type #N$83.
B $70E5,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $70E6,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $70E7,$90,$06 #SPRITEDATA(pentagram-arc-4)

b $7177 Sprite: Pentagram Arc 5
@ $7177 label=Sprite_Pentagram_Arc_5
D $7177 The sprite of the arc number 5 of the pentagram, which is used for the
. object type #N$84.
B $7177,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7178,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7179,$90,$06 #SPRITEDATA(pentagram-arc-5)

b $7209 Sprite: Pentagram Arc 6
@ $7209 label=Sprite_Pentagram_Arc_6
D $7209 The sprite of the arc number 6 of the pentagram, which is used for the
. object type #N$85.
B $7209,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $720A,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $720B,$90,$06 #SPRITEDATA(pentagram-arc-6)

b $729B Sprite: Pentagram Arc 7
@ $729B label=Sprite_Pentagram_Arc_7
D $729B The sprite of the arc number 7 of the pentagram, which is used for the
. object type #N$86.
B $729B,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $729C,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $729D,$90,$06 #SPRITEDATA(pentagram-arc-7)

b $732D Sprite: Pentagram Arc 8
@ $732D label=Sprite_Pentagram_Arc_8
D $732D The sprite of the arc number 8 of the pentagram, which is used for the
. object type #N$87.
B $732D,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $732E,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $732F,$90,$06 #SPRITEDATA(pentagram-arc-8)

b $73BF Sprite: Floor Trap 1
@ $73BF label=Sprite_Floor_Trap_1
D $73BF The sprite of a trap in the floor, which is used for the object type
. #N$4A.
B $73BF,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $73C0,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $73C1,$80,$08 #SPRITEDATA(floor-trap-1)

b $7441 Sprite: Floor Trap 2
@ $7441 label=Sprite_Floor_Trap_2
D $7441 The sprite of a trap in the floor, which is used for the object type
. #N$4B.
B $7441,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7442,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7443,$80,$08 #SPRITEDATA(floor-trap-2)

b $74C3 Sprite: Crumbling Block 2
@ $74C3 label=Sprite_Crumbling_Block_2
D $74C3 The sprite of the second stage of the block that crumbles, which is used
. for the object type #N$89.
B $74C3,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $74C4,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $74C5,$D8,$08 #SPRITEDATA(crumbling-block-2)

b $759D Sprite: Crumbling Block 3
@ $759D label=Sprite_Crumbling_Block_3
D $759D The sprite of the third stage of the block that crumbles, which is used
. for the object type #N$8A.
B $759D,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $759E,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $759F,$D8,$08 #SPRITEDATA(crumbling-block-3)

b $7677 Sprite: Crumbling Block 4
@ $7677 label=Sprite_Crumbling_Block_4
D $7677 The sprite of the last stage of the block that crumbles, which is used
. for the object type #N$8B.
B $7677,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7678,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7679,$D8,$08 #SPRITEDATA(crumbling-block-4)

b $7751 Sprite: Spiked Head
@ $7751 label=Sprite_Spiked_Head
D $7751 The sprite of a spiked head, which is used for the object types #N$56,
. #N$5C and #N$5D.
B $7751,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7752,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7753,$C0,$08 #SPRITEDATA(spiked-head)

b $7813 Sprite: Imp 1
@ $7813 label=Sprite_Imp_1
D $7813 The sprite of the frame 1 of the imp, which is used for the object type
. #N$A8.
B $7813,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7814,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7815,$96,$06 #SPRITEDATA(imp-1)

b $78AB Sprite: Imp 2
@ $78AB label=Sprite_Imp_2
D $78AB The sprite of the frame 2 of the imp, which is used for the object type
. #N$A9.
B $78AB,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $78AC,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $78AD,$96,$06 #SPRITEDATA(imp-2)

b $7943 Sprite: Imp 3
@ $7943 label=Sprite_Imp_3
D $7943 The sprite of the frame 3 of the imp, which is used for the object type
. #N$AA.
B $7943,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7944,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7945,$AE,$06 #SPRITEDATA(imp-3)

b $79F3 Sprite: Imp 4
@ $79F3 label=Sprite_Imp_4
D $79F3 The sprite of the frame 4 of the imp, which is used for the object type
. #N$AB.
B $79F3,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $79F4,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $79F5,$A8,$06 #SPRITEDATA(imp-4)

b $7A9D Sprite: Wanderer 1
@ $7A9D label=Sprite_Wanderer_1
D $7A9D The sprite of the first sprite of the creature that wanders about, which
. faces one way, which is used for the object type #N$50.
B $7A9D,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7A9E,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7A9F,$C0,$08 #SPRITEDATA(wanderer-1)

b $7B5F Sprite: Wanderer 2
@ $7B5F label=Sprite_Wanderer_2
D $7B5F The sprite of the second sprite of the creature that wanders about,
. which faces the other way, which is used for the object type #N$51.
B $7B5F,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7B60,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7B61,$C0,$08 #SPRITEDATA(wanderer-2)

b $7C21 Sprite: Bat 1
@ $7C21 label=Sprite_Bat_1
D $7C21 The sprite of a frame of the bat that homes in on the player, which is
. used for the object type #N$A7.
B $7C21,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7C22,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7C23,$7E,$06 #SPRITEDATA(bat-1)

b $7CA1 Sprite: Bat 2
@ $7CA1 label=Sprite_Bat_2
D $7CA1 The sprite of a frame of the bat that homes in on the player, which is
. used for the object types #N$A4 and #N$A6.
B $7CA1,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7CA2,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7CA3,$90,$06 #SPRITEDATA(bat-2)

b $7D33 Sprite: Bat 3
@ $7D33 label=Sprite_Bat_3
D $7D33 The sprite of a frame of the bat that homes in on the player, which is
. used for the object type #N$A5.
B $7D33,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7D34,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7D35,$9C,$06 #SPRITEDATA(bat-3)

b $7DD1 Sprite: Bat 4
@ $7DD1 label=Sprite_Bat_4
D $7DD1 The sprite of a frame of the bat that homes in on the player, which is
. used for the object types #N$A0 and #N$A2.
B $7DD1,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7DD2,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7DD3,$B8,$08 #SPRITEDATA(bat-4)

b $7E8B Sprite: Bat 5
@ $7E8B label=Sprite_Bat_5
D $7E8B The sprite of a frame of the bat that homes in on the player, which is
. used for the object type #N$A1.
B $7E8B,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7E8C,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7E8D,$B8,$08 #SPRITEDATA(bat-5)

b $7F45 Sprite: Bat 6
@ $7F45 label=Sprite_Bat_6
D $7F45 The sprite of a frame of the bat that homes in on the player, which is
. used for the object type #N$A3.
B $7F45,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $7F46,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $7F47,$B8,$08 #SPRITEDATA(bat-6)

b $7FFF Sprite: Ghost 1
@ $7FFF label=Sprite_Ghost_1
D $7FFF The sprite of the first frame of the ghost, which is used for the object
. types #N$30 and #N$32.
B $7FFF,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8000,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8001,$9C,$06 #SPRITEDATA(ghost-1)

b $809D Sprite: Ghost 2
@ $809D label=Sprite_Ghost_2
D $809D The sprite of the second frame of the ghost, which is used for the
. object types #N$31 and #N$33.
B $809D,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $809E,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $809F,$9C,$06 #SPRITEDATA(ghost-2)

b $813B Sprite: Explosion 1
@ $813B label=Sprite_Explosion_1
D $813B The sprite of the first frame of an explosion, which is used for the
. object type #N$40.
B $813B,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $813C,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $813D,$38,$04 #SPRITEDATA(explosion-1)

b $8175 Sprite: Explosion 2
@ $8175 label=Sprite_Explosion_2
D $8175 The sprite of the second frame of an explosion, which is used for the
. object types #N$41 and #N$43.
B $8175,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8176,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8177,$4E,$06 #SPRITEDATA(explosion-2)

b $81C5 Sprite: Explosion 3
@ $81C5 label=Sprite_Explosion_3
D $81C5 The sprite of the third frame of an explosion, which is used for the
. object types #N$42, #N$44 and #N$45.
B $81C5,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $81C6,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $81C7,$66,$06 #SPRITEDATA(explosion-3)

b $822D Sprite: Explosion 4
@ $822D label=Sprite_Explosion_4
D $822D The sprite of the last frame of an explosion, which is used for the
. object types #N$46 and #N$47.
B $822D,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $822E,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $822F,$60,$06 #SPRITEDATA(explosion-4)

b $828F Sprite: Projectile 1
@ $828F label=Sprite_Projectile_1
D $828F The sprite of the first frame of a projectile, which is used for the
. object type #N$95.
B $828F,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8290,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8291,$40,$04 #SPRITEDATA(projectile-1)

b $82D1 Sprite: Projectile 2
@ $82D1 label=Sprite_Projectile_2
D $82D1 The sprite of the second frame of a projectile, which is used for the
. object type #N$96.
B $82D1,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $82D2,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $82D3,$40,$04 #SPRITEDATA(projectile-2)

b $8313 Sprite: Projectile 3
@ $8313 label=Sprite_Projectile_3
D $8313 The sprite of the third frame of a projectile, which is used for the
. object type #N$97.
B $8313,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8314,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8315,$40,$04 #SPRITEDATA(projectile-3)

b $8355 Font
@ $8355 label=Font
D $8355 The glyphs of the font, of #N$08 bytes each, for the codes #N$30 to
. #N$5A, so that the digits are first. #R$BAEA draws them. #R$BC66 and #R$BB48
. print with them.
D $8355 #UDGTABLE { #FONT(font) } UDGTABLE#
E $8355 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$6308 }
. { #KNIGHTLORE$6108 }
. { #MARTIANOIDS$C33C }
. { #NIGHTSHADE$6CDE }
. { #UNDERWURLDE$EEA4 }
. LIST#
B $8355,$08,$08 #UDG(#PC)
L $8355,$08,$2B

b $84AD Sprite: Spark
@ $84AD label=Sprite_Spark
D $84AD The sprite of a spark, which is used for the object types #N$10, #N$11
. and #N$59.
B $84AD,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $84AE,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $84AF,$90,$08 #SPRITEDATA(spark)

b $853F Unused
@ $853F label=UnusedData853F
D $853F Never used. It looks like the headers of some sprites that are empty,
. followed by a byte that may be a left-over.
B $853F,$08,$08

b $8547 Sprite: Unused Sprite 1
@ $8547 label=Sprite_Unused_Sprite_1
D $8547 Never used. It is a sprite of 4 bytes wide and 24 pixels high.
B $8547,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8548,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8549,$C0,$08 #SPRITEDATA(unused-sprite-1)

b $8609 Sprite: Cube
@ $8609 label=Sprite_Cube
D $8609 The sprite of a stone cube, which is used for the object types #N$3F and
. #N$52.
B $8609,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $860A,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $860B,$E0,$08 #SPRITEDATA(cube)

b $86EB Sprite: Spiked Ring
@ $86EB label=Sprite_Spiked_Ring
D $86EB The sprite of a spiked ring, which is used for the object types #N$1E
. and #N$1F.
B $86EB,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $86EC,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $86ED,$A8,$08 #SPRITEDATA(spiked-ring)

b $8795 Sprite: Stalactites
@ $8795 label=Sprite_Stalactites
D $8795 The sprite of stalactites, which is used for the object types #N$17 and
. #N$1C.
B $8795,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8796,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8797,$E0,$08 #SPRITEDATA(stalactites)

b $8877 Sprite: Player Icon
@ $8877 label=Sprite_Player_Icon
D $8877 The sprite of the small picture of the player that is shown for the
. lives, which is used for the object type #N$16.
B $8877,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8878,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8879,$44,$04 #SPRITEDATA(player-icon)

b $88BD Sprite: Stone Block
@ $88BD label=Sprite_Stone_Block
D $88BD The sprite of a stone block, which most of the blocks of the game use,
. which is used for the object types #N$0B, #N$4E, #N$4F, #N$54, #N$55, #N$57,
. #N$58, #N$5B, #N$79, #N$7A, #N$7B, #N$7C, #N$7D, #N$7E, #N$7F, #N$88, #N$8C,
. #N$8D, #N$8E and #N$8F.
B $88BD,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $88BE,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $88BF,$E8,$08 #SPRITEDATA(stone-block)

b $89A7 Sprite: Frame Bottom Piece
@ $89A7 label=Sprite_Frame_Bottom_Piece
D $89A7 The sprite of the piece of the frame of a room that goes at the bottom,
. which is used for the object type #N$3A.
B $89A7,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $89A8,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $89A9,$40,$04 #SPRITEDATA(frame-bottom-piece)

b $89E9 Sprite: Frame Cap
@ $89E9 label=Sprite_Frame_Cap
D $89E9 The sprite of the cap of the upright edge of the frame of a room, which
. is used for the object type #N$3B.
B $89E9,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $89EA,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $89EB,$2C,$04 #SPRITEDATA(frame-cap)

b $8A17 Sprite: Unused Sprite 2
@ $8A17 label=Sprite_Unused_Sprite_2
D $8A17 Never used. It is a sprite of 2 bytes wide and 16 pixels high.
B $8A17,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8A18,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8A19,$40,$04 #SPRITEDATA(unused-sprite-2)

b $8A59 Sprite: Frame Upright Edge
@ $8A59 label=Sprite_Frame_Upright_Edge
D $8A59 The sprite of the upright edge of the frame of a room, which is used for
. the object types #N$3C and #N$3D.
B $8A59,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8A5A,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8A5B,$40,$04 #SPRITEDATA(frame-upright-edge)

b $8A9B Sprite: Frame Sloping Edge
@ $8A9B label=Sprite_Frame_Sloping_Edge
D $8A9B The sprite of the sloping edge of the frame of a room, which is used for
. the object type #N$3E.
B $8A9B,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8A9C,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8A9D,$20,$04 #SPRITEDATA(frame-sloping-edge)

b $8ABD Sprite: Table
@ $8ABD label=Sprite_Table_Object
D $8ABD The sprite of a table, which is used for the object type #N$49.
B $8ABD,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8ABE,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8ABF,$154,$0A #SPRITEDATA(table)

b $8C13 Sprite: Well
@ $8C13 label=Sprite_Well
D $8C13 The sprite of a well, which is used for the object type #N$78.
B $8C13,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8C14,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8C15,$140,$0A #SPRITEDATA(well)

b $8D55 Sprite: Quest Object 1
@ $8D55 label=Sprite_Quest_Object_1
D $8D55 The sprite of the first of the objects of the quest, which is used for
. the object types #N$70, #N$71, #N$72 and #N$73.
B $8D55,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8D56,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8D57,$138,$08 #SPRITEDATA(quest-object-1)

b $8E8F Sprite: Quest Object 2
@ $8E8F label=Sprite_Quest_Object_2
D $8E8F The sprite of the second of the objects of the quest, which is taller,
. which is used for the object types #N$74, #N$75, #N$76 and #N$77.
B $8E8F,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $8E90,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $8E91,$198,$08 #SPRITEDATA(quest-object-2)

b $9029 Sprite: Helper
@ $9029 label=Sprite_Helper
D $9029 The sprite of the helper, which is used for the object type #N$5A.
B $9029,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $902A,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $902B,$90,$06 #SPRITEDATA(helper)

b $90BB Sprite: Pentagram Stone 1
@ $90BB label=Sprite_Pentagram_Stone_1
D $90BB The sprite of the pentagram stone number 1, which is used for the object
. types #N$90 and #N$98.
B $90BB,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $90BC,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $90BD,$90,$06 #SPRITEDATA(pentagram-stone-1)

b $914D Sprite: Pentagram Stone 2
@ $914D label=Sprite_Pentagram_Stone_2
D $914D The sprite of the pentagram stone number 2, which is used for the object
. types #N$91 and #N$99.
B $914D,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $914E,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $914F,$90,$06 #SPRITEDATA(pentagram-stone-2)

b $91DF Sprite: Pentagram Stone 3
@ $91DF label=Sprite_Pentagram_Stone_3
D $91DF The sprite of the pentagram stone number 3, which is used for the object
. types #N$92 and #N$9A.
B $91DF,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $91E0,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $91E1,$90,$06 #SPRITEDATA(pentagram-stone-3)

b $9271 Sprite: Pentagram Stone 4
@ $9271 label=Sprite_Pentagram_Stone_4
D $9271 The sprite of the pentagram stone number 4, which is used for the object
. types #N$93 and #N$9B.
B $9271,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9272,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9273,$90,$06 #SPRITEDATA(pentagram-stone-4)

b $9303 Sprite: Pentagram Stone 5
@ $9303 label=Sprite_Pentagram_Stone_5
D $9303 The sprite of the pentagram stone number 5, which is used for the object
. types #N$94 and #N$9C.
B $9303,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9304,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9305,$90,$06 #SPRITEDATA(pentagram-stone-5)

b $9395 Sprite: Empty
@ $9395 label=Sprite_Empty
D $9395 The sprite of a sprite with nothing in it, which is used for the object
. types #N$00, #N$01, #N$18, #N$19, #N$1A, #N$1B, #N$53, #N$5E, #N$5F, #N$60,
. #N$61, #N$62, #N$63, #N$64, #N$65, #N$66, #N$67, #N$68, #N$69, #N$6A, #N$6B,
. #N$6C, #N$6D, #N$6E, #N$6F, #N$9D, #N$9E and #N$9F.
B $9395,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9396,$01,$01 Height = #N(#PEEK(#PC)) pixels.

b $9397 Sprite: Player Body 3
@ $9397 label=Sprite_Player_Body_3
D $9397 The sprite of a frame of the body of the player, which is used for the
. object type #N$2A.
B $9397,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9398,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9399,$A2,$06 #SPRITEDATA(player-body-3)

b $943B Sprite: Player Body 2
@ $943B label=Sprite_Player_Body_2
D $943B The sprite of a frame of the body of the player, which is used for the
. object types #N$29 and #N$2B.
B $943B,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $943C,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $943D,$A2,$06 #SPRITEDATA(player-body-2)

b $94DF Sprite: Player Body 1
@ $94DF label=Sprite_Player_Body_1
D $94DF The sprite of a frame of the body of the player, which is used for the
. object type #N$28.
B $94DF,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $94E0,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $94E1,$A2,$06 #SPRITEDATA(player-body-1)

b $9583 Sprite: Player Body 5
@ $9583 label=Sprite_Player_Body_5
D $9583 The sprite of a frame of the body of the player, which is used for the
. object types #N$2D and #N$2F.
B $9583,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9584,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9585,$CC,$06 #SPRITEDATA(player-body-5)

b $9651 Sprite: Player Body 4
@ $9651 label=Sprite_Player_Body_4
D $9651 The sprite of a frame of the body of the player, which is used for the
. object type #N$2C.
B $9651,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9652,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9653,$CC,$06 #SPRITEDATA(player-body-4)

b $971F Sprite: Player Body 6
@ $971F label=Sprite_Player_Body_6
D $971F The sprite of a frame of the body of the player, which is used for the
. object type #N$2E.
B $971F,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9720,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9721,$CC,$06 #SPRITEDATA(player-body-6)

b $97ED Sprite: Player Legs 3
@ $97ED label=Sprite_Player_Legs_3
D $97ED The sprite of a frame of the legs of the player, which is used for the
. object type #N$22.
B $97ED,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $97EE,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $97EF,$5A,$06 #SPRITEDATA(player-legs-3)

b $9849 Sprite: Player Legs 2
@ $9849 label=Sprite_Player_Legs_2
D $9849 The sprite of a frame of the legs of the player, which is used for the
. object types #N$15, #N$1D, #N$21 and #N$23.
B $9849,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $984A,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $984B,$5A,$06 #SPRITEDATA(player-legs-2)

b $98A5 Sprite: Player Legs 1
@ $98A5 label=Sprite_Player_Legs_1
D $98A5 The sprite of a frame of the legs of the player, which is used for the
. object types #N$12, #N$14 and #N$20.
B $98A5,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $98A6,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $98A7,$5A,$06 #SPRITEDATA(player-legs-1)

b $9901 Sprite: Player Legs 5
@ $9901 label=Sprite_Player_Legs_5
D $9901 The sprite of a frame of the legs of the player, which is used for the
. object types #N$13, #N$25 and #N$27.
B $9901,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9902,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9903,$6C,$06 #SPRITEDATA(player-legs-5)

b $996F Sprite: Player Legs 4
@ $996F label=Sprite_Player_Legs_4
D $996F The sprite of a frame of the legs of the player, which is used for the
. object type #N$24.
B $996F,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9970,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9971,$6C,$06 #SPRITEDATA(player-legs-4)

b $99DD Sprite: Player Legs 6
@ $99DD label=Sprite_Player_Legs_6
D $99DD The sprite of a frame of the legs of the player, which is used for the
. object type #N$26.
B $99DD,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $99DE,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $99DF,$6C,$06 #SPRITEDATA(player-legs-6)

b $9A4B Sprite: Menu Frame Edge 1
@ $9A4B label=Sprite_Menu_Frame_Edge_1
D $9A4B The sprite of the left and right edges of the frame of the menu, which
. is used for the object type #N$02.
B $9A4B,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9A4C,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9A4D,$90,$06 #SPRITEDATA(menu-frame-edge-1)

b $9ADD Sprite: Menu Frame Edge End
@ $9ADD label=Sprite_Menu_Frame_Edge_End
D $9ADD The sprite of the end of the bottom and top edges of the frame of the
. menu, which is used for the object type #N$03.
B $9ADD,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9ADE,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9ADF,$60,$04 #SPRITEDATA(menu-frame-edge-end)

b $9B3F Sprite: Menu Frame Edge 2
@ $9B3F label=Sprite_Menu_Frame_Edge_2
D $9B3F The sprite of the bottom and top edges of the frame of the menu, which
. is used for the object type #N$04.
B $9B3F,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9B40,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9B41,$90,$06 #SPRITEDATA(menu-frame-edge-2)

b $9BD1 Sprite: Menu Frame Corner
@ $9BD1 label=Sprite_Menu_Frame_Corner
D $9BD1 The sprite of the corners of the frame of the menu, which is used for
. the object type #N$05.
B $9BD1,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9BD2,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9BD3,$90,$06 #SPRITEDATA(menu-frame-corner)

b $9C63 Sprite: Root Door
@ $9C63 label=Sprite_Root_Door
D $9C63 The sprite of a root door, which is used for the object type #N$06.
B $9C63,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9C64,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9C65,$14A,$06 #SPRITEDATA(root-door)

b $9DAF Sprite: Root Door Frame
@ $9DAF label=Sprite_Root_Door_Frame
D $9DAF The sprite of the frame of a root door, which is used for the object
. type #N$07.
B $9DAF,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9DB0,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9DB1,$A0,$04 #SPRITEDATA(root-door-frame)

b $9E51 Sprite: Round Pedestal
@ $9E51 label=Sprite_Round_Pedestal
D $9E51 The sprite of a round pedestal, which is used for the object types
. #N$0A, #N$48, #N$4C and #N$4D.
B $9E51,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9E52,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9E53,$C8,$08 #SPRITEDATA(round-pedestal)

b $9F1B Sprite: Root Wall 1
@ $9F1B label=Sprite_Root_Wall_1
D $9F1B The sprite of a piece of a wall of roots, which is used for the object
. type #N$0C.
B $9F1B,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9F1C,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9F1D,$AC,$04 #SPRITEDATA(root-wall-1)

b $9FC9 Sprite: Root Wall 2
@ $9FC9 label=Sprite_Root_Wall_2
D $9FC9 The sprite of a piece of a wall of roots, which is used for the object
. type #N$0D.
B $9FC9,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $9FCA,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $9FCB,$D4,$04 #SPRITEDATA(root-wall-2)

b $A09F Sprite: Root Wall 3
@ $A09F label=Sprite_Root_Wall_3
D $A09F The sprite of a piece of a wall of roots, which is used for the object
. type #N$0E.
B $A09F,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A0A0,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A0A1,$D4,$04 #SPRITEDATA(root-wall-3)

b $A175 Sprite: Root Wall 4
@ $A175 label=Sprite_Root_Wall_4
D $A175 The sprite of a piece of a wall of roots, which is used for the object
. type #N$0F.
B $A175,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A176,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A177,$C8,$04 #SPRITEDATA(root-wall-4)

b $A23F Sprite: Stone Wall 3
@ $A23F label=Sprite_Stone_Wall_3
D $A23F The sprite of a piece of a stone wall, which is used for the object type
. #N$36.
B $A23F,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A240,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A241,$68,$04 #SPRITEDATA(stone-wall-3)

b $A2A9 Sprite: Stone Wall 2
@ $A2A9 label=Sprite_Stone_Wall_2
D $A2A9 The sprite of a piece of a stone wall, which is used for the object type
. #N$35.
B $A2A9,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A2AA,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A2AB,$7C,$04 #SPRITEDATA(stone-wall-2)

b $A327 Sprite: Stone Wall 1
@ $A327 label=Sprite_Stone_Wall_1
D $A327 The sprite of a piece of a stone wall, which is used for the object type
. #N$34.
B $A327,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A328,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A329,$84,$04 #SPRITEDATA(stone-wall-1)

b $A3AD Sprite: Stone Wall 4
@ $A3AD label=Sprite_Stone_Wall_4
D $A3AD The sprite of a piece of a stone wall, which is used for the object type
. #N$37.
B $A3AD,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A3AE,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A3AF,$60,$04 #SPRITEDATA(stone-wall-4)

b $A40F Sprite: Stone Wall 5
@ $A40F label=Sprite_Stone_Wall_5
D $A40F The sprite of a piece of a stone wall, which is used for the object type
. #N$38.
B $A40F,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A410,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A411,$6C,$04 #SPRITEDATA(stone-wall-5)

b $A47D Sprite: Stone Door Frame
@ $A47D label=Sprite_Stone_Door_Frame
D $A47D The sprite of the frame of a stone door, which is used for the object
. type #N$09.
B $A47D,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A47E,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A47F,$D8,$06 #SPRITEDATA(stone-door-frame)

b $A557 Sprite: Stone Door
@ $A557 label=Sprite_Stone_Door
D $A557 The sprite of a stone door, which is used for the object type #N$08.
B $A557,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A558,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A559,$126,$06 #SPRITEDATA(stone-door)

b $A67F Sprite: Stone Wall End
@ $A67F label=Sprite_Stone_Wall_End
D $A67F The sprite of the end of a stone wall, which is used for the object type
. #N$39.
B $A67F,$01,$01 Width = #N(#PEEK(#PC)&$0F) bytes.
B $A680,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A681,$88,$04 #SPRITEDATA(stone-wall-end)

g $A709 Control Method
@ $A709 label=ControlMethod
D $A709 Selected by the menu at #R$BB74. Bits #N$01 and #N$02 hold the control
. method read by #R$BDF8:
. #TABLE(default,centre,centre)
. { =h Value | =h Control Method }
. { #N$00 | Keyboard }
. { #N$01 | Kempston Joystick }
. { #N$02 | Cursor Joystick }
. { #N$03 | Interface II }
. TABLE#
. Bit #N$03 is never set by the menu or by anything else, so the game never
. uses what it would do: it would make the menu flash the line that starts the
. game, make #R$BF66 read the action bit from one place lower, and make
. #R$C4C8 move the player by itself.
B $A709,$01

g $A70A Menu Pass Counter
@ $A70A label=MenuPassCounter
D $A70A Incremented on every pass of the menu loop at #R$BB74.
B $A70A,$01

g $A70B Unused
D $A70B Not referenced by the game.
B $A70B,$01

g $A70C Previous Control Method
@ $A70C label=PreviousControlMethod
D $A70C Copy of #R$A709 taken before the menu keys are read, used to notice a
. change of selection.
B $A70C,$01

g $A70D Random Seed
@ $A70D label=RandomSeed
D $A70D The game's random number source. It is stirred by every object handler
. and by the menu loop with the Z80 refresh register.
B $A70D,$01

g $A70E Helper Active Flag
@ $A70E label=HelperActiveFlag
D $A70E Set to #N$01 while the helper creature (object type #N$5A, see
. #R$CFD2) exists, so that only one is created at a time.
B $A70E,$01

g $A70F Pentagram Revealed Flag
@ $A70F label=PentagramRevealedFlag
D $A70F Set to #N$01 by #R$D13A once all four of the quest objects have been
. collected (their entries in the object store then have the types #N$74 to
. #N$77); from then on the eight pentagram arcs (object types #N$80 to #N$87)
. are brought into the room by #R$B097.
B $A70F,$01

g $A710 Dirty Rectangle Count
@ $A710 label=WipedAreaCount
D $A710 Number of screen rectangles queued on the stack by #R$B19E during the
. current redraw.
B $A710,$01

g $A711 Room Redraw Flag
@ $A711 label=RoomRedrawFlag
D $A711 Set to #N$01 when a new room has been built, so that the main loop
. redraws the whole room.
B $A711,$01

g $A712 Draw List Pointer
@ $A712 label=DrawingListPointer
D $A712 Address of the next entry of the redraw list at #R$B55A, used by
. #R$B19E.
W $A712,$02

g $A714 Drawing Work Count
@ $A714 label=DrawingWorkCount
D $A714 Number of objects drawn by #R$B58A in the current frame, plus the
. number of rectangles that #R$B19E then copied to the screen. The main loop
. uses it to pad the frame time.
B $A714,$01

g $A715 Frame Counter
@ $A715 label=FrameCounter
D $A715 Counts frames. Bit #N$00 of it is used by the object handlers to
. animate and to alternate behaviour every other frame.
W $A715,$02

g $A717 Saved Stack Pointer
@ $A717 label=SavedStackPointer
D $A717 Holds the stack pointer while #R$B3D3 reads sprite data with
. #REGsp.
W $A717,$02

g $A719 Sort Outer Pointer
@ $A719 label=FirstListPosition
D $A719 Position in the draw list of the object being compared by #R$B58A.
W $A719,$02

g $A71B Sort Inner Pointer
@ $A71B label=SecondListPosition
D $A71B Position in the draw list of the object it is being compared with.
W $A71B,$02

g $A71D Room Limit X
@ $A71D label=RoomSizeX
D $A71D Distance from the room centre (#N$80) to the wall on the x axis.
B $A71D,$01

g $A71E Room Limit Y
@ $A71E label=RoomSizeY
D $A71E Distance from the room centre (#N$80) to the wall on the y axis.
B $A71E,$01

g $A71F Room Floor Height
@ $A71F label=FloorHeight
D $A71F The height of the floor, below which objects cannot fall.
B $A71F,$01

g $A720 Inventory Redraw Flag
@ $A720 label=ObjectsCarriedChangedFlag
D $A720 Set to #N$01 when the carried objects change, so that #R$BA34 redraws
. the inventory.
B $A720,$01

g $A721 Lives
@ $A721 label=Lives
D $A721 Number of lives the player has left. It starts at #N$05, is lowered
. by #R$C2EC each time the player is sent back to the start and is raised by
. #R$CF68.
B $A721,$01

g $A722 Inventory
@ $A722 label=ObjectsCarried
D $A722 The objects the player is carrying: four entries of four bytes. Each
. holds the object type, the object flags and the address of the object's
. entry in the persistent object store at #R$D432. The first entry is only
. used while an object is being picked up or dropped, and is empty the rest of
. the time. The other three are the objects that are carried, and are the
. ones that #R$BA3D shows. A new object goes into the second entry; the older
. ones move along when it is picked up, and the one in the last entry is
. the one that #R$BF79 drops.
B $A722,$04,$04 The object that has just been picked up or dropped.
@ $A726 label=ObjectsCarried_Newest
B $A726,$04,$04 The object that has been carried for the least time.
B $A72A,$03,$03 The first three bytes of the object that has been carried for a
. time between the others.
@ $A72D label=ObjectsCarried_MiddleEnd
B $A72D,$01,$01 The last byte of the object that has been carried for a time
. between the others.
@ $A72E label=ObjectsCarried_Oldest
B $A72E,$03,$03 The first three bytes of the object that has been carried for
. the longest time.
@ $A731 label=ObjectsCarried_OldestEnd
B $A731,$01,$01 The last byte of the object that has been carried for the
. longest time.

g $A732 Font Pointer
@ $A732 label=FontPointer
D $A732 Address of the glyph table used by #R$BAEA.
W $A732,$02

g $A734 Frame Drawn Flag
@ $A734 label=BorderDrawnFlag
D $A734 Set to #N$01 once the frame around the menu or end screen has been
. drawn.
B $A734,$01

g $A735 Unused
@ $A735 label=UnusedValue
D $A735 Loaded into #REGhl by #R$BBBF but otherwise not used.
B $A735,$01

g $A736 Text Colour
@ $A736 label=TextAttribute
D $A736 The attribute used for text printed by #R$BC66 and #R$BC7A.
B $A736,$01

g $A737 Controls
@ $A737 label=ControlsPressed
D $A737 The state of the controls, written by #R$BDF8 and read by the player
. handlers.
. #TABLE(default,centre,centre)
. { =h Bit | =h Meaning }
. { #N$00 | Turn left }
. { #N$01 | Turn right }
. { #N$02 | Walk forward }
. { #N$03 | Jump }
. { #N$04 | Pick up or drop }
. { #N$06 | Fire }
. TABLE#
B $A737,$01

g $A738 Room Colour
@ $A738 label=RoomAttribute
D $A738 The colour of the room: the ink colour from the room data with the
. bright bit set, set by #R$C92C.
B $A738,$01

g $A739 Previous Vertical Speed
@ $A739 label=PreviousVerticalSpeed
D $A739 The vertical speed of the player from the last frame; it tells
. #R$C61D if the player landed from a fall.
B $A739,$01

g $A73A Template Table Pointer
@ $A73A label=TemplateTablePointer
D $A73A Address of the table of template addresses that #R$C92C uses while it
. builds a room. It starts at #R$6CE5 and can be moved on to the second half
. of the table at #R$6D23 by a group in the room data, though none do.
W $A73A,$02

g $A73C Cell Offset
@ $A73C label=CellOffset
D $A73C Offset that #R$C92C adds to the positions of the scenery objects as it
. builds a room: bit 0 adds #N$08 to x and bit 1 adds #N$08 to y, and the whole
. value is added to z. It is always zero.
B $A73C,$01

g $A73D Spawn Timer
@ $A73D label=SpawnTimer
D $A73D Countdown to the next random creature, see #R$CBAB.
B $A73D,$01

g $A73E Saved Stack Pointer Copy
D $A73E Written by #R$AFDD with the stack pointer but never read.
W $A73E,$02

g $A740 Action Key Held Flag
@ $A740 label=PickupDropPressedFlag
D $A740 Set while the pick up or drop key is being held, so that one press
. only does one thing.
B $A740,$01

g $A741 No Room To Drop Flag
@ $A741 label=NoRoomToDropFlag
D $A741 Set when there is no free space above the player to drop an object.
B $A741,$01

g $A742 Special Object Flag
@ $A742 label=SpecialObjectFlag
D $A742 Set by #R$CB89 when the room holds an object of one of the types
. #N$70 to #N$78 or #N$80 to #N$87; #R$CBAB then makes no random creatures.
B $A742,$01

g $A743 Fire Key Held Flag
@ $A743 label=FireKeyHeldFlag
D $A743 Set while the fire key is being held, so that one press fires once.
B $A743,$01

g $A744 Score
@ $A744 label=Score
D $A744 The score as six binary coded decimal digits, most significant byte
. first.
B $A744,$02,$02 The four most significant digits.
@ $A746 label=Score_LastByte
B $A746,$01,$01 The two least significant digits.

g $A747 Menu Tune Flag
@ $A747 label=TunePlayedFlag
D $A747 Set when the tune of the menu has been started, so that it is played
. only once, see #R$D69C.
B $A747,$01

g $A748 Footstep Counter
@ $A748 label=FootstepCounter
D $A748 Counts steps of the player to alternate the two footstep sounds.
B $A748,$01

g $A749 Sound Effect Counter
@ $A749 label=SoundEffectCounter
D $A749 Number of frames left of the current sound effect, see #R$D5F2.
B $A749,$01

g $A74A Sound Effect Type
@ $A74A label=SoundEffectType
D $A74A Selects the pitch sequence used by #R$D5F2.
B $A74A,$01

g $A74B Pentagram Stones Placed
@ $A74B label=PentagramStonesPlaced
D $A74B Number of the five pentagram stones that have reached their places on
. the pentagram. The game is won when it reaches #N$05.
B $A74B,$01

g $A74C Objects Collected
@ $A74C label=ObjectsCollected
D $A74C Number of the four objects that have been collected, see #R$CF68.
B $A74C,$01

g $A74D Quest Percentage
@ $A74D label=PercentComplete
D $A74D The percentage of the quest completed as binary coded decimal, shown
. on the end screen by #R$C6EA.
W $A74D,$02

g $A74F Visited Rooms
@ $A74F label=RoomsVisitedBitmap
D $A74F One bit for each of the #N$100 possible rooms, set by #R$C6CC when
. the player enters the room.
B $A74F,$20

g $A76F Object Table
@ $A76F label=ObjectsTable
D $A76F The #N$36 object records of the game, each #N$20 bytes long. A record
. whose type byte is #N$00 is free. The first two records hold the two halves
. of the player (see #R$A76F and #R$A78F); the rest hold the scenery,
. creatures and items of the current room, which #R$C92C fills from the last
. record downwards. The fields of a record are:
. #TABLE(default,centre,centre)
. { =h Offset | =h Contents }
. { #N$00 | Object type; indexes the sprite table at #R$6DD7 and the handler
. table at #R$AE2F }
. { #N$01 | Position on the x axis (the centre of the object) }
. { #N$02 | Position on the y axis (the centre of the object) }
. { #N$03 | Height above the floor (the bottom of the object) }
. { #N$04 | Half the size on the x axis }
. { #N$05 | Half the size on the y axis }
. { #N$06 | Size on the z axis }
. { #N$07 | Flags, see below }
. { #N$08 | Room the object belongs to (or the room a door leads to) }
. { #N$09 | Speed on the x axis }
. { #N$0A | Speed on the y axis }
. { #N$0B | Speed on the z axis }
. { #N$0C | Collision flags: bit #N$00 is set when the object hit
. something on the x axis, bit #N$01 on the y axis and bit #N$02 on the z
. axis (it is on the ground); bit #N$03 is set while it is jumping; the upper
. four bits count down the frames after entering a room }
. { #N$0D | Collision state flags used by the handlers }
. { #N$0E | Push from other objects on the x axis }
. { #N$0F | Push from other objects on the y axis }
. { #N$10 | Low byte of the address of the entry in the object store at
. #R$D432, or handler workspace }
. { #N$11 | High byte of the address of the entry in the object store }
. { #N$12 | Offset on the x axis from the projected position to the sprite }
. { #N$13 | Offset on the y axis from the projected position to the sprite }
. { #N$14 to #N$16 | Handler workspace }
. { #N$17 | Handler flags }
. { #N$18 | Width in bytes of the sprite last drawn }
. { #N$19 | Height of the sprite last drawn }
. { #N$1A | Screen x position of the sprite last drawn }
. { #N$1B | Screen y position of the sprite last drawn, counted from the
. bottom of the screen }
. { #N$1C to #N$1F | Copy of #N$18 to #N$1B from the previous frame }
. TABLE#
. The flags in byte #N$07 are:
. #TABLE(default,centre,centre)
. { =h Bit | =h Meaning }
. { #N$00 | Ignore the walls of the room }
. { #N$01 | The object is being moved, so it is ignored by the collision
. tests }
. { #N$02 | The object can be pushed }
. { #N$03 | The object can open doors (the player) }
. { #N$04 | The object needs drawing }
. { #N$05 | The object has moved and its old area needs restoring }
. { #N$06 | Mirror the sprite from left to right }
. { #N$07 | Flip the sprite upside down }
. TABLE#
B $A76F,$07,$07 The first seven bytes of the legs of the player.
@ $A776 label=ObjectsTable_Flags
B $A776,$01,$01 The flags of the legs of the player.
B $A777,$18,$18 The rest of the legs of the player.
B $A78F,$20,$20 The top half of the player.
@ $A7AF label=ObjectsTable_Projectiles
B $A7AF,$20,$20 The first of the two projectiles.
@ $A7CF label=ObjectsTable_SecondProjectile
B $A7CF,$20,$20 The second of the two projectiles.
@ $A7EF label=ObjectsTable_Creatures
B $A7EF,$20,$20 The first of the two creatures.
@ $A80F label=ObjectsTable_SecondCreature
B $A80F,$20,$20 The second of the two creatures.
@ $A82F label=ObjectsTable_RoomObjects
B $A82F,$05C0,$20 The objects of the room, which are built from the room data.
@ $ADEF label=ObjectsTable_FirstDoor
B $ADEF,$20,$20 The slot for the first door of the room.
@ $AE0F label=ObjectsTable_Last
B $AE0F,$20,$20 The last slot of the table.

w $AE2F Object Handler Table
@ $AE2F label=ObjectHandlerTable
D $AE2F One address for each of the #N$AC object types: the routine that
. #R$AF87 calls for every object of that type once a frame, with
. #REGix pointing at the object record. Each handler ends by returning to
. #R$B00C. The types are also the index into the table of sprites at
. #R$6DD7.
W $AE2F,$02,$02 Type #N$00: a free object, which does nothing, run by #R$C43F.
W $AE31,$02,$02 Type #N$01: a marker that something has to be erased, run by
. #R$C43F.
W $AE33,$08,$02 Types #N$02 to #N$05: the pieces of the frame of the menu, which
. are never made into objects, run by #R$C43F.
W $AE3B,$02,$02 Type #N$06: a root door, run by #R$C7AD.
W $AE3D,$02,$02 Type #N$07: a root door frame, run by #R$C789.
W $AE3F,$02,$02 Type #N$08: a stone door, run by #R$C7AD.
W $AE41,$02,$02 Type #N$09: a stone door frame, run by #R$C789.
W $AE43,$02,$02 Type #N$0A: a round pedestal, run by #R$CB4E.
W $AE45,$02,$02 Type #N$0B: a stone slab, run by #R$CB4E.
W $AE47,$08,$02 Types #N$0C to #N$0F: the pieces of a wall of roots, run by
. #R$C784.
W $AE4F,$04,$02 Types #N$10 to #N$11: a spark that flickers, run by #R$D1F5.
W $AE53,$0A,$02 Types #N$12 to #N$16: pictures of the player, which are not made
. into objects, run by #R$C43F.
W $AE5D,$02,$02 Type #N$17: stalactites, run by #R$C285.
W $AE5F,$08,$02 Types #N$18 to #N$1B: nothing, run by #R$C43F.
W $AE67,$02,$02 Type #N$1C: falling stalactites, run by #R$CD70.
W $AE69,$02,$02 Type #N$1D: not used, run by #R$C43F.
W $AE6B,$02,$02 Type #N$1E: a spiked ring, run by #R$C285.
W $AE6D,$02,$02 Type #N$1F: not used, run by #R$C43F.
W $AE6F,$10,$02 Types #N$20 to #N$27: the legs of the player, run by #R$C440.
W $AE7F,$10,$02 Types #N$28 to #N$2F: the body of the player, run by #R$C5D3.
W $AE8F,$08,$02 Types #N$30 to #N$33: a ghost, run by #R$CC4B.
W $AE97,$02,$02 Type #N$34: the pieces of a stone wall, run by #R$C784.
W $AE99,$08,$02 Types #N$35 to #N$38: the pieces of a stone wall, run by
. #R$C77F.
W $AEA1,$02,$02 Type #N$39: the end of a stone wall, run by #R$C74B.
W $AEA3,$04,$02 Types #N$3A to #N$3B: the pieces of the frame of a room, which
. are never made into objects, run by #R$C43F.
W $AEA7,$02,$02 Type #N$3C: a piece of the frame of a room, which is never made
. into an object, and has the handler of a projectile, run by #R$C1C5.
W $AEA9,$04,$02 Types #N$3D to #N$3E: the pieces of the frame of a room, which
. are never made into objects, run by #R$C43F.
W $AEAD,$02,$02 Type #N$3F: a stone cube that falls, run by #R$CD81.
W $AEAF,$0E,$02 Types #N$40 to #N$46: the frames of an explosion, run by
. #R$C111.
W $AEBD,$02,$02 Type #N$47: the frames of an explosion, run by #R$C11D.
W $AEBF,$02,$02 Type #N$48: a round pedestal that falls, run by #R$CD81.
W $AEC1,$02,$02 Type #N$49: a table, run by #R$CD7C.
W $AEC3,$04,$02 Types #N$4A to #N$4B: a trap in the floor, run by #R$C285.
W $AEC7,$02,$02 Type #N$4C: a pedestal, run by #R$CB4E.
W $AEC9,$02,$02 Type #N$4D: a raised pedestal, run by #R$CB51.
W $AECB,$02,$02 Type #N$4E: a block that sinks, run by #R$CDA0.
W $AECD,$02,$02 Type #N$4F: a block that falls, run by #R$CD81.
W $AECF,$04,$02 Types #N$50 to #N$51: a creature that wanders about, run by
. #R$D1FD.
W $AED3,$02,$02 Type #N$52: a stone cube, run by #R$CB4E.
W $AED5,$02,$02 Type #N$53: nothing, run by #R$C43F.
W $AED7,$02,$02 Type #N$54: a lift, run by #R$CDBB.
W $AED9,$02,$02 Type #N$55: a block that bobs, run by #R$CE31.
W $AEDB,$02,$02 Type #N$56: a spiked head that bobs, run by #R$CE9A.
W $AEDD,$02,$02 Type #N$57: a block that slides along x, run by #R$CEA3.
W $AEDF,$02,$02 Type #N$58: a block that slides along y, run by #R$CEDD.
W $AEE1,$02,$02 Type #N$59: a spark that wanders about, run by #R$CF22.
W $AEE3,$02,$02 Type #N$5A: the helper, run by #R$D0AC.
W $AEE5,$02,$02 Type #N$5B: a block, run by #R$CD75.
W $AEE7,$02,$02 Type #N$5C: a spiked head that slides along x, run by #R$CEA0.
W $AEE9,$02,$02 Type #N$5D: a spiked head that slides along y, run by #R$CEDA.
W $AEEB,$24,$02 Types #N$5E to #N$6F: nothing, run by #R$C43F.
W $AF0F,$10,$02 Types #N$70 to #N$77: the four objects of the quest, before and
. after they are collected, run by #R$CF68.
W $AF1F,$02,$02 Type #N$78: a well that makes a helper, run by #R$CFD2.
W $AF21,$0E,$02 Types #N$79 to #N$7F: blocks that do nothing, run by #R$CF14.
W $AF2F,$10,$02 Types #N$80 to #N$87: the arcs of the pentagram, run by #R$CF14.
W $AF3F,$08,$02 Types #N$88 to #N$8B: the stages of a block that crumbles, run
. by #R$D2AD.
W $AF47,$02,$02 Type #N$8C: a block that pushes along x, run by #R$D2DE.
W $AF49,$02,$02 Type #N$8D: a block that pushes back along x, run by #R$D2E9.
W $AF4B,$02,$02 Type #N$8E: a block that pushes along y, run by #R$D2F4.
W $AF4D,$02,$02 Type #N$8F: a block that pushes back along y, run by #R$D2FF.
W $AF4F,$0A,$02 Types #N$90 to #N$94: the stones that go on the pentagram, run
. by #R$CD16.
W $AF59,$06,$02 Types #N$95 to #N$97: the frames of a projectile, run by
. #R$C1C5.
W $AF5F,$0A,$02 Types #N$98 to #N$9C: the stones when they are in place, run by
. #R$CB4E.
W $AF69,$06,$02 Types #N$9D to #N$9F: nothing, run by #R$CB4E.
W $AF6F,$10,$02 Types #N$A0 to #N$A7: a bat that homes in on the player, run by
. #R$CC4B.
W $AF7F,$08,$02 Types #N$A8 to #N$AB: a creature that wanders about, run by
. #R$D251.

c $AF87 Run Game
@ $AF87 label=RunGame
D $AF87 The game proper. Clears the game variables and the object table, builds
. the lookup tables, runs the menu, then plays the game. Every pass of the main
. loop runs the handler of each object, builds the list of the objects that need
. drawing, redraws them and paces the frame.
.
. #PUSHS #UDGTABLE { =h After the first frame of the game }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #SIM(start=$AFBF,stop=$AFDA,sp=$5E00)
. #SIM(start=$AFDA,stop=$B087,sp=$5E00)
. #SCR$02(run-game) } UDGTABLE# #POPS
N $AF87 Clear the game's memory.
  $AF87,$01 Clear #REGa.
  $AF88,$02 Set the border to black, and the speaker off, by writing #N$00 to
. the ULA.
  $AF8A,$03 Point #REGhl at the first game variable, #R$A709.
  $AF8D,$03 Set a counter in #REGbc of #N($0726) bytes, which covers the
. variables and the object table.
  $AF90,$03 Call #R$CB77 to clear the variables and the object table.
@ $AF93 label=RunGame_Restart
  $AF93,$03 Point #REGhl at the second game variable, #R$A70E.
  $AF96,$03 Set a counter in #REGbc of #N($0721) bytes, which ends at the same
. address.
  $AF99,$03 Call #R$CB77 to clear the area from #R$A70E onwards a second time
. (this repeats the first clear).
  $AF9C,$03 Call #R$CB5C to clear the screen.
  $AF9F,$02 Set #REGa to the colour bright magenta ink on a black paper.
  $AFA1,$03 Call #R$CB6A to fill the attribute file with it.
  $AFA4,$03 Call #R$B29A to build the lookup tables which are used to shift and
. to mirror sprites.
N $AFA7 Start with five lives and stir the random seed with the refresh
. register.
  $AFA7,$05 Write #N$05 to #R$A721.
  $AFAC,$02 Fetch the refresh register.
  $AFAE,$01 Stash the refresh register in #REGb.
  $AFAF,$03 Fetch #R$A70D.
  $AFB2,$01 Add the refresh register to it.
  $AFB3,$03 Write it back to #R$A70D.
N $AFB6 Show the menu, play the tune and set up the new game.
.
. #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune)))
  $AFB6,$03 Call #R$BB74 to run the title screen and the menu until the player
. starts the game.
  $AFB9,$03 Point #REGde at the start tune, #R$D833.
  $AFBC,$03 Call #R$D6B5 to play it.
  $AFBF,$03 Call #R$D16F to put the objects of the quest back in the object
. store.
  $AFC2,$03 Call #R$C2CE to prepare the template of the player's starting
. position.
@ $AFC5 label=RunGame_NextLife
N $AFC5 Put the player at the start of the game, which costs a life.
  $AFC5,$03 Call #R$C2EC to copy the template into the first two object records
. and take a life, ending the game when none are left.
@ $AFC8 label=RunGame_NewRoom
N $AFC8 Build the room the player is in.
  $AFC8,$03 Call #R$B115 to save the state of the objects of the last room in
. the object store.
  $AFCB,$03 Call #R$C6B6 to clear the buffer, build the scenery of the room and
. place the player at the door they came through.
  $AFCE,$03 Call #R$B097 to bring the objects that are stored for this room into
. it.
  $AFD1,$03 Call #R$CB89 to find out if the room has a special object in it,
. which stops random creatures from being made.
  $AFD4,$03 Call #R$BB14 to print the score.
  $AFD7,$03 Call #R$CC31 to set how long to wait before a creature is made.
@ $AFDA label=RunGame_MainLoop
N $AFDA Start of a frame: maybe create a creature, then run the handler of each
. object.
  $AFDA,$03 Call #R$CBAB to create a random creature when it is time to.
  $AFDD,$04 Point #REGix at the first object record, #R$A76F.
@ $AFE1 label=RunGame_NextObject
  $AFE1,$04 Stack #R$B00C as the address that the handler returns to.
  $AFE5,$03 Point #REGbc at the handler table, #R$AE2F.
  $AFE8,$0C Copy the width and the height of the sprite drawn in the last frame
. to the previous width and height.
  $AFF4,$0C Copy the screen position of the sprite drawn in the last frame to
. the previous position.
  $B000,$03 Fetch the type of the object.
@ $B003 label=RunGame_JumpViaTable
  $B003,$04 Point #REGhl at the entry of the table at #REGbc that belongs to the
. index in #REGl: the address of the entry is #REGbc plus twice the index.
  $B007,$04 Fetch the address of the handler.
  $B00B,$01 Jump to the handler, which returns to #R$B00C.
@ $B00C label=RunGame_ObjectDone
N $B00C The handler has run: stir the random seed with the refresh register and
. a byte of the ROM.
  $B00C,$02 Fetch the refresh register.
  $B00E,$01 Stash the refresh register in #REGb.
  $B00F,$03 Fetch the low byte of #R$A715.
  $B012,$01 Add one to it.
  $B013,$03 Point #REGhl at the byte of the ROM with that address.
  $B016,$01 Add the byte of the ROM to the frame count.
  $B017,$01 Add the refresh register to it.
  $B018,$01 Stash the result in #REGb.
  $B019,$03 Fetch #R$A70D.
  $B01C,$01 Add the stirred value to it.
  $B01D,$03 Write it back to #R$A70D.
N $B020 Move on to the next object record, until all #N$36 have been run.
  $B020,$05 Move #REGix on to the next record, which is #N$20 bytes further on.
  $B025,$03 Copy #REGix to #REGhl (using the stack).
  $B028,$03 Point #REGde at the end of the object table, #R$AE2F.
  $B02B,$06 Jump to #R$AFE1 if there are more records to run.
@ $B031 label=RunGame_FrameEnd
N $B031 All the handlers have run: count the frame, draw the objects and check
. for the pause keys.
  $B031,$07 Increment the frame counter in #R$A715.
  $B038,$03 Call #R$B531 to build the list of the objects that need drawing.
  $B03B,$03 Call #R$B19E to restore the background behind the objects that have
. moved and to draw the objects.
  $B03E,$04 Write the stack pointer to #R$A73E (nothing reads it).
  $B042,$03 Call #R$B4E0 to pause the game when the pause keys are pressed.
N $B045 Pace the frame: the less drawing was done, the longer the delay.
  $B045,$08 Set #REGb to six less the amount of drawing done, which is held in
. #R$A714.
  $B04D,$03 Jump to #R$B05C if there were more than six.
  $B050,$02 Jump to #R$B05C if there were six.
@ $B052 label=RunGame_Delay
  $B052,$03 Set the length of a delay loop in #REGhl.
@ $B055 label=RunGame_DelayLoop
  $B055,$05 Count #REGhl down to zero.
  $B05A,$02 Decrease the number of delay loops and repeat until it is zero.
@ $B05C label=RunGame_CheckRedraw
N $B05C Redraw the whole room when it has just been built.
  $B05C,$06 Jump to #R$B084 if the room does not need redrawing.
  $B062,$04 Write #N$00 to #R$A711.
  $B066,$03 Fetch the colour of the room from #R$A738.
  $B069,$03 Call #R$CB6A to fill the attribute file with it.
  $B06C,$03 Call #R$BA3D to draw the inventory.
  $B06F,$03 Call #R$BCE5 to draw the frame around the room.
  $B072,$03 Call #R$C29A to draw the lives.
  $B075,$03 Call #R$B178 to copy the buffer to the screen.
  $B078,$03 Call #R$BB14 to print the score.
  $B07B,$03 Call #R$BF0D to clear the flags that say that an object has moved.
  $B07E,$06 Start the sound effect for a new room by writing #N$04 to #R$A749
. and #N$00 to #R$A74A.
@ $B084 label=RunGame_FrameSound
  $B084,$03 Call #R$D5F2 to play the next step of the sound effect.
N $B087 Start again from the beginning of the room if the player has gone.
  $B087,$04 Point #REGix at the first object record, #R$A76F.
  $B08B,$09 Jump to #R$AFC5 if both of the object records of the player are
. free.
  $B094,$03 Jump to the main loop at #R$AFDA.

c $B097 Load Room Objects
@ $B097 label=LoadRoomObjects
D $B097 Looks through the object store for objects that belong in the current
. room, and makes an object record in the object table for each one it finds.
. The pentagram arcs are only made once the pentagram has been revealed. An
. object that lands inside another one is lifted up until it is clear.
D $B097 The store is a table of #N$12 entries of #N$10 bytes each, which starts
. at #R$D432.
N $B097 Search the object store for the objects of this room.
  $B097,$04 Point #REGiy at the entry before the first one in the object store.
  $B09B,$02 Set a counter in #REGb of #N$12 store entries.
@ $B09D label=LoadRoomObjects_Loop
  $B09D,$03 Set the size of a store entry in #REGde.
  $B0A0,$03 Fetch the room that the player is in from offset #N$08 of the first
. record of #R$A76F.
  $B0A3,$01 Stash the room in #REGc.
@ $B0A4 label=LoadRoomObjects_NextEntry
  $B0A4,$02 Move #REGiy to the next store entry.
  $B0A6,$06 Jump to #R$B0B2 if the entry is empty.
  $B0AC,$06 Jump to #R$B0B5 if the object belongs to this room.
@ $B0B2 label=LoadRoomObjects_SkipEntry
  $B0B2,$02 Decrease the entry counter and look at the next entry until there
. are none left.
  $B0B4,$01 Return.
N $B0B5 Find a free object record for the object.
@ $B0B5 label=LoadRoomObjects_FindRecord
  $B0B5,$03 Point #REGhl at the seventh object record, which is the first that
. is not used for the player or the fixed objects.
  $B0B8,$03 Set the size of an object record in #REGde.
  $B0BB,$01 Stash the entry counter and the room number on the stack.
  $B0BC,$02 Set a counter in #REGb of #N$30 records.
@ $B0BE label=LoadRoomObjects_TestRecord
  $B0BE,$04 Jump to #R$B0C7 if the record is free.
  $B0C2,$01 Move #REGhl to the next record.
  $B0C3,$02 Decrease the record counter and test the next record until none are
. left.
  $B0C5,$02 Restore the entry counter and the room number from the stack and
. return, as every record is in use.
N $B0C7 The pentagram arcs are only made when the pentagram has been revealed.
@ $B0C7 label=LoadRoomObjects_FreeRecord
  $B0C7,$01 Point #REGde at the free record.
  $B0C8,$03 Fetch the type of the stored object.
  $B0CB,$02,b$01 Keep only the type group.
  $B0CD,$04 Jump to #R$B0D7 if the object is not an arc.
  $B0D1,$06 Skip this object by jumping to #R$B111 if the pentagram has not been
. revealed.
N $B0D7 Copy the stored object into the free record.
@ $B0D7 label=LoadRoomObjects_Copy
  $B0D7,$04 Flag the stored object as needing to be drawn.
  $B0DB,$03 Copy #REGiy to #REGhl (using the stack).
  $B0DE,$03 Set a counter in #REGbc of #N$10 bytes.
  $B0E1,$02 Copy the stored entry into the record.
N $B0E3 Remember which store entry the object came from, and clear the workspace
. of the record.
  $B0E3,$03 Copy #REGiy to #REGhl (using the stack).
  $B0E6,$01 Swap so that #REGhl points to the record and #REGde to the store
. entry.
  $B0E7,$03 Write the address of the store entry to the record, in the fields at
. offsets #N$10 and #N$11.
  $B0EA,$01 Move #REGhl to the workspace of the record.
  $B0EB,$02 Set a counter in #REGb of #N$0E bytes.
  $B0ED,$01 Clear #REGa.
@ $B0EE label=LoadRoomObjects_ClearWorkspace
  $B0EE,$04 Write #N$00 to the workspace and move on, until all the bytes are
. done.
  $B0F2,$03 Set #REGde to #N$FFE0, which is minus the size of a record.
  $B0F5,$01 Move #REGhl back to the start of the record.
  $B0F6,$03 Copy #REGhl to #REGix (using the stack).
N $B0F9 Lift the object until it is not inside any other object, unless it is an
. arc.
  $B0F9,$03 Fetch the type of the object.
  $B0FC,$02,b$01 Keep only the type group.
  $B0FE,$04 Jump to #R$B111 if the object is an arc.
@ $B102 label=LoadRoomObjects_TestClear
  $B102,$03 Call #R$BF1B to see if the object is inside another one.
  $B105,$02 Jump to #R$B111 if it is not.
  $B107,$03 Fetch the height of the object.
  $B10A,$02 Add #N$0C to it.
  $B10C,$03 Write it back.
  $B10F,$02 Jump back to #R$B102 to test the object again.
@ $B111 label=LoadRoomObjects_Next
  $B111,$01 Restore the entry counter and the room number from the stack.
  $B112,$02 Decrease the entry counter and look at the next store entry until
. there are none left.
  $B114,$01 Return.

c $B115 Save Room Objects
@ $B115 label=SaveRoomObjects
D $B115 Copies the first #N$10 bytes of every object record back to the object
. store entry that has the same type, so that the state of the objects is
. remembered when the player leaves the room.
N $B115 Go through the object records, from the seventh.
  $B115,$04 Point #REGiy at the record before the seventh one.
  $B119,$02 Set a counter in #REGc of #N$30 records.
@ $B11B label=SaveRoomObjects_NextRecord
  $B11B,$03 Set the size of an object record in #REGde.
  $B11E,$02 Move #REGiy to the next record.
  $B120,$03 Fetch the type of the object.
N $B123 Look for the store entry that has the same type.
  $B123,$03 Point #REGhl at #R$D432.
  $B126,$03 Set the size of a store entry in #REGde.
  $B129,$02 Set a counter in #REGb of #N$12 entries.
@ $B12B label=SaveRoomObjects_TestEntry
  $B12B,$01 Compare the type of the object with the type of the entry.
  $B12C,$02 Jump to #R$B135 if they match.
  $B12E,$01 Move #REGhl to the next entry.
  $B12F,$02 Decrease the entry counter and test the next entry until none are
. left.
@ $B131 label=SaveRoomObjects_Count
  $B131,$01 Decrease the record counter.
  $B132,$02 Jump to #R$B11B if there are more records to look at.
  $B134,$01 Return.
N $B135 Copy the record into the store entry.
@ $B135 label=SaveRoomObjects_Copy
  $B135,$01 Point #REGde at the store entry.
  $B136,$03 Copy #REGiy to #REGhl (using the stack).
  $B139,$01 Stash the record counter on the stack.
  $B13A,$03 Set a counter in #REGbc of #N$10 bytes.
  $B13D,$02 Copy the first #N$10 bytes of the object to the store entry.
  $B13F,$01 Restore the record counter.
  $B140,$03 Set the size of an object record in #REGde.
  $B143,$02 Jump to #R$B131 to move on to the next record.

c $B145 Copy Score To Screen
@ $B145 label=CopyScoreToScreen
D $B145 Copies the part of the buffer that holds the score to the screen. It is
. #N$06 bytes wide and #N$08 pixel lines tall, and its bottom left corner is at
. (#N$B8, #N$09).
N $B145 Work out the addresses of the area in the screen and in the buffer.
  $B145,$03 Set #REGb to the y co-ordinate and #REGc to the x co-ordinate of the
. area.
  $B148,$03 Call #R$B394 to get the screen address in #REGde.
  $B14B,$03 Call #R$B37F to get the buffer address in #REGbc.
  $B14E,$02 Copy the buffer address to #REGhl.
  $B150,$02 Set a counter in #REGc of #N$08 lines.
@ $B152 label=CopyScoreToScreen_Loop
N $B152 Copy a line of #N$06 bytes.
  $B152,$01 Stash the line counter on the stack.
  $B153,$01 Stash the screen address on the stack.
  $B154,$03 Set a counter in #REGbc of #N$06 bytes.
  $B157,$02 Copy the line to the screen.
  $B159,$01 Restore the screen address from the stack.
N $B15A Move up to the next pixel line of the screen.
  $B15A,$01 Move up one pixel line.
  $B15B,$02 Invert the high byte of the screen address to test its pixel line
. bits.
  $B15D,$02,b$01 Keep only the pixel line bits.
  $B15F,$02 Jump to #R$B16B if the line is still in the same character row.
  $B161,$04 Move up one character row.
  $B165,$02 Jump to #R$B16B if that has crossed into the third above.
  $B167,$04 Otherwise cancel the effect of the borrow on the third, by adding
. #N$08 to the high byte.
@ $B16B label=CopyScoreToScreen_Next
N $B16B Move on to the next line of the buffer.
  $B16B,$01 Restore the line counter from the stack.
  $B16C,$08 Add #N$1A to #REGhl, which takes it from the end of the line just
. copied to the start of the next (a line is #N$20 bytes long).
  $B174,$01 Decrease the line counter.
  $B175,$02 Jump to #R$B152 until all the lines have been copied.
  $B177,$01 Return.

c $B178 Update Screen
@ $B178 label=UpdateScreen
D $B178 Copies the whole buffer to the screen. The buffer is held with its
. bottom line first, so the copy starts with the bottom line of the screen and
. works its way up.
E $B178 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE85 }
. LIST#
.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$B178 }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #SIM(start=$AFBF,stop=$AFDA,sp=$5E00)
. #SIM(start=$AFDA,stop=$B069,sp=$5E00)
. #SCR$01(update-screen-before)
. | #SIM(start=$B069,stop=$B06C,sp=$5E00)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$01(update-screen-after) } UDGTABLE# #POPS
N $B178 Set up the addresses of the buffer and of the bottom line of the screen.
  $B178,$03 Point #REGhl at the start of the buffer, #R$D88F.
  $B17B,$03 Point #REGde at the bottom line of the screen, #N$57E0.
  $B17E,$02 Set a counter in #REGc of #N$C0 lines.
@ $B180 label=UpdateScreen_Loop
  $B180,$01 Stash the line counter on the stack.
  $B181,$01 Stash the screen address on the stack.
  $B182,$03 Set a counter in #REGbc of #N$20 bytes.
  $B185,$02 Copy the line to the screen.
  $B187,$01 Restore the screen address from the stack.
N $B188 Move up to the next pixel line of the screen.
  $B188,$01 Move up one pixel line.
  $B189,$02 Invert the high byte of the screen address to test its pixel line
. bits.
  $B18B,$02,b$01 Keep only the pixel line bits.
  $B18D,$02 Jump to #R$B199 if the line is still in the same character row.
  $B18F,$04 Move up one character row.
  $B193,$02 Jump to #R$B199 if that has crossed into the third above.
  $B195,$04 Otherwise cancel the effect of the borrow on the third, by adding
. #N$08 to the high byte.
@ $B199 label=UpdateScreen_Next
  $B199,$01 Restore the line counter from the stack.
  $B19A,$01 Decrease the line counter.
  $B19B,$02 Jump to #R$B180 until all the lines have been copied.
  $B19D,$01 Return.

c $B19E Draw Changed Objects
@ $B19E label=DrawChangedObjects
D $B19E Redraws the objects that need it. For each object that has moved, this
. works out the rectangle that covers the old and the new positions of its
. sprite, clears it in the buffer and queues it on the stack. The objects are
. then sorted and drawn into the buffer, and finally each queued rectangle is
. copied to the screen.
D $B19E When the room has just been built the whole room is redrawn instead, so
. no rectangles are queued.
E $B19E View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D59F }
. { #ALIENEIGHT$CEAB }
. LIST#
N $B19E Start with no rectangles queued, unless the whole room needs drawing.
  $B19E,$04 Write #N$00 to #R$A710.
  $B1A2,$02 Stash #REGix on the stack.
  $B1A4,$07 Jump to #R$B252 if the room has just been built.
  $B1AB,$06 Point #R$A712 at the start of the list of objects to draw, #R$B55A.
@ $B1B1 label=DrawChangedObjects_NextEntry
N $B1B1 Take the next object from the list and skip it if it has not moved.
  $B1B1,$03 Fetch the list pointer from #R$A712.
  $B1B4,$05 Fetch the object number and move on the list pointer.
  $B1B9,$05 Jump to #R$B252 if the end of the list has been reached.
  $B1BE,$03 Call #R$B520 to get the address of the object record.
  $B1C1,$03 Copy it to #REGix (using the stack).
  $B1C4,$06 Jump to #R$B1B1 if the object has not moved.
  $B1CA,$04 Clear the flag that says it has moved.
N $B1CE Find the left edge of the rectangle: the lower of the old and new x
. positions.
  $B1CE,$09 Jump to #R$B248 if the new x position is lower than the previous
. one.
  $B1D7,$03 Use the previous x position as the left edge.
@ $B1DA label=DrawChangedObjects_RightEdge
N $B1DA Find the right edge, in bytes: the larger of the old and new right
. edges.
  $B1DA,$06 Divide the previous x position by eight, to get its byte column.
  $B1E0,$02,b$01 Keep only the five bits of the column.
  $B1E2,$04 Add the previous width to get the old right edge.
  $B1E6,$06 Divide the new x position by eight, to get its byte column.
  $B1EC,$02,b$01 Keep only the five bits of the column.
  $B1EE,$03 Add the new width to get the new right edge.
  $B1F1,$01 Compare it with the old right edge.
  $B1F2,$02 Jump to #R$B1F5 if the new right edge is lower.
  $B1F4,$01 Use the new right edge.
@ $B1F5 label=DrawChangedObjects_Width
  $B1F5,$04 Divide the left edge by eight to get its byte column.
  $B1F9,$02,b$01 Keep only the five bits of the column.
  $B1FB,$01 Stash the left column in #REGb.
  $B1FC,$03 Subtract it from the right edge to get the width of the rectangle in
. bytes, in #REGh.
N $B1FF Find the bottom edge: the lower of the old and new y positions.
  $B1FF,$08 Jump to #R$B24D if the new y position is lower than the previous
. one.
  $B207,$03 Use the previous y position as the bottom edge.
@ $B20A label=DrawChangedObjects_TopEdge
N $B20A Find the top edge: the higher of the old and new tops, and so the
. height.
  $B20A,$07 Add the previous height to the previous y position to get the old
. top.
  $B211,$06 Add the new height to the new y position to get the new top.
  $B217,$01 Compare it with the old top.
  $B218,$02 Jump to #R$B21B if the new top is higher or the same.
  $B21A,$01 Use the old top.
@ $B21B label=DrawChangedObjects_Height
  $B21B,$01 Subtract the bottom edge to get the height of the rectangle.
  $B21C,$01 Set the height in #REGl.
N $B21D Clip the rectangle to the top of the screen, and ignore it when it is
. wholly off the screen.
  $B21D,$01 Fetch the bottom edge.
  $B21E,$04 Jump to #R$B1B1 if the rectangle is below the screen and so not
. visible.
  $B222,$01 Add the height to get the top edge.
  $B223,$02 Subtract #N$C0 to see how far it is above the screen.
  $B225,$02 Jump to #R$B22B if it is not above the screen.
  $B227,$04 Reduce the height by that amount, so the rectangle ends at the top
. of the screen.
@ $B22B label=DrawChangedObjects_Queue
N $B22B Queue the rectangle on the stack.
  $B22B,$03 Call #R$B394 to get the screen address of the rectangle in #REGde.
  $B22E,$03 Call #R$B37F to get the buffer address in #REGbc.
  $B231,$06 Swap so that #REGhl is the buffer address, #REGb the width and #REGc
. the height.
  $B237,$07 Count the rectangle in #R$A710.
  $B23E,$03 Stash the width and height, the screen address and the buffer
. address on the stack.
  $B241,$01 Set #REGa to #N$00.
  $B242,$03 Call #R$B6DD to clear the rectangle in the buffer.
  $B245,$03 Jump back to #R$B1B1 to look at the next object.
@ $B248 label=DrawChangedObjects_NewLeft
  $B248,$05 Use the new x position as the left edge, and carry on at #R$B1DA.
@ $B24D label=DrawChangedObjects_NewBottom
  $B24D,$05 Use the new y position as the bottom edge, and carry on at #R$B20A.

@ $B252 label=DrawChangedObjects_Draw
N $B252 Draw the objects, then copy the queued rectangles to the screen.
  $B252,$03 Call #R$B58A to sort the objects and draw them into the buffer.
  $B255,$03 Call #R$BA34 to redraw the inventory if it has changed.
  $B258,$0A Add the number of rectangles queued to the count of objects drawn in
. #R$A714.
@ $B262 label=DrawChangedObjects_Copy
  $B262,$07 Jump to #R$B275 if there are no rectangles left on the stack.
  $B269,$01 Count the rectangle off.
  $B26A,$03 Fetch the buffer address, the screen address and the width and
. height from the stack.
  $B26D,$03 Swap #REGb and #REGc, so that #REGb is the number of lines and #REGc
. the width.
  $B270,$03 Call #R$B278 to copy the rectangle to the screen.
  $B273,$02 Jump to #R$B262 for the next rectangle.
@ $B275 label=DrawChangedObjects_Done
  $B275,$02 Restore #REGix from the stack.
  $B277,$01 Return.

c $B278 Copy Block To Screen
@ $B278 label=CopyBlockToScreen
D $B278 Copies a rectangle from the buffer to the screen, a line at a time.
E $B278 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D67C }
. { #ALIENEIGHT$CF85 }
. LIST#
R $B278 B Number of lines
R $B278 C Width in bytes
R $B278 DE Screen address of the top line of the rectangle
R $B278 HL Buffer address of the first line
  $B278,$03 Stash the line counter, the screen address and the buffer address on
. the stack.
  $B27B,$02 Clear #REGb, ready for the copy.
  $B27D,$02 Copy a line of the rectangle to the screen.
  $B27F,$01 Restore the buffer address from the stack.
  $B280,$04 Move #REGhl on to the next line of the buffer by adding #N$20.
  $B284,$01 Restore the screen address from the stack.
N $B285 Move up to the next pixel line of the screen.
  $B285,$01 Move up one pixel line.
  $B286,$02 Invert the high byte of the screen address to test its pixel line
. bits.
  $B288,$02,b$01 Keep only the pixel line bits.
  $B28A,$02 Jump to #R$B296 if the line is still in the same character row.
  $B28C,$04 Move up one character row.
  $B290,$02 Jump to #R$B296 if that has crossed into the third above.
  $B292,$04 Otherwise cancel the effect of the borrow on the third, by adding
. #N$08 to the high byte.
@ $B296 label=CopyBlockToScreen_Next
  $B296,$01 Restore the line counter from the stack.
  $B297,$02 Decrease the line counter and loop until all the lines have been
. copied.
  $B299,$01 Return.

c $B29A Build Lookup Tables
@ $B29A label=BuildLookupTables
D $B29A Builds the tables that the sprite drawing and flipping code uses.
. #R$F100 gets the reversed bits of each byte value. The shift tables fill the
. pages from #N$F200 to #N$FFFF: for each of the seven shifts, one page holds
. the low byte and the page below it holds the high byte of every byte value
. shifted left by that number of bits, with all the bits inverted.
E $B29A View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D69E }
. { #ALIENEIGHT$CFA7 }
. LIST#
N $B29A Build the shift tables, one pair of pages for each shift of one to seven
. bits.
  $B29A,$02 Start with the byte value #N$00 in #REGl.
@ $B29C label=BuildLookupTables_NextValue
  $B29C,$02 Clear #REGd, the high byte of the shifted value.
  $B29E,$01 Copy the byte value to #REGe, the low byte of the shifted value.
  $B29F,$02 Point #REGh at the top page, #N$FF.
  $B2A1,$02 Set a counter in #REGb of seven shifts.
@ $B2A3 label=BuildLookupTables_NextShift
  $B2A3,$04 Shift the value left by one bit more.
  $B2A7,$01 Fetch the low byte of the value.
  $B2A8,$01 Invert the low byte of the shifted value.
  $B2A9,$01 Write the inverted low byte to the shift table.
  $B2AA,$01 Move down to the next page.
  $B2AB,$01 Fetch the high byte of the value.
  $B2AC,$01 Invert the high byte of the shifted value.
  $B2AD,$01 Write the inverted high byte to the shift table.
  $B2AE,$01 Move down to the next page.
  $B2AF,$02 Decrease the shift counter and loop until all seven shifts are done.
  $B2B1,$01 Move on to the next byte value.
  $B2B2,$02 Jump to #R$B29C until all #N$100 byte values are done.
N $B2B4 Build the table of bytes with the order of their bits reversed.
  $B2B4,$03 Start the table of reversed bytes at #N$F100.
@ $B2B7 label=BuildLookupTables_Reverse
  $B2B7,$01 Fetch the byte value to be reversed in #REGd.
  $B2B8,$02 Set a counter in #REGb of eight bits.
@ $B2BA label=BuildLookupTables_ReverseBit
  $B2BA,$02 Shift the lowest bit of #REGd out into the carry flag.
  $B2BC,$02 Shift it into #REGe, so the bits arrive in the opposite order.
  $B2BE,$02 Decrease the bit counter and loop until all eight bits are done.
  $B2C0,$01 Write the reversed value to the table.
  $B2C1,$01 Move on to the next byte value.
  $B2C2,$02 Jump to #R$B2B7 until all #N$100 values are done.
  $B2C4,$01 Return once both tables are built.

c $B2C5 Calculate Pixel Coordinates
@ $B2C5 label=CalculatePixelCoordinates
D $B2C5 Works out where the sprite of an object goes on the screen, from its
. position in the room. Objects are shown in an isometric view: moving along x
. takes the object down and to the right and moving along y takes it up and to
. the right, while height lifts it straight up.
D $B2C5 The screen x co-ordinate is x + y - #N$80 plus the sprite offset in the
. object, and is set to zero if that comes out below zero. The screen y
. co-ordinate is (y - x + #N$80) / 2 + z - #N$68 plus the sprite offset in the
. object. The y co-ordinate counts up from the bottom of the screen.
E $B2C5 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CFD2 }
. { #KNIGHTLORE$D6C9 }
. LIST#
R $B2C5 IX Object record
R $B2C5 O:F Carry flag set if the sprite is not above the top of the screen
N $B2C5 Work out the screen x co-ordinate.
  $B2C5,$06 Add the y position of the object to its x position.
  $B2CB,$02 Subtract #N$80 to centre the room on the screen.
  $B2CD,$03 Add the horizontal sprite offset.
  $B2D0,$02 Jump to #R$B2D3 if the result is not below zero.
  $B2D2,$01 Otherwise use zero.
@ $B2D3 label=CalculatePixelCoordinates_SetX
  $B2D3,$03 Write the screen x co-ordinate of the object.
N $B2D6 Work out the screen y co-ordinate.
  $B2D6,$06 Subtract the x position of the object from its y position.
  $B2DC,$02 Add #N$80.
  $B2DE,$02 Halve it.
  $B2E0,$03 Add the height of the object.
  $B2E3,$02 Subtract #N$68 to put the floor at the bottom of the screen.
  $B2E5,$03 Add the vertical sprite offset.
  $B2E8,$03 Write the screen y co-ordinate of the object.
  $B2EB,$02 Compare it with #N$C0, the number of lines on the screen.
  $B2ED,$01 Return, with the carry flag set when the sprite is on the screen.

c $B2EE Get Sprite Address
@ $B2EE label=GetSpriteAddress
D $B2EE Makes sure that the sprite of an object faces the way the object does.
. The sprite data holds its own state in the top two bits of its first byte: bit
. 7 says that it is upside down and bit 6 that it is mirrored. If either differs
. from the flags of the object (bits 7 and 6 of its flag byte) the sprite data
. is flipped to match, in place.
D $B2EE A sprite is held as rows of pairs of bytes, one pair per #N$08 pixels,
. with the mask byte first. Its bottom row comes first. Flipping it upside down
. swaps the rows over; mirroring it reverses the bits of each byte and the order
. of the bytes in each row.
D $B2EE If the type of the object has no sprite, the routine returns to the
. caller of its caller.
E $B2EE View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D6EF }
. { #ALIENEIGHT$CFFE }
. LIST#
R $B2EE IX Object record
R $B2EE O:DE Address of the sprite
N $B2EE Find the sprite of the object.
  $B2EE,$06 Fetch the type of the object and double it.
  $B2F4,$04 Find the entry for the type in the sprite table, #R$6DD7.
  $B2F8,$03 Fetch the address of the sprite in #REGde.
  $B2FB,$04 Jump to #R$B302 if the sprite exists, which is when its first byte
. is not zero.
  $B2FF,$02 Otherwise discard the return address of the caller...
  $B301,$01 ...and return to the caller of the caller.
@ $B302 label=GetSpriteAddress_Vertical
N $B302 Flip the sprite upside down if its state differs from that of the
. object.
  $B302,$01 Stash the address of the sprite on the stack.
  $B303,$04 Compare the first byte of the sprite with the flags of the object.
  $B307,$02,b$01 Keep only bit 7.
  $B309,$02 Jump to #R$B343 if they are the same.
  $B30B,$04 Toggle bit 7 of the sprite state.
  $B30F,$01 Rotate the width up by one bit, to double it.
  $B310,$02,b$01 Keep the doubled width, which is the number of bytes in a row.
  $B312,$01 Set #REGb to the row length.
  $B313,$01 Move on to the height.
  $B314,$02 Fetch the height of the sprite in #REGc.
  $B316,$01 Move on to the first row.
  $B317,$02 Stash the row length and the height, and the address of the data, on
. the stack.
  $B319,$05 Set #REGde to the height and clear #REGhl.
@ $B31E label=GetSpriteAddress_Multiply
  $B31E,$03 Multiply the height by the row length, to get the size of the data.
  $B321,$02 Restore the address of the data and the row length.
  $B323,$01 Add the address of the data to get the address of the end of it.
  $B324,$01 Put the end of the sprite data against its start.
  $B325,$04 Call #R$B519 to add the row length to #REGhl, which then points to
. the end of the first row.
  $B329,$02 Line up the last byte of the last row with that of the first
. row.
  $B32B,$02 Halve the height to get the number of pairs of rows to swap.
@ $B32D label=GetSpriteAddress_SwapRows
  $B32D,$01 Stash the counters on the stack.
@ $B32E label=GetSpriteAddress_SwapByte
  $B32E,$05 Swap a byte of the lower row with a byte of the upper row.
  $B333,$02 Move both pointers back to the previous byte.
  $B335,$02 Decrease the byte counter and loop until the rows have been swapped.
  $B337,$01 Restore the counters from the stack.
N $B338 Move on to the next pair of rows: the upper pointer on to the end of the
. next row, while the lower pointer is already at the end of the row below.
  $B338,$04 Call #R$B519 to add the row length to #REGhl.
  $B33C,$04 Call #R$B519 to add the row length to #REGhl again.
  $B340,$03 Count down the row pairs and jump to #R$B32D until they are swapped.
@ $B343 label=GetSpriteAddress_Horizontal
N $B343 Mirror the sprite if its state differs from that of the object.
  $B343,$01 Restore the address of the sprite from the stack.
  $B344,$01 Stash the address of the sprite on the stack again.
  $B345,$04 Compare the first byte of the sprite with the flags of the object.
  $B349,$02,b$01 Keep only bit 6.
  $B34B,$02 Jump to #R$B37D if they are the same.
  $B34D,$04 Toggle bit 6 of the sprite state.
  $B351,$02,b$01 Keep only the width.
  $B353,$02 Set #REGb and #REGc to the width in byte columns.
  $B355,$01 Move on to the height.
  $B356,$01 Fetch the height.
  $B357,$01 Keep the height as the row counter.
  $B358,$01 Move on to the first row.
  $B359,$01 Start at the first row of the sprite.
  $B35A,$01 Stash the address of the first row on the stack.
  $B35B,$01 Switch to the alternate registers.
  $B35C,$01 Restore it into #REGhl' to read the data with.
  $B35D,$02 Use the table of reversed bytes, whose page is #N$F1.
  $B35F,$01 Switch back to the main registers.
@ $B360 label=GetSpriteAddress_ReadRow
N $B360 Read a row, reversing the bits of each byte, and stack each pair of
. bytes.
  $B360,$01 Switch to the alternate registers.
  $B361,$03 Look up the mask byte in the table of reversed bytes, and keep the
. result in the low byte of #REGde'.
  $B364,$01 Move on to the pixel byte.
  $B365,$03 Do the same with the pixel byte, keeping the result in the high byte
. of #REGde'.
  $B368,$01 Move on to the next pair.
  $B369,$01 Stash the reversed pair on the stack.
  $B36A,$01 Switch back to the main registers.
  $B36B,$02 Decrease the column counter and loop until the row has been read.
  $B36D,$01 Restore the column counter.
@ $B36E label=GetSpriteAddress_WriteRow
N $B36E Write the pairs back in the opposite order.
  $B36E,$01 Take a pair from the stack.
  $B36F,$01 Write the mask byte.
  $B370,$01 Move on.
  $B371,$01 Write the pixel byte.
  $B372,$01 Move on.
  $B373,$02 Decrease the column counter and loop until the row has been written.
  $B375,$01 Swap in the row counter.
  $B376,$03 Jump to #R$B37D once the last row has been mirrored.
  $B379,$01 Stash the row counter again.
  $B37A,$01 Restore the column counter.
  $B37B,$02 Jump to #R$B360 to do the next row.
@ $B37D label=GetSpriteAddress_Done
  $B37D,$01 Restore the address of the sprite from the stack.
  $B37E,$01 Return.

c $B37F Calculate Buffer Address
@ $B37F label=CalculateBufferAddress
D $B37F Finds the address in the buffer of the byte that holds a pixel. The
. buffer is #N$20 bytes wide with its bottom line first, so the address is
. #N$D88F + y * #N$20 + x / #N$08.
E $B37F View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D811 }
. { #ALIENEIGHT$D120 }
. LIST#
R $B37F B Pixel y co-ordinate, counting up from the bottom of the screen
R $B37F C Pixel x co-ordinate
R $B37F O:BC Address in the buffer
  $B37F,$01 Stash #REGhl on the stack.
  $B380,$0C Divide the pixel co-ordinates by eight.
  $B38C,$03 Start at the first byte of the buffer, #R$D88F.
  $B38F,$01 Add #REGbc to get the address of the byte.
  $B390,$02 Keep the address in the buffer.
  $B392,$01 Restore #REGhl from the stack.
  $B393,$01 Return.

c $B394 Calculate Screen Address
@ $B394 label=CalculateScreenAddress
D $B394 Finds the address in the display file of the byte that holds a pixel.
. The y co-ordinate counts up from the bottom of the screen, so the first step
. is to invert it. A y co-ordinate of #N$C0 or more is above the top of the
. screen, and gives an address below #N$4000.
E $B394 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D826 }
. { #ALIENEIGHT$D135 }
. LIST#
R $B394 B Pixel y co-ordinate, counting up from the bottom of the screen
R $B394 C Pixel x co-ordinate
R $B394 O:DE Address in the display file
N $B394 Start with the column, which is the x co-ordinate divided by eight.
  $B394,$04 Divide the x co-ordinate by eight.
  $B398,$02,b$01 Keep only the five bits of the column.
  $B39A,$01 Set #REGe to the column.
N $B39B Find the line within the character square.
  $B39B,$02 Invert the y co-ordinate, to count down from the top of the screen.
  $B39D,$02,b$01 Keep the three bits of the line within the character square.
  $B39F,$01 Stash that in #REGaf'.
N $B3A0 Find the character row within the third of the screen, and merge it with
. the column to make the low byte of the address.
  $B3A0,$04 Invert the y co-ordinate and rotate the three bits of the character
. row up to the top of #REGa.
  $B3A4,$02,b$01 Keep only those three bits.
  $B3A6,$01 Combine them with the column in #REGe.
  $B3A7,$01 Set #REGe to the low byte of the address.
N $B3A8 Find the third of the screen and merge it with the line to make the high
. byte of the address.
  $B3A8,$05 Invert the y co-ordinate and rotate the two bits of the third down
. to bits 3 and 4.
  $B3AD,$02,b$01 Keep only those two bits.
  $B3AF,$01 Set #REGd to the third.
  $B3B0,$01 Fetch the line within the character square.
  $B3B1,$01 Combine it with the third.
  $B3B2,$02 Add #N$38, which corrects for the inverted y co-ordinate and adds
. the display file base of #N$40.
  $B3B4,$01 Set #REGd to the high byte of the address.
  $B3B5,$01 Return.

c $B3B6 Calculate Attribute Address
@ $B3B6 label=CalculateAttributeAddress
D $B3B6 Finds the address in the attribute file of the colour square that holds
. a pixel. The y co-ordinate counts up from the bottom of the screen. The result
. is based on #N$5700 rather than #N$5800 as the lowest eight character rows are
. below the screen.
E $B3B6 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D848 }
. { #ALIENEIGHT$D157 }
. LIST#
R $B3B6 H Pixel y co-ordinate, counting up from the bottom of the screen
R $B3B6 L Pixel x co-ordinate
R $B3B6 O:DE Address in the attribute file
  $B3B6,$01 Stash #REGhl on the stack.
  $B3B7,$03 Invert the y co-ordinate.
  $B3BA,$08 Shift the inverted y co-ordinate right four times.
  $B3C2,$02 Rotate the last bit shifted out into the top of #REGl, shifting the
. x co-ordinate right by one.
  $B3C4,$04 Shift #REGh again, and rotate the bit shifted out into #REGl.
  $B3C8,$04 Shift #REGh once more, and rotate the bit shifted out into #REGl.
. This leaves #REGhl as the character row times #N$20 plus the column.
  $B3CC,$03 Set #REGde to #N$5700, the base of the attribute file less #N$100.
  $B3CF,$01 Add the offset to get the address of the attribute.
  $B3D0,$01 Keep the attribute address.
  $B3D1,$01 Restore #REGhl from the stack.
  $B3D2,$01 Return.

c $B3D3 Draw Object
@ $B3D3 label=DrawObject
D $B3D3 Draws the sprite of an object into the buffer, using whatever of the
. room has already been drawn as the background. An object of type #N$01 is only
. a marker that something has to be erased, so it is removed instead of being
. drawn.
D $B3D3 The sprite data is for whole bytes. If the screen x co-ordinate of the
. object is not a multiple of eight, the sprite is shifted to the right by the
. difference as it is drawn, which makes it one byte wider. Sprites are at most
. five bytes wide.
D $B3D3 The drawing is done by two pieces of code that are set up for the width
. of the sprite. Each is made of a run of identical units, one for each byte
. column, and a jump into the run, which is patched with a displacement, starts
. it at the first unit that is needed. The stack pointer is made to point at the
. sprite data, so that each pair of bytes can be fetched with a POP.
D $B3D3 Each pair is a mask byte followed by a pixel byte. The bits of the
. buffer that are under the mask are cleared and then the pixel byte is merged
. in.
E $B3D3 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D704 }
. { #ALIENEIGHT$D013 }
. LIST#
R $B3D3 IX Object record
@ $B3E7 label=DrawObject_Sprite
N $B3D3 An object of type #N$01 only marks an area to be erased, so it is freed
. and not drawn.
  $B3D3,$07 Jump to #R$B3DF if the type of the object is not #N$01.
  $B3DA,$04 Set the type of the object to #N$00, which frees it.
  $B3DE,$01 Return.
@ $B3DF label=DrawObject_Project
N $B3DF Work out where on the screen the sprite goes and fetch the sprite,
. flipped to the right way round.
  $B3DF,$04 Clear the flag that says the object needs drawing.
  $B3E3,$03 Call #R$B2C5 to work out the screen position of the object.
  $B3E6,$01 Return if the object is above the top of the screen.
  $B3E7,$03 Call #R$B2EE to flip the sprite if needed and get its address in
. #REGde.
N $B3EA Set up the drawing code for a sprite that has to be shifted.
  $B3EA,$03 Fetch the screen x co-ordinate of the object.
  $B3ED,$02,b$01 Keep the number of bits to shift by.
  $B3EF,$02 Jump to #R$B43E if there is no shift.
  $B3F1,$01 Double it.
  $B3F2,$02,b$01 Keep the number as an even number of pages.
  $B3F4,$02,b$01 Add the page of the first shift table, #N$F0.
  $B3F6,$01 Set #REGh to the page of the table for this shift.
N $B3F7 The sprite is a byte wider when it is shifted. Set that width in the
. object.
  $B3F7,$02 Fetch the first byte of the sprite, which holds its width, and move
. on to the height.
  $B3F9,$02,b$01 Keep only the width.
  $B3FB,$01 Add one for the extra byte.
  $B3FC,$01 Stash the width in #REGb.
  $B3FD,$03 Write it to the object.
N $B400 Work out the displacement that jumps into the shifted code at the first
. unit that is needed. A unit is #N$10 bytes long, and the last of them ends at
. #R$B4CD.
  $B400,$01 Subtract one to get the width of the sprite.
  $B401,$02,b$01 Keep the width (which is at most five).
  $B403,$04 Multiply it by sixteen, the size of a unit.
  $B407,$02 Negate it.
  $B409,$02 Add #N$50, the distance from the displacement to the end of the
. units.
@ $B40B label=DrawObject_SetOffset
  $B40B,$03 Write it into the jump that starts the drawing, at #N$B47C.
N $B40E Work out the amount to add to the buffer address to get from the end of
. a row of the sprite to the start of the next.
  $B40E,$02 Fetch the width, and invert it.
  $B410,$02 Add #N$22, which makes the amount #N$21 less the width.
  $B412,$03 Write it to the code that finishes a row, at #N$B4D0.
N $B415 Fetch the height of the sprite, and cut it down if the sprite sticks out
. above the top of the screen.
  $B415,$02 Fetch the height and move on to the data.
  $B417,$03 Write the height to the object.
  $B41A,$03 Add the bottom of the sprite to get the top of the sprite.
  $B41D,$02 Subtract #N$C0 to see how far it sticks out of the screen.
  $B41F,$02 Jump to #R$B429 if it does not.
  $B421,$02 Negate the amount.
  $B423,$06 Subtract it from the height, and write that to the object.
@ $B429 label=DrawObject_SetAddress
N $B429 Find where in the buffer the sprite starts and set the stack pointer to
. the data.
  $B429,$06 Set #REGbc to the pixel co-ordinates of the sprite.
  $B42F,$03 Call #R$B37F to get the address in the buffer in #REGbc.
  $B432,$04 Save the stack pointer in #R$A717.
  $B436,$03 Point the stack pointer at the sprite data.
  $B439,$03 Fetch the number of rows to draw.
  $B43C,$02 Jump to #R$B479 to start drawing.
@ $B43E label=DrawObject_Aligned
N $B43E Set up the drawing code for a sprite that is not shifted. Each unit of
. it is #N$08 bytes long, and the last of them ends at #R$B4CE.
  $B43E,$02 Fetch the first byte of the sprite, which holds its width, and move
. on to the height.
  $B440,$02,b$01 Keep only the width.
  $B442,$03 Write the width to the object.
  $B445,$01 Stash the width in #REGb.
  $B446,$03 Multiply it by eight, the size of a unit.
  $B449,$02 Negate it.
  $B44B,$02 Subtract #N$06, which makes the jump end at the last unit.
  $B44D,$02 Jump to #R$B40B to write the displacement and carry on.

c $B44F Draw Aligned Columns
@ $B44F label=DrawAlignedColumns
D $B44F Draws the rows of a sprite that is not shifted. There is one unit of
. code for each byte column of the sprite, and the first unit that is used
. depends on the width of the sprite: the jump at #R$B47B is patched with a
. displacement that enters the run at the right place. The last unit finishes by
. jumping to #R$B4CE.
D $B44F Every unit fetches a mask and a pixel byte, clears the bits of the
. buffer under the mask and sets the pixel bits.
E $B44F View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D780 }
. { #ALIENEIGHT$D08F }
. { #NIGHTSHADE$E49F }
. { #GUNFRIGHT$BE5B }
. LIST#
N $B44F The first unit of the run, which is used by sprites of five bytes wide.
  $B44F,$01 Fetch the mask byte into #REGe and the pixel byte into #REGd.
  $B450,$01 Fetch the byte from the buffer.
  $B451,$01 Invert it.
  $B452,$01 Set the mask bits (which clears them once it is inverted back).
  $B453,$01 Invert it back, which leaves the bits under the mask cleared.
  $B454,$01 Set the pixel bits.
  $B455,$01 Write the byte to the buffer.
  $B456,$01 Move on to the next byte of the buffer.
N $B457 The second unit, which is used by sprites that are four bytes wide.
  $B457,$08 Draw the second byte column in the same way as the first.
N $B45F The third unit, which is used by sprites that are three bytes wide.
  $B45F,$08 Draw the third byte column.
N $B467 The fourth unit, which is used by sprites that are two bytes wide.
  $B467,$08 Draw the fourth byte column.
N $B46F The last unit, which is used by sprites that are one byte wide.
  $B46F,$07 Draw the last byte column, but without moving on to the next byte.
  $B476,$03 Jump to #R$B4CE to finish the row.

c $B479 Draw Lines
@ $B479 label=DrawLines
D $B479 Draws the rows of a sprite, which is shifted if its x co-ordinate is not
. a multiple of eight. Both ways of drawing a sprite arrive here with the number
. of rows to draw in #REGa.
D $B479 The shifted code has one unit for each byte column, and the jump at
. #R$B47B is patched with a displacement that enters the run at the first unit
. that is needed. Each unit takes a pair of sprite bytes, and uses the shift
. tables built by #R$B29A to split each into the part that goes into the byte of
. the buffer, and the part that goes into the next byte. The table for the high
. part is in the page in #REGh, and the table for the low part is in the next
. page.
D $B479 For the aligned rows, the displacement jumps into the run of units of
. #R$B44F instead.
E $B479 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D7AA }
. { #ALIENEIGHT$D0B9 }
. LIST#
R $B479 A Number of rows to draw
R $B479 BC Address in the buffer of the first byte of the bottom row
R $B479 H Page of the shift table for the high part of the sprite bytes
  $B479,$01 Stash the number of rows in #REGaf'.
  $B47A,$01 Fetch the first byte of the buffer row.
@ $B47B label=DrawLines_Jump
  $B47B,$02 Jump into the run of units. The displacement is patched at #N$B47C.
N $B47D The first unit of the run, which is used by sprites of five bytes wide.
@ $B47D label=DrawLines_FirstUnit
  $B47D,$01 Fetch the mask byte into #REGe and the pixel byte into #REGd.
  $B47E,$01 Look up the mask byte.
  $B47F,$01 Clear the buffer bits under the high part of the mask.
  $B480,$03 Merge in the high part of the pixel byte.
  $B483,$01 Write the byte to the buffer.
  $B484,$01 Move on to the next byte of the buffer.
  $B485,$01 Switch to the page of the low parts.
  $B486,$02 Fetch the next byte of the buffer, and look up the mask byte again.
  $B488,$01 Clear the buffer bits under the low part of the mask.
  $B489,$03 Merge in the low part of the pixel byte.
  $B48C,$01 Switch back to the page of the high parts.
N $B48D The second unit, which is used by sprites of four bytes wide.
  $B48D,$10 Draw the second byte column.
N $B49D The third unit, which is used by sprites of three bytes wide.
  $B49D,$10 Draw the third byte column.
N $B4AD The fourth unit, which is used by sprites of two bytes wide.
  $B4AD,$10 Draw the fourth byte column.
N $B4BD The last unit, which is used by sprites of one byte wide.
  $B4BD,$10 Draw the last byte column.
N $B4CD Write the last byte of the row and move to the next row.
  $B4CD,$01 Write the last byte to the buffer.
@ $B4CE label=DrawLines_FinishRow
  $B4CE,$01 Fetch the low byte of the buffer address.
  $B4CF,$02 Add the amount that takes the address to the start of the next row.
. This is patched at #N$B4D0.
  $B4D1,$01 Set the low byte of the buffer address.
  $B4D2,$01 Fetch the high byte of the buffer address.
  $B4D3,$02 Add the carry.
  $B4D5,$01 Set the high byte of the buffer address.
  $B4D6,$01 Fetch the row counter.
  $B4D7,$04 Count down the rows and jump to #R$B479 until they are drawn.
  $B4DB,$04 Restore the stack pointer from #R$A717.
  $B4DF,$01 Return.

c $B4E0 Pause Game
@ $B4E0 label=PauseGame
D $B4E0 Pauses the game while CAPS SHIFT or SPACE is held down on its own. A
. click is made to say that the game has been paused, and the game then waits
. for the key to be released, pressed and released again before another click
. and returning.
D $B4E0 Interrupts are enabled while the game is paused, and the system variable
. pointer in #REGiy is set up to what the ROM interrupt routine expects.
N $B4E0 Return unless CAPS SHIFT or SPACE is the only key being pressed.
  $B4E0,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | CAPS SHIFT or SPACE | Z or SYMBOL SHIFT | X or M | C or N | V or B }
. TABLE#
  $B4E5,$03 Return if neither CAPS SHIFT nor SPACE is pressed.
  $B4E8,$02,b$01 Keep only the keys other than CAPS SHIFT and SPACE.
  $B4EA,$01 Return if another key is pressed.
  $B4EB,$03 Call #R$D5D7 to make a click.
N $B4EE Wait for the key to be released.
@ $B4EE label=PauseGame_WaitRelease
  $B4EE,$05 Read the keyboard rows that hold CAPS SHIFT and SPACE.
  $B4F3,$04 Jump back to #R$B4EE if CAPS SHIFT or SPACE is still pressed.
  $B4F7,$04 Set up the system variables for the ROM interrupt routine.
  $B4FB,$01 Enable interrupts.
N $B4FC The game is paused: wait for the key to be pressed.
@ $B4FC label=PauseGame_WaitPress
  $B4FC,$05 Read the keyboard rows that hold CAPS SHIFT and SPACE.
  $B501,$04 Jump back to #R$B4FC if neither is pressed.
N $B505 Wait for the key to be released again.
@ $B505 label=PauseGame_WaitResume
  $B505,$05 Read the keyboard rows that hold CAPS SHIFT and SPACE.
  $B50A,$04 Jump back to #R$B505 if CAPS SHIFT or SPACE is still pressed.
  $B50E,$01 Disable interrupts.
  $B50F,$03 Call #R$D5D7 to make a click.
  $B512,$01 Return.

c $B513 Clear Bytes
@ $B513 label=ClearBytes
D $B513 Writes a value to a number of bytes. The entry point at #R$B514 writes
. the value in #REGa instead of zero.
E $B513 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D508 }
. { #ALIENEIGHT$CE1C }
. LIST#
R $B513 B Number of bytes
R $B513 DE Address of the first byte
  $B513,$01 Set the value to write to #N$00.
@ $B514 label=ClearBytes_FillBytes
  $B514,$01 Write the value to the next byte.
  $B515,$01 Move on to the next byte.
  $B516,$02 Decrease the counter and loop until all the bytes have been written.
  $B518,$01 Return.

c $B519 Add A To HL
@ $B519 label=AddAToHL
D $B519 Adds the value of #REGa to #REGhl.
E $B519 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D4F2 }
. { #ALIENEIGHT$CE06 }
. { #NIGHTSHADE$E596 }
. { #CYBERUN$9BCF }
. { #ATICATAC$926C }
. LIST#
R $B519 A Value to add
R $B519 HL Value to add it to
R $B519 O:HL The sum
  $B519,$01 Add the low byte.
  $B51A,$01 Set the low byte of the result.
  $B51B,$01 Fetch the high byte.
  $B51C,$02 Add the carry.
  $B51E,$01 Set the high byte of the result.
  $B51F,$01 Return.

c $B520 Find Object Address
@ $B520 label=FindObjectAddress
D $B520 Finds the address of an object record, from its number. Bit 7 of the
. number is ignored, as that is used as a flag in the draw list.
E $B520 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D3B5 }
. { #ALIENEIGHT$CC96 }
. LIST#
R $B520 A Object number
R $B520 O:HL Address of the object record
  $B520,$01 Stash #REGbc on the stack.
  $B521,$02,b$01 Ignore bit 7 of the object number.
  $B523,$03 Set #REGhl to the object number.
  $B526,$05 Multiply it by #N$20, the size of an object record.
  $B52B,$03 Start from the object table, #R$A76F.
  $B52E,$01 Add it to get the address of the record.
  $B52F,$01 Restore #REGbc from the stack.
  $B530,$01 Return.

c $B531 List Objects To Draw
@ $B531 label=ListObjectsToDraw
D $B531 Makes a list of the numbers of the objects that have to be drawn, which
. is every object that is in use and has bit 4 of its flags set. The list is
. stored at #R$B55A and ends with #N$FF.
E $B531 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CE62 }
. { #ALIENEIGHT$C71C }
. LIST#
N $B531 Go through all #N$36 objects.
  $B531,$02 Stash #REGix on the stack.
  $B533,$02 Set a counter in #REGb of #N$36 objects.
  $B535,$03 Set #REGde to the size of an object record.
  $B538,$04 Start with the first object record, #R$A76F.
  $B53C,$03 Start the draw list at #R$B55A.
  $B53F,$02 Start with object number #N$00.
@ $B541 label=ListObjectsToDraw_Next
  $B541,$06 Jump to #R$B54F if the object is not in use.
  $B547,$06 Jump to #R$B54F if the object does not need drawing.
  $B54D,$01 Add the object number to the list.
  $B54E,$01 Move on in the list.
@ $B54F label=ListObjectsToDraw_Skip
  $B54F,$01 Move on to the next object number.
  $B550,$02 Move #REGix on to the next object record.
  $B552,$02 Decrease the counter and loop until all the objects have been done.
  $B554,$02 Take #N$FF as the end marker of the draw list.
  $B556,$01 Mark the end of the list.
  $B557,$02 Restore #REGix from the stack.
  $B559,$01 Return.

b $B55A Draw List
@ $B55A label=DrawList
D $B55A The numbers of the objects to draw, as made by #R$B531, and ended by
. #N$FF. Bit 7 of an entry is set by #R$B58A once the object has been drawn.
B $B55A,$30,$08

c $B58A Draw Objects In Order
@ $B58A label=DrawObjectsInOrder
D $B58A Draws every object in the draw list at #R$B55A, back to front, so that
. the nearer objects are drawn over the further ones.
D $B58A The routine looks at the objects in the list in turn, and draws the
. first one that no other undrawn object has to be drawn before. To decide that,
. it compares the object that it is considering (held in #REGix) with each of
. the other undrawn objects (held in #REGiy) along the three axes. Each axis
. gives a code of 0, 1 or 2: 1 when the two overlap on that axis, and 0 or 2
. when they are apart. For x and for the height, 0 means that the object
. considered is in front of the other and 2 that it is behind it; for y it is
. the other way round. The three codes make up a number from 0 to 26 (the code
. for x is multiplied by 9, and for y by 3), which selects a routine from the
. table at #R$B638.
D $B58A When the object considered is in front of the other one, and so must be
. drawn after it, the other one becomes the object that is considered instead
. and the search starts again from the beginning of the list. A list of the
. objects that have been looked at in this way, at #R$B6CD, stops this from
. going on forever if there is a loop of objects that each have to be drawn
. after another: in that case the object that closed the loop is drawn.
D $B58A Each time an object is drawn, bit 7 of its entry in the list is set, and
. the sort starts again at the beginning of the list.
E $B58A View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CEBB }
. { #ALIENEIGHT$C785 }
. LIST#
N $B58A Start with no objects drawn.
  $B58A,$04 Write #N$00 to #R$A714.
  $B58E,$04 Stash #REGix and #REGiy on the stack.
@ $B592 label=DrawObjectsInOrder_Restart
N $B592 Find the first object in the list that has not been drawn.
  $B592,$03 Point #REGde at the start of the draw list, #R$B55A.
@ $B595 label=DrawObjectsInOrder_NextCandidate
  $B595,$02 Fetch the next object number from the list.
  $B597,$05 Jump to #R$B6C8 if the end of the list has been reached, as every
. object has been drawn.
  $B59C,$04 Jump to #R$B595 if the object has already been drawn.
  $B5A0,$03 Call #R$B520 to get the address of the object.
  $B5A3,$04 Write the list pointer to #R$A719.
  $B5A7,$03 Copy the address of the object to #REGix (using the stack).
@ $B5AA label=DrawObjectsInOrder_NextOther
N $B5AA Compare it with each of the other undrawn objects in the list.
  $B5AA,$02 Fetch the next object number from the list.
  $B5AC,$05 Jump to #R$B6B3 if the end of the list has been reached, as nothing
. has to be drawn before the object considered.
  $B5B1,$04 Jump to #R$B5AA if the object has already been drawn.
  $B5B5,$03 Call #R$B520 to get the address of the object.
  $B5B8,$04 Write the list pointer to #R$A71B.
  $B5BC,$03 Copy the address of the object to #REGiy (using the stack).
  $B5BF,$03 Copy #REGix to #REGbc (using the stack).
  $B5C2,$05 Jump to #R$B5AA if the other object is the object considered, as an
. object is not compared with itself.
  $B5C7,$02 Start with a code of zero in #REGc.
N $B5C9 Compare the heights. The code is 0 if the object considered is above the
. other and so in front, 1 if they overlap and 2 if it is below the other.
  $B5C9,$07 Fetch the height of the top of the other object.
  $B5D0,$04 Subtract it from the height of the bottom of the object considered.
  $B5D4,$02 Jump to #R$B5E5 if the object considered is above the other.
  $B5D6,$07 Fetch the height of the top of the object considered.
  $B5DD,$04 Subtract it from the height of the bottom of the other object.
  $B5E1,$02 Jump to #R$B5E4 if the two overlap.
  $B5E3,$01 Add one to the code, as the object considered is below the other.
@ $B5E4 label=DrawObjectsInOrder_HeightCode
  $B5E4,$01 Add one to the code.
N $B5E5 Compare the y positions, which add three or six to the code. The code is
. 0 if the object considered has the higher y position and so is behind, 1 if
. they overlap and 2 if it has the lower y position and so is in front.
@ $B5E5 label=DrawObjectsInOrder_CompareY
  $B5E5,$07 Fetch the highest y position of the other object.
  $B5EC,$07 Subtract it from the lowest y position of the object considered.
  $B5F3,$02 Jump to #R$B60B if the object considered has the higher y position,
. and is behind.
  $B5F5,$07 Fetch the highest y position of the object considered.
  $B5FC,$07 Subtract it from the lowest y position of the other object.
  $B603,$01 Fetch the code.
  $B604,$02 Jump to #R$B608 if the two overlap.
  $B606,$02 Add three to the code, as the object considered has the lower y
. position.
@ $B608 label=DrawObjectsInOrder_YCode
  $B608,$02 Add three to the code.
  $B60A,$01 Set the code.
N $B60B Compare the x positions, which add nine or eighteen to the code. The
. code is 0 if the object considered has the higher x position and so is in
. front, 1 if they overlap and 2 if it has the lower x position and so is
. behind.
@ $B60B label=DrawObjectsInOrder_CompareX
  $B60B,$07 Fetch the highest x position of the other object.
  $B612,$07 Subtract it from the lowest x position of the object considered.
  $B619,$02 Jump to #R$B631 if the object considered has the higher x position,
. and is in front.
  $B61B,$07 Fetch the highest x position of the object considered.
  $B622,$07 Subtract it from the lowest x position of the other object.
  $B629,$01 Fetch the code.
  $B62A,$02 Jump to #R$B62E if the two overlap.
  $B62C,$02 Add nine to the code, as the object considered has the lower x
. position.
@ $B62E label=DrawObjectsInOrder_XCode
  $B62E,$02 Add nine to the code.
  $B630,$01 Set the code.
@ $B631 label=DrawObjectsInOrder_Dispatch
N $B631 Jump to the routine for the combination of codes, using the code to find
. its address in the table at #R$B638. The dispatch code of the main loop at
. #R$B003 is used for this.
  $B631,$01 Set #REGl to the combined code.
  $B632,$03 Point #REGbc at #R$B638.
  $B635,$03 Jump to #R$B003.

w $B638 Sort Jump Table
@ $B638 label=SortJumpTable
D $B638 The routines that #R$B58A uses for each combination of the codes for the
. three axes. The entries are in groups of three for the three codes of the
. height, in groups of three of those for the three codes of y, and in groups of
. three of those for the three codes of x.
D $B638 #R$B674 is used when the object considered is in front of the other on
. some axes and behind on none, so it has to be drawn after the other one.
. #R$B671 is used when it is behind on some axes and in front on none, so it can
. be drawn before. #R$B66E is used when it is in front on some axes and behind
. on others, and #R$B6B0 when the two overlap on all of them; in both cases
. there is nothing to say which comes first.
W $B638,$06,$06 In front on x, behind on y.
W $B63E,$06,$06 In front on x, overlapping on y.
W $B644,$06,$06 In front on x and on y.
W $B64A,$06,$06 Overlapping on x, behind on y.
W $B650,$06,$06 Overlapping on x and on y.
W $B656,$06,$06 Overlapping on x, in front on y.
W $B65C,$06,$06 Behind on x and on y.
W $B662,$06,$06 Behind on x, overlapping on y.
W $B668,$06,$06 Behind on x, in front on y.

c $B66E Resolve Object Order
@ $B66E label=ResolveObjectOrder
D $B66E The routines selected by the table at #R$B638, once #R$B58A has compared
. two objects. #REGix holds the object that is being considered and #REGiy holds
. the object that it has been compared with.
N $B66E The order of the objects is not known, so look at the next object.
  $B66E,$03 Jump to #R$B5AA to compare the object considered with the next
. object in the list.
N $B671 The object considered is behind the other, so it needs no wait: look at
. the next object.
@ $B671 label=ResolveObjectOrder_Behind
  $B671,$03 Jump to #R$B5AA to compare the object considered with the next
. object in the list.
N $B674 The object considered is in front of the other so it must be drawn after
. it. Make the other one the object that is being considered, unless it has
. already been tried, and so is part of a loop.
@ $B674 label=ResolveObjectOrder_InFront
  $B674,$03 Fetch the list pointer, which is just after the entry of the other
. object.
  $B677,$01 Point #REGhl at the entry.
  $B678,$01 Fetch the number of the object in #REGc.
  $B679,$03 Point #REGde at the list of the objects that have been tried,
. #R$B6CD.
@ $B67C label=ResolveObjectOrder_FindTried
  $B67C,$01 Fetch the next number in the list of the objects tried.
  $B67D,$04 Jump to #R$B687 if the end of that list has been reached.
  $B681,$03 Jump to #R$B69D if the object has already been tried, which means
. that there is a loop.
  $B684,$01 Move on in the list.
  $B685,$02 Jump back to #R$B67C to look at the next number.
N $B687 Add the object to the list of the objects tried.
@ $B687 label=ResolveObjectOrder_AddTried
  $B687,$01 Fetch the number of the object.
  $B688,$01 Add it to the list.
  $B689,$01 Move on in the list.
  $B68A,$02 Set #REGa to #N$FF.
  $B68C,$01 Mark the end of the list.
N $B68D Make the other object the one that is considered and start the search
. again from the top of the list.
  $B68D,$04 Copy #REGiy to #REGix (using the stack).
  $B691,$03 Fetch the list pointer.
  $B694,$03 Make it the pointer to the entry of the object that is considered.
  $B697,$03 Point #REGde at the start of the draw list, #R$B55A.
  $B69A,$03 Jump to #R$B5AA to compare the object with the others.
N $B69D The object has been tried before, so there is a loop. Draw it, to break
. the loop, once its place in the list has been found.
@ $B69D label=ResolveObjectOrder_Loop
  $B69D,$03 Point #REGhl at the start of the draw list, #R$B55A.
@ $B6A0 label=ResolveObjectOrder_FindEntry
  $B6A0,$02 Fetch the next number from the list.
  $B6A2,$05 Jump to #R$B592 if the end of the list has been reached.
  $B6A7,$03 Jump back to #R$B6A0 if it is not the entry of the object.
  $B6AA,$04 Copy #REGiy to #REGix (using the stack).
  $B6AE,$02 Jump to #R$B6B6 to draw the object.
N $B6B0 The two objects overlap completely, so look at the next object.
@ $B6B0 label=ResolveObjectOrder_Overlap
  $B6B0,$03 Jump to #R$B5AA to compare the object considered with the next
. object in the list.
N $B6B3 Nothing has to be drawn before the object considered, so draw it now.
@ $B6B3 label=ResolveObjectOrder_Draw
  $B6B3,$03 Fetch the pointer to the entry of the object in the list.
@ $B6B6 label=ResolveObjectOrder_DrawEntry
  $B6B6,$01 Point #REGhl at the entry.
  $B6B7,$02 Set bit 7 of the entry, to show that the object has been drawn.
  $B6B9,$02 Set #REGa to #N$FF.
  $B6BB,$03 Empty the list of the objects that have been tried.
  $B6BE,$03 Point #REGhl at the count of the objects drawn, #R$A714.
  $B6C1,$01 Count the object.
  $B6C2,$03 Call #R$B3D3 to draw the object.
  $B6C5,$03 Jump to #R$B592 to look for the next object to draw.
N $B6C8 All the objects have been drawn.
@ $B6C8 label=ResolveObjectOrder_Done
  $B6C8,$04 Restore #REGiy and #REGix from the stack.
  $B6CC,$01 Return.

b $B6CD Objects Tried List
@ $B6CD label=ObjectsTriedList
D $B6CD The numbers of the objects that #R$B674 has followed the chain of,
. ending in #N$FF. It is empty (#N$FF in the first byte) between objects.
B $B6CD,$10,$08

c $B6DD Fill Window
@ $B6DD label=FillWindow
D $B6DD Fills a rectangle of the buffer with a byte.
E $B6DD View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C515 }
. LIST#
R $B6DD A Byte to fill with
R $B6DD B Width in bytes
R $B6DD C Height in lines
R $B6DD HL Address in the buffer of the bottom left byte
  $B6DD,$03 Set #REGde to the length of a line of the buffer.
@ $B6E0 label=FillWindow_NextLine
  $B6E0,$02 Stash the counters and the start of the line on the stack.
@ $B6E2 label=FillWindow_NextByte
  $B6E2,$01 Write the byte.
  $B6E3,$01 Move on to the next byte.
  $B6E4,$02 Decrease the width counter and loop until the line has been filled.
  $B6E6,$01 Restore the start of the line.
  $B6E7,$01 Move up to the next line.
  $B6E8,$01 Restore the counters.
  $B6E9,$03 Count down the lines and jump to #R$B6E0 until the rectangle is
. filled.
  $B6EC,$01 Return.

c $B6ED Block Movement
@ $B6ED label=BlockMovement
D $B6ED Moves an object by its speeds along the three axes, which are held in
. the object, and stops it where it is blocked by a wall or by another object.
. The speeds are changed to the distances that the object has actually moved.
. The routine records what blocked the object in its collision flags: bit 0 is
. set if it was stopped on x, bit 1 if it was stopped on y and bit 2 if it was
. stopped on z, which also means that the object is standing on the floor or on
. another object. These flags are cleared first.
D $B6ED The object is flagged as being moved while this happens, so that the
. tests for collisions with other objects ignore it, and so that this routine
. ignores a second call for it.
D $B6ED The z axis is done first, then x, then y. The speed is first cut down to
. what the walls (or the floor) allow, and then to what the other objects allow.
E $B6ED View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CB45 }
. { #ALIENEIGHT$C442 }
. LIST#
R $B6ED IX Object record
N $B6ED Return if the object is already being moved. If not, flag that it is and
. clear the collision flags of the last move.
  $B6ED,$05 Return if the object is already being moved.
  $B6F2,$04 Flag that the object is being moved.
  $B6F6,$03 Fetch the collision flags.
  $B6F9,$02,b$01 Clear the flags for x, y and z.
  $B6FB,$03 Write the flags back.
  $B6FE,$03 Start with no speed along y in #REGl and none along x in #REGc.
N $B701 Move along the z axis.
  $B701,$07 Fetch the speed along z into #REGh, and jump to #R$B712 if it is
. zero.
  $B708,$03 Call #R$B963 to cut the speed down so that the object stays above
. the floor.
  $B70B,$04 Jump to #R$B712 if that has left no speed.
  $B70F,$03 Call #R$B7E0 to cut the speed down so that the object does not go
. through another object.
N $B712 Move along the x axis.
@ $B712 label=BlockMovement_X
  $B712,$07 Fetch the speed along x into #REGc, and jump to #R$B723 if it is
. zero.
  $B719,$03 Call #R$B8E2 to cut the speed down so that the object stays inside
. the walls.
  $B71C,$04 Jump to #R$B723 if that has left no speed.
  $B720,$03 Call #R$B742 to cut the speed down so that the object does not go
. through another object.
N $B723 Move along the y axis.
@ $B723 label=BlockMovement_Y
  $B723,$07 Fetch the speed along y into #REGl, and jump to #R$B734 if it is
. zero.
  $B72A,$03 Call #R$B90D to cut the speed down so that the object stays inside
. the walls.
  $B72D,$04 Jump to #R$B734 if that has left no speed.
  $B731,$03 Call #R$B791 to cut the speed down so that the object does not go
. through another object.
N $B734 Store the distances that the object can move, and finish.
@ $B734 label=BlockMovement_Store
  $B734,$03 Write the distance along x.
  $B737,$03 Write the distance along y.
  $B73A,$03 Write the distance along z.
  $B73D,$04 Flag that the object is not being moved.
  $B741,$01 Return.

c $B742 Block Movement In X
@ $B742 label=BlockMovementInX
D $B742 Cuts down the distance that an object moves along x until it does not go
. through any other object. The speed is reduced by one each time until the
. object no longer overlaps the other object, or it is zero.
D $B742 When the object hits another object, the two objects share their hit
. flags, and if the other object can be pushed, it is given the speed of this
. object.
E $B742 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CB9A }
. { #ALIENEIGHT$C497 }
. LIST#
R $B742 C Distance to move along x
R $B742 IX Object record
R $B742 O:C Distance that can be moved
N $B742 Try the object against each of the objects in turn.
  $B742,$04 Start with the first object record, #R$A76F.
  $B746,$02 Set a counter in #REGb of #N$36 objects.
@ $B748 label=BlockMovementInX_Next
  $B748,$05 Jump to #R$B789 if the other object is not in use, or is being
. moved.
  $B74D,$05 Jump to #R$B789 if the objects do not overlap along y.
  $B752,$05 Jump to #R$B789 if the objects do not overlap along z.
@ $B757 label=BlockMovementInX_Test
  $B757,$05 Jump to #R$B789 if the objects will not overlap along x when the
. object has moved.
N $B75C The objects hit each other. Flag a hit along x and pass on the hit
. flags.
  $B75C,$04 Flag that the object has been stopped along x.
  $B760,$03 Fetch the hit flags of the object.
  $B763,$01 Move bit 7 down to bit 6.
  $B764,$02,b$01 Keep only bit 6.
  $B766,$03 Add the hit flags of the other object.
  $B769,$03 Write them to the other object.
  $B76C,$01 Move bit 5 of the hit flags of the other object up to bit 6.
  $B76D,$02,b$01 Keep only bit 6.
  $B76F,$03 Add the hit flags of the object.
  $B772,$03 Write them to the object.
N $B775 Push the other object, if it can be pushed.
  $B775,$06 Jump to #R$B781 if the other object cannot be pushed.
  $B77B,$06 Give the other object the speed along x of the object.
N $B781 Step the distance closer to zero while the objects still overlap.
@ $B781 label=BlockMovementInX_Reduce
  $B781,$01 Fetch the distance along x.
  $B782,$03 Call #R$B95A to step it one closer to zero.
  $B785,$01 Set the distance.
  $B786,$01 Return if the distance is zero.
  $B787,$02 Jump to #R$B757 to test again.
@ $B789 label=BlockMovementInX_NextObject
  $B789,$05 Move #REGiy on to the next object record.
  $B78E,$02 Decrease the counter and loop until all the objects have been tried.
  $B790,$01 Return.

c $B791 Block Movement In Y
@ $B791 label=BlockMovementInY
D $B791 Cuts down the distance that an object moves along y until it does not go
. through any other object, in the same way as #R$B742 does for x.
E $B791 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CBE9 }
. { #ALIENEIGHT$C4E6 }
. LIST#
R $B791 L Distance to move along y
R $B791 IX Object record
R $B791 O:L Distance that can be moved
N $B791 Try the object against each of the objects in turn.
  $B791,$04 Start with the first object record, #R$A76F.
  $B795,$02 Set a counter in #REGb of #N$36 objects.
@ $B797 label=BlockMovementInY_Next
  $B797,$05 Jump to #R$B7D8 if the other object is not in use, or is being
. moved.
  $B79C,$05 Jump to #R$B7D8 if the objects do not overlap along x.
  $B7A1,$05 Jump to #R$B7D8 if the objects do not overlap along z.
@ $B7A6 label=BlockMovementInY_Test
  $B7A6,$05 Jump to #R$B7D8 if the objects will not overlap along y when the
. object has moved.
N $B7AB The objects hit each other. Flag a hit along y and pass on the hit
. flags.
  $B7AB,$04 Flag that the object has been stopped along y.
  $B7AF,$03 Fetch the hit flags of the object.
  $B7B2,$01 Move bit 7 down to bit 6.
  $B7B3,$02,b$01 Keep only bit 6.
  $B7B5,$03 Add the hit flags of the other object.
  $B7B8,$03 Write them to the other object.
  $B7BB,$01 Move bit 5 of the hit flags of the other object up to bit 6.
  $B7BC,$02,b$01 Keep only bit 6.
  $B7BE,$03 Add the hit flags of the object.
  $B7C1,$03 Write them to the object.
N $B7C4 Push the other object, if it can be pushed.
  $B7C4,$06 Jump to #R$B7D0 if the other object cannot be pushed.
  $B7CA,$06 Give the other object the speed along y of the object.
N $B7D0 Step the distance closer to zero while the objects still overlap.
@ $B7D0 label=BlockMovementInY_Reduce
  $B7D0,$01 Fetch the distance along y.
  $B7D1,$03 Call #R$B95A to step it one closer to zero.
  $B7D4,$01 Set the distance.
  $B7D5,$01 Return if the distance is zero.
  $B7D6,$02 Jump to #R$B7A6 to test again.
@ $B7D8 label=BlockMovementInY_NextObject
  $B7D8,$05 Move #REGiy on to the next object record.
  $B7DD,$02 Decrease the counter and loop until all the objects have been tried.
  $B7DF,$01 Return.

c $B7E0 Block Movement In Z
@ $B7E0 label=BlockMovementInZ
D $B7E0 Cuts down the distance that an object moves along z until it does not go
. through any other object. A hit along z means that the object has landed on
. the other one (or has bumped its head on it), so the routine also deals with
. the things that are done to an object that is stood on.
D $B7E0 When an object is stopped, the two objects share their hit flags, the
. one underneath is marked as being stood on, and an object that can be pushed
. is carried along: it takes the speeds of the object it is on.
R $B7E0 H Distance to move along z
R $B7E0 IX Object record
R $B7E0 O:H Distance that can be moved
N $B7E0 Try the object against each of the objects in turn.
  $B7E0,$04 Start with the first object record, #R$A76F.
  $B7E4,$02 Set a counter in #REGb of #N$36 objects.
@ $B7E6 label=BlockMovementInZ_Next
  $B7E6,$05 Jump to #R$B85E if the other object is not in use, or is being
. moved.
  $B7EB,$05 Jump to #R$B85E if the objects do not overlap along x.
  $B7F0,$05 Jump to #R$B85E if the objects do not overlap along y.
@ $B7F5 label=BlockMovementInZ_Test
  $B7F5,$05 Jump to #R$B85E if the objects will not overlap along z when the
. object has moved.
N $B7FA The objects hit each other. Flag a hit along z, which also means the
. object is on the ground.
  $B7FA,$04 Flag that the object has been stopped along z.
  $B7FE,$03 Call #R$B890 to flag the other object if the object is a part of the
. player or a block of type #N$5B.
N $B801 Flag the object if it is standing on the player.
  $B801,$03 Fetch the type of the other object.
  $B804,$04 Jump to #R$B810 if it is below #N$20, the first part of the player.
  $B808,$04 Jump to #R$B810 if it is #N$28 or more, which is not a part of the
. player.
  $B80C,$04 Flag that the object is on the player.
N $B810 An object that stands on a moving block is pushed by it.
@ $B810 label=BlockMovementInZ_Block
  $B810,$04 Jump to #R$B819 if the other object is below #N$8C, the first of the
. moving blocks.
  $B814,$05 Call #R$B866 to push the object if the other object is a moving
. block, which is when it is below #N$90.
N $B819 Pass on the hit flags, and flag that the other object has something on
. it.
@ $B819 label=BlockMovementInZ_HitFlags
  $B819,$03 Fetch the hit flags of the object.
  $B81C,$01 Move bit 7 down to bit 6.
  $B81D,$02,b$01 Keep only bit 6.
  $B81F,$03 Add the hit flags of the other object.
  $B822,$03 Write them to the other object.
  $B825,$01 Move bit 5 of the hit flags of the other object up to bit 6.
  $B826,$02,b$01 Keep only bit 6.
  $B828,$03 Add the hit flags of the object.
  $B82B,$03 Write them to the object.
  $B82E,$04 Flag that the other object has something on it.
N $B832 Carry an object that can be pushed. It takes the speed along z of the
. object, and the speeds along x and y if it has none.
  $B832,$06 Jump to #R$B856 if the object cannot be pushed.
  $B838,$06 Give the other object the speed along z of the object.
  $B83E,$06 Jump to #R$B84A if the object is moving along x.
  $B844,$06 Give the object the speed along x of the other object.
@ $B84A label=BlockMovementInZ_CarryY
  $B84A,$06 Jump to #R$B856 if the object is moving along y.
  $B850,$06 Give the object the speed along y of the other object.
N $B856 Step the distance closer to zero while the objects still overlap.
@ $B856 label=BlockMovementInZ_Reduce
  $B856,$01 Fetch the distance along z.
  $B857,$03 Call #R$B95A to step it one closer to zero.
  $B85A,$01 Set the distance.
  $B85B,$01 Return if the distance is zero.
  $B85C,$02 Jump to #R$B7F5 to test again.
@ $B85E label=BlockMovementInZ_NextObject
  $B85E,$05 Move #REGiy on to the next object record.
  $B863,$02 Decrease the counter and loop until all the objects have been tried.
  $B865,$01 Return.

c $B866 Push Object On Block
@ $B866 label=PushObjectOnBlock
D $B866 Pushes an object that stands on a moving block. The type of the block
. gives the direction of the push, in the low two bits, and the object is pushed
. on every other frame. The pushes are in a table of pairs of speeds at #R$D30A.
D $B866 A block is not pushed if it already has something on it, so the first
. thing on it does the pushing.
R $B866 A Type of the block
R $B866 IX Object record
R $B866 IY Block record
  $B866,$05 Return if the block already has something on it.
  $B86B,$02,b$01 Keep the two bits that give the direction.
  $B86D,$01 Double it, to get an offset into the table of pairs.
  $B86E,$02 Stash #REGde and #REGhl on the stack.
  $B870,$03 Set #REGde to the offset.
  $B873,$03 Fetch the frame counter.
  $B876,$02,b$01 Keep only bit 0.
  $B878,$02 Jump to #R$B88D if it is an even frame.
  $B87A,$03 Use the table of pushes, #R$D30A.
  $B87D,$01 Add the offset.
  $B87E,$01 Fetch the push along x.
  $B87F,$03 Add it to the speed of the object along x.
  $B882,$03 Write it back.
  $B885,$01 Move on to the push along y.
  $B886,$01 Fetch it.
  $B887,$03 Add it to the speed of the object along y.
  $B88A,$03 Write it back.
@ $B88D label=PushObjectOnBlock_Done
  $B88D,$02 Restore #REGhl and #REGde from the stack.
  $B88F,$01 Return.

c $B890 Mark Object Below
@ $B890 label=MarkObjectBelow
D $B890 Flags the object that a part of the player, or a block of type #N$5B,
. has landed on, by setting bit 7 of its handler flags. Nothing is done for any
. other type of object.
R $B890 IX Object record
R $B890 IY Record of the object that has been landed on
  $B890,$03 Fetch the type of the object.
  $B893,$04 Jump to #R$B89D if it is a block of type #N$5B.
  $B897,$02 Compare the type with #N$20, the first part of the player.
  $B899,$01 Return if it is lower.
  $B89A,$02 Compare the type with #N$28.
  $B89C,$01 Return if it is higher, which means that it is not a part of the
. player.
@ $B89D label=MarkObjectBelow_Set
  $B89D,$04 Flag the object as having a player or block on it.
  $B8A1,$01 Return.

c $B8A2 Test Overlap In X
@ $B8A2 label=TestOverlapInX
D $B8A2 Tests if two objects overlap along x, once the first one has moved by a
. distance. The objects overlap if the distance between their centres is less
. than the sum of their half sizes.
E $B8A2 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CC9D }
. { #ALIENEIGHT$C5A9 }
. LIST#
R $B8A2 C Distance that the first object moves along x
R $B8A2 IX Record of the first object
R $B8A2 IY Record of the second object
R $B8A2 O:F Carry flag set if the objects overlap
  $B8A2,$07 Add the half sizes of the objects along x together, in #REGd.
  $B8A9,$07 Work out the distance between the centres, once the first has moved.
  $B8B0,$03 Jump to #R$B8B5 if the distance is positive.
  $B8B3,$02 Make the distance positive.
@ $B8B5 label=TestOverlapInX_Compare
  $B8B5,$01 Subtract the sum of the half sizes, which sets the carry flag if
. they overlap.
  $B8B6,$01 Return.

c $B8B7 Test Overlap In Y
@ $B8B7 label=TestOverlapInY
D $B8B7 Tests if two objects overlap along y, once the first one has moved by a
. distance, in the same way as #R$B8A2 does for x.
E $B8B7 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CCB2 }
. { #ALIENEIGHT$C5BE }
. LIST#
R $B8B7 L Distance that the first object moves along y
R $B8B7 IX Record of the first object
R $B8B7 IY Record of the second object
R $B8B7 O:F Carry flag set if the objects overlap
  $B8B7,$07 Add the half sizes of the objects along y together, in #REGd.
  $B8BE,$07 Work out the distance between the centres, once the first has moved.
  $B8C5,$03 Jump to #R$B8CA if the distance is positive.
  $B8C8,$02 Make the distance positive.
@ $B8CA label=TestOverlapInY_Compare
  $B8CA,$01 Subtract the sum of the half sizes, which sets the carry flag if
. they overlap.
  $B8CB,$01 Return.

c $B8CC Test Overlap In Z
@ $B8CC label=TestOverlapInZ
D $B8CC Tests if two objects overlap along z, once the first one has moved by a
. distance. The z position of an object is its bottom, so the distance between
. the bottoms is compared with the height of the object that is the lower of the
. two.
E $B8CC View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CCC7 }
. { #ALIENEIGHT$C5D3 }
. LIST#
R $B8CC H Distance that the first object moves along z
R $B8CC IX Record of the first object
R $B8CC IY Record of the second object
R $B8CC O:F Carry flag set if the objects overlap
  $B8CC,$07 Work out the distance between the bottoms of the objects, once the
. first has moved.
  $B8D3,$03 Jump to #R$B8DD if the first object is the higher.
  $B8D6,$02 Make the distance positive.
  $B8D8,$03 Fetch the height of the first object, which is the lower.
@ $B8DB label=TestOverlapInZ_Compare
  $B8DB,$01 Subtract the height of the lower object, which sets the carry flag
. if they overlap.
  $B8DC,$01 Return.
@ $B8DD label=TestOverlapInZ_SecondLower
  $B8DD,$03 Fetch the height of the second object, which is the lower.
  $B8E0,$02 Jump to #R$B8DB.

c $B8E2 Keep Object In Room In X
@ $B8E2 label=KeepObjectInRoomInX
D $B8E2 Cuts down the distance that an object moves along x until it stays
. inside the walls of the room, and flags a hit on x in the collision flags if
. it had to. Nothing is done if the object is allowed to ignore the walls, or
. has only just entered the room (which is when the top four bits of its
. collision flags are not zero), as it would be outside them.
D $B8E2 The limit is in #R$A71D, and the walls are placed an equal distance
. either side of position #N$80.
E $B8E2 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CCDD }
. { #ALIENEIGHT$C5E9 }
. LIST#
R $B8E2 C Distance to move along x
R $B8E2 IX Object record
R $B8E2 O:C Distance that can be moved
  $B8E2,$03 Fetch the collision flags.
  $B8E5,$02,b$01 Keep only the countdown from entering the room.
  $B8E7,$01 Return if the object has only just entered the room.
  $B8E8,$05 Return if the object ignores the walls.
  $B8ED,$04 Fetch the limit along x in #REGb.
@ $B8F1 label=KeepObjectInRoomInX_Test
  $B8F1,$04 Work out the position of the object along x, once it has moved.
  $B8F5,$02 Subtract #N$80 to get its distance from the middle.
  $B8F7,$02 Jump to #R$B8FB if that is not negative.
  $B8F9,$02 Make the distance positive.
@ $B8FB label=KeepObjectInRoomInX_Compare
  $B8FB,$03 Add the half size of the object, to get the distance of its edge
. from the middle.
  $B8FE,$03 Return if the edge is inside the limit.
  $B901,$04 Flag that the object has been stopped along x.
  $B905,$01 Fetch the distance to move.
  $B906,$03 Call #R$B95A to step it one closer to zero.
  $B909,$01 Set the distance.
  $B90A,$02 Jump to #R$B8F1 to test again, unless the distance is zero.
@ $B90C label=KeepObjectInRoomInX_Done
  $B90C,$01 Return.

c $B90D Keep Object In Room In Y
@ $B90D label=KeepObjectInRoomInY
D $B90D Cuts down the distance that an object moves along y until it stays
. inside the walls of the room, in the same way as #R$B8E2 does for x. The limit
. is in #R$A71E.
E $B90D View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CD08 }
. { #ALIENEIGHT$C613 }
. LIST#
R $B90D L Distance to move along y
R $B90D IX Object record
R $B90D O:L Distance that can be moved
  $B90D,$03 Fetch the collision flags.
  $B910,$02,b$01 Keep only the countdown from entering the room.
  $B912,$01 Return if the object has only just entered the room.
  $B913,$05 Return if the object ignores the walls.
  $B918,$04 Fetch the limit along y in #REGb.
@ $B91C label=KeepObjectInRoomInY_Test
  $B91C,$04 Work out the position of the object along y, once it has moved.
  $B920,$02 Subtract #N$80 to get its distance from the middle.
  $B922,$02 Jump to #R$B926 if that is not negative.
  $B924,$02 Make the distance positive.
@ $B926 label=KeepObjectInRoomInY_Compare
  $B926,$03 Add the half size of the object, to get the distance of its edge
. from the middle.
  $B929,$03 Return if the edge is inside the limit.
  $B92C,$04 Flag that the object has been stopped along y.
  $B930,$01 Fetch the distance to move.
  $B931,$03 Call #R$B95A to step it one closer to zero.
  $B934,$01 Set the distance.
  $B935,$02 Jump to #R$B91C to test again, unless the distance is zero.
@ $B937 label=KeepObjectInRoomInY_Done
  $B937,$01 Return.

c $B938 Calculate Sprite Size
@ $B938 label=CalculateSpriteSize
D $B938 Works out the size on the screen of the sprite of an object, without
. drawing it, and stores it in the object. The width is one more than the width
. of the sprite data if the sprite has to be shifted.
E $B938 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CD33 }
. { #ALIENEIGHT$C63D }
. LIST#
R $B938 IX Object record
  $B938,$03 Call #R$B2C5 to work out the screen position of the object.
  $B93B,$03 Call #R$B2EE to get the address of its sprite.
  $B93E,$03 Fetch the screen x co-ordinate.
  $B941,$02,b$01 Keep the number of bits that the sprite is shifted by.
  $B943,$02 Fetch the width of the sprite, and move on to its height.
  $B945,$02 Jump to #R$B948 if the sprite is not shifted.
  $B947,$01 Add one to the width for the shift.
@ $B948 label=CalculateSpriteSize_Store
  $B948,$02,b$01 Keep only the width.
  $B94A,$03 Write the width to the object.
  $B94D,$01 Fetch the height of the sprite.
  $B94E,$03 Write the height to the object.
  $B951,$01 Return.

c $B952 Read Keyboard Port
@ $B952 label=ReadKeyboardPort
D $B952 Reads half-rows of the keyboard. The pressed keys come back as set bits,
. in the same order as the bits that the keyboard port gives, so bit 0 is the
. key that is nearest the outside edge of the keyboard.
D $B952 The value is also written to port #N$FD first, whose effect on a 128K
. Spectrum, which uses that port number for paging, is not known.
E $B952 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B5F7 }
. { #ALIENEIGHT$B759 }
. { #NIGHTSHADE$E239 }
. { #GUNFRIGHT$D0DB }
. { #CYBERUN$9BC3 }
. LIST#
R $B952 A High byte of the port, which selects the half-rows: a bit that is
. clear selects a half-row
R $B952 O:A Keys pressed, in bits 0 to 4
  $B952,$02 Write the value to port #N$FD.
  $B954,$02 Read the keyboard half-rows.
  $B956,$01 Make the pressed keys set bits.
  $B957,$02,b$01 Keep only the five keys.
  $B959,$01 Return.

c $B95A Bring Speed Closer To Zero
@ $B95A label=BringSpeedCloserToZero
D $B95A Moves a signed value one step closer to zero.
E $B95A View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA89 }
. { #ALIENEIGHT$C386 }
. LIST#
R $B95A A Value
R $B95A O:A The value, one closer to zero
R $B95A O:F Zero flag set if the result is zero
  $B95A,$02 Return if the value is zero.
  $B95C,$03 Jump to #R$B961 if the value is positive.
  $B95F,$02 Add two to a negative value...
@ $B961 label=BringSpeedCloserToZero_Subtract
  $B961,$01 ...and subtract one from a positive value (or one from the two added
. to a negative value).
  $B962,$01 Return.

c $B963 Stop Object At Floor
@ $B963 label=StopObjectAtFloor
D $B963 Cuts down the distance that an object moves along z until it stays above
. the floor of the room, whose height is in #R$A71F. Sets the flag in the
. collision flags that says the object is on the ground if it had to.
E $B963 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA5A }
. { #ALIENEIGHT$C357 }
. LIST#
R $B963 H Distance to move along z
R $B963 IX Object record
R $B963 O:H Distance that can be moved
  $B963,$04 Fetch the height of the floor in #REGd.
@ $B967 label=StopObjectAtFloor_Test
  $B967,$04 Work out the height of the bottom of the object, once it has moved.
  $B96B,$02 Return if it is not below the floor.
  $B96D,$04 Flag that the object has been stopped along z, which is on the
. ground.
  $B971,$01 Fetch the distance to move.
  $B972,$03 Call #R$B95A to step it one closer to zero.
  $B975,$01 Set the distance.
  $B976,$02 Jump to #R$B967 to test again, unless the distance is zero.
  $B978,$01 Return.

c $B979 Apply Gravity And Move
@ $B979 label=ApplyGravityAndMove
D $B979 Applies gravity to an object, moves it by its speeds (limited to where
. it is able to go by #R$B6ED, which changes the speeds), and updates its
. position.
E $B979 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C700 }
. { #ALIENEIGHT$BFB6 }
. LIST#
R $B979 IX Object record
  $B979,$03 Reduce the speed along z by one, which is gravity.
@ $B97C label=ApplyGravityAndMove_Move
  $B97C,$03 Call #R$B6ED to move the object.
@ $B97F label=ApplyGravityAndMove_AddSpeeds
  $B97F,$09 Add the speed along x to the position along x.
  $B988,$09 Add the speed along y to the position along y.
  $B991,$09 Add the speed along z to the position along z.
  $B99A,$01 Return.

c $B99B Test Object Solid
@ $B99B label=TestObjectSolid
D $B99B Tests if an object takes part in the collision tests: it must be in use
. and must not be the one that is being moved.
E $B99B View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B538 }
. { #ALIENEIGHT$B74D }
. LIST#
R $B99B IY Object record
R $B99B O:F Zero flag set if the object is free, or is being moved
  $B99B,$05 Return with the zero flag set if the object is free.
  $B9A0,$04 Fetch the flags, inverted.
  $B9A4,$02,b$01 Test the flag for being moved, which is set in the object being
. moved.
  $B9A6,$01 Return.

c $B9A7 Flag Overlapping Objects
@ $B9A7 label=FlagOverlappingObjects
D $B9A7 Flags every object whose sprite overlaps the area that an object has
. just moved through, so that they are redrawn as well, otherwise they would be
. left with a piece cut out of them when the area was cleared. The area is the
. rectangle that covers both the old and the new places of the sprite of the
. object, which is in whole bytes, so only the columns are compared in bytes.
D $B9A7 An object is flagged by setting bit 4 of its flags.
E $B9A7 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CD4D }
. { #ALIENEIGHT$C657 }
. LIST#
R $B9A7 IX Object record
N $B9A7 Work out the size of the new sprite, which is stored in the object.
  $B9A7,$04 Start with the first object record, #R$A76F.
  $B9AB,$03 Call #R$B938 to work out the size of the sprite of the object.
  $B9AE,$02 Set a counter in #REGb of #N$36 objects.
N $B9B0 Work out the first column of the area, which is the lower of the new and
. the old first columns.
  $B9B0,$06 Divide the new x co-ordinate by eight...
  $B9B6,$02,b$01 ...and keep only the five bits of the column.
  $B9B8,$01 Set #REGl to the new first column.
  $B9B9,$06 Divide the old x co-ordinate by eight...
  $B9BF,$02,b$01 ...and keep only the five bits of the column.
  $B9C1,$01 Set #REGh to the old first column.
  $B9C2,$03 Jump to #R$B9C6 if the old column is lower.
  $B9C5,$01 Use the new column.
@ $B9C6 label=FlagOverlappingObjects_Width
  $B9C6,$01 Set #REGe to the first column of the area.
N $B9C7 Work out the width of the area, which is up to the higher of the new and
. the old last columns.
  $B9C7,$04 Add the new width to the new first column to get the new last
. column.
  $B9CB,$01 Set #REGl to it.
  $B9CC,$04 Add the old width to the old first column to get the old last
. column.
  $B9D0,$03 Jump to #R$B9D4 if the old last column is higher.
  $B9D3,$01 Use the new last column.
@ $B9D4 label=FlagOverlappingObjects_Bottom
  $B9D4,$01 Subtract the first column to get the width of the area.
  $B9D5,$01 Set #REGd to the width of the area.
N $B9D6 Work out the bottom of the area, which is the lower of the new and the
. old bottoms.
  $B9D6,$06 Fetch the new y co-ordinate and compare it with the old one.
  $B9DC,$02 Jump to #R$B9E1 if the new one is lower.
  $B9DE,$03 Use the old one.
@ $B9E1 label=FlagOverlappingObjects_Height
  $B9E1,$01 Set #REGl to the bottom of the area.
N $B9E2 Work out the height of the area, which is up to the higher of the new
. and the old tops.
  $B9E2,$06 Add the new height to the new y co-ordinate to get the new top.
  $B9E8,$01 Set #REGh to it.
  $B9E9,$06 Add the old height to the old y co-ordinate to get the old top.
  $B9EF,$03 Jump to #R$B9F3 if the old top is higher.
  $B9F2,$01 Use the new top.
@ $B9F3 label=FlagOverlappingObjects_Loop
  $B9F3,$01 Subtract the bottom to get the height of the area.
  $B9F4,$01 Set #REGh to the height of the area.
N $B9F5 Test each of the other objects against the area.
@ $B9F5 label=FlagOverlappingObjects_Next
  $B9F5,$06 Jump to #R$BA1C if the other object is free.
  $B9FB,$06 Jump to #R$BA1C if the other object is already flagged.
  $BA01,$06 Divide the screen x co-ordinate of the other object by eight...
  $BA07,$02,b$01 ...and keep only the five bits of the column.
  $BA09,$01 Subtract the first column of the area.
  $BA0A,$02 Jump to #R$BA26 if it starts before the area.
  $BA0C,$01 Compare the distance with the width of the area.
@ $BA0D label=FlagOverlappingObjects_TestColumns
  $BA0D,$02 Jump to #R$BA1C if it starts after the area.
  $BA0F,$04 Subtract the bottom of the area from the screen y co-ordinate of the
. other object.
  $BA13,$02 Jump to #R$BA2D if it starts below the area.
  $BA15,$01 Compare the distance with the height of the area.
@ $BA16 label=FlagOverlappingObjects_TestRows
  $BA16,$02 Jump to #R$BA1C if it starts above the area.
  $BA18,$04 Flag the other object as needing to be drawn.
@ $BA1C label=FlagOverlappingObjects_Skip
  $BA1C,$07 Move #REGiy on to the next object record, using the alternate
. registers so that the area is kept.
  $BA23,$02 Decrease the counter and loop until all the objects have been tried.
  $BA25,$01 Return.
N $BA26 The other object starts before the area, so it only overlaps it if it is
. wide enough to reach it.
@ $BA26 label=FlagOverlappingObjects_StartsBefore
  $BA26,$02 Make the distance positive.
  $BA28,$03 Compare it with the width of the other object.
  $BA2B,$02 Jump to #R$BA0D to jump to the next object if it is not wide enough,
. or to carry on with the test if it is.
N $BA2D The other object starts below the area, so it only overlaps it if it is
. tall enough to reach it.
@ $BA2D label=FlagOverlappingObjects_StartsBelow
  $BA2D,$02 Make the distance positive.
  $BA2F,$03 Compare it with the height of the other object.
  $BA32,$02 Jump to #R$BA16 to jump to the next object if it is not tall enough,
. or to carry on with the test if it is.

c $BA34 Check Inventory
@ $BA34 label=CheckInventory
D $BA34 Redraws the inventory if the flag to say that it has changed is set, and
. clears the flag. Otherwise returns.
  $BA34,$03 Fetch the flag from #R$A720.
  $BA37,$02 Return if the inventory has not changed.
  $BA39,$01 Clear #REGa.
  $BA3A,$03 Write #N$00 to #R$A720, as the inventory is about to be redrawn.

c $BA3D Display Objects Carried
@ $BA3D label=DisplayObjectsCarried
D $BA3D Draws the three icons of the inventory in the bottom left of the screen.
. The icons are drawn into the buffer, which is copied to the screen, and the
. colours of the icons are put in the attributes. The temporary object at
. #R$BACA is used to draw them.
E $BA3D View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BC9D }
. { #KNIGHTLORE$BF45 }
. LIST#
.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$BA3D and #R$B178 }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #SIM(start=$AFBF,stop=$AFDA,sp=$5E00)
. #SIM(start=$AFDA,stop=$B06C,sp=$5E00)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$03,$02,$12,$0A,$06(objects-carried-before)
. | #POKES$A726,$70;$A72A,$71;$A72E,$72
. #SIM(start=$BA3D,stop=$0000,sp=$5D00)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$03,$02,$12,$0A,$06(objects-carried-after) } UDGTABLE# #POPS
N $BA3D Set up for the three entries of the inventory.
  $BA3D,$02 Stash #REGix on the stack.
  $BA3F,$04 Use the temporary object, #R$BACA.
  $BA43,$02 Set a counter in #REGb of three entries.
  $BA45,$03 Start with the first carried object, #R$A726.
@ $BA48 label=DisplayObjectsCarried_Next
N $BA48 Work out the x co-ordinate of the icon, which is #N$10 plus #N$18 for
. each icon so far, and clear its place in the buffer.
  $BA48,$02 Stash the counter and the pointer on the stack.
  $BA4A,$01 Fetch the counter.
  $BA4B,$02 Negate it...
  $BA4D,$02 ...and add three, to get the number of the icon.
  $BA4F,$02 Multiply it by two...
  $BA51,$02 ...and by two...
  $BA53,$02 ...and by two.
  $BA55,$01 Stash the number times eight in #REGc.
  $BA56,$02 Multiply by two again, which makes #N$10 times the number.
  $BA58,$01 Add the earlier value to make it #N$18 times the number.
  $BA59,$02 Add #N$10.
  $BA5B,$03 Write it as the screen x co-ordinate of the temporary object.
  $BA5E,$04 Write #N$00 as the screen y co-ordinate.
  $BA62,$03 Set #REGc to the x co-ordinate.
  $BA65,$03 Set #REGb to the y co-ordinate.
  $BA68,$01 Stash the pointer on the stack.
  $BA69,$03 Call #R$B37F to get the address in the buffer.
  $BA6C,$02 Copy it to #REGhl.
  $BA6E,$03 Set the size of the area in #REGbc to #N$03 bytes wide and #N$18
. lines.
  $BA71,$01 Set the fill byte in #REGa to #N$00.
  $BA72,$03 Call #R$B6DD to clear the area.
  $BA75,$01 Restore the pointer from the stack.
N $BA76 Draw the icon, if there is an object in this entry.
  $BA76,$01 Fetch the type of the object.
  $BA77,$03 Jump to #R$BA80 if the carried entry is empty.
  $BA7A,$03 Set the type of the temporary object.
  $BA7D,$03 Call #R$B3E7 to draw its sprite.
N $BA80 Copy the icon to the screen.
@ $BA80 label=DisplayObjectsCarried_Copy
  $BA80,$03 Set #REGc to the x co-ordinate.
  $BA83,$03 Set #REGb to the y co-ordinate.
  $BA86,$03 Call #R$B394 to get the address in the display file.
  $BA89,$03 Call #R$B37F to get the address in the buffer.
  $BA8C,$02 Copy it to #REGhl.
  $BA8E,$03 Set the size of the area in #REGbc to #N$18 lines and #N$03 bytes
. wide.
  $BA91,$03 Call #R$B278 to copy the icon to the screen.
N $BA94 Set the colour of the icon from the type of the object.
  $BA94,$04 Restore the pointer and the counter from the stack, and stash them
. again.
  $BA98,$01 Fetch the type of the object.
  $BA99,$02,b$01 Keep only the three bits that choose the colour.
  $BA9B,$03 Set #REGde to the offset into the table of colours.
  $BA9E,$03 Use the table of colours, #R$BAC2.
  $BAA1,$01 Add the offset.
  $BAA2,$01 Fetch the colour into #REGc.
  $BAA3,$03 Set #REGl to the x co-ordinate.
  $BAA6,$05 Add #N$17 to the y co-ordinate to get to the top of the icon.
  $BAAB,$01 Set #REGh to it.
  $BAAC,$03 Call #R$B3B6 to get the address in the attribute file.
  $BAAF,$01 Move it to #REGhl.
  $BAB0,$01 Set the colour in #REGa.
  $BAB1,$03 Set the size of the area in #REGbc to three bytes wide and three
. lines.
  $BAB4,$03 Call #R$B6DD to set the attributes.
  $BAB7,$02 Restore the pointer and the counter from the stack.
  $BAB9,$04 Move on to the next entry, which is four bytes on.
  $BABD,$02 Decrease the counter and loop until all three icons have been drawn.
  $BABF,$02 Restore #REGix from the stack.
  $BAC1,$01 Return.

b $BAC2 Inventory Colours
@ $BAC2 label=InventoryColours
D $BAC2 The attribute used for an inventory icon, which is chosen by the lowest
. three bits of the type of the object. They are bright blue, red, magenta,
. green, cyan, yellow and white ink on a black paper (twice for white).
B $BAC2,$01 #COLOUR(#PEEK(#PC)).
L $BAC2,$01,$08

g $BACA Temporary Object
@ $BACA label=TemporaryObject
D $BACA An object record that is used to draw the icons of the inventory, the
. frame around the room and the lives, as the drawing routine needs an object.
. Only the type, the flags and the screen position are set.
B $BACA,$20,$08

c $BAEA Print Character
@ $BAEA label=PrintCharacter
D $BAEA Draws a character into the buffer, a #N$08 by #N$08 block of pixels, and
. leaves the address ready for the next character. A space is drawn as the glyph
. with code #N$3D, which is blank. The glyph is found in the table at the
. address in #R$A732: the address of a glyph is that address plus the code times
. eight.
E $BAEA View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BBEB }
. { #KNIGHTLORE$BE7F }
. LIST#
R $BAEA A Character code
R $BAEA HL Address in the buffer of the top line of the place for the character
R $BAEA O:HL Address in the buffer of the top line of the place to the right
N $BAEA Find the glyph.
  $BAEA,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $BAED,$04 Jump to #R$BAF3 if the character is not a space.
  $BAF1,$02 Use the glyph for the code #N$3D instead, which is blank.
@ $BAF3 label=PrintCharacter_Glyph
  $BAF3,$03 Set #REGhl to the character code.
  $BAF6,$03 Multiply it by eight.
  $BAF9,$04 Fetch the address of the glyph table from #R$A732.
  $BAFD,$01 Add it to get the address of the glyph.
  $BAFE,$01 Set #REGde to it.
  $BAFF,$01 Restore #REGhl, the address in the buffer, from the stack.
N $BB00 Copy the eight lines of the glyph to the buffer, working down the buffer
. from the top line.
  $BB00,$02 Set a counter in #REGb of eight lines.
@ $BB02 label=PrintCharacter_Loop
  $BB02,$02 Copy a line of the glyph to the buffer.
  $BB04,$01 Move on to the next line of the glyph.
  $BB05,$01 Stash the counter on the stack.
  $BB06,$03 Set #REGbc to #N$FFE0, which is minus the length of a line of the
. buffer.
  $BB09,$01 Move #REGhl down to the next line of the buffer.
  $BB0A,$01 Restore the counter.
  $BB0B,$02 Decrease the counter and loop until all eight lines have been
. copied.
N $BB0D Move on to the next character position, which is eight lines up and one
. byte to the right.
  $BB0D,$01 Restore #REGde from the stack.
  $BB0E,$04 Add #N$0101 to #REGhl.
  $BB12,$01 Restore #REGbc from the stack.
  $BB13,$01 Return.

c $BB14 Print Score Label
@ $BB14 label=PrintScoreLabel
D $BB14 Prints the word SCORE to the buffer, in bright white, and then goes on
. to print the score itself.
.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$BB14 and #R$B178 }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #SIM(start=$AFBF,stop=$AFD4,sp=$5E00)
. #SIM(start=$CB6A,stop=$0000,sp=$5D00,a=$47)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$03,$16,$13,$0A,$05(print-score-label-before)
. | #SIM(start=$BB14,stop=$0000,sp=$5D00)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$03,$16,$13,$0A,$05(print-score-label-after) } UDGTABLE# #POPS
  $BB14,$03 Set #REGhl to the position of the word.
  $BB17,$02 Set the text colour to bright white.
  $BB19,$03 Write it to #R$A736.
  $BB1C,$03 Take the text at #R$BB24.
  $BB1F,$03 Call #R$BC66 to print the text.
  $BB22,$02 Jump to #R$BB3B to print the score.

t $BB24 Messaging: Score Label
@ $BB24 label=ScoreLabel
D $BB24 The last character has bit 7 set.
  $BB24,$05,$04:$01 "SCORE"

c $BB29 Add To Score
@ $BB29 label=AddToScore
D $BB29 Adds an amount to the score, which is held as three bytes of binary
. coded decimal, with the most significant byte first, and then draws the new
. score.
.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$BB29 and #R$B178 }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #SIM(start=$AFBF,stop=$AFDA,sp=$5E00)
. #SIM(start=$AFDA,stop=$B087,sp=$5E00)
. #SCR$03,$16,$13,$0A,$05(add-to-score-before)
. | #SIM(start=$BB29,stop=$0000,sp=$5D00,bc=$0150)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$03,$16,$13,$0A,$05(add-to-score-after) } UDGTABLE# #POPS
R $BB29 BC Amount to add, as four decimal digits
  $BB29,$03 Start at the last byte of the score, #R$A744.
  $BB2C,$04 Add the last two digits of the amount to the last two digits of the
. score.
  $BB30,$01 Move to the next byte of the score.
  $BB31,$04 Add the next two digits of the amount, and the carry.
  $BB35,$01 Move to the first byte of the score.
  $BB36,$05 Add the carry to the first two digits of the score.

c $BB3B Draw Score
@ $BB3B label=DrawScore
D $BB3B Draws the six digits of the score into the buffer, at the bottom of the
. screen on the right.
  $BB3B,$03 Set #REGb to the y co-ordinate and #REGc to the x co-ordinate of the
. place for the score.
  $BB3E,$03 Call #R$B37F to get the address in the buffer.
  $BB41,$02 Copy it to #REGhl.
  $BB43,$03 Take the score at #R$A744.
  $BB46,$02 Set a counter in #REGb of three bytes.

c $BB48 Print BCD Number
@ $BB48 label=PrintBCDNumber
D $BB48 Draws the digits of binary coded decimal bytes, two to a byte, into the
. buffer, using the digit glyphs at the start of the font.
E $BB48 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BCAE }
. { #ALIENEIGHT$BA62 }
. { #MARTIANOIDS$B5AF }
. LIST#
R $BB48 B Number of bytes
R $BB48 DE Address of the first byte
R $BB48 HL Address in the buffer of the top line of the place for the first
. digit
  $BB48,$01 Stash the buffer address on the stack.
  $BB49,$06 Set the glyph table to the start of the font, #N$8355, where the
. digits are.
  $BB4F,$01 Restore the buffer address from the stack.
  $BB50,$01 Fetch the byte.
  $BB51,$04 Move the upper digit down to the bottom four bits.
  $BB55,$02,b$01 Keep only the digit.
  $BB57,$03 Call #R$BAEA to print it.
@ $BB5A label=PrintBCDNumber_Lower
  $BB5A,$01 Fetch the byte again.
  $BB5B,$02,b$01 Keep only the lower digit.
  $BB5D,$03 Call #R$BAEA to print it.
  $BB60,$01 Move on to the next byte.
  $BB61,$02 Decrease the counter and loop until all the bytes have been done.
  $BB63,$01 Return.

c $BB64 Set Flashing Attribute
@ $BB64 label=SetFlashingAttribute
D $BB64 Makes one of the colours of a list of colours flash, and stops the
. others from flashing, by setting or clearing bit 7. This is used to show the
. chosen line of the menu.
E $BB64 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BEA3 }
. { #ALIENEIGHT$BC15 }
. { #NIGHTSHADE$CA1B }
. { #MARTIANOIDS$BB73 }
. LIST#
R $BB64 A Number of the colour to make flash
R $BB64 B Number of colours
R $BB64 HL Address of the first colour
  $BB64,$03 Jump to #R$BB6E if this is not the first colour.
@ $BB67 label=SetFlashingAttribute_Flash
  $BB67,$02 Make the colour flash.
  $BB69,$02 Jump to #R$BB70.
@ $BB6B label=SetFlashingAttribute_Next
  $BB6B,$03 Jump to #R$BB67 when the countdown reaches that colour.
@ $BB6E label=SetFlashingAttribute_Steady
  $BB6E,$02 Stop the colour from flashing.
@ $BB70 label=SetFlashingAttribute_Loop
  $BB70,$01 Move on to the next colour.
  $BB71,$02 Decrease the counter and loop until all the colours have been done.
  $BB73,$01 Return.

c $BB74 Game Selection Menu
@ $BB74 label=GameMenu
D $BB74 Shows the title screen with the menu of control methods, and waits for
. the player to choose a method and start the game. The menu text is drawn again
. on every pass, so that the line that is chosen flashes. A tune is played while
. the menu is on the screen.
D $BB74 Keys #N$31 to #N$34 choose the keyboard, a Kempston joystick, a cursor
. joystick or an Interface II joystick, and key #N$30 starts the game. The
. choice is held in #R$A709.
E $BB74 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BA7E }
. { #KNIGHTLORE$BD0C }
. { #MARTIANOIDS$BB12 }
. { #NIGHTSHADE$C8CA }
. LIST#
.
. #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune)))
.
. #PUSHS #UDGTABLE { =h The menu }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #SCR$02(game-selection-menu) } UDGTABLE#
. #HTML(<div hidden>)
. #SCR$02(screen-frame)
. #HTML(</div>)
. #POPS
N $BB74 Clear the buffer and draw the menu.
  $BB74,$04 Write #N$00 to #R$A734, so that the frame will be drawn.
  $BB78,$03 Start at the colours of the lines of the menu, #R$BBF1.
  $BB7B,$02 Set a counter in #REGb of eight bytes.
@ $BB7D label=GameMenu_Steady
  $BB7D,$02 Stop the colour from flashing.
  $BB7F,$01 Move on to the next colour.
  $BB80,$02 Decrease the counter and loop until all the colours are steady.
  $BB82,$03 Call #R$CB81 to clear the buffer.
  $BB85,$03 Call #R$BCB4 to draw the menu.
  $BB88,$03 Call #R$BBD8 to make the chosen line flash.
@ $BB8B label=GameMenu_Loop
  $BB8B,$03 Call #R$BCB4 to draw the menu.
  $BB8E,$03 Take the menu tune, #R$D7CF.
  $BB91,$03 Call #R$D69C to play it until a key is pressed.
N $BB94 Read the keys that choose the control method.
  $BB94,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $BB99,$01 Stash the keys that are pressed in #REGe.
  $BB9A,$03 Fetch the control method from #R$A709.
  $BB9D,$03 Copy it to #R$A70C.
  $BBA0,$04 Jump to #R$BBA6 if key #N$31 is not pressed.
  $BBA4,$02,b$01 Choose the keyboard, by clearing the bits of the control
. method.
@ $BBA6 label=GameMenu_TestKempston
  $BBA6,$04 Jump to #R$BBAE if key #N$32 is not pressed.
  $BBAA,$02,b$01 Clear the bits of the control method...
  $BBAC,$02,b$01 ...and choose the Kempston joystick.
@ $BBAE label=GameMenu_TestCursor
  $BBAE,$04 Jump to #R$BBB6 if key #N$33 is not pressed.
  $BBB2,$02,b$01 Clear the bits of the control method...
  $BBB4,$02,b$01 ...and choose the cursor joystick.
@ $BBB6 label=GameMenu_TestInterfaceII
  $BBB6,$04 Jump to #R$BBBC if key #N$34 is not pressed.
  $BBBA,$02,b$01 Choose the Interface II joystick.
@ $BBBC label=GameMenu_SetMethod
  $BBBC,$03 Write the control method to #R$A709.
  $BBBF,$03 Address #R$A735, which is not used.
  $BBC2,$03 Take the previous control method, #R$A70C.
  $BBC5,$01 Compare the control method with the previous one, which is not used.
N $BBC6 Start the game if key #N$30 is pressed.
  $BBC6,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $BBCB,$03 Return if key #N$30 is pressed.
  $BBCE,$04 Count the pass in #R$A70A.
  $BBD2,$03 Call #R$BBD8 to make the chosen line flash.
  $BBD5,$03 Jump to #R$BB8B for another pass.

c $BBD8 Flash Menu Options
@ $BBD8 label=FlashMenuOptions
D $BBD8 Makes the line of the menu that shows the chosen control method flash,
. and stops the other three from flashing. The line that starts the game flashes
. if bit 3 of #R$A709 is set, which the menu never does.
E $BBD8 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BD89 }
. { #ALIENEIGHT$BAFB }
. { #NIGHTSHADE$C949 }
. LIST#
  $BBD8,$03 Start at the colour of the first control method line, which is
. the byte after the first of #R$BBF1.
  $BBDB,$03 Fetch the control method.
  $BBDE,$01 Shift the method down to bits 0 and 1...
  $BBDF,$02,b$01 ...and keep only those bits.
  $BBE1,$02 Set a counter in #REGb of four lines.
  $BBE3,$03 Call #R$BB64 to make that line flash.
  $BBE6,$02 Stop the line that starts the game from flashing.
  $BBE8,$03 Fetch the control method.
  $BBEB,$02,b$01 Keep only bit 3.
  $BBED,$01 Return if it is not set.
  $BBEE,$02 Make the line that starts the game flash.
  $BBF0,$01 Return.

b $BBF1 Menu Colours
@ $BBF1 label=MenuColours
D $BBF1 The attribute of each line of the menu. Bit 7, which makes the line
. flash, is set for the line that is chosen. The lines are the title, the four
. control methods, the line that starts the game and the copyright line.
B $BBF1,$01 The title: #COLOUR(#PEEK(#PC)).
@ $BBF2 label=MenuColours_ControlMethods
B $BBF2,$01 #COLOUR(#PEEK(#PC)).
L $BBF2,$01,$06

b $BBF8 Menu Positions
@ $BBF8 label=MenuPositions
D $BBF8 The x and y co-ordinates of each line of the menu.
B $BBF8,$0E,$02

t $BC06 Messaging: Menu Text
@ $BC06 label=MenuText
D $BC06 The lines of the menu. The last character of each has bit 7 set. The
. character #N$3C is a copyright symbol.
  $BC06,$09,$08:$01 "PENTAGRAM"
  $BC0F,$0A,$09:$01 "1 KEYBOARD"
  $BC19,$13,$12:$01 "2 KEMPSTON JOYSTICK"
  $BC2C,$13,$12:$01 "3 CURSOR   JOYSTICK"
  $BC3F,$0E,$0D:$01 "4 INTERFACE II"
  $BC4D,$0C,$0B:$01 "0 START GAME"
  $BC59,$0D,$0C:$01 "< 1986 A:C:G:"

c $BC66 Print Text Single Colour
@ $BC66 label=PrintTextSingleColour
D $BC66 Prints a string to the buffer and sets the attributes of its characters
. to the text colour in #R$A736. The last character of the string has bit 7 set.
. The font used is the one at #N$8355, whose first character is code #N$30, and
. which is shifted so that the address of the glyph for a code is found by
. adding the code times eight to #N$81D5. The attributes are written straight to
. the screen.
E $BC66 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BE31 }
. { #ALIENEIGHT$BB9D }
. LIST#
.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$BC66 and #R$B178 }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #SIM(start=$AFBF,stop=$AFDA,sp=$5E00)
. #SIM(start=$AFDA,stop=$B078,sp=$5E00)
. #POKES$A736,$46
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$03,$09,$13,$0C,$04(print-text-before)
. | #SIM(start=$BC66,stop=$0000,sp=$5D00,de=$BB24,hl=$1F68)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$03,$09,$13,$0C,$04(print-text-after) } UDGTABLE# #POPS
R $BC66 DE Address of the string
R $BC66 H Pixel y co-ordinate of the string, counting up from the bottom of the
. screen
R $BC66 L Pixel x co-ordinate of the string
R $BC66 O:DE Address after the string
  $BC66,$01 Stash the position on the stack.
  $BC67,$06 Point the glyph table at #N$81D5.
  $BC6D,$01 Fetch the position into #REGbc.
  $BC6E,$01 Stash the position on the stack again.
  $BC6F,$03 Call #R$B37F to get the address in the buffer.
  $BC72,$02 Copy it to #REGhl.
  $BC74,$03 Fetch the text colour.
  $BC77,$01 Stash the colour in #REGaf'.
  $BC78,$02 Jump to #R$BC8B to print the string.

c $BC7A Print Text Standard Font
@ $BC7A label=PrintTextStandardFont
D $BC7A Prints a string like #R$BC66 does, but takes the colour from the first
. byte of the string. This is not used by the game.
E $BC7A View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BE45 }
. { #ALIENEIGHT$BBB1 }
. LIST#
R $BC7A DE Address of the colour and the string
R $BC7A H Pixel y co-ordinate of the string, counting up from the bottom of the
. screen
R $BC7A L Pixel x co-ordinate of the string
  $BC7A,$01 Stash the position on the stack.
  $BC7B,$06 Point the glyph table at #N$81D5.
  $BC81,$01 Fetch the position into #REGbc.
  $BC82,$01 Stash the position on the stack again.
  $BC83,$03 Call #R$B37F to get the address in the buffer.
  $BC86,$02 Copy it to #REGhl.
  $BC88,$01 Fetch the colour from the string.
  $BC89,$01 Stash the colour in #REGaf'.
  $BC8A,$01 Move on to the string.

c $BC8B Print Text
@ $BC8B label=PrintText
D $BC8B The part of #R$BC66 that prints the characters and their attributes. The
. alternate registers hold the address in the attribute file, and the main
. registers hold the address in the buffer.
  $BC8B,$01 Switch to the alternate registers.
  $BC8C,$01 Fetch the position from the stack.
  $BC8D,$01 Stash the string pointer on the stack.
  $BC8E,$03 Call #R$B3B6 to get the address in the attribute file.
  $BC91,$02 Copy it to #REGhl'.
  $BC93,$01 Restore the string pointer.
@ $BC94 label=PrintText_Next
  $BC94,$01 Switch to the main registers.
  $BC95,$01 Fetch the next character.
  $BC96,$04 Jump to #R$BCA7 if it is the last character.
  $BC9A,$01 Stash the string pointer on the stack.
  $BC9B,$03 Call #R$BAEA to print the character.
  $BC9E,$01 Restore the string pointer.
  $BC9F,$01 Move on to the next character.
  $BCA0,$01 Switch to the alternate registers.
  $BCA1,$04 Write the colour to the attribute file and move on to the next
. attribute.
  $BCA5,$02 Jump to #R$BC94 to print the next character.
@ $BCA7 label=PrintText_Last
  $BCA7,$02,b$01 Clear bit 7 of the character.
  $BCA9,$06 Print it, and move on to the end of the string.
  $BCAF,$01 Switch to the alternate registers.
  $BCB0,$02 Write the colour to the attribute file.
  $BCB2,$01 Switch back to the main registers.
  $BCB3,$01 Return.

c $BCB4 Display Menu
@ $BCB4 label=DisplayMenu
D $BCB4 Prints the seven lines of the menu, each in its own colour and position.
. The first time that this is called the frame is drawn as well and the whole
. buffer is copied to the screen: after that only the attributes change, as the
. line that flashes is changed by writing them straight to the screen.
E $BCB4 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BC25 }
. { #KNIGHTLORE$BEB3 }
. { #NIGHTSHADE$CA2B }
. LIST#
.
. #PUSHS #UDGTABLE { =h After #R$BCB4 }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB85,sp=$5E00)
. #SIM(start=$BCB4,stop=$0000,sp=$5D00)
. #SCR$02(display-menu) } UDGTABLE# #POPS
  $BCB4,$03 Take the colours of the lines, #R$BBF1.
  $BCB7,$01 Switch to the alternate registers.
  $BCB8,$03 Take the positions of the lines, #R$BBF8.
  $BCBB,$03 Take the text of the lines, #R$BC06.
  $BCBE,$02 Set a counter in #REGbc' of seven lines.
@ $BCC0 label=DisplayMenu_Next
  $BCC0,$01 Switch to the main registers.
  $BCC1,$01 Fetch the colour of the line.
  $BCC2,$03 Write it to #R$A736 as the text colour.
  $BCC5,$01 Move on to the next colour.
  $BCC6,$01 Switch to the alternate registers.
  $BCC7,$01 Stash the counter on the stack.
  $BCC8,$01 Fetch the x co-ordinate of the line.
  $BCC9,$02 Move on to the next position.
  $BCCB,$01 Stash the pointer on the stack.
  $BCCC,$01 Take the y co-ordinate.
  $BCCD,$01 Set #REGh to it.
  $BCCE,$01 Set #REGl to the x co-ordinate.
  $BCCF,$03 Call #R$BC66 to print the line.
  $BCD2,$02 Restore the pointer and the counter from the stack.
  $BCD4,$02 Decrease the counter and loop until all the lines have been printed.
  $BCD6,$05 Return if the frame has already been drawn.
  $BCDB,$01 Take #N$01 as the flag that the frame has been drawn.
  $BCDC,$03 Write it to #R$A734, to say that the frame has been drawn.
  $BCDF,$03 Call #R$BD59 to draw the frame of the menu.
  $BCE2,$03 Jump to #R$B178 to copy the buffer to the screen.

c $BCE5 Draw Frame
@ $BCE5 label=DrawFrame
D $BCE5 Draws the frame around the room into the buffer, from the pieces whose
. data starts at #R$BD31. The frame is made of runs of the same piece, drawn one
. after another, each a fixed distance from the last. The temporary object at
. #R$BACA is used to draw them.
.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$BCE5 and #R$B178 }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #SIM(start=$AFBF,stop=$AFDA,sp=$5E00)
. #SIM(start=$AFDA,stop=$B06F,sp=$5E00)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$01(draw-frame-before)
. | #SIM(start=$BCE5,stop=$0000,sp=$5D00)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$01(draw-frame-after) } UDGTABLE# #POPS
  $BCE5,$04 Use the temporary object, #R$BACA.
  $BCE9,$03 Take the data of the pieces, #R$BD31.
N $BCEC Draw the sloping edge on the left, which runs down to the right.
  $BCEC,$03 Call #R$BDC0 to set up the first piece.
  $BCEF,$03 Set the distance between pieces, which is #N$10 to the right and
. #N$08 down.
  $BCF2,$02 Set a counter in #REGb of five pieces.
  $BCF4,$03 Call #R$BDDE to draw them.
N $BCF7 Draw the sloping edge on the right, which runs down to the left.
  $BCF7,$03 Call #R$BDC0 to set up the next piece.
  $BCFA,$03 Set the distance between pieces, which is #N$10 to the left and
. #N$08 down.
  $BCFD,$02 Set a counter in #REGb of five pieces.
  $BCFF,$03 Call #R$BDDE to draw them.
N $BD02 Draw the two upright edges at the sides, which are each made of two runs
. that go up and are drawn one above the other.
  $BD02,$03 Call #R$BDC0 to set up the next piece.
  $BD05,$03 Set the distance between pieces, which is #N$20 up.
  $BD08,$02 Set a counter in #REGb of two pieces.
  $BD0A,$03 Call #R$BDDE to draw them.
  $BD0D,$03 Call #R$BDC0 to set up the next piece.
  $BD10,$02 Set a counter in #REGb of two pieces.
  $BD12,$03 Call #R$BDDE to draw them.
  $BD15,$03 Call #R$BDC0 to set up the next piece.
  $BD18,$02 Set a counter in #REGb of two pieces.
  $BD1A,$03 Call #R$BDDE to draw them.
  $BD1D,$03 Call #R$BDC0 to set up the next piece.
  $BD20,$02 Set a counter in #REGb of two pieces.
  $BD22,$03 Call #R$BDDE to draw them.
N $BD25 Draw the two pieces in the middle of the bottom, and the cap at the top
. of each upright edge.
  $BD25,$09 Call #R$BDD5 to draw each of the first three of those pieces.
  $BD2E,$03 Jump to #R$BDD5.

b $BD31 Frame Pieces
@ $BD31 label=FramePieces
D $BD31 The pieces of the frame that #R$BCE5 draws. Each is four bytes: the type
. of the object that is drawn, its flags (which mirror the piece when bit 6 is
. set), and the x and y screen co-ordinates of the first one. The first six are
. drawn several times each.
B $BD31,$04,$04 Sloping edge on the left, mirrored, starting at the top.
B $BD35,$04,$04 Sloping edge on the right, starting at the top.
B $BD39,$04,$04 Upright edge on the left, mirrored, first kind of piece.
B $BD3D,$04,$04 Upright edge on the right, first kind of piece.
B $BD41,$04,$04 Upright edge on the left, mirrored, second kind of piece.
B $BD45,$04,$04 Upright edge on the right, second kind of piece.
B $BD49,$04,$04 Piece in the middle of the bottom, on the left, mirrored.
B $BD4D,$04,$04 Piece in the middle of the bottom, on the right.
B $BD51,$04,$04 Cap at the top of the upright edge on the left, mirrored.
B $BD55,$04,$04 Cap at the top of the upright edge on the right.

c $BD59 Print Border
@ $BD59 label=PrintBorder
D $BD59 Draws the frame around the title screen, and around the end screens,
. into the buffer, from the pieces whose data starts at #R$BD98. It is made of
. four corners, two long edges, and two shorter ones, each drawn as a run of
. pieces.
E $BD59 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D296 }
. { #ALIENEIGHT$CB8A }
. LIST#
.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$BD59 and #R$B178 }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB85,sp=$5E00)
. #SIM(start=$BCB4,stop=$BCDF,sp=$5E00)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$01(print-border-before)
. | #SIM(start=$BD59,stop=$0000,sp=$5D00)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$01(print-border-after) } UDGTABLE# #POPS
  $BD59,$04 Use the temporary object, #R$BACA.
  $BD5D,$03 Take the data of the pieces, #R$BD98.
N $BD60 Draw the four corners.
  $BD60,$0C Call #R$BDD5 to draw each of the four corners.
N $BD6C Draw the top edge and the bottom edge, which run to the right.
  $BD6C,$03 Call #R$BDC0 to set up the top edge.
  $BD6F,$03 Set the distance between pieces, which is #N$18 to the right.
  $BD72,$02 Set a counter in #REGb of eight pieces.
  $BD74,$03 Call #R$BDDE to draw them.
  $BD77,$03 Call #R$BDC0 to set up the bottom edge.
  $BD7A,$02 Set a counter in #REGb of eight pieces.
  $BD7C,$03 Call #R$BDDE to draw them.
N $BD7F Draw the two pieces that finish the top and bottom edges.
  $BD7F,$06 Call #R$BDD5 to draw each of the two.
N $BD85 Draw the left edge and the right edge, which run up.
  $BD85,$03 Call #R$BDC0 to set up the left edge.
  $BD88,$03 Set the distance between pieces, which is #N$18 up.
  $BD8B,$02 Set a counter in #REGb of six pieces.
  $BD8D,$03 Call #R$BDDE to draw them.
  $BD90,$03 Call #R$BDC0 to set up the right edge.
  $BD93,$02 Set a counter in #REGb of six pieces.
  $BD95,$03 Jump to #R$BDDE.

b $BD98 Menu Frame Pieces
@ $BD98 label=MenuFramePieces
D $BD98 The pieces of the frame that #R$BD59 draws, in the same form as the
. pieces of #R$BD31. The flags mirror a piece when bit 6 is set, and flip it
. upside down when bit 7 is set.
B $BD98,$04,$04 Bottom left corner.
B $BD9C,$04,$04 Bottom right corner, mirrored.
B $BDA0,$04,$04 Top right corner, mirrored and flipped.
B $BDA4,$04,$04 Top left corner, flipped.
B $BDA8,$04,$04 Bottom edge, first piece.
B $BDAC,$04,$04 Top edge, first piece, flipped.
B $BDB0,$04,$04 Bottom edge, end piece.
B $BDB4,$04,$04 Top edge, end piece, flipped.
B $BDB8,$04,$04 Left edge, first piece.
B $BDBC,$04,$04 Right edge, first piece, mirrored.

c $BDC0 Set Sprite Details
@ $BDC0 label=SetSpriteDetails
D $BDC0 Sets up the temporary object from the four bytes that describe a piece
. of a frame: the type, the flags and the screen position.
E $BDC0 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D237 }
. { #ALIENEIGHT$CAF1 }
. LIST#
R $BDC0 HL Address of the data
R $BDC0 IX Temporary object record
R $BDC0 O:HL Address of the data after the piece
  $BDC0,$05 Set the type of the object.
  $BDC5,$05 Set the flags of the object.
  $BDCA,$05 Set the screen x co-ordinate of the object.
  $BDCF,$05 Set the screen y co-ordinate of the object.
  $BDD4,$01 Return.

c $BDD5 Print Table Sprite
@ $BDD5 label=PrintTableSprite
D $BDD5 Sets up a piece of a frame from its data, and draws it.
E $BDD5 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D24C }
. { #ALIENEIGHT$CB06 }
. LIST#
R $BDD5 HL Address of the data
R $BDD5 IX Temporary object record
R $BDD5 O:HL Address of the data after the piece
  $BDD5,$03 Call #R$BDC0 to set up the piece.
  $BDD8,$01 Stash the data pointer on the stack.
  $BDD9,$03 Call #R$B3E7 to draw the piece.
  $BDDC,$01 Restore the data pointer.
  $BDDD,$01 Return.

c $BDDE Print Sprites
@ $BDDE label=PrintSprites
D $BDDE Draws a number of copies of the piece in the temporary object, one after
. another, each the same distance from the last.
E $BDDE View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BEE4 }
. { #ALIENEIGHT$BC56 }
. LIST#
R $BDDE B Number of pieces
R $BDDE D Distance up the screen from one piece to the next
R $BDDE E Distance to the right from one piece to the next
R $BDDE IX Temporary object record
  $BDDE,$03 Stash the counter, the distance and the data pointer on the stack.
  $BDE1,$03 Call #R$B3E7 to draw the piece.
  $BDE4,$03 Restore the data pointer, the distance and the counter.
  $BDE7,$07 Move the piece on to the right.
  $BDEE,$07 Move the piece up.
  $BDF5,$02 Decrease the counter and loop until all the pieces have been drawn.
  $BDF7,$01 Return.

c $BDF8 Read Controls
@ $BDF8 label=ReadControls
D $BDF8 Reads the keyboard or the joystick, according to the control method that
. was chosen in the menu, and writes what is wanted to #R$A737 as a set of bits:
D $BDF8 #TABLE(default,centre,centre)
. { =h Bit | =h Meaning }
. { #N$00 | Turn left }
. { #N$01 | Turn right }
. { #N$02 | Walk forward }
. { #N$03 | Jump }
. { #N$04 | Pick up or drop an object }
. { #N$06 | Fire }
. TABLE#
D $BDF8 With the keyboard, any of several keys do each action. With a joystick,
. up walks forward, down jumps and fire fires, and a long list of the keys of
. the keyboard picks up or drops an object.
D $BDF8 CAPS SHIFT and SPACE are left alone by this routine, as they pause the
. game (see #R$B4E0).
E $BDF8 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C8FF }
. { #GUNFRIGHT$D0E3 }
. LIST#
R $BDF8 O:C The controls, also written to #R$A737
N $BDF8 Find the control method: #N$00 is the keyboard, #N$01 is a Kempston
. joystick, #N$02 is a cursor joystick and #N$03 is an Interface II joystick.
  $BDF8,$03 Fetch the control method.
  $BDFB,$01 Shift the method down to bits 0 and 1...
  $BDFC,$02,b$01 ...and keep only those bits.
  $BDFE,$03 Jump to #R$BE91 to read the keyboard if the method is #N$00.
  $BE01,$03 Jump to #R$BE40 to read a Kempston joystick if the method is #N$01.
  $BE04,$03 Jump to #R$BE65 to read a cursor joystick if the method is #N$02.
N $BE07 Read an Interface II joystick, which can be either of the two ports of
. the interface: they are the keys 1 to 5 (left, right, down, up, fire) and the
. keys 6, 7, 8, 9 and 0 (left, right, down, up, fire).
  $BE07,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $BE0C,$01 Stash #REGbc on the stack.
  $BE0D,$02 Set a counter in #REGb of five keys.
@ $BE0F label=ReadControls_Reverse
  $BE0F,$05 Reverse the order of the five bits, so that they line up with the
. keys of the second port.
  $BE14,$01 Move the reversed keys to #REGa.
  $BE15,$01 Restore #REGbc from the stack.
  $BE16,$01 Move the reversed keys to #REGc.
  $BE17,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $BE1C,$01 Add the keys from the first port to those of the second.
  $BE1D,$02 Start with no controls.
  $BE1F,$06 Set the bit for fire if fire is pressed.
@ $BE25 label=ReadControls_Interface2Up
  $BE25,$06 Set the bit for walking forward if up is pressed.
@ $BE2B label=ReadControls_Interface2Down
  $BE2B,$06 Set the bit for jumping if down is pressed.
@ $BE31 label=ReadControls_Interface2Right
  $BE31,$06 Set the bit for turning right if right is pressed.
@ $BE37 label=ReadControls_Interface2Left
  $BE37,$06 Set the bit for turning left if left is pressed.
@ $BE3D label=ReadControls_Interface2Keys
  $BE3D,$03 Jump to #R$BEFD to check the keys for picking up and dropping.
N $BE40 Read a Kempston joystick, whose bits are right, left, down, up and fire.
@ $BE40 label=ReadControls_Kempston
  $BE40,$02 Read the joystick.
  $BE42,$02 Start with no controls.
  $BE44,$06 Set the bit for turning right if right is pressed.
@ $BE4A label=ReadControls_KempstonLeft
  $BE4A,$06 Set the bit for turning left if left is pressed.
@ $BE50 label=ReadControls_KempstonDown
  $BE50,$06 Set the bit for jumping if down is pressed.
@ $BE56 label=ReadControls_KempstonUp
  $BE56,$06 Set the bit for walking forward if up is pressed.
@ $BE5C label=ReadControls_KempstonFire
  $BE5C,$06 Set the bit for fire if fire is pressed.
@ $BE62 label=ReadControls_KempstonKeys
  $BE62,$03 Jump to #R$BEFD to check the keys for picking up and dropping.
N $BE65 Read a cursor joystick, which is the keys 5 (left), 6 (down), 7 (up), 8
. (right) and 0 (fire).
@ $BE65 label=ReadControls_Cursor
  $BE65,$02 Start with no controls.
  $BE67,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $BE6C,$06 Set the bit for turning left if the key 5 is pressed.
@ $BE72 label=ReadControls_CursorFire
  $BE72,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $BE77,$06 Set the bit for fire if the key 0 is pressed.
@ $BE7D label=ReadControls_CursorUp
  $BE7D,$06 Set the bit for walking forward if the key 7 is pressed.
@ $BE83 label=ReadControls_CursorRight
  $BE83,$06 Set the bit for turning right if the key 8 is pressed.
@ $BE89 label=ReadControls_CursorDown
  $BE89,$06 Set the bit for jumping if the key 6 is pressed.
  $BE8F,$02 Jump to #R$BEFD to check the keys for picking up and dropping.
N $BE91 Read the keyboard. The keys that turn left are Z, C, M and B and those
. that turn right are X, V, SYMBOL SHIFT and N.
@ $BE91 label=ReadControls_Keyboard
  $BE91,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | CAPS SHIFT | Z | X | C | V }
. TABLE#
  $BE96,$01 Shift the keys down by one, which drops CAPS SHIFT and leaves Z and
. C for turning left, and X and V for turning right.
  $BE97,$01 Stash them in #REGc.
  $BE98,$02,b$01 Keep the keys Z and X.
  $BE9A,$04 Shift the keys C and V down to the same place.
  $BE9E,$01 Combine them with the keys Z and X.
  $BE9F,$02,b$01 Keep the two bits for turning left and turning right.
  $BEA1,$01 Set the turning bits of the controls.
  $BEA2,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | SYMBOL SHIFT | M | N | B }
. TABLE#
  $BEA7,$06 Set the bit for turning right if SYMBOL SHIFT is pressed.
@ $BEAD label=ReadControls_KeyboardM
  $BEAD,$06 Set the bit for turning left if M is pressed.
@ $BEB3 label=ReadControls_KeyboardN
  $BEB3,$06 Set the bit for turning right if N is pressed.
@ $BEB9 label=ReadControls_KeyboardB
  $BEB9,$06 Set the bit for turning left if B is pressed.
@ $BEBF label=ReadControls_KeyboardWalk
  $BEBF,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$BD | A or ENTER | S or L | D or K | F or J | G or H }
. TABLE#
  $BEC4,$04 Set the bit for walking forward if any of those keys is pressed.
@ $BEC8 label=ReadControls_KeyboardJumpKeys
  $BEC8,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DF | P | O | I | U | Y }
. TABLE#
  $BECD,$01 Stash the keys in #REGb, which is not used.
  $BECE,$02,b$01 Keep the keys O and U.
  $BED0,$02 Jump to #R$BEDC if either of them is pressed.
  $BED2,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FB | Q | W | E | R | T }
. TABLE#
  $BED7,$01 Stash the keys in #REGe, which is not used.
  $BED8,$02,b$01 Keep the keys Q, E and T.
  $BEDA,$02 Jump to #R$BEDE if none of them is pressed.
@ $BEDC label=ReadControls_KeyboardJump
  $BEDC,$02 Set the bit for jumping, as one of the keys Q, E, T, O and U is
. pressed.
@ $BEDE label=ReadControls_KeyboardAction
  $BEDE,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$E7 | 1 or 0 | 2 or 9 | 3 or 8 | 4 or 7 | 5 or 6 }
. TABLE#
  $BEE3,$02 Jump to #R$BEE7 if none of the number keys is pressed.
  $BEE5,$02 Set the bit for picking up and dropping, as a number key is pressed.
@ $BEE7 label=ReadControls_KeyboardFire
  $BEE7,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DF | P | O | I | U | Y }
. TABLE#
  $BEEC,$02,b$01 Keep the keys P, I and Y.
  $BEEE,$02 Jump to #R$BEF9 if one of them is pressed.
  $BEF0,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FB | Q | W | E | R | T }
. TABLE#
  $BEF5,$02,b$01 Keep the keys W and R.
  $BEF7,$02 Jump to #R$BF08 if neither is pressed.
@ $BEF9 label=ReadControls_KeyboardSetFire
  $BEF9,$02 Set the bit for fire, as one of the keys P, I, Y, W and R is
. pressed.
  $BEFB,$02 Jump to #R$BF08 to finish.
N $BEFD With a joystick, the keys of the keyboard other than CAPS SHIFT and
. SPACE are used to pick up and drop an object.
@ $BEFD label=ReadControls_Keys
  $BEFD,$05 Read from the keyboard, with a call to #R$B952 that returns the
. pressed keys as set bits;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | CAPS SHIFT or SPACE | Z or SYMBOL SHIFT | X or M | C or N | V or B }
. TABLE#
  $BF02,$02,b$01 Keep the keys other than CAPS SHIFT and SPACE.
  $BF04,$02 Jump to #R$BF08 if none of them is pressed.
  $BF06,$02 Set the bit for picking up and dropping.
@ $BF08 label=ReadControls_Done
  $BF08,$01 Copy the controls to #REGa.
  $BF09,$03 Write them to #R$A737.
  $BF0C,$01 Return.

c $BF0D Reset Wipe Flags
@ $BF0D label=ResetWipeFlags
D $BF0D Clears the flag in all of the object records that says that an object
. has moved and that the area where it was has to be restored. This is done once
. the room has been drawn in full, as that makes the flag out of date.
E $BF0D View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B088 }
. { #ALIENEIGHT$A7DC }
. LIST#
  $BF0D,$02 Set a counter in #REGb of the number of object records, #N$36.
  $BF0F,$03 Set the size of an object record in #REGde.
  $BF12,$03 Start at the flags of the first record of #R$A76F.
@ $BF15 label=ResetWipeFlags_Loop
  $BF15,$02 Clear bit 5 of the flags, to say that the object has not moved.
  $BF17,$01 Move on to the flags of the next object.
  $BF18,$02 Decrease the counter and loop until all the records have been done.
  $BF1A,$01 Return.

c $BF1B Test Object Intersections
@ $BF1B label=TestObjectIntersections
D $BF1B Tests if an object is overlapping any other object, where it is at the
. moment. This is used to find out if there is room to put the object somewhere,
. once its position has been changed.
E $BF1B View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B4FD }
. { #ALIENEIGHT$B712 }
. LIST#
R $BF1B IX Record of the object
R $BF1B O:F Carry flag set if the object overlaps another object
  $BF1B,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $BF1E,$02 Stash #REGiy on the stack.
  $BF20,$04 Start with the first object record, #R$A76F.
  $BF24,$02 Set a counter in #REGb of the number of object records, #N$36.
  $BF26,$02 Set the distance moved along x to zero.
  $BF28,$02 Set the distances moved along y and z to zero.
  $BF2A,$04 Flag the object as being moved, so that it is not tested against
. itself.
N $BF2E Test whether this object overlaps on all three axes.
@ $BF2E label=TestObjectIntersections_Loop
  $BF2E,$05 Jump to #R$BF4C to try the next object if this one is free, or is
. the object that is being tested.
  $BF33,$05 Jump to #R$BF4C to try the next object if they do not overlap along
. x.
  $BF38,$05 Jump to #R$BF4C to try the next object if they do not overlap along
. y.
  $BF3D,$05 Jump to #R$BF4C to try the next object if they do not overlap along
. z.
N $BF42 The objects overlap on all three axes (and the carry flag is set), or
. there are none left to try (and it is not).
@ $BF42 label=TestObjectIntersections_Done
  $BF42,$02 Restore #REGiy from the stack.
  $BF44,$03 Restore #REGhl, #REGde and #REGbc from the stack.
  $BF47,$04 Clear the flag that says that the object is being moved.
  $BF4B,$01 Return.
N $BF4C Move on to the next object.
@ $BF4C label=TestObjectIntersections_Next
  $BF4C,$05 Move on to the next object record.
  $BF51,$02 Decrease the counter and loop until all the records have been tried.
  $BF53,$01 Clear the carry flag, as nothing overlaps the object.
  $BF54,$02 Jump to #R$BF42.

c $BF56 Set Wipe And Draw Flags For Object
@ $BF56 label=SetWipeAndDrawFlagsForObject
D $BF56 Does what #R$CCDE does for the object in #REGiy, which is to say that it
. has to be drawn again, and that the area where it was has to be restored.
E $BF56 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C69D }
. { #ALIENEIGHT$ADF3 }
. LIST#
R $BF56 IY Record of the object
  $BF56,$04 Stash #REGiy and #REGix on the stack.
  $BF5A,$04 Copy #REGiy to #REGix, using the stack.
  $BF5E,$03 Call #R$CCDE to mark the object.
  $BF61,$04 Restore #REGix and #REGiy from the stack.
  $BF65,$01 Return.

c $BF66 Test Pickup Drop Key
@ $BF66 label=TestPickupDropKey
D $BF66 Tests if the key for picking up and dropping objects is being pressed.
. There is a way to read it from a different bit when the control method has bit
. 3 set, but nothing ever sets that bit.
E $BF66 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$BFFB }
. { #ALIENEIGHT$BD58 }
. LIST#
R $BF66 O:F Zero flag clear if the key is being pressed
  $BF66,$03 Take the control method, #R$A709.
  $BF69,$01 Fetch the control method.
  $BF6A,$02,b$01 Keep only the bits that choose a joystick.
  $BF6C,$03 Fetch the controls from #R$A737.
  $BF6F,$02 Jump to #R$BF76 if the keyboard is being used.
  $BF71,$04 Jump to #R$BF76 if bit 3 of the control method is not set.
  $BF75,$01 Shift the bits of the controls down by one place.
@ $BF76 label=TestPickupDropKey_Mask
  $BF76,$02,b$01 Keep only the bit for picking up and dropping.
  $BF78,$01 Return.

c $BF79 Handle Pickup And Drop
@ $BF79 label=HandlePickupAndDrop
D $BF79 Deals with the key for picking up and dropping objects. The key only
. does something once for each time that it is pressed, and only if the player
. is standing on the ground, away from the walls.
D $BF79 If the player is touching an object that can be carried, it is picked
. up. The player carries three objects at most, so if the carried objects are
. all in use the oldest one is dropped in its place. If the player is not
. touching anything, the object that is in the last place of the inventory (the
. oldest one) is dropped, if there is a free object record and nothing is in the
. way above the player. When that place is empty, the carried objects are only
. moved along one place towards it.
D $BF79 An object is dropped by creating it in a free object record, at the
. position of the player, who is moved up out of the way.
E $BF79 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C00E }
. { #ALIENEIGHT$BD6B }
. LIST#
R $BF79 IX Record of the object of the legs of the player
N $BF79 Do nothing if the key is still being held down from the last time.
  $BF79,$03 Fetch the flag from #R$A740.
  $BF7C,$04 Jump to #R$C00E if the key was already being held down.
N $BF80 The key was not being held, so find out if it is pressed, and if the
. player is able to pick things up or drop them.
  $BF80,$04 Return if the key is not being pressed.
  $BF84,$04 Return if the player is touching a wall.
  $BF88,$05 Return if the player is jumping.
  $BF8D,$05 Return if the player is not on the ground.
  $BF92,$04 Clear the flag that says that there is no room to drop an object.
  $BF96,$04 Stash the height of the player in #REGb.
  $BF9A,$05 Raise the player by #N$0C.
  $BF9F,$03 Call #R$BF1B to find out if there is room for the player there.
  $BFA2,$03 Put the player back where it was.
  $BFA5,$02 Jump to #R$BFAC if there is room.
  $BFA7,$05 Set the flag that says that there is no room to drop an object.
@ $BFAC label=HandlePickupAndDrop_Start
  $BFAC,$05 Set the flag that says that the key is being held down.
  $BFB1,$03 Set the flag to redraw the inventory in #R$A720.
  $BFB4,$02 Set a counter in #REGb of the number of ordinary object records,
. which is #N$30.
N $BFB6 Make the player larger by #N$04 along each axis, so that it can touch
. objects that are close.
  $BFB6,$09 Make the half size along x larger by #N$04.
  $BFBF,$09 Make the half size along y larger by #N$04.
  $BFC8,$01 Stash the old half sizes along x and y on the stack.
  $BFC9,$09 Make the size along z larger by #N$04.
  $BFD2,$01 Stash the old size along z on the stack.
  $BFD3,$04 Start with the first ordinary object record, #R$A82F.
@ $BFD7 label=HandlePickupAndDrop_Search
N $BFD7 Look for an object that can be picked up.
  $BFD7,$03 Call #R$C0D4 to test if the object can be picked up and touches the
. player.
  $BFDA,$03 Jump to #R$C0A7 to pick it up if it does.
  $BFDD,$05 Move on to the next object record.
  $BFE2,$02 Decrease the counter and loop until all the records have been tried.
N $BFE4 Nothing can be picked up, so look for a free object record to drop an
. object in.
  $BFE4,$05 Jump to #R$BFFC if the key is no longer pressed.
  $BFE9,$03 Set the size of an object record in #REGde.
  $BFEC,$02 Set a counter in #REGb of the number of ordinary object records.
  $BFEE,$04 Start with the first ordinary object record.
@ $BFF2 label=HandlePickupAndDrop_FindFree
  $BFF2,$06 Jump to #R$C017 to drop an object if this record is free.
  $BFF8,$04 Advance to the next record and loop until all of them have been
. tried.
@ $BFFC label=HandlePickupAndDrop_Done
N $BFFC Put the size of the player back to what it was, and make a noise.
  $BFFC,$04 Restore the old size along z.
  $C000,$01 Restore the old half sizes along x and y.
  $C001,$06 Put the old half sizes back.
  $C007,$06 Start a sound effect with a type of #N$01 and a count of #N$05.
  $C00D,$01 Return.

c $C00E Check Action Key Released
@ $C00E label=CheckActionKeyReleased
D $C00E Clears the flag that says that the key for picking up and dropping is
. being held down once the key has been released.
  $C00E,$04 Return if the key is still being pressed.
  $C012,$04 Clear the flag in #R$A740.
  $C016,$01 Return.

c $C017 Drop Object
@ $C017 label=DropObject
D $C017 Drops the oldest carried object into the free object record in #REGiy,
. at the position of the player. If there is no object in the oldest place in
. the inventory, the carried objects are only moved along. The player rises by
. #N$0C, to be out of the way of the object that is dropped.
R $C017 IX Record of the object of the legs of the player
R $C017 IY Free object record
  $C017,$03 Take the oldest of the carried objects, #R$A72E.
  $C01A,$02 Fetch the type of it.
  $C01C,$03 Jump to #R$C091 to move the objects along if there is none.
  $C01F,$03 Fetch the flag from #R$A741.
  $C022,$03 Jump to #R$BFFC if there is no room above the player.
  $C025,$03 Fetch the type of the object again.
  $C028,$03 Make it the type of the new object.
  $C02B,$01 Stash the address of the flags of the carried object on the stack.
N $C02C Copy the player to the new object, which gives it the position, the
. speeds and the room of the player.
  $C02C,$03 Set the number of bytes to copy in #REGbc.
  $C02F,$03 Take the player, using the stack.
  $C032,$03 Take the new object, using the stack.
  $C035,$02 Move on to the second byte of each of them.
  $C037,$02 Copy the record of the player to the new object.
N $C039 Raise both of the object records of the player, to be above the dropped
. object.
  $C039,$08 Add #N$0C to the height of the legs.
  $C041,$08 Add #N$0C to the height of the body.
N $C049 Make the new object ready to be drawn.
  $C049,$04 Stash the records of the player and the object on the stack.
  $C04D,$04 Take the new object as the one being updated, using the stack.
  $C051,$03 Call #R$C75F to set where the sprite is drawn.
  $C054,$03 Call #R$B2C5 to work out where the sprite goes on the screen.
  $C057,$03 Call #R$B979 to find where the object can be.
  $C05A,$03 Call #R$CCDE to mark the object to be drawn.
  $C05D,$04 Restore the records of the object and the player from the stack.
@ $C061 label=DropObject_SetUp
N $C061 Set up the dropped object, which is also done when an object is swapped
. for one that is picked up.
  $C061,$04 Set the half size along x to #N$05.
  $C065,$04 Set the half size along y to #N$05.
  $C069,$04 Set the size along z to #N$0C.
  $C06D,$01 Restore the address of the flags of the carried object from the
. stack.
  $C06E,$02 Fetch the flags of the carried object.
  $C070,$03 Set them as the flags of the new object.
  $C073,$06 Copy the room of the player to the new object.
  $C079,$02 Fetch the low byte of the address of the object in the store.
  $C07B,$03 Keep the low byte of the store address in the new object.
  $C07E,$04 Fetch the high byte of the address of the object in the store.
  $C082,$04 Set #REGhl to the address of the object in the store.
  $C086,$04 Write the type of the object to its entry in the store, so that it
. stays in the room.
  $C08A,$04 Set bit 0 of the hit flags of the new object.
  $C08E,$03 Call #R$BF56 to mark the new object to be drawn.
@ $C091 label=DropObject_MoveAlong
N $C091 Move the carried objects along one place, which gets rid of the oldest
. and leaves the first place empty.
  $C091,$03 Start at the last byte of the third entry of #R$A722.
  $C094,$03 Take the last byte of the fourth entry.
  $C097,$03 Set the number of bytes in #REGbc to #N$0C, three objects.
  $C09A,$02 Move them along, copying down from the end.
  $C09C,$03 Take the first place of the inventory, #R$A722.
  $C09F,$02 Set a counter in #REGb of four bytes.
  $C0A1,$03 Call #R$B513 to clear the first place of the inventory.
  $C0A4,$03 Jump to #R$BFFC.

c $C0A7 Pick Up Object
@ $C0A7 label=PickUpObject
D $C0A7 Picks up an object, which is put in the first place of the inventory
. (until it is moved along to the second place), and removed from the room. The
. object is changed into the marker that makes #R$B3D3 erase it. If the carried
. objects are all in use, the oldest one is dropped where the other one was.
R $C0A7 IY Record of the object that is being picked up
  $C0A7,$03 Start at the first place of the inventory, #R$A722.
  $C0AA,$04 Set the type of the object in the inventory.
  $C0AE,$01 Move on to the flags.
  $C0AF,$04 Set the flags of the object.
  $C0B3,$01 Move on to the address of the object in the store.
  $C0B4,$06 Fetch the address of the object in the store.
  $C0BA,$02 Write zero to the store, to say that the object is no longer in the
. room.
  $C0BC,$03 Set the address in the inventory.
  $C0BF,$03 Call #R$BF56 to mark the object to be drawn.
  $C0C2,$04 Change the object to the type that makes it be erased.
  $C0C6,$03 Take the oldest carried object, #R$A72E.
  $C0C9,$02 Fetch the type of it.
  $C0CB,$03 Jump to #R$C091 to move the objects along if it is not in use.
  $C0CE,$03 Make it the type of the object that is picked up, so that it is
. dropped here.
  $C0D1,$01 Stash the address of the flags of the carried object on the stack.
  $C0D2,$02 Jump to #R$C061 to set up the dropped object.

c $C0D4 Test Object Can Be Picked Up
@ $C0D4 label=TestObjectCanBePickedUp
D $C0D4 Tests if an object is one that can be picked up (of type #N$5A or #N$90
. to #N$94) and touches the player. The player is taken to touch the object if
. they overlap along each axis, with the player lowered by #N$04 to test along
. z.
E $C0D4 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C172 }
. { #ALIENEIGHT$BEA7 }
. LIST#
R $C0D4 IX Record of the object of the legs of the player
R $C0D4 IY Record of the object to test
R $C0D4 O:F Carry flag set if the object can be picked up and touches the player
  $C0D4,$03 Fetch the type of the object.
  $C0D7,$04 Jump to #R$C0E0 if it is type #N$5A.
  $C0DB,$02 Take away #N$90 from it.
  $C0DD,$03 Return with the carry flag clear if it was not one of the five types
. #N$90 to #N$94.
@ $C0E0 label=TestObjectCanBePickedUp_Overlap
  $C0E0,$01 Stash #REGbc on the stack.
  $C0E1,$03 Set the distance moved along x to zero.
  $C0E4,$02 Set the distances moved along y and z to zero.
  $C0E6,$05 Jump to #R$C105 if the objects do not overlap along x.
  $C0EB,$05 Jump to #R$C105 if the objects do not overlap along y.
  $C0F0,$08 Lower the player by #N$04.
  $C0F8,$03 Test if the objects overlap along z.
  $C0FB,$01 Stash the result on the stack.
  $C0FC,$08 Raise the player by #N$04 again.
  $C104,$01 Restore the result from the stack.
@ $C105 label=TestObjectCanBePickedUp_Done
  $C105,$01 Restore #REGbc from the stack.
  $C106,$01 Return.

c $C107 Start Explosion
@ $C107 label=StartExplosion
D $C107 Turns an object into the first stage of an explosion, which is a type
. that has its own animation in #R$C111. This is used for the player and for the
. projectiles.
R $C107 IX Record of the object
  $C107,$04 Change the object to the type of the first stage of an explosion.
  $C10B,$04 Flag the object as being moved, so that nothing can push it.
  $C10F,$02 Jump to #R$C11A to mark it to be drawn.

c $C111 Run Explosion
@ $C111 label=RunExplosion
D $C111 The handler of the object types #N$40 to #N$46, which are the stages of
. an explosion. Each time it is run the object moves on to the next type, which
. has the next sprite.
R $C111 IX Record of the object
  $C111,$03 Call #R$C77A to set where the sprite is drawn.
  $C114,$03 Call #R$D64E to make a noise.
  $C117,$03 Move on to the next type.
@ $C11A label=RunExplosion_MarkObjectMoved
  $C11A,$03 Jump to #R$CCDE to mark the object to be drawn.

c $C11D Finish Explosion
@ $C11D label=FinishExplosion
D $C11D The handler of the last stage of an explosion, type #N$47. The object is
. changed into the marker that makes #R$B3D3 erase it, which frees it.
R $C11D IX Record of the object
  $C11D,$03 Call #R$C77A to set where the sprite is drawn.
@ $C120 label=FinishExplosion_Erase
  $C120,$04 Change the object to the type that makes it be erased.
  $C124,$02 Jump to #R$C11A to mark it to be drawn.

c $C126 Fire Projectile
@ $C126 label=FireProjectile
D $C126 Fires a projectile in the direction that the player is facing, if the
. fire key is pressed and it was not already being held down from before. There
. are two object records that are used for projectiles, so nothing is done if
. both are in use.
D $C126 The projectile is a copy of the player that is changed into a projectile
. and moved on by twice its speed along the way that the player is facing. It is
. thrown away at once if it starts outside the room.
R $C126 IX Record of the object of the legs of the player
  $C126,$03 Start at the first of the two projectile object records,
. #R$A7AF.
  $C129,$03 Fetch the controls from #R$A737.
  $C12C,$02,b$01 Keep only the fire bit.
  $C12E,$02 Jump to #R$C135 if the fire key is being pressed.
  $C130,$04 Clear the flag in #R$A743, to say that the key has been released.
  $C134,$01 Return.
@ $C135 label=FireProjectile_Pressed
  $C135,$03 Fetch the flag from #R$A743.
  $C138,$02 Return if the key was already being held down.
  $C13A,$04 Set the flag in #R$A743, to say that the key is being held down.
  $C13E,$03 Set the size of an object record in #REGbc.
  $C141,$04 Jump to #R$C149 if the first record is free.
  $C145,$01 Move on to the second record.
  $C146,$03 Return if that is not free either.
@ $C149 label=FireProjectile_Create
N $C149 Copy the player to the free record, then change the copy into a
. projectile.
  $C149,$01 Move the address of the free record to #REGde.
  $C14A,$03 Take the free record, using the stack.
  $C14D,$03 Take the player, using the stack.
  $C150,$02 Copy the player to the projectile.
  $C152,$04 Set the type of the projectile to #N$96, which is the first of its
. sprites.
  $C156,$03 Call #R$C5BD to find out which way the player is facing.
  $C159,$03 Set #REGhl to the number of the direction.
  $C15C,$03 Take the table of speeds of projectiles, #R$C1BD.
  $C15F,$02 Find the entry for the direction, which is two bytes for each
. direction.
  $C161,$04 Fetch the speed along x, and set it as the x speed of the
. projectile.
  $C165,$02 Double it, and stash it in #REGe.
  $C167,$01 Move on to the speed along y.
  $C168,$04 Fetch the speed along y, and set it as the y speed of the
. projectile.
  $C16C,$01 Double it.
  $C16D,$06 Add it to the y position of the projectile.
  $C173,$07 Add the doubled speed along x to the x position of the projectile.
  $C17A,$08 Raise the projectile by #N$04.
  $C182,$04 Set the flags of the projectile, which make it pushable and mark it
. to be drawn.
  $C186,$04 Clear the collision flags of the projectile.
  $C18A,$04 Set the size of the projectile along z to #N$08.
N $C18E Make sure that the projectile is inside the room.
  $C18E,$03 Fetch the limits of the room from #R$A71D.
  $C191,$05 Take away the half size along x from the limit along x.
  $C196,$05 Take away the half size along y from the limit along y.
  $C19B,$03 Fetch the x position of the projectile.
  $C19E,$05 Take away the middle of the room, #N$80, and jump to #R$C1A5 if the
. distance from the middle is not negative.
  $C1A3,$02 Make the distance positive.
@ $C1A5 label=FireProjectile_TestX
  $C1A5,$03 Jump to #R$C1B8 to give up if the distance is not less than the
. limit along x.
  $C1A8,$03 Fetch the y position of the projectile.
  $C1AB,$05 Take away the middle of the room, #N$80, and jump to #R$C1B2 if the
. distance from the middle is not negative.
  $C1B0,$02 Make the distance positive.
@ $C1B2 label=FireProjectile_TestY
  $C1B2,$03 Jump to #R$C1B8 to give up if the distance is not less than the
. limit along y.
  $C1B5,$03 Jump to #R$D629.
@ $C1B8 label=FireProjectile_Cancel
  $C1B8,$04 Free the record, as the projectile would be outside the room.
  $C1BC,$01 Return.

b $C1BD Projectile_Speeds
@ $C1BD label=ProjectileSpeeds
D $C1BD The speed along x and the speed along y of a projectile for each of the
. four directions that the player can face. A projectile starts out twice this
. far from the player.
B $C1BD,$02,$02 Facing the direction that numbers #N$00.
B $C1BF,$02,$02 Facing the direction that numbers #N$01.
B $C1C1,$02,$02 Facing the direction that numbers #N$02.
B $C1C3,$02,$02 Facing the direction that numbers #N$03.

c $C1C5 Run Projectile
@ $C1C5 label=RunProjectile
D $C1C5 The handler of the object types #N$95 to #N$97, which are the three
. sprites of a projectile that is in flight, and of #N$3C. Each time that it is
. run the projectile moves on one place, and changes type to the next of the
. three sprites.
D $C1C5 The projectile flies at least #N$84 up, and does not fall. It explodes
. if it hits a wall, and if it hits one of the creatures then the player scores
. for it and the creature explodes instead.
R $C1C5 IX Record of the projectile
  $C1C5,$03 Call #R$C775 to set where the sprite is drawn.
  $C1C8,$03 Call #R$B979 to move the projectile.
  $C1CB,$04 Fetch the type of the projectile, and take one away to get the next
. sprite.
  $C1CF,$04 Jump to #R$C1D5 unless that gives #N$94, which is not a sprite of a
. projectile.
  $C1D3,$02 Use the sprite #N$97 instead.
@ $C1D5 label=RunProjectile_SetType
  $C1D5,$03 Set the type of the projectile.
  $C1D8,$07 Jump to #R$C1E7 if the projectile is at least #N$84 up.
  $C1DF,$04 Put the projectile at a height of #N$84.
  $C1E3,$04 Stop it from falling.
@ $C1E7 label=RunProjectile_TestHit
  $C1E7,$03 Call #R$C206 to find out if the projectile touches a creature.
  $C1EA,$01 Fetch the result.
  $C1EB,$04 Jump to #R$C264 if it does.
  $C1EF,$03 Fetch the collision flags of the projectile.
  $C1F2,$02,b$01 Keep only the bits for a hit along x or y.
  $C1F4,$03 Jump to #R$C107 to explode if the projectile hit a wall.
  $C1F7,$06 Set the x speed of the projectile to the speed that it was fired
. with.
  $C1FD,$06 Set the y speed of the projectile to the speed that it was fired
. with.
  $C203,$03 Jump to #R$CCDE to mark the projectile to be drawn.

c $C206 Test Creature Hit
@ $C206 label=TestCreatureHit
D $C206 Tests if an object touches either of the two creatures that wander about
. the room, which are in the object records #R$A7EF and #R$A80F. The touching is
. tested with a margin of #N$02.
R $C206 IX Record of the object
R $C206 O:D #N$00 if it touches a creature (and #REGiy holds the record of the
. creature), or #N$01 if it does not
  $C206,$02 Set the result to #N$01, as nothing has been hit.
  $C208,$04 Start with the first of the creatures, #R$A7EF.
  $C20C,$03 Call #R$C216 to test it.
  $C20F,$01 Fetch the result.
  $C210,$02 Return if the creature was hit.
  $C212,$04 Move on to the second of the creatures, #R$A80F.
@ $C216 label=TestCreatureHit_Test
N $C216 Ignore objects that are free, are of a type below #N$08, or are
. explosions.
  $C216,$03 Fetch the type of the creature.
  $C219,$02,b$01 Keep only the bits of the type that tell the kinds of object
. apart.
  $C21B,$01 Return if the object is free or of a type that is below #N$08.
  $C21C,$02 Compare the kind of the object with #N$40, which is an explosion.
@ $C21E label=TestCreatureHit_Projectile
  $C21E,$01 Return if it is an explosion.
N $C21F Test along x.
  $C21F,$03 Fetch the x position of the creature.
  $C222,$06 Take away the x position of the object.
  $C228,$02 Make the distance positive.
@ $C22A label=TestCreatureHit_PositiveX
  $C22A,$01 Stash the distance along x in #REGe.
  $C22B,$08 Add the half sizes along x of the two objects, and the margin.
  $C233,$02 Return with the carry flag set if the distance is more than that.
N $C235 Test along y.
  $C235,$03 Fetch the y position of the object.
  $C238,$06 Take away the y position of the creature.
  $C23E,$02 Make the distance positive.
@ $C240 label=TestCreatureHit_PositiveY
  $C240,$01 Stash the distance along y in #REGe.
  $C241,$08 Add the half sizes along y of the two objects, and the margin.
  $C249,$02 Return with the carry flag set if the distance is more than that.
N $C24B Test along z.
  $C24B,$03 Fetch the z position of the object.
  $C24E,$06 Take away the z position of the creature.
  $C254,$02 Make the distance positive.
@ $C256 label=TestCreatureHit_PositiveZ
  $C256,$01 Stash the distance along z in #REGe.
  $C257,$08 Add the sizes along z of the two objects, and the margin.
  $C25F,$02 Return with the carry flag set if the distance is more than that.
  $C261,$02 Set the result to #N$00, as the creature has been hit.
  $C263,$01 Return.

c $C264 Score For Creature
@ $C264 label=ScoreForCreature
D $C264 Adds the points for a creature that has been hit by a projectile to the
. score, makes the creature explode, and makes the projectile disappear. The
. points are worked out from the type of the creature, by rotating its bits and
. keeping the ones that make up the digits, each of which is from 0 to 7.
R $C264 IX Record of the projectile
R $C264 IY Record of the creature
  $C264,$04 Fetch the type of the creature, and stash it in #REGb.
  $C268,$02 Rotate it left twice.
  $C26A,$02,b$01 Keep only the bits that make the lower two digits.
  $C26C,$01 Set the lower two digits of the points in #REGc.
  $C26D,$01 Fetch the type of the creature again.
  $C26E,$03 Rotate it left three times.
  $C271,$02,b$01 Keep only the bits that make the upper two digits.
  $C273,$01 Set the upper two digits of the points in #REGb.
  $C274,$03 Call #R$BB29 to add the points to the score.
  $C277,$03 Call #R$B145 to copy the score to the screen.
  $C27A,$04 Change the creature to the first stage of an explosion.
  $C27E,$04 Flag the creature as being moved, so that nothing can push it.
  $C282,$03 Jump to #R$C120 to change the projectile into the marker that makes
. it be erased.

c $C285 Run Dangerous Fixed
@ $C285 label=RunDangerousFixed
D $C285 The handler of the object types #N$17, #N$1E, #N$4A and #N$4B, which are
. objects that harm the player but do not move. The sprite is drawn without a
. change.
R $C285 IX Record of the object
  $C285,$03 Call #R$C291 to make the object harm the player.
  $C288,$03 Jump to #R$C75F to set where the sprite is drawn.

c $C28B Run Dangerous Marked
@ $C28B label=RunDangerousMarked
D $C28B Makes an object harm the player, and marks it to be drawn.
R $C28B IX Record of the object
  $C28B,$03 Call #R$C291 to make the object harm the player.
  $C28E,$03 Jump to #R$CCDE to mark the object to be drawn.

c $C291 Set Deadly Flags
@ $C291 label=SetDeadlyFlags
D $C291 Flags an object as one that harms the player, both when it hits
. something that is not moving and when something moves into it.
E $C291 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B85C }
. { #ALIENEIGHT$B2A7 }
. LIST#
R $C291 IX Record of the object
  $C291,$03 Fetch the hit flags of the object.
  $C294,$02,b$01 Set bits 5 and 7, which are the ones that harm anything that
. touches the object.
  $C296,$03 Set them in the object.
  $C299,$01 Return.

c $C29A Draw Lives
@ $C29A label=DrawLives
D $C29A Draws the icon for the lives that the player has left, and the number of
. lives beside it, into the buffer. The attributes of the area are also set, as
. the buffer is not used for them.
.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$C29A and #R$B178 }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #SIM(start=$AFBF,stop=$AFDA,sp=$5E00)
. #SIM(start=$AFDA,stop=$B072,sp=$5E00)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$03,$01,$11,$07,$05(draw-lives-before)
. | #SIM(start=$C29A,stop=$0000,sp=$5D00)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$03,$01,$11,$07,$05(draw-lives-after) } UDGTABLE# #POPS
  $C29A,$04 Use the temporary object, #R$BACA.
  $C29E,$04 Set the type of the temporary object to #N$16, which is the sprite
. of the icon.
  $C2A2,$04 Set the flags of the temporary object to #N$00.
  $C2A6,$04 Set the screen x co-ordinate of the object to #N$10.
  $C2AA,$04 Set the screen y co-ordinate of the object to #N$20.
  $C2AE,$03 Call #R$B3E7 to draw the sprite.
N $C2B1 Set the attributes of the area that holds the icon and the number.
  $C2B1,$02 Set the attribute in #REGa to bright white ink on a black paper.
  $C2B3,$03 Start at the attribute file, at the top line of the area.
  $C2B6,$02 Set a counter in #REGb of two attributes.
  $C2B8,$03 Call #R$B514 to set them.
  $C2BB,$03 Move on to the next line of the attributes.
  $C2BE,$02 Set a counter in #REGb of four attributes.
  $C2C0,$03 Call #R$B514 to set them.
N $C2C3 Print the number of lives.
  $C2C3,$03 Take the number of lives, #R$A721.
  $C2C6,$02 Set a counter in #REGb of one byte.
  $C2C8,$03 Find the place for the digits in the buffer.
  $C2CB,$03 Jump to #R$BB48.

c $C2CE Choose Start Room
@ $C2CE label=ChooseStartRoom
D $C2CE Makes the copy of the object record of the legs of the player that is
. used at the start of a life, and chooses at random which of four rooms the
. player starts in.
.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Seed #N$00: room #N$33 | =h Seed #N$01: room #N$5C }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #POKES$A70D,$00
. #SIM(start=$AFBF,stop=$AFDA,sp=$5E00)
. #SIM(start=$AFDA,stop=$B087,sp=$5E00)
. #SCR$01(choose-start-room-0)
. | #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #POKES$A70D,$01
. #SIM(start=$AFBF,stop=$AFDA,sp=$5E00)
. #SIM(start=$AFDA,stop=$B087,sp=$5E00)
. #SCR$01(choose-start-room-1) }
. { =h Seed #N$02: room #N$64 | =h Seed #N$03: room #N$0C }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #POKES$A70D,$02
. #SIM(start=$AFBF,stop=$AFDA,sp=$5E00)
. #SIM(start=$AFDA,stop=$B087,sp=$5E00)
. #SCR$01(choose-start-room-2)
. | #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #POKES$A70D,$03
. #SIM(start=$AFBF,stop=$AFDA,sp=$5E00)
. #SIM(start=$AFDA,stop=$B087,sp=$5E00)
. #SCR$01(choose-start-room-3) } UDGTABLE# #POPS
  $C2CE,$03 Take the original of the record, #R$C3EF.
  $C2D1,$03 Take the copy of the record, #R$C3FF.
  $C2D4,$03 Set the number of bytes to copy in #REGbc to #N$10.
  $C2D7,$02 Copy the record.
  $C2D9,$03 Fetch the random seed from #R$A70D.
  $C2DC,$02,b$01 Keep only two bits of it, which give a number from #N$00 to
. #N$03.
  $C2DE,$01 Set the number in #REGc.
  $C2DF,$03 Take the table of rooms, #R$C2E8.
  $C2E2,$01 Add the number to get the address of the room.
  $C2E3,$01 Fetch the room.
  $C2E4,$03 Set it as the room of the copy of the record at #R$C3FF.
  $C2E7,$01 Return.

b $C2E8 Start Rooms
@ $C2E8 label=StartRooms
D $C2E8 The four rooms that the player may start in.
B $C2E8,$04,$04

c $C2EC Lose Life
@ $C2EC label=LoseLife
D $C2EC Puts the player back at the start of the game, with the object records
. of the legs and the body being copied from the records at #R$C3FF, and takes
. away a life. When there are no lives left the game is over.
E $C2EC View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CA07 }
. LIST#
  $C2EC,$03 Take the records, #R$C3FF.
  $C2EF,$03 Take the first object record, #R$A76F.
  $C2F2,$03 Take the first record, using the stack.
  $C2F5,$03 Set the number of bytes to copy in #REGbc to #N$40, which is two
. records.
  $C2F8,$02 Copy the records.
N $C2FA See #POKE(infinite_lives,Infinite Lives).
  $C2FA,$03 Take the number of lives, #R$A721.
  $C2FD,$01 Take one away.
  $C2FE,$03 Jump to #R$C323 to show the game over screen if the lives have run
. out.
  $C301,$01 Return.

c $C302 Show Victory Screen
@ $C302 label=ShowVictoryScreen
D $C302 Shows the screen for when the pentagram is complete, which is a frame
. with six lines of text in it. It is followed by the game over screen, which
. carries on from where this ends.
.
. #HTML(#AUDIO0(game-complete-tune.wav)(#INCLUDE(GameCompleteTune)))
.
. #PUSHS #UDGTABLE { =h The victory screen }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$C302,stop=$C31D,sp=$5E00)
. #SCR$02(show-victory) } UDGTABLE# #POPS
N $C302 Show the victory screen.
  $C302,$03 Call #R$CB81 to clear the buffer.
  $C305,$02 Set the attribute in #REGa to bright cyan ink on a black paper.
  $C307,$03 Call #R$CB6A to set all the attributes to it.
  $C30A,$03 Take the colours of the lines, #R$C3E9.
  $C30D,$01 Switch to the alternate registers.
  $C30E,$03 Take the positions of the lines, #R$C3DD.
  $C311,$03 Take the text of the lines, #R$C38B.
  $C314,$02 Set a counter in #REGbc' of six lines.
  $C316,$04 Write #N$00 to #R$A734, so that the frame will be drawn.
  $C31A,$03 Call #R$BCC0 to draw the lines of text and the frame, and to copy
. the buffer to the screen.
N $C31D Play the victory tune.
  $C31D,$03 Take the victory tune, #R$D86F.
  $C320,$03 Call #R$D6B5 to play it.

c $C323 Show Game Over Screen
@ $C323 label=ShowGameOverScreen
D $C323 Shows the screen for the end of the game, with the percentage of the
. quest that has been done. Once the tune has played and there has been a pause,
. the game starts again from the menu.
.
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
.
. #PUSHS #UDGTABLE { =h The game over screen }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #POKES$A74C,$02
. #SIM(start=$C323,stop=$C347,sp=$5E00)
. #SCR$02(show-game-over) } UDGTABLE# #POPS
N $C323 Show the game over screen.
  $C323,$03 Call #R$CB81 to clear the buffer.
  $C326,$02 Set the attribute in #REGa to bright yellow ink on a black paper.
  $C328,$03 Call #R$CB6A to set all the attributes to it.
  $C32B,$03 Call #R$BD59 to draw the frame.
  $C32E,$03 Take the colours of the lines, #R$C35D.
  $C331,$01 Switch to the alternate registers.
  $C332,$03 Take the positions of the lines, #R$C360.
  $C335,$03 Take the text of the lines, #R$C366.
  $C338,$02 Set a counter in #REGbc' of three lines.
  $C33A,$03 Call #R$BCC0 to draw the lines of text.
N $C33D Print the percentage of the quest that was done.
  $C33D,$03 Call #R$C6EA to print the percentage of the quest that was done.
  $C340,$04 Write #N$00 to #R$A734, so that the frame will be drawn next time.
  $C344,$03 Call #R$B178 to copy the buffer to the screen.
N $C347 Play the game over tune.
  $C347,$03 Take the game over tune, #R$D853.
  $C34A,$03 Call #R$D6B5 to play it.
N $C34D Wait for a time.
  $C34D,$02 Set a counter in #REGb of #N$40 loops.
@ $C34F label=ShowGameOverScreen_Wait
  $C34F,$03 Set a counter in #REGhl of #N$2000.
@ $C352 label=ShowGameOverScreen_Count
  $C352,$01 Decrease the counter.
  $C353,$01 Fetch the high byte of it.
  $C354,$01 Combine it with the low byte.
  $C355,$02 Jump back to #R$C352 until the delay has run out.
  $C357,$02 Repeat the delay for each of the remaining passes.
N $C359 Throw away the return address, and start again.
  $C359,$01 Take the return address off the stack.
  $C35A,$03 Jump to #R$AF93 to start the game again.

b $C35D Game Over Colours
@ $C35D label=GameOverColours
D $C35D The attributes of the three lines of text on the game over screen.
B $C35D,$01 #COLOUR(#PEEK(#PC)).
L $C35D,$01,$03

b $C360 Game Over Positions
@ $C360 label=GameOverPositions
D $C360 The x and y co-ordinates of the three lines of text on the game over
. screen.
B $C360,$06,$02

t $C366 Messaging: Game Over Text
@ $C366 label=GameOverText
D $C366 The three lines of text of the game over screen. The last character of
. each has bit 7 set. The percentage is printed under "COMPLETED".
  $C366,$09,$08:$01 "GAME OVER"
  $C36F,$13,$12:$01 "PERCENTAGE OF QUEST"
  $C382,$09,$08:$01 "COMPLETED"

t $C38B Messaging: Victory Text
@ $C38B label=VictoryText
D $C38B The six lines of text of the victory screen. The last character of each
. has bit 7 set. The last line refers to the next game.
  $C38B,$0F,$0E:$01 "CONGRATULATIONS"
  $C39A,$13,$12:$01 "YOU HAVE COMPLEATED"
  $C3AD,$0D,$0C:$01 "THE PENTAGRAM"
  $C3BA,$0E,$0D:$01 "YOUR ADVENTURE"
  $C3C8,$0C,$0B:$01 "CONTINUES IN"
  $C3D4,$09,$08:$01 "MIRE MARE"

b $C3DD Victory Positions
@ $C3DD label=VictoryPositions
D $C3DD The x and y co-ordinates of the six lines of text on the victory screen.
B $C3DD,$0C,$02

b $C3E9 Victory Colours
@ $C3E9 label=VictoryColours
D $C3E9 The attributes of the six lines of text on the victory screen.
B $C3E9,$01 #COLOUR(#PEEK(#PC)).
L $C3E9,$01,$06

b $C3EF Player Template
@ $C3EF label=PlayerTemplate
D $C3EF The first sixteen bytes of the object record of the legs of the player
. at the start of a life. #R$C2CE copies them to #R$C3FF, and sets the room.
B $C3EF,$10,$08

b $C3FF Player Records
@ $C3FF label=PlayerRecords
D $C3FF The two object records of the player, which #R$C2EC copies to the first
. two object records at #R$A76F at the start of a life. The first sixteen bytes
. of the first one are written by #R$C2CE.
B $C3FF,$20,$08 The legs.
B $C41F,$20,$08 The body.

c $C43F Run Nothing
@ $C43F label=RunNothing
D $C43F The handler of the object types that do nothing, which includes most of
. the scenery. Their sprites are drawn when the room is, and do not change.
  $C43F,$01 Return.

c $C440 Handle Player Legs
@ $C440 label=HandlePlayerLegs
D $C440 The handler of the legs of the player, which are the object types #N$20
. to #N$27. The legs are the first of the two objects of the player, and they do
. everything: the body, which follows them, is run by #R$C5D3.
D $C440 The type of the legs says which way the player is facing, and which step
. of the walk is being taken. If something dangerous has touched the player the
. legs explode. Otherwise the controls are read and used to turn, walk, jump,
. pick up and drop objects, and fire.
E $C440 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C0BE }
. LIST#
R $C440 IX Record of the legs
  $C440,$03 Call #R$C775 to set where the sprite is drawn.
  $C443,$06 Jump to #R$C450 if the player has not been touched by anything
. dangerous.
  $C449,$04 Make the body explode too.
  $C44D,$03 Jump to #R$C107 to make the legs explode.
@ $C450 label=HandlePlayerLegs_Controls
N $C450 Read the controls, and clear the speeds along x and y.
  $C450,$03 Call #R$BDF8 to read the controls.
  $C453,$07 Set the speeds along x and y to zero.
N $C45A Act on the controls.
  $C45A,$03 Call #R$C4C8 to turn the player.
  $C45D,$03 Call #R$C58D to step the legs.
  $C460,$03 Call #R$C56C to start a jump.
  $C463,$03 Call #R$BF79 to pick up or drop an object.
  $C466,$03 Call #R$C4A3 to find out if the player is clear of the walls.
  $C469,$02 Jump to #R$C495 if the player is not.
@ $C46B label=HandlePlayerLegs_Move
N $C46B Move the player, which is done with the body flagged as being moved so
. that the legs do not collide with it.
  $C46B,$04 Flag the body as being moved.
  $C46F,$07 Jump to #R$C47A unless the legs are higher than #N$F0.
  $C476,$04 Put the legs at a height of #N$F0, which is the highest that they
. can be.
@ $C47A label=HandlePlayerLegs_MoveLegs
  $C47A,$03 Call #R$C61D to move the legs.
  $C47D,$03 Call #R$C126 to fire a projectile, if the fire key is pressed.
  $C480,$04 Clear the flag on the body.
  $C484,$04 Clear the flag that makes the legs ignore the walls.
N $C488 Count down the time since the player entered the room, which is in the
. top four bits of the collision flags.
  $C488,$03 Fetch the collision flags.
  $C48B,$04 Take #N$10 off them, and jump to #R$C492 if there was nothing to
. take off.
  $C48F,$03 Set them.
@ $C492 label=HandlePlayerLegs_Done
  $C492,$03 Jump to #R$CCDE to mark the legs to be drawn.
@ $C495 label=HandlePlayerLegs_Outside
N $C495 The player is not clear of the walls, as it is in a doorway. Stop it
. from rising, though it can still fall.
  $C495,$03 Fetch the speed along z.
  $C498,$04 Jump to #R$C46B if the player is falling.
  $C49C,$04 Set the speed along z to zero.
  $C4A0,$02 Jump to #R$C46B.
  $C4A2,$01 Return, which nothing does.

c $C4A3 Test Player In Room
@ $C4A3 label=TestPlayerInRoom
D $C4A3 Tests if an object is clear of the walls of the room, which is to say
. that the middle of it is nearer to the middle of the room than the wall is,
. once the half size of the object has been taken off.
E $C4A3 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C87A }
. { #ALIENEIGHT$C117 }
. LIST#
R $C4A3 IX Record of the object
R $C4A3 O:F Carry flag set if the object is clear of the walls
  $C4A3,$03 Fetch the limits of the room, #R$A71D along x and #R$A71E along y.
  $C4A6,$05 Take the half size along x off the limit along x.
  $C4AB,$05 Take the half size along y off the limit along y.
  $C4B0,$03 Fetch the x position of the object.
  $C4B3,$05 Take away the middle of the room, #N$80, and jump to #R$C4BA if the
. distance is not negative.
  $C4B8,$02 Make the distance positive.
@ $C4BA label=TestPlayerInRoom_LimitX
  $C4BA,$02 Return with the carry flag clear if the distance is not less than
. the limit along x.
  $C4BC,$03 Fetch the y position of the object.
  $C4BF,$05 Take away the middle of the room, #N$80, and jump to #R$C4C6 if the
. distance is not negative.
  $C4C4,$02 Make the distance positive.
@ $C4C6 label=TestPlayerInRoom_LimitY
  $C4C6,$01 Test the distance against the limit along y.
  $C4C7,$01 Return with the carry flag set if it is less than that.

c $C4C8 Handle Turning
@ $C4C8 label=HandleTurning
D $C4C8 Turns the player to the left or the right, if the controls ask for it. A
. turn takes the player one quarter of the way round, and the player has to wait
. for two frames after that before it can turn again.
D $C4C8 There is a second way of controlling the player, which is for use with a
. joystick and is chosen by bit 3 of the control method in #R$A709. That bit is
. never set, so it is never used. In this way, four of the control bits stand
. for the four directions that the player can face, and the player turns until
. it faces the one that is asked for, and then walks.
E $C4C8 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C89F }
. { #ALIENEIGHT$C13C }
. LIST#
R $C4C8 C Controls
R $C4C8 IX Record of the legs
R $C4C8 O:C Controls, in which the bit for walking is set by the second way of
. controlling the player
  $C4C8,$03 Take the control method, #R$A709.
  $C4CB,$01 Fetch the control method.
  $C4CC,$02,b$01 Keep only the bits that choose a joystick.
  $C4CE,$02 Jump to #R$C51B to turn the usual way if the keyboard is being used.
  $C4D0,$04 Jump to #R$C51B to turn the usual way if bit 3 of the control method
. is not set.
N $C4D4 Turn towards the direction that is asked for. Return if the player has
. only just entered the room, or is not on the ground.
  $C4D4,$03 Fetch the collision flags.
  $C4D7,$02,b$01 Keep only the countdown from entering the room.
  $C4D9,$01 Return if the player has only just entered the room.
  $C4DA,$05 Return if the player is not on the ground.
  $C4DF,$04 Jump to #R$C4E7 if the bit for turning left is set.
  $C4E3,$04 Jump to #R$C4F6 if the bit for walking forward is set.
@ $C4E7 label=HandleTurning_TestRight
  $C4E7,$04 Jump to #R$C502 if the bit for turning right is set.
  $C4EB,$04 Jump to #R$C509 if the bit for picking up and dropping is set.
  $C4EF,$04 Jump to #R$C512 if the bit for turning left is set.
  $C4F3,$02 Clear the bit for walking forward.
  $C4F5,$01 Return.
@ $C4F6 label=HandleTurning_AskForward
N $C4F6 Turn towards the direction that the bit for walking forward stands for,
. which is direction #N$02.
  $C4F6,$03 Call #R$C5BD to find out which way the player is facing.
  $C4F9,$02 Compare it with the direction.
@ $C4FB label=HandleTurning_Compare
  $C4FB,$02 Jump to #R$C518 to walk if the player is facing that way.
  $C4FD,$01 Work out which way to turn from the direction.
@ $C4FE label=HandleTurning_Choose
  $C4FE,$02,b$01 Keep only one bit.
  $C500,$02 Jump to #R$C543 to turn the player.
@ $C502 label=HandleTurning_AskRight
N $C502 Turn towards the direction that the bit for turning right stands for,
. which is direction #N$01.
  $C502,$03 Call #R$C5BD to find out which way the player is facing.
  $C505,$02 Compare it with the direction.
  $C507,$02 Jump to #R$C4FB to walk if the player is facing that way, and to
. turn if not.
@ $C509 label=HandleTurning_AskPickUp
N $C509 Turn towards the direction that the bit for picking up and dropping
. stands for, which is direction #N$03.
  $C509,$03 Call #R$C5BD to find out which way the player is facing.
  $C50C,$02 Compare it with the direction.
@ $C50E label=HandleTurning_WalkIfEqual
  $C50E,$02 Jump to #R$C518 to walk if the player is facing that way.
  $C510,$02 Jump to #R$C4FE to turn if not.
@ $C512 label=HandleTurning_AskLeft
N $C512 Turn towards the direction that the bit for turning left stands for,
. which is direction #N$00.
  $C512,$03 Call #R$C5BD to find out which way the player is facing.
  $C515,$01 Test the direction.
  $C516,$02 Jump to #R$C50E to walk if the player is facing that way, and to
. turn if not.
@ $C518 label=HandleTurning_Walk
  $C518,$02 Set the bit for walking forward.
  $C51A,$01 Return.
@ $C51B label=HandleTurning_Usual
N $C51B Turn the usual way. Wait first if the player has turned during the last
. two frames.
  $C51B,$03 Fetch the hit flags, whose lowest three bits hold the time left
. before the player can turn.
  $C51E,$02,b$01 Keep only the countdown.
  $C520,$02 Jump to #R$C526 if there is nothing left to wait for.
  $C522,$03 Take one off the countdown.
  $C525,$01 Return.
@ $C526 label=HandleTurning_TestControls
  $C526,$01 Fetch the controls.
  $C527,$02,b$01 Keep only the bits for turning left and turning right.
  $C529,$01 Return if neither is set.
  $C52A,$03 Fetch the collision flags.
  $C52D,$02,b$01 Keep only the countdown from entering the room.
  $C52F,$01 Return if the player has only just entered the room.
  $C530,$05 Return if the player is jumping.
  $C535,$04 Test the bit for walking forward, which makes no difference.
@ $C539 label=HandleTurning_StartCountdown
  $C539,$03 Fetch the hit flags.
  $C53C,$02,b$01 Set bit 1 of them, to start the countdown that stops the player
. from turning again at once.
  $C53E,$03 Set them.
  $C541,$02 Test the bit for turning right.
@ $C543 label=HandleTurning_Turn
  $C543,$02 Jump to #R$C564 to turn right if it is set.
N $C545 Turn left, which makes the direction go from #N$02 to #N$00, #N$03,
. #N$01 and back to #N$02. This is done by flipping the mirror flag of the legs,
. and the type as well if they were mirrored.
  $C545,$06 Jump to #R$C553 if the legs are not mirrored.
@ $C54B label=HandleTurning_FlipType
  $C54B,$03 Fetch the type of the legs.
  $C54E,$02,b$01 Flip bit 2 of it.
  $C550,$03 Write the flipped type of the legs.
@ $C553 label=HandleTurning_FlipMirror
  $C553,$03 Fetch the flags.
  $C556,$02,b$01 Flip the bit that mirrors the legs.
  $C558,$03 Set them.
  $C55B,$08 Set the type of the body to be eight more than the type of the legs.
  $C563,$01 Return.
N $C564 Turn right, which makes the direction go from #N$02 to #N$01, #N$03,
. #N$00 and back to #N$02. This is done in the same way, but the type is flipped
. if the legs were not mirrored.
@ $C564 label=HandleTurning_Right
  $C564,$06 Jump to #R$C54B if the legs are not mirrored.
  $C56A,$02 Jump to #R$C553.

c $C56C Handle Jump
@ $C56C label=HandleJump
D $C56C Starts a jump, if the jump key is pressed and the player is standing on
. the ground and was not already jumping. The jump is started by giving the
. player an upward speed of #N$08, which is cut down by gravity in #R$C61D.
R $C56C C Controls
R $C56C IX Record of the legs
  $C56C,$03 Return if the jump key is not pressed.
  $C56F,$03 Fetch the collision flags.
  $C572,$02,b$01 Keep only the countdown from entering the room.
  $C574,$01 Return if the player has only just entered the room.
  $C575,$05 Return if the player is already jumping.
  $C57A,$05 Return if the player is not on the ground.
  $C57F,$04 Flag that the player is jumping.
  $C583,$04 Set the speed along z to #N$08.
  $C587,$01 Stash the controls on the stack.
  $C588,$03 Call #R$D5E4 to make the sound of a jump.
  $C58B,$01 Restore the controls from the stack.
  $C58C,$01 Return.

c $C58D Step Legs
@ $C58D label=StepLegs
D $C58D Makes the legs take a step, which means that the type moves on to the
. next of four, if the player is walking or is in the air or has just entered a
. room. If the player is standing still, the legs are moved on until they are in
. the standing position, which is the third of the four.
R $C58D C Controls
R $C58D IX Record of the legs
  $C58D,$03 Fetch the collision flags.
  $C590,$02,b$01 Keep only the countdown from entering the room.
  $C592,$02 Jump to #R$C59E to step if the player has just entered the room.
  $C594,$06 Jump to #R$C59E to step if the player is jumping.
  $C59A,$04 Jump to #R$C5B3 if the player is not walking.
@ $C59E label=StepLegs_Step
  $C59E,$03 Fetch the type of the legs.
  $C5A1,$01 Stash the type of the legs in #REGe.
  $C5A2,$01 Add one to it, and keep the lowest two bits to get the next step.
  $C5A3,$02,b$01 Keep only the step.
  $C5A5,$01 Stash the step in #REGd.
  $C5A6,$01 Fetch the type of the legs again.
  $C5A7,$02,b$01 Clear the lowest two bits of it.
  $C5A9,$01 Set the next step.
  $C5AA,$03 Set the type of the legs.
  $C5AD,$01 Stash the controls on the stack.
  $C5AE,$03 Call #R$D635 to make the sound of a footstep.
  $C5B1,$01 Restore the controls from the stack.
  $C5B2,$01 Return.
@ $C5B3 label=StepLegs_Standing
  $C5B3,$03 Fetch the type of the legs.
  $C5B6,$02,b$01 Keep only the step.
  $C5B8,$03 Return if the legs are in the standing position.
  $C5BB,$02 Jump to #R$C59E to take another step.

c $C5BD Get Facing Direction
@ $C5BD label=GetFacingDirection
D $C5BD Works out which of the four directions the player is facing, from the
. mirror flag and the type of the legs.
D $C5BD #TABLE(default,centre,centre,centre,centre)
. { =h Direction | =h Walking | =h Turn left | =h Turn right }
. { #N$00 | Speed along x, -#N$03 | #N$03 | #N$02 }
. { #N$01 | Speed along x, +#N$03 | #N$02 | #N$03 }
. { #N$02 | Speed along y, +#N$03 | #N$00 | #N$01 }
. { #N$03 | Speed along y, -#N$03 | #N$01 | #N$00 }
. TABLE#
E $C5BD View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C319 }
. LIST#
R $C5BD IX Record of the legs
R $C5BD O:A Direction, from #N$00 to #N$03
  $C5BD,$03 Fetch the flags.
  $C5C0,$03 Move bit 6, which mirrors the object, down to bit 3.
  $C5C3,$02,b$01 Keep only that bit.
  $C5C5,$02,b$01 Flip it, to say that the object is not mirrored.
  $C5C7,$01 Stash the flag in #REGl.
  $C5C8,$03 Fetch the type.
  $C5CB,$02,b$01 Keep only bit 2 of the type.
  $C5CD,$01 Combine it with the other bit.
  $C5CE,$02 Move the two bits down to bits 0 and 1.
  $C5D0,$02,b$01 Keep only those two bits.
  $C5D2,$01 Return.

c $C5D3 Handle Player Top
@ $C5D3 label=HandlePlayerTop
D $C5D3 The handler of the body of the player, which are the object types #N$28
. to #N$2F. The body is the second of the two objects of the player. It only
. follows the legs: it takes the position and flags from the legs, has a type
. that is eight more than the type of the legs, and is a little higher than the
. legs.
E $C5D3 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CDDF }
. LIST#
R $C5D3 IX Record of the body
  $C5D3,$03 Call #R$C764 to set where the sprite is drawn.
  $C5D6,$07 Jump to #R$C107 to make the body explode if something dangerous has
. touched it.
  $C5DD,$03 Take the body, using the stack.
  $C5E0,$03 Set the distance back to the legs, which is one record, in #REGhl.
  $C5E3,$01 Move back to the legs.
  $C5E4,$03 Take the legs, using the stack.
  $C5E7,$02 Move on to the second byte of each of them.
  $C5E9,$03 Set the number of bytes to copy in #REGbc to #N$07.
  $C5EC,$02 Copy the position, sizes and flags of the legs to the body.
  $C5EE,$04 Set the size of the body along z to #N$00.
  $C5F2,$04 Flag the body as being moved.
  $C5F6,$03 Fetch the hit flags of the body.
  $C5F9,$02,b$01 Keep only the lowest four bits, which are a countdown.
  $C5FB,$02 Jump to #R$C602 if it is not running.
  $C5FD,$03 Take one off the countdown.
  $C600,$02 Jump to #R$C60A to leave the type of the body as it is.
@ $C602 label=HandlePlayerTop_Type
  $C602,$03 Fetch the type of the legs.
  $C605,$02 Add eight to it.
  $C607,$03 Set it as the type of the body.
@ $C60A label=HandlePlayerTop_Height
  $C60A,$03 Fetch the type of the legs.
  $C60D,$02,b$01 Keep only bit 2 of it.
  $C60F,$02,b$01 Flip it.
  $C611,$02 Add #N$08 to it.
  $C613,$03 Add the height of the legs.
  $C616,$03 Set the height of the body.
  $C619,$03 Call #R$B9A7 to mark the objects that overlap the body to be drawn.
  $C61C,$01 Return.

c $C61D Move Player
@ $C61D label=MovePlayer
D $C61D Moves the legs of the player for a frame, using the controls, gravity
. and anything that has pushed the player. If the player is walking, or is in
. the air or has just entered the room, it is given a speed along x or y, and
. then it is moved as far as it is able to go.
D $C61D Gravity works on the speed along z: it is cut by one for each frame
. while the player is rising with the jump key held down, and by two otherwise,
. which makes the player fall faster, and makes a jump that is shorter when the
. key is let go. When the player lands, the flag for jumping is cleared.
E $C61D View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C9A1 }
. { #ALIENEIGHT$C296 }
. LIST#
R $C61D C Controls
R $C61D IX Record of the legs
  $C61D,$06 Jump to #R$C62E to walk if the player is jumping.
  $C623,$03 Fetch the collision flags.
  $C626,$02,b$01 Keep only the countdown from entering the room.
  $C628,$02 Jump to #R$C62E to walk if the player has just entered the room.
  $C62A,$04 Jump to #R$C633 if the player is not walking.
@ $C62E label=MovePlayer_Walk
  $C62E,$01 Stash the controls on the stack.
  $C62F,$03 Call #R$C66A to give the player a speed along x or y.
  $C632,$01 Restore the controls from the stack.
@ $C633 label=MovePlayer_Gravity
  $C633,$03 Fetch the speed along z.
  $C636,$04 Jump to #R$C63E if the player is falling.
  $C63A,$04 Jump to #R$C63F if the jump key is held down.
@ $C63E label=MovePlayer_GravityFalling
  $C63E,$01 Take one off the speed along z.
@ $C63F label=MovePlayer_GravityApply
  $C63F,$01 Take one off the speed along z.
  $C640,$03 Set the speed along z.
  $C643,$03 Keep a copy of it in #R$A739.
  $C646,$02 Add two to it, which is not used.
  $C648,$03 Call #R$B6ED to move the object, as far as it can go.
  $C64B,$03 Call #R$C6B5, which does nothing.
  $C64E,$03 Call #R$B97F to add the distances that the player moved to the
. position of the player.
  $C651,$06 Jump to #R$C662 if the player is not on the ground.
  $C657,$03 Fetch the speed along z from before the move.
  $C65A,$04 Jump to #R$C662 if the player was not falling.
  $C65E,$04 Clear the flag for jumping, as the player has landed.
@ $C662 label=MovePlayer_Done
  $C662,$07 Set the speeds along x and y to zero.
  $C669,$01 Return.

c $C66A Set Player Speed
@ $C66A label=SetPlayerSpeed
D $C66A Gives the player a speed of three along the direction that it faces,
. after adding any speed that something else has pushed it with, which comes
. from the two bytes of the object that hold the push. The last three
. instructions are also used by #R$C8D2, with a different table, to find the
. routine for the direction.
E $C66A View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C9FB }
. { #ALIENEIGHT$C2F6 }
. LIST#
R $C66A IX Record of the legs
  $C66A,$09 Add the push along x to the speed along x.
  $C673,$09 Add the push along y to the speed along y.
  $C67C,$07 Clear the pushes along x and y.
  $C683,$03 Take the table of the four routines that add the speed,
. #R$C68D.
@ $C686 label=SetPlayerSpeed_JumpByFacing
  $C686,$03 Call #R$C5BD to find out which way the player is facing.
  $C689,$01 Use the direction as the index into the table.
  $C68A,$03 Jump to #R$B003 to run the routine for the direction.

w $C68D Walking Routines
@ $C68D label=WalkingRoutines
D $C68D The routines that add to the speed of the player, which are in the order
. of the four directions that the player can face.
W $C68D,$08,$02

c $C695 Move Player West
@ $C695 label=MovePlayerWest
D $C695 Takes three off the speed along x, for the player to walk along x
. towards zero.
E $C695 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA3A }
. { #ALIENEIGHT$C337 }
. LIST#
R $C695 IX Record of the legs
  $C695,$03 Fetch the speed along x.
  $C698,$02 Take three off it.
@ $C69A label=MovePlayer_SetX
  $C69A,$03 Set the speed along x.
  $C69D,$01 Return.

c $C69E Move Player East
@ $C69E label=MovePlayerEast
D $C69E Adds three to the speed along x, for the player to walk along x away
. from zero.
E $C69E View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA43 }
. { #ALIENEIGHT$C340 }
. LIST#
R $C69E IX Record of the legs
  $C69E,$03 Fetch the speed along x.
  $C6A1,$02 Add three to it.
  $C6A3,$02 Jump to #R$C69A to set the speed.

c $C6A5 Move Player North
@ $C6A5 label=MovePlayerNorth
D $C6A5 Adds three to the speed along y, for the player to walk along y away
. from zero.
E $C6A5 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA4A }
. { #ALIENEIGHT$C347 }
. LIST#
R $C6A5 IX Record of the legs
  $C6A5,$03 Fetch the speed along y.
  $C6A8,$02 Add three to it.
@ $C6AA label=MovePlayer_SetY
  $C6AA,$03 Set the speed along y.
  $C6AD,$01 Return.

c $C6AE Move Player South
@ $C6AE label=MovePlayerSouth
D $C6AE Takes three off the speed along y, for the player to walk along y
. towards zero.
E $C6AE View the equivalent code in;
. #LIST
. { #KNIGHTLORE$CA53 }
. { #ALIENEIGHT$C350 }
. LIST#
R $C6AE IX Record of the legs
  $C6AE,$03 Fetch the speed along y.
  $C6B1,$02 Take three off it.
  $C6B3,$02 Jump to #R$C6AA to set the speed.

c $C6B5 Do Nothing
@ $C6B5 label=DoNothing
D $C6B5 A routine that does nothing, which is called by #R$C61D.
  $C6B5,$01 Return.

c $C6B6 Build Room
@ $C6B6 label=BuildRoom
D $C6B6 Builds the room that the player has gone into, and puts the player into
. it. The room is built in the buffer and the whole room is drawn on the next
. pass of the main loop.
  $C6B6,$04 Start with the first object record, #R$A76F, which is the legs
. of the player.
  $C6BA,$03 Call #R$CB81 to clear the buffer.
  $C6BD,$03 Call #R$C92C to make the scenery of the room.
  $C6C0,$03 Call #R$CA82 to put the player at the door that it came through.
  $C6C3,$03 Call #R$C6CC to note that the room has been visited.
  $C6C6,$05 Set the flag in #R$A711, to say that the room has to be drawn.
  $C6CB,$01 Return.

c $C6CC Mark Room Visited
@ $C6CC label=MarkRoomVisited
D $C6CC Sets the bit for a room in the table of the rooms that the player has
. visited, #R$A74F. The room number is in eight bits: the upper five choose the
. byte, and the lower three choose the bit, starting from the top of the byte.
R $C6CC IX Record of the legs, which holds the number of the room
  $C6CC,$03 Fetch the room.
  $C6CF,$03 Move the upper five bits of the room to the lower five.
  $C6D2,$02,b$01 Keep only those bits.
  $C6D4,$01 Set the offset of the byte in #REGe.
  $C6D5,$03 Fetch the room again.
  $C6D8,$02,b$01 Keep only the lower three bits.
  $C6DA,$01 Keep the bit number.
  $C6DB,$01 Add one to it, to be the number of times to rotate.
  $C6DC,$01 Start with all of the bits clear.
  $C6DD,$01 Set the carry flag.
@ $C6DE label=MarkRoomVisited_Rotate
  $C6DE,$01 Rotate the carry flag in from the left.
  $C6DF,$02 Decrease the counter and loop until the bit is in place.
  $C6E1,$02 Set #REGd to zero, to make the offset of the byte a whole number.
  $C6E3,$03 Start at the table of rooms visited.
  $C6E6,$01 Add the offset to get the address of the byte.
  $C6E7,$01 Add the bit for this room to those that are set.
  $C6E8,$01 Set the byte.
  $C6E9,$01 Return.

c $C6EA Print Quest Percentage
@ $C6EA label=PrintQuestPercentage
D $C6EA Works out how much of the quest has been done, and prints it to the
. buffer for the game over screen. The percentage is the number of rooms that
. have been visited, halved and no more than #N$36, plus four for each of the
. objects that have been collected, plus six for each of the stones that have
. been put on the pentagram. That makes #N$64 at the most.
D $C6EA The percentage is kept in #R$A74D as binary coded decimal, and it is
. printed as three digits if it is #N$64, and otherwise as two.
.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$C6EA and #R$B178 }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #POKES$A74C,$02
. #SIM(start=$C323,stop=$C33D,sp=$5E00)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$02,$05,$09,$16,$06(quest-percentage-before)
. | #SIM(start=$C6EA,stop=$0000,sp=$5D00)
. #SIM(start=$B178,stop=$0000,sp=$5D00)
. #SCR$02,$05,$09,$16,$06(quest-percentage-after) } UDGTABLE# #POPS
  $C6EA,$03 Start at the table of rooms visited, #R$A74F.
  $C6ED,$02 Set a counter in #REGc of #N$1F bytes.
  $C6EF,$02 Set the count of rooms in #REGe to zero.
@ $C6F1 label=PrintQuestPercentage_Byte
  $C6F1,$02 Set a counter in #REGb of eight bits.
  $C6F3,$01 Fetch the byte.
@ $C6F4 label=PrintQuestPercentage_Bit
  $C6F4,$01 Move a bit into the carry flag.
  $C6F5,$03 Count the room if the bit is set.
@ $C6F8 label=PrintQuestPercentage_Next
  $C6F8,$02 Decrease the counter and loop until all eight bits have been
. counted.
  $C6FA,$01 Move on to the next byte.
  $C6FB,$03 Count down the bytes and loop until all of them have been counted.
N $C6FE Add up the points.
  $C6FE,$02 Halve the count of rooms.
  $C700,$01 Fetch it.
  $C701,$04 Jump to #R$C707 if it is below #N$36.
  $C705,$02 Use #N$36 instead.
@ $C707 label=PrintQuestPercentage_Total
  $C707,$03 Fetch the number of objects that have been collected.
  $C70A,$02 Multiply it by four.
  $C70C,$01 Add the points for the rooms.
  $C70D,$01 Set the total in #REGe.
  $C70E,$03 Fetch the number of stones that have been placed.
  $C711,$01 Multiply it by two.
  $C712,$01 Stash twice the number of stones in #REGd.
  $C713,$01 Multiply it by two again.
  $C714,$01 Add the earlier value, to make six times the number of stones.
  $C715,$01 Add the total, to make the number of points.
  $C716,$01 Set the counter in #REGb to the number of points.
N $C717 Convert the points into decimal.
  $C717,$01 Start from zero.
@ $C718 label=PrintQuestPercentage_Count
  $C718,$02 Add one.
  $C71A,$01 Convert the number to decimal.
  $C71B,$02 Decrease the counter and loop until it has been added up.
  $C71D,$03 Set the lower two digits of the percentage.
  $C720,$02 Set #REGa to zero.
  $C722,$02 Add the carry flag, which is set if the percentage is #N$64 or more.
  $C724,$03 Set the digit that is the hundreds.
  $C727,$01 Keep the digit and the flags.
N $C728 Print the percentage in the buffer.
  $C728,$03 Set the position of the number in #REGbc.
  $C72B,$03 Call #R$B37F to get the address in the buffer.
  $C72E,$02 Copy it to #REGhl.
  $C730,$01 Restore the digit and the flags.
  $C731,$03 Take the percentage, #R$A74D.
  $C734,$02 Set a counter in #REGb of one byte.
  $C736,$03 Jump to #R$C745 if the percentage is under #N$64.
  $C739,$01 Set the counter to two bytes.
  $C73A,$01 Stash the buffer address on the stack.
  $C73B,$06 Set the glyph table to the start of the font, #N$8355, where the
. digits are.
  $C741,$01 Restore the buffer address from the stack.
  $C742,$03 Jump to #R$BB5A to print the digits, starting from the lower digit
. of the first byte.
@ $C745 label=PrintQuestPercentage_TwoDigits
  $C745,$02 Move on to the next byte and the next place in the buffer.
  $C747,$03 Jump to #R$BB48 to print the digits.
  $C74A,$01 Return, which nothing does.

c $C74B Set Sprite Offset Minus 8 0
@ $C74B label=SetSpriteOffset_Minus8_0
D $C74B Sets how far the sprite of an object is moved from the position on the
. screen that is worked out for it by #R$B2C5, which is #N$08 to the left and
. none up. The same is done by each of the routines up to #R$C784, which differ
. in the distances. It is also the handler of the object type #N$39, which does
. nothing else.
R $C74B IX Object record
  $C74B,$03 Set the offsets in #REGhl, which are #N$F8 horizontally and #N$00
. vertically.
  $C74E,$02 Jump to #R$C76E to set them.

c $C750 Set Sprite Offset Minus 4 Minus 12
@ $C750 label=SetSpriteOffset_Minus4_Minus12
D $C750 Sets the offsets of the sprite to #N$FC horizontally and #N$F4
. vertically.
R $C750 IX Object record
  $C750,$03 Set the offsets in #REGhl.
  $C753,$02 Jump to #R$C76E to set them.

c $C755 Set Sprite Offset Minus 36 Minus 4
@ $C755 label=SetSpriteOffset_Minus36_Minus4
D $C755 Sets the offsets of the sprite to #N$DC horizontally and #N$FC
. vertically.
R $C755 IX Object record
  $C755,$03 Set the offsets in #REGhl.
  $C758,$02 Jump to #R$C76E to set them.

c $C75A Set Sprite Offset Minus 20 Minus 8
@ $C75A label=SetSpriteOffset_Minus20_Minus8
D $C75A Sets the offsets of the sprite to #N$EC horizontally and #N$F8
. vertically.
R $C75A IX Object record
  $C75A,$03 Set the offsets in #REGhl.
  $C75D,$02 Jump to #R$C76E to set them.

c $C75F Set Sprite Offset Minus 16 Minus 8
@ $C75F label=SetSpriteOffset_Minus16_Minus8
D $C75F Sets the offsets of the sprite to #N$F0 horizontally and #N$F8
. vertically.
R $C75F IX Object record
  $C75F,$03 Set the offsets in #REGhl.
  $C762,$02 Jump to #R$C76E to set them.

c $C764 Set Sprite Offset Minus 12 Minus 8
@ $C764 label=SetSpriteOffset_Minus12_Minus8
D $C764 Sets the offsets of the sprite to #N$F4 horizontally and #N$F8
. vertically.
R $C764 IX Object record
  $C764,$03 Set the offsets in #REGhl.
  $C767,$02 Jump to #R$C76E to set them.

c $C769 Set Sprite Offset Minus 16 Minus 12
@ $C769 label=SetSpriteOffset_Minus16_Minus12
D $C769 Sets the offsets of the sprite to #N$F0 horizontally and #N$F4
. vertically.
R $C769 IX Object record
  $C769,$03 Set the offsets in #REGhl.
  $C76C,$02 Jump to #R$C76E to set them.

c $C76E Store Pixel Adjustments
@ $C76E label=StorePixelAdjustments
D $C76E Sets the amounts that the sprite of an object is moved horizontally and
. vertically from where its position puts it on the screen.
E $C76E View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C72B }
. LIST#
R $C76E L Horizontal offset
R $C76E H Vertical offset
R $C76E IX Object record
  $C76E,$03 Set the horizontal offset of the object.
  $C771,$03 Set the vertical offset of the object.
  $C774,$01 Return.

c $C775 Set Sprite Offset Minus 12 Minus 6
@ $C775 label=SetSpriteOffset_Minus12_Minus6
D $C775 Sets the offsets of the sprite to #N$F4 horizontally and #N$FA
. vertically.
R $C775 IX Object record
  $C775,$03 Set the offsets in #REGhl.
  $C778,$02 Jump to #R$C76E to set them.

c $C77A Set Sprite Offset Minus 12 Minus 4
@ $C77A label=SetSpriteOffset_Minus12_Minus4
D $C77A Sets the offsets of the sprite to #N$F4 horizontally and #N$FC
. vertically.
R $C77A IX Object record
  $C77A,$03 Set the offsets in #REGhl.
  $C77D,$02 Jump to #R$C76E to set them.

c $C77F Set Sprite Offset Minus 8 Minus 4
@ $C77F label=SetSpriteOffset_Minus8_Minus4
D $C77F Sets the offsets of the sprite to #N$F8 horizontally and #N$FC
. vertically. It is also the handler of the object types #N$35 to #N$38, which
. do nothing else.
R $C77F IX Object record
  $C77F,$03 Set the offsets in #REGhl.
  $C782,$02 Jump to #R$C76E to set them.

c $C784 Set Sprite Offset Minus 8 Minus 2
@ $C784 label=SetSpriteOffset_Minus8_Minus2
D $C784 Sets the offsets of the sprite to #N$F8 horizontally and #N$FE
. vertically. It is also the handler of the object types #N$0C to #N$0F and
. #N$34, which do nothing else.
R $C784 IX Object record
  $C784,$03 Set the offsets in #REGhl.
  $C787,$02 Jump to #R$C76E to set them.

c $C789 Run Door Frame
@ $C789 label=RunDoorFrame
D $C789 The handler of the object types #N$07 and #N$09, which are the frames of
. the doors in the walls. They only have to be placed on the screen: the doors
. themselves are the object types #N$06 and #N$08, run by #R$C7AD.
R $C789 IX Object record
  $C789,$06 Jump to #R$C79C if the frame is mirrored.
  $C78F,$03 Fetch the type.
  $C792,$04 Jump to #R$C7A2 if it is type #N$09.
  $C796,$03 Set the offsets for type #N$07, which are #N$F9 horizontally and
. #N$FB vertically.
  $C799,$03 Jump to #R$C76E to set them.
@ $C79C label=RunDoorFrame_Mirrored
  $C79C,$03 Set the offsets for a mirrored frame, which are #N$F9 horizontally
. and #N$FC vertically.
  $C79F,$03 Jump to #R$C76E to set them.
@ $C7A2 label=RunDoorFrame_TypeNine
  $C7A2,$03 Set the offsets for type #N$09, which are #N$F0 horizontally and
. #N$FB vertically.
  $C7A5,$03 Jump to #R$C76E to set them.

c $C7A8 Set Door Offset Type Eight
@ $C7A8 label=SetDoorOffsetTypeEight
D $C7A8 Sets the offsets of the sprite of a door of type #N$08 that is not
. mirrored, and carries on with the handler of the door.
R $C7A8 IX Door record
  $C7A8,$03 Set the offsets for the sprite in #REGhl, which are #N$F8
. horizontally and #N$FB vertically.
  $C7AB,$02 Jump to #R$C7BD to carry on.

c $C7AD Handle Near Arch
@ $C7AD label=HandleNearArch
D $C7AD The handler of the object types #N$06 and #N$08, which are the doors in
. the walls of a room. A door does not change, but it checks for the player
. standing in the doorway, which makes the player pass into the room on the
. other side.
D $C7AD A door that is not mirrored is in a wall at one end of the x axis, and
. has the place that the player has to be at, in front of it, held in the speeds
. along x and y and the position along z of its record, which no other object
. uses as it does not move. The place is #N$0D further along y than the door.
. When the door is mirrored it is in a wall at one end of the y axis and the
. place is #N$0D back along x.
E $C7AD View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C73C }
. { #ALIENEIGHT$BFEA }
. LIST#
R $C7AD IX Door record
  $C7AD,$06 Jump to #R$C7DD if the door is mirrored.
  $C7B3,$03 Fetch the type.
  $C7B6,$04 Jump to #R$C7A8 if it is type #N$08.
  $C7BA,$03 Set the offsets for the sprite of type #N$06 in #REGhl, which are
. #N$FB horizontally and #N$FB vertically.
@ $C7BD label=HandleNearArch_Place
  $C7BD,$03 Call #R$C76E to set the offsets.
  $C7C0,$08 Set the y position of the place in front of the door, which is #N$0D
. further than the door.
  $C7C8,$06 Set the x position of the place in front of the door, which is the
. same as that of the door.
  $C7CE,$03 Set the sizes of the area that the player has to be in, which are
. #N$0F along x and #N$06 along y, in #REGhl.
@ $C7D1 label=HandleNearArch_Check
  $C7D1,$06 Set the z position of the place in front of the door, which is the
. same as that of the door.
  $C7D7,$03 Call #R$C802 to find out if the player is passing through the door.
  $C7DA,$03 Jump to #R$C8D2 to push the player towards the door.
@ $C7DD label=HandleNearArch_Mirrored
N $C7DD The door is mirrored.
  $C7DD,$03 Fetch the type.
  $C7E0,$04 Jump to #R$C7FD if it is type #N$08.
  $C7E4,$03 Set the offsets for the sprite of type #N$06 in #REGhl, which are
. #N$EF horizontally and #N$FA vertically.
@ $C7E7 label=HandleNearArch_MirroredPlace
  $C7E7,$03 Call #R$C76E to set the offsets.
  $C7EA,$08 Set the x position of the place in front of the door, which is #N$0D
. less than that of the door.
  $C7F2,$06 Set the y position of the place in front of the door, which is the
. same as that of the door.
  $C7F8,$03 Set the sizes of the area that the player has to be in, which are
. #N$06 along x and #N$0F along y.
  $C7FB,$02 Jump to #R$C7D1.
@ $C7FD label=HandleNearArch_MirroredTypeEight
  $C7FD,$03 Set the offsets for the sprite of type #N$08 in #REGhl, which are
. #N$F0 horizontally and #N$FB vertically.
  $C800,$02 Jump to #R$C7E7.

c $C802 Test Door Passage
@ $C802 label=TestDoorPassage
D $C802 Finds out if the player is going through a door. This is so when the
. player is standing in the place in front of the door and is allowed to open
. doors, which means that the player has to be alive. If it is, the player is
. let pass through the walls, and once it has gone far enough through, it is put
. into the next room, which is the room of the door.
D $C802 When the player enters the next room it is put at the other side of the
. room along the same axis, the player's two object records are saved in #R$C3FF
. so that the player starts here again after losing a life, and the main loop is
. restarted at #R$AFC8 to build the room.
R $C802 IX Door record
R $C802 HL Sizes of the area in front of the door that the player has to be in,
. along x and along y
  $C802,$04 Start with the first object record, #R$A76F, which is the legs
. of the player.
  $C806,$03 Fetch the type of the legs.
  $C809,$02 Take away #N$10 from it.
  $C80B,$03 Return if the legs are not of a type that is from #N$10 to #N$2F,
. which are the types of the player when alive.
  $C80E,$05 Return if the player cannot open doors.
  $C813,$04 Return if the player is not in front of the door.
  $C817,$04 Make the player ignore the walls, so that it can go through the
. door.
  $C81B,$03 Take the table of the routines for the four directions that the
. player may face, #R$C83B.
  $C81E,$03 Fetch the limits of the room.
  $C821,$01 Stash them on the stack.
N $C822 Work out the direction that the player is facing, in the same way as
. #R$C5BD.
  $C822,$03 Fetch the flags of the legs.
  $C825,$03 Move bit 6, which mirrors the object, down to bit 3.
  $C828,$02,b$01 Keep only that bit.
  $C82A,$02,b$01 Flip it, to say that the object is not mirrored.
  $C82C,$01 Stash the flag in #REGl.
  $C82D,$03 Fetch the type of the legs.
  $C830,$02,b$01 Keep only bit 2 of the type.
  $C832,$01 Combine it with the other bit.
  $C833,$02 Move the two bits down to bits 0 and 1.
  $C835,$02,b$01 Keep only those two bits.
  $C837,$01 Set the direction in #REGl.
  $C838,$03 Jump to #R$B003 to run the routine for the direction.

w $C83B Door_Passage_Routines
@ $C83B label=DoorPassageRoutines
D $C83B The routines that #R$C802 uses to find out if the player has gone far
. enough through a door, for each of the four directions that the player can
. face.
W $C83B,$08,$02

c $C843 Test Passage Along Minus X
@ $C843 label=TestPassageAlongMinusX
D $C843 Finds out if the player is far enough through the wall on the side of
. low x, which is when the whole of it is beyond the limit. If it is, the player
. is put at the opposite side of the next room.
R $C843 IX Door record
R $C843 IY Record of the legs of the player
  $C843,$01 Restore the limits of the room from the stack.
  $C844,$02 Set #REGa to #N$80, the middle of the room.
  $C846,$01 Take the limit along x away from it, to get the position of the
. wall.
  $C847,$01 Set the position of the wall in #REGl.
  $C848,$03 Fetch the x position of the player.
  $C84B,$03 Add the half size along x.
  $C84E,$02 Return if the player is not through the wall.
  $C850,$04 Put the player at the lowest x position, ready for the next room.
@ $C854 label=TestPassageAlongMinusX_Done
  $C854,$06 Set the room of the player to the room of the door.
  $C85A,$03 Fetch the collision flags of the player.
  $C85D,$02,b$01 Set the countdown from entering the room to three.
  $C85F,$03 Set them.
  $C862,$03 Take the first object record, using the stack.
  $C865,$03 Take the records of the player to start from, #R$C3FF.
  $C868,$03 Set the number of bytes to copy in #REGbc to #N$40, which is two
. records.
  $C86B,$02 Save the records of the player.
  $C86D,$04 Throw away the two return addresses on the stack.
  $C871,$03 Jump to #R$AFC8 to build the next room.

c $C874 Test Passage Along Plus X
@ $C874 label=TestPassageAlongPlusX
D $C874 Finds out if the player is far enough through the wall on the side of
. high x, in the same way as #R$C843.
R $C874 IX Door record
R $C874 IY Record of the legs of the player
  $C874,$01 Restore the limits of the room from the stack.
  $C875,$01 Fetch the limit along x.
  $C876,$02 Add #N$80 to it, to get the position of the wall.
  $C878,$01 Keep the position of the wall.
  $C879,$03 Fetch the x position of the player.
  $C87C,$03 Take away the half size along x.
  $C87F,$02 Return if the player is not through the wall.
  $C881,$04 Put the player at the highest x position, ready for the next room.
  $C885,$02 Jump to #R$C854.

c $C887 Test Passage Along Plus Y
@ $C887 label=TestPassageAlongPlusY
D $C887 Finds out if the player is far enough through the wall on the side of
. high y, in the same way as #R$C843.
R $C887 IX Door record
R $C887 IY Record of the legs of the player
  $C887,$01 Restore the limits of the room from the stack.
  $C888,$01 Fetch the limit along y.
  $C889,$02 Add #N$80 to it, to get the position of the wall.
  $C88B,$01 Keep the position of the wall.
  $C88C,$03 Fetch the y position of the player.
  $C88F,$03 Take away the half size along y.
  $C892,$02 Return if the player is not through the wall.
  $C894,$04 Put the player at the highest y position, ready for the next room.
  $C898,$02 Jump to #R$C854.

c $C89A Test Passage Along Minus Y
@ $C89A label=TestPassageAlongMinusY
D $C89A Finds out if the player is far enough through the wall on the side of
. low y, in the same way as #R$C843.
R $C89A IX Door record
R $C89A IY Record of the legs of the player
  $C89A,$01 Restore the limits of the room from the stack.
  $C89B,$02 Set #REGa to #N$80, the middle of the room.
  $C89D,$01 Take the limit along y away from it, to get the position of the
. wall.
  $C89E,$01 Keep the position of the wall.
  $C89F,$03 Fetch the y position of the player.
  $C8A2,$03 Add the half size along y.
  $C8A5,$02 Return if the player is not through the wall.
  $C8A7,$04 Put the player at the lowest y position, ready for the next room.
  $C8AB,$02 Jump to #R$C854.

c $C8AD Test Near To
@ $C8AD label=TestNearTo
D $C8AD Tests if the player is standing in the place in front of a door, which
. is a box that is centred on the place that is held in the speeds and the z
. position of the door, as far as the sizes in #REGhl along x and y and #N$04
. along z.
E $C8AD View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C7FE }
. { #ALIENEIGHT$C099 }
. LIST#
R $C8AD H Size of the box along y
R $C8AD L Size of the box along x
R $C8AD IX Door record
R $C8AD IY Record of the legs of the player
R $C8AD O:F Carry flag set if the player is in the box
  $C8AD,$03 Fetch the x position of the place.
  $C8B0,$03 Take away the x position of the player.
  $C8B3,$02 Jump to #R$C8B7 if the difference is not negative.
  $C8B5,$02 Make it positive.
@ $C8B7 label=TestNearTo_Y
  $C8B7,$02 Return with the carry flag clear if it is not less than the size of
. the box along x.
  $C8B9,$03 Fetch the y position of the place.
  $C8BC,$03 Take away the y position of the player.
  $C8BF,$02 Jump to #R$C8C3 if the difference is not negative.
  $C8C1,$02 Make it positive.
@ $C8C3 label=TestNearTo_Z
  $C8C3,$02 Return with the carry flag clear if it is not less than the size of
. the box along y.
  $C8C5,$03 Fetch the z position of the place.
  $C8C8,$03 Take away the z position of the player.
  $C8CB,$02 Jump to #R$C8CF if the difference is not negative.
  $C8CD,$02 Make it positive.
@ $C8CF label=TestNearTo_Done
  $C8CF,$02 Compare the difference with #N$04.
  $C8D1,$01 Return with the carry flag set if it is less.

c $C8D2 Nudge Objects To Arch
@ $C8D2 label=NudgeObjectsToArch
D $C8D2 Gives the player a small push towards the middle of a door, when it is
. standing in front of it. The push is along x or y, depending on the direction
. that the player is facing and the type of the door. That way the player does
. not have to line up exactly to go through.
E $C8D2 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C02C }
. LIST#
R $C8D2 IX Door record
  $C8D2,$03 Set the size of the box in front of the door in #REGhl to #N$0F
. along both x and y.
  $C8D5,$04 Start with the first object record, #R$A76F, which is the legs
. of the player.
  $C8D9,$05 Return if the legs are not in use.
  $C8DE,$05 Return if the player cannot open doors.
  $C8E3,$04 Return if the player is not in front of the door.
  $C8E7,$03 Take the table of routines for type #N$08, #R$C8F7.
  $C8EA,$07 Jump to #R$C686 to run the routine for the direction if the door is
. type #N$08.
  $C8F1,$03 Take the table of routines for type #N$06, #R$C8FF.
  $C8F4,$03 Jump to #R$C686 to run the routine for the direction.

w $C8F7 Door Push Routines
@ $C8F7 label=DoorPushRoutines
D $C8F7 The routines that #R$C8D2 uses to push the player, for each of the four
. directions that the player can face. The first four are for doors of type
. #N$08 and the second four are for doors of type #N$06.
W $C8F7,$08,$02 The routines for doors of type #N$08.
@ $C8FF label=DoorPushRoutines_Type06
W $C8FF,$08,$02 The routines for doors of type #N$06.

c $C907 Nudge Object East West
@ $C907 label=NudgeObjectEastWest
D $C907 Gives the player a push of one along y, towards the y position that is
. held in the speed along y of a door.
E $C907 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C050 }
. { #KNIGHTLORE$C7B1 }
. LIST#
R $C907 IX Door record
R $C907 IY Record of the legs of the player
  $C907,$03 Fetch the y position of the place in front of the door.
  $C90A,$03 Compare it with the y position of the player.
  $C90D,$02 Jump to #R$C92B if they are the same.
  $C90F,$02 Set the push to one.
  $C911,$02 Jump to #R$C915 if the place is further along than the player.
  $C913,$02 Make the push minus one.
@ $C915 label=NudgeObjectEastWest_Set
  $C915,$03 Set the push along y of the player.
  $C918,$02 Jump to #R$C92B.

c $C91A Nudge Object North South
@ $C91A label=NudgeObjectNorthSouth
D $C91A Gives the player a push of one along x, towards the x position that is
. held in the speed along x of a door.
R $C91A IX Door record
R $C91A IY Record of the legs of the player
  $C91A,$03 Fetch the x position of the place in front of the door.
  $C91D,$03 Compare it with the x position of the player.
  $C920,$02 Jump to #R$C92B if they are the same.
  $C922,$02 Set the push to one.
  $C924,$02 Jump to #R$C928 if the place is further along than the player.
  $C926,$02 Make the push minus one.
@ $C928 label=NudgeObjectNorthSouth_Set
  $C928,$03 Set the push along x of the player.
@ $C92B label=NudgeObjectNorthSouth_Done
  $C92B,$01 Return.

c $C92C Build Room Scenery
@ $C92C label=BuildRoomScenery
D $C92C Makes the scenery objects of a room, from the data of the room, which
. starts at #R$5E10 and has a record for each of the rooms. A record is the room
. number, then a length byte (which counts itself and the bytes after it), then
. a byte holding the ink colour of the room in bits 0-2 and the size of the room
. in bits 3-7, then the features of the room and then the groups of templates.
. The size is the index of one of the three #N$03-byte entries at #R$5E07, which
. hold the distance from the centre of the room to the walls on the x axis and
. the y axis, and the height of the floor.
D $C92C The features are pairs of bytes: the number of a feature and a
. parameter, ended by #N$FF (or by the end of the data of the room, as #N$2B of
. the rooms have no #N$FF). The number is the index into the table of addresses
. at #R$696D. A feature is a list of the eight bytes of one or more objects (the
. type, x, y, z, the sizes along each axis and the flags) that ends with a zero
. in place of the type of another object. These are the doors and their frames,
. and the objects that are fixed to the walls. The parameter is stored in the
. room field of each of the objects in the feature, which makes it the number of
. the room that a door leads to.
D $C92C Each group of templates that follows is a byte holding the number of a
. template in bits 3-7 and, in bits 0-2, one less than the number of cells that
. follow, and then a byte for each of the cells. A cell holds the x position in
. bits 0-2 and the y position in bits 3-5 (in steps of #N$10 from #N$48), and
. the height in bits 6-7 (in steps of #N$0C above the floor). A template is a
. list of the five bytes of one or more objects (the type, the sizes along each
. axis and the flags) that ends with a zero in place of the type of another
. object, and an object is made from it for each of the cells. The template
. numbers are the indexes into the table of addresses that starts at #R$6CE5,
. which a group with the number #N$1F moves on by #N$20 templates, though no
. room has one. The last group of rooms #N$0D and #N$6C is cut short by the end
. of their data.
D $C92C The objects are made from the last of the object slots, which is at
. #R$AE0F, and downwards. The first feature of a room is always a door, with its
. frame in the last slot and the door in the one before, so that the doors are
. found by #R$CAEE in the slots at the top. The player and the creatures have
. the slots at the start.
E $C92C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CCA7 }
. LIST#
R $C92C IX Object record of the player's legs
  $C92C,$03 Call #R$CB54 to clear all of the objects except for the player.
  $C92F,$06 Start with the first of the tables of templates, which is #R$6CE5.
  $C935,$04 Set the offset of the cells to zero.
  $C939,$03 Take the last of the object slots.
  $C93C,$03 Take the end of the room data, which is #R$696D.
  $C93F,$03 Start at the first room record, which is #R$5E10.
@ $C942 label=BuildRoomScenery_FindRoomRecord
  $C942,$02 Fetch the number of the room, and move on to the length.
  $C944,$05 Jump to #R$C953 if it is the room that the player is in.
  $C949,$01 Fetch the length of the record.
  $C94A,$03 Call #R$B519 to move on to the next record.
  $C94D,$04 Compare #REGhl with the end of the room data, which sets the carry
. flag if it is before it.
  $C951,$02 Jump to #R$C942 if there are more records.
@ $C953 label=BuildRoomScenery_ReadRoomHeader
  $C953,$02 Fetch the length of the record into #REGb, and move on to the colour
. and size of the room.
  $C955,$01 Fetch the colour and size of the room.
  $C956,$02,b$01 Keep the ink colour.
  $C958,$02,b$01 Set the bright bit.
  $C95A,$03 Store it as the colour of the room.
  $C95D,$01 Save the address of the next free object slot.
  $C95E,$01 Put the address of the room data in #REGde.
  $C95F,$02 Fetch the colour and size again, and move on to the first feature.
  $C961,$03 Move the size of the room to bits 0-4.
  $C964,$02,b$01 Keep it.
  $C966,$01 Put the size in #REGc.
  $C967,$02 Multiply the size by three.
  $C969,$03 Take the sizes of the rooms, which is #R$5E07.
  $C96C,$03 Call #R$B519 to find the entry for the size.
  $C96F,$05 Fetch the distance to the walls along x, move on and store it.
  $C974,$05 Fetch the distance to the walls along y, move on and store it.
  $C979,$04 Fetch the height of the floor and store it.
  $C97D,$02 Count the length and the colour and size as read.
  $C97F,$01 Put the address of the room data back in #REGhl.
  $C980,$01 Get the address of the next free object slot back.
@ $C981 label=BuildRoomScenery_MakeFeature
  $C981,$02 Fetch the number of the feature, and move on to its parameter.
  $C983,$04 Jump to #R$C9B6 if it is the end of the features.
  $C987,$02 Save the number of bytes left to read and the address of the
. parameter.
  $C989,$03 Put the number of the feature in #REGhl.
  $C98C,$01 Double it.
  $C98D,$03 Take the table of addresses of the features, which is
. #R$696D.
  $C990,$01 Add the offset to find the entry for the feature.
  $C991,$02 Fetch the low byte of the address of the feature, and move on.
  $C993,$02 Fetch the high byte, and make the address of the feature in #REGhl.
@ $C995 label=BuildRoomScenery_MakeFeatureObject
  $C995,$03 Set the number of bytes that make an object in a feature, which is
. eight.
  $C998,$02 Copy the type, position, sizes and flags into the object slot.
  $C99A,$03 Fetch the parameter, leaving the address in the feature on the
. stack.
  $C99D,$02 Store it in the room field of the object, and move on.
  $C99F,$02 Set the number of bytes to clear, which is the rest of the object.
  $C9A1,$03 Call #R$B513 to clear them.
  $C9A4,$01 Save the address in the feature.
  $C9A5,$04 Subtract #N$20 from #REGde, by adding #N$FFC0...
  $C9A9,$01 ...and put it back in #REGde.
  $C9AA,$01 Get the address in the feature back.
  $C9AB,$04 Jump to #R$C995 to make another object if the next type in the
. feature is not zero.
  $C9AF,$02 Get the address of the parameter and the number of bytes left to
. read.
  $C9B1,$01 Move on to the next feature.
  $C9B2,$01 Count the parameter as read.
  $C9B3,$02 Jump to #R$C981 for the next feature, counting the number as read,
. while any data is left.
  $C9B5,$01 Return.
@ $C9B6 label=BuildRoomScenery_MakeTemplates
  $C9B6,$01 Count the end of the features as read.
  $C9B7,$02 Save #REGiy.
  $C9B9,$03 Move on to the next free object slot.
@ $C9BC label=BuildRoomScenery_MakeTemplateGroup
  $C9BC,$01 Fetch the byte that holds the template and the number of cells.
  $C9BD,$02,b$01 Keep the number of cells less one.
  $C9BF,$01 Add one.
  $C9C0,$01 Put the number of cells in #REGc.
  $C9C1,$02 Fetch the byte again, and move on to the first cell.
  $C9C3,$01 Count it as read.
  $C9C4,$02 Fetch the first cell into #REGd, and move on.
  $C9C6,$01 Save the address of the next byte.
  $C9C7,$02 Move the template number to bits 1-5, which doubles it.
  $C9C9,$02,b$01 Keep it.
  $C9CB,$05 Jump to #R$CA6C if it is the template number that moves on the
. table.
  $C9D0,$03 Fetch the address of the table of templates.
  $C9D3,$03 Call #R$B519 to find the entry for the template.
  $C9D6,$02 Fetch the low byte of the address of the template, and move on.
  $C9D8,$02 Fetch the high byte, and make the address of the template in #REGhl.
@ $C9DA label=BuildRoomScenery_MakeTemplateCell
  $C9DA,$01 Save the address of the template.
@ $C9DB label=BuildRoomScenery_MakeTemplateObject
  $C9DB,$05 Copy the type from the template to the object.
  $C9E0,$05 Copy the half size along x.
  $C9E5,$05 Copy the half size along y.
  $C9EA,$05 Copy the half size along z.
  $C9EF,$05 Copy the flags.
  $C9F4,$06 Copy the room that the player is in to the room field of the object.
  $C9FA,$03 Fetch the cell offset.
  $C9FD,$03 Move bit 0 of the offset to bit 3.
  $CA00,$02,b$01 Keep it.
  $CA02,$01 Put it in #REGe.
  $CA03,$01 Fetch the cell.
  $CA04,$04 Move the x position of the cell to bits 4-6.
  $CA08,$02,b$01 Keep it.
  $CA0A,$01 Add bit 3 of the offset.
  $CA0B,$02 Add the start of the cells.
  $CA0D,$03 Store it as the x position of the object.
  $CA10,$03 Fetch the cell offset.
  $CA13,$02 Move bit 1 of the offset to bit 3.
  $CA15,$02,b$01 Keep it.
  $CA17,$01 Put it in #REGe.
  $CA18,$01 Fetch the cell.
  $CA19,$01 Move the y position of the cell to bits 4-6.
  $CA1A,$02,b$01 Keep it.
  $CA1C,$01 Add bit 3 of the offset.
  $CA1D,$02 Add the start of the cells.
  $CA1F,$03 Store it as the y position of the object.
  $CA22,$01 Fetch the cell.
  $CA23,$02 Move the height of the cell to bits 0-1.
  $CA25,$02,b$01 Keep it.
  $CA27,$02 Multiply it by four.
  $CA29,$01 Put it in #REGe.
  $CA2A,$01 Multiply it by eight.
  $CA2B,$01 Add the four times to make it twelve times the height.
  $CA2C,$01 Put it in #REGe.
  $CA2D,$03 Fetch the cell offset.
  $CA30,$01 Add the height.
  $CA31,$02,b$01 Keep the multiple of four.
  $CA33,$01 Put it in #REGe.
  $CA34,$03 Fetch the height of the floor.
  $CA37,$01 Add the height of the cell.
  $CA38,$03 Store it as the z position of the object.
  $CA3B,$01 Save the number of bytes left to read and the number of cells.
  $CA3C,$03 Set the offset from the type to the byte after the room field, which
. is #N$09.
  $CA3F,$02 Add it to #REGiy.
  $CA41,$02 Set the number of bytes to clear, which is the rest of the object.
@ $CA43 label=BuildRoomScenery_ClearTemplateObject
  $CA43,$04 Clear a byte of the object.
  $CA47,$02 Move on to the next byte.
  $CA49,$02 Jump to #R$CA43 until the rest of the object is clear.
  $CA4B,$05 Subtract #N$40 from #REGiy, which moves it to the slot below the
. object.
  $CA50,$01 Get the number of bytes left to read and the number of cells back.
  $CA51,$04 Jump to #R$C9DB to make another object if the next type in the
. template is not zero.
  $CA55,$02 Get the address of the template and the address of the next byte of
. the room data.
  $CA57,$03 Count the cell as read, and jump to #R$CA66 if there is no more room
. data.
  $CA5A,$04 Count the object as made, and jump to #R$C9BC for the next group if
. there is no cell left.
  $CA5E,$02 Fetch the next cell, and move on.
  $CA60,$01 Save the address of the next byte.
  $CA61,$01 Put the address of the template in #REGhl.
  $CA62,$01 Put the cell in #REGd.
  $CA63,$03 Jump to #R$C9DA to make the object for it.
@ $CA66 label=BuildRoomScenery_FinishRoomScenery
  $CA66,$03 Put the address of the next free object slot in #REGde.
  $CA69,$02 Get the original #REGiy back.
  $CA6B,$01 Return.
@ $CA6C label=BuildRoomScenery_SwitchTemplateTable
  $CA6C,$03 Fetch the address of the table of templates.
  $CA6F,$02 Set the number of bytes to move on, which is #N$20 templates.
  $CA71,$03 Call #R$B519 to move on.
  $CA74,$03 Store it as the table of templates.
@ $CA77 label=BuildRoomScenery_NextTemplateGroup
  $CA77,$01 Count the unused cell as read.
  $CA78,$01 Get the address of the next group back.
  $CA79,$03 Jump to #R$C9BC to make the objects for it.

c $CA7C Set Cell Offset
@ $CA7C label=SetCellOffset
D $CA7C Never used. It would use a cell as the offset to add to the positions of
. the objects that are made from the cells that follow.
R $CA7C D Cell
  $CA7C,$04 Store the cell as the cell offset.
  $CA80,$02 Jump to #R$CA77 to carry on.

c $CA82 Place Player At Door
@ $CA82 label=PlacePlayerAtDoor
D $CA82 Moves the player to the doorway on the opposite side of a room to the
. one that it left the last room by. When the player goes through a door,
. #R$C802 sets the x or y position of the player to #N$00 or #N$FF to show which
. wall it went through. In the new room, the player is put in front of the door
. in the opposite wall, in the doorway, with the edge of the player nearest the
. centre of the room two units inside the wall. Nothing is done when the player
. is not at one of the edges, which is how a game starts.
E $CA82 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D320 }
. { #ALIENEIGHT$CC01 }
. LIST#
R $CA82 IX Object record of the player's legs
  $CA82,$05 Fetch the distance to the walls along x and take off two, which is
. how far the player is put inside the wall.
  $CA87,$01 Put it in #REGl.
  $CA88,$05 Fetch the distance to the walls along y and take off two.
  $CA8D,$01 Put it in #REGh.
  $CA8E,$03 Fetch the x position of the player.
  $CA91,$03 Jump to #R$CAE1 if the player went through the wall at the start of
. x.
  $CA94,$03 Jump to #R$CAD1 if it went through the wall at the end of x, which
. is #N$FF.
  $CA97,$03 Fetch the y position of the player.
  $CA9A,$03 Jump to #R$CAC4 if the player went through the wall at the start of
. y.
  $CA9D,$03 Jump to #R$CAA1 if it went through the wall at the end of y, which
. is #N$FF.
  $CAA0,$01 Return.
@ $CAA1 label=PlacePlayerAtDoor_StartOfY
  $CAA1,$02 Set the wall to look for a door in, which is at the start of y.
  $CAA3,$03 Call #R$CAEE to find the door and put the player in front of it.
  $CAA6,$02 Set the position of the wall at the start of y, which is the centre
. of the room.
  $CAA8,$01 Subtract the distance to the walls less two...
  $CAA9,$03 ...and the half size of the player along y, which puts the edge of
. the player nearest the centre of the room two units inside the wall.
@ $CAAC label=PlacePlayerAtDoor_SetPlayerY
  $CAAC,$03 Store it as the y position of the player.
@ $CAAF label=PlacePlayerAtDoor_MarkPlayerForDrawing
  $CAAF,$04 Flag the legs as needing to be drawn.
  $CAB3,$04 Flag the body as needing to be drawn.
  $CAB7,$06 Copy the x position of the player to the body.
  $CABD,$06 Copy the y position of the player to the body.
  $CAC3,$01 Return.
@ $CAC4 label=PlacePlayerAtDoor_EndOfY
  $CAC4,$02 Set the wall to look for a door in, which is at the end of y.
  $CAC6,$03 Call #R$CAEE to find the door and put the player in front of it.
  $CAC9,$01 Fetch the distance to the walls less two.
  $CACA,$02 Add the position of the centre of the room...
  $CACC,$03 ...and the half size of the player along y.
  $CACF,$02 Jump to #R$CAAC to store it.
@ $CAD1 label=PlacePlayerAtDoor_StartOfX
  $CAD1,$02 Set the wall to look for a door in, which is at the start of x.
  $CAD3,$03 Call #R$CAEE to find the door and put the player in front of it.
  $CAD6,$02 Set the position of the wall at the start of x, which is the centre
. of the room.
  $CAD8,$01 Subtract the distance to the walls less two...
  $CAD9,$03 ...and the half size of the player along x, which puts the edge of
. the player nearest the centre of the room two units inside the wall.
@ $CADC label=PlacePlayerAtDoor_SetPlayerX
  $CADC,$03 Store it as the x position of the player.
  $CADF,$02 Jump to #R$CAAF to finish.
@ $CAE1 label=PlacePlayerAtDoor_EndOfX
  $CAE1,$02 Set the wall to look for a door in, which is at the end of x.
  $CAE3,$03 Call #R$CAEE to find the door and put the player in front of it.
  $CAE6,$01 Fetch the distance to the walls less two.
  $CAE7,$02 Add the position of the centre of the room...
  $CAE9,$03 ...and the half size of the player along x.
  $CAEC,$02 Jump to #R$CADC to store it.

c $CAEE Find Door
@ $CAEE label=FindDoor
D $CAEE Looks for the door in a particular wall of the room, and puts the player
. in the doorway in front of it. The doors are the first of the objects that
. were made for the room, and take two slots each (with their frames), so every
. other slot is checked, starting at the last, until one is found that does not
. hold a door (or up to four are checked).
D $CAEE The position that the player is put at is not the same as that of the
. door, but is the place that the door holds for it, which is #N$0D further
. along y than a door that is not mirrored, or #N$0D back along x than a
. mirrored one.
R $CAEE C The wall to look in: #N$00 is the end of x, #N$01 is the start of x,
. #N$02 is the end of y and #N$03 is the start of y
R $CAEE IX Object record of the player's legs
  $CAEE,$04 Start at the slot of the first door.
  $CAF2,$03 Set the offset to the previous door, which is #N$40 bytes back.
  $CAF5,$02 Set the number of doors to check.
@ $CAF7 label=FindDoor_Loop
  $CAF7,$03 Fetch the type of the object.
  $CAFA,$02 Subtract the type of the first door.
  $CAFC,$03 Return if it is not one of the types #N$06 to #N$09 of the doors and
. the frames.
  $CAFF,$01 Fetch the wall to look in.
  $CB00,$03 Jump to #R$CB33 if it is the end of x.
  $CB03,$03 Jump to #R$CB3C if it is the start of x.
  $CB06,$03 Jump to #R$CB45 if it is the end of y.
  $CB09,$07 Jump to #R$CB29 if the door is at the start of y, which is where the
. y position of the object is less than #N$40.
@ $CB10 label=FindDoor_Next
  $CB10,$02 Move on to the next door.
  $CB12,$02 Jump to #R$CAF7 until all of the doors have been checked.
  $CB14,$01 Return.
@ $CB15 label=FindDoor_PlacePlayerBesideDoorY
  $CB15,$08 Set the y position of the player to be #N$0D further along than the
. door.
@ $CB1D label=FindDoor_PlacePlayerAtDoorHeight
  $CB1D,$06 Copy the z position of the door to the player.
  $CB23,$05 Set the z position of the body to be #N$0C higher.
  $CB28,$01 Return.
@ $CB29 label=FindDoor_PlacePlayerBesideDoorX
  $CB29,$08 Set the x position of the player to be #N$0D back from the door.
  $CB31,$02 Jump to #R$CB1D to set the height.
@ $CB33 label=FindDoor_EndOfX
  $CB33,$03 Fetch the x position of the object.
  $CB36,$04 Jump to #R$CB15 if the door is at the end of x.
  $CB3A,$02 Jump to #R$CB10 to check the next door.
@ $CB3C label=FindDoor_StartOfX
  $CB3C,$03 Fetch the x position of the object.
  $CB3F,$04 Jump to #R$CB15 if the door is at the start of x.
  $CB43,$02 Jump to #R$CB10 to check the next door.
@ $CB45 label=FindDoor_EndOfY
  $CB45,$03 Fetch the y position of the object.
  $CB48,$04 Jump to #R$CB29 if the door is at the end of y.
  $CB4C,$02 Jump to #R$CB10 to check the next door.

c $CB4E Run Scenery
@ $CB4E label=RunScenery
D $CB4E The handler of the object types #N$0A, #N$0B, #N$4C, #N$52 and #N$98 to
. #N$9F, which are scenery that only has to be placed on the screen.
R $CB4E IX Object record
  $CB4E,$03 Jump to #R$C75F to set the offsets of the sprite.

c $CB51 Run Raised Scenery
@ $CB51 label=RunRaisedScenery
D $CB51 The handler of the object type #N$4D, which is scenery that only has to
. be placed on the screen. It differs from the others, run by #R$CB4E, in that
. its sprite is moved #N$0C up and not #N$08.
R $CB51 IX Object record
  $CB51,$03 Jump to #R$C769 to set the offsets of the sprite.

c $CB54 Clear Objects
@ $CB54 label=ClearObjects
D $CB54 Clears all of the objects from the third one on, which leaves the two of
. the player.
E $CB54 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE4E }
. LIST#
  $CB54,$03 Start at the third object, which is #R$A7AF.
  $CB57,$03 Set the number of bytes to clear, which is the size of #N$34
. objects.
  $CB5A,$02 Jump to #R$CB77 to clear them.

c $CB5C Clear Screen
@ $CB5C label=ClearScreen
D $CB5C Clears the pixels of the screen, and the first of the attributes.
.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$CB5C }
. { #SIM(start=$AF87,stop=$AFB6,sp=$5E00,clear=1)
. #SIM(start=$BB74,stop=$BB8E,sp=$5E00)
. #SCR$01(clear-screen-before)
. | #SIM(start=$CB5C,stop=$0000,sp=$5D00)
. #SCR$01(clear-screen-after) } UDGTABLE# #POPS
  $CB5C,$03 Start at the beginning of the display file.
  $CB5F,$03 Move on to the next byte of the display file.
  $CB62,$03 Set the number of bytes to copy, which is the size of the display
. file.
  $CB65,$02 Clear the first byte.
  $CB67,$02 Copy it through the rest.
  $CB69,$01 Return.

c $CB6A Fill Attributes
@ $CB6A label=FillAttributes
D $CB6A Sets all of the attributes of the screen to a colour, and sets the byte
. after them.
R $CB6A A Attribute
  $CB6A,$03 Start at the first attribute.
  $CB6D,$03 Move on to the next attribute.
  $CB70,$03 Set the number of bytes to copy, which is the number of attributes.
  $CB73,$01 Set the first attribute.
  $CB74,$02 Copy it through the rest.
  $CB76,$01 Return.

c $CB77 Fill Memory
@ $CB77 label=FillMemory
D $CB77 Clears a number of bytes of memory.
E $CB77 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE56 }
. { #GUNFRIGHT$D6E1 }
. { #KNIGHTLORE$D53A }
. { #MARTIANOIDS$B1A3 }
. { #NIGHTSHADE$E5BA }
. { #UNDERWURLDE$9569 }
. LIST#
R $CB77 BC Number of bytes
R $CB77 HL Address of the first byte
  $CB77,$02 Set the value to write to #N$00.
@ $CB79 label=FillMemory_WithValue
  $CB79,$01 Write the value to the next byte.
  $CB7A,$01 Move on to the next byte.
  $CB7B,$01 Decrease the counter.
  $CB7C,$04 Jump to #R$CB79 until all the bytes have been written.
  $CB80,$01 Return.

c $CB81 Clear Screen Buffer
@ $CB81 label=ClearScreenBuffer
D $CB81 Clears the screen buffer, in which the objects are drawn before they are
. copied to the screen.
E $CB81 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D567 }
. LIST#
  $CB81,$03 Set the number of bytes to clear, which is the size of the buffer.
  $CB84,$03 Start at the beginning of the buffer, which is #R$D88F.
  $CB87,$02 Jump to #R$CB77 to clear it.

c $CB89 Check Special Objects
@ $CB89 label=CheckSpecialObjects
D $CB89 Looks for any special object in the room, which is an ordinary object of
. one of the types #N$70 to #N$78 or #N$80 to #N$87, and sets the flag at
. #R$A742 to show if there is one. It is called when a room has been built.
  $CB89,$03 Call #R$D071 to point #REGiy at the first ordinary object, with the
. number of them in #REGb and the size of each in #REGde.
  $CB8C,$02 Set the first of the types to look for, #N$70.
@ $CB8E label=CheckSpecialObjects_Loop
  $CB8E,$03 Fetch the type of the object.
  $CB91,$04 Jump to #R$CBA7 if it is type #N$78.
  $CB95,$02,b$01 Keep the type without its lowest three bits.
  $CB97,$03 Jump to #R$CBA7 if it is one of the types #N$70 to #N$77.
  $CB9A,$04 Jump to #R$CBA7 if it is one of the types #N$80 to #N$87.
  $CB9E,$02 Move on to the next object.
  $CBA0,$02 Jump to #R$CB8E until all of the objects have been checked.
  $CBA2,$01 Set the flag value to zero, as there is not a special object.
@ $CBA3 label=CheckSpecialObjects_SetSpecialObjectFlag
  $CBA3,$03 Store the flag.
  $CBA6,$01 Return.
@ $CBA7 label=CheckSpecialObjects_FoundSpecialObject
  $CBA7,$02 Set the flag value to one.
  $CBA9,$02 Jump to #R$CBA3 to store it.

c $CBAB Create Creature
@ $CBAB label=CreateCreature
D $CBAB Makes a random creature, when the countdown has finished, and there is
. room for it. It is called once for each frame.
D $CBAB The routine does not make a creature in a room that has a special object
. in it. Otherwise it counts down the timer at #R$A73D (which is set by #R$CC31)
. and, when that is over, tries once for every four frames (judging by the
. random seed) to make a creature in one of the two object records reserved for
. creatures. If both are being used, nothing is done.
D $CBAB The creature that is made comes from the template of an object at
. #R$CC11, which is copied into the free record. After that the template is
. changed to a new creature of a random type, in a random place that is high
. above the floor, ready for the next time. If it is found to overlap another
. object there, its type is set to zero instead, which makes the object that is
. copied the next time one that does not exist.
  $CBAB,$03 Fetch the special object flag.
  $CBAE,$02 Return if there is a special object in the room.
  $CBB0,$03 Take the creature timer, #R$A73D.
  $CBB3,$01 Decrease the timer.
  $CBB4,$01 Return if it is not zero.
  $CBB5,$02 Set the timer to one, so that it is zero again after the next frame
. unless it is changed.
  $CBB7,$03 Fetch the random seed.
  $CBBA,$02,b$01 Keep the lowest two bits.
  $CBBC,$01 Return unless they are zero.
  $CBBD,$03 Call #R$CC31 to set the timer.
  $CBC0,$03 Start at the first of the objects for creatures, #R$A7EF.
  $CBC3,$03 Set the size of an object, #N$20, in #REGbc.
  $CBC6,$03 Take the template of the creature, #R$CC11.
  $CBC9,$01 Fetch the type of the object.
  $CBCA,$03 Jump to #R$CBD1 if it is free.
  $CBCD,$01 Move on to the second object for creatures.
  $CBCE,$01 Fetch the type of the object.
  $CBCF,$02 Return if it is not free either.
@ $CBD1 label=CreateCreature_Copy
  $CBD1,$01 Put the template against the free object.
  $CBD2,$03 Take the template as the object being filled in.
  $CBD5,$02 Copy the template into the free object.
  $CBD7,$03 Fetch the random seed.
  $CBDA,$02,b$01 Keep bits 0-3 and bit 5.
  $CBDC,$02 Add the start of the area for creatures, #N$68.
  $CBDE,$03 Set the x position of the creature in the template.
  $CBE1,$02 Fetch a random number from the refresh register.
  $CBE3,$02,b$01 Keep bits 0-3 and bit 5.
  $CBE5,$02 Add the start of the area for creatures, #N$68.
  $CBE7,$03 Set the y position of the creature in the template.
  $CBEA,$03 Fetch the random seed.
  $CBED,$03 Move bits 3-5 to bits 0-2.
  $CBF0,$02,b$01 Keep them.
  $CBF2,$01 Put the offset in #REGl.
  $CBF3,$02 Clear #REGh.
  $CBF5,$03 Take the types of creatures, #R$CC09.
  $CBF8,$01 Add the offset.
  $CBF9,$01 Fetch the type of creature.
  $CBFA,$03 Set the type of the creature in the template.
  $CBFD,$03 Call #R$B2C5 to work out where the creature is on the screen.
  $CC00,$03 Call #R$BF1B to find out if the creature overlaps an object where it
. is.
  $CC03,$01 Return if it does not.
  $CC04,$04 Set the type in the template to zero.
  $CC08,$01 Return.

b $CC09 Creature Types
@ $CC09 label=CreatureTypes
D $CC09 The types of the creatures that #R$CBAB makes. One of the eight is
. picked at random, which makes the types #N$A0, #N$30 and #N$50 twice as likely
. as #N$A4 and #N$A8.
B $CC09,$08,$08

g $CC11 Creature Template
@ $CC11 label=CreatureTemplate
D $CC11 The object record that #R$CBAB copies into a free object, and then
. changes to the next creature. The type is zero until a creature has been made,
. and the position is set by the routine. The creature has a z position of
. #N$D8, which is high above the floor, so it falls into the room.
B $CC11,$08,$08 The type, position, half sizes and flags.
B $CC19,$18,$08 The rest of the record, set by #R$B2C5.

c $CC31 Set Creature Timer
@ $CC31 label=SetCreatureTimer
D $CC31 Sets the number of frames that #R$CBAB waits before it makes a creature.
. The timer is four times two more than a count of the entries of the object
. store at #R$D432 that have one of the types #N$70 to #N$73. The loop does not
. move on from the first entry, though, so the first entry is tested #N$12 times
. and the timer is #N$50 if it has one of the types and #N$08 if it does not.
  $CC31,$03 Start at the first entry of the object store.
  $CC34,$03 Set the size of an entry (which is not used).
  $CC37,$03 Set the number of entries in #REGb, which is #N$12, and the starting
. count in #REGc, which is #N$02.
@ $CC3A label=SetCreatureTimer_Loop
  $CC3A,$01 Fetch the type of the object.
  $CC3B,$02,b$01 Keep the type without its lowest two bits.
  $CC3D,$04 Jump to #R$CC42 unless it is one of the types #N$70 to #N$73.
  $CC41,$01 Add one to the count.
@ $CC42 label=SetCreatureTimer_Next
  $CC42,$02 Count down the entries and jump to #R$CC3A until all are tested.
  $CC44,$01 Fetch the count.
  $CC45,$02 Multiply it by four.
  $CC47,$03 Set the timer.
  $CC4A,$01 Return.

c $CC4B Run Homing Creature
@ $CC4B label=RunHomingCreature
D $CC4B The handler of the object types #N$30, #N$A0 and #N$A4, which are
. creatures that chase the player. Each frame the creature speeds up a little
. towards the player along each axis, bounces off anything that it hits along x
. or y, and moves.
D $CC4B The speeds that the creature works out are kept in the stored speeds at
. #N$14 to #N$16 of its record in sixteenths, which gives it finer control than
. the whole numbers that #R$B979 uses. The speeds that are used for moving it,
. in #N$09 to #N$0B, are the stored speeds rounded to whole numbers, which can
. be from #N$FC to #N$04.
D $CC4B The lowest two bits of the type of the creature are the number of the
. picture of it, and are changed each frame to make it move.
R $CC4B IX Object record
  $CC4B,$03 Call #R$C775 to set the offsets of the sprite.
  $CC4E,$04 Set the half size of the creature along x to #N$0A.
  $CC52,$04 Set the half size of the creature along y to #N$0A.
  $CC56,$03 Call #R$B979 to apply gravity to the creature and move it.
  $CC59,$03 Fetch the collision flags.
  $CC5C,$02,b$01 Keep the flags for hitting something along x, along y and
. landing.
  $CC5E,$02 Jump to #R$CC6C if the creature did not hit anything.
  $CC60,$02,b$01 Keep the flag for hitting something along x.
  $CC62,$03 Call #R$CCE9 to turn the creature around along x, if it did.
  $CC65,$04 Test the flag for hitting something along y.
  $CC69,$03 Call #R$CCF2 to turn the creature around along y, if it did.
@ $CC6C label=RunHomingCreature_Steer
  $CC6C,$03 Fetch the x position of the player.
  $CC6F,$03 Subtract the x position of the creature.
  $CC72,$03 Fetch the stored speed of the creature along x.
  $CC75,$02 Jump to #R$CCBD to speed up forwards if the player is further along.
  $CC77,$03 Call #R$CD0D to speed up backwards.
@ $CC7A label=RunHomingCreature_StoreX
  $CC7A,$03 Store the speed along x.
  $CC7D,$03 Fetch the y position of the player.
  $CC80,$03 Subtract the y position of the creature.
  $CC83,$03 Fetch the stored speed of the creature along y.
  $CC86,$02 Jump to #R$CCC2 to speed up forwards if the player is further along.
  $CC88,$03 Call #R$CD0D to speed up backwards.
@ $CC8B label=RunHomingCreature_StoreY
  $CC8B,$03 Store the speed along y.
  $CC8E,$03 Fetch the z position of the body of the player.
  $CC91,$03 Subtract the z position of the creature.
  $CC94,$03 Fetch the stored speed of the creature along z.
  $CC97,$02 Jump to #R$CCC7 to speed up forwards if the player is higher.
  $CC99,$03 Call #R$CD0D to speed up backwards.
@ $CC9C label=RunHomingCreature_StoreZ
  $CC9C,$03 Store the speed along z.
  $CC9F,$02 Set a counter for the three speeds in #REGb.
@ $CCA1 label=RunHomingCreature_RoundSpeeds
  $CCA1,$02 Move #REGix on by one byte, so that the stored speed is at #N$13 and
. the speed to move at is at #N$08, for each speed in turn.
  $CCA3,$03 Fetch the stored speed.
  $CCA6,$02 Add half of the sixteen that is to be divided by, which rounds the
. result.
  $CCA8,$08 Divide it by sixteen, keeping the sign.
  $CCB0,$03 Store it as the speed to move at.
  $CCB3,$02 Jump to #R$CCA1 until the three speeds have been set.
  $CCB5,$06 Put the record pointer back.
  $CCBB,$02 Jump to #R$CCCC to change the picture of the creature.
@ $CCBD label=RunHomingCreature_ForwardsX
  $CCBD,$03 Call #R$CD04 to speed up forwards.
  $CCC0,$02 Jump to #R$CC7A to store the speed.
@ $CCC2 label=RunHomingCreature_ForwardsY
  $CCC2,$03 Call #R$CD04 to speed up forwards.
  $CCC5,$02 Jump to #R$CC8B to store the speed.
@ $CCC7 label=RunHomingCreature_ForwardsZ
  $CCC7,$03 Call #R$CD04 to speed up forwards.
  $CCCA,$02 Jump to #R$CC9C to store the speed.
@ $CCCC label=RunHomingCreature_Animate
  $CCCC,$03 Add one to the picture counter of the creature.
  $CCCF,$03 Fetch it.
  $CCD2,$02,b$01 Keep the lowest two bits.
  $CCD4,$01 Put them in #REGb.
  $CCD5,$03 Fetch the type of the creature.
  $CCD8,$02,b$01 Keep the type without its lowest two bits.
  $CCDA,$01 Add the picture number.
  $CCDB,$03 Set it as the type of the creature, which carries on with #R$CCDE.

c $CCDE Set Wipe And Draw Flags
@ $CCDE label=SetWipeAndDrawFlags
D $CCDE Flags an object as moved and in need of drawing, and flags the other
. objects that its movement affects so that they are drawn too.
E $CCDE View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C692 }
. { #ALIENEIGHT$BFAB }
. LIST#
R $CCDE IX Object record
  $CCDE,$03 Fetch the flags of the object.
  $CCE1,$02,b$01 Set bit 4 (needs drawing) and bit 5 (moved).
  $CCE3,$03 Store the flags.
  $CCE6,$03 Jump to #R$B9A7 to mark the objects that overlap it.

c $CCE9 Reverse Speed X
@ $CCE9 label=ReverseSpeedX
D $CCE9 Reverses the stored speed of a creature along x.
R $CCE9 IX Object record
  $CCE9,$03 Fetch the stored speed along x.
  $CCEC,$02 Reverse it.
  $CCEE,$03 Store it.
  $CCF1,$01 Return.

c $CCF2 Reverse Speed Y
@ $CCF2 label=ReverseSpeedY
D $CCF2 Reverses the stored speed of a creature along y.
R $CCF2 IX Object record
  $CCF2,$03 Fetch the stored speed along y.
  $CCF5,$02 Reverse it.
  $CCF7,$03 Store it.
  $CCFA,$01 Return.

c $CCFB Reverse Speed Z
@ $CCFB label=ReverseSpeedZ
D $CCFB Never used. It would reverse the stored speed of a creature along z.
R $CCFB IX Object record
  $CCFB,$03 Fetch the stored speed along z.
  $CCFE,$02 Reverse it.
  $CD00,$03 Store it.
  $CD03,$01 Return.

c $CD04 Speed Up Forwards
@ $CD04 label=SpeedUpForwards
D $CD04 Adds three to a stored speed of a creature, up to a limit of #N$38
. (which is three and a half in sixteenths).
R $CD04 A Stored speed
R $CD04 O:A New stored speed
  $CD04,$02 Add three to the speed.
  $CD06,$01 Return if it is negative.
  $CD07,$03 Return if it is less than the limit.
  $CD0A,$02 Set the speed to the limit.
  $CD0C,$01 Return.

c $CD0D Speed Up Backwards
@ $CD0D label=SpeedUpBackwards
D $CD0D Takes three off a stored speed of a creature, down to a limit of #N$B8
. (which is four and a half in sixteenths, backwards).
R $CD0D A Stored speed
R $CD0D O:A New stored speed
  $CD0D,$02 Take three off the speed.
  $CD0F,$01 Return if it is positive.
  $CD10,$03 Return if it is not less than the limit.
  $CD13,$02 Set the speed to the limit.
  $CD15,$01 Return.

c $CD16 Run Pentagram Stone
@ $CD16 label=RunPentagramStone
D $CD16 The handler of the object types #N$90 to #N$94, which are the five
. stones that have to be put on the pentagram. A stone can be picked up and
. dropped by the player, and falls like any other object, which is done by
. #R$CD84.
D $CD16 In the room of the pentagram (room #N$52), once it has been revealed by
. #R$D13A, a stone moves by itself instead. It is steered along x and y to the
. place that it has on the pentagram, which is one of the five pairs of
. positions at #R$D562, with one for each of the stones, and it is not affected
. by gravity. When it gets there, it changes into the type that is #N$08 higher,
. which is a stone that is alight, and one is added to the count of stones in
. place. The game is won when the fifth is in place.
R $CD16 IX Object record
  $CD16,$03 Call #R$C75F to set the offsets of the sprite.
  $CD19,$03 Fetch the room that the player is in.
  $CD1C,$05 Jump to #R$CD84 if it is not room #N$52, to be moved by gravity.
  $CD21,$03 Fetch the flag for the pentagram having been revealed.
  $CD24,$04 Jump to #R$CD84 if it has not been, to be moved by gravity.
  $CD28,$03 Fetch the type of the stone.
  $CD2B,$02,b$01 Keep the type without its highest five bits, which makes the
. number of the stone.
  $CD2D,$01 Double it, to make the offset of its place on the pentagram.
  $CD2E,$03 Put the offset in #REGhl.
  $CD31,$03 Take the table of the places, #R$D562.
  $CD34,$01 Add the offset to the table.
  $CD35,$04 Fetch the x position of the place and store it in the record of the
. stone.
  $CD39,$01 Move on to the y position.
  $CD3A,$04 Fetch the y position of the place and store it in the record of the
. stone.
  $CD3E,$03 Call #R$D085 to set the speeds along x and y towards the place.
  $CD41,$03 Call #R$B97C to move the stone, without gravity.
  $CD44,$06 Fetch the x position of the stone and take off that of the place.
  $CD4A,$01 Put the result in #REGc.
  $CD4B,$06 Fetch the y position of the stone and take off that of the place.
  $CD51,$04 Combine the differences, and jump to #R$CD87 if the stone is not
. there yet.
  $CD55,$06 Set the new type, which is #N$08 more than the old, in #REGc.
  $CD5B,$03 Fetch the old type of the stone.
  $CD5E,$03 Call #R$CF9E to change the type of the stone, and that of its entry
. in the object store.
  $CD61,$07 Add one to the count of stones that are in place.
  $CD68,$05 Jump to #R$C302 to show the victory screen if there are five.
  $CD6D,$03 Jump to #R$CD87 to finish.

c $CD70 Run Harmful Falling Object
@ $CD70 label=RunHarmfulFallingObject
D $CD70 The handler of the object type #N$1C, which is an object that harms the
. player and falls, carries on as #R$CD81.
R $CD70 IX Object record
  $CD70,$03 Call #R$C291 to make the object harm the player.
  $CD73,$02 Jump to #R$CD81 to move it.

c $CD75 Run Block
@ $CD75 label=RunBlock
D $CD75 The handler of the object type #N$5B, which is a block that falls but
. cannot be pushed along x or y. It is also treated like the player when it
. lands on something, see #R$B890. It carries on as #R$CD7C.
E $CD75 Continue on to #R$CD7C.
R $CD75 IX Object record
  $CD75,$07 Set the speeds along x and y to zero.

c $CD7C Run Table
@ $CD7C label=RunTable
D $CD7C The handler of the object type #N$49, which is an object that falls and
. can be pushed, in the same way as #R$CD81.
R $CD7C IX Object record
  $CD7C,$03 Call #R$C769 to set the offsets of the sprite.
  $CD7F,$02 Jump to #R$CD84 to move it.

c $CD81 Run Falling Object
@ $CD81 label=RunFallingObject
D $CD81 The handler of the object types #N$3F, #N$48 and #N$4F, which are
. objects that fall and can be pushed by the player or by the objects that move.
R $CD81 IX Object record
  $CD81,$03 Call #R$C75F to set the offsets of the sprite.
@ $CD84 label=RunFallingObject_MoveFallingObject
  $CD84,$03 Call #R$B979 to apply gravity to the object and move it.

c $CD87 Finish Object Move
@ $CD87 label=FinishObjectMove
D $CD87 Finishes the handler of an object that moves only by being pushed. The
. speeds of the object were set by whatever pushed it, so they are cleared for
. the next frame. If the object has moved, it is flagged to be drawn.
R $CD87 IX Object record
  $CD87,$09 Fetch the speeds of the object together.
  $CD90,$01 Return if there are none.
  $CD91,$0C Set the speeds along x, y and z to zero.
  $CD9D,$03 Jump to #R$CCDE to flag the object as moved.

c $CDA0 Run Sinking Block
@ $CDA0 label=RunSinkingBlock
D $CDA0 The handler of the object type #N$4E, which is a block that sinks while
. something is standing on it. It does not move at all unless something pushes
. it down, which gives it a speed along z, and then it goes down by one for each
. frame.
R $CDA0 IX Object record
  $CDA0,$03 Call #R$C75F to set the offsets of the sprite.
  $CDA3,$04 Set the speed along x to zero.
  $CDA7,$04 Set the speed along y to zero.
  $CDAB,$03 Fetch the speed along z.
  $CDAE,$03 Jump to #R$CDB6 if there is none.
  $CDB1,$05 Set the speed along z to #N$FF.
@ $CDB6 label=RunSinkingBlock_Move
  $CDB6,$03 Call #R$B97C to move the block, without gravity.
  $CDB9,$02 Jump to #R$CD87 to finish.

c $CDBB Run Lift
@ $CDBB label=RunLift
D $CDBB The handler of the object type #N$54, which is a lift. When the player
. (or a block of type #N$5B) lands on it, it carries it up, to a height of
. #N$B0. When there is nothing on it any longer, it comes down again to where it
. started.
D $CDBB The state of the lift is in the handler flags: bit 0 is set while it is
. going up, bit 1 is set while it is coming down, and bit 7 is set by #R$B890
. when something lands on it. The collision flag for being stopped along z is
. used to find out if something is pushing down on it.
R $CDBB IX Object record
  $CDBB,$08 Set the speeds along x and y to zero.
  $CDC3,$03 Call #R$C75F to set the offsets of the sprite.
  $CDC6,$03 Call #R$B97C to move the lift, without gravity.
  $CDC9,$07 Set the speeds along x and y to zero.
  $CDD0,$06 Jump to #R$CDEC if the lift is moving.
N $CDD6 The lift is waiting. Start it when something that is pushing down on it
. has landed on it.
  $CDD6,$06 Jump to #R$CD87 if nothing is pushing down on the lift.
  $CDDC,$06 Jump to #R$CD87 if nothing has landed on it.
  $CDE2,$04 Clear the flag for something having landed on it.
  $CDE6,$04 Set the flag for the lift going up.
  $CDEA,$02 Jump to #R$CE16 to start it going up.
@ $CDEC label=RunLift_Moving
N $CDEC The lift is moving. If nothing is pushing down on it, it comes down.
  $CDEC,$06 Jump to #R$CDFD if it is being pushed down.
  $CDF2,$04 Set the flag for the lift coming down.
  $CDF6,$04 Set the speed along z of the lift to #N$FF.
  $CDFA,$03 Jump to #R$CCDE to flag the lift as moved.
@ $CDFD label=RunLift_Pushed
  $CDFD,$06 Jump to #R$CE2A if the lift is coming down, which means that it has
. landed.
  $CE03,$07 Jump to #R$CE16 to keep going up if the lift is not at the top,
. which is #N$B0.
  $CE0A,$04 Put the lift at the top.
  $CE0E,$05 Set the speed along z of the player to #N$FE, to hold it down on the
. lift.
  $CE13,$03 Jump to #R$CCDE to flag the lift as moved.
@ $CE16 label=RunLift_Rise
  $CE16,$04 Set the speed along z of the lift to #N$02.
  $CE1A,$05 Set the speed along z of the player to #N$03, to take it up with the
. lift.
  $CE1F,$03 Fetch the collision flags of the player.
  $CE22,$02,b$01 Set the flag for being on the ground, so that the player can
. jump from the lift.
  $CE24,$03 Write the collision flags of the player back.
  $CE27,$03 Jump to #R$CCDE to flag the lift as moved.
@ $CE2A label=RunLift_Landed
  $CE2A,$04 Set the state of the lift to waiting.
  $CE2E,$03 Jump to #R$CD87 to finish.

c $CE31 Run Bobbing Block
@ $CE31 label=RunBobbingBlock
D $CE31 The handler of the object type #N$55, which no room uses. The block
. falls until it lands, and then it rises until it is at a height of #N$B0, and
. falls again. It rises faster while something is standing on it. Flag bit 2 of
. the hit flags is used for the state: it is set while the block is rising.
R $CE31 IX Object record
  $CE31,$03 Call #R$C75F to set the offsets of the sprite.
  $CE34,$07 Set the speeds along x and y to zero.
N $CE3B Fall until the block lands, then start rising.
  $CE3B,$06 Jump to #R$CE5F if the block is rising.
  $CE41,$03 Set the speed along z to zero.
  $CE44,$03 Call #R$B979 to apply gravity to the block and move it.
  $CE47,$06 Jump to #R$CE55 if the block has not landed.
  $CE4D,$04 Flag the block as rising.
  $CE51,$04 Set the speed along z to #N$02.
@ $CE55 label=RunBobbingBlock_Finish
  $CE55,$07 Set the speeds along x and y to zero.
  $CE5C,$03 Jump to #R$CCDE to flag the block as moved.
N $CE5F Rise towards #N$B0, faster if something is standing on the block.
@ $CE5F label=RunBobbingBlock_Rising
  $CE5F,$03 Fetch the collision flags of the player.
  $CE62,$02,b$01 Keep the flag for the player jumping.
  $CE64,$02 Jump to #R$CE6A if the player is not jumping.
  $CE66,$04 Clear the flag for something having landed on the block.
@ $CE6A label=RunBobbingBlock_Speed
  $CE6A,$03 Fetch the speed along z.
  $CE6D,$01 Test it.
  $CE6E,$06 Jump to #R$CE77 if something has landed on the block.
  $CE74,$03 Jump to #R$CE91 if the block has no speed along z.
@ $CE77 label=RunBobbingBlock_Rise
  $CE77,$02 Set the speed along z to one.
  $CE79,$03 Keep it at one if the block is rising and nothing has landed on it.
  $CE7C,$02 Otherwise make it three.
@ $CE7E label=RunBobbingBlock_Move
  $CE7E,$03 Set the speed along z of the block.
  $CE81,$03 Call #R$B97C to move the block, without gravity.
  $CE84,$07 Jump to #R$CE55 if the block is lower than #N$B0.
  $CE8B,$04 Flag the block as not rising.
  $CE8F,$02 Jump to #R$CE55 to finish.
@ $CE91 label=RunBobbingBlock_Fall
  $CE91,$03 Call #R$B979 to apply gravity to the block and move it.
  $CE94,$04 Flag the block as not rising.
  $CE98,$02 Jump to #R$CE55 to finish.

c $CE9A Run Harmful Bobbing Block
@ $CE9A label=RunHarmfulBobbingBlock
D $CE9A The handler of the object type #N$56, which is a creature that bobs up
. and down, in the same way as #R$CE31 does for a block. It harms the player.
R $CE9A IX Object record
  $CE9A,$03 Call #R$C291 to make the creature harm the player.
  $CE9D,$03 Jump to #R$CE31 to move it.

c $CEA0 Run Harmful Slider X
@ $CEA0 label=RunHarmfulSliderX
D $CEA0 The handler of the object type #N$5C, which is a creature that goes
. backwards and forwards along x, in the same way as #R$CEA3, and harms the
. player.
R $CEA0 IX Object record
  $CEA0,$03 Call #R$C291 to make the creature harm the player.

c $CEA3 Run Slider X
@ $CEA3 label=RunSliderX
D $CEA3 The handler of the object type #N$57, which is a block that goes
. backwards and forwards along x. It moves #N$02 for each frame, carrying
. anything that stands on it, and turns around when it is stopped. Bit 0 of the
. number at #N$10 of its record is the direction that it is going in.
R $CEA3 IX Object record
  $CEA3,$03 Call #R$C75F to set the offsets of the sprite.
  $CEA6,$07 Set the speeds along y and z to zero.
N $CEAD Go towards the end of the run, or turn around if the block is
. stopped.
  $CEAD,$06 Jump to #R$CEC7 if the block is going to the start.
  $CEB3,$04 Set the speed along x to #N$02.
  $CEB7,$03 Call #R$B97C to move the block, without gravity.
  $CEBA,$06 Jump to #R$CEC4 if the block was not stopped along x.
  $CEC0,$04 Make the block go to the start.
@ $CEC4 label=RunSliderX_Finish
  $CEC4,$03 Jump to #R$CCDE to flag the block as moved.
N $CEC7 Go towards the start of the run.
@ $CEC7 label=RunSliderX_Start
  $CEC7,$04 Set the speed along x to #N$FE.
  $CECB,$03 Call #R$B97C to move the block, without gravity.
  $CECE,$06 Jump to #R$CEC4 if the block was not stopped along x.
  $CED4,$04 Make the block go to the end.
  $CED8,$02 Jump to #R$CEC4 to finish.

c $CEDA Run Harmful Slider Y
@ $CEDA label=RunHarmfulSliderY
D $CEDA The handler of the object type #N$5D, which is a creature that goes
. backwards and forwards along y, in the same way as #R$CEDD, and harms the
. player.
R $CEDA IX Object record
  $CEDA,$03 Call #R$C291 to make the creature harm the player.

c $CEDD Run Slider Y
@ $CEDD label=RunSliderY
D $CEDD The handler of the object type #N$58, which is a block that goes
. backwards and forwards along y, in the same way as #R$CEA3 does along x.
R $CEDD IX Object record
  $CEDD,$03 Call #R$C75F to set the offsets of the sprite.
  $CEE0,$07 Set the speeds along x and z to zero.
N $CEE7 Go towards the end of the run, or turn around if the block is
. stopped.
  $CEE7,$06 Jump to #R$CF01 if the block is going to the start.
  $CEED,$04 Set the speed along y to #N$02.
  $CEF1,$03 Call #R$B97C to move the block, without gravity.
  $CEF4,$06 Jump to #R$CEFE if the block was not stopped along y.
  $CEFA,$04 Make the block go to the start.
@ $CEFE label=RunSliderY_Finish
  $CEFE,$03 Jump to #R$CCDE to flag the block as moved.
N $CF01 Go towards the start of the run.
@ $CF01 label=RunSliderY_Start
  $CF01,$04 Set the speed along y to #N$FE.
  $CF05,$03 Call #R$B97C to move the block, without gravity.
  $CF08,$06 Jump to #R$CEFE if the block was not stopped along y.
  $CF0E,$04 Make the block go to the end.
  $CF12,$02 Jump to #R$CEFE to finish.

c $CF14 Run Static Object
@ $CF14 label=RunStaticObject
D $CF14 The handler of the object types #N$79 to #N$87, which include the eight
. parts of the pentagram. They do not move, unless they can be pushed and
. something pushes them.
R $CF14 IX Object record
  $CF14,$03 Call #R$C75F to set the offsets of the sprite.
  $CF17,$03 Call #R$B97C to move the object, without gravity.
  $CF1A,$05 Return if the object cannot be pushed.
  $CF1F,$03 Jump to #R$CD87 to finish.

c $CF22 Run Wandering Spark
@ $CF22 label=RunWanderingSpark
D $CF22 The handler of the object type #N$59, which is a spark that harms the
. player. It falls to the floor, and then moves about at random, in a new
. direction along x and y each time that it is stopped. The sprite of it is
. turned over every other frame.
R $CF22 IX Object record
  $CF22,$03 Call #R$C75F to set the offsets of the sprite.
  $CF25,$03 Call #R$C291 to make the spark harm the player.
  $CF28,$04 Set the speed along z to zero.
  $CF2C,$03 Call #R$B979 to apply gravity to the spark and move it.
  $CF2F,$04 Set the sprite to be the right way round.
  $CF33,$03 Fetch the frame counter.
  $CF36,$02,b$01 Keep bit 0.
  $CF38,$02 Jump to #R$CF3E if it is an even frame.
  $CF3A,$04 Turn the sprite over.
@ $CF3E label=RunWanderingSpark_Test
  $CF3E,$06 Jump to #R$CF52 if the spark was stopped along x.
  $CF44,$06 Jump to #R$CF52 if the spark was stopped along y.
  $CF4A,$08 Jump to #R$CF65 if the spark is moving.
@ $CF52 label=RunWanderingSpark_Turn
  $CF52,$03 Fetch the random seed.
  $CF55,$02,b$01 Keep bit 3.
  $CF57,$02 Make it #N$FC or #N$04.
  $CF59,$03 Set it as the speed along x.
  $CF5C,$02 Fetch a random number from the refresh register.
  $CF5E,$02,b$01 Keep bit 3.
  $CF60,$02 Make it #N$FC or #N$04.
  $CF62,$03 Set it as the speed along y.
@ $CF65 label=RunWanderingSpark_Finish
  $CF65,$03 Jump to #R$CCDE to flag the spark as moved.

c $CF68 Run Collectable Object
@ $CF68 label=RunCollectableObject
D $CF68 The handler of the object types #N$70 to #N$77, which are the four
. objects that are the aim of the quest, and the same four once they have been
. collected. An object is collected by the helper, #R$D0AC, which sets bit 0 of
. the handler flags at #N$16.
D $CF68 When that has happened, the player is given an extra life, and the
. object changes to the type that is #N$04 higher, in the object store as well.
. When all four have been collected, #R$D13A reveals the pentagram.
R $CF68 IX Object record
  $CF68,$03 Call #R$C75F to set the offsets of the sprite.
  $CF6B,$03 Call #R$B97C to move the object, without gravity.
  $CF6E,$05 Return if the object has not been collected.
  $CF73,$07 Add one to the count of objects collected.
  $CF7A,$07 Add one to the number of lives.
  $CF81,$02 Save #REGix.
  $CF83,$03 Call #R$C29A to draw the lives.
  $CF86,$02 Get #REGix back.
  $CF88,$04 Clear the flag for the object having been collected.
  $CF8C,$06 Set the new type, which is #N$04 more than the old, in #REGc.
  $CF92,$03 Fetch the old type of the object.
  $CF95,$03 Call #R$CF9E to change the type of the object, and that of its entry
. in the object store.
  $CF98,$03 Call #R$D13A to find out if all of the objects have been collected.
  $CF9B,$03 Jump to #R$CCDE to flag the object as moved.

c $CF9E Change Object Type
@ $CF9E label=ChangeObjectType
D $CF9E Changes the type of an object, and the type of the entry for it in the
. object store, which is the first entry that has the old type.
R $CF9E A Old type
R $CF9E C New type
R $CF9E IX Object record
  $CF9E,$03 Call #R$D07B to point #REGiy at the first entry of the object store.
@ $CFA1 label=ChangeObjectType_Loop
  $CFA1,$05 Jump to #R$CFAB if the entry has the old type.
  $CFA6,$02 Move on to the next entry.
  $CFA8,$02 Jump to #R$CFA1 until all of the entries have been tested.
  $CFAA,$01 Return.
@ $CFAB label=ChangeObjectType_Found
  $CFAB,$03 Set the new type of the entry.
  $CFAE,$03 Set the new type of the object.
  $CFB1,$01 Return.

c $CFB2 Test Projectile Hit
@ $CFB2 label=TestProjectileHit
D $CFB2 Tests if either of the two projectiles of the player touches an object.
R $CFB2 IX Record of the object
R $CFB2 O:F Zero flag set if a projectile touches the object
  $CFB2,$02 Set the result to #N$01, as nothing has been hit.
  $CFB4,$04 Start with the first of the projectiles, #R$A7AF.
  $CFB8,$03 Fetch the type of the projectile.
  $CFBB,$02,b$01 Keep only the bits of the type that tell the kinds of object
. apart.
  $CFBD,$03 Call #R$C21E to test it, as long as there is a projectile.
  $CFC0,$01 Fetch the result.
  $CFC1,$02 Return if the projectile touches the object.
  $CFC3,$04 Move on to the second of the projectiles, #R$A7CF.
  $CFC7,$03 Fetch the type of the projectile.
  $CFCA,$02,b$01 Keep only the bits of the type that tell the kinds of object
. apart.
  $CFCC,$03 Call #R$C216 to test it.
  $CFCF,$01 Fetch the result.
  $CFD0,$01 Test it.
  $CFD1,$01 Return.

c $CFD2 Run Helper Source
@ $CFD2 label=RunHelperSource
D $CFD2 The handler of the object type #N$78, which makes a helper (the object
. type #N$5A, run by #R$D0AC) when it has been hit by enough of the projectiles
. of the player. Nothing happens while there is a helper in the game already.
. Otherwise, a count at #N$14 of its record goes up by one for each frame that a
. projectile is touching it, and the helper is made when the count gets to
. #N$20.
D $CFD2 The helper is made by copying the record of this object into a free
. object slot, and changing it. It starts in front of the object, rising. The
. type and room of the helper are also written to the last entry of the object
. store, #R$D542, so that it is remembered when the player leaves the room.
R $CFD2 IX Object record
  $CFD2,$03 Call #R$C75F to set the offsets of the sprite.
  $CFD5,$03 Call #R$B97C to move the object, without gravity.
  $CFD8,$03 Fetch the helper flag.
  $CFDB,$02 Return if there is a helper already.
  $CFDD,$03 Call #R$CFB2 to find out if a projectile touches the object.
  $CFE0,$01 Return if none does.
  $CFE1,$03 Add one to the count of frames in which a projectile has touched the
. object.
  $CFE4,$06 Return if the count is less than #N$20.
  $CFEA,$04 Set the count back to zero.
  $CFEE,$03 Call #R$D071 to point #REGiy at the first ordinary object.
  $CFF1,$02 Set the type to look for to that of the helper.
@ $CFF3 label=RunHelperSource_Test
  $CFF3,$04 Return if the object is a helper.
  $CFF7,$04 Move on to the next object, and jump to #R$CFF3 until all have been
. tested.
  $CFFB,$03 Call #R$D071 to point #REGiy at the first ordinary object again.
  $CFFE,$01 Set the type to look for to zero, which is a free object.
@ $CFFF label=RunHelperSource_Free
  $CFFF,$05 Jump to #R$D009 if the object is free.
  $D004,$04 Move on to the next object, and jump to #R$CFFF until all have been
. tested.
  $D008,$01 Return, as there is no room for a helper.
@ $D009 label=RunHelperSource_Make
  $D009,$03 Take this object.
  $D00C,$03 Take the free object.
  $D00F,$03 Set the number of bytes to copy, which is the size of an object.
  $D012,$02 Copy this object into the free object.
  $D014,$04 Set the type of the new object to #N$5A.
  $D018,$04 Set the z position of the helper.
  $D01C,$02 Set #REGa to #N$08, for the half sizes along x and y.
  $D01E,$03 Set the half size along x.
  $D021,$03 Set the half size along y.
  $D024,$04 Set the size along z.
  $D028,$04 Set the flags, which are for an object that can be pushed.
  $D02C,$04 Set the speed along z to #N$01, which makes the helper rise.
  $D030,$03 Take the entry of the object store for the helper, #R$D542.
  $D033,$03 Write the low byte of the address as the pointer to the store.
  $D036,$03 Write the high byte.
  $D039,$06 Put the x position of the helper at that of this object.
  $D03F,$08 Put the y position of the helper #N$08 further along than that of
. this object.
  $D047,$05 Set the helper flag.
  $D04C,$06 Save the object and make #REGix the helper.
  $D052,$03 Call #R$C75F to set the offsets of the sprite.
  $D055,$03 Call #R$B2C5 to work out where it is on the screen.
  $D058,$03 Call #R$B979 to apply gravity to it and move it.
  $D05B,$03 Call #R$CCDE to flag it as moved.
  $D05E,$02 Get the object back.
  $D060,$04 Take the entry of the object store for the helper.
  $D064,$04 Set the type of the entry.
  $D068,$06 Set the room of the entry to the room of the object.
  $D06E,$03 Jump to #R$CCDE to flag the object as moved.

c $D071 Point At Objects
@ $D071 label=PointAtObjects
D $D071 Sets up the registers to go through the ordinary objects, which are the
. ones from the seventh to the last.
R $D071 O:B Number of objects
R $D071 O:DE Size of an object
R $D071 O:IY Address of the first object
  $D071,$03 Set the size of an object.
  $D074,$04 Start with the first ordinary object, #R$A82F.
  $D078,$02 Set the number of objects, which is #N$30.
  $D07A,$01 Return.

c $D07B Point At Store
@ $D07B label=PointAtStore
D $D07B Sets up the registers to go through the entries of the object store.
R $D07B O:B Number of entries
R $D07B O:DE Size of an entry
R $D07B O:IY Address of the first entry
  $D07B,$03 Set the size of an entry.
  $D07E,$04 Start with the first entry, #R$D432.
  $D082,$02 Set the number of entries, which is #N$12.
  $D084,$01 Return.

c $D085 Steer Towards Target
@ $D085 label=SteerTowardsTarget
D $D085 Sets the speeds of an object along x and y to one in the direction that
. takes it towards a target, or to nothing if it is already in line with the
. target on an axis. The target is held at #N$15 and #N$16 of the record.
R $D085 IX Object record
  $D085,$03 Fetch the x position of the object.
  $D088,$05 Jump to #R$D099 if it is the same as the target.
  $D08D,$02 Jump to #R$D095 if it is lower.
  $D08F,$04 Set the speed along x to #N$FF.
  $D093,$02 Jump to #R$D099.
@ $D095 label=SteerTowardsTarget_X
  $D095,$04 Set the speed along x to #N$01.
@ $D099 label=SteerTowardsTarget_Y
  $D099,$03 Fetch the y position of the object.
  $D09C,$04 Return if it is the same as the target.
  $D0A0,$02 Jump to #R$D0A7 if it is lower.
  $D0A2,$04 Set the speed along y to #N$FF.
  $D0A6,$01 Return.
@ $D0A7 label=SteerTowardsTarget_UpY
  $D0A7,$04 Set the speed along y to #N$01.
  $D0AB,$01 Return.

c $D0AC Run Helper
@ $D0AC label=RunHelper
D $D0AC The handler of the object type #N$5A, which is the helper. It can be
. picked up by the player, like the stones, and when it is not held it goes to
. an object of one of the types #N$70 to #N$73 in the room, and collects it.
D $D0AC The helper starts by falling to the floor. If there is an object of the
. right type, it takes the position of that as a target, which it keeps in its
. record. Then it rises, to a height of #N$B0, and goes towards the target in a
. straight line along x and y, as #R$D085 sets its speeds. When it gets there it
. flags the object, so that #R$CF68 collects it, makes a noise and disappears in
. an explosion, and its entry in the object store is removed.
.
. #HTML(#AUDIO0(collected-tune.wav)(#INCLUDE(CollectedTune)))
R $D0AC IX Object record
  $D0AC,$03 Call #R$C75F to set the offsets of the sprite.
  $D0AF,$06 Jump to #R$D10C if the helper has no target.
  $D0B5,$03 Call #R$D085 to set the speeds towards the target.
  $D0B8,$07 Jump to #R$D0C3 if the helper is at the height of #N$B0 or more.
  $D0BF,$04 Set the speed along z to #N$01.
@ $D0C3 label=RunHelper_Move
  $D0C3,$03 Call #R$B97C to move the helper, without gravity.
  $D0C6,$09 Fetch the speeds together.
  $D0CF,$03 Jump to #R$CD87 to finish if the helper is still moving.
  $D0D2,$03 Call #R$D071 to point #REGiy at the first ordinary object.
  $D0D5,$02 Set the first type to look for.
@ $D0D7 label=RunHelper_FindObject
  $D0D7,$03 Fetch the type of the object.
  $D0DA,$02,b$01 Keep the type without its lowest two bits.
  $D0DC,$03 Jump to #R$D0E6 if it is one of the types #N$70 to #N$73.
  $D0DF,$02 Move on to the next object.
  $D0E1,$02 Jump to #R$D0D7 until all of the objects have been tested.
  $D0E3,$03 Jump to #R$CD87 to finish if there is none.
@ $D0E6 label=RunHelper_Collect
  $D0E6,$04 Flag the object as collected.
  $D0EA,$04 Clear the helper flag.
  $D0EE,$03 Take the tune for an object being collected, #R$D847.
  $D0F1,$03 Call #R$D6B5 to play it.
  $D0F4,$03 Call #R$D07B to point #REGiy at the first entry of the object store.
  $D0F7,$02 Set the type to look for, which is that of the helper.
@ $D0F9 label=RunHelper_FindEntry
  $D0F9,$05 Jump to #R$D105 if the entry is the helper.
  $D0FE,$04 Move on to the next entry, and jump to #R$D0F9 until all have been
. tested.
  $D102,$03 Jump to #R$C107 to make the helper explode.
@ $D105 label=RunHelper_RemoveEntry
  $D105,$04 Remove the helper from the object store.
  $D109,$03 Jump to #R$C107 to make the helper explode.
@ $D10C label=RunHelper_Seek
  $D10C,$04 Set the speed along z to #N$FF, to make the helper fall.
  $D110,$03 Call #R$B97C to move it, without gravity.
  $D113,$03 Call #R$D071 to point #REGiy at the first ordinary object.
  $D116,$02 Set the first type to look for.
@ $D118 label=RunHelper_SeekLoop
  $D118,$03 Fetch the type of the object.
  $D11B,$02,b$01 Keep the type without its lowest two bits.
  $D11D,$03 Jump to #R$D127 if it is one of the types #N$70 to #N$73.
  $D120,$04 Move on to the next object, and jump to #R$D118 until all have been
. tested.
  $D124,$03 Jump to #R$CD87 to finish if there is none.
@ $D127 label=RunHelper_SetTarget
  $D127,$06 Set the x position of the target to that of the object.
  $D12D,$06 Set the y position of the target to that of the object.
  $D133,$04 Flag the helper as having a target.
  $D137,$03 Jump to #R$CD87 to finish.

c $D13A Check Objects Collected
@ $D13A label=CheckObjectsCollected
D $D13A Finds out if all four of the quest objects have been collected, which is
. when there are four entries in the object store that have the types #N$74 to
. #N$77. If they have, the eight parts of the pentagram are flagged as needing
. to be drawn, and the pentagram is flagged as being revealed, so that #R$B097
. brings the parts into a room.
R $D13A IX Record of the object that was collected
  $D13A,$03 Call #R$D07B to point #REGiy at the first entry of the object store.
  $D13D,$02 Set the count of the entries to zero.
@ $D13F label=CheckObjectsCollected_Count
  $D13F,$03 Fetch the type of the entry.
  $D142,$02,b$01 Keep the type without its lowest two bits.
  $D144,$04 Jump to #R$D149 unless it is one of the types #N$74 to #N$77.
  $D148,$01 Add one to the count.
@ $D149 label=CheckObjectsCollected_Next
  $D149,$02 Move on to the next entry.
  $D14B,$02 Jump to #R$D13F until all of the entries have been tested.
  $D14D,$01 Fetch the count.
  $D14E,$03 Return unless all four have been collected.
  $D151,$03 Call #R$D07B to point #REGiy at the first entry of the object store
. again.
@ $D154 label=CheckObjectsCollected_Reveal
  $D154,$03 Fetch the type of the entry.
  $D157,$02,b$01 Keep the type without its lowest three bits.
  $D159,$04 Jump to #R$D16A unless it is one of the types #N$80 to #N$87, the
. parts of the pentagram.
  $D15D,$04 Set bit 0 of the high byte of the pointer to the store in the record
. of the object.
  $D161,$04 Flag the entry as needing to be drawn.
  $D165,$05 Set the flag for the pentagram being revealed.
@ $D16A label=CheckObjectsCollected_RevealNext
  $D16A,$02 Move on to the next entry.
  $D16C,$02 Jump to #R$D154 until all of the entries have been tested.
  $D16E,$01 Return.

c $D16F Initialise Object Store
@ $D16F label=InitialiseObjectStore
D $D16F Puts the objects of the quest into the object store at the start of a
. game. The store is copied from the table at #R$D312, in which the five stones
. are all in room #N$61. The rooms and positions of the stones are then replaced
. with five consecutive entries of the table at #R$D1A5, starting at one of the
. first sixteen, which is picked by the random seed.
  $D16F,$03 Take the object store, #R$D432.
  $D172,$03 Take the initial entries of the store, #R$D312.
  $D175,$03 Set the number of bytes to copy, which is the size of #N$12 entries.
  $D178,$02 Copy the initial entries into the store.
  $D17A,$03 Fetch the random seed.
  $D17D,$02,b$01 Keep bits 2-5, to make a multiple of four from #N$00 to #N$3C.
  $D17F,$01 Put it in #REGe.
  $D180,$02 Clear #REGd.
  $D182,$03 Take the table of rooms and positions of the stones,
. #R$D1A5.
  $D185,$01 Add the offset.
  $D186,$04 Start at the store entry of the stone of type #N$94, which is
. the first of the five, #R$D472.
  $D18A,$02 Set the number of stones.
  $D18C,$03 Set the offset from the end of the position to the start of the next
. entry.
@ $D18F label=InitialiseObjectStore_Stone
  $D18F,$01 Fetch the room from the table.
  $D190,$03 Set the room of the stone in the store.
  $D193,$02 Set the number of bytes of the position.
@ $D195 label=InitialiseObjectStore_Position
  $D195,$01 Move on to the next byte of the table.
  $D196,$02 Move on to the next byte of the entry.
  $D198,$01 Fetch the byte of the position.
  $D199,$03 Set the byte of the position of the stone in the store.
  $D19C,$02 Jump to #R$D195 until the position is set.
  $D19E,$01 Move on to the next entry of the table.
  $D19F,$02 Move on to the next entry of the store.
  $D1A1,$01 Count the stone as done.
  $D1A2,$02 Jump to #R$D18F until all of the stones are set.
  $D1A4,$01 Return.

b $D1A5 Stone Places
@ $D1A5 label=StonePlaces
D $D1A5 The rooms and positions that #R$D16F gives to the five stones, which are
. twenty entries of the room and the x, y and z positions. The first of the five
. is given to the stone of type #N$94, and the others to #N$93 down to #N$90.
B $D1A5,$50,$04

c $D1F5 Run Flickering Wanderer
@ $D1F5 label=RunFlickeringWanderer
D $D1F5 The handler of the object types #N$10 and #N$11, which are creatures
. that harm the player and wander about the room. It turns the sprite over each
. frame, to make it flicker, and carries on as #R$D1FD.
E $D1F5 Continue on to #R$D1FD.
R $D1F5 IX Object record
  $D1F5,$03 Fetch the flags of the object.
  $D1F8,$02,b$01 Turn the sprite over.
  $D1FA,$03 Store the flags.

c $D1FD Run Wanderer
@ $D1FD label=RunWanderer
D $D1FD The handler of the object types #N$50 and #N$51, which are creatures
. that harm the player and wander about the room. A creature stays just above
. the floor, and walks along one axis at a time, at a speed of four. When it has
. no speed, because something has stopped it, it picks a new direction at
. random: along x if it was stopped along y, and along y if it was not. The
. lowest bit of its type and the flag for the sprite being mirrored are set to
. show which of the four ways it is going, to give the right picture.
R $D1FD IX Object record
  $D1FD,$03 Call #R$C75F to set the offsets of the sprite.
  $D200,$03 Call #R$C291 to make the creature harm the player.
  $D203,$03 Call #R$B979 to apply gravity to the creature and move it.
  $D206,$07 Jump to #R$D215 if the creature is at least #N$81 up.
  $D20D,$04 Put the creature at a height of #N$81.
  $D211,$04 Set the speed along z to zero.
@ $D215 label=RunWanderer_Test
  $D215,$09 Jump to #R$CCDE to flag the creature as moved if it is moving.
  $D21E,$02 Fetch a random number from the refresh register.
  $D220,$02,b$01 Keep bit 3.
  $D222,$02 Make it #N$FC or #N$04.
  $D224,$06 Jump to #R$D237 if the creature was stopped along y.
  $D22A,$03 Set the speed along y.
  $D22D,$04 Set the bit of the type that goes with going forwards along y.
  $D231,$04 Clear the flag for the sprite being mirrored.
  $D235,$02 Jump to #R$D242.
@ $D237 label=RunWanderer_AlongX
  $D237,$03 Set the speed along x.
  $D23A,$04 Clear the bit of the type that goes with going forwards along x.
  $D23E,$04 Set the flag for the sprite being mirrored.
@ $D242 label=RunWanderer_Direction
  $D242,$04 Jump to #R$CCDE to flag the creature as moved when it is going
. forwards.
  $D246,$03 Fetch the type of the creature.
  $D249,$02,b$01 Turn the bit of the type around, as the creature is going
. backwards.
  $D24B,$03 Set the type.
  $D24E,$03 Jump to #R$CCDE to flag the creature as moved.

c $D251 Run Four Frame Wanderer
@ $D251 label=RunFourFrameWanderer
D $D251 The handler of the object types #N$A8 to #N$AB, which are creatures that
. harm the player and wander about the room in the same way as #R$D1FD. Bit 0 of
. the type is turned around each frame, to make the creature walk, and bit 1 is
. used to show which way it is going.
R $D251 IX Object record
  $D251,$03 Call #R$C75F to set the offsets of the sprite.
  $D254,$03 Call #R$C291 to make the creature harm the player.
  $D257,$03 Call #R$B979 to apply gravity to the creature and move it.
  $D25A,$03 Fetch the type of the creature.
  $D25D,$02,b$01 Turn bit 0 around.
  $D25F,$03 Set the type.
  $D262,$07 Jump to #R$D271 if the creature is at least #N$81 up.
  $D269,$04 Put the creature at a height of #N$81.
  $D26D,$04 Set the speed along z to zero.
@ $D271 label=RunFourFrameWanderer_Test
  $D271,$09 Jump to #R$CCDE to flag the creature as moved if it is moving.
  $D27A,$02 Fetch a random number from the refresh register.
  $D27C,$02,b$01 Keep bit 3.
  $D27E,$02 Make it #N$FC or #N$04.
  $D280,$06 Jump to #R$D293 if the creature was stopped along y.
  $D286,$03 Set the speed along y.
  $D289,$04 Set the bit of the type that goes with going forwards along y.
  $D28D,$04 Clear the flag for the sprite being mirrored.
  $D291,$02 Jump to #R$D29E.
@ $D293 label=RunFourFrameWanderer_AlongX
  $D293,$03 Set the speed along x.
  $D296,$04 Clear the bit of the type that goes with going forwards along x.
  $D29A,$04 Set the flag for the sprite being mirrored.
@ $D29E label=RunFourFrameWanderer_Direction
  $D29E,$04 Jump to #R$CCDE to flag the creature as moved when it is going
. forwards.
  $D2A2,$03 Fetch the type of the creature.
  $D2A5,$02,b$01 Turn bit 1 of the type around, as the creature is going
. backwards.
  $D2A7,$03 Set the type.
  $D2AA,$03 Jump to #R$CCDE to flag the creature as moved.

c $D2AD Run Crumbling Block
@ $D2AD label=RunCrumblingBlock
D $D2AD The handler of the object types #N$88 to #N$8B, which are the stages of
. a block that crumbles away. Each time that the player or a block of type #N$5B
. lands on it, it changes to the next type, which has the next sprite, and after
. the last it is erased.
R $D2AD IX Object record
  $D2AD,$03 Call #R$C75F to set the offsets of the sprite.
  $D2B0,$04 Set the speed along z to zero.
  $D2B4,$03 Call #R$B97C to move the block, without gravity.
  $D2B7,$05 Return if nothing has landed on the block.
  $D2BC,$04 Clear the flag for something having landed on the block.
  $D2C0,$05 Return if there is nothing on the block.
  $D2C5,$04 Clear the flag for something being on the block.
  $D2C9,$03 Fetch the type of the block.
  $D2CC,$04 Jump to #R$D2D7 if it is the last of the types.
  $D2D0,$01 Move on to the next type.
  $D2D1,$03 Set the type.
  $D2D4,$03 Jump to #R$CCDE to flag the block as moved.
@ $D2D7 label=RunCrumblingBlock_Erase
  $D2D7,$04 Change the block to the type #N$01, which makes #R$B3D3 erase it.
  $D2DB,$03 Jump to #R$CCDE to flag the block as moved.

c $D2DE Run Conveyor Block Plus X
@ $D2DE label=RunConveyorBlockPlusX
D $D2DE The handler of the object type #N$8C, which is a block that pushes
. whatever stands on it along x, using the table at #R$D30A, see #R$B866. All
. that this handler does is to clear the flag for something being on the block,
. which lets the next thing that lands on it push it again.
R $D2DE IX Object record
  $D2DE,$03 Call #R$C75F to set the offsets of the sprite.
  $D2E1,$04 Clear the flag for something being on the block.
  $D2E5,$03 Call #R$B97C to move the block, without gravity.
  $D2E8,$01 Return.

c $D2E9 Run Conveyor Block Minus X
@ $D2E9 label=RunConveyorBlockMinusX
D $D2E9 The handler of the object type #N$8D, which is a block that pushes
. whatever stands on it back along x, in the same way as #R$D2DE.
R $D2E9 IX Object record
  $D2E9,$03 Call #R$C75F to set the offsets of the sprite.
  $D2EC,$04 Clear the flag for something being on the block.
  $D2F0,$03 Call #R$B97C to move the block, without gravity.
  $D2F3,$01 Return.

c $D2F4 Run Conveyor Block Plus Y
@ $D2F4 label=RunConveyorBlockPlusY
D $D2F4 The handler of the object type #N$8E, which is a block that pushes
. whatever stands on it along y, in the same way as #R$D2DE.
R $D2F4 IX Object record
  $D2F4,$03 Call #R$C75F to set the offsets of the sprite.
  $D2F7,$04 Clear the flag for something being on the block.
  $D2FB,$03 Call #R$B97C to move the block, without gravity.
  $D2FE,$01 Return.

c $D2FF Run Conveyor Block Minus Y
@ $D2FF label=RunConveyorBlockMinusY
D $D2FF The handler of the object type #N$8F, which is a block that pushes
. whatever stands on it back along y, in the same way as #R$D2DE.
R $D2FF IX Object record
  $D2FF,$03 Call #R$C75F to set the offsets of the sprite.
  $D302,$04 Clear the flag for something being on the block.
  $D306,$03 Call #R$B97C to move the block, without gravity.
  $D309,$01 Return.

b $D30A Conveyor Pushes
@ $D30A label=ConveyorPushes
D $D30A The pairs of speeds, along x and then along y, that #R$B866 gives to
. something on a block of the types #N$8C to #N$8F, which is a block that
. pushes. The type of the block gives the pair, in the same order.
B $D30A,$08,$02

b $D312 Initial Object Store
@ $D312 label=InitialObjectStore
D $D312 The entries of the object store at the start of a game, which #R$D16F
. copies to #R$D432. An entry is the first sixteen bytes of the record of an
. object: the type, the position, the sizes, the flags and the room. The rooms
. and positions of the stones are set by #R$D16F, and the arcs have no flag to
. be drawn until #R$D13A sets it.
B $D312,$40,$10 The four objects to collect, types #N$70 to #N$73.
B $D352,$50,$10 The five stones, types #N$94 to #N$90.
B $D3A2,$80,$10 The pentagram arcs, types #N$80 to #N$87.
@ $D422 label=InitialObjectStore_Helper
B $D422,$10,$10 The entry for the helper, which is empty until a helper is made.

g $D432 Object Store
@ $D432 label=ObjectStore
D $D432 The objects of the quest as the game changes them, in #N$12 entries of
. #N$10 bytes. #R$B097 takes the objects of a room from here when the room is
. built, and #R$B115 puts them back when the player leaves it. The last entry is
. the one for the helper, at #R$D542.
B $D432,$40,$10 The four objects to collect.
@ $D472 label=ObjectStore_Stones
B $D472,$50,$10 The five stones.
B $D4C2,$80,$10 The pentagram arcs.
@ $D542 label=ObjectStore_Helper
B $D542,$10,$10 The helper.

b $D552 Unused
D $D552 Never used. It would be a nineteenth entry of the object store.
B $D552,$10,$10

b $D562 Stone Places
@ $D562 label=StonePlacesOnPentagram
D $D562 The positions that the stones move to on the pentagram, which are the x
. position and then the y position of each of the five, in the order of their
. types, #N$90 to #N$94. See #R$CD16.
B $D562,$0A,$02

c $D56C Play Moving Sound
@ $D56C label=PlayMovingSound
D $D56C Never used. Makes a short tone of a pitch from the table at #R$D587,
. which is picked by the frame counter, for an object that has been moved, as
. shown by the flag for it being moved.
E $D56C View the equivalent code in;
. #LIST
. { #NIGHTSHADE$C332 }
. LIST#
.
. #HTML(#AUDIO0(moving-sound.wav)(#INCLUDE(MovingSound)))
R $D56C IX Object record
  $D56C,$03 Take the table of pitches, #R$D587.
  $D56F,$04 Test the flag for the object being moved.
  $D573,$04 Clear the flag.
  $D577,$01 Return if it was not set.
  $D578,$03 Fetch the frame counter.
  $D57B,$02,b$01 Keep the lowest four bits.
  $D57D,$03 Put that in #REGhl.
  $D580,$01 Add the table to it.
  $D581,$01 Fetch the pitch.
  $D582,$02 Set the length of the tone.
  $D584,$03 Jump to #R$D67B to make the tone.

b $D587 Moving Sound Pitches
@ $D587 label=MovingSoundPitches
D $D587 Never used. The pitches that #R$D56C picks from. Only the first #N$10
. are in reach, and the rest are runs of steps that rise and fall.
B $D587,$10,$05
B $D597,$40,$10

c $D5D7 Play Click
@ $D5D7 label=PlayClick
D $D5D7 Makes a click, which is a tone that gets a little lower each time that
. it is made, as it is a step on from the count at #R$A749 which is also used by
. #R$D5F2.
E $D5D7 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$C39D }
. LIST#
.
. #HTML(#AUDIO0(pause-sound.wav)(#INCLUDE(PauseSound)))
  $D5D7,$03 Take the counter of the sound effect, #R$A749.
  $D5DA,$01 Add one to it.
  $D5DB,$01 Fetch it.
  $D5DC,$02 Add #N$40 to make the pitch.
  $D5DE,$01 Put the pitch in #REGb.
  $D5DF,$02 Set the length of the tone.
  $D5E1,$03 Jump to #R$D67B to make the tone.

c $D5E4 Play Jump Sound
@ $D5E4 label=PlayJumpSound
D $D5E4 Makes the rattling noise of a jump, from sixteen single cycles of a tone
. whose pitch jumps about.
E $D5E4 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$AF22 }
. { #MARTIANOIDS$C04E }
. { #NIGHTSHADE$C3AA }
. { #SABREWULF$BF2F }
. LIST#
.
. #HTML(#AUDIO0(jump-sound.wav)(#INCLUDE(JumpSound)))
  $D5E4,$02 Set the number of cycles to #N$10.
@ $D5E6 label=PlayJumpSound_Loop
  $D5E6,$01 Fetch the number of cycles left.
  $D5E7,$02,b$01 Scramble it.
  $D5E9,$01 Add the number of cycles left again, to make the pitch.
  $D5EA,$01 Put the pitch in #REGb.
  $D5EB,$03 Call #R$D682 to make a cycle of the tone.
  $D5EE,$01 Count the cycle.
  $D5EF,$02 Jump back to #R$D5E6 until all of the cycles have been made.
  $D5F1,$01 Return.

c $D5F2 Play Sound Effect
@ $D5F2 label=PlaySoundEffect
D $D5F2 Plays one note of the sound effect that is in progress, which is called
. once each frame. #R$A749 is the number of notes left, and #R$A74A picks the
. sequence of pitches from the table at #R$D60D. The notes are played from the
. last of the sequence to the first. There is only a sound effect for entering a
. room, with a sequence of four notes, and one for the player picking up or
. dropping an object, with five. The sequences that the table has for the
. numbers #N$02 and #N$03 are never used.
E $D5F2 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$C3BD }
. { #MARTIANOIDS$BFDA }
. LIST#
.
. #TABLE(default,centre,left)
. { New Room Sound |
. #HTML(#AUDIO0(new-room-sound.wav)(#INCLUDE(NewRoomSound))) }
. { Item Sound | #HTML(#AUDIO0(item-sound.wav)(#INCLUDE(ItemSound))) }
. TABLE#
  $D5F2,$03 Take the number of notes left, #R$A749.
  $D5F5,$01 Fetch it.
  $D5F6,$02 Return if there are none.
  $D5F8,$01 Take one off.
  $D5F9,$01 Keep the number of notes that were left in #REGaf'.
  $D5FA,$01 Move on to the type of the effect.
  $D5FB,$01 Fetch it.
  $D5FC,$03 Take the table of sequences, #R$D60D.
  $D5FF,$03 Call #R$D692 to fetch the address of the sequence into #REGhl.
  $D602,$01 Get the number of notes that were left.
  $D603,$01 Put it in #REGc.
  $D604,$02 Clear #REGb.
  $D606,$01 Add it to the sequence, to point at the note.
  $D607,$01 Fetch the pitch.
  $D608,$02 Set the length of the tone.
  $D60A,$03 Jump to #R$D67B to make the tone.

b $D60D Sound Effect Sequences
@ $D60D label=SoundEffectSequences
D $D60D The addresses of the sequences of pitches of the sound effects, for the
. types of effect #N$00 to #N$03. The address of a sequence is that of the byte
. before its first note, as the first note is at the offset of one.
W $D60D,$08,$02

b $D615 Sound Effect Pitches
@ $D615 label=SoundEffectPitches
D $D615 The pitches of the notes of the sound effects, for #R$D5F2. The delay,
. which gets longer as the pitch gets lower.
B $D615,$01 The byte before the first sequence, which is never used.
B $D616,$04 The new room sequence, played from the end.
B $D61A,$05 The pick up or drop sequence, played from the end.
B $D61F,$0A Never used.

c $D629 Play Projectile Sound
@ $D629 label=PlayProjectileSound
D $D629 Makes the sound of a projectile that has been fired, from thirty-two
. single cycles of a tone whose pitch changes each cycle, in a way that depends
. on the value that #REGb has when the routine is called.
E $D629 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$C3F4 }
. LIST#
.
. #HTML(#AUDIO0(shot-sound.wav)(#INCLUDE(ShotSound)))
R $D629 B Starting value of the pitch
  $D629,$02 Set the number of cycles to #N$20.
@ $D62B label=PlayProjectileSound_Loop
  $D62B,$01 Fetch the number of cycles left.
  $D62C,$01 Take away the pitch.
  $D62D,$01 Set it as the new pitch.
  $D62E,$03 Call #R$D682 to make a cycle of the tone.
  $D631,$01 Count the cycle.
  $D632,$02 Jump back to #R$D62B until all of the cycles have been made.
  $D634,$01 Return.

c $D635 Play Footstep Sound
@ $D635 label=PlayFootstepSound
D $D635 Makes the sound of a footstep, on every fourth call, which alternates
. between two pitches.
.
. #HTML(#AUDIO0(footstep-sound.wav)(#INCLUDE(FootstepSound)))
  $D635,$03 Take the count of the footsteps, #R$A748.
  $D638,$01 Add one to it.
  $D639,$01 Fetch it.
  $D63A,$04 Jump to #R$D646 if bit 2 of the count is not set.
  $D63E,$02,b$01 Keep the lowest two bits.
  $D640,$01 Return if the count is not a multiple of four.
  $D641,$03 Set the pitch to #N$40 and the length to #N$02.
  $D644,$02 Jump to #R$D67B to make the tone.
@ $D646 label=PlayFootstepSound_Other
  $D646,$02,b$01 Keep the lowest two bits.
  $D648,$01 Return if the count is not a multiple of four.
  $D649,$03 Set the pitch to #N$60 and the length to #N$02.
  $D64C,$02 Jump to #R$D67B to make the tone.

c $D64E Play Explosion Sound
@ $D64E label=PlayExplosionSound
D $D64E Makes the noise of an explosion, from four single cycles of tones with
. pitches that are taken from the ROM, at an address that comes from the random
. seed.
.
. #HTML(#AUDIO0(explosion.wav)(#INCLUDE(Explosion)))
  $D64E,$03 Fetch the random seed.
  $D651,$01 Fetch the high byte.
  $D652,$02,b$01 Keep it within the first #N$2000 bytes of the ROM.
  $D654,$01 Put it in #REGh.
  $D655,$02 Set the number of tones to four.
@ $D657 label=PlayExplosionSound_Loop
  $D657,$01 Fetch a byte of the ROM.
  $D658,$01 Move on to the next.
  $D659,$02,b$01 Make it the pitch, up to #N$7F.
  $D65B,$01 Put the pitch in #REGb.
  $D65C,$02 Set the length of the tone to one cycle.
  $D65E,$03 Call #R$D67B to make the tone.
  $D661,$01 Count the tone.
  $D662,$02 Jump back to #R$D657 until all of the tones have been made.
  $D664,$01 Return.

c $D665 Play Object Sound
@ $D665 label=PlayObjectSound
D $D665 Never used. Makes a tone of a pitch that depends on the type of an
. object.
E $D665 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$C455 }
. LIST#
.
. #HTML(#AUDIO0(object-sound.wav)(#INCLUDE(ObjectSound)))
R $D665 IX Object record
  $D665,$03 Fetch the type of the object.
  $D668,$01 Invert it.
  $D669,$03 Rotate it so that its lowest three bits are in bits 5 to 7.
  $D66C,$02,b$01 Keep only those bits.
  $D66E,$01 Put the pitch in #REGb.
  $D66F,$02 Set the length of the tone to six cycles.
  $D671,$02 Jump to #R$D67B to make the tone.

c $D673 Play Stored Sound
@ $D673 label=PlayStoredSound
D $D673 Never used. The routine from #R$D674 makes a tone of a pitch that is
. held in the byte at #R$D673, which is the instruction at the start of this
. routine, a #N$00. That makes the tone the same as the pitch #N$FF, as the byte
. is inverted. It carries on as #R$D67B.
E $D673 Continue on to #R$D67B.
.
. #HTML(#AUDIO0(stored-sound.wav)(#INCLUDE(StoredSound)))
  $D673,$01 Do nothing, as this byte is the pitch of the sound.
  $D674,$03 Fetch the pitch.
  $D677,$01 Invert it.
  $D678,$01 Put it in #REGb.
  $D679,$02 Set the length of the tone to eight cycles.

c $D67B Play Wave Sequence
@ $D67B label=PlayWaveSequence
D $D67B Makes a tone from a number of cycles of the same length.
E $D67B View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B4E6 }
. { #ALIENEIGHT$B6FB }
. { #GUNFRIGHT$AF5F }
. { #MARTIANOIDS$C05B }
. LIST#
R $D67B B Half the length of a cycle, in units of the time that DJNZ takes
R $D67B C Number of cycles
  $D67B,$03 Call #R$D682 to make a cycle of the tone.
  $D67E,$01 Count the cycle.
  $D67F,$02 Jump back to #R$D67B until all of the cycles have been made.
  $D681,$01 Return.

c $D682 Play Square Wave
@ $D682 label=PlaySquareWave
D $D682 Makes one cycle of a square wave on the speaker, in which the speaker is
. on for a time and then off for the same time. The value in #REGb is kept.
E $D682 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B4ED }
. { #ALIENEIGHT$B702 }
. { #NIGHTSHADE$C471 }
. { #GUNFRIGHT$AF66 }
. { #MARTIANOIDS$C062 }
. { #BUBBLER$9E93 }
. { #CYBERUN$71E0 }
. LIST#
R $D682 B Half the length of the cycle
  $D682,$02 Set bit 4 to turn the speaker on.
  $D684,$02 Write it to the ULA.
  $D686,$01 Keep the length of the delay in #REGa.
@ $D687 label=PlaySquareWave_On
  $D687,$02 Wait while the speaker is on.
  $D689,$01 Get the length back.
  $D68A,$01 Set the speaker to off.
  $D68B,$02 Write it to the ULA.
  $D68D,$01 Keep the length of the delay in #REGa.
@ $D68E label=PlaySquareWave_Off
  $D68E,$02 Wait while the speaker is off.
  $D690,$01 Get the length back.
  $D691,$01 Return.

c $D692 Get Table Entry
@ $D692 label=GetTableEntry
D $D692 Fetches a word from a table.
E $D692 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D589 }
. { #GUNFRIGHT$C75C }
. { #MARTIANOIDS$C010 }
. LIST#
R $D692 A Number of the word
R $D692 BC Address of the table
R $D692 O:HL The word
  $D692,$03 Put the number in #REGhl.
  $D695,$01 Double it.
  $D696,$01 Add the table.
  $D697,$01 Fetch the low byte.
  $D698,$01 Move on to the high byte.
  $D699,$01 Fetch the high byte.
  $D69A,$01 Set the low byte.
  $D69B,$01 Return.

c $D69C Play Music Once
@ $D69C label=PlayMusicOnce
D $D69C Plays the tune of the menu, until a key is pressed or the tune ends. The
. tune is only started once in a game, as the flag at #R$A747 is set when it is,
. and it is only cleared when the game starts.
E $D69C View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B2B6 }
. { #ALIENEIGHT$B4A1 }
. { #NIGHTSHADE$C63D }
. { #GUNFRIGHT$AF76 }
. { #MARTIANOIDS$C0B6 }
. LIST#
R $D69C DE Address of the tune
  $D69C,$03 Take the flag for the tune having been played, #R$A747.
  $D69F,$01 Fetch it.
  $D6A0,$02 Return if the tune has been played already.
  $D6A2,$02 Set the flag.
@ $D6A4 label=PlayMusicOnce_Loop
  $D6A4,$01 Clear #REGa to read all of the rows of the keyboard.
  $D6A5,$03 Call #R$B952 to read the keyboard.
  $D6A8,$02 Jump to #R$D6AB if no key is pressed.
  $D6AA,$01 Return, as a key is pressed.
@ $D6AB label=PlayMusicOnce_Note
  $D6AB,$01 Fetch the next note.
  $D6AC,$04 Return if it is the end of the tune.
  $D6B0,$03 Call #R$D6C0 to play it.
  $D6B3,$02 Jump back to #R$D6A4 to play the next.

c $D6B5 Play Music
@ $D6B5 label=PlayMusic
D $D6B5 Plays a tune until its end.
E $D6B5 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B2CF }
. { #ALIENEIGHT$B4BA }
. { #NIGHTSHADE$C656 }
. { #GUNFRIGHT$AF8F }
. { #MARTIANOIDS$C0CF }
. { #BUBBLER$A1C1 }
. { #CYBERUN$9AA9 }
. LIST#
.
. #TABLE(default,centre,left)
. { Start-up Tune | #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune))) }
. { Main Tune | #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune))) }
. { Collected Tune |
. #HTML(#AUDIO0(collected-tune.wav)(#INCLUDE(CollectedTune))) }
. { Game Over Tune |
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune))) }
. { Game Complete Tune |
. #HTML(#AUDIO0(game-complete-tune.wav)(#INCLUDE(GameCompleteTune))) }
. TABLE#
R $D6B5 DE Address of the tune
  $D6B5,$01 Fetch the next note.
  $D6B6,$04 Jump to #R$D6BF if it is the end of the tune.
  $D6BA,$03 Call #R$D6C0 to play it.
  $D6BD,$02 Jump back to #R$D6B5 to play the next.
@ $D6BF label=PlayMusic_Done
  $D6BF,$01 Return.

c $D6C0 Play Note
@ $D6C0 label=PlayNote
D $D6C0 Plays a note of a tune, or lets the time of a rest go by. The note is a
. byte in which the lowest six bits are the number of the note, with a rest if
. it is zero, and the highest two bits are one less than the length of the note,
. which is that number of times the length of the shortest note. The pitch and
. the number of cycles of the note come from the table at #R$D718. A note is
. made of the same number of cycles for each of its lengths, so that the notes
. are all as long, whatever their pitch.
E $D6C0 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B2DA }
. { #ALIENEIGHT$B4C5 }
. { #NIGHTSHADE$C661 }
. { #GUNFRIGHT$AF9A }
. { #MARTIANOIDS$C0DA }
. { #BUBBLER$A1CC }
. { #CYBERUN$9AB4 }
. LIST#
R $D6C0 A Note
R $D6C0 DE Address of the note in the tune
R $D6C0 O:DE Address of the next note
  $D6C0,$02,b$01 Keep the number of the note.
  $D6C2,$02 Jump to #R$D702 if it is a rest.
N $D6C4 Look up the delays and the number of cycles in the table at #R$D718.
  $D6C4,$03 Put the number in #REGhl.
  $D6C7,$01 Double it.
  $D6C8,$03 Call #R$B519 to add the number, to make three times it.
  $D6CB,$03 Find the note in the table at #R$D718.
  $D6CE,$01 Add it to find the entry of the note.
  $D6CF,$01 Fetch the count for the first run of the delay loop for half a
. cycle.
  $D6D0,$01 Move on.
  $D6D1,$01 Fetch the number of times that the delay loop is run on from there.
  $D6D2,$01 Move on.
  $D6D3,$01 Fetch the number of cycles for a note of the shortest length.
  $D6D4,$02 Clear the high byte.
N $D6D6 Bits 6 and 7 of the note are the length, less one.
  $D6D6,$01 Fetch the note again.
  $D6D7,$02 Move the highest two bits to the lowest.
  $D6D9,$02,b$01 Keep them.
  $D6DB,$01 Add one to get the length of the note.
  $D6DC,$01 Save the address in the tune.
  $D6DD,$02 Copy the number of cycles to #REGde.
N $D6DF Multiply the number of cycles by the length of the note.
@ $D6DF label=PlayNote_Multiply
  $D6DF,$01 Take one off the length.
  $D6E0,$02 Jump to #R$D6E5 if it is the last.
  $D6E2,$01 Add the number of cycles for the shortest note.
  $D6E3,$02 Jump back to #R$D6DF.
@ $D6E5 label=PlayNote_Start
  $D6E5,$01 Get the address in the tune back.
N $D6E6 Each pass of this loop makes one cycle of the note, so the length of
. the note is the number of cycles.
@ $D6E6 label=PlayNote_Cycle
  $D6E6,$01 Save the half length of a cycle.
  $D6E7,$01 Set the speaker to off.
  $D6E8,$02 Write it to the ULA.
@ $D6EA label=PlayNote_LowWait
  $D6EA,$02 Wait while the speaker is off.
  $D6EC,$01 Count a loop of the high byte.
  $D6ED,$02 Jump back to #R$D6EA until the half cycle is over.
  $D6EF,$01 Get the half length back.
  $D6F0,$01 Save it again.
  $D6F1,$02 Set bit 4 to turn the speaker on.
  $D6F3,$02 Write it to the ULA.
@ $D6F5 label=PlayNote_HighWait
  $D6F5,$02 Wait while the speaker is on.
  $D6F7,$01 Count a loop of the high byte.
  $D6F8,$02 Jump back to #R$D6F5 until the half cycle is over.
  $D6FA,$01 Get the half length back.
  $D6FB,$01 Count the cycle.
  $D6FC,$02 Test whether there are any left.
  $D6FE,$02 Jump back to #R$D6E6 until all of the cycles have been made.
  $D700,$01 Move on to the next note of the tune.
  $D701,$01 Return.
N $D702 A rest is a silent pause, which is made by waiting one to four times.
@ $D702 label=PlayNote_Rest
  $D702,$01 Fetch the rest.
  $D703,$01 Move on to the next note of the tune.
  $D704,$02 Move the highest two bits to the lowest.
  $D706,$02,b$01 Keep them.
  $D708,$01 Add one to get the length of the rest.
  $D709,$01 Put it in #REGl.
  $D70A,$03 Set the count of the delay.
@ $D70D label=PlayNote_RestOuter
  $D70D,$01 Save it.
@ $D70E label=PlayNote_RestWait
  $D70E,$01 Count down.
  $D70F,$02 Test whether it is zero.
  $D711,$02 Jump back to #R$D70E until the delay is over.
  $D713,$01 Get the count back.
  $D714,$01 Take one off the length.
  $D715,$02 Jump back to #R$D70D until the rest is over.
  $D717,$01 Return.

b $D718 Note Table
@ $D718 label=NoteTable
D $D718 The entries for the notes, which #R$D6C0 uses, of three bytes each, for
. the notes #N$00 to #N$3C. For each note, the first byte is the count for the
. first run of the delay loop that makes half a cycle, and the second byte is
. the number of times that it is run on from there, in runs of #N$100, and the
. third is the number of cycles that a note of the shortest length is played
. for. The entry for the note #N$00 is not used, as that is a rest.
B $D718,$B7,$03

b $D7CF Menu Tune
@ $D7CF label=MenuTune
D $D7CF The tune of the menu, see #R$D69C. A byte is a note, as described at
. #R$D6C0, and #N$FF is the end of the tune.
.
. #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune)))
B $D7CF,$55,$10

b $D824 Unused Tune
@ $D824 label=UnusedTune
D $D824 Never used.
.
. #HTML(#AUDIO0(unused-tune.wav)(#INCLUDE(UnusedTune)))
B $D824,$0F,$0F

b $D833 Start Tune
@ $D833 label=StartTune
D $D833 The tune that is played when the game starts.
.
. #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune)))
B $D833,$14,$14

b $D847 Collected Tune
@ $D847 label=CollectedTune
D $D847 The tune that is played when the helper has collected an object, see
. #R$D0AC.
.
. #HTML(#AUDIO0(collected-tune.wav)(#INCLUDE(CollectedTune)))
B $D847,$0C,$0C

b $D853 Game Over Tune
@ $D853 label=GameOverTune
D $D853 The tune that is played when the game is over.
.
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
B $D853,$1C,$1C

b $D86F Victory Tune
@ $D86F label=VictoryTune
D $D86F The tune that is played when all of the stones have been put on the
. pentagram.
.
. #HTML(#AUDIO0(game-complete-tune.wav)(#INCLUDE(GameCompleteTune)))
B $D86F,$20,$10

s $D88F Screen Buffer
@ $D88F label=ScreenBuffer
D $D88F The buffer that the room is drawn into before it is copied to the
. screen by #R$B178 and #R$B19E. It is #N$20 bytes wide and #N$C0 pixel lines
. tall, in the order of the pixel lines of the screen but with the bottom line
. first. It is empty at the start of the game.
S $D88F,$1800

s $F08F Unused
D $F08F Never used.
S $F08F,$71

s $F100 Reverse Table
@ $F100 label=ReverseTable
D $F100 For each byte value, the value with its bits in the opposite order,
. which #R$B2EE uses to mirror a sprite. #R$B29A builds it, so it is empty in
. the snapshot.
S $F100,$0100

s $F200 Shift Tables
@ $F200 label=ShiftTables
D $F200 The pages of the tables that #R$B3D3 uses to shift a sprite to the
. right, by one to seven bits. For each of the seven shifts there is a page
. with the low byte and the page below it with the high byte of each byte value
. when it is shifted, with all of the bits inverted. #R$B29A builds them, so
. they are empty in the snapshot.
S $F200,$0E00
