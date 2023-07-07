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

w $6166 Screen Table
@ $6166 label=ScreenTable
  $6166,$60,$10

w $61C6 Background Table
N $61C6 Background Table #N$01.
@ $61C6 label=BackgroundTable
  $61C6,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $61C8,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
  $61CA,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $61CC,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $61CA,$04,$0D
  $61FE,$02 Terminator.

N $6200 Background Table #N$02.
  $6200,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6202,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
  $6204,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6206,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6204,$04,$11
  $6248,$02 Terminator.

N $624A Background Table #N$03.
  $624A,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $624C,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
  $624E,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6250,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $624E,$04,$11
  $6292,$02 Terminator.

N $6294 Background Table #N$04.
  $6294,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6296,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
  $6298,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $629A,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6298,$04,$11
  $62DC,$02 Terminator.

N $62DE Background Table #N$05.
  $62DE,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $62E0,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
  $62E2,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $62E4,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $62E2,$04,$13
  $632E,$02 Terminator.

N $6330 Background Table #N$06.
  $6330,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6332,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
  $6334,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6336,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $6334,$04,$10
  $6374,$02 Terminator.

N $6376 Background Table #N$07.
  $6376,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $6378,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
  $637A,$02 Background graphic #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100).
B $637C,$02 X/ Y position = #N(#EVAL(#PEEK(#PC) / $08)) / #N(#EVAL(#PEEK(#PC + $01) / $08)).
L $637A,$04,$15
  $63CE,$02 Terminator.

N $63D0 Background Table #N$08.
  $63D0,$50,$10
  $6420,$02 Terminator.

N $6422 Background Table #N$09.
  $6422,$58,$10
  $647A,$02 Terminator.

N $647C Background Table #N$0A.
  $647C,$4C,$10
  $64C8,$02 Terminator.

N $64CA Background Table #N$0B.
  $64CA,$54,$10
  $651E,$02 Terminator.

N $6520 Background Table #N$0C.
  $6520,$64,$10
  $6584,$02 Terminator.

N $6586 Background Table #N$0D.
  $6586,$38,$10
  $65BE,$02 Terminator.

N $65C0 Background Table #N$0E.
  $65C0,$54,$10
  $6614,$02 Terminator.

N $6616 Background Table #N$0F.
  $6616,$54,$10
  $666A,$02 Terminator.

N $666C Background Table #N$10.
  $666C,$44,$10
  $66B0,$02 Terminator.

N $66B2 Background Table #N$11.
  $66B2,$68,$10
  $671A,$02 Terminator.

N $671C Background Table #N$12.
  $671C,$68,$10
  $6784,$02 Terminator.

N $6786 Background Table #N$13.
  $6786,$60,$10
  $67E6,$02 Terminator.

N $67E8 Background Table #N$14.
  $67E8,$34,$10
  $681C,$02 Terminator.

N $681E Background Table #N$15.
  $681E,$44,$10
  $6862,$02 Terminator.

N $6864 Background Table #N$16.
  $6864,$4C,$10
  $68B0,$02 Terminator.

N $68B2 Background Table #N$17.
  $68B2,$48,$10
  $68FA,$02 Terminator.

N $68FC Background Table #N$18.
  $68FC,$38,$10
  $6938,$02 Terminator.

N $693A Background Table #N$19.
  $693A,$48,$10
  $6986,$02 Terminator.

N $6988 Background Table #N$1A.
  $6988,$54,$10
  $69DC,$02 Terminator.

N $69DE Background Table #N$1B.
  $69DE,$58,$10
  $6A36,$02 Terminator.

N $6A38 Background Table #N$1C.
  $6A38,$44,$10
  $6A7C,$02 Terminator.

N $6A7E Background Table #N$1D.
  $6A7E,$44,$10
  $6AC2,$02 Terminator.

N $6AC4 Background Table #N$1E.
  $6AC4,$54,$10
  $6B18,$02 Terminator.

N $6B1A Background Table #N$1F.
  $6B1A,$54,$10
  $6B6E,$02 Terminator.

N $6B70 Background Table #N$20.
  $6B70,$48,$10
  $6BB8,$02 Terminator.

