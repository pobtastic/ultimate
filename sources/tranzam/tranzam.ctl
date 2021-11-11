> $4000 @org=$4000
> $4000 @start=$5B80
b $4000 Loading screen
D $4000 #UDGTABLE { #SCR(loading) | Tranz Am Loading Screen. } TABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$300,$20 Attributes

i $5B00

c $5B80 Game entry point
E $5B80 View the equivalent code in;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #PSSST$5B80 }
. LIST#
E $5B80 Later Ultimate games use more advanced decryption mechanisms;
. #LIST
. { #ATICATAC$5B80 }
. { #LUNARJETMAN$5B80 }
. LIST#
@ $5B80 label=GameEntry
  $5B80,$01 Disable interrupts.
  $5B81,$0B Moves #N$20FF bytes from #N$5F01 to #N$5F00.
  $5B8C,$03 Jump to #R$5F00.

b $5B8F

c $5CB0

i $5CB1

g $5E00
g $5E03

g $5E17 Player X
@ $5E17 label=Player_X
B $5E17,$01

g $5E18 Player Y
@ $5E18 label=Player_Y
B $5E18,$01

g $5E1F

g $5E20
W $5E20,$02

g $5E22

g $5E24 Width Bytes
@ $5E24 label=WidthBytes
B $5E24,$01

g $5E26 Height Lines
@ $5E26 label=HeightLines
B $5E26,$01

g $5E27
W $5E27,$02

g $5E29 Game Timer
D $5E29 16-bit counter starting at 0x0000 and counting +1 (each time a sprite is moved or redrawn), although sometimes
.       it will increment + #N$02. This continues until the whole game is over - for both 1 and 2 player games. Counter
.       loops around after reaching #N$FFFF.
@ $5E29 label=GameTimer
W $5E29,$02

g $5E2B
g $5E2C
g $5E2D
g $5E31
g $5E33

g $5E34
W $5E34,$02

g $5E36

g $5E3C

g $5E3D Player Lives
@ $5E3D label=Player_Lives
B $5E3D,$01

g $5E3E Game Options
D $5E3E #TABLE(default,centre,centre)
. { =h Byte | =h Binary | =h Option }
. { #N$00 | #EVAL($00, 2, 8) | Keyboard }
. { #N$02 | #EVAL($02, 2, 8) | Joystick }
. TABLE#
@ $5E3E label=GameOptions
B $5E3E,$01

g $5E3F Current menu item colour attribute
@ $5E3F label=Current_MenuAttr
B $5E3F,$01

g $5E40
g $5E41
g $5E42

g $5E43
B $5E43,$01

g $5E44 Background Attribute
@ $5E44 label=Background_Attribute
B $5E44,$01

g $5E45
g $5E46
g $5E47
g $5E48
g $5E49

g $5E4C Score?

g $5E50

g $5E68
g $5E74

g $5E80

g $5EA4

c $5F00 Security Check
E $5F00 Continue on to #R$5F07.
E $5F00 View the equivalent code in;
. #LIST
. { #ATICATAC$6000 }
. { #COOKIE$5F00 }
. { #LUNARJETMAN$8000 }
. { #PSSST$61C6 }
. LIST#
@ $5F00 label=SecurityCheck
  $5F00,$01 Disable interrupts.
  $5F01,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $5F04,$03 Return if #REGa is not #N$58.

c $5F07 Game Initialisation
N $5F07 Blank the game configs.
E $5F07 View the equivalent code in;
. #LIST
. { #ATICATAC$7C19 }
. { #COOKIE$6298 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$800A }
. { #PSSST$61CD }
. LIST#
@ $5F07 label=GameInitialisation
  $5F07,$0D Write #N$00 to #N$00A3 bytes starting from #R$5E00.
  $5F14,$06 Write #N$FFFF to #R$5E00.
@ $5F1A label=Game_Restart
  $5F1A,$06 Write #N$FFFF to #R$5E34.
  $5F20,$03 Set the stack pointer to #R$5E00.
  $5F23,$03 Call #R$6175.
  $5F26,$03 Call #R$68A0.
@ $5F29 label=GameSelect_Loop
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
N $5F3E Handle keyboard selection.
@ $5F3E label=GameSelect_CheckKeyboard
  $5F3E,$02 Has key "1" been pressed? ("1 KEYBOARD").
  $5F40,$02 If not jump to #R$5F44.
  $5F42,$02 Set control method = keyboard.
N $5F44 Handle joystick selection.
@ $5F44 label=GameSelect_CheckJoystick
  $5F44,$02 Has key "2" been pressed? ("2 JOYSTICK").
  $5F46,$02 If not jump to #R$5F4A.
  $5F48,$02 Set control method = joystick.
N $5F4A Handle starting a new game.
@ $5F4A label=GameSelect_CheckStart
  $5F4A,$02 Has key "3" been pressed? ("3 START GAME").
  $5F4C,$03 If it has then jump to #R$5FEF.
N $5F4F Handle flashing each selection.
  $5F4F,$04 Write #REGd to #R$5E3E.
  $5F53,$03 #REGhl=#R$5FA8(GameSelection_Attributes)+#N$01 (i.e. ignoring "Game Selection" as it doesn't flash).
  $5F56,$04 #REGc=#R$5E3E.
  $5F5A,$04 If the joystick option is selected, jump to #R$5F65.
N $5F5E Set the first menu item, unset the second.
@ $5F5E label=MenuAttributeSetFirst
  $5F5E,$02 Set the FLASH attribute for the first selection.
  $5F60,$01 Move onto the next menu attribute.
  $5F61,$02 Unset the FLASH attribute for the second selection.
  $5F63,$02 Jump to #R$5F29.
N $5F65 Unset the first menu item, set the second.
@ $5F65 label=MenuAttributeSetSecond
  $5F65,$02 Unset the FLASH attribute for the first selection.
  $5F67,$01 Move onto the next menu attribute.
  $5F68,$02 Set the FLASH attribute for the second selection.
  $5F6A,$02 Jump to #R$5F29.

c $5F6C Game Selection Menu
@ $5F6C label=GameMenu
  $5F6C,$05 Write #N$68 to #R$5E48.
  $5F71,$03 #REGde=#R$5FA7.
  $5F74,$01 Switch to the shadow registers.
  $5F75,$03 #REGhl'=#R$5FAC.
  $5F78,$03 #REGde'=#R$5FB1.
N $5F7B There are five lines of text.
  $5F7B,$02 #REGb'=#N$05 (counter).
@ $5F7D label=GameMenu_Loop
  $5F7D,$01 Switch.
  $5F7E,$01 Copy a byte from #REGde to #R$5E3F.
  $5F83,$01 Switch to the shadow registers.
  $5F8D,$03 Call #R$5F97.
  $5F90,$01 Switch.
  $5F96,$01 Return.
  $5F98,$03 Call #R$6F10.
  $5F9F,$01 Switch.
  $5FA1,$03 Call #R$7097.
  $5FA4,$03 Jump to #R$6524.

b $5FA7 Game Select Attribute Table
E $5FA7 View the equivalent code in;
. #LIST
. { #ATICATAC$7CEA }
. { #COOKIE$635E }
. { #JETPAC$628D }
. { #LUNARJETMAN$810E }
. { #PSSST$627C }
. LIST#
@ $5FA7 label=GameSelection_Attributes
  $5FA7,$05,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | Game Selection }
. { #N$02 | 1 Keyboard }
. { #N$03 | 2 Joystick }
. { #N$04 | 3 Start Game }
. { #N$05 | © 1983 A.C.G. }
. TABLE#

b $5FAC Game Select Y Position Table
E $5FAC View the equivalent code in;
. #LIST
. { #ATICATAC$7CF1 }
. { #COOKIE$6365 }
. { #JETPAC$6293 }
. { #LUNARJETMAN$8115 }
. { #PSSST$6282 }
. LIST#
@ $5FAC label=GameSelection_Position
  $5FAC,$05,$01 #TABLE(default,centre,centre)
. { =h Byte(n) | =h Position | =h Menu Item }
. { #N$01 | #EVAL(#PEEK(#PC+$00) / $08) | Game Selection }
. { #N$02 | #EVAL(#PEEK(#PC+$01) / $08) | 1 Keyboard }
. { #N$03 | #EVAL(#PEEK(#PC+$02) / $08) | 2 Joystick }
. { #N$04 | #EVAL(#PEEK(#PC+$03) / $08) | 3 Start Game }
. { #N$05 | #EVAL(#PEEK(#PC+$04) / $08) | © 1983 A.C.G. }
. TABLE#

t $5FB1 Game Selection Screen Text
E $5FB1 View the equivalent code in;
. #LIST
. { #ATICATAC$7CF8 }
. { #COOKIE$636C }
. { #JETPAC$6299 }
. { #LUNARJETMAN$811C }
. { #PSSST$6288 }
. LIST#
@ $5FB1 label=GameSelection_Text
  $5FB1,$0E,$0D:$01 "GAME SELECTION".
  $5FBF,$0B,$0A:$01 "1  KEYBOARD".
  $5FCA,$0B,$0A:$01 "2  JOYSTICK".
  $5FD5,$0D,$0C:$01 "3  START GAME".
  $5FE2,$0D,h$01,$0B:$01 "© 1983 A.C.G.".

c $5FEF Start Game
@ $5FEF label=StartGame
  $5FEF,$07 #HTML(Write #N$00 to #LIST { <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> } { #R$5E74 } LIST#)
  $5FF6,$05 Write starting lives to #R$5E3D.
  $5FFB,$03 #REGhl=#R$5E4C.
  $5FFE,$02 #REGb=#N$03.
  $6000,$02 Write #N$00 to #REGhl.
  $6002,$01 Increment #REGhl by one.
  $6003,$02 Decrease counter by one and loop back to #R$6000 until counter is zero.
  $6005,$01 Enable interrupts.
  $6006,$03 Call #R$6391.
  $6009,$04 #REGix=#R$5E80.
  $600D,$03 Set the stack pointer to #R$5E00.
@ $6010 label=MainLoop
  $6010,$03 #REGhl=#R$6A73.
  $6013,$01 Stash #REGhl on the stack.
  $6014,$03 #REGhl=#R$6028.
  $601B,$02,b$01 Keep only bits 1-6.
  $601D,$03 Create an offset in #REGbc.
  $6020,$01 #REGhl=#REGhl + offset.
  $6021,$04 #REGhl=address from #R$6028 + offset.
  $6025,$03 Jump to #R$5CB0.

w $6028
  $6028,$08,$02

c $6030

t $6031 Score/ Hi-Score Text
@ $6031 label=Text_ScoreHi
  $6031,$15,h$01,$13:$01

c $6046

t $6099
  $6099,$13,$12:$01 "CONGRATULATIONS YOU".
  $60AC,$12,$11:$01 " HAVE SUCCESSFULLY".
  $60BE,$13,$12:$01 "COLLECTED THE EIGHT".
  $60D1,$11,$10:$01 " CUPS OF ULTIMATE".

c $60E2

c $60FB
  $60FB,$03 #REGa=#R$5E47.
  $6100,$03 Write #REGa back to #R$5E47.
  $6105,$01 Return.

c $6106
  $611A,$01 Return.

c $611B

c $6158

c $6175 Set Default Playarea Attributes
@ $6175 label=SetDefaultAttributes
E $6175 Continue on to #R$617B.
  $6175,$04 Write #N$00 to #R$5E43.
  $6179,$02 #REGa=#N$70.

c $617B Set Background Attribute
R $617B A Background attribute
@ $617B label=SetBackgroundAttr
  $617B,$03 Write #REGa to #R$5E44.
  $617E,$01 Return.

c $617F

c $61C2

c $61E0

c $625C

c $6353 Game Over
  $6353,$03 Call #R$7139.
  $6356,$03 Call #R$617F.
  $635B,$02,b$01 Keep only bit 1.
  $635F,$03 Call #R$6175.
  $6362,$03 #REGhl=#R$5E3D.
  $6365,$01 Decrease #R$5E3D by one.
  $636C,$03 Call #R$605B.
  $636F,$03 Call #R$6175.
  $6372,$03 Call #R$68A0.
  $637B,$03 Call #R$5F97.
  $6380,$03 Call #R$6386.
  $6383,$03 Jump to #R$5F1A.

c $6386 Delay Loop
R $6386 B Number of times to execute the delay
@ $6386 label=Delay
  $6386,$03 #REGhl=#N($0000, $04, $04) (large counter).
N $6389 From #REGhl being set above (and for each loop), decrementing #N($0000, $04, $04) by one gives #N$FFFF.
@ $6389 label=Delay_Loop
  $6389,$01 Decrease #REGhl by one.
  $638A,$04 Loop back to #R$6389 until #REGhl is zero.
  $638E,$02 Decrease counter by one and loop back to #R$6389 until counter is zero.
  $6390,$01 Return.

c $6391

t $63DA
  $63DA,$09,$08:$01 "GAME OVER".
  $63E3,$0D,$0C:$01 "YOUR TIME WAS".
  $63F0,$0F,$0E:$01 "BEST TIME TODAY".

c $63FF

c $646C
  $646C,$03 #REGhl=#R$672E.
  $646F,$03 #REGde=#R$7F4A.
  $6472,$03 Call #R$70DB.
  $6475,$03 Call #R$714C.
  $6478,$03 #REGde=#R$5E3C.
  $647B,$03 #REGhl=#N$48C6.
  $647E,$02 #REGb=#N$01.
  $6480,$03 Jump to #R$6CD2.

c $6518 Print Colour String
@ $6518 label=PrintStringColour
R $6518 DE Pointer to string data
  $6518,$01 Stash #REGhl on the stack.
  $6519,$03 Call #R$6F10.
  $651C,$01 Fetch the attribute byte.
  $651D,$01 Switch to the shadow #REGaf register.
  $651E,$01 Increment #REGde by one to point to the text of the string.
  $651F,$01 Switch to the shadow registers.
  $6520,$01 Restore #REGhl from the stack.
  $6521,$03 Call #R$7097.
@ $6524 label=PrintString_Loop
  $653D,$01 Return.

c $653E

c $6557

c $6588

b $65FD
c $672E

c $6826

b $6837

c $687B

c $68A0 Create Game Window
@ $68A0 label=CreateWindow
  $68A0,$0A Write #N$00 to #N$0C bytes starting from #R$5E68.
  $68AA,$06 Write #N$FFFF to #R$5E34.
  $68B0,$03 #REGhl=#R$65FD.
  $68BB,$03 Call #R$7200.
  $68BE,$03 Call #R$69BC.
  $68C1,$03 Call #R$6949.
  $68C4,$03 Call #R$646C.
  $68C7,$03 Call #R$687B.
  $68CA,$03 Call #R$6CDE.
  $68CD,$03 #REGhl=#N$5808 (attribute buffer).
  $68D0,$03 #REGbc=#N($1801, $04, $04).
  $68D3,$01 Stash #REGbc on the stack.
  $68D4,$03 Call #R$6900.
  $68D7,$03 #REGhl=#N$5AE8 (attribute buffer).
  $68DA,$01 Restore #REGbc from the stack.
  $68DB,$03 Call #R$6900.
  $68DE,$03 #REGhl=#N$5828 (attribute buffer).
  $68E1,$03 #REGbc=#N($0116, $04, $04).
  $68E4,$01 Stash #REGbc on the stack.
  $68E5,$03 Call #R$6900.
  $68E8,$01 Restore #REGbc from the stack.
  $68E9,$03 #REGhl=#N$583F (attribute buffer).
  $68EC,$03 Call #R$6900.
  $68EF,$03 #REGhl=#N($0050, $04, $04).
  $68F2,$03 #REGde=#R$6031.
  $68F5,$03 Call #R$6518.
  $68F8,$03 Call #R$6CB6.
  $68FB,$03 Call #R$6CBE.
  $68FE,$02 Jump to #R$6919.

c $6900
  $690F,$01 Return.

c $6910 Screen Address One Pixel Below
R $6910 HL Current position
R $6910 O:HL Address for new position
N $6910 Calculates the new address for writing a sprite pixel, in an downwards direction.
  $6910,$04 #REGl=#REGl=#N$20 (one line).
  $6914,$04 #REGh=#REGh+#N$00 (but include the carry from above).
  $6918,$01 Return.

c $6919
  $6919,$05 Return if #R$5E43 is zero.
  $691E,$03 #REGhl=#N$4070.
  $6921,$03 #REGde=#R$693C.
  $6924,$03 Call #R$6518.
  $6936,$03 #REGde=#R$6AE4(#N$6AE5).
@ $693C label=NightDriver_Text
T $693C,$0D,h$01,$0B:$01

c $6949 Plot Map Points
@ $6949 label=PlotMapPoints
  $6949,$03 #REGbc=#R$7811.
  $694C,$03 #REGhl=#N$4708.
  $6973,$03 Call #R$6998.
  $6977,$03 #REGhl=#R$7CD6.
  $697F,$01 Return.

c $6980

c $6998
  $6998,$05 Write #N$C6 to #R$69A6(#N$69A7).
  $699D,$02 Stash #REGbc and #REGhl on the stack.
  $69A4,$02,b$01 Keep only bits 3-5.
  $69A6,$02,b$01 Set bits 1-2, 6-7.
  $69AB,$03 Call #R$6F10.
  $69B0,$03 Call #R$6ECB.
  $69B5,$02 Restore #REGhl and #REGbc from the stack.
  $69B8,$03 Decrease counter by one and loop back to #R$699D until counter is zero.
  $69BB,$01 Return.

c $69BC Draw PlayArea
@ $69BC label=DrawPlayArea
  $69BC,$04 #HTML(Stash <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a> on the stack.)
  $69C0,$06 #HTML(Write #R$74B1 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $69C6,$03 #REGhl=#R$7691.
  $69C9,$03 #REGde=#R$7751.
  $69CC,$01 Switch to the shadow registers.
  $69CD,$03 #REGhl'=#N$4000 (screen buffer).
  $69D0,$03 #REGde'=#N$5800 (attributes buffer).
  $69D3,$02 #REGc'=#N$18 (height of the sidebar).
  $69D5,$05 Write #N$08 (width of the sidebar) to #R$5E2C.
@ $69DA label=DrawPlayArea_Loop
  $69DA,$04 #REGb'=#R$5E2C.
  $69DE,$02 Stash #REGhl and #REGde on the stack.
@ $69E0 label=DrawPlayArea_LineLoop
  $69E0,$01 Switch back to the normal registers.
  $69E1,$01 #REGa=fetch the sidebar layout data.
  $69E2,$01 Increment the sidebar layout data pointer by one.
  $69E3,$01 Switch to the shadow registers.
N $69E4 Now using the screen data held by the shadow registers.
  $69E4,$03 Call #R$6C96.
  $69E7,$01 Switch back to the normal registers.
  $69E8,$01 #REGa=fetch the sidebar attribute data.
  $69E9,$01 Increment the sidebar attribute data pointer by one.
  $69EA,$01 Switch to the shadow registers.
  $69EB,$01 Write the sidebar attribute data to the attribute buffer.
  $69EC,$01 Increment the attribute buffer pointer by one.
  $69ED,$02 Decrease counter by one and loop back to #R$69E0 until counter is zero.
N $69EF Restore the attribute buffer address for the start of this line.
  $69EF,$01 Restore #REGhl from the stack.
  $69F0,$03 Call #R$6910.
  $69F3,$01 #REGde=#REGhl (ignoring the exchange as #REGhl is instantly overwritten below).
N $69F4 Restore the screen buffer address for the start of this line.
  $69F4,$01 Restore #REGhl from the stack.
  $69F5,$03 Call #R$6910.
N $69F8 Account for the Spectrum screen layout in memory.
  $69F8,$01 #REGa=#REGl.
  $69F9,$02,b$01 Keep only bits 5-7.
  $69FB,$02 Jump to #R$6A01 if we're not crossing a screen section.
  $69FD,$04 Else #REGh=#REGh+#N$07.
@ $6A01 label=DrawPlayArea_Skip
  $6A01,$01 Decrease the height counter by one.
  $6A02,$02 Keep jumping back to #R$69DA until the height counter is zero.
N $6A04 #HTML(All done! Finish by reverting the change to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a> and returning.)
  $6A04,$04 #HTML(Restore <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/3D00.html">CHARSET</a> from the stack and write it back to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C36.html">CHARS</a>.)
  $6A08,$01 Return.

c $6A09
  $6A09,$0B Copy #N$24 bytes of data from #R$6A15 to #R$5E80.
  $6A14,$01 Return.
B $6A15,$24


c $6A39

c $6A73
  $6A73,$03 #REGde=#N($000C, $04, $04).
  $6A76,$02
  $6A78,$03 #REGhl=#REGix (using the stack to do so).
  $6A7B,$03 #REGbc=#R$5EA4.
  $6A84,$03 Call #R$6158.

@ $6A87 label=Pause_Loop
N $6A87 Holding "SHIFT" pauses the game.
  $6A87,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $6A8D,$02 Has the "SHIFT" key been pressed?
  $6A8F,$02 If it has then jump to #R$6A87.
  $6A91,$03 #REGhl=#R$5E29.
  $6A94,$01 Increment #REGhl by one.
  $6A95,$03 Write #REGhl to #R$5E29.
  $6A98,$03 Jump to #R$6009.

c $6A9B

  $6ADB,$03 #REGhl=#N$B868.
  $6ADE,$03 #REGde=#R$6AE4.
  $6AE1,$03 Call #R$6518.
T $6AE4,$11,h$01,$0F:$01

c $6AF5
  $6AF5,$03 #REGhl=#R$5E50.
B $6BD6,$20

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


c $6CB6 Print Scores
E $6CB6 View the equivalent code in;
. #LIST
. { #ATICATAC$0000 }
. { #COOKIE$0000 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$739D }
. LIST#
N $6CB6 Sets up the player score.
@ $6CB6 label=Score_Player
  $6CB6,$03 #REGhl=#N$400D.
  $6CB9,$03 #REGde=#R$5E4C.
  $6CBC,$02 Jump to #R$6CC4.
N $6CBE Sets up the HI score.
@ $6CBE label=Score_HI
  $6CBE,$03 #REGhl=#N$4018.
  $6CC1,$03 #REGde=#R$5E49.
N $6CC4 Prints the score.
@ $6CC4 label=PrintScore
  $6CC4,$02 #REGb=#N$03.
@ $6CC6 label=PrintScore_Loop
  $6CCB,$02,b$01 Keep only bits 0-3.
  $6CCF,$03 Call #R$6C96.
  $6CD3,$02,b$01 Keep only bits 0-3.
  $6CD7,$03 Call #R$6C96.
  $6CDD,$01 Return.

c $6CDE
  $6CDE,$03 #REGhl=#N$4061.
  $6CE1,$03 #REGde=#R$5E2D.
  $6CE6,$03 Call #R$6CC6.
  $6CE9,$03 #REGhl=#N$4021.
  $6CEC,$03 #REGde=#R$5E31.
  $6CF1,$03 Call #R$6CD2.
  $6CF4,$03 #REGde=#R$5E33.
  $6CFA,$03 Jump to #R$6CC6.

c $6CFD


c $6D12

c $6ECB Screen Address One Pixel Above
R $6ECB HL Current position
R $6ECB O:HL Address for new position
N $6ECB Calculates the new address for writing a sprite pixel, in an upward direction, taking into consideration the screen memory layout.
@ $6ECB label=ScreenPos1PixelAbove
  $6ECB,$01 Decrement #REGh to move up one pixel on screen.
  $6ECC,$02 Store the inverted result in #REGa.
  $6ECE,$02,b$01 Keep only bits 0-2.
  $6ED0,$01 If a character line has not been crossed then return.
  $6ED1,$04 Else subtract #N$20 from #REGl.
  $6ED5,$01 Invert the bits in #REGa.
  $6ED6,$02,b$01 Keep only bits 5-7.
  $6ED8,$01 If a new section of the screen has not been crossed then return.
  $6ED9,$05 Else add #N$08 to #REGh and return.

c $6EDE
B $6F07

c $6F10 Calculate Screen Address
@ $6F10 label=ScreenAddress

c $6F2F
  $6F2F,$03 #REGhl=#N($0000, $04, $04).
  $6F32,$02 #REGb=#N$08 (counter).
  $6F34,$01
  $6F35,$01
  $6F36,$02
  $6F38,$01
  $6F39,$02 Decrease counter by one and loop back to #R$6F34 until counter is zero.
  $6F3B,$01 Return.

c $6F3C

c $6FAC
  $6FD5,$02,b$01 Keep only bits 0-6.
  $6FD7,$03 Call #R$64F0.
  $6FDA,$03 Call #R$7101.
  $6FDD,$03 #REGl=
  $6FE0,$03 #REGh=
  $6FE3,$04 #REGd=#R$5E42.
  $6FE7,$03 Call #R$7052.
  $6FEA,$06 Return if too far from #R$5E17 (i.e. more than #N$0A pixels).
  $6FF0,$06 Return if too far from #R$5E18 (i.e. more than #N$0A pixels).
  $6FF6,$07
  $701B,$02,b$01 Keep only bits 0-6.
  $701E,$05 Write #N$07 to #R$5E46.
  $7023,$01 Return.

c $7024

c $704B

c $7097 Calculate Attribute Address
@ $7097 label=AttributeAddress
  $7097,$01 Horizontal co-ordinate.
  $7098,$03 Divide by #N$08.
  $709B,$02,b$01 Keep only bits 0-4 (#N$00-#N$1F / minimum-maximum horizontal screen values).
  $709D,$01 Store this back in #REGl.
  $709E,$01 Vertical co-ordinate.
  $709F,$02 Multiply by #N$04.
  $70A1,$01 Store this in #REGc temporarily.
  $70A2,$02,b$01 Keep only bits 5-7.
  $70A4,$01 Set the bits from #REGl.
  $70A5,$01 #REGl=#REGa.
  $70A6,$01 Fetch the stored value from #REGc.
  $70A7,$02,b$01 Keep only bits 0-1.
  $70A9,$02,b$01 Set MSB of the attribute buffer #N58. This ensures our value is >= #R$5800.
  $70AB,$01 Store this back in #REGh.
  $70AC,$01 Return.

c $70AD

c $70B2
  $70B2,$03 Call #R$7155.
  $70B5,$03 #REGhl=#R$5E20.
  $70B8,$01 #REGa=#REGl.
  $70BB,$02,b$01 Keep only bits 0-2.
  $70C0,$03 Call #R$70AD.
  $70C3,$03 Call #R$6F10.
  $70CA,$01 #REGa=#REGc.
  $70CE,$02 #REGc=#N$00.
  $70D0,$01 Increment #REGde by one.
  $70D1,$01 Return.

c $70D2

c $7101

c $7139

c $7155
  $7155,$03 #REGa=#R$5E22.
  $715B,$02,b$01 Keep only bits 1-6.
  $715D,$03 #REGhl=#R$7F06.
  $7167,$01 Return.

c $7170

c $71ED Store Entity
E $71ED View the equivalent code in;
. #LIST
. { #ATICATAC$9FFB }
. { #COOKIE$0000 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$75B9 }
. { #TRANZAM$71ED }
. LIST#
@ $71ED label=StoreEntity
  $71ED,$06 Copy actor X position to active actor X position.
  $71F3,$06 Copy actor Y position to active actor Y position.
  $71F9,$06 Copy actor movement to active actor movement.
  $71FF,$01 Return.


c $7200 Reset Attribute Buffer
@ $7200 label=ResetAttributes
  $7200,$03 Set the border to black.
  $7203,$03 Call #R$7211.
  $7206,$03 #REGhl=#R$5800(attribute buffer).
  $7209,$02 #REGb=#N$5B (i.e. finish once we reach the end of the #R$5800(attribute buffer)).
  $720B,$04 #REGc=#R$5E44.
  $720F,$02 Jump to #R$7218.

c $7211 Reset Screen Buffer
@ $7211 label=ResetScreen
E $7211 Continue on to #R$7218 to blank the screen buffer.
  $7211,$03 #REGhl=#R$4000(screen buffer).
  $7214,$02 #REGb=#N$58 (i.e. finish once we reach the start of #R$5800(attribute buffer)).
  $7216,$02 #REGc=#N$00 (value to write).

c $7218 Reset Routine
R $7218 HL Target address
R $7218 B Single byte representing the MSB of the end address (will always end on LSB #N$00)
R $7218 C Value to write
@ $7218 label=ResetCopier
  $7218,$01 Write #REGc to the target address.
  $7219,$01 Increment the target address by one.
  $721A,$02 Are we finished yet? Check the MSB of the target vs. #REGb.
  $721C,$02 Keep looping back to #R$7218 until there is no carry-over.
  $721E,$01 Return.

b $721F

b $7352 Sprite: Cactus
  $7352,$01 Height = #N(#PEEK(#PC)) pixels.
  $7353,$20,b$02 #SPRITE$00(cactus)

b $7373 Sprite: USA Sign
  $7373,$01 Height = #N(#PEEK(#PC)) pixels.
  $7374,$20,b$02 #SPRITE$01(sign)

b $7394 Sprite: Flower
  $7394,$01 Height = #N(#PEEK(#PC)) pixels.
  $7395,$20,b$02 #SPRITE$03(flower)

b $73B5 Sprite: Boulder
  $73B5,$01 Height = #N(#PEEK(#PC)) pixels.
  $73B6,$1E,b$02 #SPRITE$04(boulder)

b $73D4 Sprite: Tree
  $73D4,$01 Height = #N(#PEEK(#PC)) pixels.
  $73D5,$20,b$02 #SPRITE$05(tree)

b $73F5 Sprite: Fuel Pump
  $73F5,$01 Height = #N(#PEEK(#PC)) pixels.
  $73F6,$20,b$02 #SPRITE$06(fuel-pump)

b $7416 Sprite: Pylon
  $7416,$01 Height = #N(#PEEK(#PC)) pixels.
  $7417,$20,b$02 #SPRITE$0D(pylon)

b $7437 Sprite: Tombstone
  $7437,$01 Height = #N(#PEEK(#PC)) pixels.
  $7438,$20,b$02 #SPRITE$0E(tombstone)

b $7458 Sprite: Car
  $7458,$01 Height = #N(#PEEK(#PC)) pixels.
  $7459,$1A,b$02 #SPRITE$0F(car)

b $7473 Sprite: Bush
  $7473,$01 Height = #N(#PEEK(#PC)) pixels.
  $7474,$20,b$02 #SPRITE$09(bush)

b $7494 Sprite:
  $7494,$01 Height = #N(#PEEK(#PC)) pixels.
  $7495,$1E,b$02 SPRITE$0(tests-01)

b $74B1 UDG Graphics
@ $74B1 label=UDG_Tiles
N $74B1 Tile ID: "#N(#EVAL((#PC - $74B1) / $08))".
  $74B1,b$08,$01 #UDG(#PC)
L $74B1,$08,$3C

b $7691 Sidebar Layout
@ $7691 label=SidebarLayoutData
  $7691,$08 #FOR($00,$07)||n|#UDG($74B1 + #PEEK(#PC + n) * $08)||
L $7691,$08,$18

b $7751 Sidebar Attributes
@ $7751 label=SidebarAttributes
  $7751,$08 #FOR($00,$07)||n|#UDG($74B1 + #PEEK(n + #PC - $C0) * $08,attr=#PEEK(#PC + n))||
L $7751,$08,$18

b $7811 Map Points
@ $7811 label=MapPoints
  $7811,$4C5,$03

b $7CD6 Sprite: Car
E $7CD6 #UDGARRAY*car-01,10;car-02;car-03;car-04;car-05;car-06;car-07;car-08;car-09;car-0A;car-0B;car-0C;car-0D;car-0E;car-0F;car-10(car-ani)
N $7CD6 Frame 1.
  $7CD6,$01 Width = #N(#PEEK(#PC)) bytes.
  $7CD7,$22,b$02 #CAR$00(car-01*)

N $7CF9 Frame 2.
  $7CF9,$01 Height = #N(#PEEK(#PC)) pixels.
  $7CFA,$22,b$02 #CAR$01(car-02*)

N $7D1C Frame 3.
  $7D1C,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D1D,$22,b$02 #CAR$02(car-03*)

N $7D3F Frame 4.
  $7D3F,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D40,$22,b$02 #CAR$03(car-04*)

N $7D62 Frame 5.
  $7D62,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D63,$22,b$02 #CAR$04(car-05*)

N $7D85 Frame 6.
  $7D85,$01 Height = #N(#PEEK(#PC)) pixels.
  $7D86,$22,b$02 #CAR$05(car-06*)

N $7DA8 Frame 7.
  $7DA8,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DA9,$22,b$02 #CAR$06(car-07*)

N $7DCB Frame 8.
  $7DCB,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DCC,$22,b$02 #CAR$07(car-08*)

N $7DEE Frame 9.
  $7DEE,$01 Height = #N(#PEEK(#PC)) pixels.
  $7DEF,$22,b$02 #CAR$08(car-09*)

N $7E11 Frame 10.
  $7E11,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E12,$22,b$02 #CAR$09(car-0A*)

N $7E34 Frame 11.
  $7E34,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E35,$22,b$02 #CAR$0A(car-0B*)

N $7E57 Frame 12.
  $7E57,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E58,$22,b$02 #CAR$0B(car-0C*)

N $7E7A Frame 13.
  $7E7A,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E7B,$22,b$02 #CAR$0C(car-0D*)

N $7E9D Frame 14.
  $7E9D,$01 Height = #N(#PEEK(#PC)) pixels.
  $7E9E,$22,b$02 #CAR$0D(car-0E*)

N $7EC0 Frame 15.
  $7EC0,$01 Height = #N(#PEEK(#PC)) pixels.
  $7EC1,$22,b$02 #CAR$0E(car-0F*)

N $7EE3 Frame 16.
  $7EE3,$01 Height = #N(#PEEK(#PC)) pixels.
  $7EE4,$22,b$02 #CAR$0F(car-10*)

w $7F06 Sprites Table
E $7F06 View the equivalent code in;
. #LIST
. { #ATICATAC$A4BE }
. { #COOKIE$7702 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #TRANZAM$0000 }
. LIST#
@ $7F06 label=SpritesTable
  $7F06,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $7F06) / 2)) #SPRITENAME((#PC - $7F06) / 2).
L $7F06,$02,$0F

w $7F24 Player Sprite Table
@ $7F24 label=PlayerSpriteTable
  $7F24,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $7F24) / 2)) #CARNAME((#PC - $7F24) / 2).
L $7F24,$02,$10

w $7F44

b $7F4A Sprite: Cup
  $7F4A,$01 Height = #N(#PEEK(#PC)) pixels.
  $7F4B,$20,b$02 #CAR$10(cup)

i $8000
b $B868
i $B869
