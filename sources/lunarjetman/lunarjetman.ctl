> $4000 @org=$4000
> $4000 @start=$5B80
b $4000 Loading screen
D $4000 #UDGTABLE { #SCR(loading) | Lunar Jetman Loading Screen. } TABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$300,$20 Attributes

i $5B00

c $5B80 Decryption Routine
N $5B80 Runs "RRD" on every byte from #N$7FFF-#N$FBFF.
E $5B80 View the equivalent code in #ATICATAC$5B80.
  $5B80,$03 #REGhl=#N$7FFF.
  $5B83,$03 #REGbc=#N$007C.
  $5B86,$01 Reset the flags.
  $5B87,$02 RRD operation.
  $5B89,$01 Increment #REGhl by one.
  $5B8A,$02 Decrease counter by one and loop back to #R$5B87 until counter is zero.
  $5B8C,$01 Decrease #REGc by one.
  $5B8D,$02 Loop back to #R$5B87 until #REGc is zero.
  $5B8F,$03 Jump to #R$8000.

i $5B92

c $8000
E $8000 View the equivalent code in #ATICATAC$6000.
  $8000,$01 Disable interrupts.
  $8001,$03 Set the stack pointer to #N$5E00.
  $8004,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $8007,$03 Return if #REGa is not #N$25.
  $801E,$03 Call #R$9C23.
  $8021,$03 Call #R$84D8.
  $8027,$03 Call #R$B9BC.
  $802A,$02 Jump to #R$8035.

c $802C
  $802C,$03 Call #R$84D8.
  $802F,$03 Call #R$F410.
  $8032,$03 Call #R$84D8.
  $8035,$03 Call #R$80D1.
  $8038,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $803E,$01 Flip the bits.

  $806B,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $8071,$01 Flip the bits.

c $80D1

b $810E Game Select Attribute Table
@ $810E label=GameSelection_Attributes
E $810E View the equivalent code in #ATICATAC$7CEA.
E $810E View the equivalent code in #COOKIE$635E.
E $810E View the equivalent code in #PSSST$627C.
  $810E,$07,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { 1 | Game Selection }
. { 2 | 1 Player Game }
. { 3 | 2 Player Game }
. { 4 | 3 Keyboard }
. { 5 | 4 Kempston Joystick }
. { 6 | 5 Cursor Joystick }
. { 7 | 6 Start Game }
. TABLE#

b $8115 Game Select Y Position Table
@ $8115 label=GameSelection_Position
E $8115 View the equivalent code in #ATICATAC$7CF1.
  $8115,$07,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | Game Selection }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | 1 Player Game }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | 2 Player Game }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | 3 Keyboard }
. { #N$05 | #EVAL(#PEEK(#PC+$04) / $08) | 4 Kempston Joystick }
. { #N$06 | #EVAL(#PEEK(#PC+$05) / $08) | 5 Cursor Joystick }
. { #N$07 | #EVAL(#PEEK(#PC+$06) / $08) | 6 Start Game }
. TABLE#

t $811C Game Selection Title text
@ $811C label=GameSelection_Title
E $811C View the equivalent code in #ATICATAC$7CF8.
  $811C,$0E,$0D:$01 "GAME SELECTION".
  $812A,$10,$0F:$01 "1  1 PLAYER GAME".
  $813A,$10,$0F:$01 "2  2 PLAYER GAME".
  $814A,$0B,$0A:$01 "3  KEYBOARD".
  $8155,$14,$13:$01 "4  KEMPSTON JOYSTICK".
  $8169,$14,$13:$01 "5  CURSOR   JOYSTICK".
  $817D,$0D,$0C:$01 "6  START GAME".

t $818A Copyright Messaging
@ $818A label=Message_Copyright
E $818A View the equivalent code in #ATICATAC$7D51.
  $818A,$21,h$01,c$01,$1E:$01 Attribute: #N(#PEEK(#PC)) + "© 1983 A.C.G. ALL RIGHTS RESERVED".

c $81AB

c $84AD Reset Screen Buffer
@ $84AD label=ResetScreen
E $84AD Continue on to #R$84B4 to blank the screen buffer.
E $84AD View the equivalent code in #ATICATAC$80B4.
  $84AD,$03 #REGhl=#R$4000(screen buffer).
  $84B0,$02 #REGb=#N$58 (i.e. finish once we reach the start of #R$5800(attribute buffer)).
  $84B2,$02 #REGc=#N$00 (value to write).  

c $84B4 Reset Routine
R $84B4 HL Target address
R $84B4 B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $84B4 C Value to write
@ $84B4 label=ResetCopier
E $84B4 View the equivalent code in #ATICATAC$80BB.
  $84B4,$01 Write #REGc to the target address.
  $84B5,$01 Increment the target address by one.
  $84B6,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $84B8,$02 Keep looping back to #R$84B4 until the comparison is zero.
  $84BA,$01 Return.

c $84BB Reset Attribute Buffer
@ $84BB label=ResetAttributes
E $84BB View the equivalent code in #ATICATAC$80C2.
  $84BB,$03 Set the border to black.
  $84BE,$03 #REGhl=#R$5800(attribute buffer).
  $84C1,$02 #REGb=#N$5B (i.e. finish once we reach the end of the #R$5800(attribute buffer)).
  $84C3,$02 #REGc=#N$43 (value to write).
  $84C5,$03 Call #R$84B4.

  $84D7,$01 Return.

c $84D8

c $9C23

c $B9BC

c $F410
