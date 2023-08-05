> $4000 @org=$4000
b $4000 Loading screen
D $4000 #UDGTABLE { =h Sabre Wulf Loading Screen } { #SCR$02(loading) } UDGTABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

c $5B80 Decryption Routine
N $5B80 Runs "CPL" on every byte from #N$6000-#N$6000.
E $5B80 View the equivalent code in #LUNARJETMAN$5B80.
E $5B80 Earlier Ultimate games use a much simpler mechanism;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #PSSST$5B80 }
. { #TRANZAM$5B80 }
. LIST#
@ $5B80 label=Decryption
  $5B80,$03 #REGhl=#R$6000.
@ $5B83 label=Decryption_Loop
  $5B83,$01 #REGa=#REGhl.
  $5B84,$01 CPL operation.
  $5B85,$01 Write #REGa back to #REGhl.
  $5B86,$01 Increment #REGhl by one.
  $5B87,$04 Jump back to #R$5B83 when #REGl is #N$F0.
  $5B87,$01 Return.

i $5B88

b $5B8D

c $5CB0 Indirect Jump
E $5CB0 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$5CB0 }
. LIST#
@ $5CB0 label=IndirectJump
  $5CB0,$01 Jump to the address held in #REGhl.

i $5CB1

c $6000 Entry Point
c $6000 Game entry point
E $6000 View the equivalent code in;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #TRANZAM$5B80 }
. LIST#
@ $6000 label=GameEntry
  $6000,$01 Disable interrupts.
  $6001,$03 Set the stack pointer to #N$6000.
  $6004,$03 Jump to #R$995A.

t $6007

b $6036

b $6066 Layout
@ $6066 label=Layout
  $6066,$100,$10

w $6166 Room Table
@ $6166 label=RoomTable
W $6166,$02 Room ID: #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100)(#N(#EVAL((#PC - $6166) / $02))).
L $6166,$02,$30

w $61C6 Special Room (Main Menu)
D $61C6 This is the room data showing on the Main Menu screen. See #R$B3D5.
D $61C6 #UDGTABLE { #ROOM(#PC)(room-mainmenu) } UDGTABLE#
@ $61C6 label=Room_Special_MainMenu
  $61C6,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $61C8,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $61C6,$04,$0E
  $61FE,$02 Terminator.

w $6200 Room #N$00
D $6200 #UDGTABLE { #ROOM(#PC)(room-00) } UDGTABLE#
@ $6200 label=Room_00
  $6200,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6202,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6200,$04,$12
  $6248,$02 Terminator.

w $624A Room #N$01
D $624A #UDGTABLE { #ROOM(#PC)(room-01) } UDGTABLE#
@ $624A label=Room_01
  $624A,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $624C,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $624A,$04,$12
  $6292,$02 Terminator.

w $6294 Room #N$02
D $6294 #UDGTABLE { #ROOM(#PC)(room-02) } UDGTABLE#
@ $6294 label=Room_02
  $6294,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6296,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6294,$04,$12
  $62DC,$02 Terminator.

w $62DE Room #N$03
D $62DE #UDGTABLE { #ROOM(#PC)(room-03) } UDGTABLE#
@ $62DE label=Room_03
  $62DE,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $62E0,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $62DE,$04,$14
  $632E,$02 Terminator.

w $6330 Room #N$04
D $6330 #UDGTABLE { #ROOM(#PC)(room-04) } UDGTABLE#
@ $6330 label=Room_04
  $6330,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6332,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6330,$04,$11
  $6374,$02 Terminator.

w $6376 Room #N$05
D $6376 #UDGTABLE { #ROOM(#PC)(room-05) } UDGTABLE#
@ $6376 label=Room_05
  $6376,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6378,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6376,$04,$16
  $63CE,$02 Terminator.

w $63D0 Room #N$06
D $63D0 #UDGTABLE { #ROOM(#PC)(room-06) } UDGTABLE#
@ $63D0 label=Room_06
  $63D0,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $63D2,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $63D0,$04,$14
  $6420,$02 Terminator.

w $6422 Room #N$07
D $6422 #UDGTABLE { #ROOM(#PC)(room-07) } UDGTABLE#
@ $6422 label=Room_07
  $6422,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6424,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6422,$04,$16
  $647A,$02 Terminator.

w $647C Room #N$08
D $647C #UDGTABLE { #ROOM(#PC)(room-08) } UDGTABLE#
@ $647C label=Room_08
  $647C,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $647E,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $647C,$04,$13
  $64C8,$02 Terminator.

w $64CA Room #N$09
D $64CA #UDGTABLE { #ROOM(#PC)(room-09) } UDGTABLE#
@ $64CA label=Room_09
  $64CA,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $64CC,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $64CA,$04,$15
  $651E,$02 Terminator.

w $6520 Room #N$0A
D $6520 #UDGTABLE { #ROOM(#PC)(room-0A) } UDGTABLE#
@ $6520 label=Room_0A
  $6520,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6522,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6520,$04,$19
  $6584,$02 Terminator.

w $6586 Room #N$0B
D $6586 #UDGTABLE { #ROOM(#PC)(room-0B) } UDGTABLE#
@ $6586 label=Room_0B
  $6586,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6588,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6586,$04,$0E
  $65BE,$02 Terminator.

w $65C0 Room #N$0C
D $65C0 #UDGTABLE { #ROOM(#PC)(room-0C) } UDGTABLE#
@ $65C0 label=Room_0C
  $65C0,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $65C2,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $65C0,$04,$15
  $6614,$02 Terminator.

w $6616 Room #N$0D
D $6616 #UDGTABLE { #ROOM(#PC)(room-0D) } UDGTABLE#
@ $6616 label=Room_0D
  $6616,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6618,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6616,$04,$15
  $666A,$02 Terminator.

w $666C Room #N$0E
D $666C #UDGTABLE { #ROOM(#PC)(room-0E) } UDGTABLE#
@ $666C label=Room_0E
  $666C,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $666E,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $666C,$04,$11
  $66B0,$02 Terminator.

w $66B2 Room #N$0F
D $66B2 #UDGTABLE { #ROOM(#PC)(room-0F) } UDGTABLE#
@ $66B2 label=Room_0F
  $66B2,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $66B4,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $66B2,$04,$1A
  $671A,$02 Terminator.

w $671C Room #N$10
D $671C #UDGTABLE { #ROOM(#PC)(room-10) } UDGTABLE#
@ $671C label=Room_10
  $671C,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $671E,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $671C,$04,$1A
  $6784,$02 Terminator.

w $6786 Room #N$11
D $6786 #UDGTABLE { #ROOM(#PC)(room-11) } UDGTABLE#
@ $6786 label=Room_11
  $6786,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6788,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6786,$04,$18
  $67E6,$02 Terminator.

w $67E8 Room #N$12
D $67E8 #UDGTABLE { #ROOM(#PC)(room-12) } UDGTABLE#
@ $67E8 label=Room_12
  $67E8,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $67EA,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $67E8,$04,$0D
  $681C,$02 Terminator.

w $681E Room #N$13
D $681E #UDGTABLE { #ROOM(#PC)(room-13) } UDGTABLE#
@ $681E label=Room_13
  $681E,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6820,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $681E,$04,$11
  $6862,$02 Terminator.

w $6864 Room #N$14
D $6864 #UDGTABLE { #ROOM(#PC)(room-14) } UDGTABLE#
@ $6864 label=Room_14
  $6864,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6866,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6864,$04,$13
  $68B0,$02 Terminator.

w $68B2 Room #N$15
D $68B2 #UDGTABLE { #ROOM(#PC)(room-15) } UDGTABLE#
@ $68B2 label=Room_15
  $68B2,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $68B4,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $68B2,$04,$12
  $68FA,$02 Terminator.

w $68FC Room #N$16
D $68FC #UDGTABLE { #ROOM(#PC)(room-16) } UDGTABLE#
@ $68FC label=Room_16
  $68FC,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $68FE,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $68FC,$04,$0F
  $6938,$02 Terminator.

w $693A Room #N$17
D $693A #UDGTABLE { #ROOM(#PC)(room-17) } UDGTABLE#
@ $693A label=Room_17
  $693A,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $693C,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $693A,$04,$13
  $6986,$02 Terminator.

w $6988 Room #N$18
D $6988 #UDGTABLE { #ROOM(#PC)(room-18) } UDGTABLE#
@ $6988 label=Room_18
  $6988,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $698A,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6988,$04,$15
  $69DC,$02 Terminator.

w $69DE Room #N$19
D $69DE #UDGTABLE { #ROOM(#PC)(room-19) } UDGTABLE#
@ $69DE label=Room_19
  $69DE,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $69E0,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $69DE,$04,$16
  $6A36,$02 Terminator.

w $6A38 Room #N$1A
D $6A38 #UDGTABLE { #ROOM(#PC)(room-1A) } UDGTABLE#
@ $6A38 label=Room_1A
  $6A38,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6A3A,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6A38,$04,$11
  $6A7C,$02 Terminator.

w $6A7E Room #N$1B
D $6A7E #UDGTABLE { #ROOM(#PC)(room-1B) } UDGTABLE#
@ $6A7E label=Room_1B
  $6A7E,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6A80,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6A7E,$04,$11
  $6AC2,$02 Terminator.

w $6AC4 Room #N$1C
D $6AC4 #UDGTABLE { #ROOM(#PC)(room-1C) } UDGTABLE#
@ $6AC4 label=Room_1C
  $6AC4,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6AC6,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6AC4,$04,$15
  $6B18,$02 Terminator.

w $6B1A Room #N$1D
D $6B1A #UDGTABLE { #ROOM(#PC)(room-1D) } UDGTABLE#
@ $6B1A label=Room_1D
  $6B1A,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6B1C,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6B1A,$04,$15
  $6B6E,$02 Terminator.

w $6B70 Room #N$1E
D $6B70 #UDGTABLE { #ROOM(#PC)(room-1E) } UDGTABLE#
@ $6B70 label=Room_1E
  $6B70,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6B72,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6B70,$04,$12
  $6BB8,$02 Terminator.

w $6BBA Room #N$1F
D $6BBA #UDGTABLE { #ROOM(#PC)(room-1F) } UDGTABLE#
@ $6BBA label=Room_1F
  $6BBA,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6BBC,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6BBA,$04,$13
  $6C06,$02 Terminator.

w $6C08 Room #N$20
D $6C08 #UDGTABLE { #ROOM(#PC)(room-20) } UDGTABLE#
@ $6C08 label=Room_20
  $6C08,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6C0A,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6C08,$04,$17
  $6C64,$02 Terminator.

w $6C66 Room #N$21
D $6C66 #UDGTABLE { #ROOM(#PC)(room-21) } UDGTABLE#
@ $6C66 label=Room_21
  $6C66,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6C68,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6C66,$04,$15
  $6CBA,$02 Terminator.

w $6CBC Room #N$22
D $6CBC #UDGTABLE { #ROOM(#PC)(room-22) } UDGTABLE#
@ $6CBC label=Room_22
  $6CBC,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6CBE,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6CBC,$04,$14
  $6D0C,$02 Terminator.

w $6D0E Room #N$23
D $6D0E #UDGTABLE { #ROOM(#PC)(room-23) } UDGTABLE#
@ $6D0E label=Room_23
  $6D0E,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6D10,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6D0E,$04,$12
  $6D56,$02 Terminator.

w $6D58 Room #N$24
D $6D58 #UDGTABLE { #ROOM(#PC)(room-24) } UDGTABLE#
@ $6D58 label=Room_24
  $6D58,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6D5A,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6D58,$04,$16
  $6DB0,$02 Terminator.

w $6DB2 Room #N$25
D $6DB2 #UDGTABLE { #ROOM(#PC)(room-25) } UDGTABLE#
@ $6DB2 label=Room_25
  $6DB2,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6DB4,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6DB2,$04,$17
  $6E0E,$02 Terminator.

w $6E10 Room #N$26
D $6E10 #UDGTABLE { #ROOM(#PC)(room-26) } UDGTABLE#
@ $6E10 label=Room_26
  $6E10,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6E12,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6E10,$04,$13
  $6E5C,$02 Terminator.

w $6E5E Room #N$27
D $6E5E #UDGTABLE { #ROOM(#PC)(room-27) } UDGTABLE#
@ $6E5E label=Room_27
  $6E5E,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6E60,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6E5E,$04,$10
  $6E9E,$02 Terminator.

w $6EA0 Room #N$28
D $6EA0 #UDGTABLE { #ROOM(#PC)(room-28) } UDGTABLE#
@ $6EA0 label=Room_28
  $6EA0,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6EA2,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6EA0,$04,$13
  $6EEC,$02 Terminator.

w $6EEE Room #N$29
D $6EEE #UDGTABLE { #ROOM(#PC)(room-29) } UDGTABLE#
@ $6EEE label=Room_29
  $6EEE,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6EF0,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6EEE,$04,$11
  $6F32,$02 Terminator.

w $6F34 Room #N$2A
D $6F34 #UDGTABLE { #ROOM(#PC)(room-2A) } UDGTABLE#
@ $6F34 label=Room_2A
  $6F34,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6F36,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6F34,$04,$0E
  $6F6C,$02 Terminator.

w $6F6E Room #N$2B
D $6F6E #UDGTABLE { #ROOM(#PC)(room-2B) } UDGTABLE#
@ $6F6E label=Room_2B
  $6F6E,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6F70,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6F6E,$04,$10
  $6FAE,$02 Terminator.

w $6FB0 Room #N$2C
D $6FB0 #UDGTABLE { #ROOM(#PC)(room-2C) } UDGTABLE#
@ $6FB0 label=Room_2C
  $6FB0,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6FB2,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6FB0,$04,$10
  $6FF0,$02 Terminator.

w $6FF2 Room #N$2D
D $6FF2 #UDGTABLE { #ROOM(#PC)(room-2D) } UDGTABLE#
@ $6FF2 label=Room_2D
  $6FF2,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6FF4,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6FF2,$04,$0F
  $702E,$02 Terminator.

w $7030 Room #N$2E
D $7030 #UDGTABLE { #ROOM(#PC)(room-2E) } UDGTABLE#
@ $7030 label=Room_2E
  $7030,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $7032,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $7030,$04,$11
  $7074,$02 Terminator.

