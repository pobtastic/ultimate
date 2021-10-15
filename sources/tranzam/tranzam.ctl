> $4000 @org=$4000
> $4000 @start=$5B80
b $4000 Loading screen
D $4000 #UDGTABLE { #SCR(loading) | Tranz Am Loading Screen. } TABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$300,$20 Attributes

i $5B00

c $5B80 Game entry point
@ $5B80 label=GameEntry
  $5B80,$01 Disable interrupts.
  $5B81,$0B Moves #N$20FF bytes from #N$5F01 to #N$5F00.
  $5B8C,$03 Jump to #R$5F00.

b $5B8F

g $5E00
g $5E03
g $5E2D
g $5E31
g $5E33
g $5E34
g $5E3E
g $5E43
g $5E44
g $5E49
g $5E68

c $5F00 Security Check
@ $5F00 label=SecurityCheck
  $5F00,$01 Disable interrupts.
  $5F01,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $5F04,$03 Return if #REGa is not #N$58.
N $5F07 Blank the 1UP, 2UP and HI scores.
@ $5F07 label=GameInitialisation
  $5F07,$0D Write #N$00 to #N$00A3 bytes starting from #R$5E00.
  $5F14,$06 Write #N$FFFF to #R$5E00.
  $5F1A,$06 Write #N$FFFF to #R$5E34.
  $5F20,$03 Set the stack pointer to #R$5E00.
  $5F23,$03 Call #R$6175.
  $5F26,$03 Call #R$68A0.
  $5F29,$03 Call #R$5F6C.
  $5F2C,$07 If #R$5E03 is not zero, call #R$6483.
  $5F33,$04 #REGd=#R$5E3E.
  $5F37,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $5F3D,$01 Flip the bits.
N $5F3E Handle 1UP selection.
  $5F3E,$02 Has key "1" been pressed? ("1 PLAYER GAME").
  $5F40,$02 If not jump to #R$5F44.
N $5F44 Handle 2UP selection.
@ $5F44 label=GameSelect_CheckP2
  $5F44,$02 Has key "2" been pressed? ("2 PLAYER GAME").
  $5F46,$02 If not jump to #R$5F4A.
N $5F4A Handle Keyboard selection.
@ $5F4A label=GameSelect_CheckKeyboard
  $5F4A,$02 Has key "3" been pressed? ("KEYBOARD").
  $5F4C,$03 If it has then jump to #R$5FEF.
  $5F4F,$01 Retrieve the original value of #R$5E3E.
  $5F50,$03 Write it to #R$5E3E.
  $5F53,$03 #REGhl=#R$5FA8.
  $5F56,$04 #REGc=#R$5E3E.
  $5F63,$02 Jump to #R$5F29.
  $5F6A,$02 Jump to #R$5F29.

c $5F6C
B $5FA7,$0A,$01

t $5FB1 Game Selection Screen Text
@ $5FB1 label=GameSelection_Text
  $5FB1,$0E,$0D:$01 "GAME SELECTION".
  $5FBF,$0B,$0A:$01 "1  KEYBOARD".
  $5FCA,$0B,$0A:$01 "2  JOYSTICK".
  $5FD5,$0D,$0C:$01 "3  START GAME".
  $5FE2,$0D,h$01,$0B:$01 "© 1983 A.C.G.".

c $5FEF

t $6099
  $6099,$13,$12:$01 "CONGRATULATIONS YOU".
  $60AC,$12,$11:$01 " HAVE SUCCESSFULLY".
  $60BE,$13,$12:$01 "COLLECTED THE EIGHT".
  $60D1,$11,$10:$01 " CUPS OF ULTIMATE".

c $60E2

c $6175
  $6175,$04 Write #N$00 to #R$5E43.
  $6179,$02 #REGa=#N$70.
  $617B,$03 Write #REGa to #R$5E44.
  $617E,$01 Return.

c $617F

c $61C2

c $61E0

c $625C

t $63DA
  $63DA,$09,$08:$01 "GAME OVER".
  $63E3,$0D,$0C:$01 "YOUR TIME WAS".
  $63F0,$0F,$0E:$01 "BEST TIME TODAY".

c $63FF

c $6518

c $653E

B $65FD,$10

c $68A0
  $68A0,$0A Write #N$00 to #N$0C bytes starting from #R$5E68.
  $68AA,$06 Write #N$FFFF to #R$5E34.
  $68B0,$03 #REGhl=#R$65FD.
  $68BB,$03 Call #R$7200.
  $68BE,$03 Call #R$69BC.
  $68C1,$03 Call #R$6949.
  $68C4,$03 Call #R$646C.
  $68C7,$03 Call #R$687B.
  $68CA,$03 Call #R$6CDE.
  $690F,$01 Return.

  $691E,$03 #REGhl=#N$4070.
  $6921,$03 #REGde=#R$693C.
  $6924,$03 Call #R$6518.
@ $693C label=NightDriver_Text
T $693C,$0D,h$01,$0B:$01
  $6949

  $69BC

c $6C96 Print Character
@ $6C96 label=PrintScreen
R $6C96 A ASCII value to print
R $6C96 HL Screen address
  $6C96,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $6C99,$03 Create an offset in #REGhl.
  $6C9C,$03 Calculate offset for ASCII character (#REGhl=#REGhl * 8).
  $6C9F,$04 #HTML(#REGde=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $6CA3,$02 #REGde=#REGhl + #N$3C00. For examples of usage;
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Letter | =h ASCII Value | =h * 8 (offset) | =h CHARS + offset }
. #FOREACH($55,$4C,$54,$49,$4D,$41,$54,$45)(value,
. { #LET(result=$3C00 + value * $08) "#CHR(value)" | #N(value) | #N(value * 8) | #HTML(<a href="https://skoolkid.github.io/rom/asm/3D00.html##N({result}, 2, 3, 1, 1)()">#N({result})) }
. )
. TABLE#
N $6CA5 Print the character to the screen.
  $6CA5,$01 Restore #REGhl, containing the screen buffer location, from the stack.
  $6CA6,$02 #REGb=#N$08 (#N$08 rows of pixels).
@ $6CA8 label=PrintScreen_Loop
  $6CA8,$02 Copy a byte from the font data to the screen buffer.
  $6CAA,$01 Increment the font data by one.
  $6CAB,$01 Move onto the next pixel line.
  $6CAC,$02 Decrease counter by one and loop back to #R$6CA8 until counter is zero.
  $6CAE,$02 Restore #REGde and #REGbc from the stack.
N $6CB0 Reset #REGhl and move to the next column, ready to print the next character.
  $6CB0,$04 #REGh=#REGh - #N$08 (reset the display line).
  $6CB4,$01 Increment screen column by one.
  $6CB5,$01 Return.

c $6CB6
  $6CBE,$03 #REGhl=#N$4018.
  $6CC1,$03 #REGde=#R$5E49.
  $6CCB,$02,b$01 Keep only bits 0-3.
  $6CCF,$03 Call #R$6C96.
  $6CD3,$02,b$01 Keep only bits 0-3.
  $6CD7,$03 Call #R$6C96.
  $6CDE,$03 #REGhl=#N$4061.
  $6CE1,$03 #REGde=#R$5E2D.
  $6CE6,$03 Call #R$6CC6.
  $6CE9,$03 #REGhl=#N$4021.
  $6CEC,$03 #REGde=#R$5E31.
  $6CF1,$03 Call #R$6CD2.
  $6CF4,$03 #REGde=#R$5E33.
  $6CFA,$03 Jump to #R$6CC6.
B $6F07

c $6F10

i $8000
b $B868
i $B869
