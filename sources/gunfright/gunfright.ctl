; Copyright Ashby Computers & Graphics Ltd 1985, Rare Ltd, 2026 ArcadeGeek LTD.
> $4000 @org=$4000
> $4000 @rom
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))

b $4000 Loading screen
@ $4000 label=Loading
D $4000 #UDGTABLE { =h Gunfright Loading Screen }
. { #SCR$02(loading) } UDGTABLE#
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00


c $5B80 Decrypt Game
@ $5B80 label=DecryptGame
D $5B80 The stub which the tape loader runs once the game has been loaded at
. #N$6000. It decrypts the whole game, #N$8000 bytes, two bytes at a time, and
. then moves the game down by #N$0200 bytes to its real home at #N$5E00 before
. starting it.
.
. The tape loader sets up this stub, and the game checks for the loader's
. signature in the frame counter (see #R$A36D).
E $5B80 View the equivalent code in;
. #LIST
. { #ATICATAC$5B80 }
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #LUNARJETMAN$5B80 }
. { #NIGHTSHADE$5B80 }
. { #PSSST$5B80 }
. { #TRANZAM$5B80 }
. LIST#
N $5B80 Set up the first pair and the number of pairs to decrypt.
  $5B80,$03 Set #REGde to #N$6000, the address of the first byte of the pair to
. decrypt.
  $5B83,$03 Set #REGhl to #N$6001, the address of the second byte of the pair.
  $5B86,$03 Set #REGbc to #N$4000, the number of byte pairs to decrypt.
N $5B89 Start rotating each byte through #REGa to decrypt it.
@ $5B89 label=DecryptGame_Loop
  $5B89,$01 Fetch the first byte of the pair.
  $5B8A,$02 Rotate the nibbles of the two bytes through #REGa.
  $5B8C,$01 Write the decrypted byte back.
  $5B8D,$02 Move on to the first byte of the next pair.
  $5B8F,$02 Move #REGhl onto the second byte of the next pair.
  $5B91,$01 Decrease the pair counter by one.
  $5B92,$04 Loop back to #R$5B89 until every pair has been decrypted.
N $5B96 Move the decrypted game down to its real address and start it.
  $5B96,$0B Copy #N$8000 bytes of the game from #N$6000 to #N$5E00.
  $5BA1,$03 Jump to #R$5E00 to start the game.

u $5BA4 Unused bytes

i $5BA8

c $5CB0 Indirect Jump
@ $5CB0 label=IndirectJump
D $5CB0 Jumps to the address held in #REGhl.
E $5CB0 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$5CB0 }
. { #NIGHTSHADE$5CB0 }
. { #PSSST$5CB0 }
. { #SABREWULF$5CB0 }
. { #TRANZAM$5CB0 }
. LIST#
R $5CB0 HL The address to jump to
  $5CB0,$01 Jump to the address held in #REGhl.

i $5CB1

c $5E00 Start Game
@ $5E00 label=GameStart
D $5E00 The first instruction of the game once it has been moved down into place
. by #R$5B80. Interrupts are disabled for the whole game, which polls the
. keyboard and times everything by the speed of its own code.
  $5E00,$01 Disable interrupts.
  $5E01,$03 Jump to #R$A36D to start the game.

b $5E04 Side Picture Tiles
@ $5E04 label=SidePictureTiles
D $5E04 The numbers of the tiles of the picture which is drawn on each side of
. the screen outside the town by #R$D327, in ten rows of four. A zero is a blank
. tile.
B $5E04,$28,$04

b $5E2C Tile Image Numbers
@ $5E2C label=TileImageNumbers
D $5E2C The number of an image for each number of a tile in the lists of tiles
. of the edges of the cells of the town, which are drawn by #R$C468. The image
. is found by exclusive-ORing the number with the swap flag, which turns each
. image into the other of its pair, and then looking it up in the table at
. #R$8A2E.
B $5E2C,$25,$08

b $5E51 Revolver Tiles
@ $5E51 label=RevolverTilesDisplay
D $5E51 The numbers of the tiles of the picture of the revolver which is drawn
. by #R$D565, in eight rows of eight. Bits 6 and 7 of a number say how the tile
. is reflected.
B $5E51,$40,$08

b $5E91 Panel Tiles
@ $5E91 label=PanelTiles
D $5E91 The attribute and the number of the tile for each of the tiles of the
. panel of the town, which is drawn by #R$D3A7, in eighteen rows of eight. Each
. row is eight pairs of bytes.
B $5E91,$0120,$10

b $5FB1 Town Map
@ $5FB1 label=TownMap
D $5FB1 The map of the town, as sixteen rows of sixteen cells. The code of each
. cell says what is in it. Zero is empty ground, one is the edge of the town,
. and the codes from two to #N$19 are buildings and other things. The codes
. choose the lists of walls at #R$6151 and the lists of tiles at #R$626C.
B $5FB1,$0100,$10

b $60B1 Drawing Orders
@ $60B1 label=DrawingOrders
D $60B1 The orders in which the cells around the sheriff are drawn by #R$C0F8,
. as thirty-two entries of five bytes. The entry is chosen by which of five of
. the cells next to the sheriff have anything in them. Each byte is the offset
. of a cell and the kind of drawing which is done in it.
B $60B1,$A0,$05

w $6151 Wall Rectangle Pointers
@ $6151 label=WallRectanglePointers
D $6151 The address of the list of rectangles of walls for each code of a cell,
. which is used by #R$CFA1 and #R$CFDE.
W $6151,$02 Cell code #N(#EVAL((#PC-$6151)/$02),$02,$10):
. #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100)
L $6151,$02,$1A

b $6185 Wall Rectangle Lists
@ $6185 label=WallRectangleLists
D $6185 The lists of rectangles of walls, which are used to stop objects from
. walking through the walls. Each rectangle is four bytes: the horizontal and
. vertical positions of its middle, then its half width and half height. A
. zero byte ends a list. The middle of a cell is #N$80, a full side has a half
. length of #N$40, and a thin wall has a half length of #N$02. A gap in a side
. is a doorway.
N $6185 The list for cell code #N$00.
B $6185,$01,$01 Terminator.
N $6186 The list for cell code #N$01.
@ $6186 label=WallRectangles_01
B $6186,$04 #WALLRECTS
L $6186,$04,$04
B $6196,$01,$01 Terminator.
N $6197 The list for cell codes #N$02, #N$03 and #N$13.
@ $6197 label=WallRectangles_02
B $6197,$04 #WALLRECTS
L $6197,$04,$06
B $61AF,$01,$01 Terminator.
N $61B0 The list for cell codes #N$04, #N$05, #N$14, #N$15 and #N$16.
@ $61B0 label=WallRectangles_03
B $61B0,$04 #WALLRECTS
L $61B0,$04,$08
B $61D0,$01,$01 Terminator.
N $61D1 The list for cell codes #N$06, #N$0D and #N$12.
@ $61D1 label=WallRectangles_04
B $61D1,$04 #WALLRECTS
L $61D1,$04,$06
B $61E9,$01,$01 Terminator.
N $61EA The list for cell codes #N$07, #N$0F and #N$17.
@ $61EA label=WallRectangles_05
B $61EA,$04 #WALLRECTS
L $61EA,$04,$05
B $61FE,$01,$01 Terminator.
N $61FF The list for cell codes #N$08 and #N$0E.
@ $61FF label=WallRectangles_06
B $61FF,$04 #WALLRECTS
L $61FF,$04,$05
B $6213,$01,$01 Terminator.
N $6214 The list for cell codes #N$09, #N$11 and #N$18.
@ $6214 label=WallRectangles_07
B $6214,$04 #WALLRECTS
L $6214,$04,$05
B $6228,$01,$01 Terminator.
N $6229 The list for cell codes #N$0A, #N$10 and #N$19.
@ $6229 label=WallRectangles_08
B $6229,$04 #WALLRECTS
L $6229,$04,$05
B $623D,$01,$01 Terminator.
N $623E The list for cell code #N$0C.
@ $623E label=WallRectangles_09
B $623E,$04 #WALLRECTS
L $623E,$04,$05
B $6252,$01,$01 Terminator.
N $6253 The list for cell code #N$0B.
@ $6253 label=WallRectangles_10
B $6253,$04 #WALLRECTS
L $6253,$04,$06
B $626B,$01,$01 Terminator.

w $626C Tile List Pointers
@ $626C label=TileListPointers
D $626C The addresses of the lists of tiles for each code of a cell, two for
. each. The first is drawn for the lower edge of a building, and the second for
. the upper edge. Codes which have no building have no list. These are used by
. #R$C392 and #R$C54B.
W $626C,$68,$02

b $62D4 Tile Lists
@ $62D4 label=TileLists
D $62D4 The lists of tiles, which are used to draw the edges and the walls of
. the cells of the town. Each list is sixteen pairs of bytes, which are drawn in
. two runs of eight.
B $62D4,$20,$10
@ $62F4 label=TileList_01
B $62F4,$20,$10
@ $6314 label=TileList_02
B $6314,$20,$10
@ $6334 label=TileList_03
B $6334,$20,$10
@ $6354 label=TileList_04
B $6354,$20,$10
@ $6374 label=TileList_05
B $6374,$20,$10
@ $6394 label=TileList_06
B $6394,$20,$10
@ $63B4 label=TileList_07
B $63B4,$20,$10
@ $63D4 label=TileList_08
B $63D4,$20,$10
@ $63F4 label=TileList_09
B $63F4,$20,$10
@ $6414 label=TileList_10
B $6414,$20,$10
@ $6434 label=TileList_11
B $6434,$20,$10
@ $6454 label=TileList_12
B $6454,$20,$10
@ $6474 label=TileList_13
B $6474,$20,$10
@ $6494 label=TileList_14
B $6494,$20,$10
@ $64B4 label=TileList_15
B $64B4,$20,$10
@ $64D4 label=TileList_16
B $64D4,$20,$10
@ $64F4 label=TileList_17
B $64F4,$20,$10
@ $6514 label=TileList_18
B $6514,$20,$10
@ $6534 label=TileList_19
B $6534,$20,$10
@ $6554 label=TileList_20
B $6554,$20,$10
@ $6574 label=TileList_21
B $6574,$20,$10
@ $6594 label=TileList_22
B $6594,$20,$10
@ $65B4 label=TileList_23
B $65B4,$20,$10
@ $65D4 label=TileList_24
B $65D4,$20,$10
@ $65F4 label=TileList_25
B $65F4,$20,$10
@ $6614 label=TileList_26
B $6614,$20,$10
@ $6634 label=TileList_27
B $6634,$20,$10
@ $6654 label=TileList_28
B $6654,$20,$10
@ $6674 label=TileList_29
B $6674,$20,$10
@ $6694 label=TileList_30
B $6694,$20,$10
@ $66B4 label=TileList_31
B $66B4,$20,$10
@ $66D4 label=TileList_32
B $66D4,$20,$10
@ $66F4 label=TileList_33
B $66F4,$20,$10
@ $6714 label=TileList_34
B $6714,$20,$10
@ $6734 label=TileList_35
B $6734,$20,$10
@ $6754 label=TileList_36
B $6754,$20,$10
@ $6774 label=TileList_37
B $6774,$20,$10
@ $6794 label=TileList_38
B $6794,$20,$10
@ $67B4 label=TileList_39
B $67B4,$20,$10
@ $67D4 label=TileList_40
B $67D4,$20,$10

w $67F4 Sprite Pointers
@ $67F4 label=SpritePointers
D $67F4 The address of the data of each of the fifty-six sprites. The sprite
. number in a sprite list is the number of an entry in this table.
W $67F4,$70,$02

w $6864 Menu Sprite Pointers
@ $6864 label=MenuSpritePointers
D $6864 The addresses of the images for the states of the entries of the menu on
. the title screen, which are drawn by #R$AE10. The first two states have
. nothing to draw.
W $6864,$0A,$02

w $686E Scenery Sprite Pointers
@ $686E label=ScenerySpritePointers
D $686E The addresses of the images of the scenery which is drawn by #R$AB18,
. one of which is a blank image.
W $686E,$04,$02

b $6872 Scenery Image
@ $6872 label=SceneryImage
D $6872 The image of the scenery. It is sixteen pixels wide, and is a count of
. rows and then two bytes for each row, with the bottom row first. This one has
. 13 rows.
B $6872,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $6873,$1A,$02 #STRIPDATA(scenery-image*)

b $688D Menu Image 2
@ $688D label=MenuImage_2
D $688D The image for state #N$02 of an entry of the menu. It is sixteen pixels
. wide, and is a count of rows and then two bytes for each row, with the bottom
. row first. This one has 16 rows.
B $688D,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $688E,$20,$02 #STRIPDATA(menu-image-2*)

b $68AE Menu Image 3
@ $68AE label=MenuImage_3
D $68AE The image for state #N$03 of an entry of the menu. It is sixteen pixels
. wide, and is a count of rows and then two bytes for each row, with the bottom
. row first. This one has 13 rows.
B $68AE,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $68AF,$1A,$02 #STRIPDATA(menu-image-3*)

b $68C9 Bullet Image
@ $68C9 label=BulletImage
D $68C9 The image of a bullet, which is drawn for state #N$04 of an entry of the
. menu. It is sixteen pixels wide, and is a count of rows and then two bytes for
. each row, with the bottom row first. This one has 16 rows.
B $68C9,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $68CA,$20,$02 #STRIPDATA(bullet-image*)

b $68EA Blank Sprite
@ $68EA label=BlankSprite
D $68EA A sprite which has no columns and no rows, so nothing is drawn. It is
. used for the sprite numbers #N$00, #N$0C, #N$0D, #N$32, #N$33.
B $68EA,$02,$02 The number of columns and the number of rows.

b $68EC Sprite: Horse Head
@ $68EC label=Sprite_HorseHead
D $68EC This is the head of a horse which is standing (see #R$A9A8). It is
. sprite #N$37, 2 characters (16 pixels) wide and 20 rows high.
B $68EC,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $68ED,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $68EE,$50,$04 #SPRITEDATA(horse-head*)

b $693E Sprite: Horse Body
@ $693E label=Sprite_HorseBody
D $693E This is the body of a horse which is standing (see #R$A9A8). It is
. sprite #N$36, 3 characters (24 pixels) wide and 22 rows high.
B $693E,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $693F,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $6940,$84,$06 #SPRITEDATA(horse-body*)

b $69C4 Sprite: Bullet Hole
@ $69C4 label=Sprite_BulletHole
D $69C4 This is the bullet hole which is left in the screen after the outlaw in
. the duel has fired (see #R$B990). It is sprite #N$0B, 4 characters (32 pixels)
. wide and 32 rows high.
B $69C4,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $69C5,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $69C6,$100,$08 #SPRITEDATA(bullet-hole*)

w $6AC6 Poster Image Pointers
@ $6AC6 label=PosterImagePointers
D $6AC6 The address of each of the forty-one images of the pieces of the faces
. on the wanted posters, which are drawn by #R$D400.
W $6AC6,$52,$02

b $6B18 Poster Images
@ $6B18 label=PosterImages
D $6B18 The forty-one images of the pieces of the faces on the wanted posters.
. Each is thirty-two by eight pixels, as four bytes for each of eight lines,
. with the bottom line first.
B $6B18,$20,$04 #POSTERDATA(poster-image-00*)
@ $6B38 label=PosterImage_01
B $6B38,$20,$04 #POSTERDATA(poster-image-01*)
@ $6B58 label=PosterImage_02
B $6B58,$20,$04 #POSTERDATA(poster-image-02*)
@ $6B78 label=PosterImage_03
B $6B78,$20,$04 #POSTERDATA(poster-image-03*)
@ $6B98 label=PosterImage_04
B $6B98,$20,$04 #POSTERDATA(poster-image-04*)
@ $6BB8 label=PosterImage_05
B $6BB8,$20,$04 #POSTERDATA(poster-image-05*)
@ $6BD8 label=PosterImage_06
B $6BD8,$20,$04 #POSTERDATA(poster-image-06*)
@ $6BF8 label=PosterImage_07
B $6BF8,$20,$04 #POSTERDATA(poster-image-07*)
@ $6C18 label=PosterImage_08
B $6C18,$20,$04 #POSTERDATA(poster-image-08*)
@ $6C38 label=PosterImage_09
B $6C38,$20,$04 #POSTERDATA(poster-image-09*)
@ $6C58 label=PosterImage_0A
B $6C58,$20,$04 #POSTERDATA(poster-image-0a*)
@ $6C78 label=PosterImage_0B
B $6C78,$20,$04 #POSTERDATA(poster-image-0b*)
@ $6C98 label=PosterImage_0C
B $6C98,$20,$04 #POSTERDATA(poster-image-0c*)
@ $6CB8 label=PosterImage_0D
B $6CB8,$20,$04 #POSTERDATA(poster-image-0d*)
@ $6CD8 label=PosterImage_0E
B $6CD8,$20,$04 #POSTERDATA(poster-image-0e*)
@ $6CF8 label=PosterImage_0F
B $6CF8,$20,$04 #POSTERDATA(poster-image-0f*)
@ $6D18 label=PosterImage_10
B $6D18,$20,$04 #POSTERDATA(poster-image-10*)
@ $6D38 label=PosterImage_11
B $6D38,$20,$04 #POSTERDATA(poster-image-11*)
@ $6D58 label=PosterImage_12
B $6D58,$20,$04 #POSTERDATA(poster-image-12*)
@ $6D78 label=PosterImage_13
B $6D78,$20,$04 #POSTERDATA(poster-image-13*)
@ $6D98 label=PosterImage_14
B $6D98,$20,$04 #POSTERDATA(poster-image-14*)
@ $6DB8 label=PosterImage_15
B $6DB8,$20,$04 #POSTERDATA(poster-image-15*)
@ $6DD8 label=PosterImage_16
B $6DD8,$20,$04 #POSTERDATA(poster-image-16*)
@ $6DF8 label=PosterImage_17
B $6DF8,$20,$04 #POSTERDATA(poster-image-17*)
@ $6E18 label=PosterImage_18
B $6E18,$20,$04 #POSTERDATA(poster-image-18*)
@ $6E38 label=PosterImage_19
B $6E38,$20,$04 #POSTERDATA(poster-image-19*)
@ $6E58 label=PosterImage_1A
B $6E58,$20,$04 #POSTERDATA(poster-image-1a*)
@ $6E78 label=PosterImage_1B
B $6E78,$20,$04 #POSTERDATA(poster-image-1b*)
@ $6E98 label=PosterImage_1C
B $6E98,$20,$04 #POSTERDATA(poster-image-1c*)
@ $6EB8 label=PosterImage_1D
B $6EB8,$20,$04 #POSTERDATA(poster-image-1d*)
@ $6ED8 label=PosterImage_1E
B $6ED8,$20,$04 #POSTERDATA(poster-image-1e*)
@ $6EF8 label=PosterImage_1F
B $6EF8,$20,$04 #POSTERDATA(poster-image-1f*)
@ $6F18 label=PosterImage_20
B $6F18,$20,$04 #POSTERDATA(poster-image-20*)
@ $6F38 label=PosterImage_21
B $6F38,$20,$04 #POSTERDATA(poster-image-21*)
@ $6F58 label=PosterImage_22
B $6F58,$20,$04 #POSTERDATA(poster-image-22*)
@ $6F78 label=PosterImage_23
B $6F78,$20,$04 #POSTERDATA(poster-image-23*)
@ $6F98 label=PosterImage_24
B $6F98,$20,$04 #POSTERDATA(poster-image-24*)
@ $6FB8 label=PosterImage_25
B $6FB8,$20,$04 #POSTERDATA(poster-image-25*)
@ $6FD8 label=PosterImage_26
B $6FD8,$20,$04 #POSTERDATA(poster-image-26*)
@ $6FF8 label=PosterImage_27
B $6FF8,$20,$04 #POSTERDATA(poster-image-27*)
@ $7018 label=PosterImage_28
B $7018,$20,$04 #POSTERDATA(poster-image-28*)

b $7038 Sprite: Pointer 1
@ $7038 label=Sprite_Pointer_1
D $7038 This is the first of the two frames of the pointer which shows the
. sheriff the way to the outlaw (see #R$B347). It is sprite #N$30, 3 characters
. (24 pixels) wide and 26 rows high.
B $7038,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7039,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $703A,$9C,$06 #SPRITEDATA(pointer-1*)

b $70D6 Sprite: Pointer 2
@ $70D6 label=Sprite_Pointer_2
D $70D6 This is the second of the two frames of the pointer which shows the
. sheriff the way to the outlaw (see #R$B347). It is sprite #N$31, 3 characters
. (24 pixels) wide and 28 rows high.
B $70D6,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $70D7,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $70D8,$A8,$06 #SPRITEDATA(pointer-2*)

b $7180 Sprite: Man 4
@ $7180 label=Sprite_Man_4
D $7180 This is a figure of a man, used for a shot outlaw (see #R$BBC8). It is
. sprite #N$27, 3 characters (24 pixels) wide and 31 rows high.
B $7180,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7181,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7182,$BA,$06 #SPRITEDATA(man-4*)

b $723C Sprite: Money Bag
@ $723C label=Sprite_MoneyBag
D $723C This is a money bag (see #R$C847). It is sprite #N$29, 3 characters (24
. pixels) wide and 25 rows high.
B $723C,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $723D,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $723E,$96,$06 #SPRITEDATA(money-bag*)

b $72D4 Sprite: Cactus
@ $72D4 label=Sprite_Cactus
D $72D4 This is a cactus (see #R$AA62). It is sprite #N$2A, 3 characters (24
. pixels) wide and 35 rows high.
B $72D4,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $72D5,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $72D6,$D2,$06 #SPRITEDATA(cactus*)

b $73A8 Sprite: Tumbleweed
@ $73A8 label=Sprite_Tumbleweed
D $73A8 This is a tumbleweed (see #R$A8C1). It is sprite #N$2B, 3 characters (24
. pixels) wide and 24 rows high.
B $73A8,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $73A9,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $73AA,$90,$06 #SPRITEDATA(tumbleweed*)

b $743A Sprite: Bystander 2
@ $743A label=Sprite_Bystander_2
D $743A This is a bystander, which is the second of the two frames of a
. bystander (see #R$B7A0). It is sprite #N$2E, 3 characters (24 pixels) wide and
. 31 rows high.
B $743A,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $743B,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $743C,$BA,$06 #SPRITEDATA(bystander-2*)

b $74F6 Sprite: Bystander 1
@ $74F6 label=Sprite_Bystander_1
D $74F6 This is a bystander, which is the first of the two frames of a bystander
. (see #R$B79C). It is sprite #N$2D, 3 characters (24 pixels) wide and 31 rows
. high.
B $74F6,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $74F7,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $74F8,$BA,$06 #SPRITEDATA(bystander-1*)

b $75B2 Sprite: Horse Galloping 1
@ $75B2 label=Sprite_HorseGalloping_1
D $75B2 This is the first of the two frames of the horse which the sheriff rides
. (see #R$CB29). It is sprite #N$34, 5 characters (40 pixels) wide and 31 rows
. high.
B $75B2,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $75B3,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $75B4,$136,$0A #SPRITEDATA(horse-galloping-1*)

b $76EA Sprite: Falling Figure
@ $76EA label=Sprite_FallingFigure
D $76EA This is a figure which is lying on its back. The use of this sprite is
. not yet known. It is sprite #N$2F, 5 characters (40 pixels) wide and 33 rows
. high.
B $76EA,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $76EB,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $76EC,$14A,$0A #SPRITEDATA(falling-figure*)

b $7836 Sprite: Bullet
@ $7836 label=Sprite_Bullet
D $7836 This is a bullet in flight (see #R$CAC2). It is sprite #N$28, 1
. characters (8 pixels) wide and 6 rows high.
B $7836,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7837,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7838,$0C,$02 #SPRITEDATA(bullet*)

b $7844 Sprite: Crosshair
@ $7844 label=Sprite_Crosshair
D $7844 This is the crosshair which the player moves about the screen (see
. #R$BCA2). It is sprite #N$2C, 3 characters (24 pixels) wide and 23 rows high.
B $7844,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7845,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7846,$8A,$06 #SPRITEDATA(crosshair*)

b $78D0 Sprite: Horse Galloping 2
@ $78D0 label=Sprite_HorseGalloping_2
D $78D0 This is the second of the two frames of the horse which the sheriff
. rides (see #R$CB29). It is sprite #N$35, 5 characters (40 pixels) wide and 23
. rows high.
B $78D0,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $78D1,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $78D2,$E6,$0A #SPRITEDATA(horse-galloping-2*)

b $79B8 Sprite: Outlaw Gun Arm 1
@ $79B8 label=Sprite_OutlawGunArm_1
D $79B8 This is a frame of the arm and gun of the outlaw in the duel, which are
. drawn by #R$B8E7 as he draws his gun. It is sprite #N$01, 3 characters (24
. pixels) wide and 30 rows high.
B $79B8,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $79B9,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $79BA,$B4,$06 #SPRITEDATA(outlaw-gun-arm-1*)

b $7A6E Sprite: Outlaw Gun Arm 2
@ $7A6E label=Sprite_OutlawGunArm_2
D $7A6E This is a frame of the arm and gun of the outlaw in the duel, which are
. drawn by #R$B8E7 as he draws his gun. It is sprite #N$02, 3 characters (24
. pixels) wide and 30 rows high.
B $7A6E,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7A6F,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7A70,$B4,$06 #SPRITEDATA(outlaw-gun-arm-2*)

b $7B24 Sprite: Outlaw Gun Arm 3
@ $7B24 label=Sprite_OutlawGunArm_3
D $7B24 This is a frame of the arm and gun of the outlaw in the duel, which are
. drawn by #R$B8E7 as he draws his gun. It is sprite #N$03, 3 characters (24
. pixels) wide and 30 rows high.
B $7B24,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7B25,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7B26,$B4,$06 #SPRITEDATA(outlaw-gun-arm-3*)

b $7BDA Sprite: Outlaw Gun Arm 4
@ $7BDA label=Sprite_OutlawGunArm_4
D $7BDA This is a frame of the arm and gun of the outlaw in the duel, which are
. drawn by #R$B8E7 as he draws his gun. It is sprite #N$04, 3 characters (24
. pixels) wide and 30 rows high.
B $7BDA,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7BDB,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7BDC,$B4,$06 #SPRITEDATA(outlaw-gun-arm-4*)

b $7C90 Sprite: Outlaw Gun Arm 5
@ $7C90 label=Sprite_OutlawGunArm_5
D $7C90 This is a frame of the arm and gun of the outlaw in the duel, which are
. drawn by #R$B8E7 as he draws his gun. It is sprite #N$05, 3 characters (24
. pixels) wide and 32 rows high.
B $7C90,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7C91,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7C92,$C0,$06 #SPRITEDATA(outlaw-gun-arm-5*)

b $7D52 Sprite: Outlaw Gun Arm 6
@ $7D52 label=Sprite_OutlawGunArm_6
D $7D52 This is a frame of the arm and gun of the outlaw in the duel, which are
. drawn by #R$B8E7 as he draws his gun. It is sprite #N$06, 3 characters (24
. pixels) wide and 30 rows high.
B $7D52,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7D53,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7D54,$B4,$06 #SPRITEDATA(outlaw-gun-arm-6*)

b $7E08 Sprite: Flash 1
@ $7E08 label=Sprite_Flash_1
D $7E08 This is a frame of the flash of a gun, which grows over four frames. The
. outlaw in the duel uses all four for his muzzle flash (see #R$B972), and the
. flash of the sheriff's gun uses the last one (see #R$CA30). The first and
. third are also the two frames of the puff of smoke (see #R$C795). It is sprite
. #N$07, 2 characters (16 pixels) wide and 16 rows high.
B $7E08,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7E09,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7E0A,$40,$04 #SPRITEDATA(flash-1*)

b $7E4A Sprite: Flash 2
@ $7E4A label=Sprite_Flash_2
D $7E4A This is a frame of the flash of a gun, which grows over four frames. The
. outlaw in the duel uses all four for his muzzle flash (see #R$B972), and the
. flash of the sheriff's gun uses the last one (see #R$CA30). It is sprite
. #N$08, 2 characters (16 pixels) wide and 16 rows high.
B $7E4A,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7E4B,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7E4C,$40,$04 #SPRITEDATA(flash-2*)

b $7E8C Sprite: Flash 3
@ $7E8C label=Sprite_Flash_3
D $7E8C This is a frame of the flash of a gun, which grows over four frames. The
. outlaw in the duel uses all four for his muzzle flash (see #R$B972), and the
. flash of the sheriff's gun uses the last one (see #R$CA30). The first and
. third are also the two frames of the puff of smoke (see #R$C795). It is sprite
. #N$09, 2 characters (16 pixels) wide and 16 rows high.
B $7E8C,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7E8D,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7E8E,$40,$04 #SPRITEDATA(flash-3*)

b $7ECE Sprite: Flash 4
@ $7ECE label=Sprite_Flash_4
D $7ECE This is a frame of the flash of a gun, which grows over four frames. The
. outlaw in the duel uses all four for his muzzle flash (see #R$B972), and the
. flash of the sheriff's gun uses the last one (see #R$CA30). It is sprite
. #N$0A, 2 characters (16 pixels) wide and 16 rows high.
B $7ECE,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7ECF,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7ED0,$40,$04 #SPRITEDATA(flash-4*)

b $7F10 Sprite: Head 1
@ $7F10 label=Sprite_Head_1
D $7F10 This is one of the two heads of the sheriff for the two halves of his
. walk (see #R$CB29). It is sprite #N$0E, 3 characters (24 pixels) wide and 16
. rows high.
B $7F10,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7F11,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7F12,$60,$06 #SPRITEDATA(head-1*)

b $7F72 Sprite: Head 2
@ $7F72 label=Sprite_Head_2
D $7F72 This is one of the two heads of the sheriff for the two halves of his
. walk (see #R$CB29). It is sprite #N$0F, 3 characters (24 pixels) wide and 17
. rows high.
B $7F72,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7F73,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7F74,$66,$06 #SPRITEDATA(head-2*)

b $7FDA Sprite: Head 4
@ $7FDA label=Sprite_Head_4
D $7FDA This is one of the two heads for the two halves of the walk of an
. outlaw, which depend on the level (see #R$B3DA). It is sprite #N$11, 3
. characters (24 pixels) wide and 17 rows high.
B $7FDA,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $7FDB,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $7FDC,$66,$06 #SPRITEDATA(head-4*)

b $8042 Sprite: Head 3
@ $8042 label=Sprite_Head_3
D $8042 This is one of the two heads for the two halves of the walk of an
. outlaw, which depend on the level (see #R$B3DA). It is also the head which is
. left behind by a dead figure (see #R$B782). It is sprite #N$10, 3 characters
. (24 pixels) wide and 16 rows high.
B $8042,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $8043,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8044,$60,$06 #SPRITEDATA(head-3*)

b $80A4 Sprite: Head 6
@ $80A4 label=Sprite_Head_6
D $80A4 This is one of the two heads for the two halves of the walk of an
. outlaw, which depend on the level (see #R$B3DA). It is sprite #N$13, 3
. characters (24 pixels) wide and 19 rows high.
B $80A4,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $80A5,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $80A6,$72,$06 #SPRITEDATA(head-6*)

b $8118 Sprite: Head 5
@ $8118 label=Sprite_Head_5
D $8118 This is one of the two heads for the two halves of the walk of an
. outlaw, which depend on the level (see #R$B3DA). It is sprite #N$12, 3
. characters (24 pixels) wide and 16 rows high.
B $8118,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $8119,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $811A,$60,$06 #SPRITEDATA(head-5*)

b $817A Sprite: Head 8
@ $817A label=Sprite_Head_8
D $817A This is one of the two heads for the two halves of the walk of an
. outlaw, which depend on the level (see #R$B3DA). It is sprite #N$15, 3
. characters (24 pixels) wide and 21 rows high.
B $817A,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $817B,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $817C,$7E,$06 #SPRITEDATA(head-8*)

b $81FA Sprite: Head 7
@ $81FA label=Sprite_Head_7
D $81FA This is one of the two heads for the two halves of the walk of an
. outlaw, which depend on the level (see #R$B3DA). It is sprite #N$14, 3
. characters (24 pixels) wide and 18 rows high.
B $81FA,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $81FB,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $81FC,$6C,$06 #SPRITEDATA(head-7*)

b $8268 Sprite: Firing Torso 1
@ $8268 label=Sprite_FiringTorso_1
D $8268 This is the middle part of the sheriff when he is firing, one of the two
. used for the two halves of his walk (see #R$CAEA). It is sprite #N$16, 3
. characters (24 pixels) wide and 20 rows high.
B $8268,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $8269,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $826A,$78,$06 #SPRITEDATA(firing-torso-1*)

b $82E2 Sprite: Torso 1
@ $82E2 label=Sprite_Torso_1
D $82E2 This is the middle part of a walking figure for one of the four steps
. (see #R$C967). It is sprite #N$17, 3 characters (24 pixels) wide and 17 rows
. high.
B $82E2,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $82E3,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $82E4,$66,$06 #SPRITEDATA(torso-1*)

b $834A Sprite: Torso 2
@ $834A label=Sprite_Torso_2
D $834A This is the middle part of a walking figure for one of the four steps
. (see #R$C967). It is sprite #N$18, 3 characters (24 pixels) wide and 17 rows
. high.
B $834A,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $834B,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $834C,$66,$06 #SPRITEDATA(torso-2*)

b $83B2 Sprite: Torso 3
@ $83B2 label=Sprite_Torso_3
D $83B2 This is the middle part of a walking figure for one of the four steps
. (see #R$C967). It is sprite #N$19, 3 characters (24 pixels) wide and 17 rows
. high.
B $83B2,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $83B3,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $83B4,$66,$06 #SPRITEDATA(torso-3*)

b $841A Sprite: Torso 4
@ $841A label=Sprite_Torso_4
D $841A This is the middle part of a walking figure for one of the four steps
. (see #R$C967). It is sprite #N$1A, 3 characters (24 pixels) wide and 17 rows
. high.
B $841A,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $841B,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $841C,$66,$06 #SPRITEDATA(torso-4*)

b $8482 Sprite: Firing Torso 2
@ $8482 label=Sprite_FiringTorso_2
D $8482 This is the middle part of the sheriff when he is firing, one of the two
. used for the two halves of his walk (see #R$CAEA). It is sprite #N$1B, 3
. characters (24 pixels) wide and 17 rows high.
B $8482,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $8483,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8484,$66,$06 #SPRITEDATA(firing-torso-2*)

b $84EA Sprite: Legs 1
@ $84EA label=Sprite_Legs_1
D $84EA This is the lower part of a walking figure for one of the eight frames
. (see #R$C967). It is sprite #N$1C, 3 characters (24 pixels) wide and 15 rows
. high.
B $84EA,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $84EB,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $84EC,$5A,$06 #SPRITEDATA(legs-1*)

b $8546 Sprite: Legs 2
@ $8546 label=Sprite_Legs_2
D $8546 This is the lower part of a walking figure for one of the eight frames
. (see #R$C967). It is sprite #N$1D, 3 characters (24 pixels) wide and 15 rows
. high.
B $8546,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $8547,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8548,$5A,$06 #SPRITEDATA(legs-2*)

b $85A2 Sprite: Legs 3
@ $85A2 label=Sprite_Legs_3
D $85A2 This is the lower part of a walking figure for one of the eight frames
. (see #R$C967). It is sprite #N$1E, 3 characters (24 pixels) wide and 15 rows
. high.
B $85A2,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $85A3,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $85A4,$5A,$06 #SPRITEDATA(legs-3*)

b $85FE Sprite: Legs 4
@ $85FE label=Sprite_Legs_4
D $85FE This is the lower part of a walking figure for one of the eight frames
. (see #R$C967). It is sprite #N$1F, 3 characters (24 pixels) wide and 15 rows
. high.
B $85FE,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $85FF,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8600,$5A,$06 #SPRITEDATA(legs-4*)

b $865A Sprite: Legs 5
@ $865A label=Sprite_Legs_5
D $865A This is the lower part of a walking figure for one of the eight frames
. (see #R$C967). It is sprite #N$20, 3 characters (24 pixels) wide and 18 rows
. high.
B $865A,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $865B,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $865C,$6C,$06 #SPRITEDATA(legs-5*)

b $86C8 Sprite: Legs 6
@ $86C8 label=Sprite_Legs_6
D $86C8 This is the lower part of a walking figure for one of the eight frames
. (see #R$C967). It is sprite #N$21, 3 characters (24 pixels) wide and 18 rows
. high.
B $86C8,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $86C9,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $86CA,$6C,$06 #SPRITEDATA(legs-6*)

b $8736 Sprite: Legs 7
@ $8736 label=Sprite_Legs_7
D $8736 This is the lower part of a walking figure for one of the eight frames
. (see #R$C967). It is sprite #N$22, 3 characters (24 pixels) wide and 18 rows
. high.
B $8736,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $8737,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8738,$6C,$06 #SPRITEDATA(legs-7*)

b $87A4 Sprite: Legs 8
@ $87A4 label=Sprite_Legs_8
D $87A4 This is the lower part of a walking figure for one of the eight frames
. (see #R$C967). It is sprite #N$23, 3 characters (24 pixels) wide and 16 rows
. high.
B $87A4,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $87A5,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $87A6,$60,$06 #SPRITEDATA(legs-8*)

b $8806 Sprite: Man 1
@ $8806 label=Sprite_Man_1
D $8806 This is a figure of a man, used for a dying outlaw (see #R$BBC5). It is
. sprite #N$24, 3 characters (24 pixels) wide and 30 rows high.
B $8806,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $8807,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8808,$B4,$06 #SPRITEDATA(man-1*)

b $88BC Sprite: Man 2
@ $88BC label=Sprite_Man_2
D $88BC This is a figure of a man, used for a dying outlaw (see #R$BBC5). It is
. sprite #N$25, 3 characters (24 pixels) wide and 30 rows high.
B $88BC,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $88BD,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $88BE,$B4,$06 #SPRITEDATA(man-2*)

b $8972 Sprite: Man 3
@ $8972 label=Sprite_Man_3
D $8972 This is a figure of a man, used for a dying outlaw (see #R$BBC5). It is
. sprite #N$26, 3 characters (24 pixels) wide and 31 rows high.
B $8972,$01,$01 Width = #N(#PEEK(#PC)) characters.
B $8973,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8974,$BA,$06 #SPRITEDATA(man-3*)

w $8A2E Edge Image Pointers
@ $8A2E label=EdgeImagePointers
D $8A2E The addresses of the images of the edges of the cells of the town, in
. pairs, for the numbers which are made from #R$5E2C. They are drawn by #R$C4A7.
W $8A2E,$0C,$02

b $8A3A Edge Image 0
@ $8A3A label=EdgeImage_0
D $8A3A An image which is sixteen pixels wide, as a count of rows and then two
. bytes for each row, with the bottom row first. This one has 10 rows.
B $8A3A,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8A3B,$14,$02 #STRIPDATA(edge-image-0*)

b $8A4F Edge Image 2
@ $8A4F label=EdgeImage_2
D $8A4F An image which is sixteen pixels wide, as a count of rows and then two
. bytes for each row, with the bottom row first. This one has 10 rows.
B $8A4F,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8A50,$14,$02 #STRIPDATA(edge-image-2*)

b $8A64 Edge Image 3
@ $8A64 label=EdgeImage_3
D $8A64 An image which is sixteen pixels wide, as a count of rows and then two
. bytes for each row, with the bottom row first. This one has 4 rows.
B $8A64,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8A65,$08,$02 #STRIPDATA(edge-image-3*)

b $8A6D Edge Image 4
@ $8A6D label=EdgeImage_4
D $8A6D An image which is sixteen pixels wide, as a count of rows and then two
. bytes for each row, with the bottom row first. This one has 1 row.
B $8A6D,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $8A6E,$02,$02 #STRIPDATA(edge-image-4*)

b $8A70 Title Tiles
@ $8A70 label=TitleTiles
D $8A70 The tiles which are used on the title screen, each of eight bytes. The
. first tile is blank.
. #UDGTABLE { #TILES$8A70,$1B,$09,$47(title-tiles*) } UDGTABLE#
B $8A70,$D8,$08

b $8B48 Panel Tiles Set
@ $8B48 label=PanelTileSet
D $8B48 The tiles of the panel of the town, each of eight bytes.
. #UDGTABLE { #TILES$8B48,$36,$1B,$47(panel-tiles*) } UDGTABLE#
B $8B48,$01A8,$08

b $8CF0 Screen Tile Set
@ $8CF0 label=ScreenTileSet
D $8CF0 The tiles which are used for the border, the revolver, the telegram, the
. lives and the bounty, each of eight bytes.
. #UDGTABLE { #TILES$8CF0,$37,$0B,$47(screen-tiles*) } UDGTABLE#
B $8CF0,$01B8,$08

b $8EA8 Font
@ $8EA8 label=Font
D $8EA8 The tiles of the font, each of eight bytes. The first is the space, the
. next ten are the digits and the letters begin at the twelfth. The rest are
. punctuation.
. #UDGTABLE { #TILES$8EA8,$2A,$0E,$47(font-tiles*) } UDGTABLE#
B $8EA8,$08,$08 #UDG(#PC)
N $8EB0 The digits begin here.
@ $8EB0 label=Font_Digits
L $8EA8,$08,$2A

w $8FF8 Wall Image Pointers
@ $8FF8 label=WallImagePointers
D $8FF8 The address of the image for each of the thirty-seven numbers of tiles
. of the walls of buildings, which are drawn by #R$C5F9.
W $8FF8,$4A,$02

b $9042 Wall Images
@ $9042 label=WallImages
D $9042 The images of the tiles of the walls of buildings. Each image is a count
. of rows, and then two bytes for each row, from the bottom row to the top,
. which are sixteen pixels wide. The bytes are the indexes into the tables which
. are made by #R$D4FD.
B $9042,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9043,$80,$02 #STRIPDATA(wall-image-00*)
@ $90C3 label=WallImage_01
B $90C3,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $90C4,$80,$02 #STRIPDATA(wall-image-01*)
@ $9144 label=WallImage_02
B $9144,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9145,$80,$02 #STRIPDATA(wall-image-02*)
@ $91C5 label=WallImage_03
B $91C5,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $91C6,$80,$02 #STRIPDATA(wall-image-03*)
@ $9246 label=WallImage_04
B $9246,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9247,$80,$02 #STRIPDATA(wall-image-04*)
@ $92C7 label=WallImage_05
B $92C7,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $92C8,$80,$02 #STRIPDATA(wall-image-05*)
@ $9348 label=WallImage_06
B $9348,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9349,$80,$02 #STRIPDATA(wall-image-06*)
@ $93C9 label=WallImage_07
B $93C9,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $93CA,$80,$02 #STRIPDATA(wall-image-07*)
@ $944A label=WallImage_08
B $944A,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $944B,$80,$02 #STRIPDATA(wall-image-08*)
@ $94CB label=WallImage_09
B $94CB,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $94CC,$70,$02 #STRIPDATA(wall-image-09*)
@ $953C label=WallImage_0A
B $953C,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $953D,$70,$02 #STRIPDATA(wall-image-0a*)
@ $95AD label=WallImage_0B
B $95AD,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $95AE,$70,$02 #STRIPDATA(wall-image-0b*)
@ $961E label=WallImage_0C
B $961E,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $961F,$70,$02 #STRIPDATA(wall-image-0c*)
@ $968F label=WallImage_0D
B $968F,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9690,$70,$02 #STRIPDATA(wall-image-0d*)
@ $9700 label=WallImage_0E
B $9700,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9701,$80,$02 #STRIPDATA(wall-image-0e*)
@ $9781 label=WallImage_0F
B $9781,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9782,$80,$02 #STRIPDATA(wall-image-0f*)
@ $9802 label=WallImage_10
B $9802,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9803,$80,$02 #STRIPDATA(wall-image-10*)
@ $9883 label=WallImage_11
B $9883,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9884,$80,$02 #STRIPDATA(wall-image-11*)
@ $9904 label=WallImage_12
B $9904,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9905,$70,$02 #STRIPDATA(wall-image-12*)
@ $9975 label=WallImage_13
B $9975,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9976,$70,$02 #STRIPDATA(wall-image-13*)
@ $99E6 label=WallImage_14
B $99E6,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $99E7,$70,$02 #STRIPDATA(wall-image-14*)
@ $9A57 label=WallImage_15
B $9A57,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9A58,$80,$02 #STRIPDATA(wall-image-15*)
@ $9AD8 label=WallImage_16
B $9AD8,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9AD9,$80,$02 #STRIPDATA(wall-image-16*)
@ $9B59 label=WallImage_17
B $9B59,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9B5A,$80,$02 #STRIPDATA(wall-image-17*)
@ $9BDA label=WallImage_18
B $9BDA,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9BDB,$80,$02 #STRIPDATA(wall-image-18*)
@ $9C5B label=WallImage_19
B $9C5B,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9C5C,$70,$02 #STRIPDATA(wall-image-19*)
@ $9CCC label=WallImage_1A
B $9CCC,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9CCD,$70,$02 #STRIPDATA(wall-image-1a*)
@ $9D3D label=WallImage_1B
B $9D3D,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9D3E,$70,$02 #STRIPDATA(wall-image-1b*)
@ $9DAE label=WallImage_1C
B $9DAE,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9DAF,$70,$02 #STRIPDATA(wall-image-1c*)
@ $9E1F label=WallImage_1D
B $9E1F,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9E20,$80,$02 #STRIPDATA(wall-image-1d*)
@ $9EA0 label=WallImage_1E
B $9EA0,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9EA1,$80,$02 #STRIPDATA(wall-image-1e*)
@ $9F21 label=WallImage_1F
B $9F21,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9F22,$70,$02 #STRIPDATA(wall-image-1f*)
@ $9F92 label=WallImage_20
B $9F92,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $9F93,$70,$02 #STRIPDATA(wall-image-20*)
@ $A003 label=WallImage_21
B $A003,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $A004,$80,$02 #STRIPDATA(wall-image-21*)
@ $A084 label=WallImage_22
B $A084,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $A085,$80,$02 #STRIPDATA(wall-image-22*)
@ $A105 label=WallImage_23
B $A105,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $A106,$80,$02 #STRIPDATA(wall-image-23*)
@ $A186 label=WallImage_24
B $A186,$01,$01 Height = #N(#PEEK(#PC)) rows.
B $A187,$80,$02 #STRIPDATA(wall-image-24*)

g $A207 Movement Sound Counter
@ $A207 label=MovementSoundCounter
D $A207 Counted up each time #R$AEED is called for a moving figure. Its lowest
. bits say on which calls a tone is played.
B $A207,$01,$01

g $A208 Protection Timer
@ $A208 label=ProtectionTimer
D $A208 The time for which the sheriff is protected, which is counted down by
. the routine for the sheriff. While it is not zero the sheriff does not touch
. objects.
B $A208,$01,$01

g $A209 Riding Timer
@ $A209 label=RidingTimer
D $A209 The time for which the sheriff stays on a horse, which is counted down
. every fourth frame by the routine for a sheriff who is riding.
B $A209,$01,$01

g $A20A Outlaw Shot Flag
@ $A20A label=OutlawShotFlag
D $A20A Set to one when the outlaw has been hit by a bullet in the town, which
. makes #R$B2E9 end the stage.
B $A20A,$01,$01

g $A20B Key One Held Flag
@ $A20B label=KeyOneHeldFlag
D $A20B One while key 1 is held down on the title screen.
B $A20B,$01,$01

g $A20C Key Two Held Flag
@ $A20C label=KeyTwoHeldFlag
D $A20C One while key 2 is held down on the title screen.
B $A20C,$01,$01

g $A20D Key Three Held Flag
@ $A20D label=KeyThreeHeldFlag
D $A20D One while key 3 is held down on the title screen.
B $A20D,$01,$01

g $A20E Menu Entry Number
@ $A20E label=MenuEntryNumber
D $A20E The number of the entry of the title screen menu which is being looked
. after.
B $A20E,$01,$01

g $A20F Tile Set Address
@ $A20F label=TileSetAddress
D $A20F The address of the set of tiles which is used by the routines which draw
. blocks of tiles.
W $A20F,$02,$02

g $A211 Draw Message State
@ $A211 label=DrawMessageState
D $A211 Zero until the "DRAW!!" message has been printed in a duel. It is one if
. the player provoked the outlaw and two if the outlaw started to draw. While it
. is not zero the outlaw's gun moves on every frame.
B $A211,$01,$01

g $A212 Shots Fired Count
@ $A212 label=ShotsFiredCount
D $A212 The number of shots which the outlaw has fired in a duel.
B $A212,$01,$01

g $A213 Name Offset Flag
@ $A213 label=NameOffsetFlag
D $A213 Used while the name of the outlaw is printed on the poster. It is one if
. the part of the name has an even number of characters, which means that it is
. printed half a character across.
B $A213,$01,$01

g $A214 Horizontal Speed
@ $A214 label=HorizontalSpeed
D $A214 The signed horizontal speed of the object which is being moved, which is
. set by #R$CCC2 and used by #R$CCE5.
B $A214,$01,$01

g $A215 Vertical Speed
@ $A215 label=VerticalSpeed
D $A215 The signed vertical speed of the object which is being moved, which is
. set by #R$CCC2 and used by #R$CCE5.
B $A215,$01,$01

g $A216 Frame Counter
@ $A216 label=FrameCounter
D $A216 Counts the frames of the game.
W $A216,$02,$02

g $A218 First Random Number
@ $A218 label=FirstRandomNumber
D $A218 The first of two random numbers, which are stirred by #R$C0D3.
W $A218,$02,$02

g $A21A Second Random Number
@ $A21A label=SecondRandomNumber
D $A21A The second of two random numbers, which are stirred by #R$C0D3.
W $A21A,$02,$02

g $A21C Options
@ $A21C label=Options
D $A21C The choices which are made on the title screen. Bit 0 is set for two
. players and bits 1 and 2 are the type of controls: zero for the keyboard, one
. for a Kempston joystick, two for a cursor joystick and three for an Interface
. 2 joystick. Bit 3 is set when the game starts, and makes a joystick give the
. direction which the sheriff faces instead of turning him.
B $A21C,$01,$01

g $A21D Saved Stack Pointer
@ $A21D label=SavedStackPointer
D $A21D The stack pointer is kept here by the routines which use it to move
. data.
W $A21D,$02,$02

g $A21F Top Speed
@ $A21F label=TopSpeed
D $A21F The top speed of the sheriff, which is #N$0A when he walks and #N$12
. when he rides a horse.
B $A21F,$01,$01

g $A220 Sprite Horizontal Position
@ $A220 label=SpriteHorizontalPosition
D $A220 The horizontal position of the sprite which is being drawn. Some other
. routines use it to keep a value.
B $A220,$01,$01

g $A221 Sprite Vertical Position
@ $A221 label=SpriteVerticalPosition
D $A221 The vertical position of the sprite which is being drawn.
B $A221,$01,$01

g $A222 Sprite Row Bytes
@ $A222 label=SpriteRowBytes
D $A222 The number of bytes in each row of the sprite which is being drawn.
B $A222,$01,$01

g $A223 Sprite Rows Left
@ $A223 label=SpriteRowsLeft
D $A223 The number of rows of the sprite which is being drawn which are left to
. draw.
B $A223,$01,$01

g $A224 Sprite Jump Opcode
@ $A224 label=SpriteJumpOpcode
D $A224 The opcode of a #N$C3 ("JP") instruction, which is written when the game
. starts. It is followed by its address, so the routines for drawing sprites
. jump from here to the code for the columns of the sprite.
B $A224,$01,$01

g $A225 Sprite Jump Address
@ $A225 label=SpriteJumpAddress
D $A225 The address which is jumped to from #R$A224.
W $A225,$02,$02

g $A227 Sprite Row Step
@ $A227 label=SpriteRowStep
D $A227 The distance in the buffer from the end of one row of the sprite to the
. start of the next.
B $A227,$01,$01

g $A228 Sheriff Sprite List
@ $A228 label=SheriffSpriteList
D $A228 The sprite list of the sheriff, which has three sprites one above
. another. The sprite number of the second sprite, which is at #N$A22D, is
. changed when the sheriff has just fired.
B $A228,$0A,$03

g $A232 Outlaw Sprite List
@ $A232 label=OutlawSpriteList
D $A232 The sprite list of the outlaw in the town, which has three sprites one
. above another and is made by #R$B3DA.
B $A232,$0A,$03

g $A23C Sound Notes Left
@ $A23C label=SoundNotesLeft
D $A23C The number of notes left to play in the sound effect which is in
. progress. It is zero when there is none.
B $A23C,$01,$01

g $A23D Sound Note Address
@ $A23D label=SoundNoteAddress
D $A23D The address one byte before the next note of the sound effect which is
. in progress.
W $A23D,$02,$02

g $A23F Current Player
@ $A23F label=CurrentPlayer
D $A23F Zero for the first player and one for the second.
B $A23F,$01,$01

g $A240 Stage Running Flag
@ $A240 label=StageRunningFlag
D $A240 Set to one when a stage starts. It is cleared when the stage ends well,
. and if it is still set when the objects have gone the player loses a life.
B $A240,$01,$01

g $A241 Start Game Flag
@ $A241 label=StartGameFlag
D $A241 Set to one on the title screen when the menu has finished and the game
. is to start.
B $A241,$01,$01

g $A242 Tune Played Flag
@ $A242 label=TunePlayedFlag
D $A242 Set to one when the title tune has been played, which stops it from
. being played again.
B $A242,$01,$01

g $A243 Objects Drawn Count
@ $A243 label=ObjectsDrawnCount
D $A243 The number of objects which have been drawn in this frame. The stage is
. over when there is nothing left to do and this is zero.
B $A243,$01,$01

g $A244 Fire Held Flag
@ $A244 label=FireHeldFlag
D $A244 Set to one when the revolver has been fired and the fire control has not
. been released since.
B $A244,$01,$01

g $A245 Fire Timer
@ $A245 label=FireTimer
D $A245 The time since the revolver was fired, which is counted down. The
. sheriff is shown firing while it is not zero, and the revolver is not
. reloaded.
B $A245,$01,$01

g $A246 Reloading Flag
@ $A246 label=ReloadingFlag
D $A246 Set to one while the revolver is being loaded with bullets.
B $A246,$01,$01

g $A247 Last Controls
@ $A247 label=LastControls
D $A247 The controls which were used last time, which are used by #R$D0E3 to
. settle which of two opposite controls is used when they are both pressed.
B $A247,$01,$01

g $A248 Column Flags
@ $A248 label=ColumnFlags
D $A248 The flags, one bit each for sixteen columns of the screen which are each
. sixteen pixels wide, which say that a wall has been drawn in the column.
B $A248,$01,$01 The flags for the first eight columns.
B $A249,$01,$01 The flags for the last eight columns.

g $A24A First Object Position
@ $A24A label=FirstObjectPosition
D $A24A The position in the list of objects of a cell of the town, at #R$C352,
. which is after the first object of those which are being compared.
W $A24A,$02,$02

g $A24C Second Object Position
@ $A24C label=SecondObjectPosition
D $A24C The position in the list of objects of a cell of the town, at #R$C352,
. which is after the second object of those which are being compared.
W $A24C,$02,$02

g $A24E Screen Horizontal Position
@ $A24E label=ScreenHorizontalPosition
D $A24E The horizontal position on the screen of the object or the part of a
. cell which is being drawn.
W $A24E,$02,$02

g $A250 Screen Vertical Position
@ $A250 label=ScreenVerticalPosition
D $A250 The vertical position on the screen of the object or the part of a cell
. which is being drawn.
W $A250,$02,$02

g $A252 Flip Flag
@ $A252 label=FlipFlag
D $A252 Zero if the sprite or tile which is being drawn is drawn as it is, and
. not zero if it is drawn as a reflection.
B $A252,$01,$01

g $A253 Cell Code
@ $A253 label=CellCode
D $A253 The code of the cell of the town which is being drawn.
B $A253,$01,$01

g $A254 Cell Column
@ $A254 label=CellColumn
D $A254 The column of the cell of the town which was found last.
B $A254,$01,$01

g $A255 Cell Row
@ $A255 label=CellRow
D $A255 The row of the cell of the town which was found last.
B $A255,$01,$01

g $A256 Rotate Key Flag
@ $A256 label=RotateKeyFlag
D $A256 Set to one while the key for rotating the view is held down.
B $A256,$01,$01

g $A257 Bounty
@ $A257 label=Bounty
D $A257 The bounty of the current player, as three bytes of packed decimal
. digits with the most significant byte first. This is the start of the nineteen
. bytes of state for the current player.
B $A257,$02,$02 The two most significant bytes.
@ $A259 label=Bounty_LastByte
B $A259,$01,$01 The least significant byte.

g $A25A Fine
@ $A25A label=Fine
D $A25A The fine which is taken from the bounty when a bystander is shot, as a
. packed decimal word with the low byte first.
B $A25A,$01,$01 The low byte.
@ $A25B label=Fine_HighByte
B $A25B,$01,$01 The high byte.

g $A25C Horse Price
@ $A25C label=HorsePrice
D $A25C The price of a horse, as a packed decimal word with the low byte first.
B $A25C,$01,$01 The low byte.
@ $A25D label=HorsePrice_HighByte
B $A25D,$01,$01 The high byte.

g $A25E Bullet Price
@ $A25E label=BulletPrice
D $A25E The price of a bullet, as a packed decimal word with the low byte first.
B $A25E,$01,$01 The low byte.
@ $A25F label=BulletPrice_HighByte
B $A25F,$01,$01 The high byte.

g $A260 Level
@ $A260 label=Level
D $A260 The level which the current player has reached. It chooses the outlaw,
. the reward and the prices.
B $A260,$01,$01

g $A261 Skill
@ $A261 label=Skill
D $A261 How difficult the game is, which goes up by one, to a most of seven,
. when the player completes some of the levels. It affects how fast the outlaws
. draw and how the bags fall.
B $A261,$01,$01

g $A262 Bullets Loaded
@ $A262 label=BulletsLoaded
D $A262 The number of bullets in the revolver, from zero to six.
B $A262,$01,$01

g $A263 Lives
@ $A263 label=Lives
D $A263 The number of lives which the current player has left.
B $A263,$01,$01

g $A264 Targets Left
@ $A264 label=TargetsLeft
D $A264 The number of money bags which are still to be made in the stage of the
. bags, or one for the stage of the duel. The stage goes on while it is not
. zero.
B $A264,$01,$01

g $A265 Stage Kind
@ $A265 label=StageKind
D $A265 The kind of the stage when it is not in the town: zero for none, one for
. the money bags and two for the duel.
B $A265,$01,$01

g $A266 Screen Attribute
@ $A266 label=ScreenAttribute
D $A266 The attribute with which the screen is filled when the screen is drawn
. for a stage.
B $A266,$01,$01

g $A267 Town Offset
@ $A267 label=TownOffset
D $A267 Four in the town and zero in the other stages. It is the number of
. columns by which the screen is moved in the town, and it is used to tell the
. town from the other stages.
B $A267,$01,$01

g $A268 View Rotation
@ $A268 label=ViewRotation
D $A268 Bit 0 is set when the view of the town is rotated by a half turn.
B $A268,$01,$01

g $A269 Bullet Unpaid Flag
@ $A269 label=BulletUnpaidFlag
D $A269 Set to one when the bounty cannot pay for a bullet, which stops the
. revolver from being loaded until the bounty goes up.
B $A269,$01,$01

g $A26A Other Player State
@ $A26A label=OtherPlayerState
D $A26A The nineteen bytes of state for the player who is not playing, in the
. same order as the state of the current player which starts at #R$A257. #R$A6EA
. exchanges them.
B $A26A,$0C,$0C The bounty, the fine, the prices, the level, the skill, the
. bullets loaded.
@ $A276 label=OtherPlayerLives
B $A276,$01,$01 The number of lives.
B $A277,$06,$06 The rest of the state.

g $A27D Object Slot 1
@ $A27D label=ObjectSlot_01
D $A27D The first slot, which holds the sheriff in the town, the outlaw in the
. duel and the first of the money bags in the stage of the bags. There are
. fifteen slots of sixteen bytes. The first byte of a slot is the type of the
. object, which is zero for a slot which is not used. The layout of a slot is:
. byte #N$00 the type; bytes #N$01 and #N$02 the horizontal position; bytes
. #N$03 and #N$04 the vertical position; byte #N$05 the speed; byte #N$06 the
. heading, in bits 6 and 7, with zero for up the screen, one for the right, two
. for down and three for the left, and the time to turn in bits 0 to 2; byte
. #N$07 the flags, in which bit 0 says that the object has bumped into
. something, bit 1 says that it has been drawn and bit 6 says that it is
. flipped; bytes #N$08 and #N$09 the half width and the half height; bytes #N$0A
. and #N$0B counters; byte #N$0C the walking frame, in which bit 2 chooses the
. second set of frames; byte #N$0D the vertical offset; and bytes #N$0E and
. #N$0F the address of the sprite list.
B $A27D,$10,$08

g $A28D Object Slot 2
@ $A28D label=ObjectSlot_02
D $A28D The second slot, which holds a bullet of the sheriff in the town, and
. the gun of the outlaw in the duel. It is also the second of the money bags.
B $A28D,$10,$08

g $A29D Object Slot 3
@ $A29D label=ObjectSlot_03
D $A29D The third slot, which holds a bullet of the sheriff in the town. It is
. also the third of the money bags.
B $A29D,$10,$08

g $A2AD Object Slot 4
@ $A2AD label=ObjectSlot_04
D $A2AD The fourth slot, which holds a bullet of the sheriff in the town.
B $A2AD,$10,$08

g $A2BD Object Slot 5
@ $A2BD label=ObjectSlot_05
D $A2BD The fifth slot, which holds the outlaw in the town.
B $A2BD,$10,$08

g $A2CD Object Slot 6
@ $A2CD label=ObjectSlot_06
D $A2CD The sixth slot, which holds the pointing hand next to the sheriff in the
. town.
B $A2CD,$10,$08

g $A2DD Object Slot 7
@ $A2DD label=ObjectSlot_07
D $A2DD The seventh slot, which holds the cactus.
B $A2DD,$10,$08

g $A2ED Object Slot 8
@ $A2ED label=ObjectSlot_08
D $A2ED The eighth slot, which holds the horse.
B $A2ED,$10,$08

g $A2FD Object Slot 9
@ $A2FD label=ObjectSlot_09
D $A2FD The ninth slot, which holds the tumbleweed.
B $A2FD,$10,$08

g $A30D Object Slot 10
@ $A30D label=ObjectSlot_10
D $A30D The tenth slot, which holds a bystander.
B $A30D,$10,$08

g $A31D Object Slot 11
@ $A31D label=ObjectSlot_11
D $A31D The eleventh slot, which holds a bystander.
B $A31D,$10,$08

g $A32D Object Slot 12
@ $A32D label=ObjectSlot_12
D $A32D The twelfth slot, which holds a bystander.
B $A32D,$10,$08

g $A33D Object Slot 13
@ $A33D label=ObjectSlot_13
D $A33D The thirteenth slot, which holds a bystander.
B $A33D,$10,$08

g $A34D Object Slot 14
@ $A34D label=ObjectSlot_14
D $A34D The fourteenth slot, which holds the shot which the sheriff fires in the
. stages outside the town.
B $A34D,$10,$08

g $A35D Object Slot 15
@ $A35D label=ObjectSlot_15
D $A35D The fifteenth slot, which holds the crosshair in the stages outside the
. town.
B $A35D,$10,$08

c $A36D Initialise Game
@ $A36D label=InitialiseGame
D $A36D The real start of the game. It checks the loader's signature, clears the
. game variables, builds the lookup tables, shows the title screen and menu,
. sets up the first player and then falls into the main loop at #R$A3BA.
.
. When a game has ended and the high score has been shown, control comes back to
. #R$A37E so that the title screen is shown again.
  $A36D,$03 Reset the stack pointer to just below the start of the game.
  $A370,$03 Fetch the high byte of the system frame counter.
  $A373,$03 Return unless it holds #N$56, which is the value the tape loader
. leaves there.
N $A376 Clear the game variables.
  $A376,$06 Clear everything from #R$A207 onwards, #N$0166 bytes in all, which
. covers every game variable.
  $A37C,$02 Skip over the shorter clear below.
@ $A37E label=RestartGame
N $A37E This entry point is used when the game has ended. It keeps the frame
. counter, the random seeds and the control method chosen on the menu.
  $A37E,$06 Clear everything from #R$A23C onwards, #N$0131 bytes in all.
@ $A384 label=InitialiseGame_Clear
  $A384,$03 Fill the memory with zero.
N $A387 Set up the machine and show the title screen.
  $A387,$03 Build the pixel shifting lookup tables.
  $A38A,$05 Write the opcode for a #N$C3 (JP) instruction to #R$A224, ready for
. the sprite drawing routines to use.
  $A38F,$03 Set the border to black.
  $A392,$03 Show the title screen and wait for the player to start the game.
  $A395,$03 Fetch the option flags.
  $A398,$02,b$01 Set bit 3, which records that a game is under way.
  $A39A,$03 Store the option flags again.
  $A39D,$03 Convert the top score into text for the telegram panel.
  $A3A0,$03 Give both players their starting values.
  $A3A3,$03 Clear the off-screen playfield buffer.
  $A3A6,$05 Write #N$01 to #R$A240 to show that a new stage is starting.
  $A3AB,$03 Fetch the option flags again.
  $A3AE,$02 Test bit 0, which is set for a two player game.
  $A3B0,$03 Print the current player number if there are two players.
@ $A3B3 label=StartStage
N $A3B3 Draw the screen for the next stage of the game and run it.
  $A3B3,$04 Fetch the border and paper colour for the stage and keep the stage
. colour in #REGe.
  $A3B7,$03 Draw the screen furniture.
@ $A3BA label=MainLoop
N $A3BA The main loop. It runs once for every frame of the game.
  $A3BA,$04 Write #N$00 to #R$A243 to clear the count of objects drawn this
. frame.
  $A3BE,$03 Reset the stack pointer, so that nothing can build up on the stack.
  $A3C1,$03 Check whether the player has been lost and deal with it if so.
N $A3C4 Run the handler for each of the fifteen object slots in turn.
  $A3C4,$04 Point #REGix at #R$A27D.
@ $A3C8 label=MainLoopNextObject
  $A3C8,$03 Fetch the type of the object in this slot.
  $A3CB,$03 Point #REGbc at #R$A412.
  $A3CE,$03 Call the handler for the type of object.
  $A3D1,$03 Update the random number seeds.
  $A3D4,$03 Set the size of an object slot in #REGbc.
  $A3D7,$02 Move #REGix on to the next slot.
  $A3D9,$03 Copy the slot address into #REGhl (using the stack).
  $A3DC,$03 The address past the last object slot goes into #REGbc.
  $A3DF,$05 Loop back to #R$A3C8 until #REGix has moved past the last slot.
N $A3E4 Now do everything which does not belong to a single object.
  $A3E4,$03 Advance the frame counter.
  $A3E7,$03 Create any objects which the current stage needs.
  $A3EA,$03 Draw the scenery sprites.
  $A3ED,$03 Draw the town.
  $A3F0,$03 Flash the chamber of the revolver which has just fired.
  $A3F3,$03 Copy the playfield buffer to the screen.
  $A3F6,$03 Play the next note of any sound effect.
  $A3F9,$03 Print the next letter of the telegram.
  $A3FC,$03 Check whether the outlaw has been caught.
  $A3FF,$03 Create new townspeople, the outlaw and the other town objects.
  $A402,$03 Pause the game if the pause key is being pressed.
  $A405,$04 Fetch the number of targets remaining in the stage and keep the
. number of targets left in #REGc.
  $A409,$03 Fetch the count of objects drawn this frame.
  $A40C,$01 Combine the two counts.
  $A40D,$03 Jump to #R$C7D1 if the stage has nothing left to do.
  $A410,$02 Otherwise loop back to #R$A3BA for the next frame.

g $A412 Object Handler Table
@ $A412 label=ObjectHandlerTable
D $A412 One address for each of the twenty-seven object types. The main loop at
. #R$A3BA uses the type held in the first byte of an object slot to pick the
. routine which looks after that object.
W $A412,$36,$02 The routines for types #N$00 to #N$1A.

c $A448 Handle Empty Slot
@ $A448 label=HandleEmptySlot
D $A448 Type #N$00: an empty slot has nothing to do.
  $A448,$01 Return.

c $A449 Handle Respawn Delay
@ $A449 label=HandleRespawnDelay
D $A449 Type #N$19: the pause before the sheriff comes back after losing a life.
. The delay counter in byte #N$0C of the slot counts down, and then the object
. turns into type #N$1A.
  $A449,$04 Decrease the delay counter and return if it has not reached zero.
  $A44D,$04 Turn the object into type #N$1A.
  $A451,$01 Return.

c $A452 Handle Sheriff Entrance
@ $A452 label=HandleSheriffEntrance
D $A452 Type #N$1A: the sheriff arriving back in the street. The vertical offset
. of the sprite in byte #N$0D grows by four every frame, with a rising sound,
. until it reaches #N$1C. The object then becomes a sheriff (type #N$01) and is
. protected from harm for a short time.
  $A452,$03 Fetch the vertical offset of the sprite.
  $A455,$02 Add #N$04 to the offset.
  $A457,$03 Store the new offset.
  $A45A,$03 Play a sound effect whose pitch depends on the offset.
  $A45D,$03 Fetch the offset again.
  $A460,$03 Return if the offset is still below #N$1C.
  $A463,$04 Turn the object into a sheriff.
  $A467,$04 Reset the vertical offset of the sprite to zero.
  $A46B,$05 Write #N$10 to #R$A208 to make the sheriff invulnerable for a short
. time.
  $A470,$09 Point the sprite list of the object at #R$A228.
  $A479,$02 Clear #REGc, so that no controls are being pressed.
  $A47B,$03 Carry on in the sheriff handler.

c $A47E Create Money Bag
@ $A47E label=CreateMoneyBag
D $A47E Creates a money bag (an object of type #N$18) in the seventh object slot
. when the player's bounty has dropped below $100. The bag appears close to the
. sheriff, in a free cell.
  $A47E,$07 Return unless the first two bytes of the bounty are both zero, which
. means it is less than $100.
  $A485,$03 Point #REGde at #R$A2DD.
  $A488,$01 Fetch the type of the object in the slot.
  $A489,$02 Return if the slot is already in use.
  $A48B,$03 Copy #REGde to #REGiy (using the stack).
  $A48E,$03 Point #REGhl at #R$A4B5.
  $A491,$03 Set the size of an object slot in #REGbc.
  $A494,$02 Copy the template into the slot.
  $A496,$02 Set the distance from the sheriff to one cell.
  $A498,$03 Place the bag one cell away from the sheriff.
  $A49B,$01 Return if that cell is blocked.
  $A49C,$03 Fetch a random number.
  $A49F,$02,b$01 Keep bits 4 and 5.
  $A4A1,$02 Add #N$80 to give a position inside the cell.
  $A4A3,$03 Set the horizontal position of the bag within the cell.
  $A4A6,$03 Fetch another random number.
  $A4A9,$02,b$01 Keep bits 4 and 5.
  $A4AB,$02 Add #N$80 to give a position inside the cell.
  $A4AD,$03 Set the vertical position of the bag within the cell.
  $A4B0,$04 Turn the slot into a money bag.
  $A4B4,$01 Return.

b $A4B5 Money Bag Template
@ $A4B5 label=MoneyBagTemplate
D $A4B5 The initial contents of a slot for a money bag. The final two bytes
. point to the sprite list.
B $A4B5,$0E,$08 Type, position, speed, size and counters, which #R$A47E fills
. in.
W $A4C3,$02 The sprite list of a money bag.
B $A4C5,$04,$04 The sprite list: sprite #N$29 at offset
. (#N($F8), #N$04), then the terminator.
. #SPRITE$29(money-bag*).

c $A4C9 Handle Money Bag
@ $A4C9 label=HandleMoneyBag
D $A4C9 Type #N$18: a money bag put in the street by #R$A47E to help a player
. who has run out of money. It disappears if the sheriff moves away from it.
. When the sheriff touches it, it adds $100 to the bounty.
  $A4C9,$02 Set the distance at which the bag stays alive to two cells.
  $A4CB,$03 Check how close the sheriff is.
  $A4CE,$03 Remove the bag if the sheriff has moved away.
  $A4D1,$03 Check whether the sheriff is touching the bag.
  $A4D4,$01 Return if not.
  $A4D5,$03 Set the $100 added to the bounty in #REGbc.
  $A4D8,$03 Add it to the bounty.
  $A4DB,$03 Print the new bounty.
  $A4DE,$05 Write #N$08 to #R$A23C so that the pick-up sound lasts eight notes.
  $A4E3,$06 Point #R$A23D at the notes of the pick-up sound.
  $A4E9,$03 Remove the bag.

c $A4EC Prepare Top Score Text
@ $A4EC label=PrepareTopScoreText
D $A4EC Converts the top score into the digits shown on the telegram panel.
@ $A4F2 label=ConvertDigits
N $A4F2 This entry point converts #REGb bytes of packed decimal digits at #REGde
. into characters at #REGhl.
  $A4EC,$03 Point #REGde at the top score.
  $A4EF,$03 Point #REGhl at #R$A872.
  $A4F2,$02 Set the number of bytes to convert to three.
@ $A4F4 label=PrepareTopScoreText_ConvertDigitsLoop
  $A4F4,$01 Fetch a pair of digits.
  $A4F5,$04 Shift the first digit into the bottom half of the byte.
  $A4F9,$02,b$01 Keep just the digit.
  $A4FB,$02 Convert the digit to a character.
  $A4FD,$01 Write it to the text.
  $A4FE,$01 Move on to the next character.
  $A4FF,$01 Fetch the pair of digits again.
  $A500,$02,b$01 Keep just the second digit.
  $A502,$02 Convert it to a character.
  $A504,$01 Write it to the text.
  $A505,$02 Move on to the next pair of digits and the next character.
  $A507,$02 Loop back until every pair has been converted.
  $A509,$01 Return.

c $A50A Check Top Score
@ $A50A label=CheckTopScore
D $A50A Called when the last life of the last player has been lost. It works out
. which player scored most, and if that score beats the top score of the day it
. shows the "WELL DONE" screen and stores the new top score. Either way the game
. then goes back to the title screen.
N $A50A The player states are swapped first so that the first player's score is
. in the current position.
  $A50A,$03 Swap the states of the two players.
@ $A50D label=CheckTopScore_SkipSwap
N $A50D Compare the two scores, most significant byte first.
  $A50D,$02 Set the number of bytes in a score to three.
  $A50F,$03 Point #REGde at #R$A257.
  $A512,$03 Point #REGhl at #R$A26A.
@ $A515 label=CheckTopScore_CompareScoresLoop
  $A515,$01 Fetch a byte of the current score.
  $A516,$01 Compare it with the same byte of the other score.
  $A517,$02 Move on to the next byte of each score.
  $A519,$02 Jump to #R$A51F if the other score is higher.
  $A51B,$02 Jump to #R$A538 if the current score is higher.
  $A51D,$02 Loop back until all three bytes have been compared.
@ $A51F label=CheckTopScore_SecondPlayer
N $A51F The other player has the higher score (or the two are equal).
  $A51F,$02 Set the winner to be player two.
  $A521,$03 Point #REGde at #R$A26A.
@ $A524 label=CheckTopScore_CompareWithTopScore
N $A524 Compare the winning score with the top score of the day.
  $A524,$01 Stash the address of the winning score on the stack.
  $A525,$03 Point #REGhl at #R$A5D2.
  $A528,$02 Set the number of bytes in a score to three.
@ $A52A label=CheckTopScore_CompareWithTopScoreLoop
  $A52A,$01 Fetch a byte of the winning score.
  $A52B,$01 Compare it with the same byte of the top score.
  $A52C,$02 Move on to the next byte of each score.
  $A52E,$02 Jump to #R$A534 if the winning score is lower.
  $A530,$02 Jump to #R$A53F if the winning score is higher.
  $A532,$02 Loop back until all three bytes have been compared.
@ $A534 label=CheckTopScore_NotBeaten
  $A534,$01 The top score has not been beaten, so discard the address of the
. winning score.
  $A535,$03 Restart the game from the title screen.
@ $A538 label=CheckTopScore_FirstPlayer
N $A538 The current player has the higher score.
  $A538,$02 Set the winner to be player one.
  $A53A,$03 Point #REGde at #R$A257.
  $A53D,$02 Join in with the comparison with the top score.
@ $A53F label=CheckTopScore_Winner
N $A53F The top score has been beaten.
  $A53F,$01 Fetch the winning player.
  $A540,$02 Convert it to the character for the player number.
  $A542,$03 Write it into the "PLAYER" text.
  $A545,$02 Set the attribute to #COLOUR$00.
  $A547,$03 Clear the attributes.
  $A54A,$03 Clear the pixels of the screen.
  $A54D,$01 Retrieve the address of the winning score.
  $A54E,$03 Point #REGhl at #R$A5D2.
  $A551,$02 Set the number of bytes in a score to three.
  $A553,$03 Swap the two scores, which stores the new top score.
  $A556,$03 Point #REGde at #R$A5D2.
  $A559,$03 Point #REGhl at #R$A5CB.
  $A55C,$03 Convert the score to digits.
N $A55F Print the first line.
  $A55F,$03 Point #REGhl at #N$4087 (in the screen buffer).
  $A562,$03 Point #REGde at #R$A59D.
  $A565,$03 Print it in large letters.
N $A568 Print the second line.
  $A568,$03 Point #REGhl at #N$40E8 (in the screen buffer).
  $A56B,$03 Point #REGde at #R$A5A8.
  $A56E,$03 Print it in large letters.
N $A571 Print the third line.
  $A571,$03 Point #REGhl at #N$4846 (in the screen buffer).
  $A574,$03 Point #REGde at #R$A5B2.
  $A577,$03 Print it in large letters.
N $A57A Print the fourth line.
  $A57A,$03 Point #REGhl at #N$48A8 (in the screen buffer).
  $A57D,$03 Point #REGde at #R$A5BE.
  $A580,$03 Print it in large letters.
N $A583 Print the fifth line.
  $A583,$03 Point #REGhl at #N$5048 (in the screen buffer).
  $A586,$03 Point #REGde at #R$A5C8.
  $A589,$03 Print it in large letters.
  $A58C,$03 Point #REGde at #R$B1E0.
  $A58F,$03 Play the tune.
  $A592,$02 Set the number of delay loops to four.
  $A594,$03 Set the length of each delay loop.
  $A597,$03 Wait for a while.
  $A59A,$03 Restart the game from the title screen.

t $A59D Messaging: Score Text
@ $A59D label=ScoreMessages
D $A59D The messages shown when the top score has been beaten. Each is an
. attribute byte, the characters and a zero terminator. The #N$5E in the last
. message is the dollar sign of the font, and the score digits are written over
. the spaces after it.
B $A59D,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $A59E,$09 "WELL DONE".
B $A5A7,$01,$01 Terminator.
@ $A5A8 label=ScoreMessages_Player
B $A5A8,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $A5A9,$07 "PLAYER ".
B $A5B0,$01,$01 The number of the winning player, written by #R$A53F. It is a
. space until then.
B $A5B1,$01,$01 Terminator.
@ $A5B2 label=ScoreMessages_TodaysTop
B $A5B2,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $A5B3,$0A "TODAYS TOP".
B $A5BD,$01,$01 Terminator.
@ $A5BE label=ScoreMessages_ScoreIs
B $A5BE,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $A5BF,$08 "SCORE IS".
B $A5C7,$01,$01 Terminator.
@ $A5C8 label=ScoreMessages_Score
B $A5C8,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $A5C9,$01,$01 The dollar sign.
  $A5CA,$01 A space.
@ $A5CB label=ScoreMessages_ScoreDigits
  $A5CB,$06 Room for the six digits of the score.
B $A5D1,$01,$01 Terminator.

g $A5D2 Top Score
@ $A5D2 label=TopScore
D $A5D2 The top score of the day as three packed decimal bytes, most significant
. first. It starts at $10000 and is replaced by #R$A50A when a player beats it.
B $A5D2,$03,$03

c $A5D5 Update Prices
@ $A5D5 label=UpdatePrices
D $A5D5 Called every frame, but only does anything when the low byte of the
. frame counter is #N$BD, so once every 256 frames. It picks one of the three
. amounts on the telegram at random: the fine, the price of a horse or the price
. of a bullet. If the telegram has finished typing it chooses a new price from a
. table and retypes that line. The higher the level, the more prices the table
. offers, so prices tend to rise as the game goes on.
  $A5D5,$03 Fetch the frame counter.
  $A5D8,$01 Copy its low byte into #REGa.
  $A5D9,$02 Add #N$43, which gives zero only when the low byte is #N$BD.
  $A5DB,$01 Return unless it is.
  $A5DC,$03 Fetch a random number.
  $A5DF,$02,b$01 Keep bits 0 and 1.
  $A5E1,$02 Jump to #R$A627 to change the fine if the number is zero.
  $A5E3,$03 Jump to #R$A63B to change the price of a horse if the number is one.
N $A5E6 Change the price of a bullet.
  $A5E6,$03 Check whether the telegram has finished typing.
  $A5E9,$01 Return if it has not.
  $A5EA,$04 Write #N$00 to #R$A830 to start typing the bullet line again.
  $A5EE,$03 Point #REGhl at #R$A25F.
  $A5F1,$03 Point #REGde at #R$A83D.
  $A5F4,$01 Keep both in the alternate registers.
  $A5F5,$03 Point #REGhl at #R$A65F.
@ $A5F8 label=UpdatePrices_ChooseNewPrice
N $A5F8 Choose a new price from the table at #REGhl, using more of the table as
. the level goes up.
  $A5F8,$03 Fetch the level.
  $A5FB,$04 Jump to #R$A603 if the level is six or more.
  $A5FF,$02 Allow the first two prices.
  $A601,$02 Jump to #R$A60D.
@ $A603 label=UpdatePrices_TestLevelThirteen
  $A603,$04 Jump to #R$A60B if the level is thirteen or more.
  $A607,$02 Allow the first four prices.
  $A609,$02 Jump to #R$A60D.
@ $A60B label=UpdatePrices_AllowEight
  $A60B,$02 Allow all eight prices.
@ $A60D label=UpdatePrices_StoreAllowed
  $A60D,$01 Copy the number of prices that are allowed into #REGc.
  $A60E,$03 Fetch a random number.
  $A611,$02,b$01 Keep a number between #N$00 and #N$0F.
@ $A613 label=UpdatePrices_ChooseNewPriceLoop
  $A613,$03 Jump to #R$A619 once the number is less than the number of prices
. allowed.
  $A616,$01 Otherwise subtract the number of prices allowed.
  $A617,$02 Loop back to #R$A613.
@ $A619 label=UpdatePrices_ReadPrice
  $A619,$01 Double the number to get an offset into the table of words.
  $A61A,$01 Copy the offset into #REGe.
  $A61B,$02 Clear #REGd.
  $A61D,$01 Point #REGhl at the chosen price.
  $A61E,$01 Fetch the low byte of the price.
  $A61F,$01 Move on to the high byte.
  $A620,$01 Fetch the high byte of the price.
  $A621,$01 Stash the price on the stack.
  $A622,$01 Bring back the address of the price and the digits.
  $A623,$01 Fetch the new price into #REGbc.
  $A624,$03 Store the new price, convert it to text and start typing the line
. again.
@ $A627 label=UpdatePrices_Fine
N $A627 Change the fine.
  $A627,$03 Check whether the telegram has finished typing.
  $A62A,$01 Return if it has not.
  $A62B,$04 Write #N$00 to #R$A854 to start typing the fine line again.
  $A62F,$03 Point #REGhl at #R$A25B.
  $A632,$03 Point #REGde at #R$A861.
  $A635,$01 Keep both in the alternate registers.
  $A636,$03 Point #REGhl at #R$A67F.
  $A639,$02 Jump to #R$A5F8.
@ $A63B label=UpdatePrices_HorsePrice
N $A63B Change the price of a horse.
  $A63B,$03 Check whether the telegram has finished typing.
  $A63E,$01 Return if it has not.
  $A63F,$04 Write #N$00 to #R$A842 to start typing the horse line again.
  $A643,$03 Point #REGhl at #R$A25D.
  $A646,$03 Point #REGde at #R$A84F.
  $A649,$01 Keep both in the alternate registers.
  $A64A,$03 Point #REGhl at #R$A66F.
  $A64D,$02 Jump to #R$A5F8.

c $A64F Check Telegram Complete
@ $A64F label=CheckTelegramComplete
D $A64F Checks whether every line of the telegram has been typed in full. A line
. is complete when its counter has reached #N$0E.
R $A64F O:F The zero flag is set if every line is complete
  $A64F,$03 Point #REGhl at the first telegram line.
  $A652,$03 Set the size of a telegram line in #REGde.
  $A655,$02 Set the number of lines to six.
@ $A657 label=CheckTelegramComplete_Loop
  $A657,$01 Fetch the counter of the line.
  $A658,$02 Compare it with the number of characters in a line.
  $A65A,$01 Return if the line is not complete.
  $A65B,$01 Move on to the next line.
  $A65C,$02 Loop back until all six lines have been checked.
  $A65E,$01 Return.

g $A65F Bullet Prices
@ $A65F label=BulletPrices
D $A65F Eight prices for a bullet, as packed decimal words with the low byte
. first.
W $A65F,$10,$02 $5, $10, $15, $20, $25, $50, $75 and $100.

g $A66F Horse Prices
@ $A66F label=HorsePrices
D $A66F Eight prices for a horse, as packed decimal words with the low byte
. first.
W $A66F,$10,$02 $50, $75, $100, $150, $250, $350, $500 and $1000.

g $A67F Fine Amounts
@ $A67F label=FineAmounts
D $A67F Eight amounts for the fine, as packed decimal words with the low byte
. first.
W $A67F,$10,$02 $100, $150, $250, $400, $1000, $1500, $3000 and $5000.

c $A68F Set Up Player
@ $A68F label=SetUpPlayer
D $A68F Gives the current player the starting values for a new game: four lives,
. level zero, a bounty of $280, and the first stage, in which the player shoots
. twenty money bags.
  $A68F,$05 Write #N$04 to #R$A263 to give the player four lives.
  $A694,$04 Write #N$00 to #R$A260 to start on level zero.
  $A698,$03 Write #N$00 to #R$A261 to start at the easiest difficulty.
  $A69B,$03 Set the starting bounty of $280 in #REGbc.
  $A69E,$03 Add it to the bounty.
  $A6A1,$03 Set the number of targets to twenty and the stage type to the money
. bag shoot.
  $A6A4,$03 Store them.
  $A6A7,$05 Write #N$46 to #R$A266 to colour the border and screen yellow.
  $A6AC,$03 Make sure the price of a bullet is set.
  $A6AF,$03 Make sure the price of a horse is set.
  $A6B2,$03 Jump to #R$A7CB.

c $A6B5 Set Up Players
@ $A6B5 label=SetUpPlayers
D $A6B5 Gives both players the starting values. In a game for one player the
. second player is left with no lives.
  $A6B5,$03 Set up the first player.
  $A6B8,$03 Swap to the state of the second player.
  $A6BB,$03 Set up the second player.
  $A6BE,$03 Fetch the option flags.
  $A6C1,$02 Test bit 0, which is set for a two player game.
  $A6C3,$01 Return if there are two players.
  $A6C4,$04 Write #N$00 to #R$A276 to leave the second player with no lives.
  $A6C8,$01 Return.

c $A6C9 Show Player Number
@ $A6C9 label=ShowPlayerNumber
D $A6C9 Clears the screen and prints the number of the player who is about to
. play in large letters, and then waits a moment.
  $A6C9,$02 Set the attribute to #COLOUR$00.
  $A6CB,$03 Clear the attributes.
  $A6CE,$03 Clear the pixels of the screen.
  $A6D1,$03 Fetch the number of the current player, zero or one.
  $A6D4,$02 Convert it to a character.
  $A6D6,$03 Write it into the "PLAYER" text.
  $A6D9,$03 Point #REGde at #R$B7E6.
N $A6DC Print the "PLAYER" text.
  $A6DC,$03 Point #REGhl at #N$4868 (in the screen buffer).
  $A6DF,$03 Print it in large letters.
  $A6E2,$02 Set the number of delay loops to three.
  $A6E4,$03 Set the length of each delay loop.
  $A6E7,$03 Wait for a while.

c $A6EA Swap Player States
@ $A6EA label=SwapPlayerStates
D $A6EA Exchanges the nineteen bytes of state for the current player, which
. start at #R$A257, with the nineteen bytes for the other player, which start at
. #R$A26A.
N $A6F2 This entry point exchanges #REGb bytes at #REGhl with the bytes at
. #REGde.
  $A6EA,$03 Point #REGhl at the state of the current player.
  $A6ED,$03 Point #REGde at #R$A26A.
  $A6F0,$02 Set the number of bytes to nineteen.
@ $A6F2 label=SwapBytes
  $A6F2,$01 Fetch a byte from the first block.
  $A6F3,$01 Fetch the matching byte of the second block.
  $A6F4,$01 Put it into the first block.
  $A6F5,$01 Take the byte from the first block.
  $A6F6,$01 Put it into the second block.
  $A6F7,$02 Move on to the next byte of each block.
  $A6F9,$02 Loop back until every byte has been swapped.
  $A6FB,$01 Return.

c $A6FC Print Telegram
@ $A6FC label=PrintTelegram
D $A6FC Prints the whole telegram panel in town. It converts the bullet price,
. the horse price and the fine into digits, prints the first four lines of the
. telegram and, in a game for two players, the line which shows the score of the
. player who is not currently playing.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D301)
. #SIM(start=$D301,stop=$D304)
. #SCR$03,$11,$11,$0E,$05(telegram) } UDGTABLE# #POPS
  $A6FC,$03 Fetch the town flag.
  $A6FF,$02 Return if the game is not in town.
  $A701,$03 Point #REGhl at #R$A83D.
  $A704,$03 Point #REGde at #R$A25E.
  $A707,$03 Convert the price to digits.
  $A70A,$03 Point #REGhl at #R$A84F.
  $A70D,$03 Point #REGde at #R$A25C.
  $A710,$03 Convert the price to digits.
  $A713,$03 Point #REGhl at #R$A861.
  $A716,$03 Point #REGde at #R$A25A.
  $A719,$03 Convert the amount to digits.
  $A71C,$03 Point #REGde at #R$A830.
  $A71F,$02 Set the number of lines to four.
  $A721,$03 Print the four lines.
  $A724,$03 Fetch the option flags.
  $A727,$03 Return if the game has only one player.
  $A72A,$03 Fetch the number of the current player.
  $A72D,$02,b$01 Keep bit 0.
  $A72F,$02 Jump to #R$A766 if the second player is playing.
  $A731,$03 Point #REGde at #R$A88A.
@ $A734 label=PrintTelegram_ScoreLine
  $A734,$01 Stash the address of the line on the stack.
  $A735,$03 Point #REGhl at #R$A26A.
  $A738,$01 Swap the two addresses.
  $A739,$02 Set the offset to the digits within the line.
  $A73B,$03 Point #REGhl at the digits.
  $A73E,$03 Convert the score to digits.
  $A741,$01 Retrieve the address of the line.
  $A742,$02 Set the number of lines to print to one.
@ $A744 label=PrintTelegram_Lines
N $A744 This entry point prints #REGb lines of the telegram, starting with the
. line at #REGde.
  $A744,$02 Set the number of characters in a line to fourteen.
  $A746,$01 Skip the counter of the line.
  $A747,$01 Fetch the low byte of the screen address of the line.
  $A748,$01 Move on to the high byte.
  $A749,$02 Add four to move past the left edge of the panel.
  $A74B,$01 Keep the low byte of the screen address in #REGl.
  $A74C,$01 Fetch the high byte of the screen address of the line.
  $A74D,$01 Move on to the attribute.
  $A74E,$01 Keep the high byte of the screen address in #REGh.
  $A74F,$01 Fetch the attribute of the line.
  $A750,$01 Move on to the first character.
  $A751,$01 Keep the attribute in the alternate accumulator.
@ $A752 label=PrintTelegram_LinesLoop
  $A752,$01 Fetch a character.
  $A753,$01 Move on to the next character.
  $A754,$01 Stash the counters on the stack.
  $A755,$03 Convert the character to the number of its tile.
  $A758,$03 Point #REGbc at #R$8EA8.
  $A75B,$03 Draw the character on the screen.
  $A75E,$01 Move to the next screen position.
  $A75F,$01 Retrieve the counters.
  $A760,$01 Decrease the character counter.
  $A761,$02 Loop back until the whole line has been printed.
  $A763,$02 Loop back until every line has been printed.
  $A765,$01 Return.
@ $A766 label=PrintTelegram_FirstPlayerLine
  $A766,$03 Point #REGde at the score line for the first player.
  $A769,$02 Jump to #R$A734.
B $A76B,$05,$05 Unused.

c $A770 Reset Bullet Price
@ $A770 label=ResetBulletPrice
D $A770 Gives bullets their starting price of $5 if the price is zero.
N $A77D This entry point stores the price in #REGbc and converts it to digits.
. It is used when the telegram changes a price.
  $A770,$03 Point #REGhl at the bullet price.
  $A773,$01 Fetch the low byte of the price.
  $A774,$01 Move on to the high byte.
  $A775,$02 Return if the bullet price is not zero.
  $A777,$03 Point #REGde at #R$A83D.
  $A77A,$03 Set the starting bullet price of $5 in #REGbc.
@ $A77D label=ResetBulletPrice_SetPrice
  $A77D,$01 Store the high byte of the price.
  $A77E,$01 Move back to the low byte.
  $A77F,$01 Store the low byte of the price.
  $A780,$01 Point #REGhl at the digits.
@ $A781 label=ConvertPriceToDigits
N $A781 This entry point converts the two packed decimal bytes at #REGde, in the
. order low byte first, into digits at #REGhl. Leading zeros are not printed and
. are replaced by spaces after the digits instead.
  $A781,$03 Set the number of bytes to two and clear the count of leading zeros.
  $A784,$01 Point #REGde at the high byte.
@ $A785 label=ResetBulletPrice_ConvertPriceSkipZeros
  $A785,$01 Fetch a byte.
  $A786,$02,b$01 Keep the first digit.
  $A788,$02 Jump to #R$A795 if it is not zero.
  $A78A,$01 Count a leading zero.
  $A78B,$01 Fetch the byte again.
  $A78C,$02,b$01 Keep the second digit.
  $A78E,$02 Jump to #R$A7A0 if it is not zero.
  $A790,$01 Count another leading zero.
  $A791,$01 Move down to the next byte.
  $A792,$02 Loop back until both bytes have been checked.
  $A794,$01 Return.
@ $A795 label=ResetBulletPrice_ConvertPriceDigits
  $A795,$01 Fetch the byte.
  $A796,$04 Move the first digit into the bottom half of the byte.
  $A79A,$02,b$01 Keep the digit.
  $A79C,$02 Convert it to a character.
  $A79E,$01 Write it to the text.
  $A79F,$01 Move on to the next character.
@ $A7A0 label=ResetBulletPrice_Done
  $A7A0,$01 Fetch the byte.
  $A7A1,$02,b$01 Keep the second digit.
  $A7A3,$02 Convert it to a character.
  $A7A5,$01 Write it to the text.
  $A7A6,$01 Move on to the next character.
  $A7A7,$01 Move down to the next byte.
  $A7A8,$02 Loop back until both bytes have been converted.
@ $A7AA label=ResetBulletPrice_ConvertPricePad
  $A7AA,$01 Fetch the count of leading zeros.
  $A7AB,$02 Return once every leading zero has been replaced.
  $A7AD,$02 Write a space.
  $A7AF,$01 Move on to the next character.
  $A7B0,$01 Count the space.
  $A7B1,$02 Loop back to #R$A7AA.
B $A7B3,$05,$05 Unused.

c $A7B8 Reset Horse Price
@ $A7B8 label=ResetHorsePrice
D $A7B8 Gives a horse its starting price of $50 if the price is zero.
  $A7B8,$03 Point #REGhl at the horse price.
  $A7BB,$01 Fetch the low byte of the price.
  $A7BC,$01 Move on to the high byte.
  $A7BD,$02 Return if the horse price is not zero.
  $A7BF,$03 Point #REGde at #R$A84F.
  $A7C2,$03 Set the starting horse price of $50 in #REGbc.
  $A7C5,$02 Store the price and convert it to digits.
B $A7C7,$04,$04 Unused.

c $A7CB Reset Fine
@ $A7CB label=ResetFine
D $A7CB Gives the fine its starting amount of $100 if the amount is zero.
  $A7CB,$03 Point #REGhl at the fine.
  $A7CE,$01 Fetch the low byte of the fine.
  $A7CF,$01 Move on to the high byte.
  $A7D0,$02 Return if the fine is not zero.
  $A7D2,$03 Point #REGde at #R$A861.
  $A7D5,$03 Set the starting fine of $100 in #REGbc.
  $A7D8,$02 Store the fine and convert it to digits.

c $A7DA Type Telegram
@ $A7DA label=TypeTelegram
D $A7DA Called every frame in town. It makes the lines of the telegram appear
. one letter at a time, like a telegram being typed. Each line has a counter
. which is #N$0E once the line is complete. The first line which is not complete
. shows a blinking cursor on alternate frames, and on the other frames prints
. its next letter and clicks.
  $A7DA,$03 Fetch the town flag.
  $A7DD,$02 Return if the game is not in town.
  $A7DF,$02 Set the number of lines to six.
  $A7E1,$03 Point #REGhl at #R$A830.
  $A7E4,$03 Set the size of a telegram line in #REGde.
  $A7E7,$04 Fetch the town flag, which is also the column of the panel and keep
. the panel column in #REGc.
@ $A7EB label=TypeTelegram_NextLine
  $A7EB,$01 Fetch the counter of the line.
  $A7EC,$04 Jump to #R$A7F4 if the line is not complete.
  $A7F0,$01 Move on to the next line.
  $A7F1,$02 Loop back until every line has been checked.
  $A7F3,$01 Return.
@ $A7F4 label=TypeTelegram_StashLine
N $A7F4 Find the position of the next letter of the line.
  $A7F4,$01 Stash the address of the line on the stack.
  $A7F5,$01 Stash the counter of the line on the stack.
  $A7F6,$01 Move on to the low byte of the screen address.
  $A7F7,$01 Fetch the low byte of the screen address.
  $A7F8,$01 Move on to the high byte.
  $A7F9,$01 Fetch the high byte of the screen address.
  $A7FA,$01 Move on to the attribute.
  $A7FB,$01 Swap the screen address into #REGhl.
  $A7FC,$01 Add the counter and the column of the panel to the address.
  $A7FD,$03 Point #REGhl at the position of the next letter.
  $A800,$01 Fetch the attribute.
  $A801,$01 Move on to the first letter.
  $A802,$01 Keep the attribute in the alternate accumulator.
  $A803,$03 Fetch the low byte of the frame counter.
  $A806,$02,b$01 Keep bit 0.
  $A808,$02 Jump to #R$A818 on even frames.
N $A80A On odd frames draw the cursor in the next position.
  $A80A,$02 Convert the odd frame into the number of the cursor character.
  $A80C,$03 Convert the character to the number of its tile.
  $A80F,$03 Point #REGbc at #R$8EA8.
  $A812,$03 Draw the cursor.
  $A815,$01 Retrieve the counter of the line.
  $A816,$01 Retrieve the address of the line.
  $A817,$01 Return.
@ $A818 label=TypeTelegram_RestoreCounter
N $A818 On even frames print the next letter and click.
  $A818,$01 Retrieve the counter of the line.
  $A819,$01 Swap the pointer to the letters into #REGhl.
  $A81A,$03 Point #REGhl at the next letter of the line.
  $A81D,$01 Swap the pointer back into #REGde.
  $A81E,$01 Fetch the letter.
  $A81F,$03 Convert the letter to the number of its tile.
  $A822,$01 Stash the tile number on the stack.
  $A823,$03 Play a click.
  $A826,$01 Retrieve the tile number.
  $A827,$03 Point #REGbc at #R$8EA8.
  $A82A,$03 Draw the letter.
  $A82D,$01 Retrieve the address of the line.
  $A82E,$01 Increase the counter of the line.
  $A82F,$01 Return.

g $A830 Telegram Lines
@ $A830 label=TelegramLines
D $A830 The six lines of the telegram panel, each #N$12 bytes long. The first
. byte is the number of letters typed so far, which is #N$0E once the line is
. complete. Then come the screen address of the line, its attribute and fourteen
. characters. The score lines have room after the dollar sign for the digits.
. The #N$5C in the high score line is the full stop of the font.
B $A830,$01,$01 Letters typed so far.
W $A831,$02,$02 Screen address.
B $A833,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
T $A834,$08 "BULLETS ".
B $A83C,$01,$01 Dollar sign.
@ $A83D label=TelegramLines_BulletDigits
T $A83D,$05 "     ".
B $A842,$01,$01 Letters typed so far.
W $A843,$02,$02 Screen address.
B $A845,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
T $A846,$08 "HORSE   ".
B $A84E,$01,$01 Dollar sign.
@ $A84F label=TelegramLines_HorseDigits
T $A84F,$05 "     ".
B $A854,$01,$01 Letters typed so far.
W $A855,$02,$02 Screen address.
B $A857,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
T $A858,$08 "FINE    ".
B $A860,$01,$01 Dollar sign.
@ $A861 label=TelegramLines_FineDigits
T $A861,$05 "     ".
B $A866,$01,$01 Letters typed so far.
W $A867,$02,$02 Screen address.
B $A869,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
T $A86A,$02 "HI".
B $A86C,$01,$01 Full stop.
T $A86D,$04 "SCR ".
B $A871,$01,$01 Dollar sign.
@ $A872 label=TelegramLines_HighScoreDigits
T $A872,$06 "      ".
@ $A878 label=TelegramLines_FirstPlayerScore
B $A878,$01,$01 Letters typed so far.
W $A879,$02,$02 Screen address.
B $A87B,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
T $A87C,$08 "P1 SCR ".
B $A884,$01,$01 Dollar sign.
T $A885,$05 "     ".
@ $A88A label=TelegramLines_SecondPlayerScore
B $A88A,$01,$01 Letters typed so far.
W $A88B,$02,$02 Screen address.
B $A88D,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
T $A88E,$08 "P2 SCR ".
B $A896,$01,$01 Dollar sign.
T $A897,$05 "     ".

c $A89C Create Tumbleweed
@ $A89C label=CreateTumbleweed
D $A89C Called every frame in town. From level eight onwards it puts a
. tumbleweed (an object of type #N$17) in the ninth object slot, next to the
. sheriff, if the slot is free.
  $A89C,$03 Fetch the level.
  $A89F,$02 Compare it with eight.
  $A8A1,$01 Return if the level is below eight.
  $A8A2,$03 Point #REGde at #R$A2FD.
  $A8A5,$01 Fetch the type of the object in the slot.
  $A8A6,$02 Return if the slot is in use.
  $A8A8,$03 Copy #REGde to #REGiy (using the stack).
  $A8AB,$03 Point #REGhl at #R$A8C1.
  $A8AE,$03 Set the size of an object slot in #REGbc.
  $A8B1,$02 Copy the template into the slot.
  $A8B3,$02 Set the distance from the sheriff to one cell.
  $A8B5,$03 Place the tumbleweed one cell away from the sheriff.
  $A8B8,$01 Return if that cell is blocked.
  $A8B9,$03 Set the position of the tumbleweed within its cell.
  $A8BC,$04 Turn the slot into a tumbleweed.
  $A8C0,$01 Return.

b $A8C1 Tumbleweed Template
@ $A8C1 label=TumbleweedTemplate
D $A8C1 The initial contents of a slot for a tumbleweed. The final two bytes
. point to the sprite list.
B $A8C1,$0E,$08 Type, position, speed, size and counters.
W $A8CF,$02 The sprite list of a tumbleweed.
B $A8D1,$04,$04 The sprite list: sprite #N$2B at offset
. (#N($F4), #N$00), then the terminator.
. #SPRITE$2B(tumbleweed*).

c $A8D5 Handle Tumbleweed
@ $A8D5 label=HandleTumbleweed
D $A8D5 Type #N$17: a tumbleweed rolling about next to the sheriff. It follows
. one of two routes, stepping through the route one byte at a time; the high
. nibble of each byte is the vertical speed and the low nibble the horizontal
. speed, both signed. Bits 6 and 7 of byte #N$05 mirror the route, and they
. change every time a route ends, so the tumbleweed wanders in a different way
. each time. It spins by flipping its sprite every frame, and it hurts the
. sheriff if they touch. It goes away when the sheriff is two cells away.
N $A8D5 Disappear if the sheriff is more than two cells away.
  $A8D5,$02 Set the distance to two cells.
  $A8D7,$03 Check how close the sheriff is.
  $A8DA,$03 Remove the tumbleweed if the sheriff has moved away.
N $A8DD Fetch the next step of the route.
  $A8DD,$03 Fetch the number of the route, zero or one.
  $A8E0,$03 Point #REGbc at #R$A94B.
  $A8E3,$03 Point #REGhl at the start of the route.
  $A8E6,$03 Fetch the position in the route.
  $A8E9,$03 Move on to the next step.
  $A8EC,$03 Point #REGhl at the step.
  $A8EF,$01 Fetch the step.
  $A8F0,$04 Jump to #R$A935 if this is the end of the route.
N $A8F4 Work out the vertical speed from the high nibble.
  $A8F4,$08 Shift the high nibble into the bottom of the byte, keeping the sign.
  $A8FC,$06 Jump to #R$A904 unless the route is mirrored vertically.
  $A902,$02 Negate the speed to mirror the route.
@ $A904 label=HandleTumbleweed_DoubleVertical
  $A904,$02 Double the speed.
  $A906,$03 Store it as the vertical speed.
N $A909 Work out the horizontal speed from the low nibble.
  $A909,$01 Fetch the step again.
  $A90A,$01 Keep the tumbleweed step in #REGc.
  $A90B,$02,b$01 Keep the low nibble.
  $A90D,$04 Jump to #R$A913 unless the nibble is negative.
  $A911,$02,b$01 Extend the sign of the nibble into the top half.
@ $A913 label=HandleTumbleweed_TestHorizontal
  $A913,$06 Jump to #R$A91B unless the route is mirrored horizontally.
  $A919,$02 Negate the speed to mirror the route.
@ $A91B label=HandleTumbleweed_DoubleHorizontal
  $A91B,$02 Double the speed.
  $A91D,$03 Store it as the horizontal speed.
N $A920 Move the tumbleweed.
  $A920,$03 Set the direction the tumbleweed is facing from its speed.
  $A923,$03 Move the tumbleweed.
  $A926,$03 Fetch the flags of the object.
  $A929,$02,b$01 Flip the sprite horizontally.
  $A92B,$03 Store the flags.
  $A92E,$03 Check whether the tumbleweed is touching the sheriff.
  $A931,$03 Hurt the sheriff if it is.
  $A934,$01 Return.
@ $A935 label=HandleTumbleweed_RouteEnd
N $A935 The route has ended, so choose the next one.
  $A935,$03 Fetch a random number.
  $A938,$02,b$01 Keep bit 0.
  $A93A,$03 Choose the route with it.
  $A93D,$04 Write #N$00 to byte #N$0B to go back to the first step.
  $A941,$03 Fetch the mirror flags.
  $A944,$02 Add #N$40 to change how the route is mirrored.
  $A946,$03 Store the flags.
  $A949,$02 Start again with the new route.

g $A94B Tumbleweed Routes
@ $A94B label=TumbleweedRoutes
D $A94B The table of the two routes followed by tumbleweeds, followed by the
. routes themselves. Each step of a route is a signed vertical speed in the high
. nibble and a signed horizontal speed in the low nibble. #N$80 ends a route.
W $A94B,$04,$02 The addresses of the two routes.
B $A94F,$19,$08 The first route.
B $A968,$19,$08 The second route.

c $A981 Create Horse
@ $A981 label=CreateHorse
D $A981 Called every frame in town. While the sheriff is on foot it puts a horse
. (an object of type #N$14) in the eighth object slot, two cells from the
. sheriff, if the slot is free.
  $A981,$03 Fetch the type of the object in the first slot.
  $A984,$02 Compare it with the type of a sheriff on foot.
  $A986,$01 Return if the sheriff is not on foot.
  $A987,$03 Point #REGde at #R$A2ED.
  $A98A,$01 Fetch the type of the object in the slot.
  $A98B,$02 Return if the slot is in use.
  $A98D,$03 Copy #REGde to #REGiy (using the stack).
  $A990,$03 Point #REGhl at #R$A9A8.
  $A993,$03 Set the size of an object slot in #REGbc.
  $A996,$02 Copy the template into the slot.
  $A998,$02 Set the distance from the sheriff to two cells.
  $A99A,$03 Place the horse two cells away from the sheriff.
  $A99D,$01 Return if that cell is blocked.
  $A99E,$04 Turn the slot into a horse.
  $A9A2,$05 Set the riding time of the horse to #N$40.
  $A9A7,$01 Return.

b $A9A8 Horse Template
@ $A9A8 label=HorseTemplate
D $A9A8 The initial contents of a slot for a horse. The final two bytes point to
. the sprite list.
B $A9A8,$0E,$08 Type, position, speed, size and counters.
W $A9B6,$02 The sprite list of a horse.
B $A9B8,$07,$03 The sprite list: sprite #N$37 at offset
. (#N($EC), #N$00), sprite #N$36 at offset (#N($FC),
. #N$01), then the terminator.
. #SPRITE$37(horse-head*) #SPRITE$36(horse-body*).

c $A9BF Handle Horse
@ $A9BF label=HandleHorse
D $A9BF Type #N$14: a horse waiting in the street. It goes away if the sheriff
. is three cells away. If the sheriff touches it, the horse is removed, the
. sheriff turns into a mounted sheriff (type #N$15) who has a higher top speed,
. and the price of the horse is taken from the bounty.
  $A9BF,$02 Set the distance to three cells.
  $A9C1,$03 Check how close the sheriff is.
  $A9C4,$03 Remove the horse if the sheriff has moved away.
  $A9C7,$03 Check whether the sheriff is touching the horse.
  $A9CA,$01 Return if not.
  $A9CB,$05 Write #N$08 to #R$A23C so that the sound lasts eight notes.
  $A9D0,$06 Point #R$A23D at the notes of the horse sound.
  $A9D6,$04 Remove the horse.
  $A9DA,$05 Raise the top speed of the sheriff to #N$12.
  $A9DF,$04 Turn the sheriff into a mounted sheriff.
  $A9E3,$04 Fetch the price of a horse.
  $A9E7,$03 Take it from the bounty.
  $A9EA,$03 Jump to #R$D390.

c $A9ED Create Cactus
@ $A9ED label=CreateCactus
D $A9ED Called every frame in town. Cacti stand in eight fixed cells of the town
. (see #R$AA76). When the sheriff comes within two cells of one, and the seventh
. object slot is free, the routine puts a cactus (an object of type #N$13) in
. the slot.
  $A9ED,$03 Fetch the type of the object in the seventh slot.
  $A9F0,$02 Return if the slot is in use.
  $A9F2,$04 Fetch the horizontal cell of the sheriff and keep it in #REGe.
  $A9F6,$03 Fetch the vertical cell of the sheriff.
  $A9F9,$04 Shift it into the high nibble.
  $A9FD,$02,b$01 Keep the high nibble.
  $A9FF,$01 Keep the vertical cell in the high nibble of #REGd.
  $AA00,$03 Point #REGhl at #R$AA76.
  $AA03,$01 Fetch the number of cacti.
@ $AA04 label=CreateCactus_Next
  $AA04,$01 Move on to the next cactus.
@ $AA05 label=CreateCactus_Loop
  $AA05,$01 Fetch the position of the cactus.
  $AA06,$02,b$01 Keep the horizontal cell.
  $AA08,$01 Subtract the horizontal cell of the sheriff.
  $AA09,$02 Jump to #R$AA0D unless the difference is negative.
  $AA0B,$02 Make the difference positive.
@ $AA0D label=CreateCactus_CompareHorizontal
  $AA0D,$04 Jump to #R$AA5E if the cactus is two or more cells away
. horizontally.
  $AA11,$01 Fetch the position of the cactus again.
  $AA12,$02,b$01 Keep the vertical cell.
  $AA14,$01 Subtract the vertical cell of the sheriff.
  $AA15,$02 Jump to #R$AA19 unless the difference is negative.
  $AA17,$02 Make the difference positive.
@ $AA19 label=CreateCactus_CompareVertical
  $AA19,$04 Jump to #R$AA5E if the cactus is two or more cells away vertically.
@ $AA1D label=CreateCactusFound
N $AA1D The sheriff is close to this cactus, so make it.
  $AA1D,$01 Fetch the position of the cactus.
  $AA1E,$01 Stash it on the stack.
  $AA1F,$03 Point #REGde at #R$A2DD.
  $AA22,$03 Copy #REGde to #REGiy (using the stack).
  $AA25,$03 Point #REGhl at #R$AA62.
  $AA28,$03 Set the size of an object slot in #REGbc.
  $AA2B,$02 Copy the template into the slot.
  $AA2D,$01 Retrieve the position of the cactus.
  $AA2E,$01 Keep the cactus position in #REGc.
  $AA2F,$02,b$01 Keep the horizontal cell.
  $AA31,$03 Set the horizontal cell of the cactus.
  $AA34,$01 Fetch the position again.
  $AA35,$04 Shift the vertical cell into the bottom of the byte.
  $AA39,$02,b$01 Keep the vertical cell.
  $AA3B,$03 Set the vertical cell of the cactus.
  $AA3E,$01 Fetch the position again.
  $AA3F,$04 Swap the two halves of the position.
  $AA43,$02,b$01 Keep three bits which came from the horizontal cell.
  $AA45,$02 Add #N$40 to give the horizontal position within the cell.
  $AA47,$03 Set the horizontal position of the cactus within its cell.
  $AA4A,$01 Fetch the position again.
  $AA4B,$01 Invert it.
  $AA4C,$02,b$01 Keep three bits which came from the vertical cell.
  $AA4E,$02 Add #N$40 to give the vertical position within the cell.
  $AA50,$03 Set the vertical position of the cactus within its cell.
  $AA53,$03 Combine it with the horizontal position.
  $AA56,$02 Rotate bit 4 up into bit 6.
  $AA58,$02,b$01 Keep bit 6, which chooses whether the sprite is flipped.
  $AA5A,$03 Set the flags of the cactus.
  $AA5D,$01 Return.
@ $AA5E label=CreateCactusSkip
  $AA5E,$01 Move on to the next cactus.
  $AA5F,$02 Loop back until every cactus has been checked.
  $AA61,$01 Return.

b $AA62 Cactus Template
@ $AA62 label=CactusTemplate
D $AA62 The initial contents of a slot for a cactus. The final two bytes point
. to the sprite list.
B $AA62,$0E,$08 Type, position, speed, size and counters.
W $AA70,$02 The sprite list of a cactus.
B $AA72,$04,$04 The sprite list: sprite #N$2A at offset
. (#N($F4), #N$00), then the terminator.
. #SPRITE$2A(cactus*).

g $AA76 Cactus Positions
@ $AA76 label=CactusPositions
D $AA76 The number of cacti, followed by the position of each in the town. The
. high nibble of a position is the vertical cell and the low nibble is the
. horizontal cell. #R$A9ED also uses the same byte to choose where in its cell
. the cactus stands, so that the cacti do not all stand in the middle of their
. cells.
B $AA76,$01,$01 The number of cacti.
B $AA77,$08,$08 The positions of the cacti.

c $AA7F Handle Cactus
@ $AA7F label=HandleCactus
D $AA7F Type #N$13: a cactus standing in the street. It goes away when the
. sheriff is more than two cells away. It hurts the sheriff if they touch, and
. it stops any bullet which hits it.
  $AA7F,$02 Set the distance to two cells.
  $AA81,$03 Check how close the sheriff is.
  $AA84,$03 Remove the cactus if the sheriff has moved away.
  $AA87,$03 Check whether the cactus is touching the sheriff.
  $AA8A,$03 Hurt the sheriff if it is.
  $AA8D,$03 Check whether a bullet has hit the cactus.
  $AA90,$01 Return if not.
  $AA91,$04 Turn the bullet into a puff of smoke.
  $AA95,$04 Set the length of the puff to two frames.
  $AA99,$01 Return.

c $AA9A Print Large Text
@ $AA9A label=PrintLargeText
D $AA9A Prints a message in letters twice as big as normal, so each letter takes
. four character cells. The message is an attribute byte followed by characters
. and ends with a zero byte.
. #PUSHS #UDGTABLE { #SIM(start=$D6DB,stop=$D6EA,clear=1,sp=$5E00)
. #SIM(start=$D6D3,stop=$D6EA,de=$47)
. #SIM(start=$ABDE,stop=$ABE7)
. #SCR$03,$06,$00,$14,$02(large-text) } UDGTABLE# #POPS
R $AA9A DE The address of the message
R $AA9A HL The screen address to print it at
  $AA9A,$01 Fetch the attribute.
  $AA9B,$01 Move on to the first character.
  $AA9C,$01 Keep the attribute in the alternate accumulator.
@ $AA9D label=PrintLargeText_Loop
  $AA9D,$01 Fetch the next character.
  $AA9E,$01 Test whether it is the end of the message.
  $AA9F,$01 Return if it is.
  $AAA0,$01 Move on to the next character.
  $AAA1,$03 Convert the character to the number of its tile.
  $AAA4,$01 Stash the address of the message on the stack.
  $AAA5,$01 Stash the screen address on the stack.
  $AAA6,$01 Swap the screen address into #REGde.
  $AAA7,$01 Copy the tile number into #REGl.
  $AAA8,$02 Clear #REGh.
  $AAAA,$03 Multiply it by eight.
  $AAAD,$03 Point #REGbc at #R$8EA8.
  $AAB0,$01 Add the offset to find the pixels of the character.
  $AAB1,$01 Swap them, so that #REGde has the pixels and #REGhl the screen
. address.
  $AAB2,$03 Draw the top left quarter of the character.
  $AAB5,$03 Draw the top right quarter of the character.
  $AAB8,$03 Draw the bottom left quarter of the character.
  $AABB,$03 Draw the bottom right quarter of the character.
  $AABE,$01 Retrieve the screen address.
  $AABF,$01 Retrieve the address of the message.
  $AAC0,$02 Move across by two character cells.
  $AAC2,$02 Loop back for the next character.

c $AAC4 Print Left Half Of Character
@ $AAC4 label=PrintLeftHalfOfCharacter
D $AAC4 Draws the left half of four rows of a character in double size. The four
. bytes of pixels at #REGde each have their left four pixels widened to eight
. and written twice, so they fill the eight pixel rows of a character cell. The
. cell is coloured with the attribute and #REGhl moves to the cell on its right.
R $AAC4 DE The address of the pixels of the character
R $AAC4 HL The screen address
R $AAC4 O:HL The screen address of the cell to the right
  $AAC4,$01 Stash the address of the pixels on the stack.
  $AAC5,$01 Stash the screen address on the stack.
  $AAC6,$01 Swap the pixels into #REGhl and the screen address into #REGde.
  $AAC7,$02 Set the number of rows to four.
@ $AAC9 label=PrintLeftHalf_Loop
  $AAC9,$01 Fetch a row of pixels.
  $AACA,$01 Move on to the next row.
  $AACB,$04 Move the left four pixels into the bottom of the byte.
  $AACF,$02,b$01 Keep them.
  $AAD1,$01 Stash the address of the pixels on the stack.
  $AAD2,$03 Point #REGhl at #R$AB08.
  $AAD5,$03 Point #REGhl at the entry for the four pixels.
  $AAD8,$01 Fetch the widened pixels.
  $AAD9,$01 Write them to the screen.
  $AADA,$01 Move down a pixel row.
  $AADB,$01 Write them again.
  $AADC,$01 Move down a pixel row.
  $AADD,$01 Retrieve the address of the pixels.
  $AADE,$02 Loop back until four rows have been drawn.
  $AAE0,$01 Retrieve the screen address.
  $AAE1,$01 Retrieve the address of the pixels.
  $AAE2,$03 Set the attribute of the cell.
  $AAE5,$01 Move across to the next cell.
  $AAE6,$01 Return.

c $AAE7 Print Right Half Of Character
@ $AAE7 label=PrintRightHalfOfCharacter
D $AAE7 Draws the right half of four rows of a character in double size, in the
. same way as #R$AAC4 does for the left half, and then moves down to the cell
. below on the left.
R $AAE7 DE The address of the pixels of the character
R $AAE7 HL The screen address
R $AAE7 O:DE The address of the pixels of the next four rows
R $AAE7 O:HL The screen address of the cell below on the left
  $AAE7,$01 Stash the screen address on the stack.
  $AAE8,$01 Swap the pixels into #REGhl and the screen address into #REGde.
  $AAE9,$02 Set the number of rows to four.
@ $AAEB label=PrintRightHalf_Loop
  $AAEB,$01 Fetch a row of pixels.
  $AAEC,$01 Move on to the next row.
  $AAED,$02,b$01 Keep the right four pixels.
  $AAEF,$01 Stash the address of the pixels on the stack.
  $AAF0,$03 Point #REGhl at #R$AB08.
  $AAF3,$03 Point #REGhl at the entry for the four pixels.
  $AAF6,$01 Fetch the widened pixels.
  $AAF7,$01 Write them to the screen.
  $AAF8,$01 Move down a pixel row.
  $AAF9,$01 Write them again.
  $AAFA,$01 Move down a pixel row.
  $AAFB,$01 Retrieve the address of the pixels.
  $AAFC,$02 Loop back until four rows have been drawn.
  $AAFE,$01 Swap the screen address back into #REGhl and the pixels into #REGde.
  $AAFF,$01 Retrieve the screen address.
  $AB00,$03 Set the attribute of the cell.
  $AB03,$03 Move down to the next row of cells.
  $AB06,$01 Move back to the left.
  $AB07,$01 Return.

g $AB08 Widened Pixels
@ $AB08 label=WidenedPixels
D $AB08 Sixteen bytes, one for each pattern of four pixels. Each pixel of the
. pattern is doubled in width to give eight pixels.
B $AB08,$10,$08

c $AB18 Draw Scenery
@ $AB18 label=DrawScenery
D $AB18 Called every frame. In the town stage it draws the scenery sprites
. listed at #R$AB6A, which are fixed in the town and scroll with the view.
. Sprites which would be off the edge of the screen are skipped.
  $AB18,$03 Fetch the stage number.
  $AB1B,$01 Test whether this is a stage outside the town, which is the duel or
. the bonus stage.
  $AB1C,$01 Return if it is, as it has no scenery.
  $AB1D,$03 Fetch the horizontal cell of the sheriff.
  $AB20,$02,b$01 Make it an even number.
  $AB22,$01 Keep the even horizontal cell in #REGl.
  $AB23,$03 Fetch the vertical cell of the sheriff.
  $AB26,$02,b$01 Make it an even number.
  $AB28,$01 Keep the even vertical cell in #REGh.
  $AB29,$03 Store the cell as the origin for working out screen positions.
  $AB2C,$03 Work out where the origin is on the screen.
  $AB2F,$03 Point #REGhl at #R$AB6A.
@ $AB32 label=DrawScenery_Loop
  $AB32,$01 Fetch the number of the sprite and its flip flag.
  $AB33,$01 Test whether this is the end of the list.
  $AB34,$01 Return if it is.
  $AB35,$02,b$01 Keep the flip flag.
  $AB37,$03 Store the flip flag for the sprite drawing routine.
  $AB3A,$01 Fetch the number of the sprite again.
  $AB3B,$02,b$01 Keep the number of the sprite.
  $AB3D,$01 Move on to the horizontal offset.
  $AB3E,$01 Keep the number of the sprite in the alternate accumulator.
  $AB3F,$01 Fetch the horizontal offset of the sprite.
  $AB40,$01 Move on to the vertical offset.
  $AB41,$03 Fetch the horizontal position of the origin.
  $AB44,$01 Add the offset to find the horizontal position of the sprite.
  $AB45,$04 Jump to #R$AB67 to skip the sprite if it is off the right edge.
  $AB49,$04 Jump to #R$AB67 to skip the sprite if it is off the left edge.
  $AB4D,$01 Copy the horizontal position into #REGe.
  $AB4E,$01 Fetch the vertical offset of the sprite.
  $AB4F,$01 Move on to the next sprite in the list.
  $AB50,$03 Fetch the vertical position of the origin.
  $AB53,$01 Add the offset to find the vertical position of the sprite.
  $AB54,$02,b$01 Wrap it into the range #N$00 to #N$7F.
  $AB56,$02 Move it down the screen.
  $AB58,$01 Copy the vertical position into #REGd.
  $AB59,$01 Retrieve the number of the sprite.
  $AB5A,$01 Stash the address in the list on the stack.
  $AB5B,$03 Point #REGbc at #R$686E.
  $AB5E,$03 Point #REGhl at the sprite.
  $AB61,$03 Draw the sprite.
  $AB64,$01 Retrieve the address in the list.
  $AB65,$02 Go back for the next sprite in the list.
@ $AB67 label=DrawScenery_Skip
  $AB67,$01 Skip the vertical offset of the sprite.
  $AB68,$02 Go back for the next sprite in the list.

b $AB6A Scenery List
@ $AB6A label=SceneryList
D $AB6A The scenery sprites in the town. Each has three bytes: the number of the
. sprite (with bit 6 set if it is flipped), the horizontal offset and the
. vertical offset from the origin. A zero byte ends the list.
B $AB6A,$03,$03
B $AB6D,$03,$03
B $AB70,$03,$03
B $AB73,$03,$03
B $AB76,$01,$01 Terminator.

c $AB77 Game Selection Menu
@ $AB77 label=GameMenu
D $AB77 Shows the title screen, which has three revolvers on the left and the
. game name at the top. A bullet shoots out of each revolver and leaves a line
. of text behind it: the number of players, the controls, and "START GAME". Keys
. 1 and 2 change the first two and fire their bullet again, and key 3 starts the
. game. It returns when the bullet for key 3 has been fired.
. #PUSHS #UDGTABLE { #SIM(start=$D4FD,stop=$0000,clear=1,sp=$5E00)
. #SIM(start=$AB77,stop=$ABFB,sp=$5E00)
. #SCR$02(title-screen) } UDGTABLE# #POPS
N $AB77 Clear the screen.
  $AB77,$04 Write #N$00 to #R$A242 to allow the title tune to play.
  $AB7B,$03 Clear the screen.
  $AB7E,$02 Set the attribute to #COLOUR$45.
  $AB80,$03 Set all the attributes.
  $AB83,$03 Point #REGhl at #R$8A70.
  $AB86,$03 Set the tiles to use.
N $AB89 Draw the first revolver.
  $AB89,$03 Point #REGhl at #N$4062 (in the screen buffer).
  $AB8C,$02 Set the attribute to #COLOUR$47.
  $AB8E,$03 Draw the revolver.
  $AB91,$03 Point #REGbc at #R$8EB0.
N $AB94 Draw its digit.
  $AB94,$03 Point #REGhl at #N$40C7 (in the screen buffer).
  $AB97,$02 Set the digit to one.
  $AB99,$03 Draw the digit.
N $AB9C Draw the second revolver.
  $AB9C,$03 Point #REGhl at #N$4842 (in the screen buffer).
  $AB9F,$02 Set the attribute to #COLOUR$46.
  $ABA1,$03 Draw the revolver.
  $ABA4,$03 Point #REGbc at #R$8EB0.
N $ABA7 Draw its digit.
  $ABA7,$03 Point #REGhl at #N$48A7 (in the screen buffer).
  $ABAA,$02 Set the digit to two.
  $ABAC,$03 Draw the digit.
N $ABAF Draw the third revolver.
  $ABAF,$03 Point #REGhl at #N$5022 (in the screen buffer).
  $ABB2,$02 Set the attribute to #COLOUR$44.
  $ABB4,$03 Draw the revolver.
  $ABB7,$03 Point #REGbc at #R$8EB0.
N $ABBA Draw its digit.
  $ABBA,$03 Point #REGhl at #N$5087 (in the screen buffer).
  $ABBD,$02 Set the digit to three.
  $ABBF,$03 Draw the digit.
N $ABC2 Colour the first column black.
  $ABC2,$02 Set the attribute to #COLOUR$00.
  $ABC4,$03 Point #REGhl at #N$5800 (in the attribute buffer).
  $ABC7,$03 Colour the column.
N $ABCA Colour the last column black.
  $ABCA,$03 Point #REGhl at #N$581F (in the attribute buffer).
  $ABCD,$03 Colour the column.
N $ABD0 Colour the tenth column red.
  $ABD0,$02 Set the attribute to #COLOUR$42.
  $ABD2,$03 Point #REGhl at #N$5809 (in the attribute buffer).
  $ABD5,$03 Colour the column.
N $ABD8 Colour the eleventh column red.
  $ABD8,$03 Point #REGhl at #N$580A (in the attribute buffer).
  $ABDB,$03 Colour the column.
N $ABDE Print the game name.
  $ABDE,$03 Point #REGhl at #N$4006 (in the screen buffer).
  $ABE1,$03 Point #REGde at #R$AC32.
  $ABE4,$03 Print the game name in large letters.
N $ABE7 Print the copyright message.
  $ABE7,$03 Point #REGhl at #N$50EA (in the screen buffer).
  $ABEA,$03 Point #REGde at #R$AC23.
  $ABED,$03 Print the copyright message.
N $ABF0 Set up the four menu entries.
  $ABF0,$03 Point #REGhl at #R$AC3E.
  $ABF3,$03 Point #REGde at #R$AC4E.
  $ABF6,$03 Set the number of bytes to copy.
  $ABF9,$02 Copy the entries.
N $ABFB Run each of the menu entries once per frame.
@ $ABFB label=GameMenu_Loop
  $ABFB,$04 Point #REGix at the first menu entry.
  $ABFF,$04 Write #N$00 to #R$A20E, the number of the menu entry.
@ $AC03 label=GameMenu_Entry
  $AC03,$03 Fetch the state of the entry.
  $AC06,$03 Point #REGbc at #R$AC5E.
  $AC09,$03 Run the handler for the state.
  $AC0C,$03 Point #REGhl at #R$A20E.
  $AC0F,$01 Move on to the next entry.
  $AC10,$03 Set the size of an entry.
  $AC13,$02 Move on to the next entry.
  $AC15,$03 Copy #REGix to #REGhl (using the stack).
  $AC18,$03 Point #REGbc at the end of the entries.
  $AC1B,$03 Subtract the address of the end of the entries.
  $AC1E,$02 Loop back until all four entries have been run.
  $AC20,$03 Start the next frame.

t $AC23 Messaging: Title Text
@ $AC23 label=TitleTexts
D $AC23 The copyright message and the game name. Each is an attribute byte, the
. characters and a zero terminator. The #N$5B in the copyright message is the
. copyright symbol of the font, and the #N$5C bytes are full stops.
B $AC23,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $AC24,$01,$01 Copyright symbol.
  $AC25,$06 " 1985 ".
  $AC2B,$01 "A".
B $AC2C,$01,$01 Full stop.
  $AC2D,$01 "C".
B $AC2E,$01,$01 Full stop.
  $AC2F,$01 "G".
B $AC30,$01,$01 Full stop.
B $AC31,$01,$01 Terminator.
@ $AC32 label=TitleTexts_GameName
B $AC32,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $AC33,$0A "GUN FRIGHT".
B $AC3D,$01,$01 Terminator.

b $AC3E Initial Menu Entries
@ $AC3E label=InitialMenuEntries
D $AC3E The initial state of the four menu entries, which is copied to #R$AC4E.
. Each entry has four bytes: its state, the horizontal position of its bullet,
. the vertical position of its bullet and a counter. The first entry reads the
. keys, and the other three are the revolvers.
B $AC3E,$04,$04 Entry for the keys: state #N$05.
B $AC42,$04,$04 Entry for the first revolver.
B $AC46,$04,$04 Entry for the second revolver.
B $AC4A,$04,$04 Entry for the third revolver.

g $AC4E Menu Entries
@ $AC4E label=MenuEntries
D $AC4E The state of the four menu entries. Each entry has four bytes: its
. state, the horizontal position of its bullet, the vertical position of its
. bullet and a counter. The states are #N$00 (the revolver has not yet fired),
. #N$01 (the text is complete), #N$02 and #N$03 (the revolver is firing), #N$04
. (the bullet is flying and the text is being typed) and #N$05 (the entry which
. reads the keys).
B $AC4E,$04,$04 Entry for the keys.
@ $AC52 label=MenuEntries_FirstRevolver
B $AC52,$04,$04 Entry for the first revolver.
@ $AC56 label=MenuEntries_SecondRevolver
B $AC56,$04,$04 Entry for the second revolver.
@ $AC5A label=MenuEntries_ThirdRevolver
B $AC5A,$04,$04 Entry for the third revolver.

g $AC5E Menu Handlers
@ $AC5E label=MenuHandlers
D $AC5E The routine for each state of a menu entry. States #N$00 and #N$01 do
. nothing, states #N$02 and #N$03 use #R$ACE2, state #N$04 uses #R$ACF6 and
. state #N$05 uses #R$AC6A.
W $AC5E,$0C,$02

c $AC6A Handle Menu Keys
@ $AC6A label=HandleMenuKeys
D $AC6A The routine for state #N$05 of a menu entry, which is the only entry
. that reads the keys. First it starts each revolver which has not yet fired.
. When all three have finished it plays the title tune and checks keys 1, 2 and
. 3. Key 1 swaps between one and two players and key 2 chooses the next type of
. controls, and both make their revolver fire again so that the new text is
. typed. Key 3 starts the game, and fires the third revolver.
N $AC6A Start the next revolver which has not yet fired.
  $AC6A,$04 Point #REGiy at the entry for the first revolver.
  $AC6E,$03 Set the size of an entry.
  $AC71,$02 Set the number of revolvers to three.
@ $AC73 label=HandleMenuKeys_Loop
  $AC73,$03 Fetch the state of the revolver.
  $AC76,$03 Start the revolver if it has not fired yet.
  $AC79,$02 Subtract two from the state.
  $AC7B,$03 Return if the revolver is firing or its bullet is flying.
  $AC7E,$02 Move on to the next entry.
  $AC80,$02 Loop back until all three revolvers have been checked.
N $AC82 Play the title tune and read keys 1 to 5.
  $AC82,$03 Point #REGde at #R$B0D3.
  $AC85,$03 Play the tune, unless it has already been played or a key is
. pressed.
  $AC88,$03 Point #REGde at #R$A21C.
  $AC8B,$02 Select the keys 1 to 5.
  $AC8D,$03 Read the keys.
  $AC90,$01 Keep the keys in #REGc.
  $AC91,$03 Point #REGhl at #R$A20B.
N $AC94 Check key 1.
  $AC94,$04 Jump to #R$ACB5 if key 1 is pressed.
  $AC98,$02 Note that key 1 is not held down.
@ $AC9A label=HandleMenuKeysKey_2
  $AC9A,$01 Point #REGhl at the flag for key 2 being held down.
N $AC9B Check key 2.
  $AC9B,$04 Jump to #R$ACC5 if key 2 is pressed.
  $AC9F,$02 Note that key 2 is not held down.
@ $ACA1 label=HandleMenuKeysKey_3
  $ACA1,$01 Move on to the next flag.
N $ACA2 Check key 3.
  $ACA2,$03 Return if key 3 is not pressed.
  $ACA5,$03 Point #REGhl at #R$A241.
  $ACA8,$01 Set the flag.
  $ACA9,$03 Point #REGde at #R$B0C9.
  $ACAC,$03 Play the tune.
  $ACAF,$04 Point #REGiy at #R$AC5A.
  $ACB3,$02 Make the revolver fire.
N $ACB5 Key 1 is pressed, so swap between one and two players.
@ $ACB5 label=HandleMenuKeys_Key1Pressed
  $ACB5,$01 Fetch the flag for key 1.
  $ACB6,$01 Test whether the key was already held down.
  $ACB7,$02 Jump to #R$AC9A if it was.
  $ACB9,$02 Note that key 1 is held down.
  $ACBB,$04 Point #REGiy at #R$AC52.
  $ACBF,$01 Fetch the options.
  $ACC0,$02,b$01 Flip bit 0 to choose the other number of players.
  $ACC2,$01 Store the options.
  $ACC3,$02 Make the revolver fire.
N $ACC5 Key 2 is pressed, so choose the next type of controls.
@ $ACC5 label=HandleMenuKeys_Key2Pressed
  $ACC5,$01 Fetch the flag for key 2.
  $ACC6,$01 Test whether the key was already held down.
  $ACC7,$02 Jump to #R$ACA1 if it was.
  $ACC9,$02 Note that key 2 is held down.
  $ACCB,$04 Point #REGiy at #R$AC56.
  $ACCF,$01 Fetch the options.
  $ACD0,$02 Move on to the next type of controls.
  $ACD2,$02,b$01 Keep bits 1 and 2 as the type, and bit 0 as the number of
. players.
  $ACD4,$01 Store the options.
N $ACD5 Make the revolver fire.
@ $ACD5 label=HandleMenuKeys_StartMenuRevolver
  $ACD5,$04 Set the state of the revolver to firing.
  $ACD9,$04 Set the horizontal position of the bullet.
  $ACDD,$04 Reset the counter.
  $ACE1,$01 Return.

c $ACE2 Handle Menu Revolver Firing
@ $ACE2 label=HandleMenuRevolverFiring
D $ACE2 The routine for states #N$02 and #N$03 of a menu entry: a revolver
. firing. It draws the revolver in the state of the entry for twelve frames, and
. then moves on to the next state.
  $ACE2,$03 Draw the revolver.
  $ACE5,$03 Add one to the counter.
  $ACE8,$03 Fetch the counter.
  $ACEB,$02 Compare it with twelve.
  $ACED,$01 Return if the counter has not reached twelve.
  $ACEE,$03 Move on to the next state.
  $ACF1,$04 Reset the counter.
  $ACF5,$01 Return.

c $ACF6 Handle Menu Bullet
@ $ACF6 label=HandleMenuBullet
D $ACF6 The routine for state #N$04 of a menu entry: a bullet flying across the
. screen. It moves the bullet right two pixels, draws it and makes a click.
. Every eight pixels once it is past the left of the text, it prints the next
. character of the line of text in the bullet's wake. When the bullet reaches
. the edge of the screen the entry goes back to state #N$01. If the game has
. been started, the title screen returns to the caller.
  $ACF6,$03 Fetch the horizontal position of the bullet.
  $ACF9,$02 Move it two pixels to the right.
  $ACFB,$03 Store the new horizontal position of the bullet.
  $ACFE,$05 Jump to #R$AD6F to finish with the bullet if it has reached the
. edge.
  $AD03,$03 Draw the bullet.
  $AD06,$03 Make a click.
  $AD09,$03 Fetch the number of the entry.
  $AD0C,$01 Subtract one.
  $AD0D,$02 Jump to #R$AD1A if this is the first entry.
  $AD0F,$01 Subtract one.
  $AD10,$02 Jump to #R$AD61 if this is the second entry.
N $AD12 This is the third entry, which always says "START GAME".
  $AD12,$02 Set the attribute to #COLOUR$47.
  $AD14,$01 Keep it in the alternate accumulator.
  $AD15,$03 Point #REGhl at #R$ADD9.
  $AD18,$02 Jump to #R$AD28.
N $AD1A The first entry says "ONE PLAYER GAME" or "TWO PLAYER GAME".
@ $AD1A label=HandleMenuBullet_Players
  $AD1A,$02 Set the attribute to #COLOUR$42.
  $AD1C,$01 Keep it in the alternate accumulator.
  $AD1D,$03 Fetch the options.
  $AD20,$02,b$01 Keep the number of players.
  $AD22,$03 Point #REGbc at #R$AD7B.
@ $AD25 label=HandleMenuBullet_ChooseText
  $AD25,$03 Point #REGhl at the text.
N $AD28 Print the next character of the text when the bullet is at the right
. place.
@ $AD28 label=HandleMenuBullet_Print
  $AD28,$03 Fetch the horizontal position of the bullet.
  $AD2B,$02 Move eight pixels to the left to find the position of the character.
  $AD2D,$01 Keep the horizontal position of the character in #REGe.
  $AD2E,$03 Fetch the vertical position of the bullet.
  $AD31,$02 Move it up to the top of the text.
  $AD33,$01 Keep the vertical position of the text in #REGd.
  $AD34,$04 Test whether the text is complete.
  $AD38,$01 Return if it is.
  $AD39,$01 Fetch the horizontal position of the character.
  $AD3A,$02,b$01 Keep bits 1 and 2.
  $AD3C,$01 Return unless the character is on a character boundary.
  $AD3D,$01 Fetch the horizontal position of the character.
  $AD3E,$02 Subtract the position of the start of the text.
  $AD40,$01 Return if the bullet has not yet reached the start of the text.
  $AD41,$03 Divide the offset by eight.
  $AD44,$02,b$01 Keep five bits.
  $AD46,$03 Point #REGhl at the character in the text.
  $AD49,$01 Swap the position of the character into #REGhl and its address into
. #REGde.
  $AD4A,$03 Work out the screen address.
  $AD4D,$01 Fetch the character.
  $AD4E,$04 Jump to #R$AD58 unless the character is the last one of the text.
  $AD52,$02,b$01 Remove the flag from the character.
  $AD54,$04 Note that the text is complete.
@ $AD58 label=HandleMenuBullet_DrawCharacter
  $AD58,$03 Convert the character to the number of its tile.
  $AD5B,$03 Point #REGbc at #R$8EA8.
  $AD5E,$03 Jump to #R$D2C9.
N $AD61 The second entry says which controls are used.
@ $AD61 label=HandleMenuBullet_Controls
  $AD61,$02 Set the attribute to #COLOUR$43.
  $AD63,$01 Keep it in the alternate accumulator.
  $AD64,$03 Fetch the options.
  $AD67,$01 Move the type of controls into bits 0 and 1.
  $AD68,$02,b$01 Keep the type of controls.
  $AD6A,$03 Point #REGbc at #R$AD9D.
  $AD6D,$02 Choose the text.
N $AD6F The bullet has reached the edge of the screen.
@ $AD6F label=HandleMenuBullet_Finished
  $AD6F,$04 Set the state of the entry to complete.
  $AD73,$03 Fetch the flag which starts the game.
  $AD76,$02 Return if the game has not been started.
  $AD78,$02 Drop the return address, so that the title screen returns to its
. caller.
  $AD7A,$01 Return.

g $AD7B Number Of Players Texts
@ $AD7B label=NumberOfPlayersTexts
D $AD7B The table of texts for the number of players, followed by the texts. Bit
. 7 of the last character of each text is set. The characters with bit 7 set are
. the final #N$45 ("E") of each text.
W $AD7B,$04,$02 The addresses of the texts.
T $AD7F,$0F,$0E:$01 "#STR(#PC)".
T $AD8E,$0F,$0E:$01 "#STR(#PC)".

g $AD9D Controls Texts
@ $AD9D label=ControlsTexts
D $AD9D The table of texts for the type of controls, followed by the texts, and
. then the text of the last menu line. Bit 7 of the last character of each text
. is set.
W $AD9D,$08,$02 The addresses of the texts.
T $ADA5,$08,$07:$01 "#STR(#PC)".
T $ADAD,$11,$10:$01 "#STR(#PC)".
T $ADBE,$0F,$0E:$01 "#STR(#PC)".
T $ADCD,$0C,$0B:$01 "#STR(#PC)".
@ $ADD9 label=ControlsTexts_StartGame
T $ADD9,$0A,$09:$01 "#STR(#PC)".

c $ADE3 Draw Revolver
@ $ADE3 label=DrawRevolver
D $ADE3 Draws a revolver, which is a block of seven by five tiles.
. #PUSHS #UDGTABLE { #SIM(start=$D6DB,stop=$D6EA,clear=1,sp=$5E00)
. #SIM(start=$D6D3,stop=$D6EA,de=$47)
. #SIM(start=$AB83,stop=$AB91)
. #SCR$03,$02,$03,$07,$05(revolver) } UDGTABLE# #POPS
R $ADE3 HL The screen address
R $ADE3 A The attribute
  $ADE3,$01 Keep the attribute in the alternate accumulator.
  $ADE4,$03 Point #REGde at #R$ADED.
  $ADE7,$03 Set the width to seven and the height to five.
  $ADEA,$03 Draw the block of tiles.

g $ADED Revolver Tiles
@ $ADED label=RevolverTiles
D $ADED The numbers of the tiles which make up a revolver, in rows of seven. A
. zero is a blank tile.
B $ADED,$23,$07

c $AE10 Draw Menu Sprite
@ $AE10 label=DrawMenuSprite
D $AE10 Draws the sprite for the state of a menu entry (the gun firing or the
. bullet flying) at the position of the entry. The sprites are sixteen pixels
. wide and are drawn upwards from the bottom row. Each row has two bytes. If the
. horizontal position is not a multiple of eight, the bytes are indexes into the
. shift tables, which are used to shift the sprite across by two, four or six
. pixels. The routine takes the data from the stack to make it faster.
R $AE10 IX The address of the menu entry
N $AE10 Find the sprite and the screen address.
  $AE10,$03 Fetch the state of the entry.
  $AE13,$03 Point #REGbc at #R$6864.
  $AE16,$03 Point #REGhl at the sprite.
  $AE19,$01 Fetch the number of rows.
  $AE1A,$01 Move on to the data.
  $AE1B,$01 Keep the number of rows in the alternate accumulator.
  $AE1C,$01 Swap the address of the data into #REGde.
  $AE1D,$04 Fetch the horizontal position and keep the horizontal position of
. the sprite in #REGl.
  $AE21,$03 Fetch the vertical position into #REGh.
  $AE24,$03 Work out the screen address.
  $AE27,$04 Save the stack pointer.
  $AE2B,$01 Swap the screen address into #REGde and the address of the data into
. #REGhl.
  $AE2C,$01 Point the stack pointer at the data.
  $AE2D,$03 Fetch the horizontal position.
  $AE30,$02,b$01 Keep the pixel offset within the byte.
  $AE32,$02 Jump to #R$AE65 if the sprite is on a byte boundary.
N $AE34 The sprite is not on a byte boundary, so shift it using the shift
. tables.
  $AE34,$02,b$01 Make the offset the high byte of the address of a shift table.
  $AE36,$01 Point #REGh at the shift table.
  $AE37,$01 Fetch the number of rows.
@ $AE38 label=DrawMenuSprite_ShiftedRow
  $AE38,$01 Keep the number of rows in the alternate accumulator.
  $AE39,$01 Fetch the indexes for a row.
  $AE3A,$01 Copy the first index into #REGl.
  $AE3B,$01 Fetch the shifted first byte.
  $AE3C,$01 Write it to the screen.
  $AE3D,$01 Move to the next byte.
  $AE3E,$01 Point #REGh at the overflow table.
  $AE3F,$01 Fetch the overflow of the first byte.
  $AE40,$01 Point #REGh back at the shift table.
  $AE41,$01 Copy the second index into #REGl.
  $AE42,$01 Combine it with the shifted second byte.
  $AE43,$01 Write the second byte to the screen.
  $AE44,$01 Move to the next byte.
  $AE45,$01 Point #REGh at the overflow table.
  $AE46,$01 Fetch the overflow of the second byte.
  $AE47,$01 Point #REGh back at the shift table.
  $AE48,$01 Write it to the screen.
  $AE49,$02 Move back to the first byte.
  $AE4B,$01 Move up a pixel row.
  $AE4C,$01 Fetch the pixel row.
  $AE4D,$01 Add one.
  $AE4E,$02,b$01 Check whether the row is the last in a character cell.
  $AE50,$02 Jump to #R$AE5C unless it is.
  $AE52,$01 Fetch the low byte of the screen address.
  $AE53,$02 Move up a character row.
  $AE55,$01 Keep the low byte of the screen address.
  $AE56,$02 Jump to #R$AE5C unless that moves up into the next third of the
. screen.
  $AE58,$01 Fetch the high byte of the screen address.
  $AE59,$02 Move up to the previous third of the screen.
  $AE5B,$01 Keep the high byte of the screen address.
@ $AE5C label=DrawMenuSprite_ShiftedNext
  $AE5C,$01 Fetch the number of rows.
  $AE5D,$01 Count it down.
  $AE5E,$02 Loop back until every row has been drawn.
@ $AE60 label=DrawMenuSprite_Done
  $AE60,$04 Restore the stack pointer.
  $AE64,$01 Return.
N $AE65 The sprite is on a byte boundary, so copy the bytes straight to the
. screen.
@ $AE65 label=DrawMenuSprite_Aligned
  $AE65,$01 Swap the number of rows into #REGa.
  $AE66,$01 Keep the number of rows in #REGb.
  $AE67,$01 Swap the screen address into #REGhl.
@ $AE68 label=DrawMenuSprite_AlignedRow
  $AE68,$01 Fetch two bytes.
  $AE69,$01 Write the first byte to the screen.
  $AE6A,$01 Move to the next byte.
  $AE6B,$01 Write the second byte to the screen.
  $AE6C,$01 Move back to the first byte.
  $AE6D,$01 Move up a pixel row.
  $AE6E,$01 Fetch the pixel row.
  $AE6F,$01 Add one.
  $AE70,$02,b$01 Check whether the row is the last in a character cell.
  $AE72,$02 Jump to #R$AE7E unless it is.
  $AE74,$01 Fetch the low byte of the screen address.
  $AE75,$02 Move up a character row.
  $AE77,$01 Keep the low byte of the screen address.
  $AE78,$02 Jump to #R$AE7E unless that moves up into the next third of the
. screen.
  $AE7A,$01 Fetch the high byte of the screen address.
  $AE7B,$02 Move up to the previous third of the screen.
  $AE7D,$01 Keep the high byte of the screen address.
@ $AE7E label=DrawMenuSprite_AlignedNext
  $AE7E,$02 Loop back until every row has been drawn.
  $AE80,$02 Jump to #R$AE60.

c $AE82 Wait For A While
@ $AE82 label=WaitForAWhile
D $AE82 Waits by calling #R$AE88 several times. #REGhl is zero after the first
. call, so every call after the first counts down #N$10000 times.
R $AE82 B The number of delays
R $AE82 HL The length of the first delay
  $AE82,$03 Count down.
  $AE85,$02 Loop back until the delays are over.
  $AE87,$01 Return.

c $AE88 Wait
@ $AE88 label=Wait
D $AE88 Waits by counting a register pair down to zero.
R $AE88 HL The count
  $AE88,$01 Subtract one from the count.
  $AE89,$04 Jump to #R$AE88 if the count is not zero.
  $AE8D,$01 Return.

c $AE8E Fill Attribute Column
@ $AE8E label=FillAttributeColumn
D $AE8E Sets the attributes of one column of the screen, which is twenty four
. cells.
R $AE8E C The attribute
R $AE8E HL The address of the attribute at the top of the column
  $AE8E,$02 Set the number of rows.
  $AE90,$03 Set the distance between rows.
@ $AE93 label=FillAttributeColumn_Loop
  $AE93,$01 Set the attribute of the cell.
  $AE94,$01 Move down a row.
  $AE95,$02 Loop back until every row has been done.
  $AE97,$01 Return.

c $AE98 Play Static
@ $AE98 label=PlayStatic
D $AE98 Plays a burst of noise by using the first #N$80 bytes of the ROM as the
. length of each pulse.
.
. #HTML(#AUDIO0(static-sound.wav)(#INCLUDE(StaticSound)))
  $AE98,$03 Point #REGhl at the start of the ROM.
  $AE9B,$02 Set the number of pulses.
@ $AE9D label=PlayStatic_Loop
  $AE9D,$01 Fetch a byte of the ROM.
  $AE9E,$01 Move on to the next byte.
  $AE9F,$02,b$01 Keep the bottom six bits.
  $AEA1,$01 Use them as the length of the pulse.
  $AEA2,$03 Play the pulse.
  $AEA5,$01 Count down the pulses.
  $AEA6,$02 Loop back until all of the pulses have been played.
  $AEA8,$01 Return.

c $AEA9 Play Sound Effect
@ $AEA9 label=PlaySoundEffect
D $AEA9 Called every frame. Plays the next note of the sound effect which is in
. progress, if there is one. The effects are started by setting #R$A23C to the
. number of notes and #R$A23D to the address one byte before the notes. The
. notes are played from the last to the first, and each is the length of a
. pulse, so a bigger number is a lower note.
.
. The sound effects played by this routine are:
. #TABLE(default,centre,centre)
. { =h Effect | =h Sound }
. { Horse Sound |
. #HTML(#AUDIO0(horse-sound.wav)(#INCLUDE(HorseSound))) }
. { Money Bag Sound |
. #HTML(#AUDIO0(money-bag-sound.wav)(#INCLUDE(MoneyBagSound))) }
. { Bag Hit Sound |
. #HTML(#AUDIO0(bag-hit-sound.wav)(#INCLUDE(BagHitSound))) }
. TABLE#
  $AEA9,$03 Point #REGhl at the number of notes left.
  $AEAC,$01 Fetch the number of notes left.
  $AEAD,$01 Test whether the effect is over.
  $AEAE,$01 Return if it is.
  $AEAF,$01 Count down the notes.
  $AEB0,$01 Move on to the address of the notes.
  $AEB1,$01 Fetch the low byte of the address.
  $AEB2,$01 Move on to the high byte.
  $AEB3,$01 Fetch the high byte of the address.
  $AEB4,$01 Swap the address into #REGhl.
  $AEB5,$03 Point #REGhl at the note.
  $AEB8,$01 Fetch the note.
  $AEB9,$01 Use it as the length of a pulse.
  $AEBA,$02 Set the number of pulses.
  $AEBC,$03 Play the note.

b $AEBF Sound Effect Notes
@ $AEBF label=SoundEffectNotes
D $AEBF The notes of the sound effects. The notes of each effect are played from
. the end back to the start. The first byte is not used.
B $AEBF,$01,$01 Not used.
B $AEC0,$07,$07 The first seven notes for #R$A9BF (the horse).
@ $AEC7 label=SoundEffectNotes_BeforeMoneyBag
B $AEC7,$01,$01 The last note, which is played first.
B $AEC8,$07,$07 The first seven notes for #R$A4C9 (the money bag).
@ $AECF label=SoundEffectNotes_BeforeBag
B $AECF,$01,$01 The last note, which is played first.
B $AED0,$03,$03 The first three notes for #R$C8B8. The fourth note, which is
. played first, is the first byte of the next routine.

c $AED3 Play Footstep Sound
@ $AED3 label=PlayFootstepSound
D $AED3 Plays a burst of noise when a walking figure puts a foot down, which is
. when bits 0 and 1 of the flags of the object have both just become set.
.
. #HTML(#AUDIO0(footstep-sound.wav)(#INCLUDE(FootstepSound)))
R $AED3 A The flags of the object before it was moved
R $AED3 IX The address of the object
  $AED3,$02 Test bit 0 of the old flags.
  $AED5,$01 Return if it was already set.
  $AED6,$05 Return if bit 0 of the flags is not set now.
  $AEDB,$05 Return if bit 1 of the flags is not set now.
  $AEE0,$02 Set the number of pulses.
@ $AEE2 label=PlayFootstepSound_Loop
  $AEE2,$01 Fetch the number of the pulse.
  $AEE3,$02,b$01 Change it to make a different length for each pulse.
  $AEE5,$01 Use it as the length of the pulse.
  $AEE6,$03 Play the pulse.
  $AEE9,$01 Count down the pulses.
  $AEEA,$02 Loop back until all of the pulses have been played.
  $AEEC,$01 Return.

c $AEED Play Movement Sound
@ $AEED label=PlayMovementSound
D $AEED Plays a tone every few frames while a figure is moving, and alternates
. between a high and a low tone. A figure which is going slowly makes the sound
. every fourth frame, and a figure which is going fast every other frame.
.
. The sounds played by this routine are:
. #TABLE(default,centre,centre)
. { =h Speed | =h Sound }
. { Slow Movement Sound |
. #HTML(#AUDIO0(slow-movement-sound.wav)(#INCLUDE(SlowMovementSound))) }
. { Fast Movement Sound |
. #HTML(#AUDIO0(fast-movement-sound.wav)(#INCLUDE(FastMovementSound))) }
. TABLE#
E $AEED View the equivalent code in;
. #LIST
. { #NIGHTSHADE$C400 }
. LIST#
R $AEED IX The address of the object
  $AEED,$03 Point #REGhl at the sound counter.
  $AEF0,$01 Add one to the counter.
  $AEF1,$03 Fetch the speed of the object.
  $AEF4,$04 Jump to #R$AF0D if the speed is #N$0C or more.
  $AEF8,$01 Fetch the counter.
  $AEF9,$04 Jump to #R$AF05 unless bit 2 of the counter is set.
  $AEFD,$03,b$01 Return unless this is every fourth frame.
  $AF00,$03 Choose the high tone.
  $AF03,$02 Play it.
N $AF05 Play the low tone of a slow movement.
@ $AF05 label=PlayMovementSound_Low
  $AF05,$03,b$01 Return unless this is every fourth frame.
  $AF08,$03 Choose the low tone.
  $AF0B,$02 Play it.
N $AF0D Play a tone every other frame when the object is going fast.
@ $AF0D label=PlayMovementSound_Fast
  $AF0D,$01 Fetch the counter.
  $AF0E,$04 Jump to #R$AF1A unless bit 1 of the counter is set.
  $AF12,$03,b$01 Return unless this is every other frame.
  $AF15,$03 Choose the high tone.
  $AF18,$02 Play it.
N $AF1A Play the low tone of a fast movement.
@ $AF1A label=PlayMovementSound_FastLow
  $AF1A,$03,b$01 Return unless this is every other frame.
  $AF1D,$03 Choose the low tone.
  $AF20,$02 Play it.

c $AF22 Play Buzz
@ $AF22 label=PlayBuzz
D $AF22 Plays a short, rough buzz made of twelve pulses of different lengths.
.
. #HTML(#AUDIO0(buzz-sound.wav)(#INCLUDE(BuzzSound)))
E $AF22 View the equivalent code in;
. #LIST
. { #MARTIANOIDS$C04E }
. { #NIGHTSHADE$C3AA }
. { #PENTAGRAM$D5E4 }
. { #SABREWULF$BF2F }
. LIST#
  $AF22,$02 Set the number of pulses.
@ $AF24 label=PlayBuzz_Loop
  $AF24,$01 Fetch the number of the pulse.
  $AF25,$02,b$01 Change it.
  $AF27,$01 Add it to the number of the pulse.
  $AF28,$01 Use it as the length of the pulse.
  $AF29,$03 Play the pulse.
  $AF2C,$01 Count down the pulses.
  $AF2D,$02 Loop back until all of the pulses have been played.
  $AF2F,$01 Return.

c $AF30 Play Rumble
@ $AF30 label=PlayRumble
D $AF30 Plays sixteen short tones, using the first sixteen bytes of the ROM as
. the length of each.
.
. #HTML(#AUDIO0(rumble-sound.wav)(#INCLUDE(RumbleSound)))
  $AF30,$03 Point #REGhl at the start of the ROM.
  $AF33,$02 Set the number of tones.
@ $AF35 label=PlayRumble_Loop
  $AF35,$01 Fetch a byte of the ROM.
  $AF36,$01 Move on to the next byte.
  $AF37,$02,b$01 Keep the bottom seven bits.
  $AF39,$01 Use them as the length of a pulse.
  $AF3A,$02 Set the number of pulses.
  $AF3C,$03 Play the tone.
  $AF3F,$01 Count down the tones.
  $AF40,$02 Loop back until all of the tones have been played.
  $AF42,$01 Return.

c $AF43 Play Typing Sound
@ $AF43 label=PlayTypingSound
D $AF43 Plays a short, medium tone.
.
. #HTML(#AUDIO0(typing-sound.wav)(#INCLUDE(TypingSound)))
  $AF43,$02 Set the number of pulses.
  $AF45,$02 Set the length of a pulse.
  $AF47,$02 Play the tone.

c $AF49 Play Pause Sound
@ $AF49 label=PlayPauseSound
D $AF49 Plays a longer, low tone.
.
. #HTML(#AUDIO0(pause-sound.wav)(#INCLUDE(PauseSound)))
  $AF49,$02 Set the number of pulses.
  $AF4B,$02 Set the length of a pulse.
  $AF4D,$02 Play the tone.

c $AF4F Play Short Tone
@ $AF4F label=PlayShortTone
D $AF4F Plays a short tone. The higher the number, the higher the tone.
.
. The sounds played by this routine are:
. #TABLE(default,centre,centre)
. { =h Effect | =h Sound }
. { Sheriff Entrance Sound |
. #HTML(#AUDIO0(sheriff-entrance-sound.wav)(#INCLUDE(SheriffEntranceSound))) }
. { Dying Sound |
. #HTML(#AUDIO0(dying-sound.wav)(#INCLUDE(DyingSound))) }
. TABLE#
R $AF4F A The number
  $AF4F,$02 Multiply the number by four.
  $AF51,$01 Invert it.
  $AF52,$01 Use it as the length of a pulse.
  $AF53,$02 Set the number of pulses.
  $AF55,$02 Play the tone.

c $AF57 Play Bullet Sound
@ $AF57 label=PlayBulletSound
D $AF57 Plays a short tone which gets lower as a menu bullet moves to the right.
.
. #HTML(#AUDIO0(bullet-sound.wav)(#INCLUDE(BulletSound)))
E $AF57 Continue on to #R$AF5F.
R $AF57 IX The address of the menu entry
  $AF57,$03 Fetch the horizontal position of the bullet.
  $AF5A,$02 Subtract #N$40.
  $AF5C,$01 Use it as the length of a pulse.
  $AF5D,$02 Set the number of pulses.

c $AF5F Play Wave Sequence
@ $AF5F label=PlayWaveSequence
D $AF5F Plays a tone.
E $AF5F View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B6FB }
. { #KNIGHTLORE$B4E6 }
. { #MARTIANOIDS$C05B }
. { #PENTAGRAM$D67B }
. LIST#
R $AF5F B The length of a pulse
R $AF5F C The number of pulses
  $AF5F,$03 Play a pulse.
  $AF62,$01 Count down the pulses.
  $AF63,$02 Loop back until all of the pulses have been played.
  $AF65,$01 Return.

c $AF66 Play Square Wave
@ $AF66 label=PlaySquareWave
D $AF66 Plays one pulse, which is a high and a low half of the same length, by
. toggling the speaker. #REGb is unchanged.
E $AF66 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B702 }
. { #BUBBLER$9E93 }
. { #CYBERUN$71E0 }
. { #KNIGHTLORE$B4ED }
. { #MARTIANOIDS$C062 }
. { #NIGHTSHADE$C471 }
. { #PENTAGRAM$D682 }
. LIST#
R $AF66 B The length of the pulse
  $AF66,$02 Set the speaker bit.
  $AF68,$02 Turn the speaker on.
  $AF6A,$01 Keep the length of the pulse in #REGa.
@ $AF6B label=PlaySquareWave_FirstDelay
  $AF6B,$02 Wait for the length of the pulse.
  $AF6D,$01 Restore the length of the pulse.
  $AF6E,$01 Clear the speaker bit.
  $AF6F,$02 Turn the speaker off.
  $AF71,$01 Keep the length of the pulse in #REGa.
@ $AF72 label=PlaySquareWave_SecondDelay
  $AF72,$02 Wait for the length of the pulse.
  $AF74,$01 Restore the length of the pulse.
  $AF75,$01 Return.

c $AF76 Play Music Once
@ $AF76 label=PlayMusicOnce
D $AF76 Plays a tune once, and stops early if a key is pressed. After the tune
. has been played, nothing happens until #R$A242 is cleared.
.
. The tunes played by this routine are:
. #TABLE(default,centre,centre)
. { =h Tune | =h Sound }
. { Title Tune |
. #HTML(#AUDIO0(title-tune.wav)(#INCLUDE(TitleTune))) }
. { Game Over Tune |
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune))) }
. TABLE#
E $AF76 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4A1 }
. { #KNIGHTLORE$B2B6 }
. { #MARTIANOIDS$C0B6 }
. { #NIGHTSHADE$C63D }
. { #PENTAGRAM$D69C }
. LIST#
R $AF76 DE The address of the tune
  $AF76,$03 Point #REGhl at the flag which says whether the tune has been
. played.
  $AF79,$01 Fetch the flag.
  $AF7A,$02 Return if the tune has already been played.
  $AF7C,$02 Set the flag.
@ $AF7E label=PlayMusicOnce_Loop
  $AF7E,$04 Read every row of the keyboard.
  $AF82,$02 Jump to #R$AF85 if no key is pressed.
  $AF84,$01 Return.
N $AF85 Play the next note.
@ $AF85 label=PlayMusicOnce_NextNote
  $AF85,$01 Fetch the next note.
  $AF86,$04 Jump to #R$AF99 if the terminator has been reached.
  $AF8A,$03 Play the note.
  $AF8D,$02 Go back for the next note.

c $AF8F Play Music
@ $AF8F label=PlayMusic
D $AF8F Plays a tune, which is a list of notes ending with #N$FF.
.
. The tunes played by this routine are:
. #TABLE(default,centre,centre)
. { =h Tune | =h Sound }
. { Start Game Tune |
. #HTML(#AUDIO0(start-game-tune.wav)(#INCLUDE(StartGameTune))) }
. { Reward Tune |
. #HTML(#AUDIO0(reward-tune.wav)(#INCLUDE(RewardTune))) }
. { Outlaw Shot Tune |
. #HTML(#AUDIO0(outlaw-shot-tune.wav)(#INCLUDE(OutlawShotTune))) }
. { Fanfare Tune |
. #HTML(#AUDIO0(fanfare-tune.wav)(#INCLUDE(FanfareTune))) }
. TABLE#
E $AF8F View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4BA }
. { #BUBBLER$A1C1 }
. { #CYBERUN$9AA9 }
. { #KNIGHTLORE$B2CF }
. { #MARTIANOIDS$C0CF }
. { #NIGHTSHADE$C656 }
. { #PENTAGRAM$D6B5 }
. LIST#
R $AF8F DE The address of the tune
  $AF8F,$01 Fetch the next note.
  $AF90,$04 Jump to #R$AF99 if the terminator has been reached.
  $AF94,$03 Play the note.
  $AF97,$02 Go back for the next note.
@ $AF99 label=PlayMusic_Finish
  $AF99,$01 Return.

c $AF9A Play Note
@ $AF9A label=PlayNote
D $AF9A Plays a note of a tune, or a rest. Bits 0 to 5 of the byte are the
. number of the note (#N$00 is a rest), and bits 6 and 7 are one less than the
. length of the note in beats. The pitch of each note comes from the table at
. #R$AFF2, in which a note has three bytes: the low and high bytes of the length
. of each half of a pulse, and the number of pulses in a beat.
E $AF9A View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4C5 }
. { #BUBBLER$A1CC }
. { #CYBERUN$9AB4 }
. { #KNIGHTLORE$B2DA }
. { #MARTIANOIDS$C0DA }
. { #NIGHTSHADE$C661 }
. { #PENTAGRAM$D6C0 }
. LIST#
R $AF9A DE The address of the note
R $AF9A O:DE The address of the next note
  $AF9A,$02,b$01 Keep the number of the note.
  $AF9C,$02 Play a rest if there is no note.
N $AF9E Look up the delays and the number of cycles in the table at #R$AFF2.
  $AF9E,$03 Copy the number into #REGhl.
  $AFA1,$01 Double the number.
  $AFA2,$03 Add the number again to treble it.
  $AFA5,$04 Point #REGhl at the entry for the note.
  $AFA9,$01 Fetch the low byte of the half-period.
  $AFAA,$01 Move on to the high byte.
  $AFAB,$01 Fetch the high byte of the half-period.
  $AFAC,$01 Move on to the number of pulses in a beat.
  $AFAD,$01 Fetch the number of pulses in a beat.
  $AFAE,$02 Clear #REGh.
N $AFB0 Bits 6 and 7 of the note are the length, less one.
  $AFB0,$01 Fetch the note again.
  $AFB1,$02 Rotate the length bits into the bottom of the byte.
  $AFB3,$02,b$01 Keep them.
  $AFB5,$01 Add one to get the length in beats.
  $AFB6,$01 Stash the address of the note on the stack.
  $AFB7,$02 Copy the number of pulses into #REGde.
N $AFB9 Multiply the number of cycles by the length of the note.
@ $AFB9 label=PlayNote_Multiply
  $AFB9,$01 Count down the beats.
  $AFBA,$02 Finish multiplying when the beats are used up.
  $AFBC,$01 Add the number of pulses for another beat.
  $AFBD,$02 Go back to count the next beat.
N $AFBF The number of cycles now matches the length of the note.
@ $AFBF label=PlayNote_MultiplyDone
  $AFBF,$01 Retrieve the address of the note.
N $AFC0 Each pass of this loop makes one cycle of the note, so the length of
. the note is the number of cycles.
@ $AFC0 label=PlayNote_Cycle
  $AFC0,$01 Stash the half-period on the stack.
  $AFC1,$01 Clear the speaker bit.
  $AFC2,$02 Turn the speaker off.
@ $AFC4 label=PlayNote_OffDelay
  $AFC4,$02 Wait for the low half of the pulse.
  $AFC6,$01 Count down the high byte of the half-period.
  $AFC7,$02 Loop back until the low half is over.
  $AFC9,$01 Retrieve the half-period.
  $AFCA,$01 Stash the half-period on the stack again.
  $AFCB,$02 Set the speaker bit.
  $AFCD,$02 Turn the speaker on.
@ $AFCF label=PlayNote_OnDelay
  $AFCF,$02 Wait for the high half of the pulse.
  $AFD1,$01 Count down the high byte of the half-period.
  $AFD2,$02 Loop back until the high half is over.
  $AFD4,$01 Retrieve the half-period.
  $AFD5,$01 Count down the pulses.
  $AFD6,$04 Jump to #R$AFC0 if any pulses are left.
  $AFDA,$01 Move on to the next note.
  $AFDB,$01 Return.

c $AFDC Play Rest
@ $AFDC label=PlayRest
D $AFDC Waits for the length of a rest, which is one to four beats.
E $AFDC View the equivalent code in;
. #LIST
. { #BUBBLER$A20F }
. { #MARTIANOIDS$C11C }
. LIST#
R $AFDC DE The address of the rest
R $AFDC O:DE The address after the rest
  $AFDC,$01 Fetch the rest.
  $AFDD,$01 Move on to the next note.
  $AFDE,$02 Rotate the length bits into the bottom of the byte.
  $AFE0,$02,b$01 Keep them.
  $AFE2,$01 Add one to get the length in beats.
  $AFE3,$01 Copy the length into #REGl.
  $AFE4,$03 Set the length of a beat.
@ $AFE7 label=PlayRest_Beat
  $AFE7,$01 Stash the length of a beat on the stack.
@ $AFE8 label=PlayRest_Wait
  $AFE8,$01 Count down.
  $AFE9,$04 Jump to #R$AFE8 if the count is not zero.
  $AFED,$01 Retrieve the length of a beat.
  $AFEE,$01 Count down the beats.
  $AFEF,$02 Loop back until the rest is over.
  $AFF1,$01 Return.

g $AFF2 Note Table
@ $AFF2 label=NoteTable
D $AFF2 The table of notes used by #R$AF9A. Each note has three bytes: the low
. and high bytes of the length of each half of a pulse, and the number of pulses
. in a beat. Note #N$00 is a rest.
B $AFF2,$B7,$03

b $B0A9 Reward Tune
@ $B0A9 label=RewardTune
D $B0A9 The tune which is played when the player is given the reward for the
. outlaw. Each byte is a note: bits 0 to 5 are the number of the note in #R$AFF2
. (#N$00 is a rest) and bits 6 and 7 are one less than the length. #N$FF ends
. the tune.
.
. #HTML(#AUDIO0(reward-tune.wav)(#INCLUDE(RewardTune)))
B $B0A9,$20,$08

b $B0C9 Start Game Tune
@ $B0C9 label=StartGameTune
D $B0C9 The tune which is played when the game is started from the title screen.
.
. #HTML(#AUDIO0(start-game-tune.wav)(#INCLUDE(StartGameTune)))
B $B0C9,$0A,$0A

b $B0D3 Title Tune
@ $B0D3 label=TitleTune
D $B0D3 The tune which is played on the title screen once all of the options
. have been typed.
.
. #HTML(#AUDIO0(title-tune.wav)(#INCLUDE(TitleTune)))
B $B0D3,$E2,$10

b $B1B5 Outlaw Shot Tune
@ $B1B5 label=OutlawShotTune
D $B1B5 The tune which is played when the outlaw has been shot.
.
. #HTML(#AUDIO0(outlaw-shot-tune.wav)(#INCLUDE(OutlawShotTune)))
B $B1B5,$1A,$08

b $B1CF Game Over Tune
@ $B1CF label=GameOverTune
D $B1CF The tune which is played on the game over screen, which stops if a key
. is pressed.
.
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
B $B1CF,$11,$08

b $B1E0 Fanfare Tune
@ $B1E0 label=FanfareTune
D $B1E0 A fanfare, which is played when the top score has been beaten and before
. a bonus stage of falling money bags.
.
. #HTML(#AUDIO0(fanfare-tune.wav)(#INCLUDE(FanfareTune)))
B $B1E0,$14,$08

c $B1F4 Print Outlaw Name
@ $B1F4 label=PrintOutlawName
D $B1F4 Prints the name of the outlaw who is wanted at the current level on the
. wanted poster. The name has two parts, printed on two lines. Each part is
. centred.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D3CE)
. #SIM(start=$D3CE,stop=$D3D1)
. #SCR$03,$00,$04,$08,$02(outlaw-name) } UDGTABLE# #POPS
N $B1F4 Find the two parts of the name.
  $B1F4,$03 Point #REGhl at the table of names.
  $B1F7,$03 Fetch the level.
  $B1FA,$01 Double it, as there are two parts for each level.
  $B1FB,$01 Keep the doubled level in #REGb, one part per level.
  $B1FC,$02 Jump to #R$B205 if this is the first level.
@ $B1FE label=PrintOutlawName_Skip
  $B1FE,$02 Test whether this is the last character of a part.
  $B200,$01 Move on to the next character.
  $B201,$02 Loop back until the end of the part.
  $B203,$02 Loop back until the right parts have been reached.
@ $B205 label=PrintOutlawName_Found
  $B205,$03 Copy #REGhl to #REGiy (using the stack).
N $B208 Print the first part.
  $B208,$03 Point #REGde at #N$4083 (in the screen buffer).
  $B20B,$03 Call #R$B211 to print it.
N $B20E Print the second part.
  $B20E,$03 Point #REGde at #N$40A3 (in the screen buffer).
N $B211 Print a part of the name, centred on the screen address in #REGde. If
. the part has an even number of characters it is centred exactly, and otherwise
. it is half a character to the right, using a table which shifts a row of
. pixels right by four.
@ $B211 label=PrintOutlawName_Part
  $B211,$03 Copy #REGiy to #REGhl (using the stack).
  $B214,$01 Set the number of characters to zero.
@ $B215 label=PrintOutlawName_Count
  $B215,$04 Jump to #R$B21D if this is the last character.
  $B219,$01 Move on to the next character.
  $B21A,$01 Add one to the number of characters.
  $B21B,$02 Go back to check the next character.
@ $B21D label=PrintOutlawName_Centre
  $B21D,$01 Stash the number of characters, less one, on the stack.
  $B21E,$01 Invert it.
  $B21F,$02,b$01 Keep bit 0.
  $B221,$03 Store it, which is one if there is an odd number of characters.
  $B224,$01 Retrieve the number of characters.
  $B225,$02 Halve it.
  $B227,$02 Negate it.
  $B229,$01 Add the horizontal position of the screen address.
  $B22A,$01 Move to the left by half the length.
N $B22B Print the next character.
@ $B22B label=PrintOutlawName_Character
  $B22B,$03 Fetch the character.
  $B22E,$02,b$01 Remove the terminator.
  $B230,$03 Convert the character to the number of its tile.
  $B233,$01 Copy the number into #REGl.
  $B234,$02 Clear #REGh.
  $B236,$03 Multiply it by eight.
  $B239,$03 Point #REGbc at #R$8EA8.
  $B23C,$01 Find the pixels of the character.
  $B23D,$01 Swap the pixels into #REGde and the screen address into #REGhl.
  $B23E,$03 Fetch the flag.
  $B241,$03 Jump to #R$B26A if there is an even number of characters.
N $B244 There is an odd number of characters, so shift each character four
. pixels to the right across two cells.
  $B244,$02 Point #REGb at the table which shifts a byte by four pixels.
  $B246,$02 Set the number of rows to eight.
@ $B248 label=PrintOutlawName_ShiftedRow
  $B248,$01 Keep the number of rows in the alternate accumulator.
  $B249,$01 Fetch a row of pixels.
  $B24A,$01 Move on to the next row.
  $B24B,$01 Use them as an index into the table.
  $B24C,$01 Fetch the left part of the shifted byte.
  $B24D,$01 Combine it with the screen.
  $B24E,$01 Write it to the screen.
  $B24F,$01 Move across to the next cell.
  $B250,$01 Point #REGb at the other half of the table.
  $B251,$01 Fetch the right part of the shifted byte.
  $B252,$01 Point #REGb back at the first half of the table.
  $B253,$01 Combine it with the screen.
  $B254,$01 Write it to the screen.
  $B255,$01 Move back to the first cell.
  $B256,$01 Move down a pixel row.
  $B257,$01 Fetch the number of rows.
  $B258,$01 Count down the rows.
  $B259,$02 Loop back until all eight rows have been drawn.
@ $B25B label=PrintOutlawName_Next
  $B25B,$01 Fetch the high byte of the screen address.
  $B25C,$02 Move back up to the top of the character.
  $B25E,$01 Keep the high byte of the screen address.
  $B25F,$01 Move across to the next cell.
  $B260,$02 Move on to the next character.
  $B262,$01 Swap the screen address into #REGde.
  $B263,$04 Test whether this was the last character.
  $B267,$01 Return if it was.
  $B268,$02 Go back for the next character.
N $B26A There is an even number of characters, so copy each character to the
. screen.
@ $B26A label=PrintOutlawName_Aligned
  $B26A,$02 Set the number of rows to eight.
@ $B26C label=PrintOutlawName_AlignedRow
  $B26C,$01 Fetch a row of pixels.
  $B26D,$01 Move on to the next row.
  $B26E,$01 Combine it with the screen.
  $B26F,$01 Write it to the screen.
  $B270,$01 Move down a pixel row.
  $B271,$02 Loop back until all eight rows have been drawn.
  $B273,$02 Go back to finish the character.

c $B275 Count Down Delay
@ $B275 label=CountDownDelay
D $B275 Counts down byte #N$0D of an object by two. When it goes below zero it
. is set to a new value, and so a figure which calls this routine gets an event
. every few frames.
R $B275 A The new value
R $B275 IX The address of the object
  $B275,$03 Count down byte #N$0D.
  $B278,$03 Count it down again.
  $B27B,$01 Return if it has not gone below zero.
  $B27C,$03 Set it to the new value.
  $B27F,$01 Return.

c $B280 Draw Wide Sprites
@ $B280 label=DrawWideSprites
D $B280 Draws several wide sprites one after another.
R $B280 B The number of sprites
R $B280 DE The address of the list of sprite numbers
R $B280 HL The address in the buffer
  $B280,$01 Fetch the number of the next sprite.
  $B281,$01 Move on to the next sprite in the list.
  $B282,$01 Stash the number of sprites on the stack.
  $B283,$01 Stash the address of the list on the stack.
  $B284,$03 Draw the sprite.
  $B287,$01 Retrieve the address of the list.
  $B288,$01 Retrieve the number of sprites.
  $B289,$02 Loop back until all of the sprites have been drawn.
  $B28B,$01 Return.

c $B28C Draw Wide Sprite
@ $B28C label=DrawWideSprite
D $B28C Draws a sprite which is eight rows high and four bytes wide into a
. buffer which has twenty four bytes in each row. The pixels are combined with
. what is already in the buffer. The horizontal pixel position is in #R$A220: if
. it is not a multiple of eight, the sprite data is a list of indexes into the
. tables which shift a byte by two, four or six pixels, and the sprite takes
. five bytes in each row of the buffer. The routine takes the data from the
. stack to make it faster.
R $B28C A The number of the sprite
R $B28C HL The address in the buffer
N $B28C Find the data of the sprite.
  $B28C,$01 Swap the address in the buffer into #REGde.
  $B28D,$03 Point #REGbc at #R$6AC6.
  $B290,$03 Point #REGhl at the data of the sprite.
  $B293,$04 Save the stack pointer.
  $B297,$01 Point the stack pointer at the data.
  $B298,$01 Swap the address in the buffer back into #REGhl.
  $B299,$03 Fetch the horizontal pixel position.
  $B29C,$02,b$01 Keep the offset within the byte.
  $B29E,$02 Jump to #R$B2D6 if the sprite is on a byte boundary.
N $B2A0 The sprite is not on a byte boundary, so shift it using the shift
. tables.
  $B2A0,$02,b$01 Make the offset the high byte of the address of a shift table.
  $B2A2,$01 Point #REGd at the shift table.
  $B2A3,$02 Set the number of rows to eight.
@ $B2A5 label=DrawWideSprite_ShiftedRow
  $B2A5,$01 Keep the number of rows in the alternate accumulator.
  $B2A6,$01 Fetch the indexes for the first two bytes of a row.
  $B2A7,$01 Copy the first index into #REGe.
  $B2A8,$01 Fetch the shifted first byte.
  $B2A9,$01 Combine it with the buffer.
  $B2AA,$01 Write it to the buffer.
  $B2AB,$01 Move on to the second byte.
  $B2AC,$01 Point #REGd at the overflow table.
  $B2AD,$01 Fetch the overflow of the first byte.
  $B2AE,$01 Point #REGd back at the shift table.
  $B2AF,$01 Copy the second index into #REGe.
  $B2B0,$01 Swap the buffer address into #REGde.
  $B2B1,$01 Combine the overflow with the shifted second byte.
  $B2B2,$01 Write it to the buffer.
  $B2B3,$01 Move on to the third byte.
  $B2B4,$01 Point #REGh at the overflow table.
  $B2B5,$01 Fetch the overflow of the second byte.
  $B2B6,$01 Point #REGh back at the shift table.
  $B2B7,$01 Fetch the indexes for the next two bytes of the row.
  $B2B8,$01 Copy the third index into #REGl.
  $B2B9,$01 Combine the third byte with the buffer.
  $B2BA,$01 Write it to the buffer.
  $B2BB,$01 Move on to the fourth byte.
  $B2BC,$01 Point #REGh at the overflow table.
  $B2BD,$01 Fetch the overflow of the third byte.
  $B2BE,$01 Point #REGh back at the shift table.
  $B2BF,$01 Copy the fourth index into #REGl.
  $B2C0,$01 Combine it with the shifted fourth byte.
  $B2C1,$01 Write it to the buffer.
  $B2C2,$01 Move on to the fifth byte.
  $B2C3,$01 Point #REGh at the overflow table.
  $B2C4,$01 Swap the buffer address into #REGhl.
  $B2C5,$01 Fetch the overflow of the fourth byte.
  $B2C6,$01 Combine it with the buffer.
  $B2C7,$01 Write it to the buffer.
  $B2C8,$01 Point #REGd back at the shift table.
  $B2C9,$03 Set the distance to the next row of the buffer.
  $B2CC,$01 Move on to the next row.
  $B2CD,$01 Fetch the number of rows.
  $B2CE,$01 Count down the rows.
  $B2CF,$02 Loop back until all eight rows have been drawn.
@ $B2D1 label=DrawWideSprite_Done
  $B2D1,$04 Restore the stack pointer.
  $B2D5,$01 Return.
N $B2D6 The sprite is on a byte boundary, so copy the bytes straight to the
. buffer.
@ $B2D6 label=DrawWideSprite_Aligned
  $B2D6,$02 Set the number of rows to eight.
@ $B2D8 label=DrawWideSprite_AlignedRow
  $B2D8,$01 Fetch two bytes of the row.
  $B2D9,$01 Write the first to the buffer.
  $B2DA,$01 Move on to the second byte.
  $B2DB,$01 Write the second to the buffer.
  $B2DC,$01 Move on to the third byte.
  $B2DD,$01 Fetch two more bytes of the row.
  $B2DE,$01 Write the third to the buffer.
  $B2DF,$01 Move on to the fourth byte.
  $B2E0,$01 Write the fourth to the buffer.
  $B2E1,$03 Set the distance to the next row of the buffer.
  $B2E4,$01 Move on to the next row.
  $B2E5,$02 Loop back until all eight rows have been drawn.
  $B2E7,$02 Jump to #R$B2D1.

c $B2E9 Finish Town Stage
@ $B2E9 label=FinishTownStage
D $B2E9 Called every frame in the town. When the outlaw has been shot (#R$A20A
. is one) it plays a tune, clears all the objects and goes on to the duel with
. the outlaw. The player is given a life to make up for the one which is taken
. when the next stage starts.
  $B2E9,$03 Point #REGhl at the outlaw shot flag.
  $B2EC,$01 Fetch the flag.
  $B2ED,$03 Return if the outlaw has not just been shot.
  $B2F0,$01 Set the flag to two so that this does not happen again.
N $B2F1 Play the tune for shooting the outlaw.
  $B2F1,$06 Call #R$AF8F to play #R$B1B5.
  $B2F7,$03 Remove all of the objects.
  $B2FA,$04 Write #N$00 to #R$A267 so the next stage is outside the town.
  $B2FE,$03 Clear the flag at #R$A212.
  $B301,$06 Set one stage to play, of the kind which is the duel.
  $B307,$03 Point #REGhl at #R$A263.
  $B30A,$01 Add one to the number of lives, to make up for the one which the
. next stage takes.
  $B30B,$05 Write #N$01 to #R$A240 to show that a new stage is starting.
  $B310,$05 Write #COLOUR$45 to #R$A266.
  $B315,$03 Start the next stage.

c $B318 Create Direction Pointer
@ $B318 label=CreateDirectionPointer
D $B318 Called every frame in the town. Puts a pointing hand (an object of type
. #N$0B) in the sixth object slot, next to the sheriff, if the slot is free.
. #R$B347 makes it point towards the outlaw.
  $B318,$03 Point #REGde at the sixth object slot.
  $B31B,$01 Fetch the type of the object in the slot.
  $B31C,$02 Return if the slot is in use.
  $B31E,$03 Copy #REGde to #REGiy (using the stack).
  $B321,$03 Point #REGhl at #R$B337.
  $B324,$03 Set the size of an object slot in #REGbc.
  $B327,$02 Copy the template into the slot.
  $B329,$02 Set the distance from the sheriff to one cell.
  $B32B,$03 Place the pointer one cell away from the sheriff.
  $B32E,$01 Return if that cell is blocked.
  $B32F,$03 Set the position of the pointer within its cell.
  $B332,$04 Turn the slot into a pointer.
  $B336,$01 Return.

b $B337 Pointer Template
@ $B337 label=PointerTemplate
D $B337 The initial contents of a slot for a pointer. The final two bytes point
. to the sprite list.
B $B337,$0E,$08 Type, position, speed, size and counters.
W $B345,$02 The sprite list of a pointer.

c $B347 Handle Pointer
@ $B347 label=HandlePointer
D $B347 Type #N$0B: a pointing hand which hovers next to the sheriff and points
. to the outlaw. It works out whether the outlaw is further away across or up
. the screen, and which way, and so chooses one of two sprites and whether to
. flip it. It goes away when the sheriff is more than two cells away from it.
N $B347 Slow down the changes of sprite, and remove the pointer if it is too far
. from the sheriff.
  $B347,$02 Set the new value of the counter.
  $B349,$03 Count down the counter.
  $B34C,$02 Set the distance to two cells.
  $B34E,$03 Check how close the sheriff is.
  $B351,$03 Remove the pointer if the sheriff has moved away.
N $B354 Find how far away the outlaw is horizontally.
  $B354,$04 Point #REGiy at #R$A2BD.
  $B358,$03 Fetch the horizontal position of the outlaw.
  $B35B,$01 Swap it into #REGde.
  $B35C,$04 Point #REGiy at #R$A27D.
  $B360,$03 Fetch the horizontal position of the sheriff.
  $B363,$04 Fetch the view number and keep it in #REGb.
  $B367,$02 Set the direction flags to zero.
  $B369,$03 Subtract the horizontal position of the sheriff.
  $B36C,$02 Jump to #R$B372 if the outlaw is not to the left.
  $B36E,$03 Make the distance positive.
  $B371,$01 Set bit 0 of the direction flags.
N $B372 Find how far away the outlaw is vertically.
@ $B372 label=HandlePointer_Vertical
  $B372,$01 Stash the horizontal distance on the stack.
  $B373,$04 Point #REGiy at #R$A2BD.
  $B377,$03 Fetch the vertical position of the outlaw.
  $B37A,$01 Swap it into #REGde.
  $B37B,$04 Point #REGiy at #R$A27D.
  $B37F,$03 Fetch the vertical position of the sheriff.
  $B382,$03 Subtract the vertical position of the sheriff.
  $B385,$02 Jump to #R$B38C if the outlaw is not above.
  $B387,$03 Make the distance positive.
  $B38A,$02 Add two to the direction flags.
N $B38C Compare the two distances, and choose the sprite.
@ $B38C label=HandlePointer_Compare
  $B38C,$01 Retrieve the horizontal distance.
  $B38D,$03 Subtract it from the vertical distance.
  $B390,$02 Jump to #R$B3A4 if the outlaw is further away horizontally.
  $B392,$04 Do not flip the sprite.
  $B396,$01 Fetch the direction flags.
  $B397,$01 Invert them.
  $B398,$01 Move bit 1 into bit 0.
@ $B399 label=HandlePointer_ChooseSprite
  $B399,$02,b$01 Keep bit 0.
  $B39B,$01 Combine it with bit 0 of the view number.
  $B39C,$02 Add #N$30 to give the number of the sprite.
  $B39E,$03 Store it in the sprite list.
  $B3A1,$03 Check for bullets and the sheriff, and draw the pointer.
N $B3A4 The outlaw is further away horizontally, so flip the sprite.
@ $B3A4 label=HandlePointer_Flip
  $B3A4,$04 Flip the sprite.
  $B3A8,$01 Fetch the direction flags.
  $B3A9,$02 Choose the sprite.

b $B3AB Pointer Sprite List
@ $B3AB label=PointerSpriteList
D $B3AB The sprite list of a pointer. The sprite number, which is #N$30 or
. #N$31, is set by #R$B347.
. #SPRITE$30(pointer-1*) #SPRITE$31(pointer-2*)
B $B3AB,$04,$04

c $B3AF Get Horizontal Position
@ $B3AF label=GetHorizontalPosition
D $B3AF Fetches the horizontal position of an object.
R $B3AF IY The address of the object
R $B3AF O:HL The horizontal position
  $B3AF,$03 Fetch the low byte.
  $B3B2,$03 Fetch the high byte.
  $B3B5,$01 Return.

c $B3B6 Get Vertical Position
@ $B3B6 label=GetVerticalPosition
D $B3B6 Fetches the vertical position of an object.
R $B3B6 IY The address of the object
R $B3B6 O:HL The vertical position
  $B3B6,$03 Fetch the low byte.
  $B3B9,$03 Fetch the high byte.
  $B3BC,$01 Return.

c $B3BD Create Town Objects
@ $B3BD label=CreateTownObjects
D $B3BD Called every frame. In the town stage it updates the prices and makes
. new objects if there are free slots: bystanders, the outlaw, the pointer,
. money bags, cacti, the horse and the tumbleweed.
  $B3BD,$05 Return if this is a stage outside the town, which is the duel or
. the bonus stage.
  $B3C2,$03 Update the prices.
  $B3C5,$03 Make a bystander if there is a free slot.
  $B3C8,$03 Make the outlaw if there is a free slot.
  $B3CB,$03 Make the pointer if there is a free slot.
  $B3CE,$03 Make a money bag if there is a free slot.
  $B3D1,$03 Make a cactus if there is a free slot.
  $B3D4,$03 Make the horse if there is a free slot.
  $B3D7,$03 Jump to #R$A89C.

c $B3DA Handle Outlaw
@ $B3DA label=HandleOutlaw
D $B3DA Types #N$0A and #N$16: the outlaw who is wanted at this level. A bullet
. hit sets #R$A20A to one, which makes #R$B2E9 end the stage. Otherwise the
. outlaw wanders about the town: if he touches the sheriff, the sheriff dies.
. Type #N$16 is made by #R$B420 instead of type #N$0A when the outlaw is to be a
. little faster.
N $B3DA Check whether a bullet has hit the outlaw.
  $B3DA,$03 Check whether a bullet has hit the outlaw.
  $B3DD,$02 Jump to #R$B3E6 if not.
  $B3DF,$05 Set #R$A20A.
  $B3E4,$02 Jump to #R$B409 to draw the outlaw.
N $B3E6 Check whether the outlaw has touched the sheriff, and make him wander.
@ $B3E6 label=HandleOutlaw_Walk
  $B3E6,$03 Check whether the outlaw is touching the sheriff.
  $B3E9,$03 Kill the sheriff if he is.
  $B3EC,$03 Fetch the speed of the outlaw.
  $B3EF,$03 Set the speeds from it.
  $B3F2,$03 Fetch the flags of the outlaw.
  $B3F5,$01 Stash them on the stack.
  $B3F6,$03 Move around any walls.
  $B3F9,$01 Retrieve the flags.
  $B3FA,$03 Make a footstep sound if a foot has gone down.
  $B3FD,$03 Move the outlaw.
  $B400,$03 Choose a new direction every so often.
  $B403,$03 Set the direction the outlaw faces.
  $B406,$03 Move on to the next frame of the walk.
N $B409 Make the sprites for the outlaw.
@ $B409 label=HandleOutlaw_Draw
  $B409,$03 Choose the sprites for the figure.
  $B40C,$01 Keep the sprite number in the alternate accumulator.
  $B40D,$01 Keep the sprite number in #REGl.
  $B40E,$03 Fetch the level.
  $B411,$01 Double it.
  $B412,$02,b$01 Keep two bits.
  $B414,$02 Jump to #R$B418 unless the sprite set is the first.
  $B416,$02 Use the second sprite set.
@ $B418 label=HandleOutlaw_AddSpriteSet
  $B418,$01 Add the sprite set to the sprite number.
  $B419,$01 Keep the number in the alternate accumulator.
  $B41A,$03 Point #REGhl at #R$A232.
  $B41D,$03 Jump to #R$CB60.

c $B420 Create Outlaw
@ $B420 label=CreateOutlaw
D $B420 Called every frame in the town. Puts the outlaw (an object of type #N$0A
. or #N$16) in a random cell of the town in the fifth object slot if the slot is
. free and the cell is not blocked. The outlaw is made faster, and given type
. #N($16), if a random number is less than sixteen times the level (the level is
. reduced by four from level sixteen).
  $B420,$03 Point #REGde at #R$A2BD.
  $B423,$01 Fetch the type of the object in the slot.
  $B424,$01 Test whether the slot is in use.
  $B425,$01 Return if it is.
  $B426,$03 Copy #REGde to #REGiy (using the stack).
  $B429,$03 Point #REGhl at #R$B484.
  $B42C,$03 Set the size of an object slot in #REGbc.
  $B42F,$02 Copy the template into the slot.
N $B431 Choose a random cell.
M $B431,$06 Keep a random horizontal cell from #N$00 to #N$0F in #REGl.
  $B431,$03 Fetch a random number.
  $B434,$02,b$01 Keep a number from #N$00 to #N$0F.
  $B436,$01 Keep the random horizontal cell in #REGl.
M $B437,$06 Keep a random vertical cell from #N$00 to #N$0F in #REGh.
  $B437,$03 Fetch another random number.
  $B43A,$02,b$01 Keep a number from #N$00 to #N$0F.
  $B43C,$01 Keep the random vertical cell in #REGh.
  $B43D,$03 Set the horizontal cell of the outlaw.
  $B440,$03 Set the vertical cell of the outlaw.
  $B443,$03 Check whether the cell is blocked.
  $B446,$03 Return if the cell is blocked.
N $B449 Choose the outlaw.
  $B449,$03 Fetch the level.
  $B44C,$03 Point #REGhl at #R$B494.
  $B44F,$03 Point #REGhl at the number for the level.
  $B452,$01 Fetch the number of the outlaw.
  $B453,$03 Set it in the object.
  $B456,$04 Make the slot an outlaw.
N $B45A Choose how fast the outlaw moves.
  $B45A,$03 Fetch a random number.
  $B45D,$02,b$01 Keep bits 1 and 2.
  $B45F,$02 Add two to give a speed of two, four, six or eight.
  $B461,$03 Set the speed of the outlaw.
  $B464,$03 Fetch the level.
  $B467,$04 Jump to #R$B46D if the level is below #N$10.
  $B46B,$02 Take four off the level.
@ $B46D label=CreateOutlaw_MultiplyLevel
  $B46D,$04 Multiply the level by sixteen.
  $B471,$01 Keep the level times sixteen in #REGc.
  $B472,$03 Fetch another random number.
  $B475,$02 Return if it is not smaller than the number worked out from the
. level.
  $B477,$03 Fetch the speed of the outlaw.
  $B47A,$02 Add eight.
  $B47C,$03 Set the speed of the outlaw.
  $B47F,$04 Make the slot a faster outlaw.
  $B483,$01 Return.

b $B484 Outlaw Template
@ $B484 label=OutlawTemplate
D $B484 The initial contents of a slot for the outlaw. The final two bytes point
. to the sprite list, which is made by #R$B3DA.
B $B484,$0E,$08 Type, position, speed, size and counters.
W $B492,$02 The sprite list of the outlaw.

b $B494 Outlaw Numbers
@ $B494 label=OutlawNumbers
D $B494 The number of the outlaw wanted at each level.
B $B494,$14,$14 #FOR($00,$13)||n|#R$B4A8(#N(#PEEK(#PC+n)))|, ||

t $B4A8 Messaging: Outlaw Names
@ $B4A8 label=OutlawNames
D $B4A8 The names of the outlaws. Each outlaw has two parts, which are printed
. on two lines of the wanted poster by #R$B1F4. The last character of each part
. has bit 7 set. A part of just a space is blank.
  $B4A8,$07,$06:$01 "#STR(#PC)".
  $B4AF,$04,$03:$01 "#STR(#PC)".
  $B4B3,$05,$04:$01 "#STR(#PC)".
  $B4B8,$07,$06:$01 "#STR(#PC)".
  $B4BF,$08,$07:$01 "#STR(#PC)".
  $B4C7,$03,$02:$01 "#STR(#PC)".
  $B4CA,$05,$04:$01 "#STR(#PC)".
  $B4CF,$05,$04:$01 "#STR(#PC)".
  $B4D4,$05,$04:$01 "#STR(#PC)".
  $B4D9,$07,$06:$01 "#STR(#PC)".
  $B4E0,$02,$01:$01 "#STR(#PC)".
  $B4E2,$05,$04:$01 "#STR(#PC)".
  $B4E7,$04,$03:$01 "#STR(#PC)".
  $B4EB,$04,$03:$01 "#STR(#PC)".
  $B4EF,$05,$04:$01 "#STR(#PC)".
  $B4F4,$03,$02:$01 "#STR(#PC)".
  $B4F7,$06,$05:$01 "#STR(#PC)".
  $B4FD,$04,$03:$01 "#STR(#PC)".
  $B501,$06,$05:$01 "#STR(#PC)".
  $B507,$07,$06:$01 "#STR(#PC)".
  $B50E,$08,$07:$01 "#STR(#PC)".
  $B516,$04,$03:$01 "#STR(#PC)".
  $B51A,$06,$05:$01 "#STR(#PC)".
  $B520,$08,$07:$01 "#STR(#PC)".
  $B528,$05,$04:$01 "#STR(#PC)".
  $B52D,$03,$02:$01 "#STR(#PC)".
  $B530,$04,$03:$01 "#STR(#PC)".
  $B534,$06,$05:$01 "#STR(#PC)".
  $B53A,$05,$04:$01 "#STR(#PC)".
  $B53F,$01,$00:$01 "#STR(#PC)".
  $B540,$02,$01:$01 "#STR(#PC)".
  $B542,$06,$05:$01 "#STR(#PC)".
  $B548,$08,$07:$01 "#STR(#PC)".
  $B550,$01,$00:$01 "#STR(#PC)".
  $B551,$03,$02:$01 "#STR(#PC)".
  $B554,$08,$07:$01 "#STR(#PC)".
  $B55C,$07,$06:$01 "#STR(#PC)".
  $B563,$01,$00:$01 "#STR(#PC)".
  $B564,$04,$03:$01 "#STR(#PC)".
  $B568,$06,$05:$01 "#STR(#PC)".

g $B56E Outlaw Rewards
@ $B56E label=OutlawRewards
D $B56E The reward for each outlaw, as three packed decimal bytes in dollars,
. most significant first.
B $B56E,$3C,$03

b $B5AA Body Image Numbers
@ $B5AA label=BodyImageNumbers
D $B5AA The numbers of the images of the body of the outlaw in the duel, for his
. two steps, as two lists of three. The numbers are for the table of images at
. #R$6AC6 and the list for the step is chosen by #R$BC6C.
N $B5AA The first step.
B $B5AA,$03 #LET(b1=#PEEK($6AC6+#PEEK(#PC)*$02)+#PEEK($6AC7+#PEEK(#PC)*$02)*$100)#LET(b2=#PEEK($6AC6+#PEEK(#PC+$01)*$02)+#PEEK($6AC7+#PEEK(#PC+$01)*$02)*$100)#LET(b3=#PEEK($6AC6+#PEEK(#PC+$02)*$02)+#PEEK($6AC7+#PEEK(#PC+$02)*$02)*$100)#UDGARRAY(4,attr=$07,scale=3,step=4,flip=2)(({b1})-({b1}+$03)-$01;({b2})-({b2}+$03)-$01;({b3})-({b3}+$03)-$01)(body-#EVAL((#PC-$B5AA)/$03,16,2)*)
L $B5AA,$03,$02
N $B5AD The second step.
@ $B5AD label=BodyImageNumbers_SecondStep

b $B5B0 Face Image Numbers
@ $B5B0 label=FaceImageNumbers
D $B5B0 Five bytes for each outlaw, which are the numbers of the five images of
. his head and face in the duel, in the table of images at #R$6AC6. The wanted
. poster uses the last four of the five bytes as the numbers of its four images
. of the face.
B $B5B0,$05 #FACE(#EVAL((#PC-$B5B0)/$05))(face-#EVAL((#PC-$B5B0)/$05,16,2)*)
L $B5B0,$05,$14

c $B614 Check Bullet Hit
@ $B614 label=CheckBulletHit
D $B614 Checks whether any of the bullets (objects of type #N($02), in the
. second, third and fourth slots) is touching the object being handled.
R $B614 IX The address of the object
R $B614 O:F The carry flag is set if a bullet is touching the object
R $B614 O:IY The address of the bullet, if there is one
  $B614,$04 Point #REGiy at the second object slot.
  $B618,$03 Set the size of an object slot.
  $B61B,$02 Set the number of bullet slots to three.
N $B61D Check whether this slot holds a bullet.
@ $B61D label=CheckBulletHit_Loop
  $B61D,$03 Fetch the type of the object.
  $B620,$04 Jump to #R$B62C if it is not a bullet.
  $B624,$01 Stash the number of slots on the stack.
  $B625,$01 Stash the size of a slot on the stack.
  $B626,$03 Check whether the bullet is touching the object.
  $B629,$01 Retrieve the size of a slot.
  $B62A,$01 Retrieve the number of slots.
  $B62B,$01 Return if the bullet is touching it.
N $B62C Check the next slot.
@ $B62C label=CheckBulletHit_Next
  $B62C,$02 Move on to the next slot.
  $B62E,$02 Loop back until all three slots have been checked.
  $B630,$01 Return.

c $B631 Check Sheriff Touch
@ $B631 label=CheckSheriffTouch
D $B631 Checks whether the sheriff, on foot or on his horse, is touching the
. object being handled. It does nothing while #R$A208 is not zero.
R $B631 IX The address of the object
R $B631 O:F The carry flag is set if the sheriff is touching the object
R $B631 O:IY The address of the sheriff
  $B631,$03 Fetch the counter.
  $B634,$02 Return, with carry clear, while the sheriff is protected.
  $B636,$04 Point #REGiy at #R$A27D.
  $B63A,$03 Fetch the type of the object.
  $B63D,$08 Jump to #R$B647 if it is a sheriff on foot or a mounted sheriff.
  $B645,$01 Clear the carry flag.
  $B646,$01 Return.

c $B647 Check Overlap
@ $B647 label=CheckOverlap
D $B647 Checks whether two objects overlap. They overlap when the distance
. between their centres, both across and up the screen, is less than three
. quarters of the sum of their sizes.
R $B647 IX The address of the first object
R $B647 IY The address of the second object
R $B647 O:F The carry flag is set if the objects overlap
N $B647 Check the horizontal distance.
  $B647,$03 Fetch the horizontal size of the second object.
  $B64A,$03 Add the horizontal size of the first object.
  $B64D,$02 Halve the sum.
  $B64F,$01 Keep half of the summed widths in #REGc.
  $B650,$02 Halve it again.
  $B652,$01 Add the first half to make three quarters of the sum.
  $B653,$03 Keep three quarters of the summed widths in #REGbc.
  $B656,$06 Fetch the horizontal position of the first object into #REGhl.
  $B65C,$06 Fetch the horizontal position of the second object into #REGde.
  $B662,$03 Subtract one from the other.
  $B665,$03 Make the distance positive.
  $B668,$03 Subtract the limit.
  $B66B,$01 Return if the objects are too far apart horizontally.
N $B66C Check the vertical distance.
  $B66C,$03 Fetch the vertical size of the second object.
  $B66F,$03 Add the vertical size of the first object.
  $B672,$02 Halve the sum.
  $B674,$01 Keep half of the summed heights in #REGc.
  $B675,$02 Halve it again.
  $B677,$01 Add the first half to make three quarters of the sum.
  $B678,$03 Keep three quarters of the summed heights in #REGbc.
  $B67B,$06 Fetch the vertical position of the first object into #REGhl.
  $B681,$06 Fetch the vertical position of the second object into #REGde.
  $B687,$03 Subtract one from the other.
  $B68A,$03 Make the distance positive.
  $B68D,$03 Subtract the limit.
  $B690,$01 Return.

c $B691 Create Bystander
@ $B691 label=CreateBystander
D $B691 Called every frame in the town. Looks for a free slot among the tenth to
. thirteenth object slots, and if there is one puts a bystander (an object of
. type #N$06) in it, one cell away from the sheriff.
  $B691,$04 Point #REGiy at the tenth object slot.
  $B695,$03 Set the size of an object slot.
  $B698,$02 Set the number of slots to four.
@ $B69A label=CreateBystander_Loop
  $B69A,$03 Fetch the type of the object in the slot.
  $B69D,$03 Jump to #R$B6A5 if the slot is free.
  $B6A0,$02 Move on to the next slot.
  $B6A2,$02 Loop back until all four slots have been checked.
  $B6A4,$01 Return.
N $B6A5 Place a bystander in the free slot.
@ $B6A5 label=CreateBystander_Found
  $B6A5,$02 Set the distance from the sheriff to one cell.
  $B6A7,$03 Place the bystander one cell away from the sheriff.
  $B6AA,$01 Return if that cell is blocked.
  $B6AB,$03 Set the position of the bystander within its cell.
  $B6AE,$03 Fetch a random number.
  $B6B1,$02,b$01 Keep bits 1 and 2.
  $B6B3,$02 Add four to give a speed of four, six, eight or ten.
  $B6B5,$03 Set the speed of the bystander.
  $B6B8,$04 Turn the slot into a bystander.
  $B6BC,$04 Set the direction of the bystander.
  $B6C0,$04 Set the horizontal size of the bystander.
  $B6C4,$04 Set the vertical size of the bystander.
  $B6C8,$04 Clear the counter used for slowing down changes of sprite.
  $B6CC,$01 Return.

c $B6CD Place Near Sheriff
@ $B6CD label=PlaceNearSheriff
D $B6CD Puts an object in a cell which is a number of cells away from the
. sheriff, both across and up the screen. Which of the four diagonal directions
. is used depends on the bottom two bits of the frame counter.
R $B6CD B The distance in cells
R $B6CD IY The address of the object
R $B6CD O:F The zero flag is set if the cell is free
  $B6CD,$04 Fetch the horizontal cell of the sheriff and keep it in #REGl.
  $B6D1,$04 Fetch the vertical cell of the sheriff and keep it in #REGh.
  $B6D5,$04 Fetch the frame counter and keep it in #REGc.
  $B6D9,$01 Fetch the distance.
  $B6DA,$04 Jump to #R$B6E0 if bit 0 of the frame counter is clear.
  $B6DE,$02 Go in the other direction horizontally.
@ $B6E0 label=PlaceNearSheriff_AddHorizontal
  $B6E0,$01 Add the horizontal cell of the sheriff.
  $B6E1,$02,b$01 Wrap round the town.
  $B6E3,$01 Keep the wrapped horizontal cell in #REGl.
  $B6E4,$01 Fetch the distance again.
  $B6E5,$04 Jump to #R$B6EB if bit 1 of the frame counter is clear.
  $B6E9,$02 Go in the other direction vertically.
@ $B6EB label=PlaceNearSheriff_AddVertical
  $B6EB,$01 Add the vertical cell of the sheriff.
  $B6EC,$02,b$01 Wrap round the town.
  $B6EE,$01 Keep the wrapped vertical cell in #REGh.
  $B6EF,$03 Set the horizontal cell of the object.
  $B6F2,$03 Set the vertical cell of the object.
  $B6F5,$03 Jump to #R$C738.

c $B6F8 Set Position In Cell
@ $B6F8 label=SetPositionInCell
D $B6F8 Sets where an object stands within its cell, from the position of the
. sheriff within his cell. The routine uses #REGc as left by #R$C738, and
. #R$B6CD must have been called first.
R $B6F8 IY The address of the object
  $B6F8,$03 Fetch the horizontal position of the sheriff within his cell.
  $B6FB,$02,b$01 Keep the top two bits.
  $B6FD,$02,b$01 Set bit 6.
  $B6FF,$04 Jump to #R$B705 if bit 0 of #REGc is clear.
  $B703,$02 Negate the position.
@ $B705 label=SetPositionInCell_Horizontal
  $B705,$03 Set the horizontal position of the object within its cell.
  $B708,$03 Fetch the vertical position of the sheriff within his cell.
  $B70B,$02,b$01 Keep the top two bits.
  $B70D,$02,b$01 Set bit 6.
  $B70F,$04 Jump to #R$B715 if bit 1 of #REGc is clear.
  $B713,$02 Negate the position.
@ $B715 label=SetPositionInCell_Vertical
  $B715,$03 Set the vertical position of the object within its cell.
  $B718,$01 Return.

c $B719 Handle Bystander
@ $B719 label=HandleBystander
D $B719 Type #N$06: a bystander who wanders about the town. He goes away when
. the sheriff is more than two cells away. If he is shot, the bullet turns into
. a puff of smoke, the fine is taken from the bounty and the bystander dies. If
. the sheriff on foot touches him, the sheriff dies; if the mounted sheriff
. does, the bystander dies.
E $B719 Continue on to #R$B754.
  $B719,$03 Fetch the speed of the bystander.
  $B71C,$03 Set the speeds from it.
  $B71F,$03 Fetch the flags of the bystander.
  $B722,$01 Stash them on the stack.
  $B723,$03 Move around any walls.
  $B726,$01 Retrieve the flags.
  $B727,$03 Make a footstep sound if a foot has gone down.
  $B72A,$03 Move the bystander.
  $B72D,$03 Choose a new direction every so often.
  $B730,$03 Set the frame and the direction the bystander faces.
  $B733,$02 Set the distance to two cells.
  $B735,$03 Check how close the sheriff is.
  $B738,$03 Remove the bystander if the sheriff has moved away.
  $B73B,$03 Point #REGbc at #R$B798.
  $B73E,$03 Choose the sprite list.
N $B741 Check whether a bullet or the sheriff has hit the bystander.
@ $B741 label=HandleBystander_CheckHit
  $B741,$03 Check whether a bullet has hit the bystander.
  $B744,$02 Jump to #R$B770 if it has.
  $B746,$03 Check whether the sheriff is touching the bystander.
  $B749,$01 Return if not.
  $B74A,$03 Fetch the type of the sheriff.
  $B74D,$04 Jump to #R$B778 if he is mounted.
  $B751,$03 Take the fine from the bounty.

c $B754 Kill Sheriff
@ $B754 label=KillSheriff
D $B754 Makes the sheriff die, and removes the bullets. It is used when the
. sheriff touches something dangerous.
R $B754 IX The address of the object which killed the sheriff
R $B754 IY The address of the sheriff
  $B754,$02 Stash the address of the object on the stack.
  $B756,$04 Copy the address of the sheriff into #REGix (using the stack).
  $B75A,$03 Make the sheriff die.
  $B75D,$03 Fetch the counter of the sheriff.
  $B760,$02 Take four off it.
  $B762,$03 Store the reduced delay counter.
  $B765,$02 Retrieve the address of the object from the stack.
  $B767,$03 Point #REGhl at #R$A28D.
  $B76A,$03 Set the size of the three bullet slots.
  $B76D,$03 Jump to #R$D6E1.

c $B770 Shoot Bystander
@ $B770 label=ShootBystander
D $B770 Turns the bullet which has hit the object into a puff of smoke, and then
. goes on to take the fine for shooting a bystander.
E $B770 Continue on to #R$B778.
R $B770 IY The address of the bullet
  $B770,$04 Turn the bullet into a puff of smoke.
  $B774,$04 Set the length of the puff to two frames.

c $B778 Take Fine
@ $B778 label=TakeFine
D $B778 Takes the fine from the bounty, prints the new bounty and then makes the
. object die.
E $B778 Continue on to #R$B782.
R $B778 IX The address of the object
  $B778,$04 Fetch the fine.
  $B77C,$03 Take it from the bounty.
  $B77F,$03 Print the new bounty.

c $B782 Start Dying
@ $B782 label=StartDying
D $B782 Turns an object into a dying object (type #N$09), which falls and
. bounces, and then lies on the ground as a dead figure.
R $B782 IX The address of the object
  $B782,$04 Turn the object into a dying object.
  $B786,$04 Set the counter.
  $B78A,$04 Set the speed of the fall.
  $B78E,$03 Point #REGhl at #R$B7A4.
  $B791,$03 Store the low byte of the address.
  $B794,$03 Store the high byte of the address.
  $B797,$01 Return.

b $B798 Bystander Sprite Lists
@ $B798 label=BystanderSpriteLists
D $B798 The table of sprite lists for the two frames of a bystander, and the
. lists. The last list is for a dead figure.
W $B798,$04,$02 The addresses of #R$B79C and #R$B7A0.
@ $B79C label=BystanderSpriteLists_FirstFrame
B $B79C,$04,$04 The first frame: #SPRITE$2D(bystander-1*).
@ $B7A0 label=BystanderSpriteLists_SecondFrame
B $B7A0,$04,$04 The second frame: #SPRITE$2E(bystander-2*).
@ $B7A4 label=BystanderSpriteLists_DeadFigure
B $B7A4,$04,$04 A dead figure: sprite #N$10.
. #SPRITE$10(head-3*).

c $B7A8 Show Game Over
@ $B7A8 label=ShowGameOver
D $B7A8 Shows the game over screen for the player whose game has ended, which
. has "GAME OVER" and the number of the player in large letters. It plays the
. game over tune.
. #PUSHS #UDGTABLE { #POKES$A23F,$00
. #SIM(start=$B7A8,stop=$B7CA,clear=1,sp=$5E00)
. #SCR$02(game-over) } UDGTABLE# #POPS
N $B7A8 Show the game over screen.
  $B7A8,$02 Set the attribute to #COLOUR$00.
  $B7AA,$03 Set all the attributes.
  $B7AD,$03 Clear the screen.
  $B7B0,$03 Fetch the number of the current player, which is zero or one.
  $B7B3,$02 Make it the character "1" or "2".
  $B7B5,$03 Put it in the text.
N $B7B8 Print "GAME OVER".
  $B7B8,$03 Point #REGhl at #N$4826 (in the screen buffer).
  $B7BB,$03 Point #REGde at #R$B7DA.
  $B7BE,$03 Print it in large letters.
N $B7C1 Print the number of the player.
  $B7C1,$03 Point #REGhl at #N$48A8 (in the screen buffer).
  $B7C4,$03 Point #REGde at #R$B7E6.
  $B7C7,$03 Print it in large letters.
N $B7CA Play the tune.
  $B7CA,$03 Set the length of the wait.
  $B7CD,$03 Wait for a while.
  $B7D0,$04 Write #N$00 to #R$A242 to allow the tune to play.
  $B7D4,$03 Point #REGde at #R$B1CF.
  $B7D7,$03 Jump to #R$AF76.

t $B7DA Messaging: Game Over Text
@ $B7DA label=GameOverTexts
D $B7DA The two messages of the game over screen. Each is an attribute byte, the
. characters and a zero terminator.
B $B7DA,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $B7DB,$0A "GAME  OVER".
B $B7E5,$01,$01 Terminator.
@ $B7E6 label=GameOverTexts_Player
B $B7E6,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $B7E7,$07 "PLAYER ".
B $B7EE,$01,$01 The number of the player, written by #R$B7A8.
B $B7EF,$01,$01 Terminator.

c $B7F0 Set Frame And Flip
@ $B7F0 label=SetFrameAndFlip
D $B7F0 Chooses the frame of a walking figure and whether its sprite is flipped,
. from the direction in which it is walking and the view. Bits 6 and 7 of byte
. #N$06 of the object hold the direction.
R $B7F0 IX The address of the object
  $B7F0,$04 Fetch the view number and keep it in #REGb.
  $B7F4,$03 Fetch the direction.
  $B7F7,$02 Take one off the direction.
  $B7F9,$01 Move bit 7 into bit 0.
  $B7FA,$02,b$01 Keep bit 0.
  $B7FC,$01 Combine it with the view.
  $B7FD,$03 Set the frame.
  $B800,$03 Fetch the direction.
  $B803,$02,b$01 Keep bit 6.
  $B805,$01 Keep the flip bit in #REGc.
  $B806,$03 Fetch the flags.
  $B809,$02,b$01 Clear bit 6.
  $B80B,$01 Set bit 6 if the direction says so.
  $B80C,$03 Store the flags.
  $B80F,$01 Return.

c $B810 Check Distance
@ $B810 label=CheckDistance
D $B810 Checks whether an object is within a number of cells of the sheriff,
. both across and up the screen.
E $B810 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$C069 }
. LIST#
R $B810 C The distance in cells
R $B810 IX The address of the object
R $B810 O:F The carry flag is set if the object is closer than that
  $B810,$03 Fetch the horizontal cell of the sheriff from #R$A27D(#N$A27F).
  $B813,$03 Subtract the horizontal cell of the object.
  $B816,$03 Jump to #R$B81B if the difference is not negative.
  $B819,$02 Make the difference positive.
@ $B81B label=CheckDistance_CompareHorizontal
  $B81B,$01 Compare it with the distance.
  $B81C,$01 Return if the object is too far away.
  $B81D,$03 Fetch the vertical cell of the sheriff from #R$A27D(#N$A281).
  $B820,$03 Subtract the vertical cell of the object.
  $B823,$03 Jump to #R$B828 if the difference is not negative.
  $B826,$02 Make the difference positive.
@ $B828 label=CheckDistance_CompareVertical
  $B828,$01 Compare it with the distance.
  $B829,$01 Return.

c $B82A Update Direction
@ $B82A label=UpdateDirection
D $B82A Makes a figure choose a new direction every so often. The bottom six
. bits of byte #N$06 count down the frames until the next change, and bits 6 and
. 7 are the direction. The direction is turned a quarter to the left or the
. right, and the counter is set to a new random number. A figure which has
. bumped into a wall (bit 0 of the flags) changes direction straight away, and a
. figure with bit 5 of the flags set never changes direction on its own.
E $B82A View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DD28 }
. LIST#
R $B82A IX The address of the object
  $B82A,$06 Jump to #R$B83F if the figure has bumped into a wall.
  $B830,$03 Count down the counter.
  $B833,$03 Fetch the counter.
  $B836,$02,b$01 Keep the bottom five bits.
  $B838,$01 Return unless the counter is at a multiple of thirty two.
  $B839,$06 Jump to #R$B85A to return if the figure keeps its direction.
@ $B83F label=UpdateDirection_Random
  $B83F,$03 Fetch a random number.
  $B842,$02 Compare it with #N$80.
  $B844,$03 Fetch the direction and counter.
  $B847,$02 Jump to #R$B856 to turn left if the random number is #N$80 or more.
  $B849,$02 Turn right.
@ $B84B label=UpdateDirection_Timer
  $B84B,$01 Keep the new direction in #REGc.
  $B84C,$03 Fetch another random number.
  $B84F,$02,b$01 Keep the bottom six bits.
  $B851,$01 Combine it with the direction.
  $B852,$03 Store the new direction.
  $B855,$01 Return.
@ $B856 label=UpdateDirection_TurnLeft
  $B856,$02 Turn left.
  $B858,$02 Go back to store the direction and counter.
@ $B85A label=UpdateDirection_Finish
  $B85A,$01 Return.

c $B85B Run Stage Script
@ $B85B label=RunStageScript
D $B85B Called every frame. In the duel and the bonus stage, which both have
. #R$A267 set to zero, it runs the routine for the kind of stage which is in
. #R$A265, as long as there are still stages to play (#R$A264 is not zero). In
. kind #N$00 nothing happens, in kind #N$01 money bags are made, and in kind
. #N$02 the duel is set up.
N $B85B This routine is only for the duel and the bonus stage.
  $B85B,$05 Return if #R$A267 is not zero, so this is the town.
N $B860 The stage continues only while there is something left to play.
  $B860,$05 Return if #R$A264 is zero.
  $B865,$05 Set #R$A240, so that the objects can go without a life being lost.
  $B86A,$03 Fetch the kind of stage.
  $B86D,$03 Point #REGbc at #R$B873.
N $B870 Run the routine for the kind of stage.
  $B870,$03 Jump to #R$C766.

w $B873 Stage Routines
@ $B873 label=StageRoutines
D $B873 The routine for each kind of stage.
W $B873,$06,$02

c $B879 Set Up Duel
@ $B879 label=SetUpDuel
D $B879 Sets up the duel in the first two object slots. The first is the outlaw,
. in a random place in the middle of the screen, who will move about a random
. number of times before he draws, and the second is his gun.
  $B879,$03 Point #REGde at the first object slot.
  $B87C,$01 Fetch the type of the object in the slot.
  $B87D,$02 Return if the slot is in use.
  $B87F,$03 Copy the address of the first object slot into #REGiy
. (using the stack).
  $B882,$03 Point #REGhl at #R$B8A3.
  $B885,$03 Set the size of two object slots in #REGbc.
  $B888,$02 Copy the templates into the slots.
  $B88A,$03 Fetch a random number.
  $B88D,$02,b$01 Keep a number from #N$00 to #N$07.
  $B88F,$02 Add two to give two to nine.
  $B891,$03 Set the number of times the outlaw moves before he draws.
  $B894,$03 Fetch another random number.
  $B897,$02,b$01 Keep a number from #N$00 to #N$7F.
  $B899,$02 Add #N$40 to give the horizontal position of the outlaw.
  $B89B,$03 Set the horizontal position of the outlaw.
  $B89E,$04 Write #N$00 to #R$A211 so the draw message has not been shown.
  $B8A2,$01 Return.

b $B8A3 Duel Templates
@ $B8A3 label=DuelTemplates
D $B8A3 The initial contents of the two slots for the duel: the outlaw (type
. #N$0C) and his gun (type #N$0E). The final two bytes of the second point to
. the sprite list.
B $B8A3,$10,$08 The outlaw.
B $B8B3,$0E,$08 The outlaw's gun.
W $B8C1,$02 The sprite list of the gun.

g $B8C3 Gun Sprite Lists
@ $B8C3 label=GunSpriteLists
D $B8C3 The table of sprite lists for the six frames of the outlaw's gun,
. followed by the lists. Each list has one sprite.
W $B8C3,$0C,$02 The addresses of the sprite lists.
B $B8CF,$04,$04 Sprite #N$01. #SPRITE$01(outlaw-gun-arm-1*).
B $B8D3,$04,$04 Sprite #N$02. #SPRITE$02(outlaw-gun-arm-2*).
B $B8D7,$04,$04 Sprite #N$03. #SPRITE$03(outlaw-gun-arm-3*).
B $B8DB,$04,$04 Sprite #N$04. #SPRITE$04(outlaw-gun-arm-4*).
B $B8DF,$04,$04 Sprite #N$05. #SPRITE$05(outlaw-gun-arm-5*).
B $B8E3,$04,$04 Sprite #N$06. #SPRITE$06(outlaw-gun-arm-6*).

c $B8E7 Handle Outlaw Gun
@ $B8E7 label=HandleOutlawGun
D $B8E7 Type #N$0E: the gun of the outlaw in the duel, which is in the slot
. after the outlaw. It stays with the outlaw. When the outlaw is waiting it is
. not drawn, and when he has drawn it goes through its six frames, which raise
. the gun, and then it fires: it makes a muzzle flash (type #N$0F) in the next
. slot, and counts the shot in #R$A212. The duel ends when the outlaw has fired
. six shots. The gun is removed when the outlaw is dying.
  $B8E7,$03 Fetch the type of the outlaw.
  $B8EA,$05 Jump to #R$C7BB to remove the gun if the outlaw is dying.
  $B8EF,$04 Jump to #R$B910 if the outlaw has been shot.
  $B8F3,$04 Jump to #R$B910 if the outlaw is waiting.
  $B8F7,$03 Fetch the frame of the gun.
  $B8FA,$04 Jump to #R$B92A if the gun is fully raised.
  $B8FE,$03 Advance the frame when it is time.
  $B901,$03 Fetch the frame of the gun.
  $B904,$03 Point #REGbc at #R$B8C3.
  $B907,$03 Point #REGhl at the sprite list for the frame.
  $B90A,$03 Store the low byte of the address.
  $B90D,$03 Store the high byte of the address.
N $B910 Put the gun next to the outlaw and draw it.
@ $B910 label=HandleOutlawGun_Place
  $B910,$03 Fetch the horizontal position of the outlaw.
  $B913,$02 Move eight pixels to the left.
  $B915,$03 Set the horizontal position of the gun.
  $B918,$03 Fetch the type of the outlaw.
  $B91B,$02 Compare it with the type of a shot outlaw.
  $B91D,$03 Fetch the vertical position of the outlaw.
  $B920,$02 Jump to #R$B924 if he has been shot.
  $B922,$02 Move the gun down twelve pixels.
@ $B924 label=HandleOutlawGun_SetPosition
  $B924,$03 Set the vertical position of the gun.
  $B927,$03 Jump to #R$BD52.
N $B92A The gun is fully raised, so fire it unless it has already fired.
@ $B92A label=HandleOutlawGun_Fire
  $B92A,$03 Fetch the type of the object in the next slot.
  $B92D,$01 Test whether the slot is in use.
  $B92E,$02 Jump to #R$B910 if it is.
  $B930,$03 Point #REGhl at #R$A212.
  $B933,$01 Fetch the count.
  $B934,$02 Return if the outlaw has been hit.
  $B936,$01 Add one to the count.
  $B937,$04 Jump to #R$B985 to end the duel if the outlaw has fired six shots.
  $B93B,$01 Store the count.
  $B93C,$03 Copy #REGix to #REGhl (using the stack).
  $B93F,$03 Set the size of an object slot.
  $B942,$01 Point #REGhl at the next slot.
  $B943,$03 Copy #REGhl to #REGiy (using the stack).
  $B946,$01 Swap the address of the slot into #REGde.
  $B947,$03 Point #REGhl at #R$B95E.
  $B94A,$02 Copy the template into the slot.
  $B94C,$03 Fetch the horizontal position of the gun.
  $B94F,$02 Move eight pixels to the right.
  $B951,$03 Set the horizontal position of the flash.
  $B954,$03 Fetch the vertical position of the gun.
  $B957,$02 Move six pixels down.
  $B959,$03 Set the vertical position of the flash.
N $B95C Place and draw the gun.
  $B95C,$02 Jump to #R$B910.

b $B95E Muzzle Flash Template
@ $B95E label=MuzzleFlashTemplate
D $B95E The initial contents of a slot for a muzzle flash (type #N$0F). The
. final two bytes point to the sprite list, whose sprite number is set by
. #R$B972.
. #SPRITE$07(flash-1*) #SPRITE$08(flash-2*)
. #SPRITE$09(flash-3*) #SPRITE$0A(flash-4*)
B $B95E,$0E,$08 Type, position, speed, size and counters.
W $B96C,$02 The sprite list of the flash.
B $B96E,$04,$04 The sprite list.

c $B972 Handle Muzzle Flash
@ $B972 label=HandleMuzzleFlash
D $B972 Type #N$0F: the flash of the outlaw's gun when he fires. It grows for
. four frames, using sprites #N$07 to #N($0A), and then makes a bullet hole.
  $B972,$03 Fetch the frame.
  $B975,$04 Jump to #R$B990 if the flash is over.
  $B979,$01 Move on to the next frame.
  $B97A,$03 Store the frame.
  $B97D,$02 Add six to give the number of the sprite.
  $B97F,$03 Store it in the sprite list.
  $B982,$03 Jump to #R$BD52.

c $B985 End Duel
@ $B985 label=EndDuel
D $B985 Ends the duel when the outlaw has fired all his shots without being hit.
. The flag at #R$A240 is cleared, so the player loses a life when the objects
. have gone, and there are no more stages to play, so the town comes next.
. #R$B989 is also used to end a stage.
  $B985,$04 Write #N$00 to #R$A240 so that the loss of the sheriff counts.
@ $B989 label=EndDuel_EndStage
  $B989,$04 Write #N$00 to #R$A264, the number of stages left to play.
  $B98D,$03 Jump to #R$C7C8.

c $B990 Make Bullet Hole
@ $B990 label=MakeBulletHole
D $B990 Puts a bullet hole (an object of type #N$10) in a random place on the
. screen, in the first free slot of the first thirteen, which are searched
. downwards from the thirteenth. It makes a burst of noise and removes the
. muzzle flash.
  $B990,$03 Point #REGhl at the thirteenth object slot.
  $B993,$03 Set the distance to the previous slot.
  $B996,$02 Set the number of slots to thirteen.
@ $B998 label=MakeBulletHole_Loop
  $B998,$01 Fetch the type of the object in the slot.
  $B999,$01 Test whether the slot is in use.
  $B99A,$02 Jump to #R$B9A0 if it is free.
  $B99C,$01 Move on to the previous slot.
  $B99D,$02 Loop back until all the slots have been checked.
  $B99F,$01 Return.
N $B9A0 Place a bullet hole in the free slot.
@ $B9A0 label=MakeBulletHole_Found
  $B9A0,$01 Swap the address of the slot into #REGde.
  $B9A1,$03 Copy the address of the slot into #REGiy (using the stack).
  $B9A4,$03 Point #REGhl at #R$B9C6.
  $B9A7,$03 Set the size of an object slot in #REGbc.
  $B9AA,$02 Copy the template into the slot.
  $B9AC,$03 Fetch a random number.
  $B9AF,$02,b$01 Keep a number from #N$00 to #N$7F.
  $B9B1,$02 Add #N$38 to give the horizontal position.
  $B9B3,$03 Set the horizontal position of the hole.
  $B9B6,$03 Fetch another random number.
  $B9B9,$02,b$01 Keep a number from #N$00 to #N$3F.
  $B9BB,$02 Add #N$60 to give the vertical position.
  $B9BD,$03 Set the vertical position of the hole.
  $B9C0,$03 Make a burst of noise.
N $B9C3 Remove the muzzle flash.
  $B9C3,$03 Jump to #R$C7BB.

b $B9C6 Bullet Hole Template
@ $B9C6 label=BulletHoleTemplate
D $B9C6 The initial contents of a slot for a bullet hole (type #N$10). The final
. two bytes point to the sprite list.
B $B9C6,$0E,$08 Type, position, speed, size and counters.
W $B9D4,$02 The sprite list of a bullet hole.
B $B9D6,$04,$04 The sprite list: sprite #N$0B at offset
. (#N($F0), #N$F0). #SPRITE$0B(bullet-hole*).

c $B9DA Handle Bullet Hole
@ $B9DA label=HandleBulletHole
D $B9DA Type #N$10: a bullet hole, which stays where it is.
  $B9DA,$03 Jump to #R$BD52.

c $B9DD Advance Gun Frame
@ $B9DD label=AdvanceGunFrame
D $B9DD Moves the outlaw's gun on to its next frame. If the player has provoked
. the outlaw, which is when #R$A211 is one, the gun moves on every frame.
. Otherwise it moves on after a delay which is shorter at the higher levels of
. skill.
R $B9DD IX The address of the gun
  $B9DD,$03 Fetch #R$A211.
  $B9E0,$04 Jump to #R$B9F7 to move to the next frame at once if the outlaw has
. been provoked.
  $B9E4,$06 Jump to #R$B9EE if the delay is zero.
  $B9EA,$03 Count down the delay.
  $B9ED,$01 Return.
N $B9EE The delay has finished, so set a new one from the skill level.
@ $B9EE label=AdvanceGunFrame_Reset
  $B9EE,$03 Fetch #R$A261.
  $B9F1,$01 Invert it.
  $B9F2,$02,b$01 Keep a number from #N$00 to #N$07, which is smaller at the
. higher skill levels.
  $B9F4,$03 Set the delay.
@ $B9F7 label=AdvanceGunFrame_Next
  $B9F7,$03 Move on to the next frame.
  $B9FA,$01 Return.

c $B9FB Handle Waiting Outlaw
@ $B9FB label=HandleWaitingOutlaw
D $B9FB Type #N$0C: the outlaw in the duel before he draws. He wanders about the
. screen, changing direction a random number of times (the count in
. #REGix+#N$0A), and at the end of the last move he draws his gun. If the player
. moves or fires before then he draws at once. He is hit if the crosshair is on
. him when the player fires.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #POKES$A265,$02;$A266,$45
. #SIM(start=$A3B3,stop=$A3B7)
. #SIM(start=$A3B7,stop=$A3BA)
. #SIM(start=$A3BA,stop=$A3F6)
. #SIM(start=$A3F6,stop=$A3BA)
. #SIM(start=$A3BA,stop=$A3F6)
. #SIM(start=$A3F6,stop=$A3BA)
. #SIM(start=$A3BA,stop=$A3F6)
. #SCR$03,$02,$00,$18,$10(waiting-outlaw) } UDGTABLE# #POPS
E $B9FB Continue on to #R$BA47.
  $B9FB,$03 Check whether the player has provoked the outlaw.
  $B9FE,$03 Count down the timer for the current move.
  $BA01,$03 Fetch the timer.
  $BA04,$02 Jump if the move is not over.
  $BA06,$03 Combine the timer, which is zero, with the number of moves left.
  $BA09,$03 Jump to make the outlaw draw if he has made all his moves.
  $BA0C,$03 Choose a new move.
@ $BA0F label=HandleWaitingOutlaw_Move
  $BA0F,$03 Keep the outlaw on the screen, which reverses his speed at an edge.
  $BA12,$03 Fetch the flags which show whether he has reached an edge.
  $BA15,$02,b$01 Keep the four bits.
  $BA17,$02 Jump if he has not reached an edge.
  $BA19,$04 Make the move end on the next frame.
@ $BA1D label=HandleWaitingOutlaw_Update
  $BA1D,$03 Move the outlaw.
@ $BA20 label=HandleWaitingOutlaw_CheckHit
  $BA20,$03 Check whether the crosshair is on the outlaw.
  $BA23,$02 Jump if the outlaw has not been hit.
  $BA25,$02 Set the flag which shows that the outlaw has been hit.
  $BA27,$03 Store the flag which shows the outlaw has been hit.
  $BA2A,$04 Turn the outlaw into a shot outlaw.
  $BA2E,$04 Start at the first frame of falling.
@ $BA32 label=HandleWaitingOutlaw_DrawBody
  $BA32,$04 Fetch the horizontal position of the outlaw and keep it in #REGl.
  $BA36,$03 Store it as the horizontal pixel position for the sprites.
  $BA39,$03 Fetch the vertical position of the outlaw into #REGh.
  $BA3C,$03 Find the address in the buffer.
  $BA3F,$03 Choose the sprites of the body of the outlaw.
  $BA42,$02 Set the number of sprites to three.
  $BA44,$03 Draw the body of the outlaw into the buffer.

c $BA47 Draw Outlaw Face
@ $BA47 label=DrawOutlawFace
D $BA47 Draws the face of the outlaw, which is five sprites, into the buffer,
. below the body.
R $BA47 HL The address in the buffer
  $BA47,$03 Fetch the level.
  $BA4A,$01 Swap the address in the buffer into #REGde.
  $BA4B,$03 Point #REGhl at #R$B494.
  $BA4E,$03 Point #REGhl at the entry for the level.
  $BA51,$01 Fetch the number of the outlaw.
  $BA52,$02 Set the high byte.
  $BA54,$02 Make the outlaw number a sixteen bit index in #REGbc.
  $BA56,$02 Multiply it by four.
  $BA58,$01 Add the number to make it five times as big.
  $BA59,$03 Point #REGbc at #R$B5B0.
  $BA5C,$01 Point #REGhl at the sprites of his face.
  $BA5D,$01 Swap the pointer to the face into #REGde and the address back into
. #REGhl.
  $BA5E,$02 Set the number of sprites to five.
  $BA60,$03 Jump to #R$B280.

c $BA63 Check Crosshair On Outlaw
@ $BA63 label=CheckCrosshairOnOutlaw
D $BA63 Checks whether the player's shot is on the outlaw. The outlaw cannot be
. hit once he has fired his first shot.
R $BA63 IX The address of the outlaw
R $BA63 O:F The carry flag is set if the outlaw has been hit
  $BA63,$05 Return if #R$A212 is not zero.
  $BA68,$04 Point #REGiy at the fourteenth object slot, which holds the player's
. shot.
  $BA6C,$05 Return if the shot slot is not in use.
  $BA71,$03 Fetch the horizontal position of the outlaw.
  $BA74,$02 Move four pixels to the right.
  $BA76,$03 Subtract the horizontal position of the shot.
  $BA79,$02 Make it positive.
  $BA7B,$03 Return if the shot is #N$18 or more to the side.
  $BA7E,$03 Fetch the vertical position of the outlaw.
  $BA81,$02 Move twelve pixels up.
  $BA83,$03 Subtract the vertical position of the shot.
  $BA86,$02 Make it positive.
  $BA88,$02 Compare it with forty eight.
  $BA8A,$01 Return with the carry flag set if the shot is on the outlaw.

c $BA8B Check For Early Draw
@ $BA8B label=CheckForEarlyDraw
D $BA8B Reads the controls while the outlaw is waiting. If the player moves the
. crosshair or fires, the outlaw is provoked and starts to draw at once, and
. "DRAW!!" appears in yellow, if it is not already on the screen.
R $BA8B IX The address of the outlaw
  $BA8B,$03 Fetch the flag which shows that the outlaw has been provoked.
  $BA8E,$02 Return if the outlaw has already been provoked.
  $BA90,$03 Read the controls.
  $BA93,$02 Return if nothing has been pressed.
  $BA95,$02 Set the flag to one.
  $BA97,$03 Store the flag which shows the outlaw is provoked.
  $BA9A,$03 Make this the last move.
  $BA9D,$03 Make the timer run out on the next frame.
  $BAA0,$03 Point #REGhl at #R$A211.
  $BAA3,$01 Fetch the flag.
  $BAA4,$02 Return if the draw message has already been printed.
  $BAA6,$02 Set the flag to one.
N $BAA8 Print the "DRAW!!" message.
  $BAA8,$03 Point #REGhl at #N$502E (in the screen buffer).
  $BAAB,$03 Point #REGde at #R$BAD2.
  $BAAE,$03 Jump to #R$AA9A.

c $BAB1 Start Outlaw Drawing
@ $BAB1 label=StartOutlawDrawing
D $BAB1 Called when the outlaw has finished moving about. He is turned into an
. outlaw who is drawing (type #N$0D), and "DRAW!!" is printed in red if it is
. not yet on the screen.
R $BAB1 IX The address of the outlaw
  $BAB1,$04 Turn the outlaw into one who is drawing.
  $BAB5,$03 Point #REGhl at #R$A211.
  $BAB8,$01 Fetch the flag.
  $BAB9,$03 Jump to #R$BAC7 if the draw message has been printed.
  $BABC,$02 Set the flag to two.
N $BABE Print the "DRAW!!" message.
  $BABE,$03 Point #REGhl at #N$502E (in the screen buffer).
  $BAC1,$03 Point #REGde at #R$BACA.
  $BAC4,$03 Print the message.
@ $BAC7 label=StartOutlawDrawing_CheckHit
  $BAC7,$03 Jump to check whether he has been hit.

t $BACA Messaging: Draw Text
@ $BACA label=DrawMessages
D $BACA The two "DRAW!!" messages, each of which is an attribute byte (red, then
. yellow), characters and a zero byte. Each "!" is the character code #N$5D,
. which is why they are not text.
B $BACA,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $BACB,$04 "DRAW"
B $BACF,$02 Two exclamation marks.
B $BAD1,$01 Terminator.
@ $BAD2 label=DrawMessages_Yellow
B $BAD2,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $BAD3,$04 "DRAW"
B $BAD7,$02 Two exclamation marks.
B $BAD9,$01 Terminator.

c $BADA Handle Drawing Outlaw
@ $BADA label=HandleDrawingOutlaw
D $BADA Type #N$0D: the outlaw while he draws. He does not move.
  $BADA,$03 Jump to check whether he has been hit, and draw him.

c $BADD Handle Shot Outlaw
@ $BADD label=HandleShotOutlaw
D $BADD Type #N$11: an outlaw who has been hit. For six frames he is drawn with
. the two body sprites at #R$BBC8 and then he starts to die.
E $BADD Continue on to #R$BB0B.
  $BADD,$03 Move on to the next frame.
  $BAE0,$03 Fetch the frame.
  $BAE3,$04 Jump to #R$BB03 if the six frames are over.
  $BAE7,$04 Fetch the horizontal position of the outlaw and keep it in #REGl.
  $BAEB,$03 Store it as the horizontal pixel position for the sprites.
  $BAEE,$03 Fetch the vertical position of the outlaw into #REGh.
  $BAF1,$03 Find the address in the buffer.
  $BAF4,$03 Point #REGde at #R$BBC8.
  $BAF7,$02 Set the number of sprites to two.
  $BAF9,$03 Draw the body into the buffer.
  $BAFC,$03 Five buffer rows up is one hundred and twenty bytes.
  $BAFF,$01 Move the address up five rows of the buffer.
  $BB00,$03 Jump to #R$BA47.
N $BB03 Start the outlaw dying.
@ $BB03 label=HandleShotOutlaw_Die
  $BB03,$04 Turn the outlaw into a dying outlaw.
  $BB07,$04 Start at the first frame of dying.

c $BB0B Handle Dying Outlaw
@ $BB0B label=HandleDyingOutlaw
D $BB0B Type #N$12: an outlaw who is dying. He sinks out of sight, a sprite
. fewer each four frames, and when he has gone the player is rewarded.
  $BB0B,$03 Fetch the frame.
  $BB0E,$04 Jump to #R$BB3A to give the reward if it is three.
  $BB12,$01 Copy the frame into #REGe.
  $BB13,$03 Point #REGbc at #R$BBBB.
  $BB16,$03 Fetch the pointer to the sprite list for the frame.
  $BB19,$01 Swap the pointer into #REGde.
  $BB1A,$01 Fetch the frame.
  $BB1B,$02 Subtract it from zero.
  $BB1D,$02 Add four, to give the number of sprites for the frame.
  $BB1F,$01 Keep the number of body sprites in #REGb.
  $BB20,$04 Fetch the horizontal position of the outlaw and keep it in #REGl.
  $BB24,$03 Store it as the horizontal pixel position for the sprites.
  $BB27,$03 Fetch the vertical position of the outlaw into #REGh.
  $BB2A,$03 Find the address in the buffer.
  $BB2D,$03 Draw the sprites into the buffer.
  $BB30,$03 Fetch the frame counter.
  $BB33,$02,b$01 Keep a number from #N$00 to #N$03.
  $BB35,$01 Return unless it is every fourth frame.
  $BB36,$03 Move on to the next frame.
  $BB39,$01 Return.

c $BB3A Give Reward
@ $BB3A label=GiveReward
D $BB3A Called when the outlaw has finished dying. Plays a tune and adds the
. reward for this outlaw to the player's bounty, then adds a life to make up for
. the one which the next stage takes, and moves on to the next level. The skill
. level goes up every second level, to a maximum of seven. Levels past the
. nineteenth go back to the sixteenth. After every fourth level the player plays
. a bonus stage in which money bags fall; otherwise the stage ends.
  $BB3A,$03 Point #REGde at #R$B0A9.
  $BB3D,$03 Call #R$AF8F.
  $BB40,$03 Fetch the level.
  $BB43,$03 Multiply it by three.
  $BB46,$03 Point #REGhl at #R$B56E.
  $BB49,$03 Point #REGhl at the reward for the level.
  $BB4C,$02 Move on to the last byte of the reward.
  $BB4E,$01 Fetch the last byte into #REGc.
  $BB4F,$01 Move back a byte.
  $BB50,$01 Fetch the middle byte into #REGb.
  $BB51,$01 Move back to the first byte.
  $BB52,$01 Keep its address in #REGde.
  $BB53,$03 Add #REGbc to the bounty.
  $BB56,$04 Add the first byte of the reward to the most significant byte of the
. bounty.
  $BB5A,$03 Print the bounty.
  $BB5D,$04 Add one to the number of lives, to make up for the one which the
. next stage takes.
  $BB61,$04 Move on to the next level.
  $BB65,$01 Fetch the level.
  $BB66,$04 Jump to #R$BB6D if there are more levels.
  $BB6A,$03 Go back to the sixteenth level.
@ $BB6D label=GiveReward_Skill
  $BB6D,$02,b$01 Test whether the level is odd.
  $BB6F,$02 Jump if it is.
  $BB71,$03 Point #REGhl at #R$A261.
  $BB74,$01 Fetch the skill level.
  $BB75,$04 Jump to #R$BB7A if it is already as high as it goes.
  $BB79,$01 Raise the skill level.
@ $BB7A label=GiveReward_CheckLevel
  $BB7A,$03 Fetch the level.
  $BB7D,$02,b$01 Test whether this is the fourth level.
  $BB7F,$03 End the stage if it is not.
N $BB82 Show the bonus message, play a fanfare and set up the stage of money
. bags.
  $BB82,$03 Clear the buffer.
  $BB85,$03 Draw the buffer on the screen, which blanks it, and clear it again.
N $BB88 Print the bonus message.
  $BB88,$03 Point #REGhl at #N$40EB (in the screen buffer).
  $BB8B,$03 Point #REGde at #R$BBB4.
  $BB8E,$03 Print the message.
  $BB91,$03 Point #REGde at #R$B1E0.
  $BB94,$03 Play the fanfare.
  $BB97,$02 Set the length of the delay.
  $BB99,$03 Set the longest wait, which is a count of zero.
  $BB9C,$03 Wait for a while.
  $BB9F,$06 Set #R$A264 to #N$14 bags and #R$A265 to the money-bag stage.
  $BBA5,$03 Remove all of the objects.
  $BBA8,$02 Set #REGa to #COLOUR$46.
  $BBAA,$03 Store it as the screen colour.
  $BBAD,$04 Add another, to make up for the one which the bonus stage takes.
  $BBB1,$03 Start the stage.

t $BBB4 Messaging: Bonus Text
@ $BBB4 label=BonusMessage
D $BBB4 The message which is shown before the stage of money bags: an attribute
. byte, characters and a zero byte.
B $BBB4,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $BBB5,$05 "BONUS"
B $BBBA,$01 Terminator.

w $BBBB Dying Outlaw Sprites
@ $BBBB label=DyingOutlawSprites
D $BBBB The sprite lists of the dying outlaw, which are drawn in the buffer:
. #R$BBC1, #R$BBC5 and #R$BBC8, which is also used for a shot outlaw.
W $BBBB,$06,$02 The addresses of #R$BBC1, #R$BBC5 and #R$BBC8.
@ $BBC1 label=DyingOutlawSprites_FirstFrame
B $BBC1,$04 The first frame: #SPRITE$20(legs-5*)
. #SPRITE$21(legs-6*) #SPRITE$22(legs-7*) #SPRITE$23(legs-8*).
@ $BBC5 label=DyingOutlawSprites_SecondFrame
B $BBC5,$03 The second frame: #SPRITE$24(man-1*)
. #SPRITE$25(man-2*) #SPRITE$26(man-3*).
@ $BBC8 label=DyingOutlawSprites_Shot
B $BBC8,$02 A shot outlaw: #SPRITE$27(man-4*) #SPRITE$28(bullet*).

c $BBCA Move Duel Outlaw
@ $BBCA label=MoveDuelOutlaw
D $BBCA Moves the outlaw in the duel by his speeds. Both his positions are
. single bytes in this stage.
R $BBCA IX The address of the outlaw
  $BBCA,$03 Fetch the horizontal position.
  $BBCD,$03 Add the horizontal speed.
  $BBD0,$03 Set the new horizontal position.
  $BBD3,$03 Fetch the vertical position.
  $BBD6,$03 Add the vertical speed.
  $BBD9,$03 Set the new vertical position.
  $BBDC,$01 Return.

c $BBDD Keep Outlaw On Screen
@ $BBDD label=KeepOutlawOnScreen
D $BBDD Checks whether the next move would take the outlaw past an edge of the
. area he moves in, and if so changes his speed so that he does not go past it,
. and sets a bit in #REGix+#N$05 for the edge: bit 0 for the left edge, bit 1
. for the right edge, bit 2 for the lower edge and bit 3 for the upper edge.
R $BBDD IX The address of the outlaw
  $BBDD,$04 Clear the flags for the edges.
  $BBE1,$03 Fetch the horizontal position.
  $BBE4,$03 Add the horizontal speed.
  $BBE7,$02 Subtract the left edge.
  $BBE9,$02 Jump if the outlaw is not past it.
  $BBEB,$02 Make the distance past the edge positive.
  $BBED,$03 Set it as the horizontal speed, which bounces him back to the right.
  $BBF0,$04 Set the flag for the left edge.
@ $BBF4 label=KeepOutlawOnScreen_Right
  $BBF4,$03 Fetch the horizontal position.
  $BBF7,$03 Add the width of the outlaw.
  $BBFA,$03 Add the horizontal speed.
  $BBFD,$02 Subtract the right edge.
  $BBFF,$02 Jump if the outlaw is not past it.
  $BC01,$02 Subtract it from zero, to give the distance still to go to the edge.
  $BC03,$03 Add the horizontal speed.
  $BC06,$03 Set it as the horizontal speed, which stops him at the edge.
  $BC09,$04 Set the flag for the right edge.
@ $BC0D label=KeepOutlawOnScreen_Lower
  $BC0D,$03 Fetch the vertical position.
  $BC10,$03 Add the vertical speed.
  $BC13,$02 Subtract the lower edge.
  $BC15,$02 Jump if the outlaw is not past it.
  $BC17,$02 Make the distance past the edge positive.
  $BC19,$03 Set it as the vertical speed, which bounces him back up.
  $BC1C,$04 Set the flag for the lower edge.
@ $BC20 label=KeepOutlawOnScreen_Upper
  $BC20,$03 Fetch the vertical position.
  $BC23,$03 Add the height of the outlaw.
  $BC26,$03 Add the vertical speed.
  $BC29,$02 Subtract the upper edge.
  $BC2B,$02 Return if the outlaw is not past it.
  $BC2D,$02 Subtract it from zero, to give a speed which takes him back down.
  $BC2F,$03 Set it as the vertical speed.
  $BC32,$04 Set the flag for the upper edge.
@ $BC36 label=KeepOutlawOnScreen_Finish
  $BC36,$01 Return.

c $BC37 Choose Outlaw Move
@ $BC37 label=ChooseOutlawMove
D $BC37 Gives the waiting outlaw a new move: a speed in each direction of up to
. three, taken from random numbers, and a time for the move of eight to thirty
. nine frames. On the last move the speeds are doubled.
R $BC37 IX The address of the outlaw
  $BC37,$04 Fetch a random number and keep it in #REGc.
  $BC3B,$02,b$01 Keep a number from #N$00 to #N$03.
  $BC3D,$04 Jump to #R$BC43 if the top bit of the random number is clear.
  $BC41,$02 Make the speed negative.
@ $BC43 label=ChooseOutlawMove_Vertical
  $BC43,$03 Set the horizontal speed.
  $BC46,$04 Fetch another random number and keep it in #REGc.
  $BC4A,$02,b$01 Keep a number from #N$00 to #N$03.
  $BC4C,$04 Jump to #R$BC52 if the top bit of the random number is clear.
  $BC50,$02 Make the speed negative.
@ $BC52 label=ChooseOutlawMove_Time
  $BC52,$03 Set the vertical speed.
  $BC55,$03 Fetch the frame counter.
  $BC58,$02,b$01 Keep a number from #N$00 to #N$1F.
  $BC5A,$02 Add eight.
  $BC5C,$03 Set the timer for the move.
  $BC5F,$03 Count down the moves left.
  $BC62,$01 Return unless that was the last move.
  $BC63,$04 Double the horizontal speed.
  $BC67,$04 Double the vertical speed.
  $BC6B,$01 Return.

c $BC6C Choose Outlaw Body
@ $BC6C label=ChooseOutlawBody
D $BC6C Chooses which of the two sprite lists for the body of the outlaw to
. draw. He takes a step every fourth frame while he is moving.
R $BC6C IX The address of the outlaw
R $BC6C O:DE The address of the sprite list
  $BC6C,$03 Fetch the horizontal speed.
  $BC6F,$03 Combine it with the vertical speed.
  $BC72,$02 Jump if he is not moving.
  $BC74,$03 Fetch the number of moves left.
  $BC77,$03 Combine it with the timer.
  $BC7A,$02 Jump if both are zero.
  $BC7C,$03 Fetch the frame counter.
  $BC7F,$02,b$01 Keep a number from #N$00 to #N$03.
  $BC81,$02 Jump unless it is every fourth frame.
  $BC83,$03 Take a step.
@ $BC86 label=ChooseOutlawBody_Step
  $BC86,$03 Fetch the step.
  $BC89,$02,b$01 Keep the lowest bit.
  $BC8B,$03 Point #REGde at #R$B5AA.
  $BC8E,$01 Return if the step is even.
  $BC8F,$03 Point #REGde at #R$B5AD.
  $BC92,$01 Return.

c $BC93 Create Crosshair
@ $BC93 label=CreateCrosshair
D $BC93 Puts the crosshair (an object of type #N$03) in the last object slot, if
. it is not already there.
  $BC93,$03 Point #REGde at the last object slot.
  $BC96,$03 Return if the last object slot is in use.
  $BC99,$03 Point #REGhl at #R$BCA2.
  $BC9C,$03 Set the size of an object slot in #REGbc.
  $BC9F,$02 Copy the template into the slot.
  $BCA1,$01 Return.

b $BCA2 Crosshair Template
@ $BCA2 label=CrosshairTemplate
D $BCA2 The initial contents of a slot for the crosshair (type #N$03). It starts
. in the middle of the screen. The final two bytes point to the sprite list.
B $BCA2,$0E,$08 Type, position, speed, size and counters.
W $BCB0,$02 The address of #R$BCB2.
@ $BCB2 label=CrosshairSpriteList
B $BCB2,$04,$04 The sprite list: sprite #N$2C at offset
. (#N($F4), #N$F4). #SPRITE$2C(crosshair*).

c $BCB6 Move Crosshair Left
@ $BCB6 label=MoveCrosshairLeft
D $BCB6 Part of the handler for the crosshair, which is entered when the left
. control is pressed. Moves the crosshair left, but not past the left limit.
R $BCB6 E The speed of the crosshair
R $BCB6 L The horizontal position of the crosshair
  $BCB6,$01 Fetch the horizontal position.
  $BCB7,$01 Subtract the speed.
  $BCB8,$04 Jump to #R$BCEE if the crosshair is not past it.
  $BCBC,$02 Stop at the left limit.
  $BCBE,$02 Jump to set the position.

c $BCC0 Move Crosshair Down
@ $BCC0 label=MoveCrosshairDown
D $BCC0 Part of the handler for the crosshair, which is entered when the down
. control is pressed. Moves the crosshair down, but not past the lower limit.
R $BCC0 E The speed of the crosshair
R $BCC0 H The vertical position of the crosshair
  $BCC0,$01 Fetch the vertical position.
  $BCC1,$01 Subtract the speed.
  $BCC2,$04 Jump to #R$BD22 if the crosshair is not past it.
  $BCC6,$02 Stop at the lower limit.
  $BCC8,$02 Jump to set the position.

c $BCCA Handle Crosshair
@ $BCCA label=HandleCrosshair
D $BCCA Type #N$03: the crosshair, which the player moves about the screen in
. the duel to aim at the outlaw. It is moved by the controls, and stays between
. limits. When the fire control is pressed it fires the revolver.
N $BCCA Reload the revolver if it needs it.
  $BCCA,$03 Call #R$C977.
  $BCCD,$03 Fetch the horizontal position into #REGl.
  $BCD0,$03 Fetch the vertical position into #REGh.
  $BCD3,$03 Fetch the speed into #REGe.
N $BCD6 Read the controls.
  $BCD6,$03 Call #R$D0E3.
N $BCD9 Move left or right, but not past the edges.
  $BCD9,$01 Fetch the controls into #REGa.
  $BCDA,$02,b$01 Keep the two bits.
  $BCDC,$02 Jump to #R$BCEF if neither or both are pressed.
  $BCDE,$04 Jump to #R$BCEF if both are pressed.
  $BCE2,$04 Jump to #R$BCB6 to move left if left is pressed.
  $BCE6,$01 Fetch the horizontal position.
  $BCE7,$01 Add the speed.
  $BCE8,$04 Jump to #R$BCEE if the crosshair is not past it.
  $BCEC,$02 Stop at the right limit.
@ $BCEE label=HandleCrosshair_SetHorizontal
  $BCEE,$01 Set the horizontal position.
N $BCEF See whether the controls are the keyboard.
@ $BCEF label=HandleCrosshair_Vertical
  $BCEF,$03 Fetch #R$A21C.
  $BCF2,$01 Move the bits for the controls into the low bits.
  $BCF3,$02,b$01 Keep the two bits.
  $BCF5,$03 Jump to #R$BD3A if the controls are the keyboard.
N $BCF8 Copy the joystick bits for up, down and fire into #REGb.
  $BCF8,$01 Fetch the controls into #REGa.
  $BCF9,$02 Clear #REGb.
  $BCFB,$04 Jump to #R$BD01 if up is not pressed.
  $BCFF,$02 Set the bit for up.
@ $BD01 label=HandleCrosshair_TestDown
  $BD01,$04 Jump to #R$BD07 if down is not pressed.
  $BD05,$02 Set the bit for down.
@ $BD07 label=HandleCrosshair_TestFire
  $BD07,$04 Jump to #R$BD0D if the fire control is not pressed.
  $BD0B,$02 Set the bit for fire.
N $BD0D Move up or down, but not past the edges.
@ $BD0D label=HandleCrosshair_MoveVertical
  $BD0D,$01 Fetch the controls.
  $BD0E,$02,b$01 Keep the up and down bits.
  $BD10,$02 Jump to #R$BD23 if neither or both are pressed.
  $BD12,$04 Jump to #R$BD23 if both are pressed.
  $BD16,$04 Jump to #R$BCC0 to move down if down is pressed.
  $BD1A,$01 Fetch the vertical position.
  $BD1B,$01 Add the speed.
  $BD1C,$04 Jump to #R$BD22 if the crosshair is not past it.
  $BD20,$02 Stop at the upper limit.
@ $BD22 label=HandleCrosshair_SetVertical
  $BD22,$01 Set the vertical position.
N $BD23 Store the new position.
@ $BD23 label=HandleCrosshair_SetPosition
  $BD23,$03 Set the horizontal position of the crosshair.
  $BD26,$03 Set the vertical position of the crosshair.
N $BD29 Set the position for drawing.
  $BD29,$03 Fetch the vertical position and clear #REGh.
  $BD2C,$03 Set #R$A24E.
  $BD2F,$01 Copy the vertical position into #REGl.
  $BD30,$03 Set #R$A250.
N $BD33 Fire the revolver if the fire control is pressed, then draw the
. crosshair.
  $BD33,$01 Pass the controls to the routine which fires the revolver.
  $BD34,$03 Call #R$C9EC.
  $BD37,$03 Jump to #R$BD69.
N $BD3A The controls are the keyboard, which sets the bits for down and up the
. other way round to the joysticks.
@ $BD3A label=HandleCrosshair_Keyboard
  $BD3A,$01 Fetch the controls.
  $BD3B,$02 Clear #REGb.
  $BD3D,$04 Jump to #R$BD43 if down is not pressed.
  $BD41,$02 Set the bit for down.
@ $BD43 label=HandleCrosshair_KeyboardTestUp
  $BD43,$04 Jump to #R$BD49 if up is not pressed.
  $BD47,$02 Set the bit for up.
@ $BD49 label=HandleCrosshair_KeyboardTestFire
  $BD49,$04 Jump to #R$BD4F if the fire control is not pressed.
  $BD4D,$02 Set the bit for fire.
N $BD4F Move the crosshair up or down.
@ $BD4F label=HandleCrosshair_KeyboardMove
  $BD4F,$03 Jump to #R$BD0D.

c $BD52 Draw Object
@ $BD52 label=DrawObject
D $BD52 Draws the sprites of an object which does not move with the town: the
. objects of the duel and the ones which stay in one place on the screen. The
. position of the object, which is a single byte for each direction, is where
. its sprites are drawn from. This routine also counts the object as drawn,
. which means that the stage is still running.
R $BD52 IX The address of the object
  $BD52,$02 Clear #REGh.
  $BD54,$03 Fetch the horizontal position of the object.
  $BD57,$03 Set the horizontal position for drawing.
  $BD5A,$03 Fetch the vertical position of the object.
  $BD5D,$03 Set the vertical position for drawing.
  $BD60,$02 Jump to count the object and draw it.

c $BD62 Draw Scrolling Object
@ $BD62 label=DrawScrollingObject
D $BD62 Draws the sprites of an object which is part of the town, where the
. position of the object has to be converted to a position on the screen.
E $BD62 Continue on to #R$BD69.
R $BD62 IX The address of the object
  $BD62,$03 Work out the position of the object on the screen.
@ $BD65 label=DrawScrollingObject_CountDrawn
  $BD65,$03 Point #REGhl at the count of objects drawn.
  $BD68,$01 Add one to it.

c $BD69 Draw Sprite List
@ $BD69 label=DrawSpriteList
D $BD69 Draws each sprite in the sprite list of an object. A sprite list is made
. of three bytes for each sprite: the horizontal offset, the vertical offset and
. the number of the sprite. The offsets are added to the position of the object,
. and the vertical offset of the object in byte #N$0D. A sprite which would
. start outside the screen is not drawn. The last byte of the list is #N$80.
R $BD69 IX The address of the object
  $BD69,$06 Fetch the address of the sprite list into #REGde.
@ $BD6F label=DrawSpriteList_Next
  $BD6F,$01 Fetch the horizontal offset of the sprite.
  $BD70,$01 Move on to the next byte.
  $BD71,$03 Return if it is the terminator.
  $BD74,$03 Fetch the horizontal position of the object.
  $BD77,$03 Add the offset to it.
  $BD7A,$01 Fetch the high byte.
  $BD7B,$03 Skip the sprite if its horizontal position is off the screen.
  $BD7E,$01 Fetch the low byte.
  $BD7F,$04 Jump to #R$BDAA to skip the sprite if it is past it.
  $BD83,$04 Jump to #R$BDAA to skip the sprite if it is past it.
  $BD87,$03 Set the horizontal pixel position.
  $BD8A,$03 Fetch the vertical position of the object.
  $BD8D,$01 Fetch the vertical offset of the sprite.
  $BD8E,$01 Move on to the next byte.
  $BD8F,$03 Add the vertical offset of the object.
  $BD92,$03 Add the offset to the vertical position.
  $BD95,$01 Fetch the high byte.
  $BD96,$03 Skip the sprite if its vertical position is off the screen.
  $BD99,$01 Fetch the low byte.
  $BD9A,$04 Jump to #R$BDAB to skip the sprite if it is past it.
  $BD9E,$03 Set the vertical pixel position.
  $BDA1,$01 Fetch the number of the sprite.
  $BDA2,$01 Move on to the next byte.
N $BDA3 Draw the sprite.
  $BDA3,$01 Stash the address in the list on the stack.
  $BDA4,$03 Call #R$BDAE.
  $BDA7,$01 Restore the address in the list from the stack.
N $BDA8 Go back for the next sprite.
  $BDA8,$02 Jump to #R$BD6F.
N $BDAA The sprite is off the screen horizontally, so skip the vertical
. offset as well.
@ $BDAA label=DrawSpriteList_Skip
  $BDAA,$01 Skip the vertical offset.
N $BDAB Skip the number of the sprite and go on to the next.
@ $BDAB label=DrawSpriteList_SkipSprite
  $BDAB,$01 Skip the number of the sprite.
N $BDAC Go back for the next sprite.
  $BDAC,$02 Jump to #R$BD6F.

c $BDAE Draw Sprite
@ $BDAE label=DrawSprite
D $BDAE Draws a sprite into the buffer, which is the picture of the play area,
. with twenty four bytes in each of one hundred and twelve rows. The sprite data
. is a byte for the number of columns, a byte for the number of rows, and for
. each row, from the bottom to the top, a mask byte and a pixel byte for each
. column. The mask clears the bits under the sprite and the pixels are then
. added.
R $BDAE A The number of the sprite
R $BDAE IX The address of the object
N $BDAE Bit 1 of #REGix+#N$07 is set to show that a sprite has been drawn. The
. sprite is shifted by the horizontal pixel position, which has to be even, and
. is flipped if bit 6 of the flags of the object is set. A shifted sprite is one
. byte wider, and the shifting is done by tables, which are built by #R$D4FD.
. The row of pixels is drawn by code for the right number of columns: the code
. was unrolled so that it can be fast, and the address in the jump at #R$A224 is
. set to the right place in it. The sprite data is taken off the stack. A sprite
. which is partly below the bottom or above the top of the play area has the
. rows which are outside it left out.
  $BDAE,$03 Point #REGbc at #R$67F4.
N $BDB1 Fetch the address of the sprite data.
  $BDB1,$03 Call #R$C75C.
  $BDB4,$01 Swap the address into #REGde.
  $BDB5,$07 Jump to #R$BEF8 to draw the flipped sprite if the object is flipped.
N $BDBC Fetch the horizontal pixel position.
  $BDBC,$03 Fetch #R$A220.
  $BDBF,$02,b$01 Keep the shift, which is zero, two, four or six pixels.
N $BDC1 Draw the sprite unshifted.
  $BDC1,$03 Jump to #R$BE49 if there is no shift.
  $BDC4,$02,b$01 Make the high byte of the address of the table for the shift.
  $BDC6,$01 Set #REGh.
  $BDC7,$01 Fetch the number of columns of the sprite.
  $BDC8,$01 Move on to the next byte.
  $BDC9,$02,b$01 Keep the low three bits.
  $BDCB,$01 Add one, as a shifted sprite is one byte wider.
  $BDCC,$01 Keep the widened column count in #REGb.
N $BDCD Store the number of bytes in a row of the sprite.
  $BDCD,$03 Set #R$A222.
  $BDD0,$01 Take one off again.
  $BDD1,$02,b$01 Keep the low three bits.
  $BDD3,$01 Double it.
  $BDD4,$01 Keep twice the column count in #REGc.
  $BDD5,$03 Multiply it by eight to make sixteen times the number of columns.
  $BDD8,$01 Add the double to make eighteen times.
  $BDD9,$02 Make it negative.
  $BDDB,$02 Add #N$5D, which gives the distance from #R$BE87 to the code for the
. number of columns. Each column has eighteen bytes of code.
@ $BDDD label=DrawSprite_SetJump
  $BDDD,$01 Stash the number of columns on the stack.
  $BDDE,$01 Stash the high byte of the shift table on the stack.
  $BDDF,$02 Clear #REGh.
  $BDE1,$01 Test the sign of the distance.
  $BDE2,$03 Jump to #R$BDE6 if it is positive.
  $BDE5,$01 Make #REGhl negative.
@ $BDE6 label=DrawSprite_SetJumpAddress
  $BDE6,$01 Put the distance in #REGl.
  $BDE7,$03 Point #REGbc at #R$BE87.
  $BDEA,$01 Add the distance to give the address to jump to.
N $BDEB Set the address of the jump at #R$A224.
  $BDEB,$03 Set #R$A225.
  $BDEE,$01 Restore the shift table from the stack.
  $BDEF,$01 Restore the number of bytes in a row from the stack.
  $BDF0,$01 Fetch the number of bytes in a row.
  $BDF1,$01 Invert it.
  $BDF2,$02 Add #N$1A, to give twenty five minus the number of bytes.
N $BDF4 Store the distance from the end of a row to the start of the next.
  $BDF4,$03 Set #R$A227.
  $BDF7,$01 Swap the address of the sprite data into #REGhl.
  $BDF8,$02 Set the number of rows in the buffer.
N $BDFA Fetch the vertical position.
  $BDFA,$03 Fetch #R$A221.
  $BDFD,$02 Subtract the position of the bottom row of the buffer.
  $BDFF,$02 Jump to #R$BE28 if the sprite starts below it.
  $BE01,$01 Subtract the number of rows in the buffer.
  $BE02,$01 Return if the sprite starts above the top.
  $BE03,$02 Make it positive, which is the number of rows up to the top.
  $BE05,$01 Compare it with the number of rows in the sprite.
  $BE06,$02 Jump to #R$BE09 if there is room for fewer rows.
  $BE08,$01 Use the number of rows in the sprite.
@ $BE09 label=DrawSprite_FirstByte
  $BE09,$01 Move on to the first byte of data.
N $BE0A Store the number of rows to draw.
  $BE0A,$03 Set #R$A223.
@ $BE0D label=DrawSprite_StartRows
  $BE0D,$01 Swap the address of the data into #REGde.
  $BE0E,$01 Stash the high byte of the shift table on the stack.
N $BE0F Fetch the pixel position.
  $BE0F,$03 Fetch #R$A220.
N $BE12 Find the address in the buffer.
  $BE12,$03 Call #R$D233.
  $BE15,$02 Keep the buffer address in #REGbc.
  $BE17,$01 Restore the shift table from the stack.
N $BE18 Save the stack pointer.
  $BE18,$04 Set #R$A21D.
  $BE1C,$03 Point the stack pointer at the sprite data.
  $BE1F,$04 Set the flag which shows that a sprite has been drawn.
N $BE23 Fetch the number of rows to draw.
  $BE23,$03 Fetch #R$A223.
N $BE26 Draw the first row.
  $BE26,$02 Jump to #R$BE85.
@ $BE28 label=DrawSprite_Below
  $BE28,$02 Make the number of rows below the bottom positive.
  $BE2A,$01 Keep the rows below the bottom of the sprite in #REGc.
  $BE2B,$01 Fetch the number of rows in the sprite.
  $BE2C,$01 Subtract the number below the bottom.
  $BE2D,$01 Return if the sprite is all below the bottom.
  $BE2E,$01 Return if there is nothing left.
N $BE2F Store the number of rows to draw.
  $BE2F,$03 Set #R$A223.
  $BE32,$02 Clear #REGb.
  $BE34,$01 Move back to the first byte of the sprite data.
  $BE35,$01 Fetch the number of columns.
  $BE36,$02,b$01 Keep the number of columns.
  $BE38,$02 Move on to the data.
  $BE3A,$04 Double the number of rows to skip.
@ $BE3E label=DrawSprite_SkipRows
  $BE3E,$04 Skip two bytes for each row below the bottom in each column.
N $BE42 Start drawing at the bottom of the buffer.
  $BE42,$05 Set #R$A221 to the bottom of the buffer.
N $BE47 Start the rows.
  $BE47,$02 Jump to #R$BE0D.
@ $BE49 label=DrawSprite_Aligned
  $BE49,$01 Fetch the number of columns of the sprite.
  $BE4A,$01 Move on to the next byte.
  $BE4B,$02,b$01 Keep the low four bits.
N $BE4D Store the number of bytes in a row of the sprite.
  $BE4D,$03 Set #R$A222.
  $BE50,$01 Keep the bytes in a row in #REGb.
  $BE51,$03 Multiply it by eight.
  $BE54,$02 Make it negative.
  $BE56,$02 Subtract four, which gives the distance from #R$BE87 to the code for
. the number of columns. Each column has eight bytes of code.
N $BE58 Set the address of the jump.
  $BE58,$03 Jump to #R$BDDD.

c $BE5B Draw Aligned Columns
@ $BE5B label=DrawAlignedColumns
D $BE5B Draws the columns of a sprite which is not shifted or flipped. There is
. a piece of code for each of up to five columns, and the code for the width of
. the sprite is where the jump at #R$A224 starts. Each piece takes the mask and
. the pixels for one byte of the row from the sprite data on the stack, wipes
. the screen where the mask is and puts the pixels in. The buffer address is in
. #REGbc.
E $BE5B View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D08F }
. { #KNIGHTLORE$D780 }
. { #NIGHTSHADE$E49F }
. { #PENTAGRAM$B44F }
. LIST#
  $BE5B,$01 Fetch the mask into #REGe and the pixels into #REGd.
  $BE5C,$04 Clear the screen bits under the mask.
  $BE60,$01 Add the pixels.
  $BE61,$02 Store the byte and move on to the next.
  $BE63,$01 Fetch the mask into #REGe and the pixels into #REGd.
  $BE64,$04 Clear the screen bits under the mask.
  $BE68,$01 Add the pixels.
  $BE69,$02 Store the byte and move on to the next.
  $BE6B,$01 Fetch the mask into #REGe and the pixels into #REGd.
  $BE6C,$04 Clear the screen bits under the mask.
  $BE70,$01 Add the pixels.
  $BE71,$02 Store the byte and move on to the next.
  $BE73,$01 Fetch the mask into #REGe and the pixels into #REGd.
  $BE74,$04 Clear the screen bits under the mask.
  $BE78,$01 Add the pixels.
  $BE79,$02 Store the byte and move on to the next.
  $BE7B,$01 Fetch the mask into #REGe and the pixels into #REGd.
  $BE7C,$04 Clear the screen bits under the mask.
  $BE80,$01 Add the pixels.
  $BE81,$01 Store the byte.
N $BE82 Finish the row.
  $BE82,$03 Jump to #R$BEE5.

c $BE85 Draw Sprite Row
@ $BE85 label=DrawSpriteRow
D $BE85 Starts to draw a row of a sprite. The number of rows left is kept in the
. alternate accumulator while the code for the columns uses #REGa. The jump at
. #R$A224 goes to the code for the columns of the sprite.
  $BE85,$01 Save the number of rows left, and get #REGa.
  $BE86,$01 Fetch the first byte of the row from the buffer.
N $BE87 Jump to the code for the columns.
@ $BE87 label=DrawSprite_Jump
  $BE87,$03 Jump to #R$A224.

c $BE8A Draw Shifted Columns
@ $BE8A label=DrawShiftedColumns
D $BE8A Draws the columns of a sprite which is shifted to the right by two, four
. or six pixels. There is a piece of code for each of up to five columns of the
. sprite, and the code for the width of the sprite is where the jump at #R$A224
. starts. Each piece puts a column into two bytes of the buffer, using the table
. for the shift to split the mask and the pixels in two. The buffer address is
. in #REGbc.
E $BE8A Continue on to #R$BEE5.
E $BE8A View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E4CD }
. LIST#
  $BE8A,$02 Invert the screen byte, and fetch the mask into #REGe and the pixels
. into #REGd.
  $BE8C,$03 Clear the screen bits under the part of the mask which is in this
. byte.
  $BE8F,$02 Add the part of the pixels which is in this byte.
  $BE91,$02 Store the byte and move on to the next.
  $BE93,$03 Point #REGh at the table for the bits which move into the next byte,
. and fetch that screen byte.
  $BE96,$03 Clear the screen bits under the part of the mask which has moved
. into it.
  $BE99,$02 Add the part of the pixels which has moved into it.
  $BE9B,$01 Point #REGh back at the first table.
  $BE9C,$02 Invert the screen byte, and fetch the mask into #REGe and the pixels
. into #REGd.
  $BE9E,$03 Clear the screen bits under the part of the mask which is in this
. byte.
  $BEA1,$02 Add the part of the pixels which is in this byte.
  $BEA3,$02 Store the byte and move on to the next.
  $BEA5,$03 Point #REGh at the table for the bits which move into the next byte,
. and fetch that screen byte.
  $BEA8,$03 Clear the screen bits under the part of the mask which has moved
. into it.
  $BEAB,$02 Add the part of the pixels which has moved into it.
  $BEAD,$01 Point #REGh back at the first table.
  $BEAE,$02 Invert the screen byte, and fetch the mask into #REGe and the pixels
. into #REGd.
  $BEB0,$03 Clear the screen bits under the part of the mask which is in this
. byte.
  $BEB3,$02 Add the part of the pixels which is in this byte.
  $BEB5,$02 Store the byte and move on to the next.
  $BEB7,$03 Point #REGh at the table for the bits which move into the next byte,
. and fetch that screen byte.
  $BEBA,$03 Clear the screen bits under the part of the mask which has moved
. into it.
  $BEBD,$02 Add the part of the pixels which has moved into it.
  $BEBF,$01 Point #REGh back at the first table.
  $BEC0,$02 Invert the screen byte, and fetch the mask into #REGe and the pixels
. into #REGd.
  $BEC2,$03 Clear the screen bits under the part of the mask which is in this
. byte.
  $BEC5,$02 Add the part of the pixels which is in this byte.
  $BEC7,$02 Store the byte and move on to the next.
  $BEC9,$03 Point #REGh at the table for the bits which move into the next byte,
. and fetch that screen byte.
  $BECC,$03 Clear the screen bits under the part of the mask which has moved
. into it.
  $BECF,$02 Add the part of the pixels which has moved into it.
  $BED1,$01 Point #REGh back at the first table.
  $BED2,$02 Invert the screen byte, and fetch the mask into #REGe and the pixels
. into #REGd.
  $BED4,$03 Clear the screen bits under the part of the mask which is in this
. byte.
  $BED7,$02 Add the part of the pixels which is in this byte.
  $BED9,$02 Store the byte and move on to the next.
  $BEDB,$03 Point #REGh at the table for the bits which move into the next byte,
. and fetch that screen byte.
  $BEDE,$03 Clear the screen bits under the part of the mask which has moved
. into it.
  $BEE1,$02 Add the part of the pixels which has moved into it.
  $BEE3,$01 Point #REGh back at the first table.
  $BEE4,$01 Store the last byte of the row.

c $BEE5 Finish Sprite Row
@ $BEE5 label=FinishSpriteRow
D $BEE5 Moves to the next row of the buffer after a row of a sprite has been
. drawn, and starts the next row if there are any left.
  $BEE5,$03 Fetch the distance from #R$A227 to the start of the next row.
  $BEE8,$01 Add it to the low byte of the buffer address.
  $BEE9,$01 Set the low byte.
  $BEEA,$01 Fetch the high byte.
  $BEEB,$02 Add the carry.
  $BEED,$01 Set the high byte.
  $BEEE,$01 Fetch the number of rows left.
  $BEEF,$01 Take one off.
N $BEF0 Draw the next row if there are any left.
  $BEF0,$03 Jump to #R$BE85 if there are any.
  $BEF3,$04 Restore the stack pointer.
  $BEF7,$01 Return.

c $BEF8 Draw Flipped Sprite
@ $BEF8 label=DrawFlippedSprite
D $BEF8 Draws a sprite which is flipped, so that it faces the other way. It
. works in the same way as #R$BDAE, but it draws from the right-hand end of each
. row to the left, and the tables turn the bits of each byte round as well as
. shifting them.
R $BEF8 DE The address of the sprite data
R $BEF8 IX The address of the object
N $BEF8 Fetch the horizontal pixel position.
  $BEF8,$03 Fetch #R$A220.
  $BEFB,$02,b$01 Keep the shift, which is zero, two, four or six pixels.
N $BEFD Draw the sprite unshifted.
  $BEFD,$03 Jump to #R$BF8D if there is no shift.
  $BF00,$02,b$01 Make the high byte of the address of the table for the shift.
  $BF02,$01 Set #REGh.
  $BF03,$01 Fetch the number of columns of the sprite.
  $BF04,$01 Move on to the next byte.
  $BF05,$02,b$01 Keep the low three bits.
  $BF07,$01 Add one, as a shifted sprite is one byte wider.
  $BF08,$01 Keep the widened column count in #REGb.
N $BF09 Store the number of bytes in a row of the sprite.
  $BF09,$03 Set #R$A222.
  $BF0C,$01 Take one off again.
  $BF0D,$02,b$01 Keep the low three bits.
  $BF0F,$01 Double it.
  $BF10,$01 Keep twice the column count in #REGc.
  $BF11,$03 Multiply it by eight to make sixteen times the number of columns.
  $BF14,$01 Add the double to make eighteen times.
  $BF15,$02 Make it negative.
  $BF17,$02 Add #N$5D, which gives the distance from #R$BFD8 to the code for the
. number of columns. Each column has eighteen bytes of code.
@ $BF19 label=DrawFlippedSprite_SetJump
  $BF19,$01 Stash the number of columns on the stack.
  $BF1A,$01 Stash the high byte of the shift table on the stack.
  $BF1B,$02 Clear #REGh.
  $BF1D,$04 Jump to #R$BF22 if the distance is positive.
  $BF21,$01 Make #REGhl negative.
@ $BF22 label=DrawFlippedSprite_SetJumpAddress
  $BF22,$01 Put the distance in #REGl.
  $BF23,$03 Point #REGbc at #R$BFD8.
  $BF26,$01 Add the distance to give the address to jump to.
N $BF27 Set the address of the jump at #R$A224.
  $BF27,$03 Set #R$A225.
  $BF2A,$01 Restore the shift table from the stack.
  $BF2B,$01 Restore the number of bytes in a row from the stack.
  $BF2C,$01 Fetch the number of bytes in a row.
  $BF2D,$02 Add #N$17, to give twenty three more than the number of bytes.
N $BF2F Store the distance from the end of a row to the start of the next.
  $BF2F,$03 Set #R$A227.
  $BF32,$01 Swap the address of the sprite data into #REGhl.
  $BF33,$02 Set the number of rows in the buffer.
N $BF35 Fetch the vertical position.
  $BF35,$03 Fetch #R$A221.
  $BF38,$02 Subtract the position of the bottom row of the buffer.
  $BF3A,$02 Jump to #R$BF6C if the sprite starts below it.
  $BF3C,$01 Subtract the number of rows in the buffer.
  $BF3D,$01 Return if the sprite starts above the top.
  $BF3E,$02 Make it positive, which is the number of rows up to the top.
  $BF40,$01 Compare it with the number of rows in the sprite.
  $BF41,$02 Jump to #R$BF44 if there is room for fewer rows.
  $BF43,$01 Use the number of rows in the sprite.
@ $BF44 label=DrawFlippedSprite_FirstByte
  $BF44,$01 Move on to the first byte of data.
N $BF45 Store the number of rows to draw.
  $BF45,$03 Set #R$A223.
@ $BF48 label=DrawFlippedSprite_StartRows
  $BF48,$01 Swap the address of the data into #REGde.
  $BF49,$01 Stash the high byte of the shift table on the stack.
N $BF4A Fetch the pixel position.
  $BF4A,$03 Fetch #R$A220.
N $BF4D Fetch the number of bytes in a row.
  $BF4D,$03 Fetch #R$A222.
  $BF50,$01 Take one off.
  $BF51,$03 Multiply it by eight to give the pixels in all but one of the
. columns.
  $BF54,$01 Add it to the horizontal position, to give the right-hand end of the
. row.
  $BF55,$01 Set it in #REGl.
N $BF56 Find the address in the buffer.
  $BF56,$03 Call #R$D233.
  $BF59,$02 Keep the buffer address in #REGbc.
  $BF5B,$01 Restore the shift table from the stack.
N $BF5C Save the stack pointer.
  $BF5C,$04 Set #R$A21D.
  $BF60,$03 Point the stack pointer at the sprite data.
  $BF63,$04 Set the flag which shows that a sprite has been drawn.
N $BF67 Fetch the number of rows to draw.
  $BF67,$03 Fetch #R$A223.
N $BF6A Draw the first row.
  $BF6A,$02 Jump to #R$BFD6.
@ $BF6C label=DrawFlippedSprite_BelowBottom
N $BF6C The sprite starts below the bottom of the buffer, so skip those
. rows.
  $BF6C,$02 Make the number of rows below the bottom positive.
  $BF6E,$01 Keep the rows below the bottom of the sprite in #REGc.
  $BF6F,$01 Fetch the number of rows in the sprite.
  $BF70,$01 Subtract the number below the bottom.
  $BF71,$01 Return if the sprite is all below the bottom.
  $BF72,$01 Return if there is nothing left.
N $BF73 Store the number of rows to draw.
  $BF73,$03 Set #R$A223.
  $BF76,$02 Clear #REGb.
  $BF78,$01 Move back to the first byte of the sprite data.
  $BF79,$01 Fetch the first byte of the sprite.
  $BF7A,$02,b$01 Keep only the number of columns.
  $BF7C,$02 Move on to the data.
  $BF7E,$04 Double the number of rows to skip.
@ $BF82 label=DrawFlippedSprite_SkipRows
  $BF82,$04 Skip two bytes for each row below the bottom in each column.
N $BF86 Start drawing at the bottom of the buffer.
  $BF86,$05 Set #R$A221 to the bottom of the buffer.
N $BF8B Start the rows.
  $BF8B,$02 Jump to #R$BF48.
@ $BF8D label=DrawFlippedSprite_Aligned
  $BF8D,$02 Point #REGh at the table which only turns the bits round.
  $BF8F,$01 Fetch the number of columns of the sprite.
  $BF90,$01 Move on to the next byte.
  $BF91,$02,b$01 Keep the low four bits.
N $BF93 Store the number of bytes in a row of the sprite.
  $BF93,$03 Set #R$A222.
  $BF96,$01 Keep the bytes in a row in #REGb.
  $BF97,$03 Multiply it by eight.
  $BF9A,$02 Add it twice more to make ten times the number of columns.
  $BF9C,$02 Make it negative.
  $BF9E,$02 Subtract three, which gives the distance from #R$BFD8 to the code
. for the number of columns. Each column has ten bytes of code.
N $BFA0 Set the address of the jump.
  $BFA0,$03 Jump to #R$BF19.

c $BFA3 Draw Flipped Aligned Columns
@ $BFA3 label=DrawFlippedAlignedColumns
D $BFA3 Draws the columns of a sprite which is flipped but not shifted. There is
. a piece of code for each of up to five columns, and the code for the width of
. the sprite is where the jump at #R$A224 starts. Each piece takes the mask and
. the pixels for one byte from the sprite data on the stack, turns them round
. with the table, wipes the screen where the mask is and puts the pixels in. It
. works from right to left.
N $BFA3 The jump at #R$A224 starts here for five columns.
  $BFA3,$01 Restore the mask into #REGe and the pixels into #REGd
. from the stack.
  $BFA4,$04 Turn the mask round and clear the screen bits under it.
  $BFA8,$02 Turn the pixels round and add them.
  $BFAA,$03 Store the byte, move to the byte on the left and fetch it.
N $BFAD The jump at #R$A224 starts here for four columns.
  $BFAD,$01 Restore the mask into #REGe and the pixels into #REGd
. from the stack.
  $BFAE,$04 Turn the mask round and clear the screen bits under it.
  $BFB2,$02 Turn the pixels round and add them.
  $BFB4,$03 Store the byte, move to the byte on the left and fetch it.
N $BFB7 The jump at #R$A224 starts here for three columns.
  $BFB7,$01 Restore the mask into #REGe and the pixels into #REGd
. from the stack.
  $BFB8,$04 Turn the mask round and clear the screen bits under it.
  $BFBC,$02 Turn the pixels round and add them.
  $BFBE,$03 Store the byte, move to the byte on the left and fetch it.
N $BFC1 The jump at #R$A224 starts here for two columns.
  $BFC1,$01 Restore the mask into #REGe and the pixels into #REGd
. from the stack.
  $BFC2,$04 Turn the mask round and clear the screen bits under it.
  $BFC6,$02 Turn the pixels round and add them.
  $BFC8,$03 Store the byte, move to the byte on the left and fetch it.
N $BFCB The jump at #R$A224 starts here for one column.
  $BFCB,$01 Restore the mask into #REGe and the pixels into #REGd
. from the stack.
  $BFCC,$04 Turn the mask round and clear the screen bits under it.
  $BFD0,$02 Turn the pixels round and add them.
  $BFD2,$01 Store the byte.
N $BFD3 Finish the row.
  $BFD3,$03 Jump to #R$BEE5.

c $BFD6 Draw Flipped Row
@ $BFD6 label=DrawFlippedRow
D $BFD6 Starts to draw a row of a flipped sprite. The number of rows left is
. kept in the alternate accumulator while the code for the columns uses #REGa.
. The jump at #R$A224 goes to the code for the columns of the sprite.
  $BFD6,$01 Save the number of rows left, and get #REGa.
  $BFD7,$01 Fetch the first byte of the row from the buffer.
N $BFD8 Jump to the code for the columns.
@ $BFD8 label=DrawFlipped_SpriteJump
  $BFD8,$03 Jump to #R$A224.

c $BFDB Draw Flipped Shifted Columns
@ $BFDB label=DrawFlippedShiftedColumns
D $BFDB Draws the columns of a sprite which is flipped and shifted. There is a
. piece of code for each of up to five columns of the sprite, and the code for
. the width of the sprite is where the jump at #R$A224 starts. Each piece puts a
. column into two bytes of the buffer, using the table for the shift to turn the
. mask and the pixels round and split them in two. It works from right to left.
E $BFDB Continue on to #R$C036.
N $BFDB The jump at #R$A224 starts here for five columns.
  $BFDB,$01 Invert the screen byte.
  $BFDC,$01 Restore the mask into #REGe and the pixels into #REGd
. from the stack.
  $BFDD,$03 Clear the screen bits under the part of the mask which is in this
. byte.
  $BFE0,$02 Add the part of the pixels which is in this byte.
  $BFE2,$02 Store the byte and move on to the byte on the left.
  $BFE4,$03 Point #REGh at the table for the bits which move into the next byte,
. and fetch that screen byte.
  $BFE7,$03 Clear the screen bits under the part of the mask which has moved
. into it.
  $BFEA,$02 Add the part of the pixels which has moved into it.
  $BFEC,$01 Point #REGh back at the first table.
N $BFED The jump at #R$A224 starts here for four columns.
  $BFED,$01 Invert the screen byte.
  $BFEE,$01 Restore the mask into #REGe and the pixels into #REGd
. from the stack.
  $BFEF,$03 Clear the screen bits under the part of the mask which is in this
. byte.
  $BFF2,$02 Add the part of the pixels which is in this byte.
  $BFF4,$02 Store the byte and move on to the byte on the left.
  $BFF6,$03 Point #REGh at the table for the bits which move into the next byte,
. and fetch that screen byte.
  $BFF9,$03 Clear the screen bits under the part of the mask which has moved
. into it.
  $BFFC,$02 Add the part of the pixels which has moved into it.
  $BFFE,$01 Point #REGh back at the first table.
N $BFFF The jump at #R$A224 starts here for three columns.
  $BFFF,$01 Invert the screen byte.
  $C000,$01 Restore the mask into #REGe and the pixels into #REGd
. from the stack.
  $C001,$03 Clear the screen bits under the part of the mask which is in this
. byte.
  $C004,$02 Add the part of the pixels which is in this byte.
  $C006,$02 Store the byte and move on to the byte on the left.
  $C008,$03 Point #REGh at the table for the bits which move into the next byte,
. and fetch that screen byte.
  $C00B,$03 Clear the screen bits under the part of the mask which has moved
. into it.
  $C00E,$02 Add the part of the pixels which has moved into it.
  $C010,$01 Point #REGh back at the first table.
N $C011 The jump at #R$A224 starts here for two columns.
  $C011,$01 Invert the screen byte.
  $C012,$01 Restore the mask into #REGe and the pixels into #REGd
. from the stack.
  $C013,$03 Clear the screen bits under the part of the mask which is in this
. byte.
  $C016,$02 Add the part of the pixels which is in this byte.
  $C018,$02 Store the byte and move on to the byte on the left.
  $C01A,$03 Point #REGh at the table for the bits which move into the next byte,
. and fetch that screen byte.
  $C01D,$03 Clear the screen bits under the part of the mask which has moved
. into it.
  $C020,$02 Add the part of the pixels which has moved into it.
  $C022,$01 Point #REGh back at the first table.
N $C023 The jump at #R$A224 starts here for one column.
  $C023,$01 Invert the screen byte.
  $C024,$01 Restore the mask into #REGe and the pixels into #REGd
. from the stack.
  $C025,$03 Clear the screen bits under the part of the mask which is in this
. byte.
  $C028,$02 Add the part of the pixels which is in this byte.
  $C02A,$02 Store the byte and move on to the byte on the left.
  $C02C,$03 Point #REGh at the table for the bits which move into the next byte,
. and fetch that screen byte.
  $C02F,$03 Clear the screen bits under the part of the mask which has moved
. into it.
  $C032,$02 Add the part of the pixels which has moved into it.
  $C034,$01 Point #REGh back at the first table.
  $C035,$01 Store the last byte of the row.

c $C036 Finish Flipped Sprite Row
@ $C036 label=FinishFlippedSpriteRow
D $C036 Moves to the next row of the buffer after a row of a flipped sprite has
. been drawn, and starts the next row if there are any left.
  $C036,$03 Fetch the distance from #R$A227 to the start of the next row.
  $C039,$01 Add it to the low byte of the buffer address.
  $C03A,$01 Set the low byte.
  $C03B,$01 Fetch the high byte.
  $C03C,$02 Add the carry.
  $C03E,$01 Set the high byte.
  $C03F,$01 Fetch the number of rows left.
  $C040,$01 Take one off.
N $C041 Draw the next row if there are any left.
  $C041,$03 Jump to #R$BFD6 if there are any.
  $C044,$04 Restore the stack pointer.
  $C048,$01 Return.

c $C049 Check Sheriff Lost
@ $C049 label=CheckSheriffLost
D $C049 Called every frame. If #R$A27D, which holds the sheriff, and #R$A35D,
. which holds the crosshair, are both empty, then a stage is starting or the
. sheriff has been lost. The routine takes a life away. When there is no life
. left it shows "GAME OVER" and works out the top score, or if there are two
. players it moves on to the other player. Otherwise it makes the sheriff
. arrive in the town, or the crosshair in the duel and the bonus stage.
N $C049 Fetch the type of the first object slot.
  $C049,$04 Fetch #R$A27D and keep it in #REGc.
N $C04D Fetch the type of the last object slot.
  $C04D,$03 Fetch #R$A35D.
  $C050,$02 Return if either of the slots is in use.
N $C052 Clear the delay before the next shot.
  $C052,$03 Set #R$A245.
N $C055 Clear the flag which shows that the revolver is being reloaded.
  $C055,$03 Set #R$A246.
N $C058 Fetch the options.
  $C058,$03 Fetch #R$A21C.
N $C05B See whether there are two players.
  $C05B,$04 Jump to #R$C084 if there are.
@ $C05F label=CheckSheriffLost_TakeLife
N $C05F Take a life away.
  $C05F,$03 Point #REGhl at #R$A263.
  $C062,$01 Take one off.
N $C063 There are no lives left.
  $C063,$03 Jump to #R$C0B6 if there are none.
N $C066 Clear the flag that a stage is starting.
  $C066,$04 Write #N$00 to #R$A240.
N $C06A Fetch the kind of stage.
  $C06A,$03 Fetch #R$A265.
N $C06D The stage has a crosshair.
  $C06D,$04 Jump to #R$BC93 if it has.
N $C071 Copy the sheriff template into the first slot.
  $C071,$03 Point #REGhl at #R$C0BC.
  $C074,$03 Point #REGde at #R$A27D.
  $C077,$03 Set the size of an object slot in #REGbc.
  $C07A,$02 Copy the template into the slot.
N $C07C Set the top speed of the sheriff.
  $C07C,$05 Set #R$A21F to #N$0A.
N $C081 Draw the lives.
  $C081,$03 Jump to #R$D27C.
@ $C084 label=CheckSheriffLost_TwoPlayers
N $C084 Fetch the flag which shows that a stage is starting.
  $C084,$03 Fetch #R$A240.
N $C087 Take a life if a stage is starting.
  $C087,$03 Jump to #R$C05F if it is.
N $C08A Fetch the number of lives.
  $C08A,$03 Fetch #R$A263.
N $C08D The player has lives left.
  $C08D,$03 Jump to #R$C0B1 if there are any.
N $C090 Show "GAME OVER" for this player.
  $C090,$03 Call #R$B7A8.
N $C093 Fetch the number of the current player.
  $C093,$03 Fetch #R$A23F.
N $C096 Check the top score if the second player has finished.
  $C096,$04 Jump to #R$A50A if the second player has finished.
@ $C09A label=CheckSheriffLost_ChangePlayer
N $C09A Switch to the other player.
  $C09A,$02,b$01 Switch to the other player.
N $C09C Set the number of the current player.
  $C09C,$03 Set #R$A23F.
N $C09F Remove all of the objects.
  $C09F,$03 Call #R$C7C8.
N $C0A2 Swap the states of the two players.
  $C0A2,$03 Call #R$A6EA.
N $C0A5 Show the number of the player.
  $C0A5,$03 Call #R$A6C9.
N $C0A8 Fetch the colour of the screen.
  $C0A8,$04 Fetch #R$A266 and keep it in #REGe.
N $C0AC Draw the screen furniture.
  $C0AC,$03 Call #R$D2FB.
N $C0AF Take a life.
  $C0AF,$02 Jump to #R$C05F.
@ $C0B1 label=CheckSheriffLost_LivesLeft
N $C0B1 Fetch the number of the current player.
  $C0B1,$03 Fetch #R$A23F.
N $C0B4 Change to the other player.
  $C0B4,$02 Jump to #R$C09A.
@ $C0B6 label=CheckSheriffLost_GameOver
N $C0B6 Show "GAME OVER".
  $C0B6,$03 Call #R$B7A8.
N $C0B9 Work out the top score.
  $C0B9,$03 Jump to #R$A50D.

b $C0BC Sheriff Template
@ $C0BC label=SheriffTemplate
D $C0BC The initial contents of a slot for the sheriff when he comes back after
. losing a life. It is an object of type #N$19, which waits sixteen frames
. before the sheriff arrives, at the place where he starts. The final two bytes
. point to the sprite list.
B $C0BC,$0E,$08 Type, position, speed, size and counters.
W $C0CA,$02 The sprite list, which is a dead figure.

c $C0CC Advance Frame Counter
@ $C0CC label=AdvanceFrameCounter
D $C0CC Adds one to the frame counter, and then updates the random numbers.
E $C0CC Continue on to #R$C0D3.
  $C0CC,$03 Fetch the frame counter.
  $C0CF,$01 Add one.
  $C0D0,$03 Store the new frame counter.

c $C0D3 Update Random Numbers
@ $C0D3 label=UpdateRandomNumbers
D $C0D3 Stirs the two random numbers in #R$A218 and #R$A21A. The first uses
. #R$A216 and the refresh register, and the second uses the frame counter
. and the return address, so it is different for every routine which calls this.
N $C0D3 Stir the first random number with the frame counter and the
. refresh register.
  $C0D3,$04 Fetch #R$A216 into #REGde.
  $C0D7,$03 Fetch #R$A218.
  $C0DA,$02 Fetch the refresh register.
  $C0DC,$01 Add the low byte of the frame counter.
  $C0DD,$01 Add the low byte of the random number.
  $C0DE,$01 Set the low byte of the new number.
  $C0DF,$02 Fetch the refresh register again.
  $C0E1,$01 Add the high byte of the frame counter.
  $C0E2,$01 Add the high byte of the random number.
  $C0E3,$01 Set the high byte of the new number.
N $C0E4 Store the first random number.
  $C0E4,$03 Set #R$A218.
N $C0E7 Stir the second random number with the frame counter and the
. return address.
  $C0E7,$02 Fetch the return address into #REGbc, leaving it on the stack.
  $C0E9,$03 Fetch #R$A21A.
  $C0EC,$01 Fetch the low byte of the return address.
  $C0ED,$01 Subtract the low byte of the frame counter.
  $C0EE,$01 Add the low byte of the random number.
  $C0EF,$01 Set the low byte of the new number.
  $C0F0,$01 Fetch the high byte of the return address.
  $C0F1,$01 Subtract the high byte of the frame counter.
  $C0F2,$01 Add the high byte of the random number.
  $C0F3,$01 Set the high byte of the new number.
N $C0F4 Store the second random number.
  $C0F4,$03 Set #R$A21A.
  $C0F7,$01 Return.

c $C0F8 Draw Town
@ $C0F8 label=DrawTown
D $C0F8 Called every frame. In the town, it draws the walls and the objects of
. the cells which are around the sheriff, in an order which is chosen so that
. the cells nearer the viewer are drawn after the ones behind them. The order
. depends on which of five of the cells next to the sheriff's cell have
. buildings in them, and is taken from five-byte entries in a table at #R$60B1.
. Each of the five bytes holds the offset of a cell from the sheriff's cell
. (bits 4 and 5 for the offset in the column, bits 6 and 7 for the offset in the
. row) and a kind of drawing to do in it (bits 0 and 1): #N$00 draws the objects
. in the cell, #N$01 draws the walls and #N$02 draws the edges. The sheriff's
. cell and three of its neighbours are drawn last. The town is a map of sixteen
. cells by sixteen, and when the view is rotated the cell numbers are turned
. round.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$A3BA)
. #SIM(start=$A3BA,stop=$A3ED)
. #SIM(start=$A3ED,stop=$A3F0)
. #SIM(start=$A3F0,stop=$A3F3)
. #SIM(start=$A3F3,stop=$A3F6)
. #SCR$03,$0A,$01,$15,$0E(town) } UDGTABLE# #POPS
E $C0F8 Continue on to #R$C19F.
E $C0F8 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$CF08 }
. LIST#
N $C0F8 Return if this is not the town.
  $C0F8,$03 Fetch #R$A267.
  $C0FB,$02 Return if it is not.
N $C0FD The walls are not drawn on columns of the screen which already have a
. wall in them. The sixteen flags at #R$A248 cover columns of sixteen pixels.
. The left sixteen pixels and the right forty eight sit outside the play
. area, so they are marked as done.
  $C0FD,$06 Set #R$A248.
N $C103 Fetch the sheriff's cell.
  $C103,$04 Fetch the horizontal cell of the sheriff from #R$A27D(#N$A27F)
. and keep it in #REGl.
  $C107,$04 Fetch the vertical cell of the sheriff from #R$A27D(#N$A281)
. and keep it in #REGh.
N $C10B Turn the cell round if the view is rotated.
  $C10B,$03 Call #R$C372.
  $C10E,$01 Stash the cell of the sheriff on the stack.
  $C10F,$02 Clear the flags for the neighbouring cells.
N $C111 Find out which of five neighbouring cells have something in them. Taking
. the column and row of the sheriff's cell as x and y, they are the cells (x-1,
. y+1), (x-1, y), (x, y+1), (x-1, y-1) and (x+1, y+1).
  $C111,$01 Take one off the column...
  $C112,$01 ...and add one to the row.
N $C113 Find the contents of the cell.
  $C113,$03 Call #R$C738.
  $C116,$02 Jump to #R$C11A if it is empty.
  $C118,$02 Set the bit for the first cell.
@ $C11A label=DrawTown_TestSecondCell
N $C11A Test the cell at (x-1, y).
  $C11A,$01 Restore the cell of the sheriff from the stack.
  $C11B,$01 Stash the cell of the sheriff on the stack.
  $C11C,$01 Take one off the column.
N $C11D Find the contents of the cell.
  $C11D,$03 Call #R$C738.
  $C120,$02 Jump to #R$C124 if it is empty.
  $C122,$02 Set the bit for the second cell.
@ $C124 label=DrawTown_TestThirdCell
N $C124 Test the cell at (x, y+1).
  $C124,$01 Restore the cell of the sheriff from the stack.
  $C125,$01 Stash the cell of the sheriff on the stack.
  $C126,$01 Add one to the row.
N $C127 Find the contents of the cell.
  $C127,$03 Call #R$C738.
  $C12A,$02 Jump to #R$C12E if it is empty.
  $C12C,$02 Set the bit for the third cell.
@ $C12E label=DrawTown_TestFourthCell
N $C12E Test the cell at (x-1, y-1).
  $C12E,$01 Restore the cell of the sheriff from the stack.
  $C12F,$01 Stash the cell of the sheriff on the stack.
  $C130,$01 Take one off the column...
  $C131,$01 ...and take one off the row.
N $C132 Find the contents of the cell.
  $C132,$03 Call #R$C738.
  $C135,$02 Jump to #R$C139 if it is empty.
  $C137,$02 Set the bit for the fourth cell.
@ $C139 label=DrawTown_TestFifthCell
N $C139 Test the cell at (x+1, y+1).
  $C139,$01 Restore the cell of the sheriff from the stack.
  $C13A,$01 Stash the cell of the sheriff on the stack.
  $C13B,$01 Add one to the column...
  $C13C,$01 ...and add one to the row.
N $C13D Find the contents of the cell.
  $C13D,$03 Call #R$C738.
  $C140,$02 Jump to #R$C144 if it is empty.
  $C142,$02 Set the bit for the fifth cell.
@ $C144 label=DrawTown_FindEntry
N $C144 Point at the entry in the table of five bytes for the cells which have
. been found.
  $C144,$02 Clear #REGd.
  $C146,$01 Fetch the flags for the cells.
  $C147,$01 Move the flags into #REGhl.
  $C148,$02 Copy them into #REGde.
  $C14A,$02 Multiply them by four.
  $C14C,$01 Add them again, to make five times.
  $C14D,$03 Point #REGde at #R$60B1.
  $C150,$01 Point #REGhl at the entry.
  $C151,$01 Keep the address of the entry in #REGde.
  $C152,$02 Set the number of bytes to five.
@ $C154 label=DrawTown_NextCell
N $C154 Draw the next cell from the entry.
  $C154,$01 Restore the cell of the sheriff from the stack.
  $C155,$01 Stash the cell of the sheriff on the stack.
  $C156,$01 Fetch the byte from the entry.
  $C157,$01 Move on to the next byte.
  $C158,$04 Jump to #R$C163 if the cell is in the same column as the sheriff.
  $C15C,$04 Jump to #R$C162 if this is not the next column.
  $C160,$02 Add two to the column.
@ $C162 label=DrawTown_ColumnOffset
  $C162,$01 Take one off the column, to make it one lower or one higher.
@ $C163 label=DrawTown_TestRow
  $C163,$04 Jump to #R$C16E if the cell is in the same row as the sheriff.
  $C167,$04 Jump to #R$C16D if this is not the next row.
  $C16B,$02 Add two to the row.
@ $C16D label=DrawTown_RowOffset
  $C16D,$01 Take one off the row, to make it one lower or one higher.
@ $C16E label=DrawTown_KeepKind
N $C16E Choose what to draw in the cell.
  $C16E,$02,b$01 Keep the kind of drawing.
  $C170,$02 Stash the number of bytes left and the address in the entry on
. the stack.
N $C172 Make the draw routine return to #R$C182.
  $C172,$03 Point #REGde at #R$C182.
  $C175,$01 Stash it on the stack.
N $C176 Draw the objects in the cell if the kind is zero.
  $C176,$03 Jump to #R$C19F if it is.
  $C179,$01 Take one off the kind.
N $C17A Draw the walls of the cell if the kind is one.
  $C17A,$03 Jump to #R$C54B if it is.
  $C17D,$01 Take one off the kind.
N $C17E Draw the edges of the cell if the kind is two.
  $C17E,$03 Jump to #R$C392 if it is.
N $C181 The kind is three, which is nothing.
  $C181,$01 Throw away the return address from the stack.
@ $C182 label=DrawTown_AfterDraw
  $C182,$02 Restore the address in the entry and the number of bytes left
. from the stack.
N $C184 Go back for the next byte of the entry.
  $C184,$02 Jump to #R$C154 if there are any left.
N $C186 Draw the sheriff's cell and the three cells after it: the cells with the
. row one lower, the column one higher, and both of those.
  $C186,$01 Restore the cell of the sheriff from the stack.
  $C187,$01 Stash the cell of the sheriff on the stack.
N $C188 Draw the edges and the objects in the cell.
  $C188,$03 Call #R$C19A.
  $C18B,$01 Restore the cell of the sheriff from the stack.
  $C18C,$01 Stash the cell of the sheriff on the stack.
  $C18D,$01 Take one off the row.
N $C18E Draw the edges and the objects in the cell.
  $C18E,$03 Call #R$C19A.
  $C191,$01 Restore the cell of the sheriff from the stack.
  $C192,$01 Stash the cell of the sheriff on the stack.
  $C193,$01 Add one to the column.
N $C194 Draw the edges and the objects in the cell.
  $C194,$03 Call #R$C19A.
  $C197,$01 Restore the cell of the sheriff from the stack.
  $C198,$01 Add one to the column...
  $C199,$01 ...and take one off the row.
N $C19A The last cell goes on into the routine, which returns to the caller.
@ $C19A label=DrawCellAndObjects
  $C19A,$01 Stash the cell on the stack.
N $C19B Draw the edges of the cell.
  $C19B,$03 Call #R$C392.
  $C19E,$01 Restore the cell from the stack.

c $C19F Draw Cell Objects
@ $C19F label=DrawCellObjects
D $C19F Draws all of the objects which are in a cell of the town, with the ones
. which are furthest from the viewer first.
R $C19F HL The cell: the column in #REGl and the row in #REGh
  $C19F,$03 Make a list of the objects in the cell.
  $C1A2,$02 Jump to #R$C1E7.

c $C1A4 Find Objects In Cell
@ $C1A4 label=FindObjectsInCell
D $C1A4 Makes a list at #R$C352 of the addresses of all of the objects which are
. in a cell. The list ends with a zero word.
E $C1A4 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$CFAF }
. LIST#
R $C1A4 HL The cell: the column in #REGl and the row in #REGh
N $C1A4 Point at the list and the first object slot.
  $C1A4,$04 Point #REGiy at #R$C352.
  $C1A8,$04 Point #REGix at #R$A27D.
N $C1AC Turn the cell round if the view is rotated.
  $C1AC,$03 Call #R$C372.
  $C1AF,$01 Keep the column in #REGe and the row in #REGd.
@ $C1B0 label=FindObjectsInCell_Next
N $C1B0 Look at this slot.
  $C1B0,$06 Jump to #R$C1CF if the slot is not in use.
  $C1B6,$06 Jump to #R$C1CF if the object is not in the same column.
  $C1BC,$06 Jump to #R$C1CF if the object is not in the same row.
  $C1C2,$03 Copy the address of the object into #REGhl (using the stack).
  $C1C5,$06 Add the address of the object to the list.
  $C1CB,$04 Move on to the next place in the list.
@ $C1CF label=FindObjectsInCell_Skip
  $C1CF,$05 Move on to the next object slot.
  $C1D4,$03 Copy the address of the slot into #REGhl (using the stack).
N $C1D7 See whether every slot has been looked at.
  $C1D7,$06 Test whether this is past the last slot.
N $C1DD Go back for the next slot.
  $C1DD,$02 Jump to #R$C1B0 if it is not.
N $C1DF End the list.
  $C1DF,$07 Write a zero word to the end of the list.
  $C1E6,$01 Return.

c $C1E7 Draw Objects In List
@ $C1E7 label=DrawObjectsInList
D $C1E7 Draws the objects in the list at #R$C352, which are the objects in one
. cell. The objects are drawn so that the ones further from the viewer come
. first. Each time it takes the first object in the list which has not been
. drawn, compares it with each of the rest, and swaps it for any object which
. should be drawn before it. It then draws the object it is left with, and marks
. it as drawn by clearing bit 7 of the high byte of its address in the list.
E $C1E7 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$CFF2 }
. LIST#
N $C1E7 Find the first object in the list which has not been drawn.
  $C1E7,$03 Point #REGhl at #R$C352.
@ $C1EA label=DrawObjectsInList_First
  $C1EA,$04 Fetch the address of the next object into #REGde.
  $C1EE,$03 Return if this is the end of the list.
  $C1F1,$04 Jump to #R$C1EA if it has been drawn.
N $C1F5 Remember where the next place in the list is.
  $C1F5,$03 Set #R$A24A.
  $C1F8,$03 Copy the address of the object into #REGix (using the stack).
N $C1FB Compare this object with each of the others which have not been drawn.
@ $C1FB label=DrawObjectsInList_Next
  $C1FB,$04 Fetch the address of the next object into #REGde.
N $C1FF Draw the first object if this is the end of the list.
  $C1FF,$05 Jump to #R$C289 if it is.
  $C204,$04 Jump to #R$C1FB if it has been drawn.
N $C208 Remember where the next place in the list is.
  $C208,$03 Set #R$A24C.
  $C20B,$03 Copy the address of the object into #REGiy (using the stack).
  $C20E,$02 Clear the number which says how the objects compare.
N $C210 Compare the objects from side to side. The number in #REGc stays at zero
. if the first object starts after the second ends, becomes two if the second
. starts after the first ends, and becomes one if they overlap.
  $C210,$06 Fetch the horizontal position of the second object and add its
. horizontal size.
  $C216,$04 Halve it, add #N$40 and keep the result in #REGb.
  $C21A,$06 Fetch the horizontal position of the first object and subtract its
. horizontal size.
  $C220,$03 Halve it and add #N$40.
  $C223,$03 Jump to #R$C23E if the first object starts after the second
. ends.
  $C226,$06 Fetch the horizontal position of the first object and add its
. horizontal size.
  $C22C,$04 Halve it, add #N$40 and keep the result in #REGb.
  $C230,$06 Fetch the horizontal position of the second object and subtract its
. horizontal size.
  $C236,$03 Halve it and add #N$40.
  $C239,$03 Jump to #R$C23D if the second object starts before the first
. ends.
  $C23C,$01 Add one.
@ $C23D label=DrawObjectsInList_AddOne
  $C23D,$01 Add one more.
N $C23E Compare the objects from front to back in the same way. This time the
. number in #REGc has zero, three or six added to it.
@ $C23E label=DrawObjectsInList_Depth
  $C23E,$06 Fetch the vertical position of the second object and add its
. vertical size.
  $C244,$04 Halve it, add #N$40 and keep the result in #REGb.
  $C248,$06 Fetch the vertical position of the first object and subtract its
. vertical size.
  $C24E,$03 Halve it and add #N$40.
  $C251,$01 Subtract the end of the second object.
  $C252,$01 Fetch the number.
  $C253,$02 Jump to #R$C270 if the first object starts after the second
. ends.
  $C255,$06 Fetch the vertical position of the first object and add its vertical
. size.
  $C25B,$04 Halve it, add #N$40 and keep the result in #REGb.
  $C25F,$06 Fetch the vertical position of the second object and subtract its
. vertical size.
  $C265,$03 Halve it and add #N$40.
  $C268,$01 Subtract the end of the first object.
  $C269,$01 Fetch the number.
  $C26A,$02 Jump to #R$C26E if the second object starts before the first
. ends.
  $C26C,$02 Add three.
@ $C26E label=DrawObjectsInList_AddThree
  $C26E,$02 Add three more.
@ $C270 label=DrawObjectsInList_Rotated
  $C270,$01 Keep the number in #REGc.
N $C271 Fetch the rotation of the view.
  $C271,$03 Fetch #R$A268.
  $C274,$02,b$01 Test the lowest bit.
  $C276,$02 Jump to #R$C27C if the view is not rotated.
  $C278,$04 Add #N$09 to the number, to use the second half of the table.
@ $C27C label=DrawObjectsInList_Choose
  $C27C,$01 Fetch the number.
  $C27D,$03 Point #REGbc at #R$C295.
N $C280 Run the routine for the number.
  $C280,$03 Call #R$C766.
N $C283 Fetch the place in the list after the second object.
  $C283,$03 Fetch #R$A24C.
N $C286 Go back to compare the next object.
  $C286,$03 Jump to #R$C1FB.
N $C289 There are no more objects to compare with, so the first object is the
. one to draw. Mark it as drawn, using the place kept at #R$A24A.
@ $C289 label=DrawObjectsInList_Draw
  $C289,$06 Clear bit 7 of the high byte of its address in the list.
N $C28F Draw the object.
  $C28F,$03 Call #R$BD62.
N $C292 Go back to find the next object to draw.
  $C292,$03 Jump to #R$C1E7.

w $C295 Object Order Routines
@ $C295 label=ObjectOrderRoutines
D $C295 The routines which are run by #R$C1E7 after it compares two objects, in
. two groups of nine. The number is made from the way the objects compare from
. side to side (zero to two) plus three times the way they compare from front to
. back (zero to two), and the second group is for a rotated view. A routine is
. #R$C2B9 to keep the first object, #R$C2BA to swap it for the second object, or
. #R$C2C5 to look at the objects more closely.
W $C295,$24,$02

c $C2B9 Keep Object
@ $C2B9 label=KeepObject
D $C2B9 Keeps the first object as the one to be drawn first, so there is nothing
. to do.
  $C2B9,$01 Return.

c $C2BA Choose Other Object
@ $C2BA label=ChooseOtherObject
D $C2BA Swaps the first object for the second one, which has to be drawn before
. it.
E $C2BA View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D0C5 }
. LIST#
R $C2BA IY The address of the second object
  $C2BA,$06 Make the place in the list after the second object the place after
. the first object.
  $C2C0,$04 Copy the address of the second object into #REGix (using the stack).
  $C2C4,$01 Return.

c $C2C5 Compare Object Depths
@ $C2C5 label=CompareObjectDepths
D $C2C5 Works out which of two objects which overlap should be drawn first. For
. each object it finds a number from the difference between a vertical and a
. horizontal edge, and it swaps the objects if the numbers are the wrong way
. round. The edges which it uses are different when the view is rotated.
E $C2C5 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D0D0 }
. LIST#
R $C2C5 IX The address of the first object
R $C2C5 IY The address of the second object
  $C2C5,$03 Fetch the rotation of the view.
  $C2C8,$02,b$01 Test the lowest bit.
  $C2CA,$02 Jump if the view is rotated.
N $C2CC Find the number for the second object, in #REGde.
  $C2CC,$09 Fetch the horizontal position, add the horizontal size, halve it and
. add #N$40.
  $C2D5,$03 Keep it in #REGbc.
  $C2D8,$09 Fetch the vertical position, subtract the vertical size, halve it
. and add #N$40.
  $C2E1,$03 Make the top edge a sixteen bit number in #REGhl.
  $C2E4,$03 Subtract the horizontal edge.
  $C2E7,$04 Add #N$0100.
  $C2EB,$04 Divide the result by two...
  $C2EF,$01 ...and keep it in #REGde.
N $C2F0 Find the number for the first object, in #REGhl, in the same way.
  $C2F0,$09 Fetch the horizontal position, add the horizontal size, halve it and
. add #N$40.
  $C2F9,$03 Keep it in #REGbc.
  $C2FC,$06 Fetch the vertical position and subtract the vertical size.
@ $C302 label=CompareObjectDepths_Finish
  $C302,$03 Halve it and add #N$40.
  $C305,$03 Make the top edge a sixteen bit number in #REGhl.
  $C308,$03 Subtract the horizontal edge.
  $C30B,$04 Add #N$0100.
  $C30F,$04 Divide the result by two.
  $C313,$03 Subtract the number for the other object.
  $C316,$01 Return if the first number is not the lower.
  $C317,$03 Otherwise swap the objects.
N $C31A Find the numbers when the view is rotated. The number for the first
. object goes in #REGde...
@ $C31A label=CompareObjectDepths_Rotated
  $C31A,$09 Fetch the horizontal position, subtract the horizontal size, halve
. it and add #N$40.
  $C323,$03 Keep it in #REGbc.
  $C326,$09 Fetch the vertical position, add the vertical size, halve it and add
. #N$40.
  $C32F,$03 Make the lower edge a sixteen bit number in #REGhl.
  $C332,$03 Subtract the horizontal edge.
  $C335,$04 Add #N$0100.
  $C339,$04 Divide the result by two...
  $C33D,$01 ...and keep it in #REGde.
N $C33E ...and the number for the second object is found in #REGhl by the end of
. the routine above.
  $C33E,$09 Fetch the horizontal position, subtract the horizontal size, halve
. it and add #N$40.
  $C347,$03 Keep it in #REGbc.
  $C34A,$06 Fetch the vertical position and add the vertical size.
N $C350 Go to find the number.
  $C350,$02 Jump to #R$C302.

g $C352 Cell Object List
@ $C352 label=CellObjectList
D $C352 The list of the objects in a cell, which is made by #R$C1A4. It has room
. for the addresses of fifteen objects and the zero word which ends the list.
W $C352,$20,$02

c $C372 Convert Cell
@ $C372 label=ConvertCell
D $C372 Converts the column and the row of a cell between the map and the
. view. They are the same unless the view is rotated by a half turn, when
. each is replaced by fifteen minus itself, so that cell (x, y) on the map
. of sixteen by sixteen is (fifteen minus x, fifteen minus y) in the view.
. It does nothing when the view is not rotated.
E $C372 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D17D }
. LIST#
R $C372 L The column
R $C372 H The row
R $C372 O:L The column to use
R $C372 O:H The row to use
N $C372 Return if the view is not rotated.
  $C372,$03 Fetch #R$A268.
  $C375,$02,b$01 Keep the bit which says that the view is rotated.
  $C377,$01 Return if it is not.
N $C378 Replace the column with fifteen minus the column.
  $C378,$02 Invert the column.
  $C37A,$02,b$01 Keep the low four bits, which is fifteen minus the
. column.
  $C37C,$01 Set the column.
N $C37D Replace the row with fifteen minus the row.
  $C37D,$02 Invert the row.
  $C37F,$02,b$01 Keep the low four bits, which is fifteen minus the row.
  $C381,$01 Set the row.
  $C382,$01 Return.

c $C383 Convert Position
@ $C383 label=ConvertPosition
D $C383 Converts a position along one axis between the map and the view. It
. is the same unless the view is rotated by a half turn, when the position
. within the cell is inverted and the cell is replaced by fifteen minus
. itself. It does nothing when the view is not rotated.
E $C383 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D18E }
. LIST#
R $C383 L The position within the cell
R $C383 H The cell
R $C383 O:L The position within the cell to use
R $C383 O:H The cell to use
N $C383 Return if the view is not rotated.
  $C383,$03 Fetch #R$A268.
  $C386,$02,b$01 Keep the bit which says that the view is rotated.
  $C388,$01 Return if it is not.
N $C389 Invert the position within the cell.
  $C389,$02 Invert the low byte.
  $C38B,$01 Set the low byte.
N $C38C Replace the cell with fifteen minus the cell.
  $C38C,$02 Invert the cell.
  $C38E,$02,b$01 Keep the low four bits, which is fifteen minus the cell.
  $C390,$01 Set the cell.
  $C391,$01 Return.

c $C392 Draw Cell
@ $C392 label=DrawCell
D $C392 Draws the outline of a cell of the town, using the lists of tiles in the
. table at #R$626C. There are two lists for each kind of cell: one for the edges
. at the bottom, drawn from the left corner, and one for the edges at the top,
. drawn from the right corner. Each list is drawn as two runs of eight tiles
. which are 16 pixels wide, using the first byte of each pair of bytes in the
. list, in the shape of a V for the bottom and an upside-down V for the top.
. When the view is rotated the two lists change places.
E $C392 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D19D }
. LIST#
R $C392 L The column
R $C392 H The row
N $C392 Find the code of the cell.
  $C392,$03 Call #R$C738.
  $C395,$01 Return if there is nothing in the cell.
N $C396 Double the code to make the number of its first list.
  $C396,$01 Double the code.
  $C397,$01 Stash it on the stack.
N $C398 Find the position of the cell on the screen.
  $C398,$03 Call #R$C6DC.
  $C39B,$02 Restore the list number from the stack, leaving it there.
N $C39D Draw the second list at the bottom when the view is rotated.
  $C39D,$07 Jump to #R$C3E7 if the view is rotated.
N $C3A4 Draw the edges at the bottom.
  $C3A4,$03 Call #R$C3EF.
  $C3A7,$01 Restore the list number from the stack.
  $C3A8,$02,b$01 Use the second list.
N $C3AA Draw the edges at the top, starting from the right corner of the
. cell.
@ $C3AA label=DrawCell_Top
  $C3AA,$0A Move #R$A24E sixteen pixels to the left.
  $C3B4,$03 Point #REGbc at #R$626C.
N $C3B7 Find the address of the list.
  $C3B7,$03 Call #R$C75C.
  $C3BA,$03 Copy the list address to #REGiy (using the stack).
N $C3BD Draw tiles as they are.
  $C3BD,$04 Write #N$00 to *#R$A252.
  $C3C1,$03 Set a count of eight tiles, and swap each for its pair.
N $C3C4 Draw eight tiles going up and to the left.
@ $C3C4 label=DrawCell_TopLeft
  $C3C4,$03 Call #R$C468.
  $C3C7,$03 Call #R$C44A.
  $C3CA,$02 Jump to #R$C3C4 if there are any left.
N $C3CC Move down by eight pixels to start the second run.
  $C3CC,$0A Move #R$A250 down by eight pixels.
N $C3D6 Draw the rest of the tiles flipped.
  $C3D6,$05 Write #N$01 to *#R$A252.
  $C3DB,$03 Set a count of eight tiles, and swap each for its pair.
N $C3DE Draw eight tiles going down and to the left.
@ $C3DE label=DrawCell_TopRight
  $C3DE,$03 Call #R$C468.
  $C3E1,$03 Call #R$C463.
  $C3E4,$02 Jump to #R$C3DE if there are any left.
  $C3E6,$01 Return.
N $C3E7 The view is rotated, so draw the second list at the bottom and the
. first at the top.
@ $C3E7 label=DrawCell_Rotated
  $C3E7,$02,b$01 Use the second list.
N $C3E9 Draw the edges at the bottom.
  $C3E9,$03 Call #R$C3EF.
  $C3EC,$01 Restore the list number from the stack.
N $C3ED Draw the edges at the top.
  $C3ED,$02 Jump to #R$C3AA.

c $C3EF Draw Strips Left To Right
@ $C3EF label=DrawStripsLeftToRight
D $C3EF Draws a list of sixteen tiles for the bottom edges of a cell, going down
. and to the right for the first eight and up and to the right for the second
. eight. The second eight are drawn flipped.
E $C3EF View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D1FA }
. LIST#
R $C3EF A The number of the list in the table at #R$626C
N $C3EF Find the address of the list.
  $C3EF,$03 Point #REGbc at #R$626C.
  $C3F2,$03 Call #R$C75C.
  $C3F5,$03 Copy the list address to #REGiy (using the stack).
N $C3F8 Draw tiles as they are.
  $C3F8,$04 Write #N$00 to *#R$A252.
  $C3FC,$03 Set a count of eight tiles, without swapping any.
N $C3FF Draw eight tiles going down and to the right.
@ $C3FF label=DrawStripsLeftToRight_Down
  $C3FF,$03 Call #R$C468.
  $C402,$03 Call #R$C440.
  $C405,$02 Jump to #R$C3FF if there are any left.
N $C407 Move up by eight pixels to start the second run.
  $C407,$0A Move #R$A250 up by eight pixels.
N $C411 Draw the rest of the tiles flipped.
  $C411,$05 Write #N$01 to *#R$A252.
  $C416,$03 Set a count of eight tiles, without swapping any.
N $C419 Draw eight tiles going up and to the right.
@ $C419 label=DrawStripsLeftToRight_Up
  $C419,$03 Call #R$C468.
  $C41C,$03 Call #R$C427.
  $C41F,$02 Jump to #R$C419 if there are any left.
  $C421,$01 Return.

c $C422 Step Up Right Keep List
@ $C422 label=StepUpRightKeepList
D $C422 Moves the draw position up by eight pixels and right by sixteen
. pixels. It does not move on in the list of tiles.
E $C422 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D22D }
. LIST#
N $C422 Move up and to the right.
  $C422,$03 Set the vertical step to eight pixels up.
N $C425 Move to the right, without moving on in the list.
  $C425,$02 Jump to #R$C42E.

c $C427 Step Up Right
@ $C427 label=StepUpRight
D $C427 Moves the draw position up by eight pixels and right by sixteen
. pixels, and moves on to the next two bytes of the list of tiles.
R $C427 IY The address of the tile in its list
N $C427 Move up and to the right, and on to the next tile.
  $C427,$03 Set the vertical step to eight pixels up.
N $C42A Move on to the next two bytes of the list.
@ $C42A label=AdvanceListStepRight
  $C42A,$04 Move on to the next two bytes of the list.
N $C42E Move the position.
@ $C42E label=StepRight
  $C42E,$07 Add the vertical step to #R$A250.
  $C435,$0A Move #R$A24E sixteen pixels to the right.
  $C43F,$01 Return.
N $C440 Move down and to the right, and on to the next tile.
@ $C440 label=StepDownRight
  $C440,$03 Set the vertical step to eight pixels down.
  $C443,$02 Jump to #R$C42A.
N $C445 Move down and to the right.
@ $C445 label=StepDownRightKeepList
  $C445,$03 Set the vertical step to eight pixels down.
  $C448,$02 Jump to #R$C42E.
N $C44A Move up and to the left, and on to the next tile.
@ $C44A label=StepUpLeft
  $C44A,$03 Set the vertical step to eight pixels up.
N $C44D Move on to the next two bytes of the list.
@ $C44D label=AdvanceListStepLeft
  $C44D,$04 Move on to the next two bytes of the list.
  $C451,$07 Add the vertical step to #R$A250.
  $C458,$0A Move #R$A24E sixteen pixels to the left.
  $C462,$01 Return.
N $C463 Move down and to the left, and on to the next tile.
@ $C463 label=StepDownLeft
  $C463,$03 Set the vertical step to eight pixels down.
  $C466,$02 Jump to #R$C44D.

c $C468 Draw Strip
@ $C468 label=DrawStrip
D $C468 Draws one tile of the edge of a cell of the town, if its position is
. inside the area where the town is drawn, which is from #N$11 to #N$CF
. horizontally and below #N$0100 vertically. The tile number comes from the
. list at #REGiy, and is changed to the number of an image by a table at
. #R$5E2C and then by the swap flag.
E $C468 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D273 }
. LIST#
R $C468 IY The address of the tile in its list
R $C468 C One to swap the image for the other of its pair
N $C468 Return if the tile is outside the play area horizontally.
  $C468,$04 Fetch #R$A24E into #REGde.
  $C46C,$07 Return if it is further to the right than #N$00CF.
  $C473,$06 Return if it is not further to the right than #N$0010.
N $C479 Return if the tile is off the screen vertically.
  $C479,$03 Fetch #R$A250.
  $C47C,$03 Return if the high byte is not zero.
  $C47F,$01 Keep the low byte of the vertical position in #REGd.
N $C480 Fetch the tile and find its image.
  $C480,$01 Fetch the swap flag.
  $C481,$01 Stash the count of tiles on the stack.
  $C482,$05 Fetch the tile number into #REGbc.
  $C487,$04 Find the entry for the tile in #R$5E2C.
  $C48B,$01 Combine it with the swap flag, to make the number of the image.
  $C48C,$03 Point #REGbc at #R$8A2E.
N $C48F Find the address of the image.
  $C48F,$03 Call #R$C75C.
N $C492 Draw the image.
  $C492,$03 Call #R$C4A7.
  $C495,$01 Restore the count of tiles from the stack.
  $C496,$01 Return.

c $C497 Clip Edge Strip Top
@ $C497 label=ClipEdgeStripTop
D $C497 Skips the rows of an image that are
. below #R$D6EB. #REGa is the number of those
. rows, negated. It starts drawing at #N$48 and
. jumps to #R$C4B6.
E $C497 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D2A2 }
. LIST#
R $C497 A The number of rows below the buffer, negated
R $C497 HL The address of the image
N $C497 Skip the rows that are below the buffer.
  $C497,$03 Make the number of rows positive and keep it in #REGc.
  $C49A,$02 Fetch the height of the image.
  $C49C,$01 Subtract the rows that are below.
  $C49D,$02 Return if there are none left.
  $C49F,$04 Skip the image data for those rows.
  $C4A3,$02 Set the vertical position to #N$48.
  $C4A5,$02 Jump to #R$C4B6.

c $C4A7 Draw Strip Graphic
@ $C4A7 label=DrawStripGraphic
D $C4A7 Draws an image which is sixteen pixels
. wide into #R$D6EB, combining it with what is
. already there. The image starts with a byte
. for the number of rows, followed by two bytes
. for each row. It is drawn from the bottom row
. up, and is cut off at the bottom and top of
. the buffer. The position is in #R$A24E and
. the image is moved to the right by #N($00),
. #N($02), #N$04 or #N$06 pixels, using #R$FA00
. and #R$F200. The image is flipped if #R$A252
. is not zero.
E $C4A7 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D2B2 }
. LIST#
R $C4A7 D The vertical position of the bottom of the image
R $C4A7 E The horizontal position of the image
R $C4A7 HL The address of the image
N $C4A7 Clip the image to the buffer.
  $C4A7,$03 Subtract #N$48 from the vertical position.
  $C4AA,$02 Jump to #R$C497 if it is below the bottom.
  $C4AC,$02 Subtract #N$70.
  $C4AE,$01 Return if it is above the top.
  $C4AF,$02 Make it the number of rows in the buffer.
  $C4B1,$03 Jump to #R$C4B5 if it is fewer.
  $C4B4,$01 Use the height of the image.
N $C4B5 Draw the rows that are in the buffer.
@ $C4B5 label=DrawStripGraphic_FirstRow
  $C4B5,$01 Move on to the first row of the image.
@ $C4B6 label=DrawStripGraphic_Draw
  $C4B6,$01 Keep the number of rows in #REGa'.
  $C4B7,$01 Put the position in #REGhl.
  $C4B8,$03 Call #R$D233.
  $C4BB,$01 Switch the buffer and the image.
  $C4BC,$04 Set #R$A21D.
  $C4C0,$01 Point the stack at the image.
N $C4C1 Choose the draw path.
  $C4C1,$03 Fetch #R$A24E.
  $C4C4,$02,b$01 Keep bits 1 and 2.
  $C4C6,$02 Jump to #R$C518 if the image is aligned.
  $C4C8,$02,b$01 Set the high bits of the page.
  $C4CA,$01 Set #REGh.
  $C4CB,$03 Fetch #R$A252.
  $C4CE,$03 Jump to #R$C4F7 if it is set.
  $C4D1,$02 Set bit 3 of #REGh.
  $C4D3,$01 Switch in the number of rows.
N $C4D4 Draw a shifted row.
@ $C4D4 label=DrawStripGraphic_Shifted
  $C4D4,$01 Keep the number of rows in #REGa'.
  $C4D5,$02 Fetch a row and point at the first byte.
  $C4D7,$03 Combine the bits which stay with the first byte of the buffer.
  $C4DA,$02 Move on to the next byte and page.
  $C4DC,$02 Combine the bits which moved on from the first byte.
  $C4DE,$02 Point at the second byte of the image.
  $C4E0,$02 Combine its bits which stay and store the byte.
  $C4E2,$02 Move on to the next byte and page.
  $C4E4,$03 Combine the bits which moved on with the next byte of the buffer.
  $C4E7,$01 Go back to the first page.
  $C4E8,$06 Move on to the next row of the buffer.
  $C4EE,$01 Switch in the number of rows.
  $C4EF,$01 Count it down.
  $C4F0,$02 Jump to #R$C4D4 until the rows are done.
N $C4F2 Put the stack back.
@ $C4F2 label=DrawStrip_Finish
  $C4F2,$05 Fetch #R$A21D and return.
N $C4F7 Draw a shifted row that is flipped.
@ $C4F7 label=DrawStripGraphic_MirroredShifted
  $C4F7,$01 Switch in the number of rows.
@ $C4F8 label=DrawStripGraphic_MirroredLoop
  $C4F8,$01 Keep the number of rows in #REGa'.
  $C4F9,$02 Fetch a row and point at the second byte.
  $C4FB,$03 Combine the bits which stay with the first byte of the buffer.
  $C4FE,$02 Move on to the next byte and page.
  $C500,$02 Combine the bits which moved on.
  $C502,$02 Point at the first byte of the image.
  $C504,$02 Combine its bits which stay and store the byte.
  $C506,$02 Move on to the next byte and page.
  $C508,$03 Combine the bits which moved on with the next byte of the buffer.
  $C50B,$01 Go back to the first page.
  $C50C,$06 Move on to the next row of the buffer.
  $C512,$01 Switch in the number of rows.
  $C513,$01 Count it down.
  $C514,$02 Jump to #R$C4F8 until the rows are done.
  $C516,$02 Jump to #R$C4F2.
N $C518 Draw an aligned image.
@ $C518 label=DrawStripGraphic_Aligned
  $C518,$01 Put the buffer address in #REGhl.
  $C519,$04 Fetch #R$A252 and test it.
  $C51D,$02 Jump to #R$C533 if it is set.
  $C51F,$03 Set #REGbc to #N$0017.
  $C522,$01 Switch in the number of rows.
@ $C523 label=DrawStripGraphic_AlignedLoop
  $C523,$01 Keep the number of rows in #REGa'.
  $C524,$01 Fetch a row of the image.
  $C525,$03 Combine the first byte with the buffer.
  $C528,$01 Move on to the next byte of the buffer.
  $C529,$03 Combine the second byte with the buffer.
  $C52C,$01 Move on to the next row of the buffer.
  $C52D,$01 Switch in the number of rows.
  $C52E,$01 Count it down.
  $C52F,$02 Jump to #R$C523 until the rows are done.
  $C531,$02 Jump to #R$C4F2.
N $C533 Draw an aligned image that is flipped.
@ $C533 label=DrawStripGraphic_AlignedMirrored
  $C533,$02 Point #REGb at #R$F900.
  $C535,$01 Switch in the number of rows.
@ $C536 label=DrawStripGraphic_AlignedMirroredLoop
  $C536,$01 Keep the number of rows in #REGa'.
  $C537,$01 Fetch a row of the image.
  $C538,$01 Point at the second byte, turned round.
  $C539,$03 Combine it with the first byte of the buffer.
  $C53C,$01 Move on to the next byte of the buffer.
  $C53D,$01 Point at the first byte, turned round.
  $C53E,$03 Combine it with the second byte of the buffer.
  $C541,$04 Move on to the next row of the buffer.
  $C545,$01 Switch in the number of rows.
  $C546,$01 Count it down.
  $C547,$02 Jump to #R$C536 until the rows are done.
  $C549,$02 Jump to #R$C4F2.

c $C54B Draw Cell With Walls
@ $C54B label=DrawCellWithWalls
D $C54B Draws the walls of a building in a cell of
. the town, using the lists of tiles in #R$626C.
. The list is chosen from the code of the cell
. and #R$A268. Nothing is drawn if the cell is
. empty. A list holds sixteen steps of two tiles
. each, one above the other. They are drawn in
. two runs of eight, going down and to the right
. and then up and to the right, with the second
. run flipped by #R$A252, to make the two walls
. which can be seen. Each step is drawn by
. #R$C59B, and nothing more is drawn when all of
. the bits in #R$A248 are set.
E $C54B View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D372 }
. LIST#
R $C54B HL The cell: the column in #REGl and the row in #REGh
N $C54B Find the list of tiles.
  $C54B,$03 Call #R$C738.
  $C54E,$01 Return if the cell is empty.
  $C54F,$03 Set #R$A253.
  $C552,$01 Double the code.
  $C553,$04 Add #R$A268.
  $C557,$03 Point #REGbc at #R$626C.
  $C55A,$03 Call #R$C75C.
  $C55D,$03 Copy the list address to #REGiy (using the stack).
N $C560 Find the position and draw tiles as they are.
  $C560,$03 Call #R$C6DC.
  $C563,$04 Write #N$00 to *#R$A252.
  $C567,$02 Set a count of #N$08.
N $C569 Draw eight steps going down and to the right.
@ $C569 label=DrawCellWithWalls_Down
  $C569,$03 Call #R$C59B.
  $C56C,$03 Fetch #R$A248.
  $C56F,$05 Return if all sixteen bits are set.
  $C574,$03 Call #R$C445.
  $C577,$02 Jump to #R$C569 if there are any left.
N $C579 Move up by eight pixels to start the second run.
  $C579,$0A Move #R$A250 up by eight pixels.
N $C583 Draw the rest of the tiles flipped.
  $C583,$05 Write #N$01 to *#R$A252.
  $C588,$02 Set a count of #N$08.
N $C58A Draw eight steps going up and to the right.
@ $C58A label=DrawCellWithWalls_Up
  $C58A,$03 Call #R$C59B.
  $C58D,$03 Fetch #R$A248.
  $C590,$05 Return if all sixteen bits are set.
  $C595,$03 Call #R$C422.
  $C598,$02 Jump to #R$C58A if there are any left.
  $C59A,$01 Return.

c $C59B Draw Wall Strips
@ $C59B label=DrawWallStrips
D $C59B Draws two wall tiles, one above the other,
. for a step along the edge of a cell. A bit in
. #R$A248 is set to record that the column has a
. wall in it, and if it already has one the step
. is skipped. The horizontal position in #R$A24E
. chooses the bit, and is written into the BIT
. instruction at #R$C5BB and the SET instruction
. at #R$C59B(#N$C5BF). The lower tile is drawn at
. #R$A250 by #R$C5F9, and the upper tile #N$40
. above it. The step is skipped if either
. position is off the screen. It always moves on
. to the next two tiles of the list.
E $C59B View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D3C2 }
. LIST#
R $C59B BC The count of steps in #REGb
R $C59B IY The address of the first tile of the step in its list
N $C59B Return unless the column is on the screen.
  $C59B,$03 Fetch #R$A24E.
  $C59E,$04 Jump to #R$C5E4 if it is off the screen.
N $C5A2 Keep the position and change the BIT and SET
. instructions.
  $C5A2,$02 Keep the horizontal position in #REGe.
  $C5A4,$01 Move the bits which say which sixteen pixels it is in...
  $C5A5,$02,b$01 ...to make the number of a bit...
  $C5A7,$02,b$01 ...in the second byte of a BIT instruction.
  $C5A9,$03 Store it as the second byte of the BIT instruction at #R$C5BB.
  $C5AC,$02,b$01 Change it to the second byte of a SET instruction.
  $C5AE,$03 Store it as the second byte of the SET instruction
. at #R$C59B(#N$C5C0).
N $C5B1 Choose the byte of #R$A248.
  $C5B1,$01 Fetch the horizontal position again.
  $C5B2,$01 Move the top bit of the horizontal position...
  $C5B3,$02,b$01 ...into a single bit.
  $C5B5,$03 Point #REGhl at #R$A248.
  $C5B8,$02 Jump to #R$C5BB if the position is in the first half of the screen.
  $C5BA,$01 Point #REGhl at the second byte of the flags.
N $C5BB Test and set the flag for this column.
@ $C5BB label=DrawWallStrips_Test
  $C5BB,$04 Jump to #R$C5E4 if there is already a wall there.
  $C5BF,$02 Set the bit.
N $C5C1 Draw the lower tile.
  $C5C1,$03 Fetch #R$A250.
  $C5C4,$04 Jump to #R$C5E4 if it is off the screen.
  $C5C8,$01 Keep the low byte of the vertical position in #REGd.
  $C5C9,$02 Stash the count of steps and the position on the stack.
  $C5CB,$03 Call #R$C5F9.
  $C5CE,$01 Restore the position.
  $C5CF,$02 Move on to the next tile of the list.
N $C5D1 Draw the upper tile.
  $C5D1,$03 Fetch #R$A250.
  $C5D4,$03 Set #REGbc to #N$0040.
  $C5D7,$01 Move up by that much.
  $C5D8,$04 Jump to #R$C5E0 if it is off the screen.
  $C5DC,$01 Keep the low byte of the vertical position in #REGd.
  $C5DD,$03 Call #R$C5F9.
N $C5E0 Restore the count and move on.
@ $C5E0 label=DrawWallStrips_RestoreCount
  $C5E0,$01 Restore the count of steps.
  $C5E1,$02 Move on to the next tile of the list.
  $C5E3,$01 Return.
N $C5E4 There is nothing to draw, so skip both of the tiles.
@ $C5E4 label=DrawWallStrips_Skip
  $C5E4,$04 Move on past the two tiles of the list.
  $C5E8,$01 Return.

c $C5E9 Clip Wall Strip Top
@ $C5E9 label=ClipWallStripTop
D $C5E9 Skips the rows of a wall tile that are
. below #R$D6EB. #REGa is the number of those
. rows, negated. It starts drawing at #N$48 and
. jumps to #R$C611.
E $C5E9 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D415 }
. LIST#
R $C5E9 A The number of rows below the buffer, negated
R $C5E9 HL The address of the image
N $C5E9 Skip the rows that are below the buffer.
  $C5E9,$03 Make the number of rows positive and keep it in #REGc.
  $C5EC,$02 Fetch the height of the image.
  $C5EE,$01 Subtract the rows that are below.
  $C5EF,$02 Return if there are none left.
  $C5F1,$04 Skip the image data for those rows.
  $C5F5,$02 Set the vertical position to #N$48.
  $C5F7,$02 Jump to #R$C611.

c $C5F9 Draw Wall Strip
@ $C5F9 label=DrawWallStrip
D $C5F9 Draws a wall tile, sixteen pixels wide,
. into #R$D6EB. The image has the same format as
. #R$C4A7, but it replaces the buffer. The masks
. from #R$C6C3 are written into the AND
. instructions. The image is flipped if #R$A252
. is not zero.
E $C5F9 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D425 }
. LIST#
R $C5F9 D The vertical position of the bottom of the tile
R $C5F9 E The horizontal position of the tile
R $C5F9 IY The address of the tile number
N $C5F9 Find the image and clip it to the buffer.
  $C5F9,$03 Fetch the tile number.
  $C5FC,$03 Point #REGbc at #R$8FF8.
  $C5FF,$03 Call #R$C75C.
  $C602,$03 Subtract #N$48 from the vertical position.
  $C605,$02 Jump to #R$C5E9 if it is below the bottom.
  $C607,$02 Subtract #N$70.
  $C609,$01 Return if it is above the top.
  $C60A,$02 Make it the number of rows in the buffer.
  $C60C,$01 Compare it with the height of the image.
  $C60D,$02 Jump to #R$C610 if it is fewer.
  $C60F,$01 Use the height of the image.
N $C610 Draw the rows that are in the buffer.
@ $C610 label=DrawWallStrip_FirstRow
  $C610,$01 Move on to the first row of the image.
@ $C611 label=DrawWallStrip_Rows
  $C611,$01 Keep the number of rows in #REGa'.
  $C612,$01 Put the position in #REGhl.
  $C613,$03 Call #R$D233.
  $C616,$01 Switch the buffer and the image.
  $C617,$01 Stash the image on the stack.
N $C618 Write the masks from #R$C6C3 into the AND
. instructions.
  $C618,$03 Fetch #R$A24E.
  $C61B,$01 Move the shift into the lowest bits.
  $C61C,$02,b$01 Keep the lowest two bits.
  $C61E,$03 Point #REGhl at #R$C6C3.
  $C621,$03 Call #R$D275.
  $C624,$01 Fetch the mask.
  $C625,$06 Set the left-hand AND operands.
  $C62B,$01 Complement the mask.
  $C62C,$06 Set the right-hand AND operands.
N $C632 Choose the draw path.
  $C632,$01 Restore the image from the stack.
  $C633,$04 Set #R$A21D.
  $C637,$01 Point the stack at the image.
  $C638,$03 Fetch #R$A24E.
  $C63B,$02,b$01 Keep bits 1 and 2.
  $C63D,$02 Jump to #R$C696 if the image is aligned.
  $C63F,$02,b$01 Set the high bits of the page.
  $C641,$01 Set #REGh.
  $C642,$03 Fetch #R$A252.
  $C645,$03 Jump to #R$C671 if it is set.
  $C648,$02 Set bit 3 of #REGh.
  $C64A,$01 Switch in the number of rows.
N $C64B Draw a shifted row.
@ $C64B label=DrawWallStrip_ShiftedRow
  $C64B,$01 Keep the number of rows in #REGa'.
  $C64C,$02 Fetch a row and point at the first byte.
  $C64E,$01 Fetch the first byte of the buffer.
  $C64F,$02,b$01 Keep the bits which are not covered.
  $C651,$02 Combine it and store the byte.
  $C653,$02 Move on to the next byte and page.
  $C655,$01 Look up the bits which moved on.
  $C656,$01 Go back to the first page.
  $C657,$01 Point at the second byte of the image.
  $C658,$02 Combine it and store the byte.
  $C65A,$02 Move on to the next byte and page.
  $C65C,$01 Fetch the third byte of the buffer.
  $C65D,$02,b$01 Keep the bits which are not covered.
  $C65F,$02 Combine it and store the byte.
  $C661,$01 Go back to the first page.
  $C662,$06 Move on to the next row of the buffer.
  $C668,$01 Switch in the number of rows.
  $C669,$01 Count it down.
  $C66A,$02 Jump to #R$C64B until the rows are done.
N $C66C Put the stack back.
@ $C66C label=DrawWallStrip_Finish
  $C66C,$05 Fetch #R$A21D and return.
N $C671 Draw a shifted row that is flipped.
@ $C671 label=DrawWallStrip_Flipped
  $C671,$01 Switch in the number of rows.
@ $C672 label=DrawWallStrip_FlippedRow
  $C672,$01 Keep the number of rows in #REGa'.
  $C673,$02 Fetch a row and point at the second byte.
  $C675,$01 Fetch the first byte of the buffer.
  $C676,$02,b$01 Keep the bits which are not covered.
  $C678,$02 Combine it and store the byte.
  $C67A,$02 Move on to the next byte and page.
  $C67C,$01 Look up the bits which moved on.
  $C67D,$01 Go back to the first page.
  $C67E,$01 Point at the first byte of the image.
  $C67F,$01 Fetch the bits which stay.
  $C680,$02 Combine them and store the byte.
  $C682,$02 Move on to the next byte and page.
  $C684,$01 Fetch the third byte of the buffer.
  $C685,$02,b$01 Keep the bits which are not covered.
  $C687,$02 Combine it and store the byte.
  $C689,$01 Go back to the first page.
  $C68A,$06 Move on to the next row of the buffer.
  $C690,$01 Switch in the number of rows.
  $C691,$01 Count it down.
  $C692,$02 Jump to #R$C672 until the rows are done.
  $C694,$02 Jump to #R$C66C.
N $C696 Draw an aligned image.
@ $C696 label=DrawWallStrip_Aligned
  $C696,$01 Put the buffer address in #REGhl.
  $C697,$04 Fetch #R$A252 and test it.
  $C69B,$02 Jump to #R$C6AD if it is set.
  $C69D,$03 Set #REGbc to #N$0017.
  $C6A0,$01 Switch in the number of rows.
@ $C6A1 label=DrawWallStrip_AlignedRow
  $C6A1,$01 Keep the number of rows in #REGa'.
  $C6A2,$01 Fetch a row of the image.
  $C6A3,$02 Store the first byte and move on.
  $C6A5,$01 Store the second byte.
  $C6A6,$01 Move on to the next row of the buffer.
  $C6A7,$01 Switch in the number of rows.
  $C6A8,$01 Count it down.
  $C6A9,$02 Jump to #R$C6A1 until the rows are done.
  $C6AB,$02 Jump to #R$C66C.
N $C6AD Draw an aligned image that is flipped.
@ $C6AD label=DrawWallStrip_FlippedAligned
  $C6AD,$02 Set #REGb to #N$F9.
  $C6AF,$01 Switch in the number of rows.
@ $C6B0 label=DrawWallStrip_FlippedAlignedRow
  $C6B0,$01 Keep the number of rows in #REGa'.
  $C6B1,$01 Fetch a row of the image.
  $C6B2,$01 Point at the second byte, turned round.
  $C6B3,$02 Store it in the first byte of the buffer.
  $C6B5,$01 Move on to the next byte of the buffer.
  $C6B6,$01 Point at the first byte, turned round.
  $C6B7,$02 Store it in the second byte of the buffer.
  $C6B9,$04 Move on to the next row of the buffer.
  $C6BD,$01 Switch in the number of rows.
  $C6BE,$01 Count it down.
  $C6BF,$02 Jump to #R$C6B0 until the rows are done.
  $C6C1,$02 Jump to #R$C66C.

b $C6C3 Wall Tile Masks
@ $C6C3 label=WallTileMasks
D $C6C3 The four masks used by #R$C5F9 to keep
. the bits of the buffer on the left of a wall
. tile. The index is the shift to the right in
. twos of pixels: #N($00), #N($02), #N$04 or
. #N$06.
E $C6C3 View the equivalent data in;
. #LIST
. { #NIGHTSHADE$D4EF }
. LIST#
B $C6C3,$01 Shift #N$00: #N$00.
B $C6C4,$01 Shift #N$02: #N$C0.
B $C6C5,$01 Shift #N$04: #N$F0.
B $C6C6,$01 Shift #N$06: #N$FC.

c $C6C7 Project Object
@ $C6C7 label=ProjectObject
D $C6C7 Works out where an object is on the
. screen, in the same way as #R$C6DC. It fetches
. the position from the slot, calls #R$C383, and
. jumps to #R$C6E9. The result is put in #R$A24E
. and #R$A250.
E $C6C7 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D4F3 }
. LIST#
R $C6C7 IX The address of the object
N $C6C7 Fetch the position and convert it.
  $C6C7,$06 Fetch the vertical position.
  $C6CD,$03 Call #R$C383.
  $C6D0,$01 Stash it on the stack.
  $C6D1,$06 Fetch the horizontal position.
  $C6D7,$03 Call #R$C383.
  $C6DA,$02 Jump to #R$C6E9.

c $C6DC Project Cell
@ $C6DC label=ProjectCell
D $C6DC Works out where the corner of the cell
. last set by #R$C738 is on the screen. With the
. distances from the sheriff as dx and dy, the
. horizontal position is (dx + dy + #N$00F0) /
. 2 and the vertical position is (dy - dx +
. #N$01B0) / 4. They are put in #R$A24E and
. #R$A250. When bit 0 of #R$A268 is set, the
. sheriff's position is turned round.
E $C6DC View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D508 }
. LIST#
N $C6DC Set the position of the corner of the
. cell.
  $C6DC,$06 Fetch #R$A255 as a position in #REGhl.
  $C6E2,$01 Stash it on the stack.
  $C6E3,$06 Fetch #R$A254 as a position in #REGhl.
N $C6E9 Find the position on the screen. #REGhl
. is the horizontal position, and the vertical
. position is on the stack.
@ $C6E9 label=ProjectCell_Position
  $C6E9,$04 Fetch the sheriff's horizontal
. position from #R$A27D(#N$A27E).
  $C6ED,$03 Fetch #R$A268.
  $C6F0,$02,b$01 Keep the lowest bit.
  $C6F2,$02 Jump to #R$C6FC if the view is not rotated.
  $C6F4,$03 Complement #REGe.
  $C6F7,$02 Complement #REGd.
  $C6F9,$02,b$01 Keep the lowest four bits.
  $C6FB,$01 Set #REGd.
N $C6FC Find the horizontal distance.
@ $C6FC label=ProjectCell_X
  $C6FC,$03 Subtract the sheriff's position.
  $C6FF,$01 Copy the distance into #REGde.
  $C700,$01 Restore the vertical position from the stack.
N $C701 Find the vertical distance.
  $C701,$04 Fetch the sheriff's vertical
. position from #R$A27D(#N$A280).
  $C705,$03 Fetch #R$A268.
  $C708,$02,b$01 Keep the lowest bit.
  $C70A,$02 Jump to #R$C714 if the view is not rotated.
  $C70C,$03 Complement #REGc.
  $C70F,$02 Complement #REGb.
  $C711,$02,b$01 Keep the lowest four bits.
  $C713,$01 Set #REGb.
N $C714 Work out the screen position.
@ $C714 label=ProjectCell_Y
  $C714,$03 Subtract the sheriff's position.
  $C717,$01 Stash the distance on the stack.
  $C718,$03 Set #REGbc to #N$00F0.
  $C71B,$02 Add the two distances and #N$00F0.
  $C71D,$04 Halve it.
  $C721,$03 Set #R$A24E.
  $C724,$01 Restore the vertical distance from the stack.
  $C725,$03 Subtract the horizontal distance.
  $C728,$03 Set #REGbc to #N$01B0.
  $C72B,$01 Add it.
  $C72C,$08 Divide it by four.
  $C734,$04 Set #R$A250 and return.

c $C738 Get Map Cell
@ $C738 label=GetMapCell
D $C738 Fetches the code of a cell from #R$5FB1,
. which is sixteen rows of sixteen. #REGl is the
. column and #REGh is the row. It sets #R$A254
. and #R$A255. When bit 0 of #R$A268 is set, the
. map is read from the end.
E $C738 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D564 }
. LIST#
R $C738 HL The cell: the column in #REGl and the row in #REGh
R $C738 O:A The code for the cell
R $C738 O:F The zero flag is set if the cell is empty
N $C738 Work out the number of the cell.
  $C738,$03 Set #R$A254 and #R$A255.
  $C73B,$04 Put the column in #REGa and the row in #REGhl.
  $C73F,$04 Multiply the row by #N$10.
  $C743,$02 Add the column.
N $C745 Point at the map.
  $C745,$03 Point #REGbc at #R$5FB1.
  $C748,$03 Fetch #R$A268.
  $C74B,$02,b$01 Keep the lowest bit.
  $C74D,$02 Jump to #R$C758 if the view is not rotated.
N $C74F Read from the end.
  $C74F,$06 Complement #REGhl.
  $C755,$03 Point #REGbc one past #R$5FB1.
N $C758 Fetch the code.
@ $C758 label=GetMapCell_Fetch
  $C758,$01 Add the address of the map.
  $C759,$03 Fetch the code and return.

c $C75C Get Table Entry
@ $C75C label=GetTableEntry
D $C75C Fetches the word at #REGbc plus twice
. #REGa into #REGhl.
E $C75C View the equivalent code in;
. #LIST
. { #MARTIANOIDS$C010 }
. { #NIGHTSHADE$D589 }
. { #PENTAGRAM$D692 }
. LIST#
R $C75C A The number of the entry
R $C75C BC The address of the table
R $C75C O:HL The word from the table
N $C75C Find the address of the entry.
  $C75C,$03 Put the number of the entry in #REGhl.
  $C75F,$01 Double it.
  $C760,$01 Add the address of the table.
N $C761 Fetch the word.
  $C761,$01 Fetch the low byte.
  $C762,$01 Move on to the high byte.
  $C763,$01 Fetch it into #REGh.
  $C764,$02 Put the low byte in #REGl and return.

c $C766 Run Table Routine
@ $C766 label=RunTableRoutine
D $C766 Calls #R$C75C to fetch a routine from a
. table, then jumps to #R$5CB0 so that the
. routine returns to the caller of this one.
E $C766 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$D593 }
. LIST#
R $C766 A The number of the entry
R $C766 BC The address of the table
N $C766 Fetch the address and jump to it.
  $C766,$03 Call #R$C75C.
  $C769,$03 Jump to #R$5CB0.

c $C76C Handle Dying
@ $C76C label=HandleDying
D $C76C Type #N$09: a figure which has been shot
. and is falling. It subtracts byte #N$0C from
. byte #N$0D and adds #N$02 to the speed, so the
. figure rises and then falls, and it calls
. #R$AF4F. #R$B782 starts the speed at #N$FA and
. the height at #N$18. When the height is zero it
. makes the type #N$08 and sets byte #N$0C to
. #N$20.
R $C76C IX The address of the object
N $C76C Turn into a body if the height is zero.
  $C76C,$03 Fetch byte #N$0D.
  $C76F,$03 Jump to #R$C77B if it is not zero.
  $C772,$04 Make the type #N$08.
  $C776,$05 Set byte #N$0C to #N$20 and return.
N $C77B Move the figure.
@ $C77B label=HandleDying_Move
  $C77B,$03 Subtract byte #N$0C from the height.
  $C77E,$03 Jump to #R$C790 if it is negative.
  $C781,$03 Set byte #N$0D.
  $C784,$03 Call #R$AF4F.
  $C787,$03 Fetch byte #N$0C.
  $C78A,$02 Add #N$02.
  $C78C,$04 Set byte #N$0C and return.
N $C790 Put the figure on the ground.
@ $C790 label=HandleDying_Land
  $C790,$05 Set byte #N$0D to #N$00 and return.

c $C795 Handle Smoke
@ $C795 label=HandleSmoke
D $C795 Type #N$07: a puff of smoke. It counts
. down byte #N$0C, then calls #R$C75C to fetch a
. sprite list from #R$C7AB. It jumps to #R$C7BB
. when the counter goes below zero.
R $C795 IX The address of the object
N $C795 Count down the frames.
  $C795,$03 Count down byte #N$0C.
  $C798,$03 Jump to #R$C7BB if it is negative.
N $C79B Point at #R$C7AB.
  $C79B,$03 Point #REGbc at #R$C7AB.
N $C79E Choose the sprite list. #REGbc holds the
. table.
@ $C79E label=ChooseSpriteList
  $C79E,$03 Fetch byte #N$0C.
  $C7A1,$03 Call #R$C75C.
  $C7A4,$07 Set the sprite list and return.

g $C7AB Smoke Sprite Lists
@ $C7AB label=SmokeSpriteLists
D $C7AB The two sprite lists for a puff of
. smoke. The words point to #R$C7AF and
. #R$C7B3.
W $C7AB,$04,$02 The addresses of #R$C7AF and #R$C7B3.
N $C7AF The first frame.
@ $C7AF label=SmokeSpriteLists_FirstFrame
B $C7AF,$04,$04 Sprite #N$07 at offset (#N($F8), #N$0F).
. #SPRITE$07(flash-1*).
N $C7B3 The second frame.
@ $C7B3 label=SmokeSpriteLists_SecondFrame
B $C7B3,$04,$04 Sprite #N$09 at offset (#N($F8), #N$0F).
. #SPRITE$09(flash-3*).

c $C7B7 Handle Body
@ $C7B7 label=HandleBody
D $C7B7 Type #N$08: a body lying on the ground.
. It counts down byte #N$0C, then makes the type
. #N$00. #R$C76C makes it last for #N$20 frames.
R $C7B7 IX The address of the object
N $C7B7 Count down the frames.
  $C7B7,$04 Count down byte #N$0C and return if it is not zero.
N $C7BB Make the type #N$00.
@ $C7BB label=HandleBody_Remove
  $C7BB,$05 Make the type #N$00 and return.

c $C7C0 Handle Single Frame Object
@ $C7C0 label=HandleSingleFrameObject
D $C7C0 Type #N$05: an object which is drawn
. once and then removed. #R$CA30 makes it. It
. calls #R$BD52 and then makes the type #N$00.
R $C7C0 IX The address of the object
N $C7C0 Draw the object and remove it.
  $C7C0,$03 Call #R$BD52.
  $C7C3,$05 Make the type #N$00 and return.

c $C7C8 Remove All Objects
@ $C7C8 label=RemoveAllObjects
D $C7C8 Jumps to #R$D6E1 to fill #N$00F0 bytes
. from #R$A27D with zero, which empties all
. fifteen object slots.
N $C7C8 Set the address and the count.
  $C7C8,$03 Point #REGhl at #R$A27D.
  $C7CB,$03 Set #REGbc to #N$00F0.
  $C7CE,$03 Jump to #R$D6E1.

c $C7D1 Return To Town
@ $C7D1 label=ReturnToTown
D $C7D1 Clears #R$D6EB and the object slots. It
. sets #R$A267 to #N($04), clears #R$A265 and sets
. #R$A266 to #COLOUR$47, then jumps to #R$A3B3.
N $C7D1 Clear the buffer and the objects.
  $C7D1,$03 Call #R$D0B7.
  $C7D4,$03 Call #R$C7C8.
N $C7D7 Put the game back in the town.
  $C7D7,$05 Set #R$A267 to #N$04.
  $C7DC,$04 Clear #R$A265.
  $C7E0,$05 Set #R$A266 to #COLOUR$47.
  $C7E5,$03 Jump to #R$A3B3.

c $C7E8 Make Bag
@ $C7E8 label=MakeBag
D $C7E8 Puts a type #N$04 bag in the first free slot
. among #R$A27D, #R$A28D and #R$A29D. It does this
. on every fourth frame, copies #R$C847, sets a
. random sideways speed from #R$C85B and #R$A261,
. a random downward speed, and a random horizontal
. start. Then it takes one from #R$A264.
N $C7E8 Return unless it is time to make a bag.
  $C7E8,$03 Fetch #R$A216.
  $C7EB,$02,b$01 Keep the lowest two bits.
  $C7ED,$01 Return unless this is every fourth frame.
N $C7EE Look for a free slot among the first three.
  $C7EE,$03 Point #REGhl at #R$A27D.
  $C7F1,$03 Set the size of an object slot in #REGde.
  $C7F4,$02 Set a count of #N$03.
@ $C7F6 label=MakeBag_FindSlot
  $C7F6,$04 Jump to #R$C7FE if the slot is free.
  $C7FA,$01 Move on to the next slot.
  $C7FB,$02 Jump to #R$C7F6 until all three have been tried.
  $C7FD,$01 Return.
N $C7FE Copy #R$C847 into the slot.
@ $C7FE label=MakeBag_FillSlot
  $C7FE,$03 Copy #REGhl to #REGiy (using the stack).
  $C801,$03 Point #REGde at the slot and set #REGbc to its size.
  $C804,$03 Point #REGhl at #R$C847.
  $C807,$02 Copy the template into the slot.
N $C809 Work out the sideways speed.
  $C809,$06 Set #REGbc to #R$A261.
  $C80F,$04 Point #REGhl at the #R$C85B entry for #R$A261.
  $C813,$01 Fetch the bound for this skill.
  $C814,$04 Fetch #R$A218 and keep it in #REGb.
  $C818,$02,b$01 Keep the lowest seven bits.
  $C81A,$02 Add #N$08.
  $C81C,$03 Call #R$C863.
  $C81F,$04 Jump to #R$C825 if bit 7 of the random number is not set.
  $C823,$02 Make the sideways speed negative.
@ $C825 label=MakeBag_SetSpeeds
  $C825,$03 Set the sideways speed.
N $C828 Work out the downward speed.
  $C828,$03 Fetch #R$A218(#N$A219).
  $C82B,$02,b$01 Keep the lowest four bits.
  $C82D,$02 Double the bound.
  $C82F,$01 Add it.
  $C830,$02 Make it negative.
  $C832,$03 Set the downward speed.
N $C835 Set the horizontal start and take one from
. #R$A264.
  $C835,$03 Fetch #R$A21A.
  $C838,$02,b$01 Keep the lowest seven bits.
  $C83A,$02 Add #N$40.
  $C83C,$03 Set the horizontal position.
  $C83F,$08 Take one from #R$A264 and return.

b $C847 Bag Template
@ $C847 label=BagTemplate
D $C847 The initial contents of a slot for a bag
. (type #N$04). The final two bytes point to
. #R$C857.
B $C847,$0E,$08 Type, position, speed, size and counters.
W $C855,$02 The address of #R$C857.
N $C857 The sprite list.
@ $C857 label=BagSpriteList
B $C857,$04,$04 Sprite #N$29 at offset (#N($F4), #N$F4).
. #SPRITE$29(money-bag*).

b $C85B Bag Speeds
@ $C85B label=BagSpeeds
D $C85B One number for each of the eight skill
. levels, from #N$0F to #N$2B in steps of #N$04.
. #R$C7E8 uses it as the upper bound of the
. sideways speed and, doubled, as the downward
. speed.
B $C85B,$01 Skill #N$00: #N$0F.
B $C85C,$01 Skill #N$01: #N$13.
B $C85D,$01 Skill #N$02: #N$17.
B $C85E,$01 Skill #N$03: #N$1B.
B $C85F,$01 Skill #N$04: #N$1F.
B $C860,$01 Skill #N$05: #N$23.
B $C861,$01 Skill #N$06: #N$27.
B $C862,$01 Skill #N$07: #N$2B.

c $C863 Reduce Number
@ $C863 label=ReduceNumber
D $C863 Subtracts #N$08 from #REGa until it is
. less than #REGc.
R $C863 A The number
R $C863 C The number which #REGa must be below
R $C863 O:A The result
N $C863 Subtract #N$08 until #REGa is less than
. #REGc.
  $C863,$02 Return if #REGa is less than #REGc.
  $C865,$04 Subtract #N$08 and jump to #R$C863.

c $C869 Handle Bag
@ $C869 label=HandleBag
D $C869 Type #N$04: a bag falling in the bag
. stage. A hit adds #N$0100 to #R$A257 and removes
. the bag. Otherwise the speeds in bytes #N$0A and
. #N$0B are added to the position, and the bag is
. removed if it leaves the screen.
R $C869 IX The address of the bag
N $C869 Jump to #R$C8AF if the shot has hit the bag.
  $C869,$03 Call #R$C8C8.
  $C86C,$02 Jump to #R$C8AF if the shot is touching.
N $C86E Move the bag sideways.
  $C86E,$06 Fetch the horizontal position.
  $C874,$03 Fetch the horizontal speed.
  $C877,$03 Call #R$C8F7.
  $C87A,$05 Jump to #R$C8C3 if it is less than #N$10.
  $C87F,$04 Jump to #R$C8C3 if it is #N$D8 or more.
  $C883,$06 Set the horizontal position.
  $C889,$03 Make the pixel the screen position.
  $C88C,$03 Set #R$A24E.
N $C88F Move the bag down.
  $C88F,$06 Fetch the vertical position.
  $C895,$03 Fetch the vertical speed.
  $C898,$03 Call #R$C8F7.
  $C89B,$05 Jump to #R$C8C3 if it is less than #N$30.
  $C8A0,$06 Set the vertical position.
  $C8A6,$03 Make the pixel the screen position.
  $C8A9,$03 Set #R$A250.
  $C8AC,$03 Jump to #R$BD65.
N $C8AF Add #N$0100 to the bounty.
@ $C8AF label=HandleBag_Hit
  $C8AF,$03 Set #REGbc to #N$0100.
  $C8B2,$03 Call #R$D354.
  $C8B5,$03 Call #R$D390.
N $C8B8 Play the sound and remove the bag.
@ $C8B8 label=HandleBag_PlaySound
  $C8B8,$05 Set #R$A23C to #N$04.
  $C8BD,$06 Set #R$A23D to #R$AECF.
@ $C8C3 label=RemoveBag
  $C8C3,$05 Make the type #N$00 and return.

c $C8C8 Check Shot Hit
@ $C8C8 label=CheckShotHit
D $C8C8 Tests whether the object is touching the
. shot in #R$A34D. The distances between the
. positions must both be less than the sum of the
. sizes.
R $C8C8 IX The address of the object
R $C8C8 O:F The carry flag is set if the shot is touching the object
N $C8C8 Return unless there is a shot in #R$A34D.
  $C8C8,$04 Point #REGiy at #R$A34D.
  $C8CC,$05 Return if #R$A34D is free.
N $C8D1 Test the horizontal distance.
  $C8D1,$07 Add the horizontal sizes into #REGc.
  $C8D8,$06 Subtract the horizontal positions.
  $C8DE,$02 Jump to #R$C8E2 if it is not negative.
  $C8E0,$02 Make it positive.
@ $C8E2 label=CheckShotHit_Horizontal
  $C8E2,$02 Return if the shot is too far away.
N $C8E4 Test the vertical distance.
  $C8E4,$07 Add the vertical sizes into #REGc.
  $C8EB,$06 Subtract the vertical positions.
  $C8F1,$02 Jump to #R$C8F5 if it is not negative.
  $C8F3,$02 Make it positive.
@ $C8F5 label=CheckShotHit_Vertical
  $C8F5,$02 Set carry if the shot is touching and return.

c $C8F7 Add Speed To Position
@ $C8F7 label=AddSpeedToPosition
D $C8F7 Adds a signed speed to a position. The
. speed is multiplied by #N$10, so the high byte of
. the position is the pixel and the low byte is a
. fraction of a pixel.
R $C8F7 E The speed
R $C8F7 HL The position
R $C8F7 O:HL The new position
N $C8F7 Sign-extend the speed into #REGde.
  $C8F7,$01 Clear #REGa.
  $C8F8,$04 Jump to #R$C8FD if the speed is not negative.
  $C8FC,$01 Set #REGa to #N$FF.
N $C8FD Multiply the speed by #N$10 and add it.
@ $C8FD label=AddSpeedToPosition_Multiply
  $C8FD,$01 Put the high byte in #REGd.
  $C8FE,$10 Multiply the speed by #N$10.
  $C90E,$02 Add it to the position and return.

c $C910 Handle Mounted Sheriff
@ $C910 label=HandleMountedSheriff
D $C910 Type #N$15: the sheriff on a horse. On every
. fourth frame it counts #R$A209 down. When that
. reaches zero, #R$A21F is set to #N$0A, the speed to
. #N$08, and the type to #N$01.
E $C910 Continue on to #R$C930.
R $C910 IX The address of the sheriff
N $C910 Jump to #R$C930 unless it is time to count
. down.
  $C910,$03 Fetch #R$A216.
  $C913,$02 Add #N$02.
  $C915,$02,b$01 Keep the lowest two bits.
  $C917,$02 Jump to #R$C930 if this is not every fourth frame.
N $C919 Count down #R$A209.
  $C919,$03 Point #REGhl at #R$A209.
  $C91C,$04 Jump to #R$C930 if #R$A209 is zero.
  $C920,$01 Count #R$A209 down.
  $C921,$02 Jump to #R$C930 if it is not zero.
N $C923 Get off the horse.
  $C923,$05 Set #R$A21F to #N$0A.
  $C928,$04 Set the speed to #N$08.
  $C92C,$04 Make the type #N$01.

c $C930 Handle Sheriff
@ $C930 label=HandleSheriff
D $C930 Type #N$01: the sheriff in the town. It
. counts down #R$A208, calls #R$C977, reads the
. controls, then turns, moves and fires. The sprites
. are written to #R$A228.
R $C930 IX The address of the sheriff
N $C930 Count down #R$A208.
  $C930,$03 Point #REGhl at #R$A208.
  $C933,$04 Jump to #R$C938 if #R$A208 is zero.
  $C937,$01 Count #R$A208 down.
N $C938 Reload the revolver and read the controls.
@ $C938 label=HandleSheriff_Reload
  $C938,$03 Call #R$C977.
  $C93B,$03 Call #R$D0E3.
  $C93E,$03 Fetch #R$A21C.
  $C941,$01 Move the bits for the controls into the lowest bits.
  $C942,$02,b$01 Keep the two bits.
  $C944,$02 Jump to #R$C94C if the controls are not the keyboard.
N $C946 Copy the keyboard fire bit into bit 3.
  $C946,$01 Fetch the controls.
  $C947,$01 Move bit 4 into bit 3.
  $C948,$02,b$01 Keep only that bit.
  $C94A,$02 Combine it with the controls.
N $C94C Turn, move, fire and draw. #REGc is the
. controls, and is zero when the sheriff has just
. arrived.
@ $C94C label=HandleSheriff_Act
  $C94C,$01 Copy the controls into #REGe.
  $C94D,$03 Call #R$CD0C.
  $C950,$03 Call #R$CB86.
  $C953,$01 Stash the controls on the stack.
  $C954,$03 Call #R$CC42.
  $C957,$01 Restore the controls from the stack.
  $C958,$03 Call #R$C9EC.
  $C95B,$03 Call #R$CB29.
  $C95E,$03 Point #REGhl at #R$A228.
  $C961,$03 Call #R$CB60.
  $C964,$03 Jump to #R$CAEA.

g $C967 Figure Sprite Numbers
@ $C967 label=FigureSpriteNumbers
D $C967 The lower and middle sprite numbers for each
. walking frame. The lowest two bits choose the step,
. and bit 2, set from #R$CCBE, chooses the second
. set.
. #UDGTABLE(default,centre,centre,centre)
. { =h,c3 Bit 2 clear }
. { =h Frame | =h Lower | =h Middle }
. { #N$00 | #R$85A2 #SPRITE$1E(legs-3*) | #R$82E2 #SPRITE$17(torso-1*) }
. { #N$01 | #R$84EA #SPRITE$1C(legs-1*) | #R$82E2 #SPRITE$17(torso-1*) }
. { #N$02 | #R$85FE #SPRITE$1F(legs-4*) | #R$834A #SPRITE$18(torso-2*) }
. { #N$03 | #R$84EA #SPRITE$1C(legs-1*) | #R$834A #SPRITE$18(torso-2*) }
. { =h,c3 Bit 2 set }
. { =h Frame | =h Lower | =h Middle }
. { #N$04 | #R$86C8 #SPRITE$21(legs-6*) | #R$83B2 #SPRITE$19(torso-3*) }
. { #N$05 | #R$865A #SPRITE$20(legs-5*) | #R$83B2 #SPRITE$19(torso-3*) }
. { #N$06 | #R$8736 #SPRITE$22(legs-7*) | #R$841A #SPRITE$1A(torso-4*) }
. { #N$07 | #R$865A #SPRITE$20(legs-5*) | #R$841A #SPRITE$1A(torso-4*) }
. UDGTABLE#
N $C967 Bit 2 clear.
B $C967,$02 Frame #N$00: lower #R$85A2, middle #R$82E2.
B $C969,$02 Frame #N$01: lower #R$84EA, middle #R$82E2.
B $C96B,$02 Frame #N$02: lower #R$85FE, middle #R$834A.
B $C96D,$02 Frame #N$03: lower #R$84EA, middle #R$834A.
N $C96F Bit 2 set.
B $C96F,$02 Frame #N$04: lower #R$86C8, middle #R$83B2.
B $C971,$02 Frame #N$05: lower #R$865A, middle #R$83B2.
B $C973,$02 Frame #N$06: lower #R$8736, middle #R$841A.
B $C975,$02 Frame #N$07: lower #R$865A, middle #R$841A.

c $C977 Reload Revolver
@ $C977 label=ReloadRevolver
D $C977 Loads one bullet on every even frame while
. #R$A245 is zero and #R$A269 is clear. Reloading
. starts when #R$A262 is empty and #R$A246 is then
. set until the cylinder holds six. Each bullet takes
. #R$A25E from #R$A257. If the bounty cannot pay,
. #R$A269 is set.
N $C977 Return unless it is time to load a bullet.
  $C977,$05 Return if #R$A269 is set.
  $C97C,$03 Fetch #R$A216.
  $C97F,$02,b$01 Keep the lowest bit.
  $C981,$01 Return if this is an odd frame.
  $C982,$05 Return if #R$A245 is set.
N $C987 Start reloading if the cylinder is empty.
  $C987,$03 Point #REGhl at #R$A246.
  $C98A,$02 Fetch #R$A246 and test it.
  $C98C,$03 Fetch #R$A262.
  $C98F,$02 Jump to #R$C995 if #R$A246 is set.
  $C991,$02 Return if #R$A262 is not zero.
  $C993,$02 Set #R$A246 to #N$01.
N $C995 Take the price and add a bullet.
@ $C995 label=ReloadRevolver_Bullet
  $C995,$04 Fetch #R$A25E.
  $C999,$03 Call #R$D36B.
  $C99C,$02 Jump to #R$C9C3 if there is not enough.
  $C99E,$07 Add one to #R$A262.
  $C9A5,$04 Jump to #R$C9AE if it is not six.
  $C9A9,$05 Clear #R$A246.
N $C9AE Colour the chamber and draw the bounty.
@ $C9AE label=ReloadRevolver_Show
  $C9AE,$01 Make it the chamber number.
  $C9AF,$03 Point #REGbc at #R$C9E0.
  $C9B2,$03 Call #R$C75C.
  $C9B5,$03 Call #R$D272.
  $C9B8,$05 Call #R$C9CF with #COLOUR$71.
  $C9BD,$03 Call #R$AF22.
  $C9C0,$03 Jump to #R$D390.
N $C9C3 Put the price back and stop reloading.
@ $C9C3 label=ReloadRevolver_TooPoor
  $C9C3,$03 Call #R$D354.
  $C9C6,$04 Clear #R$A246.
  $C9CA,$05 Set #R$A269 to #N$01 and return.

c $C9CF Fill Chamber
@ $C9CF label=FillChamber
D $C9CF Fills a two-by-two block of screen
. attributes from #REGhl.
R $C9CF A The attribute
R $C9CF HL The address of the first attribute
N $C9CF Set the size of the block.
  $C9CF,$03 Set the width and height to #N$02.
  $C9D2,$03 Set the distance to the next row to #N$001E.
N $C9D5 Fill each row.
@ $C9D5 label=FillChamber_Row
  $C9D5,$01 Stash the width and height on the stack.
@ $C9D6 label=FillChamber_Attribute
  $C9D6,$01 Set an attribute.
  $C9D7,$01 Move on.
  $C9D8,$02 Jump to #R$C9D6 until the row is done.
  $C9DA,$01 Move on to the next row.
  $C9DB,$01 Restore the width and height from the stack.
  $C9DC,$03 Jump to #R$C9D5 until all of the rows are done.
  $C9DF,$01 Return.

g $C9E0 Chamber Addresses
@ $C9E0 label=ChamberAddresses
D $C9E0 The addresses in the screen attributes of the six chambers of the
. revolver which is shown at the bottom left of the screen.
W $C9E0,$0C,$02

c $C9EC Fire Revolver
@ $C9EC label=FireRevolver
D $C9EC Fires the revolver if the fire control is
. pressed, #R$A262 is not zero, and neither #R$A246
. nor #R$A244 is set. It calls #R$CA5D, takes one from
. #R$A262, and colours the chamber unless there were
. six. #R$A245 and #R$A244 are then set.
R $C9EC E The controls
R $C9EC IX The address of the object which fires
N $C9EC Return unless a new shot can be made.
  $C9EC,$06 Jump to #R$CA28 if #R$A244 is set.
  $C9F2,$03 Return if the fire control is not pressed.
  $C9F5,$05 Return if #R$A246 is set.
  $C9FA,$05 Return if #R$A262 is zero.
N $C9FF Make the shot and take a bullet.
  $C9FF,$03 Call #R$CA5D.
  $CA02,$01 Return if no shot was made.
  $CA03,$07 Take one from #R$A262.
  $CA0A,$01 Make it the number there were.
  $CA0B,$04 Jump to #R$CA1D if there were six.
N $CA0F Colour the chamber for the number there
. were.
  $CA0F,$03 Point #REGbc at #R$C9E0.
  $CA12,$03 Call #R$C75C.
  $CA15,$03 Call #R$D272.
  $CA18,$05 Call #R$C9CF with #INK$41.
N $CA1D Start the firing pose and hold the fire
. control.
@ $CA1D label=FireRevolver_Fired
  $CA1D,$05 Set #R$A245 to #N$05.
  $CA22,$06 Set #R$A244 to #N$01 and return.
N $CA28 Clear #R$A244 when the fire control is
. released.
@ $CA28 label=FireRevolver_Held
  $CA28,$03 Return if the fire control is still
. pressed.
  $CA2B,$05 Clear #R$A244 and return.

c $CA30 Make Flash
@ $CA30 label=MakeFlash
D $CA30 Puts a type #N$05 flash in #R$A34D. It copies
. the type and position of the object which fires, is
. eight by eight, and is drawn for one frame from
. #R$CA59.
R $CA30 IX The address of the object which fires
R $CA30 O:F The carry flag is set
N $CA30 Copy the type and position into #R$A34D.
  $CA30,$03 Copy #REGix to #REGhl (using the stack).
  $CA33,$06 Point #REGde and #REGiy at #R$A34D (using the stack).
  $CA39,$03 Set a count of #N$0005.
  $CA3C,$02 Copy the type and position.
N $CA3E Turn the slot into a flash.
  $CA3E,$04 Make the type #N$05.
  $CA42,$03 Point #REGhl at #R$CA59.
  $CA45,$04 Set the horizontal size to #N$08.
  $CA49,$04 Set the vertical size to #N$08.
  $CA4D,$04 Clear the vertical offset.
  $CA51,$06 Set the sprite list.
  $CA57,$02 Set the carry flag and return.

g $CA59 Flash Sprite List
@ $CA59 label=FlashSpriteList
D $CA59 The sprite list of a flash.
B $CA59,$03,$03 Sprite #N$0A at offset (#N($F8), #N$F7).
. #SPRITE$0A(flash-4*).
B $CA5C,$01,$01 Terminator.

c $CA5D Make Shot
@ $CA5D label=MakeShot
D $CA5D Makes a shot. It plays #R$AF30. If #R$A267 is
. zero it jumps to #R$CA30. In the town it puts a type
. #N$02 bullet in #R$A28D, #R$A29D or #R$A2AD: a free
. slot, or a slot that is not a bullet, or a bullet that
. is not drawn. The bullet copies the firer's position
. and heading, and has speed #N$0C.
R $CA5D IX The address of the object which fires
R $CA5D O:F The carry flag is set if a shot was made
N $CA5D Play the rumble, or make a flash outside the
. town.
  $CA5D,$03 Call #R$AF30.
  $CA60,$03 Fetch #R$A267.
  $CA63,$03 Jump to #R$CA30 if it is zero.
N $CA66 Look for a free slot among the next three.
  $CA66,$03 Point #REGhl at #R$A28D.
  $CA69,$03 Set the size of a slot to #N$0010.
  $CA6C,$02 Set a count of #N$03.
  $CA6E,$02 Stash the count and the slot on the stack.
N $CA70 Use a slot if its type is zero.
@ $CA70 label=MakeShot_FindFree
  $CA70,$04 Jump to #R$CA97 if the slot is free.
  $CA74,$01 Move on to the next slot.
  $CA75,$02 Jump to #R$CA70.
N $CA77 Look for a slot that is not a bullet.
  $CA77,$02 Restore the slot and the count from the
. stack.
  $CA79,$02 Stash the count and the slot on the stack.
@ $CA7B label=MakeShot_FindOther
  $CA7B,$05 Jump to #R$CA97 if the type is not #N$02.
  $CA80,$01 Move on to the next slot.
  $CA81,$02 Jump to #R$CA7B.
N $CA83 Look for a bullet that is not drawn.
  $CA83,$02 Point #REGiy at the first slot.
  $CA85,$01 Restore the count from the stack.
@ $CA86 label=MakeShot_FindHidden
  $CA86,$06 Jump to #R$CA92 if bit 1 of the flags is not
. set.
  $CA8C,$02 Move on to the next slot.
  $CA8E,$02 Jump to #R$CA86.
  $CA90,$02 Clear the carry flag and return.
N $CA92 Use this slot.
@ $CA92 label=MakeShot_UseHidden
  $CA92,$03 Copy #REGiy to #REGhl (using the stack).
  $CA95,$02 Jump to #R$CA99.
@ $CA97 label=MakeShot_UseSlot
  $CA97,$02 Throw away the count and the slot.
N $CA99 Fill the slot as a bullet.
@ $CA99 label=MakeShot_Bullet
  $CA99,$02 Make the type #N$02.
  $CA9B,$01 Move on to the position.
  $CA9C,$03 Copy #REGix to #REGde (using the stack).
  $CA9F,$01 Move on to the position.
  $CAA0,$01 Exchange #REGde and #REGhl.
  $CAA1,$03 Set a count of #N$0004.
  $CAA4,$02 Copy the position.
  $CAA6,$05 Set the speed to #N$0C and move on past the
. speed of the firer.
  $CAAB,$02 Set a count of #N$02.
  $CAAD,$02 Copy the heading and flags.
  $CAAF,$03 Set the horizontal size to #N$0C.
  $CAB2,$01 Move on.
  $CAB3,$01 Set the vertical size to #N$0C.
  $CAB4,$05 Move on to the sprite list.
  $CAB9,$01 Exchange #REGde and #REGhl.
  $CABA,$03 Point #REGde at #R$CAC2.
  $CABD,$03 Set the sprite list.
  $CAC0,$02 Set the carry flag and return.

g $CAC2 Bullet Sprite List
@ $CAC2 label=BulletSpriteList
D $CAC2 The sprite list of a bullet.
B $CAC2,$03,$03 Sprite #N$28 at offset (#N($FC), #N$14).
. #SPRITE$28(bullet*).
B $CAC5,$01,$01 Terminator.

c $CAC6 Handle Bullet
@ $CAC6 label=HandleBullet
D $CAC6 Type #N$02: a bullet fired by the sheriff in the
. town. It moves twice, checking the walls each time. If
. it hits a wall it becomes type #N$07.
R $CAC6 IX The address of the object
N $CAC6 Move the bullet in two steps.
  $CAC6,$03 Fetch the speed.
  $CAC9,$03 Call #R$CCC2.
  $CACC,$03 Call #R$CD8C.
  $CACF,$03 Call #R$CCE5.
  $CAD2,$03 Call #R$CD90.
  $CAD5,$03 Call #R$CCE5.
N $CAD8 Turn into smoke if it has hit a wall.
  $CAD8,$04 Clear bit 1 of the flags.
  $CADC,$05 Return if it has not hit a wall.
  $CAE1,$04 Turn the object into type #N$07.
  $CAE5,$05 Set the counter to #N$02 and return.

c $CAEA Show Firing Pose
@ $CAEA label=ShowFiringPose
D $CAEA Changes the middle sprite of #R$A228 to a firing
. pose while #R$A245 is not zero. Type #N$15 is left as
. it is. Bit 2 of the walking frame chooses sprite #N$16
. or #N$1B.
R $CAEA IX The address of the sheriff
N $CAEA Return unless the sheriff on foot has just fired.
  $CAEA,$05 Return if #R$A245 is zero.
  $CAEF,$03 Fetch the type.
  $CAF2,$03 Return if the type is #N$15.
N $CAF5 Choose the firing torso from bit 2 of the walking
. frame.
  $CAF5,$04 Test bit 2 of the walking frame.
  $CAF9,$02 Use sprite #N$16.
  $CAFB,$02 Jump to #R$CAFF if bit 2 is not set.
  $CAFD,$02 Add #N$05.
N $CAFF Store it as the middle sprite of #R$A228.
@ $CAFF label=ShowFiringPose_Store
  $CAFF,$04 Set the middle sprite of #R$A228 and return.

c $CB03 Flash Chamber
@ $CB03 label=FlashChamber
D $CB03 Counts #R$A245 down and fills the chamber for
. #R$A262 from #R$CB24. The colours are used from the last
. to the first.
N $CB03 Count down #R$A245 and pick a colour from
. #R$CB24.
  $CB03,$05 Return if #R$A245 is zero.
  $CB08,$04 Count #R$A245 down.
  $CB0C,$03 Point #REGhl at #R$CB24.
  $CB0F,$03 Call #R$D275.
  $CB12,$01 Fetch the colour.
  $CB13,$01 Stash the colour on the stack.
N $CB14 Fill the chamber for #R$A262.
  $CB14,$03 Fetch #R$A262.
  $CB17,$03 Point #REGbc at #R$C9E0.
  $CB1A,$03 Call #R$C75C.
  $CB1D,$03 Call #R$D272.
  $CB20,$01 Restore the colour from the stack.
  $CB21,$03 Jump to #R$C9CF.

g $CB24 Chamber Colours
@ $CB24 label=ChamberColours
D $CB24 The colours of the chamber of the revolver, used by #R$CB03 from the
. last to the first as the time since the sheriff fired counts down.
B $CB24,$01 #COLOUR(#PEEK(#PC)).
L $CB24,$01,$05

c $CB29 Choose Figure Sprites
@ $CB29 label=ChooseFigureSprites
D $CB29 Chooses the sprite numbers for a figure of three
. sprites, from the walking frame and #R$C967. Bit 2 of
. the walking frame chooses the second set. Types other
. than #N$01 and #N$0A use a horse for the middle sprite.
R $CB29 IX The address of the figure
R $CB29 O:E The number of the sprite for the lower part
R $CB29 O:D The number of the sprite for the middle part
R $CB29 O:B The vertical offset for the sprite for the top part
R $CB29 O:C The vertical offset for the sprite for the middle part
R $CB29 O:A' The number of the sprite for the top part
N $CB29 Fetch the lower and middle sprites from #R$C967.
  $CB29,$05 Fetch the walking frame into #REGhl.
  $CB2E,$01 Double it.
  $CB2F,$03 Point #REGbc at #R$C967.
  $CB32,$01 Find the entry.
  $CB33,$03 Fetch the lower and middle sprites.
N $CB36 Choose the vertical offsets from bit 2 of the
. walking frame.
  $CB36,$03 Fetch the walking frame.
  $CB39,$02 Test bit 2.
  $CB3B,$03 Use #N$1A for the top and #N$0F for the middle.
  $CB3E,$02 Jump to #R$CB43 if bit 2 is set.
  $CB40,$03 Use #N$19 for the top and #N$0D for the middle.
N $CB43 Make the top sprite #N$0E or #N$0F.
@ $CB43 label=ChooseFigureSprites_Top
  $CB43,$02 Move bit 2 into bit 0.
  $CB45,$02,b$01 Keep only that bit.
  $CB47,$02 Add #N$0E.
  $CB49,$01 Keep it in #REGa'.
N $CB4A Types #N$01 and #N$0A keep these sprites.
  $CB4A,$03 Fetch the type.
  $CB4D,$03 Return if the type is #N$01.
  $CB50,$03 Return if the type is #N$0A.
N $CB53 Use a horse for the middle sprite.
  $CB53,$03 Use #N$19 for the top and #N$09 for the middle.
  $CB56,$01 Fetch the middle sprite.
  $CB57,$02 Subtract #N$17.
  $CB59,$01 Move bit 1 into bit 0.
  $CB5A,$02,b$01 Keep only that bit.
  $CB5C,$02 Add #N$34.
  $CB5E,$02 Set the middle sprite and return.

c $CB60 Build Figure Sprite List
@ $CB60 label=BuildFigureSpriteList
D $CB60 Makes a sprite list of three sprites one above
. the other, using the numbers from #R$CB29. Types #N$15
. and #N$16 are moved eight to the left.
R $CB60 B The vertical offset for the sprite for the top part
R $CB60 C The vertical offset for the sprite for the middle part
R $CB60 D The number of the sprite for the middle part
R $CB60 E The number of the sprite for the lower part
R $CB60 A' The number of the sprite for the top part
R $CB60 HL The address of the sprite list to make
R $CB60 IX The address of the figure
N $CB60 Write the lower sprite.
  $CB60,$03 Set the horizontal offset of the lower sprite to
. #N$F4, and move on.
  $CB63,$03 Set the vertical offset of the lower sprite to
. #N$04, and move on.
  $CB66,$02 Set the number of the lower sprite, and move on.
N $CB68 Use a further left offset for types #N$15 and
. #N$16.
  $CB68,$03 Fetch the type.
  $CB6B,$02 Subtract #N$15.
  $CB6D,$02 Compare it with #N$02.
  $CB6F,$02 Use a horizontal offset of #N$F4.
  $CB71,$02 Jump to #R$CB75 unless the type is #N$15 or
. #N$16.
  $CB73,$02 Move the offset eight to the left.
N $CB75 Write the middle sprite.
@ $CB75 label=BuildFigureSpriteList_Middle
  $CB75,$02 Set the horizontal offset of the middle sprite,
. and move on.
  $CB77,$02 Set the vertical offset of the middle sprite,
. and move on.
  $CB79,$02 Set the number of the middle sprite, and move
. on.
N $CB7B Write the top sprite and the terminator.
  $CB7B,$03 Set the horizontal offset of the top sprite to
. #N$F4, and move on.
  $CB7E,$02 Set the vertical offset of the top sprite, and
. move on.
  $CB80,$03 Set the number of the top sprite, and move on.
  $CB83,$03 Set the terminator and return.

c $CB86 Turn Sheriff
@ $CB86 label=TurnSheriff
D $CB86 Turns the sheriff to face the way the controls
. say. Bits 6 and 7 are the heading, and bits 0 to 2 count
. down a turn. Left and right turn him a quarter when the
. controls are the keyboard or bit 3 of #R$A21C is clear.
. Otherwise he turns a quarter at a time towards the
. direction that is pressed, and bit 2 is set when he
. faces it.
E $CB86 Continue on to #R$CC13.
E $CB86 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DB89 }
. LIST#
R $CB86 E The controls
R $CB86 IX The address of the sheriff
R $CB86 O:E The controls
N $CB86 Jump to #R$CC13 while a turn is still counting.
  $CB86,$03 Fetch the heading and the time left in a turn.
  $CB89,$02,b$01 Keep the time left in a turn.
  $CB8B,$02 Jump to #R$CB93 if the sheriff is not turning.
  $CB8D,$03 Count down the time.
  $CB90,$03 Jump to #R$CC13.
N $CB93 Use the keyboard unless a joystick is set to give
. a direction.
@ $CB93 label=TurnSheriff_Choose
  $CB93,$03 Point #REGhl at #R$A21C.
  $CB96,$01 Fetch #R$A21C.
  $CB97,$02,b$01 Keep the bits for the controls.
  $CB99,$02 Jump to #R$CBFD if the controls are the
. keyboard.
  $CB9B,$04 Jump to #R$CBFD if bit 3 of #R$A21C is not set.
  $CB9F,$03 Fetch #R$A268.
  $CBA2,$02,b$01 Keep the lowest bit.
  $CBA4,$03 Call #R$CD23 if the view is rotated.
N $CBA7 Turn towards the direction that is pressed.
  $CBA7,$04 Jump to #R$CBAF if left is pressed.
  $CBAB,$04 Jump to #R$CBBF if up is pressed.
N $CBAF The controls are not for up.
@ $CBAF label=TurnSheriff_Right
  $CBAF,$04 Jump to #R$CBE5 if right is pressed.
  $CBB3,$04 Jump to #R$CBEC if down is pressed.
  $CBB7,$04 Jump to #R$CBF3 if left is pressed.
  $CBBB,$02 Clear bit 2 of the controls.
  $CBBD,$02 Jump to #R$CBFD.
N $CBBF The controls are for up.
@ $CBBF label=TurnSheriff_Up
  $CBBF,$03 Fetch the heading.
N $CBC2 How far is the heading from the direction that is
. wanted?
@ $CBC2 label=TurnSheriff_Difference
  $CBC2,$02,b$01 Keep only the heading.
  $CBC4,$02 Clear bit 2 of the controls.
  $CBC6,$02 Jump to #R$CBFA if he already faces that way.
  $CBC8,$04 Jump to #R$CBD7 if he is a quarter turn away.
  $CBCC,$04 Jump to #R$CBDE if he is three quarter turns
. away.
  $CBD0,$03 Fetch #R$A218.
  $CBD3,$04 Jump to #R$CBDE if it is less than #N$80.
N $CBD7 Turn back a quarter.
@ $CBD7 label=TurnSheriff_Back
  $CBD7,$03 Fetch the heading.
  $CBDA,$02 Take a quarter turn off it.
  $CBDC,$02 Jump to #R$CC0E.
N $CBDE Turn on a quarter.
@ $CBDE label=TurnSheriff_Forward
  $CBDE,$03 Fetch the heading.
  $CBE1,$02 Add a quarter turn to it.
  $CBE3,$02 Jump to #R$CC0E.
N $CBE5 The controls are for right.
@ $CBE5 label=TurnSheriff_ToRight
  $CBE5,$03 Fetch the heading.
  $CBE8,$02 Take a quarter turn off it.
  $CBEA,$02 Jump to #R$CBC2.
N $CBEC The controls are for down.
@ $CBEC label=TurnSheriff_ToDown
  $CBEC,$03 Fetch the heading.
  $CBEF,$02 Take two quarter turns off it.
  $CBF1,$02 Jump to #R$CBC2.
N $CBF3 The controls are for left.
@ $CBF3 label=TurnSheriff_ToLeft
  $CBF3,$03 Fetch the heading.
  $CBF6,$02 Take three quarter turns off it.
  $CBF8,$02 Jump to #R$CBC2.
N $CBFA The sheriff faces the way he was asked to.
@ $CBFA label=TurnSheriff_Facing
  $CBFA,$03 Set bit 2 of the controls and return.
N $CBFD Left and right turn the sheriff a quarter.
@ $CBFD label=TurnSheriff_Keyboard
  $CBFD,$03 Fetch the heading.
  $CC00,$04 Jump to #R$CC08 if left is not pressed.
  $CC04,$02 Take a quarter turn off the heading.
  $CC06,$02,b$01 Start a turn.
N $CC08 Right turns him the other way.
@ $CC08 label=TurnSheriff_KeyboardRight
  $CC08,$04 Jump to #R$CC10 if right is not pressed.
  $CC0C,$02 Add a quarter turn to the heading.
N $CC0E Start a turn and store the heading.
@ $CC0E label=TurnSheriff_Start
  $CC0E,$02,b$01 Start a turn.
@ $CC10 label=TurnSheriff_Store
  $CC10,$03 Set the heading.

c $CC13 Set Facing Flags
@ $CC13 label=SetFacingFlags
D $CC13 Sets the flip bit and the walking-frame set from
. #R$CCBE. When #R$A268 is set, the heading is XORed with
. two so opposite headings swap.
E $CC13 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DC14 }
. LIST#
R $CC13 IX The address of the object
N $CC13 Keep the heading in the lowest two bits.
  $CC13,$03 Fetch the heading.
  $CC16,$02 Move the heading into the lowest two bits.
  $CC18,$02,b$01 Keep only the heading.
  $CC1A,$01 Keep it in #REGl.
N $CC1B XOR the heading with two if #R$A268 is set.
  $CC1B,$03 Fetch #R$A268.
  $CC1E,$01 Double it.
  $CC1F,$01 XOR it with the heading.
  $CC20,$01 Keep the index in #REGl.
  $CC21,$02 Clear #REGh.
  $CC23,$03 Point #REGbc at #R$CCBE.
  $CC26,$01 Find the entry.
N $CC27 Set bits 6 and 7 of the flags.
  $CC27,$01 Fetch the entry.
  $CC28,$02,b$01 Keep bits 6 and 7.
  $CC2A,$01 Keep them in #REGc.
  $CC2B,$03 Fetch the flags.
  $CC2E,$02,b$01 Clear bits 6 and 7.
  $CC30,$01 Set them from the table.
  $CC31,$03 Set the flags.
N $CC34 Set bit 2 of the walking frame.
  $CC34,$01 Fetch the entry again.
  $CC35,$02,b$01 Keep bit 2.
  $CC37,$01 Keep it in #REGc.
  $CC38,$03 Fetch the walking frame.
  $CC3B,$02,b$01 Clear bit 2.
  $CC3D,$01 Set it from the table.
  $CC3E,$04 Set the walking frame and return.

c $CC42 Move Player
@ $CC42 label=MovePlayer
D $CC42 Moves the sheriff one step. If bit 2 is set he
. speeds up. Otherwise he keeps his heading and slows
. down until he stops at a multiple of eight.
E $CC42 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DC60 }
. LIST#
R $CC42 E The controls
R $CC42 IX The address of the sheriff
N $CC42 Walk if bit 2 is set.
  $CC42,$04 Jump to #R$CC8A if the sheriff should walk.
N $CC46 Otherwise slow down in the direction of the
. heading.
  $CC46,$03 Fetch the heading.
  $CC49,$02 Move the heading into the lowest two bits.
  $CC4B,$02,b$01 Keep only the heading.
  $CC4D,$03 Point #REGbc at #R$CC53.
  $CC50,$03 Jump to #R$C766.

g $CC53 Slow Down Routines
@ $CC53 label=SlowDownRoutines
D $CC53 The routines that #R$CC42 runs for each heading.
W $CC53,$02 Heading zero: #R$CC5B.
W $CC55,$02 Heading one: #R$CC74.
W $CC57,$02 Heading two: #R$CC79.
W $CC59,$02 Heading three: #R$CC80.

c $CC5B Slow Player Down
@ $CC5B label=SlowPlayerDown
D $CC5B Works out the speed when the sheriff is not
. walking, from the distance to the next multiple of
. eight. Headings zero and two use the vertical position,
. one and three the horizontal. The speed is four, two or
. one. If he is already at a multiple of eight he stops.
E $CC5B View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DC79 }
. LIST#
R $CC5B IX The address of the sheriff
N $CC5B Heading zero.
  $CC5B,$03 Fetch the vertical position.
N $CC5E Find the distance to the next multiple of eight.
@ $CC5E label=SlowPlayerDown_Distance
  $CC5E,$02,b$01 Keep the lowest three bits.
  $CC60,$02 Jump to #R$CC85 if the position is a multiple of
. eight.
  $CC62,$04 Find the distance to the next multiple of eight.
  $CC66,$02 Set a speed of four.
  $CC68,$03 Jump to #R$CC71 if the distance is four or more.
  $CC6B,$02 Halve the speed.
  $CC6D,$03 Jump to #R$CC71 if the distance is two or more.
  $CC70,$01 Use the distance.
N $CC71 Move the sheriff at this speed.
@ $CC71 label=SlowPlayerDown_Speed
  $CC71,$03 Jump to #R$CC97.
N $CC74 Heading one.
@ $CC74 label=SlowPlayerDown_One
  $CC74,$03 Fetch the horizontal position.
  $CC77,$02 Jump to #R$CC5E.
N $CC79 Heading two.
@ $CC79 label=SlowPlayerDown_Two
  $CC79,$03 Fetch the vertical position.
N $CC7C Heading two or three.
@ $CC7C label=SlowPlayerDown_Negate
  $CC7C,$02 Make it negative.
  $CC7E,$02 Jump to #R$CC5E.
N $CC80 Heading three.
@ $CC80 label=SlowPlayerDown_Three
  $CC80,$03 Fetch the horizontal position.
  $CC83,$02 Jump to #R$CC7C.
N $CC85 The sheriff is at a multiple of eight, so he
. stops.
@ $CC85 label=SlowPlayerDown_Stop
  $CC85,$05 Set the speed to zero and return.

c $CC8A Speed Player Up
@ $CC8A label=SpeedPlayerUp
D $CC8A Raises the speed halfway towards #R$A21F and
. keeps it even.
E $CC8A Continue on to #R$CC97.
E $CC8A View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DCA8 }
. LIST#
R $CC8A IX The address of the sheriff
R $CC8A O:A The speed
N $CC8A Work out the average of the speed and #R$A21F.
  $CC8A,$03 Fetch #R$A21F.
  $CC8D,$03 Subtract the speed.
  $CC90,$02 Halve the difference.
  $CC92,$03 Add the speed.
  $CC95,$02,b$01 Keep it even.

c $CC97 Move Player Forward
@ $CC97 label=MovePlayerForward
D $CC97 Sets the speed and moves the sheriff one step in
. the direction of his heading, stopping at walls. A step
. plays #R$AED3 and #R$AEED, and moves on to the next
. walking frame.
E $CC97 Continue on to #R$CCAE.
R $CC97 A The speed
R $CC97 IX The address of the sheriff
N $CC97 Set the speed and check the walls. Keep the flags
. from before the check for #R$AED3.
  $CC97,$03 Set the speed.
  $CC9A,$03 Call #R$CCC2.
  $CC9D,$03 Fetch the flags.
  $CCA0,$01 Stash the flags on the stack.
  $CCA1,$03 Call #R$CD8C.
  $CCA4,$01 Restore the flags from the stack.
N $CCA5 Play the sounds and move the sheriff.
  $CCA5,$03 Call #R$AED3.
  $CCA8,$03 Call #R$CCE5.
  $CCAB,$03 Call #R$AEED.

c $CCAE Next Sprite Number
@ $CCAE label=NextSpriteNumber
D $CCAE Moves on to the next of the four walking frames of
. a figure. They are the lowest two bits of the walking
. frame.
E $CCAE View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B18C }
. { #KNIGHTLORE$B98C }
. { #MARTIANOIDS$B063 }
. { #NIGHTSHADE$CEF8 }
. LIST#
R $CCAE IX The address of the figure
N $CCAE Add one to the lowest two bits of the walking
. frame.
  $CCAE,$04 Fetch the walking frame and keep it in #REGc.
  $CCB2,$01 Add one.
  $CCB3,$02,b$01 Keep the lowest two bits.
  $CCB5,$01 Keep them in #REGb.
N $CCB6 Put them back in the walking frame.
  $CCB6,$01 Fetch the walking frame again.
  $CCB7,$02,b$01 Clear the lowest two bits.
  $CCB9,$01 Put in the new frame.
  $CCBA,$04 Set the walking frame and return.

g $CCBE Facing Flags
@ $CCBE label=FacingFlags
D $CCBE One byte for each heading. Bit 6 flips the sprites,
. and bit 2 chooses the second set of walking frames. When
. #R$A268 is set, #R$CC13 XORs the heading with two, so
. opposite headings swap.
B $CCBE,$01,b$01 Heading zero.
B $CCBF,$01,b$01 Heading one.
B $CCC0,$01,b$01 Heading two.
B $CCC1,$01,b$01 Heading three.

c $CCC2 Set Speeds From Heading
@ $CCC2 label=SetSpeedsFromHeading
D $CCC2 Turns a speed into #R$A214 and #R$A215 from the
. heading of the object. Headings zero and two move
. vertically, one and three horizontally. Headings two and
. three have a negative speed.
E $CCC2 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DCE0 }
. LIST#
R $CCC2 A The speed
R $CCC2 IX The address of the object
N $CCC2 Put the speed on the horizontal axis.
  $CCC2,$03 Make the speed the horizontal speed, with no
. vertical speed.
  $CCC5,$06 Jump to #R$CCCE if the heading is horizontal.
N $CCCB Put the speed on the vertical axis.
  $CCCB,$03 Make the speed the vertical speed, with no
. horizontal speed.
N $CCCE Make the speed negative for headings two and three.
@ $CCCE label=SetSpeedsFromHeading_Sign
  $CCCE,$06 Jump to #R$CCDC if the heading is not two or
. three.
  $CCD4,$04 Make the horizontal speed negative.
  $CCD8,$04 Make the vertical speed negative.
N $CCDC Store the speeds.
@ $CCDC label=SetSpeedsFromHeading_Store
  $CCDC,$04 Set #R$A214.
  $CCE0,$05 Set #R$A215 and return.

c $CCE5 Move Object
@ $CCE5 label=MoveObject
D $CCE5 Moves an object by the signed speeds at #R$A214 and
. #R$A215.
E $CCE5 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DD01 }
. LIST#
R $CCE5 IX The address of the object
N $CCE5 Add #R$A214 to the horizontal position.
  $CCE5,$03 Fetch #R$A214.
  $CCE8,$03 Call #R$D023.
  $CCEB,$06 Fetch the horizontal position.
  $CCF1,$01 Add the speed to it.
  $CCF2,$06 Set the horizontal position.
N $CCF8 Add #R$A215 to the vertical position.
  $CCF8,$03 Fetch #R$A215.
  $CCFB,$03 Call #R$D023.
  $CCFE,$06 Fetch the vertical position.
  $CD04,$01 Add the speed to it.
  $CD05,$07 Set the vertical position and return.

c $CD0C Check Rotate Key
@ $CD0C label=CheckRotateKey
D $CD0C Rotates the view when the rotate control is pressed and
. then released. #R$A256 is set while it is held, and on
. release the lowest bit of #R$A268 is flipped.
E $CD0C View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DB68 }
. LIST#
R $CD0C E The controls
N $CD0C Set #R$A256 while the rotate control is held.
  $CD0C,$03 Point #REGhl at #R$A256.
  $CD0F,$04 Jump to #R$CD16 if rotate is not pressed.
  $CD13,$03 Set #R$A256 and return.
N $CD16 Flip #R$A268 when the control is released.
@ $CD16 label=CheckRotateKey_Released
  $CD16,$03 Return if the control was not held.
  $CD19,$02 Clear #R$A256.
  $CD1B,$03 Point #REGhl at #R$A268.
  $CD1E,$01 Fetch #R$A268.
  $CD1F,$02,b$01 Flip the lowest bit.
  $CD21,$02 Set #R$A268 and return.

c $CD23 Swap Controls
@ $CD23 label=SwapControls
D $CD23 Swaps left with right, and up with down, so that the
. controls match a rotated view. Fire is kept.
E $CD23 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DC43 }
. LIST#
R $CD23 E The controls
R $CD23 O:E The swapped controls
N $CD23 Keep fire, then swap left with right.
  $CD23,$01 Fetch the controls.
  $CD24,$02,b$01 Keep fire.
  $CD26,$04 Jump to #R$CD2C if left is not pressed.
  $CD2A,$02 Set the control for right.
N $CD2C Swap right with left.
@ $CD2C label=SwapControls_Right
  $CD2C,$04 Jump to #R$CD32 if right is not pressed.
  $CD30,$02 Set the control for left.
N $CD32 Swap up with down.
@ $CD32 label=SwapControls_Up
  $CD32,$04 Jump to #R$CD38 if up is not pressed.
  $CD36,$02 Set the control for down.
N $CD38 Swap down with up.
@ $CD38 label=SwapControls_Down
  $CD38,$04 Jump to #R$CD3E if down is not pressed.
  $CD3C,$02 Set the control for up.
N $CD3E Store the swapped controls.
@ $CD3E label=SwapControls_Store
  $CD3E,$02 Set the controls and return.

c $CD40 Check Walls Each Way
@ $CD40 label=CheckWallsEachWay
D $CD40 Checks the walls for each speed on its own, so that the
. object slides along a wall instead of stopping. For each
. speed it sets the heading to the direction of that speed,
. and checks the walls with the other speed set to zero.
R $CD40 IX The address of the object
N $CD40 Check the walls for the horizontal speed.
  $CD40,$03 Fetch #R$A214.
  $CD43,$03 Jump to #R$CD66 if it is zero.
  $CD46,$02 Use heading one.
  $CD48,$03 Jump to #R$CD4D if the speed is not negative.
  $CD4B,$02,b$01 Use heading three.
N $CD4D Set the heading, zero #R$A215, and check the walls.
@ $CD4D label=CheckWallsEachWay_SetHorizontal
  $CD4D,$01 Keep the heading in #REGc.
  $CD4E,$03 Fetch the heading and flags.
  $CD51,$02,b$01 Keep the other bits.
  $CD53,$01 Put in the new heading.
  $CD54,$03 Set the heading and flags.
  $CD57,$03 Fetch #R$A215.
  $CD5A,$01 Stash the vertical speed on the stack.
  $CD5B,$04 Set #R$A215 to #N$00.
  $CD5F,$03 Call #R$CD8C.
  $CD62,$01 Restore the vertical speed from the stack.
  $CD63,$03 Set #R$A215.
N $CD66 Check the walls for the vertical speed.
@ $CD66 label=CheckWallsEachWay_Vertical
  $CD66,$03 Fetch #R$A215.
  $CD69,$02 Return if it is zero.
  $CD6B,$02 Use heading zero.
  $CD6D,$03 Jump to #R$CD72 if the speed is not negative.
  $CD70,$02,b$01 Use heading two.
N $CD72 Set the heading, zero #R$A214, and check the walls.
@ $CD72 label=CheckWallsEachWay_SetVertical
  $CD72,$01 Keep the heading in #REGc.
  $CD73,$03 Fetch the heading and flags.
  $CD76,$02,b$01 Keep the other bits.
  $CD78,$01 Put in the new heading.
  $CD79,$03 Set the heading and flags.
  $CD7C,$03 Fetch #R$A214.
  $CD7F,$01 Stash the horizontal speed on the stack.
  $CD80,$04 Set #R$A214 to #N$00.
  $CD84,$03 Call #R$CD90.
  $CD87,$01 Restore the horizontal speed from the stack.
  $CD88,$03 Set #R$A214.
  $CD8B,$01 Return.

c $CD8C Test Move
@ $CD8C label=TestMove
D $CD8C Checks whether an object can move in the direction of
. its heading without going into a wall. A wall changes the
. speeds so that the object stops, and sets bit 0 of the
. flags.
E $CD8C View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DE59 }
. LIST#
R $CD8C IX The address of the object
R $CD8C O:F The carry flag is set if the object hit a wall
N $CD8C Clear bit 0 of the flags, then run the routine for the
. heading.
  $CD8C,$04 Clear bit 0 of the flags of the object.
N $CD90 Run the routine for the heading, without clearing the
. flag.
@ $CD90 label=CheckWalls
  $CD90,$03 Fetch the heading.
  $CD93,$02 Move the heading into the lowest two bits.
  $CD95,$02,b$01 Keep only the heading.
  $CD97,$03 Point #REGbc at #R$CD9D.
  $CD9A,$03 Jump to #R$C766.

g $CD9D Check Walls Routines
@ $CD9D label=CheckWallsRoutines
D $CD9D The routines that #R$CD90 runs for each heading.
W $CD9D,$02 Heading zero: #R$CDA5.
W $CD9F,$02 Heading one: #R$CE08.
W $CDA1,$02 Heading two: #R$CE6B.
W $CDA3,$02 Heading three: #R$CED0.

c $CDA5 Test Move Up
@ $CDA5 label=TestMoveUp
D $CDA5 Checks the walls for an object that is moving in the
. direction of heading zero. The front edge is the vertical
. position plus the vertical size. The two ends of that
. edge, now and after the move, are checked with #R$CF35.
E $CDA5 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DE72 }
. LIST#
R $CDA5 IX The address of the object
R $CDA5 O:F The carry flag is set if the object hit a wall
N $CDA5 Find the left end and the front edge.
  $CDA5,$06 Fetch the horizontal position of the object.
  $CDAB,$05 Fetch the horizontal size.
  $CDB0,$04 Subtract it to get the left end in #REGde.
  $CDB4,$06 Fetch the vertical position of the object.
  $CDBA,$03 Fetch the vertical size.
  $CDBD,$01 Add it to get the front edge.
N $CDBE Check the cell at the left end.
  $CDBE,$02 Stash the left end and the front edge on the stack.
  $CDC0,$03 Call #R$CF35.
  $CDC3,$02 Restore the front edge and the left end from the
. stack, with the registers swapped.
  $CDC5,$01 Return if the object has hit a wall.
N $CDC6 Check the cell at the right end, if it is in another
. cell.
  $CDC6,$02 Stash the left end and the front edge on the stack.
  $CDC8,$07 Double the horizontal size into #REGbc.
  $CDCF,$02 Find the right end of the front edge.
  $CDD1,$03 Jump to #R$CDF9 if it is in the same cell.
  $CDD4,$01 Make the right end the one to check.
  $CDD5,$03 Call #R$CF35.
  $CDD8,$02 Restore the left end and the front edge from the
. stack.
  $CDDA,$01 Return if the object has hit a wall.
N $CDDB Check the cells after the move.
  $CDDB,$03 Fetch #R$A215.
  $CDDE,$03 Make it a word in #REGbc.
  $CDE1,$02 Find the front edge after the move.
  $CDE3,$02 Return if it is in the same cell.
  $CDE5,$02 Stash the left end and the front edge on the stack.
  $CDE7,$03 Call #R$CF35.
  $CDEA,$02 Restore the front edge and the left end from the
. stack, with the registers swapped.
  $CDEC,$01 Return if the object has hit a wall.
  $CDED,$07 Double the horizontal size into #REGbc.
  $CDF4,$01 Find the right end of the front edge.
  $CDF5,$01 Make the right end the one to check.
N $CDF6 Check the cell at the right end.
  $CDF6,$03 Jump to #R$CF35.
N $CDF9 The ends are in the same cell, so only the cell beyond
. the front edge is checked.
@ $CDF9 label=TestMoveUp_Same
  $CDF9,$02 Restore the front edge and the left end from the
. stack.
  $CDFB,$03 Fetch #R$A215.
  $CDFE,$03 Make it a word in #REGbc.
  $CE01,$02 Find the front edge after the move.
  $CE03,$02 Return if it is in the same cell.
N $CE05 Check the cell.
  $CE05,$03 Jump to #R$CF35.

c $CE08 Test Move Right
@ $CE08 label=TestMoveRight
D $CE08 Checks the walls for an object that is moving in the
. direction of heading one. The front edge is the horizontal
. position plus the horizontal size. The two ends of that
. edge, now and after the move, are checked with #R$CF50.
E $CE08 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DED3 }
. LIST#
R $CE08 IX The address of the object
R $CE08 O:F The carry flag is set if the object hit a wall
N $CE08 Find the front edge and the lower end.
  $CE08,$06 Fetch the horizontal position of the object.
  $CE0E,$05 Fetch the horizontal size.
  $CE13,$02 Add it to get the front edge in #REGde.
  $CE15,$06 Fetch the vertical position of the object.
  $CE1B,$03 Fetch the vertical size.
  $CE1E,$03 Subtract it to get the lower end.
N $CE21 Check the cell at the lower end.
  $CE21,$02 Stash the front edge and the end on the stack.
  $CE23,$03 Call #R$CF50.
  $CE26,$02 Restore the end and the front edge from the stack.
  $CE28,$01 Return if the object has hit a wall.
N $CE29 Check the cell at the other end, if it is in another
. cell.
  $CE29,$02 Stash the front edge and the end on the stack.
  $CE2B,$07 Double the vertical size into #REGbc.
  $CE32,$02 Find the other end of the front edge.
  $CE34,$03 Jump to #R$CE5B if it is in the same cell.
  $CE37,$03 Call #R$CF50.
  $CE3A,$02 Restore the front edge and the end from the stack,
. with the registers swapped.
  $CE3C,$01 Return if the object has hit a wall.
N $CE3D Check the cells after the move.
  $CE3D,$03 Fetch #R$A214.
  $CE40,$03 Make it a word in #REGbc.
  $CE43,$02 Find the front edge after the move.
  $CE45,$02 Return if it is in the same cell.
  $CE47,$01 Make the first end the one to check.
  $CE48,$02 Stash the front edge and the end on the stack.
  $CE4A,$03 Call #R$CF50.
  $CE4D,$02 Restore the end and the front edge from the stack.
  $CE4F,$01 Return if the object has hit a wall.
  $CE50,$07 Double the vertical size into #REGbc.
  $CE57,$01 Find the other end of the front edge.
N $CE58 Check the cell at the other end.
  $CE58,$03 Jump to #R$CF50.
N $CE5B The ends are in the same cell, so only the cell beyond
. the front edge is checked.
@ $CE5B label=TestMoveRight_Same
  $CE5B,$02 Restore the end and the front edge from the stack,
. with the registers swapped.
  $CE5D,$03 Fetch #R$A214.
  $CE60,$03 Make it a word in #REGbc.
  $CE63,$02 Find the front edge after the move.
  $CE65,$02 Return if it is in the same cell.
  $CE67,$01 Make the front edge the one to check.
N $CE68 Check the cell.
  $CE68,$03 Jump to #R$CF50.

c $CE6B Test Move Down
@ $CE6B label=TestMoveDown
D $CE6B Checks the walls for an object that is moving in the
. direction of heading two. The front edge is the vertical
. position minus the vertical size. The two ends of that
. edge, now and after the move, are checked with #R$CF48.
E $CE6B View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DF34 }
. LIST#
R $CE6B IX The address of the object
R $CE6B O:F The carry flag is set if the object hit a wall
N $CE6B Find the left end and the front edge.
  $CE6B,$06 Fetch the horizontal position of the object.
  $CE71,$05 Fetch the horizontal size.
  $CE76,$04 Subtract it to get the left end in #REGde.
  $CE7A,$06 Fetch the vertical position of the object.
  $CE80,$03 Fetch the vertical size.
  $CE83,$03 Subtract it to get the front edge.
N $CE86 Check the cell at the left end.
  $CE86,$02 Stash the left end and the front edge on the stack.
  $CE88,$03 Call #R$CF48.
  $CE8B,$02 Restore the front edge and the left end from the
. stack, with the registers swapped.
  $CE8D,$01 Return if the object has hit a wall.
N $CE8E Check the cell at the right end, if it is in another
. cell.
  $CE8E,$02 Stash the left end and the front edge on the stack.
  $CE90,$07 Double the horizontal size into #REGbc.
  $CE97,$02 Find the right end of the front edge.
  $CE99,$03 Jump to #R$CEC1 if it is in the same cell.
  $CE9C,$01 Make the right end the one to check.
  $CE9D,$03 Call #R$CF48.
  $CEA0,$02 Restore the left end and the front edge from the
. stack.
  $CEA2,$01 Return if the object has hit a wall.
N $CEA3 Check the cells after the move.
  $CEA3,$03 Fetch #R$A215.
  $CEA6,$03 Make it a negative word in #REGbc.
  $CEA9,$02 Find the front edge after the move.
  $CEAB,$02 Return if it is in the same cell.
  $CEAD,$02 Stash the left end and the front edge on the stack.
  $CEAF,$03 Call #R$CF48.
  $CEB2,$02 Restore the front edge and the left end from the
. stack, with the registers swapped.
  $CEB4,$01 Return if the object has hit a wall.
  $CEB5,$07 Double the horizontal size into #REGbc.
  $CEBC,$01 Find the right end of the front edge.
  $CEBD,$01 Make the right end the one to check.
N $CEBE Check the cell at the right end.
  $CEBE,$03 Jump to #R$CF48.
N $CEC1 The ends are in the same cell, so only the cell beyond
. the front edge is checked.
@ $CEC1 label=TestMoveDown_Same
  $CEC1,$02 Restore the front edge and the left end from the
. stack.
  $CEC3,$03 Fetch #R$A215.
  $CEC6,$03 Make it a negative word in #REGbc.
  $CEC9,$02 Find the front edge after the move.
  $CECB,$02 Return if it is in the same cell.
N $CECD Check the cell.
  $CECD,$03 Jump to #R$CF48.

c $CED0 Test Move Left
@ $CED0 label=TestMoveLeft
D $CED0 Checks the walls for an object that is moving in the
. direction of heading three. The front edge is the horizontal
. position minus the horizontal size. The two ends of that
. edge, now and after the move, are checked with #R$CF5F.
E $CED0 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DF97 }
. LIST#
R $CED0 IX The address of the object
R $CED0 O:F The carry flag is set if the object hit a wall
N $CED0 Find the front edge and the lower end.
  $CED0,$06 Fetch the horizontal position of the object.
  $CED6,$05 Fetch the horizontal size.
  $CEDB,$04 Subtract it to get the front edge in #REGde.
  $CEDF,$06 Fetch the vertical position of the object.
  $CEE5,$03 Fetch the vertical size.
  $CEE8,$03 Subtract it to get the lower end.
N $CEEB Check the cell at the lower end.
  $CEEB,$02 Stash the front edge and the end on the stack.
  $CEED,$03 Call #R$CF5F.
  $CEF0,$02 Restore the end and the front edge from the stack.
  $CEF2,$01 Return if the object has hit a wall.
N $CEF3 Check the cell at the other end, if it is in another
. cell.
  $CEF3,$02 Stash the front edge and the end on the stack.
  $CEF5,$07 Double the vertical size into #REGbc.
  $CEFC,$02 Find the other end of the front edge.
  $CEFE,$03 Jump to #R$CF25 if it is in the same cell.
  $CF01,$03 Call #R$CF5F.
  $CF04,$02 Restore the front edge and the end from the stack,
. with the registers swapped.
  $CF06,$01 Return if the object has hit a wall.
N $CF07 Check the cells after the move.
  $CF07,$03 Fetch #R$A214.
  $CF0A,$03 Make it a negative word in #REGbc.
  $CF0D,$02 Find the front edge after the move.
  $CF0F,$02 Return if it is in the same cell.
  $CF11,$01 Make the first end the one to check.
  $CF12,$02 Stash the front edge and the end on the stack.
  $CF14,$03 Call #R$CF5F.
  $CF17,$02 Restore the end and the front edge from the stack.
  $CF19,$01 Return if the object has hit a wall.
  $CF1A,$07 Double the vertical size into #REGbc.
  $CF21,$01 Find the other end of the front edge.
N $CF22 Check the cell at the other end.
  $CF22,$03 Jump to #R$CF5F.
N $CF25 The ends are in the same cell, so only the cell beyond
. the front edge is checked.
@ $CF25 label=TestMoveLeft_Same
  $CF25,$02 Restore the end and the front edge from the stack,
. with the registers swapped.
  $CF27,$03 Fetch #R$A214.
  $CF2A,$03 Make it a negative word in #REGbc.
  $CF2D,$02 Find the front edge after the move.
  $CF2F,$02 Return if it is in the same cell.
  $CF31,$01 Make the front edge the one to check.
N $CF32 Check the cell.
  $CF32,$03 Jump to #R$CF5F.

c $CF35 Check Wall Vertical
@ $CF35 label=CheckWallVertical
D $CF35 Checks whether an object that is moving in the direction
. of heading zero touches a wall in the cell containing a
. point. If it does, #R$A215 is reduced by twice the depth and
. the object is marked as having hit a wall.
E $CF35 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$DFFA }
. LIST#
R $CF35 DE The horizontal position of the point
R $CF35 HL The vertical position of the point
R $CF35 IX The address of the object
R $CF35 O:F The carry flag is set if the object hit a wall
N $CF35 Check the walls, then push the object back if it is
. touching one.
  $CF35,$03 Call #R$CFDE.
  $CF38,$01 Return if the object is not touching a wall.
N $CF39 Reduce #R$A215 by twice the depth.
@ $CF39 label=CheckWallVertical_PushBack
  $CF39,$02 Double the depth and keep it in #REGc.
  $CF3B,$03 Fetch #R$A215.
  $CF3E,$04 Add the depth and set #R$A215.
N $CF42 Mark the object as having hit a wall.
@ $CF42 label=CheckWall_Hit
  $CF42,$04 Set bit 0 of the flags of the object.
  $CF46,$02 Set the carry flag and return.

c $CF48 Check Wall Vertical Reverse
@ $CF48 label=CheckWallVerticalReverse
D $CF48 Checks whether an object that is moving in the direction
. of heading two touches a wall in the cell containing a
. point. If it does, the depth is made positive and the object
. is pushed back by #R$CF39.
E $CF48 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E00B }
. LIST#
R $CF48 DE The horizontal position of the point
R $CF48 HL The vertical position of the point
R $CF48 IX The address of the object
R $CF48 O:F The carry flag is set if the object hit a wall
N $CF48 Check the walls, then push the object back if it is
. touching one.
  $CF48,$03 Call #R$CFDE.
  $CF4B,$01 Return if the object is not touching a wall.
  $CF4C,$04 Make the depth positive, and jump to #R$CF39.

c $CF50 Check Wall Horizontal
@ $CF50 label=CheckWallHorizontal
D $CF50 Checks whether an object that is moving in the direction
. of heading one touches a wall in the cell containing a
. point. If it does, #R$A214 is reduced by twice the depth and
. the object is marked as having hit a wall.
E $CF50 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E013 }
. LIST#
R $CF50 DE The horizontal position of the point
R $CF50 HL The vertical position of the point
R $CF50 IX The address of the object
R $CF50 O:F The carry flag is set if the object hit a wall
N $CF50 Check the walls, then push the object back if it is
. touching one.
  $CF50,$03 Call #R$CFA1.
  $CF53,$01 Return if the object is not touching a wall.
N $CF54 Reduce #R$A214 by twice the depth.
@ $CF54 label=CheckWallHorizontal_PushBack
  $CF54,$02 Double the depth and keep it in #REGc.
  $CF56,$03 Fetch #R$A214.
  $CF59,$04 Add the depth and set #R$A214.
  $CF5D,$02 Jump to #R$CF42.

c $CF5F Check Wall Horizontal Reverse
@ $CF5F label=CheckWallHorizontalReverse
D $CF5F Checks whether an object that is moving in the direction
. of heading three touches a wall in the cell containing a
. point. If it does, the depth is made positive and the object
. is pushed back by #R$CF54.
E $CF5F View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E020 }
. LIST#
R $CF5F DE The horizontal position of the point
R $CF5F HL The vertical position of the point
R $CF5F IX The address of the object
R $CF5F O:F The carry flag is set if the object hit a wall
N $CF5F Check the walls, then push the object back if it is
. touching one.
  $CF5F,$03 Call #R$CFA1.
  $CF62,$01 Return if the object is not touching a wall.
  $CF63,$04 Make the depth positive, and jump to #R$CF54.

c $CF67 Find Position In Cell
@ $CF67 label=FindPositionInCell
D $CF67 Finds the code of the cell at column #REGd and row
. #REGh in #R$5FB1, and where the object is in that cell. The
. position in the cell is half the distance from the corner,
. plus #N$40.
E $CF67 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E028 }
. LIST#
R $CF67 D The column of the cell
R $CF67 H The row of the cell
R $CF67 IX The address of the object
R $CF67 O:A The code of the cell
R $CF67 O:D The vertical position of the object in the cell
R $CF67 O:E The horizontal position of the object in the cell
R $CF67 O:F The zero flag is set if the cell is empty
N $CF67 Keep the row and column, and find the corner of the cell.
  $CF67,$02 Keep the row in #REGb and the column in #REGc.
  $CF69,$01 Stash the row and column on the stack.
  $CF6A,$03 Make #REGde the corner of the column, and #REGbc the
. corner of the row.
N $CF6D Find the horizontal position of the object in the cell.
  $CF6D,$06 Fetch the horizontal position of the object.
  $CF73,$03 Subtract the corner of the column.
  $CF76,$04 Halve the distance.
  $CF7A,$04 Add #N$40 and keep it in #REGe.
N $CF7E Find the vertical position of the object in the cell.
  $CF7E,$06 Fetch the vertical position of the object.
  $CF84,$03 Subtract the corner of the row.
  $CF87,$04 Halve the distance.
  $CF8B,$04 Add #N$40 and keep it in #REGd.
N $CF8F Find the code of the cell in #R$5FB1.
  $CF8F,$01 Restore the row and column from the stack.
  $CF90,$04 Put the column in #REGa and the row in #REGhl.
  $CF94,$04 Multiply the row by sixteen.
  $CF98,$02 Add the column.
  $CF9A,$04 Add the address of #R$5FB1.
  $CF9E,$03 Fetch the code of the cell and return.

c $CFA1 Check Walls Vertical First
@ $CFA1 label=CheckWallsVerticalFirst
D $CFA1 Checks whether an object touches any wall rectangle in
. the cell containing a point. The list for the cell is found
. from #R$6151. The vertical range is checked first.
E $CFA1 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E063 }
. LIST#
R $CFA1 DE The horizontal position of the point
R $CFA1 HL The vertical position of the point
R $CFA1 IX The address of the object
R $CFA1 O:A The depth into the wall along X, negative if they
. overlap
R $CFA1 O:F The carry flag is set if the object touches a wall
N $CFA1 Find the cell and its rectangle list.
  $CFA1,$03 Call #R$CF67.
  $CFA4,$03 Point #REGbc at #R$6151.
  $CFA7,$03 Call #R$C75C.
  $CFAA,$03 Copy the rectangle list to #REGiy (using the stack).
N $CFAD Test the next rectangle.
@ $CFAD label=CheckWallsVerticalFirst_Next
  $CFAD,$05 Return if this is the end of the list.
  $CFB2,$03 Call #R$D002.
  $CFB5,$02 Jump to #R$CFBB if the object is not touching the
. rectangle.
  $CFB7,$03 Call #R$CFC5.
  $CFBA,$01 Return if the object is touching the rectangle.
N $CFBB Move on to the next rectangle.
@ $CFBB label=CheckWallsVerticalFirst_Skip
  $CFBB,$08 Move on to the next rectangle.
  $CFC3,$02 Jump to #R$CFAD.

c $CFC5 Check Overlap Along X
@ $CFC5 label=CheckOverlapAlongX
D $CFC5 Checks whether the horizontal range of an object, after
. it moves by #R$A214, overlaps the horizontal range of a
. rectangle of a wall. The distance between the middles is
. compared with half of the width of the object plus the half
. width of the rectangle.
E $CFC5 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E087 }
. LIST#
R $CFC5 E The horizontal position of the object in the cell
R $CFC5 IX The address of the object
R $CFC5 IY The address of the rectangle
R $CFC5 O:A The depth into the rectangle, negative if they overlap
R $CFC5 O:F The carry flag is set if the ranges overlap
N $CFC5 Find the sum of the half widths.
  $CFC5,$09 Find the sum of half of the width of the object and
. the half width of the rectangle, in #REGc.
N $CFCE Find the distance between the middles.
  $CFCE,$03 Fetch #R$A214.
  $CFD1,$06 Add half of it to the position, then find the
. distance from the middle of the rectangle.
N $CFD7 Make the distance positive, then subtract the sum.
  $CFD7,$05 Make the distance positive.
@ $CFDC label=CheckOverlapAlongX_Depth
  $CFDC,$01 Subtract the sum.
  $CFDD,$01 Return.

c $CFDE Check Walls Horizontal First
@ $CFDE label=CheckWallsHorizontalFirst
D $CFDE Checks whether an object touches any wall rectangle in
. the cell containing a point. The list for the cell is found
. from #R$6151. The horizontal range is checked first.
E $CFDE View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E0A0 }
. LIST#
R $CFDE DE The horizontal position of the point
R $CFDE HL The vertical position of the point
R $CFDE IX The address of the object
R $CFDE O:A The depth into the wall along Y, negative if they
. overlap
R $CFDE O:F The carry flag is set if the object touches a wall
N $CFDE Find the cell and its rectangle list.
  $CFDE,$03 Call #R$CF67.
  $CFE1,$03 Point #REGbc at #R$6151.
  $CFE4,$03 Call #R$C75C.
  $CFE7,$03 Copy the rectangle list to #REGiy (using the stack).
N $CFEA Test the next rectangle.
@ $CFEA label=CheckWallsHorizontalFirst_Next
  $CFEA,$05 Return if this is the end of the list.
  $CFEF,$03 Call #R$CFC5.
  $CFF2,$02 Jump to #R$CFF8 if the object is not touching the
. rectangle.
  $CFF4,$03 Call #R$D002.
  $CFF7,$01 Return if the object is touching the rectangle.
N $CFF8 Move on to the next rectangle.
@ $CFF8 label=CheckWallsHorizontalFirst_Skip
  $CFF8,$08 Move on to the next rectangle.
  $D000,$02 Jump to #R$CFEA.

c $D002 Check Overlap Along Y
@ $D002 label=CheckOverlapAlongY
D $D002 Checks whether the vertical range of an object, after it
. moves by #R$A215, overlaps the vertical range of a rectangle of
. a wall. The distance between the middles is compared with half
. of the height of the object plus the half height of the
. rectangle.
E $D002 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E0C4 }
. LIST#
R $D002 D The vertical position of the object in the cell
R $D002 IX The address of the object
R $D002 IY The address of the rectangle
R $D002 O:A The depth into the rectangle, negative if they overlap
R $D002 O:F The carry flag is set if the ranges overlap
N $D002 Find the sum of the half heights.
  $D002,$09 Find the sum of half of the height of the object and
. the half height of the rectangle, in #REGc.
N $D00B Find the distance between the middles.
  $D00B,$03 Fetch #R$A215.
  $D00E,$06 Add half of it to the position, then find the
. distance from the middle of the rectangle.
N $D014 Make the distance positive, then subtract the sum.
  $D014,$05 Make the distance positive.
@ $D019 label=CheckOverlapAlongY_Depth
  $D019,$01 Subtract the sum.
  $D01A,$01 Return.

c $D01B Negate HL
@ $D01B label=NegateHL
D $D01B Makes #REGhl negative.
E $D01B View the equivalent code in;
. #LIST
. { #LUNARJETMAN$8947 }
. { #MARTIANOIDS$B4B1 }
. { #NIGHTSHADE$E0DD }
. { #TRANZAM$6BF6 }
. LIST#
R $D01B HL The word
R $D01B O:HL The negative of the word
N $D01B Invert both bytes, then add one.
  $D01B,$03 Invert the low byte.
  $D01E,$03 Invert the high byte.
  $D021,$01 Add one.
  $D022,$01 Return.

c $D023 Sign Extend A To HL
@ $D023 label=SignExtendAToHL
D $D023 Makes a signed number into a signed word.
E $D023 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E0E5 }
. LIST#
R $D023 A The number
R $D023 O:HL The word
N $D023 Put the number in the low byte. The high byte is
. zero, or #N$FF if the number is negative.
  $D023,$01 Make the number the low byte.
  $D024,$01 Start with a high byte of zero.
  $D025,$04 Jump to #R$D02A if the number is not negative.
  $D029,$01 Make the high byte #N$FF.
@ $D02A label=SignExtendAToHL_Set
  $D02A,$01 Set the high byte.
  $D02B,$01 Return.

c $D02C Add Signed To HL
@ $D02C label=AddSignedToHL
D $D02C Adds a signed number to #REGhl.
R $D02C A The number
R $D02C HL The word
R $D02C O:HL The sum
N $D02C Add the number when it is not negative.
  $D02C,$04 Jump to #R$D037 if the number is negative.
  $D030,$02 Add the number to the low byte.
  $D032,$04 Add the carry to the high byte.
  $D036,$01 Return.
N $D037 Add the number when it is negative.
@ $D037 label=AddSignedToHL_Negative
  $D037,$02 Add the number to the low byte.
  $D039,$04 Subtract one from the high byte if there is no carry.
  $D03D,$01 Return.

c $D03E Multiply A By DE
@ $D03E label=MultiplyAByDE
D $D03E Multiplies #REGa by #REGde.
E $D03E View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE0D }
. { #ATICATAC$9AAD }
. { #KNIGHTLORE$D4F9 }
. { #NIGHTSHADE$E0EE }
. { #TRANZAM$6F2F }
. { #UNDERWURLDE$AC68 }
. LIST#
R $D03E A The multiplier
R $D03E DE The multiplicand
R $D03E O:HL The product
N $D03E Start with a product of zero, and count eight bits.
  $D03E,$03 Set the product to #N$0000.
  $D041,$02 Set a count of #N$08.
N $D043 Double the product, and add #REGde if the next bit of #REGa
. is set.
@ $D043 label=MultiplyAByDE_Bit
  $D043,$01 Double the product.
  $D044,$01 Move the next bit of the multiplier into the carry flag.
  $D045,$02 Jump to #R$D048 if it is not set.
  $D047,$01 Add the multiplicand.
N $D048 Count down the bits.
@ $D048 label=MultiplyAByDE_Next
  $D048,$02 Jump to #R$D043 until all the bits are done.
  $D04A,$01 Return.

c $D04B Copy Buffer To Screen
@ $D04B label=CopyBufferToScreen
D $D04B Copies #R$D6EB to the screen, from the bottom row up. Each
. row copies #N$16 bytes. In the town the copy sits beside the panel.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$A3BA)
. #SIM(start=$A3BA,stop=$A3ED)
. #SIM(start=$A3ED,stop=$A3F0)
. #SIM(start=$A3F0,stop=$A3F3)
. #SIM(start=$A3F3,stop=$A3F6)
. #SCR$03,$0A,$01,$15,$0E(copy-buffer) } UDGTABLE# #POPS
E $D04B View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E148 }
. LIST#
N $D04B Keep the stack pointer, and point it at the playfield on the
. screen.
  $D04B,$04 Set #R$A21D.
  $D04F,$03 Point #REGhl at #N$4FDB (in the screen buffer).
N $D052 Move it to the right in the town.
  $D052,$03 Call #R$D272.
  $D055,$01 Point the stack pointer at it.
  $D056,$02 Set a count of #N$70 rows.
  $D058,$03 Point #REGhl at #R$D702.
N $D05B Copy a row from the buffer to the screen.
@ $D05B label=CopyBufferToScreen_Row
  $D05B,$36 Copy eleven words of the row, working backwards.
  $D091,$01 Keep the address in the buffer in #REGde.
N $D092 Move up one pixel line on the screen.
  $D092,$04 Find the screen address one pixel line up.
  $D096,$02 Test whether it has crossed into the previous character
. row.
  $D098,$02,b$01 Keep the bits for the pixel line.
  $D09A,$03 Jump to #R$D0A8 if it has not.
N $D09D Move to the previous character row.
  $D09D,$04 Subtract #N$20 from the low byte.
  $D0A1,$03 Jump to #R$D0A8 if that is in the previous third.
  $D0A4,$04 Add #N$08 to the high byte.
N $D0A8 Point at the next row.
@ $D0A8 label=CopyBufferToScreen_Next
  $D0A8,$01 Point the stack pointer at the new screen address.
  $D0A9,$04 Find the end of the next row in the buffer.
  $D0AD,$02 Jump to #R$D05B.
N $D0AF Restore the stack pointer.
  $D0AF,$04 Fetch #R$A21D.
  $D0B3,$01 Return.

c $D0B4 Copy Buffer And Clear
@ $D0B4 label=CopyBufferAndClear
D $D0B4 Copies #R$D6EB to the screen and then clears it.
E $D0B4 Continue on to #R$D0B7.
N $D0B4 Copy the buffer to the screen.
  $D0B4,$03 Call #R$D04B.

c $D0B7 Clear Buffer
@ $D0B7 label=ClearBuffer
D $D0B7 Clears #R$D6EB by pushing zeroes onto the stack, #N$18 bytes
. in each of #N$70 rows.
E $D0B7 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E21D }
. LIST#
R $D0B7 O:HL The address of the start of the buffer
N $D0B7 Point at the end of #R$D6EB, and fill with zero.
  $D0B7,$03 Point #REGhl at the end of #R$D6EB.
  $D0BA,$03 Set the fill word to #N$0000.
  $D0BD,$02 Set a count of #N$70 rows.
N $D0BF Keep the stack pointer, and point it at the end of the buffer.
  $D0BF,$04 Set #R$A21D.
  $D0C3,$01 Point the stack pointer at the end of the buffer.
N $D0C4 Clear a row.
@ $D0C4 label=ClearBuffer_Row
  $D0C4,$0C Stash twelve zero words on the stack.
  $D0D0,$02 Jump to #R$D0C4.
N $D0D2 Keep the start of the buffer, and restore the stack pointer.
  $D0D2,$04 Put the start of the buffer in #REGhl.
  $D0D6,$04 Fetch #R$A21D.
  $D0DA,$01 Return.

c $D0DB Read Keyboard Port
@ $D0DB label=ReadKeyboardPort
D $D0DB Reads the keyboard half-rows selected by #REGa. A zero bit
. selects a half-row, and more than one half-row can be read at once.
. The keys that are pressed come back as set bits 0 to 4.
E $D0DB View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B759 }
. { #CYBERUN$9BC3 }
. { #KNIGHTLORE$B5F7 }
. { #NIGHTSHADE$E239 }
. { #PENTAGRAM$B952 }
. LIST#
R $D0DB A The half-rows to read, with a zero bit for each half-row
R $D0DB O:A The keys pressed, in bits 0 to 4
R $D0DB O:F The zero flag is set if no key is pressed
N $D0DB Write the selector to port #N$FD, which has no effect on a
. 48K Spectrum, then read port #N$FE.
  $D0DB,$02 Write the selector to port #N$FD.
  $D0DD,$02 Read the keyboard.
  $D0DF,$01 Make a one bit for each key which is pressed.
  $D0E0,$02,b$01 Keep the five bits for the keys.
  $D0E2,$01 Return.

c $D0E3 Read Controls
@ $D0E3 label=ReadControls
D $D0E3 Reads the controls using the method in bits 1 and 2 of
. #R$A21C.
. #TABLE(default,centre,centre)
. { =h Bit | =h Meaning }
. { #N$00 | Left }
. { #N$01 | Right }
. { #N$02 | Up }
. { #N$03 | Fire }
. { #N$04 | Down }
. { #N$05 | Rotate the view }
. TABLE#
E $D0E3 Continue on to #R$D0F2.
E $D0E3 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C8FF }
. { #KNIGHTLORE$D022 }
. { #NIGHTSHADE$E241 }
. { #PENTAGRAM$BDF8 }
. LIST#
R $D0E3 O:B The controls, with bits 0 and 1, and 2 and 3, made exclusive
R $D0E3 O:C The controls
N $D0E3 Fetch the control method from #R$A21C.
  $D0E3,$03 Fetch #R$A21C.
  $D0E6,$01 Move the type of controls into the low bits.
  $D0E7,$02,b$01 Keep the two bits.
  $D0E9,$03 Jump to #R$D17C if the method is the keyboard.
  $D0EC,$03 Jump to #R$D12B if it is a Kempston joystick.
  $D0EF,$03 Jump to #R$D150 if it is a cursor joystick.

c $D0F2 Read Interface 2 Joystick
@ $D0F2 label=ReadInterface2Joystick
D $D0F2 Reads an Interface 2 joystick. The first joystick is 1 to 5
. (left, right, down, up, fire) and the second is 6 to 0. The first
. row is reversed and the two are combined, so either can be used.
E $D0F2 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C91B }
. { #KNIGHTLORE$D03E }
. { #NIGHTSHADE$E250 }
. LIST#
R $D0F2 O:C The controls
N $D0F2 Read 1 to 5.
  $D0F2,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $D0F7,$01 Stash #REGbc on the stack.
  $D0F8,$02 Set a count of #N$05.
N $D0FA Reverse the five keys into #REGc.
@ $D0FA label=ReadInterface2Joystick_Reverse
  $D0FA,$05 Reverse the five keys into #REGc.
  $D0FF,$03 Keep the reversed keys, and restore #REGbc.
N $D102 Read 6 to 0, and combine the two joysticks.
  $D102,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $D107,$01 Combine them with the reversed keys.
  $D108,$02 Clear the controls.
N $D10A Set bit 3 if fire is pressed.
  $D10A,$06 Set bit 3 if fire is pressed.
N $D110 Set bit 2 if up is pressed.
@ $D110 label=ReadInterface2Joystick_TestUp
  $D110,$06 Set bit 2 if up is pressed.
N $D116 Set bit 4 if down is pressed.
@ $D116 label=ReadInterface2Joystick_TestDown
  $D116,$06 Set bit 4 if down is pressed.
N $D11C Set bit 1 if right is pressed.
@ $D11C label=ReadInterface2Joystick_TestRight
  $D11C,$06 Set bit 1 if right is pressed.
N $D122 Set bit 0 if left is pressed.
@ $D122 label=ReadInterface2Joystick_TestLeft
  $D122,$06 Set bit 0 if left is pressed.
N $D128 Jump to #R$D1BE.
@ $D128 label=ReadInterface2Joystick_Finish
  $D128,$03 Jump to #R$D1BE.

c $D12B Read Kempston Joystick
@ $D12B label=ReadKempstonJoystick
D $D12B Reads a Kempston joystick from port #N$1F.
E $D12B View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C954 }
. { #KNIGHTLORE$D077 }
. { #NIGHTSHADE$E289 }
. LIST#
R $D12B O:C The controls
N $D12B Read the joystick, and start with no controls.
  $D12B,$02 Read the joystick from port #N$1F.
  $D12D,$02 Clear the controls.
N $D12F Set bit 1 if the joystick is pushed right.
  $D12F,$06 Set bit 1 if the joystick is pushed right.
N $D135 Set bit 0 if the joystick is pushed left.
@ $D135 label=ReadKempstonJoystick_TestLeft
  $D135,$06 Set bit 0 if the joystick is pushed left.
N $D13B Set bit 4 if the joystick is pushed down.
@ $D13B label=ReadKempstonJoystick_TestDown
  $D13B,$06 Set bit 4 if the joystick is pushed down.
N $D141 Set bit 2 if the joystick is pushed up.
@ $D141 label=ReadKempstonJoystick_TestUp
  $D141,$06 Set bit 2 if the joystick is pushed up.
N $D147 Set bit 3 if the fire button is pressed.
@ $D147 label=ReadKempstonJoystick_TestFire
  $D147,$06 Set bit 3 if the fire button is pressed.
N $D14D Jump to #R$D1BE.
@ $D14D label=ReadKempstonJoystick_Finish
  $D14D,$03 Jump to #R$D1BE.

c $D150 Read Cursor Joystick
@ $D150 label=ReadCursorJoystick
D $D150 Reads a cursor joystick. 5 is left, 8 is right, 7 is up, 6 is
. down and 0 is fire.
E $D150 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$C979 }
. { #KNIGHTLORE$D09C }
. { #NIGHTSHADE$E2AE }
. LIST#
R $D150 O:C The controls
N $D150 Start with no controls, and read 5 for left.
  $D150,$02 Clear the controls.
  $D152,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $D157,$06 Set bit 0 if 5 is pressed.
N $D15D Read 0, 7, 8 and 6.
@ $D15D label=ReadCursorJoystick_SecondRow
  $D15D,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $D162,$06 Set bit 3 if 0 is pressed.
N $D168 Set bit 2 if 7 is pressed.
@ $D168 label=ReadCursorJoystick_TestUp
  $D168,$06 Set bit 2 if 7 is pressed.
N $D16E Set bit 1 if 8 is pressed.
@ $D16E label=ReadCursorJoystick_TestRight
  $D16E,$06 Set bit 1 if 8 is pressed.
N $D174 Set bit 4 if 6 is pressed, and jump to #R$D1BE.
@ $D174 label=ReadCursorJoystick_TestDown
  $D174,$04 Jump to #R$D1BE if 6 is not pressed.
  $D178,$04 Set bit 4, and jump to #R$D1BE.

c $D17C Read Keyboard
@ $D17C label=ReadKeyboard
D $D17C Reads the controls from the keyboard. Left is X, V, M or B,
. right is C or N, up is any key from A to G or from H to ENTER, fire
. is any key from Q to T or from Y to P, and down is any key from 1 to
. 5 or from 6 to 0.
E $D17C Continue on to #R$D1BE.
E $D17C View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E2DA }
. LIST#
R $D17C O:C The controls
N $D17C Read left and right from CAPS SHIFT to V.
  $D17C,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | CAPS SHIFT | Z | X | C | V }
. TABLE#
  $D181,$02 Move X to bit 0 and C to bit 1.
  $D183,$06 Set bit 0 if V is pressed.
N $D189 Keep left and right, and read SPACE to B.
@ $D189 label=ReadKeyboard_Movement
  $D189,$02,b$01 Keep bits 0 and 1.
  $D18B,$01 Put them in #REGc.
  $D18C,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | SYMBOL SHIFT | M | N | B }
. TABLE#
  $D191,$06 Set bit 0 if M is pressed.
N $D197 Set bit 1 if N is pressed.
@ $D197 label=ReadKeyboard_TestN
  $D197,$06 Set bit 1 if N is pressed.
N $D19D Set bit 0 if B is pressed.
@ $D19D label=ReadKeyboard_TestB
  $D19D,$06 Set bit 0 if B is pressed.
N $D1A3 Set bit 2 if any key from A to G or H to ENTER is pressed.
@ $D1A3 label=ReadKeyboard_MiddleRows
  $D1A3,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$BD | A or H | S or J | D or K | F or L | G or ENTER }
. TABLE#
  $D1A8,$04 Set bit 2 if any key is pressed.
N $D1AC Set bit 3 if any key from Q to T or Y to P is pressed.
@ $D1AC label=ReadKeyboard_TopRows
  $D1AC,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DB | Q or Y | W or U | E or I | R or O | T or P }
. TABLE#
  $D1B1,$04 Set bit 3 if any key is pressed.
N $D1B5 Set bit 4 if any key from 1 to 5 or 6 to 0 is pressed.
@ $D1B5 label=ReadKeyboard_NumberRows
  $D1B5,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$E7 | 1 or 6 | 2 or 7 | 3 or 8 | 4 or 9 | 5 or 0 }
. TABLE#
  $D1BA,$04 Set bit 4 if any key is pressed.

c $D1BE Read View Key
@ $D1BE label=ReadControls_Rotate
D $D1BE Sets bit 5 of the controls if Z or SYMBOL SHIFT is pressed,
. then makes a copy in #REGb in which left and right are never both
. set, and bits 2 and 3 are never both set.
R $D1BE C The controls
R $D1BE O:B The controls, with bits 0 and 1, and 2 and 3, made exclusive
R $D1BE O:C The controls
N $D1BE Read the key which rotates the view.
  $D1BE,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | CAPS SHIFT or SPACE | Z or SYMBOL SHIFT | X or M | C or N | V or B }
. TABLE#
  $D1C3,$04 Jump to #R$D1C9 if neither Z nor SYMBOL SHIFT is pressed.
  $D1C7,$02 Set bit 5.
N $D1C9 Make #REGb from the controls so that left and right are never
. both set, and bits 2 and 3 are never both set.
@ $D1C9 label=ReadControls_Resolve
  $D1C9,$01 Stash #REGde on the stack.
  $D1CA,$04 Fetch #R$A247.
  $D1CE,$01 Fetch the controls.
  $D1CF,$02,b$01 Keep left and right.
  $D1D1,$04 Jump to #R$D1F5 if both are set.
  $D1D5,$01 Keep them in #REGb.
  $D1D6,$01 Fetch the last controls.
  $D1D7,$02,b$01 Clear their bits for left and right.
  $D1D9,$01 Put in the new ones.
  $D1DA,$01 Keep them in #REGe.
N $D1DB Do the same for bits 2 and 3.
@ $D1DB label=ReadControls_Vertical
  $D1DB,$01 Fetch the controls.
  $D1DC,$02,b$01 Keep bits 2 and 3.
  $D1DE,$04 Jump to #R$D1FD if both are set.
  $D1E2,$01 Keep them in #REGd.
  $D1E3,$01 Add them to #REGb.
  $D1E4,$01 Keep them in #REGb.
  $D1E5,$01 Fetch the last controls.
  $D1E6,$02,b$01 Clear their bits for the two controls.
  $D1E8,$01 Put in the new ones.
  $D1E9,$01 Keep them in #REGe.
N $D1EA Store #R$A247 and add bit 4 to #REGb.
@ $D1EA label=ReadControls_Store
  $D1EA,$01 Fetch the last controls.
  $D1EB,$03 Set #R$A247.
  $D1EE,$01 Restore #REGde from the stack.
  $D1EF,$01 Fetch the controls.
  $D1F0,$02,b$01 Keep bit 4, for down.
  $D1F2,$01 Add it to #REGb.
  $D1F3,$01 Keep it in #REGb.
  $D1F4,$01 Return.
N $D1F5 Both left and right are set, so use the one which was not set
. last time.
@ $D1F5 label=ReadControls_BothHorizontal
  $D1F5,$01 Fetch the last controls.
  $D1F6,$02,b$01 Keep left and right.
  $D1F8,$02,b$01 Turn the bits round.
  $D1FA,$01 Keep them in #REGb.
  $D1FB,$02 Jump to #R$D1DB.
N $D1FD Bits 2 and 3 are both set, so use the one which was not set
. last time.
@ $D1FD label=ReadControls_BothVertical
  $D1FD,$01 Fetch the last controls.
  $D1FE,$02,b$01 Keep bits 2 and 3.
  $D200,$02,b$01 Turn the bits round.
  $D202,$01 Add the horizontal controls.
  $D203,$01 Keep them in #REGb.
  $D204,$02 Jump to #R$D1EA.

c $D206 Pause Game
@ $D206 label=PauseGame
D $D206 Pauses the game if CAPS SHIFT or SPACE is pressed on its own.
. #R$AF49 is played at the start and at the end. The game carries on
. when CAPS SHIFT or SPACE is pressed again.
E $D206 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE22 }
. { #KNIGHTLORE$D50E }
. { #NIGHTSHADE$E32C }
. LIST#
N $D206 Return unless CAPS SHIFT or SPACE is the only key being pressed.
  $D206,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | CAPS SHIFT or SPACE | Z or SYMBOL SHIFT | X or M | C or N | V or B }
. TABLE#
  $D20B,$03 Return if neither CAPS SHIFT nor SPACE is pressed.
  $D20E,$02,b$01 Keep the bits for the other keys.
  $D210,$01 Return if any of them is pressed.
N $D211 Play the pause sound.
  $D211,$03 Call #R$AF49.
N $D214 Wait for the key to be released.
@ $D214 label=PauseGame_Release
  $D214,$09 Read the keys, and jump to #R$D214 while CAPS SHIFT or
. SPACE is pressed.
N $D21D Wait for a key to be pressed.
@ $D21D label=PauseGame_Press
  $D21D,$09 Read the keys, and jump to #R$D21D until CAPS SHIFT or
. SPACE is pressed.
N $D226 Play the pause sound.
  $D226,$03 Call #R$AF49.
N $D229 Wait for the key to be released.
@ $D229 label=PauseGame_ReleaseAgain
  $D229,$09 Read the keys, and jump to #R$D229 while CAPS SHIFT or
. SPACE is pressed.
  $D232,$01 Return.

c $D233 Calculate Buffer Address
@ $D233 label=CalculateBufferAddress
D $D233 Finds the address in #R$D6EB of a pixel. The first row of the
. buffer is at a vertical position of #N$48, and the first column is at
. a horizontal position of #N$10.
E $D233 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E53A }
. LIST#
R $D233 H The vertical position, from #N$48
R $D233 L The horizontal position, from #N$10
R $D233 O:HL The address in the buffer
N $D233 Stash #REGbc.
  $D233,$01 Stash #REGbc on the stack.
N $D234 Work out the column from the horizontal position.
  $D234,$06 Divide the horizontal position by eight.
  $D23A,$04 Keep the column, and start with the vertical position.
N $D23E Work out #N$18 times the vertical position.
  $D23E,$03 Multiply the vertical position by eight.
  $D241,$02 Keep it.
  $D243,$02 Multiply it by two and add the eight times.
N $D245 Add the column and the start of the buffer.
  $D245,$03 Move the column into #REGbc.
  $D248,$01 Add it.
  $D249,$04 Add the address of #R$D6EB, less the first row and column.
  $D24D,$01 Restore #REGbc from the stack.
  $D24E,$01 Return.

c $D24F Calculate Screen Address
@ $D24F label=CalculateScreenAddress
D $D24F Finds the address on the screen of a pixel. The vertical
. position is measured from the bottom of the screen.
E $D24F View the equivalent code in;
. #LIST
. { #ALIENEIGHT$D135 }
. { #KNIGHTLORE$D826 }
. { #NIGHTSHADE$E556 }
. { #PENTAGRAM$B394 }
. LIST#
R $D24F H The vertical position, from the bottom
R $D24F L The horizontal position
R $D24F O:HL The address on the screen
N $D24F Stash #REGde, and copy the position to it.
  $D24F,$01 Stash #REGde on the stack.
  $D250,$01 Copy the position to #REGde.
N $D251 Work out the column from the horizontal position.
  $D251,$04 Divide the horizontal position by eight.
  $D255,$02,b$01 Keep the column.
  $D257,$01 Store it.
N $D258 Work out the character row within a third of the screen.
  $D258,$04 Invert the vertical position and multiply it by four.
  $D25C,$02,b$01 Keep the character row within the third.
  $D25E,$02 Make the low byte of the address.
N $D260 Work out the third of the screen.
  $D260,$05 Invert the vertical position and divide it by eight.
  $D265,$02,b$01 Keep the third.
  $D267,$01 Start the high byte.
N $D268 Work out the line within the character row, and make the high
. byte of the address.
  $D268,$02 Invert the vertical position.
  $D26A,$02,b$01 Keep the line within the character row.
  $D26C,$04 Combine it with the third, add #N$38, and set the high byte.
  $D270,$01 Restore #REGde from the stack.
  $D271,$01 Return.

c $D272 Add Town Offset To HL
@ $D272 label=AddTownOffsetToHL
D $D272 Adds #R$A267 to a screen address, so a layout drawn at the
. left of the screen sits beside the town panel.
E $D272 Continue on to #R$D275.
R $D272 HL The screen address
R $D272 O:HL The new address
  $D272,$03 Fetch #R$A267.

c $D275 Add A To HL
@ $D275 label=AddAToHL
D $D275 Adds an unsigned number to #REGhl.
E $D275 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE06 }
. { #ATICATAC$926C }
. { #CYBERUN$9BCF }
. { #KNIGHTLORE$D4F2 }
. { #NIGHTSHADE$E596 }
. { #PENTAGRAM$B519 }
. { #SABREWULF$9B37 }
. LIST#
R $D275 A The number
R $D275 HL The address
R $D275 O:HL The new address
  $D275,$02 Add the number to the low byte.
  $D277,$04 Add the carry to the high byte.
  $D27B,$01 Return.

c $D27C Draw Lives
@ $D27C label=DrawLives
D $D27C Draws #N$04 sheriff hats from #R$D2AA in the lower left of the
. town screen. The hats for the lives in #R$A263 are in #COLOUR$46, and
. the hats for the lives which have been lost are in black. This does
. nothing when #R$A267 is zero.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D319)
. #SIM(start=$D319,stop=$D31C)
. #SCR$03,$00,$12,$08,$03(lives) } UDGTABLE# #POPS
N $D27C Return if this is not the town.
  $D27C,$04 Fetch #R$A267.
  $D280,$01 Return if this is not the town.
N $D281 Draw the hats for the lives which are left.
  $D281,$03 Set the attribute to #COLOUR$46.
  $D284,$03 Point #REGhl at #N$5040 (in the screen buffer).
  $D287,$03 Fetch #R$A263.
N $D28A Draw that many hats.
  $D28A,$03 Call #R$D296.
N $D28D Draw the hats for the lives which have been lost.
  $D28D,$02 Set the attribute to #COLOUR$00.
  $D28F,$03 Fetch #R$A263.
  $D292,$04 Find #N$04 minus the number of lives.
N $D296 Draw hats from #R$D2AA, each of #N$02 tiles wide and #N$03
. high, from left to right.
@ $D296 label=DrawLifeIcons
R $D296 A The number of hats
R $D296 HL The screen address of the first hat
R $D296 A' The attribute
R $D296 O:HL The screen address after the last hat
  $D296,$02 Return if there are no hats.
N $D298 Draw a hat.
  $D298,$01 Stash the number on the stack.
  $D299,$06 Point #REGde at #R$D2AA, and set the size to #N$02 by #N$03.
  $D29F,$01 Stash the screen address on the stack.
N $D2A0 Draw the hat.
  $D2A0,$03 Call #R$D595.
  $D2A3,$01 Restore the screen address from the stack.
N $D2A4 Move on to the next hat.
  $D2A4,$02 Move on two columns.
  $D2A6,$01 Restore the number from the stack.
  $D2A7,$01 Count it down.
  $D2A8,$02 Jump to #R$D296.

b $D2AA Life Icon Tiles
@ $D2AA label=LifeIconTiles
D $D2AA The numbers of the tiles of a sheriff hat, drawn by #R$D296 in
. three rows of two from #R$8CF0. Bits 6 and 7 of a number say how the
. tile is reflected.
B $D2AA,$01 #UDGTABLE { #N(#PEEK(#PC)) |
. #UDG($8CF0+#PEEK(#PC)*$08,attr=$46) } UDGTABLE#
L $D2AA,$01,$06

c $D2B0 Draw Digits
@ $D2B0 label=DrawDigits
D $D2B0 Draws a number which is held as pairs of packed decimal digits,
. as double height characters from #R$8EB0.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D3A4)
. #SIM(start=$D3A4,stop=$A3BA)
. #SCR$03,$02,$16,$06,$02(digits) } UDGTABLE# #POPS
R $D2B0 B The number of bytes of the number
R $D2B0 DE The address of the number
R $D2B0 HL The screen address
R $D2B0 A' The attribute
N $D2B0 Prepare the upper digit.
  $D2B0,$01 Fetch the byte.
  $D2B1,$04 Move the upper digit to the lower four bits.
  $D2B5,$02,b$01 Keep only bits 0-3.
  $D2B7,$01 Stash the counter on the stack.
  $D2B8,$03 Point #REGbc at #R$8EB0.
N $D2BB Draw the upper digit.
  $D2BB,$03 Call #R$D2C9.
N $D2BE Prepare the lower digit.
  $D2BE,$02 Fetch the byte again, and move to the next one.
  $D2C0,$02,b$01 Keep only bits 0-3.
N $D2C2 Draw the lower digit.
  $D2C2,$03 Call #R$D2C9.
  $D2C5,$01 Restore the counter from the stack.
  $D2C6,$02 Jump to #R$D2B0 if there are any left.
  $D2C8,$01 Return.

c $D2C9 Draw Character
@ $D2C9 label=DrawCharacter
D $D2C9 Draws a character which is #N$08 pixels wide and #N$10 high,
. from a font of #N$08 bytes for each character. The first four bytes
. are drawn as the upper half and the last four as the lower half, with
. every byte drawn on two lines.
R $D2C9 A The number of the character
R $D2C9 BC The address of the font
R $D2C9 HL The screen address
R $D2C9 A' The attribute
R $D2C9 O:HL The screen address of the next character on the right
N $D2C9 Find the character in the font.
  $D2C9,$03 Stash the registers on the stack.
  $D2CC,$01 Keep the screen address in #REGde.
  $D2CD,$03 Move the number of the character to #REGhl.
  $D2D0,$04 Multiply it by #N$08, and add the address of the font.
  $D2D4,$01 Put the address of the character in #REGde and the screen
. address in #REGhl.
N $D2D5 Draw the character.
  $D2D5,$03 Call #R$D2DD.
  $D2D8,$01 Restore the screen address from the stack.
  $D2D9,$01 Move on to the next column.
  $D2DA,$02 Restore the registers from the stack.
  $D2DC,$01 Return.

c $D2DD Draw Double Height Character
@ $D2DD label=DrawDoubleHeightCharacter
D $D2DD Draws the two halves of a character, one on top of the other,
. each with the attribute.
R $D2DD DE The address of the character
R $D2DD HL The screen address
R $D2DD A' The attribute
N $D2DD Draw the upper half.
  $D2DD,$01 Stash the screen address on the stack.
  $D2DE,$03 Call #R$D2F0.
  $D2E1,$01 Restore the screen address from the stack.
N $D2E2 Set the attribute of the upper half.
  $D2E2,$03 Call #R$D63C.
N $D2E5 Move down a row.
  $D2E5,$03 Call #R$D64F.
N $D2E8 Draw the lower half.
  $D2E8,$01 Stash the screen address on the stack.
  $D2E9,$03 Call #R$D2F0.
  $D2EC,$01 Restore the screen address from the stack.
N $D2ED Set the attribute of the lower half.
  $D2ED,$03 Jump to #R$D63C.

c $D2F0 Draw Double Lines
@ $D2F0 label=DrawDoubleLines
D $D2F0 Draws #N$04 bytes as #N$08 lines, with each byte drawn twice.
R $D2F0 DE The address of the bytes
R $D2F0 HL The screen address
R $D2F0 O:DE The address after the bytes
N $D2F0 Draw four bytes, each on two lines.
  $D2F0,$02 Set a count of #N$04 bytes.
@ $D2F2 label=DrawDoubleLines_Next
  $D2F2,$06 Draw the next byte on two lines.
  $D2F8,$02 Jump to #R$D2F2 if there are any left.
  $D2FA,$01 Return.

c $D2FB Draw Game Screen
@ $D2FB label=DrawGameScreen
D $D2FB Draws the parts of the screen which do not change during a
. stage: the border of the playfield, the revolver, the frame of the
. telegram, the panel for the town and the lives and the bounty. The
. attributes are first set to the value in #REGe and the screen is
. cleared.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$A3BA)
. #SCR$02(game-screen) } UDGTABLE#
. #HTML(<div hidden>)
. #SCR$02,$08,$00,$18,$10(screen-frame)
. #HTML(</div>)
. #POPS
R $D2FB E The attribute for the whole screen
N $D2FB Set the attributes and clear the screen.
  $D2FB,$03 Call #R$D6D3.
  $D2FE,$03 Call #R$D6DB.
N $D301 Print the telegram.
  $D301,$03 Call #R$A6FC.
N $D304 Use the tiles of the panel and the border.
  $D304,$06 Set #R$A20F to #R$8CF0.
N $D30A Draw the border of the playfield.
  $D30A,$03 Call #R$D5C9.
N $D30D Draw the revolver.
  $D30D,$03 Call #R$D565.
N $D310 Draw the frame of the telegram.
  $D310,$03 Call #R$D463.
N $D313 Draw the panel of the town, if this is the town.
  $D313,$03 Call #R$D3A7.
N $D316 Draw the pictures at the sides, if this is not the town.
  $D316,$03 Call #R$D327.
N $D319 Draw the lives.
  $D319,$03 Call #R$D27C.
N $D31C Draw the bounty.
  $D31C,$03 Jump to #R$D37E.

g $D31F Bounty Text
@ $D31F label=BountyText
D $D31F The text which is drawn next to the bounty in the town, which starts
. with its attribute and ends with zero.
B $D31F,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
T $D320,$06 "BOUNTY".
B $D326,$01,$01 The end of the text.

c $D327 Draw Side Pictures
@ $D327 label=DrawSidePictures
D $D327 Draws a block of tiles of #N$04 by #N$0A, from #R$5E04, on each
. side of the lower part of the screen of any stage which is not the
. town. The block at the left is drawn from right to left so that it is
. a reflection of the block at the right.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #POKES$A265,$02;$A266,$45
. #SIM(start=$A3B3,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D316)
. #SIM(start=$D316,stop=$D319)
. #SCR$03,$00,$0E,$20,$0A(side-pictures) } UDGTABLE# #POPS
N $D327 Return if this is the town.
  $D327,$04 Fetch #R$A267.
  $D32B,$01 Return if this is the town.
N $D32C Draw the right hand block.
  $D32C,$03 Set the attribute to #COLOUR$43.
  $D32F,$03 Point #REGhl at #N$48DC (in the screen buffer).
  $D332,$03 Point #REGde at #R$5E04.
  $D335,$03 Set the size of the block to #N$04 by #N$0A.
  $D338,$03 Call #R$D595.
N $D33B Draw the left hand block.
  $D33B,$03 Point #REGhl at #N$48C3 (in the screen buffer).
  $D33E,$03 Point #REGde at #R$5E04.
  $D341,$03 Set the size of the block to #N$04 by #N$0A.
  $D344,$03 Jump to #R$D5AE.

c $D347 Take From Bounty
@ $D347 label=TakeFromBounty
D $D347 Takes a price from the bounty, and sets the bounty to zero if it is more
. than the bounty.
R $D347 BC The price, as four binary coded decimal digits
  $D347,$03 Take the price from the bounty.
  $D34A,$01 Return if there was enough.
  $D34B,$03 Point #REGhl at #R$A257.
  $D34E,$03 Set the number of bytes to three.
  $D351,$03 Jump to #R$D6E1.

c $D354 Add To Bounty
@ $D354 label=AddToBounty
D $D354 Adds an amount to #R$A257, as #R$D36B subtracts from it. It also
. writes #N$00 to #R$A269, so the revolver may be loaded again.
R $D354 BC The amount, as four packed decimal digits
N $D354 Allow the revolver to be loaded.
  $D354,$04 Write #N$00 to #R$A269.
N $D358 Add the lowest two digits.
  $D358,$03 Point #REGhl at #R$A259.
  $D35B,$02 Add the lower two digits.
  $D35D,$01 Make it decimal.
  $D35E,$01 Store the lowest two digits of #R$A257.
  $D35F,$01 Move on to the next byte.
N $D360 Add the middle two digits.
  $D360,$02 Add the next two digits and the carry.
  $D362,$01 Make it decimal.
  $D363,$01 Store the middle two digits of #R$A257.
  $D364,$01 Move on to the next byte.
N $D365 Add the highest two digits.
  $D365,$03 Add the carry.
  $D368,$01 Make it decimal.
  $D369,$01 Store the highest two digits of #R$A257.
  $D36A,$01 Return.

c $D36B Subtract From Bounty
@ $D36B label=SubtractFromBounty
D $D36B Subtracts an amount from #R$A257, as #R$D354 adds to it.
R $D36B BC The amount, as four packed decimal digits
R $D36B O:F The carry flag is set if the amount is more than the bounty
N $D36B Subtract the lowest two digits.
  $D36B,$03 Point #REGhl at #R$A259.
  $D36E,$02 Subtract the lower two digits.
  $D370,$01 Make it decimal.
  $D371,$01 Store the lowest two digits of #R$A257.
  $D372,$01 Move on to the next byte.
N $D373 Subtract the middle two digits.
  $D373,$02 Subtract the next two digits and the carry.
  $D375,$01 Make it decimal.
  $D376,$01 Store the middle two digits of #R$A257.
  $D377,$01 Move on to the next byte.
N $D378 Subtract the highest two digits.
  $D378,$03 Subtract the carry.
  $D37B,$01 Make it decimal.
  $D37C,$01 Store the highest two digits of #R$A257.
  $D37D,$01 Return.

c $D37E Draw Bounty
@ $D37E label=DrawBounty
D $D37E Draws #R$A257. In the town it also prints #R$D31F. It draws the
. symbol which goes next to the number.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D31C)
. #SIM(start=$D31C,stop=$A3BA)
. #SCR$03,$00,$15,$08,$03(bounty) } UDGTABLE# #POPS
E $D37E Continue on to #R$D390.
N $D37E Print the text in the town.
  $D37E,$04 Fetch #R$A267.
  $D382,$02 Jump to #R$D38D if this is not the town.
  $D384,$03 Point #REGhl at #N$50A0 (in the screen buffer).
  $D387,$03 Point #REGde at #R$D31F.
N $D38A Print the text.
  $D38A,$03 Call #R$D4D7.
N $D38D Draw the symbol.
@ $D38D label=DrawBounty_SkipText
  $D38D,$03 Call #R$D54A.

c $D390 Draw Bounty Digits
@ $D390 label=DrawBountyDigits
D $D390 Draws the six digits of #R$A257. The number is at a different
. place on the screen in the town.
N $D390 Set the attribute and the number.
  $D390,$03 Set the attribute to #COLOUR$47.
  $D393,$03 Point #REGde at #R$A257.
N $D396 Choose the screen address.
  $D396,$04 Fetch #R$A267.
  $D39A,$03 Point #REGhl at #N$50C2 (in the screen buffer).
  $D39D,$02 Jump to #R$D3A2 if this is the town.
  $D39F,$03 Point #REGhl at #N$5072 (in the screen buffer).
N $D3A2 Draw the digits.
@ $D3A2 label=DrawBountyDigits_Draw
  $D3A2,$02 Set a count of #N$03 bytes.
  $D3A4,$03 Jump to #R$D2B0.

c $D3A7 Draw Town Panel
@ $D3A7 label=DrawTownPanel
D $D3A7 Draws the panel at the left of the screen of the town, which is
. #N$08 tiles wide and #N$12 high and has the wanted poster in it. The
. panel is drawn from pairs of bytes, which are the attribute and the
. tile, at #R$5E91. Then it prints the name of the outlaw, draws the
. picture of his face from four images, one above another, and draws the
. reward. This does nothing when #R$A267 is zero.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D313)
. #SIM(start=$D313,stop=$D316)
. #SCR$03,$00,$00,$08,$12(town-panel) } UDGTABLE# #POPS
N $D3A7 Return if this is not the town.
  $D3A7,$04 Fetch #R$A267, and test it.
  $D3AB,$01 Return if this is not the town.
N $D3AC Draw the panel tiles.
  $D3AC,$03 Point #REGhl at #N$4000 (in the screen buffer).
  $D3AF,$03 Point #REGde at #R$5E91.
  $D3B2,$02 Set a count of #N$12 rows.
N $D3B4 Draw a row.
@ $D3B4 label=DrawTownPanel_Row
  $D3B4,$02 Set a count of #N$08 tiles.
  $D3B6,$01 Stash the screen address of the row on the stack.
N $D3B7 Draw a tile.
@ $D3B7 label=DrawTownPanel_Tile
  $D3B7,$05 Fetch the attribute and then the tile.
  $D3BC,$01 Stash the counters on the stack.
  $D3BD,$03 Point #REGbc at #R$8B48.
  $D3C0,$03 Call #R$D639.
  $D3C3,$01 Restore the counters from the stack.
  $D3C4,$01 Move on to the next column.
  $D3C5,$02 Jump to #R$D3B7 if there are any left.
  $D3C7,$01 Restore the screen address of the row from the stack.
N $D3C8 Move down a row.
  $D3C8,$03 Call #R$D64F.
  $D3CB,$03 Jump to #R$D3B4 if there are rows left.
N $D3CE Print the name of the outlaw.
  $D3CE,$03 Call #R$B1F4.
N $D3D1 Find the face images.
  $D3D1,$03 Fetch #R$A260.
  $D3D4,$03 Point #REGhl at #R$B494.
  $D3D7,$03 Call #R$D275.
  $D3DA,$03 Fetch the number of the outlaw.
  $D3DD,$02 Keep it in #REGbc.
  $D3DF,$02 Multiply it by four.
  $D3E1,$01 Add it, which makes it five times the number.
  $D3E2,$04 Add the address of #R$B5B0.
  $D3E6,$01 Skip the first byte of the record.
  $D3E7,$01 Keep the address of the images in #REGde.
N $D3E8 Draw the face.
  $D3E8,$03 Point #REGhl at #N$4F42 (in the screen buffer).
  $D3EB,$02 Set a count of #N$04 images.
@ $D3ED label=DrawTownPanel_Face
  $D3ED,$02 Fetch the number of the next image.
  $D3EF,$03 Stash the registers on the stack.
N $D3F2 Draw the image.
  $D3F2,$03 Call #R$D400.
  $D3F5,$01 Restore the screen address from the stack.
N $D3F6 Move up a row.
  $D3F6,$03 Call #R$D659.
  $D3F9,$02 Restore the registers from the stack.
  $D3FB,$02 Jump to #R$D3ED if there are any left.
  $D3FD,$03 Jump to #R$D423.

c $D400 Draw Poster Image
@ $D400 label=DrawPosterImage
D $D400 Draws an image of thirty-two by eight pixels, as four bytes for
. each line, with the bottom line first. The addresses of the images are
. in #R$6AC6.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D3F2)
. #SIM(start=$D3F2,stop=$D3F5)
. #SCR$03,$02,$0A,$04,$01(poster-image) } UDGTABLE# #POPS
R $D400 A The number of the image
R $D400 HL The screen address of the bottom left of the image
N $D400 Find the image.
  $D400,$01 Keep the screen address in #REGde.
  $D401,$03 Point #REGbc at #R$6AC6.
N $D404 Find the address of the image.
  $D404,$03 Call #R$C75C.
N $D407 Read the image with the stack.
  $D407,$04 Set #R$A21D.
  $D40B,$01 Point the stack pointer at the image.
  $D40C,$01 Put the screen address in #REGhl.
  $D40D,$02 Set a count of #N$08 lines.
N $D40F Draw a line.
@ $D40F label=DrawPosterImage_Line
  $D40F,$05 Draw the first two bytes of the line.
  $D414,$04 Draw the next two bytes of the line.
  $D418,$04 Move up one line, and back to the first byte.
  $D41C,$02 Jump to #R$D40F if there are any left.
  $D41E,$04 Restore the stack pointer.
  $D422,$01 Return.

c $D423 Draw Reward
@ $D423 label=DrawReward
D $D423 Draws the reward for the outlaw on the poster, from #R$B56E for
. #R$A260. It is three bytes of packed decimal digits, without the
. zeroes at the start. The digits are drawn from one byte before #R$8EB0,
. so they are drawn one line lower.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D3FD)
. #SIM(start=$D3FD,stop=$D316)
. #SCR$03,$02,$0C,$03,$01(reward) } UDGTABLE# #POPS
N $D423 Find the reward for the level.
  $D423,$04 Fetch #R$A260, and keep it in #REGc.
  $D427,$02 Multiply it by #N$03.
  $D429,$03 Point #REGhl at #R$B56E.
  $D42C,$03 Call #R$D275.
  $D42F,$01 Put the address in #REGde.
N $D430 Set the screen address.
  $D430,$03 Point #REGhl at #N$4882 (in the screen buffer).
  $D433,$02 Set a count of #N$03 bytes.
N $D435 Skip the leading zeroes.
@ $D435 label=DrawReward_Skip
  $D435,$01 Fetch the byte.
  $D436,$02,b$01 Keep the upper digit.
  $D438,$02 Jump to #R$D443 if it is not zero.
  $D43A,$01 Fetch the byte.
  $D43B,$02,b$01 Keep the lower digit.
  $D43D,$02 Jump to #R$D453 if it is not zero.
  $D43F,$01 Move on to the next byte.
  $D440,$02 Jump to #R$D435 if there are any left.
  $D442,$01 Return.
N $D443 Draw the upper digit.
@ $D443 label=DrawReward_Upper
  $D443,$01 Fetch the byte.
  $D444,$04 Move the upper digit into the lower four bits.
  $D448,$02,b$01 Keep only bits 0-3.
  $D44A,$01 Stash the counter on the stack.
  $D44B,$03 Point #REGbc one byte before #R$8EB0.
N $D44E Draw the digit.
  $D44E,$03 Call #R$D663.
  $D451,$01 Move on to the next column.
  $D452,$01 Restore the counter from the stack.
N $D453 Draw the lower digit.
@ $D453 label=DrawReward_Lower
  $D453,$01 Stash the counter on the stack.
  $D454,$03 Point #REGbc one byte before #R$8EB0.
  $D457,$02 Fetch the byte and move to the next one.
  $D459,$02,b$01 Keep only bits 0-3.
N $D45B Draw the digit.
  $D45B,$03 Call #R$D663.
  $D45E,$01 Move on to the next column.
  $D45F,$01 Restore the counter from the stack.
  $D460,$02 Jump to #R$D443 if there are any left.
  $D462,$01 Return.

c $D463 Draw Telegram Frame
@ $D463 label=DrawTelegramFrame
D $D463 Draws the frame of the telegram, which has the word at #R$D4CD in
. its lower edge. The corners and the edges are the same tiles at the top
. and the left, drawn reflected for the bottom and the right.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D310)
. #SIM(start=$D310,stop=$D313)
. #SCR$03,$10,$10,$10,$08(telegram-frame) } UDGTABLE# #POPS
N $D463 Set the attribute and the tile set.
  $D463,$03 Set the attribute to #COLOUR$4F.
  $D466,$04 Fetch #R$A20F.
N $D46A Draw the top left corner.
  $D46A,$03 Point #REGhl at #N$500C (in the screen buffer).
N $D46D Move it to the right in the town.
  $D46D,$03 Call #R$D272.
  $D470,$02 Set the tile to the top left corner.
  $D472,$03 Call #R$D639.
N $D475 Draw the top edge.
  $D475,$01 Move on to the next column.
  $D476,$04 Set a count of #N$0E tiles, and fetch the top edge.
  $D47A,$03 Call #R$D62F.
N $D47D Draw the top right corner.
  $D47D,$02 Set the tile to the top right corner.
  $D47F,$03 Call #R$D639.
N $D482 Draw the left edge.
  $D482,$03 Point #REGhl at #N$502C (in the screen buffer).
N $D485 Move it to the right in the town.
  $D485,$03 Call #R$D272.
  $D488,$04 Set a count of #N$06 tiles, and fetch the left edge.
  $D48C,$03 Call #R$D623.
N $D48F Draw the right edge.
  $D48F,$03 Point #REGhl at #N$503B (in the screen buffer).
N $D492 Move it to the right in the town.
  $D492,$03 Call #R$D272.
  $D495,$04 Set a count of #N$06 tiles, and fetch the right edge.
  $D499,$03 Call #R$D623.
N $D49C Draw the bottom left corner.
  $D49C,$03 Point #REGhl at #N$50EC (in the screen buffer).
N $D49F Move it to the right in the town.
  $D49F,$03 Call #R$D272.
  $D4A2,$02 Set the tile to the bottom left corner.
  $D4A4,$03 Call #R$D639.
N $D4A7 Draw the first part of the bottom edge.
  $D4A7,$01 Move on to the next column.
  $D4A8,$04 Set a count of #N$03 tiles, and fetch the bottom edge.
  $D4AC,$03 Call #R$D62F.
N $D4AF Draw the second part of the bottom edge.
  $D4AF,$03 Point #REGhl at #N$50F8 (in the screen buffer).
N $D4B2 Move it to the right in the town.
  $D4B2,$03 Call #R$D272.
  $D4B5,$04 Set a count of #N$03 tiles, and fetch the bottom edge.
  $D4B9,$03 Call #R$D62F.
N $D4BC Draw the bottom right corner.
  $D4BC,$02 Set the tile to the bottom right corner.
  $D4BE,$03 Call #R$D639.
N $D4C1 Print the word.
  $D4C1,$03 Point #REGhl at #N$50F0 (in the screen buffer).
N $D4C4 Move it to the right in the town.
  $D4C4,$03 Call #R$D272.
  $D4C7,$03 Point #REGde at #R$D4CD.
  $D4CA,$03 Jump to #R$D4D7.

g $D4CD Telegram Text
@ $D4CD label=TelegramText
D $D4CD The word which is printed in the frame of the telegram, which starts
. with its attribute and ends with zero.
B $D4CD,$01,$01 Attribute: #COLOUR(#PEEK(#PC)).
T $D4CE,$08 "TELEGRAM".
B $D4D6,$01,$01 The end of the text.

c $D4D7 Print Text
@ $D4D7 label=PrintText
D $D4D7 Prints a text from #R$8EA8, one tile for each character. The text
. starts with an attribute and ends with #N$00.
. #PUSHS #UDGTABLE { #SIM(start=$D6DB,stop=$D6EA,clear=1,sp=$5E00)
. #SIM(start=$D6D3,stop=$D6EA,de=$47)
. #SIM(start=$ABE7,stop=$ABF0)
. #SCR$03,$0A,$17,$0D,$01(print-text) } UDGTABLE# #POPS
R $D4D7 DE The address of the attribute and the text
R $D4D7 HL The screen address
N $D4D7 Fetch the attribute.
  $D4D7,$03 Fetch the attribute, and keep it in the alternate accumulator.
N $D4DA Print the next character.
@ $D4DA label=PrintText_Next
  $D4DA,$03 Return if it is the terminator.
  $D4DD,$01 Move on to the next character.
  $D4DE,$03 Call #R$D4EA.
  $D4E1,$03 Point #REGbc at #R$8EA8.
  $D4E4,$03 Call #R$D639.
  $D4E7,$01 Move on to the next column.
  $D4E8,$02 Jump to #R$D4DA.

c $D4EA Convert Character
@ $D4EA label=ConvertCharacter
D $D4EA Converts a character into the number of its tile in #R$8EA8. The
. space is #N($00), the digits are from #N$01 to #N$0A and the letters
. begin at #N$0B. A character which is not one of these gives a number
. which has other bits set.
R $D4EA A The character
R $D4EA O:A The number of the tile
N $D4EA Make a space into zero.
  $D4EA,$03 Take away #N($20), and keep it in #REGc.
  $D4ED,$02,b$01 Keep only bits 0-5.
  $D4EF,$01 Return if it is a space.
N $D4F0 Make the digits begin at one.
  $D4F0,$04 Take away #N($0F), and keep it in #REGc.
  $D4F4,$02,b$01 Keep only bits 0-5.
  $D4F6,$03 Return if it is a digit.
N $D4F9 Make the letters begin at eleven.
  $D4F9,$03 Take away #N$07.
  $D4FC,$01 Return.

c $D4FD Build Shift Tables
@ $D4FD label=BuildShiftTables
D $D4FD Builds #R$FA00, #R$F200 and #R$F900, which the routines for
. drawing sprites use. Each table is a page, which has an entry for each
. value of a byte at the low byte of the address. For a byte which is
. moved to the right along a row by six pixels, page #N$FE has the part
. which stays in the byte and page #N$FF has the part which moves into
. the next byte. Pages #N$FC and #N$FD are the same for four pixels, and
. pages #N$FA and #N$FB for two. Pages #N$F6 and #N$F7, #N$F4 and #N$F5,
. and #N$F2 and #N$F3 are the same for the byte with its bits turned
. round, which is used for sprites which are reflected. #R$F900 has each
. byte with its bits turned round.
E $D4FD View the equivalent code in;
. #LIST
. { #NIGHTSHADE$E0FB }
. LIST#
N $D4FD Build #R$FA00.
  $D4FD,$02 Start with the byte at #N$00.
@ $D4FF label=BuildShiftTables_Normal
  $D4FF,$03 Make the word the byte.
  $D502,$02 Start at page #N$FF.
  $D504,$02 Set a count of #N$03 pairs.
N $D506 Shift the word left by two bits and store it.
@ $D506 label=BuildShiftTables_NormalLoop
  $D506,$08 Shift the word left by two bits.
  $D50E,$04 Store the pair in the next two pages.
  $D512,$02 Jump to #R$D506 if there are any left.
  $D514,$01 Move on to the next byte.
  $D515,$02 Jump to #R$D4FF if there are any left.
N $D517 Build #R$F200.
  $D517,$02 Start with the byte at #N$00.
@ $D519 label=BuildShiftTables_Reversed
  $D519,$02 Clear the high byte of the word.
  $D51B,$03 Set a count of #N$08 bits, and copy the byte into #REGa.
N $D51E Turn the bits of the byte round.
@ $D51E label=BuildShiftTables_Reverse
  $D51E,$03 Move the next bit into #REGc from the other end.
  $D521,$02 Jump to #R$D51E if there are any left.
  $D523,$01 Make the low byte the reversed byte.
  $D524,$02 Start at page #N$F7.
  $D526,$02 Set a count of #N$03 pairs.
N $D528 Shift the word left by two bits and store it.
@ $D528 label=BuildShiftTables_ReversedLoop
  $D528,$08 Shift the word left by two bits.
  $D530,$04 Store the pair in the next two pages.
  $D534,$02 Jump to #R$D528 if there are any left.
  $D536,$01 Move on to the next byte.
  $D537,$02 Jump to #R$D519 if there are any left.
N $D539 Build #R$F900.
  $D539,$03 Point #REGhl at #R$F900.
@ $D53C label=BuildShiftTables_ReverseTable
  $D53C,$03 Copy the byte into #REGd, and set a count of #N$08 bits.
@ $D53F label=BuildShiftTables_ReverseBits
  $D53F,$04 Move the lowest bit of the byte into the other end of #REGe.
  $D543,$02 Jump to #R$D53F if there are any left.
  $D545,$01 Store the byte turned round.
  $D546,$01 Move on to the next byte.
  $D547,$02 Jump to #R$D53C if there are any left.
  $D549,$01 Return.

c $D54A Draw Bounty Symbol
@ $D54A label=DrawBountySymbol
D $D54A Draws the symbol which goes before the bounty, as a block of two by two
. tiles.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D38D)
. #SIM(start=$D38D,stop=$D390)
. #SCR$03,$00,$16,$02,$02(bounty-symbol) } UDGTABLE# #POPS
N $D54A Set the attribute and the tiles.
  $D54A,$03 Set the attribute to #COLOUR$47.
  $D54D,$03 Point #REGde at #R$D561.
N $D550 Choose the screen address.
  $D550,$04 Fetch #R$A267.
  $D554,$03 Point #REGhl at #N$50C0 (in the screen buffer).
  $D557,$02 Jump to #R$D55C if this is the town.
  $D559,$03 Point #REGhl at #N$5070 (in the screen buffer).
N $D55C Draw the block.
@ $D55C label=DrawBountySymbol_Draw
  $D55C,$03 Set the size of the block to two by two.
  $D55F,$02 Jump to #R$D595.

b $D561 Bounty Symbol Tiles
@ $D561 label=BountySymbolTiles
D $D561 The numbers of the tiles of the symbol which goes before the
. bounty, drawn by #R$D54A in two rows of two from #R$8CF0. Bits 6
. and 7 of a number say how the tile is reflected.
B $D561,$01 #UDGTABLE { #N(#PEEK(#PC)) |
. #UDG($8CF0+#PEEK(#PC)*$08,attr=$47) } UDGTABLE#
L $D561,$01,$04

c $D565 Draw Revolver Display
@ $D565 label=DrawRevolverDisplay
D $D565 Draws the picture of the revolver, which is a block of eight by eight
. tiles, and then colours the chambers which are loaded.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D30D)
. #SIM(start=$D30D,stop=$D310)
. #SCR$03,$08,$10,$08,$08(revolver-display) } UDGTABLE# #POPS
N $D565 Draw the picture of the revolver.
  $D565,$03 Set the attribute to #COLOUR$41.
  $D568,$03 Point #REGhl at #N$5004 (in the screen buffer).
N $D56B Move it to the right in the town.
  $D56B,$03 Call #R$D272.
  $D56E,$03 Point #REGde at #R$5E51.
  $D571,$03 Set the size of the block to eight by eight.
N $D574 Draw the block.
  $D574,$03 Call #R$D595.
N $D577 Colour the chambers which are loaded.
  $D577,$05 Return if #R$A262 is zero.
  $D57C,$01 Keep the number in #REGe.
  $D57D,$01 Start with the first chamber.
N $D57E Colour a loaded chamber.
@ $D57E label=DrawRevolverDisplay_Chamber
  $D57E,$02 Stash the chamber number and the number of bullets on the stack.
  $D580,$03 Point #REGbc at #R$C9E0.
N $D583 Find the attribute address of the chamber.
  $D583,$03 Call #R$C75C.
N $D586 Move it to the right in the town.
  $D586,$03 Call #R$D272.
  $D589,$02 Set the attribute to #COLOUR$71.
N $D58B Colour the chamber.
  $D58B,$03 Call #R$C9CF.
  $D58E,$02 Restore the chamber number and the number of bullets from the stack.
  $D590,$01 Move on to the next chamber.
  $D591,$03 Jump to #R$D57E if there are chambers left.
  $D594,$01 Return.

c $D595 Draw Tile Block
@ $D595 label=DrawTileBlock
D $D595 Draws a block of tiles, which are held as one byte for each tile, row by
. row from left to right and top to bottom. The tiles are from the tile set
. whose address is in #R$A20F.
R $D595 B The width of the block
R $D595 C The height of the block
R $D595 DE The address of the numbers of the tiles
R $D595 HL The screen address of the top left
R $D595 A' The attribute
N $D595 Draw each row from left to right.
  $D595,$02 Stash the size and the screen address on the stack.
N $D597 Draw a tile.
@ $D597 label=DrawTileBlock_Tile
  $D597,$02 Fetch the number of the tile.
  $D599,$01 Stash the counters on the stack.
  $D59A,$04 Fetch #R$A20F.
  $D59E,$03 Call #R$D639.
  $D5A1,$01 Restore the counters from the stack.
  $D5A2,$01 Move on to the next column.
  $D5A3,$02 Jump to #R$D597 if there are tiles left in the row.
N $D5A5 Move down a row.
  $D5A5,$01 Restore the screen address of the row from the stack.
  $D5A6,$03 Call #R$D64F.
  $D5A9,$01 Restore the size from the stack.
  $D5AA,$01 Count down the rows.
  $D5AB,$02 Jump to #R$D595 if there are rows left.
  $D5AD,$01 Return.

c $D5AE Draw Tile Block Reflected
@ $D5AE label=DrawTileBlockReflected
D $D5AE The same as #R$D595, except that each row is drawn from right to left
. and each tile is reflected, which makes a reflection of the block.
R $D5AE B The width of the block
R $D5AE C The height of the block
R $D5AE DE The address of the numbers of the tiles
R $D5AE HL The screen address of the top right
R $D5AE A' The attribute
N $D5AE Draw each row from right to left.
  $D5AE,$02 Stash the size and the screen address on the stack.
N $D5B0 Draw a tile, reflected.
@ $D5B0 label=DrawTileBlockReflected_Tile
  $D5B0,$02 Fetch the number of the tile.
  $D5B2,$02,b$01 Reflect it horizontally.
  $D5B4,$01 Stash the counters on the stack.
  $D5B5,$04 Fetch #R$A20F.
N $D5B9 Draw the tile.
  $D5B9,$03 Call #R$D639.
  $D5BC,$01 Restore the counters from the stack.
  $D5BD,$01 Move on to the next column to the left.
  $D5BE,$02 Jump to #R$D5B0 if there are tiles left in the row.
N $D5C0 Move down a row.
  $D5C0,$01 Restore the screen address of the row from the stack.
  $D5C1,$03 Call #R$D64F.
  $D5C4,$01 Restore the size from the stack.
  $D5C5,$01 Count down the rows.
  $D5C6,$02 Jump to #R$D5AE if there are rows left.
  $D5C8,$01 Return.

c $D5C9 Draw Border
@ $D5C9 label=DrawBorder
D $D5C9 Draws the border around the playfield, which is twenty-four tiles wide
. and sixteen high. The corners and the edges are the same tiles at the top and
. the left, drawn reflected for the bottom and the right.
. #PUSHS #UDGTABLE { #POKES$5C79,$56
. #SIM(start=$A36D,stop=$A392,clear=1,sp=$5E00)
. #SIM(start=$A395,stop=$A3B3)
. #SIM(start=$C7D1,stop=$A3B7)
. #SIM(start=$A3B7,stop=$D30A)
. #SIM(start=$D30A,stop=$D30D)
. #SCR$03,$08,$00,$18,$10(border) } UDGTABLE# #POPS
E $D5C9 Continue on to #R$D623.
N $D5C9 Set the attribute and the tile set.
  $D5C9,$03 Set the attribute to #COLOUR$73.
  $D5CC,$04 Fetch #R$A20F.
N $D5D0 Draw the top left corner.
  $D5D0,$03 Point #REGhl at #N$4004 (in the screen buffer).
N $D5D3 Move it to the right in the town.
  $D5D3,$03 Call #R$D272.
  $D5D6,$02 Set the tile to the top left corner.
  $D5D8,$03 Call #R$D639.
N $D5DB Draw the top edge.
  $D5DB,$01 Move on to the next column.
  $D5DC,$04 Set a count of #N$16 tiles, and fetch the top edge.
  $D5E0,$03 Call #R$D62F.
N $D5E3 Draw the top right corner.
  $D5E3,$03 Point #REGhl at #N$401B (in the screen buffer).
N $D5E6 Move it to the right in the town.
  $D5E6,$03 Call #R$D272.
  $D5E9,$02 Set the tile to the top right corner.
  $D5EB,$03 Call #R$D639.
N $D5EE Draw the bottom left corner.
  $D5EE,$03 Point #REGhl at #N$48E4 (in the screen buffer).
N $D5F1 Move it to the right in the town.
  $D5F1,$03 Call #R$D272.
  $D5F4,$02 Set the tile to the bottom left corner.
  $D5F6,$03 Call #R$D639.
N $D5F9 Draw the bottom edge.
  $D5F9,$01 Move on to the next column.
  $D5FA,$04 Set a count of #N$16 tiles, and fetch the bottom edge.
  $D5FE,$03 Call #R$D62F.
N $D601 Draw the bottom right corner.
  $D601,$03 Point #REGhl at #N$48FB (in the screen buffer).
N $D604 Move it to the right in the town.
  $D604,$03 Call #R$D272.
  $D607,$02 Set the tile to the bottom right corner.
  $D609,$03 Call #R$D639.
N $D60C Draw the left edge.
  $D60C,$03 Point #REGhl at #N$4024 (in the screen buffer).
N $D60F Move it to the right in the town.
  $D60F,$03 Call #R$D272.
  $D612,$04 Set a count of #N$0E tiles, and fetch the left edge.
  $D616,$03 Call #R$D623.
N $D619 Draw the right edge.
  $D619,$03 Point #REGhl at #N$403B (in the screen buffer).
N $D61C Move it to the right in the town.
  $D61C,$03 Call #R$D272.
  $D61F,$04 Set a count of #N$0E tiles, and fetch the right edge.

c $D623 Draw Tile Column
@ $D623 label=DrawTileColumn
D $D623 Draws a number of tiles one below another.
R $D623 A The tile
R $D623 E The number of tiles
R $D623 BC The address of the tile set
R $D623 HL The screen address of the top
R $D623 A' The attribute
N $D623 Draw a tile and move down a row.
  $D623,$01 Stash the tile on the stack.
  $D624,$03 Call #R$D639.
  $D627,$03 Call #R$D64F.
  $D62A,$01 Restore the tile from the stack.
  $D62B,$01 Count down the tiles.
  $D62C,$02 Jump to #R$D623 if there are any left.
  $D62E,$01 Return.

c $D62F Draw Tile Row
@ $D62F label=DrawTileRow
D $D62F Draws a number of tiles side by side.
R $D62F A The tile
R $D62F E The number of tiles
R $D62F BC The address of the tile set
R $D62F HL The screen address of the left
R $D62F A' The attribute
N $D62F Draw a tile and move on to the next column.
  $D62F,$01 Stash the tile on the stack.
  $D630,$03 Call #R$D639.
  $D633,$01 Restore the tile from the stack.
  $D634,$01 Move on to the next column.
  $D635,$01 Count down the tiles.
  $D636,$02 Jump to #R$D62F if there are any left.
  $D638,$01 Return.

c $D639 Draw Tile
@ $D639 label=DrawTile
D $D639 Draws a tile of eight by eight pixels and sets its attribute.
E $D639 Continue on to #R$D63C.
E $D639 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$CB5B }
. LIST#
R $D639 A The number of the tile, with bits 6 and 7 which say how to reflect it
R $D639 BC The address of the tile set
R $D639 HL The screen address
R $D639 A' The attribute
  $D639,$03 Draw the tile.

c $D63C Set Tile Attribute
@ $D63C label=SetTileAttribute
D $D63C Sets the attribute of the character square that holds the screen
. address.
R $D63C HL The screen address
R $D63C A' The attribute
N $D63C Find the attribute address from the screen address.
  $D63C,$02 Stash #REGde and #REGhl on the stack.
  $D63E,$04 Find the third of the screen from the high byte.
  $D642,$02,b$01 Keep the two bits of the third.
  $D644,$01 Make it the high byte of the attribute address.
  $D645,$04 Add #N$5800, the start of the attribute buffer.
N $D649 Write the attribute.
  $D649,$01 Fetch the attribute.
  $D64A,$01 Set the attribute.
  $D64B,$01 Keep it.
  $D64C,$02 Restore #REGhl and #REGde from the stack.
  $D64E,$01 Return.

c $D64F Move Down Row
@ $D64F label=MoveDownRow
D $D64F Moves a screen address down by one row of characters.
E $D64F View the equivalent code in;
. #LIST
. { #MARTIANOIDS$B6B2 }
. { #NIGHTSHADE$CB71 }
. { #UNDERWURLDE$98D5 }
. LIST#
R $D64F HL The screen address
R $D64F O:HL The new screen address
  $D64F,$04 Add thirty-two to the low byte.
  $D653,$01 Return if it has not gone into the next third.
  $D654,$04 Add eight to the high byte.
  $D658,$01 Return.

c $D659 Move Up Row
@ $D659 label=MoveUpRow
D $D659 Moves a screen address up by one row of characters.
R $D659 HL The screen address
R $D659 O:HL The new screen address
  $D659,$04 Subtract thirty-two from the low byte.
  $D65D,$01 Return if it has not gone into the previous third.
  $D65E,$04 Subtract eight from the high byte.
  $D662,$01 Return.

c $D663 Draw Tile Pixels
@ $D663 label=DrawTilePixels
D $D663 Draws the pixels of a tile of eight by eight pixels. Bit 7 of the number
. of the tile says that it is reflected vertically and bit 6 that it is
. reflected horizontally.
R $D663 A The number of the tile, with bits 6 and 7 which say how to reflect it
R $D663 BC The address of the tile set
R $D663 HL The screen address
  $D663,$04 Save the registers.
  $D667,$01 Keep the screen address in #REGde.
  $D668,$02,b$01 Keep the number of the tile.
  $D66A,$03 Move it to #REGhl.
  $D66D,$03 Multiply it by eight.
  $D670,$01 Add the address of the tile set.
  $D671,$01 Put the address of the tile in #REGde and the screen address in
. #REGhl.
  $D672,$01 Restore the number of the tile.
  $D673,$02 Move bits 6 and 7 to bits 0 and 1.
  $D675,$02,b$01 Keep them.
  $D677,$02 Jump to draw the tile as it is if neither is set.
  $D679,$01 Count down.
  $D67A,$02 Jump to draw it reflected horizontally if that was one.
  $D67C,$01 Count down.
  $D67D,$02 Jump to draw it reflected vertically if that was two.
  $D67F,$03 Otherwise draw it reflected both ways.
@ $D682 label=DrawTilePixels_Done
  $D682,$04 Restore the registers and return.
@ $D686 label=DrawTilePixels_Normal
  $D686,$05 Draw the tile as it is.
@ $D68B label=DrawTilePixels_Horizontal
  $D68B,$05 Draw the tile reflected horizontally.
@ $D690 label=DrawTilePixels_Vertical
  $D690,$05 Draw the tile reflected vertically.

c $D695 Draw Tile Normal
@ $D695 label=DrawTileNormal
D $D695 Draws a tile as it is.
R $D695 DE The address of the tile
R $D695 HL The screen address
  $D695,$02 Set the number of lines.
@ $D697 label=DrawTileNormal_Line
  $D697,$04 Draw a line.
  $D69B,$02 Go back for the next line.
  $D69D,$01 Return.

c $D69E Draw Tile Horizontal
@ $D69E label=DrawTileHorizontal
D $D69E Draws a tile reflected horizontally, using the page of bytes turned
. round which is at #N$F9.
R $D69E DE The address of the tile
R $D69E HL The screen address
  $D69E,$02 Set the number of lines.
@ $D6A0 label=DrawTileHorizontal_Line
  $D6A0,$03 Fetch a line and keep it in #REGc.
  $D6A3,$01 Save the counters.
  $D6A4,$02 Point #REGbc at the page of bytes turned round.
  $D6A6,$03 Draw the line turned round.
  $D6A9,$01 Restore the counters.
  $D6AA,$02 Go back for the next line.
  $D6AC,$01 Return.

c $D6AD Draw Tile Vertical
@ $D6AD label=DrawTileVertical
D $D6AD Draws a tile reflected vertically, which is the lines from the last to
. the first.
R $D6AD DE The address of the tile
R $D6AD HL The screen address
  $D6AD,$02 Set the number of lines.
  $D6AF,$07 Move to the last line.
@ $D6B6 label=DrawTileVertical_Line
  $D6B6,$04 Draw a line and move to the previous one.
  $D6BA,$02 Go back for the next line.
  $D6BC,$01 Return.

c $D6BD Draw Tile Both
@ $D6BD label=DrawTileBoth
D $D6BD Draws a tile reflected both horizontally and vertically.
R $D6BD DE The address of the tile
R $D6BD HL The screen address
  $D6BD,$02 Set the number of lines.
  $D6BF,$07 Move to the last line.
@ $D6C6 label=DrawTileBoth_Line
  $D6C6,$03 Fetch a line, move to the previous one and keep the line in #REGc.
  $D6C9,$01 Save the counters.
  $D6CA,$02 Point #REGbc at the page of bytes turned round.
  $D6CC,$03 Draw the line turned round.
  $D6CF,$01 Restore the counters.
  $D6D0,$02 Go back for the next line.
  $D6D2,$01 Return.

c $D6D3 Set Attributes
@ $D6D3 label=SetAttributes
D $D6D3 Sets all of the attributes to a value.
R $D6D3 E The attribute
  $D6D3,$03 Point #REGhl at #N$5800 (in the attribute buffer).
  $D6D6,$03 Set the number of attributes.
  $D6D9,$02 Jump to clear them.

c $D6DB Clear Screen
@ $D6DB label=ClearScreen
D $D6DB Clears the pixel bytes of the screen.
E $D6DB Continue on to #R$D6E1.
E $D6DB View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE60 }
. { #ATICATAC$80B4 }
. { #COOKIE$74D4 }
. { #CYBERUN$9A7E }
. { #JETPAC$71B8 }
. { #KNIGHTLORE$D544 }
. { #LUNARJETMAN$84AD }
. { #NIGHTSHADE$E5A8 }
. { #PSSST$7439 }
. { #SABREWULF$BB81 }
. { #TRANZAM$7211 }
. LIST#
  $D6DB,$03 Point #REGhl at #N$4000 (in the screen buffer).
  $D6DE,$03 Set the number of bytes.

c $D6E1 Fill Memory
@ $D6E1 label=FillMemory
D $D6E1 Clears a number of bytes to zero, or fills them with the value of #REGe
. at #R$D6E3.
E $D6E1 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE56 }
. { #KNIGHTLORE$D53A }
. { #MARTIANOIDS$B1A3 }
. { #NIGHTSHADE$E5BA }
. { #PENTAGRAM$CB77 }
. { #UNDERWURLDE$9569 }
. LIST#
R $D6E1 BC The number of bytes
R $D6E1 HL The address
  $D6E1,$02 Fill with zero.
@ $D6E3 label=FillMemory_WithValue
  $D6E3,$05 Store the value, move on and count down the bytes.
  $D6E8,$02 Go back until they are all done.
  $D6EA,$01 Return.

g $D6EB Playfield Buffer
@ $D6EB label=PlayfieldBuffer
D $D6EB The buffer in which the playfield is drawn before it is copied to the
. screen by #R$D04B. It is #N$18 bytes in each of #N$70 rows, and the first row
. is the bottom row of the playfield. #R$D233 finds the address of a point.
B $D6EB,$17,$17
@ $D702 label=PlayfieldBuffer_FirstRowEnd
B $D702,$01,$01
B $D703,$0A68,$18

u $E16B Unused Memory
@ $E16B label=UnusedMemory
D $E16B Not referenced by the game.
B $E16B,$0F95,$20

u $F100 Unused Page
@ $F100 label=UnusedPage
D $F100 Not referenced by the game.
B $F100,$0100,$20

g $F200 Reversed Shift Tables
@ $F200 label=ReversedShiftTables
D $F200 Six pages of the tables which are made by #R$D4FD for a byte with its
. bits turned round. See #R$D4FD for how the pages are used. Pages #N$F2 and
. #N$F3 are for two pixels, pages #N$F4 and #N$F5 for four pixels and pages
. #N$F6 and #N$F7 for six pixels.
B $F200,$0600,$20

u $F800 Unused Page
@ $F800 label=UnusedPageEight
D $F800 Not referenced by the game.
B $F800,$0100,$20

g $F900 Reverse Table
@ $F900 label=ReverseTable
D $F900 A table which has each value of a byte with its bits turned round, which
. is made by #R$D4FD.
B $F900,$0100,$20

g $FA00 Shift Tables
@ $FA00 label=ShiftTables
D $FA00 Six pages of the tables which are made by #R$D4FD for the routines which
. draw sprites. Pages #N$FA and #N$FB are for two pixels, pages #N$FC and #N$FD
. for four pixels and pages #N$FE and #N$FF for six pixels. In each pair of
. pages the first is the part of a byte which stays in the byte when it is moved
. to the right, and the second is the part which moves into the next byte.
B $FA00,$0600,$20
