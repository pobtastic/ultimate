> $4000 @org=$4000
> $4000 @start=$5B80
b $4000 Loading screen
D $4000 #UDGTABLE { #SCR(loading) | Atic Atac Loading Screen. } TABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$300,$20 Attributes

i $5B00

c $5B80 Decryption Routine
N $5B80 Runs "RRD" on every byte from #N$5FFF-#N$DBFF.
E $5B80 View the equivalent code in #LUNARJETMAN$5B80.
  $5B80,$03 #REGhl=#N$5FFF.
  $5B83,$03 #REGbc=#N$007C.
  $5B86,$01 Reset the flags.
  $5B87,$02 RRD operation.
  $5B89,$01 Increment #REGhl by one.
  $5B8A,$02 Decrease counter by one and loop back to #R$5B87 until counter is zero.
  $5B8C,$01 Decrease #REGc by one.
  $5B8D,$02 Loop back to #R$5B87 until #REGc is zero.
  $5B8F,$03 Jump to #R$6000.

i $5B92

g $5E00
g $5E01
W $5E01,$02

g $5E21 Lives

c $6000 Security Check
@ $6000 label=SecurityCheck
  $6000,$01 Disable interrupts.
  $6001,$03 Set the stack pointer to #N$5E00.
  $6004,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $6007,$03 Return if #REGa is not #N$25.
  $600A,$03 Jump to #R$7C19.

b $600D


c $7C19 Game Entry Point
@ $7C19 label=GameInitialisation
  $7C19,$0A Write #N$00 to #N$10 bytes, from #R$5E00 to #N$5E10.
  $7C23,$06 Write #N$BE4C to #R$5E01.
  $7C29,$03 Call #R$80AA.
  $7C2C,$03 Call #R$A311.
  $7C2F,$03 Call #R$7CAF.
  $7C32,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $7C38,$01 Flip the bits.

  $7C62,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $7C68,$01 Flip the bits.
N $7C6B Handle choosing "Serf".
@ $7C6B label=GameSelect_Serf
  $7C6B,$02 Has key "6" been pressed? ("SERF").
  $7C6D,$02 If not skip to #R$7C73.
  $7C6F,$02,b$01 Keep only bits 0-2, 5-7.
  $7C71,$02,b$01 Set bit 4.

  $7C73,$03
  $7C76,$01

N $7C77 Handle starting a new game.
@ $7C77 label=GameSelect_Start
  $7C77,$02 Has key "0" been pressed? ("START GAME").
  $7C79,$03 If so, jump to #R$7D9A.

  $7C8D,$03 Jump to #R$7C2F.

c $7C90

c $7CAF

b $7CEA Game Select Attribute Table
@ $7CEA label=GameSelection_Attributes
  $7CEA,$07,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { 1 | 1 Keyboard }
. { 2 | 2 Kempston Joystick }
. { 3 | 3 Cursor Joystick }
. { 4 | 4 Knight }
. { 5 | 5 Wizard }
. { 6 | 6 Serf }
. { 7 | 0 Start Game }
. TABLE#

b $7CF1 Game Select Y Position Table
@ $7CF1 label=GameSelection_Position
  $7CF1,$07,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | 1 Keyboard }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | 2 Kempston Joystick }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | 3 Cursor Joystick }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | 4 Knight }
. { #N$05 | #EVAL(#PEEK(#PC+$04) / $08) | 5 Wizard }
. { #N$06 | #EVAL(#PEEK(#PC+$05) / $08) | 6 Serf }
. { #N$07 | #EVAL(#PEEK(#PC+$06) / $08) | 0 Start Game }
. TABLE#

t $7CF8 Game Selection Screen Text
@ $7CF8 label=GameSelection_Text
  $7CF8,$0B,$0A:$01 "1  KEYBOARD".
  $7D03,$14,$13:$01 "2  KEMPSTON JOYSTICK".
  $7D17,$14,$13:$01 "3  CURSOR   JOYSTICK".
  $7D2B,$09,$08:$01 "4  KNIGHT".
  $7D34,$09,$08:$01 "5  WIZARD".
  $7D3D,$07,$06:$01 "6  SERF".
  $7D44,$0D,$0C:$01 "0  START GAME".

t $7D51 Copyright Messaging
@ $7D51 label=Message_Copyright
  $7D51,$21,h$01,c$01,$1E:$01 Attribute: #N(#PEEK(#PC)) + "© 1983 A.C.G. ALL RIGHTS RESERVED".

t $7D72 Game Selection Title text
@ $7D72 label=GameSelection_Title
  $7D72,$18,h$01,$16:$01 Attribute: #N(#PEEK(#PC)) + "ATICATAC GAME SELECTION".

c $7D8A

c $7D9A
  $7D9D,$05 Write starting lives to #R$5E21.
  $7DA2,$06 Write #N$EB58 to #N$5E55.
  $7DA8,$03 Call #R$80AA.
  $7DC0,$03 Jump to #R$9147.

c $7DC3

c $80AA Reset Screen Wrappper
@ $80AA label=ResetScreenWrapper
E $80AA View the equivalent code in #COOKIE$5FB7.
E $80AA View the equivalent code in #PSSST$5F53.
  $80AA,$03 Call #R$80C2.
  $80AD,$03 Call #R$80B4.
  $80B0,$03 Set the border to black.
  $80B3,$01 Return.

c $80B4 Reset Screen Buffer
@ $80B4 label=ResetScreen
E $80B4 Continue on to #R$80BB to blank the screen buffer.
  $80B4,$03 #REGhl=#R$4000(screen buffer).
  $80B7,$02 #REGb=#N$58 (i.e. finish once we reach the start of #R$5800(attribute buffer)).
  $80B9,$02 #REGc=#N$00 (value to write).

c $80BB Reset Routine
R $80BB HL Target address
R $80BB B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $80BB C Value to write
@ $80BB label=ResetCopier
  $80BB,$01 Write #REGc to the target address.
  $80BC,$01 Increment the target address by one.
  $80BD,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $80BF,$02 Keep looping back to #R$80BB until the comparison is zero.
  $80C1,$01 Return.

c $80C2 Reset Attribute Buffer
@ $80C2 label=ResetAttributes
  $80C2,$03 #REGhl=#R$5800(attribute buffer).
  $80C5,$02 #REGb=#N$5B (i.e. finish once we reach the end of the #R$5800(attribute buffer)).
  $80C7,$02 #REGc=#N$00 (value to write).
  $80C9,$02 Jump to #R$80BB.

c $80CB

c $A1F3

c $A219

c $A311