N $6BBA Background Table #N$21.
  $6BBA,$4C,$10
  $6C06,$02 Terminator.

N $6C08 Background Table #N$22.
  $6C08,$5C,$10
  $6C64,$02 Terminator.

N $6C66 Background Table #N$23.
  $6C66,$54,$10
  $6CBA,$02 Terminator.

N $6CBC Background Table #N$24.
  $6CBC,$50,$10
  $6D0C,$02 Terminator.

N $6D0E Background Table #N$25.
  $6D0E,$48,$10
  $6D56,$02 Terminator.

N $6D58 Background Table #N$26.
  $6D58,$58,$10
  $6DB0,$02 Terminator.

N $6DB2 Background Table #N$26.
  $6DB2,$5C,$10
  $6E0E,$02 Terminator.

N $6E10 Background Table #N$27.
  $6E10,$4C,$10
  $6E5C,$02 Terminator.

N $6E5E Background Table #N$28.
  $6E5E,$40,$10
  $6E9E,$02 Terminator.

N $6EA0 Background Table #N$29.
  $6EA0,$4C,$10
  $6EEC,$02 Terminator.

N $6EEE Background Table #N$2A.
  $6EEE,$44,$10
  $6F32,$02 Terminator.

N $6F34 Background Table #N$2B.
  $6F34,$38,$10
  $6F6C,$02 Terminator.

N $6F6E Background Table #N$2C.
  $6F6E,$40,$10
  $6FAE,$02 Terminator.

N $6FB0 Background Table #N$2D.
  $6FB0,$40,$10
  $6FF0,$02 Terminator.

N $6FF2 Background Table #N$2E.
  $6FF2,$3C,$10
  $702E,$02 Terminator.

N $7030 Background Table #N$2F.
  $7030,$44,$10
  $7074,$02 Terminator.

N $7076 Background Table #N$30.
  $7076,$44,$10
  $70BA,$02 Terminator.

b $70BC Background Graphics
  $70BC,$01 #LET(width=#PEEK(#PC)) Width = #N({width}) bytes.
  $70BD,$01 #LET(height=#PEEK(#PC)) Height = #N({height}) pixels.
  $70BE,$D8,$09 UDGARRAY#($02,attr=$07,scale=$04,step={width},flip=2)(background-01)
  $7196,$1D,$09 Attributes.

  $71B3
  $7298
  $72F6
  $7462
  $7523
  $771F
  $785E
  $78F2
  $7947
  $7981
  $7B11
  $7BB7
  $7C0C
  $7CCD
  $7E4B
  $7F40
  $8047
  $81C5
  $8382
  $83AA
  $83D2
  $8427
  $847C
  $8558
  $85C8
  $86DA
  $8702
  $872A
  $8806
  $89C3
  $8B80
  $8C5C
  $8CCC
  $8D3C
  $8E18
  $8F2A
  $90A8
  $93C4
  $955D
  $95CD
  $9673

b $9692

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

