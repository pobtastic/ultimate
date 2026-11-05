; Copyright Ashby Computers & Graphics Ltd 1985, Rare Ltd, 2026 ArcadeGeek LTD.
> $4000 @org=$4000
> $4000 @rom
> $4000 @start=$5C80
> $4000 @expand=#DEF(#POKE()(anchor,text) #LINK(Pokes#$anchor)($text))
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))
> $4000 @set-handle-unsupported-macros=1
b $4000 Loading screen
@ $4000 label=Loading
D $4000 #UDGTABLE { =h Cyberun Loading Screen } { #SCR$02(loading) } UDGTABLE#
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

c $5B80 Decryption Routine
@ $5B80 label=GameEntry
D $5B80 The loader copies this routine here and runs it once the encrypted
. game has been loaded to #N$5E80. The helper at #R$6000@loader copies this
. stub here and the move routine to #N$FC00. It first moves the game down to
. its home at #N$5C80 (see #R$FC00) and then decrypts it, one byte at a time
. and from the top down, by running RRD over #N$9E00 bytes starting at
. #N$FA00. Each RRD passes a nibble along from one byte to the next, so the
. whole game is stored shifted by half a byte. Control then goes to #R$5C80.
. Once the game is running the space up to #N$5BFF is reused, for the records
. of the segments of the four tiles that #R$D0BD makes (starting at #N($5B80),
. #N($5BA5), #N($5BCA) and #N($5BEF)). That routine also sets the stack pointer
. to #N$5B7A.
N $5B80 Set up the stack and move the game down into place.
  $5B80,$03 Set the stack pointer to #N$FE00.
  $5B83,$01 Disable interrupts.
  $5B84,$03 Call #R$FC00 to move the game down to #N$5C80.
N $5B87 Decrypt every byte from #N$FA00 down to #N$5C01.
  $5B87,$03 Set the start address in #REGhl to #N$FA00.
  $5B8A,$01 Clear the nibble carried between bytes in #REGa.
  $5B8B,$03 Set the byte count in #REGbc to #N$9E00.
@ $5B8E label=Decryption_Loop
  $5B8E,$02 Rotate the nibbles of the current byte through #REGa.
  $5B90,$01 Move down to the previous byte.
  $5B91,$03 Decrease the low byte of the counter by one and loop back to #R$5B8E
. until none remain.
  $5B94,$02 Decrease the high byte of the counter by one and loop back to
. #R$5B8E until every byte has been decrypted.
  $5B96,$03 Jump to #R$5C80.

i $5B99

s $5C00 Unused
S $5C00,$1A,$1A

g $5C1A Contact Flag
@ $5C1A label=ContactFlag
D $5C1A Cleared by #R$D729, which sets it when the terrain was touched in a
. way that stops the horizontal speed, and tests it again at the end. Other
. routines also use it.
B $5C1A,$01,$01

s $5C1B Not Used
S $5C1B,$01,$01

g $5C1C Scratch Value
@ $5C1C label=ScratchValue
D $5C1C One of the values that many routines use for temporary results. The
. terrain drawing routines keep a screen column in it, for #R$D8DA.
B $5C1C,$01,$01

g $5C1D Tile Number
@ $5C1D label=TileNumber
D $5C1D Which of the four tiles in view is being drawn, from #N$00 to #N$03: bit
. 0 is set for a tile below the first and bit 1 for a tile to the right. #R$D0BD
. sets it. Other routines use it to count tiles that an object overlaps, and
. for temporary values.
B $5C1D,$01,$01

g $5C1E Scratch Values
@ $5C1E label=ScratchPair
D $5C1E Two more of the values that many routines use for temporary results.
B $5C1E,$02,$01

g $5C20 Segments Left
@ $5C20 label=SegmentsLeft
D $5C20 The number of segments of the script of the current tile that are not
. drawn yet, which #R$D0BD sets from the script. Other routines use it for
. temporary values.
B $5C20,$01,$01

s $5C21 Not Used
S $5C21,$01,$01

g $5C22 Segment Length
@ $5C22 label=SegmentLength
D $5C22 The number of steps in the current segment, from #N$01 to #N$10. #R$D0BD
. reads it from the script.
B $5C22,$01,$01

s $5C23 Not Used
S $5C23,$01,$01

g $5C24 Column Step Size
@ $5C24 label=ColumnStepSize
D $5C24 The column step of the type of the current segment without its sign,
. set by #R$CD08. Also used by #R$8347.
B $5C24,$01,$01

g $5C25 Horizontal Step Size
@ $5C25 label=HorizontalStepSize
D $5C25 The horizontal step of the type of the current segment without its
. sign, set by #R$CD08. #R$C374 sets it to #N$FF while the ship is tested
. against the terrain, and #R$90A7 sets it to #N$80 when an object should stop.
B $5C25,$01,$01

g $5C26 Upside Down Flag
@ $5C26 label=UpsideDownFlag
D $5C26 Set to #N($99) when the current tile is drawn upside down and to zero
. when it is not, by #R$D0BD.
B $5C26,$01,$01

g $5C27 Shape Flag
@ $5C27 label=ShapeFlag
D $5C27 Cleared at the start of each segment. #R$D588 stores a shape code in it
. for a segment that goes the way that the horizontal speed does and that
. starts at the edge of a cell, and #R$D8DA tests it.
B $5C27,$01,$01

g $5C28 Scratch Values
@ $5C28 label=ScratchQuad
D $5C28 Four more of the values that many routines use for temporary results.
B $5C28,$04,$01

g $5C2C Segment Screen Column
@ $5C2C label=SegmentScreenColumn
D $5C2C The pixel column of the current step of a segment on the screen, found
. by #R$D937 and moved on by #R$D319. Other routines use it for the position of
. an object.
B $5C2C,$01,$01

g $5C2D Segment Screen Row
@ $5C2D label=SegmentScreenRow
D $5C2D The pixel row of the current step of a segment on the screen, found by
. #R$D937 and moved on by #R$D319. Other routines use it for the position of an
. object.
B $5C2D,$01,$01

g $5C2E Piece Column
@ $5C2E label=PieceColumn
D $5C2E The column where the next piece of a sloped segment starts in its row,
. set by #R$D3D2 and read by #R$DBB7. Other routines use the two bytes from
. here as a word.
B $5C2E,$01,$01

g $5C2F Flagged Steps
@ $5C2F label=FlaggedSteps
D $5C2F The number of steps of the current segment that have been flagged: it is
. cleared at the start of each segment and increased by #R$D716.
B $5C2F,$01,$01

g $5C30 Back To Front Flag
@ $5C30 label=BackToFrontFlag
D $5C30 Set to #N($FF) when the current tile is drawn back to front and to zero
. when it is not, by #R$D0BD. Other routines use the two bytes from here as a
. word.
B $5C30,$01,$01

g $5C31 Contact Flags
@ $5C31 label=ContactFlags
D $5C31 Cleared by #R$D33D for each step of a segment. #R$CE79 and #R$CE97 set
. bit 7, and then bit 0 or bit 1 instead; #R$CEB5 sets bit 3 and #R$CEC8
. sets bit 2. #R$D3B0 chooses what to do from the result.
B $5C31,$01,$01

g $5C32 Last Contact Flags
@ $5C32 label=LastContactFlags
D $5C32 A copy of the flags at #R$5C31 that #R$CE79 and #R$CE97 make when they
. set bit 0 or bit 1, cleared at the start of each segment. #R$D9A8 tests it.
B $5C32,$01,$01

g $5C33 Start Shape
@ $5C33 label=StartShape
D $5C33 The shape code for the start of a flat segment, read from the script by
. #R$CD6B and changed when the tile is back to front or upside down.
B $5C33,$01,$01

g $5C34 End Shape
@ $5C34 label=EndShape
D $5C34 The shape code for the end of a flat segment, read from the script by
. #R$CD6B and changed when the tile is back to front or upside down.
B $5C34,$01,$01

g $5C35 Upside Down Segment
@ $5C35 label=UpsideDownSegment
D $5C35 Set to #N($80) by #R$E3D8 when the current segment is upside down, and
. cleared at the start of each segment. #R$BA21 also uses it as the collision
. status: #N$80 once a rectangle has been hit, bit 6 after a vertical bounce,
. and bit 4 after a slope has been hit.
B $5C35,$01,$01

g $5C36 Scratch Value
@ $5C36 label=ControlScratch
D $5C36 Cleared at the start of #R$B234. Left stores #N($80) here and right
. stores #N($03), and #R$C374 compares bit 7 with the facing of the ship.
B $5C36,$01,$01

g $5C37 Controls
@ $5C37 label=Controls
D $5C37 What is pressed on the keyboard or joystick, set by #R$B115 (bit 0 is
. right, bit 1 is left, bit 3 is up, bit 4 is fire and bit 5 is the extra key).
B $5C37,$01,$01

g $5C38 Ship Row
@ $5C38 label=ShipRow
D $5C38 A vertical position that #R$AFE9 works out from the height of the ship
. and that other routines compare with the positions of objects. Also used for
. the step of the shots.
B $5C38,$01,$01

g $5C39 Scratch Value
@ $5C39 label=ShotScratch
D $5C39 The number of frames before the ship can fire again. #R$B734
. stores #N$06 when the ship fires and counts it down, and returns
. while it is not zero.
B $5C39,$01,$01

g $5C3A Top Tile Colour
@ $5C3A label=TopTileColour
D $5C3A The attribute value for the terrain of a tile on the top row, set by
. #R$DEE1 and used by #R$CF38.
B $5C3A,$01,$01

g $5C3B Bottom Tile Colour
@ $5C3B label=BottomTileColour
D $5C3B The attribute value for the terrain of a tile on the bottom row, set by
. #R$DEE1 and used by #R$CF38.
B $5C3B,$01,$01

g $5C3C Scroll In Flag
@ $5C3C label=ScrollInFlag
D $5C3C Not zero while the world scrolls in at the start of a life: #N($FF)
. at first and #N$03 once the ground has been found (see #R$DD79). While it is
. set #R$D0BD treats all of the tiles as changed and #R$CF38 does not colour
. them.
B $5C3C,$01,$01

g $5C3D Tiles Changed
@ $5C3D label=TilesChanged
D $5C3D The number of times that the map position moved in the frame, set by
. #R$DDF8 (and set by #R$D0BD when #R$5C3C is not zero). When it is not zero
. #R$D0BD makes the records of the segments of the tiles again.
B $5C3D,$01,$01

g $5C3E Horizontal Limit
@ $5C3E label=HorizontalLimit
D $5C3E Two normally, and four when the flag at #R$F5F1 is set.
. #R$AFE9 sets it.
B $5C3E,$01,$01

g $5C3F Vertical Limit
@ $5C3F label=VerticalLimit
D $5C3F Two normally, and four when the flag at #R$F5F2 is set. #R$AFE9
. sets it. It is
. the limit of the vertical scroll speed, used by #R$B2D5.
B $5C3F,$01,$01

g $5C40 Variables
@ $5C40 label=Variables
D $5C40 More variables used by the game. The first byte is set to #N$FF
. when the ship is hit and is cleared at the start of the next frame.
. Purpose not yet known for the rest.
B $5C40,$10,$10
B $5C50,$10,$10
B $5C60,$10,$10
B $5C70,$10,$10

c $5C80 Start Game
@ $5C80 label=StartGame
D $5C80 The entry point of the game, once the loader has moved it into place and
. decrypted it.
  $5C80,$01 Disable interrupts.
  $5C81,$03 Jump to #R$9A66.

b $5C84 Bit Doubling Table
@ $5C84 label=BitDoublingTable
D $5C84 Each entry is the bottom four bits of its index with every bit
. doubled up.
B $5C84,$10,$10

b $5C94 Map Table
@ $5C94 label=MapTable
D $5C94 One byte for each of the #N$0122 objects that are placed on the map,
. in the order of the table at #R$5E17. The bottom six bits are the kind of
. object (see #R$E0FD). Bit 7 is set once player one has destroyed the object
. and bit 6 once player two has, so that #R$E114 does not put it back.
. #R$F44C changes the code that tests and sets the bit to suit the current
. player. #R$9A8A masks all of the bytes with a value that depends on the
. number of players.
B $5C94,$122,$18

b $5DB6 Column Table
@ $5DB6 label=ColumnTable
D $5DB6 The number of objects in each of the #N$60 columns of the map, which
. are the first #N$60 bytes. #R$E08F adds them up to find where the objects of
. a column start in the tables at #R$5C94 and #R$5E17. The last byte is not
. used.
B $5DB6,$61,$10

b $5E17 Terrain Data
@ $5E17 label=TerrainData
D $5E17 Two bytes for each of the objects on the map, in order of their column.
. The top six bits of the first byte are the vertical position of the object
. (one more than its pixel row, in multiples of four) and the bottom two are
. bits 3 and 4 of its horizontal position. The second byte has the map row in
. its bottom five bits and the top three bits of the horizontal position in its
. top three bits. #R$E114 decodes them.
B $5E17,$244,$10

b $605B Item Sites
@ $605B label=ItemSitesPool3
D $605B The first of five pools of candidate item sites used by #R$6113, for
. pool number #N$03. Each site is four bytes: the map column, the map zone, the
. horizontal position and the vertical position. Sixteen sites.
B $605B,$40,$04
@ $609B label=ItemSitesPool1
D $609B The pool of item sites for pool number #N$01. Sixteen sites.
B $609B,$40,$04
@ $60DB label=ItemSitesPool5
D $60DB The pool of item sites for pool number #N$05. Two sites.
B $60DB,$08,$04
@ $60E3 label=ItemSitesPool2
D $60E3 The pool of item sites for pool number #N$02. Eight sites; the first
. byte of the first and third sites is set to #N($FF) by #R$6113 so that they
. are never chosen.
B $60E3,$20,$04
@ $6103 label=ItemSitesPool4
D $6103 The pool of item sites for pool number #N$04. Four sites.
B $6103,$10,$04

c $6113 Choose Item Sites
@ $6113 label=ChooseItemSites
D $6113 Chooses the sites of the items on a planet. Each site is a four byte
. record (map column, map zone, horizontal position and vertical position)
. copied into the table in #REGde. The sites are picked at random from the five
. pools of candidate records at #R$605B, #R$609B, #R$60DB, #R$60E3 and #R$6103,
. using the list of pool numbers at #R$61A9. A pool number of zero leaves the
. site unset or, when the next pool number is #N($03), copies the previous site
. with the positions adjusted.
. .
. Bit 7 of the first byte of a pool record marks it as used so that the same
. record is never picked twice in one go.
R $6113 DE Address of the table to fill (#R$F604 for player one, #R$F66D for
. player two)
@ $6117 label=ChooseItemSites_ClearUsed
N $6113 Start at the beginning of the list of pool numbers.
  $6113,$04 Use the list of pool numbers at #R$61A9.
N $6117 Mark all of the pool records as unused.
  $6117,$03 Use the first pool record.
  $611A,$02 Set a counter in #REGb for #N$2E records.
@ $611C label=ChooseItemSites_ClearLoop
  $611C,$01 Fetch the first byte of the record.
  $611D,$02,b$01 Clear its used flag (bit 7).
  $611F,$01 Write it back.
  $6120,$04 Move on to the next record.
  $6124,$02 Decrease the record counter by one and loop back to #R$611C until
. all of the records have been cleared.
  $6126,$05 Make the first byte of the record at #R$60E3 #N($FF), so it can
. never be picked.
  $612B,$03 Do the same for the record at #R$60EB.
N $612E Work through the list of pool numbers, filling one site each time.
@ $612E label=ChooseItemSites_Loop
  $612E,$03 Fetch the pool number for this site.
  $6131,$01 Test whether it is zero.
  $6132,$02 Jump to #R$6152 if it is not.
  $6134,$03 Fetch the next pool number from the list.
  $6137,$02 Jump to #R$619B if it is not equal to #N($03), leaving this
. site unset.
N $613B This site is a copy of the previous one, moved along a little.
  $613B,$02 Copy the table pointer from #REGde to #REGhl.
  $613D,$04 Step back to the previous site.
  $6141,$03 Set the length of a site record in #REGbc.
  $6144,$02 Copy the previous site into this one.
  $6146,$01 Step back to the last byte of the site, the vertical position.
  $6147,$01 Fetch it...
  $6148,$02 ...subtract #N$23...
  $614A,$01 ...and write it back.
  $614B,$01 Step back to the horizontal position.
  $614C,$01 Fetch it...
  $614D,$02 ...add #N$10...
  $614F,$01 ...and write it back.
  $6150,$02 Jump to #R$619D.
N $6152 Select the pool for this pool number.
@ $6152 label=ChooseItemSites_SelectPool
  $6152,$02 Set the pool size mask to #N$0F (sixteen records).
  $6154,$03 Use the pool for pool number #N$01.
  $6157,$04 Jump to #R$6179 if the pool number is #N$01.
  $615B,$03 Use the pool for pool number #N$03.
  $615E,$04 Jump to #R$6179 if the pool number is #N$03.
  $6162,$02 Set the pool size mask to #N$07 (eight records).
  $6164,$03 Use the pool for pool number #N$02.
  $6167,$04 Jump to #R$6179 if the pool number is #N$02.
  $616B,$02 Set the pool size mask to #N$03 (four records).
  $616D,$03 Use the pool for pool number #N$04.
  $6170,$04 Jump to #R$6179 if the pool number is #N$04.
  $6174,$03 Use the pool for pool number #N$05.
  $6177,$02 Set the pool size mask to #N$01 (two records).
N $6179 Pick an unused record from the pool at random.
@ $6179 label=ChooseItemSites_PickRecord
  $6179,$01 Stash the address of the pool on the stack.
  $617A,$03 Fetch a random number.
  $617D,$01 Keep only the bits allowed by the pool size.
  $617E,$02 Multiply it by four to get an offset into the pool.
  $6180,$03 Add the offset to #REGhl.
  $6183,$04 Jump to #R$618D if it has not been used.
  $6187,$03 Call #R$F23B to get a new random number.
  $618A,$01 Restore the address of the pool.
  $618B,$02 Jump back to #R$6179 to try again.
N $618D Copy the unused record into the site table and mark it used.
@ $618D label=ChooseItemSites_CopyRecord
  $618D,$03 Set the length of a site record in #REGbc.
  $6190,$02 Copy the record into the site table.
  $6192,$04 Step back to the start of the pool record.
  $6196,$02 Set the used flag of the pool record.
  $6198,$01 Restore the address of the pool.
  $6199,$02 Jump to #R$619F.
@ $619B label=ChooseItemSites_Skip
  $619B,$02 Skip the first two bytes of this site, leaving it unset.
@ $619D label=ChooseItemSites_SkipRest
  $619D,$02 Skip the last two bytes of the site.
N $619F Move on to the next pool number, unless this was the last one.
@ $619F label=ChooseItemSites_Next
  $619F,$03 Fetch the pool number just dealt with.
  $61A2,$03 Return if it was #N($04), as the last pool number in the list is
. always #N$04.
  $61A5,$02 Use the next pool number.
  $61A7,$02 Jump back to #R$612E.

b $61A9 Item Site Pool Numbers
@ $61A9 label=ItemSitePoolNumbers
D $61A9 The pool number for each item site that #R$6113 fills in, in order,
. followed by #N$04 to mark the end of the list.
B $61A9,$12,$01
@ $61BB label=ItemSitePoolNumbers_End
B $61BB,$01,$01 Terminator.

b $61BC Tile Map
@ $61BC label=TileMap
D $61BC The map of the world: #N$1C rows of #N$60 columns, one byte for each
. tile, row by row from the top. The byte is the number of the tile, which
. #R$6C3C turns into a script that draws it. Tile #N$00 is blank. The top rows
. are mostly empty sky and the rest is ground.
B $61BC,$0A80,$60

w $6C3C Tile Script Pointers
@ $6C3C label=TileScriptPointers
D $6C3C The address of the script for each of the #N$AB tiles. Tiles that are
. the same shape upside down or back to front have their own entries, which
. point to the same script but start at different places (see #R$6D92).
W $6C3C,$0156,$02

b $6D92 Tile Scripts
@ $6D92 label=TileScripts
D $6D92 The scripts that draw the tiles. A script is a list of segments of
. ground. It starts with up to three prefix bytes (#N($99), #N($FF) and
. #N($99)), then the number of segments, then the segments. The pointers at
. #R$6C3C start at one of the prefix bytes or at the number: a script drawn
. from the first #N$99 is upside down and back to front, from the #N$FF is back
. to front, from the last #N$99 is upside down, and from the number is drawn as
. it is. #R$D0BD reads the scripts.
N $6D92 Each segment is the pixel column and the pixel row where it starts, one
. byte with the type of slope in the top four bits and the length in the bottom
. four bits (zero is #N$10), and, only for a flat type (#N$00 or #N$07), two
. more bytes that give the shape at each end.
B $6D92,$02,$01 Two scripts with no segments.
B $6D94,$01,$01 Prefix.
N $6D95 Tiles #N($5A).
B $6D95,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6D96,$03,$03 Type #N($09), length #N($05), at #N($08) by #N($3F).
B $6D99,$03,$03 Type #N($0C), length #N($05), at #N($E0) by #N($3F).
B $6D9C,$03,$03 Type #N($05), length #N($05), at #N($28) by #N($B7).
B $6D9F,$03,$03 Type #N($02), length #N($05), at #N($C0) by #N($B7).
N $6DA2 Tiles #N($3E).
B $6DA2,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6DA3,$05,$05 Type #N($07), length #N($08), at #N($18) by #N($63).
B $6DA8,$05,$05 Type #N($00), length #N($08), at #N($18) by #N($6F).
B $6DAD,$03,$03 Type #N($0D), length #N($02), at #N($10) by #N($5F).
B $6DB0,$03,$03 Type #N($0A), length #N($02), at #N($D8) by #N($5F).
B $6DB3,$03,$03 Type #N($03), length #N($02), at #N($08) by #N($8F).
B $6DB6,$03,$03 Type #N($06), length #N($02), at #N($E0) by #N($8F).
N $6DB9 Tiles #N($AA).
B $6DB9,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6DBA,$03,$03 Type #N($0A), length #N($02), at #N($D8) by #N($5F).
B $6DBD,$03,$03 Type #N($0D), length #N($02), at #N($10) by #N($5F).
N $6DC0 Tiles #N($40), #N($A5).
B $6DC0,$01,$01 Prefix bytes.
B $6DC1,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6DC2,$03,$03 Type #N($09), length #N($05), at #N($08) by #N($3F).
B $6DC5,$03,$03 Type #N($05), length #N($05), at #N($28) by #N($B7).
B $6DC8,$05,$05 Type #N($00), length #N($01), at #N($D0) by #N($97).
B $6DCD,$03,$03 Type #N($03), length #N($02), at #N($C0) by #N($B7).
N $6DD0 Tiles #N($42).
B $6DD0,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6DD1,$03,$03 Type #N($0F), length #N($05), at #N($28) by #N($67).
B $6DD4,$03,$03 Type #N($0A), length #N($05), at #N($08) by #N($B7).
B $6DD7,$03,$03 Type #N($0E), length #N($07), at #N($C0) by #N($87).
B $6DDA,$03,$03 Type #N($03), length #N($03), at #N($A8) by #N($B7).
N $6DDD Tiles #N($01), #N($21).
B $6DDD,$01,$01 Prefix bytes.
B $6DDE,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6DDF,$05,$05 Type #N($00), length #N($04), at #N($08) by #N($97).
B $6DE4,$03,$03 Type #N($01), length #N($04), at #N($68) by #N($97).
B $6DE7,$03,$03 Type #N($02), length #N($08), at #N($A8) by #N($77).
N $6DEA Tiles #N($02), #N($22), #N($61).
B $6DEA,$02,$01 Prefix bytes.
B $6DEC,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6DED,$03,$03 Type #N($01), length #N($04), at #N($08) by #N($37).
N $6DF0 Tiles #N($03), #N($23).
B $6DF0,$01,$01 Prefix bytes.
B $6DF1,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6DF2,$03,$03 Type #N($01), length #N($08), at #N($48) by #N($B7).
B $6DF5,$03,$03 Type #N($02), length #N($04), at #N($C8) by #N($77).
N $6DF8 Tiles #N($04), #N($24), #N($66), #N($68).
B $6DF8,$03,$01 Prefix bytes.
B $6DFB,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6DFC,$05,$05 Type #N($00), length #N($04), at #N($48) by #N($37).
B $6E01,$03,$03 Type #N($01), length #N($04), at #N($08) by #N($57).
B $6E04,$03,$03 Type #N($01), length #N($04), at #N($A8) by #N($37).
N $6E07 Tiles #N($05), #N($25), #N($67), #N($73).
B $6E07,$03,$01 Prefix bytes.
B $6E0A,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E0B,$03,$03 Type #N($01), length #N($08), at #N($08) by #N($B7).
B $6E0E,$03,$03 Type #N($02), length #N($0C), at #N($88) by #N($77).
N $6E11 Tiles #N($06), #N($26), #N($6E), #N($7A).
B $6E11,$03,$01 Prefix bytes.
B $6E14,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E15,$05,$05 Type #N($00), length #N($04), at #N($28) by #N($77).
B $6E1A,$03,$03 Type #N($03), length #N($04), at #N($08) by #N($B7).
B $6E1D,$03,$03 Type #N($02), length #N($0C), at #N($88) by #N($77).
N $6E20 Tiles #N($07), #N($27), #N($65), #N($72).
B $6E20,$03,$01 Prefix bytes.
B $6E23,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E24,$05,$05 Type #N($00), length #N($04), at #N($48) by #N($97).
B $6E29,$03,$03 Type #N($01), length #N($04), at #N($08) by #N($B7).
B $6E2C,$03,$03 Type #N($02), length #N($08), at #N($A8) by #N($97).
N $6E2F Tiles #N($08), #N($28).
B $6E2F,$01,$01 Prefix bytes.
B $6E30,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E31,$03,$03 Type #N($02), length #N($0C), at #N($08) by #N($B7).
B $6E34,$03,$03 Type #N($03), length #N($04), at #N($68) by #N($57).
N $6E37 Tiles #N($09), #N($29).
B $6E37,$01,$01 Prefix bytes.
B $6E38,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E39,$03,$03 Type #N($02), length #N($0C), at #N($88) by #N($B7).
N $6E3C Tiles #N($0A), #N($9B).
B $6E3C,$01,$01 Prefix bytes.
B $6E3D,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E3E,$05,$05 Type #N($00), length #N($04), at #N($28) by #N($37).
B $6E43,$03,$03 Type #N($02), length #N($04), at #N($08) by #N($57).
B $6E46,$03,$03 Type #N($06), length #N($08), at #N($C0) by #N($B7).
N $6E49 Tiles #N($0B), #N($2B).
B $6E49,$01,$01 Prefix bytes.
B $6E4A,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E4B,$03,$03 Type #N($03), length #N($04), at #N($08) by #N($57).
N $6E4E Tiles #N($0C), #N($2C).
B $6E4E,$01,$01 Prefix bytes.
B $6E4F,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E50,$05,$05 Type #N($00), length #N($04), at #N($28) by #N($97).
B $6E55,$03,$03 Type #N($05), length #N($04), at #N($20) by #N($97).
B $6E58,$03,$03 Type #N($03), length #N($08), at #N($88) by #N($97).
N $6E5B Tiles #N($0D), #N($2D), #N($9C).
B $6E5B,$02,$01 Prefix bytes.
B $6E5D,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E5E,$03,$03 Type #N($03), length #N($04), at #N($C8) by #N($B7).
N $6E61 Tiles #N($0E).
B $6E61,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E62,$05,$05 Type #N($00), length #N($02), at #N($28) by #N($57).
B $6E67,$03,$03 Type #N($02), length #N($04), at #N($08) by #N($77).
B $6E6A,$03,$03 Type #N($05), length #N($04), at #N($70) by #N($77).
B $6E6D,$03,$03 Type #N($06), length #N($04), at #N($90) by #N($B7).
N $6E70 Tiles #N($0F), #N($2F), #N($71), #N($7C).
B $6E70,$03,$01 Prefix bytes.
B $6E73,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E74,$03,$03 Type #N($03), length #N($0A), at #N($08) by #N($B7).
N $6E77 Tiles #N($10), #N($2E), #N($30), #N($6A).
B $6E77,$03,$01 Prefix bytes.
B $6E7A,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E7B,$05,$05 Type #N($00), length #N($04), at #N($08) by #N($97).
B $6E80,$03,$03 Type #N($03), length #N($08), at #N($68) by #N($97).
N $6E83 Tiles #N($11), #N($31), #N($76), #N($82).
B $6E83,$03,$01 Prefix bytes.
B $6E86,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E87,$05,$05 Type #N($00), length #N($04), at #N($08) by #N($97).
B $6E8C,$03,$03 Type #N($02), length #N($10), at #N($68) by #N($97).
N $6E8F Tiles #N($12), #N($32), #N($7E), #N($7F).
B $6E8F,$03,$01 Prefix bytes.
B $6E92,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E93,$05,$05 Type #N($00), length #N($08), at #N($28) by #N($97).
B $6E98,$03,$03 Type #N($02), length #N($04), at #N($08) by #N($B7).
N $6E9B Tiles #N($13), #N($33), #N($6B).
B $6E9B,$02,$01 Prefix bytes.
B $6E9D,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6E9E,$03,$03 Type #N($03), length #N($04), at #N($A8) by #N($B7).
B $6EA1,$03,$03 Type #N($02), length #N($04), at #N($C8) by #N($77).
N $6EA4 Tiles #N($14), #N($34), #N($6D), #N($99).
B $6EA4,$03,$01 Prefix bytes.
B $6EA7,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6EA8,$05,$05 Type #N($00), length #N($04), at #N($48) by #N($57).
B $6EAD,$03,$03 Type #N($02), length #N($04), at #N($08) by #N($B7).
B $6EB0,$03,$03 Type #N($03), length #N($04), at #N($28) by #N($97).
B $6EB3,$03,$03 Type #N($03), length #N($04), at #N($A8) by #N($57).
N $6EB6 Tiles #N($15), #N($35), #N($6C), #N($6F).
B $6EB6,$03,$01 Prefix bytes.
B $6EB9,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6EBA,$05,$05 Type #N($00), length #N($04), at #N($48) by #N($57).
B $6EBF,$03,$03 Type #N($01), length #N($04), at #N($08) by #N($77).
B $6EC2,$03,$03 Type #N($02), length #N($08), at #N($A8) by #N($57).
N $6EC5 Tiles #N($16), #N($87).
B $6EC5,$01,$01 Prefix bytes.
B $6EC6,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6EC7,$05,$05 Type #N($00), length #N($0A), at #N($08) by #N($97).
N $6ECC Tiles #N($17), #N($36), #N($86), #N($8B).
B $6ECC,$03,$01 Prefix bytes.
B $6ECF,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6ED0,$03,$03 Type #N($02), length #N($08), at #N($08) by #N($57).
N $6ED3 Tiles #N($18), #N($37).
B $6ED3,$01,$01 Prefix bytes.
B $6ED4,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6ED5,$05,$05 Type #N($00), length #N($06), at #N($58) by #N($97).
B $6EDA,$03,$03 Type #N($03), length #N($02), at #N($48) by #N($B7).
N $6EDD Tiles #N($19), #N($38), #N($69), #N($8A).
B $6EDD,$03,$01 Prefix bytes.
B $6EE0,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6EE1,$05,$05 Type #N($00), length #N($04), at #N($08) by #N($97).
B $6EE6,$03,$03 Type #N($01), length #N($08), at #N($68) by #N($97).
N $6EE9 Tiles #N($A7), #N($A8).
B $6EE9,$01,$01 Prefix bytes.
B $6EEA,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6EEB,$05,$05 Type #N($00), length #N($01), at #N($08) by #N($97).
B $6EF0,$03,$03 Type #N($06), length #N($02), at #N($28) by #N($B7).
N $6EF3 Tiles #N($1A), #N($39), #N($A9).
B $6EF3,$01,$01 Prefix bytes.
B $6EF4,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6EF5,$05,$05 Type #N($00), length #N($01), at #N($08) by #N($97).
B $6EFA,$05,$05 Type #N($00), length #N($01), at #N($D0) by #N($97).
B $6EFF,$03,$03 Type #N($06), length #N($02), at #N($28) by #N($B7).
B $6F02,$03,$03 Type #N($03), length #N($02), at #N($C0) by #N($B7).
N $6F05 Tiles #N($1B), #N($3A).
B $6F05,$01,$01 Prefix bytes.
B $6F06,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F07,$05,$05 Type #N($00), length #N($04), at #N($48) by #N($97).
B $6F0C,$03,$03 Type #N($02), length #N($04), at #N($28) by #N($B7).
B $6F0F,$03,$03 Type #N($03), length #N($08), at #N($A8) by #N($97).
N $6F12 Tiles #N($1C), #N($3B), #N($70), #N($7B).
B $6F12,$03,$01 Prefix bytes.
B $6F15,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F16,$03,$03 Type #N($03), length #N($0A), at #N($58) by #N($B7).
N $6F19 Tiles #N($1D), #N($3C).
B $6F19,$01,$01 Prefix bytes.
B $6F1A,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F1B,$03,$03 Type #N($03), length #N($04), at #N($08) by #N($77).
B $6F1E,$03,$03 Type #N($02), length #N($04), at #N($28) by #N($37).
N $6F21 Tiles #N($1E), #N($3D), #N($89).
B $6F21,$02,$01 Prefix bytes.
B $6F23,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F24,$05,$05 Type #N($07), length #N($08), at #N($28) by #N($3B).
B $6F29,$05,$05 Type #N($00), length #N($0A), at #N($08) by #N($97).
B $6F2E,$03,$03 Type #N($0C), length #N($04), at #N($20) by #N($37).
N $6F31 Tiles #N($1F), #N($3F).
B $6F31,$01,$01 Prefix bytes.
B $6F32,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F33,$05,$05 Type #N($00), length #N($03), at #N($A0) by #N($97).
B $6F38,$03,$03 Type #N($03), length #N($01), at #N($88) by #N($B7).
B $6F3B,$03,$03 Type #N($02), length #N($02), at #N($90) by #N($A7).
N $6F3E Tiles #N($41).
B $6F3E,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F3F,$03,$03 Type #N($06), length #N($03), at #N($40) by #N($47).
B $6F42,$03,$03 Type #N($03), length #N($03), at #N($A8) by #N($47).
B $6F45,$03,$03 Type #N($0F), length #N($07), at #N($40) by #N($B7).
B $6F48,$03,$03 Type #N($0E), length #N($07), at #N($A8) by #N($B7).
N $6F4B Tiles #N($8D).
B $6F4B,$01,$01 Prefix bytes.
B $6F4C,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F4D,$03,$03 Type #N($0A), length #N($02), at #N($20) by #N($37).
B $6F50,$03,$03 Type #N($03), length #N($08), at #N($80) by #N($97).
B $6F53,$05,$05 Type #N($07), length #N($01), at #N($08) by #N($3B).
B $6F58,$05,$05 Type #N($00), length #N($05), at #N($08) by #N($97).
N $6F5D Tiles #N($43), #N($8E).
B $6F5D,$01,$01 Prefix bytes.
B $6F5E,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F5F,$03,$03 Type #N($09), length #N($04), at #N($08) by #N($77).
B $6F62,$03,$03 Type #N($08), length #N($08), at #N($28) by #N($57).
B $6F65,$03,$03 Type #N($02), length #N($04), at #N($48) by #N($B7).
B $6F68,$03,$03 Type #N($01), length #N($08), at #N($68) by #N($97).
N $6F6B Tiles #N($44), #N($8F).
B $6F6B,$01,$01 Prefix bytes.
B $6F6C,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F6D,$03,$03 Type #N($09), length #N($08), at #N($A8) by #N($B7).
N $6F70 Tiles #N($45), #N($59), #N($79), #N($90).
B $6F70,$03,$01 Prefix bytes.
B $6F73,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F74,$03,$03 Type #N($0F), length #N($04), at #N($A0) by #N($57).
B $6F77,$03,$03 Type #N($09), length #N($0C), at #N($48) by #N($B7).
N $6F7A Tiles #N($46), #N($91).
B $6F7A,$01,$01 Prefix bytes.
B $6F7B,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F7C,$05,$05 Type #N($07), length #N($04), at #N($88) by #N($3B).
B $6F81,$05,$05 Type #N($00), length #N($02), at #N($B8) by #N($97).
B $6F86,$03,$03 Type #N($09), length #N($10), at #N($08) by #N($B7).
B $6F89,$03,$03 Type #N($01), length #N($02), at #N($98) by #N($A7).
B $6F8C,$03,$03 Type #N($02), length #N($02), at #N($88) by #N($B7).
N $6F8F Tiles #N($47), #N($92).
B $6F8F,$01,$01 Prefix bytes.
B $6F90,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F91,$03,$03 Type #N($02), length #N($08), at #N($48) by #N($57).
B $6F94,$03,$03 Type #N($01), length #N($04), at #N($08) by #N($77).
N $6F97 Tiles #N($48).
B $6F97,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6F98,$05,$05 Type #N($07), length #N($0A), at #N($08) by #N($3B).
B $6F9D,$05,$05 Type #N($00), length #N($0A), at #N($08) by #N($97).
N $6FA2 Tiles #N($49), #N($93).
B $6FA2,$01,$01 Prefix bytes.
B $6FA3,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6FA4,$05,$05 Type #N($07), length #N($0A), at #N($08) by #N($3B).
B $6FA9,$05,$05 Type #N($00), length #N($04), at #N($08) by #N($97).
B $6FAE,$03,$03 Type #N($04), length #N($04), at #N($98) by #N($B7).
N $6FB1 Tiles #N($4A), #N($83), #N($85), #N($94).
B $6FB1,$03,$01 Prefix bytes.
B $6FB4,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6FB5,$05,$05 Type #N($07), length #N($03), at #N($08) by #N($3B).
B $6FBA,$03,$03 Type #N($0B), length #N($03), at #N($70) by #N($4F).
B $6FBD,$03,$03 Type #N($0C), length #N($05), at #N($A0) by #N($77).
B $6FC0,$03,$03 Type #N($0E), length #N($04), at #N($A8) by #N($B7).
N $6FC3 Tiles #N($4B), #N($77), #N($95).
B $6FC3,$02,$01 Prefix bytes.
B $6FC5,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6FC6,$05,$05 Type #N($00), length #N($04), at #N($08) by #N($97).
B $6FCB,$03,$03 Type #N($0E), length #N($06), at #N($A8) by #N($77).
B $6FCE,$03,$03 Type #N($01), length #N($04), at #N($68) by #N($97).
N $6FD1 Tiles #N($4C), #N($84).
B $6FD1,$01,$01 Prefix bytes.
B $6FD2,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6FD3,$05,$05 Type #N($07), length #N($0A), at #N($08) by #N($3B).
N $6FD8 Tiles #N($4D), #N($98).
B $6FD8,$01,$01 Prefix bytes.
B $6FD9,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6FDA,$05,$05 Type #N($07), length #N($06), at #N($08) by #N($3B).
B $6FDF,$05,$05 Type #N($00), length #N($04), at #N($88) by #N($97).
B $6FE4,$03,$03 Type #N($0F), length #N($01), at #N($A0) by #N($27).
B $6FE7,$03,$03 Type #N($09), length #N($02), at #N($98) by #N($37).
B $6FEA,$03,$03 Type #N($01), length #N($04), at #N($48) by #N($B7).
N $6FED Tiles #N($4E), #N($A2).
B $6FED,$01,$01 Prefix bytes.
B $6FEE,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6FEF,$05,$05 Type #N($07), length #N($02), at #N($B8) by #N($3B).
B $6FF4,$03,$03 Type #N($09), length #N($0A), at #N($08) by #N($B7).
B $6FF7,$03,$03 Type #N($08), length #N($06), at #N($58) by #N($67).
N $6FFA Tiles #N($4F), #N($A3).
B $6FFA,$01,$01 Prefix bytes.
B $6FFB,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $6FFC,$05,$05 Type #N($07), length #N($08), at #N($08) by #N($3B).
B $7001,$03,$03 Type #N($09), length #N($04), at #N($C8) by #N($37).
N $7004 Tiles #N($50), #N($97).
B $7004,$01,$01 Prefix bytes.
B $7005,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $7006,$03,$03 Type #N($0E), length #N($02), at #N($A8) by #N($37).
B $7009,$03,$03 Type #N($0D), length #N($08), at #N($E0) by #N($B7).
N $700C Tiles #N($51), #N($75), #N($78), #N($96).
B $700C,$03,$01 Prefix bytes.
B $700F,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $7010,$03,$03 Type #N($0B), length #N($08), at #N($78) by #N($57).
B $7013,$03,$03 Type #N($0C), length #N($04), at #N($A0) by #N($77).
B $7016,$03,$03 Type #N($0E), length #N($04), at #N($A8) by #N($B7).
N $7019 Tiles #N($52), #N($81), #N($A1).
B $7019,$02,$01 Prefix bytes.
B $701B,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $701C,$03,$03 Type #N($01), length #N($04), at #N($A8) by #N($77).
B $701F,$03,$03 Type #N($0E), length #N($04), at #N($A8) by #N($B7).
N $7022 Tiles #N($53).
B $7022,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $7023,$03,$03 Type #N($0C), length #N($04), at #N($E0) by #N($37).
N $7026 Tiles #N($54).
B $7026,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $7027,$05,$05 Type #N($07), length #N($0A), at #N($08) by #N($3B).
N $702C Tiles #N($55), #N($8C).
B $702C,$01,$01 Prefix bytes.
B $702D,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $702E,$05,$05 Type #N($00), length #N($04), at #N($48) by #N($37).
B $7033,$03,$03 Type #N($04), length #N($04), at #N($38) by #N($37).
B $7036,$03,$03 Type #N($01), length #N($04), at #N($A8) by #N($37).
N $7039 Tiles #N($56), #N($7D), #N($9A).
B $7039,$02,$01 Prefix bytes.
B $703B,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $703C,$05,$05 Type #N($00), length #N($04), at #N($48) by #N($97).
B $7041,$03,$03 Type #N($01), length #N($04), at #N($08) by #N($B7).
B $7044,$03,$03 Type #N($05), length #N($04), at #N($C0) by #N($B7).
N $7047 Tiles #N($57), #N($80), #N($A0).
B $7047,$02,$01 Prefix bytes.
B $7049,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $704A,$03,$03 Type #N($0E), length #N($0A), at #N($A8) by #N($B7).
N $704D Tiles #N($58), #N($74), #N($9F).
B $704D,$02,$01 Prefix bytes.
B $704F,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $7050,$03,$03 Type #N($01), length #N($04), at #N($A8) by #N($37).
B $7053,$03,$03 Type #N($0E), length #N($08), at #N($A8) by #N($B7).
N $7056 Tiles #N($5B), #N($9D).
B $7056,$01,$01 Prefix bytes.
B $7057,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $7058,$03,$03 Type #N($0E), length #N($04), at #N($88) by #N($57).
B $705B,$03,$03 Type #N($0C), length #N($04), at #N($A0) by #N($77).
B $705E,$03,$03 Type #N($0E), length #N($04), at #N($A8) by #N($B7).
N $7061 Tiles #N($5C).
B $7061,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $7062,$03,$03 Type #N($0F), length #N($0A), at #N($40) by #N($B7).
B $7065,$03,$03 Type #N($0E), length #N($0A), at #N($A8) by #N($B7).
N $7068 Tiles #N($5D), #N($A4).
B $7068,$01,$01 Prefix bytes.
B $7069,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $706A,$03,$03 Type #N($0F), length #N($06), at #N($40) by #N($77).
B $706D,$03,$03 Type #N($09), length #N($08), at #N($08) by #N($B7).
B $7070,$03,$03 Type #N($0E), length #N($02), at #N($A8) by #N($37).
B $7073,$03,$03 Type #N($0C), length #N($08), at #N($E0) by #N($77).
N $7076 Tiles #N($5E).
B $7076,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $7077,$03,$03 Type #N($09), length #N($0C), at #N($48) by #N($77).
B $707A,$03,$03 Type #N($0F), length #N($04), at #N($48) by #N($B7).
B $707D,$03,$03 Type #N($02), length #N($08), at #N($A8) by #N($97).
B $7080,$03,$03 Type #N($0E), length #N($02), at #N($A8) by #N($B7).
N $7083 Tiles #N($5F), #N($88).
B $7083,$01,$01 Prefix bytes.
B $7084,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $7085,$05,$05 Type #N($07), length #N($07), at #N($40) by #N($3B).
B $708A,$05,$05 Type #N($00), length #N($07), at #N($40) by #N($97).
B $708F,$03,$03 Type #N($0F), length #N($03), at #N($20) by #N($7F).
B $7092,$03,$03 Type #N($05), length #N($03), at #N($38) by #N($97).
B $7095,$03,$03 Type #N($09), length #N($03), at #N($28) by #N($4F).
N $7098 Tiles #N($60).
B $7098,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $7099,$03,$03 Type #N($05), length #N($08), at #N($40) by #N($77).
B $709C,$03,$03 Type #N($0F), length #N($04), at #N($40) by #N($B7).
B $709F,$03,$03 Type #N($02), length #N($08), at #N($A8) by #N($97).
B $70A2,$03,$03 Type #N($0E), length #N($02), at #N($A8) by #N($B7).
N $70A5 Tiles #N($62), #N($9E).
B $70A5,$01,$01 Prefix bytes.
B $70A6,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $70A7,$05,$05 Type #N($07), length #N($07), at #N($40) by #N($3B).
B $70AC,$05,$05 Type #N($00), length #N($08), at #N($28) by #N($97).
B $70B1,$03,$03 Type #N($0B), length #N($03), at #N($28) by #N($2F).
B $70B4,$03,$03 Type #N($0C), length #N($01), at #N($38) by #N($37).
B $70B7,$03,$03 Type #N($05), length #N($04), at #N($20) by #N($97).
N $70BA Tiles #N($63).
B $70BA,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $70BB,$03,$03 Type #N($0F), length #N($06), at #N($40) by #N($77).
B $70BE,$03,$03 Type #N($09), length #N($08), at #N($08) by #N($B7).
N $70C1 Tiles #N($64).
B $70C1,$01,$01 Number of segments: #N(#PEEK(#PC)).
B $70C2,$05,$05 Type #N($00), length #N($02), at #N($60) by #N($37).
B $70C7,$05,$05 Type #N($07), length #N($02), at #N($60) by #N($9B).
B $70CC,$03,$03 Type #N($03), length #N($03), at #N($48) by #N($67).
B $70CF,$03,$03 Type #N($0D), length #N($03), at #N($58) by #N($97).
B $70D2,$03,$03 Type #N($06), length #N($03), at #N($A0) by #N($67).
B $70D5,$03,$03 Type #N($0A), length #N($03), at #N($90) by #N($97).

b $70D8 Tune: Title Screen
@ $70D8 label=TuneTitleScreen
D $70D8 The notes of the tune that plays on the title screen, which end with
. #N($FF).
B $70D8,$FB,$08

c $71D3 Make Click
@ $71D3 label=MakeClick
D $71D3 Makes a click with the speaker: the speaker is on for a time that is
. set by #REGb and off for a time that is set by #REGd. #R$7297 uses it to make
. noise.
. .
. #HTML(#AUDIO0(click.wav)(#INCLUDE(Click)))
E $71D3 View the equivalent code in;
. #LIST
. { #BUBBLER$9E86 }
. LIST#
R $71D3 B Length of the time that the speaker is on
R $71D3 D Length of the time that the speaker is off
  $71D3,$02 Turn the speaker on.
  $71D5,$02 Send that to the speaker.
@ $71D7 label=MakeClick_Delay
  $71D7,$02 Hold the speaker on for the time in #REGb.
  $71D9,$01 Turn the speaker off.
  $71DA,$02 Send that to the speaker.
  $71DC,$01 The off-time becomes the delay.
@ $71DD label=MakeClick_Wait
  $71DD,$02 Hold the speaker off for that time.
  $71DF,$01 Return.

c $71E0 Play Square Wave
@ $71E0 label=PlaySquareWave
D $71E0 Makes one cycle of a square wave with the speaker. The speaker is on
. for as long as it is off, which is set by #REGb: the higher it is, the lower
. the note.
. .
. #HTML(#AUDIO0(beep.wav)(#INCLUDE(Beep)))
E $71E0 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B702 }
. { #BUBBLER$9E93 }
. { #GUNFRIGHT$AF66 }
. { #KNIGHTLORE$B4ED }
. { #MARTIANOIDS$C062 }
. { #NIGHTSHADE$C471 }
. { #PENTAGRAM$D682 }
. LIST#
R $71E0 B Half the length of the cycle
R $71E0 O:B Unchanged
  $71E0,$02 Turn the speaker on.
  $71E2,$02 Send that to the speaker.
  $71E4,$01 Keep the half-period.
@ $71E5 label=PlaySquareWave_Delay
  $71E5,$02 Hold this half of the cycle.
  $71E7,$01 Restore the half-period.
  $71E8,$01 Turn the speaker off.
  $71E9,$02 Send that to the speaker.
  $71EB,$01 Keep the half-period again.
@ $71EC label=PlaySquareWave_Wait
  $71EC,$02 Hold the other half of the cycle.
  $71EE,$01 Restore the half-period.
  $71EF,$01 Return.

c $71F0 Play Arrival Sound
@ $71F0 label=PlayArrivalSound
D $71F0 Plays the sound that goes with the end of the scroll at the start of a
. life, which is a rising sweep of #N($20) beeps. The entry point at #R$71F4
. makes the beeps for any sweep.
. .
. #HTML(#AUDIO0(arrival-sound.wav)(#INCLUDE(ArrivalSound)))
R $71F4 C Number of beeps
R $71F4 D Pitch of the last beep
  $71F0,$02 The arrival sweep has #N($20) beeps.
  $71F2,$02 The lowest beep has half-period #N$70.
@ $71F4 label=PlaySweep
  $71F4,$01 The pitch starts at the number of beeps left.
  $71F5,$01 Add the base pitch.
  $71F6,$01 That is the half-period of this beep.
  $71F7,$03 Call #R$71E0.
  $71FA,$01 One beep of the sweep has been played.
  $71FB,$02 Jump to #R$71F4 if the zero flag is clear.
  $71FD,$01 Return.

c $71FE Play Pick-Up Sound
@ $71FE label=PlayPickUpSound
D $71FE Plays the sound of the ship picking up an object, which is a rising
. sweep of #N($10) beeps.
. .
. #HTML(#AUDIO0(pick-up-sound.wav)(#INCLUDE(PickUpSound)))
  $71FE,$02 The pick-up sweep has #N($10) beeps.
  $7200,$02 The lowest beep has half-period #N$40.
  $7202,$02 Jump to #R$71F4.

c $7204 Play Unused Sound
@ $7204 label=PlayUnusedSound
D $7204 Not used. Makes a noise of #N($17) clicks.
. .
. #HTML(#AUDIO0(unused-sound.wav)(#INCLUDE(UnusedSound)))
  $7204,$02 The unused noise has #N($17) clicks.
  $7206,$01 Use that count as the click pattern.
  $7207,$03 Jump to #R$7297.

c $720A Play Object Warble
@ $720A label=PlayObjectWarble
D $720A Does nothing once the ship is exploding (the counter at #R$8F53 is
. #N($0A) or more). Otherwise it makes a warble that depends on the age of the
. object at offset #N($15) of #REGix, and then carries on at #R$7217.
. .
. #HTML(#AUDIO0(object-warble.wav)(#INCLUDE(ObjectWarble)))
E $720A Continue on to #R$7217.
R $720A IX Address of the object
  $720A,$03 The ship state.
  $720D,$03 Return if #REGa is #N$0A or more.
  $7210,$03 Read offset #N$15 of #REGix.
  $7213,$02,b$01 Keep the bits of #REGa that are set in #N$3F.
  $7215,$02 Rotate #REGa right through the carry.

c $7217 Play Warble
@ $7217 label=PlayWarble
D $7217 Makes a warble of four beeps that alternate between two notes. Nothing
. is played if the stage is #N($10) or more or is #N($07) or #N($08).
. .
. #HTML(#AUDIO0(warble.wav)(#INCLUDE(Warble)))
R $7217 A Stage
  $7217,$03 Return if #REGa is #N$10 or more.
  $721A,$04 Jump to #R$7221 if #REGa is less than #N$07.
  $721E,$03 Return if #REGa is less than #N$09.
@ $7221 label=PlayWarble_Play
  $7221,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $7223,$01 Double the stage to spread the two notes.
  $7224,$02 Add the base pitch of the warble.
  $7226,$01 That is the first half-period.
  $7227,$02 The warble is four beeps.
@ $7229 label=PlayWarble_Loop
  $7229,$01 Start from the current half-period.
  $722A,$02,b$01 Flip the bits of #REGa that are set in #N$2A.
  $722C,$01 Keep the note for the next beep.
  $722D,$03 Call #R$71E0.
  $7230,$01 One beep of the warble has been played.
  $7231,$02 Jump to #R$7229 if the zero flag is clear.
  $7233,$01 Return.

c $7234 Play Flutter Sound
@ $7234 label=PlayFlutterSound
D $7234 Plays a flutter of beeps for which the length and the notes depend on
. the frame counter.
. .
. #HTML(#AUDIO0(flutter-sound.wav)(#INCLUDE(FlutterSound)))
  $7234,$03 The frame counter.
  $7237,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $7239,$01 The flutter is at least one beep long.
  $723A,$01 Double the length of the flutter.
  $723B,$01 Double the length again.
  $723C,$01 Double the length once more.
  $723D,$01 That many half-periods will be played.
@ $723E label=PlayFlutterSound_Loop
  $723E,$01 The next note starts from the count left.
  $723F,$02,b$01 Flip the bits of #REGa that are set in #N$07.
  $7241,$01 The half-period is one more than the count.
  $7242,$01 That is the half-period of this beep.
  $7243,$03 Call #R$71E0.
  $7246,$01 One count of the flutter has been used.
  $7247,$01 Return if the zero flag is set.
  $7248,$01 A second count has been used.
  $7249,$01 Return if the zero flag is set.
  $724A,$02 Jump to #R$723E.

c $724C Play Hit Sound
@ $724C label=PlayHitSound
D $724C Plays a falling note of #N($10) beeps. It is used when an object is
. hit, destroyed or damaged.
. .
. #HTML(#AUDIO0(hit-sound.wav)(#INCLUDE(HitSound)))
  $724C,$02 The falling note has #N($10) beeps.
@ $724E label=PlayHitSound_Loop
  $724E,$01 The pitch starts at the number of beeps left.
  $724F,$01 Double it.
  $7250,$01 Double it again, so the note falls quickly.
  $7251,$01 Invert it so the note falls as the count does.
  $7252,$02,b$01 Keep the bits of #REGa that are set in #N$7F.
  $7254,$01 That is the half-period of this beep.
  $7255,$03 Call #R$71E0.
  $7258,$01 One beep of the falling note has been played.
  $7259,$02 Jump to #R$724E if the zero flag is clear.
  $725B,$01 Return.

c $725C Play Change Sound
@ $725C label=PlayChangeSound
D $725C Plays a rising sweep of #N($0A) beeps. It is used when the colour of
. the ship changes.
. .
. #HTML(#AUDIO0(change-sound.wav)(#INCLUDE(ChangeSound)))
  $725C,$02 The colour-change sweep has #N($0A) beeps.
  $725E,$02 The lowest beep has half-period #N$80.
  $7260,$03 Jump to #R$71F4.

c $7263 Play Bump Sound
@ $7263 label=PlayBumpSound
D $7263 Plays #N($0F) beeps that alternate between a very low note and a high
. note. It is used when an object hits the terrain.
. .
. #HTML(#AUDIO0(bump-sound.wav)(#INCLUDE(BumpSound)))
  $7263,$02 The bump is #N($0F) beeps.
@ $7265 label=PlayBumpSound_Loop
  $7265,$01 Take the number of beeps still left.
  $7266,$02,b$01 Flip the bits of #REGa that are set in #N$02.
  $7268,$02,b$01 Keep the bits of #REGa that are set in #N$04.
  $726A,$01 Double the selected pitch.
  $726B,$01 Double it again.
  $726C,$01 Double it once more.
  $726D,$01 That is the half-period of this beep.
  $726E,$03 Call #R$71E0.
  $7271,$01 One beep of the bump has been played.
  $7272,$02 Jump to #R$7265 if the zero flag is clear.
  $7274,$01 Return.

c $7275 Play Moving Sound
@ $7275 label=PlayMovingSound
D $7275 Used by an object while it moves. Does nothing on even frames. If bit 6
. of offset #N($16) of the object is clear it plays a short sweep. If not it
. plays a different sweep, but only once every four frames.
. .
. #HTML(#AUDIO0(moving-sound.wav)(#INCLUDE(MovingSound)))
R $7275 IX Address of the object
  $7275,$03 The frame counter.
  $7278,$02,b$01 Keep the bits of #REGa that are set in #N$01.
  $727A,$01 Return if the zero flag is set.
  $727B,$02 The short sweep has four beeps.
  $727D,$02 Its lowest beep has half-period #N$0F.
  $727F,$07 Jump to #R$71F4 if bit 6 of offset #N$16 of #REGix is clear.
  $7286,$03 The frame counter.
  $7289,$02,b$01 Keep the bits of #REGa that are set in #N$03.
  $728B,$01 Return if the zero flag is clear.
  $728C,$02 The other sweep has three beeps.
  $728E,$02 Its lowest beep has half-period #N$1B.
  $7290,$03 Jump to #R$71F4.

c $7293 Play Crash Sound
@ $7293 label=PlayCrashSound
D $7293 Plays a burst of noise of #N($1C) clicks. It is used when the ship hits
. the terrain. The entry point at #R$7297 makes the noise for any number of
. clicks.
. .
. #HTML(#AUDIO0(crash-sound.wav)(#INCLUDE(CrashSound)))
E $7293 View the equivalent code in;
. #LIST
. { #BUBBLER$9ED1 }
. LIST#
R $7297 C Number of clicks
R $7297 E Pattern for the lengths of the clicks
  $7293,$02 The crash is #N($1C) clicks.
@ $7295 label=PlayCrashSound_Pattern
  $7295,$02 The crash uses pattern #N$27.
@ $7297 label=PlayNoise
  $7297,$01 The click length starts from the clicks left.
  $7298,$01 Flip the bits of #REGa that are set in #REGe.
  $7299,$01 Double it to make the on-time.
  $729A,$01 That on-time is passed to the click.
  $729B,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $729D,$01 The low five bits are the off-time.
  $729E,$03 Call #R$71D3.
  $72A1,$01 One click of the noise has been played.
  $72A2,$02 Jump to #R$7297 if the zero flag is clear.
  $72A4,$01 Return.

c $72A5 Play Short Crash Sound
@ $72A5 label=PlayShortCrashSound
D $72A5 Plays a shorter burst of noise of eight clicks.
. .
. #HTML(#AUDIO0(short-crash-sound.wav)(#INCLUDE(ShortCrashSound)))
  $72A5,$02 The short crash is eight clicks.
  $72A7,$02 It uses pattern #N$03.
  $72A9,$02 Jump to #R$7297.

c $72AB Play Explosion Sound
@ $72AB label=PlayExplosionSound
D $72AB Plays the sound of the explosion of the ship, for each step of the
. counter at #R$8F53 until it reaches #N($2D). It makes a warble first and then
. either a falling note (every eighth step), noise (on the odd steps) or
. nothing.
. .
. #HTML(#AUDIO0(explosion-sound.wav)(#INCLUDE(ExplosionSound)))
  $72AB,$03 The ship state.
  $72AE,$03 Return if #REGa is #N$2D or more.
  $72B1,$02 Subtract #N$0A from #REGa.
  $72B3,$03 Call #R$7217.
  $72B6,$03 The ship state.
  $72B9,$01 Keep the explosion step.
  $72BA,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $72BC,$02 Jump to #R$72CA if the zero flag is set.
  $72BE,$03 Return if bit 0 of #REGb is clear.
  $72C1,$01 The pattern comes from the step.
  $72C2,$02 Shift #REGa right.
  $72C4,$01 That is the click pattern.
  $72C5,$02 This step of the explosion is #N($0B) clicks.
  $72C7,$03 Jump to #R$7297.

c $72CA Play Explosion Hit Sound
@ $72CA label=PlayExplosionHitSound
D $72CA Plays a falling note of seven beeps, which #R$72AB uses every eighth
. step.
. .
. #HTML(#AUDIO0(explosion-hit-sound.wav)(#INCLUDE(ExplosionHitSound)))
  $72CA,$02 The eighth step is a falling note of seven beeps.
  $72CC,$03 Jump to #R$724E.

c $72CF Play Beam Sound
@ $72CF label=PlayBeamSound
D $72CF Plays the noise of a beam, using clicks that depend on the first three
. bytes of the object of the beam.
. .
. #HTML(#AUDIO0(beam-sound.wav)(#INCLUDE(BeamSound)))
R $72CF IX Address of the beam
  $72CF,$03 Read offset #N$00 of #REGix.
  $72D2,$03 Flip the bits of #REGa that are set in the byte at offset #N$01 of
. #REGix.
  $72D5,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $72D7,$02 Add #N$08 to #REGa.
  $72D9,$01 That is the number of clicks in the beam.
  $72DA,$03 Read offset #N$02 of #REGix.
  $72DD,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $72DF,$01 The third byte is the click pattern.
@ $72E0 label=PlayBeamSound_Loop
  $72E0,$01 Mix the clicks still left with the pattern.
  $72E1,$01 #REGa gains #REGe.
  $72E2,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $72E4,$01 Double the mixed value.
  $72E5,$01 Keep it as the on-time.
  $72E6,$01 The off-time starts from the pattern.
  $72E7,$01 #REGa gains #REGb.
  $72E8,$01 Double the sum.
  $72E9,$01 Subtract #REGb from #REGa.
  $72EA,$01 That is the off-time of this click.
  $72EB,$03 Call #R$71D3.
  $72EE,$01 One click of the beam has been played.
  $72EF,$02 Jump to #R$72E0 if the zero flag is clear.
  $72F1,$01 Return.

c $72F2 Play Shot Sound
@ $72F2 label=PlayShotSound
D $72F2 Plays noise that is used when a shot starts. The noise is different if
. bit 7 of offset #N($16) of the object is set.
. .
. #HTML(#AUDIO0(shot-sound.wav)(#INCLUDE(ShotSound)))
R $72F2 IX Address of the object
  $72F2,$02 A normal shot is #N($0F) clicks.
  $72F4,$02 It uses pattern #N$17.
  $72F6,$07 Jump to #R$7297 if bit 7 of offset #N$16 of #REGix is clear.
  $72FD,$01 The other shot uses the pattern as its length.
  $72FE,$02 And pattern #N$20.
  $7300,$03 Jump to #R$7297.

c $7303 Play Patterned Noise
@ $7303 label=PlayPatternedNoise
D $7303 Plays noise for which the number of clicks and the pattern depend on a
. number.
. .
. #HTML(#AUDIO0(patterned-noise.wav)(#INCLUDE(PatternedNoise)))
R $7303 A Number from #N($00) to #N($03)
  $7303,$02 Add #N$02 to #REGa.
  $7305,$01 Double the value.
  $7306,$01 Double it again to get the number of clicks.
  $7307,$01 That is how many clicks are played.
  $7308,$01 Invert #REGa.
  $7309,$02 Add #N$06 to #REGa.
  $730B,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $730D,$01 That is the click pattern.
  $730E,$03 Jump to #R$7297.

c $7311 Play Noise Burst
@ $7311 label=PlayNoiseBurst
D $7311 Plays a burst of noise of ten clicks.
. .
. #HTML(#AUDIO0(noise-burst.wav)(#INCLUDE(NoiseBurst)))
  $7311,$02 The burst is ten clicks.
  $7313,$02 It uses pattern #N$22.
  $7315,$03 Jump to #R$7297.

c $7318 Play Removal Sound
@ $7318 label=PlayRemovalSound
D $7318 Plays a rising sweep of ten beeps. It is used when an object is
. removed.
. .
. #HTML(#AUDIO0(removal-sound.wav)(#INCLUDE(RemovalSound)))
  $7318,$02 The removal sweep has ten beeps.
  $731A,$02 The lowest beep has half-period #N$18.
  $731C,$03 Jump to #R$71F4.

b $731F Sprite: Item 0
@ $731F label=SpriteItem0
D $731F The sprite of item #N$00 that the ship can carry (see #R$AF7B).
  $731F,$01 Width = #N(#PEEK(#PC)) bytes.
  $7320,$01 Height = #N(#PEEK(#PC)) pixels.
  $7321,$18,$03 #SPRITEDATA(item-00*)

b $7339 Sprite: Item 1
@ $7339 label=SpriteItem1
D $7339 The sprite of item #N$01 that the ship can carry (see #R$AF7B).
  $7339,$01 Width = #N(#PEEK(#PC)) bytes.
  $733A,$01 Height = #N(#PEEK(#PC)) pixels.
  $733B,$18,$03 #SPRITEDATA(item-01*)

b $7353 Sprite: Item 2
@ $7353 label=SpriteItem2
D $7353 The sprite of item #N$02 that the ship can carry (see #R$AF7B).
  $7353,$01 Width = #N(#PEEK(#PC)) bytes.
  $7354,$01 Height = #N(#PEEK(#PC)) pixels.
  $7355,$33,$03 #SPRITEDATA(item-02*)

b $7388 Sprite: Item 3
@ $7388 label=SpriteItem3
D $7388 The sprite of item #N$03 that the ship can carry (see #R$AF7B).
  $7388,$01 Width = #N(#PEEK(#PC)) bytes.
  $7389,$01 Height = #N(#PEEK(#PC)) pixels.
  $738A,$30,$03 #SPRITEDATA(item-03*)

b $73BA Sprite: Right Blade
@ $73BA label=SpriteItem4
D $73BA The sprite of item #N$04 that the ship can carry (see #R$AF7B).
. .
. It is drawn as a blade running up to the right.
  $73BA,$01 Width = #N(#PEEK(#PC)) bytes.
  $73BB,$01 Height = #N(#PEEK(#PC)) pixels.
  $73BC,$20,$02 #SPRITEDATA(item-04*)

b $73DC Sprite: Left Blade
@ $73DC label=SpriteItem5
D $73DC The sprite of item #N$05 that the ship can carry (see #R$AF7B).
. .
. It is drawn as a blade running up to the left.
  $73DC,$01 Width = #N(#PEEK(#PC)) bytes.
  $73DD,$01 Height = #N(#PEEK(#PC)) pixels.
  $73DE,$20,$02 #SPRITEDATA(item-05*)

b $73FE Sprite: Arrowhead
@ $73FE label=SpriteItem7
D $73FE The sprite of item #N$07 that the ship can carry (see #R$AF7B).
. .
. It is drawn as an arrowhead pointing up.
  $73FE,$01 Width = #N(#PEEK(#PC)) bytes.
  $73FF,$01 Height = #N(#PEEK(#PC)) pixels.
  $7400,$36,$03 #SPRITEDATA(item-07*)

b $7436 Sprite: Type 0C Frame 09
@ $7436 label=SpriteType0C_Frame09
D $7436 A sprite for objects of type #N$0C: it is used when the bottom four
. bits of offset #N($13) are #N$09 (see #R$ADBE).
  $7436,$01 Width = #N(#PEEK(#PC)) bytes.
  $7437,$01 Height = #N(#PEEK(#PC)) pixels.
@ $7438 label=SpriteType0C_Frame09Picture
  $7438,$AF,$05 #SPRITEDATA(type-0c-frame-09*)

b $74E7 Sprite: Type 0C Frame 0A
@ $74E7 label=SpriteType0C_Frame0A
D $74E7 A sprite for objects of type #N$0C: it is used when the bottom four
. bits of offset #N($13) are #N$0A (see #R$ADBE).
  $74E7,$01 Width = #N(#PEEK(#PC)) bytes.
  $74E8,$01 Height = #N(#PEEK(#PC)) pixels.
@ $74E9 label=SpriteType0C_Frame0APicture
  $74E9,$8D,$03 #SPRITEDATA(type-0c-frame-0a*)

b $7576 Sprite: Ship Part 8
@ $7576 label=ShipPart8
D $7576 The picture and mask of part #N$08 of the ship, which #R$B09C adds to
. the picture of the ship when the ship has the part.
  $7576,$01 The ship is made at least this tall: #N(#PEEK(#PC)) pixels.
  $7577,$01 Width = #N(#PEEK(#PC)) bytes.
  $7578,$01 Height = #N(#PEEK(#PC)) pixels.
  $7579,$08,$02 #SPRITEDATA(ship-part-08*)
  $7581,$08,$02 The mask of the part.

b $7589 Sprite: Ship Part 6
@ $7589 label=ShipPart6
D $7589 The picture and mask of part #N$06 of the ship, which #R$B09C adds to
. the picture of the ship when the ship has the part.
  $7589,$01 The ship is made at least this tall: #N(#PEEK(#PC)) pixels.
  $758A,$01 Width = #N(#PEEK(#PC)) bytes.
  $758B,$01 Height = #N(#PEEK(#PC)) pixels.
  $758C,$12,$03 #SPRITEDATA(ship-part-06*)
  $759E,$12,$03 The mask of the part.

b $75B0 Sprite: Ship Part 9
@ $75B0 label=ShipPart9
D $75B0 The picture and mask of part #N$09 of the ship, which #R$B09C adds to
. the picture of the ship when the ship has the part. The mask is only three
. rows long, though #R$B09C reads as many rows of it as the picture has, so it
. carries on into the data that follows.
  $75B0,$01 The ship is made at least this tall: #N(#PEEK(#PC)) pixels.
  $75B1,$01 Width = #N(#PEEK(#PC)) bytes.
  $75B2,$01 Height = #N(#PEEK(#PC)) pixels.
  $75B3,$1E,$02 #SPRITEDATA(ship-part-09*)
  $75D1,$06,$02 The first three rows of the mask.

b $75D7 Sprite: Ship Part 7
@ $75D7 label=ShipPart7
D $75D7 The picture and mask of part #N$07 of the ship, which #R$B09C adds to
. the picture of the ship when the ship has the part.
  $75D7,$01 The ship is made at least this tall: #N(#PEEK(#PC)) pixels.
  $75D8,$01 Width = #N(#PEEK(#PC)) bytes.
  $75D9,$01 Height = #N(#PEEK(#PC)) pixels.
  $75DA,$0A,$02 #SPRITEDATA(ship-part-07*)
  $75E4,$0A,$02 The mask of the part.

b $75EE Sprite: Ship Part 4
@ $75EE label=ShipPart4
D $75EE The picture and mask of part #N$04 of the ship, which #R$B09C adds to
. the picture of the ship when the ship has the part.
  $75EE,$01 The ship is made at least this tall: #N(#PEEK(#PC)) pixels.
  $75EF,$01 Width = #N(#PEEK(#PC)) bytes.
  $75F0,$01 Height = #N(#PEEK(#PC)) pixels.
  $75F1,$1C,$02 #SPRITEDATA(ship-part-04*)
  $760D,$1C,$02 The mask of the part.

b $7629 Sprite: Twin Pods
@ $7629 label=ShipPart5
D $7629 The picture and mask of part #N$05 of the ship, which #R$B09C adds to
. the picture of the ship when the ship has the part.
. .
. It is drawn as two round pods side by side.
  $7629,$01 The ship is made at least this tall: #N(#PEEK(#PC)) pixels.
  $762A,$01 Width = #N(#PEEK(#PC)) bytes.
  $762B,$01 Height = #N(#PEEK(#PC)) pixels.
  $762C,$2C,$04 #SPRITEDATA(ship-part-05*)
  $7658,$2C,$04 The mask of the part.

b $7684 Sprite: Right Fin
@ $7684 label=ShipPart1
D $7684 The picture and mask of part #N$01 of the ship, which #R$B09C adds to
. the picture of the ship when the ship has the part.
. .
. It is drawn as a curved fin, the mirror of #R$76B6.
  $7684,$01 The ship is made at least this tall: #N(#PEEK(#PC)) pixels.
  $7685,$01 Width = #N(#PEEK(#PC)) bytes.
  $7686,$01 Height = #N(#PEEK(#PC)) pixels.
  $7687,$2E,$02 #SPRITEDATA(ship-part-01*)
  $76B5,$01 No mask: #N$FF here tells #R$B09C to skip the mask.

b $76B6 Sprite: Left Fin
@ $76B6 label=ShipPart2
D $76B6 The picture and mask of part #N$02 of the ship, which #R$B09C adds to
. the picture of the ship when the ship has the part.
. .
. It is drawn as a curved fin, the mirror of #R$7684.
  $76B6,$01 The ship is made at least this tall: #N(#PEEK(#PC)) pixels.
  $76B7,$01 Width = #N(#PEEK(#PC)) bytes.
  $76B8,$01 Height = #N(#PEEK(#PC)) pixels.
  $76B9,$2E,$02 #SPRITEDATA(ship-part-02*)
  $76E7,$01 No mask: #N$FF here tells #R$B09C to skip the mask.

b $76E8 Sprite: Engine Ring
@ $76E8 label=ShipPart3
D $76E8 The picture and mask of part #N$03 of the ship, which #R$B09C adds to
. the picture of the ship when the ship has the part. This is also item #N$06
. that the ship can carry (see #R$AF7B). The mask of the part is the data at
. #R$7721, which is not #N$FF.
. .
. It is drawn as a symmetrical ring.
  $76E8,$01 The ship is made at least this tall: #N(#PEEK(#PC)) pixels.
  $76E9,$01 Width = #N(#PEEK(#PC)) bytes.
  $76EA,$01 Height = #N(#PEEK(#PC)) pixels.
  $76EB,$36,$03 #SPRITEDATA(ship-part-03*)

b $7721 Stack Graphic
@ $7721 label=StackGraphic
D $7721 The picture of the units that the ship carries as a stack: eighteen
. rows of two bytes, with no width or height. #R$A8D9 copies as many rows as
. the stack is high (see #R$C905) into the ship work area at #R$F6B9 (starting
. at #N($F6BB)), each six bytes after the last. The data follows the picture of
. ship part 3, so #R$B09C also reads it as the mask of that part.
  $7721,$24,$02

b $7745 Sprite: Item 8
@ $7745 label=SpriteItem8
D $7745 The sprite of item #N$08 that the ship can carry (see #R$AF7B).
  $7745,$01 Width = #N(#PEEK(#PC)) bytes.
  $7746,$01 Height = #N(#PEEK(#PC)) pixels.
  $7747,$36,$03 #SPRITEDATA(item-08*)

b $777D Sprite: Type 0C Frame 0B
@ $777D label=SpriteType0C_Frame0B
D $777D A sprite for objects of type #N$0C: it is used when the bottom four
. bits of offset #N($13) are #N$0B (see #R$ADBE).
  $777D,$01 Width = #N(#PEEK(#PC)) bytes.
  $777E,$01 Height = #N(#PEEK(#PC)) pixels.
  $777F,$69,$03 #SPRITEDATA(type-0c-frame-0b*)

b $77E8 Sprite: Type 0C Frame 0C
@ $77E8 label=SpriteType0C_Frame0C
D $77E8 A sprite for objects of type #N$0C: it is used when the bottom four
. bits of offset #N($13) are #N$0C (see #R$ADBE).
  $77E8,$01 Width = #N(#PEEK(#PC)) bytes.
  $77E9,$01 Height = #N(#PEEK(#PC)) pixels.
  $77EA,$5C,$04 #SPRITEDATA(type-0c-frame-0c*)

b $7846 Object Graphics
@ $7846 label=ObjectGraphics
D $7846 Graphic data for the objects of type #N$0E to #N$12 (see #R$AF3D), one
. block for each type, which are #N($21), #N($1F), #N($1D), #N($41) and #N($21)
. bytes long. The first byte of each is #N($10), #N($0F), #N($0E), #N($10) and
. #N($08). The format has not been worked out.
  $7846,$21,$21 Type #N$0E.
  $7867,$1F,$1F Type #N$0F.
  $7886,$1D,$1D Type #N$10.
  $78A3,$41,$08 Type #N$11.
  $78E4,$21,$08 Type #N$12.

b $7905 Sprite: Type 0C Frame 0E
@ $7905 label=SpriteType0C_Frame0E
D $7905 A sprite for objects of type #N$0C: it is used when the bottom four
. bits of offset #N($13) are #N$0E (see #R$ADBE).
  $7905,$01 Width = #N(#PEEK(#PC)) bytes.
  $7906,$01 Height = #N(#PEEK(#PC)) pixels.
  $7907,$41,$05 #SPRITEDATA(type-0c-frame-0e*)

b $7948 Sprite: Type 13 Frame 00
@ $7948 label=SpriteType13_Frame00
D $7948 A sprite for objects of type #N$13: it is used when the bottom four
. bits of offset #N($13) are #N$00 (see #R$ADBE).
  $7948,$01 Width = #N(#PEEK(#PC)) bytes.
  $7949,$01 Height = #N(#PEEK(#PC)) pixels.
  $794A,$30,$04 #SPRITEDATA(type-13-frame-00*)

b $797A Sprite: Type 13 Frame 01
@ $797A label=SpriteType13_Frame01
D $797A A sprite for objects of type #N$13: it is used when the bottom four
. bits of offset #N($13) are #N$01 (see #R$ADBE).
  $797A,$01 Width = #N(#PEEK(#PC)) bytes.
  $797B,$01 Height = #N(#PEEK(#PC)) pixels.
  $797C,$78,$05 #SPRITEDATA(type-13-frame-01*)

b $79F4 Sprite: Type 14 Frame 00
@ $79F4 label=SpriteType14_Frame00
D $79F4 A sprite for objects of type #N$14: it is used when the bottom four
. bits of offset #N($13) are #N$00 (see #R$ADBE).
  $79F4,$01 Width = #N(#PEEK(#PC)) bytes.
  $79F5,$01 Height = #N(#PEEK(#PC)) pixels.
  $79F6,$33,$03 #SPRITEDATA(type-14-frame-00*)

b $7A29 Sprite: Type 14 Frame 01
@ $7A29 label=SpriteType14_Frame01
D $7A29 A sprite for objects of type #N$14: it is used when the bottom four
. bits of offset #N($13) are #N$01 (see #R$ADBE).
  $7A29,$01 Width = #N(#PEEK(#PC)) bytes.
  $7A2A,$01 Height = #N(#PEEK(#PC)) pixels.
  $7A2B,$33,$03 #SPRITEDATA(type-14-frame-01*)

b $7A5E Sprite: Type 14 Frame 02
@ $7A5E label=SpriteType14_Frame02
D $7A5E A sprite for objects of type #N$14: it is used when the bottom four
. bits of offset #N($13) are #N$02 (see #R$ADBE).
  $7A5E,$01 Width = #N(#PEEK(#PC)) bytes.
  $7A5F,$01 Height = #N(#PEEK(#PC)) pixels.
  $7A60,$33,$03 #SPRITEDATA(type-14-frame-02*)

b $7A93 Sprite: Type 15 Frame 00
@ $7A93 label=SpriteType15_Frame00
D $7A93 A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$00 (see #R$ADBE).
  $7A93,$01 Width = #N(#PEEK(#PC)) bytes.
  $7A94,$01 Height = #N(#PEEK(#PC)) pixels.
  $7A95,$1C,$02 #SPRITEDATA(type-15-frame-00*)

b $7AB1 Sprite: Type 15 Frame 01
@ $7AB1 label=SpriteType15_Frame01
D $7AB1 A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$01 (see #R$ADBE).
  $7AB1,$01 Width = #N(#PEEK(#PC)) bytes.
  $7AB2,$01 Height = #N(#PEEK(#PC)) pixels.
  $7AB3,$1C,$02 #SPRITEDATA(type-15-frame-01*)

b $7ACF Sprite: Type 15 Frame 02
@ $7ACF label=SpriteType15_Frame02
D $7ACF A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$02 (see #R$ADBE).
  $7ACF,$01 Width = #N(#PEEK(#PC)) bytes.
  $7AD0,$01 Height = #N(#PEEK(#PC)) pixels.
  $7AD1,$3F,$03 #SPRITEDATA(type-15-frame-02*)

b $7B10 Sprite: Type 15 Frame 03
@ $7B10 label=SpriteType15_Frame03
D $7B10 A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$03 (see #R$ADBE).
  $7B10,$01 Width = #N(#PEEK(#PC)) bytes.
  $7B11,$01 Height = #N(#PEEK(#PC)) pixels.
  $7B12,$3F,$03 #SPRITEDATA(type-15-frame-03*)

b $7B51 Sprite: Type 16 Frame 0C
@ $7B51 label=SpriteType16_Frame0C
D $7B51 A sprite for objects of type #N$16: it is used when the bottom four
. bits of offset #N($13) are #N$0C (see #R$ADBE).
  $7B51,$01 Width = #N(#PEEK(#PC)) bytes.
  $7B52,$01 Height = #N(#PEEK(#PC)) pixels.
  $7B53,$4B,$03 #SPRITEDATA(type-16-frame-0c*)

b $7B9E Sprite: Type 16 Frame 0D
@ $7B9E label=SpriteType16_Frame0D
D $7B9E A sprite for objects of type #N$16: it is used when the bottom four
. bits of offset #N($13) are #N$0D (see #R$ADBE).
  $7B9E,$01 Width = #N(#PEEK(#PC)) bytes.
  $7B9F,$01 Height = #N(#PEEK(#PC)) pixels.
  $7BA0,$4B,$03 #SPRITEDATA(type-16-frame-0d*)

b $7BEB Sprite: Type 16 Frame 0E
@ $7BEB label=SpriteType16_Frame0E
D $7BEB A sprite for objects of type #N$16: it is used when the bottom four
. bits of offset #N($13) are #N$0E (see #R$ADBE).
  $7BEB,$01 Width = #N(#PEEK(#PC)) bytes.
  $7BEC,$01 Height = #N(#PEEK(#PC)) pixels.
  $7BED,$4B,$03 #SPRITEDATA(type-16-frame-0e*)

b $7C38 Sprite: Type 13 Frame 02
@ $7C38 label=SpriteType13_Frame02
D $7C38 A sprite for objects of type #N$13: it is used when the bottom four
. bits of offset #N($13) are #N$02 (see #R$ADBE).
  $7C38,$01 Width = #N(#PEEK(#PC)) bytes.
  $7C39,$01 Height = #N(#PEEK(#PC)) pixels.
  $7C3A,$20,$02 #SPRITEDATA(type-13-frame-02*)

b $7C5A Sprite: Type 13 Frame 03
@ $7C5A label=SpriteType13_Frame03
D $7C5A A sprite for objects of type #N$13: it is used when the bottom four
. bits of offset #N($13) are #N$03 (see #R$ADBE).
  $7C5A,$01 Width = #N(#PEEK(#PC)) bytes.
  $7C5B,$01 Height = #N(#PEEK(#PC)) pixels.
  $7C5C,$20,$02 #SPRITEDATA(type-13-frame-03*)

b $7C7C Sprite: Type 13 Frame 04
@ $7C7C label=SpriteType13_Frame04
D $7C7C A sprite for objects of type #N$13: it is used when the bottom four
. bits of offset #N($13) are #N$04 (see #R$ADBE).
  $7C7C,$01 Width = #N(#PEEK(#PC)) bytes.
  $7C7D,$01 Height = #N(#PEEK(#PC)) pixels.
  $7C7E,$20,$02 #SPRITEDATA(type-13-frame-04*)

b $7C9E Sprite: Dart 6
@ $7C9E label=SpriteType13_Frame06
D $7C9E A sprite for objects of type #N$13: it is used when the bottom four
. bits of offset #N($13) are #N$06 (see #R$ADBE).
  $7C9E,$01 Width = #N(#PEEK(#PC)) bytes.
  $7C9F,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CA0,$08,$01 #SPRITEDATA(type-13-frame-06*)

b $7CA8 Sprite: Dart 5
@ $7CA8 label=SpriteType13_Frame05
D $7CA8 A sprite for objects of type #N$13: it is used when the bottom four
. bits of offset #N($13) are #N$05 (see #R$ADBE).
  $7CA8,$01 Width = #N(#PEEK(#PC)) bytes.
  $7CA9,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CAA,$08,$01 #SPRITEDATA(type-13-frame-05*)

b $7CB2 Sprite: Dart 8
@ $7CB2 label=SpriteType13_Frame08
D $7CB2 A sprite for objects of type #N$13: it is used when the bottom four
. bits of offset #N($13) are #N$08 (see #R$ADBE).
  $7CB2,$01 Width = #N(#PEEK(#PC)) bytes.
  $7CB3,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CB4,$07,$01 #SPRITEDATA(type-13-frame-08*)

b $7CBB Sprite: Spark
@ $7CBB label=SpriteType13_Frame07
D $7CBB A sprite for objects of type #N$13: it is used when the bottom four
. bits of offset #N($13) are #N$07 (see #R$ADBE).
  $7CBB,$01 Width = #N(#PEEK(#PC)) bytes.
  $7CBC,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CBD,$03,$01 #SPRITEDATA(type-13-frame-07*)

b $7CC0 Sprite: Crystal 0
@ $7CC0 label=SpriteType1D_Frame00
D $7CC0 A sprite for objects of type #N$1D: it is used when the bottom four
. bits of offset #N($13) are #N$00 (see #R$ADBE).
. .
. It is drawn as a faceted crystal.
  $7CC0,$01 Width = #N(#PEEK(#PC)) bytes.
  $7CC1,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CC2,$20,$02 #SPRITEDATA(type-1d-frame-00*)

b $7CE2 Sprite: Crystal 1
@ $7CE2 label=SpriteType1D_Frame01
D $7CE2 A sprite for objects of type #N$1D: it is used when the bottom four
. bits of offset #N($13) are #N$01 (see #R$ADBE).
. .
. It is drawn as a faceted crystal.
  $7CE2,$01 Width = #N(#PEEK(#PC)) bytes.
  $7CE3,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CE4,$20,$02 #SPRITEDATA(type-1d-frame-01*)

b $7D04 Sprite: Crystal 2
@ $7D04 label=SpriteType1D_Frame02
D $7D04 A sprite for objects of type #N$1D: it is used when the bottom four
. bits of offset #N($13) are #N$02 (see #R$ADBE).
. .
. It is drawn as a faceted crystal.
  $7D04,$01 Width = #N(#PEEK(#PC)) bytes.
  $7D05,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D06,$20,$02 #SPRITEDATA(type-1d-frame-02*)

b $7D26 Sprite: Crystal 3
@ $7D26 label=SpriteType1D_Frame03
D $7D26 A sprite for objects of type #N$1D: it is used when the bottom four
. bits of offset #N($13) are #N$03 (see #R$ADBE).
. .
. It is drawn as a faceted crystal.
  $7D26,$01 Width = #N(#PEEK(#PC)) bytes.
  $7D27,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D28,$20,$02 #SPRITEDATA(type-1d-frame-03*)

b $7D48 Sprite: Crystal 4
@ $7D48 label=SpriteType1D_Frame04
D $7D48 A sprite for objects of type #N$1D: it is used when the bottom four
. bits of offset #N($13) are #N$04 (see #R$ADBE).
. .
. It is drawn as a faceted crystal.
  $7D48,$01 Width = #N(#PEEK(#PC)) bytes.
  $7D49,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D4A,$20,$02 #SPRITEDATA(type-1d-frame-04*)

b $7D6A Sprite: Crystal 5
@ $7D6A label=SpriteType1D_Frame05
D $7D6A A sprite for objects of type #N$1D: it is used when the bottom four
. bits of offset #N($13) are #N$05 (see #R$ADBE).
. .
. It is drawn as a faceted crystal.
  $7D6A,$01 Width = #N(#PEEK(#PC)) bytes.
  $7D6B,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D6C,$20,$02 #SPRITEDATA(type-1d-frame-05*)

b $7D8C Sprite: Crystal 6
@ $7D8C label=SpriteType1D_Frame06
D $7D8C A sprite for objects of type #N$1D: it is used when the bottom four
. bits of offset #N($13) are #N$06 (see #R$ADBE).
. .
. It is drawn as a faceted crystal.
  $7D8C,$01 Width = #N(#PEEK(#PC)) bytes.
  $7D8D,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D8E,$42,$03 #SPRITEDATA(type-1d-frame-06*)

b $7DD0 Sprite: Crystal 7
@ $7DD0 label=SpriteType1D_Frame07
D $7DD0 A sprite for objects of type #N$1D: it is used when the bottom four
. bits of offset #N($13) are #N$07 (see #R$ADBE).
. .
. It is drawn as a faceted crystal.
  $7DD0,$01 Width = #N(#PEEK(#PC)) bytes.
  $7DD1,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DD2,$45,$03 #SPRITEDATA(type-1d-frame-07*)

b $7E17 Sprite: Type 0D Frame 09
@ $7E17 label=SpriteType0D_Frame09
D $7E17 A sprite for objects of type #N$0D: it is used when the bottom four
. bits of offset #N($13) are #N$09 (see #R$ADBE).
  $7E17,$01 Width = #N(#PEEK(#PC)) bytes.
  $7E18,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E19,$51,$03 #SPRITEDATA(type-0d-frame-09*)

b $7E6A Sprite: Type 0D Frame 07
@ $7E6A label=SpriteType0D_Frame07
D $7E6A A sprite for objects of type #N$0D: it is used when the bottom four
. bits of offset #N($13) are #N$07 (see #R$ADBE).
  $7E6A,$01 Width = #N(#PEEK(#PC)) bytes.
  $7E6B,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E6C,$27,$03 #SPRITEDATA(type-0d-frame-07*)

b $7E93 Sprite: Type 16 Frame 0A
@ $7E93 label=SpriteType16_Frame0A
D $7E93 A sprite for objects of type #N$16: it is used when the bottom four
. bits of offset #N($13) are #N$0A (see #R$ADBE).
  $7E93,$01 Width = #N(#PEEK(#PC)) bytes.
  $7E94,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E95,$3C,$05 #SPRITEDATA(type-16-frame-0a*)

b $7ED1 Sprite: Type 16 Frame 0B
@ $7ED1 label=SpriteType16_Frame0B
D $7ED1 A sprite for objects of type #N$16: it is used when the bottom four
. bits of offset #N($13) are #N$0B (see #R$ADBE).
  $7ED1,$01 Width = #N(#PEEK(#PC)) bytes.
  $7ED2,$01 Height = #N(#PEEK(#PC)) pixels.
  $7ED3,$3C,$05 #SPRITEDATA(type-16-frame-0b*)

b $7F0F Sprite: Type 15 Frame 0A
@ $7F0F label=SpriteType15_Frame0A
D $7F0F A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$0A (see #R$ADBE).
  $7F0F,$01 Width = #N(#PEEK(#PC)) bytes.
  $7F10,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F11,$1C,$02 #SPRITEDATA(type-15-frame-0a*)

b $7F2D Sprite: Type 15 Frame 0B
@ $7F2D label=SpriteType15_Frame0B
D $7F2D A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$0B (see #R$ADBE).
  $7F2D,$01 Width = #N(#PEEK(#PC)) bytes.
  $7F2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F2F,$1A,$02 #SPRITEDATA(type-15-frame-0b*)

b $7F49 Sprite: Type 15 Frame 06
@ $7F49 label=SpriteType15_Frame06
D $7F49 A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$06 (see #R$ADBE).
  $7F49,$01 Width = #N(#PEEK(#PC)) bytes.
  $7F4A,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F4B,$1E,$03 #SPRITEDATA(type-15-frame-06*)

b $7F69 Sprite: Type 15 Frame 07
@ $7F69 label=SpriteType15_Frame07
D $7F69 A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$07 (see #R$ADBE).
  $7F69,$01 Width = #N(#PEEK(#PC)) bytes.
  $7F6A,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F6B,$1E,$03 #SPRITEDATA(type-15-frame-07*)

b $7F89 Sprite: Type 15 Frame 08
@ $7F89 label=SpriteType15_Frame08
D $7F89 A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$08 (see #R$ADBE).
  $7F89,$01 Width = #N(#PEEK(#PC)) bytes.
  $7F8A,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F8B,$1E,$03 #SPRITEDATA(type-15-frame-08*)

b $7FA9 Sprite: Type 15 Frame 09
@ $7FA9 label=SpriteType15_Frame09
D $7FA9 A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$09 (see #R$ADBE).
  $7FA9,$01 Width = #N(#PEEK(#PC)) bytes.
  $7FAA,$01 Height = #N(#PEEK(#PC)) pixels.
  $7FAB,$1E,$03 #SPRITEDATA(type-15-frame-09*)

b $7FC9 Sprite: Type 15 Frame 0C
@ $7FC9 label=SpriteType15_Frame0C
D $7FC9 A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$0C (see #R$ADBE).
  $7FC9,$01 Width = #N(#PEEK(#PC)) bytes.
  $7FCA,$01 Height = #N(#PEEK(#PC)) pixels.
  $7FCB,$24,$02 #SPRITEDATA(type-15-frame-0c*)

b $7FEF Sprite: Type 15 Frame 0E
@ $7FEF label=SpriteType15_Frame0E
D $7FEF A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$0E (see #R$ADBE).
  $7FEF,$01 Width = #N(#PEEK(#PC)) bytes.
  $7FF0,$01 Height = #N(#PEEK(#PC)) pixels.
  $7FF1,$24,$02 #SPRITEDATA(type-15-frame-0e*)

b $8015 Sprite: Type 15 Frame 0D
@ $8015 label=SpriteType15_Frame0D
D $8015 A sprite for objects of type #N$15: it is used when the bottom four
. bits of offset #N($13) are #N$0D (see #R$ADBE).
  $8015,$01 Width = #N(#PEEK(#PC)) bytes.
  $8016,$01 Height = #N(#PEEK(#PC)) pixels.
  $8017,$24,$02 #SPRITEDATA(type-15-frame-0d*)

b $803B Pulse Patterns
@ $803B label=PulsePatterns
D $803B Four patterns, each of which is a number of rows followed by two bytes
. for each row. The table at #R$B8CF lists them from the smallest to the
. largest and back again, which makes a ring that grows then shrinks.
  $803B,$0B,$02 Five rows.
  $8046,$0D,$02 Six rows.
  $8053,$0F,$02 Seven rows.
  $8062,$11,$02 Eight rows.

b $8073 Sprite: Type 0D Frame 08
@ $8073 label=SpriteType0D_Frame08
D $8073 A sprite for objects of type #N$0D: it is used when the bottom four
. bits of offset #N($13) are #N$08 (see #R$ADBE).
  $8073,$01 Width = #N(#PEEK(#PC)) bytes.
  $8074,$01 Height = #N(#PEEK(#PC)) pixels.
  $8075,$51,$03 #SPRITEDATA(type-0d-frame-08*)

b $80C6 Sprite: Type 0D Frame 0A
@ $80C6 label=SpriteType0D_Frame0A
D $80C6 A sprite for objects of type #N$0D: it is used when the bottom four
. bits of offset #N($13) are #N$0A (see #R$ADBE).
  $80C6,$01 Width = #N(#PEEK(#PC)) bytes.
  $80C7,$01 Height = #N(#PEEK(#PC)) pixels.
  $80C8,$42,$03 #SPRITEDATA(type-0d-frame-0a*)

b $810A Sprite: Type 0D Frame 06
@ $810A label=SpriteType0D_Frame06
D $810A A sprite for objects of type #N$0D: it is used when the bottom four
. bits of offset #N($13) are #N$06 (see #R$ADBE).
  $810A,$01 Width = #N(#PEEK(#PC)) bytes.
  $810B,$01 Height = #N(#PEEK(#PC)) pixels.
  $810C,$27,$03 #SPRITEDATA(type-0d-frame-06*)

b $8133 Sprite: Type 0C Frame 0D
@ $8133 label=SpriteType0C_Frame0D
D $8133 A sprite for objects of type #N$0C: it is used when the bottom four
. bits of offset #N($13) are #N$0D (see #R$ADBE).
  $8133,$01 Width = #N(#PEEK(#PC)) bytes.
  $8134,$01 Height = #N(#PEEK(#PC)) pixels.
  $8135,$64,$05 #SPRITEDATA(type-0c-frame-0d*)

b $8199 Sprite: Type 0D Frame 05
@ $8199 label=SpriteType0D_Frame05
D $8199 A sprite for objects of type #N$0D: it is used when the bottom four
. bits of offset #N($13) are #N$05 (see #R$ADBE).
  $8199,$01 Width = #N(#PEEK(#PC)) bytes.
  $819A,$01 Height = #N(#PEEK(#PC)) pixels.
  $819B,$1E,$02 #SPRITEDATA(type-0d-frame-05*)

b $81B9 Sprite: Type 1B Frame 03
@ $81B9 label=SpriteType1B_Frame03
D $81B9 A sprite for objects of type #N$1B: it is used when the bottom four
. bits of offset #N($13) are #N$03 (see #R$ADBE).
  $81B9,$01 Width = #N(#PEEK(#PC)) bytes.
  $81BA,$01 Height = #N(#PEEK(#PC)) pixels.
  $81BB,$1E,$02 #SPRITEDATA(type-1b-frame-03*)

b $81D9 Sprite: Type 0C Frame 0F
@ $81D9 label=SpriteType0C_Frame0F
D $81D9 A sprite for objects of type #N$0C: it is used when the bottom four
. bits of offset #N($13) are #N$0F (see #R$ADBE).
  $81D9,$01 Width = #N(#PEEK(#PC)) bytes.
  $81DA,$01 Height = #N(#PEEK(#PC)) pixels.
  $81DB,$20,$02 #SPRITEDATA(type-0c-frame-0f*)

b $81FB Sprite: Type 1B Frame 01
@ $81FB label=SpriteType1B_Frame01
D $81FB A sprite for objects of type #N$1B: it is used when the bottom four
. bits of offset #N($13) are #N$01 (see #R$ADBE).
  $81FB,$01 Width = #N(#PEEK(#PC)) bytes.
  $81FC,$01 Height = #N(#PEEK(#PC)) pixels.
  $81FD,$20,$02 #SPRITEDATA(type-1b-frame-01*)

b $821D Sprite: Type 0D Frame 0E
@ $821D label=SpriteType0D_Frame0E
D $821D A sprite for objects of type #N$0D: it is used when the bottom four
. bits of offset #N($13) are #N$0E (see #R$ADBE).
  $821D,$01 Width = #N(#PEEK(#PC)) bytes.
  $821E,$01 Height = #N(#PEEK(#PC)) pixels.
  $821F,$48,$03 #SPRITEDATA(type-0d-frame-0e*)

b $8267 Sprite: Type 1B Frame 05
@ $8267 label=SpriteType1B_Frame05
D $8267 A sprite for objects of type #N$1B: it is used when the bottom four
. bits of offset #N($13) are #N$05 (see #R$ADBE).
  $8267,$01 Width = #N(#PEEK(#PC)) bytes.
  $8268,$01 Height = #N(#PEEK(#PC)) pixels.
  $8269,$48,$03 #SPRITEDATA(type-1b-frame-05*)

b $82B1 Sprite: Type 0D Frame 0D
@ $82B1 label=SpriteType0D_Frame0D
D $82B1 A sprite for objects of type #N$0D: it is used when the bottom four
. bits of offset #N($13) are #N$0D (see #R$ADBE).
  $82B1,$01 Width = #N(#PEEK(#PC)) bytes.
  $82B2,$01 Height = #N(#PEEK(#PC)) pixels.
  $82B3,$50,$05 #SPRITEDATA(type-0d-frame-0d*)

b $8303 Sprite: Type 0D Frame 0B
@ $8303 label=SpriteType0D_Frame0B
D $8303 A sprite for objects of type #N$0D: it is used when the bottom four
. bits of offset #N($13) are #N$0B (see #R$ADBE).
  $8303,$01 Width = #N(#PEEK(#PC)) bytes.
  $8304,$01 Height = #N(#PEEK(#PC)) pixels.
  $8305,$42,$03 #SPRITEDATA(type-0d-frame-0b*)

c $8347 Adjust Terrain Slope
@ $8347 label=AdjustTerrainSlope
D $8347 Works out how much to adjust the drawing of a terrain tile when it
. is next to a sloping tile. The tile codes #N$90 to #N$93 are the four slope
. tiles; the codes of the two tiles under consideration are held at #R$5C33 and
. #R$5C34.
R $8347 E Direction flag set by the caller
R $8347 IX Address of the object
R $8347 O:C Number of extra rows to draw
R $8347 O:L Adjusted vertical position
  $8347,$03 Fetch the map column of the object.
  $834A,$01 Test it.
  $834B,$01 Return if it is zero.
  $834C,$03 Fetch the two tile codes from #R$5C33 into #REGhl.
  $834F,$03 Clear the adjustment (#REGb) and the extra row count (#REGc).
  $8352,$03 Check the first tile code.
  $8355,$03 Check the second tile code.
N $8358 Slope tile #N$91 can add an extra row.
  $8358,$01 Fetch the first tile code.
  $8359,$04 Jump to #R$8366 if it is not slope tile #N$91.
  $835D,$04 Jump to #R$8366 if the second tile code is a special tile (bit 7 is
. set).
  $8361,$01 Fetch the direction flag.
  $8362,$03 Test it and jump to #R$8366 if it is set.
  $8365,$01 Add an extra row.
N $8366 Slope tile #N$93 can add an extra row too.
@ $8366 label=AdjustTerrainSlope_Tile93
  $8366,$01 Fetch the first tile code.
  $8367,$04 Jump to #R$837D if it is not slope tile #N$93.
  $836B,$03 Fetch the scroll speed from #R$CCBB.
  $836E,$01 Test it.
  $836F,$02 Jump to #R$8378 if the screen is scrolling.
  $8371,$03 Fetch the vertical position from #R$BA8D.
  $8374,$02,b$01 Test the bottom three bits.
  $8376,$02 Jump to #R$837D if they are all zero.
@ $8378 label=AdjustTerrainSlope_AddRow
  $8378,$01 Fetch the direction flag.
  $8379,$01 Test it.
  $837A,$02 Jump to #R$837D if it is set.
  $837C,$01 Add an extra row.
N $837D Return the adjusted vertical position and the extra row count.
@ $837D label=AdjustTerrainSlope_Return
  $837D,$03 Fetch the position from #R$BA8D into #REGhl.
  $8380,$03 Add the adjustment in #REGb to the low byte of the position.
  $8383,$03 Clear #REGa, then add the extra row count to it.
  $8386,$01 Copy the extra row count back into #REGc.
  $8387,$03 Store the extra row count in #R$5C24.
  $838A,$01 Return.

c $838B Adjust Second Slope Tile
@ $838B label=AdjustTerrainSlope_Second
D $838B Looks at the second tile code of the pair for #R$8347.
R $838B C Extra row count
R $838B E Direction flag
R $838B O:C Updated extra row count
  $838B,$03 Fetch the second tile code from #R$5C34.
  $838E,$04 Jump to #R$839C if it is slope tile #N$93.
  $8392,$04 Jump to #R$8397 if it is slope tile #N$92.
  $8396,$01 Return, as no other tile needs adjusting.
@ $8397 label=AdjustTerrainSlope_Second92
  $8397,$01 Fetch the direction flag.
  $8398,$01 Test it.
  $8399,$01 Return if it is clear.
  $839A,$01 Add an extra row.
  $839B,$01 Return.
@ $839C label=AdjustTerrainSlope_Second93
  $839C,$01 Fetch the direction flag.
  $839D,$01 Test it.
  $839E,$01 Return if it is set.
  $839F,$01 Add an extra row.
  $83A0,$01 Return.

c $83A1 Adjust First Slope Tile
@ $83A1 label=AdjustTerrainSlope_First
D $83A1 Looks at the first tile code of the pair for #R$8347.
R $83A1 C Extra row count
R $83A1 E Direction flag
R $83A1 L Vertical position
R $83A1 O:B Adjustment
R $83A1 O:C Updated extra row count
  $83A1,$03 Fetch the first tile code from #R$5C33.
  $83A4,$04 Jump to #R$83B2 if it is slope tile #N$90.
  $83A8,$02 Is it slope tile #N$91?
  $83AA,$01 Return if not, as no other tile needs adjusting.
  $83AB,$01 Fetch the direction flag.
  $83AC,$01 Test it.
  $83AD,$02 Jump to #R$83C7 if it is clear.
  $83AF,$02 Set the adjustment to #N$07.
  $83B1,$01 Return.
@ $83B2 label=AdjustTerrainSlope_First90
  $83B2,$02 Set the adjustment to #N$07.
  $83B4,$01 Fetch the direction flag.
  $83B5,$01 Test it.
  $83B6,$01 Return if it is clear.
  $83B7,$02 Clear the adjustment.
  $83B9,$03 Fetch the scroll speed from #R$CCBB.
  $83BC,$02 Is the scroll speed negative?
  $83BE,$01 Return if so.
  $83BF,$01 Test the scroll speed.
  $83C0,$01 Return if the screen is not scrolling.
  $83C1,$03 Fetch the bottom three bits of the vertical position.
  $83C4,$02 Jump to #R$83C7 if they are not all zero.
  $83C6,$01 Add an extra row.
@ $83C7 label=AdjustTerrainSlope_Scroll
  $83C7,$03 Fetch the scroll speed from #R$CCBB.
  $83CA,$02 Negate it.
  $83CC,$01 Use it as the adjustment.
  $83CD,$01 Return.

c $83CE Print Text Repeatedly
@ $83CE label=PrintTextRepeatedly
D $83CE Calls #R$A115 several times with the same text record.
. .
. #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$83CE,stop=$83D5,clear=1,de=$F112,bc=$0C00,sp=$FE00)
. #SCR$02(repeated-title) } UDGTABLE# #POPS
E $83CE View the equivalent code in;
. #LIST
. { #BUBBLER$E1BD }
. LIST#
R $83CE B Number of times to print the text
R $83CE DE Address of the text record
  $83CE,$01 Save the counter.
  $83CF,$03 Print the text record.
  $83D2,$01 Restore the counter.
  $83D3,$02 Decrease the counter by one and loop back to #R$83CE until none
. remain.
  $83D5,$01 Return.

c $83D6 Complete Planet
@ $83D6 label=CompletePlanet
D $83D6 Shows the "planet completed" message and sets up the next planet. The
. text records at #R$84A9 are printed, with the name of the planet just
. finished and the name of the next planet filled in, then the player is
. rewarded with a sound and a short delay before new item sites are chosen
. for the next planet.
N $83D6 Print the first four lines of the message.
  $83D6,$03 Use the first text record at #R$84A9.
  $83D9,$02 Set a counter in #REGb for four records.
  $83DB,$03 Print the four text records.
N $83DE Fill in the name of the planet just completed.
  $83DE,$03 Fetch the planet number from #R$F5F9.
  $83E1,$04 Multiply it by sixteen, the length of a name in #R$8459.
  $83E5,$06 Use the table of planet names and add the offset.
  $83EB,$03 Use the planet name slot in the text record at #R$8501.
  $83EE,$02 Set the length of the name in #REGc.
  $83F0,$02 Copy the name of the planet just finished into the text record.
N $83F2 Fill in the name of the next planet, wrapping round after the last one.
  $83F2,$03 Fetch the planet number again.
  $83F5,$04 Jump to #R$8401 if it is not the last planet.
  $83F9,$05 Set the planet number to #N($FF), so that it wraps to zero when
. incremented below.
  $83FE,$03 Use the first planet name.
@ $8401 label=CompletePlanet_NextName
  $8401,$03 Use the planet name slot in the text record at #R$8523.
  $8404,$02 Set the length of the name in #REGc.
  $8406,$02 Copy the name of the next planet into the text record.
N $8408 Print the planet names, then the rest of the message.
  $8408,$03 Use the text record at #R$8501.
  $840B,$03 Print the record.
  $840E,$06 Set the screen position parameters in #R$96AC...
  $8414,$06 ...and #R$96AE.
  $841A,$07 Move on to the next planet number.
  $8421,$02 Set a counter in #REGb for four records.
  $8423,$03 Print the remaining four text records.
N $8426 Reward the player.
  $8426,$08 Set the bytes at #R$F601 and #R$F602 to #N$06.
  $842E,$02 Set a counter in #REGb for #N$0A repetitions.
@ $8430 label=CompletePlanet_Loop
  $8430,$01 Save the counter.
  $8431,$06 Add #N$5000 points to the score of player one.
  $8437,$03 Play the explosion sound.
  $843A,$05 Delay for a short while.
  $843F,$01 Restore the counter.
  $8440,$02 Decrease the counter by one and loop back to #R$8430 until none
. remain.
N $8442 Choose the item sites for the next planet.
  $8442,$03 Use the table of item sites for player two.
  $8445,$04 Use the list of pool numbers at #R$61BB.
  $8449,$03 Choose the item sites.
  $844C,$03 Fetch the player count flag from #R$CA1C.
  $844F,$07 Turn it into a mask in #REGe.
  $8456,$03 Clear the table at #R$5C94 (masked with #REGe) and carry on.

b $8459 Planet Names
@ $8459 label=PlanetNames
D $8459 The names of the five planets, sixteen characters each, padded with
. spaces. The text uses the game's own character set: #N$00 to #N$19 are the
. letters "A" to "Z", #N$1A to #N$23 are the digits "0" to "9" and #N$26 is a
. space.
B $8459,$50,$10

b $84A9 Planet Complete Messages
@ $84A9 label=PlanetCompleteText
D $84A9 The text records for the message shown by #R$83D6, in the format
. understood by #R$A115: the X and Y pixel position, the attribute, the length
. of the text and then the text itself. The records at #R$8501 and #R$8523 are
. filled in with the planet names when the message is shown.
B $84A9,$04,$04
B $84AD,$0F,$0F "CONGRATULATIONS"
B $84BC,$04,$04
B $84C0,$17,$17 "YOU HAVE SECURED ALL OF"
B $84D7,$04,$04
B $84DB,$16,$16 "THE CYBERTRON CRYSTALS"
B $84F1,$04,$04
B $84F5,$0C,$0C "AVAILABLE ON"
@ $8501 label=PlanetCompleteText_FirstRecord
B $8501,$04,$04
@ $8505 label=PlanetCompleteText_FirstPlanetName
B $8505,$10,$10 Space for the name of the planet just finished.
B $8515,$04,$04
B $8519,$0A,$0A "PROCEED TO"
B $8523,$04,$04
@ $8527 label=PlanetCompleteText_SecondPlanetName
B $8527,$0F,$0F Space for the name of the next planet.
B $8536,$04,$04
B $853A,$0C,$0C "AND CONTINUE"
B $8546,$04,$04
B $854A,$12,$12 "CRYSTAL COLLECTION"

b $855C Spawn Pattern Table
@ $855C label=SpawnPatternTable
D $855C Purpose not yet known; used by #R$89D3 to choose which of eight spawn
. positions are used for an enemy wave.
B $855C,$A8,$08
B $8604,$01

b $8605 Spawn Position Table
@ $8605 label=SpawnPositionTable
D $8605 Eight pairs of X and Y positions, used by #R$89D3 as the starting
. position of an enemy.
B $8605,$10,$02

c $8615 Run Title Menu
@ $8615 label=RunTitleMenu
D $8615 Runs the title screen: it keeps the random number generator ticking
. over, slides the control icons for each player to the position of the control
. method selected, redraws the option markers and waits for the "0" key to be
. pressed to start the game.
  $8615,$03 Fetch a random number to keep the seed moving.
  $8618,$07 Add one to the frame counter in #R$9A64.
  $861F,$04 Use the control icon data for player one...
  $8623,$03 ...with the sprite of the icon in #REGde...
  $8626,$03 ...and update the icon.
  $8629,$04 Use the control icon data for player two...
  $862D,$03 ...with the sprite of the icon in #REGde...
  $8630,$03 ...and update the icon.
  $8633,$06 Draw the first option marker.
  $8639,$06 Draw the second option marker.
  $863F,$05 Delay for a short while.
  $8644,$06 Read the keyboard row "0" to "6".
  $864A,$02,b$01 Test the "0" key.
  $864C,$01 Return if it is pressed, to start the game.
  $864D,$03 Check the other keys.
  $8650,$02 Go round again.

c $8652 Draw Menu Options
@ $8652 label=DrawMenuOptions
D $8652 Redraws both option markers, highlighting the selected one.
. .
. #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$F26C,stop=$F2D0,clear=1,sp=$FE00)
. #SCR$02(title-menu) } UDGTABLE# #POPS
  $8652,$08 Set bit 2 of the frame counter in #R$9A64, so that the selected
. option is highlighted.
  $865A,$06 Draw the first option marker.
  $8660,$06 Jump to #R$8666.

c $8666 Draw Menu Option
@ $8666 label=DrawMenuOption
D $8666 Draws one option marker, in bright white if it is the selected option
. or in bright magenta otherwise.
R $8666 HL Pixel position of the option marker
  $8666,$02 Use bright magenta as the default attribute.
  $8668,$03 Fetch the frame counter from #R$9A64.
  $866B,$02,b$01 Test bit 2.
  $866D,$02 Jump to #R$8683 if it is clear.
  $866F,$0C Turn the Y position into the option number in #REGc.
  $867B,$03 Fetch the selected option from #R$F2E2.
  $867E,$01 Is this the selected option?
  $867F,$02 Jump to #R$8683 if not.
  $8681,$02 Use bright white for the selected option instead.
@ $8683 label=DrawMenuOption_Fill
  $8683,$04 Store the attribute in the data at #R$868D.
  $8687,$03 Use the attribute data.
  $868A,$03 Jump to #R$C991.
@ $868D label=DrawMenuOption_Attributes
B $868D,$03,$03

c $8690 Update Control Icon
@ $8690 label=UpdateControlIcon
D $8690 Slides the icon for a player's control method towards the row of the
. selected method and draws it.
R $8690 IX Address of the control icon data (see #R$8708)
R $8690 DE Address of the sprite of the icon
  $8690,$03 Fetch the selected control method.
  $8693,$03 Use the table of icon positions at #R$8704.
  $8696,$03 Add the control method to the address.
  $8699,$01 Fetch the target position of the icon.
  $869A,$03 Subtract the current position of the icon.
  $869D,$02 Jump to #R$86B0 if the icon is already in place.
  $869F,$04 Jump to #R$86A8 if the icon is above the target.
  $86A3,$03 Move the icon one pixel closer.
  $86A6,$02 Jump to #R$86B0.
@ $86A8 label=UpdateControlIcon_Up
  $86A8,$03 Fetch the current position of the icon.
  $86AB,$02 Move the icon four pixels closer.
  $86AD,$03 Store the new position.
@ $86B0 label=UpdateControlIcon_Draw
  $86B0,$06 Fetch the pixel position of the icon into #REGhl.
  $86B6,$03 Draw the icon.

c $86B9 Read Menu Keys
@ $86B9 label=ReadMenuKeys
D $86B9 Reads the keys that choose the number of players ("A" and "B") and
. the control methods of each player ("1" and "2").
E $86B9 Continue on to #R$86E4.
  $86B9,$04 Read the keyboard row "A" to "G".
  $86BD,$04 Test the "A" key.
  $86C1,$02 Jump to #R$86C6 if it is not pressed.
  $86C3,$03 Select option zero in #R$F2E2.
@ $86C6 label=ReadMenuKeys_B
  $86C6,$04 Read the keyboard row "B" to "SPACE".
  $86CA,$04 Test the "B" key.
  $86CE,$02 Jump to #R$86D5 if it is not pressed.
  $86D0,$05 Select option one in #R$F2E2.
@ $86D5 label=ReadMenuKeys_Icons
  $86D5,$04 Use the control icon data for player one.
  $86D9,$02 Use the "1" key.
  $86DB,$03 Check for a change of control method.
  $86DE,$04 Use the control icon data for player two.
  $86E2,$02 Use the "2" key.

c $86E4 Change Control Method
@ $86E4 label=ChangeControlMethod
D $86E4 Moves on to the next control method for a player if the key for that
. player is pressed and the icon has finished sliding into place.
R $86E4 B Key mask for the row "1" to "5"
R $86E4 IX Address of the control icon data
  $86E4,$03 Fetch the selected control method.
  $86E7,$03 Use the table of icon positions at #R$8704.
  $86EA,$03 Add the control method to the address.
  $86ED,$01 Fetch the target position of the icon.
  $86EE,$03 Subtract the current position of the icon.
  $86F1,$01 Return if the icon is still moving.
  $86F2,$04 Read the keyboard row "1" to "5".
  $86F6,$02 Read the keyboard.
  $86F8,$01 Test the key.
  $86F9,$01 Return if it is not pressed.
  $86FA,$03 Fetch the selected control method.
  $86FD,$01 Move on to the next one...
  $86FE,$02,b$01 ...wrapping round after the fourth.
  $8700,$03 Store the new control method.
  $8703,$01 Return.

b $8704 Control Icon Positions
@ $8704 label=ControlIconPositions
D $8704 The vertical position of the icon for each of the four control
. methods.
B $8704,$04,$04

b $8708 Control Icon Data
@ $8708 label=ControlIconPlayerOne
D $8708 Two sets of three bytes: the X position, the current Y position and
. the control method selected for each player.
B $8708,$03,$03
@ $870B label=ControlIconPlayerTwo
B $870B,$03,$03

b $870E Control Icon Sprites
@ $870E label=ControlIconSprite_1
D $870E Two sprites of three bytes by twenty-one rows.
B $870E,$02,$02
B $8710,$3F,$03
@ $874F label=ControlIconSprite_2
B $874F,$02,$02
B $8751,$3F,$03
B $8790,$02,$02

c $8792 Spawn Special Enemy
@ $8792 label=SpawnSpecialEnemy
D $8792 Starts one of the special enemies, but only in the middle zones of the
. planet (zones #N$03 to #N$09).
  $8792,$03 Fetch the map zone from #R$CE58.
  $8795,$03 Return if it is #N$0A or higher...
  $8798,$03 ...or lower than #N$03.
  $879B,$06 Look for a free slot among two slots.
  $87A1,$03 Search for a free enemy slot.
  $87A4,$01 Return if there is not one.
  $87A5,$05 Select the second type of enemy.
  $87AA,$05 With #N$03 in #REGb, jump to #R$8A28 to start the enemy.

c $87AF Update Enemy Spawning
@ $87AF label=UpdateEnemySpawning
D $87AF Called once a frame to decide whether to start another enemy. A new
. enemy is started every eight calls, with a special enemy started part of the
. way through the countdown, as long as fewer than eight enemies are alive.
  $87AF,$03 Fetch the number of enemies that are alive from #R$8E2B.
  $87B2,$03 Return if there are eight of them.
  $87B5,$03 Fetch the bonus timer from #R$87F5.
  $87B8,$01 Test it.
  $87B9,$02 Jump to #R$87D0 if the timer is running.
  $87BB,$03 Fetch the random seed.
  $87BE,$04 Jump to #R$87D4 if it is not the same.
  $87C2,$03 Fetch the second byte of the seed.
  $87C5,$02,b$01 Test the bottom two bits.
  $87C7,$02 Jump to #R$87D4 if they are not zero.
  $87C9,$02,b$01 Set bit 7 of #REGa, which is zero.
  $87CB,$03 Start the bonus timer.
  $87CE,$02 Jump to #R$87D4.
@ $87D0 label=UpdateEnemySpawning_Timer
  $87D0,$04 Count the bonus timer down.
@ $87D4 label=UpdateEnemySpawning_Countdown
  $87D4,$07 Count down the spawn timer in #R$8790.
  $87DB,$05 Jump to #R$8792 if it is #N$07.
  $87E0,$02 Return if the countdown has not reached zero.
  $87E2,$05 Restart the countdown at eight.
@ $87E7 label=UpdateEnemySpawning_Spawn
  $87E7,$03 Fetch the number of slots to search from #N$8791.
  $87EA,$04 Use the first enemy slot.
  $87EE,$03 Search for a free enemy slot.
  $87F1,$03 Spawn an enemy if there is a free slot.
  $87F4,$01 Return.
B $87F5,$01,$01

c $87F6 Find Free Slot
@ $87F6 label=FindFreeSlot
D $87F6 Searches for a free enemy slot (one with type #N$FF) by stepping #REGix
. through the slots, which are #N$18 bytes long. No slot is returned if too
. many enemies are alive or if the player's ship is exploding.
R $87F6 A Number of slots to search
R $87F6 IX Address of the first slot to try
R $87F6 O:IX Address of the free slot
R $87F6 O:F The zero flag is set if a free slot was found
  $87F6,$01 Store the number of slots in #REGb.
  $87F7,$03 Fetch the number of enemies that are alive from #R$8E2B.
  $87FA,$04 Jump to #R$8810 if it is #N$07 or more.
  $87FE,$03 Fetch the death counter from #R$8F53.
  $8801,$01 Test it.
  $8802,$02 Jump to #R$8810 if the ship is exploding.
  $8804,$03 Set the size of a slot in #REGde.
@ $8807 label=FindFreeSlot_Loop
  $8807,$03 Fetch the type of the object in the slot.
  $880A,$01 Increment it.
  $880B,$01 Return with the zero flag set if the type was #N$FF.
  $880C,$02 Move on to the next slot.
  $880E,$02 Decrease the slot counter by one and loop back to #R$8807 until none
. remain.
@ $8810 label=FindFreeSlot_None
  $8810,$02,b$01 Clear the zero flag.
  $8812,$01 Return.

c $8813 Fire Random Shot
@ $8813 label=FireRandomShot
D $8813 Occasionally fires a shot from an object, when the flag at #R$A1D7 is
. set.
R $8813 IX Address of the object
  $8813,$03 Fetch the flag from #R$A1D7.
  $8816,$01 Test it.
  $8817,$01 Return if it is clear.
  $8818,$03 Fetch the first byte of the random seed.
  $881B,$02,b$01 Keep only some of the bits.
  $881D,$01 Return if any are set, so a shot is only fired now and then.
  $881E,$02 Jump to #R$882B.

c $8820 Fire Shot When Hit
@ $8820 label=FireShotWhenHit
D $8820 Occasionally fires a shot from an object that has been hit.
E $8820 Continue on to #R$882B.
R $8820 IX Address of the object
  $8820,$03 Fetch the first byte of the random seed.
  $8823,$02,b$01 Keep only some of the bits.
  $8825,$01 Return if any are set.
  $8826,$04 Test bit 7 of the flags of the object.
  $882A,$01 Return if it is clear.

c $882B Fire Shot
@ $882B label=FireShot
D $882B Starts a shot (type #N$1C) from an object, in one of the three shot
. slots. The kind of shot is chosen by the caller using the value in #R$5C1C.
R $882B IX Address of the object that fires
R $882B O:IY Address of the shot slot
  $882B,$02 Save the address of the object.
  $882D,$02 Look for a free slot among three slots...
  $882F,$04 ...starting at the first shot slot.
  $8833,$03 Search for a free slot.
  $8836,$04 Copy the address of the slot into #REGiy...
  $883A,$02 ...and restore the address of the object.
  $883C,$01 Return if there are no free slots.
  $883D,$03 Fetch the horizontal screen position of the object.
  $8840,$03 Return if it is off the right-hand side of the screen...
  $8843,$03 ...or off the left-hand side.
  $8846,$03 Fetch the kind of shot from #R$5C1C.
  $8849,$03 Use the table of shot flags at #R$89A7, less one.
  $884C,$03 Add the kind of shot to the address.
  $884F,$01 Fetch the flags for this kind of shot.
  $8850,$03 Store them in #R$5C1D.
  $8853,$03 Fetch the vertical screen position of the object.
  $8856,$04 Jump to #R$885D if bit 7 of the flags is clear.
  $885A,$03 Return if the object is too low down the screen for this shot.
@ $885D label=FireShot_CheckHigh
  $885D,$04 Jump to #R$8864 if bit 6 of the flags is clear.
  $8861,$03 Return if the object is too high up the screen for this shot.
@ $8864 label=FireShot_Start
  $8864,$03 Swap #REGix and #REGiy, then copy the position of the object.
  $8867,$03 Clear the slot of the shot.
  $886A,$04 Make the object a shot.
  $886E,$04 Set the flags of the shot.
  $8872,$03 Use the table of shot speeds at #R$89AB.
  $8875,$03 Fetch the kind of shot.
  $8878,$02 Multiply it by four.
  $887A,$03 Add it to the address.
  $887D,$06 Set the horizontal speed of the shot from the table.
  $8883,$05 Set the vertical speed of the shot from the table.
  $8888,$05 Set the first state byte of the shot from the table.
  $888D,$03 Set the second state byte of the shot from the table.
  $8890,$03 Fetch the flags for this kind of shot.
  $8893,$02,b$01 Keep the colour in the bottom four bits.
  $8895,$05 Copy it into the top four bits...
  $889A,$04 ...and set the attribute of the shot.
  $889E,$04 Set the lifetime of the shot to #N$38.
  $88A2,$03 Draw the shot.
  $88A5,$08 Swap #REGix and #REGiy back again.
  $88AD,$03 Fetch the state of the object that fired the shot.
  $88B0,$02,b$01 Keep the bottom four bits.
  $88B2,$03 Jump to #R$8934 if it is zero.
  $88B5,$05 Jump to #R$890D if it is #N$05.
  $88BA,$05 Jump to #R$890D if it is #N$06.
  $88BF,$05 Jump to #R$8970 if it is #N$07.
  $88C4,$05 Jump to #R$88F0 if it is #N$0A.
  $88C9,$06 Fetch the horizontal speed of the shot...
  $88CF,$04 ...halve it...
  $88D3,$06 ...and give it to the object that fired.
  $88D9,$03 Fetch the flags for this kind of shot.
  $88DC,$04 Set the vertical speed of the object to push it up.
  $88E0,$04 Jump to #R$88E8 if bit 7 of the flags is set.
  $88E4,$04 Otherwise set the vertical speed to push it down instead.
@ $88E8 label=FireShot_Sound
  $88E8,$03 Fetch the type of the object.
  $88EB,$01 Increment it.
  $88EC,$03 Play a sound if the object is active.
  $88EF,$01 Return.
@ $88F0 label=FireShot_State0A
  $88F0,$04 Set the horizontal speed of the object to six...
  $88F4,$0C ...and clear its other speeds.
  $8900,$03 Fetch the kind of shot.
  $8903,$04 Jump to #R$88E8 if it is #N$07.
  $8907,$04 Otherwise reverse the horizontal speed.
  $890B,$02 Jump to #R$88E8.

c $890D Set Random Speed
@ $890D label=SetRandomSpeed
D $890D Gives an object a random speed. The object is removed if it ends up
. with no speed at all.
R $890D IY Address of the object
  $890D,$03 Fetch the second byte of the random seed.
  $8910,$01 Copy it into #REGb.
  $8911,$02,b$01 Keep two bits.
  $8913,$02 Negate them.
  $8915,$01 Copy the result into #REGc.
  $8916,$03 Set the vertical speed of the object.
  $8919,$01 Fetch the random value again.
  $891A,$03 Rotate bits 5 to 3 into the bottom three bits.
  $891D,$02,b$01 Keep them.
  $891F,$05 Jump to #R$892E if the value is #N$07.
  $8924,$02 Subtract three...
  $8926,$02 ...and double it to get a horizontal speed.
  $8928,$03 Set the horizontal speed of the object.
  $892B,$01 Combine the speeds.
  $892C,$02 Jump to #R$88E8 if the object has any speed.
@ $892E label=SetRandomSpeed_Remove
  $892E,$04 Free the slot of the object.
  $8932,$02 Jump to #R$88E8.

c $8934 Set Falling Speed
@ $8934 label=SetFallingSpeed
D $8934 Gives an object a random speed and then sets its vertical acceleration.
R $8934 IY Address of the object
  $8934,$03 Give the object a random speed.
  $8937,$03 Fetch the vertical speed.
  $893A,$01 Test it.
  $893B,$02 Remove the object if it is zero.
  $893D,$02 Fetch a random number...
  $893F,$02,b$01 ...and keep three bits.
  $8941,$02 Jump to #R$8947 if any are set.
  $8943,$04 Occasionally change the state of the object to #N$09.
@ $8947 label=SetFallingSpeed_Flags
  $8947,$04 Set the flags of the object to #N$25.
  $894B,$03 Fetch the type of the object.
  $894E,$01 Increment it.
  $894F,$03 Jump to #R$88E8 if the slot is free.
  $8952,$07 Count down the timer at #R$896E.
  $8959,$02 Jump to #R$8967 if it has not run out.
  $895B,$03 Fetch the number of ships left from #R$F5ED.
  $895E,$02 Multiply it by four...
  $8960,$03 ...and restart the timer.
  $8963,$04 Change the state of the object to #N$08.
@ $8967 label=SetFallingSpeed_Accelerate
  $8967,$04 Set the vertical acceleration of the object to #N$20.
  $896B,$03 Jump to #R$88E8.
B $896E,$02,$01

c $8970 Reverse Vertical Speed
@ $8970 label=ReverseVerticalSpeed
D $8970 Part of #R$882B. Sets a random speed and, unless the object is moving
. fast, reverses its vertical direction.
R $8970 IX Address of the shot
R $8970 IY Address of the object
  $8970,$03 Give the object a random speed.
  $8973,$03 Fetch the second state byte of the shot.
  $8976,$05 Jump to #R$88E8 if it is #N$67 or higher.
  $897B,$03 Fetch the vertical speed of the object.
  $897E,$02 Negate it.
  $8980,$03 Store it.
  $8983,$03 Jump to #R$88E8.

c $8986 Swap Objects
@ $8986 label=SwapObjects
D $8986 Swaps the registers #REGix and #REGiy.
E $8986 Continue on to #R$898E.
  $8986,$02 Stash #REGix on the stack.
  $8988,$02 Stash #REGiy on the stack.
  $898A,$02 Retrieve #REGix from the stack as #REGix...
  $898C,$02 ...and #REGiy.

c $898E Copy Position
@ $898E label=CopyPosition
D $898E Copies the position of one object to another.
R $898E IX Address of the object to copy to
R $898E IY Address of the object to copy from
  $898E,$06 Copy the map column.
  $8994,$06 Copy the horizontal position.
  $899A,$06 Copy the map zone.
  $89A0,$06 Copy the vertical position.
@ $89A6 label=CopyPosition_Return
  $89A6,$01 Return.

b $89A7 Shot Tables
@ $89A7 label=ShotTables
D $89A7 Two overlapping tables used by #R$882B. The first holds a byte of flags
. for each kind of shot (the table starts at #R$89A6, so the first byte is for
. kind one). The second holds four bytes for each kind of shot, starting at
. #R$89AB: the horizontal speed, the vertical speed and the two state bytes of
. the shot.
. .
. Only kinds #N($03), #N($07) and #N($08) are known to be used.
B $89A7,$04,$04
@ $89AB label=ShotTables_Speeds
B $89AB,$28,$04

c $89D3 Spawn Enemy
@ $89D3 label=SpawnEnemy
D $89D3 Starts an enemy in the slot found by #R$87F6. The kind of enemy comes
. from the table at #R$990A, indexed by a counter that steps through a
. sequence of values.
R $89D3 IX Address of the free slot
  $89D3,$02 Use a counter limit of six...
  $89D5,$0E ...or eight if the flags at #R$F5F1 and #R$F5F2 are both set.
@ $89E3 label=SpawnEnemy_Counter
  $89E3,$03 Fetch the counter from #R$9932.
  $89E6,$04 Increase it and store it.
  $89EA,$01 Compare it with the limit.
  $89EB,$02 Jump to #R$89F1 if it is lower.
  $89ED,$04 Otherwise restart the counter at zero.
@ $89F1 label=SpawnEnemy_Kind
  $89F1,$04 Jump to #R$89FE if the counter is not four.
  $89F5,$01 Keep the counter in #REGb.
  $89F6,$02 Fetch a pseudo-random value from the refresh register.
  $89F8,$02,b$01 Keep some of its bits.
  $89FA,$01 Restore the counter.
  $89FB,$02 Jump to #R$89FE if the random bits were zero.
  $89FD,$01 Otherwise use three instead of four.
@ $89FE label=SpawnEnemy_Store
  $89FE,$03 Store the kind of enemy in #N$89D2.
  $8A01,$04 Jump to #R$8A09 if it is one.
  $8A05,$04 Jump to #R$8A18 if it is not five.
@ $8A09 label=SpawnEnemy_CheckZone
  $8A09,$03 Fetch the map zone from #R$CE58.
  $8A0C,$04 Jump to #R$8A14 if it is lower than #N$03.
  $8A10,$04 Jump to #R$8A18 if it is lower than #N$0A.
@ $8A14 label=SpawnEnemy_Reset
  $8A14,$04 Use kind zero instead.
@ $8A18 label=SpawnEnemy_CheckBonus
  $8A18,$03 Fetch the map zone from #R$CE58.
  $8A1B,$04 Jump to #R$8A26 if it is #N$0B or more.
  $8A1F,$03 Fetch the bonus timer from #R$87F5.
  $8A22,$01 Test it.
  $8A23,$03 Jump to #R$8B9B if it is running.
@ $8A26 label=SpawnEnemy_Limit
  $8A26,$02 #REGb=#N$03.
@ $8A28 label=SpawnEnemy_ChooseSide
  $8A28,$02 Clear #REGc.
  $8A2A,$03 Fetch the first byte of #N$C8FE.
  $8A2D,$01 Test it.
  $8A2E,$02 Jump to #R$8A42 if it is zero.
  $8A30,$01 Increment it.
  $8A31,$02 Jump to #R$8A42 if it was #N$FF.
  $8A33,$03 Fetch the scroll speed from #R$CCBB.
  $8A36,$04 Jump to #R$8A40 if bit 7 is set.
  $8A3A,$04 Keep only bit 0 of #REGb.
  $8A3E,$02 Jump to #R$8A42.
@ $8A40 label=SpawnEnemy_ChooseRight
  $8A40,$02 #REGc=#N$02.
@ $8A42 label=SpawnEnemy_ChooseLower
  $8A42,$03 Fetch the first byte of #N$C900.
  $8A45,$01 Test it.
  $8A46,$02 Jump to #R$8A58 if it is zero.
  $8A48,$01 Increment it.
  $8A49,$02 Jump to #R$8A58 if it was #N$FF.
  $8A4B,$01 Add one to #REGc.
  $8A4C,$03 Fetch the scroll speed from #R$CCBA.
  $8A4F,$04 Jump to #R$8A58 if bit 7 is set.
  $8A53,$01 Subtract one from #REGc.
  $8A54,$04 Keep only bit 1 of #REGb.
@ $8A58 label=SpawnEnemy_Pick
  $8A58,$05 Set the number of attempts in #R$8C04 to four.
  $8A5D,$03 Fetch the first byte of the random seed.
  $8A60,$02 Mask it with #REGb and combine it with #REGc.
@ $8A62 label=SpawnEnemy_Try
  $8A62,$03 Store the result in #R$5C1C.
  $8A65,$03 Use the table at #R$DC91.
  $8A68,$03 Add a random value to the address.
  $8A6B,$01 Fetch the entry.
  $8A6C,$04 Use the table at #R$855C and add the entry.
  $8A70,$01 Fetch the pattern.
  $8A71,$03 Store it in #R$5C1D.
  $8A74,$02 Fetch a pseudo-random value from the refresh register.
  $8A76,$02,b$01 Keep three bits.
  $8A78,$03 Store them in #R$5C1E.
  $8A7B,$03 Multiply them by eight...
  $8A7E,$02 ...and add #N$47 to make an attribute value.
  $8A80,$03 Store it in the data at #N$8A8B.
  $8A83,$04 Clear the bit counter in #R$5C1F.
@ $8A87 label=SpawnEnemy_Bit
  $8A87,$03 Fetch the pattern from #R$5C1D.
  $8A8A,$02 Rotate the mask in #REGb left.
  $8A8C,$02 Jump to #R$8AA3 if the bit was set.
  $8A8E,$03 Fetch the pattern again.
  $8A91,$01 Rotate it right.
  $8A92,$03 Store it.
  $8A95,$03 Fetch the bit counter from #R$5C1F.
  $8A98,$04 Increment it and store it.
  $8A9C,$04 Jump back to #R$8A87 if all eight bits have not been tried.
  $8AA0,$03 Give up and jump to #R$8B82.
@ $8AA3 label=SpawnEnemy_Position
  $8AA3,$03 Fetch the random three bits from #R$5C1E.
  $8AA6,$05 Add the bit counter from #R$5C1F.
  $8AAB,$02,b$01 Keep the bottom three bits.
  $8AAD,$01 Double it to index a pair of bytes.
  $8AAE,$03 Use the table at #R$8605.
  $8AB1,$03 Add the offset to the address.
  $8AB4,$04 Set the horizontal position of the enemy from the table.
  $8AB8,$05 Set the vertical position of the enemy from the table.
  $8ABD,$04 Make the enemy's attribute #N($FF).
  $8AC1,$03 Fetch the second byte of the random seed.
  $8AC4,$02,b$01 Keep two bits.
  $8AC6,$02 Jump to #R$8ACC if either is set.
  $8AC8,$04 Otherwise make the attribute #N$77.
@ $8ACC label=SpawnEnemy_FetchKind
  $8ACC,$03 Fetch the kind of enemy from #N$89D2.
@ $8ACF label=SpawnEnemy_SetKind
  $8ACF,$02 Multiply it by four.
  $8AD1,$03 Use the table at #R$990A.
  $8AD4,$03 Add the offset to the address.
  $8AD7,$03 Clear the slot.
  $8ADA,$04 Set the lifetime of the enemy to one.
  $8ADE,$06 Set the type of the enemy from the table.
  $8AE4,$05 Set the flags of the enemy from the table.
  $8AE9,$05 Set the first state byte of the enemy from the table.
  $8AEE,$03 Set the second state byte of the enemy from the table.
  $8AF1,$03 Fetch the type of the enemy.
  $8AF4,$05 Jump to #R$8BD1 if it is #N$1D.
  $8AF9,$03 Fetch the map position from #R$CE57.
  $8AFC,$03 Fetch the value from #R$5C1C.
  $8AFF,$01 Test it.
  $8B00,$02 Jump to #R$8B0F if it is zero.
  $8B02,$04 Jump to #R$8B07 if bit 0 is clear.
  $8B06,$01 Move the enemy one zone along.
@ $8B07 label=SpawnEnemy_Column
  $8B07,$04 Jump to #R$8B0F if bit 1 is clear.
  $8B0B,$03 Fetch the column from #R$DDF7.
  $8B0E,$01 Use it as the column of the enemy.
@ $8B0F label=SpawnEnemy_Place
  $8B0F,$03 Set the map column of the enemy.
  $8B12,$03 Set the map zone of the enemy.
  $8B15,$03 Fetch the type of the enemy.
  $8B18,$04 Jump to #R$8B58 if it is not #N$13.
  $8B1C,$04 Clear the first state byte of the enemy.
  $8B20,$02 Fetch a pseudo-random value from the refresh register.
  $8B22,$02,b$01 Keep some of its bits.
  $8B24,$02 Jump to #R$8B29 if any are set.
  $8B26,$03 Otherwise change the state of the enemy.
@ $8B29 label=SpawnEnemy_Zone
  $8B29,$01 Fetch the map zone of the enemy.
  $8B2A,$04 Jump to #R$8B75 if it is #N$05 or higher.
  $8B2E,$04 Set the flags of the enemy to #N$23.
  $8B32,$04 Set the map zone of the enemy to #N$04.
  $8B36,$04 Set the vertical position of the enemy to #N$1F.
  $8B3A,$04 Make the attribute of the enemy #N($FF).
  $8B3E,$03 Fetch the column from #R$DDF7.
  $8B41,$01 Compare it with the column of the enemy.
  $8B42,$02 Jump to #R$8B51 if it is the same.
  $8B44,$03 Fetch the horizontal position of the player from #R$CE45.
  $8B47,$02 Subtract #N$30 from it.
  $8B49,$02 Remove the enemy if that goes below zero.
  $8B4B,$02 Add #N$08 to it.
  $8B4D,$03 Set the horizontal position of the enemy.
  $8B50,$01 Return.
@ $8B51 label=SpawnEnemy_SameColumn
  $8B51,$03 Fetch the horizontal position of the player from #R$CE45.
  $8B54,$03 Set the horizontal position of the enemy.
  $8B57,$01 Return.
@ $8B58 label=SpawnEnemy_Attribute
  $8B58,$02 Fetch a pseudo-random value from the refresh register.
  $8B5A,$02,b$01 Keep three bits.
  $8B5C,$01 Copy them into #REGb.
  $8B5D,$01 Fetch the map zone of the enemy.
  $8B5E,$04 Jump to #R$8B6A if it is #N$0C or higher.
  $8B62,$04 Jump to #R$8B6A if it is lower than #N$04.
  $8B66,$04 Keep only two bits of the random value.
@ $8B6A label=SpawnEnemy_Colour
  $8B6A,$01 Fetch the random value.
  $8B6B,$03 Use the table at #R$9933.
  $8B6E,$03 Add the value to the address.
  $8B71,$01 Fetch the attribute from the table.
  $8B72,$03 Set the attribute of the enemy.
@ $8B75 label=SpawnEnemy_Finish
  $8B75,$03 Update the enemy.
  $8B78,$06 Jump to #R$8B93 if bit 7 of the flags of the enemy is clear.
  $8B7E,$04 Otherwise remove the enemy.
@ $8B82 label=SpawnEnemy_Retry
  $8B82,$03 Fetch the number of attempts left from #R$8C04.
  $8B85,$04 Decrease it and store it.
  $8B89,$01 Return if there are none left.
  $8B8A,$03 Fetch the value from #R$5C1C.
  $8B8D,$01 Move on to the next one...
  $8B8E,$02,b$01 ...keeping two bits.
  $8B90,$03 Try again.
@ $8B93 label=SpawnEnemy_Accelerate
  $8B93,$03 Set the acceleration of the enemy.
@ $8B96 label=SpawnEnemy_Remove
  $8B96,$04 Free the slot.
  $8B9A,$01 Return.
@ $8B9B label=SpawnEnemy_Bonus
  $8B9B,$04 Use the player's object at #R$C8E5.
  $8B9F,$03 Copy the position of the player to the enemy.
  $8BA2,$03 Fetch the first byte of the random seed.
  $8BA5,$01 Copy it into #REGb.
  $8BA6,$02,b$01 Keep two bits.
  $8BA8,$02 Add #N$18.
  $8BAA,$04 Jump to #R$8BB2 if bit 7 of the random value is clear.
  $8BAE,$02 Subtract #N$18...
  $8BB0,$02 ...and negate the result.
@ $8BB2 label=SpawnEnemy_BonusSpeed
  $8BB2,$03 Set the horizontal speed of the enemy.
  $8BB5,$03 Fetch the second vertical value of the player.
  $8BB8,$02 Subtract #N$10...
  $8BBA,$02 ...and negate the result.
  $8BBC,$03 Set the vertical speed of the enemy.
  $8BBF,$03 Draw the enemy.
  $8BC2,$03 Fetch the map column from #R$CE57.
  $8BC5,$03 Compare it with the map column of the enemy.
  $8BC8,$02 Select the kind of enemy.
  $8BCA,$03 Jump to #R$8ACF if they are the same.
  $8BCD,$01 Otherwise use the one before.
  $8BCE,$03 Jump to #R$8ACF.
@ $8BD1 label=SpawnEnemy_Type1D
  $8BD1,$03 Fetch the first byte of the random seed.
  $8BD4,$02,b$01 Keep bit 3.
  $8BD6,$04 Shift it right twice.
  $8BDA,$02 Add two.
  $8BDC,$03 Set the vertical speed of the enemy.
  $8BDF,$03 Fetch the second byte of the random seed.
  $8BE2,$02,b$01 Keep bit 3.
  $8BE4,$04 Shift it right twice.
  $8BE8,$02 Add two.
  $8BEA,$03 Set the horizontal speed of the enemy.
  $8BED,$03 Negate it and copy it into #REGb.
  $8BF0,$03 Fetch the map column from #R$CE57.
  $8BF3,$03 Compare it with the map column of the enemy.
  $8BF6,$04 Make the attribute of the enemy #N($FE).
  $8BFA,$01 Return if they are the same.
  $8BFB,$03 Otherwise reverse the horizontal speed.
  $8BFE,$04 Make the attribute of the enemy #N($EE).
  $8C02,$01 Return.
B $8C03,$02,$01

c $8C05 Accelerate Object
@ $8C05 label=AccelerateObject
D $8C05 Adds the acceleration of an object to its speed in both directions,
. limiting the speed to a maximum which depends on the flags of the object.
. The speeds are two byte values (see #R$8C3F).
R $8C05 IX Address of the object
  $8C05,$03 Fetch the flags of the object.
  $8C08,$02,b$01 Keep the bottom three bits.
  $8C0A,$01 Add one to get the speed limit.
  $8C0B,$03 Store it in #R$8C03.
  $8C0E,$01 Negate it...
  $8C0F,$03 ...and store the negative limit in #R$8C04.
  $8C12,$06 Fetch the horizontal speed of the object into #REGhl.
  $8C18,$06 Fetch the horizontal acceleration into #REGde.
  $8C1E,$01 Add it to the speed.
  $8C1F,$03 Limit the speed.
  $8C22,$06 Store the new horizontal speed.
  $8C28,$06 Fetch the vertical speed of the object into #REGhl.
  $8C2E,$06 Fetch the vertical acceleration into #REGde.
  $8C34,$01 Add it to the speed.
  $8C35,$03 Limit the speed.
  $8C38,$06 Store the new vertical speed.
  $8C3E,$01 Return.

c $8C3F Limit Speed To Range
@ $8C3F label=LimitSpeedToRange
D $8C3F Limits a speed to the range set by #R$8C05.
R $8C3F HL Speed
R $8C3F O:HL Limited speed
  $8C3F,$04 Jump to #R$8C4E if it is negative.
  $8C43,$03 Fetch the positive limit from #R$8C03.
  $8C46,$01 Subtract one.
  $8C47,$01 Compare it with the high byte of the speed.
  $8C48,$01 Return if the speed is within the limit.
  $8C49,$01 Restore the limit...
  $8C4A,$01 ...and use it as the speed.
  $8C4B,$02 Clear the low byte of the speed.
  $8C4D,$01 Return.
@ $8C4E label=LimitSpeedToRange_Negative
  $8C4E,$03 Fetch the negative limit from #R$8C04.
  $8C51,$01 Compare it with the high byte of the speed.
  $8C52,$01 Return if the speed is within the limit.
  $8C53,$01 Add one to the limit...
  $8C54,$01 ...and use it as the speed.
  $8C55,$02 Clear the low byte of the speed.
  $8C57,$01 Return.

c $8C58 Accelerate Towards Player
@ $8C58 label=AccelerateTowardsPlayer
D $8C58 Sets the acceleration of an object so that it heads towards the
. player. Objects of type #N$1D and #N$1E are left alone.
R $8C58 IX Address of the object
  $8C58,$03 Fetch the type of the object.
  $8C5B,$02 Is it #N$1D?
  $8C5D,$01 Return if so.
  $8C5E,$02 Is it #N$1E?
  $8C60,$01 Return if so.
  $8C61,$03 Fetch the value from #R$5C31.
  $8C64,$02,b$01 Keep bit 7.
  $8C66,$01 Return if it is set.
@ $8C67 label=AccelerateTowardsPlayer_Horizontal
  $8C67,$08 Set the horizontal acceleration to #N$0020.
  $8C6F,$03 Fetch the map column of the player from #R$CE57.
  $8C72,$03 Compare it with the map column of the object.
  $8C75,$02 Jump to #R$8C7F if they are the same.
  $8C77,$08 Otherwise set the horizontal acceleration to #N$FFE0.
@ $8C7F label=AccelerateTowardsPlayer_Stop
  $8C7F,$0D Clear the speeds of the object and its vertical acceleration.
  $8C8C,$03 Fetch the map zone of the player from #R$CE58.
  $8C8F,$03 Compare it with the map zone of the object.
  $8C92,$03 Fetch the vertical position of the player from #R$CE46.
  $8C95,$02 Jump to #R$8CA4 if the zones are different.
  $8C97,$03 Compare it with the vertical position of the object.
  $8C9A,$01 Return if it is lower.
  $8C9B,$08 Set the vertical acceleration to #N$0020.
  $8CA3,$01 Return.
@ $8CA4 label=AccelerateTowardsPlayer_Other
  $8CA4,$03 Compare the vertical position of the player with that of the object.
  $8CA7,$01 Return if it is not lower.
  $8CA8,$08 Set the vertical acceleration to #N$FFE0.
  $8CB0,$01 Return.
B $8CB1,$01,$01

c $8CB2 Explode Player Ship
@ $8CB2 label=ExplodePlayerShip
D $8CB2 Fills all nine enemy slots with the pieces of debris from the player's
. exploding ship: four pieces of type #N$15 followed by five pieces of type
. #N$1C.
  $8CB2,$04 Use the player's object.
  $8CB6,$03 Set the piece counter and timer in #REGbc.
  $8CB9,$04 Use the first enemy slot.
  $8CBD,$03 Fetch the scroll value from #R$C1A9.
  $8CC0,$02 Halve it.
  $8CC2,$02 Negate it.
  $8CC4,$03 Store it in #R$5C1D.
@ $8CC7 label=ExplodePlayerShip_First
  $8CC7,$01 Save the counters.
  $8CC8,$03 Start a piece at the position of the player.
  $8CCB,$03 Make the piece type #N$15.
  $8CCE,$04 Make the attribute of the piece #N($FF).
  $8CD2,$01 Restore the counters.
  $8CD3,$04 Set the timer of the piece.
  $8CD7,$03 Add #N$40 to the timer for the next piece.
  $8CDA,$03 Set the length of a slot.
  $8CDD,$02 Move on to the next slot.
  $8CDF,$02 Decrease the piece counter by one and loop back to #R$8CC7 until
. none remain.
  $8CE1,$03 Set the counter for five more pieces.
@ $8CE4 label=ExplodePlayerShip_Second
  $8CE4,$01 Save the counters.
  $8CE5,$03 Start a piece at the position of the player.
  $8CE8,$04 Make the piece type #N$1C.
  $8CEC,$04 Set the flags of the piece.
  $8CF0,$04 Set the first state byte of the piece.
  $8CF4,$04 Set the second state byte of the piece.
  $8CF8,$04 Set the lifetime of the piece.
  $8CFC,$04 Make the attribute of the piece #N($EE).
  $8D00,$01 Restore the counters.
  $8D01,$01 Fetch the timer.
  $8D02,$03 Use the table of speeds at #R$8D1F.
  $8D05,$03 Add the offset to the address.
  $8D08,$04 Set the horizontal speed of the piece from the table.
  $8D0C,$01 Fetch the next byte of the table.
  $8D0D,$04 Set the vertical speed of the piece from the table.
  $8D11,$02 Move on to the next pair of speeds.
  $8D13,$04 Set the vertical acceleration of the piece.
  $8D17,$03 Set the length of a slot.
  $8D1A,$02 Move on to the next slot.
  $8D1C,$02 Decrease the piece counter by one and loop back to #R$8CE4 until
. none remain.
  $8D1E,$01 Return.

b $8D1F Debris Speeds
@ $8D1F label=DebrisSpeeds
D $8D1F Five pairs of horizontal and vertical speeds for the pieces of debris
. of type #N$1C.
B $8D1F,$0A,$02

c $8D29 Start Debris Piece
@ $8D29 label=StartDebrisPiece
D $8D29 Starts a piece of debris at the position of the player's ship.
R $8D29 IX Address of the slot
R $8D29 IY Address of the player's object
  $8D29,$03 Clear the slot.
  $8D2C,$03 Copy the position of the player.
  $8D2F,$04 Set the horizontal speed of the piece.
  $8D33,$03 Fetch the speed from #R$5C1D.
  $8D36,$03 Set the vertical speed of the piece.
  $8D39,$03 Jump to #R$BF66.
B $8D3C,$01,$01

c $8D3D Skip Enemy Slot
@ $8D3D label=UpdateEnemies_Skip
D $8D3D Part of #R$8D42: restores #REGix and moves on to the next slot.
  $8D3D,$02 Bring #REGix back off the stack.
  $8D3F,$03 Jump to #R$8DFA.

c $8D42 Update Enemies
@ $8D42 label=UpdateEnemies
D $8D42 Updates all nine enemy slots once a frame. The counter at #R$8F53
. tracks the explosion of the player's ship: it counts up from one when the
. ship is destroyed, the debris is started when it reaches ten, and the ship
. is gone for good when it has gone past that point.
  $8D42,$03 Fetch the explosion counter from #R$8F53.
  $8D45,$01 Test it.
  $8D46,$02 Jump to #R$8D4C if the ship is intact.
  $8D48,$01 Increase the counter...
  $8D49,$03 ...and store it.
@ $8D4C label=UpdateEnemies_Debris
  $8D4C,$02 Has the counter reached ten?
  $8D4E,$03 Start the debris if so.
  $8D51,$03 Fetch the explosion counter again.
  $8D54,$02 Is it ten or more?
  $8D56,$03 Play the sound of the explosion if so.
  $8D59,$03 Fetch the value from #R$5C40.
  $8D5C,$03 Store it in #R$8CB1.
  $8D5F,$01 Clear #REGa.
  $8D60,$03 Clear the number of active enemies in #R$8E2B.
  $8D63,$03 Clear #R$5C40.
  $8D66,$03 Fetch the value from #R$8D3C.
  $8D69,$03 Store it in #R$8E2B.
  $8D6C,$04 Use the first enemy slot.
  $8D70,$02 Set the counter for nine slots.
@ $8D72 label=UpdateEnemies_Loop
  $8D72,$01 Save the slot counter.
  $8D73,$02 Save the address of the slot.
  $8D75,$03 Fetch the type of the object in the slot.
  $8D78,$01 Increment it.
  $8D79,$03 Skip the slot if it is free.
  $8D7C,$03 Fetch the second set of flags of the object.
  $8D7F,$02,b$01 Keep the top four bits.
  $8D81,$02 Jump to #R$8D8F if they are zero.
  $8D83,$02 Subtract one from the top four bits...
  $8D85,$0A ...and store them back with the bottom four bits.
@ $8D8F label=UpdateEnemies_Exploding
  $8D8F,$03 Fetch the explosion counter from #R$8F53.
  $8D92,$01 Test it.
  $8D93,$02 Jump to #R$8D9D if the ship is intact.
  $8D95,$04 Jump to #R$8D9D if the counter is four or higher.
  $8D99,$04 Otherwise set bit 3 of the second set of flags.
@ $8D9D label=UpdateEnemies_Update
  $8D9D,$05 Set the collision effects in #R$8E2C to #N$50.
  $8DA2,$07 Add one to the number of active enemies in #R$8E2B.
  $8DA9,$03 Reset the collision state.
  $8DAC,$04 Test bit 7 of the flags.
  $8DB0,$03 Call #R$8E21 if it is set.
  $8DB3,$04 Clear bit 6 of the flags.
  $8DB7,$01 Switch registers.
  $8DB8,$03 Run the code for the type of object.
  $8DBB,$03 Deal with any collision at #R$8E2D.
  $8DBE,$02 Restore the address of the slot.
  $8DC0,$03 Fetch the type of the object.
  $8DC3,$04 Jump to #R$8DD8 if it is #N$13.
  $8DC7,$04 Jump to #R$8DD1 if it is #N$1C.
  $8DCB,$04 Jump to #R$8DD8 if it is #N$1D.
  $8DCF,$02 Jump to #R$8DE8.
@ $8DD1 label=UpdateEnemies_Type1C
  $8DD1,$03 Fetch the second state byte of the object.
  $8DD4,$04 Jump to #R$8DE8 if it is two.
@ $8DD8 label=UpdateEnemies_CheckHit
  $8DD8,$03 Fetch the flag from #R$A1D7.
  $8DDB,$01 Test it.
  $8DDC,$02 Jump to #R$8DE8 if it is clear.
  $8DDE,$03 Fetch the flag from #R$A1D8.
  $8DE1,$01 Test it.
  $8DE2,$02 Jump to #R$8DE8 if it is set.
  $8DE4,$04 Otherwise free the slot.
@ $8DE8 label=UpdateEnemies_Check
  $8DE8,$06 Jump to #R$8DFA if bit 5 of the flags is set.
  $8DEE,$06 Jump to #R$8DFA if bit 3 of the second set of flags is set.
  $8DF4,$03 Work out the position of a hit.
  $8DF7,$03 Check for a collision with a shot.
@ $8DFA label=UpdateEnemies_Next
  $8DFA,$03 Set the length of a slot.
  $8DFD,$02 Move on to the next slot.
  $8DFF,$01 Restore the slot counter.
  $8E00,$01 Decrease the slot counter...
  $8E01,$03 ...and loop back to #R$8D72 until none remain.
  $8E04,$03 Fetch the number of active enemies from #R$8E2B.
  $8E07,$02 Return if there are four or more.
  $8E09,$01 Fetch a pseudo-random value from the refresh register.
  $8E0A,$04 Test bit 3.
  $8E0E,$02 Jump to #R$8E1E if it is clear.
  $8E10,$03 Fetch the map zone from #R$CE58.
  $8E13,$04 Jump to #R$8E1E if it is #N$0B or more...
  $8E17,$04 ...or less than #N$03.
  $8E1B,$03 Spawn a special enemy.
@ $8E1E label=UpdateEnemies_Spawn
  $8E1E,$03 Spawn an enemy.

c $8E21 Count Active Enemy
@ $8E21 label=CountActiveEnemy
D $8E21 Adds one to the number of active enemies and then jumps to #R$AD27.
  $8E21,$03 Fetch the number of active enemies from #R$8E2B.
  $8E24,$04 Add one and store it.
  $8E28,$03 Jump to #R$AD27.
B $8E2B,$02,$01

c $8E2D Apply Collision Effects
@ $8E2D label=ApplyCollisionEffects
D $8E2D Works out what happens when the player's ship hits an object. The
. object sets the byte at #R$8E2C when it is updated, and each bit of that
. byte selects an effect:
. #TABLE(default,centre,centre)
. { =h Bit | =h Effect }
. { 7 | Slow the ship down (#R$8F1E) }
. { 6 | Damage the ship (#R$8F54) }
. { 5 | Drain fuel (#R$8FC4) }
. { 4 | Bounce the ship (#R$8FCA) }
. { 3 | Mark the object as destroyed (#R$900B) }
. { 2 | Add fuel (#R$9015) }
. { 1 | Add a ship (#R$9020) }
. { 0 | Mark the object as hit (#R$9030) }
. TABLE#
R $8E2D IX Address of the object
  $8E2D,$03 Fetch the flag from #R$96AB.
  $8E30,$01 Test it.
  $8E31,$01 Return if it is set.
  $8E32,$03 Fetch the explosion counter from #R$8F53.
  $8E35,$01 Test it.
  $8E36,$01 Return if the ship is exploding.
  $8E37,$03 Fetch the collision effects from #R$8E2C.
  $8E3A,$01 Test them.
  $8E3B,$01 Return if there are none.
  $8E3C,$03 Fetch the collision flag from #R$A1D8.
  $8E3F,$01 Test it.
  $8E40,$01 Return if there is no collision.
  $8E41,$04 Fetch the address of the object that was hit from #R$AD46.
  $8E45,$04 Test bit 3 of its second set of flags.
  $8E49,$01 Return if it is set.
  $8E4A,$06 Fetch the screen position of the object into #REGhl.
  $8E50,$04 Use the hit data at #R$ABA4.
  $8E54,$03 Store the collision effects in the hit data.
  $8E57,$01 Fetch the horizontal screen position.
  $8E58,$02 Is it #N$8E or more?
  $8E5A,$01 Return if so.
  $8E5B,$02 Is it lower than #N$28?
  $8E5D,$01 Return if so.
  $8E5E,$06 Store the screen position in the hit data.
  $8E64,$03 Fetch the value from #R$5C29.
  $8E67,$03 Store it in the hit data.
  $8E6A,$03 Fetch the value from #R$5C38.
  $8E6D,$02 Add eight.
  $8E6F,$01 Use it as the vertical position.
  $8E70,$02 Set the horizontal position to #N$64.
  $8E72,$02 Set the width to #N$28...
  $8E74,$02 ...and the height to #N$10.
  $8E76,$03 Check for a hit.
  $8E79,$04 Bring #REGix back from #R$AD46.
  $8E7D,$04 Use the player's object.
  $8E81,$03 Fetch the value from #R$5C1C.
  $8E84,$01 Test it.
  $8E85,$03 Jump to #R$8ECA if it is zero.
  $8E88,$05 Set #R$D0BC to #N$80.
  $8E8D,$03 Fetch the collision effects from #R$8E2C.
  $8E90,$01 Copy them into #REGc.
  $8E91,$01 Increment them.
  $8E92,$02 Jump to #R$8E9F if they were not #N($FF).
  $8E94,$04 Make #R$896F #N($FF).
  $8E98,$04 Set bit 4 of the flags of the object.
  $8E9C,$03 Play the explosion sound.
@ $8E9F label=ApplyCollisionEffects_Bit7
  $8E9F,$02 Test bit 7.
  $8EA1,$03 Slow the ship down if it is set.
  $8EA4,$02 Test bit 6.
  $8EA6,$03 Damage the ship if it is set.
  $8EA9,$02 Test bit 5.
  $8EAB,$03 Drain the fuel if it is set.
  $8EAE,$02 Test bit 4.
  $8EB0,$03 Bounce the ship if it is set.
  $8EB3,$02 Test bit 3.
  $8EB5,$03 Mark the object as destroyed if it is set.
  $8EB8,$02 Test bit 2.
  $8EBA,$03 Add fuel if it is set.
  $8EBD,$01 Save the effects.
  $8EBE,$02 Test bit 1.
  $8EC0,$03 Add a ship if it is set.
  $8EC3,$01 Restore the effects.
  $8EC4,$05 Jump to #R$9030 if bit 0 is set.
  $8EC9,$01 Return.

c $8ECA Apply Player Collision
@ $8ECA label=ApplyPlayerCollision
D $8ECA Part of #R$8E2D, used when the value in #R$5C1C is zero. Only objects
. of type #N$13 are dealt with here. Purpose not yet known.
R $8ECA IX Address of the object
R $8ECA IY Address of the player's object
  $8ECA,$03 Fetch the type of the object.
  $8ECD,$02 Is it #N$13?
  $8ECF,$01 Return if not.
  $8ED0,$03 Fetch the value from #R$F5F7.
  $8ED3,$01 Test it.
  $8ED4,$01 Return if it is zero.
  $8ED5,$03 Fetch the value from #N$C8FD.
  $8ED8,$03 Combine the sign with the horizontal speed of the object.
  $8EDB,$02 Test bit 7.
  $8EDD,$01 Return if it is set.
  $8EDE,$03 Fetch the value from #N$C27C.
  $8EE1,$01 Use it as the horizontal position.
  $8EE2,$03 Fetch the value from #R$C27D.
  $8EE5,$02 Add eight.
  $8EE7,$01 Use it as the vertical position.
  $8EE8,$02 #REGa=#N$50.
  $8EEA,$03 Work out the position.
  $8EED,$01 Use the result as the height.
  $8EEE,$02 Set the width to #N$0C.
  $8EF0,$04 Use the hit data at #R$ABA4.
  $8EF4,$03 Check for a hit.
  $8EF7,$03 Fetch the value from #R$5C1C.
  $8EFA,$01 Test it.
  $8EFB,$01 Return if it is zero.
  $8EFC,$05 Set #R$D0BC to #N$80.
  $8F01,$04 Fetch the address of the object that was hit from #R$AD46.
  $8F05,$06 Fetch its horizontal speed into #REGhl.
  $8F0B,$03 Negate it.
  $8F0E,$04 Halve it.
  $8F12,$06 Give the result to the player as horizontal speed.
  $8F18,$05 Set #R$5C40 to #N($FF).
  $8F1D,$01 Return.

c $8F1E Slow Ship
@ $8F1E label=SlowShip
D $8F1E Halves the speed of the player's ship in each direction, unless the
. speed of the object that was hit is in the opposite direction.
R $8F1E IX Address of the object that was hit
R $8F1E IY Address of the player's object
  $8F1E,$03 Fetch the value from #R$8CB1.
  $8F21,$01 Test it.
  $8F22,$01 Return if it is not zero.
  $8F23,$06 Fetch the horizontal speed of the player into #REGde.
  $8F29,$04 Compare its sign with that of the object.
  $8F2D,$04 Jump to #R$8F3B if they are different.
  $8F31,$04 Halve the horizontal speed...
  $8F35,$06 ...and store it.
@ $8F3B label=SlowShip_Vertical
  $8F3B,$06 Fetch the vertical speed of the player into #REGde.
  $8F41,$04 Compare its sign with that of the object.
  $8F45,$02 Test bit 7.
  $8F47,$01 Return if they are different.
  $8F48,$04 Halve the vertical speed...
  $8F4C,$06 ...and store it.
  $8F52,$01 Return.
D $8F53 The state of the ship. Zero while it is flying, one when it is out of
. fuel, and a count that starts at #N($0A) when the ship is destroyed. #N($0B)
. or more means the ship is gone.
B $8F53,$01,$01

c $8F54 Damage Ship
@ $8F54 label=DamageShip
D $8F54 Damages the player's ship. A ship that has just been hit cannot be hit
. again for a few frames. Each hit changes the colour of the damage indicator,
. and the third hit destroys the ship.
R $8F54 IX Address of the object that was hit
  $8F54,$03 Fetch the second set of flags of the object.
  $8F57,$02,b$01 Keep the top four bits.
  $8F59,$01 Return if they are not zero.
  $8F5A,$03 Fetch the second set of flags again.
  $8F5D,$02 Set the top four bits.
  $8F5F,$03 Store them.
  $8F62,$03 Fetch the flag from #R$896F.
  $8F65,$01 Test it.
  $8F66,$02 Jump to #R$8F76 if it is zero.
  $8F68,$01 Fetch the collision effects.
  $8F69,$02,b$01 Clear bit 0.
  $8F6B,$04 Jump to #R$8F76 if the remaining effects are not #N$50.
  $8F6F,$04 Set bit 5 of the flags of the object.
  $8F73,$03 Play the explosion sound.
@ $8F76 label=DamageShip_Hit
  $8F76,$03 Fetch the flag from #R$896F.
  $8F79,$01 Test it.
  $8F7A,$01 Return if it is set.
  $8F7B,$03 Fetch the explosion counter from #R$8F53.
  $8F7E,$01 Test it.
  $8F7F,$01 Return if the ship is exploding.
  $8F80,$03 Play the explosion sound.
  $8F83,$03 Fetch the damage counter from #N$8FC3.
  $8F86,$04 Add one and store it.
  $8F8A,$01 Stash #REGbc on the stack.
  $8F8B,$02 Use bright white for the first hit...
  $8F8D,$01 Test the counter.
  $8F8E,$02 Jump to #R$8F98 if it is zero.
  $8F90,$02 Use bright yellow for the second hit...
  $8F92,$04 Jump to #R$8F98 if the counter is one.
  $8F96,$02 Otherwise use bright magenta.
@ $8F98 label=DamageShip_Colour
  $8F98,$04 Jump to #R$8FA3 if the counter is not three.
  $8F9C,$05 Set the explosion counter to one.
  $8FA1,$02 Use black for the damage indicator.
@ $8FA3 label=DamageShip_Indicator
  $8FA3,$04 Store the attribute in the data at #R$8FBF.
  $8FA7,$03 Set the position of the damage indicator.
  $8FAA,$03 Fetch the flag from #R$CA1C.
  $8FAD,$01 Test it.
  $8FAE,$02 Jump to #R$8FB3 if it is zero.
  $8FB0,$03 Move the damage indicator.
@ $8FB3 label=DamageShip_Draw
  $8FB3,$03 Use the data at #R$8FBF.
  $8FB6,$03 Draw the damage indicator.
  $8FB9,$01 Bring #REGbc back off the stack.
  $8FBA,$01 Return.
B $8FBB,$04,$04
@ $8FBF label=DamageShip_Attribute
B $8FBF,$05,$05

c $8FC4 Drain Fuel
@ $8FC4 label=DrainFuel
D $8FC4 Takes fuel from the player's ship.
  $8FC4,$03 Set the change in fuel to #N$E400.
  $8FC7,$03 Adjust the fuel.

c $8FCA Bounce Ship
@ $8FCA label=BounceShip
D $8FCA Bounces the player's ship off an object, by exchanging half of the
. speed of each of them.
R $8FCA IX Address of the object that was hit
R $8FCA IY Address of the player's object
  $8FCA,$06 Fetch the horizontal speed of the player into #REGde.
  $8FD0,$06 Fetch the horizontal speed of the object into #REGhl.
  $8FD6,$04 Halve it.
  $8FDA,$03 Negate it.
  $8FDD,$06 Store it as the new speed of the object.
  $8FE3,$01 Add the speed of the player.
  $8FE4,$06 Store the result as the new speed of the player.
  $8FEA,$06 Fetch the vertical speed of the player into #REGde.
  $8FF0,$06 Fetch the vertical speed of the object into #REGhl.
  $8FF6,$04 Halve it.
  $8FFA,$03 Negate it.
  $8FFD,$06 Store it as the new speed of the object.
  $9003,$01 Add the speed of the player.
  $9004,$06 Store the result as the new speed of the player.
  $900A,$01 Return.

c $900B Destroy Object
@ $900B label=DestroyObject
D $900B Marks an object as destroyed and plays a sound.
R $900B IX Address of the object
  $900B,$04 Set bit 4 of the flags of the object.
  $900F,$01 Stash #REGbc on the stack.
  $9010,$03 Play a sound.
  $9013,$01 Bring #REGbc back off the stack.
  $9014,$01 Return.

c $9015 Add Fuel
@ $9015 label=AddFuel
D $9015 Gives fuel to the player's ship.
  $9015,$01 Stash #REGbc on the stack.
  $9016,$03 Play the explosion sound.
  $9019,$01 Bring #REGbc back off the stack.
  $901A,$03 Set the change in fuel to #N$1000.
  $901D,$03 Adjust the fuel.

c $9020 Add Ship
@ $9020 label=AddShip
D $9020 Gives the player an extra ship, up to a maximum of ten.
  $9020,$03 Fetch the number of ships from #R$F5ED.
  $9023,$01 Add one.
  $9024,$02 Is it ten?
  $9026,$01 Return if so.
  $9027,$03 Store the new number of ships.
  $902A,$03 Play the explosion sound.
  $902D,$03 Show the number of ships.

c $9030 Mark Object Hit
@ $9030 label=MarkObjectHit
D $9030 Sets bit 5 of the flags of an object.
R $9030 IX Address of the object
  $9030,$04 Set bit 5 of the flags of the object.
  $9034,$01 Return.

c $9035 Explode Hit Object
@ $9035 label=ExplodeHitObject
D $9035 If bit 5 of the flags of an object is set, scores the points for it.
E $9035 Continue on to #R$903D.
R $9035 IX Address of the object
  $9035,$04 Test bit 5 of the flags of the object.
  $9039,$01 Return if it is clear.
  $903A,$03 Score the points for the object.

c $903D Start Explosion
@ $903D label=StartExplosion
D $903D Turns an object into an explosion (type #N$15).
R $903D IX Address of the object
  $903D,$04 Set the type of the object to #N$15.
  $9041,$04 Set its first state byte to #N$50.
  $9045,$04 Set its second state byte to #N$05.
  $9049,$03 Fetch the second byte of the random seed.
  $904C,$02,b$01 Keep two bits.
  $904E,$02 Rotate them into the top of the byte.
  $9050,$03 Set the lifetime of the object.
  $9053,$02,b$01 Set bit 0 and return.
  $9055,$01 Return.

c $9056 Nudge Object
@ $9056 label=NudgeObject
D $9056 Moves an object by a small fixed amount in two steps, by temporarily
. replacing its speeds and calling #R$BF66. Purpose of the call to #R$BA21
. in between not yet known.
R $9056 IX Address of the object
  $9056,$02 Set the displacement to four.
  $9058,$01 Stash #REGbc on the stack.
  $9059,$03 Move the object.
  $905C,$01 Bring #REGbc back off the stack.
  $905D,$03 Call #R$BA21.
  $9060,$02 Set the displacement to #N($FC).
@ $9062 label=NudgeObject_Step
  $9062,$09 Save the horizontal speed of the object in #R$DEDC.
  $906B,$09 Save the vertical speed of the object in #R$DEDE.
  $9074,$03 Set the vertical speed to the displacement.
  $9077,$04 Clear the low byte of the vertical speed.
  $907B,$02 Negate the displacement.
  $907D,$03 Set the horizontal speed to the displacement.
  $9080,$04 Clear the low byte of the horizontal speed.
  $9084,$03 Update the position of the object.
  $9087,$09 Restore the horizontal speed of the object.
  $9090,$09 Restore the vertical speed of the object.
  $9099,$01 Return.

c $909A Move Object Back And Forth
@ $909A label=MoveObjectBackAndForth
D $909A Clears the byte at #R$5C25 and nudges the object, then reverses its
. speeds and updates its position. Purpose not yet known.
R $909A IX Address of the object
  $909A,$04 Clear #R$5C25.
  $909E,$03 Nudge the object.
  $90A1,$03 Reverse the speeds of the object.
  $90A4,$03 Jump to #R$BF66.

c $90A7 Move Object And Stop
@ $90A7 label=MoveObjectAndStop
D $90A7 Sets #R$5C25 to #N$80 and nudges the object. When the value in #R$5C1C
. is not zero, the object is also marked, stopped and a sound is played.
R $90A7 IX Address of the object
  $90A7,$05 Set #R$5C25 to #N$80.
  $90AC,$03 Nudge the object.
  $90AF,$03 Fetch the value from #R$5C1C.
  $90B2,$01 Test it.
  $90B3,$03 Jump to #R$BF66 if it is zero.
  $90B6,$04 Set bit 3 of the second set of flags of the object.
  $90BA,$0D Clear the speeds of the object.
  $90C7,$03 Play a sound.
  $90CA,$03 Jump to #R$BF66.

c $90CD Reverse Object Speed
@ $90CD label=ReverseObjectSpeed
D $90CD Negates both speeds of an object.
R $90CD IX Address of the object
  $90CD,$06 Fetch the horizontal speed into #REGhl.
  $90D3,$03 Negate it.
  $90D6,$06 Store the new horizontal speed.
  $90DC,$06 Fetch the vertical speed into #REGhl.
  $90E2,$03 Negate it.
  $90E5,$06 Store the new vertical speed.
  $90EB,$01 Return.

c $90EC Process Object Flags
@ $90EC label=ProcessObjectFlags
D $90EC Remembers the address of the object in #R$AD46. If bit 4 of its flags
. is set the object is removed. Otherwise, bit 3 of the flags is cleared and,
. if it had been set, the routine returns; if not, the object is drawn and
. made to accelerate towards the player.
R $90EC IX Address of the object
  $90EC,$04 Store the address of the object in #R$AD46.
  $90F0,$06 Jump to #R$90FB if bit 4 of the flags of the object is clear.
  $90F6,$04 Free the slot.
  $90FA,$01 Return.
@ $90FB label=ProcessObjectFlags_Bit3
  $90FB,$04 Test bit 3 of the flags of the object.
  $90FF,$04 Clear bit 3.
  $9103,$01 Return if it was set.
  $9104,$03 Draw the object.
  $9107,$03 Make the object accelerate towards the player.

c $910A Step Object State
@ $910A label=StepObjectState
D $910A Steps through a sequence held in the two state bytes of an object. If
. bits 4 and 5 of the first state byte are equal to one, the bottom four bits
. of the first state byte count up and wrap round when they reach the value in
. the bottom four bits of the second state byte. Otherwise, bits 4 and 5 of the
. first state byte are adjusted. Purpose not yet known.
R $910A IX Address of the object
  $910A,$04 Fetch the first state byte and keep a copy in #REGb.
  $910E,$02,b$01 Only bits 4 and 5.
  $9110,$02 Subtract #N$10.
  $9112,$01 Keep the result in #REGd.
  $9113,$02 Jump to #R$913B if bits 4 and 5 were not equal to one.
  $9115,$01 Fetch the first state byte again.
  $9116,$02,b$01 Keep the bottom four bits.
  $9118,$01 Add one.
  $9119,$01 Keep it in #REGe.
  $911A,$03 Fetch the second state byte.
  $911D,$02,b$01 Keep the bottom four bits.
  $911F,$01 Add one.
  $9120,$01 Compare it with the first.
  $9121,$02 Jump to #R$912E if they are not the same.
  $9123,$03 Fetch the second state byte.
  $9126,$08 Shift the top four bits into the bottom four bits to use as the new
. count.
@ $912E label=StepObjectState_Store
  $912E,$01 Fetch the first state byte.
  $912F,$02,b$01 Keep the top four bits.
  $9131,$01 Combine them with the new count.
  $9132,$01 Keep the result in #REGb.
  $9133,$01 Copy it into #REGa.
  $9134,$02,b$01 Only bits 6 and 7.
  $9136,$04 Shift them right twice.
  $913A,$01 Keep the result in #REGd.
@ $913B label=StepObjectState_Finish
  $913B,$01 Fetch the first state byte.
  $913C,$02,b$01 Clear bits 4 and 5.
  $913E,$01 Combine them with the new bits.
  $913F,$03 Store it.
  $9142,$01 Return.

c $9143 Find Hit Position
@ $9143 label=FindHitPosition
D $9143 Works out the screen position of the object that was hit, and sets up
. the hit data used by #R$917C. Does nothing if the collision flag at #R$A1D8
. is clear.
  $9143,$04 Fetch the address of the object from #R$AD46.
  $9147,$06 Fetch its screen position into #REGhl.
  $914D,$04 Fetch the value from #R$5C29 into #REGe.
  $9151,$04 Fetch the collision flag from #R$A1D8 into #REGd.
  $9155,$01 Copy it into #REGa.
  $9156,$01 Subtract one.
  $9157,$01 Return if it was zero.
  $9158,$03 Fetch the flag from #R$A2FA.
  $915B,$01 Test it.
  $915C,$01 Fetch the horizontal screen position.
  $915D,$02 Jump to #R$9166 if the flag is clear.
  $915F,$01 Add the value from #REGe.
  $9160,$02 Set the horizontal screen position to #N$08.
  $9162,$01 Subtract it.
  $9163,$01 Keep the result in #REGe.
  $9164,$02 Jump to #R$916F.
@ $9166 label=FindHitPosition_Clear
  $9166,$02 Add #N$17 to the horizontal screen position.
  $9168,$01 Add the value from #REGe.
  $9169,$02 Jump to #R$916F if there is no carry.
  $916B,$02 Otherwise use #N$EE...
  $916D,$01 ...less the horizontal screen position.
  $916E,$01 Keep the result in #REGe.
@ $916F label=FindHitPosition_Store
  $916F,$03 Store the position in #R$ABA4.
  $9172,$04 Store the size in #N$ABA6.
  $9176,$01 Fetch the vertical screen position.
  $9177,$01 Subtract the collision flag.
  $9178,$03 Store the result in #R$5C1E.
  $917B,$01 Return.

c $917C Check Shot Collisions
@ $917C label=CheckShotCollisions
D $917C Checks whether any of the four objects at #R$B37A has hit the object
. described by the hit data at #R$ABA4. If one has, bit 7 of its flags is set
. and effects are applied to the object that was hit.
R $917C D Collision flag from #R$A1D8
R $917C IX Address of the object that was hit
  $917C,$01 Fetch the collision flag.
  $917D,$01 Subtract one.
  $917E,$01 Return if it was zero.
  $917F,$02 Save the address of the object.
  $9181,$04 Use the hit data at #R$ABA4.
  $9185,$02 Set the counter for four objects.
  $9187,$04 Use the first object.
@ $918B label=CheckShotCollisions_Loop
  $918B,$01 Save the counter.
  $918C,$06 Jump to #R$919B if bit 7 of the second set of flags of the object
. is set.
  $9192,$03 Fetch the first value of the object.
  $9195,$01 Test it.
  $9196,$03 Jump to #R$91E3 if it is zero.
  $9199,$02 Jump to #R$91A9.
@ $919B label=CheckShotCollisions_Position
  $919B,$06 Jump to #R$91E3 if bit 7 of the flags of the object is clear.
  $91A1,$06 Fetch the screen position of the object.
  $91A7,$02 Jump to #R$91B3.
@ $91A9 label=CheckShotCollisions_Offset
  $91A9,$03 Fetch the value from the object.
  $91AC,$01 Add one.
  $91AD,$06 Jump to #R$91C7 if bit 7 of the third set of flags of the object is
. set.
@ $91B3 label=CheckShotCollisions_Range
  $91B3,$03 Fetch the value from #R$5C1E.
  $91B6,$01 Add one to the vertical position.
  $91B7,$01 Compare it with the vertical position.
  $91B8,$02 Jump to #R$91E3 if it is lower.
  $91BA,$01 Subtract one again.
  $91BB,$03 Fetch the vertical position of the hit data.
  $91BE,$02 Add three.
  $91C0,$01 Compare it with the vertical position.
  $91C1,$02 Jump to #R$91E3 if it is lower.
  $91C3,$02 Set the width to five.
  $91C5,$02 Jump to #R$91C9.
@ $91C7 label=CheckShotCollisions_Wide
  $91C7,$02 Set the width to eight.
@ $91C9 label=CheckShotCollisions_Height
  $91C9,$02 Set the height to eight.
  $91CB,$06 Jump to #R$91DA if bit 7 of the third set of flags of the object is
. set.
  $91D1,$03 Fetch the value from the object.
  $91D4,$03 Multiply it by eight.
  $91D7,$02 Jump to #R$91E3 if it is zero.
  $91D9,$01 Use it as the height.
@ $91DA label=CheckShotCollisions_Check
  $91DA,$03 Check for a collision.
  $91DD,$03 Fetch the value from #R$5C1C.
  $91E0,$01 Test it.
  $91E1,$02 Jump to #R$91EF if there has been a collision.
@ $91E3 label=CheckShotCollisions_Next
  $91E3,$03 Set the length of an object.
  $91E6,$02 Move on to the next object.
  $91E8,$01 Restore the counter.
  $91E9,$01 Decrease the counter by one...
  $91EA,$02 ...and loop back to #R$918B until none remain.
  $91EC,$02 Restore the address of the object.
  $91EE,$01 Return.
@ $91EF label=CheckShotCollisions_Hit
  $91EF,$02 Restore the address of the object.
  $91F1,$06 Jump to #R$920B if bit 7 of the third set of flags of the shot is
. clear.
  $91F7,$04 Set bit 4 of the flags of the shot.
  $91FB,$03 Fetch the type of the object that was hit.
  $91FE,$04 Jump to #R$920B if it is not #N$19.
  $9202,$03 Add one to the third state byte of the object.
  $9205,$03 Play the explosion sound.
  $9208,$03 Score the points for the object.
@ $920B label=CheckShotCollisions_Mark
  $920B,$04 Set bit 7 of the flags of the shot.
  $920F,$04 Set bit 5 of the flags of the object that was hit.
  $9213,$04 Test bit 7 of the second value of the shot.
  $9217,$01 Return if it is clear.
  $9218,$04 Set bit 3 of the second set of flags of the object.
  $921C,$04 Clear bit 5 of its flags.
  $9220,$03 Fetch the type of the object.
  $9223,$04 Jump to #R$9234 if it is not #N$19.
  $9227,$03 Fetch the attribute of the object.
  $922A,$01 Increment it.
  $922B,$01 Return if it was not #N($FF).
  $922C,$03 Score the points for the object.
  $922F,$02 Fetch a pseudo-random value from the refresh register.
  $9231,$03 Jump to #R$A8AA.

c $9234 Score Destroyed Object
@ $9234 label=ScoreDestroyedObject
D $9234 Adds the points for an object to the score of player one. The points
. come from the table at #R$929C, indexed by the type of the object. Objects
. of type #N$0D and #N$1B are worth #N$0250 points. The points are doubled
. if bit 3 of the second flags of the object is set.
E $9234 Continue on to #R$925E.
R $9234 IX Address of the object
  $9234,$03 Fetch the type of the object.
  $9237,$04 Jump to #R$923F if it is #N$0D.
  $923B,$04 Jump to #R$9244 if it is not #N$1B.
@ $923F label=ScoreDestroyedObject_Fixed
  $923F,$03 Set the points to #N$0250.
  $9242,$02 Jump to #R$925E.
@ $9244 label=ScoreDestroyedObject_Table
  $9244,$02 Subtract #N$13 from the type.
  $9246,$01 Double it.
  $9247,$03 Use the table at #R$929C.
  $924A,$03 Add the offset to the address.
  $924D,$03 Fetch the points into #REGbc.
  $9250,$06 Jump to #R$925E if bit 3 of the second set of flags is clear.
  $9256,$07 Double the points.
  $925D,$01 Keep the result in #REGb.

c $925E Add To Score
@ $925E label=AddToScore
D $925E Adds points to the score of player one and prints the new score. The
. score is held as three bytes of binary coded decimal at #R$F5E7.
R $925E BC Points (binary coded decimal)
  $925E,$03 Use the score.
  $9261,$02 Add the low byte of the points.
  $9263,$01 Adjust for decimal.
  $9264,$01 Store the result.
  $9265,$01 Move on to the next byte.
  $9266,$02 Add the middle byte of the points.
  $9268,$01 Adjust for decimal.
  $9269,$01 Store the result.
  $926A,$01 Move on to the last byte.
  $926B,$03 Add the carry.
  $926E,$01 Adjust for decimal.
  $926F,$01 Store the result.
  $9270,$03 Use the text record for the score at #R$C9EC.
  $9273,$02 Set a counter for three bytes.
@ $9275 label=AddToScore_Digits
  $9275,$01 Fetch a byte of the score.
  $9276,$04 Shift the top four bits into the bottom four.
  $927A,$02,b$01 Keep them.
  $927C,$02 Add #N$1A to make the character code of the digit.
  $927E,$02 Store it in the text record.
  $9280,$01 Fetch the byte of the score again.
  $9281,$02,b$01 Keep the bottom four bits.
  $9283,$02 Add #N$1A to make the character code of the digit.
  $9285,$02 Store it in the text record.
  $9287,$01 Move back to the previous byte of the score.
  $9288,$02 Decrease the counter by one and loop back to #R$9275 until none
. remain.
  $928A,$03 Use the text record.
  $928D,$01 Switch registers.
  $928E,$03 Save the registers.
  $9291,$03 Use the text record.
  $9294,$03 Print the score.
  $9297,$03 Restore the registers.
  $929A,$01 Switch registers back.
  $929B,$01 Return.

b $929C Points Table
@ $929C label=PointsTable
D $929C The points for each type of object from #N($13) to #N($1E), as two
. bytes of binary coded decimal.
B $929C,$18,$02

c $92B4 Choose Target
@ $92B4 label=ChooseTarget
D $92B4 Looks through the first seven enemy slots for the active object with
. the highest priority and stores the number of its slot in the top four bits
. of the second set of flags of the object in #REGix. The priority of each
. type of object comes from the table at #R$92EE.
R $92B4 IX Address of the object that is choosing
  $92B4,$04 Use the first enemy slot.
  $92B8,$02 Set a counter for seven slots.
  $92BA,$04 Clear the highest priority so far.
@ $92BE label=ChooseTarget_Loop
  $92BE,$06 Jump to #R$92E6 if bit 7 of the flags of the object in the slot is
. clear.
  $92C4,$03 Fetch the type of the object.
  $92C7,$01 Increment it.
  $92C8,$02 Jump to #R$92E6 if the slot is free.
  $92CA,$02 Subtract #N($14), which leaves the type minus #N($13) as the type
. has been incremented.
  $92CC,$03 Use the table at #R$92EE.
  $92CF,$03 Add the offset to the address.
  $92D2,$03 Fetch the highest priority so far from #R$5C1C.
  $92D5,$01 Compare it with the priority of this type.
  $92D6,$02 Jump to #R$92E6 if it is not lower.
  $92D8,$01 Fetch the priority of this type.
  $92D9,$03 Make it the highest priority so far.
  $92DC,$01 Fetch the slot counter.
  $92DD,$02,b$01 Turn it into the number of the slot.
  $92DF,$04 Shift the number into the top four bits.
  $92E3,$03 Store it in the second set of flags of the object.
@ $92E6 label=ChooseTarget_Next
  $92E6,$03 Set the length of a slot.
  $92E9,$02 Move on to the next slot.
  $92EB,$02 Decrease the slot counter by one and loop back to #R$92BE until none
. remain.
  $92ED,$01 Return.

b $92EE Target Priorities
@ $92EE label=TargetPriorities
D $92EE The priority of each type of object for #R$92B4, starting at type
. #N$13.
B $92EE,$0C,$0C

c $92FA Set Facing
@ $92FA label=SetFacing
D $92FA Sets the first state byte of an object to zero, or one if the object is
. moving left.
R $92FA IX Address of the object
  $92FA,$04 Clear the first state byte.
  $92FE,$04 Test bit 7 of the horizontal speed.
  $9302,$01 Return if it is clear.
  $9303,$03 Set the first state byte to one.
  $9306,$01 Return.

c $9307 Update Chasing Object
@ $9307 label=UpdateChasingObject
D $9307 Moves an object that is chasing one of the enemies. The slot number of
. the target is held in the top four bits of the second set of flags; when all
. four are set, a new target is chosen with #R$92B4.
R $9307 IX Address of the object
  $9307,$03 Fetch the second set of flags.
  $930A,$02,b$01 Keep the top four bits.
  $930C,$02 Are all of them set?
  $930E,$03 Choose a target if so.
  $9311,$03 Fetch the second set of flags again.
  $9314,$02,b$01 Keep the top four bits.
  $9316,$05 Jump to #R$938D if all of them set are.
  $931B,$04 Shift the slot number into the bottom four bits.
  $931F,$01 Keep it in #REGb.
  $9320,$03 Set the length of a slot.
  $9323,$04 Use the first enemy slot.
  $9327,$01 Test the slot number.
  $9328,$02 Jump to #R$932E if it is zero.
@ $932A label=UpdateChasingObject_Find
  $932A,$02 Move on to the next slot.
  $932C,$02 Decrease the slot number by one and loop back to #R$932A until none
. remain.
@ $932E label=UpdateChasingObject_Target
  $932E,$03 Fetch the type of the object in the target slot.
  $9331,$01 Increment it.
  $9332,$02 Jump to #R$933B if the slot is in use.
  $9334,$04 Otherwise forget the target.
  $9338,$03 Jump to #R$938D.
@ $933B label=UpdateChasingObject_Chase
  $933B,$03 Set the acceleration towards the target.
  $933E,$03 Jump to #R$938D.

c $9341 Accelerate Towards Target
@ $9341 label=AccelerateTowardsTarget
D $9341 Sets the acceleration of an object so that it heads towards another
. object.
R $9341 IX Address of the object that is moving
R $9341 IY Address of the object that is the target
  $9341,$08 Set the horizontal acceleration to #N$00C0.
  $9349,$03 Fetch the map column of the object.
  $934C,$03 Compare it with the map column of the target.
  $934F,$02 Jump to #R$935B if they are different.
  $9351,$03 Fetch the horizontal position of the object.
  $9354,$03 Compare it with the horizontal position of the target.
  $9357,$02 Jump to #R$9365 if it is not lower.
  $9359,$02 Jump to #R$936D.
@ $935B label=AccelerateTowardsTarget_Column
  $935B,$03 Fetch the column from #R$DDF7.
  $935E,$03 Compare it with the map column of the object.
  $9361,$02 Jump to #R$9365 if they are the same.
  $9363,$02 Jump to #R$936D.
@ $9365 label=AccelerateTowardsTarget_Left
  $9365,$08 Set the horizontal acceleration to #N$FF40.
@ $936D label=AccelerateTowardsTarget_Vertical
  $936D,$06 Fetch the map zone and vertical position of the object into #REGhl.
  $9373,$06 Fetch the map zone and vertical position of the target into #REGde.
  $9379,$02 Subtract them.
  $937B,$08 Set the vertical acceleration to #N$00C0.
  $9383,$01 Return if the target is lower.
  $9384,$08 Otherwise set the vertical acceleration to #N$FF40.
  $938C,$01 Return.

c $938D Update Object
@ $938D label=UpdateObject
D $938D Part of #R$9307. Redraws the object, moves it, counts down its
. lifetime and gives it a position.
R $938D IX Address of the object
  $938D,$03 Reset the collision state.
  $9390,$04 Test bit 7 of the flags of the object.
  $9394,$03 Call #R$AD27 if it is set.
  $9397,$04 Clear bit 6 of the flags of the object.
  $939B,$01 Switch registers.
  $939C,$03 Move the object.
  $939F,$03 Set the facing of the object.
  $93A2,$03 Count down the lifetime of the object.
  $93A5,$02 Jump to #R$93AE if it has not run out.
@ $93A7 label=UpdateObject_Remove
  $93A7,$04 Free the slot.
  $93AB,$03 Jump to #R$93EC.
@ $93AE label=UpdateObject_Flags
  $93AE,$06 Jump to #R$93A7 if bit 4 of the flags of the object is set.
  $93B4,$03 #REGbc=#N$0B10.
  $93B7,$03 Nudge the object and reverse its speeds.
  $93BA,$03 Fetch the map position from #R$CE57.
  $93BD,$02 Clear #REGb.
  $93BF,$01 Fetch the map column.
  $93C0,$03 Compare it with the map column of the object.
  $93C3,$02 Jump to #R$93C7 if they are the same.
  $93C5,$02 Add two to #REGb.
@ $93C7 label=UpdateObject_Zone
  $93C7,$01 Fetch the map zone.
  $93C8,$03 Compare it with the map zone of the object.
  $93CB,$02 Jump to #R$93CE if they are the same.
  $93CD,$01 Add one to #REGb.
@ $93CE label=UpdateObject_Table
  $93CE,$01 #REGa=#REGb.
  $93CF,$03 Use the table at #R$DC91.
  $93D2,$03 Add the offset to the address.
  $93D5,$01 Fetch the entry.
  $93D6,$04 Jump to #R$93E9 if it is not #N$3E.
  $93DA,$03 Fetch the horizontal position of the object.
  $93DD,$04 Jump to #R$93E9 if it is lower than #N$18.
  $93E1,$04 Jump to #R$93E9 if it is #N$D8 or higher.
  $93E5,$04 Set the vertical position of the object to #N$6A.
@ $93E9 label=UpdateObject_Draw
  $93E9,$03 Draw the object.
@ $93EC label=UpdateObject_Finish
  $93EC,$03 Call #R$AD1B.
  $93EF,$03 Jump to #R$AE98.

c $93F2 Update Type 13 Object
@ $93F2 label=UpdateType13
D $93F2 The code for an object of type #N($13), which is run by
. #R$A18D.
R $93F2 IX Address of the object
  $93F2,$05 Set the collision effects in #R$8E2C to #N$80.
  $93F7,$03 Fetch the map zone of the object.
  $93FA,$04 Jump to #R$940B if it is not #N$0A.
  $93FE,$03 Fetch the vertical position of the object.
  $9401,$04 Jump to #R$9413 if it is lower than #N$A0.
  $9405,$04 Set bit 3 of the second set of flags of the object.
  $9409,$02 Jump to #R$9413.
@ $940B label=UpdateType13_Zone3
  $940B,$04 Jump to #R$9413 if the map is not zone #N$03.
  $940F,$04 Set bit 3 of the second set of flags of the object.
@ $9413 label=UpdateType13_Move
  $9413,$05 Set #R$5C1C to #N$03.
  $9418,$03 Fetch the attribute of the object.
  $941B,$02 Is it #N$77?
  $941D,$02 Stash #REGiy on the stack.
  $941F,$03 Fire a random shot if so.
  $9422,$02 Bring #REGiy back off the stack.
  $9424,$03 Fetch the flags of the object.
  $9427,$02,b$01 Keep the bottom two bits.
  $9429,$04 Jump to #R$9435 if they are not both set.
  $942D,$08 Clear the vertical acceleration of the object.
@ $9435 label=UpdateType13_Accelerate
  $9435,$03 Move the object.
  $9438,$03 #REGbc=#N$2030.
  $943B,$03 Fetch the first state byte of the object.
  $943E,$01 Test it.
  $943F,$03 Jump to #R$9518 if it is zero.
  $9442,$03 Fetch the number of active enemies from #R$8E2B.
  $9445,$04 Add one and store it.
  $9449,$03 Jump to #R$9518.
@ $944C label=UpdateType13_Table
B $944C,$0B,$0B

c $9457 Update Type 1C Object
@ $9457 label=UpdateType1C
D $9457 The code for an object of type #N($1C), which is run by
. #R$A18D.
R $9457 IX Address of the object
  $9457,$03 Fetch the first state byte of the object.
  $945A,$02,b$01 Keep the bottom four bits.
  $945C,$03 Use the table at #R$944C.
  $945F,$03 Add the offset to the address.
  $9462,$01 Fetch the collision effects for this state.
  $9463,$03 Store them in #R$8E2C.
  $9466,$03 Fetch the second state byte of the object.
  $9469,$02 Is it two?
  $946B,$03 Move the object if so.
  $946E,$03 Fetch the first state byte of the object.
  $9471,$02,b$01 Keep the bottom four bits.
  $9473,$02 Is it eight?
  $9475,$02 #REGc=#N$2A.
  $9477,$02 Jump to #R$9482 if so.
  $9479,$04 Jump to #R$9482 if it is nine.
  $947D,$03 Step the state of the object.
  $9480,$02 #REGc=#N$18.
@ $9482 label=UpdateType1C_Finish
  $9482,$02 #REGb=#N$18.
  $9484,$03 Move the object and stop it.
  $9487,$03 Count down the lifetime of the object.
  $948A,$03 Jump to #R$951B if it has not run out.
  $948D,$04 Set bit 3 of the second set of flags of the object.
  $9491,$03 Jump to #R$951B.

c $9494 Update Type 1D Object
@ $9494 label=UpdateType1D
D $9494 The code for an object of type #N($1D), which is run by
. #R$A18D.
R $9494 IX Address of the object
  $9494,$05 Set the collision effects in #R$8E2C to #N$51.
  $9499,$03 Explode the object if it has been hit.
  $949C,$03 Step the state of the object.
  $949F,$03 #REGbc=#N$2020.
  $94A2,$03 Move the object and stop it.
  $94A5,$03 Jump to #R$951B.

c $94A8 Update Type 19 Object
@ $94A8 label=UpdateType19
D $94A8 The code for an object of type #N($19), which is run by
. #R$A18D.
R $94A8 IX Address of the object
  $94A8,$03 Play a sound.
  $94AB,$04 Make the attribute of the object #N$55.
  $94AF,$06 Jump to #R$94C5 if bit 5 of the flags of the object is clear.
  $94B5,$03 Fetch the frame counter from #R$9A64.
  $94B8,$02,b$01 Keep the bottom three bits.
  $94BA,$02 Jump to #R$94C5 if any are set.
  $94BC,$03 Add one to the third state byte of the object.
  $94BF,$03 Score the points for the object.
  $94C2,$03 Play the explosion sound.
@ $94C5 label=UpdateType19_Clear
  $94C5,$04 Clear bit 5 of the flags of the object.
  $94C9,$03 Fetch the third state byte of the object.
  $94CC,$02,b$01 Keep the bottom six bits.
  $94CE,$04 Jump to #R$94D6 if it is not ten or more.
  $94D2,$04 Make the attribute of the object #N($FF).
@ $94D6 label=UpdateType19_Count
  $94D6,$04 Jump to #R$94E1 if it is not fourteen or more.
  $94DA,$04 Set bit 3 of the second set of flags of the object.
  $94DE,$03 Score the points for the object.
@ $94E1 label=UpdateType19_Shoot
  $94E1,$02 Stash #REGiy on the stack.
  $94E3,$03 Fetch the first state byte of the object.
  $94E6,$02,b$01 Keep bit 0.
  $94E8,$02 Add seven.
  $94EA,$03 Store it in #R$5C1C.
  $94ED,$03 Fire a random shot.
  $94F0,$02 Bring #REGiy back off the stack.
  $94F2,$03 Run the behaviour code for the object.
  $94F5,$03 Move the object.
  $94F8,$03 Fetch the horizontal speed of the object.
  $94FB,$03 Combine it with the low byte of the speed.
  $94FE,$03 Set the facing of the object if it is moving.
  $9501,$03 #REGbc=#N$1830.
  $9504,$03 Jump to #R$9518.

c $9507 Update Type 14 Object
@ $9507 label=UpdateType14
D $9507 The code for objects of type #N($14), #N($16), #N($17), #N($18) and
. #N($1A), which is run by #R$A18D.
R $9507 IX Address of the object
  $9507,$03 Explode the object if it has been hit.
  $950A,$02 Jump to #R$9512 if it was.
  $950C,$03 Run the behaviour code for the object.
  $950F,$03 Move the object.
@ $9512 label=UpdateType14_Step
  $9512,$03 Step the state of the object.
  $9515,$03 #REGbc=#N$2322.
@ $9518 label=UpdateType14_Move
  $9518,$03 Move the object back and forth.
@ $951B label=UpdateType14_Flags
  $951B,$03 Process the flags of the object.
@ $951E label=UpdateType14_Draw
  $951E,$03 Call #R$AD1B.
  $9521,$03 Jump to #R$AE98.

c $9524 Update Type 1E Object
@ $9524 label=UpdateType1E
D $9524 The code for an object of type #N($1E), which is run by
. #R$A18D.
R $9524 IX Address of the object
  $9524,$05 Set the collision effects in #R$8E2C to #N$10.
  $9529,$03 Move the object.
  $952C,$03 Update the position of the object.
  $952F,$03 Fetch the map zone of the object.
  $9532,$03 Compare it with the third state byte of the object.
  $9535,$02 Jump to #R$9543 if they are different.
  $9537,$03 Fetch the vertical position of the object.
  $953A,$03 Compare it with the fourth state byte of the object.
  $953D,$02 Jump to #R$9543 if it is lower.
  $953F,$04 Set bit 4 of the flags of the object.
@ $9543 label=UpdateType1E_Flags
  $9543,$03 Process the flags of the object.
  $9546,$01 Stash #REGhl on the stack.
  $9547,$03 Fetch the address of the object from #R$AD46.
  $954A,$01 Fetch the type of the object.
  $954B,$01 Increment it.
  $954C,$02 Jump to #R$955B if it is in use.
  $954E,$03 Fetch the value from #R$F602.
  $9551,$04 Add one and store it.
  $9555,$03 Set the points to #N$1500.
  $9558,$03 Add them to the score.
@ $955B label=UpdateType1E_Finish
  $955B,$01 Bring #REGhl back off the stack.
  $955C,$03 Jump to #R$951E.

c $955F Set Object Position
@ $955F label=SetObjectPosition
D $955F Gives an object the position held in #R$96AC and #R$96AE.
R $955F IX Address of the object
  $955F,$03 Fetch the horizontal position from #R$96AC.
  $9562,$06 Set the horizontal position and the map column of the object.
  $9568,$03 Fetch the vertical position from #R$96AE.
  $956B,$06 Set the vertical position and the map zone of the object.
  $9571,$01 Return.

c $9572 Update Crystal Stack
@ $9572 label=UpdateCrystalStack
D $9572 Purpose not yet known. It builds a stack of objects in the slot at
. #R$9A4C, one for each of the crystals counted at #R$F602 and takes
. different action when the player's ship is in the right place on the map.
. Called once a frame.
  $9572,$04 Clear #R$8D3C.
  $9576,$03 Fetch the flag from #R$96AB.
  $9579,$01 Test it.
  $957A,$02 Jump to #R$958F if it is set.
  $957C,$03 Fetch the map position from #R$CE57.
  $957F,$01 Fetch the map column.
  $9580,$04 Jump to #R$9587 if it is #N$51.
  $9584,$02 Is it #N$52?
  $9586,$01 Return if not.
@ $9587 label=UpdateCrystalStack_Zone
  $9587,$01 Fetch the map zone.
  $9588,$04 Jump to #R$958F if it is #N$09.
  $958C,$02 Is it #N$0A?
  $958E,$01 Return if not.
@ $958F label=UpdateCrystalStack_Count
  $958F,$03 Fetch the number of crystals from #R$F602.
  $9592,$01 Test it.
  $9593,$01 Return if there are none.
  $9594,$01 Add one.
  $9595,$02 Halve it.
  $9597,$03 Store the result in #R$8D3C.
  $959A,$04 Use the slot at #R$9A4C.
  $959E,$04 Clear the first state byte of the object.
  $95A2,$03 Fetch the flag from #R$96AB.
  $95A5,$01 Test it.
  $95A6,$02 Jump to #R$95DA if it is clear.
  $95A8,$03 Fetch the frame counter from #R$9A64.
  $95AB,$02,b$01 Keep the bottom two bits.
  $95AD,$03 Play a sound.
  $95B0,$03 Set the position of the object.
  $95B3,$03 Fetch the speed from #R$CCBA.
  $95B6,$02 Negate it.
  $95B8,$03 Set the vertical speed of the object.
  $95BB,$03 Fetch the map zone from #R$CE58.
  $95BE,$01 Test it.
  $95BF,$02 Jump to #R$95C5 if it is not zero.
  $95C1,$04 Otherwise set the vertical speed of the object to #N$FC.
@ $95C5 label=UpdateCrystalStack_Move
  $95C5,$03 Update the position of the object.
  $95C8,$09 Store the horizontal position of the object in #R$96AC.
  $95D1,$09 Store the vertical position of the object in #R$96AE.
@ $95DA label=UpdateCrystalStack_Next
  $95DA,$03 Set the position of the object.
  $95DD,$04 Fetch the first state byte of the object and keep it in #REGb.
  $95E1,$03 Multiply it by five.
  $95E4,$03 Use the table at #R$96B0.
  $95E7,$03 Add the offset to the address.
  $95EA,$03 Use the data at #R$9A5C.
  $95ED,$03 Set the length to three.
  $95F0,$02 Copy the three bytes.
  $95F2,$01 Fetch the next byte of the table.
  $95F3,$03 Set the horizontal speed of the object.
  $95F6,$01 Fetch the next byte of the table.
  $95F7,$04 Set the vertical speed of the object.
  $95FB,$03 Update the position of the object.
  $95FE,$04 Clear the horizontal speed.
  $9602,$04 Clear the vertical speed.
  $9606,$03 Fetch the first state byte of the object.
  $9609,$04 Jump to #R$9611 if it is not six.
  $960D,$04 Set the first state byte to eight.
@ $9611 label=UpdateCrystalStack_Draw
  $9611,$03 Reset the collision state.
  $9614,$04 Test bit 7 of the flags of the object.
  $9618,$03 Call #R$AD27 if it is set.
  $961B,$04 Clear bit 6 of the flags of the object.
  $961F,$01 Switch registers.
  $9620,$03 Process the flags of the object.
  $9623,$03 Call #R$AD1B.
  $9626,$03 Call #R$AE98.
  $9629,$04 Use the slot at #R$9A4C.
  $962D,$03 Fetch the first state byte of the object.
  $9630,$04 Jump to #R$9639 if it is not eight.
  $9634,$02 Use six instead.
  $9636,$03 Store it.
@ $9639 label=UpdateCrystalStack_Copy
  $9639,$01 Keep the state in #REGb.
  $963A,$03 Multiply it by five.
  $963D,$03 Use the table at #R$96B0.
  $9640,$03 Add the offset to the address.
  $9643,$03 Use the data at #R$9A5C.
  $9646,$01 Swap the pointers.
  $9647,$03 Set the length to three.
  $964A,$02 Copy the three bytes back.
  $964C,$03 Move on to the next state.
  $964F,$03 Fetch the number of crystals from #R$F602.
  $9652,$03 Compare it with the state.
  $9655,$03 Jump to #R$95DA if they are different.
  $9658,$03 Fetch the number of crystals again.
  $965B,$02 Are there eight?
  $965D,$01 Return if not.
  $965E,$03 Fetch the flag from #R$96AB.
  $9661,$01 Test it.
  $9662,$02 Jump to #R$9672 if it is clear.
  $9664,$03 Call #R$C6D2.
  $9667,$03 Fetch the value from #R$96B0.
  $966A,$02,b$01 Keep bit 7.
  $966C,$01 Return if it is set.
  $966D,$01 Decrease it.
  $966E,$03 Store it in #R$96AB.
  $9671,$01 Return.
@ $9672 label=UpdateCrystalStack_Docked
  $9672,$03 Fetch the map column and horizontal position of the player from
. #N$C8E6.
  $9675,$01 Fetch the map column.
  $9676,$02 Is it #N$52?
  $9678,$01 Return if not.
  $9679,$01 Fetch the horizontal position.
  $967A,$02 Is it #N$5C?
  $967C,$01 Return if not.
  $967D,$03 Fetch the map zone and vertical position of the player from #N$C8E9.
  $9680,$01 Fetch the map zone.
  $9681,$02 Is it #N$0A?
  $9683,$01 Return if not.
  $9684,$01 Fetch the vertical position.
  $9685,$02 Is it lower than #N$63?
  $9687,$01 Return if so.
  $9688,$03 Set the flag at #R$96AB.
  $968B,$05 Set the explosion counter at #R$8F53 to #N$0A.
  $9690,$03 Call #R$C421.
  $9693,$03 Call #R$C4ED.
  $9696,$04 Clear the explosion counter.
  $969A,$05 Set #R$C27A to #N$80.
  $969F,$03 Call #R$C1CE.
  $96A2,$06 Clear #N$C8FE.
  $96A8,$03 Play the explosion sound.
B $96AB,$01,$01
W $96AC,$02,$02
W $96AE,$02,$02
@ $96B0 label=UpdateCrystalStack_Table
B $96B0,$28,$05

c $96D8 Update Type 15 Object
@ $96D8 label=UpdateType15
D $96D8 The code for an object of type #N($15), which is run by #R$A18D. The
. speeds of the object follow the table at #R$9873, which ends with #N$80.
R $96D8 IX Address of the object
  $96D8,$04 Clear the collision effects in #R$8E2C.
  $96DC,$03 Play a sound.
  $96DF,$03 Fetch the lifetime of the object.
  $96E2,$02,b$01 Keep the bottom six bits.
  $96E4,$03 Use the table at #R$9873.
  $96E7,$03 Add the offset to the address.
  $96EA,$01 Fetch the horizontal speed from the table.
  $96EB,$04 Jump to #R$96F6 if it is not the end of the table.
  $96EF,$04 Free the slot.
  $96F3,$03 Jump to #R$951E.
@ $96F6 label=UpdateType15_Speed
  $96F6,$03 Set the horizontal speed of the object.
  $96F9,$02 Fetch the vertical speed from the table.
  $96FB,$03 Set the vertical speed of the object.
  $96FE,$06 Move two steps along the table.
  $9704,$06 Jump to #R$9712 if bit 7 of the lifetime of the object is clear.
  $970A,$08 Reverse the horizontal speed.
@ $9712 label=UpdateType15_Vertical
  $9712,$07 Jump to #R$9512 if bit 6 of the lifetime of the object is clear.
  $9719,$08 Reverse the vertical speed.
  $9721,$03 Jump to #R$9512.

c $9724 Start Crystal Object
@ $9724 label=StartCrystalObject
D $9724 Purpose not yet known. Starts an object of type #N($1E) at a fixed
. map position when the player is in the right place and the value at #R$F601
. is not #N($FF).
  $9724,$03 Fetch the value from #R$F601.
  $9727,$01 Increment it.
  $9728,$01 Return if it was #N($FF).
  $9729,$03 Fetch the map zone of the player from #N$C8E9.
  $972C,$02 Is it #N$0B or more?
  $972E,$01 Return if so.
  $972F,$03 Fetch the map column of the player from #N$C8E6.
  $9732,$02 Is it #N$52?
  $9734,$01 Return if not.
  $9735,$03 Fetch the horizontal position of the player from #N$C8E7.
  $9738,$02 Is it #N$5C?
  $973A,$01 Return if not.
  $973B,$03 Fetch the value from #R$F601.
  $973E,$04 Jump to #R$974A if it is not six.
  $9742,$03 Fetch the value from #R$C905.
  $9745,$02 Is it #N$12?
  $9747,$01 Return if not.
  $9748,$02 Use #N$08.
@ $974A label=StartCrystalObject_Set
  $974A,$02,b$01 Set bit 7.
  $974C,$03 Store the value in #N$C904.
  $974F,$03 Find a free slot.
  $9752,$03 Clear the slot.
  $9755,$03 Fetch the value from #N$C900.
  $9758,$03 Swap the bytes...
  $975B,$03 ...and negate the result.
  $975E,$06 Set the vertical speed of the object.
  $9764,$04 Set the flags of the object to #N$23.
  $9768,$04 Set the vertical acceleration of the object.
  $976C,$04 Set the type of the object to #N$1E.
  $9770,$03 Fetch the value from #R$F601.
  $9773,$03 Set the first state byte of the object.
  $9776,$01 Keep a copy in #REGb.
  $9777,$03 Multiply it by five.
  $977A,$02 Add four.
  $977C,$03 Use the table at #R$96B0.
  $977F,$03 Add the offset to the address.
  $9782,$01 Fetch the value from the table.
  $9783,$03 Add #N$73.
  $9786,$03 Set the third state byte of the object.
  $9789,$03 Fetch the map zone of the player from #N$C8E9.
  $978C,$03 Set the map zone of the object.
  $978F,$04 Set the map column of the object to #N$52.
  $9793,$04 Set the horizontal position of the object to #N$68.
  $9797,$03 Fetch the vertical position of the player from #N$C8EA.
  $979A,$03 Set the vertical position of the object.
  $979D,$04 Make the attribute of the object #N($FF).
  $97A1,$04 Set the lifetime of the object to ten.
  $97A5,$03 Fetch the value from #R$F601.
  $97A8,$04 Jump to #R$97B7 if it is not six.
  $97AC,$04 Set the first state byte of the object to eight.
  $97B0,$04 Clear #R$C905.
  $97B4,$03 Clear #R$F600.
@ $97B7 label=StartCrystalObject_Done
  $97B7,$05 Set #R$F601 to #N($FF).
  $97BC,$01 Return.

c $97BD Find Free Enemy Slot
@ $97BD label=FindFreeEnemySlot
D $97BD Looks for a free slot among the nine enemy slots. If there is not one,
. it looks for an object with bit 7 of its flags set among the first eight.
R $97BD O:IX Address of the slot
  $97BD,$02 Set a counter for nine slots.
  $97BF,$04 Use the first enemy slot.
  $97C3,$03 Set the length of a slot.
@ $97C6 label=FindFreeEnemySlot_Loop
  $97C6,$03 Fetch the type of the object in the slot.
  $97C9,$01 Increment it.
  $97CA,$01 Return if the slot is free.
  $97CB,$02 Move on to the next slot.
  $97CD,$02 Decrease the counter by one and loop back to #R$97C6 until none
. remain.
  $97CF,$04 Use the first enemy slot.
  $97D3,$02 Set a counter for eight slots.
@ $97D5 label=FindFreeEnemySlot_Flags
  $97D5,$04 Test bit 7 of the flags of the object.
  $97D9,$01 Return if it is clear.
  $97DA,$02 Move on to the next slot.
  $97DC,$02 Decrease the counter by one and loop back to #R$97D5 until none
. remain.
  $97DE,$01 Return.

c $97DF Run Object Behaviour
@ $97DF label=RunObjectBehaviour
D $97DF Counts down a timer for an object and, when it has expired, runs the
. behaviour code for its type from the table at #R$993B.
R $97DF IX Address of the object
  $97DF,$06 Jump to #R$97F2 if bit 7 of the third state byte of the object is
. set.
  $97E5,$03 Count down the lifetime of the object.
  $97E8,$01 Return if it has not run out.
  $97E9,$03 Fetch the second byte of the random seed.
  $97EC,$02,b$01 Keep five bits.
  $97EE,$01 Add one.
  $97EF,$03 Restart the lifetime of the object.
@ $97F2 label=RunObjectBehaviour_Run
  $97F2,$03 Fetch the type of the object.
  $97F5,$02 Subtract #N$13.
  $97F7,$01 Copy it into #REGc.
  $97F8,$03 Use the table at #R$993B.
  $97FB,$03 Fetch the address of the code from the table.
  $97FE,$01 Run it.

c $97FF Chase Player
@ $97FF label=ChasePlayer
D $97FF Behaviour code used for several types of object (see #R$97DF). Makes
. the object accelerate towards the player and then halves the acceleration.
R $97FF IX Address of the object
  $97FF,$02 Stash #REGiy on the stack.
  $9801,$04 Use the player's object.
  $9805,$03 Accelerate towards the player.
  $9808,$02 Bring #REGiy back off the stack.
  $980A,$04 Set bit 7 of the third state byte of the object.
  $980E,$06 Fetch the horizontal acceleration of the object.
  $9814,$08 Halve it twice.
  $981C,$06 Store it.
  $9822,$06 Fetch the vertical acceleration of the object.
  $9828,$08 Halve it twice.
  $9830,$06 Store it.
  $9836,$01 Return.

c $9837 Chase Player Briefly
@ $9837 label=ChasePlayerBriefly
D $9837 Behaviour code used for objects of type #N($17) (see #R$97DF). Makes
. the object accelerate towards the player and then gives it a new lifetime.
R $9837 IX Address of the object
  $9837,$02 Stash #REGiy on the stack.
  $9839,$04 Use the player's object.
  $983D,$03 Accelerate towards the player.
  $9840,$02 Bring #REGiy back off the stack.
  $9842,$03 Fetch the first byte of the random seed.
  $9845,$02,b$01 Keep four bits.
  $9847,$02 Add ten.
  $9849,$03 Set the lifetime of the object.
  $984C,$01 Return.

c $984D Accelerate Randomly
@ $984D label=AccelerateRandomly
D $984D Behaviour code used for objects of type #N($18) and #N($1A) (see
. #R$97DF). Gives the object a random acceleration.
R $984D IX Address of the object
  $984D,$03 Fetch the first byte of the random seed.
  $9850,$02,b$01 Keep bit 0.
  $9852,$03 Choose a horizontal acceleration.
  $9855,$06 Set the horizontal acceleration of the object.
  $985B,$03 Fetch the first byte of the random seed.
  $985E,$02,b$01 Keep bit 1.
  $9860,$03 Choose a vertical acceleration.
  $9863,$06 Set the vertical acceleration of the object.
  $9869,$01 Return.

c $986A Choose Acceleration
@ $986A label=ChooseAcceleration
D $986A Chooses an acceleration of #N$FFE0 or #N$0020.
R $986A F The zero flag selects the negative acceleration
R $986A O:DE Acceleration
  $986A,$04 Use #N$FFE0 as the acceleration.
  $986E,$01 Return if the zero flag is set.
  $986F,$03 Use #N$0020 as the acceleration.
  $9872,$01 Return.

b $9873 Explosion Speeds
@ $9873 label=ExplosionSpeeds
D $9873 Pairs of horizontal and vertical speeds used by #R$96D8, ending with
. #N$80.
B $9873,$20,$02
B $9893,$01,$01

b $9894 Frame Tables
@ $9894 label=FrameTables
D $9894 Purpose not yet fully known. Tables of addresses used with the sprite
. for each type of object (see #R$AF3D).
W $9894,$0C,$02
W $98A0,$18,$02
W $98B8,$0A,$02
W $98C2,$16,$02
B $98D8,$22,$08
W $98FA,$10,$02

b $990A Enemy Spawn Table
@ $990A label=EnemySpawnTable
D $990A Ten entries of four bytes used by #R$89D3 to set up an enemy: its type,
. its flags and its two state bytes.
B $990A,$28,$04

b $9932 Enemy Spawn Counter
@ $9932 label=EnemySpawnCounter
D $9932 The counter used by #R$89D3.
B $9932,$01,$01

b $9933 Enemy Attributes
@ $9933 label=EnemyAttributes
D $9933 The attributes used for enemies by #R$89D3.
B $9933,$01 #COLOUR(#PEEK(#PC)).
L $9933,$01,$08

b $993B Behaviour Table
@ $993B label=BehaviourTable
D $993B The behaviour code for each type of object from #N($13), used by
. #R$97DF.
W $993B,$10,$02

c $994B Clear Object Speeds
@ $994B label=ClearObjectSpeeds
D $994B Clears the speeds of an object.
R $994B IX Address of the object
  $994B,$03 Call #R$B8FC.
  $994E,$0C Clear the speeds of the object.
  $995A,$01 Return.

c $995B Run Type 19 Behaviour
@ $995B label=RunType19Behaviour
D $995B Behaviour code for objects of type #N($19) (see #R$97DF). Gives the
. object a random lifetime and, with a small chance, chases the player.
R $995B IX Address of the object
  $995B,$03 Fetch the second byte of the random seed.
  $995E,$02,b$01 Keep six bits.
  $9960,$02 Add #N$10.
  $9962,$03 Set the lifetime of the object.
  $9965,$02 Fetch a pseudo-random value from the refresh register.
  $9967,$02,b$01 Keep two bits.
  $9969,$03 Jump to #R$994B if they are zero.
  $996C,$03 Chase the player.
  $996F,$04 Clear bit 7 of the third state byte of the object.
  $9973,$01 Return.

g $9974 Enemy Slots
@ $9974 label=EnemySlots
D $9974 Nine slots of #N$18 bytes, one for each enemy or similar object.
. Each slot is laid out as follows:
. #TABLE(default,centre,centre)
. { =h Offset | =h Contents }
. { #N$00 | Type of the object (#N($FF) if the slot is free) }
. { #N$01 | Map column }
. { #N$02 | Horizontal position }
. { #N$04 | Map zone }
. { #N$05 | Vertical position }
. { #N$07-#N$08 | Horizontal speed }
. { #N$09-#N$0A | Vertical speed }
. { #N$0B-#N$0C | Horizontal acceleration }
. { #N$0D | Attribute }
. { #N$0E-#N$0F | Vertical acceleration }
. { #N$10 | Flags }
. { #N$11-#N$12 | Horizontal and vertical screen position }
. { #N$13-#N$14 | State }
. { #N$15 | Lifetime }
. { #N$16-#N$17 | More flags }
. TABLE#
B $9974,$60,$18
@ $99D4 label=EnemySlots_Fifth
B $99D4,$48,$18
@ $9A1C label=EnemySlots_Eighth
B $9A1C,$30,$18

g $9A4C Crystal Stack Slot
@ $9A4C label=CrystalStackSlot
D $9A4C A tenth slot in the same format as the enemy slots, used by
. #R$9572.
B $9A4C,$10,$10
@ $9A5C label=CrystalStackSlot_Flags
B $9A5C,$08,$08

g $9A64 Frame Counter
@ $9A64 label=FrameCounter
D $9A64 A two byte counter that is incremented every frame, for example by
. #R$8615 and #R$C374.
W $9A64,$02,$02

c $9A66 Initialise Game
@ $9A66 label=InitialiseGame
D $9A66 The game starts here, after #R$5C80. It sets up the stack, makes the
. border black, builds the shift tables and then carries on at #R$F422.
  $9A66,$03 Set the stack pointer to #N$5B80.
  $9A69,$03 Set the border to black.
  $9A6C,$03 Build the shift tables.
  $9A6F,$03 Jump to #R$F422.

c $9A72 Fill Attributes White
@ $9A72 label=FillAttributesWhite
D $9A72 Sets every attribute on the screen to bright white ink on black.
  $9A72,$03 Use the first attribute.
@ $9A75 label=FillAttributesWhite_Loop
  $9A75,$02 Write the attribute.
  $9A77,$01 Move on to the next one.
  $9A78,$01 Fetch the high byte of the address.
  $9A79,$04 Jump back to #R$9A75 if all of the attributes have not been written.
  $9A7D,$01 Return.

c $9A7E Clear Pixels
@ $9A7E label=ClearPixels
D $9A7E Clears all of the pixels on the screen.
E $9A7E View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE60 }
. { #ATICATAC$80B4 }
. { #COOKIE$74D4 }
. { #GUNFRIGHT$D6DB }
. { #JETPAC$71B8 }
. { #KNIGHTLORE$D544 }
. { #LUNARJETMAN$84AD }
. { #NIGHTSHADE$E5A8 }
. { #PSSST$7439 }
. { #SABREWULF$BB81 }
. { #TRANZAM$7211 }
. LIST#
  $9A7E,$03 Use the start of the display file.
@ $9A81 label=ClearPixels_Loop
  $9A81,$02 Clear a byte.
  $9A83,$01 Move on to the next one.
  $9A84,$01 Fetch the high byte of the address.
  $9A85,$04 Jump back to #R$9A81 if the whole display file has not been cleared.
  $9A89,$01 Return.

c $9A8A Mask Map Table
@ $9A8A label=MaskMapTable
D $9A8A Applies a mask to every byte of the table at #R$5C94.
R $9A8A E Mask
  $9A8A,$03 Set the number of bytes in #REGbc.
  $9A8D,$03 Use the table.
@ $9A90 label=MaskMapTable_Loop
  $9A90,$01 Fetch a byte of the table.
  $9A91,$01 Apply the mask.
  $9A92,$01 Store the byte.
  $9A93,$01 Move on to the next one.
  $9A94,$01 Decrease the counter.
  $9A95,$02 Combine #REGb and #REGc.
  $9A97,$02 Jump back to #R$9A90 until the counter is zero.
  $9A99,$01 Return.

c $9A9A Play Music Until Key Pressed
@ $9A9A label=PlayMusic_WaitKey
D $9A9A Plays a tune made of notes, which ends with #N($FF). The tune stops
. as soon as a key is pressed.
E $9A9A View the equivalent code in;
. #LIST
. { #BUBBLER$A1B2 }
. LIST#
R $9A9A DE Address of the first note
  $9A9A,$01 Select every keyboard row.
  $9A9B,$03 Read the keyboard.
  $9A9E,$01 Return if a key is pressed.
  $9A9F,$01 Fetch a note.
  $9AA0,$04 Jump to #R$9AB3 if it is the end of the tune.
  $9AA4,$03 Play the note.
  $9AA7,$02 Jump back to #R$9A9A for the next note.

c $9AA9 Play Music
@ $9AA9 label=PlayMusic
D $9AA9 Plays a tune made of notes, which ends with #N($FF). The keyboard is
. not checked.
E $9AA9 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4BA }
. { #BUBBLER$A1C1 }
. { #GUNFRIGHT$AF8F }
. { #KNIGHTLORE$B2CF }
. { #MARTIANOIDS$C0CF }
. { #NIGHTSHADE$C656 }
. { #PENTAGRAM$D6B5 }
. LIST#
R $9AA9 DE Address of the first note
  $9AA9,$01 Fetch a note.
  $9AAA,$04 Jump to #R$9AB3 if it is the end of the tune.
  $9AAE,$03 Play the note.
  $9AB1,$02 Jump back to #R$9AA9 for the next note.
@ $9AB3 label=PlayMusic_Return
  $9AB3,$01 Return.

c $9AB4 Play Note
@ $9AB4 label=PlayNote
D $9AB4 Plays a single note of a tune. The bottom six bits of the note byte are
. the number of the note, where zero is a rest, and the top two bits are a
. multiplier for the length of the note.
E $9AB4 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4C5 }
. { #BUBBLER$A1CC }
. { #GUNFRIGHT$AF9A }
. { #KNIGHTLORE$B2DA }
. { #MARTIANOIDS$C0DA }
. { #NIGHTSHADE$C661 }
. { #PENTAGRAM$D6C0 }
. LIST#
R $9AB4 A Note byte
R $9AB4 DE Address of the note byte
R $9AB4 O:DE Address of the next note byte
  $9AB4,$02,b$01 Keep the note number.
  $9AB6,$02 Jump to #R$9AF6 if it is a rest.
  $9AB8,$04 Multiply the note number by three...
  $9ABC,$07 ...and add the address of the table of notes at #R$9B0C.
  $9AC3,$04 Fetch the half-period from the table into #REGbc.
  $9AC7,$01 Fetch the number of cycles into #REGl.
  $9AC8,$02 Clear #REGh.
  $9ACA,$01 Fetch the note byte again.
  $9ACB,$02 Move the top two bits to the bottom.
  $9ACD,$02,b$01 Keep them.
  $9ACF,$01 Add one to get a multiplier.
  $9AD0,$01 Save the address of the note.
  $9AD1,$02 Copy the number of cycles into #REGde.
@ $9AD3 label=PlayNote_Multiply
  $9AD3,$01 Decrease the multiplier by one.
  $9AD4,$02 Jump to #R$9AD9 if it is zero.
  $9AD6,$01 Add the number of cycles again.
  $9AD7,$02 Jump back to #R$9AD3.
@ $9AD9 label=PlayNote_Play
  $9AD9,$01 Restore the address of the note.
@ $9ADA label=PlayNote_Cycle
  $9ADA,$01 Save the half-period.
  $9ADB,$01 Select the low level.
  $9ADC,$02 Send it to the speaker.
@ $9ADE label=PlayNote_Low
  $9ADE,$02 Delay.
  $9AE0,$01 Decrease the outer counter by one.
  $9AE1,$02 Jump back to #R$9ADE until none remain.
  $9AE3,$01 Restore the half-period.
  $9AE4,$01 Save the half-period again.
  $9AE5,$02 Select the high level.
  $9AE7,$02 Send it to the speaker.
@ $9AE9 label=PlayNote_High
  $9AE9,$02 Delay.
  $9AEB,$01 Decrease the outer counter by one.
  $9AEC,$02 Jump back to #R$9AE9 until none remain.
  $9AEE,$01 Restore the half-period.
  $9AEF,$01 Decrease the number of cycles.
  $9AF0,$02 Combine the high and low bytes.
  $9AF2,$02 Jump back to #R$9ADA until the note is over.
  $9AF4,$01 Move on to the next note.
  $9AF5,$01 Return.
N $9AF6 A rest is a silence of the same length as the other notes.
@ $9AF6 label=PlayNote_Rest
  $9AF6,$01 Fetch the note byte.
  $9AF7,$01 Move on to the next note.
  $9AF8,$02 Move the top two bits to the bottom.
  $9AFA,$02,b$01 Keep them.
  $9AFC,$01 Add one to get a multiplier.
  $9AFD,$01 Use it as a counter.
@ $9AFE label=PlayNote_RestLoop
  $9AFE,$03 Set the delay.
@ $9B01 label=PlayNote_Loop
  $9B01,$01 Save the delay.
@ $9B02 label=PlayNote_Delay
  $9B02,$01 Count down.
  $9B03,$02 Combine the high and low bytes.
  $9B05,$02 Jump back to #R$9B02 until the delay is over.
  $9B07,$01 Restore the delay.
  $9B08,$01 Decrease the multiplier by one.
  $9B09,$02 Jump back to #R$9B01 until none remain.
  $9B0B,$01 Return.

b $9B0C Note Table
@ $9B0C label=NoteTable
D $9B0C Three bytes for each note used by #R$9AB4: the half-period of the wave
. (two bytes, low byte first) and the number of cycles to play. Note zero is
. a rest.
B $9B0C,$B7,$03

c $9BC3 Read Keyboard Port
@ $9BC3 label=ReadKeyboardPort
D $9BC3 Reads a row of keys, or all of them at once. The bits of the result
. that are set are the keys that are pressed.
E $9BC3 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B759 }
. { #GUNFRIGHT$D0DB }
. { #KNIGHTLORE$B5F7 }
. { #NIGHTSHADE$E239 }
. { #PENTAGRAM$B952 }
. LIST#
R $9BC3 A Row selector (the high byte of the port address)
R $9BC3 O:A Keys pressed in the bottom five bits
R $9BC3 O:F The zero flag is set if no key is pressed
  $9BC3,$02 Output the selector to a port (this has no other effect).
  $9BC5,$02 Read the row selected by #REGa.
  $9BC7,$01 Invert the bits.
  $9BC8,$02,b$01 Keep the five bits for the keys.
  $9BCA,$01 Return.

g $9BCB Random Numbers
@ $9BCB label=RandomNumbers
D $9BCB The two random bytes made by the routine at #R$F23B, followed by the
. address of the next byte of memory it will mix in (high byte first).
B $9BCB,$01 First random byte.
B $9BCC,$01 Second random byte.
B $9BCD,$02 Address of the next byte to mix in.

c $9BCF Add A To HL
@ $9BCF label=AddAToHL
D $9BCF Adds #REGa to #REGhl.
E $9BCF View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE06 }
. { #ATICATAC$926C }
. { #KNIGHTLORE$D4F2 }
. { #NIGHTSHADE$E596 }
. { #PENTAGRAM$B519 }
. LIST#
R $9BCF A Value to add
R $9BCF HL Value to add to
R $9BCF O:HL The sum
  $9BCF,$02 Add the low byte.
  $9BD1,$01 Fetch the high byte.
  $9BD2,$02 Add the carry.
  $9BD4,$01 Store the high byte.
  $9BD5,$01 Return.

g $9BD6 Beam Variables
@ $9BD6 label=BeamVariables
D $9BD6 The state shared by the four flickering beams drawn by #R$9BDA.
B $9BD6,$01 The pattern of the beams, which is zero while they are switched
. off.
B $9BD7,$01 The attribute of the beams.
B $9BD8,$01 The number of frames until the beams change.
B $9BD9,$01 Set to #N$01 when at least one beam was drawn this frame.

c $9BDA Update Beams
@ $9BDA label=UpdateBeams
D $9BDA Draws, erases and flickers the horizontal beams that cross the screen
. from the visible map tiles numbered #N($A6), and hurts the ship when it
. touches one. There are up to four beams, one for each of the four tiles
. around the ship that are held at #N$DC91. The beams are switched on and off
. at random intervals with a random pattern and colour. A beam is skipped when
. the bit for its cell of the map is set in the three bytes from #N($F5EA),
. which are cleared when a planet is completed. What the tile #N($A6) looks
. like is not yet known.
  $9BDA,$03 Fetch the special sequence flag.
  $9BDD,$01 Test it.
  $9BDE,$01 Return if a special sequence (such as landing) is under way.
  $9BDF,$03 Fetch the delay left after the ship was last hit.
  $9BE2,$01 Test it.
  $9BE3,$02 Jump to #R$9BEB if the delay is over.
  $9BE5,$01 Decrease the delay.
  $9BE6,$03 Store it.
  $9BE9,$02 Jump to #R$9BFE.
N $9BEB Set up the hit box of the ship, which is #N($28) by #N($10) pixels at
. the fixed horizontal position of #N($64).
@ $9BEB label=UpdateBeams_SetHitBox
  $9BEB,$03 Fetch the vertical position of the ship.
  $9BEE,$02 Move down by #N$08 to the top of the hit box.
  $9BF0,$01 Store it in #REGh.
  $9BF1,$02 Set the horizontal position to #N$64.
  $9BF3,$02 Set the height to #N$10.
  $9BF5,$02 Set the width to #N$28.
  $9BF7,$03 Store the position of the hit box.
  $9BFA,$04 Store the size of the hit box.
N $9BFE Look for a map tile numbered #N$A6 around the ship, or a beam that is
. still being drawn.
@ $9BFE label=UpdateBeams_Look
  $9BFE,$02 Set the counter to four.
  $9C00,$04 Use the table of beams at #R$9D43.
  $9C04,$03 Use the four tiles around the ship.
@ $9C07 label=UpdateBeams_LookLoop
  $9C07,$01 Fetch a tile.
  $9C08,$04 Jump to #R$9C1E if it is tile #N$A6.
  $9C0C,$01 Move on to the next tile.
  $9C0D,$03 Fetch the beam address.
  $9C10,$01 Test it.
  $9C11,$02 Jump to #R$9C1E if a beam is still being drawn.
  $9C13,$08 Move on to the next beam.
  $9C1B,$02 Loop back to #R$9C07 for each of the four.
  $9C1D,$01 Return if there is nothing to do.
N $9C1E Count down to the next change of the beams.
@ $9C1E label=UpdateBeams_Timer
  $9C1E,$04 Use the beam variables.
  $9C22,$03 Decrease the timer.
  $9C25,$02 Jump to #R$9C60 unless it has run out.
  $9C27,$04 Switch the beams off.
  $9C2B,$03 Fetch a random number.
  $9C2E,$04 Jump to #R$9C55 if the beams stay off.
N $9C32 Choose the colour and pattern of the new beams.
  $9C32,$03 Fetch another random number.
  $9C35,$02,b$01 Keep the bottom three bits for the colour.
  $9C37,$02 Jump to #R$9C3B unless the colour is black.
  $9C39,$02 Use cyan instead.
@ $9C3B label=UpdateBeams_Colour
  $9C3B,$01 Save the colour.
  $9C3C,$02 Make it bright.
  $9C3E,$03 Set the attribute of the beams.
  $9C41,$03 Fetch the first random number again.
  $9C44,$02,b$01 Keep the bottom three bits.
  $9C46,$01 Combine them with the colour.
  $9C47,$03 Use the table of patterns.
  $9C4A,$03 Add the index.
  $9C4D,$01 Fetch a pattern.
  $9C4E,$03 Set the pattern of the beams.
  $9C51,$02 The beams stay on for up to #N$20 frames.
  $9C53,$02 Jump to #R$9C57.
@ $9C55 label=UpdateBeams_Off
  $9C55,$02 The beams stay off for up to #N$10 frames.
N $9C57 Choose how long it is until the next change.
@ $9C57 label=UpdateBeams_Interval
  $9C57,$03 Fetch a random number.
  $9C5A,$01 Invert it.
  $9C5B,$01 Limit it to the range chosen.
  $9C5C,$01 Make sure it is at least one.
  $9C5D,$03 Set the timer.
N $9C60 Now deal with each beam in turn. The beams are done in the order
. #N($00), #N($02), #N($01) and then #N($03).
@ $9C60 label=UpdateBeams_Beams
  $9C60,$01 Clear #REGa.
  $9C61,$03 Note that no beam has been drawn yet.
  $9C64,$04 Use the table of beams.
@ $9C68 label=UpdateBeams_Next
  $9C68,$03 Store the number of the beam.
  $9C6B,$03 Fetch the screen address of the beam last drawn.
  $9C6E,$01 Test it.
  $9C6F,$02 Jump to #R$9C80 if there is no beam.
  $9C71,$06 Fetch the screen address into #REGhl.
  $9C77,$03 Fetch the length of the beam into #REGb.
  $9C7A,$03 Fetch the pattern of the beam into #REGc.
  $9C7D,$03 Erase the beam.
@ $9C80 label=UpdateBeams_Erased
  $9C80,$04 Forget the beam.
  $9C84,$03 Fetch the number of the beam.
  $9C87,$03 Fetch the position of the ship on the map.
  $9C8A,$04 Jump to #R$9C8F if bit 0 of the beam number is clear.
  $9C8E,$01 Move to the next row of the map.
@ $9C8F label=UpdateBeams_Row
  $9C8F,$04 Jump to #R$9C94 if bit 1 of the beam number is clear.
  $9C93,$01 Move to the next column of the map.
@ $9C94 label=UpdateBeams_Cell
  $9C94,$01 Copy the position into #REGde.
  $9C95,$03 Find the byte and bit that go with the cell.
  $9C98,$01 Fetch the bit number...
  $9C99,$02 ...and add the opcode of BIT 0,(HL) (#N$46).
  $9C9B,$03 Modify the instruction at #R$9C9E to test that bit.
  $9C9E,$04 Jump to #R$9CEE if the bit of the cell is set.
  $9CA2,$03 Use the four tiles around the ship.
  $9CA5,$03 Fetch the number of the beam.
  $9CA8,$03 Add it to the address.
  $9CAB,$01 Fetch the tile.
  $9CAC,$04 Jump to #R$9CEE if it is not tile #N$A6.
  $9CB0,$03 Fetch the pattern of the beams.
  $9CB3,$01 Test it.
  $9CB4,$02 Jump to #R$9CEE if the beams are off.
  $9CB6,$03 Fetch the first scroll position.
  $9CB9,$04 Fetch the second scroll position.
  $9CBD,$03 Work out the extent of the beam.
  $9CC0,$01 Fetch its length.
  $9CC1,$01 Test it.
  $9CC2,$02 Jump to #R$9CEE if there is no beam.
  $9CC4,$03 Draw the beam.
  $9CC7,$03 Fetch the position of the beam.
  $9CCA,$03 Fetch its length.
  $9CCD,$03 Store it as the width of the attributes to colour.
  $9CD0,$03 Multiply it by eight to get the length in pixels.
  $9CD3,$01 Store it in #REGd.
  $9CD4,$03 Fetch the delay left after the last hit.
  $9CD7,$01 Test it.
  $9CD8,$01 Save the position.
  $9CD9,$03 Check whether the ship has been hit, if the delay is over.
  $9CDC,$01 Restore the position.
  $9CDD,$03 Fetch the attribute of the beam.
  $9CE0,$03 Store it in the parameters.
  $9CE3,$03 Use the parameters.
  $9CE6,$03 Colour the beam.
  $9CE9,$02,b$01 Make #REGa non-zero.
  $9CEB,$03 Note that a beam has been drawn.
@ $9CEE label=UpdateBeams_Advance
  $9CEE,$08 Move on to the next beam.
  $9CF6,$03 Fetch the number of the beam.
  $9CF9,$04 Jump to #R$9D06 if it was the last, beam #N$03.
  $9CFD,$02,b$01 Choose the next beam.
  $9CFF,$03 Jump to #R$9C68 if it is now beam #N$02 or #N$03.
  $9D02,$01 Otherwise it is beam #N$01.
  $9D03,$03 Jump to #R$9C68.
@ $9D06 label=UpdateBeams_Sound
  $9D06,$03 Fetch the flag that says whether a beam was drawn.
  $9D09,$01 Test it.
  $9D0A,$01 Return if not.
  $9D0B,$03 Make the sound of the beams.

c $9D0E Check Beam Hit
@ $9D0E label=CheckBeamHit
D $9D0E Checks whether the ship is touching a beam, and if so hurts it.
  $9D0E,$03 Fetch the delivery flag from #R$96AB.
  $9D11,$01 Test it.
  $9D12,$01 Return if it is set.
  $9D13,$02 Set the height of the beam to one pixel.
  $9D15,$03 Test whether the beam touches the hit box of the ship.
  $9D18,$03 Fetch the result of the test.
  $9D1B,$01 Test it.
  $9D1C,$01 Return if the beam missed.
  $9D1D,$02 Wait #N$10 frames before the beam can hurt the ship again.
  $9D1F,$03 Store the delay.
  $9D22,$03 Damage the ship.

c $9D25 Erase Beam
@ $9D25 label=EraseBeam
D $9D25 Clears the pixels of a beam, which is a row of bytes that all share the
. same pattern.
R $9D25 B Number of bytes
R $9D25 C Pattern of each byte
R $9D25 HL Screen address of the first byte
  $9D25,$03 Invert the pattern.
@ $9D28 label=EraseBeam_Loop
  $9D28,$01 Fetch the inverted pattern.
  $9D29,$02 Clear the pixels.
  $9D2B,$01 Move on to the next byte of the row.
  $9D2C,$02 Loop back to #R$9D28 for each byte.
  $9D2E,$01 Return.

g $9D2F Beam Hit Delay
@ $9D2F label=BeamHitDelay
D $9D2F The number of frames that remain before a beam can hurt the ship again.
B $9D2F,$01

c $9D30 Draw Beam
@ $9D30 label=DrawBeam
D $9D30 Records a beam in the table at #R$9D43 and draws it.
R $9D30 B Number of bytes
R $9D30 C Pattern of each byte
R $9D30 HL Screen address of the first byte
R $9D30 IY Address of the entry in the table
  $9D30,$03 Record the low byte of the screen address.
  $9D33,$03 Record the high byte of the screen address.
  $9D36,$03 Record the number of bytes.
  $9D39,$03 Record the pattern.
@ $9D3C label=DrawBeam_Loop
  $9D3C,$01 Fetch the pattern.
  $9D3D,$02 Set the pixels.
  $9D3F,$01 Move on to the next byte of the row.
  $9D40,$02 Loop back to #R$9D3C for each byte.
  $9D42,$01 Return.

g $9D43 Beam Table
@ $9D43 label=BeamTable
D $9D43 Four entries of four bytes, one for each beam that is currently drawn:
. the screen address (low byte first), the number of bytes and the pattern.
B $9D43,$10,$04

c $9D53 Find Beam Extent
@ $9D53 label=FindBeamExtent
D $9D53 Works out where a beam is drawn and how long it is. The beam number
. is held at #N$5C1E: bit 0 selects the side of the screen on the horizontal
. axis and bit 1 selects the side on the vertical axis. The screen address that
. is returned is where the beam starts.
R $9D53 DE Second scroll position (from #N$CE41)
R $9D53 HL First scroll position (from #N$CE45)
R $9D53 IX Address of the beam variables
R $9D53 O:B Length of the beam in bytes, or zero if there is no beam
R $9D53 O:C Pattern of each byte, rotated to match the fine scroll
R $9D53 O:HL Screen address of the start of the beam
  $9D53,$02 Start with a length of zero.
  $9D55,$03 Fetch the number of the beam.
  $9D58,$02 Test bit 0.
  $9D5A,$01 Fetch the high byte of the first position.
  $9D5B,$02 Jump to #R$9D64 if bit 0 is set.
  $9D5D,$02 Is the position at least #N$21?
  $9D5F,$01 Return if so, as there is no beam.
  $9D60,$02 Use #N$81 as the offset.
  $9D62,$02 Jump to #R$9D69.
@ $9D64 label=FindBeamExtent_Right
  $9D64,$02 Is the position below #N$21?
  $9D66,$01 Return if so, as there is no beam.
  $9D67,$02 Use #N$21 as the offset.
@ $9D69 label=FindBeamExtent_Y
  $9D69,$01 Add the second position to get the vertical pixel position.
  $9D6A,$01 Store it in #REGd.
  $9D6B,$03 Fetch the number of the beam.
  $9D6E,$04 Jump to #R$9D79 if bit 1 is set.
  $9D72,$02 Take the first position from #N$E8...
  $9D74,$01 ...to get the length in pixels.
  $9D75,$02 The beam starts at the horizontal position #N$08.
  $9D77,$02 Jump to #R$9D80.
@ $9D79 label=FindBeamExtent_Far
  $9D79,$02 Add the second position to #N$E8...
  $9D7B,$01 ...to get the horizontal start.
  $9D7C,$01 Store it in #REGe.
  $9D7D,$01 Fetch the first position.
  $9D7E,$02 Take #N$08 off to get the length in pixels.
@ $9D80 label=FindBeamExtent_Length
  $9D80,$04 Store the start of the beam.
  $9D84,$01 Copy the length in pixels.
  $9D85,$02,b$01 Keep the bottom three bits.
  $9D87,$02 Jump to #R$9D8D if the length is a whole number of bytes.
  $9D89,$01 Round the length up...
  $9D8A,$02 ...to the next whole byte.
  $9D8C,$01 Store it in #REGb.
@ $9D8D label=FindBeamExtent_Bytes
  $9D8D,$06 Divide the length by eight.
  $9D93,$01 Return if the length is zero.
  $9D94,$03 Fetch the pattern of the beams.
  $9D97,$03 Fetch the fine scroll.
  $9D9A,$02,b$01 Keep the bottom three bits.
  $9D9C,$02 Jump to #R$9DA3 if there is no fine scroll.
@ $9D9E label=FindBeamExtent_Rotate
  $9D9E,$02 Rotate the pattern.
  $9DA0,$01 Count down.
  $9DA1,$02 Loop back to #R$9D9E until the pattern matches the fine scroll.
@ $9DA3 label=FindBeamExtent_Address
  $9DA3,$03 Fetch the start of the beam.
  $9DA6,$03 Jump to #R$A149.

g $9DA9 Beam Patterns
@ $9DA9 label=BeamPatterns
D $9DA9 The eight patterns that a beam can have.
B $9DA9,$08,$08

c $9DB1 Test Boxes Overlap
@ $9DB1 label=TestBoxesOverlap
D $9DB1 Tests whether a box overlaps another box. The first box is described
. by four bytes: the horizontal position of the left edge, the vertical
. position, the width and the height. The vertical test passes when the
. vertical position of the first box minus that of the second is less than the
. height of the first box, or when the vertical position of the second box minus
. that of the first is less than the height of the second box.
R $9DB1 D Width of the second box
R $9DB1 E Height of the second box
R $9DB1 H Vertical position of the second box
R $9DB1 L Horizontal position of the second box
R $9DB1 IX Address of the first box
R $9DB1 O:A Value of #N$5C1C
R $9DB1 O:F The zero flag is set if the boxes do not overlap
  $9DB1,$03 Test whether the boxes overlap horizontally.
  $9DB4,$03 Fetch the result.
  $9DB7,$01 Test it.
  $9DB8,$01 Return if they do not.
  $9DB9,$02 Jump to #R$9DD8 to test whether they overlap vertically.

c $9DBB Test Horizontal Overlap
@ $9DBB label=TestHorizontalOverlap
D $9DBB Tests whether two boxes overlap horizontally. The result is stored in
. #N$5C1C.
R $9DBB D Width of the second box
R $9DBB L Horizontal position of the second box
R $9DBB IX Address of the first box
  $9DBB,$01 Clear the result.
  $9DBC,$03 Store it.
  $9DBF,$03 Fetch the left edge of the first box.
  $9DC2,$01 Subtract the left edge of the second box.
  $9DC3,$02 Jump to #R$9DC8 if the first box starts to the left of the second.
  $9DC5,$01 Does the first box start within the width of the second?
  $9DC6,$02 Jump to #R$9DD2 if so.
@ $9DC8 label=TestHorizontalOverlap_Left
  $9DC8,$03 Fetch the left edge of the first box.
  $9DCB,$01 Is it to the right of the second box?
  $9DCC,$01 Return if so, as the boxes do not overlap.
  $9DCD,$03 Add the width of the first box to get its right edge.
  $9DD0,$01 Is it to the left of the second box?
  $9DD1,$01 Return if so, as the boxes do not overlap.
@ $9DD2 label=SetOverlapFlag
  $9DD2,$02 Set the result to #N($01).
  $9DD4,$03 Store it.
  $9DD7,$01 Return.

c $9DD8 Test Vertical Overlap
@ $9DD8 label=TestVerticalOverlap
D $9DD8 Tests whether two boxes overlap vertically. The result is stored in
. #N$5C1C.
R $9DD8 E Height of the second box
R $9DD8 H Vertical position of the second box
R $9DD8 IX Address of the first box
  $9DD8,$01 Clear the result.
  $9DD9,$03 Store it.
  $9DDC,$03 Fetch the top of the first box.
  $9DDF,$01 Subtract the position of the second box.
  $9DE0,$03 Is it less than the height of the first box?
  $9DE3,$02 Jump to #R$9DD2 if so.
  $9DE5,$01 Fetch the position of the second box.
  $9DE6,$03 Subtract the top of the first box.
  $9DE9,$01 Is it less than the height of the second box?
  $9DEA,$01 Return if not, as the boxes do not overlap.
  $9DEB,$03 Jump to #R$9DD2.

c $9DEE Find Slope Overlap
@ $9DEE label=FindSlopeOverlap
D $9DEE Part of the test for a box touching an object with a sloping face. It
. checks the position of the box against the vertical limits of the object and
. works out how far up the slope the box reaches. Bit 7 of the byte at
. offset #N($04) of the object selects which way the slope runs. Purpose not
. yet known beyond this.
R $9DEE C Steepness of the slope
R $9DEE E Height of the box
R $9DEE H Vertical position of the box
R $9DEE L Horizontal position of the box
R $9DEE IX Address of the object
R $9DEE O:B Distance up the slope
  $9DEE,$01 Fetch the vertical position of the box.
  $9DEF,$03 Compare it with the lower limit of the object.
  $9DF2,$01 Return if it is below.
  $9DF3,$06 Jump to #R$9E08 if bit 7 is set.
  $9DF9,$03 Compare the position with the upper limit of the object.
  $9DFC,$02 Jump to #R$9E16 if it is below.
  $9DFE,$01 Subtract the height of the box.
  $9DFF,$03 Compare it with the upper limit.
  $9E02,$01 Return if the box is entirely above the object.
  $9E03,$03 Clip the vertical position to the upper limit.
  $9E06,$02 Jump to #R$9E16.
@ $9E08 label=FindSlopeOverlap_Reverse
  $9E08,$01 Subtract the height of the box.
  $9E09,$01 Store it as the vertical position.
  $9E0A,$03 Compare it with the upper limit of the object.
  $9E0D,$01 Return if it is above.
  $9E0E,$03 Compare it with the lower limit of the object.
  $9E11,$02 Jump to #R$9E16 if it is above.
  $9E13,$03 Clip the vertical position to the lower limit.
@ $9E16 label=FindSlopeOverlap_Horizontal
  $9E16,$01 Fetch the horizontal position of the box.
  $9E17,$03 Compare it with the horizontal limit of the object.
  $9E1A,$02 Jump to #R$9E1D if they are the same.
  $9E1C,$01 Return if the box is beyond the limit.
@ $9E1D label=FindSlopeOverlap_Found
  $9E1D,$02 Set the result to #N($01).
  $9E1F,$03 Store it.
  $9E22,$03 Fetch the upper limit of the object.
  $9E25,$01 Subtract the vertical position to get the distance up the slope.
  $9E26,$01 Store it in #REGb.
  $9E27,$01 Fetch the steepness of the slope.
  $9E28,$02 Is it #N($02)?
  $9E2A,$01 Return if so.
  $9E2B,$02 Halve the distance.
  $9E2D,$02 Is the steepness #N($03)?
  $9E2F,$01 Return if so.
  $9E30,$04 Otherwise multiply the halved distance by four.
  $9E34,$01 Return.

c $9E35 Test Slope Collision
@ $9E35 label=TestSlopeCollision
D $9E35 Tests whether a box touches an object with a sloping face. Bits 6 and 7
. of the byte at offset #N($04) of the object select one of four ways the slope
. can face, and the bottom three bits are the steepness. The result is stored
. in #N($5C1C), and when the box does touch the object the depth that it
. has gone into the slope is stored in #N($5C1A). The position of the box
. comes from #N($CE3A) and its size from #N($CE3C).
R $9E35 IX Address of the object
  $9E35,$01 Clear the result.
  $9E36,$03 Store it.
  $9E39,$03 Fetch the position of the box.
  $9E3C,$04 Fetch the size of the box.
  $9E40,$03 Fetch the slope flags.
  $9E43,$02,b$01 Keep the steepness.
  $9E45,$01 Store it in #REGc.
  $9E46,$03 Fetch the slope flags again.
  $9E49,$02,b$01 Keep the direction bits.
  $9E4B,$02 Jump to #R$9E5D if both are clear.
  $9E4D,$05 Jump to #R$9EA5 if it is the second direction.
  $9E52,$05 Jump to #R$9EC0 if it is the third direction.
  $9E57,$05 Jump to #R$9ED9 if it is the fourth direction.
  $9E5C,$01 Return.
@ $9E5D label=TestSlopeCollision_Down
  $9E5D,$03 Find the overlap with the slope.
@ $9E60 label=TestSlopeCollision_Depth
  $9E60,$03 Fetch the result.
  $9E63,$01 Test it.
  $9E64,$01 Return if the box does not overlap.
  $9E65,$01 Reduce the result to zero.
  $9E66,$03 Store it.
  $9E69,$01 Fetch the width of the box.
  $9E6A,$01 Add the horizontal position.
  $9E6B,$01 Store it in #REGl.
  $9E6C,$03 Fetch the left edge of the object.
  $9E6F,$01 Add the distance up the slope.
  $9E70,$01 Subtract the right edge of the box.
  $9E71,$01 Return if the box is clear of the slope.
  $9E72,$02 Make the depth positive.
  $9E74,$03 Store the depth.
  $9E77,$03 Jump to #R$9DD2 to say that the box touches the slope.

c $9E7A Find Mirrored Slope Overlap
@ $9E7A label=FindMirroredSlopeOverlap
D $9E7A Finds the overlap with a slope that faces the other way by swapping
. the horizontal edges of the object, calling #R$9DEE and swapping them back.
R $9E7A IX Address of the object
  $9E7A,$03 Fetch the left edge of the object.
  $9E7D,$03 Fetch the right limit of the object.
  $9E80,$03 Store the right limit as the left edge.
  $9E83,$03 Store the left edge as the right limit.
  $9E86,$03 Find the overlap with the slope.
  $9E89,$03 Fetch the left edge of the object.
  $9E8C,$03 Fetch the right limit of the object.
  $9E8F,$03 Store the right limit as the left edge.
  $9E92,$03 Store the left edge as the right limit.
  $9E95,$03 Fetch the result.
  $9E98,$01 Test it.
  $9E99,$01 Return if the box does not overlap.
  $9E9A,$01 Fetch the horizontal position of the box.
  $9E9B,$01 Add the width of the box.
  $9E9C,$03 Compare it with the right limit of the object.
  $9E9F,$01 Return if it is further to the right.
  $9EA0,$01 Clear the result.
  $9EA1,$03 Store it.
  $9EA4,$01 Return.
@ $9EA5 label=TestSlopeCollision_Mirrored
  $9EA5,$03 Find the overlap with the mirrored slope.
@ $9EA8 label=TestSlopeCollision_MirroredDepth
  $9EA8,$03 Fetch the result.
  $9EAB,$01 Test it.
  $9EAC,$01 Return if the box does not overlap.
  $9EAD,$01 Reduce the result to zero.
  $9EAE,$03 Store it.
  $9EB1,$03 Fetch the left edge of the object.
  $9EB4,$01 Subtract the distance up the slope.
  $9EB5,$01 Subtract the horizontal position of the box.
  $9EB6,$01 Return if the box is clear of the slope.
  $9EB7,$01 Return if the depth is zero.
  $9EB8,$02 Make the depth positive.
  $9EBA,$03 Store the depth.
  $9EBD,$03 Jump to #R$9DD2 to say that the box touches the slope.
@ $9EC0 label=TestSlopeCollision_Up
  $9EC0,$03 Find the overlap with the slope.
  $9EC3,$01 Fetch the distance up the slope.
  $9EC4,$02 Negate it.
  $9EC6,$01 Store it.
  $9EC7,$03 Fetch the result.
  $9ECA,$01 Test it.
  $9ECB,$01 Return if the box does not overlap.
  $9ECC,$01 Fetch the horizontal position of the box.
  $9ECD,$01 Add the width of the box.
  $9ECE,$03 Compare it with the left edge of the object.
  $9ED1,$03 Jump to #R$9EA8 if it is further to the right.
  $9ED4,$01 Clear the result.
  $9ED5,$03 Store it.
  $9ED8,$01 Return.
@ $9ED9 label=TestSlopeCollision_UpMirrored
  $9ED9,$03 Find the overlap with the mirrored slope.
  $9EDC,$01 Fetch the distance up the slope.
  $9EDD,$02 Negate it.
  $9EDF,$01 Store it.
  $9EE0,$03 Jump to #R$9E60.

c $9EE3 Read Pause Keys
@ $9EE3 label=ReadPauseKeys
D $9EE3 Tests the SPACE and CAPS SHIFT keys.
R $9EE3 O:F The zero flag is set if either key is pressed
  $9EE3,$02 Select the keyboard row with SPACE.
  $9EE5,$02 Put the row on the address lines.
  $9EE7,$02 Read the keyboard.
  $9EE9,$02,b$01 Keep the bit for SPACE.
  $9EEB,$01 Return if SPACE is pressed.
  $9EEC,$02 Select the keyboard row with CAPS SHIFT.
  $9EEE,$02 Put the row on the address lines.
  $9EF0,$02 Read the keyboard.
  $9EF2,$02,b$01 Keep the bit for CAPS SHIFT.
  $9EF4,$01 Return.

c $9EF5 Fade Out And Clear Playfield
@ $9EF5 label=FadeOutAndClearPlayfield
D $9EF5 Dissolves the playfield pixel by pixel and then clears it.
  $9EF5,$03 Use the bottom left of the playfield.
  $9EF8,$03 Dissolve it.
  $9EFB,$03 Clear the playfield.

c $9EFE Fade Out Playfield
@ $9EFE label=FadeOutPlayfield
D $9EFE Dissolves the playfield, which is #N($1C) bytes wide and #N($A0) rows
. high, by sixteen passes that each clear some pixels using the patterns at
. #R$9F44.
R $9EFE HL Position of the bottom left of the playfield
  $9EFE,$03 Find the screen address.
  $9F01,$03 Use the patterns.
  $9F04,$03 Store the screen address.
  $9F07,$02 Set the number of passes to sixteen.
@ $9F09 label=FadeOutPlayfield_Pass
  $9F09,$01 Save the number of passes.
  $9F0A,$03 Fetch the screen address of the top left.
  $9F0D,$02 Set the number of rows to #N($A0).
@ $9F0F label=FadeOutPlayfield_Row
  $9F0F,$02 Set the number of bytes in a row to #N($1C).
  $9F11,$01 Save the address of the start of the row.
@ $9F12 label=FadeOutPlayfield_Byte
  $9F12,$01 Fetch a pattern.
  $9F13,$01 Clear some of the pixels of the byte of the screen.
  $9F14,$01 Store the byte.
  $9F15,$01 Move on to the next byte.
  $9F16,$01 Move on to the next pattern.
  $9F17,$01 Fetch it.
  $9F18,$01 Test it.
  $9F19,$02 Jump to #R$9F1E unless it is the end of the patterns.
  $9F1B,$03 Go back to the first pattern.
@ $9F1E label=FadeOutPlayfield_Next
  $9F1E,$02 Loop back to #R$9F12 for each byte of the row.
  $9F20,$01 Restore the address of the start of the row.
  $9F21,$03 Move up to the next row.
  $9F24,$01 Decrease the number of rows.
  $9F25,$02 Loop back to #R$9F0F for each row.
  $9F27,$01 Restore the number of passes.
  $9F28,$01 Decrease it.
  $9F29,$02 Loop back to #R$9F09 for each pass.
  $9F2B,$01 Return.

c $9F2C Clear Playfield
@ $9F2C label=ClearPlayfield
D $9F2C Clears the pixels of the playfield, which is #N($1C) bytes wide and
. #N($A0) rows high.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$9F2C }
. { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$F26C,stop=$F2D0,clear=1,sp=$FE00)
. #SCR$02(playfield-before) |
. #SIM(start=$9F2C,stop=$9F43,sp=$FE00)
. #SCR$02(playfield-after) } UDGTABLE# #POPS
  $9F2C,$03 Use the bottom left of the playfield.
  $9F2F,$03 Find the screen address.
  $9F32,$02 Set the number of rows to #N($A0).
@ $9F34 label=ClearPlayfield_Row
  $9F34,$02 Set the number of bytes in a row to #N($1C).
  $9F36,$01 Save the address of the start of the row.
@ $9F37 label=ClearPlayfield_Byte
  $9F37,$02 Clear a byte.
  $9F39,$01 Move on to the next byte.
  $9F3A,$02 Loop back to #R$9F37 for each byte of the row.
  $9F3C,$01 Restore the address of the start of the row.
  $9F3D,$03 Move up to the next row.
  $9F40,$01 Decrease the number of rows.
  $9F41,$02 Loop back to #R$9F34 for each row.
  $9F43,$01 Return.

b $9F44 Dissolve Patterns
@ $9F44 label=DissolvePatterns
D $9F44 The masks used by #R$9EFE, ending with a zero.
B $9F44,$0A,$0A

c $9F4E Check Pause
@ $9F4E label=CheckPause
D $9F4E Pauses the game if SPACE or CAPS SHIFT is pressed, and carries on once
. one of them is pressed again.
  $9F4E,$03 Test the pause keys.
  $9F51,$01 Return if neither is pressed.
  $9F52,$02 Jump to #R$9F5B.

c $9F54 Check Pause And Silence
@ $9F54 label=CheckPauseAndSilence
D $9F54 As #R$9F4E, but first calls #R$C5FF when the game is about to pause.
  $9F54,$03 Test the pause keys.
  $9F57,$01 Return if neither is pressed.
  $9F58,$03 Call #R$C5FF.
@ $9F5B label=CheckPause_WaitRelease
  $9F5B,$03 Wait a short while.
  $9F5E,$03 Test the pause keys.
  $9F61,$02 Loop back to #R$9F5B until they are released.
@ $9F63 label=CheckPause_WaitPress
  $9F63,$03 Wait a short while.
  $9F66,$03 Test the pause keys.
  $9F69,$02 Loop back to #R$9F63 until one is pressed.
@ $9F6B label=CheckPause_WaitReleaseAgain
  $9F6B,$03 Test the pause keys.
  $9F6E,$02 Loop back to #R$9F6B until they are released.
  $9F70,$01 Return.

c $9F71 Short Delay
@ $9F71 label=ShortDelay
D $9F71 Waits for a short time.
  $9F71,$02 Set the delay.
  $9F73,$03 Wait.

b $9F76 Font
@ $9F76 label=Font
D $9F76 The letters and symbols that are printed by #R$A115. Each glyph is
. seven bytes, stored from the bottom row to the top. The letters A to Z are
. numbered #N($00) to #N($19), the digits 0 to 9 are #N($1A) to #N($23), the
. space is #N($26) and the full stop is #N($27).
E $9F76 View the equivalent code in;
. #LIST
. { #BUBBLER$64E0 }
. LIST#
B $9F76,$13B,$07

c $A0B1 Print Character
@ $A0B1 label=PrintCharacter
D $A0B1 Prints one character of text. The character is drawn from the bottom
. row to the top, so the screen address moves up the screen. The instruction at
. #R$A0C9 is changed by #R$A115 to either carry straight on or to jump to
. #R$A0DB, which prints wide characters.
E $A0B1 View the equivalent code in;
. #LIST
. { #BUBBLER$A97A }
. LIST#
R $A0B1 B' Attribute
R $A0B1 DE Address of the character code
R $A0B1 HL Screen address
R $A0B1 HL' Attribute address
R $A0B1 O:HL Screen address of the next character
R $A0B1 O:HL' Attribute address of the next character
  $A0B1,$01 Save the address of the character code.
  $A0B2,$01 Fetch the character code.
  $A0B3,$01 Save the screen address.
  $A0B4,$06 Multiply the character code by eight...
  $A0BA,$06 ...and subtract the character code to get seven times the code.
  $A0C0,$04 Add the address of the font to get the address of the glyph.
  $A0C4,$01 Put the address of the glyph in #REGde.
  $A0C5,$01 Fetch the screen address.
  $A0C6,$01 Save it again.
  $A0C7,$02 Set the number of rows of the glyph to seven.
@ $A0C9 label=PrintCharacter_Mode
  $A0C9,$02 Jump to #R$A0CB for narrow characters, or to #R$A0DB for wide ones.
@ $A0CB label=PrintCharacter_Row
  $A0CB,$01 Fetch a row of the glyph.
  $A0CC,$01 Draw it.
  $A0CD,$01 Move on to the next row of the glyph.
  $A0CE,$03 Move up a row of the screen.
  $A0D1,$02 Loop back to #R$A0CB for each of the seven rows.
  $A0D3,$01 Switch to the attribute registers.
  $A0D4,$01 Set the attribute of the character.
  $A0D5,$01 Move on to the next attribute cell.
  $A0D6,$01 Switch back to the screen registers.
  $A0D7,$01 Restore the screen address.
  $A0D8,$01 Move on to the next character cell.
  $A0D9,$01 Restore the address of the character code.
  $A0DA,$01 Return.

c $A0DB Print Wide Character
@ $A0DB label=PrintWideCharacter
D $A0DB Prints one character of text at double width, using the table at
. #N$5C84 to double each nibble of the glyph into a byte. The character takes
. two cells across and two cells high of attributes.
R $A0DB B' Attribute
R $A0DB DE Address of the character code
R $A0DB DE' Value of #N($0020)
R $A0DB HL Screen address
R $A0DB HL' Attribute address
R $A0DB O:HL Screen address two cells to the right
R $A0DB O:HL' Attribute address two cells to the right
  $A0DB,$02 Set the number of rows to seven.
  $A0DD,$02 Use the table of doubled nibbles.
@ $A0DF label=PrintWideCharacter_Row
  $A0DF,$01 Save the number of rows.
  $A0E0,$01 Fetch a row of the glyph.
  $A0E1,$08 Move the top nibble to the bottom.
  $A0E9,$02 Add the offset of the table to the nibble.
  $A0EB,$01 Put it in #REGc.
  $A0EC,$01 Fetch the doubled nibble.
  $A0ED,$01 Draw it on the left.
  $A0EE,$01 Move up a pixel row.
  $A0EF,$01 Draw it again.
  $A0F0,$01 Move back down.
  $A0F1,$01 Move on to the right cell.
  $A0F2,$01 Fetch the row of the glyph again.
  $A0F3,$02,b$01 Keep the bottom nibble.
  $A0F5,$02 Add the offset of the table.
  $A0F7,$01 Put it in #REGc.
  $A0F8,$01 Fetch the doubled nibble.
  $A0F9,$01 Draw it on the right.
  $A0FA,$01 Move up a pixel row.
  $A0FB,$01 Draw it again.
  $A0FC,$01 Move back to the left cell.
  $A0FD,$01 Move on to the next row of the glyph.
  $A0FE,$03 Move up a row of the screen.
  $A101,$01 Restore the number of rows.
  $A102,$01 Decrease it.
  $A103,$02 Loop back to #R$A0DF for each row.
  $A105,$01 Switch to the attribute registers.
  $A106,$01 Set the attribute of the cell at the left.
  $A107,$02 Move up to the attribute cell above.
  $A109,$01 Set its attribute.
  $A10A,$01 Move on to the right.
  $A10B,$01 Set the attribute of the cell above on the right.
  $A10C,$01 Move back down.
  $A10D,$01 Set the attribute of the cell on the right.
  $A10E,$01 Move on to the next cell.
  $A10F,$01 Switch back to the screen registers.
  $A110,$01 Restore the screen address.
  $A111,$02 Move on two cells.
  $A113,$01 Restore the address of the character code.
  $A114,$01 Return.

c $A115 Print Text
@ $A115 label=PrintText
D $A115 Prints a line of text. The text is held in a record made of the
. horizontal pixel position, the vertical pixel position, the attribute, the
. number of characters and then the characters. Bit 7 of the attribute makes
. the text wide.
. .
. #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$A115,stop=$A148,clear=1,de=$F112,sp=$FE00)
. #SCR$02(printed-title) } UDGTABLE# #POPS
R $A115 DE Address of the text record
R $A115 O:DE Address of the byte after the record
  $A115,$01 Select normal characters.
  $A116,$03 Change the instruction at #R$A0C9 to match.
  $A119,$02 Fetch the horizontal position.
  $A11B,$01 Move on to the vertical position.
  $A11C,$01 Fetch the vertical position.
  $A11D,$01 Move on to the attribute.
  $A11E,$01 Save the address of the attribute.
  $A11F,$01 Save the position.
  $A120,$04 Find the screen address.
  $A124,$01 Switch to the attribute registers.
  $A125,$01 Restore the position.
  $A126,$03 Find the attribute address.
  $A129,$01 Restore the address of the attribute.
  $A12A,$01 Fetch the attribute.
  $A12B,$04 Jump to #R$A13A if the text is not wide.
  $A12F,$02 Select wide characters.
  $A131,$03 Change the instruction at #R$A0C9 to match.
  $A134,$01 Fetch the attribute again.
  $A135,$02,b$01 Remove the flag.
  $A137,$03 Set the offset between rows of attributes.
@ $A13A label=PrintText_Attribute
  $A13A,$01 Store the attribute.
  $A13B,$01 Switch back to the screen registers.
  $A13C,$01 Move on to the number of characters.
  $A13D,$01 Fetch it.
  $A13E,$01 Store it in #REGb.
@ $A13F label=PrintText_Loop
  $A13F,$01 Save the number of characters.
  $A140,$01 Move on to the next character.
  $A141,$03 Print the character.
  $A144,$01 Restore the number of characters.
  $A145,$02 Loop back to #R$A13F for each character.
  $A147,$01 Move on to the byte after the record.
  $A148,$01 Return.

c $A149 Get Screen Address
@ $A149 label=GetScreenAddress
D $A149 Finds the address in the display file of a pixel position. The
. vertical position is the number of the row of pixels, counted from the top
. of the screen, so #N($BF) is the bottom row.
E $A149 View the equivalent code in;
. #LIST
. { #BUBBLER$A9FE }
. LIST#
R $A149 H Vertical position
R $A149 L Horizontal position
R $A149 O:HL Screen address
  $A149,$01 Fetch the horizontal position.
  $A14A,$06 Divide it by eight.
  $A150,$02,b$01 Keep the five bits of the column.
  $A152,$01 Store it in #REGl.
  $A153,$01 Fetch the vertical position.
  $A154,$04 Multiply it by four.
  $A158,$02,b$01 Keep the bits that give the row of the cell.
  $A15A,$01 Combine them with the column.
  $A15B,$01 Store the low byte of the address.
  $A15C,$01 Fetch the vertical position.
  $A15D,$02,b$01 Keep the bits that give the pixel row within the cell.
  $A15F,$01 Save them.
  $A160,$01 Fetch the vertical position.
  $A161,$06 Divide it by eight.
  $A167,$02,b$01 Keep the bits that give the third of the screen.
  $A169,$02,b$01 Add the address of the display file.
  $A16B,$01 Store the high byte of the address.
  $A16C,$01 Restore the pixel row.
  $A16D,$01 Combine it with the high byte.
  $A16E,$01 Store the high byte of the address.
  $A16F,$01 Return.

c $A170 Find Attribute Address
@ $A170 label=AttributeAddress
D $A170 Finds the address in the attribute file of a pixel position. The
. vertical position is the number of the row of pixels, counted from the top
. of the screen.
R $A170 H Vertical position
R $A170 L Horizontal position
R $A170 O:HL Attribute address
  $A170,$01 Stash #REGbc on the stack.
  $A171,$01 Fetch the horizontal position.
  $A172,$06 Divide it by eight.
  $A178,$02,b$01 Keep the five bits of the column.
  $A17A,$01 Store it in #REGl.
  $A17B,$01 Fetch the vertical position.
  $A17C,$04 Multiply it by four.
  $A180,$01 Keep a copy.
  $A181,$02,b$01 Keep the bits that give the row of the cell.
  $A183,$01 Combine them with the column.
  $A184,$01 Store the low byte of the address.
  $A185,$01 Fetch the multiplied vertical position.
  $A186,$02,b$01 Keep the bits that give the third of the screen.
  $A188,$02,b$01 Add the address of the attribute file.
  $A18A,$01 Store the high byte of the address.
  $A18B,$01 Bring #REGbc back off the stack.
  $A18C,$01 Return.

c $A18D Run Object Handler
@ $A18D label=RunObjectHandler
D $A18D Jumps to the routine that handles an object, which is picked from the
. table at #R$AF25 by the type of the object.
R $A18D IX Address of the object
  $A18D,$03 Fetch the type of the object.
  $A190,$02 Take off #N($13), the first type with a handler.
  $A192,$03 Put the result in #REGde.
  $A195,$03 Use the table of handlers.
  $A198,$02 Add the offset twice to get the address of the entry.
  $A19A,$04 Fetch the address of the handler into #REGhl.
  $A19E,$01 Jump to the handler.

c $A19F Fetch Object Frame Table
@ $A19F label=FetchObjectFrameTable
D $A19F Fetches the entry for the type of an object from the table at #R$AF3D.
R $A19F IX Address of the object
R $A19F O:DE The entry
  $A19F,$03 Fetch the type of the object.
  $A1A2,$03 Use the table.
  $A1A5,$03 Fetch the entry.
  $A1A8,$01 Put it in #REGde.
  $A1A9,$01 Return.

c $A1AA Get Table Entry
@ $A1AA label=GetTableEntry
D $A1AA Fetches a word from a table.
R $A1AA C Index
R $A1AA HL Address of the table
R $A1AA O:HL The word
  $A1AA,$02 Clear #REGb.
  $A1AC,$02 Add the index twice to get the address of the entry.
  $A1AE,$01 Fetch the low byte.
  $A1AF,$01 Move on to the high byte.
  $A1B0,$01 Fetch the high byte.
  $A1B1,$01 Put the low byte in #REGl.
  $A1B2,$01 Return.

c $A1B3 Move Up A Row In DE
@ $A1B3 label=MoveUpARowDE
D $A1B3 Moves a screen address up one pixel row.
E $A1B3 View the equivalent code in;
. #LIST
. { #NIGHTSHADE$C28A }
. LIST#
R $A1B3 DE Screen address
R $A1B3 O:DE Screen address of the row above
  $A1B3,$01 Move up a pixel row.
  $A1B4,$01 Fetch the high byte of the address.
  $A1B5,$01 Add one.
  $A1B6,$02,b$01 Keep the bits that give the pixel row.
  $A1B8,$01 Return if the row is still in the same cell.
  $A1B9,$01 Fetch the low byte of the address.
  $A1BA,$02 Move up a row of cells.
  $A1BC,$01 Store it.
  $A1BD,$01 Return if that crossed a third of the screen.
  $A1BE,$01 Fetch the high byte of the address.
  $A1BF,$02 Add eight to correct it.
  $A1C1,$01 Store it.
  $A1C2,$01 Return.

c $A1C3 Move Up A Row
@ $A1C3 label=MoveUpARow
D $A1C3 Moves a screen address up one pixel row.
E $A1C3 View the equivalent code in;
. #LIST
. { #ATICATAC$9F03 }
. { #LUNARJETMAN$85F6 }
. LIST#
R $A1C3 HL Screen address
R $A1C3 O:HL Screen address of the row above
  $A1C3,$01 Move up a pixel row.
  $A1C4,$01 Fetch the high byte of the address.
  $A1C5,$01 Add one.
  $A1C6,$02,b$01 Keep the bits that give the pixel row.
  $A1C8,$01 Return if the row is still in the same cell.
  $A1C9,$01 Fetch the low byte of the address.
  $A1CA,$02 Move up a row of cells.
  $A1CC,$01 Store it.
  $A1CD,$01 Return if that crossed a third of the screen.
  $A1CE,$01 Fetch the high byte of the address.
  $A1CF,$02 Add eight to correct it.
  $A1D1,$01 Store it.
  $A1D2,$01 Return.

g $A1D3 Sprite Positions
@ $A1D3 label=SpritePositions
D $A1D3 The positions and sizes of the two sprites that are drawn together by
. #R$A303. The first sprite is the one that is erased and the second sprite is
. the one that is drawn.
B $A1D3,$01 Horizontal position of the first sprite.
B $A1D4,$01 Vertical position of the first sprite.
B $A1D5,$01 Horizontal position of the second sprite.
B $A1D6,$01 Vertical position of the second sprite.
B $A1D7,$01 Number of rows of the first sprite.
B $A1D8,$01 Number of rows of the second sprite.

c $A1D9 Clip Second Sprite
@ $A1D9 label=ClipSecondSprite
D $A1D9 Fetches the header of the second sprite and clips it to the playfield.
R $A1D9 DE Address of the sprite
R $A1D9 O:B Number of rows
R $A1D9 O:C Index of the routine that draws the sprite
R $A1D9 O:DE Address of the first row of data
R $A1D9 O:H Width in bytes
  $A1D9,$03 Fetch the position of the second sprite.
  $A1DC,$03 Read the header of the sprite.
  $A1DF,$03 Fetch the vertical position.
  $A1E2,$03 Clip the sprite at the top and bottom of the playfield.
  $A1E5,$01 Fetch the clipped vertical position.
  $A1E6,$03 Store it.
  $A1E9,$01 Return.

c $A1EA Clip First Sprite
@ $A1EA label=ClipFirstSprite
D $A1EA Fetches the header of the first sprite and clips it to the playfield.
R $A1EA DE Address of the sprite
R $A1EA O:B Number of rows
R $A1EA O:C Index of the routine that draws the sprite
R $A1EA O:DE Address of the first row of data
R $A1EA O:H Width in bytes
  $A1EA,$03 Fetch the position of the first sprite.
  $A1ED,$03 Read the header of the sprite.
  $A1F0,$03 Fetch the vertical position.
  $A1F3,$03 Clip the sprite at the top and bottom of the playfield.
  $A1F6,$01 Fetch the clipped vertical position.
  $A1F7,$03 Store it.
  $A1FA,$01 Return.

c $A1FB Clip Sprite Vertically
@ $A1FB label=ClipSpriteVertically
D $A1FB Clips a sprite so that it lies between #N($17) and #N($B7) on the
. vertical axis, which is the playfield. The position of a sprite is its bottom
. row and its rows go up from there, so rows below the playfield are skipped
. by moving on the address of the data, and rows above it are not drawn.
R $A1FB A Vertical position
R $A1FB B Number of rows
R $A1FB DE Address of the first row of data
R $A1FB H Width in bytes
R $A1FB O:B Number of rows to draw
R $A1FB O:DE Address of the first row of data to draw
R $A1FB O:L Vertical position of the first row to draw
  $A1FB,$01 Store the vertical position.
  $A1FC,$02 Subtract #N($17), the top of the playfield.
  $A1FE,$01 Subtract the number of rows.
  $A1FF,$02 Jump to #R$A206 if the sprite does not go past the top.
  $A201,$01 Fetch the vertical position.
  $A202,$02 Subtract #N($17) to get the number of rows that fit.
  $A204,$01 Store it as the number of rows.
  $A205,$01 Return.
@ $A206 label=ClipSpriteVertically_Top
  $A206,$01 Fetch the vertical position.
  $A207,$02 Subtract #N($B7), the bottom of the playfield.
  $A209,$01 Return if the sprite starts exactly at the bottom.
  $A20A,$01 Return if the sprite starts above the bottom.
  $A20B,$01 Store the number of rows that are below the bottom.
  $A20C,$01 Fetch the number of rows.
  $A20D,$01 Take off the rows that are below the bottom.
  $A20E,$01 Store it.
  $A20F,$01 Clear #REGa.
@ $A210 label=ClipSpriteVertically_Skip
  $A210,$01 Add the width for each row that is below the bottom.
  $A211,$01 Count down.
  $A212,$02 Loop back to #R$A210 for each row.
  $A214,$01 Put the address of the data in #REGhl.
  $A215,$03 Skip the data for the rows below the bottom.
  $A218,$01 Put the address back in #REGde.
  $A219,$02 Start at the bottom of the playfield.
  $A21B,$01 Return.

c $A21C Read Sprite Size
@ $A21C label=ReadSpriteSize
D $A21C Reads the width and the number of rows from the header of a sprite.
R $A21C DE Address of the sprite
R $A21C O:B Number of rows
R $A21C O:DE Address of the first row of data
R $A21C O:H Width in bytes
  $A21C,$01 Fetch the width.
  $A21D,$01 Store it in #REGh.
  $A21E,$01 Move on to the number of rows.
  $A21F,$01 Fetch it.
  $A220,$01 Store it in #REGb.
  $A221,$01 Move on to the data.
  $A222,$01 Return.

c $A223 Read Sprite Header
@ $A223 label=ReadSpriteHeader
D $A223 Reads the width and the number of rows from the header of a sprite and
. works out which of the routines that draw sprites to use. Sprites that are not
. aligned to a byte (a horizontal position that has bits 1 and 2 not both
. clear) need a routine that shifts the sprite, which are the first five entries
. of the tables at #R$A294 and #R$A2AA.
R $A223 DE Address of the sprite
R $A223 L Horizontal position
R $A223 O:B Number of rows
R $A223 O:C Index of the routine that draws the sprite
R $A223 O:DE Address of the first row of data
R $A223 O:H Width in bytes
  $A223,$01 Fetch the width.
  $A224,$01 Store it in #REGh.
  $A225,$01 Copy it to #REGc.
  $A226,$01 Take one off to get the index for a sprite that must be shifted.
  $A227,$01 Move on to the number of rows.
  $A228,$01 Fetch it.
  $A229,$01 Store it in #REGb.
  $A22A,$01 Move on to the data.
  $A22B,$01 Fetch the horizontal position.
  $A22C,$02,b$01 Only bits 1 and 2.
  $A22E,$01 Return if the sprite must be shifted.
  $A22F,$02 Add five to the index for a sprite that is aligned.
  $A231,$02 Store it in #REGc.
  $A233,$01 Return.

c $A234 Select Erase Sprite
@ $A234 label=SelectEraseSprite
D $A234 Sets up the first sprite, which is the sprite that is erased by
. #R$A303.
R $A234 B Number of rows
R $A234 C Index of the routine that erases the sprite
R $A234 H Width in bytes
R $A234 O:B High byte of the shift table to use
R $A234 O:IY Address of the routine that erases the sprite
  $A234,$01 Fetch the number of rows.
  $A235,$03 Store it.
  $A238,$01 Fetch the width.
  $A239,$03 Store it.
  $A23C,$03 Use the table of routines that erase sprites.
  $A23F,$03 Fetch the address of the routine.
  $A242,$03 Put it in #REGiy.
  $A245,$02 Jump to #R$A25D.

c $A247 Select Draw Sprite
@ $A247 label=SelectDrawSprite
D $A247 Sets up the second sprite, which is the sprite that is drawn by
. #R$A303.
R $A247 B Number of rows
R $A247 C Index of the routine that draws the sprite
R $A247 H Width in bytes
R $A247 O:B High byte of the shift table to use
R $A247 O:IX Address of the routine that draws the sprite
  $A247,$01 Fetch the number of rows.
  $A248,$03 Store it.
  $A24B,$01 Fetch the width.
  $A24C,$03 Store it.
  $A24F,$03 Use the table of routines that draw sprites.
  $A252,$03 Fetch the address of the routine.
  $A255,$03 Put it in #REGix.
  $A258,$03 Fetch the horizontal position of the second sprite.
  $A25B,$02 Jump to #R$A260.
@ $A25D label=SelectEraseSprite_Position
  $A25D,$03 Fetch the horizontal position of the first sprite.
@ $A260 label=SelectEraseSprite_Shift
  $A260,$02,b$01 Only bits 1 and 2, which are the number of pixels to shift by.
  $A262,$02 Add the high byte of the shift table that does no shifting.
  $A264,$01 Store it in #REGb.
  $A265,$01 Return.

c $A266 Set Second Row Group
@ $A266 label=SetSecondRowGroup
D $A266 Sets up the counters that are used by #R$A59F for the second sprite,
. and finds the screen address of the sprite. Purpose not yet known.
R $A266 B Number of rows
R $A266 H Width in bytes
R $A266 O:HL Screen address
  $A266,$03 Fetch the vertical position from #N$BF84.
  $A269,$03 Store it.
  $A26C,$01 Fetch the number of rows.
  $A26D,$03 Store it.
  $A270,$01 Fetch the width.
  $A271,$03 Store it.
  $A274,$03 Fetch the position.
  $A277,$03 Find the screen address.

c $A27A Set First Row Group
@ $A27A label=SetFirstRowGroup
D $A27A Sets up the counters that are used by #R$A59F for the first sprite.
. Purpose not yet known.
R $A27A B Number of rows
R $A27A H Width in bytes
  $A27A,$03 Fetch the vertical position from #N$BF84.
  $A27D,$03 Store it.
  $A280,$01 Fetch the number of rows.
  $A281,$03 Store it.
  $A284,$01 Fetch the width.
  $A285,$03 Store it.
  $A288,$01 Return.

g $A289 Row Offsets
@ $A289 label=RowOffsets
D $A289 Two vertical positions that are used by #R$A59F.
B $A289,$02,$01

c $A28B Find Object Screen Address
@ $A28B label=FindObjectScreenAddress
D $A28B Finds the screen address of a position that is held in an object.
R $A28B IX Address of the object
R $A28B O:HL Screen address
  $A28B,$03 Fetch the horizontal position.
  $A28E,$03 Fetch the vertical position.
  $A291,$03 Find the screen address.

w $A294 Erase Routine Table
@ $A294 label=EraseRoutineTable
D $A294 The routines that erase a sprite, picked by the index from #R$A223. The
. first five are for sprites that have to be shifted, from one to five bytes
. wide. The last six are for sprites that are aligned, from one to six bytes
. wide.
W $A294,$16,$02

w $A2AA Draw Routine Table
@ $A2AA label=DrawRoutineTable
D $A2AA The routines that draw a sprite, picked by the index from #R$A223. The
. first five are for sprites that have to be shifted, from one to five bytes
. wide. The last six are for sprites that are aligned, from one to six bytes
. wide.
W $A2AA,$16,$02

c $A2C0 Add Speeds To Position
@ $A2C0 label=AddSpeedsToPosition
D $A2C0 Adds two speeds to the two coordinates of an object. Nothing in the
. game refers to this routine.
R $A2C0 IX Address of the object
  $A2C0,$03 Fetch the first coordinate.
  $A2C3,$03 Fetch the first speed.
  $A2C6,$01 Add the speed.
  $A2C7,$03 Store the coordinate.
  $A2CA,$03 Fetch the second coordinate.
  $A2CD,$03 Fetch the second speed.
  $A2D0,$01 Add the speed.
  $A2D1,$03 Store the coordinate.
  $A2D4,$01 Return.

c $A2D5 Subtract Speeds From Position
@ $A2D5 label=SubtractSpeedsFromPosition
D $A2D5 Subtracts two speeds from the two coordinates of an object. Nothing in
. the game refers to this routine.
R $A2D5 IX Address of the object
  $A2D5,$03 Fetch the first coordinate.
  $A2D8,$03 Fetch the first speed.
  $A2DB,$01 Subtract the speed.
  $A2DC,$03 Store the coordinate.
  $A2DF,$03 Fetch the second coordinate.
  $A2E2,$03 Fetch the second speed.
  $A2E5,$01 Subtract the speed.
  $A2E6,$03 Store the coordinate.
  $A2E9,$01 Return.

c $A2EA Reset Sprites
@ $A2EA label=ResetSprites
D $A2EA Sets both sprites to have no rows and no width, and clears the flag that
. makes #R$A303 clip at the edge of the playfield.
  $A2EA,$03 Clear #REGhl.
  $A2ED,$03 Set the number of rows of both sprites to zero.
  $A2F0,$03 Set the width of both sprites to zero.
  $A2F3,$01 Clear #REGa.
  $A2F4,$03 Clear the flag at #R$A2FA.
  $A2F7,$01 Return.

g $A2F8 Sprite Variables
@ $A2F8 label=SpriteVariables
D $A2F8 Variables used by #R$A303.
B $A2F8,$01 Width of the first sprite in bytes.
B $A2F9,$01 Width of the second sprite in bytes.
@ $A2FA label=SpriteVariables_RightEdge
B $A2FA,$01 Set when #R$A303 is to draw sprites that reach beyond the right
. of the playfield, which makes it take #N($60) off both horizontal positions.
B $A2FB,$08 Masks used to dissolve the second sprite, which are picked by the
. value at #N($A302).

c $A303 Draw Sprites
@ $A303 label=DrawSprites
D $A303 Erases one sprite and draws another without flicker. It works out the
. rectangle that holds both sprites (which is at most seven bytes wide), copies
. that part of the screen to a buffer at #N($F800), erases the first sprite
. from the buffer, draws the second sprite into the buffer and then copies the
. buffer back to the screen. The sprites are set up by #R$A234, #R$A247 and
. #R$A1D9 or #R$A1EA. A sprite with no rows is not drawn.
R $A303 B High byte of the shift table for the second sprite
R $A303 B' High byte of the shift table for the first sprite
R $A303 DE Address of the data of the second sprite
R $A303 DE' Address of the data of the first sprite
R $A303 IX Routine that draws the second sprite
R $A303 IY Routine that erases the first sprite
  $A303,$01 Save the address of the data of the second sprite.
  $A304,$01 Stash #REGbc on the stack.
  $A305,$03 Fetch the widths of the two sprites in bytes.
  $A308,$03 Keep a copy of the widths.
  $A30B,$03 Multiply the widths by eight to get them in pixels.
  $A30E,$03 Store the widths in pixels.
  $A311,$03 Fetch the number of rows of the first sprite.
  $A314,$01 Test it.
  $A315,$02 Jump to #R$A31D if the sprite has rows.
  $A317,$03 Copy the position of the second sprite...
  $A31A,$03 ...to the first sprite.
@ $A31D label=DrawSprites_SecondPosition
  $A31D,$03 Fetch the number of rows of the second sprite.
  $A320,$01 Test it.
  $A321,$02 Jump to #R$A329 if the sprite has rows.
  $A323,$03 Copy the position of the first sprite...
  $A326,$03 ...to the second sprite.
@ $A329 label=DrawSprites_Wrapped
  $A329,$03 Fetch the flag for sprites beyond the right of the playfield.
  $A32C,$01 Test it.
  $A32D,$02 Jump to #R$A33F if it is not set.
  $A32F,$03 Fetch the horizontal position of the first sprite.
  $A332,$02 Take off #N($60).
  $A334,$03 Store it.
  $A337,$03 Fetch the horizontal position of the second sprite.
  $A33A,$02 Take off #N($60).
  $A33C,$03 Store it.
N $A33F Find the bottom of the rectangle, which is the larger of the vertical
. positions of the two sprites (the rows of a sprite go up from its position).
@ $A33F label=DrawSprites_Top
  $A33F,$03 Fetch the vertical position of the first sprite.
  $A342,$01 Store it in #REGe.
  $A343,$03 Fetch the vertical position of the second sprite.
  $A346,$01 Store it in #REGd.
  $A347,$01 Is the second sprite higher than the first?
  $A348,$02 Jump to #R$A34B if so.
  $A34A,$01 Use the position of the first sprite.
@ $A34B label=DrawSprites_TopFound
  $A34B,$03 Store the bottom of the rectangle.
  $A34E,$01 Keep it in #REGh.
N $A34F Find the top of the rectangle, which gives the number of rows.
  $A34F,$04 Fetch the number of rows of each sprite.
  $A353,$03 Take the number of rows from the position of the first sprite...
  $A356,$02 ...and from the position of the second sprite.
  $A358,$01 Is the top of the second sprite higher than that of the first?
  $A359,$02 Jump to #R$A35C if not.
  $A35B,$01 Use the top of the second sprite.
@ $A35C label=DrawSprites_BottomFound
  $A35C,$02 Take the top from the bottom...
  $A35E,$01 ...and add one to get the number of rows of the rectangle.
  $A35F,$03 Store it.
N $A362 Find the left of the rectangle, which is the lowest of the horizontal
. positions of the two sprites, rounded down to a whole byte.
  $A362,$03 Fetch the horizontal position of the first sprite.
  $A365,$01 Store it in #REGe.
  $A366,$03 Fetch the horizontal position of the second sprite.
  $A369,$01 Store it in #REGd.
  $A36A,$01 Is the second sprite further to the left?
  $A36B,$02 Jump to #R$A36E if so.
  $A36D,$01 Use the position of the first sprite.
@ $A36E label=DrawSprites_Left
  $A36E,$02,b$01 Round down to a whole byte.
  $A370,$03 Store the left of the rectangle.
  $A373,$01 Keep it in #REGl.
N $A374 Find the right of the rectangle, which gives the number of bytes in each
. row.
  $A374,$04 Fetch the widths of the sprites in pixels.
  $A378,$04 Work out the right of the first sprite relative to the left.
  $A37C,$03 Work out the right of the second sprite relative to the left.
  $A37F,$01 Is the second sprite further to the right?
  $A380,$02 Jump to #R$A383 if so.
  $A382,$01 Use the right of the first sprite.
@ $A383 label=DrawSprites_Right
  $A383,$02 Add six to allow for shifting.
  $A385,$01 Store it in #REGc.
  $A386,$06 Divide it by eight to get the number of bytes in a row.
  $A38C,$03 Store it.
  $A38F,$03 Fetch the flag for sprites beyond the right of the playfield.
  $A392,$01 Test it.
  $A393,$03 Jump to #R$A3F6 if it is not set.
N $A396 The sprites reach beyond the right of the playfield. Work out how many
. bytes of each row are beyond #N($A8), then copy that many from the left of
. the playfield at the end of each row of the buffer.
  $A396,$01 Fetch the left of the rectangle.
  $A397,$01 Add the width in pixels.
  $A398,$02 Take off #N($A8).
  $A39A,$06 Divide it by eight.
  $A3A0,$01 Store the number of bytes beyond in #REGb.
  $A3A1,$03 Fetch the number of bytes in a row.
  $A3A4,$01 Subtract the bytes beyond.
  $A3A5,$03 Store it as the amount to skip at #R$A530.
  $A3A8,$03 Store it as the amount to skip at #R$A3DB.
  $A3AB,$01 Start the copy that far along each row of the buffer.
  $A3AC,$01 Fetch the number of bytes beyond.
  $A3AD,$02,b$01 Flip the bottom three bits.
  $A3AF,$04 Turn it into a distance to jump into a run of copies...
  $A3B3,$03 ...and store it for the copy back to the screen at #R$A51F.
  $A3B6,$03 Store it for the copy to the buffer at #R$A3CA.
  $A3B9,$02 Set the counter that is used by LDI.
  $A3BB,$02 Use the buffer.
  $A3BD,$02 Use the left of the playfield.
  $A3BF,$03 Find the screen address.
  $A3C2,$03 Keep the screen address of the left of the playfield.
  $A3C5,$03 Fetch the number of rows.
  $A3C8,$01 Store it in #REGb.
@ $A3C9 label=DrawSprites_WrapRow
  $A3C9,$01 Save the screen address of the row.
@ $A3CA label=DrawSprites_WrapJump
  $A3CA,$02 Jump into the run of copies.
  $A3CC,$03 Jump to #R$A43E when the rows are done.
@ $A3CF label=DrawSprites_WrapCopy
  $A3CF,$02 Copy a byte of the row to the buffer.
  $A3D1,$02 Copy a byte of the row to the buffer.
  $A3D3,$02 Copy a byte of the row to the buffer.
  $A3D5,$02 Copy a byte of the row to the buffer.
  $A3D7,$02 Copy a byte of the row to the buffer.
  $A3D9,$02 Copy a byte of the row to the buffer.
  $A3DB,$02 Move to the start of the next row of the buffer.
  $A3DD,$01 Add the amount to skip.
  $A3DE,$01 Store it in #REGe.
  $A3DF,$01 Restore the screen address of the row.
  $A3E0,$01 Move up a pixel row.
  $A3E1,$01 Fetch the high byte.
  $A3E2,$01 Add one.
  $A3E3,$02,b$01 Keep the bits that give the pixel row.
  $A3E5,$03 Jump to #R$A3C9 if the row is still in the same cell.
  $A3E8,$01 Fetch the low byte.
  $A3E9,$02 Move up a row of cells.
  $A3EB,$01 Store it.
  $A3EC,$03 Jump to #R$A3C9 if that crossed a third of the screen.
  $A3EF,$01 Fetch the high byte.
  $A3F0,$02 Add eight to correct it.
  $A3F2,$01 Store it.
  $A3F3,$03 Jump to #R$A3C9.
N $A3F6 Copy the rectangle from the screen to the buffer.
@ $A3F6 label=DrawSprites_Copy
  $A3F6,$03 Use the buffer.
  $A3F9,$03 Fetch the number of bytes in a row.
  $A3FC,$02,b$01 Flip the bottom three bits.
  $A3FE,$03 Turn it into a distance to jump into a run of copies...
  $A401,$03 ...and store it for the copy back to the screen at #R$A552.
  $A404,$03 Store it for the copy to the buffer at #R$A414.
  $A407,$03 Find the screen address of the bottom left of the rectangle.
  $A40A,$03 Keep it.
  $A40D,$02 Set the counter that is used by LDI.
  $A40F,$03 Fetch the number of rows.
  $A412,$01 Store it in #REGb.
@ $A413 label=DrawSprites_CopyRow
  $A413,$01 Save the screen address of the row.
@ $A414 label=DrawSprites_CopyJump
  $A414,$02 Jump into the run of copies.
  $A416,$03 Jump to #R$A43E when the rows are done.
@ $A419 label=DrawSprites_CopyBytes
  $A419,$02 Copy a byte of the row to the buffer.
  $A41B,$02 Copy a byte of the row to the buffer.
  $A41D,$02 Copy a byte of the row to the buffer.
  $A41F,$02 Copy a byte of the row to the buffer.
  $A421,$02 Copy a byte of the row to the buffer.
  $A423,$02 Copy a byte of the row to the buffer.
  $A425,$02 Copy a byte of the row to the buffer.
  $A427,$01 Restore the screen address of the row.
  $A428,$01 Move up a pixel row.
  $A429,$01 Fetch the high byte.
  $A42A,$01 Add one.
  $A42B,$02,b$01 Keep the bits that give the pixel row.
  $A42D,$03 Jump to #R$A413 if the row is still in the same cell.
  $A430,$01 Fetch the low byte.
  $A431,$02 Move up a row of cells.
  $A433,$01 Store it.
  $A434,$03 Jump to #R$A413 if that crossed a third of the screen.
  $A437,$01 Fetch the high byte.
  $A438,$02 Add eight to correct it.
  $A43A,$01 Store it.
  $A43B,$03 Jump to #R$A413.
N $A43E Erase the first sprite from the buffer.
@ $A43E label=DrawSprites_Erase
  $A43E,$01 Discard the extra screen address.
  $A43F,$01 Bring #REGbc back off the stack.
  $A440,$01 Restore the address of the data of the second sprite.
  $A441,$01 Switch to the registers of the first sprite.
  $A442,$03 Fetch the number of rows of the first sprite.
  $A445,$01 Test it.
  $A446,$03 Jump to #R$A469 if there is nothing to erase.
  $A449,$03 Fetch the position of the first sprite.
  $A44C,$03 Find its address in the buffer.
  $A44F,$03 Fetch the width of the first sprite.
  $A452,$01 Store it in #REGc.
  $A453,$01 Fetch the high byte of the shift table.
  $A454,$04 Jump to #R$A459 if the sprite is not aligned to a byte.
  $A458,$01 An aligned sprite is one byte narrower.
@ $A459 label=DrawSprites_EraseSkip
  $A459,$03 Fetch the number of bytes in a row.
  $A45C,$01 Take off the width to get the amount to skip to the next row.
  $A45D,$03 Store it at #R$A6D5 for aligned sprites...
  $A460,$03 ...and at #R$A727 for shifted sprites.
  $A463,$03 Fetch the number of rows of the first sprite.
  $A466,$01 Store it.
  $A467,$02 Erase the sprite.
N $A469 Draw the second sprite into the buffer.
@ $A469 label=DrawSprites_Draw
  $A469,$01 Switch to the registers of the second sprite (the main set).
  $A46A,$03 Fetch the number of rows of the second sprite.
  $A46D,$01 Test it.
  $A46E,$03 Jump to #R$A4CB if there is nothing to draw.
  $A471,$03 Fetch the position of the second sprite.
  $A474,$03 Find its address in the buffer.
  $A477,$03 Fetch the width of the second sprite.
  $A47A,$01 Store it in #REGc.
  $A47B,$01 Fetch the high byte of the shift table.
  $A47C,$04 Jump to #R$A481 if the sprite is not aligned to a byte.
  $A480,$01 An aligned sprite is one byte narrower.
@ $A481 label=DrawSprites_DrawSkip
  $A481,$03 Fetch the number of bytes in a row.
  $A484,$01 Take off the width to get the amount to skip to the next row.
  $A485,$03 Store it at #R$A750 for aligned sprites...
  $A488,$03 ...and at #R$A798 for shifted sprites.
  $A48B,$01 Take one off.
  $A48C,$03 Store it at #R$A4C4.
  $A48F,$03 Keep the address of the sprite in the buffer.
  $A492,$03 Fetch the number of rows of the second sprite.
  $A495,$01 Store it.
  $A496,$02 Draw the sprite.
N $A498 When the value at #N($A302) is not zero, dissolve the second sprite in
. the buffer by clearing some of its pixels using one of the masks at
. #R$A2FB.
@ $A498 label=DrawSprites_Dissolve
  $A498,$03 Fetch the dissolve value.
  $A49B,$01 Test it.
  $A49C,$03 Jump to #R$A4CB if the sprite is not dissolving.
  $A49F,$02,b$01 Keep the bottom four bits.
  $A4A1,$03 Use the masks.
  $A4A4,$03 Add the dissolve value.
  $A4A7,$01 Fetch the mask.
  $A4A8,$03 Fetch the address of the sprite in the buffer.
  $A4AB,$03 Fetch the width of the second sprite.
  $A4AE,$01 Store it in #REGe.
  $A4AF,$03 Fetch the number of rows of the second sprite.
  $A4B2,$01 Store it in #REGc.
  $A4B3,$03 Fetch the horizontal position of the second sprite.
  $A4B6,$02,b$01 Keep the bottom three bits.
  $A4B8,$02 Jump to #R$A4BB if the sprite is aligned to a byte.
  $A4BA,$01 A shifted sprite is one byte wider.
@ $A4BB label=DrawSprites_DissolveRow
  $A4BB,$01 Set the number of bytes in a row.
@ $A4BC label=DrawSprites_DissolveByte
  $A4BC,$01 Fetch the mask.
  $A4BD,$01 Apply it to the byte.
  $A4BE,$01 Store the byte.
  $A4BF,$02 Rotate the mask.
  $A4C1,$01 Move on to the next byte.
  $A4C2,$02 Loop back to #R$A4BC for each byte of the row.
  $A4C4,$02 Move on to the start of the next row of the buffer.
  $A4C6,$01 Add the amount to skip.
  $A4C7,$01 Store it in #REGl.
  $A4C8,$01 Count the rows.
  $A4C9,$02 Loop back to #R$A4BB for each row.
N $A4CB Copy the buffer back to the screen, without going past the left or
. right edge of the playfield.
@ $A4CB label=DrawSprites_CopyBack
  $A4CB,$04 Fetch the screen address of the bottom left of the rectangle.
  $A4CF,$03 Use the buffer.
  $A4D2,$03 Fetch the flag for sprites beyond the right of the playfield.
  $A4D5,$01 Test it.
  $A4D6,$02 Jump to #R$A4DF if it is not set.
  $A4D8,$03 Fetch the amount to skip.
  $A4DB,$01 Start the copy that far along each row of the buffer.
  $A4DC,$03 Jump to #R$A518.
@ $A4DF label=DrawSprites_Clip
  $A4DF,$03 Fetch the number of bytes in a row.
  $A4E2,$03 Multiply it by eight to get the width in pixels.
  $A4E5,$01 Store it in #REGb.
  $A4E6,$03 Fetch the left of the rectangle.
  $A4E9,$01 Test it.
  $A4EA,$02 Jump to #R$A4F5 if it is zero.
  $A4EC,$01 Store the left in #REGc.
  $A4ED,$02 Add #N($17).
  $A4EF,$01 Add the width in pixels.
  $A4F0,$03 Jump to #R$A54B if the rectangle ends within the screen.
  $A4F3,$02 Jump to #R$A4FD.
@ $A4F5 label=DrawSprites_ClipLeft
  $A4F5,$01 Skip the first byte of the buffer...
  $A4F6,$01 ...and the first byte of the screen.
  $A4F7,$03 Fetch the number of bytes in a row.
  $A4FA,$01 Take one off.
  $A4FB,$02 Jump to #R$A506.
@ $A4FD label=DrawSprites_ClipRight
  $A4FD,$02 Subtract the left from #N($EE)...
  $A4FF,$01 ...to get the width that fits.
  $A500,$06 Divide it by eight to get the number of bytes.
@ $A506 label=DrawSprites_ClipSkip
  $A506,$01 Store the number of bytes to copy in #REGb.
  $A507,$03 Fetch the number of bytes in a row.
  $A50A,$01 Subtract the number of bytes to copy.
  $A50B,$03 Store it as the amount to skip at #R$A530.
  $A50E,$01 Fetch the number of bytes to copy.
  $A50F,$02,b$01 Flip the bottom three bits.
  $A511,$04 Work out the distance to jump into the run of copies...
  $A515,$03 ...and store it at #R$A51F.
@ $A518 label=DrawSprites_ClipRows
  $A518,$02 Set the counter that is used by LDI.
  $A51A,$03 Fetch the number of rows.
  $A51D,$01 Store it in #REGb.
@ $A51E label=DrawSprites_ClipRow
  $A51E,$01 Save the screen address of the row.
@ $A51F label=DrawSprites_ClipJump
  $A51F,$02 Jump into the run of copies.
  $A521,$03 Jump to #R$A57C when the rows are done.
@ $A524 label=DrawSprites_ClipBytes
  $A524,$02 Copy a byte of the row to the screen.
  $A526,$02 Copy a byte of the row to the screen.
  $A528,$02 Copy a byte of the row to the screen.
  $A52A,$02 Copy a byte of the row to the screen.
  $A52C,$02 Copy a byte of the row to the screen.
  $A52E,$02 Copy a byte of the row to the screen.
  $A530,$02 Move to the start of the next row of the buffer.
  $A532,$01 Add the amount to skip.
  $A533,$01 Store it in #REGl.
  $A534,$01 Restore the screen address of the row.
  $A535,$01 Move up a pixel row.
  $A536,$01 Fetch the high byte.
  $A537,$01 Add one.
  $A538,$02,b$01 Keep the bits that give the pixel row.
  $A53A,$03 Jump to #R$A51E if the row is still in the same cell.
  $A53D,$01 Fetch the low byte.
  $A53E,$02 Move up a row of cells.
  $A540,$01 Store it.
  $A541,$03 Jump to #R$A51E if that crossed a third of the screen.
  $A544,$01 Fetch the high byte.
  $A545,$02 Add eight to correct it.
  $A547,$01 Store it.
  $A548,$03 Jump to #R$A51E.
@ $A54B label=DrawSprites_CopyAll
  $A54B,$03 Fetch the number of rows.
  $A54E,$01 Store it in #REGb.
  $A54F,$02 Set the counter that is used by LDI.
@ $A551 label=DrawSprites_CopyAllRow
  $A551,$01 Save the screen address of the row.
@ $A552 label=DrawSprites_CopyAllJump
  $A552,$02 Jump into the run of copies.
  $A554,$03 Jump to #R$A57C when the rows are done.
@ $A557 label=DrawSprites_CopyAllBytes
  $A557,$02 Copy a byte of the row to the screen.
  $A559,$02 Copy a byte of the row to the screen.
  $A55B,$02 Copy a byte of the row to the screen.
  $A55D,$02 Copy a byte of the row to the screen.
  $A55F,$02 Copy a byte of the row to the screen.
  $A561,$02 Copy a byte of the row to the screen.
  $A563,$02 Copy a byte of the row to the screen.
  $A565,$01 Restore the screen address of the row.
  $A566,$01 Move up a pixel row.
  $A567,$01 Fetch the high byte.
  $A568,$01 Add one.
  $A569,$02,b$01 Keep the bits that give the pixel row.
  $A56B,$03 Jump to #R$A551 if the row is still in the same cell.
  $A56E,$01 Fetch the low byte.
  $A56F,$02 Move up a row of cells.
  $A571,$01 Store it.
  $A572,$03 Jump to #R$A551 if that crossed a third of the screen.
  $A575,$01 Fetch the high byte.
  $A576,$02 Add eight to correct it.
  $A578,$01 Store it.
  $A579,$03 Jump to #R$A551.
@ $A57C label=DrawSprites_Done
  $A57C,$01 Discard the extra screen address.
  $A57D,$01 Return.

c $A57E Find Buffer Address
@ $A57E label=FindBufferAddress
D $A57E Finds the address in the buffer at #N($F800) of the top left of a sprite
. in the rectangle that is being drawn by #R$A303.
R $A57E H Vertical position
R $A57E L Horizontal position
R $A57E O:HL Address in the buffer
  $A57E,$03 Fetch the left of the rectangle.
  $A581,$01 Store it in #REGc.
  $A582,$01 Fetch the horizontal position.
  $A583,$01 Subtract the left of the rectangle.
  $A584,$06 Divide it by eight to get the number of bytes across.
  $A58A,$01 Store it in #REGl.
  $A58B,$03 Fetch the bottom of the rectangle.
  $A58E,$01 Subtract the vertical position to get the number of rows up.
  $A58F,$02 Jump to #R$A59C if the sprite is at the bottom.
  $A591,$01 Store the number of rows in #REGc.
  $A592,$03 Fetch the number of bytes in a row.
  $A595,$01 Store it in #REGh.
@ $A596 label=FindBufferAddress_Row
  $A596,$01 Fetch the offset.
  $A597,$01 Add the number of bytes in a row.
  $A598,$01 Store the offset.
  $A599,$01 Count the rows.
  $A59A,$02 Loop back to #R$A596 for each row.
@ $A59C label=FindBufferAddress_Page
  $A59C,$02 Use the buffer.
  $A59E,$01 Return.

c $A59F Draw Sprites Directly
@ $A59F label=DrawSpritesDirectly
D $A59F Erases one sprite and draws another straight on the screen instead of
. using a buffer. The rows of the two sprites are dealt with one at a time,
. alternating between an erased row and a drawn row, so that they stay in step.
. The sprite that is lower on the screen starts first, as the rows of a
. sprite go up the screen, and its first rows are done by themselves until the
. other sprite starts. The sprites are set up by #R$A266 and #R$A27A, which
. store the number of rows at #N($5C1C) and #N($5C1D). The first sprite is
. erased using the alternate registers and the second sprite is drawn using
. the main registers.
R $A59F DE Address of the data of the second sprite
R $A59F DE' Address of the data of the first sprite
R $A59F HL Screen address of the second sprite
R $A59F HL' Screen address of the first sprite
R $A59F IX Routine that draws the second sprite
R $A59F IY Routine that erases the first sprite
  $A59F,$01 Fetch the low byte of the screen address of the second sprite.
  $A5A0,$03 Store it as the start of a row.
  $A5A3,$01 Switch to the first sprite.
  $A5A4,$01 Fetch the low byte of its screen address.
  $A5A5,$03 Store it as the start of a row.
  $A5A8,$01 Switch back to the second sprite.
  $A5A9,$03 Fetch the number of rows of the second sprite.
  $A5AC,$01 Keep it in the alternate accumulator.
  $A5AD,$03 Fetch the number of rows of the first sprite.
  $A5B0,$01 Test it.
  $A5B1,$03 Jump to #R$A61C if the first sprite has no rows.
  $A5B4,$03 Fetch the number of rows of the second sprite.
  $A5B7,$01 Test it.
  $A5B8,$03 Jump to #R$A61C if the second sprite has no rows.
  $A5BB,$03 Fetch the vertical position of the first sprite.
  $A5BE,$01 Store it in #REGc.
  $A5BF,$03 Fetch the vertical position of the second sprite.
  $A5C2,$01 Subtract the position of the first sprite.
  $A5C3,$03 Jump to #R$A61C if they start on the same row.
  $A5C6,$02 Jump to #R$A5EB if the second sprite is the lower one.
N $A5C8 The first sprite is the lower one, so do its first rows by themselves.
  $A5C8,$02 Make the difference positive.
  $A5CA,$01 Store it in #REGc.
  $A5CB,$03 Fetch the number of rows of the first sprite.
  $A5CE,$01 Take off the difference.
  $A5CF,$03 Store it for later.
  $A5D2,$02 Jump to #R$A5D8 if the first sprite has fewer rows than that.
  $A5D4,$01 Otherwise use the difference as the number of rows to do.
  $A5D5,$03 Store it.
@ $A5D8 label=DrawSpritesDirectly_First
  $A5D8,$01 Clear #REGa.
  $A5D9,$01 Make the second sprite have no rows for now.
  $A5DA,$03 Do the rows of the first sprite.
  $A5DD,$01 Switch to the second sprite.
  $A5DE,$03 Fetch the number of rows that are left for the first sprite.
  $A5E1,$03 Store it.
  $A5E4,$03 Fetch the number of rows of the second sprite.
  $A5E7,$01 Restore it.
  $A5E8,$03 Jump to #R$A61C to do the rows of both sprites.
N $A5EB The second sprite is the lower one, so do its first rows by
. themselves.
@ $A5EB label=DrawSpritesDirectly_Second
  $A5EB,$01 Store the difference in #REGc.
  $A5EC,$03 Fetch the number of rows of the second sprite.
  $A5EF,$01 Take off the difference.
  $A5F0,$03 Store it for later.
  $A5F3,$02 Jump to #R$A5F7 if the second sprite has fewer rows than that.
  $A5F5,$01 Otherwise use the difference as the number of rows to do.
  $A5F6,$01 Store it.
@ $A5F7 label=DrawSpritesDirectly_SecondRows
  $A5F7,$03 Fetch the number of rows of the first sprite.
  $A5FA,$03 Keep it.
  $A5FD,$01 Clear #REGa.
  $A5FE,$03 Make the first sprite have no rows for now.
  $A601,$03 Do the rows of the second sprite.
  $A604,$03 Fetch the number of rows of the first sprite.
  $A607,$03 Restore it.
  $A60A,$03 Fetch the number of rows that are left for the second sprite.
  $A60D,$01 Store it.
  $A60E,$03 Jump to #R$A61C to do the rows of both sprites.
@ $A611 label=DrawSpritesDirectly_SecondRow
  $A611,$01 Switch to the count of the second sprite.
  $A612,$03 Fetch the number of rows of the first sprite.
  $A615,$01 Take one off.
  $A616,$01 Return if there are none left.
  $A617,$03 Store it.
  $A61A,$02 Erase a row of the first sprite.
@ $A61C label=DrawSpritesDirectly_Row
  $A61C,$03 Fetch the number of rows of the first sprite.
  $A61F,$01 Take one off.
  $A620,$03 Jump to #R$A669 if there are none left.
  $A623,$03 Store it.
  $A626,$01 Switch to the first sprite.
  $A627,$02 Erase a row of the first sprite.

c $A629 Erase Aligned Row Directly
@ $A629 label=EraseAlignedRowDirectly
D $A629 Erases one row of a sprite that is aligned to a byte from the screen.
. The entry point depends on the width of the sprite in bytes, from six bytes
. at #R$A629 to one byte at #R$A647. Each byte clears the pixels of the screen
. that are set in the sprite.
R $A629 DE' Address of the data of the sprite
R $A629 HL' Screen address of the row
  $A629,$01 Fetch a byte of the sprite.
  $A62A,$01 Invert it.
  $A62B,$01 Clear the pixels of the screen.
  $A62C,$01 Store the byte.
  $A62D,$01 Move on to the next byte of the screen.
  $A62E,$01 Move on to the next byte of the sprite.
@ $A62F label=EraseAlignedRowDirectly_Second
  $A62F,$01 Fetch a byte of the sprite.
  $A630,$01 Invert it.
  $A631,$01 Clear the pixels of the screen.
  $A632,$01 Store the byte.
  $A633,$01 Move on to the next byte of the screen.
  $A634,$01 Move on to the next byte of the sprite.
@ $A635 label=EraseAlignedRowDirectly_Third
  $A635,$01 Fetch a byte of the sprite.
  $A636,$01 Invert it.
  $A637,$01 Clear the pixels of the screen.
  $A638,$01 Store the byte.
  $A639,$01 Move on to the next byte of the screen.
  $A63A,$01 Move on to the next byte of the sprite.
@ $A63B label=EraseAlignedRowDirectly_Fourth
  $A63B,$01 Fetch a byte of the sprite.
  $A63C,$01 Invert it.
  $A63D,$01 Clear the pixels of the screen.
  $A63E,$01 Store the byte.
  $A63F,$01 Move on to the next byte of the screen.
  $A640,$01 Move on to the next byte of the sprite.
@ $A641 label=EraseAlignedRowDirectly_Fifth
  $A641,$01 Fetch a byte of the sprite.
  $A642,$01 Invert it.
  $A643,$01 Clear the pixels of the screen.
  $A644,$01 Store the byte.
  $A645,$01 Move on to the next byte of the screen.
  $A646,$01 Move on to the next byte of the sprite.
@ $A647 label=EraseAlignedRowDirectly_Sixth
  $A647,$01 Fetch a byte of the sprite.
  $A648,$01 Invert it.
  $A649,$01 Clear the pixels of the screen.
  $A64A,$01 Store the byte.
  $A64B,$01 Move on to the next byte of the sprite.
@ $A64C label=EraseAlignedRowDirectly_Next
  $A64C,$03 Fetch the low byte of the screen address of the start of the row.
  $A64F,$01 Restore it.
  $A650,$01 Move up a pixel row.
  $A651,$01 Fetch the high byte.
  $A652,$01 Add one.
  $A653,$02,b$01 Keep the bits that give the pixel row.
  $A655,$03 Jump to #R$A66F if the row is still in the same cell.
  $A658,$01 Fetch the low byte.
  $A659,$02 Move up a row of cells.
  $A65B,$01 Store it.
  $A65C,$03 Store it as the start of the row.
  $A65F,$03 Jump to #R$A66F if that crossed a third of the screen.
  $A662,$01 Fetch the high byte.
  $A663,$02 Add eight to correct it.
  $A665,$01 Store it.
  $A666,$03 Jump to #R$A66F.

c $A669 Next Row Of Second Sprite
@ $A669 label=NextRowOfSecondSprite
D $A669 Used by #R$A59F when the first sprite has no rows left: it carries on
. with the rows of the second sprite until they are done.
  $A669,$01 Switch to the count of the second sprite.
  $A66A,$01 Take one off.
  $A66B,$01 Return if there are none left.
  $A66C,$01 Switch back.
  $A66D,$02 Draw a row of the second sprite.

c $A66F Draw Next Row
@ $A66F label=DrawNextRow
D $A66F Used by #R$A59F after a row of the first sprite has been erased: it
. draws a row of the second sprite, or erases another row of the first sprite
. when the second sprite has no rows left.
  $A66F,$01 Switch to the count of the second sprite.
  $A670,$01 Take one off.
  $A671,$03 Jump to #R$A611 if there are none left.
  $A674,$01 Switch back.
  $A675,$01 Switch to the second sprite.
  $A676,$02 Draw a row of the second sprite.

c $A678 Draw Aligned Row Directly
@ $A678 label=DrawAlignedRowDirectly
D $A678 Draws one row of a sprite that is aligned to a byte on the screen. The
. entry point depends on the width of the sprite in bytes, from six bytes at
. #R$A678 to one byte at #R$A691.
R $A678 DE Address of the data of the sprite
R $A678 HL Screen address of the row
  $A678,$01 Fetch a byte of the sprite.
  $A679,$01 Set the pixels of the screen.
  $A67A,$01 Store the byte.
  $A67B,$01 Move on to the next byte of the screen.
  $A67C,$01 Move on to the next byte of the sprite.
@ $A67D label=DrawAlignedRowDirectly_Second
  $A67D,$01 Fetch a byte of the sprite.
  $A67E,$01 Set the pixels of the screen.
  $A67F,$01 Store the byte.
  $A680,$01 Move on to the next byte of the screen.
  $A681,$01 Move on to the next byte of the sprite.
@ $A682 label=DrawAlignedRowDirectly_Third
  $A682,$01 Fetch a byte of the sprite.
  $A683,$01 Set the pixels of the screen.
  $A684,$01 Store the byte.
  $A685,$01 Move on to the next byte of the screen.
  $A686,$01 Move on to the next byte of the sprite.
@ $A687 label=DrawAlignedRowDirectly_Fourth
  $A687,$01 Fetch a byte of the sprite.
  $A688,$01 Set the pixels of the screen.
  $A689,$01 Store the byte.
  $A68A,$01 Move on to the next byte of the screen.
  $A68B,$01 Move on to the next byte of the sprite.
@ $A68C label=DrawAlignedRowDirectly_Fifth
  $A68C,$01 Fetch a byte of the sprite.
  $A68D,$01 Set the pixels of the screen.
  $A68E,$01 Store the byte.
  $A68F,$01 Move on to the next byte of the screen.
  $A690,$01 Move on to the next byte of the sprite.
@ $A691 label=DrawAlignedRowDirectly_Sixth
  $A691,$01 Fetch a byte of the sprite.
  $A692,$01 Set the pixels of the screen.
  $A693,$01 Store the byte.
  $A694,$01 Move on to the next byte of the sprite.
@ $A695 label=DrawAlignedRowDirectly_Next
  $A695,$03 Fetch the low byte of the screen address of the start of the row.
  $A698,$01 Restore it.
  $A699,$01 Move up a pixel row.
  $A69A,$01 Fetch the high byte.
  $A69B,$01 Add one.
  $A69C,$02,b$01 Keep the bits that give the pixel row.
  $A69E,$03 Jump to #R$A61C if the row is still in the same cell.
  $A6A1,$01 Fetch the low byte.
  $A6A2,$02 Move up a row of cells.
  $A6A4,$01 Store it.
  $A6A5,$03 Store it as the start of the row.
  $A6A8,$03 Jump to #R$A61C if that crossed a third of the screen.
  $A6AB,$01 Fetch the high byte.
  $A6AC,$02 Add eight to correct it.
  $A6AE,$01 Store it.
  $A6AF,$03 Jump to #R$A61C.

c $A6B2 Erase Aligned Row In Buffer
@ $A6B2 label=EraseAlignedRowInBuffer
D $A6B2 Erases one row of a sprite that is aligned to a byte from the buffer
. used by #R$A303. The entry point depends on the width of the sprite in bytes,
. from six bytes at #R$A6B2 to one byte at #R$A6D0.
R $A6B2 DE' Address of the data of the sprite
R $A6B2 HL' Address in the buffer
  $A6B2,$01 Fetch a byte of the sprite.
  $A6B3,$01 Invert it.
  $A6B4,$01 Clear the pixels of the buffer.
  $A6B5,$01 Store the byte.
  $A6B6,$01 Move on to the next byte of the sprite.
  $A6B7,$01 Move on to the next byte of the buffer.
  $A6B8,$01 Fetch a byte of the sprite.
  $A6B9,$01 Invert it.
  $A6BA,$01 Clear the pixels of the buffer.
  $A6BB,$01 Store the byte.
  $A6BC,$01 Move on to the next byte of the sprite.
  $A6BD,$01 Move on to the next byte of the buffer.
  $A6BE,$01 Fetch a byte of the sprite.
  $A6BF,$01 Invert it.
  $A6C0,$01 Clear the pixels of the buffer.
  $A6C1,$01 Store the byte.
  $A6C2,$01 Move on to the next byte of the sprite.
  $A6C3,$01 Move on to the next byte of the buffer.
  $A6C4,$01 Fetch a byte of the sprite.
  $A6C5,$01 Invert it.
  $A6C6,$01 Clear the pixels of the buffer.
  $A6C7,$01 Store the byte.
  $A6C8,$01 Move on to the next byte of the sprite.
  $A6C9,$01 Move on to the next byte of the buffer.
  $A6CA,$01 Fetch a byte of the sprite.
  $A6CB,$01 Invert it.
  $A6CC,$01 Clear the pixels of the buffer.
  $A6CD,$01 Store the byte.
  $A6CE,$01 Move on to the next byte of the sprite.
  $A6CF,$01 Move on to the next byte of the buffer.
  $A6D0,$01 Fetch a byte of the sprite.
  $A6D1,$01 Invert it.
  $A6D2,$01 Clear the pixels of the buffer.
  $A6D3,$01 Store the byte.
  $A6D4,$01 Move on to the next byte of the sprite.
  $A6D5,$02 Fetch the amount to skip, which was set at #R$A45D.
  $A6D7,$01 Add it to the address in the buffer.
  $A6D8,$01 Store it in #REGl.
  $A6D9,$01 Switch to the count of rows.
  $A6DA,$01 Take one off.
  $A6DB,$03 Jump to #R$A469 to draw the second sprite when there are none left.
  $A6DE,$01 Switch back.
  $A6DF,$02 Erase the next row.

c $A6E1 Erase Shifted Row In Buffer
@ $A6E1 label=EraseShiftedRowInBuffer
D $A6E1 Erases one row of a sprite that is not aligned to a byte from the
. buffer used by #R$A303, using the shift table that #REGb points to. Each
. byte of the sprite makes two bytes in the buffer. The entry point depends on
. the width of the sprite in bytes, from five bytes at #R$A6E1 to one byte at
. #R$A719.
R $A6E1 B High byte of the shift table
R $A6E1 DE' Address of the data of the sprite
R $A6E1 HL' Address in the buffer
  $A6E1,$01 Fetch a byte of the sprite.
  $A6E2,$01 Use it to look up the left part in the shift table.
  $A6E3,$01 Fetch the left part.
  $A6E4,$01 Invert it.
  $A6E5,$01 Clear the pixels of the buffer.
  $A6E6,$01 Store the byte.
  $A6E7,$01 Move to the table of right parts.
  $A6E8,$01 Move on to the next byte of the buffer.
  $A6E9,$01 Fetch the right part.
  $A6EA,$01 Invert it.
  $A6EB,$01 Move back to the table of left parts.
  $A6EC,$01 Clear the pixels of the buffer.
  $A6ED,$01 Store the byte.
  $A6EE,$01 Move on to the next byte of the sprite.
  $A6EF,$01 Fetch a byte of the sprite.
  $A6F0,$01 Use it to look up the left part in the shift table.
  $A6F1,$01 Fetch the left part.
  $A6F2,$01 Invert it.
  $A6F3,$01 Clear the pixels of the buffer.
  $A6F4,$01 Store the byte.
  $A6F5,$01 Move to the table of right parts.
  $A6F6,$01 Move on to the next byte of the buffer.
  $A6F7,$01 Fetch the right part.
  $A6F8,$01 Invert it.
  $A6F9,$01 Clear the pixels of the buffer.
  $A6FA,$01 Store the byte.
  $A6FB,$01 Move back to the table of left parts.
  $A6FC,$01 Move on to the next byte of the sprite.
  $A6FD,$01 Fetch a byte of the sprite.
  $A6FE,$01 Use it to look up the left part in the shift table.
  $A6FF,$01 Fetch the left part.
  $A700,$01 Invert it.
  $A701,$01 Clear the pixels of the buffer.
  $A702,$01 Store the byte.
  $A703,$01 Move to the table of right parts.
  $A704,$01 Move on to the next byte of the buffer.
  $A705,$01 Fetch the right part.
  $A706,$01 Invert it.
  $A707,$01 Move back to the table of left parts.
  $A708,$01 Clear the pixels of the buffer.
  $A709,$01 Store the byte.
  $A70A,$01 Move on to the next byte of the sprite.
  $A70B,$01 Fetch a byte of the sprite.
  $A70C,$01 Use it to look up the left part in the shift table.
  $A70D,$01 Fetch the left part.
  $A70E,$01 Invert it.
  $A70F,$01 Clear the pixels of the buffer.
  $A710,$01 Store the byte.
  $A711,$01 Move to the table of right parts.
  $A712,$01 Move on to the next byte of the buffer.
  $A713,$01 Fetch the right part.
  $A714,$01 Invert it.
  $A715,$01 Move back to the table of left parts.
  $A716,$01 Clear the pixels of the buffer.
  $A717,$01 Store the byte.
  $A718,$01 Move on to the next byte of the sprite.
  $A719,$01 Fetch a byte of the sprite.
  $A71A,$01 Use it to look up the left part in the shift table.
  $A71B,$01 Fetch the left part.
  $A71C,$01 Invert it.
  $A71D,$01 Clear the pixels of the buffer.
  $A71E,$01 Store the byte.
  $A71F,$01 Move to the table of right parts.
  $A720,$01 Move on to the next byte of the buffer.
  $A721,$01 Fetch the right part.
  $A722,$01 Invert it.
  $A723,$01 Move back to the table of left parts.
  $A724,$01 Clear the pixels of the buffer.
  $A725,$01 Store the byte.
  $A726,$01 Move on to the next byte of the sprite.
  $A727,$02 Fetch the amount to skip, which was set at #R$A460.
  $A729,$01 Add it to the address in the buffer.
  $A72A,$01 Store it in #REGl.
  $A72B,$01 Switch to the count of rows.
  $A72C,$01 Take one off.
  $A72D,$03 Jump to #R$A469 to draw the second sprite when there are none left.
  $A730,$01 Switch back.
  $A731,$02 Erase the next row.

c $A733 Draw Aligned Row In Buffer
@ $A733 label=DrawAlignedRowInBuffer
D $A733 Draws one row of a sprite that is aligned to a byte into the buffer
. used by #R$A303. The entry point depends on the width of the sprite in bytes,
. from six bytes at #R$A733 to one byte at #R$A74C.
R $A733 DE Address of the data of the sprite
R $A733 HL Address in the buffer
  $A733,$01 Fetch a byte of the sprite.
  $A734,$01 Set the pixels of the buffer.
  $A735,$01 Store the byte.
  $A736,$01 Move on to the next byte of the sprite.
  $A737,$01 Move on to the next byte of the buffer.
  $A738,$01 Fetch a byte of the sprite.
  $A739,$01 Set the pixels of the buffer.
  $A73A,$01 Store the byte.
  $A73B,$01 Move on to the next byte of the sprite.
  $A73C,$01 Move on to the next byte of the buffer.
  $A73D,$01 Fetch a byte of the sprite.
  $A73E,$01 Set the pixels of the buffer.
  $A73F,$01 Store the byte.
  $A740,$01 Move on to the next byte of the sprite.
  $A741,$01 Move on to the next byte of the buffer.
  $A742,$01 Fetch a byte of the sprite.
  $A743,$01 Set the pixels of the buffer.
  $A744,$01 Store the byte.
  $A745,$01 Move on to the next byte of the sprite.
  $A746,$01 Move on to the next byte of the buffer.
  $A747,$01 Fetch a byte of the sprite.
  $A748,$01 Set the pixels of the buffer.
  $A749,$01 Store the byte.
  $A74A,$01 Move on to the next byte of the sprite.
  $A74B,$01 Move on to the next byte of the buffer.
  $A74C,$01 Fetch a byte of the sprite.
  $A74D,$01 Set the pixels of the buffer.
  $A74E,$01 Store the byte.
  $A74F,$01 Move on to the next byte of the sprite.
  $A750,$02 Fetch the amount to skip, which was set at #R$A485.
  $A752,$01 Add it to the address in the buffer.
  $A753,$01 Store it in #REGl.
  $A754,$01 Switch to the count of rows.
  $A755,$01 Take one off.
  $A756,$03 Jump to #R$A498 to finish when there are none left.
  $A759,$01 Switch back.
  $A75A,$02 Draw the next row.

c $A75C Draw Shifted Row In Buffer
@ $A75C label=DrawShiftedRowInBuffer
D $A75C Draws one row of a sprite that is not aligned to a byte into the buffer
. used by #R$A303, using the shift table that #REGb points to. Each byte of the
. sprite makes two bytes in the buffer. The entry point depends on the width of
. the sprite in bytes, from five bytes at #R$A75C to one byte at #R$A78C.
R $A75C B High byte of the shift table
R $A75C DE Address of the data of the sprite
R $A75C HL Address in the buffer
  $A75C,$01 Fetch a byte of the sprite.
  $A75D,$01 Use it to look up the left part in the shift table.
  $A75E,$01 Fetch the left part.
  $A75F,$01 Set the pixels of the buffer.
  $A760,$01 Store the byte.
  $A761,$01 Move to the table of right parts.
  $A762,$01 Move on to the next byte of the buffer.
  $A763,$01 Fetch the right part.
  $A764,$01 Set the pixels of the buffer.
  $A765,$01 Store the byte.
  $A766,$01 Move back to the table of left parts.
  $A767,$01 Move on to the next byte of the sprite.
  $A768,$01 Fetch a byte of the sprite.
  $A769,$01 Use it to look up the left part in the shift table.
  $A76A,$01 Fetch the left part.
  $A76B,$01 Set the pixels of the buffer.
  $A76C,$01 Store the byte.
  $A76D,$01 Move to the table of right parts.
  $A76E,$01 Move on to the next byte of the buffer.
  $A76F,$01 Fetch the right part.
  $A770,$01 Set the pixels of the buffer.
  $A771,$01 Store the byte.
  $A772,$01 Move back to the table of left parts.
  $A773,$01 Move on to the next byte of the sprite.
  $A774,$01 Fetch a byte of the sprite.
  $A775,$01 Use it to look up the left part in the shift table.
  $A776,$01 Fetch the left part.
  $A777,$01 Set the pixels of the buffer.
  $A778,$01 Store the byte.
  $A779,$01 Move to the table of right parts.
  $A77A,$01 Move on to the next byte of the buffer.
  $A77B,$01 Fetch the right part.
  $A77C,$01 Set the pixels of the buffer.
  $A77D,$01 Store the byte.
  $A77E,$01 Move back to the table of left parts.
  $A77F,$01 Move on to the next byte of the sprite.
  $A780,$01 Fetch a byte of the sprite.
  $A781,$01 Use it to look up the left part in the shift table.
  $A782,$01 Fetch the left part.
  $A783,$01 Set the pixels of the buffer.
  $A784,$01 Store the byte.
  $A785,$01 Move to the table of right parts.
  $A786,$01 Move on to the next byte of the buffer.
  $A787,$01 Fetch the right part.
  $A788,$01 Set the pixels of the buffer.
  $A789,$01 Store the byte.
  $A78A,$01 Move back to the table of left parts.
  $A78B,$01 Move on to the next byte of the sprite.
  $A78C,$01 Fetch a byte of the sprite.
  $A78D,$01 Use it to look up the left part in the shift table.
  $A78E,$01 Fetch the left part.
  $A78F,$01 Set the pixels of the buffer.
  $A790,$01 Store the byte.
  $A791,$01 Move to the table of right parts.
  $A792,$01 Move on to the next byte of the buffer.
  $A793,$01 Fetch the right part.
  $A794,$01 Set the pixels of the buffer.
  $A795,$01 Store the byte.
  $A796,$01 Move back to the table of left parts.
  $A797,$01 Move on to the next byte of the sprite.
  $A798,$02 Fetch the amount to skip, which was set at #R$A488.
  $A79A,$01 Add it to the address in the buffer.
  $A79B,$01 Store it in #REGl.
  $A79C,$01 Switch to the count of rows.
  $A79D,$01 Take one off.
  $A79E,$03 Jump to #R$A498 to finish when there are none left.
  $A7A1,$01 Switch back.
  $A7A2,$02 Draw the next row.

c $A7A4 Erase Mirrored Row Directly
@ $A7A4 label=EraseMirroredRowDirectly
D $A7A4 Erases one row of a sprite that is flipped from left to right from the
. screen. Each byte of the sprite has its bits reversed by the table that
. #REGb points to, and the screen is filled from right to left. The entry point
. depends on the width of the sprite in bytes, from six bytes at #R$A7A4 to one
. byte at #R$A7CC.
R $A7A4 B High byte of the table that reverses bits
R $A7A4 DE' Address of the data of the sprite
R $A7A4 HL' Screen address of the right of the row
  $A7A4,$01 Fetch a byte of the sprite.
  $A7A5,$01 Use it to look up the byte with the bits reversed.
  $A7A6,$01 Fetch it.
  $A7A7,$01 Invert it.
  $A7A8,$01 Clear the pixels of the screen.
  $A7A9,$01 Store the byte.
  $A7AA,$01 Move on to the next byte of the screen to the left.
  $A7AB,$01 Move on to the next byte of the sprite.
@ $A7AC label=EraseMirroredRowDirectly_Second
  $A7AC,$01 Fetch a byte of the sprite.
  $A7AD,$01 Use it to look up the byte with the bits reversed.
  $A7AE,$01 Fetch it.
  $A7AF,$01 Invert it.
  $A7B0,$01 Clear the pixels of the screen.
  $A7B1,$01 Store the byte.
  $A7B2,$01 Move on to the next byte of the screen to the left.
  $A7B3,$01 Move on to the next byte of the sprite.
@ $A7B4 label=EraseMirroredRowDirectly_Third
  $A7B4,$01 Fetch a byte of the sprite.
  $A7B5,$01 Use it to look up the byte with the bits reversed.
  $A7B6,$01 Fetch it.
  $A7B7,$01 Invert it.
  $A7B8,$01 Clear the pixels of the screen.
  $A7B9,$01 Store the byte.
  $A7BA,$01 Move on to the next byte of the screen to the left.
  $A7BB,$01 Move on to the next byte of the sprite.
@ $A7BC label=EraseMirroredRowDirectly_Fourth
  $A7BC,$01 Fetch a byte of the sprite.
  $A7BD,$01 Use it to look up the byte with the bits reversed.
  $A7BE,$01 Fetch it.
  $A7BF,$01 Invert it.
  $A7C0,$01 Clear the pixels of the screen.
  $A7C1,$01 Store the byte.
  $A7C2,$01 Move on to the next byte of the screen to the left.
  $A7C3,$01 Move on to the next byte of the sprite.
@ $A7C4 label=EraseMirroredRowDirectly_Fifth
  $A7C4,$01 Fetch a byte of the sprite.
  $A7C5,$01 Use it to look up the byte with the bits reversed.
  $A7C6,$01 Fetch it.
  $A7C7,$01 Invert it.
  $A7C8,$01 Clear the pixels of the screen.
  $A7C9,$01 Store the byte.
  $A7CA,$01 Move on to the next byte of the screen to the left.
  $A7CB,$01 Move on to the next byte of the sprite.
@ $A7CC label=EraseMirroredRowDirectly_Sixth
  $A7CC,$01 Fetch a byte of the sprite.
  $A7CD,$01 Use it to look up the byte with the bits reversed.
  $A7CE,$01 Fetch it.
  $A7CF,$01 Invert it.
  $A7D0,$01 Clear the pixels of the screen.
  $A7D1,$01 Store the byte.
  $A7D2,$01 Move on to the next byte of the sprite.
  $A7D3,$03 Jump to #R$A64C.

c $A7D6 Draw Mirrored Row Directly
@ $A7D6 label=DrawMirroredRowDirectly
D $A7D6 Draws one row of a sprite that is flipped from left to right on the
. screen. Each byte of the sprite has its bits reversed by the table that
. #REGb points to, and the screen is filled from right to left. The entry point
. depends on the width of the sprite in bytes, from six bytes at #R$A7D6 to one
. byte at #R$A7F9.
R $A7D6 B High byte of the table that reverses bits
R $A7D6 DE Address of the data of the sprite
R $A7D6 HL Screen address of the right of the row
  $A7D6,$01 Fetch a byte of the sprite.
  $A7D7,$01 Use it to look up the byte with the bits reversed.
  $A7D8,$01 Fetch it.
  $A7D9,$01 Set the pixels of the screen.
  $A7DA,$01 Store the byte.
  $A7DB,$01 Move on to the next byte of the screen to the left.
  $A7DC,$01 Move on to the next byte of the sprite.
@ $A7DD label=DrawMirroredRowDirectly_Second
  $A7DD,$01 Fetch a byte of the sprite.
  $A7DE,$01 Use it to look up the byte with the bits reversed.
  $A7DF,$01 Fetch it.
  $A7E0,$01 Set the pixels of the screen.
  $A7E1,$01 Store the byte.
  $A7E2,$01 Move on to the next byte of the screen to the left.
  $A7E3,$01 Move on to the next byte of the sprite.
@ $A7E4 label=DrawMirroredRowDirectly_Third
  $A7E4,$01 Fetch a byte of the sprite.
  $A7E5,$01 Use it to look up the byte with the bits reversed.
  $A7E6,$01 Fetch it.
  $A7E7,$01 Set the pixels of the screen.
  $A7E8,$01 Store the byte.
  $A7E9,$01 Move on to the next byte of the screen to the left.
  $A7EA,$01 Move on to the next byte of the sprite.
@ $A7EB label=DrawMirroredRowDirectly_Fourth
  $A7EB,$01 Fetch a byte of the sprite.
  $A7EC,$01 Use it to look up the byte with the bits reversed.
  $A7ED,$01 Fetch it.
  $A7EE,$01 Set the pixels of the screen.
  $A7EF,$01 Store the byte.
  $A7F0,$01 Move on to the next byte of the screen to the left.
  $A7F1,$01 Move on to the next byte of the sprite.
@ $A7F2 label=DrawMirroredRowDirectly_Fifth
  $A7F2,$01 Fetch a byte of the sprite.
  $A7F3,$01 Use it to look up the byte with the bits reversed.
  $A7F4,$01 Fetch it.
  $A7F5,$01 Set the pixels of the screen.
  $A7F6,$01 Store the byte.
  $A7F7,$01 Move on to the next byte of the screen to the left.
  $A7F8,$01 Move on to the next byte of the sprite.
@ $A7F9 label=DrawMirroredRowDirectly_Sixth
  $A7F9,$01 Fetch a byte of the sprite.
  $A7FA,$01 Use it to look up the byte with the bits reversed.
  $A7FB,$01 Fetch it.
  $A7FC,$01 Set the pixels of the screen.
  $A7FD,$01 Store the byte.
  $A7FE,$01 Move on to the next byte of the sprite.
  $A7FF,$03 Jump to #R$A695.

c $A802 Delay
@ $A802 label=Delay
D $A802 Waits for a short time that is proportional to #REGd.
E $A802 View the equivalent code in;
. #LIST
. { #BUBBLER$A8F9 }
. LIST#
R $A802 D Length of the delay
  $A802,$02 Set the inner counter.
@ $A804 label=Delay_Loop
  $A804,$01 Count down the inner counter.
  $A805,$02 Loop back to #R$A804 until none remain.
  $A807,$01 Count down the outer counter.
  $A808,$02 Loop back to #R$A802 until none remain.
  $A80A,$01 Return.

g $A80B Map Object Slots
@ $A80B label=MapObjectSlots
D $A80B Six slots of #N($1A) bytes for the objects of the planet that are
. near the ship. They have the same layout as the slots at #R$9974, with two
. more bytes at the end: the index in the table at #N$5C94 of the map entry
. that the object came from (at offsets #N($18) and #N($19)). A slot with a
. type of #N($FF) is free. The last slot is cut short by the code at
. #R$A8A5.
B $A80B,$68,$1A
@ $A873 label=MapObjectSlots_Fifth
B $A873,$1A,$1A
@ $A88D label=MapObjectSlots_Sixth
B $A88D,$18,$18

c $A8A5 Add To Stack
@ $A8A5 label=AddToStack
D $A8A5 Adds one or two units to the height of the stack at #R$C905 (which
. hangs below the ship) if the item that is carried at #R$F601 is item number
. #N($06). The limit is #N($12). The screen is cleared where the new units
. will be drawn. This is a best reading of the code. An object with a state of
. zero does not add anything.
E $A8A5 Continue on to #R$A8D9.
R $A8A5 IX Address of the object
  $A8A5,$03 Fetch the state of the object.
  $A8A8,$02 Return if it is zero.
N $A8AA The routine is entered here with a state in #REGa when the number of
. units is random.
@ $A8AA label=AddToStack_Units
  $A8AA,$02,b$01 Keep bit 1 of the state...
  $A8AC,$02 ...move it to bit 0...
  $A8AE,$01 ...and add one to get one or two units.
  $A8AF,$01 Store the number of units in #REGb.
  $A8B0,$03 Fetch the item that is carried.
  $A8B3,$03 Return if it is not item number #N($06).
  $A8B6,$04 Fetch the height of the stack and keep the old height in #REGe.
  $A8BA,$01 Add the new units.
  $A8BB,$04 Jump to #R$A8C1 if the height is below the limit of #N($12).
  $A8BF,$02 Use the limit.
@ $A8C1 label=AddToStack_Store
  $A8C1,$03 Store the new height of the stack.
  $A8C4,$03 Fetch the vertical position of the ship.
  $A8C7,$01 Subtract the old height to find the first new row.
  $A8C8,$01 Store it in #REGh.
  $A8C9,$02 Use the horizontal position of the stack.
  $A8CB,$03 Find the screen address.
@ $A8CE label=AddToStack_Clear
  $A8CE,$02 Clear the left byte of the row.
  $A8D0,$01 Move on to the right.
  $A8D1,$02 Clear the right byte of the row.
  $A8D3,$01 Move back to the left.
  $A8D4,$03 Move up a row.
  $A8D7,$02 Loop back to #R$A8CE for each new unit.

c $A8D9 Build Stack Graphic
@ $A8D9 label=BuildStackGraphic
D $A8D9 Builds the graphic of the stack that hangs below the ship, as a sprite
. that is two bytes wide in a buffer with seven bytes to a row, by copying one
. row of the stack for each unit of its height. This is a best reading of the
. code.
  $A8D9,$03 Use the buffer.
  $A8DC,$03 Use the graphic of the stack.
  $A8DF,$03 Fetch the height of the stack.
  $A8E2,$02 Return if the stack is empty.
  $A8E4,$01 Use the height as a counter.
@ $A8E5 label=BuildStackGraphic_Loop
  $A8E5,$01 Copy a row of the stack...
  $A8E6,$01 Write #REGa where #REGhl points.
  $A8E7,$01 Advance #REGde.
  $A8E8,$01 Advance #REGhl.
  $A8E9,$01 ...two bytes wide.
  $A8EA,$01 Write #REGa where #REGhl points.
  $A8EB,$01 Advance #REGde.
  $A8EC,$02 Move on to the next row of the buffer.
  $A8EE,$03 Call #R$9BCF.
  $A8F1,$02 Loop back to #R$A8E5 for each row.
  $A8F3,$01 Return.

c $A8F4 Check Map Object Collisions
@ $A8F4 label=CheckMapObjectCollisions
D $A8F4 Checks whether the ship is touching any of the first four map objects
. in the slots at #R$A80B. When it is, most objects bounce the ship back, but a
. type #N($1B) object in state four or five fills the fuel gauge, which is
. held in #R$CC4B, and flashes the ship, and is then removed and marked as
. destroyed in the map table.
  $A8F4,$03 Fetch the flag that is set once the crystals are delivered.
  $A8F7,$02 Return if it is set.
  $A8F9,$02 Set the number of slots to four.
  $A8FB,$04 Use the first slot.
  $A8FF,$03 Fetch the position of the ship.
  $A902,$02 The ship is always at the same horizontal position.
  $A904,$03 Fetch the horizontal scroll speed.
  $A907,$02 Negate it.
  $A909,$01 Subtract it from the horizontal position.
  $A90A,$01 Store the horizontal position.
  $A90B,$03 Fetch the vertical scroll speed.
  $A90E,$02 Negate it.
  $A910,$01 Subtract it from the vertical position.
  $A911,$01 Store the vertical position.
  $A912,$03 Store the position of the ship.
  $A915,$02 The ship is #N($28) pixels wide.
  $A917,$03 Fetch the height of the ship.
  $A91A,$01 Put it in #REGe.
  $A91B,$04 Store the size of the ship.
@ $A91F label=CheckMapObjectCollisions_Loop
  $A91F,$01 Save the slot counter.
  $A920,$02 Save the address of the slot.
  $A922,$03 Fetch the type of the object.
  $A925,$01 Is it #N($FF), which is free?
  $A926,$03 Jump to #R$A97B if so.
  $A929,$03 Fetch the state of the object.
  $A92C,$02,b$01 Keep the bottom four bits.
  $A92E,$05 Jump to #R$A97B if the state is #N($0B).
  $A933,$07 Jump to #R$A97B if the object is not on the screen.
  $A93A,$03 Fetch the vertical position of the object on the screen.
  $A93D,$05 Jump to #R$A97B if it is too far up.
  $A942,$01 Store it in #REGh.
  $A943,$03 Fetch the horizontal position of the object on the screen.
  $A946,$05 Jump to #R$A97B if it is too far to the left.
  $A94B,$05 Jump to #R$A97B if it is too far to the right.
  $A950,$01 Store it in #REGl.
  $A951,$03 Store the position of the object as the first box.
  $A954,$03 Find the sprite of the object.
  $A957,$01 Fetch the width of the sprite in bytes.
  $A958,$01 Multiply it by eight to get the width in pixels.
  $A959,$01 Double #REGa.
  $A95A,$01 Double #REGa.
  $A95B,$03 Store it as the width of the first box.
  $A95E,$01 Move on to the height.
  $A95F,$01 Fetch the height of the sprite.
  $A960,$03 Store it as the height of the first box.
  $A963,$03 Fetch the position of the ship.
  $A966,$04 Fetch the size of the ship.
  $A96A,$04 Save the address of the slot.
  $A96E,$04 Use the first box.
  $A972,$03 Test whether the boxes overlap.
  $A975,$03 Fetch the result.
  $A978,$03 Jump to #R$A988 if they do.
@ $A97B label=CheckMapObjectCollisions_Next
  $A97B,$02 Restore the address of the slot.
  $A97D,$03 Move on to the next slot...
  $A980,$02 #REGix gains #REGbc.
  $A982,$01 Restore the slot counter.
  $A983,$01 Decrease the slot counter.
  $A984,$03 Jump back to #R$A91F for each slot.
  $A987,$01 Return.
N $A988 The ship has touched an object.
@ $A988 label=CheckMapObjectCollisions_Hit
  $A988,$04 Fetch the address of the slot.
  $A98C,$03 Fetch the type of the object.
  $A98F,$04 Jump to #R$A9C4 unless it is type #N($1B).
  $A993,$03 Fetch the state of the object.
  $A996,$02,b$01 Keep the bottom four bits.
  $A998,$04 Jump to #R$A9A0 if the state is four.
  $A99C,$04 Jump to #R$A9C4 unless the state is five.
@ $A9A0 label=CheckMapObjectCollisions_Refuel
  $A9A0,$03 Use the value for a full fuel gauge.
  $A9A3,$03 Fill the fuel gauge.
  $A9A6,$04 Mark the object to be removed.
  $A9AA,$03 Fetch the position of the object in the map table.
  $A9AD,$02,b$01 Keep the bits of #REGa that are set in #N$01.
  $A9AF,$01 #REGh=#REGa.
  $A9B0,$03 Read offset #N$19 of #REGiy into #REGl.
  $A9B3,$03 The map table.
  $A9B6,$01 #REGhl gains #REGde.
  $A9B7,$02 Mark the entry in the map table as destroyed.
  $A9B9,$02 #REGa=#N$FF.
  $A9BB,$03 The damage counter.
  $A9BE,$03 Flash the ship.
  $A9C1,$03 Jump to #R$A9FD.
N $A9C4 Any other object makes the ship bounce, if it is to the left or right
. of the ship or above or below it.
@ $A9C4 label=CheckMapObjectCollisions_Bounce
  $A9C4,$02 Set the flag for the ship bouncing.
  $A9C6,$03 Update the collision kind.
  $A9C9,$03 Fetch the left edge of the box of the object.
  $A9CC,$05 Bounce horizontally if it is #N($8B) or more.
  $A9D1,$03 Fetch the left edge of the box of the object.
  $A9D4,$03 Add its width to get the right edge.
  $A9D7,$05 Bounce horizontally if it is less than #N($65).
  $A9DC,$03 Fetch the vertical position of the ship.
  $A9DF,$01 Store it in #REGh.
  $A9E0,$01 Subtract the height of the ship...
  $A9E1,$01 ...and add one to get the top of the ship.
  $A9E2,$06 Bounce vertically if the top of the ship is not above the object.
  $A9E8,$03 Fetch the vertical scroll speed.
  $A9EB,$02 Negate it.
  $A9ED,$04 Jump to #R$A9FD if it is negative.
  $A9F1,$03 Fetch the bottom edge of the box of the object.
  $A9F4,$03 Subtract its height.
  $A9F7,$02 Add nine.
  $A9F9,$04 Bounce vertically if that is not above the bottom of the ship.
@ $A9FD label=CheckMapObjectCollisions_Done
  $A9FD,$02 Restore the address of the slot.
  $A9FF,$01 Restore the slot counter.
  $AA00,$01 Return.

c $AA01 Bounce Horizontally
@ $AA01 label=BounceHorizontally
D $AA01 Makes the ship rebound after hitting something to its left or right:
. the horizontal speed of the ship is reversed and halved by #R$AA27, and the
. horizontal scroll speed is negated.
  $AA01,$01 Stash #REGhl on the stack.
  $AA02,$03 Fetch the word at #N$C8EC into #REGhl.
  $AA05,$03 Call #R$AA27.
  $AA08,$03 Update the high byte of the ship's horizontal speed.
  $AA0B,$01 Bring #REGhl back off the stack.
  $AA0C,$03 The horizontal scroll speed.
  $AA0F,$02 Negate #REGa.
  $AA11,$03 Update the horizontal scroll speed.
  $AA14,$01 Return.

c $AA15 Bounce Vertically
@ $AA15 label=BounceVertically
D $AA15 Makes the ship rebound after hitting something above or below it: the
. vertical speed of the ship is reversed and halved by #R$AA27.
  $AA15,$01 Stash #REGhl on the stack.
  $AA16,$03 Fetch the word at #N$C8EE into #REGhl.
  $AA19,$03 Call #R$AA27.
  $AA1C,$03 Update the high byte of the ship's vertical speed.
  $AA1F,$01 #REGa=#REGh.
  $AA20,$01 #REGh=#REGl.
  $AA21,$01 #REGl=#REGa.
  $AA22,$03 Call #R$B2D5.
  $AA25,$01 Bring #REGhl back off the stack.
  $AA26,$01 Return.

c $AA27 Reverse And Halve Speed
@ $AA27 label=ReverseAndHalveSpeed
D $AA27 Used to make the ship rebound. The bytes of the speed are swapped
. into #REGhl, the speed is negated and halved, a speed that is close to zero
. is set to zero, and the bytes are swapped back.
R $AA27 HL Speed
R $AA27 O:HL New speed
  $AA27,$01 #REGa=#REGh.
  $AA28,$01 #REGh=#REGl.
  $AA29,$01 #REGl=#REGa.
  $AA2A,$03 Call #R$BE08.
  $AA2D,$03 Call #R$BE03.
  $AA30,$03 Call #R$BA0B.
  $AA33,$01 #REGa=#REGh.
  $AA34,$01 #REGh=#REGl.
  $AA35,$01 #REGl=#REGa.
  $AA36,$01 Return.

c $AA37 Build Carried Item Graphic
@ $AA37 label=BuildCarriedItemGraphic
D $AA37 Builds the graphic of the item that is carried by the ship in the
. buffer at #R$F6BA (six bytes to a row) and clears the part of the
. screen beside the ship where the item will be drawn. Each byte of the
. sprite of the item is looked up in the shift table at #R$FC00 and combined
. with the buffer using XOR.
E $AA37 Continue on to #R$AA94.
  $AA37,$03 The sprite tables.
  $AA3A,$03 The item the ship is about to pick up.
  $AA3D,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $AA3F,$01 #REGc=#REGa.
  $AA40,$03 Call #R$A1AA.
  $AA43,$01 Swap #REGde and #REGhl.
  $AA44,$01 Read #REGde.
  $AA45,$01 #REGb=#REGa.
  $AA46,$03 The width of the carried item.
  $AA49,$01 Advance #REGde.
  $AA4A,$01 Read #REGde.
  $AA4B,$03 Update the segments still to draw.
  $AA4E,$01 #REGc=#REGa.
  $AA4F,$03 The carried picture in the ship work area.
@ $AA52 label=BuildCarriedItemGraphic_Row
  $AA52,$01 Stash #REGhl on the stack.
@ $AA53 label=BuildCarriedItemGraphic_Column
  $AA53,$01 Stash #REGbc on the stack.
  $AA54,$02 #REGb=#N$FC.
  $AA56,$01 Advance #REGde.
  $AA57,$01 Read #REGde.
  $AA58,$01 #REGc=#REGa.
  $AA59,$01 Read #REGbc.
  $AA5A,$01 Flip the bits of #REGa that are set in the byte at #REGhl.
  $AA5B,$01 Write #REGa where #REGhl points.
  $AA5C,$01 Advance #REGb.
  $AA5D,$01 Advance #REGhl.
  $AA5E,$01 Read #REGbc.
  $AA5F,$01 Flip the bits of #REGa that are set in the byte at #REGhl.
  $AA60,$01 Write #REGa where #REGhl points.
  $AA61,$01 Bring #REGbc back off the stack.
  $AA62,$02 Decrease #REGb and jump to #R$AA53 until none remain.
  $AA64,$01 Bring #REGhl back off the stack.
  $AA65,$03 The width of the carried item.
  $AA68,$01 #REGb=#REGa.
  $AA69,$02 #REGa=#N$06.
  $AA6B,$03 Call #R$9BCF.
  $AA6E,$01 Step #REGc back.
  $AA6F,$02 Jump to #R$AA52 if the zero flag is clear.
  $AA71,$03 Fetch the word at #N$C902 into #REGhl.
  $AA74,$03 Call #R$A149.
  $AA77,$03 The segments still to draw.
  $AA7A,$01 #REGb=#REGa.
  $AA7B,$01 Advance #REGl.
@ $AA7C label=BuildCarriedItemGraphic_Clear
  $AA7C,$02 Store #N$00 at the address in #REGhl.
  $AA7E,$01 Advance #REGl.
  $AA7F,$02 Store #N$00 at the address in #REGhl.
  $AA81,$01 Advance #REGl.
  $AA82,$02 Store #N$00 at the address in #REGhl.
  $AA84,$01 Advance #REGl.
  $AA85,$02 Store #N$00 at the address in #REGhl.
  $AA87,$01 Step #REGl back.
  $AA88,$01 Step #REGl back.
  $AA89,$01 Step #REGl back.
  $AA8A,$03 Call #R$A1C3.
  $AA8D,$02 Decrease #REGb and jump to #R$AA7C until none remain.
  $AA8F,$03 The scroll-in flag.
  $AA92,$02 Return if #REGa is not zero.

c $AA94 Attach Item To Ship
@ $AA94 label=AttachItemToShip
D $AA94 Makes the ship taller by the height of the item that it carries, and
. adjusts its position, according to whether bit 6 of the item at #N$C904
. says that the item is carried above the ship or below it. Then the ship is
. drawn.
  $AA94,$03 The item the ship is about to pick up.
  $AA97,$01 #REGb=#REGa.
  $AA98,$03 The height of the ship.
  $AA9B,$01 #REGc=#REGa.
  $AA9C,$04 Store #N$08 at offset #N$09 of #REGix.
  $AAA0,$02 #REGe=#N$03.
  $AAA2,$03 The ship work area.
  $AAA5,$02 #REGa=#N$05.
  $AAA7,$04 Jump to #R$AAB6 if bit 6 of #REGb is set.
  $AAAB,$03 The right-hand picture in the ship work area.
  $AAAE,$02 #REGe=#N$FD.
  $AAB0,$02 Negate #REGa.
  $AAB2,$04 Store #N$F8 at offset #N$09 of #REGix.
@ $AAB6 label=AttachItemToShip_Store
  $AAB6,$03 Update the ship buffer address.
  $AAB9,$01 #REGa gains #REGc.
  $AABA,$03 Update the height of the ship.
  $AABD,$03 The ship row.
  $AAC0,$01 #REGa gains #REGe.
  $AAC1,$03 Update the ship row.
  $AAC4,$03 Read offset #N$09 of #REGix.
  $AAC7,$03 Add the byte at offset #N$1E of #REGix to #REGa.
  $AACA,$03 Write #REGa to offset #N$1E of #REGix.
  $AACD,$04 Store #N$00 at offset #N$07 of #REGix.
  $AAD1,$03 Call #R$BF66.
  $AAD4,$03 Jump to #R$B9EC.

c $AAD7 Check Item Pickup
@ $AAD7 label=CheckItemPickup
D $AAD7 Checks whether the ship can pick up an object. A type #N($1E) object
. can only be picked up when its item number is the one that is wanted at
. #R$F602; objects with an item number of #N($0A) can never be picked up.
. #R$AB03 does the pick up if the ship is touching the object.
R $AAD7 IX Address of the object
  $AAD7,$03 The type.
  $AADA,$04 Jump to #R$AAF2 if #REGa is not #N$1E.
  $AADE,$03 The first part flag.
  $AAE1,$02 Return if #REGa is zero.
  $AAE3,$03 The state.
  $AAE6,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $AAE8,$01 #REGb=#REGa.
  $AAE9,$03 The crystal count.
  $AAEC,$02 Return if #REGa is not #REGb.
  $AAEE,$04 Store #N$FA at offset #N$0D of #REGix.
@ $AAF2 label=CheckItemPickup_Kind
  $AAF2,$03 The state.
  $AAF5,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $AAF7,$03 Return if #REGa is #N$0A.
  $AAFA,$04 Jump to #R$AB03 if #REGa is not #N$09.
  $AAFE,$03 The ninth part flag.
  $AB01,$02 Return if #REGa is zero.
N $AB03 Test whether the ship is touching the object, and give up if the
. object is not on the screen.
@ $AB03 label=CheckItemPickup_Touch
  $AB03,$03 The rows of the first sprite.
  $AB06,$02 Return if #REGa is zero.
  $AB08,$03 The height of the collision box.
  $AB0B,$03 Fetch the word at #R$A1D3 into #REGhl.
  $AB0E,$01 #REGa=#REGh.
  $AB0F,$03 Return if #REGa is less than #N$28.
  $AB12,$01 #REGa=#REGl.
  $AB13,$03 Return if #REGa is less than #N$30.
  $AB16,$03 Return if #REGa is #N$90 or more.
  $AB19,$03 Update the collision box.
  $AB1C,$03 The sprite width in bytes.
  $AB1F,$01 Double #REGa.
  $AB20,$01 Double #REGa.
  $AB21,$01 Double #REGa.
  $AB22,$03 The width of the collision box.
  $AB25,$03 Fetch the word at #N$C902 into #REGhl.
  $AB28,$02 #REGl=#N$70.
  $AB2A,$02 #REGd=#N$10.
  $AB2C,$03 The height of the ship.
  $AB2F,$02 Subtract #N$0A from #REGa.
  $AB31,$01 #REGe=#REGa.
N $AB32 Test the box of the object against a box around the ship.
  $AB32,$03 Call #R$AB98.
  $AB35,$03 The hit flag.
  $AB38,$02 Return if #REGa is zero.
N $AB3A The ship has picked the object up: play a sound, score #N(1000) points,
. then record the item that is now carried.
  $AB3A,$03 Call #R$71FE.
  $AB3D,$03 #REGbc=#N$1000.
  $AB40,$03 Call #R$925E.
  $AB43,$03 The type.
  $AB46,$04 Jump to #R$AB5E if #REGa is not #N$1E.
  $AB4A,$03 The state.
  $AB4D,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $AB4F,$02,b$01 Set the bits of #REGa that are set in #N$C0.
  $AB51,$03 Update the item the ship is about to pick up.
  $AB54,$03 The twelfth item site.
  $AB57,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $AB59,$03 Update the carried item.
  $AB5C,$02 Jump to #R$AB69.
N $AB5E The object is not type #N($1E): the item is recorded in the table of
. item sites at #R$F604 and the carried item at #N$C904 is set to its number.
@ $AB5E label=CheckItemPickup_Site
  $AB5E,$03 The state.
  $AB61,$01 Advance #REGa.
  $AB62,$03 Update the item the ship is about to pick up.
  $AB65,$01 Step #REGa back.
  $AB66,$03 The item sites.
N $AB69 Set bit 7 of the record for the item, remove the object from the
. screen and free its slot.
@ $AB69 label=CheckItemPickup_Record
  $AB69,$01 Double #REGa.
  $AB6A,$01 Double #REGa.
  $AB6B,$03 Call #R$9BCF.
  $AB6E,$02 Set bit 7 of the byte at the address in #REGhl.
  $AB70,$04 Set bit 4 of offset #N$10 of #REGix.
  $AB74,$04 Store #N$FF at offset #N$00 of #REGix.
  $AB78,$03 The state.
  $AB7B,$03 Return if #REGa is not #N$09.
N $AB7E Item number #N($09) is special.
@ $AB7E label=CheckItemPickup_Special
  $AB7E,$01 Clear #REGa.
  $AB7F,$03 Update the item the ship is about to pick up.
  $AB82,$03 The pieces beside the ship are cleared.
  $AB85,$02 #REGa=#N$09.
  $AB87,$03 Update the flag set when item #N($09) has been picked up.
  $AB8A,$03 Bit 4 of the sixth map object's flags.
  $AB8D,$02,b$01 Set the bits of #REGa that are set in #N$10.
  $AB8F,$03 Bit 4 of the sixth map object's flags.
  $AB92,$03 The eleventh item site.
  $AB95,$02 Set bit 7 of the byte at the address in #REGhl.
  $AB97,$01 Return.

c $AB98 Test Box Against Ship
@ $AB98 label=TestBoxAgainstShip
D $AB98 Tests the box at #R$ABA4 against the box in #REGhl and #REGde.
R $AB98 HL Position of the second box
R $AB98 D Width of the second box
R $AB98 E Height of the second box
R $AB98 O:$5C1C Non-zero if the boxes overlap
  $AB98,$02 Stash #REGix on the stack.
  $AB9A,$04 The collision box.
  $AB9E,$03 Call #R$9DB1.
  $ABA1,$02 Bring #REGix back off the stack.
  $ABA3,$01 Return.

g $ABA4 Collision Box
@ $ABA4 label=CollisionBox
D $ABA4 The box of the object that is being tested for a collision: horizontal
. position, vertical position, width in pixels and height in pixels.
B $ABA4,$04,$04

c $ABA8 Check Object Hit By Shot
@ $ABA8 label=CheckObjectHitByShot
D $ABA8 Checks whether the object that was drawn has been shot, and if it has
. been destroyed, marks its entry in the map table as destroyed.
R $ABA8 IX Address of the object
  $ABA8,$05 Return if bit 7 of offset #N$03 of #REGix is set.
  $ABAD,$03 The special-shot flag.
  $ABB0,$02 Return if #REGa is zero.
  $ABB2,$05 Return if bit 7 of offset #N$10 of #REGix is clear.
  $ABB7,$05 Return if bit 3 of offset #N$17 of #REGix is set.
  $ABBC,$03 The state.
  $ABBF,$03 Return if #REGa is #N$0B.
  $ABC2,$03 Call #R$9143.
  $ABC5,$03 Call #R$B870.
  $ABC8,$03 Call #R$AC29.
  $ABCB,$05 Return if bit 3 of offset #N$17 of #REGix is clear.
  $ABD0,$03 Read offset #N$18 of #REGix.
  $ABD3,$02,b$01 Keep the bits of #REGa that are set in #N$01.
  $ABD5,$01 #REGh=#REGa.
  $ABD6,$03 Read offset #N$19 of #REGix into #REGl.
  $ABD9,$03 The map table.
  $ABDC,$01 #REGhl gains #REGde.
  $ABDD,$02 Set bit 7 of the byte at the address in #REGhl.
  $ABDF,$03 The type.
  $ABE2,$03 Return if #REGa is not #N$0D.
  $ABE5,$03 The state.
  $ABE8,$04 Jump to #R$ABF3 if #REGa is less than #N$08.
  $ABEC,$03 Return if #REGa is #N$0B or more.
  $ABEF,$03 Write the state.
  $ABF2,$01 Return.

c $ABF3 Mark Cell Destroyed
@ $ABF3 label=MarkCellDestroyed
D $ABF3 Sets the bit for the map cell of an object in the bitmap at #R$F5EA
. (found by #R$AC08), unless the item number in #REGa is below #N($06). The
. bit number is written straight into the operand of the SET instruction at
. #R$AC05, so this routine modifies its own code.
R $ABF3 A Item number of the object
R $ABF3 IX Address of the object
  $ABF3,$03 Return if #REGa is less than #N$06.
  $ABF6,$03 The map column.
  $ABF9,$03 The map zone.
  $ABFC,$03 Call #R$AC08.
  $ABFF,$01 #REGa=#REGb.
  $AC00,$02 Add #N$C6 to #REGa.
  $AC02,$03 The bit of the map cell.
  $AC05,$02 Set bit 0 of the byte at the address in #REGhl.
  $AC07,$01 Return.

c $AC08 Find Cell Bit
@ $AC08 label=FindCellBit
D $AC08 Finds the byte of the bitmap at #R$F5EA and the bit within it for a
. cell of the planet. Each of the three bytes of the bitmap holds the bits for
. four zones of the map, and each zone has two bits: one for the left half and
. one for the right half.
R $AC08 D Map zone
R $AC08 E Horizontal position
R $AC08 O:HL Address of the byte
R $AC08 O:B The bit number multiplied by eight
  $AC08,$03 The current player's map cells.
  $AC0B,$01 #REGa=#REGd.
  $AC0C,$02 Subtract #N$01 from #REGa.
  $AC0E,$01 #REGd=#REGa.
  $AC0F,$02,b$01 Keep the bits of #REGa that are set in #N$0C.
  $AC11,$02 Shift #REGa right.
  $AC13,$02 Shift #REGa right.
  $AC15,$03 Call #R$9BCF.
  $AC18,$01 #REGa=#REGd.
  $AC19,$02,b$01 Keep the bits of #REGa that are set in #N$03.
  $AC1B,$01 Double #REGa.
  $AC1C,$01 Double #REGa.
  $AC1D,$01 Double #REGa.
  $AC1E,$01 Double #REGa.
  $AC1F,$01 #REGb=#REGa.
  $AC20,$01 #REGa=#REGe.
  $AC21,$03 Return if #REGa is less than #N$30.
  $AC24,$01 #REGa=#REGb.
  $AC25,$02 Add #N$08 to #REGa.
  $AC27,$01 #REGb=#REGa.
  $AC28,$01 Return.

c $AC29 Check Object Against Shots
@ $AC29 label=CheckObjectAgainstShots
D $AC29 Tests the box at #R$ABA4 against the four objects at #R$B37A by
. entering #R$917C at #R$918B with a count of one.
  $AC29,$02 Stash #REGix on the stack.
  $AC2B,$04 The collision box.
  $AC2F,$02 #REGa=#N$01.
  $AC31,$03 Jump to #R$918B.

c $AC34 Free Object Slot
@ $AC34 label=FreeObjectSlot
D $AC34 Clears the fields of an object slot to zero, then marks the slot as
. free by setting its type to #N($FF).
R $AC34 IX Address of the slot
  $AC34,$03 Call #R$B8FC.
  $AC37,$03 Write #REGa to offset #N$07 of #REGix.
  $AC3A,$03 Write #REGa to offset #N$08 of #REGix.
  $AC3D,$03 Write #REGa to offset #N$09 of #REGix.
  $AC40,$03 Write #REGa to offset #N$0A of #REGix.
  $AC43,$03 Write #REGa to offset #N$10 of #REGix.
  $AC46,$03 Write #REGa to offset #N$11 of #REGix.
  $AC49,$03 Write #REGa to offset #N$12 of #REGix.
  $AC4C,$03 Write #REGa to offset #N$13 of #REGix.
  $AC4F,$03 Write #REGa to offset #N$14 of #REGix.
  $AC52,$03 Write #REGa to offset #N$15 of #REGix.
  $AC55,$03 Write #REGa to offset #N$16 of #REGix.
  $AC58,$03 Write #REGa to offset #N$17 of #REGix.
  $AC5B,$04 Store #N$FF at offset #N$00 of #REGix.
  $AC5F,$01 Return.

c $AC60 Update Map Objects
@ $AC60 label=UpdateMapObjects
D $AC60 Runs once a frame to look after the six map objects in the slots at
. #R$A80B. For each used slot it erases the old sprite, removes the object if
. it is flagged for removal or lets it move and draws it in its new place,
. sets the attributes under it, and checks whether it has been shot.
  $AC60,$03 The scroll-in flag.
  $AC63,$04 Call #R$9572 if #REGa is zero.
  $AC67,$04 The map object slots.
  $AC6B,$02 #REGb=#N$06.
@ $AC6D label=UpdateMapObjects_Loop
  $AC6D,$01 Stash #REGbc on the stack.
  $AC6E,$02 Stash #REGix on the stack.
  $AC70,$03 Read offset #N$00 of #REGix.
  $AC73,$04 Jump to #R$ACD2 if #REGa is #N$FF.
  $AC77,$06 Jump to #R$AC8A if bit 7 of offset #N$03 of #REGix is set.
  $AC7D,$03 Read offset #N$18 of #REGix.
  $AC80,$02,b$01 Keep the bits of #REGa that are set in #N$0E.
  $AC82,$02 Shift #REGa right.
  $AC84,$03 The bits that fire a shot from the object.
  $AC87,$03 Call #R$8820 if the zero flag is clear.
@ $AC8A label=UpdateMapObjects_Next2
  $AC8A,$03 Call #R$A2EA.
  $AC8D,$07 Call #R$AD27 if bit 7 of offset #N$10 of #REGix is set.
  $AC94,$04 Reset bit 6 of offset #N$10 of #REGix.
  $AC98,$01 Switch to the alternate registers.
  $AC99,$07 Call #R$910A if bit 7 of offset #N$15 of #REGix is set.
  $ACA0,$07 Call #R$AAD7 if bit 7 of offset #N$03 of #REGix is set.
  $ACA7,$06 Jump to #R$ACB7 if bit 4 of offset #N$10 of #REGix is clear.
  $ACAD,$04 Store #N$FF at offset #N$00 of #REGix.
  $ACB1,$04 Store #N$00 at offset #N$10 of #REGix.
  $ACB5,$02 Jump to #R$ACBA.
@ $ACB7 label=UpdateMapObjects_Move
  $ACB7,$03 Call #R$AD48.
@ $ACBA label=UpdateMapObjects_Draw
  $ACBA,$03 Call #R$AD1B.
  $ACBD,$04 Fetch the word at #R$AD46 into #REGiy.
  $ACC1,$07 Call #R$ACDD if bit 7 of offset #N$03 of #REGiy is clear.
  $ACC8,$03 Call #R$AE98.
  $ACCB,$04 Fetch the word at #R$AD46 into #REGix.
  $ACCF,$03 Call #R$ABA8.
@ $ACD2 label=UpdateMapObjects_Next
  $ACD2,$02 Bring #REGix back off the stack.
  $ACD4,$03 #REGbc=#N$1A.
  $ACD7,$02 #REGix gains #REGbc.
  $ACD9,$01 Bring #REGbc back off the stack.
  $ACDA,$02 Decrease #REGb and jump to #R$AC6D until none remain.
  $ACDC,$01 Return.

c $ACDD Trim Object Sprite
@ $ACDD label=TrimObjectSprite
D $ACDD Used for the object at #REGiy if it is type #N($1B) or has state zero,
. one, three, ten or twelve. Returns if the bottom three bits of the
. vertical position in #R$A1D6 are all set. Otherwise subtracts seven from
. that position and four from the number of rows in #R$A1D8 (and sets the
. number of rows to zero if the new position is below #N($18)).
  $ACDD,$03 Read offset #N$00 of #REGiy.
  $ACE0,$04 Jump to #R$ACFA if #REGa is #N$1B.
  $ACE4,$03 Read offset #N$13 of #REGiy.
  $ACE7,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $ACE9,$02 Jump to #R$ACFA if the zero flag is set.
  $ACEB,$04 Jump to #R$ACFA if #REGa is #N$01.
  $ACEF,$04 Jump to #R$ACFA if #REGa is #N$03.
  $ACF3,$04 Jump to #R$ACFA if #REGa is #N$0A.
  $ACF7,$03 Return if #REGa is not #N$0C.
@ $ACFA label=TrimObjectSprite_Trim
  $ACFA,$03 The vertical position of the second sprite.
  $ACFD,$02,b$01 Flip the bits of #REGa that are set in #N$07.
  $ACFF,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $AD01,$01 Return if the zero flag is set.
  $AD02,$03 The rows of the second sprite.
  $AD05,$02 Subtract #N$04 from #REGa.
  $AD07,$03 The rows of the second sprite.
  $AD0A,$03 The vertical position of the second sprite.
  $AD0D,$02 Subtract #N$07 from #REGa.
  $AD0F,$04 Jump to #R$AD17 if #REGa is #N$18 or more.
  $AD13,$01 Clear #REGa.
  $AD14,$03 The rows of the second sprite.
@ $AD17 label=TrimObjectSprite_Store
  $AD17,$03 The vertical position of the second sprite.
  $AD1A,$01 Return.

c $AD1B Draw Object
@ $AD1B label=DrawObject
D $AD1B Draws the sprite that was set up for an object by #R$AD48, unless both
. the width in #R$A1D7 and the number of rows in #R$A1D8 are zero.
  $AD1B,$03 The rows of the first sprite.
  $AD1E,$01 #REGc=#REGa.
  $AD1F,$03 The rows of the second sprite.
  $AD22,$01 Set the bits of #REGa that are set in #REGc.
  $AD23,$01 Return if the zero flag is set.
  $AD24,$03 Jump to #R$A303.

c $AD27 Prepare Erase
@ $AD27 label=PrepareErase
D $AD27 Sets up the erasing of the old sprite of an object, from its position
. on the screen at the last frame. Also clears the visible flag of the object
. (bit 7 of offset #N($10)) and keeps the wrap flag (bit 6) in #R$A2FA.
R $AD27 IX Address of the object
  $AD27,$03 Call #R$ADBE.
  $AD2A,$03 The horizontal screen position.
  $AD2D,$03 The vertical screen position.
  $AD30,$03 Update the sprite positions.
  $AD33,$03 Call #R$A1EA.
  $AD36,$03 Call #R$A234.
  $AD39,$04 Reset bit 7 of offset #N$10 of #REGix.
  $AD3D,$03 The flags.
  $AD40,$02,b$01 Keep the bits of #REGa that are set in #N$40.
  $AD42,$03 The wrap flag.
  $AD45,$01 Return.

b $AD46 Current Object
@ $AD46 label=CurrentObject
D $AD46 The address of the object that is being drawn.
W $AD46,$02,$02

c $AD48 Prepare Draw
@ $AD48 label=PrepareDraw
D $AD48 Sets up the drawing of the new sprite of an object. Finds the sprite
. from its type and state, and its position on the screen (which frees the
. slot if it is off screen). If the object is exploding (bit 3 of offset
. #N($17)), the explosion count in the bottom three bits is increased and
. the slot is freed when it reaches eight; the count is also used as the
. dissolve step in #N$A302. The attribute of the sprite is taken from offset
. #N($0D), which holds two colours; the choice between them depends on bit 0
. of the frame counter at #R$9A64.
R $AD48 IX Address of the object
  $AD48,$04 Update the current object.
  $AD4C,$01 Clear #REGa.
  $AD4D,$03 No dissolve yet.
  $AD50,$03 Call #R$ADBE.
  $AD53,$01 Stash #REGde on the stack.
  $AD54,$03 Call #R$ADD8.
  $AD57,$01 Bring #REGde back off the stack.
  $AD58,$06 Jump to #R$AD84 if bit 3 of offset #N$17 of #REGix is clear.
  $AD5E,$03 The second set of flags.
  $AD61,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $AD63,$01 Advance #REGa.
  $AD64,$01 #REGb=#REGa.
  $AD65,$04 Jump to #R$AD73 if #REGa is not #N$08.
  $AD69,$04 Store #N$FF at offset #N$00 of #REGix.
  $AD6D,$04 Reset bit 7 of offset #N$10 of #REGix.
  $AD71,$02 Jump to #R$AD84.
@ $AD73 label=PrepareDraw_Attributes
  $AD73,$03 The second set of flags.
  $AD76,$02,b$01 Keep the bits of #REGa that are set in #N$F0.
  $AD78,$01 Set the bits of #REGa that are set in #REGb.
  $AD79,$02,b$01 Set the bits of #REGa that are set in #N$08.
  $AD7B,$03 Write the second set of flags.
  $AD7E,$01 #REGa=#REGb.
  $AD7F,$02,b$01 Set the bits of #REGa that are set in #N$80.
  $AD81,$03 The dissolve step of the explosion.
@ $AD84 label=PrepareDraw_Colour
  $AD84,$03 The flags.
  $AD87,$03 Update the contact flags.
  $AD8A,$03 Return if bit 7 of #REGa is clear.
  $AD8D,$03 The attribute.
  $AD90,$03 The frame counter.
  $AD93,$02,b$01 Keep the bits of #REGa that are set in #N$01.
  $AD95,$02 Jump to #R$ADA3 if the zero flag is set.
  $AD97,$01 #REGa=#REGc.
  $AD98,$02,b$01 Keep the bits of #REGa that are set in #N$08.
  $AD9A,$01 Double #REGa.
  $AD9B,$01 Double #REGa.
  $AD9C,$01 Double #REGa.
  $AD9D,$01 #REGb=#REGa.
  $AD9E,$01 #REGa=#REGc.
  $AD9F,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $ADA1,$02 Jump to #R$ADB4.
@ $ADA3 label=PrepareDraw_Colour2
  $ADA3,$01 #REGa=#REGc.
  $ADA4,$02,b$01 Keep the bits of #REGa that are set in #N$70.
  $ADA6,$02 Shift #REGa right.
  $ADA8,$02 Shift #REGa right.
  $ADAA,$02 Shift #REGa right.
  $ADAC,$02 Shift #REGa right.
  $ADAE,$01 #REGb=#REGa.
  $ADAF,$01 #REGa=#REGc.
  $ADB0,$02,b$01 Keep the bits of #REGa that are set in #N$80.
  $ADB2,$02 Shift #REGa right.
@ $ADB4 label=PrepareDraw_Attribute
  $ADB4,$01 Set the bits of #REGa that are set in #REGb.
  $ADB5,$03 The attribute of the sprite.
  $ADB8,$03 Call #R$A1D9.
  $ADBB,$03 Jump to #R$A247.

c $ADBE Fetch Frame Sprite
@ $ADBE label=FetchFrameSprite
D $ADBE Finds the address of the sprite for the state of an object. The type
. is used as an index into the table at #R$AF3D, which gives the address of a
. table of sprites for the type; the bottom four bits of offset #N($13) are
. the index into that table.
R $ADBE IX Address of the object
R $ADBE O:DE Address of the sprite
  $ADBE,$03 The type.
  $ADC1,$02 Clear #REGb.
  $ADC3,$03 The frame table addresses.
  $ADC6,$01 #REGhl gains #REGbc.
  $ADC7,$01 #REGhl gains #REGbc.
  $ADC8,$01 Read #REGhl.
  $ADC9,$01 Advance #REGhl.
  $ADCA,$01 Read #REGhl into #REGh.
  $ADCB,$01 #REGl=#REGa.
  $ADCC,$03 The state.
  $ADCF,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $ADD1,$01 #REGc=#REGa.
  $ADD2,$01 #REGhl gains #REGbc.
  $ADD3,$01 #REGhl gains #REGbc.
  $ADD4,$01 Read #REGhl into #REGe.
  $ADD5,$01 Advance #REGhl.
  $ADD6,$01 Read #REGhl into #REGd.
  $ADD7,$01 Return.

c $ADD8 Find Object Screen Position
@ $ADD8 label=FindObjectScreenPosition
D $ADD8 Works out where an object is on the screen from its position on the
. planet and the position of the part of the planet that is on the screen. If
. the object is off the screen, its slot is freed. Otherwise the horizontal
. and vertical screen positions are stored at offsets #N($11) and #N($12), and
. the object is flagged as visible with bit 7 of offset #N($10). The wrap
. flag (bit 6 of offset #N($10)) is set if the object has crossed the edge of
. the part of the planet that is on the screen.
R $ADD8 DE Address of the sprite
R $ADD8 IX Address of the object
  $ADD8,$01 Read #REGde.
  $ADD9,$01 Double #REGa.
  $ADDA,$01 Double #REGa.
  $ADDB,$01 Double #REGa.
  $ADDC,$01 #REGb=#REGa.
  $ADDD,$01 Advance #REGde.
  $ADDE,$01 Read #REGde.
  $ADDF,$01 #REGc=#REGa.
  $ADE0,$03 The position across.
  $ADE3,$01 #REGe=#REGa.
  $ADE4,$03 The horizontal position.
  $ADE7,$02,b$01 Keep the bits of #REGa that are set in #N$FE.
  $ADE9,$01 #REGl=#REGa.
  $ADEA,$03 The next column.
  $ADED,$06 Jump to #R$AE56 if #REGa is the byte at offset #N$01 of #REGix.
  $ADF3,$03 The map position.
  $ADF6,$05 Jump to #R$AE19 if #REGa is the byte at offset #N$01 of #REGix.
  $ADFB,$03 The rows of the sprite that was drawn.
  $ADFE,$04 Jump to #R$AE93 if #REGa is zero.
  $AE02,$01 #REGa=#REGl.
  $AE03,$02 Add #N$17 to #REGa.
  $AE05,$01 #REGa gains #REGb.
  $AE06,$03 Jump to #R$AE93 if the carry flag is clear.
  $AE09,$03 The horizontal position.
  $AE0C,$05 Jump to #R$AE93 if #REGa is less than #N$80.
  $AE11,$01 #REGa=#REGe.
  $AE12,$02 Add #N$B0 to #REGa.
  $AE14,$01 #REGe=#REGa.
  $AE15,$01 #REGa=#REGl.
  $AE16,$02 Subtract #N$30 from #REGa.
  $AE18,$01 #REGl=#REGa.
@ $AE19 label=FindObjectScreenPosition_Wrap
  $AE19,$01 #REGa=#REGl.
  $AE1A,$03 Jump to #R$AE32 if #REGa is #REGe or more.
  $AE1D,$01 #REGa gains #REGb.
  $AE1E,$02 Jump to #R$AE23 if the carry flag is set.
  $AE20,$01 Step #REGa back.
  $AE21,$02 Return if #REGa is less than #REGe.
@ $AE23 label=FindObjectScreenPosition_Row
  $AE23,$01 #REGa=#REGe.
  $AE24,$01 Subtract #REGl from #REGa.
  $AE25,$02 Subtract #N$09 from #REGa.
  $AE27,$02 Jump to #R$AE32 if the carry flag is set.
  $AE29,$04 Set bit 6 of offset #N$10 of #REGix.
  $AE2D,$02 #REGa=#N$01.
  $AE2F,$03 The sprite reaches past the right of the screen.
@ $AE32 label=FindObjectScreenPosition_Horizontal
  $AE32,$03 The map position.
  $AE35,$05 Jump to #R$AE49 if #REGa is the byte at offset #N$01 of #REGix.
  $AE3A,$03 The next column.
  $AE3D,$05 Jump to #R$AE49 if #REGa is the byte at offset #N$01 of #REGix.
  $AE42,$01 #REGa=#REGl.
  $AE43,$01 Subtract #REGe from #REGa.
  $AE44,$02 Add #N$08 to #REGa.
  $AE46,$01 #REGl=#REGa.
  $AE47,$02 Jump to #R$AE4D.
@ $AE49 label=FindObjectScreenPosition_Same
  $AE49,$03 The horizontal offset.
  $AE4C,$01 #REGa gains #REGl.
@ $AE4D label=FindObjectScreenPosition_StoreX
  $AE4D,$03 The horizontal screen position.
  $AE50,$03 Write the horizontal screen position.
  $AE53,$03 Jump to #R$AE5E.
@ $AE56 label=FindObjectScreenPosition_Edge
  $AE56,$01 #REGa=#REGl.
  $AE57,$02 Return if #REGa is #REGe or more.
  $AE59,$02 Add #N$E0 to #REGa.
  $AE5B,$01 #REGl=#REGa.
  $AE5C,$02 Jump to #R$AE32.
@ $AE5E label=FindObjectScreenPosition_Vertical
  $AE5E,$03 The vertical position.
  $AE61,$03 The position down.
  $AE64,$01 #REGe=#REGa.
  $AE65,$03 The map row.
  $AE68,$05 Jump to #R$AE83 if #REGa is not the byte at offset #N$04 of
. #REGix.
  $AE6D,$01 #REGa=#REGl.
  $AE6E,$01 Step #REGa back.
  $AE6F,$02 Return if #REGa is less than #REGe.
  $AE71,$02 Add #N$61 to #REGa.
  $AE73,$01 #REGl=#REGa.
@ $AE74 label=FindObjectScreenPosition_StoreY
  $AE74,$03 The vertical offset.
  $AE77,$01 #REGa gains #REGl.
  $AE78,$03 The vertical screen position.
  $AE7B,$03 Write the vertical screen position.
  $AE7E,$04 Set bit 7 of offset #N$10 of #REGix.
  $AE82,$01 Return.
@ $AE83 label=FindObjectScreenPosition_NextZone
  $AE83,$01 Advance #REGa.
  $AE84,$06 Jump to #R$AE93 if #REGa is not the byte at offset #N$04 of
. #REGix.
  $AE8A,$01 #REGa=#REGl.
  $AE8B,$01 Subtract #REGc from #REGa.
  $AE8C,$02 Jump to #R$AE74 if the carry flag is set.
  $AE8E,$02 Return if #REGa is #REGe or more.
  $AE90,$03 Jump to #R$AE74.
@ $AE93 label=FindObjectScreenPosition_Free
  $AE93,$04 Store #N$FF at offset #N$00 of #REGix.
  $AE97,$01 Return.

c $AE98 Set Object Attributes
@ $AE98 label=SetObjectAttributes
D $AE98 Works out the area of attribute cells that is covered by the sprite
. that has just been drawn, as a width and height in cells, and fills it with
. the attribute at #R$AF03 by calling #R$C991.
  $AE98,$03 The rows of the sprite.
  $AE9B,$01 Step #REGa back.
  $AE9C,$01 Return if the sign flag is set.
  $AE9D,$01 #REGd=#REGa.
  $AE9E,$03 Fetch the word at #R$A1D5 into #REGhl.
  $AEA1,$03 The width of the sprite in bytes.
  $AEA4,$01 #REGb=#REGa.
  $AEA5,$03 The sprite reaches past the right of the screen.
  $AEA8,$03 Jump to #R$AEB3 if #REGa is zero.
  $AEAB,$01 #REGa=#REGl.
  $AEAC,$01 #REGa gains #REGb.
  $AEAD,$02 Subtract #N$A4 from #REGa.
  $AEAF,$02 #REGl=#N$08.
  $AEB1,$02 Jump to #R$AED6.
@ $AEB3 label=SetObjectAttributes_Width
  $AEB3,$01 #REGa=#REGl.
  $AEB4,$04 Jump to #R$AEBF if #REGa is #N$08 or more.
  $AEB8,$02 Add #N$08 to #REGa.
  $AEBA,$01 #REGl=#REGa.
  $AEBB,$01 #REGa=#REGb.
  $AEBC,$02 Subtract #N$08 from #REGa.
  $AEBE,$01 #REGb=#REGa.
@ $AEBF label=SetObjectAttributes_Right
  $AEBF,$01 #REGa=#REGl.
  $AEC0,$02 Add #N$17 to #REGa.
  $AEC2,$01 #REGa gains #REGb.
  $AEC3,$02 Jump to #R$AECA if the carry flag is clear.
  $AEC5,$02 #REGa=#N$EE.
  $AEC7,$01 Subtract #REGl from #REGa.
  $AEC8,$02 Jump to #R$AED6.
@ $AECA label=SetObjectAttributes_Aligned
  $AECA,$01 #REGa=#REGl.
  $AECB,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $AECD,$02 Jump to #R$AED3 if the zero flag is set.
  $AECF,$01 #REGa=#REGb.
  $AED0,$02 Add #N$08 to #REGa.
  $AED2,$01 #REGb=#REGa.
@ $AED3 label=SetObjectAttributes_Sum
  $AED3,$01 #REGa=#REGl.
  $AED4,$01 #REGa gains #REGb.
  $AED5,$01 Subtract #REGl from #REGa.
@ $AED6 label=SetObjectAttributes_Cells
  $AED6,$02 Shift #REGa right.
  $AED8,$02 Shift #REGa right.
  $AEDA,$02 Shift #REGa right.
  $AEDC,$03 Update the attribute area.
  $AEDF,$01 Step #REGa back.
  $AEE0,$01 Return if the sign flag is set.
@ $AEE1 label=SetObjectAttributes_Height
  $AEE1,$01 #REGa=#REGh.
  $AEE2,$01 Subtract #REGd from #REGa.
  $AEE3,$02 Subtract #N$07 from #REGa.
  $AEE5,$01 #REGe=#REGa.
  $AEE6,$04 Jump to #R$AEEC if #REGa is #N$17 or more.
  $AEEA,$02 #REGe=#N$17.
@ $AEEC label=SetObjectAttributes_Rows
  $AEEC,$01 #REGa=#REGh.
  $AEED,$02,b$01 Set the bits of #REGa that are set in #N$07.
  $AEEF,$01 Subtract #REGe from #REGa.
  $AEF0,$02 Shift #REGa right.
  $AEF2,$02 Shift #REGa right.
  $AEF4,$02 Shift #REGa right.
  $AEF6,$03 The height of the attribute area.
  $AEF9,$01 Step #REGa back.
  $AEFA,$01 Return if the sign flag is set.
  $AEFB,$03 The attribute area.
  $AEFE,$03 Jump to #R$C991.

g $AF01 Attribute Area
@ $AF01 label=AttributeArea
D $AF01 The width in cells, the height in cells and the attribute of the area
. to fill, as used by #R$C991.
B $AF01,$03,$01

c $AF04 Set Pair Attributes
@ $AF04 label=SetPairAttributes
D $AF04 Sets the attributes of the two sprites at #R$C27B and #R$C27D (which
. are #N5 and #N3 cells wide) to bright white, by filling the area under each
. one in the same way as #R$AE98.
  $AF04,$02 #REGa=#N$47.
  $AF06,$03 The pieces are bright white.
  $AF09,$03 Fetch the word at #R$C27B into #REGhl.
  $AF0C,$02 #REGb=#N$23.
  $AF0E,$02 #REGa=#N$05.
  $AF10,$03 Call #R$AF1A.
  $AF13,$03 Fetch the word at #R$C27D into #REGhl.
  $AF16,$02 #REGb=#N$2F.
  $AF18,$02 #REGa=#N$03.
@ $AF1A label=SetPairAttributes_Second
  $AF1A,$03 Update the attribute area.
  $AF1D,$01 #REGa=#REGb.
  $AF1E,$03 Call #R$C331.
  $AF21,$01 #REGd=#REGb.
  $AF22,$03 Jump to #R$AEE1.

w $AF25 Object Handlers
@ $AF25 label=ObjectHandlers
D $AF25 The routines that #R$A18D jumps to for the objects of types #N($13)
. to #N($1E). The entry for type #N($1B) is never used.
W $AF25,$18,$02

w $AF3D Frame Table Addresses
@ $AF3D label=FrameTableAddresses
D $AF3D The address of the table of sprites for each type of object, from type
. #N$00 to type #N($1E); used by #R$A19F and #R$ADBE. The table for the
. object is indexed by the bottom four bits of offset #N($13) of the object.
W $AF3D,$3E,$02

w $AF7B Sprite Tables
@ $AF7B label=SpriteTables
D $AF7B Tables of the addresses of sprites. The first is indexed by the item
. that is carried and is also the table for type #N($1E). The tables for
. types #N($14), #N($0C), #N($0D) and #N($1B) overlap it, and follow it.
W $AF7B,$12,$02
W $AF8D,$08,$02
@ $AF95 label=SpriteTables_ShipParts
W $AF95,$16,$02
W $AFAB,$20,$02
W $AFCB,$0C,$02
@ $AFD7 label=SpriteTables_ShipPartPositions
W $AFD7,$12,$02

c $AFE9 Build Ship
@ $AFE9 label=BuildShip
D $AFE9 Builds the graphic of the ship from the parts that have been fitted.
. Copies the base of the ship to #R$F755 and adds each of the nine parts that
. are flagged at #R$F5EE with #R$B09C. Then works out the height of the ship
. from the parts, the position of the buffer to draw it from and the vertical
. position of the ship.
  $AFE9,$03 The number stored for the first part.
  $AFEC,$01 Double that number.
  $AFED,$03 Use the double as the second part's number.
  $AFF0,$02 Both scroll limits start at two.
  $AFF2,$03 The horizontal limit.
  $AFF5,$03 The vertical limit.
  $AFF8,$03 The base graphic is #N($54) bytes.
  $AFFB,$03 The ship graphic is built at #R$F755.
  $AFFE,$03 The base graphic is at #R$C891.
  $B001,$02 Copy the base graphic into the buffer.
  $B003,$04 The nine part flags start at #R$F5EE.
  $B007,$02 The ship starts #N($0E) rows tall.
  $B009,$03 That height.
  $B00C,$02 Nine parts.
@ $B00E label=BuildShip_Loop
  $B00E,$01 Keep the part count.
  $B00F,$03 This part's number.
  $B012,$04 Add the part when a number is stored.
  $B016,$02 The next part flag.
  $B018,$01 Back to the part count.
  $B019,$02 Repeat for all nine parts.
  $B01B,$03 The height of the ship.
  $B01E,$01 #REGb=#REGa.
  $B01F,$02 #REGa=#N$28.
  $B021,$01 Subtract #REGb from #REGa.
  $B022,$01 Double #REGa.
  $B023,$01 #REGe=#REGa.
  $B024,$01 Double #REGa.
  $B025,$01 #REGa gains #REGe.
  $B026,$01 #REGe=#REGa.
  $B027,$02 Clear #REGd.
  $B029,$03 The ship work area.
  $B02C,$01 #REGhl gains #REGde.
  $B02D,$03 Update the ship buffer address.
  $B030,$03 The row the ship was drawn on.
  $B033,$01 #REGb=#REGa.
  $B034,$03 The height of the ship.
  $B037,$02 Subtract #N$0E from #REGa.
  $B039,$02 Add #N$6F to #REGa.
  $B03B,$02,b$01 Set the bits of #REGa that are set in #N$07.
  $B03D,$03 Update the row the ship was drawn on.
  $B040,$01 Subtract #REGb from #REGa.
  $B041,$03 Update the high byte of the ship's vertical speed.
  $B044,$04 The ship.
  $B048,$03 Call #R$B9BB.
  $B04B,$03 Write #REGh to offset #N$04 of #REGix.
  $B04E,$03 Write #REGl to offset #N$05 of #REGix.
  $B051,$03 Call #R$B9EC.
  $B054,$03 The height of the ship.
  $B057,$01 #REGb=#REGa.
  $B058,$03 Read offset #N$1E of #REGix.
  $B05B,$01 Subtract #REGb from #REGa.
  $B05C,$02 Add #N$09 to #REGa.
  $B05E,$03 Update the ship row.
  $B061,$03 The flag at #R$F5F1.
  $B064,$03 Leave the horizontal limit at two when it is clear.
  $B067,$02 A fitted part raises the limit to four.
  $B069,$03 The horizontal limit.
@ $B06C label=BuildShip_Limit
  $B06C,$03 The flag at #R$F5F2.
  $B06F,$03 Leave the vertical limit at two when it is clear.
  $B072,$02 A fitted part raises the limit to four.
  $B074,$03 The vertical limit.
@ $B077 label=BuildShip_Carried
  $B077,$03 The carried item.
  $B07A,$01 Advance #REGa.
  $B07B,$02 Jump to #R$B08A if the zero flag is set.
  $B07D,$01 Step #REGa back.
  $B07E,$02,b$01 Set the bits of #REGa that are set in #N$C0.
  $B080,$03 Update the item the ship is about to pick up.
  $B083,$03 Call #R$AA94.
  $B086,$01 Clear #REGa.
  $B087,$03 Update the item the ship is about to pick up.
@ $B08A label=BuildShip_Last
  $B08A,$03 The ninth part flag.
  $B08D,$04 Jump to #R$A8D9 if #REGa is zero.
  $B091,$03 The height of the ship.
  $B094,$02 Add #N$0B to #REGa.
  $B096,$03 Update the height of the ship.
  $B099,$03 Jump to #R$A8D9.

c $B09C Add Ship Part
@ $B09C label=AddShipPart
D $B09C Adds one part to the graphic of the ship. The sprite of the part is
. found in the table at #R$AF95 and the place in the graphic where it goes in
. the table at #R$AFD7. The height of the ship is made at least as tall as the
. part. The mask of the part is ANDed into the graphic, one row at a time,
. then its picture is ORed in.
R $B09C IX Address of the flag for the part, which is the number of the part
  $B09C,$03 The ship-part sprites.
  $B09F,$03 Read offset #N$00 of #REGix into #REGc.
  $B0A2,$01 Step #REGc back.
  $B0A3,$03 Call #R$A1AA.
  $B0A6,$01 Swap #REGde and #REGhl.
  $B0A7,$01 Stash #REGde on the stack.
  $B0A8,$03 Read offset #N$00 of #REGix.
  $B0AB,$01 #REGc=#REGa.
  $B0AC,$01 Step #REGc back.
  $B0AD,$03 The positions of the ship parts.
  $B0B0,$03 Call #R$A1AA.
  $B0B3,$01 Bring #REGde back off the stack.
  $B0B4,$01 Stash #REGde on the stack.
  $B0B5,$01 Stash #REGhl on the stack.
  $B0B6,$01 Step #REGde back.
  $B0B7,$01 Read #REGde.
  $B0B8,$01 Advance #REGde.
  $B0B9,$01 #REGb=#REGa.
  $B0BA,$03 The height of the ship.
  $B0BD,$03 Jump to #R$B0C4 if #REGa is #REGb or more.
  $B0C0,$01 #REGa=#REGb.
  $B0C1,$03 Update the height of the ship.
@ $B0C4 label=AddShipPart_Picture2
  $B0C4,$01 Read #REGde.
  $B0C5,$01 #REGb=#REGa.
  $B0C6,$01 Switch to the alternate accumulator and flags.
  $B0C7,$01 Advance #REGde.
  $B0C8,$01 Read #REGde.
  $B0C9,$03 The height of the part.
  $B0CC,$01 Advance #REGde.
  $B0CD,$01 #REGc=#REGa.
  $B0CE,$01 Clear #REGa.
@ $B0CF label=AddShipPart_Multiply
  $B0CF,$01 #REGa gains #REGc.
  $B0D0,$02 Decrease #REGb and jump to #R$B0CF until none remain.
  $B0D2,$01 #REGc=#REGa.
  $B0D3,$01 Swap #REGde and #REGhl.
  $B0D4,$01 #REGhl gains #REGbc.
  $B0D5,$01 Swap #REGde and #REGhl.
  $B0D6,$01 Read #REGde.
  $B0D7,$04 Jump to #R$B0F8 if #REGa is #N$FF.
  $B0DB,$01 Switch to the alternate accumulator and flags.
  $B0DC,$01 #REGb=#REGa.
  $B0DD,$03 The height of the part.
  $B0E0,$01 Switch to the alternate accumulator and flags.
  $B0E1,$01 #REGc=#REGb.
  $B0E2,$02 Jump to #R$B0E5.
@ $B0E4 label=AddShipPart_Mask
  $B0E4,$01 Switch to the alternate accumulator and flags.
@ $B0E5 label=AddShipPart_Row2
  $B0E5,$01 #REGb=#REGc.
  $B0E6,$01 Stash #REGhl on the stack.
@ $B0E7 label=AddShipPart_Erase
  $B0E7,$01 Read #REGde.
  $B0E8,$01 Keep the bits of #REGa that are set in the byte at #REGhl.
  $B0E9,$01 Write #REGa where #REGhl points.
  $B0EA,$01 Advance #REGde.
  $B0EB,$01 Advance #REGhl.
  $B0EC,$02 Decrease #REGb and jump to #R$B0E7 until none remain.
  $B0EE,$01 Bring #REGhl back off the stack.
  $B0EF,$02 #REGa=#N$06.
  $B0F1,$03 Call #R$9BCF.
  $B0F4,$01 Switch to the alternate accumulator and flags.
  $B0F5,$01 Step #REGa back.
  $B0F6,$02 Jump to #R$B0E4 if the zero flag is clear.
@ $B0F8 label=AddShipPart_Picture
  $B0F8,$01 Bring #REGhl back off the stack.
  $B0F9,$01 Bring #REGde back off the stack.
  $B0FA,$01 Read #REGde.
  $B0FB,$01 #REGb=#REGa.
  $B0FC,$01 #REGc=#REGa.
  $B0FD,$01 Advance #REGde.
  $B0FE,$01 Read #REGde.
  $B0FF,$01 Advance #REGde.
@ $B100 label=AddShipPart_Row
  $B100,$01 Switch to the alternate accumulator and flags.
  $B101,$01 #REGb=#REGc.
  $B102,$01 Stash #REGhl on the stack.
@ $B103 label=AddShipPart_Draw
  $B103,$01 Read #REGde.
  $B104,$01 Set the bits of #REGa that are set in the byte at #REGhl.
  $B105,$01 Write #REGa where #REGhl points.
  $B106,$01 Advance #REGde.
  $B107,$01 Advance #REGhl.
  $B108,$02 Decrease #REGb and jump to #R$B103 until none remain.
  $B10A,$01 Bring #REGhl back off the stack.
  $B10B,$02 #REGa=#N$06.
  $B10D,$03 Call #R$9BCF.
  $B110,$01 Switch to the alternate accumulator and flags.
  $B111,$01 Step #REGa back.
  $B112,$02 Jump to #R$B100 if the zero flag is clear.
  $B114,$01 Return.

c $B115 Read Controls
@ $B115 label=ReadControls
D $B115 Reads the controls and keeps what is pressed at #R$5C37 (bit 0 is
. right, bit 1 is left, bit 3 is up, bit 4 is fire and bit 5 is the extra
. key). Up is ignored in one place near the start of the planet, and only
. fire and the extra key are used while the special shot is out. Moving uses
. fuel, which is worked out here and taken off by #R$CC4D: more for going up
. and sideways together, and half as much if part #N$06 is fitted or the
. value at #R$5C40 is not zero.
  $B115,$03 Call #R$B16F.
  $B118,$02 Clear #REGb.
  $B11A,$03 The fifth part flag.
  $B11D,$03 Jump to #R$B122 if #REGa is not zero.
  $B120,$02 #REGb=#N$05.
@ $B122 label=ReadControls_Zone
  $B122,$03 The map row.
  $B125,$03 Jump to #R$B133 if #REGa is not #REGb.
  $B128,$03 The position down.
  $B12B,$04 Jump to #R$B133 if #REGa is #N$60 or more.
  $B12F,$01 #REGa=#REGc.
  $B130,$02,b$01 Keep the bits of #REGa that are set in #N$F7.
  $B132,$01 #REGc=#REGa.
@ $B133 label=ReadControls_Special
  $B133,$03 The special-shot flag.
  $B136,$03 Jump to #R$B13D if #REGa is zero.
  $B139,$01 #REGa=#REGc.
  $B13A,$02,b$01 Keep the bits of #REGa that are set in #N$30.
  $B13C,$01 #REGc=#REGa.
@ $B13D label=ReadControls_Store
  $B13D,$03 The crystal-delivery flag.
  $B140,$02 Return if #REGa is not zero.
  $B142,$01 #REGa=#REGc.
  $B143,$03 Update the controls.
  $B146,$02,b$01 Keep the bits of #REGa that are set in #N$0B.
  $B148,$01 Return if the zero flag is set.
  $B149,$03 #REGde=#N$08.
  $B14C,$04 Jump to #R$B157 if bit 3 of #REGa is clear.
  $B150,$02,b$01 Keep the bits of #REGa that are set in #N$03.
  $B152,$02 Jump to #R$B157 if the zero flag is set.
  $B154,$03 #REGde=#N$10.
@ $B157 label=ReadControls_Part
  $B157,$03 The sixth part, which halves the fuel.
  $B15A,$03 Jump to #R$B161 if #REGa is zero.
  $B15D,$02 Shift #REGd right keeping the sign.
  $B15F,$02 Rotate #REGe right through the carry.
@ $B161 label=ReadControls_Use
  $B161,$03 The ship was just hit.
  $B164,$04 Jump to #R$CC4D if #REGa is zero.
  $B168,$02 Shift #REGd right keeping the sign.
  $B16A,$02 Rotate #REGe right through the carry.
  $B16C,$03 Jump to #R$CC4D.

c $B16F Read Input Device
@ $B16F label=ReadInputDevice
D $B16F Reads the device that was chosen on the title screen: the keyboard
. (#N$00), a Kempston joystick (#N$01), a Cursor joystick (#N$02) or a Sinclair
. Interface 2 joystick (#N$03). The result is in the same layout for all of
. them. The keyboard has no joystick, so the keys of the middle two rows are
. all for up, the top row is for fire, the number keys are for the extra key,
. and the keys of the bottom row alternate between right and left.
R $B16F O:C Controls: bit 0 is right, bit 1 left, bit 3 up, bit 4 fire and
. bit 5 the extra key
  $B16F,$03 The control device.
  $B172,$04 Jump to #R$B1D2 if #REGa is zero.
  $B176,$04 Jump to #R$B180 if #REGa is #N$01.
  $B17A,$04 Jump to #R$B1A6 if #REGa is #N$02.
  $B17E,$02 Jump to #R$B188.
@ $B180 label=ReadInputDevice_Kempston
  $B180,$02 Read port #N$1F.
  $B182,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $B184,$01 #REGc=#REGa.
  $B185,$03 Jump to #R$B226.
@ $B188 label=ReadInputDevice_Interface2
  $B188,$02 #REGa=#N$EF.
  $B18A,$02 Send #REGa to port #N$FD.
  $B18C,$02 Read port #N$FE.
  $B18E,$02 #REGb=#N$FF.
  $B190,$01 Rotate #REGa right.
  $B191,$02 Rotate #REGb left through the carry.
  $B193,$01 Rotate #REGa right.
  $B194,$02 Rotate #REGb left through the carry.
  $B196,$01 Rotate #REGa right.
  $B197,$02 Rotate #REGb left through the carry.
  $B199,$01 Rotate #REGa right.
  $B19A,$01 Rotate #REGa right.
  $B19B,$02 Rotate #REGb left through the carry.
  $B19D,$01 Rotate #REGa left.
  $B19E,$02 Rotate #REGb left through the carry.
  $B1A0,$01 #REGa=#REGb.
  $B1A1,$01 Invert #REGa.
  $B1A2,$01 #REGc=#REGa.
  $B1A3,$03 Jump to #R$B226.
@ $B1A6 label=ReadInputDevice_Cursor
  $B1A6,$02 #REGa=#N$EF.
  $B1A8,$02 Send #REGa to port #N$FD.
  $B1AA,$02 Read port #N$FE.
  $B1AC,$02,b$01 Set the bits of #REGa that are set in #N$E0.
  $B1AE,$01 #REGb=#REGa.
  $B1AF,$02,b$01 Keep the bits of #REGa that are set in #N$08.
  $B1B1,$01 #REGc=#REGa.
  $B1B2,$01 #REGa=#REGb.
  $B1B3,$01 Rotate #REGa right.
  $B1B4,$01 Rotate #REGa right.
  $B1B5,$01 #REGb=#REGa.
  $B1B6,$02,b$01 Keep the bits of #REGa that are set in #N$05.
  $B1B8,$01 Set the bits of #REGa that are set in #REGc.
  $B1B9,$01 #REGc=#REGa.
  $B1BA,$01 #REGa=#REGb.
  $B1BB,$01 Rotate #REGa right.
  $B1BC,$01 Rotate #REGa right.
  $B1BD,$02,b$01 Keep the bits of #REGa that are set in #N$10.
  $B1BF,$01 Set the bits of #REGa that are set in #REGc.
  $B1C0,$01 #REGc=#REGa.
  $B1C1,$02 #REGa=#N$F7.
  $B1C3,$02 Send #REGa to port #N$FD.
  $B1C5,$02 Read port #N$FE.
  $B1C7,$01 Rotate #REGa right.
  $B1C8,$01 Rotate #REGa right.
  $B1C9,$01 Rotate #REGa right.
  $B1CA,$02,b$01 Keep the bits of #REGa that are set in #N$02.
  $B1CC,$01 Set the bits of #REGa that are set in #REGc.
  $B1CD,$01 Invert #REGa.
  $B1CE,$01 #REGc=#REGa.
  $B1CF,$03 Jump to #R$B226.
@ $B1D2 label=ReadInputDevice_Keyboard
  $B1D2,$01 Clear #REGa.
  $B1D3,$01 #REGc=#REGa.
  $B1D4,$02 #REGa=#N$FE.
  $B1D6,$02 Send #REGa to port #N$FD.
  $B1D8,$02 Read port #N$FE.
  $B1DA,$02,b$01 Keep the bits of #REGa that are set in #N$14.
  $B1DC,$01 #REGb=#REGa.
  $B1DD,$02 #REGa=#N$7F.
  $B1DF,$02 Send #REGa to port #N$FD.
  $B1E1,$02 Read port #N$FE.
  $B1E3,$02,b$01 Keep the bits of #REGa that are set in #N$0A.
  $B1E5,$01 Set the bits of #REGa that are set in #REGb.
  $B1E6,$02,b$01 Flip the bits of #REGa that are set in #N$1E.
  $B1E8,$02 Jump to #R$B1F0 if the zero flag is set.
  $B1EA,$01 #REGa=#REGc.
  $B1EB,$02,b$01 Set the bits of #REGa that are set in #N$01.
  $B1ED,$01 #REGc=#REGa.
  $B1EE,$02 Jump to #R$B208.
@ $B1F0 label=ReadInputDevice_Left
  $B1F0,$02 #REGa=#N$FE.
  $B1F2,$02 Send #REGa to port #N$FD.
  $B1F4,$02 Read port #N$FE.
  $B1F6,$02,b$01 Keep the bits of #REGa that are set in #N$0A.
  $B1F8,$01 #REGb=#REGa.
  $B1F9,$02 #REGa=#N$7F.
  $B1FB,$02 Send #REGa to port #N$FD.
  $B1FD,$02 Read port #N$FE.
  $B1FF,$02,b$01 Keep the bits of #REGa that are set in #N$14.
  $B201,$01 Set the bits of #REGa that are set in #REGb.
  $B202,$02,b$01 Flip the bits of #REGa that are set in #N$1E.
  $B204,$02 Jump to #R$B208 if the zero flag is set.
  $B206,$02 Set bit 1 of #REGc.
@ $B208 label=ReadInputDevice_Up
  $B208,$02 #REGa=#N$BD.
  $B20A,$03 Call #R$9BC3.
  $B20D,$02 Jump to #R$B211 if the zero flag is set.
  $B20F,$02 Set bit 3 of #REGc.
@ $B211 label=ReadInputDevice_Fire
  $B211,$02 #REGa=#N$DB.
  $B213,$03 Call #R$9BC3.
  $B216,$02 Jump to #R$B21A if the zero flag is set.
  $B218,$02 Set bit 4 of #REGc.
@ $B21A label=ReadInputDevice_Extra
  $B21A,$02 #REGa=#N$E7.
  $B21C,$02 Clear #REGb.
@ $B21E label=ReadInputDevice_Test
  $B21E,$03 Call #R$9BC3.
  $B221,$01 Set the bits of #REGa that are set in #REGb.
  $B222,$01 Return if the zero flag is set.
  $B223,$02 Set bit 5 of #REGc.
  $B225,$01 Return.
@ $B226 label=ReadInputDevice_Joystick
  $B226,$02 Reset bit 5 of #REGc.
  $B228,$02 #REGa=#N$7E.
  $B22A,$03 Call #R$9BC3.
  $B22D,$02,b$01 Keep the bits of #REGa that are set in #N$1E.
  $B22F,$01 #REGb=#REGa.
  $B230,$02 #REGa=#N$99.
  $B232,$02 Jump to #R$B21E.

c $B234 Update Ship Speeds
@ $B234 label=UpdateShipSpeeds
D $B234 Reads the controls, then changes the horizontal and vertical speeds
. of the ship by the amounts in the table at #R$B312, depending on what is
. pressed and on the speed it already has, limits them, and works out the
. vertical scroll speed in #R$CCBA with #R$B2D5.
E $B234 Continue on to #R$B2D5.
R $B234 IX Address of the ship at #R$C8E5
  $B234,$03 Call #R$B115.
  $B237,$01 Clear #REGa.
  $B238,$03 Update the steering direction.
  $B23B,$04 Fetch the word at #R$B31A into #REGde.
  $B23F,$03 The crystal-delivery flag.
  $B242,$03 Jump to #R$B259 if #REGa is zero.
  $B245,$02 #REGa=#N$08.
  $B247,$03 Update the controls.
  $B24A,$02 #REGa=#N$04.
  $B24C,$03 Update the vertical scroll limit.
  $B24F,$03 The map row.
  $B252,$03 Jump to #R$B26D if #REGa is not zero.
  $B255,$03 Update the vertical scroll speed.
  $B258,$01 Return.
@ $B259 label=UpdateShipSpeeds_Drag
  $B259,$03 Read offset #N$07 of #REGix.
  $B25C,$02 Negate #REGa.
  $B25E,$03 Jump to #R$B26D if #REGa is zero.
  $B261,$04 Fetch the word at #R$B31E into #REGde.
  $B265,$04 Jump to #R$B26D if bit 7 of #REGa is set.
  $B269,$04 Fetch the word at #R$B31C into #REGde.
@ $B26D label=UpdateShipSpeeds_Sideways
  $B26D,$03 The controls.
  $B270,$04 Jump to #R$B287 if bit 1 of #REGa is clear.
  $B274,$01 Swap #REGde and #REGhl.
  $B275,$04 Fetch the word at #R$B318 into #REGde.
  $B279,$02 #REGa=#N$80.
  $B27B,$03 Update the steering direction.
  $B27E,$01 #REGa=#REGh.
  $B27F,$04 Jump to #R$B29B if #REGa is #N$FF.
  $B283,$01 #REGhl gains #REGde.
  $B284,$01 Swap #REGde and #REGhl.
  $B285,$02 Jump to #R$B29B.
@ $B287 label=UpdateShipSpeeds_Right
  $B287,$04 Jump to #R$B29B if bit 0 of #REGa is clear.
  $B28B,$01 Swap #REGde and #REGhl.
  $B28C,$04 Fetch the word at #R$B316 into #REGde.
  $B290,$02 #REGa=#N$03.
  $B292,$03 Update the steering direction.
  $B295,$01 #REGa=#REGh.
  $B296,$03 Jump to #R$B29B if #REGa is zero.
  $B299,$01 #REGhl gains #REGde.
  $B29A,$01 Swap #REGde and #REGhl.
@ $B29B label=UpdateShipSpeeds_Vertical
  $B29B,$03 The ship was just hit.
  $B29E,$03 Jump to #R$B2A4 if #REGa is zero.
  $B2A1,$03 #REGde=#N$00.
@ $B2A4 label=UpdateShipSpeeds_Thrust
  $B2A4,$03 Call #R$C7FC.
  $B2A7,$04 Fetch the word at #R$B312 into #REGde.
  $B2AB,$03 The controls.
  $B2AE,$02,b$01 Keep the bits of #REGa that are set in #N$08.
  $B2B0,$02 Jump to #R$B2B6 if the zero flag is set.
  $B2B2,$04 Fetch the word at #R$B314 into #REGde.
@ $B2B6 label=UpdateShipSpeeds_Gravity
  $B2B6,$03 Read offset #N$1B of #REGix into #REGh.
  $B2B9,$03 Read offset #N$1C of #REGix into #REGl.
  $B2BC,$03 The special-shot flag.
  $B2BF,$03 Jump to #R$B2CB if #REGa is zero.
  $B2C2,$03 #REGhl=#N$00.
  $B2C5,$03 #REGde=#N$00.
  $B2C8,$03 Update the vertical scroll fraction.
@ $B2CB label=UpdateShipSpeeds_Limit
  $B2CB,$01 #REGhl gains #REGde.
  $B2CC,$03 Call #R$B322.
  $B2CF,$03 Write #REGh to offset #N$1B of #REGix.
  $B2D2,$03 Write #REGl to offset #N$1C of #REGix.

c $B2D5 Update Vertical Scroll Speed
@ $B2D5 label=UpdateVerticalScrollSpeed
D $B2D5 Adds the vertical speed of the ship to the fraction in #R$B320 and
. works out how many whole pixels of vertical scroll that makes, limited to
. the value at #R$5C3F and stores it in #R$CCBA. Halved if the speed is at
. its limit and bit 1 of #R$CE42 is set.
  $B2D5,$04 Fetch the word at #R$B320 into #REGde.
  $B2D9,$01 #REGhl gains #REGde.
  $B2DA,$03 Update the vertical scroll fraction.
  $B2DD,$01 #REGa=#REGh.
  $B2DE,$01 Subtract #REGd from #REGa.
  $B2DF,$01 Double #REGa.
  $B2E0,$01 #REGh=#REGa.
  $B2E1,$04 Jump to #R$B2F3 if bit 7 of #REGa is set.
  $B2E5,$03 The vertical scroll limit.
  $B2E8,$02 Add #N$02 to #REGa.
  $B2EA,$01 Compare #REGa with #REGh.
  $B2EB,$01 #REGa=#REGh.
  $B2EC,$02 Jump to #R$B2F9 if the zero flag is clear.
  $B2EE,$03 The vertical scroll limit.
  $B2F1,$02 Jump to #R$B2F9.
@ $B2F3 label=UpdateVerticalScrollSpeed_Up
  $B2F3,$04 Jump to #R$B2F9 if #REGa is not #N$FA.
  $B2F7,$02 #REGa=#N$FC.
@ $B2F9 label=UpdateVerticalScrollSpeed_Store
  $B2F9,$03 Update the vertical scroll speed.
  $B2FC,$04 Jump to #R$B303 if #REGa is #N$04.
  $B300,$03 Return if #REGa is not #N$FC.
@ $B303 label=UpdateVerticalScrollSpeed_Halve
  $B303,$03 The vertical offset.
  $B306,$02,b$01 Keep the bits of #REGa that are set in #N$02.
  $B308,$01 Return if the zero flag is set.
  $B309,$03 The vertical scroll speed.
  $B30C,$02 Shift #REGa right keeping the sign.
  $B30E,$03 Update the vertical scroll speed.
  $B311,$01 Return.

w $B312 Ship Acceleration Table
@ $B312 label=ShipAccelerationTable
D $B312 The amounts that #R$B234 adds to the speeds of the ship, which are
. signed numbers with the fraction in the bottom byte.
W $B312,$02,$02 Vertical, when not going up
W $B314,$02,$02 Vertical, when going up
W $B316,$02,$02 Horizontal, for the right key
W $B318,$02,$02 Horizontal, for the left key
W $B31A,$02,$02 Horizontal drag, when not moving
W $B31C,$02,$02 Horizontal drag, one way
W $B31E,$02,$02 Horizontal drag, the other way

g $B320 Vertical Scroll Fraction
@ $B320 label=VerticalScrollFraction
D $B320 The fraction of a pixel that is left over from the vertical scroll
. speed worked out by #R$B2D5.
W $B320,$02,$02

c $B322 Limit Vertical Speed
@ $B322 label=LimitVerticalSpeed
D $B322 Keeps the vertical speed of the ship within its limits: no faster than
. #N$FD downwards, and no faster than half the value at #R$5C3F upwards.
R $B322 HL Vertical speed
R $B322 O:HL Limited vertical speed
  $B322,$01 #REGa=#REGh.
  $B323,$04 Jump to #R$B32D if bit 7 of #REGa is clear.
  $B327,$03 Return if #REGa is #N$FE or more.
  $B32A,$02 #REGh=#N$FD.
  $B32C,$01 Return.
@ $B32D label=LimitVerticalSpeed_Up
  $B32D,$03 The vertical scroll limit.
  $B330,$02 Shift #REGa right.
  $B332,$02 Return if #REGa is #REGh or more.
  $B334,$01 #REGh=#REGa.
  $B335,$01 Return.

c $B336 Draw Rows
@ $B336 label=DrawRows
D $B336 Draws rows of a buffer onto the screen by ORing them in, going up the
. screen from the row that #REGhl is at. The number of rows is the value in
. #R$A1D8 and a row is #REGb bytes of the buffer, which has eight bytes to a
. row.
R $B336 B Number of bytes in a row
R $B336 DE Address of the buffer
R $B336 HL Screen address
  $B336,$01 #REGa=#REGb.
  $B337,$02 Return if #REGa is zero.
  $B339,$01 #REGc=#REGb.
  $B33A,$03 The rows to draw.
@ $B33D label=DrawRows_Row
  $B33D,$01 Switch to the alternate accumulator and flags.
  $B33E,$01 #REGb=#REGc.
  $B33F,$01 Stash #REGde on the stack.
  $B340,$01 Stash #REGhl on the stack.
@ $B341 label=DrawRows_Byte
  $B341,$01 Read #REGde.
  $B342,$01 Set the bits of #REGa that are set in the byte at #REGhl.
  $B343,$01 Write #REGa where #REGhl points.
  $B344,$01 Advance #REGl.
  $B345,$01 Advance #REGde.
  $B346,$02 Decrease #REGb and jump to #R$B341 until none remain.
  $B348,$01 Bring #REGhl back off the stack.
  $B349,$03 Call #R$A1C3.
  $B34C,$01 Bring #REGde back off the stack.
  $B34D,$02 #REGa=#N$08.
  $B34F,$01 #REGa gains #REGe.
  $B350,$01 #REGe=#REGa.
  $B351,$01 Switch to the alternate accumulator and flags.
  $B352,$01 Step #REGa back.
  $B353,$02 Jump to #R$B33D if the zero flag is clear.
  $B355,$01 Return.

c $B356 Erase Rows
@ $B356 label=EraseRows
D $B356 Erases rows from the screen, going up from the row that #REGhl is at,
. using the same layout as #R$B336 but with the number of rows in #R$A1D7. The
. alternate registers are used.
R $B356 B' Number of bytes in a row
R $B356 DE' Address of the buffer
R $B356 HL' Screen address
  $B356,$01 Switch to the alternate registers.
  $B357,$01 #REGa=#REGb.
  $B358,$03 Jump to #R$B378 if #REGa is zero.
  $B35B,$01 #REGc=#REGb.
  $B35C,$03 The rows to erase.
@ $B35F label=EraseRows_Row
  $B35F,$01 Switch to the alternate accumulator and flags.
  $B360,$01 #REGb=#REGc.
  $B361,$01 Stash #REGde on the stack.
  $B362,$01 Stash #REGhl on the stack.
@ $B363 label=EraseRows_Byte
  $B363,$01 Read #REGde.
  $B364,$01 Invert #REGa.
  $B365,$01 Keep the bits of #REGa that are set in the byte at #REGhl.
  $B366,$01 Write #REGa where #REGhl points.
  $B367,$01 Advance #REGl.
  $B368,$01 Advance #REGde.
  $B369,$02 Decrease #REGb and jump to #R$B363 until none remain.
  $B36B,$01 Bring #REGhl back off the stack.
  $B36C,$03 Call #R$A1C3.
  $B36F,$01 Bring #REGde back off the stack.
  $B370,$02 #REGa=#N$08.
  $B372,$01 #REGa gains #REGe.
  $B373,$01 #REGe=#REGa.
  $B374,$01 Switch to the alternate accumulator and flags.
  $B375,$01 Step #REGa back.
  $B376,$02 Jump to #R$B35F if the zero flag is clear.
@ $B378 label=EraseRows_Finish
  $B378,$01 Switch to the alternate registers.
  $B379,$01 Return.

g $B37A Shot Slots
@ $B37A label=ShotSlots
D $B37A Four slots of #N($18) bytes for the shots that the ship fires, in the
. same layout as the slots at #R$9974. The routine at #R$B706 updates them.
B $B37A,$60,$18

b $B3DA Shot Offsets
@ $B3DA label=ShotOffsets
D $B3DA Two tables of eight bytes. The offset in the shot is added to the
. address of one of them by #R$B3EA.
B $B3DA,$08,$08
@ $B3E2 label=ShotOffsets_Second
B $B3E2,$08,$08

c $B3EA Add Shot Offset
@ $B3EA label=AddShotOffset
D $B3EA Adds the byte at offset #N($0F) of a shot to a table address.
R $B3EA DE Address of the table
R $B3EA IX Address of the shot
R $B3EA O:DE Address of the entry
  $B3EA,$03 The low byte of the vertical acceleration.
  $B3ED,$02 Clear #REGh.
  $B3EF,$01 #REGhl gains #REGde.
  $B3F0,$01 Swap #REGde and #REGhl.
  $B3F1,$01 Return.

c $B3F2 Choose Random Colour
@ $B3F2 label=ChooseRandomColour
D $B3F2 Picks one of four attributes for an object at random and stores it at
. offset #N($0D).
R $B3F2 IX Address of the object
  $B3F2,$03 The random numbers.
  $B3F5,$02,b$01 Keep the bits of #REGa that are set in #N$03.
  $B3F7,$02 Add #N$45 to #REGa.
  $B3F9,$04 Jump to #R$B3FF if #REGa is not #N$48.
  $B3FD,$02 #REGa=#N$43.
@ $B3FF label=ChooseRandomColour_Store
  $B3FF,$03 Write #REGa to offset #N$0D of #REGix.
  $B402,$01 Return.

c $B403 Choose Random Step
@ $B403 label=ChooseRandomStep
D $B403 Chooses a step of #N($FF), #N($00) or #N($01) at random, with zero
. twice as likely as the others.
R $B403 O:B Step
  $B403,$03 The second random byte.
  $B406,$02,b$01 Keep the bits of #REGa that are set in #N$03.
  $B408,$02 Clear #REGb.
  $B40A,$03 Return if #REGa is less than #N$02.
  $B40D,$01 Step #REGb back.
  $B40E,$03 Return if #REGa is #N$03.
  $B411,$01 Advance #REGb.
  $B412,$01 Advance #REGb.
  $B413,$01 Return.

c $B414 Update Special Shot
@ $B414 label=UpdateSpecialShot
D $B414 Updates a shot that has bit 7 of offset #N($15) set, which is the
. kind that is made by #R$B7F6. The length of the shot is at offset #N($0E).
. Purpose of the details not yet known.
R $B414 IX Address of the shot
  $B414,$03 The high byte of the vertical acceleration.
  $B417,$04 Call #R$7234 if #REGa is not zero.
  $B41B,$03 Increase offset #N$11 of #REGix by one.
  $B41E,$03 Call #R$B897.
  $B421,$03 Call #R$A28B.
  $B424,$03 The high byte of the vertical acceleration.
  $B427,$01 Switch to the alternate registers.
  $B428,$06 Jump to #R$B460 if bit 7 of offset #N$10 of #REGix is set.
  $B42E,$06 Jump to #R$B471 if bit 0 of offset #N$11 of #REGix is clear.
  $B434,$03 The vertical screen position.
  $B437,$03 Add the byte at offset #N$07 of #REGix to #REGa.
  $B43A,$03 Write the high byte of the horizontal speed.
  $B43D,$03 The high byte of the vertical acceleration.
  $B440,$04 Jump to #R$B455 if #REGa is #N$08.
  $B444,$03 Increase offset #N$0E of #REGix by one.
  $B447,$06 Jump to #R$B455 if bit 7 of offset #N$00 of #REGix is clear.
  $B44D,$02 #REGa=#N$F8.
  $B44F,$03 Add the byte at offset #N$0B of #REGix to #REGa.
  $B452,$03 Write the high byte of the horizontal acceleration.
@ $B455 label=UpdateSpecialShot_Test
  $B455,$03 Call #R$B6F0.
  $B458,$02 Jump to #R$B471 if the zero flag is set.
  $B45A,$03 The high byte of the ship's horizontal speed.
  $B45D,$03 Write the high byte of the horizontal speed.
@ $B460 label=UpdateSpecialShot_Shorter
  $B460,$03 Decrease offset #N$0E of #REGix by one.
  $B463,$06 Jump to #R$B471 if bit 7 of offset #N$00 of #REGix is clear.
  $B469,$02 #REGa=#N$08.
  $B46B,$03 Add the byte at offset #N$0B of #REGix to #REGa.
  $B46E,$03 Write the high byte of the horizontal acceleration.
@ $B471 label=UpdateSpecialShot_Frame
  $B471,$03 Call #R$B8B5.
  $B474,$03 The horizontal screen position.
  $B477,$05 Jump to #R$B5B5 if #REGa is not #N$16.
  $B47C,$04 Set bit 7 of offset #N$10 of #REGix.
  $B480,$03 Jump to #R$B5B5.

c $B483 Update Shot
@ $B483 label=UpdateShot
D $B483 Updates one of the shots that the ship has fired. Shots that have bit
. 7 of offset #N($15) set go to #R$B414. A shot that is starting (with a
. length of zero at offset #N($0E)) is given a starting vertical position from
. #R$5C38 with a random step, and a random colour. Shots that are
. facing right continue at #R$B4C9 and ones that are facing left at #R$B628.
R $B483 IX Address of the shot
  $B483,$03 The high byte of the ship's horizontal speed.
  $B486,$03 Write the high byte of the horizontal speed.
  $B489,$02 #REGa=#N$80.
  $B48B,$03 The shot stops on the terrain.
  $B48E,$07 Jump to #R$B414 if bit 7 of offset #N$15 of #REGix is set.
  $B495,$02 #REGa=#N$01.
  $B497,$03 One row to erase.
  $B49A,$03 One row to draw.
  $B49D,$03 The high byte of the vertical acceleration.
  $B4A0,$03 Jump to #R$B4C9 if #REGa is not zero.
  $B4A3,$04 Store #N$00 at offset #N$10 of #REGix.
  $B4A7,$04 Store #N$00 at offset #N$07 of #REGix.
  $B4AB,$03 Call #R$B403.
  $B4AE,$03 The vertical scroll speed.
  $B4B1,$02 Negate #REGa.
  $B4B3,$01 #REGa gains #REGb.
  $B4B4,$03 Write the high byte of the vertical speed.
  $B4B7,$01 #REGb=#REGa.
  $B4B8,$03 The ship row.
  $B4BB,$01 #REGa gains #REGb.
  $B4BC,$03 Write the low byte of the horizontal acceleration.
  $B4BF,$03 Call #R$B3F2.
  $B4C2,$03 Call #R$BF66.
  $B4C5,$04 Store #N$00 at offset #N$09 of #REGix.
@ $B4C9 label=UpdateShot_Right
  $B4C9,$07 Jump to #R$B628 if bit 7 of offset #N$00 of #REGix is set.
  $B4D0,$03 The shot offsets.
  $B4D3,$03 Call #R$B3EA.
  $B4D6,$03 Call #R$A28B.
  $B4D9,$03 The high byte of the vertical acceleration.
  $B4DC,$01 Switch to the alternate registers.
  $B4DD,$06 Jump to #R$B532 if bit 7 of offset #N$10 of #REGix is set.
  $B4E3,$03 The high byte of the vertical acceleration.
  $B4E6,$03 Jump to #R$B4F1 if #REGa is not zero.
  $B4E9,$04 Store #N$08 at offset #N$0F of #REGix.
  $B4ED,$04 Store #N$88 at offset #N$0B of #REGix.
@ $B4F1 label=UpdateShot_Longer
  $B4F1,$02 #REGa=#N$10.
  $B4F3,$03 Add the byte at offset #N$07 of #REGix to #REGa.
  $B4F6,$03 Write the high byte of the horizontal speed.
  $B4F9,$03 Call #R$B6EC.
  $B4FC,$02 Jump to #R$B511 if the zero flag is set.
  $B4FE,$02 #REGa=#N$F0.
  $B500,$03 Add the byte at offset #N$07 of #REGix to #REGa.
  $B503,$03 Write the high byte of the horizontal speed.
  $B506,$04 Set bit 7 of offset #N$10 of #REGix.
  $B50A,$04 Set bit 5 of offset #N$10 of #REGix.
  $B50E,$03 Jump to #R$B59D.
@ $B511 label=UpdateShot_Move
  $B511,$02 #REGa=#N$08.
  $B513,$03 Add the byte at offset #N$0B of #REGix to #REGa.
  $B516,$03 Write the high byte of the horizontal acceleration.
  $B519,$04 Jump to #R$B521 if #REGa is not #N$B8.
  $B51D,$04 Set bit 7 of offset #N$10 of #REGix.
@ $B521 label=UpdateShot_Length
  $B521,$03 The high byte of the vertical acceleration.
  $B524,$01 Advance #REGa.
  $B525,$03 Write the high byte of the vertical acceleration.
  $B528,$03 The low byte of the vertical acceleration.
  $B52B,$01 Step #REGa back.
  $B52C,$03 Write the low byte of the vertical acceleration.
  $B52F,$03 Jump to #R$B5AA.
@ $B532 label=UpdateShot_Hit
  $B532,$06 Jump to #R$B541 if bit 5 of offset #N$10 of #REGix is set.
  $B538,$03 Call #R$B6EC.
  $B53B,$02 Jump to #R$B586 if the zero flag is set.
  $B53D,$04 Set bit 5 of offset #N$10 of #REGix.
@ $B541 label=UpdateShot_Stopped
  $B541,$03 The high byte of the horizontal speed.
  $B544,$02 Negate #REGa.
  $B546,$03 Add the byte at offset #N$0B of #REGix to #REGa.
  $B549,$03 Write the high byte of the horizontal acceleration.
  $B54C,$04 Store #N$00 at offset #N$07 of #REGix.
  $B550,$04 Test bit 6 of offset #N$10 of #REGix.
  $B554,$03 The high byte of the vertical acceleration.
  $B557,$03 The high byte of the horizontal acceleration.
  $B55A,$02 Jump to #R$B561 if the zero flag is set.
  $B55C,$01 Step #REGb back.
  $B55D,$01 #REGa=#REGc.
  $B55E,$02 Add #N$08 to #REGa.
  $B560,$01 #REGc=#REGa.
@ $B561 label=UpdateShot_Clip
  $B561,$02 Shift #REGb left.
  $B563,$02 Shift #REGb left.
  $B565,$02 Shift #REGb left.
  $B567,$01 #REGa=#REGb.
  $B568,$01 #REGa gains #REGc.
  $B569,$02,b$01 Keep the bits of #REGa that are set in #N$F8.
  $B56B,$04 Jump to #R$B586 if #REGa is less than #N$E4.
  $B56F,$04 Jump to #R$B577 if #REGa is less than #N$F0.
  $B573,$04 Store #N$00 at offset #N$0E of #REGix.
@ $B577 label=UpdateShot_Shorten
  $B577,$03 The high byte of the vertical acceleration.
  $B57A,$01 Step #REGa back.
  $B57B,$03 Write the high byte of the vertical acceleration.
  $B57E,$03 The high byte of the horizontal acceleration.
  $B581,$02 Subtract #N$08 from #REGa.
  $B583,$03 Write the high byte of the horizontal acceleration.
@ $B586 label=UpdateShot_Facing
  $B586,$06 Jump to #R$B59D if bit 6 of offset #N$10 of #REGix is clear.
  $B58C,$03 The high byte of the vertical acceleration.
  $B58F,$01 Step #REGa back.
  $B590,$03 Write the high byte of the vertical acceleration.
  $B593,$03 The high byte of the horizontal acceleration.
  $B596,$02 Add #N$08 to #REGa.
  $B598,$03 Write the high byte of the horizontal acceleration.
  $B59B,$02 Jump to #R$B5AA.
@ $B59D label=UpdateShot_Count
  $B59D,$03 The low byte of the vertical acceleration.
  $B5A0,$01 Step #REGa back.
  $B5A1,$03 Write the low byte of the vertical acceleration.
  $B5A4,$02 Jump to #R$B5AA if the zero flag is clear.
  $B5A6,$04 Set bit 6 of offset #N$10 of #REGix.
@ $B5AA label=UpdateShot_Table
  $B5AA,$03 The shot offsets.
  $B5AD,$02 Jump to #R$B5B2.
@ $B5AF label=UpdateShot_LeftTable
  $B5AF,$03 The second shot offset.
@ $B5B2 label=UpdateShot_Offset
  $B5B2,$03 Call #R$B3EA.

c $B5B5 Draw Shot
@ $B5B5 label=DrawShot
D $B5B5 The end of the routines that update a shot. Moves the shot by the
. vertical scroll speed, then erases the old picture of the shot with
. #R$B356 and draws the new one with #R$B336. If the shot has ended, its slot
. is made free; if it was a special shot that ends the flag at #R$B832 is
. cleared. Otherwise the area of the screen under it is given its attribute
. by #R$B60B.
R $B5B5 IX Address of the shot
  $B5B5,$03 The vertical scroll speed.
  $B5B8,$03 Add the byte at offset #N$0C of #REGix to #REGa.
  $B5BB,$03 Write the low byte of the horizontal acceleration.
  $B5BE,$03 Call #R$A28B.
  $B5C1,$03 The high byte of the vertical acceleration.
  $B5C4,$04 Jump to #R$B5CD if bit 7 of #REGb is clear.
  $B5C8,$02 Clear #REGb.
  $B5CA,$03 Write the high byte of the vertical acceleration.
@ $B5CD label=DrawShot_Draw
  $B5CD,$03 Call #R$B356.
  $B5D0,$03 Call #R$B336.
  $B5D3,$03 Call #R$BF66.
  $B5D6,$03 The high byte of the vertical acceleration.
  $B5D9,$03 Jump to #R$B5EC if #REGa is not zero.
  $B5DC,$04 Store #N$00 at offset #N$0B of #REGix.
  $B5E0,$05 Return if bit 7 of offset #N$15 of #REGix is clear.
  $B5E5,$01 Clear #REGa.
  $B5E6,$03 The special shot has ended.
  $B5E9,$03 Jump to #R$A8A5.
@ $B5EC label=DrawShot_Attributes
  $B5EC,$06 Jump to #R$B60B if bit 7 of offset #N$15 of #REGix is clear.
  $B5F2,$02 #REGa=#N$43.
  $B5F4,$03 The special shot is bright magenta.
  $B5F7,$03 The high byte of the horizontal acceleration.
  $B5FA,$03 The low byte of the horizontal acceleration.
  $B5FD,$03 The rows of the shot.
  $B600,$01 #REGd=#REGa.
  $B601,$03 The high byte of the vertical acceleration.
  $B604,$01 Double #REGa.
  $B605,$01 Double #REGa.
  $B606,$01 Double #REGa.
  $B607,$01 #REGb=#REGa.
  $B608,$03 Jump to #R$AED3.
@ $B60B label=SetShotAttributes
  $B60B,$03 The shot attribute area.
  $B60E,$03 The high byte of the vertical acceleration.
  $B611,$01 Write #REGa where #REGde points.
  $B612,$01 Advance #REGde.
  $B613,$01 Advance #REGde.
  $B614,$03 The attribute.
  $B617,$01 Write #REGa where #REGde points.
  $B618,$03 The high byte of the horizontal acceleration.
  $B61B,$03 The low byte of the horizontal acceleration.
  $B61E,$03 The shot attribute area.
  $B621,$03 Call #R$C991.
  $B624,$01 Return.

g $B625 Shot Attribute Area
@ $B625 label=ShotAttributeArea
D $B625 The width in cells, the height in cells and the attribute of the
. area that #R$B60B fills in the same way as #R$AE98.
B $B625,$03,$01

c $B628 Update Left Shot
@ $B628 label=UpdateLeftShot
D $B628 Updates a shot that is facing left (bit 7 of its type is set), in the
. same way as the section of #R$B483 that is used for a shot that is facing
. right.
R $B628 IX Address of the shot
  $B628,$03 The second shot offset.
  $B62B,$03 Call #R$B3EA.
  $B62E,$03 Call #R$A28B.
  $B631,$03 The high byte of the vertical acceleration.
  $B634,$01 Switch to the alternate registers.
  $B635,$06 Jump to #R$B68E if bit 7 of offset #N$10 of #REGix is set.
  $B63B,$02 #REGa=#N$F0.
  $B63D,$03 Add the byte at offset #N$0B of #REGix to #REGa.
  $B640,$03 Write the high byte of the horizontal acceleration.
  $B643,$02 #REGa=#N$F0.
  $B645,$03 Add the byte at offset #N$07 of #REGix to #REGa.
  $B648,$03 Write the high byte of the horizontal speed.
  $B64B,$03 The high byte of the vertical acceleration.
  $B64E,$03 Jump to #R$B655 if #REGa is not zero.
  $B651,$04 Store #N$58 at offset #N$0B of #REGix.
@ $B655 label=UpdateLeftShot_Test
  $B655,$04 Store #N$00 at offset #N$0F of #REGix.
  $B659,$03 Call #R$B6EC.
  $B65C,$02 Jump to #R$B678 if the zero flag is set.
  $B65E,$04 Set bit 7 of offset #N$10 of #REGix.
  $B662,$04 Set bit 5 of offset #N$10 of #REGix.
  $B666,$02 #REGa=#N$10.
  $B668,$03 Add the byte at offset #N$07 of #REGix to #REGa.
  $B66B,$03 Write the high byte of the horizontal speed.
  $B66E,$02 #REGa=#N$10.
  $B670,$03 Add the byte at offset #N$0B of #REGix to #REGa.
  $B673,$03 Write the high byte of the horizontal acceleration.
  $B676,$02 Jump to #R$B67F.
@ $B678 label=UpdateLeftShot_Length
  $B678,$03 The high byte of the vertical acceleration.
  $B67B,$01 Advance #REGa.
  $B67C,$03 Write the high byte of the vertical acceleration.
@ $B67F label=UpdateLeftShot_End
  $B67F,$03 The high byte of the horizontal acceleration.
  $B682,$05 Jump to #R$B5AF if #REGa is not #N$08.
  $B687,$04 Set bit 7 of offset #N$10 of #REGix.
  $B68B,$03 Jump to #R$B5AF.
@ $B68E label=UpdateLeftShot_Hit
  $B68E,$03 The low byte of the vertical acceleration.
  $B691,$01 Advance #REGa.
  $B692,$03 Write the low byte of the vertical acceleration.
  $B695,$06 Jump to #R$B6A4 if bit 5 of offset #N$10 of #REGix is set.
  $B69B,$03 Call #R$B6EC.
  $B69E,$02 Jump to #R$B6CA if the zero flag is set.
  $B6A0,$04 Set bit 5 of offset #N$10 of #REGix.
@ $B6A4 label=UpdateLeftShot_Stopped
  $B6A4,$03 The high byte of the horizontal speed.
  $B6A7,$02 Negate #REGa.
  $B6A9,$03 Add the byte at offset #N$0B of #REGix to #REGa.
  $B6AC,$03 Write the high byte of the horizontal acceleration.
  $B6AF,$04 Store #N$00 at offset #N$07 of #REGix.
  $B6B3,$04 Jump to #R$B6CA if #REGa is #N$08 or more.
  $B6B7,$02 Add #N$08 to #REGa.
  $B6B9,$03 Write the high byte of the horizontal acceleration.
  $B6BC,$03 The high byte of the vertical acceleration.
  $B6BF,$01 Step #REGa back.
  $B6C0,$03 Write the high byte of the vertical acceleration.
  $B6C3,$03 The low byte of the vertical acceleration.
  $B6C6,$01 Advance #REGa.
  $B6C7,$03 Write the low byte of the vertical acceleration.
@ $B6CA label=UpdateLeftShot_Facing
  $B6CA,$06 Jump to #R$B6DA if bit 6 of offset #N$10 of #REGix is clear.
  $B6D0,$03 The high byte of the vertical acceleration.
  $B6D3,$01 Step #REGa back.
  $B6D4,$03 Write the high byte of the vertical acceleration.
  $B6D7,$03 Jump to #R$B5AF.
@ $B6DA label=UpdateLeftShot_Count
  $B6DA,$03 The low byte of the vertical acceleration.
  $B6DD,$03 Add the byte at offset #N$0E of #REGix to #REGa.
  $B6E0,$05 Jump to #R$B5AF if #REGa is not #N$08.
  $B6E5,$04 Set bit 6 of offset #N$10 of #REGix.
  $B6E9,$03 Jump to #R$B5AF.

c $B6EC Test Shot Hits Ground
@ $B6EC label=TestShotHitsGround
D $B6EC Tests whether a shot has hit the ground or an object, using
. #R$9056 with a box that is #N($18) wide and #N($0C) high (#N($10) high if
. entered at #R$B6F0). A sound is made if the shot is not a special one.
R $B6EC IX Address of the shot
R $B6EC O:F The zero flag is set if nothing was hit
  $B6EC,$02 #REGb=#N$0C.
  $B6EE,$02 Jump to #R$B6F2.
@ $B6F0 label=TestShotHitsGround_Wide
  $B6F0,$02 #REGb=#N$10.
@ $B6F2 label=TestShotHitsGround_Check
  $B6F2,$02 #REGc=#N$18.
  $B6F4,$03 Call #R$9056.
  $B6F7,$03 The hit flag.
  $B6FA,$02 Return if #REGa is zero.
  $B6FC,$07 Call #R$72A5 if bit 7 of offset #N$15 of #REGix is clear.
  $B703,$02,b$01 Set the bits of #REGa that are set in #N$01.
  $B705,$01 Return.

c $B706 Update Shots
@ $B706 label=UpdateShots
D $B706 Updates the four shots in the slots at #R$B37A. A shot with bit 7 of
. offset #N($16) set and a type of zero is a chasing shot, which is dealt
. with by #R$9307. The others are shots in use when offset #N($0B) is not
. zero, and are dealt with by #R$B483.
  $B706,$04 The shot slots.
  $B70A,$02 #REGb=#N$04.
@ $B70C label=UpdateShots_Loop
  $B70C,$01 Stash #REGbc on the stack.
  $B70D,$02 Stash #REGix on the stack.
  $B70F,$06 Jump to #R$B71E if bit 7 of offset #N$16 of #REGix is clear.
  $B715,$03 Read offset #N$00 of #REGix.
  $B718,$04 Call #R$9307 if #REGa is zero.
  $B71C,$02 Jump to #R$B725.
@ $B71E label=UpdateShots_Shot
  $B71E,$03 Read offset #N$0B of #REGix.
  $B721,$04 Call #R$B483 if #REGa is not zero.
@ $B725 label=UpdateShots_Next
  $B725,$02 Bring #REGix back off the stack.
  $B727,$03 #REGbc=#N$18.
  $B72A,$02 #REGix gains #REGbc.
  $B72C,$01 Bring #REGbc back off the stack.
  $B72D,$02 Decrease #REGb and jump to #R$B70C until none remain.
  $B72F,$01 Return.

g $B730 Weapon Toggle
@ $B730 label=WeaponToggle
D $B730 Bit 0 changes every time the ship fires. Bit 2 is flipped by
. #R$B833 to make #R$B752 launch a special shot.
B $B730,$01,$01

c $B731 Fire Weapons
@ $B731 label=FireWeapons
D $B731 Checks the controls for the fire key. The extra key is dealt with by
. #R$B833 first. When fire is pressed, and the six frames since the last
. shot have passed, a shot is launched.
E $B731 Continue on to #R$B752.
  $B731,$03 Call #R$B833.
  $B734,$03 The frames before the next shot.
  $B737,$03 Jump to #R$B73F if #REGa is zero.
  $B73A,$01 Step #REGa back.
  $B73B,$03 One fewer frame before the next shot.
  $B73E,$01 Return.
@ $B73F label=FireWeapons_Fire
  $B73F,$03 The controls.
  $B742,$03 Return if bit 4 of #REGa is clear.
  $B745,$02 #REGa=#N$06.
  $B747,$03 Six frames before the next shot.
  $B74A,$03 The weapon toggle.
  $B74D,$02,b$01 Flip the bits of #REGa that are set in #N$01.
  $B74F,$03 Update the weapon toggle.

c $B752 Launch Shot
@ $B752 label=LaunchShot
D $B752 Launches a shot, from the first free slot out of the four at #R$B37A.
. It faces the way the ship is facing and starts at the ship. Three kinds of
. shot can be launched: an ordinary one, a chasing shot if the ship has part
. #N$08 and the weapon toggle at #R$B730 is one, and a special shot if bit 2
. of the toggle is set.
  $B752,$04 The shot slots.
  $B756,$02 #REGa=#N$04.
@ $B758 label=LaunchShot_Slot
  $B758,$01 Switch to the alternate accumulator and flags.
  $B759,$06 Jump to #R$B765 if bit 7 of offset #N$16 of #REGix is set.
  $B75F,$03 Read offset #N$0B of #REGix.
  $B762,$03 Jump to #R$B76B if #REGa is zero.
@ $B765 label=LaunchShot_Check
  $B765,$03 Read offset #N$00 of #REGix.
  $B768,$01 Advance #REGa.
  $B769,$02 Jump to #R$B796 if the zero flag is clear.
@ $B76B label=LaunchShot_Free
  $B76B,$03 Call #R$AC34.
  $B76E,$03 The ship's facing.
  $B771,$03 Write #REGa to offset #N$00 of #REGix.
  $B774,$04 Store #N$99 at offset #N$0B of #REGix.
  $B778,$03 Call #R$B90A.
  $B77B,$03 The weapon toggle.
  $B77E,$05 Jump to #R$B7F6 if bit 2 of #REGa is set.
  $B783,$01 Step #REGa back.
  $B784,$03 Jump to #R$B7A0 if the zero flag is set.
@ $B787 label=LaunchShot_Ordinary
  $B787,$03 Call #R$BF66.
  $B78A,$04 Store #N$00 at offset #N$09 of #REGix.
  $B78E,$05 Return if bit 7 of offset #N$15 of #REGix is set.
  $B793,$03 Jump to #R$72F2.
@ $B796 label=LaunchShot_Next
  $B796,$03 #REGbc=#N$18.
  $B799,$02 #REGix gains #REGbc.
  $B79B,$01 Switch to the alternate accumulator and flags.
  $B79C,$01 Step #REGa back.
  $B79D,$02 Jump to #R$B758 if the zero flag is clear.
  $B79F,$01 Return.
@ $B7A0 label=LaunchShot_Chasing
  $B7A0,$03 The eighth part, which makes a chasing shot.
  $B7A3,$04 Jump to #R$B787 if #REGa is zero.
  $B7A7,$03 Read offset #N$07 of #REGix.
  $B7AA,$04 Jump to #R$B7B2 if #REGa is #N$08.
  $B7AE,$04 Store #N$20 at offset #N$07 of #REGix.
@ $B7B2 label=LaunchShot_Speed
  $B7B2,$03 Read offset #N$09 of #REGix.
  $B7B5,$02 Subtract #N$03 from #REGa.
  $B7B7,$03 Write #REGa to offset #N$09 of #REGix.
  $B7BA,$04 Store #N$00 at offset #N$08 of #REGix.
  $B7BE,$04 Store #N$00 at offset #N$0A of #REGix.
  $B7C2,$03 Call #R$BF66.
  $B7C5,$04 Store #N$00 at offset #N$09 of #REGix.
  $B7C9,$04 Store #N$27 at offset #N$10 of #REGix.
  $B7CD,$03 Read offset #N$07 of #REGix.
  $B7D0,$04 Store #N$08 at offset #N$07 of #REGix.
  $B7D4,$04 Jump to #R$B7DC if #REGa is #N$20.
  $B7D8,$04 Store #N$F8 at offset #N$07 of #REGix.
@ $B7DC label=LaunchShot_Set
  $B7DC,$04 Store #N$00 at offset #N$00 of #REGix.
  $B7E0,$04 Store #N$DD at offset #N$0D of #REGix.
  $B7E4,$04 Store #N$7F at offset #N$15 of #REGix.
  $B7E8,$04 Store #N$80 at offset #N$16 of #REGix.
  $B7EC,$03 Call #R$B8FC.
  $B7EF,$04 Store #N$F0 at offset #N$17 of #REGix.
  $B7F3,$03 Jump to #R$72F2.
@ $B7F6 label=LaunchShot_Special
  $B7F6,$02 #REGa=#N$80.
  $B7F8,$03 Write #REGa to offset #N$15 of #REGix.
  $B7FB,$03 A special shot has been launched.
  $B7FE,$04 Store #N$43 at offset #N$0D of #REGix.
  $B802,$03 The ship row.
  $B805,$02 Add #N$09 to #REGa.
  $B807,$03 Write #REGa to offset #N$0C of #REGix.
  $B80A,$03 Read offset #N$09 of #REGix.
  $B80D,$02 Add #N$09 to #REGa.
  $B80F,$03 Write #REGa to offset #N$09 of #REGix.
  $B812,$03 Read offset #N$07 of #REGix.
  $B815,$02 Add #N$08 to #REGa.
  $B817,$02,b$01 Keep the bits of #REGa that are set in #N$20.
  $B819,$03 Write #REGa to offset #N$07 of #REGix.
  $B81C,$04 Store #N$F8 at offset #N$12 of #REGix.
  $B820,$04 Store #N$60 at offset #N$0B of #REGix.
  $B824,$03 Jump to #R$B787 if the zero flag is set.
  $B827,$04 Store #N$08 at offset #N$12 of #REGix.
  $B82B,$04 Store #N$90 at offset #N$0B of #REGix.
  $B82F,$03 Jump to #R$B787.
  $B832,$01 Do nothing.

c $B833 Check Special Shot
@ $B833 label=CheckSpecialShot
D $B833 Used when the extra key is pressed. If there is no special shot at
. #R$B832 and the ship has part #N$07 and is moving slowly in both
. directions, launches one. If there is one already, goes to #R$B889.
  $B833,$03 The special-shot flag.
  $B836,$03 Jump to #R$B889 if #REGa is not zero.
  $B839,$03 The controls.
  $B83C,$03 Return if bit 5 of #REGa is clear.
  $B83F,$03 The seventh part, which makes a special shot.
  $B842,$02 Return if #REGa is zero.
  $B844,$03 Fetch the word at #N$C8FE into #REGhl.
  $B847,$01 #REGa=#REGh.
  $B848,$01 #REGh=#REGl.
  $B849,$01 #REGl=#REGa.
  $B84A,$03 Call #R$BA0B.
  $B84D,$01 #REGa=#REGh.
  $B84E,$01 Set the bits of #REGa that are set in #REGl.
  $B84F,$01 Return if the zero flag is clear.
  $B850,$03 Fetch the word at #N$C900 into #REGhl.
  $B853,$01 #REGa=#REGh.
  $B854,$01 #REGh=#REGl.
  $B855,$01 #REGl=#REGa.
  $B856,$03 Call #R$BA0B.
  $B859,$01 #REGa=#REGh.
  $B85A,$01 Set the bits of #REGa that are set in #REGl.
  $B85B,$01 Return if the zero flag is clear.
  $B85C,$03 The weapon toggle.
  $B85F,$02,b$01 Flip the bits of #REGa that are set in #N$04.
  $B861,$03 Update the weapon toggle.
  $B864,$03 Call #R$B752.
  $B867,$03 The weapon toggle.
  $B86A,$02,b$01 Keep the bits of #REGa that are set in #N$01.
  $B86C,$03 Update the weapon toggle.
  $B86F,$01 Return.
@ $B870 label=FindShot
  $B870,$04 The shot slots.
  $B874,$03 #REGde=#N$18.
  $B877,$02 #REGb=#N$03.
@ $B879 label=CheckSpecialShot_Loop
  $B879,$06 Jump to #R$B884 if bit 7 of offset #N$16 of #REGiy is set.
  $B87F,$05 Return if bit 7 of offset #N$15 of #REGiy is set.
@ $B884 label=CheckSpecialShot_Next
  $B884,$02 #REGiy gains #REGde.
  $B886,$02 Decrease #REGb and jump to #R$B879 until none remain.
  $B888,$01 Return.
@ $B889 label=DetonateSpecialShot
  $B889,$03 The controls.
  $B88C,$03 Return if bit 5 of #REGa is set.
  $B88F,$03 Call #R$B870.
  $B892,$04 Set bit 7 of offset #N$10 of #REGiy.
  $B896,$01 Return.

c $B897 Make Shot Row
@ $B897 label=MakeShotRow
D $B897 Builds the picture of a shot from one of the six patterns in the table
. at #R$B8CF, picked by the bottom four bits of offset #N($15), which go round
. from zero to five as the shot is updated. The picture is made in the buffer
. at #N$F800 and its size is stored in #R$A1D7. #R$B8B5 does the same for the
. buffer at #R$F880 and #R$A1D8.
R $B897 IX Address of the shot
  $B897,$03 Use #N$F800.
  $B89A,$03 Call #R$B8C3.
  $B89D,$03 Read offset #N$15 of #REGix.
  $B8A0,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $B8A2,$01 Advance #REGa.
  $B8A3,$04 Jump to #R$B8A8 if #REGa is not #N$06.
  $B8A7,$01 Clear #REGa.
@ $B8A8 label=MakeShotRow_Store
  $B8A8,$02,b$01 Set the bits of #REGa that are set in #N$80.
  $B8AA,$03 Write #REGa to offset #N$15 of #REGix.
  $B8AD,$01 Swap #REGde and #REGhl.
  $B8AE,$01 Read #REGde.
  $B8AF,$03 The rows of the shot picture.
  $B8B2,$03 Jump to #R$B8DB.
@ $B8B5 label=MakeShotColumn
  $B8B5,$03 The build buffer.
  $B8B8,$03 Call #R$B8C3.
  $B8BB,$01 Swap #REGde and #REGhl.
  $B8BC,$01 Read #REGde.
  $B8BD,$03 The rows of the shot column.
  $B8C0,$03 Jump to #R$B8DB.
@ $B8C3 label=FindShotPattern
  $B8C3,$03 Read offset #N$15 of #REGix.
  $B8C6,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $B8C8,$01 #REGc=#REGa.
  $B8C9,$03 The shot pattern table.
  $B8CC,$03 Jump to #R$A1AA.

w $B8CF Shot Pattern Table
@ $B8CF label=ShotPatternTable
D $B8CF The addresses of the six patterns that #R$B897 and #R$B8B5 use for the
. shots, in the order that they are used.
W $B8CF,$0C,$02

c $B8DB Build Shot Pattern
@ $B8DB label=BuildShotPattern
D $B8DB Builds the rows of a pattern in a buffer. The first byte of the pattern
. is the number of rows and each row is two bytes, which are repeated four times
. in the buffer. Returns with the start of the buffer in #REGde, which has one
. added to #REGe if the shot is facing left and bit 0 of its length is set.
R $B8DB A Number of rows
R $B8DB DE Address of the pattern
R $B8DB HL Address of the buffer
R $B8DB IX Address of the shot
R $B8DB O:DE Address of the buffer
  $B8DB,$01 Stash #REGhl on the stack.
  $B8DC,$01 Advance #REGde.
@ $B8DD label=BuildShotPattern_Loop
  $B8DD,$01 Switch to the alternate accumulator and flags.
  $B8DE,$01 Read #REGde.
  $B8DF,$01 #REGc=#REGa.
  $B8E0,$01 Advance #REGde.
  $B8E1,$01 Read #REGde.
  $B8E2,$01 Advance #REGde.
  $B8E3,$02 #REGb=#N$04.
@ $B8E5 label=BuildShotPattern_Row
  $B8E5,$01 Write #REGc where #REGhl points.
  $B8E6,$01 Advance #REGl.
  $B8E7,$01 Write #REGa where #REGhl points.
  $B8E8,$01 Advance #REGl.
  $B8E9,$02 Decrease #REGb and jump to #R$B8E5 until none remain.
  $B8EB,$01 Switch to the alternate accumulator and flags.
  $B8EC,$01 Step #REGa back.
  $B8ED,$02 Jump to #R$B8DD if the zero flag is clear.
  $B8EF,$01 Bring #REGde back off the stack.
  $B8F0,$05 Return if bit 7 of offset #N$00 of #REGix is clear.
  $B8F5,$05 Return if bit 0 of offset #N$0E of #REGix is clear.
  $B8FA,$01 Advance #REGe.
  $B8FB,$01 Return.

c $B8FC Clear Shot
@ $B8FC label=ClearShot
D $B8FC Clears offsets #N($0B), #N($0C), #N($0E) and #N($0F) of a shot.
R $B8FC IX Address of the shot
  $B8FC,$01 Clear #REGa.
  $B8FD,$03 Write the high byte of the horizontal acceleration.
  $B900,$03 Write the low byte of the horizontal acceleration.
  $B903,$03 Write the high byte of the vertical acceleration.
  $B906,$03 Write the low byte of the vertical acceleration.
  $B909,$01 Return.

c $B90A Start Shot At Ship
@ $B90A label=StartShotAtShip
D $B90A Gives a new shot the position of the ship, and a horizontal speed of
. #N($08) if bit 7 of its type is set or #N($18) if not. Its vertical speed is
. the value at #R$5C38 less the vertical position of the ship.
R $B90A IX Address of the shot
  $B90A,$03 The row the ship was drawn on.
  $B90D,$01 #REGb=#REGa.
  $B90E,$03 The ship row.
  $B911,$01 Subtract #REGb from #REGa.
  $B912,$03 Write the high byte of the vertical speed.
  $B915,$03 Fetch the word at #N$C8E6 into #REGhl.
  $B918,$04 Fetch the word at #N$C8E9 into #REGde.
  $B91C,$03 Write the map column.
  $B91F,$03 Write the horizontal position.
  $B922,$03 Write the map zone.
  $B925,$03 Write the vertical position.
  $B928,$04 Store #N$08 at offset #N$07 of #REGix.
  $B92C,$05 Return if bit 7 of offset #N$00 of #REGix is set.
  $B931,$04 Store #N$18 at offset #N$07 of #REGix.
  $B935,$01 Return.

b $B936 Shot Frame Table
@ $B936 label=ShotFrameTable
D $B936 The table of sprites for type #N($00), which is the type of a shot,
. followed by the two sprites (a width of one byte and three rows each).
. The two bytes after them make a record of a tile that has nothing in it, for
. #R$B946 to return when it finds no tile.
W $B936,$04,$02
B $B93A,$05,$05
B $B93F,$05,$05
@ $B944 label=ShotFrameTable_Records
B $B944,$02,$02

c $B946 Find Tile Record
@ $B946 label=FindTileRecord
D $B946 Looks for the record of the tile at a position of the planet, in the
. four records that are kept at #R$5B80 and then every #N($25) bytes, which are
. for the tile at the map position in #R$CE57 and the ones next to it. If none
. of them match, the address of an empty record is returned.
R $B946 B Map zone
R $B946 D Map column
R $B946 O:IX Address of the record of the tile
R $B946 O:F The zero flag is set if the tile was found
  $B946,$01 #REGe=#REGb.
  $B947,$04 The decryption routine.
  $B94B,$04 Fetch the word at #R$CE57 into #REGbc.
  $B94F,$03 Call #R$B97A.
  $B952,$01 Return if the zero flag is set.
  $B953,$04 Use #N$5BA5.
  $B957,$01 Advance #REGb.
  $B958,$03 Call #R$B97A.
  $B95B,$01 Return if the zero flag is set.
  $B95C,$04 Use #N$5BEF.
  $B960,$01 Advance #REGc.
  $B961,$01 #REGa=#REGc.
  $B962,$04 Jump to #R$B968 if #REGa is not #N$60.
  $B966,$02 Clear #REGc.
@ $B968 label=FindTileRecord_Column
  $B968,$03 Call #R$B97A.
  $B96B,$01 Return if the zero flag is set.
  $B96C,$01 Step #REGb back.
  $B96D,$04 Use #N$5BCA.
  $B971,$03 Call #R$B97A.
  $B974,$01 Return if the zero flag is set.
  $B975,$04 The shot frame records.
  $B979,$01 Return.

c $B97A Compare Tile Position
@ $B97A label=CompareTilePosition
D $B97A Compares a map column and zone with another.
R $B97A B Zone
R $B97A C Column
R $B97A D Column to compare
R $B97A E Zone to compare
R $B97A O:F The zero flag is set if they are the same
  $B97A,$01 #REGa=#REGd.
  $B97B,$02 Return if #REGa is not #REGc.
  $B97D,$01 #REGa=#REGe.
  $B97E,$01 Compare #REGa with #REGb.
  $B97F,$01 Return.

c $B980 Find Horizontal Move
@ $B980 label=FindHorizontalMove
D $B980 Works out the horizontal position of an object after it has moved by
. its horizontal speed, which is wrapped around to the next map column, or the
. previous one, when it goes off the edge of the column. There are #N($60)
. columns.
R $B980 IX Address of the object
R $B980 O:H Map column
R $B980 O:L Horizontal position
R $B980 O:E Fraction of the horizontal position
  $B980,$03 The horizontal position.
  $B983,$03 Read offset #N$03 of #REGix into #REGl.
  $B986,$03 The high byte of the horizontal speed.
  $B989,$03 The low byte of the horizontal speed.
  $B98C,$01 #REGhl gains #REGde.
  $B98D,$01 #REGe=#REGl.
  $B98E,$01 #REGl=#REGh.
  $B98F,$03 The map column.
  $B992,$03 The horizontal position.
  $B995,$01 #REGa=#REGl.
  $B996,$04 Jump to #R$B9AA if bit 7 of #REGd is set.
@ $B99A label=FindHorizontalMove_Right
  $B99A,$04 Jump to #R$B9A0 if #REGa is #N$E8 or more.
  $B99E,$02 Return if #REGa is #REGc or more.
@ $B9A0 label=FindHorizontalMove_Next
  $B9A0,$02 Subtract #N$E0 from #REGa.
  $B9A2,$01 #REGl=#REGa.
  $B9A3,$01 Advance #REGh.
  $B9A4,$01 #REGa=#REGh.
  $B9A5,$02 Subtract #N$60 from #REGa.
  $B9A7,$01 Return if the zero flag is clear.
  $B9A8,$01 #REGh=#REGa.
  $B9A9,$01 Return.
@ $B9AA label=FindHorizontalMove_Left
  $B9AA,$04 Jump to #R$B9B1 if #REGa is less than #N$08.
  $B9AE,$02 Return if #REGa is less than #REGc.
  $B9B0,$01 Return if the zero flag is set.
@ $B9B1 label=FindHorizontalMove_Previous
  $B9B1,$02 Add #N$E0 to #REGa.
  $B9B3,$01 #REGl=#REGa.
  $B9B4,$01 Step #REGh back.
  $B9B5,$01 #REGa=#REGh.
  $B9B6,$01 Advance #REGa.
  $B9B7,$01 Return if the zero flag is clear.
  $B9B8,$02 #REGh=#N$5F.
  $B9BA,$01 Return.

c $B9BB Find Vertical Move
@ $B9BB label=FindVerticalMove
D $B9BB Works out the vertical position of an object after it has moved by
. its vertical speed, in the same way as #R$B980 does for the horizontal
. position. The zone changes when the position goes beyond the limits of
. #N($18) and #N($B8).
R $B9BB IX Address of the object
R $B9BB O:H Map zone
R $B9BB O:L Vertical position
R $B9BB O:E Fraction of the vertical position
  $B9BB,$03 The vertical position.
  $B9BE,$03 Read offset #N$06 of #REGix into #REGl.
  $B9C1,$03 The high byte of the vertical speed.
  $B9C4,$03 The low byte of the vertical speed.
  $B9C7,$01 #REGhl gains #REGde.
  $B9C8,$01 #REGe=#REGl.
  $B9C9,$01 #REGl=#REGh.
  $B9CA,$03 The map zone.
  $B9CD,$03 The vertical position.
  $B9D0,$01 #REGa=#REGl.
  $B9D1,$04 Jump to #R$B9E0 if bit 7 of #REGd is set.
  $B9D5,$04 Jump to #R$B9DB if #REGa is #N$B8 or more.
  $B9D9,$02 Return if #REGa is #REGc or more.
@ $B9DB label=FindVerticalMove_Down
  $B9DB,$02 Subtract #N$A0 from #REGa.
  $B9DD,$01 #REGl=#REGa.
  $B9DE,$01 Advance #REGh.
  $B9DF,$01 Return.
@ $B9E0 label=FindVerticalMove_Up
  $B9E0,$04 Jump to #R$B9E7 if #REGa is less than #N$18.
  $B9E4,$02 Return if #REGa is less than #REGc.
  $B9E6,$01 Return if the zero flag is set.
@ $B9E7 label=FindVerticalMove_Previous
  $B9E7,$02 Add #N$A0 to #REGa.
  $B9E9,$01 #REGl=#REGa.
  $B9EA,$01 Step #REGh back.
  $B9EB,$01 Return.

c $B9EC Set Ship Speeds
@ $B9EC label=SetShipSpeeds
D $B9EC Gives the ship (at #R$C8E5) horizontal and vertical speeds that are
. the opposite of the two scroll speeds, with no fractions. Moving the ship
. at these speeds makes it stay in the same place on the screen.
  $B9EC,$04 The ship.
  $B9F0,$03 The horizontal scroll speed.
  $B9F3,$02 Negate #REGa.
  $B9F5,$03 Write #REGa to offset #N$07 of #REGix.
  $B9F8,$03 The vertical scroll speed.
  $B9FB,$02 Negate #REGa.
  $B9FD,$03 Write #REGa to offset #N$09 of #REGix.
  $BA00,$04 Store #N$00 at offset #N$08 of #REGix.
  $BA04,$04 Store #N$00 at offset #N$0A of #REGix.
  $BA08,$01 Return.
  $BA09,$01 Do nothing.
  $BA0A,$01 Do nothing.

c $BA0B Zero Small Speed
@ $BA0B label=ZeroSmallSpeed
D $BA0B Sets a speed to zero if it is too small to matter. The speed is a
. signed number, which is changed if it is below #N($0064) or above #N($FF58).
R $BA0B HL Speed
R $BA0B O:HL New speed
  $BA0B,$01 #REGa=#REGh.
  $BA0C,$03 Jump to #R$BA17 if #REGa is not zero.
  $BA0F,$01 #REGa=#REGl.
  $BA10,$03 Return if #REGa is #N$64 or more.
  $BA13,$03 #REGhl=#N$00.
  $BA16,$01 Return.
@ $BA17 label=ZeroSmallSpeed_Negative
  $BA17,$01 Advance #REGa.
  $BA18,$01 Return if the zero flag is clear.
  $BA19,$01 #REGa=#REGl.
  $BA1A,$03 Return if #REGa is less than #N$58.
  $BA1D,$03 #REGhl=#N$00.
  $BA20,$01 Return.

c $BA21 Check Terrain Collision
@ $BA21 label=CheckTerrainCollision
D $BA21 Checks whether an object has run into the terrain and bounces it when
. it has. The tiles come from #R$BE8F and #R$BE43. A tile record starts with
. the number of boxes, and each box is five bytes: its position, its width,
. its height and its flags. Bits 2 to 5 clear means a slope (#R$9E35);
. otherwise the box is a rectangle (#R$9DB1). A rectangle with bits 4 and 5
. clear reverses, halves and limits the vertical speed. Any other rectangle
. does the same to the horizontal speed, and skips the halving when the
. collision mode is zero. The mode in #R$5C25 is #N$FF for the ship, #N$80
. when the object should stop, and zero otherwise. The ship also plays the
. crash or bump sound and changes the scroll speed.
R $BA21 B Height of the object
R $BA21 C Width of the object
R $BA21 IX Address of the object
R $BA21 O:$5C1C Non-zero if the object hit something
  $BA21,$01 Clear the hit flag.
  $BA22,$03 The hit flag at #R$5C1C starts clear.
  $BA25,$04 Keep the address of the object.
  $BA29,$03 Find the tiles the object overlaps.
  $BA2C,$02 Test the first of those tiles.
@ $BA2E label=CheckTerrainCollision_NextTiles
  $BA2E,$03 The next overlapping tile.
@ $BA31 label=CheckTerrainCollision_Tile
  $BA31,$03 The number of boxes in this tile.
  $BA34,$03 None: on to the next tile.
  $BA37,$02 The first box of the tile.
@ $BA39 label=CheckTerrainCollision_Box
  $BA39,$02 Keep the address of this box.
  $BA3B,$01 The box count is in the alternate accumulator.
  $BA3C,$01 Clear the hit flag for this box.
  $BA3D,$03 The hit flag starts clear.
  $BA40,$03 The flags of this box.
  $BA43,$03 Keep the flags.
  $BA46,$02,b$01 Bits 2 to 5 mark a rectangle.
  $BA48,$02 A rectangle is tested below.
  $BA4A,$03 Otherwise the box is a slope.
@ $BA4D label=CheckTerrainCollision_Check
  $BA4D,$03 The collision status.
  $BA50,$04 Jump to #R$BA76 if bit 6 of #REGa is set.
@ $BA54 label=CheckTerrainCollision_NextBox
  $BA54,$02 Back to this box.
  $BA56,$03 A box is five bytes.
  $BA59,$02 The next box.
  $BA5B,$01 Back to the box count.
  $BA5C,$01 One box has been tested.
  $BA5D,$02 Repeat while boxes remain.
@ $BA5F label=CheckTerrainCollision_Done
  $BA5F,$03 The tiles still to test.
  $BA62,$01 One tile has been tested.
  $BA63,$03 Remember how many tiles remain.
  $BA66,$03 Jump to #R$BA2E if the zero flag is clear.
  $BA69,$04 Fetch the word at #R$BA09 into #REGix.
  $BA6D,$03 The collision mode.
  $BA70,$01 The ship is mode #N$FF, which becomes zero here.
  $BA71,$01 Return if the zero flag is clear.
  $BA72,$03 The ship has finished this check.
  $BA75,$01 Return.
@ $BA76 label=CheckTerrainCollision_Stop
  $BA76,$03 The ship state.
  $BA79,$04 Jump to #R$BA86 if #REGa is less than #N$0A.
  $BA7D,$03 The collision mode.
  $BA80,$03 Jump to #R$BA86 if #REGa is not zero.
  $BA83,$03 Jump to #R$BA54.
@ $BA86 label=CheckTerrainCollision_Return
  $BA86,$02 Discard the box address.
  $BA88,$04 Fetch the word at #R$BA09 into #REGix.
  $BA8C,$01 Return.
  $BA8D,$01 Do nothing.
  $BA8E,$01 Do nothing.
@ $BA8F label=CheckTerrainCollision_Rectangle
  $BA8F,$03 The collision status.
  $BA92,$05 Jump to #R$BA4D if bit 7 of #REGa is set.
  $BA97,$03 Fetch the word at #R$CE3A into #REGhl.
  $BA9A,$03 The collision mode.
  $BA9D,$04 Jump to #R$BB0D if #REGa is #N$80.
  $BAA1,$03 The collision mode again.
  $BAA4,$01 The ship is the only object tested here.
  $BAA5,$03 Jump to #R$BADE if the zero flag is clear.
  $BAA8,$01 The low byte of the position in the tile.
  $BAA9,$02 Add #N$04 to #REGa.
  $BAAB,$04 Jump to #R$BAB1 if #REGa is less than #N$E8.
  $BAAF,$02 Do not test past column #N$E8.
@ $BAB1 label=CheckTerrainCollision_Limit
  $BAB1,$01 The near edge of the test.
  $BAB2,$02 Add #N$24 to #REGa.
  $BAB4,$02 Jump to #R$BAB8 if the carry flag is clear.
  $BAB6,$02 Do not test past column #N$F8.
@ $BAB8 label=CheckTerrainCollision_Lower
  $BAB8,$01 The far edge of the test.
  $BAB9,$06 Jump to #R$BADE if bit 2 of offset #N$04 of #REGix is clear.
  $BABF,$03 The second part flag.
  $BAC2,$03 Jump to #R$BADE if #REGa is not zero.
  $BAC5,$03 The box's other coordinate.
  $BAC8,$01 Subtract #REGh from #REGa.
  $BAC9,$02 Jump to #R$BADE if the carry flag is set.
  $BACB,$04 Jump to #R$BADE if #REGa is #N$29 or more.
  $BACF,$03 The box's first coordinate.
  $BAD2,$03 Jump to #R$BADE if #REGa is #REGe or more.
  $BAD5,$03 Add the byte at offset #N$02 of #REGix to #REGa.
  $BAD8,$03 Jump to #R$BADE if #REGa is less than #REGd.
  $BADB,$03 The ship has landed on this box.
@ $BADE label=CheckTerrainCollision_Flags
  $BADE,$03 The box flags.
  $BAE1,$02,b$01 Bits 4 and 5 select a sideways face.
  $BAE3,$02 Jump to #R$BAFA if the zero flag is clear.
  $BAE5,$03 The saved vertical speed.
  $BAE8,$03 Jump to #R$BB0D if #REGa is zero.
  $BAEB,$06 Jump to #R$BAF3 if bit 2 of offset #N$04 of #REGix is set.
  $BAF1,$02 Negate #REGa.
@ $BAF3 label=CheckTerrainCollision_Skip
  $BAF3,$05 Jump to #R$BA4D if bit 7 of #REGa is set.
  $BAF8,$02 Jump to #R$BB0D.
@ $BAFA label=CheckTerrainCollision_Test2
  $BAFA,$02 Test bit 4 of #REGa.
  $BAFC,$03 The saved horizontal speed.
  $BAFF,$02 Jump to #R$BB03 if the zero flag is clear.
  $BB01,$02 Negate #REGa.
@ $BB03 label=CheckTerrainCollision_Check2
  $BB03,$03 Jump to #R$BB0D if #REGa is zero.
  $BB06,$05 Jump to #R$BA4D if bit 7 of #REGa is clear.
  $BB0B,$02 Jump to #R$BB0D.
@ $BB0D label=CheckTerrainCollision_Test
  $BB0D,$04 Fetch the word at #R$CE3C into #REGde.
  $BB11,$03 Call #R$9DB1.
  $BB14,$03 The hit flag from the rectangle test.
  $BB17,$04 Jump to #R$BA4D if #REGa is zero.
  $BB1B,$03 The collision mode.
  $BB1E,$05 Jump to #R$BA76 if #REGa is #N$80.
  $BB23,$02 A rectangle hit is marked with #N$80.
  $BB25,$03 Remember that hit in the collision status.
  $BB28,$03 The box's second coordinate.
  $BB2B,$02 Subtract #N$14 from #REGa.
  $BB2D,$03 Keep that coordinate.
  $BB30,$03 The box flags again.
  $BB33,$03 Keep the box flags.
  $BB36,$01 The flags, kept for the bounce.
  $BB37,$02,b$01 Bits 4 and 5 mean the face is sideways.
  $BB39,$04 Fetch the word at #R$BA09 into #REGix.
  $BB3D,$03 Jump to #R$BBCD if the zero flag is clear.
  $BB40,$03 The collision mode.
  $BB43,$03 Jump to #R$BB57 if #REGa is zero.
  $BB46,$04 Jump to #R$BB64 if bit 3 of #REGb is clear.
  $BB4A,$03 The ninth part flag.
  $BB4D,$03 Jump to #R$BB64 if #REGa is not zero.
  $BB50,$02 Four frames of the hit flash.
  $BB52,$03 Start the hit flash.
  $BB55,$02 Jump to #R$BB64.
@ $BB57 label=CheckTerrainCollision_Free
  $BB57,$03 Call #R$B8FC.
  $BB5A,$04 Jump to #R$BB64 if bit 3 of #REGb is set.
  $BB5E,$03 The coordinate the object should stand on.
  $BB61,$03 Put the object on that row.
@ $BB64 label=CheckTerrainCollision_Vertical
  $BB64,$03 The high byte of the vertical speed.
  $BB67,$03 The low byte of the vertical speed.
  $BB6A,$03 Call #R$BE08.
  $BB6D,$03 Call #R$BE03.
  $BB70,$03 Call #R$C880.
  $BB73,$03 Call #R$BA0B.
@ $BB76 label=CheckTerrainCollision_StoreVertical
  $BB76,$03 The bounced vertical speed.
  $BB79,$03 The low byte of the bounced vertical speed.
  $BB7C,$01 The high byte of that speed.
  $BB7D,$03 Keep it for the next box.
  $BB80,$01 Set the bits of #REGa that are set in #REGl.
  $BB81,$02 Jump to #R$BB8D if the zero flag is set.
  $BB83,$03 The collision status.
  $BB86,$02,b$01 Set the bits of #REGa that are set in #N$40.
  $BB88,$03 Note that the object is still moving vertically.
  $BB8B,$02 Jump to #R$BB9C.
@ $BB8D label=CheckTerrainCollision_Still
  $BB8D,$03 The collision mode.
  $BB90,$01 See whether this is the ship.
  $BB91,$02 Jump to #R$BB9C if the zero flag is set.
  $BB93,$05 Jump to #R$BA4D if bit 3 of #REGb is clear.
  $BB98,$04 Store #N$FE at offset #N$09 of #REGix.
@ $BB9C label=CheckTerrainCollision_Ship
  $BB9C,$03 The collision mode.
  $BB9F,$01 The ship is mode #N$FF.
  $BBA0,$03 Jump to #R$BA4D if the zero flag is clear.
  $BBA3,$01 The low byte of the bounced speed.
  $BBA4,$01 Set the bits of #REGa that are set in #REGh.
  $BBA5,$03 Call #R$7293 if the zero flag is clear.
  $BBA8,$03 No fractional vertical scroll.
  $BBAB,$04 Clear the vertical scroll fraction.
  $BBAF,$03 Call #R$B2D5.
  $BBB2,$03 The box flags that were hit.
  $BBB5,$05 Jump to #R$BA4D if #REGa is not #N$04.
  $BBBA,$03 The ship's map zone.
  $BBBD,$01 Keep the map zone.
  $BBBE,$03 The box coordinate.
  $BBC1,$04 Jump to #R$BA4D if #REGa is #REGb or more.
  $BBC5,$02 A small downward scroll.
  $BBC7,$03 Scroll the world down by two.
  $BBCA,$03 Jump to #R$BA4D.
@ $BBCD label=CheckTerrainCollision_Wall
  $BBCD,$03 The high byte of the horizontal speed.
  $BBD0,$03 The low byte of the horizontal speed.
  $BBD3,$03 Call #R$BE08.
  $BBD6,$03 The collision mode.
  $BBD9,$03 Jump to #R$BBE1 if #REGa is not zero.
  $BBDC,$03 Call #R$B8FC.
  $BBDF,$02 Jump to #R$BBEA.
@ $BBE1 label=CheckTerrainCollision_Update
  $BBE1,$03 Call #R$BE03.
  $BBE4,$03 Call #R$C880.
  $BBE7,$03 Call #R$BA0B.
@ $BBEA label=CheckTerrainCollision_StoreHorizontal
  $BBEA,$03 The bounced horizontal speed.
  $BBED,$03 The low byte of the bounced horizontal speed.
  $BBF0,$01 The high byte of that speed.
  $BBF1,$03 Keep it for the next box.
  $BBF4,$03 The collision mode.
  $BBF7,$01 The ship is mode #N$FF.
  $BBF8,$03 Jump to #R$BA4D if the zero flag is clear.
  $BBFB,$01 The low byte of the bounced speed.
  $BBFC,$01 Set the bits of #REGa that are set in #REGh.
  $BBFD,$03 Call #R$7263 if the zero flag is clear.
  $BC00,$03 No fractional horizontal scroll.
  $BC03,$04 Clear the horizontal scroll fraction.
  $BC07,$03 Call #R$C81F.
  $BC0A,$02 The ship has hit a wall.
  $BC0C,$03 The collision kind is the terrain.
  $BC0F,$03 Jump to #R$BA4D.
  $BC12,$01 Do nothing.
@ $BC13 label=CheckTerrainCollision_Slope
  $BC13,$03 The collision status.
  $BC16,$05 Jump to #R$BA4D if bit 4 of #REGa is set.
  $BC1B,$03 Call #R$9E35.
  $BC1E,$03 The hit flag from the slope test.
  $BC21,$04 Jump to #R$BA4D if #REGa is zero.
  $BC25,$03 The collision status.
  $BC28,$02,b$01 Set the bits of #REGa that are set in #N$10.
  $BC2A,$03 Note that a slope has been hit.
  $BC2D,$03 The collision mode.
  $BC30,$05 Jump to #R$BA76 if #REGa is #N$80.
  $BC35,$03 Jump to #R$BC3C if #REGa is zero.
  $BC38,$01 One less than the mode.
  $BC39,$03 The collision kind follows the mode.
@ $BC3C label=CheckTerrainCollision_Kind
  $BC3C,$03 The slope flags.
  $BC3F,$03 Keep the slope flags.
  $BC42,$02,b$01 The steepness and the facing, without bit 7.
  $BC44,$05 Jump to #R$BD04 if #REGa is #N$02.
  $BC49,$02,b$01 The steepness.
  $BC4B,$05 Jump to #R$BD3B if #REGa is #N$02.
  $BC50,$03 The slope flags again.
  $BC53,$05 Jump to #R$BD44 if bit 6 of #REGa is clear.
  $BC58,$03 Jump to #R$BDBD.
@ $BC5B label=CheckTerrainCollision_Bounce
  $BC5B,$04 Fetch the word at #R$BA09 into #REGix.
  $BC5F,$03 The collision mode.
  $BC62,$01 See whether this is the ship.
  $BC63,$02 Jump to #R$BC9A if the zero flag is set.
  $BC65,$03 The high byte of the horizontal speed, kept in #REGl.
  $BC68,$03 The low byte of the horizontal speed, kept in #REGh.
  $BC6B,$03 Keep the old horizontal speed.
  $BC6E,$03 How far the object went into the slope.
  $BC71,$02 Negate #REGa.
  $BC73,$03 The horizontal speed becomes that depth, reversed.
  $BC76,$04 Jump to #R$BC7C if bit 7 of #REGa is clear.
  $BC7A,$02 Negate #REGa.
@ $BC7C label=CheckTerrainCollision_Speed
  $BC7C,$04 Jump to #R$BC84 if #REGa is less than #N$10.
  $BC80,$04 Set bit 3 of offset #N$10 of #REGix.
@ $BC84 label=CheckTerrainCollision_Position
  $BC84,$04 Store #N$00 at offset #N$08 of #REGix.
  $BC88,$03 Call #R$B980.
  $BC8B,$03 The map column after the bounce.
  $BC8E,$03 The horizontal position after the bounce.
  $BC91,$03 Fetch the word at #R$BA8D into #REGhl.
  $BC94,$03 Restore the high byte of the old horizontal speed.
  $BC97,$03 Restore the low byte of the old horizontal speed.
@ $BC9A label=CheckTerrainCollision_Clear
  $BC9A,$03 Call #R$B8FC.
  $BC9D,$03 The high byte of the vertical speed.
  $BCA0,$03 The low byte of the vertical speed.
  $BCA3,$03 Call #R$BA0B.
  $BCA6,$01 The low byte of the vertical speed.
  $BCA7,$01 Set the bits of #REGa that are set in #REGh.
  $BCA8,$02 Jump to #R$BCD1 if the zero flag is clear.
  $BCAA,$03 The high byte of the horizontal speed.
  $BCAD,$03 The low byte of the horizontal speed.
  $BCB0,$03 Call #R$BA0B.
  $BCB3,$03 The low byte, once a tiny speed has been dropped.
  $BCB6,$01 The high byte of the horizontal speed.
  $BCB7,$01 Set the bits of #REGa that are set in #REGl.
  $BCB8,$02 Jump to #R$BCD1 if the zero flag is clear.
  $BCBA,$03 Call #R$BCBF.
  $BCBD,$02 Jump to #R$BCD1.
@ $BCBF label=CheckTerrainCollision_Flags2
  $BCBF,$03 The slope flags.
  $BCC2,$04 Store #N$01 at offset #N$07 of #REGix.
  $BCC6,$02,b$01 The two facing bits.
  $BCC8,$01 Return if the zero flag is set.
  $BCC9,$02,b$01 Flip the bits of #REGa that are set in #N$C0.
  $BCCB,$01 Return if the zero flag is set.
  $BCCC,$04 Store #N$FF at offset #N$07 of #REGix.
  $BCD0,$01 Return.
@ $BCD1 label=CheckTerrainCollision_Finish
  $BCD1,$03 The collision mode.
  $BCD4,$04 Jump to #R$BA76 if #REGa is zero.
  $BCD8,$01 Clear #REGa.
  $BCD9,$03 Stop the horizontal scroll.
  $BCDC,$03 Stop the vertical scroll.
  $BCDF,$03 The ship was just hit.
  $BCE2,$03 Jump to #R$BCEC if #REGa is not zero.
  $BCE5,$03 The terrain-check flag.
  $BCE8,$04 Call #R$7263 if #REGa is zero.
@ $BCEC label=CheckTerrainCollision_Pending
  $BCEC,$03 The terrain-check flag.
  $BCEF,$03 Jump to #R$BCFC if #REGa is zero.
  $BCF2,$03 Call #R$BCBF.
  $BCF5,$03 The high byte of the horizontal speed.
  $BCF8,$01 Twice that speed.
  $BCF9,$03 The scroll follows the bounce.
@ $BCFC label=CheckTerrainCollision_Set
  $BCFC,$02 The check is finished.
  $BCFE,$03 Mark the check as finished.
  $BD01,$03 Jump to #R$BA76.
@ $BD04 label=CheckTerrainCollision_Reflect
  $BD04,$01 Clear #REGa.
@ $BD05 label=CheckTerrainCollision_Patch
  $BD05,$03 Choose whether the first speed is reversed.
  $BD08,$03 Choose whether the second speed is reversed.
  $BD0B,$04 Fetch the word at #R$BA09 into #REGix.
  $BD0F,$03 The high byte of the horizontal speed.
  $BD12,$03 The low byte of the horizontal speed.
@ $BD15 label=CheckTerrainCollision_PatchFirst
  $BD15,$02 Jump to #R$BD15.
  $BD17,$03 Call #R$BD3F.
  $BD1A,$03 Call #R$C880.
  $BD1D,$01 Swap #REGde and #REGhl.
  $BD1E,$03 The high byte of the vertical speed.
  $BD21,$03 The low byte of the vertical speed.
  $BD24,$03 The vertical speed takes the adjusted horizontal speed.
  $BD27,$03 The low byte of that new vertical speed.
@ $BD2A label=CheckTerrainCollision_PatchSecond
  $BD2A,$02 Jump to #R$BD2A.
  $BD2C,$03 Call #R$BD3F.
@ $BD2F label=CheckTerrainCollision_Horizontal
  $BD2F,$03 Call #R$C880.
  $BD32,$03 The horizontal speed takes the adjusted vertical speed.
  $BD35,$03 The low byte of that new horizontal speed.
  $BD38,$03 Jump to #R$BC5B.
@ $BD3B label=CheckTerrainCollision_Three
  $BD3B,$02 Steepness two does not reverse the speeds.
  $BD3D,$02 Jump to #R$BD05.
@ $BD3F label=CheckTerrainCollision_Negate
  $BD3F,$01 The high byte of the speed.
  $BD40,$02 Negate #REGa.
  $BD42,$01 The speed is reversed.
  $BD43,$01 Return.
@ $BD44 label=CheckTerrainCollision_Rebound
  $BD44,$01 Clear #REGa.
  $BD45,$03 Choose whether this speed is reversed.
  $BD48,$03 Choose whether the other speed is reversed.
@ $BD4B label=CheckTerrainCollision_ReboundStart
  $BD4B,$03 The slope flags.
  $BD4E,$01 Keep the slope flags.
  $BD4F,$02,b$01 The steepness.
  $BD51,$01 Keep the steepness.
  $BD52,$04 Fetch the word at #R$BA09 into #REGix.
  $BD56,$05 Call #R$BDD8 if #REGa is #N$03.
  $BD5B,$03 The high byte of the horizontal speed.
  $BD5E,$03 The low byte of the horizontal speed.
  $BD61,$03 Call #R$BDF1.
  $BD64,$03 Three eighths of the horizontal speed.
  $BD67,$03 The horizontal speed again.
  $BD6A,$03 The low byte again.
  $BD6D,$03 Call #R$BDFE.
  $BD70,$03 Call #R$BDF1.
@ $BD73 label=CheckTerrainCollision_PatchThird
  $BD73,$02 Jump to #R$BD73.
  $BD75,$03 Call #R$BDC8.
  $BD78,$03 The adjusted fraction of the doubled horizontal speed.
  $BD7B,$03 The high byte of the vertical speed.
  $BD7E,$03 The low byte of the vertical speed.
  $BD81,$03 Call #R$BDF1.
@ $BD84 label=CheckTerrainCollision_PatchFourth
  $BD84,$02 Jump to #R$BD84.
  $BD86,$03 Call #R$BDC8.
  $BD89,$04 Fetch the word at #N$5C15 into #REGde.
  $BD8D,$01 Add the saved fraction of the horizontal speed.
  $BD8E,$03 Call #R$C880.
  $BD91,$03 The new horizontal speed.
  $BD94,$03 The low byte of the new horizontal speed.
  $BD97,$03 The vertical speed.
  $BD9A,$03 The low byte of the vertical speed.
  $BD9D,$03 Call #R$BDFE.
  $BDA0,$03 Call #R$BDF1.
  $BDA3,$03 Call #R$BDC8.
  $BDA6,$04 Fetch the word at #N$5C17 into #REGde.
  $BDAA,$01 Add the saved fraction of the doubled horizontal speed.
  $BDAB,$03 Call #R$C880.
  $BDAE,$03 The new vertical speed.
  $BDB1,$03 The low byte of the new vertical speed.
  $BDB4,$01 Back to the steepness.
  $BDB5,$05 Call #R$BDD8 if #REGa is #N$03.
  $BDBA,$03 Jump to #R$BC5B.
@ $BDBD label=CheckTerrainCollision_ReboundBoth
  $BDBD,$02 This facing does not reverse the speeds.
  $BDBF,$03 This facing skips the first reverse.
  $BDC2,$03 This facing skips the second reverse.
  $BDC5,$03 Jump to #R$BD4B.
@ $BDC8 label=CheckTerrainCollision_ReboundNegate
  $BDC8,$05 Jump to #R$BE08 if bit 7 of #REGc is set.
  $BDCD,$01 The slope flags.
  $BDCE,$02,b$01 The steepness.
  $BDD0,$05 Jump to #R$BE08 if #REGa is #N$03.
  $BDD5,$03 Jump to #R$BD3F.
@ $BDD8 label=SwapSpeeds
  $BDD8,$03 The high byte of the horizontal speed.
  $BDDB,$03 The low byte of the horizontal speed.
  $BDDE,$03 The high byte of the vertical speed.
  $BDE1,$03 The low byte of the vertical speed.
  $BDE4,$03 Swap the speeds: horizontal takes the vertical.
  $BDE7,$03 The low byte of the new horizontal speed.
  $BDEA,$03 Vertical takes the old horizontal speed.
  $BDED,$03 The low byte of the new vertical speed.
  $BDF0,$01 Return.

c $BDF1 Take Three Eighths
@ $BDF1 label=TakeThreeEighths
D $BDF1 Divides a signed number by eight and by four, and adds the two
. results.
R $BDF1 HL Number
R $BDF1 O:HL Three eighths of the number
  $BDF1,$03 Call #R$BE03.
  $BDF4,$03 Call #R$BE03.
  $BDF7,$01 Stash #REGhl on the stack.
  $BDF8,$01 Bring #REGde back off the stack.
  $BDF9,$03 Call #R$BE03.
  $BDFC,$01 #REGhl gains #REGde.
  $BDFD,$01 Return.

c $BDFE Double Number
@ $BDFE label=DoubleNumber
D $BDFE Multiplies a number by two.
R $BDFE HL Number
R $BDFE O:HL Number multiplied by two
  $BDFE,$02 Shift #REGl left.
@ $BE00 label=DoubleNumber_Rotate
  $BE00,$02 Rotate #REGh left through the carry.
  $BE02,$01 Return.

c $BE03 Halve Number
@ $BE03 label=HalveNumber
D $BE03 Divides a signed number by two.
R $BE03 HL Number
R $BE03 O:HL Number divided by two
  $BE03,$02 Shift #REGh right keeping the sign.
  $BE05,$02 Rotate #REGl right through the carry.
  $BE07,$01 Return.

c $BE08 Negate Number
@ $BE08 label=NegateNumber
D $BE08 Changes the sign of a signed number.
R $BE08 HL Number
R $BE08 O:HL Number with the sign changed
  $BE08,$01 #REGa=#REGh.
  $BE09,$01 Invert #REGa.
  $BE0A,$01 #REGh=#REGa.
  $BE0B,$01 #REGa=#REGl.
  $BE0C,$01 Invert #REGa.
  $BE0D,$01 #REGl=#REGa.
  $BE0E,$01 Advance #REGhl.
  $BE0F,$01 Return.

c $BE10 Select Previous Zone
@ $BE10 label=SelectPreviousZone
D $BE10 Sets the tile to look at next to the one in the zone above the current
. one, at the bottom of it, for #R$BE43.
  $BE10,$03 The object reaches into the zone above.
  $BE13,$03 Update the segment screen row.
  $BE16,$03 Fetch the word at #R$5C30 into #REGhl.
  $BE19,$01 Step #REGh back.
  $BE1A,$02 #REGl=#N$B7.
  $BE1C,$03 The tile in the zone above, at its bottom.
  $BE1F,$03 The segment column.
  $BE22,$03 Update the segment screen column.
  $BE25,$01 Return.

c $BE26 Select Next Column
@ $BE26 label=SelectNextColumn
D $BE26 Sets the tile to look at next to the one in the column to the right of
. the current one, at the left of it, for #R$BE43. The column goes round to zero
. after #N($5F).
  $BE26,$03 The object reaches into the next column.
  $BE29,$03 Update the segment screen column.
  $BE2C,$03 Fetch the word at #R$5C2E into #REGhl.
  $BE2F,$01 Advance #REGh.
  $BE30,$01 #REGa=#REGh.
  $BE31,$04 Jump to #R$BE37 if #REGa is not #N$60.
  $BE35,$02 Clear #REGh.
@ $BE37 label=SelectNextColumn_Store
  $BE37,$02 #REGl=#N$08.
  $BE39,$03 Update the tile position.
  $BE3C,$03 The segment row.
  $BE3F,$03 Update the segment screen row.
  $BE42,$01 Return.

c $BE43 Select Next Tile
@ $BE43 label=SelectNextTile
D $BE43 Chooses the next tile for #R$BA21 to check the object against, from the
. tiles that the object overlaps and the count in #R$5C1D, then carries on at
. #R$BEE7.
  $BE43,$03 The tiles still to test.
  $BE46,$04 Jump to #R$BE65 if #REGa is not #N$01.
  $BE4A,$03 The object reaches into the next column.
  $BE4D,$03 Jump to #R$BE65 if #REGa is zero.
  $BE50,$03 The object reaches into the zone above.
  $BE53,$03 Jump to #R$BE65 if #REGa is zero.
  $BE56,$03 Call #R$BE10.
  $BE59,$03 Call #R$BE26.
  $BE5C,$03 The object reaches into the zone above.
  $BE5F,$03 Update the segment screen row.
  $BE62,$03 Jump to #R$BEE7.
@ $BE65 label=SelectNextTile_Column
  $BE65,$03 The object reaches into the next column.
  $BE68,$03 Jump to #R$BE81 if #REGa is zero.
  $BE6B,$03 The slope direction.
  $BE6E,$03 Jump to #R$BE81 if #REGa is zero.
  $BE71,$01 Clear #REGa.
  $BE72,$03 Update the slope direction.
  $BE75,$03 Call #R$BE26.
  $BE78,$03 Fetch the word at #R$5C30 into #REGhl.
  $BE7B,$03 The vertical position of the next tile.
  $BE7E,$03 Jump to #R$BEE7.
@ $BE81 label=SelectNextTile_Current
  $BE81,$03 Call #R$BE10.
  $BE84,$03 Fetch the word at #R$5C2E into #REGhl.
  $BE87,$03 Update the tile position.
  $BE8A,$03 Jump to #R$BEE7.
  $BE8D,$01 Do nothing.
  $BE8E,$01 Do nothing.

c $BE8F Start Terrain Check
@ $BE8F label=StartTerrainCheck
D $BE8F Sets up #R$BA21: keeps the size of the object in #R$CE43 and clears the
. working values, finds where the object will be after it has moved by its
. speeds using #R$B980 and #R$B9BB, and keeps its speeds. Carries on at
. #R$BEE7.
E $BE8F Continue on to #R$BEE7.
R $BE8F BC Size of the object
R $BE8F IX Address of the object
  $BE8F,$04 Update the segment column.
  $BE93,$01 Clear #REGa.
  $BE94,$03 The object does not reach the next column.
  $BE97,$03 The object does not reach the zone above.
  $BE9A,$03 Update the tiles still to test.
  $BE9D,$03 Update the collision status.
  $BEA0,$03 Update the slope direction.
  $BEA3,$03 Call #R$B980.
  $BEA6,$03 Update the tile position.
  $BEA9,$03 Update the piece column.
  $BEAC,$03 Call #R$B9BB.
  $BEAF,$03 The vertical position after the move.
  $BEB2,$03 Update the back to front flag.
  $BEB5,$03 The collision mode.
  $BEB8,$01 Advance #REGa.
  $BEB9,$02 Jump to #R$BEC1 if the zero flag is set.
  $BEBB,$01 Step #REGa back.
  $BEBC,$03 Call #R$90CD if the zero flag is set.
  $BEBF,$02 Jump to #R$BECD.
@ $BEC1 label=StartTerrainCheck_Ship
  $BEC1,$03 Fetch the word at #N$C8FE into #REGhl.
  $BEC4,$03 Update the high byte of the ship's horizontal speed.
  $BEC7,$03 Fetch the word at #N$C900 into #REGhl.
  $BECA,$03 Update the high byte of the ship's vertical speed.
@ $BECD label=StartTerrainCheck_Speeds
  $BECD,$03 Read offset #N$07 of #REGix.
  $BED0,$03 Update the saved horizontal speed.
  $BED3,$03 Read offset #N$09 of #REGix.
  $BED6,$02 Negate #REGa.
  $BED8,$03 Update the saved vertical speed.
  $BEDB,$03 The segment column.
  $BEDE,$03 Update the segment screen column.
  $BEE1,$03 The segment row.
  $BEE4,$03 Update the segment screen row.

c $BEE7 Find Tiles Overlapped
@ $BEE7 label=FindTilesOverlapped
D $BEE7 Finds the tile record for the position of the object using
. #R$B946, works out where the object is within the tile and stores
. it in #R$CE3A to #R$CE3D and counts the tiles that it overlaps (up to four)
. in #R$5C1D.
  $BEE7,$04 Fetch the word at #R$BF81 into #REGbc.
  $BEEB,$04 Fetch the word at #R$BF7F into #REGde.
  $BEEF,$03 Call #R$B946.
  $BEF2,$03 The tile position.
  $BEF5,$01 #REGc=#REGa.
  $BEF6,$03 The segment screen column.
  $BEF9,$01 #REGb=#REGa.
  $BEFA,$01 #REGa=#REGc.
  $BEFB,$02 Add #N$18 to #REGa.
  $BEFD,$01 #REGa gains #REGb.
  $BEFE,$01 #REGe=#REGb.
  $BEFF,$02 Jump to #R$BF15 if the carry flag is clear.
  $BF01,$01 #REGb=#REGa.
  $BF02,$03 The tiles still to test.
  $BF05,$03 Jump to #R$BF11 if #REGa is not zero.
  $BF08,$01 #REGa=#REGb.
  $BF09,$03 The object reaches into the next column.
  $BF0C,$02 #REGa=#N$01.
  $BF0E,$03 Update the slope direction.
@ $BF11 label=FindTilesOverlapped_Right
  $BF11,$02 #REGa=#N$E8.
  $BF13,$01 Subtract #REGc from #REGa.
  $BF14,$01 #REGe=#REGa.
@ $BF15 label=FindTilesOverlapped_Horizontal
  $BF15,$01 #REGa=#REGe.
  $BF16,$03 The horizontal edge in the tile.
  $BF19,$01 #REGa=#REGc.
  $BF1A,$03 The horizontal position in the tile.
  $BF1D,$03 The vertical position.
  $BF20,$01 #REGc=#REGa.
  $BF21,$03 The segment screen row.
  $BF24,$01 #REGb=#REGa.
  $BF25,$01 #REGa=#REGc.
  $BF26,$02 Subtract #N$17 from #REGa.
  $BF28,$01 Subtract #REGb from #REGa.
  $BF29,$01 #REGe=#REGb.
  $BF2A,$02 Jump to #R$BF3D if the carry flag is clear.
  $BF2C,$01 #REGb=#REGa.
  $BF2D,$03 The tiles still to test.
  $BF30,$03 Jump to #R$BF39 if #REGa is not zero.
  $BF33,$01 #REGa=#REGb.
  $BF34,$02 Negate #REGa.
  $BF36,$03 The object reaches into the zone above.
@ $BF39 label=FindTilesOverlapped_Up
  $BF39,$01 #REGa=#REGc.
  $BF3A,$02 Subtract #N$17 from #REGa.
  $BF3C,$01 #REGe=#REGa.
@ $BF3D label=FindTilesOverlapped_Vertical
  $BF3D,$01 #REGa=#REGe.
  $BF3E,$03 The vertical edge in the tile.
  $BF41,$01 #REGa=#REGc.
  $BF42,$03 The vertical position in the tile.
  $BF45,$03 The tiles still to test.
  $BF48,$02 Return if #REGa is not zero.
  $BF4A,$02 #REGb=#N$01.
  $BF4C,$03 The object reaches into the next column.
  $BF4F,$03 Jump to #R$BF5A if #REGa is zero.
  $BF52,$01 Advance #REGb.
  $BF53,$03 The object reaches into the zone above.
  $BF56,$03 Jump to #R$BF5A if #REGa is zero.
  $BF59,$01 Advance #REGb.
@ $BF5A label=FindTilesOverlapped_Count
  $BF5A,$03 The object reaches into the zone above.
  $BF5D,$03 Jump to #R$BF61 if #REGa is zero.
  $BF60,$01 Advance #REGb.
@ $BF61 label=FindTilesOverlapped_Return
  $BF61,$01 #REGa=#REGb.
  $BF62,$03 Update the tiles still to test.
  $BF65,$01 Return.

c $BF66 Move Object
@ $BF66 label=MoveObject
D $BF66 Moves an object by its speeds: the horizontal position with
. #R$B980 and the vertical position with #R$B9BB.
R $BF66 IX Address of the object
  $BF66,$03 Call #R$B980.
  $BF69,$03 Write the map column.
  $BF6C,$03 Write the horizontal position.
  $BF6F,$03 Write #REGe to offset #N$03 of #REGix.
  $BF72,$03 Call #R$B9BB.
  $BF75,$03 Write the map zone.
  $BF78,$03 Write the vertical position.
  $BF7B,$03 Write #REGe to offset #N$06 of #REGix.
  $BF7E,$01 Return.

g $BF7F Tile Position
@ $BF7F label=TilePosition
D $BF7F Used while checking the terrain: the map column and horizontal position
. of the object, then its map zone and vertical position, then a third
. position that is used by #R$BF85.
W $BF7F,$02,$02
W $BF81,$02,$02
W $BF83,$02,$02

c $BF85 Select Mirrored Erase
@ $BF85 label=SelectMirroredErase
D $BF85 Used when the ship is erased. If it is facing left (bit 7 of
. #N$C8FD or of #REGa if entered at #R$BF88) the horizontal position is
. moved to the other side of the sprite by its width in #R$5C28 and #REGiy
. is pointed at the routine for the width in the table at #R$A7A4, which
. erases a mirrored sprite.
R $BF85 HL' Position (if entered at #R$BF88)
R $BF85 O:IY Address of the routine
  $BF85,$03 The ship's facing.
@ $BF88 label=SelectMirroredErase_Entry
  $BF88,$03 Fetch the word at #R$BF83 into #REGhl.
  $BF8B,$03 Return if bit 7 of #REGa is clear.
  $BF8E,$02 #REGb=#N$F9.
  $BF90,$03 The sprite width in bytes.
  $BF93,$01 Step #REGa back.
  $BF94,$01 Double #REGa.
  $BF95,$01 Double #REGa.
  $BF96,$01 Double #REGa.
  $BF97,$01 #REGa gains #REGl.
  $BF98,$03 The column on the other side of the sprite.
  $BF9B,$03 The sprite width in bytes.
  $BF9E,$04 The erase mirrored row directly.
  $BFA2,$03 Return if #REGa is #N$06.
  $BFA5,$04 The second mirrored-row erase.
  $BFA9,$03 Return if #REGa is #N$05.
  $BFAC,$04 The third mirrored-row erase.
  $BFB0,$03 Return if #REGa is #N$04.
  $BFB3,$04 The fourth mirrored-row erase.
  $BFB7,$01 Return.

c $BFB8 Select Mirrored Draw
@ $BFB8 label=SelectMirroredDraw
D $BFB8 Used when the ship is drawn. If it is facing left, moves the
. horizontal position to the other side of the sprite by its width in
. #R$5C29 and points #REGix at the routine for the width in the table at
. #R$A7D6, which draws a mirrored sprite.
R $BFB8 HL Position
R $BFB8 O:IX Address of the routine
  $BFB8,$03 The ship's facing.
  $BFBB,$03 Return if bit 7 of #REGa is clear.
  $BFBE,$02 #REGb=#N$F9.
  $BFC0,$03 The sprite width in bytes.
  $BFC3,$01 Step #REGa back.
  $BFC4,$01 #REGa gains #REGl.
  $BFC5,$01 #REGl=#REGa.
  $BFC6,$03 The sprite width in bytes.
  $BFC9,$04 The draw mirrored row directly.
  $BFCD,$03 Return if #REGa is #N$06.
  $BFD0,$04 The second mirrored-row draw.
  $BFD4,$03 Return if #REGa is #N$05.
  $BFD7,$04 The third mirrored-row draw.
  $BFDB,$03 Return if #REGa is #N$04.
  $BFDE,$04 The fourth mirrored-row draw.
  $BFE2,$01 Return.

c $BFE3 Update Stars
@ $BFE3 label=UpdateStars
D $BFE3 Moves and draws the stars in the sky, in three layers of six stars.
. Only does anything when the ship is in one of the four zones at the top of
. the planet. The stars in the nearer layers move faster than the ones in the
. further layers when the screen scrolls, and are bigger. This is a best
. reading of the code.
  $BFE3,$03 The map row.
  $BFE6,$03 Return if #REGa is #N$04 or more.
  $BFE9,$03 #REGbc=#N$06.
  $BFEC,$03 The star offsets.
  $BFEF,$03 The second star offset.
  $BFF2,$02 Copy #REGbc bytes from #REGhl to #REGde.
  $BFF4,$02 #REGb=#N$03.
  $BFF6,$04 The star offsets.
@ $BFFA label=UpdateStars_Loop
  $BFFA,$03 Fetch the word at #R$CCBA into #REGhl.
  $BFFD,$03 Call #R$C152.
  $C000,$01 #REGa=#REGh.
  $C001,$03 Add the byte at offset #N$00 of #REGix to #REGa.
  $C004,$03 Write #REGa to offset #N$00 of #REGix.
  $C007,$01 #REGh=#REGl.
  $C008,$02 Advance #REGix.
  $C00A,$03 Call #R$C152.
  $C00D,$01 #REGa=#REGh.
  $C00E,$03 Add the byte at offset #N$00 of #REGix to #REGa.
  $C011,$03 Write #REGa to offset #N$00 of #REGix.
  $C014,$02 Advance #REGix.
  $C016,$02 Decrease #REGb and jump to #R$BFFA until none remain.
@ $C018 label=UpdateStars_Draw
  $C018,$03 The star positions.
  $C01B,$03 The address of the star's position.
  $C01E,$04 The star layer types.
  $C022,$03 The star offsets.
  $C025,$03 The address of the star's offset.
  $C028,$02 #REGb=#N$03.
@ $C02A label=UpdateStars_Layer
  $C02A,$01 Stash #REGbc on the stack.
  $C02B,$03 Call #R$C032.
  $C02E,$01 Bring #REGbc back off the stack.
  $C02F,$02 Decrease #REGb and jump to #R$C02A until none remain.
  $C031,$01 Return.

c $C032 Update Star Layer
@ $C032 label=UpdateStarLayer
D $C032 Erases and draws the six stars of one layer, from the positions in the
. table at #R$C0EA. A star is only drawn when it is on the screen, as decided
. by #R$C10E. Its attribute is set to bright white.
R $C032 IX Address of the table of types for the layer
  $C032,$02 Stash #REGix on the stack.
  $C034,$02 #REGb=#N$06.
@ $C036 label=UpdateStarLayer_Loop
  $C036,$03 Call #R$A2EA.
  $C039,$03 Update the star flags.
  $C03C,$01 Stash #REGbc on the stack.
  $C03D,$02 Stash #REGix on the stack.
  $C03F,$03 Fetch the word at #R$C0E8 into #REGhl.
  $C042,$04 Jump to #R$C069 if bit 0 of the byte at the address in #REGhl is
. clear.
  $C046,$03 #REGbc=#N$06.
  $C049,$03 Fetch the word at #R$C0E6 into #REGhl.
  $C04C,$01 #REGhl gains #REGbc.
  $C04D,$04 Fetch the word at #R$C0E8 into #REGde.
  $C051,$01 Read #REGde.
  $C052,$02,b$01 Keep the bits of #REGa that are set in #N$FE.
  $C054,$01 Add the byte at #REGhl to #REGa.
  $C055,$03 Update the sprite positions.
  $C058,$01 Advance #REGhl.
  $C059,$01 Advance #REGde.
  $C05A,$01 Read #REGde.
  $C05B,$01 Add the byte at #REGhl to #REGa.
  $C05C,$03 The star's vertical position.
  $C05F,$03 The star flags.
  $C062,$02,b$01 Set the bits of #REGa that are set in #N$01.
  $C064,$03 Update the star flags.
  $C067,$02 Jump to #R$C06B.
@ $C069 label=UpdateStarLayer_Erased
  $C069,$02 Jump to #R$C087.
@ $C06B label=UpdateStarLayer_Update2
  $C06B,$03 The sprite positions.
  $C06E,$02,b$01 Keep the bits of #REGa that are set in #N$01.
  $C070,$03 Add the byte at offset #N$01 of #REGix to #REGa.
  $C073,$03 Write #REGa to offset #N$00 of #REGix.
  $C076,$03 The sprite positions.
  $C079,$02,b$01 Keep the bits of #REGa that are set in #N$FE.
  $C07B,$03 Update the sprite positions.
  $C07E,$03 Call #R$A19F.
  $C081,$03 Call #R$A1EA.
  $C084,$03 Call #R$A234.
@ $C087 label=UpdateStarLayer_Draw
  $C087,$01 Switch to the alternate registers.
  $C088,$03 Call #R$C10E.
  $C08B,$02 Jump to #R$C094 if the zero flag is clear.
  $C08D,$03 Fetch the word at #R$C0E8 into #REGhl.
  $C090,$02 Reset bit 0 of the byte at the address in #REGhl.
  $C092,$02 Jump to #R$C0B5.
@ $C094 label=UpdateStarLayer_Visible
  $C094,$03 Fetch the word at #R$C0E8 into #REGhl.
  $C097,$02 Set bit 0 of the byte at the address in #REGhl.
  $C099,$03 The star's horizontal position.
  $C09C,$02,b$01 Keep the bits of #REGa that are set in #N$01.
  $C09E,$03 Add the byte at offset #N$01 of #REGix to #REGa.
  $C0A1,$03 Write #REGa to offset #N$00 of #REGix.
  $C0A4,$03 The star's horizontal position.
  $C0A7,$02,b$01 Keep the bits of #REGa that are set in #N$FE.
  $C0A9,$03 The star's horizontal position.
  $C0AC,$03 Call #R$A19F.
  $C0AF,$03 Call #R$A1D9.
  $C0B2,$03 Call #R$A247.
@ $C0B5 label=UpdateStarLayer_Update
  $C0B5,$03 The star flags.
  $C0B8,$03 Jump to #R$C0C6 if #REGa is zero.
  $C0BB,$03 Call #R$A303.
  $C0BE,$03 Fetch the word at #R$A1D5 into #REGhl.
  $C0C1,$03 Call #R$A170.
  $C0C4,$02 Store #N$47 at the address in #REGhl.
@ $C0C6 label=UpdateStarLayer_Next
  $C0C6,$04 Fetch the word at #R$C0E8 into #REGde.
  $C0CA,$01 Advance #REGde.
  $C0CB,$01 Advance #REGde.
  $C0CC,$04 The address of the next star's position.
  $C0D0,$02 Bring #REGix back off the stack.
  $C0D2,$01 Bring #REGbc back off the stack.
  $C0D3,$01 Step #REGb back.
  $C0D4,$03 Jump to #R$C036 if the zero flag is clear.
  $C0D7,$02 Bring #REGix back off the stack.
  $C0D9,$02 Advance #REGix.
  $C0DB,$02 Advance #REGix.
  $C0DD,$03 Fetch the word at #R$C0E6 into #REGhl.
  $C0E0,$01 Advance #REGhl.
  $C0E1,$01 Advance #REGhl.
  $C0E2,$03 The address of the next star's offset.
  $C0E5,$01 Return.

g $C0E6 Star Variables
@ $C0E6 label=StarVariables
D $C0E6 The addresses of the offsets of the layer and of the position of the
. current star.
W $C0E6,$02,$02
W $C0E8,$02,$02

g $C0EA Star Positions
@ $C0EA label=StarPositions
D $C0EA The horizontal and vertical positions of the eighteen stars. Bit 0 of
. the horizontal position is set while the star is being shown.
B $C0EA,$24,$02

c $C10E Check Star Position
@ $C10E label=CheckStarPosition
D $C10E Finds the position of a star on the screen, from its position and the
. offset of its layer. It is stored in #R$A1D5 and #R$A1D6. In the third zone
. a star is also left out if it is below the level of the ground.
R $C10E O:F The zero flag is set if the star is not on the screen
  $C10E,$03 Fetch the word at #R$C0E6 into #REGhl.
  $C111,$04 Fetch the word at #R$C0E8 into #REGde.
  $C115,$01 Read #REGde.
  $C116,$02,b$01 Keep the bits of #REGa that are set in #N$FE.
  $C118,$01 Add the byte at #REGhl to #REGa.
  $C119,$02 Subtract #N$08 from #REGa.
  $C11B,$04 Jump to #R$C150 if #REGa is #N$E0 or more.
  $C11F,$02 Add #N$08 to #REGa.
  $C121,$03 The star's horizontal position.
  $C124,$01 Advance #REGde.
  $C125,$01 Advance #REGhl.
  $C126,$01 Read #REGde.
  $C127,$01 Add the byte at #REGhl to #REGa.
  $C128,$02 Subtract #N$18 from #REGa.
  $C12A,$04 Jump to #R$C150 if #REGa is #N$A1 or more.
  $C12E,$02 Add #N$18 to #REGa.
  $C130,$03 The star's vertical position.
  $C133,$03 The map row.
  $C136,$04 Jump to #R$C147 if #REGa is not #N$03.
  $C13A,$03 The position down.
  $C13D,$01 Invert #REGa.
  $C13E,$02 Subtract #N$31 from #REGa.
  $C140,$01 #REGb=#REGa.
  $C141,$03 The star's vertical position.
  $C144,$03 Jump to #R$C150 if #REGa is #REGb or more.
@ $C147 label=CheckStarPosition_Visible
  $C147,$03 The star flags.
  $C14A,$02,b$01 Set the bits of #REGa that are set in #N$01.
  $C14C,$03 Update the star flags.
  $C14F,$01 Return.
@ $C150 label=CheckStarPosition_Hidden
  $C150,$01 Clear #REGa.
  $C151,$01 Return.

c $C152 Scale Scroll Speed
@ $C152 label=ScaleScrollSpeed
D $C152 Makes a scroll speed smaller for the stars of a layer further away,
. by shifting it right once for the second layer and twice for the third. For
. the third layer, on odd frames, a speed of #N($FE) is first changed to zero
. and a speed of #N($02) is changed to #N($04).
R $C152 B Layer (one for the nearest)
R $C152 H Scroll speed
R $C152 O:H Scaled scroll speed
  $C152,$01 #REGa=#REGb.
  $C153,$03 Return if #REGa is #N$01.
  $C156,$04 Jump to #R$C169 if #REGa is #N$02.
  $C15A,$01 #REGa=#REGh.
  $C15B,$04 Jump to #R$C169 if #REGa is not #N$FE.
  $C15F,$03 The frame counter.
  $C162,$02,b$01 Keep the bits of #REGa that are set in #N$01.
  $C164,$02 Jump to #R$C169 if the zero flag is set.
  $C166,$02 Clear #REGh.
  $C168,$01 Return.
@ $C169 label=ScaleScrollSpeed_Third
  $C169,$01 #REGa=#REGb.
  $C16A,$04 Jump to #R$C17C if #REGa is not #N$03.
  $C16E,$01 #REGa=#REGh.
  $C16F,$04 Jump to #R$C17C if #REGa is not #N$02.
  $C173,$03 The frame counter.
  $C176,$02,b$01 Keep the bits of #REGa that are set in #N$01.
  $C178,$02 Jump to #R$C17C if the zero flag is set.
  $C17A,$02 #REGh=#N$04.
@ $C17C label=ScaleScrollSpeed_Shift
  $C17C,$01 #REGa=#REGb.
  $C17D,$01 Step #REGa back.
@ $C17E label=ScaleScrollSpeed_Loop
  $C17E,$02 Shift #REGh right keeping the sign.
  $C180,$01 Step #REGa back.
  $C181,$02 Jump to #R$C17E if the zero flag is clear.
  $C183,$01 Return.

g $C184 Star Offsets
@ $C184 label=StarOffsets
D $C184 The distance that each of the three layers of stars has moved, as
. a horizontal and a vertical offset, followed by a copy that is kept while
. the layers are being updated.
B $C184,$06,$02
@ $C18A label=StarOffsets_Second
B $C18A,$06,$02

b $C190 Star Sprites
@ $C190 label=StarSprites
D $C190 The sprites of the five types of star, which are types #N($07) to
. #N($0B). Each has a width of one byte and a height of one to three rows.
B $C190,$03,$03
B $C193,$03,$03
B $C196,$04,$04
B $C19A,$04,$04
B $C19E,$05,$05

b $C1A3 Star Layer Types
@ $C1A3 label=StarLayerTypes
D $C1A3 Two bytes for each layer of stars, of which the second is the base type
. of the stars in the layer. The type of a star is that plus bit 0 of its
. horizontal position.
B $C1A3,$06,$02

g $C1A9 Ship Height
@ $C1A9 label=ShipHeight
D $C1A9 The height of the ship in pixels, which is made taller by parts that
. are fitted.
B $C1A9,$01,$01

g $C1AA Ship Buffer Address
@ $C1AA label=ShipBufferAddress
D $C1AA The address in the buffer at #R$F6B9 that the ship is drawn from.
W $C1AA,$02,$02

c $C1AC Create Ship Piece
@ $C1AC label=CreatePiece
D $C1AC Makes an object of type #N($0C) in a slot, with the state in #REGb and
. a position that is held in four bytes: the map column, the map zone, the
. horizontal position and the vertical position.
R $C1AC B State of the object
R $C1AC HL Address of the position
R $C1AC IX Address of the slot
  $C1AC,$03 Call #R$AC34.
  $C1AF,$04 Store #N$0C at offset #N$00 of #REGix.
  $C1B3,$03 Write #REGb to offset #N$13 of #REGix.
  $C1B6,$04 Store #N$FF at offset #N$0D of #REGix.
  $C1BA,$01 Read #REGhl.
  $C1BB,$03 Write #REGa to offset #N$01 of #REGix.
  $C1BE,$01 Advance #REGhl.
  $C1BF,$01 Read #REGhl.
  $C1C0,$03 Write #REGa to offset #N$04 of #REGix.
  $C1C3,$01 Advance #REGhl.
  $C1C4,$01 Read #REGhl.
  $C1C5,$03 Write #REGa to offset #N$02 of #REGix.
  $C1C8,$01 Advance #REGhl.
  $C1C9,$01 Read #REGhl.
  $C1CA,$03 Write #REGa to offset #N$05 of #REGix.
  $C1CD,$01 Return.

c $C1CE Check Item Delivery
@ $C1CE label=CheckItemDelivery
D $C1CE Does nothing unless the flag at #R$F5F7 is set, which happens when item
. number #N($09) has been picked up. Once the ship is at the bottom of zone
. #N($0B), the item is delivered: it is no longer carried, and two pieces are
. made with #R$C1AC in the last two slots of the map objects. Either way,
. carries on to draw the two pieces that are held at #R$C27B and #R$C27D and
. to set their attributes. This is a best reading of the code.
  $C1CE,$03 The flag set when item #N($09) has been picked up.
  $C1D1,$02 Return if #REGa is zero.
  $C1D3,$03 The ship's map zone.
  $C1D6,$05 Jump to #R$C240 if #REGa is not #N$0B.
  $C1DB,$03 The ship's vertical position.
  $C1DE,$05 Jump to #R$C240 if #REGa is less than #N$A7.
  $C1E3,$03 The facing kept for the pieces.
  $C1E6,$02,b$01 Set the bits of #REGa that are set in #N$40.
  $C1E8,$03 A piece is being delivered.
  $C1EB,$01 Clear #REGa.
  $C1EC,$03 Update the flag set when item #N($09) has been picked up.
  $C1EF,$03 Update the item the ship is about to pick up.
  $C1F2,$03 The ship's map zone.
  $C1F5,$01 #REGd=#REGa.
  $C1F6,$03 The ship's map column.
  $C1F9,$01 #REGe=#REGa.
  $C1FA,$04 The tenth item site.
  $C1FE,$04 The eleventh item site.
  $C202,$03 The ship row.
  $C205,$02 Subtract #N$0D from #REGa.
  $C207,$01 #REGb=#REGa.
  $C208,$03 The row the ship was drawn on.
  $C20B,$01 Subtract #REGb from #REGa.
  $C20C,$01 #REGb=#REGa.
  $C20D,$03 The ship's vertical position.
  $C210,$01 Subtract #REGb from #REGa.
  $C211,$01 #REGh=#REGa.
  $C212,$03 The ship's horizontal position.
  $C215,$02 Add #N$08 to #REGa.
  $C217,$02,b$01 Keep the bits of #REGa that are set in #N$F8.
  $C219,$01 #REGl=#REGa.
  $C21A,$03 The position of the tenth item site.
  $C21D,$01 #REGa=#REGl.
  $C21E,$02 Add #N$10 to #REGa.
  $C220,$01 #REGl=#REGa.
  $C221,$01 #REGa=#REGh.
  $C222,$02 Subtract #N$23 from #REGa.
  $C224,$01 #REGh=#REGa.
  $C225,$03 The position of the eleventh item site.
  $C228,$03 The tenth item site.
  $C22B,$04 The fifth map-object slot.
  $C22F,$02 #REGb=#N$09.
  $C231,$03 Call #R$C1AC.
  $C234,$04 The sixth map-object slot.
  $C238,$03 The eleventh item site.
  $C23B,$02 #REGb=#N$0A.
  $C23D,$03 Call #R$C1AC.
@ $C240 label=CheckItemDelivery_Pieces
  $C240,$04 The first piece beside the ship.
  $C244,$03 The picture of type #N$0C, frame #N$09.
  $C247,$03 #REGhl=#N$0505.
  $C24A,$03 The first piece is five bytes wide.
  $C24D,$03 #REGhl=#N$2300.
  $C250,$03 No rows saved, and the piece is #N($23) pixels high.
  $C253,$03 Call #R$C27F.
  $C256,$04 The second piece beside the ship.
  $C25A,$03 The picture of type #N$0C, frame #N$0A.
  $C25D,$03 #REGhl=#N$0303.
  $C260,$03 The second piece is three bytes wide.
  $C263,$03 #REGhl=#N$2F00.
  $C266,$03 No rows saved, and the piece is #N($2F) pixels high.
  $C269,$03 Call #R$C27F.
  $C26C,$03 The ship's facing.
  $C26F,$03 The facing the pieces were drawn with.
  $C272,$01 Clear #REGa.
  $C273,$03 No piece has been drawn yet.
  $C276,$03 Jump to #R$AF04.

g $C279 Piece Variables
@ $C279 label=PieceVariables
D $C279 Used to draw the pieces that are next to the ship. The first byte has
. bit 6 set when a piece is being delivered, and otherwise holds the
. direction that the ship was facing when it started. The second is set to
. #N($80) after a piece is drawn, and the others are the positions of
. the two pieces.
B $C279,$01,$01
B $C27A,$01,$01
@ $C27B label=PieceVariables_FirstSprite
W $C27B,$02,$02
@ $C27D label=PieceVariables_SecondSprite
W $C27D,$02,$02

c $C27F Draw Piece
@ $C27F label=DrawPiece
D $C27F Draws one of the two pieces that are next to the ship, if there is
. one. The position of the piece is at #REGix and its sprite
. is in #REGde. Pieces that are being delivered are drawn directly to the
. screen with #R$A59F.
R $C27F DE Address of the sprite
R $C27F IX Address of the position
  $C27F,$01 Stash #REGde on the stack.
  $C280,$03 The piece flags.
  $C283,$04 Jump to #R$C299 if bit 6 of #REGa is set.
  $C287,$03 Jump to #R$C2D2 if #REGa is zero.
  $C28A,$01 #REGb=#REGa.
  $C28B,$03 A piece has already been drawn.
  $C28E,$03 Jump to #R$C299 if #REGa is not zero.
  $C291,$03 The ship's facing.
  $C294,$01 Flip the bits of #REGa that are set in #REGb.
  $C295,$04 Jump to #R$C2D2 if bit 7 of #REGa is clear.
@ $C299 label=DrawPiece_Draw
  $C299,$03 The height of the piece.
  $C29C,$03 Keep the height of the piece.
  $C29F,$03 Read offset #N$00 of #REGix into #REGl.
  $C2A2,$03 Read offset #N$01 of #REGix into #REGh.
  $C2A5,$01 #REGa=#REGh.
  $C2A6,$03 Update the row offsets.
  $C2A9,$03 The height of the piece.
  $C2AC,$03 Call #R$C331.
  $C2AF,$01 #REGa=#REGb.
  $C2B0,$03 The height, kept below the top of the playfield.
  $C2B3,$03 The position of the piece.
  $C2B6,$04 The second aligned-row erase.
  $C2BA,$03 The piece width in bytes.
  $C2BD,$04 Jump to #R$C2C5 if #REGa is #N$05.
  $C2C1,$04 The fourth aligned-row erase.
@ $C2C5 label=DrawPiece_Draw2
  $C2C5,$03 The piece flags.
  $C2C8,$03 Call #R$BF88.
  $C2CB,$03 Fetch the word at #R$BF83 into #REGhl.
  $C2CE,$03 Call #R$A149.
  $C2D1,$01 Switch to the alternate registers.
@ $C2D2 label=DrawPiece_Done
  $C2D2,$01 Bring #REGde back off the stack.
  $C2D3,$03 The piece flags.
  $C2D6,$04 Jump to #R$C2E1 if bit 6 of #REGa is clear.
  $C2DA,$01 Clear #REGa.
  $C2DB,$03 Draw the piece straight to the screen.
  $C2DE,$03 Jump to #R$A59F.
@ $C2E1 label=DrawPiece_Ship
  $C2E1,$04 Store #N$68 at offset #N$00 of #REGix.
  $C2E5,$03 The ship row.
  $C2E8,$02 Subtract #N$0D from #REGa.
  $C2EA,$03 Write #REGa to offset #N$01 of #REGix.
  $C2ED,$03 The second aligned-row draw.
  $C2F0,$03 The piece width in bytes.
  $C2F3,$04 Jump to #R$C306 if #REGa is #N$05.
  $C2F7,$04 Store #N$78 at offset #N$00 of #REGix.
  $C2FB,$03 Read offset #N$01 of #REGix.
  $C2FE,$02 Subtract #N$23 from #REGa.
  $C300,$03 Write #REGa to offset #N$01 of #REGix.
  $C303,$03 The fourth aligned-row draw.
@ $C306 label=DrawPiece_Mask
  $C306,$03 The ship's facing.
  $C309,$04 Jump to #R$C311 if bit 7 of #REGa is clear.
  $C30D,$04 Store #N$60 at offset #N$00 of #REGix.
@ $C311 label=DrawPiece_Position
  $C311,$01 Stash #REGhl on the stack.
  $C312,$03 Read offset #N$00 of #REGix into #REGl.
  $C315,$03 Read offset #N$01 of #REGix into #REGh.
  $C318,$01 #REGa=#REGh.
  $C319,$03 The row the piece is drawn on.
  $C31C,$03 The height of the piece.
  $C31F,$03 Call #R$C331.
  $C322,$01 #REGa=#REGb.
  $C323,$03 The height of the piece.
  $C326,$03 Call #R$A149.
  $C329,$02 Bring #REGix back off the stack.
  $C32B,$03 Call #R$BFB8.
  $C32E,$03 Jump to #R$A59F.

c $C331 Limit Height
@ $C331 label=LimitHeight
D $C331 Stops a height from reaching above the top of the playfield, which
. is at row #N($17).
R $C331 A Height
R $C331 H Row at the bottom
R $C331 O:B Limited height
  $C331,$01 #REGb=#REGa.
  $C332,$01 #REGa=#REGh.
  $C333,$02 Subtract #N$17 from #REGa.
  $C335,$01 Subtract #REGb from #REGa.
  $C336,$01 Return if the carry flag is clear.
  $C337,$01 #REGa=#REGh.
  $C338,$02 Subtract #N$17 from #REGa.
  $C33A,$01 #REGb=#REGa.
  $C33B,$01 Return.

c $C33C Save Restart Position
@ $C33C label=SaveRestartPosition
D $C33C Called when the bottom two bits of the frame counter are zero. The
. position of the ship is saved when it is safe to restart there: that is
. when the row of the screen at #N$57C1 holds only #N($55), or when none of
. the four tiles that are on the screen has anything in it other than the
. tile #N($A6). The position is kept at #R$F5FA to #R$F5FF. This is a best
. reading of the code.
  $C33C,$03 #REGhl=#N$57C1.
  $C33F,$02 #REGb=#N$1C.
@ $C341 label=SaveRestartPosition_Loop
  $C341,$01 Read #REGhl.
  $C342,$04 Jump to #R$C361 if #REGa is not #N$55.
  $C346,$01 Advance #REGl.
  $C347,$02 Decrease #REGb and jump to #R$C341 until none remain.
@ $C349 label=SaveRestartPosition_Zero
  $C349,$02 Clear #REGb.
@ $C34B label=SaveRestartPosition_Store
  $C34B,$03 Fetch the word at #R$CE57 into #REGhl.
  $C34E,$03 Update the map column of the position that the ship restarts at.
  $C351,$03 Fetch the word at #R$CE45 into #REGhl.
  $C354,$01 #REGa=#REGl.
  $C355,$01 Set the bits of #REGa that are set in #REGb.
  $C356,$01 #REGl=#REGa.
  $C357,$03 Update the position of the ship: horizontal then vertical.
  $C35A,$03 Fetch the word at #R$CE41 into #REGhl.
  $C35D,$03 Update the scroll offsets: horizontal then vertical.
  $C360,$01 Return.
@ $C361 label=SaveRestartPosition_Tiles
  $C361,$03 The visible tiles.
  $C364,$02 #REGb=#N$04.
@ $C366 label=SaveRestartPosition_Row
  $C366,$01 Read #REGhl.
  $C367,$03 Jump to #R$C36D if #REGa is zero.
  $C36A,$03 Return if #REGa is not #N$A6.
@ $C36D label=SaveRestartPosition_Next
  $C36D,$01 Advance #REGhl.
  $C36E,$02 Decrease #REGb and jump to #R$C366 until none remain.
  $C370,$02 #REGb=#N$01.
  $C372,$02 Jump to #R$C34B.

c $C374 Run Frame
@ $C374 label=RunFrame
D $C374 Does the work for one frame of the game: increases the frame counter at
. #R$9A64, saves the position where the ship can restart with #R$C33C (every
. fourth frame) and clears the scroll speeds. Unless the ship is out of
. control, it is then moved by #R$B234 and tested against the terrain and the
. map objects. The shots are moved by #R$B706 and the rest of the world by
. #R$DDF8, which comes back at #R$C3E3. Then a part that has just been
. collected is fitted and the ship is drawn.
E $C374 Continue on to #R$C4ED.
  $C374,$03 The frame counter.
  $C377,$01 The next frame.
  $C378,$03 Write the frame counter back.
  $C37B,$04 On even frames the falling timer is left alone.
  $C37F,$03 The falling timer.
  $C382,$03 Leave it once it has run out.
  $C385,$01 One frame less on the timer.
  $C386,$03 Write the falling timer back.
@ $C389 label=RunFrame_Counter
  $C389,$01 The low byte of the frame counter.
  $C38A,$02,b$01 Only the bottom two bits of the frame.
  $C38C,$03 Save the restart position every fourth frame.
  $C38F,$02 Keep the pointer that was in #REGiy.
  $C391,$01 The scroll starts at rest.
  $C392,$03 No horizontal scroll yet.
  $C395,$03 No vertical scroll yet.
  $C398,$03 The ship state.
  $C39B,$04 State #N$0B or more means the ship is gone.
  $C39F,$04 The ship.
  $C3A3,$03 Change the ship's speeds from the controls.
  $C3A6,$02 The ship uses collision mode #N$FF.
  $C3A8,$03 Remember that mode for the terrain test.
  $C3AB,$03 The crystal-delivery flag.
  $C3AE,$03 A delivered stack skips the terrain test.
  $C3B1,$03 Give the ship the opposite of the scroll, so it stays put.
  $C3B4,$02 The ship's collision width is #N($30).
  $C3B6,$03 The ninth part flag.
  $C3B9,$01 Is the ninth part fitted?
  $C3BA,$02 Four extra rows of height without that part.
  $C3BC,$02 Jump to #R$C3C0 if the zero flag is set.
  $C3BE,$02 No extra rows.
@ $C3C0 label=RunFrame_Add
  $C3C0,$03 The height of the ship.
  $C3C3,$01 Add the extra rows.
  $C3C4,$01 That is the collision height.
  $C3C5,$03 Test the ship against the terrain.
  $C3C8,$03 Test the ship against the map objects.
  $C3CB,$03 The ship's horizontal speed.
  $C3CE,$03 Keep it for the end of the frame.
  $C3D1,$03 The ship's vertical speed.
  $C3D4,$03 Keep it for the end of the frame.
  $C3D7,$03 Set the ship speeds from the scroll again.
  $C3DA,$03 Move the ship by those speeds.
@ $C3DD label=RunFrame_Shots
  $C3DD,$03 Call #R$B706.
  $C3E0,$03 Jump to #R$DDF8.
@ $C3E3 label=RunFrame_Draw
  $C3E3,$02 Back to the pointer saved at the start of the frame.
  $C3E5,$03 The crystal-delivery flag.
  $C3E8,$02 A delivered stack draws nothing more this frame.
  $C3EA,$03 The ship state.
  $C3ED,$03 An explosion past ten draws nothing more.
  $C3F0,$03 Call #R$9724.
  $C3F3,$03 The frame counter.
  $C3F6,$02,b$01 Bit 0 set means an odd frame.
  $C3F8,$02 Jump to #R$C421 if the zero flag is clear.
  $C3FA,$03 Call #R$C1CE.
  $C3FD,$03 The carried-item marker.
  $C400,$03 Jump to #R$C421 if #REGa is not zero.
  $C403,$03 The ship state.
  $C406,$04 State ten skips the flame test.
  $C40A,$03 A finished slope check skips the flames.
  $C40D,$03 Jump to #R$C421 if #REGa is not zero.
  $C410,$03 The steering direction.
  $C413,$04 Jump to #R$C5EA if #REGa is zero.
  $C417,$01 The direction being steered.
  $C418,$03 The ship's facing.
  $C41B,$01 Flip the bits of #REGa that are set in #REGb.
  $C41C,$05 Jump to #R$C5EA if bit 7 of #REGa is clear.
@ $C421 label=RunFrame_Ship
  $C421,$03 The draw scratch starts clear.
  $C424,$03 The draw scratch starts at zero.
  $C427,$03 The ship's screen row.
  $C42A,$03 The row the sprites are drawn on.
  $C42D,$03 A width and height of six.
  $C430,$03 The sprite size is six by six.
  $C433,$04 The ship.
  $C437,$03 The ship state.
  $C43A,$04 State ten skips the flame colour.
  $C43E,$03 The ship's facing.
  $C441,$03 The direction being steered.
  $C444,$03 Jump to #R$C4AB if #REGa is zero.
  $C447,$01 Compare it with the facing byte.
  $C448,$02,b$01 Only the facing bit.
  $C44A,$03 Note that the steering and the facing differ.
  $C44D,$02 Jump to #R$C4AB if the zero flag is set.
  $C44F,$01 Clear #REGa.
  $C450,$03 Clear the shot scratch.
@ $C453 label=RunFrame_Erase
  $C453,$03 Where the ship was drawn.
  $C456,$03 Keep that, so it can be erased.
  $C459,$04 The ship graphic in the buffer.
  $C45D,$03 The height of the ship.
  $C460,$03 The height, kept for the draw.
  $C463,$04 The erase aligned row directly.
  $C467,$03 Call #R$BF85.
  $C46A,$03 Fetch the word at #R$BF83 into #REGhl.
  $C46D,$03 Call #R$A149.
  $C470,$01 Switch to the alternate registers.
  $C471,$03 Read offset #N$1F of #REGix.
  $C474,$03 Jump to #R$C4AB if #REGa is zero.
  $C477,$04 Jump to #R$C485 if bit 7 of #REGa is clear.
  $C47B,$03 Call #R$AA37.
  $C47E,$02 #REGa=#N$80.
  $C480,$03 A piece has been drawn.
  $C483,$02 Jump to #R$C4B1.
@ $C485 label=RunFrame_FitPart
  $C485,$01 #REGb=#REGa.
  $C486,$01 Step #REGa back.
  $C487,$03 The first part flag.
  $C48A,$03 Call #R$9BCF.
  $C48D,$01 Write #REGb where #REGhl points.
  $C48E,$03 Call #R$A59F.
  $C491,$03 Call #R$AFE9.
  $C494,$02 #REGa=#N$80.
  $C496,$03 A piece has been drawn.
  $C499,$04 The ship.
  $C49D,$03 #REGhl=#N$00.
  $C4A0,$03 No saved row count.
  $C4A3,$03 #REGhl=#N$0606.
  $C4A6,$03 The ship sprite is six bytes wide.
  $C4A9,$02 Jump to #R$C4B1.
@ $C4AB label=RunFrame_Check
  $C4AB,$03 Read offset #N$1F of #REGix.
  $C4AE,$03 Jump to #R$C453 if #REGa is not zero.
@ $C4B1 label=RunFrame_Facing
  $C4B1,$03 The steering direction.
  $C4B4,$03 Jump to #R$C4BA if #REGa is zero.
  $C4B7,$03 Write #REGa to offset #N$18 of #REGix.
@ $C4BA label=RunFrame_Explosion
  $C4BA,$03 The ship state.
  $C4BD,$04 Jump to #R$C4E1 if #REGa is #N$0A.
  $C4C1,$03 The row the ship was drawn on.
  $C4C4,$03 The row the ship was drawn on.
  $C4C7,$04 Fetch the word at #R$C1AA into #REGde.
  $C4CB,$03 Fetch the word at #N$C902 into #REGhl.
  $C4CE,$03 The position the ship was drawn at.
  $C4D1,$03 Call #R$A149.
  $C4D4,$03 The height of the ship.
  $C4D7,$03 The height of the ship.
  $C4DA,$04 The draw aligned row directly.
  $C4DE,$03 Call #R$BFB8.
@ $C4E1 label=RunFrame_DrawShip
  $C4E1,$03 Call #R$A59F.
  $C4E4,$03 Call #R$F1BD.
  $C4E7,$03 The ship state.
  $C4EA,$03 Return if #REGa is #N$0A or more.

c $C4ED Draw Ship Top
@ $C4ED label=DrawShipTop
D $C4ED Draws the top of the ship, which is one of the six sprites for types
. #N($01) to #N($06): the one that is used depends on the horizontal speed of
. the ship, and type #N($06) is used while the ship has just been hit.
. Then it checks for the pause keys with #R$9F54 and fires the weapons with
. #R$B731. Carries on with #R$C6D2 or #R$C5FF on alternate frames. This is a
. best reading of the code.
E $C4ED Continue on to #R$C5FF.
  $C4ED,$03 #REGhl=#N$00.
  $C4F0,$03 No saved row count.
  $C4F3,$04 The ship top object.
  $C4F7,$03 Call #R$A19F.
  $C4FA,$03 Fetch the word at #R$C7BD into #REGhl.
  $C4FD,$03 The position of the ship top.
  $C500,$03 Call #R$A21C.
  $C503,$03 Call #R$A27A.
  $C506,$03 Fetch the word at #R$BF83 into #REGhl.
  $C509,$03 Call #R$A149.
  $C50C,$04 The sixth aligned-row erase.
  $C510,$03 Call #R$C7B1.
  $C513,$02 Jump to #R$C519 if the zero flag is clear.
  $C515,$04 The sixth mirrored-row erase.
@ $C519 label=DrawShipTop_Frame
  $C519,$01 Switch to the alternate registers.
  $C51A,$03 Read offset #N$00 of #REGix into #REGe.
  $C51D,$03 The item the ship is about to pick up.
  $C520,$03 Jump to #R$C534 if #REGa is zero.
  $C523,$03 The ship row.
  $C526,$02 Subtract #N$09 from #REGa.
  $C528,$03 The row of the carried item.
  $C52B,$03 The row the item is drawn on.
  $C52E,$02 #REGe=#N$FF.
  $C530,$01 Clear #REGa.
  $C531,$03 Update the item the ship is about to pick up.
@ $C534 label=DrawShipTop_Speed
  $C534,$03 Fetch the word at #N$C8FE into #REGhl.
  $C537,$01 #REGa=#REGh.
  $C538,$01 #REGh=#REGl.
  $C539,$01 #REGl=#REGa.
  $C53A,$01 #REGa=#REGh.
  $C53B,$03 Jump to #R$C54B if #REGa is not zero.
  $C53E,$01 #REGa=#REGl.
  $C53F,$02 Compare #REGa with #N$80.
  $C541,$01 #REGa=#REGh.
  $C542,$02 Jump to #R$C54B if the carry flag is clear.
  $C544,$02 #REGa=#N$80.
  $C546,$03 The ship top faces left.
  $C549,$02 Jump to #R$C553.
@ $C54B label=DrawShipTop_Fast
  $C54B,$02,b$01 Keep the bits of #REGa that are set in #N$80.
  $C54D,$03 The facing of the ship top.
  $C550,$03 Call #R$BE08 if the zero flag is clear.
@ $C553 label=DrawShipTop_Select
  $C553,$01 #REGa=#REGl.
  $C554,$02,b$01 Keep the bits of #REGa that are set in #N$80.
  $C556,$01 Rotate #REGa left.
  $C557,$02 Shift #REGh left.
  $C559,$01 #REGa gains #REGh.
  $C55A,$01 Advance #REGa.
  $C55B,$03 Write #REGa to offset #N$00 of #REGix.
  $C55E,$03 The horizontal scroll limit.
  $C561,$01 #REGb=#REGa.
  $C562,$01 #REGa=#REGh.
  $C563,$03 Jump to #R$C56A if #REGa is less than #REGb.
  $C566,$01 Advance #REGb.
  $C567,$03 Write #REGb to offset #N$00 of #REGix.
@ $C56A label=DrawShipTop_Hit
  $C56A,$03 The ship state.
  $C56D,$03 Jump to #R$C580 if #REGa is not zero.
  $C570,$03 The hit-flash timer.
  $C573,$03 Jump to #R$C580 if #REGa is zero.
  $C576,$01 Step #REGa back.
  $C577,$03 Update the hit-flash timer.
  $C57A,$04 Store #N$06 at offset #N$00 of #REGix.
  $C57E,$02 Jump to #R$C59C.
@ $C580 label=DrawShipTop_Show
  $C580,$03 The ship state.
  $C583,$04 Jump to #R$C5CF if #REGa is #N$0A or more.
  $C587,$03 The collision kind.
  $C58A,$03 Jump to #R$C59C if #REGa is not zero.
  $C58D,$03 Read offset #N$00 of #REGix.
  $C590,$03 Jump to #R$C59C if #REGa is not #REGe.
  $C593,$03 The turn flag.
  $C596,$03 Jump to #R$C59C if #REGa is not zero.
  $C599,$03 The ship is not turning.
@ $C59C label=DrawShipTop_Position
  $C59C,$03 Call #R$A19F.
  $C59F,$02 #REGb=#N$68.
  $C5A1,$03 The ship's facing.
  $C5A4,$04 Jump to #R$C5AA if bit 7 of #REGa is clear.
  $C5A8,$02 #REGb=#N$78.
@ $C5AA label=DrawShipTop_Store
  $C5AA,$01 #REGa=#REGb.
  $C5AB,$03 The column of the ship top.
  $C5AE,$03 The column of the ship top.
  $C5B1,$03 Call #R$A19F.
  $C5B4,$03 Call #R$A21C.
  $C5B7,$03 Call #R$A266.
  $C5BA,$04 The sixth aligned-row draw.
  $C5BE,$03 Call #R$C7B1.
  $C5C1,$02 Jump to #R$C5CF if the zero flag is clear.
  $C5C3,$04 The sixth mirrored-row draw.
  $C5C7,$03 The column of the ship top.
  $C5CA,$02 Add #N$08 to #REGa.
  $C5CC,$03 The column one byte to the right.
@ $C5CF label=DrawShipTop_Draw
  $C5CF,$03 Call #R$A59F.
  $C5D2,$01 Clear #REGa.
  $C5D3,$03 Update the collision kind.
  $C5D6,$03 The ship top object.
  $C5D9,$05 Jump to #R$C5EA if #REGa is #N$06.
  $C5DE,$03 Fetch the word at #R$BF83 into #REGhl.
  $C5E1,$01 #REGa=#REGh.
  $C5E2,$02 Subtract #N$07 from #REGa.
  $C5E4,$01 #REGh=#REGa.
  $C5E5,$03 Call #R$A170.
  $C5E8,$02 Store #N$47 at the address in #REGhl.
@ $C5EA label=DrawShipTop_Pause
  $C5EA,$03 Call #R$9F54.
  $C5ED,$03 Call #R$B731.
  $C5F0,$03 The ship state.
  $C5F3,$04 Jump to #R$C5FF if #REGa is #N$0A or more.
  $C5F7,$03 The frame counter.
  $C5FA,$02,b$01 Keep the bits of #REGa that are set in #N$01.
  $C5FC,$03 Jump to #R$C6D2 if the zero flag is set.

c $C5FF Draw Side Flames
@ $C5FF label=DrawSideFlames
D $C5FF Does nothing unless part #N$04 has been fitted. Draws the flame at the
. side of the ship when it is moving to the left or to the right, from the
. object at #R$C6C2, and sets its attribute with #R$C6A8. This is a best
. reading of the code.
  $C5FF,$03 The fourth part flag.
  $C602,$02 Return if #REGa is zero.
  $C604,$04 The side flame object.
  $C608,$03 #REGhl=#N$00.
  $C60B,$03 No saved row count.
  $C60E,$06 Jump to #R$C61C if bit 7 of offset #N$03 of #REGix is set.
  $C614,$03 The controls.
  $C617,$02,b$01 Keep the bits of #REGa that are set in #N$03.
  $C619,$01 Return if the zero flag is set.
  $C61A,$02 Jump to #R$C635.
@ $C61C label=DrawSideFlames_Flame
  $C61C,$03 Call #R$C7A3.
  $C61F,$03 The flame sprite's width.
  $C622,$03 Fetch the word at #N$C6C3 into #REGhl.
  $C625,$04 The fifth aligned-row erase.
  $C629,$06 Jump to #R$C635 if bit 6 of offset #N$03 of #REGix is clear.
  $C62F,$04 The fifth mirrored-row erase.
  $C633,$02 #REGb=#N$F9.
@ $C635 label=DrawSideFlames_Update
  $C635,$01 Switch to the alternate registers.
  $C636,$04 Store #N$00 at offset #N$03 of #REGix.
  $C63A,$03 The controls.
  $C63D,$02,b$01 Keep the bits of #REGa that are set in #N$03.
  $C63F,$03 Jump to #R$C691 if the zero flag is set.
  $C642,$03 The ship state.
  $C645,$04 Jump to #R$C691 if #REGa is #N$0A or more.
  $C649,$03 Read offset #N$06 of #REGix.
  $C64C,$01 Advance #REGa.
  $C64D,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $C64F,$03 Write #REGa to offset #N$06 of #REGix.
  $C652,$03 The flame frames.
  $C655,$03 Call #R$9BCF.
  $C658,$01 Read #REGhl.
  $C659,$02 Add #N$0E to #REGa.
  $C65B,$03 Write #REGa to offset #N$00 of #REGix.
  $C65E,$03 Call #R$C7A3.
  $C661,$03 The flame sprite's width.
  $C664,$04 Store #N$80 at offset #N$03 of #REGix.
  $C668,$04 The fifth aligned-row draw.
  $C66C,$03 The ship row.
  $C66F,$02 Add #N$08 to #REGa.
  $C671,$01 #REGh=#REGa.
  $C672,$02 #REGl=#N$50.
  $C674,$03 The controls.
  $C677,$04 Jump to #R$C688 if bit 1 of #REGa is clear.
  $C67B,$02 #REGl=#N$98.
  $C67D,$02 #REGb=#N$F9.
  $C67F,$02 #REGa=#N$C0.
  $C681,$03 The side flame faces left.
  $C684,$04 The fifth mirrored-row draw.
@ $C688 label=DrawSideFlames_Draw2
  $C688,$03 The position of the side flame.
  $C68B,$03 Call #R$A149.
  $C68E,$03 The screen address of the side flame.
@ $C691 label=DrawSideFlames_Draw
  $C691,$03 Call #R$A59F.
  $C694,$03 The side flame faces left.
  $C697,$02,b$01 Keep the bits of #REGa that are set in #N$80.
  $C699,$01 Return if the zero flag is set.
  $C69A,$03 Fetch the word at #N$C6C6 into #REGhl.
  $C69D,$01 #REGa=#REGl.
  $C69E,$02,b$01 Keep the bits of #REGa that are set in #N$F0.
  $C6A0,$01 #REGl=#REGa.
  $C6A1,$01 #REGa=#REGh.
  $C6A2,$02 Subtract #N$04 from #REGa.
  $C6A4,$01 #REGh=#REGa.
  $C6A5,$03 The flame attribute.
@ $C6A8 label=SetFlameAttributes
  $C6A8,$01 Swap #REGde and #REGhl.
  $C6A9,$03 #REGhl=#N$0202.
  $C6AC,$03 Update the attribute area.
  $C6AF,$03 The flame attributes.
  $C6B2,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $C6B4,$03 Call #R$9BCF.
  $C6B7,$01 Read #REGhl.
  $C6B8,$01 Swap #REGde and #REGhl.
  $C6B9,$03 The attribute of the side flame.
  $C6BC,$03 The attribute area.
  $C6BF,$03 Jump to #R$C991.

g $C6C2 Side Flame Object
@ $C6C2 label=SideFlameObject
D $C6C2 The object that is used to draw the flame at the side of the ship,
. followed by a copy that is kept for the other player. The byte at #R$C6D0
. is set by #R$BA21 when the ship has landed.
B $C6C2,$07,$07
@ $C6C9 label=SideFlameObject_Second
B $C6C9,$07,$07
B $C6D0,$01,$01
B $C6D1,$01,$01

c $C6D2 Draw Main Flame
@ $C6D2 label=DrawMainFlame
D $C6D2 Does nothing unless part #N$05 has been fitted. Draws the flame under
. the ship, from the object at #R$C78F: a larger one (type #N($11)) when
. going up and a smaller one (type #N($12)) when not. This is a best reading
. of the code.
  $C6D2,$03 The fifth part flag.
  $C6D5,$02 Return if #REGa is zero.
  $C6D7,$04 The main flame object.
  $C6DB,$03 #REGhl=#N$00.
  $C6DE,$03 No saved row count.
  $C6E1,$03 Update the row offsets.
  $C6E4,$06 Jump to #R$C703 if bit 7 of offset #N$03 of #REGix is clear.
  $C6EA,$03 Call #R$C7A3.
  $C6ED,$03 The flame sprite's width.
  $C6F0,$03 Fetch the word at #N$C790 into #REGhl.
  $C6F3,$04 The third aligned-row erase.
  $C6F7,$06 Jump to #R$C703 if bit 6 of offset #N$03 of #REGix is clear.
  $C6FD,$04 The third mirrored-row erase.
  $C701,$02 #REGb=#N$F9.
@ $C703 label=DrawMainFlame_Update
  $C703,$04 Reset bit 7 of offset #N$03 of #REGix.
  $C707,$01 Switch to the alternate registers.
  $C708,$03 The ship has landed.
  $C70B,$03 Jump to #R$C774 if #REGa is not zero.
  $C70E,$04 Store #N$12 at offset #N$00 of #REGix.
  $C712,$03 The ship state.
  $C715,$04 Jump to #R$C774 if #REGa is #N$0A or more.
  $C719,$03 The controls.
  $C71C,$02,b$01 Keep the bits of #REGa that are set in #N$08.
  $C71E,$02 Jump to #R$C724 if the zero flag is set.
  $C720,$04 Store #N$11 at offset #N$00 of #REGix.
@ $C724 label=DrawMainFlame_Frame
  $C724,$03 Call #R$C7A3.
  $C727,$03 The flame sprite's width.
  $C72A,$03 Read offset #N$03 of #REGix.
  $C72D,$02,b$01 Flip the bits of #REGa that are set in #N$40.
  $C72F,$02,b$01 Set the bits of #REGa that are set in #N$80.
  $C731,$03 Write #REGa to offset #N$03 of #REGix.
  $C734,$03 The crystal-delivery flag.
  $C737,$03 Jump to #R$C746 if #REGa is zero.
  $C73A,$03 The row of the crystal stack.
  $C73D,$02 Add #N$13 to #REGa.
  $C73F,$01 #REGh=#REGa.
  $C740,$04 Store #N$11 at offset #N$00 of #REGix.
  $C744,$02 Jump to #R$C757.
@ $C746 label=DrawMainFlame_Position
  $C746,$03 The ship row.
  $C749,$02 Add #N$1D to #REGa.
  $C74B,$01 #REGh=#REGa.
  $C74C,$03 Read offset #N$00 of #REGix.
  $C74F,$04 Jump to #R$C757 if #REGa is #N$11.
  $C753,$01 #REGa=#REGh.
  $C754,$02 Subtract #N$08 from #REGa.
  $C756,$01 #REGh=#REGa.
@ $C757 label=DrawMainFlame_Side
  $C757,$02 #REGl=#N$68.
  $C759,$04 Test bit 6 of offset #N$03 of #REGix.
  $C75D,$04 The third aligned-row draw.
  $C761,$02 Jump to #R$C76B if the zero flag is set.
  $C763,$04 The third mirrored-row draw.
  $C767,$02 #REGb=#N$F9.
  $C769,$02 #REGl=#N$80.
@ $C76B label=DrawMainFlame_Store
  $C76B,$03 The position of the main flame.
  $C76E,$03 Call #R$A149.
  $C771,$03 The screen address of the main flame.
@ $C774 label=DrawMainFlame_Draw
  $C774,$03 Call #R$A59F.
  $C777,$01 Clear #REGa.
  $C778,$03 The ship is no longer on the ground.
  $C77B,$03 The main flame faces left.
  $C77E,$02,b$01 Keep the bits of #REGa that are set in #N$80.
  $C780,$01 Return if the zero flag is set.
  $C781,$03 Fetch the word at #N$C793 into #REGhl.
  $C784,$01 #REGa=#REGh.
  $C785,$02 Subtract #N$07 from #REGa.
  $C787,$01 #REGh=#REGa.
  $C788,$02 #REGl=#N$70.
  $C78A,$02 #REGa=#N$07.
  $C78C,$03 Jump to #R$C6A8.

g $C78F Main Flame Object
@ $C78F label=MainFlameObject
D $C78F The object that is used to draw the flame under the ship.
B $C78F,$06,$06
@ $C795 label=MainFlameObject_Second
B $C795,$06,$06

b $C79B Flame Attributes
@ $C79B label=FlameAttributes
D $C79B The attributes for the flames, which are used in turn.
B $C79B,$01 #COLOUR(#PEEK(#PC)).
L $C79B,$01,$08

c $C7A3 Fetch Sprite Type
@ $C7A3 label=FetchSpriteType
D $C7A3 Finds the sprite for the type of an object, and reads the first byte
. of it, which is its width.
R $C7A3 IX Address of the object
R $C7A3 O:A Width of the sprite
R $C7A3 O:DE Address of the second byte of the sprite
  $C7A3,$03 Call #R$A19F.
  $C7A6,$01 Read #REGde.
  $C7A7,$01 Advance #REGde.
  $C7A8,$01 Return.

b $C7A9 Flame Frames
@ $C7A9 label=FlameFrames
D $C7A9 Eight numbers that are added to fourteen to make the type of the flame.
B $C7A9,$08,$08

c $C7B1 Test Direction
@ $C7B1 label=TestDirection
D $C7B1 Tests the flag at #R$C7BF, which has bit 7 set when the object is facing
. left. If it is not, #REGl is increased, #REGb is made #N($F9) and the zero
. flag is set.
R $C7B1 L Horizontal position
R $C7B1 O:A Zero if not facing left
R $C7B1 O:B #N($F9) if not facing left
R $C7B1 O:F The zero flag is set if the object is not facing left
  $C7B1,$03 The ship top faces left.
  $C7B4,$03 Return if bit 7 of #REGa is set.
  $C7B7,$02 #REGb=#N$F9.
  $C7B9,$01 Advance #REGl.
  $C7BA,$01 Clear #REGa.
  $C7BB,$01 Return.

g $C7BC Ship Top Object
@ $C7BC label=ShipTopObject
D $C7BC The object that is used to draw the top of the ship: its type, its
. position on the screen, and some flags. The flag at #R$C7BF has bit 7 set
. when it faces left, and #R$C7C1 is the number of frames for which it is
. shown as hit. There is a second copy of it that is kept for the other
. player.
B $C7BC,$01,$01
B $C7BD,$01,$01
B $C7BE,$01,$01
B $C7BF,$01,$01
B $C7C0,$01,$01
B $C7C1,$01,$01
@ $C7C2 label=ShipTopObject_Second
B $C7C2,$06,$06

b $C7C8 Ship Top Sprites
@ $C7C8 label=ShipTopSprites
D $C7C8 The sprites for types #N($01) to #N($06), each of which is one byte wide
. and has one to eight rows.
B $C7C8,$0A,$0A
B $C7D2,$0A,$0A
B $C7DC,$09,$09
B $C7E5,$08,$08
B $C7ED,$07,$07
B $C7F4,$06,$06

g $C7FA Horizontal Scroll Fraction
@ $C7FA label=HorizontalScrollFraction
D $C7FA The fraction of a pixel that is left over from the horizontal speed
. worked out by #R$C81F.
W $C7FA,$02,$02

c $C7FC Update Horizontal Speed
@ $C7FC label=UpdateHorizontalSpeed
D $C7FC Adds the acceleration in #REGde to the horizontal speed of the ship,
. limits it, and sets it to zero if the ship has turned round. Carries on at
. #R$C81F to work out the horizontal scroll speed.
E $C7FC Continue on to #R$C81F.
R $C7FC DE Acceleration
R $C7FC IX Address of the ship
  $C7FC,$03 Read offset #N$19 of #REGix into #REGh.
  $C7FF,$03 Read offset #N$1A of #REGix into #REGl.
  $C802,$01 Swap #REGde and #REGhl.
  $C803,$01 #REGhl gains #REGde.
  $C804,$03 Call #R$C868.
  $C807,$03 The steering direction.
  $C80A,$03 Jump to #R$C819 if #REGa is not zero.
  $C80D,$01 #REGa=#REGh.
  $C80E,$01 Flip the bits of #REGa that are set in #REGd.
  $C80F,$02,b$01 Keep the bits of #REGa that are set in #N$80.
  $C811,$02 Jump to #R$C819 if the zero flag is set.
  $C813,$03 #REGhl=#N$00.
  $C816,$03 Update the horizontal scroll fraction.
@ $C819 label=UpdateHorizontalSpeed_Store
  $C819,$03 Write #REGh to offset #N$19 of #REGix.
  $C81C,$03 Write #REGl to offset #N$1A of #REGix.

c $C81F Update Horizontal Scroll Speed
@ $C81F label=UpdateHorizontalScrollSpeed
D $C81F Adds the horizontal speed of the ship to the fraction in #R$C7FA and
. works out how many whole pixels of horizontal scroll that makes, limited by
. the value in #R$5C3E in the same way as #R$B2D5 for the vertical scroll.
. The result is stored in #R$CCBB.
R $C81F HL Horizontal speed
  $C81F,$04 Fetch the word at #R$C7FA into #REGde.
  $C823,$01 #REGhl gains #REGde.
  $C824,$03 Update the horizontal scroll fraction.
  $C827,$01 #REGa=#REGh.
  $C828,$01 Subtract #REGd from #REGa.
  $C829,$01 Double #REGa.
  $C82A,$01 #REGh=#REGa.
  $C82B,$03 The horizontal scroll limit.
  $C82E,$04 Jump to #R$C837 if bit 7 of #REGh is set.
  $C832,$02 Add #N$02 to #REGa.
  $C834,$01 #REGb=#REGa.
  $C835,$02 Jump to #R$C83C.
@ $C837 label=UpdateHorizontalScrollSpeed_Negative
  $C837,$02 Negate #REGa.
  $C839,$02 Subtract #N$02 from #REGa.
  $C83B,$01 #REGb=#REGa.
@ $C83C label=UpdateHorizontalScrollSpeed_Limit
  $C83C,$01 #REGa=#REGh.
  $C83D,$04 Jump to #R$C847 if bit 7 of #REGa is set.
  $C841,$03 Jump to #R$C84F if #REGa is not #REGb.
  $C844,$03 The horizontal scroll limit.
@ $C847 label=UpdateHorizontalScrollSpeed_Fast
  $C847,$03 Jump to #R$C84F if #REGa is not #REGb.
  $C84A,$03 The horizontal scroll limit.
  $C84D,$02 Negate #REGa.
@ $C84F label=UpdateHorizontalScrollSpeed_Store
  $C84F,$03 Update the horizontal scroll speed.
  $C852,$04 Jump to #R$C859 if #REGa is #N$04.
  $C856,$03 Return if #REGa is not #N$FC.
@ $C859 label=UpdateHorizontalScrollSpeed_Halve
  $C859,$03 The horizontal offset.
  $C85C,$02,b$01 Keep the bits of #REGa that are set in #N$02.
  $C85E,$01 Return if the zero flag is set.
  $C85F,$03 The horizontal scroll speed.
  $C862,$02 Shift #REGa right keeping the sign.
  $C864,$03 Update the horizontal scroll speed.
  $C867,$01 Return.

c $C868 Limit Horizontal Speed
@ $C868 label=LimitHorizontalSpeed
D $C868 Keeps the horizontal speed of the ship within a limit that is half the
. value at #R$5C3E.
R $C868 H Horizontal speed
R $C868 O:H Limited horizontal speed
  $C868,$03 The horizontal scroll limit.
  $C86B,$02 Shift #REGa right.
  $C86D,$04 Jump to #R$C87A if bit 7 of #REGh is clear.
  $C871,$02 Negate #REGa.
  $C873,$01 #REGb=#REGa.
  $C874,$01 #REGa=#REGh.
  $C875,$02 Return if #REGa is #REGb or more.
  $C877,$01 Step #REGb back.
  $C878,$01 #REGh=#REGb.
  $C879,$01 Return.
@ $C87A label=LimitHorizontalSpeed_Positive
  $C87A,$01 #REGb=#REGa.
  $C87B,$01 #REGa=#REGh.
  $C87C,$02 Return if #REGa is less than #REGb.
  $C87E,$01 #REGh=#REGb.
  $C87F,$01 Return.

c $C880 Limit Speed
@ $C880 label=LimitSpeed
D $C880 Keeps the high byte of a speed within #N($FD) (the fastest upwards or
. to the left) and #N($02) (the fastest downwards or to the right).
R $C880 H Speed (high byte)
R $C880 O:H Limited speed (high byte)
  $C880,$01 #REGa=#REGh.
  $C881,$04 Jump to #R$C88B if bit 7 of #REGa is clear.
  $C885,$03 Return if #REGa is #N$FE or more.
  $C888,$02 #REGh=#N$FD.
  $C88A,$01 Return.
@ $C88B label=LimitSpeed_Positive
  $C88B,$03 Return if #REGa is less than #N$02.
  $C88E,$02 #REGh=#N$02.
  $C890,$01 Return.

b $C891 Ship Base Graphic
@ $C891 label=ShipBaseGraphic
D $C891 The picture of the ship without any parts fitted: fourteen rows of six
. bytes. #R$AFE9 copies it to the buffer at #N($F755) when the ship is built.
B $C891,$54,$06

g $C8E5 Ship Object
@ $C8E5 label=ShipObject
D $C8E5 The player's ship. The first #N($18) bytes have the layout of an enemy
. slot, as described at #R$9974, and then there are some extra fields:
. #TABLE(default,centre,centre)
. { =h Offset | =h Contents }
. { #N($18) | Bit 7 is set when the ship is facing left }
. { #N($19)-#N($1A) | Copy of the horizontal speed (offsets #N($07) and
. #N($08)) taken at the end of the frame }
. { #N($1B)-#N($1C) | Copy of the vertical speed (offsets #N($09) and
. #N($0A)) taken at the end of the frame }
. { #N($1D)-#N($1E) | Horizontal then vertical position at which the ship was
. last drawn, which is used to erase it }
. { #N($1F) | What the ship is about to pick up: #N($C0) plus the number of
. an item to carry, or the number of a part to fit }
. TABLE#
B $C8E5,$20,$20

g $C905 Stack Height
@ $C905 label=StackHeight
D $C905 The height of the stack of units that the ship carries (up to
. #N($12)). Also see #R$A8A5.
B $C905,$01,$01

g $C906 Ship Start State
@ $C906 label=ShipStartState
D $C906 The state that #R$F311 copies to the ship object at #R$C8E5 at the
. start of each life.
B $C906,$20,$20
B $C926,$01,$01

b $C927 Ship Icon
@ $C927 label=ShipIcon
D $C927 The small picture of a ship that #R$CA3F draws beside the number of
. ships that each player has left. It is four bytes wide and nine rows high.
B $C927,$02,$02
B $C929,$24,$04

b $C94D Horizontal Tick Graphic
@ $C94D label=HorizontalTickGraphic
D $C94D A mark that #R$CACB draws along the top and bottom edges of the frame:
. one byte wide and six rows high.
B $C94D,$02,$02
B $C94F,$06,$01

b $C955 Vertical Tick Graphic
@ $C955 label=VerticalTickGraphic
D $C955 A mark that #R$CACB draws along the left and right edges of the frame:
. one byte wide and six rows high.
B $C955,$02,$02
B $C957,$06,$01

b $C95D Unused
@ $C95D label=Unused_C95D
D $C95D Not referenced by the code.
B $C95D,$12,$06

c $C96F Draw Bitmap
@ $C96F label=DrawBitmap
D $C96F Draws a bitmap on the screen. The bitmap starts with its width in bytes
. and its height in rows, followed by the bytes for each row. The position is
. that of the bottom row, and the rows are drawn going up the screen.
R $C96F DE Address of the bitmap
R $C96F HL Position (#REGh is the pixel row and #REGl is the pixel column)
R $C96F O:DE Address after the bitmap
  $C96F,$01 Stash #REGhl on the stack.
  $C970,$01 Read #REGde.
  $C971,$01 #REGb=#REGa.
  $C972,$01 Advance #REGde.
  $C973,$01 Read #REGde.
  $C974,$01 #REGc=#REGa.
  $C975,$01 Advance #REGde.
  $C976,$03 Call #R$A149.
  $C979,$01 #REGa=#REGb.
  $C97A,$03 The width of the bitmap.
@ $C97D label=DrawBitmap_Row
  $C97D,$01 Stash #REGhl on the stack.
  $C97E,$03 The width of the bitmap.
  $C981,$01 #REGb=#REGa.
@ $C982 label=DrawBitmap_Loop
  $C982,$01 Read #REGde.
  $C983,$01 Write #REGa where #REGhl points.
  $C984,$01 Advance #REGde.
  $C985,$01 Advance #REGhl.
  $C986,$02 Decrease #REGb and jump to #R$C982 until none remain.
  $C988,$01 Bring #REGhl back off the stack.
  $C989,$03 Call #R$A1C3.
  $C98C,$01 Step #REGc back.
  $C98D,$02 Jump to #R$C97D if the zero flag is clear.
  $C98F,$01 Bring #REGhl back off the stack.
  $C990,$01 Return.

c $C991 Fill Attributes
@ $C991 label=FillAttributes
D $C991 Fills an area of the attributes with one value. The area starts with
. its width, its height and the attribute. The position is that of the bottom
. row of the area, and the rows are filled going up the screen.
R $C991 DE Address of the area
R $C991 HL Position (#REGh is the pixel row and #REGl is the pixel column)
  $C991,$01 Read #REGde.
  $C992,$01 #REGb=#REGa.
  $C993,$01 Advance #REGde.
  $C994,$01 Read #REGde.
  $C995,$01 #REGc=#REGa.
  $C996,$03 Call #R$A170.
  $C999,$01 Advance #REGde.
  $C99A,$01 Read #REGde.
  $C99B,$01 Advance #REGde.
  $C99C,$01 Stash #REGde on the stack.
  $C99D,$01 #REGd=#REGa.
  $C99E,$01 #REGe=#REGb.
@ $C99F label=FillAttributes_Row
  $C99F,$01 Stash #REGhl on the stack.
  $C9A0,$01 #REGb=#REGe.
@ $C9A1 label=FillAttributes_Loop
  $C9A1,$01 Write #REGd where #REGhl points.
  $C9A2,$01 Advance #REGhl.
  $C9A3,$02 Decrease #REGb and jump to #R$C9A1 until none remain.
  $C9A5,$01 Bring #REGhl back off the stack.
  $C9A6,$01 Stash #REGbc on the stack.
  $C9A7,$03 #REGbc=#N$20.
  $C9AA,$01 Is #REGa zero?
  $C9AB,$02 Subtract #REGbc and the carry from #REGhl.
  $C9AD,$01 Bring #REGbc back off the stack.
  $C9AE,$01 Step #REGc back.
  $C9AF,$02 Jump to #R$C99F if the zero flag is clear.
  $C9B1,$01 Bring #REGde back off the stack.
  $C9B2,$01 Return.

c $C9B3 Copy Attributes
@ $C9B3 label=CopyAttributes
D $C9B3 Not used. Copies attributes from the bytes that follow the width and
. height of an area, rather than filling the area with one value as
. #R$C991 does.
R $C9B3 DE Address of the area
R $C9B3 HL Position (#REGh is the pixel row and #REGl is the pixel column)
  $C9B3,$01 Stash #REGhl on the stack.
  $C9B4,$01 Read #REGde.
  $C9B5,$01 #REGb=#REGa.
  $C9B6,$01 Advance #REGde.
  $C9B7,$01 Read #REGde.
  $C9B8,$01 #REGc=#REGa.
  $C9B9,$03 Call #R$A170.
  $C9BC,$01 #REGa=#REGb.
  $C9BD,$03 The width of the attribute area.
  $C9C0,$01 Advance #REGde.
@ $C9C1 label=CopyAttributes_Row
  $C9C1,$01 Stash #REGhl on the stack.
  $C9C2,$03 The width of the attribute area.
  $C9C5,$01 #REGb=#REGa.
@ $C9C6 label=CopyAttributes_Byte
  $C9C6,$01 Read #REGde.
  $C9C7,$01 Write #REGa where #REGhl points.
  $C9C8,$01 Advance #REGde.
  $C9C9,$01 Advance #REGhl.
  $C9CA,$02 Decrease #REGb and jump to #R$C9C6 until none remain.
  $C9CC,$01 Bring #REGhl back off the stack.
  $C9CD,$01 Stash #REGde on the stack.
  $C9CE,$03 #REGde=#N$20.
  $C9D1,$01 Is #REGa zero?
  $C9D2,$02 Subtract #REGde and the carry from #REGhl.
  $C9D4,$01 Bring #REGde back off the stack.
  $C9D5,$01 Step #REGc back.
  $C9D6,$02 Jump to #R$C9C1 if the zero flag is clear.
  $C9D8,$01 Bring #REGhl back off the stack.
  $C9D9,$01 Return.

b $C9DA HUD Text
@ $C9DA label=HUDText
D $C9DA The eight text records that #R$CA3F prints at the top of the screen,
. in the format that #R$A115 prints: the column, the row, the attribute, the
. number of characters and then the characters. The digits of the two scores
. and of the numbers of ships are changed as the game goes on. A zero ends the
. records.
B $C9DA,$04,$04 Player 1: "SCORE" label
B $C9DE,$05,$05
B $C9E3,$04,$04 Player 2: "SCORE" label
B $C9E7,$05,$05
@ $C9EC label=HUDText_Player1Score
B $C9EC,$04,$04 Player 1: score
@ $C9F0 label=HUDText_Player1ScoreDigits
B $C9F0,$06,$06
@ $C9F6 label=HUDText_Player1Ships
B $C9F6,$04,$04 Player 1: ships left
B $C9FA,$02,$02
@ $C9FC label=HUDText_Player2Score
B $C9FC,$04,$04 Player 2: score
@ $CA00 label=HUDText_Player2ScoreDigits
B $CA00,$06,$06
B $CA06,$04,$04 Player 2: ships left
B $CA0A,$02,$02
B $CA0C,$04,$04 "HI" label
B $CA10,$02,$02
B $CA12,$04,$04 High score
@ $CA16 label=HUDText_HighScoreDigits
B $CA16,$06,$06
B $CA1C,$01,$01

g $CA1D Frame Parameters
@ $CA1D label=FrameParameters
D $CA1D The values that #R$CACB uses to draw the frame round the playfield.
. The addresses are screen addresses, and #R$CA3F sets up the two tables.
W $CA1D,$02,$02 Left vertical line
W $CA1F,$02,$02 Right vertical line
B $CA21,$01,$01 Number of rows in the vertical lines
W $CA22,$02,$02 Bottom horizontal lines
W $CA24,$02,$02 Top horizontal lines
W $CA26,$02,$02 Address of the corner table (set by #R$CA3F)
B $CA28,$01,$01 Number of ticks along each edge
W $CA29,$02,$02 Address of the tick table (set by #R$CA3F)
B $CA2B,$01,$01 Pixel row of the top edge
B $CA2C,$01,$01 Pixel column of the right edge
B $CA2D,$01,$01 Length of the horizontal lines, in bytes
@ $CA2E label=FrameParameters_Second
B $CA2E,$03,$03 Attribute area for the panel behind the text

c $CA31 Print Ships Remaining
@ $CA31 label=PrintShipsRemaining
D $CA31 Prints the number of ships that player 1 has left, which is one less
. than the number that is stored.
  $CA31,$03 The ships remaining.
  $CA34,$02 Add #N$19 to #REGa.
  $CA36,$03 The digit of the ships that are left.
  $CA39,$03 The player 1 ships text.
  $CA3C,$03 Jump to #R$A115.

c $CA3F Draw HUD
@ $CA3F label=DrawHUD
D $CA3F Draws the status panel at the top of the screen and the frame round the
. playfield. The panel has the scores, the numbers of ships with a ship icon
. beside each, and the high score. The frame has the sides, the lines along
. the top and bottom, the corners and some ticks. Last of all it draws the
. fuel gauge at the right.
. .
. #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$CA3F,stop=$C990,clear=1,sp=$FE00)
. #SCR$02(status-panel) } UDGTABLE# #POPS
  $CA3F,$02 #REGa=#N$46.
  $CA41,$03 Player one's score is bright yellow.
  $CA44,$02 #REGa=#N$42.
  $CA46,$03 Player two's score is bright red.
  $CA49,$03 #REGhl=#N$0F30.
  $CA4C,$03 The second copy of the frame parameters.
  $CA4F,$03 Call #R$C991.
  $CA52,$03 Call #R$CA31.
  $CA55,$03 The other player's ships.
  $CA58,$02 Add #N$1A to #REGa.
  $CA5A,$03 The digit of the other player's ships.
  $CA5D,$03 The hud text.
  $CA60,$02 #REGb=#N$08.
  $CA62,$03 Call #R$83CE.
  $CA65,$03 #REGhl=#N$0B30.
  $CA68,$03 The ship icon.
  $CA6B,$03 Call #R$C96F.
  $CA6E,$03 #REGhl=#N$0BB0.
  $CA71,$03 The ship icon.
  $CA74,$03 Call #R$C96F.
@ $CA77 label=DrawHUD_Frame
  $CA77,$04 The frame parameters.
  $CA7B,$03 The frame corner table.
  $CA7E,$03 Write #REGe to offset #N$09 of #REGix.
  $CA81,$03 Write #REGd to offset #N$0A of #REGix.
  $CA84,$03 The frame tick table.
  $CA87,$03 Write #REGe to offset #N$0C of #REGix.
  $CA8A,$03 Write #REGd to offset #N$0D of #REGix.
  $CA8D,$03 Call #R$CACB.
  $CA90,$03 Call #R$CABD.
  $CA93,$03 Call #R$CBAE.
  $CA96,$03 #REGhl=#N$37F0.
  $CA99,$01 Stash #REGhl on the stack.
  $CA9A,$03 The fuel gauge attributes.
  $CA9D,$03 Call #R$C991.
  $CAA0,$01 Bring #REGhl back off the stack.
  $CAA1,$03 The fuel label graphic.
  $CAA4,$03 Jump to #R$C96F.

c $CAA7 Colour Fuel Gauge
@ $CAA7 label=ColourFuelGauge
D $CAA7 Used on odd frames. When the fuel is low (the gauge level is at least
. #N($98)) the colour of the fuel gauge alternates between red and yellow
. every other frame, otherwise it is yellow. #R$CABD is the entry point that
. always uses yellow.
  $CAA7,$03 Fetch the frame counter from #R$9A64.
  $CAAA,$01 Keep it, so the next bit can be tested as well.
  $CAAB,$02,b$01 Is this an odd frame?
  $CAAD,$01 Return on an even frame.
  $CAAE,$03 Fetch the row of the top of the fuel.
  $CAB1,$04 Use yellow if the tank is not low.
  $CAB5,$04 Use yellow on the frames when bit 1 is clear.
  $CAB9,$02 Otherwise use red (#N$42).
  $CABB,$02 Fill the gauge with it.
@ $CABD label=ColourFuelGauge_Yellow
  $CABD,$02 The normal colour of the gauge is yellow (#N$46).
@ $CABF label=ColourFuelGauge_Fill
  $CABF,$03 Store the chosen colour in the gauge attributes.
  $CAC2,$03 The gauge hangs from the right of the bottom row.
  $CAC5,$03 The attribute area of the gauge.
  $CAC8,$03 Fill that area.

c $CACB Draw Frame
@ $CACB label=DrawFrame
D $CACB Draws the frame round the playfield from the values in the table at
. #R$CA1D: a vertical line at each side, a double horizontal line at the top
. and bottom, a graphic at each of the four corners with a coloured line along
. each edge, and then the ticks along the edges.
. .
. #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$F26C,stop=$F28B,clear=1,sp=$FE00)
. #SCR$02(playfield-frame) } UDGTABLE# #POPS
R $CACB IX Address of the table (#R$CA1D)
  $CACB,$03 The low byte of the address of the left side.
  $CACE,$03 The high byte of the address of the left side.
  $CAD1,$03 The low byte of the address of the right side.
  $CAD4,$03 The high byte of the address of the right side.
  $CAD7,$03 The number of rows in the two sides.
@ $CADA label=DrawFrame_Sides
  $CADA,$02 Plot the patterned byte #N$66 on the left side.
  $CADC,$02 The same byte for the right side.
  $CADE,$01 Plot it on the right side.
  $CADF,$03 Move the left side up one pixel row.
  $CAE2,$03 Move the right side up one pixel row.
  $CAE5,$02 Repeat for each row of the sides.
  $CAE7,$03 The low byte of the address of the bottom rules.
  $CAEA,$03 The high byte of the address of the bottom rules.
  $CAED,$03 The low byte of the address of the top rules.
  $CAF0,$03 The high byte of the address of the top rules.
  $CAF3,$03 Draw one pixel row of the top and bottom rules.
  $CAF6,$03 Draw the next pixel row of those rules.
  $CAF9,$01 Move the bottom rule up one pixel row.
  $CAFA,$01 Move the bottom rule up another pixel row.
  $CAFB,$01 Move the top rule up one pixel row.
  $CAFC,$01 Move the top rule up another pixel row.
  $CAFD,$03 Draw one pixel row of the inner rules.
  $CB00,$03 Draw the next pixel row of the inner rules.
  $CB03,$03 The corner graphics start at #R$CC14.
  $CB06,$04 Keep that address for the next corner.
  $CB0A,$03 The low byte of the address of the corner table.
  $CB0D,$03 The high byte of the address of the corner table.
  $CB10,$02 There are four corners.
@ $CB12 label=DrawFrame_Corners
  $CB12,$01 Keep the number of corners still to draw.
  $CB13,$03 Read the position of this corner graphic.
  $CB16,$01 Keep the place in the corner table.
  $CB17,$04 The graphic for this corner.
  $CB1B,$03 Draw the corner graphic.
  $CB1E,$04 The next corner graphic follows this one.
  $CB22,$01 Back to the corner table.
  $CB23,$03 Read the position of the coloured edge.
  $CB26,$03 Colour that edge.
  $CB29,$01 Bring back the number of corners.
  $CB2A,$02 Repeat for each corner.
  $CB2C,$03 The number of ticks along each edge.
  $CB2F,$03 The low byte of the address of the tick table.
  $CB32,$03 The high byte of the address of the tick table.
@ $CB35 label=DrawFrame_Ticks
  $CB35,$01 Keep the number of ticks still to draw.
  $CB36,$01 The pixel column of this tick.
  $CB37,$01 That column is its horizontal position.
  $CB38,$03 The pixel row of the top edge.
  $CB3B,$01 Keep the place in the tick table.
  $CB3C,$03 The top and bottom tick is #R$C94D.
  $CB3F,$03 Draw the tick on the top edge.
  $CB42,$02 The bottom edge is pixel row #N$BE.
  $CB44,$03 The same top and bottom tick.
  $CB47,$03 Draw the tick on the bottom edge.
  $CB4A,$01 Back to the tick table.
  $CB4B,$01 The next byte is the pixel row of the side ticks.
  $CB4C,$01 That row.
  $CB4D,$01 It is their vertical position.
  $CB4E,$02 The left edge is pixel column zero.
  $CB50,$01 Keep the place in the tick table.
  $CB51,$03 The side tick is #R$C955.
  $CB54,$03 Draw the tick on the left edge.
  $CB57,$03 The pixel column of the right edge.
  $CB5A,$03 The same side tick.
  $CB5D,$03 Draw the tick on the right edge.
  $CB60,$01 Back to the tick table.
  $CB61,$01 Move on to the next tick.
  $CB62,$01 Bring back the number of ticks.
  $CB63,$02 Repeat for each tick.
  $CB65,$01 Return.

b $CB66 Fuel Label Graphic
@ $CB66 label=FuelLabelGraphic
D $CB66 The word FUEL, written vertically, which is two bytes wide and
. #N($20) rows high. It is stored with the bottom row first, so the letters
. are in the order L, E, U and F.
B $CB66,$02,$02
B $CB68,$40,$02

b $CBA8 Fuel Gauge Attributes
@ $CBA8 label=FuelGaugeAttributes
D $CBA8 Two areas of attributes, each with a width, a height and an attribute.
. The first is for the label and the second is for the gauge: #R$CAA7 changes
. the attribute of the second.
B $CBA8,$03,$03
@ $CBAB label=FuelGaugeAttributes_Second
B $CBAB,$03,$03

c $CBAE Draw Fuel Gauge Frame
@ $CBAE label=DrawFuelGaugeFrame
D $CBAE Draws the outline of the fuel gauge: a cap at the bottom and one at
. the top, and a column of dots down the right of the gauge.
  $CBAE,$03 The bottom of the gauge is at #N$BFF0.
  $CBB1,$03 The bottom cap is at #R$CBDB.
  $CBB4,$03 Draw the bottom cap.
  $CBB7,$03 The top of the gauge is at #N$43F0.
  $CBBA,$03 The top cap is at #R$CBD1.
  $CBBD,$03 Draw the top cap.
  $CBC0,$03 The column of dots starts at #N$53FE.
  $CBC3,$02 There are #N($78) rows of dots.
@ $CBC5 label=DrawFuelGaugeFrame_Dots
  $CBC5,$02 Plot the left-hand dot.
  $CBC7,$01 Move across to the right-hand dot.
  $CBC8,$02 Plot the right-hand dot.
  $CBCA,$01 Back to the left-hand dot.
  $CBCB,$03 Move up one pixel row.
  $CBCE,$02 Repeat for every row of the gauge.
  $CBD0,$01 Return.

b $CBD1 Fuel Gauge Caps
@ $CBD1 label=FuelGaugeCaps
D $CBD1 The bitmaps for the top and the bottom of the fuel gauge, which are
. two bytes wide and four rows high.
B $CBD1,$0A,$0A Top
@ $CBDB label=FuelGaugeCaps_Second
B $CBDB,$0A,$0A Bottom

b $CBE5 Frame Tick Table
@ $CBE5 label=FrameTickTable
D $CBE5 The positions of the ticks that #R$CACB draws on the frame. Each pair
. is the pixel column of a tick along the top and bottom, and then the pixel
. row of a tick down the left and right.
B $CBE5,$0C,$02

c $CBF1 Fetch Position
@ $CBF1 label=FetchPosition
D $CBF1 Reads a position (pixel column first) from a table.
R $CBF1 DE Address of the position
R $CBF1 O:DE Address after the position
R $CBF1 O:HL Position (#REGh is the pixel row and #REGl is the pixel column)
  $CBF1,$01 Fetch the pixel column.
  $CBF2,$01 Move on to the pixel row.
  $CBF3,$01 Keep the column.
  $CBF4,$01 Fetch the pixel row.
  $CBF5,$01 Move on past this position.
  $CBF6,$01 Keep the row.
  $CBF7,$01 Return.

b $CBF8 Frame Corner Table
@ $CBF8 label=FrameCornerTable
D $CBF8 Four entries of seven bytes for #R$CACB, one for each corner. Each has
. the position of the corner graphic, the position of an area of attributes
. along the edge and then the area (width, height and attribute).
B $CBF8,$07,$07 Bottom left
B $CBFF,$07,$07 Bottom right
B $CC06,$07,$07 Top left
B $CC0D,$07,$07 Top right

b $CC14 Frame Corner Graphics
@ $CC14 label=FrameCornerGraphics
D $CC14 The four corner graphics for #R$CACB, each of which is one byte wide
. and seven rows high.
B $CC14,$09,$09 Bottom left
B $CC1D,$09,$09 Bottom right
B $CC26,$09,$09 Top left
B $CC2F,$09,$09 Top right

c $CC38 Draw Line Pair
@ $CC38 label=DrawLinePair
D $CC38 Draws a horizontal line of solid bytes at each of two screen addresses
. and moves both addresses up one pixel row. The length of the lines is in
. offset #N($10) of the table.
R $CC38 DE Second screen address
R $CC38 HL First screen address
R $CC38 IX Address of the table (#R$CA1D)
R $CC38 O:DE Second screen address, one row up
R $CC38 O:HL First screen address, one row up
  $CC38,$03 The length of the rules, in bytes.
  $CC3B,$01 Keep the address of the first rule.
  $CC3C,$01 Keep the address of the second rule.
@ $CC3D label=DrawLinePair_Loop
  $CC3D,$02 Plot a solid byte on the first rule.
  $CC3F,$02 A solid byte is #N$FF.
  $CC41,$01 Plot it on the second rule.
  $CC42,$01 Move along the second rule.
  $CC43,$01 Move along the first rule.
  $CC44,$02 Repeat for the whole length of the rules.
  $CC46,$01 Back to the start of the second rule.
  $CC47,$01 Back to the start of the first rule.
  $CC48,$01 Move the second rule up one pixel row.
  $CC49,$01 Move the first rule up one pixel row.
  $CC4A,$01 Return.

g $CC4B Fuel Level
@ $CC4B label=FuelLevel
D $CC4B The amount of fuel that is left. The high byte is the row of the fuel
. gauge: #N($42) when the tank is full and #N($BE) when it is empty.
W $CC4B,$02,$02

c $CC4D Use Fuel
@ $CC4D label=UseFuel
D $CC4D Adds an amount to the fuel level, to use up some fuel (a positive
. amount) or to put some in (a negative one), keeping the high byte between
. #N($42) and #N($BE).
R $CC4D DE Amount
  $CC4D,$03 The fuel level.
N $CC50 See #POKE(infinite_fuel,Infinite Fuel).
  $CC50,$01 Add the amount.
  $CC51,$01 The high byte is the row of the top of the fuel.
  $CC52,$04 Carry on if that row is still on the gauge.
  $CC56,$02 Otherwise the tank is empty.
@ $CC58 label=UseFuel_Upper
  $CC58,$04 Carry on if the tank is not fuller than full.
  $CC5C,$02 Otherwise the tank is full.
@ $CC5E label=UseFuel_Store
  $CC5E,$03 Write the new fuel level.
  $CC61,$01 Return.

g $CC62 Fuel Gauge Row
@ $CC62 label=FuelGaugeRow
D $CC62 The pixel row that the fuel gauge is currently showing, which
. #R$CC77 moves one row at a time towards the high byte of the fuel level.
B $CC62,$01,$01

c $CC63 Check Fuel Empty
@ $CC63 label=CheckFuelEmpty
D $CC63 Used when the fuel gauge has reached the level of the fuel. If the ship
. is in its normal state, the gauge is at the empty row and the bottom seven
. bits of the frame counter are zero, the ship is put in state 1: out of fuel.
R $CC63 B Pixel row of the fuel gauge
  $CC63,$03 The state of the ship.
  $CC66,$02 Return unless the ship is flying normally.
  $CC68,$01 The row of the needle.
  $CC69,$03 Return unless the needle is on the empty row.
  $CC6C,$03 The frame counter.
  $CC6F,$02,b$01 The bottom seven bits.
  $CC71,$01 Return unless they are all clear.
  $CC72,$01 The out-of-fuel state is one.
  $CC73,$03 Put the ship in that state.
  $CC76,$01 Return.

c $CC77 Update Fuel Gauge
@ $CC77 label=UpdateFuelGauge
D $CC77 Moves the needle of the fuel gauge one row towards the level of the
. fuel. The needle is a small marker that is drawn at the right of the gauge
. using XOR, so drawing it again at the same row erases it.
  $CC77,$03 Colour the gauge.
  $CC7A,$03 The row the needle is on.
  $CC7D,$01 Keep that row.
  $CC7E,$03 The row of the top of the fuel.
  $CC81,$01 How far the needle is from the fuel.
  $CC82,$02 The needle has arrived: see if the tank is empty.
  $CC84,$01 Step the needle one row up.
  $CC85,$01 The upper row of the marker.
  $CC86,$04 The fuel is above the needle, so that step stands.
  $CC8A,$01 The fuel is below, so put that row back.
  $CC8B,$01 The row the needle is leaving.
  $CC8C,$01 Step the needle one row down.
@ $CC8D label=UpdateFuelGauge_Store
  $CC8D,$01 The new row of the needle.
  $CC8E,$03 Remember it.
  $CC91,$01 The other row of the marker.
  $CC92,$03 Keep it while the screen address is found.
  $CC95,$02 The needle sits in the right-hand column.
  $CC97,$03 Find the screen address of that row.
  $CC9A,$02 The upper part of the marker.
  $CC9C,$01 Toggle it into the screen byte.
  $CC9D,$01 Write that byte back.
  $CC9E,$01 The next byte of the marker.
  $CC9F,$02 The right-hand bit of the upper part.
  $CCA1,$01 Toggle it into the screen byte.
  $CCA2,$01 Write that byte back.
  $CCA3,$03 The other row of the marker.
  $CCA6,$03 Nothing more to draw once the needle is this low.
  $CCA9,$01 The row below that one.
  $CCAA,$01 That row.
  $CCAB,$02 The same column.
  $CCAD,$03 Find the screen address.
  $CCB0,$02 The lower part of the marker.
  $CCB2,$01 Toggle it into the screen byte.
  $CCB3,$01 Write that byte back.
  $CCB4,$01 The next byte of the marker.
  $CCB5,$02 The right-hand bit of the lower part.
  $CCB7,$01 Toggle it into the screen byte.
  $CCB8,$01 Write that byte back.
  $CCB9,$01 Return.

g $CCBA Vertical Speed
@ $CCBA label=VerticalSpeed
D $CCBA The vertical scroll speed: how many pixel rows the world moves each
. frame. It is negative when the ship is going up the screen.
B $CCBA,$01,$01

g $CCBB Horizontal Speed
@ $CCBB label=HorizontalSpeed
D $CCBB The horizontal scroll speed: how many pixels the world moves sideways
. each frame. It is negative when the ship is going to the left.
B $CCBB,$01,$01

g $CCBC Star Flags
@ $CCBC label=StarFlags
D $CCBC Flags for the layers of stars. Bit 0 is set when a star has been drawn
. (see #R$C032 and #R$C10E). Purpose not yet known for the other bits.
B $CCBC,$01,$01

g $CCBD Shape Table Pointer
@ $CCBD label=ShapeTablePointer
D $CCBD The address of the table of shapes for the current horizontal scroll
. offset, which is one of #R$E2BD, #R$E2FD, #R$E33D and #R$E37D. #R$D0BD sets
. it.
W $CCBD,$02,$02

b $CCBF Picture Offsets
@ $CCBF label=PictureOffsets
D $CCBF Six bytes for each of the nine types of slope listed at #R$E3BD. The
. terrain drawing routine at #R$D0BD points #R$CE51 at the entry for the type
. of the current segment and #R$D672 uses the third and later bytes as offsets
. into the picture of the segment. The first two bytes are always zero. The
. values are repeated by the types that are the same shape.
B $CCBF,$36,$06

c $CCF5 Advance Screen Address
@ $CCF5 label=AdvanceScreenAddress
D $CCF5 Moves the screen address of the segment that is being drawn along by
. the column step of its type, and then clears the column step and the
. horizontal step ready for the next segment.
  $CCF5,$03 The segment screen address.
  $CCF8,$01 #REGb=#REGa.
  $CCF9,$03 The column step.
  $CCFC,$01 #REGa gains #REGb.
  $CCFD,$03 Update the segment screen address.
  $CD00,$01 Clear #REGa.
  $CD01,$03 Update the column step.
  $CD04,$03 Update the horizontal step.
  $CD07,$01 Return.

c $CD08 Set Up Segment
@ $CD08 label=SetUpSegment
D $CD08 Sets up the variables for a segment of the tile, whose type is at
. offset #N$03 of the segment record. When the tile is drawn upside down the
. type is first changed with the table at #R$CE14. #R$E3D8 then loads the three
. steps of the type. The routine stores a vertical step of #N$04 if the type
. has none (and so is flat), and stores the absolute values of the column and
. horizontal steps in #R$5C24 and #R$5C25. If the tile is upside down it moves
. the pixel position of a vertical segment sideways.
R $CD08 IX Address of the segment record
  $CD08,$03 The upside down flag.
  $CD0B,$03 Jump to #R$CD1B if #REGa is zero.
  $CD0E,$03 Read offset #N$03 of #REGix into #REGe.
  $CD11,$02 Clear #REGd.
  $CD13,$03 The flip type table.
  $CD16,$01 #REGhl gains #REGde.
  $CD17,$01 Read #REGhl.
  $CD18,$03 Write #REGa to offset #N$03 of #REGix.
@ $CD1B label=SetUpSegment_Steps
  $CD1B,$03 Call #R$E3D8.
  $CD1E,$03 The vertical step.
  $CD21,$03 Update the vertical step copy.
  $CD24,$03 Jump to #R$CD2C if #REGa is not zero.
  $CD27,$02,b$01 Set the bits of #REGa that are set in #N$04.
  $CD29,$03 Update the vertical step copy.
@ $CD2C label=SetUpSegment_Column
  $CD2C,$03 The column step.
  $CD2F,$03 Update the column step size.
  $CD32,$03 The horizontal step.
  $CD35,$03 Update the horizontal step copy.
  $CD38,$03 Jump to #R$CD44 if #REGa is not zero.
  $CD3B,$03 The slope direction.
  $CD3E,$02 Negate #REGa.
  $CD40,$01 Double #REGa.
  $CD41,$01 Double #REGa.
  $CD42,$01 Double #REGa.
  $CD43,$01 #REGb=#REGa.
@ $CD44 label=SetUpSegment_Absolute
  $CD44,$03 Update the horizontal step size.
  $CD47,$04 Jump to #R$CD58 if bit 7 of #REGa is clear.
  $CD4B,$02 Negate #REGa.
  $CD4D,$03 Update the horizontal step size.
  $CD50,$03 The column step size.
  $CD53,$02 Negate #REGa.
  $CD55,$03 Update the column step size.
@ $CD58 label=SetUpSegment_Flip
  $CD58,$03 The upside down flag.
  $CD5B,$03 Return if #REGa is not #N$99.
  $CD5E,$03 The horizontal step copy.
  $CD61,$02 Return if #REGa is not zero.
  $CD63,$03 The segment column.
  $CD66,$01 #REGa gains #REGb.
  $CD67,$03 Update the segment column.
  $CD6A,$01 Return.

c $CD6B Read Segment Shapes
@ $CD6B label=ReadSegmentShapes
D $CD6B Reads the two bytes that give the shapes at the ends of a flat segment
. from the script and stores them in #R$5C33 and #R$5C34. It changes them if
. the tile is drawn back to front or upside down. When the tile is back to
. front the horizontal position of the segment is mirrored and its type is
. changed with the table at #R$CE04. The routine finally stores the address of
. the rest of the script in #R$CE4D.
R $CD6B HL Address of the shape bytes in the script
R $CD6B O:HL Address of the next segment in the script
  $CD6B,$03 The vertical step.
  $CD6E,$03 Jump to #R$CDC3 if #REGa is not zero.
  $CD71,$03 The upside down flag.
  $CD74,$03 Jump to #R$CD7F if #REGa is zero.
  $CD77,$03 The segment row.
  $CD7A,$02,b$01 Flip the bits of #REGa that are set in #N$0C.
  $CD7C,$03 Update the segment row.
@ $CD7F label=ReadSegmentShapes_BackToFront
  $CD7F,$03 The back to front flag.
  $CD82,$03 Jump to #R$CD9F if #REGa is zero.
  $CD85,$01 Read #REGhl.
  $CD86,$02,b$01 Flip the bits of #REGa that are set in #N$02.
  $CD88,$03 Update the segment end shape.
  $CD8B,$01 Advance #REGhl.
  $CD8C,$01 Read #REGhl.
  $CD8D,$04 Jump to #R$CD99 if #REGa is #N$16.
  $CD91,$02,b$01 Flip the bits of #REGa that are set in #N$02.
  $CD93,$03 Update the segment start shape.
  $CD96,$01 Advance #REGhl.
  $CD97,$02 Jump to #R$CDA9.
@ $CD99 label=ReadSegmentShapes_End
  $CD99,$03 Update the segment end shape.
  $CD9C,$01 Advance #REGhl.
  $CD9D,$02 Jump to #R$CDA9.
@ $CD9F label=ReadSegmentShapes_Normal
  $CD9F,$01 Read #REGhl.
  $CDA0,$03 Update the segment start shape.
  $CDA3,$01 Advance #REGhl.
  $CDA4,$01 Read #REGhl.
  $CDA5,$03 Update the segment end shape.
  $CDA8,$01 Advance #REGhl.
@ $CDA9 label=ReadSegmentShapes_UpsideDown
  $CDA9,$03 The upside down flag.
  $CDAC,$03 Jump to #R$CDC3 if #REGa is zero.
  $CDAF,$03 The segment start shape.
  $CDB2,$02,b$01 Flip the bits of #REGa that are set in #N$01.
  $CDB4,$03 Update the segment start shape.
  $CDB7,$03 The segment end shape.
  $CDBA,$04 Jump to #R$CDC3 if #REGa is #N$16.
  $CDBE,$02,b$01 Flip the bits of #REGa that are set in #N$01.
  $CDC0,$03 Update the segment end shape.
@ $CDC3 label=ReadSegmentShapes_Store
  $CDC3,$03 Update the script pointer.
  $CDC6,$03 The back to front flag.
  $CDC9,$02 Return if #REGa is zero.
  $CDCB,$03 The segment end shape.
  $CDCE,$03 Return if #REGa is #N$16.
  $CDD1,$03 The segment column.
  $CDD4,$01 #REGb=#REGa.
  $CDD5,$03 The horizontal step size.
  $CDD8,$01 #REGa gains #REGb.
  $CDD9,$02 Add #N$0F to #REGa.
  $CDDB,$01 Invert #REGa.
  $CDDC,$03 Update the segment column.
  $CDDF,$01 Switch to the alternate registers.
  $CDE0,$03 Read offset #N$03 of #REGix into #REGe.
  $CDE3,$02 Clear #REGd.
  $CDE5,$03 The mirror type table.
  $CDE8,$01 #REGhl gains #REGde.
  $CDE9,$01 Read #REGhl.
  $CDEA,$03 Write #REGa to offset #N$03 of #REGix.
  $CDED,$03 Call #R$E3D8.
  $CDF0,$01 Switch to the alternate registers.
  $CDF1,$03 The vertical step.
  $CDF4,$02 Return if #REGa is not zero.
  $CDF6,$01 #REGb=#REGc.
  $CDF7,$03 The segment column.
  $CDFA,$01 Step #REGb back.
  $CDFB,$01 Return if the zero flag is set.
@ $CDFC label=ReadSegmentShapes_Position
  $CDFC,$02 Subtract #N$18 from #REGa.
  $CDFE,$02 Decrease #REGb and jump to #R$CDFC until none remain.
  $CE00,$03 Update the segment column.
  $CE03,$01 Return.

b $CE04 Mirror Type Table
@ $CE04 label=MirrorTypeTable
D $CE04 The type to use for each of the sixteen types of segment when the tile
. is drawn back to front. #R$CD6B uses it.
B $CE04,$10,$10

b $CE14 Flip Type Table
@ $CE14 label=FlipTypeTable
D $CE14 The type to use for each of the sixteen types of segment when the tile
. is drawn upside down. #R$CD08 uses it.
B $CE14,$10,$10

b $CE24 Column Phase Table
@ $CE24 label=ColumnPhaseTable
D $CE24 A value from #N$00 to #N$02 for each step of a segment, which #R$D3D2
. uses to choose the part of the picture to draw. The last byte is not used.
B $CE24,$11,$10

g $CE35 Horizontal Step
@ $CE35 label=HorizontalStep
D $CE35 The number of pixels that the current type of segment moves across the
. screen at each step, which is negative if it goes to the left. It is the
. first of the three steps that #R$E3D8 loads, and is also used by the routines
. that draw the ship parts.
B $CE35,$01,$01

g $CE36 Column Step
@ $CE36 label=ColumnStep
D $CE36 The second of the steps that #R$E3D8 loads: the number added to the
. screen address at each step of a segment, which is negative if it goes to the
. left.
B $CE36,$01,$01

g $CE37 Vertical Step
@ $CE37 label=VerticalStep
D $CE37 The third of the steps that #R$E3D8 loads: the number of pixel rows
. that the current type of segment moves down the screen at each step, which is
. zero for a flat segment.
B $CE37,$01,$01

s $CE38 Not Used
S $CE38,$02,$02

g $CE3A Scratch Values
@ $CE3A label=ScratchValues
D $CE3A Four bytes that many of the routines use for temporary values, and
. which #R$BEE7 uses for the position of an object within a tile.
B $CE3A,$04,$01

g $CE3E Attribute Rows
@ $CE3E label=AttributeRows
D $CE3E The number of rows of attributes that #R$CF38 colours at each step of a
. segment.
B $CE3E,$01,$01

g $CE3F Vertical Distance
@ $CE3F label=VerticalDistance
D $CE3F The number of pixel rows that the world moves vertically in a frame,
. which is the vertical speed without its sign. #R$DDF8 sets it. #R$D9A8 uses
. it as the number of rows of the edge to fill, with #R$DB49 if it is four and
. #R$DB41 otherwise.
B $CE3F,$01,$01

g $CE40 Segment Height
@ $CE40 label=SegmentHeight
D $CE40 Set by #R$D3D2 to the pixel row where the picture of a segment starts.
. #R$D672 reads it.
B $CE40,$01,$01

g $CE41 Horizontal Offset
@ $CE41 label=HorizontalOffset
D $CE41 How far the view of the world is across the first tile, from #N$00 to
. #N$20 pixels. #R$DE46 adds the horizontal speed to it. Its bottom three bits
. choose which of the tables of shifted pictures is used.
B $CE41,$01,$01

g $CE42 Vertical Offset
@ $CE42 label=VerticalOffset
D $CE42 How far the view of the world is down the first tile, from #N$00 to
. #N$A0 pixel rows. #R$DE09 adds the vertical speed to it.
B $CE42,$01,$01

g $CE43 Segment Column
@ $CE43 label=SegmentColumn
D $CE43 The pixel column where the current segment starts. The script gives it
. and #R$D319 adds the horizontal step at each step of the segment.
B $CE43,$01,$01

g $CE44 Segment Row
@ $CE44 label=SegmentRow
D $CE44 The pixel row where the current segment starts. The script gives it and
. #R$D319 subtracts the vertical step at each step of the segment.
B $CE44,$01,$01

g $CE45 Position Across
@ $CE45 label=PositionAcross
D $CE45 The pixel column that the tests of a segment at #R$D25A compare the
. segment with. #R$DE46 subtracts the horizontal speed from it, and when it
. leaves the range #N$08 to #N$E8 (the width of the area of the terrain) the
. map position moves one tile and it wraps round.
B $CE45,$01,$01

g $CE46 Position Down
@ $CE46 label=PositionDown
D $CE46 The pixel row that the tests of a segment at #R$D25A compare the
. segment with. #R$DE09 subtracts the vertical speed from it, and when it
. leaves the range #N$17 to #N$B7 (the height of the area of the terrain) the
. map position moves one tile and it wraps round.
B $CE46,$01,$01

g $CE47 Picture Pointer
@ $CE47 label=PicturePointer
D $CE47 The address of the picture of the current segment, which #R$D3D2 sets
. and #R$D672 reads.
W $CE47,$02,$02

g $CE49 Segment Screen Address
@ $CE49 label=SegmentScreenAddress
D $CE49 The screen address where the drawing of the current segment is up to.
W $CE49,$02,$02

g $CE4B Picture Offsets Pointer
@ $CE4B label=PictureOffsetsPointer
D $CE4B A pointer into #R$CCBF that #R$D0BD sets: to the start of the table
. when the horizontal offset has no pixels to the side of a whole byte, or one
. byte on otherwise. #R$D3D2 adds the offset of the type to set #R$CE51.
W $CE4B,$02,$02

g $CE4D Script Pointer
@ $CE4D label=ScriptPointer
D $CE4D The address in the script of the next segment, which #R$CD6B sets.
W $CE4D,$02,$02

g $CE4F Saved Screen Address
@ $CE4F label=SavedScreenAddress
D $CE4F A screen address that #R$D5EC and #R$D937 store. #R$D711 and #R$D8DA
. read it.
W $CE4F,$02,$02

g $CE51 Segment Picture Offsets
@ $CE51 label=SegmentPictureOffsets
D $CE51 The address of the six bytes in #R$CCBF for the type of the current
. segment, which #R$D3D2 sets.
W $CE51,$02,$02

g $CE53 Saved Row
@ $CE53 label=SavedRow
D $CE53 A pixel row that #R$D937 stores. #R$D711 and #R$D8DA read it.
B $CE53,$01,$01

g $CE54 Steps Drawn
@ $CE54 label=StepsDrawn
D $CE54 The number of steps of the current segment that have been drawn so far.
B $CE54,$01,$01

g $CE55 Start Column
@ $CE55 label=StartColumn
D $CE55 The pixel column where the first step that was seen of the current
. segment started, which #R$D979 stores.
B $CE55,$01,$01

g $CE56 Start Row
@ $CE56 label=StartRow
D $CE56 The pixel row where the first step that was seen of the current segment
. started, which #R$D979 stores.
B $CE56,$01,$01

g $CE57 Map Position
@ $CE57 label=MapPosition
D $CE57 The map column (in the first byte) and map row (in the second) of the
. tile at the top left of the view of the world.
B $CE57,$02,$01

g $CE59 Horizontal Step Copy
@ $CE59 label=HorizontalStepCopy
D $CE59 A copy of the horizontal step of the type of the current segment. It is
. zero for a vertical segment.
B $CE59,$01,$01

g $CE5A Vertical Step Copy
@ $CE5A label=VerticalStepCopy
D $CE5A A copy of the vertical step of the type of the current segment, which
. is set to #N$04 when it is zero. Some routines use it as a count of rows.
B $CE5A,$01,$01

c $CE5B Count Vertical Contact
@ $CE5B label=CountVerticalContact
D $CE5B Used when the ship touches the top or bottom of a segment. On the top
. row of tiles a vertical segment is made to end at the next step. The count of
. steps drawn is increased, and when it is the first the start of the segment
. is noted with #R$D979. The routine then carries on with the next step at
. #R$D724.
  $CE5B,$03 The tile number.
  $CE5E,$04 Jump to #R$CE6A if bit 0 of #REGa is set.
  $CE62,$03 The vertical step.
  $CE65,$03 Jump to #R$CE6A if #REGa is zero.
  $CE68,$02 #REGc=#N$01.
@ $CE6A label=CountVerticalContact_Count
  $CE6A,$03 The steps already drawn.
  $CE6D,$01 Advance #REGa.
  $CE6E,$03 Update the steps already drawn.
  $CE71,$05 Call #R$D979 if #REGa is #N$01.
  $CE76,$03 Jump to #R$D724.

c $CE79 Record Floor Contact
@ $CE79 label=FlagFloorContact
D $CE79 Used when the ship is on the same row as a step of a segment. It sets
. bit 7 of the contact flags at #R$5C31. If the vertical speed is not negative
. it also sets bit 0 (clearing bit 7) and copies the flags into #R$5C32. It
. carries on at #R$D36C.
  $CE79,$03 The contact flags.
  $CE7C,$02,b$01 Set the bits of #REGa that are set in #N$80.
  $CE7E,$03 Update the contact flags.
  $CE81,$03 The vertical scroll speed.
  $CE84,$05 Jump to #R$D36C if bit 7 of #REGa is set.
  $CE89,$03 The contact flags.
  $CE8C,$02,b$01 Flip the bits of #REGa that are set in #N$81.
  $CE8E,$03 Update the contact flags.
  $CE91,$03 Update the last contact flags.
  $CE94,$03 Jump to #R$D36C.

c $CE97 Record Ceiling Contact
@ $CE97 label=FlagCeilingContact
D $CE97 Used when the ship is on the same row as a step of a segment in the
. bottom half of the tile. It sets bit 7 of the contact flags at #R$5C31. If
. the vertical speed is negative it also sets bit 1 (clearing bit 7) and copies
. the flags into #R$5C32. It carries on at #R$D36C.
  $CE97,$03 The contact flags.
  $CE9A,$02,b$01 Set the bits of #REGa that are set in #N$80.
  $CE9C,$03 Update the contact flags.
  $CE9F,$03 The vertical scroll speed.
  $CEA2,$05 Jump to #R$D36C if bit 7 of #REGa is clear.
  $CEA7,$03 The contact flags.
  $CEAA,$02,b$01 Flip the bits of #REGa that are set in #N$82.
  $CEAC,$03 Update the contact flags.
  $CEAF,$03 Update the last contact flags.
  $CEB2,$03 Jump to #R$D36C.

c $CEB5 Record Left Contact
@ $CEB5 label=FlagLeftContact
D $CEB5 Used when the ship is in the same column as a step of a segment. When
. the horizontal speed is negative it sets bit 3 of the contact flags at
. #R$5C31 and carries on at #R$D3B0. Otherwise the next step is drawn.
  $CEB5,$03 The horizontal scroll speed.
  $CEB8,$05 Jump to #R$D724 if bit 7 of #REGa is clear.
  $CEBD,$03 The contact flags.
  $CEC0,$02,b$01 Set the bits of #REGa that are set in #N$08.
  $CEC2,$03 Update the contact flags.
  $CEC5,$03 Jump to #R$D3B0.

c $CEC8 Record Right Contact
@ $CEC8 label=FlagRightContact
D $CEC8 Used when the ship is in the same column as a step of a segment. When
. the horizontal speed is not negative it sets bit 2 of the contact flags at
. #R$5C31 and carries on at #R$D3B0. Otherwise the next step is drawn.
  $CEC8,$03 The horizontal scroll speed.
  $CECB,$05 Jump to #R$D724 if bit 7 of #REGa is set.
  $CED0,$03 The contact flags.
  $CED3,$02,b$01 Set the bits of #REGa that are set in #N$04.
  $CED5,$03 Update the contact flags.
  $CED8,$03 Jump to #R$D3B0.

c $CEDB Note Wall Contact
@ $CEDB label=NoteWallContact
D $CEDB Used when the ship has touched the side of a segment. For a segment
. that has a horizontal step the remaining length is limited to two steps if
. the slope goes the way that the tile is facing. If the ship has not touched a
. segment already the routine finds the screen address of the start with
. #R$D937 and clears the first byte of the record. It carries on at #R$D716.
  $CEDB,$03 The horizontal step copy.
  $CEDE,$03 Jump to #R$CF01 if #REGa is zero.
  $CEE1,$03 The tile number.
  $CEE4,$04 Jump to #R$CEF8 if bit 1 of #REGa is set.
  $CEE8,$03 The slope direction.
  $CEEB,$04 Jump to #R$CF01 if #REGa is not #N$01.
@ $CEEF label=NoteWallContact_Limit
  $CEEF,$01 #REGa=#REGc.
  $CEF0,$04 Jump to #R$CF01 if #REGa is less than #N$02.
  $CEF4,$02 #REGc=#N$02.
  $CEF6,$02 Jump to #R$CF01.
@ $CEF8 label=NoteWallContact_Right
  $CEF8,$03 The slope direction.
  $CEFB,$04 Jump to #R$CF01 if #REGa is not #N$FF.
  $CEFF,$02 Jump to #R$CEEF.
@ $CF01 label=NoteWallContact_Check
  $CF01,$03 The flagged steps.
  $CF04,$04 Jump to #R$D716 if #REGa is not zero.
  $CF08,$01 Switch to the alternate registers.
  $CF09,$03 Call #R$D937.
  $CF0C,$01 Clear #REGa.
  $CF0D,$03 Write #REGa to offset #N$01 of #REGix.
  $CF10,$01 Switch to the alternate registers.
  $CF11,$03 Jump to #R$D716.

c $CF14 Test Attribute Address
@ $CF14 label=TestAttributeAddress
D $CF14 Tests the attribute address after the one in #REGhl. The top three rows
. of attributes and the last row are not part of the area where the terrain is
. drawn.
R $CF14 HL Attribute address
R $CF14 O:F Zero if the next address is outside the area of the terrain
  $CF14,$01 Advance #REGhl.
  $CF15,$01 #REGa=#REGh.
  $CF16,$04 Jump to #R$CF28 if #REGa is not #N$58.
  $CF1A,$01 #REGa=#REGl.
  $CF1B,$02,b$01 Keep the bits of #REGa that are set in #N$E0.
  $CF1D,$04 Jump to #R$CF25 if #REGa is less than #N$60.
@ $CF21 label=TestAttributeAddress_Inside
  $CF21,$01 Step #REGhl back.
  $CF22,$02,b$01 Set the bits of #REGa that are set in #N$FF.
  $CF24,$01 Return.
@ $CF25 label=TestAttributeAddress_Outside
  $CF25,$01 Step #REGhl back.
  $CF26,$01 Clear #REGa.
  $CF27,$01 Return.
@ $CF28 label=TestAttributeAddress_Rows
  $CF28,$01 #REGa=#REGh.
  $CF29,$04 Jump to #R$CF21 if #REGa is not #N$5A.
  $CF2D,$01 #REGa=#REGl.
  $CF2E,$02,b$01 Keep the bits of #REGa that are set in #N$E0.
  $CF30,$04 Jump to #R$CF25 if #REGa is #N$E0 or more.
  $CF34,$02 Jump to #R$CF21.

c $CF36 Jump To Painter
@ $CF36 label=JumpToPainter
D $CF36 Jumps to the routine that paints one row of attributes, which #R$CF38
. has chosen: one of #R$D04F, #R$D063 and #R$D082.
  $CF36,$02 Jump to the address in #REGiy.

c $CF38 Colour Segment
@ $CF38 label=ColourSegment
D $CF38 Colours the attribute cells that a segment covers, one step at a time.
. Nothing is coloured if #R$5C3C is set or if the drawing record has no screen
. address or no length. The number of cells across at each step (one to three)
. chooses the routine that paints the cells of a column: a flat segment is
. painted three cells across. The colour is #R$5C3A for a tile on the top row
. and #R$5C3B for one on the bottom row, with the colours at #R$DC95 and
. #R$DC96 used for some of the tiles on map rows #N$0B and #N$0C.
E $CF38 Continue on to #R$D04F.
R $CF38 IX Address of the drawing record at #R$DEDC
  $CF38,$03 The scroll-in flag.
  $CF3B,$02 Return if #REGa is not zero.
  $CF3D,$03 Read offset #N$01 of #REGix.
  $CF40,$02 Return if #REGa is zero.
  $CF42,$03 Read offset #N$02 of #REGix.
  $CF45,$02 Return if #REGa is zero.
  $CF47,$03 The horizontal step copy.
  $CF4A,$03 Jump to #R$CF54 if #REGa is not zero.
  $CF4D,$03 Update the column step.
  $CF50,$01 Advance #REGa.
  $CF51,$03 Update the column step size.
@ $CF54 label=ColourSegment_Cells
  $CF54,$03 The column step size.
  $CF57,$01 Advance #REGa.
  $CF58,$01 #REGc=#REGa.
  $CF59,$03 The slope direction.
  $CF5C,$04 Jump to #R$CF6A if #REGa is #N$FF.
  $CF60,$03 Read offset #N$00 of #REGix.
  $CF63,$02 Subtract #N$02 from #REGa.
  $CF65,$02,b$01 Keep the bits of #REGa that are set in #N$F8.
  $CF67,$03 Write #REGa to offset #N$00 of #REGix.
@ $CF6A label=ColourSegment_Painter
  $CF6A,$01 #REGa=#REGc.
  $CF6B,$04 The paint one column.
  $CF6F,$04 Jump to #R$CF7F if #REGa is #N$01.
  $CF73,$04 The paint two columns.
  $CF77,$04 Jump to #R$CF7F if #REGa is #N$02.
  $CF7B,$04 The paint three columns.
@ $CF7F label=ColourSegment_Rows
  $CF7F,$03 The vertical step.
  $CF82,$02 Shift #REGa right.
  $CF84,$02 Shift #REGa right.
  $CF86,$02 Shift #REGa right.
  $CF88,$03 Update the vertical step copy.
  $CF8B,$03 Read offset #N$00 of #REGix into #REGl.
  $CF8E,$03 Read offset #N$01 of #REGix into #REGh.
  $CF91,$03 The vertical step copy.
  $CF94,$03 Update the attribute rows.
  $CF97,$01 #REGa=#REGh.
  $CF98,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $CF9A,$02,b$01 Flip the bits of #REGa that are set in #N$07.
  $CF9C,$02 Jump to #R$CFA5 if the zero flag is set.
  $CF9E,$03 The attribute rows.
  $CFA1,$01 Advance #REGa.
  $CFA2,$03 Update the attribute rows.
@ $CFA5 label=ColourSegment_Flat
  $CFA5,$03 Read offset #N$03 of #REGix.
  $CFA8,$03 Jump to #R$CFAF if #REGa is zero.
  $CFAB,$04 Jump to #R$CFC8 if #REGa is not #N$07.
@ $CFAF label=ColourSegment_FlatCells
  $CFAF,$04 The paint three columns.
  $CFB3,$01 Clear #REGa.
  $CFB4,$03 Update the vertical step copy.
  $CFB7,$01 #REGa=#REGh.
  $CFB8,$02 Subtract #N$0B from #REGa.
  $CFBA,$01 #REGb=#REGa.
  $CFBB,$01 #REGa=#REGh.
  $CFBC,$02,b$01 Set the bits of #REGa that are set in #N$07.
  $CFBE,$01 Subtract #REGb from #REGa.
  $CFBF,$02 Shift #REGa right.
  $CFC1,$02 Shift #REGa right.
  $CFC3,$02 Shift #REGa right.
  $CFC5,$03 Update the attribute rows.
@ $CFC8 label=ColourSegment_Address
  $CFC8,$01 #REGb=#REGl.
  $CFC9,$01 #REGa=#REGl.
  $CFCA,$04 Jump to #R$CFD0 if #REGa is less than #N$F0.
  $CFCE,$02 Clear #REGl.
@ $CFD0 label=ColourSegment_Convert
  $CFD0,$03 Call #R$A170.
  $CFD3,$01 #REGa=#REGb.
  $CFD4,$04 Jump to #R$CFD9 if #REGa is less than #N$F0.
  $CFD8,$01 Step #REGhl back.
@ $CFD9 label=ColourSegment_Colour
  $CFD9,$03 The top-tile colour.
  $CFDC,$01 #REGc=#REGa.
  $CFDD,$03 The tile number.
  $CFE0,$04 Jump to #R$CFE8 if bit 0 of #REGa is clear.
  $CFE4,$03 The bottom-tile colour.
  $CFE7,$01 #REGc=#REGa.
@ $CFE8 label=ColourSegment_Row
  $CFE8,$03 The map row.
  $CFEB,$04 Jump to #R$CFFC if #REGa is #N$0B.
  $CFEF,$04 Jump to #R$D012 if #REGa is not #N$0C.
  $CFF3,$03 The tile number.
  $CFF6,$04 Jump to #R$D012 if bit 0 of #REGa is set.
  $CFFA,$02 Jump to #R$D003.
@ $CFFC label=ColourSegment_Special
  $CFFC,$03 The tile number.
  $CFFF,$04 Jump to #R$D012 if bit 0 of #REGa is clear.
@ $D003 label=ColourSegment_Alternate
  $D003,$03 The underground attribute.
  $D006,$01 #REGc=#REGa.
  $D007,$03 The vertical edge in the tile.
  $D00A,$04 Jump to #R$D012 if #REGa is #N$67 or more.
  $D00E,$03 The sky attribute.
  $D011,$01 #REGc=#REGa.
@ $D012 label=ColourSegment_Paint
  $D012,$03 #REGde=#N$20.
  $D015,$03 Read offset #N$02 of #REGix into #REGb.
@ $D018 label=ColourSegment_Loop
  $D018,$01 Stash #REGbc on the stack.
  $D019,$03 The attribute rows.
  $D01C,$01 #REGb=#REGa.
  $D01D,$01 Stash #REGhl on the stack.
  $D01E,$03 Call #R$CF36.
  $D021,$01 Bring #REGhl back off the stack.
  $D022,$03 The vertical step copy.
  $D025,$03 Jump to #R$D02E if #REGa is zero.
  $D028,$01 #REGb=#REGa.
@ $D029 label=ColourSegment_Up
  $D029,$01 Is #REGa zero?
  $D02A,$02 Subtract #REGde and the carry from #REGhl.
  $D02C,$02 Decrease #REGb and jump to #R$D029 until none remain.
@ $D02E label=ColourSegment_Across
  $D02E,$03 The column step.
  $D031,$01 #REGc=#REGa.
  $D032,$02 Clear #REGb.
  $D034,$04 Jump to #R$D039 if bit 7 of #REGa is clear.
  $D038,$01 Step #REGb back.
@ $D039 label=ColourSegment_Advance
  $D039,$01 #REGhl gains #REGbc.
  $D03A,$01 Bring #REGbc back off the stack.
  $D03B,$02 Decrease #REGb and jump to #R$D018 until none remain.
  $D03D,$03 The segment end shape.
  $D040,$02,b$01 Keep the bits of #REGa that are set in #N$7F.
  $D042,$03 Return if #REGa is not #N$13.
  $D045,$03 The horizontal offset.
  $D048,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $D04A,$01 Return if the zero flag is set.
@ $D04B label=ColourSegment_Edge
  $D04B,$03 The attribute rows.
  $D04E,$01 #REGb=#REGa.

c $D04F Paint One Column
@ $D04F label=PaintOneColumn
D $D04F Paints one attribute cell in each of the rows going up the screen, but
. only the cells inside the area of the terrain.
R $D04F B Number of rows
R $D04F C Attribute value
R $D04F DE #N$0020
R $D04F HL Attribute address of the bottom cell
  $D04F,$03 Call #R$CF14.
  $D052,$02 Jump to #R$D05D if the zero flag is set.
  $D054,$01 #REGa=#REGl.
  $D055,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D057,$01 Step #REGa back.
  $D058,$04 Jump to #R$D05D if #REGa is #N$1C or more.
  $D05C,$01 Write #REGc where #REGhl points.
@ $D05D label=PaintOneColumn_Next
  $D05D,$01 Is #REGa zero?
  $D05E,$02 Subtract #REGde and the carry from #REGhl.
  $D060,$02 Decrease #REGb and jump to #R$D04F until none remain.
  $D062,$01 Return.

c $D063 Paint Two Columns
@ $D063 label=PaintTwoColumns
D $D063 Paints two attribute cells in each of the rows going up the screen, but
. only the cells inside the area of the terrain.
R $D063 B Number of rows
R $D063 C Attribute value
R $D063 DE #N$0020
R $D063 HL Attribute address of the bottom left cell
  $D063,$03 Call #R$CF14.
  $D066,$02 Jump to #R$D07C if the zero flag is set.
  $D068,$01 #REGa=#REGl.
  $D069,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D06B,$01 Step #REGa back.
  $D06C,$04 Jump to #R$D071 if #REGa is #N$1C or more.
  $D070,$01 Write #REGc where #REGhl points.
@ $D071 label=PaintTwoColumns_Second
  $D071,$01 Advance #REGhl.
  $D072,$01 #REGa=#REGl.
  $D073,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D075,$01 Step #REGa back.
  $D076,$04 Jump to #R$D07B if #REGa is #N$1C or more.
  $D07A,$01 Write #REGc where #REGhl points.
@ $D07B label=PaintTwoColumns_Restore
  $D07B,$01 Step #REGhl back.
@ $D07C label=PaintTwoColumns_Next
  $D07C,$01 Is #REGa zero?
  $D07D,$02 Subtract #REGde and the carry from #REGhl.
  $D07F,$02 Decrease #REGb and jump to #R$D063 until none remain.
  $D081,$01 Return.

c $D082 Paint Three Columns
@ $D082 label=PaintThreeColumns
D $D082 Paints three attribute cells in each of the rows going up the screen,
. but only the cells inside the area of the terrain.
R $D082 B Number of rows
R $D082 C Attribute value
R $D082 DE #N$0020
R $D082 HL Attribute address of the bottom left cell
  $D082,$03 Call #R$CF14.
  $D085,$02 Jump to #R$D0A6 if the zero flag is set.
  $D087,$01 #REGa=#REGl.
  $D088,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D08A,$01 Step #REGa back.
  $D08B,$04 Jump to #R$D090 if #REGa is #N$1C or more.
  $D08F,$01 Write #REGc where #REGhl points.
@ $D090 label=PaintThreeColumns_Second
  $D090,$01 Advance #REGhl.
  $D091,$01 #REGa=#REGl.
  $D092,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D094,$01 Step #REGa back.
  $D095,$04 Jump to #R$D09A if #REGa is #N$1C or more.
  $D099,$01 Write #REGc where #REGhl points.
@ $D09A label=PaintThreeColumns_Third
  $D09A,$01 Advance #REGhl.
  $D09B,$01 #REGa=#REGl.
  $D09C,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D09E,$01 Step #REGa back.
  $D09F,$04 Jump to #R$D0A4 if #REGa is #N$1C or more.
  $D0A3,$01 Write #REGc where #REGhl points.
@ $D0A4 label=PaintThreeColumns_Restore
  $D0A4,$01 Step #REGhl back.
  $D0A5,$01 Step #REGhl back.
@ $D0A6 label=PaintThreeColumns_Next
  $D0A6,$01 Is #REGa zero?
  $D0A7,$02 Subtract #REGde and the carry from #REGhl.
  $D0A9,$02 Decrease #REGb and jump to #R$D082 until none remain.
  $D0AB,$01 Return.

b $D0AC Segment Codes
@ $D0AC label=SegmentCodes
D $D0AC A code for each of the sixteen types of segment, which #R$D0BD stores
. at offset #N$04 of the record that it makes for the segment (the first four
. bytes are the position and size). Purpose not yet known.
B $D0AC,$10,$10

g $D0BC Collision Kind
@ $D0BC label=CollisionKind
D $D0BC What the ship has collided with: zero for nothing, #N$80 for an object,
. #N($FF) or #N$01 for the terrain. The routines that detect collisions set it
. and #R$C5D2 clears it each frame.
B $D0BC,$01,$01

c $D0BD Draw Terrain
@ $D0BD label=DrawTerrain
D $D0BD Draws the terrain of the four tiles that are in view, by running the
. script of each tile. The number of the tile is kept in #R$5C1D: bit 0 is set
. for a tile below the first and bit 1 for a tile to the right. The scripts of
. the tiles are found from the table at #R$DC87. Each tile is a list of
. segments, and each segment is set up with #R$CD08 and #R$CD6B and then drawn
. step by step, each step of a segment being a piece of picture. #R$5C3D is
. non-zero when the tiles have changed, and then the routine also makes a
. record of each segment in the area from #R$5B80: a count byte for the tile
. followed by five bytes for each segment (the position, the size and the code
. from #R$D0AC), which the routines that move objects use to test for
. collisions with the terrain. The segments that are not near the position at
. #R$CE45 and #R$CE46 are not drawn.
  $D0BD,$03 The scroll-in flag.
  $D0C0,$03 Jump to #R$D0C6 if #REGa is zero.
  $D0C3,$03 Update the tiles changed.
N $D0C6 Choose the table of shifted pictures for the horizontal offset, and
. the offsets table that goes with it.
@ $D0C6 label=DrawTerrain_Tables
  $D0C6,$03 The vertical offset.
  $D0C9,$02 Add #N$60 to #REGa.
  $D0CB,$03 Update the vertical offset.
  $D0CE,$03 The picture offsets.
  $D0D1,$04 Update the picture offsets pointer.
  $D0D5,$01 Switch to the alternate registers.
  $D0D6,$03 The shape table shift zero.
  $D0D9,$03 The horizontal offset.
  $D0DC,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $D0DE,$02 Jump to #R$D0F8 if the zero flag is set.
  $D0E0,$01 Switch to the alternate registers.
  $D0E1,$01 Advance #REGde.
  $D0E2,$04 Update the picture offsets pointer.
  $D0E6,$01 Switch to the alternate registers.
  $D0E7,$03 The shape table shift two.
  $D0EA,$04 Jump to #R$D0F8 if #REGa is #N$02.
  $D0EE,$03 The shape table shift four.
  $D0F1,$04 Jump to #R$D0F8 if #REGa is #N$04.
  $D0F5,$03 The shape table shift six.
N $D0F8 Run the script of each of the four tiles in turn.
@ $D0F8 label=DrawTerrain_Tile
  $D0F8,$03 Update the shape table pointer.
  $D0FB,$01 Clear #REGa.
  $D0FC,$03 Update the tile number.
@ $D0FF label=DrawTerrain_Record
  $D0FF,$04 The decryption routine.
  $D103,$03 The tile number.
  $D106,$03 Jump to #R$D11D if #REGa is zero.
  $D109,$04 Use #N$5BA5.
  $D10D,$04 Jump to #R$D11D if #REGa is #N$01.
  $D111,$04 Use #N$5BCA.
  $D115,$04 Jump to #R$D11D if #REGa is #N$02.
  $D119,$04 Use #N$5BEF.
N $D11D Read the address of the script of the tile and see if it starts with the
. prefix bytes that draw it upside down (#N($99)) and back to front (#N($FF)).
@ $D11D label=DrawTerrain_Script
  $D11D,$03 Fetch the word at #R$DC87 into #REGhl.
  $D120,$01 Read #REGhl into #REGe.
  $D121,$01 Advance #REGhl.
  $D122,$01 Read #REGhl into #REGd.
  $D123,$01 Advance #REGhl.
  $D124,$03 Update the tile script pointer.
  $D127,$01 Swap #REGde and #REGhl.
  $D128,$01 Clear #REGa.
  $D129,$03 Update the back to front flag.
  $D12C,$03 Update the upside down flag.
  $D12F,$03 Write #REGa to offset #N$00 of #REGix.
  $D132,$01 Read #REGhl.
  $D133,$04 Jump to #R$D81A if #REGa is zero.
  $D137,$04 Jump to #R$D13F if #REGa is not #N$99.
  $D13B,$03 Update the upside down flag.
  $D13E,$01 Advance #REGhl.
@ $D13F label=DrawTerrain_BackToFront
  $D13F,$01 Read #REGhl.
  $D140,$04 Jump to #R$D148 if #REGa is not #N$FF.
  $D144,$03 Update the back to front flag.
  $D147,$01 Advance #REGhl.
@ $D148 label=DrawTerrain_Count
  $D148,$01 Read #REGhl.
  $D149,$04 Jump to #R$D14F if #REGa is less than #N$95.
  $D14D,$01 Advance #REGhl.
  $D14E,$01 Read #REGhl.
@ $D14F label=DrawTerrain_Remember
  $D14F,$03 Update the segments still to draw.
  $D152,$03 Write #REGa to offset #N$00 of #REGix.
  $D155,$02 Advance #REGix.
  $D157,$01 Advance #REGhl.
  $D158,$04 The segment record.
N $D15C Start a segment: clear the variables, read its position and type from
. the script and set up its slope and shapes.
@ $D15C label=DrawTerrain_Segment
  $D15C,$04 The segment record.
  $D160,$01 Clear #REGa.
  $D161,$03 Update the flagged steps.
  $D164,$03 Update the steps already drawn.
  $D167,$03 Update the last contact flags.
  $D16A,$03 Update the shape flag.
  $D16D,$03 Update the segment end shape.
  $D170,$03 Update the segment start shape.
  $D173,$03 Update the upside-down segment flag.
  $D176,$03 Update the vertical step copy.
  $D179,$03 Update the edge flag.
  $D17C,$03 Write #REGa to offset #N$01 of #REGix.
  $D17F,$01 Read #REGhl.
  $D180,$03 Update the segment column.
  $D183,$01 Advance #REGhl.
  $D184,$01 Read #REGhl.
  $D185,$03 Update the segment row.
  $D188,$03 The segment row.
  $D18B,$01 Advance #REGhl.
  $D18C,$01 Read #REGhl.
  $D18D,$01 Rotate #REGa right.
  $D18E,$01 Rotate #REGa right.
  $D18F,$01 Rotate #REGa right.
  $D190,$01 Rotate #REGa right.
  $D191,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $D193,$03 Write #REGa to offset #N$03 of #REGix.
  $D196,$01 Switch to the alternate registers.
  $D197,$03 Call #R$CD08.
  $D19A,$01 Switch to the alternate registers.
  $D19B,$01 Read #REGhl.
  $D19C,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $D19E,$02 Jump to #R$D1A2 if the zero flag is clear.
  $D1A0,$02 #REGa=#N$10.
@ $D1A2 label=DrawTerrain_Length
  $D1A2,$03 Update the segment length.
  $D1A5,$01 #REGc=#REGa.
  $D1A6,$01 Advance #REGhl.
  $D1A7,$03 Call #R$CD6B.
  $D1AA,$03 The column phase table.
  $D1AD,$03 Read offset #N$03 of #REGix into #REGb.
  $D1B0,$01 Switch to the alternate registers.
  $D1B1,$04 Fetch the word at #R$BA09 into #REGix.
N $D1B5 If the tiles have changed, make the record of the segment.
@ $D1B5 label=DrawTerrain_Changed
  $D1B5,$03 The tiles changed.
  $D1B8,$04 Jump to #R$D25A if #REGa is zero.
  $D1BC,$03 The segment type.
  $D1BF,$01 #REGe=#REGa.
  $D1C0,$02 Clear #REGd.
  $D1C2,$03 The segment codes.
  $D1C5,$01 #REGhl gains #REGde.
  $D1C6,$01 Read #REGhl.
  $D1C7,$03 Write #REGa to offset #N$04 of #REGix.
  $D1CA,$03 The segment length.
  $D1CD,$03 Write #REGa to offset #N$02 of #REGix.
  $D1D0,$03 The segment column.
  $D1D3,$03 Write #REGa to offset #N$00 of #REGix.
  $D1D6,$03 The segment row.
  $D1D9,$03 Write #REGa to offset #N$01 of #REGix.
  $D1DC,$03 The vertical step.
  $D1DF,$03 Jump to #R$D204 if #REGa is not zero.
  $D1E2,$03 Read offset #N$02 of #REGix into #REGb.
  $D1E5,$01 Clear #REGa.
@ $D1E6 label=DrawTerrain_FlatWidth
  $D1E6,$02 Add #N$18 to #REGa.
  $D1E8,$02 Decrease #REGb and jump to #R$D1E6 until none remain.
  $D1EA,$03 Write #REGa to offset #N$02 of #REGix.
  $D1ED,$03 The segment type.
  $D1F0,$02 Compare #REGa with #N$07.
  $D1F2,$04 Store #N$14 at offset #N$03 of #REGix.
  $D1F6,$03 Jump to #R$D25A if the zero flag is set.
  $D1F9,$03 Read offset #N$01 of #REGix.
  $D1FC,$02 Add #N$10 to #REGa.
  $D1FE,$03 Write #REGa to offset #N$01 of #REGix.
  $D201,$03 Jump to #R$D25A.
@ $D204 label=DrawTerrain_Sloped
  $D204,$03 The horizontal step copy.
  $D207,$03 Jump to #R$D22D if #REGa is not zero.
  $D20A,$03 Read offset #N$02 of #REGix into #REGb.
  $D20D,$01 Clear #REGa.
@ $D20E label=DrawTerrain_SlopeWidth
  $D20E,$02 Add #N$10 to #REGa.
  $D210,$02 Decrease #REGb and jump to #R$D20E until none remain.
  $D212,$01 #REGb=#REGa.
  $D213,$04 Store #N$18 at offset #N$02 of #REGix.
  $D217,$03 The segment type.
  $D21A,$03 Write #REGb to offset #N$03 of #REGix.
  $D21D,$05 Jump to #R$D25A if #REGa is not #N$0F.
  $D222,$03 Read offset #N$00 of #REGix.
  $D225,$02 Subtract #N$10 from #REGa.
  $D227,$03 Write #REGa to offset #N$00 of #REGix.
  $D22A,$03 Jump to #R$D25A.
@ $D22D label=DrawTerrain_Extent
  $D22D,$03 The slope direction.
  $D230,$04 Jump to #R$D23D if #REGa is #N$FF.
  $D234,$03 The horizontal step size.
  $D237,$03 Add the byte at offset #N$00 of #REGix to #REGa.
  $D23A,$03 Write #REGa to offset #N$00 of #REGix.
@ $D23D label=DrawTerrain_End
  $D23D,$03 Read offset #N$02 of #REGix into #REGb.
  $D240,$03 Read offset #N$00 of #REGix into #REGd.
  $D243,$03 Read offset #N$01 of #REGix into #REGe.
@ $D246 label=DrawTerrain_ExtentLoop
  $D246,$03 The horizontal step.
  $D249,$01 #REGa gains #REGd.
  $D24A,$01 #REGd=#REGa.
  $D24B,$03 The vertical step.
  $D24E,$02 Negate #REGa.
  $D250,$01 #REGa gains #REGe.
  $D251,$01 #REGe=#REGa.
  $D252,$02 Decrease #REGb and jump to #R$D246 until none remain.
  $D254,$03 Write #REGe to offset #N$03 of #REGix.
  $D257,$03 Write #REGd to offset #N$02 of #REGix.
N $D25A Test whether the segment is near the position at #R$CE45 and #R$CE46,
. and skip it if it is not.
@ $D25A label=DrawTerrain_Test
  $D25A,$03 The position across.
  $D25D,$01 #REGb=#REGa.
  $D25E,$03 The tile number.
  $D261,$04 Jump to #R$D26A if bit 1 of #REGa is clear.
  $D265,$03 Call #R$D2C0.
  $D268,$02 Jump to #R$D26D.
@ $D26A label=DrawTerrain_TestVertical
  $D26A,$03 Call #R$D292.
@ $D26D label=DrawTerrain_Vertical
  $D26D,$03 Jump to #R$D28C if the zero flag is clear.
  $D270,$03 The position down.
  $D273,$01 #REGb=#REGa.
  $D274,$03 The tile number.
  $D277,$04 Jump to #R$D280 if bit 0 of #REGa is clear.
  $D27B,$03 Call #R$D2E1.
  $D27E,$02 Jump to #R$D283.
@ $D280 label=DrawTerrain_Top
  $D280,$03 Call #R$D2DA.
@ $D283 label=DrawTerrain_Near
  $D283,$03 Jump to #R$D28C if the zero flag is clear.
  $D286,$03 Call #R$D303.
  $D289,$03 Jump to #R$D33D.
@ $D28C label=DrawTerrain_Skip
  $D28C,$03 Call #R$D303.
  $D28F,$03 Jump to #R$D80A.

c $D292 Test Left Column
@ $D292 label=TestLeftColumn
D $D292 Tests the right end of a segment of a tile in the left column against
. the horizontal position in #REGb.
R $D292 B Horizontal position to test against
R $D292 IX Address of the record of the segment
R $D292 O:F Zero if the end of the segment is at the position or beyond it
  $D292,$03 The vertical step.
  $D295,$03 Jump to #R$D2A0 if #REGa is not zero.
  $D298,$03 Read offset #N$00 of #REGix.
  $D29B,$03 Add the byte at offset #N$02 of #REGix to #REGa.
  $D29E,$02 Jump to #R$D2BC.
@ $D2A0 label=TestLeftColumn_Sloped
  $D2A0,$03 The horizontal step copy.
  $D2A3,$03 Jump to #R$D2AD if #REGa is not zero.
  $D2A6,$03 The segment column.
  $D2A9,$02 Add #N$08 to #REGa.
  $D2AB,$02 Jump to #R$D2BC.
@ $D2AD label=TestLeftColumn_Direction
  $D2AD,$03 The slope direction.
  $D2B0,$04 Jump to #R$D2B9 if #REGa is #N$01.
  $D2B4,$03 Read offset #N$02 of #REGix.
  $D2B7,$02 Jump to #R$D2BC.
@ $D2B9 label=TestLeftColumn_Start
  $D2B9,$03 Read offset #N$00 of #REGix.
@ $D2BC label=TestLeftColumn_Compare
  $D2BC,$02 Return if #REGa is less than #REGb.
  $D2BE,$01 Clear #REGa.
  $D2BF,$01 Return.

c $D2C0 Test Right Column
@ $D2C0 label=TestRightColumn
D $D2C0 Tests the left end of a segment of a tile in the right column against
. the horizontal position in #REGb.
R $D2C0 B Horizontal position to test against
R $D2C0 IX Address of the record of the segment
R $D2C0 O:F Zero if the start of the segment is at the position or before it
  $D2C0,$03 The horizontal step copy.
  $D2C3,$03 Jump to #R$D2D3 if #REGa is zero.
  $D2C6,$03 The slope direction.
  $D2C9,$04 Jump to #R$D2D3 if #REGa is #N$FF.
  $D2CD,$03 Read offset #N$02 of #REGix.
  $D2D0,$01 Step #REGa back.
  $D2D1,$02 Jump to #R$D2D6.
@ $D2D3 label=TestRightColumn_Start
  $D2D3,$03 The segment column.
@ $D2D6 label=TestRightColumn_Compare
  $D2D6,$02 Return if #REGa is #REGb or more.
  $D2D8,$01 Clear #REGa.
  $D2D9,$01 Return.

c $D2DA Test Top Row
@ $D2DA label=TestTopRow
D $D2DA Tests the vertical position of the start of a segment of a tile in the
. top row against the vertical position in #REGb.
R $D2DA B Vertical position to test against
R $D2DA O:F Zero if the start of the segment is at the position or below it
  $D2DA,$03 The segment row.
  $D2DD,$02 Return if #REGa is less than #REGb.
  $D2DF,$01 Clear #REGa.
  $D2E0,$01 Return.

c $D2E1 Test Bottom Row
@ $D2E1 label=TestBottomRow
D $D2E1 Tests the vertical extent of a segment of a tile in the bottom row
. against the vertical position in #REGb.
R $D2E1 B Vertical position to test against
R $D2E1 IX Address of the record of the segment
R $D2E1 O:F Zero if the segment reaches the position or goes beyond it
  $D2E1,$03 The vertical step.
  $D2E4,$03 Jump to #R$D2EE if #REGa is not zero.
  $D2E7,$03 The segment row.
  $D2EA,$02 Subtract #N$04 from #REGa.
  $D2EC,$02 Jump to #R$D2FF.
@ $D2EE label=TestBottomRow_Sloped
  $D2EE,$03 The horizontal step copy.
  $D2F1,$03 Jump to #R$D2FC if #REGa is not zero.
  $D2F4,$03 Read offset #N$01 of #REGix.
  $D2F7,$03 Subtract the byte at offset #N$03 of #REGix from #REGa.
  $D2FA,$02 Jump to #R$D2FF.
@ $D2FC label=TestBottomRow_Direction
  $D2FC,$03 Read offset #N$03 of #REGix.
@ $D2FF label=TestBottomRow_Compare
  $D2FF,$02 Return if #REGa is #REGb or more.
  $D301,$01 Clear #REGa.
  $D302,$01 Return.

c $D303 Next Record
@ $D303 label=NextRecord
D $D303 Moves on to the next five byte record of a segment in the tile record
. and stores it in #R$BA09, then points #REGix back at the drawing record at
. #R$DEDC with its screen address cleared.
R $D303 IX Address of the record of the segment
  $D303,$03 #REGde=#N$05.
  $D306,$02 #REGix gains #REGde.
  $D308,$04 The next segment record.
  $D30C,$04 The segment record.
  $D310,$01 Switch to the alternate registers.
  $D311,$04 Store #N$00 at offset #N$01 of #REGix.
  $D315,$03 Write #REGb to offset #N$03 of #REGix.
  $D318,$01 Return.

c $D319 Next Step
@ $D319 label=NextStep
D $D319 Moves to the next step of a segment: the pixel row goes up by the
. vertical step and the pixel column along by the horizontal step. Then the
. step is tested against the position at #R$CE45 and #R$CE46, and the flags in
. #R$5C31 are set to say where they are in relation to each other.
  $D319,$03 The vertical step.
  $D31C,$01 #REGb=#REGa.
  $D31D,$03 The segment row.
  $D320,$01 Subtract #REGb from #REGa.
  $D321,$03 Update the segment row.
  $D324,$03 The segment screen row.
  $D327,$01 Subtract #REGb from #REGa.
  $D328,$03 Update the segment screen row.
  $D32B,$03 The horizontal step.
  $D32E,$01 #REGb=#REGa.
  $D32F,$03 The segment screen column.
  $D332,$01 #REGa gains #REGb.
  $D333,$03 Update the segment screen column.
  $D336,$03 The segment column.
  $D339,$01 #REGa gains #REGb.
  $D33A,$03 Update the segment column.
N $D33D Test the row. Rows that are above the position are drawn, a step at the
. same row is flagged by #R$CE79 or #R$CE97, and steps below the position are
. skipped.
@ $D33D label=NextStep_Test
  $D33D,$01 Clear #REGa.
  $D33E,$03 Update the contact flags.
  $D341,$03 The tile number.
  $D344,$04 Jump to #R$D359 if bit 0 of #REGa is set.
  $D348,$03 The segment row.
  $D34B,$01 #REGb=#REGa.
  $D34C,$03 The position down.
  $D34F,$04 Jump to #R$CE97 if #REGa is #REGb.
  $D353,$03 Jump to #R$D724 if the carry flag is clear.
  $D356,$03 Jump to #R$D36C.
@ $D359 label=NextStep_Bottom
  $D359,$03 The vertical step copy.
  $D35C,$01 #REGb=#REGa.
  $D35D,$03 The segment row.
  $D360,$01 Subtract #REGb from #REGa.
  $D361,$01 #REGb=#REGa.
  $D362,$03 The position down.
  $D365,$04 Jump to #R$D724 if #REGa is less than #REGb.
  $D369,$03 Jump to #R$CE79 if the zero flag is set.
N $D36C Test the column in the same way, with #R$CEB5 and #R$CEC8 for the same
. column.
@ $D36C label=NextStep_Column
  $D36C,$03 The segment column.
  $D36F,$01 #REGb=#REGa.
  $D370,$03 The tile number.
  $D373,$04 Jump to #R$D3A6 if bit 1 of #REGa is set.
  $D377,$03 The vertical step.
  $D37A,$03 Jump to #R$D395 if #REGa is not zero.
  $D37D,$03 The horizontal offset.
  $D380,$01 #REGa gains #REGb.
  $D381,$04 Jump to #R$D395 if #REGa is less than #N$F0.
  $D385,$03 Jump to #R$CEB5 if the zero flag is set.
  $D388,$04 Jump to #R$D395 if #REGa is #N$F7 or more.
  $D38C,$01 #REGa=#REGc.
  $D38D,$01 Step #REGa back.
  $D38E,$03 Jump to #R$D724 if the zero flag is clear.
  $D391,$01 Step #REGa back.
  $D392,$03 Update the edge flag.
@ $D395 label=NextStep_Width
  $D395,$03 The horizontal step size.
  $D398,$01 #REGa gains #REGb.
  $D399,$01 #REGb=#REGa.
  $D39A,$03 The position across.
  $D39D,$04 Jump to #R$CEB5 if #REGa is #REGb.
  $D3A1,$03 Jump to #R$D724 if the carry flag is clear.
  $D3A4,$02 Jump to #R$D3B0.
@ $D3A6 label=NextStep_Right
  $D3A6,$03 The position across.
  $D3A9,$04 Jump to #R$CEC8 if #REGa is #REGb.
  $D3AD,$03 Jump to #R$D724 if the carry flag is set.
N $D3B0 If any of the flags have been set the step is handled by one of the
. routines for contact. Otherwise the step is drawn.
@ $D3B0 label=NextStep_Flags
  $D3B0,$03 The contact flags.
  $D3B3,$03 Jump to #R$D3D2 if #REGa is zero.
  $D3B6,$05 Jump to #R$CEDB if #REGa is #N$08.
  $D3BB,$05 Jump to #R$CEDB if #REGa is #N$04.
  $D3C0,$05 Jump to #R$CE5B if #REGa is #N$01.
  $D3C5,$05 Jump to #R$CE5B if #REGa is #N$02.
  $D3CA,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $D3CC,$03 Jump to #R$CE5B if the zero flag is clear.
  $D3CF,$03 Jump to #R$D724.

c $D3D2 Set Up Piece
@ $D3D2 label=SetUpPiece
D $D3D2 Sets up the drawing of the piece of picture for a step of a segment.
. Normally the routine for the type of the segment and the address of its
. picture are looked up in the table at #R$CCBD (four bytes for each type: the
. routine, which goes into #REGiy, and the picture) and the screen address for
. the start of the piece is found with #R$D937. Then, depending on the type of
. the segment and where on the screen it is, the routine sets the displacement
. of the jump at #R$D701 (in #N$D702) to choose a routine, and changes the
. instructions of the drawing routines to suit. Steps that were set up already
. start at #R$D435.
R $D3D2 HL Address of the entry for the step in the table at #R$CE24
R $D3D2 IX Address of the drawing record at #R$DEDC
  $D3D2,$01 Read #REGhl into #REGe.
  $D3D3,$03 Read offset #N$01 of #REGix.
  $D3D6,$04 Jump to #R$D435 if #REGa is not zero.
@ $D3DA label=SetUpPiece_Table
  $D3DA,$01 Switch to the alternate registers.
  $D3DB,$03 Fetch the word at #R$CCBD into #REGhl.
  $D3DE,$03 Read offset #N$03 of #REGix into #REGe.
  $D3E1,$02 Clear #REGd.
  $D3E3,$02 Shift #REGe left.
  $D3E5,$02 Shift #REGe left.
  $D3E7,$01 #REGhl gains #REGde.
  $D3E8,$01 Read #REGhl into #REGc.
  $D3E9,$01 Advance #REGhl.
  $D3EA,$01 Read #REGhl into #REGb.
  $D3EB,$01 Advance #REGhl.
  $D3EC,$01 Stash #REGbc on the stack.
  $D3ED,$02 Bring #REGiy back off the stack.
  $D3EF,$01 Read #REGhl into #REGc.
  $D3F0,$01 Advance #REGhl.
  $D3F1,$01 Read #REGhl into #REGb.
  $D3F2,$04 Update the picture pointer.
  $D3F6,$03 The vertical step copy.
  $D3F9,$02 Shift #REGa right.
  $D3FB,$03 Update the segment height.
  $D3FE,$03 Call #R$D937.
  $D401,$03 The column step.
  $D404,$01 #REGb=#REGa.
  $D405,$01 #REGa=#REGl.
  $D406,$01 Subtract #REGb from #REGa.
  $D407,$01 #REGl=#REGa.
  $D408,$03 Update the segment screen address.
  $D40B,$04 Fetch the word at #R$CE4B into #REGde.
  $D40F,$03 Read offset #N$03 of #REGix.
  $D412,$04 Jump to #R$D418 if #REGa is less than #N$07.
  $D416,$02 Subtract #N$07 from #REGa.
@ $D418 label=SetUpPiece_Offsets
  $D418,$01 Double #REGa.
  $D419,$01 #REGh=#REGa.
  $D41A,$01 Double #REGa.
  $D41B,$01 #REGa gains #REGh.
  $D41C,$01 #REGl=#REGa.
  $D41D,$02 Clear #REGh.
  $D41F,$01 #REGhl gains #REGde.
  $D420,$03 Update the segment picture offsets.
  $D423,$01 Switch to the alternate registers.
  $D424,$01 Clear #REGa.
  $D425,$01 #REGd=#REGa.
  $D426,$03 Shorten the piece by one column.
  $D429,$03 Read offset #N$00 of #REGix.
  $D42C,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $D42E,$02 Jump to #R$D435 if the zero flag is clear.
  $D430,$02 #REGa=#N$01.
  $D432,$03 Keep the width of the piece.
@ $D435 label=SetUpPiece_Type
  $D435,$03 The horizontal step copy.
  $D438,$03 Jump to #R$D44B if #REGa is not zero.
  $D43B,$01 #REGa=#REGd.
  $D43C,$04 Jump to #R$D672 if #REGa is not zero.
  $D440,$03 The slope direction.
  $D443,$02 Negate #REGa.
  $D445,$01 Double #REGa.
  $D446,$01 Double #REGa.
  $D447,$01 Double #REGa.
  $D448,$03 Update the horizontal step.
N $D44B Flat segments are handled at #R$D588.
@ $D44B label=SetUpPiece_Slope
  $D44B,$01 Clear #REGa.
  $D44C,$03 Use the routine in #REGiy.
  $D44F,$03 The vertical step.
  $D452,$04 Jump to #R$D588 if #REGa is zero.
  $D456,$03 The segment screen column.
  $D459,$05 Jump to #R$D4CB if #REGa is less than #N$D1.
  $D45E,$01 #REGb=#REGa.
  $D45F,$03 The horizontal step.
N $D462 The displacement of this jump is set by #R$E3D8: it is zero when the
. second step of the slope is negative, so that the next instruction is run, and
. two otherwise, to skip it.
@ $D462 label=SetUpPiece_Patched
  $D462,$02 Skip ahead by the displacement at #N$D463.
  $D464,$02 Negate #REGa.
  $D466,$01 #REGa gains #REGb.
  $D467,$05 Jump to #R$D4CB if #REGa is less than #N$E9.
  $D46C,$01 #REGa=#REGb.
  $D46D,$04 Jump to #R$D494 if #REGa is less than #N$E0.
  $D471,$03 The slope direction.
  $D474,$04 Jump to #R$D4A7 if #REGa is #N$01.
  $D478,$03 The column step.
  $D47B,$01 #REGb=#REGa.
  $D47C,$02 #REGa=#N$21.
  $D47E,$01 Subtract #REGb from #REGa.
@ $D47F label=SetUpPiece_ShortPatch
  $D47F,$02 Skip ahead by the displacement at #N$D480.
  $D481,$01 Step #REGa back.
  $D482,$03 Whether the second byte of the slope row is skipped.
  $D485,$02 #REGa=#N$02.
  $D487,$03 Draw the slope rows.
  $D48A,$03 The horizontal step copy.
  $D48D,$04 Call #R$CCF5 if #REGa is zero.
  $D491,$03 Jump to #R$D672.
@ $D494 label=SetUpPiece_Reverse
  $D494,$03 The slope direction.
  $D497,$04 Jump to #R$D4B8 if #REGa is #N$01.
  $D49B,$01 Clear #REGa.
  $D49C,$03 Draw both bytes of the slope row.
  $D49F,$02 #REGa=#N$02.
  $D4A1,$03 Draw the slope rows.
  $D4A4,$03 Jump to #R$D672.
@ $D4A7 label=SetUpPiece_Edge
  $D4A7,$03 Whether the piece was shortened.
  $D4AA,$03 Whether the piece is shortened at the edge.
  $D4AD,$03 The column step.
  $D4B0,$02 Negate #REGa.
  $D4B2,$01 #REGb=#REGa.
  $D4B3,$02 #REGa=#N$29.
  $D4B5,$01 Subtract #REGb from #REGa.
@ $D4B6 label=SetUpPiece_EdgePatch
  $D4B6,$02 Skip ahead by the displacement at #N$D4B7.
@ $D4B8 label=SetUpPiece_Draw
  $D4B8,$01 Step #REGa back.
  $D4B9,$03 How far to skip along the mirrored row.
  $D4BC,$02 #REGa=#N$05.
  $D4BE,$03 Draw the mirrored slope rows.
  $D4C1,$03 The horizontal step copy.
  $D4C4,$04 Call #R$CCF5 if #REGa is zero.
  $D4C8,$03 Jump to #R$D672.
@ $D4CB label=SetUpPiece_Left
  $D4CB,$03 The segment screen column.
  $D4CE,$02 Add #N$08 to #REGa.
  $D4D0,$04 Jump to #R$D4E1 if #REGa is less than #N$0F.
  $D4D4,$03 The horizontal step copy.
  $D4D7,$04 Jump to #R$D672 if #REGa is not zero.
  $D4DB,$03 Call #R$CCF5.
  $D4DE,$03 Jump to #R$D672.
@ $D4E1 label=SetUpPiece_Direction
  $D4E1,$03 The slope direction.
  $D4E4,$04 Jump to #R$D539 if #REGa is #N$01.
  $D4E8,$03 The segment screen address.
  $D4EB,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D4ED,$04 Jump to #R$D514 if #REGa is #N$1D.
  $D4F1,$04 Jump to #R$D525 if #REGa is #N$1E.
@ $D4F5 label=SetUpPiece_Flat
  $D4F5,$03 The horizontal step copy.
  $D4F8,$04 Call #R$CCF5 if #REGa is zero.
  $D4FC,$03 The column step.
  $D4FF,$03 Update the piece column.
  $D502,$02 #REGa=#N$2C.
  $D504,$03 Skip along the slope row.
@ $D507 label=SetUpPiece_SetCounts
  $D507,$02 #REGa=#N$01.
  $D509,$03 Skip a word of the picture.
@ $D50C label=SetUpPiece_SelectEight
  $D50C,$02 #REGa=#N$08.
  $D50E,$03 Draw the slope rows from the edge.
  $D511,$03 Jump to #R$D672.
@ $D514 label=SetUpPiece_Column29
  $D514,$02 #REGa=#N$01.
  $D516,$03 Update the piece column.
  $D519,$01 Clear #REGa.
  $D51A,$03 Keep the word of the picture.
  $D51D,$02 #REGa=#N$30.
  $D51F,$03 Skip further along the slope row.
  $D522,$03 Jump to #R$D50C.
@ $D525 label=SetUpPiece_Column30
  $D525,$03 Whether the piece was shortened.
  $D528,$04 Jump to #R$D4F5 if #REGa is #N$01.
  $D52C,$03 The column step.
  $D52F,$03 Update the piece column.
  $D532,$01 Clear #REGa.
  $D533,$03 Do not skip along the slope row.
  $D536,$03 Jump to #R$D507.
@ $D539 label=SetUpPiece_Backwards
  $D539,$03 The column step.
  $D53C,$01 #REGb=#REGa.
  $D53D,$03 The segment screen address.
  $D540,$01 Subtract #REGb from #REGa.
  $D541,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D543,$04 Jump to #R$D562 if #REGa is #N$02.
  $D547,$04 Jump to #R$D573 if #REGa is #N$03.
  $D54B,$03 Whether the piece was shortened.
  $D54E,$04 Jump to #R$D562 if #REGa is #N$01.
  $D552,$01 Clear #REGa.
  $D553,$03 Do not skip along the mirrored slope row.
  $D556,$01 Advance #REGa.
@ $D557 label=SetUpPiece_SelectEleven
  $D557,$03 Whether a word of the mirrored picture is skipped.
  $D55A,$02 #REGa=#N$0B.
  $D55C,$03 Draw the mirrored rows from the edge.
  $D55F,$03 Jump to #R$D672.
@ $D562 label=SetUpPiece_Two
  $D562,$03 The horizontal step copy.
  $D565,$04 Call #R$CCF5 if #REGa is zero.
  $D569,$02 #REGa=#N$26.
  $D56B,$03 Skip along the mirrored slope row.
  $D56E,$02 #REGa=#N$01.
  $D570,$03 Jump to #R$D557.
@ $D573 label=SetUpPiece_Three
  $D573,$01 #REGa=#REGd.
  $D574,$03 Jump to #R$D57F if #REGa is not zero.
  $D577,$03 The segment screen address.
  $D57A,$02 Subtract #N$20 from #REGa.
  $D57C,$03 Update the segment screen address.
@ $D57F label=SetUpPiece_ThreeBytes
  $D57F,$02 #REGa=#N$2A.
  $D581,$03 Skip further along the mirrored slope row.
  $D584,$01 Clear #REGa.
  $D585,$03 Jump to #R$D557.

c $D588 Set Up Flat Piece
@ $D588 label=SetUpFlatPiece
D $D588 Sets up the drawing of the piece of picture for a step of a flat
. segment, which is three bytes wide. The jumps at #R$E259, #R$E25D and #R$E261
. and the instructions at #N$E2A5 and #N$E2AA of #R$E249 are changed when the
. piece is at the edge of the screen (the column in the bottom five bits of the
. screen address is #N($18), #N($19), #N($1C) or #N($1D)) so that only the part
. inside the area of the terrain is drawn. The routine then reads the shape at
. the end of the segment from #R$5C33 and #R$5C34 and finds the picture and the
. routine that draws it.
R $D588 C Number of steps left in the segment
R $D588 IX Address of the drawing record at #R$DEDC
  $D588,$01 Clear #REGa.
  $D589,$03 Draw the first word of the flat row.
  $D58C,$03 Draw the second word of the flat row.
  $D58F,$03 Draw the third word of the flat row.
  $D592,$03 The segment screen address.
  $D595,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D597,$04 Jump to #R$D5C6 if #REGa is #N$1D.
  $D59B,$04 Jump to #R$D5D5 if #REGa is #N$1C.
  $D59F,$04 Jump to #R$D5E5 if #REGa is #N$18.
  $D5A3,$04 Jump to #R$D5EC if #REGa is #N$19.
  $D5A7,$03 The edge flag.
  $D5AA,$04 Jump to #R$D716 if #REGa is not zero.
  $D5AE,$03 The segment length.
  $D5B1,$03 Jump to #R$D5F1 if #REGa is not #REGc.
  $D5B4,$03 The segment start shape.
  $D5B7,$04 Jump to #R$D5F1 if #REGa is not #N$10.
  $D5BB,$03 The horizontal offset.
  $D5BE,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $D5C0,$02 Jump to #R$D5F1 if the zero flag is set.
  $D5C2,$02 #REGa=#N$EE.
  $D5C4,$02 Jump to #R$D5C8.
@ $D5C6 label=SetUpFlatPiece_Right
  $D5C6,$02 #REGa=#N$33.
@ $D5C8 label=SetUpFlatPiece_Patch
  $D5C8,$03 Skip part of the flat row at the right edge.
  $D5CB,$01 Clear #REGa.
  $D5CC,$03 Draw the right-hand byte.
  $D5CF,$01 Advance #REGa.
  $D5D0,$03 Skip the byte before the right-hand byte.
  $D5D3,$02 Jump to #R$D5F1.
@ $D5D5 label=SetUpFlatPiece_Edge
  $D5D5,$02 #REGa=#N$33.
  $D5D7,$03 Skip part of the flat row at the edge.
  $D5DA,$02 #REGa=#N$0B.
  $D5DC,$03 Skip most of the right-hand side.
  $D5DF,$01 Clear #REGa.
  $D5E0,$03 Draw the byte before the right-hand byte.
  $D5E3,$02 Jump to #R$D5F1.
@ $D5E5 label=SetUpFlatPiece_Column
  $D5E5,$02 #REGa=#N$26.
  $D5E7,$03 Skip the third word of the flat row.
  $D5EA,$02 Jump to #R$D5F1.
@ $D5EC label=SetUpFlatPiece_Skip
  $D5EC,$02 #REGa=#N$24.
  $D5EE,$03 Skip the second word of the flat row.
@ $D5F1 label=SetUpFlatPiece_Shape
  $D5F1,$03 The segment length.
  $D5F4,$04 Jump to #R$D65E if #REGa is not #REGc.
  $D5F8,$03 The segment start shape.
  $D5FB,$05 Jump to #R$D672 if bit 4 of #REGa is clear.
  $D600,$02,b$01 Set the bits of #REGa that are set in #N$80.
  $D602,$03 Update the segment start shape.
@ $D605 label=SetUpFlatPiece_Picture
  $D605,$01 #REGb=#REGa.
  $D606,$04 Jump to #R$D636 if #REGa is #N$96.
  $D60A,$04 Jump to #R$D64E if bit 0 of #REGa is clear.
  $D60E,$02 Compare #REGa with #N$91.
  $D610,$03 The horizontal scroll speed.
  $D613,$02 Jump to #R$D617 if the zero flag is set.
  $D615,$02 Negate #REGa.
@ $D617 label=SetUpFlatPiece_Direction
  $D617,$04 Jump to #R$D64E if bit 7 of #REGa is set.
  $D61B,$03 Read offset #N$00 of #REGix.
  $D61E,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $D620,$02 Jump to #R$D64E if the zero flag is clear.
  $D622,$01 #REGa=#REGb.
  $D623,$03 Update the shape flag.
  $D626,$01 Switch to the alternate registers.
  $D627,$03 Fetch the word at #R$CE49 into #REGhl.
  $D62A,$03 Update the saved screen address.
  $D62D,$03 The segment screen column.
  $D630,$03 Update the screen column.
  $D633,$01 Switch to the alternate registers.
  $D634,$02 Jump to #R$D64E.
@ $D636 label=SetUpFlatPiece_Edges
  $D636,$03 The segment screen address.
  $D639,$01 Advance #REGa.
  $D63A,$01 Advance #REGa.
  $D63B,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D63D,$05 Jump to #R$D724 if #REGa is #N$1C or more.
  $D642,$01 Clear #REGa.
  $D643,$03 Draw the first word of the flat row.
  $D646,$03 Draw the third word of the flat row.
  $D649,$02 #REGa=#N$24.
  $D64B,$03 Skip the second word of the flat row.
@ $D64E label=SetUpFlatPiece_Offset
  $D64E,$01 #REGa=#REGb.
  $D64F,$02,b$01 Keep the bits of #REGa that are set in #N$03.
  $D651,$01 Double #REGa.
  $D652,$01 Double #REGa.
  $D653,$01 #REGb=#REGa.
  $D654,$01 Double #REGa.
  $D655,$01 #REGa gains #REGb.
  $D656,$02 Add #N$24 to #REGa.
  $D658,$01 Switch to the alternate registers.
  $D659,$01 #REGe=#REGa.
  $D65A,$02 Clear #REGd.
  $D65C,$02 Jump to #R$D67E.
@ $D65E label=SetUpFlatPiece_Last
  $D65E,$01 #REGa=#REGc.
  $D65F,$04 Jump to #R$D672 if #REGa is not #N$01.
  $D663,$03 The segment end shape.
  $D666,$04 Jump to #R$D672 if bit 4 of #REGa is clear.
  $D66A,$02,b$01 Set the bits of #REGa that are set in #N$80.
  $D66C,$03 Update the segment end shape.
  $D66F,$03 Jump to #R$D605.

c $D672 Locate Picture
@ $D672 label=LocatePicture
D $D672 Finds the picture for the piece. The offset of the picture is looked up
. in the table that #R$CE51 points at, using the value in #REGe as the index,
. and added to the address of the picture at #R$CE47. The stack pointer is
. pointed at the result, so that the drawing routines can pop the words of the
. picture. The routine then works out how many rows to draw. If the piece is at
. the bottom of the screen the rows that are below the bottom are skipped by
. popping their words.
R $D672 E Index into the table of offsets, in words
  $D672,$01 #REGa=#REGe.
  $D673,$01 Switch to the alternate registers.
  $D674,$03 Fetch the word at #R$CE51 into #REGhl.
  $D677,$01 #REGe=#REGa.
  $D678,$02 Shift #REGe left.
  $D67A,$02 Clear #REGd.
  $D67C,$01 #REGhl gains #REGde.
  $D67D,$01 Read #REGhl into #REGe.
@ $D67E label=LocatePicture_Address
  $D67E,$03 Fetch the word at #R$CE47 into #REGhl.
  $D681,$01 #REGhl gains #REGde.
  $D682,$01 Set the stack pointer from #REGhl.
  $D683,$03 The segment height.
  $D686,$01 #REGe=#REGa.
  $D687,$03 The segment screen row.
  $D68A,$05 Jump to #R$D6DB if #REGa is less than #N$B8.
  $D68F,$02 Subtract #N$B7 from #REGa.
  $D691,$01 #REGb=#REGa.
  $D692,$02 Shift #REGb right.
  $D694,$01 #REGa=#REGe.
  $D695,$01 Subtract #REGb from #REGa.
  $D696,$01 #REGe=#REGa.
  $D697,$03 The column step size.
  $D69A,$01 #REGd=#REGa.
  $D69B,$03 The vertical step.
  $D69E,$03 Jump to #R$D6A9 if #REGa is zero.
  $D6A1,$03 Read offset #N$00 of #REGix.
  $D6A4,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $D6A6,$02 Jump to #R$D6A9 if the zero flag is set.
  $D6A8,$01 Advance #REGd.
@ $D6A9 label=LocatePicture_Skip
  $D6A9,$01 #REGa=#REGd.
@ $D6AA label=LocatePicture_Pop
  $D6AA,$01 Bring #REGhl back off the stack.
  $D6AB,$01 Step #REGa back.
  $D6AC,$02 Jump to #R$D6AA if the zero flag is clear.
  $D6AE,$02 Decrease #REGb and jump to #R$D6A9 until none remain.
  $D6B0,$02 #REGh=#N$57.
  $D6B2,$03 The segment screen address.
  $D6B5,$01 #REGl=#REGa.
  $D6B6,$03 The column step.
  $D6B9,$01 #REGa gains #REGl.
  $D6BA,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D6BC,$02,b$01 Set the bits of #REGa that are set in #N$C0.
  $D6BE,$01 #REGl=#REGa.
  $D6BF,$03 The column step.
  $D6C2,$02 Negate #REGa.
  $D6C4,$01 #REGa gains #REGl.
  $D6C5,$01 #REGl=#REGa.
  $D6C6,$03 Which drawing routine was chosen.
  $D6C9,$05 Jump to #R$D700 if #REGa is not #N$0B.
  $D6CE,$01 #REGa=#REGl.
  $D6CF,$05 Jump to #R$D700 if #REGa is less than #N$DD.
  $D6D4,$01 #REGa=#REGl.
  $D6D5,$02 Subtract #N$20 from #REGa.
  $D6D7,$01 #REGl=#REGa.
  $D6D8,$03 Jump to #R$D700.

c $D6DB Adjust Piece
@ $D6DB label=AdjustPiece
D $D6DB Adjusts the number of rows of a piece that is near the top of the
. screen so that it does not go above the top, and, for a sloped piece, limits
. the number of steps left in the segment to two. The screen address is loaded
. from #R$CE49.
E $D6DB Continue on to #R$D700.
R $D6DB A Vertical position of the piece
  $D6DB,$01 #REGb=#REGa.
  $D6DC,$03 The vertical step copy.
  $D6DF,$02 Negate #REGa.
  $D6E1,$01 #REGa gains #REGb.
  $D6E2,$02 Subtract #N$18 from #REGa.
  $D6E4,$03 Jump to #R$D6FD if the carry flag is clear.
  $D6E7,$01 Invert #REGa.
  $D6E8,$02 Shift #REGa right.
  $D6EA,$02 Negate #REGa.
  $D6EC,$01 #REGa gains #REGe.
  $D6ED,$01 #REGe=#REGa.
  $D6EE,$03 The vertical step.
  $D6F1,$03 Jump to #R$D6FD if #REGa is zero.
  $D6F4,$01 Switch to the alternate registers.
  $D6F5,$01 #REGa=#REGc.
  $D6F6,$04 Jump to #R$D6FC if #REGa is #N$01.
  $D6FA,$02 #REGc=#N$02.
@ $D6FC label=AdjustPiece_Columns
  $D6FC,$01 Switch to the alternate registers.
@ $D6FD label=AdjustPiece_Address
  $D6FD,$03 Fetch the word at #R$CE49 into #REGhl.

c $D700 Jump To Drawing Routine
@ $D700 label=JumpToDrawingRoutine
D $D700 Jumps to the routine that draws the piece. The displacement of the
. relative jump at #R$D701 is held in #N$D702 and chosen by #R$D3D2 and
. #R$D588: zero for the routine in #REGiy, #N$02 for #R$DB89, #N$05 for
. #R$DC47, #N$08 for #R$DBB7 and #N$0B for #R$DBFD.
R $D700 E Number of rows in a block
R $D700 HL Screen address
R $D700 IY Address of the routine for the type of segment
  $D700,$01 #REGa=#REGe.
@ $D701 label=JumpToDrawingRoutine_Jump
  $D701,$02 Jump forward by the displacement at #N$D702.
@ $D703 label=JumpToDrawingRoutine_Iy
  $D703,$02 Jump to the address in #REGiy.
@ $D705 label=JumpToDrawingRoutine_First
  $D705,$03 Jump to #R$DB89.
@ $D708 label=JumpToDrawingRoutine_Second
  $D708,$03 Jump to #R$DC47.
@ $D70B label=JumpToDrawingRoutine_Third
  $D70B,$03 Jump to #R$DBB7.
@ $D70E label=JumpToDrawingRoutine_Fourth
  $D70E,$03 Jump to #R$DBFD.

c $D711 Finish Step
@ $D711 label=FinishStep
D $D711 Finishes the drawing of a step. The screen address that the drawing has
. reached is stored in #R$CE49 (at #R$D711 only), the number of steps drawn is
. counted and the next step of the segment is started, until the segment has no
. steps left.
E $D711 Continue on to #R$D729.
R $D711 HL Screen address
  $D711,$03 Update the segment screen address.
@ $D714 label=FinishStep_Exchange
  $D714,$01 Switch to the alternate registers.
  $D715,$01 Advance #REGd.
@ $D716 label=FinishStep_Count
  $D716,$03 The flagged steps.
  $D719,$01 Advance #REGa.
  $D71A,$03 Update the flagged steps.
  $D71D,$03 The steps already drawn.
  $D720,$01 Advance #REGa.
  $D721,$03 Update the steps already drawn.
@ $D724 label=FinishStep_Next
  $D724,$01 Advance #REGhl.
  $D725,$01 Step #REGc back.
  $D726,$03 Jump to #R$D319 if the zero flag is clear.

c $D729 End Segment
@ $D729 label=EndSegment
D $D729 Finishes the last step of a segment: the end of the segment is stored
. at offset #N$02 of the record and #R$D86A draws the pixels at the edge of a
. sloped segment. If steps of the segment were flagged (#R$5C2F is not zero)
. and the horizontal offset is a multiple of eight, the routine starts or stops
. the horizontal speed in #R$CCBB depending on the direction of the segment and
. fills the pixels of the steps that were flagged with #R$E41C, using the
. chequer pattern or blank. Purpose not yet known for the details of this.
E $D729 Continue on to #R$D7F8.
  $D729,$03 Write #REGd to offset #N$02 of #REGix.
  $D72C,$03 Set the stack pointer to #N$5B7A.
  $D72F,$03 Call #R$D86A.
  $D732,$03 The flagged steps.
  $D735,$04 Jump to #R$D7F8 if #REGa is zero.
  $D739,$03 The horizontal offset.
  $D73C,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $D73E,$03 Jump to #R$D7F8 if the zero flag is clear.
  $D741,$03 The alignment that should stop the scroll.
  $D744,$03 The horizontal scroll speed.
  $D747,$04 Jump to #R$D766 if #REGa is not zero.
  $D74B,$03 The vertical step.
  $D74E,$04 Jump to #R$D7F8 if #REGa is zero.
  $D752,$03 The vertical step that should stop the scroll.
  $D755,$03 The slope direction.
  $D758,$01 #REGb=#REGa.
  $D759,$03 The horizontal step copy.
  $D75C,$03 Jump to #R$D762 if #REGa is zero.
  $D75F,$03 The upside-down segment flag.
@ $D762 label=EndSegment_Store
  $D762,$01 Flip the bits of #REGa that are set in #REGb.
  $D763,$03 Update the horizontal scroll speed.
@ $D766 label=EndSegment_Fill
  $D766,$03 The vertical step.
  $D769,$04 Jump to #R$D8DA if #REGa is zero.
  $D76D,$01 Switch to the alternate registers.
  $D76E,$03 Fetch the word at #R$CE4F into #REGhl.
  $D771,$03 The saved row.
  $D774,$03 Update the segment row.
  $D777,$03 The horizontal step copy.
  $D77A,$03 Jump to #R$D788 if #REGa is not zero.
  $D77D,$03 Update the upside-down segment flag.
  $D780,$03 The slope direction.
  $D783,$02 Negate #REGa.
  $D785,$03 Update the column step.
@ $D788 label=EndSegment_Pattern
  $D788,$03 #REGde=#N$55AA.
  $D78B,$03 The horizontal scroll speed.
  $D78E,$01 #REGb=#REGa.
  $D78F,$03 The upside-down segment flag.
  $D792,$01 Flip the bits of #REGa that are set in #REGb.
  $D793,$01 #REGb=#REGa.
  $D794,$03 The slope direction.
  $D797,$01 Flip the bits of #REGa that are set in #REGb.
  $D798,$04 Jump to #R$D79F if bit 7 of #REGa is clear.
  $D79C,$03 #REGde=#N$00.
@ $D79F label=EndSegment_Direction
  $D79F,$03 The slope direction.
  $D7A2,$04 Jump to #R$D7B9 if #REGa is #N$FF.
  $D7A6,$03 The horizontal scroll speed.
  $D7A9,$04 Jump to #R$D7B1 if bit 7 of #REGa is set.
  $D7AD,$01 Step #REGl back.
  $D7AE,$03 Jump to #R$D7C9.
@ $D7B1 label=EndSegment_Column
  $D7B1,$03 The column step size.
  $D7B4,$01 #REGa gains #REGl.
  $D7B5,$01 #REGl=#REGa.
  $D7B6,$03 Jump to #R$D7C1.
@ $D7B9 label=EndSegment_Flat
  $D7B9,$03 The horizontal scroll speed.
  $D7BC,$04 Jump to #R$D7C4 if bit 7 of #REGa is set.
  $D7C0,$01 Step #REGl back.
@ $D7C1 label=EndSegment_Jump
  $D7C1,$03 Jump to #R$D7C9.
@ $D7C4 label=EndSegment_Step
  $D7C4,$03 The column step.
  $D7C7,$01 #REGa gains #REGl.
  $D7C8,$01 #REGl=#REGa.
@ $D7C9 label=EndSegment_Rows
  $D7C9,$03 The horizontal step copy.
  $D7CC,$03 Jump to #R$D7E0 if #REGa is not zero.
  $D7CF,$03 The flagged steps.
  $D7D2,$01 #REGb=#REGa.
  $D7D3,$01 Clear #REGa.
@ $D7D4 label=EndSegment_Rows2
  $D7D4,$02 Add #N$10 to #REGa.
  $D7D6,$02 Decrease #REGb and jump to #R$D7D4 until none remain.
  $D7D8,$03 Update the vertical step copy.
  $D7DB,$02 #REGa=#N$01.
  $D7DD,$03 Update the flagged steps.
@ $D7E0 label=EndSegment_Strip
  $D7E0,$03 The vertical step copy.
  $D7E3,$02 Shift #REGa right.
  $D7E5,$01 #REGc=#REGa.
  $D7E6,$01 Switch to the alternate registers.
  $D7E7,$03 The flagged steps.
  $D7EA,$01 #REGb=#REGa.
  $D7EB,$03 Call #R$E41C.
  $D7EE,$03 See whether that marker should stop the scroll.
  $D7F1,$03 Jump to #R$D7F8 if #REGa is zero.
  $D7F4,$01 Clear #REGa.
  $D7F5,$03 Update the horizontal scroll speed.

c $D7F8 Finish Segment
@ $D7F8 label=FinishSegment
D $D7F8 Finishes a segment. When the world is scrolling vertically and steps of
. the segment have been counted, the edge of the segment is drawn by #R$D9A8.
. Otherwise the attributes of the segment are coloured with #R$CF38.
E $D7F8 Continue on to #R$D80A.
  $D7F8,$01 Switch to the alternate registers.
  $D7F9,$03 The vertical scroll speed.
  $D7FC,$03 Jump to #R$D806 if #REGa is zero.
  $D7FF,$03 The steps already drawn.
  $D802,$04 Jump to #R$D9A8 if #REGa is not zero.
@ $D806 label=FinishSegment_Colour
  $D806,$03 Call #R$CF38.
  $D809,$01 Switch to the alternate registers.

c $D80A Next Segment
@ $D80A label=NextSegment
D $D80A Moves on to the next segment of the script, using the address that
. #R$CD6B stored in #R$CE4D, until the last has been drawn. Then the next tile
. is started: the vertical offset (and for the third tile the horizontal
. offset) is changed to move to the position of that tile. After the fourth
. tile the horizontal offset is put back.
  $D80A,$03 Set the stack pointer to #N$5B7A.
  $D80D,$03 Fetch the word at #R$CE4D into #REGhl.
  $D810,$03 The segments still to draw.
  $D813,$01 Step #REGa back.
  $D814,$03 Update the segments still to draw.
  $D817,$03 Jump to #R$D15C if the zero flag is clear.
@ $D81A label=NextSegment_Tile
  $D81A,$03 The tile number.
  $D81D,$01 Advance #REGa.
  $D81E,$03 Update the tile number.
  $D821,$04 Jump to #R$D848 if #REGa is #N$04.
  $D825,$02 Test bit 0 of #REGa.
  $D827,$02 #REGb=#N$60.
  $D829,$02 Jump to #R$D82D if the zero flag is set.
  $D82B,$02 #REGb=#N$A0.
@ $D82D label=NextSegment_Offset
  $D82D,$03 The vertical offset.
  $D830,$01 #REGa gains #REGb.
  $D831,$03 Update the vertical offset.
  $D834,$03 The tile number.
  $D837,$05 Jump to #R$D0FF if #REGa is not #N$02.
  $D83C,$02 #REGb=#N$20.
  $D83E,$03 The horizontal offset.
  $D841,$01 Subtract #REGb from #REGa.
  $D842,$03 Update the horizontal offset.
  $D845,$03 Jump to #R$D0FF.
@ $D848 label=NextSegment_Done
  $D848,$03 The horizontal offset.
  $D84B,$02 Add #N$20 to #REGa.
  $D84D,$03 Update the horizontal offset.
  $D850,$01 Return.

b $D851 Edge Patterns Right
@ $D851 label=EdgePatternsRight
D $D851 Pixel bytes for the edge of a flat segment, four bytes for each of the
. horizontal offsets of two to seven pixels (each starts two bytes after the
. one before). #R$D86A draws them.
B $D851,$0C,$04

g $D85D Edge Flag
@ $D85D label=EdgeFlag
D $D85D Set to zero when each segment is started and to #N($FF) by #R$D319 when
. the last step of a flat segment is found to be at the right edge of the area.
. #R$D86A and #R$D9A8 test it.
B $D85D,$01,$01

b $D85E Edge Patterns Left
@ $D85E label=EdgePatternsLeft
D $D85E The same as #R$D851 for a segment that is not the first of a tile, as
. selected by the type at offset #N$03 of the drawing record.
B $D85E,$0C,$04

c $D86A Draw Edge Pixels
@ $D86A label=DrawEdgePixels
D $D86A Draws the pixels that finish the edge of a flat segment when the
. horizontal offset is not a multiple of eight. Nothing is drawn unless the
. segment is flat, its shape code (see #R$5C34) is #N($13) or #N($93) and steps
. have been flagged. The four bytes come from #R$D851 or #R$D85E, depending on
. the type, and are stored going up the screen at the address in #R$CE49,
. except that only #N$02 are stored when the segment is at the top or bottom of
. the area.
R $D86A IX Address of the drawing record at #R$DEDC
  $D86A,$03 The vertical step.
  $D86D,$02 Return if #REGa is not zero.
  $D86F,$03 The segment end shape.
  $D872,$02,b$01 Keep the bits of #REGa that are set in #N$7F.
  $D874,$03 Return if #REGa is not #N$13.
  $D877,$03 The flagged steps.
  $D87A,$02 Return if #REGa is zero.
  $D87C,$03 The edge patterns right.
  $D87F,$03 Read offset #N$03 of #REGix.
  $D882,$03 Jump to #R$D888 if #REGa is zero.
  $D885,$03 The edge patterns left.
@ $D888 label=DrawEdgePixels_Table
  $D888,$03 The horizontal offset.
  $D88B,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $D88D,$01 Return if the zero flag is set.
  $D88E,$01 Step #REGa back.
  $D88F,$01 Step #REGa back.
  $D890,$01 Double #REGa.
  $D891,$01 #REGe=#REGa.
  $D892,$02 Clear #REGd.
  $D894,$01 #REGhl gains #REGde.
  $D895,$01 Swap #REGde and #REGhl.
  $D896,$03 The edge flag.
  $D899,$01 Is #REGa zero?
  $D89A,$03 Fetch the word at #R$CE49 into #REGhl.
  $D89D,$02 Jump to #R$D8AA if the zero flag is set.
  $D89F,$04 Store #N$00 at offset #N$01 of #REGix.
  $D8A3,$01 #REGa=#REGl.
  $D8A4,$02 Subtract #N$20 from #REGa.
  $D8A6,$01 #REGl=#REGa.
  $D8A7,$01 Advance #REGl.
  $D8A8,$01 Advance #REGl.
  $D8A9,$01 Advance #REGl.
@ $D8AA label=DrawEdgePixels_Address
  $D8AA,$01 Advance #REGl.
  $D8AB,$01 Advance #REGl.
  $D8AC,$01 Advance #REGl.
  $D8AD,$01 #REGa=#REGl.
  $D8AE,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D8B0,$01 Step #REGa back.
  $D8B1,$03 Return if #REGa is #N$1C or more.
  $D8B4,$02 #REGb=#N$04.
  $D8B6,$03 The segment screen row.
  $D8B9,$04 Jump to #R$D8CB if #REGa is not #N$B9.
  $D8BD,$01 Advance #REGde.
  $D8BE,$01 Advance #REGde.
  $D8BF,$02 #REGh=#N$57.
  $D8C1,$01 #REGa=#REGl.
  $D8C2,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $D8C4,$02,b$01 Set the bits of #REGa that are set in #N$C0.
  $D8C6,$01 #REGl=#REGa.
  $D8C7,$02 #REGb=#N$02.
  $D8C9,$02 Jump to #R$D8D1.
@ $D8CB label=DrawEdgePixels_Rows
  $D8CB,$04 Jump to #R$D8D1 if #REGa is not #N$19.
  $D8CF,$02 #REGb=#N$02.
@ $D8D1 label=DrawEdgePixels_Draw
  $D8D1,$01 Read #REGde.
  $D8D2,$01 Write #REGa where #REGhl points.
  $D8D3,$01 Advance #REGde.
  $D8D4,$03 Call #R$A1C3.
  $D8D7,$02 Decrease #REGb and jump to #R$D8D1 until none remain.
  $D8D9,$01 Return.

c $D8DA Fill Slope Edge
@ $D8DA label=FillSlopeEdge
D $D8DA Clears the pixels at the end of a sloped segment when the world is
. moving horizontally and the shape code of the segment says that it is a slope
. (bit 0 of the shape code that goes with the direction, in #R$5C33 or
. #R$5C34). The screen address of the end is found from #R$CE4F, moved to
. either side, and #R$E41C fills a strip there with zeros.
R $D8DA IX Address of the drawing record at #R$DEDC
  $D8DA,$03 The horizontal scroll speed.
  $D8DD,$04 Jump to #R$D7F8 if #REGa is zero.
  $D8E1,$03 Read offset #N$01 of #REGix.
  $D8E4,$03 Jump to #R$D900 if #REGa is not zero.
  $D8E7,$03 The horizontal scroll speed.
  $D8EA,$02 Test bit 7 of #REGa.
  $D8EC,$03 The segment end shape.
  $D8EF,$02 Jump to #R$D8F4 if the zero flag is clear.
  $D8F1,$03 The segment start shape.
@ $D8F4 label=FillSlopeEdge_Check
  $D8F4,$05 Jump to #R$D7F8 if bit 0 of #REGa is clear.
  $D8F9,$01 Switch to the alternate registers.
  $D8FA,$03 Fetch the word at #R$CE4F into #REGhl.
  $D8FD,$01 Step #REGl back.
  $D8FE,$02 Jump to #R$D918.
@ $D900 label=FillSlopeEdge_Right
  $D900,$03 The shape flag.
  $D903,$04 Jump to #R$D7F8 if #REGa is zero.
  $D907,$01 Switch to the alternate registers.
  $D908,$03 Fetch the word at #R$CE4F into #REGhl.
  $D90B,$01 Advance #REGl.
  $D90C,$01 Advance #REGl.
  $D90D,$03 The screen column.
  $D910,$04 Jump to #R$D918 if #REGa is less than #N$F0.
  $D914,$01 #REGa=#REGl.
  $D915,$02 Subtract #N$20 from #REGa.
  $D917,$01 #REGl=#REGa.
@ $D918 label=FillSlopeEdge_Fill
  $D918,$03 The saved row.
  $D91B,$03 Update the segment row.
  $D91E,$03 The horizontal scroll speed.
  $D921,$04 Jump to #R$D929 if bit 7 of #REGa is clear.
  $D925,$01 #REGa=#REGl.
  $D926,$02 Add #N$04 to #REGa.
  $D928,$01 #REGl=#REGa.
@ $D929 label=FillSlopeEdge_Pattern
  $D929,$03 #REGde=#N$00.
  $D92C,$02 #REGc=#N$02.
  $D92E,$01 Switch to the alternate registers.
  $D92F,$02 #REGb=#N$01.
  $D931,$03 Call #R$E41C.
  $D934,$03 Jump to #R$D7F8.

c $D937 Find Segment Address
@ $D937 label=FindSegmentAddress
D $D937 Finds the screen address of the start of the current segment from its
. pixel position in #R$CE43 and #R$CE44 and the offsets in #R$CE41 and #R$CE42.
. The pixel position is stored in the drawing record at #R$DEDC and in #R$5C2C
. and #R$5C2D. If no step of the segment has been flagged (#R$5C2F is zero) the
. address is also stored in #R$CE4F with the pixel row in #R$CE53.
E $D937 Continue on to #R$D979.
R $D937 IX Address of the drawing record at #R$DEDC
R $D937 O:HL Screen address
  $D937,$03 The segment row.
  $D93A,$01 #REGh=#REGa.
  $D93B,$03 The vertical offset.
  $D93E,$01 #REGa gains #REGh.
  $D93F,$01 #REGh=#REGa.
  $D940,$03 Write #REGa to offset #N$01 of #REGix.
  $D943,$03 Update the segment screen row.
  $D946,$03 The segment column.
  $D949,$01 #REGl=#REGa.
  $D94A,$03 The horizontal offset.
  $D94D,$01 #REGa gains #REGl.
  $D94E,$01 #REGl=#REGa.
  $D94F,$03 Update the segment screen column.
  $D952,$03 Write #REGa to offset #N$00 of #REGix.
  $D955,$02 Clear #REGd.
  $D957,$04 Jump to #R$D95D if #REGa is less than #N$F0.
  $D95B,$02 #REGd=#N$20.
@ $D95D label=FindSegmentAddress_Address
  $D95D,$03 Call #R$A149.
  $D960,$03 The flagged steps.
  $D963,$03 Jump to #R$D974 if #REGa is not zero.
  $D966,$01 #REGa=#REGl.
  $D967,$01 Subtract #REGd from #REGa.
  $D968,$01 #REGl=#REGa.
  $D969,$03 Update the saved screen address.
  $D96C,$01 #REGa gains #REGd.
  $D96D,$01 #REGl=#REGa.
  $D96E,$03 The segment screen row.
  $D971,$03 Update the saved row.
@ $D974 label=FindSegmentAddress_Count
  $D974,$03 The steps already drawn.
  $D977,$02 Return if #REGa is not zero.

c $D979 Note Segment Start
@ $D979 label=NoteSegmentStart
D $D979 Stores the pixel position of the start of the segment, with the offsets
. of the view added, in #R$CE55 and #R$CE56.
  $D979,$03 The segment column.
  $D97C,$01 #REGb=#REGa.
  $D97D,$03 The horizontal offset.
  $D980,$01 #REGa gains #REGb.
  $D981,$03 Update the start column.
  $D984,$03 The segment row.
  $D987,$01 #REGb=#REGa.
  $D988,$03 The vertical offset.
  $D98B,$01 #REGa gains #REGb.
  $D98C,$03 Update the start row.
  $D98F,$01 Return.

c $D990 Adjust Edge Address
@ $D990 label=AdjustEdgeAddress
D $D990 Moves the screen address in #REGhl one cell to the left when the
. horizontal speed is negative. The last four instructions, which would move it
. back and count a step less, cannot be reached because the speed is known to
. be negative.
R $D990 C Number of steps left
R $D990 HL Screen address
R $D990 O:C Number of steps left
R $D990 O:HL Screen address
  $D990,$03 The horizontal scroll speed.
  $D993,$03 Return if bit 7 of #REGa is clear.
  $D996,$01 Step #REGl back.
  $D997,$03 The segment row.
  $D99A,$03 Return if #REGa is #N$5F or more.
  $D99D,$03 The horizontal scroll speed.
  $D9A0,$02 Negate #REGa.
  $D9A2,$03 Return if bit 7 of #REGa is clear.
  $D9A5,$01 Advance #REGl.
  $D9A6,$01 Step #REGc back.
  $D9A7,$01 Return.

c $D9A8 Draw Vertical Edge
@ $D9A8 label=DrawVerticalEdge
D $D9A8 Draws the edge of the terrain when the world is scrolling vertically,
. for the steps of a segment that have been counted in #R$CE54. A strip across
. the segment is filled with either a chequered pattern (#N($55AA)) or blank
. (zero), depending on whether the vertical speed in #R$CCBA and the direction
. are the same, using #R$DB41 or #R$DB49. The routine finally carries on with
. #R$D806. Purpose not yet known for the details of the positions.
  $D9A8,$04 The fill four edge rows.
  $D9AC,$03 The vertical distance.
  $D9AF,$04 Jump to #R$D9B7 if #REGa is #N$04.
  $D9B3,$04 The fill two edge rows.
@ $D9B7 label=DrawVerticalEdge_Pattern
  $D9B7,$03 #REGde=#N$00.
  $D9BA,$03 The vertical scroll speed.
  $D9BD,$01 #REGb=#REGa.
  $D9BE,$03 The upside-down segment flag.
  $D9C1,$01 Flip the bits of #REGa that are set in #REGb.
  $D9C2,$04 Jump to #R$D9C9 if bit 7 of #REGa is clear.
  $D9C6,$03 #REGde=#N$55AA.
@ $D9C9 label=DrawVerticalEdge_Address
  $D9C9,$03 Fetch the word at #R$CE55 into #REGhl.
  $D9CC,$03 The horizontal step copy.
  $D9CF,$03 Jump to #R$DA01 if #REGa is not zero.
  $D9D2,$03 The slope direction.
  $D9D5,$04 Jump to #R$D9DD if #REGa is #N$01.
  $D9D9,$01 #REGa=#REGl.
  $D9DA,$02 Add #N$07 to #REGa.
  $D9DC,$01 #REGl=#REGa.
@ $D9DD label=DrawVerticalEdge_Count
  $D9DD,$03 The steps already drawn.
  $D9E0,$01 #REGb=#REGa.
  $D9E1,$01 Clear #REGa.
@ $D9E2 label=DrawVerticalEdge_Rows2
  $D9E2,$02 Add #N$10 to #REGa.
  $D9E4,$02 Decrease #REGb and jump to #R$D9E2 until none remain.
  $D9E6,$03 Update the vertical step copy.
  $D9E9,$02 #REGa=#N$01.
  $D9EB,$03 Update the steps already drawn.
  $D9EE,$03 #REGde=#N$55AA.
  $D9F1,$03 The slope direction.
  $D9F4,$01 #REGb=#REGa.
  $D9F5,$03 The horizontal scroll speed.
  $D9F8,$03 Jump to #R$DA01 if #REGa is zero.
  $D9FB,$01 Flip the bits of #REGa that are set in #REGb.
  $D9FC,$05 Jump to #R$D806 if bit 7 of #REGa is set.
@ $DA01 label=DrawVerticalEdge_Rows
  $DA01,$03 The vertical scroll speed.
  $DA04,$02 Test bit 7 of #REGa.
  $DA06,$03 The vertical distance.
  $DA09,$02 Jump to #R$DA10 if the zero flag is clear.
  $DA0B,$03 The vertical step copy.
  $DA0E,$02 Negate #REGa.
@ $DA10 label=DrawVerticalEdge_Row
  $DA10,$01 #REGa gains #REGh.
  $DA11,$01 #REGh=#REGa.
  $DA12,$03 Update the segment row.
  $DA15,$03 The edge position.
  $DA18,$03 The vertical step.
  $DA1B,$03 Jump to #R$DA52 if #REGa is not zero.
  $DA1E,$03 The horizontal scroll speed.
  $DA21,$02 Negate #REGa.
  $DA23,$01 #REGa gains #REGl.
  $DA24,$01 #REGl=#REGa.
  $DA25,$03 The steps already drawn.
  $DA28,$01 #REGb=#REGa.
  $DA29,$02 #REGa=#N$01.
  $DA2B,$03 Update the steps already drawn.
  $DA2E,$03 The edge flag.
  $DA31,$03 Jump to #R$DA45 if #REGa is zero.
  $DA34,$03 The segment end shape.
  $DA37,$02,b$01 Keep the bits of #REGa that are set in #N$7F.
  $DA39,$04 Jump to #R$DA45 if #REGa is not #N$13.
  $DA3D,$01 #REGa=#REGe.
  $DA3E,$03 Jump to #R$DA45 if #REGa is zero.
  $DA41,$02 #REGa=#N$01.
  $DA43,$02 Jump to #R$DA4B.
@ $DA45 label=DrawVerticalEdge_Width
  $DA45,$02 #REGa=#N$01.
@ $DA47 label=DrawVerticalEdge_Cells
  $DA47,$02 Add #N$03 to #REGa.
  $DA49,$02 Decrease #REGb and jump to #R$DA47 until none remain.
@ $DA4B label=DrawVerticalEdge_Columns
  $DA4B,$03 Update the column step size.
  $DA4E,$01 Step #REGa back.
  $DA4F,$03 The extra columns of the edge.
@ $DA52 label=DrawVerticalEdge_Sloped
  $DA52,$03 The horizontal step copy.
  $DA55,$04 Jump to #R$DAA0 if #REGa is zero.
  $DA59,$03 Read offset #N$01 of #REGix.
  $DA5C,$03 Jump to #R$DAA0 if #REGa is not zero.
  $DA5F,$01 #REGa=#REGe.
  $DA60,$03 Jump to #R$DA6E if #REGa is zero.
  $DA63,$03 The last contact flags.
  $DA66,$03 Jump to #R$DA6E if #REGa is zero.
  $DA69,$01 #REGa=#REGh.
  $DA6A,$04 Jump to #R$DA75 if #REGa is #N$1F or more.
@ $DA6E label=DrawVerticalEdge_Move
  $DA6E,$03 The horizontal scroll speed.
  $DA71,$02 Negate #REGa.
  $DA73,$01 #REGa gains #REGl.
  $DA74,$01 #REGl=#REGa.
@ $DA75 label=DrawVerticalEdge_Flags
  $DA75,$03 The last contact flags.
  $DA78,$03 Jump to #R$DAA0 if #REGa is zero.
  $DA7B,$04 Jump to #R$DA8D if #REGa is #N$01.
  $DA7F,$03 The slope direction.
  $DA82,$04 Jump to #R$DA94 if #REGa is #N$01.
@ $DA86 label=DrawVerticalEdge_Reverse
  $DA86,$02 Negate #REGa.
  $DA88,$03 Update the slope direction.
  $DA8B,$02 Jump to #R$DA94.
@ $DA8D label=DrawVerticalEdge_Same
  $DA8D,$03 The slope direction.
  $DA90,$04 Jump to #R$DA86 if #REGa is #N$01.
@ $DA94 label=DrawVerticalEdge_Align
  $DA94,$01 #REGa=#REGl.
  $DA95,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $DA97,$02 Jump to #R$DAA0 if the zero flag is set.
  $DA99,$03 The column step size.
  $DA9C,$01 Advance #REGa.
  $DA9D,$03 Update the column step size.
@ $DAA0 label=DrawVerticalEdge_Start
  $DAA0,$03 The vertical step.
  $DAA3,$04 Call #R$8347 if #REGa is zero.
  $DAA7,$02 Clear #REGb.
  $DAA9,$01 #REGa=#REGl.
  $DAAA,$03 Update the screen column.
  $DAAD,$04 Jump to #R$DAB3 if #REGa is less than #N$F0.
  $DAB1,$01 #REGl=#REGb.
  $DAB2,$01 Advance #REGb.
@ $DAB3 label=DrawVerticalEdge_Screen
  $DAB3,$03 Call #R$A149.
  $DAB6,$01 #REGa=#REGl.
  $DAB7,$01 Subtract #REGb from #REGa.
  $DAB8,$01 #REGl=#REGa.
  $DAB9,$03 The column step size.
  $DABC,$01 #REGc=#REGa.
  $DABD,$03 The horizontal step copy.
  $DAC0,$04 Jump to #R$DB1A if #REGa is zero.
  $DAC4,$03 The vertical step.
  $DAC7,$03 Jump to #R$DAFA if #REGa is zero.
  $DACA,$03 Read offset #N$01 of #REGix.
  $DACD,$04 Jump to #R$DB03 if #REGa is zero.
  $DAD1,$03 The screen column.
  $DAD4,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $DAD6,$03 Jump to #R$DB03 if the zero flag is clear.
  $DAD9,$03 The horizontal scroll speed.
  $DADC,$03 Jump to #R$DAF7 if #REGa is zero.
  $DADF,$01 #REGb=#REGa.
  $DAE0,$03 The vertical scroll speed.
  $DAE3,$01 Flip the bits of #REGa that are set in #REGb.
  $DAE4,$01 #REGb=#REGa.
  $DAE5,$03 The slope direction.
  $DAE8,$01 Flip the bits of #REGa that are set in #REGb.
  $DAE9,$04 Jump to #R$DAF7 if bit 7 of #REGa is clear.
  $DAED,$01 Step #REGl back.
  $DAEE,$03 The horizontal scroll speed.
  $DAF1,$04 Jump to #R$DAF7 if bit 7 of #REGa is clear.
  $DAF5,$01 Advance #REGl.
  $DAF6,$01 Advance #REGl.
@ $DAF7 label=DrawVerticalEdge_Draw
  $DAF7,$03 Jump to #R$DB1A.
@ $DAFA label=DrawVerticalEdge_Flat
  $DAFA,$03 Read offset #N$01 of #REGix.
  $DAFD,$04 Call #R$D990 if #REGa is zero.
  $DB01,$02 Jump to #R$DB1A.
@ $DB03 label=DrawVerticalEdge_Slope
  $DB03,$03 The vertical step.
  $DB06,$03 Jump to #R$DB1A if #REGa is zero.
  $DB09,$03 The slope direction.
  $DB0C,$02 Compare #REGa with #N$01.
  $DB0E,$03 The vertical scroll speed.
  $DB11,$02 Jump to #R$DB15 if the zero flag is clear.
  $DB13,$02 Negate #REGa.
@ $DB15 label=DrawVerticalEdge_Check
  $DB15,$04 Jump to #R$DB1A if bit 7 of #REGa is clear.
  $DB19,$01 Advance #REGl.
@ $DB1A label=DrawVerticalEdge_Fill
  $DB1A,$01 Switch to the alternate registers.
  $DB1B,$03 The steps already drawn.
  $DB1E,$01 #REGb=#REGa.
  $DB1F,$03 Call #R$DB26.
  $DB22,$01 Switch to the alternate registers.
  $DB23,$03 Jump to #R$D806.

c $DB26 Call Edge Painter
@ $DB26 label=CallEdgePainter
D $DB26 Jumps to the routine for the edge in #REGiy, which is #R$DB41 or
. #R$DB49.
  $DB26,$01 Switch to the alternate registers.
  $DB27,$02 Jump to the address in #REGiy.

c $DB29 Move Up Edge Rows
@ $DB29 label=MoveUpEdgeRows
D $DB29 The end of the routines that fill the edge: moves up the rows that are
. left in the step and then goes round for the next step.
R $DB29 B Number of rows already filled
  $DB29,$03 The vertical step copy.
  $DB2C,$01 Subtract #REGb from #REGa.
  $DB2D,$01 #REGb=#REGa.
  $DB2E,$03 The segment row.
  $DB31,$01 Subtract #REGb from #REGa.
  $DB32,$03 Update the segment row.
  $DB35,$02 Shift #REGb right.
@ $DB37 label=MoveUpEdgeRows_Up
  $DB37,$01 Step #REGh back.
  $DB38,$03 Call #R$A1C3.
  $DB3B,$02 Decrease #REGb and jump to #R$DB37 until none remain.
  $DB3D,$01 Switch to the alternate registers.
  $DB3E,$02 Decrease #REGb and jump to #R$DB26 until none remain.
  $DB40,$01 Return.

c $DB41 Fill Two Edge Rows
@ $DB41 label=FillTwoEdgeRows
D $DB41 Fills one pair of pixel rows of the edge with the pattern in #REGde.
  $DB41,$03 Call #R$DB5B.
  $DB44,$02 #REGb=#N$02.
  $DB46,$03 Jump to #R$DB29.

c $DB49 Fill Four Edge Rows
@ $DB49 label=FillFourEdgeRows
D $DB49 Fills two pairs of pixel rows of the edge with the pattern in #REGde,
. moving along by the column step between them.
  $DB49,$03 Call #R$DB5B.
  $DB4C,$03 The column step.
  $DB4F,$02 Negate #REGa.
  $DB51,$01 #REGa gains #REGl.
  $DB52,$01 #REGl=#REGa.
  $DB53,$03 Call #R$DB5B.
  $DB56,$02 #REGb=#N$04.
  $DB58,$03 Jump to #R$DB29.

c $DB5B Fill Edge Row Pair
@ $DB5B label=FillEdgeRowPair
D $DB5B Stores the pattern in #REGd and #REGe in two pixel rows, one above the
. other, for each of the #REGc cells across, but only the cells inside the area
. of the terrain. The pixel row in #R$CE44 goes up by two and the screen
. address moves up a row and along by the column step.
R $DB5B C Number of cells
R $DB5B DE Pattern for the two rows
R $DB5B HL Screen address
  $DB5B,$03 The segment row.
  $DB5E,$04 Jump to #R$DB78 if #REGa is #N$B8 or more.
  $DB62,$04 Jump to #R$DB78 if #REGa is less than #N$18.
  $DB66,$01 #REGb=#REGc.
  $DB67,$01 Stash #REGhl on the stack.
@ $DB68 label=FillEdgeRowPair_Cell
  $DB68,$01 #REGa=#REGl.
  $DB69,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $DB6B,$01 Step #REGa back.
  $DB6C,$04 Jump to #R$DB74 if #REGa is #N$1C or more.
  $DB70,$01 Write #REGd where #REGhl points.
  $DB71,$01 Step #REGh back.
  $DB72,$01 Write #REGe where #REGhl points.
  $DB73,$01 Advance #REGh.
@ $DB74 label=FillEdgeRowPair_Next
  $DB74,$01 Advance #REGl.
  $DB75,$02 Decrease #REGb and jump to #R$DB68 until none remain.
  $DB77,$01 Bring #REGhl back off the stack.
@ $DB78 label=FillEdgeRowPair_Up
  $DB78,$03 The segment row.
  $DB7B,$01 Step #REGa back.
  $DB7C,$01 Step #REGa back.
  $DB7D,$03 Update the segment row.
  $DB80,$03 The column step.
  $DB83,$01 #REGa gains #REGl.
  $DB84,$01 #REGl=#REGa.
  $DB85,$01 Step #REGh back.
  $DB86,$03 Jump to #R$A1C3.

c $DB89 Draw Slope Rows
@ $DB89 label=DrawSlopeRows
D $DB89 Draws the rows of a piece of a slope two bytes wide, going up the
. screen two pixel rows at a time. The words of the picture are popped from the
. stack: the bytes of the first word go to the left and right, and of the third
. word to the right and left, so that they make a zigzag. The second word of
. each group is not used. The jump at #R$DB91 has its displacement set by
. #R$D3D2 to skip the first byte of each pair of rows when only part of the
. piece is drawn. When the pixel row is the top of a character the routine
. moves up to the character above.
R $DB89 A Number of pairs of pixel rows to draw
R $DB89 HL Screen address
R $DB89 SP Address of the picture
  $DB89,$01 #REGb=#REGa.
  $DB8A,$03 The column step.
  $DB8D,$01 #REGa gains #REGl.
  $DB8E,$01 #REGl=#REGa.
@ $DB8F label=DrawSlopeRows_Loop
  $DB8F,$01 Bring #REGde back off the stack.
  $DB90,$01 Write #REGe where #REGhl points.
@ $DB91 label=DrawSlopeRows_Patch
  $DB91,$02 Skip ahead by the displacement at #N$DB92.
  $DB93,$01 Advance #REGl.
  $DB94,$01 Write #REGd where #REGhl points.
  $DB95,$01 Step #REGh back.
  $DB96,$01 Bring #REGde back off the stack.
  $DB97,$01 Bring #REGde back off the stack.
  $DB98,$01 Write #REGe where #REGhl points.
  $DB99,$01 Step #REGl back.
@ $DB9A label=DrawSlopeRows_Second
  $DB9A,$01 Write #REGd where #REGhl points.
  $DB9B,$01 Step #REGh back.
  $DB9C,$01 #REGa=#REGh.
  $DB9D,$01 Advance #REGa.
  $DB9E,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $DBA0,$02 Jump to #R$DBAC if the zero flag is clear.
  $DBA2,$01 #REGa=#REGl.
  $DBA3,$02 Subtract #N$20 from #REGa.
  $DBA5,$01 #REGl=#REGa.
  $DBA6,$02 Jump to #R$DBAC if the carry flag is set.
  $DBA8,$01 #REGa=#REGh.
  $DBA9,$02 Add #N$08 to #REGa.
  $DBAB,$01 #REGh=#REGa.
@ $DBAC label=DrawSlopeRows_Next
  $DBAC,$02 Decrease #REGb and jump to #R$DB8F until none remain.
  $DBAE,$03 Jump to #R$D711.
  $DBB1,$01 Bring #REGde back off the stack.
  $DBB2,$01 Bring #REGde back off the stack.
  $DBB3,$01 Step #REGh back.
  $DBB4,$03 Jump to #R$DB9A.

c $DBB7 Draw Slope Rows From Edge
@ $DBB7 label=DrawSlopeRowsFromEdge
D $DBB7 Draws the rows of a piece of a slope two bytes wide, going up the
. screen two pixel rows at a time, starting from the second column of the row
. that the screen address is in (or the next one if it is in the last two
. columns). The two jumps at #R$DBC0 and #R$DBC5 are changed by #R$D3D2 to skip
. bytes when only part of the piece is to be drawn. The variable #R$5C2E sets
. where the next piece starts on the row. The routine finishes with #R$D711.
R $DBB7 A Number of pairs of pixel rows to draw
R $DBB7 HL Screen address
R $DBB7 SP Address of the picture
  $DBB7,$01 #REGb=#REGa.
  $DBB8,$01 #REGa=#REGl.
  $DBB9,$01 Advance #REGa.
  $DBBA,$01 Advance #REGa.
  $DBBB,$02,b$01 Keep the bits of #REGa that are set in #N$E0.
  $DBBD,$01 Advance #REGa.
  $DBBE,$01 #REGl=#REGa.
  $DBBF,$01 Advance #REGsp.
@ $DBC0 label=DrawSlopeRowsFromEdge_PatchFirst
  $DBC0,$02 Skip ahead by the displacement at #N$DBC1.
  $DBC2,$01 Advance #REGsp.
@ $DBC3 label=DrawSlopeRowsFromEdge_Loop
  $DBC3,$01 Bring #REGde back off the stack.
  $DBC4,$01 Write #REGe where #REGhl points.
@ $DBC5 label=DrawSlopeRowsFromEdge_PatchSecond
  $DBC5,$02 Skip ahead by the displacement at #N$DBC6.
  $DBC7,$01 Advance #REGl.
  $DBC8,$01 Write #REGd where #REGhl points.
  $DBC9,$01 Step #REGh back.
  $DBCA,$01 Bring #REGde back off the stack.
  $DBCB,$01 Write #REGe where #REGhl points.
  $DBCC,$01 Step #REGl back.
@ $DBCD label=DrawSlopeRowsFromEdge_StoreHigh
  $DBCD,$01 Write #REGd where #REGhl points.
@ $DBCE label=DrawSlopeRowsFromEdge_PopWord
  $DBCE,$01 Bring #REGde back off the stack.
  $DBCF,$01 Step #REGh back.
  $DBD0,$01 #REGa=#REGh.
  $DBD1,$01 Advance #REGa.
  $DBD2,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $DBD4,$02 Jump to #R$DBE0 if the zero flag is clear.
  $DBD6,$01 #REGa=#REGl.
  $DBD7,$02 Subtract #N$20 from #REGa.
  $DBD9,$01 #REGl=#REGa.
  $DBDA,$02 Jump to #R$DBE0 if the carry flag is set.
  $DBDC,$01 #REGa=#REGh.
  $DBDD,$02 Add #N$08 to #REGa.
  $DBDF,$01 #REGh=#REGa.
@ $DBE0 label=DrawSlopeRowsFromEdge_Next
  $DBE0,$02 Decrease #REGb and jump to #R$DBC3 until none remain.
  $DBE2,$03 The piece column.
  $DBE5,$01 #REGb=#REGa.
  $DBE6,$03 The column step.
  $DBE9,$01 #REGc=#REGa.
  $DBEA,$01 #REGa=#REGl.
  $DBEB,$02,b$01 Keep the bits of #REGa that are set in #N$E0.
  $DBED,$01 Set the bits of #REGa that are set in #REGb.
  $DBEE,$01 Subtract #REGc from #REGa.
  $DBEF,$01 #REGl=#REGa.
  $DBF0,$03 Jump to #R$D711.
  $DBF3,$01 Step #REGh back.
  $DBF4,$03 Jump to #R$DBCD.
  $DBF7,$01 Step #REGh back.
  $DBF8,$01 Write #REGd where #REGhl points.
  $DBF9,$01 Bring #REGde back off the stack.
  $DBFA,$03 Jump to #R$DBCE.

c $DBFD Draw Mirrored Rows From Edge
@ $DBFD label=DrawMirroredRowsFromEdge
D $DBFD Draws the rows of a piece of a slope back to front, two bytes wide,
. going up the screen two pixel rows at a time, starting from the second column
. of the row (see #R$DBB7). Each byte of the picture is reversed using the
. table at #N$F900 (#REGb is set to #N($F9)). The jumps at #R$DC0B and #R$DC13
. are changed by #R$D3D2 to skip bytes when only part of the piece is to be
. drawn.
R $DBFD A Number of pairs of pixel rows to draw
R $DBFD HL Screen address
R $DBFD SP Address of the picture
  $DBFD,$01 Switch to the alternate registers.
  $DBFE,$01 #REGb=#REGa.
  $DBFF,$01 Switch to the alternate registers.
  $DC00,$01 #REGa=#REGl.
  $DC01,$01 Advance #REGa.
  $DC02,$01 Advance #REGa.
  $DC03,$02,b$01 Keep the bits of #REGa that are set in #N$E0.
  $DC05,$01 Advance #REGa.
  $DC06,$01 #REGl=#REGa.
  $DC07,$02 #REGb=#N$F9.
  $DC09,$01 Switch to the alternate registers.
  $DC0A,$01 Advance #REGsp.
@ $DC0B label=DrawMirroredRowsFromEdge_PatchFirst
  $DC0B,$02 Skip ahead by the displacement at #N$DC0C.
  $DC0D,$01 Advance #REGsp.
@ $DC0E label=DrawMirroredRowsFromEdge_Loop
  $DC0E,$01 Switch to the alternate registers.
  $DC0F,$01 Bring #REGde back off the stack.
  $DC10,$01 #REGc=#REGe.
  $DC11,$01 Read #REGbc.
  $DC12,$01 Write #REGa where #REGhl points.
@ $DC13 label=DrawMirroredRowsFromEdge_PatchSecond
  $DC13,$02 Skip ahead by the displacement at #N$DC14.
  $DC15,$01 Advance #REGl.
  $DC16,$01 #REGc=#REGd.
  $DC17,$01 Read #REGbc.
  $DC18,$01 Write #REGa where #REGhl points.
  $DC19,$01 Step #REGh back.
  $DC1A,$01 Bring #REGde back off the stack.
  $DC1B,$01 #REGc=#REGe.
  $DC1C,$01 Read #REGbc.
  $DC1D,$01 Write #REGa where #REGhl points.
  $DC1E,$01 Step #REGl back.
@ $DC1F label=DrawMirroredRowsFromEdge_Second
  $DC1F,$01 #REGc=#REGd.
  $DC20,$01 Read #REGbc.
  $DC21,$01 Write #REGa where #REGhl points.
@ $DC22 label=DrawMirroredRowsFromEdge_PopWord
  $DC22,$01 Bring #REGde back off the stack.
  $DC23,$01 Step #REGh back.
  $DC24,$01 #REGa=#REGh.
  $DC25,$01 Advance #REGa.
  $DC26,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $DC28,$02 Jump to #R$DC34 if the zero flag is clear.
  $DC2A,$01 #REGa=#REGl.
  $DC2B,$02 Subtract #N$20 from #REGa.
  $DC2D,$01 #REGl=#REGa.
  $DC2E,$02 Jump to #R$DC34 if the carry flag is set.
  $DC30,$01 #REGa=#REGh.
  $DC31,$02 Add #N$08 to #REGa.
  $DC33,$01 #REGh=#REGa.
@ $DC34 label=DrawMirroredRowsFromEdge_Next
  $DC34,$01 Switch to the alternate registers.
  $DC35,$02 Decrease #REGb and jump to #R$DC0E until none remain.
  $DC37,$01 Switch to the alternate registers.
  $DC38,$03 Jump to #R$D711.
  $DC3B,$01 Step #REGh back.
  $DC3C,$03 Jump to #R$DC1F.
  $DC3F,$01 Step #REGh back.
  $DC40,$01 #REGc=#REGd.
  $DC41,$01 Read #REGbc.
  $DC42,$01 Write #REGa where #REGhl points.
  $DC43,$01 Bring #REGde back off the stack.
  $DC44,$03 Jump to #R$DC22.

c $DC47 Draw Mirrored Slope Rows
@ $DC47 label=DrawMirroredSlopeRows
D $DC47 Draws the rows of a piece of a slope back to front, two bytes wide,
. going up the screen two pixel rows at a time. Each byte of the picture is
. reversed using the table at #N$F900 (#REGb is set to #N($F9)). The jump at
. #R$DC59 is changed by #R$D3D2 to skip bytes when only part of the piece is to
. be drawn, and the last words of each group are entered at #R$DC81 and
. #R$DC66.
R $DC47 A Number of pairs of pixel rows to draw
R $DC47 HL Screen address
R $DC47 SP Address of the picture
  $DC47,$01 Switch to the alternate registers.
  $DC48,$01 #REGb=#REGa.
  $DC49,$01 Switch to the alternate registers.
  $DC4A,$03 The column step.
  $DC4D,$01 #REGa gains #REGl.
  $DC4E,$01 #REGl=#REGa.
  $DC4F,$02 #REGb=#N$F9.
  $DC51,$03 Jump to #R$DC55.
@ $DC54 label=DrawMirroredSlopeRows_Loop
  $DC54,$01 Switch to the alternate registers.
@ $DC55 label=DrawMirroredSlopeRows_PopWord
  $DC55,$01 Bring #REGde back off the stack.
  $DC56,$01 #REGc=#REGe.
  $DC57,$01 Read #REGbc.
  $DC58,$01 Write #REGa where #REGhl points.
@ $DC59 label=DrawMirroredSlopeRows_Patch
  $DC59,$02 Skip ahead by the displacement at #N$DC5A.
  $DC5B,$01 Advance #REGl.
  $DC5C,$01 #REGc=#REGd.
  $DC5D,$01 Read #REGbc.
  $DC5E,$01 Write #REGa where #REGhl points.
  $DC5F,$01 Step #REGh back.
  $DC60,$01 Bring #REGde back off the stack.
  $DC61,$01 Bring #REGde back off the stack.
  $DC62,$01 #REGc=#REGe.
  $DC63,$01 Read #REGbc.
  $DC64,$01 Write #REGa where #REGhl points.
  $DC65,$01 Step #REGl back.
@ $DC66 label=DrawMirroredSlopeRows_Second
  $DC66,$01 #REGc=#REGd.
  $DC67,$01 Read #REGbc.
  $DC68,$01 Write #REGa where #REGhl points.
  $DC69,$01 Step #REGh back.
  $DC6A,$01 #REGa=#REGh.
  $DC6B,$01 Advance #REGa.
  $DC6C,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $DC6E,$02 Jump to #R$DC7A if the zero flag is clear.
  $DC70,$01 #REGa=#REGl.
  $DC71,$02 Subtract #N$20 from #REGa.
  $DC73,$01 #REGl=#REGa.
  $DC74,$02 Jump to #R$DC7A if the carry flag is set.
  $DC76,$01 #REGa=#REGh.
  $DC77,$02 Add #N$08 to #REGa.
  $DC79,$01 #REGh=#REGa.
@ $DC7A label=DrawMirroredSlopeRows_Next
  $DC7A,$01 Switch to the alternate registers.
  $DC7B,$02 Decrease #REGb and jump to #R$DC54 until none remain.
  $DC7D,$01 Switch to the alternate registers.
  $DC7E,$03 Jump to #R$D711.
@ $DC81 label=DrawMirroredSlopeRows_Last
  $DC81,$01 Bring #REGde back off the stack.
  $DC82,$01 Bring #REGde back off the stack.
  $DC83,$01 Step #REGh back.
  $DC84,$03 Jump to #R$DC66.

g $DC87 Tile Script Pointer
@ $DC87 label=TileScriptPointer
D $DC87 The address in the list at #R$DC89 that #R$D0BD reads next.
W $DC87,$02,$02

g $DC89 Tile Script Addresses
@ $DC89 label=TileScriptAddresses
D $DC89 The addresses of the scripts that draw the four tiles that are on the
. screen, which #R$DF08 gets from the table at #R$6C3C.
W $DC89,$08,$02

g $DC91 Visible Tiles
@ $DC91 label=VisibleTiles
D $DC91 The numbers of the four tiles that are on the screen, which #R$DF08
. reads from the map at #R$61BC. They are the top tile and the bottom tile of
. the left column and then the same of the right column.
B $DC91,$04,$04

g $DC95 Sky Attribute
@ $DC95 label=SkyAttribute
D $DC95 The attribute for the background of the map rows above row #N($0C),
. which #R$DCA1 gets from the table at #R$DC97.
B $DC95,$01,$01

g $DC96 Underground Attribute
@ $DC96 label=UndergroundAttribute
D $DC96 The attribute for the background of the map rows from row #N($0C) down,
. which #R$DCA1 gets from the table at #R$DC97.
B $DC96,$01,$01

b $DC97 Planet Attributes
@ $DC97 label=PlanetAttributes
D $DC97 The attributes for the sky and for the underground of each of the five
. planets, in that order. The last byte is not used, so the second attribute of
. the fifth planet is taken from the code at #R$DCA1.
B $DC97,$09,$02

c $DCA1 Begin Life
@ $DCA1 label=BeginLife
D $DCA1 Sets up the screen at the start of each life. It shows the fuel gauge
. as empty but fills the tank, so the gauge fills up, and chooses the
. attributes for the planet. It restores the position of the ship from the
. state of the current player (which starts at #R$F5E7) and makes the tiles for
. that position. It builds the ship with #R$AFE9 and puts back any item that it
. was carrying. It then drops into the loop at #R$DD72 that scrolls the world
. until the ship is in place.
E $DCA1 Continue on to #R$DD72.
  $DCA1,$02 #REGa=#N$BE.
  $DCA3,$03 Update the fuel gauge row.
  $DCA6,$03 #REGhl=#N$4200.
  $DCA9,$03 Update the fuel level.
  $DCAC,$01 Clear #REGa.
  $DCAD,$03 Clear the background attribute.
  $DCB0,$03 Call #R$F419.
  $DCB3,$03 The planet number, from #N($00) to #N($04).
  $DCB6,$01 Double #REGa.
  $DCB7,$03 The planet attributes.
  $DCBA,$03 Call #R$9BCF.
  $DCBD,$01 Read #REGhl.
  $DCBE,$03 Update the sky attribute.
  $DCC1,$01 Advance #REGhl.
  $DCC2,$01 Read #REGhl.
  $DCC3,$03 Update the underground attribute.
  $DCC6,$03 The sky attribute.
  $DCC9,$01 #REGb=#REGa.
  $DCCA,$03 The map row of the position that the ship restarts at.
  $DCCD,$04 Jump to #R$DCE3 if #REGa is less than #N$0C.
  $DCD1,$03 The underground attribute.
  $DCD4,$01 #REGb=#REGa.
  $DCD5,$03 The tenth item site.
  $DCD8,$02 Reset bit 7 of the byte at the address in #REGhl.
  $DCDA,$03 The eleventh item site.
  $DCDD,$02 Reset bit 7 of the byte at the address in #REGhl.
  $DCDF,$01 Clear #REGa.
  $DCE0,$03 Update the flag set when item #N($09) has been picked up.
@ $DCE3 label=BeginLife_Attributes
  $DCE3,$01 #REGa=#REGb.
  $DCE4,$03 The background attribute.
  $DCE7,$03 The position of the ship: horizontal then vertical.
  $DCEA,$02,b$01 Keep the bits of #REGa that are set in #N$01.
  $DCEC,$02,b$01 Flip the bits of #REGa that are set in #N$01.
  $DCEE,$03 Update the chequered floor flag.
  $DCF1,$02 Jump to #R$DD0C if the zero flag is set.
  $DCF3,$03 #REGhl=#N$57C1.
  $DCF6,$02 #REGc=#N$50.
@ $DCF8 label=BeginLife_Row
  $DCF8,$02 #REGb=#N$1C.
  $DCFA,$01 Stash #REGhl on the stack.
@ $DCFB label=BeginLife_Cell
  $DCFB,$02 Store #N$55 at the address in #REGhl.
  $DCFD,$01 Step #REGh back.
  $DCFE,$02 Store #N$AA at the address in #REGhl.
  $DD00,$01 Advance #REGh.
  $DD01,$01 Advance #REGhl.
  $DD02,$02 Decrease #REGb and jump to #R$DCFB until none remain.
  $DD04,$01 Bring #REGhl back off the stack.
  $DD05,$01 Step #REGh back.
  $DD06,$03 Call #R$A1C3.
  $DD09,$01 Step #REGc back.
  $DD0A,$02 Jump to #R$DCF8 if the zero flag is clear.
@ $DD0C label=BeginLife_Position
  $DD0C,$03 Fetch the word at #R$F5FA into #REGhl.
  $DD0F,$01 Advance #REGh.
  $DD10,$03 Update the map position.
  $DD13,$03 Fetch the word at #R$F5FC into #REGhl.
  $DD16,$01 #REGa=#REGl.
  $DD17,$02,b$01 Keep the bits of #REGa that are set in #N$FE.
  $DD19,$01 #REGl=#REGa.
  $DD1A,$03 Update the position across.
  $DD1D,$03 Fetch the word at #R$F5FE into #REGhl.
  $DD20,$03 Update the horizontal offset.
  $DD23,$02 #REGa=#N$02.
  $DD25,$04 Jump to #R$DD2A if bit 1 of #REGh is set.
  $DD29,$01 Double #REGa.
@ $DD2A label=BeginLife_Speed
  $DD2A,$03 Update the vertical scroll speed.
  $DD2D,$02 #REGa=#N$FF.
  $DD2F,$03 Update the scroll-in flag.
  $DD32,$03 Fetch the word at #R$CE57 into #REGhl.
  $DD35,$03 Call #R$DF08.
  $DD38,$01 Clear #REGa.
  $DD39,$03 Update the horizontal scroll speed.
  $DD3C,$02 #REGa=#N$60.
  $DD3E,$03 The column the ship starts drawn at.
  $DD41,$03 #REGbc=#N$012C.
  $DD44,$03 The ship work area.
@ $DD47 label=BeginLife_Clear
  $DD47,$02 Store #N$00 at the address in #REGhl.
  $DD49,$01 Advance #REGhl.
  $DD4A,$01 Step #REGbc back.
  $DD4B,$01 #REGa=#REGb.
  $DD4C,$01 Set the bits of #REGa that are set in #REGc.
  $DD4D,$02 Jump to #R$DD47 if the zero flag is clear.
  $DD4F,$03 Call #R$AFE9.
  $DD52,$03 The carried item.
  $DD55,$01 Advance #REGa.
  $DD56,$02 Jump to #R$DD61 if the zero flag is set.
  $DD58,$01 Step #REGa back.
  $DD59,$02,b$01 Set the bits of #REGa that are set in #N$C0.
  $DD5B,$03 Update the item the ship is about to pick up.
  $DD5E,$03 Call #R$AA37.
@ $DD61 label=BeginLife_Continue
  $DD61,$01 Clear #REGa.
  $DD62,$03 Update the item the ship is about to pick up.
  $DD65,$03 Call #R$A8D9.
  $DD68,$03 The ship row.
  $DD6B,$02 Subtract #N$09 from #REGa.
  $DD6D,$03 The row of the carried item.
  $DD70,$02 #REGb=#N$28.

c $DD72 Scroll In World
@ $DD72 label=ScrollInWorld
D $DD72 One step of the loop that runs at the start of a life, in which the
. world scrolls past while the fuel gauge is updated. The step is done by
. #R$DDF8, which comes back to #R$DD79 while the flag at #R$5C3C is not zero.
. The flag is #N($FF) while the scroll is looking for the ground, and then
. #N($03) until the loop ends.
R $DD72 B Number of steps left
  $DD72,$01 Stash #REGbc on the stack.
  $DD73,$03 Call #R$CC77.
  $DD76,$03 Jump to #R$DDF8.

c $DD79 Look For Ground
@ $DD79 label=LookForGround
D $DD79 Used while the world is scrolling in at the start of a life. If the
. flag at #R$5C3C is #N($03) the scroll is finished (see #R$DDBF). If not, the
. vertical scroll speed is set to #N($04). If the flag at #R$DDF2 is zero the
. scroll lasts for the number of steps that are left in #REGb. Otherwise it
. looks at the six bytes of the screen where the ship is, and at the row above
. them, and goes on scrolling until they are all blank. Then the flag is set to
. #N($03), the playfield is coloured and the tiles are made again.
  $DD79,$03 The scroll-in flag.
  $DD7C,$05 Jump to #R$DDBF if #REGa is #N$03.
  $DD81,$02 #REGa=#N$04.
  $DD83,$03 Update the vertical scroll speed.
  $DD86,$03 The chequered floor flag.
  $DD89,$03 Jump to #R$DDA7 if #REGa is zero.
  $DD8C,$02 #REGb=#N$06.
  $DD8E,$03 Fetch the word at #N$C902 into #REGhl.
  $DD91,$03 Call #R$A149.
@ $DD94 label=LookForGround_Loop
  $DD94,$01 Read #REGhl.
  $DD95,$03 Jump to #R$DDA4 if #REGa is not zero.
  $DD98,$01 Step #REGh back.
  $DD99,$01 Read #REGhl.
  $DD9A,$03 Jump to #R$DDA4 if #REGa is not zero.
  $DD9D,$01 Advance #REGh.
  $DD9E,$01 Advance #REGl.
  $DD9F,$02 Decrease #REGb and jump to #R$DD94 until none remain.
  $DDA1,$01 Bring #REGbc back off the stack.
  $DDA2,$02 Jump to #R$DDAA.
@ $DDA4 label=LookForGround_Restore
  $DDA4,$01 Bring #REGbc back off the stack.
  $DDA5,$02 Jump to #R$DD72.
@ $DDA7 label=LookForGround_Count
  $DDA7,$01 Bring #REGbc back off the stack.
  $DDA8,$02 Decrease #REGb and jump to #R$DD72 until none remain.
@ $DDAA label=LookForGround_Found
  $DDAA,$03 Call #R$F419.
  $DDAD,$01 Clear #REGa.
  $DDAE,$03 Update the vertical scroll speed.
  $DDB1,$02 #REGa=#N$03.
  $DDB3,$03 Update the scroll-in flag.
  $DDB6,$03 Fetch the word at #R$CE57 into #REGhl.
  $DDB9,$03 Call #R$DF08.
  $DDBC,$03 Jump to #R$DD72.

c $DDBF Finish Scroll In
@ $DDBF label=FinishScrollIn
D $DDBF Ends the scroll at the start of a life. It clears the flag at #R$5C3C
. and makes the tiles for the current position again. It sets the map column
. and row, the position and the speeds of the ship from the position of the
. view, moves the ship with #R$BF66 and then goes to the sound routine at
. #N($71F0).
  $DDBF,$01 Bring #REGbc back off the stack.
  $DDC0,$01 Clear #REGa.
  $DDC1,$03 Update the scroll-in flag.
  $DDC4,$03 Fetch the word at #R$CE57 into #REGhl.
  $DDC7,$03 Call #R$DF08.
  $DDCA,$04 The ship.
  $DDCE,$03 Fetch the word at #R$CE57 into #REGhl.
  $DDD1,$03 Write #REGl to offset #N$01 of #REGix.
  $DDD4,$03 Write #REGh to offset #N$04 of #REGix.
  $DDD7,$03 Fetch the word at #R$CE45 into #REGhl.
  $DDDA,$03 Write #REGl to offset #N$02 of #REGix.
  $DDDD,$03 Write #REGh to offset #N$05 of #REGix.
  $DDE0,$04 Store #N$58 at offset #N$07 of #REGix.
  $DDE4,$03 Read offset #N$1E of #REGix.
  $DDE7,$02 Subtract #N$17 from #REGa.
  $DDE9,$03 Write #REGa to offset #N$09 of #REGix.
  $DDEC,$03 Call #R$BF66.
  $DDEF,$03 Jump to #R$71F0.

g $DDF2 Chequered Floor Flag
@ $DDF2 label=ChequeredFloorFlag
D $DDF2 Set by #R$DCA1 to one when the horizontal position of the ship is an
. even number, in which case the bottom of the playfield is filled with a
. chequered pattern.
B $DDF2,$01,$01

g $DDF3 Unused
@ $DDF3 label=Unused_DDF3
D $DDF3 Not referenced by the code.
B $DDF3,$02,$02

g $DDF5 Column Counts
@ $DDF5 label=ColumnCounts
D $DDF5 The number of map objects in the column that the left side of the
. screen is in and in the one to its right, set by #R$E08F.
B $DDF5,$01,$01
B $DDF6,$01,$01

g $DDF7 Next Column
@ $DDF7 label=NextColumn
D $DDF7 The number of the map column that is to the right of the one that the
. left side of the screen is in, set by #R$E235. It wraps round from #N($5F) to
. #N($00).
B $DDF7,$01,$01

c $DDF8 Scroll World
@ $DDF8 label=ScrollWorld
D $DDF8 Moves the view of the world by the scroll speeds, which are the
. vertical speed at #R$CCBA and the horizontal speed at #R$CCBB. The speeds are
. added to the offsets within the tile and when an edge of the tile is passed
. the map position at #R$CE57 moves to the next tile. If any tile has changed
. the four visible tiles are found again. Unless the map row is above row
. #N($03), where there is no terrain, the tile scripts are then run to draw the
. tiles and to make the boxes for the terrain. The map objects, beams and stars
. are updated, and the lines at the bottom of the frame that the drawing may
. have damaged are drawn again.
  $DDF8,$03 The vertical scroll speed.
  $DDFB,$04 Jump to #R$DE01 if bit 7 of #REGa is clear.
  $DDFF,$02 Negate #REGa.
@ $DE01 label=ScrollWorld_Speed
  $DE01,$03 Update the vertical distance.
  $DE04,$02 Clear #REGc.
  $DE06,$03 Fetch the word at #R$CE57 into #REGhl.
@ $DE09 label=ScrollWorld_Vertical
  $DE09,$03 The vertical offset.
  $DE0C,$01 #REGb=#REGa.
  $DE0D,$03 The vertical scroll speed.
  $DE10,$01 #REGa gains #REGb.
  $DE11,$03 Update the vertical offset.
  $DE14,$03 The vertical scroll speed.
  $DE17,$02 Negate #REGa.
  $DE19,$01 #REGb=#REGa.
  $DE1A,$03 The position down.
  $DE1D,$01 #REGa gains #REGb.
  $DE1E,$03 Update the position down.
  $DE21,$04 Jump to #R$DE37 if #REGa is #N$B8 or more.
  $DE25,$04 Jump to #R$DE46 if #REGa is #N$16 or more.
@ $DE29 label=ScrollWorld_Up
  $DE29,$02 #REGa=#N$B7.
  $DE2B,$03 Update the position down.
  $DE2E,$01 Clear #REGa.
  $DE2F,$03 Update the vertical offset.
  $DE32,$01 Step #REGh back.
  $DE33,$01 Advance #REGc.
  $DE34,$03 Jump to #R$DE09.
@ $DE37 label=ScrollWorld_Down
  $DE37,$02 #REGa=#N$17.
  $DE39,$03 Update the position down.
  $DE3C,$02 #REGa=#N$A0.
  $DE3E,$03 Update the vertical offset.
  $DE41,$01 Advance #REGh.
  $DE42,$01 Advance #REGc.
  $DE43,$03 Jump to #R$DE09.
@ $DE46 label=ScrollWorld_Horizontal
  $DE46,$03 The horizontal scroll speed.
  $DE49,$01 #REGb=#REGa.
  $DE4A,$03 The horizontal offset.
  $DE4D,$01 #REGa gains #REGb.
  $DE4E,$03 Update the horizontal offset.
  $DE51,$03 The horizontal scroll speed.
  $DE54,$02 Negate #REGa.
  $DE56,$01 #REGb=#REGa.
  $DE57,$03 The position across.
  $DE5A,$01 #REGa gains #REGb.
  $DE5B,$03 Update the position across.
  $DE5E,$04 Jump to #R$DE75 if #REGa is #N$E9 or more.
  $DE62,$04 Jump to #R$DE83 if #REGa is #N$07 or more.
@ $DE66 label=ScrollWorld_Left
  $DE66,$02 #REGa=#N$E8.
  $DE68,$03 Update the position across.
  $DE6B,$02 #REGa=#N$20.
  $DE6D,$03 Update the horizontal offset.
  $DE70,$01 Step #REGl back.
  $DE71,$01 Advance #REGc.
  $DE72,$03 Jump to #R$DE46.
@ $DE75 label=ScrollWorld_Right
  $DE75,$02 #REGa=#N$08.
  $DE77,$03 Update the position across.
  $DE7A,$01 Clear #REGa.
  $DE7B,$03 Update the horizontal offset.
  $DE7E,$01 Advance #REGl.
  $DE7F,$01 Advance #REGc.
  $DE80,$03 Jump to #R$DE46.
@ $DE83 label=ScrollWorld_Redraw
  $DE83,$01 #REGa=#REGc.
  $DE84,$03 Update the tiles changed.
  $DE87,$04 Call #R$DF08 if #REGa is not zero.
  $DE8B,$03 Call #R$DEE1.
  $DE8E,$03 The tile script addresses.
  $DE91,$04 Update the tile script pointer.
  $DE95,$03 The vertical scroll speed.
  $DE98,$05 Call #R$AC60 if bit 7 of #REGa is set.
  $DE9D,$03 The map row.
  $DEA0,$04 Jump to #R$DEB3 if #REGa is #N$03 or more.
  $DEA4,$01 Clear #REGa.
  $DEA5,$03 Update the decryption routine.
  $DEA8,$03 Clear the second tile record.
  $DEAB,$03 Clear the third tile record.
  $DEAE,$03 Clear the fourth tile record.
  $DEB1,$02 Jump to #R$DEB6.
@ $DEB3 label=ScrollWorld_Terrain
  $DEB3,$03 Call #R$D0BD.
@ $DEB6 label=ScrollWorld_Objects
  $DEB6,$03 The vertical scroll speed.
  $DEB9,$05 Call #R$AC60 if bit 7 of #REGa is clear.
  $DEBE,$03 Call #R$9BDA.
  $DEC1,$03 Call #R$BFE3.
  $DEC4,$02 #REGa=#N$FF.
  $DEC6,$03 A solid pixel byte in the playfield.
  $DEC9,$03 A solid pixel byte in the playfield.
  $DECC,$03 A solid pixel byte in the playfield.
  $DECF,$03 A solid pixel byte in the playfield.
  $DED2,$03 The scroll-in flag.
  $DED5,$04 Jump to #R$C3E3 if #REGa is zero.
  $DED9,$03 Jump to #R$DD79.
@ $DEDC label=ScrollWorld_Record
  $DEDC,$01 Do nothing.
  $DEDD,$01 Do nothing.
  $DEDE,$01 Do nothing.
  $DEDF,$01 Do nothing.
  $DEE0,$01 Do nothing.

c $DEE1 Set Row Attributes
@ $DEE1 label=SetRowAttributes
D $DEE1 Does nothing unless the tiles have just changed or the world is being
. scrolled in at the start of a life. Sets the attributes of the background for
. the two rows of the tile at #R$5C3A and #R$5C3B.
E $DEE1 Continue on to #R$DEF7.
  $DEE1,$03 The tiles changed.
  $DEE4,$01 #REGb=#REGa.
  $DEE5,$03 The scroll-in flag.
  $DEE8,$01 Set the bits of #REGa that are set in #REGb.
  $DEE9,$01 Return if the zero flag is set.
  $DEEA,$03 The map row.
  $DEED,$03 Call #R$DEF7.
  $DEF0,$03 Update the top-tile colour.
  $DEF3,$03 The map row.
  $DEF6,$01 Advance #REGa.

c $DEF7 Choose Row Attribute
@ $DEF7 label=ChooseRowAttribute
D $DEF7 Chooses the attribute for the background of a map row: the one at
. #R$DC95 for the rows above row #N($0C) and the one at #R$DC96 for the rows
. from row #N($0C) down.
R $DEF7 A Map row
R $DEF7 O:A Attribute
  $DEF7,$02 Compare #REGa with #N$0C.
  $DEF9,$03 The sky attribute.
  $DEFC,$01 #REGb=#REGa.
  $DEFD,$02 Jump to #R$DF03 if the carry flag is set.
  $DEFF,$03 The underground attribute.
  $DF02,$01 #REGb=#REGa.
@ $DF03 label=ChooseRowAttribute_Store
  $DF03,$01 #REGa=#REGb.
  $DF04,$03 Update the bottom-tile colour.
  $DF07,$01 Return.

c $DF08 Make Tiles
@ $DF08 label=MakeTiles
D $DF08 Finds the four tiles that are on the screen for a position on the map.
. The tile numbers are read from the map for two columns and two rows, and are
. stored in the table at #R$DC91. Tiles that are above the first row, or below
. the last row (rows #N($1C) and #N($1D)), are blank. While the world scrolls
. in at the start of a life tile #N($3E) is replaced by #N($AA). The address of
. the script of each tile is looked up in the table at #R$6C3C and stored in
. the list at #R$DC89. Unless the world is being scrolled in, the pick-ups and
. the map objects for the position are then put in their slots, and the slots
. of any that are no longer on the screen are freed.
R $DF08 HL Map position (#REGl is the column and #REGh is the row)
  $DF08,$03 #REGde=#N$60.
  $DF0B,$01 #REGa=#REGl.
  $DF0C,$04 Jump to #R$DF12 if #REGa is not #N$FF.
  $DF10,$02 #REGl=#N$5F.
@ $DF12 label=MakeTiles_Wrapped
  $DF12,$04 Jump to #R$DF18 if #REGa is not #N$60.
  $DF16,$02 Clear #REGl.
@ $DF18 label=MakeTiles_Start
  $DF18,$03 Update the map position.
  $DF1B,$03 Set #REGbc to #R$DC89.
  $DF1E,$04 Update the tile script pointer.
  $DF22,$01 Stash #REGhl on the stack.
  $DF23,$03 Call #R$E235.
  $DF26,$03 Update the visible tiles.
  $DF29,$01 #REGhl gains #REGde.
  $DF2A,$01 Read #REGhl.
  $DF2B,$03 The bottom tile of the left column.
  $DF2E,$01 Bring #REGhl back off the stack.
  $DF2F,$01 Advance #REGl.
  $DF30,$03 Call #R$E235.
  $DF33,$03 The top tile of the right column.
  $DF36,$01 #REGhl gains #REGde.
  $DF37,$01 Read #REGhl.
  $DF38,$03 The bottom tile of the right column.
  $DF3B,$03 The map row.
  $DF3E,$04 Jump to #R$DF4A if #REGa is not #N$1C.
  $DF42,$02 #REGa=#N$20.
  $DF44,$03 The bottom tile of the left column is empty.
  $DF47,$03 The bottom tile of the right column is empty.
@ $DF4A label=MakeTiles_Rows
  $DF4A,$04 Jump to #R$DF59 if #REGa is not #N$1D.
  $DF4E,$03 #REGbc=#N$2020.
  $DF51,$04 Update the visible tiles.
  $DF55,$04 The right column is empty.
@ $DF59 label=MakeTiles_Scripts
  $DF59,$03 The scroll-in flag.
  $DF5C,$04 Jump to #R$DF6F if bit 7 of #REGa is clear.
  $DF60,$02 #REGb=#N$04.
  $DF62,$03 The visible tiles.
@ $DF65 label=MakeTiles_Search
  $DF65,$01 Read #REGhl.
  $DF66,$04 Jump to #R$DF6C if #REGa is not #N$3E.
  $DF6A,$02 Store #N$AA at the address in #REGhl.
@ $DF6C label=MakeTiles_Next
  $DF6C,$01 Advance #REGhl.
  $DF6D,$02 Decrease #REGb and jump to #R$DF65 until none remain.
@ $DF6F label=MakeTiles_Lookup
  $DF6F,$03 Set #REGbc to #R$DC91.
  $DF72,$02 #REGa=#N$04.
@ $DF74 label=MakeTiles_Tile
  $DF74,$01 Switch to the alternate accumulator and flags.
  $DF75,$01 Read #REGbc.
  $DF76,$01 #REGl=#REGa.
  $DF77,$02 Clear #REGh.
  $DF79,$03 The tile script pointers.
  $DF7C,$01 Double #REGhl.
  $DF7D,$01 #REGhl gains #REGde.
  $DF7E,$01 Read #REGhl into #REGe.
  $DF7F,$01 Advance #REGhl.
  $DF80,$01 Read #REGhl into #REGd.
  $DF81,$03 Fetch the word at #R$DC87 into #REGhl.
  $DF84,$01 Write #REGe where #REGhl points.
  $DF85,$01 Advance #REGhl.
  $DF86,$01 Write #REGd where #REGhl points.
  $DF87,$01 Advance #REGhl.
  $DF88,$03 Update the tile script pointer.
  $DF8B,$01 Advance #REGbc.
  $DF8C,$01 Switch to the alternate accumulator and flags.
  $DF8D,$01 Step #REGa back.
  $DF8E,$02 Jump to #R$DF74 if the zero flag is clear.
  $DF90,$03 The scroll-in flag.
  $DF93,$02 Return if #REGa is not zero.
@ $DF95 label=MakeTiles_PickUps
  $DF95,$02 #REGa=#N$0C.
  $DF97,$03 The object type is #N($0C).
  $DF9A,$04 The fifth map-object slot.
  $DF9E,$02 #REGb=#N$02.
  $DFA0,$03 Call #R$E062.
  $DFA3,$04 The item sites.
  $DFA7,$03 Fetch the word at #R$CE57 into #REGhl.
  $DFAA,$03 The next column.
  $DFAD,$01 #REGd=#REGa.
  $DFAE,$03 #REGbc=#N$1300.
@ $DFB1 label=MakeTiles_NextSite
  $DFB1,$01 #REGa=#REGc.
  $DFB2,$02 Subtract #N$0B from #REGa.
  $DFB4,$02 Jump to #R$DFBC if the zero flag is clear.
  $DFB6,$01 #REGc=#REGa.
  $DFB7,$02 #REGa=#N$1E.
  $DFB9,$03 The object type is #N($1E).
@ $DFBC label=MakeTiles_Object
  $DFBC,$06 Jump to #R$E01D if bit 7 of offset #N$00 of #REGix is set.
  $DFC2,$03 Read offset #N$00 of #REGix.
  $DFC5,$03 Jump to #R$DFCB if #REGa is #REGl.
  $DFC8,$03 Jump to #R$E01D if #REGa is not #REGd.
@ $DFCB label=MakeTiles_Compare
  $DFCB,$01 #REGa=#REGh.
  $DFCC,$01 Advance #REGa.
  $DFCD,$05 Jump to #R$DFD8 if #REGa is the byte at offset #N$01 of #REGix.
  $DFD2,$01 #REGa=#REGh.
  $DFD3,$05 Jump to #R$E01D if #REGa is not the byte at offset #N$01 of
. #REGix.
@ $DFD8 label=MakeTiles_Slot
  $DFD8,$04 The fifth map-object slot.
  $DFDC,$03 Call #R$E03D.
  $DFDF,$02 Jump to #R$E01D if the zero flag is set.
  $DFE1,$04 The sixth map-object slot.
  $DFE5,$03 Call #R$E03D.
  $DFE8,$02 Jump to #R$E01D if the zero flag is set.
  $DFEA,$04 The fifth map-object slot.
  $DFEE,$03 Read offset #N$00 of #REGiy.
  $DFF1,$01 Advance #REGa.
  $DFF2,$02 Jump to #R$DFF8 if the zero flag is set.
  $DFF4,$04 The sixth map-object slot.
@ $DFF8 label=MakeTiles_FillSlot
  $DFF8,$03 Read offset #N$00 of #REGix.
  $DFFB,$03 Write #REGa to offset #N$01 of #REGiy.
  $DFFE,$03 Read offset #N$01 of #REGix.
  $E001,$03 Write #REGa to offset #N$04 of #REGiy.
  $E004,$03 Read offset #N$02 of #REGix.
  $E007,$03 Write #REGa to offset #N$02 of #REGiy.
  $E00A,$03 Read offset #N$03 of #REGix.
  $E00D,$03 Write #REGa to offset #N$05 of #REGiy.
  $E010,$03 Write #REGc to offset #N$13 of #REGiy.
  $E013,$04 Store #N$FF at offset #N$0D of #REGiy.
  $E017,$03 The object type.
  $E01A,$03 Write #REGa to offset #N$00 of #REGiy.
@ $E01D label=MakeTiles_Skip
  $E01D,$02 Advance #REGix.
  $E01F,$02 Advance #REGix.
  $E021,$02 Advance #REGix.
  $E023,$02 Advance #REGix.
  $E025,$01 Advance #REGc.
  $E026,$02 Decrease #REGb and jump to #R$DFB1 until none remain.
@ $E028 label=MakeTiles_Finish
  $E028,$04 The fifth map-object slot.
  $E02C,$02 #REGb=#N$02.
  $E02E,$03 Call #R$E0EA.
  $E031,$04 The map object slots.
  $E035,$02 #REGb=#N$04.
  $E037,$03 Call #R$E062.
  $E03A,$03 Jump to #R$E08F.

c $E03D Compare Slot With Site
@ $E03D label=CompareSlotWithSite
D $E03D Compares a slot for a pick-up with a site, using the column, the row
. and the position. The result is that the zero flag is set if the slot holds
. the pick-up for the site, and is clear if not or if the slot is free.
R $E03D IX Address of the site
R $E03D IY Address of the slot
R $E03D O:F Zero flag set if the slot has the pick-up
  $E03D,$03 Read offset #N$00 of #REGiy.
  $E040,$01 Advance #REGa.
  $E041,$02 Jump to #R$E05F if the zero flag is set.
  $E043,$03 Read offset #N$00 of #REGix.
  $E046,$04 Return if #REGa is not the byte at offset #N$01 of #REGiy.
  $E04A,$03 Read offset #N$01 of #REGix.
  $E04D,$04 Return if #REGa is not the byte at offset #N$04 of #REGiy.
  $E051,$03 Read offset #N$02 of #REGix.
  $E054,$04 Return if #REGa is not the byte at offset #N$02 of #REGiy.
  $E058,$03 Read offset #N$03 of #REGix.
  $E05B,$03 Compare #REGa with the byte at offset #N$05 of #REGiy.
  $E05E,$01 Return.
@ $E05F label=CompareSlotWithSite_Free
  $E05F,$02,b$01 Set the bits of #REGa that are set in #N$01.
  $E061,$01 Return.

c $E062 Free Distant Slots
@ $E062 label=FreeDistantSlots
D $E062 Frees any slots of objects that are not on one of the two columns and
. two rows that are on the screen.
R $E062 B Number of slots
R $E062 IX Address of the first slot
  $E062,$03 The next column.
  $E065,$01 #REGc=#REGa.
  $E066,$03 #REGde=#N$1A.
  $E069,$03 Fetch the word at #R$CE57 into #REGhl.
  $E06C,$01 Advance #REGh.
@ $E06D label=FreeDistantSlots_Loop
  $E06D,$03 Read offset #N$00 of #REGix.
  $E070,$01 Advance #REGa.
  $E071,$02 Jump to #R$E08A if the zero flag is set.
  $E073,$03 Read offset #N$01 of #REGix.
  $E076,$03 Jump to #R$E07C if #REGa is #REGl.
  $E079,$03 Jump to #R$E086 if #REGa is not #REGc.
@ $E07C label=FreeDistantSlots_Row
  $E07C,$03 Read offset #N$04 of #REGix.
  $E07F,$03 Jump to #R$E08A if #REGa is #REGh.
  $E082,$01 Advance #REGa.
  $E083,$03 Jump to #R$E08A if #REGa is #REGh.
@ $E086 label=FreeDistantSlots_Free
  $E086,$04 Store #N$FF at offset #N$00 of #REGix.
@ $E08A label=FreeDistantSlots_Next
  $E08A,$02 #REGix gains #REGde.
  $E08C,$02 Decrease #REGb and jump to #R$E06D until none remain.
  $E08E,$01 Return.

c $E08F Load Map Objects
@ $E08F label=LoadMapObjects
D $E08F Puts the objects of the map for the two columns that are on the screen
. into the slots for the map objects. The objects of a column are found by
. adding up the numbers of the objects in the columns before it, from the table
. at #R$5DB6, to get the place in the tables at #R$5C94 and #R$5E17. If the
. second column wraps round to column zero its objects are the first in the
. tables. The slots of any objects that are free have their flags cleared.
E $E08F Continue on to #R$E0EA.
  $E08F,$03 The map position.
  $E092,$01 #REGb=#REGa.
  $E093,$03 #REGhl=#N$00.
  $E096,$03 The column table.
  $E099,$03 Jump to #R$E0A3 if #REGa is zero.
@ $E09C label=LoadMapObjects_Count
  $E09C,$01 Read #REGde.
  $E09D,$03 Call #R$9BCF.
  $E0A0,$01 Advance #REGde.
  $E0A1,$02 Decrease #REGb and jump to #R$E09C until none remain.
@ $E0A3 label=LoadMapObjects_Column
  $E0A3,$03 The column of the map objects.
  $E0A6,$01 Double #REGhl.
  $E0A7,$01 Swap #REGde and #REGhl.
  $E0A8,$01 Read #REGhl.
  $E0A9,$03 Update the column counts.
  $E0AC,$01 Advance #REGhl.
  $E0AD,$01 Read #REGhl.
  $E0AE,$03 The object count of the next column.
  $E0B1,$04 The terrain data.
  $E0B5,$02 #REGix gains #REGde.
  $E0B7,$03 The map table.
  $E0BA,$03 Fetch the word at #R$CE3A into #REGhl.
  $E0BD,$01 #REGhl gains #REGde.
  $E0BE,$03 The map position.
  $E0C1,$01 #REGc=#REGa.
  $E0C2,$03 The column counts.
  $E0C5,$01 #REGb=#REGa.
  $E0C6,$03 Call #R$E114.
  $E0C9,$03 The next column.
  $E0CC,$03 Jump to #R$E0DC if #REGa is not zero.
  $E0CF,$03 #REGhl=#N$00.
  $E0D2,$03 The column of the map objects.
  $E0D5,$03 The map table.
  $E0D8,$04 The terrain data.
@ $E0DC label=LoadMapObjects_Second
  $E0DC,$01 #REGc=#REGa.
  $E0DD,$03 The object count of the next column.
  $E0E0,$01 #REGb=#REGa.
  $E0E1,$03 Call #R$E114.
  $E0E4,$02 #REGb=#N$04.
  $E0E6,$04 The map object slots.

c $E0EA Clear Free Slot Flags
@ $E0EA label=ClearFreeSlotFlags
D $E0EA Clears the flags at offset #N($10) of every slot of the map objects
. that is free.
R $E0EA B Number of slots
R $E0EA IX Address of the first slot
  $E0EA,$03 #REGde=#N$1A.
@ $E0ED label=ClearFreeSlotFlags_Loop
  $E0ED,$03 Read offset #N$00 of #REGix.
  $E0F0,$04 Jump to #R$E0F8 if #REGa is not #N$FF.
  $E0F4,$04 Store #N$00 at offset #N$10 of #REGix.
@ $E0F8 label=ClearFreeSlotFlags_Next
  $E0F8,$02 #REGix gains #REGde.
  $E0FA,$02 Decrease #REGb and jump to #R$E0ED until none remain.
  $E0FC,$01 Return.

b $E0FD Object Kinds
@ $E0FD label=ObjectKinds
D $E0FD One byte for each kind of object on the map. The top three bits are
. shifted down into bits 1 to 3 of offset #N($18) of the slot, where #R$AC60
. passes them to #R$8820 when they are not zero. If bit 4 is set the object is
. one of the special ones, and the bottom four bits are the offset in #R$E10E
. of its state.
B $E0FD,$11,$01

b $E10E Special Object States
@ $E10E label=SpecialObjectStates
D $E10E The states for the special kinds of object, which are put in offsets
. #N($13) and #N($14) of the slot.
B $E10E,$06,$02

c $E114 Add Map Objects
@ $E114 label=AddMapObjects
D $E114 Puts the objects of one column of the map in free slots of the map
. objects. An object is skipped if the current player has destroyed it (bit 7
. of its byte in the table at #R$5C94 is set, or bit 6 for player two), if it
. is not on one of the two rows that are on the screen or if there is already a
. slot for it. It is put in the first free slot of the first three slots, or in
. the fourth if none of them is free. Its column, row, position and kind are
. set from the tables. The slot holds the index of the object in offsets
. #N($18) and #N($19) so that the object can be marked as destroyed later.
R $E114 B Number of objects in the column
R $E114 C Column
R $E114 HL Address of the first object in #R$5C94
R $E114 IX Address of the first object in #R$5E17
  $E114,$02 Return if #REGa is zero.
@ $E116 label=AddMapObjects_Next2
  $E116,$01 Stash #REGbc on the stack.
  $E117,$05 Jump to #R$E1F1 if bit 7 of the byte at the address in #REGhl is
. set.
  $E11C,$03 Read offset #N$01 of #REGix.
  $E11F,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $E121,$01 #REGe=#REGa.
  $E122,$03 The map row.
  $E125,$03 Jump to #R$E12D if #REGa is #REGe.
  $E128,$01 Advance #REGa.
  $E129,$04 Jump to #R$E1F1 if #REGa is not #REGe.
@ $E12D label=AddMapObjects_Search
  $E12D,$04 The map object slots.
  $E131,$02 #REGb=#N$04.
@ $E133 label=AddMapObjects_Search2
  $E133,$03 Read offset #N$00 of #REGiy.
  $E136,$01 Advance #REGa.
  $E137,$02 Jump to #R$E146 if the zero flag is set.
  $E139,$03 Read offset #N$01 of #REGiy.
  $E13C,$03 Jump to #R$E146 if #REGa is not #REGc.
  $E13F,$03 Read offset #N$04 of #REGiy.
  $E142,$04 Jump to #R$E1F1 if #REGa is #REGe.
@ $E146 label=AddMapObjects_Next
  $E146,$01 #REGa=#REGe.
  $E147,$03 #REGde=#N$1A.
  $E14A,$02 #REGiy gains #REGde.
  $E14C,$01 #REGe=#REGa.
  $E14D,$02 Decrease #REGb and jump to #R$E133 until none remain.
@ $E14F label=AddMapObjects_Free
  $E14F,$04 The map object slots.
  $E153,$02 #REGb=#N$03.
@ $E155 label=AddMapObjects_SearchSecond
  $E155,$03 Read offset #N$00 of #REGiy.
  $E158,$01 Advance #REGa.
  $E159,$02 Jump to #R$E164 if the zero flag is set.
  $E15B,$01 #REGa=#REGe.
  $E15C,$03 #REGde=#N$1A.
  $E15F,$02 #REGiy gains #REGde.
  $E161,$01 #REGe=#REGa.
  $E162,$02 Decrease #REGb and jump to #R$E155 until none remain.
@ $E164 label=AddMapObjects_Fill
  $E164,$02 Stash #REGix on the stack.
  $E166,$02 Stash #REGiy on the stack.
  $E168,$02 Bring #REGix back off the stack.
  $E16A,$02 Bring #REGiy back off the stack.
  $E16C,$03 Call #R$AC34.
  $E16F,$02 Stash #REGix on the stack.
  $E171,$02 Stash #REGiy on the stack.
  $E173,$02 Bring #REGix back off the stack.
  $E175,$02 Bring #REGiy back off the stack.
  $E177,$03 Write #REGe to offset #N$04 of #REGiy.
  $E17A,$04 Store #N$0D at offset #N$00 of #REGiy.
  $E17E,$01 Read #REGhl.
  $E17F,$02,b$01 Keep the bits of #REGa that are set in #N$3F.
  $E181,$03 Write #REGa to offset #N$13 of #REGiy.
  $E184,$01 Stash #REGhl on the stack.
  $E185,$03 The object attributes.
  $E188,$03 Call #R$9BCF.
  $E18B,$01 Read #REGhl.
  $E18C,$03 Write #REGa to offset #N$0D of #REGiy.
  $E18F,$03 The object kinds.
  $E192,$03 Read offset #N$13 of #REGiy.
  $E195,$03 Call #R$9BCF.
  $E198,$01 Read #REGhl.
  $E199,$02,b$01 Keep the bits of #REGa that are set in #N$E0.
  $E19B,$02 Shift #REGa right.
  $E19D,$02 Shift #REGa right.
  $E19F,$02 Shift #REGa right.
  $E1A1,$02 Shift #REGa right.
  $E1A3,$03 Write #REGa to offset #N$18 of #REGiy.
  $E1A6,$04 Jump to #R$E1C4 if bit 4 of the byte at the address in #REGhl is
. clear.
  $E1AA,$01 Read #REGhl.
  $E1AB,$02,b$01 Keep the bits of #REGa that are set in #N$0F.
  $E1AD,$03 The special object states.
  $E1B0,$03 Call #R$9BCF.
  $E1B3,$01 Read #REGhl.
  $E1B4,$03 Write #REGa to offset #N$13 of #REGiy.
  $E1B7,$01 Advance #REGhl.
  $E1B8,$01 Read #REGhl.
  $E1B9,$03 Write #REGa to offset #N$14 of #REGiy.
  $E1BC,$04 Store #N$80 at offset #N$15 of #REGiy.
  $E1C0,$04 Store #N$1B at offset #N$00 of #REGiy.
@ $E1C4 label=AddMapObjects_Position
  $E1C4,$01 Bring #REGhl back off the stack.
  $E1C5,$04 Fetch the word at #R$CE3A into #REGde.
  $E1C9,$01 #REGa=#REGd.
  $E1CA,$03 Set the bits of #REGa that are set in the byte at offset #N$18 of
. #REGiy.
  $E1CD,$03 Write #REGa to offset #N$18 of #REGiy.
  $E1D0,$03 Write #REGe to offset #N$19 of #REGiy.
  $E1D3,$03 Write #REGc to offset #N$01 of #REGiy.
  $E1D6,$03 Read offset #N$00 of #REGix.
  $E1D9,$02,b$01 Keep the bits of #REGa that are set in #N$FC.
  $E1DB,$01 Step #REGa back.
  $E1DC,$03 Write #REGa to offset #N$05 of #REGiy.
  $E1DF,$03 Read offset #N$00 of #REGix.
  $E1E2,$02,b$01 Keep the bits of #REGa that are set in #N$03.
  $E1E4,$01 Double #REGa.
  $E1E5,$01 Double #REGa.
  $E1E6,$01 Double #REGa.
  $E1E7,$01 #REGe=#REGa.
  $E1E8,$03 Read offset #N$01 of #REGix.
  $E1EB,$02,b$01 Keep the bits of #REGa that are set in #N$E0.
  $E1ED,$01 Set the bits of #REGa that are set in #REGe.
  $E1EE,$03 Write #REGa to offset #N$02 of #REGiy.
@ $E1F1 label=AddMapObjects_Skip
  $E1F1,$02 Advance #REGix.
  $E1F3,$02 Advance #REGix.
  $E1F5,$01 Advance #REGhl.
  $E1F6,$04 Fetch the word at #R$CE3A into #REGde.
  $E1FA,$01 Advance #REGde.
  $E1FB,$04 The next object in the column.
  $E1FF,$01 Bring #REGbc back off the stack.
  $E200,$01 Step #REGb back.
  $E201,$03 Jump to #R$E116 if the zero flag is clear.
  $E204,$01 Return.

b $E205 Object Attributes
@ $E205 label=ObjectAttributes
D $E205 The attribute of each kind of object on the map, which is put in offset
. #N($0D) of the slot.
B $E205,$01 #COLOUR(#PEEK(#PC)).
L $E205,$01,$11

c $E216 Find Map Address
@ $E216 label=FindMapAddress
D $E216 Finds the address in the map at #R$61BC of the tile at a column and a
. row. Each row of the map is #N($60) bytes, and rows zero and one both give
. the address of the first row, because the row that is given is that of the
. tile at the bottom of the two on the screen. The column wraps round from
. #N($FF) to #N($5F) and from #N($60) to #N($00).
R $E216 DE #N($0060)
R $E216 H Row
R $E216 L Column
R $E216 O:C Column, wrapped
R $E216 O:HL Address in the map
  $E216,$01 #REGc=#REGl.
  $E217,$01 #REGa=#REGh.
  $E218,$01 Is #REGa zero?
  $E219,$01 #REGb=#REGh.
  $E21A,$03 The tile map.
  $E21D,$02 Jump to #R$E225 if the zero flag is set.
  $E21F,$01 Step #REGb back.
  $E220,$02 Jump to #R$E225 if the zero flag is set.
@ $E222 label=FindMapAddress_Loop
  $E222,$01 #REGhl gains #REGde.
  $E223,$02 Decrease #REGb and jump to #R$E222 until none remain.
@ $E225 label=FindMapAddress_Wrap
  $E225,$01 #REGa=#REGc.
  $E226,$04 Jump to #R$E22C if #REGa is not #N$FF.
  $E22A,$02 #REGc=#N$5F.
@ $E22C label=FindMapAddress_Wrapped
  $E22C,$01 #REGa=#REGc.
  $E22D,$04 Jump to #R$E233 if #REGa is not #N$60.
  $E231,$02 Clear #REGc.
@ $E233 label=FindMapAddress_Return
  $E233,$01 #REGhl gains #REGbc.
  $E234,$01 Return.

c $E235 Get Tile
@ $E235 label=GetTile
D $E235 Gets the number of the tile at a column and a row of the map. It also
. stores the column, after it has wrapped, at #R$DDF7. If the row is zero there
. is no tile above the first row of the map, so the tile is blank and the
. address is moved up a row, ready for the next tile.
R $E235 DE #N($0060)
R $E235 H Row
R $E235 L Column
R $E235 O:A Tile number
R $E235 O:HL Address in the map
  $E235,$03 Call #R$E216.
  $E238,$01 #REGa=#REGc.
  $E239,$03 Update the next column.
  $E23C,$03 The map row.
  $E23F,$03 Jump to #R$E244 if #REGa is zero.
  $E242,$01 Read #REGhl.
  $E243,$01 Return.

c $E244 Get Blank Tile
@ $E244 label=GetBlankTile
D $E244 Used by #R$E235 when the row is zero. Moves the address back up a row
. and returns a blank tile.
R $E244 DE #N($0060)
R $E244 HL Address in the map
R $E244 O:A Tile number (zero)
R $E244 O:HL Address in the map, one row up
  $E244,$01 Is #REGa zero?
  $E245,$02 Subtract #REGde and the carry from #REGhl.
  $E247,$01 Clear #REGa.
  $E248,$01 Return.

c $E249 Draw Flat Rows
@ $E249 label=DrawFlatRows
D $E249 Draws a flat piece of terrain, three bytes wide, going up the screen
. two pixel rows at a time. The words of the picture are popped from the stack
. (which #R$D0BD has pointed at the picture) and stored in a zigzag, so that a
. word is two screen bytes next to each other. The entry point at #R$E249 moves
. one column to the right and carries on at #R$E29E. The three JR instructions
. at #R$E259, #R$E25D and #R$E261 have their displacements set by #R$D0BD to
. choose how much of the three bytes is drawn. When one is changed to #N($33)
. or to #N($EE) the row is drawn from #R$E28E or #R$E249, and when #R$E25D or
. #R$E261 is changed to #N($24) or #N($26) the word is skipped (#R$E283 and
. #R$E289).
R $E249 A Number of pairs of pixel rows to draw
R $E249 HL Screen address of the bottom left of the piece
R $E249 SP Address of the picture
  $E249,$01 Advance #REGl.
  $E24A,$03 Jump to #R$E29E.
@ $E24D label=DrawFlatRows_Normal
  $E24D,$01 #REGb=#REGa.
  $E24E,$03 The segment screen address.
  $E251,$02 Add #N$03 to #REGa.
  $E253,$03 Update the segment screen address.
  $E256,$01 Advance #REGl.
  $E257,$01 Advance #REGl.
  $E258,$01 Advance #REGl.
@ $E259 label=DrawFlatRows_Next
  $E259,$02 Skip ahead by the displacement that #R$D0BD sets.
@ $E25B label=DrawFlatRows_Word1
  $E25B,$01 Bring #REGde back off the stack.
  $E25C,$01 Write #REGe where #REGhl points.
@ $E25D label=DrawFlatRows_PatchSecond
  $E25D,$02 Skip ahead by the displacement that #R$D0BD sets.
@ $E25F label=DrawFlatRows_Word2
  $E25F,$01 Advance #REGl.
  $E260,$01 Write #REGd where #REGhl points.
@ $E261 label=DrawFlatRows_PatchThird
  $E261,$02 Skip ahead by the displacement that #R$D0BD sets.
@ $E263 label=DrawFlatRows_Word3
  $E263,$01 Advance #REGl.
  $E264,$01 Bring #REGde back off the stack.
  $E265,$01 Write #REGe where #REGhl points.
  $E266,$01 Step #REGh back.
  $E267,$01 Write #REGd where #REGhl points.
  $E268,$01 Step #REGl back.
@ $E269 label=DrawFlatRows_Word4
  $E269,$01 Bring #REGde back off the stack.
  $E26A,$01 Write #REGe where #REGhl points.
  $E26B,$01 Step #REGl back.
@ $E26C label=DrawFlatRows_Store
  $E26C,$01 Write #REGd where #REGhl points.
@ $E26D label=DrawFlatRows_Up
  $E26D,$01 Step #REGh back.
  $E26E,$01 #REGa=#REGh.
  $E26F,$01 Advance #REGa.
  $E270,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $E272,$02 Jump to #R$E27E if the zero flag is clear.
  $E274,$01 #REGa=#REGl.
  $E275,$02 Subtract #N$20 from #REGa.
  $E277,$01 #REGl=#REGa.
  $E278,$02 Jump to #R$E27E if the carry flag is set.
  $E27A,$01 #REGa=#REGh.
  $E27B,$02 Add #N$08 to #REGa.
  $E27D,$01 #REGh=#REGa.
@ $E27E label=DrawFlatRows_Loop
  $E27E,$02 Decrease #REGb and jump to #R$E259 until none remain.
  $E280,$03 Jump to #R$D714.
@ $E283 label=DrawFlatRows_SkipWord
  $E283,$01 Step #REGh back.
  $E284,$01 Bring #REGde back off the stack.
  $E285,$01 Bring #REGde back off the stack.
  $E286,$03 Jump to #R$E26C.
@ $E289 label=DrawFlatRows_SkipOne
  $E289,$01 Step #REGh back.
  $E28A,$01 Bring #REGde back off the stack.
  $E28B,$03 Jump to #R$E269.
@ $E28E label=DrawFlatRows_NextColumn
  $E28E,$01 Advance #REGa.
  $E28F,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $E291,$02 Jump to #R$E299 if the zero flag is clear.
  $E293,$01 #REGa=#REGl.
  $E294,$02 Subtract #N$20 from #REGa.
  $E296,$03 Update the segment screen address.
@ $E299 label=DrawFlatRows_Column
  $E299,$01 #REGa=#REGl.
  $E29A,$02,b$01 Keep the bits of #REGa that are set in #N$E0.
  $E29C,$01 Advance #REGa.
  $E29D,$01 #REGl=#REGa.
@ $E29E label=DrawFlatRows_Start
  $E29E,$02 #REGa=#N$4C.
  $E2A0,$03 Skip the rest of the flat row.
  $E2A3,$01 Advance #REGsp.
@ $E2A4 label=DrawFlatRows_PatchFourth
  $E2A4,$02 Skip ahead by the displacement that #R$D0BD sets.
@ $E2A6 label=DrawFlatRows_Pop
  $E2A6,$01 Advance #REGsp.
  $E2A7,$01 Bring #REGde back off the stack.
  $E2A8,$01 Write #REGe where #REGhl points.
@ $E2A9 label=DrawFlatRows_PatchFifth
  $E2A9,$02 Skip ahead by the displacement that #R$D0BD sets.
@ $E2AB label=DrawFlatRows_Right
  $E2AB,$01 Advance #REGl.
  $E2AC,$01 Write #REGd where #REGhl points.
  $E2AD,$01 Bring #REGde back off the stack.
  $E2AE,$01 Step #REGh back.
  $E2AF,$01 Write #REGe where #REGhl points.
  $E2B0,$01 Step #REGl back.
  $E2B1,$01 Write #REGd where #REGhl points.
  $E2B2,$01 Bring #REGde back off the stack.
  $E2B3,$03 Jump to #R$E26D.
@ $E2B6 label=DrawFlatRows_Left
  $E2B6,$01 Step #REGh back.
  $E2B7,$01 Write #REGd where #REGhl points.
  $E2B8,$01 Bring #REGde back off the stack.
  $E2B9,$01 Bring #REGde back off the stack.
  $E2BA,$03 Jump to #R$E26D.

b $E2BD Shape Table Shift Two
@ $E2BD label=ShapeTableShiftTwo
D $E2BD The sixteen entries, one for each type of segment, that #R$D0BD uses
. when the terrain is scrolled two pixels to the right. Each entry is two
. words: the routine that draws the type of segment, and the address of the
. shifted picture of the type.
W $E2BD,$40,$04

b $E2FD Shape Table Shift Four
@ $E2FD label=ShapeTableShiftFour
D $E2FD The entries that are used when the terrain is scrolled four pixels to
. the right.
W $E2FD,$40,$04

b $E33D Shape Table Shift Six
@ $E33D label=ShapeTableShiftSix
D $E33D The entries that are used when the terrain is scrolled six pixels to
. the right (or by any other amount that is not a multiple of two).
W $E33D,$40,$04

b $E37D Shape Table Shift Zero
@ $E37D label=ShapeTableShiftZero
D $E37D The entries that are used when the terrain is not scrolled. The
. pictures are the descriptions of the shapes at #R$E581.
W $E37D,$40,$04

b $E3BD Slope Parameters
@ $E3BD label=SlopeParameters
D $E3BD Three bytes for each of the types of slope #N$00 to #N$08. The routine
. at #R$E3D8 copies to the variables at #R$CE35. The second is added to the
. screen address for each step of a segment, so it is negative for a slope that
. goes to the left.
B $E3BD,$1B,$03

c $E3D8 Set Slope Parameters
@ $E3D8 label=SetSlopeParameters
D $E3D8 Looks up the three parameters of the type of the current segment in the
. table at #R$E3BD and stores them in the variables at #R$CE35. A type of #N$07
. or more is for a segment that is upside down: it sets #R$5C35 to #N($80) and
. uses the parameters of the type less seven. It then sets #R$E41B to #N$01
. when the second parameter is negative and to #N($FF) when it is not, and in
. the second case changes the JR instruction at #R$D462 to skip two bytes.
R $E3D8 IX Address of the record of the segment (#N$03 is the type)
  $E3D8,$03 The slope parameters.
  $E3DB,$03 Read offset #N$03 of #REGix.
  $E3DE,$04 Jump to #R$E3EC if #REGa is less than #N$07.
  $E3E2,$02 #REGa=#N$80.
  $E3E4,$03 Update the upside-down segment flag.
  $E3E7,$03 Read offset #N$03 of #REGix.
  $E3EA,$02 Subtract #N$07 from #REGa.
@ $E3EC label=SetSlopeParameters_Fetch
  $E3EC,$01 #REGe=#REGa.
  $E3ED,$01 Double #REGa.
  $E3EE,$01 #REGa gains #REGe.
  $E3EF,$01 #REGe=#REGa.
  $E3F0,$02 Clear #REGd.
  $E3F2,$01 #REGhl gains #REGde.
  $E3F3,$01 Read #REGhl.
  $E3F4,$03 Update the horizontal step.
  $E3F7,$01 Advance #REGhl.
  $E3F8,$01 Read #REGhl.
  $E3F9,$03 Update the column step.
  $E3FC,$01 Advance #REGhl.
  $E3FD,$01 Read #REGhl.
  $E3FE,$03 Update the vertical step.
  $E401,$02 #REGa=#N$01.
  $E403,$03 Update the slope direction.
  $E406,$01 Clear #REGa.
  $E407,$03 Negate the slope step.
  $E40A,$03 The column step.
  $E40D,$03 Return if bit 7 of #REGa is set.
  $E410,$02 #REGa=#N$FF.
  $E412,$03 Update the slope direction.
  $E415,$02 #REGa=#N$02.
  $E417,$03 Leave the slope step as it is.
  $E41A,$01 Return.

g $E41B Slope Direction
@ $E41B label=SlopeDirection
D $E41B The direction of the current segment, which is #N$01 when the second
. parameter of its slope is negative (the segment goes to the left) and #N($FF)
. when it is not. It is set by #R$E3D8.
B $E41B,$01,$01

c $E41C Fill Strip With Pattern
@ $E41C label=FillStripWithPattern
D $E41C Fills a strip of screen bytes with a pattern of two bytes, going up two
. pixel rows at a time, and then moves along to the next column of the strip by
. the amount in #R$CE36. The strip is not drawn where the column is within one
. character of the edge of the screen, and its height is reduced where it would
. go past the bottom of the screen or above the top of the terrain.
R $E41C B' Number of columns
R $E41C C' Number of pairs of pixel rows
R $E41C DE Pattern: the first byte in #REGd and the second in #REGe
R $E41C HL' Screen address of the bottom of the first column
  $E41C,$01 Switch to the alternate registers.
  $E41D,$01 #REGb=#REGc.
  $E41E,$01 #REGa=#REGl.
  $E41F,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $E421,$01 Step #REGa back.
  $E422,$04 Jump to #R$E471 if #REGa is #N$1C or more.
  $E426,$03 The segment row.
  $E429,$04 Jump to #R$E442 if #REGa is less than #N$B8.
  $E42D,$02 Jump to #R$E442 if the zero flag is set.
  $E42F,$02 Subtract #N$B7 from #REGa.
  $E431,$02 Shift #REGa right.
  $E433,$02 Negate #REGa.
  $E435,$01 #REGa gains #REGb.
  $E436,$01 #REGb=#REGa.
  $E437,$02 #REGh=#N$57.
  $E439,$01 #REGa=#REGl.
  $E43A,$02,b$01 Keep the bits of #REGa that are set in #N$1F.
  $E43C,$02,b$01 Set the bits of #REGa that are set in #N$C0.
  $E43E,$01 #REGl=#REGa.
  $E43F,$03 Jump to #R$E455.
@ $E442 label=FillStripWithPattern_Height
  $E442,$01 #REGb=#REGa.
  $E443,$03 The vertical step copy.
  $E446,$02 Negate #REGa.
  $E448,$01 #REGa gains #REGb.
  $E449,$02 Subtract #N$18 from #REGa.
  $E44B,$01 #REGb=#REGc.
  $E44C,$02 Jump to #R$E455 if the carry flag is clear.
  $E44E,$01 Invert #REGa.
  $E44F,$02 Shift #REGa right.
  $E451,$02 Negate #REGa.
  $E453,$01 #REGa gains #REGb.
  $E454,$01 #REGb=#REGa.
@ $E455 label=FillStripWithPattern_Draw
  $E455,$03 The segment row.
  $E458,$02 Shift #REGc left.
  $E45A,$01 Subtract #REGc from #REGa.
  $E45B,$02 Shift #REGc right.
  $E45D,$03 Update the segment row.
@ $E460 label=FillStripWithPattern_Rows
  $E460,$01 Write #REGd where #REGhl points.
  $E461,$01 Step #REGh back.
  $E462,$01 Write #REGe where #REGhl points.
  $E463,$03 Call #R$A1C3.
  $E466,$02 Decrease #REGb and jump to #R$E460 until none remain.
  $E468,$03 The column step.
  $E46B,$01 #REGa gains #REGl.
  $E46C,$01 #REGl=#REGa.
  $E46D,$01 Switch to the alternate registers.
  $E46E,$02 Decrease #REGb and jump to #R$E41C until none remain.
  $E470,$01 Return.
@ $E471 label=FillStripWithPattern_Skip
  $E471,$03 The segment row.
  $E474,$02 Shift #REGb left.
  $E476,$01 Subtract #REGb from #REGa.
  $E477,$02 Shift #REGb right.
  $E479,$03 Update the segment row.
  $E47C,$03 The column step.
  $E47F,$01 #REGa gains #REGl.
  $E480,$01 #REGl=#REGa.
@ $E481 label=FillStripWithPattern_SkipRows
  $E481,$01 Step #REGh back.
  $E482,$03 Call #R$A1C3.
  $E485,$02 Decrease #REGb and jump to #R$E481 until none remain.
  $E487,$01 Switch to the alternate registers.
  $E488,$02 Decrease #REGb and jump to #R$E41C until none remain.
  $E48A,$01 Return.

c $E48B Draw One Byte Rows
@ $E48B label=DrawOneByteRows
D $E48B Draws a piece of terrain that is one byte wide, going up the screen two
. pixel rows at a time, using a word of the picture for each pair of rows. The
. entry point at #R$E48B moves one column to the right first.
R $E48B A Number of pairs of pixel rows to draw
R $E48B HL Screen address of the bottom of the piece
R $E48B SP Address of the picture
  $E48B,$01 Advance #REGl.
@ $E48C label=DrawOneByteRows_Start
  $E48C,$01 #REGb=#REGa.
@ $E48D label=DrawOneByteRows_Loop
  $E48D,$01 Bring #REGde back off the stack.
  $E48E,$01 Write #REGe where #REGhl points.
  $E48F,$01 Step #REGh back.
  $E490,$01 Write #REGd where #REGhl points.
  $E491,$01 Step #REGh back.
  $E492,$01 #REGa=#REGh.
  $E493,$01 Advance #REGa.
  $E494,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $E496,$02 Jump to #R$E4A2 if the zero flag is clear.
  $E498,$01 #REGa=#REGl.
  $E499,$02 Subtract #N$20 from #REGa.
  $E49B,$01 #REGl=#REGa.
  $E49C,$02 Jump to #R$E4A2 if the carry flag is set.
  $E49E,$01 #REGa=#REGh.
  $E49F,$02 Add #N$08 to #REGa.
  $E4A1,$01 #REGh=#REGa.
@ $E4A2 label=DrawOneByteRows_Next
  $E4A2,$02 Decrease #REGb and jump to #R$E48D until none remain.
  $E4A4,$03 Jump to #R$D711.

c $E4A7 Draw Three Byte Rows
@ $E4A7 label=DrawThreeByteRows
D $E4A7 Draws a piece of terrain that is three bytes wide, going up the screen
. two pixel rows at a time, using three words of the picture for each pair of
. rows. The entry points at #R$E4A7 and #R$E4A8 first move to the right by
. three columns and two columns.
R $E4A7 A Number of pairs of pixel rows to draw
R $E4A7 HL Screen address of the bottom left of the piece
R $E4A7 SP Address of the picture
  $E4A7,$01 Advance #REGl.
@ $E4A8 label=DrawThreeByteRows_Two
  $E4A8,$01 Advance #REGl.
  $E4A9,$01 Advance #REGl.
  $E4AA,$01 #REGb=#REGa.
@ $E4AB label=DrawThreeByteRows_Loop
  $E4AB,$01 Bring #REGde back off the stack.
  $E4AC,$01 Write #REGe where #REGhl points.
  $E4AD,$01 Advance #REGl.
  $E4AE,$01 Write #REGd where #REGhl points.
  $E4AF,$01 Advance #REGl.
  $E4B0,$01 Bring #REGde back off the stack.
  $E4B1,$01 Write #REGe where #REGhl points.
  $E4B2,$01 Step #REGh back.
  $E4B3,$01 Write #REGd where #REGhl points.
  $E4B4,$01 Step #REGl back.
  $E4B5,$01 Bring #REGde back off the stack.
  $E4B6,$01 Write #REGe where #REGhl points.
  $E4B7,$01 Step #REGl back.
  $E4B8,$01 Write #REGd where #REGhl points.
  $E4B9,$01 Step #REGh back.
  $E4BA,$01 #REGa=#REGh.
  $E4BB,$01 Advance #REGa.
  $E4BC,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $E4BE,$02 Jump to #R$E4CA if the zero flag is clear.
  $E4C0,$01 #REGa=#REGl.
  $E4C1,$02 Subtract #N$20 from #REGa.
  $E4C3,$01 #REGl=#REGa.
  $E4C4,$02 Jump to #R$E4CA if the carry flag is set.
  $E4C6,$01 #REGa=#REGh.
  $E4C7,$02 Add #N$08 to #REGa.
  $E4C9,$01 #REGh=#REGa.
@ $E4CA label=DrawThreeByteRows_Next
  $E4CA,$02 Decrease #REGb and jump to #R$E4AB until none remain.
  $E4CC,$03 Jump to #R$D711.

c $E4CF Draw Two Byte Rows
@ $E4CF label=DrawTwoByteRows
D $E4CF Draws a piece of terrain that is two bytes wide, going up the screen
. two pixel rows at a time, using two words of the picture for each pair of
. rows. The entry points at #R$E4CF and #R$E4D0 first move to the right by two
. columns and one column, and the one at #R$E4D1 does not.
R $E4CF A Number of pairs of pixel rows to draw
R $E4CF HL Screen address of the bottom left of the piece
R $E4CF SP Address of the picture
  $E4CF,$01 Advance #REGl.
@ $E4D0 label=DrawTwoByteRows_One
  $E4D0,$01 Advance #REGl.
@ $E4D1 label=DrawTwoByteRows_Start
  $E4D1,$01 #REGb=#REGa.
@ $E4D2 label=DrawTwoByteRows_Loop
  $E4D2,$01 Bring #REGde back off the stack.
  $E4D3,$01 Write #REGe where #REGhl points.
  $E4D4,$01 Advance #REGl.
  $E4D5,$01 Write #REGd where #REGhl points.
  $E4D6,$01 Step #REGh back.
  $E4D7,$01 Bring #REGde back off the stack.
  $E4D8,$01 Write #REGe where #REGhl points.
  $E4D9,$01 Step #REGl back.
  $E4DA,$01 Write #REGd where #REGhl points.
  $E4DB,$01 Step #REGh back.
  $E4DC,$01 #REGa=#REGh.
  $E4DD,$01 Advance #REGa.
  $E4DE,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $E4E0,$02 Jump to #R$E4EC if the zero flag is clear.
  $E4E2,$01 #REGa=#REGl.
  $E4E3,$02 Subtract #N$20 from #REGa.
  $E4E5,$01 #REGl=#REGa.
  $E4E6,$02 Jump to #R$E4EC if the carry flag is set.
  $E4E8,$01 #REGa=#REGh.
  $E4E9,$02 Add #N$08 to #REGa.
  $E4EB,$01 #REGh=#REGa.
@ $E4EC label=DrawTwoByteRows_Next
  $E4EC,$02 Decrease #REGb and jump to #R$E4D2 until none remain.
  $E4EE,$03 Jump to #R$D711.

c $E4F1 Draw Mirrored Three Byte Rows
@ $E4F1 label=DrawMirroredThreeByteRows
D $E4F1 Draws a piece of terrain that is three bytes wide in the same way as
. #R$E4A7, but passes every byte through the table of reversed bytes at #N$F900
. so that the piece is drawn back to front. The entry points at #R$E4F1 and
. #R$E4F2 first move to the left by three columns and two columns.
R $E4F1 A Number of pairs of pixel rows to draw
R $E4F1 HL Screen address of the bottom left of the piece
R $E4F1 SP Address of the picture
  $E4F1,$01 Step #REGl back.
@ $E4F2 label=DrawMirroredThreeByteRows_Two
  $E4F2,$01 Step #REGl back.
  $E4F3,$01 Step #REGl back.
@ $E4F4 label=DrawMirroredThreeByteRows_Start
  $E4F4,$02 #REGb=#N$F9.
  $E4F6,$01 Switch to the alternate registers.
  $E4F7,$01 #REGb=#REGa.
@ $E4F8 label=DrawMirroredThreeByteRows_Loop
  $E4F8,$01 Switch to the alternate registers.
  $E4F9,$01 Bring #REGde back off the stack.
  $E4FA,$01 #REGc=#REGe.
  $E4FB,$01 Read #REGbc.
  $E4FC,$01 Write #REGa where #REGhl points.
  $E4FD,$01 Advance #REGl.
  $E4FE,$01 #REGc=#REGd.
  $E4FF,$01 Read #REGbc.
  $E500,$01 Write #REGa where #REGhl points.
  $E501,$01 Advance #REGl.
  $E502,$01 Bring #REGde back off the stack.
  $E503,$01 #REGc=#REGe.
  $E504,$01 Read #REGbc.
  $E505,$01 Write #REGa where #REGhl points.
  $E506,$01 Step #REGh back.
  $E507,$01 #REGc=#REGd.
  $E508,$01 Read #REGbc.
  $E509,$01 Write #REGa where #REGhl points.
  $E50A,$01 Step #REGl back.
  $E50B,$01 Bring #REGde back off the stack.
  $E50C,$01 #REGc=#REGe.
  $E50D,$01 Read #REGbc.
  $E50E,$01 Write #REGa where #REGhl points.
  $E50F,$01 Step #REGl back.
  $E510,$01 #REGc=#REGd.
  $E511,$01 Read #REGbc.
  $E512,$01 Write #REGa where #REGhl points.
  $E513,$01 Step #REGh back.
  $E514,$01 #REGa=#REGh.
  $E515,$01 Advance #REGa.
  $E516,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $E518,$02 Jump to #R$E524 if the zero flag is clear.
  $E51A,$01 #REGa=#REGl.
  $E51B,$02 Subtract #N$20 from #REGa.
  $E51D,$01 #REGl=#REGa.
  $E51E,$02 Jump to #R$E524 if the carry flag is set.
  $E520,$01 #REGa=#REGh.
  $E521,$02 Add #N$08 to #REGa.
  $E523,$01 #REGh=#REGa.
@ $E524 label=DrawMirroredThreeByteRows_Next
  $E524,$01 Switch to the alternate registers.
  $E525,$02 Decrease #REGb and jump to #R$E4F8 until none remain.
  $E527,$01 Switch to the alternate registers.
  $E528,$03 Jump to #R$D711.

c $E52B Draw Mirrored Two Byte Rows
@ $E52B label=DrawMirroredTwoByteRows
D $E52B Draws a piece of terrain that is two bytes wide in the same way as
. #R$E4CF, but passes every byte through the table of reversed bytes at
. #N$F900. The entry points at #R$E52B and #R$E52C first move to the left by
. two columns and one column, and the one at #R$E52D does not.
R $E52B A Number of pairs of pixel rows to draw
R $E52B HL Screen address of the bottom left of the piece
R $E52B SP Address of the picture
  $E52B,$01 Step #REGl back.
@ $E52C label=DrawMirroredTwoByteRows_One
  $E52C,$01 Step #REGl back.
@ $E52D label=DrawMirroredTwoByteRows_Start
  $E52D,$02 #REGb=#N$F9.
  $E52F,$01 Switch to the alternate registers.
  $E530,$01 #REGb=#REGa.
@ $E531 label=DrawMirroredTwoByteRows_Loop
  $E531,$01 Switch to the alternate registers.
  $E532,$01 Bring #REGde back off the stack.
  $E533,$01 #REGc=#REGe.
  $E534,$01 Read #REGbc.
  $E535,$01 Write #REGa where #REGhl points.
  $E536,$01 Advance #REGl.
  $E537,$01 #REGc=#REGd.
  $E538,$01 Read #REGbc.
  $E539,$01 Write #REGa where #REGhl points.
  $E53A,$01 Step #REGh back.
  $E53B,$01 Bring #REGde back off the stack.
  $E53C,$01 #REGc=#REGe.
  $E53D,$01 Read #REGbc.
  $E53E,$01 Write #REGa where #REGhl points.
  $E53F,$01 Step #REGl back.
  $E540,$01 #REGc=#REGd.
  $E541,$01 Read #REGbc.
  $E542,$01 Write #REGa where #REGhl points.
  $E543,$01 Step #REGh back.
  $E544,$01 #REGa=#REGh.
  $E545,$01 Advance #REGa.
  $E546,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $E548,$02 Jump to #R$E554 if the zero flag is clear.
  $E54A,$01 #REGa=#REGl.
  $E54B,$02 Subtract #N$20 from #REGa.
  $E54D,$01 #REGl=#REGa.
  $E54E,$02 Jump to #R$E554 if the carry flag is set.
  $E550,$01 #REGa=#REGh.
  $E551,$02 Add #N$08 to #REGa.
  $E553,$01 #REGh=#REGa.
@ $E554 label=DrawMirroredTwoByteRows_Next
  $E554,$01 Switch to the alternate registers.
  $E555,$02 Decrease #REGb and jump to #R$E531 until none remain.
  $E557,$01 Switch to the alternate registers.
  $E558,$03 Jump to #R$D711.

c $E55B Draw Mirrored One Byte Rows
@ $E55B label=DrawMirroredOneByteRows
D $E55B Draws a piece of terrain that is one byte wide in the same way as
. #R$E48B, but passes every byte through the table of reversed bytes at
. #N$F900. The entry point at #R$E55B moves one column to the left first.
R $E55B A Number of pairs of pixel rows to draw
R $E55B HL Screen address of the bottom of the piece
R $E55B SP Address of the picture
  $E55B,$01 Step #REGl back.
@ $E55C label=DrawMirroredOneByteRows_Start
  $E55C,$02 #REGb=#N$F9.
  $E55E,$01 Switch to the alternate registers.
  $E55F,$01 #REGb=#REGa.
@ $E560 label=DrawMirroredOneByteRows_Loop
  $E560,$01 Switch to the alternate registers.
  $E561,$01 Bring #REGde back off the stack.
  $E562,$01 #REGc=#REGe.
  $E563,$01 Read #REGbc.
  $E564,$01 Write #REGa where #REGhl points.
  $E565,$01 Step #REGh back.
  $E566,$01 #REGc=#REGd.
  $E567,$01 Read #REGbc.
  $E568,$01 Write #REGa where #REGhl points.
  $E569,$01 Step #REGh back.
  $E56A,$01 #REGa=#REGh.
  $E56B,$01 Advance #REGa.
  $E56C,$02,b$01 Keep the bits of #REGa that are set in #N$07.
  $E56E,$02 Jump to #R$E57A if the zero flag is clear.
  $E570,$01 #REGa=#REGl.
  $E571,$02 Subtract #N$20 from #REGa.
  $E573,$01 #REGl=#REGa.
  $E574,$02 Jump to #R$E57A if the carry flag is set.
  $E576,$01 #REGa=#REGh.
  $E577,$02 Add #N$08 to #REGa.
  $E579,$01 #REGh=#REGa.
@ $E57A label=DrawMirroredOneByteRows_Next
  $E57A,$01 Switch to the alternate registers.
  $E57B,$02 Decrease #REGb and jump to #R$E560 until none remain.
  $E57D,$01 Switch to the alternate registers.
  $E57E,$03 Jump to #R$D711.

b $E581 Shape Descriptions
@ $E581 label=ShapeDescriptions
D $E581 The descriptions of the shapes of the ground that #R$F7EB shifts to
. make the pictures that #R$D0BD draws. Each starts with a header of three
. bytes (see #R$F895) that is followed by the bytes of the picture, which
. include the chequered background of #N($55) and #N($AA).
B $E581,$56,$08
@ $E5D7 label=ShapeDescriptions_Second
B $E5D7,$56,$08
@ $E62D label=ShapeDescriptions_Third
B $E62D,$1E,$08
@ $E64B label=ShapeDescriptions_Fourth
B $E64B,$1E,$08
@ $E669 label=ShapeDescriptions_Fifth
B $E669,$39,$08
@ $E6A2 label=ShapeDescriptions_Sixth
B $E6A2,$3B,$08
@ $E6DD label=ShapeDescriptions_Seventh
B $E6DD,$36,$08
@ $E713 label=ShapeDescriptions_Eighth
B $E713,$36,$08
B $E749,$01,$01

b $E74A Shifted Shapes One
@ $E74A label=ShiftedShapesOne
D $E74A The three copies of the description at #R$E64B, shifted by two, four
. and six pixels, which #R$F7EB makes. The bytes that are zero are not used.
B $E74A,$BA,$08

b $E804 Shifted Shapes Two
@ $E804 label=ShiftedShapesTwo
D $E804 The three shifted copies of the description at #R$E6A2.
B $E804,$011A,$08

b $E91E Shifted Shapes Three
@ $E91E label=ShiftedShapesThree
D $E91E The three shifted copies of the description at #R$E713.
B $E91E,$014A,$08

b $EA68 Shifted Shapes Four
@ $EA68 label=ShiftedShapesFour
D $EA68 The three shifted copies of the description at #R$E581.
B $EA68,$FC,$08

b $EB64 Shifted Shapes Five
@ $EB64 label=ShiftedShapesFive
D $EB64 The three shifted copies of the description at #R$E5D7.
B $EB64,$FC,$08

b $EC60 Shape Description
@ $EC60 label=ShapeDescriptionLast
D $EC60 A description of a shape of the same kind as the ones at #R$E581. It is
. in the middle of the buffers.
B $EC60,$36,$08

b $EC96 Shifted Shapes Six
@ $EC96 label=ShiftedShapesSix
D $EC96 The three shifted copies of the description at #R$EC60.
B $EC96,$014A,$08

b $EDE0 Shifted Shapes Seven
@ $EDE0 label=ShiftedShapesSeven
D $EDE0 The three shifted copies of the description at #R$E62D, made with the
. shape back to front.
B $EDE0,$BA,$08

b $EE9A Shifted Shapes Eight
@ $EE9A label=ShiftedShapesEight
D $EE9A The three shifted copies of the description at #R$E669, made with the
. shape back to front.
B $EE9A,$0117,$08

b $EFB1 Shifted Shapes Nine
@ $EFB1 label=ShiftedShapesNine
D $EFB1 The three shifted copies of the description at #R$E6DD, made with the
. shape back to front.
B $EFB1,$015E,$08

g $F10F Playfield Attribute Area
@ $F10F label=PlayfieldAttributeArea
D $F10F The area of attributes for the background of the playfield, which
. #R$F419 fills: #N($1C) wide and #N($14) high. #R$DCA1 sets the attribute.
B $F10F,$03,$03

b $F112 Title Text
@ $F112 label=TitleText
D $F112 The twelve text records for the title screen, in the format that
. #R$A115 prints: the column, the row, the attribute, the number of characters
. and then the characters. #N($25) is a graphic of the roman numeral two and
. #N($28) is an equals sign, and the last record is a line.
B $F112,$04,$04 Title
B $F116,$07,$07 "CYBERUN"
B $F11D,$04,$04 Option for one player
B $F121,$0C,$0C "A = 1 PLAYER"
B $F12D,$04,$04 Option for two players
B $F131,$0D,$0D "B = 2 PLAYERS"
B $F13E,$04,$04 Option to start
B $F142,$0E,$0E "0 = START GAME"
B $F150,$04,$04 Control option
B $F154,$08,$08 "KEYBOARD"
B $F15C,$04,$04 Control option
B $F160,$08,$08 "KEMPSTON"
B $F168,$04,$04 Control option
B $F16C,$08,$08 "JOYSTICK"
B $F174,$04,$04 Control option
B $F178,$06,$06 "CURSOR"
B $F17E,$04,$04 Control option
B $F182,$08,$08 "JOYSTICK"
B $F18A,$04,$04 Control option
B $F18E,$0B,$0B "INTERFACE II"
B $F199,$04,$04 Copyright
B $F19D,$0C,$0C "  A.C.G.1985"
B $F1A9,$04,$04 Line
B $F1AD,$10,$10

c $F1BD Colour Ship
@ $F1BD label=ColourShip
D $F1BD Fills the attributes that the ship covers with its colour, which is
. white normally, yellow while the stack of units is full and cyan while the
. timer at #R$896F is running (changing back to the normal colour every eight
. frames during the last #N($20) frames). If the colour has changed it makes
. the sound at #R$725C.
  $F1BD,$02 #REGb=#N$47.
  $F1BF,$03 The stack height.
  $F1C2,$04 Jump to #R$F1C8 if #REGa is not #N$12.
  $F1C6,$02 #REGb=#N$46.
@ $F1C8 label=ColourShip_Timer
  $F1C8,$01 #REGc=#REGb.
  $F1C9,$03 The falling timer.
  $F1CC,$03 Jump to #R$F1DD if #REGa is zero.
  $F1CF,$02 #REGb=#N$45.
  $F1D1,$04 Jump to #R$F1DD if #REGa is #N$20 or more.
  $F1D5,$03 The frame counter.
  $F1D8,$02,b$01 Keep the bits of #REGa that are set in #N$08.
  $F1DA,$02 Jump to #R$F1DD if the zero flag is set.
  $F1DC,$01 #REGb=#REGc.
@ $F1DD label=ColourShip_Fill
  $F1DD,$03 The colour the ship was drawn in.
  $F1E0,$01 Compare #REGa with #REGb.
  $F1E1,$01 Stash #REGbc on the stack.
  $F1E2,$03 Call #R$725C if the zero flag is clear.
  $F1E5,$01 Bring #REGbc back off the stack.
  $F1E6,$03 Fetch the word at #N$C902 into #REGhl.
  $F1E9,$03 The height of the ship.
  $F1EC,$02 Add #N$07 to #REGa.
  $F1EE,$02 Shift #REGa right.
  $F1F0,$02 Shift #REGa right.
  $F1F2,$02 Shift #REGa right.
  $F1F4,$01 #REGc=#REGa.
  $F1F5,$04 The size and the new colour of the ship.
  $F1F9,$03 The ship attribute area.
  $F1FC,$03 Jump to #R$C991.

g $F1FF Ship Attribute Area
@ $F1FF label=ShipAttributeArea
D $F1FF The area of attributes that #R$F1BD fills: the width, the height in
. rows and the attribute.
B $F1FF,$03,$03

b $F202 Title Frame Corners
@ $F202 label=TitleFrameCorners
D $F202 The table for the corners of the frame of the title screen, which has
. the same layout as the one at #R$CBF8.
B $F202,$07,$07 Bottom left
B $F209,$07,$07 Bottom right
B $F210,$07,$07 Top left
B $F217,$07,$07 Top right

b $F21E Title Frame Ticks
@ $F21E label=TitleFrameTicks
D $F21E The table for the ticks on the frame of the title screen, which has the
. same layout as the one at #R$CBE5.
B $F21E,$0C,$02

g $F22A Title Frame Parameters
@ $F22A label=TitleFrameParameters
D $F22A The values that #R$CACB uses to draw the frame of the title screen,
. which has the same layout as the table at #R$CA1D.
W $F22A,$02,$02 Left vertical line
W $F22C,$02,$02 Right vertical line
B $F22E,$01,$01 Number of rows in the vertical lines
W $F22F,$02,$02 Bottom horizontal lines
W $F231,$02,$02 Top horizontal lines
W $F233,$02,$02 Address of the corner table (set by #R$F26C)
B $F235,$01,$01 Number of ticks along each edge
W $F236,$02,$02 Address of the tick table (set by #R$F26C)
B $F238,$01,$01 Pixel row of the top edge
B $F239,$01,$01 Pixel column of the right edge
B $F23A,$01,$01 Length of the horizontal lines, in bytes

c $F23B Get Random Numbers
@ $F23B label=RandomNumber
D $F23B Makes two new random numbers at #R$9BCB, using a pointer to a byte of
. memory that is moved on one place each time and stays below #N($B000). The
. byte that it points to is added to each number, together with the value of
. the value of the controls (see #R$B115), so pressing the controls at
. different times changes the numbers.
  $F23B,$04 The random numbers.
  $F23F,$03 Read offset #N$02 of #REGix into #REGh.
  $F242,$03 Read offset #N$03 of #REGix into #REGl.
  $F245,$01 Advance #REGhl.
  $F246,$01 #REGa=#REGh.
  $F247,$02,b$01 Keep the bits of #REGa that are set in #N$AF.
  $F249,$03 Write #REGa to offset #N$02 of #REGix.
  $F24C,$03 Write #REGl to offset #N$03 of #REGix.
  $F24F,$01 Read #REGhl into #REGb.
  $F250,$03 The controls.
  $F253,$01 #REGa gains #REGb.
  $F254,$02 Add #N$05 to #REGa.
  $F256,$03 Add the byte at offset #N$00 of #REGix to #REGa.
  $F259,$03 Write #REGa to offset #N$00 of #REGix.
  $F25C,$01 #REGa=#REGb.
  $F25D,$01 Invert #REGa.
  $F25E,$01 #REGb=#REGa.
  $F25F,$03 The controls.
  $F262,$02 Add #N$09 to #REGa.
  $F264,$01 #REGa gains #REGb.
  $F265,$03 Add the byte at offset #N$01 of #REGix to #REGa.
  $F268,$03 Write #REGa to offset #N$01 of #REGix.
  $F26B,$01 Return.

c $F26C Show Title Screen
@ $F26C label=ShowTitleScreen
D $F26C Draws the title screen, with a frame, the title text and two small
. graphics, and shows the control icons and the options with #R$8690 and
. #R$8652. A tune plays until a key is pressed and then the menu runs with
. #R$8615. When it has finished, the options are shown again and a short tune
. plays.
. .
. #HTML(#AUDIO0(title-tune.wav)(#INCLUDE(TitleTune)))
. #HTML(#AUDIO0(game-start-tune.wav)(#INCLUDE(GameStartTune)))
. #PUSHS #UDGTABLE { #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$F26C,stop=$F2D0,clear=1,sp=$FE00)
. #SCR$02(title-screen) } UDGTABLE# #POPS
  $F26C,$03 Call #R$9A7E.
  $F26F,$03 Call #R$9A72.
  $F272,$04 The title frame parameters.
  $F276,$03 The title frame corners.
  $F279,$03 Write #REGe to offset #N$09 of #REGix.
  $F27C,$03 Write #REGd to offset #N$0A of #REGix.
  $F27F,$03 The title frame ticks.
  $F282,$03 Write #REGe to offset #N$0C of #REGix.
  $F285,$03 Write #REGd to offset #N$0D of #REGix.
  $F288,$03 Call #R$CACB.
  $F28B,$03 The title text.
  $F28E,$02 #REGb=#N$0C.
  $F290,$03 Call #R$83CE.
  $F293,$03 Use #N$BF40.
  $F296,$03 The title graphics.
  $F299,$03 Call #R$C96F.
  $F29C,$03 Use #N$BEB0.
  $F29F,$03 Call #R$C96F.
  $F2A2,$02 #REGa=#N$46.
  $F2A4,$03 A title-screen attribute.
  $F2A7,$03 A title-screen attribute.
  $F2AA,$03 #REGhl=#N$486C.
  $F2AD,$02 Store #N$0F at the address in #REGhl.
  $F2AF,$01 Advance #REGl.
  $F2B0,$02 #REGb=#N$06.
@ $F2B2 label=ShowTitleScreen_Line
  $F2B2,$02 Store #N$FF at the address in #REGhl.
  $F2B4,$01 Advance #REGl.
  $F2B5,$02 Decrease #REGb and jump to #R$F2B2 until none remain.
  $F2B7,$02 Store #N$F0 at the address in #REGhl.
  $F2B9,$04 The control icon data.
  $F2BD,$03 The control icon sprites.
  $F2C0,$03 Call #R$8690.
  $F2C3,$04 The second player's control icon.
  $F2C7,$03 The second control-icon sprite.
  $F2CA,$03 Call #R$8690.
  $F2CD,$03 Call #R$8652.
  $F2D0,$03 The tune: title screen.
  $F2D3,$03 Call #R$9A9A.
  $F2D6,$03 Call #R$8615.
  $F2D9,$03 Call #R$8652.
  $F2DC,$03 The tune: game start.
  $F2DF,$03 Jump to #R$9AA9.

g $F2E2 Two Player Flag
@ $F2E2 label=TwoPlayerFlag
D $F2E2 Is zero for a game with one player and not zero for a game with two
. players, which the menu at #R$8615 sets.
B $F2E2,$01,$01

b $F2E3 Title Graphics
@ $F2E3 label=TitleGraphics
D $F2E3 The two small graphics that #R$F26C draws at the bottom of the title
. screen: the first is three bytes wide and eight rows high, the second two
. bytes wide and six rows high.
B $F2E3,$02,$02
B $F2E5,$18,$03
B $F2FD,$02,$02
B $F2FF,$0C,$02

c $F30B Clear Bytes
@ $F30B label=ClearBytes
D $F30B Sets a number of bytes of memory to zero.
E $F30B View the equivalent code in;
. #LIST
. { #BUBBLER$A2E0 }
. LIST#
R $F30B B Number of bytes
R $F30B HL Address
R $F30B O:HL Address after the last byte
  $F30B,$02 Store #N$00 at the address in #REGhl.
  $F30D,$01 Advance #REGhl.
  $F30E,$02 Decrease #REGb and jump to #R$F30B until none remain.
  $F310,$01 Return.

c $F311 Reset Life
@ $F311 label=ResetLife
D $F311 Resets everything for the start of a life: the colour of the ship, the
. explosion, the shield timer and some other counters, the stars, the shots and
. the saved copies of the flame objects. The ship object at #R$C8E5 is restored
. from the state at #R$C906 and all the enemy and map object slots are freed.
  $F311,$02 #REGa=#N$47.
  $F313,$03 The ship starts white.
  $F316,$01 Clear #REGa.
  $F317,$03 Update the ship state.
  $F31A,$03 Update the falling timer.
  $F31D,$03 Update the crystal-delivery flag.
  $F320,$03 The damage counter.
  $F323,$03 No piece has been drawn yet.
  $F326,$03 The bonus timer.
  $F329,$02 #REGa=#N$18.
  $F32B,$03 Update the beam hit delay.
  $F32E,$03 The star positions.
  $F331,$02 #REGb=#N$12.
@ $F333 label=ResetLife_Stars
  $F333,$01 Read #REGhl.
  $F334,$02,b$01 Keep the bits of #REGa that are set in #N$FE.
  $F336,$01 Write #REGa where #REGhl points.
  $F337,$01 Advance #REGhl.
  $F338,$01 Advance #REGhl.
  $F339,$02 Decrease #REGb and jump to #R$F333 until none remain.
  $F33B,$03 The shot slots.
  $F33E,$02 #REGb=#N$60.
  $F340,$03 Call #R$F30B.
  $F343,$03 The crystal-stack table.
  $F346,$02 #REGb=#N$08.
@ $F348 label=ResetLife_Entries
  $F348,$02 Store #N$00 at the address in #REGhl.
  $F34A,$02 #REGa=#N$05.
  $F34C,$03 Call #R$9BCF.
  $F34F,$02 Decrease #REGb and jump to #R$F348 until none remain.
  $F351,$03 The beam table.
  $F354,$02 #REGb=#N$10.
  $F356,$03 Call #R$F30B.
  $F359,$03 The ship top object.
  $F35C,$03 The other player's ship top.
  $F35F,$03 #REGbc=#N$06.
  $F362,$02 Copy #REGbc bytes from #REGhl to #REGde.
  $F364,$03 The main flame object.
  $F367,$03 The other player's main flame.
  $F36A,$02 #REGc=#N$06.
  $F36C,$02 Copy #REGbc bytes from #REGhl to #REGde.
  $F36E,$03 The side flame object.
  $F371,$03 The other player's side flame.
  $F374,$02 #REGc=#N$07.
  $F376,$02 Copy #REGbc bytes from #REGhl to #REGde.
  $F378,$02 #REGc=#N$20.
  $F37A,$03 The ship.
  $F37D,$03 The ship start state.
  $F380,$02 Copy #REGbc bytes from #REGhl to #REGde.
@ $F382 label=ResetLife_Slots
  $F382,$04 The enemy slots.
  $F386,$02 #REGb=#N$09.
  $F388,$03 #REGde=#N$18.
  $F38B,$03 Call #R$F396.
  $F38E,$04 The map object slots.
  $F392,$02 #REGe=#N$1A.
  $F394,$02 #REGb=#N$06.
@ $F396 label=ResetLife_FreeSlot
  $F396,$03 Call #R$AC34.
  $F399,$02 #REGix gains #REGde.
  $F39B,$02 Decrease #REGb and jump to #R$F396 until none remain.
  $F39D,$01 Return.

c $F39E Reset Player State
@ $F39E label=ResetPlayerState
D $F39E Clears the state of a player apart from the sites of the items, sets
. the item that is carried to none (#N($FF)) and copies the starting position
. from #R$F3B7.
R $F39E HL Address of the state of the player
  $F39E,$02 #REGb=#N$1C.
  $F3A0,$01 Stash #REGhl on the stack.
  $F3A1,$03 Call #R$F30B.
  $F3A4,$01 Step #REGhl back.
  $F3A5,$01 Step #REGhl back.
  $F3A6,$02 Store #N$FF at the address in #REGhl.
  $F3A8,$01 Bring #REGhl back off the stack.
  $F3A9,$02 #REGa=#N$13.
  $F3AB,$03 Call #R$9BCF.
  $F3AE,$03 The starting position.
  $F3B1,$02 #REGc=#N$06.
  $F3B3,$01 Swap #REGde and #REGhl.
  $F3B4,$02 Copy #REGbc bytes from #REGhl to #REGde.
  $F3B6,$01 Return.

b $F3B7 Starting Position
@ $F3B7 label=StartingPosition
D $F3B7 The position that each player starts at, in the same format as at
. #R$F5FA: the map column and row, the two positions and the two offsets.
B $F3B7,$06,$06

c $F3BD Start New Game
@ $F3BD label=StartNewGame
D $F3BD Sets up a new game: the objects on the map are all put back, the state
. of both players is reset and each player is given five ships. If the players
. were swapped by the last game they are swapped back, the second player is
. given no ships in a game with one player, the control devices that were
. chosen by the menu are copied for the players, the scores are set to zero and
. the sites of the items are chosen for both players.
  $F3BD,$02 #REGe=#N$3F.
  $F3BF,$03 Call #R$9A8A.
  $F3C2,$03 The current player state.
  $F3C5,$03 Call #R$F39E.
  $F3C8,$03 The other player state.
  $F3CB,$03 Call #R$F39E.
  $F3CE,$02 #REGa=#N$05.
  $F3D0,$03 Update the ships remaining.
  $F3D3,$03 The other player is given five ships.
  $F3D6,$02 #REGa=#N$99.
  $F3D8,$03 The players are being set up.
  $F3DB,$03 The player 1: ships left.
  $F3DE,$05 Call #R$F591 if #REGa is #N$A0.
  $F3E3,$01 Clear #REGa.
  $F3E4,$03 Player one is up.
  $F3E7,$03 The two player flag.
  $F3EA,$03 Jump to #R$F3F0 if #REGa is not zero.
  $F3ED,$03 The other player has no ships.
@ $F3F0 label=StartNewGame_Controls
  $F3F0,$03 The control method chosen for player one.
  $F3F3,$03 Update the control device.
  $F3F6,$03 The control method chosen for player two.
  $F3F9,$03 The other player's control device.
  $F3FC,$02 #REGb=#N$06.
  $F3FE,$03 The player 1 score digits.
  $F401,$03 The player 2 score digits.
  $F404,$02 #REGa=#N$1A.
@ $F406 label=StartNewGame_Loop
  $F406,$01 Write #REGa where #REGde points.
  $F407,$01 Write #REGa where #REGhl points.
  $F408,$01 Advance #REGhl.
  $F409,$01 Advance #REGde.
  $F40A,$02 Decrease #REGb and jump to #R$F406 until none remain.
  $F40C,$03 The item sites.
  $F40F,$03 Call #R$6113.
  $F412,$03 The other player's item sites.
  $F415,$03 Call #R$6113.
  $F418,$01 Return.

c $F419 Colour Playfield
@ $F419 label=ColourPlayfield
D $F419 Fills the attributes of the playfield with the background colour.
  $F419,$03 Use #N$B708.
  $F41C,$03 The playfield attribute area.
  $F41F,$03 Jump to #R$C991.

c $F422 Run Game
@ $F422 label=RunGame
D $F422 Runs the game, starting with the title screen: it makes a new game,
. draws the screen and the HUD and prints the number of the player. Returns
. here from #R$F440 when all the ships have gone.
  $F422,$03 Call #R$F26C.
  $F425,$03 Call #R$F3BD.
  $F428,$03 Call #R$9A72.
  $F42B,$03 Call #R$9A7E.
  $F42E,$03 Call #R$CA3F.
  $F431,$03 Call #R$F4EE.
  $F434,$02 #REGb=#N$06.
@ $F436 label=RunGame_Wait
  $F436,$03 Call #R$A802.
  $F439,$02 Decrease #REGb and jump to #R$F436 until none remain.
  $F43B,$03 Call #R$9F2C.
  $F43E,$02 Jump to #R$F44C.

c $F440 Prepare Life
@ $F440 label=PrepareLife
D $F440 Resets the ship and everything else for the next life. If there are no
. ships left the game goes back to the title screen. If there are, the HUD is
. drawn again.
E $F440 Continue on to #R$F44C.
  $F440,$03 Call #R$F311.
  $F443,$03 The ships remaining.
  $F446,$03 Jump to #R$F422 if #REGa is zero.
  $F449,$03 Call #R$CA3F.

c $F44C Play Life
@ $F44C label=PlayLife
D $F44C Plays a life. The height of the stack of units is restored and the code
. that tests and sets the bit for a destroyed object in the map table is
. changed (at #N($E118), #N($A9B8) and #N($ABDE)) so that player two uses bit 6
. rather than bit 7. The life is started with #R$DCA1.
E $F44C Continue on to #R$F46C.
  $F44C,$03 The height of the stack of units that the ship carries.
  $F44F,$03 Update the stack height.
  $F452,$03 The current player.
  $F455,$01 #REGb=#REGa.
  $F456,$02 #REGa=#N$7E.
  $F458,$04 Jump to #R$F45E if bit 0 of #REGb is clear.
  $F45C,$02 #REGa=#N$76.
@ $F45E label=PlayLife_Store
  $F45E,$03 Which bit is tested for a destroyed map cell.
  $F461,$02,b$01 Set the bits of #REGa that are set in #N$F0.
  $F463,$03 Which bit is set on a destroyed map cell.
  $F466,$03 Which bit is set on a destroyed map cell.
  $F469,$03 Call #R$DCA1.

c $F46C Run Life
@ $F46C label=RunLife
D $F46C Runs the frames of a life one at a time until the ship has been
. destroyed (when the explosion counter at #R$8F53 is #N($0C) or more) or the
. planet has been completed (when the flag at #R$96AB is #N($FF)).
  $F46C,$03 Call #R$C374.
  $F46F,$03 Call #R$CC77.
  $F472,$03 Call #R$87AF.
  $F475,$03 Call #R$8D42.
  $F478,$03 Call #R$F23B.
  $F47B,$03 The ship state.
  $F47E,$04 Jump to #R$F48B if #REGa is #N$0C or more.
  $F482,$03 The crystal-delivery flag.
  $F485,$01 Advance #REGa.
  $F486,$02 Jump to #R$F46C if the zero flag is clear.
  $F488,$03 Jump to #R$F52A.

c $F48B Explode Ship
@ $F48B label=ExplodeShip
D $F48B Runs the frames of the explosion of the ship, once it has been
. destroyed, with the scroll speeds at zero and the fuel gauge empty, until the
. explosion counter at #R$8F53 gets to #N($50). It then plays a tune, fades out
. the playfield and takes away a life, and goes on to #R$F440.
. .
. #HTML(#AUDIO0(ship-destroyed-tune.wav)(#INCLUDE(ShipDestroyedTune)))
  $F48B,$01 Clear #REGa.
  $F48C,$03 Update the horizontal scroll speed.
  $F48F,$03 Update the vertical scroll speed.
  $F492,$03 The rotate step of doubling a number.
  $F495,$03 Update the fuel level.
  $F498,$03 Call #R$C4ED.
  $F49B,$03 Call #R$C6D2.
@ $F49E label=ExplodeShip_Loop
  $F49E,$03 Call #R$C374.
  $F4A1,$03 Call #R$9F4E.
  $F4A4,$03 Call #R$CC77.
  $F4A7,$03 Call #R$8D42.
  $F4AA,$03 Call #R$C1CE.
  $F4AD,$03 Call #R$CC77.
  $F4B0,$03 The ship state.
  $F4B3,$04 Jump to #R$F49E if #REGa is not #N$50.
  $F4B7,$03 The tune: ship destroyed.
  $F4BA,$03 Call #R$9AA9.
  $F4BD,$03 Call #R$9EF5.
  $F4C0,$03 Call #R$F4C6.
  $F4C3,$03 Jump to #R$F440.

c $F4C6 Lose Life
@ $F4C6 label=LoseLife
D $F4C6 Saves the height of the stack of units and takes a ship away from the
. current player. If there are none left the game is over for the player.
. Otherwise, in a game with two players, the players are swapped.
  $F4C6,$03 The stack height.
  $F4C9,$03 Update the height of the stack of units that the ship carries.
  $F4CC,$03 The ships remaining.
N $F4CF See #POKE(infinite_ships,Infinite Ships).
  $F4CF,$01 Step #REGa back.
  $F4D0,$03 Update the ships remaining.
  $F4D3,$02 Jump to #R$F4FC if the zero flag is set.
  $F4D5,$03 The two player flag.
  $F4D8,$04 Call #R$F591 if #REGa is not zero.
  $F4DC,$01 Return.

b $F4DD Tune: Ship Destroyed
@ $F4DD label=TuneShipDestroyed
D $F4DD The notes that are played when the ship has been destroyed. The tune
. ends with #N($FF).
B $F4DD,$07,$07

b $F4E4 Tune: Game Start
@ $F4E4 label=TuneGameStart
D $F4E4 The notes that are played when a game starts. The tune ends with
. #N($FF).
B $F4E4,$0A,$0A

c $F4EE Print Player
@ $F4EE label=PrintPlayer
D $F4EE Prints the number of the current player, which is player one or player
. two, with the text at #R$F5DB.
  $F4EE,$03 The current player.
  $F4F1,$02 Add #N$1B to #REGa.
  $F4F3,$03 The digit of the player.
  $F4F6,$03 The text: player.
  $F4F9,$03 Jump to #R$A115.

c $F4FC Game Over
@ $F4FC label=GameOver
D $F4FC Ends the game for the current player. It prints the number of the
. player and the text GAME OVER, updates the high score and plays a tune. Then
. it waits for a while or until the 0 key is pressed, clears the playfield and
. (with two players) swaps the players.
. .
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
  $F4FC,$03 Call #R$F4EE.
  $F4FF,$03 The text: game over.
  $F502,$03 Call #R$A115.
  $F505,$03 Call #R$F54D.
  $F508,$03 The tune: game over.
  $F50B,$03 Call #R$9AA9.
  $F50E,$02 #REGb=#N$0C.
@ $F510 label=GameOver_Wait
  $F510,$03 Call #R$A802.
  $F513,$02 #REGa=#N$EF.
  $F515,$02 Send #REGa to port #N$FD.
  $F517,$02 Read port #N$FE.
  $F519,$02,b$01 Keep the bits of #REGa that are set in #N$01.
  $F51B,$02 Jump to #R$F51F if the zero flag is set.
  $F51D,$02 Decrease #REGb and jump to #R$F510 until none remain.
@ $F51F label=GameOver_Done
  $F51F,$03 Call #R$9F2C.
  $F522,$03 The two player flag.
  $F525,$04 Call #R$F591 if #REGa is not zero.
  $F529,$01 Return.

c $F52A Finish Planet
@ $F52A label=FinishPlanet
D $F52A Used when the planet has been completed. It clears the playfield, runs
. #R$83D6 and plays a tune. After a short delay it clears the playfield and the
. map cells at #R$F5EA again, and carries on with #R$F440.
. .
. #HTML(#AUDIO0(planet-complete-tune.wav)(#INCLUDE(PlanetCompleteTune)))
  $F52A,$03 Call #R$9F2C.
  $F52D,$03 Call #R$83D6.
  $F530,$03 The tune: planet complete.
  $F533,$03 Call #R$9AA9.
  $F536,$02 #REGb=#N$0E.
@ $F538 label=FinishPlanet_Wait
  $F538,$03 Call #R$A802.
  $F53B,$02 Decrease #REGb and jump to #R$F538 until none remain.
  $F53D,$03 Call #R$9F2C.
  $F540,$01 Clear #REGa.
  $F541,$03 Update the bitmap of map cells.
  $F544,$03 The second byte of the map-cell bitmap.
  $F547,$03 The third byte of the map-cell bitmap.
  $F54A,$03 Jump to #R$F440.

c $F54D Update High Score
@ $F54D label=UpdateHighScore
D $F54D Compares the score at #R$C9F0 with the high score at #R$CA16, one digit
. at a time, starting at the left. If the score is higher it is copied to the
. high score.
  $F54D,$03 The high-score digits.
  $F550,$03 The player 1 score digits.
  $F553,$02 #REGb=#N$06.
@ $F555 label=UpdateHighScore_Compare
  $F555,$01 Read #REGde.
  $F556,$02 Return if #REGa is less than the byte at #REGhl.
  $F558,$02 Jump to #R$F55E if the zero flag is clear.
  $F55A,$01 Advance #REGhl.
  $F55B,$01 Advance #REGde.
  $F55C,$02 Decrease #REGb and jump to #R$F555 until none remain.
@ $F55E label=UpdateHighScore_Update
  $F55E,$03 The high-score digits.
  $F561,$03 The player 1 score digits.
  $F564,$03 #REGbc=#N$06.
  $F567,$02 Copy #REGbc bytes from #REGhl to #REGde.
  $F569,$01 Return.

b $F56A Tune: Planet Complete
@ $F56A label=TunePlanetComplete
D $F56A The notes that are played when a planet has been completed. The tune
. ends with #N($FF).
B $F56A,$16,$08

b $F580 Tune: Game Over
@ $F580 label=TuneGameOver
D $F580 The notes that are played when the game is over. The tune ends with
. #N($FF).
B $F580,$11,$08

c $F591 Swap Players
@ $F591 label=SwapPlayers
D $F591 Does nothing if the second player has no ships. Otherwise it swaps the
. state of the two players, and the records for the scores and the numbers of
. ships that are printed at the top of the screen, so that the state of the
. player who is up is always at #R$F5E7. If the flag at #R$CA1C is #N($99) it
. goes no further. If not it changes the number of the player, prints it and
. clears the playfield.
  $F591,$03 The other player's ships.
  $F594,$02 Return if #REGa is zero.
  $F596,$03 The current player state.
  $F599,$03 The other player state.
  $F59C,$02 #REGb=#N$69.
  $F59E,$03 Call #R$F5C4.
  $F5A1,$03 The player 1 score text.
  $F5A4,$03 The player 2 score text.
  $F5A7,$02 #REGb=#N$10.
  $F5A9,$03 Call #R$F5C4.
  $F5AC,$03 The current player.
  $F5AF,$03 Return if #REGa is #N$99.
  $F5B2,$02,b$01 Flip the bits of #REGa that are set in #N$01.
  $F5B4,$03 The other player is now up.
  $F5B7,$03 Call #R$F4EE.
  $F5BA,$02 #REGb=#N$08.
@ $F5BC label=SwapPlayers_Delay
  $F5BC,$03 Call #R$A802.
  $F5BF,$02 Decrease #REGb and jump to #R$F5BC until none remain.
  $F5C1,$03 Jump to #R$9F2C.

c $F5C4 Swap Bytes
@ $F5C4 label=SwapBytes
D $F5C4 Swaps two blocks of memory.
E $F5C4 View the equivalent code in;
. #LIST
. { #BUBBLER$A2E6 }
. LIST#
R $F5C4 B Number of bytes
R $F5C4 DE Address of the first block
R $F5C4 HL Address of the second block
  $F5C4,$01 Read #REGhl into #REGc.
  $F5C5,$01 Read #REGde.
  $F5C6,$01 Write #REGa where #REGhl points.
  $F5C7,$01 #REGa=#REGc.
  $F5C8,$01 Write #REGa where #REGde points.
  $F5C9,$01 Advance #REGhl.
  $F5CA,$01 Advance #REGde.
  $F5CB,$02 Decrease #REGb and jump to #R$F5C4 until none remain.
  $F5CD,$01 Return.

b $F5CE Text: Game Over
@ $F5CE label=TextGameOver
D $F5CE The text record for the words GAME OVER.
B $F5CE,$04,$04
B $F5D2,$09,$09 "GAME OVER"

b $F5DB Text: Player
@ $F5DB label=TextPlayer
D $F5DB The text record for the number of the player. The last character, which
. is changed by #R$F4EE, is the digit one or two.
B $F5DB,$04,$04
B $F5DF,$08,$08 "PLAYER 1"

g $F5E7 Current Player State
@ $F5E7 label=CurrentPlayerState
D $F5E7 The state of the player who is up. The state of the other player is at
. #R$F650 in the same layout, and #R$F591 swaps the two.
B $F5E7,$03,$03 Score (binary coded decimal, see #R$925E)
@ $F5EA label=CurrentPlayerState_MapCells
B $F5EA,$03,$03 Bitmap of map cells (see #R$ABF3)
B $F5ED,$01,$01 Ships that are left
@ $F5EE label=CurrentPlayerState_Parts
B $F5EE,$09,$01 Flags for the parts that have been fitted to the ship
B $F5F7,$01,$01 Set when item number #N($09) has been picked up (see #R$C1CE)
B $F5F8,$01,$01 Not used
B $F5F9,$01,$01 Planet number, from #N($00) to #N($04)
B $F5FA,$01,$01 Map column of the position that the ship restarts at
B $F5FB,$01,$01 Map row of the position that the ship restarts at
B $F5FC,$02,$01 Position of the ship: horizontal then vertical
B $F5FE,$02,$01 Scroll offsets: horizontal then vertical
B $F600,$01,$01 Height of the stack of units that the ship carries
B $F601,$01,$01 Item that is being carried, or #N($FF) if there is none
B $F602,$01,$01 Number of crystals
B $F603,$01,$01 Control device: keyboard, Kempston, Cursor or Interface 2

g $F604 Item Sites
@ $F604 label=ItemSites
D $F604 Nineteen sites for items, of four bytes each, that #R$6113 chooses. The
. sites are the map column, the map row, and the horizontal and vertical
. positions. The first eleven are for parts and the others for items. The first
. byte of a site that has been taken has bit 7 set.
B $F604,$24,$04
@ $F628 label=ItemSites_Tenth
B $F628,$04,$04
@ $F62C label=ItemSites_Eleventh
B $F62C,$04,$04
@ $F630 label=ItemSites_Twelfth
B $F630,$1C,$04
@ $F64C label=ItemSites_Nineteenth
B $F64C,$04,$04

g $F650 Other Player State
@ $F650 label=OtherPlayerState
D $F650 The state of the other player, in the same layout as #R$F5E7.
B $F650,$1D,$08
@ $F66D label=OtherPlayerState_ItemSites
B $F66D,$4C,$04

g $F6B9 Ship Work Area
@ $F6B9 label=ShipWorkArea
D $F6B9 Cleared by #R$DCA1 at the start of each life. #R$AFE9 builds the
. graphic of the ship from #R$C891 at #R$F755.
B $F6B9,$01,$01
@ $F6BA label=ShipWorkArea_Carried
B $F6BA,$01,$01
@ $F6BB label=ShipWorkArea_Stack
B $F6BB,$1C,$07
@ $F6D7 label=ShipWorkArea_Right
B $F6D7,$7E,$07
@ $F755 label=ShipWorkArea_ShipGraphic
B $F755,$54,$06
B $F7A9,$42,$10

c $F7EB Build Shape Tables
@ $F7EB label=BuildShapeTables
D $F7EB Builds the shifted copies of the descriptions of the ground textures
. (see #R$E581). Each description is merged into three buffers, shifted by two,
. four and six pixels to the right, so that the terrain can be drawn at any
. horizontal pixel position. Those buffers are in #R$E74A to #N$F10E. Four of
. the descriptions are read in the format of #R$F939, two in the format that
. #R$F8E2 handles, and the last three in the format of #R$F939 again with
. #R$5C25 set to #N($FF).
  $F7EB,$03 The working variables start here.
  $F7EE,$02 #REGb=#N$26.
  $F7F0,$03 Call #R$F30B.
  $F7F3,$01 Clear #REGa.
  $F7F4,$03 The shapes are built front to back.
N $F7F7 Make the copies of each description, with the description in #REGhl and
. the buffer for the copies in #REGhl'.
@ $F7F7 label=BuildShapeTables_First
  $F7F7,$03 The shifted shapes one.
  $F7FA,$01 Switch to the alternate registers.
  $F7FB,$03 The fourth shape description.
  $F7FE,$03 Call #R$F939.
  $F801,$03 The shifted shapes two.
  $F804,$01 Switch to the alternate registers.
  $F805,$03 The sixth shape description.
  $F808,$03 Call #R$F939.
  $F80B,$03 The shifted shapes three.
  $F80E,$01 Switch to the alternate registers.
  $F80F,$03 The eighth shape description.
  $F812,$03 Call #R$F939.
  $F815,$03 The shifted shapes six.
  $F818,$01 Switch to the alternate registers.
  $F819,$03 The shape description.
  $F81C,$03 Call #R$F939.
  $F81F,$03 The shifted shapes four.
  $F822,$01 Switch to the alternate registers.
N $F823 The next two descriptions use the other format.
  $F823,$03 The shape descriptions.
  $F826,$03 Call #R$F8E2.
  $F829,$03 The shifted shapes five.
  $F82C,$01 Switch to the alternate registers.
  $F82D,$03 The second shape description.
  $F830,$03 Call #R$F8E2.
N $F833 The last three descriptions are built with the flag at #R$5C25 set.
  $F833,$02,b$01 Set the bits of #REGa that are set in #N$FF.
  $F835,$03 The last shapes are built back to front.
  $F838,$03 The shifted shapes seven.
  $F83B,$01 Switch to the alternate registers.
  $F83C,$03 The third shape description.
  $F83F,$03 Call #R$F939.
  $F842,$03 The shifted shapes eight.
  $F845,$01 Switch to the alternate registers.
  $F846,$03 The fifth shape description.
  $F849,$03 Call #R$F939.
  $F84C,$03 The shifted shapes nine.
  $F84F,$01 Switch to the alternate registers.
  $F850,$03 The seventh shape description.
  $F853,$03 Jump to #R$F939.

c $F856 Build Reverse Table
@ $F856 label=BuildReverseTable
D $F856 Builds the table at #N$F900 of every byte with its bits in reverse
. order, indexed by the byte. The drawing routines use it to draw tiles back to
. front. The table overwrites the routine at #R$F8FD onwards, which is no
. longer needed once the shape tables have been built.
  $F856,$02 Clear #REGc.
  $F858,$03 The next shifted shape.
@ $F85B label=BuildReverseTable_Loop
  $F85B,$02 #REGb=#N$08.
  $F85D,$01 #REGd=#REGc.
  $F85E,$01 Clear #REGa.
@ $F85F label=BuildReverseTable_Bits
  $F85F,$02 Shift #REGd left.
  $F861,$02 Rotate #REGa right through the carry.
  $F863,$02 Decrease #REGb and jump to #R$F85F until none remain.
  $F865,$01 Write #REGa where #REGhl points.
  $F866,$01 Advance #REGhl.
  $F867,$01 Advance #REGc.
  $F868,$02 Jump to #R$F85B if the zero flag is clear.
  $F86A,$01 Return.

c $F86B Build Tables
@ $F86B label=BuildTables
D $F86B Builds the tables that the game needs before it can start. First it
. makes the tables at #R$FA00 of every byte shifted two, four and six bits to
. the right, as a pair of bytes. A page holds the first byte of every shifted
. value and the page after holds the second byte. Then it builds the shape
. tables with #R$F7EB and the table of reversed bytes with #R$F856.
  $F86B,$03 The shift tables.
  $F86E,$02 #REGb=#N$02.
@ $F870 label=BuildTables_Shift
  $F870,$02 Clear #REGc.
@ $F872 label=BuildTables_Byte
  $F872,$01 #REGd=#REGc.
  $F873,$02 Clear #REGe.
  $F875,$01 #REGa=#REGb.
@ $F876 label=BuildTables_Bits
  $F876,$02 Shift #REGd right.
  $F878,$02 Rotate #REGe right through the carry.
  $F87A,$01 Step #REGa back.
  $F87B,$02 Jump to #R$F876 if the zero flag is clear.
  $F87D,$01 Write #REGd where #REGhl points.
  $F87E,$01 Advance #REGh.
  $F87F,$01 Write #REGe where #REGhl points.
@ $F880 label=BuildTables_Buffer
  $F880,$01 Step #REGh back.
  $F881,$01 Advance #REGhl.
  $F882,$01 Advance #REGc.
  $F883,$01 #REGa=#REGc.
  $F884,$03 Jump to #R$F872 if #REGa is not zero.
  $F887,$01 Advance #REGh.
  $F888,$01 Advance #REGb.
  $F889,$01 Advance #REGb.
  $F88A,$01 #REGa=#REGb.
  $F88B,$04 Jump to #R$F870 if #REGa is not #N$08.
  $F88F,$03 Call #R$F7EB.
  $F892,$03 Jump to #R$F856.

c $F895 Read Shape Header
@ $F895 label=ReadShapeHeader
D $F895 Reads the header of a description of a shape and sets up the counters
. that the routines at #R$F8E2 and #R$F939 use. The first byte is the number of
. strips, which is stored in #R$5C1E and #R$5C1F. The second byte is the number
. of rows, which is stored in #R$5C1C and #R$5C1D. The third byte is the number
. of bytes in a row. The entry point at #R$F89D skips the first byte.
R $F895 HL Address of the description
R $F895 O:HL Address of the first byte after the header
R $F895 O:C Number of bytes in a row
R $F895 O:D #N($FA), the page of the table of bytes shifted by two pixels
  $F895,$01 Read #REGhl.
  $F896,$03 The number of strips.
  $F899,$03 The number of strips.
  $F89C,$01 Advance #REGhl.
@ $F89D label=ReadShapeHeader_Rows
  $F89D,$01 Read #REGhl.
  $F89E,$03 The number of rows.
  $F8A1,$03 The number of rows.
  $F8A4,$01 Advance #REGhl.
  $F8A5,$02 #REGd=#N$FA.
  $F8A7,$01 Read #REGhl into #REGc.
  $F8A8,$01 Advance #REGhl.
  $F8A9,$01 Return.

c $F8AA Merge Shifted Byte
@ $F8AA label=MergeShiftedByte
D $F8AA Merges a byte of a shape into the buffer, shifted to the right by the
. number of pixels that the table in #REGd gives. The shifted byte is two
. bytes: the first is ORed into the byte at #REGhl' and the second into the one
. after it.
R $F8AA D Page of the table of shifted bytes
R $F8AA HL Address of the byte to shift
R $F8AA HL' Address in the buffer
R $F8AA O:HL' Address of the second byte that was merged
  $F8AA,$01 Read #REGhl into #REGe.
  $F8AB,$01 Read #REGde.
  $F8AC,$01 Switch to the alternate registers.
  $F8AD,$01 Set the bits of #REGa that are set in the byte at #REGhl.
  $F8AE,$01 Write #REGa where #REGhl points.
  $F8AF,$01 Advance #REGhl.
  $F8B0,$01 Switch to the alternate registers.
  $F8B1,$01 Advance #REGd.
  $F8B2,$01 Read #REGde.
  $F8B3,$01 Step #REGd back.
  $F8B4,$01 Switch to the alternate registers.
  $F8B5,$01 Set the bits of #REGa that are set in the byte at #REGhl.
  $F8B6,$01 Write #REGa where #REGhl points.
  $F8B7,$01 Switch to the alternate registers.
  $F8B8,$01 Return.

c $F8B9 Merge Background Byte
@ $F8B9 label=MergeBackgroundByte
D $F8B9 Merges one byte of the chequered background into the buffer: the
. pattern byte of #N($55), shifted by the amount that the table in #REGd gives.
. The entry point at #R$F8BC merges #REGa.
R $F8B9 D Page of the table of shifted bytes
R $F8B9 HL' Address in the buffer
R $F8B9 O:HL' Address of the next byte in the buffer
  $F8B9,$02 #REGe=#N$55.
  $F8BB,$01 Read #REGde.
@ $F8BC label=MergeBackgroundByte_Merge
  $F8BC,$01 Switch to the alternate registers.
@ $F8BD label=MergeBackgroundByte_Store
  $F8BD,$01 Set the bits of #REGa that are set in the byte at #REGhl.
  $F8BE,$01 Write #REGa where #REGhl points.
  $F8BF,$01 Advance #REGhl.
  $F8C0,$01 Switch to the alternate registers.
  $F8C1,$01 Return.

c $F8C2 Fetch Shifted Byte
@ $F8C2 label=FetchShiftedByte
D $F8C2 Finds the second byte of a byte of a shape that has been shifted to the
. right. The entry point at #R$F8C3 first sets the byte count to the width of a
. row and the one at #R$F8C4 does not change #REGhl.
R $F8C2 C Number of bytes in a row
R $F8C2 D Page of the table of shifted bytes
R $F8C2 HL Address of the byte to shift
R $F8C2 O:A The second byte of the shifted byte
  $F8C2,$01 Advance #REGhl.
@ $F8C3 label=FetchShiftedByte_Count
  $F8C3,$01 #REGb=#REGc.
@ $F8C4 label=FetchShiftedByte_Byte
  $F8C4,$01 Read #REGhl into #REGe.
  $F8C5,$01 Advance #REGd.
  $F8C6,$01 Read #REGde.
  $F8C7,$01 Step #REGd back.
  $F8C8,$01 Return.

c $F8C9 Merge Next Shifted Byte
@ $F8C9 label=MergeNextShiftedByte
D $F8C9 Moves on to the next byte of a shape and merges the first byte of the
. shifted value of the byte that was fetched. The entry point at #R$F8CB merges
. #REGa.
R $F8C9 DE Address in the table of shifted bytes
R $F8C9 HL Address of the byte of the shape
R $F8C9 HL' Address in the buffer
R $F8C9 O:HL Address of the next byte of the shape
  $F8C9,$01 Advance #REGhl.
  $F8CA,$01 Read #REGde.
@ $F8CB label=MergeNextShiftedByte_Merge
  $F8CB,$01 Switch to the alternate registers.
  $F8CC,$01 Set the bits of #REGa that are set in the byte at #REGhl.
  $F8CD,$01 Write #REGa where #REGhl points.
  $F8CE,$01 Switch to the alternate registers.
  $F8CF,$01 Return.

c $F8D0 Next Shift
@ $F8D0 label=NextShift
D $F8D0 Moves on to the table for the next shift: it restores the strip and row
. counters from their copies and adds two to the page of the table. The Z flag
. is set when there are no more tables.
R $F8D0 D Page of the table of shifted bytes
R $F8D0 O:D Page of the table for the next shift
R $F8D0 O:F The Z flag is set after the shift by six pixels
  $F8D0,$03 The number of strips.
  $F8D3,$03 The number of strips.
@ $F8D6 label=NextShift_Rows
  $F8D6,$03 The number of rows.
  $F8D9,$03 The number of rows.
  $F8DC,$01 #REGa=#REGd.
  $F8DD,$02 Add #N$02 to #REGa.
  $F8DF,$01 #REGd=#REGa.
  $F8E0,$01 Is #REGa zero?
  $F8E1,$01 Return.

c $F8E2 Build Shifted Shape A
@ $F8E2 label=BuildShiftedShapeA
D $F8E2 Merges a description of a shape into the buffers, once for each of the
. three shifts, using the first of the two formats. The description starts with
. the number of rows and the number of bytes in a row; the rows follow. Each
. row is merged into the buffer, with the byte that is left over at the end of
. the row from the shifted bytes, and the buffer moves on #N($30) bytes after
. each shift.
R $F8E2 HL Address of the description
R $F8E2 HL' Address of the buffer for the shifted shape
  $F8E2,$03 Call #R$F89D.
@ $F8E5 label=BuildShiftedShapeA_Shift
  $F8E5,$01 Stash #REGhl on the stack.
@ $F8E6 label=BuildShiftedShapeA_Row
  $F8E6,$01 #REGb=#REGc.
  $F8E7,$01 Advance #REGb.
@ $F8E8 label=BuildShiftedShapeA_Merge
  $F8E8,$03 Call #R$F8AA.
  $F8EB,$01 Advance #REGhl.
  $F8EC,$02 Decrease #REGb and jump to #R$F8E8 until none remain.
  $F8EE,$01 Switch to the alternate registers.
  $F8EF,$02 Store #N$00 at the address in #REGhl.
  $F8F1,$01 Step #REGhl back.
  $F8F2,$01 Step #REGhl back.
  $F8F3,$01 Step #REGhl back.
  $F8F4,$01 Set the bits of #REGa that are set in the byte at #REGhl.
  $F8F5,$01 Write #REGa where #REGhl points.
  $F8F6,$01 Advance #REGhl.
  $F8F7,$01 Advance #REGhl.
  $F8F8,$01 Advance #REGhl.
  $F8F9,$01 Switch to the alternate registers.
  $F8FA,$03 Call #R$F8C3.
  $F8FD,$03 Update the segments still to draw.
@ $F900 label=BuildShiftedShapeA_Next
  $F900,$01 Advance #REGb.
@ $F901 label=BuildShiftedShapeA_Loop
  $F901,$03 Call #R$F8C9.
  $F904,$03 Call #R$F8C4.
  $F907,$03 Call #R$F8BC.
  $F90A,$02 Decrease #REGb and jump to #R$F901 until none remain.
  $F90C,$01 Advance #REGd.
  $F90D,$01 Read #REGde.
  $F90E,$01 Step #REGd back.
  $F90F,$01 Switch to the alternate registers.
  $F910,$01 Step #REGhl back.
  $F911,$01 Flip the bits of #REGa that are set in the byte at #REGhl.
  $F912,$01 Write #REGa where #REGhl points.
  $F913,$03 The segments still to draw.
  $F916,$03 Call #R$F8BD.
  $F919,$03 The number of rows.
  $F91C,$01 Step #REGa back.
  $F91D,$03 One fewer row of the shifted shape.
  $F920,$02 Jump to #R$F8E6 if the zero flag is clear.
  $F922,$03 Call #R$F8D6.
  $F925,$01 Switch to the alternate registers.
  $F926,$03 #REGde=#N$30.
  $F929,$01 #REGhl gains #REGde.
  $F92A,$01 Switch to the alternate registers.
  $F92B,$01 Bring #REGhl back off the stack.
  $F92C,$02 Jump to #R$F8E5 if the zero flag is clear.
  $F92E,$02 #REGa=#N$5C.
  $F930,$03 Purpose not yet known.
  $F933,$02 #REGa=#N$40.
  $F935,$03 Purpose not yet known.
  $F938,$01 Return.

c $F939 Build Shifted Shape B
@ $F939 label=BuildShiftedShapeB
D $F939 Merges a description of a shape into the buffers, once for each of the
. three shifts, using the second format. The description starts with the number
. of strips, the number of rows and the number of bytes in a row. Each row is
. merged into the buffer next to the chequered background. When the flag at
. #R$5C25 is set the background is merged differently, as the shape is back to
. front.
R $F939 HL Address of the description
R $F939 HL' Address of the buffer for the shifted shape
  $F939,$03 Call #R$F895.
@ $F93C label=BuildShiftedShapeB_Shift
  $F93C,$01 Stash #REGhl on the stack.
@ $F93D label=BuildShiftedShapeB_Row
  $F93D,$01 #REGb=#REGc.
  $F93E,$03 The back-to-front flag.
  $F941,$03 Jump to #R$F94D if #REGa is zero.
  $F944,$02 #REGe=#N$55.
  $F946,$01 Advance #REGd.
  $F947,$01 Read #REGde.
  $F948,$01 Step #REGd back.
  $F949,$01 Switch to the alternate registers.
  $F94A,$01 Set the bits of #REGa that are set in the byte at #REGhl.
  $F94B,$01 Write #REGa where #REGhl points.
  $F94C,$01 Switch to the alternate registers.
@ $F94D label=BuildShiftedShapeB_Merge
  $F94D,$03 Call #R$F8AA.
  $F950,$01 Advance #REGhl.
  $F951,$02 Decrease #REGb and jump to #R$F94D until none remain.
  $F953,$03 The back-to-front flag.
  $F956,$03 Jump to #R$F95E if #REGa is zero.
  $F959,$01 Switch to the alternate registers.
  $F95A,$01 Advance #REGhl.
  $F95B,$01 Switch to the alternate registers.
  $F95C,$02 Jump to #R$F961.
@ $F95E label=BuildShiftedShapeB_Background
  $F95E,$03 Call #R$F8B9.
@ $F961 label=BuildShiftedShapeB_Strip
  $F961,$03 The strips still to merge.
  $F964,$01 Step #REGa back.
  $F965,$03 The strips still to merge.
  $F968,$02 Jump to #R$F996 if the zero flag is set.
  $F96A,$03 The back-to-front flag.
  $F96D,$03 Jump to #R$F976 if #REGa is not zero.
  $F970,$02 #REGe=#N$AA.
  $F972,$01 Read #REGde.
  $F973,$03 Call #R$F8CB.
@ $F976 label=BuildShiftedShapeB_Second
  $F976,$01 #REGb=#REGc.
@ $F977 label=BuildShiftedShapeB_Bytes
  $F977,$03 Call #R$F8C4.
  $F97A,$03 Call #R$F8BC.
  $F97D,$03 Call #R$F8C9.
  $F980,$02 Decrease #REGb and jump to #R$F977 until none remain.
  $F982,$03 The back-to-front flag.
  $F985,$01 Is #REGa zero?
  $F986,$01 Switch to the alternate registers.
  $F987,$02 Jump to #R$F992 if the zero flag is set.
  $F989,$01 Switch to the alternate registers.
  $F98A,$02 #REGe=#N$AA.
  $F98C,$01 Advance #REGd.
  $F98D,$01 Read #REGde.
  $F98E,$01 Step #REGd back.
  $F98F,$01 Switch to the alternate registers.
  $F990,$01 Set the bits of #REGa that are set in the byte at #REGhl.
  $F991,$01 Write #REGa where #REGhl points.
@ $F992 label=BuildShiftedShapeB_Advance
  $F992,$01 Advance #REGhl.
  $F993,$01 Switch to the alternate registers.
  $F994,$02 Jump to #R$F99C.
@ $F996 label=BuildShiftedShapeB_Reload
  $F996,$03 The number of strips.
  $F999,$03 The number of strips.
@ $F99C label=BuildShiftedShapeB_Count
  $F99C,$03 The rows still to merge.
  $F99F,$01 Step #REGa back.
  $F9A0,$03 The rows still to merge.
  $F9A3,$02 Jump to #R$F93D if the zero flag is clear.
  $F9A5,$01 Bring #REGhl back off the stack.
  $F9A6,$03 Call #R$F8D0.
  $F9A9,$02 Jump to #R$F93C if the zero flag is clear.
  $F9AB,$01 Return.

s $F9AC Unused
S $F9AC,$54,$54

g $FA00 Shift Tables
@ $FA00 label=ShiftTables
D $FA00 Tables of shifted bytes built by #R$F86B when the game starts, used by
. the sprite drawing routines. The first table holds two pages of two byte
. values for each of the shifts by two, four and six bits. The contents at the
. time of the snapshot are left over from loading and are replaced when the
. tables are built.
B $FA00,$200,$10

c $FC00 Copy Game Down
@ $FC00 label=CopyGameDown
D $FC00 Used by the loader before the game starts: #R$5B80 calls this routine
. to move the encrypted game from #N$5E80 down to #N$5C80. The helper at
. #R$6000@loader copies it here from #R$6022@loader. The routine is in the
. area of memory where the shift tables are built afterwards, so it is
. overwritten when the game starts.
  $FC00,$03 Set the source address in #REGhl.
  $FC03,$03 Set the destination address in #REGde.
  $FC06,$03 Set the number of bytes to copy in #REGbc.
  $FC09,$02 Copy the game down.
  $FC0B,$01 Return.
N $FC0C The next four bytes are not used.
  $FC0C,$03 Set the stack pointer to #N$FE00.
  $FC0F,$01 Disable interrupts.

g $FC10 Shift Tables (continued)
D $FC10 The rest of the shift tables.
B $FC10,$3F0,$10