w $7076 Room #N$2F
D $7076 #UDGTABLE { #ROOM(#PC)(room-2F) } UDGTABLE#
@ $7076 label=Room_2F
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
D $9692 #TABLE(default,centre,centre,centre,centre)
. { =h Byte Value | =h Binary | =h Option }
. { #N$00 | #EVAL($00, $02, $08) | 1 Player Game }
. { #N$01 | #EVAL($01, $02, $08) | 2 Player Game }
. { #N$02 | #EVAL($02, $02, $08) | Kempston Joystick }
. { #N$04 | #EVAL($04, $02, $08) | Cursor Joystick }
. { #N$06 | #EVAL($06, $02, $08) | Interface II Joystick }
. TABLE#
B $9692,$01

g $9693 Counter
@ $9693 label=CounterLow
@ $9694 label=CounterHigh
  $9693,$01,$02

g $9695 Rand8

g $9696 Last Frame
@ $9696 label=LastFrame

g $9697 Frame Updated
@ $9697 label=FrameUpdated
D $9697 Has the frame been updated? #N$00=No #N$01=Yes.

g $9698 1UP Score
D $9698 3-byte representation of the score.
@ $9698 label=1UP_Score_1
B $9698,$01 Byte #1.
@ $9699 label=1UP_Score_2
B $9699,$01 Byte #2.
@ $969A label=1UP_Score_3
B $969A,$01 Byte #3.

g $969B 2UP Score
D $969B 3-byte representation of the score.
@ $969B label=2UP_Score_1
B $969B,$01 Byte #1.
@ $969C label=2UP_Score_2
B $969C,$01 Byte #2.
@ $969D label=2UP_Score_3
B $969D,$01 Byte #3.

g $969E Flag: Active Player
@ $969E label=Flag_ActivePlayer
D $969E Which player is currently active.
. $969E #TABLE(default,centre,centre) { =h Value | =h Player }
. { #N$00 | 1UP }
. { #N$FF | 2UP }
. TABLE#

g $969F Saved Frame
@ $969F label=Saved_Frame
  $969F,$01

g $96A0 Saved X
@ $96A0 label=Saved_X
  $96A0,$01

g $96A1 Saved Y
@ $96A1 label=Saved_Y
  $96A1,$01

g $96A2 Saved Location (Room)
@ $96A2 label=Saved_Room
  $96A2,$01

g $96A3 Some Height
@ $96A3 label=SomeHeight
  $96A3,$01

g $96A4 Some Width
@ $96A4 label=SomeWidth
  $96A4,$01

g $96A5

g $96A8 Current Menu Item Colour attribute
@ $96A8 label=Current_MenuAttr
  $96A8,$01

b $96A9
  $96AB
  $96AD
  $96B0
  $96B1
  $96B2
  $96B3
  $96B4
  $96B5
  $96B6

g $96B7 Flag: Hall Of Fame
@ $96B7 label=FlagHallOfFame
B $96B7

g $96B8 Counter: Hall Of Fame
D $96B8 Counter for game selection screen, which tells the routine when to flip
.       to display the Hall Of Fame.
@ $96B8 label=CounterHallOfFame
W $96B8

g $96BA

g $96BC Active Player:

g $96BD Active Player: Lives
@ $96BD label=ActivePlayer_Lives

g $96BE

g $96BF

g $96DF Inactive Player:

g $96E0 Inactive Player Lives
@ $96E0 label=InactivePlayer_Lives
  $96E0,$01

g $96E1

g $9702
  $9703
  $970D
  $970E
  $9792

b $97FE Amulet Data
@ $97FE label=AmuletData
N $97FE Amulet part: #N(#EVAL((#PC - $97FE) / $0C) + $01).
  $97FE,$0C
L $97FE,$0C,$04

b $982E

c $995A Security Check
E $995A Continue on to #R$9960.
E $995A View the equivalent code in;
. #LIST
. { #COOKIE$5F00 }
. { #JETPAC$61E5 }
. { #LUNARJETMAN$8000 }
. { #PSSST$61C6 }
. { #TRANZAM$5F00 }
. LIST#
@ $995A label=SecurityCheck
  $995A,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $995D,$03 Return if #REGa is not #N$7D.

c $9960 Game Initialisation
E $9960 View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #JETPAC$61EB }
. { #LUNARJETMAN$800A }
. { #PSSST$61CD }
. { #TRANZAM$5F07 }
. LIST#
@ $9960 label=GameInitialisation
  $9960,$03 Call #R$BB9F.
  $9963,$03 Set the border to black.
  $9966,$03 Call #R$BB8F.
  $9969,$03 Call #R$BB81.
  $996C,$03 Call #R$B902.
N $996F Set the attributes for the top banner (the whole line is INK:#N$47).
  $996F,$03 #REGhl=#N$5800 (attribute buffer).
  $9972,$03 #REGbc=counter:#N$20, INK:#N$47.
@ $9975 label=CreateWindow_Loop_Banner
  $9975,$01 Write #N$47 to the attribute buffer.
  $9976,$01 Move onto the next column.
  $9977,$02 Decrease counter by one and loop back to #R$9975 until counter is zero.
  $9979,$03 Call #R$B563.
N $997C Set the attributes for the score line (the whole line is INK:#N$46).
  $997C,$03 #REGhl=#N$5820 (attribute buffer).
  $997F,$03 #REGbc=counter:#N$20, INK:#N$46.
@ $9982 label=CreateWindow_Loop_Score
  $9982,$01 Write #N$46 to the attribute buffer.
  $9983,$01 Move onto the next column.
  $9984,$02 Decrease counter by one and loop back to #R$9982 until counter is zero.
  $9986,$03 Call #R$B5CC.
  $9989,$03 Call #R$B5D4.
  $998C,$03 Call #R$B5DC.
@ $998F label=Game_Restart
  $998F,$03 Call #R$B3D5.
N $9992 Writes #N$00 to every address from #R$9698 to #R$995A.
  $9992,$03 #REGhl=#N$9698.
  $9995,$03 #REGbc=#N$02C2.
  $9998,$03 Call #R$BBA5.
  $999B,$03 Call #R$B5CC.
  $999E,$03 Call #R$B5D4.
  $99A1,$03 #REGde=#R$BD45.
  $99A4,$03 Call #R$BD6E.
  $99A7,$03 Call #R$B1D4.

  $99AA,$03 #REGsp=#R$6000.
  $99AD,$01 Enable interrupts.
  $99AE,$04 #REGix=#R$970E.
  $99B2,$04 #HTML(#REGc=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $99B6,$03 #REGa=#R$9696.
@ $99BC label=FrameUpdate
  $99BC,$01 Disable interrupts.
  $99BD,$06 #HTML(Store <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> at #R$9696.)
  $99C3,$05 Set #R$9697 to #N$01 (frame has updated).

  $99CC,$04 #REGix=#R$9702.

  $99DA,$04 Push #R$99F0 onto the stack.

  $99DE,$03 #REGbc=#R$9B3E.

c $99F0
  $99F0,$03 #REGde=#N($000C, $04, $04).
  $99FE,$03 #REGde=#R$982E.

N $9A18
  $9A18,$03 #REGde=#R$970E.
  $9A1B,$02 Jump to #R$9A01.

c $9A1D
  $9A1D,$03 #REGhl=#R$9693.
  $9A20,$04 Increment #REGhl by one, and write this value back to #R$9693.
  $9A24,$03 #REGa=#R$9695.
  $9A30,$03 Call #R$AC28.
  $9A33,$03 Call #R$9A3C.
  $9A36,$03 Call #R$9ABC.
  $9A39,$03 Jump to #R$99AA.

c $9A3C Handler: Destructable Enemies
@ $9A3C label=HandlerDestructableEnemies
  $9A3C,$05 If #R$96B5 is not zero, return.
  $9A41,$06 If #R$96B1 is zero, jump to #R$9A4C.
  $9A47,$01 Decrease #REGa by one.
  $9A48,$03 Write the value back to #R$96B1.
  $9A4B,$01 Return.

N $9A4C
  $9A4C,$03 #REGa=#R$9702.
  $9A54,$04 #REGix=#R$9792.
  $9A58,$03 #REGde=#N($000C,$04,$04).
  $9A5B,$02 #REGb=#N$06.
  $9A5D,$03 #REGa=#REGix+#N$00 (sprite reference).
  $9A60,$03 If #REGa is zero, jump to #R$9A68.
  $9A63,$02 #REGix=#REGix+#REGde.
  $9A65,$02 Decrease counter by one and loop back to #R$9A5D until counter is zero.
  $9A67,$01 Return.

c $9A68
  $9A68,$03 #REGhl=#N$9792.
  $9A6B,$02 #REGb=#N$06.
  $9A6D,$02 #REGd=#N$00.
  $9A6F,$04 #REGe=#N$9703.
  $9A73,$01
  $9A7E,$02 #REGa=#N$0C.
  $9A80,$03 Call #R$9B37.
  $9A8A,$03 Call #R$9B0D.
  $9A8E,$03 #REGa=#R$9693.
  $9A91,$02,b$01 Keep only bits 0-1.
  $9A93,$03 Create an offset.
  $9A96,$04 #REGhl=#R$9AB8 + #REGa.

  $9AA2,$13 Writes #N$00 to: #TABLE(default,centre)
. { #REGix+#N$06 }
. { #REGix+#N$07 }
. { #REGix+#N$08 }
. { #REGix+#N$09 }
. { #REGix+#N$0A }
. { #REGix+#N$0B }
. TABLE#
  $9AB5,$03 Jump to #R$B919.

b $9AB8
@ $9AB8 label=ColourBytes
  $9AB8,$04

c $9ABC

c $9AE9
  $9AEC,$02,b$01 Keep bit 0.
  $9AF7,$02 Jump to #R$9B18.

c $9AF9
  $9B03,$02,b$01 Keep bits 0-6.
  $9B0B,$02 Jump to #R$9B23.

c $9B0D
  $9B0D,$03 #REGa=#R$9695.
  $9B10,$02,b$01 Keep bits 0-6.
  $9B18,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $9B1B,$02,b$01 Keep bits 0-6.
  $9B23,$03 #REGa=#R$9703.
  $9B29,$03 #REGbc=#N$1717.
  $9B2C,$03 Call #R$AB01.
  $9B30,$03 #REGbc=#N$1717.
  $9B33,$03 Call #R$B81C.
  $9B36,$01 Return.

c $9B37
  $9B3D,$01 Return.

w $9B3E Jump Table
@ $9B3E label=JumpTable
  $9B3E,$C4,$02

c $9CC6
  $9CC6,$03 #REGde=#N($0000,$04,$04).
  $9CC9,$03 #REGbc=#N$0820.
  $9CCC,$03 #REGhl=#R$96BF.
  $9CDC,$03 #REGa=#R$970D.
  $9CDF,$02 #REGb=#N$04.
  $9CE7,$03 #REGbc=#R$6276.
  $9CEA,$03 #REGhl=#N($0000,$04,$04).
  $9CF9,$02 Jump to #R$9CEE.

  $9D0E,$03 #REGhl=#N$48F8.
  $9D11,$03 #REGde=#R$96B6.
  $9D14,$02 #REGb=#N$01.
  $9D1B,$03 Jump to #R$B5F0.

  $9D20,$03 Jump to #R$B5E4.

c $9D23
  $9D23,$04 #REGc=#REGix+#N$01 (current location).
  $9D2A,$02,b$01 Keep only bits 0-4.
  $9D33,$02,b$01 Keep only bits 3-5.
  $9D35,$02,b$01 Set bits 1-2, 6-7.
  $9D3A,$03 #REGbc=#N$96BF.
  $9D40,$01 Return.

c $9D41
N $9D41 Each block of amulet data is #N$0B bytes long.
  $9D41,$03 #REGde=#N($000B,$04,$04).
  $9D44,$03 #REGhl=#R$97FE.
N $9D47 There are four pieces of the amulet.
  $9D47,$02 #REGb=#N$04.
  $9D49,$01 #REGa.
  $9D51,$01 Store the result in #REGc.
  $9D52,$03 #REGa=#REGix+#N$01 (current location).
  $9D4F,$02,b$01 Keep only bits 0-3.
  $9D55,$02,b$01 Keep only bits 0-3.
  $9D5B,$02,b$01 Keep only bits 4-7.
  $9D61,$02,b$01 Keep only bits 4-7.
  $9D6A,$01 Return.

  $9D6B,$02 Increment #REGhl by two.

  $9D7C,$01 Return.

  $9D90,$01 Return.

c $9D91

c $9E04
  $9E04,$03 Call #R$A5A9.
  $9E07,$02 Jump to #R$9DC3.

c $9E09
  $9E09,$03 Call #R$A5BA.
  $9E0C,$02 Jump to #R$9DC3.

c $9E0E
  $9E15,$02,b$01 Keep only bit 0.
  $9E1C,$02,b$01 Keep only bits 0-2.
  $9E2E,$01 Return.

c $9E2F

c $9E48

c $9E4E

c $9E53
  $9E53,$03 #REGb=#R$9E5C.
  $9E5B,$01 Return.

b $9E5C

c $9E64
  $9E64,$03 #REGa=#R$9695.
  $9E67,$02,b$01 Keep only bits 0-2.
  $9E6D,$02,b$01 Set bits 1-2.
  $9E6F,$02,b$01 Set bit 6.
  $9E71,$01 Return.

c $9E72

c $9F6A Game Complete
@ $9F6A label=GameComplete
  $9F6A,$03 Call #R$BB7C.
  $9F6D,$03 Call #R$BB5C.
  $9F70,$03 #REGhl=#R$C386.
  $9F73,$03 Call #R$BBF7.
  $9F76,$03 #REGde=#R$9F91.
N $9F79 There are six lines of text.
  $9F79,$02 #REGb=#N$06.
  $9F7B,$03 Call #R$A036.
  $9F7E,$03 #REGde=#R$BC67.
  $9F81,$03 Call #R$BD6E.
  $9F84,$03 Call #R$AC28.
  $9F87,$04 Write #N$00 to #R$96BD.
  $9F8B,$03 Call #R$B7CD.
  $9F8E,$03 Jump to #R$AA27.

b $9F91 Congratulations Messaging
D $9F91 #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Attribute | =h Text }
. #FOREACH($9F91,$9F9C,$9FB6,$9FD1,$9FF0,$A003)(n,{ #N(#EVAL(#PEEKn / $08)) | #N(#EVAL(#PEEK(n + $01) / $08)) | #N(#PEEK(n + $02)) | #STR(n + $03) })
. TABLE#
@ $9F91 label=GameComplete_Copy
B $9F91,$02 X / Y position.
B $9F93,$01 Attribute.
T $9F94,$08,$07:$01 "#STR(#PC)".
B $9F9C,$02 X / Y position.
B $9F9E,$01 Attribute.
T $9F9F,$17,$16:$01 "#STR(#PC)".
B $9FB6,$02 X / Y position.
B $9FB8,$01 Attribute.
T $9FB9,$18,$17:$01 "#STR(#PC)".
B $9FD1,$02 X / Y position.
B $9FD3,$01 Attribute.
T $9FD4,$1C,$1B:$01 "#STR(#PC)".
B $9FF0,$02 X / Y position.
B $9FF2,$01 Attribute.
T $9FF3,$10,$0F:$01 "#STR(#PC)".
B $A003,$02 X / Y position.
B $A005,$01 Attribute.
T $A006,$15,$14:$01 "#STR(#PC)".

c $A01B Display Poem
@ $A01B label=DisplayPoem
R $A01B IX Actor Entity
  $A01B,$03 Fetch the current number of amulet pieces which need to be collected.
N $A01E Convert "number of pieces to collect" into "number of pieces collected".
  $A01E,$03 #REGbc=#N$0400 counter = #N$04 (total number of pieces) and initialise #REGc to #N$00.
@ $A021 label=Poem_CollectCollected_Loop
  $A021,$03 The number of amulet pieces which need to be collected is held in bits, so rotate #REGa
.           and if there are no bits to carry over then jump to #R$A025.
@ $A025 label=Poem_CollectCollected_Skip
  $A025,$02 Decrease counter by one and loop back to #R$A021 until counter is zero.
  $A024,$01 Increment #REGc by one.
  $A027,$01 #REGa=#REGc (the number of amulet pieces collected).
N $A028 Check if poem "1" should be displayed.
  $A028,$03 Decrease #REGa by one and jump to #R$A046 if #REGa is now zero.
N $A02B Check if poem "2" should be displayed.
  $A02B,$03 Decrease #REGa by one and jump to #R$A04B if #REGa is now zero.
N $A02E Check if poem "3" should be displayed.
  $A02E,$03 Decrease #REGa by one and jump to #R$A050 if #REGa is now zero.
N $A031 Handles pointing to poem "4".
  $A031,$03 #REGde=#R$A13B.
N $A034 Each poem is four lines of prose.
@ $A034 label=Poem_Start
  $A034,$02 #REGb=#N$04.
@ $A036 label=Poem_Loop
  $A036,$01
  $A037,$04
  $A03B,$01
  $A03C,$01 Stash #REGbc on the stack.
  $A03D,$03 Call #R$B53D.
  $A040,$01 Switch to the shadow registers.
  $A041,$01 Increment #REGde by one.
  $A042,$01 Restore #REGbc from the stack.
  $A043,$02 Decrease counter by one and loop back to #R$A036 until counter is zero.
  $A045,$01 Return.
N $A046 Handles pointing to poem "1".
@ $A046 label=Poem_1_Reference
  $A046,$03 #REGde=#R$A055.
  $A049,$02 Jump to #R$A034.
N $A04B Handles pointing to poem "2".
@ $A04B label=Poem_2_Reference
  $A04B,$03 #REGde=#R$A0A7.
  $A04E,$02 Jump to #R$A034.
N $A050 Handles pointing to poem "3".
@ $A050 label=Poem_3_Reference
  $A050,$03 #REGde=#R$A0F4.
  $A053,$02 Jump to #R$A034.
N $A055 Poem 1. #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Attribute | =h Text }
. #FOREACH($A055,$A071,$A07E,$A097)(n,{ #N(#EVAL(#PEEKn / $08)) | #N(#EVAL(#PEEK(n + $01) / $08)) | #N(#PEEK(n + $02)) | #STR(n + $03) })
. TABLE#
@ $A055 label=Poem_1_Copy
B $A055,$02 X / Y position.
B $A057,$01 Attribute.
T $A058,$19,$18:$01 "#STR(#PC)".
B $A071,$02 X / Y position.
B $A073,$01 Attribute.
T $A074,$0A,$09:$01 "#STR(#PC)".
B $A07E,$02 X / Y position.
B $A080,$01 Attribute.
T $A081,$16,$15:$01 "#STR(#PC)".
B $A097,$02 X / Y position.
B $A099,$01 Attribute.
T $A09A,$0D,$0C:$01 "#STR(#PC)".
N $A0A7 Poem 2. #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Attribute | =h Text }
. #FOREACH($A0A7,$A0C4,$A0CE,$A0E9)(n,{ #N(#EVAL(#PEEKn / $08)) | #N(#EVAL(#PEEK(n + $01) / $08)) | #N(#PEEK(n + $02)) | #STR(n + $03) })
. TABLE#
@ $A0A7 label=Poem_2_Copy
B $A0A7,$02 X / Y position.
B $A0A9,$01 Attribute.
T $A0AA,$1A,$19:$01 "#STR(#PC)".
B $A0C4,$02 X / Y position.
B $A0C6,$01 Attribute.
T $A0C7,$07,$06:$01 "#STR(#PC)".
B $A0CE,$02 X / Y position.
B $A0D0,$01 Attribute.
T $A0D1,$18,$17:$01 "#STR(#PC)".
B $A0E9,$02 X / Y position.
B $A0EB,$01 Attribute.
T $A0EC,$08,$07:$01 "#STR(#PC)".
N $A0F4 Poem 3. #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Attribute | =h Text }
. #FOREACH($A0F4,$A10A,$A116,$A130)(n,{ #N(#EVAL(#PEEKn / $08)) | #N(#EVAL(#PEEK(n + $01) / $08)) | #N(#PEEK(n + $02)) | #STR(n + $03) })
. TABLE#
@ $A0F4 label=Poem_3_Copy
B $A0F4,$02 X / Y position.
B $A0F6,$01 Attribute.
T $A0F7,$13,$12:$01 "#STR(#PC)".
B $A10A,$02 X / Y position.
B $A10C,$01 Attribute.
T $A10D,$09,$08:$01 "#STR(#PC)".
B $A116,$02 X / Y position.
B $A118,$01 Attribute.
T $A119,$17,$16:$01 "#STR(#PC)".
B $A130,$02 X / Y position.
B $A132,$01 Attribute.
T $A133,$08,$07:$01 "#STR(#PC)".
N $A13B Poem 4. #TABLE(default,centre,centre,centre)
. { =h X Position | =h Y Position | =h Attribute | =h Text }
. #FOREACH($A13B,$A158,$A165,$A180)(n,{ #N(#EVAL(#PEEKn / $08)) | #N(#EVAL(#PEEK(n + $01) / $08)) | #N(#PEEK(n + $02)) | #STR(n + $03) })
. TABLE#
@ $A13B label=Poem_4_Copy
B $A13B,$02 X / Y position.
B $A13D,$01 Attribute.
T $A13E,$1A,$19:$01 "#STR(#PC)".
B $A158,$02 X / Y position.
B $A15A,$01 Attribute.
T $A15B,$0A,$09:$01 "#STR(#PC)".
B $A165,$02 X / Y position.
B $A167,$01 Attribute.
T $A168,$18,$17:$01 "#STR(#PC)".
B $A180,$02 X / Y position.
B $A182,$01 Attribute.
T $A183,$09,$08:$01 "#STR(#PC)".

c $A18C

c $A1FF Pause
@ $A1FF label=Pause
  $A1FF,$01 Decrease #REGhl by one.
  $A200,$04 Loop back to #R$A1FF until #REGhl is zero.
  $A204,$02 Decrease counter by one and loop back to #R$A1FF until counter is zero.
  $A206,$01 Return.

c $A207
  $A207,$03 Call #R$BB7C.
  $A20A,$03 Call #R$BB5C.
  $A211,$03 #REGhl=#R$C374.
  $A220,$05 Write #N$01 to #R$96B2.
  $A22D,$03 Call #R$BC0B.
  $A230,$02 Stash #REGhl and #REGbc on the stack.
  $A232,$02 Jump to #R$A214.

c $A234 Handler: Poems
@ $A234 label=HandlerPoems
N $A234 Display the poem copy.
  $A234,$03 Call #R$A01B.
N $A237 Play music.
  $A237,$03 #REGhl=#N($0000,$04,$04).
  $A23A,$03 #REGde=#R$BD33.
  $A23D,$03 Call #R$BD6E.
N $A240 Pause so the player has a chance to read and listen.
  $A240,$02 #REGb=#N$08.
  $A242,$03 Call #R$A1FF.
  $A245,$03 Call #R$AC28.
  $A248,$03 Call #R$BB7C.
  $A24B,$03 Call #R$BB5C.
  $A24E,$03 Call #R$BBDD.
  $A251,$03 Call #R$B919.
  $A254,$01 Return.

c $A255 Place Amulet Pieces
@ $A255 label=PlaceAmuletPieces
  $A255,$04 #REGix=#R$97FE.
  $A259,$03 #REGa=#R$9695.
  $A25C,$02,b$01 Keep only bits 0-2.
  $A25E,$03 Create an offset.
  $A266,$01 #REGhl=#R$A29D + (#REGa * #N$02).
N $A268 There are four pieces of the amulet to collect.
  $A268,$02 #REGb=#N$04.
@ $A26A label=PlaceAmuletPieces_Loop
  $A26A,$01 Stash the counter on the stack.
  $A279,$03 #REGbc=#R$6066.
  $A283,$03 #REGbc=#R$DC6C.
  $A294,$03 #REGbc=#N$000C.
  $A299,$01 Restore the counter from the stack.
  $A29A,$02 Decrease counter by one and loop back to #R$A26A until counter is zero.
  $A29C,$01 Return.
@ $A29D label=Initialisation_Amulet
B $A29D

c $A2BD
  $A2BD,$03 #REGhl=#R$DDEC.
  $A2C0,$04 #HTML(#REGe=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $A2C4,$03 #REGa=#R$9693.
  $A2C7,$02,b$01 Keep only bits 0-4.
  $A2C9,$01 Store the result in #REGd.

b $A3A7

c $A3B7

c $A3C5

c $A3E0
  $A3E0,$03 #REGa=#R$9703.
  $A3E9,$03 Call #R$BB0B.
  $A3EC,$03 #REGa=#R$970D.
  $A3EF,$02 #REGc=#N$00.
  $A3F1,$02 #REGb=#N$4.
  $A3FF,$03 #REGa=#R$9693.
  $A402,$02,b$01 Keep only bits 0-3.
  $A407,$02,b$01 Keep only bits 0-2.
  $A409,$03 Create an offset.
  $A40C,$04 #REGhl=#R$A41A + offset.
  $A414,$03 Call #R$A5CD.
  $A417,$03 Jump to #R$AD5D.

b $A41A
@ $A41A label=SpriteReference
  $A41A,$01 #LET(result=$BF84 + (#PEEK(#PC) * $02)) Sprite ID: #R(#PEEK({result}) + #PEEK({result} + $01) * $100)(#N(#PEEK(#PC))) #SPRITENAME(#PEEK(#PC))
L $A41A,$01,$10

c $A42A

c $A43B

c $A44B

c $A493
  $A4A0,$01 Return.

c $A4A1
  $A4A1,$05 Write #N$10 to #R$96B4.
  $A4A6,$03 Call #R$BEEE.
  $A4A9,$03 Call #R$A4B3.
  $A4B0,$03 Jump to #R$AD5D.

c $A4B3
  $A4B9,$02,b$01 Keep only bits 4-5.
  $A4BE,$02 #REGb=#N$01.
  $A4C0,$03 Jump to #R$B5A9.

c $A4C3
  $A4C8,$02,b$01 Keep only bit 1.
  $A4CE,$02,b$01 Keep only bits 0, 2-7.
  $A4D6,$01 Return.

c $A4D7

c $A545
  $A545,$03 Call #R$A5A9.
  $A548,$02 Jump to #R$A52D.

c $A54A
  $A54A,$03 Call #R$A5BA.
  $A54D,$02 Jump to #R$A52D.

c $A54F
  $A558,$05 Write #N$17 to #R$96AD.
  $A55D,$03 Call #R$BB0B.
  $A578,$03 Call #R$A44B.
  $A583,$03 #REGbc=#N$1717.
  $A586,$03 Call #R$B81C.
  $A589,$03 Call #R$AAED.
  $A59D,$03 #REGbc=#N$1313.
  $A5A0,$03 Call #R$AB36.
  $A5A6,$03 Jump to #R$A4A6.

c $A5A9
  $A5B9,$01 Return.

c $A5BA
  $A5C2,$01 Return.

c $A5C3
  $A5C3,$03 Call #R$A5A9.
  $A5C6,$02 Jump to #R$A583.

c $A5C8
  $A5C8,$03 Call #R$A5BA.
  $A5CB,$02 Jump to #R$A583.

c $A5CD
  $A5D8,$02,b$01 Keep only bits 0-2.
  $A5DD,$03 #REGbc=#R$A601.
  $A5F0,$02,b$01 Keep only bits 0-2.
  $A5FA,$01 Return.

N $A5FB
  $A5FF,$02 Jump to #R$A5ED.
B $A601,$08

c $A609
  $A609,$07 Write #N$00 to #REGix+#N$06 and #REGix+#N$07.
  $A610,$03 #REGa=#R$9695.
  $A613,$02,b$01 Keep only bits 0-2.
  $A615,$02,b$01 Set bit 3.
  $A617,$03 Write the result to #REGix+#N$02.
  $A61A,$01 Return.

c $A61B
  $A61B,$03 Call #R$BB0B.
  $A61E,$03 Call #R$AE7A.
  $A623,$03 #REGa=#REGix+#N$00 (sprite reference).
  $A626,$02,b$01 Keep only bits 0-2.
  $A628,$02,b$01 Set bit 4.
  $A62A,$03 Write the result to #REGix+#N$00 (sprite reference).
  $A62D,$03 Jump to #R$AF7A.

c $A630
  $A63C,$02,b$01 Keep only bits 0-4.

c $A678
  $A678,$03 #REGa=#REGb+#N$10.
  $A67B,$02 Jump to #R$A65B.

c $A67D
  $A67D,$01 #REGa=#REGb.
  $A67E,$02 Jump to #R$A65D.

c $A680
  $A680,$03 Call #R$BB0B.
  $A6A3,$03 Call #R$A737.
  $A6A6,$03 Call #R$B9A9.

  $A6AF,$03 Call #R$B8DD.
  $A6B2,$02 #REGc=#N$01.
  $A6B4,$02 #REGd=#N$44.
  $A6B6,$02 #REGb=#N$02.
  $A6B8,$03 Call #R$A6C8.

  $A6BE,$02,b$01 Keep only bits 0-2.
  $A6C1,$02 #REGc=#N$01.
  $A6C6,$02 #REGb=#N$02.
  $A6CC,$02,b$01 Keep only bits 0-2.
  $A6D1,$03 Jump to #R$BB45.

c $A6D4
  $A6D4,$03 #REGa=#R$9693.
  $A6E7,$02,b$01 Keep only bits 0-2.
  $A6EE,$02,b$01 Keep only bits 0-3.
  $A6F3,$03 #REGbc=#R$A6FD.
  $A6FB,$02 Jump to #R$A71A.

b $A6FD
@ $A6FD label=OrchidColour

c $A70D
  $A714,$02,b$01 Keep only bits 0-2.
  $A718,$02 Jump to #R$A6A6.

  $A71A,$03 #REGa=#REGix+#N$02.
  $A724,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $A727,$02,b$01 Keep only bits 0-5.
  $A72E,$03 Jump to #R$A69D.
  $A731,$03 #REGhl=#N($0010,$04,$04).
  $A734,$03 Jump to #R$A69D.

c $A737
  $A73B,$02,b$01 Keep only bits 0-2.
  $A73E,$03 #REGbc=#N$0F0F.
  $A741,$03 Call #R$AB01.
  $A745,$05 Write #N$C0 to #R$96B0.
  $A75C,$04 Write #N$00 to #R$96B0.
  $A760,$03 Jump to #R$BF2A.

c $A763
R $A763 IX Actor Entity
  $A763,$03 #REGa=#REGix+#N$01 (current location).
  $A766,$03 Call #R$A7E8.
  $A769,$03 #REGde=#R$97DA.
  $A76C,$03 #REGbc=the orchid type from #REGhl.
  $A76F,$01 #REGa=#REGc.
  $A770,$02,b$01 Keep only bits 0-2.
  $A772,$02,b$01 Set bits 3 and 6.
  $A77C,$02,b$01 Keep only bit 3.
  $A780,$03 Call #R$A7D4.
  $A78B,$02,b$01 Keep only bits 0-2.
  $A78D,$02,b$01 Set bit 6.
  $A792,$02,b$01 Keep only bits 3-7.
  $A79B,$02,b$01 Keep only bits 0-3.
  $A79E,$01 Return.

c $A79F
  $A79F,$03 #REGa=#R$96AB.
  $A7A2,$03 Call #R$A7E8.
  $A7A7,$04 #REGix=#R$97DA.
  $A7AE,$02,b$01 Keep only bits 0-2.
  $A7B4,$02,b$01 Keep only bit 3.
  $A7BF,$02,b$01 Keep only bits 4-7.
  $A7C7,$02,b$01 Keep only bits 0-2.
  $A7CD,$02,b$01 Keep only bits 3-7.
  $A7D3,$01 Return.

c $A7D4 Handler: Orchid Position
@ $A7D4 label=HandlerOrchidPosition
R $A7D4 IX Actor Entity
R $A7D4 O:HL Pointer to Orchid Position
  $A7D4,$01 Stash #REGbc on the stack.
N $A7D5 Fetch the Room ID from the layout map.
  $A7D5,$05 Create an offset with #REGix+#N$01 (current location).
  $A7DA,$04 #REGhl=#R$6066 + offset.
N $A7DE Fetch the orchid position from the orchid position table.
  $A7DE,$03 Create an offset.
  $A7E1,$05 #REGhl=#R$D6A6 + (offset * #N$02).
  $A7E6,$01 Restore #REGbc from the stack.
  $A7E7,$01 Return.

c $A7E8 Handler: Orchid Type
@ $A7E8 label=HandlerOrchidType
R $A7E8 A Location ID
R $A7E8 O:HL Pointer to Orchid Type
N $A7E8 Fetch the Room ID from the layout map.
  $A7E8,$03 Create an offset.
  $A7EB,$04 #REGhl=#R$6066 + #REGa.
N $A7EF Fetch the orchid type from the orchid type table.
  $A7EF,$03 Create an offset using the room ID.
  $A7F2,$05 #REGhl=#R$A7F8 + (offset * #N$02).
  $A7F7,$01 Return.

b $A7F8 Table: Orchid Types
@ $A7F8 label=TableOrchidTypes
  $A7F8,$60,$02

c $A858
  $A858,$03 Call #R$BB0B.
  $A85B,$05 Write #N$20 to #R$96AD.
  $A860,$03 Call #R$AC0E.
  $A863,$03 Call #R$A922.
  $A866,$03 Call #R$A8B2.
  $A869,$03 Call #R$AFE8.
  $A86C,$03 #REGbc=#N$171F.
  $A86F,$03 Call #R$B81C.
  $A872,$03 Call #R$AAED.
  $A877,$03 Call #R$ADB3.

  $A892,$03 Call #R$AB01.

  $A89D,$02,b$01 Keep only bit 0.

  $A8AC,$03 Call #R$ADB3.
  $A8AF,$03 Jump to #R$AD46.

c $A8B2
  $A8BC,$02,b$01 Keep only bits 4-7.
  $A8D8,$02,b$01 Keep only bits 2-7.
  $A8DA,$02,b$01 Set bit 3.
  $A8E3,$01 Return.

c $A8E4
  $A8F3,$02 Jump to #R$A8D5.

c $A8F5
  $A8F5,$03 Call #R$BB0B.
  $A90A,$02,b$01 Keep only bit 2.
  $A91F,$03 Jump to #R$A880.

c $A922
  $A925,$02,b$01 Keep only bits 4-7.
  $A92B,$02,b$01 Keep only bits 4-7.

  $A934,$01 Return.

  $A950,$01 Return.

c $A951
  $A959,$01 Return.

c $A95A
  $A962,$02 Jump to #R$A951.

c $A964
  $A964,$03 Call #R$BB0B.
  $A982,$03 Jump to #R$A869.

c $A985
  $A99D,$03 Jump to #R$AD5D.

c $A9A0
  $A9A8,$03 Jump to #R$AD5D.

c $A9AB
  $A9BB,$03 Jump to #R$AD5D.

c $A9BE
  $A9BE,$03 Call #R$BB0B.

  $A9CF,$03 #REGbc=#N$170F.
  $A9D2,$03 Call #R$B81C.
  $A9D5,$03 Call #R$AAED.

  $A9F2,$03 Call #R$AD5D.

  $A9FB,$02 #REGc=#N$04.
  $A9FD,$03 Jump to #R$BF6D.

c $AA00
  $AA07,$03 Call #R$AD5D.
  $AA0A,$03 Jump to #R$BF2F.

c $AA0D
  $AA0D,$03 Call #R$BB0B.
  $AA25,$02 Jump to #R$AA57.

c $AA27
N $AA27 Is this a one or two player game?
  $AA27,$03 #REGa=#R$9692.
  $AA2A,$02,b$01 Keep only bit 0.
  $AA2C,$02 Jump to #R$AA5A if this is a two player game.
N $AA2E This is a one player game.
  $AA2E,$06 If #R$96BD is zero then jump to #R$AAA4.
  $AA34,$03 #REGhl=#R$96BD.

  $AA38,$03 Call #R$B7CD.
  $AA3E,$02,b$01 Keep only bits 0-2.
  $AA40,$02,b$01 Set bit 4.

  $AA49,$04 Write #N$00 to #R$96B0.
  $AA4D,$05 Write #N$10 to #R$96B1.
  $AA52,$05 Write #N$80 to #R$96B4.

  $AA57,$03 Jump to #R$AD5D.

N $AA5A This is a two player game.
  $AA5A,$06 If #R$96E0 is zero then jump to #R$AA2E.

  $AA67,$03 Jump to #R$B205.

c $AA6A Game Over
@ $AA6A label=GameOver_1UP
N $AA6A #HTML(Set up altering the "GAME OVER PLAYER <em>X</em>" message for 1UP.)
  $AA6A,c,$02 #REGa="1" + #N$80 (escape character).
N $AA6C Print the messaging and pause to show it for a period of time.
@ $AA6C label=GameOver_Write
  $AA6C,$03 Write ASCII player number to #R$AAC1(#N$AAD3)(GameOver_Text).
  $AA6F,$03 Call #R$BB7C.
  $AA72,$03 Call #R$BB5C.
  $AA75,$03 #REGde=#R$AAD4.
  $AA78,$03 #REGhl=#N$7820.
  $AA7B,$03 Call #R$B53D.
  $AA7E,$03 #REGde=#R$AAC1.
  $AA81,$03 #REGhl=#N$6038.
  $AA84,$03 Call #R$B53D.
  $AA87,$03 Call #R$9CC6.
  $AA8A,$03 #REGde=#R$BD28.
  $AA8D,$03 Call #R$BD6E.
N $AA90 Introduce a pause by counting down from #N$10000 twice.
  $AA90,$02 #REGb=#N$02 (counter).
  $AA92,$03 #REGhl=#N$0000 (large counter).
  $AA95,$03 Call #R$A1FF.
N $AA98 #HTML(Set up altering the "GAME OVER PLAYER <em>X</em>" message for 2UP.)
@ $AA98 label=GameOver_2UP
  $AA98,c,$02 #REGa="2" + #N$80 (escape character).
  $AA9A,$02 Jump to #R$AA6C.

N $AA9C This controller simply returns on end. This is for when the game continues after the messaging.
@ $AA9C label=GameOver_Controller
  $AA9C,$06 If #R$969E is zero, jump to #R$AA6A.
  $AAA2,$02 Else, jump to #R$AA98.

N $AAA4 This is a controller with a jump to #R$998F to return to the game selection screen.
@ $AAA4 label=GameOver_ControllerRestart
  $AAA4,$06 If #R$969E is not zero, jump to #R$AABC.
  $AAAA,$03 Call #R$AA6A.
  $AAAD,$03 Call #R$B5FC.
  $AAB0,$06 If #R$96BA is not zero, jump to #R$AAB9.
  $AAB6,$03 Call #R$B27E.
@ $AAB9 label=GameOver_Restart
  $AAB9,$03 Jump to #R$998F.
@ $AABC label=GameOver_Restart2UP
  $AABC,$03 Call #R$AA98.
  $AABF,$02 Jump to #R$AAAD.

b $AAC1 Game Over Messaging
D $AAC1 This message is altered directly to change from "1" to "2" for the correct player.
.       See #R$AA6A and #R$AA98.
@ $AAC1 label=GameOver_Text
  $AAC1,$01 Attribute: #N(#PEEK(#PC)).
T $AAC2,$12,$11:$01 #HTML("GAME OVER PLAYER <em>X</em>".)

b $AAD4 Adventure Completed Messaging
@ $AAD4 label=AdventureCompleted_Text
  $AAD4,$01 Attribute: #N(#PEEK(#PC)).
T $AAD5,$18,$17:$01 "#STR(#PC)".

c $AAED

b $AC24

c $AC28
  $AC28,$01 Enable interrupts.
  $AC29,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SPACE | FULL-STOP | M | N | B | Shift | Z | X | C | V }
. TABLE#
  $AC32,$01 Flip the bits.
  $AC33,$02,b$01 Keep only bits 1-4.
  $AC36,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SPACE | FULL-STOP | M | N | B | Shift | Z | X | C | V }
. TABLE#

  $AC40,$04 #HTML(#REGhl=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)

  $AC4D,$02,b$01 Keep only bit 1.
  $AC4F,$02,b$01

  $AC53,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SPACE | FULL-STOP | M | N | B | Shift | Z | X | C | V }
. TABLE#

  $AC5D,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SPACE | FULL-STOP | M | N | B | Shift | Z | X | C | V }
. TABLE#

  $AC6A,$01 Return.

  $AC6B,$0B Copy #N$0090 bytes of data from #R$AC77 to #R$9702.
  $AC76,$01 Return.

b $AC77

c $AD07

c $ADBD

c $ADBF
  $ADC3,$02,b$01 Keep only bits 0-3.
  $ADC5,$02,b$01 Set bit 5.
  $ADCA,$05 Write #N$18 to #R$96AD.
  $ADCF,$01 Return.

c $ADD0
  $ADD0,$03 Call #R$BB0B.
  $ADD3,$03 Call #R$A18C.

  $ADE2,$03 #REGde=#N($0000,$04,$04).
  $ADE5,$03 Call #R$B0A3.

  $AE19,$03 Call #R$AFE8.
  $AE1C,$03 #REGbc=#N$160E.
  $AE1F,$03 Call #R$B81C.
  $AE22,$03 Call #R$AE4B.
  $AE25,$03 Call #R$AAED.

  $AE31,$03 Jump to #R$AD5D.

c $AE34
  $AE44,$03 Jump to #R$AF1C.

c $AE47
  $AE47,$02 #REGa=#N$10.
  $AE49,$02 Jump to #R$AE3C.

c $AE4B
  $AE72,$01 Return.
  $AE76,$02,b$01 Keep only bits 0-2, 4-7.
  $AE78,$02 Jump to #R$AE59.

c $AE7A

c $AE8F

c $AEA1
  $AEBC,$01 Return.

c $AEBD

c $AECA

c $AECF

c $AEEA

c $AEEF

c $AFC1

c $AFE0
  $AFE0,$02 #REGb=#N$20.
  $AFE2,$02 Jump to #R$AFCF.

c $AFE4
  $AFE4,$02 #REGb=#N$40.
  $AFE6,$02 Jump to #R$AFCF.

c $AFE8
  $AFF4,$03 Call #R$B031.

  $B009,$03 Call #R$B031.

  $B019,$01 Return.

c $B01A
  $B025,$02 Jump to #R$B006.

c $B027
  $B030,$01 Return.

c $B031
  $B03F,$01 Return.
  $B046,$01 Return.

c $B047
  $B04E,$01 Return.
  $B052,$01 Return.

c $B053
  $B053,$03 Call #R$B078.
  $B077,$01 Return.

c $B078
  $B098,$01 Return.

c $B099
  $B099,$02,b$01 Keep only bits 0-1, 4-7.
  $B09B,$02,b$01 Set bit 3.
  $B09D,$02 Jump to #R$B063.

c $B09F
  $B09F,$02,b$01 Keep only bits 0-1, 4-7.
  $B0A1,$02 Jump to #R$B074.

c $B0A3 Handler: Controls
E $B0A3 Else, handle Interface II joystick - it's the only option left.
E $B0A3 Continue on to #R$B0B1.
@ $B0A3 label=HandlerControls
  $B0A3,$03 #REGa=#R$9692.
  $B0A6,$01 Shift off the keyboard option.
  $B0A7,$02,b$01 Keep only bits 0-1 (Kempston and Cursor joystick options).
  $B0A9,$02 If there are no joystick options, then keyboard was selected - so jump to #R$B0FA.
  $B0AB,$03 If bit 0 was on then Kempston joystick was selected - so jump to #R$B0D9.
  $B0AE,$03 If bit 1 was on then Cursor joystick was selected - so jump to #R$B103.

c $B0B1 Controls: Interface II Joystick
@ $B0B1 label=ReadInterfaceIIJoystick
R $B0B1 O:A Joystick controls
R $B0B1 O:C Joystick controls
N $B0B1 Initialise the controls as "none" in #REGc.
  $B0B1,$02 #REGc=#N$00.
  $B0B3,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
N $B0B9 Check joystick "FIRE".
@ $B0B9 label=ReadInterfaceIIJoystick_Fire
  $B0B9,$02 Has key "0" been pressed?
  $B0BB,$02 If not jump to #R$B0BF.
  $B0BD,$02 Set bit 4 of #REGc.
N $B0BF Check joystick "UP".
@ $B0BF label=ReadInterfaceIIJoystick_Up
  $B0BF,$02 Has key "9" been pressed?
  $B0C1,$02 If not jump to #R$B0C5.
  $B0C3,$02 Set bit 2 of #REGc.
N $B0C5 Check joystick "DOWN".
@ $B0C5 label=ReadInterfaceIIJoystick_Down
  $B0C5,$02 Has key "8" been pressed?
  $B0C7,$02 If not jump to #R$B0CB.
  $B0C9,$02 Set bit 3 of #REGc.
N $B0CB Check joystick "RIGHT".
@ $B0CB label=ReadInterfaceIIJoystick_Right
  $B0CB,$02 Has key "7" been pressed?
  $B0CD,$02 If not jump to #R$B0C5.
  $B0CF,$02 Set bit 1 of #REGc.
N $B0D1 Check joystick "LEFT".
@ $B0D1 label=ReadInterfaceIIJoystick_Left
  $B0D1,$02 Has key "6" been pressed?
  $B0D3,$02 If not jump to #R$B0D7.
  $B0D5,$02 Set bit 0 of #REGc.
@ $B0D7 label=HandlerInterfaceIIJoystick
  $B0D7,$01 #REGa=controls.
  $B0D8,$01 Return.

c $B0D9 Controls: Kempston Joystick
@ $B0D9 label=ReadKempstonJoystick
R $B0D9 O:A Joystick controls
R $B0D9 O:C Joystick controls
  $B0D9,$02 #REGa=controls.
N $B0DB Initialise the controls as "none" in #REGc.
  $B0DB,$02 #REGc=#N$00.
N $B0DD Check joystick "RIGHT".
@ $B0DD label=ReadKempstonJoystick_Right
  $B0DD,$02 If bit 0 is set/ "RIGHT" is NOT being pressed then jump to #R$B0E3.
  $B0DF,$02 If not jump to #R$B0E3.
  $B0E1,$02 Set bit 1 of #REGc.
N $B0E3 Check joystick "LEFT".
@ $B0E3 label=ReadKempstonJoystick_Left
  $B0E3,$02 If bit 1 is set/ "LEFT" is NOT being pressed then jump to #R$B0E9.
  $B0E5,$02 If not jump to #R$B0E9.
  $B0E7,$02 Set bit 0 of #REGc.
N $B0E9 Check joystick "DOWN".
@ $B0E9 label=ReadKempstonJoystick_Down
  $B0E9,$02 If bit 2 is set/ "DOWN" is NOT being pressed then jump to #R$B0EF.
  $B0EB,$02 If not jump to #R$B0EF.
  $B0ED,$02 Set bit 3 of #REGc.
N $B0EF Check joystick "UP".
@ $B0EF label=ReadKempstonJoystick_Up
  $B0EF,$02 If bit 3 is set/ "UP" is NOT being pressed then jump to #R$B0F5.
  $B0F1,$02 If not jump to #R$B0F5.
  $B0F3,$02 Set bit 2 of #REGc.
N $B0F5 Check joystick "FIRE".
@ $B0F5 label=ReadKempstonJoystick_Fire
  $B0F5,$02,b$01 Keep only bit 4.
  $B0F7,$02 Merge the kept bit into #REGc.
  $B0F9,$01 Return.

c $B0FA Controls: Keyboard
@ $B0FA label=ReadKeyboard
R $B0FA O:A Joystick controls
R $B0FA O:C Keyboard controls
  $B0FA,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FB | Q | W | E | R | T }
. TABLE#
  $B100,$01 Flip the bits.
  $B101,$01 #REGc=#REGa.
  $B102,$01 Return.

c $B103 Controls: Cursor Joystick
@ $B103 label=ReadCursorJoystick
R $B103 O:A Joystick controls
R $B103 O:C Joystick controls
N $B103 Initialise the controls as "none" in #REGc.
  $B103,$02 #REGc=#N$00.
N $B105 The cusor keys are covered by different ports.
@ $B105 label=HandleCursorJoystick_Port_F7
  $B105,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
N $B10B Check joystick "LEFT".
@ $B10B label=ReadCursorJoystick_Left
  $B10B,$02 Has key "5" been pressed?
  $B10D,$02 If not jump to #R$B111.
  $B10F,$02 Set bit 0 of #REGc.
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
  $B117,$02 Has key "6" been pressed?
  $B119,$02 If not jump to #R$B11D.
  $B11B,$02 Set bit 3 of #REGc.
N $B11D Check joystick "UP".
@ $B11D label=ReadCursorJoystick_Up
  $B11D,$02 Has key "7" been pressed?
  $B11F,$02 If not jump to #R$B123.
  $B121,$02 Set bit 2 of #REGc.
N $B123 Check joystick "RIGHT".
@ $B123 label=ReadCursorJoystick_Right
  $B123,$02 Has key "8" been pressed?
  $B125,$02 If not jump to #R$B129.
  $B127,$02 Set bit 1 of #REGc.
N $B129 Check joystick "FIRE".
@ $B129 label=ReadCursorJoystick_Fire
  $B129,$02 Has key "0" been pressed?
  $B12B,$01 If not then return.
  $B12C,$02 Set bit 4 of #REGc.
  $B12E,$01 Return.

c $B12F
  $B12F,$02 #REGd=#N$27.
  $B139,$03 Create an offset.
  $B13C,$04 #REGbc=#R$6066 + offset.
  $B150,$01 Stash #REGde on the stack.
  $B151,$03 Call #R$BB7C.
  $B154,$03 Call #R$BB5C.
  $B157,$03 Call #R$BBDD.
  $B15A,$03 Call #R$BB0B.
  $B15D,$03 Call #R$B919.
  $B160,$03 Call #R$9D23.
  $B163,$01 Restore #REGde from the stack.
  $B164,$05 Write #N$80 to #R$96B4.
  $B169,$01 Return.

c $B16A

c $B187

c $B1B7
  $B1B7,$03 #REGhl=#R$9702.
  $B1BA,$05 Write #N$10 to #R$96B1.
  $B1BF,$05 Write #N$80 to #R$96B4.
  $B1C4,$05 Write #N$80 to #R$96B5.
  $B1C9,$04 Write #N$00 to #R$96B0.
  $B1CD,$03 #REGhl=#R$96BD.
  $B1D0,$01 Decrease the lives value held at the memory location in #REGhl.
  $B1D1,$03 Jump to #R$B7CD.

c $B1D4
N $B1D4 Initialise player 2.
  $B1D4,$03 Call #R$B21E.
  $B1D7,$03 Call #R$B235.
N $B1DA Initialise player 1.
  $B1DA,$03 Call #R$B21E.
N $B1DD Always start on player 1.
  $B1DD,$04 Write #N$00 to #R$969E.
  $B1E1,$03 Call #R$BB7C.
  $B1E4,$03 Call #R$BB5C.
  $B1E7,$03 #REGa=#R$9692.
  $B1EA,$02,b$01 Keep only bit 0.
  $B1EC,$02 Jump to #R$B1F1 if this is a two player game.
  $B1EE,$03 Write #REGa to #R$96E0.
  $B1F1,$03 Call #R$B1B7.
  $B1F4,$04 #REGix=#R$9702.
  $B1F8,$03 Call #R$9D23.
  $B1FB,$03 Call #R$A763.
  $B1FE,$03 Call #R$A33B.
  $B201,$03 Call #R$BBDD.
  $B204,$01 Return.

c $B205
  $B205,$03 Call #R$B235.
  $B208,$03 Call #R$BB7C.
  $B20B,$03 Call #R$BB5C.
  $B211,$02,b$01 Keep only bits 0-2.
  $B213,$02,b$01 Set bit 4.
  $B21C,$02 Jump to #R$B1F1.

c $B21E
N $B21E Set starting lives.
  $B21E,$05 Write #N$05 to #R$96BD.
  $B223,$05 Write #N$03 to #R$96BE.
  $B228,$04 Write #N$00 to #R$96BC.
  $B22C,$03 Call #R$AC6B.
  $B22F,$03 Call #R$A255.
  $B232,$03 Jump to #R$A2BD.

c $B235 1UP/ 2UP Swapper 
E $B235 View the equivalent code in;
. #LIST
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$613B }
. { #TRANZAM$0000 }
. LIST#
@ $B235 label=ChangePlayer
N $B235 This routine "swaps" the data between #REGde and #REGhl.
  $B235,$03 #REGa=#R$969E.
  $B238,$01 Flip the bits.
  $B239,$03 Write this back to #R$969E.
N $B23C These are all the player states.
  $B23C,$03 #REGhl=#R$96BC
  $B23F,$03 #REGde=#R$96DF.
  $B242,$03 #REGbc=#N$0023 (counter).
  $B245,$03 Call #R$B25D.
N $B248 This is the current "map".
  $B248,$03 #REGhl=#R$DDEC.
  $B24B,$03 #REGde=#R$DFEC.
  $B24E,$03 #REGbc=#N$0200 (counter).
  $B251,$03 Call #R$B25D.
N $B254 And this is the active sprites.
  $B254,$03 #REGhl=#R$9702.
  $B257,$03 #REGde=#R$982E.
  $B25A,$03 #REGbc=#N$012C (counter).
N $B25D This looks complicated but it's just grabbing the data from #REGde, grabbing the data from #REGhl, and writing the others data to each one.
@ $B25D label=ChangePlayer_Loop
  $B25D,$01 Fetch a byte from #REGde and store it in #REGa.
  $B25E,$01 Switch to the shadow #REGaf register.
  $B25F,$02 Copy a byte from #REGhl and write it to #REGde.
  $B261,$01 Switch back to the normal #REGaf register.
  $B262,$01 Write the byte held in #REGa (orginally from #REGde) into #REGhl.
  $B263,$01 Increment #REGde by one.
  $B264,$01 Increment #REGhl by one.
  $B265,$01 Decrease #REGc by one.
  $B266,$04 Loop back to #R$B25D until the counter in #REGbc is zero.
  $B26A,$01 Return.

c $B26B Initialise Hall Of Fame Counter
@ $B26B label=InitialiseCounterHallOfFame
  $B26B,$06 Write #N$0300 to #R$96B8.
  $B271,$01 Return.

c $B272 Handler: Hall Of Fame
@ $B272 label=HandlerHallOfFame
  $B274,$07 Decrease #R$96B8 by one.
  $B27B,$03 Return unless #R$96B8 is zero.
  $B27E,$03 Call #R$B29F.
  $B281,$02 #REGb=#N$0C.
  $B283,$03 #REGhl=#N$0000.
  $B28B,$01 Flip the bits.
  $B28C,$02,b$01 Keep only bits 0-4.
  $B297,$03 Call #R$B2D8.
  $B29A,$03 Call #R$B473.
  $B29D,$02 Jump to #R$B26B.

c $B29F Hall Of Fame
@ $B29F label=HallOfFame
  $B29F,$03 Call #R$B2D8.
  $B2A2,$03 #REGde=#R$B32E.
  $B2A5,$01 Switch to the shadow registers.
  $B2A6,$03 #REGhl'=#R$B336.
  $B2A9,$03 #REGde'=#R$B346.
N $B2AC There are eight lines of text.
  $B2AC,$02 #REGb'=#N$08.
  $B2AE,$03 Call #R$B47F.
  $B2B1,$03 #REGbc=#N$0306.
  $B2B4,$03 #REGde=#R$B304.
  $B2B7,$03 #REGhl=#N$4868.

  $B2BC,$03 Call #R$B8AD.
  $B2BF,$03 Call #R$B5E4.
  $B2C2,$02 #REGb=#N$03.
  $B2C9,$03 Call #R$B589.

  $B2D7,$01 Return.

@ $B2D8 label=HallOfFame_Clear
  $B2D8,$03 #REGhl=#N$58A4.
  $B2DB,$03 #REGbc=#N$1810.
  $B2DE,$03 #REGde=#N$0020.
  $B2E1

  $B2EE,$03 #REGhl=#N$40A4.
  $B2F1,$03 #REGbc=#N$1880.

  $B303,$01 Return.

g $B304 High Scores
E $B304 View the equivalent code in;
. #LIST
. { #JETPAC$5CF0 }
. { #LUNARJETMAN$5E06 }
. { #PSSST$5E00 }
. { #TRANZAM$5E49 }
. LIST#
D $B304 Each high score slot uses 3-bytes for the score with the players initials.
D $B304 Most other Ultimate games only hold the high score.
N $B304 Top score.
@ $B304 label=Top_HighScore_1
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

t $B346 Hall Of Fame Screen Text
@ $B346 label=HallOfFame_Text
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
  $B3D5,$05 Write #N$FF to #R$96B7.
  $B3DA,$03 Call #R$BB7C.
  $B3DD,$03 Call #R$BB5C.
  $B3E0,$03 #REGhl=#R$61C6.
  $B3E3,$03 Call #R$BBF7.
  $B3E6,$03 Call #R$B473.
  $B3E9,$03 Call #R$B43E.
  $B3EC,$03 #REGhl=#R$BC67.
  $B3EF,$03 Call #R$BD51.
  $B3F2,$03 Call #R$B473.
  $B3F5,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $B3FB,$01 Flip the bits.
  $B3FC,$01 Store the result in #REGe.
  $B3FD,$03 #REGa=#R$9692.
N $B400 Handle 1UP game selection.
@ $B400 label=GameSelect_Check1UP
  $B400,$02 Has key "1" been pressed? ("1 PLAYER GAME").
  $B402,$02 If not jump to #R$B406.
  $B404,$02 Reset bit 0.
N $B406 Handle 2UP game selection.
@ $B406 label=GameSelect_Check2UP
  $B406,$02 Has key "2" been pressed? ("2 PLAYER GAME").
  $B408,$02 If not jump to #R$B40C.
  $B40A,$02 Set bit 0.
N $B40C Handle Keyboard selection.
@ $B40C label=GameSelect_CheckKeyboard
  $B40C,$02 Has key "3" been pressed? ("KEYBOARD").
  $B40E,$02 If not jump to #R$B412.
  $B410,$02,b$01 Keep only bits 0, 3-7.
N $B412 Handle Kempston Joystick selection.
@ $B412 label=GameSelect_CheckKempston
  $B412,$02 Has key "4" been pressed? ("KEMPSTON JOYSTICK").
  $B414,$02 If not jump to #R$B41A.
  $B416,$02,b$01 Keep only bits 0, 3-7.
  $B418,$02,b$01 Set control method = #N$02.
N $B41A Handle Cursor Joystick selection.
@ $B41A label=GameSelect_CheckCursor
  $B41A,$02 Has key "3" been pressed? ("CURSOR JOYSTICK").
  $B41C,$02 If not jump to #R$B422.
  $B41E,$02,b$01 Keep only bits 0, 3-7.
  $B420,$02,b$01 Set control method = #N$04.
  $B422,$01 Temporarily store #REGa (#R$9692) in #REGc.
  $B423,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $B429,$01 Flip the bits.
  $B42A,$01 Store the result in #REGe.
  $B42B,$01 Restore the previous game options value to #REGa.
N $B42C Handle Interface II Joystick selection.
@ $B42C label=GameSelect_CheckInterface2
  $B42C,$02 Has key "6" been pressed? ("INTERFACE II").
  $B42E,$02 If not jump to #R$B432.
  $B430,$02,b$01 Set control method = #N$06.
  $B432,$03 Write #REGa to #R$9692.
N $B435 Handle starting a new game.
@ $B435 label=GameSelect_Start
  $B435,$02 Has key "0" been pressed? ("START GAME").
  $B437,$01 If so, return.
  $B438,$03 Call #R$B43E.
  $B43B,$03 Jump to #R$B3F2.
@ $B43E label=HallOfFameCheck
  $B43E,$03 #REGhl=#R$96B7.
  $B441,$03 #REGa=#R$9692.
  $B445,$03 Write #REGa to #R$96B7.
  $B448,$03 Call #R$B272.
N $B44B Handle flashing each selection.
  $B44B,$03 #REGhl=#R$B498.
  $B44E,$03 #REGa=#R$9692.
  $B451,$01 Temporarily store #REGa (#R$9692) in #REGc.
N $B452 There are two player options to choose from (1UP or 2UP game).
  $B452,$02 #REGb=#N$02.
  $B454,$02,b$01 Keep only bit 0 (the player options).
  $B456,$03 Call #R$B463.
  $B459,$01 Restore the previous game options value to #REGa.
  $B45A,$01 Shift off the 1UP/ 2UP player options.
  $B45B,$02,b$01 Keep only bits 0-1 (the control options).
N $B45D There are four control methods to choose from.
  $B45D,$02 #REGb=#N$04 (counter).
  $B45F,$03 Call #R$B463.
  $B462,$01 Return.
N $B463 Selection flashing routine.
@ $B463 label=HandlerMenuAttributeFlash
  $B463,$03 Jump to #R$B46D if #REGa is zero.
@ $B466 label=MenuAttributeSet
  $B466,$02 Set the FLASH attribute for the current selection.
  $B468,$02 Jump to #R$B46F, we're done here.
@ $B46A label=HandlerMenuAttributeFlash_Loop
  $B46A,$01 Decrease #REGa by one.
  $B46B,$02 Jump to #R$B466 if #REGa is zero.
@ $B46D label=MenuAttributeUnset
  $B46D,$02 Unset the FLASH attribute for the current selection.
@ $B46F label=MenuAttributeNext
  $B46F,$01 Move onto the next selection attribute.
  $B470,$02 Decrease counter by one and loop back to #R$B46A until counter is zero.
  $B472,$01 Return.

c $B473 Game Selection Menu
E $B473 View the equivalent code in;
. #LIST
. { #ATICATAC$7CAF }
. { #COOKIE$6332 }
. { #JETPAC$6260 }
. { #LUNARJETMAN$80D1 }
. { #PSSST$6250 }
. LIST#
@ $B473 label=GameMenu
  $B473,$03 #REGde=#R$B498.
  $B476,$01 Switch to the shadow registers.
  $B477,$03 #REGhl'=#R$B4A0.
  $B47A,$03 #REGde'=#R$B4B0.
N $B47D There are eight lines of text.
  $B47D,$02 #REGb'=#N$08 (counter).
@ $B47F label=GameMenu_Loop
  $B47F,$01 Switch back to the normal registers.

  $B480,$04 Copy a byte from #REGde to #R$96A8.
  $B484,$01 Increment #REGde by one.
  $B485,$01 Switch to the shadow registers.
  $B486,$01 Stash #REGbc' on the stack.
  $B487,$01 #REGa=#REGhl' (grab the position data).
  $B488,$02 Increment #REGhl' (position data pointer) by two.
  $B48A,$01 Stash #REGhl' (position data pointer) on the stack.
  $B48B,$01 Decrease #REGhl' (position data pointer) by one.
  $B48C,$01 #REGa=#REGhl' (grab the position data).
  $B48D,$01 #REGl'=#REGa.
  $B48E,$03 Call #R$B52D.
  $B491,$01 Switch back to the normal registers.
  $B492,$02 Restore #REGhl and #REGbc from the stack.
  $B494,$01 Increase #REGde by one.
  $B495,$02 Decrease counter by one and loop back to #R$B47F until counter is zero.
  $B497,$01 Return.

b $B498 Game Select Attribute Table
E $B498 View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #JETPAC$628D }
. { #LUNARJETMAN$810E }
. { #PSSST$627C }
. { #TRANZAM$5FA7 }
. LIST#
@ $B498 label=GameSelection_Attributes
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

b $B4A0 Game Select Position Table
E $B4A0 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF1 }
. { #JETPAC$6293 }
. { #LUNARJETMAN$8115 }
. { #PSSST$6282 }
. { #TRANZAM$5FAC }
. LIST#
@ $B4A0 label=GameSelection_Position
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

t $B4B0 Game Selection Screen Text
E $B4B0 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #COOKIE$636C }
. { #JETPAC$6299 }
. { #LUNARJETMAN$811C }
. { #PSSST$6288 }
. LIST#
@ $B4B0 label=GameSelection_Text
  $B4B0,$10,$0F:$01 "#STR(#PC)".
  $B4C0,$10,$0F:$01 "#STR(#PC)".
  $B4D0,$0B,$0A:$01 "#STR(#PC)".
  $B4DB,$14,$13:$01 "#STR(#PC)".
  $B4EF,$14,$13:$01 "#STR(#PC)".
  $B503,$0F,$0E:$01 "#STR(#PC)".
  $B512,$0D,$0C:$01 "#STR(#PC)".
  $B51F,$0E,$0D:$01 "#STR(#PC)".

c $B52D Write Menu Line
E $B52D View the equivalent code in;
. #LIST
. { #ATICATAC$7D8A }
. { #COOKIE$63E0 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$62E7 }
. LIST#
@ $B52D label=MenuWriteText
  $B52D,$01 Stash #REGhl containing the co-ordinate on the stack.
  $B52E,$03 Call #R$B8AD.
  $B531,$03 #REGa=the menu attribute byte from #R$96A8.
  $B534,$01 Switch to the shadow #REGaf register.
  $B535,$01 Switch to the shadow registers.
  $B536,$01 Restore #REGhl from the stack.
  $B537,$03 Call #R$B8DD.
  $B53A,$03 Jump to #R$B549.

c $B53D Print Colour String
E $B53D View the equivalent code in;
. #LIST
. { #ATICATAC$A1F3 }
. { #COOKIE$7488 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$8A11 }
. { #PSSST$73ED }
. LIST#
@ $B53D label=PrintStringColour
R $B53D DE Pointer to string data
  $B53D,$01 Stash #REGhl on the stack.
  $B53E,$03 Call #R$B8AD.
  $B541,$01 Fetch the attribute byte.
  $B542,$01 Switch to the shadow #REGaf register.
  $B543,$01 Increment #REGde by one to point to the text of the string.
  $B544,$01 Switch to the shadow registers.
  $B545,$01 Restore #REGhl from the stack.
  $B546,$03 Call #R$B8DD.
@ $B549 label=PrintString_Loop
  $B549,$01 Switch back to the normal registers.
  $B54A,$01 Fetch the character to print.
  $B54B,$04 If bit 7 is set (which signifies the end of the string), jump to #R$B55A.
  $B54F,$03 Call #R$B589.
  $B552,$01 Increment #REGde by one.
  $B553,$01 Switch to the shadow registers.
  $B554,$01 Switch to the shadow #REGaf register.
  $B555,$01 Copy the attribute byte to the screen.
  $B556,$01 Increment #REGl by one.
  $B557,$01 Switch to the shadow #REGaf register.
  $B558,$02 Jump to #R$B549.
N $B55A Because the last character contains the terminator, it needs to be handled separately.
@ $B55A label=PrintString_LastCharacter
  $B55A,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $B55C,$03 Call #R$B589.
  $B55F,$01 Switch to the shadow registers.
  $B560,$01 Switch to the shadow #REGaf register.
  $B561,$01 Copy the attribute byte to the screen.
  $B562,$01 Return.

c $B563 Print Banner
E $B563 View the equivalent code in;
. #LIST
. { #COOKIE$74AE }
. { #LUNARJETMAN$8A37 }
. { #PSSST$7413 }
. LIST#
@ $B563 label=PrintBanner
N $B563 Prints "1UP".
  $B563,$03 #REGhl=#N($0010, $04, $04).
  $B566,$03 #REGde=#R$B57E.
  $B569,$03 Call #R$B53D.
N $B56C Prints "HI".
  $B56C,$03 #REGhl=#N($0078, $04, $04).
  $B56F,$03 #REGde=#R$B586.
  $B572,$03 Call #R$B53D.
N $B575 Prints "2UP".
  $B575,$03 #REGhl=#N($00D8, $04, $04).
  $B578,$03 #REGde=#R$B582.
  $B57B,$03 Jump to #R$B53D.
N $B57E Banner text data.
@ $B57E label=1UP_Text
T $B57E,$04,h$01,$02:$01 "1UP" (#N(#PEEK(#PC)) is the attribute).
@ $B582 label=2UP_Text
T $B582,$04,h$01,$02:$01 "2UP" (#N(#PEEK(#PC)) is the attribute).
@ $B586 label=HI_Text
T $B586,$03,h$01,$01:$01 "HI" (#N(#PEEK(#PC)) is the attribute).

c $B589 Print Character
E $B589 View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #PSSST$73CD }
. LIST#
@ $B589 label=PrintScreen
R $B589 A ASCII value to print
R $B589 HL Screen address
  $B589,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $B58C,$03 Create an offset in #REGhl.
  $B58F,$03 Calculate offset for ASCII character (#REGhl=#REGhl * 8).
  $B592,$04 #HTML(#REGde=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $B596,$02 #REGde=#REGhl + #N$3C00. For examples of usage;
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Letter | =h ASCII Value | =h * 8 (offset) | =h CHARS + offset }
. #FOREACH($55,$4C,$54,$49,$4D,$41,$54,$45)(value,
. { #LET(result=$3C00 + value * $08) "#CHR(value)" | #N(value) | #N(value * 8) | #HTML(<a href="https://skoolkid.github.io/rom/asm/3D00.html##N({result}, $02, $03, $01, $01)()">#N({result})) }
. )
. TABLE#
N $B598 Print the character to the screen.
  $B598,$01 Restore #REGhl, containing the screen buffer location, from the stack.
  $B599,$02 #REGb=#N$08 (#N$08 rows of pixels).
@ $B59B label=PrintScreen_Loop
  $B59B,$02 Copy a byte from the font data to the screen buffer.
  $B59D,$01 Increment the font data by one.
  $B59E,$01 Move onto the next pixel line.
  $B59F,$02 Decrease counter by one and loop back to #R$B59B until counter is zero.
  $B5A1,$02 Restore #REGde and #REGbc from the stack.
N $B5A3 Reset #REGhl and move to the next column, ready to print the next character.
  $B5A3,$04 #REGh=#REGh - #N$08 (reset the display line).
  $B5A7,$01 Increment screen column by one.
  $B5A8,$01 Return.

c $B5A9 Add Points To Score
E $B5A9 View the equivalent code in;
. #LIST
. { #COOKIE$7415 }
. { #JETPAC$70F9 }
. { #PSSST$737A }
. { #TRANZAM$6046 }
. LIST#
R $B5A9 BC Points to add to score
N $B5A9 Check the active player.
@ $B5A9 label=AddPointsToScore
  $B5A9,$06 If #R$969E is not zero, jump to #R$B5B4.
N $B5AF Set the score address for 1UP.
  $B5AF,$03 #REGhl=#R$969A.
  $B5B2,$02 Jump to #R$B5B7.
N $B5B4 Set the score address for 2UP.
@ $B5B4 label=AddPointsToScore_2UP
  $B5B4,$03 #REGhl=#R$969D.
N $B5B7 Process adding the points to the appropriate score.
@ $B5B7 label=AddPointsToScore_Start
  $B5B7,$01 #REGa=score byte #3.
  $B5B8,$02 Add #REGc to score byte #3 with BCD conversion.
  $B5BA,$01 Update score byte #3.
  $B5BB,$01 Move onto the next score byte.
  $B5BC,$01 #REGa=score byte #2.
  $B5BD,$02 Add (with carry) #REGb to score byte #2 with BCD conversion.
  $B5BF,$01 Update score byte #2.
  $B5C0,$01 Move onto the next score byte.
  $B5C1,$01 #REGa=score byte #1.
  $B5C2,$03 Add #N$00 (i.e. just the carry flag) to score byte #1 with BCD conversion.
  $B5C5,$01 Update score byte #1.
N $B5C6 Check the active player.
  $B5C6,$06 If #R$969E is not zero, jump to #R$B5D4.

c $B5CC Print Scores
E $B5CC View the equivalent code in;
. #LIST
. { #COOKIE$7438 }
. { #JETPAC$711C }
. { #LUNARJETMAN$89BF }
. { #PSSST$739D }
. LIST#
N $B5CC Sets up the 1UP score.
@ $B5CC label=Score_1UP
  $B5CC,$03 #REGhl=#N$4021 (screen buffer address).
  $B5CF,$03 #REGde=#R$9698.
  $B5D2,$02 Jump to #R$B5E2.
N $B5D4 Sets up the 2UP score.
@ $B5D4 label=Score_2UP
  $B5D4,$03 #REGhl=#N$4039 (screen buffer address).
  $B5D7,$03 #REGde=#R$969B.
  $B5DA,$02 Jump to #R$B5E2.
N $B5DC Sets up the HI score.
@ $B5DC label=Score_HI
  $B5DC,$03 #REGhl=#N$402D (screen buffer address).
  $B5DF,$03 #REGde=#R$B304.
N $B5E2 Prints the score.
@ $B5E2 label=PrintScore
  $B5E2,$02 #REGb=#N$03.
@ $B5E4 label=PrintScore_Loop
  $B5E4,$01 #REGa=#REGde.
  $B5E5,$04 #REGa=#REGa / #N$10.
  $B5E9,$02,b$01 Keep only bits 0-3.
  $B5EB,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $B5ED,$03 Call #R$B589.
  $B5F0,$01 #REGa=#REGde.
  $B5F1,$02,b$01 Keep only bits 0-3.
  $B5F3,$02 #REGa=#REGa + #N$30 (convert to ASCII).
  $B5F5,$03 Call #R$B589.
  $B5F8,$01 Increment #REGde by one.
  $B5F9,$02 Decrease counter by one and loop back to #R$B5E4 until counter is zero.
  $B5FB,$01 Return.

c $B5FC Handler: New High Score
@ $B5FC label=NewHighScore
  $B5FC,$03 #REGhl=#R$9698.
  $B5FF,$03 #REGde=#R$969B.
  $B602,$03 Call #R$B6B2.
  $B605,$05 Write #N$00 to #R$96BA.
  $B60A,$04 If there's either any carry or the zero flag is set then jump to #R$B610.
  $B60E,$01 Flip the bits.
  $B60F,$01 Switch the registers containing the 1UP and 2UP score.
@ $B610 label=NewHighScore_Process
  $B610,$03 Write #REGa to #R$969E.
  $B613,$03 Call #R$B61E.
  $B61A,$01 Flip the bits.
  $B61E,$02 Stash #REGde and #REGhl on the stack.
N $B620 We hold six high scores.
  $B620,$02 #REGb=#N$06.
  $B622,$03 #REGde=#R$B322.
  $B625,$03 Call #R$B6B2.
  $B62A,$03 Call #R$B6AB.

  $B634,$03 #REGhl=#R$B322.
  $B637,$03 #REGde=#R$B328.

  $B667,$03 #REGhl=#R$61C6.
  $B66A,$03 Call #R$BBF7.
  $B66D,$03 Call #R$B2D8.
  $B670,$03 #REGa=#R$969E.
  $B673,$01
  $B674,$02 #REGa=#N$B1.

  $B686,$03 Create an offset in #REGbc.
  $B689,$04 #REGhl=#R$B6C5 + offset.
  $B68D,$03 #REGde=#R$B795(#N$B79C).
  $B690,$03 #REGbc=#N$0003 (counter).
  $B693,$02
  $B695,$03 #REGde=#R$B755.
  $B699,$03 #REGhl'=#R$B75D.
  $B69C,$03 #REGde'=#R$B76D.
N $B69F There are eight lines of text.
  $B69F,$02 #REGb=#N$08.
  $B6A1,$03 Call #R$B47F.

  $B6AA,$01 Return.

  $B6B1,$01 Return.
  $B6B2,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $B6B5,$02 #REGb=#N$03 (counter).
  $B6B7,$01 #REGa=the 1UP score digit held by #REGde.
  $B6B8,$01 Compare this against the 2UP score.
  $B6B9,$02 If there's any carry over then jump to #R$B6C1 to return.
  $B6BB,$02 If the result is non-zero then jump to #R$B6C1 to return.
  $B6BD,$02 Increment both #REGhl and #REGde by one.
  $B6BF,$02 Decrease the score digit counter by one and loop back to #R$B6B7 until the counter is zero.
  $B6C1,$03 Restore #REGhl, #REGde and #REGbc from the stack.
  $B6C4,$01 Return.

T $B6C5,$03 "#STR(#PC,$04,$03)".
T $B6C8,$03 "#STR(#PC,$04,$03)".
T $B6CB,$03 "#STR(#PC,$04,$03)".
T $B6CE,$03 "#STR(#PC,$04,$03)".
T $B6D1,$03 "#STR(#PC,$04,$03)".
T $B6D4,$03 "#STR(#PC,$04,$03)".

  $B6D7,$02 #REGb=#N$03.
  $B6D9,$03 #REGhl=#N$506D.
  $B6DC,$02 #REGa=#N$20.
  $B6DF,$03 Call #R$B0A3.

  $B71B,$01 Stash #REGaf on the stack.
  $B71C,$03 Call #R$B0A3.
  $B71F,$01 Restore #REGaf from the stack.

  $B728,$03 Call #R$B589.
  $B72C,$03 Call #R$BF2A.

N $B73B Introduce a pause by counting down from 10000.
  $B73B,$02 #REGb=#N$01.
  $B73D,$03 #REGhl=#N$0000.
  $B740,$03 Jump to #R$A1FF.

N $B743 Introduce a pause by counting down from 8000.
@ $B743 label=NewHighScore_Return
  $B743,$03 Stash #REGaf, #REGbc and #REGhl on the stack.
  $B746,$02 #REGb=#N$01.
  $B748,$03 #REGhl=#N$8000.
  $B74B,$03 Call #R$A1FF.
  $B74E,$03 Call #R$BF25.
  $B751,$03 Restore #REGhl, #REGbc and #REGaf from the stack.
  $B754,$01 Return.

b $B755 New High Score Attribute Table
@ $B755 label=NewHighScore_Attributes
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

t $B76D New High Score Screen Text
@ $B76D label=NewHighScore_Text
  $B76D,$0F,$0E:$01 "#STR(#PC)".
  $B77C,$08,$07:$01 "#STR(#PC)".
  $B784,$11,$10:$01 "#STR(#PC)".
  $B795,$12,$11:$01 "#STR(#PC)".
  $B7A7,$05,$04:$01 "#STR(#PC)".
  $B7AC,$0F,$0E:$01 "#STR(#PC)".
  $B7BB,$0D,$0C:$01 "#STR(#PC)".
  $B7C8,$05,$04:$01 "#STR(#PC)".

c $B7CD Display Lives
E $B7CD View the equivalent code in;
. #LIST
. { #ATICATAC$0000 }
. { #COOKIE$7378 }
. { #JETPAC$70A4 }
. { #LUNARJETMAN$894F }
. { #PSSST$7325 }
. { #TRANZAM$0000 }
. LIST#
@ $B7CD label=DisplayPlayerLives
N $B7CD Controller for 1UP lives.
  $B7CD,$03 #REGhl=#N$4008 (screen buffer address) for 1UP lives.
  $B7D0,$03 #REGa=1UP lives remaining (by calling #R$B7FE).
  $B7D3,$03 If 1UP lives are zero, jump to #R$B7EF.
  $B7D6,$03 Else, there are lives to display so call #R$B7E2.
N $B7D9 Controller for 2UP lives.
@ $B7D9 label=Controller2UPLives
  $B7D9,$03 #REGhl=#N$4016 (screen buffer address) for 2UP lives.
  $B7DC,$03 #REGa=2UP lives remaining (by calling #R$B80C).
  $B7DF,$03 If 2UP lives are zero, jump to #R$B7F4.
N $B7E2 Handles displaying the lives count and UDG character.
@ $B7E2 label=HandlerDisplayLives
  $B7E2,$02 Add #N$30 to convert to an ASCII character (starting at "0" character).
  $B7E4,$03 Call #R$B589.
  $B7E7,$03 #REGde=#R$B814.
  $B7EA,$02 Stash #REGbc and #REGde on the stack.
  $B7EC,$03 Jump to #R$B599.
N $B7EF 1UP has no lives.
@ $B7EF label=Handler1UPNoLives
  $B7EF,$03 Call #R$B7F4.
  $B7F2,$02 Jump to #R$B7D9.
N $B7F4 2UP has no lives.
@ $B7F4 label=Handler2UPNoLives
  $B7F4,$02 #REGa=ASCII " " (SPACE).
  $B7F6,$03 Call #R$B589.
  $B7F9,$02 #REGa=ASCII " " (SPACE).
  $B7FB,$03 Jump to #R$B589.
N $B7FE Controller for the currently active player.
@ $B7FE label=ControllerActiveLives
  $B7FE,$06 If #R$969E is not zero then jump to #R$B808.
N $B804 Return currently active players lives left.
@ $B804 label=ActivePlayerLives
  $B804,$03 #REGa=#R$96BD.
  $B807,$01 Return.
N $B808 Return inactive players lives left.
@ $B808 label=InactivePlayerLives
  $B808,$03 #REGa=#R$96E0.
  $B80B,$01 Return.
N $B80C Controller for the inactive player.
@ $B80C label=ControllerInactiveLives
  $B80C,$06 If #R$969E is zero then jump to #R$B808.
  $B812,$02 Jump to #R$B804.

b $B814 The UDG for the lives icon
@ $B814 label=UDG_Life
  $B814,$08,b$01 #UDGTABLE(default,centre) { #UDG#(#PC),attr=$07 } UDGTABLE#

c $B81C

c $B873

c $B8AD Calculate Screen Address
E $B8AD View the equivalent code in;
. #LIST
. { #ATICATAC$9BA2 }
. { #COOKIE$76E3 }
. { #JETPAC$7308 }
. { #LUNARJETMAN$851E }
. { #PSSST$759A }
. LIST#
@ $B8AD label=ScreenAddress
  $B8AD,$01 #REGa=#REGl.
  $B8AE,$03 #REGa=#REGa / #N$08.
  $B8B1,$02,b$01 Keep only bits 0-4.
  $B8B3,$01 #REGl=#REGa.
  $B8B4,$01 #REGa=#REGh.
  $B8B5,$02 #REGa=#REGa * #N$04.
  $B8B7,$02,b$01 Keep only bits 5-7.
  $B8B9,$01
  $B8BA,$01 #REGl=#REGa.
  $B8BB,$01 #REGa=#REGh.
  $B8BC,$02,b$01 Keep only bits 0-2.
  $B8BE,$01 Switch to the shadow #REGaf register.
  $B8BF,$01 #REGa=#REGh.
  $B8C0,$03 #REGa=#REGa / #N$08.
  $B8C3,$02,b$01 Keep only bits 3-4.
  $B8C5,$02,b$01 Set bit 6.
  $B8C7,$01 #REGh=#REGa.
  $B8C8,$01 Switch to the shadow #REGaf register.
  $B8C9,$01
  $B8CA,$01 #REGh=#REGa.
  $B8CB,$01 Return.

c $B8CC Screen Address One Pixel Below
@ $B8CC label=ScreenPos1PixelBelow
R $B8CC HL Current position
R $B8CC O:HL Address for new position
N $B8CC Calculates the new address for writing a sprite pixel, in a downward direction, taking into consideration the screen memory layout.
  $B8CC,$01 Increment #REGh to move down one pixel on screen.
  $B8CD,$01 Stash #REGh in #REGa temporarily.
  $B8CE,$02,b$01 Keep only bits 0-2.
  $B8D0,$01 If a character line has not been crossed then return.
  $B8D1,$04 #REGl=#REGl+#N$20.
  $B8D5,$02,b$01 Keep only bits 5-7.
  $B8D7,$01 If a new section of the screen has not been crossed then return.
  $B8D8,$04 #REGh=#REGh-#N$08.
  $B8DC,$01 Return.

c $B8DD Calculate Attribute Address
E $B8DD View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #COOKIE$7534 }
. { #JETPAC$720E }
. { #LUNARJETMAN$8506 }
. { #PSSST$748F }
. LIST#
@ $B8DD label=AttributeAddress
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
E $B8F5 View the equivalent code in;
. #LIST
. { #ATICATAC$9F56 }
. LIST#
@ $B8F5 label=RemoveEntity

c $B902
  $B902,$02 #REGl=#N$00.
  $B904,$02 #REGd=#N$00.
  $B906,$01
  $B907,$02 #REGh=#N$FF.
  $B909,$02 #REGb=#N$08.
  $B918,$01 Return.

c $B919 Draw Entity
E $B919 View the equivalent code in;
. #LIST
. { #ATICATAC$9F4A }
. LIST#
@ $B919 label=DrawEntity
  $B919,$03 Call #R$B969.
  $B91C,$01 Switch to the shadow registers.
  $B91D,$04 Write #N$00 to #R$96A3.
  $B921,$01 #REGc=#N$00.
  $B922,$03 Jump to #R$B9DA.

c $B925 Get Sprite "A"
R $B925 O:DE The sprite address
E $B925 View the equivalent code in;
. #LIST
. { #ATICATAC$9E86 }
. LIST#
E $B925 Continue on to #R$B928.
@ $B925 label=GetSpriteA
  $B925,$03 #REGa=#R$969F.

c $B928 Get Sprite Address
R $B928 A The Sprite ID
R $B928 O:DE The sprite address
E $B928 View the equivalent code in;
. #LIST
. { #ATICATAC$9E89 }
. LIST#
@ $B928 label=GetSpriteAddress
  $B928,$03 Create an offset in #REGhl.
  $B92B,$01 #REGhl=#REGhl * 2.
  $B92C,$04 #REGhl=#R$BF84 + offset.
  $B930,$03 #REGde=the sprite address.
  $B933,$01 Return.

c $B934 Get Entity Sprite
E $B934 View the equivalent code in;
. #LIST
. { #ATICATAC$9E96 }
. LIST#
@ $B934 label=GetEntitySprite
  $B934,$03 #REGa=#REGix+#N$00 (sprite reference).
  $B937,$02 Jump to #R$B928.

c $B939 Prepare Draw 2/ 3 Byte Sprite
E $B969 View the equivalent code in;
. #LIST
. { #ATICATAC$9F80 }
. LIST#
@ $B939 label=PrepDraw23
  $B939,$03 Call #R$B925.
  $B93C,$03 #REGhl=#R$96A0 (saved X position).
  $B942,$02,b$01 Keep only bits 1-3.
  $B968,$01 Return.

c $B969 Prepare Draw 2 Byte Sprite
E $B969 View the equivalent code in;
. #LIST
. { #ATICATAC$9E96 }
. LIST#
@ $B969 label=PrepDraw2
  $B969,$03 Call #R$9E96.

c $B9A9 Display Entity
E $B9A9 View the equivalent code in;
. #LIST
. { #ATICATAC$9FCA }
. LIST#
@ $B9A9 label=DisplayEntity
  $B9A9,$03 Call #R$B969.
  $B9AC,$01 Switch to the shadow registers.
  $B9AD,$03 Call #R$B939.
  $B9B0,$03 #REGa=#R$96A1.
  $B9BD,$03 #REGa=#R$96A3.
  $B9C8,$03 Jump to #R$B9DA.

N $B9CB
  $B9CB,$01 Switch back to the normal registers.
  $B9CF,$03 #REGa=#R$96A4.
  $B9D7,$03 Jump to #R$BA07.

c $B9DA
E $B9DA  View the equivalent code in;
. #LIST
. { #ATICATAC$9E9B }
. LIST#

c $BA14

c $BB0B Store Entity
E $BB0B View the equivalent code in;
. #LIST
. { #ATICATAC$9FFB }
. { #COOKIE$0000 }
. { #JETPAC$7327 }
. { #LUNARJETMAN$0000 }
. { #PSSST$75B9 }
. { #TRANZAM$71ED }
. LIST#
@ $BB0B label=StoreEntity
R $BB0B IX Actor Entity
N $BB0B This is @todo.
  $BB0B,$06 Copy actor X position to active actor X position at #R$96A0.
  $BB11,$06 Copy actor Y position to active actor Y position at #R$96A1.
  $BB17,$06 Copy actor movement to active actor movement at #R$969F.
  $BB1D,$06 Copy actor movement to active actor movement at #R$96A2.
  $BB23,$01 Return.

c $BB24

c $BB45
@ $BB45 label=AttrDrawUnchanged
  $BB45,$02
  $BB5B,$01 Return.

c $BB5C Clear Play Area
N $BB5C This routine clears the top third of the screen, but only from below the banner. This is left untouched.
@ $BB5C label=ClearPlayArea
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
  $BB7C,$03 #REGhl=#N$5840(attribute buffer).
  $BB7F,$02 Jump to #R$BB92.

c $BB8F Reset Attribute Buffer
E $BB8F View the equivalent code in;
. #LIST
. { #ATICATAC$80C2 }
. { #JETPAC$71C6 }
. { #LUNARJETMAN$84BB }
. { #PSSST$7447 }
. { #TRANZAM$7200 }
. LIST#
@ $BB8F label=ResetAttributes
  $BB8F,$03 #REGhl=#R$5800(attribute buffer).
  $BB92,$02 #REGb=#N$5B (i.e. finish once we reach the end of the #R$5800(attribute buffer)).
  $BB94,$02 #REGc=#N$00 (value to write).
  $BB96,$02 Jump to #R$BB88.

c $BB81 Reset Screen Buffer
E $BB81 View the equivalent code in;
. #LIST
. { #ATICATAC$80B4 }
. { #COOKIE$74D4 }
. { #JETPAC$71B8 }
. { #LUNARJETMAN$84AD }
. { #PSSST$7439 }
. LIST#
@ $BB81 label=ResetScreen
E $BB81 Continue on to #R$BB88 to blank the screen buffer.
  $BB81,$03 #REGhl=#R$4000(screen buffer).
  $BB84,$02 #REGb=#N$58 (i.e. finish once we reach the start of #R$5800(attribute buffer)).
  $BB86,$02 #REGc=#N$00 (value to write).

c $BB88 Reset Routine
E $BB88 View the equivalent code in;
. #LIST
. { #ATICATAC$80BB }
. { #COOKIE$74DB }
. { #JETPAC$71B8 }
. { #LUNARJETMAN$84B4 }
. { #PSSST$7440 }
. LIST#
R $BB88 HL Target address
R $BB88 B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $BB88 C Value to write
@ $BB88 label=ResetCopier
  $BB88,$01 Write #REGc to the target address.
  $BB89,$01 Increment the target address by one.
  $BB8A,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $BB8C,$02 Keep looping back to #R$BB88 until there is no carry-over.
  $BB8E,$01 Return.

c $BB9F Clear Buffers
@ $BB9F label=ClearBuffers
N $BB9F Writes #N$00 to every address from #R$9692 to #R$995A.
  $BB9F,$03 #REGhl=#R$9692 (starting address).
  $BBA2,$03 #REGbc=#N$02C8 (counter).
@ $BBA5 label=ClearBuffers_Loop
  $BBA5,$02 Writes #N$00 to the address held by #REGhl.
  $BBA7,$01 Increment #REGhl by one.
  $BBA8,$01 Decrease the counter held in #REGbc by one.
  $BBA9,$04 Keep looping back to #R$BBA5 until the counter in #REGbc is zero.
  $BBAD,$01 Return.

c $BBAE
  $BBAE,$03 Call #R$A79F.
  $BBB1,$03 Call #R$A763.
  $BBB4,$03 Call #R$A33B.
  $BBB7,$03 Call #R$BBBB.
  $BBBA,$01 Return.

c $BBBB

c $BBDD
  $BBDD,$03 #REGl=#REGix+#N$01 (current location).
  $BBE0,$02 #REGh=#N$00.
  $BBE2,$03 #REGbc=#R$6066.
  $BBE7,$02 #REGh=#N$00.
  $BBEA,$03 #REGbc=#R$6166.
  $BBF2,$03 Call #R$BBF2.
  $BBF5,$02 Jump to #R$BBAE.

c $BBF7 Draw Room
@ $BBF7 label=DrawRoom
R $BBF7 HL The Room Data memory address (e.g. #R$61C6, #R$6200)
N $BBF7 The room data is held as: #TABLE(default,centre)
. { =h Byte | =h Type }
. { #N$01 | =r2 Room Graphic Data Address }
. { #N$02 }
. { #N$03 | X Position }
. { #N$04 | Y Position }
. TABLE#
. And is terminated when #N($0000, $04, $04) is reached.
N $BBF7 Fetch the room data graphic address.
  $BBF7 #REGde=room data graphic address.
  $BBFA,$03 Return if the terminator is found.
N $BBFD Fetch the X/ Y position data.
  $BBFD,$01 Increment #REGhl by one.
  $BBFE,$03 #REGbc=X/ Y position data.
  $BC01,$01 Increment #REGhl by one, ready for the next loop.
  $BC02,$01 Stash #REGhl (room graphic data pointer) on the stack.
  $BC03,$02 #REGhl=#REGbc.
  $BC05,$03 Call #R$BC0B.
  $BC08,$01 Restore #REGhl from the stack (room graphic data pointer).
  $BC09,$02 Jump back to #R$BBF7.
N $BC0B At the point of processing; #REGhl contains X/ Y position data, #REGde contains the room data graphic address (and #REGbc is throwaway).
@ $BC0B label=DrawRoom_Process
  $BC0B,$01 Stash #REGhl (X/ Y position) on the stack.
  $BC0C,$03 Call #R$B8AD.
  $BC0F,$02 #REGc=room graphic width byte.
  $BC11,$01 Increment #REGde by one.
  $BC12,$02 #REGb=room graphic height byte.
  $BC14,$01 Increment #REGde by one.
@ $BC15 label=DrawRoom_Row_Loop
  $BC15,$01 Stash #REGbc on the stack.
@ $BC16 label=DrawRoom_Write_Row
  $BC16,$01 #REGa=fetch a byte of graphics data.
  $BC17,$01 Invert the bits.
  $BC18,$01 Write the graphic data to #REGhl (screen buffer).
  $BC19,$01 Move onto the next screen location.
  $BC1A,$01 Increment #REGde by one.
  $BC1B,$02 Decrease the width counter by one and loop back to #R$BC16 until counter is zero.
  $BC1D,$01 Restore #REGbc from the stack.
  $BC1E,$03 #REGl=#REGl-#REGb.
  $BC21,$03 Call #R$B8CC.
  $BC24,$03 Decrease the height counter by one and loop back to #R$BC15 until counter is zero.
  $BC27,$01 Restore #REGhl from the stack.
  $BC28,$03 Call #R$B8DD.

  $BC31,$06 If #R$96B2 is not zero, jump to #R$BC49.

  $BC48,$01 Return.
  $BC49,$01 Stash #REGbc on the stack.
  $BC4A,$04 Write #N$00 to #R$96B2.

  $BC5A,$03 #REGhl=#N($0000, $04, $04).
  $BC5D,$02 #REGb=#N$08.

  $BC66,$01 Return.

b $BC67 Music Data
@ $BC67 label=MusicData_GameComplete
@ $BC77 label=MusicData_GameComplete_Loop
  $BC77
@ $BD28 label=MusicData_GameOver
  $BD28
@ $BD33 label=MusicData_Poem
  $BD33
@ $BD45 label=MusicData_GameInitialisation
  $BD45

c $BD51 Play Music (break on keypress)
@ $BD51 label=PlayAudio_WaitKey
  $BD51,$01 Disable interrupts.
@ $BD52 label=PlayAudio_WaitKey_Loop
  $BD52,$05
  $BD57,$01 Flip the bits.
  $BD58,$02,b$01 Keep only bits 0-4.
  $BD5A,$02 If no keys were pressed, jump to #R$BD64.
  $BD5C,$03 #REGa=#R$9692.
  $BD5F,$02 Increments the stack pointer by two.
  $BD61,$03 Jump to #R$B422.
  $BD61,$03 Jump to #R$B422.
N $BD64 This is identical to #R$BD6E except it also handles exiting on a keypress.
@ $BD64 label=PlayAudio_WaitKey_Process
  $BD64,$01 Fetch the next byte of music data.
  $BD65,$04 If this is #N$FF (the terminator) then jump to #R$BD79.
  $BD69,$03 Call #R$BD7B.
  $BD6C,$02 Jump to #R$BD52.

c $BD6E Play Audio
@ $BD6E label=PlayAudio
R $BD6E DE Music data terminated by #N$FF
  $BD6E,$01 Disable interrupts.
@ $BD6F label=PlayAudio_Loop
  $BD6F,$01 Fetch the next byte of music data.
  $BD70,$04 If this is #N$FF (the terminator) then jump to #R$BD79.
  $BD74,$03 Call #R$BD7B.
  $BD77,$02 Jump to #R$BD6F.

c $BD79 Play Audio: Enable Interrupts And Return
@ $BD79 label=PlayAudio_Return
  $BD79,$01 Enable interrupts.
  $BD7A,$01 Return.

c $BD7B Play Audio: Process Music Data
@ $BD7B label=PlayAudio_Process
R $BD7B A Music data byte
R $BD7B DE Music data terminated by #N$FF
  $BD7B,$02,b$01 Keep only bits 0-5.
  $BD7D,$02 If we're left with zero, jump to #R$BDBC.
  $BD7F,$03 Creates an offset using #REGh=#N$00 and #REGl=#REGa.
  $BD82,$06 #REGhl=#R$BDD2 + (offset * #N$04).
  $BD88,$04 #REGbc=the address held at #REGhl.
  $BD8C,$04 #REGa=.
  $BD90,$01 #REGa=.
  $BD93,$02,b$01 Keep only bits 0-1.
  $BD96,$01 Stash #REGde on the stack.
  $BDA1,$03 Set the border to black.
M $BDAB,$04 Flip speaker on (set bit 4).
  $BDAB,$02,b$01
  $BDAF,$02 Decrease counter by one and loop back to #R$BDAF until counter is zero.
  $BDBB,$01 Return.
  $BDC0,$02,b$01 Keep only bits 0-1.
  $BDC4,$03 #REGbc=#N$430B.
  $BDD1,$01 Return.

b $BDD2 Music Data
@ $BDD2 label=MusicData

c $BECC
  $BECC,$03 #REGbc=#R$BEDE.
  $BECF,$03 #REGa=#R$9693.
  $BED2,$02,b$01 Keep only bits 0-3.
  $BEDB,$03 Jump to #R$BF6D.

b $BEDE

c $BEEE
  $BEEE,$04 #REGl=#R$9695.
  $BEF2,$03 #REGa=#R$9693.
  $BEF5,$02,b$01 Keep only bits 0-4.
  $BEF7,$01 Store the result in #REGh.
  $BEF8,$02 #REGe=#N$10.
  $BEFC,$02,b$01 Keep only bits 0-6.
  $BEFE,$01 Store the result in #REGb.
  $BEFF,$02 #REGc=#N$02.
  $BF01,$03 Call #R$BF6D.
  $BF04,$01 Decrease #REGe by one.
  $BF07,$01 Return.

c $BF08
  $BF08,$03 #REGa=#REGix+#N$00 (sprite reference).
  $BF0B,$01 Flip the bits.
  $BF0C,$03
  $BF0F,$02,b$01 Keep only bits 5-7.
  $BF11,$01 Store the result in #REGb.
  $BF12,$02 #REGc=#N$06.
  $BF14,$03 Jump to #R$BF6D.

c $BF17
  $BF17,$02 #REGc=#N$30.
  $BF1A,$02,b$01 Set bits 3-4.
  $BF1E,$03 Call #R$BF74.
  $BF24,$01 Return.

c $BF25
  $BF25,$03 #REGbc=#N$4030.
  $BF28,$02 Jump to #R$BF6D.

c $BF2A
  $BF2A,$03 #REGbc=#N$8010.
  $BF2D,$02 Jump to #R$BF6D.

c $BF2F
  $BF2F,$02 #REGc=#N$30.
  $BF36,$03 Call #R$BF74.
  $BF3C,$01 Return.

c $BF3D
  $BF46,$02 #REGc=#N$08.
  $BF48,$03 Jump to #R$BF6D.

c $BF4B
  $BF4B,$03 Call #R$BF54.
  $BF54,$03 #REGhl=#R$96B3.
  $BF5D,$02,b$01 Keep only bits 0-2.
  $BF60,$03 #REGbc=#N$4004.
  $BF63,$02 Jump to #R$BF6D.
  $BF65,$02,b$01 Keep only bits 0-2.
  $BF68,$03 #REGbc=#N$6004.
  $BF6B,$02 Jump to #R$BF6D.

c $BF6D
  $BF6D,$03 Call #R$BF74.

c $BF74 Play Square Wave Sound
@ $BF74 label=PlaySquareWave
E $BF74 View the equivalent code in;
. #LIST
. { #PSSST$64AA }
. LIST#
R $BF74 B Duration of wave
N $BF74 Flip speaker on (set bit 4).
M $BF74,$04 #REGa=#N$10 (speaker on = bit 4).
  $BF74,$02,b$01
  $BF78,$01 #REGa=#REGb.
@ $BF79 label=PlaySquareWave_Loop
  $BF79,$02 Decrease duration by one and loop back to #R$BF79 until counter is zero.
  $BF7B,$01 #REGb=#REGa.
N $BF7C Flip speaker off (unset bit 4).
  $BF7C,$03 Speaker off.
  $BF7F,$01 #REGa=#REGb.
@ $BF80 label=Silence_Loop
  $BF80,$02 Decrease duration by one and loop back to #R$BF80 until counter is zero.
  $BF82,$01 #REGb=#REGa.
  $BF83,$01 Return.

w $BF84 Sprites Table
E $BF84 View the equivalent code in;
. #LIST
. { #COOKIE$7702 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$761A }
. { #TRANZAM$0000 }
. LIST#
@ $BF84 label=SpritesTable
  $BF84 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100)(#N((#PC - $BF84) / $02)) #SPRITENAME((#PC - $BF84) / $02).
L $BF84,$02,$C4

b $C10C Sprite: None
  $C10C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C10D,$01 Height = #N(#PEEK(#PC)) pixels.

b $C10E Sprite: Earwig
N $C10E Frame 1.
  $C10E,$01 Width = #N(#PEEK(#PC)) bytes.
  $C10F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C110,$36,$03 #GRAPHIC$C0(C0)

N $C146 Frame 2.
  $C146,$01 Width = #N(#PEEK(#PC)) bytes.
  $C147,$01 Height = #N(#PEEK(#PC)) pixels.
  $C148,$33,$03 #GRAPHIC$C1(C1)

N $C17B Frame 3.
  $C17B,$01 Width = #N(#PEEK(#PC)) bytes.
  $C17C,$01 Height = #N(#PEEK(#PC)) pixels.
  $C17D,$36,$03 #GRAPHIC$C2(C2)

N $C1B3 Frame 4.
  $C1B3,$01 Width = #N(#PEEK(#PC)) bytes.
  $C1B4,$01 Height = #N(#PEEK(#PC)) pixels.
  $C1B5,$33,$03 #GRAPHIC$C1(C3)

b $C1E8 Sprite: Flea
N $C1E8 Left Frame 1.
  $C1E8,$01 Width = #N(#PEEK(#PC)) bytes.
  $C1E9,$01 Height = #N(#PEEK(#PC)) pixels.
  $C1EA,$1C,$02 #GRAPHIC$BC(BC)

N $C206 Left Frame 2.
  $C206,$01 Width = #N(#PEEK(#PC)) bytes.
  $C207,$01 Height = #N(#PEEK(#PC)) pixels.
  $C208,$24,$02 #GRAPHIC$BD(BD)

N $C22C Right Frame 1.
  $C22C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C22D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C22E,$1C,$02 #GRAPHIC$BE(BE)

N $C24A Right Frame 2.
  $C24A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C24B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C24C,$24,$02 #GRAPHIC$BF(BF)

b $C270 Sprite: Skunk
N $C270 Left Frame 1.
  $C270,$01 Width = #N(#PEEK(#PC)) bytes.
  $C271,$01 Height = #N(#PEEK(#PC)) pixels.
  $C272,$3F,$03 #GRAPHIC$B8(B8)

N $C2B1 Left Frame 2.
  $C2B1,$01 Width = #N(#PEEK(#PC)) bytes.
  $C2B2,$01 Height = #N(#PEEK(#PC)) pixels.
  $C2B3,$3F,$03 #GRAPHIC$B9(B9)

N $C2F2 Right Frame 1.
  $C2F2,$01 Width = #N(#PEEK(#PC)) bytes.
  $C2F3,$01 Height = #N(#PEEK(#PC)) pixels.
  $C2F4,$3F,$03 #GRAPHIC$BA(BA)

N $C333 Right Frame 2.
  $C333,$01 Width = #N(#PEEK(#PC)) bytes.
  $C334,$01 Height = #N(#PEEK(#PC)) pixels.
  $C335,$3F,$03 #GRAPHIC$BB(BB)

b $C374 Attributes?

w $C386 Special Room (Game Completed)
D $C386 This is the room data showing on the Game Completed screen. See #R$9F6A.
D $C386 #UDGTABLE { #ROOM(#PC)(room-complete) } UDGTABLE#
@ $C386 label=Room_Special_Complete
  $C386,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $C388,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
  $C38A,$02 Terminator.

b $C38C Sprite: Bat
N $C38C Frame 1.
  $C38C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C38D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C38E,$22,$02 #GRAPHIC$68(68)

N $C3B0 Frame 2.
  $C3B0,$01 Width = #N(#PEEK(#PC)) bytes.
  $C3B1,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3B2,$1A,$02 #GRAPHIC$69(69)

N $C3CC Frame 1.
  $C3CC,$01 Width = #N(#PEEK(#PC)) bytes.
  $C3CD,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3CE,$22,$02 #GRAPHIC$6A(6A)

N $C3F0 Frame 2.
  $C3F0,$01 Width = #N(#PEEK(#PC)) bytes.
  $C3F1,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3F2,$1A,$02 #GRAPHIC$6B(6B)

b $C40C Sprite: Sabreman
E $C40C #UDGTABLE(default,centre)
. { =h Down | =h Up | =h Left (fighting) | =h Right (fighting) }{
.   #UDGARRAY*1C,25;1D;1E;1D(sabreman-down) |
.   #UDGARRAY*18,25;19;1A;19(sabreman-up) |
.   #UDGARRAY*20,25;21;22;23;24;23;26;21(sabreman-left-fighting) |
.   #UDGARRAY*28,25;29;2A;2B;2C;2B;2D;29(sabreman-right-fighting)
. }
. UDGTABLE#
N $C40C Up Frame 1.
  $C40C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C40D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C40E,$2A,$02 #GRAPHIC$18(18*)

N $C438 Up Frame 2.
  $C438,$01 Width = #N(#PEEK(#PC)) bytes.
  $C439,$01 Height = #N(#PEEK(#PC)) pixels.
  $C43A,$2A,$02 #GRAPHIC$19(19*)

N $C464 Up Frame 3.
  $C464,$01 Width = #N(#PEEK(#PC)) bytes.
  $C465,$01 Height = #N(#PEEK(#PC)) pixels.
  $C466,$2A,$02 #GRAPHIC$1A(1A*)

N $C490 Down Frame 1.
  $C490,$01 Width = #N(#PEEK(#PC)) bytes.
  $C491,$01 Height = #N(#PEEK(#PC)) pixels.
  $C492,$2A,$02 #GRAPHIC$1C(1C*)

N $C4BC Down Frame 2.
  $C4BC,$01 Width = #N(#PEEK(#PC)) bytes.
  $C4BD,$01 Height = #N(#PEEK(#PC)) pixels.
  $C4BE,$2A,$02 #GRAPHIC$1D(1D*)

N $C4E8 Down Frame 3.
  $C4E8,$01 Width = #N(#PEEK(#PC)) bytes.
  $C4E9,$01 Height = #N(#PEEK(#PC)) pixels.
  $C4EA,$2A,$02 #GRAPHIC$1E(1E*)

N $C514 Left Frame 1.
  $C514,$01 Width = #N(#PEEK(#PC)) bytes.
  $C515,$01 Height = #N(#PEEK(#PC)) pixels.
  $C516,$2A,$02 #GRAPHIC$10(10*)

N $C540 Left Frame 2.
  $C540,$01 Width = #N(#PEEK(#PC)) bytes.
  $C541,$01 Height = #N(#PEEK(#PC)) pixels.
  $C542,$2C,$02 #GRAPHIC$11(11*)

N $C56E Left Frame 3.
  $C56E,$01 Width = #N(#PEEK(#PC)) bytes.
  $C56F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C570,$2A,$02 #GRAPHIC$12(12*)

N $C59A Left Fighting Frame 1.
  $C59A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C59B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C59C,$3F,$03 #GRAPHIC$20(20*)

N $C5DB Left Fighting Frame 2.
  $C5DB,$01 Width = #N(#PEEK(#PC)) bytes.
  $C5DC,$01 Height = #N(#PEEK(#PC)) pixels.
  $C5DD,$3F,$03 #GRAPHIC$21(21*)

N $C61C Left Fighting Frame 3.
  $C61C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C61D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C61E,$3F,$03 #GRAPHIC$22(22*)

N $C65D Left Fighting Frame 4.
  $C65D,$01 Width = #N(#PEEK(#PC)) bytes.
  $C65E,$01 Height = #N(#PEEK(#PC)) pixels.
  $C65F,$3F,$03 #GRAPHIC$23(23*)

N $C69E Left Fighting Frame 5.
  $C69E,$01 Width = #N(#PEEK(#PC)) bytes.
  $C69F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6A0,$3F,$03 #GRAPHIC$24(24*)

N $C6DF Left Fighting Frame 6.
  $C6DF,$01 Width = #N(#PEEK(#PC)) bytes.
  $C6E0,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6E1,$3F,$03 #GRAPHIC$26(26*)

N $C720 Right Frame 1.
  $C720,$01 Width = #N(#PEEK(#PC)) bytes.
  $C721,$01 Height = #N(#PEEK(#PC)) pixels.
  $C722,$2A,$02 #GRAPHIC$14(14*)

N $C74C Right Frame 2.
  $C74C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C74D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C74E,$2A,$02 #GRAPHIC$15(15*)

N $C77A Right Frame 3.
  $C77A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C77B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C77C,$2A,$02 #GRAPHIC$16(16*)

N $C7A6 Right Fighting Frame 1.
  $C7A6,$01 Width = #N(#PEEK(#PC)) bytes.
  $C7A7,$01 Height = #N(#PEEK(#PC)) pixels.
  $C7A8,$3F,$03 #GRAPHIC$28(28*)

N $C7E7 Right Fighting Frame 2.
  $C7E7,$01 Width = #N(#PEEK(#PC)) bytes.
  $C7E8,$01 Height = #N(#PEEK(#PC)) pixels.
  $C7E9,$3F,$03 #GRAPHIC$29(29*)

N $C828 Right Fighting Frame 3.
  $C828,$01 Width = #N(#PEEK(#PC)) bytes.
  $C829,$01 Height = #N(#PEEK(#PC)) pixels.
  $C82A,$3F,$03 #GRAPHIC$2A(2A*)

N $C869 Right Fighting Frame 4.
  $C869,$01 Width = #N(#PEEK(#PC)) bytes.
  $C86A,$01 Height = #N(#PEEK(#PC)) pixels.
  $C86B,$3F,$03 #GRAPHIC$2B(2B*)

N $C8AA Right Fighting Frame 5.
  $C8AA,$01 Width = #N(#PEEK(#PC)) bytes.
  $C8AB,$01 Height = #N(#PEEK(#PC)) pixels.
  $C8AC,$3F,$03 #GRAPHIC$2C(2C*)

N $C8EB Right Fighting Frame 6.
  $C8EB,$01 Width = #N(#PEEK(#PC)) bytes.
  $C8EC,$01 Height = #N(#PEEK(#PC)) pixels.
  $C8ED,$3F,$03 #GRAPHIC$2D(2D*)

b $C92C Sprite: Rhino
E $C92C #UDGTABLE(default,centre)
. { =h Left | =h Right }{
.   #UDGARRAY*31,25;30(rhino-left) |
.   #UDGARRAY*33,25;32(rhino-right)
. }
. UDGTABLE#
N $C92C Left Frame 1.
  $C92C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C92D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C92E,$4C,$04 #GRAPHIC$31(31*)

N $C97A Left Frame 2.
  $C97A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C97B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C97C,$4C,$04 #GRAPHIC$30(30*)

N $C9C8 Right Frame 1.
  $C9C8,$01 Width = #N(#PEEK(#PC)) bytes.
  $C9C9,$01 Height = #N(#PEEK(#PC)) pixels.
  $C9CA,$4C,$04 #GRAPHIC$33(33*)

N $CA16 Right Frame 2.
  $CA16,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA17,$01 Height = #N(#PEEK(#PC)) pixels.
  $CA18,$4C,$04 #GRAPHIC$32(32*)

b $CA64 Sprite: Hippo Sleeping
  $CA64,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA65,$01 Height = #N(#PEEK(#PC)) pixels.
  $CA66,$48,$03 #GRAPHIC$A4(A4)

b $CAAE Sprite: Hippo
N $CAAE Left Frame 1.
  $CAAE,$01 Width = #N(#PEEK(#PC)) bytes.
  $CAAF,$01 Height = #N(#PEEK(#PC)) pixels.
  $CAB0,$48,$04 #GRAPHIC$A0(A0)

N $CAF8 Left Frame 2.
  $CAF8,$01 Width = #N(#PEEK(#PC)) bytes.
  $CAF9,$01 Height = #N(#PEEK(#PC)) pixels.
  $CAFA,$4C,$04 #GRAPHIC$A1(A1)

N $CB46 Right Frame 1.
  $CB46,$01 Width = #N(#PEEK(#PC)) bytes.
  $CB47,$01 Height = #N(#PEEK(#PC)) pixels.
  $CB48,$48,$04 #GRAPHIC$A2(A2)

N $CB90 Right Frame 2.
  $CB90,$01 Width = #N(#PEEK(#PC)) bytes.
  $CB91,$01 Height = #N(#PEEK(#PC)) pixels.
  $CB92,$4C,$04 #GRAPHIC$A3(A3)

b $CBDE Sprite: Tribesman
N $CBDE Left Frame 1.
  $CBDE,$01 Width = #N(#PEEK(#PC)) bytes.
  $CBDF,$01 Height = #N(#PEEK(#PC)) pixels.
  $CBE0,$2E,$02 #GRAPHIC$38(38)

N $CC0E Left Frame 2.
  $CC0E,$01 Width = #N(#PEEK(#PC)) bytes.
  $CC0F,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC10,$2E,$02 #GRAPHIC$39(39)

N $CC3E Left Frame 3.
  $CC3E,$01 Width = #N(#PEEK(#PC)) bytes.
  $CC3F,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC40,$2E,$02 #GRAPHIC$3A(3A)

N $CC6E Left Frame 4.
  $CC6E,$01 Width = #N(#PEEK(#PC)) bytes.
  $CC6F,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC70,$2E,$02 #GRAPHIC$3B(3B)

N $CC9E Right Frame 1.
  $CC9E,$01 Width = #N(#PEEK(#PC)) bytes.
  $CC9F,$01 Height = #N(#PEEK(#PC)) pixels.
  $CCA0,$2E,$02 #GRAPHIC$3C(3C)

N $CCCE Right Frame 2.
  $CCCE,$01 Width = #N(#PEEK(#PC)) bytes.
  $CCCF,$01 Height = #N(#PEEK(#PC)) pixels.
  $CCD0,$2E,$02 #GRAPHIC$3D(3D)

b $CCFE Sprite: Spider
N $CCFE Left Frame 1.
  $CCFE,$01 Width = #N(#PEEK(#PC)) bytes.
  $CCFF,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD00,$3F,$03 #GRAPHIC$60(60)

N $CD3F Left Frame 2.
  $CD3F,$01 Width = #N(#PEEK(#PC)) bytes.
  $CD40,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD41,$42,$03 #GRAPHIC$61(61)

N $CD83 Right Frame 1.
  $CD83,$01 Width = #N(#PEEK(#PC)) bytes.
  $CD84,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD85,$3F,$03 #GRAPHIC$62(62)

N $CDC4 Right Frame 2.
  $CDC4,$01 Width = #N(#PEEK(#PC)) bytes.
  $CDC5,$01 Height = #N(#PEEK(#PC)) pixels.
  $CDC6,$42,$03 #GRAPHIC$63(63)

b $CE08 Sprite: Scorpion
N $CE08 Left Frame 1.
  $CE08,$01 Width = #N(#PEEK(#PC)) bytes.
  $CE09,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE0A,$3F,$03 #GRAPHIC$64(64)

N $CE49 Left Frame 2.
  $CE49,$01 Width = #N(#PEEK(#PC)) bytes.
  $CE4A,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE4B,$3C,$03 #GRAPHIC$65(65)

N $CE87 Right Frame 1.
  $CE87,$01 Width = #N(#PEEK(#PC)) bytes.
  $CE88,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE89,$3F,$03 #GRAPHIC$66(66)

N $CEC8 Right Frame 2.
  $CEC8,$01 Width = #N(#PEEK(#PC)) bytes.
  $CEC9,$01 Height = #N(#PEEK(#PC)) pixels.
  $CECA,$3C,$03 #GRAPHIC$67(67)

b $CF06 Sprite: Wulf
N $CF06 Left Frame 1.
  $CF06,$01 Width = #N(#PEEK(#PC)) bytes.
  $CF07,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF08,$5C,$04 #GRAPHIC$50(50)

N $CF64 Left Frame 2.
  $CF64,$01 Width = #N(#PEEK(#PC)) bytes.
  $CF65,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF66,$5C,$04 #GRAPHIC$51(51)

N $CFC2 Left Frame 3.
  $CFC2,$01 Width = #N(#PEEK(#PC)) bytes.
  $CFC3,$01 Height = #N(#PEEK(#PC)) pixels.
  $CFC4,$5C,$04 #GRAPHIC$52(52)

N $D020 Right Frame 1.
  $D020,$01 Width = #N(#PEEK(#PC)) bytes.
  $D021,$01 Height = #N(#PEEK(#PC)) pixels.
  $D022,$5C,$04 #GRAPHIC$54(54)

N $D07E Right Frame 2.
  $D07E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D07F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D080,$5C,$04 #GRAPHIC$55(55)

N $D0DC Right Frame 3.
  $D0DC,$01 Width = #N(#PEEK(#PC)) bytes.
  $D0DD,$01 Height = #N(#PEEK(#PC)) pixels.
  $D0DE,$5C,$04 #GRAPHIC$56(56)

N $D13A Pounce Left Frame 1.
  $D13A,$01 Width = #N(#PEEK(#PC)) bytes.
  $D13B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D13C,$40,$04 #GRAPHIC$58(58)

N $D17C Pounce Right Frame 1.
  $D17C,$01 Width = #N(#PEEK(#PC)) bytes.
  $D17D,$01 Height = #N(#PEEK(#PC)) pixels.
  $D17E,$40,$04 #GRAPHIC$5C(5C)

N $D1BE Pounce Left Frame 2.
  $D1BE,$01 Width = #N(#PEEK(#PC)) bytes.
  $D1BF,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1C0,$60,$04 #GRAPHIC$59(59)

N $D220 Pounce Right Frame 2.
  $D220,$01 Width = #N(#PEEK(#PC)) bytes.
  $D221,$01 Height = #N(#PEEK(#PC)) pixels.
  $D222,$60,$04 #GRAPHIC$5D(5D)

b $D282 Sabreman: Attacked
N $D282 Flying Left.
  $D282,$01 Width = #N(#PEEK(#PC)) bytes.
  $D283,$01 Height = #N(#PEEK(#PC)) pixels.
  $D284,$2C,$02 #GRAPHIC$40(40)

N $D2B0 Sitting Left.
  $D2B0,$01 Width = #N(#PEEK(#PC)) bytes.
  $D2B1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2B2,$24,$02 #GRAPHIC$41(41)

N $D2D6 Dead Left.
  $D2D6,$01 Width = #N(#PEEK(#PC)) bytes.
  $D2D7,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2D8,$24,$03 #GRAPHIC$42(42)

N $D2FC Flying Right.
  $D2FC,$01 Width = #N(#PEEK(#PC)) bytes.
  $D2FD,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2FE,$2C,$02 #GRAPHIC$44(44)

N $D32A Sitting Right.
  $D32A,$01 Width = #N(#PEEK(#PC)) bytes.
  $D32B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D32C,$24,$02 #GRAPHIC$45(45)

N $D350 Dead Right.
  $D350,$01 Width = #N(#PEEK(#PC)) bytes.
  $D351,$01 Height = #N(#PEEK(#PC)) pixels.
  $D352,$24,$03 #GRAPHIC$46(46)

b $D376 Sprite: Orchid
N $D376 Frame 1.
  $D376,$01 Width = #N(#PEEK(#PC)) bytes.
  $D377,$01 Height = #N(#PEEK(#PC)) pixels.
  $D378,$06,$02 #GRAPHIC$48(48)

N $D37E Frame 2.
  $D37E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D37F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D380,$06,$02 #GRAPHIC$49(49)

N $D386 Frame 3.
  $D386,$01 Width = #N(#PEEK(#PC)) bytes.
  $D387,$01 Height = #N(#PEEK(#PC)) pixels.
  $D388,$0A,$02 #GRAPHIC$4A(4A)

N $D392 Frame 4.
  $D392,$01 Width = #N(#PEEK(#PC)) bytes.
  $D393,$01 Height = #N(#PEEK(#PC)) pixels.
  $D394,$0C,$02 #GRAPHIC$4B(4B)

N $D3A0 Frame 5.
  $D3A0,$01 Width = #N(#PEEK(#PC)) bytes.
  $D3A1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D3A2,$10,$02 #GRAPHIC$4C(4C)

N $D3B2 Frame 6.
  $D3B2,$01 Width = #N(#PEEK(#PC)) bytes.
  $D3B3,$01 Height = #N(#PEEK(#PC)) pixels.
  $D3B4,$16,$02 #GRAPHIC$4D(4D)

N $D3CA Frame 7.
  $D3CA,$01 Width = #N(#PEEK(#PC)) bytes.
  $D3CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $D3CC,$1A,$02 #GRAPHIC$4E(4E)

N $D3E6 Frame 8.
  $D3E6,$01 Width = #N(#PEEK(#PC)) bytes.
  $D3E7,$01 Height = #N(#PEEK(#PC)) pixels.
  $D3E8,$30,$03 #GRAPHIC$4F(4F)

b $D418 Sprite: Parrot
N $D418 Left Frame 1.
  $D418,$01 Width = #N(#PEEK(#PC)) bytes.
  $D419,$01 Height = #N(#PEEK(#PC)) pixels.
  $D41A,$26,$02 #GRAPHIC$6C(6C)

N $D440 Left Frame 2.
  $D440,$01 Width = #N(#PEEK(#PC)) bytes.
  $D441,$01 Height = #N(#PEEK(#PC)) pixels.
  $D442,$26,$02 #GRAPHIC$6D(6D)

N $D468 Right Frame 1.
  $D468,$01 Width = #N(#PEEK(#PC)) bytes.
  $D469,$01 Height = #N(#PEEK(#PC)) pixels.
  $D46A,$26,$02 #GRAPHIC$6E(6E)

N $D490 Right Frame 2.
  $D490,$01 Width = #N(#PEEK(#PC)) bytes.
  $D491,$01 Height = #N(#PEEK(#PC)) pixels.
  $D492,$26,$02 #GRAPHIC$6F(6F)

b $D4B8 Sprite: Monkey
N $D4B8 Left Frame 1.
  $D4B8,$01 Width = #N(#PEEK(#PC)) bytes.
  $D4B9,$01 Height = #N(#PEEK(#PC)) pixels.
  $D4BA,$2A,$02 #GRAPHIC$70(70)

N $D4E4 Left Frame 2.
  $D4E4,$01 Width = #N(#PEEK(#PC)) bytes.
  $D4E5,$01 Height = #N(#PEEK(#PC)) pixels.
  $D4E6,$28,$02 #GRAPHIC$71(71)

N $D50E Right Frame 1.
  $D50E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D50F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D510,$2A,$02 #GRAPHIC$72(72)

N $D53A Right Frame 2.
  $D53A,$01 Width = #N(#PEEK(#PC)) bytes.
  $D53B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D53C,$28,$02 #GRAPHIC$73(73)

b $D564 Sprite: Lizard
N $D564 Left Frame 1.
  $D564,$01 Width = #N(#PEEK(#PC)) bytes.
  $D565,$01 Height = #N(#PEEK(#PC)) pixels.
  $D566,$27,$03 #GRAPHIC$74(74)

N $D58D Left Frame 2.
  $D58D,$01 Width = #N(#PEEK(#PC)) bytes.
  $D58E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D58F,$2A,$03 #GRAPHIC$75(75)

N $D5B9 Right Frame 1.
  $D5B9,$01 Width = #N(#PEEK(#PC)) bytes.
  $D5BA,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5BB,$2A,$03 #GRAPHIC$76(76)

N $D5E5 Right Frame 2.
  $D5E5,$01 Width = #N(#PEEK(#PC)) bytes.
  $D5E6,$01 Height = #N(#PEEK(#PC)) pixels.
  $D5E7,$27,$03 #GRAPHIC$77(77)

b $D60E Sprite: Snake
N $D60E Left Frame 1.
  $D60E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D60F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D610,$27,$03 #GRAPHIC$78(78)

N $D637 Left Frame 2.
  $D637,$01 Width = #N(#PEEK(#PC)) bytes.
  $D638,$01 Height = #N(#PEEK(#PC)) pixels.
  $D639,$21,$03 #GRAPHIC$79(79)

N $D65A Right Frame 1.
  $D65A,$01 Width = #N(#PEEK(#PC)) bytes.
  $D65B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D65C,$21,$03 #GRAPHIC$7A(7A)

N $D67D Right Frame 2.
  $D67D,$01 Width = #N(#PEEK(#PC)) bytes.
  $D67E,$01 Height = #N(#PEEK(#PC)) pixels.
  $D67F,$27,$03 #GRAPHIC$7B(7B)

b $D6A6 Table: Orchid Positions
@ $D6A6 label=TableOrchidPositions
  $D6A6,$60,$02

b $D706 Sprite: Explosion
N $D706 Frame 1.
  $D706,$01 Width = #N(#PEEK(#PC)) bytes.
  $D707,$01 Height = #N(#PEEK(#PC)) pixels.
  $D708,$3F,$03 #GRAPHIC$0D(0D)

N $D747 Frame 2.
  $D747,$01 Width = #N(#PEEK(#PC)) bytes.
  $D748,$01 Height = #N(#PEEK(#PC)) pixels.
  $D749,$45,$03 #GRAPHIC$08(08)

N $D78E Frame 3.
  $D78E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D78F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D790,$48,$03 #GRAPHIC$09(09)

N $D7D8 Frame 4.
  $D7D8,$01 Width = #N(#PEEK(#PC)) bytes.
  $D7D9,$01 Height = #N(#PEEK(#PC)) pixels.
  $D7DA,$48,$03 #GRAPHIC$0A(0A)

b $D822 Sprite: Appearing
N $D822 Frame 1.
  $D822,$01 Width = #N(#PEEK(#PC)) bytes.
  $D823,$01 Height = #N(#PEEK(#PC)) pixels.
  $D824,$2A,$03 #GRAPHIC$01(01)

N $D84E Frame 2.
  $D84E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D84F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D850,$39,$03 #GRAPHIC$02(02)

N $D889 Frame 3.
  $D889,$01 Width = #N(#PEEK(#PC)) bytes.
  $D88A,$01 Height = #N(#PEEK(#PC)) pixels.
  $D88B,$45,$03 #GRAPHIC$03(03)

N $D8D0 Frame 4.
  $D8D0,$01 Width = #N(#PEEK(#PC)) bytes.
  $D8D1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8D2,$45,$03 #GRAPHIC$04(04)

N $D917 Frame 5.
  $D917,$01 Width = #N(#PEEK(#PC)) bytes.
  $D918,$01 Height = #N(#PEEK(#PC)) pixels.
  $D919,$45,$03 #GRAPHIC$05(05)

N $D95E Frame 6.
  $D95E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D95F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D960,$39,$03 #GRAPHIC$06(06)

b $D999 Sprite: Crate
  $D999,$01 Width = #N(#PEEK(#PC)) bytes.
  $D99A,$01 Height = #N(#PEEK(#PC)) pixels.
  $D99B,$20,$02 #GRAPHIC$80(80)

b $D9BB Sprite: Ring
  $D9BB,$01 Width = #N(#PEEK(#PC)) bytes.
  $D9BC,$01 Height = #N(#PEEK(#PC)) pixels.
  $D9BD,$20,$02 #GRAPHIC$81(ring)

b $D9DD Sprite: Fruit
  $D9DD,$01 Width = #N(#PEEK(#PC)) bytes.
  $D9DE,$01 Height = #N(#PEEK(#PC)) pixels.
  $D9DF,$20,$02 #GRAPHIC$82(82)

b $D9FF Sprite: Cap
  $D9FF,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA00,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA01,$20,$02 #GRAPHIC$83(83)

b $DA21 Sprite: Shield
  $DA21,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA22,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA23,$20,$02 #GRAPHIC$84(84)

b $DA43 Sprite: Life
  $DA43,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA44,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA45,$20,$02 #GRAPHIC$85(85)

b $DA65 Sprite: Money Bag
  $DA65,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA66,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA67,$20,$02 #GRAPHIC$86(86)

b $DA87 Sprite: Sword
  $DA87,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA88,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA89,$20,$02 #GRAPHIC$87(87)

b $DAA9 Sprite: Unused?
N $DAA9 Not in the sprite table.
  $DAA9,$01 Width = #N(#PEEK(#PC)) bytes.
  $DAAA,$01 Height = #N(#PEEK(#PC)) pixels.
  $DAAB,$20,$02 #NOCROP(#PC,$02,$10,$07)(unused-01)

N $DACB Not in the sprite table.
  $DACB,$01 Width = #N(#PEEK(#PC)) bytes.
  $DACC,$01 Height = #N(#PEEK(#PC)) pixels.
  $DACD,$20,$02 #NOCROP(#PC,$02,$10,$07)(unused-02)

N $DAED Not in the sprite table.
  $DAED,$01 Width = #N(#PEEK(#PC)) bytes.
  $DAEE,$01 Height = #N(#PEEK(#PC)) pixels.
  $DAEF,$1C,$02 #CROP(#PC,$02,$0E,$07)(unused-03)

b $DB0B Sprite: Sleeping Warthog
  $DB0B,$01 Width = #N(#PEEK(#PC)) bytes.
  $DB0C,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB0D,$3F,$03 #GRAPHIC$AC(AC)

b $DB4C Sprite: Warthog
N $DB4C Left Frame 1.
  $DB4C,$01 Width = #N(#PEEK(#PC)) bytes.
  $DB4D,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB4E,$44,$04 #GRAPHIC$A8(A8)

N $DB92 Right Frame 1.
  $DB92,$01 Width = #N(#PEEK(#PC)) bytes.
  $DB93,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB94,$48,$04 #GRAPHIC$AA(AA)

N $DBDC Right Frame 2.
  $DBDC,$01 Width = #N(#PEEK(#PC)) bytes.
  $DBDD,$01 Height = #N(#PEEK(#PC)) pixels.
  $DBDE,$44,$04 #GRAPHIC$AB(AB)

N $DC22 Left Frame 2.
  $DC22,$01 Width = #N(#PEEK(#PC)) bytes.
  $DC23,$01 Height = #N(#PEEK(#PC)) pixels.
  $DC24,$48,$04 #GRAPHIC$A9(A9)

b $DC6C Object Location Table
@ $DC6C label=ObjectLocation
  $DC6C,$08,$02 X/ Y position.

b $DC74

b $E1EC Background Graphic Game Completed
D $E1EC #BG(#PC)(background-complete)
N $E1EC Pixels.
  $E1EC,$01 Height = #N(#PEEK(#PC)) pixels.
  $E1ED,$01 Width = #N(#PEEK(#PC)) bytes.
  $E1EE,$180,$08 Pixel data.
N $E36E Attributes.
  $E36E,$01 Height = #N(#PEEK(#PC)) bytes.
  $E36F,$01 Width = #N(#PEEK(#PC)) bytes.
  $E370,$30,$08 Attribute data.

b $E3A0 Graphic: Amulet Outline
D $E3A0 #UDGTABLE(default,centre,centre)
. { #BG($E3A0)(outline-01) | #BG($E494)(outline-02) }
. { #BG($E588)(outline-03) | #BG($E67C)(outline-04) }
. UDGTABLE#
N $E3A0 Pixels.
  $E3A0,$01 Height = #N(#PEEK(#PC)) pixels.
  $E3A1,$01 Width = #N(#PEEK(#PC)) bytes.
  $E3A2,$C0,$06 Pixel data.

N $E462 Pixels.
  $E462,$01 Height = #N(#PEEK(#PC)) pixels.
  $E463,$01 Width = #N(#PEEK(#PC)) bytes.
  $E464,$18,$06 Pixel data.
N $E47C Attributes.
  $E47C,$18,$08 Attribute data.

N $E494 Pixels.
  $E494,$01 Height = #N(#PEEK(#PC)) pixels.
  $E495,$01 Width = #N(#PEEK(#PC)) bytes.
  $E496,$C0,$06 Pixel data.

N $E556 Pixels.
  $E556,$01 Height = #N(#PEEK(#PC)) pixels.
  $E557,$01 Width = #N(#PEEK(#PC)) bytes.
  $E558,$18,$06 Pixel data.
N $E570 Attributes.
  $E570,$18,$08 Attribute data.

N $E588 Pixels.
  $E588,$01 Height = #N(#PEEK(#PC)) pixels.
  $E589,$01 Width = #N(#PEEK(#PC)) bytes.
  $E58A,$C0,$06 Pixel data.

N $E64A Pixels.
  $E64A,$01 Height = #N(#PEEK(#PC)) pixels.
  $E64B,$01 Width = #N(#PEEK(#PC)) bytes.
  $E64C,$18,$06 Pixel data.
N $E664 Attributes.
  $E664,$18,$08 Attribute data.

N $E67C Pixels.
  $E67C,$01 Height = #N(#PEEK(#PC)) pixels.
  $E67D,$01 Width = #N(#PEEK(#PC)) bytes.
  $E67E,$C0,$06 Pixel data.

N $E73E Pixels.
  $E73E,$01 Height = #N(#PEEK(#PC)) pixels.
  $E73F,$01 Width = #N(#PEEK(#PC)) bytes.
  $E740,$18,$06 Pixel data.
N $E758 Attributes.
  $E758,$18,$08 Attribute data.

b $E770 Graphic: Amulet
D $E770 #UDGTABLE(default,centre,centre)
. { #GRAPHIC$93(93) | #GRAPHIC$92(92) }
. { #GRAPHIC$91(91) | #GRAPHIC$90(90) }
. UDGTABLE#
N $E770 Top Left.
  $E770,$01 Width = #N(#PEEK(#PC)) bytes.
  $E771,$01 Height = #N(#PEEK(#PC)) pixels.
  $E772,$20,$02 #GRAPHIC$93(93)

N $E792 Top Right.
  $E792,$01 Width = #N(#PEEK(#PC)) bytes.
  $E793,$01 Height = #N(#PEEK(#PC)) pixels.
  $E794,$20,$02 #GRAPHIC$92(92)

N $E7B4 Bottom Left.
  $E7B4,$01 Width = #N(#PEEK(#PC)) bytes.
  $E7B5,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7B6,$20,$02 #GRAPHIC$91(91)

N $E7D6 Bottom Right.
  $E7D6,$01 Width = #N(#PEEK(#PC)) bytes.
  $E7D7,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7D8,$20,$02 #GRAPHIC$90(90)

b $E7F8 Sprite: The Guardian
N $E7F8 Frame 1.
  $E7F8,$01 Width = #N(#PEEK(#PC)) bytes.
  $E7F9,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7FA,$80,$04 #GRAPHIC$94(94*)

N $E87A Frame 2.
  $E87A,$01 Width = #N(#PEEK(#PC)) bytes.
  $E87B,$01 Height = #N(#PEEK(#PC)) pixels.
  $E87C,$80,$04 #GRAPHIC$95(95*)

b $E8FC Sprite: Flame
N $E8FC Frame 1.
  $E8FC,$01 Width = #N(#PEEK(#PC)) bytes.
  $E8FD,$01 Height = #N(#PEEK(#PC)) pixels.
  $E8FE,$2C,$02 #GRAPHIC$34(34*)

N $E92A Frame 2.
  $E92A,$01 Width = #N(#PEEK(#PC)) bytes.
  $E92B,$01 Height = #N(#PEEK(#PC)) pixels.
  $E92C,$2C,$02 #GRAPHIC$35(35*)

N $E958 Frame 3.
  $E958,$01 Width = #N(#PEEK(#PC)) bytes.
  $E959,$01 Height = #N(#PEEK(#PC)) pixels.
  $E95A,$2E,$02 #GRAPHIC$36(36*)

N $E988 Frame 4.
  $E988,$01 Width = #N(#PEEK(#PC)) bytes.
  $E989,$01 Height = #N(#PEEK(#PC)) pixels.
  $E98A,$2E,$02 #GRAPHIC$37(37*)

b $E9B8 Sprite: Rat
N $E9B8 Left Frame 1.
  $E9B8,$01 Width = #N(#PEEK(#PC)) bytes.
  $E9B9,$01 Height = #N(#PEEK(#PC)) pixels.
  $E9BA,$1B,$03 #GRAPHIC$98(98)

N $E9D5 Left Frame 2.
  $E9D5,$01 Width = #N(#PEEK(#PC)) bytes.
  $E9D6,$01 Height = #N(#PEEK(#PC)) pixels.
  $E9D7,$1B,$03 #GRAPHIC$99(99)

N $E9F2 Right Frame 1.
  $E9F2,$01 Width = #N(#PEEK(#PC)) bytes.
  $E9F3,$01 Height = #N(#PEEK(#PC)) pixels.
  $E9F4,$1B,$03 #GRAPHIC$9A(9A)

N $EA0F Right Frame 2.
  $EA0F,$01 Width = #N(#PEEK(#PC)) bytes.
  $EA10,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA11,$1B,$03 #GRAPHIC$9B(9B)

b $EA2C Sprite: Bird
N $EA2C Left Frame 1.
  $EA2C,$01 Width = #N(#PEEK(#PC)) bytes.
  $EA2D,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA2E,$36,$03 #GRAPHIC$9C(9C)

N $EA64 Left Frame 2.
  $EA64,$01 Width = #N(#PEEK(#PC)) bytes.
  $EA65,$01 Height = #N(#PEEK(#PC)) pixels.
  $EA66,$42,$03 #GRAPHIC$9D(9D)

N $EAA8 Right Frame 1.
  $EAA8,$01 Width = #N(#PEEK(#PC)) bytes.
  $EAA9,$01 Height = #N(#PEEK(#PC)) pixels.
  $EAAA,$36,$03 #GRAPHIC$9E(9E)

N $EAE0 Right Frame 2.
  $EAE0,$01 Width = #N(#PEEK(#PC)) bytes.
  $EAE1,$01 Height = #N(#PEEK(#PC)) pixels.
  $EAE2,$42,$03 #GRAPHIC$9F(9F)

b $EB24 Sprite: Mosquito
N $EB24 Left Frame 1.
  $EB24,$01 Width = #N(#PEEK(#PC)) bytes.
  $EB25,$01 Height = #N(#PEEK(#PC)) pixels.
  $EB26,$20,$02 #GRAPHIC$B4(B4)

N $EB46 Left Frame 2.
  $EB46,$01 Width = #N(#PEEK(#PC)) bytes.
  $EB47,$01 Height = #N(#PEEK(#PC)) pixels.
  $EB48,$1C,$02 #GRAPHIC$B5(B5)

N $EB64 Right Frame 1.
  $EB64,$01 Width = #N(#PEEK(#PC)) bytes.
  $EB65,$01 Height = #N(#PEEK(#PC)) pixels.
  $EB66,$20,$02 #GRAPHIC$B6(B6)

N $EB86 Right Frame 1.
  $EB86,$01 Width = #N(#PEEK(#PC)) bytes.
  $EB87,$01 Height = #N(#PEEK(#PC)) pixels.
  $EB88,$1C,$02 #GRAPHIC$B7(B7)

b $EBA4 Sprite: Frog
N $EBA4 Left Frame 1.
  $EBA4,$01 Width = #N(#PEEK(#PC)) bytes.
  $EBA5,$01 Height = #N(#PEEK(#PC)) pixels.
  $EBA6,$24,$03 #GRAPHIC$B0(B0)

N $EBCA Left Frame 2.
  $EBCA,$01 Width = #N(#PEEK(#PC)) bytes.
  $EBCB,$01 Height = #N(#PEEK(#PC)) pixels.
  $EBCC,$1E,$03 #GRAPHIC$B1(B1)

N $EBEA Right Frame 1.
  $EBEA,$01 Width = #N(#PEEK(#PC)) bytes.
  $EBEB,$01 Height = #N(#PEEK(#PC)) pixels.
  $EBEC,$24,$03 #GRAPHIC$B2(B2)

N $EC10 Right Frame 2.
  $EC10,$01 Width = #N(#PEEK(#PC)) bytes.
  $EC11,$01 Height = #N(#PEEK(#PC)) pixels.
  $EC12,$1E,$03 #GRAPHIC$B3(B3)

t $EC30
  $EC30,$2F

b $EC5F