g $969E Current Player
@ $969E label=ActivePlayer
D $969E The currently active player.
. #TABLE(default,centre,centre)
. { =h Value | =h Player }
. { #N$00 | 1UP }
. { #N$01 | 2UP }
. TABLE#

g $96A8 Current Menu Item Colour attribute
@ $96A8 label=Current_MenuAttr
B $96A8,$01

b $96A9
  $96B4
  $96B7
W $96B8
  $96BA
  $96BC
  $96BD
  $96DF
  $9702
  $982E

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
  $9992,$03 #REGhl=#N$9698.
  $9995,$03 #REGbc=#N$02C2.
  $9998,$03 Call #R$BBA5.
  $999B,$03 Call #R$B5CC.
  $999E,$03 Call #R$B5D4.
  $99A1,$03 #REGde=#R$BD45.
  $99A4,$03 Call #R$BD6E.
  $99A7,$03 Call #R$B1D4.

w $9B3E Jump Table
@ $9B3E label=JumpTable
  $9B3E,$C4,$02

c $9CC6

b $9E5C
  $9E6C

c $9E72

c $9F6A Game Complete
@ $9F6A label=GameComplete
  $9F6A,$03 Call #R$BB7C.
  $9F6D,$03 Call #R$BB5C.
  $9F70,$03 #REGhl=#N$C386.
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
N $9F91 Congratulations messaging. #TABLE(default,centre,centre,centre)
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
@ $A01B label=Poem
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

b $A29D

c $A2BD

b $A3A7

c $A3B7

b $A41A

c $A42A

b $A6FD

c $A70D

b $A7F8

c $A858

c $AA6A Game Over
@ $AA6A label=GameOver_1UP
N $AA6A #HTML(Set up altering the "GAME OVER PLAYER <em>X</em>" message for 1UP.)
  $AA6A,c,$02 #REGa="1" + #N$80 (escape character).
N $AA6C Print the messaging and pause to show it for a period of time.
@ $AA6C label=GameOver_Write
  $AA6C,$03 Write ASCII player number to #R$AAC1(#N$AAD3).
  $AA6F,$03 Call #R$BB7C.
  $AA72,$03 Call #R$BB5C.
  $AA75,$03 #REGde=#R$AAD4.
  $AA78,$03 #REGhl=#N$7820.
  $AA7B,$03 Call #R$B53D.
  $AA7E,$03 #REGde=#R$AAC1.
  $AA81,$03 #REGhl=#N$6038.
  $AA84,$03 Call #R$B53D.
  $AA87,$03 Call #R$9CC6.
  $AA8A,$03 #REGde=#N$BD28.
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
@ $AAB9 label=GameOver_Restart
  $AAB9,$03 Jump to #R$998F.
@ $AABC label=GameOver_Restart2UP
  $AABC,$03 Call #R$AA98.
  $AABF,$02 Jump to #R$AAAD.

N $AAC1 Game Over Messaging
@ $AAC1 label=GameOver_Text
T $AAC1,$13,h$01,$11:$01 #HTML("GAME OVER PLAYER <em>X</em>" (#N(#PEEK(#PC)) is the attribute).)

b $AAD4 Adventure Completed Messaging
@ $AAD4 label=AdventureCompleted_Text
  $AAD4,$01 Attribute: #N(#PEEK(#PC)).
T $AAD5,$18,$17:$01 "#STR(#PC)".

c $AAED

b $AC24

c $AC28

b $AC77

c $AD07

c $B0D9 Controls: Kempston Joystick
@ $B0D9 label=ReadKempstonJoystick
R $B0D9 A Joystick controls
  $B0D9,$02 #REGa=controls.
  $B0F9,$01 Return.

c $B0FA
  $B0FA

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

c $B1D4
  $B204,$01 Return.

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
  $B23C,$03 #REGhl=#R$96BC
  $B23F,$03 #REGde=#R$96DF.
  $B242,$03 #REGbc=#N$0023 (counter).
  $B245,$03 Call #R$B25D.
  $B248,$03 #REGhl=#R$DDEC.
  $B24B,$03 #REGde=#R$DFEC.
  $B24E,$03 #REGbc=#N$0200 (counter).
  $B251,$03 Call #R$B25D.
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

c $B26B
  $B26B,$06 Write #N$0300 to #R$96B8.
  $B271,$01 Return.

c $B272

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

  $B2D8,$03 #REGhl=#N$58A4.
  $B2DB,$03 #REGbc=#N$1810.
  $B2DE,$03 #REGde=#N$0020.

  $B2EE,$03 #REGhl=#N$40A4.
  $B2F1,$03 #REGbc=#N$1880.

  $B303,$01 Return.

g $B304 High Score
E $B304 View the equivalent code in;
. #LIST
. { #JETPAC$5CF0 }
. { #LUNARJETMAN$5E06 }
. { #PSSST$5E00 }
. { #TRANZAM$5E49 }
. LIST#
D $B304 3-byte representation of the score.
@ $B304 label=HighScore_1
B $B304,$01 Byte #1.
@ $B305 label=HighScore_2
B $B305,$01 Byte #2.
@ $B306 label=HighScore_3
B $B306,$01 Byte #3.

b $B307
  $B322
@ $B32E label=HallOfFame_Attributes
  $B32E
@ $B336 label=HallOfFame_Position
  $B336
@ $B346 label=HallOfFame_Text
T $B346,$15,$14:$01 "#STR(#PC)".
T $B35B,$12,$11:$01 "#STR(#PC)".
T $B36D,$12,$11:$01 "#STR(#PC)".
T $B37F,$12,$11:$01 "#STR(#PC)".
T $B391,$12,$11:$01 "#STR(#PC)".
T $B3A3,$12,$11:$01 "#STR(#PC)".
T $B3B5,$12,$11:$01 "#STR(#PC)".
T $B3C7,$0E,$0D:$01 "#STR(#PC)".

c $B3D5
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

  $B423,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $B429,$01 Flip the bits.
  $B42A,$01 Store the result in #REGe.

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

c $B5FC
  $B5FC,$03 #REGhl=#R$9698.
  $B5FF,$03 #REGde=#R$969B.
  $B602,$03 Call #R$B6B2.
  $B605,$05 Write #N$00 to #R$96BA.
  $B60E,$01 Flip the bits.
  $B610,$03 Write #REGa to #R$969E.
  $B613,$03 Call #R$B61E.
  $B61A,$01 Flip the bits.
  $B622,$03 #REGde=#R$B322.
  $B625,$03 Call #R$B6B2.
  $B62A,$03 Call #R$B6AB.
  $B6C4,$01 Return.
T $B6C5,$03 "#STR(#PC,$04,$03)".
T $B6C8,$03 "#STR(#PC,$04,$03)".
T $B6CB,$03 "#STR(#PC,$04,$03)".
T $B6CE,$03 "#STR(#PC,$04,$03)".
T $B6D1,$03 "#STR(#PC,$04,$03)".
T $B6D4,$03 "#STR(#PC,$04,$03)".

  $B754,$01 Return.

b $B755
T $B76D,$0F,$0E:$01 "#STR(#PC)".
T $B77C,$08,$07:$01 "#STR(#PC)".
T $B784,$11,$10:$01 "#STR(#PC)".
T $B795,$12,$11:$01 "#STR(#PC)".
T $B7A7,$05,$04:$01 "#STR(#PC)".
T $B7AC,$0F,$0E:$01 "#STR(#PC)".
T $B7BB,$0D,$0C:$01 "#STR(#PC)".
T $B7C8,$05,$04:$01 "#STR(#PC)".

c $B7CD

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

c $B8CC

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

c $B8F5

c $B902
  $B902,$02 #REGl=#N$00.
  $B904,$02 #REGd=#N$00.
  $B906,$01
  $B907,$02 #REGh=#N$FF.
  $B909,$02 #REGb=#N$08.
  $B918,$01 Return.

c $B919

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
N $BB0B This is @todo.
  $BB0B,$06 Copy actor X position to active actor X position.
  $BB11,$06 Copy actor Y position to active actor Y position.
  $BB17,$06 Copy actor movement to active actor movement.
  $BB1D,$06 Copy actor movement to active actor movement.
  $BB23,$01 Return.

c $BB24

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

c $BB9F
  $BB9F,$03 #REGhl=#R$9692.
  $BBA2,$03 #REGbc=#N$02C8.
  $BBA5
  $BBAD,$01 Return.

c $BBAE
  $BBAE,$03 Call #R$A79F.
  $BBB1,$03 Call #R$A763.
  $BBB4,$03 Call #R$A33B.
  $BBB7,$03 Call #R$BBBB.
  $BBBA,$01 Return.

c $BBBB

b $BC67
  $BC77
  $BD33
  $BD45

c $BD51
  $BD51,$01 Disable interrupts.
  $BD61,$03 Jump to #R$B422.
  $BD6C,$02 Jump to #R$BD52.

c $BD6E
  $BD6E,$01 Disable interrupts.
@ $BD6F label=Loop
  $BD6F,$01 Fetch the next byte.
  $BD70,$04 If this is #N$FF (the terminator) then jump to #R$BD79.
  $BD74,$03 Call #R$BD7B.
  $BD77,$02 Jump to #R$BD6F.

N $BD79 Enable interrupts and return.
@ $BD79 label=EnableInterrupts
  $BD79,$01 Enable interrupts.
  $BD7A,$01 Return.

N $BD7B
  $BD7B,$02,b$01 Keep only bits 0-5.
  $BD7D,$02 If we're left with zero, jump to #R$BDBC.
  $BD7F,$03 Creates an offset using #REGh=$N$00 and #REGl=#REGa.
  $BD82,$06 #REGhl=#R$BDD2 + (offset * #N$04).
  $BD88,$04 #REGbc=the address held at #REGhl.
  $BD8C,$04 #REGa=.
  $BD90,$01 #REGa=.
  $BD93,$02,b$01 Keep only bits 0-1.
  $BD96,$01 Stash #REGde on the stack.
  $BDA1,$03 Set the border to black.
  $BDBB,$01 Return.
  $BDC0,$02,b$01 Keep only bits 0-1.
  $BDD1,$01 Return.

b $BDD2

c $BECC

b $BEDE

c $BF08

w $BF84 Sprite Table
@ $BF84 label=SpritesTable
  $BF84 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + $01) * $100)(#N((#PC - $BF84) / $02)) #SPRITENAME((#PC - $BF84) / $02).
L $BF84,$02,$C4

b $C10C
  $C10C,$01 Height = #N(#PEEK(#PC)) pixels.
  $C10D,$01

b $C10E
N $C10E Frame 1.
  $C10E,$01 Width = #N(#PEEK(#PC)) bytes.
  $C10F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C110,$36,$03 #GRAPHIC$C0(teleporter)

N $C146 Frame 2.
  $C146,$01 Width = #N(#PEEK(#PC)) bytes.
  $C147,$01 Height = #N(#PEEK(#PC)) pixels.
  $C148,$33,$03 #GRAPHIC$C1(c1)

N $C17B Frame 3.
  $C17B,$01 Width = #N(#PEEK(#PC)) bytes.
  $C17C,$01 Height = #N(#PEEK(#PC)) pixels.
  $C17D,$36,$03 #GRAPHIC$C2(c2)

N $C1B3 Frame 4.
  $C1B3,$01 Width = #N(#PEEK(#PC)) bytes.
  $C1B4,$01 Height = #N(#PEEK(#PC)) pixels.
  $C1B5,$33,$03 #GRAPHIC$C1(c3)

b $C1E8
  $C1E8,$01 Width = #N(#PEEK(#PC)) bytes.
  $C1E9,$01 Height = #N(#PEEK(#PC)) pixels.
  $C1EA,$1C,$02 #GRAPHIC$BC(bc)

N $C206
  $C206,$01 Width = #N(#PEEK(#PC)) bytes.
  $C207,$01 Height = #N(#PEEK(#PC)) pixels.
  $C208,$24,$02 #GRAPHIC$BD(bd)

N $C22C
  $C22C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C22D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C22E,$1C,$02 #GRAPHIC$BE(be)

N $C24A
  $C24A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C24B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C24C,$24,$02 #GRAPHIC$BF(bf)

b $C270
  $C270,$01 Width = #N(#PEEK(#PC)) bytes.
  $C271,$01 Height = #N(#PEEK(#PC)) pixels.
  $C272,$3F,$03 #GRAPHIC$B8(b8)

N $C2B1
  $C2B1,$01 Width = #N(#PEEK(#PC)) bytes.
  $C2B2,$01 Height = #N(#PEEK(#PC)) pixels.
  $C2B3,$3F,$03 #GRAPHIC$B9(b9)

N $C2F2
  $C2F2,$01 Width = #N(#PEEK(#PC)) bytes.
  $C2F3,$01 Height = #N(#PEEK(#PC)) pixels.
  $C2F4,$3F,$03 #GRAPHIC$BA(ba)

N $C333
  $C333,$01 Width = #N(#PEEK(#PC)) bytes.
  $C334,$01 Height = #N(#PEEK(#PC)) pixels.
  $C335,$3F,$03 #GRAPHIC$BB(bb)

b $C374 Attributes?

b $C38C
  $C38C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C38D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C38E,$22,$02 #GRAPHIC$68(68)

b $C3B0
b $C3CC
b $C3F0
b $C40C
b $C438
b $C464
b $C490
b $C4BC
b $C4E8
b $C514
b $C540
b $C56E
b $C59A
b $C5DB
b $C61C
b $C65D
b $C69E
b $C6DF
b $C720
b $C74C
b $C77A
b $C7A6
b $C7E7
b $C828
b $C869
b $C8AA
b $C8EB
b $C92C
b $C97A
b $C9C8
b $CA16
b $CA64
b $CAAE
b $CAF8
b $CB46
b $CB90
b $CBDE
b $CC0E
b $CC3E
b $CC6E
b $CC9E
b $CCCE
b $CCFE
b $CD3F
b $CD83
b $CDC4
b $CE08
b $CE49
b $CE87
b $CEC8
b $CF06
b $CF64
b $CFC2
b $D020
b $D07E
b $D0DC
b $D13A
b $D17C
b $D1BE
b $D220
b $D282
b $D2B0
b $D2D6
b $D2FC
b $D32A
b $D350
b $D376
b $D37E
b $D386
b $D392
b $D3A0
b $D3B2
b $D3CA
b $D3E6
b $D418
b $D440
b $D468
b $D490
b $D4B8
b $D4E4
b $D50E
b $D53A
b $D564
b $D58D
b $D5B9
b $D5E5
b $D60E
b $D637
b $D65A
b $D67D
b $D706
b $D747
b $D78E
b $D7D8

b $D822
N $D822 Frame 1.
  $D822,$01 Width = #N(#PEEK(#PC)) bytes.
  $D823,$01 Height = #N(#PEEK(#PC)) pixels.
  $D824,$2A,$03 #GRAPHIC$01(testing-01)

N $D84E Frame 2.
  $D84E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D84F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D850,$39,$03 #GRAPHIC$02(testing-02)

N $D889 Frame 3.
  $D889,$01 Width = #N(#PEEK(#PC)) bytes.
  $D88A,$01 Height = #N(#PEEK(#PC)) pixels.
  $D88B,$45,$03 #GRAPHIC$03(testing-03)

N $D8D0 Frame 4.
  $D8D0,$01 Width = #N(#PEEK(#PC)) bytes.
  $D8D1,$01 Height = #N(#PEEK(#PC)) pixels.
  $D8D2,$45,$03 #GRAPHIC$04(testing-04)

N $D917 Frame 5.
  $D917,$01 Width = #N(#PEEK(#PC)) bytes.
  $D918,$01 Height = #N(#PEEK(#PC)) pixels.
  $D919,$45,$03 #GRAPHIC$05(testing-05)

N $D95E Frame 6.
  $D95E,$01 Width = #N(#PEEK(#PC)) bytes.
  $D95F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D960,$39,$03 #GRAPHIC$06(testing-06)

b $D999
  $D999,$01 Width = #N(#PEEK(#PC)) bytes.
  $D99A,$01 Height = #N(#PEEK(#PC)) pixels.
  $D99B,$20,$02 #GRAPHIC$80(testing-07)

b $D9BB Graphic: Ring
  $D9BB,$01 Width = #N(#PEEK(#PC)) bytes.
  $D9BC,$01 Height = #N(#PEEK(#PC)) pixels.
  $D9BD,$20,$02 #GRAPHIC$81(ring)

b $D9DD
  $D9DD,$01 Width = #N(#PEEK(#PC)) bytes.
  $D9DE,$01 Height = #N(#PEEK(#PC)) pixels.
  $D9DF,$20,$02 #GRAPHIC$82(testing-08)

b $D9FF
  $D9FF,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA00,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA01,$20,$02 #GRAPHIC$83(testing-09)

b $DA21 Graphic: Gem
  $DA21,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA22,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA23,$20,$02 #GRAPHIC$84(gem)

b $DA43
  $DA43,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA44,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA45,$20,$02 #GRAPHIC$85(testing-0A)

b $DA65 Graphic: Money Bag
  $DA65,$01 Width = #N(#PEEK(#PC)) bytes.
  $DA66,$01 Height = #N(#PEEK(#PC)) pixels.
  $DA67,$20,$02 #GRAPHIC$86(testing-0B)

b $DA87

b $DB0B Graphic: Sleeping Rhino
  $DB0B,$01 Width = #N(#PEEK(#PC)) bytes.
  $DB0C,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB0D,$3F,$03 #GRAPHIC$AC(rhino-sleeping)

b $DB4C Graphic: Running Rhino
N $DB4C Left Frame 1.
  $DB4C,$01 Width = #N(#PEEK(#PC)) bytes.
  $DB4D,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB4E,$44,$04 #GRAPHIC$A8(rhino-left-01)

N $DB92 Right Frame 1.
  $DB92,$01 Width = #N(#PEEK(#PC)) bytes.
  $DB93,$01 Height = #N(#PEEK(#PC)) pixels.
  $DB94,$48,$04 #GRAPHIC$AA(rhino-right-01)

N $DBDC Right Frame 2.
  $DBDC,$01 Width = #N(#PEEK(#PC)) bytes.
  $DBDD,$01 Height = #N(#PEEK(#PC)) pixels.
  $DBDE,$44,$04 #GRAPHIC$AB(rhino-right-02)

N $DC22 Left Frame 2.
  $DC22,$01 Width = #N(#PEEK(#PC)) bytes.
  $DC23,$01 Height = #N(#PEEK(#PC)) pixels.
  $DC24,$48,$04 #GRAPHIC$A8(rhino-left-02)

b $DC6C Attributes?

b $E770 Graphic: Amulet
D $E770 #UDGTABLE(default,centre,centre)
. { #GRAPHIC$93(testing-93) | #GRAPHIC$92(testing-92) }
. { #GRAPHIC$91(testing-91) | #GRAPHIC$90(testing-90) }
. UDGTABLE#
N $E770 Top Left.
  $E770,$01 Width = #N(#PEEK(#PC)) bytes.
  $E771,$01 Height = #N(#PEEK(#PC)) pixels.
  $E772,$20,$02 #GRAPHIC$93(testing-93)

N $E792 Top Right.
  $E792,$01 Width = #N(#PEEK(#PC)) bytes.
  $E793,$01 Height = #N(#PEEK(#PC)) pixels.
  $E794,$20,$02 #GRAPHIC$92(testing-92)

N $E7B4 Bottom Left.
  $E7B4,$01 Width = #N(#PEEK(#PC)) bytes.
  $E7B5,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7B6,$20,$02 #GRAPHIC$91(testing-91)

N $E7D6 Bottom Right.
  $E7D6,$01 Width = #N(#PEEK(#PC)) bytes.
  $E7D7,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7D8,$20,$02 #GRAPHIC$90(testing-90)

b $E7F8
D $E7F8 ...
  $E7F8,$01 Width = #N(#PEEK(#PC)) bytes.
  $E7F9,$01 Height = #N(#PEEK(#PC)) pixels.
  $E7FA,$80,$04 #GRAPHIC$94(testing-94*)

N $E87A
  $E87A,$01 Width = #N(#PEEK(#PC)) bytes.
  $E87B,$01 Height = #N(#PEEK(#PC)) pixels.
  $E87C,$80,$04 #GRAPHIC$95(testing-95*)

b $E8FC
  $E8FC,$01 Width = #N(#PEEK(#PC)) bytes.
  $E8FD,$01 Height = #N(#PEEK(#PC)) pixels.
  $E8FE,$2C,$02 #GRAPHIC$34(testing-34)

N $E92A
  $E92A,$01 Width = #N(#PEEK(#PC)) bytes.
  $E92B,$01 Height = #N(#PEEK(#PC)) pixels.
  $E92C,$2C,$02 #GRAPHIC$35(testing-35)

N $E958
  $E958,$01 Width = #N(#PEEK(#PC)) bytes.
  $E959,$01 Height = #N(#PEEK(#PC)) pixels.
  $E95A,$2E,$02 #GRAPHIC$36(testing-36)

N $E988
  $E988,$01 Width = #N(#PEEK(#PC)) bytes.
  $E989,$01 Height = #N(#PEEK(#PC)) pixels.
  $E98A,$2E,$02 #GRAPHIC$37(testing-37)

b $E9B8
b $E9D5
b $E9F2
b $EA0F
b $EA2C
b $EA64
b $EAA8
b $EAE0
b $EB24
b $EB46
b $EB64
b $EB86
b $EBA4
b $EBCA
b $EBEA
b $EC10
T $EC30,$2F