; Copyright Ashby Computers & Graphics Ltd 1987, Rare Ltd, 2026 ArcadeGeek LTD.
> $4000 @org=$4000
> $4000 @rom
> $4000 @start=$5E00
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))
> $4000 @set-handle-unsupported-macros=1
b $4000 Loading screen
@ $4000 label=Loading
D $4000 #UDGTABLE { =h Bubbler Loading Screen } { #SCR$02(loading) } UDGTABLE#
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

g $5CB8 Title Animation Frame
@ $5CB8 label=TitleAnimationFrame
D $5CB8 The frame of the highlight animation of the title menu, which is set to
. #N$00 by #R$60FE(#N$6148) and used by #R$60FE(#N$61D3).
B $5CB8,$01

g $5CB9 Cell Position
@ $5CB9 label=CellPosition
D $5CB9 In the game, this is the position of the cell of the level whose objects
. are being drawn, which is set by #R$BB0F and used by #R$BB3C. On the title
. menu, the first byte is the low byte of the address of the attribute that is
. highlighted (see #R$60FE(#N$6150)) and the second byte is the last value of
. FRAMES that was seen (see #R$61BD).
B $5CB9,$02,$01

g $5CBB Strip Address
@ $5CBB label=StripAddress
D $5CBB The address in the view buffer of the strip that is being built by
. #R$AA5B, which is used when the blocks are drawn and is changed by the
. routines that scroll the view.
W $5CBB,$02,$02

i $5CBD

g $5CD8 Scratch Value
@ $5CD8 label=ScratchValue
D $5CD8 A value that is used for several purposes. The heading of the player is
. kept here, which is shown by #R$A724. The stack pointer is saved here by
. #R$A8D1 and #R$A8E1. Purpose of the other uses is not yet known.
W $5CD8,$02,$02

g $5CDA Saved Stack Pointer
@ $5CDA label=SavedStackPointer
D $5CDA The stack pointer is kept here while the drawing routines use it to read
. data, for example #R$B43C and #R$C59A(#N$C5E5).
W $5CDA,$02,$02

g $5CDC Drawing Position
@ $5CDC label=DrawingPosition
D $5CDC A word that is used for several purposes, including the details of the
. record that is added by #R$B1FF and the position of the tip of the needle of
. the direction gauge (see #R$A724). Purpose of the other uses is not yet
. known.
W $5CDC,$02,$02

g $5CDE Game Variable
@ $5CDE label=GameVariable
D $5CDE A byte that is stored by #R$AB0F(#N$AB21) and used by #R$5F9E(#N$5FA9)
. and #R$CDF8. Purpose not yet known.
B $5CDE,$01

i $5CDF

g $5CE2 View Position
@ $5CE2 label=ViewPosition
D $5CE2 The position of the view, as two words. It is set by #R$86F9 when a
. level is started and is changed when the view is moved (see #R$B8F9). The
. high bytes at #N$5CE3 and #N$5CE5 are used by #R$BB0F as the position of the
. player.
W $5CE2,$02,$02
W $5CE4,$02,$02

g $5CE6 View Flags
@ $5CE6 label=ViewFlags
D $5CE6 The flags that record which way the view is scrolling. They are set by
. the scroll routines and tested by #R$CC71. Bits 0-1 scroll left, bits 2-3
. scroll right, bits 4-5 scroll down and bits 6-7 scroll up. #N$01 in a pair is
. one pixel a frame and #N$02 is two pixels.
B $5CE6,$01

g $5CE7 View Origin Sum
@ $5CE7 label=ViewOriginSum
D $5CE7 The sum of the two values of the position of the view plus #N$80, which
. is worked out by #R$AA5B. It is used with #R$5CEE as the origin of the view
. on the screen when the position of an entity is worked out by #R$AE0D.
W $5CE7,$02,$02

g $5CE9 Scroll Value
@ $5CE9 label=ScrollValue
D $5CE9 A byte that is used by the routines that scroll the view (see #R$C7E8
. and #R$C873) and by #R$E461(#N$E463). Purpose not yet known.
B $5CE9,$01

g $5CEA Entity Speed
@ $5CEA label=EntitySpeed
D $5CEA The speed of the entity that is being moved. Its high byte is multiplied
. by the direction by #R$CF5B.
W $5CEA,$02,$02

g $5CEC Player Screen Position
@ $5CEC label=PlayerScreenPosition
D $5CEC The previous value of the screen position of the player, which is kept
. by #R$ADF9, followed by the change in the value.
B $5CEC,$01
B $5CED,$01

g $5CEE View Origin Difference
@ $5CEE label=ViewOriginDifference
D $5CEE The difference of the halves of the two values of the position of the
. view, which is worked out by #R$AA5B. It is used with #R$5CE7 as the origin
. of the view on the screen.
W $5CEE,$02,$02

g $5CF0 Drawing Flags
@ $5CF0 label=DrawingFlags
D $5CF0 The flags that are used when blocks are drawn. If bits 1 and 2 are zero
. then #R$C76D draws the bytes of a row plain, and otherwise it shifts them.
. Purpose of the other bits is not yet known.
B $5CF0,$01

g $5CF1 Saved IY
@ $5CF1 label=SavedIY
D $5CF1 The value of #REGiy that is saved by #R$5E00(#N$5E04), because the ROM
. interrupt routine needs it to point at the system variables. It is restored
. whenever the ROM is used.
W $5CF1,$02,$02

g $5CF3 Record Details
@ $5CF3 label=RecordDetails
D $5CF3 Details of the record that is being added by #R$B1FF and of the object
. that is being drawn, which include the sizes that are used by #R$B9F3.
. Purpose of the individual bytes is not yet known.
B $5CF3,$03,$01

g $5CF6 Turning Rate
@ $5CF6 label=TurningRate
D $5CF6 The rate of turning of the player, which builds up while a turn control
. is held (see #R$AB0F).
W $5CF6,$02,$02

i $5CF8

g $5CFE Level Header Address
@ $5CFE label=LevelHeaderAddress
D $5CFE The address of the header of the data of the current level, which is set
. by #R$86F9 and used to find the map and the path entries (see #R$87D3).
W $5CFE,$02,$02

g $5D00 Jump Counter
@ $5D00 label=JumpCounter
D $5D00 The counter that is used for the player jumping and for the death of the
. player (see #R$CD11). Purpose of its values is not yet known.
B $5D00,$01

i $5D01

c $5E00 Game Entry
@ $5E00 label=GameEntry
D $5E00 The entry point of the game, started by the loader. It moves the title
. sequence code and graphics out of the way, runs the title sequence and then
. builds three lookup tables for the sprite routines before handing over to the
. game proper at #R$DFF0.
.
. The title sequence (the code at #N$F512) does not return by itself: when a key
. is pressed it leaves through #R$E42F, which ends by returning to the
. instruction after the call at #N$5E27.
N $5E00 Set up the machine.
  $5E00,$01 Disable interrupts.
  $5E01,$03 Put the stack just below the game variables.
  $5E04,$04 Remember #REGiy in #R$5CF1, as the ROM interrupt routine needs it to
. point at the system variables.
  $5E08,$03 Set the border colour to black.
N $5E0B Move the title sequence out of the game data.
  $5E0B,$03 #REGde is #N$F500 (the destination).
  $5E0E,$03 Set #REGhl to #R$E5BB (the source).
  $5E11,$03 #REGbc is #N$0200 (the number of bytes to copy).
  $5E14,$02 Copy the title sequence code.
  $5E16,$03 #REGde is #N$F700 (the destination).
  $5E19,$03 Set #REGhl to #R$E5BB(#N$E696) (the source).
  $5E1C,$03 #REGbc is #N$0800 (the number of bytes to copy).
  $5E1F,$02 Copy the title sequence graphics.
N $5E21 Run the title sequence.
  $5E21,$03 Call #R$A8E1 to clear the pixels of the screen.
  $5E24,$03 Call #R$A8D1 to set the attributes of the lower two thirds of the
. screen to bright white on black.
  $5E27,$03 Call the title sequence.
N $5E2A Build the bit reversal table at #N$F900.
  $5E2A,$03 #REGhl is #N$F900 (the start of the table).
  $5E2D,$02 Set the table index in #REGc to #N$00.
@ $5E2F label=GameEntry_BuildReverseTable
  $5E2F,$02 Set the bit counter in #REGb to #N$08.
  $5E31,$01 Copy the table index into #REGd.
  $5E32,$01 Clear the reversed value in #REGa.
@ $5E33 label=GameEntry_ReverseBits
  $5E33,$02 Shift the top bit of #REGd out into the carry flag.
  $5E35,$02 Rotate the carry flag into the top of the reversed value.
  $5E37,$02 Decrease the bit counter by one and loop back to #R$5E33 until all
. eight bits have been reversed.
  $5E39,$01 Store the reversed value in the table.
  $5E3A,$01 Move onto the next table entry.
  $5E3B,$01 Move onto the next table index.
  $5E3C,$02 Jump back to #R$5E2F until all #N$0100 entries have been written.
N $5E3E Build the three pairs of shift tables at #N$FA00, #N$FC00 and #N$FE00.
. For every byte value, the first table of a pair holds the byte shifted right
. and inverted, and the second table holds the inverted bits which were shifted
. out. The shifts are two, four and six pixels.
  $5E3E,$02 Start with a shift of two pixels.
@ $5E40 label=GameEntry_BuildShiftTables
  $5E40,$02 Start with the byte value #N$00.
@ $5E42 label=GameEntry_BuildShiftEntry
  $5E42,$01 Copy the byte value into #REGd.
  $5E43,$01 Copy the shift count into #REGe.
  $5E44,$01 Clear the bits which are shifted out, in #REGa.
@ $5E45 label=GameEntry_ShiftByte
  $5E45,$02 Shift #REGd right by one pixel.
  $5E47,$02 Rotate the bit which fell off into the top of #REGa.
  $5E49,$03 Decrease the shift count by one and loop back to #R$5E45 until the
. byte has been shifted.
  $5E4C,$01 Move onto the second table of the pair.
  $5E4D,$01 Invert the bits which were shifted out.
  $5E4E,$01 Store them in the second table.
  $5E4F,$01 Go back to the first table of the pair.
  $5E50,$01 Fetch the shifted byte.
  $5E51,$01 Invert it.
  $5E52,$01 Store it in the first table.
  $5E53,$01 Move onto the next table entry.
  $5E54,$01 Move onto the next byte value.
  $5E55,$02 Jump back to #R$5E42 until all #N$0100 byte values have been done.
  $5E57,$01 Move past the second table of the pair.
  $5E58,$02 Increase the shift by two pixels.
  $5E5A,$01 Fetch the shift.
  $5E5B,$04 Jump back to #R$5E40 until the shifts of two, four and six pixels
. have all been done.
  $5E5F,$03 Start the game.

b $5E62 Ending Window Fill
@ $5E62 label=EndingWindow_Fill
D $5E62 A rectangle description for #R$AAE8 which blanks the attributes of the
. game window.
B $5E62,$01 Width of the window in characters.
B $5E63,$01 Height of the window in characters.
B $5E64,$01 Attribute: #COLOUR(#PEEK(#PC)).

c $5E65 Show Ending
@ $5E65 label=ShowEnding
D $5E65 Used when all five levels have been completed. It prints the
. congratulation message over the game window, saves the window and clears it,
. and then scrolls the saved picture back in underneath the message. After a
. long pause the message flashes, with a clicking sound which rises in pitch,
. and the window is scrolled away by #R$E42F.
N $5E65 Reset the level number and print the message.
  $5E65,$01 Clear #REGa.
  $5E66,$03 Write #N$00 to #R$DEDF, to make the next game start on the first
. level.
  $5E69,$03 Point #REGde at the rectangle description at #R$5E62.
  $5E6C,$03 Set #REGhl to the position of the bottom left of the game window.
  $5E6F,$03 Call #R$AAE8 to blank the attributes of the game window, so the
. message cannot be seen yet.
  $5E72,$03 Point #REGde at the message at #R$5F0C(#N$5F0F).
  $5E75,$02 Set the number of lines in the message in #REGb to #N$07.
  $5E77,$03 Call #R$E1BD to print the message.
N $5E7A Save the picture in the game window into the view buffer, clearing the
. window as it goes.
  $5E7A,$03 Set #REGhl to the position of the top left of the game window in the
. view buffer.
  $5E7D,$03 Call #R$E59E to find the address in the view buffer.
  $5E80,$01 Move it into #REGde.
  $5E81,$03 Point #REGhl at the top left of the game window on the screen.
  $5E84,$02 Set the scanline counter in #REGc to #N$70.
@ $5E86 label=ShowEnding_SaveLine
  $5E86,$02 Set the line length in #REGb to #N$14 bytes.
  $5E88,$01 Stash the screen address on the stack.
@ $5E89 label=ShowEnding_SaveByte
  $5E89,$01 Fetch a byte of the screen.
  $5E8A,$01 Store it in the view buffer.
  $5E8B,$02 Clear the byte of the screen.
  $5E8D,$01 Move onto the next byte of the screen.
  $5E8E,$01 Move onto the next byte of the view buffer.
  $5E8F,$02 Decrease the line length by one and loop back to #R$5E89 until the
. whole line has been saved.
  $5E91,$04 Skip the four unused bytes at the end of the line in the view
. buffer.
  $5E95,$01 Restore the screen address.
  $5E96,$01 Move down a scanline.
  $5E97,$05 Jump to #R$5EA6 unless the new scanline is the start of a new
. character row.
  $5E9C,$04 Move onto the next character row.
  $5EA0,$02 Jump to #R$5EA6 if the row is still in the same third of the screen.
  $5EA2,$04 Move into the next third of the screen.
@ $5EA6 label=ShowEnding_NextLine
  $5EA6,$03 Decrease the scanline counter by one and jump back to #R$5E86 until
. all #N$70 scanlines have been saved.
N $5EA9 Make the message visible and scroll the saved picture back in.
  $5EA9,$03 Point #REGde at the rectangle description at #R$5F0C.
  $5EAC,$03 Set #REGhl to the position of the bottom left of the game window.
  $5EAF,$03 Call #R$AAE8 to make the attributes of the game window bright white.
  $5EB2,$03 Call #R$E461 to scroll the saved picture into the window.
N $5EB5 Wait while checking for the pause keys.
  $5EB5,$02 Set the number of long waits in #REGb to #N$02.
@ $5EB7 label=ShowEnding_Wait
  $5EB7,$01 Stash the long wait counter on the stack.
  $5EB8,$03 Start the short wait counter in #REGde at #N$0000.
@ $5EBB label=ShowEnding_WaitLoop
  $5EBB,$01 Stash the short wait counter on the stack.
  $5EBC,$03 Call #R$A837 to check for the pause keys.
  $5EBF,$01 Restore the short wait counter from the stack.
  $5EC0,$01 Decrease the short wait counter by one.
  $5EC1,$04 Jump back to #R$5EBB until the high byte of the counter is zero.
  $5EC5,$01 Restore the long wait counter from the stack.
  $5EC6,$02 Decrease the long wait counter by one and jump back to #R$5EB7 until
. both long waits are over.
N $5EC8 Flash the message.
  $5EC8,$02 Set the flash counter in #REGb to #N$18.
  $5ECA,$04 Bring back #REGiy from #R$5CF1.
@ $5ECE label=ShowEnding_Flash
  $5ECE,$01 Stash the flash counter on the stack.
  $5ECF,$01 Copy the flash counter into #REGa.
  $5ED0,$02 Multiply it by four...
  $5ED2,$03 ...and store it in the operand of the instruction at
. #R$5E65(#N$5EE8).
  $5ED5,$03 Store it in the operand of the instruction at #R$5E65(#N$5EFE) too.
  $5ED8,$04 Write #N$00 to the attribute of the rectangle description at
. #R$5F0C.
N $5EDC Hide the message and click.
  $5EDC,$01 Enable interrupts.
  $5EDD,$01 Wait for the next frame.
  $5EDE,$01 Disable interrupts.
  $5EDF,$03 Set #REGhl to the position of the bottom left of the game window.
  $5EE2,$03 Point #REGde at the rectangle description at #R$5F0C.
  $5EE5,$03 Call #R$AAE8 to make the attributes of the game window black.
  $5EE8,$02 Set the length of the click.
  $5EEA,$03 Call #R$9E93 to click the speaker.
N $5EED Show the message and click.
  $5EED,$01 Enable interrupts.
  $5EEE,$01 Wait for the next frame.
  $5EEF,$01 Disable interrupts.
  $5EF0,$05 Write #N$47 to the attribute of the rectangle description at
. #R$5F0C.
  $5EF5,$03 Set #REGhl to the position of the bottom left of the game window.
  $5EF8,$03 Point #REGde at the rectangle description at #R$5F0C.
  $5EFB,$03 Call #R$AAE8 to make the attributes of the game window bright white.
  $5EFE,$02 Set the length of the click.
  $5F00,$03 Call #R$9E93 to click the speaker.
  $5F03,$03 Call #R$A837 to check for the pause keys.
  $5F06,$01 Restore the flash counter from the stack.
  $5F07,$02 Decrease the flash counter by one and jump back to #R$5ECE until the
. message has flashed #N$18 times.
  $5F09,$03 Jump to #R$E42F to scroll the window away.

b $5F0C Ending Message
@ $5F0C label=EndingMessage
D $5F0C The message shown when the game has been completed.
N $5F0C The rectangle description for #R$AAE8, which makes the attributes of the
. game window bright white.
B $5F0C,$01 Width of the window in characters.
B $5F0D,$01 Height of the window in characters.
B $5F0E,$01 Attribute: #COLOUR(#PEEK(#PC)).
N $5F0F The seven lines of the message, as text records for #R$E1BD.
@ $5F0F label=EndingMessage_Lines
B $5F0F,$02 Position: x=#N$40, y=#N$17.
B $5F11,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $5F12,$01 Length #N$0F, double height.
B $5F13,$0F "CONGRATULATIONS"
B $5F22,$02 Position: x=#N$40, y=#N$27.
B $5F24,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $5F25,$01 Length #N$10.
B $5F26,$10 "YOU HAVE ESCAPED"
B $5F36,$02 Position: x=#N$38, y=#N$37.
B $5F38,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $5F39,$01 Length #N$12.
B $5F3A,$12 "FROM VADRAS PRISON"
B $5F4C,$02 Position: x=#N$38, y=#N$45.
B $5F4E,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $5F4F,$01 Length #N$11.
B $5F50,$11 "YOUR NEXT MISSION"
B $5F61,$02 Position: x=#N$40, y=#N$55.
B $5F63,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $5F64,$01 Length #N$0F.
B $5F65,$0F "IS TO OVERTHROW"
B $5F74,$02 Position: x=#N$38, y=#N$65.
B $5F76,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $5F77,$01 Length #N$12.
B $5F78,$12 "VADRA AND FREE THE"
B $5F8A,$02 Position: x=#N$50, y=#N$75.
B $5F8C,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $5F8D,$01 Length #N$0C.
B $5F8E,$0C "IRKON PEOPLE"

g $5F9A Random Number State
@ $5F9A label=RandomNumber_Seed
D $5F9A The state of the random number generator at #R$5F9E.
W $5F9A,$02 The seed, which changes every time a number is made.
W $5F9C,$02 The address of the next byte of game memory to mix into the seed.

c $5F9E Get Random Number
@ $5F9E label=GetRandomNumber
D $5F9E Makes a pseudo-random number by mixing the byte at a moving address in
. the game memory into a seed. The address moves on by one byte each time and
. wraps within #N$8000-#N$9FFF.
R $5F9E O:A The high byte of the new seed
R $5F9E O:DE The new seed
  $5F9E,$04 Fetch the seed.
  $5FA2,$03 Fetch the address of the byte of game memory to mix in.
N $5FA5 Make the new low byte.
  $5FA5,$01 Fetch the byte of game memory.
  $5FA6,$02 Add #N$05 to it.
  $5FA8,$01 Store the result in #REGb.
  $5FA9,$03 Fetch the game variable at #R$5CDE.
  $5FAC,$01 Add the byte from game memory.
  $5FAD,$01 Add the low byte of the seed.
  $5FAE,$01 Make it the new low byte of the seed.
N $5FAF Make the new high byte.
  $5FAF,$01 Fetch the byte of game memory again.
  $5FB0,$01 Invert it.
  $5FB1,$02 Add #N$16.
  $5FB3,$01 Add the high byte of the seed.
  $5FB4,$01 Add the low byte of the address.
  $5FB5,$01 Make it the new high byte of the seed.
  $5FB6,$04 Store the new seed.
N $5FBA Move the address on.
  $5FBA,$01 Move onto the next byte of game memory.
  $5FBB,$01 Fetch the high byte of the address.
  $5FBC,$02,b$01 Keep the address within #N$8000-#N$9FFF.
  $5FBE,$01 Put the high byte back.
  $5FBF,$03 Store the address.
  $5FC2,$01 Return.

b $5FC3 Title Tune
@ $5FC3 label=TitleTune
D $5FC3 The tune which plays while the title menu is shown, for #R$A1B2. Each
. byte is a note number for the table at #R$A226, with #N$00 being a rest. The
. top two bits of each byte are not used. The tune is ended by #N$FF.
B $5FC3,$84,$10
B $6047,$01 End of the tune.

b $6048 Start Tune
@ $6048 label=StartTune
D $6048 The short tune which plays when the game is started from the title menu,
. for #R$A1C1. It uses the same format as the title tune (see #R$5FC3).
B $6048,$1D,$10
B $6065,$01 End of the tune.

b $6066 Title Logo
@ $6066 label=TitleLogo
D $6066 The BUBBLER logo of the title menu, for #R$AAC4. The rows are stored
. from the bottom of the picture up.
B $6066,$01 Width of the picture in bytes.
B $6067,$01 Height of the picture in rows.
  $6068,$80,$08 #PICTUREDATA(title-logo*)

c $60E8 Leave Title Menu
@ $60E8 label=LeaveTitleMenu
D $60E8 Used when the title menu is finished. It records which control methods
. were chosen and plays the start tune. The tune routine returns to the caller
. of #R$60FE.
. .
. #HTML(#AUDIO0(start-tune.wav)(#INCLUDE(StartTune)))
  $60E8,$01 Disable interrupts.
  $60E9,$03 Fetch the control method chosen for player 1 from #R$627F(#N$6281).
  $60EC,$03 Store it in #R$60FB.
  $60EF,$03 Fetch the control method chosen for player 2 from #R$627F(#N$6284).
  $60F2,$03 Store it in #R$60FC.
  $60F5,$03 Point #REGde at #R$6048.
  $60F8,$03 Jump to #R$A1C1 to play the tune.

g $60FB Player 1 Control Method
@ $60FB label=Player1ControlMethod
D $60FB The control method chosen for player 1 in the title menu: #N$00 for the
. keyboard, #N$01 for a Kempston joystick, #N$02 for a Cursor joystick and #N$03
. for an Interface II joystick.
B $60FB,$01

g $60FC Player 2 Control Method
@ $60FC label=Player2ControlMethod
D $60FC The control method chosen for player 2 in the title menu, which uses the
. same values as #R$60FB.
B $60FC,$01

g $60FD Two Player Flag
@ $60FD label=TwoPlayerFlag
D $60FD Set to #N$01 when the two player game is chosen in the title menu, or
. #N$00 for the one player game.
B $60FD,$01

c $60FE Show Title Menu
@ $60FE label=ShowTitleMenu
D $60FE Draws the title menu and runs it until the player presses "0" to start
. the game. While it waits it plays the title tune, highlights the chosen
. player option and scrolls a message along the bottom of the screen.
. .
. #HTML(#AUDIO0(title-tune.wav)(#INCLUDE(TitleTune)))
. .
. Pressing "A" or "B" chooses a one or two player game. Pressing "1" or "2"
. steps player 1 or player 2 onto the next control method, which moves the
. marker of that player down the list of options.
. .
. #PUSHS #UDGTABLE { #BLANKSCREEN(0)
. #SIM(start=$876B,stop=$0000,sp=$5B60)
. #SIM(start=$60FE,stop=$6170,sp=$5B60)
. #SCR$02(show-title-menu) } UDGTABLE# #POPS
. #PUSHS
. #HTML(<div hidden>)
. #BLANKSCREEN(0)
. #SIM(start=$E2E9,stop=$0000,ix=$6318,sp=$5B60)
. #SCR$02(screen-frame)
. #HTML(</div>)
. #POPS
  $60FE,$03 Set #REGhl to the position for the logo.
  $6101,$03 Point #REGde at #R$6066.
  $6104,$03 Call #R$AAC4 to draw it.
  $6107,$03 #REGhl is #N$FF0E, to write #N$0E to #R$A921 (the scroll counter)
. and #N$FF to #R$A921(#N$A922) (the index of the next character of the
. scrolling message).
  $610A,$03 Write them.
N $610D Copy the scores of the two players into the score boxes of the menu.
  $610D,$03 Point #REGde at the digits of the score of player 1 in the text
. record at #R$63AF(#N$642B).
  $6110,$03 Point #REGhl at the score of player 1 at #R$E132.
  $6113,$03 Set the number of digits in #REGbc to #N$05.
  $6116,$02 Copy the digits.
  $6118,$03 Point #REGde at the digits of the score of player 2 in the text
. record at #R$63AF(#N$6434).
  $611B,$03 Point #REGhl at the score of player 2 at #R$E144.
  $611E,$03 Set the number of digits in #REGbc to #N$05.
  $6121,$02 Copy the digits.
N $6123 Print the text of the menu and draw the frames and decorations.
  $6123,$02 Set the number of text records in #REGb to #N$0D.
  $6125,$03 Point #REGde at the first text record at #R$63AF.
  $6128,$03 Call #R$E1BD to print the text records.
  $612B,$04 Point #REGix at the two frame records at #R$6318.
  $612F,$03 Call #R$E2E9 to draw the first frame (the list of options).
  $6132,$03 Call #R$E2E9 to draw the second frame (the scrolling message).
  $6135,$03 Set #REGhl to the position of the left decoration.
  $6138,$03 Point #REGde at the decoration graphic at #R$6307.
  $613B,$03 Call #R$AAC4 to draw it.
  $613E,$03 Set #REGhl to the position of the right decoration.
  $6141,$03 Point #REGde at the decoration graphic at #R$630D.
  $6144,$03 Call #R$AAC4 to draw it.
N $6147 Draw the two markers and set up the highlight of the player option.
  $6147,$01 Clear #REGa.
  $6148,$03 Write #N$00 to #R$5CB8 (the frame of the highlight animation).
  $614B,$03 Write #N$00 to the attribute at #N$5ADC.
  $614E,$02 #REGa is #N$AE, the low byte of the attribute address of the one
. player option.
  $6150,$03 Write it to #R$5CB9.
  $6153,$03 Fetch the position of the marker of player 1 from #R$627F.
  $6156,$03 Point #REGde at #R$6285.
  $6159,$03 Call #R$AAC4 to draw it.
  $615C,$03 Fetch the position of the marker of player 2 from #R$627F(#N$6282).
  $615F,$03 Point #REGde at #R$62C6.
  $6162,$03 Call #R$AAC4 to draw it.
  $6165,$03 Fetch the number of players chosen.
  $6168,$03 Jump to #R$6170 if one player is chosen.
  $616B,$02 #REGa is #N$EE, the low byte of the attribute address of the two
. player option.
  $616D,$03 Write it to #R$5CB9.
@ $6170 label=ShowTitleMenu_Play
  $6170,$04 Bring back #REGiy from #R$5CF1.
  $6174,$03 Point #REGde at #R$5FC3.
  $6177,$03 Call #R$A1B2 to play it until a key is pressed.
N $617A The main loop of the menu.
@ $617A label=ShowTitleMenu_Loop
  $617A,$01 Enable interrupts.
  $617B,$03 Fetch the low byte of the attribute address of the highlighted
. option.
  $617E,$01 Copy it into #REGl.
  $617F,$04 Jump to #R$6190 if the two player option is highlighted.
  $6183,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | SYMBOL SHIFT | M | N | B }
. TABLE#
  $6188,$02,b$01 Test the bit for "B".
  $618A,$02 Jump to #R$61AB if "B" is not being pressed.
  $618C,$02 Set the two player flag to #N$01.
  $618E,$02 Jump to #R$6199.
@ $6190 label=ShowTitleMenu_TestOnePlayer
  $6190,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FD | A | S | D | F | G }
. TABLE#
  $6195,$01 Test the bit for "A".
  $6196,$02 Jump to #R$61AB if "A" is not being pressed.
  $6198,$01 Set the one player flag to #N$00.
@ $6199 label=ShowTitleMenu_SetPlayers
  $6199,$03 Store the number of players.
  $619C,$01 Fetch the low byte of the old attribute address.
  $619D,$02,b$01 Swap between the two options.
  $619F,$03 Store the new highlighted option.
  $61A2,$02 Point #REGh at the attribute rows.
  $61A4,$02 Set the width of the highlight in #REGb to #N$09.
@ $61A6 label=ShowTitleMenu_ResetHighlight
  $61A6,$02 Set the attribute of the option which is no longer highlighted to
. the normal colour.
  $61A8,$01 Move onto the next attribute.
  $61A9,$02 Decrease the width counter by one and jump back to #R$61A6 until the
. whole option has been reset.
N $61AB Move the markers, if needed.
@ $61AB label=ShowTitleMenu_MoveMarkers
  $61AB,$01 Enable interrupts.
  $61AC,$04 Point #REGix at the record of the marker of player 1 at #R$627F.
  $61B0,$02 #REGe is #N$01, the bit of the "1" key.
  $61B2,$03 Call #R$623F to move the marker of player 1.
  $61B5,$04 Point #REGix at the record of the marker of player 2 at
. #R$627F(#N$6282).
  $61B9,$01 #REGe is #N$02, the bit of the "2" key.
  $61BA,$03 Call #R$623F to move the marker of player 2.
N $61BD Wait for the next frame.
@ $61BD label=ShowTitleMenu_WaitFrame
  $61BD,$03 Fetch the last value of FRAMES that was seen from #R$5CB9(#N$5CBA).
  $61C0,$01 Copy it into #REGb.
  $61C1,$03 Fetch the low byte of FRAMES.
  $61C4,$01 Compare it with the last value.
  $61C5,$02 Jump back to #R$61BD until it has changed.
  $61C7,$03 Store the new value in #R$5CB9(#N$5CBA).
  $61CA,$01 Disable interrupts.
N $61CB Cycle the colours of the highlighted option.
  $61CB,$02 Set the width of the highlight in #REGb to #N$09.
  $61CD,$03 Fetch the low byte of the attribute address of the highlighted
. option.
  $61D0,$01 Copy it into #REGl.
  $61D1,$02 Point #REGh at the attribute rows.
  $61D3,$03 Fetch the animation frame from #R$5CB8.
  $61D6,$01 Decrease it by one.
  $61D7,$02,b$01 Keep only bits 0-2.
  $61D9,$03 Store it.
@ $61DC label=ShowTitleMenu_Highlight
  $61DC,$02,b$01 Make the attribute bright with the ink from #REGa.
  $61DE,$01 Store it.
  $61DF,$01 Move onto the next attribute.
  $61E0,$01 Move onto the next ink colour.
  $61E1,$02,b$01 Keep the ink colour in the range #N$00-#N$07.
  $61E3,$02 Decrease the width counter by one and jump back to #R$61DC until the
. whole option has been done.
N $61E5 Redraw the markers.
  $61E5,$03 Point #REGde at #R$6285.
  $61E8,$03 Fetch the position of the marker of player 1 from #R$627F.
  $61EB,$03 Call #R$AAC4 to draw it.
  $61EE,$03 Point #REGde at #R$62C6.
  $61F1,$03 Fetch the position of the marker of player 2 from #R$627F(#N$6282).
  $61F4,$03 Call #R$AAC4 to draw it.
  $61F7,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $61FC,$01 Rotate the bit for "0" into the carry flag.
  $61FD,$03 Jump to #R$60E8 if "0" is being pressed, to start the game.
N $6200 Scroll the message along the bottom of the screen.
  $6200,$03 Set #REGhl to the position of the right of the new character area.
  $6203,$03 Set the width in #REGb to #N$02 bytes and the height in #REGc to
. #N$07 rows.
  $6206,$03 Call #R$A902 to scroll the new character area left by one pixel.
  $6209,$03 #REGhl is #N$51DC, the screen address of the left of the new
. character area.
  $620C,$01 #REGh moves into #REGd.
  $620D,$02 #REGe is #N$DA, to make the screen address of the right of the
. message frame.
  $620F,$03 Call #R$A588 to copy the pixels of the leftmost byte across.
  $6212,$03 Set #REGhl to the position of the right of the message frame.
  $6215,$03 Set the width in #REGb to #N$16 bytes and the height in #REGc to
. #N$07 rows.
  $6218,$03 Call #R$A902 to scroll the message frame left by one pixel.
  $621B,$02,b$01 Keep only bits 0-3 of the scroll counter.
  $621D,$03 Jump back to #R$617A unless the scroll counter is a multiple of
. #N$10.
N $6220 Add the next character of the message.
  $6220,$03 Fetch the index of the next character of the message from
. #R$A921(#N$A922).
  $6223,$01 Move onto the next character.
  $6224,$04 Jump to #R$6229 if the end of the message has not been reached.
  $6228,$01 Go back to the start of the message.
@ $6229 label=ShowTitleMenu_StoreIndex
  $6229,$03 Store the index.
  $622C,$03 Point #REGhl at the scrolling message at #R$6322.
  $622F,$03 Add the index to find the address of the character.
  $6232,$01 Fetch the character.
  $6233,$03 Store it in the text record at #R$6313.
  $6236,$03 Point #REGde at #R$6313.
  $6239,$03 Call #R$A923 to print the character.
  $623C,$03 Jump back to #R$617A.

c $623F Move Marker
@ $623F label=MoveMarker
D $623F Moves the marker of one player, in the title menu, towards the control
. method option that is chosen. When the marker has reached the option, the key
. of the player ("1" or "2") chooses the next option. The marker moves down by
. one pixel at a time and up by four pixels at a time.
R $623F IX The record of the marker (see #R$627F)
R $623F E The bit of the key of the player: #N$01 for "1" and #N$02 for "2"
  $623F,$04 Fetch the number of the chosen option from the record of the marker
. and keep it in #REGb.
  $6243,$03 Point #REGhl at the table of the vertical positions of the options
. at #R$627B.
  $6246,$03 Add the number of the option to find its position.
  $6249,$01 Fetch the position of the option into #REGc.
  $624A,$01 Copy it into #REGa.
  $624B,$03 Subtract the current position of the marker.
  $624E,$02 Jump to #R$6266 if the marker has not reached the option.
  $6250,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $6255,$01 Test the bit of the key of the player.
  $6256,$02 Jump to #R$6266 if the key is not being pressed.
  $6258,$01 Fetch the number of the chosen option again.
  $6259,$01 Move onto the next option.
  $625A,$02,b$01 Keep the number in the range #N$00-#N$03.
  $625C,$03 Store the new number of the option in the record of the marker.
  $625F,$03 Point #REGhl at #R$627B.
  $6262,$03 Add the number of the option to find its position.
  $6265,$01 Fetch the position of the new option into #REGc.
@ $6266 label=MoveMarker_Step
  $6266,$01 Copy the position of the option into #REGa.
  $6267,$03 Subtract the current position of the marker.
  $626A,$01 Return if the marker is at the option.
  $626B,$01 Rotate the sign of the difference into the carry flag.
  $626C,$02 Jump to #R$6272 if the option is above the marker.
  $626E,$03 Move the marker down by one pixel.
  $6271,$01 Return.

c $6272 Move Marker Up
@ $6272 label=MoveMarkerUp
D $6272 Moves the marker of one player up by four pixels.
R $6272 IX The record of the marker (see #R$627F)
  $6272,$03 Fetch the vertical position of the marker.
  $6275,$02 Subtract #N$04 from it.
  $6277,$03 Store the new position.
  $627A,$01 Return.

g $627B Option Positions
@ $627B label=OptionPositions
D $627B The vertical positions of the markers beside the four control method
. options of the title menu: the keyboard, a Kempston joystick, a Cursor
. joystick and an Interface II joystick.
B $627B,$04

g $627F Marker Records
@ $627F label=MarkerRecords
D $627F The records of the markers of the two players in the title menu, for
. #R$623F.
B $627F,$01 Horizontal position of the marker of player 1 in pixels.
B $6280,$01 Vertical position of the marker of player 1 in pixels.
B $6281,$01 The number of the chosen control method of player 1.
@ $6282 label=MarkerRecords_Player2
B $6282,$01 Horizontal position of the marker of player 2 in pixels.
B $6283,$01 Vertical position of the marker of player 2 in pixels.
B $6284,$01 The number of the chosen control method of player 2.

b $6285 Player 1 Marker
@ $6285 label=Player1Marker
D $6285 The arrow which marks the control method of player 1 in the title menu,
. for #R$AAC4.
B $6285,$01 Width of the picture in bytes.
B $6286,$01 Height of the picture in rows.
  $6287,$3F,$03 #PICTUREDATA(player-1-marker*)

b $62C6 Player 2 Marker
@ $62C6 label=Player2Marker
D $62C6 The arrow which marks the control method of player 2 in the title menu,
. for #R$AAC4.
B $62C6,$01 Width of the picture in bytes.
B $62C7,$01 Height of the picture in rows.
  $62C8,$3F,$03 #PICTUREDATA(player-2-marker*)

b $6307 Menu Corner Left
@ $6307 label=MenuCornerLeft
D $6307 A small corner piece for #R$AAC4 which is drawn at the left of the title
. menu.
B $6307,$01 Width of the picture in bytes.
B $6308,$01 Height of the picture in rows.
  $6309,$04 #PICTUREDATA(menu-corner-left*)

b $630D Menu Corner Right
@ $630D label=MenuCornerRight
D $630D A small corner piece for #R$AAC4 which is drawn at the right of the
. title menu.
B $630D,$01 Width of the picture in bytes.
B $630E,$01 Height of the picture in rows.
  $630F,$04 #PICTUREDATA(menu-corner-right*)

b $6313 Scroller Character
@ $6313 label=ScrollerCharacter
D $6313 The text record for #R$A923 which prints the next character of the
. scrolling message of the title menu.
B $6313,$01 Horizontal position in pixels.
B $6314,$01 Vertical position in pixels.
B $6315,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6316,$01 Length of the text.
B $6317,$01 The character, which is changed by #R$60FE.

b $6318 Menu Frames
@ $6318 label=MenuFrames
D $6318 The records of the two frames of the title menu, for #R$E2E9.
B $6318,$05 The frame around the options.
B $631D,$05 The frame around the scrolling message.

b $6322 Scrolling Message
@ $6322 label=ScrollingMessage
D $6322 The message which scrolls along the bottom of the title menu, one
. character at a time, in the text encoding of the game. It reads: "!!!! BUBBLER
. !!!! COPYRIGHT ASHBY COMPUTERS AND GRAPHICS LTD! 1987 - ALL SOFTWARE, GRAPHICS
. AND AUDIO VISUAL BY ULTIMATE PLAY THE GAME!" followed by four spaces.
B $6322,$8D,$10

b $63AF Title Menu Text
@ $63AF label=TitleMenuText
D $63AF The thirteen text records of the title menu, for #R$E1BD.
B $63AF,$02 Position: x=#N$50, y=#N$2F.
B $63B1,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $63B2,$01 Length #N$0C.
B $63B3,$0C "A - 1 PLAYER"
B $63BF,$02 Position: x=#N$50, y=#N$3F.
B $63C1,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $63C2,$01 Length #N$0D.
B $63C3,$0D "B - 2 PLAYERS"
B $63D0,$02 Position: x=#N$50, y=#N$4F.
B $63D2,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $63D3,$01 Length #N$0E.
B $63D4,$0E "0 - START GAME"
B $63E2,$02 Position: x=#N$60, y=#N$5F.
B $63E4,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $63E5,$01 Length #N$08.
B $63E6,$08 "KEYBOARD"
B $63EE,$02 Position: x=#N$60, y=#N$6F.
B $63F0,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $63F1,$01 Length #N$08.
B $63F2,$08 "KEMPSTON"
B $63FA,$02 Position: x=#N$60, y=#N$77.
B $63FC,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $63FD,$01 Length #N$08.
B $63FE,$08 "JOYSTICK"
B $6406,$02 Position: x=#N$68, y=#N$87.
B $6408,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6409,$01 Length #N$06.
B $640A,$06 "CURSOR"
B $6410,$02 Position: x=#N$60, y=#N$8F.
B $6412,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6413,$01 Length #N$08.
B $6414,$08 "JOYSTICK"
B $641C,$02 Position: x=#N$58, y=#N$9F.
B $641E,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $641F,$01 Length #N$0B.
B $6420,$0B "INTERFACE [II]"
B $642B,$02 Position: x=#N$10, y=#N$17.
B $642D,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $642E,$01 Length #N$05.
@ $642F label=TitleMenuText_Player1Score
B $642F,$05 "00000"
B $6434,$02 Position: x=#N$C8, y=#N$17.
B $6436,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6437,$01 Length #N$05.
@ $6438 label=TitleMenuText_Player2Score
B $6438,$05 "00000"
B $643D,$02 Position: x=#N$18, y=#N$0F.
B $643F,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6440,$01 Length #N$03.
B $6441,$03 "1UP"
B $6444,$02 Position: x=#N$D0, y=#N$0F.
B $6446,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $6447,$01 Length #N$03.
B $6448,$03 "2UP"

b $644B Bottle Picture
@ $644B label=BottlePicture
D $644B The picture of the bottle which is shown in the score panel, for
. #R$AAC4. The rows are stored from the bottom of the picture up.
B $644B,$01 Width of the picture in bytes.
B $644C,$01 Height of the picture in rows.
  $644D,$4B,$03 #PICTUREDATA(bottle*)

b $6498 Filled Cup Picture
@ $6498 label=FilledCupPicture
D $6498 The picture of the cup which is shown in the score panel when the cup
. has been filled, for #R$AAC4. The rows are stored from the bottom of the
. picture up.
B $6498,$01 Width of the picture in bytes.
B $6499,$01 Height of the picture in rows.
  $649A,$22,$02 #PICTUREDATA(filled-cup*)

b $64BC Empty Cup Picture
@ $64BC label=EmptyCupPicture
D $64BC The picture of the cup which is shown in the score panel until the cup
. has been filled, for #R$AAC4. The rows are stored from the bottom of the
. picture up.
B $64BC,$01 Width of the picture in bytes.
B $64BD,$01 Height of the picture in rows.
  $64BE,$22,$02 #PICTUREDATA(empty-cup*)

b $64E0 Font
@ $64E0 label=Font
D $64E0 The graphics of the characters which are printed by #R$A923. There are
. #N$35 characters of seven bytes each, stored from the bottom row of the
. character up. The character codes are: #N$00-#N$09 for "0" to "9", #N$0A-#N$23
. for "A" to "Z", #N$24 for "-", #N$25 for "!", #N$26 for ":", #N$27 for a
. space, #N$28-#N$32 for eleven boxed symbols, #N$33 for the two vertical bars
. of "II" and #N$34 for ",".
E $64E0 View the equivalent code in;
. #LIST
. { #CYBERUN$9F76 }
. LIST#
B $64E0,$0173,$07

c $6653 Find Sprite Frame
@ $6653 label=FindSpriteFrame
D $6653 Finds the address of the sprite which shows an entity. The type of the
. entity selects a table of frames and the frame number of the entity selects
. one of the sprites in that table.
R $6653 IX The entity
R $6653 O:DE The address of the sprite
  $6653,$03 Fetch the type of the entity.
  $6656,$02 Clear #REGd.
  $6658,$03 Point #REGhl at #R$669E.
  $665B,$02 Add the type twice, as the table has two bytes per entry.
  $665D,$01 Fetch the low byte of the address of the frame table of the type.
  $665E,$01 Move onto the high byte.
  $665F,$01 Fetch the high byte of the address of the frame table.
  $6660,$03 Fetch the frame number of the entity.
  $6663,$02,b$01 Keep the frame number in the range #N$00-#N$1F.
  $6665,$01 Double it, as the table has two bytes per frame.
  $6666,$01 Set #REGhl to the frame number multiplied by two.
  $6667,$02 Clear the high byte.
  $6669,$01 Add the address of the frame table to find the address of the entry.
  $666A,$01 Fetch the low byte of the address of the sprite.
  $666B,$01 Move onto the high byte.
  $666C,$01 Fetch the high byte of the address of the sprite.
  $666D,$01 Return.

w $666E Tile Table
@ $666E label=TileTable
D $666E The addresses of the tiles that are drawn by #R$C59A(#N$C5E5), which are
. chosen by number, with two bytes for each. The entries at #N$666E, #N$6670,
. #N$6672 and #N$669C are set for the level by #R$876B. The entries at #N$6682
. to #N$6689 are zero and not used.
W $666E,$30,$02

w $669E Sprite Table
@ $669E label=SpriteTable
D $669E The address of the table of sprites for each type of entity, which are
. found by #R$6653. The table for type #N$00 is at #N$740E, where there is no
. list of sprite addresses. Purpose of that data is not yet known.
W $669E,$24,$02

w $66C2 Sprite Frame Tables
@ $66C2 label=SpriteFrameTables
D $66C2 The tables of sprite addresses that are listed in #R$669E, with two
. bytes for each frame of the entity. The frame number is in the range #N$00 to
. #N$1F.
N $66C2 Frame table for entity type #N$01.
W $66C2,$0A,$02
N $66CC Frame table for entity type #N$06.
W $66CC,$04,$02
N $66D0 Frame table for entity type #N$07.
W $66D0,$0E,$02
N $66DE Frame table for entity type #N$10.
W $66DE,$04,$02
N $66E2 Frame table for entity type #N$09.
W $66E2,$02,$02
N $66E4 Frame table for entity type #N$08.
W $66E4,$12,$02
N $66F6 Frame table for entity type #N$11.
W $66F6,$0E,$02
N $6704 Frame table for entity type #N$05.
W $6704,$04,$02
N $6708 Frame table for entity types #N$02, #N$03 and #N$04.
W $6708,$0C,$02
N $6714 Frame table for entity type #N$0B.
W $6714,$04,$02
N $6718 Frame table for entity type #N$0A.
W $6718,$12,$02
N $672A Frame table for entity type #N$0C.
W $672A,$06,$02
N $6730 Frame table for entity type #N$0D.
W $6730,$04,$02
N $6734 Frame table for entity type #N$0F.
W $6734,$12,$02
N $6746 Frame table for entity type #N$0E.
W $6746,$08,$02

b $674E Sprite: Foam
@ $674E label=SpriteFoam_1
D $674E The foam sprites, which are drawn by #R$B43C for entities of the type
. #N$0A. Each sprite starts with its width in bytes and its height in rows, and
. the rest is a mask byte and a picture byte for each byte of the width in each
. row, from the top row down. A set bit in the mask means that the picture
. replaces the background. The names of the sprites are only descriptions of how
. they look.
N $674E Frame #N$01 of the foam.
  $674E,$01 Width = #N(#PEEK(#PC)) bytes.
  $674F,$01 Height = #N(#PEEK(#PC)) rows.
  $6750,$7E,$06 #SPRITEDATA(foam-01*)

N $67CE Frame #N$02 of the foam.
@ $67CE label=SpriteFoam_2
  $67CE,$01 Width = #N(#PEEK(#PC)) bytes.
  $67CF,$01 Height = #N(#PEEK(#PC)) rows.
  $67D0,$7E,$06 #SPRITEDATA(foam-02*)

N $684E Frame #N$03 of the foam.
@ $684E label=SpriteFoam_3
  $684E,$01 Width = #N(#PEEK(#PC)) bytes.
  $684F,$01 Height = #N(#PEEK(#PC)) rows.
  $6850,$78,$06 #SPRITEDATA(foam-03*)

N $68C8 Frame #N$04 of the foam.
@ $68C8 label=SpriteFoam_4
  $68C8,$01 Width = #N(#PEEK(#PC)) bytes.
  $68C9,$01 Height = #N(#PEEK(#PC)) rows.
  $68CA,$78,$06 #SPRITEDATA(foam-04*)

N $6942 Frame #N$05 of the foam.
@ $6942 label=SpriteFoam_5
  $6942,$01 Width = #N(#PEEK(#PC)) bytes.
  $6943,$01 Height = #N(#PEEK(#PC)) rows.
  $6944,$78,$06 #SPRITEDATA(foam-05*)

b $69BC Sprite: Whirler
@ $69BC label=SpriteWhirler_1
D $69BC The whirler sprites, which are drawn by #R$B43C for entities of the type
. #N$11.
N $69BC Frame #N$01 of the whirler.
  $69BC,$01 Width = #N(#PEEK(#PC)) bytes.
  $69BD,$01 Height = #N(#PEEK(#PC)) rows.
  $69BE,$8A,$06 #SPRITEDATA(whirler-01*)

N $6A48 Frame #N$02 of the whirler.
@ $6A48 label=SpriteWhirler_2
  $6A48,$01 Width = #N(#PEEK(#PC)) bytes.
  $6A49,$01 Height = #N(#PEEK(#PC)) rows.
  $6A4A,$84,$06 #SPRITEDATA(whirler-02*)

N $6ACE Frame #N$03 of the whirler.
@ $6ACE label=SpriteWhirler_3
  $6ACE,$01 Width = #N(#PEEK(#PC)) bytes.
  $6ACF,$01 Height = #N(#PEEK(#PC)) rows.
  $6AD0,$8A,$06 #SPRITEDATA(whirler-03*)

N $6B5A Frame #N$04 of the whirler.
@ $6B5A label=SpriteWhirler_4
  $6B5A,$01 Width = #N(#PEEK(#PC)) bytes.
  $6B5B,$01 Height = #N(#PEEK(#PC)) rows.
  $6B5C,$8A,$06 #SPRITEDATA(whirler-04*)

b $6BE6 Sprite: Pickup Bubble
@ $6BE6 label=SpritePickupBubble_1
D $6BE6 The pickup bubble sprites, which are drawn by #R$B43C for entities of
. the type #N$0F.
N $6BE6 Frame #N$01 of the pickup bubble.
  $6BE6,$01 Width = #N(#PEEK(#PC)) bytes.
  $6BE7,$01 Height = #N(#PEEK(#PC)) rows.
  $6BE8,$3C,$04 #SPRITEDATA(pickup-bubble-01*)

N $6C24 Frame #N$02 of the pickup bubble.
@ $6C24 label=SpritePickupBubble_2
  $6C24,$01 Width = #N(#PEEK(#PC)) bytes.
  $6C25,$01 Height = #N(#PEEK(#PC)) rows.
  $6C26,$44,$04 #SPRITEDATA(pickup-bubble-02*)

b $6C6A Sprite: Pickup Rocket
@ $6C6A label=SpritePickupRocket_1
D $6C6A The pickup rocket sprites, which are drawn by #R$B43C for entities of
. the type #N$0F.
N $6C6A Frame #N$01 of the pickup rocket.
  $6C6A,$01 Width = #N(#PEEK(#PC)) bytes.
  $6C6B,$01 Height = #N(#PEEK(#PC)) rows.
  $6C6C,$20,$02 #SPRITEDATA(pickup-rocket-01*)

N $6C8C Frame #N$02 of the pickup rocket.
@ $6C8C label=SpritePickupRocket_2
  $6C8C,$01 Width = #N(#PEEK(#PC)) bytes.
  $6C8D,$01 Height = #N(#PEEK(#PC)) rows.
  $6C8E,$20,$02 #SPRITEDATA(pickup-rocket-02*)

b $6CAE Sprite: Pickup Clock
@ $6CAE label=SpritePickupClock_1
D $6CAE The pickup clock sprite, which is drawn by #R$B43C for entities of the
. type #N$0F.
  $6CAE,$01 Width = #N(#PEEK(#PC)) bytes.
  $6CAF,$01 Height = #N(#PEEK(#PC)) rows.
  $6CB0,$90,$06 #SPRITEDATA(pickup-clock-01*)

b $6D40 Sprite: Pickup Blob
@ $6D40 label=SpritePickupBlob_1
D $6D40 The pickup blob sprite, which is drawn by #R$B43C for entities of the
. type #N$0F.
  $6D40,$01 Width = #N(#PEEK(#PC)) bytes.
  $6D41,$01 Height = #N(#PEEK(#PC)) rows.
  $6D42,$28,$04 #SPRITEDATA(pickup-blob-01*)

b $6D6A Sprite: Pickup Score
@ $6D6A label=SpritePickupScore_1
D $6D6A The pickup score sprite, which is drawn by #R$B43C for entities of the
. type #N$0F.
  $6D6A,$01 Width = #N(#PEEK(#PC)) bytes.
  $6D6B,$01 Height = #N(#PEEK(#PC)) rows.
  $6D6C,$40,$04 #SPRITEDATA(pickup-score-01*)

b $6DAC Sprite: Sparkle
@ $6DAC label=SpriteSparkle_1
D $6DAC The sparkle sprites, which are drawn by #R$B43C for entities of the type
. #N$0D.
N $6DAC Frame #N$01 of the sparkle.
  $6DAC,$01 Width = #N(#PEEK(#PC)) bytes.
  $6DAD,$01 Height = #N(#PEEK(#PC)) rows.
  $6DAE,$10,$02 #SPRITEDATA(sparkle-01*)

N $6DBE Frame #N$02 of the sparkle.
@ $6DBE label=SpriteSparkle_2
  $6DBE,$01 Width = #N(#PEEK(#PC)) bytes.
  $6DBF,$01 Height = #N(#PEEK(#PC)) rows.
  $6DC0,$10,$02 #SPRITEDATA(sparkle-02*)

b $6DD0 Sprite: Puff
@ $6DD0 label=SpritePuff_1
D $6DD0 The puff sprite, which is drawn by #R$B43C for entities of the type
. #N$05.
  $6DD0,$01 Width = #N(#PEEK(#PC)) bytes.
  $6DD1,$01 Height = #N(#PEEK(#PC)) rows.
  $6DD2,$0C,$02 #SPRITEDATA(puff-01*)

b $6DDE Sprite: Growing Bubble
@ $6DDE label=SpriteGrowingBubble_1
D $6DDE The growing bubble sprites, which are drawn by #R$B43C for entities of
. the type #N$08.
N $6DDE Frame #N$01 of the growing bubble.
  $6DDE,$01 Width = #N(#PEEK(#PC)) bytes.
  $6DDF,$01 Height = #N(#PEEK(#PC)) rows.
  $6DE0,$1C,$04 #SPRITEDATA(growing-bubble-01*)

N $6DFC Frame #N$02 of the growing bubble.
@ $6DFC label=SpriteGrowingBubble_2
  $6DFC,$01 Width = #N(#PEEK(#PC)) bytes.
  $6DFD,$01 Height = #N(#PEEK(#PC)) rows.
  $6DFE,$24,$04 #SPRITEDATA(growing-bubble-02*)

N $6E22 Frame #N$03 of the growing bubble.
@ $6E22 label=SpriteGrowingBubble_3
  $6E22,$01 Width = #N(#PEEK(#PC)) bytes.
  $6E23,$01 Height = #N(#PEEK(#PC)) rows.
  $6E24,$2C,$04 #SPRITEDATA(growing-bubble-03*)

N $6E50 Frame #N$04 of the growing bubble.
@ $6E50 label=SpriteGrowingBubble_4
  $6E50,$01 Width = #N(#PEEK(#PC)) bytes.
  $6E51,$01 Height = #N(#PEEK(#PC)) rows.
  $6E52,$38,$04 #SPRITEDATA(growing-bubble-04*)

b $6E8A Sprite: Starburst
@ $6E8A label=SpriteStarburst_1
D $6E8A The starburst sprite, which is drawn by #R$B43C for entities of the
. types #N$08 and #N$0F.
  $6E8A,$01 Width = #N(#PEEK(#PC)) bytes.
  $6E8B,$01 Height = #N(#PEEK(#PC)) rows.
  $6E8C,$40,$04 #SPRITEDATA(starburst-01*)

b $6ECC Sprite: Growing Bubble
@ $6ECC label=SpriteGrowingBubble_5
D $6ECC The growing bubble sprites, which are drawn by #R$B43C for entities of
. the type #N$08.
N $6ECC Frame #N$05 of the growing bubble.
  $6ECC,$01 Width = #N(#PEEK(#PC)) bytes.
  $6ECD,$01 Height = #N(#PEEK(#PC)) rows.
  $6ECE,$3C,$04 #SPRITEDATA(growing-bubble-05*)

N $6F0A Frame #N$06 of the growing bubble.
@ $6F0A label=SpriteGrowingBubble_6
  $6F0A,$01 Width = #N(#PEEK(#PC)) bytes.
  $6F0B,$01 Height = #N(#PEEK(#PC)) rows.
  $6F0C,$44,$04 #SPRITEDATA(growing-bubble-06*)

b $6F50 Sprite: Burst
@ $6F50 label=SpriteBurst_1
D $6F50 The burst sprites, which are drawn by #R$B43C for entities of the type
. #N$07.
N $6F50 Frame #N$01 of the burst.
  $6F50,$01 Width = #N(#PEEK(#PC)) bytes.
  $6F51,$01 Height = #N(#PEEK(#PC)) rows.
  $6F52,$60,$06 #SPRITEDATA(burst-01*)

N $6FB2 Frame #N$02 of the burst.
@ $6FB2 label=SpriteBurst_2
  $6FB2,$01 Width = #N(#PEEK(#PC)) bytes.
  $6FB3,$01 Height = #N(#PEEK(#PC)) rows.
  $6FB4,$6C,$06 #SPRITEDATA(burst-02*)

N $7020 Frame #N$03 of the burst.
@ $7020 label=SpriteBurst_3
  $7020,$01 Width = #N(#PEEK(#PC)) bytes.
  $7021,$01 Height = #N(#PEEK(#PC)) rows.
  $7022,$78,$06 #SPRITEDATA(burst-03*)

N $709A Frame #N$04 of the burst.
@ $709A label=SpriteBurst_4
  $709A,$01 Width = #N(#PEEK(#PC)) bytes.
  $709B,$01 Height = #N(#PEEK(#PC)) rows.
  $709C,$78,$06 #SPRITEDATA(burst-04*)

N $7114 Frame #N$05 of the burst.
@ $7114 label=SpriteBurst_5
  $7114,$01 Width = #N(#PEEK(#PC)) bytes.
  $7115,$01 Height = #N(#PEEK(#PC)) rows.
  $7116,$78,$06 #SPRITEDATA(burst-05*)

N $718E Frame #N$06 of the burst.
@ $718E label=SpriteBurst_6
  $718E,$01 Width = #N(#PEEK(#PC)) bytes.
  $718F,$01 Height = #N(#PEEK(#PC)) rows.
  $7190,$66,$06 #SPRITEDATA(burst-06*)

N $71F6 Frame #N$07 of the burst.
@ $71F6 label=SpriteBurst_7
  $71F6,$01 Width = #N(#PEEK(#PC)) bytes.
  $71F7,$01 Height = #N(#PEEK(#PC)) rows.
  $71F8,$72,$06 #SPRITEDATA(burst-07*)

b $726A Tile: Block Faces One
@ $726A label=TileBlockFace_1
D $726A The tiles that are drawn by #R$C59A(#N$C5E5), which are shapes for the
. faces of the blocks of the level. Each starts with a flag that records whether
. it has been flipped by #R$C522, and then has a mask byte and a picture byte
. for each of the two bytes of the width in each row, from the top row down. The
. names of the tiles are only descriptions of how they look.
N $726A Block face #N$01, which is #N$18 rows high.
  $726A,$01 Flip flag.
  $726B,$60,$04 #TILEDATA$18(block-face-01*)

N $72CB Block face #N$02, which is #N$18 rows high.
@ $72CB label=TileBlockFace_2
  $72CB,$01 Flip flag.
  $72CC,$60,$04 #TILEDATA$18(block-face-02*)

N $732C Block face #N$03, which is #N$18 rows high.
@ $732C label=TileBlockFace_3
  $732C,$01 Flip flag.
  $732D,$60,$04 #TILEDATA$18(block-face-03*)

N $738D Block face #N$04, which is #N$18 rows high.
@ $738D label=TileBlockFace_4
  $738D,$01 Flip flag.
  $738E,$60,$04 #TILEDATA$18(block-face-04*)
N $73EE Purpose of the data from #N$73EE to #N$748E is not yet known. The
. address in the table for type #N$00 is #N$740E.
  $73EE,$20,$04
  $740E,$80,$04
  $748E,$01

N $748F Block face #N$05, which is #N$18 rows high.
@ $748F label=TileBlockFace_5
  $748F,$01 Flip flag.
  $7490,$60,$04 #TILEDATA$18(block-face-05*)

N $74F0 Block face #N$06, which is #N$44 rows high.
@ $74F0 label=TileBlockFace_6
  $74F0,$01 Flip flag.
  $74F1,$110,$04 #TILEDATA$44(block-face-06*)

b $7601 Sprite: Bubble
@ $7601 label=SpriteBubble_1
D $7601 The bubble sprites, which are drawn by #R$B43C for entities of the type
. #N$01.
N $7601 Frame #N$01 of the bubble.
  $7601,$01 Width = #N(#PEEK(#PC)) bytes.
  $7602,$01 Height = #N(#PEEK(#PC)) rows.
  $7603,$54,$06 #SPRITEDATA(bubble-01*)

N $7657 Frame #N$02 of the bubble.
@ $7657 label=SpriteBubble_2
  $7657,$01 Width = #N(#PEEK(#PC)) bytes.
  $7658,$01 Height = #N(#PEEK(#PC)) rows.
  $7659,$54,$06 #SPRITEDATA(bubble-02*)

N $76AD Frame #N$04 of the bubble.
@ $76AD label=SpriteBubble_4
  $76AD,$01 Width = #N(#PEEK(#PC)) bytes.
  $76AE,$01 Height = #N(#PEEK(#PC)) rows.
  $76AF,$48,$06 #SPRITEDATA(bubble-04*)

N $76F7 Frame #N$05 of the bubble.
@ $76F7 label=SpriteBubble_5
  $76F7,$01 Width = #N(#PEEK(#PC)) bytes.
  $76F8,$01 Height = #N(#PEEK(#PC)) rows.
  $76F9,$6C,$06 #SPRITEDATA(bubble-05*)

N $7765 Frame #N$03 of the bubble.
@ $7765 label=SpriteBubble_3
  $7765,$01 Width = #N(#PEEK(#PC)) bytes.
  $7766,$01 Height = #N(#PEEK(#PC)) rows.
  $7767,$60,$06 #SPRITEDATA(bubble-03*)

b $77C7 Sprite: Drop
@ $77C7 label=SpriteDrop_1
D $77C7 The drop sprites, which are drawn by #R$B43C for entities of the types
. #N$02, #N$03 and #N$04.
N $77C7 Frame #N$01 of the drop.
  $77C7,$01 Width = #N(#PEEK(#PC)) bytes.
  $77C8,$01 Height = #N(#PEEK(#PC)) rows.
  $77C9,$36,$06 #SPRITEDATA(drop-01*)

N $77FF Frame #N$02 of the drop.
@ $77FF label=SpriteDrop_2
  $77FF,$01 Width = #N(#PEEK(#PC)) bytes.
  $7800,$01 Height = #N(#PEEK(#PC)) rows.
  $7801,$18,$04 #SPRITEDATA(drop-02*)

N $7819 Frame #N$03 of the drop.
@ $7819 label=SpriteDrop_3
  $7819,$01 Width = #N(#PEEK(#PC)) bytes.
  $781A,$01 Height = #N(#PEEK(#PC)) rows.
  $781B,$08,$02 #SPRITEDATA(drop-03*)

N $7823 Frame #N$06 of the drop.
@ $7823 label=SpriteDrop_6
  $7823,$01 Width = #N(#PEEK(#PC)) bytes.
  $7824,$01 Height = #N(#PEEK(#PC)) rows.
  $7825,$14,$02 #SPRITEDATA(drop-06*)

N $7839 Frame #N$05 of the drop.
@ $7839 label=SpriteDrop_5
  $7839,$01 Width = #N(#PEEK(#PC)) bytes.
  $783A,$01 Height = #N(#PEEK(#PC)) rows.
  $783B,$1A,$02 #SPRITEDATA(drop-05*)

N $7855 Frame #N$04 of the drop.
@ $7855 label=SpriteDrop_4
  $7855,$01 Width = #N(#PEEK(#PC)) bytes.
  $7856,$01 Height = #N(#PEEK(#PC)) rows.
  $7857,$1E,$02 #SPRITEDATA(drop-04*)

b $7875 Tile: Block Faces Two
@ $7875 label=TileBlockFace_7
D $7875 The tiles that are drawn by #R$C59A(#N$C5E5), which are shapes for the
. faces of the blocks of the level. Each starts with a flag that records whether
. it has been flipped by #R$C522, and then has a mask byte and a picture byte
. for each of the two bytes of the width in each row, from the top row down.
N $7875 Block face #N$07, which is #N$22 rows high.
  $7875,$01 Flip flag.
  $7876,$88,$04 #TILEDATA$22(block-face-07*)

N $78FE Block face #N$08, which is #N$22 rows high.
@ $78FE label=TileBlockFace_8
  $78FE,$01 Flip flag.
  $78FF,$88,$04 #TILEDATA$22(block-face-08*)

N $7987 Block face #N$09, which is #N$22 rows high.
@ $7987 label=TileBlockFace_9
  $7987,$01 Flip flag.
  $7988,$88,$04 #TILEDATA$22(block-face-09*)

N $7A10 Block face #N$0A, which is #N$22 rows high.
@ $7A10 label=TileBlockFace_10
  $7A10,$01 Flip flag.
  $7A11,$88,$04 #TILEDATA$22(block-face-10*)

N $7A99 Block face #N$0B, which is #N$12 rows high.
@ $7A99 label=TileBlockFace_11
  $7A99,$01 Flip flag.
  $7A9A,$48,$04 #TILEDATA$12(block-face-11*)

N $7AE2 Block face #N$0C, which is #N$64 rows high.
@ $7AE2 label=TileBlockFace_12
  $7AE2,$01 Flip flag.
  $7AE3,$190,$04 #TILEDATA$64(block-face-12*)

N $7C73 Block face #N$0D, which is #N$42 rows high.
@ $7C73 label=TileBlockFace_13
  $7C73,$01 Flip flag.
  $7C74,$E4,$04 #TILEDATA$42(block-face-13*)
@ $7D58 label=TileBlockFace13_Row57
  $7D58,$24,$04

N $7D7C Block face #N$0E, which is #N$30 rows high.
@ $7D7C label=TileBlockFace_14
  $7D7C,$01 Flip flag.
  $7D7D,$C0,$04 #TILEDATA$30(block-face-14*)

N $7E3D Block face #N$0F, which is #N$19 rows high.
@ $7E3D label=TileBlockFace_15
  $7E3D,$01 Flip flag.
  $7E3E,$64,$04 #TILEDATA$19(block-face-15*)

N $7EA2 Block face #N$10, which is #N$18 rows high.
@ $7EA2 label=TileBlockFace_16
  $7EA2,$01 Flip flag.
  $7EA3,$60,$04 #TILEDATA$18(block-face-16*)

N $7F03 Block face #N$11, which is #N$10 rows high.
@ $7F03 label=TileBlockFace_17
  $7F03,$01 Flip flag.
  $7F04,$0C,$04 #TILEDATA$10(block-face-17*)
@ $7F10 label=TileBlockFace17_Row03
  $7F10,$34,$04

N $7F44 Block face #N$12, which is #N$10 rows high.
@ $7F44 label=TileBlockFace_18
  $7F44,$01 Flip flag.
  $7F45,$40,$04 #TILEDATA$10(block-face-18*)

N $7F85 Block face #N$13, which is #N$18 rows high.
@ $7F85 label=TileBlockFace_19
  $7F85,$01 Flip flag.
  $7F86,$60,$04 #TILEDATA$18(block-face-19*)

N $7FE6 Block face #N$14, which is #N$18 rows high.
@ $7FE6 label=TileBlockFace_20
  $7FE6,$01 Flip flag.
  $7FE7,$58,$04 #TILEDATA$18(block-face-20*)
@ $803F label=TileBlockFace20_Row22
  $803F,$08,$04

N $8047 Block face #N$15, which is #N$18 rows high.
@ $8047 label=TileBlockFace_21
  $8047,$01 Flip flag.
  $8048,$30,$04 #TILEDATA$18(block-face-21*)
@ $8078 label=TileBlockFace21_Row12
  $8078,$08,$04
@ $8080 label=TileBlockFace21_Row14
  $8080,$20,$04
@ $80A0 label=TileBlockFace21_Row22
  $80A0,$04,$04
@ $80A4 label=TileBlockFace21_Row23
  $80A4,$04,$04

N $80A8 Block face #N$16, which is #N$18 rows high.
@ $80A8 label=TileBlockFace_22
  $80A8,$01 Flip flag.
  $80A9,$60,$04 #TILEDATA$18(block-face-22*)

b $8109 Sprite: Dome
@ $8109 label=SpriteDome_1
D $8109 The dome sprites, which are drawn by #R$B43C for entities of the type
. #N$06.
N $8109 Frame #N$01 of the dome.
  $8109,$01 Width = #N(#PEEK(#PC)) bytes.
  $810A,$01 Height = #N(#PEEK(#PC)) rows.
  $810B,$6C,$06 #SPRITEDATA(dome-01*)

N $8177 Frame #N$02 of the dome.
@ $8177 label=SpriteDome_2
  $8177,$01 Width = #N(#PEEK(#PC)) bytes.
  $8178,$01 Height = #N(#PEEK(#PC)) rows.
  $8179,$6C,$06 #SPRITEDATA(dome-02*)

b $81E5 Dial Picture
@ $81E5 label=DialPicture
D $81E5 The empty dial of a direction gauge, which is drawn twice by #R$E229
. before the needles are added by #R$A724. It is #N$07 bytes wide and #N$28 rows
. high, and has no mask.
  $81E5,$01 Width = #N(#PEEK(#PC)) bytes.
  $81E6,$01 Height = #N(#PEEK(#PC)) rows.
  $81E7,$46,$07 #PICTUREDATA(dial-picture*)
@ $822D label=DialPicture_Row10
  $822D,$D2,$07

b $82FF Sprite: Saucer
@ $82FF label=SpriteSaucer_1
D $82FF The saucer sprite, which is drawn by #R$B43C for entities of the type
. #N$09.
  $82FF,$01 Width = #N(#PEEK(#PC)) bytes.
  $8300,$01 Height = #N(#PEEK(#PC)) rows.
  $8301,$66,$06 #SPRITEDATA(saucer-01*)

b $8367 Sprite: Shot
@ $8367 label=SpriteShot_1
D $8367 The shot sprites, which are drawn by #R$B43C for entities of the type
. #N$0E.
N $8367 Frame #N$01 of the shot.
  $8367,$01 Width = #N(#PEEK(#PC)) bytes.
  $8368,$01 Height = #N(#PEEK(#PC)) rows.
  $8369,$12,$02 #SPRITEDATA(shot-01*)

N $837B Frame #N$02 of the shot.
@ $837B label=SpriteShot_2
  $837B,$01 Width = #N(#PEEK(#PC)) bytes.
  $837C,$01 Height = #N(#PEEK(#PC)) rows.
  $837D,$12,$02 #SPRITEDATA(shot-02*)

N $838F Frame #N$03 of the shot.
@ $838F label=SpriteShot_3
  $838F,$01 Width = #N(#PEEK(#PC)) bytes.
  $8390,$01 Height = #N(#PEEK(#PC)) rows.
  $8391,$12,$02 #SPRITEDATA(shot-03*)

N $83A3 Frame #N$04 of the shot.
@ $83A3 label=SpriteShot_4
  $83A3,$01 Width = #N(#PEEK(#PC)) bytes.
  $83A4,$01 Height = #N(#PEEK(#PC)) rows.
  $83A5,$12,$02 #SPRITEDATA(shot-04*)

b $83B7 Sprite: Bat
@ $83B7 label=SpriteBat_1
D $83B7 The bat sprites, which are drawn by #R$B43C for entities of the type
. #N$0B.
N $83B7 Frame #N$01 of the bat.
  $83B7,$01 Width = #N(#PEEK(#PC)) bytes.
  $83B8,$01 Height = #N(#PEEK(#PC)) rows.
  $83B9,$88,$08 #SPRITEDATA(bat-01*)

N $8441 Frame #N$02 of the bat.
@ $8441 label=SpriteBat_2
  $8441,$01 Width = #N(#PEEK(#PC)) bytes.
  $8442,$01 Height = #N(#PEEK(#PC)) rows.
  $8443,$88,$08 #SPRITEDATA(bat-02*)

b $84CB Sprite: Spider
@ $84CB label=SpriteSpider_1
D $84CB The spider sprite, which is drawn by #R$B43C for entities of the type
. #N$10.
  $84CB,$01 Width = #N(#PEEK(#PC)) bytes.
  $84CC,$01 Height = #N(#PEEK(#PC)) rows.
  $84CD,$66,$06 #SPRITEDATA(spider-01*)

b $8533 Sprite: Hand
@ $8533 label=SpriteHand_1
D $8533 The hand sprite, which is drawn by #R$B43C for entities of the type
. #N$10.
  $8533,$01 Width = #N(#PEEK(#PC)) bytes.
  $8534,$01 Height = #N(#PEEK(#PC)) rows.
  $8535,$9C,$06 #SPRITEDATA(hand-01*)

b $85D1 Sprite: Disc
@ $85D1 label=SpriteDisc_1
D $85D1 The disc sprites, which are drawn by #R$B43C for entities of the type
. #N$0C.
N $85D1 Frame #N$01 of the disc.
  $85D1,$01 Width = #N(#PEEK(#PC)) bytes.
  $85D2,$01 Height = #N(#PEEK(#PC)) rows.
  $85D3,$5A,$06 #SPRITEDATA(disc-01*)

N $862D Frame #N$02 of the disc.
@ $862D label=SpriteDisc_2
  $862D,$01 Width = #N(#PEEK(#PC)) bytes.
  $862E,$01 Height = #N(#PEEK(#PC)) rows.
  $862F,$5A,$06 #SPRITEDATA(disc-02*)

N $8689 Frame #N$03 of the disc.
@ $8689 label=SpriteDisc_3
  $8689,$01 Width = #N(#PEEK(#PC)) bytes.
  $868A,$01 Height = #N(#PEEK(#PC)) rows.
  $868B,$5A,$06 #SPRITEDATA(disc-03*)

w $86E5 Level Table
@ $86E5 label=LevelTable
D $86E5 The addresses of the data of each level, which are found by #R$86F9.
. There are four bytes for each level. The first address is the header of the
. level, which is used with the map and the path entries that are described at
. #R$87D3. The second address is not used by the game and its purpose is not yet
. known.
W $86E5,$14,$04

c $86F9 Start Level
@ $86F9 label=StartLevel
D $86F9 Finds the data of the current level and, when it is entered at #R$86F9,
. places the player at the start of the level (or at the position where the
. player last restarted) and sets the view to match.
R $86F9 C #N$01 to place the player, otherwise only find the level data
  $86F9,$02 Set the placement flag in #REGc to #N$01.
@ $86FB label=StartLevel_FindData
  $86FB,$03 Fetch the number of the current level from #R$DEDF.
  $86FE,$02 Multiply it by four, as there are four bytes for each level in the
. table at #R$86E5.
  $8700,$01 Move it into #REGe.
  $8701,$02 Clear #REGd.
  $8703,$03 Point #REGhl at #R$86E5.
  $8706,$01 Add the offset of the level to find its entry.
  $8707,$01 Fetch the low byte of the address of the data of the level.
  $8708,$01 Move onto the high byte.
  $8709,$01 Fetch the high byte of the address of the data of the level.
  $870A,$04 Store the address in #R$5CFE.
  $870E,$01 Decrease the placement flag by one.
  $870F,$01 Return unless the player is to be placed.
N $8710 Place the player at the start position of the level, or at the position
. of the last restart.
  $8710,$03 Copy the address of the start position of the level into #REGix
. (using the stack).
  $8713,$01 Stash the address of the start position of the level on the stack.
  $8714,$03 Fetch the restart flag from #R$DEF5(#N$DEF7).
  $8717,$01 Test it.
  $8718,$02 Jump to #R$871E if the player has not restarted.
  $871A,$04 Point #REGix at the position of the last restart at #R$DEF5 instead.
@ $871E label=StartLevel_Place
  $871E,$03 Fetch the first byte of the start position.
  $8721,$02,b$01 Keep the upper four bits.
  $8723,$01 Copy them into #REGh.
  $8724,$02 #REGl is #N$01.
  $8726,$01 Copy the upper four bits into #REGc.
  $8727,$02 Clear #REGb.
  $8729,$03 Write #REGhl in the player entity at #R$B540(#N$B548).
  $872C,$03 Fetch the first byte of the start position again.
  $872F,$02,b$01 Keep the lower four bits.
  $8731,$02 Add #N$20.
  $8733,$01 Copy the result into #REGl.
  $8734,$03 Fetch the second byte of the start position into #REGh.
  $8737,$03 Write #REGhl in the player entity at #R$B540(#N$B542).
  $873A,$01 #REGl moves into #REGa.
  $873B,$01 #REGh moves into #REGl.
  $873C,$01 #REGa moves into #REGh.
  $873D,$03 #REGde is #N$FF98 (minus #N$68).
  $8740,$01 Subtract #N$68 from the swapped position.
  $8741,$03 Subtract the upper four bits of the first byte of the start
. position.
  $8744,$03 Store the result in #R$5CE2.
  $8747,$03 Fetch the third byte of the start position into #REGl.
  $874A,$03 Fetch the fourth byte of the start position into #REGh.
  $874D,$03 Write #REGhl in the player entity at #R$B540(#N$B545).
  $8750,$01 #REGl moves into #REGa.
  $8751,$01 #REGh moves into #REGl.
  $8752,$01 #REGa moves into #REGh.
  $8753,$01 Subtract #N$68 from the swapped position.
  $8754,$01 Add the upper four bits of the first byte of the start position.
  $8755,$03 Store the result in #R$5CE2(#N$5CE4).
  $8758,$03 Fetch the byte of the player entity at #R$B540(#N$B546).
  $875B,$02 Add #N$04 to it.
  $875D,$03 Store it again.
  $8760,$03 Fetch the byte of the player entity at #R$B540(#N$B543).
  $8763,$02 Add #N$02 to it.
  $8765,$03 Store it again.
  $8768,$02 Bring back #REGix from the stack.
  $876A,$01 Return.

c $876B Set Level Graphics
@ $876B label=SetLevelGraphics
D $876B Sets up the level which is being played using the table of levels at
. #R$87AB, which has eight bytes for each level. The colour for the level and
. the number of bottles to collect are stored, and four of the addresses in the
. table at #R$666E are replaced for the level.
  $876B,$03 Point #REGhl at the table of levels.
  $876E,$03 Fetch the number of the current level from #R$DEDF.
  $8771,$03 Multiply it by eight.
  $8774,$03 Add it to #REGhl to find the entry of the level.
  $8777,$01 Fetch the colour of the level.
  $8778,$03 Store it in the attribute of the rectangle at #R$E11C(#N$E11E).
  $877B,$01 Move onto the next byte of the entry.
  $877C,$01 Fetch the number of bottles to collect.
  $877D,$03 Store it in #R$DEE0.
  $8780,$01 Move onto the next byte of the entry.
  $8781,$01 Fetch the low byte of the first address.
  $8782,$01 Move onto the high byte.
  $8783,$01 Fetch the high byte.
  $8784,$01 Move onto the next word of the entry.
  $8785,$04 Store it in the first entry of the table at #R$666E.
  $8789,$01 Fetch the low byte of the second address.
  $878A,$01 Move onto the high byte.
  $878B,$01 Fetch the high byte.
  $878C,$01 Move onto the next word of the entry.
  $878D,$04 Store it in the last entry of the table at #R$666E(#N$669C).
  $8791,$01 Fetch the low byte of the third address.
  $8792,$01 Move onto the high byte.
  $8793,$01 Fetch the high byte.
  $8794,$04 Store it in the third entry of the table at #R$666E(#N$6670).
  $8798,$03 #REGhl is #N$7F85.
  $879B,$01 Clear the carry flag.
  $879C,$02 Compare the third address with #N$7F85.
  $879E,$03 #REGde is #N$8047, the fourth address when the third address is
. #N$7F85.
  $87A1,$02 Jump to #R$87A6 if it is #N$7F85.
  $87A3,$03 #REGde is #N$80A8, the fourth address otherwise.
@ $87A6 label=SetLevelGraphics_Store
  $87A6,$04 Store it in the fourth entry of the table at #R$666E(#N$6672).
  $87AA,$01 Return.

b $87AB Level Settings
@ $87AB label=LevelSettings
D $87AB The settings of each level, which are used by #R$876B. There are eight
. bytes for each level. The first is the attribute of the game area, which is
. stored at #N$E11E, and the second is the number of bottles that are to be
. collected. The three words that follow are the tiles that #R$876B sets for the
. entries at #N$666E, #N$669C and #N$6670 of the table at #R$666E. The entry at
. #N$6672 is chosen from the third of them.
N $87AB Level #N$00.
B $87AB,$02,$01
W $87AD,$06,$02
N $87B3 Level #N$01.
B $87B3,$02,$01
W $87B5,$06,$02
N $87BB Level #N$02.
B $87BB,$02,$01
W $87BD,$06,$02
N $87C3 Level #N$03.
B $87C3,$02,$01
W $87C5,$06,$02
N $87CB Level #N$04.
B $87CB,$02,$01
W $87CD,$06,$02

b $87D3 Level Data
@ $87D3 label=LevelData
D $87D3 The data of the five levels, which are found with #R$86E5. The data of
. the levels are not in the order of the levels. For each level there is a list
. of addresses (two bytes each), the number of cells of the map, the header and
. the map, and then the path entries that the addresses in the list refer to.
. The path entries of level #N$03 are stored after those of level #N$04. The
. header of a level is #N$07 bytes: the position that the player starts at (see
. #R$86F9), a byte, and the width and height of the map, which are used by
. #R$BA16. The map has two bytes for each cell. The second is the number of the
. group of objects in the table at #R$8BB1, and the first is also used by
. #R$BA16, where #N$FE and #N$FF mean that the cell has no group.
N $87D3 Purpose of the data from #N$87D3 to #N$87EE is not yet known. The last
. #N$10 bytes look like a path entry.
W $87D3,$02,$02
B $87D5,$0A,$0A
B $87DF,$10,$04
N $87EF Level #N$00: the list of path entries, the number of cells, the header
. and the map.
W $87EF,$08,$02
B $87F7,$01 Number of cells in the map.
B $87F8,$04,$04 Position that the player starts at.
B $87FC,$01 Purpose not yet known.
B $87FD,$01 Width of the map in cells.
B $87FE,$01 Height of the map in cells.
B $87FF,$08,$04
N $8807 The path entries of level #N$00.
B $8807,$14,$04
B $881B,$10,$04
B $882B,$10,$04
B $883B,$10,$04
N $884B Level #N$01: the list of path entries, the number of cells, the header
. and the map.
W $884B,$1C,$02
B $8867,$01 Number of cells in the map.
B $8868,$04,$04 Position that the player starts at.
B $886C,$01 Purpose not yet known.
B $886D,$01 Width of the map in cells.
B $886E,$01 Height of the map in cells.
B $886F,$08,$04
N $8877 The path entries of level #N$01.
B $8877,$10,$04
B $8887,$10,$04
B $8897,$10,$04
B $88A7,$10,$04
B $88B7,$10,$04
B $88C7,$10,$04
B $88D7,$10,$04
B $88E7,$10,$04
B $88F7,$10,$04
B $8907,$10,$04
B $8917,$14,$04
B $892B,$14,$04
B $893F,$14,$04
B $8953,$14,$04
N $8967 Level #N$03: the list of path entries, the number of cells, the header
. and the map.
W $8967,$0E,$02
B $8975,$01 Number of cells in the map.
B $8976,$04,$04 Position that the player starts at.
B $897A,$01 Purpose not yet known.
B $897B,$01 Width of the map in cells.
B $897C,$01 Height of the map in cells.
B $897D,$18,$06
N $8995 Level #N$02: the list of path entries, the number of cells, the header
. and the map.
W $8995,$0A,$02
B $899F,$01 Number of cells in the map.
B $89A0,$04,$04 Position that the player starts at.
B $89A4,$01 Purpose not yet known.
B $89A5,$01 Width of the map in cells.
B $89A6,$01 Height of the map in cells.
B $89A7,$12,$06
N $89B9 The path entries of level #N$02.
B $89B9,$14,$04
B $89CD,$10,$04
B $89DD,$18,$04
B $89F5,$10,$04
B $8A05,$10,$04
N $8A15 Level #N$04: the list of path entries, the number of cells, the header
. and the map.
W $8A15,$14,$02
B $8A29,$01 Number of cells in the map.
B $8A2A,$04,$04 Position that the player starts at.
B $8A2E,$01 Purpose not yet known.
B $8A2F,$01 Width of the map in cells.
B $8A30,$01 Height of the map in cells.
B $8A31,$38,$0E
N $8A69 The path entries of level #N$04.
B $8A69,$10,$04
B $8A79,$10,$04
B $8A89,$18,$04
B $8AA1,$10,$04
B $8AB1,$14,$04
B $8AC5,$10,$04
B $8AD5,$14,$04
B $8AE9,$10,$04
B $8AF9,$18,$04
B $8B11,$10,$04
N $8B21 The path entries of level #N$03.
B $8B21,$10,$04
B $8B31,$14,$04
B $8B45,$18,$04
B $8B5D,$14,$04
B $8B71,$10,$04
B $8B81,$10,$04
B $8B91,$20,$04

b $8BB1 Group Table
@ $8BB1 label=GroupTable
D $8BB1 The addresses of the groups of objects at #R$8C0D, which are chosen by
. the group number in the map of a level. Each group is found with #R$BA16.
W $8BB1,$5C,$02

b $8C0D Groups
@ $8C0D label=Groups
D $8C0D The groups of objects that are found by the table at #R$8BB1. The first
. byte of a group has the number of objects in bits 0-4, and the other bits are
. flags. The next two bytes are values that #R$BB3C shifts once for each object.
. If bit 4 of the count is set there is an extra byte. The objects follow, with
. three bytes each. A group with a first byte of #N$00 has no objects. Purpose
. of the individual bytes is not yet known.
N $8C0D A group that is not in the table.
B $8C0D,$01 Count and flags.
B $8C0E,$02,$01
B $8C10,$01 Extra byte.
B $8C11,$48,$03
N $8C59 Group #N$02.
B $8C59,$01 Count and flags.
B $8C5A,$02,$01
B $8C5C,$01 Extra byte.
B $8C5D,$33,$03
N $8C90 Group #N$03.
B $8C90,$01 Count and flags.
B $8C91,$02,$01
B $8C93,$01 Extra byte.
B $8C94,$42,$03
N $8CD6 Group #N$00.
B $8CD6,$01 Count and flags.
N $8CD7 Group #N$01.
B $8CD7,$01 Count and flags.
B $8CD8,$02,$01
B $8CDA,$01 Extra byte.
B $8CDB,$4E,$03
N $8D29 Group #N$06.
B $8D29,$01 Count and flags.
B $8D2A,$02,$01
B $8D2C,$2A,$03
N $8D56 Group #N$07.
B $8D56,$01 Count and flags.
B $8D57,$02,$01
B $8D59,$01 Extra byte.
B $8D5A,$33,$03
N $8D8D Group #N$04.
B $8D8D,$01 Count and flags.
B $8D8E,$02,$01
B $8D90,$01 Extra byte.
B $8D91,$51,$03
N $8DE2 Group #N$05.
B $8DE2,$01 Count and flags.
B $8DE3,$02,$01
B $8DE5,$01 Extra byte.
B $8DE6,$3C,$03
N $8E22 Group #N$08.
B $8E22,$01 Count and flags.
B $8E23,$02,$01
B $8E25,$01 Extra byte.
B $8E26,$33,$03
N $8E59 Group #N$09.
B $8E59,$01 Count and flags.
B $8E5A,$02,$01
B $8E5C,$2A,$03
N $8E86 Group #N$0A.
B $8E86,$01 Count and flags.
B $8E87,$02,$01
B $8E89,$01 Extra byte.
B $8E8A,$45,$03
N $8ECF Group #N$0B.
B $8ECF,$01 Count and flags.
B $8ED0,$02,$01
B $8ED2,$2D,$03
N $8EFF Group #N$0C.
B $8EFF,$01 Count and flags.
B $8F00,$02,$01
B $8F02,$01 Extra byte.
B $8F03,$3C,$03
N $8F3F Group #N$0D.
B $8F3F,$01 Count and flags.
B $8F40,$02,$01
B $8F42,$01 Extra byte.
B $8F43,$57,$03
N $8F9A Group #N$0E.
B $8F9A,$01 Count and flags.
B $8F9B,$02,$01
B $8F9D,$01 Extra byte.
B $8F9E,$3C,$03
N $8FDA Group #N$0F.
B $8FDA,$01 Count and flags.
B $8FDB,$02,$01
B $8FDD,$27,$03
N $9004 Group #N$10.
B $9004,$01 Count and flags.
B $9005,$02,$01
B $9007,$01 Extra byte.
B $9008,$39,$03
N $9041 Group #N$11.
B $9041,$01 Count and flags.
B $9042,$02,$01
B $9044,$01 Extra byte.
B $9045,$45,$03
N $908A Group #N$12.
B $908A,$01 Count and flags.
B $908B,$02,$01
B $908D,$2A,$03
N $90B7 Group #N$13.
B $90B7,$01 Count and flags.
B $90B8,$02,$01
B $90BA,$01 Extra byte.
B $90BB,$33,$03
N $90EE Group #N$14.
B $90EE,$01 Count and flags.
B $90EF,$02,$01
B $90F1,$01 Extra byte.
B $90F2,$3C,$03
N $912E Group #N$15.
B $912E,$01 Count and flags.
B $912F,$02,$01
B $9131,$1B,$03
N $914C Group #N$16.
B $914C,$01 Count and flags.
B $914D,$02,$01
B $914F,$01 Extra byte.
B $9150,$30,$03
N $9180 Group #N$17.
B $9180,$01 Count and flags.
B $9181,$02,$01
B $9183,$2D,$03
N $91B0 Group #N$18.
B $91B0,$01 Count and flags.
B $91B1,$02,$01
B $91B3,$15,$03
N $91C8 Group #N$19.
B $91C8,$01 Count and flags.
B $91C9,$02,$01
B $91CB,$01 Extra byte.
B $91CC,$3F,$03
N $920B Group #N$1A.
B $920B,$01 Count and flags.
B $920C,$02,$01
B $920E,$01 Extra byte.
B $920F,$39,$03
N $9248 Group #N$1B.
B $9248,$01 Count and flags.
B $9249,$02,$01
B $924B,$01 Extra byte.
B $924C,$39,$03
N $9285 Group #N$1C.
B $9285,$01 Count and flags.
B $9286,$02,$01
B $9288,$21,$03
N $92A9 Group #N$1D.
B $92A9,$01 Count and flags.
B $92AA,$02,$01
B $92AC,$01 Extra byte.
B $92AD,$54,$03
N $9301 Group #N$1E.
B $9301,$01 Count and flags.
B $9302,$02,$01
B $9304,$01 Extra byte.
B $9305,$45,$03
N $934A Group #N$1F.
B $934A,$01 Count and flags.
B $934B,$02,$01
B $934D,$18,$03
N $9365 Group #N$20.
B $9365,$01 Count and flags.
B $9366,$02,$01
B $9368,$2A,$03
N $9392 Group #N$21.
B $9392,$01 Count and flags.
B $9393,$02,$01
B $9395,$01 Extra byte.
B $9396,$3C,$03
N $93D2 Group #N$22.
B $93D2,$01 Count and flags.
B $93D3,$02,$01
B $93D5,$01 Extra byte.
B $93D6,$3C,$03
N $9412 Group #N$23.
B $9412,$01 Count and flags.
B $9413,$02,$01
B $9415,$27,$03
N $943C Group #N$24.
B $943C,$01 Count and flags.
B $943D,$02,$01
B $943F,$2D,$03
N $946C Group #N$25.
B $946C,$01 Count and flags.
B $946D,$02,$01
B $946F,$01 Extra byte.
B $9470,$30,$03
N $94A0 Group #N$26.
B $94A0,$01 Count and flags.
B $94A1,$02,$01
B $94A3,$27,$03
N $94CA Group #N$27.
B $94CA,$01 Count and flags.
B $94CB,$02,$01
B $94CD,$01 Extra byte.
B $94CE,$30,$03
N $94FE Group #N$28.
B $94FE,$01 Count and flags.
B $94FF,$02,$01
B $9501,$01 Extra byte.
B $9502,$3C,$03
N $953E Group #N$29.
B $953E,$01 Count and flags.
B $953F,$02,$01
B $9541,$2A,$03
N $956B Group #N$2A.
B $956B,$01 Count and flags.
B $956C,$02,$01
B $956E,$01 Extra byte.
B $956F,$3F,$03
N $95AE Group #N$2B.
B $95AE,$01 Count and flags.
B $95AF,$02,$01
B $95B1,$01 Extra byte.
B $95B2,$30,$03
N $95E2 Group #N$2C.
B $95E2,$01 Count and flags.
B $95E3,$02,$01
B $95E5,$01 Extra byte.
B $95E6,$3F,$03
N $9625 Group #N$2D.
B $9625,$01 Count and flags.
B $9626,$02,$01
B $9628,$01 Extra byte.
B $9629,$39,$03

c $9662 Add Score
@ $9662 label=AddScore
D $9662 Adds points to the score of the current player, which is kept as six
. digits in three bytes of binary coded decimal, and awards an extra life each
. time the score passes a multiple of 5000 points (see #R$D5DF(#N$D619)). It
. then prints the new score.
. .
. #PUSHS #UDGTABLE { #NEWGAME(0)
. #SCR$02,$00,$00,$06,$06(add-score-before)
. | #SIM(start=$9662,stop=$0000,bc=$1250,sp=$5B60)
. #SCR$02,$00,$00,$06,$06(add-score-after) } UDGTABLE# #POPS
E $9662 View the equivalent code in;
. #LIST
. { #ATICATAC$A19C }
. { #COOKIE$7415 }
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
R $9662 B The highest two digits of the points, in binary coded decimal
R $9662 C The lowest two digits of the points, in binary coded decimal
  $9662,$04 Fetch the highest two digits of the score and keep them in #REGd.
  $9666,$03 Fetch the middle two digits of the score.
  $9669,$02 Clear the flag in #REGe, which will show whether the score was
. already past the 5000 point mark.
  $966B,$04 Jump to #R$9670 if they are below #N$50.
  $966F,$01 Set the flag.
@ $9670 label=AddScore_Add
  $9670,$03 Point #REGhl at the score.
  $9673,$01 Fetch the lowest two digits of the points.
  $9674,$01 Add the lowest two digits of the score.
  $9675,$01 Adjust the result to binary coded decimal.
  $9676,$01 Store the new lowest two digits.
  $9677,$01 Move onto the middle two digits.
  $9678,$01 Fetch the middle two digits of the points.
  $9679,$01 Add the middle two digits of the score, with the carry.
  $967A,$01 Adjust the result to binary coded decimal.
  $967B,$01 Store the new middle two digits.
  $967C,$01 Move onto the highest two digits.
  $967D,$02 #REGa is #N$00.
  $967F,$01 Add the highest two digits of the score, with the carry.
  $9680,$01 Adjust the result to binary coded decimal.
  $9681,$01 Store the new highest two digits.
  $9682,$01 Fetch the flag.
  $9683,$01 Test it.
  $9684,$02 Jump to #R$9690 if the score was already past the 5000 point mark.
  $9686,$03 Fetch the middle two digits of the score.
  $9689,$02 Compare them with #N$50.
  $968B,$03 Call #R$D5DF(#N$D619) to award an extra life if the score has now
. passed the #N$5000 mark.
  $968E,$02 Jump to #R$9697 to print the score.

c $9690 Print Score
@ $9690 label=PrintScore
D $9690 Prints the score of the current player in the score panel. When it is
. entered at #R$9690, an extra life is awarded if the highest two digits of the
. score have changed.
R $9690 D The highest two digits of the score before the points were added
  $9690,$03 Fetch the highest two digits of the score.
  $9693,$01 Compare them with the old highest two digits.
  $9694,$03 Call #R$D5DF(#N$D619) to award an extra life if they have changed.
@ $9697 label=PrintScore_Digits
  $9697,$03 Point #REGhl at the highest two digits of the score.
  $969A,$03 Point #REGde at the digits of the score in the text record at
. #R$E11F(#N$E131).
  $969D,$02 Set the byte counter in #REGb to #N$03.
@ $969F label=PrintScore_Convert
  $969F,$01 Fetch two digits of the score.
  $96A0,$04 Move the upper digit into the lower four bits...
  $96A4,$02,b$01 ...and keep only that digit.
  $96A6,$01 Store it in the text record.
  $96A7,$01 Move onto the next character of the text record.
  $96A8,$01 Fetch the two digits again.
  $96A9,$02,b$01 Keep the lower digit.
  $96AB,$01 Store it in the text record.
  $96AC,$01 Move onto the next character of the text record.
  $96AD,$01 Move onto the next two digits of the score.
  $96AE,$02 Decrease the byte counter by one and jump back to #R$969F until all
. six digits have been converted.
  $96B0,$02 #REGa is #N$85, the length of the text with the flags for the double
. height.
  $96B2,$03 Store it as the first character of the text record.
  $96B5,$03 Point #REGde at #R$E12E.
  $96B8,$03 Jump to #R$A923 to print the score.

c $96BB Create Pickup
@ $96BB label=CreatePickup
D $96BB Tries to create a pickup in one of the two entity slots starting at
. #R$B540(#N$B5B2). The pickup is placed beside the view, on the side chosen by
. the low bits of a random number, at a position relative to the player, and it
. is given the type #N$0F.
  $96BB,$04 Point #REGix at the first of the two entity slots.
  $96BF,$02 Set the number of slots to look at in #REGb to #N$02.
  $96C1,$03 Call #R$979F to find a free slot.
  $96C4,$01 Return if there is no free slot.
  $96C5,$03 Call #R$98AE to clear the slot.
  $96C8,$03 Fetch the random number from #R$5F9A(#N$5F9B).
  $96CB,$02,b$01 Keep only bits 0-1, to choose the side.
  $96CD,$02 Jump to #R$96D6 unless the first side is chosen.
  $96CF,$03 #REGde is #N$0040, the offset for the first side.
  $96D2,$01 #REGe moves into #REGc.
  $96D3,$01 #REGd moves into #REGb, so the offset is also #REGbc.
  $96D4,$02 Jump to #R$96F7.

c $96D6 Choose Second Side
@ $96D6 label=CreatePickup_SecondSide
  $96D6,$01 Decrease the chosen side by one.
  $96D7,$02 Jump to #R$96E2 unless the second side is chosen.
  $96D9,$03 #REGde is #N$00A0, the offset for the second side.
  $96DC,$01 #REGe moves into #REGc.
  $96DD,$01 #REGd moves into #REGb, so the offset is also #REGbc.
  $96DE,$02 #REGa is #N$20, the direction for the second side.
  $96E0,$02 Jump to #R$96F7.

c $96E2 Choose Third Side
@ $96E2 label=CreatePickup_ThirdSide
  $96E2,$01 Decrease the chosen side by one.
  $96E3,$02 Jump to #R$96EF unless the third side is chosen.
  $96E5,$03 #REGbc is #N$00B0, the first offset for the third side.
  $96E8,$03 #REGde is #N$0030, the second offset for the third side.
  $96EB,$02 #REGa is #N$30, the direction for the third side.
  $96ED,$02 Jump to #R$96F7.

c $96EF Choose Fourth Side
@ $96EF label=CreatePickup_FourthSide
  $96EF,$03 #REGbc is #N$0030, the first offset for the fourth side.
  $96F2,$03 #REGde is #N$00B0, the second offset for the fourth side.
  $96F5,$02 #REGa is #N$10, the direction for the fourth side.
@ $96F7 label=CreatePickup_Place
  $96F7,$01 Copy the direction into #REGl.
  $96F8,$03 Fetch the random number.
  $96FB,$02 Shift it right twice...
  $96FD,$02,b$01 ...and keep bits 2-5.
  $96FF,$01 Add the direction.
  $9700,$02,b$01 Set bit 7.
  $9702,$03 Store it in field #N$11 of the pickup.
  $9705,$03 Fetch the view position from #R$5CE2(#N$5CE4).
  $9708,$01 Add the first offset.
  $9709,$03 Fetch the first coordinate of the player from #R$B540(#N$B548).
  $970C,$03 Store it in field #N$08 of the pickup.
  $970F,$01 Decrease it by one.
  $9710,$01 Keep it in #REGb.
  $9711,$03 Fetch the second coordinate of the player from #R$B540(#N$B549).
  $9714,$03 Store it in field #N$09 of the pickup.
  $9717,$01 Keep it in #REGc.
  $9718,$03 Subtract the coordinate of the player from the position.
  $971B,$03 Store the high byte in field #N$05 of the pickup.
  $971E,$03 Store the low byte in field #N$06 of the pickup.
  $9721,$03 Fetch the view position from #R$5CE2.
  $9724,$01 Add the second offset.
  $9725,$02 Add the coordinate of the player.
  $9727,$03 Store the high byte in field #N$02 of the pickup.
  $972A,$03 Store the low byte in field #N$03 of the pickup.
  $972D,$04 Set the type of the pickup to #N$0F.
  $9731,$03 Call #R$986C to set up the rest of the pickup.
  $9734,$04 Set field #N$10 of the pickup to #N$22.
  $9738,$04 Set field #N$1D of the pickup to #N$10.
  $973C,$02 #REGa is #N$08.
  $973E,$03 Set field #N$0B of the pickup to #N$08.
  $9741,$03 Set field #N$0C of the pickup to #N$08.
  $9744,$03 Set field #N$0D of the pickup to #N$08.
  $9747,$01 Return.

c $9748 Update Spawn Points
@ $9748 label=UpdateSpawnPoints
D $9748 Called every frame. Once in every #N$40 frames, on average, it creates
. a pickup (see #R$96BB). It then goes through the spawn points of the level,
. which have seven bytes each, counting down the delay of each one and, when the
. delay has run out, trying to create the entity the spawn point makes.
  $9748,$03 Fetch the low byte of the random seed from #R$5F9A.
  $974B,$02,b$01 Keep only bits 0-5.
  $974D,$03 Call #R$96BB to create a pickup if they are all zero.
  $9750,$03 Fetch the number of spawn points from #R$BD73.
  $9753,$01 Test it.
  $9754,$01 Return if there are none.
  $9755,$01 Set the spawn point counter in #REGb.
  $9756,$04 Point #REGiy at the first spawn point at #R$BD73(#N$BD74).
@ $975A label=UpdateSpawnPoints_Loop
  $975A,$01 Stash the spawn point counter on the stack.
  $975B,$02 Stash the address of the spawn point on the stack.
  $975D,$03 Fetch the delay of the spawn point.
  $9760,$01 Test it.
  $9761,$02 Jump to #R$9769 if it has run out.
  $9763,$01 Decrease the delay by one.
  $9764,$03 Store it.
  $9767,$02 Jump to #R$9790 to go on to the next spawn point.
@ $9769 label=UpdateSpawnPoints_Create
  $9769,$03 Fetch the kind of the spawn point.
  $976C,$01 Copy it into #REGa.
  $976D,$04 Jump to #R$9790 if it is #N($03), which makes nothing.
  $9771,$03 Multiply it by seven...
  $9774,$01 ...by multiplying by eight and subtracting the kind.
  $9775,$01 Move it into #REGe.
  $9776,$02 Clear #REGd.
  $9778,$04 Point #REGiy at #R$988B.
  $977C,$02 Add the offset of the kind to find its entry.
  $977E,$03 Fetch the low byte of the address of the first entity slot of the
. kind.
  $9781,$03 Fetch the high byte of the address of the first entity slot of the
. kind.
  $9784,$03 Copy it into #REGix (using the stack).
  $9787,$03 Fetch the number of entity slots of the kind into #REGb.
  $978A,$03 Call #R$979F to find a free slot.
  $978D,$03 Jump to #R$97AE if there is one, to create the entity.
@ $9790 label=UpdateSpawnPoints_Next
  $9790,$02 Restore the address of the spawn point from the stack.
@ $9792 label=UpdateSpawnPoints_Advance
  $9792,$03 #REGbc is #N$0007, the size of a spawn point.
  $9795,$02 Move onto the next spawn point.
  $9797,$01 Restore the spawn point counter from the stack.
  $9798,$02 Decrease the spawn point counter by one and jump back to #R$975A
. until all of the spawn points have been done.
  $979A,$01 Return.

b $979B Unused
@ $979B label=Unused_979B
D $979B Purpose not yet known. These bytes are not used by the game.
B $979B,$04

c $979F Find Free Entity
@ $979F label=FindFreeEntity
D $979F Looks for an unused entity (one with the type #N$00) in a run of
. entities.
R $979F IX The first entity
R $979F B The number of entities to look at
R $979F O:IX The unused entity, if one was found
R $979F O:F Zero flag set if an unused entity was found
  $979F,$03 #REGde is #N$0026, the size of an entity.
@ $97A2 label=FindFreeEntity_Loop
  $97A2,$03 Fetch the type of the entity.
  $97A5,$01 Test it.
  $97A6,$01 Return with the zero flag set if the entity is unused.
  $97A7,$02 Move onto the next entity.
  $97A9,$02 Decrease the entity counter by one and jump back to #R$97A2 until
. all of the entities have been looked at.
  $97AB,$02,b$01 Reset the zero flag, as no unused entity was found.
  $97AD,$01 Return.

c $97AE Create Spawned Entity
@ $97AE label=CreateSpawnedEntity
D $97AE Makes an entity from a spawn point, provided that the random number is
. odd. When it is created the spawn point is made to wait for #N$07 frames
. before it may create another entity. The entity which is made depends on its
. type: the code for types #N$00, #N$08 and #N$0E is different.
R $97AE IX The free entity
R $97AE IY The entry of the table of kinds (see #R$988B)
  $97AE,$03 Call #R$5F9E to get a random number.
  $97B1,$03 Fetch the low byte of the seed.
  $97B4,$02,b$01 Keep only bit 0.
  $97B6,$03 Jump to #R$9790 if it is zero, to leave this spawn point for now.
  $97B9,$03 Call #R$98AE to clear the entity.
  $97BC,$03 Fetch the type from the kind.
  $97BF,$03 Set the type of the entity.
  $97C2,$03 Fetch the first size from the kind.
  $97C5,$03 Set the x extent.
  $97C8,$03 Fetch the second size from the kind.
  $97CB,$03 Set the y extent.
  $97CE,$03 Fetch the third size from the kind.
  $97D1,$03 Set the z extent.
  $97D4,$02 Restore the address of the spawn point from the stack.
  $97D6,$04 Set the delay of the spawn point to #N$07.
  $97DA,$03 Fetch the first byte of the position from the spawn point.
  $97DD,$03 Set the low byte of the x coordinate.
  $97E0,$03 Fetch the second byte of the position from the spawn point.
  $97E3,$03 Set the high byte of the x coordinate.
  $97E6,$03 Fetch the third byte of the position from the spawn point.
  $97E9,$03 Set the low byte of the y coordinate.
  $97EC,$03 Fetch the fourth byte of the position from the spawn point.
  $97EF,$03 Set the high byte of the y coordinate.
  $97F2,$03 Fetch the fifth byte of the position from the spawn point.
  $97F5,$03 Set the middle byte of the z coordinate.
  $97F8,$04 Set the top byte of the z coordinate to #N$01.
  $97FC,$03 Fetch the type of the entity.
  $97FF,$01 Test it.
  $9800,$02 Jump to #R$984C if the type is #N$00.
  $9802,$04 Jump to #R$9856 if the type is #N$08.
  $9806,$04 Jump to #R$9820 if the type is #N$0E.
  $980A,$04 Set field #N$23 of the entity to #N$00.
  $980E,$04 Set field #N$1C of the entity to #N$04.
  $9812,$04 Set field #N$1D of the entity to #N$10.
  $9816,$03 Call #R$AF21 to set the sprite of the entity.
  $9819,$04 Set bit 4 of field #N$16 of the entity.
  $981D,$03 Jump to #R$9792 to go on to the next spawn point.

c $9820 Create Shot
@ $9820 label=CreateShot
D $9820 Makes a shot at the spawn point. The shot is nudged on by three along
. both axes, given a random heading in the low four bits, and sent off with
. the moving flag set.
R $9820 IX The shot
  $9820,$03 Play the brief buzz.
  $9823,$03 Fetch a random number.
  $9826,$02,b$01 Keep a heading from 0 to 15.
  $9828,$03 Keep that heading aside.
  $982B,$08 Nudge the low byte of the x coordinate on by three.
  $9833,$08 Nudge the low byte of the y coordinate on by three.
  $983B,$03 Set up the shot sprite.
  $983E,$03 Face the shot towards the player.
  $9841,$03 Fetch the heading that was kept aside.
  $9844,$02,b$01 Mark the shot as moving.
  $9846,$03 Use that value as the heading.
  $9849,$03 Go on to the next spawn point.

c $984C Create Spawned Creature
@ $984C label=CreateSpawnedEntity_Creature
  $984C,$04 Set bit 4 of field #N$16 of the entity.
  $9850,$03 Call #R$99FD.
  $9853,$03 Jump to #R$9792 to go on to the next spawn point.

c $9856 Create Spawned Growing Bubble
@ $9856 label=CreateSpawnedEntity_GrowingBubble
  $9856,$03 Fetch the low byte of the x coordinate.
  $9859,$02 Add #N$03.
  $985B,$03 Store it again.
  $985E,$03 Fetch the low byte of the y coordinate.
  $9861,$02 Add #N$06.
  $9863,$03 Store it again.
  $9866,$03 Call #R$986C to set up the rest of the entity.
  $9869,$03 Jump to #R$9792 to go on to the next spawn point.

c $986C Set Entity Defaults
@ $986C label=SetEntityDefaults
D $986C Sets the acceleration, the speed and the animation which an entity made
. by #R$96BB or #R$97AE has in common, and then measures its sprite.
R $986C IX The entity
  $986C,$04 Set the high byte of the acceleration to #N$FF.
  $9870,$04 Set the low byte of the acceleration to #N$B0.
  $9874,$04 Set the rate of change of the speed to #N$10.
  $9878,$04 Set the animation counter to #N$51.
  $987C,$04 Set the frame range to #N$76, so the frames run from 6 to 7.
  $9880,$04 Set the speed to #N$10.
  $9884,$04 Set the frame byte to #N$20.
  $9888,$03 Measure the sprite.

b $988B Spawn Kinds
@ $988B label=SpawnKinds
D $988B The kinds of entity which a spawn point can make, for #R$9748. Each kind
. is described by seven bytes: the address of the first of its entity slots, the
. number of slots, the type of entity and the three sizes of the entity. The
. kind #N$03 is not used.
W $988B,$02 The address of the first entity slot of kind #N$00.
B $988D,$01 The number of entity slots of kind #N$00.
B $988E,$01 The type of entity of kind #N$00.
B $988F,$03 The three sizes of entity of kind #N$00.
W $9892,$02 The address of the first entity slot of kind #N$01.
B $9894,$01 The number of entity slots of kind #N$01.
B $9895,$01 The type of entity of kind #N$01.
B $9896,$03 The three sizes of entity of kind #N$01.
W $9899,$02 The address of the first entity slot of kind #N$02.
B $989B,$01 The number of entity slots of kind #N$02.
B $989C,$01 The type of entity of kind #N$02.
B $989D,$03 The three sizes of entity of kind #N$02.
B $98A0,$07 Kind #N$03, which is not used.
W $98A7,$02 The address of the first entity slot of kind #N$04.
B $98A9,$01 The number of entity slots of kind #N$04.
B $98AA,$01 The type of entity of kind #N$04.
B $98AB,$03 The three sizes of entity of kind #N$04.

c $98AE Clear Entity
@ $98AE label=ClearEntity
D $98AE Sets all of the bytes of an entity to zero, using the stack.
R $98AE IX The entity
  $98AE,$03 Copy the address of the entity into #REGhl (using the stack).
  $98B1,$03 #REGde is #N$0026, the size of an entity.
  $98B4,$01 Point #REGhl at the end of the entity.
  $98B5,$04 Save the stack pointer in the operand of the instruction at
. #R$98AE(#N$98CF).
  $98B9,$01 Point the stack at the end of the entity.
  $98BA,$02 #REGde is #N$0000.
  $98BC,$13 Write #N$00 to the #N$26 bytes of the entity, #N$02 bytes at a time.
  $98CF,$03 Restore the stack pointer.
  $98D2,$01 Return.

c $98D3 Face Player
@ $98D3 label=FacePlayer
D $98D3 Chooses the direction in which an entity should head to move towards the
. player. If the direction (bits 4 and 5 of field #N$20 of the entity) is
. already the right one it is left alone, otherwise the new direction is set
. along with a random value in bits 1-3.
R $98D3 IX The entity
  $98D3,$02 Clear the direction bits in #REGb.
  $98D5,$03 Fetch the first byte of the first coordinate of the player from
. #R$B540(#N$B542).
  $98D8,$03 Subtract the first byte of the first coordinate of the entity.
  $98DB,$02 Jump to #R$98E3 if they are different.
  $98DD,$03 Fetch the second byte of the first coordinate of the player from
. #R$B540(#N$B543).
  $98E0,$03 Subtract the second byte of the first coordinate of the entity.
@ $98E3 label=FacePlayer_FirstDone
  $98E3,$02 Jump to #R$98E7 if the player is not before the entity on the first
. coordinate.
  $98E5,$02 Set bit 4 of the direction.
@ $98E7 label=FacePlayer_Second
  $98E7,$03 Fetch the first byte of the second coordinate of the player from
. #R$B540(#N$B545).
  $98EA,$03 Subtract the first byte of the second coordinate of the entity.
  $98ED,$02 Jump to #R$98F5 if they are different.
  $98EF,$03 Fetch the second byte of the second coordinate of the player from
. #R$B540(#N$B546).
  $98F2,$03 Subtract the second byte of the second coordinate of the entity.
@ $98F5 label=FacePlayer_SecondDone
  $98F5,$01 Fetch the direction.
  $98F6,$02 Jump to #R$98FA if the player is not before the entity on the second
. coordinate.
  $98F8,$02,b$01 Flip bits 4 and 5 of the direction.
@ $98FA label=FacePlayer_Compare
  $98FA,$01 Keep the direction in #REGb.
  $98FB,$03 Read field #N$20 of the entity.
  $98FE,$02,b$01 Use bits 4 and 5.
  $9900,$01 Compare them with the new direction.
  $9901,$01 Return if the entity is already heading that way.
  $9902,$03 Fetch the low byte of the random seed from #R$5F9A.
  $9905,$02,b$01 Use bits 1-3.
  $9907,$01 Add the new direction.
  $9908,$03 Store it in field #N$20 of the entity.
  $990B,$01 Return.

c $990C Turn Entity
@ $990C label=TurnEntity
D $990C Turns an entity by a step towards the heading in field #N$20, by
. changing bits 1-5 of the current heading in field #N$11.
R $990C B The size of the step
R $990C IX The entity
  $990C,$03 Fetch the current heading of the entity.
  $990F,$02,b$01 Use bits 1-5.
  $9911,$01 Copy it into #REGl.
  $9912,$03 Subtract the wanted heading of the entity.
  $9915,$01 Return if the entity is already heading that way.
  $9916,$02 Test bit 5 of the difference.
  $9918,$01 Fetch the size of the step.
  $9919,$02 Jump to #R$991D if the step is to be added.
  $991B,$02 Negate the step.
@ $991D label=TurnEntity_Apply
  $991D,$01 Add the step to the current heading.
  $991E,$02,b$01 Use bits 1-5.
  $9920,$03 Store the new heading of the entity.
  $9923,$01 Return.

c $9924 Start Burst
@ $9924 label=StartBurst
D $9924 Changes an entity into one of type #N$07, which is set up using #R$9F06.
R $9924 IX The entity
  $9924,$04 Set field #N$01 of the entity to #N$00.
  $9928,$04 Set the type of the entity to #N$07.
  $992C,$03 Call #R$AF21 to set the sprite of the entity.
  $992F,$04 Set field #N$1C of the entity to #N$04.
  $9933,$04 Set field #N$1D of the entity to #N$88.
  $9937,$03 Call #R$9F06.
  $993A,$03 Jump to #R$AE0D.

b $993D Entity Handlers
@ $993D label=EntityHandlers
D $993D The routines which update each type of entity, for #R$CEE2. The routine
. is found by adding twice the type of the entity to #N$993B, so there is no
. entry for the type #N$00.
W $993D,$22,$02

c $995F Set Up Creature
@ $995F label=SetUpCreature
D $995F Sets up an entity as one of four kinds of creature, using the templates
. at #R$99C7. The first level has only two kinds of creature and the second
. level has no kind #N$03.
R $995F A The kind of creature (#N$00-#N$03)
R $995F C The mask for the random heading
R $995F IX The entity
  $995F,$01 Copy the kind of creature into #REGb.
  $9960,$03 Fetch the number of the level from #R$DEDF.
  $9963,$01 Test it.
  $9964,$02 Jump to #R$9968 unless this is the first level.
  $9966,$02 Reset bit 1 of the kind, so that only the kinds #N$00 and #N$01 are
. used.
@ $9968 label=SetUpCreature_Level
  $9968,$01 Decrease the level by one.
  $9969,$02 Jump to #R$9972 unless this is the second level.
  $996B,$01 Fetch the kind of creature.
  $996C,$04 Jump to #R$9972 unless it is #N$03.
  $9970,$02 Use the kind #N$02 instead.
@ $9972 label=SetUpCreature_Template
  $9972,$01 Fetch the kind of creature.
  $9973,$02 Multiply it by four...
  $9975,$01 ...and keep it in #REGb.
  $9976,$01 Multiply it by eight...
  $9977,$01 ...and add the four times to make twelve times the kind, the size of
. a template.
  $9978,$03 Point #REGhl at #R$99C7.
  $997B,$03 Add the offset of the kind to find its template.
  $997E,$01 Fetch the type of the creature.
  $997F,$03 Set the type of the entity.
  $9982,$01 Move onto the next byte of the template.
  $9983,$01 Fetch the frame of the creature.
  $9984,$03 Set field #N$01 of the entity.
  $9987,$01 Move onto the next byte of the template.
  $9988,$01 Fetch the third byte of the template.
  $9989,$03 Set the speed.
  $998C,$01 Move onto the next byte of the template.
  $998D,$01 Fetch the fourth byte of the template.
  $998E,$03 Set field #N$14 of the entity.
  $9991,$01 Move onto the next byte of the template.
  $9992,$01 Fetch the fifth byte of the template.
  $9993,$03 Set field #N$15 of the entity.
  $9996,$01 Move onto the next byte of the template.
  $9997,$01 Fetch the sixth byte of the template.
  $9998,$03 Set field #N$1C of the entity.
  $999B,$01 Move onto the next byte of the template.
  $999C,$01 Fetch the seventh byte of the template.
  $999D,$03 Set field #N$1D of the entity.
  $99A0,$01 Move onto the next byte of the template.
  $99A1,$01 Fetch the eighth byte of the template.
  $99A2,$03 Set field #N$23 of the entity.
  $99A5,$01 Move onto the next byte of the template.
  $99A6,$01 Fetch the ninth byte of the template.
  $99A7,$03 Set the x extent.
  $99AA,$01 Move onto the next byte of the template.
  $99AB,$01 Fetch the tenth byte of the template.
  $99AC,$03 Set the y extent.
  $99AF,$01 Move onto the next byte of the template.
  $99B0,$01 Fetch the eleventh byte of the template.
  $99B1,$03 Set the z extent.
  $99B4,$01 Move onto the next byte of the template.
  $99B5,$01 Fetch the twelfth byte of the template.
  $99B6,$03 Set field #N$1B of the entity.
  $99B9,$04 Set field #N$13 of the entity to #N$00.
  $99BD,$03 Fetch the random number from #R$5F9A(#N$5F9B).
  $99C0,$01 Mask it with the heading mask.
  $99C1,$03 Set the heading.
  $99C4,$03 Jump to #R$AF21 to set the sprite of the entity.

b $99C7 Creature Templates
@ $99C7 label=CreatureTemplates
D $99C7 The four kinds of creature, for #R$995F. Each template has twelve bytes,
. which are copied into the fields #N$00, #N$01, #N$10, #N$14, #N$15, #N$1C,
. #N$1D, #N$23, #N$0B, #N$0C, #N$0D and #N$1B of the entity.
B $99C7,$0C Kind #N$00.
B $99D3,$0C Kind #N$01.
B $99DF,$0C Kind #N$02.
B $99EB,$0C Kind #N$03.

c $99F7 Make Creature
@ $99F7 label=MakeCreature
D $99F7 Sets up an entity as a random creature (see #R$99FD) and then carries on
. with the update of the entity at #R$CF3A.
  $99F7,$03 Call #R$99FD to set up a random creature.
  $99FA,$03 Jump to #R$CF3A.

c $99FD Create Random Creature
@ $99FD label=CreateRandomCreature
D $99FD Sets up an entity as a creature of a random kind, using #R$995F.
R $99FD IX The entity
  $99FD,$03 Call #R$5F9E to get a random number.
  $9A00,$03 Fetch the low byte of the seed.
  $9A03,$02,b$01 Use bits 0-1 to make the kind of the creature.
  $9A05,$02 Set the mask for the random heading to #N$3F.
  $9A07,$03 Jump to #R$995F.

c $9A0A Update Pickup Entity
@ $9A0A label=UpdatePickupEntity
D $9A0A Updates an entity of the type #N$0F, which is made by #R$96BB. While the
. frame of the entity is #N$00 or #N$01 it moves up or down on its third
. coordinate to line up with the player, and in one frame in every #N$80, on
. average, it changes into frame #N$02. Frame #N$03 is set up from a random
. choice of the table at #R$9AB6, and later frames count down in field #N$20
. until the entity is turned into one of type #N$07.
R $9A0A IX The entity
  $9A0A,$03 Fetch the frame of the entity.
  $9A0D,$02,b$01 Keep the number of the frame.
  $9A0F,$04 Jump to #R$9A55 if it is #N$02 or more.
  $9A13,$03 Fetch the first byte of the third coordinate of the player from
. #R$B540(#N$B548).
  $9A16,$01 Copy it into #REGh.
  $9A17,$03 Fetch the second byte of the third coordinate of the player from
. #R$B540(#N$B549).
  $9A1A,$01 Copy it into #REGl.
  $9A1B,$03 #REGbc is #N$0030.
  $9A1E,$01 Add it to the third coordinate of the player.
  $9A1F,$03 Fetch the first byte of the third coordinate of the entity.
  $9A22,$03 Fetch the second byte of the third coordinate of the entity.
  $9A25,$02 Subtract it from the third coordinate of the player.
  $9A27,$03 Set the speed to #N$0040, to move up.
  $9A2A,$02 Jump to #R$9A2F if the entity is below the player.
  $9A2C,$03 Set the speed to #N$FFC0, to move down.
@ $9A2F label=UpdatePickupEntity_SetSpeed
  $9A2F,$03 Store the first byte of the speed in field #N$14 of the entity.
  $9A32,$03 Store the second byte of the speed in field #N$15 of the entity.
  $9A35,$03 Call #R$5F9E to get a random number.
  $9A38,$03 Fetch the low byte of the seed.
  $9A3B,$02,b$01 Use bits 0-6.
  $9A3D,$03 Jump to #R$CF3A to carry on updating the entity unless they are all
. zero.
  $9A40,$04 Set the frame of the entity to #N$02.
  $9A44,$04 Set field #N$1C of the entity to #N$51.
  $9A48,$04 Set field #N$1D of the entity to #N$33.
  $9A4C,$03 Call #R$AF21 to set the sprite of the entity.
  $9A4F,$03 Call #R$9F55.
  $9A52,$03 Jump to #R$CF3A to carry on updating the entity.
@ $9A55 label=UpdatePickupEntity_LaterFrames
  $9A55,$05 Jump to #R$CF3A to carry on updating the entity if it is #N$02.
  $9A5A,$04 Jump to #R$9A8C unless it is #N$03.
  $9A5E,$03 Fetch the low byte of the seed.
  $9A61,$02,b$01 Use bits 1-2.
  $9A63,$03 Point #REGhl at #R$9AB6.
  $9A66,$03 Add the offset to find the entry.
  $9A69,$01 Fetch the frame from the entry.
  $9A6A,$03 Set the frame of the entity.
  $9A6D,$01 Move onto the next byte of the entry.
  $9A6E,$01 Fetch the value from the entry.
  $9A6F,$03 Set field #N$1D of the entity.
  $9A72,$04 Set field #N$20 of the entity to #N$40.
  $9A76,$04 Set field #N$1C of the entity to #N$03.
  $9A7A,$04 Set field #N$14 of the entity to #N$FF.
  $9A7E,$04 Set field #N$15 of the entity to #N$A0.
  $9A82,$03 Call #R$AF21 to set the sprite of the entity.
  $9A85,$04 Reset bit 7 of the heading.
  $9A89,$03 Jump to #R$CF3A to carry on updating the entity.
@ $9A8C label=UpdatePickupEntity_Countdown
  $9A8C,$03 Read field #N$1D of the entity.
  $9A8F,$04 Jump to #R$9AA7 unless it is #N$54.
  $9A93,$03 Call #R$98D3 to choose the direction towards the player.
  $9A96,$03 Read field #N$20 of the entity.
  $9A99,$02,b$01 Set bit 7.
  $9A9B,$03 Set the heading.
  $9A9E,$03 Read field #N$1F of the entity.
  $9AA1,$01 Test it.
  $9AA2,$03 Jump to #R$CF3A to carry on updating the entity if it is not zero.
  $9AA5,$02 Jump to #R$9AB0 to finish with the entity.
@ $9AA7 label=UpdatePickupEntity_Move
  $9AA7,$03 Call #R$9DDE.
  $9AAA,$03 Decrease field #N$20 of the entity by one.
  $9AAD,$03 Jump to #R$CF3A to carry on updating the entity unless it is zero.
@ $9AB0 label=UpdatePickupEntity_Finish
  $9AB0,$03 Call #R$9924 to turn the entity into one of type #N$07.
  $9AB3,$03 Jump to #R$CF3A to carry on updating the entity.

b $9AB6 Pickup Frames
@ $9AB6 label=PickupFrames
D $9AB6 The frames and values of field #N$1D which #R$9A0A chooses between at
. random when an entity changes into frame #N$03.
B $9AB6,$08,$02

c $9ABE Make Entity Sound
@ $9ABE label=MakeEntitySound
D $9ABE Plays four short tones, with a pitch which depends on field #N$20 of the
. entity, and carries on with the update of the entity.
. .
. #HTML(#AUDIO0(entity-sound.wav)(#INCLUDE(EntitySound)))
R $9ABE IX The entity
  $9ABE,$03 Read field #N$20 of the entity.
  $9AC1,$02,b$01 Flip bits 0-4.
  $9AC3,$01 Keep it in #REGb.
  $9AC4,$02 Multiply it by four...
  $9AC6,$01 ...and add it to make five times the value.
  $9AC7,$02 Add #N$10 to make the length of the tones.
  $9AC9,$01 Set the length of the tones in #REGb.
  $9ACA,$03 Call #R$9E93 to play a tone.
  $9ACD,$03 Call #R$9E93 to play a tone.
  $9AD0,$03 Call #R$9E93 to play a tone.
  $9AD3,$03 Call #R$9E93 to play a tone.
  $9AD6,$03 Jump to #R$CF3D to carry on updating the entity.

c $9AD9 Update Growing Bubble Entity
@ $9AD9 label=UpdateGrowingBubbleEntity
D $9AD9 Updates an entity of the type #N$08. Field #N$20 counts the frames and
. field #N$23 holds the state of the entity. The entity moves up or down on its
. third coordinate depending on field #N$1F.
R $9AD9 IX The entity
  $9AD9,$03 Increase field #N$20 of the entity by one.
  $9ADC,$03 Fetch the frame of the entity.
  $9ADF,$02,b$01 Keep the number of the frame.
  $9AE1,$04 Jump to #R$9AEC unless it is #N$06.
  $9AE5,$07 Jump to #R$99F7 if bit 1 of field #N$23 of the entity is set.
@ $9AEC label=UpdateGrowingBubbleEntity_Speed
  $9AEC,$03 Read field #N$1F of the entity.
  $9AEF,$01 Add one.
  $9AF0,$03 Set the speed to #N$0028, to move up.
  $9AF3,$04 Jump to #R$9AFA if it is below #N$24.
  $9AF7,$03 Set the speed to #N$FFD8, to move down.
@ $9AFA label=UpdateGrowingBubbleEntity_SetSpeed
  $9AFA,$03 Store the first byte of the speed in field #N$14 of the entity.
  $9AFD,$03 Store the second byte of the speed in field #N$15 of the entity.
  $9B00,$03 Read field #N$23 of the entity.
  $9B03,$04 Jump to #R$9B49 if bit 0 is set.
  $9B07,$03 Fetch the frame of the entity.
  $9B0A,$02,b$01 Keep the number of the frame.
  $9B0C,$05 Jump to #R$9ABE if it is below #N$05.
  $9B11,$02 Jump to #R$9B36 if it is above #N$05.
  $9B13,$04 Fetch the low byte of the seed from #R$5F9A and keep it in #REGb.
  $9B17,$02,b$01 Use bits 6-7.
  $9B19,$02 Jump to #R$9B49 if they are zero.
  $9B1B,$01 Fetch the random number.
  $9B1C,$02,b$01 Use bits 0-5.
  $9B1E,$02,b$01 Set bit 7.
  $9B20,$03 Set the heading.
  $9B23,$03 Fetch the random number from #R$5F9A(#N$5F9B).
  $9B26,$02,b$01 Use bits 2-5 and 7.
  $9B28,$02 Add #N$40.
  $9B2A,$03 Store it in field #N$23 of the entity.
  $9B2D,$03 Move onto the next frame.
  $9B30,$03 Call #R$AF21 to set the sprite of the entity.
  $9B33,$03 Jump to #R$CF3A to carry on updating the entity.
@ $9B36 label=UpdateGrowingBubbleEntity_Countdown
  $9B36,$03 Fetch the low byte of the frame counter from #R$A2DD.
  $9B39,$01 Rotate bit 0 into the carry flag.
  $9B3A,$02 Jump to #R$9B46 if it is set.
  $9B3C,$01 Read field #N$23 of the entity.
  $9B3D,$02 Subtract #N$04.
  $9B3F,$02 Jump to #R$9B43 if there was no carry.
  $9B41,$02 Set the value to #N$01.
@ $9B43 label=UpdateGrowingBubbleEntity_Store
  $9B43,$03 Store it in field #N$23 of the entity.
@ $9B46 label=UpdateGrowingBubbleEntity_Done
  $9B46,$03 Jump to #R$CF3A to carry on updating the entity.
@ $9B49 label=UpdateGrowingBubbleEntity_Change
  $9B49,$03 Call #R$9F55.
  $9B4C,$03 Fetch the frame of the entity.
  $9B4F,$02,b$01 Use bits 5-7.
  $9B51,$02,b$01 Set the number of the frame to #N$08.
  $9B53,$03 Store it.
  $9B56,$03 Call #R$AF21 to set the sprite of the entity.
  $9B59,$04 Set field #N$1C of the entity to #N$51.
  $9B5D,$04 Set field #N$23 of the entity to #N$82.
  $9B61,$02 Jump to #R$9B46.

c $9B63 Update Basic Entity
@ $9B63 label=UpdateBasicEntity
D $9B63 Updates an entity of the type #N$01, #N$02 or #N$03, by passing it
. straight on to #R$CF30.
R $9B63 IX The entity
  $9B63,$03 Jump to #R$CF30 to carry on updating the entity.

c $9B66 Reset Entity Movement
@ $9B66 label=ResetEntityMovement
D $9B66 Resets bit 7 of the heading of an entity. If field #N$1F of the entity
. is not zero then this routine does not return to its caller, but jumps to
. #R$CF3A to carry on updating the entity. Otherwise bit 7 of field #N$23 is
. reset too.
R $9B66 IX The entity
  $9B66,$04 Reset bit 7 of the heading.
  $9B6A,$03 Read field #N$1F of the entity.
  $9B6D,$01 Add one.
  $9B6E,$02 Compare it with #N$02.
  $9B70,$01 Drop the return address into #REGhl.
  $9B71,$03 Jump to #R$CF3A to carry on updating the entity if the value was
. #N$02 or more.
  $9B74,$04 Reset bit 7 of field #N$23 of the entity.
  $9B78,$01 Return to the caller.

c $9B79 Test Entity Removal
@ $9B79 label=TestEntityRemoval
D $9B79 Calls #R$AEB0 with #REGbc set to #N$0020 and, if that returns with the
. zero flag set, frees the entity and hides its sprite.
R $9B79 IX The entity
  $9B79,$03 Set the value to test to #N$0020.
  $9B7C,$03 Call #R$AEB0.
  $9B7F,$01 Return if the zero flag is not set.
  $9B80,$04 Set the type of the entity to #N$00, to free it.
  $9B84,$04 Set bit 7 of the frame of the entity, to hide it.
  $9B88,$01 Return.

c $9B89 Update Foam Entity
@ $9B89 label=UpdateFoamEntity
D $9B89 Updates an entity of the type #N$0A, which is made from the first kind
. of creature at #R$99C7. Roughly once in every #N$20 frames it flips bits of
. field #N$1D, and once in every #N$40 frames it chooses a new direction towards
. the player.
R $9B89 IX The entity
  $9B89,$03 Fetch the random number from #R$5F9A(#N$5F9B).
  $9B8C,$02,b$01 Use bits 0-4.
  $9B8E,$02 Jump to #R$9B98 unless they are all zero.
  $9B90,$03 Read field #N$1D of the entity.
  $9B93,$02,b$01 Flip bits 2, 6 and 7.
  $9B95,$03 Store it in field #N$1D of the entity.
@ $9B98 label=UpdateFoamEntity_Test
  $9B98,$03 Call #R$9B79 to test whether the entity should be removed.
  $9B9B,$03 Call #R$9DF8.
  $9B9E,$04 Test bit 7 of field #N$23 of the entity.
  $9BA2,$03 Call #R$9B66 if it is set.
  $9BA5,$03 Fetch the low byte of the seed from #R$5F9A.
  $9BA8,$02,b$01 Use bits 0-5.
  $9BAA,$03 Call #R$98D3 to choose the direction towards the player if they are
. all zero.
  $9BAD,$02 Set the size of the step to #N$01.
  $9BAF,$03 Call #R$990C to turn the entity towards the wanted heading.
  $9BB2,$04 Set bit 7 of the heading of the entity.
  $9BB6,$03 Jump to #R$CF3A to carry on updating the entity.

c $9BB9 Update Whirler Entity
@ $9BB9 label=UpdateWhirlerEntity
D $9BB9 Updates an entity of the type #N$11, which is made from the third kind
. of creature at #R$99C7. Field #N$23 counts down the frames between random
. changes of its speed and its direction.
R $9BB9 IX The entity
  $9BB9,$03 Call #R$9DF8.
  $9BBC,$04 Test bit 7 of field #N$23 of the entity.
  $9BC0,$03 Call #R$9B66 if it is set.
  $9BC3,$03 Decrease field #N$23 of the entity by one.
  $9BC6,$03 Jump to #R$CF3A to carry on updating the entity unless it is zero.
  $9BC9,$03 Fetch the random number from #R$5F9A(#N$5F9B).
  $9BCC,$04 Set field #N$1D of the entity to #N$30.
  $9BD0,$01 Rotate bit 7 of the random number into the carry flag.
  $9BD1,$02 Jump to #R$9BD7 if it is set.
  $9BD3,$04 Set field #N$1D of the entity to #N$63.
@ $9BD7 label=UpdateWhirlerEntity_Speed
  $9BD7,$02,b$01 Use bits 5-7 of the rotated value.
  $9BD9,$02 Jump to #R$9BDF unless they are all zero.
  $9BDB,$04 Set field #N$12 of the entity to #N$03.
@ $9BDF label=UpdateWhirlerEntity_Delay
  $9BDF,$04 Fetch the low byte of the seed from #R$5F9A and keep it in #REGb.
  $9BE3,$02,b$01 Use bits 0-5.
  $9BE5,$03 Store it as the new delay in field #N$23 of the entity.
  $9BE8,$01 Fetch the random number.
  $9BE9,$02,b$01 Use bits 6-7.
  $9BEB,$02 Jump to #R$9BF4 unless they are both zero.
  $9BED,$04 Set the speed to #N$00.
  $9BF1,$03 Jump to #R$CF3A to carry on updating the entity.
@ $9BF4 label=UpdateWhirlerEntity_Direction
  $9BF4,$01 Shift bits 6-7 of the random number...
  $9BF5,$01 ...down to bits 4-5.
  $9BF6,$02,b$01 Use bits 4-5.
  $9BF8,$02 Add #N$10.
  $9BFA,$01 Keep the new value in #REGb.
  $9BFB,$03 Fetch the speed.
  $9BFE,$02,b$01 Use bits 0-3.
  $9C00,$01 Combine them with the new value.
  $9C01,$03 Set the speed.
  $9C04,$03 Fetch the random number from #R$5F9A(#N$5F9B).
  $9C07,$02,b$01 Use bits 0-3.
  $9C09,$03 Set field #N$20 of the entity, the wanted heading.
  $9C0C,$03 Call #R$98D3 to choose the direction towards the player.
  $9C0F,$03 Read field #N$20 of the entity.
  $9C12,$02,b$01 Set bit 7.
  $9C14,$03 Set the heading.
  $9C17,$03 Jump to #R$CF3A to carry on updating the entity.

c $9C1A Update Bat Entity
@ $9C1A label=UpdateBatEntity
D $9C1A Updates an entity of the type #N$0B, which is made from the second kind
. of creature at #R$99C7. Field #N$23 is a countdown which is set from the
. random number when the entity is stopped.
R $9C1A IX The entity
  $9C1A,$03 Call #R$9B79 to test whether the entity should be removed.
  $9C1D,$03 Call #R$9DF8.
  $9C20,$04 Test bit 7 of field #N$23 of the entity.
  $9C24,$03 Call #R$9B66 if it is set.
  $9C27,$07 Jump to #R$CF3A to carry on updating the entity if bit 7 of the
. flags is not set.
  $9C2E,$04 Set the frame of the entity to #N$01.
  $9C32,$04 Set the speed to #N$00.
  $9C36,$04 Set the heading of the entity to #N$00.
  $9C3A,$03 Read field #N$23 of the entity.
  $9C3D,$01 Test it.
  $9C3E,$02 Jump to #R$9C6C if it is zero.
  $9C40,$01 Decrease the countdown by one.
  $9C41,$03 Store it in field #N$23 of the entity.
  $9C44,$03 Jump to #R$CF3A to carry on updating the entity unless it is zero.
  $9C47,$03 Call #R$98D3 to choose the direction towards the player.
  $9C4A,$03 Read field #N$20 of the entity.
  $9C4D,$02,b$01 Set bit 7.
  $9C4F,$03 Set the heading.
  $9C52,$04 Fetch the random number from #R$5F9A(#N$5F9B) and keep it in #REGb.
  $9C56,$02,b$01 Keep bit 4.
  $9C58,$02 Add #N$10.
  $9C5A,$03 Set the speed.
  $9C5D,$01 Fetch the random number.
  $9C5E,$02,b$01 Use bits 0-1.
  $9C60,$02 Add #N$03.
  $9C62,$03 Store it in field #N$12 of the entity.
  $9C65,$04 Set field #N$13 of the entity to #N$00.
  $9C69,$03 Jump to #R$CF3A to carry on updating the entity.
@ $9C6C label=UpdateBatEntity_Delay
  $9C6C,$03 Fetch the random number from #R$5F9A(#N$5F9B).
  $9C6F,$02,b$01 Use bits 1-4.
  $9C71,$01 Add one.
  $9C72,$03 Store it as the countdown in field #N$23 of the entity.
  $9C75,$03 Jump to #R$CF3A to carry on updating the entity.

c $9C78 Update Drop Entity
@ $9C78 label=UpdateDropEntity
D $9C78 Updates an entity of the type #N$04. Every other frame it calls #R$9DF8.
R $9C78 IX The entity
  $9C78,$03 Fetch the low byte of the frame counter from #R$A2DD.
  $9C7B,$02,b$01 Keep bit 0.
  $9C7D,$03 Call #R$9DF8 on every other frame.
  $9C80,$04 Set bit 7 of the heading of the entity.
  $9C84,$07 Jump to #R$CF3A to carry on updating the entity if bit 7 of field
. #N$23 of the entity is not set.
  $9C8B,$03 Read field #N$1F of the entity.
  $9C8E,$01 Add one.
  $9C8F,$02 Compare it with #N$02.
  $9C91,$04 Reset bit 7 of field #N$23 of the entity.
  $9C95,$03 Jump to #R$CF3A to carry on updating the entity if it was below
. #N$02.
  $9C98,$04 Set bit 7 of field #N$23 of the entity.
  $9C9C,$04 Reset bit 7 of the heading of the entity.
  $9CA0,$03 Jump to #R$CF3A to carry on updating the entity.

c $9CA3 Set Up Shot Sprite
@ $9CA3 label=SetUpShotSprite
D $9CA3 Sets the speed and sprite fields of an entity of the type #N$0E, which
. is made by #R$9CBA, and then sets its sprite.
R $9CA3 IX The entity
  $9CA3,$04 Set the speed to #N$44.
  $9CA7,$04 Set field #N$14 of the entity to #N$FF.
  $9CAB,$04 Set field #N$15 of the entity to #N$C8.
  $9CAF,$04 Set field #N$1C of the entity to #N$04.
  $9CB3,$04 Set field #N$1D of the entity to #N$30.
  $9CB7,$03 Jump to #R$AF21 to set the sprite of the entity.

c $9CBA Update Saucer Entity
@ $9CBA label=UpdateSaucerEntity
D $9CBA Updates an entity of the type #N$09, which is made from the fourth kind
. of creature at #R$99C7. On odd frames it turns towards the player, and on
. average once in every #N$20 frames it fires a new entity of the type #N$0E
. from the position of this one, if there is a free entity to use.
R $9CBA IX The entity
  $9CBA,$03 Call #R$9DF8.
  $9CBD,$03 Fetch the low byte of the frame counter from #R$A2DD.
  $9CC0,$01 Rotate bit 0 into the carry flag.
  $9CC1,$03 Call #R$98D3 on odd frames to choose the direction towards the
. player.
  $9CC4,$02 Set the size of the step to #N$02.
  $9CC6,$03 Call #R$990C to turn the entity towards the wanted heading.
  $9CC9,$03 Fetch the low byte of the seed from #R$5F9A.
  $9CCC,$02,b$01 Use bits 0-4.
  $9CCE,$02 Jump to #R$9D3E unless they are all zero.
  $9CD0,$04 Copy the address of the entity into #REGiy (using the stack).
  $9CD4,$04 Point #REGix at #R$B5B2.
  $9CD8,$02 Look at #N$02 entities.
  $9CDA,$03 Call #R$979F to find a free entity.
  $9CDD,$02 Jump to #R$9D3E if there is not one.
  $9CDF,$03 Call #R$9F6F.
  $9CE2,$03 Call #R$98AE to clear the new entity.
  $9CE5,$04 Set the type of the new entity to #N$0E.
  $9CE9,$04 Set the frame of the new entity to #N$20.
  $9CED,$03 #REGbc is #N$0008.
  $9CF0,$03 Fetch the first byte of the first coordinate of this entity.
  $9CF3,$03 Fetch the second byte of the first coordinate of this entity.
  $9CF6,$01 Add #N$0008.
  $9CF7,$03 Store the first byte of the first coordinate of the new entity.
  $9CFA,$03 Store the second byte of the first coordinate of the new entity.
  $9CFD,$03 Fetch the first byte of the second coordinate of this entity.
  $9D00,$03 Fetch the second byte of the second coordinate of this entity.
  $9D03,$01 Add #N$0008.
  $9D04,$03 Store the first byte of the second coordinate of the new entity.
  $9D07,$03 Store the second byte of the second coordinate of the new entity.
  $9D0A,$02 #REGc is #N$03.
  $9D0C,$03 Fetch the first byte of the third coordinate of this entity.
  $9D0F,$03 Fetch the second byte of the third coordinate of this entity.
  $9D12,$03 Store the first byte of the third coordinate of the new entity.
  $9D15,$03 Store the second byte of the third coordinate of the new entity.
  $9D18,$04 Set the first size of the new entity to #N$04.
  $9D1C,$04 Set the second size of the new entity to #N$04.
  $9D20,$04 Set the third size of the new entity to #N$04.
  $9D24,$03 Call #R$9CA3 to set up the sprite of the new entity.
  $9D27,$03 Fetch the low byte of the seed from #R$5F9A.
  $9D2A,$02,b$01 Use bits 0-3.
  $9D2C,$03 Set field #N$20 of the new entity, the wanted heading.
  $9D2F,$03 Call #R$98D3 to choose the direction towards the player.
  $9D32,$03 Read field #N$20 of the new entity.
  $9D35,$02,b$01 Set bit 7.
  $9D37,$03 Store it in field #N$11 of the new entity, the heading.
  $9D3A,$04 Copy the address of this entity back into #REGix (using the stack).
@ $9D3E label=UpdateSaucerEntity_Speed
  $9D3E,$03 Read field #N$12 of the entity.
  $9D41,$01 Test it.
  $9D42,$02 Jump to #R$9D5C if it is not zero.
  $9D44,$03 Read field #N$1F of the entity.
  $9D47,$01 Add one.
  $9D48,$02 Compare it with #N$09.
  $9D4A,$02 Set the speed to #N$00.
  $9D4C,$03 Store the first byte of the speed in field #N$14 of the entity.
  $9D4F,$03 Store the second byte of the speed in field #N$15 of the entity.
  $9D52,$02 Jump to #R$9D59 if field #N$1F was #N$08.
  $9D54,$01 Set the value to #N$01.
  $9D55,$02 Jump to #R$9D59 if field #N$1F was below #N$08.
  $9D57,$02 Set the value to #N$FF.
@ $9D59 label=UpdateSaucerEntity_SetStep
  $9D59,$03 Store it in field #N$12 of the entity.
@ $9D5C label=UpdateSaucerEntity_Done
  $9D5C,$04 Set field #N$13 of the entity to #N$00.
  $9D60,$04 Set bit 7 of the heading of the entity.
  $9D64,$03 Jump to #R$CF3A to carry on updating the entity.

c $9D67 Update Burst Entity
@ $9D67 label=UpdateBurstEntity
D $9D67 Updates an entity of the type #N$07, which is made by #R$9924. It plays
. two clicks, and when it reaches frame #N$07 it hides itself and frees its
. slot.
R $9D67 IX The entity
  $9D67,$03 Fetch the low byte of the seed from #R$5F9A.
  $9D6A,$02,b$01 Use bits 0-4.
  $9D6C,$02 Add #N$50 to make the length of the clicks.
  $9D6E,$01 Set the length of the clicks in #REGb.
  $9D6F,$03 Call #R$9E93 to play a click.
  $9D72,$03 Call #R$9E93 to play a click.
  $9D75,$03 Fetch the frame of the entity.
  $9D78,$02,b$01 Keep the number of the frame.
  $9D7A,$05 Jump to #R$CF3D to carry on updating the entity unless it is #N$07.
  $9D7F,$04 Set the frame of the entity to #N$80, to hide it.
  $9D83,$03 Call #R$AF21 to set the sprite of the entity.
  $9D86,$04 Set the type of the entity to #N$00, to free it.
  $9D8A,$03 Jump to #R$CF44.

c $9D8D Update Spider Entity
@ $9D8D label=UpdateSpiderEntity
D $9D8D Updates an entity of the type #N$10. If the player touches it then it is
. drawn as normal, otherwise it is freed (see #R$9DAB).
R $9D8D IX The entity
  $9D8D,$03 Set the value to test to #N$0020.
  $9D90,$03 Call #R$AEB0.
  $9D93,$02 Jump to #R$9D9B if the zero flag is set.
  $9D95,$03 Call #R$AE0D.
  $9D98,$03 Jump to #R$CF44.
@ $9D9B label=UpdateSpiderEntity_Free
  $9D9B,$02 Jump to #R$9DAB to free the entity.

c $9D9D Update Disc Entity
@ $9D9D label=UpdateDiscEntity
D $9D9D Updates an entity of the type #N$0C, in the same way as #R$9D8D but with
. a different value to test.
R $9D9D IX The entity
  $9D9D,$03 Set the value to test to #N$0018.
  $9DA0,$03 Call #R$AEB0.
  $9DA3,$02 Jump to #R$9DAB if the zero flag is set.
  $9DA5,$03 Call #R$AE0D.
  $9DA8,$03 Jump to #R$CF44.
@ $9DAB label=FreeLinkedEntity
N $9DAB Frees an entity, and resets bit 7 of the third byte of the record that
. field #N$1A of the entity points to.
  $9DAB,$04 Set the type of the entity to #N$00, to free it.
  $9DAF,$03 Fetch the first byte of the address of the record from field #N$1A.
  $9DB2,$03 Fetch the second byte of the address of the record from field #N$1B.
  $9DB5,$01 Move onto the second byte of the record.
  $9DB6,$01 Move onto the third byte of the record.
  $9DB7,$02 Reset bit 7 of the third byte of the record.
  $9DB9,$04 Set the frame of the entity to #N$80, to hide it.
  $9DBD,$03 Jump to #R$CF44.

c $9DC0 Update Sparkle Entity
@ $9DC0 label=UpdateSparkleEntity
D $9DC0 Updates an entity of the type #N$0D. Field #N$23 counts down the number
. of frames that the entity lasts for. It plays a buzz on every frame and flips
. bit 0 of its frame.
R $9DC0 IX The entity
  $9DC0,$03 Call #R$9EEA to play a buzz.
  $9DC3,$03 Decrease field #N$23 of the entity by one.
  $9DC6,$02 Jump to #R$9DD3 if it is not zero.
  $9DC8,$04 Set the type of the entity to #N$00, to free it.
  $9DCC,$04 Set bit 7 of the frame of the entity, to hide it.
  $9DD0,$03 Jump to #R$CF44.
@ $9DD3 label=UpdateSparkleEntity_Flip
  $9DD3,$03 Fetch the frame of the entity.
  $9DD6,$02,b$01 Flip bit 0.
  $9DD8,$03 Store it.
  $9DDB,$03 Jump to #R$CF3D to carry on updating the entity.

c $9DDE Decrease Entity Counter
@ $9DDE label=DecreaseEntityCounter
D $9DDE Decreases the counter in the high nibble of field #N$16 of an entity by
. one. When the counter reaches zero the entity is freed and hidden.
R $9DDE IX The entity
  $9DDE,$03 Read field #N$16 of the entity.
  $9DE1,$02,b$01 Keep the counter.
  $9DE3,$01 Return if it is zero.
  $9DE4,$03 Read field #N$16 of the entity.
  $9DE7,$02 Subtract one from the counter.
  $9DE9,$03 Store it.
  $9DEC,$02,b$01 Keep the counter.
  $9DEE,$01 Return if it is not zero.
  $9DEF,$04 Set the type of the entity to #N$00, to free it.
  $9DF3,$04 Set bit 7 of the frame of the entity, to hide it.
  $9DF7,$01 Return.

c $9DF8 Increase Entity Counter
@ $9DF8 label=IncreaseEntityCounter
D $9DF8 Increases the counter in the high nibble of field #N$16 of an entity by
. one, if it is not zero, and wraps it to zero after #N$08. Then plays a click
. of a random length.
R $9DF8 IX The entity
  $9DF8,$03 Read field #N$16 of the entity.
  $9DFB,$01 Keep it in #REGb.
  $9DFC,$02,b$01 Keep the counter.
  $9DFE,$01 Return if it is zero.
  $9DFF,$02 Add one to the counter.
  $9E01,$04 Jump to #R$9E06 if it is below #N$90.
  $9E05,$01 Set the counter to zero.
@ $9E06 label=IncreaseEntityCounter_Store
  $9E06,$01 Keep the new counter in #REGc.
  $9E07,$01 Fetch the old value of field #N$16.
  $9E08,$02,b$01 Keep the low nibble.
  $9E0A,$01 Combine it with the new counter.
  $9E0B,$03 Store it in field #N$16 of the entity.
  $9E0E,$03 Fetch the low byte of the seed from #R$5F9A.
  $9E11,$02,b$01 Use bits 0-5.
  $9E13,$01 Add one.
  $9E14,$03 Jump to #R$9E93 to play a click.

c $9E17 Update Puff Entity
@ $9E17 label=UpdatePuffEntity
D $9E17 Updates an entity of the type #N$05. When it is in frame #N$01 the low
. nibble of field #N$23 counts down, and when that runs out the entity is freed.
R $9E17 IX The entity
  $9E17,$03 Fetch the frame of the entity.
  $9E1A,$02,b$01 Use bits 0-3.
  $9E1C,$01 Subtract one.
  $9E1D,$02 Jump to #R$9E34 unless it is frame #N$01.
  $9E1F,$03 Set the speed to #N$00.
  $9E22,$03 Read field #N$23 of the entity.
  $9E25,$01 Keep it in #REGb.
  $9E26,$02,b$01 Keep the low nibble.
  $9E28,$02 Subtract one.
  $9E2A,$02 Jump to #R$9E3B if it was zero.
  $9E2C,$01 Keep the new count in #REGc.
  $9E2D,$01 Read field #N$23 of the entity.
  $9E2E,$02,b$01 Keep the high nibble.
  $9E30,$01 Combine it with the new count.
  $9E31,$03 Store it in field #N$23 of the entity.
@ $9E34 label=UpdatePuffEntity_Test
  $9E34,$07 Jump to #R$CF30 if bit 7 of the frame of the entity is not set.
@ $9E3B label=FreeEntity
  $9E3B,$04 Set the type of the entity to #N$00, to free it.
  $9E3F,$04 Set bit 7 of the frame of the entity, to hide it.
  $9E43,$03 Jump to #R$CF44.

c $9E46 Update Shot Entity
@ $9E46 label=UpdateShotEntity
D $9E46 Updates an entity of the type #N$0E, which is made by #R$9CBA. The
. entity falls until its third coordinate reaches #N$0103.
R $9E46 IX The entity
  $9E46,$03 Read field #N$16 of the entity.
  $9E49,$02,b$01 Keep the counter.
  $9E4B,$02 Jump to #R$9E53 if it is zero.
  $9E4D,$03 Call #R$9DDE to count down.
  $9E50,$03 Jump to #R$CF3D to carry on updating the entity.
@ $9E53 label=UpdateShotEntity_Fall
  $9E53,$03 Fetch the first byte of the third coordinate of the entity.
  $9E56,$01 Subtract one.
  $9E57,$02 Jump to #R$9E34 unless it was #N$01.
  $9E59,$03 Fetch the second byte of the third coordinate of the entity.
  $9E5C,$04 Jump to #R$9E34 if it is #N$03 or more.
  $9E60,$04 Set the second byte of the third coordinate to #N$03.
  $9E64,$01 Set #REGa to zero.
  $9E65,$03 Set field #N$12 of the entity to zero.
  $9E68,$03 Set field #N$13 of the entity to zero.
  $9E6B,$02 Jump to #R$9E34.

c $9E6D Update Dome Entity
@ $9E6D label=UpdateDomeEntity
D $9E6D Updates an entity of the type #N$06, which rises by one unit of its
. third coordinate on every frame until the countdown in field #N$23 reaches
. zero, when it is freed.
R $9E6D IX The entity
  $9E6D,$03 Call #R$9DF8.
  $9E70,$03 Decrease field #N$23 of the entity by one.
  $9E73,$03 Jump to #R$9E3B to free the entity if it is zero.
  $9E76,$03 Fetch the first byte of the third coordinate of the entity.
  $9E79,$03 Fetch the second byte of the third coordinate of the entity.
  $9E7C,$01 Add one.
  $9E7D,$03 Store the first byte of the third coordinate of the entity.
  $9E80,$03 Store the second byte of the third coordinate of the entity.
  $9E83,$03 Jump to #R$CF3D to carry on updating the entity.

c $9E86 Play Pulse
@ $9E86 label=PlayPulse
D $9E86 Plays one cycle of a tone, by setting the speaker bit for a time and
. then clearing it for a time. This is the basis of the sound effects.
E $9E86 View the equivalent code in;
. #LIST
. { #CYBERUN$71D3 }
. LIST#
R $9E86 B The length of the pulse
R $9E86 D The length of the gap
  $9E86,$02 Set the speaker bit.
  $9E88,$02 Write to the port.
@ $9E8A label=PlayPulse_Pulse
  $9E8A,$02 Wait for the length of the pulse.
  $9E8C,$01 Clear the speaker bit.
  $9E8D,$02 Write to the port.
  $9E8F,$01 Copy the length of the gap into #REGb.
@ $9E90 label=PlayPulse_Gap
  $9E90,$02 Wait for the length of the gap.
  $9E92,$01 Return.

c $9E93 Play Click
@ $9E93 label=PlayClick
D $9E93 Plays one cycle of a tone in which the pulse and the gap are equally
. long.
E $9E93 View the equivalent code in;
. #LIST
. { #CYBERUN$71E0 }
. { #GUNFRIGHT$AF66 }
. { #NIGHTSHADE$C471 }
. { #PENTAGRAM$D682 }
. LIST#
R $9E93 B The length of the pulse and the gap
  $9E93,$02 Set the speaker bit.
  $9E95,$02 Write to the port.
  $9E97,$01 Save the length in #REGa.
@ $9E98 label=PlayClick_Pulse
  $9E98,$02 Wait for the length of the pulse.
  $9E9A,$01 Restore the length in #REGb.
  $9E9B,$01 Clear the speaker bit.
  $9E9C,$02 Write to the port.
  $9E9E,$01 Save the length in #REGa.
@ $9E9F label=PlayClick_Gap
  $9E9F,$02 Wait for the length of the gap.
  $9EA1,$01 Restore the length in #REGb.
  $9EA2,$01 Return.

c $9EA3 Play Fanfare
@ $9EA3 label=PlayFanfare
D $9EA3 Plays three rising sweeps of clicks and then the tune at #R$9EBF.
. .
. #HTML(#AUDIO0(fanfare.wav)(#INCLUDE(Fanfare)))
  $9EA3,$02 Set the number of sweeps in #REGc to #N$03.
@ $9EA5 label=PlayFanfare_Sweep
  $9EA5,$02 Start the sweep with a length of #N$FF.
@ $9EA7 label=PlayFanfare_Click
  $9EA7,$03 Play a click.
  $9EAA,$02 Shorten the length and jump back until the sweep has finished.
@ $9EAC label=PlayFanfare_Pause
  $9EAC,$02 Pause for a moment.
  $9EAE,$01 Decrease the number of sweeps by one.
  $9EAF,$02 Jump back until all of the sweeps have been played.
  $9EB1,$03 Point #REGde at #R$9EBF.
  $9EB4,$03 Jump to #R$A1C1 to play the tune.

c $9EB7 Play Rising Sweep
@ $9EB7 label=PlayRisingSweep
D $9EB7 Plays a sweep of clicks which get shorter, so the pitch rises.
. .
. #HTML(#AUDIO0(rising-sweep.wav)(#INCLUDE(RisingSweep)))
  $9EB7,$02 Start the sweep with a length of #N$FF.
@ $9EB9 label=PlayRisingSweep_Click
  $9EB9,$03 Play a click.
  $9EBC,$02 Shorten the length and jump back until the sweep has finished.
  $9EBE,$01 Return.

b $9EBF Fanfare Tune
@ $9EBF label=FanfareTune
D $9EBF The tune for #R$9EA3, in the format used by #R$A1C1.
B $9EBF,$12,$08,$0A

c $9ED1 Play Default Buzz
@ $9ED1 label=PlayDefaultBuzz
D $9ED1 Plays a buzz, using a pattern of pulses which is based on the number of
. the pulse and a seed. This entry point uses #N$1C pulses and a seed of #N$27.
. .
. #HTML(#AUDIO0(buzz.wav)(#INCLUDE(Buzz)))
E $9ED1 View the equivalent code in;
. #LIST
. { #CYBERUN$7293 }
. LIST#
  $9ED1,$02 Set the number of pulses to #N$1C.
  $9ED3,$02 Set the seed to #N$27.
@ $9ED5 label=PlayBuzz
N $9ED5 This entry point takes the number of pulses in #REGc and the seed in
. #REGe.
  $9ED5,$01 Fetch the number of the pulse.
  $9ED6,$01 Combine it with the seed.
  $9ED7,$01 Double it.
  $9ED8,$01 Use it as the length of the pulse.
  $9ED9,$02,b$01 Use bits 0-4.
  $9EDB,$01 Use it as the length of the gap.
  $9EDC,$03 Play a pulse.
  $9EDF,$01 Decrease the number of pulses by one.
  $9EE0,$02 Jump back until they have all been played.
  $9EE2,$01 Return.

c $9EE3 Play Short Buzz
@ $9EE3 label=PlayShortBuzz
D $9EE3 Plays a buzz of #N$0D pulses with a seed of #N$14.
. .
. #HTML(#AUDIO0(short-buzz.wav)(#INCLUDE(ShortBuzz)))
  $9EE3,$02 Set the number of pulses to #N$0D.
  $9EE5,$02 Set the seed to #N$14.
  $9EE7,$03 Jump to #R$9ED1(#N$9ED5) to play the buzz.

c $9EEA Play Tiny Buzz
@ $9EEA label=PlayTinyBuzz
D $9EEA Plays a buzz of #N$04 pulses with a seed of #N$03.
. .
. #HTML(#AUDIO0(tiny-buzz.wav)(#INCLUDE(TinyBuzz)))
  $9EEA,$02 Set the number of pulses to #N$04.
  $9EEC,$02 Set the seed to #N$03.
  $9EEE,$03 Jump to #R$9ED1(#N$9ED5) to play the buzz.

c $9EF1 Play Buzz Sweep
@ $9EF1 label=PlayBuzzSweep
D $9EF1 Plays three buzzes, each with a lower number of pulses and a higher seed
. than the one before.
. .
. #HTML(#AUDIO0(buzz-sweep.wav)(#INCLUDE(BuzzSweep)))
  $9EF1,$03 Set the number of pulses to #N$30 and the number of buzzes to #N$03.
@ $9EF4 label=PlayBuzzSweep_Buzz
  $9EF4,$01 Save the counters.
  $9EF5,$01 Fetch the number of buzzes.
  $9EF6,$01 Multiply it by two...
  $9EF7,$01 ...four...
  $9EF8,$01 ...and eight.
  $9EF9,$01 Add the number of pulses to make the seed.
  $9EFA,$01 Set the seed.
  $9EFB,$03 Play the buzz.
  $9EFE,$01 Restore the counters.
  $9EFF,$01 Fetch the number of pulses.
  $9F00,$02 Subtract #N$0C.
  $9F02,$01 Store it.
  $9F03,$02 Jump back until all of the buzzes have been played.
  $9F05,$01 Return.

c $9F06 Play Random Noise
@ $9F06 label=PlayRandomNoise
D $9F06 Plays a series of pulses of rising length, using the random number
. generator to set the length of the series and the speed of the rise.
. .
. #HTML(#AUDIO0(random-noise.wav)(#INCLUDE(RandomNoise)))
  $9F06,$03 Fetch the low byte of the seed from #R$5F9A.
  $9F09,$02,b$01 Use bits 0-4.
  $9F0B,$02 Add #N$07 to make the first pulse length.
  $9F0D,$01 Use it as the length of the pulse.
  $9F0E,$02 Add #N$14 to make the first gap length.
  $9F10,$01 Use it as the length of the gap.
  $9F11,$03 Fetch the random number from #R$5F9A(#N$5F9B).
  $9F14,$02,b$01 Use bits 0-3.
  $9F16,$02 Add #N$10 to make the number of pulses.
  $9F18,$01 Set the number of pulses.
@ $9F19 label=PlayRandomNoise_Pulse
  $9F19,$01 Save the counters.
  $9F1A,$03 Play a pulse.
  $9F1D,$01 Restore the counters.
  $9F1E,$01 Fetch the length of the pulse.
  $9F1F,$02 Add #N$08.
  $9F21,$01 Store it.
  $9F22,$01 Fetch the length of the gap.
  $9F23,$02 Add #N$07.
  $9F25,$01 Store it.
  $9F26,$01 Decrease the number of pulses by one.
  $9F27,$02 Jump back until they have all been played.
  $9F29,$01 Return.

c $9F2A Play Long Buzz
@ $9F2A label=PlayLongBuzz
D $9F2A Plays a buzz of #N$38 pulses with a seed of #N$7F.
. .
. #HTML(#AUDIO0(long-buzz.wav)(#INCLUDE(LongBuzz)))
  $9F2A,$02 Set the number of pulses to #N$38.
  $9F2C,$02 Set the seed to #N$7F.
  $9F2E,$03 Jump to #R$9ED1(#N$9ED5) to play the buzz.

c $9F31 Play Falling Sweep
@ $9F31 label=PlayFallingSweep
D $9F31 Plays a sweep of #N$3F clicks which get longer, so the pitch falls.
. .
. #HTML(#AUDIO0(falling-sweep.wav)(#INCLUDE(FallingSweep)))
  $9F31,$02 Set the number of clicks to #N$3F.
@ $9F33 label=PlayFallingSweep_Click
  $9F33,$01 Fetch the number of clicks left.
  $9F34,$02,b$01 Flip bits 0-5, to count upwards.
  $9F36,$02 Add #N$10.
  $9F38,$01 Use it as the length of the click.
  $9F39,$03 Play a click.
  $9F3C,$01 Decrease the number of clicks by one.
  $9F3D,$02 Jump back until they have all been played.
  $9F3F,$01 Return.

c $9F40 Play Short Rising Sweep
@ $9F40 label=PlayShortRisingSweep
D $9F40 Plays a sweep of #N$09 clicks which get shorter, so the pitch rises.
. .
. #HTML(#AUDIO0(short-rising-sweep.wav)(#INCLUDE(ShortRisingSweep)))
  $9F40,$03 Set the length of the first click to #N$80 and the number of clicks
. to #N$09.
@ $9F43 label=PlayShortRisingSweep_Click
  $9F43,$03 Play a click.
  $9F46,$01 Fetch the length.
  $9F47,$02 Subtract #N$06.
  $9F49,$01 Store it.
  $9F4A,$01 Decrease the number of clicks by one.
  $9F4B,$02 Jump back until they have all been played.
  $9F4D,$01 Return.

c $9F4E Play Medium Buzz
@ $9F4E label=PlayMediumBuzz
D $9F4E Plays a buzz of #N$0F pulses with a seed of #N$0F.
. .
. #HTML(#AUDIO0(medium-buzz.wav)(#INCLUDE(MediumBuzz)))
  $9F4E,$02 Set the number of pulses to #N$0F.
  $9F50,$02 Set the seed to #N$0F.
  $9F52,$03 Jump to #R$9ED1(#N$9ED5) to play the buzz.

c $9F55 Play Slow Fall
@ $9F55 label=PlaySlowFall
D $9F55 Plays a series of #N$12 clicks whose lengths slowly increase.
. .
. #HTML(#AUDIO0(slow-fall.wav)(#INCLUDE(SlowFall)))
  $9F55,$02 Set the number of clicks to #N$12.
  $9F57,$02 Set the base length to #N$60.
@ $9F59 label=PlaySlowFall_Click
  $9F59,$01 Fetch the number of clicks left.
  $9F5A,$01 Double it.
  $9F5B,$01 Add the base length.
  $9F5C,$01 Use it as the length of the click.
  $9F5D,$03 Play a click.
  $9F60,$01 Fetch the base length.
  $9F61,$02 Add #N$03.
  $9F63,$01 Store it.
  $9F64,$01 Decrease the number of clicks by one.
  $9F65,$02 Jump back until they have all been played.
  $9F67,$01 Return.

c $9F68 Play Brief Buzz
@ $9F68 label=PlayBriefBuzz
D $9F68 Plays a buzz of #N$0A pulses with a seed of #N$26.
. .
. #HTML(#AUDIO0(brief-buzz.wav)(#INCLUDE(BriefBuzz)))
  $9F68,$02 Set the number of pulses to #N$0A.
  $9F6A,$02 Set the seed to #N$26.
  $9F6C,$03 Jump to #R$9ED1(#N$9ED5) to play the buzz.

c $9F6F Play Shot Sound
@ $9F6F label=PlayShotSound
D $9F6F Plays six clicks, each of length #N$80.
. .
. #HTML(#AUDIO0(shot-sound.wav)(#INCLUDE(ShotSound)))
  $9F6F,$03 Set the length of the clicks to #N$80 and the number of clicks to
. #N$06.
@ $9F72 label=PlayShotSound_Click
  $9F72,$03 Play a click.
  $9F75,$01 Decrease the number of clicks by one.
  $9F76,$02 Jump back until they have all been played.
  $9F78,$01 Return.

g $9F79 Scratch Items
@ $9F79 label=ScratchItems
D $9F79 Two buffers, each holding a copy of an item from the draw list that has
. been expanded into the same layout as an entity, for #R$9F99. The positions
. are copied in at offsets #N$02, #N$05 and #N$08, and the sizes at offsets
. #N$0B, #N$0C and #N$0D are always #N$06, #N$06 and #N$01.
B $9F79,$10,$0B,$03,$02 Scratch item #N$00.
@ $9F89 label=ScratchItems_Second
B $9F89,$10,$0B,$03,$02 Scratch item #N$01.

c $9F99 Sort Draw List
@ $9F99 label=SortDrawList
D $9F99 Sorts the draw list at #R$AFFB into the order in which the items must be
. drawn, and builds the sorted list at #R$AF8F. This is a painter's algorithm:
. an item can only be drawn after every item which is behind it. Each item in
. the lists has three bytes: flags, and the address of its record. Bit 0 of the
. flags is set if the record is an entity, and reset if it is a compact record
. with the three coordinates at offsets #N$02, #N$04 and #N$06, which is given
. the size #N$06, #N$06, #N$01. Bit 7 is set once the item has been moved to the
. sorted list. . The routine takes the first item which has not been moved, and
. compares it with each of the other items which have not been moved. The result
. for each pair is a number in the range #N$00-#N$1A, made from the relation
. along the first, second and third coordinates (#N$00 for 'the other item is
. before this one', #N$01 for 'they overlap' and #N$02 for 'the other item is
. after this one'). The number selects a routine from the table at #R$A0BE. If
. the other item has to be drawn first then it becomes the item under
. consideration (unless it has been tried already, which would be a loop). When
. an item has no other item that has to be drawn before it, it is moved to the
. sorted list and the whole process starts again.
  $9F99,$03 Point #REGhl at the sorted list.
  $9F9C,$03 Store it as the address of the next free place in the sorted list.
@ $9F9F label=SortDrawList_Next
  $9F9F,$03 Point #REGde at the start of the draw list.
@ $9FA2 label=SortDrawList_FirstLoop
  $9FA2,$01 Fetch the flags of the next item.
  $9FA3,$01 Move onto the address of the record.
  $9FA4,$01 Test the flags.
  $9FA5,$03 Jump to #R$A198 if this is the end of the list.
  $9FA8,$02 Test whether the item has been moved already.
  $9FAA,$01 Keep the flags in #REGl.
  $9FAB,$01 Fetch the first byte of the address of the record.
  $9FAC,$01 Keep it in #REGc.
  $9FAD,$01 Move onto the second byte of the address.
  $9FAE,$01 Fetch it.
  $9FAF,$01 Keep it in #REGb.
  $9FB0,$01 Move onto the next item.
  $9FB1,$02 Jump back to look at the next item if this one has been moved
. already.
  $9FB3,$04 Store the address of the next item as that of the item under
. consideration.
  $9FB7,$03 Copy the address of the record into #REGix (using the stack).
  $9FBA,$02 Rotate bit 0 of the flags into the carry flag.
  $9FBC,$02 Jump to #R$9FDD if the record is an entity.
  $9FBE,$03 Fetch the first byte of the first coordinate of the record.
  $9FC1,$03 Fetch the second byte of the first coordinate of the record.
  $9FC4,$03 Store the first coordinate in the first scratch item.
  $9FC7,$03 Fetch the first byte of the second coordinate of the record.
  $9FCA,$03 Fetch the second byte of the second coordinate of the record.
  $9FCD,$03 Store the second coordinate in the first scratch item.
  $9FD0,$03 Fetch the first byte of the third coordinate of the record.
  $9FD3,$03 Fetch the second byte of the third coordinate of the record.
  $9FD6,$03 Store the third coordinate in the first scratch item.
  $9FD9,$04 Point #REGix at #R$9F79.
@ $9FDD label=SortDrawList_SecondLoop
  $9FDD,$01 Fetch the flags of the next item to compare.
  $9FDE,$01 Move onto the address of the record.
  $9FDF,$01 Test the flags.
  $9FE0,$03 Jump to #R$A179 if the end of the list has been reached, as no other
. item has to go first.
  $9FE3,$02 Test whether the item has been moved already.
  $9FE5,$01 Keep the flags in #REGl.
  $9FE6,$01 Fetch the first byte of the address of the record.
  $9FE7,$01 Keep it in #REGc.
  $9FE8,$01 Move onto the second byte of the address.
  $9FE9,$01 Fetch it.
  $9FEA,$01 Keep it in #REGb.
  $9FEB,$01 Move onto the next item.
  $9FEC,$02 Jump back to look at the next item if this one has been moved
. already.
  $9FEE,$04 Store the address of the next item as that of the other item.
  $9FF2,$03 Copy the address of the record into #REGiy (using the stack).
  $9FF5,$02 Rotate bit 0 of the flags into the carry flag.
  $9FF7,$02 Jump to #R$A01B if the record is an entity.
  $9FF9,$03 Fetch the first byte of the first coordinate of the record.
  $9FFC,$03 Fetch the second byte of the first coordinate of the record.
  $9FFF,$03 Store the first coordinate in the second scratch item.
  $A002,$03 Fetch the first byte of the second coordinate of the record.
  $A005,$03 Fetch the second byte of the second coordinate of the record.
  $A008,$03 Store the second coordinate in the second scratch item.
  $A00B,$03 Fetch the first byte of the third coordinate of the record.
  $A00E,$03 Fetch the second byte of the third coordinate of the record.
  $A011,$03 Store the third coordinate in the second scratch item.
  $A014,$04 Point #REGiy at #R$9F89.
  $A018,$03 Use it as the address to compare against.
@ $A01B label=SortDrawList_Compare
N $A01B Skip the pair if both are the same item.
  $A01B,$03 Copy the address of the item under consideration into #REGhl (using
. the stack).
  $A01E,$03 Compare it with the address of the other item.
  $A021,$02 Jump to #R$9FDD if they are the same item.
N $A023 Compare the third coordinate of the two items, and put the result in
. #REGc: #N$00 if the other item is entirely before this one, #N$01 if they
. overlap, and #N$02 if the other item is entirely after this one.
  $A023,$01 Switch to the alternate registers.
  $A024,$02 Clear the result.
  $A026,$03 Fetch the first byte of the third coordinate of the other item.
  $A029,$03 Fetch the second byte of the third coordinate of the other item.
  $A02C,$02 Clear #REGd.
  $A02E,$03 Fetch the third size of the other item.
  $A031,$01 Subtract one to make the last position it covers.
  $A032,$01 Find the last position that the other item covers.
  $A033,$03 Fetch the first byte of the third coordinate of this item.
  $A036,$03 Fetch the second byte of the third coordinate of this item.
  $A039,$02 Subtract the position of this item.
  $A03B,$02 Jump to #R$A051 if the other item ends before this one begins.
  $A03D,$03 Fetch the third size of this item.
  $A040,$02 Clear #REGh.
  $A042,$01 Find the position just beyond this item.
  $A043,$01 Keep it in #REGde.
  $A044,$03 Fetch the first byte of the third coordinate of the other item.
  $A047,$03 Fetch the second byte of the third coordinate of the other item.
  $A04A,$03 Subtract the position beyond this item.
  $A04D,$02 Jump to #R$A050 if the other item starts before the end of this one.
  $A04F,$01 Add one to the result.
@ $A050 label=SortDrawList_ThirdAdd
  $A050,$01 Add one to the result.
@ $A051 label=SortDrawList_Second
N $A051 Do the same for the second coordinate, adding #N$03 to the result for an
. overlap and #N$06 for the other item being entirely after this one.
  $A051,$03 Fetch the first byte of the second coordinate of the other item.
  $A054,$03 Fetch the second byte of the second coordinate of the other item.
  $A057,$02 Clear #REGd.
  $A059,$03 Fetch the second size of the other item.
  $A05C,$01 Subtract one to make the last position it covers.
  $A05D,$01 Find the last position that the other item covers.
  $A05E,$03 Fetch the first byte of the second coordinate of this item.
  $A061,$03 Fetch the second byte of the second coordinate of this item.
  $A064,$02 Subtract the position of this item.
  $A066,$02 Jump to #R$A080 if the other item ends before this one begins.
  $A068,$03 Fetch the second size of this item.
  $A06B,$02 Clear #REGh.
  $A06D,$01 Find the position just beyond this item.
  $A06E,$01 Keep it in #REGde.
  $A06F,$03 Fetch the first byte of the second coordinate of the other item.
  $A072,$03 Fetch the second byte of the second coordinate of the other item.
  $A075,$03 Subtract the position beyond this item.
  $A078,$01 Fetch the result so far.
  $A079,$02 Jump to #R$A07D if the other item starts before the end of this one.
  $A07B,$02 Add #N$03 to the result.
@ $A07D label=SortDrawList_SecondAdd
  $A07D,$02 Add #N$03 to the result.
  $A07F,$01 Store the result.
@ $A080 label=SortDrawList_First
N $A080 Do the same for the first coordinate, adding #N$09 to the result for an
. overlap and #N$12 for the other item being entirely after this one.
  $A080,$03 Fetch the first byte of the first coordinate of the other item.
  $A083,$03 Fetch the second byte of the first coordinate of the other item.
  $A086,$02 Clear #REGd.
  $A088,$03 Fetch the first size of the other item.
  $A08B,$01 Subtract one to make the last position it covers.
  $A08C,$01 Find the last position that the other item covers.
  $A08D,$03 Fetch the first byte of the first coordinate of this item.
  $A090,$03 Fetch the second byte of the first coordinate of this item.
  $A093,$02 Subtract the position of this item.
  $A095,$02 Jump to #R$A0AF if the other item ends before this one begins.
  $A097,$03 Fetch the first size of this item.
  $A09A,$02 Clear #REGh.
  $A09C,$01 Find the position just beyond this item.
  $A09D,$01 Keep it in #REGde.
  $A09E,$03 Fetch the first byte of the first coordinate of the other item.
  $A0A1,$03 Fetch the second byte of the first coordinate of the other item.
  $A0A4,$03 Subtract the position beyond this item.
  $A0A7,$01 Fetch the result so far.
  $A0A8,$02 Jump to #R$A0AC if the other item starts before the end of this one.
  $A0AA,$02 Add #N$09 to the result.
@ $A0AC label=SortDrawList_FirstAdd
  $A0AC,$02 Add #N$09 to the result.
  $A0AE,$01 Store the result.
@ $A0AF label=SortDrawList_Dispatch
N $A0AF Use the result to jump to the routine in the table at #R$A0BE.
  $A0AF,$01 Fetch the result.
  $A0B0,$01 Double it to make the offset into the table.
  $A0B1,$01 Switch back to the normal registers.
  $A0B2,$03 Point #REGhl at #R$A0BE.
  $A0B5,$01 Copy the offset into #REGc.
  $A0B6,$02 Clear #REGb.
  $A0B8,$01 Add the offset to find the entry.
  $A0B9,$01 Fetch the first byte of the address.
  $A0BA,$01 Move onto the second byte.
  $A0BB,$01 Fetch it.
  $A0BC,$01 Combine them into #REGhl.
  $A0BD,$01 Jump to the routine.

w $A0BE Draw Order Table
@ $A0BE label=DrawOrderTable
D $A0BE The routines for each result of the comparison in #R$9F99. The result is
. #N$09 times the relation along the first coordinate plus #N$03 times the
. relation along the second plus the relation along the third, where the
. relation is #N$00 if the other item is before this one, #N$01 for an overlap
. and #N$02 if it is after.
W $A0BE,$36,$02

c $A0F4 Ignore Item
@ $A0F4 label=IgnoreItem
D $A0F4 The other item does not have to be drawn before this one, so carry on
. with the next other item.
  $A0F4,$03 Jump to #R$9FDD.

c $A0F7 Ignore Overlap
@ $A0F7 label=IgnoreOverlap
D $A0F7 The other item does not have to be drawn before this one (the same as
. #R$A0F4), so carry on with the next other item.
  $A0F7,$03 Jump to #R$9FDD.

c $A0FA Draw Other Item First
@ $A0FA label=DrawOtherItemFirst
D $A0FA The other item must be drawn before this one, so it becomes the item
. under consideration. The addresses of the entries in the draw list which have
. been tried are kept in a list at #R$A19E, and if the other item is already in
. that list then there is a loop and the other item is moved to the sorted list
. now.
  $A0FA,$03 Fetch the address of the entry after the other item.
  $A0FD,$01 Move back to the start of the item...
  $A0FE,$01 ...in the draw list...
  $A0FF,$01 ...which is three bytes.
  $A100,$03 Point #REGde at #R$A19E.
@ $A103 label=DrawOtherItemFirst_Search
  $A103,$01 Fetch the first byte of the next address in the list.
  $A104,$04 Jump to #R$A114 if this is the end of the list.
  $A108,$01 Compare it with the first byte of the address of the other item.
  $A109,$01 Move onto the second byte.
  $A10A,$02 Jump to #R$A110 if they are different.
  $A10C,$01 Fetch the second byte.
  $A10D,$01 Compare it with the second byte of the address of the other item.
  $A10E,$02 Jump to #R$A156 if the item is in the list.
@ $A110 label=DrawOtherItemFirst_Different
  $A110,$01 Move onto the next address in the list.
  $A111,$02 Jump back to compare it.
  $A113,$01 This instruction is never executed.
@ $A114 label=DrawOtherItemFirst_Add
  $A114,$01 Store the first byte of the address of the other item at the end of
. the list.
  $A115,$02 Move onto the second byte.
  $A117,$01 Fetch the second byte of the address of the other item.
  $A118,$01 Store it in the list.
  $A119,$01 Move onto the end marker.
  $A11A,$02 Set the end marker to #N$FF.
  $A11C,$01 Store it.
  $A11D,$04 Copy the address of the other record into #REGix (using the stack).
  $A121,$03 Fetch the address of the item after the other item.
  $A124,$03 Make it the item under consideration.
  $A127,$03 Point #REGde at #R$AFFB.
  $A12A,$01 Move back to the start of the item...
  $A12B,$01 ...in the draw list...
  $A12C,$01 ...which is three bytes.
  $A12D,$05 Jump to #R$9FDD if the record is an entity.
  $A132,$03 Copy the address of the second scratch item into #REGhl (using the
. stack).
  $A135,$03 Point #REGde at #R$9F79.
  $A138,$02 Copy the first byte of the second scratch item to the first scratch
. item.
  $A13A,$02 Copy the second byte.
  $A13C,$02 Copy the third byte.
  $A13E,$02 Copy the fourth byte.
  $A140,$02 Copy the fifth byte.
  $A142,$02 Copy the sixth byte.
  $A144,$02 Copy the seventh byte.
  $A146,$02 Copy the eighth byte.
  $A148,$02 Copy the ninth byte.
  $A14A,$02 Copy the tenth byte.
  $A14C,$04 Point #REGix at #R$9F79.
  $A150,$03 Point #REGde at #R$AFFB.
  $A153,$03 Jump to #R$9FDD.
@ $A156 label=DrawOtherItemFirst_Loop
N $A156 There is a loop, so move the other item to the sorted list now.
  $A156,$03 Fetch the address of the item after the other item.
  $A159,$03 Make it the item under consideration.
  $A15C,$02 Jump to #R$A179 to move it to the sorted list.

c $A15E Resolve Full Overlap
@ $A15E label=ResolveFullOverlap
D $A15E Chooses what to do when two items overlap along all three coordinates.
. An item with the flags #N$03 is drawn before the other item.
  $A15E,$03 Fetch the address of the entry after the item under consideration.
  $A161,$01 Move back to the start of the entry...
  $A162,$01 ...in the draw list...
  $A163,$01 ...which is three bytes.
  $A164,$01 Fetch the flags of the item under consideration.
  $A165,$05 Jump to #R$9FDD to carry on with the next other item if they are
. the same.
  $A16A,$03 Fetch the address of the entry after the other item.
  $A16D,$01 Move back to the start of the entry...
  $A16E,$01 ...in the draw list...
  $A16F,$01 ...which is three bytes.
  $A170,$01 Fetch the flags of the other item.
  $A171,$05 Jump to #R$A0FA if they are the same, to draw the other item first.
  $A176,$03 Jump to #R$9FDD to carry on with the next other item.

c $A179 Move Item To Sorted List
@ $A179 label=MoveItemToSortedList
D $A179 Moves the item under consideration to the sorted list, marks it as moved
. in the draw list, and starts again with the first item that has not been
. moved.
  $A179,$03 Point #REGde at the next free place in the sorted list (the address
. is stored in the operand of this instruction, #R$A179(#N$A17A)).
  $A17C,$03 Fetch the address of the entry after the item under consideration.
  $A17F,$01 Move back to the start of the entry...
  $A180,$01 ...in the draw list...
  $A181,$01 ...which is three bytes.
  $A182,$01 Fetch the flags of the item.
  $A183,$02 Mark it as moved in the draw list.
  $A185,$01 Store the flags in the sorted list.
  $A186,$01 Move onto the address of the record.
  $A187,$01 Move onto the next place in the sorted list.
  $A188,$02 Copy the first byte of the address of the record.
  $A18A,$02 Copy the second byte.
  $A18C,$04 Store the address of the next free place in the sorted list.
  $A190,$02 Set the end marker of the list of items which have been tried.
  $A192,$03 Store it at the start of the list.
  $A195,$03 Jump to #R$9F99(#N$9F9F) to find the next item.

c $A198 End Sorted List
@ $A198 label=EndSortedList
D $A198 Ends the sorted list, once all of the items have been moved to it.
  $A198,$03 Fetch the address of the next free place in the sorted list.
  $A19B,$02 Write the end marker.
  $A19D,$01 Return.

g $A19E Tried Entries
@ $A19E label=TriedEntries
D $A19E The addresses of the entries in the draw list that #R$A0FA has tried
. while it looks for an item to move to the sorted list, each stored as two
. bytes and ended by #N$FF.
B $A19E,$10,$08

g $A1AE Draw List Pointers
@ $A1AE label=ItemUnderConsideration
D $A1AE The addresses used by #R$9F99 to track its progress.
W $A1AE,$02 The address of the entry after the item under consideration.
W $A1B0,$02 The address of the entry after the other item.

c $A1B2 Play Music Until Key Pressed
@ $A1B2 label=PlayMusic_WaitKey
D $A1B2 Plays a piece of music, until it ends or a key is pressed.
E $A1B2 View the equivalent code in;
. #LIST
. { #CYBERUN$9A9A }
. LIST#
R $A1B2 DE The address of the music
  $A1B2,$01 Select all of the keyboard rows.
  $A1B3,$03 Read the keyboard.
  $A1B6,$01 Return if a key is being pressed.
  $A1B7,$01 Fetch the next byte of the music.
  $A1B8,$04 Jump to #R$A1CB if the music has ended.
  $A1BC,$03 Play the note.
  $A1BF,$02 Jump back for the next note.

c $A1C1 Play Music
@ $A1C1 label=PlayMusic
D $A1C1 Plays a piece of music. Each byte of the music is a note, or #N$FF at
. the end. Bits 0-5 of a note are its number in the table at #R$A226 (#N$00 for
. a rest). Bits 6-7 are not used.
.
. The tunes played by this routine are:
. #TABLE(default,centre,centre)
. { =h Tune | =h Sound }
. { Title Tune |
. #HTML(#AUDIO0(title-tune.wav)(#INCLUDE(TitleTune))) }
. { Start Tune |
. #HTML(#AUDIO0(start-tune.wav)(#INCLUDE(StartTune))) }
. { Fanfare |
. #HTML(#AUDIO0(fanfare.wav)(#INCLUDE(Fanfare))) }
. { Game Over Tune |
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune))) }
. TABLE#
E $A1C1 View the equivalent code in;
. #LIST
. { #CYBERUN$9AA9 }
. { #GUNFRIGHT$AF8F }
. { #NIGHTSHADE$C656 }
. { #PENTAGRAM$D6B5 }
. LIST#
R $A1C1 DE The address of the music
  $A1C1,$01 Fetch the next byte of the music.
  $A1C2,$04 Jump to #R$A1CB if the music has ended.
  $A1C6,$03 Play the note.
  $A1C9,$02 Jump back for the next note.
@ $A1CB label=PlayMusic_Return
  $A1CB,$01 Return.

c $A1CC Play Note
@ $A1CC label=PlayNote
D $A1CC Plays a note of a piece of music, using the table at #R$A226. Each entry
. in the table has three bytes: the lengths of the inner and outer delay loops,
. which set the pitch, and the number of cycles.
E $A1CC View the equivalent code in;
. #LIST
. { #CYBERUN$9AB4 }
. { #GUNFRIGHT$AF9A }
. { #NIGHTSHADE$C661 }
. { #PENTAGRAM$D6C0 }
. LIST#
R $A1CC A The next byte of the music
R $A1CC DE The address of the byte of the music
R $A1CC O:DE The address of the next byte of the music
  $A1CC,$02,b$01 Use bits 0-5, the number of the note.
  $A1CE,$02 Jump to #R$A20F if it is a rest.
N $A1D0 Look up the delays and the number of cycles in the table at #R$A226.
  $A1D0,$03 Set #REGhl to the note number.
  $A1D3,$01 Double it.
  $A1D4,$03 Add the note number to make three times the number.
  $A1D7,$03 Point #REGbc at #R$A226.
  $A1DA,$01 Find the entry of the note.
  $A1DB,$01 Fetch the length of the inner delay loop.
  $A1DC,$01 Move onto the next byte.
  $A1DD,$01 Fetch the length of the outer delay loop.
  $A1DE,$01 Move onto the next byte.
  $A1DF,$01 Fetch the number of cycles.
  $A1E0,$02 Clear #REGh.
N $A1E2 Bits 6 and 7 of the note are the length, less one.
  $A1E2,$01 Fetch the byte of the music again.
  $A1E3,$01 Rotate bits 6 and 7 of the note down...
  $A1E4,$01 ...to bits 0 and 1.
  $A1E5,$02,b$01 Keep them, but the result is not used.
  $A1E7,$01 Set the multiplier to zero...
  $A1E8,$01 ...and then to one.
N $A1E9 Multiply the number of cycles by the length of the note.
@ $A1E9 label=PlayNote_Multiply
  $A1E9,$01 Save the address of the music.
  $A1EA,$01 Copy the low byte of the number of cycles into #REGe.
  $A1EB,$01 Copy the high byte into #REGd.
@ $A1EC label=PlayNote_MultiplyLoop
  $A1EC,$01 Decrease the multiplier by one.
  $A1ED,$02 Jump to #R$A1F2 if it is zero.
  $A1EF,$01 Add the number of cycles again.
  $A1F0,$02 Jump back to count the multiplier down.
@ $A1F2 label=PlayNote_Multiplied
  $A1F2,$01 Restore the address of the music.
N $A1F3 Each pass of this loop makes one cycle of the note, so the length of
. the note is the number of cycles.
@ $A1F3 label=PlayNote_Cycle
  $A1F3,$01 Save the lengths of the delay loops.
  $A1F4,$01 Clear the speaker bit.
  $A1F5,$02 Write to the port.
@ $A1F7 label=PlayNote_LowDelay
  $A1F7,$02 Wait for the inner delay loop.
  $A1F9,$01 Decrease the outer loop count by one.
  $A1FA,$02 Jump back until the outer delay loop has finished.
  $A1FC,$01 Restore the lengths of the delay loops.
  $A1FD,$01 Save them again.
  $A1FE,$02 Set the speaker bit.
  $A200,$02 Write to the port.
@ $A202 label=PlayNote_HighDelay
  $A202,$02 Wait for the inner delay loop.
  $A204,$01 Decrease the outer loop count by one.
  $A205,$02 Jump back until the outer delay loop has finished.
  $A207,$01 Restore the lengths of the delay loops.
  $A208,$01 Decrease the number of cycles by one.
  $A209,$01 Fetch the high byte of the number of cycles left.
  $A20A,$01 Combine it with the low byte, to test whether it is zero.
  $A20B,$02 Jump back for the next cycle until the note has finished.
  $A20D,$01 Move onto the next byte of the music.
  $A20E,$01 Return.

c $A20F Play Rest
@ $A20F label=PlayRest
D $A20F Plays a rest, which is a fixed length of silence, in a piece of music.
E $A20F View the equivalent code in;
. #LIST
. { #GUNFRIGHT$AFDC }
. LIST#
R $A20F DE The address of the byte of the music
R $A20F O:DE The address of the next byte of the music
  $A20F,$01 Fetch the byte of the music again.
  $A210,$01 Move onto the next byte of the music.
  $A211,$01 Rotate bits 6 and 7 of the note down...
  $A212,$01 ...to bits 0 and 1.
  $A213,$02,b$01 Keep them, but the result is not used.
  $A215,$01 Set the multiplier to zero...
  $A216,$01 ...and then to one.
  $A217,$01 Store it in #REGl.
  $A218,$03 Set the length of the delay.
@ $A21B label=PlayRest_Loop
  $A21B,$01 Save the length of the delay.
@ $A21C label=PlayRest_Delay
  $A21C,$01 Count the delay down.
  $A21D,$01 Combine the two bytes...
  $A21E,$01 ...to test whether it is zero.
  $A21F,$02 Jump back until the delay has finished.
  $A221,$01 Restore the length of the delay.
  $A222,$01 Decrease the multiplier by one.
  $A223,$02 Jump back until none remain.
  $A225,$01 Return.

b $A226 Note Table
@ $A226 label=NoteTable
D $A226 The notes of the music, for #R$A1CC. Each note has three bytes: the
. length of the inner delay loop, the length of the outer delay loop, and the
. number of cycles. The first note (number #N$00) is a rest and is not used.
B $A226,$B7,$03

g $A2DD Frame Counter
@ $A2DD label=FrameCounter
D $A2DD A counter that is increased once every frame.
W $A2DD,$02

g $A2DF Countdown Timer
@ $A2DF label=CountdownTimer
D $A2DF A timer which is set to #N$28 and is then counted down to zero once
. every frame.
B $A2DF,$01

c $A2E0 Clear Bytes
@ $A2E0 label=ClearBytes
D $A2E0 Sets a number of bytes to zero.
E $A2E0 View the equivalent code in;
. #LIST
. { #CYBERUN$F30B }
. LIST#
R $A2E0 B The number of bytes
R $A2E0 HL The address of the first byte
  $A2E0,$02 Write zero to the byte.
  $A2E2,$01 Move onto the next byte.
  $A2E3,$02 Jump back until all of the bytes have been cleared.
  $A2E5,$01 Return.

c $A2E6 Swap Bytes
@ $A2E6 label=SwapBytes
D $A2E6 Swaps the contents of two runs of bytes.
E $A2E6 View the equivalent code in;
. #LIST
. { #CYBERUN$F5C4 }
. LIST#
R $A2E6 B The number of bytes
R $A2E6 DE The address of the first run
R $A2E6 HL The address of the second run
  $A2E6,$01 Fetch a byte of the second run.
  $A2E7,$01 Fetch a byte of the first run.
  $A2E8,$01 Store it in the second run.
  $A2E9,$01 Fetch the byte of the second run.
  $A2EA,$01 Store it in the first run.
  $A2EB,$01 Move onto the next byte of the second run.
  $A2EC,$01 Move onto the next byte of the first run.
  $A2ED,$02 Jump back until all of the bytes have been swapped.
  $A2EF,$01 Return.

c $A2F0 Update High Score
@ $A2F0 label=UpdateHighScore
D $A2F0 Compares the five digits of the score at #R$E132 with the five digits of
. the high score at #R$E1A0 and, if the score is higher, copies it over the high
. score.
  $A2F0,$03 Point #REGhl at the digits of the high score.
  $A2F3,$03 Point #REGde at #R$E132.
  $A2F6,$02 Set a counter of five digits.
@ $A2F8 label=UpdateHighScore_Compare
  $A2F8,$01 Fetch a digit of the score.
  $A2F9,$01 Compare it with the same digit of the high score.
  $A2FA,$01 Return if the score is lower.
  $A2FB,$02 Jump to #R$A301 if the score is higher.
  $A2FD,$01 Move onto the next digit of the score.
  $A2FE,$01 Move onto the next digit of the high score.
  $A2FF,$02 Jump back to compare the next digit.
@ $A301 label=UpdateHighScore_Copy
  $A301,$03 Point #REGde at the digits of the high score.
  $A304,$03 Point #REGhl at #R$E132.
  $A307,$03 Set the number of digits.
  $A30A,$02 Copy the score over the high score.
  $A30C,$01 Return.

c $A30D Switch Player
@ $A30D label=SwitchPlayer
D $A30D Switches to the other player in a two-player game, by swapping the saved
. game state of the two players, and sets up the level for the new player.
  $A30D,$03 Fetch the number of lives of the second player from #R$DEFD.
  $A310,$01 Test it.
  $A311,$01 Return if there is no second player.
@ $A312 label=SwitchPlayer_Flip
  $A312,$03 Fetch the low byte of the operand of the instruction at #N$A413.
  $A315,$02,b$01 Flip bits 5-7.
  $A317,$03 Store it.
  $A31A,$03 Store it in the operand byte at #N$D2FA.
  $A31D,$03 Point #REGhl at #R$DEDE.
  $A320,$03 Point #REGde at #R$DEFD.
  $A323,$02 Set the number of bytes to #N$1F.
  $A325,$03 Swap the two game states.
  $A328,$03 Point #REGhl at #R$E12E.
  $A32B,$03 Point #REGde at #R$E140.
  $A32E,$02 Set the number of bytes to #N$09.
  $A330,$03 Swap them.
  $A333,$03 Point #REGhl at #R$E1A5.
  $A336,$03 Point #REGde at #R$E1AB.
  $A339,$02 Set the number of bytes to #N$06.
  $A33B,$03 Swap them.
  $A33E,$03 Point #REGhl at #R$E1B1.
  $A341,$03 Point #REGde at #R$E1B7.
  $A344,$02 Set the number of bytes to #N$06.
  $A346,$03 Swap them.
  $A349,$03 Point #REGde at #R$A59D.
  $A34C,$03 Point #REGhl at #R$A5A1.
  $A34F,$02 Set the number of bytes to #N$04.
  $A351,$03 Swap them.
  $A354,$04 Fetch the control method of the first player from #R$60FB and keep
. it in #REGb.
  $A358,$03 Fetch the control method of the second player from #R$60FC.
  $A35B,$03 Make it the control method of the first player.
  $A35E,$01 Fetch the old control method of the first player.
  $A35F,$03 Make it the control method of the second player.
  $A362,$03 Fetch the number of lives of the new player from #R$DEDE.
  $A365,$01 Test it.
  $A366,$01 Return if the new player has no lives.
  $A367,$01 Set #REGa to zero.
  $A368,$03 Clear the first of the saved values at #R$A59D.
  $A36B,$03 Clear the second of the saved values at #R$A59D(#N$A5A1).
  $A36E,$03 Fetch the number of the current player from #R$DEDD.
  $A371,$02,b$01 Flip bit 0.
  $A373,$03 Store it.
  $A376,$03 Call #R$DE9D.
  $A379,$03 Call #R$A8D1.
  $A37C,$03 Call #R$A8E1.
  $A37F,$03 Call #R$E229.
  $A382,$02 #REGc is #N$00, so that the player is not placed.
  $A384,$03 Call #R$86F9(#N$86FB) to find the data of the level.
  $A387,$03 Fetch the number of bottles left from #R$DEE0.
  $A38A,$01 Save it.
  $A38B,$03 Call #R$876B to set the graphics of the level.
  $A38E,$01 Restore the number of bottles left.
  $A38F,$03 Store it.
  $A392,$03 Set the position of the panel attributes.
  $A395,$03 Point #REGde at #R$E11C.
  $A398,$03 Jump to #R$AAE8 to fill the attributes.

c $A39B Restore Bottles
@ $A39B label=RestoreBottles
D $A39B Copies the saved state of each bottle in the level (see #R$DEE1) back
. into the objects of the level. Each entry in the list of the level selects a
. group of objects, and the objects with the type #N$01 or #N$02 in bits 0-3
. (and bit 7 set) are the bottles.
  $A39B,$03 Call #R$86F9 to find the data of the level and place the player.
  $A39E,$04 Point #REGiy at #R$DEE1.
  $A3A2,$03 Fetch the number of entries in the list of the level.
@ $A3A5 label=RestoreBottles_NextEntry
  $A3A5,$01 Save the count of entries.
  $A3A6,$02 Save the address of the entry.
  $A3A8,$03 Call #R$A3DB to find the objects in the group of the entry.
  $A3AB,$01 Fetch the number of objects.
  $A3AC,$01 Test it.
  $A3AD,$02 Jump to #R$A3D1 if there are no objects.
@ $A3AF label=RestoreBottles_NextObject
  $A3AF,$03 Fetch the type of the next object.
  $A3B2,$02,b$01 Keep bit 7 and bits 0-3.
  $A3B4,$04 Jump to #R$A3BC if it is a bottle of type #N$01.
  $A3B8,$04 Jump to #R$A3C9 unless it is a bottle of type #N$02.
@ $A3BC label=RestoreBottles_Restore
  $A3BC,$03 Fetch the type of the object again.
  $A3BF,$02,b$01 Use bits 4-6.
  $A3C1,$03 Combine them with the saved state of the bottle.
  $A3C4,$03 Store the new type of the object.
  $A3C7,$02 Move onto the saved state of the next bottle.
@ $A3C9 label=RestoreBottles_Skip
  $A3C9,$02 Move onto the next object...
  $A3CB,$02 ...which is three bytes...
  $A3CD,$02 ...along.
  $A3CF,$02 Jump back until all of the objects have been looked at.
@ $A3D1 label=RestoreBottles_NextGroup
  $A3D1,$02 Restore the address of the entry.
  $A3D3,$02 Move onto the next entry...
  $A3D5,$02 ...which is two bytes along.
  $A3D7,$01 Restore the count of entries.
  $A3D8,$02 Jump back until all of the entries have been looked at.
  $A3DA,$01 Return.

c $A3DB Find Group Objects
@ $A3DB label=FindGroupObjects
D $A3DB Finds the objects of the group which an entry in the list of a level
. refers to. The group is found in the table at #R$8BB1 from the byte at offset
. #N$08 from the entry, and its first byte holds the number of objects in the
. low five bits.
R $A3DB IX The address of the entry in the list of the level
R $A3DB O:B The number of objects
R $A3DB O:IX The address of the first object (which is three bytes long)
  $A3DB,$03 Fetch the number of the group.
  $A3DE,$02 Double it to make the offset into the table.
  $A3E0,$02 Clear #REGb.
  $A3E2,$03 Point #REGhl at #R$8BB1.
  $A3E5,$01 Add the offset to find the entry in the table.
  $A3E6,$01 Fetch the low byte of the address of the group.
  $A3E7,$01 Move onto the high byte.
  $A3E8,$01 Fetch the high byte.
  $A3E9,$03 Copy the address of the group into #REGix (using the stack).
  $A3EC,$03 Fetch the first byte of the group.
  $A3EF,$02,b$01 Keep the number of objects.
  $A3F1,$01 Copy it into #REGb.
  $A3F2,$02 Skip the first byte of the group.
  $A3F4,$02 Skip the second byte.
  $A3F6,$02 Skip the third byte.
  $A3F8,$02,b$01 Use bits 4-6.
  $A3FA,$01 Return if they are all zero.
  $A3FB,$02 Skip a fourth byte.
  $A3FD,$01 Return.

c $A3FE Collect Bottle
@ $A3FE label=CollectBottle
D $A3FE Handles the player collecting a bottle, if the flag at #R$DEFC is set.
. The score is increased, the bottle is shown as an empty cup, and the number of
. bottles left is decreased. If there are none left then the exit is opened.
  $A3FE,$03 Fetch the flag from #R$DEFC.
  $A401,$01 Test it.
  $A402,$01 Return if it is not set.
  $A403,$01 Clear the flag...
  $A404,$03 ...and store it.
  $A407,$03 Set the amount to add to the score.
  $A40A,$03 Call #R$9662 to add it to the score.
  $A40D,$03 Set the value of #N$6000.
  $A410,$03 Store it in #R$A59D(#N$A59F), which sets the target of the first
. gauge.
  $A413,$03 Set the position of the picture.
  $A416,$03 Point #REGde at #R$64BC.
  $A419,$03 Call #R$AAC4 to draw the picture.
  $A41C,$02 Set the value #N$04...
  $A41E,$03 ...in #R$AB0F(#N$AB7D).
  $A421,$03 Fetch the byte of the player entity at #R$B540(#N$B55C).
  $A424,$02,b$01 Keep the upper four bits.
  $A426,$02,b$01 Add the value #N$04.
  $A428,$03 Store it again.
  $A42B,$03 Fetch the number of bottles left from #R$DEE0.
  $A42E,$01 Decrease it by one.
  $A42F,$03 Store it.
  $A432,$02 Jump to #R$A440 if there are some left.
  $A434,$03 Set the units digit of the count on the panel to zero.
  $A437,$01 Set #REGc to zero, so that the player is not placed.
  $A438,$03 Call #R$86F9(#N$86FB) to find the data of the level.
  $A43B,$03 Call #R$A898 to show that the exit is open.
  $A43E,$02 Jump to #R$A457.
@ $A440 label=CollectBottle_Count
  $A440,$01 Copy the number of bottles left into #REGb.
  $A441,$01 Set #REGa to zero.
@ $A442 label=CollectBottle_Convert
  $A442,$02 Add one.
  $A444,$01 Convert it to binary coded decimal.
  $A445,$02 Jump back until the number has been converted.
  $A447,$01 Keep the result in #REGb.
  $A448,$02,b$01 Keep the units.
  $A44A,$03 Store it as the units digit of the count on the panel.
  $A44D,$01 Fetch the result.
  $A44E,$01 Move the tens digit...
  $A44F,$01 ...down...
  $A450,$01 ...to the lower...
  $A451,$01 ...four bits.
  $A452,$02,b$01 Keep the tens.
  $A454,$03 Store it as the tens digit of the count on the panel.
@ $A457 label=CollectBottle_Print
  $A457,$03 Point #REGde at the text of the count on the panel.
  $A45A,$03 Call #R$A923 to print it.
  $A45D,$04 Reset bit 0 of the type of the object in #REGix.
  $A461,$04 Set bit 1 of the type of the object in #REGix.
  $A465,$04 Store the address of the object at #N$C13C.
  $A469,$04 Store the address of the object at #N$A495, the operand of the
. instruction at #N$A494.
  $A46D,$04 Point #REGiy at #R$DEE1.
  $A471,$04 Fetch the address of the level data from #R$5CFE.
  $A475,$03 Fetch the number of entries in the list of the level.
@ $A478 label=CollectBottle_NextEntry
  $A478,$01 Save the count of entries.
  $A479,$02 Save the address of the entry.
  $A47B,$03 Call #R$A3DB to find the objects in the group of the entry.
  $A47E,$01 Fetch the number of objects.
  $A47F,$01 Test it.
  $A480,$02 Jump to #R$A4AD if there are no objects.
@ $A482 label=CollectBottle_NextObject
  $A482,$03 Fetch the type of the next object.
  $A485,$02,b$01 Keep bit 7 and bits 0-3.
  $A487,$04 Jump to #R$A48F if it is a bottle of type #N$01.
  $A48B,$04 Jump to #R$A4A5 unless it is a bottle of type #N$02.
@ $A48F label=CollectBottle_Match
  $A48F,$02 Move onto the saved state of the next bottle.
  $A491,$03 Copy the address of the object into #REGde (using the stack).
  $A494,$03 Set #REGhl to the address of the bottle that was collected.
  $A497,$01 Clear the carry flag.
  $A498,$02 Compare the two addresses.
  $A49A,$02 Jump to #R$A4A5 if this is not the bottle that was collected.
  $A49C,$04 Set the saved state of the bottle to #N$82.
  $A4A0,$02 Discard the address of the entry.
  $A4A2,$01 Discard the count of entries.
  $A4A3,$02 Jump to #R$A4B6.
@ $A4A5 label=CollectBottle_Skip
  $A4A5,$02 Move onto the next object...
  $A4A7,$02 ...which is three bytes...
  $A4A9,$02 ...along.
  $A4AB,$02 Jump back until all of the objects have been looked at.
@ $A4AD label=CollectBottle_NextGroup
  $A4AD,$02 Restore the address of the entry.
  $A4AF,$02 Move onto the next entry...
  $A4B1,$02 ...which is two bytes along.
  $A4B3,$01 Restore the count of entries.
  $A4B4,$02 Jump back until all of the entries have been looked at.
@ $A4B6 label=CollectBottle_Finish
  $A4B6,$02 #REGa is #N$01.
  $A4B8,$03 Store it in the byte at #N$B1B2.
  $A4BB,$03 Store it in the byte at #N$C653.
  $A4BE,$03 Fetch the value from #R$5CF0.
  $A4C1,$02,b$01 Use bits 0-2.
  $A4C3,$03 Store it in the byte at #N$C65D.
  $A4C6,$03 Set the value #N$7F10.
  $A4C9,$03 Store it at #N$B1B3.
  $A4CC,$03 Set the value #N$80A0.
  $A4CF,$03 Store it at #N$B1B5.
  $A4D2,$03 Point #REGde at #R$C646.
  $A4D5,$03 Point #REGhl at #R$C13B.
  $A4D8,$03 Call #R$BA78.
  $A4DB,$02 #REGa is #N$08.
  $A4DD,$03 Store it in the byte at #N$C794.
  $A4E0,$03 Store it in the byte at #N$C7A6.
  $A4E3,$03 Call #R$9EF1 to play a sound.
  $A4E6,$01 Return.

c $A4E7 Scroll Stage Message
@ $A4E7 label=ScrollStageMessage
D $A4E7 Scrolls the message 'STAGE' and the number of the stage across the
. window, one frame at a time, while the gauges are updated.
  $A4E7,$02 Set the length of the message to #N$07...
  $A4E9,$03 ...in the operand of the instruction at #N$A571.
  $A4EC,$03 Fetch the number of the current level from #R$DEDF.
  $A4EF,$01 Add one to make the number of the stage.
  $A4F0,$03 Store it as the last character of the message at #R$A591(#N$A597).
  $A4F3,$03 Set the scroll counter to #N$0E and the character index to #N$FF.
  $A4F6,$03 Store them in #R$A921 and #R$A921(#N$A922).
@ $A4F9 label=ScrollStageMessage_Loop
  $A4F9,$04 Bring back #REGiy from #R$5CF1.
  $A4FD,$01 Enable interrupts...
  $A4FE,$01 ...and wait for the next frame.
  $A4FF,$01 Disable interrupts.
  $A500,$04 Point #REGix at #R$A59D.
  $A504,$03 Update the gauge.
  $A507,$04 Point #REGix at #R$A5A1.
  $A50B,$03 Update the gauge.
  $A50E,$03 Point #REGhl at #R$A591.
  $A511,$03 Scroll the message by one step.
  $A514,$03 Fetch the character index from #R$A921(#N$A922).
  $A517,$02 Compare it with #N$0F.
  $A519,$01 Return if the message has gone.
  $A51A,$02 Jump back to scroll the message another step.

c $A51C Scroll Time Out Message
@ $A51C label=ScrollTimeOutMessage
D $A51C Scrolls the message 'TIME OUT' across the window, one frame at a time.
  $A51C,$03 Set the scroll counter to #N$0E and the character index to #N$FF.
  $A51F,$03 Store them in #R$A921 and #R$A921(#N$A922).
  $A522,$02 Set the length of the message to #N$08...
  $A524,$03 ...in the operand of the instruction at #N$A571.
@ $A527 label=ScrollTimeOutMessage_Loop
  $A527,$04 Bring back #REGiy from #R$5CF1.
  $A52B,$01 Enable interrupts...
  $A52C,$01 ...and wait for the next frame.
  $A52D,$01 Disable interrupts.
  $A52E,$03 Point #REGhl at #R$A53C.
  $A531,$03 Scroll the message by one step.
  $A534,$03 Fetch the character index from #R$A921(#N$A922).
  $A537,$02 Compare it with #N$11.
  $A539,$01 Return if the message has gone.
  $A53A,$02 Jump back to scroll the message another step.

b $A53C Time Out Message
@ $A53C label=TimeOutMessage
D $A53C The characters of the message 'TIME OUT', for #R$A51C.
B $A53C,$08,$08 TIME OUT

c $A544 Scroll Message
@ $A544 label=ScrollMessage
D $A544 Scrolls the message in the window by one pixel and, every sixteen
. pixels, adds the next character of the message on the right.
R $A544 HL The address of the message
  $A544,$01 Save the address of the message.
  $A545,$03 Point #REGhl at the top half of the area to scroll.
  $A548,$03 Set the width of the area to #N$02 bytes and the height to #N$0E.
  $A54B,$03 Scroll the area to the left by one pixel.
  $A54E,$03 Point #REGhl at the first screen address to copy.
  $A551,$03 Copy the column of pixels.
  $A554,$03 Point #REGhl at the second screen address to copy.
  $A557,$03 Copy the column of pixels.
  $A55A,$03 Point #REGhl at the lower half of the area to scroll.
  $A55D,$03 Set the width of the area to #N$08 bytes and the height to #N$0F.
  $A560,$03 Scroll the area to the left by one pixel.
  $A563,$01 Restore the address of the message.
  $A564,$02,b$01 Keep the low four bits of the scroll counter.
  $A566,$01 Return unless a new character is due.
  $A567,$03 Reset the scroll counter to zero.
  $A56A,$03 Fetch the character index from #R$A921(#N$A922).
  $A56D,$01 Add one.
  $A56E,$03 Store it.
  $A571,$02 Compare it with the length of the message.
  $A573,$01 Return if the message has been completely printed.
  $A574,$03 Add the index to the address of the message.
  $A577,$01 Fetch the character.
  $A578,$03 Store it in the character record.
  $A57B,$03 Point #REGde at #R$A598.
  $A57E,$03 Jump to #R$A923 to print the character.

c $A581 Copy Column
@ $A581 label=CopyColumn
D $A581 Copies a column of seven pixel lines, one byte wide, from the address
. #N$C0 bytes after the destination address to the destination address.
R $A581 HL The destination address
  $A581,$01 Copy the low byte of the destination address into #REGe.
  $A582,$01 Copy the high byte into #REGd.
  $A583,$02 Set the offset to #N$C0.
  $A585,$03 Add the offset to the source address.
@ $A588 label=CopyColumn_Copy
  $A588,$02 Set the number of lines to #N$07.
@ $A58A label=CopyColumn_Loop
  $A58A,$01 Fetch a byte of the source.
  $A58B,$01 Store it at the destination.
  $A58C,$01 Move down a pixel line in the source.
  $A58D,$01 Move down a pixel line in the destination.
  $A58E,$02 Jump back until all of the lines have been copied.
  $A590,$01 Return.

b $A591 Stage Message
@ $A591 label=StageMessage
D $A591 The characters of the message 'STAGE' and the number of the stage, for
. #R$A4E7. The last character is set by #R$A4E7.
B $A591,$07,$07 STAGE 1

g $A598 Message Character
@ $A598 label=MessageCharacter
D $A598 A text record, in the format used by #R$A923, for the character that
. #R$A544 adds on the right of a message that is scrolling.
B $A598,$04,$04 The position, colour and flags.
B $A59C,$01 The character.

g $A59D Gauges
@ $A59D label=Gauges
D $A59D Two gauges which are drawn as horizontal bars, for #R$A5A5. Each has
. four bytes: the current length of the bar in pixels, the column of the left
. end of the bar, and a word whose high byte is the target length. The word of
. the first gauge is counted down as time passes (see #R$A59D(#N$A59F)).
B $A59D,$01 The current length of the first gauge.
B $A59E,$01 The column of the left end of the first gauge.
W $A59F,$02 The target of the first gauge.
@ $A5A1 label=Gauges_Second
B $A5A1,$01 The current length of the second gauge.
B $A5A2,$01 The column of the left end of the second gauge.
W $A5A3,$02 The target of the second gauge.

c $A5A5 Update Gauge
@ $A5A5 label=UpdateGauge
D $A5A5 Moves the length of a gauge by one pixel towards its target, and draws
. or erases the end of the bar.
R $A5A5 IX The address of the gauge
  $A5A5,$03 Fetch the current length of the bar.
  $A5A8,$03 Compare it with the target length.
  $A5AB,$01 Return if it is already at the target.
  $A5AC,$02 Jump to #R$A5B4 if the target is lower.
  $A5AE,$01 Add one to the length.
  $A5AF,$02 Compare it with #N$55, the longest length.
  $A5B1,$01 Return if the length is too long.
  $A5B2,$02 Jump to #R$A5BB.
@ $A5B4 label=UpdateGauge_Shrink
  $A5B4,$01 Test the length.
  $A5B5,$01 Return if the length is zero.
  $A5B6,$03 Decrease the length by one.
  $A5B9,$02 Jump to #R$A5C0.
@ $A5BB label=UpdateGauge_Grow
  $A5BB,$03 Store the new length.
  $A5BE,$01 Test it.
  $A5BF,$01 Return if it is zero.
@ $A5C0 label=UpdateGauge_Draw
  $A5C0,$01 Keep the length in #REGc.
  $A5C1,$01 Divide it by eight...
  $A5C2,$01 ...to find the number of whole bytes...
  $A5C3,$01 ...in the bar.
  $A5C4,$02,b$01 Keep the number of bytes.
  $A5C6,$03 Add the column of the left end of the bar.
  $A5C9,$01 Set the low byte of the screen address.
  $A5CA,$02 Set the high byte of the screen address for the bottom pixel line.
  $A5CC,$01 Fetch the length again.
  $A5CD,$02,b$01 Keep the number of pixels in the last byte.
  $A5CF,$01 Add one.
  $A5D0,$01 Use it as a counter.
  $A5D1,$01 Clear #REGa.
  $A5D2,$01 Set the carry flag.
@ $A5D3 label=UpdateGauge_Mask
  $A5D3,$01 Rotate the set bit into position.
  $A5D4,$02 Jump back until it is in the right place.
  $A5D6,$01 Keep the mask in #REGe.
  $A5D7,$01 Fetch the length again.
  $A5D8,$04 Jump to #R$A5E6 if the length is short.
  $A5DC,$01 Save the screen address.
  $A5DD,$01 Fetch the byte of the bottom pixel line.
  $A5DE,$01 Flip the pixel of the end of the bar.
  $A5DF,$01 Store it.
  $A5E0,$02 Move to the top pixel line.
  $A5E2,$01 Fetch the byte of the top pixel line.
  $A5E3,$01 Flip the pixel of the end of the bar.
  $A5E4,$01 Store it.
  $A5E5,$01 Restore the screen address.
@ $A5E6 label=UpdateGauge_Pixel
  $A5E6,$01 Move up a pixel line.
  $A5E7,$02 Move the mask one pixel to the right.
  $A5E9,$02 Jump to #R$A5EC unless the mask moved to the next byte.
  $A5EB,$01 Move onto the next byte.
@ $A5EC label=UpdateGauge_Rest
  $A5EC,$01 Fetch the mask.
  $A5ED,$01 Flip the pixel of the end of the bar.
  $A5EE,$01 Store it.
  $A5EF,$01 Move up a pixel line.
  $A5F0,$01 Fetch the mask.
  $A5F1,$01 Flip the pixel of the end of the bar.
  $A5F2,$01 Store it.
  $A5F3,$01 Return.

c $A5F4 Count Down Time
@ $A5F4 label=CountDownTime
D $A5F4 Counts the target of the first gauge down to zero, adding to the score
. and clicking as it goes, one frame at a time.
  $A5F4,$04 Bring back #REGiy from #R$5CF1.
  $A5F8,$04 Point #REGix at #R$A59D.
@ $A5FC label=CountDownTime_Loop
  $A5FC,$01 Enable interrupts...
  $A5FD,$01 ...and wait for the next frame.
  $A5FE,$01 Disable interrupts.
  $A5FF,$03 Fetch the target length of the gauge.
  $A602,$01 Test it.
  $A603,$02 Jump to #R$A617 if it is zero.
  $A605,$03 Set the amount to add to the score.
  $A608,$03 Add it to the score.
  $A60B,$03 Decrease the target length of the gauge.
  $A60E,$03 Fetch the target length again.
  $A611,$01 Add one.
  $A612,$01 Double it.
  $A613,$01 Use it as the length of the click.
  $A614,$03 Play a click.
@ $A617 label=CountDownTime_Update
  $A617,$03 Update the gauge.
  $A61A,$03 Fetch the length of the bar.
  $A61D,$03 Combine it with the target length.
  $A620,$02 Jump back unless both are zero.
  $A622,$01 Return.

c $A623 Find Hidden Entity
@ $A623 label=FindHiddenEntity
D $A623 Looks for an entity whose frame has bit 7 set (a hidden entity).
R $A623 B The number of entities to look at
R $A623 IY The first entity
R $A623 O:IY The hidden entity, if one was found
R $A623 O:F Zero flag reset if a hidden entity was found
  $A623,$03 Set the size of an entity.
@ $A626 label=FindHiddenEntity_Loop
  $A626,$04 Test bit 7 of the frame of the entity.
  $A62A,$01 Return if it is hidden.
  $A62B,$02 Move onto the next entity.
  $A62D,$02 Jump back until all of the entities have been tested.
  $A62F,$01 Return.

c $A630 Create Puff
@ $A630 label=CreatePuff
D $A630 Makes an entity of the type #N$05 (see #R$9E17) at the position of
. another entity, using one of the two hidden entities from #R$B540(#N$B5FE),
. and plays a buzz. Does nothing if both entities are in use.
R $A630 IX The other entity
  $A630,$04 Point #REGiy at the first of the two entities which can be used.
  $A634,$02 Look at #N$02 entities.
  $A636,$03 Call #R$A623 to find a hidden entity.
  $A639,$01 Return if there is not one.
  $A63A,$04 Set the frame of the new entity to #N$00.
  $A63E,$04 Set the type of the new entity to #N$05.
  $A642,$03 Fetch the first byte of the first coordinate of the other entity.
  $A645,$03 Fetch the second byte of the first coordinate of the other entity.
  $A648,$03 Fetch the first size of the other entity.
  $A64B,$02 Clear #REGd.
  $A64D,$02 Halve the size.
  $A64F,$01 Subtract one.
  $A650,$01 Add it to the first coordinate, to find the middle.
  $A651,$03 Store the first byte of the first coordinate of the new entity.
  $A654,$03 Store the second byte of the first coordinate of the new entity.
  $A657,$03 Fetch the first byte of the second coordinate of the other entity.
  $A65A,$03 Fetch the second byte of the second coordinate of the other entity.
  $A65D,$03 Fetch the second size of the other entity.
  $A660,$02 Halve the size.
  $A662,$01 Subtract one.
  $A663,$01 Add it to the second coordinate, to find the middle.
  $A664,$03 Store the first byte of the second coordinate of the new entity.
  $A667,$03 Store the second byte of the second coordinate of the new entity.
  $A66A,$03 Fetch the first byte of the third coordinate of the other entity.
  $A66D,$03 Fetch the second byte of the third coordinate of the other entity.
  $A670,$03 Fetch the third size of the other entity (which is not used).
  $A673,$02 Set the offset to #N$00.
  $A675,$01 Add it to the third coordinate.
  $A676,$01 Add one.
  $A677,$03 Store the first byte of the third coordinate of the new entity.
  $A67A,$03 Store the second byte of the third coordinate of the new entity.
  $A67D,$03 Fetch the heading of the other entity.
  $A680,$03 Copy it to the new entity.
  $A683,$04 Set field #N$10 of the new entity to #N$88.
  $A687,$04 Set field #N$1B of the new entity to #N$40.
  $A68B,$04 Set field #N$17 of the new entity to #N$06.
  $A68F,$03 Jump to #R$9EE3 to play a buzz.

c $A692 Draw Needle Tip
@ $A692 label=DrawNeedleTip
D $A692 Draws the ball at the tip of the needle of a direction gauge into the
. buffer at #N$F517, using self-modifying versions of the sprite drawing code at
. #R$B4E8. The ball is drawn from six pairs of mask and picture values at
. #R$A6D3 (or the shifted version at #R$A6D3(#N$A6DF)), which are taken from the
. stack. The value of #R$5CDC selects the version by bit 0, and the table of
. shifts to use by bits 1-2.
R $A692 HL The address in the buffer
  $A692,$04 Save the stack pointer.
  $A696,$03 Fetch the position of the tip of the needle from #R$5CDC.
  $A699,$03 Point the stack at the shape of the ball.
  $A69C,$04 Jump to #R$A6A3 if bit 0 of the position is reset.
  $A6A0,$03 Point the stack at the shifted shape of the ball.
@ $A6A3 label=DrawNeedleTip_Shift
  $A6A3,$02,b$01 Use bits 1-2, the shift in pixels.
  $A6A5,$02 Jump to #R$A6C2 if the ball is not to be shifted.
  $A6A7,$01 Exchange #REGde and #REGhl, so that #REGde is the address in the
. buffer.
  $A6A8,$02 Add #N$F8 to make the high byte of the address of the shift table.
  $A6AA,$01 Set the high byte of #REGhl to select the shift table.
  $A6AB,$02 Set the number of bytes to step back to the next row to #N$08...
  $A6AD,$03 ...in the operand of the instruction at #N$B52F.
  $A6B0,$02 Set the counter of rows to #N$06...
  $A6B2,$01 ...and store it in the alternate #REGa.
  $A6B3,$03 Set #REGbc to the address of the code at #R$B4E8(#N$B518).
  $A6B6,$04 Patch the jump at #N$B533 to go there.
  $A6BA,$04 Patch the jump at #N$B538 to go there.
  $A6BE,$01 Fetch the byte of the buffer.
  $A6BF,$03 Jump to #R$B4E8(#N$B518) to draw the ball.
@ $A6C2 label=DrawNeedleTip_Unshifted
  $A6C2,$02 Set the low byte of the operand of the instruction at #N$B4DB to
. #N$F9...
  $A6C4,$03 ...to make the offset to the next row #N$FFF9.
  $A6C7,$02 Set the counter of rows to #N$06.
  $A6C9,$03 Point #REGde at the code at #R$B4E8(#N$B4D5).
  $A6CC,$04 Patch the jump at #N$B4E0 to go there.
  $A6D0,$03 Jump to #R$B4E8(#N$B4D5) to draw the ball.

b $A6D3 Needle Tip Shapes
@ $A6D3 label=NeedleTipShapes
D $A6D3 The ball at the tip of the needle in a direction gauge, for #R$A692.
. Each of the two shapes has six rows with two bytes per row: the mask and the
. picture. The second shape is the first shifted by one pixel.
B $A6D3,$0C,$02 The ball.
@ $A6DF label=NeedleTipShapes_Shifted
B $A6DF,$0C,$02 The ball shifted by one pixel.

c $A6EB Get Direction Vector
@ $A6EB label=GetDirectionVector
D $A6EB Finds the sine and cosine of a heading in units of #N$01/#N$40 of a
. turn, using the table at #R$A7C0. Bits 0-3 of the heading are the angle within
. a quadrant, and bits 4-5 are the quadrant. This entry point takes the heading
. from the entity.
R $A6EB A The heading (when entered at #R$A6F1)
R $A6EB IX The entity (when entered at #R$A6EB)
R $A6EB O:BC The first component (a signed number)
R $A6EB O:HL The second component (a signed number)
  $A6EB,$03 Fetch the heading of the entity.
  $A6EE,$03 Store it in #R$5CD8.
@ $A6F1 label=GetDirectionVector_Heading
  $A6F1,$03 Point #REGhl at the table of values.
  $A6F4,$02,b$01 Keep the angle within the quadrant.
  $A6F6,$01 Keep it in #REGb.
  $A6F7,$03 Add the angle to the address.
  $A6FA,$01 Fetch the first value.
  $A6FB,$01 Fetch the angle.
  $A6FC,$02,b$01 Subtract it from #N$0F...
  $A6FE,$01 ...and add one.
  $A6FF,$03 Point #REGhl at #R$A7C0.
  $A702,$03 Add the new angle to the address.
  $A705,$01 Fetch the second value.
  $A706,$02 Clear #REGh.
  $A708,$01 Clear #REGb.
  $A709,$03 Fetch the heading.
  $A70C,$02,b$01 Keep the quadrant.
  $A70E,$01 Return if it is zero.
  $A70F,$04 Jump to #R$A718 unless it is #N$10.
  $A713,$01 Fetch the second value.
  $A714,$01 Swap the values...
  $A715,$01 ...in #REGl and #REGc.
  $A716,$01 #REGb is #N$FF to make the first value negative.
  $A717,$01 Return.
@ $A718 label=GetDirectionVector_Quadrant2
  $A718,$04 Jump to #R$A71F unless it is #N$20.
  $A71C,$01 #REGh is #N$FF to make the second value negative.
  $A71D,$01 #REGb is #N$FF to make the first value negative.
  $A71E,$01 Return.
@ $A71F label=GetDirectionVector_Quadrant3
  $A71F,$01 Fetch the first value.
  $A720,$01 Swap the values...
  $A721,$01 ...in #REGl and #REGc.
  $A722,$01 #REGh is #N$FF to make the second value negative.
  $A723,$01 Return.

c $A724 Draw Direction Gauge
@ $A724 label=DrawDirectionGauge
D $A724 Draws a direction gauge, which shows the heading in #R$5CD8 by a needle
. with a ball at its tip. The picture of the dial is copied into the buffer at
. #N$F517, the needle is drawn into it, and the buffer is then copied to the
. screen. The picture is seven bytes wide and #N$1C pixel lines high.
  $A724,$03 Point #REGde at the buffer.
  $A727,$03 Point #REGhl at #R$822D.
  $A72A,$03 Set the number of bytes to #N$00C4.
  $A72D,$02 Copy the picture into the buffer.
  $A72F,$03 Fetch the heading.
  $A732,$03 Call #R$A6EB(#N$A6F1) to find the components of the heading.
  $A735,$01 Save the second component.
  $A736,$01 Save the first component.
  $A737,$01 Retrieve the first component in #REGhl...
  $A738,$01 ...and the second in #REGbc.
  $A739,$01 Save the first component.
  $A73A,$01 Save the second component.
  $A73B,$01 Save the first component again.
  $A73C,$01 Copy the low byte of the second component into #REGl...
  $A73D,$01 ...and the high byte into #REGh.
  $A73E,$01 Switch to the alternate registers.
  $A73F,$01 Retrieve the first component in #REGde.
  $A740,$02 Set the length of the needle to #N$18.
  $A742,$03 Call #R$A7D1 to draw the needle.
  $A745,$01 Retrieve the second component.
  $A746,$01 Fetch the sign byte of the component.
  $A747,$02 Clear #REGh.
  $A749,$01 Multiply the component by two...
  $A74A,$01 ...four...
  $A74B,$01 ...and eight.
  $A74C,$02 Copy it into #REGbc.
  $A74E,$01 Multiply it by sixteen...
  $A74F,$01 ...and add the eight times value to make twenty-four times.
  $A750,$01 Test the sign byte.
  $A751,$01 Fetch the high byte of the result, which is the offset in pixels.
  $A752,$02 Jump to #R$A756 if the component was positive.
  $A754,$02 Make the offset negative.
@ $A756 label=DrawDirectionGauge_Offset
  $A756,$01 Add one.
  $A757,$03 Store the offset in #R$5CDC.
  $A75A,$02 Divide the offset by two...
  $A75C,$02 ...four...
  $A75E,$02 ...and eight to find the byte.
  $A760,$02 Add the offset of the needle in the buffer.
  $A762,$01 Keep the column in #REGe.
  $A763,$01 Retrieve the first component.
  $A764,$01 Fetch the sign byte of the component.
  $A765,$02 Clear #REGh.
  $A767,$01 Multiply the component by two...
  $A768,$01 ...and four.
  $A769,$02 Copy it into #REGbc.
  $A76B,$01 Multiply it by eight...
  $A76C,$01 ...and add the four times value to make twelve times.
  $A76D,$01 Test the sign byte.
  $A76E,$01 Fetch the high byte of the result, which is the offset in pixel
. lines.
  $A76F,$02 Jump to #R$A773 if the component was negative.
  $A771,$02 Make the offset negative.
@ $A773 label=DrawDirectionGauge_Row
  $A773,$01 Keep the offset in #REGb.
  $A774,$01 Multiply it by two...
  $A775,$01 ...four...
  $A776,$01 ...and eight.
  $A777,$01 Subtract the offset to make seven times the offset.
  $A778,$01 Add the column.
  $A779,$01 Set the low byte of the address in the buffer.
  $A77A,$02 Set the high byte of the address in the buffer.
  $A77C,$03 Call #R$A692 to draw the ball at the tip of the needle.
N $A77F Copy the buffer to the screen.
  $A77F,$04 Save the stack pointer.
  $A783,$03 Point the stack at the buffer.
  $A786,$03 Point #REGhl at the bottom left of the position on the screen.
  $A789,$02 Load the offset of the gauge on the screen (this is set at #N$A78A).
  $A78B,$01 Add it to the address.
  $A78C,$01 Set the low byte of the address.
  $A78D,$02 Set the number of pixel lines to #N$1C.
@ $A78F label=DrawDirectionGauge_Line
  $A78F,$01 Remember the start of the line.
  $A790,$01 Fetch the first two bytes of the line.
  $A791,$01 Store the first byte.
  $A792,$01 Move onto the next byte of the line.
  $A793,$01 Store the second byte.
  $A794,$01 Move onto the next byte of the line.
  $A795,$01 Fetch the third and fourth bytes of the line.
  $A796,$01 Store the third byte.
  $A797,$01 Move onto the next byte of the line.
  $A798,$01 Store the fourth byte.
  $A799,$01 Move onto the next byte of the line.
  $A79A,$01 Fetch the fifth and sixth bytes of the line.
  $A79B,$01 Store the fifth byte.
  $A79C,$01 Move onto the next byte of the line.
  $A79D,$01 Store the sixth byte.
  $A79E,$01 Move onto the next byte of the line.
  $A79F,$01 Fetch the seventh byte and the first byte of the next line.
  $A7A0,$01 Step back over the byte of the next line.
  $A7A1,$01 Store the seventh byte.
  $A7A2,$01 Decrease the number of lines by one.
  $A7A3,$02 Jump to #R$A7BB if all of the lines have been copied.
  $A7A5,$01 Go back to the start of the line.
  $A7A6,$01 Fetch the high byte of the address.
  $A7A7,$01 Move up a pixel line.
  $A7A8,$02,b$01 Keep the number of the pixel line which the line was in.
  $A7AA,$03 Jump back to copy the next line unless that was the top pixel line
. of a character row.
  $A7AD,$01 Fetch the low byte of the address.
  $A7AE,$02 Move up a character row.
  $A7B0,$01 Store it.
  $A7B1,$03 Jump back to copy the next line if the row was at the top of a
. screen section.
  $A7B4,$01 Fetch the high byte of the address.
  $A7B5,$02 Move to the bottom pixel line of the character row.
  $A7B7,$01 Store it.
  $A7B8,$03 Jump back to copy the next line.
@ $A7BB label=DrawDirectionGauge_Done
  $A7BB,$04 Restore the stack pointer.
  $A7BF,$01 Return.

b $A7C0 Direction Table
@ $A7C0 label=DirectionTable
D $A7C0 The cosine of an angle from #N$00 to #N$10 sixteenths of a quarter turn,
. scaled so that #N$FF is one, for #R$A6EB.
B $A7C0,$11,$08,$09

c $A7D1 Draw Line
@ $A7D1 label=DrawLine
D $A7D1 Draws a line into the buffer at #N$F517, starting from the centre of the
. dial. The line is two pixels wide, and it is plotted by adding the components
. of the direction to two running totals; each carry moves the line by a pixel
. line (using the first component) or by a pixel along a line (using the
. second). The code is patched according to the signs of the components.
R $A7D1 B The number of pixels to plot
R $A7D1 DE The first component, which moves the line up or down
R $A7D1 HL' The second component, which moves the line left or right
  $A7D1,$01 Test the sign byte of the first component.
  $A7D2,$02 Set the step to #N$F9 (minus seven bytes), to move up a pixel line.
  $A7D4,$02 Jump to #R$A7D8 if the component is positive.
  $A7D6,$02 Set the step to #N$07, to move down a pixel line.
@ $A7D8 label=DrawLine_Step
  $A7D8,$03 Store the step in the operand of the instruction at #N$A819.
  $A7DB,$02 Halve the first component.
  $A7DD,$02 Clear the running total in #REGd.
  $A7DF,$01 Switch to the alternate registers.
  $A7E0,$01 Test the sign byte of the second component.
  $A7E1,$03 Set the instructions for moving to the right.
  $A7E4,$02 Set the opcode of INC L.
  $A7E6,$02 Jump to #R$A7ED if the component is positive.
  $A7E8,$03 Set the instructions for moving to the left.
  $A7EB,$02 Set the opcode of DEC L.
@ $A7ED label=DrawLine_Direction
  $A7ED,$03 Patch the instruction at #N$A82D.
  $A7F0,$01 Fetch the second byte of the instruction for rotating the pixel.
  $A7F1,$03 Patch the instruction at #N$A825.
  $A7F4,$01 Fetch the pixel pattern at which to move onto the next byte.
  $A7F5,$03 Patch the operand of the instruction at #N$A828.
  $A7F8,$02 Clear the high byte of the second running total.
  $A7FA,$01 Switch back to the normal registers.
  $A7FB,$02 Set the pixel pattern to #N$18.
  $A7FD,$03 Point #REGhl at the centre of the dial in the buffer.
@ $A800 label=DrawLine_Plot
  $A800,$01 Fetch the pixel pattern.
  $A801,$05 Jump to #R$A80F if it does not.
  $A806,$02 Set the pixel at the right of the byte.
  $A808,$01 Move onto the next byte.
  $A809,$02 Set the pixel at the left of the byte.
  $A80B,$01 Move back to the first byte.
  $A80C,$03 Jump to #R$A811.
@ $A80F label=DrawLine_Pixels
  $A80F,$01 Combine the pixel pattern with the byte.
  $A810,$01 Store it.
@ $A811 label=DrawLine_Count
  $A811,$01 Decrease the number of pixels by one.
  $A812,$01 Return if all of the pixels have been plotted.
  $A813,$01 Fetch the running total of the first component.
  $A814,$01 Add the first component.
  $A815,$01 Store it.
  $A816,$03 Jump to #R$A81D if there was no carry.
  $A819,$02 Set the step (this is patched at #N$A81A).
  $A81B,$01 Add it to the address, to move up or down a pixel line.
  $A81C,$01 Store it.
@ $A81D label=DrawLine_Second
  $A81D,$01 Switch to the alternate registers.
  $A81E,$01 Fetch the running total of the second component.
  $A81F,$01 Add the second component.
  $A820,$01 Store it.
  $A821,$01 Switch back to the normal registers.
  $A822,$03 Jump to #R$A800 to plot the next pixel if there was no carry.
  $A825,$02 Rotate the pixel pattern (this is patched at #N$A826).
  $A827,$01 Fetch the pattern.
  $A828,$05 Jump to #R$A800 if the pattern is not there yet.
  $A82D,$01 Move onto the next byte (this is patched at #N$A82D).
  $A82E,$03 Jump to #R$A800.

b $A831 Pause Message
@ $A831 label=PauseMessage
D $A831 The characters of the message 'PAUSED', for #R$A837.
B $A831,$06,$06 PAUSED

c $A837 Pause Game
@ $A837 label=PauseGame
D $A837 Pauses the game, if SPACE or CAPS SHIFT is being pressed, until one of
. them is pressed again. The message 'PAUSED' scrolls in and out across the
. window.
  $A837,$04 Bring back #REGiy from #R$5CF1.
  $A83B,$03 Test whether SPACE or CAPS SHIFT is being pressed.
  $A83E,$01 Return if not.
@ $A83F label=PauseGame_Release
  $A83F,$03 Test whether SPACE or CAPS SHIFT is being pressed.
  $A842,$02 Jump back until the keys have been released.
  $A844,$03 Set the scroll counter to #N$0C and the character index to #N$FF.
  $A847,$03 Store them in #R$A921 and #R$A921(#N$A922).
  $A84A,$02 Set the length of the message to #N$06...
  $A84C,$03 ...in the operand of the instruction at #N$A571.
@ $A84F label=PauseGame_ScrollIn
  $A84F,$01 Enable interrupts...
  $A850,$01 ...and wait for the next frame.
  $A851,$01 Disable interrupts.
  $A852,$03 Point #REGhl at #R$A831.
  $A855,$03 Scroll the message by one step.
  $A858,$03 Point #REGhl at #R$A831.
  $A85B,$03 Scroll the message by another step.
  $A85E,$03 Fetch the scroll counter and the character index.
  $A861,$03 Set the values at which the message is completely in.
  $A864,$01 Clear the carry flag.
  $A865,$02 Compare them.
  $A867,$02 Jump back to scroll the message until it is completely in.
@ $A869 label=PauseGame_Wait
  $A869,$03 Wait for a short time.
  $A86C,$03 Test whether SPACE or CAPS SHIFT is being pressed.
  $A86F,$02 Jump back until one of them is pressed.
@ $A871 label=PauseGame_Release2
  $A871,$03 Test whether SPACE or CAPS SHIFT is being pressed.
  $A874,$02 Jump back until the keys have been released.
@ $A876 label=PauseGame_ScrollOut
  $A876,$01 Enable interrupts...
  $A877,$01 ...and wait for the next frame.
  $A878,$01 Disable interrupts.
  $A879,$03 Point #REGhl at #R$A831.
  $A87C,$03 Scroll the message by one step.
  $A87F,$03 Point #REGhl at #R$A831.
  $A882,$03 Scroll the message by one step.
  $A885,$03 Point #REGhl at #R$A831.
  $A888,$03 Scroll the message by one step.
  $A88B,$03 Point #REGhl at #R$A831.
  $A88E,$03 Scroll the message by one step.
  $A891,$03 Fetch the character index.
  $A894,$04 Jump back to #R$A876 to scroll the message until it has gone.

c $A898 Show Exit Message
@ $A898 label=ShowExitMessage
D $A898 Prints the message 'EXIT OPEN' on the window if all of the bottles have
. been collected.
  $A898,$03 Fetch the number of bottles left from #R$DEE0.
  $A89B,$01 Test it.
  $A89C,$01 Return if there are some left.
  $A89D,$03 Point #REGde at #R$A8A6.
  $A8A0,$03 Print the first part of the message.
  $A8A3,$03 Print the second part of the message.

b $A8A6 Exit Message
@ $A8A6 label=ExitMessage
D $A8A6 The two text records of the message 'EXIT OPEN', for #R$A898.
B $A8A6,$02 Position: x=#N$70, y=#N$87.
B $A8A8,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $A8A9,$01 Length #N$04.
B $A8AA,$04 "EXIT"
B $A8AE,$02 Position: x=#N$70, y=#N$8F.
B $A8B0,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $A8B1,$01 Length #N$04.
B $A8B2,$04 "OPEN"

c $A8B6 Wait
@ $A8B6 label=Wait
D $A8B6 Waits for a short time.
  $A8B6,$02 Set the length of the wait to #N$40.
  $A8B8,$03 Jump to #R$A8F9 to wait.

c $A8BB Test Pause Keys
@ $A8BB label=TestPauseKeys
D $A8BB Tests whether SPACE or CAPS SHIFT is being pressed.
R $A8BB O:F Zero flag reset if one of them is being pressed
  $A8BB,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | SYMBOL SHIFT | M | N | B }
. TABLE#
  $A8C0,$02,b$01 Keep the bit for SPACE.
  $A8C2,$01 Return if SPACE is being pressed.
  $A8C3,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | CAPS SHIFT | Z | X | C | V }
. TABLE#
  $A8C8,$02,b$01 Keep the bit for CAPS SHIFT.
  $A8CA,$01 Return.

c $A8CB Read Keyboard
@ $A8CB label=ReadKeyboard
D $A8CB Reads the rows of the keyboard which are selected by the high byte of
. the port address.
R $A8CB A The high byte of the port address (#N$00 selects all of the rows)
R $A8CB O:A The keys which are being pressed (bit set for pressed)
  $A8CB,$02 Read the keyboard.
  $A8CD,$01 Invert the bits.
  $A8CE,$02,b$01 Keep the bits for the five keys.
  $A8D0,$01 Return.

c $A8D1 Reset Attributes
@ $A8D1 label=ResetAttributes
D $A8D1 Sets the attributes of the lower two thirds of the screen to bright
. white on black, using the stack. The same code clears the screen when entered
. at #R$A8E1.
  $A8D1,$04 Save the stack pointer.
  $A8D5,$03 Point the stack at the end of the attribute file.
  $A8D8,$03 Set the number of pushes to #N$0100.
  $A8DB,$03 Set the value to #N$47 (bright white ink on black paper).
  $A8DE,$03 Jump to #R$A8EE.

c $A8E1 Clear Screen
@ $A8E1 label=ClearScreen
D $A8E1 Sets the pixels of the whole screen to zero, using the stack.
  $A8E1,$04 Save the stack pointer.
  $A8E5,$03 Point the stack at the end of the pixel file.
  $A8E8,$03 Set the number of pushes to #N$0C00.
  $A8EB,$03 Set the value to #N$00.
@ $A8EE label=ClearScreen_Fill
  $A8EE,$01 Write two bytes.
  $A8EF,$02 Jump back until a block of pushes has been done.
  $A8F1,$01 Decrease the number of blocks by one.
  $A8F2,$02 Jump back until all of the blocks have been done.
  $A8F4,$04 Restore the stack pointer.
  $A8F8,$01 Return.

c $A8F9 Delay
@ $A8F9 label=Delay
D $A8F9 Waits for a time which depends on the value in #REGd.
E $A8F9 View the equivalent code in;
. #LIST
. { #CYBERUN$A802 }
. LIST#
R $A8F9 D The length of the delay
  $A8F9,$02 Set the inner counter to #N$FF.
@ $A8FB label=Delay_Inner
  $A8FB,$01 Decrease the inner counter by one.
  $A8FC,$02 Jump back until none remain.
  $A8FE,$01 Decrease the outer counter by one.
  $A8FF,$02 Jump back until none remain.
  $A901,$01 Return.

c $A902 Scroll Area Left
@ $A902 label=ScrollAreaLeft
D $A902 Scrolls a rectangular area of the screen one pixel to the left, and
. increases the scroll counter at #R$A921.
R $A902 B The width of the area in bytes
R $A902 C The height of the area in pixel lines
R $A902 HL The pixel position of the right end of the bottom line of the area
  $A902,$03 Convert the pixel position into a screen address.
  $A905,$01 Fetch the width.
  $A906,$03 Store it in the operand of the instruction at #N$A90B.
@ $A909 label=ScrollAreaLeft_Line
  $A909,$01 Save the address of the right end of the line.
  $A90A,$01 Clear the carry flag.
  $A90B,$02 Set the number of bytes in the line (this is patched at #N$A90C).
@ $A90D label=ScrollAreaLeft_Byte
  $A90D,$02 Rotate the byte left through the carry flag.
  $A90F,$01 Move onto the next byte to the left.
  $A910,$02 Jump back until the line has been done.
  $A912,$01 Restore the address of the right end of the line.
  $A913,$03 Move up a pixel line.
  $A916,$01 Decrease the number of lines by one.
  $A917,$02 Jump back until all of the lines have been done.
  $A919,$03 Fetch the scroll counter.
  $A91C,$01 Add one.
  $A91D,$03 Store it.
  $A920,$01 Return.

g $A921 Scroll Counters
@ $A921 label=ScrollCounter
D $A921 The counters used when a message is scrolled by #R$A544.
B $A921,$01 The number of pixels that the message has scrolled.
B $A922,$01 The index of the last character of the message to be printed.

c $A923 Print Text
@ $A923 label=PrintText
D $A923 Prints a text record. A text record has four bytes followed by the
. characters: the x position in pixels, the y position in pixels of the bottom
. line of the text, the attribute and the number of characters in bits 0-5. Bit
. 7 of the number of characters selects double height, and bits 6 and 7 together
. select double height and double width.
. .
. #PUSHS #UDGTABLE { #BLANKSCREEN(0)
. #SIM(start=$A923,stop=$0000,de=$E125,sp=$5B60)
. #SCR$02,$00,$00,$08,$04(print-text) } UDGTABLE# #POPS
R $A923 DE The address of the text record
R $A923 O:DE The address after the text record
  $A923,$01 Exchange #REGde and #REGhl, so that #REGhl is the address of the
. record.
  $A924,$01 Fetch the x position.
  $A925,$01 Move onto the y position.
  $A926,$01 Fetch it.
  $A927,$01 Move onto the attribute.
  $A928,$01 Fetch it.
  $A929,$03 Store it in the attribute of the rectangle at #R$AAE2(#N$AAE4).
  $A92C,$01 Move onto the number of characters and the flags.
  $A92D,$01 Fetch them.
  $A92E,$01 Move onto the first character.
  $A92F,$01 #REGa is #N$00.
  $A930,$03 Store it in the operand of the jump at #N$A992, to select the normal
. size.
  $A933,$01 #REGa is #N$01.
  $A934,$03 Store it as the height of the rectangle at #R$AAE2(#N$AAE3).
  $A937,$01 Fetch the number of characters.
  $A938,$02,b$01 Keep the number of characters.
  $A93A,$03 Store it as the width of the rectangle at #R$AAE2.
  $A93D,$04 Jump to #R$A962 if bit 7, the flag for double height, is reset.
  $A941,$04 Jump to #R$A951 if bit 6, the flag for double width, is set.
  $A945,$02 Set the distance to jump to #N$0C...
  $A947,$03 ...to select double height.
  $A94A,$02 Set the height of the rectangle to #N$02.
  $A94C,$03 Store it.
  $A94F,$02 Jump to #R$A962.
@ $A951 label=PrintText_Double
  $A951,$02 Set the distance to jump to #N$1E...
  $A953,$03 ...to select double height and width.
  $A956,$02 Set the height of the rectangle to #N$02.
  $A958,$03 Store it.
  $A95B,$03 Fetch the width of the rectangle.
  $A95E,$01 Double it.
  $A95F,$03 Store it.
@ $A962 label=PrintText_Attributes
  $A962,$01 Exchange #REGde and #REGhl, so that #REGde is the address of the
. first character and #REGhl is the position.
  $A963,$01 Save the number of characters.
  $A964,$01 Save the address of the first character.
  $A965,$03 Call #R$AAE5 to set the attributes.
  $A968,$01 Restore the address of the first character.
  $A969,$01 Restore the number of characters.
  $A96A,$03 Convert the pixel position into a screen address.
  $A96D,$01 Fetch the number of characters.
  $A96E,$02,b$01 Keep the number of characters.
  $A970,$01 Store it in #REGb.
@ $A971 label=PrintText_Character
  $A971,$01 Save the number of characters.
  $A972,$03 Print a character.
  $A975,$01 Restore the number of characters.
  $A976,$01 Move onto the next character.
  $A977,$02 Jump back until all of the characters have been printed.
  $A979,$01 Return.

c $A97A Print Character
@ $A97A label=PrintCharacter
D $A97A Prints a character of a text record. The shapes of the characters are in
. the font at #R$64E0, and each is seven bytes with the bottom line first.
E $A97A View the equivalent code in;
. #LIST
. { #CYBERUN$A0B1 }
. LIST#
R $A97A DE The address of the character
R $A97A HL The screen address of the bottom line of the character
R $A97A O:HL The screen address of the bottom line of the next character
  $A97A,$01 Save the address of the character.
  $A97B,$01 Fetch the character.
  $A97C,$01 Exchange #REGde and #REGhl.
  $A97D,$01 Save the screen address.
  $A97E,$01 Copy the character into #REGl.
  $A97F,$02 Clear #REGh.
  $A981,$01 Clear #REGd.
  $A982,$01 Multiply the character by two...
  $A983,$01 ...four...
  $A984,$01 ...and eight.
  $A985,$01 Copy the character into #REGe.
  $A986,$02 Subtract it, to make seven times the character.
  $A988,$03 Point #REGde at #R$64E0.
  $A98B,$01 Add the offset to find the shape of the character.
  $A98C,$01 Restore the screen address into #REGde.
  $A98D,$01 Exchange #REGde and #REGhl, so that #REGde is the shape and #REGhl
. is the screen address.
  $A98E,$01 Save the screen address.
  $A98F,$02 Set the number of lines to #N$07.
@ $A991 label=PrintCharacter_Patched
  $A991,$02 Jump to the routine for the size of text (this is patched at
. #N$A992).
@ $A993 label=PrintCharacter_Normal
  $A993,$01 Fetch a line of the shape.
  $A994,$01 Write it to the screen.
  $A995,$01 Move onto the next line of the shape.
  $A996,$03 Move up a pixel line on the screen.
  $A999,$02 Jump back until all of the lines have been written.
  $A99B,$01 Restore the screen address.
  $A99C,$01 Move onto the next character cell.
  $A99D,$01 Restore the address of the character.
  $A99E,$01 Return.
@ $A99F label=PrintCharacter_DoubleHeight
  $A99F,$01 Fetch a line of the shape.
  $A9A0,$01 Write it to the screen.
  $A9A1,$01 Save it.
  $A9A2,$03 Move up a pixel line on the screen.
  $A9A5,$01 Restore it.
  $A9A6,$01 Write it to the screen again.
  $A9A7,$03 Move up a pixel line on the screen.
  $A9AA,$01 Move onto the next line of the shape.
  $A9AB,$02 Jump back until all of the lines have been written.
  $A9AD,$01 Restore the screen address.
  $A9AE,$01 Move onto the next character cell.
  $A9AF,$01 Restore the address of the character.
  $A9B0,$01 Return.
@ $A9B1 label=PrintCharacter_DoubleBoth
  $A9B1,$01 Fetch the number of lines.
@ $A9B2 label=PrintCharacter_DoubleBothLine
  $A9B2,$01 Save the number of lines in the alternate #REGa.
  $A9B3,$03 Point #REGbc at #R$A9EE.
  $A9B6,$01 Fetch a line of the shape.
  $A9B7,$01 Move the upper four bits...
  $A9B8,$01 ...down...
  $A9B9,$01 ...to the lower...
  $A9BA,$01 ...four bits.
  $A9BB,$02,b$01 Keep the upper nibble.
  $A9BD,$01 Add it to the address of the table.
  $A9BE,$01 Store the low byte.
  $A9BF,$01 Fetch the high byte.
  $A9C0,$02 Add the carry.
  $A9C2,$01 Store the high byte.
  $A9C3,$01 Fetch the doubled bits.
  $A9C4,$01 Write them to the left cell.
  $A9C5,$01 Keep them in #REGc.
  $A9C6,$01 Save the screen address.
  $A9C7,$03 Move up a pixel line on the screen.
  $A9CA,$01 Write the doubled bits again.
  $A9CB,$01 Restore the screen address.
  $A9CC,$01 Move onto the right cell.
  $A9CD,$03 Point #REGbc at #R$A9EE.
  $A9D0,$01 Fetch the line of the shape.
  $A9D1,$02,b$01 Keep the lower nibble.
  $A9D3,$01 Add it to the address of the table.
  $A9D4,$01 Store the low byte.
  $A9D5,$01 Fetch the high byte.
  $A9D6,$02 Add the carry.
  $A9D8,$01 Store the high byte.
  $A9D9,$01 Fetch the doubled bits.
  $A9DA,$01 Write them to the right cell.
  $A9DB,$01 Keep them in #REGc.
  $A9DC,$03 Move up a pixel line on the screen.
  $A9DF,$01 Write the doubled bits again.
  $A9E0,$01 Move back to the left cell.
  $A9E1,$03 Move up a pixel line on the screen.
  $A9E4,$01 Move onto the next line of the shape.
  $A9E5,$01 Fetch the number of lines.
  $A9E6,$01 Decrease it by one.
  $A9E7,$02 Jump back until all of the lines have been written.
  $A9E9,$01 Restore the screen address.
  $A9EA,$01 Move onto the next cell...
  $A9EB,$01 ...which is two cells further on.
  $A9EC,$01 Restore the address of the character.
  $A9ED,$01 Return.

b $A9EE Doubled Nibbles
@ $A9EE label=DoubledNibbles
D $A9EE The value to use for each four bits of a line of a character when it is
. printed at double width: each bit is repeated twice.
B $A9EE,$10,$08

c $A9FE Get Screen Address
@ $A9FE label=GetScreenAddress
D $A9FE Finds the address in the display file of a position in pixels.
E $A9FE View the equivalent code in;
. #LIST
. { #CYBERUN$A149 }
. LIST#
R $A9FE H The y position in pixels from the top of the screen
R $A9FE L The x position in pixels from the left of the screen
R $A9FE O:HL The screen address
  $A9FE,$01 Fetch the x position.
  $A9FF,$02 Divide it by two...
  $AA01,$02 ...four...
  $AA03,$02 ...and eight to find the column.
  $AA05,$02,b$01 Keep the column.
  $AA07,$01 Store it in #REGl.
  $AA08,$01 Fetch the y position.
  $AA09,$02 Move bits 3-5, the character row within the section, up...
  $AA0B,$02 ...to bits 5-7.
  $AA0D,$02,b$01 Keep them.
  $AA0F,$01 Add the column.
  $AA10,$01 Store it in #REGl.
  $AA11,$01 Fetch the y position.
  $AA12,$02,b$01 Use bits 0-2, the pixel line within the character row.
  $AA14,$01 Save it in the alternate #REGa.
  $AA15,$01 Fetch the y position.
  $AA16,$02 Move bits 6-7, the section of the screen, down...
  $AA18,$02 ...to...
  $AA1A,$02 ...bits 3-4.
  $AA1C,$02,b$01 Keep them.
  $AA1E,$02,b$01 Add the address of the display file.
  $AA20,$01 Store it in #REGh.
  $AA21,$01 Retrieve the pixel line.
  $AA22,$01 Add it.
  $AA23,$01 Store it in #REGh.
  $AA24,$01 Return.

c $AA25 Get Attribute Address
@ $AA25 label=GetAttributeAddress
D $AA25 Finds the address in the attribute file of a position in pixels.
R $AA25 H The y position in pixels from the top of the screen
R $AA25 L The x position in pixels from the left of the screen
R $AA25 O:HL The attribute address
  $AA25,$02 Divide the y position by two...
  $AA27,$02 ...four...
  $AA29,$02 ...and eight, to make the character row.
  $AA2B,$02 Halve the row, moving its lowest bit into the carry flag.
  $AA2D,$02 Move that bit into the top of #REGl, halving the x position.
  $AA2F,$02 Halve the row again, moving its next bit into the carry flag.
  $AA31,$02 Move that bit into #REGl.
  $AA33,$02 Halve the row again, moving its top bit into the carry flag.
  $AA35,$02 Move that bit into #REGl, which is now the offset within the
. section.
  $AA37,$01 Fetch the section of the screen.
  $AA38,$02 Add the address of the attribute file.
  $AA3A,$01 Store it in #REGh.
  $AA3B,$01 Return.

c $AA3C Add To Address
@ $AA3C label=AddToAddress
D $AA3C Adds a value to an address.
R $AA3C A The value
R $AA3C HL The address
R $AA3C O:HL The address plus the value
  $AA3C,$01 Add the value to the low byte of the address.
  $AA3D,$01 Store it.
  $AA3E,$01 Return if there was no carry.
  $AA3F,$01 Increase the high byte of the address.
  $AA40,$01 Return.

c $AA41 Jump Via Table
@ $AA41 label=JumpViaTable
D $AA41 Jumps to the routine in a table of addresses.
R $AA41 A The number of the entry in the table
R $AA41 HL The address of the table
  $AA41,$01 Copy the number of the entry into #REGe.
@ $AA42 label=JumpViaTable_Index
  $AA42,$02 Clear #REGd.
  $AA44,$01 Add the number of the entry to the address of the table...
  $AA45,$01 ...twice, to find the entry.
  $AA46,$01 Fetch the low byte of the address of the routine.
  $AA47,$01 Move onto the high byte.
  $AA48,$01 Fetch it.
  $AA49,$01 Set the low byte of the address.
  $AA4A,$01 Jump to the routine.

c $AA4B Move Up A Line
@ $AA4B label=MoveUpALine
D $AA4B Moves a screen address up by one pixel line.
R $AA4B HL The screen address
R $AA4B O:HL The screen address of the pixel line above
  $AA4B,$01 Fetch the high byte of the address.
  $AA4C,$01 Move up a pixel line.
  $AA4D,$02,b$01 Keep the number of the pixel line which it was in.
  $AA4F,$01 Return unless that was the top pixel line of a character row.
  $AA50,$01 Fetch the low byte of the address.
  $AA51,$02 Move up a character row.
  $AA53,$01 Store it.
  $AA54,$01 Return if the row was at the top of a section of the screen.
  $AA55,$01 Fetch the high byte of the address.
  $AA56,$02 Move to the bottom pixel line of the character row.
  $AA58,$01 Store it.
  $AA59,$01 Return.

g $AA5A Render Flag
@ $AA5A label=RenderFlag
D $AA5A A byte which #R$AA5B sets to zero and which is used by the code that
. draws the view.
B $AA5A,$01

c $AA5B Build View
@ $AA5B label=BuildView
D $AA5B Builds the view buffer at #R$E5BB from the position of the view in
. #R$5CE2 and #R$5CE2(#N$5CE4), one strip at a time in twelve passes.
. .
. #PUSHS #UDGTABLE { #NEWGAME(0)
. #SIM(start=$AA5B,stop=$0000,sp=$5B60)
. #SIM(start=$E4CC,stop=$0000,sp=$5B60)
. #SCR$02(build-view) } UDGTABLE# #POPS
  $AA5B,$03 #REGhl is #N$0000.
  $AA5E,$03 Store it in #R$5CF6.
  $AA61,$03 Fetch the first value from #R$5CE2.
  $AA64,$04 Fetch the second value from #R$5CE2(#N$5CE4).
  $AA68,$01 Save the first value.
  $AA69,$01 Add the second value.
  $AA6A,$03 #REGbc is #N$0080.
  $AA6D,$01 Add it.
  $AA6E,$03 Store the result in #R$5CE7.
  $AA71,$01 Retrieve the first value.
  $AA72,$02 Halve the second value...
  $AA74,$02 ...with the carry going into #REGe.
  $AA76,$02 Halve the first value...
  $AA78,$02 ...with the carry going into #REGl.
  $AA7A,$03 Subtract the second halved value from the first.
  $AA7D,$03 Store the result in #R$5CEE.
  $AA80,$03 #REGde is #N$FFA8.
  $AA83,$03 Call #R$C9A0.
  $AA86,$03 Point #REGhl at the first strip of the view buffer.
  $AA89,$03 Store it in #R$5CBB.
  $AA8C,$02 Set the number of passes to #N$0C.
@ $AA8E label=BuildView_Pass
  $AA8E,$01 Save the number of passes.
  $AA8F,$03 Point #REGhl at the first strip of the view buffer.
  $AA92,$03 Set the size of a row to #N$0017.
  $AA95,$02 Set the number of rows to #N$80.
  $AA97,$01 Set #REGa to zero.
  $AA98,$03 Store it in #R$5CF0.
  $AA9B,$03 Store it in #R$AA5A.
@ $AA9E label=BuildView_Clear
  $AA9E,$01 Clear a byte of the strip.
  $AA9F,$01 Move onto the next byte.
  $AAA0,$01 Clear that byte.
  $AAA1,$01 Move onto the next row.
  $AAA2,$02 Jump back until all of the rows have been cleared.
  $AAA4,$03 #REGhl is #N$C0E1.
  $AAA7,$03 Call #R$BA70.
  $AAAA,$01 Restore the number of passes.
  $AAAB,$01 Decrease it by one.
  $AAAC,$01 Return if all of the passes have been done.
  $AAAD,$01 Switch to the alternate registers.
  $AAAE,$03 Call #R$DFAB.
  $AAB1,$03 Point #REGde at #R$E5BB.
  $AAB4,$03 Point #REGhl at the second column of the view buffer.
  $AAB7,$03 Set the number of bytes to #N$0BFE.
  $AABA,$02 Move the contents of the view buffer along by two bytes.
  $AABC,$02 #REGe is #N$08.
  $AABE,$03 Call #R$C99E.
  $AAC1,$01 Switch back to the normal registers.
  $AAC2,$02 Jump back for the next pass.

c $AAC4 Draw Picture
@ $AAC4 label=DrawPicture
D $AAC4 Draws a picture on the screen. A picture starts with its width in bytes
. and its height in pixel lines, and is followed by the bytes of each line with
. the bottom line first.
. .
. #PUSHS #UDGTABLE { #BLANKSCREEN(0)
. #SIM(start=$AAC4,stop=$0000,de=$6066,hl=$1960,sp=$5B60)
. #SCR$02,$00,$00,$20,$08(draw-picture) } UDGTABLE# #POPS
R $AAC4 DE The address of the picture
R $AAC4 HL The pixel position of the bottom left (H is y, L is x)
  $AAC4,$01 Save the position.
  $AAC5,$03 Convert the position into a screen address.
  $AAC8,$01 Fetch the width of the picture.
  $AAC9,$03 Store it in the operand of the instruction at #N$AAD1.
  $AACC,$01 Move onto the height.
  $AACD,$01 Fetch it.
  $AACE,$01 Move onto the first byte of the picture.
  $AACF,$01 Keep the height in #REGc.
@ $AAD0 label=DrawPicture_Line
  $AAD0,$01 Save the screen address of the start of the line.
  $AAD1,$02 Set the width in bytes (this is patched at #N$AAD2).
@ $AAD3 label=DrawPicture_Byte
  $AAD3,$01 Fetch a byte of the picture.
  $AAD4,$01 Write it to the screen.
  $AAD5,$01 Move onto the next byte of the picture.
  $AAD6,$01 Move onto the next byte of the screen.
  $AAD7,$02 Jump back until the line has been drawn.
  $AAD9,$01 Restore the screen address of the start of the line.
  $AADA,$03 Move up a pixel line.
  $AADD,$01 Decrease the height by one.
  $AADE,$02 Jump back until all of the lines have been drawn.
  $AAE0,$01 Restore the position.
  $AAE1,$01 Return.

g $AAE2 Attribute Rectangle
@ $AAE2 label=AttributeRectangle
D $AAE2 A rectangle of attributes for #R$AAE5, which has three bytes.
B $AAE2,$01 The width in character cells.
B $AAE3,$01 The height in character cells.
B $AAE4,$01 The attribute.

c $AAE5 Fill Scratch Rectangle
@ $AAE5 label=FillScratchRectangle
D $AAE5 Fills a rectangle of the attribute file using the rectangle at #R$AAE2.
R $AAE5 HL The pixel position of the bottom left of the rectangle
  $AAE5,$03 Point #REGde at the rectangle.
@ $AAE8 label=FillRectangle
N $AAE8 This entry point takes the address of the rectangle in #REGde.
  $AAE8,$01 Save the position.
  $AAE9,$03 Convert the position into an attribute address.
  $AAEC,$01 Fetch the width of the rectangle.
  $AAED,$03 Store it in the operand of the instruction at #N$AAFE.
  $AAF0,$02 Add #N$1E to it.
  $AAF2,$01 Invert it, to make minus the width less #N$1F.
  $AAF3,$03 Store it in the operand of the instruction at #N$AB06.
  $AAF6,$01 Move onto the height.
  $AAF7,$01 Fetch it.
  $AAF8,$01 Keep the height in #REGc.
  $AAF9,$01 Move onto the attribute.
  $AAFA,$01 Fetch it.
  $AAFB,$03 Store it in the operand of the instruction at #N$AB00.
@ $AAFE label=FillRectangle_Row
  $AAFE,$02 Set the width of the row (this is patched at #N$AAFF).
@ $AB00 label=FillRectangle_Cell
  $AB00,$02 Set the attribute of a cell (this is patched at #N$AB01).
  $AB02,$01 Move onto the next cell.
  $AB03,$02 Jump back until the row has been filled.
  $AB05,$01 Move back to the last cell of the row.
  $AB06,$03 Set the offset to the start of the row above (this is patched at
. #N$AB07).
  $AB09,$01 Add it to the address.
  $AB0A,$01 Decrease the height by one.
  $AB0B,$02 Jump back until all of the rows have been filled.
  $AB0D,$01 Restore the position.
  $AB0E,$01 Return.

c $AB0F Control Player
@ $AB0F label=ControlPlayer
D $AB0F Reads the controls and makes the player entity turn, jump and move
. forward. The controls are a byte with one bit for each direction, as read by
. #R$AB8F: bit 0 and bit 1 turn the player, bit 2 makes the player jump if it is
. on the ground, and bit 3 makes the player move forward. While the player is
. held (fields #N$24 and #N$25 are not both zero) bits 2-4 are ignored. The rate
. of turning builds up while a turn control is held, and is kept in #R$5CF6.
R $AB0F IX The player entity
  $AB0F,$03 Read the controls.
  $AB12,$03 Read field #N$24 of the entity.
  $AB15,$03 Combine it with field #N$25.
  $AB18,$02 Jump to #R$AB20 if both are zero.
  $AB1A,$02 Ignore bit 2 of the controls.
  $AB1C,$02 Ignore bit 3 of the controls.
  $AB1E,$02 Ignore bit 4 of the controls.
@ $AB20 label=ControlPlayer_Store
  $AB20,$01 Fetch the controls.
  $AB21,$03 Store them in #R$5CDE.
  $AB24,$03 Fetch the rate of turning from #R$5CF6.
  $AB27,$03 Set the amount by which the rate builds up.
  $AB2A,$02 Move bit 0 into the carry flag.
  $AB2C,$02 Jump to #R$AB36 if it is reset.
  $AB2E,$02 Move bit 1 into the carry flag.
  $AB30,$02 Jump to #R$AB59 if both are set.
  $AB32,$02 Set the direction of the turn to #N$FF.
  $AB34,$02 Jump to #R$AB3C.
@ $AB36 label=ControlPlayer_TestLeft
  $AB36,$02 Move bit 1 into the carry flag.
  $AB38,$02 Jump to #R$AB59 if neither bit is set.
  $AB3A,$02 Set the direction of the turn to #N$00.
@ $AB3C label=ControlPlayer_Turn
  $AB3C,$01 Increase the rate of turning.
  $AB3D,$01 Fetch the whole part of the rate.
  $AB3E,$04 Jump to #R$AB43 if it is less.
  $AB42,$01 Limit the rate to below #N$03.
@ $AB43 label=ControlPlayer_StoreRate
  $AB43,$03 Store the rate of turning.
  $AB46,$01 Fetch the whole part of the rate.
  $AB47,$04 Jump to #R$AB4D if the turn is in the positive direction.
  $AB4B,$02 Make the turn negative.
@ $AB4D label=ControlPlayer_Heading
  $AB4D,$01 Keep the turn in #REGb.
  $AB4E,$03 Fetch the heading of the player.
  $AB51,$01 Add the turn.
  $AB52,$02,b$01 Use bits 0-5.
  $AB54,$03 Store the new heading.
  $AB57,$02 Jump to #R$AB6A.
@ $AB59 label=ControlPlayer_NoTurn
  $AB59,$04 Reset bit 7 of the heading of the player, so that it is not moving
. forward.
  $AB5D,$02 Set the amount by which the rate of turning falls.
  $AB5F,$01 Clear the carry flag.
  $AB60,$02 Reduce the rate of turning.
  $AB62,$02 Jump to #R$AB67 if it is still positive.
  $AB64,$03 Set the rate of turning to zero.
@ $AB67 label=ControlPlayer_StoreRate2
  $AB67,$03 Store the rate of turning.
@ $AB6A label=ControlPlayer_Jump
  $AB6A,$02 Move bit 2 into the carry flag.
  $AB6C,$02 Jump to #R$AB87 if it is reset.
  $AB6E,$06 Jump to #R$AB87 if bit 7 of field #N$1E of the player is reset.
  $AB74,$03 Fetch the jump flag from #R$5D00.
  $AB77,$01 Test it.
  $AB78,$02 Jump to #R$AB87 if the player is already jumping.
  $AB7A,$04 Set the vertical speed of the player (field #N$12) to #N$04...
  $AB7E,$04 ...and field #N$13 to #N$00.
  $AB82,$02 Set the jump flag to #N$01...
  $AB84,$03 ...and store it.
@ $AB87 label=ControlPlayer_Forward
  $AB87,$02 Move bit 3 into the carry flag.
  $AB89,$01 Return if it is reset.
  $AB8A,$04 Set bit 7 of the heading of the player, so that it moves forward.
  $AB8E,$01 Return.

c $AB8F Read Controls
@ $AB8F label=ReadControls
D $AB8F Reads the controls of the current player, using the control method which
. is selected in #R$60FB (#N$00 for the keyboard, #N$01 for a Kempston joystick,
. #N$02 for a Cursor joystick, otherwise an Interface II joystick). The result
. has one bit for each control: bit 0 is right, bit 1 is left, bit 2 is down,
. bit 3 is up and bit 4 is fire.
R $AB8F O:C The controls which are being used
  $AB8F,$03 Fetch the control method of the current player.
  $AB92,$01 Test it.
  $AB93,$03 Jump to #R$ABE2 if it is the keyboard.
  $AB96,$01 Decrease it by one.
  $AB97,$02 Jump to #R$ABB6 if it is a Kempston joystick.
  $AB99,$01 Decrease it by one.
  $AB9A,$02 Jump to #R$ABBC if it is a Cursor joystick.
  $AB9C,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $ABA0,$02 Start with all of the bits set.
  $ABA2,$01 Move the bit for "0" into the carry flag.
  $ABA3,$02 Move it into #REGb.
  $ABA5,$01 Move the bit for "9" into the carry flag.
  $ABA6,$02 Move it into #REGb.
  $ABA8,$01 Move the bit for "8" into the carry flag.
  $ABA9,$02 Move it into #REGb.
  $ABAB,$01 Move the bit for "7" into the carry flag...
  $ABAC,$01 ...and then the bit for "6".
  $ABAD,$02 Move it into #REGb.
  $ABAF,$01 Rotate the bit for "7" back into the carry flag...
  $ABB0,$02 ...and move it into #REGb.
  $ABB2,$01 Fetch the result.
  $ABB3,$01 Invert the bits, so that a set bit is a control being used.
  $ABB4,$01 Store it in #REGc.
  $ABB5,$01 Return.
@ $ABB6 label=ReadControls_Kempston
  $ABB6,$02 Read the Kempston joystick.
  $ABB8,$02,b$01 Keep the five bits.
  $ABBA,$01 Store them in #REGc.
  $ABBB,$01 Return.
@ $ABBC label=ReadControls_Cursor
  $ABBC,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $ABC0,$02,b$01 Set the unused bits.
  $ABC2,$01 Keep the bits in #REGb.
  $ABC3,$02,b$01 Keep the bit for "7", up.
  $ABC5,$01 Store it in #REGc.
  $ABC6,$01 Fetch the bits.
  $ABC7,$01 Rotate bit 2, for "8" (right), into bit 0...
  $ABC8,$01 ...and bit 4, for "6" (down), into bit 2.
  $ABC9,$01 Keep the bits in #REGb.
  $ABCA,$02,b$01 Keep the bits for right and down.
  $ABCC,$01 Add the bit for up.
  $ABCD,$01 Store them in #REGc.
  $ABCE,$01 Fetch the bits.
  $ABCF,$01 Rotate the bit for "0" (fire)...
  $ABD0,$01 ...into bit 4.
  $ABD1,$02,b$01 Keep the bit for fire.
  $ABD3,$01 Add the other bits.
  $ABD4,$01 Store them in #REGc.
  $ABD5,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $ABD9,$01 Rotate the bit for "5" (left)...
  $ABDA,$01 ...into...
  $ABDB,$01 ...bit 1.
  $ABDC,$02,b$01 Keep the bit for left.
  $ABDE,$01 Add the other bits.
  $ABDF,$01 Invert the bits, so that a set bit is a control being used.
  $ABE0,$01 Store them in #REGc.
  $ABE1,$01 Return.
@ $ABE2 label=ReadControls_Keyboard
  $ABE2,$02 Clear the controls.
  $ABE4,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | CAPS SHIFT | Z | X | C | V }
. TABLE#
  $ABE9,$02,b$01 Keep the bits for "X" and "V".
  $ABEB,$02 Jump to #R$ABF6 if either of them is being pressed.
  $ABED,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | SYMBOL SHIFT | M | N | B }
. TABLE#
  $ABF2,$02,b$01 Keep the bits for "SYMBOL SHIFT" and "N".
  $ABF4,$02 Jump to #R$ABF8 if neither of them is being pressed.
@ $ABF6 label=ReadControls_Right
  $ABF6,$02 Set bit 0, right.
@ $ABF8 label=ReadControls_TestLeft
  $ABF8,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | CAPS SHIFT | Z | X | C | V }
. TABLE#
  $ABFD,$02,b$01 Keep the bits for "Z" and "C".
  $ABFF,$02 Jump to #R$AC0A if either of them is being pressed.
  $AC01,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | SYMBOL SHIFT | M | N | B }
. TABLE#
  $AC06,$02,b$01 Keep the bits for "M" and "B".
  $AC08,$02 Jump to #R$AC0C if neither of them is being pressed.
@ $AC0A label=ReadControls_Left
  $AC0A,$02 Set bit 1, left.
@ $AC0C label=ReadControls_TestUp
  $AC0C,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FD | A | S | D | F | G }
. TABLE#
  $AC11,$02 Jump to #R$AC1A if any of the keys is being pressed.
  $AC13,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$BF | ENTER | L | K | J | H }
. TABLE#
  $AC18,$02 Jump to #R$AC1C if none of the keys is being pressed.
@ $AC1A label=ReadControls_Up
  $AC1A,$02 Set bit 3, up.
@ $AC1C label=ReadControls_TestDown
  $AC1C,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FB | Q | W | E | R | T }
. TABLE#
  $AC21,$01 Keep the bits in #REGe.
  $AC22,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DF | P | O | I | U | Y }
. TABLE#
  $AC27,$01 Keep the bits in #REGd.
  $AC28,$01 Fetch the bits for "Q", "W", "E", "R" and "T".
  $AC29,$02,b$01 Keep the bits for "Q", "E" and "T".
  $AC2B,$01 Store them in #REGl.
  $AC2C,$01 Fetch the bits for "P", "O", "I", "U" and "Y".
  $AC2D,$02,b$01 Keep the bits for "O" and "U".
  $AC2F,$01 Combine them with the bits for "Q", "E" and "T".
  $AC30,$02 Jump to #R$AC34 if none of them is being pressed.
  $AC32,$02 Set bit 2, down.
@ $AC34 label=ReadControls_TestFire
  $AC34,$01 Fetch the bits for "Q", "W", "E", "R" and "T".
  $AC35,$02,b$01 Keep the bits for "W" and "R".
  $AC37,$01 Store them in #REGl.
  $AC38,$01 Fetch the bits for "P", "O", "I", "U" and "Y".
  $AC39,$02,b$01 Keep the bits for "P", "I" and "Y".
  $AC3B,$01 Combine them with the bits for "W" and "R".
  $AC3C,$01 Return if none of them is being pressed.
  $AC3D,$02 Set bit 4, fire.
  $AC3F,$01 Return.

c $AC40 Build Draw List
@ $AC40 label=BuildDrawList
D $AC40 Builds the list of items to be drawn for the current frame, at #R$AFFB.
. Each item is three bytes: a flag byte followed by the address of the record to
. draw. The flag is #N$01 for an entity (see #R$B540), #N$02 for one of the
. #N$0C extra records at #R$B708 and #N$03 for one of the #N$14-byte records at
. #R$BBF7. The list ends with a zero byte, and #R$B06C holds the address of
. the next free item.
.
. Every entity that is in use and not hidden is prepared with #R$AD07. The
. matching extra record is then prepared as well, if it has been flagged as
. visible.
N $AC40 Start with an empty list and with no table records, and go through the
. #N$0C entities and their extra records.
  $AC40,$06 Make the next free item of the draw list the start of the list.
  $AC46,$04 Clear the count of table records that have been prepared.
  $AC4A,$04 Point #REGix at #R$B540.
  $AC4E,$04 Point #REGiy at #R$B708.
  $AC52,$03 Point #REGhl at the start of the table of records.
  $AC55,$02 Set a counter in #REGb for the #N$0C entities.
@ $AC57 label=BuildDrawList_Loop
  $AC57,$01 Stash the counter on the stack.
  $AC58,$03 Fetch the type of the entity.
  $AC5B,$01 Test it.
  $AC5C,$02 Jump to #R$ACB9 if the entity is not in use.
N $AC5E Add the entity to the draw list, unless it is hidden.
  $AC5E,$04 Test bit 7 of field #N$01 of the entity, which is set if it is
. hidden.
  $AC62,$03 Add the entity to the draw list if it is not hidden.
  $AC65,$06 Jump to #R$ACB9 if the extra record is not in use.
N $AC6B Build the temporary entity from the extra record, so that the extra
. record can be drawn in the same way as an entity.
  $AC6B,$02 Stash the entity and the table pointer on the stack.
  $AC6D,$01 Stash the table pointer on the stack.
  $AC6E,$09 Copy the screen position of the extra record into the temporary
. entity.
  $AC77,$09 Copy the x coordinate of the extra record into the temporary entity.
  $AC80,$09 Copy the y coordinate of the extra record into the temporary entity.
  $AC89,$09 Copy the z coordinate of the extra record into the temporary entity.
  $AC92,$08 Copy the width of the extra record into the temporary entity.
  $AC9A,$08 Copy the height of the extra record into the temporary entity.
  $ACA2,$04 Point #REGix at #R$B7A4.
  $ACA6,$04 Make it an entity of type #N$02.
  $ACAA,$03 Find its address in the screen buffer.
  $ACAD,$06 Store the address in the extra record.
  $ACB3,$01 Restore the table pointer.
  $ACB4,$03 Add the temporary entity to the draw list.
  $ACB7,$02 Restore the entity.
@ $ACB9 label=BuildDrawList_Next
N $ACB9 Move on to the next entity and the next extra record.
  $ACB9,$05 Move #REGix on to the next entity.
  $ACBE,$04 Move #REGiy on to the next extra record.
  $ACC2,$01 Restore the counter.
  $ACC3,$02 Decrease the counter and loop back to #R$AC57 until all #N$0C
. entities have been done.
@ $ACC5 label=BuildDrawList_Records
N $ACC5 Add the records of the objects of the level that are in view to the draw
. list.
  $ACC5,$03 Fetch the next free item of the draw list.
  $ACC8,$03 Fetch the number of records.
  $ACCB,$01 Test it.
  $ACCC,$02 Jump to #R$ACEE if there are none.
  $ACCE,$04 Point #REGiy at #R$BBF7.
  $ACD2,$03 Set the length of a record, #N$0014.
@ $ACD5 label=BuildDrawList_RecordLoop
  $ACD5,$06 Jump to #R$ACE9 if the record is not to be drawn.
  $ACDB,$04 Reset the bit so that the record is only drawn once.
  $ACDF,$02 Mark the item as a record.
  $ACE1,$03 Copy the address of the record into #REGde.
  $ACE4,$04 Store the address of the record in the item.
  $ACE8,$01 Move on to the next item.
@ $ACE9 label=BuildDrawList_RecordNext
  $ACE9,$02 Move #REGiy on to the next record.
  $ACEB,$01 Decrease the number of records by one.
  $ACEC,$02 Loop back to #R$ACD5 until all of the records have been done.
@ $ACEE label=BuildDrawList_End
  $ACEE,$02 Mark the end of the draw list.
  $ACF0,$03 Store the new end of the list.
  $ACF3,$01 Return.

c $ACF4 Append Entity Item
@ $ACF4 label=AppendEntityItem
D $ACF4 Adds an entity to the draw list without preparing a table record for it.
. Used for entity types #N$0C and #N$10.
R $ACF4 IX The entity
  $ACF4,$01 Keep the other registers aside.
  $ACF5,$03 The next free entry of the draw list.
  $ACF8,$03 Mark the entry as an entity and move on.
  $ACFB,$07 Write this entity's address into the entry.
  $AD02,$03 The list continues after this entry.
  $AD05,$01 Bring the other registers back.
  $AD06,$01 Return.

c $AD07 Prepare Entity Item
@ $AD07 label=PrepareEntityItem
D $AD07 Converts the position of the entity with #R$B8E2 and adds it to the
. draw list. Entity types #N$0C and #N$10 are only appended with #R$ACF4. Any
. other type is also given a record in the table of item records, which holds a
. copy of the rows of the screen buffer (which are #N$18 bytes wide) that lie
. under the entity, so that #R$AD9E can put them back after the entity has been
. drawn.
R $AD07 IX The entity
R $AD07 HL Pointer to the next free byte in the table of item records
R $AD07 O:HL Updated pointer
  $AD07,$01 Save the item record pointer.
  $AD08,$03 Convert the position of the entity.
  $AD0B,$01 Restore the item record pointer.
  $AD0C,$03 Fetch the type of the entity.
  $AD0F,$04 Jump to #R$ACF4 if it is type #N$0C.
  $AD13,$04 Jump to #R$ACF4 if it is type #N$10.
@ $AD17 label=PrepareEntityItem_Table
N $AD17 Entry point used for the extra records, which are passed in #REGiy.
N $AD17 Count the item.
  $AD17,$03 Fetch the number of prepared items.
  $AD1A,$01 Add one.
  $AD1B,$03 Store it again.
  $AD1E,$01 Save the item record pointer.
  $AD1F,$03 Check the #N$14-byte records for any that overlap the entity.
N $AD22 Check the #N$14-byte records for any that overlap the entity.
  $AD22,$03 Fetch the next free item address.
N $AD25 Fetch the type.
  $AD25,$03 Fetch the type of the entity.
  $AD28,$04 Jump to #R$AD36 if it is not type #N$02.
  $AD2C,$01 Use the type as the flag for the item.
  $AD2D,$02 #REGiy moves into #REGde.
  $AD2F,$01 (via the stack).
  $AD30,$01 Move to the address bytes.
  $AD31,$01 Store the low byte of the record address.
  $AD32,$01 Move on.
  $AD33,$01 Store the high byte of the record address.
  $AD34,$02 Jump to #R$AD3F.
@ $AD36 label=PrepareEntityItem_Entity
N $AD36 Add an entity item (flag #N$01) to the draw list.
  $AD36,$02 Set the flag of the item to #N$01.
  $AD38,$01 Move to the address bytes.
  $AD39,$02 #REGix moves into #REGde.
  $AD3B,$01 (via the stack).
  $AD3C,$01 Store the low byte of the entity address.
  $AD3D,$01 Move on.
  $AD3E,$01 Store the high byte of the entity address.
@ $AD3F label=PrepareEntityItem_Header
  $AD3F,$01 Move to the next free item.
  $AD40,$03 Store it.
  $AD43,$01 Restore the item record pointer.
N $AD44 Fetch the address in the screen buffer.
  $AD44,$03 Fetch the low byte of the address in the screen buffer.
  $AD47,$03 Fetch the high byte of the address in the screen buffer.
N $AD4A Work out how many bytes wide the record is, from field #N$16 and field
. #N$0E.
  $AD4A,$03 Read field #N$16.
  $AD4D,$02,b$01 Keep the low nibble.
  $AD4F,$01 Copy it into #REGc.
  $AD50,$03 Read field #N$0E.
  $AD53,$02,b$01 Use bits 0-2.
  $AD55,$02 Jump to #R$AD58 if they are all zero.
  $AD57,$01 Otherwise add one to the width.
@ $AD58 label=PrepareEntityItem_Width
N $AD58 Patch the operand of the #REGbc load at #R$AD07(#N$AD96) and write the
. record header: the first byte is the width plus #N$18, then the address in the
. screen buffer.
  $AD58,$02 Start from #N$E8.
  $AD5A,$01 Subtract the width.
  $AD5B,$03 Patch the operand of the #REGbc load at #N$AD94 with it.
  $AD5E,$02 Negate it to give the width plus #N$18.
  $AD60,$01 Write it as the first byte of the record.
  $AD61,$01 Move on.
  $AD62,$01 Write the low byte of the address in the screen buffer.
  $AD63,$01 Move on.
  $AD64,$01 Write the high byte of the address in the screen buffer.
  $AD65,$01 Move on.
N $AD66 Patch the jump back into the unrolled copy so that only #REGc bytes of
. each row are copied.
  $AD66,$02 Double the width.
  $AD68,$02 Start from #N$F8.
  $AD6A,$01 Subtract twice the width.
  $AD6B,$03 Patch the displacement of the DJNZ at #R$AD9A with it (the
. displacement is the byte at #N$AD9B).
  $AD6E,$02 Subtract #N$02.
  $AD70,$01 Write it as the fourth byte of the record.
  $AD71,$01 Move on.
N $AD72 Work out the number of rows from fields #N$17 and #N$0F and write it to
. the header.
  $AD72,$03 Read field #N$17.
  $AD75,$02,b$01 Use bits 0-5.
  $AD77,$01 Add one.
  $AD78,$01 Copy it into #REGb.
  $AD79,$03 Read field #N$0F.
  $AD7C,$01 Compare it with the value in #REGb.
  $AD7D,$02 Jump to #R$AD07(#N$AD82) if it is not less.
  $AD7F,$02 Otherwise use field #N$0F plus #N$02.
  $AD81,$01 Copy it into #REGb.
@ $AD82 label=PrepareEntityItem_Skip
  $AD82,$01 Write the number of rows as the fifth byte of the record.
  $AD83,$01 Move on.
N $AD84 Swap, ready to copy the rows from the data into the table.
  $AD84,$01 Swap the screen buffer address into #REGhl and the table pointer
. into #REGde.
  $AD85,$03 Jump into the copy loop.
@ $AD88 label=PrepareEntityItem_Copy
  $AD88,$02 Copy a byte and move on.
  $AD8A,$02 Copy a byte and move on.
  $AD8C,$02 Copy a byte and move on.
  $AD8E,$02 Copy a byte and move on.
  $AD90,$02 Copy a byte and move on.
  $AD92,$02 Copy a byte and move on.
  $AD94,$01 Save the row counter.
  $AD95,$03 Set up the step back to the start of the next row (the low byte is
. patched at #N$AD96).
  $AD98,$01 Move #REGhl back to the start of the next row of the screen buffer.
  $AD99,$01 Restore the row counter.
@ $AD9A label=PrepareEntityItem_Loop
  $AD9A,$02 Decrease the row counter and jump back into the copy chain (the
. displacement is patched at #R$AD07(#N$AD9B)) until all rows are copied.
  $AD9C,$01 Swap the pointer to the next free byte back into #REGhl.
  $AD9D,$01 Return.

c $AD9E Restore Item Rows
@ $AD9E label=RestoreItemRows
D $AD9E Replays the table of item records built by #R$AC40 and #R$AD07. For
. each record, the rows of the screen buffer saved in the record are copied back
. to the address in the record header, working upwards one row at a time.
  $AD9E,$03 Read how many item records there are.
  $ADA1,$02 Return when there are none.
N $ADA3 The alternate accumulator counts the records. The first byte of a
. header is the step back to the previous row.
  $ADA3,$03 Start at the first record.
@ $ADA6 label=RestoreItemRows_Loop
  $ADA6,$01 Remember how many records remain.
  $ADA7,$04 Patch the step back to the previous row.
  $ADAB,$01 Move on to the screen address.
  $ADAC,$04 Read the screen address from the header.
  $ADB0,$04 Patch the row loop with the width.
  $ADB4,$01 Move on to the row count.
  $ADB5,$02 Read how many rows.
  $ADB7,$02 Keep the byte count from carrying into the row count.
  $ADB9,$03 Join the row loop.
@ $ADBC label=RestoreItemRows_Next
  $ADBC,$05 Repeat for the remaining records.
  $ADC1,$01 Return.
@ $ADC2 label=RestoreItemRows_Words
N $ADC2 Copy three words from the stack. The patched jump cannot reach this for
. a width of up to six bytes, so it is not used.
  $ADC2,$0E Copy three words from the stack.
@ $ADD0 label=RestoreItemRows_Copy
N $ADD0 Copy one byte of the row for each of these that the patched jump
. reaches. A wider row starts further up the list.
  $ADD0,$02 Copy a byte and move on.
  $ADD2,$02 Copy a byte and move on.
  $ADD4,$02 Copy a byte and move on.
  $ADD6,$02 Copy a byte and move on.
  $ADD8,$02 Copy a byte and move on.
  $ADDA,$02 Copy a byte and move on.
@ $ADDC label=RestoreItemRows_Step
N $ADDC Move back one row. The distance subtracted below is patched from the
. record header.
  $ADDC,$04 Step back to the previous row.
  $ADE0,$03 Stay on this page if the step did not borrow.
  $ADE3,$01 Move to the previous page.
@ $ADE4 label=RestoreItemRows_Rows
  $ADE4,$02 Repeat for the remaining rows. The displacement is patched.
  $ADE6,$03 Go on to the next record.

w $ADE9 Row Routine Table
@ $ADE9 label=RowRoutineTable
D $ADE9 The addresses of the routines that draw the rows of a sprite, used by
. #R$B43C. The first four draw sprites that are byte aligned and are for widths
. of one to four bytes, and the last four are for shifted sprites.
W $ADE9,$10,$02

c $ADF9 Project Player Entity
@ $ADF9 label=ProjectPlayerEntity
D $ADF9 Projects the player entity with #R$AE0D, then works out how far the
. entity has moved on the screen since the last frame. The previous value is
. kept in #R$5CEC and the change in #R$5CEC(#N$5CED).
R $ADF9 IX The player entity
  $ADF9,$03 Call #R$AE0D.
  $ADFC,$03 Read the byte at #R$5CEC.
  $ADFF,$01 #REGa moves into #REGb.
  $AE00,$03 Fetch the row.
  $AE03,$01 #REGa moves into #REGc.
  $AE04,$01 Subtract #REGb.
  $AE05,$03 Write #REGa at #R$5CEC(#N$5CED).
  $AE08,$01 #REGc moves into #REGa.
  $AE09,$03 Write #REGa at #R$5CEC.
  $AE0C,$01 Return.

c $AE0D Project Entity
@ $AE0D label=ProjectEntity
D $AE0D Works out the screen position of an entity from its coordinates,
. relative to the view origin held in #R$5CE7 and #R$5CEE. The results are
. stored in fields #N$0E and #N$0F of the entity. If any part of the entity is
. out of view then it is hidden by setting bit 7 of field #N$01, and when it is
. visible the hidden bit is only set if the entity is waiting to appear (see the
. wanted heading in fields #N$24 and #N$25). Purpose of the individual tests is
. not yet known.
R $AE0D IX The entity
N $AE0D Find the screen column of the entity. This is the sum of its x and y
. coordinates, less the horizontal origin of the view.
  $AE0D,$06 Fetch the x coordinate of the entity into #REGhl.
  $AE13,$06 Fetch the y coordinate of the entity into #REGde.
  $AE19,$01 Add them together.
  $AE1A,$04 Fetch the horizontal origin of the view.
  $AE1E,$01 Clear #REGa.
  $AE1F,$02 Subtract the origin from the sum.
  $AE21,$01 Combine #REGa with #REGh.
  $AE22,$03 Jump to #R$AEAB if the column is more than one byte, so that the
. entity is hidden.
  $AE25,$01 Copy the column into #REGa.
  $AE26,$05 Jump to #R$AEAB if the entity starts beyond the right edge of the
. view.
  $AE2B,$03 Set the column.
N $AE2E Check that the right edge of the entity is not off the left or right
. edge of the view.
  $AE2E,$03 Read field #N$16 of the entity.
  $AE31,$02,b$01 Keep the width of the sprite in bytes, which is held in bits
. 0-3.
  $AE33,$03 Multiply the width by eight to find it in pixels.
  $AE36,$01 Add the column to find the right edge of the entity.
  $AE37,$05 Jump to #R$AEAB if the right edge is beyond the right of the view.
  $AE3C,$05 Jump to #R$AEAB if the right edge is before the left of the view.
N $AE41 Find the screen row of the entity. This is half of the difference
. between its x and y coordinates, less its height (z coordinate), plus an
. offset for its size, less the vertical origin of the view.
  $AE41,$06 Fetch the x coordinate of the entity into #REGhl.
  $AE47,$04 Halve the x coordinate.
  $AE4B,$06 Fetch the y coordinate of the entity into #REGde.
  $AE51,$04 Halve the y coordinate.
  $AE55,$01 Clear #REGa.
  $AE56,$02 Subtract half of the y coordinate from half of the x coordinate.
  $AE58,$04 Fetch the high byte of the z coordinate, less one, into #REGd.
  $AE5C,$03 Fetch the low byte of the z coordinate into #REGe.
  $AE5F,$03 Subtract the z coordinate, so that a higher entity is drawn higher
. up.
  $AE62,$03 Fetch the offset #N$0040.
  $AE65,$01 Add the offset.
  $AE66,$03 Fetch the x extent, which is its size.
  $AE69,$02 Halve it.
  $AE6B,$01 Add it, so that the row is that of the bottom of the entity.
  $AE6C,$01 Clear #REGa.
  $AE6D,$04 Fetch the vertical origin of the view.
  $AE71,$02 Subtract the origin.
  $AE73,$01 Combine #REGa with #REGh.
  $AE74,$02 Jump to #R$AEAB if the row is more than one byte, so that the entity
. is hidden.
  $AE76,$03 Set the row.
N $AE79 Decide whether the entity is shown yet. An entity that is turning
. towards its wanted heading is hidden until it has faced the right way.
  $AE79,$03 Read field #N$24 of the entity.
  $AE7C,$02,b$01 Use bits 6-7.
  $AE7E,$02 Jump to #R$AE84 if both are reset.
  $AE80,$04 Jump to #R$AE9B if they are not set to that value, to show the
. entity.
@ $AE84 label=ProjectEntity_Delay
  $AE84,$03 Read field #N$25 of the entity.
  $AE87,$01 Test it.
  $AE88,$02 Jump to #R$AE9B if it is zero, to show the entity.
  $AE8A,$02,b$01 Use bits 0-2.
  $AE8C,$02 Jump to #R$AE95 if any of them is set, to hide the entity.
  $AE8E,$03 Read field #N$25 of the entity.
  $AE91,$04 Jump to #R$AE9B if it is #N$38 or more, to show the entity.
@ $AE95 label=ProjectEntity_Hide
  $AE95,$04 Set bit 7 of field #N$01 of the entity, to hide it.
  $AE99,$02 Jump to #R$AE9F.
@ $AE9B label=ProjectEntity_Show
  $AE9B,$04 Reset bit 7 of field #N$01 of the entity, to show it.
N $AE9F Hide the entity if the top of it is off the bottom of the view.
@ $AE9F label=ProjectEntity_Size
  $AE9F,$03 Read field #N$17 of the entity.
  $AEA2,$02,b$01 Keep the height of the sprite in bits 0-5.
  $AEA4,$01 Copy it into #REGb.
  $AEA5,$01 Copy the row into #REGa.
  $AEA6,$01 Subtract the height of the sprite to find the top row.
  $AEA7,$01 Return if the top row is above the view, as the entity is partly in
. view.
  $AEA8,$02 Move onto the row below and shift it into the carry flag.
  $AEAA,$01 Return if the entity is within the first half of the view.
@ $AEAB label=ProjectEntity_Hidden
  $AEAB,$04 Set bit 7 of field #N$01 of the entity, to hide it.
  $AEAF,$01 Return.

c $AEB0 Test Entity Visible
@ $AEB0 label=TestEntityVisible
D $AEB0 Tests whether the entity is within the view in both directions, allowing
. for a margin of #REGbc.
R $AEB0 IX The entity
R $AEB0 BC The margin
R $AEB0 O:A Zero if the entity is out of view, otherwise non-zero
N $AEB0 Test the column, which is the x coordinate plus the y coordinate, less
. the horizontal origin of the view. The entity is out of view if the column
. is further left than the margin, or further right than #N$C0 plus the margin.
  $AEB0,$06 Fetch the x coordinate.
  $AEB6,$06 Fetch the y coordinate.
  $AEBC,$01 Add them to get the column before the origin.
  $AEBD,$04 Fetch the horizontal origin of the view.
  $AEC1,$02 Subtract the origin.
  $AEC3,$04 Jump to #R$AECE if the column is not left of the origin.
  $AEC7,$01 Add the margin.
  $AEC8,$02 Test whether the column is still negative.
  $AECA,$02 Go on to the row if the margin brings the column back.
  $AECC,$02 Report that the entity is out of view.
@ $AECE label=TestEntityVisible_Second
  $AECE,$03 Set the right edge of the test to #N$C0.
  $AED1,$02 Subtract it from the column.
  $AED3,$02 Subtract the margin as well.
  $AED5,$02 Test whether the column is now negative.
  $AED7,$02 Go on to the row if the column is inside the right edge.
  $AED9,$02 Report that the entity is out of view.
@ $AEDB label=TestEntityVisible_Vertical
N $AEDB Test the row, using the same sum as #R$AE0D: half of the x coordinate
. less half of the y coordinate, less the z coordinate, plus #N$40, less the
. vertical origin of the view.
  $AEDB,$06 Fetch the x coordinate.
  $AEE1,$04 Halve the x coordinate.
  $AEE5,$06 Fetch the y coordinate.
  $AEEB,$04 Halve the y coordinate.
  $AEEF,$03 Subtract half of the y coordinate from half of the x coordinate.
  $AEF2,$04 Fetch the high byte of the z coordinate, less one.
  $AEF6,$03 Fetch the low byte of the z coordinate.
  $AEF9,$03 Subtract the z coordinate.
  $AEFC,$03 Set the offset to #N$0040.
  $AEFF,$01 Add the offset.
  $AF00,$04 Fetch the vertical origin of the view.
  $AF04,$02 Subtract the origin.
  $AF06,$04 Jump to #R$AF11 if the row is not above the origin.
  $AF0A,$01 Add the margin.
  $AF0B,$02 Test whether the row is still negative.
  $AF0D,$02 Accept the entity if the margin brings the row back.
  $AF0F,$02 Report that the entity is out of view.
@ $AF11 label=TestEntityVisible_Far
  $AF11,$03 Set the bottom of the test to #N$80.
  $AF14,$02 Subtract it from the row.
  $AF16,$02 Subtract the margin as well.
  $AF18,$02 Test whether the row is now negative.
  $AF1A,$02 Accept the entity if the row is inside the bottom edge.
  $AF1C,$02 Report that the entity is out of view.
@ $AF1E label=TestEntityVisible_Yes
  $AF1E,$02,b$01 Set a non-zero result.
  $AF20,$01 Return.

c $AF21 Set Entity Size
@ $AF21 label=SetEntitySize
D $AF21 Fetches the sprite for the entity with #R$6653 and copies the width and
. the height of the sprite to fields #N$16 and #N$17. If either is too big, the
. game crashes with #R$AF43.
R $AF21 IX The entity
  $AF21,$03 Find the sprite of the entity.
  $AF24,$01 Point #REGhl at the sprite.
  $AF25,$01 Fetch the width of the sprite.
  $AF26,$04 Jump to #R$AF43 to crash if the width is #N$05 bytes or more.
  $AF2A,$03 Fetch the width byte of the entity.
  $AF2D,$02,b$01 Keep the flags in bits 4-7.
  $AF2F,$01 Combine them with the width of the sprite.
  $AF30,$03 Store the width of the entity.
  $AF33,$01 Move on to the height of the sprite.
  $AF34,$01 Fetch the height of the sprite.
  $AF35,$04 Jump to #R$AF43 to crash if the height is #N$28 or more.
  $AF39,$03 Fetch the height byte of the entity.
  $AF3C,$02,b$01 Keep the flags in bits 6-7.
  $AF3E,$01 Combine them with the height of the sprite.
  $AF3F,$03 Store the height of the entity.
  $AF42,$01 Return.

c $AF43 Flash Border
@ $AF43 label=FlashBorder
D $AF43 Cycles the border colour for ever. Entered when the sprite data of an
. entity is out of range.
  $AF43,$02 Write #REGa to the port.
  $AF45,$01 Advance #REGa.
  $AF46,$02 Jump to #R$AF43.

c $AF48 Animate Entity
@ $AF48 label=AnimateEntity
D $AF48 Moves the entity on to the next frame of its animation every other
. frame. The counter in field #N$1C controls the speed, and field #N$1D holds
. the first and last frame numbers.
R $AF48 IX The entity
  $AF48,$03 Fetch the frame counter.
  $AF4B,$01 Move its low bit into the carry flag.
  $AF4C,$01 Return on every other frame.
  $AF4D,$04 Fetch the animation counter and keep it in #REGb.
  $AF51,$02 Count it down by #N$40.
  $AF53,$02 Jump to #R$AF83 if it had not yet reached the next frame.
  $AF55,$03 Fetch the frame of the entity.
  $AF58,$02,b$01 Keep the frame number.
  $AF5A,$01 Move on to the next frame.
  $AF5B,$01 Keep the next frame in #REGe.
  $AF5C,$04 Fetch the first and last frame numbers and keep them in #REGd.
  $AF60,$04 Move the last frame number down to bits 0-3.
  $AF64,$02,b$01 Keep the last frame number.
  $AF66,$01 Compare it with the next frame.
  $AF67,$02 Jump to #R$AF6D if the next frame is still within the animation.
  $AF69,$01 Fetch the first and last frame numbers again.
  $AF6A,$02,b$01 Keep the first frame number.
  $AF6C,$01 Use the first frame, so that the animation repeats.
@ $AF6D label=AnimateEntity_Frame
  $AF6D,$03 Fetch the frame of the entity.
  $AF70,$02,b$01 Keep the flags in bits 4-7.
  $AF72,$01 Combine them with the new frame number.
  $AF73,$03 Store the new frame.
  $AF76,$03 Move bits 4-5 of the animation counter up to bits 6-7.
  $AF79,$02,b$01 Keep those bits.
  $AF7B,$03 Combine them with the animation counter.
  $AF7E,$01 Save it.
  $AF7F,$03 Set the sprite size for the new frame.
  $AF82,$01 Restore the animation counter.
@ $AF83 label=AnimateEntity_Store
  $AF83,$03 Store the animation counter.
  $AF86,$01 Return.

b $AF87 Draw List Buffers
@ $AF87 label=DrawListBuffers
D $AF87 Guard bytes before the sorted draw list.
B $AF87,$08,$08

g $AF8F Sorted Draw List
@ $AF8F label=SortedDrawList
D $AF8F The draw list after it has been sorted into drawing order by #R$9F99.
. It has the same format as the list at #R$AFFB.
B $AF8F,$64,$08

b $AFF3 Draw List Guard
@ $AFF3 label=DrawListGuard
B $AFF3,$08,$08

g $AFFB Draw List
@ $AFFB label=DrawList
D $AFFB The list of items to draw, built by #R$AC40. Each item is three bytes:
. a flag and the address of a record.
B $AFFB,$71,$08

g $B06C Draw List Pointer
@ $B06C label=DrawListPointer
D $B06C The address of the next free item in the draw list.
W $B06C,$02,$02

c $B06E Draw Items
@ $B06E label=DrawItems
D $B06E Draws every item in the sorted draw list at #R$AF8F, in order. The flag
. in each item selects what is drawn: #N$01 is an entity, #N$02 is one of the
. extra records (which is first copied into the temporary entity at #R$B7A4)
. and #N$03 is one of the #N$14-byte records.
D $B06E For a #N$14-byte record, the items drawn before it that overlap it are
. collected into the table at #R$B1B2(#N$B1B3) and then the record is drawn
. with #R$C15E. An extra record is drawn with #R$B436 after its column, row,
. frame, width and height have been copied into the temporary entity.
  $B06E,$03 Take the sorted draw list.
@ $B071 label=DrawItems_Next
  $B071,$01 Read the kind of the next item.
  $B072,$02,b$01 Keep the kind of the item.
  $B074,$01 Return at the end of the list.
  $B075,$05 Read the address of the record and step to the next item.
  $B07A,$03 Take that record.
  $B07D,$01 Remember the next item.
  $B07E,$04 Draw an entity with #R$B436.
  $B082,$05 Draw a #N$14-byte record at #R$B0C4.
@ $B087 label=DrawItems_Extra
  $B087,$06 Jump to #R$B0C1 to skip an extra record that is not in use.
  $B08D,$09 Copy the column and the row into the temporary entity.
  $B096,$09 Copy fields #N$08 and #N$09 of the extra record into the screen
. address
. of the temporary entity.
  $B09F,$04 Fetch the frame and the width.
  $B0A3,$02,b$01 Keep the width.
  $B0A5,$03 Store the width in the temporary entity.
  $B0A8,$03 Fetch the height byte.
  $B0AB,$02,b$01 Keep the height.
  $B0AD,$03 Store the height in the temporary entity.
  $B0B0,$05 Move the frame down from the high nibble.
  $B0B5,$02,b$01 Keep the frame.
  $B0B7,$03 Store the frame in the temporary entity.
  $B0BA,$04 Use the temporary entity.
  $B0BE,$03 Draw it.
@ $B0C1 label=DrawItems_NextItem
  $B0C1,$01 Restore the next item.
  $B0C2,$02 Take the next item.
@ $B0C4 label=DrawItems_Record
N $B0C4 Look back through the items drawn before this #N$14-byte record. The
. alternate #REGc counts the ones that overlap it, and the alternate #REGhl
. walks the overlap table.
  $B0C4,$01 Switch to the alternate registers.
  $B0C5,$02 Clear the overlap count.
  $B0C7,$03 Use the overlap table.
  $B0CA,$01 Switch back.
  $B0CB,$04 Keep this record aside.
  $B0CF,$03 Step back to this item.
@ $B0D2 label=DrawItems_Previous
  $B0D2,$06 Read the previous item.
  $B0D8,$04 Stop at the start of the list.
  $B0DC,$04 Skip another #N$14-byte record.
  $B0E0,$03 Take the previous item.
  $B0E3,$01 Remember the place in the list.
  $B0E4,$03 Test an entity now.
  $B0E7,$09 Copy the column and the row of the extra record into the temporary
. entity.
  $B0F0,$09 Copy the adjusted x coordinate into the temporary entity.
  $B0F9,$09 Copy the adjusted y coordinate into the temporary entity.
  $B102,$09 Copy the adjusted z coordinate into the temporary entity.
  $B10B,$03 Fetch the frame and the width.
  $B10E,$02,b$01 Keep the width.
  $B110,$03 Store the width in the temporary entity.
  $B113,$03 Fetch the height byte.
  $B116,$02,b$01 Keep the height.
  $B118,$03 Store the height in the temporary entity.
  $B11B,$04 Use the temporary entity.
@ $B11F label=DrawItems_Test
  $B11F,$03 Test this item against the record.
  $B122,$04 Test whether the record still has to collect this item.
  $B126,$04 Mark the record as having been tested against this item.
  $B12A,$03 Collect the item when it overlaps the record.
  $B12D,$01 Restore the place in the list.
@ $B12E label=DrawItems_Continue
  $B12E,$02 Look at the previous item.
@ $B130 label=DrawItems_Collected
N $B130 Patch the drawing routines with this record, then draw the block. A
. record whose byte #N$0A is #N$11 or #N$12 keeps the default details #N$1010.
  $B130,$01 Switch to the alternate registers.
  $B131,$02 Test the overlap count.
  $B133,$03 Leave a record that nothing overlaps.
  $B136,$03 Remember how many items overlap the record.
  $B139,$03 Give that count to the overlapped-block routine.
  $B13C,$03 Fetch the drawing flags.
  $B13F,$02,b$01 Keep the low three drawing flags.
  $B141,$03 Give the drawing flags to the overlapped-block routine.
  $B144,$03 Fetch byte #N$0A of the record.
  $B147,$03 Give that byte to the block routine.
  $B14A,$07 Build an instruction that loads three times that byte.
  $B151,$03 Patch that instruction into #R$C15E(#N$C1A0).
  $B154,$02 Take the opcode of a jump.
  $B156,$03 Patch it into #R$C72E(#N$C75D).
  $B159,$03 Take #R$C7AC.
  $B15C,$03 Patch the jump so that it enters #R$C7AC.
  $B15F,$04 Fetch the view origin.
  $B163,$06 Fetch the first two bytes of the record.
  $B169,$03 Start from zero.
  $B16C,$04 Subtract the view origin and add the first two bytes of the record.
  $B170,$03 Store the result in the drawing variables.
  $B173,$06 Fetch the screen position saved in the record.
  $B179,$03 Store it in the drawing variables.
  $B17C,$03 Take the default record details.
  $B17F,$03 Fetch byte #N$0A of the record.
  $B182,$04 Keep the default details when the byte is #N$11.
  $B186,$04 Keep the default details when the byte is #N$12.
  $B18A,$06 Take fields #N$0B and #N$0C of the record as the details.
@ $B190 label=DrawItems_Details
  $B190,$03 Store the details.
  $B193,$03 Fetch byte #N$0D of the record.
  $B196,$03 Store the third detail byte.
  $B199,$03 Take the overlapped-block routine.
  $B19C,$03 Patch #R$C381 so that it uses #R$C646.
  $B19F,$02 Take the value #N$1A.
  $B1A1,$03 Patch it into #R$B4E8(#N$B530).
  $B1A4,$03 Draw the block.
  $B1A7,$02 Take the row step #N$08.
  $B1A9,$03 Restore it in #R$C76D(#N$C794).
  $B1AC,$03 Restore it in #R$C76D(#N$C7A6).
  $B1AF,$03 Take the next item.

g $B1B2 Draw Items Work Area
@ $B1B2 label=DrawItemsWorkArea
D $B1B2 The first byte is the number of overlapping items collected by #R$B06E.
. The table of overlapping items that follows is filled by #R$B399, each entry
. being four bytes. Purpose of the rest is not yet known.
B $B1B2,$4D,$08

c $B1FF Add Item Record
@ $B1FF label=AddItemRecord
D $B1FF Adds a #N$14-byte record to the table at #R$BBF7, from the entity in
. #REGix and the details held at #R$5CB9, #R$5CDC, #R$5CF3 and #R$5CF3(#N$5CF5).
. The operand of the first instruction is the address of the next free record,
. and is updated each time. The number of records is kept in #R$BBF6. Kinds
. #N$11 and #N$12 set both sizes to #N$08 and set bit 2 of bytes 3 and 6.
R $B1FF IX The entity
N $B1FF #REGiy is the new record. Its bytes are filled from the entity and from
. the cell, the drawing position and the three sizes.
  $B1FF,$04 Use the next free record.
  $B203,$07 Count one more record.
  $B20A,$04 Fetch the cell position.
  $B20E,$03 Read the entity's type.
  $B211,$01 Keep the type aside.
  $B212,$02,b$01 Use the high nibble of the type.
  $B214,$03 Keep it as byte 3 of the record.
  $B217,$08 Shift the type up by four and keep it as byte 6.
  $B21F,$06 Keep the cell position in bytes 2 and 5.
  $B225,$03 Read the frame.
  $B228,$01 Keep the frame aside.
  $B229,$02,b$01 Use the frame number.
  $B22B,$01 Keep the frame number aside.
  $B22C,$04 Bring bit 4 of the frame down beside it.
  $B230,$02,b$01 Use that bit.
  $B232,$04 Combine it with the frame number and keep it as byte #N$0A.
  $B236,$09 Copy the first two sizes into bytes #N$0B and #N$0C.
  $B23F,$06 Copy the third size into byte #N$0D.
  $B245,$10 Make bytes 4 and 7 from that size, the details and #N$10.
  $B255,$04 Fetch the drawing position.
  $B259,$03 Read the frame again.
  $B25C,$02,b$01 Use bits 4-6 of the frame.
  $B25E,$03 Add them to the position and advance its high byte.
  $B261,$06 Keep that position in bytes 8 and 9.
  $B267,$13 Make the address kept in bytes #N$12 and #N$13.
  $B27A,$05 Add the size to the low byte of the drawing position.
  $B27F,$01 Count the carry in the high byte.
@ $B280 label=AddItemRecord_Address
  $B280,$06 Fetch bytes 2 and 3 of the record.
  $B286,$03 Subtract the drawing position.
  $B289,$06 Keep that address in bytes #N$10 and #N$11.
  $B28F,$03 Fetch the origin.
  $B292,$03 Read the drawing flags.
  $B295,$02,b$01 Use bits 0-2 of the drawing flags.
  $B297,$01 Combine them with the low byte of the origin.
  $B298,$06 Keep the origin in bytes 0 and 1.
  $B29E,$09 Copy the screen position into bytes #N$0E and #N$0F.
  $B2A7,$0B Kinds #N$11 and #N$12 use fixed sizes.
@ $B2B2 label=AddItemRecord_Fixed
  $B2B2,$08 Set bit 2 of bytes 3 and 6.
  $B2BA,$08 Set both sizes to #N$08.
@ $B2C2 label=AddItemRecord_Next
  $B2C2,$09 Advance to the next free record.
  $B2CB,$01 Return.

c $B2CC Test Records Against Entity
@ $B2CC label=TestRecordsAgainstEntity
D $B2CC Tests the entity in #REGix against each of the #N$14-byte records in the
. table at #R$BBF7 that has not already been marked, using #R$B2EB.
R $B2CC IX The entity
  $B2CC,$03 Read how many records there are.
  $B2CF,$02 Return when there are none.
  $B2D1,$02 Remember the record that was in use.
  $B2D3,$04 Start at the first record.
@ $B2D7 label=TestRecordsAgainstEntity_Loop
  $B2D7,$01 Remember how many records remain.
  $B2D8,$07 Test the overlap when bit 7 of byte #N$0A is clear.
  $B2DF,$05 Step on to the next record.
  $B2E4,$04 Repeat for the remaining records.
  $B2E8,$02 Restore the record that was in use.
  $B2EA,$01 Return.

c $B2EB Test Record Overlap
@ $B2EB label=TestRecordOverlap
D $B2EB Tests whether the entity in #REGix overlaps the #N$14-byte record in
. #REGiy. If it does then bit 7 of field #N$0A of the record is set.
R $B2EB IX The entity
R $B2EB IY The #N$14-byte record
N $B2EB The record's drawing position, plus its third size, has to meet the
. entity on z. The addresses in bytes #N$10 and #N$12 then have to meet it
. on x and y.
  $B2EB,$02 Start with no high byte.
  $B2ED,$06 Read the record's drawing position.
  $B2F3,$05 Add the third size and step back one.
  $B2F8,$06 Subtract the entity's z.
  $B2FE,$04 No overlap when the record is below the entity on z.
  $B302,$05 Add the z extent to that z.
  $B307,$03 Count the carry in the high byte.
@ $B30A label=TestRecordOverlap_X
  $B30A,$09 Subtract it from the entity's x.
  $B313,$06 Subtract the address in bytes #N$10 and #N$11.
  $B319,$05 The entity is on the far side of that address.
  $B31E,$02 No overlap when it is a byte or more past the address.
  $B320,$05 No overlap when the gap is at least byte 4 of the record.
  $B325,$02 Join the y test.
@ $B327 label=TestRecordOverlap_MissX
  $B327,$02 No overlap when the miss is a byte or more the other way.
  $B329,$06 The x extent reaches the address.
  $B32F,$03 The z extent reaches it too.
  $B332,$01 No overlap when it still falls short.
@ $B333 label=TestRecordOverlap_Y
  $B333,$0D Add the entity's z to its y.
  $B340,$09 Subtract the address in bytes #N$12 and #N$13.
  $B349,$02 The entity is on the far side of that address.
  $B34B,$02 No overlap when it is a byte or more past the address.
  $B34D,$05 No overlap when the gap is at least byte 7 of the record.
  $B352,$02 Join the column test.
@ $B354 label=TestRecordOverlap_MissY
  $B354,$02 No overlap when the miss is a byte or more the other way.
  $B356,$06 The y extent reaches the address.
  $B35C,$03 The z extent reaches it too.
  $B35F,$01 No overlap when it still falls short.
@ $B360 label=TestRecordOverlap_Range
N $B360 The column is tested against the record's origin, shifted by how far
. the view origin has moved. The width is the sprite width in bytes times
. eight, and the range is the two sizes or #N$20, whichever is larger.
  $B360,$06 Read the record's origin.
  $B366,$04 Fetch the view origin.
  $B36A,$03 Fetch the origin kept for the items.
  $B36D,$03 Subtract the kept origin.
  $B370,$01 Add the record's origin.
  $B371,$05 Measure the column from page #N$80.
  $B376,$03 Read the sprite width.
  $B379,$02,b$01 Use the low nibble.
  $B37B,$04 Turn the width into pixels, eight per byte.
  $B37F,$08 Add the two sizes.
  $B387,$02 Use #N$FF when the sizes overflow.
@ $B389 label=TestRecordOverlap_Minimum
  $B389,$04 Use at least #N$20.
  $B38D,$02 The minimum size is #N$20.
@ $B38F label=TestRecordOverlap_Column
  $B38F,$04 Test the column against that range.
  $B393,$01 Return when the column is outside it.
  $B394,$04 Mark the record as overlapping.
  $B398,$01 Return.

c $B399 Collect Overlapping Item
@ $B399 label=CollectOverlappingItem
D $B399 Adds the entity in #REGix to the table of overlapping items that is
. being built by #R$B06E. Four bytes are stored: the screen position from
. fields #N$0E and #N$0F, the width from field #N$16 (times eight) and the
. height from field #N$17.
R $B399 IX The entity
R $B399 HL' Pointer to the next free entry in the table
R $B399 C' The number of entries
R $B399 O:HL' Updated pointer
  $B399,$01 Keep the table pointer aside.
  $B39A,$06 The column and the row.
  $B3A0,$0B The width, times eight.
  $B3AB,$06 Write the column, the row and the width.
  $B3B1,$05 The height, without the shape flags.
  $B3B6,$01 Count this item.
  $B3B7,$01 Bring the table pointer back.
  $B3B8,$01 Return.

c $B3B9 Test Range
@ $B3B9 label=TestRange
D $B3B9 Tests whether a position falls within a range. The zero flag is set
. when it does.
R $B3B9 HL The position
R $B3B9 DE The column address
R $B3B9 B The width
R $B3B9 C The size
R $B3B9 O:F The zero flag is set when the position is inside the range
N $B3B9 #REGhl is the position and #REGde the column address. #REGb is the width
. and #REGc the size. The zero flag is set when the position is inside.
  $B3B9,$02 Subtract the column address from the position.
  $B3BB,$02 The position is below the column address.
  $B3BD,$03 Test the width on this side.
  $B3C0,$02 Subtract the width.
  $B3C2,$01 Outside the range when the position is past the width.
  $B3C3,$01 Inside the range.
  $B3C4,$01 Return.
@ $B3C5 label=TestRange_Low
  $B3C5,$02 The size is a single byte.
  $B3C7,$01 Add the size to the shortfall.
  $B3C8,$01 Outside the range when the size falls short.
  $B3C9,$01 Inside the range.
  $B3CA,$01 Return.

c $B3CB Build Patterned Sprite
@ $B3CB label=BuildPatternedSprite
D $B3CB Builds a copy of a sprite in the buffer at #N$5B70 for an entity whose
. sprite has a pattern. The pattern is chosen by the entity and by the frame
. counter at #R$A2DD, taken from the table at #R$B416, and each pair of bytes
. of the sprite is combined with a rotating mask from the table.
R $B3CB A Bits 4-7 of field #N$16 of the entity, shifted
R $B3CB DE The address of the sprite
R $B3CB O:DE The address of the buffer
N $B3CB The countdown nibble, already shifted down, selects the pattern. The
. low bits of the frame counter choose which mask, and which way it rotates.
  $B3CB,$04 The pattern index is the countdown nibble, less four.
  $B3CF,$01 Keep the index.
  $B3D0,$03 Read the frame counter.
  $B3D3,$02,b$01 Use its low two bits.
  $B3D5,$01 Combine them with the index.
  $B3D6,$06 Look the mask up in the pattern table.
  $B3DC,$01 Read the mask.
  $B3DD,$01 The sprite is the source.
  $B3DE,$03 Read the frame counter again.
  $B3E1,$02,b$01 Use its low bit.
  $B3E3,$04 Turn that bit into a rotate one way or the other.
  $B3E7,$03 Patch the rotate below with it.
  $B3EA,$0B Remember the sprite's width and height at the front of the buffer.
  $B3F5,$02 Move on to the sprite data and clear the total.
@ $B3F7 label=BuildPatternedSprite_Width
  $B3F7,$03 Add the width once for every row.
  $B3FA,$01 The total is the number of byte pairs.
  $B3FB,$05 Remember the stack and read the sprite through it.
  $B400,$03 The masked copy is built just after the width and height.
@ $B403 label=BuildPatternedSprite_Pairs
  $B403,$06 Copy one byte and mask its partner.
  $B409,$01 Move on to the next pair.
  $B40A,$04 Rotate the mask and repeat for the remaining pairs.
  $B40E,$04 Restore the stack pointer.
  $B412,$03 Return the buffer, width and height included.
  $B415,$01 Return.

b $B416 Pattern Table
@ $B416 label=PatternTable
D $B416 The first #N$10 bytes are masks for #R$B3CB. Purpose of the other bytes
. is not yet known.
B $B416,$20,$08

c $B436 Draw Entity Item
@ $B436 label=DrawEntityItem
D $B436 Draws an item from the draw list that is an entity, and then moves on to
. the next item.
R $B436 IX The entity
  $B436,$03 Call #R$B43C.
  $B439,$03 Jump to #R$B0C1.

c $B43C Draw Sprite
@ $B43C label=DrawSprite
D $B43C Draws the sprite of an entity into the screen buffer, which is #N$18
. bytes wide. The sprite data is read by using the stack pointer, and the sprite
. is drawn by one of the row routines in the table at #R$ADE9, which is chosen
. using the width of the sprite and whether it is shifted by the low bits of
. the column. The addresses of the row routine and the step to
. the previous row are written into the drawing code before it is entered. If
. the sprite goes beyond the top of the screen buffer, the rows that are not
. needed are skipped.
R $B43C IX The entity
  $B43C,$03 Find the sprite.
  $B43F,$03 Read the width byte.
  $B442,$02,b$01 Use the countdown nibble.
  $B444,$03 Build a patterned copy when that nibble is set.
  $B447,$04 Remember the stack pointer.
  $B44B,$03 Use the row-routine table.
  $B44E,$03 Read the column.
  $B451,$02,b$01 Use bits 1-2 as the shift.
  $B453,$01 Keep the shift.
  $B454,$01 Read the sprite's width.
  $B455,$03 Give the width to the skip loop.
  $B458,$01 Keep the width.
  $B459,$05 A shifted sprite uses the next routine and one more byte.
@ $B45E label=DrawSprite_Index
  $B45E,$01 Double the width to make a table index.
  $B45F,$03 Look the row routine up.
  $B462,$04 Read the routine's address.
  $B466,$0F Give the routine and the row step to the drawers.
  $B475,$01 Move on to the sprite data.
  $B476,$06 The step back across a row is the width plus #N$17.
  $B47C,$05 The other step is the opposite of that width.
  $B481,$06 Fetch the screen address.
  $B487,$01 Keep the sprite address aside.
  $B488,$02 Read how many rows the sprite has.
  $B48A,$01 Remember that count.
  $B48B,$04 The first row to draw is one past the entity's row.
  $B48F,$02 Read the sprite through the stack.
  $B491,$04 Clip the sprite when its rows end above the view.
  $B495,$01 The row count is that first row.
  $B496,$01 Bring the sprite's row count back.
  $B497,$03 Draw the sprite.
@ $B49A label=DrawSprite_Clip
  $B49A,$05 A count below #N$80 is drawn whole.
  $B49F,$03 A count of exactly #N$80 is drawn whole.
  $B4A2,$01 The rows above the view are the excess.
  $B4A3,$01 Bring the sprite's row count back.
  $B4A4,$02 Drop the rows that are off the view.
  $B4A6,$02 Skip one row of the sprite.
  $B4A8,$03 Skip the bytes of that row.
  $B4AB,$03 Repeat for the remaining rows above the view.
  $B4AE,$01 Bring the rows that are in view back.
  $B4AF,$02 Use that as the row count.
  $B4B1,$01 Read the shift.
  $B4B2,$03 An unshifted sprite is drawn directly.
  $B4B5,$04 A shifted sprite uses the page selected by the shift.
  $B4B9,$03 Draw the shifted rows. The target is patched.
  $B4BC,$01 Put the screen address in #REGhl.
  $B4BD,$03 Draw the unshifted rows. The target is patched.

c $B4C0 Draw Unshifted Rows
@ $B4C0 label=DrawUnshiftedRows
D $B4C0 Draws the rows of a sprite that is not shifted, using the stack pointer
. to read the sprite data. Each pair of sprite bytes is a mask byte and a
. picture byte, and these are combined with the screen buffer. There are four
. entry points, which are for widths of four, three, two and one bytes. The
. address in the table at #R$ADE9 is the entry point for the width.
R $B4C0 HL The address in the screen buffer
R $B4C0 B The number of rows
R $B4C0 SP The sprite data
  $B4C0,$07 Draw one byte of the sprite.
@ $B4C7 label=DrawUnshiftedRows_Three
  $B4C7,$07 Draw one byte of the sprite.
@ $B4CE label=DrawUnshiftedRows_Two
  $B4CE,$07 Draw one byte of the sprite.
@ $B4D5 label=DrawUnshiftedRows_One
  $B4D5,$06 Draw the last byte of the sprite.
@ $B4DB label=DrawUnshiftedRows_Next
  $B4DB,$04 Move to the next row of the screen buffer.
  $B4DF,$04 Repeat for the remaining rows.
  $B4E3,$04 Restore the stack pointer.
  $B4E7,$01 Return.

c $B4E8 Draw Shifted Rows
@ $B4E8 label=DrawShiftedRows
D $B4E8 Draws the rows of a sprite that is shifted by one to three pixels, using
. the stack pointer to read the sprite data. The shifted bytes are found in the
. tables that start at the page in #REGh, and one more byte than the width is
. drawn. There are four entry points, which are for widths of four, three, two
. and one bytes. The address in the table at #R$ADE9 is the entry point for the
. width.
R $B4E8 DE The address in the screen buffer
R $B4E8 H The page of the table for the shift
R $B4E8 B The number of rows
R $B4E8 SP The sprite data
  $B4E8,$10 Draw one byte of the shifted sprite.
@ $B4F8 label=DrawShiftedRows_Three
  $B4F8,$10 Draw one byte of the shifted sprite.
@ $B508 label=DrawShiftedRows_Two
  $B508,$10 Draw one byte of the shifted sprite.
@ $B518 label=DrawShiftedRows_One
  $B518,$10 Draw one byte of the shifted sprite.
@ $B528 label=DrawShiftedRows_Store
N $B528 The row count is held in the alternate accumulator. The width subtracted
. below, and the two jumps, are patched before the routine is entered.
  $B528,$01 Write the prepared byte.
  $B529,$04 Count a row, and finish when none remain.
  $B52D,$01 Bring the sprite byte back.
  $B52E,$04 Step back by the patched width.
  $B532,$01 Read the first byte of the next row.
@ $B533 label=DrawShiftedRows_Step
  $B533,$03 Stay on this page if the step did not borrow.
  $B536,$02 Move to the previous page and read its byte.
@ $B538 label=DrawShiftedRows_Patched
  $B538,$03 Draw the next row. The target is patched.
@ $B53B label=DrawShiftedRows_Return
  $B53B,$04 Restore the stack pointer.
  $B53F,$01 Return.

g $B540 Entities
@ $B540 label=Entities
D $B540 The entities. There are #N$0C of them, each of #N$26 bytes, and the
. first is the player. Field #N$00 is the type, which is zero when the entity
. is not in use. Field #N$01 is the frame, and its bit 7 hides the entity.
. Fields #N$02 and #N$03 are the x coordinate, #N$05 and #N$06 the y coordinate
. and #N$08 to #N$0A the z coordinate. Field #N$0B is the extent on the x axis,
. #N$0C the extent on the y axis and #N$0D the extent on the z axis. Field
. #N$0E is the column on the screen, #N$0F the row and #N$11 the heading.
. Field #N$10 is the speed, with the current speed in bits 0-3 and the maximum
. in bits 4-7. Field #N$1E holds the flags. Bit 7 is set when the entity is
. moving fast. Bit 6 selects the higher frame when #R$B7CE builds the extra
. record, and is tested again by #R$D7E4. Purpose of bit 6 is not yet known.
B $B540,$26,$26
@ $B566 label=EntitiesEntity_01
B $B566,$4C,$26
@ $B5B2 label=EntitiesEntity_03
B $B5B2,$4C,$26
@ $B5FE label=EntitiesEntity_05
B $B5FE,$72,$26
@ $B670 label=EntitiesEntity_08
B $B670,$98,$26

g $B708 Extra Records
@ $B708 label=ExtraRecords
D $B708 One extra record of #N$0D bytes for each of the entities. Bit 7 of field
. #N$09 is set while the record is in use. Fields #N$00 and #N$01 are the
. column and the row. #R$B7CE writes the adjusted x coordinate to fields #N$02
. and #N$03, the adjusted y coordinate to fields #N$04 and #N$05, and the
. adjusted z coordinate to fields #N$06 and #N$07. Field #N$0B holds the width
. in bits 0-3 and the frame in bits 4-7. Field #N$0C holds the height in bits
. 0-5, and its bit 7 copies bit 6 of the entity flags.
B $B708,$9C,$0D

g $B7A4 Temporary Entity
@ $B7A4 label=TemporaryEntity
D $B7A4 A temporary entity that is built from an extra record or a #N$14-byte
. record so that it can be drawn like an entity.
B $B7A4,$26,$26
B $B7CA,$04,$04

c $B7CE Update Extra Record
@ $B7CE label=UpdateExtraRecord
D $B7CE Builds the extra record for an entity, and fills the temporary entity at
. #R$B7A4 so that #R$AF21 can measure its sprite. Field #N$1F chooses the size
. class: below #N$17 is class 0, below #N$25 is class 1, and any higher value
. is class 2. A size index of zero or #N$FF leaves the record unset.
D $B7CE Bit 6 of the flags in field #N$1E selects the higher frame. The frame
. written for the temporary entity is the class when the bit is clear, and the
. class plus three when it is set. The same bit is copied into bit 7 of byte
. #N$0C of the extra record. Purpose of the flag beyond that choice is not yet
. known. The instructions at #R$B7F8 would step the shape bits of the height
. and then start a burst, but they are not reached: the class is only 0, 1 or
. 2, so the jump at #R$B7F6 is always taken. The saved zero flag then makes the
. height adjustment subtract field #N$1F rather than add the z extent.
D $B7CE The adjusted x coordinate is the entity's x plus half of field #N$0B,
. its x extent, and the adjusted y coordinate is the entity's y plus half of
. field #N$0C, its y extent. Both are reduced by a margin taken from the class.
. The z coordinate is the entity's z less field #N$1F, or #N$0100 when that
. would leave the high byte zero. Bytes #N$02 and #N$03 of the extra record
. receive the adjusted x, bytes #N$04 and #N$05 the adjusted y, and bytes
. #N$06 and #N$07 the adjusted z. Byte #N$0B holds the width in bits 0-3 and
. the frame in bits 4-7. Byte #N$0C holds the height in bits 0-5.
R $B7CE IX The entity
R $B7CE IY The extra record
R $B7CE O:A Zero if the record was set up, otherwise non-zero
N $B7CE Leave the record unset when the size index is zero or #N$FF.
  $B7CE,$03 Fetch the size index.
  $B7D1,$03 Jump to #R$B7D7 if the size index is not zero.
@ $B7D4 label=UpdateExtraRecord_Return
  $B7D4,$02,b$01 Report that the record was not set up.
  $B7D6,$01 Return.
@ $B7D7 label=UpdateExtraRecord_Start
  $B7D7,$01 Advance the size index.
  $B7D8,$02 Leave the record unset if the size index was #N$FF.
  $B7DA,$02 Take class 0.
  $B7DC,$04 Use class 0 when the size index is below #N$17.
  $B7E0,$01 Take the next class.
  $B7E1,$04 Use class 1 when the size index is below #N$25.
  $B7E5,$01 Take class 2.
@ $B7E6 label=UpdateExtraRecord_Class
N $B7E6 Remember a clear zero flag, so the height adjustment later subtracts the
. size index. Then choose the higher frame when bit 6 of the flags is set.
  $B7E6,$01 Clear the alternate flags.
  $B7E7,$01 Save the alternate flags.
  $B7E8,$01 Take the class as the frame.
  $B7E9,$06 Jump to #R$B838 to keep this frame if bit 6 is clear.
  $B7EF,$03 Fetch the size index again.
  $B7F2,$02 Compare the size index with #N$05. The result is not used.
  $B7F4,$01 Take the class again.
  $B7F5,$01 Advance to the higher frame.
@ $B7F6 label=UpdateExtraRecord_HigherFrame
  $B7F6,$02 Use the higher frame. This jump is always taken.
@ $B7F8 label=UpdateExtraRecord_Unused
N $B7F8 These instructions are not reached. They would cycle bits 6-7 of the
. height, play the medium buzz the first time, and start a burst when the
. cycle wraps, clearing bit 6 of the flags.
  $B7F8,$01 Restore the alternate flags.
  $B7F9,$03 Fetch the height byte.
  $B7FC,$02,b$01 Keep the shape bits of the height.
  $B7FE,$02 Step the shape if it has already started.
  $B800,$04 Set the first shape bit of the height.
  $B804,$03 Play the medium buzz.
  $B807,$02 Join the shape calculation.
@ $B809 label=UpdateExtraRecord_Frame
  $B809,$03 Fetch the frame counter.
  $B80C,$02,b$01 Act on every fourth frame.
  $B80E,$02 Leave the shape as it is on the other frames.
  $B810,$03 Fetch the height byte.
  $B813,$02 Step the shape bits.
  $B815,$02 Store the new shape if it has not wrapped.
  $B817,$03 Start a burst.
  $B81A,$04 Clear bit 6 of the flags.
  $B81E,$04 Clear the upper shape bit of the height.
  $B822,$04 Clear the lower shape bit of the height.
  $B826,$02 Leave the record unset.
@ $B828 label=UpdateExtraRecord_Store
  $B828,$03 Store the stepped height byte.
@ $B82B label=UpdateExtraRecord_Shape
  $B82B,$03 Fetch the height byte.
  $B82E,$02 Move the shape bits down.
  $B830,$02 Make the shape number negative.
  $B832,$02,b$01 Keep the two shape bits.
@ $B834 label=UpdateExtraRecord_Size
  $B834,$02 Move up by two frames from the shape, or from the higher frame.
  $B836,$02 Use a fixed margin for the higher frame.
@ $B838 label=UpdateExtraRecord_Position
N $B838 Write the frame, then the x extent of the temporary entity, which is
. four times the complement of the class margin.
  $B838,$03 Store the frame in the temporary entity.
  $B83B,$01 Take the class, or the fixed margin of the higher frame.
  $B83C,$02 Subtract four.
  $B83E,$01 Complement the margin.
  $B83F,$01 Double the margin.
  $B840,$01 Keep the doubled margin.
  $B841,$01 Double it again.
  $B842,$03 Store the x extent of the temporary entity.
N $B845 Move the x coordinate by half of the x extent, less the margin.
  $B845,$03 Fetch the high byte of the x coordinate.
  $B848,$03 Fetch the low byte of the x coordinate.
  $B84B,$03 Fetch the x extent.
  $B84E,$02 Halve the x extent.
  $B850,$01 Reduce it by one.
  $B851,$01 Subtract the margin.
  $B852,$01 Keep the adjustment.
  $B853,$02 Take a positive adjustment.
  $B855,$02 Keep the positive adjustment.
  $B857,$02 Take a negative adjustment.
@ $B859 label=UpdateExtraRecord_AddX
  $B859,$01 Add the adjustment to the x coordinate.
  $B85A,$03 Swap the bytes of the x coordinate.
  $B85D,$03 Store the adjusted x coordinate in the temporary entity.
  $B860,$03 Store the high byte of the adjusted x coordinate in the extra
. record.
  $B863,$03 Store the low byte of the adjusted x coordinate in the extra record.
N $B866 Move the y coordinate by half of the y extent, less the same margin.
  $B866,$03 Fetch the high byte of the y coordinate.
  $B869,$03 Fetch the low byte of the y coordinate.
  $B86C,$03 Fetch the y extent.
  $B86F,$02 Halve the y extent.
  $B871,$01 Reduce it by one.
  $B872,$01 Subtract the margin.
  $B873,$02 Take a positive adjustment.
  $B875,$02 Keep the positive adjustment.
  $B877,$02 Take a negative adjustment.
@ $B879 label=UpdateExtraRecord_AddY
  $B879,$01 Add the adjustment to the y coordinate.
  $B87A,$03 Swap the bytes of the y coordinate.
  $B87D,$03 Store the adjusted y coordinate in the temporary entity.
  $B880,$03 Store the high byte of the adjusted y coordinate in the extra
. record.
  $B883,$03 Store the low byte of the adjusted y coordinate in the extra record.
N $B886 Lower the z coordinate by the size index. The saved zero flag makes
. this the path that is taken. The other path would add the z extent.
  $B886,$03 Fetch the top byte of the z coordinate.
  $B889,$03 Fetch the middle byte of the z coordinate.
  $B88C,$02 Clear the high byte of the subtraction.
  $B88E,$01 Restore the saved zero flag.
  $B88F,$02 Subtract the size index. This jump is always taken.
  $B891,$03 Fetch the z extent.
  $B894,$01 Add the z extent. This path is not taken.
  $B895,$02 Join the stored height.
@ $B897 label=UpdateExtraRecord_Height
  $B897,$03 Fetch the size index.
  $B89A,$01 Clear the carry.
  $B89B,$02 Subtract the size index from the z coordinate.
  $B89D,$01 Test the high byte of the result.
  $B89E,$02 Keep the result when the high byte is not zero.
  $B8A0,$03 Use a height of #N$0100 when the result is zero.
@ $B8A3 label=UpdateExtraRecord_Finish
  $B8A3,$03 Store the high byte of the adjusted z coordinate in the extra
. record.
  $B8A6,$03 Store the low byte of the adjusted z coordinate in the extra record.
  $B8A9,$03 Swap the bytes of the z coordinate.
  $B8AC,$03 Store the adjusted z coordinate in the temporary entity.
  $B8AF,$04 Use the temporary entity.
  $B8B3,$04 Clear the height byte of the temporary entity.
  $B8B7,$03 Measure the sprite.
  $B8BA,$03 Fetch the frame of the temporary entity.
  $B8BD,$05 Move the frame into the high nibble.
  $B8C2,$03 Fetch the width of the temporary entity.
  $B8C5,$02,b$01 Keep the width.
  $B8C7,$01 Combine the frame with the width.
  $B8C8,$03 Store the frame and the width in the extra record.
  $B8CB,$03 Fetch the height of the temporary entity.
  $B8CE,$02,b$01 Keep the height.
  $B8D0,$01 Keep the height aside.
  $B8D1,$03 Fetch the flags.
  $B8D4,$01 Move bit 6 of the flags up to bit 7.
  $B8D5,$02,b$01 Keep that bit.
  $B8D7,$01 Combine it with the height.
  $B8D8,$03 Store the height in the extra record.
  $B8DB,$01 Report that the record was set up.
  $B8DC,$01 Return.

c $B8DD Add To High Byte
@ $B8DD label=AddToHighByte
D $B8DD Adds a value to the high byte of an address, carrying into the low byte.
R $B8DD A The value
R $B8DD HL The address
R $B8DD O:HL The new address
  $B8DD,$01 Plus #REGh.
  $B8DE,$01 #REGa moves into #REGh.
  $B8DF,$01 Return if the carry flag is reset.
  $B8E0,$01 Advance #REGl.
  $B8E1,$01 Return.

c $B8E2 Convert Entity Position
@ $B8E2 label=ConvertEntityPosition
D $B8E2 Converts the screen position in fields #N$0E and #N$0F of an entity,
. which is limited to #N$7F in the high byte, to an address in the screen buffer
. with #R$E59E, and stores the address in fields #N$18 and #N$19.
R $B8E2 IX The entity
  $B8E2,$03 Fetch the row into #REGh.
  $B8E5,$03 Fetch the column into #REGl.
  $B8E8,$01 #REGh moves into #REGa.
  $B8E9,$04 Jump to #R$B8E2(#N$B8EF) if it is below #N$80.
  $B8ED,$02 #REGh is #N$7F.
@ $B8EF label=ConvertEntityPosition_Skip
  $B8EF,$03 Call #R$E59E.
  $B8F2,$03 Write #REGl in field #N$18 of the entity.
  $B8F5,$03 Write #REGh in field #N$19 of the entity.
  $B8F8,$01 Return.

c $B8F9 Move View
@ $B8F9 label=MoveView
D $B8F9 Moves the view by adding a value to #R$5CE2(#N$5CE4) and subtracting it
. from #R$5CEE and #R$5CE2.
R $B8F9 DE The amount
  $B8F9,$03 Fetch the word at #R$5CE2(#N$5CE4) into #REGhl.
  $B8FC,$01 #REGhl takes #REGde.
  $B8FD,$03 Write #REGhl at #R$5CE2(#N$5CE4).
  $B900,$03 Fetch the word at #R$5CEE into #REGhl.
  $B903,$01 See whether #REGa is zero.
  $B904,$02 Subtract #REGde from #REGhl. (with the carry)
  $B906,$03 Write #REGhl at #R$5CEE.
  $B909,$03 Fetch the word at #R$5CE2 into #REGhl.
  $B90C,$01 See whether #REGa is zero.
  $B90D,$02 Subtract #REGde from #REGhl. (with the carry)
  $B90F,$03 Write #REGhl at #R$5CE2.
  $B912,$01 Return.

b $B913 Block Shape Table
@ $B913 label=BlockShapeTable
D $B913 Purpose not yet known. The first bytes are used by #R$C15E(#N$C2FA),
. which uses the low seven bits of the byte for an entry to patch the drawing
. code, and bit 7 to patch the code as well.
B $B913,$E0,$10

c $B9F3 Add Record Sizes
@ $B9F3 label=AddRecordSizes
D $B9F3 Adds the size values at #R$5CF3 and #R$5CF3(#N$5CF4) to a value.
R $B9F3 HL The value
R $B9F3 O:HL The value plus the sizes
  $B9F3,$07 Add the low byte of the first size.
  $B9FA,$05 Add the second size.
  $B9FF,$01 Return.

c $BA00 Get Size Offset
@ $BA00 label=GetSizeOffset
D $BA00 Subtracts half of the second size at #R$5CF3(#N$5CF4), plus the third
. size at #R$5CF3(#N$5CF5), from the screen position at #R$BB9F(#N$BBA1).
R $BA00 O:HL The result
  $BA00,$03 The screen position.
  $BA03,$06 Half of the second size.
  $BA09,$05 Add the third size.
  $BA0E,$05 Subtract that from the screen position.
  $BA13,$01 Return.

c $BA14 Set Carry And Return
@ $BA14 label=SetCarryAndReturn
D $BA14 Sets the carry flag.
  $BA14,$01 Set the carry flag.
  $BA15,$01 Return.

c $BA16 Find Group
@ $BA16 label=FindGroup
D $BA16 Finds the group of objects at a position of the level, using the level
. map at the address in #R$5CFE and the table of groups at #R$8BB1.
R $BA16 H The vertical position, which starts at #N$20
R $BA16 L The horizontal position, which starts at #N$20
R $BA16 O:IY The address of the group
R $BA16 O:F Carry set if there is no group, or it has no objects
N $BA16 Check that the position is inside the map, and find the cell of the map.
  $BA16,$04 Fetch the address of the header of the level into #REGiy.
  $BA1A,$01 Copy the horizontal position into #REGa.
  $BA1B,$02 Take away the border of #N$20 to make it a column of the map.
  $BA1D,$01 Return if the position is left of the map.
  $BA1E,$01 Keep the column in #REGc.
  $BA1F,$03 Compare the column with the width of the map.
  $BA22,$02 Return with no group if the position is right of the map.
  $BA24,$01 Copy the vertical position into #REGh.
  $BA25,$02 Take away the border of #N$20 to make it a row of the map.
  $BA27,$01 Return if the position is above the map.
  $BA28,$01 Keep the row in #REGb.
  $BA29,$02 Jump to #R$BA38 if it is the first row.
  $BA2B,$03 Compare the row with the height of the map.
  $BA2E,$02 Return with no group if the position is below the map.
N $BA30 Find the number of the cell by adding the width of the map once for each
. row, and then add that number of cells to the start of the map.
  $BA30,$01 Start with the column.
  $BA31,$03 Fetch the width of the map.
@ $BA34 label=FindGroup_Loop
  $BA34,$01 Add the width of the map.
  $BA35,$02 Decrease the row counter and loop back to #R$BA34 until all the rows
. have been added.
  $BA37,$01 Keep the number of the cell in #REGc.
@ $BA38 label=FindGroup_Row
  $BA38,$02 Double it, as there are two bytes for each cell.
  $BA3A,$02 Add it to the address of the header, to reach the cell.
N $BA3C Read the cell. Its first byte is returned as an offset, and its second
. is the number of the group.
  $BA3C,$01 Clear #REGe.
  $BA3D,$03 Fetch the first byte of the cell, which starts #N$07 bytes after the
. header.
  $BA40,$01 Keep it in #REGd.
  $BA41,$02 Add #N$02, which sets the carry flag if the byte is #N$FE or #N$FF.
  $BA43,$01 Return with no group if the cell has none.
  $BA44,$03 Fetch the number of the group from the second byte of the cell.
  $BA47,$02 Double it, as the table has two bytes for each group.
  $BA49,$03 Point #REGhl at #R$8BB1.
  $BA4C,$01 Add the offset to find the entry for the group.
  $BA4D,$01 Fetch the low byte of the address of the group.
  $BA4E,$01 Move onto the high byte.
  $BA4F,$01 Fetch the high byte of the address of the group.
  $BA50,$01 Put the address of the group in #REGbc onto the stack...
  $BA51,$02 ...and take it off into #REGiy.
  $BA53,$02 Multiply the first byte of the cell by #N$80 by shifting it...
  $BA55,$02 ...across #REGde, ready to return it as an offset.
  $BA57,$03 Fetch the first byte of the group.
  $BA5A,$01 Test it.
  $BA5B,$01 Return with the carry flag reset if the group has objects.
  $BA5C,$01 Set the carry flag as the group is empty.
  $BA5D,$01 Return.

b $BA5E Cell Offsets
@ $BA5E label=CellOffsets
D $BA5E Nine pairs of offsets, which are used to find the cells around the
. player that are to be drawn.
B $BA5E,$12,$02

c $BA70 Draw Level Objects
@ $BA70 label=DrawLevelObjects
D $BA70 Draws the objects of the level that are near the player. The nine cells
. around the position of the player are tried in turn, and the objects of the
. group in each cell are drawn with #R$BB3C. There are two entry points, which
. choose between two versions of the drawing code that is patched at #N$C3D8.
  $BA70,$05 Draw each row with #R$C59A.
@ $BA75 label=DrawLevelObjects_Second
  $BA75,$03 Test each row with #R$C717 instead.
@ $BA78 label=DrawLevelObjects_Start
  $BA78,$04 Give that routine to the shape drawer.
  $BA7C,$03 Remember where #R$BFA5 should return.
N $BA7F Records at #R$BD74 whose fifth byte is set are copied, seven bytes
. each, into the table at #R$BDBB.
  $BA7F,$06 There is nothing to copy when the count is zero.
  $BA85,$03 Start with none kept.
  $BA88,$04 Start at the first record.
  $BA8C,$03 The copies go into #R$BDBB.
@ $BA8F label=DrawLevelObjects_Loop
  $BA8F,$01 Remember how many records remain.
  $BA90,$06 Copy a record whose fifth byte is set.
  $BA96,$06 Take the seven bytes.
  $BA9C,$02 Copy them.
  $BA9E,$03 Move on to the next source record.
  $BAA1,$04 Count the copy.
@ $BAA5 label=DrawLevelObjects_Empty
  $BAA5,$05 Skip an empty record.
  $BAAA,$01 Bring the counts back.
@ $BAAB label=DrawLevelObjects_Copied
  $BAAB,$02 Repeat for the remaining records.
  $BAAD,$04 Remember how many records were copied.
  $BAB1,$06 Remember the horizontal view origin.
  $BAB7,$06 The next item record is the first one.
  $BABD,$06 The object records start at #R$BD74.
  $BAC3,$05 Draw the block bytes with a call.
  $BAC8,$06 The call draws the block bytes.
  $BACE,$06 Restore the shape index so that it masks nothing.
  $BAD4,$05 The row step-back is #N$1A.
  $BAD9,$07 Clear the item count and the record count.
  $BAE0,$02 Remember the entity.
  $BAE2,$02 Start at the first cell.
  $BAE4,$01 Remember the cell number.
  $BAE5,$03 Find the cell around the player.
  $BAE8,$03 Accept the cell.
  $BAEB,$02 Leave the cell when it is not accepted.
  $BAED,$06 Find the cell position for the group.
  $BAF3,$02 Leave the cell when it is rejected.
  $BAF5,$06 Find the group at that cell.
  $BAFB,$02 Leave the cell when there is no group.
  $BAFD,$04 Remember the group.
  $BB01,$03 Draw the objects of the group.
@ $BB04 label=DrawLevelObjects_Next
  $BB04,$01 Bring the cell number back.
  $BB05,$02 Step on by two cells.
  $BB07,$05 Repeat for the nine cells.
  $BB0C,$02 Restore the entity.
  $BB0E,$01 Return.

c $BB0F Get Cell Position
@ $BB0F label=GetCellPosition
D $BB0F Finds the position of a cell around the player by adding an offset from
. the table at #R$BA5E to the position of the player in #R$5CE2(#N$5CE3) and
. #R$5CE2(#N$5CE5), and stores the result in #R$5CB9.
R $BB0F C The offset in the table, #N$00-#N$10 in twos
  $BB0F,$03 Point #REGhl at #R$BA5E.
  $BB12,$02 #REGb is #N$00.
  $BB14,$01 #REGhl takes #REGbc.
  $BB15,$03 Read the byte at #R$5CE2(#N$5CE3).
  $BB18,$01 Add the byte at the address in #REGhl.
  $BB19,$01 #REGa moves into #REGe.
  $BB1A,$01 Advance #REGhl.
  $BB1B,$03 Read the byte at #R$5CE2(#N$5CE5).
  $BB1E,$01 Add the byte at the address in #REGhl.
  $BB1F,$01 #REGa moves into #REGd.
  $BB20,$01 Exchange #REGde and #REGhl.
  $BB21,$03 Write #REGhl at #R$5CB9.
  $BB24,$01 Return.

c $BB25 Set Carry
@ $BB25 label=SetCarry
D $BB25 Sets the carry flag. Used by #R$BA70 to accept a cell.
  $BB25,$01 Set the carry flag.
  $BB26,$01 Return.
  $BB27,$01 #REGh moves into #REGa.
  $BB28,$01 Plus #REGl.
  $BB29,$01 #REGa moves into #REGe.
  $BB2A,$03 Read the byte at #R$5CE7(#N$5CE8).
  $BB2D,$01 Compare #REGa with #REGe.
  $BB2E,$02 Jump to #R$BB25(#N$BB36) if the carry flag is reset.
  $BB30,$03 Read the byte at #R$5CE7.
  $BB33,$02 Add #N$C0.
  $BB35,$01 Return.
@ $BB36 label=SetCarry_Unused
  $BB36,$01 Advance #REGe.
  $BB37,$01 Advance #REGe.
  $BB38,$01 Compare #REGa with #REGe.
  $BB39,$01 Return.

c $BB3A Clear Carry
@ $BB3A label=ClearCarry
D $BB3A Clears the carry flag. Used by #R$BA70 to accept a group.
  $BB3A,$01 Set #REGa to zero.
  $BB3B,$01 Return.

c $BB3C Draw Group Objects
@ $BB3C label=DrawGroupObjects
D $BB3C Draws each of the objects of a group of a cell, using #R$BFA5. The group
. is at #REGiy and the cell is at #R$5CB9. The first byte of a group has the
. number of objects in bits 0-4, and if bit 4 of it is set there is an extra
. byte, as described for #R$8BB1. The next two bytes and the extra byte make up
. a row of flags that is shifted left by one bit after each object, so that each
. object has a flag of its own.
R $BB3C IY The address of the group
  $BB3C,$03 Fetch the position of the cell.
  $BB3F,$02 Add the column of the cell to its row.
  $BB41,$03 Patch it into #R$BFA5(#N$BFA6) as the depth of the objects.
N $BB44 Work out where the view starts, relative to the cell, and patch it into
. the drawing code.
  $BB44,$03 #REGhl is #N$8000.
  $BB47,$04 Fetch the vertical origin of the view.
  $BB4B,$01 Clear the carry flag.
  $BB4C,$02 Take the origin away.
  $BB4E,$03 Patch the result into #R$BFA5(#N$BFBA).
  $BB51,$03 #REGhl is #N$803F.
  $BB54,$04 Fetch the horizontal origin of the view.
  $BB58,$01 Clear the carry flag.
  $BB59,$02 Take the origin away.
  $BB5B,$03 Patch the result into #R$BFA5(#N$C061).
N $BB5E Read the header of the group.
  $BB5E,$02 Put the address of the group onto the stack...
  $BB60,$02 ...and take it off into #REGix.
  $BB62,$03 Fetch the first byte of the group.
  $BB65,$02,b$01 Keep the number of objects.
  $BB67,$01 Keep it in #REGb.
  $BB68,$03 Fetch the first byte of the flags.
  $BB6B,$03 Fetch the second byte of the flags.
  $BB6E,$02 Move past the first byte of the group...
  $BB70,$02 ...and the first byte of the flags.
  $BB72,$02,b$01 Test whether the group has an extra byte of flags.
@ $BB74 label=DrawGroupObjects_Header
  $BB74,$02 Jump to #R$BB7B if there is no extra byte, with #REGa as zero.
  $BB76,$03 Fetch the extra byte of flags.
  $BB79,$02 Move past the extra byte.
@ $BB7B label=DrawGroupObjects_Objects
  $BB7B,$03 Patch the flags into the instructions that load them after each
. object...
  $BB7E,$03 ...including the extra byte.
N $BB81 Draw each object, and then move the row of flags along by one.
@ $BB81 label=DrawGroupObjects_Loop
  $BB81,$02 Move onto the first byte of the object.
  $BB83,$01 Save the number of objects left.
  $BB84,$03 Draw the object.
  $BB87,$02 Move past the second byte of the object...
  $BB89,$02 ...and the third.
  $BB8B,$02 Fetch the extra byte of flags, which is patched in.
  $BB8D,$03 Fetch the other two bytes of flags, which are patched in.
  $BB90,$01 Shift the extra byte left...
  $BB91,$02 ...then the second byte...
  $BB93,$02 ...and then the first byte.
  $BB95,$03 Patch the extra byte back in.
  $BB98,$03 Patch the other two bytes back in.
  $BB9B,$01 Restore the number of objects left.
  $BB9C,$02 Decrease the number of objects and loop back to #R$BB81 until all of
. them have been drawn.
  $BB9E,$01 Return.

g $BB9F Drawing Variables
@ $BB9F label=DrawingVariables
D $BB9F Variables for the drawing routines. Purpose of most of them is not yet
. known.
B $BB9F,$57,$08

g $BBF6 Record Count
@ $BBF6 label=RecordCount
D $BBF6 The number of #N$14-byte records in use.
B $BBF6,$01,$01

g $BBF7 Records
@ $BBF7 label=Records
D $BBF7 The #N$14-byte records, which are created by #R$B1FF. There is room for
. #N$13 of them.
B $BBF7,$17C,$14

g $BD73 Object Count
@ $BD73 label=ObjectCount
D $BD73 The number of #N$07-byte records in use.
B $BD73,$01,$01

g $BD74 Object Records
@ $BD74 label=ObjectRecords
D $BD74 Records of #N$07 bytes. There is room for #N$0A of them.
B $BD74,$46,$07

g $BDBA Copy Count
@ $BDBA label=CopyCount
D $BDBA The number of records in the copy at #R$BDBB.
B $BDBA,$01,$01

g $BDBB Copied Records
@ $BDBB label=CopiedRecords
D $BDBB A copy of the records in use at #R$BD74.
B $BDBB,$46,$07

c $BE01 Add Object Entity
@ $BE01 label=AddObjectEntity
D $BE01 Called by #R$BFA5 for an object that can be an entity. Checks that the
. object is in view and, if it is of kind #N$02, #N$03 or #N$04, makes an entity
. for it in the pool of four entities at #R$B540(#N$B670). The entity is of type
. #N$0C for kind #N$02 and type #N$10 for the other two. Any object that is in
. view is also recorded with #R$BF41.
E $BE01 Continue on to #R$BF41.
R $BE01 IX The object, which is three bytes
R $BE01 HL The screen column of the object
N $BE01 Check that the object is not off the left or right edge of the view.
  $BE01,$04 Jump to #R$BE0E if bit 7 of the high byte of the screen column is
. set.
  $BE05,$03 #REGbc is #N$0028, the margin on the left of the view.
  $BE08,$01 Add the margin to the screen column.
  $BE09,$02 Rotate bit 7 of the high byte into the carry flag.
  $BE0B,$01 Return if the object is off the left edge of the view.
  $BE0C,$02 Jump to #R$BE14.
@ $BE0E label=AddObjectEntity_RightEdge
  $BE0E,$03 #REGbc is #N$80E0, the right edge of the view.
  $BE11,$02 Subtract it from the screen column.
  $BE13,$01 Return if the object is off the right edge of the view.
N $BE14 Work out the coordinates of the object. The x coordinate is the column
. of the cell and the upper four bits of the first byte of the object. The y
. coordinate is the row of the cell and the lower four bits, multiplied by
. sixteen. They are kept on the stack for the entity.
@ $BE14 label=AddObjectEntity_Position
  $BE14,$04 Fetch the row of the cell and keep it in #REGd.
  $BE18,$03 Fetch the first byte of the object.
  $BE1B,$04 Multiply it by sixteen, to move the lower four bits to the top...
  $BE1F,$01 ...and keep the result in #REGe, as the low byte of the y
. coordinate.
  $BE20,$03 Fetch the column of the cell into #REGh.
  $BE23,$03 Fetch the first byte of the object.
  $BE26,$02,b$01 Keep the upper four bits.
  $BE28,$01 Keep them in #REGl, as the low byte of the x coordinate.
  $BE29,$01 Save the y coordinate.
  $BE2A,$01 Save the x coordinate.
N $BE2B Work out the screen row of the object. This is half of the difference
. between its x and y coordinates, plus the offset to the view, less the height
. of the object.
  $BE2B,$04 Halve the y coordinate.
  $BE2F,$04 Halve the x coordinate.
  $BE33,$02 Subtract half of the y coordinate from half of the x coordinate.
  $BE35,$04 Fetch the offset to the view from the drawing code.
  $BE39,$01 Add the offset.
  $BE3A,$03 Fetch the second byte of the object.
  $BE3D,$02,b$01 Keep the height in bits 4-6.
  $BE3F,$01 Keep it in #REGe.
  $BE40,$03 Fetch the third byte of the object.
  $BE43,$01 Move bit 6, the top bit of the height, to bit 7...
  $BE44,$02,b$01 ...and keep it.
  $BE46,$01 Add the other bits of the height to find the height of the object.
  $BE47,$01 Keep the low byte of the height in #REGe.
  $BE48,$02 Clear #REGd.
  $BE4A,$02 Subtract the height from the screen row.
N $BE4C Check that the object is not above or below the view.
  $BE4C,$04 Jump to #R$BE5A if bit 7 of the high byte of the screen row is not
. set.
  $BE50,$03 #REGde is #N$80A4, the bottom of the view.
  $BE53,$02 Subtract it from the screen row.
  $BE55,$01 Restore the x coordinate.
  $BE56,$01 Restore the y coordinate.
  $BE57,$01 Return if the object is below the view.
  $BE58,$02 Jump to #R$BE63.
@ $BE5A label=AddObjectEntity_TopMargin
  $BE5A,$03 #REGde is #N$0028, the margin at the top of the view.
  $BE5D,$01 Add the margin to the screen row.
  $BE5E,$02 Rotate bit 7 of the high byte into the carry flag.
  $BE60,$01 Restore the x coordinate.
  $BE61,$01 Restore the y coordinate.
  $BE62,$01 Return if the object is above the view.
N $BE63 Only objects of kind #N$02, #N$03 and #N$04 that are not hidden have an
. entity. Record all of the others.
@ $BE63 label=AddObjectEntity_Pool
  $BE63,$04 Point #REGiy at the pool of four entities for objects.
  $BE67,$03 Fetch the third byte of the object.
  $BE6A,$05 Jump to #R$BF41 to record the object if it has one.
  $BE6F,$02,b$01 Keep the kind of the object.
  $BE71,$04 Jump to #R$BE7E if it is kind #N$03.
  $BE75,$04 Jump to #R$BE7E if it is kind #N$04.
  $BE79,$05 Jump to #R$BF41 to record the object if it is not kind #N$02.
N $BE7E Search the pool for an entity that is not in use.
@ $BE7E label=AddObjectEntity_Search
  $BE7E,$02 Set the number of entities left to try to #N$04.
  $BE80,$01 Put the y coordinate into #REGhl.
  $BE81,$03 Set the size of an entity, #N$0026.
@ $BE84 label=AddObjectEntity_Next
  $BE84,$01 Save the number of entities left.
  $BE85,$03 Fetch the type of the entity.
  $BE88,$01 Test it.
  $BE89,$03 Jump to #R$BF39 if the entity is in use.
N $BE8C Make the entity. It starts as type #N$0C, which is kind #N$02.
  $BE8C,$03 Store the high byte of the x coordinate in field #N$02 of the
. entity.
  $BE8F,$03 Store the low byte of the x coordinate in field #N$03.
  $BE92,$03 Store the high byte of the y coordinate in field #N$05.
  $BE95,$01 Fetch the low byte of the y coordinate.
  $BE96,$02 Add #N$04 to put the entity in the middle of the cell.
  $BE98,$01 Keep it in #REGl.
  $BE99,$03 Store it in field #N$06.
  $BE9C,$04 Set the animation counter in field #N$1C to #N$00.
  $BEA0,$04 Set the first and last frames in field #N$1D to #N$20.
  $BEA4,$04 Set the type of the entity to #N$0C.
  $BEA8,$04 Set the size in field #N$0B to #N$0C.
  $BEAC,$04 Set the size in field #N$0C to #N$0C.
  $BEB0,$04 Set field #N$0D to #N$01.
  $BEB4,$03 Fetch the third byte of the object.
  $BEB7,$02,b$01 Keep the kind of the object.
  $BEB9,$04 Jump to #R$BED5 if it is kind #N$02.
  $BEBD,$04 Change the type of the entity to #N$10.
  $BEC1,$04 Set the first and last frames in field #N$1D to #N$00.
  $BEC5,$04 Set field #N$0D to #N$0A.
  $BEC9,$04 Jump to #R$BED5 if it is kind #N$03.
  $BECD,$04 Set the first and last frames in field #N$1D to #N$11, for kind
. #N$04.
  $BED1,$04 Set field #N$0D to #N$10.
N $BED5 Work out the z coordinate of the entity from the height of the object,
. less one.
@ $BED5 label=AddObjectEntity_Fields
  $BED5,$03 Fetch the second byte of the object.
  $BED8,$02,b$01 Keep the height in bits 4-6.
  $BEDA,$01 Keep it in #REGe.
  $BEDB,$04 Set the high byte of the z coordinate in field #N$08 to #N$01.
  $BEDF,$03 Fetch the third byte of the object.
  $BEE2,$01 Move bit 6, the top bit of the height, to bit 7...
  $BEE3,$02,b$01 ...and keep it.
  $BEE5,$01 Add the other bits of the height.
  $BEE6,$02 Take away one.
  $BEE8,$03 Store it in field #N$09, as the low byte of the z coordinate.
  $BEEB,$02 Jump to #R$BEF0 if it did not go below zero.
  $BEED,$03 Decrease the high byte of the z coordinate by one.
@ $BEF0 label=AddObjectEntity_SetFrame
  $BEF0,$03 Fetch the first frame of the entity from field #N$1D.
  $BEF3,$02,b$01 Keep the frame.
  $BEF5,$02,b$01 Set bit 7 to hide the entity until it is known to be in view.
  $BEF7,$03 Store it as the frame of the entity in field #N$01.
N $BEFA Remember the address of the object in fields #N$1A and #N$1B of the
. entity.
  $BEFA,$03 Put the address of the object into #REGde, via the stack.
  $BEFD,$03 Store the high byte in field #N$1A.
  $BF00,$03 Store the low byte in field #N$1B.
N $BF03 Check that the new entity is in view, and free it again if it is not.
  $BF03,$01 Switch to the alternate registers, to keep the coordinates.
  $BF04,$02 Save the address of the object.
  $BF06,$04 Put the address of the new entity into #REGix, via the stack.
  $BF0A,$04 Set the width of the sprite in field #N$16 to #N$00.
  $BF0E,$04 Set the height of the sprite in field #N$17 to #N$18.
  $BF12,$03 Set the margin to #N$0010.
  $BF15,$03 Test whether the entity is in view.
  $BF18,$02 Jump to #R$BF26 if it is.
  $BF1A,$04 Set the type of the entity to #N$00, to free it.
  $BF1E,$04 Set the frame of the entity to #N$80, so that it is hidden.
  $BF22,$02 Restore the address of the object.
  $BF24,$02 Jump to #R$BF36.
N $BF26 The entity is in view. Work out where it is on the screen and which
. sprite it has, and mark the object as having an entity so that it is not made
. again.
@ $BF26 label=AddObjectEntity_Visible
  $BF26,$03 Work out the screen position of the entity.
  $BF29,$03 Fetch the sprite of the entity.
  $BF2C,$02 Restore the address of the object.
  $BF2E,$01 Take the return address off the stack.
  $BF2F,$01 Take the screen column of the object off the stack.
  $BF30,$01 Take the second and third bytes of the object off the stack.
  $BF31,$02 Set bit 7 of the third byte, to show that the object has an entity.
  $BF33,$01 Put the bytes of the object back on the stack...
  $BF34,$01 ...then the screen column...
  $BF35,$01 ...and then the return address.
@ $BF36 label=AddObjectEntity_Done
  $BF36,$01 Switch back to the main registers.
  $BF37,$02 Jump to #R$BF40 to record the object.
@ $BF39 label=AddObjectEntity_NextEntity
  $BF39,$02 Move on to the next entity of the pool.
  $BF3B,$01 Restore the number of entities left.
  $BF3C,$01 Decrease the number of entities left.
  $BF3D,$03 Jump back to #R$BE84 until all four have been tried.
@ $BF40 label=AddObjectEntity_Record
  $BF40,$01 Put the y coordinate back into #REGde, and carry on into #R$BF41 to
. record the object.

c $BF41 Record Object
@ $BF41 label=RecordObject
D $BF41 Records an object in the table of objects at #R$BD74. If the object is
. already in the copy of the table at #R$BDBB, the copy of the record is used.
. Otherwise a new record is made, with the position and kind of the object. The
. operand of the first instruction is the address of the next free record, and
. is updated each time.
R $BF41 IX The object
R $BF41 BC The position of the object
R $BF41 DE The position of the object
N $BF41 Fetch the address of the next free record, which is patched in, and
. check whether there are any records in the copy of the table.
  $BF41,$03 Set #REGhl to the address of the next free record.
  $BF44,$03 Fetch the number of records in the copy of the table.
  $BF47,$01 Test it.
  $BF48,$02 Jump to #R$BF79 to make a new record if there are none.
N $BF4A Look for a record in the copy of the table that has the same position as
. the object.
  $BF4A,$01 Save the y coordinate.
  $BF4B,$01 Save the x coordinate.
  $BF4C,$01 Copy the low byte of the x coordinate into #REGd.
  $BF4D,$04 Point #REGiy at #R$BDBB.
@ $BF51 label=RecordObject_Find
  $BF51,$01 Keep the number of records left.
  $BF52,$01 Fetch the low byte of the x coordinate.
  $BF53,$03 Compare it with the one in the record.
  $BF56,$02 Jump to #R$BF6C if it is different.
  $BF58,$01 Fetch the low byte of the y coordinate.
  $BF59,$03 Compare it with the one in the record.
  $BF5C,$02 Jump to #R$BF6C if it is different.
N $BF5E Found it, so copy the record to the next free record.
  $BF5E,$02 Put the address of the record into #REGde, via the stack...
  $BF60,$02 ...then swap it with the address of the next free record.
  $BF62,$03 Set the size of a record, #N$0007.
  $BF65,$02 Copy the record.
  $BF67,$01 Put the address of the next free record in #REGhl again.
  $BF68,$01 Restore the x coordinate.
  $BF69,$01 Restore the y coordinate.
  $BF6A,$02 Jump to #R$BF9A.
@ $BF6C label=RecordObject_Next
  $BF6C,$01 Keep #REGb in #REGa.
  $BF6D,$03 Set the size of a record, #N$0007.
  $BF70,$02 Move on to the next record in the copy of the table.
  $BF72,$01 Bring back #REGb.
  $BF73,$01 Fetch the number of records left.
  $BF74,$01 Decrease it.
  $BF75,$02 Jump back to #R$BF51 until all of the records have been tried.
  $BF77,$01 Restore the x coordinate.
  $BF78,$01 Restore the y coordinate.
N $BF79 Make a new record from the object, with the coordinates, the height and
. the kind.
@ $BF79 label=RecordObject_New
  $BF79,$02 Store the low byte of the x coordinate.
  $BF7B,$02 Store the high byte of the x coordinate.
  $BF7D,$02 Store the low byte of the y coordinate.
  $BF7F,$02 Store the high byte of the y coordinate.
  $BF81,$03 Fetch the second byte of the object.
  $BF84,$02,b$01 Keep the height in bits 4-6.
  $BF86,$01 Keep it in #REGe.
  $BF87,$03 Fetch the third byte of the object.
  $BF8A,$01 Move bit 6, the top bit of the height, to bit 7...
  $BF8B,$02,b$01 ...and keep it.
  $BF8D,$01 Add the other bits of the height.
  $BF8E,$02 Store the height in the record.
  $BF90,$03 Set the next byte of the record to #N$00.
  $BF93,$03 Fetch the third byte of the object.
  $BF96,$02,b$01 Keep the kind of the object.
  $BF98,$01 Store it in the record.
  $BF99,$01 Move on past the record.
N $BF9A Store the address of the next free record, and count the record.
@ $BF9A label=RecordObject_Store
  $BF9A,$03 Patch the address of the next free record into the first
. instruction.
  $BF9D,$03 Fetch the number of records.
  $BFA0,$01 Add one.
  $BFA1,$03 Store the number of records.
  $BFA4,$01 Return.

c $BFA5 Draw Object
@ $BFA5 label=DrawObject
D $BFA5 Prepares an object of a group for drawing, and then passes it to the
. routine whose address is the operand of the JP at #N$C0DE, which is set by
. #R$BA70. It works out the screen column and row of the object, and returns
. without doing anything if the object is not in view. Objects that can be
. entities are passed to #R$BE01 first, and an object that has the flag for it
. in the row of flags of the group is also given an item record with #R$B1FF.
R $BFA5 IX The object, which is three bytes
N $BFA5 Work out the screen column of the object. This is the depth of the cell
. plus the sum of the two halves of the first byte of the object, which are its
. offsets along the x and y axes, less the origin of the view.
  $BFA5,$02 Set #REGh to the depth of the cell, which is patched in.
  $BFA7,$03 Fetch the first byte of the object.
  $BFAA,$04 Multiply it by sixteen, to move the offset along the y axis to the
. top four bits...
  $BFAE,$01 ...and keep it in #REGe.
  $BFAF,$03 Fetch the first byte of the object again.
  $BFB2,$02,b$01 Keep the offset along the x axis in the top four bits.
  $BFB4,$01 Add the two offsets to find the low byte of the screen column.
  $BFB5,$02 Jump to #R$BFB8 if there was no carry.
  $BFB7,$01 Increase the high byte of the screen column.
@ $BFB8 label=DrawObject_SetColumn
  $BFB8,$01 Put the low byte of the screen column in #REGl.
  $BFB9,$03 Set #REGbc to the origin of the view, which is patched in.
  $BFBC,$01 Add the origin to the screen column.
N $BFBD Find out whether the object can be an entity. Objects of kind #N$81 and
. #N$8F are passed to #R$BE01, and any other kind is drawn straight away.
  $BFBD,$03 Fetch the second byte of the object.
  $BFC0,$02,b$01 Keep bit 7 and the kind in bits 0-3.
  $BFC2,$04 Jump to #R$BFD1 if it is kind #N$81.
  $BFC6,$05 Jump to #R$C018 if bit 7 is not set.
  $BFCB,$01 Add one to the kind.
  $BFCC,$02,b$01 Keep the kind.
  $BFCE,$03 Jump to #R$C018 unless the kind was #N$8F.
@ $BFD1 label=DrawObject_Entity
  $BFD1,$03 Fetch the third byte of the object into #REGb...
  $BFD4,$03 ...and the second byte into #REGc.
  $BFD7,$01 Save them.
  $BFD8,$01 Save the screen column.
  $BFD9,$01 Copy the second byte into #REGa.
  $BFDA,$02,b$01 Keep bit 7 and the kind.
  $BFDC,$04 Jump to #R$BFFF if it is kind #N($8F), so that the bytes are used
. as they are.
N $BFE0 Change an object of kind #N$81 into an object of kind #N$8F that has the
. size of the object in its third byte, so that it is recorded with that size.
  $BFE0,$01 Fetch the third byte of the object.
  $BFE1,$02 Shift the size in bits 4-5 to bits 2-3...
  $BFE3,$02,b$01 ...and keep it.
  $BFE5,$02 Add #N$10.
  $BFE7,$01 Keep it in #REGb.
  $BFE8,$01 Fetch the second byte of the object.
  $BFE9,$02,b$01 Keep the height in bits 4-6.
  $BFEB,$01 Add the size to the height.
  $BFEC,$04 Set the third byte of the object to #N$01.
  $BFF0,$04 Jump to #R$BFFA if it is below #N$80.
  $BFF4,$02 Take away #N$80.
  $BFF6,$04 Set bit 6 of the third byte of the object.
@ $BFFA label=DrawObject_SetKind
  $BFFA,$02,b$01 Set bits 0-3 and bit 7, to make it kind #N$8F.
  $BFFC,$03 Store it as the second byte of the object.
@ $BFFF label=DrawObject_Add
  $BFFF,$03 Add an entity for the object, if it has one, and record it.
  $C002,$01 Restore the screen column.
  $C003,$01 Restore the second and third bytes of the object...
  $C004,$03 ...and put them back.
  $C007,$03 Put the third byte back.
  $C00A,$01 Fetch the second byte of the object.
  $C00B,$02,b$01 Keep bit 7 and the kind.
  $C00D,$02 Compare it with #N$8F.
  $C00F,$01 Return if it is kind #N$8F, as it is an entity and is not drawn as a
. block.
  $C010,$03 Fetch the first byte of the object.
  $C013,$04 Multiply it by sixteen, to move the offset along the y axis to the
. top four bits...
  $C017,$01 ...and keep it in #REGe.
N $C018 Check that the object is not off the left of the view, or off the right
. of it, using the width of the object.
@ $C018 label=DrawObject_Position
  $C018,$01 Fetch the low byte of the screen column.
  $C019,$02,b$01 Round it down to a multiple of eight.
  $C01B,$01 Put it back.
  $C01C,$01 Save the screen column.
  $C01D,$04 Jump to #R$C03E if bit 7 of the high byte of the screen column is
. set.
  $C021,$02 Clear #REGb.
  $C023,$03 Fetch the third byte of the object into #REGc.
  $C026,$02 Double it.
  $C028,$01 Copy it into #REGa.
  $C029,$02,b$01 Keep the width in bits 4-6.
  $C02B,$01 Keep it in #REGd.
  $C02C,$01 Fetch the doubled byte again.
  $C02D,$03 Shift it left three times, to move the depth to bits 4-6...
  $C030,$02,b$01 ...and keep it.
  $C032,$01 Add the width.
  $C033,$02 Add #N$1F to make the distance to the left of the object.
  $C035,$01 Put it in #REGc.
  $C036,$01 Add it to the screen column.
  $C037,$01 Move on by one more.
  $C038,$02 Rotate bit 7 of the high byte into the carry flag.
  $C03A,$01 Restore the screen column.
  $C03B,$01 Return if the object is off the left of the view.
  $C03C,$02 Jump to #R$C045.
@ $C03E label=DrawObject_Far
  $C03E,$03 #REGbc is #N$80C0, the right edge of the view.
  $C041,$02 Subtract it from the screen column.
  $C043,$01 Restore the screen column.
  $C044,$01 Return if the object is off the right of the view.
N $C045 Work out the screen row of the object. This is half of the difference
. between its x and y coordinates, plus the offset to the view, less the height
. of the object.
@ $C045 label=DrawObject_Visible
  $C045,$03 Store the screen column, as the one to draw at.
  $C048,$03 Fetch the row of the cell into #REGd.
  $C04B,$01 Keep the y coordinate of the cell...
  $C04C,$03 Fetch the column of the cell into #REGh.
  $C04F,$03 Fetch the first byte of the object.
  $C052,$02,b$01 Keep the offset along the x axis.
  $C054,$01 Make it the low byte of the x coordinate.
  $C055,$04 Halve the y coordinate...
  $C059,$04 ...and halve the x coordinate.
  $C05D,$03 Subtract half of the y coordinate from half of the x coordinate.
  $C060,$03 Set #REGde to the offset to the view, which is patched in.
  $C063,$01 Add the offset.
  $C064,$03 Fetch the second byte of the object.
  $C067,$02,b$01 Keep the height in bits 4-6.
  $C069,$01 Keep it in #REGe.
  $C06A,$03 Fetch the second byte of the object again.
  $C06D,$02,b$01 Keep bit 7 and the kind.
  $C06F,$04 Jump to #R$C077 if it is kind #N$83.
  $C073,$04 Jump to #R$C07B unless it is kind #N$85.
@ $C077 label=DrawObject_AddHeight
  $C077,$02 #REGa is #N$10, which is added to the height of these kinds.
  $C079,$01 Add the height.
  $C07A,$01 Keep it in #REGe.
@ $C07B label=DrawObject_SubtractHeight
  $C07B,$02 Clear #REGd.
  $C07D,$03 Subtract the height from the screen row.
  $C080,$01 Save the screen row.
N $C081 Check that the object is not above the view.
  $C081,$03 Fetch the third byte of the object.
  $C084,$03 Shift it left three times, to move the depth to bits 3-5...
  $C087,$02,b$01 ...and keep it.
  $C089,$02 Add #N$08.
  $C08B,$01 Keep it in #REGe.
  $C08C,$01 Add it to the screen row.
  $C08D,$02 Rotate bit 7 of the high byte into the carry flag.
  $C08F,$01 Restore the screen row.
  $C090,$01 Return if the object is above the view.
N $C091 Check that the object is not below the view, and work out the height of
. the object.
  $C091,$01 Save the screen row.
  $C092,$04 Fetch the third byte of the object and keep it in #REGb.
  $C096,$02,b$01 Keep the depth in bits 3-5.
  $C098,$02 Add #N$08.
  $C09A,$01 Keep it in #REGe.
  $C09B,$03 Fetch the second byte of the object.
  $C09E,$04 Jump to #R$C0A8 if bit 7 is set.
  $C0A2,$02,b$01 Keep the kind.
  $C0A4,$02 Take away #N$02.
  $C0A6,$02 Jump to #R$C0AF if it is kind #N$02, with zero as the size.
@ $C0A8 label=DrawObject_SizeFromByte
  $C0A8,$01 Fetch the third byte of the object.
  $C0A9,$02 Shift the size in bits 4-5 to bits 2-3...
  $C0AB,$02,b$01 ...and keep it.
  $C0AD,$02 Add #N$10.
@ $C0AF label=DrawObject_StoreHeight
  $C0AF,$03 Store it as the height of the object, in #R$5CF3(#N$5CF5).
  $C0B2,$01 Add the depth.
  $C0B3,$01 Keep it in #REGe.
  $C0B4,$02 Subtract it from the screen row.
  $C0B6,$03 #REGde is #N$8080, the bottom of the view.
  $C0B9,$02 Subtract it from the screen row.
  $C0BB,$01 Restore the screen row.
  $C0BC,$01 Return if the object is below the view.
  $C0BD,$03 Store the screen row, as the one to draw at.
N $C0C0 Work out the depth and the width of the object, and store them.
  $C0C0,$03 Fetch the third byte of the object.
  $C0C3,$01 Double it...
  $C0C4,$01 ...and keep it in #REGb.
  $C0C5,$02,b$01 Keep the size in bits 4-6.
  $C0C7,$02 Add #N$10.
  $C0C9,$03 Store it as the depth of the object, in #R$5CF3(#N$5CF4).
  $C0CC,$01 Fetch the doubled byte again.
  $C0CD,$03 Shift it left three times, to move the other size to bits 4-6...
  $C0D0,$02,b$01 ...and keep it.
  $C0D2,$02 Add #N$10.
  $C0D4,$03 Store it as the width of the object, in #R$5CF3.
N $C0D7 Give the object an item record if its flag in the row of flags of the
. group is set, and then pass it to the routine that handles it.
  $C0D7,$03 Fetch the first byte of the row of flags of the group.
  $C0DA,$01 Rotate its top bit into the carry flag.
@ $C0DB label=DrawObject_Record
  $C0DB,$03 Add an item record for the object if the flag is set.
@ $C0DE label=DrawObject_Handle
  $C0DE,$03 Jump to the routine that handles the object, which is patched in.

c $C0E1 Draw Right Strip
@ $C0E1 label=DrawRightStrip
D $C0E1 Handles an object for #R$BFA5 when the view is scrolling to the left, so
. that only the objects in the strip that has just come into view on the right
. are drawn.
  $C0E1,$03 Fetch the position of the object in the view.
  $C0E4,$03 Add the sizes of the object, to find its far edge.
  $C0E7,$03 Set the position of the start of the strip on the right.
  $C0EA,$03 Subtract the start of the strip.
  $C0ED,$01 Return if the object is not as far across as the strip.
  $C0EE,$02 Draw the block of the object.

c $C0F0 Draw Left Strip
@ $C0F0 label=DrawLeftStrip
D $C0F0 Handles an object for #R$BFA5 when the view is scrolling to the right,
. so that only the objects in the strip that has just come into view on the left
. are drawn. The position of the object is moved across by the width of the
. view, #N$00B0, by the entry point at #R$C0FF.
  $C0F0,$03 Fetch the position of the object in the view.
  $C0F3,$03 Set the distance to move the object across, #N$00B0.
  $C0F6,$01 Copy the high byte of the position into #REGa.
  $C0F7,$04 Jump to #R$C0FF if the position is below #N$8000.
  $C0FB,$01 Copy the low byte of the position into #REGa.
  $C0FC,$02 Compare it with #N$10.
  $C0FE,$01 Return if the object is not in the strip.
@ $C0FF label=DrawLeftStrip_AddOffset
  $C0FF,$03 Fetch the position of the object in the view.
  $C102,$01 Add the distance to move across.
  $C103,$03 Store the new position.
  $C106,$02 Draw the block of the object.

c $C108 Draw Top Strip
@ $C108 label=DrawTopStrip
D $C108 Handles an object for #R$BFA5 when the view is scrolling down, so that
. only the objects in the strip that has just come into view at the top are
. drawn.
  $C108,$03 Find the position of the object in the view, with its size offset.
  $C10B,$01 Copy the high byte of the position into #REGa.
  $C10C,$02 Compare it with #N$80.
  $C10E,$03 Set the distance to move the object down, #N$0010.
  $C111,$02 Draw the object, after moving it, if the high byte is not #N$80.
  $C113,$01 Copy the low byte of the position into #REGa.
  $C114,$02 Compare it with #N$08.
  $C116,$01 Return if the object is not in the strip.
  $C117,$02 Draw the object, after moving it.

c $C119 Draw Bottom Strip
@ $C119 label=DrawBottomStrip
D $C119 Handles an object for #R$BFA5 when the view is scrolling up, so that
. only the objects in the strip that has just come into view at the bottom are
. drawn.
  $C119,$03 Fetch the vertical position of the object in the view.
  $C11C,$03 Fetch the size of the object.
  $C11F,$02 Halve it.
  $C121,$01 Copy it into #REGe.
  $C122,$02 Clear #REGd.
  $C124,$01 Add half of the size to the position.
  $C125,$03 Set the position of the start of the strip at the bottom.
  $C128,$03 Subtract the start of the strip.
  $C12B,$01 Return if the object is not as far down as the strip.
  $C12C,$03 Fetch the vertical position of the object in the view.
  $C12F,$03 Set the distance to move the object up, #N$FF88.
  $C132,$01 Add it.
  $C133,$03 Store the new position.
  $C136,$03 Set the distance to move the object down, #N$0010.
  $C139,$02 Draw the object, after moving it.

c $C13B Draw Chosen Object
@ $C13B label=DrawChosenObject
D $C13B Handles an object for #R$BFA5 when only one object is to be drawn, which
. is the object whose address is the operand of the first instruction. Every
. other object is skipped. The block of the object is drawn with the code that
. is patched to draw a block section instead of a block row.
E $C13B Continue on to #R$C15E.
  $C13B,$03 Set #REGhl to the address of the chosen object, which is patched in.
  $C13E,$03 Copy the address of the current object into #REGde.
  $C141,$03 Subtract the address of the current object.
  $C144,$01 Return if it is not the chosen object.
  $C145,$03 Fetch the kind of the object.
  $C148,$02,b$01 Use bits 0-3 and bit 7.
  $C14A,$02 Compare it with #N$82.
  $C14C,$01 Return if it is not an object of that kind.
  $C14D,$02 Set #REGa to the opcode of a JP instruction, #N$C3.
  $C14F,$03 Patch it into the drawing code at #R$C72E(#N$C75D).
  $C152,$03 Point #REGhl at #R$C7AC.
  $C155,$03 Patch it in as the destination of the jump.
  $C158,$03 #REGhl is #N$00F6.
  $C15B,$03 Patch it in as the amount that is used by #R$C15E at #N$C1A0.

c $C15E Draw Block
@ $C15E label=DrawBlock
D $C15E Draws a block from the drawing variables at #R$BB9F. The three sizes at
. #R$5CF3 supply the column and row sizes, from the high nibble of each byte.
. The shape index comes from the object's frame, unless a record has patched
. #R$C1A0 so that it loads the record's own index. The shape byte is looked up
. from that index, and one section is drawn for each #N$40 in the byte.
D $C15E The flags at #R$D7B3, indexed by the shape kind, choose the layout. Bit
. 7 clear draws the block as it is. Bits 5-6 clear mirror it, #N$20 draws it
. as it is, #N$40 raises it, and any other value moves the origin back by
. #N$10. Kinds #N$11 and #N$12 use a column size of one and lower the screen
. position by the third size. Each section is drawn by #R$C381.
R $C15E IX The object
N $C15E Copy the high nibbles of the three sizes into the drawing variables, and
. make the shape index.
  $C15E,$02 Remember the object.
  $C160,$04 Use the drawing variables.
  $C164,$02 Remember the drawing variables.
  $C166,$08 Take the high nibble of the first size.
  $C16E,$06 Keep it as both copies of the column size.
  $C174,$07 Take the high nibble of the second size.
  $C17B,$09 Keep it as the row size.
  $C184,$07 Use the patched shape index when this instruction loads one.
  $C18B,$04 Read the object's frame.
  $C18F,$02,b$01 Keep the frame number.
  $C191,$05 Bring bit 4 of the frame down beside the frame number.
  $C196,$02,b$01 Keep that bit.
  $C198,$05 Remember the shape index made from the frame.
  $C19D,$03 Triple the shape index.
@ $C1A0 label=DrawBlock_Index
N $C1A0 Look the shape byte up. Below #N$40 there is one section, below #N$80
. there are two, and a larger byte has a third. The bytes of the further
. sections follow the first shape byte.
  $C1A0,$02,b$01 Keep the shape index. A record replaces this so that it loads
. its index.
  $C1A2,$09 Look the shape byte up.
  $C1AB,$01 Remember the shape byte for the later sections.
  $C1AC,$02,b$01 Keep the shape number.
  $C1AE,$03 Store the shape number in the drawing variables.
  $C1B1,$05 One section is enough when the shape byte is below #N$40.
  $C1B6,$05 Read the second shape byte.
  $C1BB,$05 Read the third shape byte.
  $C1C0,$08 Take the high nibble of the third size.
  $C1C8,$06 Use it as the row size of the further sections.
  $C1CE,$03 Fetch the origin.
  $C1D1,$04 Fetch the first two sizes.
  $C1D5,$06 Add the first size to the origin.
  $C1DB,$03 Fetch the screen position.
  $C1DE,$06 Add half of the first size to the screen position.
  $C1E4,$05 Two sections are enough when the shape byte is below #N$80.
  $C1E9,$06 Keep the origin for a third section.
  $C1EF,$03 Fetch the screen position again.
  $C1F2,$0B Subtract the third size from the screen position.
@ $C1FD label=DrawBlock_Details
N $C1FD Kinds #N$11 and #N$12 are the special blocks. The byte loaded here is
. patched with the record's kind.
  $C1FD,$02 Take the shape kind.
  $C1FF,$05 Use the special sizes for kind #N$12.
  $C204,$04 Use the special sizes for kind #N$11 too.
@ $C208 label=DrawBlock_Special
  $C208,$12 Lower the screen position by the third size.
  $C21A,$08 Use a column size of one.
@ $C222 label=DrawBlock_Flags
N $C222 The object's flags choose a mirrored block, a raised block, or a block
. shifted back by #N$10.
  $C222,$06 Look up the flags for this kind of object.
  $C228,$05 Draw the block as it is when the top flag is clear.
  $C22D,$01 Read the flags.
  $C22E,$02,b$01 Keep the layout in bits 5-6.
  $C230,$02 Mirror the block when those bits are clear.
  $C232,$05 Draw the block as it is when the layout is #N$20.
  $C237,$05 Raise the block when the layout is #N$40.
  $C23C,$08 Take the high nibble of the first size.
  $C244,$03 Use it as the extra row size.
  $C247,$0A Move the adjusted origin back by #N$10.
  $C251,$03 Draw the shape.
@ $C254 label=DrawBlock_Mirror
  $C254,$0E Swap the origin with the adjusted origin.
  $C262,$0E Swap the screen position with its adjusted copy.
  $C270,$0E Swap the shape bytes with the extra shape bytes.
  $C27E,$0E Swap the two column sizes.
  $C28C,$08 Take the high nibble of the second size.
  $C294,$03 Use it as the extra row size.
  $C297,$08 Take the high nibble of the first size.
  $C29F,$03 Use it as the other column size.
  $C2A2,$0F Move the origin on by the second size less #N$10.
  $C2B1,$0A Move the screen position back by half of that step.
  $C2BB,$02 Draw the shape.
@ $C2BD label=DrawBlock_Raised
  $C2BD,$0F Move the origin on by the first size less #N$10.
  $C2CC,$0E Move the screen position on by half of that, and keep the old one.
  $C2DA,$02 Draw the shape.
@ $C2DC label=DrawBlock_Next
  $C2DC,$02 Remember the drawing variables.
  $C2DE,$01 Remember the shape byte.
@ $C2DF label=DrawBlock_Shape
N $C2DF Patch the draw routines from the block shape table, then draw the
. section. A shape number of #N$11 takes its row size from the third size.
  $C2DF,$04 Read the shape number.
  $C2E3,$04 Replace the sizes when the shape number is #N$11.
  $C2E7,$08 Take the high nibble of the third size.
  $C2EF,$03 Use it as the row size.
  $C2F2,$05 Use a column size of one.
@ $C2F7 label=DrawBlock_Count
  $C2F7,$08 Look the shape up in the block shape table.
  $C2FF,$02,b$01 Keep the row count.
  $C301,$06 Give the row count to the row routines.
  $C307,$01 Read the same table byte again.
  $C308,$02,b$01 Keep its top bit.
  $C30A,$06 Give that bit to the row routines.
  $C310,$0C Fetch the origin and the screen position.
  $C31C,$06 Give the row size to the shape routine.
  $C322,$03 Fetch the column size.
  $C325,$04 Give the shape number to the shape routine.
  $C329,$04 Multiply the shape number by seven.
  $C32D,$0B Find this shape's seven-byte record.
  $C338,$07 Skip the edge bytes when the shape index was not patched.
  $C33F,$07 Give the shape's first edge, less one, to the overlap test.
  $C346,$0C Give the shape's other edge to the overlap test.
@ $C352 label=DrawBlock_Edges
  $C352,$08 Give the row offset to the row test.
  $C35A,$03 Read the shape's position byte.
  $C35D,$04 Add the offset when that byte is positive.
  $C361,$03 Keep a negative position that overflowed.
  $C364,$03 Sign-extend that negative position.
@ $C367 label=DrawBlock_Offset
  $C367,$04 Add the offset to a positive position.
  $C36B,$01 Count the carry in the high byte.
@ $C36C label=DrawBlock_Section
  $C36C,$03 Draw this section of the block.
  $C36F,$07 Finish when the shape byte has no further section.
  $C376,$08 Step on seven bytes and draw the next section.
@ $C37E label=DrawBlock_Return
  $C37E,$02 Restore the object.
  $C380,$01 Return.

c $C381 Draw Block Shape
@ $C381 label=DrawBlockShape
D $C381 Copies the four step bytes of the shape into this routine and
. sign-extends each one, then draws the block. A shape below #N$09, and shape
. #N$11, is drawn here a row at a time. Shapes #N$09 to #N$10 are drawn by
. #R$C418 and shapes #N$12 to #N$15 by #R$C3F7. #R$C15E patches in the shape
. number and the row count.
R $C381 IY The shape
N $C381 Each step byte of the shape is sign-extended into a word that the row
. loops add to the screen address and the sprite address.
  $C381,$03 Read the shape's first step.
  $C384,$03 Keep it as the low byte of a row step.
  $C387,$05 Sign-extend it when its top bit is set.
  $C38C,$01 The high byte is #N$FF.
@ $C38D label=DrawBlockShape_High
  $C38D,$03 Keep the high byte of the row step.
  $C390,$03 Read the shape's second step.
  $C393,$03 Keep it as the low byte of the other row step.
  $C396,$05 Sign-extend it when its top bit is set.
  $C39B,$01 The high byte is #N$FF.
@ $C39C label=DrawBlockShape_High2
  $C39C,$03 Keep that high byte.
  $C39F,$03 Read the shape's fourth byte.
  $C3A2,$03 Keep it as the low byte of a column step.
  $C3A5,$05 Sign-extend it when its top bit is set.
  $C3AA,$01 The high byte is #N$FF.
@ $C3AB label=DrawBlockShape_High3
  $C3AB,$03 Keep that high byte.
  $C3AE,$03 Read the shape's third byte.
  $C3B1,$03 Keep it as the low byte of the other column step.
  $C3B4,$05 Sign-extend it when its top bit is set.
  $C3B9,$01 The high byte is #N$FF.
@ $C3BA label=DrawBlockShape_High4
  $C3BA,$03 Keep that high byte.
  $C3BD,$02 Read the shape number. The byte is patched.
  $C3BF,$04 A shape below #N$09 is drawn here.
  $C3C3,$05 Shapes #N$09 to #N$10 use the third shape.
@ $C3C8 label=DrawBlockShape_Second
  $C3C8,$04 Shape #N$11 is drawn here.
  $C3CC,$05 Shapes #N$12 to #N$15 use the second shape.
@ $C3D1 label=DrawBlockShape_Rows
  $C3D1,$03 Remember the column count and both addresses.
  $C3D4,$02 Take the patched row count.
@ $C3D6 label=DrawBlockShape_Loop
  $C3D6,$01 Remember how many rows remain.
  $C3D7,$03 Draw this row.
@ $C3DA label=DrawBlockShape_Resume
  $C3DA,$0B Step both addresses on by the row steps.
  $C3E5,$01 Bring the row count back.
  $C3E6,$02 Repeat for the remaining rows.
  $C3E8,$01 Restore the screen address.
  $C3E9,$04 Step on by the column step.
  $C3ED,$01 Switch the addresses.
  $C3EE,$01 Restore the sprite address.
  $C3EF,$04 Step it on by the other column step.
  $C3F3,$01 Bring the column count back.
  $C3F4,$02 Repeat for the remaining columns.
  $C3F6,$01 Return.

c $C3F7 Draw Block Shape Two
@ $C3F7 label=DrawBlockShapeTwo
D $C3F7 Draws one part of a block whose shape is #N$12 to #N$15, lengthens both
. row counts by two, then jumps into #R$C381 to finish.
  $C3F7,$03 Remember the counts and the position.
  $C3FA,$08 Use the row routine chosen for this view.
  $C402,$08 Draw this part.
  $C40A,$0B Lengthen both row counts by two.
  $C415,$03 Continue with the rest of the shape.

c $C418 Draw Block Shape Three
@ $C418 label=DrawBlockShapeThree
D $C418 Draws a block whose shape number is #N$09 to #N$10. #R$C381 has already
. copied the shape's steps into this routine. The shape number chooses the
. edges: shapes below #N$0B use one edge, #N$0B and #N$0C leave the edges
. alone, #N$0D and #N$0E use two, and #N$0F and #N$10 lengthen the row count
. by #N$0E as well. Each column is drawn a row at a time by #R$C59A.
N $C418 The shape number is in #REGa. It chooses how many edge steps this column
. adds, and which edges are written before a single-row column.
  $C418,$01 Remember the screen address.
  $C419,$07 One edge step for a shape below #N$0B.
  $C420,$09 Two edge steps for shape #N$0D or #N$0E.
  $C429,$08 None for shape #N$0B or #N$0C, and three for a higher shape.
@ $C431 label=DrawBlockShapeThree_Steps
  $C431,$04 Remember how many steps this column adds.
  $C435,$07 Remember the edge choice.
  $C43C,$04 Clear the running total of steps.
  $C440,$06 Copy the row count into the row loop.
  $C446,$1E Copy the row routine and the four steps from the shape.
  $C464,$01 Restore the screen address.
@ $C465 label=DrawBlockShapeThree_Rows
  $C465,$03 Remember the column count and both addresses.
  $C468,$02 Take the row count.
@ $C46A label=DrawBlockShapeThree_Columns
N $C46A The edges are changed only when a single row remains, and only for an
. edge choice other than zero.
  $C46A,$01 Remember the row count.
  $C46B,$03 Change the edges only when a single row remains.
  $C46E,$02 Read the edge choice.
  $C470,$03 Leave the edges as they are when the choice is zero.
  $C473,$03 The low bit of the choice selects the wide edges.
  $C476,$03 Read the running total of steps.
  $C479,$03 Use the narrow edges only when that total is odd.
  $C47C,$16 Set the edges to #N$08.
@ $C492 label=DrawBlockShapeThree_Wide
  $C492,$15 Set the edges to #N$18.
  $C4A7,$23 A choice of three also sets the edges to #N$10 and lengthens the
. rows.
@ $C4CA label=DrawBlockShapeThree_Draw
  $C4CA,$03 Draw this row. The routine is patched.
  $C4CD,$0B Step both addresses on by the shape's row steps.
  $C4D8,$03 Repeat for the remaining rows.
  $C4DB,$01 Restore the screen address.
  $C4DC,$14 Put the edges back to #N$18.
  $C4F0,$11 A choice of three shortens the row count again.
  $C501,$07 Add this column's steps to the running total.
  $C508,$0A Shorten the remaining rows when the total overflows.
  $C512,$05 Step the screen address on by the column step.
  $C517,$05 Restore the sprite address and step it on too.
  $C51C,$05 Repeat for the remaining columns.
  $C521,$01 Return.

c $C522 Flip Block Data
@ $C522 label=FlipBlockData
D $C522 Flips the data of a block horizontally, by reversing the bits of each
. byte with the table at #N$F900 and swapping the bytes. The flag in bit 7 of
. the first byte is changed to record the flip. This version is for blocks that
. are #N$10 pixels wide.
R $C522 HL The address of the data of the block
R $C522 IY The shape
N $C522 The first byte of the tile is a flag. A row size other than #N$10 is
. flipped by #R$C556 instead. The mirror of each byte is on page #N$F9.
  $C522,$01 Read the tile's flag.
  $C523,$02,b$01 Toggle its top bit.
  $C525,$01 Write the flag back.
  $C526,$02 Remember the tile and move past the flag.
  $C528,$02 Remember the addresses.
  $C52A,$03 Read the row size.
  $C52D,$02 The narrow flip is for a row size of #N$10.
  $C52F,$04 Remember the stack pointer.
  $C533,$03 Flip a wide tile when the row size differs.
  $C536,$04 Read the tile through the stack. The count is the position byte.
  $C53A,$02 Use the mirror table on page #N$F9.
@ $C53C label=FlipBlockData_Loop
  $C53C,$01 Remember how many rows remain.
  $C53D,$0E Mirror four bytes of the tile.
  $C54B,$01 Bring the count back.
  $C54C,$03 Repeat for the remaining rows.
@ $C54F label=FlipBlockData_Exit
  $C54F,$03 Restore the stack pointer.
  $C552,$03 Restore the saved registers.
  $C555,$01 Return.

c $C556 Flip Wide Block Data
@ $C556 label=FlipWideBlockData
D $C556 Flips the data of a block horizontally, as #R$C522 does, for blocks
. that are wider than #N$10 pixels.
R $C556 IY The shape
N $C556 The mirror of each byte is taken from the table on page #N$F9. The
. count is the shape's position byte.
  $C556,$01 Read the tile through the stack.
  $C557,$0B Step four bytes on for each unit of the position byte.
  $C562,$01 Keep the far end of the row.
  $C563,$02 Use the mirror table on page #N$F9.
@ $C565 label=FlipWideBlockData_Loop
  $C565,$01 Remember how many rows remain.
  $C566,$2C Flip four bytes of the tile.
  $C592,$01 Bring the count back.
  $C593,$04 Repeat for the remaining rows.
  $C597,$03 Join the end of the narrow flip.

c $C59A Draw Block Row
@ $C59A label=DrawBlockRow
D $C59A Draws one row of a block into the screen buffer. A row outside the view
. is left undrawn. The tile is the word at #N$666E indexed by the patched row
. count, and #R$C522 flips it when its top bit differs. Two masked bytes are
. drawn, then the routine steps up one screen row, for the height of the row.
R $C59A HL The first coordinate of the position
R $C59A DE The second coordinate of the position
N $C59A The position arrives in the alternate registers. A row whose page,
. column or size is outside the view is left undrawn.
  $C59A,$05 Take the position from the alternate registers.
  $C59F,$04 Return unless the row is on the drawable page.
  $C5A3,$04 Return when the column is past the view.
  $C5A7,$06 Return when the row size does not reach the view.
  $C5AD,$04 Return unless the other address is on the same page.
  $C5B1,$01 Keep the row.
  $C5B2,$03 Take the shape's position byte as the height.
  $C5B5,$03 Start with no column offset.
  $C5B8,$03 The row starts above the view when it is below that position.
  $C5BB,$03 A row at #N$78 or beyond is off the view.
  $C5BE,$05 Shorten a row that starts above the drawable page.
  $C5C3,$09 Shorten the height by four times that overflow.
  $C5CC,$04 Start the row at #N$7F.
@ $C5D0 label=DrawBlockRow_Above
  $C5D0,$02 Use the whole height when the row starts above the position.
@ $C5D2 label=DrawBlockRow_Tile
  $C5D2,$05 A column of #N$B0 needs no extra offset.
  $C5D7,$06 A row size of #N$10 is not drawn.
  $C5DD,$07 The offset is four times the position byte.
@ $C5E4 label=DrawBlockRow_Draw
  $C5E4,$01 Keep the row number.
  $C5E5,$07 Look the tile up. The index and its high byte are patched.
  $C5EC,$01 Add the index.
  $C5ED,$01 Keep the row number.
  $C5EE,$04 Read the tile address.
  $C5F2,$03 Compare the tile with the patched top bit.
  $C5F5,$03 Flip the tile when they differ.
  $C5F8,$05 Add the column offset to the tile address.
  $C5FD,$01 Count the carry in the high byte.
@ $C5FE label=DrawBlockRow_Offset
  $C5FE,$06 Remember the stack and read the tile through it.
  $C604,$08 Turn the row number into a screen address, #N$18 bytes per row.
  $C60C,$05 Add the strip address.
@ $C611 label=DrawBlockRow_Loop
  $C611,$07 Draw one byte of the row.
  $C618,$06 Draw the other byte of the row.
  $C61E,$04 Step up to the next row of the screen.
  $C622,$02 Repeat for the remaining rows.
  $C624,$04 Restore the stack pointer.
  $C628,$01 Return.

c $C629 Clip Span
@ $C629 label=ClipSpan
D $C629 Works out how much of a span is in view. Purpose not yet known.
  $C629,$02 #REGh is #N$00.
  $C62B,$01 #REGl moves into #REGa.
  $C62C,$01 Subtract #REGe.
  $C62D,$02 Jump to #R$C629(#N$C63B) if the carry flag is set.
  $C62F,$01 #REGa moves into #REGh.
  $C630,$01 Subtract #REGb.
  $C631,$01 Return if the carry flag is reset.
  $C632,$01 #REGe moves into #REGl.
  $C633,$02 Negate #REGa.
  $C635,$01 #REGa moves into #REGb.
  $C636,$01 Compare #REGa with #REGc.
  $C637,$01 Return if the carry flag is set.
  $C638,$01 #REGc moves into #REGb.
@ $C639 label=ClipSpan_Loop
  $C639,$01 Set the carry flag.
  $C63A,$01 Return.
@ $C63B label=ClipSpan_Skip
  $C63B,$01 Plus #REGc.
  $C63C,$01 Return if the carry flag is reset.
  $C63D,$02 Jump to #R$C629(#N$C644) if the zero flag is set.
  $C63F,$01 Compare #REGa with #REGb.
  $C640,$02 Jump to #R$C629(#N$C639) if the carry flag is reset.
  $C642,$01 #REGa moves into #REGb.
  $C643,$01 Return.
@ $C644 label=ClipSpan_Skip2
  $C644,$01 Set #REGa to zero.
  $C645,$01 Return.

c $C646 Draw Overlapped Block
@ $C646 label=DrawOverlappedBlock
D $C646 Draws a block in the parts left uncovered by entities drawn earlier.
. Those entities are in the table at #R$B1B2(#N$B1B3), four bytes each, and the
. count is patched into this routine. Each item that covers the row leaves a
. span, which #R$C6C5 draws.
N $C646 The two limits of the row are remembered, and the count of overlapping
. items is patched into the loop.
  $C646,$03 Remember the first limit.
  $C649,$04 Remember the second limit.
  $C64D,$01 Use the limits' register set.
  $C64E,$04 Start at the first overlapping item.
  $C652,$02 The number of items is patched.
  $C654,$01 Clear the carry for the comparison.
@ $C655 label=DrawOverlappedBlock_Loop
  $C655,$01 Remember how many items remain.
  $C656,$03 Read the patched first limit.
  $C659,$01 Take its low byte.
  $C65A,$02,b$01 Use the patched mask.
  $C65C,$02,b$01 Apply the patched bits.
  $C65E,$04 Remember the masked limit.
  $C662,$05 Take the item's first byte, with the patched high byte.
  $C667,$02 Subtract it from the limit.
  $C669,$02 The item starts above the row.
  $C66B,$04 The item is a whole byte or more past the row.
  $C66F,$06 The gap is at least the item's next byte.
  $C675,$02 Join the second limit.
@ $C677 label=DrawOverlappedBlock_Above
  $C677,$03 The other side is a whole byte or more away.
  $C67A,$05 The item's extra size does not reach the row.
@ $C67F label=DrawOverlappedBlock_Second
  $C67F,$03 Read the patched second limit.
  $C682,$04 The high byte has to be clear.
  $C686,$05 The low byte has to reach the patched edge.
  $C68B,$02 Shift that distance up.
  $C68D,$02 A distance that overflowed does not cover the row.
@ $C68F label=DrawOverlappedBlock_Height
  $C68F,$03 Read the shape's position byte.
  $C692,$04 Subtract the item's byte from the distance.
  $C696,$02 The item covers the far side of the row.
  $C698,$01 The remainder is the height so far.
  $C699,$04 A remainder past the patched edge does not cover the row.
  $C69D,$06 The height is the item's byte, negated.
  $C6A3,$05 Use the smaller of that height and the item's other byte.
  $C6A8,$05 Use the item's byte when it is the smaller.
@ $C6AD label=DrawOverlappedBlock_Far
  $C6AD,$03 Add the item's byte to the distance.
  $C6B0,$04 The sum has to reach past zero.
  $C6B4,$04 Use the patched edge when the sum is below it.
  $C6B8,$01 The height is that sum.
@ $C6B9 label=DrawOverlappedBlock_Draw
  $C6B9,$03 Draw the span that this item leaves.
@ $C6BC label=DrawOverlappedBlock_Next
  $C6BC,$05 Move on to the next item.
  $C6C1,$01 Bring the count back.
  $C6C2,$02 Repeat for the remaining items.
  $C6C4,$01 Return.

c $C6C5 Draw Block Span
@ $C6C5 label=DrawBlockSpan
D $C6C5 Draws the part of a block that falls inside the view, then draws its
. tile with #R$C72E(#N$C735). A span that reaches #N$7F is shortened. The
. height is given to both row counts, and the row becomes a strip address.
  $C6C5,$04 The span starts above the position byte.
  $C6C9,$04 Use the whole span when it does.
@ $C6CD label=DrawBlockSpan_Upper
  $C6CD,$05 Shorten a span that starts at #N$7F or beyond.
  $C6D2,$07 Shorten the height by that overflow.
  $C6D9,$01 Nothing to draw when the height falls to zero.
  $C6DA,$03 The height is what remains, and the row starts at #N$7F.
@ $C6DD label=DrawBlockSpan_Draw
  $C6DD,$07 Give the height to both row counts.
  $C6E4,$05 The column offset is four times the row's high byte.
  $C6E9,$09 Turn the row into a screen address, #N$18 bytes per row.
  $C6F2,$04 Add the base just before the screen buffer.
  $C6F6,$03 Keep that as the strip address.
  $C6F9,$03 Read the column limit.
  $C6FC,$02,b$01 Use its top five bits.
  $C6FE,$03 Add #N$10 to make the limit passed to the tile.
  $C701,$03 Draw the tile.

c $C704 Draw Short Row
@ $C704 label=DrawShortRow
D $C704 Gives both row counts the height in #REGa plus one, draws the row with
. #R$C72E, and puts both counts back to #N$08.
  $C704,$01 The drawn height is one more than the value passed in.
  $C705,$06 Give that height to both row counts.
  $C70B,$03 Draw the row.
  $C70E,$08 Put both row counts back to #N$08.
  $C716,$01 Return.

c $C717 Test Block Row
@ $C717 label=TestBlockRow
D $C717 Tests a row against the view, using the position in the alternate
. registers. A row on the drawable page, with its column below #N$C1, is
. drawn by #R$C72E when it is before the patched row, or by #R$C704 when it
. is on that row. A row past it is left undrawn.
E $C717 Continue on to #R$C72E.
R $C717 HL The first coordinate of the position
R $C717 DE The second coordinate of the position
  $C717,$05 Take the position from the alternate registers.
  $C71C,$04 Return unless the row is on the drawable page.
  $C720,$04 Return when the column is past #N$C0.
  $C724,$04 Return unless the other address is on the same page.
  $C728,$05 A row on the patched position is the short row.
  $C72D,$01 A row past that position is left undrawn.

c $C72E Draw Block Row Data
@ $C72E label=DrawBlockRowData
D $C72E Finds the tile for a row in the table at #N$666E, flips it with #R$C522
. when its top bit differs, and draws it with #R$C76D. A row size of #N$10 is
. drawn at once. Any other size is given a limit of the column plus #N$10.
E $C72E Continue on to #R$C76D.
@ $C72E label=TestBlockRow_Draw
N $C72E The column offset is four times the row, less #N$07. The tile index and
. its top bit are patched, as they are for #R$C59A.
  $C72E,$06 The column offset is four times the row, less #N$07.
  $C734,$01 Keep the column.
@ $C735 label=DrawBlockRowData_Tile
  $C735,$07 Look the tile up. The index is patched.
  $C73C,$01 Add the index.
  $C73D,$04 Read the tile address.
  $C741,$03 Compare the tile with the patched top bit.
  $C744,$03 Flip the tile when they differ.
  $C747,$05 Add the column offset to the tile address.
  $C74C,$01 Count the carry in the high byte.
@ $C74D label=DrawBlockRowData_Draw
  $C74D,$01 Move past the tile's flag.
  $C74E,$05 A row size of #N$10 is drawn as it stands.
  $C753,$01 Bring the column back.
  $C754,$02 Draw it now when the row size is #N$10.
  $C756,$01 Remember the tile.
  $C757,$05 The limit passed to the drawer is the column plus #N$10.
  $C75C,$01 Bring the column back.
  $C75D,$03 Draw the bytes.
  $C760,$01 Restore the tile.
  $C761,$07 Step on by four times the position byte.
  $C768,$03 Add that step.
@ $C76B label=DrawBlockRowData_Limit
  $C76B,$02 Use the patched limit. Drawing continues in #R$C76D.

c $C76D Draw Block Bytes
@ $C76D label=DrawBlockBytes
D $C76D Draws the bytes of a row of a block into the screen buffer. A column
. below #N$10 is off the view, and a column of #N$C0 is drawn only when bits
. 1-2 of #R$5CF0 are clear. The tile is read through the stack. Those bits
. clear draw the bytes plain, with #R$C59A(#N$C611); otherwise #R$B508 shifts
. them.
R $C76D A The column
R $C76D HL The address of the data
  $C76D,$03 A column below #N$10 is off the view.
  $C770,$01 Keep the column.
  $C771,$04 A column of #N$C0 needs the drawing flags.
  $C775,$03 Read the drawing flags.
  $C778,$02,b$01 Use bits 1-2 of the drawing flags.
  $C77A,$02 Draw when those bits are clear.
@ $C77C label=DrawBlockBytes_Return
  $C77C,$01 Leave a shifted column of #N$C0 undrawn.
@ $C77D label=DrawBlockBytes_Offset
  $C77D,$06 The byte offset is the column divided by eight.
  $C783,$04 Remember the stack pointer.
  $C787,$01 Read the tile through the stack.
  $C788,$03 Fetch the strip address.
  $C78B,$03 Add the byte offset to the strip.
  $C78E,$03 Read the drawing flags again.
  $C791,$02,b$01 Use bits 1-2 of the drawing flags.
  $C793,$05 Draw the plain bytes when those bits are clear.
  $C798,$01 Keep the strip address aside.
  $C799,$02 The shift selects the page of the shifted rows.
  $C79B,$03 Use the two-byte shifted rows.
  $C79E,$06 Give that routine to the shifted drawer.
  $C7A4,$01 Keep the page.
  $C7A5,$03 The shifted row count is #N$08.
  $C7A8,$01 Read the first screen byte.
  $C7A9,$03 Draw the shifted rows.

c $C7AC Draw Block Section
@ $C7AC label=DrawBlockSection
D $C7AC Draws a section of a block, once for each of the entities that overlap
. it. Purpose not yet known.
R $C7AC IX The overlapping item
  $C7AC,$02 #REGa is #N$00.
  $C7AE,$03 Subtract field #N$00 of the entity.
  $C7B1,$02 Jump to #R$C7AC(#N$C7B7) if the carry flag is reset.
  $C7B3,$04 Jump to #R$C7CA if it is below #N$F1.
@ $C7B7 label=DrawBlockSection_Skip
  $C7B7,$01 #REGb moves into #REGa.
  $C7B8,$03 Call #R$C76D.
  $C7BB,$03 Read the byte at #R$C7AC(#N$C7AD).
  $C7BE,$01 #REGa moves into #REGb.
  $C7BF,$03 Read field #N$00 of the entity.
  $C7C2,$03 Add the high byte of the x coordinate.
  $C7C5,$01 Subtract #REGb.
  $C7C6,$02 Subtract #N$11.
  $C7C8,$02 Jump to #R$C7DE if the carry flag is set.
@ $C7CA label=DrawBlockSection_Next
  $C7CA,$01 Bring back #REGhl.
  $C7CB,$03 Read field #N$06 of the other entity into #REGc.
  $C7CE,$02 Shift #REGc left.
  $C7D0,$02 Shift #REGc left.
  $C7D2,$02 #REGb is #N$00.
  $C7D4,$01 #REGhl takes #REGbc.
  $C7D5,$03 Jump to #R$C72E(#N$C76B).
  $C7D8,$04 Jump to #R$C7CA if it is #N$10 or more.
  $C7DC,$02 Jump to #R$C7AC(#N$C7B7).
@ $C7DE label=DrawBlockSection_Return
  $C7DE,$01 Bring back #REGhl.
  $C7DF,$01 Return.

c $C7E0 Update View Flags
@ $C7E0 label=UpdateViewFlags
D $C7E0 Clears bits of the view flags at #R$5CE6 that are not set in #REGl.
R $C7E0 L The bits to keep
  $C7E0,$03 Read the byte at #R$5CE6.
  $C7E3,$01 Keep only the bits of #REGa that are set in #REGl.
  $C7E4,$03 Write #REGa at #R$5CE6.
  $C7E7,$01 Return.

c $C7E8 Scroll View Down
@ $C7E8 label=ScrollViewDown
D $C7E8 Scrolls the view down by eight rows when the player has moved towards
. the top of the view. The rows of the screen buffer are moved down with
. #R$C857, the new rows at the top are cleared with #R$C861, the view is moved
. with #R$B8F9 and the objects that have come into view are drawn using
. #R$C108.
R $C7E8 IX The player entity
N $C7E8 Check whether the player is near enough to the top of the view for the
. view to scroll down. If it is not, and the view is not part way through a
. scroll, stop scrolling.
  $C7E8,$04 Fetch the scroll position, which is #N$10 when the view is at rest
. and keep it in #REGc.
  $C7EC,$04 Fetch the row of the player on the screen and keep it in #REGd.
  $C7F0,$04 Jump to #R$C7FC if the player is near the top of the view.
  $C7F4,$01 Fetch the scroll position.
  $C7F5,$02 Set the bits of the view flags to keep, to clear the scroll bits.
  $C7F7,$05 Jump to #R$C7E0 to clear the scroll bits of the view flags if the
. view is at rest.
@ $C7FC label=ScrollViewDown_Speed
N $C7FC Work out how fast to scroll from the change in the row of the player on
. the screen. If the player is moving up then the view scrolls down faster.
  $C7FC,$03 Fetch the view flags.
  $C7FF,$02,b$01 Clear bits 4-5.
  $C801,$01 Keep them in #REGl.
  $C802,$03 Fetch the change in the row of the player.
  $C805,$01 Double it.
  $C806,$02 Jump to #R$C80F if the player is not moving up.
  $C808,$01 Use the doubled change as the amount to scroll.
  $C809,$04 Set bits 4-5 of the flags.
  $C80D,$02 Jump to #R$C815.
@ $C80F label=ScrollViewDown_Slowest
  $C80F,$02 Scroll by the slowest amount, #N$FE.
  $C811,$04 Set bit 4 of the flags.
@ $C815 label=ScrollViewDown_SetFlags
  $C815,$04 Store the view flags.
  $C819,$05 Add the amount to scroll to the scroll position.
  $C81E,$02 Jump to #R$C824 unless the scroll position is zero.
  $C820,$02 Set the scroll position back to #N$10.
  $C822,$02 Jump to #R$C829.
@ $C824 label=ScrollViewDown_CheckWrap
  $C824,$02 Test bit 7 of the scroll position.
  $C826,$01 Return if it has not gone below zero, as the view is not ready to
. move by a whole row of the buffer.
  $C827,$02,b$01 Keep the low four bits as the new scroll position.
@ $C829 label=ScrollViewDown_MoveRows
  $C829,$03 Store the scroll position.
N $C82C Move the view down by eight rows. The player moves down the screen by
. eight rows, the buffer is moved down, and the eight rows at the top are
. cleared and drawn again.
  $C82C,$03 Fetch the row of the player on the screen.
  $C82F,$02 Add #N$08.
  $C831,$03 Store it.
  $C834,$03 Store it as the last row of the player.
  $C837,$03 Point #REGhl at the end of the rows to be moved in the buffer.
  $C83A,$02 Set the number of rows to #N$78.
  $C83C,$03 Move the rows of the buffer down.
  $C83F,$03 Point #REGhl at #R$E67B.
  $C842,$03 Clear the eight rows.
  $C845,$03 Set the distance to move the view origin, #N$0008.
  $C848,$03 Move the view origin.
  $C84B,$03 Point #REGhl at the first rows of the buffer.
  $C84E,$03 Store it as the place to draw to.
  $C851,$03 Point #REGhl at #R$C108.
  $C854,$03 Draw the objects of the level in the strip.

c $C857 Move Rows Down
@ $C857 label=MoveRowsDown
D $C857 Copies #N$78 rows of the screen buffer downwards, by jumping into the
. code at #R$CB23.
R $C857 HL The address of the end of the rows to copy
R $C857 B The number of rows
  $C857,$04 Write #REGsp at #R$5CDA.
  $C85B,$03 #REGsp is #N$F1BB.
  $C85E,$03 Jump to #R$CB2E.

c $C861 Clear Rows
@ $C861 label=ClearRows
D $C861 Clears #N$C0 bytes, which are eight rows of the screen buffer, by
. pushing zeroes on the stack.
R $C861 HL The address of the end of the bytes to clear
  $C861,$04 Write #REGsp at #R$5CDA.
  $C865,$01 #REGhl moves into #REGsp.
  $C866,$02 #REGb is #N$60.
  $C868,$03 #REGde is #N$0000.
@ $C86B label=ClearRows_Loop
  $C86B,$01 Remember #REGde.
  $C86C,$02 Repeat from #R$C861(#N$C86B) while #REGb still counts.
  $C86E,$04 Fetch the word at #R$5CDA into #REGsp.
  $C872,$01 Return.

c $C873 Scroll View Up
@ $C873 label=ScrollViewUp
D $C873 Scrolls the view up by eight rows when the player has moved towards the
. bottom of the view. The rows of the screen buffer are moved up with #R$C8D9,
. the new rows at the bottom are cleared with #R$C861, the view is moved with
. #R$B8F9 and the objects that have come into view are drawn using #R$C119.
R $C873 IX The player entity
N $C873 Check whether the player is near enough to the bottom of the view for
. the view to scroll up. If it is not, and the view is not part way through a
. scroll, stop scrolling.
  $C873,$04 Fetch the scroll position, which is #N$10 when the view is at rest
. and keep it in #REGc.
  $C877,$04 Fetch the row of the player on the screen and keep it in #REGd.
  $C87B,$04 Jump to #R$C887 if the player is near the bottom of the view.
  $C87F,$01 Fetch the scroll position.
  $C880,$02 Set the bits of the view flags to keep, to clear the scroll bits.
  $C882,$05 Jump to #R$C7E0 to clear the scroll bits of the view flags if the
. view is at rest.
@ $C887 label=ScrollViewUp_Speed
N $C887 Work out how fast to scroll from the change in the row of the player on
. the screen. If the player is moving down then the view scrolls up faster.
  $C887,$03 Fetch the view flags.
  $C88A,$02,b$01 Clear bits 6-7.
  $C88C,$01 Keep them in #REGl.
  $C88D,$03 Fetch the change in the row of the player.
  $C890,$01 Double it.
  $C891,$02 Jump to #R$C89C if the player is not moving.
  $C893,$02 Jump to #R$C89C if the player is moving up.
  $C895,$01 Use the doubled change as the amount to scroll.
  $C896,$04 Set bits 6-7 of the flags.
  $C89A,$02 Jump to #R$C8A2.
@ $C89C label=ScrollViewUp_Slowest
  $C89C,$02 Scroll by the slowest amount, #N$02.
  $C89E,$04 Set bit 6 of the flags.
@ $C8A2 label=ScrollViewUp_SetFlags
  $C8A2,$04 Store the view flags.
  $C8A6,$02 Add the amount to scroll to the scroll position.
  $C8A8,$03 Store the scroll position.
  $C8AB,$02 Test bit 5 of the scroll position.
  $C8AD,$01 Return if it has not gone past #N$20, as the view is not ready to
. move by a whole row of the buffer.
  $C8AE,$02 Take away #N$10 from the scroll position.
  $C8B0,$03 Store it.
N $C8B3 Move the view up by eight rows. The player moves up the screen by eight
. rows, the buffer is moved up, and the eight rows at the bottom are cleared and
. drawn again.
  $C8B3,$03 Fetch the row of the player on the screen.
  $C8B6,$02 Take away #N$08.
  $C8B8,$03 Store it.
  $C8BB,$03 Store it as the last row of the player.
  $C8BE,$03 Set the distance to move the view origin, #N$FFF8.
  $C8C1,$03 Move the view origin.
  $C8C4,$03 Move the rows of the buffer up.
  $C8C7,$03 Point #REGhl at the last rows of the buffer.
  $C8CA,$03 Clear the eight rows.
  $C8CD,$03 Point #REGhl at the last rows of the buffer.
  $C8D0,$03 Store it as the place to draw to.
  $C8D3,$03 Point #REGhl at the routine that draws the objects in the bottom
. strip.
  $C8D6,$03 Draw the objects of the level in the strip.

c $C8D9 Move Rows Up
@ $C8D9 label=MoveRowsUp
D $C8D9 Copies #N$78 rows of the screen buffer upwards, by jumping into the code
. at #R$C9C9.
  $C8D9,$04 Write #REGsp at #R$5CDA.
  $C8DD,$02 #REGb is #N$78.
  $C8DF,$03 Set #REGsp to #R$E5BB(#N$E67B).
  $C8E2,$03 Point #REGhl at #R$E5BB.
  $C8E5,$03 Jump to #R$C9D4.

c $C8E8 Scroll View Left
@ $C8E8 label=ScrollViewLeft
D $C8E8 Scrolls the view to the left when the player has moved towards the right
. of the view. The buffer is shifted with one of the routines in the table at
. #R$C9C3, the view is moved with #R$C99E and the objects that have come into
. view are drawn using #R$C0E1.
R $C8E8 IX The player entity
N $C8E8 Check whether the player is near enough to the right of the view for the
. view to scroll to the left. If it is not, stop scrolling.
  $C8E8,$04 Fetch the scroll position along the view and keep it in #REGc.
  $C8EC,$04 Fetch the column of the player on the screen and keep it in #REGd.
  $C8F0,$02 Compare it with #N$68.
  $C8F2,$02 Set the bits of the view flags to keep, to clear the scroll bits.
  $C8F4,$03 Jump to #R$C7E0 if the player is not near the right of the view.
N $C8F7 Choose the speed to scroll at, which is two pixels a frame when the
. player is near the edge of the view and one pixel a frame otherwise.
  $C8F7,$02 Set the speed to two pixels.
  $C8F9,$03 Fetch the view flags.
  $C8FC,$02,b$01 Keep the scroll left bits.
  $C8FE,$04 Jump to #R$C909 if the view is not already scrolling at two
. pixels.
  $C902,$01 Fetch the column of the player.
  $C903,$04 Jump to #R$C913 to slow down to one pixel if the player is not as
. far across as that.
  $C907,$02 Keep the speed at two pixels.
@ $C909 label=ScrollViewLeft_CheckPhase
  $C909,$01 Fetch the scroll position.
  $C90A,$02,b$01 Keep the low two bits.
  $C90C,$02 Slow down to one pixel if it is part way through a pixel step.
  $C90E,$01 Fetch the column of the player.
  $C90F,$04 Jump to #R$C914 to keep the speed at two pixels if the player is
. that far across.
@ $C913 label=ScrollViewLeft_OnePixel
  $C913,$01 Slow down to one pixel.
@ $C914 label=ScrollViewLeft_Scroll
  $C914,$01 Save the speed.
N $C915 When the view has scrolled by another sixteen pixels, draw the objects
. that have come into view along the right edge of the buffer.
  $C915,$03 Point #REGhl at the right of the first row of the buffer.
  $C918,$03 Store it as the place to draw to.
  $C91B,$03 Point #REGhl at the routine that draws the objects in the right
. strip.
  $C91E,$01 Fetch the scroll position.
  $C91F,$02,b$01 Keep the low four bits.
  $C921,$03 Draw the objects of the level in the strip if it is a multiple of
. sixteen.
  $C924,$01 Restore the speed.
N $C925 Move the view along by the speed and note it in the view flags.
  $C925,$03 Move the origin of the view.
  $C928,$01 Fetch the speed.
  $C929,$02 Halve it.
  $C92B,$01 Keep it in #REGe.
  $C92C,$01 Add one, to make the scroll left value of the flags.
  $C92D,$01 Copy it into #REGb.
  $C92E,$03 Fetch the view flags.
  $C931,$02,b$01 Clear the scroll left bits.
  $C933,$01 Set the new scroll left value.
  $C934,$03 Store the view flags.
  $C937,$03 Point #REGhl at the table of routines that shift the buffer to the
. left.
  $C93A,$03 Shift the buffer.

c $C93D Scroll View Right
@ $C93D label=ScrollViewRight
D $C93D Scrolls the view to the right when the player has moved towards the left
. of the view. The buffer is shifted with one of the routines in the table at
. #R$C998, the view is moved with #R$C9A0 and the objects that have come into
. view are drawn using #R$C0F0.
R $C93D IX The player entity
N $C93D Check whether the player is near enough to the left of the view for the
. view to scroll to the right. If it is not, stop scrolling.
  $C93D,$04 Fetch the scroll position along the view and keep it in #REGc.
  $C941,$04 Fetch the column of the player on the screen and keep it in #REGd.
  $C945,$02 Compare it with #N$40.
  $C947,$02 Set the bits of the view flags to keep, to clear the scroll bits.
  $C949,$03 Jump to #R$C7E0 if the player is not near the left of the view.
N $C94C Choose the speed to scroll at, which is two pixels a frame when the
. player is near the edge of the view and one pixel a frame otherwise.
  $C94C,$02 Set the speed to two pixels, negative as the view moves the other
. way.
  $C94E,$03 Fetch the view flags.
  $C951,$02,b$01 Keep the scroll right bits.
  $C953,$04 Jump to #R$C95E if the view is not already scrolling at two
. pixels.
  $C957,$01 Fetch the column of the player.
  $C958,$04 Jump to #R$C968 to slow down to one pixel if the player is further
. across than that.
  $C95C,$02 Keep the speed at two pixels.
@ $C95E label=ScrollViewRight_CheckPhase
  $C95E,$01 Fetch the scroll position.
  $C95F,$02,b$01 Keep the low two bits.
  $C961,$02 Slow down to one pixel if it is part way through a pixel step.
  $C963,$01 Fetch the column of the player.
  $C964,$04 Jump to #R$C969 to keep the speed at two pixels if the player is
. that far across.
@ $C968 label=ScrollViewRight_OnePixel
  $C968,$01 Slow down to one pixel.
@ $C969 label=ScrollViewRight_Scroll
  $C969,$01 Save the speed.
N $C96A When the view has scrolled by another sixteen pixels, draw the objects
. that have come into view along the left edge of the buffer.
  $C96A,$03 Point #REGhl at the left of the first row of the buffer.
  $C96D,$03 Store it as the place to draw to.
  $C970,$03 Point #REGhl at the routine that draws the objects in the left
. strip.
  $C973,$01 Fetch the scroll position.
  $C974,$02,b$01 Keep the low four bits.
  $C976,$03 Draw the objects of the level in the strip if it is a multiple of
. sixteen.
  $C979,$01 Restore the speed.
N $C97A Move the view along by the speed and note it in the view flags.
  $C97A,$02 Make the amount to move the origin of the view negative.
  $C97C,$03 Move the origin of the view.
  $C97F,$01 Fetch the speed.
  $C980,$02 Make it positive.
  $C982,$02 Halve it.
  $C984,$01 Keep it in #REGe.
  $C985,$01 Add one.
  $C986,$02 Shift it left twice, to make the scroll right value of the flags.
  $C988,$01 Copy it into #REGb.
  $C989,$03 Fetch the view flags.
  $C98C,$02,b$01 Clear the scroll right bits.
  $C98E,$01 Set the new scroll right value.
  $C98F,$03 Store the view flags.
  $C992,$03 Point #REGhl at the table of routines that shift the buffer to the
. right.
  $C995,$03 Shift the buffer.

w $C998 Shift Right Table
@ $C998 label=ShiftRightTable
D $C998 The addresses of the routines that shift the screen buffer to the right,
. which are used by #R$C93D. They shift by a nibble, a byte and a pair of
. pixels.
W $C998,$06,$06

c $C99E Adjust View Origin
@ $C99E label=AdjustViewOrigin
D $C99E Adds an amount to the origin of the view, which is held in #R$5CE2,
. #R$5CE2(#N$5CE4) and #R$5CE7, and changes the scroll position at #R$5CF0 to
. suit.
R $C99E E The amount
R $C99E D The high byte of the amount, which is cleared by this entry point
  $C99E,$02 The amount is a single byte.
@ $C9A0 label=AdjustViewOrigin_Signed
  $C9A0,$07 Add the amount to the first origin.
  $C9A7,$07 Add the amount to the second origin.
  $C9AE,$08 Add the amount twice to the view origin.
  $C9B6,$0C The scroll flags move the other way, by twice the amount.
  $C9C2,$01 Return.

w $C9C3 Shift Left Table
@ $C9C3 label=ShiftLeftTable
D $C9C3 The addresses of the routines that shift the screen buffer to the left,
. which are used by #R$C8E8.
W $C9C3,$06,$06

c $C9C9 Shift View Left Byte
@ $C9C9 label=ShiftViewLeftByte
D $C9C9 Shifts the screen buffer to the left by one byte, by using the stack
. pointer to copy it. The part from #R$C9D4 is also used to move rows up by
. #R$C8D9.
  $C9C9,$03 Point #REGhl at the second byte of the screen buffer.
  $C9CC,$04 Save the stack pointer.
  $C9D0,$01 Point the stack at that byte.
  $C9D1,$01 Point #REGhl at the byte to its left.
  $C9D2,$02 Set the row count to #N$80.
@ $C9D4 label=ShiftViewLeftByte_Copy
  $C9D4,$3C Copy the twenty-four bytes of the next row from the stack.
  $CA10,$02 Decrease the row count and jump back until every row has been
. copied.
  $CA12,$04 Restore the stack pointer.
  $CA16,$01 Return.

c $CA17 Shift View Left Nibble
@ $CA17 label=ShiftViewLeftNibble
D $CA17 Shifts the screen buffer to the left by four pixels, by rotating the
. nibbles of each row.
  $CA17,$02 Set the row count to #N$80.
  $CA19,$03 Point #REGhl at the last byte of the screen buffer.
  $CA1C,$01 Clear the nibble shifted in from the right.
@ $CA1D label=ShiftViewLeftNibble_Loop
  $CA1D,$48 Shift the row four pixels to the left.
  $CA65,$01 Discard the nibble that fell off the left of the row.
  $CA66,$02 Decrease the row count and jump back until every row of the buffer
. has been shifted.
  $CA68,$01 Return.

c $CA69 Shift View Left Pixels
@ $CA69 label=ShiftViewLeftPixels
D $CA69 Shifts the screen buffer to the left by two pixels, by rotating the bits
. of each row through the stack.
  $CA69,$04 Save the stack pointer.
  $CA6D,$02 Set the row count to #N$80.
  $CA6F,$03 Point the stack at the last two bytes of the screen buffer.
@ $CA72 label=ShiftViewLeftPixels_Loop
  $CA72,$0F Shift the rightmost two bytes of the row two pixels to the left,
. filling the gap with blank pixels.
  $CA81,$8C Shift the middle twenty bytes of the row two pixels to the left.
  $CB0D,$0D Shift the leftmost two bytes two pixels to the left and step onto
. the next row.
  $CB1A,$04 Decrease the row count and jump back until every row of the buffer
. has been shifted.
  $CB1E,$04 Restore the stack pointer.
  $CB22,$01 Return.

c $CB23 Shift View Right Byte
@ $CB23 label=ShiftViewRightByte
D $CB23 Shifts the screen buffer to the right by one byte, by using the stack
. pointer to copy it. The part from #R$CB2E is also used to move rows down by
. #R$C857.
  $CB23,$04 Save the stack pointer.
  $CB27,$03 Point #REGhl at the last two bytes of the screen buffer.
  $CB2A,$01 Point the stack at them.
  $CB2B,$01 Skip those two bytes, which the shift overwrites.
  $CB2C,$02 Set the row count to #N$80.
@ $CB2E label=ShiftViewRightByte_Copy
  $CB2E,$3C Copy the twenty-four bytes of the next row onto the stack, walking
. backwards.
  $CB6A,$02 Decrease the row count and jump back until every row has been
. copied.
  $CB6C,$04 Restore the stack pointer.
  $CB70,$01 Return.

c $CB71 Shift View Right Nibble
@ $CB71 label=ShiftViewRightNibble
D $CB71 Shifts the screen buffer to the right by four pixels, by rotating the
. nibbles of each row.
  $CB71,$02 Set the row count to #N$80.
  $CB73,$03 Point #REGhl at #R$E5BB.
@ $CB76 label=ShiftViewRightNibble_Loop
  $CB76,$49 Clear the nibble shifted in from the left and shift the row four
. pixels to the right.
  $CBBF,$02 Decrease the row count and jump back until every row of the buffer
. has been shifted.
  $CBC1,$01 Return.

c $CBC2 Shift View Right Pixels
@ $CBC2 label=ShiftViewRightPixels
D $CBC2 Shifts the screen buffer to the right by two pixels, by rotating the
. bits of each row through the stack.
  $CBC2,$04 Save the stack pointer.
  $CBC6,$03 Point the stack at the first byte of the screen buffer.
  $CBC9,$02 Set the row count to #N$80.
@ $CBCB label=ShiftViewRightPixels_Loop
  $CBCB,$01 Clear the pixels shifted in from the left of the row.
  $CBCC,$0D Shift the leftmost two bytes of the row two pixels to the right.
  $CBD9,$8F Shift the other twenty-two bytes two pixels to the right and step
. onto the next row.
  $CC68,$04 Decrease the row count and jump back until every row of the buffer
. has been shifted.
  $CC6C,$04 Restore the stack pointer.
  $CC70,$01 Return.

c $CC71 Scroll View
@ $CC71 label=ScrollView
D $CC71 Scrolls the view if the player has moved too close to one of its edges.
. The view is scrolled to the left or right first, with #R$C8E8 or #R$C93D,
. and then up or down, with #R$C7E8 or #R$C873.
R $CC71 IX The player entity
  $CC71,$04 Fetch the view flags and keep them in #REGc.
  $CC75,$02,b$01 Keep the scroll left bits.
  $CC77,$02 Jump to #R$CC89 if the view is already scrolling left.
  $CC79,$03 Fetch the column of the player on the screen.
  $CC7C,$04 Jump to #R$CC8E if the player is not that far to the right.
  $CC80,$03 Fetch the view flags.
  $CC83,$02,b$01 Clear the scroll left bits.
  $CC85,$01 Set them to one pixel a frame.
  $CC86,$03 Store the view flags.
@ $CC89 label=ScrollView_Left
  $CC89,$03 Scroll the view to the left.
  $CC8C,$02 Jump to the vertical scroll.
@ $CC8E label=ScrollView_Right
  $CC8E,$01 Fetch the view flags kept in #REGc.
  $CC8F,$02,b$01 Keep the scroll right bits.
  $CC91,$02 Jump to #R$CCA2 if the view is already scrolling right.
  $CC93,$03 Fetch the column of the player on the screen.
  $CC96,$04 Jump to #R$CCA5 if the player is not that far to the left.
  $CC9A,$01 Fetch the view flags kept in #REGc.
  $CC9B,$02,b$01 Clear the scroll right bits.
  $CC9D,$02 Set them to one pixel a frame.
  $CC9F,$03 Store the view flags.
@ $CCA2 label=ScrollView_ScrollRight
  $CCA2,$03 Scroll the view to the right.
@ $CCA5 label=ScrollView_Vertical
  $CCA5,$04 Fetch the view flags and keep them in #REGc.
  $CCA9,$02,b$01 Keep the scroll down bits.
  $CCAB,$03 Scroll the view down if it is already scrolling down.
  $CCAE,$03 Fetch the row of the player on the screen.
  $CCB1,$05 Jump to #R$C7E8 to scroll the view down if the player is near the
. top of the view.
  $CCB6,$01 Fetch the view flags kept in #REGc.
  $CCB7,$02,b$01 Keep the scroll up bits.
  $CCB9,$03 Scroll the view up if it is already scrolling up.
  $CCBC,$03 Fetch the row of the player on the screen.
  $CCBF,$02 Compare it with #N$61.
  $CCC1,$01 Return if the player is not near the bottom of the view.
  $CCC2,$03 Scroll the view up.

c $CCC5 Update Direction Gauge
@ $CCC5 label=UpdateDirectionGauge
D $CCC5 Sets the heading shown by the direction gauge, which is the heading of
. the player plus #N$08, and redraws the gauge with #R$A724.
R $CCC5 IX The player entity
  $CCC5,$03 Fetch the heading.
  $CCC8,$02 Add #N$08.
  $CCCA,$02,b$01 Use bits 0-5.
  $CCCC,$03 Write #REGa at #R$5CD8.
  $CCCF,$03 Jump to #R$A724.

c $CCD2 Settle Player
@ $CCD2 label=SettlePlayer
D $CCD2 Updates the player entity with #R$D037, with its speed set to zero and
. its heading flag cleared, and then restores the speed. The entry point at
. #R$CCD2 goes on to set the player to frame #N$03 at #R$CDE3, the entry point
. at #R$CD0B goes on to the end of the player update at #R$CDF8 and the entry
. point at #R$CCD8 returns.
R $CCD2 IX The player entity
  $CCD2,$06 Settle the player, then set its frame.
@ $CCD8 label=SettlePlayer_Update
  $CCD8,$04 Remember the vertical speed.
  $CCDC,$07 Remember the speed and the speed fraction.
  $CCE3,$04 Remember the drift.
  $CCE7,$11 Clear the speed, the drift and the vertical speed, and stop moving.
  $CCF8,$03 Move the player.
  $CCFB,$04 Put the drift back.
  $CCFF,$07 Put the speed and the speed fraction back.
  $CD06,$04 Put the vertical speed back.
  $CD0A,$01 Return.
@ $CD0B label=SettlePlayer_Continue
  $CD0B,$06 Settle the player, then finish the update.

c $CD11 Run Frame
@ $CD11 label=RunFrame
D $CD11 Runs one frame of the game. First the timers are updated and then the
. player is controlled, updated and projected. The view is scrolled, the other
. entities are updated, and then the draw list is built, sorted and drawn.
. Finally the messages are updated.
D $CD11 The counter in #R$5D00 is used for the player jumping and for the death
. of the player. Purpose of its values is not yet known.
N $CD11 Count down the timer, if it is running.
  $CD11,$03 Fetch the countdown timer.
  $CD14,$01 Test it.
  $CD15,$02 Jump to #R$CD1B if it has stopped.
  $CD17,$04 Decrease the timer by one and store it.
@ $CD1B label=RunFrame_Gauge
N $CD1B Drain the first gauge by #N$10 and redraw it. If it has run out then the
. player bursts, provided that it is still the player.
  $CD1B,$03 Fetch the target of the first gauge.
  $CD1E,$03 Set the amount to drain, #N$0010.
  $CD21,$03 Take the amount away.
  $CD24,$02 Jump to #R$CD32 if the gauge has run out.
  $CD26,$03 Store the new target of the gauge.
  $CD29,$04 Point #REGix at #R$A59D.
  $CD2D,$03 Move the bar of the gauge one step towards its target.
  $CD30,$02 Jump to #R$CD3F.
@ $CD32 label=RunFrame_Burst
  $CD32,$03 Fetch the type of the player entity.
  $CD35,$01 Decrease it by one.
  $CD36,$02 Jump to #R$CD3F if it is not of type #N$01.
  $CD38,$04 Point #REGix at #R$B540.
  $CD3C,$03 Burst the player.
@ $CD3F label=RunFrame_Spawn
N $CD3F Update the points where creatures appear, on every fourth frame.
  $CD3F,$03 Fetch the frame counter.
  $CD42,$02,b$01 Use bits 0-1.
  $CD44,$03 Update the spawn points if this is a fourth frame.
@ $CD47 label=RunFrame_Player
N $CD47 Control the player, if it is still an entity of type #N$01. Animate it,
. and update the direction gauge if the heading has changed.
  $CD47,$04 Point #REGix at #R$B540.
  $CD4B,$03 Fetch the type of the player entity.
  $CD4E,$01 Decrease it by one.
  $CD4F,$03 Jump to #R$CE00 if the player is not of type #N$01.
  $CD52,$03 Read the controls and turn or speed up the player.
  $CD55,$03 Animate the player.
  $CD58,$03 Fetch the heading of the player.
  $CD5B,$03 Find which bits of it have changed since the heading that is shown
. on the gauge.
  $CD5E,$02,b$01 Keep the bits that give the direction.
  $CD60,$03 Update the direction gauge if the heading has changed.
@ $CD63 label=RunFrame_Counter
N $CD63 Count the frames of the counter at #R$5D00, if it is running. Purpose of
. its values from #N$01 to #N$05 is not yet known; the player is held still for
. them, and the values from #N$F0 on are the player landing.
  $CD63,$03 Fetch the counter.
  $CD66,$01 Test it.
  $CD67,$02 Jump to #R$CD82 if it is not running.
  $CD69,$01 Add one to the counter.
  $CD6A,$03 Store it.
  $CD6D,$04 Jump to #R$CDCC if the player is landing.
  $CD71,$05 Jump to #R$CCD2 to settle the player and set the landing frame if
. it is #N$02.
  $CD76,$02 Take away #N$05.
  $CD78,$02 Settle the player if the counter is not at #N$05.
  $CD7A,$03 Stop the counter.
  $CD7D,$03 Play the short rising sweep.
  $CD80,$02 Jump to #R$CD8D.
@ $CD82 label=RunFrame_Ground
N $CD82 Move the player. If it is on the ground then it is not animated.
  $CD82,$06 Jump to #R$CD8D if it is not on the ground.
  $CD88,$03 Move the player.
  $CD8B,$02 Jump to #R$CDF8.
@ $CD8D label=RunFrame_Update
  $CD8D,$03 Fetch the height of the player above the ground before it moves.
  $CD90,$01 Stash it on the stack.
  $CD91,$03 Move the player.
  $CD94,$01 Restore the old height.
  $CD95,$03 Read field #N$1E of the player.
  $CD98,$02,b$01 Use bits 0-5.
  $CD9A,$02 Jump to #R$CDF8 if any of them are set.
  $CD9C,$03 Fetch the new height of the player above the ground.
  $CD9F,$01 Test it.
  $CDA0,$02 Jump to #R$CDC2 if the player is on the ground.
N $CDA2 Choose the frame of the player from its height above the ground.
  $CDA2,$02 Use frame #N$02 if the player is lower than it was.
  $CDA4,$01 Compare the new height with the old height.
  $CDA5,$02 Jump to #R$CDE5 if it is lower.
  $CDA7,$02 Use frame #N$03 if the height is less than #N$04.
  $CDA9,$04 Jump to #R$CDE5 if the height is below #N$04.
  $CDAD,$02 Use frame #N$01 if the height is less than #N$0C.
  $CDAF,$04 Jump to #R$CDE5 if the height is below #N$0C.
  $CDB3,$01 Use frame #N$02 if the height is less than #N$10.
  $CDB4,$04 Jump to #R$CDE5 if the height is below #N$10.
  $CDB8,$02 Use frame #N$04 if the height is less than #N$16.
  $CDBA,$04 Jump to #R$CDE5 if the height is below #N$16.
  $CDBE,$02 Otherwise use frame #N$02.
  $CDC0,$02 Jump to #R$CDE5.
@ $CDC2 label=RunFrame_Still
N $CDC2 The player is on the ground. If it was in the air a moment ago it has
. just landed, so start the counter at #N$F0.
  $CDC2,$01 Combine the old height with the new height.
  $CDC3,$02 Jump to #R$CDF8 if the player was already on the ground.
  $CDC5,$02 Start the counter for the player landing.
  $CDC7,$03 Store it.
  $CDCA,$02 Jump to #R$CDCF.
@ $CDCC label=RunFrame_Fall
  $CDCC,$03 Move the player.
@ $CDCF label=RunFrame_Frame
N $CDCF Choose the frame of the player from the counter of the landing, which is
. frame #N$01 until the counter reaches #N$F2 and then frame #N$03. The counter
. is stopped after #N$F3.
  $CDCF,$02 Use frame #N$01.
  $CDD1,$03 Fetch the counter.
  $CDD4,$04 Jump to #R$CDE5 if it is lower.
  $CDD8,$02 Use frame #N$03.
  $CDDA,$02 Take away #N$F3.
  $CDDC,$02 Jump to #R$CDE5 if the landing has not finished.
  $CDDE,$03 Stop the counter.
  $CDE1,$02 Jump to #R$CDE5.
@ $CDE3 label=RunFrame_Land
  $CDE3,$02 Use frame #N$03.
@ $CDE5 label=RunFrame_SetFrame
N $CDE5 Show the frame of the player, and set the size of its sprite, if it has
. changed.
  $CDE5,$03 Read field #N$01 of the player.
  $CDE8,$01 Keep it in #REGc.
  $CDE9,$02,b$01 Keep the number of the frame.
  $CDEB,$01 Compare it with the new frame.
  $CDEC,$02 Jump to #R$CDF8 if it has not changed.
  $CDEE,$01 Fetch the flags in field #N$01.
  $CDEF,$02,b$01 Keep the flags in bits 5-7.
  $CDF1,$01 Combine them with the new frame.
  $CDF2,$03 Store them.
  $CDF5,$03 Set the size of the sprite.
@ $CDF8 label=RunFrame_Entities
  $CDF8,$03 Read the byte at #R$5CDE.
  $CDFB,$02,b$01 Keep bit 4.
  $CDFD,$03 Create an entity of type #N$05 if the bit is set.
@ $CE00 label=RunFrame_Draw
N $CE00 Work out where the player is on the screen and scroll the view to follow
. it. Then update the entities and the extra records, build and sort the draw
. list, and draw it. If SPACE or CAPS SHIFT is pressed the game is paused here.
  $CE00,$03 Project the player on to the screen.
  $CE03,$04 Point #REGix at #R$B540.
  $CE07,$03 Scroll the view to follow the player.
  $CE0A,$03 Update the other entities.
  $CE0D,$03 Update the extra records.
  $CE10,$03 Build the draw list.
  $CE13,$03 Sort the draw list.
  $CE16,$03 Draw the items of the draw list.
  $CE19,$03 Pause the game if a key is pressed.
N $CE1C Print the message that is scrolling in or out, if there is one. It is
. printed in two parts, one of which is chosen by the state of the message.
  $CE1C,$03 Fetch the state of the message.
  $CE1F,$01 Test it.
  $CE20,$02 Jump to #R$CE39 if there is no message.
  $CE22,$03 Point #REGde at #R$CE5A.
  $CE25,$01 Decrease the state by one.
  $CE26,$02 Jump to #R$CE2B if it is the first message.
  $CE28,$03 Point #REGde at #R$CE72.
@ $CE2B label=RunFrame_Skip
  $CE2B,$03 Print the first part of the message.
  $CE2E,$03 Print the second part of the message.
  $CE31,$03 Fetch the state of the message.
  $CE34,$02 Halve it.
  $CE36,$03 Store it.
@ $CE39 label=RunFrame_Message
  $CE39,$03 Copy the screen buffer to the screen.
N $CE3C Check what has happened to the player.
  $CE3C,$03 Fetch the type of the player entity.
  $CE3F,$01 Test it.
  $CE40,$02 Jump to #R$CE4E if the player is still there.
  $CE42,$01 The player has gone, so set #REGa to #N$01.
  $CE43,$03 Store it to show that a life has been lost.
  $CE46,$03 Fetch the high byte of the target of the first gauge.
  $CE49,$01 Test it.
  $CE4A,$03 Show the time out message if the gauge is empty.
  $CE4D,$01 Return.
@ $CE4E label=RunFrame_Dead
  $CE4E,$03 Fetch the high byte of the x coordinate of the player.
  $CE51,$01 Test it.
  $CE52,$01 Return if it is zero, which is when the player has left the level.
  $CE53,$03 Put the rows of the screen buffer back.
  $CE56,$03 Run the next frame.

g $CE59 Exit Message Flag
@ $CE59 label=ExitMessageFlag
D $CE59 Controls the "EXIT CLOSED" message. When it is #N$02 the message is
. printed, and when it is #N$01 the message is blanked out. It is zero when
. there is no message.
B $CE59,$01,$01

b $CE5A Exit Closed Messages
@ $CE5A label=ExitClosedMessages
D $CE5A The text that is printed by #R$CD11. The first two are blanks, to
. remove the message.
B $CE5A,$02 Position: x=#N$60, y=#N$87.
B $CE5C,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $CE5D,$01 Length #N$08.
B $CE5E,$08 "        "
B $CE66,$02 Position: x=#N$60, y=#N$8F.
B $CE68,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $CE69,$01 Length #N$08.
B $CE6A,$08 "        "
@ $CE72 label=ExitClosedMessages_Second
B $CE72,$02 Position: x=#N$70, y=#N$87.
B $CE74,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $CE75,$01 Length #N$04.
B $CE76,$04 "EXIT"
B $CE7A,$02 Position: x=#N$68, y=#N$8F.
B $CE7C,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $CE7D,$01 Length #N$06.
B $CE7E,$06 "CLOSED"

c $CE84 Update Extra Records
@ $CE84 label=UpdateExtraRecords
D $CE84 Updates the extra record of each of the entities, with #R$B7CE. If the
. entity is in use, is not of type #N$05, #N$0D or #N$0E, and is in view, its
. screen position is stored in the first two bytes of its extra record, and bit
. 7 of field #N$09 of the extra record is set to show that it is visible.
  $CE84,$04 Point #REGiy at the first extra record.
  $CE88,$04 Point #REGix at #R$B540.
  $CE8C,$02 Set the number of entities to #N$0C.
@ $CE8E label=UpdateExtraRecords_Loop
  $CE8E,$04 Mark the extra record as not in use.
  $CE92,$01 Save the entity count.
  $CE93,$02 Save the entity.
  $CE95,$03 Fetch the type of the entity.
  $CE98,$01 Test it.
  $CE99,$02 Jump to #R$CED3 if the entity is not in use.
  $CE9B,$04 Jump to #R$CED3 if the entity is a puff.
  $CE9F,$04 Jump to #R$CED3 if the entity is a sparkle.
  $CEA3,$04 Jump to #R$CED3 if the entity is a shot.
  $CEA7,$04 Jump to #R$CEB5 unless the entity is a pickup.
  $CEAB,$04 Reset bit 6 of field #N$1E of the pickup.
  $CEAF,$03 Fetch the low byte of the z coordinate.
  $CEB2,$01 Test it.
  $CEB3,$02 Jump to #R$CED3 if it is zero.
@ $CEB5 label=UpdateExtraRecords_Skip
  $CEB5,$03 Set up the extra record from the entity.
  $CEB8,$02 Jump to #R$CED3 if the record was not set up.
  $CEBA,$03 Work out the screen position of the entity.
  $CEBD,$06 Jump to #R$CED3 if the entity is hidden.
  $CEC3,$03 Fetch the column of the entity on the screen.
  $CEC6,$03 Store it in the first byte of the extra record.
  $CEC9,$03 Fetch the row of the entity on the screen.
  $CECC,$03 Store it in the second byte of the extra record.
  $CECF,$04 Mark the extra record as in use.
@ $CED3 label=UpdateExtraRecords_Next
  $CED3,$02 Restore the entity.
  $CED5,$03 Set the size of an entity to #N$26.
  $CED8,$02 Move on to the next entity.
  $CEDA,$02 Set the size of an extra record to #N$0D.
  $CEDC,$02 Move on to the next extra record.
  $CEDE,$01 Restore the entity count.
  $CEDF,$02 Decrease it and jump back until every entity has been updated.
  $CEE1,$01 Return.

c $CEE2 Update Entities
@ $CEE2 label=UpdateEntities
D $CEE2 Updates each of the entities that are not the player, or all of them if
. the player is not of type #N$01. An entity that is of type #N$0C or #N$10 is
. always kept. Any other entity is checked every eighth frame and is removed if
. it is a long way out of view. The entity is animated with #R$AF48 and then
. the routine for its type is run, using the table at #R$993D.
  $CEE2,$04 Point #REGix at the entity after the player.
  $CEE6,$02 Set the number of entities to #N$0B, leaving out the player.
  $CEE8,$03 Fetch the type of the player.
  $CEEB,$01 Compare it with the player type, #N$01.
  $CEEC,$02 Jump to #R$CEF3 if the player is still a player.
  $CEEE,$04 Point #REGix at #R$B540.
  $CEF2,$01 Include the player in the count.
@ $CEF3 label=UpdateEntities_Loop
  $CEF3,$01 Save the entity count.
  $CEF4,$03 Fetch the type of the entity.
  $CEF7,$01 Test it.
  $CEF8,$02 Jump to #R$CF46 if the entity is not in use.
  $CEFA,$01 Save the type.
  $CEFB,$04 Jump to #R$CF1D if the entity is a disc.
  $CEFF,$04 Jump to #R$CF1D if the entity is a spider.
  $CF03,$03 Fetch the frame counter.
  $CF06,$02,b$01 Keep the low three bits.
  $CF08,$02 Jump to #R$CF1D unless this is every eighth frame.
  $CF0A,$03 Set the margin to #N$20.
  $CF0D,$03 Test whether the entity is within the view.
  $CF10,$02 Jump to #R$CF1D if it is within the view.
  $CF12,$04 Hide the entity.
  $CF16,$04 Remove the entity.
  $CF1A,$01 Restore the type.
  $CF1B,$02 Jump to the next entity.
@ $CF1D label=UpdateEntities_Animate
  $CF1D,$03 Animate the entity.
  $CF20,$10 Jump to the update routine for the type of the entity.

c $CF30 Update Entity
@ $CF30 label=UpdateEntity
D $CF30 The routine for the types #N$01, #N$02 and #N$03 of entity, which is
. also jumped to by the routines for other types. Moves the entity with
. #R$D037, with the entity flagged as moving, and then projects it with
. #R$AE0D if it is still in use.
E $CF30 Continue on to #R$CF46.
R $CF30 IX The entity
  $CF30,$03 Fetch the type of the entity.
  $CF33,$01 Test it.
  $CF34,$02 Jump to #R$CF44 if the entity is not in use.
  $CF36,$04 Flag the entity as moving.
@ $CF3A label=UpdateEntity_Move
  $CF3A,$03 Move the entity.
@ $CF3D label=UpdateEntity_Project
  $CF3D,$03 Fetch the type of the entity.
  $CF40,$01 Test it.
  $CF41,$03 Work out the screen position if the entity is still in use.
@ $CF44 label=UpdateEntity_Done
  $CF44,$02 Restore the entity.

c $CF46 Update Next Entity
@ $CF46 label=UpdateNextEntity
D $CF46 Moves on to the next entity in #R$CEE2.
  $CF46,$03 Set the size of an entity to #N$26.
  $CF49,$02 Move on to the next entity.
  $CF4B,$01 Restore the entity count.
  $CF4C,$02 Decrease it and jump back until every entity has been updated.
  $CF4E,$01 Return.

c $CF4F Add Displacement
@ $CF4F label=AddDisplacement
D $CF4F Adds a signed displacement to a position that is held in three bytes.
R $CF4F HL The displacement
R $CF4F C The top byte of the position
R $CF4F DE The bottom two bytes of the position
R $CF4F O:C The new top byte
R $CF4F O:HL The new bottom two bytes
  $CF4F,$04 Jump to #R$CF4F(#N$CF57) if the zero flag is reset.
  $CF53,$01 #REGhl takes #REGde.
  $CF54,$01 Return if the carry flag is reset.
  $CF55,$01 Advance #REGc.
  $CF56,$01 Return.
@ $CF57 label=AddDisplacement_Skip
  $CF57,$01 #REGhl takes #REGde.
  $CF58,$01 Return if the carry flag is set.
  $CF59,$01 Step #REGc back.
  $CF5A,$01 Return.

c $CF5B Scale Displacement
@ $CF5B label=ScaleDisplacement
D $CF5B Works out the displacement of an entity along an axis. The high byte of
. the speed word at #R$5CEA is multiplied by the value in #REGbc, which is part
. of a direction vector, and divided by #N$10. The sign is taken from #REGb.
R $CF5B BC The part of the direction vector
R $CF5B O:HL The displacement
  $CF5B,$03 Fetch the word at #R$5CEA into #REGhl.
  $CF5E,$01 Remember #REGbc.
  $CF5F,$01 #REGh moves into #REGd.
  $CF60,$03 Call #R$CF7E.
  $CF63,$02 Shift #REGh right.
  $CF65,$02 Rotate #REGl right through the carry flag.
  $CF67,$02 Shift #REGh right.
  $CF69,$02 Rotate #REGl right through the carry flag.
  $CF6B,$02 Shift #REGh right.
  $CF6D,$02 Rotate #REGl right through the carry flag.
  $CF6F,$02 Shift #REGh right.
  $CF71,$02 Rotate #REGl right through the carry flag.
  $CF73,$01 Bring back #REGbc.
  $CF74,$01 Advance #REGb.
  $CF75,$01 Return if the zero flag is reset.
  $CF76,$01 #REGl moves into #REGa.
  $CF77,$01 Invert the bits of #REGa.
  $CF78,$01 #REGa moves into #REGl.
  $CF79,$01 #REGh moves into #REGa.
  $CF7A,$01 Invert the bits of #REGa.
  $CF7B,$01 #REGa moves into #REGh.
  $CF7C,$01 Advance #REGhl.
  $CF7D,$01 Return.

c $CF7E Multiply
@ $CF7E label=Multiply
D $CF7E Multiplies the byte in #REGd by the byte in #REGc.
R $CF7E D One byte
R $CF7E C The other byte
R $CF7E O:HL The product
N $CF7E The byte in #REGd is multiplied by the byte in #REGc. Eight bits are
. tested, and each bit that is set adds the shifted byte into the product.
  $CF7E,$07 The product starts at zero, with eight bits to test.
  $CF85,$02 Test the first bit.
@ $CF87 label=Multiply_Loop
  $CF87,$01 One fewer bit remains.
  $CF88,$01 The product is ready.
  $CF89,$04 Shift the other byte up.
@ $CF8D label=Multiply_Bit
  $CF8D,$02 The next bit of the byte.
  $CF8F,$02 This bit adds nothing.
  $CF91,$01 Add the shifted byte into the product.
  $CF92,$03 The next bit.

c $CF95 Limit Displacement
@ $CF95 label=LimitDisplacement
D $CF95 Limits the displacement of the player to less than #N$09C0, if the
. player is in a certain range of positions. Purpose not yet known.
R $CF95 HL The displacement
R $CF95 IX The entity
R $CF95 O:HL The limited displacement
  $CF95,$03 Fetch the column.
  $CF98,$04 Jump to #R$CF95(#N$CF9F) if it is #N$84 or more.
  $CF9C,$02 Compare #REGa with #N$25.
  $CF9E,$01 Return if the carry flag is reset.
@ $CF9F label=LimitDisplacement_Skip
  $CF9F,$03 #REGde is #N$09C0.
  $CFA2,$02 Subtract #REGde from #REGhl. (with the carry)
  $CFA4,$01 Return if the carry flag is reset.
  $CFA5,$01 #REGhl takes #REGde.
  $CFA6,$01 Return.

c $CFA7 Update Drift
@ $CFA7 label=UpdateDrift
D $CFA7 Adds the amount in #REGa to the drift in field #N$20. Bits 0-1 are the
. amount and bit 2 makes it negative. A zero amount is handled by #R$D014.
. An eighth of the resulting drift is added to the displacement in #REGhl,
. which is then clamped to the limit in the high nibble of #REGb.
R $CFA7 A The amount, in bits 0-1, with bit 2 for the direction
R $CFA7 HL The displacement
R $CFA7 IX The entity
R $CFA7 O:HL The limited displacement
  $CFA7,$01 Keep the amount aside.
  $CFA8,$02,b$01 Use bits 0-1 as the amount.
  $CFAA,$03 A zero amount is handled by the decay.
  $CFAD,$01 Double the amount.
  $CFAE,$04 Bit 2 of the original amount makes it negative.
  $CFB2,$02 Negate the amount.
@ $CFB4 label=UpdateDrift_Apply
  $CFB4,$01 Keep the amount.
  $CFB5,$03 Read the drift.
  $CFB8,$03 Use bits 0-6 of the drift.
  $CFBB,$02,b$01 Use the low five bits as its magnitude.
  $CFBD,$06 The top bit makes that magnitude negative.
  $CFC3,$02 Negate the magnitude.
@ $CFC5 label=UpdateDrift_Add
  $CFC5,$01 Add the amount to the drift.
  $CFC6,$04 A negative result flips the sign.
  $CFCA,$04 Negate it and set the sign.
@ $CFCE label=UpdateDrift_Cap
  $CFCE,$02,b$01 Use the low five bits as the new magnitude.
  $CFD0,$01 Keep the new magnitude.
  $CFD1,$03 Shift the old limit down.
  $CFD4,$02,b$01 Use bits 3-4 as that limit.
  $CFD6,$04 Keep the new magnitude when it is within the limit.
@ $CFDA label=UpdateDrift_Store
  $CFDA,$03 Use the sign and the old limit bits.
  $CFDD,$04 Combine them with the magnitude and keep the drift.
  $CFE1,$03 A negative drift is subtracted from the displacement.
  $CFE4,$04 Negate the magnitude.
@ $CFE8 label=UpdateDrift_Shift
  $CFE8,$0F Add an eighth of the drift to the displacement.
  $CFF7,$05 Shift the limit in #REGb down by four.
  $CFFC,$02,b$01 Use the low four bits as the limit.
  $CFFE,$02 Keep the limit.
  $D000,$05 A negative displacement is clamped to it.
  $D005,$03 Compare the displacement with the negative limit.
  $D008,$01 Leave it when it is inside the limit.
  $D009,$04 Clamp the displacement to that limit.
@ $D00D label=UpdateDrift_Positive
  $D00D,$02 A positive displacement is cleared only when the limit is zero.
  $D00F,$05 Clear the displacement.

c $D014 Decay Drift
@ $D014 label=DecayDrift
D $D014 Moves the drift of an entity, which is held in field #N$20, one step
. towards zero.
R $D014 HL The displacement
R $D014 IX The entity
  $D014,$03 Read the drift.
  $D017,$02,b$01 Use the magnitude in the low five bits.
  $D019,$01 The drift is already zero.
  $D01A,$01 Remember the displacement.
  $D01B,$02 The nudge is one.
  $D01D,$06 A negative drift is nudged the other way.
  $D023,$02 The nudge is minus one.
@ $D025 label=DecayDrift_Nudge
  $D025,$03 Nudge the drift.
  $D028,$07 The nudge crossed zero when the signs differ.
  $D02F,$05 Clear the drift and restore the displacement.
  $D034,$01 Return.
@ $D035 label=DecayDrift_Keep
  $D035,$01 Keep the updated displacement.
  $D036,$01 Return.

c $D037 Move Entity
@ $D037 label=MoveEntity
D $D037 Moves an entity for one frame, which is used for all of the types of
. entity that move. The entity is moved along its heading by the speed in fields
. #N$12-#N$15, changed by its direction vector from #R$A6EB, and the vertical
. speed in fields #N$12 and #N$13 is applied to the height. Purpose of the
. individual steps is not yet known.
R $D037 IX The entity
N $D037 Return if the entity is not in use, and hand over to #R$D202 if it is
. following a path.
  $D037,$03 Fetch the type of the entity.
  $D03A,$01 Test it.
  $D03B,$01 Return if the entity is not in use.
  $D03C,$03 Fetch the first byte of the path of the entity.
  $D03F,$03 Combine it with the second byte.
  $D042,$03 Jump to #R$D202 to follow the path if the entity has one.
N $D045 Return if the sprite of the entity has not been set up, and note whether
. the entity is fast.
  $D045,$03 Fetch the width of the sprite.
  $D048,$02,b$01 Use bits 4-7.
  $D04A,$01 Return if any of them are set.
  $D04B,$03 Fetch the height of the sprite.
  $D04E,$02,b$01 Use bits 6-7.
  $D050,$01 Return if any of them are set.
  $D051,$03 Fetch the speed of the entity.
  $D054,$02 Subtract #N$50.
  $D056,$02 Jump to #R$D05E if the speed is at least #N$50.
  $D058,$04 Clear bit 7 of the flags of the entity.
  $D05C,$02 Jump to #R$D062.
@ $D05E label=MoveEntity_Fast
  $D05E,$04 Set bit 7 of the flags of the entity.
N $D062 Copy the position of the entity into the code that tests its collisions
. and the code at the end of this routine, which use it as the position that the
. entity started the frame at.
@ $D062 label=MoveEntity_Position
  $D062,$06 Fetch the x coordinate of the entity.
  $D068,$03 Store it in the collision code.
  $D06B,$06 Fetch the y coordinate of the entity.
  $D071,$03 Store it in the collision code.
  $D074,$06 Fetch the z coordinate of the entity.
  $D07A,$03 Store it in the instruction at #R$D037(#N$D1F4), as the height that
. the entity started the frame at.
N $D07D Change the speed of the entity. If the entity is not moving then the
. speed falls, and if it is moving then the speed rises, one step at a time, to
. the maximum.
  $D07D,$04 Test bit 7 of the heading of the entity.
  $D081,$03 Fetch the fraction of the speed.
  $D084,$02 Jump to #R$D0AE if the entity is moving.
  $D086,$03 Subtract the rate of change from the fraction.
  $D089,$03 Store the fraction.
  $D08C,$03 Jump to #R$D0DD if there was no step down.
  $D08F,$04 Fetch the speed of the entity and keep it in #REGb.
  $D093,$02,b$01 Keep the maximum speed in bits 4-7.
  $D095,$01 Keep it in #REGe.
  $D096,$01 Fetch the speed again.
  $D097,$02,b$01 Keep the current speed in bits 0-3.
  $D099,$02 Take one away.
  $D09B,$02 Jump to #R$D0A4 if the speed was zero already.
  $D09D,$01 Add the maximum speed.
  $D09E,$03 Store the new speed.
  $D0A1,$03 Jump to #R$D0DD.
@ $D0A4 label=MoveEntity_ZeroSpeed
  $D0A4,$03 Store the maximum speed as the speed, with the current speed zero.
  $D0A7,$04 Set the fraction of the speed to #N$00.
  $D0AB,$03 Jump to #R$D0DD.
@ $D0AE label=MoveEntity_Moving
  $D0AE,$03 Add the rate of change to the fraction.
  $D0B1,$03 Store the fraction.
  $D0B4,$03 Fetch the speed of the entity.
  $D0B7,$02 Jump to #R$D0C8 if there was a step up.
  $D0B9,$01 Fetch the speed again.
  $D0BA,$04 Move the maximum speed down to bits 0-3.
  $D0BE,$01 Compare it with the current speed.
  $D0BF,$02,b$01 Use bits 0-3.
  $D0C1,$02 Jump to #R$D0DD if the current speed has not reached the maximum.
  $D0C3,$03 Set the fraction of the speed to zero.
  $D0C6,$02 Jump to #R$D0DD.
@ $D0C8 label=MoveEntity_StepUp
  $D0C8,$01 Fetch the speed.
  $D0C9,$02,b$01 Keep the maximum speed in bits 4-7.
  $D0CB,$01 Keep it in #REGe.
  $D0CC,$04 Move the maximum speed down to bits 0-3...
  $D0D0,$01 ...and keep it in #REGc.
  $D0D1,$01 Fetch the speed again.
  $D0D2,$02,b$01 Keep the current speed in bits 0-3.
  $D0D4,$01 Add one.
  $D0D5,$01 Compare it with the maximum speed.
  $D0D6,$02 Jump to #R$D0D9 if it is below the maximum.
  $D0D8,$01 Limit it to the maximum.
@ $D0D9 label=MoveEntity_StoreSpeed
  $D0D9,$01 Add the maximum speed in bits 4-7.
  $D0DA,$03 Store the new speed.
N $D0DD Change the vertical speed of the entity by its acceleration, limit it,
. and move the entity up or down by it.
@ $D0DD label=MoveEntity_Speed
  $D0DD,$06 Fetch the vertical speed of the entity.
  $D0E3,$06 Fetch the acceleration of the entity.
  $D0E9,$04 Combine the four bytes.
  $D0ED,$03 Jump to #R$D12C if the entity is neither moving vertically nor
. accelerating.
  $D0F0,$01 Add the acceleration to the vertical speed.
  $D0F1,$04 Jump to #R$D104 if the entity is moving down.
  $D0F5,$03 Fetch the limit of the vertical speed from field #N$1C.
  $D0F8,$02,b$01 Use bits 0-3.
  $D0FA,$01 Take one away.
  $D0FB,$01 Compare it with the high byte of the vertical speed.
  $D0FC,$02 Jump to #R$D111 if the speed is within the limit.
  $D0FE,$01 Add one back.
  $D0FF,$01 Limit the vertical speed to the limit...
  $D100,$02 ...with no fraction.
  $D102,$02 Jump to #R$D111.
@ $D104 label=MoveEntity_Falling
  $D104,$03 Fetch the limit of the vertical speed from field #N$1C.
  $D107,$02,b$01 Use bits 0-3.
  $D109,$01 Make it negative, for moving down.
  $D10A,$01 Compare it with the high byte of the vertical speed.
  $D10B,$02 Jump to #R$D111 if the speed is within the limit.
  $D10D,$01 Add one back.
  $D10E,$01 Limit the vertical speed to the limit...
  $D10F,$02 ...with no fraction.
@ $D111 label=MoveEntity_Height
  $D111,$06 Store the vertical speed.
  $D117,$09 Fetch the z coordinate of the entity.
  $D120,$03 Add the vertical speed to the z coordinate.
  $D123,$09 Store the new z coordinate.
N $D12C Set the entity going in the direction that it is heading. If the heading
. has changed, centre the entity within its cell on each axis.
@ $D12C label=MoveEntity_Heading
  $D12C,$03 Fetch the heading that the entity had.
  $D12F,$02,b$01 Use bits 0-5.
  $D131,$01 Keep it in #REGb.
  $D132,$03 Fetch the heading of the entity.
  $D135,$02,b$01 Use bits 0-5.
  $D137,$01 Compare it with the old heading.
  $D138,$02 Jump to #R$D142 if it has not changed.
  $D13A,$04 Set the fraction of the x coordinate to #N$7F.
  $D13E,$04 Set the fraction of the y coordinate to #N$7F.
@ $D142 label=MoveEntity_StoreHeading
  $D142,$01 Keep the heading in #REGb.
  $D143,$03 Fetch the old heading, with its flag.
  $D146,$02,b$01 Keep bit 6.
  $D148,$01 Combine it with the heading.
  $D149,$03 Store it as the heading that the entity has.
N $D14C Work out the distance to move, from the speed, and the amount of it
. along each axis from the direction vector of the heading.
  $D14C,$03 Fetch the speed of the entity into #REGh...
  $D14F,$03 ...and the fraction of the speed into #REGl.
  $D152,$04 Multiply the speed by sixteen.
  $D156,$03 Fetch the type of the entity.
  $D159,$01 Take one away.
  $D15A,$03 Limit the distance if the entity is the player.
  $D15D,$03 Store the distance.
  $D160,$03 Fetch the heading of the entity.
  $D163,$03 Get the direction vector of the heading.
  $D166,$01 Keep the first part of the vector.
  $D167,$01 Switch to the alternate registers.
  $D168,$01 Take the first part of the vector off the stack.
  $D169,$03 Work out the displacement along the x axis.
  $D16C,$03 Fetch the type of the entity.
  $D16F,$01 Take one away.
  $D170,$02 Jump to #R$D17B unless the entity is the player.
  $D172,$03 Fetch the speed of the player.
  $D175,$03 Fetch the flags of the player, which hold the change of the drift.
  $D178,$03 Change the drift, and limit the displacement.
@ $D17B label=MoveEntity_First
  $D17B,$09 Fetch the x coordinate of the entity.
  $D184,$03 Add the displacement to the x coordinate.
  $D187,$09 Store the new x coordinate.
  $D190,$01 Switch to the alternate registers.
  $D191,$01 Save the displacement along the y axis.
  $D192,$01 Switch to the alternate registers.
  $D193,$01 Restore it into #REGbc.
  $D194,$03 Work out the displacement along the y axis.
  $D197,$03 Fetch the type of the entity.
  $D19A,$01 Take one away.
  $D19B,$02 Jump to #R$D1AD unless the entity is the player.
  $D19D,$03 Fetch the speed of the player.
  $D1A0,$03 Fetch the flags of the player, which hold the change of the drift.
  $D1A3,$03 Shift the part that is for the y axis down to bits 0-2.
  $D1A6,$02 Use the next field of the entity.
  $D1A8,$03 Change the drift, and limit the displacement.
  $D1AB,$02 Use the first field of the entity again.
@ $D1AD label=MoveEntity_Second
  $D1AD,$09 Fetch the y coordinate of the entity.
  $D1B6,$03 Add the displacement to the y coordinate.
  $D1B9,$09 Store the new y coordinate.
N $D1C2 Note that the entity has moved, and check what it has collided with.
  $D1C2,$03 Fetch the flags of the entity.
  $D1C5,$02,b$01 Use bits 6-7.
  $D1C7,$02,b$01 Set bit 6, to show that it has moved.
  $D1C9,$03 Store the flags.
  $D1CC,$04 Set field #N$1F of the entity to #N$FF.
  $D1D0,$04 Test bit 6 of the frame of the entity.
  $D1D4,$01 Return if it is set.
  $D1D5,$03 Fetch the type of the entity.
  $D1D8,$04 Jump to #R$D1E0 unless it is a shot.
  $D1DC,$04 Set the vertical speed of the shot to zero.
@ $D1E0 label=MoveEntity_TestCollisions
  $D1E0,$03 Test the collisions of the entity.
  $D1E3,$03 Fetch the type of the entity.
  $D1E6,$01 Test it.
  $D1E7,$01 Return if the entity has been removed.
  $D1E8,$02 Compare the type with #N$05.
  $D1EA,$02 Set the height to test to #N$FF.
  $D1EC,$02 Jump to #R$D1FB if the type is #N$05.
  $D1EE,$06 Fetch the z coordinate of the entity.
  $D1F4,$03 Set #REGde to the height that the entity started at, which is
. patched in.
  $D1F7,$02 Subtract it to find how far the entity has risen.
  $D1F9,$01 Take one away.
  $D1FA,$01 Keep the low byte.
@ $D1FB label=MoveEntity_TestCells
  $D1FB,$03 Store it in the code that tests the cells.
  $D1FE,$03 Test the cells that the entity is in.
  $D201,$01 Return.

c $D202 Follow Path
@ $D202 label=FollowPath
D $D202 Moves an entity that is following a path from the level data, which is
. the case when fields #N$24 and #N$25 are not both zero. Bits 0-2 of field
. #N$25 choose a three-byte step from a table. Bits 6-7 of field #N$24 can
. replace that step: #N$40 lowers the entity and can play the long buzz,
. #N$80 moves it back along y, and #N$C0 moves it on along x. The three bytes
. of a looked-up step are added to x, y and z. A step above #N$08 finishes
. the path. The player can be scored and shown the filled cup, and a path
. position is then copied into the entity before the falling sweep plays.
R $D202 IX The entity
  $D202,$04 Clear the moving flag.
  $D206,$04 Clear the fast flag.
  $D20A,$03 Find the path entry.
  $D20D,$01 Remember the entry.
  $D20E,$03 Read the low byte of the path.
  $D211,$02,b$01 Keep the step number in bits 0-2.
  $D213,$02 Look the step up when a number is set.
  $D215,$02 Use the two bytes just before the entry.
  $D217,$02 Join the stored step.
@ $D219 label=FollowPath_Lookup
  $D219,$03 Turn the step number into a table offset.
  $D21C,$03 Look the offset up.
  $D21F,$05 Read the x step, the y step and the z step.
@ $D224 label=FollowPath_Step
  $D224,$03 Remember where the path continues.
  $D227,$03 Read the high byte of the path.
  $D22A,$02,b$01 Keep the nudge in bits 6-7.
  $D22C,$02 Use the looked-up step when there is no nudge.
  $D22E,$04 Lower the entity when the nudge is #N$40.
  $D232,$03 Read the low byte of the path again.
  $D235,$05 Play the long buzz when that byte is #N$40 as well.
  $D23A,$03 Clear the x step and the y step.
  $D23D,$02 Lower the entity by two.
  $D23F,$02 Add the step.
@ $D241 label=FollowPath_Nudge
  $D241,$05 Move the entity back along y, and clear the other steps.
  $D246,$04 Keep that nudge when the bits are #N$80.
  $D24A,$03 Move the entity on along x instead.
@ $D24D label=FollowPath_Z
  $D24D,$06 Fetch the z coordinate.
  $D253,$07 Sign-extend the z step.
@ $D25A label=FollowPath_AddZ
  $D25A,$07 Add the z step to the z coordinate.
  $D261,$08 Sign-extend the x step.
@ $D269 label=FollowPath_X
  $D269,$06 Fetch the x coordinate.
  $D26F,$07 Add the x step to the x coordinate.
  $D276,$08 Sign-extend the y step.
@ $D27E label=FollowPath_Y
  $D27E,$06 Fetch the y coordinate.
  $D284,$07 Add the y step to the y coordinate.
N $D28B A step above #N$08 finishes the path. A step of exactly #N$08, or a
. step number that no longer matches the entry, reads the next path byte.
  $D28B,$01 Restore the path entry.
  $D28C,$08 A step of #N$08 reads the next path byte.
  $D294,$02 A larger step finishes the path.
  $D296,$03 Read field #N$25 again.
  $D299,$02,b$01 Use the step number.
  $D29B,$02 Compare it with the byte before the entry.
  $D29D,$03 Read the next path byte when they differ.
  $D2A0,$03 Read field #N$24.
  $D2A3,$02,b$01 Use bits 6-7 of the path.
  $D2A5,$02 Copy the path position when those bits are clear.
  $D2A7,$06 Only the player finishes the path here.
  $D2AD,$06 Set the player's vertical speed to #N$2200.
  $D2B3,$03 Clear the jump counter.
  $D2B6,$03 Read the width byte.
  $D2B9,$02,b$01 Use the countdown nibble.
  $D2BB,$03 Clear the sprite width.
  $D2BE,$04 Clear the fraction of the speed.
@ $D2C2 label=FollowPath_Clear
  $D2C2,$04 Clear field #N$24.
@ $D2C6 label=FollowPath_Finish
  $D2C6,$04 Clear field #N$25 and return.
@ $D2CA label=FollowPath_Reward
N $D2CA The byte stored by #R$D389 chooses the player's reward. Zero scores
. #N$0500. Any other byte, the first time, scores #N$0060 and draws the cup.
  $D2CA,$06 Only the player is rewarded.
  $D2D0,$01 Switch to the reward byte.
  $D2D1,$05 Score #N$0500 when the path byte is zero.
  $D2D6,$06 Add a score of #N$0500.
  $D2DC,$02 Skip the cup.
@ $D2DE label=FollowPath_Cup
  $D2DE,$06 The cup is shown only once.
  $D2E4,$03 Read the player's animation counter.
  $D2E7,$02,b$01 Use the high nibble of the animation.
  $D2E9,$02,b$01 Set the low nibble to #N$05.
  $D2EB,$03 Keep that animation.
  $D2EE,$05 Set the control byte to #N$05.
  $D2F3,$06 Add a score of #N$0060.
  $D2F9,$09 Draw the filled cup.
  $D302,$05 Remember that the cup has been shown.
  $D307,$01 Switch back.
  $D308,$01 Step back to the path's position.
  $D309,$03 Read field #N$24.
  $D30C,$02,b$01 Use bits 0-5 of the path.
  $D30E,$05 Combine them with the path byte and keep them.
  $D313,$03 Read field #N$25.
  $D316,$02,b$01 Use the step number.
  $D318,$02,b$01 Mark the step with bit 5.
  $D31A,$03 Keep the marked step.
  $D31D,$1E Copy the path's coordinates into the entity.
  $D33B,$01 Bring the new path flags back.
  $D33C,$02,b$01 Use bits 6-7 of those flags.
  $D33E,$04 Place the entity on y unless the flags are #N$C0.
  $D342,$03 Read the low byte of y.
  $D345,$02,b$01 Use the high nibble of y.
  $D347,$02,b$01 Force the low nibble to #N$08.
  $D349,$03 Keep that y position.
  $D34C,$0D Shift x by half of #N$10 less the x extent.
  $D359,$02 Join the falling sweep.
@ $D35B label=FollowPath_PlaceX
  $D35B,$03 Read the low byte of x.
  $D35E,$02,b$01 Use the high nibble of x.
  $D360,$02,b$01 Force the low nibble to #N$08.
  $D362,$03 Keep that x position.
  $D365,$0D Shift y by half of #N$10 less the y extent.
  $D372,$03 Play the falling sweep.
@ $D375 label=FollowPath_Next
  $D375,$07 Read the next byte of the path table.
  $D37C,$04 Use it as field #N$25.
  $D380,$03 Read field #N$24.
  $D383,$02,b$01 Use bits 0-5 of the path.
  $D385,$03 Clear bits 6-7 of the path.
  $D388,$01 Return.
c $D389 Find Path Entry
@ $D389 label=FindPathEntry
D $D389 Finds the entry of the level data for the path of an entity. The entries
. are in a list that is found just before the level header at #R$5CFE.
R $D389 IX The entity
R $D389 O:HL The address in the entry
  $D389,$04 The list sits just before the level header.
  $D38D,$09 Twice bits 0-5 of field #N$24 select the entry.
  $D396,$03 Step back that far in the list.
  $D399,$03 The entry's address.
  $D39C,$04 Four bytes into the entry.
  $D3A0,$04 The reward byte, remembered for #R$D202.
  $D3A4,$04 Eight bytes further on is returned.
  $D3A8,$01 Return.

c $D3A9 Find Path At Position
@ $D3A9 label=FindPathAtPosition
D $D3A9 Looks through the entries of the level data, which are found just before
. the level header at #R$5CFE, for one whose position matches the position of
. the entity. If one is found the entity is set to follow it by setting fields
. #N$24 and #N$25.
R $D3A9 IX The entity
N $D3A9 The list is walked backwards from just before the level header. Each
. entry is a pointer to four position bytes. A match stores the index in
. field #N$24 and #N$48 in field #N$25.
  $D3A9,$06 The path list sits just before the level header.
  $D3AF,$02 The first index is #N$41.
@ $D3B1 label=FindPathAtPosition_Loop
  $D3B1,$01 Remember this point in the list.
  $D3B2,$03 Read the pointer to the entry's position.
  $D3B5,$03 Use that position.
  $D3B8,$08 The high byte of x has to match.
  $D3C0,$03 Read the low byte of x.
  $D3C3,$02,b$01 Use its high nibble.
  $D3C5,$05 That nibble has to match the entry.
  $D3CA,$08 The high byte of y has to match.
  $D3D2,$03 Read the low byte of y.
  $D3D5,$02,b$01 Use its high nibble.
  $D3D7,$05 That nibble has to match the entry.
  $D3DC,$03 The index becomes field #N$24.
  $D3DF,$04 Field #N$25 becomes #N$48.
  $D3E3,$02 Restore the list and return.
@ $D3E5 label=FindPathAtPosition_Next
  $D3E5,$04 Step back to the previous entry and take the next index.
  $D3E9,$02 Try that entry.

c $D3EB Test Entity Collisions
@ $D3EB label=TestEntityCollisions
D $D3EB Tests the entity against each of the other entities with #R$D47A.
. A puff and a shot are not tested. A player skips puffs and sparkles, and a
. saucer skips shots. A disc, a free slot and a hidden entity are skipped.
. The direction bytes are #N$20 during the tests. Afterwards the low bytes of
. x and y, relative to the patched origins, replace them for #R$D7E4. The
. step in #R$DDD5 is removed for the tests and then put back.
R $D3EB IX The entity
N $D3EB The direction bytes start at #N$20 so a hit during the tests has a
. neutral component. The type of this entity is patched into the skip below.
  $D3EB,$05 Mark the entity as only touching.
  $D3F0,$06 Remember this entity's type for the skips below.
  $D3F6,$04 A puff is not tested against the others.
  $D3FA,$04 A shot is not tested against the others.
  $D3FE,$08 Set both direction bytes to #N$20.
  $D406,$07 Clear the object flags and remove the move-back step.
  $D40D,$02 There are #N$0C entities.
  $D40F,$04 Start at the first entity.
@ $D413 label=TestEntityCollisions_Loop
  $D413,$01 Remember how many entities remain.
  $D414,$06 Skip an entity that is free.
  $D41A,$04 Skip a disc.
  $D41E,$04 The type patched above selects the next skips.
  $D422,$0D A player does not test a puff or a sparkle.
@ $D42F label=TestEntityCollisions_Saucer
  $D42F,$05 A saucer does not test a shot.
  $D434,$07 Skip the shot.
@ $D43B label=TestEntityCollisions_Frame
  $D43B,$03 Read the other entity's frame.
  $D43E,$02,b$01 Use bits 6 and 7 of the frame.
  $D440,$02 Skip an entity with either bit set.
  $D442,$06 It is not tested against itself.
  $D448,$06 Test the pair when the two entities differ.
@ $D44E label=TestEntityCollisions_Next
  $D44E,$05 Move on to the next entity.
  $D453,$01 Bring the count back.
  $D454,$02 Repeat for the remaining entities.
@ $D456 label=TestEntityCollisions_Finish
  $D456,$0F Keep the low byte of x relative to the patched origin.
  $D465,$0F Keep the low byte of y relative to the patched origin.
  $D474,$05 Put the step back into the move-back routine.
  $D479,$01 Return.

c $D47A Test Entity Pair
@ $D47A label=TestEntityPair
D $D47A Tests whether two entities overlap on x, then y, then z, using #R$D647.
. The three extents are fields #N$0B, #N$0C and #N$0D. The y test and the z
. test move #REGix so that those extents sit at the displacement the test
. reads. An overlap is stored at #R$DDCF for x, #R$DDCF(#N$DDD1) for y and
. #R$DDCF(#N$DDD3) for z. A puff with no width flags then scores, from the
. table at #R$D5BD, and becomes a sparkle. A whirler meeting the player, a
. spider and a shot all burst. A shot is then removed. A pickup is collected
. with #R$D5DF, and the player is moved clear with #R$DC75.
E $D47A Continue on to #R$D5AD.
R $D47A IX The entity that is being moved
R $D47A IY The other entity
  $D47A,$06 Fetch the other entity's x coordinate.
  $D480,$06 Fetch this entity's x coordinate.
  $D486,$03 Fetch the other entity's x extent.
  $D489,$03 Fetch this entity's x extent.
  $D48C,$03 Test the two x ranges.
  $D48F,$01 Return if the x ranges do not overlap.
  $D490,$04 Remember the x overlap.
  $D494,$06 Fetch the other entity's y coordinate.
  $D49A,$06 Fetch this entity's y coordinate.
  $D4A0,$03 Fetch the other entity's y extent.
  $D4A3,$03 Fetch this entity's y extent.
  $D4A6,$02 Aim the test at the y extent.
  $D4A8,$03 Test the two y ranges.
  $D4AB,$02 Restore the entity address.
  $D4AD,$01 Return if the y ranges do not overlap.
  $D4AE,$04 Remember the y overlap.
  $D4B2,$06 Fetch the other entity's z coordinate.
  $D4B8,$06 Fetch this entity's z coordinate.
  $D4BE,$07 Aim the test at the z extent.
  $D4C5,$03 Fetch the other entity's z extent.
  $D4C8,$03 Fetch this entity's z extent.
  $D4CB,$03 Test the two z ranges.
  $D4CE,$02 Restore the entity address.
  $D4D0,$01 Return if the z ranges do not overlap.
  $D4D1,$04 Remember the z overlap.
N $D4D5 A puff whose width flags are clear scores and becomes a sparkle.
  $D4D5,$07 Leave this reward unless the width flags are clear.
  $D4DC,$07 Score only when the other entity is a puff.
  $D4E3,$04 Use this entity's type as an index into the score table.
  $D4E7,$03 Take the score table.
  $D4EA,$03 Look the score up.
  $D4ED,$03 Read the score.
  $D4F0,$03 Add the score.
  $D4F3,$03 Start a burst.
  $D4F6,$04 Turn the puff into a sparkle.
  $D4FA,$04 Clear the sparkle's frame.
  $D4FE,$04 Set the sparkle's height to #N$08.
  $D502,$04 Set the sparkle's countdown to #N$04.
N $D506 Nothing else happens while the countdown timer is running. The other
. entity is in #REGiy.
  $D506,$05 Return while the countdown timer is running.
  $D50B,$03 Read the other entity's width byte.
  $D50E,$02,b$01 Use the countdown nibble.
  $D510,$02 Skip the whirler test when that nibble is set.
  $D512,$03 Read the other entity's type.
  $D515,$03 The other entity is the player.
  $D518,$07 A whirler bursts the player.
  $D51F,$02 Burst them.
@ $D521 label=TestEntityPair_Whirler
  $D521,$04 The other entity is a whirler.
  $D525,$04 This entity is the player.
  $D529,$02 Leave the pair when it is not.
@ $D52B label=TestEntityPair_Burst
  $D52B,$03 Burst the other entity.
  $D52E,$03 Finish bursting it.
@ $D531 label=TestEntityPair_Spider
  $D531,$08 A spider bursts.
  $D539,$07 A shot bursts and is removed.
  $D540,$03 Burst the shot.
  $D543,$04 Remove the shot.
  $D547,$04 Hide what remains of it.
@ $D54B label=TestEntityPair_Pickup
  $D54B,$08 A pickup is collected.
  $D553,$07 The player is moved clear of the overlap.
  $D55A,$04 A shot is collected from the other side.
  $D55E,$08 Swap the two entities.
  $D566,$03 Collect the item.
  $D569,$08 Swap the two entities back.
@ $D571 label=TestEntityPair_Clear
  $D571,$04 Clear the handled flag.
  $D575,$07 Reduce the z overlap by one.
  $D57C,$08 Reduce the x overlap by two.
  $D584,$08 Reduce the y overlap by two.
  $D58C,$07 Remember the flags and field #N$1F.
  $D593,$03 Move the entity clear of the overlap.
  $D596,$01 Bring the saved values back.
  $D597,$03 Restore field #N$1F.
  $D59A,$03 Use bit 6 of the saved flags.
  $D59D,$06 Keep that bit in the flags.
  $D5A3,$05 Return unless the patched kind is #N$0B.
  $D5A8,$05 Return unless the other entity is the player.
c $D5AD Burst Other Entity
@ $D5AD label=BurstOtherEntity
D $D5AD Bursts the other entity, by calling #R$9924 with #REGiy in place of
. #REGix.
R $D5AD IX The entity that is being moved
R $D5AD IY The other entity
  $D5AD,$02 Remember #REGix.
  $D5AF,$02 Remember #REGiy.
  $D5B1,$02 Bring back #REGix.
  $D5B3,$03 Call #R$9924.
  $D5B6,$02 Remember #REGix.
  $D5B8,$02 Bring back #REGiy.
  $D5BA,$02 Bring back #REGix.
  $D5BC,$01 Return.

b $D5BD Score Table
@ $D5BD label=ScoreTable
D $D5BD The points that are scored when the player hits an entity, in binary
. coded decimal and indexed by the type of the entity, which is doubled and
. added to #N$D5BB. The values are the highest two digits and the lowest two
. digits, as for #R$9662.
B $D5BD,$22,$02

c $D5DF Collect Item
@ $D5DF label=CollectItem
D $D5DF Deals with an entity touching an entity of the type #N$0F. Nothing
. happens while the counter in the high nibble of field #N$16 of the other
. entity is running, or while its frame (the low five bits of field #N$01) is
. below #N$04. Frames #N$04 and #N$05 burst the touching entity (see #R$9924)
. and free the other entity. Frames of #N$06 or more are collected if the
. touching entity is the player: #N$0100 points are added to the score and the
. other entity starts to disappear. Frame #N$07 also gives an extra life, which
. is printed, and plays the rising sweep. Frame #N$08 gives #N$0900 more points,
. and the other frames give #N$0150 more points and fill the first gauge.
. Purpose of the individual frames is not yet known.
R $D5DF IX The entity that is moved
R $D5DF IY The entity of type #N$0F
  $D5DF,$03 Read field #N$16 of the other entity.
  $D5E2,$02,b$01 Keep the counter in bits 4-7.
  $D5E4,$01 Return if the counter is running.
  $D5E5,$03 Fetch the frame of the other entity.
  $D5E8,$02,b$01 Keep the number of the frame.
  $D5EA,$02 Compare it with #N$04.
  $D5EC,$01 Return if the frame is lower.
  $D5ED,$04 Jump to #R$D5FD if the frame is #N$06 or more.
  $D5F1,$03 Burst the touching entity.
  $D5F4,$04 Free the other entity...
  $D5F8,$04 ...and hide it.
  $D5FC,$01 Return.
@ $D5FD label=CollectItem_Collect
  $D5FD,$03 Fetch the type of the touching entity.
  $D600,$01 Decrease it by one.
  $D601,$01 Return if it is not the player.
  $D602,$03 Set the points to #N$0100.
  $D605,$03 Add them to the score.
  $D608,$04 Start the counter in field #N$16 of the other entity.
  $D60C,$04 Set field #N$20 of the other entity to #N$0F.
  $D610,$03 Fetch the frame of the other entity.
  $D613,$02,b$01 Keep the number of the frame.
  $D615,$04 Jump to #R$D630 if it is not the frame that gives an extra life.
@ $D619 label=CollectItem_ExtraLife
  $D619,$03 Fetch the number of lives.
  $D61C,$01 Add one.
  $D61D,$03 Store it.
  $D620,$01 Take away one to find the number of lives that are to be shown.
  $D621,$03 Convert it into digits.
  $D624,$03 Store them in the text record of the lives.
  $D627,$03 Point #REGde at #R$E1A5.
  $D62A,$03 Print it.
  $D62D,$03 Jump to #R$9EB7.
@ $D630 label=CollectItem_Frame
  $D630,$04 Jump to #R$D63A if it is not that frame.
  $D634,$03 Set the points to #N$0900.
  $D637,$03 Jump to #R$9662.
@ $D63A label=CollectItem_Other
  $D63A,$03 Set the points to #N$0150.
  $D63D,$03 Add them to the score.
  $D640,$03 #REGhl is #N$6000, a full gauge.
  $D643,$03 Fill the first gauge.
  $D646,$01 Return.

c $D647 Test Overlap
@ $D647 label=TestOverlap
D $D647 Tests whether two ranges overlap. The carry is set when they do, and
. #REGl is the amount of the overlap. No overlap leaves the carry clear.
R $D647 HL The start of the first range
R $D647 DE The start of the second range
R $D647 B The size of the first range
R $D647 C The size of the second range
R $D647 O:F The carry flag is set if they overlap
R $D647 O:L The amount of the overlap
N $D647 #REGb is the size of the first range and #REGc the size of the second.
. The result is the smaller amount by which they cross.
  $D647,$03 Subtract the second start from the first.
  $D64A,$02 The second range starts first.
  $D64C,$02 No overlap when the starts are a byte or more apart.
  $D64E,$03 No overlap when the gap is at least the first size.
  $D651,$0A The overlap is the first size less that gap.
  $D65B,$03 Keep the smaller of the two amounts.
  $D65E,$02 Return that overlap.
@ $D660 label=TestOverlap_Overlap
  $D660,$04 Return the overlap that reached the other size.
@ $D664 label=TestOverlap_Before
  $D664,$04 Take the first size and clear the carry.
  $D668,$01 Remember where the ranges stood.
  $D669,$05 Add the second size to the first start.
  $D66E,$01 No overlap when the second size falls short.
  $D66F,$03 The ranges meet on an edge.
  $D672,$07 Measure how far the first range reaches back.
  $D679,$03 Keep the smaller of the two amounts.
  $D67C,$02 Return that overlap.
@ $D67E label=TestOverlap_Inside
  $D67E,$04 Return the overlap that reached the other size.

c $D682 Test Wide Overlap
@ $D682 label=TestWideOverlap
D $D682 Tests the entity against a block with #R$D6DC after widening the x and y
. edges by half the matching extent, less four. For the test, the edge path
. takes its size from #REGa, and a miss on z returns the distance instead of
. setting the flags to #N$FF. The edges and those two patches are put back.
R $D682 IX The entity
  $D682,$01 Remember the caller's count.
  $D683,$05 Make the edge path take its size from #REGa.
  $D688,$13 Widen the x edge by half the x extent, less four.
  $D69B,$11 Widen the y edge by half the y extent, less four.
  $D6AC,$0C A miss on z returns the distance instead of failing.
  $D6B8,$03 Test the widened block.
  $D6BB,$0C Put the edges and that branch back.
  $D6C7,$05 Put the edge path back to taking its size from #REGb.
  $D6CC,$01 Restore the caller's count.
  $D6CD,$01 Return.

c $D6CE Test Edge Overlap
@ $D6CE label=TestEdgeOverlap
D $D6CE Compares a patched position with a patched edge that has been moved
. back by four. The carry is set when the position is below that edge. #R$D8E4
. patches both operands before the call.
E $D6CE Continue on to #R$D6DC.
N $D6CE Both operands are patched before the call. The edge is moved back by
. four and the position is compared with it.
  $D6CE,$07 Move the patched edge back by four.
  $D6D5,$06 Subtract that edge from the patched position.
  $D6DB,$01 Return when the position is below the edge.

c $D6DC Test Block Overlap
@ $D6DC label=TestBlockOverlap
D $D6DC Tests the entity against one axis of a block. #R$D8E4 patches the two
. edges in first. Bit 6 of the object's flags selects the x edges and the x
. extent; otherwise the y edges and the y extent are used. The overlap is
. stored for that axis, and for the player the side is mixed into the flags.
. No overlap on z sets the flags to #N$FF.
R $D6DC IX The entity
R $D6DC IY The object
N $D6DC Bit 6 of the object's flags selects the axis. The two edges loaded
. below are patched by #R$D8E4.
  $D6DC,$03 Read the object's flags.
  $D6DF,$02,b$01 Use bit 6 of the flags.
  $D6E1,$02 Test the y edges when bit 6 is clear.
  $D6E3,$06 Take the patched x edges.
  $D6E9,$0B Scale the object's byte and use the x extent.
@ $D6F4 label=TestBlockOverlap_YAxis
  $D6F4,$06 Take the patched y edges.
  $D6FA,$03 Use the y extent.
  $D6FD,$03 Read the object's byte.
@ $D700 label=TestBlockOverlap_Size
  $D700,$01 Double that byte.
  $D701,$02,b$01 Use bits 4-6.
  $D703,$03 Add #N$10 to make the size.
  $D706,$03 Read the flags again.
  $D709,$02,b$01 Use bit 5 of the flags.
  $D70B,$02 Measure from the far edge when bit 5 is set.
  $D70D,$07 Subtract the near edge from the far edge plus the size.
  $D714,$02 The marker for that side is zero.
@ $D716 label=TestBlockOverlap_Edge
  $D716,$06 Subtract the near edge from the far edge plus the extent.
  $D71C,$02 The marker for that side is #N$04.
@ $D71E label=TestBlockOverlap_Mark
  $D71E,$03 Remember the marker.
  $D721,$02 Start with a count of two.
  $D723,$03 Read the flags.
  $D726,$02,b$01 Use bit 4 of the flags.
  $D728,$02 Halve the overlap when bit 4 is clear.
  $D72A,$05 Halve the overlap and count one.
@ $D72F label=TestBlockOverlap_Compare
  $D72F,$05 Add the edge address.
  $D734,$04 Subtract the z coordinate.
  $D738,$04 No overlap on z sets the flags to #N$FF.
  $D73C,$06 The overlap has to reach the stored z overlap.
  $D742,$04 An overlap below two clears the flags.
  $D746,$05 Remember an overlap of #N$FF.
  $D74B,$03 Read the flags.
  $D74E,$02,b$01 Use bit 6 of the flags.
  $D750,$03 The x test records the overlap on x.
  $D753,$03 Record the overlap on y.
  $D756,$05 Only the player records the side.
  $D75B,$04 Combine the marker with the count.
  $D75F,$03 Shift that side up by three.
  $D762,$01 Keep it for the flags.
  $D763,$02 Shift it up by two more.
  $D765,$02,b$01 Use bits 5-6.
  $D767,$01 Keep them for field #N$21.
  $D768,$03 Read the flags.
  $D76B,$02,b$01 Use the flag bits other than 3-5.
  $D76D,$04 Mix the side into the flags.
  $D771,$03 Read field #N$21.
  $D774,$02,b$01 Use the bits other than 5-6.
  $D776,$04 Mix the side into field #N$21.
  $D77A,$01 Return.
  $D77B,$05 Clear the flags when the overlap is too small.
  $D780,$03 Record the overlap on x.
  $D783,$05 Only the player records the side.
  $D788,$03 Combine the marker with the count.
  $D78B,$01 Keep it.
  $D78C,$03 Shift the side down by three.
  $D78F,$02,b$01 Use bits 5-6.
  $D791,$01 Keep them.
  $D792,$03 Read field #N$20.
  $D795,$02,b$01 Use the bits other than 5-6.
  $D797,$04 Mix the side into field #N$20.
  $D79B,$03 Read the flags.
  $D79E,$02,b$01 Use the top five bits of the flags.
  $D7A0,$04 Mix the count into the low bits of the flags.
  $D7A4,$01 Return.

c $D7A5 Flag Overlap
@ $D7A5 label=FlagOverlap
D $D7A5 Sets the flag at #R$5CD8 to #N$FF, to show that there is an overlap.
  $D7A5,$02 #REGa is #N$FF.
  $D7A7,$03 Write #REGa at #R$5CD8.
  $D7AA,$01 Return.

c $D7AB Get Overlap Distance
@ $D7AB label=GetOverlapDistance
D $D7AB Works out the distance that is needed to move out of an overlap. Purpose
. not yet known.
R $D7AB L The amount of the overlap
R $D7AB F The carry flag is set if there is an overlap
R $D7AB O:E The distance
  $D7AB,$02 #REGe is #N$FF.
  $D7AD,$01 Return if the carry flag is reset.
  $D7AE,$01 #REGl moves into #REGa.
  $D7AF,$02 Negate #REGa.
  $D7B1,$01 #REGa moves into #REGe.
  $D7B2,$01 Return.

b $D7B3 Object Flags Table
@ $D7B3 label=ObjectFlagsTable
D $D7B3 A table of flags for each kind of object, which is used by #R$D8E4 and
. #R$C15E. #R$C15E indexes it with the shape kind. Bit 7 clear draws the block
. as it is. Bits 5-6 clear mirror it, #N$20 draws it as it is, #N$40 raises
. it, and any other value moves the origin back by #N$10. The index used by
. #R$D8E4 is made from the object's type byte. Purpose of the other bits is
. not yet known.
B $D7B3,$31,$10

c $D7E4 Test Entity Cells
@ $D7E4 label=TestEntityCells
D $D7E4 Tests each cell of the level that the entity's box covers, by calling
. #R$D8E4, and retests a cell when a collision moves the entity. When bit 6 of
. the flags is set, a z within one page of #N$FF is stored in field #N$1F,
. after a zero top byte has been snapped up by one unit. A hit planted by
. #R$DC6A then turns the heading away from it. Purpose of bit 6 is not yet
. known.
R $D7E4 IX The entity
N $D7E4 The cell is the high byte of x and the high byte of y. A collision can
. move those bytes, and the extent can make the entity cover the next cell.
  $D7E4,$06 Take the cell from the high bytes of x and y.
  $D7EA,$04 Test that cell.
  $D7EE,$01 Restore the cell.
  $D7EF,$06 Retest the previous column when the high byte of x moved.
  $D7F5,$04 Use the column below the new x.
@ $D7F9 label=TestEntityCells_SpanX
  $D7F9,$08 The entity covers the next column when the x extent carries.
@ $D801 label=TestEntityCells_Second
  $D801,$05 Test the next column.
  $D806,$01 Restore the cell.
  $D807,$06 Retest this row when the high byte of y moved.
  $D80D,$09 Test the entity's row, then the row above.
@ $D816 label=TestEntityCells_SpanY
  $D816,$08 The entity covers the next row when the y extent carries.
  $D81E,$06 Test the next row.
@ $D824 label=TestEntityCells_Next
  $D824,$03 Test the diagonal cell too.
@ $D827 label=TestEntityCells_Moved
  $D827,$06 Use the entity's row when y has moved.
  $D82D,$03 Use that row.
@ $D830 label=TestEntityCells_SpanRow
  $D830,$08 Cover the next row when the y extent carries.
  $D838,$01 Use the next row.
@ $D839 label=TestEntityCells_Cell
  $D839,$03 Test this cell.
@ $D83C label=TestEntityCells_Snap
N $D83C Bit 6 of the flags stores a z that is within one page of #N$FF into
. field #N$1F. A zero top byte is snapped up by one unit first. A pickup
. stores zero instead.
  $D83C,$02 Start with no hit. #R$DC6A plants one in this byte.
  $D83E,$06 Snap z when bit 6 of the flags is set.
  $D844,$09 A zero top byte of z is snapped up by one unit.
  $D84D,$08 Write that snap back into z.
  $D855,$07 A pickup stores zero in field #N$1F.
  $D85C,$02 Otherwise measure from one.
@ $D85E label=TestEntityCells_Distance
  $D85E,$0A Store the distance when z is within one page of #N$FF.
@ $D868 label=TestEntityCells_Store
  $D868,$03 Remember that distance in field #N$1F.
@ $D86B label=TestEntityCells_Hit
N $D86B A hit turns the heading. Fields #N$18 and #N$19 supply the two
. components, and the low bits of the hit choose which axis is turned.
  $D86B,$03 Return when nothing was hit.
  $D86E,$05 Remember the hit and clear it.
  $D873,$05 Return when bit 5 of the frame is set.
  $D878,$07 Return when fields #N$18 and #N$19 are both zero.
  $D87F,$04 Return when the hit was #N$FF.
  $D883,$06 Use field #N$18 as one component.
  $D889,$03 Read the heading.
  $D88C,$02 Add #N$10 to the heading.
  $D88E,$02,b$01 Use the low six bits of the heading.
  $D890,$04 Use #N$FE when those bits are #N$20 or more.
  $D894,$02 Use #N$FE for that component.
@ $D896 label=TestEntityCells_Component
  $D896,$01 Keep the first component.
  $D897,$06 Use field #N$19 as the other component.
  $D89D,$03 Read the heading.
  $D8A0,$02,b$01 Use the low six bits of the heading.
  $D8A2,$04 Use #N$FE when those bits are #N$20 or more.
  $D8A6,$02 Use #N$FE for that component.
@ $D8A8 label=TestEntityCells_Other
  $D8A8,$01 Keep the second component.
  $D8A9,$03 Use the low two bits of the hit.
  $D8AC,$06 Swap the components when the hit was on x.
@ $D8B2 label=TestEntityCells_Swap
  $D8B2,$08 Turn the second component to face the other way.
  $D8BA,$01 Keep the first component.
@ $D8BB label=TestEntityCells_Heading
  $D8BB,$08 Face the patched step away from the first component.
  $D8C3,$04 Face the other way when the signs differ.
@ $D8C7 label=TestEntityCells_Signs
  $D8C7,$03 Compare the signs of the two components.
  $D8CA,$02 Keep the turn when the signs agree.
  $D8CC,$06 A positive turn is #N$01.
  $D8D2,$02 A negative turn is #N$FF.
@ $D8D4 label=TestEntityCells_Apply
  $D8D4,$03 Read the heading.
  $D8D7,$01 Keep the old heading aside.
  $D8D8,$01 Add the turn to the heading.
  $D8D9,$02,b$01 Use the low six bits of the new heading.
  $D8DB,$01 Keep the new heading aside.
  $D8DC,$03 Use bits 6-7 of the old heading.
  $D8DF,$04 Combine them with the new heading.
  $D8E3,$01 Return.

c $D8E4 Test Group Objects
@ $D8E4 label=TestGroupObjects
D $D8E4 Finds the group of objects at a cell of the level with #R$BA16 and then
. tests the entity against each of the objects, which are three bytes each.
. The low five bits of the group header are the number of objects. Objects of
. type #N$84, #N$86 and #N$06 are skipped. A solid block stops the entity.
. Type #N$81 is a bottle and is collected with #R$A3FE. Type #N$85 sets bit 1
. of #R$CE59, the exit-closed message, while #R$DEE0 is not zero. A type
. #N$83, and a type #N$85 once no bottles are left, is solid: the entity is
. pushed back to the edge and #R$D3A9 looks for a path there. Other objects are
. matched with #R$DC3F. The smaller gap is kept in field #N$1F and bit 6 of
. the flags is cleared. Purpose of that gap is not yet known.
R $D8E4 HL The position of the cell
R $D8E4 IX The entity
  $D8E4,$03 Remember the cell position.
  $D8E7,$03 Find the group of objects.
  $D8EA,$01 Return if this cell has no group.
  $D8EB,$04 Remember the cell offset.
  $D8EF,$01 Advance the high byte of the cell offset.
  $D8F0,$03 Read the group header.
  $D8F3,$02,b$01 Keep the object count.
  $D8F5,$01 Keep the object count aside.
  $D8F6,$04 Step on to the first object.
  $D8FA,$02,b$01 Test bit 4, which the count mask has already cleared.
  $D8FC,$02 Skip the extra step. This jump is always taken.
  $D8FE,$02 Step on another byte. This is not reached.
@ $D900 label=TestGroupObjects_Loop
  $D900,$02 Advance to the type byte of the object.
  $D902,$01 Remember the object count.
  $D903,$03 Read the type byte.
  $D906,$02,b$01 Keep the type bits.
  $D908,$05 Skip an object of type #N$84.
  $D90D,$05 Skip an object of type #N$86.
  $D912,$05 Skip an object of type #N$06.
  $D917,$01 Move bit 7 of the type into the carry flag.
  $D918,$02 Test the object when that bit is clear.
  $D91A,$02,b$01 Keep the shifted type bits.
  $D91C,$05 Skip an object whose shifted type is #N$1E.
@ $D921 label=TestGroupObjects_Player
  $D921,$07 On any other frame, or for any entity but the player, test the
. block below.
  $D928,$03 Read the frame counter.
  $D92B,$02,b$01 Act on every eighth frame.
  $D92D,$03 Leave this path on the other frames.
  $D930,$03 Read the type byte again.
  $D933,$02 Add three to the type.
  $D935,$02,b$01 Use bits 2 and 7 of the adjusted type.
  $D937,$05 Match the object when the result is #N$84.
@ $D93C label=TestGroupObjects_Block
N $D93C Build the object's x range from its first and third bytes, then test
. it against the x coordinate. A type of #N$82 uses a fixed size of #N$08.
  $D93C,$03 Fetch the word at #R$5CB8.
  $D93F,$03 Read the first byte of the object.
  $D942,$02,b$01 Keep the high nibble as the low byte of the range.
  $D944,$01 Keep that nibble as the low byte of the range.
  $D945,$03 Read the third byte of the object.
  $D948,$04 Shift that byte up by four bits.
  $D94C,$02,b$01 Use bits 4-6 as the size.
  $D94E,$02 Add the base size of #N$10.
  $D950,$01 Keep the size.
  $D951,$06 Fetch the x coordinate.
  $D957,$03 Read the type byte.
  $D95A,$01 Advance the type.
  $D95B,$02,b$01 Use bits 1, 2 and 7.
  $D95D,$04 Keep this size unless the type is #N$82.
  $D961,$02 Mark the fixed-size object.
  $D963,$02 Use a size of #N$08.
@ $D965 label=TestGroupObjects_XRange
  $D965,$04 Pass the x coordinate to the overlap test.
  $D969,$03 Pass the object's x range to the overlap test.
  $D96C,$03 Fetch the x extent.
  $D96F,$03 Test the two x ranges.
  $D972,$03 Skip the object when the x ranges do not overlap.
  $D975,$03 Remember the x overlap.
  $D978,$02 Point the entity one byte on, so the y fields line up.
N $D97A Build the object's y range in the same way, and test it against the
. y coordinate. #REGix still addresses the byte after the type, so a
. displacement reads the following field.
  $D97A,$03 Fetch the cell position again.
  $D97D,$03 Read the first byte of the object.
  $D980,$04 Shift it up by four bits.
  $D984,$01 Keep it as the low byte of the range.
  $D985,$03 Read the third byte of the object.
  $D988,$01 Double it.
  $D989,$02,b$01 Use bits 4-6 as the size.
  $D98B,$02 Add the base size of #N$10.
  $D98D,$01 Keep the size.
  $D98E,$06 Fetch the y coordinate.
  $D994,$03 Fetch the y extent.
  $D997,$03 Read the type byte.
  $D99A,$01 Advance the type.
  $D99B,$02,b$01 Use bits 1, 2 and 7.
  $D99D,$04 Keep this size unless the type is #N$82.
  $D9A1,$02 Mark the fixed-size object.
  $D9A3,$02 Use a size of #N$08.
@ $D9A5 label=TestGroupObjects_YRange
  $D9A5,$04 Pass the y coordinate to the overlap test.
  $D9A9,$03 Pass the object's y range to the overlap test.
  $D9AC,$03 Test the two y ranges.
  $D9AF,$02 Restore the entity address.
  $D9B1,$03 Skip the object when the y ranges do not overlap.
  $D9B4,$03 Remember the y overlap.
N $D9B7 Compare the z coordinate with the object, and remember the smaller gap
. in
. field #N$1F.
  $D9B7,$06 Fetch the z coordinate.
  $D9BD,$03 Pass the z coordinate to the edge test.
  $D9C0,$03 Read the object's type.
  $D9C3,$01 Keep the type aside.
  $D9C4,$02,b$01 Use the low nibble of the type.
  $D9C6,$01 Keep it as the low byte of the index.
  $D9C7,$04 Bring bit 4 of the type down beside it.
  $D9CB,$02,b$01 Use that bit.
  $D9CD,$02 Combine it with the low nibble.
  $D9CF,$06 Look this kind up in the object flags.
  $D9D5,$01 Read the flag byte.
  $D9D6,$03 Remember the object's flags.
  $D9D9,$03 Fetch the cell offset.
  $D9DC,$01 Advance its high byte.
  $D9DD,$01 Take the type again.
  $D9DE,$02,b$01 Use bits 4-6 as a row within the group.
  $D9E0,$02 Add that row to the cell offset.
  $D9E2,$03 Pass the address to the edge test.
@ $D9E5 label=TestGroupObjects_Heights
  $D9E5,$02 Start with no extra height.
  $D9E7,$05 A kind of #N$02 has no extra height.
  $D9EC,$03 Read the third byte of the object.
  $D9EF,$02 Shift it down by two.
  $D9F1,$02,b$01 Use bits 4-5 of that byte.
  $D9F3,$02 Use the looked-up height when those bits are set.
  $D9F5,$06 Jump to #R$DA09 to use the looked-up height when the top bit is
. clear.
  $D9FB,$05 Look up a height for this kind.
  $DA00,$02,b$01 Use the low nibble of the kind.
  $DA02,$03 Look the height up.
  $DA05,$01 Read the height.
  $DA06,$03 Restore the address and use that height.
@ $DA09 label=TestGroupObjects_AddHeight
  $DA09,$02 Add #N$10 to the height.
@ $DA0B label=TestGroupObjects_Height
  $DA0B,$01 Keep the height.
@ $DA0C label=TestGroupObjects_Overlap
N $DA0C The entity is only touching the block when half of either extent, less
. two, still covers the overlap. A deeper overlap on both axes means the
. entity is inside the block.
  $DA0C,$05 Mark the entity as only touching the block.
  $DA11,$03 Fetch the x overlap.
  $DA14,$01 Keep it.
  $DA15,$0B Compare half the x extent, less two, with the overlap.
  $DA20,$0F Compare half the y extent, less two, with the overlap.
  $DA2F,$04 The entity is inside the block, so clear the touching flag.
  $DA33,$01 Remember the edge address.
  $DA34,$03 Read the object's flags.
  $DA37,$03 Compare the z coordinate directly when the top flag is clear.
  $DA3A,$04 Add the overlap to the edge address.
  $DA3E,$06 Fetch the z coordinate.
  $DA44,$03 Subtract the edge.
  $DA47,$02 Leave this object if the entity is below the edge.
  $DA49,$03 Leave this object unless the result is within one page.
  $DA4C,$03 The low byte is the gap.
@ $DA4F label=TestGroupObjects_Raised
  $DA4F,$16 Compare the z coordinate with the z extent instead.
  $DA65,$03 Test a wide block.
  $DA68,$03 Read the object's flags.
  $DA6B,$02,b$01 Use the layout in bits 5-6.
  $DA6D,$02 No further height test when the layout is clear.
  $DA6F,$04 A layout of #N$40 ends the height test.
@ $DA73 label=TestGroupObjects_Gap
  $DA73,$07 Reduce the gap by four, and ignore a gap below four.
  $DA7A,$01 Keep the reduced gap.
  $DA7B,$18 Keep the smaller of the gap and the room above the entity.
@ $DA93 label=TestGroupObjects_SaveGap
  $DA93,$03 Fetch the gap already stored for this entity.
  $DA96,$03 Keep the stored gap when it is the smaller one.
  $DA99,$03 Remember this smaller gap.
  $DA9C,$04 Clear bit 6 of the flags.
@ $DAA0 label=TestGroupObjects_Vertical
N $DAA0 Test the z range. The vertical speed is put back afterwards, and a
. stand-in value of #N$18 is used for the test.
  $DAA0,$01 Restore the edge address.
@ $DAA1 label=TestGroupObjects_ZRange
  $DAA1,$03 Fetch the vertical speed.
  $DAA4,$01 Remember it.
  $DAA5,$03 Fetch the z extent.
  $DAA8,$02 Remember the entity.
  $DAAA,$05 Move back to the byte the test reads.
  $DAAF,$04 Plant #N$18 for the test.
  $DAB3,$04 Fetch the z coordinate passed to the test.
  $DAB7,$03 Test the z range.
  $DABA,$02 Restore the entity.
  $DABC,$01 Bring the vertical speed back.
  $DABD,$03 Restore the vertical speed.
  $DAC0,$03 Leave this object when the z ranges do not overlap.
  $DAC3,$04 Test whether the entity is moving fast.
  $DAC7,$02 The overlap is ordinary when the entity is not fast.
  $DAC9,$02 Test the sign of the result.
  $DACB,$02 A negative result keeps the low byte.
  $DACD,$02 Force the low byte to #N$FF.
  $DACF,$02 Join the stored overlap.
@ $DAD1 label=TestGroupObjects_Positive
  $DAD1,$02 Test the sign of the result.
  $DAD3,$02 A negative result is stored as it is.
  $DAD5,$02 Raise a positive overlap by two.
@ $DAD7 label=TestGroupObjects_ZOverlap
  $DAD7,$01 Reduce the overlap by one.
  $DAD8,$03 Remember the z overlap.
  $DADB,$03 Read the object's type.
  $DADE,$02,b$01 Use the type bits that select a solid block.
  $DAE0,$05 A type #N$83 is solid.
  $DAE5,$04 A type other than #N$85 is handled below.
  $DAE9,$03 Read how many bottles are left.
  $DAEC,$04 A type #N$85 is solid once no bottles are left.
@ $DAF0 label=TestGroupObjects_Handle
  $DAF0,$03 Read the object's flags.
  $DAF3,$04 Test the edge when the top flag is set.
  $DAF7,$04 Clear the handled flag.
  $DAFB,$03 Read the flags again.
  $DAFE,$04 Handle the overlap unless the flags were #N$FF.
  $DB02,$07 Only the player is placed against the block.
  $DB09,$03 Read the frame counter.
  $DB0C,$05 Only on every eighth frame.
  $DB11,$03 Read the object's type.
  $DB14,$02,b$01 Use bits 1, 2, 3 and 7 of the type.
  $DB16,$05 Only a type whose remaining bits are #N$02 places the player.
  $DB1B,$03 Read the handled flag.
  $DB1E,$04 Leave the placement when the flag is clear.
  $DB22,$03 Read the stored gap.
  $DB25,$04 Leave the placement when a gap is already stored.
  $DB29,$04 Fetch the x edge passed to the overlap test.
  $DB2D,$02 Step that edge back by two.
  $DB2F,$03 Fetch the other x edge.
  $DB32,$05 Keep the first edge when it is the nearer.
  $DB37,$04 Otherwise use the other edge.
@ $DB3B label=TestGroupObjects_XEdge
  $DB3B,$04 Keep the column of that edge.
  $DB3F,$04 Remember it as the position to match.
  $DB43,$04 Fetch the y edge passed to the overlap test.
  $DB47,$02 Step that edge back by two.
  $DB49,$03 Fetch the other y edge.
  $DB4C,$05 Keep the first edge when it is the nearer.
  $DB51,$04 Otherwise use the other edge.
@ $DB55 label=TestGroupObjects_YEdge
  $DB55,$04 Keep the column of that edge.
  $DB59,$04 Remember it as the other position to match.
  $DB5D,$08 Remember the player's height for the match.
  $DB65,$03 Go on to the bottle and the exit.
@ $DB68 label=TestGroupObjects_Solid
N $DB68 A solid block matches the object, raises the entity by one, and pushes
. it back to the edge. If it is still inside, the position is set from both
. edges and #R$D3A9 looks for a path there.
  $DB68,$03 Match the object.
  $DB6B,$06 Fetch the z coordinate.
  $DB71,$07 Raise the entity by one.
  $DB78,$03 Read the touching flag.
  $DB7B,$03 Leave this object when the entity was only touching.
  $DB7E,$04 Fetch an x edge.
  $DB82,$03 Step that edge on by three.
  $DB85,$03 Fetch the other x edge.
  $DB88,$02 Turn that edge into a coordinate.
  $DB8A,$03 Subtract the stepped edge.
  $DB8D,$04 Jump to #R$DB9F to push the entity the other way when the
. difference is negative.
  $DB91,$01 Step the edge back.
  $DB92,$06 Move the x coordinate back to that edge.
  $DB98,$07 Step the difference back by five.
@ $DB9F label=TestGroupObjects_PushX
  $DB9F,$01 Step the edge on.
  $DBA0,$06 Move the x coordinate on to that edge.
  $DBA6,$04 Step the difference on by four.
@ $DBAA label=TestGroupObjects_TryY
  $DBAA,$02 Leave this object when the x push was enough.
  $DBAC,$01 Remember the y edge.
  $DBAD,$04 Fetch a y edge.
  $DBB1,$03 Step that edge on by three.
  $DBB4,$03 Fetch the other y edge.
  $DBB7,$02 Turn that edge into a coordinate.
  $DBB9,$03 Subtract the stepped edge.
  $DBBC,$04 Jump to #R$DBCE to push the entity the other way when the
. difference is negative.
  $DBC0,$01 Step the edge back.
  $DBC1,$06 Move the y coordinate back to that edge.
  $DBC7,$07 Step the difference back by five.
@ $DBCE label=TestGroupObjects_PushY
  $DBCE,$01 Step the edge on.
  $DBCF,$06 Move the y coordinate on to that edge.
  $DBD5,$04 Step the difference on by four.
@ $DBD9 label=TestGroupObjects_Place
  $DBD9,$01 Restore the saved edge.
  $DBDA,$02 Leave this object when the y push was enough.
  $DBDC,$0C Place the entity on both saved edges.
  $DBE8,$02 Remember the object.
  $DBEA,$03 Find the path at this position.
  $DBED,$02 Restore the object.
@ $DBEF label=TestGroupObjects_Special
N $DBEF A type #N$85 object shows the exit-closed message for the player while
. bottles remain. A type #N$81 object is a bottle.
  $DBEF,$03 Read the type byte.
  $DBF2,$02,b$01 Keep the type bits.
  $DBF4,$04 Try a bottle unless the type is #N$85.
  $DBF8,$03 Read how many bottles are left.
  $DBFB,$03 Leave the message alone when no bottles are left.
  $DBFE,$07 Show the message for the player only.
  $DC05,$03 Read the exit message flag.
  $DC08,$02,b$01 Set the exit-closed bit.
  $DC0A,$03 Update the exit message flag.
  $DC0D,$03 Go on to the next object.
@ $DC10 label=TestGroupObjects_Bottle
  $DC10,$04 Leave any object that is not a bottle.
  $DC14,$06 Collect a bottle for the player only.
  $DC1A,$06 Leave the bottle if the flag at #R$DC6A(#N$DD4C) is clear.
  $DC20,$06 Leave the bottle if the flag at #R$D47A(#N$D5A4) is set.
  $DC26,$0F Collect the bottle, keeping the entity and the object.
@ $DC35 label=TestGroupObjects_Next
  $DC35,$04 Advance to the next object.
  $DC39,$01 Restore the object count.
  $DC3A,$04 Take the next object until every object has been tested.
  $DC3E,$01 Return.

c $DC3F Test Object Match
@ $DC3F label=TestObjectMatch
D $DC3F Tests whether an object is at the position that is stored at #R$E4C6 and
. #R$E4C6(#N$E4C8), and if it is then clears the flag at #R$E4C6(#N$E4C7).
R $DC3F IY The object
  $DC3F,$09 The high nibble of the object's first byte, beside the word at
. #R$5CB8.
  $DC48,$09 It matches the stored position at #R$E4C6.
  $DC51,$0B The same byte shifted up by four, beside the cell position.
  $DC5C,$09 It matches the stored position at #R$E4C6(#N$E4C8).
  $DC65,$04 Clear the flag at #R$E4C6(#N$E4C7).
@ $DC69 label=TestObjectMatch_Skip
  $DC69,$01 Return.

c $DC6A Handle Overlap
@ $DC6A label=HandleOverlap
D $DC6A Moves an entity off the overlap whose axis is the smallest of the three
. held at #R$DDCF. The x axis is handled by #R$DD61 and the y axis by #R$DD93.
. On z, a player under a flagged block changes frame, the difference is planted
. for #R$D7E4, and the vertical speed pushes the entity clear. A saucer sets
. the high byte of its vertical speed to #N$02 first.
R $DC6A IX The entity
R $DC6A IY The other entity or object
N $DC6A The smallest overlap chooses the axis. A saucer is pushed up before
. the choice is made.
  $DC6A,$07 A saucer sets its vertical speed.
  $DC71,$04 Set the high byte of the vertical speed to #N$02.
@ $DC75 label=HandleOverlap_Compare
  $DC75,$04 Read the x overlap.
  $DC79,$04 Compare it with the y overlap.
  $DC7D,$03 Handle x when it is the smaller overlap.
  $DC80,$01 Keep the y overlap.
  $DC81,$04 Compare it with the z overlap.
  $DC85,$03 Handle y when it is the smaller overlap.
@ $DC88 label=HandleOverlap_Vertical
N $DC88 The z overlap is the smallest. A player whose block has the top flag
. set takes frame #N$02, and the sides of the block choose the push.
  $DC88,$06 Remember the type.
  $DC8E,$03 Only the player changes frame.
  $DC91,$03 Read the object's flags.
  $DC94,$03 Change the frame when the top flag is set.
  $DC97,$05 Use the top three bits of the frame.
  $DC9C,$02,b$01 Set the frame number to #N$02.
  $DC9E,$03 Keep that frame.
  $DCA1,$03 Measure the sprite.
@ $DCA4 label=HandleOverlap_Frame
  $DCA4,$07 Move straight on when bit 5 of the frame is set.
  $DCAB,$06 Fetch the x coordinate.
  $DCB1,$03 Fetch the near x edge.
  $DCB4,$04 Subtract the entity's x from the edge.
  $DCB8,$02 The entity is on the edge.
  $DCBA,$02 Push back when the entity is past the edge.
@ $DCBC label=HandleOverlap_SizeX
  $DCBC,$07 Scale the object's byte up to a size along x.
  $DCC3,$02,b$01 Use bits 4-6 of that byte.
  $DCC5,$05 Add #N$10 to make the size.
  $DCCA,$01 Add the size to the difference.
  $DCCB,$04 The push stays small when x is still inside the extent.
  $DCCF,$02 The small push is #N$02.
  $DCD1,$02 Double the push and test y when x is clear.
  $DCD3,$01 Double the push.
  $DCD4,$06 Fetch the y coordinate.
  $DCDA,$05 Subtract the entity's y from the near edge.
  $DCDF,$02 The entity is on the edge.
  $DCE1,$02 Push back when the entity is past the edge.
@ $DCE3 label=HandleOverlap_SizeY
  $DCE3,$03 Read the object's byte.
  $DCE6,$01 Double that byte.
  $DCE7,$02,b$01 Use bits 4-6.
  $DCE9,$03 Add #N$10 to make the size.
  $DCEC,$01 Add the size to the difference.
  $DCED,$04 The push stays #N$08 when y is still inside the extent.
  $DCF1,$02 The push is #N$08.
  $DCF3,$02 Move the entity when y is clear.
@ $DCF5 label=HandleOverlap_Push
  $DCF5,$01 Keep the push.
  $DCF6,$01 Read the low byte of the difference.
  $DCF7,$04 Jump to #R$DCFD to keep a negative difference.
  $DCFB,$02 Force the difference negative.
@ $DCFD label=HandleOverlap_Step
  $DCFD,$03 Give that step to the turn.
  $DD00,$03 Read the hit already planted.
  $DD03,$03 A second hit becomes #N$FF.
  $DD06,$02 A second hit is #N$FF.
@ $DD08 label=HandleOverlap_Hit
  $DD08,$04 Plant the hit for #R$D7E4.
@ $DD0C label=HandleOverlap_Move
N $DD0C A positive z overlap clears the vertical speed. A negative one sets
. it, and a saucer is left alone. The byte at #R$DC6A(#N$DD4C) is patched by
. #R$D8E4: zero clears the low byte of the speed, and #N$04 skips that clear.
  $DD0C,$03 Fetch the z overlap.
  $DD0F,$02 Remember the entity.
  $DD11,$05 Move on to the vertical speed.
  $DD16,$04 Clear the fraction of x.
  $DD1A,$04 A negative overlap pushes the entity up.
  $DD1E,$06 Clear the vertical speed.
  $DD24,$03 Move the entity back.
  $DD27,$02 Join the restore.
  $DD29,$07 A saucer is not pushed up.
  $DD30,$03 Read the object's flags.
  $DD33,$05 The push is #N$FD when the top flag is set.
  $DD38,$02 Otherwise the push is #N$FF.
  $DD3A,$06 Use that as the vertical speed.
  $DD40,$08 Set bit 7 of the vertical speed and clear bit 6.
  $DD48,$03 Move the entity back.
  $DD4B,$02 Clear the low byte of the speed when the entity is inside.
  $DD4D,$04 Clear the low byte of the vertical speed.
  $DD51,$02 Restore the entity.
  $DD53,$05 Snap z up when its top byte is zero.
  $DD58,$04 Set the top of z to one.
  $DD5C,$04 Clear the middle byte of z.
  $DD60,$01 Return.

c $DD61 Handle Overlap First
@ $DD61 label=HandleOverlapFirst
D $DD61 Moves the entity clear of the overlap in the first direction. Entities
. of type #N$05 are changed to type #N$0D.
R $DD61 IX The entity
  $DD61,$07 The z overlap is smaller, so this axis is left alone.
  $DD68,$07 A puff becomes a sparkle.
  $DD6F,$0F The sparkle's countdown is #N$04, its frame is #N$00, its type is
. #N$0D
. and its height is #N$08.
@ $DD7E label=HandleOverlapFirst_Shot
  $DD7E,$09 When the type is a shot.
  $DD87,$04 Set bit 7 of the width byte.
@ $DD8B label=HandleOverlapFirst_Move
  $DD8B,$08 Move back by the x overlap and finish.

c $DD93 Handle Overlap Second
@ $DD93 label=HandleOverlapSecond
D $DD93 Moves the entity clear of the overlap in the second direction. Entities
. of type #N$05 are changed to type #N$0D.
R $DD93 IX The entity
  $DD93,$07 A puff becomes a sparkle.
  $DD9A,$0F The sparkle's countdown is #N$04, its frame is #N$00, its type is
. #N$0D
. and its height is #N$08.
@ $DDA9 label=HandleOverlapSecond_Shot
  $DDA9,$09 When the type is a shot.
  $DDB2,$04 Set bit 7 of the width byte.
@ $DDB6 label=HandleOverlapSecond_Move
  $DDB6,$10 Move the y coordinate back by the y overlap.
@ $DDC6 label=HandleOverlapSecond_Clear
  $DDC6,$08 Leave bits 6 and 7 of the flags.
  $DDCE,$01 Return.

g $DDCF Overlap Distances
@ $DDCF label=OverlapDistances
D $DDCF The overlap in the first, second and third directions, as found by
. #R$D47A. Each is a word.
W $DDCF,$06,$02

c $DDD5 Move Entity Back
@ $DDD5 label=MoveEntityBack
D $DDD5 Moves an entity back along one of its coordinates by an amount.
R $DDD5 HL The amount, with the direction in bit 7 of #REGh
R $DDD5 IX The entity, with the coordinate in fields #N$02 and #N$03
  $DDD5,$03 Fetch the high byte of the x coordinate into #REGd.
  $DDD8,$03 Fetch the low byte of the x coordinate into #REGe.
  $DDDB,$02 Rotate #REGh left through the carry flag.
  $DDDD,$02 #REGh is #N$00.
  $DDDF,$02 Jump to #R$DDD5(#N$DDE4) if the carry flag is reset.
  $DDE1,$01 #REGhl takes #REGde.
  $DDE2,$02 Jump to #R$DDD5(#N$DDEC).
@ $DDE4 label=MoveEntityBack_Skip
  $DDE4,$01 Step #REGl back.
  $DDE5,$04 Set field #N$04 of the entity to #N$FF.
  $DDE9,$01 Exchange #REGde and #REGhl.
  $DDEA,$02 Subtract #REGde from #REGhl. (with the carry)
@ $DDEC label=MoveEntityBack_Skip2
  $DDEC,$03 Set the high byte of the x coordinate.
  $DDEF,$03 Set the low byte of the x coordinate.
  $DDF2,$01 Return.

c $DDF3 Test Range Overlap
@ $DDF3 label=TestRangeOverlap
D $DDF3 Tests whether a range overlaps another, taking into account whether the
. entity is on the ground. Purpose of the individual steps is not yet known.
R $DDF3 HL The start of the first range
R $DDF3 DE The start of the second range
R $DDF3 B The size of the range
R $DDF3 O:F The carry flag is set if the ranges overlap
  $DDF3,$01 Set #REGa to zero.
  $DDF4,$02 Subtract #REGde from #REGhl. (with the carry)
  $DDF6,$02 Jump to #R$DE11 if the carry flag is set.
  $DDF8,$01 Combine #REGa with #REGh.
  $DDF9,$01 Return if the zero flag is reset.
  $DDFA,$01 #REGl moves into #REGa.
  $DDFB,$01 Subtract #REGb.
  $DDFC,$01 Return if the carry flag is reset.
  $DDFD,$01 #REGhl takes #REGde.
  $DDFE,$06 Jump to #R$DE21 if the zero flag is set.
@ $DE04 label=TestRangeOverlap_Loop
  $DE04,$02 #REGb is #N$00.
  $DE06,$01 #REGhl takes #REGbc.
  $DE07,$02 Subtract #REGde from #REGhl. (with the carry)
@ $DE09 label=TestRangeOverlap_Loop2
  $DE09,$03 Read field #N$18 of the entity into #REGh.
  $DE0C,$01 Advance #REGl.
  $DE0D,$01 Set the carry flag.
  $DE0E,$01 Return.
@ $DE0F label=TestRangeOverlap_Reset
  $DE0F,$01 See whether #REGa is zero.
  $DE10,$01 Return.
@ $DE11 label=TestRangeOverlap_Second
  $DE11,$01 #REGb moves into #REGa.
  $DE12,$02 #REGb is #N$00.
  $DE14,$01 #REGhl takes #REGbc.
  $DE15,$01 Return if the carry flag is reset.
  $DE16,$06 Jump to #R$DDF3(#N$DE09) if the zero flag is reset.
  $DE1C,$01 See whether #REGa is zero.
  $DE1D,$02 Subtract #REGbc from #REGhl. (with the carry)
  $DE1F,$01 #REGa moves into #REGb.
  $DE20,$01 #REGhl takes #REGde.
@ $DE21 label=TestRangeOverlap_Swap
  $DE21,$01 Exchange #REGde and #REGhl.
  $DE22,$01 #REGb moves into #REGc.
  $DE23,$02 Jump to #R$DDF3(#N$DE04).

c $DE25 Reset Entities
@ $DE25 label=ResetEntities
D $DE25 Clears the entities other than the player, and marks every extra record
. free. The player is copied from the template at #R$DE77 and the jump counter
. is cleared. If #R$DEFC is set, the player's animation low nibble and the
. control byte are set to #N$05. #R$AF21 then measures the sprite.
  $DE25,$04 Start at the first entity after the player.
  $DE29,$02 There are #N$0B entities besides the player.
  $DE2B,$03 Each entity is #N$26 bytes.
@ $DE2E label=ResetEntities_Pool
  $DE2E,$04 Free the entity.
  $DE32,$04 Hide the entity.
  $DE36,$02 Move on to the next entity.
  $DE38,$02 Repeat for the remaining entities.
  $DE3A,$04 Start at the first extra record.
  $DE3E,$02 There are #N$0C extra records.
  $DE40,$03 Each record is #N$0D bytes.
@ $DE43 label=ResetEntities_Records
  $DE43,$04 Mark the extra record as free.
  $DE47,$02 Move on to the next record.
  $DE49,$02 Repeat for the remaining records.
  $DE4B,$03 The player is the destination.
  $DE4E,$03 The template is #N$26 bytes.
  $DE51,$03 The template is the source.
  $DE54,$02 Copy the template over the player.
  $DE56,$04 Clear the jump counter.
@ $DE5A label=ResetEntities_Player
  $DE5A,$04 Use the player.
  $DE5E,$03 Read the bottle flag.
  $DE61,$04 Measure the sprite when the flag is clear.
  $DE65,$03 Read the player's animation counter.
  $DE68,$02,b$01 Use the high nibble of the animation.
  $DE6A,$02,b$01 Set the low nibble to #N$05.
  $DE6C,$03 Keep that animation.
  $DE6F,$05 Set the control byte to #N$05.
  $DE74,$03 Measure the sprite.

b $DE77 Player Template
@ $DE77 label=PlayerTemplate
D $DE77 The initial values for the player entity, which is copied to #R$B540.
B $DE77,$26,$26

c $DE9D Show Player Number
@ $DE9D label=ShowPlayerNumber
D $DE9D Clears the screen and prints the number of the player, which is the text
. at #R$DEC4, and if the player has no lives left plays the tune at #R$DFD1.
. Then waits for a short time.
. .
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
. .
. #PUSHS #UDGTABLE { #SIM(start=$876B,stop=$0000,clear=1,sp=$5B60)
. #SIM(start=$DF1F,stop=$0000,sp=$5B60)
. #SIM(start=$DE9D,stop=$DEB0,sp=$5B60)
. #SCR$02(show-player-number) } UDGTABLE# #POPS
  $DE9D,$03 Call #R$A8E1.
  $DEA0,$03 Call #R$A8D1.
@ $DEA3 label=ShowPlayerNumber_Print
  $DEA3,$03 Read the byte at #R$DEDD.
  $DEA6,$01 Advance #REGa.
  $DEA7,$03 Write #REGa at #R$DEC4(#N$DECF).
  $DEAA,$03 Point #REGde at #R$DEC4.
  $DEAD,$03 Call #R$A923.
  $DEB0,$03 Point #REGde at #R$DFD1.
  $DEB3,$03 Read the byte at #R$DEDE.
  $DEB6,$01 See whether #REGa is zero.
  $DEB7,$03 Call #R$A1C1 if the zero flag is set.
  $DEBA,$02 #REGb is #N$08.
@ $DEBC label=ShowPlayerNumber_Loop
  $DEBC,$02 #REGd is #N$00.
  $DEBE,$03 Call #R$A8F9.
  $DEC1,$02 Repeat from #R$DE9D(#N$DEBC) while #REGb still counts.
  $DEC3,$01 Return.

b $DEC4 Player Number Text
@ $DEC4 label=PlayerNumberText
D $DEC4 The text record for the message 'PLAYER 1', which is printed by
. #R$DE9D. The number is changed to suit the player.
B $DEC4,$02 Position: x=#N$40, y=#N$5F.
B $DEC6,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $DEC7,$01 Length #N$08, quadruple size.
B $DEC8,$08 "PLAYER 1"

b $DED0 Game Over Text
@ $DED0 label=GameOverText
D $DED0 The text record for the message 'GAME OVER', which is printed by
. #R$DFF0(#N$E0C0).
B $DED0,$02 Position: x=#N$38, y=#N$3F.
B $DED2,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $DED3,$01 Length #N$09, quadruple size.
B $DED4,$09 "GAME OVER"

g $DEDD Current Player
@ $DEDD label=CurrentPlayer
D $DEDD The player who is playing, which is #N$00 for player 1 and #N$01 for
. player 2.
B $DEDD,$01,$01

g $DEDE Lives
@ $DEDE label=Lives
D $DEDE The number of lives that the current player has. The details of the
. player that is not playing are held at #R$DEFD, and the two are swapped by
. #R$A30D. This byte is the first of a block of #N$1F bytes that are swapped.
B $DEDE,$01,$01

g $DEDF Level Number
@ $DEDF label=LevelNumber
D $DEDF The number of the level that the player is on, which is a number from
. #N$00 to #N$04.
B $DEDF,$01,$01

g $DEE0 Bottles Left
@ $DEE0 label=BottlesLeft
D $DEE0 The number of bottles that the player has still to collect. The exit
. opens when it reaches zero.
B $DEE0,$01,$01

g $DEE1 Bottle States
@ $DEE1 label=BottleStates
D $DEE1 The state of each of the #N$14 bottles of the level, which is set by
. #R$DFF0(#N$E0EB) and kept by #R$A39B and #R$A3FE.
B $DEE1,$14,$14

g $DEF5 Restart Position
@ $DEF5 label=RestartPosition
D $DEF5 The position at which the player restarts, which is used by #R$876B if
. the flag in the third byte of it is set. The routine at #R$E461 sets it.
B $DEF5,$04,$04

g $DEF9 Score
@ $DEF9 label=Score
D $DEF9 The score of the current player, as six digits in binary coded decimal
. in three bytes.
B $DEF9,$03,$03

g $DEFC Bottle Flag
@ $DEFC label=BottleFlag
D $DEFC A flag that is set when the player is on a bottle, so that #R$A3FE
. collects it.
B $DEFC,$01,$01

g $DEFD Other Player State
@ $DEFD label=OtherPlayerState
D $DEFD The details of the player who is not playing, in the same format as the
. #N$1F bytes from #R$DEDE. The first byte is the number of lives and the third
. is the number of bottles left.
B $DEFD,$1F,$1F

b $DF1C Panel Fill Rectangle
@ $DF1C label=PanelFillRectangle
D $DF1C The rectangle that is used by #R$DF1F to clear the area of the screen
. of the game.
B $DF1C,$03,$03

c $DF1F Start Game
@ $DF1F label=StartGame
D $DF1F Sets up everything for a new game: the lives, the scores, the gauges,
. the bottles and the details of the second player if there is one. The entry
. point at #R$DF81 is also used to start each life, and resets the player
. state.
N $DF1F Colour the area at the bottom of the screen.
  $DF1F,$09 Colour the area that is described by the rectangle at #R$DF1C,
. starting at the position #N$BF00.
N $DF28 Give the first player five lives.
  $DF28,$05 Set the number of lives to #N$05.
N $DF2D Clear the score of the first player and the digits of the scores of both
. players.
  $DF2D,$08 Clear the three bytes of the score of the first player.
  $DF35,$08 Clear the five digits of the score of the first player in the panel
. text.
  $DF3D,$08 Clear the five digits of the score of the second player in the panel
. text.
N $DF45 Set up the two gauges.
  $DF45,$0B Copy the starting values of the gauges, which empty the bars and set
. the targets to full.
N $DF50 Mark all of the bottles of the level as not yet collected.
  $DF50,$03 Point #REGhl at #R$DEE1.
  $DF53,$02 Set the state of an uncollected bottle.
  $DF55,$02 Set the number of bottles to #N$14.
@ $DF57 label=StartGame_Loop
  $DF57,$01 Set the state of a bottle.
  $DF58,$01 Move on to the next bottle.
  $DF59,$02 Loop back to #R$DF57 until all of the bottles have been done.
N $DF5B Clear the restart position, the current player and the bottle flag, and
. go to the first level.
  $DF5B,$04 Clear the restart position.
  $DF5F,$03 Make the first player the current player.
  $DF62,$03 Clear the bottle flag of the player.
  $DF65,$05 Set the number of the level to zero.
N $DF6A Copy the details of the first player to the second player.
  $DF6A,$0B Copy the details of the first player, which are #N$1F bytes, to
. those of the second player.
N $DF75 Take the lives and the bottles away from the second player if there is
. only one player.
  $DF75,$03 Fetch the number of players.
  $DF78,$01 Test it.
  $DF79,$02 Jump to #R$DF81 if there are two players.
  $DF7B,$03 Clear the lives of the second player.
  $DF7E,$03 Clear the bottles of the second player.
@ $DF81 label=StartGame_Life
N $DF81 Start a life. Reset the heading of the player, the message, the counter
. of the player and the countdown timer.
  $DF81,$04 Clear the heading of the player.
  $DF85,$03 Clear the state of the message.
  $DF88,$03 Clear the counter of the player.
  $DF8B,$05 Start the countdown timer at #N$28.
  $DF90,$05 Set the byte that is patched into the controls at #R$AB0F(#N$AB7D)
. to #N$04.
N $DF95 Fill the first gauge, and draw the direction gauge with the needle at
. its start.
  $DF95,$06 Set the first gauge to full.
  $DF9B,$05 Set the heading of the needle to #N$08.
  $DFA0,$03 Draw the direction gauge.

b $DFA3 Gauge Defaults
@ $DFA3 label=GaugeDefaults
D $DFA3 The initial values of the two gauges, which are copied to #R$A59D.
B $DFA3,$08,$04

c $DFAB Remove Object Entities
@ $DFAB label=RemoveObjectEntities
D $DFAB Removes each of the four entities that were made for objects of the
. level by #R$BE01, and clears the flag of each of the objects.
  $DFAB,$04 Point #REGix at #R$B540(#N$B670).
  $DFAF,$02 #REGb is #N$04.
  $DFB1,$03 #REGde is #N$0026.
@ $DFB4 label=RemoveObjectEntities_Loop
  $DFB4,$03 Read field #N$00 of the entity.
  $DFB7,$01 See whether #REGa is zero.
  $DFB8,$02 Jump to #R$DFCC if the zero flag is set.
  $DFBA,$03 Read field #N$1A of the entity into #REGh.
  $DFBD,$03 Read field #N$1B of the entity into #REGl.
  $DFC0,$01 Advance #REGhl.
  $DFC1,$01 Advance #REGhl.
  $DFC2,$02 Reset bit 7 of the byte at the address in #REGhl.
  $DFC4,$04 Set field #N$00 of the entity to #N$00.
  $DFC8,$04 Set field #N$01 of the entity to #N$80.
@ $DFCC label=RemoveObjectEntities_Next
  $DFCC,$02 #REGix takes #REGde.
  $DFCE,$02 Repeat from #R$DFB4 while #REGb still counts.
  $DFD0,$01 Return.

b $DFD1 Game Over Tune
@ $DFD1 label=GameOverTune
D $DFD1 The notes of the tune that is played by #R$A1C1 when the game is over,
. ending with #N$FF.
B $DFD1,$1F,$08

c $DFF0 Run Game
@ $DFF0 label=RunGame
D $DFF0 The main loop of the game. A game starts with the title menu, and then
. each life is played in the loop from #R$E027. When the player loses a life
. the next player is switched to if there is a second player. When the last life
. is lost the high score is checked and the game starts again.
N $DFF0 Clear the bytes at #R$5CD8 that the game uses as variables.
  $DFF0,$08 Clear #N$30 bytes starting at #R$5CD8.
@ $DFF8 label=RunGame_Loop
N $DFF8 Start a new game from the title menu. Make player 1 the player on the
. left of the panel, and go to the first level.
  $DFF8,$03 Fetch the flag that shows the scores are swapped.
  $DFFB,$01 Test it.
  $DFFC,$03 Swap the players back if they were swapped.
  $DFFF,$04 Set the level number to zero.
  $E003,$03 Set the colours and the shape of the level.
  $E006,$03 Reset the attributes of the screen.
  $E009,$03 Clear the screen.
  $E00C,$03 Show the title menu and wait for the game to be started.
  $E00F,$03 Set up the lives, the scores, the gauges and the bottles for a new
. game.
  $E012,$03 Show the number of the player.
  $E015,$03 Reset the attributes of the screen.
  $E018,$03 Clear the screen.
  $E01B,$03 Draw the panel.
@ $E01E label=RunGame_Loop2
N $E01E Colour the window of the game for the level.
  $E01E,$03 Set #REGhl to the position #N$7730 of the game window.
  $E021,$03 Point #REGde at #R$E11C.
  $E024,$03 Colour the window.
@ $E027 label=RunGame_Life
N $E027 Start a life. Draw the icon of each player that shows whether the player
. has the bottle flag set, putting the icon of the current player on the left.
  $E027,$04 Fetch the bottle flag of the first player and keep it in #REGc.
  $E02B,$04 Fetch the bottle flag of the second player and keep it in #REGb.
  $E02F,$03 Fetch the number of the current player.
  $E032,$01 Test it.
  $E033,$02 Jump to #R$E038 if it is the first player.
  $E035,$03 Swap the flags of the players, so that the flag of the current
. player is in #REGc.
@ $E038 label=RunGame_Pictures
  $E038,$01 Stash the flags on the stack.
  $E039,$03 Set #REGhl to the position #N$6808 of the icon on the left of the
. panel.
  $E03C,$03 Point #REGde at #R$64BC.
  $E03F,$01 Fetch the flag for the icon.
  $E040,$01 Test it.
  $E041,$02 Jump to #R$E046 if the flag is not set.
  $E043,$03 Point #REGde at #R$6498.
@ $E046 label=RunGame_LeftIcon
  $E046,$03 Draw the icon on the left.
  $E049,$02 Move across to the icon on the right of the panel.
  $E04B,$03 Point #REGde at #R$64BC.
  $E04E,$01 Restore the flags.
  $E04F,$01 Fetch the flag for the icon on the right.
  $E050,$01 Test it.
  $E051,$02 Jump to #R$E056 if the flag is not set.
  $E053,$03 Point #REGde at #R$6498.
@ $E056 label=RunGame_RightIcon
  $E056,$03 Draw the icon on the right.
N $E059 Update the panel, reset the state of the player and print the digits of
. the lives and the bottles.
  $E059,$03 Update the digits of the lives and the bottles.
  $E05C,$03 Reset the state of the player, the countdown timer and the gauges.
  $E05F,$03 Point #REGde at #R$E1A5.
  $E062,$02 Set the number of text records to #N$04.
  $E064,$03 Print the digits of the lives and the bottles of both players.
N $E067 Put the entities and the bottles of the level in place, build the view
. and print the messages.
  $E067,$03 Reset the entities.
  $E06A,$03 Restore the bottles that the player has not yet collected.
  $E06D,$03 Build the view of the level.
  $E070,$03 Scroll in the message for the stage.
  $E073,$03 Show the exit message, if all of the bottles have been collected.
@ $E076 label=RunGame_Frame
N $E076 Draw the first frame, and wipe it on to the screen.
  $E076,$04 Point #REGix at #R$B540.
  $E07A,$03 Project the player on to the screen.
  $E07D,$03 Update the entities.
  $E080,$03 Build the draw list.
  $E083,$03 Sort the draw list.
  $E086,$03 Draw the items of the draw list.
  $E089,$03 Wipe the view on to the screen.
  $E08C,$03 Put the rows of the screen buffer back.
N $E08F Run the frames of the game until the player loses a life or leaves the
. level. Then remove the entities that were made from the objects of the level,
. and clear the message.
  $E08F,$03 Run the frames of the game.
  $E092,$03 Remove the entities that were made from the objects of the level.
  $E095,$03 Point #REGde at #R$CE5A.
  $E098,$03 Clear the first part of the message.
  $E09B,$03 Clear the second part of the message.
  $E09E,$03 Fetch the flag that shows a life has been lost.
  $E0A1,$01 Test it.
  $E0A2,$02 Jump to #R$E0E0 if the player has left the level.
@ $E0A4 label=RunGame_Lost
N $E0A4 The player lost a life. Wipe the view off the screen and take away a
. life.
  $E0A4,$03 Wipe the view off the screen.
  $E0A7,$03 Fetch the number of lives.
  $E0AA,$01 Take away a life.
@ $E0AB label=RunGame_Loop3
  $E0AB,$03 Store the number of lives.
  $E0AE,$02 Jump to #R$E0BA if the player has no lives left.
N $E0B0 Hand over to the other player in a game with two players, and carry on
. from the start of a life.
  $E0B0,$03 Fetch the number of players.
  $E0B3,$01 Test it.
  $E0B4,$03 Swap the details of the two players if there are two players.
  $E0B7,$03 Start the next life.
@ $E0BA label=RunGame_Over
N $E0BA The player has no lives left. Show the message 'GAME OVER' and the
. number of the player, and check the high score.
  $E0BA,$03 Reset the attributes of the screen.
  $E0BD,$03 Clear the screen.
  $E0C0,$03 Point #REGde at #R$DED0.
  $E0C3,$03 Print it.
  $E0C6,$03 Print the number of the player and play the game over tune.
  $E0C9,$03 Check whether the score is a new high score.
  $E0CC,$03 Fetch the number of players.
  $E0CF,$01 Test it.
  $E0D0,$03 Go back to the title menu if there is only one player.
  $E0D3,$03 Fetch the number of lives of the other player.
  $E0D6,$01 Test it.
  $E0D7,$03 Go back to the title menu if the other player has no lives left
. either.
  $E0DA,$03 Swap the details of the two players.
  $E0DD,$03 Start a life for the other player.
@ $E0E0 label=RunGame_Complete
N $E0E0 The player has left the level. Go on to the next level, put all of the
. bottles back and give the bonus for the time that is left.
  $E0E0,$01 Clear the bottle flag of the player.
  $E0E1,$03 Store it.
  $E0E4,$03 Fetch the number of the level.
  $E0E7,$01 Go on to the next level.
  $E0E8,$03 Store it.
  $E0EB,$03 Point #REGhl at #R$DEE1.
  $E0EE,$02 Set the state of an uncollected bottle.
  $E0F0,$02 Set the number of bottles to #N$14.
@ $E0F2 label=RunGame_Loop4
  $E0F2,$01 Set the state of a bottle.
  $E0F3,$01 Move on to the next bottle.
  $E0F4,$02 Loop back to #R$E0F2 until all of the bottles have been done.
  $E0F6,$03 Clear the wanted heading of the player.
  $E0F9,$03 Store it.
  $E0FC,$03 Play the fanfare.
  $E0FF,$03 Count down the time that is left and add it to the score.
  $E102,$03 Wipe the view off the screen.
  $E105,$01 Clear the restart position.
  $E106,$03 Store it.
N $E109 After the last level, show the ending and finish the game.
  $E109,$03 Fetch the number of the level.
  $E10C,$02 Take away the number of levels.
  $E10E,$02 Jump to #R$E116 if the last level has not been finished.
  $E110,$03 Show the ending.
  $E113,$01 Set the number of lives to zero.
  $E114,$02 Jump to #R$E0AB to finish the game.
@ $E116 label=RunGame_Next
  $E116,$03 Set the colours and the shape of the next level.
  $E119,$03 Start the level.

b $E11C Panel Rectangle
@ $E11C label=PanelRectangle
D $E11C The rectangle that is used by #R$DFF0 to set the attributes of the game
. area. The attribute is set to suit the level by #R$876B.
B $E11C,$03,$03

b $E11F Panel Text
@ $E11F label=PanelText
D $E11F The text records for the panel, which are printed by #R$DFF0 and
. updated by #R$E200. The digits of the two scores are at #R$E132 and
. #R$E144, the high score is at #R$E1A0, and there are two digits for the
. lives and two for the bottles of each player.
@ $E132 label=ScoreText_PlayerOne
@ $E144 label=ScoreText_PlayerTwo
@ $E1A0 label=HighScoreText
@ $E1A9 label=LivesText_PlayerOne
@ $E1AF label=LivesText_PlayerTwo
@ $E1B5 label=BottlesText_PlayerOne
@ $E1BB label=BottlesText_PlayerTwo
B $E11F,$02 Position: x=#N$98, y=#N$BE.
B $E121,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E122,$01 Length #N$02, double height.
B $E123,$02 "  "
B $E125,$02 Position: x=#N$00, y=#N$0F.
B $E127,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E128,$01 Length #N$05, double height.
B $E129,$05 "SCORE"
@ $E12E label=ScoreTextPlayerOne_Record
B $E12E,$02 Position: x=#N$00, y=#N$1F.
B $E130,$01 Attribute: #COLOUR(#PEEK(#PC)).
@ $E131 label=ScoreTextPlayerOne_Length
B $E131,$01 Length #N$05, double height.
B $E132,$05 "00000"
B $E137,$02 Position: x=#N$D8, y=#N$0F.
B $E139,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E13A,$01 Length #N$05, double height.
B $E13B,$05 "SCORE"
@ $E140 label=ScoreTextPlayerTwo_Record
B $E140,$02 Position: x=#N$D8, y=#N$1F.
B $E142,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E143,$01 Length #N$05, double height.
B $E144,$05 "00000"
B $E149,$02 Position: x=#N$00, y=#N$7D.
B $E14B,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E14C,$01 Length #N$04, double height.
B $E14D,$04 "TIME"
B $E151,$02 Position: x=#N$E0, y=#N$7D.
B $E153,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E154,$01 Length #N$04, double height.
B $E155,$04 "TIME"
B $E159,$02 Position: x=#N$08, y=#N$8F.
B $E15B,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E15C,$01 Length #N$09.
B $E15D,$09 "<28><29><2A><2B><2C><2D><29><2E><2F>"
B $E166,$02 Position: x=#N$18, y=#N$BF.
B $E168,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E169,$01 Length #N$05.
B $E16A,$05 "<30><31><32><30><2B>"
B $E16F,$02 Position: x=#N$B0, y=#N$8F.
B $E171,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E172,$01 Length #N$09.
B $E173,$09 "<28><29><2A><2B><2C><2D><29><2E><2F>"
B $E17C,$02 Position: x=#N$C0, y=#N$BF.
B $E17E,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E17F,$01 Length #N$05.
B $E180,$05 "<30><31><32><30><2B>"
B $E185,$02 Position: x=#N$68, y=#N$9F.
B $E187,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E188,$01 Length #N$05.
B $E189,$05 "     "
B $E18E,$02 Position: x=#N$68, y=#N$AB.
B $E190,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E191,$01 Length #N$05, double height.
B $E192,$05 "HI-SC"
B $E197,$02 Position: x=#N$78, y=#N$AB.
B $E199,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E19A,$01 Length #N$01, double height.
B $E19B,$01 "-"
B $E19C,$02 Position: x=#N$70, y=#N$BF.
B $E19E,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E19F,$01 Length #N$05, double height.
B $E1A0,$05 "10645"
@ $E1A5 label=LivesTextPlayerOne_Record
B $E1A5,$02 Position: x=#N$18, y=#N$2B.
B $E1A7,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E1A8,$01 Length #N$02.
B $E1A9,$02 "00"
@ $E1AB label=LivesTextPlayerTwo_Record
B $E1AB,$02 Position: x=#N$D8, y=#N$2B.
B $E1AD,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E1AE,$01 Length #N$02.
B $E1AF,$02 "00"
@ $E1B1 label=BottlesTextPlayerOne_Record
B $E1B1,$02 Position: x=#N$18, y=#N$47.
B $E1B3,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E1B4,$01 Length #N$02.
B $E1B5,$02 "00"
@ $E1B7 label=BottlesTextPlayerTwo_Record
B $E1B7,$02 Position: x=#N$D8, y=#N$47.
B $E1B9,$01 Attribute: #COLOUR(#PEEK(#PC)).
B $E1BA,$01 Length #N$02.
B $E1BB,$02 "00"

c $E1BD Print Text Records
@ $E1BD label=PrintTextRecords
D $E1BD Prints a number of text records, one after the other, with #R$A923.
. .
. #PUSHS #UDGTABLE { #BLANKSCREEN(0)
. #SIM(start=$E1BD,stop=$0000,de=$E11F,bc=$1300,sp=$5B60)
. #SCR$02(print-text-records) } UDGTABLE# #POPS
E $E1BD View the equivalent code in;
. #LIST
. { #CYBERUN$83CE }
. LIST#
R $E1BD DE The address of the first text record
R $E1BD B The number of text records
  $E1BD,$01 Remember #REGbc.
  $E1BE,$03 Call #R$A923.
  $E1C1,$01 Bring back #REGbc.
  $E1C2,$02 Repeat from #R$E1BD while #REGb still counts.
  $E1C4,$01 Return.

c $E1C5 Copy Rectangle Rows
@ $E1C5 label=CopyRectangleRows
D $E1C5 Copies rows of bytes into the table at #N$F502. The first byte is the
. width of each row, remembered at #N$F500, and the second is the number of
. rows, remembered at #N$F501. Each copied byte is two source bytes on from
. the last.
R $E1C5 DE The address of the data
  $E1C5,$06 The width of each row, remembered at #N$F500.
  $E1CB,$04 The number of rows, remembered at #N$F501.
  $E1CF,$03 The copy starts at #N$F502.
@ $E1D2 label=CopyRectangleRows_Row
  $E1D2,$01 One row.
  $E1D3,$01 The width is the count for this row.
@ $E1D4 label=CopyRectangleRows_Byte
  $E1D4,$05 Copy the next byte, two source bytes on.
  $E1D9,$02 The rest of the row.
  $E1DB,$01 The next row.
  $E1DC,$01 One fewer row remains.
  $E1DD,$02 Another row.
  $E1DF,$01 Return.

b $E1E0 Panel Rectangles
@ $E1E0 label=PanelRectangles
D $E1E0 The three rectangles that are used by #R$E229 to set the attributes of
. the panel.
B $E1E0,$03,$03
@ $E1E3 label=PanelRectangles_Second
B $E1E3,$03,$03
@ $E1E6 label=PanelRectangles_Third
B $E1E6,$03,$03

c $E1E9 Get Digits
@ $E1E9 label=GetDigits
D $E1E9 Converts a number to two digits, ready to be printed as text.
R $E1E9 A The number, which is #N$00 to #N$63
R $E1E9 O:H The units digit
R $E1E9 O:L The tens digit
  $E1E9,$01 See whether #REGa is zero.
  $E1EA,$02 Jump to #R$E1E9(#N$E1F3) if the zero flag is set.
  $E1EC,$01 #REGa moves into #REGb.
@ $E1ED label=GetDigits_Convert
  $E1ED,$01 Set #REGa to zero.
@ $E1EE label=GetDigits_Loop
  $E1EE,$02 Add #N$01.
  $E1F0,$01 Adjust #REGa for binary coded decimal.
  $E1F1,$02 Repeat from #R$E1E9(#N$E1EE) while #REGb still counts.
@ $E1F3 label=GetDigits_Skip
  $E1F3,$01 #REGa moves into #REGb.
  $E1F4,$01 Rotate #REGa right through the carry flag.
  $E1F5,$01 Rotate #REGa right through the carry flag.
  $E1F6,$01 Rotate #REGa right through the carry flag.
  $E1F7,$01 Rotate #REGa right through the carry flag.
  $E1F8,$02,b$01 Use bits 0-3.
  $E1FA,$01 #REGa moves into #REGl.
  $E1FB,$01 #REGb moves into #REGa.
  $E1FC,$02,b$01 Use bits 0-3.
  $E1FE,$01 #REGa moves into #REGh.
  $E1FF,$01 Return.

c $E200 Update Panel Digits
@ $E200 label=UpdatePanelDigits
D $E200 Sets the digits on the panel of the lives and the bottles of each of the
. players, using #R$E1E9. The number of lives that is shown is one less than
. the number the current player has.
  $E200,$03 Read the byte at #R$DEDE.
  $E203,$01 See whether #REGa is zero.
  $E204,$02 Jump to #R$E200(#N$E207) if the zero flag is set.
  $E206,$01 Step #REGa back.
@ $E207 label=UpdatePanelDigits_Skip
  $E207,$03 Call #R$E1E9.
  $E20A,$03 Write #REGhl at #R$E1A9.
  $E20D,$03 Read the byte at #R$DEFD.
  $E210,$03 Call #R$E1E9.
  $E213,$03 Write #REGhl at #R$E1AF.
  $E216,$03 Read the byte at #R$DEE0.
  $E219,$03 Call #R$E1E9.
  $E21C,$03 Write #REGhl at #R$E1B5.
  $E21F,$03 Read the byte at #R$DEFD(#N$DEFF).
  $E222,$03 Call #R$E1E9.
  $E225,$03 Write #REGhl at #R$E1BB.
  $E228,$01 Return.

c $E229 Draw Panel
@ $E229 label=DrawPanel
D $E229 Draws the panel at the edges of the screen. This is made of four frames,
. which are drawn with #R$E2E9 using the table at #R$E41B, the pictures and
. the text of the panel, and the attributes of the rectangles at #R$E1E0. The
. direction gauges are also drawn.
. .
. #PUSHS #UDGTABLE { #BLANKSCREEN(0)
. #SIM(start=$E229,stop=$0000,sp=$5B60)
. #SCR$02(draw-panel) } UDGTABLE# #POPS
  $E229,$03 Refresh the digits of the lives and bottles in the panel text.
N $E22C Draw the four frames of the panel: the message box, the game window and
. the frames of the two direction gauges.
  $E22C,$04 Point #REGix at the first frame in the table at #R$E41B.
  $E230,$03 Draw the message box.
  $E233,$03 Draw the game window.
  $E236,$03 Draw the frame of the left direction gauge.
  $E239,$03 Draw the frame of the right direction gauge.
N $E23C Draw the corner pieces beside the message box and the empty dial of each
. direction gauge.
  $E23C,$03 Set the position of the left corner piece.
  $E23F,$03 Point #REGde at #R$6307.
  $E242,$03 Draw it.
  $E245,$03 Set the position of the right corner piece.
  $E248,$03 Point #REGde at #R$630D.
  $E24B,$03 Draw it.
  $E24E,$03 Set the position of the empty dial of the right gauge.
  $E251,$03 Point #REGde at #R$81E5.
  $E254,$03 Draw it.
  $E257,$03 Set the position of the empty dial of the left gauge.
  $E25A,$03 Point #REGde at #R$81E5.
  $E25D,$03 Draw it.
N $E260 Draw the dial and needle of each direction gauge.
  $E260,$02 Set the heading of the needle to #N$08.
  $E262,$03 Store it as the heading to draw.
  $E265,$03 Fetch the column of the second gauge.
  $E268,$03 Patch it into the drawing routine as the column to draw at.
  $E26B,$03 Draw the dial of the second gauge.
  $E26E,$03 Fetch the column of the first gauge.
  $E271,$03 Patch it into the drawing routine as the column to draw at.
  $E274,$02 Set the heading of the needle to #N$08 again.
  $E276,$03 Store it as the heading to draw.
  $E279,$03 Draw the dial of the first gauge.
N $E27C Print the #N$13 text records of the panel: the headings of the scores,
. the digits, the lives and bottles, and the high score.
  $E27C,$03 Point #REGde at #R$E11F.
  $E27F,$02 Set the number of records to #N$13.
  $E281,$03 Print them.
N $E284 Colour the icons on both sides of the panel.
  $E284,$03 Set the position of the left lives icon.
  $E287,$03 Point #REGde at #R$E1E0.
  $E28A,$03 Colour it.
  $E28D,$02 Move across to the right side.
  $E28F,$03 Point #REGde at #R$E1E0.
  $E292,$03 Colour it.
  $E295,$02 Move down to the bottle icons.
  $E297,$03 Point #REGde at #R$E1E3.
  $E29A,$03 Colour the right bottle icon.
  $E29D,$02 Move across to the left side.
  $E29F,$03 Point #REGde at #R$E1E3.
  $E2A2,$03 Colour the left bottle icon.
  $E2A5,$03 Set the position of the left spare icon.
  $E2A8,$03 Point #REGde at #R$E1E6.
  $E2AB,$03 Colour it.
  $E2AE,$02 Move across to the right side.
  $E2B0,$03 Point #REGde at #R$E1E6.
  $E2B3,$03 Colour it.
N $E2B6 Draw the bubbles that show the lives and the bottles of each player.
  $E2B6,$03 Point #REGde at #R$7601.
  $E2B9,$03 Copy it into the picture buffer at #N$F500.
  $E2BC,$03 Set the position of the left bottle.
  $E2BF,$03 Point #REGde at #R$644B.
  $E2C2,$03 Draw it.
  $E2C5,$02 Move across to the right side.
  $E2C7,$03 Point #REGde at #R$644B.
  $E2CA,$03 Draw it.
  $E2CD,$03 Set the position of the left bubble.
  $E2D0,$03 Point #REGde at the buffered bubble picture.
  $E2D3,$03 Draw it.
  $E2D6,$02 Move across to the right side.
  $E2D8,$03 Point #REGde at the buffered bubble picture.
  $E2DB,$03 Draw it.
N $E2DE Draw the empty bars of the two gauges.
  $E2DE,$03 Set the position of the bar of the first gauge.
  $E2E1,$03 Draw it.
  $E2E4,$02 Set the position of the bar of the second gauge.
  $E2E6,$03 Jump to #R$E3D7.

c $E2E9 Draw Frame
@ $E2E9 label=DrawFrame
D $E2E9 Draws a frame, from an entry of #N$05 bytes in the table at #R$E41B,
. and moves on to the next entry. The edges of the frame are made with #R$E3AC,
. #R$E3B0 and #R$E3BD, and the corners with #R$E376.
. .
. #PUSHS #UDGTABLE { #BLANKSCREEN(0)
. #SIM(start=$E2E9,stop=$0000,ix=$E41B,sp=$5B60)
. #SCR$02(draw-frame) } UDGTABLE# #POPS
R $E2E9 IX The entry of the frame
R $E2E9 O:IX The next entry
  $E2E9,$03 Fetch the attribute of the frame.
  $E2EC,$03 Store it in the colour rectangle at #R$AAE2(#N$AAE4).
  $E2EF,$03 Fetch the x position of the frame into #REGl.
  $E2F2,$03 Fetch the y position of the frame into #REGh.
  $E2F5,$01 Save the position.
  $E2F6,$01 Save it again.
  $E2F7,$01 Move down a pixel line, to the row below the frame.
  $E2F8,$03 Fetch the width of the frame.
  $E2FB,$02 Set the height of the rectangle to one row.
  $E2FD,$04 Store the width and the height in the rectangle.
  $E301,$03 Colour the row below the frame.
  $E304,$01 Restore the position.
  $E305,$03 Fetch the height of the frame in pixel lines.
  $E308,$01 Copy the y position into #REGa.
  $E309,$01 Subtract the height of the frame.
  $E30A,$01 Copy it into #REGh, to find the row above the frame.
  $E30B,$03 Colour the row above the frame.
  $E30E,$01 Restore the position.
  $E30F,$01 Move one pixel to the left, beside the frame.
  $E310,$01 Move down a pixel line.
  $E311,$01 Save the position.
  $E312,$02 Set the width of the rectangle to one cell.
  $E314,$03 Fetch the height of the frame.
  $E317,$02 Round it up to a whole number of rows.
  $E319,$02 Halve it.
  $E31B,$02 Halve it again.
  $E31D,$02 Halve it a third time, to find the height in rows.
  $E31F,$01 Copy it into #REGb.
  $E320,$04 Store the width and the height in the rectangle.
  $E324,$03 Colour the column on the left of the frame.
  $E327,$01 Restore the position.
  $E328,$03 Fetch the width of the frame.
  $E32B,$01 Double it.
  $E32C,$01 Double it again.
  $E32D,$01 Double it a third time, to find the width in pixels.
  $E32E,$01 Add the x position.
  $E32F,$01 Add one to find the column on the right of the frame.
  $E330,$01 Copy it into #REGl.
  $E331,$03 Colour the column on the right of the frame.
  $E334,$03 Fetch the x position of the frame into #REGl.
  $E337,$03 Fetch the y position of the frame into #REGh.
  $E33A,$03 Draw the left edge of the frame.
  $E33D,$01 Fetch the x position of the left edge.
  $E33E,$03 Add the width of the frame.
  $E341,$01 Add one.
  $E342,$01 Copy the position of the right edge into #REGl.
  $E343,$03 Draw the right edge of the frame.
  $E346,$03 Fetch the y position of the frame.
  $E349,$02 Add #N$06 to find the y position of the bottom bar.
  $E34B,$01 Copy it into #REGh.
  $E34C,$03 Subtract the height of the frame.
  $E34F,$02 Subtract eight to find the y position of the top bar.
  $E351,$03 Patch it into the instruction at #N$E358.
  $E354,$03 Draw the bottom bar of the frame.
  $E357,$02 Set #REGh to the y position of the top bar (this is patched at
. #N$E358).
  $E359,$03 Draw the top bar of the frame.
  $E35C,$03 Point #REGde at #R$E38C.
  $E35F,$03 Fetch the y position of the frame.
  $E362,$02 Add #N$06 to find the y position of the bottom bar.
  $E364,$03 Draw the corners of the bottom bar.
  $E367,$03 Fetch the y position of the frame.
  $E36A,$03 Subtract the height of the frame.
  $E36D,$03 Draw the corners of the top bar.
  $E370,$03 Set the length of an entry of the frame table.
  $E373,$02 Move #REGix on to the next entry.
  $E375,$01 Return.

c $E376 Draw Frame Corners
@ $E376 label=DrawFrameCorners
D $E376 Draws the pictures for the corners of a frame at the left and the right
. of one of its edges.
R $E376 A The vertical position
R $E376 IX The entry of the frame
  $E376,$01 Copy the y position into #REGh.
  $E377,$03 Fetch the x position of the frame.
  $E37A,$02 Subtract #N$08 to put the corner beside the left end of the bar.
  $E37C,$01 Copy it into #REGl.
  $E37D,$03 Draw the left corner.
  $E380,$03 Fetch the width of the frame.
  $E383,$01 Add one.
  $E384,$01 Double it.
  $E385,$01 Double it again.
  $E386,$01 Double it a third time, to find the width in pixels.
  $E387,$01 Add the x position of the left corner.
  $E388,$01 Copy it into #REGl.
  $E389,$03 Jump to #R$AAC4.

b $E38C Frame Corner Pictures
@ $E38C label=FrameCornerPictures
D $E38C The pictures that are used for the corners of the frames by #R$E376.
B $E38C,$20,$08

c $E3AC Draw Frame Left
@ $E3AC label=DrawFrameLeft
D $E3AC Draws a vertical line of the frame, by setting the bytes of the screen
. to #N$3C. The entry point at #R$E3B0 draws it from an address that is already
. in #REGhl.
R $E3AC HL The position of the line
R $E3AC IX The entry of the frame
  $E3AC,$03 Convert the position into a screen address.
@ $E3AF label=DrawFrameLeft_Move
  $E3AF,$01 Move one byte to the left, beside the frame.
@ $E3B0 label=DrawFrameLeft_Draw
  $E3B0,$03 Fetch the height of the frame in pixel lines.
  $E3B3,$01 Save the screen address.
@ $E3B4 label=DrawFrameLeft_Loop
  $E3B4,$02 Draw a pixel line of the edge.
  $E3B6,$03 Move up a pixel line.
  $E3B9,$02 Repeat until the whole edge is drawn.
  $E3BB,$01 Restore the screen address.
  $E3BC,$01 Return.

c $E3BD Draw Frame Bar
@ $E3BD label=DrawFrameBar
D $E3BD Draws a horizontal bar of four rows for the frame, with each row as wide
. as the frame.
R $E3BD H The vertical position
R $E3BD IX The entry of the frame
  $E3BD,$03 Fetch the x position of the frame into #REGl.
  $E3C0,$02 Set the number of pixel lines in the bar to #N$04.
  $E3C2,$03 Convert the position into a screen address.
@ $E3C5 label=DrawFrameBar_Loop
  $E3C5,$03 Fetch the width of the frame in bytes.
@ $E3C8 label=DrawFrameBar_Loop2
  $E3C8,$02 Draw a byte of the bar.
  $E3CA,$01 Move onto the next byte.
  $E3CB,$02 Repeat until the line is drawn.
  $E3CD,$01 Copy the screen address into #REGa.
  $E3CE,$03 Subtract the width of the frame.
  $E3D1,$01 Copy it back into #REGl, to return to the start of the line.
  $E3D2,$01 Move up a pixel line.
  $E3D3,$01 Decrease the number of pixel lines by one.
  $E3D4,$02 Repeat until the bar is drawn.
  $E3D6,$01 Return.

c $E3D7 Draw Gauge Bar
@ $E3D7 label=DrawGaugeBar
D $E3D7 Draws the empty bar of one of the two gauges, which is made of a picture
. of the left end, nine copies of a picture of the middle and a picture of the
. right end. The bar is then filled by #R$A5A5.
R $E3D7 HL The position of the left end
  $E3D7,$03 Point #REGde at the colour rectangle.
  $E3DA,$03 Colour the bar.
  $E3DD,$03 Point #REGde at the picture of the left end.
  $E3E0,$03 Draw it.
  $E3E3,$02 Set the distance to the next piece to #N$08.
  $E3E5,$01 Add the x position.
  $E3E6,$01 Move across to the next piece.
  $E3E7,$02 Set the number of middle pieces to #N$09.
@ $E3E9 label=DrawGaugeBar_Loop
  $E3E9,$01 Save the counter.
  $E3EA,$03 Point #REGde at the picture of the middle piece.
  $E3ED,$03 Draw it.
  $E3F0,$02 Set the distance to the next piece to #N$08.
  $E3F2,$01 Add the x position.
  $E3F3,$01 Move across to the next piece.
  $E3F4,$01 Restore the counter.
  $E3F5,$02 Repeat until all of the middle pieces are drawn.
  $E3F7,$03 Jump to #R$AAC4.

b $E3FA Gauge Bar Data
@ $E3FA label=GaugeBarData
D $E3FA The rectangle and the pictures that are used by #R$E3D7.
B $E3FA,$21,$08

b $E41B Frame Table
@ $E41B label=FrameTable
D $E41B The four frames that are drawn by #R$E229. Each is #N$05 bytes: the
. position, the width, the height and the attribute.
B $E41B,$14,$05

c $E42F Wipe View Out
@ $E42F label=WipeViewOut
D $E42F Clears the bytes at #N$4FC6 and at #N$F0CD, and then wipes the picture
. away from the screen by calling #R$E487 once for each step of the wipe, which
. goes up from #N$07 to #N$77 in twos.
. .
. #PUSHS #UDGTABLE { #NEWGAME(0)
. #SIM(start=$AA5B,stop=$0000,sp=$5B60)
. #SIM(start=$E076,stop=$E089,sp=$5B60)
. #SIM(start=$E461,stop=$0000,sp=$5B60)
. #SCR$02(wipe-view-out-before)
. | #SIM(start=$E42F,stop=$0000,sp=$5B60)
. #SCR$02(wipe-view-out-after) } UDGTABLE# #POPS
  $E42F,$03 #REGhl is #N$4FC6.
  $E432,$02 #REGb is #N$14.
  $E434,$03 Call #R$A2E0.
  $E437,$03 Point #REGhl at #N$F0CD.
  $E43A,$02 #REGb is #N$2C.
  $E43C,$03 Call #R$A2E0.
  $E43F,$02 #REGa is #N$07.
  $E441,$03 Write #REGa at #R$5CD8.
  $E444,$04 Fetch the word at #R$5CF1 into #REGiy.
  $E448,$01 Enable interrupts.
  $E449,$01 Wait for the next frame.
@ $E44A label=WipeViewOut_Loop
  $E44A,$03 Read the byte at #R$5CD8.
  $E44D,$02 Compare #REGa with #N$77.
  $E44F,$01 Disable interrupts.
  $E450,$01 Return if the zero flag is set.
  $E451,$04 Fetch the word at #R$5CF1 into #REGiy.
  $E455,$01 Enable interrupts.
  $E456,$01 Advance #REGa.
  $E457,$01 Advance #REGa.
  $E458,$03 Write #REGa at #R$5CD8.
  $E45B,$03 Call #R$E487.
  $E45E,$03 Jump to #R$E42F(#N$E44A).

c $E461 Wipe View In
@ $E461 label=WipeViewIn
D $E461 Wipes the picture on to the screen by calling #R$E487 once for each
. step of the wipe, which goes down from #N$78 to #N$08 in twos.
. .
. #PUSHS #UDGTABLE { #NEWGAME(0)
. #SIM(start=$AA5B,stop=$0000,sp=$5B60)
. #SIM(start=$E076,stop=$E089,sp=$5B60)
. #SCR$02(wipe-view-in-before)
. | #SIM(start=$E461,stop=$0000,sp=$5B60)
. #SCR$02(wipe-view-in-after) } UDGTABLE# #POPS
  $E461,$02 #REGa is #N$10.
  $E463,$03 Write #REGa at #R$5CE9.
  $E466,$02 #REGa is #N$78.
  $E468,$03 Write #REGa at #R$5CD8.
  $E46B,$04 Fetch the word at #R$5CF1 into #REGiy.
  $E46F,$01 Enable interrupts.
@ $E470 label=WipeViewIn_Loop
  $E470,$03 Read the byte at #R$5CD8.
  $E473,$01 Disable interrupts.
  $E474,$02 Compare #REGa with #N$08.
  $E476,$01 Return if the zero flag is set.
  $E477,$04 Fetch the word at #R$5CF1 into #REGiy.
  $E47B,$01 Enable interrupts.
  $E47C,$01 Step #REGa back.
  $E47D,$01 Step #REGa back.
  $E47E,$03 Write #REGa at #R$5CD8.
  $E481,$03 Call #R$E487.
  $E484,$03 Jump to #R$E461(#N$E470).

c $E487 Draw Wipe Step
@ $E487 label=DrawWipeStep
D $E487 Draws one step of the wipe, by finding the address in the screen buffer
. with #R$E59E and then waiting for the next frame and copying the picture to
. the screen.
R $E487 A The step
  $E487,$01 #REGa moves into #REGh.
  $E488,$02 #REGl is #N$10.
  $E48A,$04 Write #REGsp at #R$5CDA.
  $E48E,$03 Call #R$E59E.
  $E491,$01 Wait for the next frame.
  $E492,$01 Disable interrupts.
  $E493,$01 #REGhl moves into #REGsp.
  $E494,$03 #REGde is #N$0248.
@ $E497 label=DrawWipeStep_Loop
  $E497,$01 Step #REGde back.
  $E498,$01 #REGd moves into #REGa.
  $E499,$01 Combine #REGa with #REGe.
  $E49A,$02 Jump to #R$E487(#N$E497) if the zero flag is reset.
  $E49C,$03 Read the byte at #R$5CD8.
  $E49F,$02 Add #N$87.
  $E4A1,$01 Invert the bits of #REGa.
  $E4A2,$01 #REGa moves into #REGb.
  $E4A3,$03 Jump to #R$E52B.

w $E4A6 Buffer Row Table
@ $E4A6 label=BufferRowTable
D $E4A6 The addresses of the sixteen rows in the screen buffer, which are #N$18
. bytes apart and are used by #R$E4CC.
W $E4A6,$20,$02

g $E4C6 Restart Candidate
@ $E4C6 label=RestartCandidate
D $E4C6 The position that the player will restart from, which is set by #R$D8E4
. and is copied to #R$DEF5 by #R$E4CC when the player has been on it for long
. enough. Purpose of the individual bytes is not yet known.
B $E4C6,$06,$06

c $E4CC Update Screen
@ $E4CC label=UpdateScreen
D $E4CC Called every frame. Every eighth frame the restart position is updated
. if the player has been standing on a place where it can restart. The frame
. counter is increased and the screen buffer is copied to the screen, starting
. with the rows that are chosen by #R$5CE9. The copy of the buffer to the
. screen is done by using the stack pointer.
. .
. #PUSHS #UDGTABLE { #NEWGAME(0)
. #SIM(start=$AA5B,stop=$0000,sp=$5B60)
. #SIM(start=$E076,stop=$E089,sp=$5B60)
. #SCR$02(update-screen-before)
. | #SIM(start=$E4CC,stop=$0000,sp=$5B60)
. #SCR$02(update-screen-after) } UDGTABLE# #POPS
N $E4CC Every eighth frame, remember where the player is standing so that a new
. life can start from there.
  $E4CC,$03 Fetch the frame counter.
  $E4CF,$02,b$01 Use bits 0-2.
  $E4D1,$02 Jump to #R$E50D unless this is an eighth frame.
  $E4D3,$03 Read field #N$1E of the player entity.
  $E4D6,$02,b$01 Keep bit 7, which is set if the player is on the ground.
  $E4D8,$02 Jump to #R$E50A if the player is not on the ground, to forget the
. place that was found.
  $E4DA,$03 Read the byte at #R$E4C6(#N$E4C7), which is not zero if a place to
. restart from has been found.
  $E4DD,$01 Test it.
  $E4DE,$02 Jump to #R$E50D if no place has been found.
  $E4E0,$03 Fetch the type of the player entity.
  $E4E3,$01 Decrease it by one.
  $E4E4,$02 #REGa is #N$00, ready to forget the place.
  $E4E6,$02 Jump to #R$E50A if the player is not of type #N$01, to forget the
. place that was found.
N $E4E8 Copy the place that was found to the restart position of the level.
  $E4E8,$03 Read the byte at #R$E4C6.
  $E4EB,$03 Store it at #R$DEF5(#N$DEF6).
  $E4EE,$05 Read the byte at #R$E4C6(#N$E4C7) and take away #N$20.
  $E4F3,$01 Keep it in #REGb.
  $E4F4,$03 Read the byte at #R$E4C6(#N$E4CB).
  $E4F7,$02,b$01 Use bits 4-7.
  $E4F9,$01 Combine them with the byte in #REGb.
  $E4FA,$03 Store them at #R$DEF5.
  $E4FD,$03 Read the byte at #R$E4C6(#N$E4C9).
  $E500,$03 Store it at #R$DEF5(#N$DEF7).
  $E503,$03 Read the byte at #R$E4C6(#N$E4C8).
  $E506,$03 Store it at #R$DEF5(#N$DEF8).
  $E509,$01 #REGa is #N$00.
@ $E50A label=UpdateScreen_Store
  $E50A,$03 Forget the place that was found.
@ $E50D label=UpdateScreen_Count
N $E50D Count the frame, and make the random numbers move on.
  $E50D,$03 Fetch the frame counter into #REGhl.
  $E510,$01 Add one to it.
  $E511,$03 Store it.
  $E514,$03 Update the random number.
N $E517 Copy the screen buffer to the game window, one pixel line at a time,
. starting from the line that is chosen by #R$5CE9. The stack pointer is used to
. read the buffer, which saves time.
  $E517,$04 Store the stack pointer, which is restored at the end.
  $E51B,$03 Fetch the number that selects the first line.
  $E51E,$03 Point #REGhl at the table of line addresses at #R$E4A6.
  $E521,$03 Find the entry in the table.
  $E524,$03 Fetch the address of the first line of the buffer into #REGde.
  $E527,$02 Set the number of pixel lines to copy to #N$70.
  $E529,$02 Point the stack pointer at the first line of the buffer.
@ $E52B label=UpdateScreen_Copy
  $E52B,$03 Set #REGhl to the screen address of the first pixel line of the game
. window, #N$4026.
  $E52E,$03 Jump to #R$E544 to copy the first line.
@ $E531 label=UpdateScreen_Row
N $E531 Move down by one pixel line on the screen.
  $E531,$01 Go back to the first column of the window.
  $E532,$01 Move down a pixel line.
  $E533,$01 Fetch the screen address into #REGa.
  $E534,$02,b$01 Use bits 0-2, which are zero at the start of a character row.
  $E536,$03 Jump to #R$E544 if the line is in the same character row.
  $E539,$03 Move on to the next character row...
  $E53C,$01 ...by adding #N$20.
  $E53D,$03 Jump to #R$E544 if that stays in the same third of the screen.
  $E540,$04 Move on to the next third of the screen.
@ $E544 label=UpdateScreen_Bytes
N $E544 Copy twenty bytes of the buffer to the screen, and skip the last four
. bytes of the line in the buffer.
  $E544,$01 Keep the first column of the line in #REGc.
  $E545,$05 Copy the first two bytes of the line.
  $E54A,$05 Copy the next two bytes of the line.
  $E54F,$05 Copy the next two bytes of the line.
  $E554,$05 Copy the next two bytes of the line.
  $E559,$05 Copy the next two bytes of the line.
  $E55E,$05 Copy the next two bytes of the line.
  $E563,$05 Copy the next two bytes of the line.
  $E568,$05 Copy the next two bytes of the line.
  $E56D,$05 Copy the next two bytes of the line.
  $E572,$04 Copy the last two bytes of the line.
  $E576,$02 Skip the four bytes at the end of the line in the buffer.
  $E578,$02 Decrease the line counter and loop back to #R$E531 until all #N$70
. lines have been copied.
@ $E57A label=UpdateScreen_Return
  $E57A,$04 Restore the stack pointer.
  $E57E,$01 Return.

c $E57F Clear Buffer
@ $E57F label=ClearBuffer
D $E57F Clears the screen buffer, by pushing zeroes on the stack.
  $E57F,$04 Remember the stack pointer.
  $E583,$03 The stack starts just past the screen buffer.
  $E586,$02 There are #N$80 rows.
  $E588,$03 The fill value is zero.
@ $E58B label=ClearBuffer_Row
  $E58B,$0C Fill one row with zero.
  $E597,$02 The next row.
  $E599,$04 Bring the stack pointer back.
  $E59D,$01 Return.

c $E59E Get Buffer Address
@ $E59E label=GetBufferAddress
D $E59E Finds the address in the screen buffer of a position, which is the
. buffer address plus the row times #N$18 plus the column.
R $E59E H The row
R $E59E L The pixel column
R $E59E O:HL The address
  $E59E,$01 Remember the registers in #REGde.
  $E59F,$04 Shift the pixel column down by three.
  $E5A3,$02,b$01 Use the low five bits as the byte column.
  $E5A5,$01 Remember the byte column.
  $E5A6,$03 The row is the high byte, in a word of its own.
  $E5A9,$07 Multiply the row by #N$18.
  $E5B0,$05 Add the byte column.
  $E5B5,$04 Add the screen buffer base.
  $E5B9,$01 Restore the registers.
  $E5BA,$01 Return.

g $E5BB Screen Buffer
@ $E5BB label=ScreenBuffer
D $E5BB The start of the screen buffer, which has #N$80 rows of #N$18 bytes and
. ends at #N$F1BA, after the end of the data of the file. The picture of the
. view is built here before it is copied to the screen. The bytes here when the
. game is saved are whatever was last drawn.
B $E5BB,$C0,$18
@ $E67B label=ScreenBuffer_Row08
B $E67B,$79D,$18

i $EE18



