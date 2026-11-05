; Copyright Ashby Computers & Graphics Ltd 1985, Rare Ltd, 2026 ArcadeGeek LTD.

> $6000 @org=$6000
> $6000 @start=$6000
> $6000 @remote=main:$5C80

i $4000

c $6000 Copy Loader
@ $6000 label=Copy_Loader
D $6000 The helper that the BASIC loader runs at #N$6000. It copies the move
. routine to #N$FC00, the decrypt stub to #N$5B80, and the loading screen to
. #N$4000, then returns so that BASIC can load the encrypted game to #N$5E80.
N $6000 Copy the routine that moves the game down.
  $6000,$0B Copy #N$10 bytes from #R$6022 to #N$FC00.
N $600B Copy the decrypt stub.
  $600B,$0B Copy #N$20 bytes from #R$602E to #N$5B80.
N $6016 Copy the loading screen.
  $6016,$0B Copy #N$1B00 bytes from #R$6047 to #N$4000.
  $6021,$01 Return.

c $6022 Copy Game Down
@ $6022 label=Copy_Game_Down
D $6022 Copied to #N$FC00 by #R$6000 and then called from #R$602E. Moves the
. encrypted game from #N$5E80 down to #N$5C80, stopping short of this routine.
  $6022,$0B Copy #N$9D80 bytes from #N$5E80 to #N$5C80.
  $602D,$01 Return.

c $602E Decrypt Game
@ $602E label=Decrypt_Game
D $602E Copied to #N$5B80 by #R$6000. After the game has been loaded to
. #N$5E80, this moves it down and decrypts it from the top with RRD, then
. starts the game at #R$5C80@main(StartGame).
N $602E Set up the stack and move the game down into place.
  $602E,$03 Set the stack pointer to #N$FE00.
  $6031,$01 Disable interrupts.
  $6032,$03 Call #N$FC00 to move the game down to #N$5C80.
N $6035 Decrypt every byte from #N$FA00 down to #N$5C01.
  $6035,$03 Set the start address in #REGhl to #N$FA00.
  $6038,$01 Clear the nibble carried between bytes in #REGa.
  $6039,$03 Set the byte count in #REGbc to #N$9E00.
N $603C Start rotating each byte through #REGa to decrypt it.
@ $603C label=Decrypt_Game_Loop
  $603C,$02 Rotate the nibbles of the current byte through #REGa.
  $603E,$01 Move down to the previous byte.
  $603F,$03 Decrease the low byte of the counter by one and loop back to
. #R$603C until none remain.
  $6042,$02 Decrease the high byte of the counter by one and loop back to
. #R$603C until every byte has been decrypted.
  $6044,$03 Jump to #R$5C80@main(StartGame).

b $6047 Loading Screen
@ $6047 label=Loading_Screen
D $6047 Copied to #N$4000 by #R$6000.
. #UDGTABLE { =h Loading Screen }
. { #SCR$02,$00,$00,$20,$18,$6047,$7847(loader-screen) } UDGTABLE#
B $6047,$1B00,$20

u $7B47 Unused bytes
B $7B47,$07

i $7B4E
