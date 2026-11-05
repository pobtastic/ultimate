; Copyright Ashby Computers & Graphics Ltd 1985, Rare Ltd, 2026 ArcadeGeek LTD.
> $4000 @org=$4000
> $4000 @rom
> $4000 @start=$5B80
> $4000 @expand=#DEF(#POKE()(anchor,text) #LINK(Pokes#$anchor)($text))
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))
b $4000 Loading screen
@ $4000 label=Loading
D $4000 #UDGTABLE { =h Nightshade Loading Screen }
. { #SCR$02(loading) } UDGTABLE#
N $4000 The knotwork around the loading screen is the same border that
. #R$CA9D draws around the game selection menu at #R$C8CA. That frame is
. used as the border of every page of this disassembly.
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

c $5B80 Decryption Routine
@ $5B80 label=Decryption
D $5B80 The stub that the tape loader runs after loading the game, which
. arrives scrambled at #N$6000 (#N$8800 bytes of it). It unscrambles the game
. in place, moves it down by #N$0200 bytes so that it starts at #R$5E00, and
. jumps there.
.
. Each pair of bytes is unscrambled by a single RLD: the low nibble of the
. first byte of the pair is replaced by the high nibble of the second byte,
. the high nibble of the second byte by its low nibble, and the low nibble of
. the second byte by the old low nibble of the first byte.
.
. The routine also sets bit 7 of the memory refresh register #REGr. Nothing
. in the game ever clears that bit, and the game resets the computer if it is
. clear when the check at #R$C1DB runs, which defeats any attempt to start the
. game without going through this stub. The random number generator at #R$C5BB
. also reads #REGr, so that bit keeps those values in the range #N$80 to
. #N$FF.
E $5B80 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$5B80 }
. { #LUNARJETMAN$5B80 }
. LIST#
N $5B80 Set bit 7 of the memory refresh register for the random
. number generator.
  $5B80,$01 Disable interrupts.
  $5B81,$02 Fetch the memory refresh register into #REGa.
  $5B83,$02,b$01 Set bit 7. The Z80 leaves that bit as it is written,
. so #R$C5BB always mixes a value from #N$80 to #N$FF into the
. random number.
  $5B85,$02 Write #REGa back to the memory refresh register.
N $5B87 Unscramble the whole game, a pair of bytes at a time.
  $5B87,$03 Set #REGde to #N$6000, the first byte of the first pair.
  $5B8A,$03 Set #REGhl to #N$6001, the second byte of the first pair.
  $5B8D,$03 Set a pair counter in #REGbc to #N$4400.
@ $5B90 label=Decryption_Loop
  $5B90,$01 Fetch the first byte of the pair.
  $5B91,$02 Rotate the nibbles of the pair.
  $5B93,$01 Write the unscrambled first byte back.
  $5B94,$02 Move #REGde on to the first byte of the next pair.
  $5B96,$02 Move #REGhl on to the second byte of the next pair.
  $5B98,$01 Decrease the pair counter by one.
  $5B99,$04 Jump back to #R$5B90 until every pair has been unscrambled.
N $5B9D Move the unscrambled game down so that it starts at #R$5E00.
  $5B9D,$0B Move #N$8800 bytes from #N$6000 down to #R$5E00.
  $5BA8,$03 Jump to #R$5E00 to start the game.

i $5BAB

c $5CB0 Indirect Jump
@ $5CB0 label=IndirectJump
D $5CB0 Jumps to the routine whose address is already held in #REGhl. It is the
. byte #N$E9 (JP (HL)) that the tape loader leaves in the system variable
. #SKOOLKID$5CB0(NMIADD), which the game borrows as a trampoline.
E $5CB0 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$5CB0 }
. { #LUNARJETMAN$5CB0 }
. { #SABREWULF$5CB0 }
. { #TRANZAM$5CB0 }
. LIST#
R $5CB0 HL Jump address
  $5CB0,$01 Jump to the address held in #REGhl.

i $5CB1

c $5E00 Game Entry Point
@ $5E00 label=GameEntry
D $5E00 The start of the game, which the #R$5B80 stub jumps to once the game has
. been unscrambled and moved into place.
  $5E00,$01 Disable interrupts.
  $5E01,$03 Jump to #R$BDFE.

b $5E04 Map
@ $5E04 label=Map
D $5E04 The map of the village. It is #N$20 cells wide and #N$20 cells high, and
. each byte holds the tile that is in one cell, which is a number from #N$00 to
. #N$23. Tile #N$00 is open ground, and tile #N$01 is the solid tile that fills
. the edge of the village and much of the rest of it. The other tiles are the
. trees, graves, walls and other things that stand in the village. The cell is
. found from the column and the row by #R$E051, and the tile decides how it is
. drawn (see #R$62A4) and what the player can walk through (see #R$6334). The
. whole village is shown on the #LINK(Map)(Map) page.
.
. When the view is turned round, the map is read backwards from the end.
B $5E04,$20,$20 Row #N$00.
B $5E24,$20,$20 Row #N$01.
B $5E44,$20,$20 Row #N$02.
B $5E64,$20,$20 Row #N$03.
B $5E84,$20,$20 Row #N$04.
B $5EA4,$20,$20 Row #N$05.
B $5EC4,$20,$20 Row #N$06.
B $5EE4,$20,$20 Row #N$07.
B $5F04,$20,$20 Row #N$08.
B $5F24,$20,$20 Row #N$09.
B $5F44,$20,$20 Row #N$0A.
B $5F64,$20,$20 Row #N$0B.
B $5F84,$20,$20 Row #N$0C.
B $5FA4,$20,$20 Row #N$0D.
B $5FC4,$20,$20 Row #N$0E.
B $5FE4,$20,$20 Row #N$0F.
B $6004,$20,$20 Row #N$10.
B $6024,$20,$20 Row #N$11.
B $6044,$20,$20 Row #N$12.
B $6064,$20,$20 Row #N$13.
B $6084,$20,$20 Row #N$14.
B $60A4,$20,$20 Row #N$15.
B $60C4,$20,$20 Row #N$16.
B $60E4,$20,$20 Row #N$17.
B $6104,$20,$20 Row #N$18.
B $6124,$20,$20 Row #N$19.
B $6144,$20,$20 Row #N$1A.
B $6164,$20,$20 Row #N$1B.
B $6184,$20,$20 Row #N$1C.
B $61A4,$20,$20 Row #N$1D.
B $61C4,$20,$20 Row #N$1E.
B $61E4,$20,$20 Row #N$1F.

b $6204 View Patterns
@ $6204 label=ViewPatterns
D $6204 The orders in which to draw the five cells that are beside the cell that
. the player is in, which is chosen by which of those cells are empty (see
. #R$CF08 for the way that the bytes are used). There are #N$20 patterns, one
. for each combination of the five cells, and each is made of five bytes.
B $6204,$05,$05 Pattern #N$00.
B $6209,$05,$05 Pattern #N$01.
B $620E,$05,$05 Pattern #N$02.
B $6213,$05,$05 Pattern #N$03.
B $6218,$05,$05 Pattern #N$04.
B $621D,$05,$05 Pattern #N$05.
B $6222,$05,$05 Pattern #N$06.
B $6227,$05,$05 Pattern #N$07.
B $622C,$05,$05 Pattern #N$08.
B $6231,$05,$05 Pattern #N$09.
B $6236,$05,$05 Pattern #N$0A.
B $623B,$05,$05 Pattern #N$0B.
B $6240,$05,$05 Pattern #N$0C.
B $6245,$05,$05 Pattern #N$0D.
B $624A,$05,$05 Pattern #N$0E.
B $624F,$05,$05 Pattern #N$0F.
B $6254,$05,$05 Pattern #N$10.
B $6259,$05,$05 Pattern #N$11.
B $625E,$05,$05 Pattern #N$12.
B $6263,$05,$05 Pattern #N$13.
B $6268,$05,$05 Pattern #N$14.
B $626D,$05,$05 Pattern #N$15.
B $6272,$05,$05 Pattern #N$16.
B $6277,$05,$05 Pattern #N$17.
B $627C,$05,$05 Pattern #N$18.
B $6281,$05,$05 Pattern #N$19.
B $6286,$05,$05 Pattern #N$1A.
B $628B,$05,$05 Pattern #N$1B.
B $6290,$05,$05 Pattern #N$1C.
B $6295,$05,$05 Pattern #N$1D.
B $629A,$05,$05 Pattern #N$1E.
B $629F,$05,$05 Pattern #N$1F.

w $62A4 Strip List Table
@ $62A4 label=StripListTable
D $62A4 The lists of strips that draw each tile. There are two for each tile:
. the first is for the view as it is, and the second is for the view when it has
. been turned round. Tile #N$00 has no lists because nothing is drawn for it.
W $62A4,$04,$02 Tile #N$00.
W $62A8,$04,$02 Tile #N$01.
W $62AC,$04,$02 Tile #N$02.
W $62B0,$04,$02 Tile #N$03.
W $62B4,$04,$02 Tile #N$04.
W $62B8,$04,$02 Tile #N$05.
W $62BC,$04,$02 Tile #N$06.
W $62C0,$04,$02 Tile #N$07.
W $62C4,$04,$02 Tile #N$08.
W $62C8,$04,$02 Tile #N$09.
W $62CC,$04,$02 Tile #N$0A.
W $62D0,$04,$02 Tile #N$0B.
W $62D4,$04,$02 Tile #N$0C.
W $62D8,$04,$02 Tile #N$0D.
W $62DC,$04,$02 Tile #N$0E.
W $62E0,$04,$02 Tile #N$0F.
W $62E4,$04,$02 Tile #N$10.
W $62E8,$04,$02 Tile #N$11.
W $62EC,$04,$02 Tile #N$12.
W $62F0,$04,$02 Tile #N$13.
W $62F4,$04,$02 Tile #N$14.
W $62F8,$04,$02 Tile #N$15.
W $62FC,$04,$02 Tile #N$16.
W $6300,$04,$02 Tile #N$17.
W $6304,$04,$02 Tile #N$18.
W $6308,$04,$02 Tile #N$19.
W $630C,$04,$02 Tile #N$1A.
W $6310,$04,$02 Tile #N$1B.
W $6314,$04,$02 Tile #N$1C.
W $6318,$04,$02 Tile #N$1D.
W $631C,$04,$02 Tile #N$1E.
W $6320,$04,$02 Tile #N$1F.
W $6324,$04,$02 Tile #N$20.
W $6328,$04,$02 Tile #N$21.
W $632C,$04,$02 Tile #N$22.
W $6330,$04,$02 Tile #N$23.

w $6334 Rectangle List Table
@ $6334 label=RectangleListTable
D $6334 The list of rectangles that the walls of each tile are made of, for
. finding out whether an object has hit one (see #R$E063). There is one list for
. each tile.
W $6334,$02,$02 Tile #N$00.
W $6336,$02,$02 Tile #N$01.
W $6338,$02,$02 Tile #N$02.
W $633A,$02,$02 Tile #N$03.
W $633C,$02,$02 Tile #N$04.
W $633E,$02,$02 Tile #N$05.
W $6340,$02,$02 Tile #N$06.
W $6342,$02,$02 Tile #N$07.
W $6344,$02,$02 Tile #N$08.
W $6346,$02,$02 Tile #N$09.
W $6348,$02,$02 Tile #N$0A.
W $634A,$02,$02 Tile #N$0B.
W $634C,$02,$02 Tile #N$0C.
W $634E,$02,$02 Tile #N$0D.
W $6350,$02,$02 Tile #N$0E.
W $6352,$02,$02 Tile #N$0F.
W $6354,$02,$02 Tile #N$10.
W $6356,$02,$02 Tile #N$11.
W $6358,$02,$02 Tile #N$12.
W $635A,$02,$02 Tile #N$13.
W $635C,$02,$02 Tile #N$14.
W $635E,$02,$02 Tile #N$15.
W $6360,$02,$02 Tile #N$16.
W $6362,$02,$02 Tile #N$17.
W $6364,$02,$02 Tile #N$18.
W $6366,$02,$02 Tile #N$19.
W $6368,$02,$02 Tile #N$1A.
W $636A,$02,$02 Tile #N$1B.
W $636C,$02,$02 Tile #N$1C.
W $636E,$02,$02 Tile #N$1D.
W $6370,$02,$02 Tile #N$1E.
W $6372,$02,$02 Tile #N$1F.
W $6374,$02,$02 Tile #N$20.
W $6376,$02,$02 Tile #N$21.
W $6378,$02,$02 Tile #N$22.
W $637A,$02,$02 Tile #N$23.

b $637C Rectangle Lists
@ $637C label=RectangleLists
D $637C The lists of rectangles. Each rectangle is four bytes: the X and Y
. positions of the centre, and then the half width and the half depth. A zero X
. position ends a list. Several tiles share the same list.
B $637C,$01,$01 The list for tile #N$00, which has no rectangles.
@ $637D label=RectangleList_01
B $637D,$11,$04 The list for tiles #N$01 and #N$02, which has 4 rectangles.
@ $638E label=RectangleList_02
B $638E,$19,$04 The list for tiles #N$07, #N$0F and #N$17, which has 6
. rectangles.
@ $63A7 label=RectangleList_03
B $63A7,$15,$04 The list for tiles #N$04, #N$0C and #N$14, which has 5
. rectangles.
@ $63BC label=RectangleList_04
B $63BC,$15,$04 The list for tiles #N$05, #N$0D and #N$15, which has 5
. rectangles.
@ $63D1 label=RectangleList_05
B $63D1,$15,$04 The list for tiles #N$06, #N$0E and #N$16, which has 5
. rectangles.
@ $63E6 label=RectangleList_06
B $63E6,$15,$04 The list for tiles #N$03, #N$0B, #N$13, #N$1D and #N$1F, which
. has 5 rectangles.
@ $63FB label=RectangleList_07
B $63FB,$19,$04 The list for tiles #N$08, #N$10 and #N$18, which has 6
. rectangles.
@ $6414 label=RectangleList_08
B $6414,$21,$04 The list for tiles #N$09, #N$11 and #N$19, which has 8
. rectangles.
@ $6435 label=RectangleList_09
B $6435,$19,$04 The list for tile #N$12, which has 6 rectangles.
@ $644E label=RectangleList_10
B $644E,$41,$04 The list for tile #N$0A, which has 16 rectangles.
@ $648F label=RectangleList_11
B $648F,$19,$04 The list for tiles #N$1A and #N$1C, which has 6 rectangles.
@ $64A8 label=RectangleList_12
B $64A8,$15,$04 The list for tile #N$1B, which has 5 rectangles.
@ $64BD label=RectangleList_13
B $64BD,$1D,$04 The list for tile #N$1E, which has 7 rectangles.
@ $64DA label=RectangleList_14
B $64DA,$1D,$04 The list for tile #N$20, which has 7 rectangles.
@ $64F7 label=RectangleList_15
B $64F7,$19,$04 The list for tile #N$21, which has 6 rectangles.
@ $6510 label=RectangleList_16
B $6510,$19,$04 The list for tile #N$22, which has 6 rectangles.
@ $6529 label=RectangleList_17
B $6529,$19,$04 The list for tile #N$23, which has 6 rectangles.

b $6542 Strip Variants
@ $6542 label=StripVariants
D $6542 One byte for each strip, which is combined with the variant of the strip
. when a cell is drawn to give the number (#N$00 to #N$03) of the graphic to use
. (see #R$6FDC).
B $6542,$34,$04

b $6576 Strip Lists
@ $6576 label=StripLists
D $6576 The lists of strips that draw the tiles. Each list is made of sixteen
. pairs of bytes, for the sixteen strips that lie along the edge of a cell (see
. #R$D1FA and #R$D3C2). The first byte of each pair is the number of the strip,
. which is an index into the table at #R$6542 for a cell or the table at #R$6E36
. for a cell with walls. The second byte is the number of a strip that is drawn
. sixty-four pixels below it, when the cell has walls.
B $6576,$20,$02 The list for tile #N$07 in the view as it is.
@ $6596 label=StripList_01
B $6596,$20,$02 The list for tile #N$07 in the turned view.
@ $65B6 label=StripList_02
B $65B6,$20,$02 The list for tile #N$0B in the view as it is.
@ $65D6 label=StripList_03
B $65D6,$20,$02 The list for tile #N$0B in the turned view.
@ $65F6 label=StripList_04
B $65F6,$20,$02 The list for tile #N$23 in the view as it is.
@ $6616 label=StripList_05
B $6616,$20,$02 The list for tile #N$23 in the turned view.
@ $6636 label=StripList_06
B $6636,$20,$02 The list for tile #N$22 in the view as it is.
@ $6656 label=StripList_07
B $6656,$20,$02 The list for tile #N$22 in the turned view.
@ $6676 label=StripList_08
B $6676,$20,$02 The list for tile #N$21 in the view as it is.
@ $6696 label=StripList_09
B $6696,$20,$02 The list for tile #N$21 in the turned view.
@ $66B6 label=StripList_10
B $66B6,$20,$02 The list for tile #N$20 in the view as it is.
@ $66D6 label=StripList_11
B $66D6,$20,$02 The list for tile #N$20 in the turned view.
@ $66F6 label=StripList_12
B $66F6,$20,$02 The list for tile #N$1F in the view as it is.
@ $6716 label=StripList_13
B $6716,$20,$02 The list for tile #N$1F in the turned view.
@ $6736 label=StripList_14
B $6736,$20,$02 The list for tile #N$1E in the view as it is.
@ $6756 label=StripList_15
B $6756,$20,$02 The list for tile #N$1E in the turned view.
@ $6776 label=StripList_16
B $6776,$20,$02 The list for tile #N$1D in the view as it is.
@ $6796 label=StripList_17
B $6796,$20,$02 The list for tile #N$1D in the turned view.
@ $67B6 label=StripList_18
B $67B6,$20,$02 The list for tile #N$1C in the view as it is.
@ $67D6 label=StripList_19
B $67D6,$20,$02 The list for tile #N$1C in the turned view.
@ $67F6 label=StripList_20
B $67F6,$20,$02 The list for tile #N$04 in the view as it is.
@ $6816 label=StripList_21
B $6816,$20,$02 The list for tile #N$04 in the turned view.
@ $6836 label=StripList_22
B $6836,$20,$02 The list for tile #N$05 in the view as it is.
@ $6856 label=StripList_23
B $6856,$20,$02 The list for tile #N$05 in the turned view.
@ $6876 label=StripList_24
B $6876,$20,$02 The list for tile #N$06 in the view as it is.
@ $6896 label=StripList_25
B $6896,$20,$02 The list for tile #N$06 in the turned view.
@ $68B6 label=StripList_26
B $68B6,$20,$02 The list for tile #N$03 in the view as it is.
@ $68D6 label=StripList_27
B $68D6,$20,$02 The list for tile #N$03 in the turned view.
@ $68F6 label=StripList_28
B $68F6,$20,$02 The list for tile #N$08 in the view as it is, and for tile #N$08
. in the turned view.
@ $6916 label=StripList_29
B $6916,$20,$02 The list for tile #N$12 in the view as it is, and for tile #N$12
. in the turned view.
@ $6936 label=StripList_30
B $6936,$20,$02 The list for tile #N$0A in the view as it is, and for tile #N$0A
. in the turned view.
@ $6956 label=StripList_31
B $6956,$20,$02 The list for tile #N$1A in the view as it is.
@ $6976 label=StripList_32
B $6976,$20,$02 The list for tile #N$1A in the turned view.
@ $6996 label=StripList_33
B $6996,$20,$02 The list for tile #N$02 in the view as it is, and for tile #N$02
. in the turned view.
@ $69B6 label=StripList_34
B $69B6,$20,$02 The list for tile #N$01 in the view as it is, and for tile #N$01
. in the turned view.
@ $69D6 label=StripList_35
B $69D6,$20,$02 The list for tile #N$0F in the view as it is, and for tile #N$0F
. in the turned view.
@ $69F6 label=StripList_36
B $69F6,$20,$02 The list for tile #N$0C in the view as it is.
@ $6A16 label=StripList_37
B $6A16,$20,$02 The list for tile #N$0C in the turned view.
@ $6A36 label=StripList_38
B $6A36,$20,$02 The list for tile #N$0D in the view as it is.
@ $6A56 label=StripList_39
B $6A56,$20,$02 The list for tile #N$0D in the turned view.
@ $6A76 label=StripList_40
B $6A76,$20,$02 The list for tile #N$0E in the view as it is.
@ $6A96 label=StripList_41
B $6A96,$20,$02 The list for tile #N$0E in the turned view.
@ $6AB6 label=StripList_42
B $6AB6,$20,$02 The list for tile #N$1B in the view as it is.
@ $6AD6 label=StripList_43
B $6AD6,$20,$02 The list for tile #N$1B in the turned view.
@ $6AF6 label=StripList_44
B $6AF6,$20,$02 The list for tile #N$10 in the view as it is, and for tile #N$10
. in the turned view.
@ $6B16 label=StripList_45
B $6B16,$20,$02 The list for tile #N$11 in the view as it is, and for tile #N$11
. in the turned view.
@ $6B36 label=StripList_46
B $6B36,$20,$02 The list for tile #N$09 in the view as it is, and for tile #N$09
. in the turned view.
@ $6B56 label=StripList_47
B $6B56,$20,$02 The list for tile #N$14 in the view as it is.
@ $6B76 label=StripList_48
B $6B76,$20,$02 The list for tile #N$14 in the turned view.
@ $6B96 label=StripList_49
B $6B96,$20,$02 The list for tile #N$13 in the view as it is.
@ $6BB6 label=StripList_50
B $6BB6,$20,$02 The list for tile #N$13 in the turned view.
@ $6BD6 label=StripList_51
B $6BD6,$20,$02 The list for tile #N$16 in the view as it is.
@ $6BF6 label=StripList_52
B $6BF6,$20,$02 The list for tile #N$16 in the turned view.
@ $6C16 label=StripList_53
B $6C16,$20,$02 The list for tile #N$15 in the view as it is.
@ $6C36 label=StripList_54
B $6C36,$20,$02 The list for tile #N$15 in the turned view.
@ $6C56 label=StripList_55
B $6C56,$20,$02 The list for tile #N$19 in the view as it is, and for tile #N$19
. in the turned view.
@ $6C76 label=StripList_56
B $6C76,$20,$02 The list for tile #N$18 in the view as it is, and for tile #N$18
. in the turned view.
@ $6C96 label=StripList_57
B $6C96,$20,$02 The list for tile #N$17 in the view as it is, and for tile #N$17
. in the turned view.

b $6CB6 Tube Characters
@ $6CB6 label=TubeCharacters
D $6CB6 The five characters that are used to draw the inventory tube (see
. #R$C83F), from #N$00 to #N$04 when the font pointer is #N$6CB6.
B $6CB6,$28,$08

b $6CDE Font
@ $6CDE label=Font
D $6CDE The graphics of the characters that are used for the score and the text,
. from #N$30 (the digit "0") to #N$5A (the letter "Z"). The graphic of a
. character is found by adding eight times its code to the font pointer, which
. is #N$6B5E for this font (see #R$C9EF), so the characters with codes below
. #N$30 are not part of it.
E $6CDE View the equivalent code in;
. #LIST
. { #ALIENEIGHT$6308 }
. { #KNIGHTLORE$6108 }
. { #MARTIANOIDS$C33C }
. { #PENTAGRAM$8355 }
. { #UNDERWURLDE$EEA4 }
. LIST#
B $6CDE,$08,$08 #UDG(#PC)
L $6CDE,$08,$2B


w $6E36 Wall Strip Table
@ $6E36 label=WallStripTable
D $6E36 The addresses of the graphics of the strips of wall, which are drawn for
. the cells that have walls. There is an address for each strip number that the
. lists of strips use (see #R$6576).
W $6E36,$02,$02 Strip #N$00.
W $6E38,$02,$02 Strip #N$01.
W $6E3A,$02,$02 Strip #N$02.
W $6E3C,$02,$02 Strip #N$03.
W $6E3E,$02,$02 Strip #N$04.
W $6E40,$02,$02 Strip #N$05.
W $6E42,$02,$02 Strip #N$06.
W $6E44,$02,$02 Strip #N$07.
W $6E46,$02,$02 Strip #N$08.
W $6E48,$02,$02 Strip #N$09.
W $6E4A,$02,$02 Strip #N$0A.
W $6E4C,$02,$02 Strip #N$0B.
W $6E4E,$02,$02 Strip #N$0C.
W $6E50,$02,$02 Strip #N$0D.
W $6E52,$02,$02 Strip #N$0E.
W $6E54,$02,$02 Strip #N$0F.
W $6E56,$02,$02 Strip #N$10.
W $6E58,$02,$02 Strip #N$11.
W $6E5A,$02,$02 Strip #N$12.
W $6E5C,$02,$02 Strip #N$13.
W $6E5E,$02,$02 Strip #N$14.
W $6E60,$02,$02 Strip #N$15.
W $6E62,$02,$02 Strip #N$16.
W $6E64,$02,$02 Strip #N$17.
W $6E66,$02,$02 Strip #N$18.
W $6E68,$02,$02 Strip #N$19.
W $6E6A,$02,$02 Strip #N$1A.
W $6E6C,$02,$02 Strip #N$1B.
W $6E6E,$02,$02 Strip #N$1C.
W $6E70,$02,$02 Strip #N$1D.
W $6E72,$02,$02 Strip #N$1E.
W $6E74,$02,$02 Strip #N$1F.
W $6E76,$02,$02 Strip #N$20.
W $6E78,$02,$02 Strip #N$21.
W $6E7A,$02,$02 Strip #N$22.
W $6E7C,$02,$02 Strip #N$23.
W $6E7E,$02,$02 Strip #N$24.
W $6E80,$02,$02 Strip #N$25.
W $6E82,$02,$02 Strip #N$26.
W $6E84,$02,$02 Strip #N$27.
W $6E86,$02,$02 Strip #N$28.
W $6E88,$02,$02 Strip #N$29.
W $6E8A,$02,$02 Strip #N$2A.
W $6E8C,$02,$02 Strip #N$2B.
W $6E8E,$02,$02 Strip #N$2C.
W $6E90,$02,$02 Strip #N$2D.
W $6E92,$02,$02 Strip #N$2E.
W $6E94,$02,$02 Strip #N$2F.
W $6E96,$02,$02 Strip #N$30.
W $6E98,$02,$02 Strip #N$31.
W $6E9A,$02,$02 Strip #N$32.
W $6E9C,$02,$02 Strip #N$33.

w $6E9E Sprite Table
@ $6E9E label=SpriteTable
D $6E9E The addresses of the sprites, which are found from the type of an object
. (see #R$D599). A sprite is turned round or upside down in place when the
. object is flagged as being the other way (see #R$E353).
W $6E9E,$02,$02 Type #N$00: Blank.
W $6EA0,$02,$02 Type #N$01: Blank.
W $6EA2,$02,$02 Type #N$02: Speed Bonus.
W $6EA4,$02,$02 Type #N$03: Health Bonus.
W $6EA6,$02,$02 Type #N$04: Item 1.
W $6EA8,$02,$02 Type #N$05: Item 2.
W $6EAA,$02,$02 Type #N$06: Item 3.
W $6EAC,$02,$02 Type #N$07: Item 4.
W $6EAE,$02,$02 Type #N$08: Item 1.
W $6EB0,$02,$02 Type #N$09: Item 2.
W $6EB2,$02,$02 Type #N$0A: Item 3.
W $6EB4,$02,$02 Type #N$0B: Item 4.
W $6EB6,$02,$02 Type #N$0C: Burst 1.
W $6EB8,$02,$02 Type #N$0D: Burst 2.
W $6EBA,$02,$02 Type #N$0E: Burst 3.
W $6EBC,$02,$02 Type #N$0F: Burst 4.
W $6EBE,$02,$02 Type #N$10: Player Legs A Frame 1.
W $6EC0,$02,$02 Type #N$11: Player Legs A Frame 2.
W $6EC2,$02,$02 Type #N$12: Player Legs A Frame 3.
W $6EC4,$02,$02 Type #N$13: Player Legs A Frame 4.
W $6EC6,$02,$02 Type #N$14: Player Legs A Frame 3.
W $6EC8,$02,$02 Type #N$15: Player Legs A Frame 2.
W $6ECA,$02,$02 Type #N$16: Player Bumping Body A.
W $6ECC,$02,$02 Type #N$17: Blank.
W $6ECE,$02,$02 Type #N$18: Player Legs B Frame 1.
W $6ED0,$02,$02 Type #N$19: Player Legs B Frame 2.
W $6ED2,$02,$02 Type #N$1A: Player Legs B Frame 3.
W $6ED4,$02,$02 Type #N$1B: Player Legs B Frame 4.
W $6ED6,$02,$02 Type #N$1C: Player Legs B Frame 3.
W $6ED8,$02,$02 Type #N$1D: Player Legs B Frame 2.
W $6EDA,$02,$02 Type #N$1E: Player Bumping Body B.
W $6EDC,$02,$02 Type #N$1F: Blank.
W $6EDE,$02,$02 Type #N$20: Player Body A Frame 1.
W $6EE0,$02,$02 Type #N$21: Player Body A Frame 2.
W $6EE2,$02,$02 Type #N$22: Player Body A Frame 3.
W $6EE4,$02,$02 Type #N$23: Player Body A Frame 4.
W $6EE6,$02,$02 Type #N$24: Player Body A Frame 3.
W $6EE8,$02,$02 Type #N$25: Player Body A Frame 2.
W $6EEA,$02,$02 Type #N$26: Player Body A Frame 5.
W $6EEC,$02,$02 Type #N$27: Player Body A Frame 6.
W $6EEE,$02,$02 Type #N$28: Player Body B Frame 1.
W $6EF0,$02,$02 Type #N$29: Player Body B Frame 2.
W $6EF2,$02,$02 Type #N$2A: Player Body B Frame 3.
W $6EF4,$02,$02 Type #N$2B: Player Body B Frame 4.
W $6EF6,$02,$02 Type #N$2C: Player Body B Frame 3.
W $6EF8,$02,$02 Type #N$2D: Player Body B Frame 2.
W $6EFA,$02,$02 Type #N$2E: Player Body B Frame 5.
W $6EFC,$02,$02 Type #N$2F: Player Body B Frame 6.
W $6EFE,$02,$02 Type #N$30: Shot 1 Frame 1.
W $6F00,$02,$02 Type #N$31: Shot 1 Frame 2.
W $6F02,$02,$02 Type #N$32: Shot 1 Frame 3.
W $6F04,$02,$02 Type #N$33: Shot 1 Frame 4.
W $6F06,$02,$02 Type #N$34: Shot 2 Frame 1.
W $6F08,$02,$02 Type #N$35: Shot 2 Frame 2.
W $6F0A,$02,$02 Type #N$36: Shot 2 Frame 3.
W $6F0C,$02,$02 Type #N$37: Shot 2 Frame 2.
W $6F0E,$02,$02 Type #N$38: Shot 3 Frame 1.
W $6F10,$02,$02 Type #N$39: Shot 3 Frame 2.
W $6F12,$02,$02 Type #N$3A: Shot 3 Frame 3.
W $6F14,$02,$02 Type #N$3B: Shot 3 Frame 4.
W $6F16,$02,$02 Type #N$3C: Shot 4 Frame 1.
W $6F18,$02,$02 Type #N$3D: Shot 4 Frame 2.
W $6F1A,$02,$02 Type #N$3E: Shot 4 Frame 3.
W $6F1C,$02,$02 Type #N$3F: Shot 4 Frame 4.
W $6F1E,$02,$02 Type #N$40: Spore 1 Frame 1.
W $6F20,$02,$02 Type #N$41: Spore 1 Frame 2.
W $6F22,$02,$02 Type #N$42: Spore 1 Frame 3.
W $6F24,$02,$02 Type #N$43: Spore 1 Frame 2.
W $6F26,$02,$02 Type #N$44: Spore 2 Frame 1.
W $6F28,$02,$02 Type #N$45: Spore 2 Frame 2.
W $6F2A,$02,$02 Type #N$46: Spore 2 Frame 3.
W $6F2C,$02,$02 Type #N$47: Spore 2 Frame 2.
W $6F2E,$02,$02 Type #N$48: Spore 3 Frame 1.
W $6F30,$02,$02 Type #N$49: Spore 3 Frame 2.
W $6F32,$02,$02 Type #N$4A: Spore 3 Frame 3.
W $6F34,$02,$02 Type #N$4B: Spore 3 Frame 2.
W $6F36,$02,$02 Type #N$4C: Spore 4 Frame 1.
W $6F38,$02,$02 Type #N$4D: Spore 4 Frame 2.
W $6F3A,$02,$02 Type #N$4E: Spore 4 Frame 3.
W $6F3C,$02,$02 Type #N$4F: Spore 4 Frame 2.
W $6F3E,$02,$02 Type #N$50: Shot 1 Frame 1.
W $6F40,$02,$02 Type #N$51: Shot 1 Frame 2.
W $6F42,$02,$02 Type #N$52: Shot 1 Frame 3.
W $6F44,$02,$02 Type #N$53: Shot 1 Frame 4.
W $6F46,$02,$02 Type #N$54: Shot 2 Frame 1.
W $6F48,$02,$02 Type #N$55: Shot 2 Frame 2.
W $6F4A,$02,$02 Type #N$56: Shot 2 Frame 3.
W $6F4C,$02,$02 Type #N$57: Shot 2 Frame 2.
W $6F4E,$02,$02 Type #N$58: Shot 3 Frame 1.
W $6F50,$02,$02 Type #N$59: Shot 3 Frame 2.
W $6F52,$02,$02 Type #N$5A: Shot 3 Frame 3.
W $6F54,$02,$02 Type #N$5B: Shot 3 Frame 4.
W $6F56,$02,$02 Type #N$5C: Shot 4 Frame 1.
W $6F58,$02,$02 Type #N$5D: Shot 4 Frame 2.
W $6F5A,$02,$02 Type #N$5E: Shot 4 Frame 3.
W $6F5C,$02,$02 Type #N$5F: Shot 4 Frame 4.
W $6F5E,$02,$02 Type #N$60: Monster 1 Frame 1.
W $6F60,$02,$02 Type #N$61: Monster 1 Frame 2.
W $6F62,$02,$02 Type #N$62: Monster 1 Frame 1.
W $6F64,$02,$02 Type #N$63: Monster 1 Frame 2.
W $6F66,$02,$02 Type #N$64: Monster 2 Frame 1.
W $6F68,$02,$02 Type #N$65: Monster 2 Frame 1.
W $6F6A,$02,$02 Type #N$66: Monster 2 Frame 2.
W $6F6C,$02,$02 Type #N$67: Monster 2 Frame 2.
W $6F6E,$02,$02 Type #N$68: Monster 3 Frame 1.
W $6F70,$02,$02 Type #N$69: Monster 3 Frame 1.
W $6F72,$02,$02 Type #N$6A: Monster 3 Frame 2.
W $6F74,$02,$02 Type #N$6B: Monster 3 Frame 2.
W $6F76,$02,$02 Type #N$6C: Monster 4 Frame 1.
W $6F78,$02,$02 Type #N$6D: Monster 4 Frame 2.
W $6F7A,$02,$02 Type #N$6E: Monster 4 Frame 3.
W $6F7C,$02,$02 Type #N$6F: Monster 4 Frame 4.
W $6F7E,$02,$02 Type #N$70: Creature 1 Frame 1.
W $6F80,$02,$02 Type #N$71: Creature 1 Frame 2.
W $6F82,$02,$02 Type #N$72: Creature 1 Frame 3.
W $6F84,$02,$02 Type #N$73: Creature 1 Frame 4.
W $6F86,$02,$02 Type #N$74: Creature 2 Frame 1.
W $6F88,$02,$02 Type #N$75: Creature 2 Frame 2.
W $6F8A,$02,$02 Type #N$76: Creature 2 Frame 3.
W $6F8C,$02,$02 Type #N$77: Creature 2 Frame 4.
W $6F8E,$02,$02 Type #N$78: Creature 3 Frame 1.
W $6F90,$02,$02 Type #N$79: Creature 3 Frame 2.
W $6F92,$02,$02 Type #N$7A: Creature 3 Frame 3.
W $6F94,$02,$02 Type #N$7B: Creature 3 Frame 4.
W $6F96,$02,$02 Type #N$7C: Creature 4 Frame 1.
W $6F98,$02,$02 Type #N$7D: Creature 4 Frame 2.
W $6F9A,$02,$02 Type #N$7E: Creature 4 Frame 3.
W $6F9C,$02,$02 Type #N$7F: Creature 4 Frame 4.
W $6F9E,$02,$02 Type #N$80: Burst 4.
W $6FA0,$02,$02 Type #N$81: Burst 3.
W $6FA2,$02,$02 Type #N$82: Burst 2.
W $6FA4,$02,$02 Type #N$83: Burst 1.
W $6FA6,$02,$02 Type #N$84: Burst 1.
W $6FA8,$02,$02 Type #N$85: Burst 2.
W $6FAA,$02,$02 Type #N$86: Burst 3.
W $6FAC,$02,$02 Type #N$87: Burst 4.
W $6FAE,$02,$02 Type #N$88: Ghost Frame 1.
W $6FB0,$02,$02 Type #N$89: Ghost Frame 2.
W $6FB2,$02,$02 Type #N$8A: Ghost Frame 3.
W $6FB4,$02,$02 Type #N$8B: Ghost Frame 2.
W $6FB6,$02,$02 Type #N$8C: Shot 1 Frame 1.
W $6FB8,$02,$02 Type #N$8D: Shot 2 Frame 1.
W $6FBA,$02,$02 Type #N$8E: Shot 3 Frame 1.
W $6FBC,$02,$02 Type #N$8F: Shot 4 Frame 1.
W $6FBE,$02,$02 Type #N$90: Monster 1 Frame 1.
W $6FC0,$02,$02 Type #N$91: Monster 1 Frame 2.
W $6FC2,$02,$02 Type #N$92: Monster 2 Frame 1.
W $6FC4,$02,$02 Type #N$93: Monster 2 Frame 1.
W $6FC6,$02,$02 Type #N$94: Monster 3 Frame 1.
W $6FC8,$02,$02 Type #N$95: Monster 3 Frame 1.
W $6FCA,$02,$02 Type #N$96: Monster 4 Frame 1.
W $6FCC,$02,$02 Type #N$97: Monster 4 Frame 2.
W $6FCE,$02,$02 Type #N$98: Logo Piece 1.
W $6FD0,$02,$02 Type #N$99: Logo Piece 2.
W $6FD2,$02,$02 Type #N$9A: Logo Piece 3.
W $6FD4,$02,$02 Type #N$9B: Logo Piece 4.
W $6FD6,$02,$02 Type #N$9C: Logo Piece 5.
W $6FD8,$02,$02 Type #N$9D: Logo Piece 6.

b $6FDA Sprite: Blank
@ $6FDA label=Sprite_Blank
D $6FDA A sprite with no width and no height, which draws nothing. The sprite is
. used for object types #N$00, #N$01, #N$17 and #N$1F.
B $6FDA,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $6FDB,$01,$01 Height = #N(#PEEK(#PC)) rows.

w $6FDC Strip Graphic Table
@ $6FDC label=StripGraphicTable
D $6FDC The addresses of the four graphics that are drawn for the strips of a
. cell. They are found from the variant of the strip (see #R$6542).
W $6FDC,$08,$02

b $6FE4 Strip Graphic 1
@ $6FE4 label=StripGraphic_1
D $6FE4 The graphic of the strip of a cell for the variants #N$00 and #N$01. It
. is made of a byte for the number of rows, and then two bytes of pixels for
. each row.
B $6FE4,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $6FE5,$14,$02 #STRIPDATA(strip-graphic-1*)

b $6FF9 Strip Graphic 2
@ $6FF9 label=StripGraphic_2
D $6FF9 The graphic of the strip of a cell for the variant #N$02. It is made of
. a byte for the number of rows, and then two bytes of pixels for each row.
B $6FF9,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $6FFA,$14,$02 #STRIPDATA(strip-graphic-2*)

b $700E Strip Graphic 3
@ $700E label=StripGraphic_3
D $700E The graphic of the strip of a cell for the variant #N$03. It is made of
. a byte for the number of rows, and then two bytes of pixels for each row.
B $700E,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $700F,$08,$02 #STRIPDATA(strip-graphic-3*)

b $7017 Sprite: Logo Piece 1
@ $7017 label=Sprite_Logo_Piece_1
D $7017 A piece of the title graphic that is shown at the end of the game (see
. #R$CD10). The sprite is used for object type #N$98.
.
. A sprite is made of a byte for the width in characters (the flags that say
. whether the sprite has been turned round or upside down are in bits 6 and 7),
. a byte for the number of rows, and then the rows with the bottom row first.
. Each row has a pair of bytes for each character, which are the mask and then
. the pixels (see #R$E3FF).
B $7017,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7018,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7019,$D0,$08 #SPRITEDATA(logo-piece-1*)

b $70E9 Sprite: Logo Piece 2
@ $70E9 label=Sprite_Logo_Piece_2
D $70E9 A piece of the title graphic that is shown at the end of the game (see
. #R$CD10). The sprite is used for object type #N$99.
B $70E9,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $70EA,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $70EB,$54,$04 #SPRITEDATA(logo-piece-2*)

b $713F Sprite: Logo Piece 3
@ $713F label=Sprite_Logo_Piece_3
D $713F A piece of the title graphic that is shown at the end of the game (see
. #R$CD10). The sprite is used for object type #N$9A.
B $713F,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7140,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7141,$60,$04 #SPRITEDATA(logo-piece-3*)

b $71A1 Sprite: Logo Piece 4
@ $71A1 label=Sprite_Logo_Piece_4
D $71A1 A piece of the title graphic that is shown at the end of the game (see
. #R$CD10). The sprite is used for object type #N$9B.
B $71A1,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $71A2,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $71A3,$70,$04 #SPRITEDATA(logo-piece-4*)

b $7213 Sprite: Logo Piece 5
@ $7213 label=Sprite_Logo_Piece_5
D $7213 A piece of the title graphic that is shown at the end of the game (see
. #R$CD10). The sprite is used for object type #N$9C.
B $7213,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7214,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7215,$50,$04 #SPRITEDATA(logo-piece-5*)

b $7265 Sprite: Logo Piece 6
@ $7265 label=Sprite_Logo_Piece_6
D $7265 A piece of the title graphic that is shown at the end of the game (see
. #R$CD10). The sprite is used for object type #N$9D.
B $7265,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7266,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7267,$30,$04 #SPRITEDATA(logo-piece-6*)

b $7297 Sprite: Speed Bonus
@ $7297 label=Sprite_Speed_Bonus
D $7297 The bonus that makes the player move faster (see #R$D727). The sprite is
. used for object type #N$02.
B $7297,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7298,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7299,$98,$08 #SPRITEDATA(speed-bonus*)

b $7331 Sprite: Ghost Frame 1
@ $7331 label=Sprite_Ghost_Frame_1
D $7331 A frame of the ghost (see #R$BFF1). The sprite is used for object type
. #N$88.
B $7331,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7332,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7333,$A8,$06 #SPRITEDATA(ghost-frame-1*)

b $73DB Sprite: Ghost Frame 2
@ $73DB label=Sprite_Ghost_Frame_2
D $73DB A frame of the ghost (see #R$BFF1). The sprite is used for object types
. #N$89 and #N$8B.
B $73DB,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $73DC,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $73DD,$D2,$06 #SPRITEDATA(ghost-frame-2*)

b $74AF Sprite: Ghost Frame 3
@ $74AF label=Sprite_Ghost_Frame_3
D $74AF A frame of the ghost (see #R$BFF1). The sprite is used for object type
. #N$8A.
B $74AF,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $74B0,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $74B1,$C0,$06 #SPRITEDATA(ghost-frame-3*)

b $7571 Inventory Item Icons
@ $7571 label=InventoryItemIcons
D $7571 The icons of the items in the inventory tube, with four characters (two
. by two) for each item, in the order of the characters on the screen: the top
. left, top right, bottom left and bottom right. The font pointer is set to
. #N$7571 to print them (see #R$C4A4). The first icon is blank, and the others
. are the items that are numbered from #N$01 (see #R$C489).
B $7571,$120,$08

b $7691 Sprite: Creature 2 Frame 3
@ $7691 label=Sprite_Creature_2_Frame_3
D $7691 A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$76.
B $7691,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7692,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7693,$A2,$06 #SPRITEDATA(creature-2-frame-3*)

b $7735 Sprite: Creature 2 Frame 4
@ $7735 label=Sprite_Creature_2_Frame_4
D $7735 A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$77.
B $7735,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7736,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7737,$A8,$06 #SPRITEDATA(creature-2-frame-4*)

b $77DF Sprite: Creature 3 Frame 3
@ $77DF label=Sprite_Creature_3_Frame_3
D $77DF A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$7A.
B $77DF,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $77E0,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $77E1,$9C,$06 #SPRITEDATA(creature-3-frame-3*)

b $787D Sprite: Creature 3 Frame 4
@ $787D label=Sprite_Creature_3_Frame_4
D $787D A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$7B.
B $787D,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $787E,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $787F,$9C,$06 #SPRITEDATA(creature-3-frame-4*)

b $791B Sprite: Creature 4 Frame 3
@ $791B label=Sprite_Creature_4_Frame_3
D $791B A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$7E.
B $791B,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $791C,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $791D,$A8,$06 #SPRITEDATA(creature-4-frame-3*)

b $79C5 Sprite: Creature 4 Frame 4
@ $79C5 label=Sprite_Creature_4_Frame_4
D $79C5 A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$7F.
B $79C5,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $79C6,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $79C7,$A8,$06 #SPRITEDATA(creature-4-frame-4*)

b $7A6F Status Panel Characters
@ $7A6F label=StatusPanelCharacters
D $7A6F The characters of the icons and the text of the status panel. The font
. pointer is set to the start of each group of characters to print it.
B $7A6F,$40,$08 The eight characters of the compass icon (see #R$C2C8).
@ $7AAF label=CompassTextNorth
B $7AAF,$20,$08 The four characters of the compass text "NORTH" (see #R$C29A).
@ $7ACF label=CompassTextSouth
B $7ACF,$20,$08 The four characters of the compass text "SOUTH".
@ $7AEF label=LifeIconCharacterSet
B $7AEF,$40,$08 The eight characters of the life icon (see #R$CBE4).

b $7B2F Sprite: Burst 1
@ $7B2F label=Sprite_Burst_1
D $7B2F A frame of the burst that shows an object being destroyed (see #R$D7D8).
. The balls (see #R$C164) and the flash of a destroyed monster (see #R$D847) use
. the same frames. The sprite is used for object types #N$0C, #N$83 and #N$84.
B $7B2F,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7B30,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7B31,$40,$04 #SPRITEDATA(burst-1*)

b $7B71 Sprite: Burst 2
@ $7B71 label=Sprite_Burst_2
D $7B71 A frame of the burst that shows an object being destroyed (see #R$D7D8).
. The balls (see #R$C164) and the flash of a destroyed monster (see #R$D847) use
. the same frames. The sprite is used for object types #N$0D, #N$82 and #N$85.
B $7B71,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7B72,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7B73,$40,$04 #SPRITEDATA(burst-2*)

b $7BB3 Sprite: Burst 3
@ $7BB3 label=Sprite_Burst_3
D $7BB3 A frame of the burst that shows an object being destroyed (see #R$D7D8).
. The balls (see #R$C164) and the flash of a destroyed monster (see #R$D847) use
. the same frames. The sprite is used for object types #N$0E, #N$81 and #N$86.
B $7BB3,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7BB4,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7BB5,$40,$04 #SPRITEDATA(burst-3*)

b $7BF5 Sprite: Burst 4
@ $7BF5 label=Sprite_Burst_4
D $7BF5 A frame of the burst that shows an object being destroyed (see #R$D7D8).
. The balls (see #R$C164) and the flash of a destroyed monster (see #R$D847) use
. the same frames. The sprite is used for object types #N$0F, #N$80 and #N$87.
B $7BF5,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7BF6,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7BF7,$40,$04 #SPRITEDATA(burst-4*)

b $7C37 Sprite: Health Bonus
@ $7C37 label=Sprite_Health_Bonus
D $7C37 The bonus that makes the health of the player full (see #R$D74C). The
. sprite is used for object type #N$03.
B $7C37,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7C38,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7C39,$40,$04 #SPRITEDATA(health-bonus*)

b $7C79 Sprite: Monster 3 Frame 2
@ $7C79 label=Sprite_Monster_3_Frame_2
D $7C79 A frame of one of the four kinds of monster (see #R$D94F). The ghosts
. that are shown at the end of the game use the same frames (see #R$CD58). The
. sprite is used for object types #N$6A and #N$6B.
B $7C79,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7C7A,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7C7B,$C6,$06 #SPRITEDATA(monster-3-frame-2*)

b $7D41 Sprite: Monster 1 Frame 1
@ $7D41 label=Sprite_Monster_1_Frame_1
D $7D41 A frame of one of the four kinds of monster (see #R$D94F). The ghosts
. that are shown at the end of the game use the same frames (see #R$CD58). The
. sprite is used for object types #N$60, #N$62 and #N$90.
B $7D41,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7D42,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7D43,$102,$06 #SPRITEDATA(monster-1-frame-1*)

b $7E45 Sprite: Monster 1 Frame 2
@ $7E45 label=Sprite_Monster_1_Frame_2
D $7E45 A frame of one of the four kinds of monster (see #R$D94F). The ghosts
. that are shown at the end of the game use the same frames (see #R$CD58). The
. sprite is used for object types #N$61, #N$63 and #N$91.
B $7E45,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7E46,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7E47,$102,$06 #SPRITEDATA(monster-1-frame-2*)

b $7F49 Sprite: Item 2
@ $7F49 label=Sprite_Item_2
D $7F49 One of the four items that the monsters need (see #R$D942). It is also
. the item when it has been thrown (see #R$D80C). The sprite is used for object
. types #N$05 and #N$09.
B $7F49,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7F4A,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7F4B,$5A,$06 #SPRITEDATA(item-2*)

b $7FA5 Sprite: Item 1
@ $7FA5 label=Sprite_Item_1
D $7FA5 One of the four items that the monsters need (see #R$D942). It is also
. the item when it has been thrown (see #R$D80C). The sprite is used for object
. types #N$04 and #N$08.
B $7FA5,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $7FA6,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7FA7,$72,$06 #SPRITEDATA(item-1*)

b $8019 Sprite: Item 4
@ $8019 label=Sprite_Item_4
D $8019 One of the four items that the monsters need (see #R$D942). It is also
. the item when it has been thrown (see #R$D80C). The sprite is used for object
. types #N$07 and #N$0B.
B $8019,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $801A,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $801B,$5A,$06 #SPRITEDATA(item-4*)

b $8075 Sprite: Item 3
@ $8075 label=Sprite_Item_3
D $8075 One of the four items that the monsters need (see #R$D942). It is also
. the item when it has been thrown (see #R$D80C). The sprite is used for object
. types #N$06 and #N$0A.
B $8075,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8076,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8077,$96,$06 #SPRITEDATA(item-3*)

b $810D Sprite: Monster 4 Frame 1
@ $810D label=Sprite_Monster_4_Frame_1
D $810D A frame of one of the four kinds of monster (see #R$D94F). The ghosts
. that are shown at the end of the game use the same frames (see #R$CD58). The
. sprite is used for object types #N$6C and #N$96.
B $810D,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $810E,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $810F,$CC,$06 #SPRITEDATA(monster-4-frame-1*)

b $81DB Sprite: Creature 1 Frame 3
@ $81DB label=Sprite_Creature_1_Frame_3
D $81DB A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$72.
B $81DB,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $81DC,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $81DD,$C0,$06 #SPRITEDATA(creature-1-frame-3*)

b $829D Sprite: Creature 1 Frame 4
@ $829D label=Sprite_Creature_1_Frame_4
D $829D A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$73.
B $829D,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $829E,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $829F,$BA,$06 #SPRITEDATA(creature-1-frame-4*)

b $8359 Sprite: Shot 1 Frame 1
@ $8359 label=Sprite_Shot_1_Frame_1
D $8359 A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$30, #N$50 and #N$8C.
B $8359,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $835A,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $835B,$34,$04 #SPRITEDATA(shot-1-frame-1*)

b $838F Sprite: Shot 1 Frame 2
@ $838F label=Sprite_Shot_1_Frame_2
D $838F A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$31 and #N$51.
B $838F,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8390,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8391,$34,$04 #SPRITEDATA(shot-1-frame-2*)

b $83C5 Sprite: Shot 1 Frame 3
@ $83C5 label=Sprite_Shot_1_Frame_3
D $83C5 A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$32 and #N$52.
B $83C5,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $83C6,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $83C7,$34,$04 #SPRITEDATA(shot-1-frame-3*)

b $83FB Sprite: Shot 1 Frame 4
@ $83FB label=Sprite_Shot_1_Frame_4
D $83FB A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$33 and #N$53.
B $83FB,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $83FC,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $83FD,$34,$04 #SPRITEDATA(shot-1-frame-4*)

b $8431 Sprite: Shot 2 Frame 1
@ $8431 label=Sprite_Shot_2_Frame_1
D $8431 A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$34, #N$54 and #N$8D.
B $8431,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8432,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8433,$40,$04 #SPRITEDATA(shot-2-frame-1*)

b $8473 Sprite: Shot 2 Frame 2
@ $8473 label=Sprite_Shot_2_Frame_2
D $8473 A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$35, #N$37, #N$55 and #N$57.
B $8473,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8474,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8475,$40,$04 #SPRITEDATA(shot-2-frame-2*)

b $84B5 Sprite: Shot 2 Frame 3
@ $84B5 label=Sprite_Shot_2_Frame_3
D $84B5 A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$36 and #N$56.
B $84B5,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $84B6,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $84B7,$40,$04 #SPRITEDATA(shot-2-frame-3*)

b $84F7 Sprite: Shot 3 Frame 1
@ $84F7 label=Sprite_Shot_3_Frame_1
D $84F7 A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$38, #N$58 and #N$8E.
B $84F7,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $84F8,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $84F9,$40,$04 #SPRITEDATA(shot-3-frame-1*)

b $8539 Sprite: Shot 3 Frame 2
@ $8539 label=Sprite_Shot_3_Frame_2
D $8539 A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$39 and #N$59.
B $8539,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $853A,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $853B,$40,$04 #SPRITEDATA(shot-3-frame-2*)

b $857B Sprite: Shot 3 Frame 3
@ $857B label=Sprite_Shot_3_Frame_3
D $857B A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$3A and #N$5A.
B $857B,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $857C,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $857D,$40,$04 #SPRITEDATA(shot-3-frame-3*)

b $85BD Sprite: Shot 3 Frame 4
@ $85BD label=Sprite_Shot_3_Frame_4
D $85BD A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$3B and #N$5B.
B $85BD,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $85BE,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $85BF,$40,$04 #SPRITEDATA(shot-3-frame-4*)

b $85FF Sprite: Shot 4 Frame 1
@ $85FF label=Sprite_Shot_4_Frame_1
D $85FF A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$3C, #N$5C and #N$8F.
B $85FF,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8600,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8601,$40,$04 #SPRITEDATA(shot-4-frame-1*)

b $8641 Sprite: Shot 4 Frame 2
@ $8641 label=Sprite_Shot_4_Frame_2
D $8641 A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$3D and #N$5D.
B $8641,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8642,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8643,$40,$04 #SPRITEDATA(shot-4-frame-2*)

b $8683 Sprite: Shot 4 Frame 3
@ $8683 label=Sprite_Shot_4_Frame_3
D $8683 A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$3E and #N$5E.
B $8683,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8684,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8685,$40,$04 #SPRITEDATA(shot-4-frame-3*)

b $86C5 Sprite: Shot 4 Frame 4
@ $86C5 label=Sprite_Shot_4_Frame_4
D $86C5 A frame of one of the four kinds of item that appear in the village (see
. #R$D9A3). The same frames are used for the shots that the player fires (see
. #R$D7ED) and for the fragments of a destroyed monster (see #R$D70A). The
. sprite is used for object types #N$3F and #N$5F.
B $86C5,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $86C6,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $86C7,$40,$04 #SPRITEDATA(shot-4-frame-4*)

b $8707 Sprite: Monster 4 Frame 2
@ $8707 label=Sprite_Monster_4_Frame_2
D $8707 A frame of one of the four kinds of monster (see #R$D94F). The ghosts
. that are shown at the end of the game use the same frames (see #R$CD58). The
. sprite is used for object types #N$6D and #N$97.
B $8707,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8708,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8709,$D8,$06 #SPRITEDATA(monster-4-frame-2*)

b $87E1 Sprite: Monster 4 Frame 3
@ $87E1 label=Sprite_Monster_4_Frame_3
D $87E1 A frame of one of the four kinds of monster (see #R$D94F). The ghosts
. that are shown at the end of the game use the same frames (see #R$CD58). The
. sprite is used for object type #N$6E.
B $87E1,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $87E2,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $87E3,$D8,$06 #SPRITEDATA(monster-4-frame-3*)

b $88BB Sprite: Monster 4 Frame 4
@ $88BB label=Sprite_Monster_4_Frame_4
D $88BB A frame of one of the four kinds of monster (see #R$D94F). The ghosts
. that are shown at the end of the game use the same frames (see #R$CD58). The
. sprite is used for object type #N$6F.
B $88BB,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $88BC,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $88BD,$D8,$06 #SPRITEDATA(monster-4-frame-4*)

b $8995 Sprite: Monster 3 Frame 1
@ $8995 label=Sprite_Monster_3_Frame_1
D $8995 A frame of one of the four kinds of monster (see #R$D94F). The ghosts
. that are shown at the end of the game use the same frames (see #R$CD58). The
. sprite is used for object types #N$68, #N$69, #N$94 and #N$95.
B $8995,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8996,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8997,$CC,$06 #SPRITEDATA(monster-3-frame-1*)

b $8A63 Sprite: Spore 3 Frame 1
@ $8A63 label=Sprite_Spore_3_Frame_1
D $8A63 A frame of one of the four kinds of spore (see #R$CE89). The sprite is
. used for object type #N$48.
B $8A63,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8A64,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8A65,$78,$06 #SPRITEDATA(spore-3-frame-1*)

b $8ADD Sprite: Spore 3 Frame 2
@ $8ADD label=Sprite_Spore_3_Frame_2
D $8ADD A frame of one of the four kinds of spore (see #R$CE89). The sprite is
. used for object types #N$49 and #N$4B.
B $8ADD,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8ADE,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8ADF,$78,$06 #SPRITEDATA(spore-3-frame-2*)

b $8B57 Sprite: Spore 3 Frame 3
@ $8B57 label=Sprite_Spore_3_Frame_3
D $8B57 A frame of one of the four kinds of spore (see #R$CE89). The sprite is
. used for object type #N$4A.
B $8B57,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8B58,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8B59,$72,$06 #SPRITEDATA(spore-3-frame-3*)

b $8BCB Sprite: Spore 1 Frame 1
@ $8BCB label=Sprite_Spore_1_Frame_1
D $8BCB A frame of one of the four kinds of spore (see #R$CE89). The sprite is
. used for object type #N$40.
B $8BCB,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8BCC,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8BCD,$66,$06 #SPRITEDATA(spore-1-frame-1*)

b $8C33 Sprite: Spore 1 Frame 2
@ $8C33 label=Sprite_Spore_1_Frame_2
D $8C33 A frame of one of the four kinds of spore (see #R$CE89). The sprite is
. used for object types #N$41 and #N$43.
B $8C33,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8C34,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8C35,$66,$06 #SPRITEDATA(spore-1-frame-2*)

b $8C9B Sprite: Spore 1 Frame 3
@ $8C9B label=Sprite_Spore_1_Frame_3
D $8C9B A frame of one of the four kinds of spore (see #R$CE89). The sprite is
. used for object type #N$42.
B $8C9B,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8C9C,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8C9D,$66,$06 #SPRITEDATA(spore-1-frame-3*)

b $8D03 Sprite: Spore 4 Frame 2
@ $8D03 label=Sprite_Spore_4_Frame_2
D $8D03 A frame of one of the four kinds of spore (see #R$CE89). The sprite is
. used for object types #N$4D and #N$4F.
B $8D03,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8D04,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8D05,$88,$08 #SPRITEDATA(spore-4-frame-2*)

b $8D8D Sprite: Spore 4 Frame 3
@ $8D8D label=Sprite_Spore_4_Frame_3
D $8D8D A frame of one of the four kinds of spore (see #R$CE89). The sprite is
. used for object type #N$4E.
B $8D8D,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8D8E,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8D8F,$78,$08 #SPRITEDATA(spore-4-frame-3*)

b $8E07 Sprite: Spore 4 Frame 1
@ $8E07 label=Sprite_Spore_4_Frame_1
D $8E07 A frame of one of the four kinds of spore (see #R$CE89). The sprite is
. used for object type #N$4C.
B $8E07,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8E08,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8E09,$88,$08 #SPRITEDATA(spore-4-frame-1*)

b $8E91 Sprite: Spore 2 Frame 1
@ $8E91 label=Sprite_Spore_2_Frame_1
D $8E91 A frame of one of the four kinds of spore (see #R$CE89). The sprite is
. used for object type #N$44.
B $8E91,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8E92,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8E93,$72,$06 #SPRITEDATA(spore-2-frame-1*)

b $8F05 Sprite: Spore 2 Frame 2
@ $8F05 label=Sprite_Spore_2_Frame_2
D $8F05 A frame of one of the four kinds of spore (see #R$CE89). The sprite is
. used for object types #N$45 and #N$47.
B $8F05,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8F06,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8F07,$78,$06 #SPRITEDATA(spore-2-frame-2*)

b $8F7F Sprite: Spore 2 Frame 3
@ $8F7F label=Sprite_Spore_2_Frame_3
D $8F7F A frame of one of the four kinds of spore (see #R$CE89). The sprite is
. used for object type #N$46.
B $8F7F,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $8F80,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8F81,$7E,$06 #SPRITEDATA(spore-2-frame-3*)

b $8FFF Sprite: Creature 4 Frame 1
@ $8FFF label=Sprite_Creature_4_Frame_1
D $8FFF A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$7C.
B $8FFF,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9000,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9001,$A8,$06 #SPRITEDATA(creature-4-frame-1*)

b $90A9 Sprite: Creature 4 Frame 2
@ $90A9 label=Sprite_Creature_4_Frame_2
D $90A9 A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$7D.
B $90A9,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $90AA,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $90AB,$A8,$06 #SPRITEDATA(creature-4-frame-2*)

b $9153 Sprite: Creature 3 Frame 2
@ $9153 label=Sprite_Creature_3_Frame_2
D $9153 A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$79.
B $9153,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9154,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9155,$9C,$06 #SPRITEDATA(creature-3-frame-2*)

b $91F1 Sprite: Creature 3 Frame 1
@ $91F1 label=Sprite_Creature_3_Frame_1
D $91F1 A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$78.
B $91F1,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $91F2,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $91F3,$9C,$06 #SPRITEDATA(creature-3-frame-1*)

b $928F Sprite: Creature 2 Frame 2
@ $928F label=Sprite_Creature_2_Frame_2
D $928F A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$75.
B $928F,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9290,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9291,$AE,$06 #SPRITEDATA(creature-2-frame-2*)

b $933F Sprite: Creature 2 Frame 1
@ $933F label=Sprite_Creature_2_Frame_1
D $933F A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$74.
B $933F,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9340,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9341,$AE,$06 #SPRITEDATA(creature-2-frame-1*)

b $93EF Sprite: Creature 1 Frame 1
@ $93EF label=Sprite_Creature_1_Frame_1
D $93EF A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$70.
B $93EF,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $93F0,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $93F1,$BA,$06 #SPRITEDATA(creature-1-frame-1*)

b $94AB Sprite: Creature 1 Frame 2
@ $94AB label=Sprite_Creature_1_Frame_2
D $94AB A frame of one of the four kinds of creature (see #R$C083). The sprite
. is used for object type #N$71.
B $94AB,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $94AC,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $94AD,$BA,$06 #SPRITEDATA(creature-1-frame-2*)

b $9567 Sprite: Monster 2 Frame 1
@ $9567 label=Sprite_Monster_2_Frame_1
D $9567 A frame of one of the four kinds of monster (see #R$D94F). The ghosts
. that are shown at the end of the game use the same frames (see #R$CD58). The
. sprite is used for object types #N$64, #N$65, #N$92 and #N$93.
B $9567,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9568,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9569,$CC,$06 #SPRITEDATA(monster-2-frame-1*)

b $9635 Sprite: Monster 2 Frame 2
@ $9635 label=Sprite_Monster_2_Frame_2
D $9635 A frame of one of the four kinds of monster (see #R$D94F). The ghosts
. that are shown at the end of the game use the same frames (see #R$CD58). The
. sprite is used for object types #N$66 and #N$67.
B $9635,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9636,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9637,$CC,$06 #SPRITEDATA(monster-2-frame-2*)

b $9703 Sprite: Player Body A Frame 2
@ $9703 label=Sprite_Player_Body_A_Frame_2
D $9703 A frame of the body of the player (see #R$DA00). The sprite is used for
. object types #N$21 and #N$25.
B $9703,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9704,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9705,$90,$06 #SPRITEDATA(player-body-a-frame-2*)

b $9795 Sprite: Player Body B Frame 3
@ $9795 label=Sprite_Player_Body_B_Frame_3
D $9795 A frame of the body of the player (see #R$DA00). The sprite is used for
. object types #N$2A and #N$2C.
B $9795,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9796,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9797,$96,$06 #SPRITEDATA(player-body-b-frame-3*)

b $982D Sprite: Player Body A Frame 5
@ $982D label=Sprite_Player_Body_A_Frame_5
D $982D A frame of the body of the player (see #R$DA00). The sprite is used for
. object type #N$26.
B $982D,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $982E,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $982F,$90,$06 #SPRITEDATA(player-body-a-frame-5*)

b $98BF Sprite: Player Body A Frame 1
@ $98BF label=Sprite_Player_Body_A_Frame_1
D $98BF A frame of the body of the player (see #R$DA00). The sprite is used for
. object type #N$20.
B $98BF,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $98C0,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $98C1,$90,$06 #SPRITEDATA(player-body-a-frame-1*)

b $9951 Sprite: Player Body A Frame 4
@ $9951 label=Sprite_Player_Body_A_Frame_4
D $9951 A frame of the body of the player (see #R$DA00). The sprite is used for
. object type #N$23.
B $9951,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9952,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9953,$90,$06 #SPRITEDATA(player-body-a-frame-4*)

b $99E3 Sprite: Player Body A Frame 3
@ $99E3 label=Sprite_Player_Body_A_Frame_3
D $99E3 A frame of the body of the player (see #R$DA00). The sprite is used for
. object types #N$22 and #N$24.
B $99E3,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $99E4,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $99E5,$90,$06 #SPRITEDATA(player-body-a-frame-3*)

b $9A75 Sprite: Player Body B Frame 4
@ $9A75 label=Sprite_Player_Body_B_Frame_4
D $9A75 A frame of the body of the player (see #R$DA00). The sprite is used for
. object type #N$2B.
B $9A75,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9A76,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9A77,$96,$06 #SPRITEDATA(player-body-b-frame-4*)

b $9B0D Sprite: Player Body B Frame 1
@ $9B0D label=Sprite_Player_Body_B_Frame_1
D $9B0D A frame of the body of the player (see #R$DA00). The sprite is used for
. object type #N$28.
B $9B0D,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9B0E,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9B0F,$96,$06 #SPRITEDATA(player-body-b-frame-1*)

b $9BA5 Sprite: Player Body B Frame 2
@ $9BA5 label=Sprite_Player_Body_B_Frame_2
D $9BA5 A frame of the body of the player (see #R$DA00). The sprite is used for
. object types #N$29 and #N$2D.
B $9BA5,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9BA6,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9BA7,$96,$06 #SPRITEDATA(player-body-b-frame-2*)

b $9C3D Sprite: Player Body A Frame 6
@ $9C3D label=Sprite_Player_Body_A_Frame_6
D $9C3D A frame of the body of the player (see #R$DA00). The sprite is used for
. object type #N$27.
B $9C3D,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9C3E,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9C3F,$96,$06 #SPRITEDATA(player-body-a-frame-6*)

b $9CD5 Sprite: Player Body B Frame 5
@ $9CD5 label=Sprite_Player_Body_B_Frame_5
D $9CD5 A frame of the body of the player (see #R$DA00). The sprite is used for
. object type #N$2E.
B $9CD5,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9CD6,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9CD7,$96,$06 #SPRITEDATA(player-body-b-frame-5*)

b $9D6D Sprite: Player Body B Frame 6
@ $9D6D label=Sprite_Player_Body_B_Frame_6
D $9D6D A frame of the body of the player (see #R$DA00). The sprite is used for
. object type #N$2F.
B $9D6D,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9D6E,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9D6F,$96,$06 #SPRITEDATA(player-body-b-frame-6*)

b $9E05 Sprite: Player Bumping Body B
@ $9E05 label=Sprite_Player_Bumping_Body_B
D $9E05 The body of the player when the legs have bumped into something (see
. #R$D9EB). The sprite is used for object type #N$1E.
B $9E05,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9E06,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9E07,$96,$06 #SPRITEDATA(player-bumping-body-b*)

b $9E9D Sprite: Player Bumping Body A
@ $9E9D label=Sprite_Player_Bumping_Body_A
D $9E9D The body of the player when the legs have bumped into something (see
. #R$D9EB). The sprite is used for object type #N$16.
B $9E9D,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9E9E,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9E9F,$90,$06 #SPRITEDATA(player-bumping-body-a*)

b $9F2F Sprite: Player Legs A Frame 4
@ $9F2F label=Sprite_Player_Legs_A_Frame_4
D $9F2F A frame of the legs of the player (see #R$DA7A). The sprite is used for
. object type #N$13.
B $9F2F,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9F30,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9F31,$60,$06 #SPRITEDATA(player-legs-a-frame-4*)

b $9F91 Sprite: Player Legs A Frame 3
@ $9F91 label=Sprite_Player_Legs_A_Frame_3
D $9F91 A frame of the legs of the player (see #R$DA7A). The sprite is used for
. object types #N$12 and #N$14.
B $9F91,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9F92,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9F93,$60,$06 #SPRITEDATA(player-legs-a-frame-3*)

b $9FF3 Sprite: Player Legs A Frame 2
@ $9FF3 label=Sprite_Player_Legs_A_Frame_2
D $9FF3 A frame of the legs of the player (see #R$DA7A). The sprite is used for
. object types #N$11 and #N$15.
B $9FF3,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $9FF4,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9FF5,$60,$06 #SPRITEDATA(player-legs-a-frame-2*)

b $A055 Sprite: Player Legs A Frame 1
@ $A055 label=Sprite_Player_Legs_A_Frame_1
D $A055 A frame of the legs of the player (see #R$DA7A). The sprite is used for
. object type #N$10.
B $A055,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $A056,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $A057,$60,$06 #SPRITEDATA(player-legs-a-frame-1*)

b $A0B7 Sprite: Player Legs B Frame 4
@ $A0B7 label=Sprite_Player_Legs_B_Frame_4
D $A0B7 A frame of the legs of the player (see #R$DA7A). The sprite is used for
. object type #N$1B.
B $A0B7,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $A0B8,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $A0B9,$66,$06 #SPRITEDATA(player-legs-b-frame-4*)

b $A11F Sprite: Player Legs B Frame 3
@ $A11F label=Sprite_Player_Legs_B_Frame_3
D $A11F A frame of the legs of the player (see #R$DA7A). The sprite is used for
. object types #N$1A and #N$1C.
B $A11F,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $A120,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $A121,$66,$06 #SPRITEDATA(player-legs-b-frame-3*)

b $A187 Sprite: Player Legs B Frame 2
@ $A187 label=Sprite_Player_Legs_B_Frame_2
D $A187 A frame of the legs of the player (see #R$DA7A). The sprite is used for
. object types #N$19 and #N$1D.
B $A187,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $A188,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $A189,$66,$06 #SPRITEDATA(player-legs-b-frame-2*)

b $A1EF Sprite: Player Legs B Frame 1
@ $A1EF label=Sprite_Player_Legs_B_Frame_1
D $A1EF A frame of the legs of the player (see #R$DA7A). The sprite is used for
. object type #N$18.
B $A1EF,$01,$01 Width = #N(#PEEK(#PC)&$0F) characters.
B $A1F0,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $A1F1,$66,$06 #SPRITEDATA(player-legs-b-frame-1*)

b $A257 Wall Strip 00
@ $A257 label=WallStrip_00
D $A257 The graphic of the strip of wall numbers #N$00 and #N$2A. It is made of
. a byte for the number of rows, and then two bytes of pixels for each row,
. which are the left and the right eight pixels. The graphic is drawn with a
. mask by #R$D425.
B $A257,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A258,$70,$02 #STRIPDATA(wall-strip-00*)

b $A2C8 Wall Strip 01
@ $A2C8 label=WallStrip_01
D $A2C8 The graphic of the strip of wall number #N$01. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A2C8,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A2C9,$70,$02 #STRIPDATA(wall-strip-01*)

b $A339 Wall Strip 02
@ $A339 label=WallStrip_02
D $A339 The graphic of the strip of wall number #N$02. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A339,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A33A,$70,$02 #STRIPDATA(wall-strip-02*)

b $A3AA Wall Strip 03
@ $A3AA label=WallStrip_03
D $A3AA The graphic of the strip of wall number #N$03. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A3AA,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A3AB,$70,$02 #STRIPDATA(wall-strip-03*)

b $A41B Wall Strip 2F
@ $A41B label=WallStrip_2F
D $A41B The graphic of the strip of wall number #N$2F. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A41B,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A41C,$80,$02 #STRIPDATA(wall-strip-2f*)

b $A49C Wall Strip 30
@ $A49C label=WallStrip_30
D $A49C The graphic of the strip of wall number #N$30. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A49C,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A49D,$80,$02 #STRIPDATA(wall-strip-30*)

b $A51D Wall Strip 04
@ $A51D label=WallStrip_04
D $A51D The graphic of the strip of wall number #N$04. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A51D,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A51E,$70,$02 #STRIPDATA(wall-strip-04*)

b $A58E Wall Strip 05
@ $A58E label=WallStrip_05
D $A58E The graphic of the strip of wall number #N$05. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A58E,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A58F,$80,$02 #STRIPDATA(wall-strip-05*)

b $A60F Wall Strip 06
@ $A60F label=WallStrip_06
D $A60F The graphic of the strip of wall number #N$06. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A60F,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A610,$80,$02 #STRIPDATA(wall-strip-06*)

b $A690 Wall Strip 07
@ $A690 label=WallStrip_07
D $A690 The graphic of the strip of wall number #N$07. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A690,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A691,$80,$02 #STRIPDATA(wall-strip-07*)

b $A711 Wall Strip 08
@ $A711 label=WallStrip_08
D $A711 The graphic of the strip of wall number #N$08. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A711,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A712,$80,$02 #STRIPDATA(wall-strip-08*)

b $A792 Wall Strip 09
@ $A792 label=WallStrip_09
D $A792 The graphic of the strip of wall number #N$09. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A792,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A793,$80,$02 #STRIPDATA(wall-strip-09*)

b $A813 Wall Strip 0A
@ $A813 label=WallStrip_0A
D $A813 The graphic of the strip of wall number #N$0A. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A813,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A814,$80,$02 #STRIPDATA(wall-strip-0a*)

b $A894 Wall Strip 0B
@ $A894 label=WallStrip_0B
D $A894 The graphic of the strip of wall number #N$0B. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A894,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A895,$80,$02 #STRIPDATA(wall-strip-0b*)

b $A915 Wall Strip 0C
@ $A915 label=WallStrip_0C
D $A915 The graphic of the strip of wall number #N$0C. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A915,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A916,$80,$02 #STRIPDATA(wall-strip-0c*)

b $A996 Wall Strip 0D
@ $A996 label=WallStrip_0D
D $A996 The graphic of the strip of wall number #N$0D. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $A996,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $A997,$80,$02 #STRIPDATA(wall-strip-0d*)

b $AA17 Wall Strip 0E
@ $AA17 label=WallStrip_0E
D $AA17 The graphic of the strip of wall number #N$0E. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $AA17,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $AA18,$80,$02 #STRIPDATA(wall-strip-0e*)

b $AA98 Wall Strip 0F
@ $AA98 label=WallStrip_0F
D $AA98 The graphic of the strip of wall number #N$0F. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $AA98,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $AA99,$80,$02 #STRIPDATA(wall-strip-0f*)

b $AB19 Wall Strip 10
@ $AB19 label=WallStrip_10
D $AB19 The graphic of the strip of wall number #N$10. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $AB19,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $AB1A,$80,$02 #STRIPDATA(wall-strip-10*)

b $AB9A Wall Strip 11
@ $AB9A label=WallStrip_11
D $AB9A The graphic of the strip of wall number #N$11. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $AB9A,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $AB9B,$80,$02 #STRIPDATA(wall-strip-11*)

b $AC1B Wall Strip 12
@ $AC1B label=WallStrip_12
D $AC1B The graphic of the strip of wall number #N$12. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $AC1B,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $AC1C,$80,$02 #STRIPDATA(wall-strip-12*)

b $AC9C Wall Strip 13
@ $AC9C label=WallStrip_13
D $AC9C The graphic of the strip of wall number #N$13. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $AC9C,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $AC9D,$80,$02 #STRIPDATA(wall-strip-13*)

b $AD1D Wall Strip 14
@ $AD1D label=WallStrip_14
D $AD1D The graphic of the strip of wall number #N$14. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $AD1D,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $AD1E,$80,$02 #STRIPDATA(wall-strip-14*)

b $AD9E Wall Strip 16
@ $AD9E label=WallStrip_16
D $AD9E The graphic of the strip of wall number #N$16. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $AD9E,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $AD9F,$70,$02 #STRIPDATA(wall-strip-16*)

b $AE0F Wall Strip 15
@ $AE0F label=WallStrip_15
D $AE0F The graphic of the strip of wall number #N$15. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $AE0F,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $AE10,$80,$02 #STRIPDATA(wall-strip-15*)

b $AE90 Wall Strip 18
@ $AE90 label=WallStrip_18
D $AE90 The graphic of the strip of wall number #N$18. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $AE90,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $AE91,$80,$02 #STRIPDATA(wall-strip-18*)

b $AF11 Wall Strip 19
@ $AF11 label=WallStrip_19
D $AF11 The graphic of the strip of wall number #N$19. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $AF11,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $AF12,$80,$02 #STRIPDATA(wall-strip-19*)

b $AF92 Wall Strip 32
@ $AF92 label=WallStrip_32
D $AF92 The graphic of the strip of wall number #N$32. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $AF92,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $AF93,$80,$02 #STRIPDATA(wall-strip-32*)

b $B013 Wall Strip 33
@ $B013 label=WallStrip_33
D $B013 The graphic of the strip of wall number #N$33. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B013,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B014,$80,$02 #STRIPDATA(wall-strip-33*)

b $B094 Wall Strip 17
@ $B094 label=WallStrip_17
D $B094 The graphic of the strip of wall number #N$17. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B094,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B095,$80,$02 #STRIPDATA(wall-strip-17*)

b $B115 Wall Strip 1A
@ $B115 label=WallStrip_1A
D $B115 The graphic of the strip of wall number #N$1A. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B115,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B116,$80,$02 #STRIPDATA(wall-strip-1a*)

b $B196 Wall Strip 1B
@ $B196 label=WallStrip_1B
D $B196 The graphic of the strip of wall number #N$1B. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B196,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B197,$80,$02 #STRIPDATA(wall-strip-1b*)

b $B217 Wall Strip 1C
@ $B217 label=WallStrip_1C
D $B217 The graphic of the strip of wall number #N$1C. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B217,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B218,$80,$02 #STRIPDATA(wall-strip-1c*)

b $B298 Wall Strip 1E
@ $B298 label=WallStrip_1E
D $B298 The graphic of the strip of wall number #N$1E. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B298,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B299,$80,$02 #STRIPDATA(wall-strip-1e*)

b $B319 Wall Strip 1D
@ $B319 label=WallStrip_1D
D $B319 The graphic of the strip of wall number #N$1D. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B319,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B31A,$80,$02 #STRIPDATA(wall-strip-1d*)

b $B39A Wall Strip 1F
@ $B39A label=WallStrip_1F
D $B39A The graphic of the strip of wall number #N$1F. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B39A,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B39B,$70,$02 #STRIPDATA(wall-strip-1f*)

b $B40B Wall Strip 20
@ $B40B label=WallStrip_20
D $B40B The graphic of the strip of wall number #N$20. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B40B,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B40C,$80,$02 #STRIPDATA(wall-strip-20*)

b $B48C Wall Strip 21
@ $B48C label=WallStrip_21
D $B48C The graphic of the strip of wall number #N$21. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B48C,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B48D,$70,$02 #STRIPDATA(wall-strip-21*)

b $B4FD Wall Strip 22
@ $B4FD label=WallStrip_22
D $B4FD The graphic of the strip of wall number #N$22. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B4FD,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B4FE,$70,$02 #STRIPDATA(wall-strip-22*)

b $B56E Wall Strip 23
@ $B56E label=WallStrip_23
D $B56E The graphic of the strip of wall number #N$23. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B56E,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B56F,$70,$02 #STRIPDATA(wall-strip-23*)

b $B5DF Wall Strip 24
@ $B5DF label=WallStrip_24
D $B5DF The graphic of the strip of wall number #N$24. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B5DF,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B5E0,$70,$02 #STRIPDATA(wall-strip-24*)

b $B650 Wall Strip 25
@ $B650 label=WallStrip_25
D $B650 The graphic of the strip of wall number #N$25. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B650,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B651,$70,$02 #STRIPDATA(wall-strip-25*)

b $B6C1 Wall Strip 26
@ $B6C1 label=WallStrip_26
D $B6C1 The graphic of the strip of wall number #N$26. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B6C1,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B6C2,$70,$02 #STRIPDATA(wall-strip-26*)

b $B732 Wall Strip 27
@ $B732 label=WallStrip_27
D $B732 The graphic of the strip of wall number #N$27. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B732,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B733,$70,$02 #STRIPDATA(wall-strip-27*)

b $B7A3 Wall Strip 28
@ $B7A3 label=WallStrip_28
D $B7A3 The graphic of the strip of wall number #N$28. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B7A3,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B7A4,$70,$02 #STRIPDATA(wall-strip-28*)

b $B814 Wall Strip 29
@ $B814 label=WallStrip_29
D $B814 The graphic of the strip of wall number #N$29. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B814,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B815,$70,$02 #STRIPDATA(wall-strip-29*)

b $B885 Wall Strip 2B
@ $B885 label=WallStrip_2B
D $B885 The graphic of the strip of wall number #N$2B. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B885,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B886,$80,$02 #STRIPDATA(wall-strip-2b*)

b $B906 Wall Strip 2C
@ $B906 label=WallStrip_2C
D $B906 The graphic of the strip of wall number #N$2C. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B906,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B907,$80,$02 #STRIPDATA(wall-strip-2c*)

b $B987 Wall Strip 2D
@ $B987 label=WallStrip_2D
D $B987 The graphic of the strip of wall number #N$2D. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $B987,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $B988,$80,$02 #STRIPDATA(wall-strip-2d*)

b $BA08 Wall Strip 2E
@ $BA08 label=WallStrip_2E
D $BA08 The graphic of the strip of wall number #N$2E. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $BA08,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $BA09,$80,$02 #STRIPDATA(wall-strip-2e*)

b $BA89 Wall Strip 31
@ $BA89 label=WallStrip_31
D $BA89 The graphic of the strip of wall number #N$31. It is made of a byte for
. the number of rows, and then two bytes of pixels for each row, which are the
. left and the right eight pixels. The graphic is drawn with a mask by #R$D425.
B $BA89,$01,$01 Height = #N(#PEEK(#PC)) pixels.
B $BA8A,$80,$02 #STRIPDATA(wall-strip-31*)


b $BB0A Border Characters
@ $BB0A label=BorderCharacters
D $BB0A The twenty characters that draw the border around the playing area and
. the frame of the menu (see #R$CA55 and #R$CA9D). The font pointer is set to
. this address to print them.
B $BB0A,$A0,$08

g $BBAA Random Seed
@ $BBAA label=RandomSeed
D $BBAA The seed of the random number generator, which is updated by #R$C5BB.
. The two bytes are also used one at a time as two random numbers. It is kept
. when a new game is started after a game over (see #R$BE0F).
W $BBAA,$02,$02

g $BBAC Font Pointer
@ $BBAC label=FontPointer
D $BBAC The address that is used for the graphics of the characters that are
. printed by #R$CB19: the graphic of a character is at this address plus eight
. times the code of the character. It is kept when a new game is started after a
. game over (see #R$BE0F).
W $BBAC,$02,$02

g $BBAE Saved Stack Pointer
@ $BBAE label=SavedStackPointer
D $BBAE Holds the stack pointer while a routine uses the stack to move data
. around quickly (for example #R$E148). It is kept when a new game is started
. after a game over (see #R$BE0F).
W $BBAE,$02,$02

g $BBB0 Game Options
@ $BBB0 label=GameOptions
D $BBB0 The options that are chosen on the game selection menu (see #R$C8CA). It
. is kept when a new game is started after a game over (see #R$BE0F).
.
. #TABLE(default,centre,centre)
. { =h Bits | =h Option }
. { #N$00 | Keyboard (bits 1 and 2) }
. { #N$02 | Kempston joystick (bits 1 and 2) }
. { #N$04 | Cursor joystick (bits 1 and 2) }
. { #N$06 | Sinclair joystick (bits 1 and 2) }
. { Bit 3 | Directional control, when set }
. TABLE#
B $BBB0,$01,$01

g $BBB1 Previous Game Options
@ $BBB1 label=PreviousGameOptions
D $BBB1 The options as they were before the last key was read by the game
. selection menu, so that the tune can be played when an option has changed. It
. is kept when a new game is started after a game over (see #R$BE0F).
B $BBB1,$01,$01

g $BBB2 Frame Counter
@ $BBB2 label=FrameCounter
D $BBB2 Counts the frames of the game. It starts from the low word of the system
. variable #SKOOLKID$5C78(FRAMES), and is also used to make random numbers (see
. #R$C5B4 and #R$C5BB). It is kept when a new game is started after a game over
. (see #R$BE0F).
W $BBB2,$02,$02

g $BBB4 Cell Column
@ $BBB4 label=CellColumn
D $BBB4 The column of the map of the cell that is being drawn, which #R$D564
. keeps for #R$D508.
B $BBB4,$01,$01

g $BBB5 Cell Row
@ $BBB5 label=CellRow
D $BBB5 The row of the map of the cell that is being drawn, which #R$D564 keeps
. for #R$D508.
B $BBB5,$01,$01

g $BBB6 Screen X Position
@ $BBB6 label=ScreenXPosition
D $BBB6 The position along the X axis of the screen of the corner of the cell or
. of the object that #R$D508 or #R$D4F3 last worked out.
W $BBB6,$02,$02

g $BBB8 Screen Y Position
@ $BBB8 label=ScreenYPosition
D $BBB8 The position along the Y axis of the screen of the corner of the cell or
. of the object that #R$D508 or #R$D4F3 last worked out.
W $BBB8,$02,$02

g $BBBA View Rotated Flag
@ $BBBA label=ViewRotatedFlag
D $BBBA Holds #N$01 when the view has been turned round, and #N$00 when it has
. not (see #R$DB68).
B $BBBA,$01,$01

g $BBBB Drawn Columns
@ $BBBB label=DrawnColumns
D $BBBB A bit for each of the sixteen columns of the view, which is set when the
. column has been drawn with strips of wall, or is outside the view. #R$CF08
. stops drawing the view when all of the bits are set.
W $BBBB,$02,$02

g $BBBD Key Held Flag
@ $BBBD label=KeyHeldFlag
D $BBBD Holds #N$01 while the key that turns the view is being held down (see
. #R$DB68). The game selection menu also uses it for the key that changes
. directional control (see #R$C8CA).
B $BBBD,$01,$01

g $BBBE Maximum Speed
@ $BBBE label=MaximumSpeed
D $BBBE The speed that the player works up to when moving forward. It is #N$0A,
. and it is #N$12 while a speed bonus lasts (see #R$D727).
B $BBBE,$01,$01

g $BBBF Menu Frame Drawn Flag
@ $BBBF label=MenuFrameDrawnFlag
D $BBBF Holds #N$01 when the frame of the game selection menu has been drawn
. (see #R$CA2B).
B $BBBF,$01,$01

g $BBC0 Wall Tile
@ $BBC0 label=WallTile
D $BBC0 The tile of the cell with walls that is being drawn, which decides the
. colour of its walls (see #R$D372).
B $BBC0,$01,$01

g $BBC1 Tune Played Flag
@ $BBC1 label=TunePlayedFlag
D $BBC1 Has bit 0 set when #R$C63D has played a tune, so that it plays it only
. once.
B $BBC1,$01,$01

g $BBC2 Characters To Draw
@ $BBC2 label=CharactersToDraw
D $BBC2 The number of characters in each row of the sprite that #R$E3FF is
. drawing, which is the width of the sprite, and one more when the sprite has to
. be shifted.
B $BBC2,$01,$01

g $BBC3 Rows To Draw
@ $BBC3 label=RowsToDraw
D $BBC3 The number of rows of the sprite that #R$E3FF is drawing.
B $BBC3,$01,$01

g $BBC4 Chosen Object Position
@ $BBC4 label=ChosenObjectPosition
D $BBC4 The position in the list of objects at #R$D15D of the object that
. #R$CFF2 has chosen to draw next.
W $BBC4,$02,$02

g $BBC6 Compared Object Position
@ $BBC6 label=ComparedObjectPosition
D $BBC6 The position in the list of objects at #R$D15D of the object that
. #R$CFF2 is comparing with the chosen object.
W $BBC6,$02,$02

g $BBC8 Throw Timer
@ $BBC8 label=ThrowTimer
D $BBC8 The number of frames that are left before another item can be thrown
. (see #R$DAB7).
B $BBC8,$01,$01

g $BBC9 Score
@ $BBC9 label=Score
D $BBC9 The score, as three bytes of BCD with the highest first, which are
. followed by a fourth byte that is always zero. The score is printed with those
. two zeroes at the end, so it is in hundreds (see #R$C2ED and #R$C2FF).
B $BBC9,$02,$02 The highest two bytes.
@ $BBCB label=Score_Lowest
B $BBCB,$01,$01 The lowest byte.
B $BBCC,$01,$01 Always zero.

g $BBCD Lives
@ $BBCD label=Lives
D $BBCD The number of lives that are left after the one that is being played. It
. is #N$06 when the game starts, and it goes down by one as each life starts
. (see #R$CBC5).
B $BBCD,$01,$01

g $BBCE Items Left
@ $BBCE label=ItemsLeft
D $BBCE The number of items that are left to be found on each kind of tile, for
. the tiles #N$00 to #N$23. An item appears in the village when the player
. stands on a tile that has some left (see #R$C5CE), and it is added back when
. the item is lost again (see #R$D9A3).
B $BBCE,$02,$02 Tiles #N$00 and #N$01, which never have any.
@ $BBD0 label=ItemsLeft_Tiles
B $BBD0,$22,$11 Tiles #N$02 to #N$23, which are filled in with random numbers
. from #N$10 to #N$1F when the game starts (see #R$C1DB).

g $BBF2 Mirror Flag
@ $BBF2 label=MirrorFlag
D $BBF2 Holds #N$01 when the strips that are being drawn are to be mirrored, and
. #N$00 when they are not (see #R$D1FA).
B $BBF2,$01,$01

g $BBF3 Health
@ $BBF3 label=Health
D $BBF3 The health of the player, which is #N$03 when a life starts or the
. health is made full. The life ends when it reaches zero (see #R$CEBF).
B $BBF3,$01,$01

g $BBF4 Last Shot Used
@ $BBF4 label=LastShotUsed
D $BBF4 Which of the two shots was used last, as #N$00 or #N$10 (see #R$DAB7).
B $BBF4,$01,$01

g $BBF5 Speed Bonus Timer
@ $BBF5 label=SpeedBonusTimer
D $BBF5 The number of frames that the speed bonus has left, which is set to
. #N$FF when the player collects a speed bonus (see #R$D727).
B $BBF5,$01,$01

g $BBF6 Last Cell Visited
@ $BBF6 label=LastCellVisited
D $BBF6 The last cell of the village that was visited, with the column in the
. first byte and the row in the second (see #R$BF48).
B $BBF6,$01,$01 Column.
B $BBF7,$01,$01 Row.

g $BBF8 Step Counter
@ $BBF8 label=StepCounter
D $BBF8 Counts the steps of the player, which is used to make the sound of the
. player walking (see #R$C400).
B $BBF8,$01,$01

g $BBF9 Note Counter
@ $BBF9 label=NoteCounter
D $BBF9 The number of notes of the sound effect that are left to be played (see
. #R$C3BD). A sound effect is started by setting the note counter and the sound
. number together.
B $BBF9,$01,$01

g $BBFA Sound Number
@ $BBFA label=SoundNumber
D $BBFA The number of the sound effect that is playing, which is an index into
. the table at #R$C3D8.
B $BBFA,$01,$01

g $BBFB Flash Colour
@ $BBFB label=FlashColour
D $BBFB The paper colour (in bits 3 to 5) that the playing area is flashed with
. on this frame, which is set by #R$D847 when a monster has been destroyed. It
. is cleared at the end of every frame (see #R$BEDD).
B $BBFB,$01,$01

g $BBFC Previous Flash Colour
@ $BBFC label=PreviousFlashColour
D $BBFC A copy of the flash colour from the last frame, which is added to the
. attributes that are made on this frame.
B $BBFC,$01,$01

g $BBFD Percentage Hundreds
@ $BBFD label=PercentageHundreds
D $BBFD The hundreds digit of the percentage of the game that has been completed
. (see #R$BEDF).
B $BBFD,$01,$01

g $BBFE Percentage Tens And Units
@ $BBFE label=PercentageTensAndUnits
D $BBFE The tens and units digits of the percentage of the game that has been
. completed, as BCD (see #R$BEDF).
B $BBFE,$01,$01

g $BBFF Game Finished Flag
@ $BBFF label=GameFinishedFlag
D $BBFF Holds #N$01 when the game has been finished.
B $BBFF,$01,$01

g $BC00 Ending Attribute
@ $BC00 label=EndingAttribute
D $BC00 The attribute that the piece of the title graphic or the ghost is drawn
. with at the end of the game (see #R$CD10 and #R$CD58).
B $BC00,$01,$01

g $BC01 Controls
@ $BC01 label=Controls
D $BC01 The controls that are being used, as read by #R$E241.
.
. #TABLE(default,centre,centre)
. { =h Bit | =h Control }
. { #N$00 | Left }
. { #N$01 | Right }
. { #N$02 | Forward }
. { #N$03 | Fire }
. { #N$04 | Down }
. { #N$05 | Turn the view }
. TABLE#
B $BC01,$01,$01

g $BC02 Materialise Timer
@ $BC02 label=MaterialiseTimer
D $BC02 The timer for the player appearing at the start of a life, which is set
. to #N$28 (see #R$CBC5) and is made larger by two on each frame until it
. reaches #N$70 (see #R$DA7A).
B $BC02,$01,$01

g $BC03 Inventory
@ $BC03 label=Inventory
D $BC03 The eleven places in the inventory tube. A place holds the number of the
. item that is in it, or zero if there is nothing there (see #R$C489).
B $BC03,$0A,$0A The first ten places.
@ $BC0D label=Inventory_Last
B $BC0D,$01,$01 The last place.

g $BC0E Visited Cells
@ $BC0E label=VisitedCells
D $BC0E A bit for each of the cells of the village, which is set once the player
. has visited the cell (see #R$BF48). There are four bytes for each row.
B $BC0E,$80,$04

g $BC8E Object Table
@ $BC8E label=ObjectTable
D $BC8E The table of objects, which holds everything that moves in the village.
. There are #N$17 objects of #N$10 bytes each, and #R$BE71 updates them in turn.
.
. The type of an object chooses the routine that updates it (see #R$D599) and
. the sprite that draws it (see #R$6E9E). An object of type #N$00 is not in use.
.
. #TABLE(default,centre,centre)
. { =h Byte | =h Contents }
. { #N$00 | Type }
. { #N$01 | Position along the X axis within the cell }
. { #N$02 | Column of the cell }
. { #N$03 | Position along the Y axis within the cell }
. { #N$04 | Row of the cell }
. { #N$05 | Speed (or the kind of tile, for an item) }
. { #N$06 | Direction (bits 6 and 7) and timer (bits 0 to 5) }
. { #N$07 | Flags }
. { #N$08 | Half of the width }
. { #N$09 | Half of the depth }
. { #N$0A | Velocity along the X axis }
. { #N$0B | Velocity along the Y axis }
. { #N$0C | Offset of the sprite along the X axis }
. { #N$0D | Offset of the sprite along the Y axis }
. { #N$0E | Screen position of the sprite, low byte }
. { #N$0F | Screen position of the sprite, high byte }
. TABLE#
.
. The flags are bit 0 (the object has hit something), bit 1 (the object has been
. drawn), bit 5 (the object chases the player) and bits 6 and 7 (the sprite is
. to be turned round and upside down, see #R$E353).
B $BC8E,$10,$10 The legs of the player.
B $BC9E,$10,$10 The body of the player.
@ $BCAE label=ObjectTable_Shots
B $BCAE,$10,$10 The first of the two shots.
B $BCBE,$10,$10 The second of the two shots.
@ $BCCE label=ObjectTable_Items
B $BCCE,$10,$10 Item or fragment 1 of 4.
B $BCDE,$10,$10 Item or fragment 2 of 4.
B $BCEE,$10,$10 Item or fragment 3 of 4.
B $BCFE,$10,$10 Item or fragment 4 of 4.
@ $BD0E label=ObjectTable_Bonus
B $BD0E,$10,$10 The bonus.
@ $BD1E label=ObjectTable_MonsterItems
B $BD1E,$10,$10 The item that monster 1 needs.
B $BD2E,$10,$10 The item that monster 2 needs.
B $BD3E,$10,$10 The item that monster 3 needs.
B $BD4E,$10,$10 The item that monster 4 needs.
@ $BD5E label=ObjectTable_Monsters
B $BD5E,$10,$10 Monster 1.
B $BD6E,$10,$10 Monster 2.
B $BD7E,$10,$10 Monster 3.
B $BD8E,$10,$10 Monster 4.
@ $BD9E label=ObjectTable_Transient
B $BD9E,$10,$10 Short-lived object 1 of 6.
B $BDAE,$10,$10 Short-lived object 2 of 6.
B $BDBE,$10,$10 Short-lived object 3 of 6.
B $BDCE,$10,$10 Short-lived object 4 of 6.
B $BDDE,$10,$10 Short-lived object 5 of 6.
B $BDEE,$10,$10 Short-lived object 6 of 6.


c $BDFE Start Game
@ $BDFE label=StartGame
D $BDFE Checks that the game was started by the tape loader, clears the game
. variables, shows the game selection menu, sets up the status panel and the
. first life, and then falls into the main loop.
.
. The first check is part of the copy protection: the game returns to BASIC
. if the high byte of the system variable FRAMES is not #N$63 (the loader
. arranges for it to be). The routine at #R$C1DB makes a second check on the
. memory refresh register.
.
. #PUSHS #UDGTABLE { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$BE2D,stop=$BE71)
. #SIM(start=$BE71,stop=$BECD)
. #SIM(start=$BECD,stop=$BED0)
. #SCR$02(start-game) } UDGTABLE# #POPS
N $BDFE Check that the game was started by the tape loader.
  $BDFE,$06 Return if the high byte of the system variable FRAMES (#N$5C79)
. is not #N$63.
N $BE04 Clear the game variables.
  $BE04,$03 Set the stack pointer to #N$5E00, so that the stack grows down
. from the start of the game.
  $BE07,$03 Point at the start of the game variables (#R$BBAA).
  $BE0A,$03 Set the number of bytes to clear to #N$0254.
  $BE0D,$02 Jump to #R$BE15.
@ $BE0F label=StartGame_KeepSettings
N $BE0F Starting a new game after a game over keeps the random seed, the font
. pointer, the stack pointer and the control settings at the start of the game
. variables.
B $BE0F,$06 Instructions skipped when starting from scratch: load #REGhl with
. #R$BBB4 and #REGbc with #N$024A.
@ $BE15 label=StartGame_Clear
  $BE15,$03 Clear the game variables.
N $BE18 Seed the random number generator and show the game selection menu.
  $BE18,$03 Fetch the low word of the system variable FRAMES.
  $BE1B,$03 Use it as the starting value of the frame counter.
  $BE1E,$03 Clear the screen.
  $BE21,$03 Build the pixel shifting tables used when drawing sprites.
  $BE24,$03 Show the game selection menu.
  $BE27,$03 Point at the notes of the start-of-game tune.
  $BE2A,$03 Play the tune.
N $BE2D Draw the status panel around the playing area.
  $BE2D,$03 Clear the screen.
  $BE30,$03 Draw the border of the playing area.
  $BE33,$03 Draw the inventory tube.
  $BE36,$03 Set the screen position of the word "SCORE" (#N$0F38).
  $BE39,$03 Point at the text "SCORE".
  $BE3C,$03 Print "SCORE".
  $BE3F,$03 Print the score.
  $BE42,$03 Draw the compass icon.
  $BE45,$03 Draw the compass text.
  $BE48,$03 Clear the playing area.
N $BE4B Set up the first life.
  $BE4B,$05 Set the player's speed to #N$0A.
  $BE50,$03 Fetch the opcode of the instruction at #R$BEDD (#N$18).
  $BE53,$04 Divide it by four to get six lives.
  $BE57,$03 Set the number of lives.
  $BE5A,$03 Choose a random starting position for the player.
  $BE5D,$05 Set the direction that the player starts facing.
  $BE62,$03 Start the player's first life.
  $BE65,$03 Place the four monsters in the village.
  $BE68,$03 Place the starting items in the village.
  $BE6B,$03 Draw the icons of the four monsters in the status panel.
  $BE6E,$03 Build the table of random values.
@ $BE71 label=MainLoop
N $BE71 The main loop. Each pass updates every object, draws the view, and
. then checks for the game being paused.
  $BE71,$04 Start with the first object, which is the player.
@ $BE75 label=MainLoop_UpdateObjects
  $BE75,$03 Fetch the type of the object.
  $BE78,$03 Point at the table of routines that handle each type of object.
  $BE7B,$03 Run the routine that handles this type of object.
  $BE7E,$03 Update the random number generator.
  $BE81,$03 Set the size of an object to #N$0010 bytes.
  $BE84,$02 Move on to the next object.
  $BE86,$03 Get the address of the next object.
  $BE89,$03 Point at the end of the object table.
  $BE8C,$03 Subtract the end of the object table from the address of the next
. object.
  $BE8F,$02 Jump back to #R$BE75 until every object has been updated.
N $BE91 Run the once-per-frame updates.
  $BE91,$03 Increase the frame counter and update the random number generator.
  $BE94,$07 Jump to #R$BECD if the game has finished (the flag at #R$BBFF is
. set), skipping the rest of the frame.
  $BE9B,$03 Update the creatures that chase the player.
  $BE9E,$03 Update the shots fired at the player.
  $BEA1,$03 Spawn a new creature if it is time to do so.
  $BEA4,$03 Update the ghost.
  $BEA7,$03 Play the next note of the current sound effect.
  $BEAA,$03 Update the items shown in the inventory tube.
  $BEAD,$03 Draw the view of the village into the screen buffer.
N $BEB0 Colour the area around the player according to the player's health.
  $BEB0,$03 Fetch the player's health.
  $BEB3,$03 Point at the table of attribute colours.
  $BEB6,$03 Add the health to the address to point at its colour.
  $BEB9,$01 Fetch the attribute.
  $BEBA,$01 Switch to the shadow #REGaf to hold the attribute.
  $BEBB,$03 Set the position of the player's feet on the screen (#N$7070).
  $BEBE,$03 Get the address in the attribute buffer for this position.
  $BEC1,$02 Set the width of the area to #N$04 attributes.
  $BEC3,$01 Fetch the attribute.
  $BEC4,$03 Colour the attributes.
  $BEC7,$03 Check whether the player has lost a life.
  $BECA,$03 Check whether the player has beaten all four monsters.
@ $BECD label=MainLoop_Redraw
N $BECD Update the screen and check for the pause key.
  $BECD,$03 Copy the screen buffer onto the screen.
  $BED0,$03 Fetch the flag at #R$BBFB.
  $BED3,$03 Keep a copy of it for the next frame in #R$BBFC.
  $BED6,$01 Clear the accumulator.
  $BED7,$03 Reset the flag.
  $BEDA,$03 Check whether the game has been paused.
  $BEDD,$02 Jump back to #R$BE71 for the next frame.

c $BEDF Calculate Percentage Complete
@ $BEDF label=CalculatePercentage
D $BEDF Works out how much of the game has been completed and stores it as a
. percentage in #R$BBFD (the hundreds digit) and #R$BBFE (the tens and units,
. as BCD).
.
. Every bit set in the #N$80 bytes at #R$BC0E is a cell of the village that has
. been visited. Every monster that has been killed counts as three more
. cells. The total is multiplied by #N$2830 and divided by #N$010000, so that
. visiting about #N$027D cells (or a few less when monsters have been killed)
. gives #N$64 percent.
N $BEDF Count the visited cells.
  $BEDF,$03 Start the count of cells at zero.
  $BEE2,$03 Point at the bitmap of visited cells.
  $BEE5,$02 Set the number of bytes in the bitmap to #N$80.
@ $BEE7 label=CalculatePercentage_ByteLoop
  $BEE7,$02 Fetch a byte of the bitmap and move on to the next.
  $BEE9,$02 Set a counter for the eight bits in the byte.
@ $BEEB label=CalculatePercentage_BitLoop
  $BEEB,$03 Check the next bit of the bitmap, and move it into the carry flag.
  $BEEE,$01 Count the visited cell.
@ $BEEF label=CalculatePercentage_NextBit
  $BEEF,$02 Loop back until all eight bits have been counted.
  $BEF1,$03 Loop back until every byte of the bitmap has been counted.
N $BEF4 Add three for every monster that has been killed.
  $BEF4,$04 Start with the first of the four monsters.
  $BEF8,$02 Set a counter for the four monsters.
@ $BEFA label=CalculatePercentage_MonsterLoop
  $BEFA,$05 Fetch the type of the monster and subtract #N$60.
  $BEFF,$04 Jump to #R$BF07 if the monster is still alive (its type is #N$60 to
. #N$6F).
  $BF03,$04 Add three to the count of cells.
@ $BF07 label=CalculatePercentage_NextMonster
  $BF07,$03 Set the size of a monster's entry in the object table to #N$0010
. bytes.
  $BF0A,$02 Move on to the next monster.
  $BF0C,$02 Loop back until all four monsters have been counted.
N $BF0E Multiply the count by #N$2830 and divide by #N$010000, using BCD
. arithmetic for the high byte.
  $BF0E,$03 Set the value to add on each pass.
  $BF11,$01 Start the BCD result at zero.
  $BF12,$01 Make the count of cells the number of times to add.
  $BF13,$03 Start the running total at zero.
@ $BF16 label=CalculatePercentage_MultiplyLoop
  $BF16,$01 Add the value to the total.
  $BF17,$02 Add any carry to the BCD result.
  $BF19,$01 Adjust the BCD result.
  $BF1A,$01 Keep the result.
  $BF1B,$01 Decrease the count.
  $BF1C,$04 Jump to #R$BF23 if the count has reached zero.
  $BF20,$01 Get the result back.
  $BF21,$02 Jump back to #R$BF16.
@ $BF23 label=CalculatePercentage_Finish
  $BF23,$01 Get the result back.
  $BF24,$03 Add #N$0090 to the total, which rounds the percentage.
  $BF27,$04 Add any carry to the BCD result.
  $BF2B,$03 Set the tens and units of the percentage.
  $BF2E,$04 Set the hundreds digit to one if the percentage has overflowed.
  $BF32,$03 Set the hundreds digit of the percentage.
  $BF35,$01 Return.

c $BF36 Print Percentage
@ $BF36 label=PrintPercentage
D $BF36 Prints the percentage complete from #R$BBFD and #R$BBFE, with the
. hundreds digit only when the game is one hundred percent complete.
.
. #PUSHS #UDGTABLE { =h After #R$BF36 }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #POKES$BBFE,$45
. #SIM(start=$BF36,stop=$0000,xa=$45,hl=$4894,sp=$5BF0)
. #SCR$02,$14,$0B,$04,$03(print-percentage) } UDGTABLE# #POPS
R $BF36 HL Screen position of the first digit
  $BF36,$05 Point at the hundreds digit and set the number of digits to one.
  $BF3B,$04 Fetch the hundreds digit and jump to #R$BF43 if it is zero.
  $BF3F,$01 Include the hundreds digit.
  $BF40,$03 Jump to #R$C327 to print the digits.
@ $BF43 label=PrintPercentage_NoHundreds
  $BF43,$02 Move the screen position and the pointer on to the tens digit.
  $BF45,$03 Jump to #R$C314 to print the two digits.

c $BF48 Mark Cell Visited
@ $BF48 label=MarkCellVisited
D $BF48 Records that the object at #REGix has entered a cell of the village by
. setting its bit in the bitmap of visited cells at #R$BC0E. The bitmap holds
. one bit for each of the #N$20 by #N$20 cells.
.
. The routine does nothing if the cell is the same as the one visited last
. time. When the cell holds anything other than open ground and has not been
. visited before, a four note sound effect is started.
R $BF48 IX Object
  $BF48,$03 Fetch the last cell that was visited (the column in #REGl and the
. row in #REGh).
  $BF4B,$06 Jump to #R$BF56 if the object is in a different column.
  $BF51,$05 Return if the object is in the same row too.
@ $BF56 label=MarkCellVisited_NewCell
  $BF56,$06 Fetch the cell that the object is in.
  $BF5C,$03 Remember it as the last cell visited.
  $BF5F,$01 Keep the cell.
  $BF60,$03 Fetch the type of tile in this cell.
  $BF63,$01 Get the cell back.
  $BF64,$02 Jump to #R$BF8A if the cell is not open ground.
@ $BF66 label=MarkCellVisited_SetBit
N $BF66 Find the byte and the bit of the bitmap for the cell. The byte is
. (row * 4 + column / 8) and the bit is (column MOD 8).
  $BF66,$01 Fetch the column.
  $BF67,$01 Put the row in #REGl.
  $BF68,$03 Shift the column left by three places.
  $BF6B,$01 Keep the shifted column.
  $BF6C,$06 Shift the top bits of the column into #REGl, so that #REGl holds
. (row * 4 + column / 8).
  $BF72,$01 Fetch the shifted column.
  $BF73,$02 Clear the high byte of the offset.
  $BF75,$03 Point at the bitmap of visited cells.
  $BF78,$01 Add the offset to find the byte.
  $BF79,$02,b$01 Keep the bits that give the bit number (column MOD 8) in bits
. 3 to 5.
  $BF7B,$02,b$01 Turn this into the opcode of a BIT n,(HL) instruction.
  $BF7D,$03 Change the second byte of the instruction at #R$BF85 to it.
  $BF80,$02,b$01 Turn it into the opcode of a SET n,(HL) instruction.
  $BF82,$03 Change the second byte of the instruction at #R$BF87 to it.
  $BF85,$02 Test the bit for the cell (the code changes itself). The zero flag
. is set if the cell has not been visited before.
  $BF87,$02 Set the bit (self-modifying code).
  $BF89,$01 Return.
@ $BF8A label=MarkCellVisited_Feature
N $BF8A The cell holds something other than open ground.
  $BF8A,$03 Record the cell as visited.
  $BF8D,$01 Return if the cell has been visited before.
  $BF8E,$06 Start the first sound effect, which has four notes, by setting the
. note counter at #R$BBF9 (and the sound number at #R$BBFA).
  $BF94,$01 Return.

c $BF95 Spawn Ghost
@ $BF95 label=SpawnGhost
D $BF95 Creates a ghost at the player's position every #N$0100 frames. The
. ghost is placed in the first of the six short-lived objects at #R$BD9E that is
. not close to the player, at a random position within the player's cell. The
. ghost becomes a burst if it appears on top of the player.
  $BF95,$05 Return unless the frame counter has wrapped round to a multiple of
. #N$0100, so that a ghost appears every #N$0100 frames.
  $BF9A,$04 Start with the first of the six short-lived objects.
  $BF9E,$03 Set the distance between one object and the next (#N$0010 bytes).
  $BFA1,$02 Set a counter for the six short-lived objects.
@ $BFA3 label=SpawnGhost_FindSlot
  $BFA3,$02 Look for an object that is at least two cells away from the player.
  $BFA5,$03 Check whether the object is close to the player.
  $BFA8,$02 Jump to #R$BFB4 to use this object if it is not close to the player.
  $BFAA,$02 Move on to the next short-lived object.
  $BFAC,$02 Loop back until all six objects have been tried.
  $BFAE,$05 Every object is close to the player, so use the first one anyway.
  $BFB3,$01 Return.
@ $BFB4 label=SpawnGhost_Create
N $BFB4 Place the ghost in the player's cell at a random position.
  $BFB4,$07 Choose a random place between #N$40 and #N$BF along the X axis of
. the player's cell...
  $BFBB,$03 ... and set it as the fractional part of the ghost's X position.
  $BFBE,$03 Fetch the player's column.
  $BFC1,$03 Put the ghost in the same column.
  $BFC4,$07 Choose a random place between #N$40 and #N$BF along the Y axis of
. the player's cell...
  $BFCB,$03 ... and set it as the fractional part of the ghost's Y position.
  $BFCE,$03 Fetch the player's row.
  $BFD1,$03 Put the ghost in the same row.
  $BFD4,$04 Set the width of the ghost to #N$10.
  $BFD8,$04 Set the depth of the ghost to #N$10.
  $BFDC,$08 Set the drawing offsets of the ghost to #N$F4 and #N$04.
  $BFE4,$03 Check whether the ghost has appeared on top of the player.
  $BFE7,$02 Choose the type for a burst (#N$0C), in case it has.
  $BFE9,$02 Jump to #R$BFED if the ghost is on top of the player.
  $BFEB,$02 Otherwise choose the type for a ghost (#N$88).
@ $BFED label=SpawnGhost_SetType
  $BFED,$03 Turn the object into a ghost, or a burst.
  $BFF0,$01 Return.

c $BFF1 Update Ghost
@ $BFF1 label=UpdateGhost
D $BFF1 The routine for objects of type #N$88 to #N$8B, the ghosts. A ghost
. drifts towards the player and hurts the player if it touches. It vanishes when
. the player moves more than three cells away, and turns into a burst
. (scoring #N$10 hundred points) when a shot hits it.
  $BFF1,$03 Play the ghost's sound if the ghost has been drawn in the view.
  $BFF4,$03 Make the ghost drift towards the player.
  $BFF7,$03 Move the ghost.
  $BFFA,$06 Jump to #R$C022 if the ghost has been hit by something.
  $C000,$03 Check whether the ghost has run into the scenery.
  $C003,$03 Animate the ghost.
  $C006,$02 Set the distance at which the ghost gives up to #N$03 cells.
  $C008,$03 Check whether the ghost is close to the player.
  $C00B,$02 Jump to #R$C019 if the player is further away than that.
  $C00D,$03 Check whether a shot has hit the ghost.
  $C010,$02 Jump to #R$C01E if it has.
  $C012,$03 Check whether the ghost is touching the player.
  $C015,$01 Return if it is not.
  $C016,$03 Hurt the player (see #R$CEBB).
@ $C019 label=UpdateGhost_Vanish
  $C019,$04 Remove the ghost, because the player has got away from it.
  $C01D,$01 Return.
N $C01E A shot has hit the ghost.
@ $C01E label=UpdateGhost_ShotBurst
  $C01E,$04 Turn the shot that hit the ghost into a burst.
@ $C022 label=UpdateGhost_Burst
  $C022,$04 Turn the ghost into a burst.
  $C026,$03 Set the points for destroying a ghost.
  $C029,$03 Jump to #R$C2ED to add the points to the score.

c $C02C Set Velocity Towards Player
@ $C02C label=SetVelocityTowardsPlayer
D $C02C Makes the object at #REGix chase the player, by setting its velocity
. along each axis to two units towards the player.
R $C02C IX Object
  $C02C,$06 Fetch the X position of the object.
  $C032,$03 Fetch the X position of the player.
  $C035,$03 Work out how far the player is to the right of the object.
  $C038,$02 Use a velocity of #N$02 to move towards the player...
  $C03A,$02 ... unless the player is on the left of the object, which needs the
. opposite velocity.
N $C03C The player is to the left of the object.
@ $C03C label=SetVelocityTowardsPlayer_Left
  $C03C,$02 Reverse the velocity, to move left.
@ $C03E label=SetVelocityTowardsPlayer_SetX
  $C03E,$03 Set the velocity of the object along the X axis.
  $C041,$06 Fetch the Y position of the object.
  $C047,$03 Fetch the Y position of the player.
  $C04A,$03 Work out how far the player is above the object.
  $C04D,$02 Use a velocity of #N$02 to move towards the player...
  $C04F,$02 ... unless the player is below the object, which needs the opposite
. velocity.
N $C051 The player is below the object.
@ $C051 label=SetVelocityTowardsPlayer_Down
  $C051,$02 Reverse the velocity, to move down the screen.
@ $C053 label=SetVelocityTowardsPlayer_SetY
  $C053,$03 Set the velocity of the object along the Y axis.
  $C056,$01 Return.

c $C057 Clear Short-Lived Objects
@ $C057 label=ClearShortLivedObjects
D $C057 Removes everything that is short-lived
. (the ghosts, bursts, fragments and bonuses held in the six objects at #R$BD9E)
. by changing their types to zero.
  $C057,$03 Start with the first short-lived object.
  $C05A,$03 Set the distance between one object and the next (#N$0010 bytes).
  $C05D,$02 Set a counter for the six objects.
@ $C05F label=ClearShortLivedObjects_Loop
  $C05F,$02 Remove the object.
  $C061,$01 Move on to the next object.
  $C062,$02 Loop back until all six objects have been removed.
  $C064,$01 Return.

b $C065 Player Health Colours
@ $C065 label=PlayerHealthColours
D $C065 The attribute used to colour the area around the player for each level
. of health, from #N$00 (dead) to #N$03 (full health).
B $C065,$01 #COLOUR(#PEEK(#PC)).
L $C065,$01,$04

c $C069 Check Object Close To Player
@ $C069 label=CheckPlayerClose
D $C069 Checks whether the object at #REGix is within a given number of cells of
. the player, along both axes. The ghosts, creatures and bonuses use it to find
. out whether they are near enough to matter.
E $C069 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$B810 }
. LIST#
R $C069 IX Object
R $C069 C Distance in cells
R $C069 O:F The carry flag is set if the object is closer than the distance
  $C069,$03 Fetch the player's column.
  $C06C,$03 Work out how many columns the object is from the player.
  $C06F,$03 Jump to #R$C074 if the object is to the left of the player.
  $C072,$02 Otherwise turn the distance round, so that it is positive.
@ $C074 label=CheckPlayerClose_Columns
  $C074,$01 Compare the distance in columns with the limit.
  $C075,$01 Return with the carry flag clear if the object is too far away.
  $C076,$03 Fetch the player's row.
  $C079,$03 Work out how many rows the object is from the player.
  $C07C,$03 Jump to #R$C081 if the object is below the player.
  $C07F,$02 Otherwise turn the distance round, so that it is positive.
@ $C081 label=CheckPlayerClose_Rows
  $C081,$01 Compare the distance in rows with the limit.
  $C082,$01 Return with the carry flag set only if the object is close enough.

c $C083 Update Creature
@ $C083 label=UpdateCreature
D $C083 The routine for objects of type #N$70 to #N$7F, the creatures. A
. creature wanders about the village and hurts the player if it touches. It
. vanishes when the player is more than three cells away. When a shot hits it,
. the kind of the shot and the kind of the creature are added together to choose
. one of four things to happen to it (see #R$C0D1).
  $C083,$06 Set the velocity of the creature from its speed and the way it
. faces.
  $C089,$03 Check whether the creature has run into the scenery.
  $C08C,$04 Check whether it did.
  $C090,$03 Play the bump sound if it did.
  $C093,$04 Clear the flag that shows that the creature has been drawn, ready
. for the next frame.
  $C097,$03 Move the creature.
  $C09A,$03 Turn the creature to a new direction if it has gone far enough in
. this one.
  $C09D,$03 Choose the picture of the creature from the way it faces.
  $C0A0,$02 Set the distance at which the creature gives up to #N$03 cells.
  $C0A2,$03 Check whether the creature is close to the player.
  $C0A5,$02 Jump to #R$C0D9 if the player is further away than that.
  $C0A7,$03 Check whether a shot has hit the creature.
  $C0AA,$02 Jump to #R$C0B9 if one has.
  $C0AC,$03 Check whether the creature is touching the player.
  $C0AF,$01 Return if it is not.
  $C0B0,$03 Set the points that touching a creature costs.
  $C0B3,$03 Add the points to the score.
  $C0B6,$03 Hurt the player (see #R$CEBB).
@ $C0B9 label=UpdateCreature_Hit
N $C0B9 A shot has hit the creature. Add together the kind of the creature and
. the kind of the shot (its type divided by four) to choose what happens.
  $C0B9,$07 Work out the kind of the creature, by dividing its type by four.
  $C0C0,$01 Keep it in #REGc.
  $C0C1,$07 Work out the kind of the shot, by dividing its type by four.
  $C0C8,$01 Add the two kinds together.
  $C0C9,$02,b$01 Keep the result between #N$00 and #N$03.
  $C0CB,$03 Point at the table of outcomes.
  $C0CE,$03 Jump to the outcome that was chosen.

w $C0D1 Hit Outcome Table
@ $C0D1 label=HitOutcomeTable
D $C0D1 The routines that deal with a creature that has been hit by a shot. The
. outcome is chosen by the sum of the kinds of the creature and the shot.
W $C0D1,$08,$02

c $C0D9 Remove Creature
@ $C0D9 label=UpdateCreature_Vanish
  $C0D9,$04 Remove the creature, because the player has moved away.
  $C0DD,$01 Return.

c $C0DE Destroy Creature
@ $C0DE label=HitOutcome_Destroy
D $C0DE Destroys the creature: the creature and the shot both turn into bursts,
. and #N$25 hundred points are added to the score.
  $C0DE,$04 Turn the creature into a burst.
  $C0E2,$03 Set the points for destroying a creature.
  $C0E5,$03 Add the points to the score.
@ $C0E8 label=HitOutcome_BurstShot
  $C0E8,$04 Turn the shot into a burst.
  $C0EC,$01 Return.

c $C0ED Change Creature
@ $C0ED label=HitOutcome_Change
D $C0ED Changes the creature into the next kind of creature, adds #N$20 hundred
. points to the score, and turns the shot into a burst.
  $C0ED,$05 Add four to the type of the creature, which makes it the next kind
. of creature.
  $C0F2,$02,b$01 Keep the frame and kind of creature within #N$00 to #N$0F.
  $C0F4,$02,b$01 Make it the type of a creature (#N$70 to #N$7F).
  $C0F6,$03 Change the type of the creature.
  $C0F9,$03 Set the points for changing a creature.
  $C0FC,$03 Add the points to the score.
  $C0FF,$02 Jump to #R$C0E8 to turn the shot into a burst.

c $C101 Split Creature
@ $C101 label=HitOutcome_Split
D $C101 Splits the creature in two. The shot turns into a burst, and a copy of
. the creature is made in the first of the short-lived objects that is free. The
. two creatures go in opposite directions, and #N$15 hundred points are added to
. the score. If there is no room for the copy, the player scores only a small
. number of points.
  $C101,$04 Turn the shot into a burst.
  $C105,$02 Keep the address of the creature.
  $C107,$04 Start with the first short-lived object.
  $C10B,$03 Set the distance between one object and the next (#N$0010 bytes).
  $C10E,$02 Set a counter for the six objects.
@ $C110 label=HitOutcome_Split_Loop
  $C110,$06 Jump to #R$C129 to use this object if it is empty.
  $C116,$02 Set the distance to #N$02 cells.
  $C118,$03 Check whether the creature is close to the player.
  $C11B,$02 Jump to #R$C129 to use this object if the creature is not close to
. the player.
  $C11D,$02 Move on to the next object.
  $C11F,$02 Loop back until all six objects have been tried.
  $C121,$02 Get the creature back.
  $C123,$03 Set the points for failing to split the creature.
  $C126,$03 Jump to #R$C2ED to add the points to the score.
@ $C129 label=HitOutcome_Split_Copy
  $C129,$03 Remember the address of the free object in #REGde.
  $C12C,$03 Make #REGiy point at the free object.
  $C12F,$01 Get the address of the creature back.
  $C130,$01 Keep it on the stack.
  $C131,$02 Make #REGix point at the creature.
  $C133,$03 Set the size of an object to #N$0010 bytes.
  $C136,$02 Copy the creature into the free object.
  $C138,$03 Fetch the direction timer of the original creature.
  $C13B,$02 Turn it a quarter on.
  $C13D,$02,b$01 Set the lower five bits, to give it a new time to go in that
. direction.
  $C13F,$03 Store the direction timer of the original creature.
  $C142,$03 Fetch the direction timer of the copy.
  $C145,$02 Turn it a quarter back.
  $C147,$02,b$01 Set the lower five bits, to give it a new time to go in that
. direction.
  $C149,$03 Store the direction timer of the copy.
  $C14C,$03 Set the points for splitting a creature.
  $C14F,$03 Jump to #R$C2ED to add the points to the score.

c $C152 Turn Creature Into Spore
@ $C152 label=HitOutcome_Spore
D $C152 Turns the creature into a spore (a type #N$40 to #N$4F object), adds
. #N$10 hundred points to the score and turns the shot into a burst.
  $C152,$03 Fetch the type of the creature.
  $C155,$02,b$01 Keep only bit 2, which tells the two kinds of creature apart.
  $C157,$02,b$01 Make it the type of a spore (#N$40 to #N$4F).
  $C159,$03 Change the type of the creature.
  $C15C,$03 Set the points for changing a creature.
  $C15F,$03 Add the points to the score.
  $C162,$02 Jump to #R$C0E8 to turn the shot into a burst.

c $C164 Update Ball
@ $C164 label=UpdateBall
D $C164 The routine for objects of type #N$80 to #N$83, the balls. A ball
. changes
. through four frames and then turns into a creature (type #N$70 to #N$7F) or,
. at random, into a type #N$40 to #N$4F object. The kind is that of the monster
. that is nearest to the ball.
  $C164,$04 Test whether the ball has been drawn in the view.
  $C168,$04 Clear the flag.
  $C16C,$03 Play the sound of the ball if it was drawn.
  $C16F,$03 Move on to the next frame of animation.
  $C172,$06 Fetch the type of the ball, and return unless the frame number has
. wrapped round to zero.
  $C178,$07 Jump to #R$C191 if a random number is less than #N$80.
  $C17F,$03 Find the nearest living monster.
  $C182,$02 Multiply its number by four to get its kind.
  $C184,$02,b$01 Make it a type #N$40 to #N$4F object.
  $C186,$03 Set the new type.
  $C189,$03 Return unless the type is #N$4C.
  $C18C,$04 Set the depth of the object to #N$18 (type #N$4C only).
  $C190,$01 Return.
@ $C191 label=UpdateBall_Creature
  $C191,$03 Find the nearest living monster.
  $C194,$02 Multiply its number by four to get its kind.
  $C196,$02,b$01 Make it a creature (#N$70 to #N$7F).
  $C198,$03 Set the new type.
  $C19B,$01 Return.

c $C19C Find Nearest Monster
@ $C19C label=FindNearestMonster
D $C19C Finds the living monster that is nearest to the object at #REGix, using
. the sum of the differences in columns and rows as the distance.
R $C19C IX Object
R $C19C O:A The nearest monster, from #N$00 to #N$03 (#N$03 is the monster at
. #R$BD5E)
  $C19C,$04 Start with the first monster.
  $C1A0,$02 Set a counter for the four monsters.
  $C1A2,$03 Start with the shortest distance as #N$FF and no monster.
@ $C1A5 label=FindNearestMonster_Loop
  $C1A5,$03 Find the distance to this monster.
  $C1A8,$01 Compare it with the shortest distance so far.
  $C1A9,$02 Jump to #R$C1AD if it is not shorter.
  $C1AB,$01 Remember the shortest distance.
  $C1AC,$01 Remember the monster.
@ $C1AD label=FindNearestMonster_Next
  $C1AD,$01 Save the shortest distance and the monster.
  $C1AE,$03 Set the size of an object to #N$0010 bytes.
  $C1B1,$02 Move on to the next monster.
  $C1B3,$01 Restore the shortest distance and the monster.
  $C1B4,$02 Loop back until all four monsters have been checked.
  $C1B6,$02 Fetch the monster and convert it to a number from #N$00 to #N$03.
  $C1B8,$01 Return.

c $C1B9 Get Distance To Monster
@ $C1B9 label=GetDistanceToMonster
D $C1B9 Works out the distance from the object at #REGix to a monster, which is
. the sum of the differences in their columns and rows.
R $C1B9 IX Object
R $C1B9 IY Monster
R $C1B9 O:A The distance, or #N$FF if the monster is dead
  $C1B9,$06 Check whether the monster is alive, and jump to #R$C1C2 if it is.
  $C1BF,$02 The monster has been killed, so return a distance of #N$FF, which is
. too far away to matter.
  $C1C1,$01 Return.
@ $C1C2 label=GetDistanceToMonster_Alive
  $C1C2,$06 Work out how many columns the object is from the monster.
  $C1C8,$03 Jump to #R$C1CD if the object is to the right of the monster.
  $C1CB,$02 Otherwise turn the distance round, so that it is positive.
@ $C1CD label=GetDistanceToMonster_Rows
  $C1CD,$01 Keep the distance in columns.
  $C1CE,$06 Work out how many rows the object is from the monster.
  $C1D4,$03 Jump to #R$C1D9 if the object is above the monster.
  $C1D7,$02 Otherwise turn the distance round, so that it is positive.
@ $C1D9 label=GetDistanceToMonster_Add
  $C1D9,$01 Add the two distances together to get the distance from the monster.
  $C1DA,$01 Return.

c $C1DB Build Random Table
@ $C1DB label=BuildRandomTable
D $C1DB Fills the #N$22 bytes at #R$BBD0 with random numbers from #N$10 to
. #N$1F, taken from a random place in the ROM.
.
. The routine then makes the second part of the copy protection check: it
. returns if bit 7 of the memory refresh register is set (the loader sets it,
. see #R$5B80), and resets the computer if not.
  $C1DB,$03 Update the frame counter and the random number generator.
  $C1DE,$03 Fetch the random number.
  $C1E1,$04 Turn it into the address of a random place in the first #N$1000
. bytes of the ROM.
  $C1E5,$03 Point at the table of random numbers.
  $C1E8,$02 Set the length of the table to #N$22 bytes.
@ $C1EA label=BuildRandomTable_Loop
  $C1EA,$0A Copy a byte of the ROM into the table, after making it a number from
. #N$10 to #N$1F, and loop back until the table is full.
  $C1F4,$05 Return if the loader has set bit 7 of the memory refresh register.
N $C1F9 The memory refresh register has not been set up by the stub, so the game
. has been tampered with. Reset the computer.
@ $C1F9 label=BuildRandomTable_Reset
  $C1F9,$04 The game has been tampered with, so reset the computer.

c $C1FD Draw Monster Icons
@ $C1FD label=DrawMonsterIcons
D $C1FD Draws the icons of the four monsters in the status panel. The icon of a
. monster that is still alive is drawn as a plain shape. The icon of a monster
. that has been killed is drawn with all of its detail, in the colour of the
. monster.
.
. #PUSHS #UDGTABLE { =h Monsters alive | =h Monsters killed #R$C1FD }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$BE2D,stop=$BE71)
. #SIM(start=$C1FD,stop=$0000,sp=$5BF0)
. #SCR$02,$0F,$12,$0C,$06(monster-icons-alive)
. | #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$C1FD,stop=$0000,sp=$5BF0)
. #SCR$02,$0F,$12,$0C,$06(monster-icons-killed) } UDGTABLE# #POPS
  $C1FD,$04 Start with the first monster.
  $C201,$03 Set the screen address of the bottom row of the first
. icon to #N$57EF (in the screen buffer).
  $C204,$02 Set a counter for the four monsters.
@ $C206 label=DrawMonsterIcons_Loop
  $C206,$02 Keep the counter and the screen address.
  $C208,$05 Work out the type of the first frame of this monster's sprite
. (#N$6C, #N$68, #N$64 or #N$60).
  $C20D,$03 Point at the table of sprite addresses.
  $C210,$03 Find the address of the sprite in the table.
  $C213,$01 Swap the sprite address and the screen address over.
  $C214,$03 Check whether the sprite is stored flipped
. (bit 6 of its first byte).
  $C217,$02 Keep the registers safe.
  $C219,$03 Flip the sprite back to its normal way round if it is flipped.
  $C21C,$02 Get the registers back.
  $C21E,$01 Swap the sprite address and the screen address over again.
  $C21F,$05 Fetch the width of the sprite in bytes.
  $C224,$02 Fetch the height of the sprite in rows.
  $C226,$09 Check whether the monster has been killed, and jump to #R$C252 if it
. has.
@ $C22F label=DrawMonsterIcons_AliveRow
  $C22F,$02 Keep the width and the screen address of the row.
@ $C231 label=DrawMonsterIcons_AliveByte
  $C231,$0A Draw a byte of the row as the plain shape of the sprite, and loop
. back until the whole row has been drawn.
  $C23B,$02 Get the width and the screen address of the row back.
  $C23D,$03 Move up to the row above.
  $C240,$03 Loop back until every row of the icon has been drawn.
@ $C243 label=DrawMonsterIcons_Next
  $C243,$02 Get the counter and the screen address back.
  $C245,$03 Move on by three characters, to the place for the next icon.
  $C248,$07 Move on to the next monster.
  $C24F,$02 Loop back until the icons of all four monsters have been drawn.
  $C251,$01 Return.
@ $C252 label=DrawMonsterIcons_DeadRow
N $C252 The monster has been killed, so draw its full pixel image.
  $C252,$02 Keep the width and the screen address of the row.
@ $C254 label=DrawMonsterIcons_DeadByte
  $C254,$07 Draw a byte of the row from the full pixel image of the sprite, and
. loop back until the whole row has been drawn.
  $C25B,$02 Get the width and the screen address of the row back.
  $C25D,$03 Move up to the row above.
  $C260,$03 Loop back until every row of the icon has been drawn.
N $C263 Colour the icon with the colour of the monster.
  $C263,$04 Get the counter and the screen address back, and keep them for the
. next icon.
  $C267,$07 Look up the colour of the monster.
  $C26E,$01 Keep the colour.
  $C26F,$01 Get the screen address of the icon.
  $C270,$07 Work out the address of the matching attribute.
  $C277,$04 Add #N$5800 (in the attribute buffer).
  $C27B,$03 Set the distance from one row of attributes to the row above.
  $C27E,$02 Set a counter for the six rows of the icon.
@ $C280 label=DrawMonsterIcons_Colour
  $C280,$08 Colour the three attributes of a row of the icon, and loop back
. until all six rows have been coloured.
  $C288,$02 Jump to #R$C243 to move on to the next icon.

c $C28A Screen Address One Pixel Above
@ $C28A label=ScreenPosition1PixelAbove
D $C28A Moves a screen address up by one row of pixels.
E $C28A View the equivalent code in;
. #LIST
. { #CYBERUN$A1B3 }
. LIST#
R $C28A DE Screen address
R $C28A O:DE The screen address one row of pixels above
  $C28A,$06 Move up a pixel row, and return if that is still in the same
. character row.
  $C290,$05 Move up a character row, and return if that crossed into the
. previous third of the screen (the carry flag is set).
  $C295,$04 Otherwise go to the bottom pixel row of the character row above in
. the same third of the screen.
  $C299,$01 Return.

c $C29A Draw Compass Text
@ $C29A label=DrawCompassText
D $C29A Draws the four characters of the compass text in the status panel, using
. one set of characters when the view is the normal way round and another set
. when the view has been rotated by half a turn.
.
. #PUSHS #UDGTABLE { =h Normal view | =h Rotated view }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$C29A,stop=$0000,sp=$5BF0)
. #SCR$02,$1B,$16,$04,$01(compass-text-normal)
. | #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #POKES$BBBA,$01
. #SIM(start=$C29A,stop=$0000,sp=$5BF0)
. #SCR$02,$1B,$16,$04,$01(compass-text-rotated) } UDGTABLE# #POPS
R $C29A DE Preserved
  $C29A,$01 Keep #REGde safe.
  $C29B,$03 Fetch the flag that tells whether the view is turned round.
  $C29E,$04 Jump to #R$C2BD if the view is turned round.
  $C2A2,$03 Point at the characters for the normal view.
  $C2A5,$02 Use bright cyan ink (attribute #N$45).
@ $C2A7 label=DrawCompassText_Draw
  $C2A7,$01 Keep the colour.
  $C2A8,$03 Set the font to the compass characters.
  $C2AB,$03 Set the screen position of the compass text to
. #N$50DB (in the screen buffer).
  $C2AE,$03 Point at the list of four characters.
  $C2B1,$02 Set a counter for the four characters.
@ $C2B3 label=DrawCompassText_Loop
  $C2B3,$08 Print a character of the compass text, and loop back until all four
. have been printed.
  $C2BB,$02 Get #REGde back and return.
@ $C2BD label=DrawCompassText_Rotated
  $C2BD,$03 Point at the characters for the turned round view.
  $C2C0,$02 Use bright magenta ink (attribute #N$43).
  $C2C2,$02 Jump to #R$C2A7 to print the compass text.

b $C2C4 Compass Text Characters
@ $C2C4 label=CompassTextCharacters
D $C2C4 The codes of the four characters of the compass text.
B $C2C4,$04,$01

c $C2C8 Draw Compass Icon
@ $C2C8 label=DrawCompassIcon
D $C2C8 Draws the compass icon in the status panel, which is made of two blocks
. of four characters (two by two) to make an icon that is four characters wide
. and two high.
.
. #PUSHS #UDGTABLE { =h After #R$C2C8 }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$C2C8,stop=$0000,sp=$5BF0)
. #SCR$02,$1B,$13,$04,$02(compass-icon) } UDGTABLE# #POPS
  $C2C8,$03 Point at the character set of the status panel icons.
  $C2CB,$03 Set it as the font.
  $C2CE,$03 Set the screen position of the first block of the
. icon to #N$507B (in the screen buffer).
  $C2D1,$03 Point at the list of characters of the icon.
  $C2D4,$02 Use bright yellow ink (attribute #N$46).
  $C2D6,$01 Keep the colour.
  $C2D7,$03 Print the first block of the icon.
  $C2DA,$02 Move the screen position on by two characters.
  $C2DC,$03 Jump to #R$CB3E to print the second block of the icon.

b $C2DF Compass Icon Characters
@ $C2DF label=CompassIconCharacters
D $C2DF The codes of the characters of the compass icon: two blocks of four
. characters, each in the order top left, top right, bottom left and bottom
. right (see #R$CB3E).
B $C2DF,$08,$01

t $C2E7 Messaging: Score Text
@ $C2E7 label=Text_Score
D $C2E7 An attribute (bright cyan ink) followed by the characters of the word
. "SCORE". The last character has bit 7 set.
  $C2E7,$06,h$01,$04:$01 Attribute: #COLOUR(#PEEK(#PC)) + "SCORE".

c $C2ED Add To Score
@ $C2ED label=AddToScore
D $C2ED Adds points to the score, which is held as BCD in the three bytes from
. #R$BBC9, and then prints it.
.
. The score is printed with two zeroes added to the end, so the points are in
. hundreds.
R $C2ED BC The points to add, as BCD (in hundreds)
  $C2ED,$03 Point at the last (lowest) byte of the score.
  $C2F0,$04 Add the lowest two digits of the points to the lowest two digits of
. the score.
  $C2F4,$01 Move on to the middle byte of the score.
  $C2F5,$04 Add the next two digits of the points to the next two digits of the
. score, with any carry.
  $C2F9,$01 Move on to the highest byte of the score.
  $C2FA,$05 Add any carry to the highest two digits of the score.

c $C2FF Print Score
@ $C2FF label=PrintScore
D $C2FF Prints the score, as seven digits, in the status panel. The last two
. digits are always zero.
.
. #PUSHS #UDGTABLE { =h After #R$C2FF }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #POKES$BBC9,$12;$BBCA,$34;$BBCB,$56
. #SIM(start=$C2FF,stop=$0000,sp=$5BF0)
. #SCR$02,$05,$16,$09,$02(print-score) } UDGTABLE# #POPS
  $C2FF,$03 Use bright yellow ink (attribute #N$46), and keep it for printing
. the digits.
  $C302,$03 Set the screen position of the score to
. #N$50E6 (in the screen buffer).
@ $C305 label=PrintScore_Position
  $C305,$05 Point at the score, and set the number of bytes to print to four.
  $C30A,$01 Keep the screen position.
  $C30B,$03 Point at the font of the digits.
  $C30E,$03 Set it as the font.
  $C311,$01 Get the screen position back.
  $C312,$02 Jump to #R$C327 to print the digits, starting with the lower digit
. of the first byte.

c $C314 Print BCD Number
@ $C314 label=PrintBCDNumber
D $C314 Prints the digits of BCD numbers.
.
. Entering at #R$C314 sets the font to the digits first. Entering at #R$C327
. prints only the lower digit of the first byte.
E $C314 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BA62 }
. { #KNIGHTLORE$BCAE }
. { #MARTIANOIDS$B5AF }
. LIST#
R $C314 B Number of bytes
R $C314 DE Address of the BCD number
R $C314 HL Screen position of the first digit
  $C314,$01 Keep the screen position.
  $C315,$03 Point at the font of the digits.
  $C318,$03 Set it as the font.
  $C31B,$01 Get the screen position back.
@ $C31C label=PrintBCDNumber_Loop
  $C31C,$05 Fetch a byte of the number and move its upper digit down to the
. lower four bits.
  $C321,$02,b$01 Keep only the digit.
  $C323,$03 Print the upper digit.
  $C326,$01 Move on to the next screen position.
@ $C327 label=PrintBCDNumber_LowerDigit
  $C327,$03 Fetch the byte again and keep only its lower digit.
  $C32A,$03 Print the lower digit.
  $C32D,$01 Move on to the next screen position.
  $C32E,$01 Move on to the next byte of the number.
  $C32F,$02 Loop back until all of the bytes have been printed.
  $C331,$01 Return.

c $C332 Play Ghost Sound
@ $C332 label=PlayGhostSound
D $C332 Plays a sound for a ghost, if the ghost has been drawn in the view.
E $C332 View the equivalent code in;
. #LIST
. { #PENTAGRAM$D56C }
. LIST#
.
. #HTML(#AUDIO0(ghost-sound.wav)(#INCLUDE(GhostSound)))
  $C332,$03 Point at the pitches of the ghost sound.
@ $C335 label=PlayFlaggedSound
N $C335 Plays a sound effect, using a pitch from a table, if the object at
. #REGix has been drawn in the view. The routine that draws a sprite (see
. #R$E3FF) sets bit 1 of the flags of the object, and this routine clears it.
.
. When it is used for a monster (see #R$D94F), the pitches come from the ROM
. instead (see #R$C34D).
.
. #HTML(#AUDIO0(monster-sound.wav)(#INCLUDE(MonsterSound)))
R $C335 BC Address of the table of pitches (or of the ROM)
R $C335 IX Object
  $C335,$04 Check whether the object has been drawn in the view.
  $C339,$04 Clear the flag, ready for the next frame.
  $C33D,$01 Return if the object was not drawn, because it can't be heard.
  $C33E,$03 Fetch the low byte of the frame counter.
  $C341,$02,b$01 Keep only the lowest four bits, to choose one of the sixteen
. pitches.
  $C343,$04 Add it to the address of the table.
  $C347,$01 Fetch the pitch.
  $C348,$02 Set the length of the sound.
  $C34A,$03 Jump to #R$C46A to play the tone.

b $C34D Sound Pitch Tables
@ $C34D label=SoundPitchTables
D $C34D Five tables of sixteen pitches: one for the ghost (see #R$C332) and one
. for each of the four kinds of monster.
.
. The game uses the table for the ghost. It does not use the four tables for the
. monsters: #R$D94F passes only the offset of a table to #R$C335, so the pitches
. of the monsters come from the ROM, starting at #N$0080.
B $C34D,$10,$10 The pitches for the ghost.
@ $C35D label=SoundPitchTable_Monsters
B $C35D,$40,$10 The pitches for the four kinds of monster (not used by the
. game).

c $C39D Play Ending Ghost Sound
@ $C39D label=PlayEndingGhostSound
D $C39D Plays a tone that is one step lower every time it is called. It is
. played for the ghosts of the ending (see #R$CD58).
E $C39D View the equivalent code in;
. #LIST
. { #PENTAGRAM$D5D7 }
. LIST#
.
. #HTML(#AUDIO0(ending-ghost-sound.wav)(#INCLUDE(EndingGhostSound)))
  $C39D,$03 Point at the counter that holds the pitch of the sound.
  $C3A0,$01 Raise it, so that the sound falls in pitch each time.
  $C3A1,$01 Fetch the counter.
  $C3A2,$02 Add #N$40 to make the pitch higher than the lowest.
  $C3A4,$01 Set the pitch.
  $C3A5,$02 Set the length of the tone.
  $C3A7,$03 Jump to #R$C46A to play the tone.

c $C3AA Play Bump Sound
@ $C3AA label=PlayBumpSound
D $C3AA Plays a burst of noise, if the object at #REGix has been drawn in the
. view (bit 1 of its flags).
E $C3AA View the equivalent code in;
. #LIST
. { #GUNFRIGHT$AF22 }
. { #MARTIANOIDS$C04E }
. { #PENTAGRAM$D5E4 }
. { #SABREWULF$BF2F }
. LIST#
.
. #HTML(#AUDIO0(bump-sound.wav)(#INCLUDE(BumpSound)))
R $C3AA IX Object
  $C3AA,$05 Return if the object has not been drawn in the view, because it
. can't be heard.
  $C3AF,$02 Set a counter for sixteen tones.
@ $C3B1 label=PlayBumpSound_Loop
  $C3B1,$0B Play a short tone, with a pitch that depends on the counter, and
. loop back until all sixteen tones have been played.
  $C3BC,$01 Return.

c $C3BD Play Sound Effect
@ $C3BD label=PlaySoundEffect
D $C3BD Plays the next note of the current sound effect. The note counter is
. held at #R$BBF9 and the number of the sound effect at #R$BBFA. A sound effect
. is started by setting the note counter to the number of notes.
.
. The sound effects are:
. #TABLE(default,centre,centre)
. { =h Effect | =h Sound }
. { #N$00, a new cell |
. #HTML(#AUDIO0(new-cell-sound.wav)(#INCLUDE(NewCellSound))) }
. { #N$01, a speed bonus |
. #HTML(#AUDIO0(speed-bonus-sound.wav)(#INCLUDE(SpeedBonusSound))) }
. { #N$02, a health bonus |
. #HTML(#AUDIO0(health-bonus-sound.wav)(#INCLUDE(HealthBonusSound))) }
. { #N$03, an item |
. #HTML(#AUDIO0(item-sound.wav)(#INCLUDE(ItemSound))) }
. TABLE#
E $C3BD View the equivalent code in;
. #LIST
. { #MARTIANOIDS$BFDA }
. { #PENTAGRAM$D5F2 }
. LIST#
  $C3BD,$03 Point at the counter of notes still to play.
  $C3C0,$03 Return if there are no more notes to play.
  $C3C3,$01 Count down a note.
  $C3C4,$01 Keep the note counter.
  $C3C5,$01 Point at the number of the sound effect.
  $C3C6,$01 Fetch the number of the sound effect.
  $C3C7,$03 Point at the table of sound effects.
  $C3CA,$03 Fetch the address of the notes of the sound effect.
  $C3CD,$01 Get the number of the note.
  $C3CE,$01 Use it as the distance along the notes.
  $C3CF,$02 Make the distance a whole number of bytes.
  $C3D1,$01 Find the address of the note.
  $C3D2,$01 Fetch the pitch of the note.
  $C3D3,$02 Set the length of the note.
  $C3D5,$03 Jump to #R$C46A to play the note.

w $C3D8 Sound Effect Table
@ $C3D8 label=SoundEffectTable
D $C3D8 The addresses of the notes of each of the four sound effects.
W $C3D8,$08,$02

b $C3E0 Sound Effect Notes
@ $C3E0 label=SoundEffectNotes
D $C3E0 The pitches of the notes of each of the four sound effects. They are
. played from the last note to the first.
B $C3E0,$04,$04 Sound effect #N$00.
@ $C3E4 label=SoundEffectNotes_1
B $C3E4,$05,$05 Sound effect #N$01.
@ $C3E9 label=SoundEffectNotes_2
B $C3E9,$07,$07 Sound effect #N$02.
@ $C3F0 label=SoundEffectNotes_3
B $C3F0,$04,$04 Sound effect #N$03.

c $C3F4 Play Sweep Sound
@ $C3F4 label=PlaySweepSound
D $C3F4 Plays a sequence of thirty-two tones.
E $C3F4 View the equivalent code in;
. #LIST
. { #PENTAGRAM$D629 }
. LIST#
.
. #HTML(#AUDIO0(throw-sound.wav)(#INCLUDE(ThrowSound)))
R $C3F4 B Starting pitch
  $C3F4,$02 Set the number of tones to play to #N$20.
@ $C3F6 label=PlaySweepSound_Loop
  $C3F6,$09 Subtract the starting pitch from the number of tones left to work
. out the pitch of the next tone, play it, and loop back until all #N$20 tones
. have been played.
  $C3FF,$01 Return.

c $C400 Play Movement Sound
@ $C400 label=PlayMovementSound
D $C400 Plays a short tick, which is alternately high and low, once every few
. frames. The ticks are made twice as often when the object is moving quickly.
.
. #HTML(#AUDIO0(footstep-sound.wav)(#INCLUDE(FootstepSound)))
E $C400 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$AEED }
. LIST#
R $C400 IX Object
  $C400,$03 Point at the counter of steps.
  $C403,$01 Count a step.
  $C404,$03 Fetch the speed of the object.
  $C407,$04 Jump to #R$C420 if the object is moving quickly.
  $C40B,$05 Jump to #R$C418 to make the low tick unless bit 2 of the step
. counter is set.
  $C410,$08 Return unless the step counter is a multiple of four, otherwise play
. the high tick.
@ $C418 label=PlayMovementSound_Low
  $C418,$08 Return unless the step counter is a multiple of four, otherwise play
. the low tick.
@ $C420 label=PlayMovementSound_Fast
  $C420,$05 Jump to #R$C42D to make the low tick unless bit 1 of the step
. counter is set.
  $C425,$08 Return unless the step counter is even, otherwise play the high
. tick.
@ $C42D label=PlayMovementSound_FastLow
  $C42D,$08 Return unless the step counter is even, otherwise play the low tick.

c $C435 Play Random Sound
@ $C435 label=PlayRandomSound
D $C435 Plays sixteen tones with pitches taken from a random place in the ROM,
. if the object at #REGix has been drawn in the view (bit 1 of its flags).
.
. #HTML(#AUDIO0(explosion.wav)(#INCLUDE(Explosion)))
R $C435 IX Object
  $C435,$09 Return if the object has not been drawn in the view, otherwise clear
. the flag.
  $C43E,$03 Fetch the random number.
  $C441,$04 Turn it into the address of a random place in the first #N$2000
. bytes of the ROM.
  $C445,$02 Set a counter for sixteen tones.
@ $C447 label=PlayRandomSound_Loop
  $C447,$0D Play a short tone, with a pitch taken from the ROM, and loop back
. until all sixteen tones have been played.
  $C454,$01 Return.

c $C455 Play Object Sound
@ $C455 label=PlayObjectSound
D $C455 Plays a tone with a pitch that depends on the type of an object.
E $C455 View the equivalent code in;
. #LIST
. { #PENTAGRAM$D665 }
. LIST#
.
. #HTML(#AUDIO0(ball-sound.wav)(#INCLUDE(BallSound)))
R $C455 IX Object
  $C455,$0C Work out the pitch of the tone from the type of the object and set
. the length of the tone to #N$06.
  $C461,$02 Jump to #R$C46A to play the tone.

c $C463 Play Materialise Sound
@ $C463 label=PlayMaterialiseSound
D $C463 Plays a tone with a pitch that depends on the player's materialise timer
. (#R$BC02).
.
. #HTML(#AUDIO0(appearing-sound.wav)(#INCLUDE(AppearingSound)))
  $C463,$07 Work out the pitch of the tone from the timer, so that it rises as
. the timer counts down, and set the length of the tone to #N$08.
@ $C46A label=PlayTone
N $C46A Plays a tone.
R $C46A B Pitch (the lower the number, the higher the pitch)
R $C46A C Length of the tone, in cycles
  $C46A,$06 Play a cycle of the tone, and loop back until the whole tone has
. been played.
  $C470,$01 Return.

c $C471 Play Square Wave
@ $C471 label=PlaySquareWave
D $C471 Plays a single cycle of a tone on the speaker.
E $C471 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B702 }
. { #BUBBLER$9E93 }
. { #CYBERUN$71E0 }
. { #GUNFRIGHT$AF66 }
. { #KNIGHTLORE$B4ED }
. { #MARTIANOIDS$C062 }
. { #PENTAGRAM$D682 }
. LIST#
R $C471 B Pitch
  $C471,$05 Turn the speaker on.
@ $C476 label=PlaySquareWave_High
  $C476,$02 Wait, to make the first half of the cycle.
  $C478,$05 Turn the speaker off.
@ $C47D label=PlaySquareWave_Low
  $C47D,$02 Wait, to make the second half of the cycle.
  $C47F,$02 Get the pitch back and return.

c $C481 Pick Up Special Item
@ $C481 label=PickUpItem_Special
D $C481 Works out the number of an item from the type of the object that has
. been picked up (an object of type #N$30 or above).
R $C481 A Type of the object
R $C481 HL Address of the free place in the inventory
R $C481 IX Object
  $C481,$08 Divide the type by four, keep the lowest two bits and add five, to
. make the number of the item. Jump to #R$C49F to put it in the inventory.

c $C489 Pick Up Item
@ $C489 label=PickUpItem
D $C489 Puts the object at #REGix into the first free place in the inventory
. (the eleven bytes from #R$BC03), removes the object from the village and draws
. the item in the inventory tube. Nothing happens if the inventory is full.
.
. The number of the item is the type of the object minus three, or, for objects
. of type #N$30 and above, the kind of object (bits 2 and 3 of the type) plus
. five.
R $C489 IX Object
  $C489,$05 Point at the first place in the inventory and set a counter for the
. eleven places.
@ $C48E label=PickUpItem_Find
  $C48E,$04 Jump to #R$C496 if this place is empty.
  $C492,$03 Move on to the next place, and loop back until all eleven have been
. checked.
  $C495,$01 Return, because the inventory is full.
@ $C496 label=PickUpItem_Free
  $C496,$07 Fetch the type of the object, and jump to #R$C481 if it is #N$30 or
. more.
  $C49D,$02 Subtract three from the type to make the number of the item.
@ $C49F label=PickUpItem_Store
  $C49F,$01 Put the item in the empty place in the inventory.
  $C4A0,$04 Remove the object from the village.
@ $C4A4 label=DrawInventoryItem
N $C4A4 Draws the icon of an item in the inventory tube.
R $C4A4 B Place in the inventory, counted from the end (#N$0B to #N$01)
R $C4A4 DE Address of the place in the inventory
  $C4A4,$01 Point at the place in the inventory.
  $C4A5,$03 Point at the character set of the status panel icons.
  $C4A8,$03 Set it as the font.
  $C4AB,$0E Work out the screen Y position of the place up the tube.
  $C4B9,$02 Set the screen X position of the item.
  $C4BB,$03 Work out the screen address of the item.
  $C4BE,$01 Fetch the number of the item.
  $C4BF,$02 Multiply it by four, to get the first of the four characters that
. make up the icon.
  $C4C1,$01 Keep the character code.
  $C4C2,$03 Print the top left character.
  $C4C5,$01 Get the character code back.
  $C4C6,$01 Move on to the next character.
  $C4C7,$01 Move one position to the right.
  $C4C8,$01 Keep the character code.
  $C4C9,$03 Print the top right character.
  $C4CC,$01 Move one position back to the left.
  $C4CD,$03 Move down one row.
  $C4D0,$01 Get the character code back.
  $C4D1,$01 Move on to the next character.
  $C4D2,$01 Keep the character code.
  $C4D3,$03 Print the bottom left character.
  $C4D6,$01 Get the character code back.
  $C4D7,$01 Move on to the next character.
  $C4D8,$01 Move one position to the right.
  $C4D9,$03 Jump to #R$CB1F to print the bottom right character.

c $C4DC Colour Inventory Items
@ $C4DC label=ColourInventoryItems
D $C4DC Sets the attributes of the items in the inventory tube. Each item is a
. block of two by two attributes. Items #N$01 to #N$04 flash in the colours of
. items #N$05 to #N$08 when the player is within five cells of the monster that
. they belong to.
  $C4DC,$06 Point at the table of colours, and at the lowest item
. at #N$5AC2 (in the attribute buffer).
  $C4E2,$06 Swap to the shadow registers, point at the inventory and set a
. counter for the eleven places in it.
@ $C4E8 label=ColourInventoryItems_Loop
  $C4E8,$03 Fetch the item, and return if there are no more items.
  $C4EB,$04 Jump to #R$C507 if the item is one of the four that belong to
. monsters.
@ $C4EF label=ColourInventoryItems_Colour
  $C4EF,$08 Look up the colour of the item in the table of colours.
  $C4F7,$03 Colour the top two attributes of the item.
  $C4FA,$04 Move to the row of attributes above.
  $C4FE,$03 Colour the bottom two attributes of the item.
  $C501,$01 Move up one more row, to the next item.
  $C502,$01 Swap back to the main registers.
  $C503,$03 Move on to the next place in the inventory, and loop back until all
. eleven have been coloured.
  $C506,$01 Return.
@ $C507 label=ColourInventoryItems_Monster
N $C507 Items #N$01 to #N$04 belong to the monsters. Find out whether the
. monster is near the player.
  $C507,$02 Keep the item and the pointer to the inventory.
  $C509,$03 Turn the number of the item into the number of the monster, from
. #N$03 to #N$00.
  $C50C,$04 Multiply it by sixteen, to get the distance to the object of the
. monster.
  $C510,$03 Put the distance in #REGde.
  $C513,$04 Start with the first monster.
  $C517,$02 Add the distance, to point at the right monster.
  $C519,$02 Set the distance to #N$05 cells.
  $C51B,$03 Check whether the monster is close to the player.
  $C51E,$02 Jump to #R$C524 to make the item flash if the player is within five
. cells of the monster.
  $C520,$02 Get the item and the pointer to the inventory back.
  $C522,$02 Jump to #R$C4EF to give the item its usual colour.
@ $C524 label=ColourInventoryItems_Flash
  $C524,$02 Get the item and the pointer to the inventory back.
  $C526,$07 Use the lowest two bits of the frame counter, plus five, as the
. colour of the item, so that it flashes.
  $C52D,$02 Jump to #R$C4EF to colour the item.

b $C52F Item Colours
@ $C52F label=ItemColours
D $C52F The attribute for each of the items, from #N$00 (no item) to #N$08.
B $C52F,$01 #COLOUR(#PEEK(#PC)).
L $C52F,$01,$09

c $C538 Check Shot Hits Object
@ $C538 label=CheckShotHit
D $C538 Checks whether the object at #REGix has been hit by a shot. The shots
. are objects of type #N$50 to #N$5F. The first shot is checked twice, as #REGiy
. is not moved on to the second.
R $C538 IX Object
R $C538 O:IY The shot
R $C538 O:F The carry flag is set if the object has been hit
  $C538,$06 Point #REGiy at the first shot, and set a counter for two shots.
@ $C53E label=CheckShotHit_Loop
  $C53E,$06 Check whether this shot hits the object, and return if it does.
  $C544,$03 Set the distance from one object to the next (#N$0010 bytes).
  $C547,$02 Loop back until both shots have been checked.
  $C549,$01 Return.
@ $C54A label=CheckShotHit_Shot
  $C54A,$08 Return if the object at #REGiy is not a shot (type #N$50 to #N$5F).
  $C552,$02 Jump to #R$C572 to check whether the shot overlaps the object.

c $C554 Check Overlap With Next Object
@ $C554 label=CheckOverlapWithNextObject
D $C554 Checks whether the object at #REGix overlaps the object that is four
. places further along the object table.
R $C554 IX Object
R $C554 O:F The carry flag is set if the objects overlap
  $C554,$04 Make #REGiy point at the same object.
  $C558,$05 Move #REGiy on by four objects.
  $C55D,$02 Jump to #R$C572 to check whether they overlap.

c $C55F Check Player Collision
@ $C55F label=CheckPlayerCollision
D $C55F Checks whether the object at #REGix is touching the player. Nothing
. touches the player until the player has finished materialising, or when the
. player is dead.
R $C55F IX Object
R $C55F O:IY The player
R $C55F O:F The carry flag is set if the object is touching the player
  $C55F,$07 Return if the player is still materialising.
  $C566,$04 Use the player as the second object.
  $C56A,$08 Return if the player is dead.
@ $C572 label=CheckObjectsOverlap
N $C572 Checks whether two objects overlap along both axes. The overlap is
. measured from the centres of the objects, using half of the width and the
. depth of the object at #REGiy and the full width and depth of the object at
. #REGix.
R $C572 IX First object
R $C572 IY Second object
R $C572 O:F The carry flag is set if the objects overlap
  $C572,$0B Add half of the width of the second object to the width of the first
. object, to find the distance along the X axis within which they overlap.
  $C57D,$0C Fetch the X positions of the two objects.
  $C589,$03 Subtract one from the other to get the distance between the objects.
  $C58C,$03 Turn the distance round if it is negative, so that it is positive.
  $C58F,$03 Subtract the distance within which the objects overlap.
  $C592,$01 Return with the carry flag clear if the objects do not overlap along
. the X axis.
  $C593,$0B Add half of the depth of the second object to the depth of the first
. object, to find the distance along the Y axis within which they overlap.
  $C59E,$0C Fetch the Y positions of the two objects.
  $C5AA,$03 Subtract one from the other to get the distance between the objects.
  $C5AD,$03 Turn the distance round if it is negative, so that it is positive.
  $C5B0,$03 Subtract the distance within which the objects overlap.
  $C5B3,$01 Return with the carry flag set if the objects overlap along the Y
. axis as well, which means they are touching.

c $C5B4 Increment Frame Counter
@ $C5B4 label=IncrementFrameCounter
D $C5B4 Increases the frame counter, and then updates the random number
. generator.
  $C5B4,$07 Count a frame.

c $C5BB Update Random Number
@ $C5BB label=RandomNumber
D $C5BB Updates the random seed from the frame counter, the old seed and the
. memory refresh register.
  $C5BB,$07 Fetch the frame counter and the random number.
  $C5C2,$02 Fetch a random number from #N$80 to #N$FF.
  $C5C4,$02 Add the low byte of the random number, and then the low byte of the
. frame counter, to it.
  $C5C6,$01 Make that the low byte of the new random number.
  $C5C7,$03 Add the high byte of the frame counter to the high byte of the
. random number.
  $C5CA,$03 Store the new random number.
  $C5CD,$01 Return.

c $C5CE Spawn Item
@ $C5CE label=SpawnItem
D $C5CE Every sixteen frames, when the player is standing on a kind of tile that
. still has items to give, makes an item appear at the player's position. The
. item is placed in the first free one of the four objects from #R$BCCE, at a
. random position within the cell. The number of items that are left for each
. kind of tile is held in the table at #R$BBCE.
  $C5CE,$06 Return if the player is still materialising.
  $C5D4,$06 Return unless the frame counter is a multiple of sixteen.
  $C5DA,$09 Start with the first of the four item objects, set the distance from
. one object to the next (#N$0010 bytes) and set a counter for the four items.
@ $C5E3 label=SpawnItem_Find
  $C5E3,$06 Jump to #R$C5EE if this item object is free.
  $C5E9,$05 Move on to the next item object and loop back until all four have
. been tried, and then return.
@ $C5EE label=SpawnItem_Spawn
  $C5EE,$0A Fetch the column and row of the player's cell.
  $C5F8,$03 Find out what kind of tile is in the cell.
  $C5FB,$0A Fetch the number of items that are left for this kind of tile, and
. return if there are none.
  $C605,$01 Take one from the number of items that are left.
  $C606,$09 Set the column and row of the item to those of the player's cell,
. and the tile to the kind of tile.
  $C60F,$07 Choose the type of the item (#N$30, #N$34, #N$38 or #N$3C) from the
. kind of tile.
  $C616,$03 Make the object an item.
  $C619,$0B Put the item at a random place along the X axis of the cell.
  $C624,$08 Put the item at a random place along the Y axis of the cell.
  $C62C,$08 Make the item eight units wide and deep.
  $C634,$08 Set the drawing offsets of the item to #N$F8 and #N$04.
  $C63C,$01 Return.

c $C63D Play Music Once
@ $C63D label=PlayMusicOnce
D $C63D Plays a tune, which is stopped by any key being pressed. A tune that has
. been started is not started again.
E $C63D View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4A1 }
. { #GUNFRIGHT$AF76 }
. { #KNIGHTLORE$B2B6 }
. { #MARTIANOIDS$C0B6 }
. { #PENTAGRAM$D69C }
. LIST#
R $C63D DE Address of the tune
  $C63D,$06 Return if this tune has been played before.
  $C643,$02 Remember that the tune has been played.
@ $C645 label=PlayMusicOnce_Loop
  $C645,$01 Read every row of the keyboard at once.
  $C646,$03 Check whether a key is being pressed.
  $C649,$02 Jump to #R$C64C to play the next note if no key is being pressed.
  $C64B,$01 Return, to stop the tune.
@ $C64C label=PlayMusicOnce_Note
  $C64C,$03 Fetch the next note and jump to #R$C660 if it marks the end of the
. tune.
  $C64F,$05 Play the note.
  $C654,$02 Jump back to #R$C645 to check the keyboard again.

c $C656 Play Music
@ $C656 label=PlayMusic
D $C656 Plays a tune. Each note is a byte, with the note in bits 0 to 5 (#N$00
. is a rest) and the length of the note minus one in bits 6 and 7. The tune ends
. with #N$FF.
.
. The tunes played by this routine are:
. #TABLE(default,centre,centre)
. { =h Tune | =h Sound }
. { Main Tune |
. #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune))) }
. { Menu Selection Tune |
. #HTML(#AUDIO0(menu-selection-tune.wav)(#INCLUDE(MenuSelectionTune))) }
. { Start-up Tune |
. #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune))) }
. { Life Lost Tune |
. #HTML(#AUDIO0(life-lost-tune.wav)(#INCLUDE(LifeLostTune))) }
. { Game Over Tune |
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune))) }
. { Game Complete Tune |
. #HTML(#AUDIO0(game-complete-tune.wav)(#INCLUDE(GameCompleteTune))) }
. TABLE#
E $C656 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4BA }
. { #BUBBLER$A1C1 }
. { #CYBERUN$9AA9 }
. { #GUNFRIGHT$AF8F }
. { #KNIGHTLORE$B2CF }
. { #MARTIANOIDS$C0CF }
. { #PENTAGRAM$D6B5 }
. LIST#
R $C656 DE Address of the tune
  $C656,$0A Fetch the next note, return if it marks the end of the tune, and
. otherwise play the note and loop back.
@ $C660 label=PlayMusic_Return
  $C660,$01 Return.

c $C661 Play Note
@ $C661 label=PlayNote
D $C661 Plays a note of a tune, or waits if it is a rest.
E $C661 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4C5 }
. { #BUBBLER$A1CC }
. { #CYBERUN$9AB4 }
. { #GUNFRIGHT$AF9A }
. { #KNIGHTLORE$B2DA }
. { #MARTIANOIDS$C0DA }
. { #PENTAGRAM$D6C0 }
. LIST#
R $C661 A Note
R $C661 DE Address of the note
R $C661 O:DE Address of the next note
  $C661,$04 Keep the note, and jump to #R$C6A3 if it is a rest.
N $C665 Look up the delays and the number of cycles in the table at #R$C6B9.
  $C665,$04 Multiply the note number by three.
  $C669,$03 Add the note number to get the place in the table of notes.
  $C66C,$04 Point at the table of notes.
  $C670,$01 Fetch the pitch of the note.
  $C671,$01 Move on to the next byte.
  $C672,$01 Fetch the delay of the note.
  $C673,$01 Move on to the next byte.
  $C674,$03 Fetch the number of cycles that make up one unit of length of the
. note.
N $C677 Bits 6 and 7 of the note are the length, less one.
  $C677,$06 Fetch the length of the note, from bits 6 and 7 of the note.
  $C67D,$03 Keep the address of the next note, and use #REGde to count out the
. length.
N $C680 Multiply the number of cycles by the length of the note.
@ $C680 label=PlayNote_Length
  $C680,$03 Jump to #R$C686 when the length has been counted out.
  $C683,$03 Add the number of cycles in a unit of length, and loop back.
@ $C686 label=PlayNote_Start
  $C686,$01 Get the address of the next note back.
N $C687 Each pass of this loop makes one cycle of the note, so the length of
. the note is the number of cycles.
@ $C687 label=PlayNote_Cycle
  $C687,$04 Keep the pitch and the delay, and turn the speaker off.
@ $C68B label=PlayNote_Low
  $C68B,$05 Wait while the speaker is off.
  $C690,$06 Get the pitch and the delay back, keep them again and turn the
. speaker on.
@ $C696 label=PlayNote_High
  $C696,$05 Wait while the speaker is on.
  $C69B,$06 Get the pitch and the delay back, count down the cycles and loop
. back until the note has been played.
  $C6A1,$02 Move on to the next note and return.
@ $C6A3 label=PlayNote_Rest
N $C6A3 The note is a rest, so wait for as long as the note would last.
  $C6A3,$0B Fetch the length of the rest, and set the delay for one unit of the
. rest.
@ $C6AE label=PlayNote_RestLoop
  $C6AE,$01 Keep the delay for one unit.
@ $C6AF label=PlayNote_RestWait
  $C6AF,$05 Wait for one unit of the rest.
  $C6B4,$04 Get the delay for one unit back, and loop back until the rest is
. over.
  $C6B8,$01 Return.

b $C6B9 Note Table
@ $C6B9 label=NoteTable
D $C6B9 The pitch of each of the notes that can be played. Each note has three
. bytes: the delay for the speaker, the multiplier for the delay, and the number
. of cycles that make up one unit of length. Note #N$00 is a rest, and has no
. entry.
B $C6B9,$B7,$03

b $C770 Tune: Game Selection Menu
@ $C770 label=Tune_Menu
D $C770 The tune that is played while the game selection menu is shown.
.
. #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune)))
B $C770,$84,$0C

b $C7F4 Tune: Menu Selection
@ $C7F4 label=Tune_MenuSelection
D $C7F4 The jingle that is played when an option on the game selection menu is
. chosen.
.
. #HTML(#AUDIO0(menu-selection-tune.wav)(#INCLUDE(MenuSelectionTune)))
B $C7F4,$04,$04

b $C7F8 Tune: Start Game
@ $C7F8 label=Tune_StartGame
D $C7F8 The tune that is played when the game starts.
.
. #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune)))
B $C7F8,$0B,$0B

b $C803 Tune: Game Over
@ $C803 label=Tune_GameOver
D $C803 The tune that is played when the game is over.
.
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
B $C803,$17,$0C

b $C81A Tune: Game Complete
@ $C81A label=Tune_GameComplete
D $C81A The tune that is played when all four monsters have been killed.
.
. #HTML(#AUDIO0(game-complete-tune.wav)(#INCLUDE(GameCompleteTune)))
B $C81A,$1F,$0C

b $C839 Tune: Life Lost
@ $C839 label=Tune_LifeLost
D $C839 The tune that is played when the player loses a life.
.
. #HTML(#AUDIO0(life-lost-tune.wav)(#INCLUDE(LifeLostTune)))
B $C839,$06,$06

c $C83F Draw Inventory Tube
@ $C83F label=DrawInventoryTube
D $C83F Draws the tube down the left of the screen that holds the items that the
. player is carrying: two vertical bars joined at the bottom.
.
. #PUSHS #UDGTABLE { =h After #R$C83F }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$C83F,stop=$0000,sp=$5BF0)
. #SCR$02,$01,$00,$04,$18(inventory-tube) } UDGTABLE# #POPS
  $C83F,$03 Use bright magenta ink (attribute #N$43), and keep it for colouring
. the tube.
  $C842,$06 Set the font to the characters of the tube.
  $C848,$03 Set the screen position of the top of the left
. bar to #N$4001 (in the screen buffer).
  $C84B,$04 Print the top of the bar.
  $C84F,$03 Move down a row.
  $C852,$04 Choose the side of the bar as the character, and #N$16 as the number
. of rows.
  $C856,$03 Print the side of the left bar.
N $C859 Print the bottom of the tube.
  $C859,$05 Print the bottom left corner.
  $C85E,$01 Move one position to the right.
  $C85F,$05 Print the first part of the bottom.
  $C864,$01 Move one position to the right.
  $C865,$05 Print the second part of the bottom.
  $C86A,$01 Move one position to the right.
  $C86B,$05 Print the bottom right corner.
N $C870 Print the right bar.
  $C870,$03 Set the screen position of the top of the right
. bar to #N$4004 (in the screen buffer).
  $C873,$04 Print the top of the bar.
  $C877,$03 Move down a row.
  $C87A,$04 Choose the side of the bar as the character, and #N$16 as the number
. of rows.
@ $C87E label=PrintCharacterColumn
N $C87E Prints a column of characters.
R $C87E A Character
R $C87E B Number of rows
R $C87E HL Screen position of the first character
  $C87E,$01 Keep the character.
  $C87F,$03 Print the character.
  $C882,$03 Move down a row.
  $C885,$01 Get the character back.
  $C886,$02 Loop back until the whole column has been printed.
  $C888,$01 Return.

c $C889 Colour Attribute Column
@ $C889 label=ColourAttributeColumn
D $C889 Sets a column of two attributes, down a number of rows of the attribute
. buffer.
R $C889 A Attribute
R $C889 B Number of rows
R $C889 HL Address in the attribute buffer
  $C889,$05 Add the flash colour used in the last frame (#R$BBFC) to the
. attribute.
  $C88E,$03 Set the distance to the first attribute in the next row
. (#N$18 minus one).
@ $C891 label=ColourAttributeColumn_Loop
  $C891,$06 Set two attributes and move down a row, and loop back until all of
. the rows have been coloured.
  $C897,$01 Return.

c $C898 Colour Player Attributes
@ $C898 label=ColourPlayerAttributes
D $C898 Sets a block of two attributes across, down a number of rows of the
. attribute buffer. The first attribute is made bright. Nothing is coloured when
. the player is dead.
R $C898 A' Attribute
R $C898 B Number of rows
R $C898 HL Address in the attribute buffer
  $C898,$01 Keep the attribute.
  $C899,$05 Return if the player is dead.
  $C89E,$01 Get the attribute back.
  $C89F,$05 Add the flash colour used in the last frame (#R$BBFC) to the
. attribute.
  $C8A4,$03 Set the distance to the first attribute in the next row
. (#N$18 minus one).
@ $C8A7 label=ColourPlayerAttributes_Loop
  $C8A7,$0A Set the first attribute (bright) and the second attribute
. (not bright), move down a row, and loop back until all of the rows have been
. coloured.
  $C8B1,$01 Return.

c $C8B2 Fill Attribute Rectangle
@ $C8B2 label=FillAttributeRectangle
D $C8B2 Sets a rectangle of attributes in the attribute buffer.
R $C8B2 A Attribute
R $C8B2 B Width
R $C8B2 C Height
R $C8B2 HL Address in the attribute buffer
  $C8B2,$06 Add the flash colour used in the last frame (#R$BBFC) to the
. attribute, and keep it.
  $C8B8,$07 Work out how far to move on from the end of one row of the rectangle
. to the start of the next.
@ $C8BF label=FillAttributeRectangle_Row
  $C8BF,$01 Keep the width and the height.
@ $C8C0 label=FillAttributeRectangle_Loop
  $C8C0,$04 Set the attributes of one row of the rectangle.
  $C8C4,$05 Move on to the start of the next row, and loop back until all of the
. rows have been set.
  $C8C9,$01 Return.

c $C8CA Game Selection Menu
@ $C8CA label=GameMenu
D $C8CA Shows the game selection menu, plays a tune, and waits for the options
. for the controls to be chosen. The game starts when the "0" key is pressed.
.
. The control method is held in bits 1 and 2 of #R$BBB0, and bit 3 is set when
. directional control has been chosen.
.
. #PUSHS #UDGTABLE { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$C8CA,stop=$C8E1)
. #SCR$02(game-selection-menu) } UDGTABLE# #POPS
E $C8CA View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BA7E }
. { #KNIGHTLORE$BD0C }
. { #MARTIANOIDS$BB12 }
. { #PENTAGRAM$BB74 }
. LIST#
N $C8CA Prepare the menu.
  $C8CA,$04 Flag that the frame around the screen has not been drawn.
  $C8CE,$05 Point at the attributes of the lines of the menu, and set a counter
. for eight lines.
@ $C8D3 label=GameMenu_Unflash
  $C8D3,$05 Turn off the flashing of the line, and loop back until all of the
. lines have been done.
  $C8D8,$03 Clear the playing area and the screen buffer.
  $C8DB,$03 Print the lines of the menu.
  $C8DE,$03 Make the lines for the options that have been chosen flash.
@ $C8E1 label=GameMenu_Loop
  $C8E1,$03 Print the lines of the menu.
  $C8E4,$03 Point at the menu tune.
  $C8E7,$03 Play the tune until a key is pressed.
N $C8EA Read the keys "1" to "5".
  $C8EA,$05 Read the keys "1" to "5".
  $C8EF,$01 Keep the keys that are being pressed.
  $C8F0,$06 Fetch the control options, and keep a copy to compare with later.
  $C8F6,$04 Jump to #R$C8FC unless "1" (keyboard) is being pressed.
  $C8FA,$02,b$01 Choose the keyboard.
@ $C8FC label=GameMenu_Key2
  $C8FC,$04 Jump to #R$C904 unless "2" (Kempston joystick) is being pressed.
  $C900,$04 Choose the Kempston joystick.
@ $C904 label=GameMenu_Key3
  $C904,$04 Jump to #R$C90C unless "3" (cursor joystick) is being pressed.
  $C908,$04 Choose the cursor joystick.
@ $C90C label=GameMenu_Key4
  $C90C,$04 Jump to #R$C912 unless "4" (Interface II) is being pressed.
  $C910,$02,b$01 Choose Interface II.
@ $C912 label=GameMenu_Key5
  $C912,$03 Store the control options.
  $C915,$03 Point at the flag that says that the "5" key is being held.
  $C918,$04 Jump to #R$C945 unless "5" (directional control) is being pressed.
  $C91C,$04 Jump to #R$C92A if the key was already being held.
  $C920,$02 Flag that the key is being held.
  $C922,$03 Fetch the control options.
  $C925,$02,b$01 Switch directional control on or off.
  $C927,$03 Store the control options.
@ $C92A label=GameMenu_Check
  $C92A,$04 Check whether the control options have changed.
  $C92E,$03 Point at the menu selection jingle.
  $C931,$03 Play the jingle if they have changed.
  $C934,$05 Read the keys "0" to "9".
  $C939,$03 Return to start the game if "0" is being pressed.
  $C93C,$03 Update the random number generator.
  $C93F,$03 Make the lines for the options that have been chosen flash.
  $C942,$03 Jump back to #R$C8E1 to read the keys again.
@ $C945 label=GameMenu_Key5Released
  $C945,$02 Flag that the "5" key is not being held.
  $C947,$02 Jump to #R$C92A.

c $C949 Flash Menu Options
@ $C949 label=FlashMenuOptions
D $C949 Makes the attributes of the lines of the menu for the chosen control
. method and for directional control flash.
E $C949 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BAFB }
. { #KNIGHTLORE$BD89 }
. { #PENTAGRAM$BBD8 }
. LIST#
  $C949,$03 Point at the attribute of the first control method.
  $C94C,$03 Fetch the control options.
  $C94F,$01 Move the chosen control method into the lowest two bits.
  $C950,$02,b$01 Keep only the chosen control method.
  $C952,$02 Set a counter for the four control methods.
  $C954,$03 Make the line for the chosen control method flash.
  $C957,$02 Turn off the flashing of the line for directional control.
  $C959,$03 Fetch the control options again.
  $C95C,$02,b$01 Keep only the directional control bit.
  $C95E,$01 Return if directional control has not been chosen.
  $C95F,$02 Make the line for directional control flash.
  $C961,$01 Return.

b $C962 Menu Line Attributes
@ $C962 label=MenuLineAttributes
D $C962 The attribute of each of the eight lines of the menu. Bit 7 (flash) is
. set for the lines that have been chosen.
B $C962,$01 The title: #COLOUR(#PEEK(#PC)).
@ $C963 label=MenuLineAttributes_ControlMethods
B $C963,$01 The four methods of control: #COLOUR(#PEEK(#PC)).
L $C963,$01,$04
@ $C967 label=MenuLineAttributes_DirectionalControl
B $C967,$01 Directional control: #COLOUR(#PEEK(#PC)).
B $C968,$01 Start game: #COLOUR(#PEEK(#PC)).
B $C969,$01 The copyright notice: #COLOUR(#PEEK(#PC)).

w $C96A Menu Line Positions
@ $C96A label=MenuLinePositions
D $C96A The screen position of each of the eight lines of the menu.
W $C96A,$10,$10

t $C97A Messaging: Menu Text
@ $C97A label=MenuText
D $C97A The text of each of the eight lines of the menu. The last character of
. each has bit 7 set. The character after the year is the copyright symbol.
  $C97A,$0B,10:1 "NIGHT SHADE".
  $C985,$0A,9:1 "1 KEYBOARD".
  $C98F,$13,18:1 "2 KEMPSTON JOYSTICK".
  $C9A2,$11,16:1 "3 CURSOR JOYSTICK".
  $C9B3,$0E,13:1 "4 INTERFACE II".
  $C9C1,$15,20:1 "5 DIRECTIONAL CONTROL".
  $C9D6,$0C,11:1 "0 START GAME".
  $C9E2,$0D,12:1 Copyright symbol, "1985 A.C.G.".

c $C9EF Print String
@ $C9EF label=PrintString
D $C9EF Prints a string in the main font, at a position given in pixels measured
. from the bottom left of the screen. The string ends with a character that has
. bit 7 set. The attribute for the whole string is in the shadow #REGaf, unless
. the string is printed by entering at #R$C9FC, which takes the attribute from
. the first byte of the string.
.
. #PUSHS #UDGTABLE { =h After #R$C9EF }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$C9EF,stop=$0000,xa=$46,de=$C985,hl=$8F40,sp=$5BF0)
. #SCR$02,$07,$05,$0C,$03(print-string) } UDGTABLE# #POPS
R $C9EF A' Attribute
R $C9EF DE Address of the string
R $C9EF HL Position (X in #REGl, Y in #REGh)
  $C9EF,$08 Set the font to the main font.
  $C9F7,$03 Work out the screen address of the position.
  $C9FA,$02 Jump to #R$CA0A to print the string.
@ $C9FC label=PrintStringWithAttribute
N $C9FC Prints a string that starts with an attribute.
R $C9FC DE Address of the attribute and the string
R $C9FC HL Position (X in #REGl, Y in #REGh)
  $C9FC,$08 Set the font to the main font.
  $CA04,$03 Work out the screen address of the position.
  $CA07,$03 Fetch the attribute from the start of the string, and keep it for
. printing.
@ $CA0A label=PrintString_Loop
  $CA0A,$06 Fetch the next character of the string, and jump to #R$CA16 if it is
. the last one.
  $CA10,$06 Print the character, move on to the next position and loop back.
@ $CA16 label=PrintString_Last
  $CA16,$05 Print the last character, after clearing bit 7.

c $CA1B Set Flashing Attribute
@ $CA1B label=SetFlashingAttribute
D $CA1B Sets bit 7 (flash) of the attribute of one of a number of lines of the
. menu, and resets it in the other lines.
E $CA1B View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BC15 }
. { #PENTAGRAM$BB64 }
. LIST#
R $CA1B A Number of the line to flash
R $CA1B B Number of lines
R $CA1B HL Address of the attribute of the first line
  $CA1B,$03 Jump to #R$CA25 unless this is the line to flash.
@ $CA1E label=FlashChosenLine_Flash
  $CA1E,$04 Turn on flashing for the line, and jump to #R$CA27.
@ $CA22 label=FlashChosenLine_Next
  $CA22,$03 Count down the lines, and jump to #R$CA1E when the line to flash is
. reached.
@ $CA25 label=FlashChosenLine_NoFlash
  $CA25,$02 Turn off flashing for the line.
@ $CA27 label=FlashChosenLine_Skip
  $CA27,$03 Move on to the next line, and loop back until all of the lines have
. been done.
  $CA2A,$01 Return.

c $CA2B Display Menu
@ $CA2B label=DisplayMenu
D $CA2B Prints the eight lines of the game selection menu. The first time that
. it is called it also draws the frame around the screen.
E $CA2B View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BC25 }
. { #KNIGHTLORE$BEB3 }
. { #PENTAGRAM$BCB4 }
. LIST#
.
. #PUSHS #UDGTABLE { =h Before | =h After #R$CA2B }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SCR$02(print-menu-lines-before)
. | #SIM(start=$CA2B,stop=$0000,sp=$5BF0)
. #SCR$02(print-menu-lines-after) } UDGTABLE# #POPS
  $CA2B,$03 Point at the attributes of the lines of the menu.
  $CA2E,$01 Swap to the shadow registers to keep the pointer to the attributes.
  $CA2F,$08 Point at the positions of the lines and at the text of the lines,
. and set a counter for eight lines.
@ $CA37 label=DisplayMenu_Loop
  $CA37,$03 Fetch the position of the line.
  $CA3A,$04 Keep the pointer to the positions, and put the position of the line
. into #REGhl.
  $CA3E,$01 Swap to the shadow registers.
  $CA3F,$03 Fetch the attribute of the line, and keep it for printing.
  $CA42,$01 Swap back to the main registers.
  $CA43,$03 Print the line.
  $CA46,$03 Get the pointer to the positions back, and loop back until all eight
. lines have been printed.
  $CA49,$05 Return if the frame around the screen has been drawn.
  $CA4E,$04 Flag that the frame has been drawn.
  $CA52,$03 Jump to #R$CA9D to draw the frame.

c $CA55 Draw Playing Area Border
@ $CA55 label=DrawPlayingAreaBorder
D $CA55 Draws the border around the playing area, in yellow on red.
.
. #PUSHS #UDGTABLE { =h After #R$CA55 }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$CA55,stop=$0000,sp=$5BF0)
. #SCR$02,$05,$00,$1A,$12(playing-area-border) } UDGTABLE# #POPS
  $CA55,$03 Use yellow ink on red paper (attribute #N$16), and keep it in the
. shadow #REGaf.
  $CA58,$06 Set the font to the characters of the border.
  $CA5E,$03 Point at the characters of the border.
  $CA61,$06 Draw the top left corner at #N$4005 (in the screen buffer).
  $CA67,$06 Draw the top right corner at #N$401D (in the screen buffer).
  $CA6D,$06 Draw the bottom left corner at #N$5005 (in the screen buffer).
  $CA73,$06 Draw the bottom right corner at #N$501D (in the screen buffer).
  $CA79,$08 Draw the top edge, eleven blocks long, at
. #N$4007 (in the screen buffer).
  $CA81,$08 Draw the bottom edge, eleven blocks long, at
. #N$5007 (in the screen buffer).
  $CA89,$04 Point at the characters of the sides.
  $CA8D,$08 Draw the left edge, seven blocks long, at
. #N$4045 (in the screen buffer).
  $CA95,$08 Draw the right edge, seven blocks long, at
. #N$405D (in the screen buffer).

c $CA9D Draw Frame
@ $CA9D label=DrawFrame
D $CA9D Draws the frame around the whole screen, in yellow on blue.
.
. #PUSHS #UDGTABLE { =h After #R$CA9D }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$CA9D,stop=$0000,sp=$5BF0)
. #SCR$02(screen-frame) } UDGTABLE# #POPS
  $CA9D,$03 Use bright yellow ink on blue paper (attribute #N$4E), and keep it
. in the shadow #REGaf.
  $CAA0,$06 Set the font to the characters of the border.
  $CAA6,$03 Point at the characters of the border.
  $CAA9,$06 Draw the top left corner at #N$4000 (in the screen buffer).
  $CAAF,$06 Draw the top right corner at #N$401E (in the screen buffer).
  $CAB5,$06 Draw the bottom left corner at #N$50C0 (in the screen buffer).
  $CABB,$06 Draw the bottom right corner at #N$50DE (in the screen buffer).
  $CAC1,$08 Draw the top edge, fourteen blocks long, at
. #N$4002 (in the screen buffer).
  $CAC9,$08 Draw the bottom edge, fourteen blocks long, at
. #N$50C2 (in the screen buffer).
  $CAD1,$04 Point at the characters of the sides.
  $CAD5,$08 Draw the left edge, ten blocks long, at
. #N$4040 (in the screen buffer).
  $CADD,$08 Draw the right edge, ten blocks long, at
. #N$405E (in the screen buffer).

b $CAE5 Border Block Characters
@ $CAE5 label=BorderBlockCharacters
D $CAE5 The characters that make up the border and the frame: four blocks of two
. by two characters for the corners, one for the top and bottom edges, and one
. for the sides.
B $CAE5,$18,$04

c $CAFD Draw Horizontal Edge
@ $CAFD label=DrawHorizontalEdge
D $CAFD Draws a number of blocks of two by two characters along a row.
R $CAFD A' Attribute
R $CAFD B Number of blocks
R $CAFD DE Address of the four characters in a block
R $CAFD HL Screen address of the first block
  $CAFD,$02 Keep the number of blocks and the address of the characters.
  $CAFF,$03 Print a block.
  $CB02,$02 Move on two positions to the right.
  $CB04,$02 Get the number of blocks and the address of the characters back.
  $CB06,$02 Loop back until all of the blocks have been drawn.
  $CB08,$01 Return.

c $CB09 Draw Vertical Edge
@ $CB09 label=DrawVerticalEdge
D $CB09 Draws a number of blocks of two by two characters down a column.
R $CB09 A' Attribute
R $CB09 B Number of blocks
R $CB09 DE Address of the four characters in a block
R $CB09 HL Screen address of the first block
  $CB09,$02 Keep the number of blocks and the address of the characters.
  $CB0B,$03 Print a block.
  $CB0E,$06 Move down two rows.
  $CB14,$02 Get the number of blocks and the address of the characters back.
  $CB16,$02 Loop back until all of the blocks have been drawn.
  $CB18,$01 Return.

c $CB19 Print Character
@ $CB19 label=PrintScreen
D $CB19 Prints a character on the screen, using the font pointed at by #R$BBAC.
. Both the pixels and the attribute are set.
.
. #PUSHS #UDGTABLE { =h After #R$CB19 }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #POKES$BBAC,$5E;$BBAD,$6B
. #SIM(start=$CB19,stop=$0000,a=$41,hl=$40E8,sp=$5BF0)
. #SCR$02,$07,$06,$03,$03(print-character) } UDGTABLE# #POPS
E $CB19 View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #MARTIANOIDS$B5CB }
. { #PSSST$73CD }
. { #SABREWULF$B589 }
. { #TRANZAM$6C96 }
. { #UNDERWURLDE$98DF }
. LIST#
R $CB19 A Character
R $CB19 A' Attribute
R $CB19 HL Screen address
  $CB19,$06 Print the blank character #N$3C instead of a space (#N$20).
@ $CB1F label=PrintGlyph
N $CB1F Draws the eight rows of pixels of a character, without setting the
. attribute.
  $CB1F,$03 Keep the registers safe.
  $CB22,$03 Multiply the character code by eight...
  $CB25,$03 ... to get the distance to the character in the font.
  $CB28,$06 Add the address of the font to get the address of the character.
  $CB2E,$01 Get the screen address back.
  $CB2F,$02 Set a counter for the eight rows of the character.
@ $CB31 label=PrintGlyph_Loop
  $CB31,$06 Copy a row of the character to the screen, and loop back until all
. eight rows have been drawn.
  $CB37,$02 Get the registers back.
  $CB39,$04 Move the screen address back to the top row of the character.
  $CB3D,$01 Return.

c $CB3E Print Character Block
@ $CB3E label=PrintCharacterBlock
D $CB3E Prints a block of four characters, in two rows of two, with the same
. attribute.
R $CB3E A' Attribute
R $CB3E DE Address of the four characters
R $CB3E HL Screen address of the top left character
R $CB3E O:DE Address after the four characters
  $CB3E,$01 Keep the screen address.
  $CB3F,$06 Print the top left character and move to the right.
  $CB45,$06 Print the top right character and move back to the left.
  $CB4B,$03 Move down a row.
  $CB4E,$06 Print the bottom left character and move to the right.
  $CB54,$05 Print the bottom right character.
  $CB59,$02 Get the screen address back and return.

c $CB5B Print Character With Attribute
@ $CB5B label=PrintCharacterWithAttribute
D $CB5B Prints a character on the screen and sets its attribute.
E $CB5B View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D639 }
. LIST#
R $CB5B A Character
R $CB5B A' Attribute
R $CB5B HL Screen address
  $CB5B,$03 Print the pixels of the character.
  $CB5E,$02 Keep the registers safe.
  $CB60,$07 Turn the screen address into an address in the attribute file.
  $CB67,$04 Add #N$5800, the start of the attribute buffer.
  $CB6B,$03 Set the attribute of the character.
  $CB6E,$03 Get the registers back and return.

c $CB71 Move Down Row
@ $CB71 label=MoveDownRow
D $CB71 Moves a screen address down by one character row.
E $CB71 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D64F }
. { #MARTIANOIDS$B6B2 }
. { #UNDERWURLDE$98D5 }
. LIST#
R $CB71 HL Screen address
R $CB71 O:HL The screen address one character row below
  $CB71,$05 Move down one character row, and return if that is still within the
. same third of the screen.
  $CB76,$05 Otherwise move to the first row of the next third of the screen and
. return.

c $CB7B Choose Start Position
@ $CB7B label=ChooseStartPosition
D $CB7B Chooses a random cell of the village for the player to start in,
. avoiding cells that are solid (tiles #N$01 and #N$02), and stores its column
. and row in the template for the player at #R$CC36.
  $CB7B,$03 Update the random number generator.
  $CB7E,$04 Fetch the random number.
@ $CB82 label=ChooseStartPosition_Cell
  $CB82,$04 Turn the random number into a place in the map of the village.
  $CB86,$04 Find the tile in the map.
  $CB8A,$06 Jump to #R$CB93 to use this cell unless the tile is solid
. (#N$01 or #N$02).
  $CB90,$03 Otherwise move on to the next cell and try again.
@ $CB93 label=ChooseStartPosition_Found
  $CB93,$06 Store the column of the cell in the template for the player.
  $CB99,$0C Shift the place in the map left three times, which moves the row of
. the cell into the lowest five bits of #REGd.
  $CBA5,$06 Store the row of the cell in the template for the player.
  $CBAB,$01 Return.

c $CBAC Check Player Dead
@ $CBAC label=CheckPlayerDead
D $CBAC Checks whether the player has died. If so, a new life is started (or the
. game is over if there are no lives left).
.
. The routine also checks that the instruction at #R$CBDD has not been changed,
. which is part of the copy protection. The computer is reset if it has been.
  $CBAC,$05 Return if the player is still alive.
N $CBB1 See #POKE(infinite_lives,Infinite Lives).
  $CBB1,$08 Fetch the opcode of the instruction at #R$CBDD, and reset the
. computer by jumping to #R$C1F9 unless it is #N$35 (DEC (HL)).
  $CBB9,$06 Fetch the number of lives left and jump to #R$CBC5 to start a new
. life if there are none.
  $CBBF,$06 Play the tune for losing a life.

c $CBC5 Start New Life
@ $CBC5 label=StartNewLife
D $CBC5 Starts a new life for the player: sets up the objects for the player,
. sets the player's health, uses up a life and shows the lives that are left.
. The game is over when no lives are left.
  $CBC5,$0B Copy the template for the two objects that make up the player
. (legs and body) into the object table.
  $CBD0,$05 Set the player's materialise timer to #N$28.
  $CBD5,$05 Give the player #N$03 health.
N $CBDA See #POKE(infinite_lives,Infinite Lives).
  $CBDA,$07 Use up a life, and jump to #R$CC56 if there were none left.
  $CBE1,$03 Remove the ghosts and other short-lived objects.
  $CBE4,$07 Point #REGix at the player and mark the cell that the player starts
. in as visited.
N $CBEB Draw the lives that are left.
  $CBEB,$09 Set the font to the knight icons, and use bright white ink
. (attribute #N$47).
  $CBF4,$06 Point at the characters of an icon, and set the
. screen address of the first icon to #N$5045
. (in the screen buffer).
  $CBFA,$09 Find the number of lives left, and work out the number of lives that
. have been used (#N$05 minus the lives left).
@ $CC03 label=StartNewLife_LifeLoop
  $CC03,$04 Jump to #R$CC0E if there are no more lives left to draw.
  $CC07,$07 Draw an icon, move on two positions and loop back until all of the
. lives left have been drawn.
@ $CC0E label=StartNewLife_UsedLives
  $CC0E,$03 Use blue ink (attribute #N$41) for the lives that have been used.
  $CC11,$03 Return if no lives have been used.
  $CC14,$01 Set a counter for the lives that have been used.
@ $CC15 label=StartNewLife_UsedLoop
  $CC15,$07 Draw an icon, move on two positions and loop back until all of the
. used lives have been drawn.
  $CC1C,$01 Return.

c $CC1D Draw Life Icon
@ $CC1D label=DrawLifeIcon
D $CC1D Draws the icon of a knight that shows a life, which is two blocks of two
. by two characters, one above the other.
.
. #PUSHS #UDGTABLE { =h After #R$CC1D }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #POKES$BBAC,$EF;$BBAD,$7A
. #SIM(start=$CC1D,stop=$0000,xa=$47,de=$CC2E,hl=$5060,sp=$5BF0)
. #SCR$02,$00,$12,$03,$05(life-icon) } UDGTABLE# #POPS
R $CC1D A' Attribute
R $CC1D DE Address of the characters
R $CC1D HL Screen address
  $CC1D,$02 Keep the address of the characters and the screen address.
  $CC1F,$03 Draw the top block.
  $CC22,$06 Move down two rows.
  $CC28,$03 Draw the bottom block.
  $CC2B,$03 Get the address of the characters and the screen address back, and
. return.

b $CC2E Life Icon Characters
@ $CC2E label=LifeIconCharacters
D $CC2E The characters of the two blocks that make up a life icon.
B $CC2E,$08,$04

b $CC36 Player Template
@ $CC36 label=PlayerTemplate
D $CC36 The initial state of the two objects that make up the player, copied
. into the object table by #R$CBC5 (see #R$BC8E for the fields). The column and
. the row of the first object are set by #R$CB7B before it is used.
.
. The first object is the player's legs and the second is the body.
B $CC36,$10,$10 The legs (type #N$18).
B $CC46,$10,$10 The body (type #N$20).

c $CC56 Game Over
@ $CC56 label=GameOver
D $CC56 Shows the game over screen, with the percentage of the game that has
. been completed and the score, and plays a tune. A new game is started if any
. of the monsters is still alive. Otherwise all of the monsters have been
. killed, so the ending is shown.
.
. #PUSHS #UDGTABLE { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #POKES$BBFE,$37;$BBC9,$00;$BBCA,$12;$BBCB,$30
. #SIM(start=$CC56,stop=$CC8C,sp=$5BF0)
. #SCR$02(game-over) } UDGTABLE# #POPS
N $CC56 Show the game over screen.
  $CC56,$03 Work out the percentage of the game that has been completed.
  $CC59,$06 Clear the screen and draw the frame.
  $CC5F,$09 Print "GAME OVER".
  $CC68,$06 Print "PERCENTAGE OF GAME".
  $CC6E,$06 Print "COMPLETED =".
  $CC74,$06 Print "SCORE".
  $CC7A,$09 Use bright cyan ink (attribute #N$45), and print
. the percentage at #N$4894 (in the screen buffer).
  $CC83,$09 Use bright yellow ink (attribute #N$46), and print
. the score at #N$48F0 (in the screen buffer).
N $CC8C Play the tune.
  $CC8C,$06 Play the game over tune.
  $CC92,$05 Wait for about half a second.
N $CC97 Start a new game if any of the monsters is still alive.
  $CC97,$08 Point at the first monster, set the distance from one object to the
. next (#N$0010 bytes) and set a counter for the four monsters.
@ $CC9F label=GameOver_CheckMonsters
  $CC9F,$08 Start a new game, keeping the settings, if this monster is still
. alive.
  $CCA7,$03 Move on to the next monster and loop back until all four have been
. checked.
N $CCAA All four monsters have been killed. Set up the ending.
  $CCAA,$03 Remove all of the objects.
  $CCAD,$0C Point #REGix at the first object, point at the table of pieces for
. the ending, set the distance from one object to the next (#N$0010 bytes) and
. set a counter for ten pieces.
@ $CCB9 label=GameOver_Pieces
  $CCB9,$1D Set the type and the velocities of a piece, clear its flags and
. offsets, and loop back until all ten pieces have been set up.
  $CCD6,$03 Clear the screen.
  $CCD9,$05 Flag that the game has been finished.
  $CCDE,$03 Clear the playing area.
  $CCE1,$03 Jump back to the main loop to show the ending.

b $CCE4 Ending Pieces
@ $CCE4 label=EndingPieces
D $CCE4 The ten objects of the ending, used by #R$CC56. Each has a type, and the
. X and Y screen position that is stored in the fields at offsets #N$0A and
. #N$0B.
.
. The first five are the pieces of the title graphic in a row, then four ghosts,
. then the large piece of the title graphic.
B $CCE4,$1E,$03

c $CD02 Remove All Objects
@ $CD02 label=RemoveAllObjects
D $CD02 Removes every object by setting the types of all #N$17 objects to zero.
  $CD02,$08 Point at the object table, set the distance from one object to the
. next (#N$0010 bytes) and set a counter for the #N$17 objects.
@ $CD0A label=RemoveAllObjects_Loop
  $CD0A,$05 Remove an object, and loop back until all of them have been removed.
  $CD0F,$01 Return.

c $CD10 Update Logo Piece
@ $CD10 label=UpdateLogoPiece
D $CD10 The routine for objects of type #N$98 to #N$9D, the pieces of the title
. graphic that are shown during the ending. Each piece stays where it was
. placed. It is drawn, and its attributes are set to bright white.
.
. The large piece (type #N$98) is the last piece in the object table, and waits
. for the ghosts before it: when the object before it has gone, the ending is
. over and the game starts again.
.
. #PUSHS #UDGTABLE { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$BE2D,stop=$BE71)
. #SIM(start=$CCAA,stop=$CCE1,sp=$5BF0)
. #SIM(start=$CD16,stop=$0000,ix=$BC8E,sp=$5BF0)
. #SIM(start=$CD16,stop=$0000,ix=$BC9E,sp=$5BF0)
. #SIM(start=$CD16,stop=$0000,ix=$BCAE,sp=$5BF0)
. #SIM(start=$CD16,stop=$0000,ix=$BCBE,sp=$5BF0)
. #SIM(start=$CD16,stop=$0000,ix=$BCCE,sp=$5BF0)
. #SIM(start=$CD16,stop=$0000,ix=$BD1E,sp=$5BF0)
. #SIM(start=$E200,stop=$0000,sp=$5BF0)
. #SCR$02(ending-logo) } UDGTABLE# #POPS
  $CD10,$06 Jump to #R$CD4F if the object before this one has gone, which means
. the ending is over.
@ $CD16 label=UpdateLogoPiece_Small
N $CD16 The smaller pieces start here, as they do not wait.
  $CD16,$05 Use bright white ink (attribute #N$47).
@ $CD1B label=UpdateLogoPiece_Draw
N $CD1B Draw the piece, and set its attributes.
  $CD1B,$0C Copy the X and Y position of the piece
. (kept where the velocities usually are) into the position of the sprite.
  $CD27,$03 Draw the sprite.
  $CD2A,$06 Fetch the screen position of the sprite.
  $CD30,$03 Turn the position into an address in the attribute buffer.
  $CD33,$04 Fetch the number of rows of the sprite that were drawn.
  $CD37,$08 Add the position of the sprite within a character cell and #N$05, to
. get the height of the sprite in pixels.
  $CD3F,$06 Divide by eight to get the height in characters.
  $CD45,$04 Fetch the width of the sprite in characters.
  $CD49,$03 Fetch the attribute.
  $CD4C,$03 Jump to #R$C8B2.
@ $CD4F label=UpdateLogoPiece_Finished
N $CD4F The ending is over.
  $CD4F,$09 Play the tune for completing the game, and start a new game.

c $CD58 Update Ending Ghost
@ $CD58 label=UpdateEndingGhost
D $CD58 The routine for objects of type #N$90 to #N$97, the ghosts that are
. shown during the ending. A ghost moves sideways towards the large piece of the
. title graphic, and then drops down the screen and goes away. It does not start
. until the ghost before it has gone.
  $CD58,$08 Flip the sprite of the ghost to its other frame.
  $CD60,$08 Return if the object before this one is a ghost that is still there.
  $CD68,$03 Play a tone that falls in pitch each time.
  $CD6B,$08 Work out how far the ghost is from the middle of the large piece of
. the title graphic (plus #N$04), limited to four pixels.
  $CD73,$03 Jump to #R$CD8A if the ghost has arrived.
  $CD76,$06 Move the ghost sideways by that amount.
@ $CD7C label=UpdateEndingGhost_Draw
  $CD7C,$0B Set the colour of the ghost from its sprite
. (bright red, magenta, green or cyan).
  $CD87,$03 Draw the ghost.
@ $CD8A label=UpdateEndingGhost_Drop
  $CD8A,$0C Move the ghost down the screen by four pixels, and jump to #R$CD7C
. to draw it unless it has reached the bottom.
  $CD96,$08 Stop the falling tone and remove the ghost.

c $CD9E Limit Distance
@ $CD9E label=LimitDistance
D $CD9E Subtracts a position from a target and limits the difference to four
. pixels in either direction.
R $CD9E A Target position
R $CD9E IX Object
R $CD9E O:A The distance to move, from #N$FC to #N$04
  $CD9E,$05 Work out how far the object is from the target along the X axis, and
. jump to #R$CDA9 if the target is on the left.
  $CDA3,$03 Return if the distance is less than four.
  $CDA6,$03 Limit the distance to four and return.
@ $CDA9 label=LimitDistance_Negative
  $CDA9,$03 Return if the distance is #N$FC or more, which means it is less than
. four to the left.
  $CDAC,$03 Limit the distance to minus four and return.

t $CDAF Messaging: Game Over Text
@ $CDAF label=GameOverText
D $CDAF The strings that are shown on the game over screen. Each string starts
. with its attribute.
  $CDAF,$0B,h$01,$09:$01 Attribute: #COLOUR(#PEEK(#PC)) + "GAME  OVER".
  $CDBA,$13,h$01,$11:$01 Attribute: #COLOUR(#PEEK(#PC)) + "PERCENTAGE OF GAME".
  $CDCD,$0C,h$01,$0A:$01 Attribute: #COLOUR(#PEEK(#PC)) + "COMPLETED =".
  $CDD9,$06,h$01,$04:$01 Attribute: #COLOUR(#PEEK(#PC)) + "SCORE".

c $CDDF Pause For Half A Second
@ $CDDF label=Wait
D $CDDF Waits for about half a second.
  $CDDF,$03 Set the counter to zero, so that it counts down #N$10000 times.
@ $CDE2 label=Wait_Loop
  $CDE2,$05 Count down until the counter is zero.
  $CDE7,$01 Return.

c $CDE8 Spawn Ball
@ $CDE8 label=SpawnBall
D $CDE8 Starts a ball (a type #N$80 object, which turns into a creature - see
. #R$C164) in one of the short-lived objects at #R$BD9E. It is done on every
. fourth frame, once the player has finished materialising, and the ball is
. placed in a cell that is next to the player or the same one as the player, as
. long as that cell is not solid.
  $CDE8,$06 Return unless the player has finished materialising.
  $CDEE,$07 Return unless this is the fourth frame
. (the frame counter is #N$03 modulo four).
  $CDF5,$09 Point at the first short-lived object, set the distance from one
. object to the next (#N$0010 bytes) and set a counter for the six objects.
@ $CDFE label=SpawnBall_Loop
  $CDFE,$06 Jump to #R$CE09 if the object is free.
  $CE04,$04 Move on to the next object and loop back until all six have been
. checked.
  $CE08,$01 Return, as there is no free object.
@ $CE09 label=SpawnBall_Found
  $CE09,$03 Point at the template for a ball.
  $CE0C,$03 Point at the free object.
  $CE0F,$05 Copy the template into the object.
N $CE14 Choose the cell for the ball: the player's cell, with the column and row
. each moved by one cell, or not moved, using the random seeds.
  $CE14,$08 Fetch the column and row of the player's cell.
  $CE1C,$07 Jump to #R$CE2A to keep the column as it is if the first random
. number is less than #N$55.
  $CE23,$04 Jump to #R$CE29 to move the ball on one column if the number is less
. than #N$AA.
  $CE27,$02 Move the ball back one column...
@ $CE29 label=SpawnBall_NextColumn
  $CE29,$01 ... or on one column.
@ $CE2A label=SpawnBall_Row
  $CE2A,$07 Jump to #R$CE38 to keep the row as it is if the second random number
. is less than #N$55.
  $CE31,$04 Jump to #R$CE37 to move the ball on one row if the number is less
. than #N$AA.
  $CE35,$02 Move the ball back one row...
@ $CE37 label=SpawnBall_NextRow
  $CE37,$01 ... or on one row.
@ $CE38 label=SpawnBall_Place
  $CE38,$04 Wrap the column round, to stay within the village.
  $CE3C,$04 Wrap the row round, to stay within the village.
  $CE40,$05 Find out what kind of tile is in the cell.
  $CE45,$04 Return without making a ball if the tile is solid (#N$01 or #N$02).
  $CE49,$06 Set the column and the row of the ball.
N $CE4F Choose the position of the ball within the cell using the random seeds.
  $CE4F,$03 Update the random number generator.
  $CE52,$07 Fetch the first random number and jump to #R$CE5B if it is less than
. #N$C0.
  $CE59,$02 Bring the number into the range #N$80 to #N$BF.
@ $CE5B label=SpawnBall_X
  $CE5B,$05 Add #N$20 to get a position within the cell from #N$20 to #N$DF, and
. set it as the X position of the ball.
  $CE60,$07 Fetch the second random number and jump to #R$CE69 if it is less
. than #N$C0.
  $CE67,$02 Bring the number into the range #N$80 to #N$BF.
@ $CE69 label=SpawnBall_Y
  $CE69,$05 Add #N$20 to get a position within the cell from #N$20 to #N$DF, and
. set it as the Y position of the ball.
  $CE6E,$06 Return if the frame counter is #N$80 or more.
  $CE74,$05 Set the flag that makes the ball chase the player, and return.

b $CE79 Ball Template
@ $CE79 label=BallTemplate
D $CE79 The initial state of a ball, copied into the object table by #R$CDE8
. (see #R$BC8E for the fields). The type is #N$80, the speed is #N$06 and the
. size is #N$10 by #N$10.
B $CE79,$10,$10

c $CE89 Update Spore
@ $CE89 label=UpdateSpore
D $CE89 The routine for objects of type #N$40 to #N$4F, the spores. A spore
. wanders about at random, and vanishes when the player is more than three cells
. away. If a shot hits it, both the spore and the shot burst. If the player
. touches it, the spore bursts and the player is hurt. Either way, #N$05 hundred
. points are added to the score.
  $CE89,$02 Use #N$07 as the number of random bits for the velocity.
  $CE8B,$03 Choose a new random velocity when the timer has run out.
  $CE8E,$03 Make the spore face the way that it is moving.
  $CE91,$03 Move the spore.
  $CE94,$03 Animate the spore.
  $CE97,$08 Check whether the view is turned round, to flip the sprite to match.
  $CE9F,$09 Set or clear the flip flag of the spore.
  $CEA8,$05 Set the distance to #N$03 cells and check whether the spore is that
. close to the player.
  $CEAD,$02 Jump to #R$CEF3 to remove the spore if it is further away.
  $CEAF,$05 Check whether a shot has hit the spore, and jump to #R$CEE5 if it
. has.
  $CEB4,$04 Check whether the spore is touching the player, and return if it is
. not.
  $CEB8,$03 Add the points for the spore to the score.

c $CEBB Hurt Player
@ $CEBB label=HurtPlayer
D $CEBB Turns the object that has touched the player into a burst, and takes one
. point of health from the player. When the player has no health left, the
. player dies.
E $CEBB Continue on to #R$CEC4.
R $CEBB IX Object that touched the player
  $CEBB,$04 Turn the object that touched the player into a burst.
N $CEBF See #POKE(infinite_health,Infinite Health).
  $CEBF,$05 Take one point of health from the player, and return if there is
. some left.

c $CEC4 Kill Player
@ $CEC4 label=KillPlayer
D $CEC4 Kills the player by turning both of the player's objects into bursts.
. The position and the direction of the player are kept in the template at
. #R$CC36 so that the next life starts in the same place.
  $CEC4,$06 Keep the column of the player in the template for the next life.
  $CECA,$06 Keep the row of the player in the template.
  $CED0,$06 Keep the direction and timer of the player in the template.
  $CED6,$06 Keep the flags of the player in the template.
  $CEDC,$08 Turn both of the player's objects into bursts.
  $CEE4,$01 Return.

c $CEE5 Burst Spore And Shot
@ $CEE5 label=BurstSporeAndShot
D $CEE5 Turns the shot and the spore into bursts, and adds #N$05 hundred points
. to the score.
R $CEE5 IX Spore
R $CEE5 IY Shot
  $CEE5,$04 Turn the shot into a burst.
  $CEE9,$04 Turn the spore into a burst.
@ $CEED label=BurstSporeAndShot_Score
  $CEED,$06 Add #N$05 hundred points to the score.
@ $CEF3 label=BurstSporeAndShot_Remove
N $CEF3 The spore is too far from the player, so remove it.
  $CEF3,$05 Remove the spore and return.

c $CEF8 Next Sprite Number
@ $CEF8 label=NextSpriteNumber
D $CEF8 Moves an object on to the next of its four sprites, by adding one to the
. lowest two bits of the type and wrapping around.
E $CEF8 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B18C }
. { #GUNFRIGHT$CCAE }
. { #KNIGHTLORE$B98C }
. { #MARTIANOIDS$B063 }
. LIST#
R $CEF8 IX Object
  $CEF8,$08 Add one to the lowest two bits of the type, wrapping round, to
. choose the next sprite.
  $CF00,$07 Put them back in the type of the object.
  $CF07,$01 Return.

c $CF08 Draw View
@ $CF08 label=DrawView
D $CF08 Draws the view of the village in the pixel buffer, as seen from the
. player. The view is made of cells of the map, drawn from the furthest to the
. nearest, with the objects that are in each cell drawn after the cell.
.
. The cells around the player are drawn in an order that depends on which of the
. five cells beside the player's cell are not empty. A pattern of five bits is
. made from them and used to find an entry in the table at #R$6204, which is
. made of five bytes for each pattern. Each byte gives one cell to draw: bits 0
. and 1 choose what to draw (0 for only the objects in the cell, 1 for the cell
. with its walls, 2 for the cell); bits 4 and 5 give the column (0 for one back,
. 1 for one on, 2 or 3 for the same one); and bits 6 and 7 give the row in the
. same way.
.
. #PUSHS #UDGTABLE { =h Before | =h After #R$CF08 }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$BE2D,stop=$BE71)
. #SCR$02,$05,$00,$1A,$12(draw-view-before)
. | #SIM(start=$CF08,stop=$0000,sp=$5BF0)
. #SIM(start=$E200,stop=$0000,sp=$5BF0)
. #SCR$02,$05,$00,$1A,$12(draw-view-after) } UDGTABLE# #POPS
E $CF08 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C0F8 }
. LIST#
  $CF08,$06 Mark the columns that are outside the view as already drawn
. (see #R$BBBB).
  $CF0E,$08 Fetch the column and the row of the player's cell.
  $CF16,$03 Turn them into the column and the row in the view, if the view is
. turned round.
  $CF19,$01 Keep the player's cell.
  $CF1A,$02 Start with an empty pattern of cells.
N $CF1C Make the pattern of the five cells next to the player's cell that are
. not empty.
  $CF1C,$09 Set bit 0 if the cell one column back and one row on is not empty.
@ $CF25 label=DrawView_Pattern1
  $CF25,$0A Set bit 1 if the cell one column back is not empty.
@ $CF2F label=DrawView_Pattern2
  $CF2F,$0A Set bit 2 if the cell one row on is not empty.
@ $CF39 label=DrawView_Pattern3
  $CF39,$0B Set bit 3 if the cell one column back and one row back is not empty.
@ $CF44 label=DrawView_Pattern4
  $CF44,$0B Set bit 4 if the cell one column on and one row on is not empty.
N $CF4F Find the entry in the table at #R$6204 for the pattern.
@ $CF4F label=DrawView_FindEntry
  $CF4F,$10 Find the entry in the table for the pattern, and set a counter for
. five cells.
@ $CF5F label=DrawView_Cell
  $CF5F,$04 Get the player's cell back and fetch the next byte of the entry.
  $CF63,$04 Keep the column as it is if bit 5 is set.
  $CF67,$04 Jump to #R$CF6D to move the column back one if bit 4 is clear.
  $CF6B,$02 Move the column on two...
@ $CF6D label=DrawView_ColumnBack
  $CF6D,$01 ... and back one, to give one on.
@ $CF6E label=DrawView_Row
  $CF6E,$04 Keep the row as it is if bit 7 is set.
  $CF72,$04 Jump to #R$CF78 to move the row back one if bit 6 is clear.
  $CF76,$02 Move the row on two...
@ $CF78 label=DrawView_RowBack
  $CF78,$01 ... and back one, to give one on.
@ $CF79 label=DrawView_Select
  $CF79,$08 Keep the counter and the address of the entry, and make #R$CF8D the
. address to return to.
  $CF81,$03 Draw only the objects in the cell if bits 0 and 1 are 0.
  $CF84,$04 Draw the cell with its walls if bits 0 and 1 are 1.
  $CF88,$04 Draw the cell if bits 0 and 1 are 2.
  $CF8C,$01 Throw away the address to return to.
@ $CF8D label=DrawView_Next
  $CF8D,$04 Get the address of the entry and the counter back, and loop back
. until all five cells have been drawn.
N $CF91 Draw the player's cell and the three cells next to it that are nearer to
. the viewer, with the objects in each.
  $CF91,$05 Draw the player's cell, and the objects in it.
  $CF96,$06 Draw the cell one row back, and the objects in it.
  $CF9C,$06 Draw the cell one column on, and the objects in it.
  $CFA2,$03 Move to the cell one column on and one row back, and draw it and its
. objects in the routine that follows.

c $CFA5 Draw Cell And Objects
@ $CFA5 label=DrawCellAndObjects
D $CFA5 Draws a cell of the map and then the objects that are in it.
R $CFA5 H Row in the view
R $CFA5 L Column in the view
  $CFA5,$05 Draw the cell.
@ $CFAA label=DrawObjectsInCell
N $CFAA Draw only the objects in the cell.
  $CFAA,$05 Make a list of the objects in the cell, and draw them in the routine
. that follows.

c $CFAF Find Objects In Cell
@ $CFAF label=FindObjectsInCell
D $CFAF Makes a list of the objects that are in a cell, at #R$D15D, ending with
. a zero word.
E $CFAF View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C1A4 }
. LIST#
R $CFAF H Row in the view
R $CFAF L Column in the view
  $CFAF,$08 Point #REGiy at the list and #REGix at the first object.
  $CFB7,$04 Turn the cell into the column and the row on the map.
@ $CFBB label=FindObjectsInCell_Loop
  $CFBB,$06 Jump to #R$CFDA to move on if the object is free.
  $CFC1,$06 Jump to #R$CFDA to move on if the object is not in the column.
  $CFC7,$06 Jump to #R$CFDA to move on if the object is not in the row.
  $CFCD,$03 Get the address of the object.
  $CFD0,$06 Add the address of the object to the list.
  $CFD6,$04 Move on to the next place in the list.
@ $CFDA label=FindObjectsInCell_Next
  $CFDA,$05 Move on to the next object.
  $CFDF,$03 Get the address of the object.
  $CFE2,$06 Check whether the end of the object table at #R$BDFE has been
. reached.
  $CFE8,$02 Loop back until all #N$17 objects have been checked.
  $CFEA,$07 Add the zero word that marks the end of the list.
  $CFF1,$01 Return.

c $CFF2 Draw Objects In List
@ $CFF2 label=DrawObjectsInList
D $CFF2 Draws the objects in the list at #R$D15D, from the furthest away to the
. nearest. It repeatedly finds the object that has no other object behind it,
. draws it, and then marks it as drawn by clearing bit 7 of the high byte of its
. entry in the list.
E $CFF2 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C1E7 }
. LIST#
  $CFF2,$03 Point at the list.
@ $CFF5 label=DrawObjectsInList_Next
  $CFF5,$04 Fetch the next entry in the list.
  $CFF9,$03 Return if it is the zero word that marks the end of the list.
  $CFFC,$04 Skip the entry if the object has been drawn already.
  $D000,$06 Keep the place in the list, and point #REGix at the object.
N $D006 Compare the object at #REGix with each of the objects after it, and make
. the object that must be drawn first the one at #REGix.
@ $D006 label=DrawObjectsInList_Compare
  $D006,$04 Fetch the next entry in the list.
  $D00A,$05 Jump to #R$D094 to draw the object if it is the zero word that marks
. the end of the list.
  $D00F,$04 Skip the entry if the object has been drawn already.
  $D013,$06 Keep the place in the list, and point #REGiy at the object.
  $D019,$02 Start with a relation of zero.
N $D01B Compare the extents of the two objects along the X axis. The relation in
. #REGc becomes 0 if the object at #REGix is wholly beyond the object at #REGiy,
. 1 if they overlap and 2 if it is wholly before it.
  $D01B,$0A Work out the largest extent of the object at #REGiy.
  $D025,$0A Work out the smallest extent of the object at #REGix, and subtract
. the largest extent of the object at #REGiy.
  $D02F,$02 Jump to #R$D049 if the object at #REGix is wholly beyond it.
  $D031,$0A Work out the largest extent of the object at #REGix.
  $D03B,$0A Work out the smallest extent of the object at #REGiy, and subtract
. the largest extent of the object at #REGix.
  $D045,$02 Jump to #R$D048 if they overlap.
  $D047,$01 Add one to the relation...
@ $D048 label=DrawObjectsInList_Overlap
  $D048,$01 ... and add one to the relation.
N $D049 Compare the extents along the Y axis in the same way, adding 0, 3 or 6
. to the relation.
@ $D049 label=DrawObjectsInList_Y
  $D049,$0A Work out the largest extent of the object at #REGiy.
  $D053,$0A Work out the smallest extent of the object at #REGix, and subtract
. the largest extent of the object at #REGiy.
  $D05D,$01 Fetch the relation.
  $D05E,$02 Jump to #R$D07B if the object at #REGix is wholly beyond it.
  $D060,$0A Work out the largest extent of the object at #REGix.
  $D06A,$0A Work out the smallest extent of the object at #REGiy, and subtract
. the largest extent of the object at #REGix.
  $D074,$01 Fetch the relation.
  $D075,$02 Jump to #R$D079 if they overlap.
  $D077,$02 Add three to the relation...
@ $D079 label=DrawObjectsInList_YOverlap
  $D079,$02 ... and add three more to the relation.
@ $D07B label=DrawObjectsInList_Relation
  $D07B,$01 Keep the relation.
  $D07C,$07 Fetch the flag that tells whether the view is turned round.
  $D083,$04 Add nine to the relation if it is.
@ $D087 label=DrawObjectsInList_Choose
  $D087,$07 Run the routine in the table at #R$D0A0 for the relation, which does
. nothing if the object at #REGix is to be drawn first, and otherwise makes the
. object at #REGiy the object at #REGix (see #R$D0C5), or compares them further.
  $D08E,$06 Get the place in the list back, and loop back to compare with the
. next entry.
@ $D094 label=DrawObjectsInList_Draw
  $D094,$06 Mark the entry for the object at #REGix as drawn.
  $D09A,$03 Draw the object.
  $D09D,$03 Go back to draw the objects that are left in the list.

w $D0A0 Object Order Table
@ $D0A0 label=ObjectOrderTable
D $D0A0 The routines that #R$CFF2 runs to decide which of two objects to draw
. first, chosen by the relation between them. The relation is made from the
. relation along the X axis (0 to 2) and three times the relation along the Y
. axis (0 to 2), and nine is added to it when the view is rotated. The routine
. is #R$D0C4 if the first object stays, #R$D0C5 if the second object is chosen,
. and #R$D0D0 if they have to be compared further.
W $D0A0,$24,$02

c $D0C4 Keep Object
@ $D0C4 label=KeepObject
D $D0C4 Does nothing, which leaves the object at #REGix as the one to draw
. first.
  $D0C4,$01 Return.

c $D0C5 Choose Other Object
@ $D0C5 label=ChooseOtherObject
D $D0C5 Makes the object at #REGiy the one to draw first.
E $D0C5 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C2BA }
. LIST#
R $D0C5 IY Object
R $D0C5 O:IX Object
  $D0C5,$06 Make the place in the list the place of the object at #REGiy.
  $D0CB,$04 Make that object the one to draw first.
  $D0CF,$01 Return.

c $D0D0 Compare Object Depths
@ $D0D0 label=CompareObjectDepths
D $D0D0 Decides which of two objects that overlap along both axes is drawn
. first, by working out a value for each from the corners of the object, in
. units of half a cell, that measures how far it is along the diagonal of the
. view. The object at #REGix is kept if its value is not less than that of the
. object at #REGiy, otherwise the object at #REGiy is chosen.
E $D0D0 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C2C5 }
. LIST#
R $D0D0 IX First object
R $D0D0 IY Second object
R $D0D0 O:IX The object to draw first
  $D0D0,$07 Jump to #R$D125 if the view is turned round.
  $D0D7,$0A Work out the largest X extent of the object at #REGiy.
  $D0E1,$02 Clear the high byte of the extent.
  $D0E3,$0A Work out the smallest Y extent of the object at #REGiy.
  $D0ED,$02 Clear the high byte of the extent.
  $D0EF,$03 Subtract the X extent from the Y extent, to measure how far along
. the diagonal of the view the object is.
  $D0F2,$04 Add #N$0100 to keep the result positive.
  $D0F6,$04 Halve it.
  $D0FA,$01 Keep the result for the object at #REGiy.
  $D0FB,$0A Work out the largest X extent of the object at #REGix.
  $D105,$02 Clear the high byte of the extent.
  $D107,$06 Fetch the smallest Y extent of the object at #REGix.
@ $D10D label=CompareObjectDepths_Second
  $D10D,$04 Convert it into the same units.
  $D111,$02 Clear the high byte of the extent.
  $D113,$03 Subtract the X extent from the Y extent.
  $D116,$04 Add #N$0100 to keep the result positive.
  $D11A,$04 Halve it.
  $D11E,$03 Subtract the result for the object at #REGiy.
  $D121,$01 Return if the value for the object at #REGix is not less, which
. keeps it as the one to draw first.
  $D122,$03 Choose the object at #REGiy instead.
@ $D125 label=CompareObjectDepths_Rotated
N $D125 The view is rotated, so the other corners of the objects are compared.
  $D125,$0A Work out the smallest X extent of the object at #REGix.
  $D12F,$02 Clear the high byte of the extent.
  $D131,$0A Work out the largest Y extent of the object at #REGix.
  $D13B,$02 Clear the high byte of the extent.
  $D13D,$03 Subtract the X extent from the Y extent.
  $D140,$04 Add #N$0100 to keep the result positive.
  $D144,$04 Halve it.
  $D148,$01 Keep the result for the object at #REGix.
  $D149,$0A Work out the smallest X extent of the object at #REGiy.
  $D153,$02 Clear the high byte of the extent.
  $D155,$06 Fetch the largest Y extent of the object at #REGiy.
  $D15B,$02 Jump to #R$D10D to compare the results.

s $D15D Object List
@ $D15D label=ObjectList
D $D15D The list of the objects in a cell that is being drawn, made by #R$CFAF.
S $D15D,$20,$20

c $D17D Convert Cell
@ $D17D label=ConvertCell
D $D17D Converts the column and the row of a cell between the map and the view,
. which are the same unless the view is rotated, when both are turned around.
E $D17D View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C372 }
. LIST#
R $D17D H Row
R $D17D L Column
R $D17D O:H Row converted
R $D17D O:L Column converted
  $D17D,$06 Return if the view is not turned round.
  $D183,$05 Turn the column round by subtracting it from #N$1F.
  $D188,$05 Turn the row round by subtracting it from #N$1F.
  $D18D,$01 Return.

c $D18E Convert Position
@ $D18E label=ConvertPosition
D $D18E Converts a position along one axis of the map into the position in the
. view, which is the same unless the view is rotated, when the position is
. turned around.
E $D18E View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C383 }
. LIST#
R $D18E H Tile
R $D18E L Fraction
R $D18E O:H Tile converted
R $D18E O:L Fraction converted
  $D18E,$06 Return if the view is not turned round.
  $D194,$03 Turn the fraction round.
  $D197,$05 Turn the tile round by subtracting it from #N$1F.
  $D19C,$01 Return.

c $D19D Draw Cell
@ $D19D label=DrawCell
D $D19D Draws a cell of the map from the two lists of strips for its tile. Each
. list is made of sixteen strips, which are drawn along the edge of the cell:
. the first list from left to right and the second list from right to left.
. Nothing is drawn if the cell is empty. When the view is rotated, the lists are
. drawn in the opposite order.
E $D19D View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C392 }
. LIST#
R $D19D H Row in the view
R $D19D L Column in the view
  $D19D,$04 Find the tile of the cell, and return if the cell is empty.
  $D1A1,$02 Double the tile to give the number of its first list, and keep it.
  $D1A3,$03 Work out the position of the cell on the screen.
  $D1A6,$02 Get the number of the list back, and keep it again.
  $D1A8,$07 Jump to #R$D1F2 if the view is turned round.
  $D1AF,$03 Draw the first list from left to right.
  $D1B2,$03 Get the number of the list back and make it the number of the second
. list.
@ $D1B5 label=DrawCell_RightToLeft
N $D1B5 Draw a list of strips from right to left, starting with the last strip
. that was drawn.
  $D1B5,$0A Move the position back to the last strip that was drawn.
  $D1BF,$06 Find the list of strips.
  $D1C5,$03 Use the list of strips.
  $D1C8,$04 Clear the flag for the strips to be mirrored.
  $D1CC,$03 Set a counter for eight strips, and the variant of the strips.
@ $D1CF label=DrawCell_Down
  $D1CF,$08 Draw a strip and step down and to the left, until eight strips have
. been drawn.
  $D1D7,$0A Move the position of the strips up one step.
  $D1E1,$05 Set the flag for the strips to be mirrored.
  $D1E6,$03 Set a counter for eight strips, and the variant of the strips.
@ $D1E9 label=DrawCell_Up
  $D1E9,$08 Draw a strip and step up and to the left, until eight more strips
. have been drawn.
  $D1F1,$01 Return.
@ $D1F2 label=DrawCell_Rotated
N $D1F2 The view is rotated, so draw the lists in the opposite order.
  $D1F2,$08 Draw the second list from left to right and then the first list from
. right to left.

c $D1FA Draw Strips Left To Right
@ $D1FA label=DrawStripsLeftToRight
D $D1FA Draws a list of sixteen strips along the edge of a cell from left to
. right: eight strips going up and to the right, and then eight going down and
. to the right, which are mirrored.
E $D1FA View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C3EF }
. LIST#
R $D1FA A Number of the list
  $D1FA,$06 Find the list of strips.
  $D200,$03 Use the list of strips.
  $D203,$04 Clear the flag for the strips to be mirrored.
  $D207,$03 Set a counter for eight strips, and the variant of the strips.
@ $D20A label=DrawStripsLeftToRight_Up
  $D20A,$08 Draw a strip and step up and to the right, until eight strips have
. been drawn.
  $D212,$0A Move the position of the strips down one step.
  $D21C,$05 Set the flag for the strips to be mirrored.
  $D221,$03 Set a counter for eight strips, and the variant of the strips.
@ $D224 label=DrawStripsLeftToRight_Down
  $D224,$08 Draw a strip and step down and to the right, until eight more strips
. have been drawn.
  $D22C,$01 Return.

c $D22D Step Down Right
@ $D22D label=StepDownRight
D $D22D Moves the position of the strips down eight pixels and right sixteen
. pixels.
E $D22D View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C422 }
. LIST#
  $D22D,$05 Set the step down to eight.

c $D232 Step Down Right In List
@ $D232 label=StepDownRightInList
D $D232 Moves the position of the strips down eight pixels and right sixteen
. pixels, and moves on to the next strip in the list.
  $D232,$03 Set the step down to eight.
@ $D235 label=StepInList
N $D235 Move on to the next strip in the list, and move the position.
  $D235,$04 Move on to the next strip in the list.
@ $D239 label=StepRight
N $D239 Move the position of the strips down by the step (in #REGde) and right
. sixteen pixels.
  $D239,$07 Add the step to the Y position of the strips.
  $D240,$0A Add sixteen to the X position of the strips.
  $D24A,$01 Return.

c $D24B Step Up Right In List
@ $D24B label=StepUpRightInList
D $D24B Moves the position of the strips up eight pixels and right sixteen
. pixels, and moves on to the next strip in the list.
  $D24B,$05 Set the step up to eight, and move on to the next strip in the list.

c $D250 Step Up Right
@ $D250 label=StepUpRight
D $D250 Moves the position of the strips up eight pixels and right sixteen
. pixels.
  $D250,$05 Set the step up to eight and move the position.

c $D255 Step Down Left In List
@ $D255 label=StepDownLeftInList
D $D255 Moves the position of the strips down eight pixels and left sixteen
. pixels, and moves on to the next strip in the list.
  $D255,$03 Set the step down to eight.
@ $D258 label=StepLeftInList
N $D258 Move on to the next strip in the list, and move the position by the step
. (in #REGde) and left sixteen pixels.
  $D258,$04 Move on to the next strip in the list.
  $D25C,$07 Add the step to the Y position of the strips.
  $D263,$0A Subtract sixteen from the X position of the strips.
  $D26D,$01 Return.

c $D26E Step Up Left In List
@ $D26E label=StepUpLeftInList
D $D26E Moves the position of the strips up eight pixels and left sixteen
. pixels, and moves on to the next strip in the list.
  $D26E,$05 Set the step up to eight and move the position.

c $D273 Draw Strip
@ $D273 label=DrawStrip
D $D273 Draws one strip of a cell, which is a graphic that is sixteen pixels
. wide. A strip is not drawn if its position is outside the view.
E $D273 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C468 }
. LIST#
R $D273 C Variant of the strip (0 or 1)
R $D273 IY Entry in the list of strips
  $D273,$0B Return if the X position of the strip is more than #N$CF, which is
. off the right of the view.
  $D27E,$06 Return if the X position of the strip is #N$10 or less, which is off
. the left of the view.
  $D284,$06 Return if the Y position of the strip is outside the range #N$00 to
. #N$FF.
  $D28A,$03 Use the Y position of the strip, and keep the variant of the strip.
  $D28D,$05 Fetch the number of the strip.
  $D292,$05 Combine the variant with the entry for the strip in the table at
. #R$6542.
  $D297,$06 Find the graphic for the strip.
  $D29D,$03 Draw the graphic.
  $D2A0,$02 Get the variant back, and return.

c $D2A2 Clip Edge Strip Top
@ $D2A2 label=ClipEdgeStripTop
D $D2A2 Skips the rows of a strip that are
. below #R$E5C4. #REGa is the number of those
. rows, negated. It starts drawing at #N$48 and
. jumps to #R$D2C1.
E $D2A2 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C497 }
. LIST#
R $D2A2 A The number of rows below the buffer, negated
R $D2A2 HL The address of the strip
N $D2A2 Skip the rows that are below the buffer.
  $D2A2,$03 Make the number of rows positive and keep it in #REGc.
  $D2A5,$02 Fetch the height of the strip.
  $D2A7,$01 Subtract the rows that are below.
  $D2A8,$02 Return if there are none left.
  $D2AA,$04 Skip the image data for those rows.
  $D2AE,$02 Set the vertical position to #N$48.
  $D2B0,$02 Jump to #R$D2C1.

c $D2B2 Draw Strip Graphic
@ $D2B2 label=DrawStripGraphic
D $D2B2 Draws a strip which is sixteen pixels
. wide into #R$E5C4, combining it with what is
. already there. The strip starts with a byte
. for the number of rows, followed by two bytes
. for each row. It is drawn from the bottom row
. up, and is cut off at the bottom and top of
. the buffer. The position is in #R$BBB6 and
. the strip is moved to the right by #N($00),
. #N($02), #N$04 or #N$06 pixels, using #R$FA00
. and #R$F200. The strip is flipped if #R$BBF2
. is not zero.
.
. #PUSHS #UDGTABLE { =h After #R$D2B2 }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$BE2D,stop=$BE71)
. #SIM(start=$D2B2,stop=$0000,de=$7850,hl=$6FE4,sp=$5BF0)
. #SIM(start=$E200,stop=$0000,sp=$5BF0)
. #SCR$02,$05,$00,$1A,$12(draw-strip-graphic) } UDGTABLE# #POPS
E $D2B2 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C4A7 }
. LIST#
R $D2B2 D The vertical position of the bottom of the strip
R $D2B2 E The horizontal position of the strip
R $D2B2 HL The address of the graphic
N $D2B2 Clip the strip to the buffer.
  $D2B2,$03 Subtract #N$48 from the vertical position.
  $D2B5,$02 Jump to #R$D2A2 if it is below the bottom.
  $D2B7,$02 Subtract #N$70.
  $D2B9,$01 Return if it is above the top.
  $D2BA,$02 Make it the number of rows in the buffer.
  $D2BC,$03 Jump to #R$D2C0 if it is fewer.
  $D2BF,$01 Use the height of the strip.
N $D2C0 Draw the rows that are in the buffer.
@ $D2C0 label=DrawStripGraphic_Height
  $D2C0,$01 Move on to the first row of the graphic.
@ $D2C1 label=DrawStripGraphic_Draw
  $D2C1,$01 Keep the number of rows in #REGa'.
  $D2C2,$01 Put the position in #REGhl.
  $D2C3,$03 Call #R$E53A.
  $D2C6,$01 Switch the buffer and the graphic.
  $D2C7,$04 Set #R$BBAE.
  $D2CB,$01 Point the stack at the graphic.
N $D2CC Choose the draw path.
  $D2CC,$03 Fetch #R$BBB6.
  $D2CF,$02,b$01 Keep bits 1 and 2.
  $D2D1,$02 Jump to #R$D323 if the strip is aligned.
  $D2D3,$02,b$01 Set the high bits of the page.
  $D2D5,$01 Set #REGh.
  $D2D6,$03 Fetch #R$BBF2.
  $D2D9,$03 Jump to #R$D302 if it is set.
  $D2DC,$02 Set bit 3 of #REGh.
  $D2DE,$01 Switch in the number of rows.
N $D2DF Draw a shifted row.
@ $D2DF label=DrawStripGraphic_Shifted
  $D2DF,$01 Keep the number of rows in #REGa'.
  $D2E0,$02 Fetch a row and point at the first byte.
  $D2E2,$03 Combine the bits which stay with the first byte of the buffer.
  $D2E5,$02 Move on to the next byte and page.
  $D2E7,$02 Combine the bits which moved on from the first byte.
  $D2E9,$02 Point at the second byte of the graphic.
  $D2EB,$02 Combine its bits which stay and store the byte.
  $D2ED,$02 Move on to the next byte and page.
  $D2EF,$03 Combine the bits which moved on with the next byte of the buffer.
  $D2F2,$01 Go back to the first page.
  $D2F3,$06 Move on to the next row of the buffer.
  $D2F9,$01 Switch in the number of rows.
  $D2FA,$01 Count it down.
  $D2FB,$02 Jump to #R$D2DF until the rows are done.
N $D2FD Put the stack back.
@ $D2FD label=DrawStripGraphic_Done
  $D2FD,$05 Fetch #R$BBAE and return.
N $D302 Draw a shifted row that is flipped.
@ $D302 label=DrawStripGraphic_MirroredShifted
  $D302,$01 Switch in the number of rows.
@ $D303 label=DrawStripGraphic_MirroredLoop
  $D303,$01 Keep the number of rows in #REGa'.
  $D304,$02 Fetch a row and point at the second byte.
  $D306,$03 Combine the bits which stay with the first byte of the buffer.
  $D309,$02 Move on to the next byte and page.
  $D30B,$02 Combine the bits which moved on.
  $D30D,$02 Point at the first byte of the graphic.
  $D30F,$02 Combine its bits which stay and store the byte.
  $D311,$02 Move on to the next byte and page.
  $D313,$03 Combine the bits which moved on with the next byte of the buffer.
  $D316,$01 Go back to the first page.
  $D317,$06 Move on to the next row of the buffer.
  $D31D,$01 Switch in the number of rows.
  $D31E,$01 Count it down.
  $D31F,$02 Jump to #R$D303 until the rows are done.
  $D321,$02 Jump to #R$D2FD.
N $D323 Draw an aligned strip.
@ $D323 label=DrawStripGraphic_Aligned
  $D323,$01 Put the buffer address in #REGhl.
  $D324,$04 Fetch #R$BBF2 and test it.
  $D328,$02 Jump to #R$D33E if it is set.
  $D32A,$03 Set #REGbc to #N$0017.
  $D32D,$01 Switch in the number of rows.
@ $D32E label=DrawStripGraphic_AlignedLoop
  $D32E,$01 Keep the number of rows in #REGa'.
  $D32F,$01 Fetch a row of the graphic.
  $D330,$03 Combine the first byte with the buffer.
  $D333,$01 Move on to the next byte of the buffer.
  $D334,$03 Combine the second byte with the buffer.
  $D337,$01 Move on to the next row of the buffer.
  $D338,$01 Switch in the number of rows.
  $D339,$01 Count it down.
  $D33A,$02 Jump to #R$D32E until the rows are done.
  $D33C,$02 Jump to #R$D2FD.
N $D33E Draw an aligned strip that is flipped.
@ $D33E label=DrawStripGraphic_AlignedMirrored
  $D33E,$02 Point #REGb at #R$F900.
  $D340,$01 Switch in the number of rows.
@ $D341 label=DrawStripGraphic_AlignedMirroredLoop
  $D341,$01 Keep the number of rows in #REGa'.
  $D342,$01 Fetch a row of the graphic.
  $D343,$01 Point at the second byte, turned round.
  $D344,$03 Combine it with the first byte of the buffer.
  $D347,$01 Move on to the next byte of the buffer.
  $D348,$01 Point at the first byte, turned round.
  $D349,$03 Combine it with the second byte of the buffer.
  $D34C,$04 Move on to the next row of the buffer.
  $D350,$01 Switch in the number of rows.
  $D351,$01 Count it down.
  $D352,$02 Jump to #R$D341 until the rows are done.
  $D354,$02 Jump to #R$D2FD.

c $D356 Colour Wall Column
@ $D356 label=ColourWallColumn
D $D356 Sets the attributes of a column of
. #R$F044 from the strip to the bottom of the
. view. The colour is bright green, cyan, yellow
. or white, from the lowest two bits of #R$BBC0.
R $D356 D The vertical position of the strip
R $D356 E The horizontal position of the strip
N $D356 Return unless the strip is in the view.
  $D356,$04 Return if it is below the bottom of the view.
  $D35A,$02 Make the number of pixel rows to the bottom.
  $D35C,$06 Divide it by eight.
  $D362,$01 Return if there are none.
N $D363 Colour the column.
  $D363,$01 Set the number of character rows.
  $D364,$01 Put the position in #REGhl.
  $D365,$03 Call #R$E579.
  $D368,$03 Fetch #R$BBC0.
  $D36B,$02,b$01 Keep the lowest two bits.
  $D36D,$02,b$01 Make the colour bright green, cyan, yellow or white.
  $D36F,$03 Jump to #R$C889.

c $D372 Draw Cell With Walls
@ $D372 label=DrawCellWithWalls
D $D372 Draws the walls of a building in a cell
. of the village, using the lists of strips in
. #R$62A4. The list is chosen from the tile of
. the cell and #R$BBBA. Nothing is drawn if the
. cell is empty. A list holds sixteen steps of
. two strips each, one above the other. They
. are drawn in two runs of eight, going up and
. to the right and then down and to the right,
. with the second run flipped by #R$BBF2, to
. make the two walls which can be seen. Each
. step is drawn by #R$D3C2, and nothing more is
. drawn when all of the bits in #R$BBBB are set.
E $D372 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C54B }
. LIST#
R $D372 HL The cell: the column in #REGl and the row in #REGh
N $D372 Find the list of strips.
  $D372,$03 Call #R$D564.
  $D375,$01 Return if the cell is empty.
  $D376,$03 Set #R$BBC0.
  $D379,$01 Double the tile.
  $D37A,$04 Add #R$BBBA.
  $D37E,$03 Point #REGbc at #R$62A4.
  $D381,$03 Call #R$D589.
  $D384,$03 Copy the list address to #REGiy (using the stack).
N $D387 Find the position and draw strips as they are.
  $D387,$03 Call #R$D508.
  $D38A,$04 Write #N$00 to *#R$BBF2.
  $D38E,$02 Set a count of #N$08.
N $D390 Draw eight steps going up and to the right.
@ $D390 label=DrawCellWithWalls_Up
  $D390,$03 Call #R$D3C2.
  $D393,$03 Fetch #R$BBBB.
  $D396,$05 Return if all sixteen bits are set.
  $D39B,$03 Call #R$D250.
  $D39E,$02 Jump to #R$D390 if there are any left.
N $D3A0 Move up by eight pixels to start the second run.
  $D3A0,$0A Move #R$BBB8 up by eight pixels.
N $D3AA Draw the rest of the strips flipped.
  $D3AA,$05 Write #N$01 to *#R$BBF2.
  $D3AF,$02 Set a count of #N$08.
N $D3B1 Draw eight steps going down and to the right.
@ $D3B1 label=DrawCellWithWalls_Down
  $D3B1,$03 Call #R$D3C2.
  $D3B4,$03 Fetch #R$BBBB.
  $D3B7,$05 Return if all sixteen bits are set.
  $D3BC,$03 Call #R$D22D.
  $D3BF,$02 Jump to #R$D3B1 if there are any left.
  $D3C1,$01 Return.

c $D3C2 Draw Wall Strips
@ $D3C2 label=DrawWallStrips
D $D3C2 Draws two wall strips, one above the
. other, for a step along the edge of a cell. A
. bit in #R$BBBB is set to record that the
. column has a wall in it, and if it already has
. one the step is skipped. The horizontal
. position in #R$BBB6 chooses the bit, and is
. written into the BIT instruction at #R$D3E2
. and the SET instruction at #R$D3C2(#N$D3E6).
. The lower strip is drawn at #R$BBB8 by
. #R$D425, the column is coloured by #R$D356,
. and the upper strip #N$40 above it. The step
. is skipped if either position is off the
. screen. It always moves on to the next two
. strips of the list.
E $D3C2 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C59B }
. LIST#
R $D3C2 BC The count of steps in #REGb
R $D3C2 IY The address of the first strip of the step in its list
N $D3C2 Return unless the column is on the screen.
  $D3C2,$03 Fetch #R$BBB6.
  $D3C5,$04 Jump to #R$D410 if it is off the screen.
N $D3C9 Keep the position and change the BIT and SET
. instructions.
  $D3C9,$02 Keep the horizontal position in #REGe.
  $D3CB,$01 Move the bits which say which sixteen pixels it is in...
  $D3CC,$02,b$01 ...to make the number of a bit...
  $D3CE,$02,b$01 ...in the second byte of a BIT instruction.
  $D3D0,$03 Store it as the second byte of the BIT instruction at #R$D3E2.
  $D3D3,$02,b$01 Change it to the second byte of a SET instruction.
  $D3D5,$03 Store it as the second byte of the SET instruction
. at #R$D3C2(#N$D3E7).
N $D3D8 Choose the byte of #R$BBBB.
  $D3D8,$01 Fetch the horizontal position again.
  $D3D9,$01 Move the top bit of the horizontal position...
  $D3DA,$02,b$01 ...into a single bit.
  $D3DC,$03 Point #REGhl at #R$BBBB.
  $D3DF,$02 Jump to #R$D3E2 if the position is in the first half of the screen.
  $D3E1,$01 Point #REGhl at the second byte of the flags.
N $D3E2 Test and set the flag for this column.
@ $D3E2 label=DrawWallStrips_Test
  $D3E2,$04 Jump to #R$D410 if there is already a wall there.
  $D3E6,$02 Set the bit.
N $D3E8 Draw the lower strip and colour the column.
  $D3E8,$03 Fetch #R$BBB8.
  $D3EB,$04 Jump to #R$D410 if it is off the screen.
  $D3EF,$01 Keep the low byte of the vertical position in #REGd.
  $D3F0,$02 Stash the count of steps and the position on the stack.
  $D3F2,$03 Call #R$D425.
  $D3F5,$02 Restore the position and stash it again.
  $D3F7,$03 Call #R$D356.
  $D3FA,$01 Restore the position.
  $D3FB,$02 Move on to the next strip of the list.
N $D3FD Draw the upper strip.
  $D3FD,$03 Fetch #R$BBB8.
  $D400,$03 Set #REGbc to #N$0040.
  $D403,$01 Move up by that much.
  $D404,$04 Jump to #R$D40C if it is off the screen.
  $D408,$01 Keep the low byte of the vertical position in #REGd.
  $D409,$03 Call #R$D425.
N $D40C Restore the count and move on.
@ $D40C label=DrawWallStrips_Done
  $D40C,$01 Restore the count of steps.
  $D40D,$02 Move on to the next strip of the list.
  $D40F,$01 Return.
N $D410 There is nothing to draw, so skip both of the strips.
@ $D410 label=DrawWallStrips_Skip
  $D410,$04 Move on past the two strips of the list.
  $D414,$01 Return.

c $D415 Clip Wall Strip Top
@ $D415 label=ClipWallStripTop
D $D415 Skips the rows of a wall strip that are
. below #R$E5C4. #REGa is the number of those
. rows, negated. It starts drawing at #N$48 and
. jumps to #R$D43D.
E $D415 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C5E9 }
. LIST#
R $D415 A The number of rows below the buffer, negated
R $D415 HL The address of the graphic
N $D415 Skip the rows that are below the buffer.
  $D415,$03 Make the number of rows positive and keep it in #REGc.
  $D418,$02 Fetch the height of the graphic.
  $D41A,$01 Subtract the rows that are below.
  $D41B,$02 Return if there are none left.
  $D41D,$04 Skip the image data for those rows.
  $D421,$02 Set the vertical position to #N$48.
  $D423,$02 Jump to #R$D43D.

c $D425 Draw Wall Strip
@ $D425 label=DrawWallStrip
D $D425 Draws a wall strip, sixteen pixels wide,
. into #R$E5C4. The graphic has the same format
. as #R$D2B2, but it replaces the buffer. The
. masks from #R$D4EF are written into the AND
. instructions. The graphic is flipped if
. #R$BBF2 is not zero.
E $D425 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C5F9 }
. LIST#
R $D425 D The vertical position of the bottom of the strip
R $D425 E The horizontal position of the strip
R $D425 IY The address of the strip number
N $D425 Find the graphic and clip it to the buffer.
  $D425,$03 Fetch the strip number.
  $D428,$03 Point #REGbc at #R$6E36.
  $D42B,$03 Call #R$D589.
  $D42E,$03 Subtract #N$48 from the vertical position.
  $D431,$02 Jump to #R$D415 if it is below the bottom.
  $D433,$02 Subtract #N$70.
  $D435,$01 Return if it is above the top.
  $D436,$02 Make it the number of rows in the buffer.
  $D438,$01 Compare it with the height of the graphic.
  $D439,$02 Jump to #R$D43C if it is fewer.
  $D43B,$01 Use the height of the graphic.
N $D43C Draw the rows that are in the buffer.
@ $D43C label=DrawWallStrip_Height
  $D43C,$01 Move on to the first row of the graphic.
@ $D43D label=DrawWallStrip_Draw
  $D43D,$01 Keep the number of rows in #REGa'.
  $D43E,$01 Put the position in #REGhl.
  $D43F,$03 Call #R$E53A.
  $D442,$01 Switch the buffer and the graphic.
  $D443,$01 Stash the graphic on the stack.
N $D444 Write the masks from #R$D4EF into the AND
. instructions.
  $D444,$03 Fetch #R$BBB6.
  $D447,$01 Move the shift into the lowest bits.
  $D448,$02,b$01 Keep the lowest two bits.
  $D44A,$03 Point #REGhl at #R$D4EF.
  $D44D,$03 Call #R$E596.
  $D450,$01 Fetch the mask.
  $D451,$06 Set the left-hand AND operands.
  $D457,$01 Complement the mask.
  $D458,$06 Set the right-hand AND operands.
N $D45E Choose the draw path.
  $D45E,$01 Restore the graphic from the stack.
  $D45F,$04 Set #R$BBAE.
  $D463,$01 Point the stack at the graphic.
  $D464,$03 Fetch #R$BBB6.
  $D467,$02,b$01 Keep bits 1 and 2.
  $D469,$02 Jump to #R$D4C2 if the graphic is aligned.
  $D46B,$02,b$01 Set the high bits of the page.
  $D46D,$01 Set #REGh.
  $D46E,$03 Fetch #R$BBF2.
  $D471,$03 Jump to #R$D49D if it is set.
  $D474,$02 Set bit 3 of #REGh.
  $D476,$01 Switch in the number of rows.
N $D477 Draw a shifted row.
@ $D477 label=DrawWallStrip_Shifted
  $D477,$01 Keep the number of rows in #REGa'.
  $D478,$02 Fetch a row and point at the first byte.
  $D47A,$01 Fetch the first byte of the buffer.
  $D47B,$02,b$01 Keep the bits which are not covered.
  $D47D,$02 Combine it and store the byte.
  $D47F,$02 Move on to the next byte and page.
  $D481,$01 Look up the bits which moved on.
  $D482,$01 Go back to the first page.
  $D483,$01 Point at the second byte of the graphic.
  $D484,$02 Combine it and store the byte.
  $D486,$02 Move on to the next byte and page.
  $D488,$01 Fetch the third byte of the buffer.
  $D489,$02,b$01 Keep the bits which are not covered.
  $D48B,$02 Combine it and store the byte.
  $D48D,$01 Go back to the first page.
  $D48E,$06 Move on to the next row of the buffer.
  $D494,$01 Switch in the number of rows.
  $D495,$01 Count it down.
  $D496,$02 Jump to #R$D477 until the rows are done.
N $D498 Put the stack back.
@ $D498 label=DrawWallStrip_Done
  $D498,$05 Fetch #R$BBAE and return.
N $D49D Draw a shifted row that is flipped.
@ $D49D label=DrawWallStrip_MirroredShifted
  $D49D,$01 Switch in the number of rows.
@ $D49E label=DrawWallStrip_MirroredLoop
  $D49E,$01 Keep the number of rows in #REGa'.
  $D49F,$02 Fetch a row and point at the second byte.
  $D4A1,$01 Fetch the first byte of the buffer.
  $D4A2,$02,b$01 Keep the bits which are not covered.
  $D4A4,$02 Combine it and store the byte.
  $D4A6,$02 Move on to the next byte and page.
  $D4A8,$01 Look up the bits which moved on.
  $D4A9,$01 Go back to the first page.
  $D4AA,$01 Point at the first byte of the graphic.
  $D4AB,$01 Fetch the bits which stay.
  $D4AC,$02 Combine them and store the byte.
  $D4AE,$02 Move on to the next byte and page.
  $D4B0,$01 Fetch the third byte of the buffer.
  $D4B1,$02,b$01 Keep the bits which are not covered.
  $D4B3,$02 Combine it and store the byte.
  $D4B5,$01 Go back to the first page.
  $D4B6,$06 Move on to the next row of the buffer.
  $D4BC,$01 Switch in the number of rows.
  $D4BD,$01 Count it down.
  $D4BE,$02 Jump to #R$D49E until the rows are done.
  $D4C0,$02 Jump to #R$D498.
N $D4C2 Draw an aligned graphic.
@ $D4C2 label=DrawWallStrip_Aligned
  $D4C2,$01 Put the buffer address in #REGhl.
  $D4C3,$04 Fetch #R$BBF2 and test it.
  $D4C7,$02 Jump to #R$D4D9 if it is set.
  $D4C9,$03 Set #REGbc to #N$0017.
  $D4CC,$01 Switch in the number of rows.
@ $D4CD label=DrawWallStrip_AlignedLoop
  $D4CD,$01 Keep the number of rows in #REGa'.
  $D4CE,$01 Fetch a row of the graphic.
  $D4CF,$02 Store the first byte and move on.
  $D4D1,$01 Store the second byte.
  $D4D2,$01 Move on to the next row of the buffer.
  $D4D3,$01 Switch in the number of rows.
  $D4D4,$01 Count it down.
  $D4D5,$02 Jump to #R$D4CD until the rows are done.
  $D4D7,$02 Jump to #R$D498.
N $D4D9 Draw an aligned graphic that is flipped.
@ $D4D9 label=DrawWallStrip_AlignedMirrored
  $D4D9,$02 Point #REGb at #R$F900.
  $D4DB,$01 Switch in the number of rows.
@ $D4DC label=DrawWallStrip_AlignedMirroredLoop
  $D4DC,$01 Keep the number of rows in #REGa'.
  $D4DD,$01 Fetch a row of the graphic.
  $D4DE,$01 Point at the second byte, turned round.
  $D4DF,$02 Store it in the first byte of the buffer.
  $D4E1,$01 Move on to the next byte of the buffer.
  $D4E2,$01 Point at the first byte, turned round.
  $D4E3,$02 Store it in the second byte of the buffer.
  $D4E5,$04 Move on to the next row of the buffer.
  $D4E9,$01 Switch in the number of rows.
  $D4EA,$01 Count it down.
  $D4EB,$02 Jump to #R$D4DC until the rows are done.
  $D4ED,$02 Jump to #R$D498.

b $D4EF Wall Strip Masks
@ $D4EF label=WallStripMasks
D $D4EF The four masks used by #R$D425 to keep
. the bits of the buffer on the left of a wall
. strip. The index is the shift to the right in
. twos of pixels: #N($00), #N($02), #N$04 or
. #N$06.
E $D4EF View the equivalent data in;
. #LIST
. { #GUNFRIGHT$C6C3 }
. LIST#
B $D4EF,$01 Shift #N$00: #N$00.
B $D4F0,$01 Shift #N$02: #N$C0.
B $D4F1,$01 Shift #N$04: #N$F0.
B $D4F2,$01 Shift #N$06: #N$FC.

c $D4F3 Project Object
@ $D4F3 label=ProjectObject
D $D4F3 Works out where an object is on the
. screen, in the same way as #R$D508. It fetches
. the position from the slot, calls #R$D18E, and
. jumps to #R$D515. The result is put in #R$BBB6
. and #R$BBB8.
E $D4F3 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C6C7 }
. LIST#
R $D4F3 IX The address of the object
N $D4F3 Fetch the position and convert it.
  $D4F3,$06 Fetch the vertical position.
  $D4F9,$03 Call #R$D18E.
  $D4FC,$01 Stash it on the stack.
  $D4FD,$06 Fetch the horizontal position.
  $D503,$03 Call #R$D18E.
  $D506,$02 Jump to #R$D515.

c $D508 Project Cell
@ $D508 label=ProjectCell
D $D508 Works out where the corner of the cell
. last set by #R$D564 is on the screen. With the
. distances from the player as dx and dy, the
. horizontal position is (dx + dy + #N$00F0) /
. 2 and the vertical position is (dy - dx +
. #N$01B0) / 4. They are put in #R$BBB6 and
. #R$BBB8. When bit 0 of #R$BBBA is set, the
. player's position is turned round.
E $D508 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C6DC }
. LIST#
N $D508 Set the position of the corner of the
. cell.
  $D508,$06 Fetch #R$BBB5 as a position in #REGhl.
  $D50E,$01 Stash it on the stack.
  $D50F,$06 Fetch #R$BBB4 as a position in #REGhl.
N $D515 Find the position on the screen. #REGhl
. is the horizontal position, and the vertical
. position is on the stack.
@ $D515 label=ProjectCell_Position
  $D515,$04 Fetch the player's horizontal
. position from #R$BC8E(#N$BC8F).
  $D519,$03 Fetch #R$BBBA.
  $D51C,$02,b$01 Keep the lowest bit.
  $D51E,$02 Jump to #R$D528 if the view is not rotated.
  $D520,$03 Complement #REGe.
  $D523,$02 Complement #REGd.
  $D525,$02,b$01 Keep the lowest five bits.
  $D527,$01 Set #REGd.
N $D528 Find the horizontal distance.
@ $D528 label=ProjectCell_X
  $D528,$03 Subtract the player's position.
  $D52B,$01 Copy the distance into #REGde.
  $D52C,$01 Restore the vertical position from the stack.
N $D52D Find the vertical distance.
  $D52D,$04 Fetch the player's vertical
. position from #R$BC8E(#N$BC91).
  $D531,$03 Fetch #R$BBBA.
  $D534,$02,b$01 Keep the lowest bit.
  $D536,$02 Jump to #R$D540 if the view is not rotated.
  $D538,$03 Complement #REGc.
  $D53B,$02 Complement #REGb.
  $D53D,$02,b$01 Keep the lowest five bits.
  $D53F,$01 Set #REGb.
N $D540 Work out the screen position.
@ $D540 label=ProjectCell_Y
  $D540,$03 Subtract the player's position.
  $D543,$01 Stash the distance on the stack.
  $D544,$03 Set #REGbc to #N$00F0.
  $D547,$02 Add the two distances and #N$00F0.
  $D549,$04 Halve it.
  $D54D,$03 Set #R$BBB6.
  $D550,$01 Restore the vertical distance from the stack.
  $D551,$03 Subtract the horizontal distance.
  $D554,$03 Set #REGbc to #N$01B0.
  $D557,$01 Add it.
  $D558,$08 Divide it by four.
  $D560,$04 Set #R$BBB8 and return.

c $D564 Get Map Cell
@ $D564 label=GetMapCell
D $D564 Fetches the tile of a cell from #R$5E04,
. which is thirty-two rows of thirty-two. #REGl
. is the column and #REGh is the row. It sets
. #R$BBB4 and #R$BBB5. When bit 0 of #R$BBBA is
. set, the map is read from the end.
E $D564 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C738 }
. LIST#
R $D564 HL The cell: the column in #REGl and the row in #REGh
R $D564 O:A The tile for the cell
R $D564 O:F The zero flag is set if the cell is empty
N $D564 Work out the number of the cell.
  $D564,$03 Set #R$BBB4 and #R$BBB5.
  $D567,$04 Put the column in #REGa and the row in #REGhl.
  $D56B,$05 Multiply the row by #N$20.
  $D570,$02 Add the column.
N $D572 Point at the map.
  $D572,$03 Point #REGbc at #R$5E04.
  $D575,$03 Fetch #R$BBBA.
  $D578,$02,b$01 Keep the lowest bit.
  $D57A,$02 Jump to #R$D585 if the view is not rotated.
N $D57C Read from the end.
  $D57C,$06 Complement #REGhl.
  $D582,$03 Point #REGbc past #R$5E04.
N $D585 Fetch the tile.
@ $D585 label=GetMapCell_Tile
  $D585,$01 Add the address of the map.
  $D586,$03 Fetch the tile and return.

c $D589 Get Table Entry
@ $D589 label=GetTableEntry
D $D589 Fetches the word at #REGbc plus twice
. #REGa into #REGhl.
E $D589 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C75C }
. { #MARTIANOIDS$C010 }
. { #PENTAGRAM$D692 }
. LIST#
R $D589 A The number of the entry
R $D589 BC The address of the table
R $D589 O:HL The word from the table
N $D589 Find the address of the entry.
  $D589,$03 Put the number of the entry in #REGhl.
  $D58C,$01 Double it.
  $D58D,$01 Add the address of the table.
N $D58E Fetch the word.
  $D58E,$01 Fetch the low byte.
  $D58F,$01 Move on to the high byte.
  $D590,$01 Fetch it into #REGh.
  $D591,$02 Put the low byte in #REGl and return.

c $D593 Jump To Table Routine
@ $D593 label=JumpToTableRoutine
D $D593 Calls #R$D589 to fetch a routine from a
. table, then jumps to #R$5CB0 so that the
. routine returns to the caller of this one.
E $D593 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C766 }
. LIST#
R $D593 A The number of the entry
R $D593 BC The address of the table
N $D593 Fetch the address and jump to it.
  $D593,$03 Call #R$D589.
  $D596,$03 Jump to #R$5CB0.

w $D599 Object Handler Table
@ $D599 label=ObjectHandlerTable
D $D599 The routines that update each type of object, which #R$BE71 runs for
. each of the objects in turn (see #R$BC8E for the types of the objects).
W $D599,$04,$04 Types #N$00 and #N$01: #R$D6D5.
W $D59D,$02,$02 Type #N$02: #R$D727.
W $D59F,$02,$02 Type #N$03: #R$D74C.
W $D5A1,$08,$08 Types #N$04 to #N$07: #R$D942.
W $D5A9,$08,$08 Types #N$08 to #N$0B: #R$D80C.
W $D5B1,$08,$08 Types #N$0C to #N$0F: #R$D7D8.
W $D5B9,$0C,$0C Types #N$10 to #N$15: #R$DA7A.
W $D5C5,$02,$02 Type #N$16: #R$D9EB.
W $D5C7,$02,$02 Type #N$17: #R$D6D5.
W $D5C9,$0C,$0C Types #N$18 to #N$1D: #R$DA7A.
W $D5D5,$02,$02 Type #N$1E: #R$D9EB.
W $D5D7,$02,$02 Type #N$1F: #R$D6D5.
W $D5D9,$20,$20 Types #N$20 to #N$2F: #R$DA00.
W $D5F9,$20,$20 Types #N$30 to #N$3F: #R$D9A3.
W $D619,$20,$20 Types #N$40 to #N$4F: #R$CE89.
W $D639,$20,$20 Types #N$50 to #N$5F: #R$D7ED.
W $D659,$20,$20 Types #N$60 to #N$6F: #R$D94F.
W $D679,$20,$20 Types #N$70 to #N$7F: #R$C083.
W $D699,$08,$08 Types #N$80 to #N$83: #R$C164.
W $D6A1,$08,$08 Types #N$84 to #N$87: #R$D847.
W $D6A9,$08,$08 Types #N$88 to #N$8B: #R$BFF1.
W $D6B1,$08,$08 Types #N$8C to #N$8F: #R$D70A.
W $D6B9,$10,$10 Types #N$90 to #N$97: #R$CD58.
W $D6C9,$02,$02 Type #N$98: #R$CD10.
W $D6CB,$0A,$0A Types #N$99 to #N$9D: #R$CD16.

c $D6D5 Ignore Object
@ $D6D5 label=IgnoreObject
D $D6D5 The routine for objects that do nothing.
  $D6D5,$01 Return.

c $D6D6 Create Fragments
@ $D6D6 label=CreateFragments
D $D6D6 Creates four fragments (objects of type #N$8C) at the position of an
. object, in the four objects from #R$BCCE. Each fragment flies off in a
. different direction.
R $D6D6 IY Object
  $D6D6,$05 Point #REGhl at the first fragment, and set a counter for four
. fragments.
@ $D6DB label=CreateFragments_Loop
  $D6DB,$03 Set the type of the fragment.
  $D6DE,$06 Point #REGde at the position of the object, and set a counter for
. four bytes.
@ $D6E4 label=CreateFragments_Position
  $D6E4,$07 Copy the position of the object into the fragment, and loop back
. until all of it has been copied.
  $D6EB,$03 Set the speed of the fragment to #N$0C.
  $D6EE,$06 Work out the direction of the fragment from the counter, so that the
. four fragments fly off in different directions.
  $D6F4,$03 Set the direction of the fragment, and move on to the width.
  $D6F7,$03 Set the width of the fragment to #N$10.
  $D6FA,$02 Set the depth of the fragment to #N$10.
  $D6FC,$03 Move on to the sprite offsets.
  $D6FF,$03 Set the X offset of the sprite.
  $D702,$02 Set the Y offset of the sprite.
  $D704,$03 Move on to the next fragment.
  $D707,$02 Loop back until all four fragments have been created.
  $D709,$01 Return.

c $D70A Update Fragment
@ $D70A label=UpdateFragment
D $D70A The routine for objects of type #N$8C to #N$8F, the fragments that fly
. out of a monster that has been destroyed. A fragment moves in a straight line,
. and turns into a burst when it hits something.
  $D70A,$04 Clear the flag that shows that the fragment has been drawn.
  $D70E,$06 Set the velocity of the fragment from its speed and direction.
  $D714,$03 Check whether the scenery blocks the move.
  $D717,$03 Move the fragment.
  $D71A,$03 Change the sprite of the fragment.
  $D71D,$05 Return if the fragment has not hit anything.
  $D722,$05 Turn the fragment into a burst and return.

c $D727 Update Speed Bonus
@ $D727 label=UpdateSpeedBonus
D $D727 The routine for objects of type #N$02, the bonuses that make the player
. move faster. A bonus vanishes when the player is more than four cells away.
. When the player touches it, the bonus turns into a burst and the player's
. speed is raised for #N$FF frames.
  $D727,$05 Set the distance to #N$04 cells and check whether the bonus is that
. close to the player.
  $D72C,$02 Jump to #R$D733 if it is.
  $D72E,$05 Remove the bonus, because the player is too far away, and return.
@ $D733 label=UpdateSpeedBonus_Close
  $D733,$04 Return if the bonus is not touching the player.
  $D737,$04 Turn the bonus into a burst.
  $D73B,$05 Make the speed bonus last for #N$FF frames.
  $D740,$05 Raise the player's top speed to #N$12.
  $D745,$06 Start the speed bonus sound, which is sound effect #N$01 and has
. five notes.
  $D74B,$01 Return.

c $D74C Update Health Bonus
@ $D74C label=UpdateHealthBonus
D $D74C The routine for objects of type #N$03, the bonuses that restore the
. player's health. A bonus vanishes when the player is more than four cells
. away. When the player touches it, the bonus turns into a burst and the
. player's health is made full.
  $D74C,$05 Set the distance to #N$04 cells and check whether the bonus is that
. close to the player.
  $D751,$02 Jump to #R$D758 if it is.
  $D753,$05 Remove the bonus, because the player is too far away, and return.
@ $D758 label=UpdateHealthBonus_Close
  $D758,$04 Return if the bonus is not touching the player.
  $D75C,$04 Turn the bonus into a burst.
  $D760,$05 Give the player full health.
  $D765,$06 Start the health bonus sound, which is sound effect #N$02 and has
. seven notes.
  $D76B,$01 Return.

c $D76C Spawn Bonus
@ $D76C label=SpawnBonus
D $D76C Makes a bonus appear near the player, in the object at #R$BD0E, if there
. is not one already. The bonus is a speed bonus (type #N$02) or a health bonus
. (type #N$03), depending on the frame counter. It is placed in a cell that is
. not solid and is at least two cells from the player, at a random place within
. the cell.
  $D76C,$04 Use the object for the bonus.
  $D770,$05 Return if there is a bonus already.
  $D775,$03 Update the random number generator.
  $D778,$08 Fetch the column and the row of the player's cell.
  $D780,$07 Choose a column that is the same as the player's, or four on, from
. the random seed.
  $D787,$04 Add the choice to the column, and keep it within the village.
  $D78B,$03 Set the column of the bonus.
  $D78E,$08 Choose a row from four back to three on, using the second random
. seed.
  $D796,$06 Add the choice to the row, and set the row of the bonus.
  $D79C,$03 Find the tile of the cell.
  $D79F,$04 Return if the tile is solid (#N$01 or #N$02).
  $D7A3,$05 Set the distance to two cells.
  $D7A8,$01 Check whether the cell is closer to the player than that, and return
. if it is.
  $D7A9,$0A Make the type of the bonus #N$02 or #N$03, from the frame counter,
. and set it.
  $D7B3,$0A Set the position of the bonus along the X axis within the cell to a
. random place.
  $D7BD,$0A Set the position of the bonus along the Y axis within the cell to a
. random place.
  $D7C7,$04 Set the width of the bonus to #N$10.
  $D7CB,$04 Set the depth of the bonus to #N$10.
  $D7CF,$04 Set the X offset of the sprite.
  $D7D3,$04 Set the Y offset of the sprite.
  $D7D7,$01 Return.

c $D7D8 Update Burst
@ $D7D8 label=UpdateBurst
D $D7D8 The routine for objects of type #N$0C to #N$0F, the bursts that show an
. object being destroyed. The burst changes to the next sprite, and the object
. is removed after the fourth sprite and a random sound is played.
  $D7D8,$0A Change to the next sprite, and jump to #R$D7E8 unless that was the
. last one.
  $D7E2,$06 Remove the burst, and play a random sound.
@ $D7E8 label=UpdateBurst_Next
  $D7E8,$05 Clear the flag that shows that the burst has been drawn, and return.

c $D7ED Update Shot
@ $D7ED label=UpdateShot
D $D7ED The routine for objects of type #N$50 to #N$5F, the shots that the
. player fires. A shot moves in a straight line, and turns into a burst when it
. hits something.
  $D7ED,$06 Set the velocity of the shot from its speed and direction.
  $D7F3,$03 Change the sprite of the shot.
  $D7F6,$03 Check whether the scenery blocks the move along one axis.
  $D7F9,$03 Move the shot.
  $D7FC,$03 Check whether the scenery blocks the move along the other axis.
  $D7FF,$03 Move the shot.
  $D802,$05 Return if the shot has not hit anything.
  $D807,$05 Turn the shot into a burst and return.

c $D80C Update Thrown Item
@ $D80C label=UpdateThrownItem
D $D80C The routine for objects of type #N$08 to #N$0B, the items that the
. player has thrown. The item flies in a straight line. If it hits the object
. that is four places along the object table (the monster that it belongs to),
. the monster is destroyed, #N$25 hundred points are added to the score and the
. monster explodes into fragments. If the item hits something else, it lands and
. becomes an item that can be picked up again (type #N$04 to #N$07).
  $D80C,$06 Set the velocity of the item from its speed and direction.
  $D812,$03 Check whether the scenery blocks the move along one axis.
  $D815,$03 Move the item.
  $D818,$03 Check whether the scenery blocks the move along the other axis.
  $D81B,$03 Move the item.
  $D81E,$05 Check whether the item has hit its monster, and jump to #R$D833 if
. it has.
  $D823,$05 Return if the item has not hit the scenery.
  $D828,$0B Change the type of the item to the one for an item that is lying on
. the ground, and return.
@ $D833 label=UpdateThrownItem_Hit
N $D833 The item has hit its monster.
  $D833,$04 Change the monster into a flash (type #N$84).
  $D837,$04 Turn the item into a burst.
  $D83B,$06 Add #N$25 hundred points to the score.
  $D841,$03 Create fragments from the monster.
  $D844,$03 Jump to #R$C1FD.

c $D847 Update Destroyed Monster
@ $D847 label=UpdateDestroyedMonster
D $D847 The routine for objects of type #N$84 to #N$87, the flash that shows a
. monster that has been destroyed. The border of the screen is set to a colour
. from the frame counter, and on every other frame the object moves on to the
. next sprite. It is removed after the fourth sprite.
  $D847,$0B Set the colour of the border from the frame counter.
  $D852,$06 Return unless the frame counter is odd.
  $D858,$09 Move on to the next sprite, and return unless it was the last.
  $D861,$04 Remove the object and return.

c $D865 Check Monsters Defeated
@ $D865 label=CheckMonstersDefeated
D $D865 Checks whether all four monsters have been destroyed and their fragments
. have gone. If so, the game is over (see #R$CC56). Returns if any monster is
. still alive, or any of its fragments is still moving.
  $D865,$09 Point #REGhl at the first monster, set the distance from one object
. to the next (#N$0010 bytes), set a counter for four monsters and clear #REGa.
@ $D86E label=CheckMonstersDefeated_Monsters
  $D86E,$04 Combine the type of the monster with the others, and loop back until
. all four have been checked.
  $D872,$01 Return if any monster is still alive.
  $D873,$06 Point #REGix at the first of the four fragments, and set a counter
. for four.
@ $D879 label=CheckMonstersDefeated_Fragments
  $D879,$09 Jump to #R$D887 if the object is not a fragment.
  $D882,$05 Return if the fragment has been drawn, because it is still in view.
@ $D887 label=CheckMonstersDefeated_Next
  $D887,$04 Move on to the next object and loop back until all four have been
. checked.
  $D88B,$03 Finish the game.

c $D88E Place Items
@ $D88E label=PlaceItems
D $D88E Places the four items that the monsters need (type #N$04 to #N$07) in
. random cells of the village that are not solid, in the objects from #R$BD1E.
. The cells come from bytes of the ROM, starting from a random place.
  $D88E,$03 Increase the frame counter, and update the random number generator.
  $D891,$06 Point #REGiy at the first object, and set a counter of four items.
  $D897,$08 Make a random address in the first #N$1000 bytes of the ROM.
@ $D89F label=PlaceItems_Cell
  $D89F,$05 Fetch a column from the ROM.
  $D8A4,$05 Fetch a row from the ROM.
  $D8A9,$07 Find the tile of the cell.
  $D8B0,$05 Try another cell if the tile is solid (#N$01 or #N$02).
  $D8B5,$03 Keep the counter, the address in the ROM and the cell.
  $D8B8,$0D Copy the template for an item into the object, and move on to the
. next object.
  $D8C5,$03 Restore the cell, the address in the ROM and the counter.
  $D8C8,$06 Set the type of the item.
  $D8CE,$06 Set the column and the row of the item.
  $D8D4,$02 Loop back until all four items have been placed.
  $D8D6,$01 Return.

b $D8D7 Item Template
@ $D8D7 label=ItemTemplate
D $D8D7 The initial state of an item, copied into the object table by #R$D88E
. (see #R$BC8E for the fields). The size is #N$08 by #N$08.
B $D8D7,$10,$10

c $D8E7 Place Monsters
@ $D8E7 label=PlaceMonsters
D $D8E7 Places the four monsters (type #N$60, #N$64, #N$68 and #N$6C) in random
. cells of the village that are not solid, in the objects from #R$BD5E. The
. cells come from bytes of the ROM, starting from a random place.
  $D8E7,$03 Increase the frame counter, and update the random number generator.
  $D8EA,$06 Point #REGiy at the first object, and set a counter of four
. monsters.
  $D8F0,$08 Make a random address in the first #N$1000 bytes of the ROM.
@ $D8F8 label=PlaceMonsters_Cell
  $D8F8,$05 Fetch a column from the ROM.
  $D8FD,$05 Fetch a row from the ROM.
  $D902,$07 Find the tile of the cell.
  $D909,$05 Try another cell if the tile is solid (#N$01 or #N$02).
  $D90E,$03 Keep the counter, the address in the ROM and the cell.
  $D911,$0D Copy the template for a monster into the object, and move on to the
. next object.
  $D91E,$03 Restore the cell, the address in the ROM and the counter.
  $D921,$08 Set the type of the monster from the counter.
  $D929,$06 Set the column and the row of the monster.
  $D92F,$02 Loop back until all four monsters have been placed.
  $D931,$01 Return.

b $D932 Monster Template
@ $D932 label=MonsterTemplate
D $D932 The initial state of a monster, copied into the object table by #R$D8E7
. (see #R$BC8E for the fields). The speed is #N$04 and the size is #N$10 by
. #N$10.
B $D932,$10,$10

c $D942 Update Monster Item
@ $D942 label=UpdateMonsterItem
D $D942 The routine for objects of type #N$04 to #N$07, the items that the
. monsters need, lying in the village. When the player touches one, the item is
. picked up.
  $D942,$04 Return if the item is not touching the player.
  $D946,$06 Start the item sound, which is sound effect #N$03 and has four
. notes.
  $D94C,$03 Pick up the item.

c $D94F Update Monster
@ $D94F label=UpdateMonster
D $D94F The routine for objects of type #N$60 to #N$6F, the monsters. A monster
. moves about, changing direction from time to time, and kills the player if it
. touches the player.
  $D94F,$0A Set the offset of the pitches for the monster from its type.
  $D959,$06 Play the sound for the monster if it has been drawn. #REGbc holds
. only the offset of the pitches, so they are read from the ROM, and the address
. of the table that is loaded into #REGhl is not used.
  $D95F,$06 Set the velocity of the monster from its speed and direction.
  $D965,$03 Check whether the scenery blocks the move.
  $D968,$03 Move the monster.
  $D96B,$03 Turn the monster to a new direction if its timer has run out.
  $D96E,$03 Choose the sprite from the direction that the monster faces.
N $D971 See #POKE(immunity_to_monsters,Immunity To Monsters).
  $D971,$04 Return if the monster is not touching the player.
  $D975,$03 Kill the player.

c $D978 Set Sprite From Direction
@ $D978 label=SetSpriteFromDirection
D $D978 Sets the sprite of an object from the direction that it is facing. Bit 1
. of the type is set from the direction, bit 0 is flipped, and the flip flag is
. set from the direction, with both the sprite and the flip changed when the
. view is rotated.
R $D978 IX Object
  $D978,$05 Fetch whether the view is turned round, and double it.
  $D97D,$0A Work out bit 1 of the type from the direction.
  $D987,$0C Set bit 1 of the type from the direction, flip bit 0 to change the
. frame, and flip bit 1 as well if the view is rotated.
  $D993,$06 Fetch the direction of the object, and keep bit 6.
  $D999,$09 Set the flip flag of the object from it.
  $D9A2,$01 Return.

c $D9A3 Update Village Item
@ $D9A3 label=UpdateVillageItem
D $D9A3 The routine for objects of type #N$30 to #N$3F, the items that appear in
. the village (see #R$C5CE). An item wanders about at random while the player
. stays in the cell that it appeared in, and is picked up when the player
. touches it. It turns into a burst, and goes back to the items that are
. available, when the player has gone from the cell or is dead.
  $D9A3,$09 Jump to #R$D9D6 if the player is not there (the type of the player
. is not #N$10 to #N$2F).
  $D9AC,$08 Jump to #R$D9DC if the player is not in the column of the item.
  $D9B4,$08 Jump to #R$D9DC if the player is not in the row of the item.
  $D9BC,$02 Use #N$04 bits for the velocity.
  $D9BE,$03 Choose a random velocity.
  $D9C1,$03 Set the direction that the item is facing from its velocity.
  $D9C4,$03 Move the item.
  $D9C7,$03 Change the sprite of the item.
  $D9CA,$04 Return if the item is not touching the player.
  $D9CE,$03 Pick up the item.
  $D9D1,$05 Turn the item into a burst and return.
@ $D9D6 label=UpdateVillageItem_Dead
N $D9D6 The player is dead.
  $D9D6,$06 Turn the item into a burst, with a different sprite, and jump to
. #R$D9E0.
@ $D9DC label=UpdateVillageItem_Left
N $D9DC The player has left the cell.
  $D9DC,$04 Turn the item into a burst.
@ $D9E0 label=UpdateVillageItem_Return
N $D9E0 Add the item to the items that are available for the kind of tile.
  $D9E0,$05 Fetch the kind of tile that the item was found on.
  $D9E5,$04 Point at the number of items for the kind of tile.
  $D9E9,$01 Add one to the number of items that are available.
  $D9EA,$01 Return.

c $D9EB Update Bumping Body
@ $D9EB label=UpdateBumpingBody
D $D9EB The routine for objects of type #N$16 and #N$1E, which is the body of
. the player when the legs have bumped into something. The body stays in this
. pose while the legs are flagged as having bumped into something, and goes back
. to normal otherwise.
  $D9EB,$07 Update the body as normal (see #R$DA00) if the legs have not bumped
. into something.
  $D9F2,$03 Copy the flags of the legs.
  $D9F5,$0A Set the type to the bumping pose (sprite #N$06) for the kind of
. legs.
  $D9FF,$01 Return.

c $DA00 Update Player Body
@ $DA00 label=UpdatePlayerBody
D $DA00 The routine for objects of type #N$20 to #N$2F, the body of the player.
. The body follows the legs (the object before it), and has the same sprite
. number as the legs. A sound is played when the legs bump into something, and
. the body then changes to the bumping pose. When the player is standing still,
. the body occasionally looks around.
  $DA00,$04 Use the position of the body as the destination of the copy.
  $DA04,$04 Use the position of the legs as the source of the copy.
  $DA08,$05 Copy the position and the speed of the legs.
  $DA0D,$07 Jump to #R$DA46 if the turn counter of the legs is zero.
@ $DA14 label=UpdatePlayerBody_Copy
  $DA14,$0A Make the type of the body from the type of the legs.
  $DA1E,$04 Clear the direction and timer of the body.
  $DA22,$06 Copy the flags of the legs.
@ $DA28 label=UpdatePlayerBody_Bump
  $DA28,$05 Return if the legs have not bumped into something.
  $DA2D,$0A Play the sound for a bump, unless the body is in the bumping pose
. already.
  $DA37,$0A Make the type of the body from the type of the legs, but with the
. lowest three bits set to #N$06 for the bumping pose.
  $DA41,$04 Clear the direction and timer of the body.
  $DA45,$01 Return.
@ $DA46 label=UpdatePlayerBody_Idle
N $DA46 The player is standing still, so the body looks around from time to
. time.
  $DA46,$06 Jump to #R$DA72 if the timer of the body has not run out.
  $DA4C,$07 Jump to #R$DA14 unless the random seed is less than #N$08.
  $DA53,$03 Choose between two poses from the random seed.
  $DA56,$0B Set the type of the body to one of the poses for looking around.
  $DA61,$09 Set the timer of the body to a random time of two to nine frames.
  $DA6A,$06 Copy the flags of the legs.
  $DA70,$02 Jump to #R$DA28.
@ $DA72 label=UpdatePlayerBody_Timer
  $DA72,$04 Count down the timer of the body.
  $DA76,$02 Jump to #R$DA14 if the timer has run out.
  $DA78,$02 Jump to #R$DA28.

c $DA7A Update Player Legs
@ $DA7A label=UpdatePlayerLegs
D $DA7A The routine for objects of type #N$10 to #N$15 and #N$18 to #N$1D, the
. legs of the player. While the player is materialising, the timer at #R$BC02 is
. advanced by two each frame and the player just flickers into view. Once the
. player is solid, it reads the controls and moves the player.
  $DA7A,$04 Clear the flag for a collision.
  $DA7E,$07 Advance the timer for materialising by two.
  $DA85,$04 Jump to #R$DAB1 if the player is still materialising.
  $DA89,$02 Set the timer to the value for a solid player (#N$70).
  $DA8B,$07 Fetch the time that the speed bonus has left, and skip the next part
. if it is zero.
  $DA92,$03 Count down the time, and skip the next part if there is some left.
  $DA95,$05 Set the maximum speed back to the normal #N$0A.
  $DA9A,$04 Set the speed of the player to #N$08.
@ $DA9E label=UpdatePlayerLegs_Controls
  $DA9E,$03 Read the controls.
  $DAA1,$01 Keep the controls in #REGe.
  $DAA2,$03 Check whether the key to turn the view has been pressed.
  $DAA5,$03 Work out the direction that the player is facing.
  $DAA8,$01 Keep the controls.
  $DAA9,$03 Move the player.
  $DAAC,$01 Restore the controls.
  $DAAD,$03 Throw an item if the fire button was pressed.
  $DAB0,$01 Return.
@ $DAB1 label=UpdatePlayerLegs_Materialising
N $DAB1 The player is materialising.
  $DAB1,$03 Set the sprite of the player.
  $DAB4,$03 Play the sound for materialising.

c $DAB7 Throw Item
@ $DAB7 label=ThrowItem
D $DAB7 Throws the last item that was picked up, if the fire button has been
. pressed and the previous throw has finished. An item that belongs to a monster
. (items #N$01 to #N$04) is dropped into the object for the monster. Any other
. item becomes a shot, in one of the two objects from #R$BCAE; if both are busy,
. the one that was not used last is turned into a burst.
R $DAB7 E Controls
N $DAB7 See #POKE(no_throw_delay,No Throw Delay).
  $DAB7,$07 Fetch the time left before another item can be thrown.
  $DABE,$02 Count down the time and return if it has not run out.
@ $DAC0 label=ThrowItem_Ready
  $DAC0,$03 Return if the fire button has not been pressed.
  $DAC3,$05 Point #REGhl at the last place in the inventory, and set a counter
. of eleven places.
@ $DAC8 label=ThrowItem_Find
  $DAC8,$04 Jump to #R$DAD0 if there is an item in this place.
  $DACC,$03 Move to the place before it and loop back until all of the places
. have been checked.
  $DACF,$01 Return.
N $DAD0 An item has been found. Monster items are dropped; any other item
. becomes a shot.
@ $DAD0 label=ThrowItem_Found
  $DAD0,$04 Jump to #R$DB43 if the item is one of the monster items (#N$01 to
. #N$04).
  $DAD4,$07 Point #REGiy at the first shot, and set the size of an object to
. #N$0010 bytes.
  $DADB,$02 Set a counter of two shots.
@ $DADD label=ThrowItem_Shot
  $DADD,$06 Jump to #R$DAFD if this shot is free.
  $DAE3,$05 Move on to the next shot and loop back until both have been checked.
  $DAE8,$03 Choose the shot that was not used last.
  $DAEB,$06 Fetch which shot was used last (#N$00 or #N$10).
  $DAF1,$02 Set the offset of the shot.
  $DAF3,$01 Point at the shot.
  $DAF4,$05 Fetch the type of the shot, and subtract #N$50.
  $DAF9,$01 Return if the shot has not got a type of #N$50 to #N$5F.
  $DAFA,$02 Turn the shot into a burst.
  $DAFC,$01 Return.
N $DAFD This shot is free, so the item is copied from the player into it.
@ $DAFD label=ThrowItem_Free
  $DAFD,$08 Change the shot that was used last.
  $DB05,$02 Keep the counter and the place in the inventory.
  $DB07,$03 Fetch the item and remove it from the inventory.
  $DB0A,$03 Use the player as the source of the copy.
  $DB0D,$03 Use the shot as the destination of the copy.
  $DB10,$05 Copy the player into the shot.
  $DB15,$04 Make the type of the shot from the item.
@ $DB19 label=ThrowItem_Set
  $DB19,$03 Set the type of the object.
  $DB1C,$04 Set the speed of the object to #N$0C.
  $DB20,$08 Set the width and the depth of the object to #N$10.
  $DB28,$04 Set the X offset of the sprite.
  $DB2C,$04 Set the Y offset of the sprite.
  $DB30,$05 Set the time before the next throw to two frames.
  $DB35,$02 Restore the place in the inventory and the counter.
  $DB37,$06 Work out the number of the place counted from the start of the
. inventory.
  $DB3D,$03 Redraw the item in the inventory tube.
  $DB40,$03 Jump to #R$C3F4.
@ $DB43 label=ThrowItem_Drop
N $DB43 The item is one of the monster items, which is dropped into the object
. for the monster.
  $DB43,$03 Keep the counter, the place in the inventory and the item.
  $DB46,$02 Remove the item from the inventory.
  $DB48,$08 Work out the offset of the object from the number of the item.
  $DB50,$06 Find the object for the monster.
  $DB56,$05 Point #REGiy at the object, and keep the address of the object.
  $DB5B,$08 Copy the player into the object.
  $DB63,$05 Make the type of the object from the item, and jump to #R$DB19.

c $DB68 Check Rotate Key
@ $DB68 label=CheckRotateKey
D $DB68 Turns the view around when the key to turn the view has been pressed and
. then released. The view is turned by flipping the rotation flag at #R$BBBA,
. and the player is given a short turn counter. The compass is redrawn.
E $DB68 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CD0C }
. LIST#
R $DB68 E Controls
  $DB68,$03 Find the flag for the key being held.
  $DB6B,$04 Jump to #R$DB72 unless the key is pressed.
  $DB6F,$03 Flag that the key is being held, and return.
@ $DB72 label=CheckRotateKey_Released
  $DB72,$03 Return if the key was not being held.
  $DB75,$02 Flag that the key is no longer being held.
  $DB77,$07 Flip the rotation of the view.
  $DB7E,$08 Give the player a turn counter of at least two.
  $DB86,$03 Jump to #R$C29A.

c $DB89 Choose Direction
@ $DB89 label=ChooseDirection
D $DB89 Works out the direction that the player is facing from the controls,
. which is held in bits 6 and 7 of the direction and timer of the player (0 is
. up the screen, 1 is right, 2 is down and 3 is left). A turn takes a few
. frames, which are counted in the lowest bits of the timer.
.
. With the keyboard or when the option for directional control is not set, the
. controls for left and right turn the player. When it is set, the player turns
. towards the direction that the controls give, one quarter at a time, and moves
. when it faces that way.
E $DB89 Continue on to #R$DC14.
E $DB89 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CB86 }
. LIST#
R $DB89 E Controls
R $DB89 IX Player
R $DB89 O:E Controls, with bit 2 set only if the player is to move forward
  $DB89,$07 Jump to #R$DB95 if the player is not turning.
  $DB90,$05 Count down the turn counter, and set the sprite of the player.
@ $DB95 label=ChooseDirection_Controls
  $DB95,$08 Jump to #R$DBFE if the controls are the keyboard.
  $DB9D,$04 Jump to #R$DBFE if the option for directional control is not set.
  $DBA1,$08 Swap the controls for left and right, and up and down, if the view
. is rotated.
  $DBA9,$04 Jump to #R$DBB1 if the control for left is used.
  $DBAD,$04 Jump to #R$DBC0 if the control for up is used.
@ $DBB1 label=ChooseDirection_Right
  $DBB1,$04 Jump to #R$DBE6 if the control for right is used.
  $DBB5,$04 Jump to #R$DBED if the control for down is used.
  $DBB9,$04 Jump to #R$DBF4 if the control for left is used.
  $DBBD,$03 Clear the control for up, and return.
@ $DBC0 label=ChooseDirection_Up
  $DBC0,$03 Fetch the direction of the player.
@ $DBC3 label=ChooseDirection_Turn
N $DBC3 Work out how far the player has to turn.
  $DBC3,$06 Clear the control for up, and jump to #R$DBFB if the player is
. facing the direction that is wanted.
  $DBC9,$04 Jump to #R$DBD8 if the player has to turn back by a quarter.
  $DBCD,$04 Jump to #R$DBDF if the player has to turn on by a quarter.
  $DBD1,$07 Choose which way to turn from the random seed, as the player has to
. turn right round.
@ $DBD8 label=ChooseDirection_TurnBack
  $DBD8,$07 Turn the player back by a quarter, and jump to #R$DC0F.
@ $DBDF label=ChooseDirection_TurnOn
  $DBDF,$07 Turn the player on by a quarter, and jump to #R$DC0F.
@ $DBE6 label=ChooseDirection_WantRight
  $DBE6,$07 Work out the direction of the player compared with right, and jump
. to #R$DBC3.
@ $DBED label=ChooseDirection_WantDown
  $DBED,$07 Work out the direction of the player compared with down, and jump to
. #R$DBC3.
@ $DBF4 label=ChooseDirection_WantLeft
  $DBF4,$07 Work out the direction of the player compared with left, and jump to
. #R$DBC3.
@ $DBFB label=ChooseDirection_Forward
  $DBFB,$03 Set the control for moving forward, and return.
@ $DBFE label=ChooseDirection_Relative
N $DBFE Turn the player with the controls for left and right.
  $DBFE,$03 Fetch the direction of the player.
  $DC01,$08 Turn the player back by a quarter if the control for left is used.
@ $DC09 label=ChooseDirection_RelativeRight
  $DC09,$06 Turn the player on by a quarter if the control for right is used.
@ $DC0F label=ChooseDirection_Counter
  $DC0F,$02,b$01 Set the turn counter to one.
@ $DC11 label=ChooseDirection_Set
  $DC11,$03 Set the direction of the player.

c $DC14 Set Facing Flags
@ $DC14 label=SetFacingFlags
D $DC14 Sets the sprite of the legs of the player from the direction. Bits 6 and
. 7 of the flags (to flip the sprite) and bit 3 of the type (to choose between
. the two sets of sprites) are taken from the table at #R$DCDC, which is turned
. around by two places when the view is rotated.
E $DC14 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CC13 }
. LIST#
R $DC14 IX Player
  $DC14,$08 Fetch the direction of the player.
  $DC1C,$06 Turn it around if the view is rotated.
  $DC22,$02 Clear the high byte.
  $DC24,$04 Find the entry in the table.
  $DC28,$04 Fetch the flags from the table.
  $DC2C,$09 Set the flip flags of the legs.
  $DC35,$04 Fetch the sprite set from the table.
  $DC39,$09 Set the sprite set of the legs.
  $DC42,$01 Return.

c $DC43 Swap Controls
@ $DC43 label=SwapControls
D $DC43 Swaps the controls for left and right, and up and down, which turns the
. controls around when the view is rotated. The control for fire is not changed.
E $DC43 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CD23 }
. LIST#
R $DC43 E Controls
R $DC43 O:E Controls swapped
  $DC43,$03 Keep the control for fire.
  $DC46,$04 Make the control for right the control for left.
  $DC4A,$02 Set the control for left.
@ $DC4C label=SwapControls_Left
  $DC4C,$04 Make the control for left the control for right.
  $DC50,$02 Set the control for right.
@ $DC52 label=SwapControls_Down
  $DC52,$04 Make the control for down the control for up.
  $DC56,$02 Set the control for up.
@ $DC58 label=SwapControls_Up
  $DC58,$04 Make the control for up the control for down.
  $DC5C,$02 Set the control for down.
@ $DC5E label=SwapControls_Return
  $DC5E,$02 Keep the controls and return.

c $DC60 Move Player
@ $DC60 label=MovePlayer
D $DC60 Moves the player. When the control to move forward is used, the speed of
. the player is raised towards the maximum speed in #R$BBBE. Otherwise the
. player slows down and stops at a position that is a multiple of eight units
. from the edge of a cell.
E $DC60 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CC42 }
. LIST#
R $DC60 E Controls
R $DC60 IX Player
  $DC60,$04 Jump to #R$DCA8 if the control to move forward is used.
  $DC64,$07 Fetch the direction of the player.
  $DC6B,$06 Jump to the routine for the direction, to find the part of the
. position that is along the way that the player is moving.

w $DC71 Slow Down Routines
@ $DC71 label=SlowDownRoutines
D $DC71 The routines that #R$DC60 runs to start slowing down the player, for
. each of the four directions.
W $DC71,$08,$02

c $DC79 Slow Player Down
@ $DC79 label=SlowPlayerDown
D $DC79 Slows the player down when no control is used to move. The distance to
. the next position that is a multiple of eight units is found, and the speed is
. the distance (up to four units).
E $DC79 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CC5B }
. LIST#
  $DC79,$03 Fetch the Y position of the player (moving up the screen).
@ $DC7C label=SlowPlayerDown_Distance
  $DC7C,$04 Stop the player if the position is a multiple of eight units.
  $DC80,$04 Work out the distance to the next multiple of eight units.
  $DC84,$02 Set the greatest speed to four.
  $DC86,$03 Jump to #R$DC8F if the distance is four or more.
  $DC89,$05 Halve the greatest speed, and jump to #R$DC8F if the distance is two
. or more.
  $DC8E,$01 Use the distance as the speed.
@ $DC8F label=SlowPlayerDown_Speed
  $DC8F,$03 Set the speed and move the player.
@ $DC92 label=SlowPlayerDown_Right
  $DC92,$05 Fetch the X position of the player (moving right), and jump to
. #R$DC7C.
@ $DC97 label=SlowPlayerDown_Down
  $DC97,$03 Fetch the Y position of the player (moving down the screen).
@ $DC9A label=SlowPlayerDown_Negate
  $DC9A,$04 Negate the position and jump to #R$DC7C.
@ $DC9E label=SlowPlayerDown_Left
  $DC9E,$05 Fetch the X position of the player (moving left), and jump to
. #R$DC9A.
@ $DCA3 label=SlowPlayerDown_Stop
  $DCA3,$05 Set the speed of the player to zero and return.

c $DCA8 Speed Player Up
@ $DCA8 label=SpeedPlayerUp
D $DCA8 Raises the speed of the player half of the way towards the maximum
. speed, keeping it even, and then moves the player.
E $DCA8 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CC8A }
. LIST#
  $DCA8,$0D Work out the new speed, which is the average of the current speed
. and the maximum speed (#R$BBBE), made even.
@ $DCB5 label=MovePlayer_Speed
N $DCB5 Set the speed, move the player and animate the legs.
  $DCB5,$03 Set the speed of the player.
  $DCB8,$03 Set the velocity of the player from its speed and direction.
  $DCBB,$03 Test whether the move is blocked by the scenery.
  $DCBE,$03 Move the player.
  $DCC1,$03 Mark the cell that the player is in as visited.
  $DCC4,$03 Play the sound for walking.
  $DCC7,$0B Move on to the next sprite for the legs, from #N$00 to #N$05.
  $DCD2,$01 Clear the sprite number if it went past #N$05.
@ $DCD3 label=MovePlayer_SetLegs
  $DCD3,$08 Set the type of the legs.
  $DCDB,$01 Return.

b $DCDC Player Sprite Table
@ $DCDC label=PlayerSpriteTable
D $DCDC The flags and the sprite set for each direction of the legs of the
. player. Bits 6 and 7 are the flags for the sprite (bit 6 is to flip it), and
. bit 3 is bit 3 of the type of the legs.
B $DCDC,$04,$04

c $DCE0 Set Velocity From Speed
@ $DCE0 label=SetVelocityFromSpeed
D $DCE0 Sets the velocity of an object along the X and Y axes from its speed and
. the direction that it faces. Only one axis is used, and the velocity is
. negative for the directions that face down the screen and to the left.
E $DCE0 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CCC2 }
. LIST#
R $DCE0 A Speed
R $DCE0 IX Object
  $DCE0,$09 Use the speed for the velocity along the X axis (bit 6 of the
. direction is set) in #REGl...
  $DCE9,$03 ... or the velocity along the Y axis in #REGh.
@ $DCEC label=SetVelocityFromSpeed_Sign
  $DCEC,$06 Jump to #R$DCFA unless the direction faces down the screen or to the
. left.
  $DCF2,$08 Negate the velocity along both axes.
@ $DCFA label=SetVelocityFromSpeed_Set
  $DCFA,$06 Set the velocities of the object.
  $DD00,$01 Return.

c $DD01 Move Object
@ $DD01 label=MoveObject
D $DD01 Moves an object by adding its velocity along each axis to its position.
E $DD01 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CCE5 }
. LIST#
R $DD01 IX Object
  $DD01,$13 Add the velocity along the X axis to the X position of the object.
  $DD14,$13 Add the velocity along the Y axis to the Y position of the object.
  $DD27,$01 Return.

c $DD28 Update Direction
@ $DD28 label=UpdateDirection
D $DD28 Changes the direction that an object is facing when the timer for the
. direction has run out (the lowest five bits of the direction and timer) or the
. object has hit something. The object turns a quarter to the left or to the
. right, chosen from the random seed, or, if it has been flagged as chasing the
. player (bit 5 of the flags), turns towards the player. A new timer is set.
E $DD28 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$B82A }
. LIST#
R $DD28 IX Object
  $DD28,$06 Jump to #R$DD3D if the object has hit something.
  $DD2E,$09 Count down the timer, and return unless it has run out.
  $DD37,$06 Jump to #R$DD58 if the object chases the player.
@ $DD3D label=UpdateDirection_Random
  $DD3D,$0A Fetch the random seed and the direction, and jump to #R$DD54 if the
. seed is #N$80 or more.
  $DD47,$02 Turn on a quarter.
@ $DD49 label=UpdateDirection_Timer
  $DD49,$0B Set a timer from the second random seed, set the direction and
. return.
@ $DD54 label=UpdateDirection_Back
N $DD54 Turn back a quarter.
  $DD54,$04 Turn back a quarter, and jump to #R$DD49.
@ $DD58 label=UpdateDirection_Chase
N $DD58 The object chases the player, so work out where the player is compared
. with the direction that the object is facing.
  $DD58,$03 Find the direction towards the player.
  $DD5B,$01 Keep it.
  $DD5C,$08 Work out how far the object has to turn.
  $DD64,$06 Jump to the routine for the amount.

w $DD6A Turn Routines
@ $DD6A label=TurnRoutines
D $DD6A The routines that #R$DD28 runs to turn an object towards the player, by
. the amount that it has to turn: none, a quarter back, right round and a
. quarter on.
W $DD6A,$08,$02

c $DD72 Turn Towards Player
@ $DD72 label=TurnTowardsPlayer
D $DD72 Turns an object towards the player, by a quarter back (from #R$DD79), by
. a quarter on (from #R$DD92) or, from #R$DD72, right round by turning a quarter
. in a direction chosen from the random seed. The direction gets a timer of one
. to sixteen.
R $DD72 IX Object
  $DD72,$07 Fetch the random seed, and jump to #R$DD92 if it is less than #N$80.
@ $DD79 label=TurnTowardsPlayer_Back
  $DD79,$05 Turn back a quarter.
@ $DD7E label=TurnTowardsPlayer_Set
  $DD7E,$03 Set the direction.
@ $DD81 label=TurnTowardsPlayer_Timer
  $DD81,$06 Fetch the direction, and keep only the direction.
  $DD87,$0A Set a timer of one to sixteen from the random seed.
  $DD91,$01 Return.
@ $DD92 label=TurnTowardsPlayer_On
  $DD92,$07 Turn on a quarter, and jump to #R$DD7E.

c $DD99 Find Direction To Player
@ $DD99 label=FindDirectionToPlayer
D $DD99 Works out which of the four directions an object has to face to move
. towards the player, using the axis along which the player is furthest away.
R $DD99 IX Object
R $DD99 O:A The direction (0 for up the screen, 1 for right, 2 for down and 3
. for left)
  $DD99,$0C Work out the distance along the X axis from the object to the
. player.
  $DDA5,$01 Keep it.
  $DDA6,$06 Make it positive, and keep it in #REGde.
  $DDAC,$0C Work out the distance along the Y axis from the object to the
. player.
  $DDB8,$01 Keep it.
  $DDB9,$05 Make it positive.
  $DDBE,$05 Compare it with the distance along the X axis, and start with the
. direction up the screen.
  $DDC3,$02 Restore the distances.
  $DDC5,$02 Jump to #R$DDC9 if the player is further along the Y axis.
  $DDC7,$02 Use the direction to the right, and use the distance along the X
. axis.
@ $DDC9 label=FindDirectionToPlayer_Sign
  $DDC9,$03 Return if the player is not at a negative distance.
  $DDCC,$03 Use the opposite direction, and return.

c $DDCF Choose Random Velocity
@ $DDCF label=ChooseRandomVelocity
D $DDCF Chooses a new random velocity along both axes for an object when the
. timer has run out (the lowest six bits of the direction and timer) or when the
. object is not moving. The velocity along each axis is an even number, chosen
. from the random seeds. A new timer is set from the memory refresh register.
R $DDCF B Number of random bits to use for each velocity
R $DDCF IX Object
  $DDCF,$0A Count down the timer, and jump to #R$DDE0 if it has run out.
  $DDD9,$07 Return if the object is moving.
@ $DDE0 label=ChooseRandomVelocity_Choose
  $DDE0,$0A Choose the velocity along the X axis from the first random seed.
  $DDEA,$0A Choose the velocity along the Y axis from the second random seed.
  $DDF4,$07 Set a random timer.
  $DDFB,$01 Return.

c $DDFC Choose Velocity
@ $DDFC label=ChooseVelocity
D $DDFC Makes a random velocity from a random number. The velocity is two for
. each of the bits that are not set in the lowest bits of the number, and it is
. negative if the next bit is not set.
R $DDFC B Number of bits to use
R $DDFC C Random number
R $DDFC O:A Velocity
  $DDFC,$02 Keep the registers, and start with a velocity of zero.
@ $DDFE label=ChooseVelocity_Loop
  $DDFE,$04 Test the next bit of the random number, and jump to #R$DE04 if it is
. set.
  $DE02,$02 Add two to the velocity.
@ $DE04 label=ChooseVelocity_Next
  $DE04,$02 Loop back until all the bits have been used.
  $DE06,$04 Test the next bit for the sign, restore the registers and return if
. it is set.
  $DE0A,$03 Make the velocity negative and return.

c $DE0D Set Direction From Velocity
@ $DE0D label=SetDirectionFromVelocity
D $DE0D Makes an object face the direction that it is moving in, and tests
. whether it can move that way. The direction along the X axis is used first,
. and then the one along the Y axis, so that an object that is moving along both
. axes ends up facing along the Y axis (if the velocity along that axis is not
. zero).
R $DE0D IX Object
  $DE0D,$06 Jump to #R$DE33 if the velocity along the X axis is zero.
  $DE13,$05 Face right...
  $DE18,$02,b$01 ... or face left, if the velocity is negative.
@ $DE1A label=SetDirectionFromVelocity_X
  $DE1A,$01 Keep the direction.
  $DE1B,$09 Set the direction of the object.
  $DE24,$08 Keep the velocity along the Y axis, and set it to zero.
  $DE2C,$03 Test whether the object can move that way.
  $DE2F,$04 Restore the velocity along the Y axis.
@ $DE33 label=SetDirectionFromVelocity_Y
  $DE33,$05 Return if the velocity along the Y axis is zero.
  $DE38,$05 Face up the screen...
  $DE3D,$02,b$01 ... or face down the screen, if the velocity is negative.
@ $DE3F label=SetDirectionFromVelocity_Set
  $DE3F,$01 Keep the direction.
  $DE40,$09 Set the direction of the object.
  $DE49,$08 Keep the velocity along the X axis, and set it to zero.
  $DE51,$03 Test whether the object can move that way.
  $DE54,$04 Restore the velocity along the X axis.
  $DE58,$01 Return.

c $DE59 Test Move
@ $DE59 label=TestMove
D $DE59 Tests whether an object can move in the direction that it is facing, by
. testing the cells that its front edge touches (including the cells that the
. velocity takes it into) for walls. A wall changes the velocity so that the
. object stops at the wall, and sets the flag for a collision (bit 0 of the
. flags).
E $DE59 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CD8C }
. LIST#
R $DE59 IX Object
  $DE59,$04 Clear the flag for a collision.
@ $DE5D label=TestMove_Keep
N $DE5D Test the move without clearing the flag for a collision.
  $DE5D,$07 Fetch the direction that the object is facing.
  $DE64,$06 Run the routine for the direction.

w $DE6A Test Move Routines
@ $DE6A label=TestMoveRoutines
D $DE6A The routines that #R$DE5D runs to test a move, for each of the four
. directions (up the screen, right, down the screen and left).
W $DE6A,$08,$02

c $DE72 Test Move Up
@ $DE72 label=TestMoveUp
D $DE72 Tests the move of an object that is facing up the screen (along the
. positive Y axis). The front edge is at the Y position plus the depth of the
. object, and it is tested from the left corner to the right corner, in the cell
. that the edge is in and then in the next one along the Y axis that the
. velocity takes the object into. Each cell is tested by #R$DFFA.
E $DE72 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CDA5 }
. LIST#
R $DE72 IX Object
R $DE72 O:F The carry flag is set if there was a collision
  $DE72,$06 Fetch the X position of the object.
  $DE78,$05 Fetch the half width of the object.
  $DE7D,$04 Subtract it to get the left edge, and keep it in #REGde.
  $DE81,$06 Fetch the Y position of the object.
  $DE87,$04 Add the half depth to get the front edge.
  $DE8B,$02 Save the left edge and the front edge.
  $DE8D,$03 Check whether the front left corner of the object hits a wall.
  $DE90,$02 Get the edges back, with the registers swapped over.
  $DE92,$01 Return if the object hit a wall.
  $DE93,$02 Save the edges again.
  $DE95,$07 Work out the width of the object.
  $DE9C,$01 Keep the cell of the left edge.
  $DE9D,$01 Work out the right edge.
  $DE9E,$03 Jump to #R$DEC5 if the right edge is in the same cell as the left
. edge.
  $DEA1,$01 Use the right edge.
  $DEA2,$03 Check whether the front right corner of the object hits a wall.
  $DEA5,$02 Get the edges back.
  $DEA7,$01 Return if the object hit a wall.
  $DEA8,$05 Fetch the velocity along the Y axis.
  $DEAD,$01 Keep the cell of the front edge.
  $DEAE,$01 Work out where the velocity takes the front edge to.
  $DEAF,$02 Return if the front edge stays in the same cell.
  $DEB1,$02 Save the edges.
  $DEB3,$03 Check whether the front left corner hits a wall in the next cell.
  $DEB6,$02 Get the edges back, with the registers swapped over.
  $DEB8,$01 Return if the object hit a wall.
  $DEB9,$07 Work out the width of the object.
  $DEC0,$01 Work out the right edge.
  $DEC1,$01 Use the right edge.
N $DEC2 Check whether the front right corner hits a wall in the next cell.
  $DEC2,$03 Jump to #R$DFFA.
@ $DEC5 label=TestMoveUp_SameCell
N $DEC5 The left and right edges are in the same cell.
  $DEC5,$02 Get the edges back.
  $DEC7,$05 Fetch the velocity along the Y axis.
  $DECC,$01 Keep the cell of the front edge.
  $DECD,$01 Work out where the velocity takes the front edge to.
  $DECE,$02 Return if the front edge stays in the same cell.
N $DED0 Check whether the front edge hits a wall in the next cell.
  $DED0,$03 Jump to #R$DFFA.

c $DED3 Test Move Right
@ $DED3 label=TestMoveRight
D $DED3 Tests the move of an object that is facing to the right (along the
. positive X axis), in the same way as #R$DE72. The front edge is at the X
. position plus the half width of the object, and it is tested from the top
. corner to the bottom corner. Each cell is tested by #R$E013.
E $DED3 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CE08 }
. LIST#
R $DED3 IX Object
R $DED3 O:F The carry flag is set if there was a collision
  $DED3,$06 Fetch the X position of the object.
  $DED9,$05 Fetch the half width of the object.
  $DEDE,$01 Add it to get the front edge.
  $DEDF,$01 Keep the front edge.
  $DEE0,$06 Fetch the Y position of the object.
  $DEE6,$03 Fetch the half depth of the object.
  $DEE9,$03 Subtract it to get the first side edge.
  $DEEC,$02 Save the edges.
  $DEEE,$03 Check whether the first corner of the front edge hits a wall.
  $DEF1,$02 Get the edges back.
  $DEF3,$01 Return if the object hit a wall.
  $DEF4,$02 Save the edges again.
  $DEF6,$07 Work out the depth of the object.
  $DEFD,$01 Keep the cell of the first side edge.
  $DEFE,$01 Work out the second side edge.
  $DEFF,$03 Jump to #R$DF25 if the second side edge is in the same cell as the
. first.
  $DF02,$03 Check whether the second corner of the front edge hits a wall.
  $DF05,$02 Get the edges back, with the registers swapped over.
  $DF07,$01 Return if the object hit a wall.
  $DF08,$05 Fetch the velocity along the X axis.
  $DF0D,$01 Keep the cell of the front edge.
  $DF0E,$01 Work out where the velocity takes the front edge to.
  $DF0F,$02 Return if the front edge stays in the same cell.
@ $DF11 label=TestMoveRight_Next
  $DF11,$01 Use the new position of the front edge.
  $DF12,$02 Save the edges.
  $DF14,$03 Check whether the first corner hits a wall in the next cell.
  $DF17,$02 Get the edges back.
  $DF19,$01 Return if the object hit a wall.
  $DF1A,$07 Work out the depth of the object.
  $DF21,$01 Work out the second side edge.
N $DF22 Check whether the second corner hits a wall in the next cell.
  $DF22,$03 Jump to #R$E013.
@ $DF25 label=TestMoveRight_SameCell
N $DF25 The side edges are in the same cell.
  $DF25,$02 Get the edges back, with the registers swapped over.
  $DF27,$05 Fetch the velocity along the X axis.
  $DF2C,$01 Keep the cell of the front edge.
  $DF2D,$01 Work out where the velocity takes the front edge to.
  $DF2E,$02 Return if the front edge stays in the same cell.
  $DF30,$01 Use the new position of the front edge.
N $DF31 Check whether the first corner hits a wall in the next cell.
  $DF31,$03 Jump to #R$E013.

c $DF34 Test Move Down
@ $DF34 label=TestMoveDown
D $DF34 Tests the move of an object that is facing down the screen (along the
. negative Y axis), in the same way as #R$DE72. The front edge is at the Y
. position minus the half depth of the object, and it is tested from the left
. corner to the right corner. Each cell is tested by #R$E00B.
E $DF34 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CE6B }
. LIST#
R $DF34 IX Object
R $DF34 O:F The carry flag is set if there was a collision
  $DF34,$06 Fetch the X position of the object.
  $DF3A,$05 Fetch the half width of the object.
  $DF3F,$04 Subtract it to get the left edge, and keep it in #REGde.
  $DF43,$06 Fetch the Y position of the object.
  $DF49,$03 Fetch the half depth of the object.
  $DF4C,$03 Subtract it to get the front edge.
  $DF4F,$02 Save the edges.
  $DF51,$03 Check whether the front left corner of the object hits a wall.
  $DF54,$02 Get the edges back, with the registers swapped over.
  $DF56,$01 Return if the object hit a wall.
  $DF57,$02 Save the edges again.
  $DF59,$07 Work out the width of the object.
  $DF60,$01 Keep the cell of the left edge.
  $DF61,$01 Work out the right edge.
  $DF62,$03 Jump to #R$DF89 if the right edge is in the same cell as the left
. edge.
  $DF65,$01 Use the right edge.
  $DF66,$03 Check whether the front right corner of the object hits a wall.
  $DF69,$02 Get the edges back.
  $DF6B,$01 Return if the object hit a wall.
  $DF6C,$05 Fetch the velocity along the Y axis, which is negative.
  $DF71,$04 Work out the position that the velocity takes the front edge to, and
. return if it is in the same cell.
  $DF75,$02 Save the edges.
  $DF77,$03 Check whether the front left corner hits a wall in the next cell.
  $DF7A,$02 Get the edges back, with the registers swapped over.
  $DF7C,$01 Return if the object hit a wall.
  $DF7D,$07 Work out the width of the object.
  $DF84,$01 Work out the right edge.
  $DF85,$01 Use the right edge.
N $DF86 Check whether the front right corner hits a wall in the next cell.
  $DF86,$03 Jump to #R$E00B.
@ $DF89 label=TestMoveDown_SameCell
N $DF89 The left and right edges are in the same cell.
  $DF89,$02 Get the edges back.
  $DF8B,$05 Fetch the velocity along the Y axis, which is negative.
  $DF90,$04 Work out the position that the velocity takes the front edge to, and
. return if it is in the same cell.
N $DF94 Check whether the front edge hits a wall in the next cell.
  $DF94,$03 Jump to #R$E00B.

c $DF97 Test Move Left
@ $DF97 label=TestMoveLeft
D $DF97 Tests the move of an object that is facing to the left (along the
. negative X axis), in the same way as #R$DE72. The front edge is at the X
. position minus the half width of the object, and it is tested from the top
. corner to the bottom corner. Each cell is tested by #R$E020.
E $DF97 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CED0 }
. LIST#
R $DF97 IX Object
R $DF97 O:F The carry flag is set if there was a collision
  $DF97,$06 Fetch the X position of the object.
  $DF9D,$05 Fetch the half width of the object.
  $DFA2,$04 Subtract it to get the front edge, and keep it in #REGde.
  $DFA6,$06 Fetch the Y position of the object.
  $DFAC,$03 Fetch the half depth of the object.
  $DFAF,$03 Subtract it to get the first side edge.
  $DFB2,$02 Save the edges.
  $DFB4,$03 Check whether the first corner of the front edge hits a wall.
  $DFB7,$02 Get the edges back, with the registers swapped over.
  $DFB9,$01 Return if the object hit a wall.
  $DFBA,$02 Save the edges again.
  $DFBC,$07 Work out the depth of the object.
  $DFC3,$02 Work out the second side edge.
  $DFC5,$03 Jump to #R$DFEB if the second side edge is in the same cell as the
. first.
  $DFC8,$03 Check whether the second corner of the front edge hits a wall.
  $DFCB,$02 Get the edges back.
  $DFCD,$01 Return if the object hit a wall.
  $DFCE,$05 Fetch the velocity along the X axis, which is negative.
  $DFD3,$04 Work out the position that the velocity takes the front edge to, and
. return if it is in the same cell.
  $DFD7,$01 Use the new position of the front edge.
  $DFD8,$02 Save the edges.
  $DFDA,$03 Check whether the first corner hits a wall in the next cell.
  $DFDD,$02 Get the edges back, with the registers swapped over.
  $DFDF,$01 Return if the object hit a wall.
  $DFE0,$07 Work out the depth of the object.
  $DFE7,$01 Work out the second side edge.
N $DFE8 Check whether the second corner hits a wall in the next cell.
  $DFE8,$03 Jump to #R$E020.
@ $DFEB label=TestMoveLeft_SameCell
N $DFEB The side edges are in the same cell.
  $DFEB,$02 Get the edges back.
  $DFED,$05 Fetch the velocity along the X axis, which is negative.
  $DFF2,$04 Work out the position that the velocity takes the front edge to, and
. return if it is in the same cell.
  $DFF6,$01 Use the new position of the front edge.
N $DFF7 Check whether the first corner hits a wall in the next cell.
  $DFF7,$03 Jump to #R$E020.

c $DFFA Test Cell Moving Up
@ $DFFA label=TestCellMovingUp
D $DFFA Tests an object that is moving up the screen (along the positive Y axis)
. against the walls in one cell. If the object hits a wall then its velocity
. along the Y axis is reduced by twice the depth that it has gone into the wall,
. and the flag for a collision is set.
R $DFFA DE X position to test
R $DFFA HL Y position to test
R $DFFA IX Object
R $DFFA O:F The carry flag is set if there was a collision
  $DFFA,$03 Check whether the object hits a wall in the cell.
  $DFFD,$01 Return if it did not.
@ $DFFE label=ReduceVelocityY
N $DFFE Reduce the velocity along the Y axis.
  $DFFE,$07 Add twice the depth to the velocity along the Y axis, which stops
. the object at the wall.
@ $E005 label=SetCollisionFlag
N $E005 Set the flag for a collision.
  $E005,$06 Set the flag for a collision, set the carry flag and return.

c $E00B Test Cell Moving Down
@ $E00B label=TestCellMovingDown
D $E00B Tests an object that is moving down the screen (along the negative Y
. axis) against the walls in one cell, in the same way as #R$DFFA.
R $E00B DE X position to test
R $E00B HL Y position to test
R $E00B IX Object
R $E00B O:F The carry flag is set if there was a collision
  $E00B,$03 Check whether the object hits a wall in the cell.
  $E00E,$01 Return if it did not.
  $E00F,$04 Make the depth positive, and jump to #R$DFFE to reduce the velocity.

c $E013 Test Cell Moving Right
@ $E013 label=TestCellMovingRight
D $E013 Tests an object that is moving to the right (along the positive X axis)
. against the walls in one cell. If the object hits a wall then its velocity
. along the X axis is reduced by twice the depth that it has gone into the wall,
. and the flag for a collision is set.
R $E013 DE X position to test
R $E013 HL Y position to test
R $E013 IX Object
R $E013 O:F The carry flag is set if there was a collision
  $E013,$03 Check whether the object hits a wall in the cell.
  $E016,$01 Return if it did not.
@ $E017 label=ReduceVelocityX
N $E017 Reduce the velocity along the X axis.
  $E017,$07 Add twice the depth to the velocity along the X axis, which stops
. the object at the wall.
  $E01E,$02 Jump to #R$E005 to set the flag for a collision.

c $E020 Test Cell Moving Left
@ $E020 label=TestCellMovingLeft
D $E020 Tests an object that is moving to the left (along the negative X axis)
. against the walls in one cell, in the same way as #R$E013.
R $E020 DE X position to test
R $E020 HL Y position to test
R $E020 IX Object
R $E020 O:F The carry flag is set if there was a collision
  $E020,$03 Check whether the object hits a wall in the cell.
  $E023,$01 Return if it did not.
  $E024,$04 Make the depth positive, and jump to #R$E017 to reduce the velocity.

c $E028 Find Position In Cell
@ $E028 label=FindPositionInCell
D $E028 Works out where an object is in a cell, and finds the tile of the cell.
. The position is in half units, with an offset of #N$40 so that it is positive
. for the object when it is in the cell or the cells next to it.
E $E028 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CF67 }
. LIST#
R $E028 D Column of the cell
R $E028 H Row of the cell
R $E028 IX Object
R $E028 O:E The position of the object along the X axis in the cell
R $E028 O:D The position of the object along the Y axis in the cell
R $E028 O:L The column of the cell
R $E028 O:H The row of the cell
  $E028,$03 Save the column and the row.
  $E02B,$03 Clear the lowest byte of the column and of the row, to give the
. position of the corner of the cell.
  $E02E,$06 Fetch the X position of the object.
  $E034,$03 Subtract the X position of the corner of the cell.
  $E037,$04 Halve the result.
  $E03B,$04 Add the offset, to give the position of the object along the X axis
. in the cell.
  $E03F,$06 Fetch the Y position of the object.
  $E045,$03 Subtract the Y position of the corner of the cell.
  $E048,$04 Halve the result.
  $E04C,$04 Add the offset, to give the position of the object along the Y axis
. in the cell.
  $E050,$01 Get the column and the row back.

c $E051 Find Map Tile
@ $E051 label=FindMapTile
D $E051 Finds the tile at a cell of the map, which is 32 cells wide and 32 cells
. high.
R $E051 L Column of the cell
R $E051 H Row of the cell
R $E051 O:A The tile (zero for no tile)
R $E051 O:F The zero flag is set if there is no tile
  $E051,$04 Save the column, and start with the row.
  $E055,$05 Multiply the row by thirty-two.
  $E05A,$02 Add the column.
  $E05C,$04 Add the address of the map.
  $E060,$03 Fetch the tile and return.

c $E063 Check Walls Vertical First
@ $E063 label=CheckWallsVerticalFirst
D $E063 Tests an object against the walls in a cell, by testing it against each
. rectangle of the tile of the cell in turn, with the position along the Y axis
. first. The rectangles are four bytes each (the X and Y positions of the
. centre, then the half width and half depth), and a zero X position ends the
. list.
E $E063 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CFA1 }
. LIST#
R $E063 DE X position to test
R $E063 HL Y position to test
R $E063 IX Object
R $E063 O:A The depth that the object has gone into the wall along the X axis
. (negative)
R $E063 O:F The carry flag is set if there was a collision
  $E063,$03 Find the position in the cell and the tile.
  $E066,$06 Find the list of rectangles for the tile.
  $E06C,$03 Use the list of rectangles.
@ $E06F label=CheckWallsVerticalFirst_Loop
  $E06F,$05 Return if there are no more rectangles.
  $E074,$05 Jump to #R$E07D to try the next rectangle if the object is not
. touching this one along the Y axis.
  $E079,$04 Return if it is touching along the X axis as well.
@ $E07D label=CheckWallsVerticalFirst_Next
  $E07D,$08 Move on to the next rectangle.
  $E085,$02 Jump back to check it.

c $E087 Check Overlap Along X
@ $E087 label=CheckOverlapAlongX
D $E087 Checks whether an object overlaps a rectangle along the X axis, using
. the position that the velocity takes the object to.
E $E087 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CFC5 }
. LIST#
R $E087 E Position of the object along the X axis in the cell
R $E087 IX Object
R $E087 IY Rectangle
R $E087 O:A The depth that the object has gone into the rectangle (negative)
R $E087 O:F The carry flag is set if the object overlaps the rectangle
  $E087,$09 Work out the combined half widths of the object and the rectangle.
  $E090,$09 Work out the distance along the X axis, including the velocity.
  $E099,$05 Make the distance positive.
@ $E09E label=CheckOverlapAlongX_Depth
  $E09E,$02 Subtract the combined half widths and return.

c $E0A0 Check Walls Horizontal First
@ $E0A0 label=CheckWallsHorizontalFirst
D $E0A0 Tests an object against the walls in a cell, in the same way as #R$E063
. but with the position along the X axis first.
E $E0A0 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CFDE }
. LIST#
R $E0A0 DE X position to test
R $E0A0 HL Y position to test
R $E0A0 IX Object
R $E0A0 O:A The depth that the object has gone into the wall along the Y axis
. (negative)
R $E0A0 O:F The carry flag is set if there was a collision
  $E0A0,$03 Find the position in the cell and the tile.
  $E0A3,$06 Find the list of rectangles for the tile.
  $E0A9,$03 Use the list of rectangles.
@ $E0AC label=CheckWallsHorizontalFirst_Loop
  $E0AC,$05 Return if there are no more rectangles.
  $E0B1,$03 Check whether the object is touching the rectangle along the X axis.
  $E0B4,$02 Jump to #R$E0BA to try the next rectangle if it is not.
  $E0B6,$03 Check whether the object is touching it along the Y axis too.
  $E0B9,$01 Return if it is, as the object has hit the wall.
@ $E0BA label=CheckWallsHorizontalFirst_Next
  $E0BA,$08 Move on to the next rectangle.
  $E0C2,$02 Jump back to check it.

c $E0C4 Check Overlap Along Y
@ $E0C4 label=CheckOverlapAlongY
D $E0C4 Checks whether an object overlaps a rectangle along the Y axis, using
. the position that the velocity takes the object to.
E $E0C4 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D002 }
. LIST#
R $E0C4 D Position of the object along the Y axis in the cell
R $E0C4 IX Object
R $E0C4 IY Rectangle
R $E0C4 O:A The depth that the object has gone into the rectangle (negative)
R $E0C4 O:F The carry flag is set if the object overlaps the rectangle
  $E0C4,$09 Work out the combined half depths of the object and the rectangle.
  $E0CD,$09 Work out the distance along the Y axis, including the velocity.
  $E0D6,$05 Make the distance positive.
@ $E0DB label=CheckOverlapAlongY_Depth
  $E0DB,$02 Subtract the combined half depths and return.

c $E0DD Negate HL
@ $E0DD label=NegateHL
D $E0DD Negates a 16-bit number.
E $E0DD View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D01B }
. { #LUNARJETMAN$8947 }
. { #MARTIANOIDS$B4B1 }
. { #TRANZAM$6BF6 }
. LIST#
R $E0DD HL Number
R $E0DD O:HL The number negated
  $E0DD,$03 Invert the low byte.
  $E0E0,$03 Invert the high byte.
  $E0E3,$01 Add one, to make the number negative.
  $E0E4,$01 Return.

c $E0E5 Sign Extend A
@ $E0E5 label=SignExtendA
D $E0E5 Converts a signed 8-bit number into a signed 16-bit number.
E $E0E5 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D023 }
. LIST#
R $E0E5 A Number
R $E0E5 O:HL The number as 16 bits
  $E0E5,$06 Put the number in the low byte, and test its sign.
  $E0EB,$01 Use #N$FF for the high byte if the number is negative.
@ $E0EC label=SignExtendA_Set
  $E0EC,$02 Set the high byte and return.

c $E0EE Multiply A By DE
@ $E0EE label=MultiplyAByDE
D $E0EE Multiplies an 8-bit number by a 16-bit number.
E $E0EE View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE0D }
. { #ATICATAC$9AAD }
. { #GUNFRIGHT$D03E }
. { #KNIGHTLORE$D4F9 }
. { #TRANZAM$6F2F }
. { #UNDERWURLDE$AC68 }
. LIST#
R $E0EE A Multiplier
R $E0EE DE Multiplicand
R $E0EE O:HL The result
  $E0EE,$05 Start with a result of zero, and count eight bits.
@ $E0F3 label=MultiplyAByDE_Loop
  $E0F3,$04 Move on to the next bit of the multiplier, and jump to #R$E0F8 if it
. is not set.
  $E0F7,$01 Add the multiplicand to the result.
@ $E0F8 label=MultiplyAByDE_Next
  $E0F8,$02 Loop back until all the bits have been used.
  $E0FA,$01 Return.

c $E0FB Build Shift Tables
@ $E0FB label=BuildShiftTables
D $E0FB Builds the tables that the sprite drawing routines use to shift graphics
. sideways, and the table that reverses the bits in a byte.
.
. There are three pairs of 256-byte pages for shifting a byte by two, four and
. six pixels (the low byte of the shifted result is in the first page of each
. pair, counting down from #N$FF, and the high byte is in the second). #N$FA to
. #N$FF hold the shifts of the bytes as they are, and #N$F2 to #N$F7 hold the
. shifts of the bytes with their bits reversed. The page at #N$F900 holds the
. bytes with their bits reversed.
E $E0FB View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D4FD }
. LIST#
  $E0FB,$02 Start with the byte #N$00.
@ $E0FD label=BuildShiftTables_Normal
  $E0FD,$07 Start with the byte as a 16-bit number, and point #REGhl at the
. first page of the tables.
@ $E104 label=BuildShiftTables_NormalLoop
  $E104,$0E Shift the number left by two pixels, and store it in the next pair
. of pages.
  $E112,$03 Move on to the next byte, and loop back until all 256 have been
. done.
  $E115,$02 Start with the byte #N$00 again.
@ $E117 label=BuildShiftTables_Reversed
  $E117,$05 Count eight bits, and get the byte.
@ $E11C label=BuildShiftTables_Reverse
  $E11C,$05 Reverse the bits of the byte.
  $E121,$05 Start with the reversed byte as a 16-bit number, and point #REGhl at
. the first page of the reversed tables.
@ $E126 label=BuildShiftTables_ReversedLoop
  $E126,$0E Shift the number left by two pixels, and store it in the next pair
. of pages.
  $E134,$03 Move on to the next byte, and loop back until all 256 have been
. done.
  $E137,$03 Point #REGhl at #R$F900.
@ $E13A label=BuildShiftTables_ReverseTable
  $E13A,$03 Start with the byte, and count eight bits.
@ $E13D label=BuildShiftTables_ReverseBits
  $E13D,$06 Reverse the bits of the byte.
  $E143,$04 Store the reversed byte, and loop back until all 256 have been done.
  $E147,$01 Return.

c $E148 Copy Pixels To Screen
@ $E148 label=CopyPixelsToScreen
D $E148 Copies the pixels of the screen buffer onto the screen, using the stack
. to copy two bytes at a time.
E $E148 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D04B }
. LIST#
.
. The buffer holds 112 rows of 24 bytes, and the top row of the buffer is the
. bottom row of the playing area, so the rows of the buffer are copied from the
. bottom of the screen upwards. Only the 22 bytes of each row that are inside
. the border are copied, which are bytes 2 to 23 of the row.
  $E148,$09 Save the stack pointer, point it at the end of the last row of the
. playing area on the screen, and count 112 rows.
  $E151,$03 Point #REGhl at the end of the first row of the buffer.
@ $E154 label=CopyPixelsToScreen_Row
  $E154,$32 Copy the last twenty bytes of the row from the buffer onto the
. screen, two at a time.
  $E186,$04 Copy the first two bytes of the row onto the screen.
  $E18A,$01 Keep the buffer address in #REGde.
  $E18B,$04 Work out the address on the screen of the end of the row above,
. which is one pixel row up.
  $E18F,$07 Jump to #R$E1A1 unless that is the last pixel row of a character
. row.
  $E196,$07 Move up one character row, and jump to #R$E1A1 if that is in a
. different third of the screen.
  $E19D,$04 Move up to the last pixel row of the character row.
@ $E1A1 label=CopyPixelsToScreen_Next
  $E1A1,$01 Point the stack pointer at the row on the screen.
  $E1A2,$04 Move on to the end of the next row of the buffer.
  $E1A6,$02 Loop back until all of the rows have been copied.
  $E1A8,$05 Get the stack pointer back and return.

c $E1AD Copy Attributes To Screen
@ $E1AD label=CopyAttributesToScreen
D $E1AD Copies the attributes of the attribute buffer onto the screen, in the
. same way as #R$E148. The buffer holds 14 rows of 24 bytes, and the top row of
. the buffer is the bottom row of the playing area.
  $E1AD,$0C Save the stack pointer, point it at the end of the last row of
. attributes of the playing area, count 14 rows, and point #REGhl at the end of
. the first row of the buffer.
@ $E1B9 label=CopyAttributesToScreen_Row
  $E1B9,$32 Copy the last twenty bytes of the row from the buffer onto the
. screen, two at a time.
  $E1EB,$04 Copy the first two bytes of the row onto the screen.
  $E1EF,$01 Keep the buffer address in #REGde.
  $E1F0,$05 Move up one row of attributes on the screen.
  $E1F5,$04 Move on to the end of the next row of the buffer.
  $E1F9,$02 Loop back until all of the rows have been copied.
  $E1FB,$05 Get the stack pointer back and return.

c $E200 Copy Buffers To Screen
@ $E200 label=CopyBuffersToScreen
D $E200 Copies the pixels and the attributes of the screen buffer onto the
. screen, and then clears the buffer.
.
. #PUSHS #UDGTABLE { =h Before | =h After #R$E200 }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$BE2D,stop=$BE71)
. #SIM(start=$CF08,stop=$0000,sp=$5BF0)
. #SCR$02,$05,$00,$1A,$12(copy-buffers-before)
. | #SIM(start=$E200,stop=$0000,sp=$5BF0)
. #SCR$02,$05,$00,$1A,$12(copy-buffers-after) } UDGTABLE# #POPS
  $E200,$03 Copy the pixels to the screen.
  $E203,$03 Copy the attributes to the screen.
@ $E206 label=ClearScreenBuffer
N $E206 Clear the screen buffer.
  $E206,$03 Point #REGhl at the end of the attribute buffer.
  $E209,$07 Make the attribute from white ink and the colour in #R$BBFB, which
. is used for the paper.
  $E210,$05 Fill the 14 rows of the attribute buffer with it.
  $E215,$08 Clear the 112 rows of the pixel buffer.

c $E21D Fill Buffer
@ $E21D label=FillBuffer
D $E21D Fills a buffer with a word, by pushing it onto the stack. The buffer is
. filled downwards from the address in #REGhl.
E $E21D View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D0B7 }
. LIST#
R $E21D B Number of rows of 24 bytes
R $E21D DE Word to fill the buffer with
R $E21D HL Address after the end of the buffer
R $E21D O:HL Address of the start of the buffer
  $E21D,$05 Save the stack pointer, and point it at the end of the buffer.
@ $E222 label=FillBuffer_Row
  $E222,$0C Fill a row of 24 bytes by pushing twelve words onto the stack.
  $E22E,$02 Loop back until all of the rows have been filled.
  $E230,$04 Fetch the address of the start of the buffer.
  $E234,$04 Get the stack pointer back.
  $E238,$01 Return.

c $E239 Read Keyboard Port
@ $E239 label=ReadKeyboardPort
D $E239 Reads half of the keyboard. The bits of the half-row of keys to read are
. zero, and more than one half-row can be read at once.
E $E239 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B759 }
. { #CYBERUN$9BC3 }
. { #GUNFRIGHT$D0DB }
. { #KNIGHTLORE$B5F7 }
. { #PENTAGRAM$B952 }
. LIST#
R $E239 A Half-rows to read
R $E239 O:A The keys that are pressed (bits 0 to 4, with bit 0 for the key
. nearest the edge of the keyboard)
R $E239 O:F The zero flag is set if no keys are pressed
  $E239,$02 Write the half-row selector to port #N$FD. The ULA only responds to
. even port numbers, so this has no effect on the 48K Spectrum, but it leaves
. the selector in #REGa for the next instruction.
  $E23B,$02 Read the keyboard.
  $E23D,$04 Make the pressed keys into set bits, and return.

c $E241 Read Controls
@ $E241 label=ReadControls
D $E241 Reads the controls, using the method that was chosen on the game
. selection menu (bits 1 and 2 of #R$BBB0), and keeps them in #R$BC01.
.
. The bits of the controls are 0 for left, 1 for right, 2 for forward, 3 for
. fire, 4 for down and 5 for turning the view.
.
. The methods are the keyboard (0), a Kempston joystick (1), a Cursor joystick
. (2) and a Sinclair joystick (3).
E $E241 Continue on to #R$E250.
E $E241 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C8FF }
. { #GUNFRIGHT$D0E3 }
. { #KNIGHTLORE$D022 }
. LIST#
R $E241 O:C Controls
  $E241,$06 Fetch the control method.
  $E247,$03 Jump to #R$E2DA to read the keyboard if it is the keyboard.
  $E24A,$03 Jump to #R$E289 if it is a Kempston joystick.
  $E24D,$03 Jump to #R$E2AE if it is a Cursor joystick.

c $E250 Read Interface 2 Joystick
@ $E250 label=ReadInterface2Joystick
D $E250 Reads the controls from a Sinclair joystick, which can be in either of
. the two sockets (using the keys 1 to 5 or the keys 6 to 0).
E $E250 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C91B }
. { #GUNFRIGHT$D0F2 }
. { #KNIGHTLORE$D03E }
. LIST#
  $E250,$05 Read the keys 1 to 5.
  $E255,$03 Save the registers, and count five keys.
@ $E258 label=ReadInterface2Joystick_Reverse
  $E258,$05 Reverse the order of the five keys.
  $E25D,$03 Get the registers back, and keep the reversed keys.
  $E260,$05 Read the keys 6 to 0.
  $E265,$01 Combine them with the keys 1 to 5, so that the joysticks are the
. same.
  $E266,$02 Start with none of the controls.
  $E268,$06 Set the control for fire if the key for fire is pressed.
@ $E26E label=ReadInterface2Joystick_Forward
  $E26E,$06 Set the control for forward if the key for up is pressed.
@ $E274 label=ReadInterface2Joystick_Down
  $E274,$06 Set the control for down if the key for down is pressed.
@ $E27A label=ReadInterface2Joystick_Right
  $E27A,$06 Set the control for right if the key for right is pressed.
@ $E280 label=ReadInterface2Joystick_Left
  $E280,$06 Set the control for left if the key for left is pressed.
@ $E286 label=ReadInterface2Joystick_ViewKey
  $E286,$03 Jump to #R$E31C to read the key for turning the view.

c $E289 Read Kempston Joystick
@ $E289 label=ReadKempstonJoystick
D $E289 Reads the controls from a Kempston joystick.
E $E289 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C954 }
. { #GUNFRIGHT$D12B }
. { #KNIGHTLORE$D077 }
. LIST#
  $E289,$04 Read the joystick, and start with none of the controls.
  $E28D,$06 Set the control for right if the joystick is pushed right.
@ $E293 label=ReadKempstonJoystick_Left
  $E293,$06 Set the control for left if the joystick is pushed left.
@ $E299 label=ReadKempstonJoystick_Down
  $E299,$06 Set the control for down if the joystick is pushed down.
@ $E29F label=ReadKempstonJoystick_Forward
  $E29F,$06 Set the control for forward if the joystick is pushed up.
@ $E2A5 label=ReadKempstonJoystick_Fire
  $E2A5,$06 Set the control for fire if the fire button is pressed.
@ $E2AB label=ReadKempstonJoystick_ViewKey
  $E2AB,$03 Jump to #R$E31C to read the key for turning the view.

c $E2AE Read Cursor Joystick
@ $E2AE label=ReadCursorJoystick
D $E2AE Reads the controls from a Cursor joystick (which uses the keys 5, 6, 7,
. 8 and 0).
E $E2AE View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C979 }
. { #GUNFRIGHT$D150 }
. { #KNIGHTLORE$D09C }
. LIST#
  $E2AE,$02 Start with none of the controls.
  $E2B0,$05 Read the keys 1 to 5.
  $E2B5,$06 Set the control for left if the key 5 is pressed.
@ $E2BB label=ReadCursorJoystick_SecondRow
  $E2BB,$05 Read the keys 6 to 0.
  $E2C0,$06 Set the control for fire if the key 0 is pressed.
@ $E2C6 label=ReadCursorJoystick_Forward
  $E2C6,$06 Set the control for forward if the key 7 is pressed.
@ $E2CC label=ReadCursorJoystick_Right
  $E2CC,$06 Set the control for right if the key 8 is pressed.
@ $E2D2 label=ReadCursorJoystick_Down
  $E2D2,$08 Set the control for down if the key 6 is pressed, and jump to
. #R$E31C to read the key for turning the view.

c $E2DA Read Keyboard
@ $E2DA label=ReadKeyboard
D $E2DA Reads the controls from the keyboard. Left is X, V, M or B, right is C
. or N, forward is any key from A to G or from H to ENTER, fire is any key from
. Q to T or from Y to P, and down is any key from 1 to 5 or from 6 to 0.
  $E2DA,$05 Read the keys CAPS SHIFT, Z, X, C and V.
  $E2DF,$02 Move the keys X and C into bits 0 and 1, for left and right.
  $E2E1,$06 Set the control for left as well if the key V is pressed.
@ $E2E7 label=ReadKeyboard_Right
  $E2E7,$03 Keep the controls for X and C, and start with them.
  $E2EA,$05 Read the keys SPACE, SYMBOL SHIFT, M, N and B.
  $E2EF,$06 Set the control for left if the key M is pressed.
@ $E2F5 label=ReadKeyboard_KeyN
  $E2F5,$06 Set the control for right if the key N is pressed.
@ $E2FB label=ReadKeyboard_KeyB
  $E2FB,$06 Set the control for left if the key B is pressed.
@ $E301 label=ReadKeyboard_Forward
  $E301,$05 Read the keys A to G and H to ENTER.
  $E306,$04 Set the control for forward if any of them are pressed.
@ $E30A label=ReadKeyboard_Fire
  $E30A,$09 Read the keys Q to T and Y to P, and set the control for fire if any
. of them are pressed.
@ $E313 label=ReadKeyboard_Down
  $E313,$09 Read the keys 1 to 5 and 6 to 0, and set the control for down if any
. of them are pressed.

c $E31C Read View Key
@ $E31C label=ReadViewKey
D $E31C Reads the key for turning the view (Z or SYMBOL SHIFT), and keeps the
. controls in #R$BC01.
R $E31C C Controls
  $E31C,$05 Read the keys CAPS SHIFT, Z, SPACE and SYMBOL SHIFT.
  $E321,$06 Set the control for turning the view if the key Z or SYMBOL SHIFT is
. pressed.
@ $E327 label=ReadViewKey_Store
  $E327,$05 Store the controls and return.

c $E32C Pause Game
@ $E32C label=PauseGame
D $E32C Pauses the game when CAPS SHIFT or SPACE is pressed on its own. The game
. continues when the key has been pressed again.
E $E32C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE22 }
. { #GUNFRIGHT$D206 }
. { #KNIGHTLORE$D50E }
. LIST#
  $E32C,$05 Read the keys CAPS SHIFT, Z, X, C, V, SPACE, SYMBOL SHIFT, M, N and
. B.
  $E331,$03 Return if neither of the keys CAPS SHIFT or SPACE is pressed.
  $E334,$03 Return if any of the other keys is pressed too.
@ $E337 label=PauseGame_Release
N $E337 Wait for the key to be released.
  $E337,$09 Read the keys, and loop back until neither of the keys is pressed.
@ $E340 label=PauseGame_Press
N $E340 Wait for a key to be pressed.
  $E340,$09 Read the keys, and loop back until one of the keys is pressed.
@ $E349 label=PauseGame_ReleaseAgain
N $E349 Wait for the key to be released.
  $E349,$09 Read the keys, and loop back until neither of the keys is pressed.
  $E352,$01 Return.

c $E353 Flip Sprite
@ $E353 label=FlipSprite
D $E353 Turns a sprite upside down or round (or back again) when the flags of an
. object say that it should be the other way up or round from how it was last
. time. The sprite is changed in place, with bits 7 (upside down) and 6
. (reversed) of its first byte showing how it is.
.
. A sprite is made of a byte for the width in characters (bits 0 to 3) and the
. flags, a byte for the number of rows, and then the rows, with the bottom row
. first. Each row has a pair of bytes for each character: the mask and then the
. pixels.
E $E353 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D174 }
. { #KNIGHTLORE$D865 }
. LIST#
R $E353 IX Object
R $E353 O:DE Address of the sprite
  $E353,$03 Fetch the type of the object.
  $E356,$06 Find the address of the sprite in the table of sprites.
  $E35C,$02 Move the address of the sprite into #REGde and keep it.
  $E35E,$08 Jump to #R$E39A if the sprite is already the right way up.
N $E366 Turn the sprite upside down, by swapping the rows.
  $E366,$04 Flip the flag for being upside down.
  $E36A,$04 Work out the number of bytes in a row (two for each character).
  $E36E,$03 Fetch the number of rows of the sprite.
  $E371,$02 Point at the first row, and keep the address.
  $E373,$03 Set the number of bytes in a row.
  $E376,$03 Work out the number of bytes in the sprite.
  $E379,$03 Work out the address of the end of the sprite, and move it into
. #REGde.
  $E37C,$04 Point #REGhl at the start of the second row.
  $E380,$02 Point #REGhl at the end of the first row, and #REGde at the end of
. the last row.
  $E382,$02 Work out the number of pairs of rows to swap.
@ $E384 label=FlipSprite_Rows
  $E384,$01 Keep the number of bytes in a row and the number of rows.
@ $E385 label=FlipSprite_Bytes
  $E385,$09 Swap the bytes of the two rows, from the end backwards, until the
. whole of both rows has been swapped.
  $E38E,$01 Get the number of bytes in a row and the number of rows back.
  $E38F,$08 Move #REGhl on to the end of the next row down.
  $E397,$03 Loop back until all of the pairs of rows have been swapped.
@ $E39A label=FlipSprite_Reverse
N $E39A Turn the sprite round, by reversing the rows.
  $E39A,$02 Fetch the address of the sprite.
  $E39C,$08 Jump to #R$E3D4 if the sprite is already the right way round.
@ $E3A4 label=FlipSprite_Mirror
  $E3A4,$04 Flip the flag for being reversed.
  $E3A8,$04 Fetch the width of the sprite in characters.
  $E3AC,$03 Fetch the number of rows of the sprite, and keep it.
  $E3AF,$02 Start with the first row.
  $E3B1,$06 Point the shadow #REGhl at the first row, and the shadow #REGb at
. the table for reversing bits.
@ $E3B7 label=FlipSprite_Row
  $E3B7,$04 Reverse the bits of the mask of a character, using the table.
  $E3BB,$04 Reverse the bits of the pixels of the character.
  $E3BF,$05 Keep them on the stack, and loop back until the row has been done.
  $E3C4,$01 Count the characters again.
@ $E3C5 label=FlipSprite_Store
  $E3C5,$07 Put the characters back in the row, in the reverse order.
  $E3CC,$04 Jump to #R$E3D4 when all the rows have been done.
  $E3D0,$04 Count the characters again, and loop back to do the next row.
@ $E3D4 label=FlipSprite_Done
  $E3D4,$02 Get the address of the sprite back, and return.

c $E3D6 Mirror Sprite
@ $E3D6 label=MirrorSprite
D $E3D6 Turns a sprite round, and flips the flag in the sprite that shows
. whether it is reversed.
R $E3D6 DE Address of the sprite
  $E3D6,$03 Keep the address of the sprite, and jump to #R$E3A4 to reverse it.

c $E3D9 Draw Object
@ $E3D9 label=DrawObject
D $E3D9 Draws an object, if it is on the screen. The position of the object is
. worked out from its position in the world and the offsets of its sprite, and
. kept in the object.
.
. #PUSHS #UDGTABLE { =h After #R$E3D9 }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$BE2D,stop=$BE71)
. #POKES$BC02,$70
. #SIM(start=$E3D9,stop=$0000,ix=$BC9E,sp=$5BF0)
. #SIM(start=$E3D9,stop=$0000,ix=$BC8E,sp=$5BF0)
. #SIM(start=$E200,stop=$0000,sp=$5BF0)
. #SCR$02,$05,$00,$1A,$12(draw-object) } UDGTABLE# #POPS
R $E3D9 IX Object
  $E3D9,$03 Work out the position of the object on the screen.
  $E3DC,$06 Return if the position along the X axis is outside the screen.
  $E3E2,$07 Add the offset of the sprite along the X axis, and return if that is
. past the right edge of the window.
  $E3E9,$06 Return if it is past the left edge, and set the X position of the
. sprite.
  $E3EF,$06 Return if the position along the Y axis is outside the screen.
  $E3F5,$07 Add the offset of the sprite along the Y axis, and return if that is
. past the top edge of the window.
  $E3FC,$03 Set the Y position of the sprite.

c $E3FF Draw Sprite
@ $E3FF label=DrawSprite
D $E3FF Draws the sprite of an object in the screen buffer, with its mask. The
. sprite is clipped at the top and bottom of the window by its position. A
. sprite is drawn by popping its bytes off the stack, so the code that does the
. drawing changes itself to fit the sprite.
.
. Only the rows of a player sprite that the timer at #R$BC02 allows are drawn,
. so the player appears from the bottom to the top while materialising.
.
. The bottom of the buffer is the top of the window, and the rows of a sprite
. are stored from the bottom upwards, so a sprite starts at its Y position and
. is drawn towards the top of the screen.
R $E3FF IX Object
  $E3FF,$03 Turn the sprite round or upside down, if it needs it.
  $E402,$05 Work out the position of the sprite in a character, in pixels
. (#N$00, #N$02, #N$04 or #N$06).
  $E407,$03 Jump to #R$E48E if the sprite is on a character boundary.
  $E40A,$03 Make the high byte of the address of the table for shifting the
. sprite.
  $E40D,$06 Fetch the width of the sprite, and add one for the part that is
. shifted into the next character.
  $E413,$03 Keep the number of characters to draw.
  $E416,$05 Double the width of the sprite in characters.
  $E41B,$04 Multiply it by nine, to make eighteen bytes of code for each
. character.
  $E41F,$04 Subtract the length of the code from the end of the shifted row.
@ $E423 label=DrawSprite_Patch
N $E423 Change the code to jump into the row.
  $E423,$03 Set the offset of the jump in the code.
  $E426,$07 Work out the number of bytes to move on to the next row, and set it
. in the code.
  $E42D,$01 Start with the sprite.
  $E42E,$07 Check whether the object is one of the legs or the body of the
. player.
  $E435,$02 Use a height of #N$70 (the whole window).
  $E437,$02 Jump to #R$E43C unless it is the player.
  $E439,$03 Use the height of the player while materialising.
@ $E43C label=DrawSprite_Clip
N $E43C Clip the sprite at the top and bottom of the window.
  $E43C,$01 Keep the height.
  $E43D,$07 Work out the position of the sprite in the window, and jump to
. #R$E46E if it starts below the window.
  $E444,$02 Return if it starts above the height of the window.
  $E446,$02 Work out the number of rows that fit between the sprite and the top
. of the window.
  $E448,$03 Jump to #R$E44C if fewer rows fit than there are in the sprite.
  $E44B,$01 Otherwise use the number of rows of the sprite.
@ $E44C label=DrawSprite_Rows
  $E44C,$04 Point at the first row of the sprite, and keep the number of rows to
. draw.
@ $E450 label=DrawSprite_Draw
N $E450 Set up the registers, and draw the rows of the sprite.
  $E450,$02 Keep the address of the sprite.
  $E452,$06 Fetch the position of the sprite.
  $E458,$03 Find the address of the position in the screen buffer.
  $E45B,$02 Move it into #REGbc.
  $E45D,$01 Get the address of the sprite back.
  $E45E,$04 Keep the stack pointer.
  $E462,$03 Point the stack pointer at the sprite.
  $E465,$04 Flag that the object has been drawn.
  $E469,$03 Fetch the number of rows to draw.
  $E46C,$02 Jump to #R$E4C9 to draw them.
@ $E46E label=DrawSprite_Below
N $E46E The sprite starts below the window, so skip the rows that are not
. visible.
  $E46E,$03 Work out the number of rows to skip.
  $E471,$02 Work out the number of rows that are left.
  $E473,$02 Return if no rows are left.
  $E475,$05 Keep the number of rows to draw, and clear #REGb.
  $E47A,$04 Fetch the width of the sprite.
  $E47E,$02 Point at the first row.
  $E480,$04 Work out the number of bytes that make up a row, and double it.
@ $E484 label=DrawSprite_Skip
  $E484,$04 Skip the rows, one at a time.
  $E488,$04 Start the sprite at the bottom of the window.
  $E48C,$02 Jump to #R$E450 to draw the sprite.
@ $E48E label=DrawSprite_Aligned
N $E48E The sprite is on a character boundary.
  $E48E,$04 Fetch the width of the sprite.
  $E492,$03 Keep the number of characters to draw.
  $E495,$01 Make it the count of characters.
  $E496,$03 Multiply it by eight.
  $E499,$02 Negate it.
  $E49B,$02 Take off the length of the code that is left after the characters.
  $E49D,$02 Jump to #R$E423 to change the code.

c $E49F Draw Aligned Columns
@ $E49F label=DrawAlignedColumns
D $E49F The code that draws a row of a sprite that is on a character boundary.
. There is a copy of the code for each of up to five characters, and the code is
. entered at the one that leaves the number of characters of the sprite, by
. #R$E3FF. Each character takes a mask and pixels from the stack, and puts them
. on the screen buffer: the pixels under the mask are cleared, and then the
. pixels of the sprite are set.
E $E49F View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D08F }
. { #GUNFRIGHT$BE5B }
. { #KNIGHTLORE$D780 }
. { #PENTAGRAM$B44F }
. LIST#
R $E49F BC Address in the screen buffer
@ $E49F label=DrawAlignedColumns_Five
  $E49F,$01 Take the mask and the pixels of the first character from the stack.
  $E4A0,$01 Fetch the byte of the screen buffer.
  $E4A1,$04 Clear the pixels under the mask, and set the pixels of the sprite.
  $E4A5,$02 Put the byte in the screen buffer, and move on to the next byte.
@ $E4A7 label=DrawAlignedColumns_Four
  $E4A7,$01 Take the mask and the pixels of the second character from the stack.
  $E4A8,$01 Fetch the byte of the screen buffer.
  $E4A9,$04 Clear the pixels under the mask, and set the pixels of the sprite.
  $E4AD,$02 Put the byte in the screen buffer, and move on to the next byte.
@ $E4AF label=DrawAlignedColumns_Three
  $E4AF,$01 Take the mask and the pixels of the third character from the stack.
  $E4B0,$01 Fetch the byte of the screen buffer.
  $E4B1,$04 Clear the pixels under the mask, and set the pixels of the sprite.
  $E4B5,$02 Put the byte in the screen buffer, and move on to the next byte.
@ $E4B7 label=DrawAlignedColumns_Two
  $E4B7,$01 Take the mask and the pixels of the fourth character from the stack.
  $E4B8,$01 Fetch the byte of the screen buffer.
  $E4B9,$04 Clear the pixels under the mask, and set the pixels of the sprite.
  $E4BD,$02 Put the byte in the screen buffer, and move on to the next byte.
@ $E4BF label=DrawAlignedColumns_One
  $E4BF,$01 Take the mask and the pixels of the fifth character from the stack.
  $E4C0,$01 Fetch the byte of the screen buffer.
  $E4C1,$04 Clear the pixels under the mask, and set the pixels of the sprite.
  $E4C5,$01 Put the byte in the screen buffer.
  $E4C6,$03 Jump to #R$E528 to move on to the next row.

c $E4C9 Draw Sprite Row
@ $E4C9 label=DrawSpriteRow
D $E4C9 Starts drawing a row of a sprite, by jumping into the code for the width
. of the sprite. The offset of the jump is set by #R$E3FF.
R $E4C9 A' Number of rows left to draw
R $E4C9 BC Address in the screen buffer
  $E4C9,$01 Keep the number of rows left to draw.
  $E4CA,$01 Fetch the first byte of the row from the screen buffer.
@ $E4CB label=DrawSpriteRow_Jump
  $E4CB,$02 Jump into the row to draw the characters (the offset is changed by
. the code that sets up the drawing).

c $E4CD Draw Shifted Columns
@ $E4CD label=DrawShiftedColumns
D $E4CD The code that draws a row of a sprite that has been shifted by two, four
. or six pixels. There is a copy of the code for each of up to five characters,
. and the code is entered at the one that leaves the number of characters of the
. sprite, from #R$E4C9.
.
. Each character takes a mask and pixels from the stack. The shifted halves of
. them come from the tables that #R$E0FB builds, with the high byte of the
. address of the table in #REGh, and the low byte of the address from the mask
. or the pixels. The part that goes into the first character of the screen
. buffer is combined with what is left over from the previous character, and the
. part that goes into the next character is kept for the next time.
E $E4CD View the equivalent code in;
. #LIST
. { #GUNFRIGHT$BE8A }
. LIST#
R $E4CD A The first byte of the row in the screen buffer
R $E4CD BC Address in the screen buffer
R $E4CD H Page of the table for the first parts of the shifted bytes
@ $E4CD label=DrawShiftedColumns_Five
  $E4CD,$07 Take the mask and the pixels of the first character from the stack,
. clear the pixels under the first part of the mask in the byte that is left
. over, and set the first part of the pixels.
  $E4D4,$03 Put the byte in the screen buffer, move on to the next byte and
. point #REGh at the table for the second parts.
  $E4D7,$07 Fetch the next byte of the screen buffer, clear the pixels under the
. second part of the mask, and set the second part of the pixels, to be left
. over for the next character.
  $E4DE,$01 Point #REGh at the table for the first parts again, ready for the
. next character.
@ $E4DF label=DrawShiftedColumns_Four
  $E4DF,$07 Take the mask and the pixels of the second character from the stack,
. clear the pixels under the first part of the mask in the byte that is left
. over, and set the first part of the pixels.
  $E4E6,$03 Put the byte in the screen buffer, move on to the next byte and
. point #REGh at the table for the second parts.
  $E4E9,$07 Fetch the next byte of the screen buffer, clear the pixels under the
. second part of the mask, and set the second part of the pixels, to be left
. over for the next character.
  $E4F0,$01 Point #REGh at the table for the first parts again, ready for the
. next character.
@ $E4F1 label=DrawShiftedColumns_Three
  $E4F1,$07 Take the mask and the pixels of the third character from the stack,
. clear the pixels under the first part of the mask in the byte that is left
. over, and set the first part of the pixels.
  $E4F8,$03 Put the byte in the screen buffer, move on to the next byte and
. point #REGh at the table for the second parts.
  $E4FB,$07 Fetch the next byte of the screen buffer, clear the pixels under the
. second part of the mask, and set the second part of the pixels, to be left
. over for the next character.
  $E502,$01 Point #REGh at the table for the first parts again, ready for the
. next character.
@ $E503 label=DrawShiftedColumns_Two
  $E503,$07 Take the mask and the pixels of the fourth character from the stack,
. clear the pixels under the first part of the mask in the byte that is left
. over, and set the first part of the pixels.
  $E50A,$03 Put the byte in the screen buffer, move on to the next byte and
. point #REGh at the table for the second parts.
  $E50D,$07 Fetch the next byte of the screen buffer, clear the pixels under the
. second part of the mask, and set the second part of the pixels, to be left
. over for the next character.
  $E514,$01 Point #REGh at the table for the first parts again, ready for the
. next character.
@ $E515 label=DrawShiftedColumns_One
  $E515,$07 Take the mask and the pixels of the fifth character from the stack,
. clear the pixels under the first part of the mask in the byte that is left
. over, and set the first part of the pixels.
  $E51C,$03 Put the byte in the screen buffer, move on to the next byte and
. point #REGh at the table for the second parts.
  $E51F,$07 Fetch the next byte of the screen buffer, clear the pixels under the
. second part of the mask, and set the second part of the pixels, to be left
. over for the next character.
  $E526,$01 Point #REGh at the table for the first parts again, ready for the
. next character.
@ $E527 label=DrawShiftedColumns_Last
  $E527,$01 Put the part of the last character that is left over in the screen
. buffer.

c $E528 End Sprite Row
@ $E528 label=EndSpriteRow
D $E528 Moves on to the next row of a sprite after one has been drawn. The
. number that is added to the address in the screen buffer is set by #R$E3FF.
R $E528 BC Address in the screen buffer
  $E528,$04 Add the number of bytes to the next row to the low byte of the
. address (the number is set by the code that sets up the drawing).
  $E52C,$04 Add the carry to the high byte.
  $E530,$01 Get the number of rows left back.
  $E531,$01 Count down the number of rows.
  $E532,$03 Loop back to draw the next row.
  $E535,$05 Get the stack pointer back, and return.

c $E53A Calculate Buffer Address
@ $E53A label=CalculateBufferAddress
D $E53A Works out the address in the screen buffer of a position in the window.
. The buffer is 24 bytes wide.
E $E53A View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D233 }
. LIST#
R $E53A H Y position (from #N$48 at the first row of the buffer)
R $E53A L X position
R $E53A O:HL Address in the screen buffer
  $E53A,$01 Save #REGbc.
  $E53B,$06 Divide the X position by eight.
  $E541,$04 Keep the column, and start with the Y position.
  $E545,$03 Multiply the Y position by eight.
  $E548,$02 Keep the result.
  $E54A,$02 Multiply by two more, and add it to get 24 times the Y position.
  $E54C,$03 Add the X position divided by eight.
  $E54F,$01 Add the column.
  $E550,$04 Add the address of the buffer.
  $E554,$02 Get #REGbc back and return.

c $E556 Calculate Screen Address
@ $E556 label=CalculateScreenAddress
D $E556 Works out the address on the screen of a position given in pixels,
. measured from the bottom left of the screen.
E $E556 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D135 }
. { #GUNFRIGHT$D24F }
. LIST#
R $E556 H Y position (from the bottom of the screen)
R $E556 L X position
R $E556 O:HL Screen address
  $E556,$02 Keep #REGde, and put the position in it.
  $E558,$07 Work out the column from the X position.
  $E55F,$08 Work out the character row within a third of the screen, from the Y
. position measured from the top.
  $E567,$08 Work out the third of the screen.
  $E56F,$08 Work out the pixel row within the character, and make the high byte
. of the address.
  $E577,$02 Get #REGde back and return.

c $E579 Calculate Attribute Address
@ $E579 label=CalculateAttributeAddress
D $E579 Works out the address in the attribute buffer of a position in the
. window. The buffer is 24 bytes wide, and has a row for each eight rows of the
. screen buffer.
R $E579 H Y position (from #N$48 at the first row of the buffer)
R $E579 L X position
R $E579 O:HL Address in the attribute buffer
  $E579,$01 Save #REGbc.
  $E57A,$01 Keep the X position.
  $E57B,$06 Work out the Y position at the start of its character row.
  $E581,$03 Fetch the X position, and copy the Y position into #REGbc.
  $E584,$02 Multiply the Y position by three, to make 24 times the row.
  $E586,$06 Work out the column from the X position.
  $E58C,$03 Make the column into a 16-bit number.
  $E58F,$01 Add the column.
  $E590,$04 Add the address of the attribute buffer.
  $E594,$02 Get #REGbc back and return.

c $E596 Add A To HL
@ $E596 label=AddAToHL
D $E596 Adds a number to a 16-bit number.
E $E596 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE06 }
. { #ATICATAC$926C }
. { #CYBERUN$9BCF }
. { #KNIGHTLORE$D4F2 }
. { #PENTAGRAM$B519 }
. LIST#
R $E596 A Number to add
R $E596 HL Number
R $E596 O:HL The sum
  $E596,$02 Add the number to the low byte.
  $E598,$04 Add the carry to the high byte.
  $E59C,$01 Return.

c $E59D Clear Screen
@ $E59D label=ClearScreen
D $E59D Clears the whole screen to white ink on black paper, and sets the border
. to black.
.
. #PUSHS #UDGTABLE { =h Before | =h After #R$E59D }
. { #SIM(start=$BE04,stop=$BE18,sp=$5E00,r=$80,clear=1)
. #SIM(start=$BE18,stop=$BE24)
. #SIM(start=$BE2D,stop=$BE71)
. #SIM(start=$BE71,stop=$BECD)
. #SIM(start=$BECD,stop=$BED0)
. #SCR$02(clear-screen-before)
. | #SIM(start=$E59D,stop=$0000,sp=$5BF0)
. #SCR$02(clear-screen-after) } UDGTABLE# #POPS
  $E59D,$03 Clear the pixels.
  $E5A0,$03 Clear the attributes.
  $E5A3,$04 Set the border to black.
  $E5A7,$01 Return.

c $E5A8 Clear Pixels
@ $E5A8 label=ClearPixels
D $E5A8 Clears the pixels of the screen.
E $E5A8 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE60 }
. { #ATICATAC$80B4 }
. { #COOKIE$74D4 }
. { #CYBERUN$9A7E }
. { #GUNFRIGHT$D6DB }
. { #JETPAC$71B8 }
. { #KNIGHTLORE$D544 }
. { #LUNARJETMAN$84AD }
. { #PSSST$7439 }
. { #SABREWULF$BB81 }
. { #TRANZAM$7211 }
. LIST#
  $E5A8,$06 Point at #N$4000 (in the screen buffer), and count the bytes.
  $E5AE,$02 Jump to #R$E5BA to clear them.

c $E5B0 Clear Attributes
@ $E5B0 label=ClearAttributes
D $E5B0 Sets the attributes of the screen to white ink on black paper.
  $E5B0,$06 Point at #N$5800 (in the attribute buffer), and count the bytes.
  $E5B6,$02 Use the attribute for white ink on black paper.
  $E5B8,$02 Jump to #R$E5BC to fill them.

c $E5BA Fill Memory
@ $E5BA label=FillMemory
D $E5BA Fills memory with a byte. Entering at #R$E5BA fills it with zero.
E $E5BA View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE56 }
. { #GUNFRIGHT$D6E1 }
. { #KNIGHTLORE$D53A }
. { #MARTIANOIDS$B1A3 }
. { #PENTAGRAM$CB77 }
. { #UNDERWURLDE$9569 }
. LIST#
R $E5BA BC Number of bytes
R $E5BA E Byte to fill with (when entering at #R$E5BC)
R $E5BA HL Address
  $E5BA,$02 Use zero to fill the memory.
@ $E5BC label=FillMemory_WithValue
  $E5BC,$07 Fill the memory, and loop back until all of the bytes have been
. filled.
  $E5C3,$01 Return.

s $E5C4 Pixel Buffer
@ $E5C4 label=PixelBuffer
D $E5C4 The buffer that the view of the village is drawn in before it is copied
. to the playing area of the screen. It is #N$18 bytes wide and #N$70 rows high,
. and the top row of the buffer is the bottom row of the playing area. The
. contents at the time of the snapshot are left over from loading.
S $E5C4,$17,$17
@ $E5DB label=PixelBuffer_FirstRowEnd
S $E5DB,$A69,$0A69

s $F044 Attribute Buffer
@ $F044 label=AttributeBuffer
D $F044 The buffer that the attributes of the playing area are made in before
. they are copied to the screen. It is #N$18 bytes wide and #N$0E rows high.
S $F044,$17,$17
@ $F05B label=AttributeBuffer_FirstRowEnd
S $F05B,$139,$0139

s $F194 Unused
@ $F194 label=AttributeBuffer_End
D $F194 #N$6C bytes that the game does not use.
S $F194,$6C,$6C

s $F200 Reversed Shift Tables
@ $F200 label=ReversedShiftTables
D $F200 Six pages of tables that are built by #R$E0FB, which shift the bytes
. with their bits reversed by two, four and six pixels. For each shift there is
. a page for the low byte of the result and a page for the high byte. The
. contents at the time of the snapshot are left over from loading.
S $F200,$600,$0600

s $F800 Unused
D $F800 A page that the game does not use.
S $F800,$100,$0100

s $F900 Reverse Bits Table
@ $F900 label=ReverseBitsTable
D $F900 The table that is built by #R$E0FB, which holds each byte with its bits
. reversed. The contents at the time of the snapshot are left over from loading.
S $F900,$100,$0100

s $FA00 Shift Tables
@ $FA00 label=ShiftTables
D $FA00 Six pages of tables that are built by #R$E0FB, which shift a byte by
. two, four and six pixels. For each shift there is a page for the low byte of
. the result and a page for the high byte. The contents at the time of the
. snapshot are left over from loading.
S $FA00,$600,$0600

