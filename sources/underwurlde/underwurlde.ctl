> $4000 @org=$4000
b $4000 Loading screen
D $4000 #UDGTABLE { =h Underwurlde Loading Screen } { #SCR$02(loading) } UDGTABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

c $5B00 Game entry point
@ $5B00 label=GameEntry
  $5B00,$01 Disable interrupts.

T $9125,$0B,$0A:$01 "1  KEYBOARD"
T $9130,$14,$13:$01 "2  KEMPSTON JOYSTICK"
T $9144,$14,$13:$01 "3  CURSOR   JOYSTICK"
T $9158,$0F,$0E:$01 "4  INTERFACE II"
T $9167,$0D,$0C:$01 "0  START GAME"
T $9176,$1F,$1E:$01 "1984 A:C:G: ALL RIGHTS RESERVED".
T $9196,$1A,$19:$01 "UNDERWURLDE GAME SELECTION".

  $94A9,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { $BF | ENTER | L | K | J | H }
. TABLE#

c $989F

c $98B2

c $98DF
  $98DF,$04 Stash #REGaf, #REGbc, #REGde and #REGhl on the stack.
  $98E3,$04 If #REGa is not #N$20, jump to #R$98E9.
  $98E7,$02 #REGa=#N$3D.
  $98E9,$03 Create an offset in #REGhl.
  $98EC,$07 Calculate the offset (#R$ED24 + #REGhl * 8).
  $98F3,$01 Store the result in #REGde.
  $98F4,$01 Restore #REGhl from the stack.

c $9906
  $9906,$01 Disable interrupts.
  $9907,$03 Call #R$99AB.
  $990A,$06 Write #N$0000 to #R$AA97.
  $9910,$03 Call #R$98CC.
  $9920,$03 Call #R$99F5.
  $9923,$03 Call #R$9A53.
  $9926,$03 Call #R$9AB6.
  $9929,$03 Call #R$9AF8.
  $992C,$03 Call #R$9B38.
  $992F,$03 Call #R$9B64.
  $9932,$03 Call #R$9BA4.
  $9935,$03 Call #R$9BB8.
  $9938,$03 Call #R$AF56.
  $993B,$03 Call #R$E6A5.

c $9BB8

c $9C62
  $9C62,$0D Write #N$00 to #N$07FF bytes starting at #R$6000.
  $9C6F,$01 Return.

c $9C70

T $9F0D,$0F,$0E:$01 "CONGRATULATIONS".
T $9F1C,$0C,$0B:$01 "KNIGHT LORE".
T $9F3F,$0C,$0B:$01 "SCORE 000000".
T $9F4B,$16,$15:$01 "YOU HAVE ESCAPED FROM".
T $9F61,$10,$0F:$01 "THE UNDERWURLDE".
T $9F71,$17,$16:$01 "YOUR NEXT ADVENTURE IS".
T $9F88,$13,$12:$01 "YOU HAVE COMPLETED".

b $ED24
  $ED24,$08 #UDG(#PC)
L $ED24,$08,$5B

i $EFFC
