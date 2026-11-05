; Copyright Ashby Computers & Graphics Ltd 1984, Rare Ltd, 2026 ArcadeGeek LTD.
> $4000 @org=$4000
> $4000 @rom
> $4000 @expand=#DEF(#POKE()(anchor,text) #LINK(Pokes#$anchor)($text))
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))
b $4000 Loading screen
@ $4000 label=Loading
D $4000 #UDGTABLE { =h Sabre Wulf Loading Screen } { #SCR$02(loading) } UDGTABLE#
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

c $5B80 Decryption Routine
@ $5B80 label=Decryption
D $5B80 The bytes in this region are all #N$00 in the snapshot used for this
. disassembly (the routine is not present in memory), so the instructions below
. are the documented operation of the loader's decryption routine rather than
. something that can be checked against the bytes here.
E $5B80 View the equivalent code in #LUNARJETMAN$5B80.
E $5B80 Earlier Ultimate games use a much simpler mechanism;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #PSSST$5B80 }
. { #TRANZAM$5B80 }
. LIST#
N $5B80 Runs "CPL" on each byte starting from #R$6000.
  $5B80,$03 #REGhl=#R$6000.
@ $5B83 label=Decryption_Loop
  $5B83,$01 #REGa=#REGhl.
  $5B84,$01 CPL operation.
  $5B85,$01 Write #REGa back to #REGhl.
  $5B86,$01 Increment #REGhl by one.
  $5B87,$01 Return.

i $5B88

c $5CB0 Indirect Jump
@ $5CB0 label=IndirectJump
E $5CB0 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$5CB0 }
. { #LUNARJETMAN$5CB0 }
. { #NIGHTSHADE$5CB0 }
. { #PSSST$5CB0 }
. { #TRANZAM$5CB0 }
. LIST#
  $5CB0,$01 Jump to the address held in #REGhl.

i $5CB1

c $6000 Game Entry Point
@ $6000 label=GameEntry
D $6000 Where the game starts once it has been decrypted. The stack is set up
. just below this routine and control passes to the security check at #R$995A.
E $6000 View the equivalent code in;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #TRANZAM$5B80 }
. { #UNDERWURLDE$7680 }
. LIST#
  $6000,$01 Disable interrupts.
  $6001,$03 Set the stack pointer to #N$6000.
  $6004,$03 Jump to #R$995A.

t $6007 Messaging: Copyright
@ $6007 label=CopyrightNotice
D $6007 The copyright notice of the game. Nothing in the code refers to it.
  $6007,$2F "#STR(#PC,$04,$2F)".

b $6036 Room Entry X Positions
@ $6036 label=RoomEntryXPositions
D $6036 The X position at which an actor is placed when it enters a room from
. above (see #R$B12F). There is one byte for each of the #N$30 room layouts, and
. the layout of a room is found from the table at #R$6066.
B $6036,$30,$10

b $6066 Layout
@ $6066 label=Layout
D $6066 The room layout table. There is one byte for each of the #N$100 rooms,
. with the room number as the index (the room to the left or right is one more
. or less and the room below or above is #N$10 more or less). Each byte is the
. number of the layout of the room, which is the index into #R$6036 and
. #R$6166.
  $6066,$100,$10

w $6166 Room Table
@ $6166 label=RoomTable
D $6166 The address of the room data for each of the #N$30 room layouts (see
. #R$6066). The room data is drawn by #R$BBF7.
W $6166,$02 Room ID: #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100)(#N(#EVAL((#PC - $6166) / $02))).
L $6166,$02,$30

w $61C6 Special Room (Main Menu)
@ $61C6 label=Room_Special_MainMenu
D $61C6 This is the room data showing on the Main Menu screen. See #R$B3D5.
D $61C6 #UDGTABLE { #ROOM(#PC)(room-mainmenu) } UDGTABLE#
. #PUSHS #UDGTABLE { =h The Main Menu screen }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$B3D5,stop=$B3EC,sp=$5B40)
. #SCR$02(main-menu) } UDGTABLE# #POPS
  $61C6,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $61C8,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $61C6,$04,$0E
  $61FE,$02 Terminator.

w $6200 Room #N$00
@ $6200 label=Room_00
D $6200 #UDGTABLE { #ROOM(#PC)(room-00) } UDGTABLE#
  $6200,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6202,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6200,$04,$12
  $6248,$02 Terminator.

w $624A Room #N$01
@ $624A label=Room_01
D $624A #UDGTABLE { #ROOM(#PC)(room-01) } UDGTABLE#
  $624A,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $624C,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $624A,$04,$12
  $6292,$02 Terminator.

w $6294 Room #N$02
@ $6294 label=Room_02
D $6294 #UDGTABLE { #ROOM(#PC)(room-02) } UDGTABLE#
  $6294,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6296,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6294,$04,$12
  $62DC,$02 Terminator.

w $62DE Room #N$03
@ $62DE label=Room_03
D $62DE #UDGTABLE { #ROOM(#PC)(room-03) } UDGTABLE#
  $62DE,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $62E0,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $62DE,$04,$14
  $632E,$02 Terminator.

w $6330 Room #N$04
@ $6330 label=Room_04
D $6330 #UDGTABLE { #ROOM(#PC)(room-04) } UDGTABLE#
  $6330,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6332,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6330,$04,$11
  $6374,$02 Terminator.

w $6376 Room #N$05
@ $6376 label=Room_05
D $6376 #UDGTABLE { #ROOM(#PC)(room-05) } UDGTABLE#
  $6376,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6378,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6376,$04,$16
  $63CE,$02 Terminator.

w $63D0 Room #N$06
@ $63D0 label=Room_06
D $63D0 #UDGTABLE { #ROOM(#PC)(room-06) } UDGTABLE#
  $63D0,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $63D2,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $63D0,$04,$14
  $6420,$02 Terminator.

w $6422 Room #N$07
@ $6422 label=Room_07
D $6422 #UDGTABLE { #ROOM(#PC)(room-07) } UDGTABLE#
  $6422,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6424,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6422,$04,$16
  $647A,$02 Terminator.

w $647C Room #N$08
@ $647C label=Room_08
D $647C #UDGTABLE { #ROOM(#PC)(room-08) } UDGTABLE#
  $647C,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $647E,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $647C,$04,$13
  $64C8,$02 Terminator.

w $64CA Room #N$09
@ $64CA label=Room_09
D $64CA #UDGTABLE { #ROOM(#PC)(room-09) } UDGTABLE#
  $64CA,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $64CC,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $64CA,$04,$15
  $651E,$02 Terminator.

w $6520 Room #N$0A
@ $6520 label=Room_0A
D $6520 #UDGTABLE { #ROOM(#PC)(room-0A) } UDGTABLE#
  $6520,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6522,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6520,$04,$19
  $6584,$02 Terminator.

w $6586 Room #N$0B
@ $6586 label=Room_0B
D $6586 #UDGTABLE { #ROOM(#PC)(room-0B) } UDGTABLE#
  $6586,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6588,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6586,$04,$0E
  $65BE,$02 Terminator.

w $65C0 Room #N$0C
@ $65C0 label=Room_0C
D $65C0 #UDGTABLE { #ROOM(#PC)(room-0C) } UDGTABLE#
  $65C0,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $65C2,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $65C0,$04,$15
  $6614,$02 Terminator.

w $6616 Room #N$0D
@ $6616 label=Room_0D
D $6616 #UDGTABLE { #ROOM(#PC)(room-0D) } UDGTABLE#
  $6616,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6618,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6616,$04,$15
  $666A,$02 Terminator.

w $666C Room #N$0E
@ $666C label=Room_0E
D $666C #UDGTABLE { #ROOM(#PC)(room-0E) } UDGTABLE#
  $666C,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $666E,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $666C,$04,$11
  $66B0,$02 Terminator.

w $66B2 Room #N$0F
@ $66B2 label=Room_0F
D $66B2 #UDGTABLE { #ROOM(#PC)(room-0F) } UDGTABLE#
  $66B2,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $66B4,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $66B2,$04,$1A
  $671A,$02 Terminator.

w $671C Room #N$10
@ $671C label=Room_10
D $671C #UDGTABLE { #ROOM(#PC)(room-10) } UDGTABLE#
  $671C,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $671E,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $671C,$04,$1A
  $6784,$02 Terminator.

w $6786 Room #N$11
@ $6786 label=Room_11
D $6786 #UDGTABLE { #ROOM(#PC)(room-11) } UDGTABLE#
  $6786,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6788,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6786,$04,$18
  $67E6,$02 Terminator.

w $67E8 Room #N$12
@ $67E8 label=Room_12
D $67E8 #UDGTABLE { #ROOM(#PC)(room-12) } UDGTABLE#
  $67E8,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $67EA,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $67E8,$04,$0D
  $681C,$02 Terminator.

w $681E Room #N$13
@ $681E label=Room_13
D $681E #UDGTABLE { #ROOM(#PC)(room-13) } UDGTABLE#
  $681E,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6820,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $681E,$04,$11
  $6862,$02 Terminator.

w $6864 Room #N$14
@ $6864 label=Room_14
D $6864 #UDGTABLE { #ROOM(#PC)(room-14) } UDGTABLE#
  $6864,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6866,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6864,$04,$13
  $68B0,$02 Terminator.

w $68B2 Room #N$15
@ $68B2 label=Room_15
D $68B2 #UDGTABLE { #ROOM(#PC)(room-15) } UDGTABLE#
  $68B2,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $68B4,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $68B2,$04,$12
  $68FA,$02 Terminator.

w $68FC Room #N$16
@ $68FC label=Room_16
D $68FC #UDGTABLE { #ROOM(#PC)(room-16) } UDGTABLE#
  $68FC,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $68FE,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $68FC,$04,$0F
  $6938,$02 Terminator.

w $693A Room #N$17
@ $693A label=Room_17
D $693A #UDGTABLE { #ROOM(#PC)(room-17) } UDGTABLE#
  $693A,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $693C,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $693A,$04,$13
  $6986,$02 Terminator.

w $6988 Room #N$18
@ $6988 label=Room_18
D $6988 #UDGTABLE { #ROOM(#PC)(room-18) } UDGTABLE#
  $6988,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $698A,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6988,$04,$15
  $69DC,$02 Terminator.

w $69DE Room #N$19
@ $69DE label=Room_19
D $69DE #UDGTABLE { #ROOM(#PC)(room-19) } UDGTABLE#
  $69DE,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $69E0,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $69DE,$04,$16
  $6A36,$02 Terminator.

w $6A38 Room #N$1A
@ $6A38 label=Room_1A
D $6A38 #UDGTABLE { #ROOM(#PC)(room-1A) } UDGTABLE#
  $6A38,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6A3A,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6A38,$04,$11
  $6A7C,$02 Terminator.

w $6A7E Room #N$1B
@ $6A7E label=Room_1B
D $6A7E #UDGTABLE { #ROOM(#PC)(room-1B) } UDGTABLE#
  $6A7E,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6A80,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6A7E,$04,$11
  $6AC2,$02 Terminator.

w $6AC4 Room #N$1C
@ $6AC4 label=Room_1C
D $6AC4 #UDGTABLE { #ROOM(#PC)(room-1C) } UDGTABLE#
  $6AC4,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6AC6,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6AC4,$04,$15
  $6B18,$02 Terminator.

w $6B1A Room #N$1D
@ $6B1A label=Room_1D
D $6B1A #UDGTABLE { #ROOM(#PC)(room-1D) } UDGTABLE#
  $6B1A,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6B1C,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6B1A,$04,$15
  $6B6E,$02 Terminator.

w $6B70 Room #N$1E
@ $6B70 label=Room_1E
D $6B70 #UDGTABLE { #ROOM(#PC)(room-1E) } UDGTABLE#
  $6B70,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6B72,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6B70,$04,$12
  $6BB8,$02 Terminator.

w $6BBA Room #N$1F
@ $6BBA label=Room_1F
D $6BBA #UDGTABLE { #ROOM(#PC)(room-1F) } UDGTABLE#
  $6BBA,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6BBC,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6BBA,$04,$13
  $6C06,$02 Terminator.

w $6C08 Room #N$20
@ $6C08 label=Room_20
D $6C08 #UDGTABLE { #ROOM(#PC)(room-20) } UDGTABLE#
  $6C08,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6C0A,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6C08,$04,$17
  $6C64,$02 Terminator.

w $6C66 Room #N$21
@ $6C66 label=Room_21
D $6C66 #UDGTABLE { #ROOM(#PC)(room-21) } UDGTABLE#
  $6C66,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6C68,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6C66,$04,$15
  $6CBA,$02 Terminator.

w $6CBC Room #N$22
@ $6CBC label=Room_22
D $6CBC #UDGTABLE { #ROOM(#PC)(room-22) } UDGTABLE#
  $6CBC,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6CBE,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6CBC,$04,$14
  $6D0C,$02 Terminator.

w $6D0E Room #N$23
@ $6D0E label=Room_23
D $6D0E #UDGTABLE { #ROOM(#PC)(room-23) } UDGTABLE#
  $6D0E,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6D10,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6D0E,$04,$12
  $6D56,$02 Terminator.

w $6D58 Room #N$24
@ $6D58 label=Room_24
D $6D58 #UDGTABLE { #ROOM(#PC)(room-24) } UDGTABLE#
  $6D58,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6D5A,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6D58,$04,$16
  $6DB0,$02 Terminator.

w $6DB2 Room #N$25
@ $6DB2 label=Room_25
D $6DB2 #UDGTABLE { #ROOM(#PC)(room-25) } UDGTABLE#
  $6DB2,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6DB4,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6DB2,$04,$17
  $6E0E,$02 Terminator.

w $6E10 Room #N$26
@ $6E10 label=Room_26
D $6E10 #UDGTABLE { #ROOM(#PC)(room-26) } UDGTABLE#
  $6E10,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6E12,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6E10,$04,$13
  $6E5C,$02 Terminator.

w $6E5E Room #N$27
@ $6E5E label=Room_27
D $6E5E #UDGTABLE { #ROOM(#PC)(room-27) } UDGTABLE#
  $6E5E,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6E60,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6E5E,$04,$10
  $6E9E,$02 Terminator.

w $6EA0 Room #N$28
@ $6EA0 label=Room_28
D $6EA0 #UDGTABLE { #ROOM(#PC)(room-28) } UDGTABLE#
  $6EA0,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6EA2,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6EA0,$04,$13
  $6EEC,$02 Terminator.

w $6EEE Room #N$29
@ $6EEE label=Room_29
D $6EEE #UDGTABLE { #ROOM(#PC)(room-29) } UDGTABLE#
  $6EEE,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6EF0,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6EEE,$04,$11
  $6F32,$02 Terminator.

w $6F34 Room #N$2A
@ $6F34 label=Room_2A
D $6F34 #UDGTABLE { #ROOM(#PC)(room-2A) } UDGTABLE#
  $6F34,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6F36,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6F34,$04,$0E
  $6F6C,$02 Terminator.

w $6F6E Room #N$2B
@ $6F6E label=Room_2B
D $6F6E #UDGTABLE { #ROOM(#PC)(room-2B) } UDGTABLE#
  $6F6E,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6F70,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6F6E,$04,$10
  $6FAE,$02 Terminator.

w $6FB0 Room #N$2C
@ $6FB0 label=Room_2C
D $6FB0 #UDGTABLE { #ROOM(#PC)(room-2C) } UDGTABLE#
  $6FB0,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6FB2,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6FB0,$04,$10
  $6FF0,$02 Terminator.

w $6FF2 Room #N$2D
@ $6FF2 label=Room_2D
D $6FF2 #UDGTABLE { #ROOM(#PC)(room-2D) } UDGTABLE#
  $6FF2,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6FF4,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6FF2,$04,$0F
  $702E,$02 Terminator.

w $7030 Room #N$2E
@ $7030 label=Room_2E
D $7030 #UDGTABLE { #ROOM(#PC)(room-2E) } UDGTABLE#
  $7030,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $7032,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $7030,$04,$11
  $7074,$02 Terminator.

w $7076 Room #N$2F
@ $7076 label=Room_2F
D $7076 #UDGTABLE { #ROOM(#PC)(room-2F) } UDGTABLE#
  $7076,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $7078,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $7076,$04,$11
  $70BA,$02 Terminator.

b $70BC Background Graphic #N$01
D $70BC #BG(#PC)(background-#PC)
N $70BC Pixels.
  $70BC,$01 Height = #N(#PEEK(#PC)) pixels.
  $70BD,$01 Width = #N(#PEEK(#PC)) bytes.
  $70BE,$D8,$08 Pixel data.
N $7196 Attributes.
  $7196,$01 Height = #N(#PEEK(#PC)) bytes.
  $7197,$01 Width = #N(#PEEK(#PC)) bytes.
  $7198,$1B,$08 Attribute data.

b $71B3 Background Graphic #N$02
D $71B3 #BG(#PC)(background-#PC)
N $71B3 Pixels.
  $71B3,$01 Height = #N(#PEEK(#PC)) pixels.
  $71B4,$01 Width = #N(#PEEK(#PC)) bytes.
  $71B5,$C8,$08 Pixel data.
N $727D Attributes.
  $727D,$01 Height = #N(#PEEK(#PC)) bytes.
  $727E,$01 Width = #N(#PEEK(#PC)) bytes.
  $727F,$19,$08 Attribute data.

b $7298 Background Graphic #N$03
D $7298 #BG(#PC)(background-#PC)
N $7298 Pixels.
  $7298,$01 Height = #N(#PEEK(#PC)) pixels.
  $7299,$01 Width = #N(#PEEK(#PC)) bytes.
  $729A,$50,$08 Pixel data.
N $72EA Attributes.
  $72EA,$01 Height = #N(#PEEK(#PC)) bytes.
  $72EB,$01 Width = #N(#PEEK(#PC)) bytes.
  $72EC,$0A,$08 Attribute data.

b $72F6 Background Graphic #N$04
D $72F6 #BG(#PC)(background-#PC)
N $72F6 Pixels.
  $72F6,$01 Height = #N(#PEEK(#PC)) pixels.
  $72F7,$01 Width = #N(#PEEK(#PC)) bytes.
  $72F8,$140,$08 Pixel data.
N $7438 Attributes.
  $7438,$01 Height = #N(#PEEK(#PC)) bytes.
  $7439,$01 Width = #N(#PEEK(#PC)) bytes.
  $743A,$28,$08 Attribute data.

b $7462 Background Graphic #N$05
D $7462 #BG(#PC)(background-#PC)
N $7462 Pixels.
  $7462,$01 Height = #N(#PEEK(#PC)) pixels.
  $7463,$01 Width = #N(#PEEK(#PC)) bytes.
  $7464,$A8,$08 Pixel data.
N $750C Attributes.
  $750C,$01 Height = #N(#PEEK(#PC)) bytes.
  $750D,$01 Width = #N(#PEEK(#PC)) bytes.
  $750E,$15,$08 Attribute data.

b $7523 Background Graphic #N$06
D $7523 #BG(#PC)(background-#PC)
N $7523 Pixels.
  $7523,$01 Height = #N(#PEEK(#PC)) pixels.
  $7524,$01 Width = #N(#PEEK(#PC)) bytes.
  $7525,$1C0,$08 Pixel data.
N $76E5 Attributes.
  $76E5,$01 Height = #N(#PEEK(#PC)) bytes.
  $76E6,$01 Width = #N(#PEEK(#PC)) bytes.
  $76E7,$38,$08 Attribute data.

b $771F Background Graphic #N$07
D $771F #BG(#PC)(background-#PC)
N $771F Pixels.
  $771F,$01 Height = #N(#PEEK(#PC)) pixels.
  $7720,$01 Width = #N(#PEEK(#PC)) bytes.
  $7721,$118,$08 Pixel data.
N $7839 Attributes.
  $7839,$01 Height = #N(#PEEK(#PC)) bytes.
  $783A,$01 Width = #N(#PEEK(#PC)) bytes.
  $783B,$23,$08 Attribute data.

b $785E Background Graphic #N$08
D $785E #BG(#PC)(background-#PC)
N $785E Pixels.
  $785E,$01 Height = #N(#PEEK(#PC)) pixels.
  $785F,$01 Width = #N(#PEEK(#PC)) bytes.
  $7860,$80,$08 Pixel data.
N $78E0 Attributes.
  $78E0,$01 Height = #N(#PEEK(#PC)) bytes.
  $78E1,$01 Width = #N(#PEEK(#PC)) bytes.
  $78E2,$10,$08 Attribute data.

b $78F2 Background Graphic #N$09
D $78F2 #BG(#PC)(background-#PC)
N $78F2 Pixels.
  $78F2,$01 Height = #N(#PEEK(#PC)) pixels.
  $78F3,$01 Width = #N(#PEEK(#PC)) bytes.
  $78F4,$48,$08 Pixel data.
N $793C Attributes.
  $793C,$01 Height = #N(#PEEK(#PC)) bytes.
  $793D,$01 Width = #N(#PEEK(#PC)) bytes.
  $793E,$09,$08 Attribute data.

b $7947 Background Graphic #N$0A
D $7947 #BG(#PC)(background-#PC)
N $7947 Pixels.
  $7947,$01 Height = #N(#PEEK(#PC)) pixels.
  $7948,$01 Width = #N(#PEEK(#PC)) bytes.
  $7949,$30,$08 Pixel data.
N $7979 Attributes.
  $7979,$01 Height = #N(#PEEK(#PC)) bytes.
  $797A,$01 Width = #N(#PEEK(#PC)) bytes.
  $797B,$06,$08 Attribute data.

b $7981 Background Graphic #N$0B
D $7981 #BG(#PC)(background-#PC)
N $7981 Pixels.
  $7981,$01 Height = #N(#PEEK(#PC)) pixels.
  $7982,$01 Width = #N(#PEEK(#PC)) bytes.
  $7983,$160,$08 Pixel data.
N $7AE3 Attributes.
  $7AE3,$01 Height = #N(#PEEK(#PC)) bytes.
  $7AE4,$01 Width = #N(#PEEK(#PC)) bytes.
  $7AE5,$2C,$08 Attribute data.

b $7B11 Background Graphic #N$0C
D $7B11 #BG(#PC)(background-#PC)
N $7B11 Pixels.
  $7B11,$01 Height = #N(#PEEK(#PC)) pixels.
  $7B12,$01 Width = #N(#PEEK(#PC)) bytes.
  $7B13,$90,$08 Pixel data.
N $7BA3 Attributes.
  $7BA3,$01 Height = #N(#PEEK(#PC)) bytes.
  $7BA4,$01 Width = #N(#PEEK(#PC)) bytes.
  $7BA5,$12,$08 Attribute data.

b $7BB7 Background Graphic #N$0D
D $7BB7 #BG(#PC)(background-#PC)
N $7BB7 Pixels.
  $7BB7,$01 Height = #N(#PEEK(#PC)) pixels.
  $7BB8,$01 Width = #N(#PEEK(#PC)) bytes.
  $7BB9,$48,$08 Pixel data.
N $7C01 Attributes.
  $7C01,$01 Height = #N(#PEEK(#PC)) bytes.
  $7C02,$01 Width = #N(#PEEK(#PC)) bytes.
  $7C03,$09,$08 Attribute data.

b $7C0C Background Graphic #N$0E
D $7C0C #BG(#PC)(background-#PC)
N $7C0C Pixels.
  $7C0C,$01 Height = #N(#PEEK(#PC)) pixels.
  $7C0D,$01 Width = #N(#PEEK(#PC)) bytes.
  $7C0E,$A8,$08 Pixel data.
N $7CB6 Attributes.
  $7CB6,$01 Height = #N(#PEEK(#PC)) bytes.
  $7CB7,$01 Width = #N(#PEEK(#PC)) bytes.
  $7CB8,$15,$08 Attribute data.

b $7CCD Background Graphic #N$0F
D $7CCD #BG(#PC)(background-#PC)
N $7CCD Pixels.
  $7CCD,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CCE,$01 Width = #N(#PEEK(#PC)) bytes.
  $7CCF,$150,$08 Pixel data.
N $7E1F Attributes.
  $7E1F,$01 Height = #N(#PEEK(#PC)) bytes.
  $7E20,$01 Width = #N(#PEEK(#PC)) bytes.
  $7E21,$2A,$08 Attribute data.

b $7E4B Background Graphic #N$10
D $7E4B #BG(#PC)(background-#PC)
N $7E4B Pixels.
  $7E4B,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E4C,$01 Width = #N(#PEEK(#PC)) bytes.
  $7E4D,$1C0,$08 Pixel data.
N $800D Attributes.
  $800D,$01 Height = #N(#PEEK(#PC)) bytes.
  $800E,$01 Width = #N(#PEEK(#PC)) bytes.
  $800F,$38,$08 Attribute data.

b $8047 Background Graphic #N$11
D $8047 #BG(#PC)(background-#PC)
N $8047 Pixels.
  $8047,$01 Height = #N(#PEEK(#PC)) pixels.
  $8048,$01 Width = #N(#PEEK(#PC)) bytes.
  $8049,$150,$08 Pixel data.
N $8199 Attributes.
  $8199,$01 Height = #N(#PEEK(#PC)) bytes.
  $819A,$01 Width = #N(#PEEK(#PC)) bytes.
  $819B,$2A,$08 Attribute data.

b $81C5 Background Graphic #N$12
D $81C5 #BG(#PC)(background-#PC)
N $81C5 Pixels.
  $81C5,$01 Height = #N(#PEEK(#PC)) pixels.
  $81C6,$01 Width = #N(#PEEK(#PC)) bytes.
  $81C7,$188,$08 Pixel data.
N $834F Attributes.
  $834F,$01 Height = #N(#PEEK(#PC)) bytes.
  $8350,$01 Width = #N(#PEEK(#PC)) bytes.
  $8351,$31,$08 Attribute data.

b $8382 Background Graphic #N$13
D $8382 #BG(#PC)(background-#PC)
N $8382 Pixels.
  $8382,$01 Height = #N(#PEEK(#PC)) pixels.
  $8383,$01 Width = #N(#PEEK(#PC)) bytes.
  $8384,$20,$08 Pixel data.
N $83A4 Attributes.
  $83A4,$01 Height = #N(#PEEK(#PC)) bytes.
  $83A5,$01 Width = #N(#PEEK(#PC)) bytes.
  $83A6,$04,$08 Attribute data.

b $83AA Background Graphic #N$14
D $83AA #BG(#PC)(background-#PC)
N $83AA Pixels.
  $83AA,$01 Height = #N(#PEEK(#PC)) pixels.
  $83AB,$01 Width = #N(#PEEK(#PC)) bytes.
  $83AC,$20,$08 Pixel data.
N $83CC Attributes.
  $83CC,$01 Height = #N(#PEEK(#PC)) bytes.
  $83CD,$01 Width = #N(#PEEK(#PC)) bytes.
  $83CE,$04,$08 Attribute data.

b $83D2 Background Graphic #N$15
D $83D2 #BG(#PC)(background-#PC)
N $83D2 Pixels.
  $83D2,$01 Height = #N(#PEEK(#PC)) pixels.
  $83D3,$01 Width = #N(#PEEK(#PC)) bytes.
  $83D4,$48,$08 Pixel data.
N $841C Attributes.
  $841C,$01 Height = #N(#PEEK(#PC)) bytes.
  $841D,$01 Width = #N(#PEEK(#PC)) bytes.
  $841E,$09,$08 Attribute data.

b $8427 Background Graphic #N$16
D $8427 #BG(#PC)(background-#PC)
N $8427 Pixels.
  $8427,$01 Height = #N(#PEEK(#PC)) pixels.
  $8428,$01 Width = #N(#PEEK(#PC)) bytes.
  $8429,$48,$08 Pixel data.
N $8471 Attributes.
  $8471,$01 Height = #N(#PEEK(#PC)) bytes.
  $8472,$01 Width = #N(#PEEK(#PC)) bytes.
  $8473,$09,$08 Attribute data.

b $847C Background Graphic #N$17
D $847C #BG(#PC)(background-#PC)
N $847C Pixels.
  $847C,$01 Height = #N(#PEEK(#PC)) pixels.
  $847D,$01 Width = #N(#PEEK(#PC)) bytes.
  $847E,$C0,$08 Pixel data.
N $853E Attributes.
  $853E,$01 Height = #N(#PEEK(#PC)) bytes.
  $853F,$01 Width = #N(#PEEK(#PC)) bytes.
  $8540,$18,$08 Attribute data.

b $8558 Background Graphic #N$18
D $8558 #BG(#PC)(background-#PC)
N $8558 Pixels.
  $8558,$01 Height = #N(#PEEK(#PC)) pixels.
  $8559,$01 Width = #N(#PEEK(#PC)) bytes.
  $855A,$60,$08 Pixel data.
N $85BA Attributes.
  $85BA,$01 Height = #N(#PEEK(#PC)) bytes.
  $85BB,$01 Width = #N(#PEEK(#PC)) bytes.
  $85BC,$0C,$08 Attribute data.

b $85C8 Background Graphic #N$19
D $85C8 #BG(#PC)(background-#PC)
N $85C8 Pixels.
  $85C8,$01 Height = #N(#PEEK(#PC)) pixels.
  $85C9,$01 Width = #N(#PEEK(#PC)) bytes.
  $85CA,$F0,$08 Pixel data.
N $86BA Attributes.
  $86BA,$01 Height = #N(#PEEK(#PC)) bytes.
  $86BB,$01 Width = #N(#PEEK(#PC)) bytes.
  $86BC,$1E,$08 Attribute data.

b $86DA Background Graphic #N$1A
D $86DA #BG(#PC)(background-#PC)
N $86DA Pixels.
  $86DA,$01 Height = #N(#PEEK(#PC)) pixels.
  $86DB,$01 Width = #N(#PEEK(#PC)) bytes.
  $86DC,$20,$08 Pixel data.
N $86FC Attributes.
  $86FC,$01 Height = #N(#PEEK(#PC)) bytes.
  $86FD,$01 Width = #N(#PEEK(#PC)) bytes.
  $86FE,$04,$08 Attribute data.

b $8702 Background Graphic #N$1B
D $8702 #BG(#PC)(background-#PC)
N $8702 Pixels.
  $8702,$01 Height = #N(#PEEK(#PC)) pixels.
  $8703,$01 Width = #N(#PEEK(#PC)) bytes.
  $8704,$20,$08 Pixel data.
N $8724 Attributes.
  $8724,$01 Height = #N(#PEEK(#PC)) bytes.
  $8725,$01 Width = #N(#PEEK(#PC)) bytes.
  $8726,$04,$08 Attribute data.

b $872A Background Graphic #N$1C
D $872A #BG(#PC)(background-#PC)
N $872A Pixels.
  $872A,$01 Height = #N(#PEEK(#PC)) pixels.
  $872B,$01 Width = #N(#PEEK(#PC)) bytes.
  $872C,$C0,$08 Pixel data.
N $87EC Attributes.
  $87EC,$01 Height = #N(#PEEK(#PC)) bytes.
  $87ED,$01 Width = #N(#PEEK(#PC)) bytes.
  $87EE,$18,$08 Attribute data.

b $8806 Background Graphic #N$1D
D $8806 #BG(#PC)(background-#PC)
N $8806 Pixels.
  $8806,$01 Height = #N(#PEEK(#PC)) pixels.
  $8807,$01 Width = #N(#PEEK(#PC)) bytes.
  $8808,$188,$08 Pixel data.
N $8990 Attributes.
  $8990,$01 Height = #N(#PEEK(#PC)) bytes.
  $8991,$01 Width = #N(#PEEK(#PC)) bytes.
  $8992,$31,$08 Attribute data.

b $89C3 Background Graphic #N$1E
D $89C3 #BG(#PC)(background-#PC)
N $89C3 Pixels.
  $89C3,$01 Height = #N(#PEEK(#PC)) pixels.
  $89C4,$01 Width = #N(#PEEK(#PC)) bytes.
  $89C5,$188,$08 Pixel data.
N $8B4D Attributes.
  $8B4D,$01 Height = #N(#PEEK(#PC)) bytes.
  $8B4E,$01 Width = #N(#PEEK(#PC)) bytes.
  $8B4F,$31,$08 Attribute data.

b $8B80 Background Graphic #N$1F
D $8B80 #BG(#PC)(background-#PC)
N $8B80 Pixels.
  $8B80,$01 Height = #N(#PEEK(#PC)) pixels.
  $8B81,$01 Width = #N(#PEEK(#PC)) bytes.
  $8B82,$C0,$08 Pixel data.
N $8C42 Attributes.
  $8C42,$01 Height = #N(#PEEK(#PC)) bytes.
  $8C43,$01 Width = #N(#PEEK(#PC)) bytes.
  $8C44,$18,$08 Attribute data.

b $8C5C Background Graphic #N$20
D $8C5C #BG(#PC)(background-#PC)
N $8C5C Pixels.
  $8C5C,$01 Height = #N(#PEEK(#PC)) pixels.
  $8C5D,$01 Width = #N(#PEEK(#PC)) bytes.
  $8C5E,$60,$08 Pixel data.
N $8CBE Attributes.
  $8CBE,$01 Height = #N(#PEEK(#PC)) bytes.
  $8CBF,$01 Width = #N(#PEEK(#PC)) bytes.
  $8CC0,$0C,$08 Attribute data.

b $8CCC Background Graphic #N$21
D $8CCC #BG(#PC)(background-#PC)
N $8CCC Pixels.
  $8CCC,$01 Height = #N(#PEEK(#PC)) pixels.
  $8CCD,$01 Width = #N(#PEEK(#PC)) bytes.
  $8CCE,$60,$08 Pixel data.
N $8D2E Attributes.
  $8D2E,$01 Height = #N(#PEEK(#PC)) bytes.
  $8D2F,$01 Width = #N(#PEEK(#PC)) bytes.
  $8D30,$0C,$08 Attribute data.

b $8D3C Background Graphic #N$22
D $8D3C #BG(#PC)(background-#PC)
N $8D3C Pixels.
  $8D3C,$01 Height = #N(#PEEK(#PC)) pixels.
  $8D3D,$01 Width = #N(#PEEK(#PC)) bytes.
  $8D3E,$C0,$08 Pixel data.
N $8DFE Attributes.
  $8DFE,$01 Height = #N(#PEEK(#PC)) bytes.
  $8DFF,$01 Width = #N(#PEEK(#PC)) bytes.
  $8E00,$18,$08 Attribute data.

b $8E18 Background Graphic #N$23
D $8E18 #BG(#PC)(background-#PC)
N $8E18 Pixels.
  $8E18,$01 Height = #N(#PEEK(#PC)) pixels.
  $8E19,$01 Width = #N(#PEEK(#PC)) bytes.
  $8E1A,$F0,$08 Pixel data.
N $8F0A Attributes.
  $8F0A,$01 Height = #N(#PEEK(#PC)) bytes.
  $8F0B,$01 Width = #N(#PEEK(#PC)) bytes.
  $8F0C,$1E,$08 Attribute data.

b $8F2A Background Graphic #N$24
D $8F2A #BG(#PC)(background-#PC)
N $8F2A Pixels.
  $8F2A,$01 Height = #N(#PEEK(#PC)) pixels.
  $8F2B,$01 Width = #N(#PEEK(#PC)) bytes.
  $8F2C,$150,$08 Pixel data.
N $907C Attributes.
  $907C,$01 Height = #N(#PEEK(#PC)) bytes.
  $907D,$01 Width = #N(#PEEK(#PC)) bytes.
  $907E,$2A,$08 Attribute data.

b $90A8 Background Graphic #N$25
D $90A8 #BG(#PC)(background-#PC)
N $90A8 Pixels.
  $90A8,$01 Height = #N(#PEEK(#PC)) pixels.
  $90A9,$01 Width = #N(#PEEK(#PC)) bytes.
  $90AA,$2C0,$08 Pixel data.
N $936A Attributes.
  $936A,$01 Height = #N(#PEEK(#PC)) bytes.
  $936B,$01 Width = #N(#PEEK(#PC)) bytes.
  $936C,$58,$08 Attribute data.

b $93C4 Background Graphic #N$26
D $93C4 #BG(#PC)(background-#PC)
N $93C4 Pixels.
  $93C4,$01 Height = #N(#PEEK(#PC)) pixels.
  $93C5,$01 Width = #N(#PEEK(#PC)) bytes.
  $93C6,$168,$08 Pixel data.
N $952E Attributes.
  $952E,$01 Height = #N(#PEEK(#PC)) bytes.
  $952F,$01 Width = #N(#PEEK(#PC)) bytes.
  $9530,$2D,$08 Attribute data.

b $955D Background Graphic #N$27
D $955D #BG(#PC)(background-#PC)
N $955D Pixels.
  $955D,$01 Height = #N(#PEEK(#PC)) pixels.
  $955E,$01 Width = #N(#PEEK(#PC)) bytes.
  $955F,$60,$08 Pixel data.
N $95BF Attributes.
  $95BF,$01 Height = #N(#PEEK(#PC)) bytes.
  $95C0,$01 Width = #N(#PEEK(#PC)) bytes.
  $95C1,$0C,$08 Attribute data.

b $95CD Background Graphic #N$28
D $95CD #BG(#PC)(background-#PC)
N $95CD Pixels.
  $95CD,$01 Height = #N(#PEEK(#PC)) pixels.
  $95CE,$01 Width = #N(#PEEK(#PC)) bytes.
  $95CF,$90,$08 Pixel data.
N $965F Attributes.
  $965F,$01 Height = #N(#PEEK(#PC)) bytes.
  $9660,$01 Width = #N(#PEEK(#PC)) bytes.
  $9661,$12,$08 Attribute data.

b $9673 Background Graphic #N$29
D $9673 #BG(#PC)(background-#PC)
N $9673 Pixels.
  $9673,$01 Height = #N(#PEEK(#PC)) pixels.
  $9674,$01 Width = #N(#PEEK(#PC)) bytes.
  $9675,$18,$08 Pixel data.
N $968D Attributes.
  $968D,$01 Height = #N(#PEEK(#PC)) bytes.
  $968E,$01 Width = #N(#PEEK(#PC)) bytes.
  $968F,$03,$08 Attribute data.

g $9692 Game Options
@ $9692 label=GameOptions
D $9692 The options chosen on the game selection menu (see #R$B3D5).
. #TABLE(default,centre,left)
. { =h Bit(s) | =h Meaning }
. { 0 | Set for a 2 player game, reset for a 1 player game }
. { 1-2 | The controls (see below) }
. TABLE#
. #TABLE(default,centre,left)
. { =h Bits 1-2 | =h Controls }
. { #N$00 | Keyboard }
. { #N$01 | Kempston Joystick }
. { #N$02 | Cursor Joystick }
. { #N$03 | Interface II Joystick }
. TABLE#
E $9692 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$8ED5 }
. LIST#
  $9692,$01

g $9693 Game Timer
@ $9693 label=GameTimer
@ $9694 label=GameTimer_High
D $9693 A 16-bit counter which is incremented by #R$9A1D each time every actor
. has been processed.
  $9693,$01,$02

g $9695 Random Number
@ $9695 label=RandomNumber
D $9695 An 8-bit pseudo-random seed. It is updated each time an actor handler
. is run (#R$99D0) and once per pass of the actor table (#R$9A1D).
  $9695,$01

g $9696 Last Frame
@ $9696 label=LastFrame
D $9696 The value of #SKOOLKID$5C78(FRAMES) the last time #R$99B2 saw a new
. frame.
  $9696,$01

g $9697 Frame Updated
@ $9697 label=FrameUpdated
D $9697 Has the frame been updated? This is set by #R$99BC and cleared by
. #R$99F0 once the player's actor has been processed.
. #TABLE(default,centre,centre) { =h Value | =h Updated? }
. { #N$00 | Not updated }
. { #N$01 | Updated }
. TABLE#
  $9697,$01

g $9698 1UP Score
@ $9698 label=1UP_Score_1
D $9698 The score of player 1, held as three bytes with two BCD digits in each.
. The most significant byte is first.
  $9698,$01 Byte #1.
@ $9699 label=1UP_Score_2
  $9699,$01 Byte #2.
@ $969A label=1UP_Score_3
  $969A,$01 Byte #3.

g $969B 2UP Score
@ $969B label=2UP_Score_1
D $969B The score of player 2, held as three bytes with two BCD digits in each.
. The most significant byte is first.
  $969B,$01 Byte #1.
@ $969C label=2UP_Score_2
  $969C,$01 Byte #2.
@ $969D label=2UP_Score_3
  $969D,$01 Byte #3.

g $969E Active Player
@ $969E label=Flag_ActivePlayer
D $969E Which player is currently active.
. #TABLE(default,centre,centre) { =h Value | =h Player }
. { #N$00 | 1UP }
. { #N$FF | 2UP }
. TABLE#
  $969E,$01

g $969F Previous Sprite Id
@ $969F label=Previous_Sprite_Id
D $969F The sprite ID of the actor that #R$BB0B last saved. #R$B925 uses it to
. find the sprite that has to be erased, together with the saved position and
. room.
  $969F,$01

g $96A0 Previous X Position
@ $96A0 label=Previous_X_Position
D $96A0 The X position of the actor that #R$BB0B last saved.
  $96A0,$01

g $96A1 Previous Y Position
@ $96A1 label=Previous_Y_Position
D $96A1 The Y position of the actor that #R$BB0B last saved.
  $96A1,$01

g $96A2 Previous Room
@ $96A2 label=Previous_Room
D $96A2 The room of the actor that #R$BB0B last saved.
  $96A2,$01

g $96A3 Old Sprite Row Count
@ $96A3 label=Old_Sprite_Row_Count
D $96A3 The number of rows of the old sprite that #R$B9A9 has still to draw. It
. is set up by #R$B939, and is zero when there is no old sprite to erase (see
. #R$B919).
  $96A3,$01

g $96A4 New Sprite Row Count
@ $96A4 label=New_Sprite_Row_Count
D $96A4 The number of rows of the new sprite that #R$B9A9 has still to draw. It
. is set up by #R$B969, and is zero when there is no new sprite to draw (see
. #R$B8F5).
  $96A4,$01

g $96A5 New Sprite Height
@ $96A5 label=New_Sprite_Height
D $96A5 The height in pixels of the new sprite. It is set up by #R$B969 and used
. by #R$BB24.
  $96A5,$01

g $96A6 New Sprite Width
@ $96A6 label=New_Sprite_Width
D $96A6 The number of character cells that each row of the new sprite covers. It
. is one more than the width of the sprite in bytes when the sprite does not
. start on a character boundary. It is set up by #R$B969 and used by #R$BB24.
  $96A6,$01

u $96A7 Unused
@ $96A7 label=Unused_After_New_Sprite_Width
D $96A7 Cleared when the game starts. The game does not use it.
  $96A7,$01

g $96A8 Current menu item colour attribute
@ $96A8 label=Current_MenuAttribute
D $96A8 The attribute of the line of the game selection menu that is being
. printed (see #R$B473 and #R$B52D).
  $96A8,$01

g $96A9 Saved Actor Pointer
@ $96A9 label=SavedActorPointer
D $96A9 The address of the actor being processed when a new frame started. See
. #R$99BC and #R$99F0.
W $96A9,$02

g $96AB Moved Actor Room
@ $96AB label=Moved_Actor_Room
D $96AB The room of the actor that #R$AFE8 last moved, saved before it moves so
. that the room it was in is known if it changes room (see #R$A79F).
  $96AB,$01

g $96AC Player Controls
@ $96AC label=Player_Controls
D $96AC The controls being pressed by the player, as read by #R$B0A3 (after the
. magenta orchid has reversed them). There is a bit for each of left (bit 0),
. right (bit 1), up (bit 2), down (bit 3) and fire (bit 4).
  $96AC,$01

g $96AD Actor Width
@ $96AD label=Actor_Width
D $96AD The width in pixels of the actor that is being moved. Each actor
. handler sets it before moving the actor with #R$AFE8 and #R$A44B, so that the
. actor can be kept on the screen.
  $96AD,$01

g $96AE Actor Old X Position
@ $96AE label=Actor_Old_X_Position
D $96AE The X position of the actor before it moved, saved by #R$B81C when it
. stops the actor moving through the objects in the room.
  $96AE,$01

g $96AF Actor Old Y Position
@ $96AF label=Actor_Old_Y_Position
D $96AF The Y position of the actor before it moved, saved by #R$B81C when it
. stops the actor moving through the objects in the room.
  $96AF,$01

g $96B0 Orchid Effect Timer
@ $96B0 label=OrchidEffectTimer
D $96B0 The time left of the effect of an orchid on the player, or zero if there
. is no effect. It is set by #R$A737 (to #N$C0) and #R$AE8F (to #N$60), and is
. counted down by #R$AE7A every other frame. When it reaches zero the player
. goes back to the normal colour. While it is below #N$2F the player flashes
. between the colour of the orchid and white.
  $96B0,$01

g $96B1 Nastie Spawn Delay
@ $96B1 label=NastieSpawnDelay
D $96B1 A delay between nasties appearing. It is counted down by #R$9A3C each
. time every actor has been processed, and a new nastie can only start when it
. is zero. It is set to #N$10 at the start of a turn (see #R$B1B7) and when the
. player has died (see #R$AA27).
  $96B1,$01

g $96B2 Attribute Set Flag
@ $96B2 label=AttributeSetFlag
D $96B2 If this is not zero then #R$BC0B uses the second set of attributes of a
. graphic, if it has one, and resets this to zero. #R$A207 sets it to draw the
. pieces of the amulet that have been collected in full colour.
  $96B2,$01

g $96B3 Footstep Counter
@ $96B3 label=FootstepCounter
D $96B3 Incremented by #R$BF4B each time a player moves. It times the sound of
. the footsteps.
  $96B3,$01

g $96B4 Flame Spawn Delay
@ $96B4 label=FlameSpawnDelay
D $96B4 A delay before a flame can start. It is counted down by #R$9ABC while
. the flame record at #R$9762 is empty. It is set to #N$80 at the start of a
. turn, when the player has died and when the player moves to another room, and
. to #N$10 when a flame has been blown up (see #R$A4A1).
  $96B4,$01

g $96B5 Game Delay Timer
@ $96B5 label=GameDelayTimer
D $96B5 At the beginning of each player turn there is a delay to allow the
. player to be ready for play.
. #TABLE(default,centre,centre)
. { =h Value | =h Game Mode }
. { #N$80 | 1UP }
. { #N$FF | 2UP }
. TABLE#
. The larger delay for a 2UP game is useful for swapping players controls.
  $96B5,$01

g $96B6 Percentage Hundreds
@ $96B6 label=Percentage_Hundreds
D $96B6 The hundreds digit of the percentage of the jungle that has been
. explored, which is worked out by #R$9CC6.
  $96B6,$01

g $96B7 Previous Game Options
@ $96B7 label=PreviousGameOptions
D $96B7 The game selection menu uses this to remember the options that it last
. saw (see #R$B43E), so that the countdown to the hall of fame is restarted when
. the options change.
. .
. It is also used by #R$9CC6 to hold the tens and units digits of the
. percentage of the jungle that has been explored.
  $96B7,$01

g $96B8 Hall Of Fame Timer
@ $96B8 label=HallOfFame_Timer
D $96B8 Counter for game selection screen, which tells the routine when to flip
. to display the Hall Of Fame (see #R$B272).
W $96B8,$02

g $96BA Hall Of Fame Updated Flag
@ $96BA label=HallOfFameUpdated
D $96BA Set to #N$01 when a score has been entered into the hall of fame, and
. cleared by #R$B5FC. #R$AAA4 shows the hall of fame at the end of the game if
. it is set.
  $96BA,$01

g $96BB High Score Position
@ $96BB label=HighScorePosition
D $96BB Used when calculating the players position in the high score table.
. It is the number of places that the score beat (see #R$B61E).
  $96BB,$01

g $96BC Active Player: Unknown
@ $96BC label=ActivePlayer_Unknown
D $96BC Purpose not yet known. It is cleared by #R$B21E and swapped with
. #R$96DF by #R$B235 when the players change, but it is never read.
  $96BC,$01

g $96BD Active Player Lives
@ $96BD label=ActivePlayer_Lives
D $96BD The number of lives of the active player.
  $96BD,$01

g $96BE Active Player: Nastie Limit
@ $96BE label=ActivePlayer_NastieLimit
D $96BE The maximum number of nasties that can be in the room of the player at
. once, which is set by #R$B21E.
  $96BE,$01

g $96BF Visited Rooms
@ $96BF label=VisitedRooms
D $96BF A bitmap of the rooms which the active player has visited, with a bit
. for each of the #N($0100,$04,$04) rooms (see #R$9D23).
E $96BF View the equivalent code in;
. #LIST
. { #ATICATAC$5E40 }
. LIST#
  $96BF,$20,$01

g $96DF Inactive Player: Unknown
@ $96DF label=InactivePlayer_Unknown
D $96DF The stored copy of #R$96BC for the player who is not playing.
  $96DF,$01

g $96E0 Inactive Player Lives
@ $96E0 label=InactivePlayer_Lives
D $96E0 The stored copy of #R$96BD for the player who is not playing. A one
. player game leaves player 2 with no lives.
  $96E0,$01

g $96E1 Inactive Player: Nastie Limit
@ $96E1 label=InactivePlayer_NastieLimit
D $96E1 The stored copy of #R$96BE for the player who is not playing.
  $96E1,$01

g $96E2 Inactive Player: Visited Rooms
@ $96E2 label=InactivePlayer_VisitedRooms
D $96E2 The stored copy of #R$96BF for the player who is not playing.
  $96E2,$20,$01

g $9702 Immortal Data
@ $9702 label=ImmortalData
D $9702 The table of actors, which runs from here to #R$982E. Every actor is
. held in a #N$0C byte record, and #R$99AA handles each record in turn, using
. the sprite ID to choose the handler (see #R$9B3E).
. .
. A record is made up of:
. #TABLE(default,centre,left)
. { =h Byte | =h Contents }
. { #N$00 | Sprite ID (zero for an empty record) }
. { #N$01 | Room }
. { #N$02 | Hit direction or counter }
. { #N$03 | X position }
. { #N$04 | Y position }
. { #N$05 | Colour }
. { #N$06 | X velocity, in sixteenths of a pixel }
. { #N$07 | Y velocity, in sixteenths of a pixel }
. { #N$08-#N$0B | Used in different ways by different actors }
. TABLE#
. .
. The first #N$0C records are the player and the actors which are always
. present, which are set up from #R$AC77. They are followed by the nasties
. (#R$9792), the orchid (#R$97DA), the objects (#R$97E6) and the pieces of the
. amulet (#R$97FE).
N $9702 The record of the player.
  $9702,$01 Sprite ID.
  $9703,$01 Room.
  $9704,$01 Hit direction.
  $9705,$01 X position.
  $9706,$01 Y position.
  $9707,$01 Colour.
  $9708,$01 X velocity.
  $9709,$01 Y velocity.
  $970A,$03 Not used.
  $970D,$01 Amulet pieces collected. Bits 0-3 are set for the pieces which have
. been collected and bit 7 is set when a piece has just been collected.
N $970E The records of the other actors which are always present.
@ $970E label=ImmortalData_Actors
  $970E,$0C Rhino.
  $971A,$0C Rhino.
  $9726,$0C Rhino.
  $9732,$0C Rhino.
  $973E,$0C Tribesman.
  $974A,$0C Tribesman.
  $9756,$0C Tribesman.
@ $9762 label=ImmortalData_SpareFlame
  $9762,$0C Spare record for a flame.
  $976E,$0C Wulf.
  $977A,$0C Hippo.
  $9786,$0C The Guardian.

g $9792 Nastie Data
@ $9792 label=NastieData
D $9792 The records of the six nasties. A nastie is started in an empty record
. by #R$9A68.
  $9792,$0C
L $9792,$0C,$06

g $97DA Orchid Data
@ $97DA label=OrchidData
D $97DA The record of the orchid in the room the player is in. It is set up by
. #R$A763 when the player enters a room and stored again by #R$A79F when the
. player leaves.
  $97DA,$0C

g $97E6 Object Data
@ $97E6 label=ObjectData
D $97E6 The records of the two objects in the room the player is in, which are
. set up by #R$A33B.
  $97E6,$0C The first object.
@ $97F2 label=ObjectData_Second
  $97F2,$0C The second object.

g $97FE Amulet Data
@ $97FE label=AmuletData
D $97FE The records of the four pieces of the amulet, which are set up by
. #R$A255 when a game starts. A record has a sprite ID of zero once the piece
. has been collected.
N $97FE Amulet part: #N(#EVAL((#PC - $97FE) / $0C) + $01).
  $97FE,$0C
L $97FE,$0C,$04

g $982E Stored Actor Table
@ $982E label=StoredActorTable
D $982E The stored copy of the actor table at #R$9702 for the player who is not
. playing. The two are swapped by #R$B235 when the players change.
  $982E,$012C,$0C

c $995A Security Check
@ $995A label=SecurityCheck
D $995A The first routine run once the game has been decrypted. It checks the
. second byte of the #SKOOLKID$5C78(FRAMES) system variable (#N$5C79). If this
. is not #N$7D the routine returns, and as the stack pointer was set to
. #N$6000 by #R$6000 the return address is taken from the first two bytes of
. that routine instead of from a caller.
E $995A Continue on to #R$9960.
E $995A View the equivalent code in;
. #LIST
. { #COOKIE$5F00 }
. { #JETPAC$61E5 }
. { #LUNARJETMAN$8000 }
. { #PSSST$61C6 }
. { #TRANZAM$5F00 }
. LIST#
  $995A,$03 Fetch the second byte of the #SKOOLKID$5C78(FRAMES) system variable
. (#N$5C79).
  $995D,$03 Return unless that byte is #N$7D.

c $9960 Game Initialisation
@ $9960 label=GameInitialisation
D $9960 Clears the game variables, the screen and the attribute buffer, builds
. the lookup table used when drawing sprites (#R$B902) and colours and draws
. the banner and score line. The game selection menu (#R$B3D5) is shown, then
. the game variables are cleared again, the scores are printed, the start-up
. jingle (the music data at #R$BD45) is played and #R$B1D4 sets up both
. players and the first room before the main loop at #R$99AA is entered.
. .
. #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune)))
E $9960 Continue on to #R$99AA.
E $9960 View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #JETPAC$61EB }
. { #LUNARJETMAN$800A }
. { #PSSST$61CD }
. { #TRANZAM$5F07 }
. LIST#
N $9960 #PUSHS #UDGTABLE { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #SCR$02(game-start) }
. { #SCR$01,$00,$16,$20,$02(jungle-strip) } UDGTABLE# #POPS
  $9960,$03 Clear the game variables.
  $9963,$03 Set the border to #INK$00.
  $9966,$03 Clear the attribute buffer.
  $9969,$03 Reset the screen buffer.
  $996C,$03 Build the shift table used when drawing sprites.
N $996F Set the attributes for the top banner (the whole line is #COLOUR$47).
  $996F,$03 Set the attribute pointer in #REGhl to the start of the attribute
. buffer at #N$5800.
  $9972,$03 Set the column counter in #REGb to #N$20 and the banner colour in
. #REGc to #COLOUR$47.
@ $9975 label=CreateWindow_Loop_Banner
  $9975,$01 Write the banner colour to the attribute buffer.
  $9976,$01 Move onto the next column.
  $9977,$02 Decrease the column counter by one and loop back to #R$9975 until
. all #N$20 columns have been coloured.
  $9979,$03 Print the banner.
N $997C Set the attributes for the score line (the whole line is #COLOUR$46).
  $997C,$03 Set the attribute pointer in #REGhl to the start of the score line
. at #N$5820.
  $997F,$03 Set the column counter in #REGb to #N$20 and the score line colour
. in #REGc to #COLOUR$46.
@ $9982 label=CreateWindow_Loop_Score
  $9982,$01 Write the score line colour to the attribute buffer.
  $9983,$01 Move onto the next column.
  $9984,$02 Decrease the column counter by one and loop back to #R$9982 until
. all #N$20 columns have been coloured.
N $9986 Print the 1UP, 2UP and HI scores on the score line.
  $9986,$03 Print the 1UP score.
  $9989,$03 Print the 2UP score.
  $998C,$03 Print the high score.
N $998F Show the game selection menu and wait for a game to be chosen. This is
. also where the game restarts when a game is over.
@ $998F label=Game_Restart
  $998F,$03 Show the game menu.
N $9992 Write #N$00 to every address from #R$9698 to #N$9959 (the scores, the
. player data, the actor table and the other game variables).
  $9992,$03 Set the start of the game variables in #REGhl to #R$9698.
  $9995,$03 Set the number of bytes to clear in #REGbc to #N$02C2.
  $9998,$03 Clear the game variables.
N $999B Print the (now zero) 1UP and 2UP scores.
  $999B,$03 Print the 1UP score.
  $999E,$03 Print the 2UP score.
N $99A1 Play the start-up jingle.
  $99A1,$03 Point #REGde at #R$BD45.
  $99A4,$03 Play the start-up tune.
N $99A7 Set up both players and the first room, then carry on into the main
. loop.
  $99A7,$03 Set up the players and the first room.

c $99AA Run Main Loop
@ $99AA label=MainLoop
D $99AA Every actor (the player, the animals, the tribesmen, the objects and so
. on) is held in a #N$0C byte record in the actor table, which runs from
. #R$9702 to #R$982E. The first byte of each record is the sprite ID, and this
. is also the index into the jump table at #R$9B3E which selects the handler
. routine for the actor.
. .
. The handler for one actor is run per pass of #R$99B2. When the frame counter
. changes the actor currently being processed is
. remembered in #R$96A9 (this happens every frame, 50 times a second), the
. player's actor (#R$9702) is processed straight away and then the loop
. carries on from where it was interrupted. Once every actor has been
. processed, #R$9A1D runs.
  $99AA,$03 Set the stack pointer to #R$6000.
  $99AD,$01 Enable interrupts.
  $99AE,$04 Point #REGix at the first actor after the player, at #R$970E.
N $99B2 Check if the frame counter has changed since the last time through.
@ $99B2 label=MainLoop_NextActor
  $99B2,$04 Fetch the low byte of the frame counter from #SKOOLKID$5C78(FRAMES)
. into #REGc.
  $99B6,$03 Fetch the frame counter from the previous pass from #R$9696.
  $99B9,$03 Jump to #R$99D0 if the frame counter has not changed.
@ $99BC label=FrameUpdate
  $99BC,$01 Disable interrupts.
  $99BD,$06 Remember the new frame counter in #R$9696.
  $99C3,$05 Set the frame updated flag in #R$9697.
  $99C8,$04 Remember which actor was being processed in #R$96A9.
  $99CC,$04 Point #REGix at the player's actor at #R$9702.
N $99D0 Update the random number seed using the Z80 refresh register.
@ $99D0 label=MainLoop_RunHandler
  $99D0,$02 Fetch the Z80 refresh register as a source of randomness.
  $99D2,$01 Stash it in #REGc.
  $99D3,$03 Fetch the random seed from #R$9695.
  $99D6,$01 Mix in the refresh register value and the carry flag.
  $99D7,$03 Store the new random seed in #R$9695.
N $99DA Run the handler for this actor. The handler returns to #R$99F0, so push
. that address first, then use the sprite ID to find the handler in the jump
. table.
  $99DA,$04 Stash the return address #R$99F0 on the stack so the handler returns
. to it.
  $99DE,$03 Point #REGbc at the handler jump table at #R$9B3E.
N $99E1 See #POKE(see_ending,See Ending).
  $99E1,$06 Fetch the sprite ID of the actor into #REGhl.
  $99E7,$01 Double the sprite ID to get the offset into the jump table.
  $99E8,$01 Add the jump table address to get the address of the actor's entry.
  $99E9,$04 Fetch the address of the handler from the jump table.
  $99ED,$03 Jump to #R$5CB0, which jumps to the address held in #REGhl.

c $99F0 Next Actor
@ $99F0 label=NextActor
D $99F0 Moves on to the next actor in the actor table. If a new frame has just
. started only the player's actor is processed before the interrupted pass
. carries on; otherwise the loop runs until the end of the actor table is
. reached.
  $99F0,$03 Set the size of an actor record in #REGde to #N$0C.
  $99F3,$02 Move onto the next actor.
  $99F5,$03 Copy the actor pointer to #REGhl (using the stack).
  $99F8,$03 Fetch the frame updated flag from #R$9697.
  $99FB,$03 Jump to #R$9A18 if the frame has just updated.
  $99FE,$03 Point #REGde at the end of the actor table at #R$982E.
@ $9A01 label=NextActor_Compare
  $9A01,$03 Subtract the end of the actor table from the actor pointer.
  $9A04,$02 Jump to #R$99B2 if there are more actors to process.
N $9A06 The end of the range has been reached. If this was just the player's
. actor then go back to where the interrupted pass left off; otherwise the pass
. through the actor table is complete.
  $9A06,$03 Fetch the frame updated flag from #R$9697.
  $9A09,$03 Jump to #R$9A1D if the frame has not just updated
. (every actor has been processed).
  $9A0C,$04 Restore the actor which was being processed before the frame updated
. from #R$96A9.
  $9A10,$04 Clear the frame updated flag in #R$9697.
  $9A14,$01 Enable interrupts.
  $9A15,$03 Jump to #R$99B2.
N $9A18 The frame has just updated, so only the player's actor is processed
. before the interrupted pass is resumed (i.e. stop once #REGix reaches the
. second actor).
@ $9A18 label=NextActor_FrameUpdated
  $9A18,$03 Point #REGde at the second actor record at #R$970E.
  $9A1B,$02 Jump to #R$9A01.

c $9A1D Update Counters And Housekeeping
@ $9A1D label=UpdateCounters
D $9A1D Runs once every time all of the actors have been processed. It updates
. the counter and the random number seed and then calls the pause check and
. the other per-pass routines before going back to the main loop.
  $9A1D,$03 Fetch the game timer from #R$9693.
  $9A20,$04 Increment the game timer and write it back to #R$9693.
  $9A24,$03 Fetch the random seed from #R$9695.
  $9A27,$02 Add the low byte of the game timer to the random seed.
  $9A29,$03 Fetch the frame counter from #SKOOLKID$5C78(FRAMES).
  $9A2C,$01 Mix the frame counter into the random seed.
  $9A2D,$03 Store the new random seed in #R$9695.
  $9A30,$03 Check if the game is paused.
  $9A33,$03 Try to spawn a nastie.
  $9A36,$03 Try to spawn a flame.
  $9A39,$03 Jump back to the start of the main loop.

c $9A3C Spawn Nastie
@ $9A3C label=SpawnNastie
D $9A3C Called once every time all of the actors have been processed. If the
. start-of-turn delay is over, the nastie spawn delay has run out and the
. player is alive, this looks for an empty record in the nastie table at
. #R$9792 and, if one is found, tries to start a new nastie in it with
. #R$9A68.
N $9A3C Return if the start-of-turn delay is still running.
  $9A3C,$05 Return if the start-of-turn delay in #R$96B5 is not zero.
N $9A41 Count down the delay between nasties appearing.
  $9A41,$06 Jump to #R$9A4C if the nastie spawn delay in #R$96B1 is zero.
  $9A47,$01 Decrease the nastie spawn delay by one.
  $9A48,$03 Store the nastie spawn delay in #R$96B1.
  $9A4B,$01 Return.
N $9A4C Return unless the player is alive (the sprite ID of the player's actor
. is in the range #N$10-#N$2F).
@ $9A4C label=SpawnNastie_Ready
  $9A4C,$03 Fetch the sprite ID of the player's actor from #R$9702.
  $9A4F,$02 Subtract #N$10 (the first Sabreman sprite ID).
  $9A51,$03 Return if the player is not alive.
N $9A54 Look for an empty record in the nastie table.
  $9A54,$04 Point #REGix at the first nastie record at #R$9792.
  $9A58,$03 Set the size of an actor record in #REGde to #N$0C.
  $9A5B,$02 Set the nastie record counter in #REGb to #N$06.
@ $9A5D label=SpawnNastie_Loop
  $9A5D,$03 Fetch the sprite ID of the nastie.
  $9A60,$03 Jump to #R$9A68 if the record is empty.
  $9A63,$02 Move onto the next nastie record.
  $9A65,$02 Decrease the nastie record counter by one and loop back to #R$9A5D
. until all six records have been checked.
  $9A67,$01 Return.

c $9A68 Start Nastie
@ $9A68 label=StartNastie
D $9A68 Turns an empty nastie record into a nastie which is just appearing,
. unless the player's room already holds the maximum number of nasties
. (#R$96BE) or the position chosen by #R$9B0D is unsuitable. The nastie starts
. as the first of the five "appearing" sprites (sprite ID #N$01), in one of
. four colours chosen from the table at #R$9AB8 using the low bits of the
. counter at #R$9693.
R $9A68 IX Empty nastie record
N $9A68 Count the nasties which are already in the player's room.
  $9A68,$03 Point #REGhl at the first nastie record at #R$9792.
  $9A6B,$02 Set the nastie record counter in #REGb to #N$06.
  $9A6D,$02 Set the number of nasties in the player's room in #REGd to #N$00.
  $9A6F,$04 Fetch the player's room from #R$9703 into #REGe.
@ $9A73 label=StartNastie_CountLoop
  $9A73,$01 Fetch the sprite ID of the nastie.
  $9A74,$03 Jump to #R$9A7E if the record is empty.
  $9A77,$01 Move onto the room of the nastie.
  $9A78,$02 Compare the room of the nastie with the player's room.
  $9A7A,$01 Move back to the sprite ID.
  $9A7B,$02 Jump to #R$9A7E if the nastie is in a different room.
  $9A7D,$01 Count the nastie.
@ $9A7E label=StartNastie_NextRecord
  $9A7E,$02 Set the size of an actor record in #REGa to #N$0C.
  $9A80,$03 Move #REGhl onto the next nastie record.
  $9A83,$02 Decrease the nastie record counter by one and loop back to #R$9A73
. until all six records have been checked.
N $9A85 Return if the room already holds the maximum number of nasties.
  $9A85,$03 Fetch the maximum number of nasties allowed in a room from #R$96BE.
  $9A88,$02 Return if the room already holds the maximum number of nasties.
N $9A8A Choose where the nastie will appear and return if the position is not
. suitable (the carry flag is set).
  $9A8A,$03 Choose a position for the nastie.
  $9A8D,$01 Return if the position is unsuitable.
N $9A8E Choose a colour for the nastie from the four in the table.
  $9A8E,$03 Fetch the low byte of the game timer from #R$9693.
  $9A91,$02,b$01 Keep only bits 0-1.
  $9A93,$03 Use it as the offset into the colour table.
  $9A96,$04 Add the address of the colour table to get the address of the
. colour.
  $9A9A,$01 Fetch the colour of the nastie from the table.
  $9A9B,$03 Set the colour of the nastie.
N $9A9E Start the nastie as the first "appearing" sprite.
  $9A9E,$04 Set the sprite ID of the nastie to #N$01 (appearing).
N $9AA2 Clear the movement and state bytes of the new actor and draw it.
@ $9AA2 label=StartActor_Reset
  $9AA2,$13 Clear the velocities and counters of the actor.
  $9AB5,$03 Draw the actor.

b $9AB8 Nastie Colour Table
@ $9AB8 label=NastieColours
D $9AB8 The colours which a nastie can appear in, chosen using bits 0-1 of
. the counter at #R$9693.
B $9AB8,$01 #COLOUR(#PEEK(#PC)).
L $9AB8,$01,$04

c $9ABC Spawn Flame
@ $9ABC label=SpawnFlame
D $9ABC Called once every time all of the actors have been processed, after
. #R$9A3C. If the start-of-turn delay is over, the player is alive and the
. actor record at #R$9762 is empty then a counter (#R$96B4) is counted down;
. when it reaches zero a flame (sprite ID #N$34) is started at a position
. chosen by #R$9AE9, unless that position is unsuitable.
N $9ABC Return unless the player is alive (the sprite ID of the player's actor
. is in the range #N$10-#N$2F).
  $9ABC,$03 Fetch the sprite ID of the player's actor from #R$9702.
  $9ABF,$02 Subtract #N$10 (the first Sabreman sprite ID).
  $9AC1,$03 Return if the player is not alive.
N $9AC4 Return if the start-of-turn delay is still running.
  $9AC4,$05 Return if the start-of-turn delay in #R$96B5 is not zero.
N $9AC9 Return if the record is already in use.
  $9AC9,$03 Point #REGde at the flame's actor record at #R$9762.
  $9ACC,$01 Fetch the sprite ID of the flame's actor.
  $9ACD,$02 Return if the flame is already in use.
N $9ACF Count down the delay before the next flame appears.
  $9ACF,$03 Point #REGhl at the flame spawn delay at #R$96B4.
  $9AD2,$01 Fetch the flame spawn delay.
  $9AD3,$03 Jump to #R$9AD8 if the flame spawn delay has run out.
  $9AD6,$01 Decrease the flame spawn delay by one.
  $9AD7,$01 Return if the flame spawn delay is not zero yet.
N $9AD8 The delay has run out so try to start a flame.
@ $9AD8 label=SpawnFlame_Start
  $9AD8,$03 Point #REGix at the flame's actor record (using the stack).
  $9ADB,$03 Choose a position for the flame.
  $9ADE,$01 Return if the position is unsuitable.
  $9ADF,$04 Set the sprite ID of the actor to #N$34 (flame).
  $9AE3,$04 Set the colour of the flame to #COLOUR$46.
  $9AE7,$02 Jump to #R$9AA2 to start the flame.

c $9AE9 Place Flame
@ $9AE9 label=PlaceFlame
D $9AE9 Chooses a position for a new flame. Depending on bit 0 of the counter at
. #R$9693 the flame is either placed in the same column as the player (with a
. position from the frame counter for its row, see #R$9B18) or in the same row
. as the player (see #R$9AF9). It then finishes by checking the position, see
. #R$9B23.
R $9AE9 IX Flame record
R $9AE9 O:F Carry flag set if the position is unsuitable
  $9AE9,$03 Fetch the low byte of the game timer from #R$9693.
  $9AEC,$02,b$01 Keep only bit 0.
  $9AEE,$02 Jump to #R$9AF9 if the flame is to appear in the same row as the
. player.
N $9AF0 Use the same X position as the player.
  $9AF0,$03 Fetch the X position of the player from #R$9705.
  $9AF3,$03 Set the X position of the flame.
  $9AF6,$01 Copy the X position to #REGe.
  $9AF7,$02 Jump to #R$9B18 to choose the Y position.

c $9AF9 Place Flame In Row
@ $9AF9 label=PlaceFlame_InRow
D $9AF9 Places a new flame at the same Y position as the player and at a random
. X position.
R $9AF9 IX Flame record
R $9AF9 O:F Carry flag set if the position is unsuitable
N $9AF9 Use the same Y position as the player.
  $9AF9,$03 Fetch the Y position of the player from #R$9706.
  $9AFC,$03 Set the Y position of the flame.
  $9AFF,$01 Copy the Y position to #REGd.
N $9B00 Use a random X position between #N$30 and #N$AF.
  $9B00,$03 Fetch the random seed from #R$9695.
  $9B03,$02,b$01 Keep only bits 0-6.
  $9B05,$02 Add #N$30.
  $9B07,$01 Copy the X position to #REGe.
  $9B08,$03 Set the X position of the flame.
  $9B0B,$02 Jump to #R$9B23 to test the position.

c $9B0D Choose Position
@ $9B0D label=ChoosePosition
D $9B0D Chooses a random position for an actor which is about to appear in the
. player's room, both the X and Y coordinates are between #N$30 and #N$AF. The
. position is rejected if the actor would overlap the player (see #R$AB01) or
. an object in the room (see #R$B81C).
R $9B0D IX Actor record
R $9B0D O:DE The Y and X position (#REGd and #REGe)
R $9B0D O:F Carry flag set if the position is unsuitable
N $9B0D Use a random X position.
  $9B0D,$03 Fetch the random seed from #R$9695.
  $9B10,$02,b$01 Keep only bits 0-6.
  $9B12,$02 Add #N$30.
  $9B14,$01 Copy the X position to #REGe.
N $9B15 See #POKE(less_enemies,Less Enemies).
  $9B15,$03 Set the X position of the actor.
N $9B18 Use a Y position based on the frame counter.
@ $9B18 label=ChoosePosition_SetY
  $9B18,$03 Fetch the frame counter from #SKOOLKID$5C78(FRAMES).
  $9B1B,$02,b$01 Keep only bits 0-6.
  $9B1D,$02 Add #N$30.
  $9B1F,$01 Copy the Y position to #REGd.
  $9B20,$03 Set the Y position of the actor.
N $9B23 Put the actor in the player's room and test the position.
@ $9B23 label=ChoosePosition_Test
  $9B23,$03 Fetch the player's room from #R$9703.
  $9B26,$03 Set the room of the actor to the player's room.
  $9B29,$03 Set the height and width of the actor in #REGb and #REGc to #N$17.
  $9B2C,$03 Check whether the actor overlaps the player.
  $9B2F,$01 Return if the actor would overlap the player.
  $9B30,$03 Set the height and width of the actor in #REGb and #REGc to #N$17.
  $9B33,$03 Check whether the actor overlaps an object in the room.
  $9B36,$01 Return.

c $9B37 Add A To HL
@ $9B37 label=AddAToHL
D $9B37 Adds #REGa to #REGhl.
E $9B37 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$D4F2 }
. LIST#
R $9B37 A Value to add
R $9B37 HL Address
R $9B37 O:HL #REGhl + #REGa
  $9B37,$02 #REGl=#REGa+#REGl.
  $9B39,$04 #REGh=#REGh+any carry.
  $9B3D,$01 Return.

w $9B3E Jump Table
@ $9B3E label=JumpTable
D $9B3E The handler address for each sprite ID (#N$00-#N$C3), which is #N$C4
. entries of two bytes each. The table is indexed by the sprite ID of
. an actor (see #R$99AA). Every handler is called with #REGix pointing at the
. actor record. Sprite IDs which have no behaviour of their own point at
. #R$ADBD.
. .
. Each run of sprite IDs below has the same handler; the sprite names are
. given by #R$BF84.
  $9B3E,$02 Sprite ID #N$00: no sprite, handled by #R$ADBD.
  $9B40,$0A,$02 Sprite IDs #N$01-#N$05: appearing nastie, handled by #R$A3C5.
  $9B4A,$02 Sprite ID #N$06: choose nastie, handled by #R$A3E0.
  $9B4C,$02 Sprite ID #N$07: none, handled by #R$ADBD.
  $9B4E,$0A,$02 Sprite IDs #N$08-#N$0C: dying nastie, handled by #R$A42A.
  $9B58,$02 Sprite ID #N$0D: remove nastie, handled by #R$A43B.
  $9B5A,$04,$02 Sprite IDs #N$0E-#N$0F: none, handled by #R$ADBD.
  $9B5E,$20,$02 Sprite IDs #N$10-#N$1F: walking Sabreman, handled by #R$AECF.
  $9B7E,$20,$02 Sprite IDs #N$20-#N$2F: attacking Sabreman, handled by #R$ADD0.
  $9B9E,$08,$02 Sprite IDs #N$30-#N$33: rhino, handled by #R$AD07.
  $9BA6,$08,$02 Sprite IDs #N$34-#N$37: flame, handled by #R$9D91.
  $9BAE,$10,$02 Sprite IDs #N$38-#N$3F: tribesman, handled by #R$AB74.
  $9BBE,$02 Sprite ID #N$40: flying Sabreman, handled by #R$A9BE.
  $9BC0,$04,$02 Sprite IDs #N$41-#N$42: sitting Sabreman, handled by #R$AA0D.
  $9BC4,$02 Sprite ID #N$43: Sabreman standing up, handled by #R$A61B.
  $9BC6,$02 Sprite ID #N$44: flying Sabreman, handled by #R$A9BE.
  $9BC8,$04,$02 Sprite IDs #N$45-#N$46: sitting Sabreman, handled by #R$AA0D.
  $9BCC,$02 Sprite ID #N$47: Sabreman standing up, handled by #R$A61B.
  $9BCE,$10,$02 Sprite IDs #N$48-#N$4F: orchid, handled by #R$A680.
  $9BDE,$10,$02 Sprite IDs #N$50-#N$57: Wulf, handled by #R$A858.
  $9BEE,$02 Sprite ID #N$58: Wulf pouncing, handled by #R$A8F5.
  $9BF0,$02 Sprite ID #N$59: Wulf landing, handled by #R$A964.
  $9BF2,$04,$02 Sprite IDs #N$5A-#N$5B: none, handled by #R$ADBD.
  $9BF6,$02 Sprite ID #N$5C: Wulf pouncing, handled by #R$A8F5.
  $9BF8,$02 Sprite ID #N$5D: Wulf landing, handled by #R$A964.
  $9BFA,$04,$02 Sprite IDs #N$5E-#N$5F: none, handled by #R$ADBD.
  $9BFE,$10,$02 Sprite IDs #N$60-#N$67: spider and scorpion, handled by
. #R$A54F.
  $9C0E,$08,$02 Sprite IDs #N$68-#N$6B: bat, handled by #R$A4D7.
  $9C16,$10,$02 Sprite IDs #N$6C-#N$73: parrot and monkey, handled by #R$A54F.
  $9C26,$10,$02 Sprite IDs #N$74-#N$7B: lizard and snake, handled by #R$A4D7.
  $9C36,$08,$02 Sprite IDs #N$7C-#N$7F: none, handled by #R$ADBD.
  $9C3E,$0A,$02 Sprite IDs #N$80-#N$84: objects, handled by #R$A312.
  $9C48,$02 Sprite ID #N$85: extra life, handled by #R$A305.
  $9C4A,$14,$02 Sprite IDs #N$86-#N$8F: objects, handled by #R$A312.
  $9C5E,$08,$02 Sprite IDs #N$90-#N$93: pieces of the amulet, handled by
. #R$A1AB.
  $9C66,$04,$02 Sprite IDs #N$94-#N$95: guardian, handled by #R$9F16.
  $9C6A,$04,$02 Sprite IDs #N$96-#N$97: none, handled by #R$ADBD.
  $9C6E,$10,$02 Sprite IDs #N$98-#N$9F: rat and bird, handled by #R$A54F.
  $9C7E,$08,$02 Sprite IDs #N$A0-#N$A3: hippo, handled by #R$9E72.
  $9C86,$08,$02 Sprite IDs #N$A4-#N$A7: sleeping hippo, handled by #R$9EB3.
  $9C8E,$08,$02 Sprite IDs #N$A8-#N$AB: warthog, handled by #R$9E72.
  $9C96,$08,$02 Sprite IDs #N$AC-#N$AF: sleeping warthog, handled by #R$9EB3.
  $9C9E,$28,$02 Sprite IDs #N$B0-#N$C3: frog, mosquito, skunk, flea and earwig,
. handled by #R$A54F.

c $9CC6 Print Percentage Explored
@ $9CC6 label=PrintRoomsVisited
D $9CC6 Works out how much of the jungle the player has explored and prints the
. result as a percentage on the game over screen.
. .
. The number of rooms visited (the bits set in the bitmap at #R$96BF) plus the
. number of amulet pieces collected (the bits set in the low four bits of
. #R$970D) is converted into a percentage of #N($0104,$04,$04) (the #N$0100
. rooms plus the four amulet pieces). The result is held as two BCD bytes in
. #R$96B6 (the hundreds) and #R$96B7 (the tens and units) before being printed.
. .
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #POKES$96BF,$FF,$0A
. #SIM(start=$AA6A,stop=$AA87,sp=$5B40)
. #SCR$02,$02,$0B,$1C,$06(percentage-before) }
. { =h After #R$9CC6 }
. { #SIM(start=$AA87,stop=$AA8A,sp=$5B40)
. #SCR$02,$02,$0B,$1C,$06(percentage-after) } UDGTABLE# #POPS
E $9CC6 View the equivalent code in;
. #LIST
. { #ATICATAC$96C9 }
. LIST#
N $9CC6 Count the number of rooms which have been visited.
  $9CC6,$03 Set the count of rooms visited and amulet pieces collected in #REGde
. to #N$0000.
  $9CC9,$03 Set the bit counter in #REGb to #N$08 and the byte counter in #REGc
. to #N$20.
  $9CCC,$03 Point #REGhl at the visited rooms bitmap at #R$96BF.
@ $9CCF label=PrintRoomsVisited_CountByte
  $9CCF,$01 Stash the counters on the stack.
  $9CD0,$01 Fetch the next byte of the visited rooms bitmap.
  $9CD1,$01 Move onto the next byte of the bitmap.
@ $9CD2 label=PrintRoomsVisited_CountBit
  $9CD2,$01 Rotate the bit for the next room into the carry flag.
  $9CD3,$02 Jump to #R$9CD6 if the room has not been visited.
  $9CD5,$01 Add the room to the count in #REGde.
@ $9CD6 label=PrintRoomsVisited_NextBit
  $9CD6,$02 Decrease the bit counter by one and loop back to #R$9CD2 until all
. eight rooms in the byte have been checked.
  $9CD8,$01 Restore the counters from the stack.
  $9CD9,$03 Decrease the byte counter by one and jump back to #R$9CCF until all
. #N$20 bytes of the bitmap have been counted.
N $9CDC Add the number of amulet pieces which have been collected.
  $9CDC,$03 Fetch the amulet pieces collected from #R$970D.
  $9CDF,$02 Set the amulet piece counter in #REGb to #N$04.
@ $9CE1 label=PrintRoomsVisited_CountPiece
  $9CE1,$01 Rotate the flag for the next amulet piece into the carry flag.
  $9CE2,$02 Jump to #R$9CE5 if the amulet piece has not been collected.
  $9CE4,$01 Add the amulet piece to the count in #REGde.
@ $9CE5 label=PrintRoomsVisited_NextPiece
  $9CE5,$02 Decrease the amulet piece counter by one and loop back to #R$9CE1
. until all four pieces have been checked.
N $9CE7 Multiply the count by #N$6276 (#N$10000 * #N$64 / #N($0104,$04,$04)) by
. repeated addition. Every time the sum in #REGhl overflows the carry is added
. to #REGa, which is kept in BCD, so #REGa ends up holding the percentage.
  $9CE7,$03 Set the multiplier in #REGbc to #N$6276.
  $9CEA,$03 Clear the running total in #REGhl.
  $9CED,$01 Clear the percentage in #REGa.
@ $9CEE label=PrintRoomsVisited_Multiply
  $9CEE,$01 Add the multiplier to the running total.
  $9CEF,$02 Add any carry to the percentage.
  $9CF1,$01 Adjust the percentage to be a BCD number.
  $9CF2,$01 Decrease the count of rooms and amulet pieces by one.
  $9CF3,$01 Stash the percentage so far on the stack.
  $9CF4,$04 Jump to #R$9CFB if the count has run out.
  $9CF8,$01 Restore the percentage so far from the stack.
  $9CF9,$02 Jump back to #R$9CEE to keep adding.
N $9CFB Round the result up and store the percentage as BCD.
@ $9CFB label=PrintRoomsVisited_Store
  $9CFB,$01 Restore the percentage from the stack.
  $9CFC,$03 Set the rounding value in #REGbc to #N$0028.
  $9CFF,$01 Add the rounding value to the running total.
  $9D00,$02 Add any carry to the percentage.
  $9D02,$01 Adjust the percentage to be a BCD number.
  $9D03,$03 Store the tens and units of the percentage in #R$96B7.
  $9D06,$02 Set the hundreds in #REGa to #N$00.
  $9D08,$02 Add the carry flag (the percentage is #N$100 if it is set).
  $9D0A,$01 Adjust the hundreds to be a BCD number.
  $9D0B,$03 Store the hundreds of the percentage in #R$96B6.
N $9D0E Print the percentage, leaving out the hundreds digit if it is zero.
  $9D0E,$03 Set the print position in #REGhl to #N$48F8 in the screen buffer.
  $9D11,$03 Point #REGde at the percentage at #R$96B6.
  $9D14,$02 Set the number of bytes to print in #REGb to #N$01.
  $9D16,$04 Jump to #R$9D1E if the hundreds are zero.
  $9D1A,$01 Print both bytes of the percentage.
  $9D1B,$03 Jump to #R$B5F0 to print the low digit of the first byte and then
. the digits of the second byte.
@ $9D1E label=PrintRoomsVisited_SkipHundreds
  $9D1E,$01 Move the print position on past the unused hundreds digit.
  $9D1F,$01 Move onto the tens and units of the percentage.
  $9D20,$03 Jump to #R$B5E4 to print both digits of the byte.

c $9D23 Visit Room
@ $9D23 label=VisitRoom
D $9D23 Marks the room that an actor is in as having been visited, by setting
. its bit in the bitmap at #R$96BF (the bitmap holds one bit for each of the
. #N($0100,$04,$04) rooms). This uses self-modifying code: the second byte of
. the "SET n,(HL)" instruction at #R$9D3E is overwritten to select the bit.
E $9D23 View the equivalent code in;
. #LIST
. { #ATICATAC$96AF }
. { #KNIGHTLORE$D219 }
. LIST#
R $9D23 IX Actor record
N $9D23 Work out which byte of the bitmap holds the bit for the room.
  $9D23,$03 Fetch the room of the actor.
  $9D26,$01 Stash the room in #REGc.
  $9D27,$03 Divide the room by #N$08
. (each byte of the bitmap holds the bits for #N$08 rooms).
  $9D2A,$02,b$01 Keep only bits 0-4.
  $9D2C,$03 Use it as the offset into the visited rooms bitmap.
N $9D2F Work out which bit of that byte is needed and modify the instruction.
  $9D2F,$01 Fetch the room.
  $9D30,$03 Multiply by #N$08 so that the low three bits of the room are in bits
. 3-5.
  $9D33,$02,b$01 Keep only the bit number (bits 3-5).
  $9D35,$02,b$01 Set bits 1-2, 6-7 (to make the second byte of "SET n,(HL)").
  $9D37,$03 Write this into the second byte of the instruction at #R$9D3E.
N $9D3A Set the bit.
  $9D3A,$04 Add the start of the visited rooms bitmap at #R$96BF to the offset.
  $9D3E,$02 Set the bit for the room in the bitmap.
  $9D40,$01 Return.

c $9D41 Test Amulet Proximity
@ $9D41 label=TestAmuletProximity
D $9D41 Tests whether an actor is close to any of the four amulet pieces which
. have not been collected yet (those with a non-zero sprite ID in the records
. at #R$97FE). A piece counts as close if either of these is true:
. #LIST
. { the column of the room (bits 0-3 of the room number) matches the column
. of the room of the piece and the X positions are less than #N$10 apart }
. { the row of the room (bits 4-7 of the room number) matches the row of the
. room of the piece and the Y positions are less than #N$10 apart }
. LIST#
. The room is only compared in part so the test does not require the actor and
. the piece to be in exactly the same room.
R $9D41 IX Actor record
R $9D41 O:A The distance to the piece which is close
R $9D41 O:F Carry flag set if an amulet piece is close
N $9D41 Check each of the four amulet piece records in turn.
  $9D41,$03 Set the offset to the next amulet piece in #REGde to #N$0B.
  $9D44,$03 Point #REGhl at the first amulet piece record at #R$97FE.
  $9D47,$02 Set the amulet piece counter in #REGb to #N$04.
@ $9D49 label=TestAmuletProximity_Loop
  $9D49,$01 Fetch the sprite ID of the amulet piece.
  $9D4A,$01 Move onto the room of the amulet piece.
  $9D4B,$03 Jump to #R$9D66 if the amulet piece is not present.
N $9D4E Compare the columns of the rooms.
  $9D4E,$01 Fetch the room of the amulet piece.
  $9D4F,$02,b$01 Keep only the column of the room (bits 0-3).
  $9D51,$01 Stash the column of the amulet piece in #REGc.
  $9D52,$03 Fetch the room of the actor.
  $9D55,$02,b$01 Keep only the column of the room (bits 0-3).
  $9D57,$03 Jump to #R$9D6B if the actor is in the same column as the amulet
. piece.
N $9D5A Compare the rows of the rooms.
@ $9D5A label=TestAmuletProximity_Rows
  $9D5A,$01 Fetch the room of the amulet piece.
  $9D5B,$02,b$01 Keep only the row of the room (bits 4-7).
  $9D5D,$01 Stash the row of the amulet piece in #REGc.
  $9D5E,$03 Fetch the room of the actor.
  $9D61,$02,b$01 Keep only the row of the room (bits 4-7).
  $9D63,$03 Jump to #R$9D7D if the actor is in the same row as the amulet piece.
N $9D66 Move on to the next piece.
@ $9D66 label=TestAmuletProximity_Next
  $9D66,$01 Move onto the next amulet piece.
  $9D67,$02 Decrease the amulet piece counter by one and loop back to #R$9D49
. until all four pieces have been checked.
  $9D69,$01 Clear the carry flag (no amulet piece is close).
  $9D6A,$01 Return.
N $9D6B The columns are the same so compare the X positions.
@ $9D6B label=TestAmuletProximity_Columns
  $9D6B,$02 Move onto the X position of the amulet piece.
  $9D6D,$01 Fetch the X position of the amulet piece.
  $9D6E,$02 Move back onto the room of the amulet piece.
  $9D70,$03 Subtract the X position of the actor to get the horizontal distance.
  $9D73,$03 Jump to #R$9D78 if the distance is positive.
  $9D76,$02 Make the distance positive.
@ $9D78 label=TestAmuletProximity_Columns_Positive
  $9D78,$04 Jump to #R$9D5A if the horizontal distance is #N$10 or more.
  $9D7C,$01 Return with the carry flag set (the amulet piece is close).
N $9D7D The rows are the same so compare the Y positions.
@ $9D7D label=TestAmuletProximity_Rows_Same
  $9D7D,$03 Move onto the Y position of the amulet piece.
  $9D80,$01 Fetch the Y position of the amulet piece.
  $9D81,$03 Move back onto the room of the amulet piece.
  $9D84,$03 Subtract the Y position of the actor to get the vertical distance.
  $9D87,$03 Jump to #R$9D8C if the distance is positive.
  $9D8A,$02 Make the distance positive.
@ $9D8C label=TestAmuletProximity_Rows_Same_Positive
  $9D8C,$04 Jump to #R$9D66 if the vertical distance is #N$10 or more.
  $9D90,$01 Return with the carry flag set (the amulet piece is close).

c $9D91 Handler: Flame
@ $9D91 label=HandlerFlame
D $9D91 Handles a flame (sprite IDs #N$34-#N$37) which has been started by
. #R$9ABC. A flame which is not in the player's room is counted off by
. #R$A493. In the player's room it burns for a limited time, drifting around
. in a random direction (which is changed by #R$9E0E whenever its timer runs
. out or it is blocked) and bouncing off the edges of the screen. It flickers
. by changing sprite and colour every time it is handled, and it plays a
. crackling sound. If it touches the player (while the player is coloured
. #COLOUR$47) the player is hit. When its time is up, or the player is dead,
. the flame is blown up.
R $9D91 IX Flame record
N $9D91 Count off the flame if it is not in the same room as the player.
  $9D91,$03 Fetch the room of the player from #R$9703.
  $9D94,$06 Jump to #R$A493 if the flame is in a different room to the player.
  $9D9A,$05 Write #N$17 to #R$96AD (the width of the flame).
  $9D9F,$03 Remember the previous position of the flame.
N $9DA2 Explode the flame if the player is not alive.
  $9DA2,$03 Fetch the sprite ID of the player.
  $9DA5,$02 Subtract #N$10 (the first Sabreman sprite ID).
  $9DA7,$05 Jump to #R$A4A6 if the player is not alive.
N $9DAC Explode the flame when its lifetime runs out.
  $9DAC,$06 Decrease the lifetime of the flame by one and jump to #R$A4A1 if it
. has run out.
N $9DB2 Choose a new direction when the direction timer has run out.
  $9DB2,$06 Decrease the direction timer by one and choose a new direction if it
. has run out.
N $9DB8 Work out the new position of the flame and bounce off the edges of the
. screen.
  $9DB8,$03 Work out the new position of the flame.
  $9DBB,$04 Jump to #R$9E04 if the flame has hit the left or right edge of the
. screen.
  $9DBF,$04 Jump to #R$9E09 if the flame has hit the top or bottom edge of the
. screen.
N $9DC3 Stop the flame moving through objects in the room. If it did not manage
. to move then choose a new direction.
@ $9DC3 label=HandlerFlame_Move
  $9DC3,$03 Set the height of the flame in #REGb to #N$17 and the width in #REGc
. to #N$0F.
  $9DC6,$03 Stop the flame passing through objects in the room.
  $9DC9,$03 Test whether the flame has stayed where it was.
  $9DCC,$03 Choose a new direction if the flame has stayed where it was.
N $9DCF Flicker the flame by choosing one of the four flame sprites and a colour
. at random.
  $9DCF,$03 Fetch the random seed from #R$9695.
  $9DD2,$02,b$01 Keep only bits 0-1.
  $9DD4,$02,b$01 Set bits 2, 4-5.
  $9DD6,$03 Set the sprite ID of the flame.
  $9DD9,$03 Choose a colour for the flame.
  $9DDC,$03 Set the colour of the flame.
N $9DDF Store the new position.
  $9DDF,$03 Set the X position of the flame.
  $9DE2,$03 Set the Y position of the flame.
N $9DE5 Hit the player if the flame touches the player, but only if the player
. is coloured #COLOUR$47.
  $9DE5,$03 Fetch the colour of the player from #R$9707.
  $9DE8,$04 Jump to #R$9DFE if the player is not coloured #COLOUR$47.
  $9DEC,$03 Set the height of the flame in #REGb to #N$13 and the width in #REGc
. to #N$0F.
  $9DEF,$03 Test whether the flame is touching the player.
  $9DF2,$02 Jump to #R$9DFE if the flame is not touching the player.
  $9DF4,$03 Fetch the X position of the player from #R$9705.
  $9DF7,$01 Rotate bit 7 (which half of the screen the player is in) into bit 0.
  $9DF8,$02,b$01 Keep only bit 0.
  $9DFA,$01 Add one, so the hit direction is #N$01 or #N$02.
  $9DFB,$03 Store the hit direction in #R$9704 (the player's state).
N $9DFE Draw the flame and make the crackling sound.
@ $9DFE label=HandlerFlame_Draw
  $9DFE,$03 Display the flame.
  $9E01,$03 Jump to #R$BECC to play the flame sound.

c $9E04 Bounce Flame Horizontally
@ $9E04 label=BounceFlameHorizontally
D $9E04 Reverses the horizontal direction of a flame and carries on moving it.
R $9E04 IX Flame record
  $9E04,$03 Reverse the X velocity of the flame.
  $9E07,$02 Jump to #R$9DC3 to carry on moving the flame.

c $9E09 Bounce Flame Vertically
@ $9E09 label=BounceFlameVertically
D $9E09 Reverses the vertical direction of a flame and carries on moving it.
R $9E09 IX Flame record
  $9E09,$03 Reverse the Y velocity of the flame.
  $9E0C,$02 Jump to #R$9DC3 to carry on moving the flame.

c $9E0E Choose Flame Direction
@ $9E0E label=ChooseFlameDirection
D $9E0E Starts a new direction timer for a flame (#N$40 frames) and chooses its
. velocity. On every other call the velocity is random: the X velocity comes
. from the table at #R$9E5C and the Y velocity from the counter and the Z80
. refresh register. On the other calls the flame heads towards the player
. (see #R$9E2F).
R $9E0E IX Flame record
  $9E0E,$04 Set the direction timer of the flame to #N$40.
  $9E12,$03 Fetch the low byte of the game timer from #R$9693.
  $9E15,$02,b$01 Keep only bit 0.
  $9E17,$02 Jump to #R$9E2F to aim the flame at the player if bit 0 of the pass
. counter is set.
N $9E19 Choose a random velocity.
  $9E19,$03 Fetch the random seed from #R$9695.
  $9E1C,$02,b$01 Keep only bits 0-2.
  $9E1E,$03 Fetch a velocity from the table.
  $9E21,$03 Set the X velocity of the flame.
  $9E24,$02 Fetch the Z80 refresh register as a source of randomness.
  $9E26,$01 Stash it in #REGc.
  $9E27,$03 Fetch the low byte of the game timer from #R$9693.
  $9E2A,$01 Add the refresh register value.
  $9E2B,$03 Set the Y velocity of the flame.
  $9E2E,$01 Return.

c $9E2F Aim Flame At Player
@ $9E2F label=AimFlameAtPlayer
D $9E2F Sets the velocity of a flame so that it heads in the direction of the
. player: the X velocity is #N$C0 (left) or #N$40 (right) and the Y velocity is
. set to #N$40 (down). If the player is above the flame then the code at
. #R$9E4E writes #N$40 to the X velocity again instead of changing the Y
. velocity, so the Y velocity is left as it was.
R $9E2F IX Flame record
  $9E2F,$03 Fetch the X position of the player from #R$9705.
  $9E32,$05 Jump to #R$9E48 if the player is to the left of the flame.
  $9E37,$04 Set the X velocity of the flame to #N$40 (moving right).
@ $9E3B label=AimFlameAtPlayer_Vertical
  $9E3B,$03 Fetch the Y position of the player from #R$9706.
  $9E3E,$05 Jump to #R$9E4E if the player is above the flame.
  $9E43,$04 Set the Y velocity of the flame to #N$40 (moving down).
  $9E47,$01 Return.

c $9E48 Aim Flame Left
@ $9E48 label=AimFlameLeft
D $9E48 Sets the X velocity of a flame so that it moves left.
R $9E48 IX Flame record
  $9E48,$04 Set the X velocity of the flame to #N$C0 (moving left).
  $9E4C,$02 Jump to #R$9E3B to aim vertically.

c $9E4E Aim Flame Up
@ $9E4E label=AimFlameUp
D $9E4E Reached when the player is above a flame. This writes #N$40 to the X
. velocity (*#REGix+#N$06) of the flame and not to the Y velocity
. (*#REGix+#N$07), which looks like a mistake in the original code.
R $9E4E IX Flame record
  $9E4E,$04 Set the X velocity of the flame to #N$40.
  $9E52,$01 Return.

c $9E53 Fetch Flame Velocity
@ $9E53 label=FetchFlameVelocity
D $9E53 Reads a velocity from the table at #R$9E5C.
E $9E53 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$C645 }
. LIST#
R $9E53 A Index into the table (#N$00-#N$07)
R $9E53 O:A The velocity
  $9E53,$03 Point #REGbc at the table of flame velocities at #R$9E5C.
  $9E56,$03 Use the index as the offset into the table.
  $9E59,$01 Add the table address to get the address of the velocity.
  $9E5A,$01 Fetch the velocity from the table.
  $9E5B,$01 Return.

b $9E5C Table: Flame Velocities
@ $9E5C label=FlameVelocities
D $9E5C The X velocities which a flame can be given by #R$9E0E. Values from
. #N$80 are negative (the flame moves left).
B $9E5C,$08,$01

c $9E64 Choose Flame Colour
@ $9E64 label=ChooseFlameColour
D $9E64 Chooses a colour for the flame from the low bits of the random seed
. at #R$9695. The result is a bright ink colour from red to white.
R $9E64 O:A The colour
  $9E64,$03 Fetch the random seed from #R$9695.
  $9E67,$02,b$01 Keep only bits 0-2.
  $9E69,$04 Jump to #R$9E6F if the colour is #N$02 or more.
  $9E6D,$02,b$01 Set bits 1-2.
@ $9E6F label=ChooseFlameColour_Bright
  $9E6F,$02,b$01 Set bit 6 (bright).
  $9E71,$01 Return.

c $9E72 Handler: Hippo And Warthog
@ $9E72 label=HandlerHippoWarthog
D $9E72 Handles a hippo (sprite IDs #N$A0-#N$A3) or a warthog (sprite IDs
. #N$A8-#N$AB) which is awake. The animal walks along (see #R$AFE8), animating
. as it goes, and stays in the same direction until it is blocked by
. something in the room, at which point it falls asleep (bit 2 of the sprite
. ID is set, see #R$9EB3). If the animal has bumped into the player then it
. stands still for a short while (the counter in *#REGix+#N$02 is counted
. down) and, if the player is hurt, the player is hit.
R $9E72 IX Actor record
  $9E72,$03 Remember the previous position of the animal.
  $9E75,$03 Animate the animal.
  $9E78,$05 Write #N$20 to #R$96AD (the width of the animal).
N $9E7D Stand still while the pause counter is running.
  $9E7D,$03 Fetch the pause counter of the animal.
  $9E80,$03 Jump to #R$9E99 if the animal is still paused.
N $9E83 Work out the new position of the animal and stop it walking through
. objects in the room.
  $9E83,$03 Move the animal.
  $9E86,$03 Set the height of the animal in #REGb to #N$17 and the width in
. #REGc to #N$1F.
  $9E89,$03 Stop the animal passing through objects in the room.
N $9E8C Carry on if the animal moved. If it is stuck then put it to sleep.
  $9E8C,$03 Test whether the animal has stayed where it was.
  $9E8F,$03 Jump to #R$AD28 if the animal has moved.
  $9E92,$04 Set bit 2 of the sprite ID to put the animal to sleep.
  $9E96,$03 Jump to #R$AD46 to update the animal.
N $9E99 Count down the pause and test whether the animal has hit the player.
@ $9E99 label=HandlerHippoWarthog_Pause
  $9E99,$01 Decrease the pause counter by one.
  $9E9A,$03 Store the pause counter.
  $9E9D,$03 Fetch the X position of the animal into #REGe.
  $9EA0,$03 Fetch the Y position of the animal into #REGd.
  $9EA3,$03 Fetch the sprite ID of the animal.
  $9EA6,$01 Rotate the direction bit (bit 1) into bit 0.
  $9EA7,$02,b$01 Keep only bit 0.
  $9EA9,$01 Set the direction the animal is facing in #REGd.
  $9EAA,$03 Set how far above and to the right of the animal the player can be
. in #REGbc to #N$0F1C.
  $9EAD,$03 Test whether the animal has hurt the player.
  $9EB0,$03 Jump to #R$AD46 to update the animal.

c $9EB3 Handler: Sleeping Hippo And Warthog
@ $9EB3 label=HandlerSleepingHippoWarthog
D $9EB3 Handles a hippo (sprite IDs #N$A4-#N$A7) or a warthog (sprite IDs
. #N$AC-#N$AF) which is asleep. If #R$A630 has moved the animal to another room
. then it wakes up as a hippo or a warthog chosen at random (see #R$9F06).
. .
. If the player touches the animal (see #R$AB36), unless the start-of-turn delay
. is running or the player is not alive, then the animal wakes up, turns around,
. stands still for a short while (the counter in *#REGix+#N$02) and makes a
. noise.
R $9EB3 IX Actor record
N $9EB3 If the animal has been moved to another room then wake it up.
  $9EB3,$03 Fetch the room of the animal into #REGc.
  $9EB6,$01 Stash the room on the stack.
  $9EB7,$03 Move the animal into the row above or below the player if it is two
. or more rows away.
  $9EBA,$01 Restore the old room of the animal from the stack.
  $9EBB,$03 Fetch the new room of the animal.
  $9EBE,$01 Compare with the old room.
  $9EBF,$03 Wake the animal up if it has moved to a different room.
N $9EC2 Do nothing else unless the animal is in the same room as the player.
  $9EC2,$03 Fetch the room of the player from #R$9703.
  $9EC5,$03 Compare with the room of the animal.
  $9EC8,$01 Return if the animal is in a different room to the player.
  $9EC9,$03 Remember the previous position of the animal.
  $9ECC,$05 Write #N$20 to #R$96AD (the width of the animal).
  $9ED1,$03 Fetch the sprite ID of the animal.
  $9ED4,$01 Rotate the direction bit (bit 1) into bit 0.
  $9ED5,$02,b$01 Keep only bit 0.
  $9ED7,$01 Set the direction the animal is facing in #REGd.
  $9ED8,$03 Set how far above and to the right of the animal the player can be
. in #REGbc to #N$0F1C.
  $9EDB,$03 Fetch the start-of-turn delay from #R$96B5.
  $9EDE,$01 Set the flags.
  $9EDF,$02 Jump to #R$9F01 if the start-of-turn delay is running.
  $9EE1,$03 Fetch the sprite ID of the player from #R$9702.
  $9EE4,$02 Subtract #N$10 (the first Sabreman sprite ID).
  $9EE6,$04 Jump to #R$9F01 if the player is not alive.
  $9EEA,$03 Test whether the animal is touching the player.
@ $9EED label=HandlerSleepingHippoWarthog_Touch
  $9EED,$03 Jump to #R$AD5D to display the animal if the player is not touching
. it.
N $9EF0 The player is touching the animal so it wakes up and turns around.
  $9EF0,$04 Reset bit 2 of the sprite ID to wake the animal up.
  $9EF4,$03 Turn the animal around.
  $9EF7,$04 Set the pause counter of the animal to #N$0F so that it stands
. still.
  $9EFB,$03 Display the animal.
  $9EFE,$03 Jump to #R$BF17 to play the warble sound.
N $9F01 Test whether the player is touching the animal, without hurting the
. player.
@ $9F01 label=HandlerSleepingHippoWarthog_NoHurt
  $9F01,$03 Test whether the player is touching the animal.
  $9F04,$02 Jump to #R$9EED.

c $9F06 Wake Animal
@ $9F06 label=WakeAnimal
D $9F06 Wakes up a hippo or a warthog by resetting bit 2 of the sprite ID. Bit 3
. of the sprite ID is set from bit 3 of the random seed, which makes it a
. warthog (set) or a hippo (reset).
R $9F06 IX Actor record
  $9F06,$03 Fetch the random seed from #R$9695.
  $9F09,$02,b$01 Keep only bit 3.
  $9F0B,$01 Stash bit 3 of the random seed in #REGc.
  $9F0C,$03 Fetch the sprite ID of the animal.
  $9F0F,$02,b$01 Keep only bits 0-1 and 4-7.
  $9F11,$01 Merge in bit 3 from the random seed.
  $9F12,$03 Store the new sprite ID of the animal.
  $9F15,$01 Return.

c $9F16 Handler: Guardian
@ $9F16 label=HandlerGuardian
D $9F16 Handles the guardian (sprite IDs #N$94-#N$95). Nothing happens unless
. the guardian is in the same room as the player.
. .
. Until all four pieces of the amulet have been collected (see #R$970D) the
. guardian is animated, and if it touches the player (see #R$AB3D) then the
. player is hit with a hit direction of #N$80, which makes the player fall
. straight down.
. .
. Once all four pieces have been collected the guardian steps aside to let the
. player past. It walks to the left if the X position of the player is #N$80 or
. more, but it does not move further left than #N$40. Otherwise it walks to the
. right, but it does not move further right than #N$BF.
R $9F16 IX Actor record
  $9F16,$03 Fetch the room of the player from #R$9703.
  $9F19,$03 Compare with the room of the guardian.
  $9F1C,$01 Return if the guardian is in a different room.
  $9F1D,$03 Remember the previous position of the guardian.
  $9F20,$03 Fetch the amulet pieces collected from #R$970D.
  $9F23,$02,b$01 Keep only bits 0-3.
  $9F25,$04 Jump to #R$9F40 if all four amulet pieces have been collected.
  $9F29,$03 Animate the guardian.
  $9F2C,$03 Set how far above and to the right of the guardian the player can be
. in #REGbc to #N$170F.
  $9F2F,$03 Test whether the guardian is touching the player.
  $9F32,$03 Jump to #R$AD5D to display the guardian if the player is not
. touching it.
  $9F35,$05 Set the hit direction of the player in #R$9704 to #N$80.
  $9F3A,$03 Play the warble sound.
  $9F3D,$03 Jump to #R$AD5D to display the guardian.
N $9F40 All four pieces have been collected. Walk to the left if the player is
. in the right half of the screen.
@ $9F40 label=HandlerGuardian_StepAside
  $9F40,$03 Fetch the X position of the player from #R$9705.
  $9F43,$04 Jump to #R$9F5D if the player is in the left half of the screen.
  $9F47,$04 Set the X velocity of the guardian to #N$E0 (walking to the left).
  $9F4B,$03 Work out the new position of the guardian.
  $9F4E,$01 Fetch the new X position of the guardian.
  $9F4F,$02 Compare with #N$40.
@ $9F51 label=HandlerGuardian_Limit
  $9F51,$03 Jump to #R$AD5D to display the guardian if it has reached the limit
. of its walk.
  $9F54,$03 Set the new X position of the guardian.
  $9F57,$03 Animate the guardian.
  $9F5A,$03 Jump to #R$AD5D to display the guardian.
N $9F5D Walk to the right.
@ $9F5D label=HandlerGuardian_Right
  $9F5D,$04 Set the X velocity of the guardian to #N$20 (walking to the right).
  $9F61,$03 Work out the new position of the guardian.
  $9F64,$01 Fetch the new X position of the guardian.
  $9F65,$02 Compare with #N$C0.
  $9F67,$01 Invert the carry flag.
  $9F68,$02 Jump to #R$9F51.

c $9F6A Game Complete
@ $9F6A label=GameComplete
D $9F6A Shows the "Game Complete" screen when the player has reached the end of
. the game (see #R$A18C). The play area is cleared and the room data at
. #R$C386 is drawn, followed by the six messages at #R$9F91, and then the tune
. at #R$BC67 is played.
. .
. The player is then left with no lives, so that #R$AA27 ends the game for the
. player (or hands over to the other player in a two player game).
. .
. #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune)))
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #SCR$01(game-complete-before)
. | #SIM(start=$9F6A,stop=$9F7E,sp=$5B40)
. #SCR$01(game-complete-after) } UDGTABLE# #POPS
N $9F6A Clear down the play area.
  $9F6A,$03 Clear the attribute buffer of the play area.
  $9F6D,$03 Clear the play area.
N $9F70 Display the "Game Complete" screen.
  $9F70,$03 Point #REGhl at the room data for the "Game Complete" screen at
. #R$C386.
  $9F73,$03 Draw the room.
N $9F76 Display the "Game Complete" messaging.
  $9F76,$03 Point #REGde at the "Game Complete" messages at #R$9F91.
N $9F79 There are six messages. Calling #R$A036 skips setting up the counter.
  $9F79,$02 Set the message counter in #REGb to #N$06.
  $9F7B,$03 Print the messages.
N $9F7E Play the tune and then check if the game is being paused.
  $9F7E,$03 Point #REGde at the tune at #R$BC67.
  $9F81,$03 Play the tune.
  $9F84,$03 Check if the game is paused.
N $9F87 The game is over, so the player has no lives left.
  $9F87,$04 Set the number of lives in #R$96BD to #N$00.
  $9F8B,$03 Update the lives display.
  $9F8E,$03 Jump to #R$AA27 to end the game.

t $9F91 Messaging: Congratulations
@ $9F91 label=GameComplete_Copy
D $9F91 #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Attribute | =h Text }
. #FOREACH($9F91,$9F9C,$9FB6,$9FD1,$9FF0,$A003)(n,{ #N(#EVAL(#PEEKn / $08)) | #N(#EVAL(#PEEK(n + $01) / $08)) | #N(#PEEK(n + $02)) | #STR(n + $03) })
. TABLE#
. .
. The six messages printed by #R$9F6A. Each message is an X position, a Y
. position and an attribute, followed by the text, whose last character has bit
. 7 set (see #R$B53D).
B $9F91,$02 X / Y position.
B $9F93,$01 Attribute.
  $9F94,$08,$07:$01 "#STR(#PC)".
B $9F9C,$02 X / Y position.
B $9F9E,$01 Attribute.
  $9F9F,$17,$16:$01 "#STR(#PC)".
B $9FB6,$02 X / Y position.
B $9FB8,$01 Attribute.
  $9FB9,$18,$17:$01 "#STR(#PC)".
B $9FD1,$02 X / Y position.
B $9FD3,$01 Attribute.
  $9FD4,$1C,$1B:$01 "#STR(#PC)".
B $9FF0,$02 X / Y position.
B $9FF2,$01 Attribute.
  $9FF3,$10,$0F:$01 "#STR(#PC)".
B $A003,$02 X / Y position.
B $A005,$01 Attribute.
  $A006,$15,$14:$01 "#STR(#PC)".

c $A01B Display Poem
@ $A01B label=DisplayPoem
D $A01B Prints one of the four poems at the bottom of the screen. Which poem is
. shown depends on how many amulet pieces the player has collected (the number
. of bits set in the low four bits of #R$970D): poem 1 for one piece, poem 2
. for two pieces, poem 3 for three pieces and poem 4 for all four.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$A01B }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #POKES$970D,$0F
. #SIM(start=$A207,stop=$A234,ix=$9702,sp=$5B40)
. #SCR$01(display-poem-before)
. | #SIM(start=$A01B,stop=$0000,ix=$9702,sp=$5B40)
. #SCR$01(display-poem-after) } UDGTABLE# #POPS
R $A01B IX Actor record of the player
N $A01B Count the number of amulet pieces which have been collected.
  $A01B,$03 Fetch the amulet pieces collected from the actor record.
  $A01E,$03 Set the amulet piece counter in #REGb to #N$04 and the number of
. pieces collected in #REGc to #N$00.
@ $A021 label=Poem_CollectCollected_Loop
  $A021,$01 Rotate the flag for the next amulet piece into the carry flag.
  $A022,$02 Jump to #R$A025 if the amulet piece has not been collected.
  $A024,$01 Count the amulet piece.
@ $A025 label=Poem_CollectCollected_Skip
  $A025,$02 Decrease the amulet piece counter by one and loop back to #R$A021
. until all four pieces have been checked.
  $A027,$01 Fetch the number of amulet pieces collected.
N $A028 Choose the poem to display.
  $A028,$03 Jump to #R$A046 to show poem 1 if only one amulet piece has been
. collected.
  $A02B,$03 Jump to #R$A04B to show poem 2 if two amulet pieces have been
. collected.
  $A02E,$03 Jump to #R$A050 to show poem 3 if three amulet pieces have been
. collected.
N $A031 Otherwise display poem 4.
  $A031,$03 Point #REGde at the first message of poem 4 at #R$A13B.

c $A034 Print Messages
@ $A034 label=Poem_Start
D $A034 Prints a number of messages on the screen. Each message is held as an X
. position, a Y position, an attribute byte and the text (see #R$A055), and is
. printed by #R$B53D.
R $A034 B The number of messages to print
R $A034 DE The address of the first message
  $A034,$02 Set the message counter in #REGb to #N$04.
@ $A036 label=Poem_Loop
N $A036 Print each message in turn.
  $A036,$06 Fetch the X position into #REGl and the Y position into #REGh of the
. message, leaving #REGde pointing at the attribute byte.
  $A03C,$01 Stash the message counter on the stack.
  $A03D,$03 Print the message.
  $A040,$01 Switch to the shadow registers.
  $A041,$01 Move onto the next message.
  $A042,$01 Restore the message counter from the stack.
  $A043,$02 Decrease the message counter by one and loop back to #R$A036 until
. all of the messages have been printed.
  $A045,$01 Return.

c $A046 Select Poem
@ $A046 label=Poem_1_Reference
D $A046 Points #REGde at the first message of a poem and then prints it (#N$04
. lines) by jumping into #R$A034.
N $A046 Poem 1.
  $A046,$03 Point #REGde at the first message of poem 1 at #R$A055.
  $A049,$02 Jump to #R$A034 to print the poem.
N $A04B Poem 2.
@ $A04B label=Poem_2_Reference
  $A04B,$03 Point #REGde at the first message of poem 2 at #R$A0A7.
  $A04E,$02 Jump to #R$A034 to print the poem.
N $A050 Poem 3.
@ $A050 label=Poem_3_Reference
  $A050,$03 Point #REGde at the first message of poem 3 at #R$A0F4.
  $A053,$02 Jump to #R$A034 to print the poem.

t $A055 Messaging: Poem 1
@ $A055 label=Poem_1_Copy
D $A055 The poem shown when one piece of the amulet has
. been collected (see #R$A01B). It is made up of four messages, each
. of which is an X position, a Y position (both in pixels), an
. attribute byte and then the text, with bit 7 set on the last
. character.
. .
. #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Attribute | =h Text }
. #FOREACH($A055,$A071,$A07E,$A097)(n,{ #N(#EVAL(#PEEKn / $08)) | #N(#EVAL(#PEEK(n + $01) / $08)) | #N(#PEEK(n + $02)) | #STR(n + $03) })
. TABLE#
B $A055,$02 X / Y position.
B $A057,$01 Attribute.
  $A058,$19,$18:$01 "#STR(#PC)".
B $A071,$02 X / Y position.
B $A073,$01 Attribute.
  $A074,$0A,$09:$01 "#STR(#PC)".
B $A07E,$02 X / Y position.
B $A080,$01 Attribute.
  $A081,$16,$15:$01 "#STR(#PC)".
B $A097,$02 X / Y position.
B $A099,$01 Attribute.
  $A09A,$0D,$0C:$01 "#STR(#PC)".

t $A0A7 Messaging: Poem 2
@ $A0A7 label=Poem_2_Copy
D $A0A7 The poem shown when two pieces of the amulet have
. been collected (see #R$A01B). It is made up of four messages, each
. of which is an X position, a Y position (both in pixels), an
. attribute byte and then the text, with bit 7 set on the last
. character.
. .
. #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Attribute | =h Text }
. #FOREACH($A0A7,$A0C4,$A0CE,$A0E9)(n,{ #N(#EVAL(#PEEKn / $08)) | #N(#EVAL(#PEEK(n + $01) / $08)) | #N(#PEEK(n + $02)) | #STR(n + $03) })
. TABLE#
B $A0A7,$02 X / Y position.
B $A0A9,$01 Attribute.
  $A0AA,$1A,$19:$01 "#STR(#PC)".
B $A0C4,$02 X / Y position.
B $A0C6,$01 Attribute.
  $A0C7,$07,$06:$01 "#STR(#PC)".
B $A0CE,$02 X / Y position.
B $A0D0,$01 Attribute.
  $A0D1,$18,$17:$01 "#STR(#PC)".
B $A0E9,$02 X / Y position.
B $A0EB,$01 Attribute.
  $A0EC,$08,$07:$01 "#STR(#PC)".

t $A0F4 Messaging: Poem 3
@ $A0F4 label=Poem_3_Copy
D $A0F4 The poem shown when three pieces of the amulet have
. been collected (see #R$A01B). It is made up of four messages, each
. of which is an X position, a Y position (both in pixels), an
. attribute byte and then the text, with bit 7 set on the last
. character.
. .
. #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Attribute | =h Text }
. #FOREACH($A0F4,$A10A,$A116,$A130)(n,{ #N(#EVAL(#PEEKn / $08)) | #N(#EVAL(#PEEK(n + $01) / $08)) | #N(#PEEK(n + $02)) | #STR(n + $03) })
. TABLE#
B $A0F4,$02 X / Y position.
B $A0F6,$01 Attribute.
  $A0F7,$13,$12:$01 "#STR(#PC)".
B $A10A,$02 X / Y position.
B $A10C,$01 Attribute.
  $A10D,$09,$08:$01 "#STR(#PC)".
B $A116,$02 X / Y position.
B $A118,$01 Attribute.
  $A119,$17,$16:$01 "#STR(#PC)".
B $A130,$02 X / Y position.
B $A132,$01 Attribute.
  $A133,$08,$07:$01 "#STR(#PC)".

t $A13B Messaging: Poem 4
@ $A13B label=Poem_4_Copy
D $A13B The poem shown when all four pieces of the amulet have
. been collected (see #R$A01B). It is made up of four messages, each
. of which is an X position, a Y position (both in pixels), an
. attribute byte and then the text, with bit 7 set on the last
. character.
. .
. #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Attribute | =h Text }
. #FOREACH($A13B,$A158,$A165,$A180)(n,{ #N(#EVAL(#PEEKn / $08)) | #N(#EVAL(#PEEK(n + $01) / $08)) | #N(#PEEK(n + $02)) | #STR(n + $03) })
. TABLE#
B $A13B,$02 X / Y position.
B $A13D,$01 Attribute.
  $A13E,$1A,$19:$01 "#STR(#PC)".
B $A158,$02 X / Y position.
B $A15A,$01 Attribute.
  $A15B,$0A,$09:$01 "#STR(#PC)".
B $A165,$02 X / Y position.
B $A167,$01 Attribute.
  $A168,$18,$17:$01 "#STR(#PC)".
B $A180,$02 X / Y position.
B $A182,$01 Attribute.
  $A183,$09,$08:$01 "#STR(#PC)".

c $A18C Test Player Progress
@ $A18C label=TestPlayerProgress
D $A18C Called once per frame for the player. Checks whether the game has been
. completed and whether an amulet piece has just been collected.
R $A18C IX Actor record of the player
N $A18C The game is complete if the player is in room #N$88 and is above the
. half-way point of the screen.
  $A18C,$03 Fetch the room of the player.
  $A18F,$04 Jump to #R$A19F if the player is not in room #N$88.
  $A193,$03 Fetch the Y position of the player.
  $A196,$04 Jump to #R$A19F if the player has not reached the top half of the
. screen (the Y position is #N$80 or more).
N $A19A The game is over, so discard the return address as #R$9F6A never
. returns to the caller.
  $A19A,$02 Discard the return address.
  $A19C,$03 Jump to #R$9F6A to complete the game.
N $A19F Show the amulet if a piece has just been collected.
@ $A19F label=TestPlayerProgress_ShowAmulet
  $A19F,$05 Return unless the "show the amulet" flag
. (bit 7 of the amulet pieces collected, see #R$970D) is set.
  $A1A4,$04 Reset the "show the amulet" flag as it has been dealt with.
  $A1A8,$03 Jump to #R$A207 to show the amulet.

c $A1AB Handler: Amulet Piece
@ $A1AB label=HandlerAmuletPiece
D $A1AB Handles the four amulet pieces (sprite IDs #N$90 to #N$93), which are
. placed in the rooms by #R$A255. The piece flashes when it is in the room
. the player is in and when the player touches it, it is collected.
. .
. Collecting a piece sets the bit in #R$970D that corresponds to the piece,
. sets bit 7 of the same byte so that the amulet is shown by #R$A18C, and
. awards 7500 points.
R $A1AB IX Actor record of the amulet piece
N $A1AB Do nothing unless the piece is in the same room as the player.
  $A1AB,$03 Fetch the room of the player from #R$9703.
  $A1AE,$03 Compare with the room of the amulet piece.
  $A1B1,$01 Return if the amulet piece is in a different room to the player.
  $A1B2,$03 Set how far above and to the right of the amulet piece the player
. can be in #REGbc to #N$0C0C (see #R$AB01).
N $A1B5 Every other frame, cycle the piece through the colours #N$44 to #N$47.
  $A1B5,$03 Fetch the low byte of the game timer from #R$9693.
  $A1B8,$02,b$01 Keep only bit 0.
  $A1BA,$02 Jump to #R$A1C7 if bit 0 is set
. (the colour only changes on alternate passes).
  $A1BC,$03 Fetch the colour of the amulet piece.
  $A1BF,$01 Move on to the next colour.
  $A1C0,$02,b$01 Keep only bits 0-1.
  $A1C2,$02,b$01 Set bits 2 and 6, giving a bright ink colour of #N$04-#N$07.
  $A1C4,$03 Set the new colour of the amulet piece.
N $A1C7 Test whether the player is touching the piece.
@ $A1C7 label=AmuletPiece_TestTouch
  $A1C7,$03 Test whether the player is touching the amulet piece.
  $A1CA,$03 Jump to #R$A31A to draw the amulet piece if the player is not
. touching it.
N $A1CD The piece has been collected, so work out which bit to set.
  $A1CD,$03 Fetch the amulet pieces collected from #R$970D.
  $A1D0,$02,b$01 Set bit 7 (the "show the amulet" flag).
  $A1D2,$01 Stash the new amulet pieces collected in #REGc.
  $A1D3,$03 Fetch the sprite ID of the amulet piece.
  $A1D6,$02 Subtract #N$90 to get the number of the amulet piece.
  $A1D8,$02 Jump to #R$A1F3 if this is the first amulet piece.
  $A1DA,$01 Move on to the next piece number.
  $A1DB,$02 Jump to #R$A1F7 if this is the second amulet piece.
  $A1DD,$01 Move on to the next piece number.
  $A1DE,$02 Jump to #R$A1FB if this is the third amulet piece.
  $A1E0,$02 Set bit 3 of the amulet pieces collected, as this is the fourth
. piece.
@ $A1E2 label=AmuletPiece_Collected
  $A1E2,$01 Fetch the new amulet pieces collected.
  $A1E3,$03 Store the amulet pieces collected in #R$970D.
  $A1E6,$03 Erase the amulet piece from the screen.
  $A1E9,$04 Remove the amulet piece by setting its sprite ID to #N$00.
N $A1ED Add 7500 points to the player's score.
  $A1ED,$03 Set the points to award in #REGbc to 7500 (stored as BCD).
  $A1F0,$03 Jump to #R$B5A9 to add the points to the score.
N $A1F3 Set the bit for the first, second or third piece.
@ $A1F3 label=AmuletPiece_First
  $A1F3,$02 Set bit 0 of the amulet pieces collected for the first piece.
  $A1F5,$02 Jump to #R$A1E2.
@ $A1F7 label=AmuletPiece_Second
  $A1F7,$02 Set bit 1 of the amulet pieces collected for the second piece.
  $A1F9,$02 Jump to #R$A1E2.
@ $A1FB label=AmuletPiece_Third
  $A1FB,$02 Set bit 2 of the amulet pieces collected for the third piece.
  $A1FD,$02 Jump to #R$A1E2.

c $A1FF Pause
@ $A1FF label=Pause
D $A1FF A simple delay loop. #REGhl is counted down to zero, which is repeated
. #REGb times. As #REGhl wraps around when it is zero, every pass after the
. first one counts through all #N$10000 values.
E $A1FF View the equivalent code in;
. #LIST
. { #MARTIANOIDS$BD32 }
. LIST#
R $A1FF B Number of times to count down #REGhl
R $A1FF HL Start value for the first count down
  $A1FF,$01 Decrease the delay counter in #REGhl by one.
  $A200,$04 Loop back to #R$A1FF until the delay counter in #REGhl is zero.
  $A204,$02 Decrease the number of delays in #REGb by one and loop back to
. #R$A1FF until all of the delays have been done.
  $A206,$01 Return.

c $A207 Show Amulet
@ $A207 label=ShowAmulet
D $A207 Clears the play area and draws the amulet in the middle of the screen.
. The amulet is drawn as four graphics, one for each piece. Every piece is
. drawn as a plain red silhouette, unless it has been collected, in which case
. it is drawn in full colour. Each of the graphics is drawn by #R$BC0B, which
. holds two sets of attributes for each graphic, the second of which is only
. used when #R$96B2 is set.
. .
. Once the amulet has been drawn the poem is shown by #R$A234.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$A207 }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #POKES$970D,$07
. #SCR$01(show-amulet-before)
. | #SIM(start=$A207,stop=$A234,ix=$9702,sp=$5B40)
. #SCR$01(show-amulet-after) } UDGTABLE# #POPS
R $A207 IX Actor record of the player
  $A207,$03 Clear the attribute buffer of the play area.
  $A20A,$03 Clear the play area.
  $A20D,$03 Fetch the amulet pieces collected from #R$970D.
  $A210,$01 Stash the amulet pieces collected in #REGc.
  $A211,$03 Point #REGhl at the table of amulet graphics and positions at
. #R$C374.
N $A214 Draw each of the amulet pieces in turn.
@ $A214 label=ShowAmulet_Loop
  $A214,$03 Fetch the address of the next graphic from the table into #REGde.
  $A217,$04 Jump to #R$A234 if the end of the table has been reached
. (the address is zero).
  $A21B,$01 Move onto the position of the graphic.
  $A21C,$02 Shift the collected flag for this amulet piece out of #REGc and into
. the carry flag.
  $A21E,$02 Jump to #R$A225 if the amulet piece has not been collected.
  $A220,$05 Write #N$01 to #R$96B2 so that the graphic is drawn in full colour.
@ $A225 label=ShowAmulet_Draw
  $A225,$01 Stash the amulet pieces remaining on the stack.
  $A226,$03 Fetch the position of the graphic from the table
. (#REGc is the X position and #REGb the Y position).
  $A229,$01 Move onto the next table entry.
  $A22A,$01 Stash the table pointer on the stack.
  $A22B,$02 Copy the position to #REGhl.
  $A22D,$03 Draw the graphic of the amulet piece.
  $A230,$02 Restore the table pointer and the amulet pieces remaining from the
. stack.
  $A232,$02 Jump back to #R$A214 to draw the next amulet piece.

c $A234 Show Poem
@ $A234 label=HandlerPoems
D $A234 Shows the poem for the pieces of the amulet which have been collected,
. plays a tune, waits for a while and then restores the play area. This is
. reached when #R$A207 has finished drawing the amulet.
. .
. #HTML(#AUDIO0(poem-tune.wav)(#INCLUDE(PoemTune)))
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$A234 }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #POKES$970D,$05
. #SIM(start=$A207,stop=$A234,ix=$9702,sp=$5B40)
. #SCR$01(show-poem-before)
. | #SIM(start=$A234,stop=$A237,ix=$9702,sp=$5B40)
. #SCR$01(show-poem-after) } UDGTABLE# #POPS
N $A234 Display the poem copy.
  $A234,$03 Display the poem.
N $A237 Play music.
  $A237,$03 Set #REGhl to #N$0000.
  $A23A,$03 Point #REGde at the poem tune at #R$BD33.
  $A23D,$03 Play the tune.
N $A240 Pause so the player has a chance to read and listen.
  $A240,$02 Set the number of delays in #REGb to #N$08.
  $A242,$03 Pause so that the player can read the poem.
  $A245,$03 Check if the game is paused.
N $A248 Put the room back as it was.
  $A248,$03 Clear the attribute buffer of the play area.
  $A24B,$03 Clear the play area.
  $A24E,$03 Draw the current room.
  $A251,$03 Redraw the player.
  $A254,$01 Return.

c $A255 Place Amulet Pieces
@ $A255 label=PlaceAmuletPieces
D $A255 Sets up the four amulet pieces in #R$97FE. The random seed in #R$9695
. selects one of eight sets of four rooms (see #R$A29D) and each piece is put
. at the first position in the room's layout (see #R$DC6C). The pieces are
. numbered #N$90 to #N$93 and are all drawn in bright yellow (#N$46).
. .
. This is used when a new game is started.
  $A255,$04 Point #REGix at the first amulet piece record at #R$97FE.
  $A259,$03 Fetch the random seed from #R$9695.
  $A25C,$02,b$01 Keep only bits 0-2.
  $A25E,$01 Stash the set number in #REGl.
  $A25F,$02 Clear #REGh.
  $A261,$02 Multiply the set number by four, as there are four rooms in each
. set.
  $A263,$03 Point #REGbc at the sets of amulet piece rooms at #R$A29D.
  $A266,$01 Add the set offset to get the address of the chosen set of rooms.
  $A267,$01 Point #REGde at the chosen set of rooms.
N $A268 There are four pieces of the amulet to collect.
  $A268,$02 Set the amulet piece counter in #REGb to #N$04.
@ $A26A label=PlaceAmuletPieces_Loop
  $A26A,$01 Stash the amulet piece counter on the stack.
  $A26B,$01 Copy the amulet piece counter to #REGa.
  $A26C,$02 Add #N$8F, giving a sprite ID of #N$90 to #N$93.
  $A26E,$03 Set the sprite ID of the amulet piece.
  $A271,$01 Fetch the room for this amulet piece.
  $A272,$01 Move onto the next room in the set.
  $A273,$03 Set the room of the amulet piece.
N $A276 Find the layout of the room, and from it the position of the piece.
  $A276,$01 Use the room as the offset into the layout table.
  $A277,$02 Clear #REGh.
  $A279,$03 Point #REGbc at the layout table at #R$6066.
  $A27C,$01 Add the layout table address to get the address of the layout number
. for the room.
  $A27D,$01 Fetch the layout number.
  $A27E,$02 Clear #REGh.
  $A280,$03 Multiply the layout number by eight, as there are eight bytes of
. positions for each layout.
  $A283,$03 Point #REGbc at the table of object positions at #R$DC6C.
  $A286,$01 Add the table address to get the first position for the layout.
  $A287,$01 Fetch the X position.
  $A288,$01 Move onto the Y position.
  $A289,$03 Set the X position of the amulet piece.
  $A28C,$01 Fetch the Y position.
  $A28D,$03 Set the Y position of the amulet piece.
  $A290,$04 Set the colour of the amulet piece to #COLOUR$46.
  $A294,$03 Set the size of an actor record in #REGbc to #N$0C.
  $A297,$02 Move onto the next actor record.
  $A299,$01 Restore the amulet piece counter from the stack.
  $A29A,$02 Decrease the amulet piece counter by one and loop back to #R$A26A
. until all four pieces have been placed.
  $A29C,$01 Return.

b $A29D Amulet Piece Rooms
@ $A29D label=Initialisation_Amulet
D $A29D Eight sets of four rooms. One of the sets is chosen at random by
. #R$A255 and the four amulet pieces are placed in its rooms, in the order
. #N$93, #N$92, #N$91 and #N$90.
  $A29D,$04 Set 1.
  $A2A1,$04 Set 2.
  $A2A5,$04 Set 3.
  $A2A9,$04 Set 4.
  $A2AD,$04 Set 5.
  $A2B1,$04 Set 6.
  $A2B5,$04 Set 7.
  $A2B9,$04 Set 8.

c $A2BD Generate Room Objects
@ $A2BD label=GenerateRoomObjects
D $A2BD Fills a table of #N$0200 bytes at #R$DDEC with the objects (see
. #R$A33B) which are to be found in the rooms. There are two bytes for each of
. the #N$0100 rooms, so each room can hold up to two objects.
. .
. A byte is taken from the ROM (starting at an address made from #R$9693 and
. the frame counter, so it is effectively random) for each byte of the table.
. If the ROM byte is #N$80 or more then the table byte is zero, which means
. there is no object. Otherwise the table byte is made up from:
. #LIST
. { Bits 6-7: which of the room's four positions to use (taken from the byte
. count) }
. { Bits 0-3: the type of object (taken from the random seed at #R$9695) }
. LIST#
. This is used when a new game is started.
  $A2BD,$03 Point #REGhl at the table of room objects at #R$DDEC.
  $A2C0,$04 Fetch the low byte of #SKOOLKID$5C78(FRAMES) into #REGe.
  $A2C4,$03 Fetch the low byte of the game timer from #R$9693.
  $A2C7,$02,b$01 Keep only bits 0-4.
  $A2C9,$01 Use it as the high byte of the ROM address in #REGd, so #REGde
. points into the ROM.
  $A2CA,$03 Set the number of bytes in the table in #REGbc to #N$0200.
@ $A2CD label=GenerateRoomObjects_Loop
  $A2CD,$01 Fetch a (random) byte from the ROM.
  $A2CE,$01 Move onto the next ROM byte.
  $A2CF,$04 Jump to #R$A2DC if the ROM byte is less than #N$80.
  $A2D3,$02 Write #N$00 to the table, so there is no object here.
@ $A2D5 label=GenerateRoomObjects_Next
  $A2D5,$01 Move onto the next table byte.
@ $A2D6 label=GenerateRoomObjects_Count
  $A2D6,$01 Decrease the byte counter by one.
  $A2D7,$04 Loop back to #R$A2CD until all #N$0200 bytes of the table have been
. done.
  $A2DB,$01 Return.
N $A2DC Make the table byte for an object.
@ $A2DC label=GenerateRoomObjects_Object
  $A2DC,$01 Stash the byte counter on the stack.
  $A2DD,$01 Fetch the low byte of the byte counter.
  $A2DE,$02 Rotate the low byte of the byte counter right twice.
  $A2E0,$02,b$01 Keep only bits 6-7.
  $A2E2,$01 Stash the position bits in #REGc.
  $A2E3,$03 Fetch the random seed from #R$9695.
  $A2E6,$02,b$01 Keep only bits 0-3.
  $A2E8,$01 Combine the position and the object type.
  $A2E9,$01 Write the table byte for the object.
  $A2EA,$01 Move onto the next table byte.
N $A2EB Update the random seed.
  $A2EB,$02 Fetch the Z80 refresh register.
  $A2ED,$01 Stash it in #REGc.
  $A2EE,$03 Fetch the random seed from #R$9695.
  $A2F1,$01 Add the refresh register value to the seed.
  $A2F2,$03 Store the new random seed in #R$9695.
  $A2F5,$01 Restore the byte counter from the stack.
  $A2F6,$02 Jump back to #R$A2D6.

c $A2F8 Add Life
@ $A2F8 label=AddLife
D $A2F8 Gives the player an extra life, up to a maximum of nine, and updates
. the lives on the screen.
  $A2F8,$03 Fetch the number of lives from #R$96BD.
  $A2FB,$03 Return if the player already has #N$09 lives.
  $A2FE,$01 Add a life.
  $A2FF,$03 Store the number of lives in #R$96BD.
  $A302,$03 Jump to #R$B7CD to update the lives display.

c $A305 Handler: Extra Life
@ $A305 label=HandlerExtraLife
D $A305 Handles the extra life (sprite ID #N$85). If the player touches it then
. a life is added, otherwise it is drawn.
R $A305 IX Actor record of the extra life
  $A305,$03 Set how far above and to the right of the extra life the player can
. be in #REGbc to #N$0C0C (see #R$AB01).
  $A308,$03 Test whether the player is touching the extra life.
  $A30B,$02 Jump to #R$A31A to draw the extra life if the player is not touching
. it.
  $A30D,$03 Add a life.
  $A310,$02 Jump to #R$A323 to collect the extra life.

c $A312 Handler: Pickup
@ $A312 label=HandlerPickup
D $A312 Handles the pickups (sprite IDs #N$80 to #N$84 and #N$86 to #N$8F). If
. the player touches one then it is collected, otherwise it is drawn.
R $A312 IX Actor record of the pickup
  $A312,$03 Set how far above and to the right of the pickup the player can be
. in #REGbc to #N$0C0C (see #R$AB01).
  $A315,$03 Test whether the player is touching the pickup.
  $A318,$02 Jump to #R$A323 to collect the pickup if the player is touching it.

c $A31A Colour Pickup
@ $A31A label=ColourPickup
D $A31A Sets the attributes of the screen cells covered by a pickup, which is a
. sprite #N$10 pixels high and two cells wide, using #R$BB24.
R $A31A IX Actor record of the pickup
  $A31A,$03 Set the height of the pickup in #REGl to #N$10 and the number of
. columns in #REGh to #N$02.
  $A31D,$03 Store the height and the number of columns in #R$96A5 and #R$96A6.
  $A320,$03 Jump to #R$BB24 to colour the pickup.

c $A323 Collect Pickup
@ $A323 label=CollectPickup
D $A323 Collects a pickup: it is erased from the screen, removed from the
. table of room objects so that it does not come back, and is worth 150
. points. A tone is then played by #R$BF25.
. .
. #HTML(#AUDIO0(high-tone.wav)(#INCLUDE(HighTone)))
R $A323 IX Actor record of the pickup
  $A323,$03 Erase the pickup from the screen.
N $A326 Remove the object from the table of objects in the room.
  $A326,$03 Fetch the low byte of the address of the pickup's entry in the table
. of room objects.
  $A329,$03 Fetch the high byte of the address of the pickup's entry.
  $A32C,$02 Clear the table entry so that the pickup is gone from the room.
  $A32E,$04 Remove the pickup by setting its sprite ID to #N$00.
N $A332 Add 150 points to the player's score.
  $A332,$03 Set the points to award in #REGbc to 150 (stored as BCD).
  $A335,$03 Add the points to the score.
  $A338,$03 Jump to #R$BF25 to play the high tone.

c $A33B Set Up Room Objects
@ $A33B label=SetUpRoomObjects
D $A33B Creates the actors for the objects which are in the room the player is
. in. Each room has two entries in the table built by #R$A2BD, and each of the
. entries which is not zero is turned into one of the two actors in
. #R$97E6.
E $A33B Continue on to #R$A356.
R $A33B IX Actor record of the player
N $A33B Clear the first object and create it from the first table entry.
  $A33B,$03 Point #REGde at the record of the first object at #R$97E6.
  $A33E,$01 Clear #REGa.
  $A33F,$01 Clear the sprite ID of the first object.
  $A340,$03 Find the entries in the table of room objects for the room.
  $A343,$01 Fetch the first table entry for the room.
  $A344,$03 Jump to #R$A34A if there is no object in the first entry.
  $A347,$03 Create the first object.
N $A34A Clear the second object and create it from the second table entry.
@ $A34A label=SetUpRoomObjects_Second
  $A34A,$03 Point #REGde at the record of the second object at #R$97F2.
  $A34D,$01 Clear #REGa.
  $A34E,$01 Clear the sprite ID of the second object.
  $A34F,$03 Find the entries in the table of room objects for the room.
  $A352,$01 Move onto the second table entry for the room.
  $A353,$01 Fetch the second table entry for the room.
  $A354,$02 Return if there is no object in the second entry.

c $A356 Create Object
@ $A356 label=CreateObject
D $A356 Creates an object actor from an entry in the table of room objects (see
. #R$A2BD). The actor is set up as follows:
. #TABLE(default,centre,left)
. { =h Byte | =h Contents }
. { #N$00 | The sprite ID, which is #N$80 plus the type of the object (bits 0-3
. of the table entry) }
. { #N$01 | The room the player is in }
. { #N$03 | The X position }
. { #N$04 | The Y position }
. { #N$05 | The colour, see #R$A3A7 }
. { #N$06 | The address of the table entry, which #R$A323 clears when the
. object is collected }
. TABLE#
R $A356 A The table entry
R $A356 DE Address of the actor record
R $A356 HL Address of the table entry
R $A356 IX Actor record of the player
  $A356,$01 Stash the address of the table entry on the stack.
  $A357,$01 Stash the table entry in #REGc.
  $A358,$02,b$01 Keep only the object type (bits 0-3).
  $A35A,$02 Add #N$80 to get the sprite ID.
  $A35C,$01 Set the sprite ID of the object.
  $A35D,$01 Move onto the room of the object.
  $A35E,$03 Fetch the room of the player.
  $A361,$01 Set the room of the object.
  $A362,$02 Move onto the X position of the object.
N $A364 Find the positions for the layout of the room.
  $A364,$01 Use the room as the offset into the layout table.
  $A365,$02 Clear #REGh.
  $A367,$01 Stash the pointer to the actor record on the stack.
  $A368,$03 Point #REGde at the layout table at #R$6066.
  $A36B,$01 Add the layout table address to get the address of the layout number
. for the room.
  $A36C,$01 Fetch the layout number of the room.
  $A36D,$02 Clear #REGh.
  $A36F,$03 Multiply #REGhl by eight, as there are eight bytes of positions for
. each layout.
N $A372 Use bits 6-7 of the table entry to choose one of the four positions.
  $A372,$01 Fetch the table entry.
  $A373,$03 Rotate it left three times.
  $A376,$02,b$01 Keep only bits 1-2.
  $A378,$01 Stash the position offset in #REGe.
  $A379,$02 Clear #REGd.
  $A37B,$01 Add the position offset to the layout offset.
  $A37C,$03 Point #REGde at the table of object positions at #R$DC6C.
  $A37F,$01 Add the table address to get the address of the position.
  $A380,$01 Restore the pointer to the actor record from the stack.
  $A381,$01 Fetch the X position.
  $A382,$01 Move onto the Y position.
  $A383,$01 Set the X position of the object.
  $A384,$01 Move onto the Y position of the object.
  $A385,$01 Fetch the Y position.
  $A386,$01 Set the Y position of the object.
  $A387,$01 Move onto the colour of the object.
N $A388 Look up the colour for the type of the object.
  $A388,$01 Fetch the table entry.
  $A389,$02,b$01 Keep only bits 0-3.
  $A38B,$01 Stash the object type in #REGc.
  $A38C,$02 Clear #REGb.
  $A38E,$03 Point #REGhl at the table of object colours at #R$A3A7.
  $A391,$01 Add the object type to get the address of the colour.
  $A392,$01 Fetch the colour of the object.
  $A393,$01 Set the colour of the object.
  $A394,$01 Move onto the address of the table entry in the actor record.
  $A395,$01 Restore the address of the table entry from the stack.
  $A396,$01 Fetch the low byte of the address of the table entry.
  $A397,$01 Store it in the actor record.
  $A398,$01 Move onto the high byte.
  $A399,$01 Fetch the high byte of the address of the table entry.
  $A39A,$01 Store it in the actor record.
  $A39B,$01 Return.

c $A39C Find Room Objects
@ $A39C label=FindRoomObjects
D $A39C Finds the entries in the table of room objects which belong to the room
. an actor is in.
R $A39C IX Actor record
R $A39C O:HL Address of the first of the two table entries for the room
  $A39C,$03 Fetch the room of the actor.
  $A39F,$02 Clear #REGh.
  $A3A1,$01 Double the room, as there are two entries for each room.
  $A3A2,$03 Point #REGbc at the table of room objects at #R$DDEC.
  $A3A5,$01 Add the table address to get the address of the entries for the
. room.
  $A3A6,$01 Return.

b $A3A7 Object Colours
@ $A3A7 label=ObjectColours
D $A3A7 The attribute used for each type of object (bits 0-3 of the entry in
. the table of room objects, see #R$A356). The five colours are repeated for
. the sixteen types.
B $A3A7,$01 #COLOUR(#PEEK(#PC)).
L $A3A7,$01,$10

c $A3B7 Test Attack Overlap
@ $A3B7 label=TestAttackOverlap
D $A3B7 Tests whether the player is attacking with the sword (sprite IDs #N$20
. to #N$2F) and is touching an actor. The size of the area used for the test is
. set up here for #R$AB01, which does the work.
R $A3B7 IX Actor record
R $A3B7 O:F Carry flag set if the player is attacking and touching the actor
  $A3B7,$03 Fetch the sprite ID of the player from #R$9702.
  $A3BA,$02 Subtract #N$20 (the first attacking Sabreman sprite ID).
  $A3BC,$03 Return if the player is not attacking (the carry flag is reset).
  $A3BF,$03 Set how far above and to the right of the actor the player can be in
. #REGbc to #N$0C10.
  $A3C2,$03 Jump to #R$AB01 to test whether the player is touching the actor.

c $A3C5 Handler: Appearing Nastie
@ $A3C5 label=HandlerAppearingNastie
D $A3C5 Handles a nastie which is appearing (sprite IDs #N$01 to #N$05). Each
. time it is handled the sprite ID goes up by one, until it reaches #N$06 and
. #R$A3E0 turns it into a real nastie. If the player attacks it while it is
. appearing then it is blown up by #R$A4A6, and if it is in a different room to
. the player it is counted off by #R$A493.
R $A3C5 IX Nastie record
N $A3C5 Count off the nastie if it is not in the same room as the player.
  $A3C5,$03 Fetch the room of the player from #R$9703.
  $A3C8,$06 Jump to #R$A493 if the nastie is in a different room to the player.
  $A3CE,$03 Remember the previous position of the nastie.
N $A3D1 Blow up the nastie if the player is attacking it.
  $A3D1,$03 Test whether the player is attacking the nastie.
  $A3D4,$03 Jump to #R$A4A6 to blow up the nastie if the player is attacking it.
N $A3D7 Move the nastie on to the next sprite and make a sound, the pitch of
. which depends on the sprite ID.
  $A3D7,$03 Move the nastie on to the next appearing sprite.
  $A3DA,$03 Play the appearing sound.
  $A3DD,$03 Jump to #R$AD5D to display the nastie.

c $A3E0 Handler: Choose Nastie
@ $A3E0 label=HandlerChooseNastie
D $A3E0 Handles a nastie which has finished appearing (sprite ID #N$06) by
. choosing which type of nastie it is going to be. The types are held in
. #R$A41A. At the start of the game only the first eight types are possible,
. but each amulet piece which has been collected makes two more types possible.
R $A3E0 IX Nastie record
N $A3E0 Count off the nastie if it is not in the same room as the player.
  $A3E0,$03 Fetch the room of the player from #R$9703.
  $A3E3,$06 Jump to #R$A493 if the nastie is in a different room to the player.
  $A3E9,$03 Remember the previous position of the nastie.
N $A3EC Count the amulet pieces which have been collected.
  $A3EC,$03 Fetch the amulet pieces collected from #R$970D.
  $A3EF,$02 Clear the number of amulet pieces collected in #REGc.
  $A3F1,$02 Set the amulet piece counter in #REGb to #N$04.
@ $A3F3 label=HandlerChooseNastie_Loop
  $A3F3,$01 Rotate the flag for the next amulet piece into the carry flag.
  $A3F4,$02 Jump to #R$A3F7 if the amulet piece has not been collected.
  $A3F6,$01 Count the amulet piece.
@ $A3F7 label=HandlerChooseNastie_Next
  $A3F7,$02 Decrease the amulet piece counter by one and loop back to #R$A3F3
. until all four pieces have been checked.
N $A3F9 Work out how many types of nastie are possible: #N$08 plus twice the
. number of pieces collected.
  $A3F9,$02 Double the number of amulet pieces collected.
  $A3FB,$01 Copy it to #REGa.
  $A3FC,$02 Add #N$08.
  $A3FE,$01 Stash the number of nastie types possible in #REGc.
N $A3FF Choose a type at random, using the counter. If it is not one of the
. types which are possible then use only the first eight.
  $A3FF,$03 Fetch the low byte of the game timer from #R$9693.
  $A402,$02,b$01 Keep only bits 0-3.
  $A404,$03 Jump to #R$A409 if the type is possible.
  $A407,$02,b$01 Keep only bits 0-2.
@ $A409 label=HandlerChooseNastie_Type
  $A409,$01 Stash the type in #REGc.
  $A40A,$02 Clear #REGb.
  $A40C,$03 Point #REGhl at the table of nastie types at #R$A41A.
  $A40F,$01 Add the type to get the address of the sprite ID.
  $A410,$01 Fetch the sprite ID for the type.
  $A411,$03 Set the sprite ID of the nastie.
  $A414,$03 Choose a velocity for the nastie.
  $A417,$03 Jump to #R$AD5D to display the nastie.

b $A41A Nastie Types
@ $A41A label=SpriteReference
D $A41A The sprite ID for each type of nastie, which is chosen by #R$A3E0. The
. first eight are possible from the start of the game, and the others are only
. possible once enough amulet pieces have been collected.
  $A41A,$01 #LET(result=$BF84 + (#PEEK(#PC) * $02)) Sprite ID: #R(#PEEK({result}) + #PEEK({result} + $01) * $100)(#N(#PEEK(#PC))) #SPRITENAME(#PEEK(#PC))
L $A41A,$01,$10

c $A42A Handler: Dying Nastie
@ $A42A label=HandlerDyingNastie
D $A42A Handles a nastie which is being blown up (sprite IDs #N$08 to #N$0C).
. Each time it is handled the sprite ID goes up by one until it reaches #N$0D,
. when #R$A43B removes it.
R $A42A IX Nastie record
  $A42A,$03 Fetch the room of the player from #R$9703.
  $A42D,$05 Jump to #R$A446 if the nastie is in a different room to the player.
  $A432,$03 Remember the previous position of the nastie.
  $A435,$03 Move the nastie on to the next dying sprite.
  $A438,$03 Jump to #R$AD5D to display the nastie.

c $A43B Handler: Remove Nastie
@ $A43B label=HandlerRemoveNastie
D $A43B Handles a nastie which has finished being blown up (sprite ID #N$0D).
. The nastie is erased if it is in the same room as the player and the actor
. record is then emptied.
R $A43B IX Nastie record
  $A43B,$03 Fetch the room of the player from #R$9703.
  $A43E,$05 Jump to #R$A446 if the nastie is in a different room to the player.
  $A443,$03 Erase the nastie from the screen.
@ $A446 label=RemoveExplosion
  $A446,$04 Empty the record by setting the sprite ID to #N$00.
  $A44A,$01 Return.

c $A44B Calculate New Position
@ $A44B label=CalculateNewPosition
D $A44B Works out where an actor will be after it has moved by its velocities
. (see #REGix+#N$06 and #REGix+#N$07), keeping it on the screen. The velocities
. are in sixteenths of a pixel.
. .
. The X position is kept between #N$00 and #N($0100,$04,$04) minus the width
. (held in #R$96AD) and the Y position between #N$27 and #N$BF.
R $A44B IX Actor record
R $A44B O:B Bit 0 is set if the actor hit the left or right of the screen, bit
. 1 is set if it hit the top or bottom
R $A44B O:D The new Y position
R $A44B O:E The new X position
  $A44B,$02 Clear the edge flags in #REGb.
  $A44D,$03 Fetch the width of the actor from #R$96AD.
  $A450,$01 Stash the width in #REGc.
N $A451 Work out the new X position.
  $A451,$03 Fetch the X velocity of the actor.
  $A454,$03 Convert the X velocity to pixels.
  $A457,$03 Jump to #R$A47D if the actor is moving left.
  $A45A,$03 Add the X position of the actor.
  $A45D,$01 Stash the new X position in #REGe.
  $A45E,$01 Add the width of the actor.
  $A45F,$02 Jump to #R$A476 if the actor would go off the right edge of the
. screen.
N $A461 Work out the new Y position.
@ $A461 label=CalculateNewPosition_Y
  $A461,$03 Fetch the Y velocity of the actor.
  $A464,$03 Convert the Y velocity to pixels.
  $A467,$03 Jump to #R$A488 if the actor is moving up.
  $A46A,$03 Add the Y position of the actor.
  $A46D,$01 Stash the new Y position in #REGd.
  $A46E,$03 Return if the actor is not off the bottom of the screen (#N$BF).
  $A471,$02 Limit the Y position to the bottom of the screen (#N$BF).
@ $A473 label=CalculateNewPosition_HitY
  $A473,$02 Set the top or bottom edge flag (bit 1).
  $A475,$01 Return.
N $A476 The actor hit the right of the screen.
@ $A476 label=CalculateNewPosition_HitRight
  $A476,$01 Fetch the width of the actor.
  $A477,$02 Negate it to give the X position which puts the actor against the
. right of the screen.
  $A479,$01 Stash it in #REGe as the new X position.
  $A47A,$02 Set the left or right edge flag (bit 0).
  $A47C,$01 Return.
N $A47D The actor is moving left.
@ $A47D label=CalculateNewPosition_Left
  $A47D,$03 Add the X position of the actor.
  $A480,$01 Stash the new X position in #REGe.
  $A481,$02 Jump to #R$A461 if the actor is still on the screen.
  $A483,$02 Limit the X position to the left edge of the screen (#N$00).
  $A485,$02 Set the left or right edge flag (bit 0).
  $A487,$01 Return.
N $A488 The actor is moving up.
@ $A488 label=CalculateNewPosition_Up
  $A488,$03 Add the Y position of the actor.
  $A48B,$01 Stash the new Y position in #REGd.
  $A48C,$03 Return if the actor is not off the top of the screen
. (the Y position is #N$27 or more).
  $A48F,$02 Limit the Y position to the top of the screen (#N$27).
  $A491,$02 Jump to #R$A473 to set the top or bottom edge flag.

c $A493 Expire Actor
@ $A493 label=ExpireActor
D $A493 Counts off an actor which is in a different room to the player. Once it
. has been counted off #N$40 times it is removed.
R $A493 IX Actor record
  $A493,$03 Increase the time the actor has spent in another room by one.
  $A496,$03 Fetch the time the actor has spent in another room.
  $A499,$03 Return if the actor has spent less than #N$40 in another room.
  $A49C,$04 Empty the record by setting the sprite ID to #N$00.
  $A4A0,$01 Return.

c $A4A1 Blow Up Flame
@ $A4A1 label=BlowUpFlame
D $A4A1 Blows up a flame which has burnt for its full time. This sets a delay of
. #N$10 in #R$96B4 before another flame can be started and then blows up the
. actor.
R $A4A1 IX Flame record
  $A4A1,$05 Set the flame spawn delay in #R$96B4 to #N$10.

c $A4A6 Blow Up Actor
@ $A4A6 label=BlowUpActor
D $A4A6 Plays an explosion noise, awards points for the actor and starts the
. actor on the sprites for blowing up (sprite IDs #N$08 to #N$0D, which are
. handled by #R$A42A and #R$A43B).
R $A4A6 IX Actor record
  $A4A6,$03 Play the explosion sound.
  $A4A9,$03 Award points for the actor.
  $A4AC,$04 Set the sprite ID of the actor to #N$08 (#SPRITENAME$08).
  $A4B0,$03 Jump to #R$AD5D to display the actor.

c $A4B3 Award Actor Points
@ $A4B3 label=AwardActorPoints
D $A4B3 Adds points to the score for blowing up an actor. The points are 100
. plus a value of #N$65, #N$75, #N$85 or #N$95 depending on bits 1-2 of the
. sprite ID, so they are 165, 175, 185 or 195.
R $A4B3 IX Actor record
  $A4B3,$03 Fetch the sprite ID of the actor.
  $A4B6,$03 Rotate the sprite ID left three times.
  $A4B9,$02,b$01 Keep only the type of the actor (bits 4-5).
  $A4BB,$02 Add #N$65.
  $A4BD,$01 Stash the low byte of the points in #REGc.
  $A4BE,$02 Set the high byte of the points in #REGb to #N$01.
  $A4C0,$03 Jump to #R$B5A9 to add the points to the score.

c $A4C3 Face Direction
@ $A4C3 label=FaceDirection
D $A4C3 Updates the sprite ID of an actor so that it faces the way it is moving
. and flips its animation frame. Bit 1 of the sprite ID is set when the X
. velocity is positive, and bit 0 of the sprite ID is flipped.
R $A4C3 IX Actor record
  $A4C3,$03 Fetch the X velocity of the actor.
  $A4C6,$02 Rotate the X velocity left twice, so that the direction is in bit 1.
  $A4C8,$02,b$01 Keep only the direction bit (bit 1).
  $A4CA,$01 Stash the direction bit in #REGc.
  $A4CB,$03 Fetch the sprite ID of the actor.
  $A4CE,$02,b$01 Keep only bits 0 and 2-7.
  $A4D0,$01 Merge in the direction bit.
  $A4D1,$02,b$01 Flip bits 0 and 1.
  $A4D3,$03 Set the new sprite ID of the actor.
  $A4D6,$01 Return.

c $A4D7 Handler: Chasing Nastie
@ $A4D7 label=HandlerChasingNastie
D $A4D7 Handles the nastie types which chase the player: the bat (sprite IDs
. #N$68 to #N$6B), the lizard (#N$74 to #N$77) and the snake (#N$78 to #N$7B).
. Every time they are handled the velocity of the nastie is changed by #N$08
. towards the position of the player, up to a maximum of #N$30 in each
. direction (see #R$AFD0).
. .
. The nastie bounces off the edges of the screen, is stopped by objects in the
. room, and is blown up (by #R$A4A6) if it touches the player or if the
. player is not alive.
R $A4D7 IX Nastie record
N $A4D7 Count off the nastie if it is not in the same room as the player.
  $A4D7,$03 Fetch the room of the player from #R$9703.
  $A4DA,$05 Jump to #R$A493 if the nastie is in a different room to the player.
  $A4DF,$05 Set the width of the nastie in #R$96AD to #N$17.
  $A4E4,$03 Remember the previous position of the nastie.
N $A4E7 Blow up the nastie if the player is not alive.
  $A4E7,$03 Fetch the sprite ID of the player from #R$9702.
  $A4EA,$02 Subtract #N$10 (the first Sabreman sprite ID).
  $A4EC,$04 Jump to #R$A4A6 to blow up the nastie if the player is not alive.
  $A4F0,$03 Set the maximum velocity in #REGb to #N$30 and the amount to change
. the velocity by in #REGc to #N$08.
N $A4F3 Change the X velocity towards the player.
  $A4F3,$03 Fetch the X position of the player from #R$9705.
  $A4F6,$03 Subtract the X position of the nastie.
  $A4F9,$02 Jump to #R$A506 if the positions are the same, with a velocity of
. zero.
  $A4FB,$01 Fetch the amount to change the velocity by.
  $A4FC,$02 Jump to #R$A500 if the player is to the right of the nastie.
  $A4FE,$02 Negate the amount to change the velocity by.
@ $A500 label=HandlerChasingNastie_AddX
  $A500,$03 Add the X velocity of the nastie.
  $A503,$03 Limit the X velocity.
@ $A506 label=HandlerChasingNastie_StoreX
  $A506,$03 Set the X velocity of the nastie.
N $A509 Change the Y velocity towards the player.
  $A509,$03 Fetch the Y position of the player from #R$9706.
  $A50C,$03 Compare with the Y position of the nastie.
  $A50F,$02 Jump to #R$A51C if the positions are the same (#REGa still holds the
. Y position of the player at this point, and this is what is used as the Y
. velocity).
  $A511,$01 Fetch the amount to change the velocity by.
  $A512,$02 Jump to #R$A516 if the player is below the nastie.
  $A514,$02 Negate the amount to change the velocity by.
@ $A516 label=HandlerChasingNastie_AddY
  $A516,$03 Add the Y velocity of the nastie.
  $A519,$03 Limit the Y velocity.
@ $A51C label=HandlerChasingNastie_StoreY
  $A51C,$03 Set the Y velocity of the nastie.
N $A51F Move the nastie, bouncing it off the edges of the screen.
  $A51F,$03 Make the nastie face the way it is moving.
  $A522,$03 Work out the new position of the nastie.
  $A525,$04 Jump to #R$A545 if the nastie has hit the left or right edge of the
. screen.
  $A529,$04 Jump to #R$A54A if the nastie has hit the top or bottom edge of the
. screen.
N $A52D Stop the nastie moving through objects in the room.
@ $A52D label=HandlerChasingNastie_Move
  $A52D,$03 Set the height and width of the nastie in #REGb and #REGc to #N$17.
  $A530,$03 Stop the nastie passing through objects in the room.
  $A533,$03 Set the X position of the nastie.
  $A536,$03 Set the Y position of the nastie.
N $A539 Blow up the nastie if it touches the player, otherwise draw it.
  $A539,$03 Set the reach used to test whether the nastie is touching the player
. in #REGbc to #N$1313.
  $A53C,$03 Test whether the nastie is touching the player.
  $A53F,$03 Jump to #R$AD5D to display the nastie if it is not touching the
. player.
  $A542,$03 Jump to #R$A4A6 to blow up the nastie.

c $A545 Bounce Nastie Horizontally
@ $A545 label=BounceNastieHorizontally
D $A545 Reverses the X velocity of a chasing nastie which has hit the left or
. right of the screen.
R $A545 IX Nastie record
  $A545,$03 Reverse the X velocity of the nastie.
  $A548,$02 Jump to #R$A52D.

c $A54A Bounce Nastie Vertically
@ $A54A label=BounceNastieVertically
D $A54A Reverses the Y velocity of a chasing nastie which has hit the top or
. bottom of the screen.
R $A54A IX Nastie record
  $A54A,$03 Reverse the Y velocity of the nastie.
  $A54D,$02 Jump to #R$A52D.

c $A54F Handler: Wandering Nastie
@ $A54F label=HandlerWanderingNastie
D $A54F Handles the nastie types which wander about: the spider (sprite IDs
. #N$60 to #N$63), scorpion (#N$64 to #N$67), parrot (#N$6C to #N$6F), monkey
. (#N$70 to #N$73) and all of the nastie types which are only possible later
. in the game (#N$98 to #N$9F and #N$B0 to #N$C3).
. .
. The nastie moves with a velocity chosen by #R$A5CD, which also makes it pause
. for a while. It chooses a new velocity when the timer in #REGix+#N$02 runs
. out or when it is blocked. It bounces off the edges of the screen, is stopped
. by objects in the room, and is blown up (by #R$A4A6) if it touches the player
. or if the player is not alive.
R $A54F IX Nastie record
N $A54F Count off the nastie if it is not in the same room as the player.
  $A54F,$03 Fetch the room of the player from #R$9703.
  $A552,$06 Jump to #R$A493 if the nastie is in a different room to the player.
  $A558,$05 Set the width of the nastie in #R$96AD to #N$17.
  $A55D,$03 Remember the previous position of the nastie.
N $A560 Blow up the nastie if the player is not alive.
  $A560,$03 Fetch the sprite ID of the player from #R$9702.
  $A563,$02 Subtract #N$10 (the first Sabreman sprite ID).
  $A565,$05 Jump to #R$A4A6 to blow up the nastie if the player is not alive.
N $A56A Choose a new velocity when the timer has run out.
  $A56A,$06 Decrease the velocity timer by one and choose a new velocity if it
. has run out.
N $A570 Skip the move if the nastie is not moving.
  $A570,$03 Fetch the X velocity of the nastie.
  $A573,$03 Combine it with the Y velocity.
  $A576,$02 Jump to #R$A59D if the nastie is not moving.
N $A578 Move the nastie, bouncing it off the edges of the screen.
  $A578,$03 Work out the new position of the nastie.
  $A57B,$04 Jump to #R$A5C3 if the nastie has hit the left or right edge of the
. screen.
  $A57F,$04 Jump to #R$A5C8 if the nastie has hit the top or bottom edge of the
. screen.
N $A583 Stop the nastie moving through objects in the room. If it did not
. manage to move then choose a new velocity.
@ $A583 label=HandlerWanderingNastie_Move
  $A583,$03 Set the height and width of the nastie in #REGb and #REGc to #N$17.
  $A586,$03 Stop the nastie passing through objects in the room.
  $A589,$03 Test whether the nastie has stayed where it was.
  $A58C,$03 Choose a new velocity if the nastie has stayed where it was.
N $A58F Flip the animation frame and store the new position.
  $A58F,$03 Fetch the sprite ID of the nastie.
  $A592,$02,b$01 Flip bit 0.
  $A594,$03 Set the new sprite ID of the nastie.
  $A597,$03 Set the X position of the nastie.
  $A59A,$03 Set the Y position of the nastie.
N $A59D Blow up the nastie if it touches the player, otherwise draw it.
@ $A59D label=HandlerWanderingNastie_Touch
  $A59D,$03 Set the reach used to test whether the nastie is touching the player
. in #REGbc to #N$1313.
  $A5A0,$03 Test whether the nastie is touching the player.
  $A5A3,$03 Jump to #R$AD5D to display the nastie if it is not touching the
. player.
  $A5A6,$03 Jump to #R$A4A6 to blow up the nastie.

c $A5A9 Reverse X Velocity
@ $A5A9 label=ReverseXVelocity
D $A5A9 Reverses the X velocity of an actor and flips bit 1 of its sprite ID,
. so that it faces the other way.
R $A5A9 IX Actor record
  $A5A9,$03 Fetch the X velocity of the actor.
  $A5AC,$02 Reverse the X velocity.
  $A5AE,$03 Set the new X velocity of the actor.
  $A5B1,$03 Fetch the sprite ID of the actor.
  $A5B4,$02,b$01 Flip bit 1 (the direction the actor is facing).
  $A5B6,$03 Set the new sprite ID of the actor.
  $A5B9,$01 Return.

c $A5BA Reverse Y Velocity
@ $A5BA label=ReverseYVelocity
D $A5BA Reverses the Y velocity of an actor.
R $A5BA IX Actor record
  $A5BA,$03 Fetch the Y velocity of the actor.
  $A5BD,$02 Reverse the Y velocity.
  $A5BF,$03 Set the new Y velocity of the actor.
  $A5C2,$01 Return.

c $A5C3 Bounce Wandering Nastie Horizontally
@ $A5C3 label=BounceWanderingNastieHorizontally
D $A5C3 Reverses the X velocity of a wandering nastie which has hit the left
. or right of the screen.
R $A5C3 IX Nastie record
  $A5C3,$03 Reverse the X velocity of the nastie.
  $A5C6,$02 Jump to #R$A583.

c $A5C8 Bounce Wandering Nastie Vertically
@ $A5C8 label=BounceWanderingNastieVertically
D $A5C8 Reverses the Y velocity of a wandering nastie which has hit the top or
. bottom of the screen.
R $A5C8 IX Nastie record
  $A5C8,$03 Reverse the Y velocity of the nastie.
  $A5CB,$02 Jump to #R$A583.

c $A5CD Choose Velocity
@ $A5CD label=ChooseVelocity
D $A5CD Chooses the velocity for a wandering actor. If it is moving then it is
. stopped (by #R$A609). If it has stopped then it is given a random X velocity
. and a random Y velocity from #R$A601, and the sprite is made to face the way
. it is going.
R $A5CD IX Actor record
  $A5CD,$03 Fetch the X velocity of the actor.
  $A5D0,$03 Combine it with the Y velocity.
  $A5D3,$02 Jump to #R$A609 to stop the actor if it is moving.
N $A5D5 Choose the X velocity.
  $A5D5,$03 Fetch the random seed from #R$9695.
  $A5D8,$02,b$01 Keep only bits 0-2.
  $A5DA,$01 Stash the velocity index in #REGl.
  $A5DB,$02 Clear #REGh.
  $A5DD,$03 Point #REGbc at the table of velocities at #R$A601.
  $A5E0,$01 Add the table address to get the address of the velocity.
  $A5E1,$01 Fetch the velocity from the table.
  $A5E2,$03 Set the X velocity of the actor.
  $A5E5,$04 Jump to #R$A5FB if the actor is moving right.
  $A5E9,$04 Reset bit 1 of the sprite ID so that the actor faces left.
N $A5ED Choose the Y velocity.
@ $A5ED label=ChooseVelocity_Y
  $A5ED,$03 Fetch the low byte of #SKOOLKID$5C78(FRAMES).
  $A5F0,$02,b$01 Keep only bits 0-2.
  $A5F2,$01 Stash the velocity index in #REGl.
  $A5F3,$02 Clear #REGh.
  $A5F5,$01 Add the table address to get the address of the velocity.
  $A5F6,$01 Fetch the velocity from the table.
  $A5F7,$03 Set the Y velocity of the actor.
  $A5FA,$01 Return.
N $A5FB The actor is moving to the right.
@ $A5FB label=ChooseVelocity_Right
  $A5FB,$04 Set bit 1 of the sprite ID so that the actor faces right.
  $A5FF,$02 Jump to #R$A5ED to choose the Y velocity.

b $A601 Velocity Table
@ $A601 label=VelocityTable
D $A601 The velocities which can be chosen by #R$A5CD, in sixteenths of a
. pixel. Four of them are negative (up or left) and four are positive (down or
. right).
  $A601,$04,$01 Negative velocities.
  $A605,$04,$01 Positive velocities.

c $A609 Stop Actor
@ $A609 label=StopActor
D $A609 Stops an actor moving and sets its timer to a random value between #N$08
. and #N$0F, which is how long it stays still for.
R $A609 IX Actor record
  $A609,$07 Stop the actor by clearing its X and Y velocities.
  $A610,$03 Fetch the random seed from #R$9695.
  $A613,$02,b$01 Keep only bits 0-2.
  $A615,$02,b$01 Set bit 3.
  $A617,$03 Set the velocity timer of the actor.
  $A61A,$01 Return.

c $A61B Handler: Stand Up (After Yellow Orchid)
@ $A61B label=HandlerYellowOrchid_StandUp
D $A61B Handles the player while they are lying down after touching a yellow
. orchid (sprite IDs #N$43 and #N$47, see #R$AE8F). Once the orchid effect
. timer in #R$96B0 has run out the player is turned back into a walking
. Sabreman (sprite IDs #N$10 to #N$17).
R $A61B IX Actor record of the player
  $A61B,$03 Remember the previous position of the player.
@ $A61E label=HandlerYellowOrchid_StandUp_CountDown
  $A61E,$03 Count down the orchid effect.
  $A621,$02 Jump to #R$A62D if the orchid effect has not yet run out.
  $A623,$03 Fetch the sprite ID of the player.
  $A626,$02,b$01 Keep only bits 0-2.
  $A628,$02,b$01 Set bit 4, giving a Sabreman sprite ID of #N$10 to #N$17.
  $A62A,$03 Set the new sprite ID of the player.
@ $A62D label=HandlerYellowOrchid_StandUp_Skip
  $A62D,$03 Jump to #R$AF7A.

c $A630 Bring Actor Closer
@ $A630 label=BringActorCloser
D $A630 Moves an actor which is two or more rows of rooms away from the player
. to a room in the row above or below the player (never the player's own room),
. placing it at the position in #R$D6A6 for the layout of the new room. Half
. of the time it is moved to the row above, and half of the time to the row
. below.
R $A630 IX Actor record
  $A630,$03 Fetch the room of the player from #R$9703.
  $A633,$03 Compare with the room of the actor.
  $A636,$01 Return if the actor is in the same room as the player.
  $A637,$01 Stash the room of the player in #REGb.
N $A638 Work out how many rows of rooms are between the player and the actor.
  $A638,$04 Rotate the room of the player right four times.
  $A63C,$02,b$01 Keep only bits 0-3.
  $A63E,$01 Stash the row of the player in #REGc.
  $A63F,$03 Fetch the room of the actor.
  $A642,$04 Rotate the room of the actor right four times.
  $A646,$02,b$01 Keep only bits 0-3.
  $A648,$01 Subtract the row of the player to get the number of rows between
. them.
  $A649,$03 Jump to #R$A64E if the number of rows is positive.
  $A64C,$02 Make the number of rows positive.
@ $A64E label=BringActorCloser_Distance
  $A64E,$02 Compare with #N$02.
  $A650,$01 Return if the actor is less than two rows away.
N $A651 Choose the row above or below the player at random.
  $A651,$03 Fetch the random seed from #R$9695.
  $A654,$02,b$01 Keep only bit 0.
  $A656,$02 Jump to #R$A678 to use the row below the player if bit 0 is set.
  $A658,$01 Fetch the room of the player.
  $A659,$02 Subtract #N$10 to get the room above.
@ $A65B label=BringActorCloser_CheckRoom
  $A65B,$02 Jump to #R$A67D if there is no room above.
@ $A65D label=BringActorCloser_Room
  $A65D,$02,b$01 Keep only bits 2-7 (the row, and the column in groups of four).
  $A65F,$01 Stash the result in #REGc.
  $A660,$03 Fetch the room of the actor.
  $A663,$02,b$01 Keep only bits 0-1.
  $A665,$01 Merge in the new room.
  $A666,$01 Compare with the room of the player.
  $A667,$01 Return if the new room is the room of the player.
N $A668 Put the actor in the new room.
  $A668,$03 Set the new room of the actor.
  $A66B,$03 Find the position of the actor in the new room.
  $A66E,$01 Fetch the X position from the table.
  $A66F,$03 Set the X position of the actor.
  $A672,$01 Move onto the Y position.
  $A673,$01 Fetch the Y position from the table.
  $A674,$03 Set the Y position of the actor.
  $A677,$01 Return.

c $A678 Choose Room Below
@ $A678 label=ChooseRoomBelow
D $A678 Chooses the room below the player for #R$A630.
R $A678 B Room of the player
  $A678,$01 Fetch the room of the player.
  $A679,$02 Add #N$10 to get the room below.
  $A67B,$02 Jump to #R$A65B.

c $A67D Choose Player Room
@ $A67D label=ChoosePlayerRoom
D $A67D Used by #R$A630 when there is no room above or below the player, so
. the room of the player is used instead.
R $A67D B Room of the player
  $A67D,$01 Fetch the room of the player.
  $A67E,$02 Jump to #R$A65D.

c $A680 Handler: Orchid
@ $A680 label=HandlerOrchid
D $A680 Handles an orchid (sprite IDs #N$48 to #N$4F). An orchid goes through a
. cycle of growing, staying in bloom for a short time, shrinking and then
. staying hidden for a while. The lowest three bits of the sprite ID are the
. stage of growth and a timer in #REGix+#N$06 and #REGix+#N$07 counts down how
. long it is before the next change (see #R$A6D4). The timer only counts down
. while the player is alive and the game delay timer in #R$96B5 is zero.
. .
. Once the orchid has finished growing it can be touched by the player (see
. #R$A737). The stem of the orchid is coloured bright green and the flower is
. coloured with the colour of the orchid.
R $A680 IX Actor record of the orchid
  $A680,$03 Remember the previous position of the orchid.
  $A683,$06 Fetch the timer of the orchid.
  $A689,$04 Jump to #R$A6D4 to change the stage of the orchid if the timer is
. zero.
N $A68D Count down the timer if the player is alive and the game delay is over.
  $A68D,$03 Fetch the sprite ID of the player from #R$9702.
  $A690,$02 Subtract #N$10 (the first Sabreman sprite ID).
  $A692,$04 Jump to #R$A69D if the player is not alive.
  $A696,$03 Fetch the start-of-turn delay from #R$96B5.
  $A699,$01 Set the flags.
  $A69A,$02 Jump to #R$A69D if the start-of-turn delay is still running.
  $A69C,$01 Decrease the timer by one.
@ $A69D label=HandlerOrchid_StoreTimer
  $A69D,$06 Store the timer of the orchid.
  $A6A3,$03 Test whether the player is touching the orchid.
@ $A6A6 label=HandlerOrchid_Draw
  $A6A6,$03 Display the orchid.
N $A6A9 Colour the stem of the orchid.
  $A6A9,$06 Fetch the X and Y position of the orchid.
  $A6AF,$03 Find the attribute address of the orchid.
  $A6B2,$02 Set the number of rows in #REGc to #N$01.
  $A6B4,$02 Set the colour in #REGd to #N$44 (bright green).
  $A6B6,$02 Set the number of columns in #REGb to #N$02.
  $A6B8,$03 Colour the stem of the orchid.
N $A6BB Colour the flower if the orchid has started to grow.
  $A6BB,$03 Fetch the sprite ID of the orchid.
  $A6BE,$02,b$01 Keep only the stage of growth (bits 0-2).
  $A6C0,$01 Return if the orchid is hidden.
  $A6C1,$02 Set the number of rows in #REGc to #N$01.
  $A6C3,$03 Fetch the colour of the orchid into #REGd.
  $A6C6,$02 Set the number of columns in #REGb to #N$02.
N $A6C8 The orchid is one column wider when it is not fully grown.
@ $A6C8 label=HandlerOrchid_Colour
  $A6C8,$03 Fetch the sprite ID of the orchid.
  $A6CB,$01 Flip the bits, so that a fully grown orchid gives zero.
  $A6CC,$02,b$01 Keep only bits 0-2.
  $A6CE,$02 Jump to #R$A6D1 if the orchid is not fully grown.
  $A6D0,$01 Add one to the number of columns.
@ $A6D1 label=HandlerOrchid_ColourRows
  $A6D1,$03 Jump to #R$BB45 to colour the rows.

c $A6D4 Change Orchid Stage
@ $A6D4 label=ChangeOrchidStage
D $A6D4 Called when the timer of an orchid has run out. Every other frame the
. growth stage of the orchid (the lowest three bits of the sprite ID) is moved
. on by one. Whether it grows or shrinks depends on bit 3 of #REGix+#N$02.
. When it has finished growing the timer is set to #N$10, and when it has
. finished shrinking a new colour is chosen and the timer is set to a random
. value between #N$80 and #N$BF.
R $A6D4 IX Actor record of the orchid
  $A6D4,$03 Fetch the low byte of the game timer from #R$9693.
  $A6D7,$02,b$01 Keep only bit 0.
  $A6D9,$02 Jump to #R$A6A6 to just display the orchid if bit 0 is set.
  $A6DB,$03 Fetch the direction of growth of the orchid.
  $A6DE,$01 Set the flags.
  $A6DF,$02 Jump to #R$A70D if the orchid is growing.
N $A6E1 The orchid is shrinking.
  $A6E1,$03 Move the orchid back to the previous stage of growth.
  $A6E4,$03 Fetch the sprite ID of the orchid.
  $A6E7,$02,b$01 Keep only bits 0-2.
  $A6E9,$02 Jump to #R$A6A6 if the orchid has not finished shrinking.
N $A6EB The orchid has gone, so choose a new colour for the next time.
  $A6EB,$03 Fetch the low byte of #SKOOLKID$5C78(FRAMES).
  $A6EE,$02,b$01 Keep only bits 0-3.
  $A6F0,$01 Stash the colour index in #REGl.
  $A6F1,$02 Clear #REGh.
  $A6F3,$03 Point #REGbc at the table of orchid colours at #R$A6FD.
  $A6F6,$01 Add the table address to get the address of the colour.
  $A6F7,$01 Fetch the colour from the table.
  $A6F8,$03 Set the colour of the orchid.
  $A6FB,$02 Jump to #R$A71A to swap the direction of growth.

b $A6FD Orchid Colours
@ $A6FD label=OrchidColour
D $A6FD The colours which an orchid can have, chosen at random by #R$A6D4. The
. colours are bright red, magenta, cyan, yellow and white. White (#N$47) is
. more likely than the others.
B $A6FD,$01 #COLOUR(#PEEK(#PC)).
L $A6FD,$01,$10

c $A70D Grow Orchid
@ $A70D label=GrowOrchid
D $A70D Moves a growing orchid on to the next stage. When it is fully grown
. (the lowest three bits of the sprite ID are all set) the direction of
. growth is changed (see #R$A71A). Otherwise the orchid is just drawn.
R $A70D IX Actor record of the orchid
  $A70D,$03 Move the orchid on to the next stage of growth.
  $A710,$03 Fetch the sprite ID of the orchid.
  $A713,$01 Flip the bits, so that a fully grown orchid gives zero.
  $A714,$02,b$01 Keep only bits 0-2.
  $A716,$02 Jump to #R$A71A if the orchid is fully grown.
  $A718,$02 Jump to #R$A6A6 to display the orchid.
N $A71A Swap between growing and shrinking and set the timer.
@ $A71A label=GrowOrchid_Swap
  $A71A,$03 Fetch the direction of growth of the orchid.
  $A71D,$02,b$01 Flip bit 3 to swap between growing and shrinking.
  $A71F,$03 Set the new direction of growth of the orchid.
  $A722,$02 Jump to #R$A731 if the orchid is now shrinking.
N $A724 The orchid has finished shrinking, so it stays hidden for #N$80 to #N$BF
. frames.
  $A724,$03 Fetch the low byte of #SKOOLKID$5C78(FRAMES).
  $A727,$02,b$01 Keep only bits 0-5.
  $A729,$02 Add #N$80.
  $A72B,$01 Stash the hidden time in #REGl.
  $A72C,$02 Clear #REGh.
  $A72E,$03 Jump to #R$A69D to store the hidden time as the timer.
N $A731 The orchid has finished growing, so it stays in bloom for #N$10 frames.
@ $A731 label=GrowOrchid_Bloom
  $A731,$03 Set the time the orchid stays in bloom in #REGhl to #N$0010.
  $A734,$03 Jump to #R$A69D to store the bloom time as the timer.

c $A737 Test Orchid Touched
@ $A737 label=TestOrchidTouched
D $A737 Tests whether the player is touching an orchid which is fully grown.
. If so then the orchid shrinks away (its timer is zeroed), the effect timer in
. #R$96B0 is started and the player takes on the colour of the orchid. If the
. orchid is white (#N$47) then the effect timer is reset instead, which
. removes any effect. A low tone is played.
R $A737 IX Actor record of the orchid
  $A737,$03 Fetch the sprite ID of the orchid.
  $A73A,$01 Flip the bits, so that a fully grown orchid gives zero.
  $A73B,$02,b$01 Keep only bits 0-2.
  $A73D,$01 Return if the orchid is not fully grown.
  $A73E,$03 Set the reach used to test whether the player is touching the orchid
. in #REGbc to #N$0F0F.
  $A741,$03 Test whether the player is touching the orchid.
  $A744,$01 Return if the player is not touching the orchid.
  $A745,$05 Set the orchid effect timer in #R$96B0 to #N$C0.
  $A74A,$01 Clear #REGa.
  $A74B,$03 Clear the low byte of the timer of the orchid.
  $A74E,$03 Clear the high byte of the timer of the orchid.
  $A751,$03 Fetch the colour of the orchid.
  $A754,$03 Set the colour of the player to the colour of the orchid.
  $A757,$05 Jump to #R$BF2A to play the low tone if the orchid is not white.
  $A75C,$04 Clear the orchid effect timer in #R$96B0, as a white orchid has no
. effect.
  $A760,$03 Jump to #R$BF2A to play the low tone.

c $A763 Load Orchid
@ $A763 label=LoadOrchid
D $A763 Sets up the orchid for the room the player is in, using the state of the
. orchid held in #R$A7F8 and its position in #R$D6A6. The record is built in
. #R$97DA. This is the opposite of #R$A79F.
R $A763 IX Actor record of the player
  $A763,$03 Fetch the room of the player.
  $A766,$03 Find the state of the orchid for the room.
  $A769,$03 Point #REGde at the orchid's actor record at #R$97DA.
  $A76C,$03 Fetch the state of the orchid from the table into #REGc and #REGb.
  $A76F,$01 Copy the first byte of the state to #REGa.
  $A770,$02,b$01 Keep only the stage of growth (bits 0-2).
  $A772,$02,b$01 Set bits 3 and 6, giving a sprite ID of #N$48 to #N$4F.
  $A774,$01 Set the sprite ID of the orchid.
  $A775,$01 Move onto the room of the orchid.
  $A776,$03 Fetch the room of the player.
  $A779,$01 Set the room of the orchid.
  $A77A,$01 Move onto the direction of growth of the orchid.
  $A77B,$01 Copy the first byte of the state to #REGa.
  $A77C,$02,b$01 Keep only the direction of growth (bit 3).
  $A77E,$01 Set the direction of growth of the orchid.
  $A77F,$01 Move onto the X position of the orchid.
  $A780,$03 Find the position of the orchid for the room.
  $A783,$01 Fetch the X position of the orchid.
  $A784,$01 Move onto the Y position.
  $A785,$01 Set the X position of the orchid.
  $A786,$01 Move onto the Y position of the orchid.
  $A787,$01 Fetch the Y position of the orchid.
  $A788,$01 Set the Y position of the orchid.
  $A789,$01 Move onto the colour of the orchid.
  $A78A,$01 Copy the second byte of the state to #REGa.
  $A78B,$02,b$01 Keep only the colour (bits 0-2).
  $A78D,$02,b$01 Set bit 6 (bright).
  $A78F,$01 Set the colour of the orchid.
  $A790,$01 Move onto the timer of the orchid.
  $A791,$01 Copy the second byte of the state to #REGa.
  $A792,$02,b$01 Keep only the low bits of the timer (bits 3-7).
  $A794,$01 Set the low byte of the timer of the orchid.
  $A795,$01 Move onto the high byte of the timer.
  $A796,$01 Copy the first byte of the state to #REGa.
  $A797,$04 Rotate the first byte of the state right four times.
  $A79B,$02,b$01 Keep only the high bits of the timer (bits 0-3).
  $A79D,$01 Set the high byte of the timer of the orchid.
  $A79E,$01 Return.

c $A79F Save Orchid
@ $A79F label=SaveOrchid
D $A79F Stores the state of the orchid in #R$97DA back into the table in
. #R$A7F8, for the room which it was in (held in #R$96AB), so that it is as it
. was left when the player returns to the room. This is the opposite of
. #R$A763.
  $A79F,$03 Fetch the room of the orchid from #R$96AB.
  $A7A2,$03 Find the state of the orchid for the room.
  $A7A5,$02 Stash the actor pointer on the stack.
  $A7A7,$04 Point #REGix at the orchid's actor record at #R$97DA.
  $A7AB,$03 Fetch the sprite ID of the orchid.
  $A7AE,$02,b$01 Keep only the stage of growth (bits 0-2).
  $A7B0,$01 Stash the stage of growth in #REGc.
  $A7B1,$03 Fetch the direction of growth of the orchid.
  $A7B4,$02,b$01 Keep only the direction of growth (bit 3).
  $A7B6,$01 Merge in the stage of growth.
  $A7B7,$01 Stash the stage and direction of growth in #REGc.
  $A7B8,$03 Fetch the high byte of the timer of the orchid.
  $A7BB,$04 Rotate the high byte of the timer left four times.
  $A7BF,$02,b$01 Keep only bits 4-7.
  $A7C1,$01 Merge in the stage and direction of growth.
  $A7C2,$01 Store the first byte of the state in the table.
  $A7C3,$01 Move onto the second byte of the state.
  $A7C4,$03 Fetch the colour of the orchid.
  $A7C7,$02,b$01 Keep only the colour (bits 0-2).
  $A7C9,$01 Stash the colour in #REGb.
  $A7CA,$03 Fetch the low byte of the timer of the orchid.
  $A7CD,$02,b$01 Keep only the low bits of the timer (bits 3-7).
  $A7CF,$01 Merge in the colour.
  $A7D0,$01 Store the second byte of the state in the table.
  $A7D1,$02 Restore the actor pointer from the stack.
  $A7D3,$01 Return.

c $A7D4 Find Orchid Position
@ $A7D4 label=HandlerOrchidPosition
D $A7D4 Finds the entry in #R$D6A6 for the layout of the room an actor is in.
R $A7D4 IX Actor record
R $A7D4 O:HL Address of the X and Y position of the orchid
  $A7D4,$01 Stash #REGbc on the stack.
N $A7D5 Fetch the layout of the room.
  $A7D5,$03 Fetch the room of the actor.
  $A7D8,$02 Clear #REGh.
  $A7DA,$03 Point #REGbc at the layout table at #R$6066.
  $A7DD,$01 Add the layout table address to get the address of the layout number
. for the room.
N $A7DE Fetch the orchid position for the layout.
  $A7DE,$01 Fetch the layout number of the room.
  $A7DF,$02 Clear #REGh.
  $A7E1,$01 Double the layout number, as there are two bytes of position for
. each layout.
  $A7E2,$03 Point #REGbc at the table of orchid positions at #R$D6A6.
  $A7E5,$01 Add the table address to get the address of the position for the
. layout.
  $A7E6,$01 Restore #REGbc from the stack.
  $A7E7,$01 Return.

c $A7E8 Find Orchid State
@ $A7E8 label=HandlerOrchidType
D $A7E8 Finds the entry in #R$A7F8 for the layout of a room.
R $A7E8 A Room
R $A7E8 O:HL Address of the state of the orchid
N $A7E8 Fetch the layout of the room.
  $A7E8,$03 Use the room as the offset into the layout table.
  $A7EB,$03 Point #REGbc at the layout table at #R$6066.
  $A7EE,$01 Add the layout table address to get the address of the layout number
. for the room.
N $A7EF Fetch the state of the orchid for the layout.
  $A7EF,$01 Fetch the layout number of the room.
  $A7F0,$02 Clear #REGh.
  $A7F2,$01 Double the layout number, as there are two bytes of state for each
. layout.
  $A7F3,$03 Point #REGbc at the table of orchid states at #R$A7F8.
  $A7F6,$01 Add the table address to get the address of the state for the
. layout.
  $A7F7,$01 Return.

b $A7F8 Table: Orchid Types
@ $A7F8 label=TableOrchidTypes
D $A7F8 The state of the orchid for each of the #N$30 room layouts, held as two
. bytes. This is the state when the game starts, and is updated by #R$A79F
. as the player moves between rooms.
. #TABLE(default,centre,left)
. { =h Byte | =h Bits | =h Contents }
. { #N$00 | 0-2 | The stage of growth }
. { | 3 | The direction of growth (set when the orchid is shrinking) }
. { | 4-7 | The high byte of the timer }
. { #N$01 | 0-2 | The colour }
. { | 3-7 | The low byte of the timer }
. TABLE#
  $A7F8,$60,$02

c $A858 Handler: Wulf
@ $A858 label=HandlerWulf
D $A858 Handles the Sabre Wulf (sprite IDs #N$50 to #N$57) when it is
. running. Bit 2 of the sprite ID is set when the Wulf is facing right.
. .
. Each time the Wulf is handled it animates, works out whether to head for
. the player (see #R$A922) or pounce at them (see #R$A8B2), moves with its
. velocity (see #R$AFE8), turns around if it was blocked and then hurts the
. player if it is touching them.
R $A858 IX Actor record of the Wulf
  $A858,$03 Remember the previous position of the Wulf.
  $A85B,$05 Set the width of the Wulf in #R$96AD to #N$20.
  $A860,$03 Animate the Wulf.
  $A863,$03 Choose the direction of the Wulf.
  $A866,$03 Test whether the Wulf should pounce.
@ $A869 label=HandlerWulf_Move
  $A869,$03 Work out the new position of the Wulf.
N $A86C Stop the Wulf moving through objects in the room. If it did not manage
. to move then turn it around.
  $A86C,$03 Set the height of the Wulf in #REGb to #N$17 and the width in #REGc
. to #N$1F.
  $A86F,$03 Stop the Wulf passing through objects in the room.
  $A872,$03 Test whether the Wulf has stayed where it was.
  $A875,$02 Jump to #R$A87A if the Wulf has moved.
  $A877,$03 Turn the Wulf around.
@ $A87A label=HandlerWulf_Position
  $A87A,$03 Set the X position of the Wulf.
  $A87D,$03 Set the Y position of the Wulf.
N $A880 The Wulf can only hurt the player if the player is in the same room and
. has the normal colour.
@ $A880 label=HandlerWulf_Touch
  $A880,$03 Fetch the colour of the player from #R$9707.
  $A883,$04 Jump to #R$A8AF if the player does not have the normal colour
. (#COLOUR$47).
  $A887,$03 Fetch the room of the player from #R$9703.
  $A88A,$05 Jump to #R$A8AF if the Wulf is in a different room to the player.
  $A88F,$03 Set the reach used to test whether the Wulf is touching the player
. in #REGbc to #N$0F1C.
  $A892,$03 Test whether the Wulf is touching the player.
  $A895,$02 Jump to #R$A8AF if the Wulf is not touching the player.
N $A897 Knock the player in the direction the Wulf is facing.
  $A897,$03 Fetch the sprite ID of the Wulf.
  $A89A,$01 Flip the bits.
  $A89B,$02 Rotate right twice, so bit 2 is now in bit 0.
  $A89D,$02,b$01 Keep only bit 0.
  $A89F,$01 Add one, giving a hit direction of #N$01 or #N$02.
  $A8A0,$03 Store the hit direction in #R$9704.
N $A8A3 Turn the Wulf around unless the player is attacking.
  $A8A3,$03 Fetch the sprite ID of the player from #R$9702.
  $A8A6,$02 Subtract #N$20 (the first attacking Sabreman sprite ID).
  $A8A8,$04 Jump to #R$A8AF if the player is attacking.
  $A8AC,$03 Turn the Wulf around.
@ $A8AF label=HandlerWulf_Draw
  $A8AF,$03 Jump to #R$AD46 to update the Wulf.

c $A8B2 Test Wulf Pounce
@ $A8B2 label=TestWulfPounce
D $A8B2 Makes the Wulf pounce (sprite IDs #N$58 and #N$5C) when it is moving
. left, is in the same room as the player, is to the right of the player and
. the player is attacking to the right (sprite IDs #N$28 to #N$2F).
. #R$A8E4 does the same for a Wulf moving right.
R $A8B2 IX Actor record of the Wulf
  $A8B2,$03 Fetch the room of the player from #R$9703.
  $A8B5,$04 Return if the Wulf is in a different room to the player.
  $A8B9,$03 Fetch the pounce timer of the Wulf.
  $A8BC,$02,b$01 Keep only bits 4-7.
  $A8BE,$01 Return if the Wulf is pouncing already.
  $A8BF,$03 Fetch the X velocity of the Wulf.
  $A8C2,$04 Jump to #R$A8E4 if the Wulf is moving right.
  $A8C6,$03 Fetch the X position of the player from #R$9705.
  $A8C9,$04 Return if the player is not to the left of the Wulf.
  $A8CD,$03 Fetch the sprite ID of the player from #R$9702.
  $A8D0,$02 Subtract #N$28.
  $A8D2,$03 Return if the player is not attacking to the right.
N $A8D5 Start the pounce.
@ $A8D5 label=TestWulfPounce_Start
  $A8D5,$03 Fetch the sprite ID of the Wulf.
  $A8D8,$02,b$01 Keep only bits 2-7.
  $A8DA,$02,b$01 Set bit 3, giving a sprite ID of #N$58 or #N$5C.
  $A8DC,$03 Set the new sprite ID of the Wulf.
  $A8DF,$04 Set the pounce timer of the Wulf to #N$0F.
  $A8E3,$01 Return.

c $A8E4 Test Wulf Pounce Right
@ $A8E4 label=TestWulfPounceRight
D $A8E4 Makes a Wulf which is moving right pounce when the player is to the
. right of it and is attacking to the left (sprite IDs #N$20 to #N$27). See
. #R$A8B2.
R $A8E4 IX Actor record of the Wulf
  $A8E4,$03 Fetch the X position of the player from #R$9705.
  $A8E7,$04 Return if the player is to the left of the Wulf.
  $A8EB,$03 Fetch the sprite ID of the player from #R$9702.
  $A8EE,$02 Subtract #N$20 (the first attacking Sabreman sprite ID).
  $A8F0,$03 Return if the player is not attacking to the left.
  $A8F3,$02 Jump to #R$A8D5 to start the pounce.

c $A8F5 Handler: Wulf Pouncing
@ $A8F5 label=HandlerWulfPouncing
D $A8F5 Handles the first frame of the Wulf pouncing (sprite IDs #N$58 and
. #N$5C). The timer in #REGix+#N$02 counts down while the player is not
. attacking in the direction the Wulf is facing, and when it runs out the Wulf
. moves on to the second frame, which is handled by #R$A964. The Wulf can
. hurt the player in the same way as in #R$A858.
R $A8F5 IX Actor record of the Wulf
  $A8F5,$03 Remember the previous position of the Wulf.
  $A8F8,$03 Fetch the room of the player from #R$9703.
  $A8FB,$05 Jump to #R$A913 if the Wulf is in a different room to the player.
  $A900,$03 Fetch the sprite ID of the player from #R$9702.
  $A903,$02 Subtract #N$20 (the first attacking Sabreman sprite ID).
  $A905,$04 Jump to #R$A913 if the player is not attacking.
  $A909,$01 Rotate right, so that the direction of the attack is in bit 2.
  $A90A,$02,b$01 Keep only bit 2.
  $A90C,$03 Combine with the sprite ID of the Wulf, so bit 2 shows whether the
. directions differ.
  $A90F,$02,b$01 Keep only bit 2.
  $A911,$02 Jump to #R$A91F if the player is attacking in the other direction.
@ $A913 label=HandlerWulfPouncing_Timer
  $A913,$05 Decrease the pounce timer by one and jump to #R$A91F if it is not
. zero.
  $A918,$03 Move the Wulf on to the second frame of the pounce.
  $A91B,$04 Set the pounce timer of the Wulf to #N$08.
@ $A91F label=HandlerWulfPouncing_Touch
  $A91F,$03 Jump to #R$A880 to test whether the Wulf is touching the player.

c $A922 Choose Wulf Direction
@ $A922 label=ChooseWulfDirection
D $A922 Sets the direction of the Wulf. If the Wulf is not in the same row of
. rooms as the player then nothing happens, except that #REGix+#N$02 is reset.
. Otherwise, if #REGix+#N$02 is zero, it is set to #N$01 and the Wulf is
. sent to the left or the right depending on whether the player is in a room
. to its left or right. If they are in the same room then the X positions are
. used instead (see #R$A95A).
R $A922 IX Actor record of the Wulf
  $A922,$03 Fetch the room of the player from #R$9703.
  $A925,$02,b$01 Keep only bits 4-7.
  $A927,$01 Stash the row of the player in #REGc.
  $A928,$03 Fetch the room of the Wulf.
  $A92B,$02,b$01 Keep only bits 4-7.
  $A92D,$03 Jump to #R$A935 if the Wulf is in the same row as the player.
  $A930,$04 Clear the direction chosen flag of the Wulf.
  $A934,$01 Return.
@ $A935 label=ChooseWulfDirection_SameRow
  $A935,$03 Fetch the direction chosen flag of the Wulf.
  $A938,$02 Return if the direction has already been chosen.
  $A93A,$04 Set the direction chosen flag of the Wulf.
  $A93E,$03 Fetch the room of the player from #R$9703.
  $A941,$05 Jump to #R$A95A if the Wulf is in the same room as the player.
  $A946,$02 Jump to #R$A951 if the player is to the right of the Wulf.
@ $A948 label=ChooseWulfDirection_Left
  $A948,$04 Set the X velocity of the Wulf to #N$C0 (moving left).
  $A94C,$04 Reset bit 2 of the sprite ID so that the Wulf faces left.
  $A950,$01 Return.

c $A951 Send Wulf Right
@ $A951 label=SendWulfRight
D $A951 Sends the Wulf to the right.
R $A951 IX Actor record of the Wulf
  $A951,$04 Set the X velocity of the Wulf to #N$40 (moving right).
  $A955,$04 Set bit 2 of the sprite ID so that the Wulf faces right.
  $A959,$01 Return.

c $A95A Compare Wulf Position
@ $A95A label=CompareWulfPosition
D $A95A Sends the Wulf to the left if the player is to its left, or otherwise
. to the right. This is used when the Wulf and the player are in the same
. room.
R $A95A IX Actor record of the Wulf
  $A95A,$03 Fetch the X position of the player from #R$9705.
  $A95D,$05 Jump to #R$A948 if the player is to the left of the Wulf.
  $A962,$02 Jump to #R$A951.

c $A964 Handler: Wulf Landing
@ $A964 label=HandlerWulfLanding
D $A964 Handles the second frame of the Wulf pouncing (sprite IDs #N$59 and
. #N$5D). When the timer in #REGix+#N$02 runs out the Wulf goes back to
. running with a faster velocity than before.
R $A964 IX Actor record of the Wulf
  $A964,$03 Remember the previous position of the Wulf.
  $A967,$05 Decrease the pounce timer by one and jump to #R$A982 if it is not
. zero.
  $A96C,$04 Reset bit 3 of the sprite ID to go back to running.
  $A970,$04 Set the pounce timer of the Wulf to #N$10.
  $A974,$03 Fetch the X velocity of the Wulf.
  $A977,$04 Jump to #R$A97D if the velocity is positive.
  $A97B,$02 Subtract #N$40 if the velocity is negative.
@ $A97D label=HandlerWulfLanding_Velocity
  $A97D,$02 Add #N$20, making the velocity faster in either direction.
  $A97F,$03 Set the new X velocity of the Wulf.
@ $A982 label=HandlerWulfLanding_Move
  $A982,$03 Jump to #R$A869 to move the Wulf.

c $A985 Knock Player Back
@ $A985 label=KnockPlayerBack
D $A985 Starts the player flying after they have been hit, using the hit
. direction in #REGa (taken from #R$9704). Bit 7 of the hit direction makes
. the player fall straight down instead (see #R$A9AB). A hit direction of
. #N$02 sends the player to the left (see #R$A9A0) and otherwise the player
. is sent to the right. The sprite IDs #N$40 to #N$47 are then handled by
. #R$A9BE, #R$AA0D and #R$A61B.
R $A985 A The hit direction
R $A985 IX Actor record of the player
  $A985,$04 Set the hit counter of the player to #N$20.
  $A989,$04 Jump to #R$A9AB to make the player fall down if bit 7 is set.
  $A98D,$04 Clear the Y velocity of the player.
  $A991,$04 Jump to #R$A9A0 if the player is to be sent to the left
. (the hit direction is #N$02).
  $A995,$04 Set the sprite ID of the player to #N$40 (#SPRITENAME$40).
  $A999,$04 Set the X velocity of the player to #N$03 (moving right).
  $A99D,$03 Jump to #R$AD5D to display the player.

c $A9A0 Knock Player Left
@ $A9A0 label=KnockPlayerLeft
D $A9A0 Sends the player flying to the left.
R $A9A0 IX Actor record of the player
  $A9A0,$04 Set the sprite ID of the player to #N$44 (#SPRITENAME$44).
  $A9A4,$04 Set the X velocity of the player to #N$FD (moving left).
  $A9A8,$03 Jump to #R$AD5D to display the player.

c $A9AB Knock Player Down
@ $A9AB label=KnockPlayerDown
D $A9AB Makes the player fall down the screen at the middle of the screen.
R $A9AB IX Actor record of the player
  $A9AB,$04 Set the sprite ID of the player to #N$40 (#SPRITENAME$40).
  $A9AF,$04 Clear the X velocity of the player.
  $A9B3,$04 Set the Y velocity of the player to #N$04 (falling).
  $A9B7,$04 Set the X position of the player to #N$78
. (the middle of the screen).
  $A9BB,$03 Jump to #R$AD5D to display the player.

c $A9BE Handler: Flying Sabreman
@ $A9BE label=HandlerFlyingSabreman
D $A9BE Handles the player while they are flying through the air after being
. hit (sprite IDs #N$40 and #N$44). The player moves with the velocity set up
. by #R$A985 and falls to the ground when they hit an object or the edge of
. the play area. A sound is played with a pitch which changes with the
. counter in #REGix+#N$02.
R $A9BE IX Actor record of the player
  $A9BE,$03 Remember the previous position of the player.
N $A9C1 Add the velocities to the position.
  $A9C1,$03 Fetch the X velocity of the player.
  $A9C4,$03 Add the X position of the player.
  $A9C7,$01 Stash the new X position in #REGe.
  $A9C8,$03 Fetch the Y position of the player.
  $A9CB,$03 Add the Y velocity of the player.
  $A9CE,$01 Stash the new Y position in #REGd.
  $A9CF,$03 Set the height of the player in #REGb to #N$17 and the width in
. #REGc to #N$0F.
  $A9D2,$03 Stop the player passing through objects in the room.
  $A9D5,$03 Test whether the player has stayed where it was.
  $A9D8,$02 Jump to #R$AA00 if the player did not move.
  $A9DA,$01 Fetch the new X position.
  $A9DB,$04 Jump to #R$AA00 if the player is off the left of the play area.
  $A9DF,$04 Jump to #R$AA00 if the player is off the right of the play area.
  $A9E3,$01 Fetch the new Y position.
  $A9E4,$04 Jump to #R$AA00 if the player is off the top of the play area.
  $A9E8,$04 Jump to #R$AA00 if the player is off the bottom of the play area.
  $A9EC,$03 Set the X position of the player.
  $A9EF,$03 Set the Y position of the player.
  $A9F2,$03 Display the player.
N $A9F5 Play a sound which changes with the counter.
  $A9F5,$03 Increase the flying counter of the player by one.
  $A9F8,$03 Fetch the flying counter as the duration of the wave in #REGb.
  $A9FB,$02 Set the number of waves in #REGc to #N$04.
  $A9FD,$03 Jump to #R$BF6D to play the sound.

c $AA00 Land Sabreman
@ $AA00 label=LandSabreman
D $AA00 Makes the player sit down after flying through the air. The sprite ID
. goes up by one (to #N$41 or #N$45), a counter of #N$3F is set, the player
. is drawn and a noise is played.
R $AA00 IX Actor record of the player
  $AA00,$03 Move the player on to the sitting sprite.
  $AA03,$04 Set the sitting counter of the player to #N$3F.
  $AA07,$03 Display the player.
  $AA0A,$03 Jump to #R$BF2F to play the noise.

c $AA0D Handler: Sitting Sabreman
@ $AA0D label=HandlerSittingSabreman
D $AA0D Handles the player after they have landed (sprite IDs #N$41, #N$42,
. #N$45 and #N$46). When the counter in #REGix+#N$02 runs out the player
. either starts again or loses a life (see #R$AA27). If the player has no
. lives left then they are shown as dead when the counter reaches #N$30.
R $AA0D IX Actor record of the player
  $AA0D,$03 Remember the previous position of the player.
  $AA10,$05 Decrease the sitting counter by one and jump to #R$AA27 if it has
. run out.
  $AA15,$03 Fetch the number of lives from #R$96BD.
  $AA18,$03 Jump to #R$AA57 if the player has lives left.
  $AA1B,$03 Fetch the sitting counter of the player.
  $AA1E,$04 Jump to #R$AA57 if the sitting counter is not #N$30.
  $AA22,$03 Move the player on to the dead sprite.
  $AA25,$02 Jump to #R$AA57.

c $AA27 Handle Player Death
@ $AA27 label=HandlePlayerDeath
D $AA27 Called when the player has finished being shown as dead or sitting
. (see #R$AA0D). Depending on the number of players and the number of lives
. left this will either put the player back on their feet with one life less,
. end the game for the player, or hand over to the other player.
R $AA27 IX Actor record of the player
N $AA27 Is this a one or two player game?
  $AA27,$03 Fetch the game options from #R$9692.
  $AA2A,$02,b$01 Keep only bit 0.
  $AA2C,$02 Jump to #R$AA5A if this is a two player game.
N $AA2E This is a one player game.
@ $AA2E label=HandlePlayerDeath_OnePlayer
  $AA2E,$06 Jump to #R$AAA4 if the player has no lives left.
  $AA34,$03 Point #REGhl at the number of lives at #R$96BD.
N $AA37 See #POKE(infinite_lives_player_1,Infinite Lives Player 1).
  $AA37,$01 Decrease the number of lives by one.
  $AA38,$03 Update the lives display.
N $AA3B Put the player back on their feet with the normal colour.
  $AA3B,$03 Fetch the sprite ID of the player.
  $AA3E,$02,b$01 Keep only bits 0-2.
  $AA40,$02,b$01 Set bit 4, giving a sprite ID of #N$10 to #N$17.
  $AA42,$03 Set the new sprite ID of the player.
  $AA45,$04 Set the colour of the player to #COLOUR$47.
N $AA49 Remove any orchid effect and delay the nastie and flame spawning.
  $AA49,$04 Clear the orchid effect timer in #R$96B0.
  $AA4D,$05 Set the nastie spawn delay in #R$96B1 to #N$10.
  $AA52,$05 Set the flame spawn delay in #R$96B4 to #N$80.
@ $AA57 label=HandlePlayerDeath_Draw
  $AA57,$03 Jump to #R$AD5D to display the player.
N $AA5A This is a two player game.
@ $AA5A label=HandlePlayerDeath_TwoPlayer
  $AA5A,$06 Jump to #R$AA2E if the other player has no lives left.
  $AA60,$03 Fetch the number of lives of this player from #R$96BD.
  $AA63,$04 Show the game over message if this player has no lives left.
  $AA67,$03 Jump to #R$B205 to swap over to the other player.

c $AA6A Game Over
@ $AA6A label=GameOver_1UP_Messaging
D $AA6A Shows the "GAME OVER PLAYER" message, with the percentage of the jungle
. explored, and plays a tune. The message is for player 1 when entered at
. #R$AA6A and for player 2 when entered at #R$AA98.
. .
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$AA6A }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #SCR$01(game-over-before)
. | #POKES$96BF,$FF,$0A
. #SIM(start=$AA6A,stop=$AA8A,sp=$5B40)
. #SCR$01(game-over-after) } UDGTABLE# #POPS
E $AA6A View the equivalent code in;
. #LIST
. { #LUNARJETMAN$A8E3 }
. { #TRANZAM$6353 }
. LIST#
N $AA6A #HTML(Set up altering the "GAME OVER PLAYER <em>X</em>" message for 1UP.)
  $AA6A,c,$02 #REGa="1" + #N$80 (escape character).
N $AA6C Print the messaging and pause to show it for a period of time.
@ $AA6C label=GameOver_Write
  $AA6C,$03 Write ASCII player number to #R$AAC1(#N$AAD3)(GameOver_Text).
  $AA6F,$03 Clear the attribute buffer of the play area.
  $AA72,$03 Clear the play area.
  $AA75,$03 Point #REGde at the "ADVENTURE COMPLETED" message at #R$AAD4.
  $AA78,$03 Set the print position in #REGhl
. (#REGl is the X position and #REGh is the Y position) to #N$7820.
  $AA7B,$03 Print the message.
  $AA7E,$03 Point #REGde at the "GAME OVER PLAYER" message at #R$AAC1.
  $AA81,$03 Set the print position in #REGhl to #N$6038.
  $AA84,$03 Print the message.
  $AA87,$03 Print the percentage of the jungle explored.
  $AA8A,$03 Point #REGde at the game over tune at #R$BD28.
  $AA8D,$03 Play the tune.
N $AA90 Introduce a pause by counting down from #N$10000 twice.
  $AA90,$02 Set the number of delays in #REGb to #N$02.
  $AA92,$03 Set the delay counter in #REGhl to #N$0000
. (which counts down from #N$10000).
  $AA95,$03 Jump to #R$A1FF to pause.
N $AA98 #HTML(Set up altering the "GAME OVER PLAYER <em>X</em>" message for 2UP.)
@ $AA98 label=GameOver_2UP
  $AA98,c,$02 #REGa="2" + #N$80 (escape character).
  $AA9A,$02 Jump to #R$AA6C.

c $AA9C Show Current Game Over
@ $AA9C label=GameOver_Controller
D $AA9C Shows the game over message for whichever player is active. This simply
. returns when it is done, as the game continues after the message.
  $AA9C,$06 Jump to #R$AA6A to show the message for 1UP if player 1 is active
. (#R$969E is zero).
  $AAA2,$02 Jump to #R$AA98 to show the message for 2UP.

c $AAA4 End Game
@ $AAA4 label=GameOver_ControllerRestart
D $AAA4 Ends the game: shows the game over message for the active player, lets
. the player enter their name if they have a high score, shows the Hall of
. Fame if a new score has been entered and then returns to the game selection
. screen at #R$998F.
  $AAA4,$06 Jump to #R$AABC if player 2 is active (#R$969E is not zero).
@ $AAAA label=GameOver_Scores
  $AAAA,$03 Show the game over message for 1UP.
@ $AAAD label=GameOver_NewHighScore
  $AAAD,$03 Check for a new high score.
  $AAB0,$06 Jump to #R$AAB9 if the hall of fame has not been updated
. (#R$96BA is zero).
  $AAB6,$03 Show the hall of fame.
@ $AAB9 label=GameOver_Restart
  $AAB9,$03 Jump to #R$998F to restart the game.
@ $AABC label=GameOver_Restart2UP
  $AABC,$03 Show the game over message for 2UP.
  $AABF,$02 Jump to #R$AAAD.

t $AAC1 Messaging: Game Over
@ $AAC1 label=GameOver_Text
D $AAC1 This message is altered directly to change from "1" to "2" for the
. correct player. See #R$AA6A and #R$AA98.
B $AAC1,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $AAC2,$12,$11:$01 #HTML("GAME OVER PLAYER <em>X</em>".)

t $AAD4 Messaging: Adventure Completed
@ $AAD4 label=AdventureCompleted_Text
D $AAD4 The message shown on the game over screen, which is the heading for the
. percentage of the jungle explored (see #R$9CC6). The message finishes with a
. percent sign.
B $AAD4,$01 Attribute: #COLOUR(#PEEK(#PC)).
  $AAD5,$18,$17:$01 "#STR(#PC)".

c $AAED Test Position Unchanged
@ $AAED label=TestPositionUnchanged
D $AAED Tests whether the position an actor has been moved to is the same as the
. position it started from.
R $AAED DE The new position of the actor (#REGe is X and #REGd is Y)
R $AAED IX Actor record
R $AAED O:F Zero flag set if the position is the same as the position in the
. record
  $AAED,$01 Fetch the new X position of the actor.
  $AAEE,$03 Compare the new X position with the X position of the actor.
  $AAF1,$01 Return if the X positions are different.
  $AAF2,$01 Fetch the new Y position of the actor.
  $AAF3,$03 Compare the new Y position with the Y position of the actor.
  $AAF6,$01 Return.

u $AAF7 Test Position Partly Unchanged
@ $AAF7 label=TestPositionPartlyUnchanged
D $AAF7 Tests whether either the X position or the Y position an actor has been
. moved to is the same as the one it started from. This routine is not used.
R $AAF7 DE The new position of the actor (#REGe is X and #REGd is Y)
R $AAF7 IX Actor record
R $AAF7 O:F Zero flag set if either the X or Y position is the same
  $AAF7,$01 Fetch the new X position of the actor.
  $AAF8,$04 Return if the X positions are the same.
  $AAFC,$01 Fetch the new Y position of the actor.
  $AAFD,$03 Compare the new Y position with the Y position of the actor.
  $AB00,$01 Return.

c $AB01 Test Player Touching Actor
@ $AB01 label=TestPlayerTouchingActor
D $AB01 Tests whether the player is touching an actor. The reach in #REGb and
. #REGc is how far the player can be above and to the right of the position of
. the actor, and the reach below and to the left is fixed:
. #TABLE(default,centre,centre,centre)
. { =h Player | =h Left | =h Below }
. { Walking (sprite IDs #N$10 to #N$1F) | #N$0C | #N$0F }
. { Attacking (sprite IDs #N$20 to #N$2F) | #N$1C | #N$0F }
. TABLE#
. No touching takes place while the game delay in #R$96B5 is running, or if
. the player is not walking or attacking.
R $AB01 B How far above the actor the player can be
R $AB01 C How far to the right of the actor the player can be
R $AB01 IX Actor record
R $AB01 O:F Carry flag set if the player is touching the actor
  $AB01,$03 Fetch the start-of-turn delay from #R$96B5.
  $AB04,$02 Return (with the carry flag reset) if the start-of-turn delay is
. running.
  $AB06,$03 Fetch the sprite ID of the player from #R$9702.
  $AB09,$02 Subtract #N$10 (the first Sabreman sprite ID).
  $AB0B,$03 Return if the player is not walking or attacking.
@ $AB0E label=TestPlayerTouchingActor_Reach
  $AB0E,$03 Set the reach below the actor in #REGh to #N$0F and the reach to the
. left in #REGl to #N$0C.
  $AB11,$04 Jump to #R$AB18 if the player is walking.
  $AB15,$03 Set the longer reach to the left of an attacking player in #REGl to
. #N$1C.
N $AB18 Compare the X positions.
@ $AB18 label=TestPlayerTouchingActor_X
  $AB18,$03 Fetch the X position of the player from #R$9705.
  $AB1B,$03 Subtract the X position of the actor to get the horizontal distance.
  $AB1E,$02 Jump to #R$AB2C if the player is to the left of the actor.
  $AB20,$01 Compare the distance with the reach to the right.
@ $AB21 label=TestPlayerTouchingActor_TooFarRight
  $AB21,$01 Return if the player is too far to the right.
N $AB22 Compare the Y positions.
@ $AB22 label=TestPlayerTouchingActor_Y
  $AB22,$03 Fetch the Y position of the player from #R$9706.
  $AB25,$03 Subtract the Y position of the actor to get the vertical distance.
  $AB28,$02 Jump to #R$AB31 if the player is above the actor.
  $AB2A,$01 Compare the distance with the reach below.
@ $AB2B label=TestPlayerTouchingActor_Return
  $AB2B,$01 Return.
N $AB2C The player is to the left of the actor.
@ $AB2C label=TestPlayerTouchingActor_Left
  $AB2C,$02 Make the distance positive.
  $AB2E,$01 Compare the distance with the reach to the left.
  $AB2F,$02 Jump to #R$AB21.
N $AB31 The player is above the actor.
@ $AB31 label=TestPlayerTouchingActor_Above
  $AB31,$02 Make the distance positive.
  $AB33,$01 Compare the distance with the reach above.
  $AB34,$02 Jump to #R$AB2B.

c $AB36 Test Actor Hurting Player
@ $AB36 label=TestActorHurtingPlayer
D $AB36 Tests whether an actor is touching the player, and if so whether the
. actor hurts the player. The test is only made when the player has the normal
. colour of #N$47 (see #R$A737) and is in the same room as the actor.
. .
. If the player is walking, or is attacking in the direction away from the
. actor, then they are hit and the direction they are hit in is written to
. #R$9704 (#N$01 if bit 0 of #REGd is set, or #N$02 otherwise). If the player is
. attacking towards the actor then the actor is hit and no hit direction is
. written.
R $AB36 B How far above the actor the player can be
R $AB36 C How far to the right of the actor the player can be
R $AB36 D Bit 0 is set if the hit direction should be #N$01
R $AB36 IX Actor record
R $AB36 O:F Carry flag set if the actor is touching the player
  $AB36,$03 Fetch the colour of the player from #R$9707.
  $AB39,$02 Subtract #N$47 (the normal colour).
  $AB3B,$02 Return if the player does not have the normal colour.
@ $AB3D label=TestActorHurtingPlayer_Room
  $AB3D,$03 Fetch the room of the player from #R$9703.
  $AB40,$03 Subtract the room of the actor.
  $AB43,$02 Return if the actor is in a different room to the player.
  $AB45,$03 Test whether the player is touching the actor.
N $AB48 See #POKE(immunity,Immunity).
  $AB48,$01 Return if the player is not touching the actor.
  $AB49,$03 Fetch the sprite ID of the player from #R$9702.
  $AB4C,$02 Subtract #N$10 (the first Sabreman sprite ID).
  $AB4E,$04 Jump to #R$AB5E if the player is walking.
  $AB52,$04 Jump to #R$AB6A if the player is attacking to the right
. (bit 3 of the sprite ID is set).
N $AB56 The player is attacking to the left.
  $AB56,$03 Fetch the X position of the player from #R$9705.
  $AB59,$03 Subtract the X position of the actor.
  $AB5C,$02 Jump to #R$AB68 if the actor is to the left of the player.
N $AB5E Hurt the player.
@ $AB5E label=TestActorHurtingPlayer_Hit
  $AB5E,$02 Test whether the hit direction should be #N$01 (bit 0 of #REGd).
  $AB60,$02 Set the hit direction in #REGa to #N$01.
  $AB62,$02 Jump to #R$AB65 if bit 0 of #REGd is set.
  $AB64,$01 Set the hit direction in #REGa to #N$02.
@ $AB65 label=TestActorHurtingPlayer_Direction
  $AB65,$03 Store the hit direction in #R$9704.
@ $AB68 label=TestActorHurtingPlayer_Touching
  $AB68,$01 Set the carry flag (the actor is touching the player).
  $AB69,$01 Return.
N $AB6A The player is attacking to the right.
@ $AB6A label=TestActorHurtingPlayer_Right
  $AB6A,$03 Fetch the X position of the player from #R$9705.
  $AB6D,$03 Subtract the X position of the actor.
  $AB70,$02 Jump to #R$AB68 if the actor is to the right of the player.
  $AB72,$02 Jump to #R$AB5E to hurt the player.

c $AB74 Handler: Tribesman
@ $AB74 label=HandlerTribesman
D $AB74 Handles a tribesman (sprite IDs #N$38 to #N$3F). Bit 2 of the sprite ID
. is set when the tribesman is facing right.
. .
. A tribesman wanders about the room with the velocity chosen by #R$ABDE. If
. it touches the player then it hurts the player and is thrown away (see
. #R$ABEF). When a tribesman is close to an amulet piece which has not been
. collected (see #R$9D41) it flashes yellow and plays a sound.
R $AB74 IX Actor record of the tribesman
  $AB74,$03 Bring the tribesman closer to the player if it is two or more rows
. away.
  $AB77,$03 Remember the previous position of the tribesman.
  $AB7A,$05 Set the width of the tribesman in #R$96AD to #N$10.
  $AB7F,$03 Work out the new position of the tribesman.
  $AB82,$03 Set the height of the tribesman in #REGb to #N$17 and the width in
. #REGc to #N$0F.
  $AB85,$03 Stop the tribesman passing through objects in the room.
  $AB88,$03 Choose a new velocity if the tribesman did not manage to move.
  $AB8B,$03 Set the X position of the tribesman.
  $AB8E,$03 Set the Y position of the tribesman.
  $AB91,$03 Animate the tribesman.
N $AB94 Test whether the tribesman has touched the player.
  $AB94,$03 Fetch the sprite ID of the tribesman.
  $AB97,$02 Rotate right twice, so bit 2 is now in bit 0.
  $AB99,$02,b$01 Keep only the direction bit (bit 0).
  $AB9B,$01 Stash the hit direction in #REGd (used by #R$AB36).
  $AB9C,$03 Set the reach used to test whether the tribesman is touching the
. player in #REGbc to #N$0F0C.
  $AB9F,$03 Test whether the tribesman is hurting the player.
  $ABA2,$02 Jump to #R$ABB6 if the tribesman is not touching the player.
N $ABA4 Throw the tribesman away from the player.
  $ABA4,$03 Fetch the sprite ID of the player from #R$9702.
  $ABA7,$02,b$01 Keep only the direction the player is facing (bit 3).
  $ABA9,$02 Jump to #R$ABDA if the player is facing left.
  $ABAB,$02 Set the X velocity in #REGa to #N$40 (moving right).
@ $ABAD label=HandlerTribesman_Throw
  $ABAD,$03 Point #REGbc at the table of tribesman velocities at #R$AC24.
  $ABB0,$03 Set the velocity of the tribesman.
  $ABB3,$03 Play the warble sound.
N $ABB6 Flash the tribesman and make a sound if an amulet piece is close.
@ $ABB6 label=HandlerTribesman_Amulet
  $ABB6,$03 Test whether an amulet piece is close.
  $ABB9,$03 Jump to #R$AD46 to update the tribesman if no amulet piece is close.
  $ABBC,$01 Stash the distance to the amulet piece in #REGc.
  $ABBD,$03 Fetch the room of the player from #R$9703.
  $ABC0,$03 Compare with the room of the tribesman.
  $ABC3,$03 Jump to #R$AD46 to update the tribesman if it is in a different room
. to the player.
  $ABC6,$01 Fetch the distance to the amulet piece.
  $ABC7,$03 Play the amulet piece sound.
  $ABCA,$03 Fetch the colour of the tribesman.
  $ABCD,$01 Stash the colour on the stack.
  $ABCE,$04 Set the colour of the tribesman to #COLOUR$46 (bright yellow).
  $ABD2,$03 Update the tribesman.
  $ABD5,$01 Restore the colour of the tribesman from the stack.
  $ABD6,$03 Set the colour of the tribesman.
  $ABD9,$01 Return.
@ $ABDA label=HandlerTribesman_ThrowLeft
  $ABDA,$02 Set the X velocity in #REGa to #N$C0 (moving left).
  $ABDC,$02 Jump to #R$ABAD.

c $ABDE Choose Tribesman Velocity
@ $ABDE label=ChooseTribesmanVelocity
D $ABDE Chooses a new velocity for a tribesman if it did not manage to move.
. The velocities are held in #R$AC24, so each one has a one in four chance of
. being chosen for each direction.
R $ABDE DE The new position of the tribesman (#REGe is X and #REGd is Y)
R $ABDE IX Actor record of the tribesman
  $ABDE,$03 Test whether the tribesman has stayed where it was.
  $ABE1,$01 Return if the tribesman has moved.
  $ABE2,$03 Point #REGbc at the table of tribesman velocities at #R$AC24.
  $ABE5,$03 Fetch the random seed from #R$9695.
  $ABE8,$02,b$01 Keep only bits 0-1.
  $ABEA,$01 Stash the velocity index in #REGl.
  $ABEB,$02 Clear #REGh.
  $ABED,$01 Add the table address to get the address of the velocity.
  $ABEE,$01 Fetch the X velocity from the table.

c $ABEF Set Tribesman Velocity
@ $ABEF label=SetTribesmanVelocity
D $ABEF Sets the X velocity of a tribesman and makes it face the way it is
. going, then chooses a random Y velocity.
R $ABEF A The X velocity
R $ABEF BC Address of the table of velocities at #R$AC24
R $ABEF IX Actor record of the tribesman
  $ABEF,$03 Set the X velocity of the tribesman.
  $ABF2,$04 Jump to #R$AC08 if the tribesman is moving left.
  $ABF6,$04 Set bit 2 of the sprite ID so that the tribesman faces right.
@ $ABFA label=SetTribesmanVelocity_Y
  $ABFA,$03 Fetch the low byte of #SKOOLKID$5C78(FRAMES).
  $ABFD,$02,b$01 Keep only bits 0-1.
  $ABFF,$01 Stash the velocity index in #REGl.
  $AC00,$02 Clear #REGh.
  $AC02,$01 Add the table address to get the address of the velocity.
  $AC03,$01 Fetch the Y velocity from the table.
  $AC04,$03 Set the Y velocity of the tribesman.
  $AC07,$01 Return.
N $AC08 The tribesman is moving left.
@ $AC08 label=SetTribesmanVelocity_Left
  $AC08,$04 Reset bit 2 of the sprite ID so that the tribesman faces left.
  $AC0C,$02 Jump to #R$ABFA.

c $AC0E Animate Actor
@ $AC0E label=AnimateActor
D $AC0E Every other frame, moves an actor on to the next frame of its animation
. by incrementing the lowest two bits of the sprite ID (so the animation is
. the four frames of the sprite with the same upper bits).
R $AC0E IX Actor record
  $AC0E,$03 Fetch the low byte of the game timer from #R$9693.
  $AC11,$02,b$01 Keep only bit 0.
  $AC13,$01 Return if bit 0 is set
. (the actor only animates on alternate passes).
  $AC14,$03 Fetch the sprite ID of the actor.
  $AC17,$01 Stash the sprite ID in #REGc.
  $AC18,$01 Move on to the next frame.
  $AC19,$02,b$01 Keep only bits 0-1.
  $AC1B,$01 Stash the new frame in #REGb.
  $AC1C,$01 Fetch the old sprite ID.
  $AC1D,$02,b$01 Keep only bits 2-7.
  $AC1F,$01 Merge in the new frame.
  $AC20,$03 Set the new sprite ID of the actor.
  $AC23,$01 Return.

b $AC24 Tribesman Velocities
@ $AC24 label=TribesmanVelocities
D $AC24 The velocities which a tribesman can be given by #R$ABDE, in sixteenths
. of a pixel. Two are negative (up or left) and two are positive (down or
. right).
  $AC24,$02,$01 Negative velocities.
  $AC26,$02,$01 Positive velocities.

c $AC28 Pause Game
@ $AC28 label=PauseGame
D $AC28 Pauses the game if SPACE (or CAPS SHIFT) is being pressed on its own.
. While the game is paused the border flashes. Pressing SPACE (or CAPS SHIFT)
. again carries on with the game, and the border is set back to black.
  $AC28,$01 Enable interrupts.
  $AC29,$06 Read from the keyboard (#N$7E is also written to port #N$FD);
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { =r2 #N$7E | SPACE | FULL-STOP | M | N | B }
. { Shift | Z | X | C | V }
. TABLE#
  $AC2F,$03 Return if neither SPACE nor CAPS SHIFT is being pressed.
  $AC32,$01 Flip the bits so that the keys being pressed are set.
  $AC33,$02,b$01 Keep only the other keys on this row (bits 1-4).
  $AC35,$01 Return if any other key is being pressed.
N $AC36 Wait for the key to be released.
@ $AC36 label=PauseGame_Release
  $AC36,$06 Read from the keyboard (#N$7E is also written to port #N$FD);
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { =r2 #N$7E | SPACE | FULL-STOP | M | N | B }
. { Shift | Z | X | C | V }
. TABLE#
  $AC3C,$04 Jump back to #R$AC36 until SPACE and CAPS SHIFT have been released.
N $AC40 Flash the border every frame until the key is pressed again.
@ $AC40 label=PauseGame_Loop
  $AC40,$03 Point #REGhl at #SKOOLKID$5C78(FRAMES).
  $AC43,$01 Fetch the frame counter.
@ $AC44 label=PauseGame_Frame
  $AC44,$03 Jump back to #R$AC44 until the frame counter changes.
  $AC47,$01 Fetch the border flash counter from #REGd.
  $AC48,$02 Add #N$04 to the border flash counter.
  $AC4A,$01 Store the border flash counter in #REGd.
  $AC4B,$02 Rotate left twice, so bit 7 is now in bit 1.
  $AC4D,$02,b$01 Keep only bit 1.
  $AC4F,$02,b$01 Set bit 0, so the border alternates between blue and magenta.
  $AC51,$02 Set the border colour.
  $AC53,$06 Read from the keyboard (#N$7E is also written to port #N$FD);
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { =r2 #N$7E | SPACE | FULL-STOP | M | N | B }
. { Shift | Z | X | C | V }
. TABLE#
  $AC59,$04 Jump back to #R$AC40 until SPACE or CAPS SHIFT is pressed to
. unpause.
N $AC5D Wait for the key to be released again.
@ $AC5D label=PauseGame_Release_Again
  $AC5D,$06 Read from the keyboard (#N$7E is also written to port #N$FD);
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { =r2 #N$7E | SPACE | FULL-STOP | M | N | B }
. { Shift | Z | X | C | V }
. TABLE#
  $AC63,$04 Jump back to #R$AC5D until SPACE and CAPS SHIFT have been released.
  $AC67,$01 Select black for the border.
  $AC68,$02 Set the border colour.
  $AC6A,$01 Return.

c $AC6B Reset Actors
@ $AC6B label=ResetActors
D $AC6B Copies the initial state of the #N$0C actors in #R$AC77 into the actor
. table at #R$9702, which sets up the player and the immortal actors for a new
. game.
  $AC6B,$03 Point #REGhl at the initial state of the actors at #R$AC77.
  $AC6E,$03 Point #REGde at the actor table at #R$9702.
  $AC71,$03 Set the number of bytes to copy in #REGbc to #N$0090 (#N$0C actors
. of #N$0C bytes).
  $AC74,$02 Copy the actors.
  $AC76,$01 Return.

b $AC77 Initial Actors
@ $AC77 label=InitialActors
D $AC77 The initial state of the player and the immortal actors, copied into
. #R$9702 by #R$AC6B. Each is a #N$0C byte actor record (see #R$9702). The
. spare record is used for flames.
  $AC77,$0C,$0C Player (#SPRITENAME$10) in room #N$A8.
  $AC83,$0C,$0C Rhino (#SPRITENAME$30) in room #N$98.
  $AC8F,$0C,$0C Rhino (#SPRITENAME$32) in room #N$07.
  $AC9B,$0C,$0C Rhino (#SPRITENAME$30) in room #N$F3.
  $ACA7,$0C,$0C Rhino (#SPRITENAME$32) in room #N$98.
  $ACB3,$0C,$0C Tribesman (#SPRITENAME$3C) in room #N$A7.
  $ACBF,$0C,$0C Tribesman (#SPRITENAME$3C) in room #N$44.
  $ACCB,$0C,$0C Tribesman (#SPRITENAME$3C) in room #N$E2.
  $ACD7,$0C,$0C Spare record for a flame.
  $ACE3,$0C,$0C Wulf (#SPRITENAME$50) in room #N$F6.
  $ACEF,$0C,$0C Hippo (#SPRITENAME$A0) in room #N$83.
  $ACFB,$0C,$0C The Guardian (#SPRITENAME$94) in room #N$88.

c $AD07 Handler: Rhino
@ $AD07 label=HandlerRhino
D $AD07 Handles a rhino (sprite IDs #N$30 to #N$33). Bit 1 of the sprite ID is
. set when the rhino is facing right.
. .
. The rhino moves with its X velocity (see #R$AFE8) and stops and turns
. around if it is blocked, when its speed is also reset. If it touches the
. player then the player is hurt and the rhino turns around, unless the player
. is attacking, in which case the rhino is knocked back instead (see
. #R$AD69).
R $AD07 IX Actor record of the rhino
  $AD07,$03 Remember the previous position of the rhino.
  $AD0A,$03 Animate the rhino.
  $AD0D,$05 Set the width of the rhino in #R$96AD to #N$20.
  $AD12,$03 Work out the new position of the rhino.
N $AD15 Stop the rhino moving through objects in the room. If it did not manage
. to move then turn it around.
  $AD15,$03 Set the height of the rhino in #REGb to #N$17 and the width in #REGc
. to #N$1F.
  $AD18,$03 Stop the rhino passing through objects in the room.
  $AD1B,$03 Test whether the rhino has stayed where it was.
  $AD1E,$02 Jump to #R$AD28 if the rhino has moved.
  $AD20,$02 Set the speed of the rhino in #REGa to #N$30.
  $AD22,$03 Set the speed of the rhino, keeping its direction.
  $AD25,$03 Turn the rhino around.
@ $AD28 label=HandlerRhino_Position
  $AD28,$03 Set the X position of the rhino.
  $AD2B,$03 Set the Y position of the rhino.
N $AD2E Test whether the rhino has touched the player.
  $AD2E,$03 Fetch the sprite ID of the rhino.
  $AD31,$01 Rotate right, so bit 1 is now in bit 0.
  $AD32,$02,b$01 Keep only bit 0.
  $AD34,$01 Store the result in #REGd (the hit direction for #R$AB36).
  $AD35,$03 Set the reach used to test whether the rhino is touching the player
. in #REGbc to #N$0F1C.
  $AD38,$03 Test whether the rhino is hurting the player.
  $AD3B,$02 Jump to #R$AD46 if the rhino is not touching the player.
  $AD3D,$03 Fetch the hit direction of the player from #R$9704.
  $AD40,$03 Jump to #R$AD69 if the player was not hit, which means the rhino was
. hit by the sword.
  $AD43,$03 Turn the rhino around.

c $AD46 Update Actor
@ $AD46 label=UpdateActor
D $AD46 Updates the display of an actor which has been moved. If the actor is in
. the same room as the player then it is drawn (see #R$AD57). If the actor is
. not in the room of the player but it was in the room last time (the room is
. held in #R$96A2) then it is removed from the screen.
R $AD46 IX Actor record
  $AD46,$03 Fetch the room of the player from #R$9703.
  $AD49,$01 Stash the room of the player in #REGc.
  $AD4A,$05 Jump to #R$AD57 if the actor is in the same room as the player.
  $AD4F,$03 Fetch the previous room of the actor from #R$96A2.
  $AD52,$02 Return if the actor was not in the room of the player.
  $AD54,$03 Jump to #R$B8F5 to remove the actor from the screen.

c $AD57 Update Actor In Room
@ $AD57 label=UpdateActorInRoom
D $AD57 Draws an actor which is in the same room as the player. If the actor
. was in the room last time then it is moved with #R$B9A9, otherwise it has
. just arrived and is drawn with #R$B919. The attributes of the actor are then
. set.
R $AD57 C Room of the player
R $AD57 IX Actor record
  $AD57,$03 Fetch the previous room of the actor from #R$96A2.
  $AD5A,$03 Jump to #R$AD63 if the actor has just arrived in the room.

c $AD5D Display Actor
@ $AD5D label=DisplayActor
D $AD5D Moves an actor on the screen and sets its attributes.
R $AD5D IX Actor record
  $AD5D,$03 Move the actor on the screen.
  $AD60,$03 Jump to #R$BB24 to colour the actor.

c $AD63 Draw Actor
@ $AD63 label=DrawActor
D $AD63 Draws an actor on the screen and sets its attributes.
R $AD63 IX Actor record
  $AD63,$03 Draw the actor on the screen.
  $AD66,$03 Jump to #R$BB24 to colour the actor.

c $AD69 Knock Back Rhino
@ $AD69 label=KnockBackRhino
D $AD69 Turns a rhino which has been hit by the sword of the player and sends it
. away from the player with a velocity of #N$60 (to the right) or #N$A0 (to the
. left), depending on which way the player is facing. A warble is played.
R $AD69 IX Actor record of the rhino
  $AD69,$03 Fetch the sprite ID of the player from #R$9702.
  $AD6C,$04 Jump to #R$AD7E if the player is attacking to the right (bit 3 of
. the sprite ID is set).
  $AD70,$04 Reset bit 1 of the sprite ID so the rhino faces left.
  $AD74,$02 Set the X velocity in #REGa to #N$A0 (moving left).
@ $AD76 label=KnockBackRhino_Velocity
  $AD76,$03 Set the X velocity of the rhino.
  $AD79,$03 Play the warble sound.
  $AD7C,$02 Jump to #R$AD46 to update the rhino.
@ $AD7E label=KnockBackRhino_Right
  $AD7E,$04 Set bit 1 of the sprite ID so the rhino faces right.
  $AD82,$02 Set the X velocity in #REGa to #N$60 (moving right).
  $AD84,$02 Jump to #R$AD76.

c $AD86 Set Velocity Magnitude
@ $AD86 label=SetVelocityMagnitude
D $AD86 Sets the speed of the X velocity of an actor but keeps the direction it
. is moving in.
R $AD86 A The speed
R $AD86 IX Actor record
  $AD86,$07 Jump to #R$AD8F if the actor is moving right.
  $AD8D,$02 Negate the speed.
@ $AD8F label=SetVelocityMagnitude_Store
  $AD8F,$03 Set the X velocity of the actor.
  $AD92,$01 Return.

c $AD93 Animate Rhino
@ $AD93 label=AnimateRhino
D $AD93 Every other frame, flips bit 0 of the sprite ID of an actor to give it
. the next frame of animation.
R $AD93 IX Actor record
  $AD93,$03 Fetch the low byte of the game timer from #R$9693.
  $AD96,$02,b$01 Keep only bit 0.
  $AD98,$01 Return if bit 0 is set (the actor only animates on alternate
. passes).
  $AD99,$03 Fetch the sprite ID of the actor.
  $AD9C,$02,b$01 Flip bit 0 to give the next frame of animation.
  $AD9E,$03 Set the new sprite ID of the actor.
  $ADA1,$01 Return.

c $ADA2 Turn Rhino Around
@ $ADA2 label=TurnRhinoAround
D $ADA2 Turns a rhino around, by flipping bit 1 of the sprite ID and reversing
. the X velocity.
R $ADA2 IX Actor record
  $ADA2,$03 Fetch the sprite ID of the rhino.
  $ADA5,$02,b$01 Flip bit 1 (the direction the rhino is facing).
  $ADA7,$03 Set the new sprite ID of the rhino.
@ $ADAA label=TurnRhinoAround_Velocity
  $ADAA,$03 Fetch the X velocity of the actor.
  $ADAD,$02 Reverse the X velocity.
  $ADAF,$03 Set the new X velocity of the actor.
  $ADB2,$01 Return.

c $ADB3 Turn Wulf Around
@ $ADB3 label=TurnWulfAround
D $ADB3 Turns a Wulf or a tribesman around, by flipping bit 2 of the sprite ID
. and reversing the X velocity.
R $ADB3 IX Actor record
  $ADB3,$03 Fetch the sprite ID of the actor.
  $ADB6,$02,b$01 Flip bit 2 (the direction the actor is facing).
  $ADB8,$03 Set the new sprite ID of the actor.
  $ADBB,$02 Jump to #R$ADAA to reverse the X velocity.

c $ADBD Handler: Empty
@ $ADBD label=HandlerEmpty
D $ADBD The handler for the sprite IDs which are not used. It does nothing.
  $ADBD,$01 Return.
  $ADBE,$01 Return.

c $ADBF Start Attack
@ $ADBF label=StartAttack
D $ADBF Turns a walking Sabreman into an attacking one with a sword. The new
. sprite ID is #N$20 to #N$2F and depends on the direction the player was
. facing.
R $ADBF IX Actor record of the player
  $ADBF,$03 Fetch the sprite ID of the player.
  $ADC2,$01 Rotate left, so that bit 2 (set when facing right or down) is moved
. into bit 3.
  $ADC3,$02,b$01 Keep only bits 0-3.
  $ADC5,$02,b$01 Set bit 5.
  $ADC7,$03 Set the new sprite ID of the player.
  $ADCA,$05 Set the width of an attacking player in #R$96AD to #N$18.
  $ADCF,$01 Return.

c $ADD0 Handler: Attacking Sabreman
@ $ADD0 label=PlayerMovement
D $ADD0 Handles the player while they are attacking with the sword (sprite IDs
. #N$20 to #N$2F). Bit 3 of the sprite ID is set when the player is attacking
. to the right.
. .
. While the player is holding down "fire" they can move about with a fixed
. speed in any direction. When "fire" is released, or if the player has an
. orchid effect, the player is made to walk again by #R$AE34. If the player
. has been hit (the hit direction in #REGix+#N$02 is not zero) then they are
. knocked back by #R$A985.
R $ADD0 IX Actor record of the player
  $ADD0,$03 Remember the previous position of the player.
  $ADD3,$03 Check the progress of the player.
  $ADD6,$05 Set the width of the player in #R$96AD to #N$10.
  $ADDB,$03 Fetch the hit direction of the player.
  $ADDE,$04 Jump to #R$A985 if the player has been hit.
N $ADE2 Initialise the player movement (#N($0000,$04,$04) == no movement).
  $ADE2,$03 Clear the movement of the player in #REGde.
N $ADE5 Read the controls.
  $ADE5,$03 Read the controls.
N $ADE8 Check if the player is under the influence of an orchid.
  $ADE8,$03 Fetch the colour of the player.
  $ADEB,$04 Jump to #R$AE34 if the player is not using attribute #COLOUR$47.
N $ADEF Check that "fire" is still being pressed.
  $ADEF,$04 Jump to #R$AE34 if "fire" is not being pressed.
N $ADF3 Handle "right".
  $ADF3,$04 Jump to #R$ADFB if "right" is not being pressed.
  $ADF7,$04 Add #N$20 to the X movement in #REGe.
N $ADFB Handle "left".
@ $ADFB label=PlayerMovement_Left
  $ADFB,$04 Jump to #R$AE03 if "left" is not being pressed.
  $ADFF,$04 Subtract #N$20 from the X movement in #REGe.
N $AE03 Handle "up".
@ $AE03 label=PlayerMovement_Up
  $AE03,$04 Jump to #R$AE0B if "up" is not being pressed.
  $AE07,$04 Subtract #N$20 from the Y movement in #REGd.
N $AE0B Handle "down".
@ $AE0B label=PlayerMovement_Down
  $AE0B,$04 Jump to #R$AE13 if "down" is not being pressed.
  $AE0F,$04 Add #N$20 to the Y movement in #REGd.
N $AE13 Update the player actor record and move the player.
@ $AE13 label=PlayerMovement_Move
  $AE13,$03 Set the X velocity of the player.
  $AE16,$03 Set the Y velocity of the player.
  $AE19,$03 Work out the new position of the player.
  $AE1C,$03 Set the height of the player in #REGb to #N$16 and the width in
. #REGc to #N$0E.
  $AE1F,$03 Stop the player passing through objects in the room.
  $AE22,$03 Animate the attacking player.
  $AE25,$03 Test whether the player has stayed where it was.
  $AE28,$03 Set the X position of the player.
  $AE2B,$03 Set the Y position of the player.
  $AE2E,$03 Play the footstep sound if the player moved.
  $AE31,$03 Jump to #R$AD5D to display the player.

c $AE34 Stop Attack
@ $AE34 label=StopAttack
D $AE34 Turns an attacking Sabreman back into a walking one, which faces right
. if the player was attacking to the right and left otherwise. The sprite IDs
. used are #N$14 and #N$10.
R $AE34 C The controls
R $AE34 DE The movement
R $AE34 IX Actor record of the player
  $AE34,$06 Jump to #R$AE47 if the player was attacking to the left (bit 3 of
. the sprite ID is reset).
  $AE3A,$02 Set the walking sprite ID in #REGa to #N$14.
@ $AE3C label=StopAttack_Sprite
  $AE3C,$03 Set the sprite ID of the player.
  $AE3F,$05 Set the width of the player in #R$96AD to #N$10.
  $AE44,$03 Jump to #R$AF1C to carry on with the controls.

c $AE47 Stop Attack Left
@ $AE47 label=StopAttackLeft
D $AE47 Used by #R$AE34 to use the sprite ID for a walking Sabreman which is
. facing left.
  $AE47,$02 Set the walking sprite ID in #REGa to #N$10.
  $AE49,$02 Jump to #R$AE3C.

c $AE4B Animate Attack
@ $AE4B label=AnimateAttack
D $AE4B Sets the direction and animation of an attacking Sabreman. If the X
. velocity is positive then bit 3 of the sprite ID is set and the player
. attacks to the right, and if it is negative then bit 3 is reset. Every four
. frames the sprite is changed to one of the first eight frames at random.
R $AE4B IX Actor record of the player
  $AE4B,$03 Fetch the X velocity of the player.
  $AE4E,$03 Jump to #R$AE5C if the player is not moving left or right.
  $AE51,$03 Jump to #R$AE73 if the player is moving left.
  $AE54,$03 Fetch the sprite ID of the player.
  $AE57,$02,b$01 Set bit 3 (attacking to the right).
@ $AE59 label=AnimateAttack_Store
  $AE59,$03 Set the new sprite ID of the player.
@ $AE5C label=AnimateAttack_Frame
  $AE5C,$03 Fetch the low byte of #SKOOLKID$5C78(FRAMES).
  $AE5F,$02,b$01 Keep only bits 0-1.
  $AE61,$01 Return if this is not every fourth frame.
  $AE62,$03 Fetch the sprite ID of the player into #REGc.
  $AE65,$03 Fetch the random seed from #R$9695.
  $AE68,$02,b$01 Keep only bits 0-2.
  $AE6A,$01 Stash the random animation frame in #REGb.
  $AE6B,$01 Fetch the sprite ID of the player.
  $AE6C,$02,b$01 Keep only bits 3-7.
  $AE6E,$01 Merge in the animation frame.
  $AE6F,$03 Set the new sprite ID of the player.
  $AE72,$01 Return.
@ $AE73 label=AnimateAttack_Left
  $AE73,$03 Fetch the sprite ID of the player.
  $AE76,$02,b$01 Keep only bits 0-2 and 4-7, which resets bit 3 (attacking to
. the left).
  $AE78,$02 Jump to #R$AE59.

c $AE7A Count Down Orchid Effect
@ $AE7A label=HandlerOrchidTimer
D $AE7A Every other frame, counts down the orchid effect timer in #R$96B0. When
. the timer reaches zero the player goes back to the normal colour. The zero
. flag is set when the timer is zero or has just reached zero.
R $AE7A IX Actor record of the player
R $AE7A O:F Zero flag set if the orchid effect is over
  $AE7A,$03 Fetch the low byte of #SKOOLKID$5C78(FRAMES).
  $AE7D,$02,b$01 Keep only bit 0.
  $AE7F,$01 Return every other frame.
  $AE80,$03 Fetch the orchid effect timer from #R$96B0.
N $AE83 See #POKE(always_walk_fast,Always walk fast).
  $AE83,$02 Return if there is no orchid effect.
  $AE85,$01 Decrease the orchid effect timer by one.
  $AE86,$03 Store the orchid effect timer in #R$96B0.
  $AE89,$01 Return if the orchid effect has not run out.
  $AE8A,$04 Set the colour of the player back to #COLOUR$47.
  $AE8E,$01 Return.

c $AE8F Start Yellow Orchid Effect
@ $AE8F label=HandlerYellowOrchid
D $AE8F Makes the player sit down because of the yellow orchid, for a time of
. #N$60 (the orchid effect timer). The sprite ID is #N$43 if the player is
. facing left or #N$47 if the player is facing right, and the player is then
. handled by #R$A61B.
R $AE8F IX Actor record of the player
N $AE8F Fetch the current sprite ID of Sabreman.
  $AE8F,$03 Fetch the sprite ID of the player.
N $AE92 This will leave either #N$00 or #N$04.
  $AE92,$02,b$01 Keep only bit 2.
N $AE94 Add on #N$43.
  $AE94,$02,b$01 Set bits 0-1, 6.
N $AE96 The resulting sprite ID will be either #R$D2B0(#SPRITENAME$43) or
. #R$D32A(#SPRITENAME($47)).
  $AE96,$03 Set the new sprite ID of the player.
  $AE99,$05 Set the orchid effect timer in #R$96B0 to #N$60.
  $AE9E,$03 Jump to #R$A61E to count down the orchid effect.

c $AEA1 Flash Score Label
@ $AEA1 label=ScoreLabelFlash
D $AEA1 Used while the game is waiting to start the active player. Makes a low
. tone every sixteen frames and flashes the score label of the active player
. ("1UP" or "2UP").
R $AEA1 HL Address of the delay counter in #R$96B5
E $AEA1 View the equivalent code in;
. #LIST
. { #COOKIE$7020 }
. { #LUNARJETMAN$8C3E }
. LIST#
  $AEA1,$01 Fetch the start-of-turn delay.
  $AEA2,$02,b$01 Keep only bits 0-3.
  $AEA4,$03 Play the low tone if the start-of-turn delay is a multiple of #N$10
. (every sixteenth frame).
  $AEA7,$06 Jump to #R$AECA to flash the 2UP score label if 2UP is the active
. player (#R$969E is not zero).
N $AEAD Flash 1UP score label.
  $AEAD,$03 #REGhl=#N($00,$02,$03),#N($10,$02,$03) (position of the 1UP score label).
N $AEB0 Set flash state for the 3-attributes of the score label.
@ $AEB0 label=FlashText
  $AEB0,$03 Find the attribute address of the score label.
  $AEB3,$02 Set the letter counter in #REGb to #N$03 (one for each letter of a
. score label).
@ $AEB5 label=FlashText_Loop
  $AEB5,$01 Fetch the attribute byte.
  $AEB6,$02,b$01 Ensure bit 7 is set (the flash bit).
  $AEB8,$01 Write the attribute byte back.
  $AEB9,$01 Move onto the next attribute.
  $AEBA,$02 Decrease the letter counter by one and loop back to #R$AEB5 until
. all three letters have been flashed.
  $AEBC,$01 Return.
N $AEBD Unset flash state for the 3-attributes of the score label.
@ $AEBD label=UnsetFlashText
  $AEBD,$03 Find the attribute address of the score label.
  $AEC0,$02 Set the letter counter in #REGb to #N$03 (one for each letter of a
. score label).
@ $AEC2 label=UnsetFlashText_Loop
  $AEC2,$01 Fetch the attribute byte.
  $AEC3,$02,b$01 Keep only bits 0-6 (i.e. everything except the flash bit).
  $AEC5,$01 Write the attribute byte back.
  $AEC6,$01 Move onto the next attribute.
  $AEC7,$02 Decrease the letter counter by one and loop back to #R$AEC2 until
. all three letters have been unflashed.
  $AEC9,$01 Return.
N $AECA Flash 2UP score label.
@ $AECA label=FlashScoreLabel2UP
  $AECA,$03 #REGhl=#N($00,$02,$03),#N($D8,$02,$03) (position of the 2UP score label).
  $AECD,$02 Jump to #R$AEB0.

c $AECF Game Play Entry
@ $AECF label=GamePlayEntry
D $AECF Handles Sabreman while walking (sprite IDs #N$10 to #N$1F), but first
. deals with the delay at the start of each turn. While the delay timer in
. #R$96B5 is running, the player is neither drawn nor controlled and the score
. label of the player is flashed by #R$AEA1. When the delay ends the flash
. is turned off, the player is drawn and the normal handling at #R$AEEF
. starts.
R $AECF IX Actor record of the player
E $AECF View the equivalent code in;
. #LIST
. { #COOKIE$7048 }
. { #JETPAC$73B2 }
. { #PSSST$6DBA }
. LIST#
  $AECF,$07 Jump to #R$AEEF if the start-of-turn delay in #R$96B5 is zero.
  $AED6,$01 Decrease the start-of-turn delay by one.
  $AED7,$02 Jump to #R$AEA1 to flash the score label if the start-of-turn delay
. is still running.
  $AED9,$06 Jump to #R$AEEA if 2UP is the active player (#R$969E is not zero).
N $AEDF Handle turning off flash for 1UP score label.
  $AEDF,$03 #REGhl=#N($00,$02,$03),#N($10,$02,$03) (position of the 1UP score label).
@ $AEE2 label=Game1UP_UnsetFlash
  $AEE2,$03 Stop the score label flashing.
  $AEE5,$03 Draw the player.
  $AEE8,$02 Jump to #R$AEEF.
N $AEEA Handle turning off flash for 2UP score label.
@ $AEEA label=Game2UP_UnsetFlash
  $AEEA,$03 #REGhl=#N($00,$02,$03),#N($D8,$02,$03) (position of 2UP label).
  $AEED,$02 Jump to #R$AEE2.

c $AEEF Game Play Start
@ $AEEF label=GamePlay_Start
D $AEEF Handles Sabreman while walking (sprite IDs #N$10 to #N$1F). The
. controls are read, with the effects of the orchids applied, and turned into
. an acceleration of #N$07 in each direction. The player is then moved, tested
. against the objects in the room and the walking animation is updated. If
. "fire" is pressed then the player starts to attack (see #R$ADBF). The
. velocities are then reduced by one so the player slides to a halt. Finally
. the player is displayed.
. .
. The effect of an orchid depends on the colour of the player: yellow
. (#COLOUR$46) makes the player sit down, magenta (#COLOUR$43) reverses the
. controls, red (#COLOUR$42) lowers the top speed and cyan (#COLOUR$45)
. increases the top speed. The colour white (#COLOUR$47) is normal.
R $AEEF IX Actor record of the player
  $AEEF,$03 Remember the previous position of the player.
N $AEF2 See #POKE(less_animals,Less Animals).
  $AEF2,$03 Check the progress of the player.
N $AEF5 Is Sabreman yellow?
  $AEF5,$03 Fetch the colour of the player.
  $AEF8,$04 Jump to #R$AE8F if the player is yellow (#COLOUR$46).
  $AEFC,$03 Count down the orchid effect.
  $AEFF,$05 Set the width of the player in #R$96AD to #N$10.
N $AF04 Check whether the player has been hit.
  $AF04,$03 Fetch the hit direction of the player.
  $AF07,$04 Jump to #R$A985 if the player has been hit.
  $AF0B,$03 Clear the movement of the player in #REGde.
  $AF0E,$03 Read the controls.
N $AF11 Is Sabreman magenta?
  $AF11,$03 Fetch the colour of the player.
  $AF14,$04 Jump to #R$AF1C if the player is not magenta (#COLOUR$43).
N $AF18 Handles reversing the controls as a result of the magenta orchid.
  $AF18,$01 Fetch the controls.
  $AF19,$02,b$01 Flip bits 0-3 (swapping left with right and up with down).
  $AF1B,$01 Store the reversed controls in #REGc.
@ $AF1C label=GamePlay_Controls
  $AF1C,$01 Fetch the controls.
  $AF1D,$03 Store the controls in #R$96AC.
N $AF20 Turn the controls into an acceleration in #REGe (X) and #REGd (Y).
  $AF20,$01 Fetch the X acceleration.
  $AF21,$02 Set the amount to accelerate by in #REGb to #N$07.
  $AF23,$04 Jump to #R$AF28 if "right" is not being pressed.
  $AF27,$01 Add the acceleration for "right".
@ $AF28 label=GamePlay_Left
  $AF28,$04 Jump to #R$AF2D if "left" is not being pressed.
  $AF2C,$01 Subtract the acceleration for "left".
@ $AF2D label=GamePlay_AccelerationX
  $AF2D,$01 Store the X acceleration in #REGe.
  $AF2E,$01 Fetch the Y acceleration.
  $AF2F,$04 Jump to #R$AF34 if "down" is not being pressed.
  $AF33,$01 Add the acceleration for "down".
@ $AF34 label=GamePlay_Up
  $AF34,$04 Jump to #R$AF39 if "up" is not being pressed.
  $AF38,$01 Subtract the acceleration for "up".
@ $AF39 label=GamePlay_AccelerationY
  $AF39,$01 Store the Y acceleration in #REGd.
  $AF3A,$03 Accelerate the player.
  $AF3D,$03 Work out the new position of the player.
  $AF40,$03 Set the height of the player in #REGb to #N$16 and the width in
. #REGc to #N$0E.
  $AF43,$03 Stop the player passing through objects in the room.
  $AF46,$03 Update the direction the player is facing.
  $AF49,$03 Test whether the player has stayed where it was.
  $AF4C,$03 Set the X position of the player.
  $AF4F,$03 Set the Y position of the player.
  $AF52,$03 Play the footstep sound if the player has moved.
N $AF55 Is Sabreman white?
  $AF55,$03 Fetch the colour of the player.
  $AF58,$04 Jump to #R$AF66 if the player is not white (#COLOUR$47).
  $AF5C,$03 Fetch the controls from #R$96AC.
  $AF5F,$04 Jump to #R$AF66 if "fire" is not being pressed.
  $AF63,$03 Start an attack.
N $AF66 Reduce the velocities by one.
@ $AF66 label=GamePlay_Friction
  $AF66,$03 Fetch the X velocity of the player.
  $AF69,$02 Set the amount to reduce the velocity by in #REGb to #N$01.
  $AF6B,$03 Reduce the X velocity.
  $AF6E,$03 Set the new X velocity of the player.
  $AF71,$03 Fetch the Y velocity of the player.
  $AF74,$03 Reduce the Y velocity.
  $AF77,$03 Set the new Y velocity of the player.
N $AF7A Display the player. While an orchid effect is about to wear off (the
. timer in #R$96B0 is below #N$2F) the player flashes between the colour of
. the orchid and white, with a sound at the start of each phase.
@ $AF7A label=GamePlay_Display
  $AF7A,$03 Move the player on the screen.
  $AF7D,$03 Fetch the orchid effect timer from #R$96B0.
  $AF80,$04 Jump to #R$BB24 to colour the player if there is no orchid effect.
  $AF84,$05 Jump to #R$BB24 to colour the player if the orchid effect timer is
. #N$2F or more.
  $AF89,$02,b$01 Keep only bits 0-3.
  $AF8B,$04 Jump to #R$AFA4 if bit 3 of the orchid effect timer is set.
  $AF8F,$02,b$01 Keep only bits 0-2.
  $AF91,$03 Play the orchid flash beep if the timer is at the start of the white
. phase.
  $AF94,$03 Fetch the colour of the player (the colour of the orchid).
  $AF97,$01 Stash the colour of the orchid on the stack.
  $AF98,$04 Set the colour of the player to #COLOUR$47.
  $AF9C,$03 Colour the player.
  $AF9F,$01 Restore the colour of the orchid from the stack.
  $AFA0,$03 Set the colour of the player back to the colour of the orchid.
  $AFA3,$01 Return.
N $AFA4 The player is drawn in the colour of the orchid.
@ $AFA4 label=GamePlay_OrchidPhase
  $AFA4,$02,b$01 Keep only bits 0-2.
  $AFA6,$03 Play the orchid flash beep if the timer is at the start of the
. orchid phase.
  $AFA9,$03 Jump to #R$BB24 to colour the player.

c $AFAC Accelerate Player
@ $AFAC label=AcceleratePlayer
D $AFAC Adds an acceleration to the velocity of the player in both directions
. and limits the result to the top speed (see #R$AFC1).
R $AFAC D Y acceleration
R $AFAC E X acceleration
R $AFAC IX Actor record of the player
  $AFAC,$01 Fetch the X acceleration.
  $AFAD,$03 Add the X velocity of the player.
  $AFB0,$03 Limit the X velocity.
  $AFB3,$03 Set the new X velocity of the player.
  $AFB6,$01 Fetch the Y acceleration.
  $AFB7,$03 Add the Y velocity of the player.
  $AFBA,$03 Limit the Y velocity.
  $AFBD,$03 Set the new Y velocity of the player.
  $AFC0,$01 Return.

c $AFC1 Limit Player Velocity
@ $AFC1 label=LimitPlayerVelocity
D $AFC1 Limits a velocity to the top speed of the player, which depends on the
. colour of the player. The top speed is #N$20 for red (#COLOUR$42), #N$40 for
. cyan (#COLOUR$45) and #N$30 otherwise. The velocity may be negative.
R $AFC1 A Velocity
R $AFC1 IX Actor record of the player
R $AFC1 O:A The limited velocity
  $AFC1,$01 Stash the velocity on the stack.
  $AFC2,$03 Fetch the colour of the player.
  $AFC5,$04 Jump to #R$AFE0 if the player is red (#COLOUR$42), which slows the
. player.
  $AFC9,$04 Jump to #R$AFE4 if the player is cyan (#COLOUR$45), which speeds the
. player up.
  $AFCD,$02 Set the normal maximum speed in #REGb to #N$30.
@ $AFCF label=LimitPlayerVelocity_Restore
  $AFCF,$01 Restore the velocity from the stack.

c $AFD0 Limit Velocity
@ $AFD0 label=LimitVelocity
D $AFD0 Limits a signed velocity to a maximum speed.
R $AFD0 A Velocity
R $AFD0 B Maximum speed
R $AFD0 O:A The limited velocity
  $AFD0,$03 Jump to #R$AFD7 if the velocity is negative.
  $AFD3,$02 Return if the velocity is less than the maximum speed.
  $AFD5,$01 Limit the velocity to the maximum speed.
  $AFD6,$01 Return.
@ $AFD7 label=LimitVelocity_Negative
  $AFD7,$02 Make the velocity positive.
  $AFD9,$03 Jump to #R$AFDD if the speed is less than the maximum speed.
  $AFDC,$01 Limit the speed to the maximum speed.
@ $AFDD label=LimitVelocity_Restore
  $AFDD,$02 Make the velocity negative again.
  $AFDF,$01 Return.

c $AFE0 Set Slow Speed Limit
@ $AFE0 label=SetSlowSpeedLimit
D $AFE0 Used by #R$AFC1 for the red orchid effect.
  $AFE0,$02 Set the slow maximum speed in #REGb to #N$20.
  $AFE2,$02 Jump to #R$AFCF.

c $AFE4 Set Fast Speed Limit
@ $AFE4 label=SetFastSpeedLimit
D $AFE4 Used by #R$AFC1 for the cyan orchid effect.
  $AFE4,$02 Set the fast maximum speed in #REGb to #N$40.
  $AFE6,$02 Jump to #R$AFCF.

c $AFE8 Move Actor
@ $AFE8 label=MoveActor
D $AFE8 Works out the new position of an actor from its velocities. The
. velocities are signed and in units of one sixteenth of a pixel, so they are
. first scaled by #R$B031. The new position is returned in #REGe and #REGd and
. is not written to the actor record.
. .
. If the actor would move off the screen it is moved to the neighbouring room
. instead, using #R$B187 (left), #R$B19F (right), #R$B12F (below) or #R$B1AB
. (above). The top of the screen is at #N$28, the bottom at #N$C0 and the
. width of the actor (held in #R$96AD) is taken into account at the right.
R $AFE8 IX Actor record
R $AFE8 O:D New Y position
R $AFE8 O:E New X position
  $AFE8,$06 Store the room of the actor in #R$96AB.
  $AFEE,$03 Fetch the Y position of the actor into #REGd.
  $AFF1,$03 Fetch the X velocity of the actor.
  $AFF4,$03 Convert the X velocity to whole pixels.
  $AFF7,$04 Jump to #R$B01A if the actor is moving left.
N $AFFB The actor is moving right.
  $AFFB,$03 Add the X position of the actor.
  $AFFE,$01 Stash the new X position in #REGe.
  $AFFF,$03 Fetch the width of the actor from #R$96AD.
  $B002,$01 Add the new X position to find the right edge of the actor.
  $B003,$03 Jump to #R$B19F if the actor has left the screen on the right.
@ $B006 label=MoveActor_Vertical
N $B006 Now move the actor up or down.
  $B006,$03 Fetch the Y velocity of the actor.
  $B009,$03 Convert the Y velocity to whole pixels.
  $B00C,$04 Jump to #R$B027 if the actor is moving up.
  $B010,$03 Add the Y position of the actor.
  $B013,$01 Stash the new Y position in #REGd.
  $B014,$05 Jump to #R$B12F if the actor has left the screen at the bottom.
  $B019,$01 Return.

c $B01A Move Actor Left
@ $B01A label=MoveActorLeft
D $B01A Used by #R$AFE8 when the actor is moving left. The new X position is
. found by taking the speed away from the current position. If it goes below
. zero the actor has moved into the room on the left.
R $B01A A X velocity in pixels (negative)
R $B01A D New Y position
R $B01A IX Actor record
  $B01A,$02 Make the speed positive.
  $B01C,$01 Stash the speed in #REGe.
  $B01D,$03 Fetch the X position of the actor.
  $B020,$01 Subtract the speed.
  $B021,$01 Stash the new X position in #REGe.
  $B022,$03 Jump to #R$B187 if the actor has left the screen on the left.
  $B025,$02 Jump to #R$B006 to move the actor vertically.

c $B027 Move Actor Up
@ $B027 label=MoveActorUp
D $B027 Used by #R$AFE8 when the actor is moving up. If the new Y position is
. less than #N$28 the actor has moved into the room above.
R $B027 A Y velocity in pixels (negative)
R $B027 E New X position
R $B027 IX Actor record
  $B027,$03 Add the Y position of the actor.
  $B02A,$01 Stash the new Y position in #REGd.
  $B02B,$05 Jump to #R$B1AB if the actor has left the screen at the top.
  $B030,$01 Return.

c $B031 Get Whole Pixels
@ $B031 label=GetWholePixels
D $B031 Divides a signed velocity by sixteen, to give the number of whole
. pixels to move. The direction is kept. For example, #N$30 gives #N$03 and
. #N$D0 (-#N$30) gives #N$FD (-#N$03).
R $B031 A Velocity
R $B031 O:A Pixels to move
E $B031 View the equivalent code in;
. #LIST
. { #ATICATAC$8F80 }
. LIST#
  $B031,$04 Jump to #R$B040 if the velocity is positive.
  $B035,$02 Make the velocity positive.
  $B037,$04 Divide by sixteen (by rotating right four times).
  $B03B,$02,b$01 Keep only bits 0-3.
  $B03D,$02 Make the result negative again.
  $B03F,$01 Return.
@ $B040 label=GetWholePixels_Positive
  $B040,$04 Divide by sixteen (by rotating right four times).
  $B044,$02,b$01 Keep only bits 0-3.
  $B046,$01 Return.

c $B047 Reduce Velocity
@ $B047 label=ReduceVelocity
D $B047 Moves a signed velocity towards zero by a given amount. It will not go
. past zero.
R $B047 A Velocity
R $B047 B Amount to reduce the speed by
R $B047 O:A The new velocity
  $B047,$04 Jump to #R$B04F if the velocity is positive.
  $B04B,$01 Add the amount to reduce the velocity by to the negative velocity.
  $B04C,$01 Return if the velocity is still negative.
  $B04D,$01 Set the velocity to zero.
  $B04E,$01 Return.
@ $B04F label=ReduceVelocity_Positive
  $B04F,$01 Subtract the amount to reduce the velocity by from the positive
. velocity.
  $B050,$01 Return if the velocity is still positive.
  $B051,$01 Set the velocity to zero.
  $B052,$01 Return.

c $B053 Update Player Direction
@ $B053 label=UpdatePlayerDirection
D $B053 Sets the direction the player faces to match the way the player has
. moved. Bits 2-3 of the sprite ID hold the direction: #N$00 is left, #N$04
. is right, #N$08 is up and #N$0C is down. The vertical movement is tested
. first, so if the player has moved both horizontally and vertically then the
. horizontal direction is used. The walking animation is also advanced (see
. #R$B078).
R $B053 D New Y position
R $B053 E New X position
R $B053 IX Actor record of the player
  $B053,$03 Animate the walking player.
  $B056,$01 Fetch the new Y position.
  $B057,$05 Jump to #R$B066 if the player has not moved up or down.
  $B05C,$03 Fetch the sprite ID of the player.
  $B05F,$02 Jump to #R$B099 if the player has moved up.
  $B061,$02,b$01 Set bits 2-3, so the player faces down.
@ $B063 label=UpdatePlayerDirection_Store
  $B063,$03 Set the new sprite ID of the player.
@ $B066 label=UpdatePlayerDirection_Horizontal
  $B066,$01 Fetch the new X position.
  $B067,$04 Return if the player has not moved left or right.
  $B06B,$03 Fetch the sprite ID of the player.
  $B06E,$02 Jump to #R$B09F if the player has moved left.
  $B070,$02,b$01 Keep only bits 0-1, 4-7.
  $B072,$02,b$01 Set bit 2, so the player faces right.
@ $B074 label=UpdatePlayerDirection_Write
  $B074,$03 Set the new sprite ID of the player.
  $B077,$01 Return.

c $B078 Animate Walk
@ $B078 label=AnimateWalk
D $B078 Every other frame, if the player has moved, adds one to the animation
. frame in bits 0-1 of the sprite ID (wrapping from #N$03 round to #N$00).
R $B078 D New Y position
R $B078 E New X position
R $B078 IX Actor record of the player
  $B078,$03 Fetch the low byte of #SKOOLKID$5C78(FRAMES).
  $B07B,$02,b$01 Keep only bit 0.
  $B07D,$01 Return if this is an odd frame.
  $B07E,$01 Fetch the new Y position.
  $B07F,$03 Find the difference from the Y position of the player.
  $B082,$01 Stash the Y difference in #REGc.
  $B083,$01 Fetch the new X position.
  $B084,$03 Find the difference from the X position of the player.
  $B087,$02 Return if the player has not moved.
  $B089,$03 Fetch the sprite ID of the player.
  $B08C,$01 Stash the sprite ID in #REGc.
  $B08D,$01 Move on to the next frame of animation.
  $B08E,$02,b$01 Keep only bits 0-1.
  $B090,$01 Stash the new frame in #REGb.
  $B091,$01 Fetch the old sprite ID.
  $B092,$02,b$01 Keep only bits 2-7.
  $B094,$01 Merge in the new frame.
  $B095,$03 Set the new sprite ID of the player.
  $B098,$01 Return.

c $B099 Face Up
@ $B099 label=FaceUp
D $B099 Used by #R$B053 to set the direction of the sprite to up.
R $B099 A Sprite ID
R $B099 IX Actor record of the player
  $B099,$02,b$01 Keep only bits 0-1, 4-7.
  $B09B,$02,b$01 Set bit 3.
  $B09D,$02 Jump to #R$B063.

c $B09F Face Left
@ $B09F label=FaceLeft
D $B09F Used by #R$B053 to set the direction of the sprite to left.
R $B09F A Sprite ID
R $B09F IX Actor record of the player
  $B09F,$02,b$01 Keep only bits 0-1, 4-7.
  $B0A1,$02 Jump to #R$B074.

c $B0A3 Handler: Controls
@ $B0A3 label=HandlerControls
D $B0A3 Reads the controls using the method chosen in the game options (see
. #R$9692): the keyboard, a Kempston joystick, a Cursor joystick or an
. Interface II joystick. Each of the routines returns the controls in #REGc,
. with a bit set for each direction or button pressed.
. #TABLE(default,centre,centre)
. { =h Bit | =h Action }
. { 0 | Left }
. { 1 | Right }
. { 2 | Up }
. { 3 | Down }
. { 4 | Fire }
. TABLE#
E $B0A3 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$8F90 }
. LIST#
R $B0A3 O:C Controls
E $B0A3 Else, handle Interface II joystick - it's the only option left.
E $B0A3 Continue on to #R$B0B1.
  $B0A3,$03 Fetch the game options from #R$9692.
  $B0A6,$01 Rotate out the number of players bit (bit 0).
  $B0A7,$02,b$01 Keep only bits 0-1 (Kempston and Cursor joystick options).
  $B0A9,$02 Jump to #R$B0FA if the keyboard was selected (both control bits are
. reset).
  $B0AB,$03 Jump to #R$B0D9 if the Kempston joystick was selected.
  $B0AE,$03 Jump to #R$B103 if the Cursor joystick was selected.

c $B0B1 Controls: Interface II Joystick
@ $B0B1 label=ReadInterfaceIIJoystick
D $B0B1 Reads an Interface II joystick, which is mapped onto the keys "6" to
. "0".
R $B0B1 O:A Joystick controls
R $B0B1 O:C Joystick controls
N $B0B1 Initialise the controls as "none" in #REGc.
  $B0B1,$02 Clear the controls in #REGc.
  $B0B3,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
N $B0B9 Check joystick "FIRE".
@ $B0B9 label=ReadInterfaceIIJoystick_Fire
  $B0B9,$04 Jump to #R$B0BF if "FIRE" (key "0") is not being pressed.
  $B0BD,$02 Set the "FIRE" bit (bit 4) of the controls in #REGc.
N $B0BF Check joystick "UP".
@ $B0BF label=ReadInterfaceIIJoystick_Up
  $B0BF,$04 Jump to #R$B0C5 if "UP" (key "9") is not being pressed.
  $B0C3,$02 Set the "UP" bit (bit 2) of the controls in #REGc.
N $B0C5 Check joystick "DOWN".
@ $B0C5 label=ReadInterfaceIIJoystick_Down
  $B0C5,$04 Jump to #R$B0CB if "DOWN" (key "8") is not being pressed.
  $B0C9,$02 Set the "DOWN" bit (bit 3) of the controls in #REGc.
N $B0CB Check joystick "RIGHT".
@ $B0CB label=ReadInterfaceIIJoystick_Right
  $B0CB,$04 Jump to #R$B0D1 if "RIGHT" (key "7") is not being pressed.
  $B0CF,$02 Set the "RIGHT" bit (bit 1) of the controls in #REGc.
N $B0D1 Check joystick "LEFT".
@ $B0D1 label=ReadInterfaceIIJoystick_Left
  $B0D1,$04 Jump to #R$B0D7 if "LEFT" (key "6") is not being pressed.
  $B0D5,$02 Set the "LEFT" bit (bit 0) of the controls in #REGc.
@ $B0D7 label=HandlerInterfaceIIJoystick
  $B0D7,$01 Fetch the controls.
  $B0D8,$01 Return.

c $B0D9 Controls: Kempston Joystick
@ $B0D9 label=ReadKempstonJoystick
D $B0D9 Reads a Kempston joystick from port #N$1F. A bit is set in the port for
. each direction or button pressed, which is moved onto the matching bit of
. the controls.
E $B0D9 View the equivalent code in;
. #LIST
. { #COOKIE$6FB0 }
. { #JETPAC$733A }
. { #LUNARJETMAN$8F9B }
. { #MARTIANOIDS$B0B4 }
. { #PSSST$75CC }
. { #TRANZAM$6188 }
. LIST#
R $B0D9 O:A Joystick controls
R $B0D9 O:C Joystick controls
  $B0D9,$02 Read the joystick port into #REGa.
N $B0DB Initialise the controls as "none" in #REGc.
  $B0DB,$02 Clear the controls in #REGc.
N $B0DD Check joystick "RIGHT".
@ $B0DD label=ReadKempstonJoystick_Right
  $B0DD,$04 Jump to #R$B0E3 if "RIGHT" is not being pressed.
  $B0E1,$02 Set the "RIGHT" bit (bit 1) of the controls in #REGc.
N $B0E3 Check joystick "LEFT".
@ $B0E3 label=ReadKempstonJoystick_Left
  $B0E3,$04 Jump to #R$B0E9 if "LEFT" is not being pressed.
  $B0E7,$02 Set the "LEFT" bit (bit 0) of the controls in #REGc.
N $B0E9 Check joystick "DOWN".
@ $B0E9 label=ReadKempstonJoystick_Down
  $B0E9,$04 Jump to #R$B0EF if "DOWN" is not being pressed.
  $B0ED,$02 Set the "DOWN" bit (bit 3) of the controls in #REGc.
N $B0EF Check joystick "UP".
@ $B0EF label=ReadKempstonJoystick_Up
  $B0EF,$04 Jump to #R$B0F5 if "UP" is not being pressed.
  $B0F3,$02 Set the "UP" bit (bit 2) of the controls in #REGc.
N $B0F5 Check joystick "FIRE".
@ $B0F5 label=ReadKempstonJoystick_Fire
  $B0F5,$02,b$01 Keep only bit 4 ("FIRE").
  $B0F7,$02 Merge the other controls into the "FIRE" bit and store the controls
. in #REGc.
  $B0F9,$01 Return.

c $B0FA Controls: Keyboard
@ $B0FA label=ReadKeyboard
D $B0FA Reads the keys "Q", "W", "E", "R" and "T" and uses them directly as the
. controls, so "Q" is left, "W" is right, "E" is up, "R" is down and "T" is
. fire.
E $B0FA View the equivalent code in;
. #LIST
. { #LUNARJETMAN$8F9F }
. LIST#
R $B0FA O:C Keyboard controls
  $B0FA,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FB | Q | W | E | R | T }
. TABLE#
  $B100,$01 Flip the bits.
  $B101,$01 Store the controls in #REGc.
  $B102,$01 Return.

c $B103 Controls: Cursor Joystick
@ $B103 label=ReadCursorJoystick
D $B103 Reads a Cursor joystick, which is mapped onto the keys "5" to "8" and
. "0".
E $B103 View the equivalent code in;
. #LIST
. { #COOKIE$6FD7 }
. { #LUNARJETMAN$8F6A }
. LIST#
R $B103 O:C Joystick controls
N $B103 Initialise the controls as "none" in #REGc.
  $B103,$02 Clear the controls in #REGc.
N $B105 The cursor keys are covered by different ports.
@ $B105 label=HandleCursorJoystick_Port_F7
  $B105,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
N $B10B Check joystick "LEFT".
@ $B10B label=ReadCursorJoystick_Left
  $B10B,$04 Jump to #R$B111 if "LEFT" (key "5") is not being pressed.
  $B10F,$02 Set the "LEFT" bit (bit 0) of the controls in #REGc.
N $B111 Handle the other port.
@ $B111 label=HandleCursorJoystick_Port_EF
  $B111,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
N $B117 Check joystick "DOWN".
@ $B117 label=ReadCursorJoystick_Down
  $B117,$04 Jump to #R$B11D if "DOWN" (key "6") is not being pressed.
  $B11B,$02 Set the "DOWN" bit (bit 3) of the controls in #REGc.
N $B11D Check joystick "UP".
@ $B11D label=ReadCursorJoystick_Up
  $B11D,$04 Jump to #R$B123 if "UP" (key "7") is not being pressed.
  $B121,$02 Set the "UP" bit (bit 2) of the controls in #REGc.
N $B123 Check joystick "RIGHT".
@ $B123 label=ReadCursorJoystick_Right
  $B123,$04 Jump to #R$B129 if "RIGHT" (key "8") is not being pressed.
  $B127,$02 Set the "RIGHT" bit (bit 1) of the controls in #REGc.
N $B129 Check joystick "FIRE".
@ $B129 label=ReadCursorJoystick_Fire
  $B129,$03 Return if "FIRE" (key "0") is not being pressed.
  $B12C,$02 Set the "FIRE" bit (bit 4) of the controls in #REGc.
  $B12E,$01 Return.

c $B12F Enter Room Below
@ $B12F label=EnterRoomBelow
D $B12F Used by #R$AFE8 when an actor has gone off the bottom of the screen.
. The actor is put at the top of the room below (the room number increases by
. #N$10) and its X position is changed to the entry point of the room, which
. is held in #R$6036 for the layout of the room (see #R$6066).
. .
. If the actor is not the player (the sprite ID is not #N$10 to #N$2F) then
. that is all. If it is the player then the new room is drawn and the delay
. before the flames appear is started.
R $B12F IX Actor record
R $B12F O:D New Y position
R $B12F O:E New X position
  $B12F,$02 Set the Y position to the top of the play area (#N$27).
  $B131,$03 Fetch the room of the actor.
  $B134,$02 Move to the room below.
  $B136,$03 Set the new room of the actor.
  $B139,$03 Use the room as the offset into the layout table.
  $B13C,$04 Add the layout table at #R$6066 to get the address of the layout
. number.
  $B140,$01 Fetch the layout number of the room.
  $B141,$02 Clear #REGh.
  $B143,$04 Add the table of entry X positions at #R$6036 to get the address of
. the X position.
  $B147,$01 Fetch the X position at which the actor enters the room.
N $B148 This is where the other routines to enter a room join in.
@ $B148 label=EnterRoom
  $B148,$03 Fetch the sprite ID of the actor.
  $B14B,$02 Subtract #N$10 (the first Sabreman sprite ID).
  $B14D,$03 Return if the actor is not the player.
  $B150,$01 Stash the new position on the stack.
  $B151,$03 Clear the attribute buffer of the play area.
  $B154,$03 Clear the play area.
  $B157,$03 Draw the new room.
  $B15A,$03 Remember the previous position of the player.
  $B15D,$03 Draw the player.
  $B160,$03 Mark the new room as visited.
  $B163,$01 Restore the new position from the stack.
  $B164,$05 Set the flame spawn delay in #R$96B4 to #N$80.
  $B169,$01 Return.

u $B16A Update Moved Actor
D $B16A This code is not used. If the actor was in the room of the player (the
. room saved in #R$96AB) then it is removed from the screen. If the actor is
. now in the room of the player then it is drawn and stored.
R $B16A DE Position of the actor
R $B16A IX Actor record
  $B16A,$03 #REGa=*#R$96AB.
  $B16D,$01 Store the room in #REGb.
  $B16E,$03 #REGa=*#R$9703 (the room of the player).
  $B171,$01 Compare with the room in #REGb.
  $B172,$01 Stash #REGde on the stack.
  $B173,$03 Call #R$B8F5 if the actor was in the room of the player.
  $B176,$01 Restore #REGde from the stack.
  $B177,$03 #REGa=*#R$9703 (the room of the player).
  $B17A,$03 Compare with #REGix+#N$01 (the room of the actor).
  $B17D,$01 Return if the actor is not in the room of the player.
  $B17E,$01 Stash #REGde on the stack.
  $B17F,$03 Draw the actor.
  $B182,$03 Remember the position of the actor.
  $B185,$01 Restore #REGde from the stack.
  $B186,$01 Return.

c $B187 Enter Room Left
@ $B187 label=EnterRoomLeft
D $B187 Used by #R$AFE8 when an actor has gone off the left of the screen. The
. actor is put at the right of the room to the left (the room number is one
. less, but the room stays in the same row of the map) and its X position is
. set so that its right edge is at the edge of the screen.
R $B187 IX Actor record
R $B187 O:E New X position
  $B187,$03 Fetch the width of the actor from #R$96AD.
  $B18A,$02 Negate the width.
  $B18C,$01 Subtract one.
  $B18D,$01 Stash the new X position in #REGe.
  $B18E,$03 Fetch the room of the actor.
  $B191,$01 Stash the room in #REGc.
  $B192,$01 Move to the room on the left.
@ $B193 label=EnterRoomLeft_Row
  $B193,$02,b$01 Keep only bits 0-3 (the column).
  $B195,$01 Stash the column in #REGb.
  $B196,$01 Fetch the old room.
  $B197,$02,b$01 Keep only bits 4-7 (the row).
  $B199,$01 Merge in the new column.
  $B19A,$03 Set the new room of the actor.
  $B19D,$02 Jump to #R$B148.

c $B19F Enter Room Right
@ $B19F label=EnterRoomRight
D $B19F Used by #R$AFE8 when an actor has gone off the right of the screen. The
. actor is put at the left of the room to the right (the room number is one
. more, but the room stays in the same row of the map).
R $B19F IX Actor record
R $B19F O:E New X position
  $B19F,$02 Set the X position to the left edge of the screen (#N$00).
  $B1A1,$03 Fetch the room of the actor.
  $B1A4,$01 Stash the room in #REGc.
  $B1A5,$01 Move to the room on the right.
  $B1A6,$03 Set the new room of the actor.
  $B1A9,$02 Jump to #R$B193.

c $B1AB Enter Room Above
@ $B1AB label=EnterRoomAbove
D $B1AB Used by #R$AFE8 when an actor has gone off the top of the screen. The
. actor is put at the bottom of the room above (the room number decreases by
. #N$10) without changing its X position.
R $B1AB IX Actor record
R $B1AB O:D New Y position
  $B1AB,$02 Set the Y position to the bottom of the play area (#N$BF).
  $B1AD,$03 Fetch the room of the actor.
  $B1B0,$02 Subtract #N$10 to move to the room above.
  $B1B2,$03 Set the new room of the actor.
  $B1B5,$02 Jump to #R$B148.

c $B1B7 Start Turn
@ $B1B7 label=StartTurn
D $B1B7 Sets up the delays at the start of a turn of a player, removes any
. orchid effect, takes one life from the player and displays the new number of
. lives. The start-of-turn delay (#R$96B5) is also what flashes the score
. label of the player (see #R$AECF).
  $B1B7,$03 Point #REGhl at the player's actor at #R$9702.
  $B1BA,$05 Set the nastie spawn delay in #R$96B1 to #N$10.
  $B1BF,$05 Set the flame spawn delay in #R$96B4 to #N$80.
  $B1C4,$05 Set the start-of-turn delay in #R$96B5 to #N$80.
  $B1C9,$04 Clear the orchid effect timer in #R$96B0.
  $B1CD,$03 Point #REGhl at the number of lives at #R$96BD.
N $B1D0 See #POKE(infinite_lives_player_2,Infinite Lives Player 2).
  $B1D0,$01 Decrease the number of lives by one.
  $B1D1,$03 Jump to #R$B7CD to update the lives display.

c $B1D4 Initialise Game
@ $B1D4 label=InitialiseGame
D $B1D4 Sets up the state of both players ready for a new game, builds the first
. room and starts the turn of player 1. A one player game gives player 2 no
. lives.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$B1D4 }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SCR$01(initialise-game-before)
. | #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #SCR$01(initialise-game-after) } UDGTABLE# #POPS
N $B1D4 Initialise player 2.
  $B1D4,$03 Initialise the player.
  $B1D7,$03 Swap over to the other player.
N $B1DA Initialise player 1.
  $B1DA,$03 Initialise the player.
N $B1DD Always start on player 1.
  $B1DD,$04 Set the active player to 1UP in #R$969E.
  $B1E1,$03 Clear the attribute buffer of the play area.
  $B1E4,$03 Clear the play area.
  $B1E7,$03 Fetch the game options from #R$9692.
  $B1EA,$02,b$01 Keep only bit 0.
  $B1EC,$02 Jump to #R$B1F1 if this is a two player game.
  $B1EE,$03 Set the number of lives of player 2 in #R$96E0 to zero.
N $B1F1 This is also where the next player joins in after the other player has
. died.
@ $B1F1 label=InitialiseGame_StartTurn
  $B1F1,$03 Start the turn.
  $B1F4,$04 Point #REGix at the player's actor at #R$9702.
  $B1F8,$03 Mark the room as visited.
  $B1FB,$03 Load the orchid for the room.
  $B1FE,$03 Set up the objects in the room.
  $B201,$03 Draw the current room.
  $B204,$01 Return.

c $B205 Switch Player
@ $B205 label=SwitchPlayer
D $B205 Used when a player has died in a two player game. Swaps over the state
. of the two players, clears the screen and makes the new player stand up with
. the normal colour, then carries on at #R$B1F1.
  $B205,$03 Swap over the states of the two players.
  $B208,$03 Clear the attribute buffer of the play area.
  $B20B,$03 Clear the play area.
  $B20E,$03 Fetch the sprite ID of the player.
  $B211,$02,b$01 Keep only bits 0-2.
  $B213,$02,b$01 Set bit 4, giving a sprite ID of #N$10 to #N$17.
  $B215,$03 Set the new sprite ID of the player.
  $B218,$04 Set the colour of the player to #COLOUR$47.
  $B21C,$02 Jump to #R$B1F1 to start the turn.

c $B21E Initialise Player
@ $B21E label=InitialisePlayer
D $B21E Sets up the state of the current player: five lives, a limit of three
. nasties per room, and a new set of actors, amulet pieces and room objects.
N $B21E Set starting lives.
  $B21E,$05 Set the number of lives in #R$96BD to #N$05.
  $B223,$05 Set the nastie limit in #R$96BE to #N$03.
  $B228,$04 Clear #R$96BC (purpose not yet known, as this is never read).
  $B22C,$03 Reset the actors.
  $B22F,$03 Place the amulet pieces.
  $B232,$03 Jump to #R$A2BD to generate the objects in the rooms.

c $B235 1UP/ 2UP Swapper
@ $B235 label=ChangePlayer
D $B235 Swaps over the state of player 1 and player 2, by swapping three blocks
. of memory with the stored copy for the other player. The active player flag
. in #R$969E is also flipped. The blocks swapped are:
. #TABLE(default,centre,centre,centre)
. { =h Active | =h Stored | =h Bytes }
. { #R$96BC | #R$96DF | #N($0023,$04,$04) }
. { #R$DDEC | #R$DFEC | #N($0200,$04,$04) }
. { #R$9702 | #R$982E | #N($012C,$04,$04) }
. TABLE#
E $B235 View the equivalent code in;
. #LIST
. { #COOKIE$6416 }
. { #JETPAC$616A }
. { #LUNARJETMAN$A880 }
. { #PSSST$613B }
. LIST#
  $B235,$03 Fetch the active player from #R$969E.
  $B238,$01 Flip the bits to switch to the other player.
  $B239,$03 Store the new active player in #R$969E.
N $B23C These are all the player states.
  $B23C,$03 Point #REGhl at the state of the active player at #R$96BC.
  $B23F,$03 Point #REGde at the state of the inactive player at #R$96DF.
  $B242,$03 Set the number of bytes to swap in #REGbc to #N$0023.
  $B245,$03 Swap the bytes.
N $B248 These are the room objects.
  $B248,$03 Point #REGhl at the room objects of the active player at #R$DDEC.
  $B24B,$03 Point #REGde at the room objects of the inactive player at #R$DFEC.
  $B24E,$03 Set the number of bytes to swap in #REGbc to #N$0200.
  $B251,$03 Swap the bytes.
N $B254 And these are the actors.
  $B254,$03 Point #REGhl at the actors of the active player at #R$9702.
  $B257,$03 Point #REGde at the actors of the inactive player at #R$982E.
  $B25A,$03 Set the number of bytes to swap in #REGbc to #N$012C.
N $B25D Swap the bytes at #REGhl and #REGde, for the number of bytes in #REGbc.
@ $B25D label=ChangePlayer_Loop
  $B25D,$01 Fetch a byte of the inactive player's data.
  $B25E,$01 Switch to the shadow #REGaf register.
  $B25F,$02 Copy a byte of the active player's data over the inactive player's
. data.
  $B261,$01 Switch back to the normal #REGaf register.
  $B262,$01 Write the inactive player's byte over the active player's data.
  $B263,$01 Move onto the next byte of the inactive player's data.
  $B264,$01 Move onto the next byte of the active player's data.
  $B265,$01 Decrease the byte counter by one.
  $B266,$04 Loop back to #R$B25D until all of the bytes have been swapped.
  $B26A,$01 Return.

c $B26B Initialise Hall Of Fame Timer
@ $B26B label=InitialiseHallOfFameTimer
D $B26B Sets the counter which counts the time left before the hall of fame is
. shown from the game selection menu (see #R$B272) to #N($0300,$04,$04).
  $B26B,$06 Set the hall of fame timer in #R$96B8 to #N$0300.
  $B271,$01 Return.

c $B272 Handler: Hall Of Fame
@ $B272 label=HandlerHallOfFame
D $B272 Called from the game selection menu (see #R$B43E). If the options have
. been changed then the counter is set again. Otherwise the counter in #R$96B8
. is decreased, and when it reaches zero the hall of fame is shown (see
. #R$B29F). The hall of fame stays on screen until a key is pressed, or until
. about twelve times #N($FFFF,$04,$04) loops of the delay have passed. The
. game selection menu is then drawn again.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$B272 }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$B3D5,stop=$B3EC,sp=$5B40)
. #SCR$01(handler-hall-of-fame-before)
. | #POKES$96B8,$01;$96B9,$00
. #SIM(start=$B43E,stop=$B286,sp=$5B40)
. #SCR$01(handler-hall-of-fame-after) } UDGTABLE# #POPS
E $B272 View the equivalent code in;
. #LIST
. { #MARTIANOIDS$B760 }
. { #MARTIANOIDS$B76C }
. LIST#
R $B272 F Zero flag set if the options have not changed
  $B272,$02 Jump to #R$B26B to restart the hall of fame timer if the options
. have been changed.
  $B274,$07 Decrease the hall of fame timer in #R$96B8 by one.
  $B27B,$03 Return unless the hall of fame timer has run out.
@ $B27E label=HandlerHallOfFame_Show
  $B27E,$03 Show the hall of fame.
  $B281,$02 Set the number of waits in #REGb to #N$0C.
  $B283,$03 Set the wait counter in #REGhl to zero.
N $B286 Wait for a key to be pressed or for the time to run out.
@ $B286 label=HandlerHallOfFame_Wait
  $B286,$01 Select every row of the keyboard.
  $B287,$02 Select the keyboard rows (this does nothing on a 48K).
  $B289,$02 Read the keyboard.
  $B28B,$01 Flip the bits.
  $B28C,$02,b$01 Keep only bits 0-4.
  $B28E,$02 Jump to #R$B297 if a key has been pressed.
  $B290,$01 Decrease the wait counter by one.
  $B291,$04 Loop back to #R$B286 until the wait counter is zero.
  $B295,$02 Decrease the number of waits by one and loop back to #R$B286 until
. all of the waits are done.
@ $B297 label=HandlerHallOfFame_Finish
  $B297,$03 Clear the panel.
  $B29A,$03 Print the game selection menu.
  $B29D,$02 Jump to #R$B26B to restart the hall of fame timer.

c $B29F Show Hall Of Fame
@ $B29F label=HallOfFame
D $B29F Clears the panel in the middle of the screen, prints the eight lines of
. text of the hall of fame (the title, the six positions and the copyright
. message) and then prints the six scores and initials from #R$B304, one under
. the other.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$B29F }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$B3D5,stop=$B3EC,sp=$5B40)
. #SCR$01(hall-of-fame-before)
. | #SIM(start=$B27E,stop=$B281,sp=$5B40)
. #SCR$01(hall-of-fame-after) } UDGTABLE# #POPS
E $B29F View the equivalent code in;
. #LIST
. { #MARTIANOIDS$B78C }
. LIST#
  $B29F,$03 Clear the panel.
  $B2A2,$03 Point #REGde at the attributes of the lines of text at #R$B32E.
  $B2A5,$01 Switch to the shadow registers.
  $B2A6,$03 Point #REGhl' at the positions of the lines of text at #R$B336.
  $B2A9,$03 Point #REGde' at the lines of text at #R$B346.
N $B2AC There are eight lines of text.
  $B2AC,$02 Set the number of lines of text in the shadow #REGb register to
. #N$08.
  $B2AE,$03 Print the lines of text.
N $B2B1 Print the scores. #REGc is the counter for the six positions.
  $B2B1,$03 Set the number of scores in #REGc to #N$06 (and #REGb to #N$03).
  $B2B4,$03 Point #REGde at the first high score at #R$B304.
  $B2B7,$03 #REGhl=#N($4868,$04,$04) (the Y position of the first score is
. #N$48 and the X position is #N$68).
@ $B2BA label=HallOfFame_Loop
  $B2BA,$01 Stash the score counter on the stack.
  $B2BB,$01 Stash the position of the score on the stack.
  $B2BC,$03 Convert the position into a screen address.
  $B2BF,$03 Print the score.
  $B2C2,$02 Set the number of initials in #REGb to #N$03.
  $B2C4,$03 Move three characters to the right.
N $B2C7 Print the three initials.
@ $B2C7 label=HallOfFame_Initials
  $B2C7,$01 Fetch an initial.
  $B2C8,$01 Move onto the next initial.
  $B2C9,$03 Print the initial.
  $B2CC,$02 Decrease the initial counter by one and loop back to #R$B2C7 until
. all three initials have been printed.
  $B2CE,$01 Restore the position of the score from the stack.
  $B2CF,$01 Fetch the Y position.
  $B2D0,$02 Add #N$10 to move down two lines of text.
  $B2D2,$01 Set the new Y position.
  $B2D3,$01 Restore the score counter from the stack.
  $B2D4,$03 Decrease the score counter by one and loop back to #R$B2BA until all
. six scores have been printed.
  $B2D7,$01 Return.

c $B2D8 Clear Panel
@ $B2D8 label=HallOfFame_Clear
D $B2D8 Clears the panel which is used for the hall of fame and for entering a
. new high score. The panel is #N$18 characters wide, #N$10 characters high
. and starts at column #N$04 of row #N$05. The attributes are set to #N$00 and
. the pixels are set to zero.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$B2D8 }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$B3D5,stop=$B3EC,sp=$5B40)
. #SIM(start=$B27E,stop=$B281,sp=$5B40)
. #SCR$01(clear-panel-before)
. | #SIM(start=$B297,stop=$B29A,sp=$5B40)
. #SCR$01(clear-panel-after) } UDGTABLE# #POPS
N $B2D8 Clear the attributes.
  $B2D8,$03 Point #REGhl at the first attribute of the panel.
  $B2DB,$03 #REGbc=#N($1810,$04,$04) (#REGb is the width and #REGc is the number
. of rows).
  $B2DE,$03 #REGde=#N($0020,$04,$04) (the number of bytes to the next row).
@ $B2E1 label=HallOfFame_Clear_Attribute_Rows
  $B2E1,$01 Stash the counters on the stack.
  $B2E2,$01 Stash the start of the row on the stack.
@ $B2E3 label=HallOfFame_Clear_Attribute_Row
  $B2E3,$02 Clear the attribute.
  $B2E5,$01 Move to the next column.
  $B2E6,$02 Decrease #REGb by one and loop back to #R$B2E3 until the row
. is done.
  $B2E8,$01 Restore the start of the row from the stack.
  $B2E9,$01 Move down to the next row.
  $B2EA,$01 Restore the counters from the stack.
  $B2EB,$03 Decrease the row counter by one and loop back to #R$B2E1 until all
. of the rows are done.
N $B2EE Clear the pixels.
  $B2EE,$03 Point #REGhl at the first pixel line of the panel.
  $B2F1,$03 #REGbc=#N($1880,$04,$04) (#REGb is the width and #REGc is the number
. of pixel lines).
@ $B2F4 label=HallOfFame_Clear_Pixel_Lines
  $B2F4,$01 Stash the counters on the stack.
  $B2F5,$01 Stash the start of the pixel line on the stack.
@ $B2F6 label=HallOfFame_Clear_Pixel_Line
  $B2F6,$02 Clear a byte of the pixel line.
  $B2F8,$01 Move to the next column.
  $B2F9,$02 Decrease #REGb by one and loop back to #R$B2F6 until the line
. is done.
  $B2FB,$01 Restore the start of the pixel line from the stack.
  $B2FC,$03 Move down to the next pixel line.
  $B2FF,$01 Restore the counters from the stack.
  $B300,$03 Decrease the pixel line counter by one and loop back to #R$B2F4
. until all of the pixel lines are done.
  $B303,$01 Return.

g $B304 High Scores
@ $B304 label=Top_HighScore_1
D $B304 Each high score slot uses 3-bytes for the score with the players initials.
D $B304 Most other Ultimate games only hold the high score.
E $B304 View the equivalent code in;
. #LIST
. { #JETPAC$5CF0 }
. { #LUNARJETMAN$5E06 }
. { #PSSST$5E00 }
. { #TRANZAM$5E49 }
. LIST#
N $B304 Top score.
B $B304,$01 Byte #1.
@ $B305 label=Top_HighScore_2
B $B305,$01 Byte #2.
@ $B306 label=Top_HighScore_3
B $B306,$01 Byte #3.
@ $B307 label=Top_HighScore_Initials
T $B307,$03 "#STR(#PC,$04,$03)".
N $B30A 2nd place.
@ $B30A label=Pos_2_HighScore_1
B $B30A,$01 Byte #1.
@ $B30B label=Pos_2_HighScore_2
B $B30B,$01 Byte #2.
@ $B30C label=Pos_2_HighScore_3
B $B30C,$01 Byte #3.
@ $B30D label=Pos_2_HighScore_Initials
T $B30D,$03 "#STR(#PC,$04,$03)".
N $B310 3rd place.
@ $B310 label=Pos_3_HighScore_1
B $B310,$01 Byte #1.
@ $B311 label=Pos_3_HighScore_2
B $B311,$01 Byte #2.
@ $B312 label=Pos_3_HighScore_3
B $B312,$01 Byte #3.
@ $B313 label=Pos_3_HighScore_Initials
T $B313,$03 "#STR(#PC,$04,$03)".
N $B316 4th place.
@ $B316 label=Pos_4_HighScore_1
B $B316,$01 Byte #1.
@ $B317 label=Pos_4_HighScore_2
B $B317,$01 Byte #2.
@ $B318 label=Pos_4_HighScore_3
B $B318,$01 Byte #3.
@ $B319 label=Pos_4_HighScore_Initials
T $B319,$03 "#STR(#PC,$04,$03)".
N $B31C 5th place.
@ $B31C label=Pos_5_HighScore_1
B $B31C,$01 Byte #1.
@ $B31D label=Pos_5_HighScore_2
B $B31D,$01 Byte #2.
@ $B31E label=Pos_5_HighScore_3
B $B31E,$01 Byte #3.
@ $B31F label=Pos_5_HighScore_Initials
T $B31F,$03 "#STR(#PC,$04,$03)".
N $B322 6th place.
@ $B322 label=Pos_6_HighScore_1
B $B322,$01 Byte #1.
@ $B323 label=Pos_6_HighScore_2
B $B323,$01 Byte #2.
@ $B324 label=Pos_6_HighScore_3
B $B324,$01 Byte #3.
@ $B325 label=Pos_6_HighScore_Initials
T $B325,$03 "#STR(#PC,$04,$03)".

N $B328 New high score entry buffer.
@ $B328 label=New_HighScore_1
B $B328,$01 Byte #1.
@ $B329 label=New_HighScore_2
B $B329,$01 Byte #2.
@ $B32A label=New_HighScore_3
B $B32A,$01 Byte #3.
@ $B32B label=New_HighScore_Initials
T $B32B,$03 "#STR(#PC,$04,$03)".

b $B32E Hall Of Fame Attribute Table
@ $B32E label=HallOfFame_Attributes
D $B32E The attribute used for each of the eight lines of text of the hall of
. fame: white for the title and the first two positions, yellow for the third
. and fourth positions, cyan for the fifth and sixth and white for the
. copyright message.
  $B32E,$08,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | ULTIMATE HALL OF FAME }
. { #N$02 | 1ST }
. { #N$03 | 2ND }
. { #N$04 | 3RD }
. { #N$05 | 4TH }
. { #N$06 | 5TH }
. { #N$07 | 6TH }
. { #N$08 | © 1984 A.C.G. }
. TABLE#

b $B336 Hall Of Fame Position Table
@ $B336 label=HallOfFame_Position
D $B336 The X and Y positions (in pixels) of each of the eight lines of text of
. the hall of fame.
  $B336,$10,$02 #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Menu Item }
. { #N(#EVAL(#PEEK(#PC+$00) / $08)) | #N(#EVAL(#PEEK(#PC+$01)) / $08) | ULTIMATE HALL OF FAME }
. { #N(#EVAL(#PEEK(#PC+$02) / $08)) | #N(#EVAL(#PEEK(#PC+$03)) / $08) | 1ST }
. { #N(#EVAL(#PEEK(#PC+$04) / $08)) | #N(#EVAL(#PEEK(#PC+$05)) / $08) | 2ND }
. { #N(#EVAL(#PEEK(#PC+$06) / $08)) | #N(#EVAL(#PEEK(#PC+$07)) / $08) | 3RD }
. { #N(#EVAL(#PEEK(#PC+$08) / $08)) | #N(#EVAL(#PEEK(#PC+$09)) / $08) | 4TH }
. { #N(#EVAL(#PEEK(#PC+$0A) / $08)) | #N(#EVAL(#PEEK(#PC+$0B)) / $08) | 5TH }
. { #N(#EVAL(#PEEK(#PC+$0C) / $08)) | #N(#EVAL(#PEEK(#PC+$0D)) / $08) | 6TH }
. { #N(#EVAL(#PEEK(#PC+$0E) / $08)) | #N(#EVAL(#PEEK(#PC+$0F)) / $08) | © 1984 A.C.G }
. TABLE#

t $B346 Messaging: Hall Of Fame Screen Text
@ $B346 label=HallOfFame_Text
D $B346 The eight lines of text of the hall of fame. The last character of each
. string has bit 7 set.
  $B346,$15,$14:$01 "#STR(#PC)".
  $B35B,$12,$11:$01 "#STR(#PC,$04)".
  $B36D,$12,$11:$01 "#STR(#PC,$04)".
  $B37F,$12,$11:$01 "#STR(#PC,$04)".
  $B391,$12,$11:$01 "#STR(#PC,$04)".
  $B3A3,$12,$11:$01 "#STR(#PC,$04)".
  $B3B5,$12,$11:$01 "#STR(#PC,$04)".
  $B3C7,$0E,$0D:$01 "#STR(#PC)".

c $B3D5 Handler: Game Menu
@ $B3D5 label=HandlerGameMenu
D $B3D5 Shows the game selection menu and waits for the player to start the
. game. The keys are:
. #TABLE(default,centre,centre)
. { =h Key | =h Action }
. { 1 | One player game }
. { 2 | Two player game }
. { 3 | Keyboard controls }
. { 4 | Kempston joystick }
. { 5 | Cursor joystick }
. { 6 | Interface II joystick }
. { 0 | Start the game }
. TABLE#
. The choices are stored in #R$9692.
. .
. The tune at #R$BC67 is played while the menu is waiting, and a key press
. stops it. While nothing is changed the hall of fame is shown after a time
. (see #R$B272).
. .
. #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune)))
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SCR$01(game-menu-before)
. | #SIM(start=$B3D5,stop=$B3EC,sp=$5B40)
. #SCR$01(game-menu-after) } UDGTABLE# #POPS
  $B3D5,$05 Set the last seen options in #R$96B7 to #N$FF.
  $B3DA,$03 Clear the attribute buffer of the play area.
  $B3DD,$03 Clear the play area.
  $B3E0,$03 #REGhl=#R$61C6.
  $B3E3,$03 Draw the room.
  $B3E6,$03 Print the game selection menu.
  $B3E9,$03 Update the flashing selections.
  $B3EC,$03 Point #REGde at the music at #R$BC67.
  $B3EF,$03 Play the music until a key is pressed.
@ $B3F2 label=HandlerGameMenu_Loop
  $B3F2,$03 Print the game selection menu.
  $B3F5,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $B3FB,$01 Flip the bits.
  $B3FC,$01 Store the result in #REGe.
  $B3FD,$03 Fetch the game options from #R$9692.
N $B400 Handle 1UP game selection.
@ $B400 label=GameSelect_Check1UP
  $B400,$04 Jump to #R$B406 if key "1" ("1 PLAYER GAME") has not been pressed.
  $B404,$02 Select a one player game by resetting bit 0.
N $B406 Handle 2UP game selection.
@ $B406 label=GameSelect_Check2UP
  $B406,$04 Jump to #R$B40C if key "2" ("2 PLAYER GAME") has not been pressed.
  $B40A,$02 Select a two player game by setting bit 0.
N $B40C Handle Keyboard selection.
@ $B40C label=GameSelect_CheckKeyboard
  $B40C,$04 Jump to #R$B412 if key "3" ("KEYBOARD") has not been pressed.
  $B410,$02,b$01 Select the keyboard by clearing the control method.
N $B412 Handle Kempston Joystick selection.
@ $B412 label=GameSelect_CheckKempston
  $B412,$04 Jump to #R$B41A if key "4" ("KEMPSTON JOYSTICK") has not been
. pressed.
  $B416,$02,b$01 Clear the control method.
  $B418,$02,b$01 Select the Kempston joystick by setting control method #N$02.
N $B41A Handle Cursor Joystick selection.
@ $B41A label=GameSelect_CheckCursor
  $B41A,$04 Jump to #R$B422 if key "5" ("CURSOR JOYSTICK") has not been pressed.
  $B41E,$02,b$01 Clear the control method.
  $B420,$02,b$01 Select the Cursor joystick by setting control method #N$04.
@ $B422 label=GameSelect_ReadSecondKeyRow
  $B422,$01 Stash the game options in #REGc.
  $B423,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $B429,$01 Flip the bits.
  $B42A,$01 Store the result in #REGe.
  $B42B,$01 Restore the game options to #REGa.
N $B42C Handle Interface II Joystick selection.
@ $B42C label=GameSelect_CheckInterface2
  $B42C,$04 Jump to #R$B432 if key "6" ("INTERFACE II") has not been pressed.
  $B430,$02,b$01 Select the Interface II joystick by setting control method
. #N$06.
@ $B432 label=GameSelect_StoreOptions
  $B432,$03 Store the game options in #R$9692.
N $B435 Handle starting a new game.
@ $B435 label=GameSelect_Start
  $B435,$03 Return if key "0" ("START GAME") has been pressed.
  $B438,$03 Update the flashing selections.
  $B43B,$03 Jump to #R$B3F2.

c $B43E Update Game Menu
@ $B43E label=HallOfFameCheck
D $B43E Called when the selections on the game selection menu may have changed.
. Records the selections in #R$96B7 and counts down to the hall of fame (see
. #R$B272) and then makes the two selected options (the number of players and
. the controls) flash, and the others not.
. .
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$B3D5,stop=$B3E9,sp=$5B40)
. #SCR$02,$02,$04,$1C,$0E(update-menu-before) }
. { =h After #R$B43E }
. { #SIM(start=$B3E9,stop=$B3EC,sp=$5B40)
. #SCR$02,$02,$04,$1C,$0E(update-menu-after) } UDGTABLE# #POPS
  $B43E,$03 Point #REGhl at the last seen options at #R$96B7.
  $B441,$03 Fetch the game options from #R$9692.
  $B444,$01 Compare the game options with the last ones seen.
  $B445,$03 Store the game options as the last ones seen.
  $B448,$03 Check the hall of fame timer.
N $B44B Handle flashing each selection.
  $B44B,$03 Point #REGhl at the attributes of the selections at #R$B498.
  $B44E,$03 Fetch the game options from #R$9692.
  $B451,$01 Stash the game options in #REGc.
N $B452 There are two player options to choose from (1UP or 2UP game).
  $B452,$02 Set the number of player options in #REGb to #N$02.
  $B454,$02,b$01 Keep only bit 0 (the player options).
  $B456,$03 Flash the selected player option.
  $B459,$01 Restore the game options to #REGa.
  $B45A,$01 Rotate out the number of players bit.
  $B45B,$02,b$01 Keep only bits 0-1 (the control options).
N $B45D There are four control methods to choose from.
  $B45D,$02 Set the number of control methods in #REGb to #N$04.
  $B45F,$03 Flash the selected control method.
  $B462,$01 Return.
N $B463 Selection flashing routine.
@ $B463 label=HandlerMenuAttributeFlash
  $B463,$03 Jump to #R$B46D if this is not the selected option.
@ $B466 label=MenuAttributeSet
  $B466,$02 Make the selection flash.
  $B468,$02 Jump to #R$B46F.
@ $B46A label=HandlerMenuAttributeFlash_Loop
  $B46A,$01 Decrease the selection counter by one.
  $B46B,$02 Jump to #R$B466 if this is the selected option.
@ $B46D label=MenuAttributeUnset
  $B46D,$02 Stop the selection flashing.
@ $B46F label=MenuAttributeNext
  $B46F,$01 Move onto the attribute of the next option.
  $B470,$02 Decrease the option counter by one and loop back to #R$B46A until
. all of the options have been done.
  $B472,$01 Return.

c $B473 Game Selection Menu
@ $B473 label=GameMenu
D $B473 Prints the eight lines of text of the game selection menu, each with
. its own attribute (see #R$B498), at the positions in #R$B4A0. The entry point
. at #R$B47F is also used to print the hall of fame, which has its own tables.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$B473 }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$B3D5,stop=$B3E6,sp=$5B40)
. #SCR$01(selection-menu-before)
. | #SIM(start=$B3E6,stop=$B3E9,sp=$5B40)
. #SCR$01(selection-menu-after) } UDGTABLE# #POPS
E $B473 View the equivalent code in;
. #LIST
. { #ATICATAC$7CAF }
. { #COOKIE$6332 }
. { #JETPAC$6260 }
. { #LUNARJETMAN$80D1 }
. { #MARTIANOIDS$B8B3 }
. { #PSSST$6250 }
. { #TRANZAM$5F6C }
. { #UNDERWURLDE$90E4 }
. LIST#
  $B473,$03 Point #REGde at the attributes of the lines of text at #R$B498.
  $B476,$01 Switch to the shadow registers.
  $B477,$03 Point #REGhl' at the positions of the lines of text at #R$B4A0.
  $B47A,$03 Point #REGde' at the lines of text at #R$B4B0.
N $B47D There are eight lines of text.
  $B47D,$02 Set the number of lines of text in the shadow #REGb register to
. #N$08.
@ $B47F label=GameMenu_Loop
  $B47F,$01 Switch back to the normal registers.
  $B480,$04 Copy the attribute of the line of text to #R$96A8.
  $B484,$01 Move onto the attribute of the next line of text.
  $B485,$01 Switch to the shadow registers.
  $B486,$01 Stash the line counter on the stack.
  $B487,$01 Fetch the X position of the line of text.
  $B488,$02 Move onto the position of the next line of text.
  $B48A,$01 Stash the position pointer on the stack.
  $B48B,$01 Move back to the Y position of the line of text.
  $B48C,$01 Set the Y position in #REGh.
  $B48D,$01 Set the X position in #REGl.
  $B48E,$03 Print the line of text.
  $B491,$01 Switch to the shadow registers.
  $B492,$02 Restore the position pointer and the line counter from the stack.
  $B494,$01 Move onto the next line of text.
  $B495,$02 Decrease the line counter by one and loop back to #R$B47F until all
. of the lines of text have been printed.
  $B497,$01 Return.

b $B498 Game Select Attribute Table
@ $B498 label=GameSelection_Attributes
D $B498 The attribute used for each of the eight lines of text of the game
. selection menu. The routine at #R$B43E sets bit 7 (the flash bit) for the
. player option and the control option which are selected.
E $B498 View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #JETPAC$628D }
. { #LUNARJETMAN$810E }
. { #PSSST$627C }
. { #TRANZAM$5FA7 }
. { #UNDERWURLDE$9119 }
. LIST#
  $B498,$08,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | 1 1 PLAYER GAME }
. { #N$02 | 2 2 PLAYER GAME }
. { #N$03 | 3 KEYBOARD }
. { #N$04 | 4 KEMPSTON JOYSTICK }
. { #N$05 | 5 CURSOR JOYSTICK }
. { #N$06 | 6 INTERFACE II }
. { #N$07 | 0 START GAME }
. { #N$08 | © 1984 A.C.G. }
. TABLE#

b $B4A0 Game Select Y Position Table
@ $B4A0 label=GameSelection_Position
D $B4A0 The X and Y positions (in pixels) of each of the eight lines of text of
. the game selection menu.
E $B4A0 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF1 }
. { #JETPAC$6293 }
. { #LUNARJETMAN$8115 }
. { #PSSST$6282 }
. { #TRANZAM$5FAC }
. { #UNDERWURLDE$911F }
. LIST#
  $B4A0,$10,$02 #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Menu Item }
. { #N(#EVAL(#PEEK(#PC+$00) / $08)) | #N(#EVAL(#PEEK(#PC+$01)) / $08) | 1 1 PLAYER GAME }
. { #N(#EVAL(#PEEK(#PC+$02) / $08)) | #N(#EVAL(#PEEK(#PC+$03)) / $08) | 2 2 PLAYER GAME }
. { #N(#EVAL(#PEEK(#PC+$04) / $08)) | #N(#EVAL(#PEEK(#PC+$05)) / $08) | 3 KEYBOARD }
. { #N(#EVAL(#PEEK(#PC+$06) / $08)) | #N(#EVAL(#PEEK(#PC+$07)) / $08) | 4 KEMPSTON JOYSTICK }
. { #N(#EVAL(#PEEK(#PC+$08) / $08)) | #N(#EVAL(#PEEK(#PC+$09)) / $08) | 5 CURSOR JOYSTICK }
. { #N(#EVAL(#PEEK(#PC+$0A) / $08)) | #N(#EVAL(#PEEK(#PC+$0B)) / $08) | 6 INTERFACE II }
. { #N(#EVAL(#PEEK(#PC+$0C) / $08)) | #N(#EVAL(#PEEK(#PC+$0D)) / $08) | 0 START GAME }
. { #N(#EVAL(#PEEK(#PC+$0E) / $08)) | #N(#EVAL(#PEEK(#PC+$0F)) / $08) | © 1984 A.C.G }
. TABLE#

t $B4B0 Messaging: Game Selection Title
@ $B4B0 label=String_1UP_Game
D $B4B0 The eight lines of text of the game selection menu. The last character
. of each string has bit 7 set.
E $B4B0 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #COOKIE$636C }
. { #JETPAC$6299 }
. { #LUNARJETMAN$811C }
. { #PSSST$6288 }
. LIST#
  $B4B0,$10,$0F:$01 "#STR(#PC)".
@ $B4C0 label=String_2UP_Game
  $B4C0,$10,$0F:$01 "#STR(#PC)".
@ $B4D0 label=String_Keyboard
  $B4D0,$0B,$0A:$01 "#STR(#PC)".
@ $B4DB label=String_Kempston
  $B4DB,$14,$13:$01 "#STR(#PC)".
@ $B4EF label=String_Cursor
  $B4EF,$14,$13:$01 "#STR(#PC)".
@ $B503 label=String_InterfaceII
  $B503,$0F,$0E:$01 "#STR(#PC)".
@ $B512 label=String_StartGame
  $B512,$0D,$0C:$01 "#STR(#PC)".
@ $B51F label=String_Copyright
  $B51F,$0E,$0D:$01 "#STR(#PC)".

c $B52D Write Menu Line
@ $B52D label=MenuWriteText
D $B52D Prints a line of text with an attribute, for the game selection menu and
. the hall of fame. The shadow registers hold the text pointer (#REGde') and the
. screen address (#REGhl'), and the normal registers hold the attribute address
. (#REGhl). The attribute is taken from #R$96A8. Printing is done by the code
. in #R$B53D.
. .
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$B3D5,stop=$B3E6,sp=$5B40)
. #SIM(start=$B473,stop=$B47F,sp=$5B40)
. #SCR$02,$02,$05,$1C,$03(menu-line-before) }
. { =h After #R$B52D }
. { #SIM(start=$B47F,stop=$B495,sp=$5B40)
. #SCR$02,$02,$05,$1C,$03(menu-line-after) } UDGTABLE# #POPS
R $B52D HL Position of the text, with the Y position in #REGh and the X position
. in #REGl (both in pixels)
R $B52D DE' Pointer to the text, which ends with a character that has bit 7 set
E $B52D View the equivalent code in;
. #LIST
. { #ATICATAC$7D8A }
. { #COOKIE$63E0 }
. { #JETPAC$62FF }
. { #LUNARJETMAN$81AB }
. { #PSSST$62E7 }
. { #TRANZAM$5F97 }
. { #UNDERWURLDE$91B0 }
. LIST#
  $B52D,$01 Stash the position of the line of text on the stack.
  $B52E,$03 Convert the position into a screen address.
  $B531,$03 Fetch the attribute of the line of text from #R$96A8.
  $B534,$01 Stash the attribute in the shadow #REGaf register.
  $B535,$01 Switch to the shadow registers.
  $B536,$01 Restore the position of the line of text from the stack.
  $B537,$03 Convert the position into an attribute address.
  $B53A,$03 Jump to #R$B549 to print the line of text.

c $B53D Print Colour String
@ $B53D label=PrintStringColour
D $B53D Prints a string at the position given, which has its attribute as the
. first byte. The last character of the string has bit 7 set. The attribute is
. written to each of the positions of the characters.
. .
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$9960,stop=$9979,clear=1,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(colour-string-before) }
. { =h After #R$B53D }
. { #SIM(start=$B53D,stop=$0000,hl=$0078,de=$B586,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(colour-string-after) } UDGTABLE# #POPS
E $B53D View the equivalent code in;
. #LIST
. { #ATICATAC$A1F3 }
. { #COOKIE$7488 }
. { #JETPAC$716C }
. { #LUNARJETMAN$8A11 }
. { #MARTIANOIDS$BD99 }
. { #PSSST$73ED }
. { #TRANZAM$6518 }
. { #UNDERWURLDE$9C3C }
. LIST#
R $B53D HL Position of the text, with the Y position in #REGh and the X position
. in #REGl (both in pixels)
R $B53D DE Pointer to string data
  $B53D,$01 Stash the position of the string on the stack.
  $B53E,$03 Convert the position into a screen address.
  $B541,$01 Fetch the attribute of the string.
  $B542,$01 Stash the attribute in the shadow #REGaf register.
  $B543,$01 Move onto the text of the string.
  $B544,$01 Switch to the shadow registers.
  $B545,$01 Restore the position of the string from the stack.
  $B546,$03 Convert the position into an attribute address.
@ $B549 label=PrintString_Loop
  $B549,$01 Switch back to the normal registers.
  $B54A,$01 Fetch the next character of the string.
  $B54B,$04 Jump to #R$B55A if this is the last character of the string (bit 7
. is set).
  $B54F,$03 Print the character.
  $B552,$01 Move onto the next character of the string.
  $B553,$01 Switch to the shadow registers.
  $B554,$01 Fetch the attribute.
  $B555,$01 Set the attribute of the character on the screen.
  $B556,$01 Move onto the next column.
  $B557,$01 Stash the attribute in the shadow #REGaf register.
  $B558,$02 Jump back to #R$B549 to print the next character.
N $B55A Because the last character contains the terminator, it needs to be handled separately.
@ $B55A label=PrintString_LastCharacter
  $B55A,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $B55C,$03 Print the last character of the string.
  $B55F,$01 Switch to the shadow registers.
  $B560,$01 Fetch the attribute.
  $B561,$01 Set the attribute of the last character on the screen.
  $B562,$01 Return.

c $B563 Print Banner
@ $B563 label=PrintBanner
D $B563 Prints the score labels "1UP", "HI" and "2UP" at the top of the screen.
. .
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$9960,stop=$9979,clear=1,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(banner-before) }
. { =h After #R$B563 }
. { #SIM(start=$9979,stop=$997C,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(banner-after) } UDGTABLE# #POPS
E $B563 View the equivalent code in;
. #LIST
. { #COOKIE$74AE }
. { #JETPAC$7192 }
. { #LUNARJETMAN$8A37 }
. { #PSSST$7413 }
. LIST#
N $B563 Prints "1UP".
  $B563,$03 Set the position of the "1UP" label in #REGhl (the Y position is
. #N$00 and the X position is #N$10).
  $B566,$03 Point #REGde at the "1UP" label at #R$B57E.
  $B569,$03 Print the "1UP" label.
N $B56C Prints "HI".
  $B56C,$03 Set the position of the "HI" label in #REGhl (the Y position is
. #N$00 and the X position is #N$78).
  $B56F,$03 Point #REGde at the "HI" label at #R$B586.
  $B572,$03 Print the "HI" label.
N $B575 Prints "2UP".
  $B575,$03 Set the position of the "2UP" label in #REGhl (the Y position is
. #N$00 and the X position is #N$D8).
  $B578,$03 Point #REGde at the "2UP" label at #R$B582.
  $B57B,$03 Print the "2UP" label.
N $B57E Banner text data.
@ $B57E label=1UP_Text
T $B57E,$04,h$01,$02:$01 "1UP" (#COLOUR(#PEEK(#PC)) is the attribute).
@ $B582 label=2UP_Text
T $B582,$04,h$01,$02:$01 "2UP" (#COLOUR(#PEEK(#PC)) is the attribute).
@ $B586 label=HI_Text
T $B586,$03,h$01,$01:$01 "HI" (#COLOUR(#PEEK(#PC)) is the attribute).

c $B589 Print Character
@ $B589 label=PrintScreen
D $B589 Prints a character from the font pointed to by the system variable CHARS
. onto the screen, at an address on the screen, and moves to the next column.
. .
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$9960,stop=$9979,clear=1,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(character-before) }
. { =h After #R$B589 }
. { #SIM(start=$B589,stop=$0000,a=$53,hl=$4004,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(character-after) } UDGTABLE# #POPS
E $B589 View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #MARTIANOIDS$B5CB }
. { #NIGHTSHADE$CB19 }
. { #PSSST$73CD }
. { #TRANZAM$6C96 }
. { #UNDERWURLDE$98DF }
. LIST#
R $B589 A ASCII value to print
R $B589 HL Screen address
R $B589 O:HL Screen address of the next character
  $B589,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $B58C,$03 Use the character code as the offset into the font.
  $B58F,$03 Multiply the offset by eight (the number of bytes in a character).
  $B592,$04 Fetch the address of the font from #SKOOLKID$5C36(CHARS).
  $B596,$02 #REGde=#REGhl + #N$3C00. For examples of usage;
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Letter | =h ASCII Value | =h * 8 (offset) | =h CHARS + offset }
. #FOREACH($55,$4C,$54,$49,$4D,$41,$54,$45)(value,
. { #LET(result=$3C00 + value * $08) "#CHR(value)" | #N(value) | #N(value * 8) | #SKOOLKID($3D00,{result})(#N({result})) }
. )
. TABLE#
N $B598 Print the character to the screen.
  $B598,$01 Restore the screen address.
@ $B599 label=PrintScreen_Write
  $B599,$02 Set the number of pixel lines in #REGb to #N$08.
@ $B59B label=PrintScreen_Loop
  $B59B,$02 Draw a pixel line of the character.
  $B59D,$01 Move onto the next pixel line of the character.
  $B59E,$01 Move onto the next pixel line of the screen.
  $B59F,$02 Decrease the pixel line counter by one and loop back to #R$B59B
. until all eight pixel lines have been drawn.
  $B5A1,$02 Restore the registers from the stack.
N $B5A3 Reset #REGhl and move to the next column, ready to print the next character.
  $B5A3,$04 #REGh=#REGh - #N$08 (reset the display line).
  $B5A7,$01 Move onto the next column.
  $B5A8,$01 Return.

c $B5A9 Add Points To Score
@ $B5A9 label=AddPointsToScore
D $B5A9 Adds points to the score of the active player. The scores are held as
. three bytes, each with two BCD digits. The new score is then printed by
. #R$B5CC.
. .
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(add-points-before) }
. { =h After #R$B5A9 }
. { #SIM(start=$B5A9,stop=$0000,bc=$0150,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(add-points-after) } UDGTABLE# #POPS
E $B5A9 View the equivalent code in;
. #LIST
. { #COOKIE$7415 }
. { #JETPAC$70F9 }
. { #LUNARJETMAN$899C }
. { #PSSST$737A }
. { #TRANZAM$6046 }
. { #UNDERWURLDE$A045 }
. LIST#
R $B5A9 BC Points to add to score
N $B5A9 Check the active player.
  $B5A9,$06 Jump to #R$B5B4 if the active player is 2UP.
N $B5AF Set the score address for 1UP.
  $B5AF,$03 Point #REGhl at the score of 1UP at #R$969A.
  $B5B2,$02 Jump to #R$B5B7.
N $B5B4 Set the score address for 2UP.
@ $B5B4 label=AddPointsToScore_2UP
  $B5B4,$03 Point #REGhl at the score of 2UP at #R$969D.
N $B5B7 Process adding the points to the appropriate score.
@ $B5B7 label=AddPointsToScore_Start
  $B5B7,$01 Fetch the lowest pair of digits of the score.
  $B5B8,$02 Add the low byte of the points to the digits (in BCD).
  $B5BA,$01 Store the new lowest pair of digits.
  $B5BB,$01 Move onto the middle pair of digits.
  $B5BC,$01 Fetch the middle pair of digits of the score.
  $B5BD,$02 Add the high byte of the points to the digits, plus the carry (in
. BCD).
  $B5BF,$01 Store the new middle pair of digits.
  $B5C0,$01 Move onto the highest pair of digits.
  $B5C1,$01 Fetch the highest pair of digits of the score.
  $B5C2,$03 Add the carry to the digits (in BCD).
  $B5C5,$01 Store the new highest pair of digits.
N $B5C6 Check the active player.
  $B5C6,$06 Jump to #R$B5D4 if the active player is 2UP.

c $B5CC Print Scores
@ $B5CC label=Score_1UP
D $B5CC Prints the score of player 1, the score of player 2 or the high score on
. the screen as six digits. Each of the entry points sets the screen address and
. the score to print and joins the code at #R$B5E2.
. .
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$9960,stop=$9986,clear=1,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(scores-before) }
. { =h After #R$B5CC }
. { #SIM(start=$9986,stop=$998F,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(scores-after) } UDGTABLE# #POPS
E $B5CC View the equivalent code in;
. #LIST
. { #COOKIE$7438 }
. { #JETPAC$711C }
. { #LUNARJETMAN$89BF }
. { #PSSST$739D }
. { #TRANZAM$6CB6 }
. LIST#
N $B5CC Sets up the 1UP score.
  $B5CC,$03 Set the screen address of the 1UP score in #REGhl.
  $B5CF,$03 Point #REGde at the score of 1UP at #R$9698.
  $B5D2,$02 Jump to #R$B5E2 to print the score.
N $B5D4 Sets up the 2UP score.
@ $B5D4 label=Score_2UP
  $B5D4,$03 Set the screen address of the 2UP score in #REGhl.
  $B5D7,$03 Point #REGde at the score of 2UP at #R$969B.
  $B5DA,$02 Jump to #R$B5E2 to print the score.
N $B5DC Sets up the HI score.
@ $B5DC label=Score_HI
  $B5DC,$03 Set the screen address of the high score in #REGhl.
  $B5DF,$03 Point #REGde at the top high score at #R$B304.
N $B5E2 Prints the score.
@ $B5E2 label=PrintScore
  $B5E2,$02 Set the number of bytes of the score in #REGb to #N$03.
@ $B5E4 label=PrintScore_Loop
  $B5E4,$01 Fetch a pair of digits of the score.
  $B5E5,$04 Move the upper digit into the lower four bits.
  $B5E9,$02,b$01 Keep only bits 0-3.
  $B5EB,$02 Convert the digit to ASCII.
  $B5ED,$03 Print the upper digit.
@ $B5F0 label=PrintScore_LowDigit
  $B5F0,$01 Fetch the pair of digits of the score again.
  $B5F1,$02,b$01 Keep only bits 0-3.
  $B5F3,$02 Convert the digit to ASCII.
  $B5F5,$03 Print the lower digit.
  $B5F8,$01 Move onto the next pair of digits of the score.
  $B5F9,$02 Decrease the digit pair counter by one and loop back to #R$B5E4
. until all six digits have been printed.
  $B5FB,$01 Return.

c $B5FC New High Score
@ $B5FC label=NewHighScore
D $B5FC Called when the game has ended to see whether either of the scores has
. made it into the hall of fame. The player with the highest score is dealt
. with first (see #R$B61E) and then the other player, so if both players have
. scored enough the higher score is entered first.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$B5FC }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #SCR$01(new-high-score-before)
. | #POKES$9698,$11;$9699,$50;$969A,$00
. #SIM(start=$B5FC,stop=$B6A5,sp=$5B40)
. #SCR$01(new-high-score-after) } UDGTABLE# #POPS
E $B5FC View the equivalent code in;
. #LIST
. { #MARTIANOIDS$B958 }
. LIST#
  $B5FC,$03 Point #REGhl at the score of 1UP at #R$9698.
  $B5FF,$03 Point #REGde at the score of 2UP at #R$969B.
  $B602,$03 Compare the two scores.
  $B605,$05 Clear the hall of fame updated flag in #R$96BA (without changing the
. flags).
  $B60A,$04 Jump to #R$B610 if the score of 1UP is higher than (or equal to) the
. score of 2UP.
  $B60E,$01 Flip the bits to make 2UP the active player.
  $B60F,$01 Swap the score pointers, so #REGhl points to the score of 2UP.
@ $B610 label=NewHighScore_Process
  $B610,$03 Set the active player to the one with the highest score.
  $B613,$03 Enter the high score.
  $B616,$01 Swap the score pointers back, so #REGhl points to the other score.
  $B617,$03 Fetch the active player from #R$969E.
  $B61A,$01 Flip the bits to switch to the other player.
  $B61B,$03 Set the other player as the active player.

c $B61E Enter High Score
@ $B61E label=NewHighScore_Enter
D $B61E Works out whether a score is high enough to go in the hall of fame. If
. it is then every entry below it is moved down a place, the score is put in
. the gap and the player is asked to register their initials (see #R$B6D7).
. .
. The number of places that the score beat is stored in #R$96BB, so #N$01 means
. that the score only beat the sixth place and #N$06 means that it is the new
. top score.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$B61E }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #SCR$01(enter-high-score-before)
. | #POKES$9698,$08;$9699,$00;$969A,$00
. #SIM(start=$B61E,stop=$B6A5,hl=$9698,sp=$5B40)
. #SCR$01(enter-high-score-after) } UDGTABLE# #POPS
E $B61E View the equivalent code in;
. #LIST
. { #MARTIANOIDS$B970 }
. LIST#
R $B61E HL Pointer to the score of the player
  $B61E,$01 Stash the score pointers on the stack.
  $B61F,$01 Stash #REGhl on the stack.
N $B620 We hold six high scores. Start at the sixth one and compare it to the
. score, moving up while the score is greater.
  $B620,$02 Set the number of high scores in #REGb to #N$06.
  $B622,$03 Point #REGde at the sixth high score at #R$B322.
@ $B625 label=NewHighScore_Position_Loop
  $B625,$03 Compare the high score with the score of the player.
  $B628,$02 Jump to #R$B62F if the high score is not lower than the score of the
. player.
  $B62A,$03 Move back to the previous high score.
  $B62D,$02 Decrease the high score counter by one and loop back to #R$B625
. until all of the high scores have been checked.
@ $B62F label=NewHighScore_PositionFound
  $B62F,$01 Fetch the position of the first high score that was not beaten.
  $B630,$04 Jump to #R$B6A8 if the score did not beat any of the high scores.
N $B634 Move the entries down. The sixth entry moves into the buffer at #R$B328.
  $B634,$03 Point #REGhl at the sixth high score at #R$B322.
  $B637,$03 Point #REGde at the new high score buffer at #R$B328.
  $B63A,$01 Fetch the position of the first high score that was not beaten.
  $B63B,$02 Negate the position.
  $B63D,$02 #REGa=#REGa+#N$06 (the number of places beaten).
  $B63F,$03 Store the result at #R$96BB.
@ $B642 label=NewHighScore_Move_Loop
  $B642,$03 Set the size of a high score entry in #REGbc to #N$0006.
  $B645,$01 Stash the pointer to the high score on the stack.
  $B646,$02 Copy the high score down one place.
  $B648,$01 Restore the pointer to the high score into #REGde.
  $B649,$02 Copy the pointer into #REGhl.
  $B64B,$03 Move back to the previous high score.
  $B64E,$01 Swap #REGde and #REGhl so the pointers are one entry higher.
  $B64F,$03 Decrease the number of places beaten by one and loop back to #R$B642
. until all of the high scores have been moved down.
N $B652 Write the score into the gap.
  $B652,$01 Restore the pointer to the score of the player from the stack.
  $B653,$01 Stash the pointer to the score of the player on the stack again.
  $B654,$03 Set the number of bytes of the score in #REGbc to #N$0003.
  $B657,$02 Copy the score into the hall of fame.
  $B659,$01 Stash the pointer to the initials on the stack.
  $B65A,$03 Print the new high score.
  $B65D,$06 Jump to #R$B66D if the hall of fame has already been shown.
  $B663,$01 Set the hall of fame updated flag.
  $B664,$03 Store the flag in #R$96BA.
  $B667,$03 Point #REGhl at the room data at #R$61C6.
  $B66A,$03 Draw the room.
@ $B66D label=NewHighScore_Update_ClearPanel
  $B66D,$03 Clear the panel.
N $B670 Updates the text for the appropriate player number.
  $B670,$03 Fetch the active player from #R$969E.
  $B673,$01 Is this 1UP or 2UP?
  $B674,$02 #REGa=#N$B1 (ASCII "1"+#N$80).
  $B676,$02 Jump to #R$B679 if the current player is 1UP.
  $B678,$01 Else, #REGa=#N$B2 (ASCII "2"+#N$80).
N $B679 Overwrite the copy: #PUSHS
. #TABLE(default,centre,centre)
. { =h Byte | =h Copy }
. { #N$B1 | #POKES$B783,$B1 "#STR($B77C)" }
. { #N$B2 | #POKES$B783,$B2 "#STR($B77C)" }
. TABLE#
. #POPS
@ $B679 label=NewHighScore_Update_Player
  $B679,$03 Write #REGa to #R$B77C(#N$B783).
N $B67C Work out which of the #R$B6C5 to use.
  $B67C,$04 Fetch the number of places beaten from #R$96BB into #REGb.
  $B680,$02 #REGa=#N$FD (as #N$FD+#N$03=#N$00 - so the offset is then pointing at the #R$B6C5(base address)).
@ $B682 label=NewHighScore_Suffix_Loop
  $B682,$02 Move onto the next suffix.
  $B684,$02 Decrease the position counter by one and loop back to #R$B682 until
. the offset has been found.
N $B686 Fetch the appropriate position suffix.
  $B686,$03 Create an offset in #REGbc.
  $B689,$04 #REGhl=#R$B6C5 + offset.
  $B68D,$03 #REGde=#R$B795(#N$B79C).
  $B690,$03 #REGbc=#N$0003 (counter).
N $B693 Overwrite the copy: #PUSHS
. #TABLE(default,centre,centre)
. { =h Byte | =h Copy }
. { #N$00 | #FOR($00,$02)(n,#POKES($B79C+n,#PEEK($B6C5+n))) "#STR($B795)" }
. { #N$01 | #FOR($00,$02)(n,#POKES($B79C+n,#PEEK($B6C8+n))) "#STR($B795)" }
. { #N$02 | #FOR($00,$02)(n,#POKES($B79C+n,#PEEK($B6CB+n))) "#STR($B795)" }
. { #N$03 | #FOR($00,$02)(n,#POKES($B79C+n,#PEEK($B6CE+n))) "#STR($B795)" }
. { #N$04 | #FOR($00,$02)(n,#POKES($B79C+n,#PEEK($B6D1+n))) "#STR($B795)" }
. TABLE#
. #POPS
  $B693,$02 Copy #N$0003 bytes of data from #REGhl to #R$B795(#N$B79C).
N $B695 Print the messaging to the screen.
  $B695,$03 Point #REGde at the attributes of the lines of text at #R$B755.
  $B698,$01 Switch to the shadow registers.
  $B699,$03 Point #REGhl' at the positions of the lines of text at #R$B75D.
  $B69C,$03 Point #REGde' at the lines of text at #R$B76D.
N $B69F There are eight lines of text.
  $B69F,$02 Set the number of lines of text in the shadow #REGb register to
. #N$08.
  $B6A1,$03 Print the lines of text.
  $B6A4,$01 Restore the pointer to the initials from the stack.
  $B6A5,$03 Let the player enter their initials.
@ $B6A8 label=NewHighScore_Finish
  $B6A8,$01 Restore the pointer to the score of the player from the stack.
  $B6A9,$01 Restore #REGde from the stack.
  $B6AA,$01 Return.

c $B6AB Previous High Score
@ $B6AB label=NewHighScore_Next
D $B6AB Moves a pointer to a high score back to the previous entry (from the 6th
. entry towards the 1st one). Each entry is six bytes long.
E $B6AB View the equivalent code in;
. #LIST
. { #MARTIANOIDS$B9E7 }
. LIST#
R $B6AB DE Pointer to an entry
R $B6AB O:DE Pointer to the entry before it
  $B6AB,$06 Decrease #REGde by six.
  $B6B1,$01 Return.

c $B6B2 Compare Scores
@ $B6B2 label=NewHighScore_Compare
D $B6B2 Compares the scores pointed to by #REGde and #REGhl. They are held as
. three bytes, with the most significant digits first.
E $B6B2 View the equivalent code in;
. #LIST
. { #MARTIANOIDS$B9EE }
. LIST#
R $B6B2 DE Pointer to a score
R $B6B2 HL Pointer to a score
R $B6B2 O:F Carry set if the score at #REGde is less than the score at #REGhl.
. Zero set if they are equal
  $B6B2,$03 Stash #REGbc, #REGde and #REGhl on the stack.
N $B6B5 Scores are held in three bytes.
  $B6B5,$02 Set the number of bytes of the score in #REGb to #N$03.
@ $B6B7 label=NewHighScore_Compare_Loop
  $B6B7,$01 Fetch a pair of digits of the first score.
  $B6B8,$01 Compare it with the pair of digits of the second score.
  $B6B9,$02 Jump to #R$B6C1 if the first score is lower.
  $B6BB,$02 Jump to #R$B6C1 if the first score is higher.
  $B6BD,$02 Move onto the next pair of digits of both scores.
  $B6BF,$02 Decrease the digit pair counter by one and loop back to #R$B6B7
. until all three pairs of digits have been compared.
@ $B6C1 label=NewHighScore_Compare_Return
  $B6C1,$03 Restore #REGhl, #REGde and #REGbc from the stack.
  $B6C4,$01 Return.

t $B6C5 Messaging: High Score Suffixes
@ $B6C5 label=HighScore_Suffixes
D $B6C5 The text for the place of a score which has beaten the sixth entry down
. to the second one. These are used to complete the message on the new high
. score screen. The last entry is blank, as a new top score is just "highest".
  $B6C5,$03 "#STR(#PC,$04,$03)".
  $B6C8,$03 "#STR(#PC,$04,$03)".
  $B6CB,$03 "#STR(#PC,$04,$03)".
  $B6CE,$03 "#STR(#PC,$04,$03)".
  $B6D1,$03 "#STR(#PC,$04,$03)".
  $B6D4,$03 "#STR(#PC,$04,$03)".

c $B6D7 Enter Initials
@ $B6D7 label=EnterInitials
D $B6D7 Lets the player choose three initials for the hall of fame, using the
. controls (see #R$B0A3). "Left" and "right" step through the letters (space
. followed by "A" to "Z"), and "fire" accepts the letter and moves to the next
. one. The initials are written to the hall of fame and drawn on the screen.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$B6D7 }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #POKES$9698,$11;$9699,$50;$969A,$00
. #SIM(start=$B5FC,stop=$B6A5,sp=$5B40)
. #SCR$02,$04,$05,$18,$10(enter-initials-before)
. | #SIM(start=$B709,stop=$B707,a=$20,hl=$506D,sp=$5B40)
. #SCR$02,$04,$05,$18,$10(enter-initials-after) } UDGTABLE# #POPS
E $B6D7 View the equivalent code in;
. #LIST
. { #MARTIANOIDS$BA19 }
. LIST#
R $B6D7 DE Address of the initials in the hall of fame
  $B6D7,$02 Set the number of initials in #REGb to #N$03.
  $B6D9,$03 #REGhl=#N($506D,$04,$04) (the screen address of the first letter).
@ $B6DC label=EnterInitials_Letter
  $B6DC,$02 Set the letter to a space (the first choice for each initial).
@ $B6DE label=EnterInitials_Wait
  $B6DE,$01 Stash the letter on the stack.
  $B6DF,$03 Read the controls.
  $B6E2,$01 Restore the letter from the stack.
  $B6E3,$04 Jump to #R$B71B if "FIRE" is being pressed.
  $B6E7,$04 Jump to #R$B6F1 if "LEFT" is being pressed.
  $B6EB,$04 Jump to #R$B709 if "RIGHT" is being pressed.
  $B6EF,$02 Jump to #R$B6DE to wait for the controls.
N $B6F1 Choose the previous letter.
@ $B6F1 label=EnterInitials_Previous
  $B6F1,$03 Pause and play a high tone.
  $B6F4,$01 Move back to the previous letter.
  $B6F5,$04 Jump to #R$B6FB unless the letter is the one before "A" (#N$40).
  $B6F9,$02 Wrap round to a space.
@ $B6FB label=EnterInitials_Previous_Wrap
  $B6FB,$04 Jump to #R$B701 unless the letter is the one before a space (#N$1F).
  $B6FF,$02 Wrap round to "Z".
N $B701 Print the letter without moving along.
@ $B701 label=EnterInitials_Print
  $B701,$01 Stash the letter on the stack.
  $B702,$03 Print the letter.
  $B705,$01 Restore the letter from the stack.
  $B706,$01 Move back to the column of the letter.
  $B707,$02 Jump to #R$B6DE.
N $B709 Choose the next letter.
@ $B709 label=EnterInitials_Next
  $B709,$03 Pause and play a high tone.
  $B70C,$01 Move on to the next letter.
  $B70D,$04 Jump to #R$B713 unless the letter is the one after "Z" (#N$5B).
  $B711,$02 Wrap round to a space.
@ $B713 label=EnterInitials_Next_Wrap
  $B713,$04 Jump to #R$B701 unless the letter is the one after a space (#N$21).
  $B717,$02 Wrap round to "A".
  $B719,$02 Jump to #R$B701.
N $B71B Accept the letter. First wait for "fire" to be released.
@ $B71B label=EnterInitials_Accept
  $B71B,$01 Stash the letter on the stack.
  $B71C,$03 Read the controls.
  $B71F,$01 Restore the letter from the stack.
  $B720,$04 Jump to #R$B71B until "FIRE" has been released.
  $B724,$01 Write the letter into the hall of fame.
  $B725,$01 Move to the next letter in the hall of fame.
  $B726,$01 Stash the letter on the stack.
  $B727,$01 Stash the initials counter on the stack.
  $B728,$03 Print the chosen letter.
  $B72B,$01 Leave a gap before the next letter.
  $B72C,$03 Play a low tone.
  $B72F,$03 Set the delay counter in #REGbc to zero.
@ $B732 label=EnterInitials_Delay
  $B732,$01 Decrease the delay counter by one.
  $B733,$02 Test whether the delay counter is zero.
  $B735,$02 Loop back to #R$B732 until the delay is over.
  $B737,$01 Restore the initials counter from the stack.
  $B738,$01 Restore the letter from the stack.
  $B739,$02 Decrease the letter counter by one and loop back to #R$B6DC until
. all three letters have been chosen.
N $B73B Introduce a pause by counting down from #N($10000,$04,$04) before
. returning (this jumps to a routine which returns).
  $B73B,$02 Set the pause multiplier in #REGb to #N$01.
  $B73D,$03 Set the pause counter in #REGhl to zero.
  $B740,$03 Jump to #R$A1FF to pause before returning.

c $B743 Delay And Beep
@ $B743 label=NewHighScore_Return
D $B743 Used while the player chooses their initials. Pauses for a short time
. and then plays a high tone.
. .
. #HTML(#AUDIO0(high-tone.wav)(#INCLUDE(HighTone)))
E $B743 View the equivalent code in;
. #LIST
. { #MARTIANOIDS$BA93 }
. LIST#
  $B743,$03 Stash the registers on the stack.
N $B746 Introduce a pause by counting down from #N($8000,$04,$04).
  $B746,$02 Set the pause multiplier in #REGb to #N$01.
  $B748,$03 Set the pause counter in #REGhl to #N($8000,$04,$04).
  $B74B,$03 Pause.
  $B74E,$03 Play a high tone.
  $B751,$03 Restore the registers from the stack.
  $B754,$01 Return.

b $B755 New High Score Attribute Table
@ $B755 label=NewHighScore_Attributes
D $B755 The attribute used for each of the eight lines of text of the new high
. score screen.
  $B755,$08,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | CONGRATULATIONS }
. { #N$02 | PLAYER }
. { #N$03 | YOU HAVE ACHIEVED }
. { #N$04 | TODAYS HIGHEST }
. { #N$05 | SCORE }
. { #N$06 | PLEASE REGISTER }
. { #N$07 | YOUR INITIALS }
. { #N$08 | - - - }
. TABLE#

b $B75D New High Score Position Table
@ $B75D label=NewHighScore_Position
D $B75D The X and Y positions (in pixels) of each of the eight lines of text of
. the new high score screen.
  $B75D,$10,$02 #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Menu Item }
. { #N(#EVAL(#PEEK(#PC+$00) / $08)) | #N(#EVAL(#PEEK(#PC+$01)) / $08) | CONGRATULATIONS }
. { #N(#EVAL(#PEEK(#PC+$02) / $08)) | #N(#EVAL(#PEEK(#PC+$03)) / $08) | PLAYER }
. { #N(#EVAL(#PEEK(#PC+$04) / $08)) | #N(#EVAL(#PEEK(#PC+$05)) / $08) | YOU HAVE ACHIEVED }
. { #N(#EVAL(#PEEK(#PC+$06) / $08)) | #N(#EVAL(#PEEK(#PC+$07)) / $08) | TODAYS HIGHEST }
. { #N(#EVAL(#PEEK(#PC+$08) / $08)) | #N(#EVAL(#PEEK(#PC+$09)) / $08) | SCORE }
. { #N(#EVAL(#PEEK(#PC+$0A) / $08)) | #N(#EVAL(#PEEK(#PC+$0B)) / $08) | PLEASE REGISTER }
. { #N(#EVAL(#PEEK(#PC+$0C) / $08)) | #N(#EVAL(#PEEK(#PC+$0D)) / $08) | YOUR INITIALS }
. { #N(#EVAL(#PEEK(#PC+$0E) / $08)) | #N(#EVAL(#PEEK(#PC+$0F)) / $08) | - - - }
. TABLE#

t $B76D Messaging: New High Score Screen Text
@ $B76D label=NewHighScore_Text
D $B76D The eight lines of text of the new high score screen. The last character
. of each string has bit 7 set.
  $B76D,$0F,$0E:$01 "#STR(#PC)".
N $B77C This is altered by the code at #R$B679.
  $B77C,$07,$07 "PLAYER ".
@ $B783 label=NewHighScore_Text_PlayerNumber
  $B783,$01,$01 The player number, which is set by #R$B679.
  $B784,$11,$10:$01 "#STR(#PC)".
N $B795 This is altered by the code at #R$B68D.
  $B795,$07,$07 "TODAYS ".
@ $B79C label=NewHighScore_Text_Position
  $B79C,$03,$03 The position reached, with its suffix (for example "6TH"), which
. is set by #R$B68D.
  $B79F,$08,$07:$01 " HIGHEST".
  $B7A7,$05,$04:$01 "#STR(#PC)".
  $B7AC,$0F,$0E:$01 "#STR(#PC)".
  $B7BB,$0D,$0C:$01 "#STR(#PC)".
  $B7C8,$05,$04:$01 "#STR(#PC)".

c $B7CD Display Lives
@ $B7CD label=DisplayPlayerLives
D $B7CD Shows the number of lives of each player at the top of the screen as a
. digit followed by a small picture of Sabreman. If a player has no lives left
. then spaces are printed. The lives of player 1 are on the left and the lives
. of player 2 are on the right.
. .
. #PUSHS #UDGTABLE(default,centre)
. { =h Before }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(display-lives-before) }
. { =h After #R$B7CD }
. { #POKES$96BD,$05
. #SIM(start=$B7CD,stop=$0000,sp=$5B40)
. #SCR$02,$00,$00,$20,$02(display-lives-after) } UDGTABLE# #POPS
E $B7CD View the equivalent code in;
. #LIST
. { #COOKIE$7378 }
. { #JETPAC$70A4 }
. { #LUNARJETMAN$894F }
. { #PSSST$7325 }
. LIST#
N $B7CD Controller for 1UP lives.
  $B7CD,$03 Set the screen address of the 1UP lives in #REGhl.
  $B7D0,$03 Fetch the number of lives of 1UP.
  $B7D3,$03 Jump to #R$B7EF if 1UP has no lives left.
  $B7D6,$03 Display the lives of 1UP.
N $B7D9 Controller for 2UP lives.
@ $B7D9 label=Controller2UPLives
  $B7D9,$03 Set the screen address of the 2UP lives in #REGhl.
  $B7DC,$03 Fetch the number of lives of 2UP.
  $B7DF,$03 Jump to #R$B7F4 if 2UP has no lives left.
N $B7E2 Handles displaying the lives count and UDG character.
@ $B7E2 label=HandlerDisplayLives
  $B7E2,$02 Convert the number of lives to an ASCII digit.
  $B7E4,$03 Print the number of lives.
  $B7E7,$03 Point #REGde at the life icon at #R$B814.
  $B7EA,$02 Stash #REGbc and #REGde on the stack, ready for #R$B599.
  $B7EC,$03 Jump to #R$B599 to draw the life icon.
N $B7EF 1UP has no lives.
@ $B7EF label=Handler1UPNoLives
  $B7EF,$03 Clear the lives of 1UP.
  $B7F2,$02 Jump to #R$B7D9.
N $B7F4 2UP has no lives.
@ $B7F4 label=Handler2UPNoLives
  $B7F4,$02 Set the character to a space.
  $B7F6,$03 Print a space, to clear the number of lives.
  $B7F9,$02 Set the character to a space.
  $B7FB,$03 Print a space, to clear the life icon.
N $B7FE Return the 1UP player's lives left.
@ $B7FE label=FetchLives_1UP
  $B7FE,$06 Jump to #R$B808 if the active player is 2UP (so 1UP is inactive).
N $B804 Return currently active players lives left.
@ $B804 label=ActivePlayerLives
  $B804,$03 Fetch the lives of the active player from #R$96BD.
  $B807,$01 Return.
N $B808 Return inactive players lives left.
@ $B808 label=InactivePlayerLives
  $B808,$03 Fetch the lives of the inactive player from #R$96E0.
  $B80B,$01 Return.
N $B80C Return the 2UP player's lives left.
@ $B80C label=FetchLives_2UP
  $B80C,$06 Jump to #R$B808 if the active player is 1UP (so 2UP is inactive).
  $B812,$02 Jump to #R$B804.

b $B814 The UDG for the lives icon
@ $B814 label=UDG_Life
D $B814 The graphic which #R$B7CD draws for each of the lives of the player.
  $B814,$08,b$01 #UDGTABLE(default,centre) { #UDG#(#PC),attr=$07 } UDGTABLE#

c $B81C Slide Actor Past Objects
@ $B81C label=SlideActorPastObjects
D $B81C Stops an actor moving through the objects of the room. The new position
. of the actor is tested with #R$B873 against each of the objects in the
. layout of the room (the pointers to the layouts are in #R$6166, found from
. the room with #R$6066). If it overlaps with an object then the movement is
. tried in the X direction only and the Y direction only so that the actor can
. slide along the object. If neither works then the actor is left where it
. was.
. .
. The Y position of an actor is the position of its feet, and the Y position
. of an object is the top of it.
R $B81C B Height of the actor
R $B81C C Width of the actor
R $B81C DE New position of the actor, with Y in #REGd and X in #REGe
R $B81C IX Actor record
R $B81C O:DE The position that the actor can move to
  $B81C,$03 Stash the actor record and the size of the actor on the stack.
  $B81F,$03 Fetch the X position of the actor.
  $B822,$03 Fetch the Y position of the actor.
  $B825,$03 Remember the old X position in #R$96AE and the old Y position in
. #R$96AF.
  $B828,$03 Fetch the room of the actor.
  $B82B,$02 Clear #REGh.
  $B82D,$04 Add the layout table at #R$6066 to find the layout number of the
. room.
  $B831,$01 Fetch the layout number of the room.
  $B832,$02 Clear #REGh.
  $B834,$01 Double it, as each pointer is two bytes.
  $B835,$04 Add the table of object lists at #R$6166 to find the pointer to the
. list of objects.
  $B839,$01 Fetch the low byte of the address of the list of objects.
  $B83A,$01 Move to the high byte.
  $B83B,$01 Fetch the high byte of the address of the list of objects.
  $B83C,$01 Combine the low byte with the high byte.
  $B83D,$03 Point #REGix at the list of objects.
  $B840,$01 Restore the size of the actor from the stack.
N $B841 Test the new position.
  $B841,$02 Stash the pointer to the list of objects on the stack.
  $B843,$03 Test whether the new position overlaps with an object.
  $B846,$02 Restore the pointer to the list of objects from the stack.
  $B848,$02 Jump to #R$B870 if the new position does not overlap with an object.
N $B84A Try moving in the X direction only.
  $B84A,$01 Stash the new position on the stack.
  $B84B,$03 Fetch the old Y position.
  $B84E,$01 Use the old Y position instead.
  $B84F,$02 Stash the pointer to the list of objects on the stack.
  $B851,$03 Test whether moving in the X direction only overlaps with an object.
  $B854,$02 Restore the pointer to the list of objects from the stack.
  $B856,$01 Restore the new position from the stack.
  $B857,$02 Jump to #R$B85D if the actor can move in the X direction.
  $B859,$04 Keep the old X position, as the actor cannot move in the X
. direction.
N $B85D Try moving in the Y direction only.
@ $B85D label=SlideActorPastObjects_Vertical
  $B85D,$01 Stash the new position on the stack.
  $B85E,$04 Use the old X position instead.
  $B862,$02 Stash the pointer to the list of objects on the stack.
  $B864,$03 Test whether moving in the Y direction only overlaps with an object.
  $B867,$02 Restore the pointer to the list of objects from the stack.
  $B869,$01 Restore the new position from the stack.
  $B86A,$02 Jump to #R$B870 if the actor can move in the Y direction.
  $B86C,$04 Keep the old Y position, as the actor cannot move in the Y
. direction.
@ $B870 label=SlideActorPastObjects_Return
  $B870,$02 Restore the actor record from the stack.
  $B872,$01 Return.

c $B873 Test Object Overlap
@ $B873 label=TestObjectOverlap
D $B873 Tests whether an actor at a position would overlap with any object in a
. list. The list is made up of four byte entries. The first two bytes are the
. address of the graphic of the object, then the X and Y positions of the
. object. The list ends with an address of zero. The first two bytes of the
. graphic are the height in pixels and the width in bytes.
R $B873 B Height of the actor
R $B873 C Width of the actor
R $B873 D Y position of the actor
R $B873 E X position of the actor
R $B873 IX Pointer to the list of objects
R $B873 O:F Carry flag set if the actor overlaps with an object
  $B873,$03 Fetch the low byte of the address of the object.
  $B876,$03 Fetch the high byte of the address of the object.
  $B879,$02 Combine the bytes to check for zero.
  $B87B,$01 Return if the address is zero (the end of the list), with the
. carry flag reset.
  $B87C,$01 Fetch the height of the object in pixels.
  $B87D,$01 Move to the width of the object.
  $B87E,$01 Fetch the width of the object in bytes.
  $B87F,$01 Set the height of the object in #REGl.
  $B880,$01 Fetch the width of the object in bytes.
  $B881,$03 Multiply by eight.
  $B884,$02,b$01 Keep only bits 3-7.
  $B886,$01 #REGh=the width of the object in pixels.
N $B887 Compare the X positions.
  $B887,$01 Fetch the X position of the actor.
  $B888,$03 Subtract the X position of the object.
  $B88B,$03 Jump to #R$B8A7 if the actor is not to the left of the object.
  $B88E,$01 Flip the bits to get the distance from the object, less one.
  $B88F,$01 Compare with the width of the actor.
@ $B890 label=TestObjectOverlap_Horizontal
  $B890,$02 Jump to #R$B89D if the actor is too far away.
N $B892 Compare the Y positions.
  $B892,$01 Fetch the Y position of the actor.
  $B893,$01 Subtract the height of the object.
  $B894,$03 Subtract the Y position of the object.
  $B897,$03 Jump to #R$B8AA if the feet of the actor are below the object.
  $B89A,$01 Flip the bits to get the distance from the object, less one.
  $B89B,$01 Compare with the height of the object.
@ $B89C label=TestObjectOverlap_Return
  $B89C,$01 Return if the actor overlaps with the object.
N $B89D Move on to the next object.
@ $B89D label=TestObjectOverlap_Next
  $B89D,$08 Move #REGix on four bytes.
  $B8A5,$02 Jump to #R$B873.
N $B8A7 The actor is to the right of the object so compare with the width of the
. object.
@ $B8A7 label=TestObjectOverlap_Right
  $B8A7,$01 Compare with the width of the object.
  $B8A8,$02 Jump to #R$B890.
N $B8AA The feet of the actor are below the object, so compare with the height
. of the actor.
@ $B8AA label=TestObjectOverlap_Below
  $B8AA,$01 Compare with the height of the actor.
  $B8AB,$02 Jump to #R$B89C.

c $B8AD Calculate Screen Address
@ $B8AD label=ScreenAddress
D $B8AD Converts pixel coordinates into the address of the byte in the display
. file that holds the pixel.
E $B8AD View the equivalent code in;
. #LIST
. { #ATICATAC$9BA2 }
. { #COOKIE$76E3 }
. { #JETPAC$7308 }
. { #LUNARJETMAN$851E }
. { #MARTIANOIDS$BD4B }
. { #PSSST$759A }
. { #TRANZAM$6F10 }
. { #UNDERWURLDE$ADF8 }
. LIST#
R $B8AD H Y coordinate
R $B8AD L X coordinate
R $B8AD O:HL Screen address
N $B8AD The low byte is made up of the column (bits 0-4) and the character row
. within the third of the screen (bits 5-7).
  $B8AD,$01 #REGa=#REGl.
  $B8AE,$03 Divide the X coordinate by #N$08 to get the column.
  $B8B1,$02,b$01 Keep only bits 0-4.
  $B8B3,$01 #REGl=#REGa.
  $B8B4,$01 #REGa=#REGh.
  $B8B5,$02 Multiply the Y coordinate by #N$04, which moves bits 3-5 into bits
. 5-7.
  $B8B7,$02,b$01 Keep only bits 5-7.
  $B8B9,$01 Merge in the column.
  $B8BA,$01 #REGl=#REGa.
N $B8BB The high byte is made up of the third of the screen (bits 3-4) and the
. pixel line within the character (bits 0-2).
  $B8BB,$01 #REGa=#REGh.
  $B8BC,$02,b$01 Keep only bits 0-2 (the pixel line).
  $B8BE,$01 Store the pixel line in #REGaf'.
  $B8BF,$01 #REGa=#REGh.
  $B8C0,$03 Divide the Y coordinate by #N$08.
  $B8C3,$02,b$01 Keep only bits 3-4 (the third of the screen).
  $B8C5,$02,b$01 Set bit 6 to point to the display file.
  $B8C7,$01 #REGh=#REGa.
  $B8C8,$01 Fetch the pixel line from #REGaf'.
  $B8C9,$01 Merge in the third of the screen.
  $B8CA,$01 #REGh=#REGa.
  $B8CB,$01 Return.

c $B8CC Screen Address One Pixel Below
@ $B8CC label=ScreenPosition1PixelBelow
D $B8CC Calculates the address of the pixel line below the one at a screen
. address, taking into consideration the layout of the display file.
E $B8CC View the equivalent code in;
. #LIST
. { #MARTIANOIDS$BD3A }
. { #UNDERWURLDE$9C2B }
. LIST#
R $B8CC HL Current screen address
R $B8CC O:HL Screen address of the pixel line below
  $B8CC,$01 Increment #REGh to move down one pixel on screen.
  $B8CD,$01 #REGa=#REGh.
  $B8CE,$02,b$01 Keep only bits 0-2.
  $B8D0,$01 If a character line has not been crossed then return.
  $B8D1,$04 #REGl=#REGl+#N$20.
  $B8D5,$02,b$01 Keep only bits 5-7.
  $B8D7,$01 If a new section of the screen has not been crossed then return.
  $B8D8,$04 #REGh=#REGh-#N$08.
  $B8DC,$01 Return.

c $B8DD Calculate Attribute Address
@ $B8DD label=AttributeAddress
E $B8DD View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #COOKIE$7534 }
. { #JETPAC$720E }
. { #LUNARJETMAN$8506 }
. { #MARTIANOIDS$BD6A }
. { #PSSST$748F }
. { #UNDERWURLDE$ADE0 }
. LIST#
N $B8DD Converts a given pixel address to the associated attribute buffer address.
R $B8DD HL Pixel address co-ordinates
R $B8DD O:HL Attribute buffer address
  $B8DD,$01 Stash #REGbc on the stack.
  $B8DE,$01 Horizontal co-ordinate.
  $B8DF,$03 Divide by #N$08.
  $B8E2,$02,b$01 Keep only bits 0-4 (#N$00-#N$1F / minimum-maximum horizontal screen values).
  $B8E4,$01 Store this back in #REGl.
  $B8E5,$01 Vertical co-ordinate.
  $B8E6,$02 Multiply by #N$04.
  $B8E8,$01 Store this in #REGc temporarily.
  $B8E9,$02,b$01 Keep only bits 5-7.
  $B8EB,$01 Set the bits from #REGl.
  $B8EC,$01 #REGl=#REGa.
  $B8ED,$01 Fetch the stored value from #REGc.
  $B8EE,$02,b$01 Keep only bits 0-1.
  $B8F0,$02,b$01 Set MSB of the attribute buffer #N$58. This ensures our value is >= #R$5800.
  $B8F2,$01 Store this back in #REGh.
  $B8F3,$01 Restore #REGbc from the stack.
  $B8F4,$01 Return.

c $B8F5 Remove Entity
@ $B8F5 label=RemoveEntity
D $B8F5 Removes an entity from the screen, by drawing the sprite at the old
. position that was saved by #R$BB0B. The sprites are drawn with XOR so this
. erases the sprite. No new sprite is drawn, so the row count of the new sprite
. is zero.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$B8F5 }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #SIM(start=$B919,stop=$0000,ix=$970E,sp=$5B40)
. #SIM(start=$BB24,stop=$0000,ix=$970E,sp=$5B40)
. #SIM(start=$BB0B,stop=$0000,ix=$970E,sp=$5B40)
. #SCR$03,$0C,$0D,$08,$06(remove-entity-before)
. | #SIM(start=$B8F5,stop=$0000,ix=$970E,sp=$5B40)
. #SCR$03,$0C,$0D,$08,$06(remove-entity-after) } UDGTABLE# #POPS
E $B8F5 View the equivalent code in;
. #LIST
. { #ATICATAC$9F56 }
. { #COOKIE$7607 }
. { #JETPAC$72A5 }
. { #PSSST$7526 }
. { #TRANZAM$7139 }
. { #UNDERWURLDE$9636 }
. LIST#
  $B8F5,$03 Prepare the registers for the sprite at its old position.
  $B8F8,$01 Switch to the shadow registers.
  $B8F9,$02 Set #REGa and #REGc to #N$00.
  $B8FB,$03 Write #N$00 to #R$96A4.
  $B8FE,$01 Switch back to the normal registers.
  $B8FF,$03 Jump to #R$B9DA.

c $B902 Build Shift Table
@ $B902 label=BuildShiftTable
D $B902 Builds a lookup table in the top #N$1000 bytes of memory (#N$F000 to
. #N$FFFF) which the sprite drawing routines use to position a sprite at any
. pixel.
. .
. For every byte value, and for each of the eight possible pixel offsets, the
. value shifted left by that many bits is stored as a 16-bit number. The low
. byte is written to the page at #N$FF - (#N$02 * offset) and the high byte to
. the page below it, both at the position given by the byte value.
E $B902 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$9613 }
. LIST#
N $B902 Work through each byte value in turn, starting with #N$00.
  $B902,$02 #REGl=#N$00 (the byte value).
N $B904 Start with no shift (#REGe holds the low byte and #REGd the high byte
. of the shifted value).
@ $B904 label=BuildShiftTable_Value
  $B904,$02 #REGd=#N$00.
  $B906,$01 #REGe=#REGl.
  $B907,$02 #REGh=#N$FF (the page for the first low byte).
  $B909,$02 #REGb=#N$08 (counter, one for each pixel offset).
N $B90B Store the low and the high byte, then shift the 16-bit value left by one
. bit for the next offset.
@ $B90B label=BuildShiftTable_Offset
  $B90B,$01 Write the low byte.
  $B90C,$01 Move down a page.
  $B90D,$01 Write the high byte.
  $B90E,$01 Move down a page.
  $B90F,$02 Shift #REGe left one bit (bit 7 goes into the carry flag).
  $B911,$02 Rotate #REGd left one bit, bringing in the carry flag.
  $B913,$02 Decrease counter by one and loop back to #R$B90B until zero.
  $B915,$01 Move onto the next byte value.
  $B916,$02 Jump back to #R$B904 until every byte value has been done.
  $B918,$01 Return.

c $B919 Draw Entity
@ $B919 label=DrawEntity
D $B919 Draws an entity on the screen, at its current position, using XOR.
. Nothing is erased, as the entity has no old sprite on the screen, so the row
. count of the old sprite is zero.
. .
. The attributes are set separately by #R$BB24.
E $B919 View the equivalent code in;
. #LIST
. { #ATICATAC$9F4A }
. { #COOKIE$7617 }
. { #JETPAC$72B5 }
. { #PSSST$7536 }
. { #TRANZAM$7149 }
. { #UNDERWURLDE$962A }
. LIST#
R $B919 IX Actor record
N $B919 #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$B919 and #R$BB24 }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #SCR$03,$0C,$0D,$08,$06(entity-before)
. | #SIM(start=$B919,stop=$0000,ix=$970E,sp=$5B40)
. #SIM(start=$BB24,stop=$0000,ix=$970E,sp=$5B40)
. #SCR$03,$0C,$0D,$08,$06(entity-after) } UDGTABLE# #POPS
  $B919,$03 Prepare the registers for the sprite at its new position.
  $B91C,$01 Switch to the shadow registers, which belong to the old sprite.
  $B91D,$04 Write #N$00 to #R$96A3 as there are no rows of the old sprite to
. draw.
  $B921,$01 #REGc=#N$00.
  $B922,$03 Jump to #R$B9DA to draw the sprite.

c $B925 Get Sprite "A"
@ $B925 label=GetSpriteA
D $B925 Looks up the address of the data of the sprite whose ID was saved by
. #R$BB0B.
E $B925 View the equivalent code in;
. #LIST
. { #ATICATAC$9E86 }
. { #UNDERWURLDE$9643 }
. LIST#
E $B925 Continue on to #R$B928.
R $B925 O:DE The sprite address
  $B925,$03 #REGa=*#R$969F.

c $B928 Fetch Sprite
@ $B928 label=FetchSprite
D $B928 Looks up the address of the data of a sprite in the table at #R$BF84.
E $B928 View the equivalent code in;
. #LIST
. { #ATICATAC$9E89 }
. { #LUNARJETMAN$8568 }
. { #UNDERWURLDE$9646 }
. LIST#
R $B928 A The Sprite ID
R $B928 O:DE The sprite address
  $B928,$03 Create an offset in #REGhl.
  $B92B,$01 #REGhl=#REGhl * 2.
  $B92C,$04 #REGhl=#R$BF84 + offset.
  $B930,$03 #REGde=the sprite address.
  $B933,$01 Return.

c $B934 Fetch Actor Sprite
@ $B934 label=FetchActorSprite
D $B934 Looks up the address of the data of the sprite of an actor.
E $B934 View the equivalent code in;
. #LIST
. { #ATICATAC$9E96 }
. { #LUNARJETMAN$857F }
. { #UNDERWURLDE$9652 }
. LIST#
R $B934 IX Actor record
R $B934 O:DE The sprite address
  $B934,$03 #REGa=*#REGix+#N$00 (sprite reference).
  $B937,$02 Jump to #R$B928.

c $B939 Prepare Draw 2/ 3 Byte Sprite
@ $B939 label=PrepDraw23
D $B939 Gets the registers ready to draw the sprite of an entity at its old
. position, which was saved by #R$BB0B.
. .
. The shift table page is put in #REGb, the screen address of the bottom row is
. put in #REGhl and the pointer to the pixel data is put in #REGde. The operand
. of the jump at #R$BA12 is changed so that the unrolled code that follows it
. draws the right number of bytes for each row, and the number of rows is stored
. in #R$96A3.
E $B939 View the equivalent code in;
. #LIST
. { #ATICATAC$9F80 }
. { #UNDERWURLDE$9657 }
. LIST#
R $B939 O:B Page of the shift table
R $B939 O:C #N$00
R $B939 O:DE Address of the pixel data
R $B939 O:HL Screen address of the bottom row
  $B939,$03 Fetch the address of the sprite data in #REGde.
  $B93C,$03 Fetch the old X position into #REGl and the old Y position into
. #REGh from #R$96A0.
  $B93F,$01 #REGa=#REGl.
  $B940,$01 Subtract one.
  $B941,$01 Multiply by two (rotate left).
  $B942,$02,b$01 Keep only bits 1-3.
  $B944,$02,b$01 Set bits 4-7 to point at the pages #N$F0 to #N$FF.
  $B946,$01 Store the page of the shift table in #REGb.
  $B947,$01 Fetch the width of the sprite in bytes.
  $B948,$01 Move on to the height of the sprite.
  $B949,$02 Negate the width.
  $B94B,$02,b$01 Keep only bits 0-2.
  $B94D,$02 Multiply by four.
  $B94F,$01 Store the result in #REGc.
  $B950,$01 Multiply by two.
  $B951,$01 Add the result so that it is multiplied by twelve (the size of the
. code for one byte of the row).
  $B952,$01 Store the offset in #REGc.
  $B953,$01 #REGa=#REGl.
  $B954,$02,b$01 Keep only the pixel offset (bits 0-2).
  $B956,$01 Fetch the offset.
  $B957,$02 Jump to #R$B95B if the sprite does not start on a character
. boundary.
  $B959,$02 Add #N$06 to the offset to skip the first six bytes of the code for
. the first byte of the row, as no cell to the left is needed.
@ $B95B label=PrepDraw23_SetJump
  $B95B,$03 Change the operand of the jump at #R$BA12.
  $B95E,$01 Fetch the height of the sprite.
  $B95F,$01 Move on to the pixel data.
  $B960,$03 Write the number of rows of the old sprite to #R$96A3.
  $B963,$03 Convert the position into the screen address.
  $B966,$02 #REGc=#N$00.
  $B968,$01 Return.

c $B969 Prepare Draw 2 Byte Sprite
@ $B969 label=PrepDraw2
D $B969 Gets the registers ready to draw the sprite of the entity that #REGix
. points at, at its current position.
. .
. It does what #R$B939 does for the old sprite, but it uses the position and the
. sprite of the entity, changes the operand of the jump at #R$BA91 (used by the
. code at #R$BA8C) and stores the number of rows in #R$96A4 and #R$96A5. The
. number of character cells that the sprite covers in each row (one more than
. the width if the sprite is not aligned to a character boundary) is stored in
. #R$96A6.
E $B969 View the equivalent code in;
. #LIST
. { #ATICATAC$9F9F }
. { #UNDERWURLDE$9689 }
. LIST#
R $B969 IX Actor record
R $B969 O:B Page of the shift table
R $B969 O:C #N$00
R $B969 O:DE Address of the pixel data
R $B969 O:HL Screen address of the bottom row
  $B969,$03 Fetch the address of the sprite data in #REGde.
  $B96C,$03 Fetch the X position of the entity into #REGl.
  $B96F,$03 Fetch the Y position of the entity into #REGh.
  $B972,$01 #REGa=#REGl.
  $B973,$01 Subtract one.
  $B974,$01 Multiply by two (rotate left).
  $B975,$02,b$01 Keep only bits 1-3.
  $B977,$02,b$01 Set bits 4-7 to point at the pages #N$F0 to #N$FF.
  $B979,$01 Store the page of the shift table in #REGb.
  $B97A,$01 #REGa=#REGl.
  $B97B,$02,b$01 Keep only the pixel offset (bits 0-2).
  $B97D,$01 Fetch the width of the sprite in bytes.
  $B97E,$02 Jump to #R$B981 if the sprite starts on a character boundary.
  $B980,$01 Add one for the extra cell that the shifted sprite needs.
@ $B981 label=PrepDraw2_StoreCells
  $B981,$03 Write the number of cells in each row to #R$96A6.
  $B984,$01 Fetch the width of the sprite in bytes.
  $B985,$01 Move on to the height of the sprite.
  $B986,$02 Negate the width.
  $B988,$02,b$01 Keep only bits 0-2.
  $B98A,$02 Multiply by four.
  $B98C,$01 Store the result in #REGc.
  $B98D,$01 Multiply by two.
  $B98E,$01 Add the result so that it is multiplied by twelve (the size of the
. code for one byte of the row).
  $B98F,$01 Store the offset in #REGc.
  $B990,$01 #REGa=#REGl.
  $B991,$02,b$01 Keep only the pixel offset (bits 0-2).
  $B993,$01 Fetch the offset.
  $B994,$02 Jump to #R$B998 if the sprite does not start on a character
. boundary.
  $B996,$02 Add #N$06 to the offset to skip the first six bytes of the code for
. the first byte of the row, as no cell to the left is needed.
@ $B998 label=PrepDraw2_SetJump
  $B998,$03 Change the operand of the jump at #R$BA91.
  $B99B,$01 Fetch the height of the sprite.
  $B99C,$01 Move on to the pixel data.
  $B99D,$03 Write the number of rows of the new sprite to #R$96A4.
  $B9A0,$03 Write the height of the sprite to #R$96A5.
  $B9A3,$03 Convert the position into the screen address.
  $B9A6,$02 #REGc=#N$00.
  $B9A8,$01 Return.

c $B9A9 Display Entity
@ $B9A9 label=DisplayEntity
D $B9A9 Moves an entity on the screen, by erasing the sprite at its old position
. (saved by #R$BB0B) and drawing it at its new one.
. .
. Both sprites are drawn with XOR, a row at a time, so that the rows are
. alternated between the two sprites and the screen is never without the sprite
. for long. If the sprites are offset vertically, the rows of the sprite that
. has no matching row in the other one are drawn first.
. .
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After #R$B9A9 and #R$BB24 }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #SIM(start=$B919,stop=$0000,ix=$970E,sp=$5B40)
. #SIM(start=$BB24,stop=$0000,ix=$970E,sp=$5B40)
. #SIM(start=$BB0B,stop=$0000,ix=$970E,sp=$5B40)
. #SCR$03,$0A,$0B,$0E,$08(display-entity-before)
. | #POKES$9711,$80;$9712,$7B
. #SIM(start=$B9A9,stop=$0000,ix=$970E,sp=$5B40)
. #SIM(start=$BB24,stop=$0000,ix=$970E,sp=$5B40)
. #SCR$03,$0A,$0B,$0E,$08(display-entity-after) } UDGTABLE# #POPS
E $B9A9 View the equivalent code in;
. #LIST
. { #ATICATAC$9FCA }
. { #COOKIE$75CC }
. { #JETPAC$726A }
. { #PSSST$74EB }
. { #TRANZAM$7101 }
. { #TRANZAM$7108 }
. { #UNDERWURLDE$96F7 }
. LIST#
R $B9A9 IX Actor record
  $B9A9,$03 Prepare the registers for the sprite at its new position.
  $B9AC,$01 Switch to the registers of the old sprite.
  $B9AD,$03 Prepare the registers for the sprite at its old position.
  $B9B0,$03 Fetch the old Y position from #R$96A1.
  $B9B3,$03 Subtract the new Y position of the entity.
  $B9B6,$03 Jump to #R$B9F4 if the Y position has not changed.
  $B9B9,$03 Jump to #R$B9CB if the sprite has moved down the screen.
N $B9BC The old sprite is lower than the new one, so draw the bottom rows of the
. old sprite on their own first.
  $B9BC,$01 Copy the number of rows that stand alone to #REGc.
  $B9BD,$03 Fetch the number of rows of the old sprite from #R$96A3.
  $B9C0,$01 Compare it with the number of rows that stand alone.
  $B9C1,$03 Jump to #R$B9F4 if the old sprite has no more rows than that, so
. that the sprites do not overlap and are each drawn in full.
  $B9C4,$01 Subtract the number of rows that stand alone.
  $B9C5,$03 Write the number of rows that remain to #R$96A3.
  $B9C8,$03 Jump to #R$B9DA to draw those rows of the old sprite on their own.

c $B9CB Display Entity Moved Down
@ $B9CB label=DisplayEntity_NewLower
D $B9CB Used by #R$B9A9 when the new sprite is lower than the old one. The
. bottom rows of the new sprite are drawn on their own first.
E $B9CB View the equivalent code in;
. #LIST
. { #ATICATAC$9FEC }
. { #COOKIE$75EE }
. { #JETPAC$728C }
. { #PSSST$750D }
. { #TRANZAM$712A }
. { #UNDERWURLDE$9719 }
. LIST#
R $B9CB A Old Y position minus the new Y position (negative)
  $B9CB,$01 Switch to the registers of the new sprite.
  $B9CC,$02 Make the difference positive.
  $B9CE,$01 Copy the number of rows that stand alone to #REGc.
  $B9CF,$03 Fetch the number of rows of the new sprite from #R$96A4.
  $B9D2,$01 Compare it with the number of rows that stand alone.
  $B9D3,$03 Jump to #R$B9F3 if the new sprite has no more rows than that, so
. that the sprites do not overlap and are each drawn in full.
  $B9D6,$01 Subtract the number of rows that stand alone.
  $B9D7,$03 Jump to #R$BA07 to store the number of rows that remain and draw
. those rows of the new sprite on their own.

c $B9DA XOR Sprite Loop
@ $B9DA label=XORSpriteLoop
D $B9DA Draws the old sprite and the new sprite a row at a time, alternating
. between the two, until every row of both has been drawn. The set of registers
. that is current on entry belongs to the old sprite, which is drawn by
. #R$BA0D. The other set belongs to the new sprite, which is drawn by #R$BA8C.
. .
. In each set #REGhl is the screen address of the next row (the sprites are
. drawn from the bottom row upwards), #REGde points at the pixel data and #REGb
. is the page of the shift table. #REGc counts the rows that remain.
. .
. When both counts reach zero, the counts that are held in #R$96A3 (old sprite)
. and #R$96A4 (new sprite) are loaded and the whole process repeats. The
. routine returns when those are zero as well. This allows the rows that have
. no partner to be drawn first (see #R$B9A9).
E $B9DA View the equivalent code in;
. #LIST
. { #ATICATAC$9E9B }
. { #COOKIE$763A }
. { #LUNARJETMAN$858E }
. { #UNDERWURLDE$9728 }
. LIST#
N $B9DA Draw a row of the old sprite, if it has any rows left.
  $B9DA,$01 Fetch the row count of the old sprite.
  $B9DB,$01 Set the flags.
  $B9DC,$02 Jump to #R$B9EE if there are no rows left.
  $B9DE,$01 Decrease the row count.
  $B9DF,$03 Draw a row of the old sprite.
N $B9E2 Draw a row of the new sprite, if it has any rows left.
  $B9E2,$01 Switch to the registers of the new sprite.
  $B9E3,$01 Fetch the row count of the new sprite.
  $B9E4,$01 Set the flags.
  $B9E5,$02 Jump to #R$B9EB if there are no rows left.
@ $B9E7 label=XORSpriteLoop_NewRow
  $B9E7,$01 Decrease the row count.
  $B9E8,$03 Draw a row of the new sprite.
@ $B9EB label=XORSpriteLoop_OldRow
  $B9EB,$01 Switch to the registers of the old sprite.
  $B9EC,$02 Jump to #R$B9DA to draw the next pair of rows.
N $B9EE The old sprite has no rows left, so draw the rest of the new sprite.
@ $B9EE label=XORSpriteLoop_NewOnly
  $B9EE,$01 Switch to the registers of the new sprite.
  $B9EF,$01 Fetch the row count of the new sprite.
  $B9F0,$01 Set the flags.
  $B9F1,$02 Jump to #R$B9E7 if there are rows left.
@ $B9F3 label=XORSpriteLoop_Done
  $B9F3,$01 Switch to the registers of the old sprite.
N $B9F4 Both of the counts are zero. Load the row counts that were stored by the
. preparation routines and go round again, unless they are zero too.
@ $B9F4 label=XORSpriteLoop_Reload
  $B9F4,$03 Fetch the number of rows of the old sprite from #R$96A3.
  $B9F7,$01 Copy the number of rows to #REGc.
  $B9F8,$03 Fetch the number of rows of the new sprite from #R$96A4.
  $B9FB,$01 Combine it with the number of rows of the old sprite.
  $B9FC,$01 Return if there are no rows left to draw.
  $B9FD,$01 #REGa=#N$00.
  $B9FE,$03 Write #REGa to #R$96A3.
  $BA01,$01 Switch to the registers of the new sprite.
  $BA02,$03 Fetch the number of rows of the new sprite from #R$96A4.
  $BA05,$01 Copy the number of rows to #REGc.
  $BA06,$01 #REGa=#N$00.
@ $BA07 label=XORSpriteLoop_StoreNew
  $BA07,$03 Write #REGa to #R$96A4.
  $BA0A,$01 Switch to the registers of the old sprite.
  $BA0B,$02 Jump to #R$B9DA to start drawing rows.

c $BA0D Draw Old Entity Row
@ $BA0D label=DrawOldEntityRow
D $BA0D Draws one row of the old sprite, using XOR, and moves up to the next
. row.
. .
. The row is drawn by unrolled code with one piece of #N$0C bytes for each byte
. of the row (up to eight bytes, with the last piece being longer so it can stop
. at the right of the screen). The operand of the jump at #R$BA12 is changed by
. #R$B939 so that the jump lands on the first piece that is needed. If the
. sprite is aligned to a character boundary the jump goes six bytes further in,
. which leaves out the first write.
E $BA0D View the equivalent code in;
. #LIST
. { #UNDERWURLDE$975B }
. LIST#
R $BA0D B Page of the shift table
R $BA0D C Number of rows left
R $BA0D DE Pointer to the pixel data
R $BA0D HL Screen address of the row
R $BA0D O:C Number of rows left
R $BA0D O:DE Pointer to the next row of pixel data
R $BA0D O:HL Screen address of the next row
  $BA0D,$01 Copy the row count to #REGa.
  $BA0E,$01 Store the row count in #REGaf'.
  $BA0F,$01 Fetch the first byte of the row.
  $BA10,$01 Copy it to #REGc to use as the index into the shift table.
  $BA11,$01 Stash the screen address on the stack.
  $BA12,$02 Jump into the unrolled code. The operand of this instruction is
. changed by #R$B939.
@ $BA14 label=DrawOldEntityRow_Byte_1
  $BA14,$06 Byte 1 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BA1A label=DrawOldEntityRow_Byte_1_Right
  $BA1A,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BA20 label=DrawOldEntityRow_Byte_2
  $BA20,$06 Byte 2 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BA26 label=DrawOldEntityRow_Byte_2_Right
  $BA26,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BA2C label=DrawOldEntityRow_Byte_3
  $BA2C,$06 Byte 3 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BA32 label=DrawOldEntityRow_Byte_3_Right
  $BA32,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BA38 label=DrawOldEntityRow_Byte_4
  $BA38,$06 Byte 4 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BA3E label=DrawOldEntityRow_Byte_4_Right
  $BA3E,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BA44 label=DrawOldEntityRow_Byte_5
  $BA44,$06 Byte 5 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BA4A label=DrawOldEntityRow_Byte_5_Right
  $BA4A,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BA50 label=DrawOldEntityRow_Byte_6
  $BA50,$06 Byte 6 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BA56 label=DrawOldEntityRow_Byte_6_Right
  $BA56,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BA5C label=DrawOldEntityRow_Byte_7
  $BA5C,$06 Byte 7 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BA62 label=DrawOldEntityRow_Byte_7_Right
  $BA62,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BA68 label=DrawOldEntityRow_Byte_8
  $BA68,$06 Byte 8 of the row: look up the shifted byte for the left cell
. and XOR it onto the screen.
@ $BA6E label=DrawOldEntityRow_Byte_8_Right
  $BA6E,$01 #REGa=#REGl.
  $BA6F,$02,b$01 Keep only bits 0-4.
  $BA71,$02 Jump to #R$BA78 if the first cell was at the right of the
. screen, as the second cell is then not written.
  $BA73,$05 Look up the shifted byte for the cell to the right and XOR it
. onto the screen.
@ $BA78 label=DrawOldEntityRow_Byte_8_Next
  $BA78,$01 Move on to the next byte of pixel data.
  $BA79,$01 Fetch the row count from #REGaf'.
  $BA7A,$01 Copy the row count to #REGc.
  $BA7B,$01 Restore the screen address from the stack.
  $BA7C,$01 Move up one pixel line.
  $BA7D,$01 #REGa=#REGh.
  $BA7E,$01 Flip the bits.
  $BA7F,$02,b$01 Keep only the pixel line bits (bits 0-2).
  $BA81,$01 Return if the move up stayed inside the same character cell.
  $BA82,$04 Subtract #N$20 from the low byte to move up to the previous
. character row.
  $BA86,$01 Return if the move up stayed inside the same third of the screen.
  $BA87,$04 Add #N$08 to the high byte to move up to the previous third of the
. screen.
  $BA8B,$01 Return.

c $BA8C Draw New Entity Row
@ $BA8C label=DrawNewEntityRow
D $BA8C Draws one row of the new sprite, using XOR, and moves up to the next
. row. It is a copy of #R$BA0D that uses the jump at #R$BA91, which is changed
. by #R$B969.
E $BA8C View the equivalent code in;
. #LIST
. { #UNDERWURLDE$97E1 }
. LIST#
R $BA8C B Page of the shift table
R $BA8C C Number of rows left
R $BA8C DE Pointer to the pixel data
R $BA8C HL Screen address of the row
R $BA8C O:C Number of rows left
R $BA8C O:DE Pointer to the next row of pixel data
R $BA8C O:HL Screen address of the next row
  $BA8C,$01 Copy the row count to #REGa.
  $BA8D,$01 Store the row count in #REGaf'.
  $BA8E,$01 Fetch the first byte of the row.
  $BA8F,$01 Copy it to #REGc to use as the index into the shift table.
  $BA90,$01 Stash the screen address on the stack.
  $BA91,$02 Jump into the unrolled code. The operand of this instruction is
. changed by #R$B969.
@ $BA93 label=DrawNewEntityRow_Byte_1
  $BA93,$06 Byte 1 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BA99 label=DrawNewEntityRow_Byte_1_Right
  $BA99,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BA9F label=DrawNewEntityRow_Byte_2
  $BA9F,$06 Byte 2 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BAA5 label=DrawNewEntityRow_Byte_2_Right
  $BAA5,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BAAB label=DrawNewEntityRow_Byte_3
  $BAAB,$06 Byte 3 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BAB1 label=DrawNewEntityRow_Byte_3_Right
  $BAB1,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BAB7 label=DrawNewEntityRow_Byte_4
  $BAB7,$06 Byte 4 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BABD label=DrawNewEntityRow_Byte_4_Right
  $BABD,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BAC3 label=DrawNewEntityRow_Byte_5
  $BAC3,$06 Byte 5 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BAC9 label=DrawNewEntityRow_Byte_5_Right
  $BAC9,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BACF label=DrawNewEntityRow_Byte_6
  $BACF,$06 Byte 6 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BAD5 label=DrawNewEntityRow_Byte_6_Right
  $BAD5,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BADB label=DrawNewEntityRow_Byte_7
  $BADB,$06 Byte 7 of the row: look up the shifted byte for the left
. cell and XOR it onto the screen.
@ $BAE1 label=DrawNewEntityRow_Byte_7_Right
  $BAE1,$06 Look up the shifted byte for the cell to the right and XOR it
. onto the screen, then move on to the next byte of pixel data.
@ $BAE7 label=DrawNewEntityRow_Byte_8
  $BAE7,$06 Byte 8 of the row: look up the shifted byte for the left cell
. and XOR it onto the screen.
@ $BAED label=DrawNewEntityRow_Byte_8_Right
  $BAED,$01 #REGa=#REGl.
  $BAEE,$02,b$01 Keep only bits 0-4.
  $BAF0,$02 Jump to #R$BAF7 if the first cell was at the right of the
. screen, as the second cell is then not written.
  $BAF2,$05 Look up the shifted byte for the cell to the right and XOR it
. onto the screen.
@ $BAF7 label=DrawNewEntityRow_Byte_8_Next
  $BAF7,$01 Move on to the next byte of pixel data.
  $BAF8,$01 Fetch the row count from #REGaf'.
  $BAF9,$01 Copy the row count to #REGc.
  $BAFA,$01 Restore the screen address from the stack.
  $BAFB,$01 Move up one pixel line.
  $BAFC,$01 #REGa=#REGh.
  $BAFD,$01 Flip the bits.
  $BAFE,$02,b$01 Keep only the pixel line bits (bits 0-2).
  $BB00,$01 Return if the move up stayed inside the same character cell.
  $BB01,$04 Subtract #N$20 from the low byte to move up to the previous
. character row.
  $BB05,$01 Return if the move up stayed inside the same third of the screen.
  $BB06,$04 Add #N$08 to the high byte to move up to the previous third of the
. screen.
  $BB0A,$01 Return.

c $BB0B Store Entity
@ $BB0B label=StoreEntity
D $BB0B Saves the position, the sprite ID and the room of an actor, so that the
. sprite can be erased from its old position later (see #R$B9A9 and #R$B8F5).
. The values are saved in #R$96A0 (X), #R$96A1 (Y), #R$969F (sprite ID) and
. #R$96A2 (room).
E $BB0B View the equivalent code in;
. #LIST
. { #ATICATAC$9FFB }
. { #COOKIE$76D0 }
. { #JETPAC$7327 }
. { #PSSST$75B9 }
. { #TRANZAM$71ED }
. { #UNDERWURLDE$989F }
. LIST#
R $BB0B IX Actor Entity
  $BB0B,$06 Copy the X position of the actor to #R$96A0.
  $BB11,$06 Copy the Y position of the actor to #R$96A1.
  $BB17,$06 Copy the sprite ID of the actor to #R$969F.
  $BB1D,$06 Copy the room of the actor to #R$96A2.
  $BB23,$01 Return.

c $BB24 Colour Entity
@ $BB24 label=ColourEntity
D $BB24 Colours the attribute cells covered by the sprite that has just been
. drawn with #R$B919 using the colour held in byte #N$05 of the actor. Only
. cells with a black paper are changed (see #R$BB45), so the colour of anything
. already drawn behind the sprite is kept.
E $BB24 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$9867 }
. LIST#
R $BB24 IX Actor Entity
E $BB24 Continue on to #R$BB45.
  $BB24,$03 Fetch the X position of the actor.
  $BB27,$03 Fetch the Y position of the actor.
  $BB2A,$03 Fetch the colour of the actor.
  $BB2D,$04 Fetch the number of columns the sprite covers from #R$96A6 into
. #REGb.
  $BB31,$02 Invert the Y position.
  $BB33,$02,b$01 Keep only bits 0-2.
  $BB35,$01 Stash the pixel line offset in #REGc.
  $BB36,$03 Fetch the height of the sprite from #R$96A5.
  $BB39,$01 Add the pixel line offset.
  $BB3A,$02 Add #N$08.
  $BB3C,$03 Divide by eight to get the number of attribute rows.
  $BB3F,$02,b$01 Keep only bits 0-4.
  $BB41,$01 Set the number of rows to colour in #REGc.
  $BB42,$03 Convert the position into an attribute address.

c $BB45 Colour Rows
@ $BB45 label=ColourRows
D $BB45 Colours #REGc rows of #REGb attribute cells, working upwards from the
. attribute address in #REGhl. A cell is only changed if its paper is black.
E $BB45 View the equivalent code in;
. #LIST
. { #UNDERWURLDE$9888 }
. LIST#
R $BB45 B The number of columns
R $BB45 C The number of rows
R $BB45 D The attribute value to write
R $BB45 HL The attribute buffer address of the bottom-left cell
  $BB45,$02 Stash the counters and the start of the row on the stack.
@ $BB47 label=ColourRows_Loop
  $BB47,$01 Fetch the attribute.
  $BB48,$02,b$01 Keep only bits 3-5 (the paper).
  $BB4A,$02 Jump to #R$BB4D if the paper is not black.
  $BB4C,$01 Colour the cell with the colour of the actor.
@ $BB4D label=ColourRows_Next
  $BB4D,$01 Move on to the next column.
  $BB4E,$02 Decrease the column counter by one and loop back to #R$BB47 until
. all of the columns have been coloured.
  $BB50,$01 Restore the start of the row from the stack.
  $BB51,$03 #REGbc=#N($0020,$04,$04).
  $BB54,$01 Reset the carry flag.
  $BB55,$02 Move up one row of attributes.
  $BB57,$01 Restore the counters from the stack.
  $BB58,$03 Decrease the row counter by one and loop back to #R$BB45 until all
. of the rows have been coloured.
  $BB5B,$01 Return.

c $BB5C Clear Play Area
@ $BB5C label=ClearPlayArea
D $BB5C Clears the top third of the screen, but only from below the banner. The
. banner is left untouched.
N $BB5C #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$99A7,stop=$99AA,sp=$5B40)
. #SCR$01(clear-before)
. | #SIM(start=$BB5C,stop=$0000,sp=$5B40)
. #SCR$01(clear-after) } UDGTABLE# #POPS
  $BB5C,$03 #REGhl=#N$4040(screen buffer).
N $BB5F Here #REGd contains the value to be written (#N$00) and #REGe holds the number of rows of pixels to act on
.       (the full height of a character block).
  $BB5F,$03 #REGde=#N($0008,$04,$04).
N $BB62 #REGb holds the number of columns (i.e. #N$20 == full width of the screen), and #REGc is a
.       counter for how many rows to clear (i.e. the top third would usually be #N$08 rows, but the banner takes up
.       two - hence this initialises to #N$06).
  $BB62,$03 #REGbc=#N$2006.
@ $BB65 label=ClearPlayArea_ClearLine
  $BB65,$02 Stash #REGbc and #REGhl on the stack.
@ $BB67 label=ClearPlayArea_ClearLine_Start
  $BB67,$01 Stash #REGbc on the stack.
@ $BB68 label=ClearPlayArea_ClearLine_Loop
  $BB68,$01 Write #N$00 (#REGd) to the screen (#REGhl).
  $BB69,$01 Move "right" onto the next column.
  $BB6A,$02 Decrease the width counter by one and loop back to #R$BB68 until counter is zero.
N $BB6C Resets the width counter ready for the next loop.
  $BB6C,$01 Restore #REGbc from the stack.
  $BB6D,$01 Decrease the number of rows counter by one.
  $BB6E,$02 Jump back to #R$BB67 unless #REGc is zero.
N $BB70 Resets the screen buffer to where the clearing started for this loop, then moves down one character block.
  $BB70,$01 Restore #REGhl from the stack.
  $BB71,$01 Increments #REGh by one.
  $BB72,$01 Restore #REGbc from the stack.
  $BB73,$01 Decrease the pixel row counter by one.
  $BB74,$02 Jump back to #R$BB65 unless #REGe is zero.
N $BB76 Clears the other two thirds of the screen, so now the screen only contains the banner.
  $BB76,$03 #REGhl=#N$4800(screen buffer).
  $BB79,$03 Jump to #R$BB84.

c $BB7C Clear Play Area Attribute Buffer
@ $BB7C label=ClearPlayArea_Attributes
D $BB7C Sets the attributes of the play area to #N$40, which is everything
. except the two rows at the top of the screen that hold the banner.
  $BB7C,$03 #REGhl=#N$5840(attribute buffer).
  $BB7F,$02 Jump to #R$BB92.

c $BB81 Reset Screen Buffer
@ $BB81 label=ResetScreen
E $BB81 View the equivalent code in;
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
. { #PSSST$7439 }
. { #TRANZAM$7211 }
. LIST#
E $BB81 Continue on to #R$BB88 to blank the screen buffer.
  $BB81,$03 #REGhl=#R$4000(screen buffer).
@ $BB84 label=ResetScreen_FromAddress
  $BB84,$02 #REGb=#N$58 (i.e. finish once we reach the start of #R$5800(attribute buffer)).
  $BB86,$02 #REGc=#N$00 (value to write).

c $BB88 Fill Memory
@ $BB88 label=ResetCopier
E $BB88 View the equivalent code in;
. #LIST
. { #ATICATAC$80BB }
. { #COOKIE$74DB }
. { #JETPAC$71BF }
. { #LUNARJETMAN$84B4 }
. { #PSSST$7440 }
. { #TRANZAM$7218 }
. LIST#
R $BB88 HL Target address
R $BB88 B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $BB88 C Value to write
  $BB88,$01 Write #REGc to the target address.
  $BB89,$01 Increment the target address by one.
  $BB8A,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $BB8C,$02 Keep looping back to #R$BB88 until there is no carry-over.
  $BB8E,$01 Return.

c $BB8F Reset Attribute Buffer
@ $BB8F label=ResetAttributes
E $BB8F View the equivalent code in;
. #LIST
. { #ATICATAC$80C2 }
. { #JETPAC$71C6 }
. { #LUNARJETMAN$84BB }
. { #PSSST$7447 }
. { #TRANZAM$7200 }
. LIST#
  $BB8F,$03 #REGhl=#R$5800(attribute buffer).
@ $BB92 label=ResetAttributes_FromAddress
  $BB92,$02 Set the end of the attribute buffer in #REGb to #N$5B.
  $BB94,$02 Set the value to write in #REGc to #N$40.
  $BB96,$02 Jump to #R$BB88.

u $BB98 Add Accumulator To Address
D $BB98 This code is not used. Adds #REGa to #REGhl.
R $BB98 A Number to add
R $BB98 HL Address
R $BB98 O:HL The address plus the number
  $BB98,$01 #REGa=#REGa+#REGl.
  $BB99,$01 #REGl=#REGa.
  $BB9A,$01 #REGa=#REGh.
  $BB9B,$02 Add the carry to #REGa.
  $BB9D,$01 #REGh=#REGa.
  $BB9E,$01 Return.

c $BB9F Clear Buffers
@ $BB9F label=ClearBuffers
N $BB9F Writes #N$00 to every address from #R$9692 to #R$995A.
  $BB9F,$03 Point #REGhl at the first game variable at #R$9692.
  $BBA2,$03 Set the number of bytes to clear in #REGbc to #N$02C8.
@ $BBA5 label=ClearBuffers_Loop
  $BBA5,$02 Clear a byte of the game variables.
  $BBA7,$01 Move onto the next byte.
  $BBA8,$01 Decrease the byte counter by one.
  $BBA9,$04 Loop back to #R$BBA5 until all of the bytes have been cleared.
  $BBAD,$01 Return.

c $BBAE Draw Room Contents
@ $BBAE label=DrawRoomContents
D $BBAE Calls the routines which set up the contents of the room (#R$A79F,
. #R$A763 and #R$A33B) and then draws every actor in the room with #R$BBBB.
  $BBAE,$03 Save the orchid of the room.
  $BBB1,$03 Load the orchid of the room.
  $BBB4,$03 Set up the objects in the room.
  $BBB7,$03 Draw the actors in the room.
  $BBBA,$01 Return.

c $BBBB Draw Room Actors
@ $BBBB label=DrawRoomActors
D $BBBB Works through the actor table from #R$970E and draws (with #R$B919)
. every actor whose room (byte #N$01) is the same as the room the player is
. in (#R$9703).
  $BBBB,$02 Stash the actor record pointer on the stack.
  $BBBD,$04 Point #REGix at the first actor after the player at #R$970E.
N $BBC1 Draw the actor if it is in the same room as the player.
@ $BBC1 label=DrawRoomActors_Loop
  $BBC1,$03 Fetch the room of the player from #R$9703.
  $BBC4,$06 Draw the actor if it is in the room of the player.
N $BBCA Move on to the next actor, until the end of the actor table is reached.
  $BBCA,$03 Set the size of an actor record in #REGde to #N$000C.
  $BBCD,$02 Move onto the next actor.
  $BBCF,$03 Copy the pointer to the actor into #REGhl.
  $BBD2,$03 Point #REGde at the end of the actor table at #R$982E.
  $BBD5,$03 Subtract the end of the actor table from the pointer to the actor.
  $BBD8,$02 Jump to #R$BBC1 if there are more actors to draw.
  $BBDA,$02 Restore the actor record pointer from the stack.
  $BBDC,$01 Return.

c $BBDD Draw Current Room
@ $BBDD label=DrawCurrentRoom
D $BBDD Looks up the room data for the room the actor is in, using the layout
. table at #R$6066 to find the room in the room table at #R$6166, draws the
. room with #R$BBF7 and then carries on to #R$BBAE to draw its contents.
R $BBDD IX Actor Entity
  $BBDD,$03 Fetch the room of the actor.
  $BBE0,$02 Clear #REGh.
  $BBE2,$03 Point #REGbc at the table of room layouts at #R$6066.
  $BBE5,$01 Add the table to the room to find the layout number of the room.
  $BBE6,$01 Fetch the layout number of the room.
  $BBE7,$02 Clear #REGh.
  $BBE9,$01 Double the layout number (each pointer to room data is a word).
  $BBEA,$03 Point #REGbc at the table of pointers to room data at #R$6166.
  $BBED,$01 Add the table to find the pointer to the room data.
  $BBEE,$01 Fetch the low byte of the address of the room data.
  $BBEF,$01 Move onto the high byte.
  $BBF0,$01 Fetch the high byte of the address of the room data.
  $BBF1,$01 Combine the low byte with the high byte.
  $BBF2,$03 Draw the room.
  $BBF5,$02 Jump to #R$BBAE to set up the contents of the room.

c $BBF7 Draw Room
@ $BBF7 label=DrawRoom
D $BBF7 Draws the graphics of a room. The room data is a list of graphics, each
. with the address of the graphic and the position to draw it at. Each graphic
. is drawn with #R$BC0B.
R $BBF7 HL The Room Data memory address (e.g. #R$61C6, #R$6200)
N $BBF7 #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$9960,stop=$998F,clear=1,sp=$5B40)
. #SIM(start=$AC6B,stop=$AC76,sp=$5B40)
. #SCR$01(room-before)
. | #SIM(start=$BBDD,stop=$BBF5,ix=$9702,sp=$5B40)
. #SCR$01(room-after) } UDGTABLE# #POPS
N $BBF7 The room data is held as: #TABLE(default,centre)
. { =h Byte | =h Type }
. { #N$01 | =r2 Room Graphic Data Address }
. { #N$02 }
. { #N$03 | X Position }
. { #N$04 | Y Position }
. TABLE#
. And is terminated when #N($0000, $04, $04) is reached.
N $BBF7 Fetch the room data graphic address.
  $BBF7,$03 Fetch the address of the graphic.
  $BBFA,$03 Return if the end of the room data has been reached (the address is
. zero).
N $BBFD Fetch the X/ Y position data.
  $BBFD,$01 Move onto the X position of the graphic.
  $BBFE,$03 Fetch the X position into #REGc and the Y position into #REGb.
  $BC01,$01 Move onto the next graphic in the room data.
  $BC02,$01 Stash the pointer to the room data on the stack.
  $BC03,$02 Copy the position into #REGhl.
  $BC05,$03 Draw the graphic.
  $BC08,$01 Restore the pointer to the room data from the stack.
  $BC09,$02 Jump back to #R$BBF7 to draw the next graphic.
N $BC0B At the point of processing; #REGhl contains X/ Y position data, #REGde contains the room data graphic address (and #REGbc is throwaway).
@ $BC0B label=DrawRoom_Process
D $BC0B Draws one graphic of a room, and sets its attributes. The graphic is
. made up of the pixel data and then the attribute data:
. #TABLE(default,centre)
. { =h Item | =h Type }
. { Height of the pixel data in lines | Byte }
. { Width of the pixel data in bytes | Byte }
. { Pixel data, stored inverted | Bytes }
. { Height of the attribute data in rows | Byte }
. { Width of the attribute data in columns | Byte }
. { Attribute data | Bytes }
. { A second set of attribute data (optional) | Bytes }
. TABLE#
. If #R$96B2 is not zero then the second set of attributes is used, if there
. is one, and #R$96B2 is reset.
R $BC0B DE Address of the graphic
R $BC0B HL Position, with Y in #REGh and X in #REGl
  $BC0B,$01 Stash the position of the graphic on the stack.
  $BC0C,$03 Convert the position into a screen address.
  $BC0F,$02 Fetch the height of the graphic into #REGc.
  $BC11,$01 Increment #REGde by one.
  $BC12,$02 Fetch the width of the graphic into #REGb.
  $BC14,$01 Increment #REGde by one.
@ $BC15 label=DrawRoom_Row_Loop
  $BC15,$01 Stash the counters on the stack.
@ $BC16 label=DrawRoom_Write_Row
  $BC16,$01 Fetch a byte of the graphic.
  $BC17,$01 Invert the bits.
  $BC18,$01 Draw the byte on the screen.
  $BC19,$01 Move onto the next column.
  $BC1A,$01 Move onto the next byte of the graphic.
  $BC1B,$02 Decrease the width counter by one and loop back to #R$BC16 until counter is zero.
  $BC1D,$01 Restore the counters from the stack.
  $BC1E,$03 Move back to the first column.
  $BC21,$03 Move down to the next pixel line.
  $BC24,$03 Decrease the height counter by one and loop back to #R$BC15 until counter is zero.
  $BC27,$01 Restore the position of the graphic from the stack.
  $BC28,$03 Convert the position into an attribute address.
N $BC2B Now set the attributes.
  $BC2B,$03 Fetch the height of the attribute data into #REGc.
  $BC2E,$03 Fetch the width of the attribute data into #REGb.
  $BC31,$06 Jump to #R$BC49 if #R$96B2 is not zero, to use the second set of
. attributes.
@ $BC37 label=DrawRoom_Attribute_Row_Loop
  $BC37,$01 Stash the counters on the stack.
  $BC38,$01 Stash the start of the row on the stack.
@ $BC39 label=DrawRoom_Attribute_Loop
  $BC39,$01 Fetch an attribute.
  $BC3A,$01 Move onto the next attribute.
  $BC3B,$01 Set the attribute on the screen.
  $BC3C,$01 Move onto the next column.
  $BC3D,$02 Decrease the width counter by one and loop back to #R$BC39 until
. counter is zero.
  $BC3F,$01 Restore the start of the row from the stack.
  $BC40,$03 #REGbc=#N($0020,$04,$04).
  $BC43,$01 Move down one row of attributes.
  $BC44,$01 Restore the counters from the stack.
  $BC45,$03 Decrease the row counter by one and loop back to #R$BC37 until all
. of the rows of attributes have been set.
  $BC48,$01 Return.
N $BC49 Use the second set of attributes, by skipping over the first set.
@ $BC49 label=DrawRoom_Second_Attributes
  $BC49,$01 Stash the counters on the stack.
  $BC4A,$01 Start the total at zero.
  $BC4B,$03 Clear #R$96B2, so the first set of attributes is used next time.
@ $BC4E label=DrawRoom_Skip_Attributes
  $BC4E,$01 Add the height to #REGa, once for each column, to find the size of
. the first set.
  $BC4F,$02 Decrease #REGb by one and loop back to #R$BC4E until it is zero.
  $BC51,$01 #REGc=#REGa.
  $BC52,$02 #REGb=#N$00.
  $BC54,$01 Swap #REGde and #REGhl.
  $BC55,$01 Move the attribute data pointer past the first set.
  $BC56,$01 Swap #REGde and #REGhl back.
  $BC57,$01 Restore the counters from the stack.
  $BC58,$02 Jump to #R$BC37.

u $BC5A Multiply A By DE
@ $BC5A label=MultiplyAByDE
D $BC5A This code is not used. Multiplies #REGa by #REGde.
E $BC5A View the equivalent code in;
. #LIST
. { #ATICATAC$9AAD }
. { #TRANZAM$6F2F }
. { #UNDERWURLDE$AC68 }
. LIST#
R $BC5A A Number to multiply by
R $BC5A DE Number to multiply
R $BC5A O:HL The result
  $BC5A,$03 #REGhl=#N($0000,$04,$04).
  $BC5D,$02 #REGb=#N$08 (the number of bits).
  $BC5F,$01 Double the result.
  $BC60,$01 Rotate the next bit of #REGa into the carry flag.
  $BC61,$02 Jump to #R$BC64 if the bit is not set.
  $BC63,$01 Add #REGde to the result.
  $BC64,$02 Decrease the bit counter by one and loop back to #R$BC5F until it is
. zero.
  $BC66,$01 Return.

b $BC67 Music Data
@ $BC67 label=MusicData_GameComplete
D $BC67 Each byte of music data is a note and the data is terminated by #N$FF.
. Bits 0-5 select the note from the table at #R$BDD2 (zero is a rest) and bits
. 6-7 hold the length of the note minus one (so a note lasts for between one and
. four units). See #R$BD7B.
. .
. This is the main tune, played when the game is completed and on the game
. selection screen. #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune)))
  $BC67,$10,$10
@ $BC77 label=MusicData_GameComplete_Loop
  $BC77,$B1,$10
N $BD28 This is the tune played when the game is over.
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
@ $BD28 label=MusicData_GameOver
  $BD28,$0B,$0B
N $BD33 This is the tune played with the poems.
. #HTML(#AUDIO0(poem-tune.wav)(#INCLUDE(PoemTune)))
@ $BD33 label=MusicData_Poem
  $BD33,$12,$09
N $BD45 This is the tune played when a new game is started.
. #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune)))
@ $BD45 label=MusicData_GameInitialisation
  $BD45,$0C,$06

c $BD51 Play Music Until Key Pressed
@ $BD51 label=PlayMusic_WaitKey
D $BD51 Plays a tune in the same way as #R$BD6E, but stops as soon as any key
. is pressed. The key press is then handled by the game selection menu (see
. #R$B3D5), as if it had been read there.
. .
. #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune)))
R $BD51 DE Music data terminated by #N$FF
  $BD51,$01 Disable interrupts.
N $BD52 Check for any key being pressed.
@ $BD52 label=PlayMusic_WaitKey_Loop
  $BD52,$01 Select every row of the keyboard.
  $BD53,$02 Write #REGa to port #N$FD (this has no effect).
  $BD55,$02 Read every half-row of the keyboard at once (the high byte of the
. port number is zero).
  $BD57,$01 Flip the bits.
  $BD58,$02,b$01 Keep only bits 0-4.
  $BD5A,$02 Jump to #R$BD64 if no keys were pressed.
N $BD5C A key was pressed, so stop playing and hand over to the game menu.
  $BD5C,$03 Fetch the game options from #R$9692.
  $BD5F,$02 Discard the return address.
  $BD61,$03 Jump to #R$B422 to handle the key press in the game selection menu.
N $BD64 This is identical to #R$BD6E except it also handles exiting on a keypress.
@ $BD64 label=PlayMusic_WaitKey_Process
  $BD64,$01 Fetch the next note.
  $BD65,$04 Jump to #R$BD79 if the end of the tune has been reached (#N$FF).
  $BD69,$03 Play the note.
  $BD6C,$02 Jump to #R$BD52 to check for a key press.

c $BD6E Play Music
@ $BD6E label=PlayMusic
D $BD6E Plays a tune, one note at a time with #R$BD7B, until the #N$FF
. terminator is found. Interrupts are disabled while the tune plays.
. .
. The tunes played by this routine are:
. #TABLE(default,centre,centre)
. { =h Tune | =h Sound }
. { Start-up Tune
. | #HTML(#AUDIO0(start-up-tune.wav)(#INCLUDE(StartUpTune))) }
. { Main Tune
. | #HTML(#AUDIO0(main-tune.wav)(#INCLUDE(MainTune))) }
. { Poem Tune
. | #HTML(#AUDIO0(poem-tune.wav)(#INCLUDE(PoemTune))) }
. { Game Over Tune
. | #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune))) }
. TABLE#
E $BD6E View the equivalent code in;
. #LIST
. { #COOKIE$6568 }
. { #KNIGHTLORE$B2CF }
. { #MARTIANOIDS$C0CF }
. LIST#
R $BD6E DE Music data terminated by #N$FF
  $BD6E,$01 Disable interrupts.
@ $BD6F label=PlayMusic_Loop
  $BD6F,$01 Fetch the next note.
  $BD70,$04 Jump to #R$BD79 if the end of the tune has been reached (#N$FF).
  $BD74,$03 Play the note.
  $BD77,$02 Jump to #R$BD6F for the next note.

c $BD79 Finish Playing Music
@ $BD79 label=PlayMusic_Return
D $BD79 Enables interrupts again once a tune has finished.
  $BD79,$01 Enable interrupts.
  $BD7A,$01 Return.

c $BD7B Play Note
@ $BD7B label=PlayNote
D $BD7B Plays a single note, or a rest if the note is zero. A note is looked up
. in the table at #R$BDD2, which has four bytes per note: two bytes which set
. the length of the delays between speaker changes (the pitch), followed by a
. 16-bit count of the number of cycles to play. The count is multiplied by the
. length held in bits 6-7 of the music data byte plus one.
. .
. Each cycle sets the border (and speaker) to black for a delay and then turns
. the speaker on for the same delay.
E $BD7B View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B2DA }
. { #MARTIANOIDS$C0DA }
. LIST#
R $BD7B A Music data byte
R $BD7B DE Music data terminated by #N$FF
  $BD7B,$02,b$01 Keep only bits 0-5 (the note).
  $BD7D,$02 Jump to #R$BDBC if the note is a rest (zero).
  $BD7F,$03 Use the note as the offset into the table of notes.
  $BD82,$06 Multiply the offset by four (the size of an entry) and add the table
. of notes at #R$BDD2.
N $BD88 Read the table entry for the note: two bytes of pitch delay and then
. the 16-bit number of cycles.
  $BD88,$04 Fetch the pitch delay of the note into #REGb and #REGc.
  $BD8C,$04 Fetch the number of cycles of the note into #REGhl.
N $BD90 Multiply the number of cycles by the length of the note.
  $BD90,$01 Fetch the music data byte.
  $BD91,$02 Rotate bits 6-7 (the length of the note) into bits 0-1.
  $BD93,$02,b$01 Keep only bits 0-1.
  $BD95,$01 Add one, so #REGa holds the length of the note.
  $BD96,$01 Stash the music data pointer on the stack.
  $BD97,$02 Copy the number of cycles into #REGde.
@ $BD99 label=PlayMusic_Multiply
  $BD99,$03 Decrease the length counter by one and jump to #R$BD9F once the
. length has been multiplied in.
  $BD9C,$01 Add the number of cycles to the total.
  $BD9D,$02 Jump back to #R$BD99.
@ $BD9F label=PlayMusic_MultiplyDone
  $BD9F,$01 Restore the music data pointer from the stack.
N $BDA0 Play one cycle: the speaker is off for the delay and then on for the
. same delay.
@ $BDA0 label=PlayMusic_Cycle
  $BDA0,$01 Stash the pitch delay on the stack.
  $BDA1,$01 Set the speaker to off.
  $BDA2,$02 Write #REGa to port #N$FE (border black, speaker off).
@ $BDA4 label=PlayMusic_OffDelay
  $BDA4,$02 Decrease #REGb by one and loop back to #R$BDA4 until it is zero.
  $BDA6,$03 Decrease #REGc by one and jump back to #R$BDA4 until it is zero.
  $BDA9,$01 Restore the pitch delay from the stack.
  $BDAA,$01 Stash the pitch delay on the stack.
  $BDAB,$02 Set the speaker to on (bit 4).
  $BDAD,$02 Write #REGa to port #N$FE (border black, speaker on).
@ $BDAF label=PlayMusic_OnDelay
  $BDAF,$02 Decrease #REGb by one and loop back to #R$BDAF until it is zero.
  $BDB1,$03 Decrease #REGc by one and jump back to #R$BDAF until it is zero.
  $BDB4,$01 Restore the pitch delay from the stack.
  $BDB5,$01 Decrease the cycle counter by one.
  $BDB6,$04 Loop back to #R$BDA0 until all of the cycles of the note have been
. played.
  $BDBA,$01 Move on to the next note.
  $BDBB,$01 Return.
N $BDBC A rest is a silent delay, which lasts for as many units as the length of
. the note.
@ $BDBC label=PlayMusic_Rest
  $BDBC,$01 Fetch the music data byte.
  $BDBD,$01 Move on to the next note.
  $BDBE,$02 Rotate left twice, so bits 6-7 become bits 0-1.
  $BDC0,$02,b$01 Keep only bits 0-1.
  $BDC2,$01 Add one, so #REGa holds the length of the rest.
  $BDC3,$01 Store the length of the rest in #REGl.
  $BDC4,$03 Set the length of one unit of the rest in #REGbc to #N$430B.
@ $BDC7 label=PlayMusic_RestUnit
  $BDC7,$01 Stash the length of the unit on the stack.
@ $BDC8 label=PlayMusic_RestDelay
  $BDC8,$01 Decrease the unit counter by one.
  $BDC9,$04 Loop back to #R$BDC8 until the unit has passed.
  $BDCD,$01 Restore the length of the unit from the stack.
  $BDCE,$03 Decrease the length of the rest by one and loop back to #R$BDC7
. until the rest is over.
  $BDD1,$01 Return.

b $BDD2 Music Note Table
@ $BDD2 label=MusicNotes
D $BDD2 The pitch delays and cycle counts for each of the notes (see
. #R$BD7B). Each entry is four bytes: the delay as two bytes, followed by the
. 16-bit number of cycles to play, which gets larger as the pitch rises so that
. every note lasts the same length of time. Entry #N$00 is unused as it is a
. rest.
E $BDD2 View the equivalent code in;
. #LIST
. { #COOKIE$6594 }
. LIST#
B $BDD2,$F4,$04

c $BEC6 Play Orchid Flash Beep
@ $BEC6 label=PlayOrchidFlashBeep
D $BEC6 Plays a short, low beep of eight cycles. It is made when the player
. changes between white and the colour of the orchid, as the effect of the
. orchid wears off (see #R$AEEF).
. .
. #HTML(#AUDIO0(orchid-flash-beep.wav)(#INCLUDE(OrchidFlashBeep)))
  $BEC6,$03 Set the half-period in #REGb to #N$A0 and the number of cycles in
. #REGc to #N$08.
  $BEC9,$03 Jump to #R$BF6D to play the beep.

c $BECC Play Flame Sound
@ $BECC label=PlayFlameSound
D $BECC Plays sixteen cycles of a tone, with a half-period taken from the table
. at #R$BEDE. The entry used depends on the low four bits of the frame counter,
. which gives the flame a crackling sound.
. .
. #HTML(#AUDIO0(flame-sound.wav)(#INCLUDE(FlameSound)))
  $BECC,$03 Point #REGbc at the flame sound table at #R$BEDE.
  $BECF,$03 Fetch the low byte of the game timer from #R$9693.
  $BED2,$02,b$01 Keep only bits 0-3.
  $BED4,$03 Use it as the offset into the table.
  $BED7,$01 Add the table to find the half-period.
  $BED8,$01 Fetch the half-period of the tone from the table into #REGb.
  $BED9,$02 Set the number of cycles in #REGc to #N$10.
  $BEDB,$03 Jump to #R$BF6D to play the sound.

b $BEDE Flame Sound Table
@ $BEDE label=FlameSoundTable
D $BEDE The half-periods used by #R$BECC.
B $BEDE,$10,$08

c $BEEE Play Explosion Sound
@ $BEEE label=PlayExplosionSound
D $BEEE Plays sixteen short tones to make a burst of noise. The half-period of
. each tone is the low seven bits of a byte of the ROM, which is read from an
. address made from the low five bits of the frame counter (the high byte) and
. the random seed (the low byte).
. .
. #HTML(#AUDIO0(explosion.wav)(#INCLUDE(Explosion)))
E $BEEE View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B489 }
. LIST#
  $BEEE,$04 Fetch the random seed from #R$9695 into #REGl.
  $BEF2,$03 Fetch the low byte of the game timer from #R$9693.
  $BEF5,$02,b$01 Keep only bits 0-4.
  $BEF7,$01 Store the result in #REGh, so #REGhl points to a byte of the ROM.
  $BEF8,$02 Set the number of tones in #REGe to #N$10.
@ $BEFA label=PlayExplosionSound_Loop
  $BEFA,$01 Fetch a byte of the ROM, to use as noise.
  $BEFB,$01 Move on to the next byte of the ROM.
  $BEFC,$02,b$01 Keep only bits 0-6.
  $BEFE,$01 Store the result in #REGb (the half-period).
  $BEFF,$02 Set the number of cycles of each tone in #REGc to #N$02.
  $BF01,$03 Play the tone.
  $BF04,$03 Decrease the tone counter by one and loop back to #R$BEFA until all
. of the tones have been played.
  $BF07,$01 Return.

c $BF08 Play Appearing Sound
@ $BF08 label=PlayAppearingSound
D $BF08 Plays six cycles of a tone with a half-period which depends on the low
. three bits of the sprite ID, so the sound changes as the sprite changes.
. .
. #HTML(#AUDIO0(appearing-sound.wav)(#INCLUDE(AppearingSound)))
R $BF08 IX Actor record
  $BF08,$03 Fetch the sprite ID of the actor.
  $BF0B,$01 Flip the bits.
  $BF0C,$03 Rotate right three times.
  $BF0F,$02,b$01 Keep only bits 5-7.
  $BF11,$01 Store the result in #REGb (the half-period).
  $BF12,$02 Set the number of cycles in #REGc to #N$06.
  $BF14,$03 Jump to #R$BF6D to play the sound.

c $BF17 Play Warble Sound
@ $BF17 label=PlayWarbleSound
D $BF17 Plays #N$30 tones, using #R$BF74. The pitch of each one is worked out
. from a counter which counts down from #N$30, which gives a warbling sound.
. #HTML(#AUDIO0(warble-sound.wav)(#INCLUDE(WarbleSound)))
  $BF17,$02 Set the number of tones in #REGc to #N$30.
@ $BF19 label=PlayWarbleSound_Loop
  $BF19,$01 Fetch the tone counter.
  $BF1A,$02,b$01 Set bits 3-4.
  $BF1C,$01 Decimal adjust the result, so the pitch jumps about.
  $BF1D,$01 Store the result in #REGb (the half-period).
  $BF1E,$03 Play the tone.
  $BF21,$03 Decrease the tone counter by one and loop back to #R$BF19 until all
. of the tones have been played.
  $BF24,$01 Return.

c $BF25 Play High Tone
@ $BF25 label=PlayHighTone
D $BF25 Plays a steady tone of #N$30 cycles, using #N$40 as the pitch delay.
. #HTML(#AUDIO0(high-tone.wav)(#INCLUDE(HighTone)))
  $BF25,$03 Set the half-period in #REGb to #N$40 and the number of cycles in
. #REGc to #N$30.
  $BF28,$02 Jump to #R$BF6D to play the tone.

c $BF2A Play Low Tone
@ $BF2A label=PlayLowTone
D $BF2A Plays a steady tone of #N$10 cycles, using #N$80 as the pitch delay
. (so it is lower in pitch than #R$BF25).
. #HTML(#AUDIO0(low-tone.wav)(#INCLUDE(LowTone)))
  $BF2A,$03 Set the half-period in #REGb to #N$80 and the number of cycles in
. #REGc to #N$10.
  $BF2D,$02 Jump to #R$BF6D to play the tone.

c $BF2F Play Noise Sound
@ $BF2F label=PlayNoiseSound
D $BF2F Plays #N$30 tones, each with a pitch worked out from the counter, which
. gives a noisy sound.
. #HTML(#AUDIO0(noise-sound.wav)(#INCLUDE(NoiseSound)))
E $BF2F View the equivalent code in;
. #LIST
. { #GUNFRIGHT$AF22 }
. { #MARTIANOIDS$C04E }
. { #NIGHTSHADE$C3AA }
. { #PENTAGRAM$D5E4 }
. LIST#
  $BF2F,$02 Set the number of tones in #REGc to #N$30.
@ $BF31 label=PlayNoiseSound_Loop
  $BF31,$01 Fetch the tone counter.
  $BF32,$02,b$01 Flip bits 0, 2, 4 and 6.
  $BF34,$01 Add the tone counter.
  $BF35,$01 Store the result in #REGb (the half-period).
  $BF36,$03 Play the tone.
  $BF39,$03 Decrease the tone counter by one and loop back to #R$BF31 until all
. of the tones have been played.
  $BF3C,$01 Return.

c $BF3D Play Amulet Piece Sound
@ $BF3D label=PlayAmuletPieceSound
D $BF3D Plays eight cycles of a tone. The half-period is the distance to the
. nearest amulet piece, plus the X and Y positions of the actor, rotated left
. twice.
. .
. #HTML(#AUDIO0(amulet-piece-sound.wav)(#INCLUDE(AmuletPieceSound)))
R $BF3D A Distance to the nearest amulet piece
R $BF3D IX Actor record
  $BF3D,$03 Add the X position of the actor to the distance.
  $BF40,$03 Add the Y position of the actor to the distance.
  $BF43,$02 Rotate left twice.
  $BF45,$01 Store the result in #REGb (the half-period).
  $BF46,$02 Set the number of cycles in #REGc to #N$08.
  $BF48,$03 Jump to #R$BF6D to play the sound.

c $BF4B Play Footstep Sound
@ $BF4B label=PlayFootstepSound
D $BF4B Makes the sound of a footstep when a player has moved. The footstep
. counter at #R$96B3 is incremented and a short tone is played whenever the low
. three bits are zero, which alternates between two pitches (using bit 3). A
. cyan player (the effect of a cyan orchid) is quicker, so the
. counter is incremented twice.
. .
. #HTML(#AUDIO0(footstep-sound.wav)(#INCLUDE(FootstepSound)))
R $BF4B IX Actor record
  $BF4B,$03 Make the footstep sound.
  $BF4E,$03 Fetch the colour of the player.
  $BF51,$03 Return unless the player is cyan (#COLOUR$45), who makes the
. footstep sound a second time.
N $BF54 Increment the counter and make the sound if it is time for one.
@ $BF54 label=PlayFootstepSound_Step
  $BF54,$03 Point #REGhl at the footstep counter at #R$96B3.
  $BF57,$01 Increase the footstep counter by one.
  $BF58,$01 Fetch the footstep counter.
  $BF59,$04 Jump to #R$BF65 if bit 3 of the counter is zero.
  $BF5D,$02,b$01 Keep only bits 0-2.
  $BF5F,$01 Return unless the footstep counter is a multiple of eight.
  $BF60,$03 Set the half-period in #REGb to #N$40 and the number of cycles in
. #REGc to #N$04.
  $BF63,$02 Jump to #R$BF6D to play the sound.
@ $BF65 label=PlayFootstepSound_Low
  $BF65,$02,b$01 Keep only bits 0-2.
  $BF67,$01 Return unless the footstep counter is a multiple of eight.
  $BF68,$03 Set the half-period in #REGb to #N$60 and the number of cycles in
. #REGc to #N$04.
  $BF6B,$02 Jump to #R$BF6D to play the sound.

c $BF6D Play Wave Sequence
@ $BF6D label=PlayWaveSequence
D $BF6D Plays a number of cycles of a square wave, one after the other.
E $BF6D View the equivalent code in;
. #LIST
. { #LUNARJETMAN$B92D }
. LIST#
R $BF6D B Duration of wave
R $BF6D C Number of times to repeat
  $BF6D,$03 Play a cycle of the wave.
  $BF70,$03 Decrease the repeat counter by one and loop back to #R$BF6D until
. all of the cycles have been played.
  $BF73,$01 Return.

c $BF74 Play Square Wave
@ $BF74 label=PlaySquareWave
D $BF74 Plays a single cycle of a square wave: the speaker is turned on for the
. duration and then off for the same duration.
E $BF74 View the equivalent code in;
. #LIST
. { #KNIGHTLORE$B4ED }
. { #LUNARJETMAN$B8DA }
. { #MARTIANOIDS$C062 }
. { #PSSST$64AA }
. LIST#
R $BF74 B Duration of wave
  $BF74,$02 #REGa=#N$10 (bit 4 turns the speaker on).
  $BF76,$02 Write #REGa to port #N$FE (border black, speaker on).
  $BF78,$01 Stash the duration in #REGa.
@ $BF79 label=PlaySquareWave_Loop
  $BF79,$02 Decrease duration by one and loop back to #R$BF79 until it is zero.
  $BF7B,$01 Restore the duration to #REGb.
  $BF7C,$01 #REGa=#N$00.
  $BF7D,$02 Write #REGa to port #N$FE (border black, speaker off).
  $BF7F,$01 Stash the duration in #REGa.
@ $BF80 label=Silence_Loop
  $BF80,$02 Decrease duration by one and loop back to #R$BF80 until it is zero.
  $BF82,$01 Restore the duration to #REGb.
  $BF83,$01 Return.

w $BF84 Sprite Table
@ $BF84 label=SpritesTable
D $BF84 The table of sprites, with an entry for each of the #N$C4 sprite IDs. An
. entry is the address of the sprite for the ID (see #R$B928). The sprite ID is
. the first byte of an actor record.
. .
. A sprite is stored as its width in bytes, then its height in pixels, and then
. the pixel data: one byte for every byte of the width, for each row of the
. sprite. Sprites have no mask, as they are drawn using XOR. Several sprite IDs
. can share one sprite when an animation repeats a frame.
E $BF84 View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #PSSST$761A }
. { #TRANZAM$7F06 }
. LIST#
  $BF84 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100)(#N((#PC - $BF84) / $02)) #SPRITENAME((#PC - $BF84) / $02).
L $BF84,$02,$C4

b $C10C Sprite: None
@ $C10C label=Sprite_None
D $C10C The blank sprite. Its width and height are both zero, so nothing is
. drawn. It is used by the sprite IDs which show nothing: #N$00, #N$07,
. #N$0E-#N$0F, #N$5A-#N$5B, #N$5E-#N$5F, #N$7C-#N$7F and #N$96-#N$97 (see
. #R$BF84).
  $C10C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C10D,$01 Height = #N(#PEEK(#PC)) pixels.

b $C10E Sprite: Earwig
@ $C10E label=Sprite_Earwig_Left_1
D $C10E The earwig sprites (sprite IDs #N$C0-#N$C3, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $C10E Left Frame 1.
  $C10E,$01 Width = #N(#PEEK(#PC)) bytes.
  $C10F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C110,$36,$03 #GRAPHIC$C0(C0)

N $C146 Left Frame 2.
@ $C146 label=Sprite_Earwig_Left_2
  $C146,$01 Width = #N(#PEEK(#PC)) bytes.
  $C147,$01 Height = #N(#PEEK(#PC)) pixels.
  $C148,$33,$03 #GRAPHIC$C1(C1)

N $C17B Right Frame 1.
@ $C17B label=Sprite_Earwig_Right_1
  $C17B,$01 Width = #N(#PEEK(#PC)) bytes.
  $C17C,$01 Height = #N(#PEEK(#PC)) pixels.
  $C17D,$36,$03 #GRAPHIC$C2(C2)

N $C1B3 Right Frame 2.
@ $C1B3 label=Sprite_Earwig_Right_2
  $C1B3,$01 Width = #N(#PEEK(#PC)) bytes.
  $C1B4,$01 Height = #N(#PEEK(#PC)) pixels.
  $C1B5,$33,$03 #GRAPHIC$C3(C3)

b $C1E8 Sprite: Flea
@ $C1E8 label=Sprite_Flea_Left_1
D $C1E8 The flea sprites (sprite IDs #N$BC-#N$BF, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $C1E8 Left Frame 1.
  $C1E8,$01 Width = #N(#PEEK(#PC)) bytes.
  $C1E9,$01 Height = #N(#PEEK(#PC)) pixels.
  $C1EA,$1C,$02 #GRAPHIC$BC(BC)

N $C206 Left Frame 2.
@ $C206 label=Sprite_Flea_Left_2
  $C206,$01 Width = #N(#PEEK(#PC)) bytes.
  $C207,$01 Height = #N(#PEEK(#PC)) pixels.
  $C208,$24,$02 #GRAPHIC$BD(BD)

N $C22C Right Frame 1.
@ $C22C label=Sprite_Flea_Right_1
  $C22C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C22D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C22E,$1C,$02 #GRAPHIC$BE(BE)

N $C24A Right Frame 2.
@ $C24A label=Sprite_Flea_Right_2
  $C24A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C24B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C24C,$24,$02 #GRAPHIC$BF(BF)

b $C270 Sprite: Skunk
@ $C270 label=Sprite_Skunk_Left_1
D $C270 The skunk sprites (sprite IDs #N$B8-#N$BB, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $C270 Left Frame 1.
  $C270,$01 Width = #N(#PEEK(#PC)) bytes.
  $C271,$01 Height = #N(#PEEK(#PC)) pixels.
  $C272,$3F,$03 #GRAPHIC$B8(B8)

N $C2B1 Left Frame 2.
@ $C2B1 label=Sprite_Skunk_Left_2
  $C2B1,$01 Width = #N(#PEEK(#PC)) bytes.
  $C2B2,$01 Height = #N(#PEEK(#PC)) pixels.
  $C2B3,$3F,$03 #GRAPHIC$B9(B9)

N $C2F2 Right Frame 1.
@ $C2F2 label=Sprite_Skunk_Right_1
  $C2F2,$01 Width = #N(#PEEK(#PC)) bytes.
  $C2F3,$01 Height = #N(#PEEK(#PC)) pixels.
  $C2F4,$3F,$03 #GRAPHIC$BA(BA)

N $C333 Right Frame 2.
@ $C333 label=Sprite_Skunk_Right_2
  $C333,$01 Width = #N(#PEEK(#PC)) bytes.
  $C334,$01 Height = #N(#PEEK(#PC)) pixels.
  $C335,$3F,$03 #GRAPHIC$BB(BB)

b $C374 Amulet Graphics Table
@ $C374 label=AmuletGraphicsTable
D $C374 The graphics which make up the amulet on the amulet screen (see
. #R$A207). There are four entries of four bytes, each of which is the address
. of a graphic followed by its X and Y position, and then a zero address ends
. the table. The first entry is used for the first bit of the amulet pieces
. collected (see #R$970D).
. .
. The graphics are the amulet outlines at #R$E3A0, #R$E494, #R$E588 and #R$E67C.
W $C374,$02 Graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $C376,$02 X/ Y position.
W $C378,$02 Graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $C37A,$02 X/ Y position.
W $C37C,$02 Graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $C37E,$02 X/ Y position.
W $C380,$02 Graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $C382,$02 X/ Y position.
W $C384,$02 Terminator.

w $C386 Special Room (Game Completed)
@ $C386 label=Room_Special_Complete
D $C386 This is the room data showing on the Game Completed screen. See #R$9F6A.
D $C386 #UDGTABLE { #ROOM(#PC)(room-complete) } UDGTABLE#
  $C386,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $C388,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
  $C38A,$02 Terminator.

b $C38C Sprite: Bat
@ $C38C label=Sprite_Bat_Left_1
D $C38C The bat sprites (sprite IDs #N$68-#N$6B, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $C38C Left Frame 1.
  $C38C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C38D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C38E,$22,$02 #GRAPHIC$68(68)

N $C3B0 Left Frame 2.
@ $C3B0 label=Sprite_Bat_Left_2
  $C3B0,$01 Width = #N(#PEEK(#PC)) bytes.
  $C3B1,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3B2,$1A,$02 #GRAPHIC$69(69)

N $C3CC Right Frame 1.
@ $C3CC label=Sprite_Bat_Right_1
  $C3CC,$01 Width = #N(#PEEK(#PC)) bytes.
  $C3CD,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3CE,$22,$02 #GRAPHIC$6A(6A)

N $C3F0 Right Frame 2.
@ $C3F0 label=Sprite_Bat_Right_2
  $C3F0,$01 Width = #N(#PEEK(#PC)) bytes.
  $C3F1,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3F2,$1A,$02 #GRAPHIC$6B(6B)

b $C40C Sprite: Sabreman
@ $C40C label=Sprite_Sabreman_Up_1
D $C40C The sprites for Sabreman walking and fighting (sprite IDs #N$10-#N$2F,
. see #R$BF84).
. .
. Walking has three frames for each of the directions up, down, left and right.
. Each direction has four sprite IDs which play the frames in the order 1, 2, 3,
. 2.
. .
. Fighting has six frames facing left and six facing right. Each direction has
. eight sprite IDs which play the frames in the order 1, 2, 3, 4, 5, 4, 6, 2.
E $C40C #UDGTABLE(default,centre)
. { =h Down | =h Up | =h Left (fighting) | =h Right (fighting) }{
.   #FRAMES(1C,25;1D;1E;1D)(sabreman-down) |
.   #FRAMES(18,25;19;1A;19)(sabreman-up) |
.   #FRAMES(20,25;21;22;23;24;23;26;21)(sabreman-left-fighting) |
.   #FRAMES(28,25;29;2A;2B;2C;2B;2D;29)(sabreman-right-fighting)
. }
. UDGTABLE#
N $C40C Up Frame 1.
  $C40C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C40D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C40E,$2A,$02 #GRAPHIC$18(18*)

N $C438 Up Frame 2.
@ $C438 label=Sprite_Sabreman_Up_2
  $C438,$01 Width = #N(#PEEK(#PC)) bytes.
  $C439,$01 Height = #N(#PEEK(#PC)) pixels.
  $C43A,$2A,$02 #GRAPHIC$19(19*)

N $C464 Up Frame 3.
@ $C464 label=Sprite_Sabreman_Up_3
  $C464,$01 Width = #N(#PEEK(#PC)) bytes.
  $C465,$01 Height = #N(#PEEK(#PC)) pixels.
  $C466,$2A,$02 #GRAPHIC$1A(1A*)

N $C490 Down Frame 1.
@ $C490 label=Sprite_Sabreman_Down_1
  $C490,$01 Width = #N(#PEEK(#PC)) bytes.
  $C491,$01 Height = #N(#PEEK(#PC)) pixels.
  $C492,$2A,$02 #GRAPHIC$1C(1C*)

N $C4BC Down Frame 2.
@ $C4BC label=Sprite_Sabreman_Down_2
  $C4BC,$01 Width = #N(#PEEK(#PC)) bytes.
  $C4BD,$01 Height = #N(#PEEK(#PC)) pixels.
  $C4BE,$2A,$02 #GRAPHIC$1D(1D*)

N $C4E8 Down Frame 3.
@ $C4E8 label=Sprite_Sabreman_Down_3
  $C4E8,$01 Width = #N(#PEEK(#PC)) bytes.
  $C4E9,$01 Height = #N(#PEEK(#PC)) pixels.
  $C4EA,$2A,$02 #GRAPHIC$1E(1E*)

N $C514 Left Frame 1.
@ $C514 label=Sprite_Sabreman_Left_1
  $C514,$01 Width = #N(#PEEK(#PC)) bytes.
  $C515,$01 Height = #N(#PEEK(#PC)) pixels.
  $C516,$2A,$02 #GRAPHIC$10(10*)

N $C540 Left Frame 2.
@ $C540 label=Sprite_Sabreman_Left_2
  $C540,$01 Width = #N(#PEEK(#PC)) bytes.
  $C541,$01 Height = #N(#PEEK(#PC)) pixels.
  $C542,$2C,$02 #GRAPHIC$11(11*)

N $C56E Left Frame 3.
@ $C56E label=Sprite_Sabreman_Left_3
  $C56E,$01 Width = #N(#PEEK(#PC)) bytes.
  $C56F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C570,$2A,$02 #GRAPHIC$12(12*)

N $C59A Left Fighting Frame 1.
@ $C59A label=Sprite_Sabreman_Left_Fighting_1
  $C59A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C59B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C59C,$3F,$03 #GRAPHIC$20(20*)

N $C5DB Left Fighting Frame 2.
@ $C5DB label=Sprite_Sabreman_Left_Fighting_2
  $C5DB,$01 Width = #N(#PEEK(#PC)) bytes.
  $C5DC,$01 Height = #N(#PEEK(#PC)) pixels.
  $C5DD,$3F,$03 #GRAPHIC$21(21*)

N $C61C Left Fighting Frame 3.
@ $C61C label=Sprite_Sabreman_Left_Fighting_3
  $C61C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C61D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C61E,$3F,$03 #GRAPHIC$22(22*)

N $C65D Left Fighting Frame 4.
@ $C65D label=Sprite_Sabreman_Left_Fighting_4
  $C65D,$01 Width = #N(#PEEK(#PC)) bytes.
  $C65E,$01 Height = #N(#PEEK(#PC)) pixels.
  $C65F,$3F,$03 #GRAPHIC$23(23*)

N $C69E Left Fighting Frame 5.
@ $C69E label=Sprite_Sabreman_Left_Fighting_5
  $C69E,$01 Width = #N(#PEEK(#PC)) bytes.
  $C69F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6A0,$3F,$03 #GRAPHIC$24(24*)

N $C6DF Left Fighting Frame 6.
@ $C6DF label=Sprite_Sabreman_Left_Fighting_6
  $C6DF,$01 Width = #N(#PEEK(#PC)) bytes.
  $C6E0,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6E1,$3F,$03 #GRAPHIC$26(26*)

N $C720 Right Frame 1.
@ $C720 label=Sprite_Sabreman_Right_1
  $C720,$01 Width = #N(#PEEK(#PC)) bytes.
  $C721,$01 Height = #N(#PEEK(#PC)) pixels.
  $C722,$2A,$02 #GRAPHIC$14(14*)

N $C74C Right Frame 2.
@ $C74C label=Sprite_Sabreman_Right_2
  $C74C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C74D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C74E,$2A,$02 #GRAPHIC$15(15*)

N $C77A Right Frame 3.
@ $C77A label=Sprite_Sabreman_Right_3
  $C77A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C77B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C77C,$2A,$02 #GRAPHIC$16(16*)

N $C7A6 Right Fighting Frame 1.
@ $C7A6 label=Sprite_Sabreman_Right_Fighting_1
  $C7A6,$01 Width = #N(#PEEK(#PC)) bytes.
  $C7A7,$01 Height = #N(#PEEK(#PC)) pixels.
  $C7A8,$3F,$03 #GRAPHIC$28(28*)

N $C7E7 Right Fighting Frame 2.
@ $C7E7 label=Sprite_Sabreman_Right_Fighting_2
  $C7E7,$01 Width = #N(#PEEK(#PC)) bytes.
  $C7E8,$01 Height = #N(#PEEK(#PC)) pixels.
  $C7E9,$3F,$03 #GRAPHIC$29(29*)

N $C828 Right Fighting Frame 3.
@ $C828 label=Sprite_Sabreman_Right_Fighting_3
  $C828,$01 Width = #N(#PEEK(#PC)) bytes.
  $C829,$01 Height = #N(#PEEK(#PC)) pixels.
  $C82A,$3F,$03 #GRAPHIC$2A(2A*)

N $C869 Right Fighting Frame 4.
@ $C869 label=Sprite_Sabreman_Right_Fighting_4
  $C869,$01 Width = #N(#PEEK(#PC)) bytes.
  $C86A,$01 Height = #N(#PEEK(#PC)) pixels.
  $C86B,$3F,$03 #GRAPHIC$2B(2B*)

N $C8AA Right Fighting Frame 5.
@ $C8AA label=Sprite_Sabreman_Right_Fighting_5
  $C8AA,$01 Width = #N(#PEEK(#PC)) bytes.
  $C8AB,$01 Height = #N(#PEEK(#PC)) pixels.
  $C8AC,$3F,$03 #GRAPHIC$2C(2C*)

N $C8EB Right Fighting Frame 6.
@ $C8EB label=Sprite_Sabreman_Right_Fighting_6
  $C8EB,$01 Width = #N(#PEEK(#PC)) bytes.
  $C8EC,$01 Height = #N(#PEEK(#PC)) pixels.
  $C8ED,$3F,$03 #GRAPHIC$2D(2D*)

b $C92C Sprite: Rhino
@ $C92C label=Sprite_Rhino_Left_1
D $C92C The rhino sprites (sprite IDs #N$30-#N$33, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
. Frame 1 of each direction has the higher sprite ID.
E $C92C #UDGTABLE(default,centre)
. { =h Left | =h Right }{
.   #FRAMES(31,25;30)(rhino-left) |
.   #FRAMES(33,25;32)(rhino-right)
. }
. UDGTABLE#
N $C92C Left Frame 1.
  $C92C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C92D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C92E,$4C,$04 #GRAPHIC$31(31*)

N $C97A Left Frame 2.
@ $C97A label=Sprite_Rhino_Left_2
  $C97A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C97B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C97C,$4C,$04 #GRAPHIC$30(30*)

N $C9C8 Right Frame 1.
@ $C9C8 label=Sprite_Rhino_Right_1
  $C9C8,$01 Width = #N(#PEEK(#PC)) bytes.
  $C9C9,$01 Height = #N(#PEEK(#PC)) pixels.
  $C9CA,$4C,$04 #GRAPHIC$33(33*)

N $CA16 Right Frame 2.
@ $CA16 label=Sprite_Rhino_Right_2
  $CA16,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA17,$01 Height = #N(#PEEK(#PC)) pixels.
  $CA18,$4C,$04 #GRAPHIC$32(32*)

b $CA64 Sprite: Hippo Sleeping
@ $CA64 label=Sprite_Hippo_Sleeping
D $CA64 The sprite of the hippo when it is sleeping (sprite IDs #N$A4-#N$A7, see
. #R$BF84), which all share the same sprite.
  $CA64,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA65,$01 Height = #N(#PEEK(#PC)) pixels.
  $CA66,$48,$03 #GRAPHIC$A4(A4)

b $CAAE Sprite: Hippo
@ $CAAE label=Sprite_Hippo_Left_1
D $CAAE The hippo sprites (sprite IDs #N$A0-#N$A3, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $CAAE Left Frame 1.
  $CAAE,$01 Width = #N(#PEEK(#PC)) bytes.
  $CAAF,$01 Height = #N(#PEEK(#PC)) pixels.
  $CAB0,$48,$04 #GRAPHIC$A0(A0)

N $CAF8 Left Frame 2.
@ $CAF8 label=Sprite_Hippo_Left_2
  $CAF8,$01 Width = #N(#PEEK(#PC)) bytes.
  $CAF9,$01 Height = #N(#PEEK(#PC)) pixels.
  $CAFA,$4C,$04 #GRAPHIC$A1(A1)

N $CB46 Right Frame 1.
@ $CB46 label=Sprite_Hippo_Right_1
  $CB46,$01 Width = #N(#PEEK(#PC)) bytes.
  $CB47,$01 Height = #N(#PEEK(#PC)) pixels.
  $CB48,$48,$04 #GRAPHIC$A2(A2)

N $CB90 Right Frame 2.
@ $CB90 label=Sprite_Hippo_Right_2
  $CB90,$01 Width = #N(#PEEK(#PC)) bytes.
  $CB91,$01 Height = #N(#PEEK(#PC)) pixels.
  $CB92,$4C,$04 #GRAPHIC$A3(A3)

b $CBDE Sprite: Tribesman
@ $CBDE label=Sprite_Tribesman_Left_1
D $CBDE The tribesman sprites (sprite IDs #N$38-#N$3F, see #R$BF84). There are
. three animation frames facing left, followed by three animation frames facing
. right. Each direction has four sprite IDs which play the frames in the order
. 1, 2, 3, 2.
N $CBDE Left Frame 1.
  $CBDE,$01 Width = #N(#PEEK(#PC)) bytes.
  $CBDF,$01 Height = #N(#PEEK(#PC)) pixels.
  $CBE0,$2E,$02 #GRAPHIC$38(38)

N $CC0E Left Frame 2.
@ $CC0E label=Sprite_Tribesman_Left_2
  $CC0E,$01 Width = #N(#PEEK(#PC)) bytes.
  $CC0F,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC10,$2E,$02 #GRAPHIC$39(39)

N $CC3E Left Frame 3.
@ $CC3E label=Sprite_Tribesman_Left_3
  $CC3E,$01 Width = #N(#PEEK(#PC)) bytes.
  $CC3F,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC40,$2E,$02 #GRAPHIC$3A(3A)

N $CC6E Right Frame 1.
@ $CC6E label=Sprite_Tribesman_Right_1
  $CC6E,$01 Width = #N(#PEEK(#PC)) bytes.
  $CC6F,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC70,$2E,$02 #GRAPHIC$3B(3B)

N $CC9E Right Frame 2.
@ $CC9E label=Sprite_Tribesman_Right_2
  $CC9E,$01 Width = #N(#PEEK(#PC)) bytes.
  $CC9F,$01 Height = #N(#PEEK(#PC)) pixels.
  $CCA0,$2E,$02 #GRAPHIC$3C(3C)

N $CCCE Right Frame 3.
@ $CCCE label=Sprite_Tribesman_Right_3
  $CCCE,$01 Width = #N(#PEEK(#PC)) bytes.
  $CCCF,$01 Height = #N(#PEEK(#PC)) pixels.
  $CCD0,$2E,$02 #GRAPHIC$3D(3D)

b $CCFE Sprite: Spider
@ $CCFE label=Sprite_Spider_Left_1
D $CCFE The spider sprites (sprite IDs #N$60-#N$63, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $CCFE Left Frame 1.
  $CCFE,$01 Width = #N(#PEEK(#PC)) bytes.
  $CCFF,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD00,$3F,$03 #GRAPHIC$60(60)

N $CD3F Left Frame 2.
@ $CD3F label=Sprite_Spider_Left_2
  $CD3F,$01 Width = #N(#PEEK(#PC)) bytes.
  $CD40,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD41,$42,$03 #GRAPHIC$61(61)

N $CD83 Right Frame 1.
@ $CD83 label=Sprite_Spider_Right_1
  $CD83,$01 Width = #N(#PEEK(#PC)) bytes.
  $CD84,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD85,$3F,$03 #GRAPHIC$62(62)

N $CDC4 Right Frame 2.
@ $CDC4 label=Sprite_Spider_Right_2
  $CDC4,$01 Width = #N(#PEEK(#PC)) bytes.
  $CDC5,$01 Height = #N(#PEEK(#PC)) pixels.
  $CDC6,$42,$03 #GRAPHIC$63(63)

b $CE08 Sprite: Scorpion
@ $CE08 label=Sprite_Scorpion_Left_1
D $CE08 The scorpion sprites (sprite IDs #N$64-#N$67, see #R$BF84). There are
. two animation frames facing left, followed by two animation frames facing
. right.
N $CE08 Left Frame 1.
  $CE08,$01 Width = #N(#PEEK(#PC)) bytes.
  $CE09,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE0A,$3F,$03 #GRAPHIC$64(64)

N $CE49 Left Frame 2.
@ $CE49 label=Sprite_Scorpion_Left_2
  $CE49,$01 Width = #N(#PEEK(#PC)) bytes.
  $CE4A,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE4B,$3C,$03 #GRAPHIC$65(65)

N $CE87 Right Frame 1.
@ $CE87 label=Sprite_Scorpion_Right_1
  $CE87,$01 Width = #N(#PEEK(#PC)) bytes.
  $CE88,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE89,$3F,$03 #GRAPHIC$66(66)

N $CEC8 Right Frame 2.
@ $CEC8 label=Sprite_Scorpion_Right_2
  $CEC8,$01 Width = #N(#PEEK(#PC)) bytes.
  $CEC9,$01 Height = #N(#PEEK(#PC)) pixels.
  $CECA,$3C,$03 #GRAPHIC$67(67)

b $CF06 Sprite: Wulf
@ $CF06 label=Sprite_Wulf_Left_1
D $CF06 The sprites for Wulf (sprite IDs #N$50-#N$5D, see #R$BF84).
. .
. There are three walking frames facing left, followed by three facing right.
. Each direction has four sprite IDs which play the frames in the order 1, 2, 3,
. 2.
. .
. Then there are two pouncing frames facing left (#N$58 and #N$59) and two
. pouncing frames facing right (#N$5C and #N$5D).
N $CF06 Left Frame 1.
  $CF06,$01 Width = #N(#PEEK(#PC)) bytes.
  $CF07,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF08,$5C,$04 #GRAPHIC$50(50)

N $CF64 Left Frame 2.
@ $CF64 label=Sprite_Wulf_Left_2
  $CF64,$01 Width = #N(#PEEK(#PC)) bytes.
  $CF65,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF66,$5C,$04 #GRAPHIC$51(51)

N $CFC2 Left Frame 3.
@ $CFC2 label=Sprite_Wulf_Left_3
  $CFC2,$01 Width = #N(#PEEK(#PC)) bytes.
  $CFC3,$01 Height = #N(#PEEK(#PC)) pixels.
  $CFC4,$5C,$04 #GRAPHIC$52(52)

N $D020 Right Frame 1.
@ $D020 label=Sprite_Wulf_Right_1
  $D020,$01 Width = #N(#PEEK(#PC)) bytes.
  $D021,$01 Height = #N(#PEEK(#PC)) pixels.
  $D022,$5C,$04 #GRAPHIC$54(54)

N $D07E Right Frame 2.
@ $D07E label=Sprite_Wulf_Right_2
  $D07E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D07F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D080,$5C,$04 #GRAPHIC$55(55)

N $D0DC Right Frame 3.
@ $D0DC label=Sprite_Wulf_Right_3
  $D0DC,$01 Width = #N(#PEEK(#PC)) bytes.
  $D0DD,$01 Height = #N(#PEEK(#PC)) pixels.
  $D0DE,$5C,$04 #GRAPHIC$56(56)

N $D13A Pounce Left Frame 1.
@ $D13A label=Sprite_Wulf_Pounce_Left_1
  $D13A,$01 Width = #N(#PEEK(#PC)) bytes.
  $D13B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D13C,$40,$04 #GRAPHIC$58(58)

N $D17C Pounce Right Frame 1.
@ $D17C label=Sprite_Wulf_Pounce_Right_1
  $D17C,$01 Width = #N(#PEEK(#PC)) bytes.
  $D17D,$01 Height = #N(#PEEK(#PC)) pixels.
  $D17E,$40,$04 #GRAPHIC$5C(5C)

N $D1BE Pounce Left Frame 2.
@ $D1BE label=Sprite_Wulf_Pounce_Left_2
  $D1BE,$01 Width = #N(#PEEK(#PC)) bytes.
  $D1BF,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1C0,$60,$04 #GRAPHIC$59(59)

N $D220 Pounce Right Frame 2.
@ $D220 label=Sprite_Wulf_Pounce_Right_2
  $D220,$01 Width = #N(#PEEK(#PC)) bytes.
  $D221,$01 Height = #N(#PEEK(#PC)) pixels.
  $D222,$60,$04 #GRAPHIC$5D(5D)

b $D282 Sabreman: Attacked
@ $D282 label=Sprite_Sabreman_Attacked_Flying_Left
D $D282 The sprites for Sabreman when he has been attacked (sprite IDs
. #N$40-#N$47, see #R$BF84): flying through the air, sitting and dead, facing
. left and then facing right. The sitting sprite is used by two sprite IDs for
. each direction.
N $D282 Flying Left.
  $D282,$01 Width = #N(#PEEK(#PC)) bytes.
  $D283,$01 Height = #N(#PEEK(#PC)) pixels.
  $D284,$2C,$02 #GRAPHIC$40(40)

N $D2B0 Sitting Left.
@ $D2B0 label=Sprite_Sabreman_Attacked_Sitting_Left
  $D2B0,$01 Width = #N(#PEEK(#PC)) bytes.
  $D2B1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2B2,$24,$02 #GRAPHIC$41(41)

N $D2D6 Dead Left.
@ $D2D6 label=Sprite_Sabreman_Attacked_Dead_Left
  $D2D6,$01 Width = #N(#PEEK(#PC)) bytes.
  $D2D7,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2D8,$24,$03 #GRAPHIC$42(42)

N $D2FC Flying Right.
@ $D2FC label=Sprite_Sabreman_Attacked_Flying_Right
  $D2FC,$01 Width = #N(#PEEK(#PC)) bytes.
  $D2FD,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2FE,$2C,$02 #GRAPHIC$44(44)

N $D32A Sitting Right.
@ $D32A label=Sprite_Sabreman_Attacked_Sitting_Right
  $D32A,$01 Width = #N(#PEEK(#PC)) bytes.
  $D32B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D32C,$24,$02 #GRAPHIC$45(45)

N $D350 Dead Right.
@ $D350 label=Sprite_Sabreman_Attacked_Dead_Right
  $D350,$01 Width = #N(#PEEK(#PC)) bytes.
  $D351,$01 Height = #N(#PEEK(#PC)) pixels.
  $D352,$24,$03 #GRAPHIC$46(46)

b $D376 Sprite: Orchid
@ $D376 label=Sprite_Orchid_1
D $D376 The eight frames of the orchid (sprite IDs #N$48-#N$4F, see #R$BF84).
. Each frame is at least as big as the frame before it.
N $D376 Frame 1.
  $D376,$01 Width = #N(#PEEK(#PC)) bytes.
  $D377,$01 Height = #N(#PEEK(#PC)) pixels.
  $D378,$06,$02 #GRAPHIC$48(48)

N $D37E Frame 2.
@ $D37E label=Sprite_Orchid_2
  $D37E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D37F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D380,$06,$02 #GRAPHIC$49(49)

N $D386 Frame 3.
@ $D386 label=Sprite_Orchid_3
  $D386,$01 Width = #N(#PEEK(#PC)) bytes.
  $D387,$01 Height = #N(#PEEK(#PC)) pixels.
  $D388,$0A,$02 #GRAPHIC$4A(4A)

N $D392 Frame 4.
@ $D392 label=Sprite_Orchid_4
  $D392,$01 Width = #N(#PEEK(#PC)) bytes.
  $D393,$01 Height = #N(#PEEK(#PC)) pixels.
  $D394,$0C,$02 #GRAPHIC$4B(4B)

N $D3A0 Frame 5.
@ $D3A0 label=Sprite_Orchid_5
  $D3A0,$01 Width = #N(#PEEK(#PC)) bytes.
  $D3A1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D3A2,$10,$02 #GRAPHIC$4C(4C)

N $D3B2 Frame 6.
@ $D3B2 label=Sprite_Orchid_6
  $D3B2,$01 Width = #N(#PEEK(#PC)) bytes.
  $D3B3,$01 Height = #N(#PEEK(#PC)) pixels.
  $D3B4,$16,$02 #GRAPHIC$4D(4D)

N $D3CA Frame 7.
@ $D3CA label=Sprite_Orchid_7
  $D3CA,$01 Width = #N(#PEEK(#PC)) bytes.
  $D3CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D3CC,$1A,$02 #GRAPHIC$4E(4E)

N $D3E6 Frame 8.
@ $D3E6 label=Sprite_Orchid_8
  $D3E6,$01 Width = #N(#PEEK(#PC)) bytes.
  $D3E7,$01 Height = #N(#PEEK(#PC)) pixels.
  $D3E8,$30,$03 #GRAPHIC$4F(4F)

b $D418 Sprite: Parrot
@ $D418 label=Sprite_Parrot_Left_1
D $D418 The parrot sprites (sprite IDs #N$6C-#N$6F, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $D418 Left Frame 1.
  $D418,$01 Width = #N(#PEEK(#PC)) bytes.
  $D419,$01 Height = #N(#PEEK(#PC)) pixels.
  $D41A,$26,$02 #GRAPHIC$6C(6C)

N $D440 Left Frame 2.
@ $D440 label=Sprite_Parrot_Left_2
  $D440,$01 Width = #N(#PEEK(#PC)) bytes.
  $D441,$01 Height = #N(#PEEK(#PC)) pixels.
  $D442,$26,$02 #GRAPHIC$6D(6D)

N $D468 Right Frame 1.
@ $D468 label=Sprite_Parrot_Right_1
  $D468,$01 Width = #N(#PEEK(#PC)) bytes.
  $D469,$01 Height = #N(#PEEK(#PC)) pixels.
  $D46A,$26,$02 #GRAPHIC$6E(6E)

N $D490 Right Frame 2.
@ $D490 label=Sprite_Parrot_Right_2
  $D490,$01 Width = #N(#PEEK(#PC)) bytes.
  $D491,$01 Height = #N(#PEEK(#PC)) pixels.
  $D492,$26,$02 #GRAPHIC$6F(6F)

b $D4B8 Sprite: Monkey
@ $D4B8 label=Sprite_Monkey_Left_1
D $D4B8 The monkey sprites (sprite IDs #N$70-#N$73, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $D4B8 Left Frame 1.
  $D4B8,$01 Width = #N(#PEEK(#PC)) bytes.
  $D4B9,$01 Height = #N(#PEEK(#PC)) pixels.
  $D4BA,$2A,$02 #GRAPHIC$70(70)

N $D4E4 Left Frame 2.
@ $D4E4 label=Sprite_Monkey_Left_2
  $D4E4,$01 Width = #N(#PEEK(#PC)) bytes.
  $D4E5,$01 Height = #N(#PEEK(#PC)) pixels.
  $D4E6,$28,$02 #GRAPHIC$71(71)

N $D50E Right Frame 1.
@ $D50E label=Sprite_Monkey_Right_1
  $D50E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D50F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D510,$2A,$02 #GRAPHIC$72(72)

N $D53A Right Frame 2.
@ $D53A label=Sprite_Monkey_Right_2
  $D53A,$01 Width = #N(#PEEK(#PC)) bytes.
  $D53B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D53C,$28,$02 #GRAPHIC$73(73)

b $D564 Sprite: Lizard
@ $D564 label=Sprite_Lizard_Left_1
D $D564 The lizard sprites (sprite IDs #N$74-#N$77, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $D564 Left Frame 1.
  $D564,$01 Width = #N(#PEEK(#PC)) bytes.
  $D565,$01 Height = #N(#PEEK(#PC)) pixels.
  $D566,$27,$03 #GRAPHIC$74(74)

N $D58D Left Frame 2.
@ $D58D label=Sprite_Lizard_Left_2
  $D58D,$01 Width = #N(#PEEK(#PC)) bytes.
  $D58E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D58F,$2A,$03 #GRAPHIC$75(75)

N $D5B9 Right Frame 1.
@ $D5B9 label=Sprite_Lizard_Right_1
  $D5B9,$01 Width = #N(#PEEK(#PC)) bytes.
  $D5BA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5BB,$2A,$03 #GRAPHIC$76(76)

N $D5E5 Right Frame 2.
@ $D5E5 label=Sprite_Lizard_Right_2
  $D5E5,$01 Width = #N(#PEEK(#PC)) bytes.
  $D5E6,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5E7,$27,$03 #GRAPHIC$77(77)

b $D60E Sprite: Snake
@ $D60E label=Sprite_Snake_Left_1
D $D60E The snake sprites (sprite IDs #N$78-#N$7B, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $D60E Left Frame 1.
  $D60E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D60F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D610,$27,$03 #GRAPHIC$78(78)

N $D637 Left Frame 2.
@ $D637 label=Sprite_Snake_Left_2
  $D637,$01 Width = #N(#PEEK(#PC)) bytes.
  $D638,$01 Height = #N(#PEEK(#PC)) pixels.
  $D639,$21,$03 #GRAPHIC$79(79)

N $D65A Right Frame 1.
@ $D65A label=Sprite_Snake_Right_1
  $D65A,$01 Width = #N(#PEEK(#PC)) bytes.
  $D65B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D65C,$21,$03 #GRAPHIC$7A(7A)

N $D67D Right Frame 2.
@ $D67D label=Sprite_Snake_Right_2
  $D67D,$01 Width = #N(#PEEK(#PC)) bytes.
  $D67E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D67F,$27,$03 #GRAPHIC$7B(7B)

b $D6A6 Table: Orchid Positions
@ $D6A6 label=TableOrchidPositions
D $D6A6 The position of the orchid in each of the #N$30 room layouts, as an X
. and Y pair (the layout of a room is found with the table at #R$6066). See
. #R$A7D4.
  $D6A6,$60,$02

b $D706 Sprite: Explosion
@ $D706 label=Sprite_Explosion_1
D $D706 The four frames of the explosion (sprite IDs #N$08-#N$0D, see #R$BF84),
. which are used when an actor is blown up (see #R$A4A6). As the sprite ID goes
. up from #N$08 to #N$0D the frames are played in the order 2, 3, 4, 3, 2, 1.
N $D706 Frame 1.
  $D706,$01 Width = #N(#PEEK(#PC)) bytes.
  $D707,$01 Height = #N(#PEEK(#PC)) pixels.
  $D708,$3F,$03 #GRAPHIC$0D(0D)

N $D747 Frame 2.
@ $D747 label=Sprite_Explosion_2
  $D747,$01 Width = #N(#PEEK(#PC)) bytes.
  $D748,$01 Height = #N(#PEEK(#PC)) pixels.
  $D749,$45,$03 #GRAPHIC$08(08)

N $D78E Frame 3.
@ $D78E label=Sprite_Explosion_3
  $D78E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D78F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D790,$48,$03 #GRAPHIC$09(09)

N $D7D8 Frame 4.
@ $D7D8 label=Sprite_Explosion_4
  $D7D8,$01 Width = #N(#PEEK(#PC)) bytes.
  $D7D9,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7DA,$48,$03 #GRAPHIC$0A(0A)

b $D822 Sprite: Appearing
@ $D822 label=Sprite_Appearing_1
D $D822 The six frames of the sprite which is shown while a nastie is appearing
. (sprite IDs #N$01-#N$06, see #R$BF84 and #R$A3C5).
N $D822 Frame 1.
  $D822,$01 Width = #N(#PEEK(#PC)) bytes.
  $D823,$01 Height = #N(#PEEK(#PC)) pixels.
  $D824,$2A,$03 #GRAPHIC$01(01)

N $D84E Frame 2.
@ $D84E label=Sprite_Appearing_2
  $D84E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D84F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D850,$39,$03 #GRAPHIC$02(02)

N $D889 Frame 3.
@ $D889 label=Sprite_Appearing_3
  $D889,$01 Width = #N(#PEEK(#PC)) bytes.
  $D88A,$01 Height = #N(#PEEK(#PC)) pixels.
  $D88B,$45,$03 #GRAPHIC$03(03)

N $D8D0 Frame 4.
@ $D8D0 label=Sprite_Appearing_4
  $D8D0,$01 Width = #N(#PEEK(#PC)) bytes.
  $D8D1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8D2,$45,$03 #GRAPHIC$04(04)

N $D917 Frame 5.
@ $D917 label=Sprite_Appearing_5
  $D917,$01 Width = #N(#PEEK(#PC)) bytes.
  $D918,$01 Height = #N(#PEEK(#PC)) pixels.
  $D919,$45,$03 #GRAPHIC$05(05)

N $D95E Frame 6.
@ $D95E label=Sprite_Appearing_6
  $D95E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D95F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D960,$39,$03 #GRAPHIC$06(06)

b $D999 Sprite: Crate
@ $D999 label=Sprite_Crate
D $D999 The crate (sprite IDs #N$80 and #N$88, see #R$BF84). This is object type
. #N$00.
  $D999,$01 Width = #N(#PEEK(#PC)) bytes.
  $D99A,$01 Height = #N(#PEEK(#PC)) pixels.
  $D99B,$20,$02 #GRAPHIC$80(80)

b $D9BB Sprite: Ring
@ $D9BB label=Sprite_Ring
D $D9BB The ring (sprite IDs #N$81 and #N$89, see #R$BF84). This is object type
. #N$01.
  $D9BB,$01 Width = #N(#PEEK(#PC)) bytes.
  $D9BC,$01 Height = #N(#PEEK(#PC)) pixels.
  $D9BD,$20,$02 #GRAPHIC$81(ring)

b $D9DD Sprite: Fruit
@ $D9DD label=Sprite_Fruit
D $D9DD The fruit (sprite IDs #N$82 and #N$8A, see #R$BF84). This is object type
. #N$02.
  $D9DD,$01 Width = #N(#PEEK(#PC)) bytes.
  $D9DE,$01 Height = #N(#PEEK(#PC)) pixels.
  $D9DF,$20,$02 #GRAPHIC$82(82)

b $D9FF Sprite: Cap
@ $D9FF label=Sprite_Cap
D $D9FF The cap (sprite IDs #N$83 and #N$8B, see #R$BF84). This is object type
. #N$03.
  $D9FF,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA00,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA01,$20,$02 #GRAPHIC$83(83)

b $DA21 Sprite: Shield
@ $DA21 label=Sprite_Shield
D $DA21 The shield (sprite IDs #N$84, #N$8C and #N$8D, see #R$BF84). This is
. object type #N$04.
  $DA21,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA22,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA23,$20,$02 #GRAPHIC$84(84)

b $DA43 Sprite: Life
@ $DA43 label=Sprite_Life
D $DA43 The extra life (sprite ID #N$85, see #R$BF84). This is object type
. #N$05. Sprite ID #N$8D uses the shield sprite rather than this one.
  $DA43,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA44,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA45,$20,$02 #GRAPHIC$85(85)

b $DA65 Sprite: Money Bag
@ $DA65 label=Sprite_Money_Bag
D $DA65 The money bag (sprite IDs #N$86 and #N$8E, see #R$BF84). This is object
. type #N$06.
  $DA65,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA66,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA67,$20,$02 #GRAPHIC$86(86)

b $DA87 Sprite: Sword
@ $DA87 label=Sprite_Sword
D $DA87 The sword (sprite IDs #N$87 and #N$8F, see #R$BF84). This is object type
. #N$07.
  $DA87,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA88,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA89,$20,$02 #GRAPHIC$87(87)

b $DAA9 Sprite: Unused?
@ $DAA9 label=Sprite_Unused_1
D $DAA9 Three sprites which are not in the sprite table at #R$BF84, so they are
. never drawn. They have the same format as the other sprites.
N $DAA9 Not in the sprite table.
  $DAA9,$01 Width = #N(#PEEK(#PC)) bytes.
  $DAAA,$01 Height = #N(#PEEK(#PC)) pixels.
  $DAAB,$20,$02 #NOCROP(#PC,$02,$10,$07)(unused-01)

N $DACB Not in the sprite table.
@ $DACB label=Sprite_Unused_2
  $DACB,$01 Width = #N(#PEEK(#PC)) bytes.
  $DACC,$01 Height = #N(#PEEK(#PC)) pixels.
  $DACD,$20,$02 #NOCROP(#PC,$02,$10,$07)(unused-02)

N $DAED Not in the sprite table.
@ $DAED label=Sprite_Unused_3
  $DAED,$01 Width = #N(#PEEK(#PC)) bytes.
  $DAEE,$01 Height = #N(#PEEK(#PC)) pixels.
  $DAEF,$1C,$02 #CROP(#PC,$02,$0E,$07)(unused-03)

b $DB0B Sprite: Sleeping Warthog
@ $DB0B label=Sprite_Warthog_Sleeping
D $DB0B The sprite of the warthog when it is sleeping (sprite IDs #N$AC-#N$AF,
. see #R$BF84), which all share the same sprite.
  $DB0B,$01 Width = #N(#PEEK(#PC)) bytes.
  $DB0C,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB0D,$3F,$03 #GRAPHIC$AC(AC)

b $DB4C Sprite: Warthog
@ $DB4C label=Sprite_Warthog_Left_1
D $DB4C The warthog sprites (sprite IDs #N$A8-#N$AB, see #R$BF84). There are two
. animation frames facing left and two facing right, which are stored in the
. order left frame 1, right frame 1, right frame 2 and left frame 2.
N $DB4C Left Frame 1.
  $DB4C,$01 Width = #N(#PEEK(#PC)) bytes.
  $DB4D,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB4E,$44,$04 #GRAPHIC$A8(A8)

N $DB92 Right Frame 1.
@ $DB92 label=Sprite_Warthog_Right_1
  $DB92,$01 Width = #N(#PEEK(#PC)) bytes.
  $DB93,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB94,$48,$04 #GRAPHIC$AA(AA)

N $DBDC Right Frame 2.
@ $DBDC label=Sprite_Warthog_Right_2
  $DBDC,$01 Width = #N(#PEEK(#PC)) bytes.
  $DBDD,$01 Height = #N(#PEEK(#PC)) pixels.
  $DBDE,$44,$04 #GRAPHIC$AB(AB)

N $DC22 Left Frame 2.
@ $DC22 label=Sprite_Warthog_Left_2
  $DC22,$01 Width = #N(#PEEK(#PC)) bytes.
  $DC23,$01 Height = #N(#PEEK(#PC)) pixels.
  $DC24,$48,$04 #GRAPHIC$A9(A9)

b $DC6C Object Position Table
@ $DC6C label=ObjectLocation
D $DC6C The positions at which objects can be placed, with an entry of eight
. bytes for each of the #N$30 room layouts (the layout of a room is found with
. the table at #R$6066). An entry is four X/Y pairs, so there are four possible
. positions in each layout. #R$A33B uses bits 6-7 of an entry in #R$DDEC to
. choose between the four, and #R$A255 puts a piece of the amulet at the first
. position of a layout.
. .
. The entry for layout #N$01 is all zeros.
  $DC6C,$180,$08 Four X/ Y positions.

b $DDEC Room Object Table
@ $DDEC label=RoomObjectTable
D $DDEC The objects found in the rooms, with two bytes for each of the #N$0100
. rooms (indexed by the room). A byte of zero means there is no object.
. Otherwise bits 6-7 choose one of the four positions in the layout of the room
. (see #R$DC6C) and bits 0-3 are the type of the object, which gives the sprite
. ID when #N$80 is added.
. .
. The table is filled in by #R$A2BD when a new game starts. The table for the
. player who is not playing is kept in #R$DFEC.
  $DDEC,$0200,$10

b $DFEC Stored Room Object Table
@ $DFEC label=RoomObjectTable_Stored
D $DFEC The copy of #R$DDEC which belongs to the player who is not playing. The
. two are swapped by #R$B235 when the players change.
  $DFEC,$0200,$10

b $E1EC Background Graphic Game Completed
@ $E1EC label=Graphic_Background_Game_Completed
D $E1EC #BG(#PC)(background-complete)
. .
. The background of the Game Completed screen, which is drawn as part of the
. room data at #R$C386 (see #R$9F6A). The graphic is #N$18 pixels high and #N$10
. bytes wide.
N $E1EC Pixels.
  $E1EC,$01 Height = #N(#PEEK(#PC)) pixels.
  $E1ED,$01 Width = #N(#PEEK(#PC)) bytes.
  $E1EE,$180,$10 Pixel data.
N $E36E Attributes.
  $E36E,$01 Height = #N(#PEEK(#PC)) bytes.
  $E36F,$01 Width = #N(#PEEK(#PC)) bytes.
  $E370,$30,$10 Attribute data.

b $E3A0 Graphic: Amulet Outline
@ $E3A0 label=Graphic_Amulet_Outline_Top_Left
D $E3A0 #UDGTABLE(default,centre,centre)
. { #BG($E3A0)(outline-01) | #BG($E494)(outline-02) }
. { #BG($E588)(outline-03) | #BG($E67C)(outline-04) }
. UDGTABLE#
. .
. The four graphics which make up the outline of the amulet on the amulet
. screen (see #R$A207 and #R$C374). Each one is #N$20 pixels high and #N$06
. bytes wide, and has two sets of attributes. The first set draws the piece
. in plain red, when it has not been collected, and the second set draws it
. in colour when it has been collected.
N $E3A0 Top Left: pixels.
  $E3A0,$01 Height = #N(#PEEK(#PC)) pixels.
  $E3A1,$01 Width = #N(#PEEK(#PC)) bytes.
  $E3A2,$C0,$06 Pixel data.
N $E462 Top Left: attributes for a piece which has not been collected.
  $E462,$01 Height = #N(#PEEK(#PC)) character rows.
  $E463,$01 Width = #N(#PEEK(#PC)) bytes.
  $E464,$18,$06 Attribute data.
N $E47C Top Left: attributes for a piece which has been collected.
  $E47C,$18,$06 Attribute data.

@ $E494 label=Graphic_Amulet_Outline_Top_Right
N $E494 Top Right: pixels.
  $E494,$01 Height = #N(#PEEK(#PC)) pixels.
  $E495,$01 Width = #N(#PEEK(#PC)) bytes.
  $E496,$C0,$06 Pixel data.
N $E556 Top Right: attributes for a piece which has not been collected.
  $E556,$01 Height = #N(#PEEK(#PC)) character rows.
  $E557,$01 Width = #N(#PEEK(#PC)) bytes.
  $E558,$18,$06 Attribute data.
N $E570 Top Right: attributes for a piece which has been collected.
  $E570,$18,$06 Attribute data.

@ $E588 label=Graphic_Amulet_Outline_Bottom_Left
N $E588 Bottom Left: pixels.
  $E588,$01 Height = #N(#PEEK(#PC)) pixels.
  $E589,$01 Width = #N(#PEEK(#PC)) bytes.
  $E58A,$C0,$06 Pixel data.
N $E64A Bottom Left: attributes for a piece which has not been collected.
  $E64A,$01 Height = #N(#PEEK(#PC)) character rows.
  $E64B,$01 Width = #N(#PEEK(#PC)) bytes.
  $E64C,$18,$06 Attribute data.
N $E664 Bottom Left: attributes for a piece which has been collected.
  $E664,$18,$06 Attribute data.

@ $E67C label=Graphic_Amulet_Outline_Bottom_Right
N $E67C Bottom Right: pixels.
  $E67C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E67D,$01 Width = #N(#PEEK(#PC)) bytes.
  $E67E,$C0,$06 Pixel data.
N $E73E Bottom Right: attributes for a piece which has not been collected.
  $E73E,$01 Height = #N(#PEEK(#PC)) character rows.
  $E73F,$01 Width = #N(#PEEK(#PC)) bytes.
  $E740,$18,$06 Attribute data.
N $E758 Bottom Right: attributes for a piece which has been collected.
  $E758,$18,$06 Attribute data.

b $E770 Graphic: Amulet
@ $E770 label=Graphic_Amulet_Top_Left
D $E770 #UDGTABLE(default,centre,centre)
. { #GRAPHIC$93(93) | #GRAPHIC$92(92) }
. { #GRAPHIC$91(91) | #GRAPHIC$90(90) }
. UDGTABLE#
. .
. The four pieces of the amulet which are picked up in the rooms (sprite IDs
. #N$90-#N$93, see #R$BF84 and #R$A255). Each one is #N$10 pixels high and #N$02
. bytes wide.
N $E770 Top Left.
  $E770,$01 Width = #N(#PEEK(#PC)) bytes.
  $E771,$01 Height = #N(#PEEK(#PC)) pixels.
  $E772,$20,$02 #GRAPHIC$93(93)

N $E792 Top Right.
@ $E792 label=Graphic_Amulet_Top_Right
  $E792,$01 Width = #N(#PEEK(#PC)) bytes.
  $E793,$01 Height = #N(#PEEK(#PC)) pixels.
  $E794,$20,$02 #GRAPHIC$92(92)

N $E7B4 Bottom Left.
@ $E7B4 label=Graphic_Amulet_Bottom_Left
  $E7B4,$01 Width = #N(#PEEK(#PC)) bytes.
  $E7B5,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7B6,$20,$02 #GRAPHIC$91(91)

N $E7D6 Bottom Right.
@ $E7D6 label=Graphic_Amulet_Bottom_Right
  $E7D6,$01 Width = #N(#PEEK(#PC)) bytes.
  $E7D7,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7D8,$20,$02 #GRAPHIC$90(90)

b $E7F8 Sprite: The Guardian
@ $E7F8 label=Sprite_The_Guardian_1
D $E7F8 The two frames of the guardian (sprite IDs #N$94-#N$95, see #R$BF84).
. Each frame is #N$04 bytes wide and #N$20 pixels high.
N $E7F8 Frame 1.
  $E7F8,$01 Width = #N(#PEEK(#PC)) bytes.
  $E7F9,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7FA,$80,$04 #GRAPHIC$94(94*)

N $E87A Frame 2.
@ $E87A label=Sprite_The_Guardian_2
  $E87A,$01 Width = #N(#PEEK(#PC)) bytes.
  $E87B,$01 Height = #N(#PEEK(#PC)) pixels.
  $E87C,$80,$04 #GRAPHIC$95(95*)

b $E8FC Sprite: Flame
@ $E8FC label=Sprite_Flame_1
D $E8FC The four frames of the flame (sprite IDs #N$34-#N$37, see #R$BF84 and
. #R$9D91).
N $E8FC Frame 1.
  $E8FC,$01 Width = #N(#PEEK(#PC)) bytes.
  $E8FD,$01 Height = #N(#PEEK(#PC)) pixels.
  $E8FE,$2C,$02 #GRAPHIC$34(34*)

N $E92A Frame 2.
@ $E92A label=Sprite_Flame_2
  $E92A,$01 Width = #N(#PEEK(#PC)) bytes.
  $E92B,$01 Height = #N(#PEEK(#PC)) pixels.
  $E92C,$2C,$02 #GRAPHIC$35(35*)

N $E958 Frame 3.
@ $E958 label=Sprite_Flame_3
  $E958,$01 Width = #N(#PEEK(#PC)) bytes.
  $E959,$01 Height = #N(#PEEK(#PC)) pixels.
  $E95A,$2E,$02 #GRAPHIC$36(36*)

N $E988 Frame 4.
@ $E988 label=Sprite_Flame_4
  $E988,$01 Width = #N(#PEEK(#PC)) bytes.
  $E989,$01 Height = #N(#PEEK(#PC)) pixels.
  $E98A,$2E,$02 #GRAPHIC$37(37*)

b $E9B8 Sprite: Rat
@ $E9B8 label=Sprite_Rat_Left_1
D $E9B8 The rat sprites (sprite IDs #N$98-#N$9B, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $E9B8 Left Frame 1.
  $E9B8,$01 Width = #N(#PEEK(#PC)) bytes.
  $E9B9,$01 Height = #N(#PEEK(#PC)) pixels.
  $E9BA,$1B,$03 #GRAPHIC$98(98)

N $E9D5 Left Frame 2.
@ $E9D5 label=Sprite_Rat_Left_2
  $E9D5,$01 Width = #N(#PEEK(#PC)) bytes.
  $E9D6,$01 Height = #N(#PEEK(#PC)) pixels.
  $E9D7,$1B,$03 #GRAPHIC$99(99)

N $E9F2 Right Frame 1.
@ $E9F2 label=Sprite_Rat_Right_1
  $E9F2,$01 Width = #N(#PEEK(#PC)) bytes.
  $E9F3,$01 Height = #N(#PEEK(#PC)) pixels.
  $E9F4,$1B,$03 #GRAPHIC$9A(9A)

N $EA0F Right Frame 2.
@ $EA0F label=Sprite_Rat_Right_2
  $EA0F,$01 Width = #N(#PEEK(#PC)) bytes.
  $EA10,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA11,$1B,$03 #GRAPHIC$9B(9B)

b $EA2C Sprite: Bird
@ $EA2C label=Sprite_Bird_Left_1
D $EA2C The bird sprites (sprite IDs #N$9C-#N$9F, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $EA2C Left Frame 1.
  $EA2C,$01 Width = #N(#PEEK(#PC)) bytes.
  $EA2D,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA2E,$36,$03 #GRAPHIC$9C(9C)

N $EA64 Left Frame 2.
@ $EA64 label=Sprite_Bird_Left_2
  $EA64,$01 Width = #N(#PEEK(#PC)) bytes.
  $EA65,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA66,$42,$03 #GRAPHIC$9D(9D)

N $EAA8 Right Frame 1.
@ $EAA8 label=Sprite_Bird_Right_1
  $EAA8,$01 Width = #N(#PEEK(#PC)) bytes.
  $EAA9,$01 Height = #N(#PEEK(#PC)) pixels.
  $EAAA,$36,$03 #GRAPHIC$9E(9E)

N $EAE0 Right Frame 2.
@ $EAE0 label=Sprite_Bird_Right_2
  $EAE0,$01 Width = #N(#PEEK(#PC)) bytes.
  $EAE1,$01 Height = #N(#PEEK(#PC)) pixels.
  $EAE2,$42,$03 #GRAPHIC$9F(9F)

b $EB24 Sprite: Mosquito
@ $EB24 label=Sprite_Mosquito_Left_1
D $EB24 The mosquito sprites (sprite IDs #N$B4-#N$B7, see #R$BF84). There are
. two animation frames facing left, followed by two animation frames facing
. right.
N $EB24 Left Frame 1.
  $EB24,$01 Width = #N(#PEEK(#PC)) bytes.
  $EB25,$01 Height = #N(#PEEK(#PC)) pixels.
  $EB26,$20,$02 #GRAPHIC$B4(B4)

N $EB46 Left Frame 2.
@ $EB46 label=Sprite_Mosquito_Left_2
  $EB46,$01 Width = #N(#PEEK(#PC)) bytes.
  $EB47,$01 Height = #N(#PEEK(#PC)) pixels.
  $EB48,$1C,$02 #GRAPHIC$B5(B5)

N $EB64 Right Frame 1.
@ $EB64 label=Sprite_Mosquito_Right_1
  $EB64,$01 Width = #N(#PEEK(#PC)) bytes.
  $EB65,$01 Height = #N(#PEEK(#PC)) pixels.
  $EB66,$20,$02 #GRAPHIC$B6(B6)

N $EB86 Right Frame 2.
@ $EB86 label=Sprite_Mosquito_Right_2
  $EB86,$01 Width = #N(#PEEK(#PC)) bytes.
  $EB87,$01 Height = #N(#PEEK(#PC)) pixels.
  $EB88,$1C,$02 #GRAPHIC$B7(B7)

b $EBA4 Sprite: Frog
@ $EBA4 label=Sprite_Frog_Left_1
D $EBA4 The frog sprites (sprite IDs #N$B0-#N$B3, see #R$BF84). There are two
. animation frames facing left, followed by two animation frames facing right.
N $EBA4 Left Frame 1.
  $EBA4,$01 Width = #N(#PEEK(#PC)) bytes.
  $EBA5,$01 Height = #N(#PEEK(#PC)) pixels.
  $EBA6,$24,$03 #GRAPHIC$B0(B0)

N $EBCA Left Frame 2.
@ $EBCA label=Sprite_Frog_Left_2
  $EBCA,$01 Width = #N(#PEEK(#PC)) bytes.
  $EBCB,$01 Height = #N(#PEEK(#PC)) pixels.
  $EBCC,$1E,$03 #GRAPHIC$B1(B1)

N $EBEA Right Frame 1.
@ $EBEA label=Sprite_Frog_Right_1
  $EBEA,$01 Width = #N(#PEEK(#PC)) bytes.
  $EBEB,$01 Height = #N(#PEEK(#PC)) pixels.
  $EBEC,$24,$03 #GRAPHIC$B2(B2)

N $EC10 Right Frame 2.
@ $EC10 label=Sprite_Frog_Right_2
  $EC10,$01 Width = #N(#PEEK(#PC)) bytes.
  $EC11,$01 Height = #N(#PEEK(#PC)) pixels.
  $EC12,$1E,$03 #GRAPHIC$B3(B3)

t $EC30 Messaging: Copyright
@ $EC30 label=CopyrightMessage
D $EC30 The copyright message of the game, which is not referenced by any code.
  $EC30,$2F

b $EC5F Unused Data
@ $EC5F label=UnusedData
D $EC5F This area is not referenced by any code.
  $EC5F,$03A1,$10

g $F000 Shift Table
@ $F000 label=ShiftTable
D $F000 The lookup table which is used to shift the pixels of a sprite, so it
. can be drawn at any pixel position. It is built by #R$B902 when a game is
. started and is used by the sprite drawing code (see #R$B939).
. .
. There are eight pairs of pages, one pair for each of the eight pixel offsets.
. In each pair the entry for a byte value holds that byte shifted left by the
. offset, as a 16-bit number: the low byte is in the page #N$FF - (#N$02 *
. offset) and the high byte is in the page below it.
  $F000,$1000,$10
