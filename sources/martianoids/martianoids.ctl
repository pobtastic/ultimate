; Copyright Ashby Computers & Graphics Ltd 1987, Rare Ltd, 2026 ArcadeGeek LTD.
> $4000 @org=$4000
> $4000 @rom
> $4000 @expand=#DEF(#POKE()(anchor,text) #LINK(Pokes#$anchor)($text))
> $4000 @expand=#DEF(#COLOUR(id)#LET(ink=$id&$07)#IF({ink}>=$00)(INK:#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE)), #LET(paper=$id>>$03&$07)#IF({paper}>=$00)(PAPER:#MAP({paper})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#LET(bright=$id&$40)#IF({bright}>$00)( (BRIGHT))#LET(flash=$id&$80)#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF(#INK(id)#LET(bright=$id&$40)#LET(flash=$id&$80)#LET(ink=$id&$07)#IF({ink}>=$00)(#MAP({ink})(UNKNOWN,0:BLACK,1:BLUE,2:RED,3:MAGENTA,4:GREEN,5:CYAN,6:YELLOW,7:WHITE))#IF({bright}>$00)( (BRIGHT))#IF({flash}>$00)( (FLASH: ON)))
> $4000 @expand=#DEF1(#SKOOLKID(addr,anchor=0)(name)#HTML(<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/#IF({{mode[base]}}==16)(hex/)asm/#IF({{mode[base]}}==16)(#EVAL({addr},16,4),#EVAL({addr})).html#IF({anchor})(#CHR(35)#IF({{mode[base]}}==16)(#EVAL({anchor},16,4),#EVAL({anchor})))">){name}#HTML(</a>))
b $4000 Loading screen
@ $4000 label=Loading
D $4000 #UDGTABLE { =h Martianoids Loading Screen } { #SCR$02(loading) } UDGTABLE#
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

c $6000 Start Game
@ $6000 label=StartGame_Jump
D $6000 The first instruction of the game, which jumps to #R$9601 to start it.
  $6000,$03 Jump to the start of the game.

b $6003 Digit Graphics
@ $6003 label=DigitGraphics
D $6003 The graphics of the digits #N$00 to #N$09 that are used for the scores.
. Each digit is two characters tall, so it takes #N$10 bytes.
. .
. #UDGARRAY10,attr=$47,scale=4($6003-$6093-$10;$600B-$609B-$10)(digits)
B $6003,$A0,$10

w $60A3 Sprite Pointers
@ $60A3 label=SpritePointers
D $60A3 The address of the sprite for each entity type. The type is the first
. byte of the entity, without bit 7, which flips the sprite. Several types use
. the same sprite.
W $60A3,$02,$02 Type #N$00: Blank 1.
W $60A5,$02,$02 Type #N$01: Blank 2.
W $60A7,$02,$02 Type #N$02: Unused Figure 1.
W $60A9,$02,$02 Type #N$03: Unused Figure 2.
W $60AB,$02,$02 Type #N$04: Installed Program 1.
W $60AD,$02,$02 Type #N$05: Installed Program 3.
W $60AF,$02,$02 Type #N$06: Battery.
W $60B1,$02,$02 Type #N$07: Battery.
W $60B3,$02,$02 Type #N$08: Saucer 1.
W $60B5,$02,$02 Type #N$09: Saucer 2.
W $60B7,$02,$02 Type #N$0A: Saucer 3.
W $60B9,$02,$02 Type #N$0B: Saucer 4.
W $60BB,$02,$02 Type #N$0C: Dome 1.
W $60BD,$02,$02 Type #N$0D: Dome 2.
W $60BF,$02,$02 Type #N$0E: Dome 3.
W $60C1,$02,$02 Type #N$0F: Dome 4.
W $60C3,$02,$02 Type #N$10: Robot Walking 1.
W $60C5,$02,$02 Type #N$11: Robot Walking 2.
W $60C7,$02,$02 Type #N$12: Robot Walking 3.
W $60C9,$02,$02 Type #N$13: Robot Walking 4.
W $60CB,$02,$02 Type #N$14: Robot Walking 5.
W $60CD,$02,$02 Type #N$15: Robot Walking 6.
W $60CF,$02,$02 Type #N$16: Robot Walking 7.
W $60D1,$02,$02 Type #N$17: Robot Walking 8.
W $60D3,$02,$02 Type #N$18: Robot Walking 9.
W $60D5,$02,$02 Type #N$19: Robot Walking 10.
W $60D7,$02,$02 Type #N$1A: Robot Walking 11.
W $60D9,$02,$02 Type #N$1B: Robot Walking 12.
W $60DB,$02,$02 Type #N$1C: Robot Walking 13.
W $60DD,$02,$02 Type #N$1D: Robot Walking 14.
W $60DF,$02,$02 Type #N$1E: Robot Walking 15.
W $60E1,$02,$02 Type #N$1F: Robot Walking 16.
W $60E3,$02,$02 Type #N$20: Robot Turning 1.
W $60E5,$02,$02 Type #N$21: Robot Turning 2.
@ $60E7 label=SpritePointers_LivesIcon
W $60E7,$02,$02 Type #N$22: Robot Turning 3.
W $60E9,$02,$02 Type #N$23: Robot Turning 4.
W $60EB,$02,$02 Type #N$24: Robot Turning 5.
W $60ED,$02,$02 Type #N$25: Robot Turning 6.
W $60EF,$02,$02 Type #N$26: Robot Turning 7.
W $60F1,$02,$02 Type #N$27: Robot Turning 8.
W $60F3,$02,$02 Type #N$28: Robot Turning 9.
W $60F5,$02,$02 Type #N$29: Robot Turning 10.
W $60F7,$02,$02 Type #N$2A: Robot Turning 11.
W $60F9,$02,$02 Type #N$2B: Robot Turning 12.
W $60FB,$02,$02 Type #N$2C: Robot Turning 13.
W $60FD,$02,$02 Type #N$2D: Robot Turning 14.
W $60FF,$02,$02 Type #N$2E: Robot Turning 15.
W $6101,$02,$02 Type #N$2F: Robot Turning 16.
W $6103,$02,$02 Type #N$30: Pellet 1.
W $6105,$02,$02 Type #N$31: Pellet 2.
W $6107,$02,$02 Type #N$32: Pellet 3.
W $6109,$02,$02 Type #N$33: Pellet 4.
W $610B,$02,$02 Type #N$34: Pellet 5.
W $610D,$02,$02 Type #N$35: Pellet 6.
W $610F,$02,$02 Type #N$36: Pellet 7.
W $6111,$02,$02 Type #N$37: Pellet 8.
W $6113,$02,$02 Type #N$38: Smoke 1.
W $6115,$02,$02 Type #N$39: Smoke 2.
W $6117,$02,$02 Type #N$3A: Smoke 3.
W $6119,$02,$02 Type #N$3B: Smoke 4.
W $611B,$02,$02 Type #N$3C: Spark 1.
W $611D,$02,$02 Type #N$3D: Spark 2.
W $611F,$02,$02 Type #N$3E: Spark 3.
W $6121,$02,$02 Type #N$3F: Spark 4.
W $6123,$02,$02 Type #N$40: Materialising 1.
W $6125,$02,$02 Type #N$41: Materialising 2.
W $6127,$02,$02 Type #N$42: Materialising 3.
W $6129,$02,$02 Type #N$43: Materialising 4.
W $612B,$02,$02 Type #N$44: Materialising 5.
W $612D,$02,$02 Type #N$45: Materialising 6.
W $612F,$02,$02 Type #N$46: Materialising 7.
W $6131,$02,$02 Type #N$47: Materialising 8.
W $6133,$02,$02 Type #N$48: Materialising 9.
W $6135,$02,$02 Type #N$49: Materialising 10.
W $6137,$02,$02 Type #N$4A: Materialising 11.
W $6139,$02,$02 Type #N$4B: Materialising 12.
W $613B,$02,$02 Type #N$4C: Hazard 1.
W $613D,$02,$02 Type #N$4D: Hazard 2.
W $613F,$02,$02 Type #N$4E: Transmitter 1.
W $6141,$02,$02 Type #N$4F: Transmitter 2.
W $6143,$02,$02 Type #N$50: Thief 1.
W $6145,$02,$02 Type #N$51: Thief 2.
W $6147,$02,$02 Type #N$52: Thief 3.
W $6149,$02,$02 Type #N$53: Thief 4.
W $614B,$02,$02 Type #N$54: Cloud 1.
W $614D,$02,$02 Type #N$55: Cloud 2.
W $614F,$02,$02 Type #N$56: Cloud 3.
W $6151,$02,$02 Type #N$57: Cloud 4.
W $6153,$02,$02 Type #N$58: Blank 1.
W $6155,$02,$02 Type #N$59: Blank 2.
W $6157,$02,$02 Type #N$5A: Wall Along X.
W $6159,$02,$02 Type #N$5B: Wall Along Y.
W $615B,$02,$02 Type #N$5C: Sector Wall Along X.
W $615D,$02,$02 Type #N$5D: Sector Wall Along Y.
W $615F,$02,$02 Type #N$5E: Dropped Program.
W $6161,$02,$02 Type #N$5F: Robot Standing.
W $6163,$02,$02 Type #N$60: Hunter 1.
W $6165,$02,$02 Type #N$61: Hunter 2.
W $6167,$02,$02 Type #N$62: Hunter 3.
W $6169,$02,$02 Type #N$63: Hunter 4.
W $616B,$02,$02 Type #N$64: Destroyer 1.
W $616D,$02,$02 Type #N$65: Destroyer 2.
W $616F,$02,$02 Type #N$66: Destroyer 3.
W $6171,$02,$02 Type #N$67: Destroyer 4.
W $6173,$02,$02 Type #N$68: Terminal.
W $6175,$02,$02 Type #N$69: Socket.
W $6177,$02,$02 Type #N$6A: Wall Post.
W $6179,$02,$02 Type #N$6B: Wall Corner.
W $617B,$02,$02 Type #N$6C: Dropped Program.
W $617D,$02,$02 Type #N$6D: Robot Standing.
W $617F,$02,$02 Type #N$6E: Program Packet 1.
W $6181,$02,$02 Type #N$6F: Program Packet 2.
W $6183,$02,$02 Type #N$70: Activated Terminal 1.
W $6185,$02,$02 Type #N$71: Activated Terminal 2.
W $6187,$02,$02 Type #N$72: Activated Terminal 3.
W $6189,$02,$02 Type #N$73: Activated Terminal 4.
W $618B,$02,$02 Type #N$74: Installed Program 1.
W $618D,$02,$02 Type #N$75: Installed Program 2.
W $618F,$02,$02 Type #N$76: Installed Program 3.
W $6191,$02,$02 Type #N$77: Installed Program 4.

b $6193 Blank Sprite 1
@ $6193 label=BlankSprite1
D $6193 The sprite for the entity types #N$00 and #N$01 and #N$58 and #N$59.
B $6193,$02,$02 Width of #N$00 bytes, height of #N$00 rows.
B $6195,$00,$00

b $6195 Terminal Sprite
@ $6195 label=TerminalSprite
D $6195 The sprite for the entity type #N$68. It is drawn for the map cells of
. type #N$09.
. .
. #SPRITEAT$6195(terminal*)
B $6195,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $6197,$CC,$06

b $6263 Activated Terminal Sprite 1
@ $6263 label=ActivatedTerminalSprite1
D $6263 The first frame of the activated terminal (entity type #N$70). Map cells
. of type #N$0E use it. A terminal becomes type #N$0E when a program packet
. arrives (see #R$A3C6), and the bolt then moves through the four frames.
. .
. #SPRITEAT$6263(activated-terminal-01*)
B $6263,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $6265,$CC,$06

b $6331 Activated Terminal Sprite 2
@ $6331 label=ActivatedTerminalSprite2
D $6331 The second frame of the activated terminal (entity type #N$71).
. .
. #SPRITEAT$6331(activated-terminal-02*)
B $6331,$02,$02 Width of #N$03 bytes, height of #N$23 rows.
B $6333,$D2,$06

b $6405 Activated Terminal Sprite 3
@ $6405 label=ActivatedTerminalSprite3
D $6405 The third frame of the activated terminal (entity type #N$72).
. .
. #SPRITEAT$6405(activated-terminal-03*)
B $6405,$02,$02 Width of #N$03 bytes, height of #N$24 rows.
B $6407,$D8,$06

b $64DF Activated Terminal Sprite 4
@ $64DF label=ActivatedTerminalSprite4
D $64DF The fourth frame of the activated terminal (entity type #N$73).
. .
. #SPRITEAT$64DF(activated-terminal-04*)
B $64DF,$02,$02 Width of #N$03 bytes, height of #N$23 rows.
B $64E1,$D2,$06

b $65B3 Wall Post Sprite
@ $65B3 label=WallPostSprite
D $65B3 The sprite for the entity type #N$6A. It is drawn for the map cells of
. type #N$0D.
. .
. #SPRITEAT$65B3(wall-post*)
B $65B3,$02,$02 Width of #N$03 bytes (with the flags #N$40), height of #N$21
. rows.
B $65B5,$C6,$06

b $667B Wall Corner Sprite
@ $667B label=WallCornerSprite
D $667B The sprite for the entity type #N$6B. It is drawn for the map cells of
. type #N$0C.
. .
. #SPRITEAT$667B(wall-corner*)
B $667B,$02,$02 Width of #N$03 bytes, height of #N$23 rows.
B $667D,$D2,$06

b $674F Hunter Sprite 1
@ $674F label=HunterSprite1
D $674F The sprite for the entity type #N$60.
. .
. #SPRITEAT$674F(hunter-01*)
B $674F,$02,$02 Width of #N$03 bytes, height of #N$1A rows.
B $6751,$9C,$06

b $67ED Hunter Sprite 2
@ $67ED label=HunterSprite2
D $67ED The sprite for the entity type #N$61.
. .
. #SPRITEAT$67ED(hunter-02*)
B $67ED,$02,$02 Width of #N$03 bytes, height of #N$1A rows.
B $67EF,$9C,$06

b $688B Hunter Sprite 3
@ $688B label=HunterSprite3
D $688B The sprite for the entity type #N$62.
. .
. #SPRITEAT$688B(hunter-03*)
B $688B,$02,$02 Width of #N$03 bytes, height of #N$1A rows.
B $688D,$9C,$06

b $6929 Hunter Sprite 4
@ $6929 label=HunterSprite4
D $6929 The sprite for the entity type #N$63.
. .
. #SPRITEAT$6929(hunter-04*)
B $6929,$02,$02 Width of #N$03 bytes, height of #N$1A rows.
B $692B,$9C,$06

b $69C7 Hazard Sprite 1
@ $69C7 label=HazardSprite1
D $69C7 The sprite for the entity type #N$4C. It is drawn for the map cells of
. type #N$01.
. .
. #SPRITEAT$69C7(hazard-01*)
B $69C7,$02,$02 Width of #N$03 bytes, height of #N$1C rows.
B $69C9,$A8,$06

b $6A71 Hazard Sprite 2
@ $6A71 label=HazardSprite2
D $6A71 The sprite for the entity type #N$4D. It is drawn for the map cells of
. type #N$07.
. .
. #SPRITEAT$6A71(hazard-02*)
B $6A71,$02,$02 Width of #N$03 bytes (with the flags #N$80), height of #N$1C
. rows.
B $6A73,$A8,$06

b $6B1B Battery Sprite
@ $6B1B label=BatterySprite
D $6B1B The battery. Entity types #N$06 and #N$07 both use this picture, so
. alternating them does not change it. It is drawn for the map cells of type
. #N$03.
. .
. #SPRITEAT$6B1B(battery*)
B $6B1B,$02,$02 Width of #N$03 bytes, height of #N$1A rows.
B $6B1D,$9C,$06

b $6BB9 Transmitter Sprite 1
@ $6BB9 label=TransmitterSprite1
D $6BB9 The sprite for the entity type #N$4E. It is drawn for the map cells of
. type #N$08.
. .
. #SPRITEAT$6BB9(transmitter-01*)
B $6BB9,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $6BBB,$CC,$06

b $6C87 Transmitter Sprite 2
@ $6C87 label=TransmitterSprite2
D $6C87 The sprite for the entity type #N$4F.
. .
. #SPRITEAT$6C87(transmitter-02*)
B $6C87,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $6C89,$CC,$06

b $6D55 Program Packet Sprite 1
@ $6D55 label=ProgramPacketSprite1
D $6D55 The sprite for the entity type #N$6E.
. .
. #SPRITEAT$6D55(program-packet-01*)
B $6D55,$02,$02 Width of #N$03 bytes, height of #N$0E rows.
B $6D57,$54,$06

b $6DAB Program Packet Sprite 2
@ $6DAB label=ProgramPacketSprite2
D $6DAB The sprite for the entity type #N$6F.
. .
. #SPRITEAT$6DAB(program-packet-02*)
B $6DAB,$02,$02 Width of #N$03 bytes, height of #N$0D rows.
B $6DAD,$4E,$06

b $6DFB Spark Sprite 1
@ $6DFB label=SparkSprite1
D $6DFB The sprite for the entity types #N$3C and #N$64.
. .
. #SPRITEAT$6DFB(spark-01*)
B $6DFB,$02,$02 Width of #N$03 bytes, height of #N$18 rows.
B $6DFD,$90,$06

b $6E8D Spark Sprite 2
@ $6E8D label=SparkSprite2
D $6E8D The sprite for the entity types #N($3D), #N($3F), #N$65 and #N$67.
. .
. #SPRITEAT$6E8D(spark-02*)
B $6E8D,$02,$02 Width of #N$03 bytes, height of #N$16 rows.
B $6E8F,$84,$06

b $6F13 Spark Sprite 3
@ $6F13 label=SparkSprite3
D $6F13 The sprite for the entity types #N$3E and #N$66.
. .
. #SPRITEAT$6F13(spark-03*)
B $6F13,$02,$02 Width of #N$03 bytes, height of #N$14 rows.
B $6F15,$78,$06

b $6F8D Thief Sprite 1
@ $6F8D label=ThiefSprite1
D $6F8D The sprite for the entity type #N$50.
. .
. #SPRITEAT$6F8D(thief-01*)
B $6F8D,$02,$02 Width of #N$04 bytes, height of #N$22 rows.
B $6F8F,$0110,$08

b $709F Thief Sprite 2
@ $709F label=ThiefSprite2
D $709F The sprite for the entity types #N$51 and #N$53.
. .
. #SPRITEAT$709F(thief-02*)
B $709F,$02,$02 Width of #N$04 bytes, height of #N$21 rows.
B $70A1,$0108,$08

b $71A9 Thief Sprite 3
@ $71A9 label=ThiefSprite3
D $71A9 The sprite for the entity type #N$52.
. .
. #SPRITEAT$71A9(thief-03*)
B $71A9,$02,$02 Width of #N$04 bytes, height of #N$1F rows.
B $71AB,$F8,$08

b $72A3 Unused Sprite
@ $72A3 label=UnusedSprite
D $72A3 A sprite that is not used. It is cut short, as it is #N$09 rows tall but
. only has the data for #N$08.
. .
. #SPRITEAT$72A3(unused-72a3*)
B $72A3,$02,$02 Width of #N$03 bytes, height of #N$09 rows.
B $72A5,$30,$06

b $72D5 Materialising Sprite 1
@ $72D5 label=MaterialisingSprite1
D $72D5 The sprite for the entity type #N$40.
. .
. #SPRITEAT$72D5(materialising-01*)
B $72D5,$02,$02 Width of #N$03 bytes, height of #N$0A rows.
B $72D7,$3C,$06

b $7313 Materialising Sprite 2
@ $7313 label=MaterialisingSprite2
D $7313 The sprite for the entity type #N$41.
. .
. #SPRITEAT$7313(materialising-02*)
B $7313,$02,$02 Width of #N$03 bytes, height of #N$0B rows.
B $7315,$42,$06

b $7357 Materialising Sprite 3
@ $7357 label=MaterialisingSprite3
D $7357 The sprite for the entity type #N$42.
. .
. #SPRITEAT$7357(materialising-03*)
B $7357,$02,$02 Width of #N$03 bytes, height of #N$0C rows.
B $7359,$48,$06

b $73A1 Materialising Sprite 4
@ $73A1 label=MaterialisingSprite4
D $73A1 The sprite for the entity type #N$43.
. .
. #SPRITEAT$73A1(materialising-04*)
B $73A1,$02,$02 Width of #N$03 bytes, height of #N$0D rows.
B $73A3,$4E,$06

b $73F1 Materialising Sprite 5
@ $73F1 label=MaterialisingSprite5
D $73F1 The sprite for the entity type #N$44.
. .
. #SPRITEAT$73F1(materialising-05*)
B $73F1,$02,$02 Width of #N$03 bytes, height of #N$0F rows.
B $73F3,$5A,$06

b $744D Materialising Sprite 6
@ $744D label=MaterialisingSprite6
D $744D The sprite for the entity type #N$45.
. .
. #SPRITEAT$744D(materialising-06*)
B $744D,$02,$02 Width of #N$03 bytes, height of #N$10 rows.
B $744F,$60,$06

b $74AF Materialising Sprite 7
@ $74AF label=MaterialisingSprite7
D $74AF The sprite for the entity type #N$46.
. .
. #SPRITEAT$74AF(materialising-07*)
B $74AF,$02,$02 Width of #N$03 bytes, height of #N$10 rows.
B $74B1,$60,$06

b $7511 Materialising Sprite 8
@ $7511 label=MaterialisingSprite8
D $7511 The sprite for the entity type #N$47.
. .
. #SPRITEAT$7511(materialising-08*)
B $7511,$02,$02 Width of #N$03 bytes, height of #N$11 rows.
B $7513,$66,$06

b $7579 Materialising Sprite 9
@ $7579 label=MaterialisingSprite9
D $7579 The sprite for the entity type #N$48.
. .
. #SPRITEAT$7579(materialising-09*)
B $7579,$02,$02 Width of #N$03 bytes, height of #N$16 rows.
B $757B,$84,$06

b $75FF Materialising Sprite 10
@ $75FF label=MaterialisingSprite10
D $75FF The sprite for the entity type #N$49.
. .
. #SPRITEAT$75FF(materialising-10*)
B $75FF,$02,$02 Width of #N$03 bytes, height of #N$18 rows.
B $7601,$90,$06

b $7691 Materialising Sprite 11
@ $7691 label=MaterialisingSprite11
D $7691 The sprite for the entity type #N$4A.
. .
. #SPRITEAT$7691(materialising-11*)
B $7691,$02,$02 Width of #N$03 bytes, height of #N$18 rows.
B $7693,$90,$06

b $7723 Materialising Sprite 12
@ $7723 label=MaterialisingSprite12
D $7723 The sprite for the entity type #N$4B.
. .
. #SPRITEAT$7723(materialising-12*)
B $7723,$02,$02 Width of #N$03 bytes, height of #N$1B rows.
B $7725,$A2,$06

b $77C7 Saucer Sprite 1
@ $77C7 label=SaucerSprite1
D $77C7 The sprite for the entity type #N$08.
. .
. #SPRITEAT$77C7(saucer-01*)
B $77C7,$02,$02 Width of #N$04 bytes, height of #N$19 rows.
B $77C9,$C8,$08

b $7891 Saucer Sprite 2
@ $7891 label=SaucerSprite2
D $7891 The sprite for the entity type #N$09.
. .
. #SPRITEAT$7891(saucer-02*)
B $7891,$02,$02 Width of #N$04 bytes, height of #N$1D rows.
B $7893,$E8,$08

b $797B Saucer Sprite 3
@ $797B label=SaucerSprite3
D $797B The sprite for the entity type #N$0A.
. .
. #SPRITEAT$797B(saucer-03*)
B $797B,$02,$02 Width of #N$04 bytes, height of #N$1F rows.
B $797D,$F8,$08

b $7A75 Saucer Sprite 4
@ $7A75 label=SaucerSprite4
D $7A75 The sprite for the entity type #N$0B.
. .
. #SPRITEAT$7A75(saucer-04*)
B $7A75,$02,$02 Width of #N$04 bytes, height of #N$1D rows.
B $7A77,$E8,$08

b $7B5F Smoke Sprite 4
@ $7B5F label=SmokeSprite4
D $7B5F The sprite for the entity types #N$3B and #N$57.
. .
. #SPRITEAT$7B5F(smoke-04*)
B $7B5F,$02,$02 Width of #N$04 bytes, height of #N$1D rows.
B $7B61,$E8,$08

b $7C49 Smoke Sprite 3
@ $7C49 label=SmokeSprite3
D $7C49 The sprite for the entity types #N$3A and #N$56.
. .
. #SPRITEAT$7C49(smoke-03*)
B $7C49,$02,$02 Width of #N$04 bytes, height of #N$1C rows.
B $7C4B,$E0,$08

b $7D2B Smoke Sprite 2
@ $7D2B label=SmokeSprite2
D $7D2B The sprite for the entity types #N$39 and #N$55.
. .
. #SPRITEAT$7D2B(smoke-02*)
B $7D2B,$02,$02 Width of #N$04 bytes, height of #N$20 rows.
B $7D2D,$0100,$08

b $7E2D Smoke Sprite 1
@ $7E2D label=SmokeSprite1
D $7E2D The sprite for the entity types #N$38 and #N$54.
. .
. #SPRITEAT$7E2D(smoke-01*)
B $7E2D,$02,$02 Width of #N$04 bytes, height of #N$20 rows.
B $7E2F,$0100,$08

b $7F2F Pellet Sprite 1
@ $7F2F label=PelletSprite1
D $7F2F The sprite for the entity type #N$30.
. .
. #SPRITEAT$7F2F(pellet-01*)
B $7F2F,$02,$02 Width of #N$02 bytes, height of #N$0F rows.
B $7F31,$3C,$04

b $7F6D Pellet Sprite 2
@ $7F6D label=PelletSprite2
D $7F6D The sprite for the entity type #N$31.
. .
. #SPRITEAT$7F6D(pellet-02*)
B $7F6D,$02,$02 Width of #N$02 bytes, height of #N$10 rows.
B $7F6F,$40,$04

b $7FAF Pellet Sprite 7
@ $7FAF label=PelletSprite7
D $7FAF The sprite for the entity type #N$36.
. .
. #SPRITEAT$7FAF(pellet-07*)
B $7FAF,$02,$02 Width of #N$03 bytes, height of #N$14 rows.
B $7FB1,$78,$06

b $8029 Pellet Sprite 8
@ $8029 label=PelletSprite8
D $8029 The sprite for the entity type #N$37.
. .
. #SPRITEAT$8029(pellet-08*)
B $8029,$02,$02 Width of #N$03 bytes, height of #N$12 rows.
B $802B,$6C,$06

b $8097 Pellet Sprite 3
@ $8097 label=PelletSprite3
D $8097 The sprite for the entity type #N$32.
. .
. #SPRITEAT$8097(pellet-03*)
B $8097,$02,$02 Width of #N$03 bytes, height of #N$0F rows.
B $8099,$5A,$06

b $80F3 Pellet Sprite 4
@ $80F3 label=PelletSprite4
D $80F3 The sprite for the entity type #N$33.
. .
. #SPRITEAT$80F3(pellet-04*)
B $80F3,$02,$02 Width of #N$03 bytes, height of #N$0F rows.
B $80F5,$5A,$06

b $814F Pellet Sprite 5
@ $814F label=PelletSprite5
D $814F The sprite for the entity type #N$34.
. .
. #SPRITEAT$814F(pellet-05*)
B $814F,$02,$02 Width of #N$02 bytes, height of #N$10 rows.
B $8151,$40,$04

b $8191 Pellet Sprite 6
@ $8191 label=PelletSprite6
D $8191 The sprite for the entity type #N$35.
. .
. #SPRITEAT$8191(pellet-06*)
B $8191,$02,$02 Width of #N$02 bytes, height of #N$0F rows.
B $8193,$3C,$04

b $81CF Dome Sprite 1
@ $81CF label=DomeSprite1
D $81CF The sprite for the entity type #N$0C.
. .
. #SPRITEAT$81CF(dome-01*)
B $81CF,$02,$02 Width of #N$03 bytes, height of #N$1D rows.
B $81D1,$AE,$06

b $827F Dome Sprite 2
@ $827F label=DomeSprite2
D $827F The sprite for the entity type #N$0D.
. .
. #SPRITEAT$827F(dome-02*)
B $827F,$02,$02 Width of #N$03 bytes, height of #N$1E rows.
B $8281,$B4,$06

b $8335 Dome Sprite 3
@ $8335 label=DomeSprite3
D $8335 The sprite for the entity type #N$0E.
. .
. #SPRITEAT$8335(dome-03*)
B $8335,$02,$02 Width of #N$03 bytes, height of #N$1E rows.
B $8337,$B4,$06

b $83EB Dome Sprite 4
@ $83EB label=DomeSprite4
D $83EB The sprite for the entity type #N$0F.
. .
. #SPRITEAT$83EB(dome-04*)
B $83EB,$02,$02 Width of #N$03 bytes, height of #N$1D rows.
B $83ED,$AE,$06

b $849B Socket Sprite
@ $849B label=SocketSprite
D $849B The sprite for the entity type #N$69. It is drawn for the map cells of
. type #N$0F.
. .
. #SPRITEAT$849B(socket*)
B $849B,$02,$02 Width of #N$03 bytes, height of #N$15 rows.
B $849D,$7E,$06

b $851B Installed Program Sprite 1
@ $851B label=InstalledProgramSprite1
D $851B The first frame of an installed program (entity type #N$74). Entity type
. #N$04 uses the same picture, and nothing sets that type. It is drawn for the
. map cells of type #N$02.
. .
. #SPRITEAT$851B(installed-program-01*)
B $851B,$02,$02 Width of #N$03 bytes, height of #N$1C rows.
B $851D,$A8,$06

b $85C5 Installed Program Sprite 3
@ $85C5 label=InstalledProgramSprite3
D $85C5 The third frame of an installed program (entity type #N$76). Entity type
. #N$05 uses the same picture, and nothing sets that type.
. .
. #SPRITEAT$85C5(installed-program-03*)
B $85C5,$02,$02 Width of #N$03 bytes, height of #N$1C rows.
B $85C7,$A8,$06

b $866F Installed Program Sprite 2
@ $866F label=InstalledProgramSprite2
D $866F The sprite for the entity type #N$75.
. .
. #SPRITEAT$866F(installed-program-02*)
B $866F,$02,$02 Width of #N$03 bytes, height of #N$1C rows.
B $8671,$A8,$06

b $8719 Installed Program Sprite 4
@ $8719 label=InstalledProgramSprite4
D $8719 The sprite for the entity type #N$77.
. .
. #SPRITEAT$8719(installed-program-04*)
B $8719,$02,$02 Width of #N$03 bytes, height of #N$1C rows.
B $871B,$A8,$06

b $87C3 Unused Figure Sprite 1
@ $87C3 label=UnusedFigureSprite1
D $87C3 The sprite for entity type #N$02. No entity is given this type, and no
. map cell uses it. #R$B05A would alternate it with the sprite for type #N$03.
. .
. #SPRITEAT$87C3(unused-figure-01*)
B $87C3,$02,$02 Width of #N$03 bytes, height of #N$1C rows.
B $87C5,$A8,$06

b $886D Unused Figure Sprite 2
@ $886D label=UnusedFigureSprite2
D $886D The sprite for entity type #N$03. No entity is given this type, and no
. map cell uses it.
. .
. #SPRITEAT$886D(unused-figure-02*)
B $886D,$02,$02 Width of #N$03 bytes, height of #N$1C rows.
B $886F,$A8,$06

b $8917 Dropped Program Sprite
@ $8917 label=DroppedProgramSprite
D $8917 The sprite for the entity types #N$5E and #N$6C. It is drawn for the map
. cells of type #N$06.
. .
. #SPRITEAT$8917(dropped-program*)
B $8917,$02,$02 Width of #N$03 bytes, height of #N$17 rows.
B $8919,$8A,$06

b $89A3 Robot Turning Sprite 3
@ $89A3 label=RobotTurningSprite3
D $89A3 The sprite for the entity types #N$22 and #N$23 and #N$2C and #N$2D.
. .
. #SPRITEAT$89A3(robot-turning-03*)
B $89A3,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $89A5,$CC,$06

b $8A71 Robot Turning Sprite 5
@ $8A71 label=RobotTurningSprite5
D $8A71 The sprite for the entity types #N$24 and #N$25 and #N$2A and #N$2B.
. .
. #SPRITEAT$8A71(robot-turning-05*)
B $8A71,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $8A73,$CC,$06

b $8B3F Robot Turning Sprite 1
@ $8B3F label=RobotTurningSprite1
D $8B3F The sprite for the entity types #N$20 and #N($21), #N$26 to #N($29),
. #N($2E) and #N($2F), #N$5F and #N$6D.
. .
. #SPRITEAT$8B3F(robot-turning-01*)
B $8B3F,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $8B41,$CC,$06

b $8C0D Robot Walking Sprite 1
@ $8C0D label=RobotWalkingSprite1
D $8C0D The sprite for the entity types #N$10 and #N$1C.
. .
. #SPRITEAT$8C0D(robot-walking-01*)
B $8C0D,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $8C0F,$CC,$06

b $8CDB Robot Walking Sprite 2
@ $8CDB label=RobotWalkingSprite2
D $8CDB The sprite for the entity types #N($11), #N($13), #N$1D and #N$1F.
. .
. #SPRITEAT$8CDB(robot-walking-02*)
B $8CDB,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $8CDD,$CC,$06

b $8DA9 Robot Walking Sprite 3
@ $8DA9 label=RobotWalkingSprite3
D $8DA9 The sprite for the entity types #N$12 and #N$1E.
. .
. #SPRITEAT$8DA9(robot-walking-03*)
B $8DA9,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $8DAB,$CC,$06

b $8E77 Robot Walking Sprite 5
@ $8E77 label=RobotWalkingSprite5
D $8E77 The sprite for the entity types #N$14 and #N$18.
. .
. #SPRITEAT$8E77(robot-walking-05*)
B $8E77,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $8E79,$CC,$06

b $8F45 Robot Walking Sprite 6
@ $8F45 label=RobotWalkingSprite6
D $8F45 The sprite for the entity types #N($15), #N($17), #N$19 and #N$1B.
. .
. #SPRITEAT$8F45(robot-walking-06*)
B $8F45,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $8F47,$CC,$06

b $9013 Robot Walking Sprite 7
@ $9013 label=RobotWalkingSprite7
D $9013 The sprite for the entity types #N$16 and #N$1A.
. .
. #SPRITEAT$9013(robot-walking-07*)
B $9013,$02,$02 Width of #N$03 bytes, height of #N$22 rows.
B $9015,$CC,$06

b $90E1 Sector Wall Along Y Sprite
@ $90E1 label=SectorWallAlongYSprite
D $90E1 The sprite for the entity type #N$5D. It is drawn for the map cells of
. type #N$04.
. .
. #SPRITEAT$90E1(sector-wall-along-y*)
B $90E1,$02,$02 Width of #N$03 bytes, height of #N$21 rows.
B $90E3,$C6,$06

b $91A9 Sector Wall Along X Sprite
@ $91A9 label=SectorWallAlongXSprite
D $91A9 The sprite for the entity type #N$5C. It is drawn for the map cells of
. type #N$05.
. .
. #SPRITEAT$91A9(sector-wall-along-x*)
B $91A9,$02,$02 Width of #N$03 bytes, height of #N$21 rows.
B $91AB,$C6,$06

b $9271 Wall Along Y Sprite
@ $9271 label=WallAlongYSprite
D $9271 The sprite for the entity type #N$5B. It is drawn for the map cells of
. type #N$0A.
. .
. #SPRITEAT$9271(wall-along-y*)
B $9271,$02,$02 Width of #N$03 bytes (with the flags #N$40), height of #N$21
. rows.
B $9273,$C6,$06

b $9339 Wall Along X Sprite
@ $9339 label=WallAlongXSprite
D $9339 The sprite for the entity type #N$5A. It is drawn for the map cells of
. type #N$0B.
. .
. #SPRITEAT$9339(wall-along-x*)
B $9339,$02,$02 Width of #N$03 bytes (with the flags #N$40), height of #N$21
. rows.
B $933B,$C6,$06

b $9401 Border Graphics
@ $9401 label=BorderGraphics
D $9401 The graphics for the beads of the frame around the screen, which are
. drawn by #R$B5EB. There are four characters, which make two pairs.
. .
. #UDGARRAY4,attr=$47,scale=8($9401-$941F-$08)(border-beads)
B $9401,$20,$08

b $9421 Panel Graphics
@ $9421 label=PanelGraphics
D $9421 The graphics of the characters that are used to build the panel, which
. are numbered from #N$00.
. .
. #UDGARRAY30,attr=$47,scale=3($9421-$9509-$08)(panel-graphics)
B $9421,$F0,$08

b $9511 Panel Characters
@ $9511 label=PanelCharacters
D $9511 The characters of the panel, which is #N$08 characters wide and #N$0F
. characters tall. They are drawn by #R$B4B9.
. .
. #PANEL(panel)
B $9511,$78,$08

b $9589 Panel Attributes
@ $9589 label=PanelAttributes
D $9589 The attributes of the panel, which is #N$08 characters wide and #N$0F
. characters tall.
B $9589,$78,$08

c $9601 Game Entry
@ $9601 label=GameEntry
D $9601 The game starts here, as the first instruction at #N$6000 jumps to this
. address. Interrupts stay disabled for the whole game, apart from the short
. windows used to wait for the next frame (see #R$9F4D).
  $9601,$01 Disable interrupts.
  $9602,$03 Move the stack pointer to the top of the area below the game code,
. as the stack grows downwards from #N$6000.
  $9605,$02 Select interrupt mode 1.
  $9607,$03 Convert all of the sprites to the form used by #R$B2BC, using
. #R$9C20.
  $960A,$03 Point #REGhl at the font used by the game. Characters start at #N$20
. so this is #N$0100 below the start of the font data.
  $960D,$03 Use it as the current character set.
  $9610,$03 Jump to #R$98D0 to set up the game.

g $9613 Saved IY Register
@ $9613 label=SavedIY
D $9613 The value of #REGiy from when the game was started, which the ROM
. interrupt routine needs. It is put back every time the game waits for an
. interrupt.
W $9613,$02,$02

g $9615 Frame Counter
@ $9615 label=FrameCounter
D $9615 Counts the frames. It goes up by one in every frame, and is used for
. timing things.
W $9615,$02,$02

g $9617 Random Number
@ $9617 label=RandomNumber
D $9617 The random number. It is changed in every frame by adding the high byte
. of the frame counter and the memory refresh register to it, and by some of the
. routines that use it.
B $9617,$01,$01

g $9618 Character Set Address
@ $9618 label=CharacterSetAddress
D $9618 The address of the character set that is used for printing text, which
. is the address of character #N$00. The font for the game starts with character
. #N($20), so for that it is #N$0100 bytes before the start of the data.
W $9618,$02,$02

g $961A Control Method
@ $961A label=ControlMethod
D $961A The method of control that has been chosen in the menu, which is in bits
. 1 and 2: #N$00 is the keyboard, #N$01 is the Kempston joystick, #N$02 is the
. cursor keys and #N$03 is Sinclair interface 2.
B $961A,$01,$01

g $961B Scores
@ $961B label=Scores
D $961B The scores of the two players, which are each three bytes of binary
. coded decimal with the most significant byte first.
B $961B,$02,$02 Player 1, the first two bytes.
@ $961D label=Scores_Player1_LastByte
B $961D,$01,$01 Player 1, the last byte.
@ $961E label=Scores_Player2
B $961E,$03,$03 Player 2.

g $9621 Sprite Row Width
@ $9621 label=SpriteRowWidth
D $9621 The number of bytes that are written to the buffer for each row of a
. sprite that is being drawn.
B $9621,$01,$01

g $9622 Sprite Rows Left
@ $9622 label=SpriteRowsLeft
D $9622 The number of rows of the sprite that is being drawn that are still to
. be drawn.
B $9622,$01,$01

g $9623 Saved Stack Pointer
@ $9623 label=SavedStackPointer
D $9623 Holds the stack pointer while a routine is using it for other things:
. the routines that draw sprites and that clear and copy the buffer.
W $9623,$02,$02

g $9625 Controls
@ $9625 label=Controls
D $9625 The controls that have been read but not used yet. A bit stays set until
. the robot has used it: bit 0 turns right, bit 1 turns left, bit 2 moves
. forward, bit 3 uses the action key, bit 4 fires the second weapon and bit 5
. fires the first.
B $9625,$01,$01

g $9626 Fraction Difference
@ $9626 label=FractionDifference
D $9626 The difference between the fractions of the horizontal and vertical
. positions of the robot, in sixteenths of a cell. It is used when the cells of
. the map are projected onto the screen.
B $9626,$01,$01

g $9627 Fraction Sum
@ $9627 label=FractionSum
D $9627 The sum of the fractions of the horizontal and vertical positions of the
. robot, in sixteenths of a cell.
B $9627,$01,$01

g $9628 Text Attribute
@ $9628 label=TextAttribute
D $9628 The attribute that is used for the text that is printed using #R$BD82.
B $9628,$01,$01

g $9629 Light Turned Flag
@ $9629 label=LightTurnedFlag
D $9629 Set when a light that goes round the frame of the screen has been turned
. round, so that it is only turned once.
B $9629,$01,$01

g $962A Draw List Pointer
@ $962A label=DrawListPointer
D $962A The address of the next free entry of the draw list.
W $962A,$02,$02

g $962C Cell Position
@ $962C label=CellPosition
D $962C The column (the first byte) and the row (the second byte) of the map
. cell that was last looked at.
B $962C,$02,$01

g $962E Cell Address
@ $962E label=CellAddress
D $962E The address in the map of the cell that was last looked at.
W $962E,$02,$02

g $9630 Idle Timer
@ $9630 label=IdleTimer
D $9630 Counts down while the menu is being shown. When it reaches zero the hall
. of fame is shown.
W $9630,$02,$02

g $9632 Last Control Method
@ $9632 label=LastControlMethod
D $9632 The method of control that was selected the last time that the menu was
. drawn, which is used to tell if it has changed.
B $9632,$01,$01

g $9633 Name Entered Flag
@ $9633 label=NameEnteredFlag
D $9633 Set when a score has been put in the hall of fame, so that the hall of
. fame is shown.
B $9633,$01,$01

g $9634 Places Higher
@ $9634 label=PlacesHigher
D $9634 The number of places in the hall of fame that a new score is higher
. than.
B $9634,$01,$01

g $9635 Unused Stack Pointer
@ $9635 label=UnusedStackPointer
D $9635 The stack pointer is stored here by the main loop, but it is never used.
W $9635,$02,$02

g $9637 Tune Played Flag
@ $9637 label=TunePlayedFlag
D $9637 Set when the tune on the menu has been played, so that it is only played
. once.
B $9637,$01,$01

g $9638 Enemy Hit Address
@ $9638 label=EnemyHitAddress
D $9638 The address of the enemy that has been hit by a shot.
W $9638,$02,$02

g $963A Battery Energy
@ $963A label=BatteryEnergy
D $963A The energy that is left in the battery, as a 16-bit number. The high
. byte is the level that is shown on the battery bar, from #N$00 to #N$74.
W $963A,$02,$02

g $963C Displayed Battery Level
@ $963C label=DisplayedBatteryLevel
D $963C The level of the battery that is shown on the battery bar at the moment,
. which moves one pixel column at a time towards the level in the high byte of
. the battery energy.
B $963C,$01,$01

g $963D Cell To Check
@ $963D label=CellToCheck
D $963D The column (the low byte) and the row (the high byte) of the map cell
. that is checked in the next frame.
W $963D,$02,$02

g $963F Shot Cost
@ $963F label=ShotCost
D $963F The amount of energy that is used by the shot that is being fired.
W $963F,$02,$02

g $9641 Program Queue
@ $9641 label=ProgramQueue
D $9641 The queue of programs that the robot has picked up. The first four are
. shown as icons in the panel and the last is the one that is used next when the
. action key is pressed.
B $9641,$03,$03
@ $9644 label=ProgramQueue_Fourth
B $9644,$01,$01
@ $9645 label=ProgramQueue_Last
B $9645,$01,$01

g $9646 Attack Timer
@ $9646 label=AttackTimer
D $9646 The number of frames until the next sector is attacked.
B $9646,$01,$01

g $9647 Attacked Sector
@ $9647 label=AttackedSector
D $9647 The code of the sector that is under attack. The row is in bits 6 and 7,
. and the column is in bits 1 and 2, and a value of #N$03 for either means that
. no sector is attacked.
B $9647,$01,$01

g $9648 Robot Marker Position
@ $9648 label=RobotMarkerPosition
D $9648 The horizontal position (the first word) and the vertical position (the
. second word) of the robot when its marker on the map of the sectors was last
. drawn. The fraction is the low byte of each and the cell is the high byte.
W $9648,$04,$02

g $964C Packet Marker
@ $964C label=PacketMarker
D $964C The cell where the marker for the program packet was last drawn on the
. map of the sectors: the column, the row, and a flag that is set if there is a
. marker.
B $964C,$03,$01

g $964F Scroll Flag
@ $964F label=ScrollFlag
D $964F Set when the message area has to be scrolled up before the next message
. is printed.
B $964F,$01,$01

g $9650 Battery Low Flag
@ $9650 label=BatteryLowFlag
D $9650 Set when the message "BATTERY LOW" has been queued, so that it is only
. queued once.
B $9650,$01,$01

g $9651 Unused Variable
@ $9651 label=UnusedVariable3
D $9651 This byte is not used.
S $9651,$01,$01

g $9652 Action Key Used Flag
@ $9652 label=ActionKeyUsedFlag
D $9652 Set when the action key has been used, so that holding it down does not
. use it again.
B $9652,$01,$01

g $9653 Previous Position
@ $9653 label=PreviousPosition
D $9653 The horizontal position (the first word) and the vertical position (the
. second word) that an entity had before it was moved, so that the move can be
. undone.
W $9653,$04,$02

g $9657 Scroll Counter
@ $9657 label=ScrollCounter
D $9657 The number of pixel rows that the message area still has to be scrolled
. up.
B $9657,$01,$01

g $9658 Sectors Activated
@ $9658 label=SectorsActivated
D $9658 The number of sectors that have been activated.
B $9658,$01,$01

g $9659 Sectors Destroyed
@ $9659 label=SectorsDestroyed
D $9659 The number of sectors that have been destroyed.
B $9659,$01,$01

g $965A Sectors Dealt With
@ $965A label=SectorsDealtWith
D $965A The number of sectors that have been activated or destroyed.
B $965A,$01,$01

g $965B Sector Flags
@ $965B label=SectorFlags
D $965B One flag for each of the nine sectors, which is set (#N$FF) when the
. sector has been activated.
B $965B,$09,$09

g $9664 Unused Variables
@ $9664 label=UnusedVariables1
D $9664 These bytes are not used.
S $9664,$07,$07

g $966B Characters Printed
@ $966B label=CharactersPrinted
D $966B The number of characters of the current message that have been printed.
B $966B,$01,$01

g $966C Message Queue
@ $966C label=MessageQueue
D $966C The queue of the messages that are to be shown in the message area.
. There are eight entries of two bytes each: the number of the message (zero if
. the entry is free) and its argument. The values that are in the snapshot are
. left over from before the game was started.
B $966C,$02,$02
@ $966E label=MessageQueue_Second
B $966E,$0E,$02

g $967C Unused Variables
@ $967C label=UnusedVariables2
D $967C These bytes are not used.
S $967C,$02,$02

g $967E Sector States
@ $967E label=SectorStates
D $967E The state of each of the nine sectors. Bit 0 is set if the sector has
. been destroyed, bit 1 is set if it has been activated and bit 2 is set if it
. is under attack.
B $967E,$09,$09

g $9687 Unused Variable
@ $9687 label=UnusedVariable
D $9687 This byte is not used.
S $9687,$01,$01

g $9688 Sound Effect
@ $9688 label=SoundEffect
D $9688 The sound effect #R$BFDA is playing. The first byte is the number of
. tones still to play, or zero when nothing is playing. The second byte is the
. effect number (#N$00 to #N$03). #R$BFDA counts the first byte down and does
. not read the effect number.
B $9688,$02,$01

g $968A Player Number
@ $968A label=PlayerNumber
D $968A The number of the player, which is cleared when a game is started and is
. not used.
B $968A,$01,$01

g $968B Lives
@ $968B label=Lives
D $968B The number of lives that the player has left.
B $968B,$01,$01

g $968C Unused Variable
@ $968C label=UnusedVariable2
D $968C This variable is set to #N$80 when a game is started, and is never used.
B $968C,$01,$01

g $968D Unused Bytes
@ $968D label=UnusedBytes
D $968D These bytes are not used.
S $968D,$03,$03

g $9690 Entities
@ $9690 label=Entities
D $9690 The entities, which are the robot, the shots, the enemies, the program
. packet and the clouds. Each is #N$10 bytes long. The entity is not in use if
. its type is zero.
. #TABLE(default,centre)
. { =h Byte | =h What it holds }
. { #N$00 | Sprite type. Bit 7 flips it. Bits 0 and 1 pick the frame. }
. { #N$01 | Fraction of the horizontal position. }
. { #N$02 | Horizontal cell. }
. { #N$03 | Fraction of the vertical position. }
. { #N$04 | Vertical cell. }
. { #N$05 | Type it becomes after materialising. }
. { #N$06 | Robot wait timer, or the robot's speed. }
. { #N$07 | Direction in the low two bits, or a shot's range. }
. { #N$08 | Item an enemy is carrying. }
. { #N$09 | Time a destroyer has left. }
. { #N$0A-#N$0D | Left unused by the handlers. }
. { #N$0E | Program packet state: low four bits count, bit 7 destroyed. }
. { #N$0F | Bit 0 set while the entity is visible. }
. TABLE#
. Entity #N$00 is the robot, entities #N$01 to #N$03 are the shots,
. entities #N$04 to #N$09 are the enemies, entities #N$0A to #N$0D are the
. destroyers, entity #N$0E is the program packet and entities #N$0F to #N$12 are
. not used. The templates for the cells of the map come after them, and the last
. two entities are the clouds.
S $9690,$10,$10
@ $96A0 label=ShotEntities
S $96A0,$30,$10
@ $96D0 label=EnemyEntities
S $96D0,$60,$10
@ $9730 label=DestroyerEntities
S $9730,$40,$10
@ $9770 label=ProgramPacketEntity
S $9770,$10,$10
S $9780,$40,$10

g $97C0 Cell Templates
@ $97C0 label=CellTemplates
D $97C0 The templates for the cells of the map, which are used to draw them in
. the same way as entities. Each is #N$10 bytes long, and they are for the cell
. types #N$01 to #N$0F. The first byte of each is the sprite type, and bytes
. #N$01 and #N$03 are offsets for its position, which are all zero. The handler
. for that sprite type runs on the template, which is how a program and an
. activated terminal animate.
. #TABLE(default,centre)
. { =h Cell | =h Sprite | =h Drawn as }
. { #N$01 | #N$4C | Hazard }
. { #N$02 | #N$74 | Installed program }
. { #N$03 | #N$06 | Battery }
. { #N$04 | #N$5D | Sector wall along Y }
. { #N$05 | #N$5C | Sector wall along X }
. { #N$06 | #N$5E | Dropped program }
. { #N$07 | #N$4D | Hazard }
. { #N$08 | #N$4E | Transmitter }
. { #N$09 | #N$68 | Terminal }
. { #N$0A | #N$5B | Wall along Y }
. { #N$0B | #N$5A | Wall along X }
. { #N$0C | #N$6B | Wall corner }
. { #N$0D | #N$6A | Wall post }
. { #N$0E | #N$70 | Activated terminal }
. { #N$0F | #N$69 | Socket }
. TABLE#
B $97C0,$F0,$10

g $98B0 Cloud Entities
@ $98B0 label=CloudEntities
D $98B0 The two entities that are used for the clouds of smoke.
S $98B0,$20,$10

c $98D0 Initialise Game
@ $98D0 label=InitialiseGame
D $98D0 Sets up the screen and the tables used by the game and then shows the
. title screen. This routine never returns.
  $98D0,$03 Point #REGhl at the first of the game variables.
  $98D3,$03 There are #N$01AD bytes to clear, which covers the variables and the
. first #N$13 entries of the entity table.
  $98D6,$03 Zero them using #R$B1A3.
  $98D9,$04 Save #REGiy, as it is restored every time the game waits for an
. interrupt.
  $98DD,$03 Set the border to black.
  $98E0,$03 Point #REGde at an address in ROM, so that the screen is not
. touched.
  $98E3,$03 Initialise the off-screen buffer using #R$B21F.
  $98E6,$03 Build the tables that are used to shift sprites using #R$B294.
  $98E9,$03 Clear the screen using #R$B1AD.
  $98EC,$03 Draw the border around the screen using #R$B5EB.
N $98EF The game comes back here when it has ended.
@ $98EF label=TitleScreen
  $98EF,$03 Draw the panel using #R$B4B9.
  $98F2,$03 Print the score using #R$B585.
  $98F5,$03 Print the hi-score using #R$B56B.
  $98F8,$03 Point #REGhl at #R$961B.
  $98FB,$03 There are #N$01A5 bytes to clear, which covers the scores, the
. variables and the first #N$13 entries of the entity table.
  $98FE,$03 Zero them using #R$B1A3.
  $9901,$03 Clear the large window using #R$B20A.
  $9904,$03 Show the menu using #R$BB12, which returns when the player has
. chosen to start the game.
  $9907,$03 Start the game using #R$B72B.

c $990A Start Round
@ $990A label=StartRound
D $990A Sets up everything needed to start (or restart) the play area, and then
. falls through into the main loop. The game also comes back here when a new
. round starts after all of the sectors have been activated.
E $990A Continue on to #R$993C.
  $990A,$03 Point #REGhl at the bottom part of the panel, which is in character
. column #N$18 of row #N$10.
  $990D,$03 The block to clear is #N$08 bytes wide (#REGb) and #N$40 pixel rows
. tall (#REGc).
  $9910,$03 Clear it using #R$B1F2.
  $9913,$03 Put the camera at the corner of cell #N$18 in both directions.
  $9916,$03 Set the X position of the camera.
  $9919,$03 Set the Y position of the camera.
  $991C,$03 Count the programs that are installed in each sector using #R$9BCE.
  $991F,$02 Use bright white on black as the attribute.
  $9921,$03 Colour the play window using #R$B1C2.
  $9924,$03 Take the random number...
  $9927,$02 ...limited to #N$00-#N$3F...
  $9929,$01 ...as the column of the map cell that is checked next.
  $992A,$02 Take a number from the memory refresh register...
  $992C,$02 ...limited to #N$00-#N$3F...
  $992E,$01 ...as the row of the map cell that is checked next.
  $992F,$03 Store the position of the first map cell to check.
  $9932,$05 Set the flag that says the next message is to be scrolled into the
. message area.
  $9937,$05 Set a delay of #N$80 frames before the first attack on a sector.

c $993C Main Loop
@ $993C label=MainLoop
D $993C Runs once per frame. It checks whether the round is over, runs the
. handler of every entity, checks one cell of the map, draws the world and then
. updates the battery, the messages and the attacks on the sectors.
N $993C Check whether the program packet is still on its way, and whether the
. round has ended.
  $993C,$03 Fetch the type of the program packet (entity #N$0E).
  $993F,$03 Jump if there is no program packet.
  $9942,$03 Fetch the state of the program packet.
  $9945,$04 Skip the end of round checks while the state is not zero.
@ $9949 label=MainLoop_CheckRoundEnd
  $9949,$03 Fetch the number of sectors that have been destroyed.
  $994C,$05 Jump if all nine sectors have been destroyed, as the game is lost.
  $9951,$01 Keep the number of destroyed sectors.
  $9952,$03 Fetch the number of sectors that have been activated.
  $9955,$05 Jump if all nine have been activated, as the round has been won.
  $995A,$01 Add the number of destroyed sectors.
  $995B,$05 Jump if all nine sectors have been dealt with, one way or the other,
. to see how well the player has done.
  $9960,$03 Update the markers on the sector map using #R$AE2D.
N $9963 Run the handler of each entity, starting with the robot.
@ $9963 label=MainLoop_Entities
  $9963,$04 Point #REGix at the first entity (the robot).
  $9967,$03 Point #REGhl at #R$D355.
  $996A,$03 Save it as the current position in the draw list.
  $996D,$03 Read the controls using #R$B075.
@ $9970 label=MainLoop_Dispatch
  $9970,$04 Push the address of #R$9985, which is where the handler returns to.
  $9974,$03 Fetch the type of the entity.
  $9977,$03 Point #REGbc at #R$9F5B.
N $997A This entry point jumps to the routine in the table at #REGbc that is
. selected by #REGl.
@ $997A label=MainLoop_Dispatch_Table
  $997A,$02 Clear the high byte of the index.
  $997C,$01 Double the index.
  $997D,$02 Clear the high byte again, which discards the flip flag that was in
. bit 7 of the type.
  $997F,$01 Add the address of the table.
  $9980,$01 Fetch the low byte of the handler address...
  $9981,$01 ...and then the high byte...
  $9982,$01 ...into #REGhl.
  $9983,$01 Assemble the low byte of the handler address.
  $9984,$01 Run the handler.
N $9985 Each handler returns here.
@ $9985 label=MainLoop_NextEntity
  $9985,$03 Fetch the frame counter.
  $9988,$01 Keep the frame counter.
  $9989,$03 Fetch the random number.
  $998C,$01 Add the frame counter to it...
  $998D,$03 ...and store the result as the new random number.
  $9990,$03 Each entity is #N$10 bytes long.
  $9993,$02 Move on to the next entity.
  $9995,$03 Copy the address of the entity into #REGhl.
  $9998,$03 Point #REGbc at the end of the entity table.
  $999B,$03 Subtract the address of the end of the entity table.
  $999E,$02 Jump if every entity has been handled.
  $99A0,$02 Otherwise run the handler of the next entity.
N $99A2 Check one cell of the map, and then draw the frame.
@ $99A2 label=MainLoop_EndOfFrame
  $99A2,$03 Fetch the frame counter.
  $99A5,$01 Increment it...
  $99A6,$03 ...and store it.
  $99A9,$02 Fetch a number from the memory refresh register.
  $99AB,$01 Keep the refresh value.
  $99AC,$03 Fetch the random number.
  $99AF,$01 Add the high byte of the frame counter to it...
  $99B0,$01 ...and then the number from the memory refresh register...
  $99B1,$03 ...and store the result as the new random number.
  $99B4,$03 Fetch the position of the map cell that is checked next.
  $99B7,$01 Move to the next column.
  $99B8,$04 Limit the column to #N$00-#N$3F.
  $99BC,$04 Jump if the column is inside the #N$30 columns of the map.
  $99C0,$02 Otherwise go back to column #N$00...
  $99C2,$01 ...and move on to the next row.
  $99C3,$04 Limit the row to #N$00-#N$3F.
  $99C7,$04 Jump if the row is inside the #N$30 rows of the map.
  $99CB,$02 Otherwise go back to row #N$00.
@ $99CD label=MainLoop_StoreCell
  $99CD,$03 Store the position of the cell to check.
  $99D0,$01 Put the position in #REGde.
  $99D1,$03 Find the address of the cell in the map using #R$BF9D.
  $99D4,$03 Fetch the address of the cell.
  $99D7,$01 Fetch the contents of the cell.
  $99D8,$05 Is this a program transmitter (current and initial types both
. #N$08)? If so, send a program packet using #R$9DFE.
  $99DD,$02 Keep the initial type of the cell.
  $99DF,$04 Compare it with #N$30 (the result is never used), and jump over the
. code that is never run.
N $99E3 This code is never run.
@ $99E3 label=MainLoop_Unused
  $99E3,$02 Skip the rest if the initial type is not #N$30.
  $99E5,$01 Fetch the contents of the cell.
  $99E6,$02 Keep the initial type...
  $99E8,$01 ...in #REGb.
  $99E9,$04 Move the initial type into the low nibble.
  $99ED,$01 Combine it with the initial type...
  $99EE,$01 ...and write it back, so that the cell goes back to its initial
. type.
N $99EF Draw the world, then deal with the battery, the messages and the attacks
. on the sectors.
@ $99EF label=MainLoop_Draw
  $99EF,$03 Sort the draw list using #R$BF22.
  $99F2,$03 Add the cells of the map to the draw list using #R$BE5F.
  $99F5,$03 Sort the draw list again.
  $99F8,$03 Draw everything in the draw list into the off-screen buffer using
. #R$BF6A.
  $99FB,$03 Copy the off-screen buffer to the screen using #R$B21C.
  $99FE,$03 Try to start a new enemy using #R$A739.
  $9A01,$04 Save the stack pointer (this is never used).
  $9A05,$03 Check for the pause key using #R$9F09.
  $9A08,$03 Set up a delay that is only one iteration long.
@ $9A0B label=MainLoop_Delay
  $9A0B,$01 Count down.
  $9A0C,$04 Loop back until the delay has finished.
  $9A10,$03 Play the next part of the current sound effect using #R$BFDA.
  $9A13,$03 Update the battery bar using #R$9E5C.
  $9A16,$03 Flash the battery if it is low using #R$9EC6.
  $9A19,$03 Count down to the next attack on a sector using #R$9DA7.
  $9A1C,$03 Print the next character of the current message using #R$9C88.
  $9A1F,$03 Go round again.

c $9A22 Lose Game
@ $9A22 label=LoseGame
D $9A22 Shows the message that is used when every sector has been destroyed,
. plays the defeat tune and then ends the game.
  $9A22,$02 Use bright white on black as the attribute.
  $9A24,$03 Clear the play window using #R$B217.
  $9A27,$03 Point #REGde' at the attributes of the four lines of text (see
. #R$9B26).
  $9A2A,$01 Switch to the shadow registers, as #R$B8CE expects the attributes
. there.
  $9A2B,$03 Point #REGhl at #R$9B2A.
  $9A2E,$03 Point #REGde at #R$9B32.
  $9A31,$02 There are four lines to print.
  $9A33,$03 Print them using #R$B8CE.
  $9A36,$03 Point #REGde at #R$C2E9.
  $9A39,$03 Play it using #R$C0CF.
N $9A3C This entry point waits for a while and then ends the game.
@ $9A3C label=LoseGame_Wait
  $9A3C,$03 Set up a delay of #N$010000 iterations of the outer loop...
  $9A3F,$02 ...using #REGb as the second counter.
@ $9A41 label=LoseGame_Delay
  $9A41,$01 Count down.
  $9A42,$04 Loop back until the high byte has counted down to zero.
  $9A46,$02 Loop back until #REGb has counted down to zero too.
  $9A48,$03 End the game using #R$B6FD.

c $9A4B Win Round
@ $9A4B label=WinRound
D $9A4B Shows the message that is used when every sector has been activated and
. plays the victory tune. The robot then starts a new round on a fresh map with
. two more lives, up to a maximum of nine.
  $9A4B,$02 Use bright white on black as the attribute.
  $9A4D,$03 Clear the play window using #R$B217.
  $9A50,$03 Point #REGde' at the attributes of the five lines of text (see
. #R$9B70).
  $9A53,$01 Switch to the shadow registers, as #R$B8CE expects the attributes
. there.
  $9A54,$03 Point #REGhl at #R$9B75.
  $9A57,$03 Point #REGde at #R$9B7F.
  $9A5A,$02 There are five lines to print.
  $9A5C,$03 Print them using #R$B8CE.
N $9A5F The game comes here when the player has activated eight sectors and
. destroyed the last one.
@ $9A5F label=WinRound_Tune
  $9A5F,$03 Point #REGde at the tune that is played when the round is won.
  $9A62,$03 Play it using #R$C0CF.
  $9A65,$03 Reset the map and the screen for a new round using #R$BBAA.
  $9A68,$03 Point #REGhl at #R$968B.
  $9A6B,$01 Fetch the number of lives.
  $9A6C,$02 Add two lives.
  $9A6E,$04 Jump if the total is below #N$09.
  $9A72,$02 Otherwise limit it to nine lives.
@ $9A74 label=WinRound_StoreLives
  $9A74,$01 Store the number of lives.
  $9A75,$03 Point #REGhl at the variables that describe the state of the
. previous round.
  $9A78,$03 There are #N$69 bytes to clear.
  $9A7B,$03 Zero them using #R$B1A3.
  $9A7E,$03 Point #REGhl at #R$9690.
  $9A81,$03 The first #N$13 entities are cleared. The rest are templates for the
. map.
  $9A84,$03 Zero them using #R$B1A3.
  $9A87,$02 Use bright white on black as the attribute.
  $9A89,$03 Clear the play window using #R$B217.
  $9A8C,$03 Set the number of the sprite shown when the robot is starting using
. #R$A127.
  $9A8F,$03 Put the robot back at the start using #R$A99F.
  $9A92,$04 Set the displayed battery level to zero, so that the bar fills up
. from the left.
  $9A96,$03 Colour the cells of the sector map using #R$ADEA.
  $9A99,$03 Draw the panel using #R$B4B9.
  $9A9C,$03 Print the score using #R$B585.
  $9A9F,$03 Print the hi-score using #R$B56B.
  $9AA2,$03 Start the round using #R$990A.

c $9AA5 End Round
@ $9AA5 label=EndRound
D $9AA5 Used when every sector has either been destroyed or activated. It shows
. how many of each there are. If at least eight sectors have been activated then
. the player goes on to the next round, and otherwise the game is lost.
  $9AA5,$03 Fetch the number of sectors that have been destroyed.
  $9AA8,$02 Convert it into a digit...
  $9AAA,$03 ...and write it into the text of the message that shows it (see
. #R$9B00).
  $9AAD,$03 Fetch the number of sectors that have been activated.
  $9AB0,$02 Convert it into a digit...
  $9AB2,$03 ...and write it into the text of the message that shows it (see
. #R$9B13).
  $9AB5,$02 Use bright white on black as the attribute.
  $9AB7,$03 Clear the play window using #R$B217.
  $9ABA,$03 Point #REGde' at the attributes of the two lines of text (see
. #R$9AFA).
  $9ABD,$01 Switch to the shadow registers, as #R$B8CE expects the attributes
. there.
  $9ABE,$03 Point #REGhl at #R$9AFC.
  $9AC1,$03 Point #REGde at #R$9B00.
  $9AC4,$02 There are two lines to print.
  $9AC6,$03 Print them using #R$B8CE.
  $9AC9,$03 Fetch the number of sectors that have been activated.
  $9ACC,$04 Jump if at least eight sectors have been activated.
  $9AD0,$03 Point #REGde' at the attributes of the last two lines of the defeat
. message.
  $9AD3,$01 Switch to the shadow registers.
  $9AD4,$03 Point #REGhl at #R$9B2E.
  $9AD7,$03 Point #REGde at #R$9B51.
  $9ADA,$02 There are two lines to print.
  $9ADC,$03 Print them using #R$B8CE.
  $9ADF,$03 Point #REGde at #R$C2E9.
  $9AE2,$03 Play it using #R$C0CF.
  $9AE5,$03 Wait for a while and end the game using #R$9A3C.
N $9AE8 The player has activated at least eight sectors.
@ $9AE8 label=EndRound_Continue
  $9AE8,$03 Point #REGde' at the attributes of the last two lines of the victory
. message.
  $9AEB,$01 Switch to the shadow registers.
  $9AEC,$03 Point #REGhl at #R$9B7B.
  $9AEF,$03 Point #REGde at #R$9BAC.
  $9AF2,$02 There are two lines to print.
  $9AF4,$03 Print them using #R$B8CE.
  $9AF7,$03 Play the victory tune and start the next round using #R$9A5F.

t $9AFA Messaging: Round Result Text
@ $9AFA label=RoundResult_Attributes
D $9AFA The attributes, coordinates and text that are used by the screens shown
. at the end of a round. The attributes and coordinates are passed to #R$B8CE,
. which takes the coordinates as pairs of an X position and a Y position in
. pixels. Every string has bit 7 of its last character set.
B $9AFA,$02,$01 Attributes: #COLOUR(#PEEK(#PC)) and #COLOUR(#PEEK(#PC+1)).
@ $9AFC label=RoundResult_Coordinates
B $9AFC,$04,$02 Coordinates of the two lines of text.
@ $9B00 label=Message_SectorsDestroyed
  $9B00,$13,$12:$01 The number of sectors destroyed is written into the first
. character. "1 SECTORS DESTROYED".
@ $9B13 label=Message_SectorsActivated
  $9B13,$13,$12:$01 The number of sectors activated is written into the first
. character. "1 SECTORS ACTIVATED".
@ $9B26 label=DefeatMessage_Attributes
@ $9B28 label=DefeatMessage_Attributes_LastLines
B $9B26,$04,$01 Attributes: #COLOUR(#PEEK(#PC)) for each of the four lines of
. text.
@ $9B2A label=DefeatMessage_Coordinates
@ $9B2E label=DefeatMessage_Coordinates_LastLines
B $9B2A,$08,$02 Coordinates of the four lines of text.
@ $9B32 label=DefeatMessage_Text
  $9B32,$10,$0F:$01 "ALL SECTORS HAVE".
  $9B42,$0F,$0E:$01 "BEEN DESTROYED.".
@ $9B51 label=DefeatMessage_TextFailed
  $9B51,$0F,$0E:$01 "YOU HAVE FAILED".
  $9B60,$10,$0F:$01 "IN YOUR MISSION.".
@ $9B70 label=VictoryMessage_Attributes
@ $9B73 label=VictoryMessage_Attributes_LastLines
B $9B70,$05,$01 Attributes: #COLOUR(#PEEK(#PC)) for each of the five lines of
. text.
@ $9B75 label=VictoryMessage_Coordinates
@ $9B7B label=VictoryMessage_Coordinates_LastLines
B $9B75,$0A,$02 Coordinates of the five lines of text.
@ $9B7F label=VictoryMessage_Text
  $9B7F,$0F,$0E:$01 "CONGRATULATIONS".
  $9B8E,$12,$11:$01 "YOU HAVE ACTIVATED".
  $9BA0,$0C,$0B:$01 "ALL SECTORS.".
@ $9BAC label=VictoryMessage_TextContinue
  $9BAC,$10,$0F:$01 "YOU MAY CONTINUE".
  $9BBC,$12,$11:$01 "WITH YOUR MISSION.".

c $9BCE Count Sector Programs
@ $9BCE label=CountSectorPrograms
D $9BCE Counts the installed programs (map cells with both their current and
. initial type equal to #N$02) in each of the nine sectors. The result is the
. amount of energy that each sector starts with.
  $9BCE,$02 There are nine sectors, which are counted from the last to the
. first.
@ $9BD0 label=CountSectorPrograms_NextSector
  $9BD0,$01 Fetch the sector number...
  $9BD1,$01 ...which is one below the counter.
  $9BD2,$03 Point #REGhl at #R$A361.
  $9BD5,$03 Add the sector number, using #R$BF92, to find the entry for this
. sector.
  $9BD8,$02 Start the count for the sector at zero.
  $9BDA,$01 Fetch the sector number again.
  $9BDB,$01 The sector number is one below the counter.
  $9BDC,$01 Switch to the shadow registers, so that the counter in #REGhl' is
. the address of the entry for this sector.
  $9BDD,$01 Double the sector number...
  $9BDE,$01 ...to make an index into the table of offsets of the sectors in the
. map.
  $9BDF,$02 Clear the high byte of the index.
  $9BE1,$03 Point #REGhl at #R$9C0E.
  $9BE4,$01 Add the index.
  $9BE5,$01 Fetch the low byte of the offset of the sector...
  $9BE6,$01 ...and then the high byte...
  $9BE7,$01 ...into #REGde.
  $9BE8,$03 Point #REGhl at #R$C515.
  $9BEB,$01 Add the offset to find the first cell of the sector.
  $9BEC,$03 Count the programs in the sector using #R$9BF3.
  $9BEF,$01 Switch back to the main registers.
  $9BF0,$02 Loop back until every sector has been counted.
  $9BF2,$01 Return.

c $9BF3 Count Programs In Sector
@ $9BF3 label=CountSectorPrograms_Sector
D $9BF3 Counts the installed programs in a sector of #N$10 by #N$10 cells and
. adds each one to the energy of the sector.
R $9BF3 HL Address of the first cell of the sector in the map
R $9BF3 HL' Address of the energy of the sector
  $9BF3,$03 Each row of the map is #N$40 bytes long.
  $9BF6,$02 There are #N$10 rows in the sector.
@ $9BF8 label=CountSectorPrograms_Row
  $9BF8,$02 There are #N$10 cells in each row.
  $9BFA,$01 Save the address of the start of the row.
@ $9BFB label=CountSectorPrograms_Cell
  $9BFB,$01 Fetch the cell.
  $9BFC,$04 Jump if it is an installed program, which is a cell with a current
. and an initial type of #N$02.
@ $9C00 label=CountSectorPrograms_Next
  $9C00,$01 Move on to the next cell.
  $9C01,$02 Loop back until the whole row has been checked.
  $9C03,$01 Restore the address of the start of the row.
  $9C04,$01 Move down to the next row of the map.
  $9C05,$01 Count down the rows.
  $9C06,$02 Loop back until the whole sector has been checked.
  $9C08,$01 Return.
@ $9C09 label=CountSectorPrograms_Installed
  $9C09,$01 Switch to the shadow registers.
  $9C0A,$01 Add one to the energy of the sector.
  $9C0B,$01 Switch back to the main registers.
  $9C0C,$02 Jump back to carry on with the row.

w $9C0E Sector Offsets
@ $9C0E label=SectorOffsets
D $9C0E The offset into the map of the first cell of each sector. Sector #N$00
. is the top left, sector #N$01 is the one to the right of it, and sector #N$08
. is the bottom right. As the map starts with the bottom row of sectors, the
. offsets of the top row of sectors are the largest.
W $9C0E,$12,$02

c $9C20 Decode Sprites
@ $9C20 label=DecodeSprites
D $9C20 Converts every sprite from the form in which it is stored, a mask byte
. and then a pixel byte for each pair of bytes, into the form used by #R$B2BC,
. which is a mask byte followed by the XOR of the mask and the pixels. Sprites
. that are already marked as decoded (bit 6 of the first byte of the header) are
. left alone.
  $9C20,$03 Point #REGhl at the end of the table of sprite addresses (which is
. the address of the blank sprite).
  $9C23,$03 Point #REGde at #R$60A3.
  $9C26,$03 Subtract the start of the table to find its size in bytes.
  $9C29,$02 Halve it to find the number of sprites...
  $9C2B,$01 ...and use that as the counter.
@ $9C2C label=DecodeSprites_NextSprite
  $9C2C,$01 Save the counter.
  $9C2D,$01 The sprite number is one below the counter.
  $9C2E,$01 Use the sprite number as the low byte of the index...
  $9C2F,$02 ...and clear #REGh.
  $9C31,$01 Double it to make an index into the table.
  $9C32,$03 Point #REGde at #R$60A3.
  $9C35,$01 Add the index.
  $9C36,$01 Fetch the address of the sprite...
  $9C37,$01 ...from the table...
  $9C38,$01 ...into #REGde.
  $9C39,$01 Fetch the first byte of the header (the width, and flags).
  $9C3A,$04 Jump if the sprite has been decoded already.
  $9C3E,$02 Mark the sprite as decoded...
  $9C40,$01 ...and store the byte.
  $9C41,$04 Extract the width in bytes, and jump if the sprite is blank.
  $9C45,$01 Use the width as a counter.
  $9C46,$01 Move on to the height.
  $9C47,$01 Fetch it...
  $9C48,$01 ...and keep it in #REGc.
  $9C49,$03 Jump if the sprite is blank.
  $9C4C,$01 Multiply the height by the width, by adding it up that many times,
. to find the number of pairs of bytes.
@ $9C4D label=DecodeSprites_AddHeight
  $9C4D,$01 Add the height.
  $9C4E,$02 Loop back until done.
  $9C50,$01 Point #REGhl at the sprite data.
  $9C51,$01 Move on to the first pair of bytes.
  $9C52,$01 Use the number of pairs as a counter.
@ $9C53 label=DecodeSprites_Pair
  $9C53,$01 Fetch the mask.
  $9C54,$01 Move on to the pixels.
  $9C55,$01 Combine the mask with the pixels...
  $9C56,$01 ...and store the result.
  $9C57,$01 Move on to the next pair.
  $9C58,$02 Loop back until every pair has been converted.
@ $9C5A label=DecodeSprites_Next
  $9C5A,$01 Restore the sprite counter.
  $9C5B,$02 Loop back until every sprite has been decoded.
  $9C5D,$01 Return.

c $9C5E Find Sector
@ $9C5E label=FindSector
D $9C5E Finds the sector that an entity is in. The nine sectors are numbered
. from #N$00 for the top left to #N$08 for the bottom right.
R $9C5E IX Entity
R $9C5E O:D Sector number
  $9C5E,$03 Fetch the X cell of the entity.
  $9C61,$02 Keep the sector column, which is a multiple of #N$10...
  $9C63,$01 ...in #REGe.
  $9C64,$03 Fetch the Y cell of the entity.
  $9C67,$02 Keep the sector row...
  $9C69,$02 ...and turn it round, as the first row of sectors is at the bottom
. of the map...
  $9C6B,$02 ...and make it a multiple of #N$10 from #N$00 to #N($20), from the
. top.
  $9C6D,$01 Keep the sector row.
  $9C6E,$01 Add the column.
  $9C6F,$01 Halve it...
  $9C70,$01 ...and add the row, so that the result is three times the row plus
. the column, multiplied by #N$08.
  $9C71,$03 Shift down by three...
  $9C74,$01 ...to give the sector number.
  $9C75,$01 Return.

c $9C76 Queue Message
@ $9C76 label=QueueMessage
D $9C76 Adds a message to the queue of messages that are shown in the message
. area. The queue holds eight messages, and if it is full then the message is
. lost.
R $9C76 E Message number (#N$01 to #N($08), see #R$9D34)
R $9C76 D Argument (the sector number for message #N$01)
  $9C76,$03 Point #REGhl at the queue.
  $9C79,$02 There are eight places in the queue.
@ $9C7B label=QueueMessage_Search
  $9C7B,$01 Fetch the message number of the entry.
  $9C7C,$03 Jump if the entry is free.
  $9C7F,$01 Move on to the next entry...
  $9C80,$01 ...which is two bytes further on.
  $9C81,$02 Loop back until every entry has been checked.
  $9C83,$01 Return, as the queue is full.
@ $9C84 label=QueueMessage_Store
  $9C84,$01 Store the message number.
  $9C85,$01 Move on to the argument.
  $9C86,$01 Store the argument.
  $9C87,$01 Return.

c $9C88 Print Message
@ $9C88 label=PrintMessage
D $9C88 Called every frame. When the message area is being scrolled this does
. the scrolling. Otherwise it prints one more character of the first message in
. the queue, and when that is complete removes the message from the queue.
  $9C88,$03 Fetch the number of lines that are still to be scrolled.
  $9C8B,$03 Jump to scroll the message area up by one pixel row if the number is
. not zero.
  $9C8E,$03 Fetch the number of characters that have been printed of the current
. message.
  $9C91,$01 Test whether it is zero.
  $9C92,$03 Fetch the number of the first message in the queue.
  $9C95,$02 Jump if a message is being printed.
  $9C97,$02 Return if the queue is empty.
  $9C99,$03 Fetch the flag that is set when the previous message has been
. completed.
  $9C9C,$03 Jump if the area has been scrolled for this message already.
  $9C9F,$04 Clear the flag.
  $9CA3,$02 Scroll the message area by eight lines before the message is
. printed...
  $9CA5,$03 ...by setting the counter.
  $9CA8,$03 Point #REGhl at #R$966C.
  $9CAB,$01 Fetch its number.
  $9CAC,$02 Return if it is not message number one, which is "SECTOR n".
  $9CAE,$01 Move on to the argument, which is the sector number.
  $9CAF,$01 Fetch it.
  $9CB0,$02 Convert it into the digit that is the last character of the message
. (the number of the first sector is zero, but it is shown as #N($31), and bit 7
. is set as it is the last character).
  $9CB2,$03 Write it into the message.
  $9CB5,$01 Return.
@ $9CB6 label=PrintMessage_Start
  $9CB6,$03 Fetch the number of the message.
@ $9CB9 label=PrintMessage_Character
  $9CB9,$01 Double it to make an index into the table of messages.
  $9CBA,$03 Point #REGhl at #R$9D34.
  $9CBD,$01 Add the index to the address.
  $9CBE,$01 Keep the low byte of the message address.
  $9CBF,$02 Jump if there was no carry into the high byte.
  $9CC1,$01 Otherwise carry into the high byte.
@ $9CC2 label=PrintMessage_NoCarry
  $9CC2,$01 Fetch the address of the message...
  $9CC3,$01 ...from the table...
  $9CC4,$01 ...into #REGde.
  $9CC5,$02 Clear the high byte of the index.
  $9CC7,$03 Fetch the number of characters that have been printed.
  $9CCA,$01 Use it as the low byte of the index.
  $9CCB,$01 Add one...
  $9CCC,$03 ...and store it as the new number of characters printed.
  $9CCF,$01 Swap the index and the address of the message.
  $9CD0,$01 Find the address of the next character.
  $9CD1,$01 Fetch it...
  $9CD2,$01 ...and keep it in #REGc.
  $9CD3,$03 Fetch the character set that the game uses...
  $9CD6,$03 ...and use it to print text.
  $9CD9,$03 Point #REGhl at the position of the first character, with an X
. position of #N$28 and a Y position of #N$B0.
  $9CDC,$03 Convert it to a screen address using #R$BD4B.
  $9CDF,$01 Add the index of the character, so that each character is one column
. further to the right.
  $9CE0,$01 Fetch the character...
  $9CE1,$02 ...without the flag for the last character.
  $9CE3,$03 Print it using #R$B5CB.
  $9CE6,$01 Fetch the character again.
  $9CE7,$05 Jump to #R$C072 if this is not the last character.
  $9CEC,$03 Make the click for the character.
  $9CEF,$03 Point #REGde at #R$966C.
  $9CF2,$03 Point #REGhl at #R$966E.
  $9CF5,$03 Remove the entry that has been shown by moving the others down...
  $9CF8,$02 ...by one.
  $9CFA,$02 Clear the last entry.
  $9CFC,$01 Move on to the second byte of the last entry.
  $9CFD,$01 Clear that too.
  $9CFE,$03 Start the next message at its first character.
  $9D01,$02 Set the flag that says that the area has to be scrolled before the
. next message is shown...
  $9D03,$03 ...and store it.
  $9D06,$01 Return.

c $9D07 Scroll Message Area
@ $9D07 label=ScrollMessageArea
D $9D07 Scrolls the pixels of the message area (#N$12 characters wide and #N$10
. pixel rows tall) up by one pixel row.
R $9D07 A Number of lines still to scroll
  $9D07,$03 Point #REGhl at the position of the message area, with an X position
. of #N$28 and a Y position of #N$A8.
  $9D0A,$01 One less line has to be scrolled.
  $9D0B,$03 Store the new count.
  $9D0E,$03 Convert the position into a screen address using #R$BD4B.
  $9D11,$02 Scroll #N$12 columns, from left to right.
@ $9D13 label=ScrollMessageArea_Column
  $9D13,$01 Save the address of the top of the column.
  $9D14,$02 Each column is #N$10 pixels tall.
@ $9D16 label=ScrollMessageArea_Row
  $9D16,$02 Copy the address into #REGde, as the destination.
  $9D18,$01 Fetch the high byte of the address.
  $9D19,$01 Move #REGhl down by one pixel row.
  $9D1A,$05 Jump if the pixel row is in the same character row.
  $9D1F,$04 Otherwise go back to the first pixel row of the character row...
  $9D23,$01 Fetch the low byte of the address.
  $9D24,$02 Add #N$20 (this result is not used).
  $9D26,$04 ...and move down to the next character row.
@ $9D2A label=ScrollMessageArea_Copy
  $9D2A,$01 Fetch the byte from the pixel row below...
  $9D2B,$01 ...and copy it to the pixel row above.
  $9D2C,$02 Loop back until the column has been scrolled.
  $9D2E,$01 Restore the address of the top of the column.
  $9D2F,$01 Move on to the next column.
  $9D30,$01 Count down the columns.
  $9D31,$02 Loop back until every column has been scrolled.
  $9D33,$01 Return.

w $9D34 Message Table
@ $9D34 label=MessageTable
D $9D34 The addresses of the messages, which are numbered from #N$01. Message
. #N$00 does not exist. Each message has bit 7 of its last character set.
W $9D34,$12,$02

t $9D46 Messaging: Message Text
@ $9D46 label=Message_Sector
  $9D46,$08,$07:$01 Message number #N$01. The sector number is written into the
. last character, which is a space until a message with a sector number is
. printed. "SECTOR n".
@ $9D4E label=Message_ProgramSentFrom
  $9D4E,$11,$10:$01 Message number #N$02. "PROGRAM SENT FROM".
@ $9D5F label=Message_ProgramHasBeen
  $9D5F,$10,$0F:$01 Message number #N$03. "PROGRAM HAS BEEN".
@ $9D6F label=Message_Destroyed
  $9D6F,$09,$08:$01 Message number #N$04. "DESTROYED".
@ $9D78 label=Message_BatteryLow
  $9D78,$0B,$0A:$01 Message number #N$05. "BATTERY LOW".
@ $9D83 label=Message_UnderAttack
  $9D83,$0C,$0B:$01 Message number #N$06. "UNDER ATTACK".
@ $9D8F label=Message_Critical
  $9D8F,$08,$07:$01 Message number #N$07. "CRITICAL".
@ $9D97 label=Message_ProgramReceived
  $9D97,$10,$0F:$01 Message number #N$08. The game spells this "PROGRAM
. RECIEVED".

c $9DA7 Attack Sector
@ $9DA7 label=AttackSector
D $9DA7 Called every frame. It counts down to the next attack on one of the nine
. sectors. When the count reaches zero a sector is picked at random. If it still
. has some energy then it comes under attack, and the messages "SECTOR n" and
. "UNDER ATTACK" are queued. The attack lasts until the next sector is attacked.
  $9DA7,$03 Fetch the number of frames until the next attack.
  $9DAA,$01 Count down.
  $9DAB,$03 Store it.
  $9DAE,$01 Return if it has not reached zero.
  $9DAF,$02 Set the time until the next attack to #N$50 frames.
  $9DB1,$03 Store it.
  $9DB4,$03 Fetch the random number.
  $9DB7,$02 Keep the bits that choose the sector (bits 1 and 2 give the column,
. bits 6 and 7 the row).
  $9DB9,$01 Keep the sector bits.
  $9DBA,$02 Test the row.
  $9DBC,$04 Jump if it is #N($03), as there is no such row.
  $9DC0,$01 Fetch the number again.
  $9DC1,$02 Test the column.
  $9DC3,$04 Jump if it is #N($03), as there is no such column.
  $9DC7,$01 Move the column into bits 0 and 1...
  $9DC8,$01 ...and keep it in #REGd.
  $9DC9,$01 Fetch the number again.
  $9DCA,$02 Move the row into bits 0 and 1...
  $9DCC,$02 ...clear the other bits...
  $9DCE,$01 ...and keep the row in #REGe.
  $9DCF,$01 Double the row...
  $9DD0,$01 ...add the row to make three times the row...
  $9DD1,$01 ...and add the column to find the sector number.
  $9DD2,$01 Keep the sector number...
  $9DD3,$02 ...and clear #REGd.
  $9DD5,$03 Point #REGhl at #R$A361.
  $9DD8,$01 Add the sector number.
  $9DD9,$01 Fetch the energy of the sector.
  $9DDA,$03 Jump if the sector has no energy left, as it cannot be attacked.
  $9DDD,$03 Point #REGhl at #R$967E.
  $9DE0,$01 Add the sector number.
  $9DE1,$02 Mark the sector as under attack.
  $9DE3,$01 Use the sector number as the argument of the message...
  $9DE4,$02 ...for message #N($01), "SECTOR n".
  $9DE6,$03 Queue the message using #R$9C76.
  $9DE9,$03 Queue message #N($06), "UNDER ATTACK"...
  $9DEC,$03 ...as well.
  $9DEF,$03 Mark the sector as the one under attack and colour the sector map
. using #R$ADC3.
N $9DF2 The time until the next attack is shortened if there was no sector that
. could be attacked.
@ $9DF2 label=AttackSector_Retry
  $9DF2,$02 Set the time until the next attack to #N$20 frames.
@ $9DF4 label=AttackSector_Store
  $9DF4,$03 Store it.
  $9DF7,$03 Mark the sector as the one under attack and colour the sector map
. using #R$ADC3.
@ $9DFA label=AttackSector_NoEnergy
  $9DFA,$02 Set the time until the next attack to one frame.
  $9DFC,$02 Jump back to store it.

c $9DFE Send Program Packet
@ $9DFE label=SendProgramPacket
D $9DFE Starts a program packet flying from a program transmitter, unless one is
. already on its way. It queues the messages "PROGRAM SENT FROM" and "SECTOR n".
R $9DFE HL Address of the program transmitter in the map
  $9DFE,$03 Fetch the type of the program packet (entity #N$0E).
  $9E01,$02 Return if it is already in use.
  $9E03,$01 Save the address of the transmitter...
  $9E04,$01 ...twice.
  $9E05,$03 Point #REGhl at #R$9770.
  $9E08,$02 Clear all #N$10 bytes of the entity.
@ $9E0A label=SendProgramPacket_ClearEntity
  $9E0A,$02 Zero a byte.
  $9E0C,$01 Move on to the next byte.
  $9E0D,$02 Loop back until the entity has been cleared.
  $9E0F,$01 Restore the address of the transmitter.
  $9E10,$04 Point #REGix at #R$9770.
  $9E14,$04 Set the type of the entity to #N($6E), the first sprite of the
. program packet.
  $9E18,$03 Point #REGde at #R$C515.
  $9E1B,$02 Subtract it to find the offset of the transmitter.
  $9E1D,$01 Fetch the low byte of the offset.
  $9E1E,$02 The column is in the low six bits.
  $9E20,$02 Multiply the offset by four...
  $9E22,$01 ...and keep the column in #REGl.
  $9E23,$01 The row is in the high byte, in the low six bits.
  $9E24,$02 Limit the row to #N$00-#N$3F...
  $9E26,$01 ...and keep it in #REGh.
  $9E27,$03 Fetch the random number...
  $9E2A,$02 ...limited to #N$00-#N$3F...
  $9E2C,$03 ...as a timer for the program packet.
  $9E2F,$03 Set the X cell of the packet to that of the transmitter.
  $9E32,$03 Set the Y cell of the packet to that of the transmitter.
  $9E35,$01 Save the registers.
  $9E36,$01 Save the registers.
  $9E37,$03 Queue message #N($02), "PROGRAM SENT FROM"...
  $9E3A,$03 ...using #R$9C76.
  $9E3D,$03 Find the sector that the packet is in using #R$9C5E.
  $9E40,$02 Queue message #N($01), "SECTOR n"...
  $9E42,$03 ...using #R$9C76.
  $9E45,$03 Start effect #N$01 (five tones).
  $9E48,$03 Store the length and the effect number for #R$BFDA.
  $9E4B,$01 Restore the registers.
  $9E4C,$01 Restore the registers.
  $9E4D,$01 Restore the address of the transmitter.
  $9E4E,$01 Return.

c $9E4F Remove Entity
@ $9E4F label=RemoveEntity
D $9E4F Removes an entity. This routine is not used.
R $9E4F IX Entity
  $9E4F,$04 Set the type of the entity to zero.
  $9E53,$01 Discard the return address.
  $9E54,$01 Return to the caller of the routine that called this one.

c $9E55 Update Battery Bar
@ $9E55 label=UpdateBatteryBar_Increase
D $9E55 Moves the displayed level of the battery bar by one pixel column towards
. the actual level, which is a number from #N$00 to #N$74. The bar is drawn by
. toggling the pixels of one column, so it is added to or taken away from the
. end of the bar. This is called every frame.
  $9E55,$01 Add one to the displayed level.
  $9E56,$01 Keep the displayed level.
  $9E57,$03 Point #REGhl at the position of the column before the first one
. (which has an X position of #N$3F), so that when the level is added the column
. that is drawn is the first one that is not yet lit.
  $9E5A,$02 Jump to draw the column.
@ $9E5C label=UpdateBatteryBar
  $9E5C,$03 Fetch the actual level of the battery.
  $9E5F,$01 Keep the actual level.
  $9E60,$03 Fetch the displayed level of the battery.
  $9E63,$02 Return if the two are the same.
  $9E65,$02 Jump if the displayed level is lower than the actual level.
  $9E67,$01 Keep the displayed level.
  $9E68,$01 Take one pixel column off the displayed level.
  $9E69,$03 Point #REGhl at the position of the first column, which has an X
. position of #N$40 and a Y position of #N$94.
@ $9E6C label=UpdateBatteryBar_Draw
  $9E6C,$03 Store the new displayed level.
  $9E6F,$01 Add the X position to find the X position of the column that is to
. be drawn...
  $9E70,$01 ...and put it in the position.
  $9E71,$01 Keep the X position.
  $9E72,$03 Convert the position into a screen address using #R$BD4B.
  $9E75,$01 Fetch the level.
  $9E76,$01 Keep the level.
  $9E77,$01 Switch to the shadow registers.
  $9E78,$03 Point #REGhl' at #R$9EB9.
  $9E7B,$01 Switch back to the main registers.
  $9E7C,$01 Fetch the X position.
  $9E7D,$01 Find the number of the bit that the column is in, as a number of
. pixels from the right...
  $9E7E,$02 ...limited to a character.
  $9E80,$01 Keep the column within the character.
  $9E81,$02 The column has #N$08 rows.
  $9E83,$01 Add one, as it will be used to shift the pattern.
  $9E84,$01 Fetch the level.
  $9E85,$04 Jump if the level is at least five, as the column is then not part
. of the rounded end of the bar.
  $9E89,$01 Save the shift.
  $9E8A,$01 Save the screen address.
  $9E8B,$03 Point #REGhl at the table of the number of rows to skip at the top
. and the bottom of the column.
  $9E8E,$03 Add the level, using #R$BF92.
  $9E91,$01 Fetch the number of rows to skip.
  $9E92,$01 Restore the screen address.
@ $9E93 label=UpdateBatteryBar_SkipRows
  $9E93,$01 Take off two rows from the end of the column...
  $9E94,$01 ...for each row that is skipped at the top...
  $9E95,$01 ...and move down one pixel row.
  $9E96,$01 Switch to the shadow registers...
  $9E97,$01 ...and skip a byte of the pattern...
  $9E98,$01 ...and switch back.
  $9E99,$02 Loop back until the rows have been skipped.
  $9E9B,$01 Restore the shift.
@ $9E9C label=UpdateBatteryBar_Row
  $9E9C,$01 Switch to the shadow registers.
  $9E9D,$01 Fetch the next byte of the pattern.
  $9E9E,$01 Move on to the next byte of the pattern.
  $9E9F,$01 Switch back to the main registers.
  $9EA0,$01 Keep the screen address.
  $9EA1,$01 Put the byte of the pattern in #REGhl...
  $9EA2,$02 ...as a two byte number.
  $9EA4,$01 Fetch the level...
@ $9EA5 label=UpdateBatteryBar_ShiftPattern
  $9EA5,$01 ...and shift the pattern left by the number of pixels needed to put
. the pixel in the right place.
  $9EA6,$02 Restore the shift.
  $9EA8,$01 Keep the level.
  $9EA9,$01 Restore the screen address and the shifted pattern.
  $9EAA,$01 Fetch the first byte of the shifted pattern...
  $9EAB,$01 ...toggle it on the screen...
  $9EAC,$01 ...and store it.
  $9EAD,$01 Move on to the next byte of the screen.
  $9EAE,$01 Fetch the second byte of the shifted pattern...
  $9EAF,$01 ...toggle it on the screen...
  $9EB0,$01 ...and store it.
  $9EB1,$01 Move back to the first byte.
  $9EB2,$03 Move down to the next pixel row using #R$B558.
  $9EB5,$01 Count down the rows.
  $9EB6,$02 Loop back until the whole column has been drawn.
  $9EB8,$01 Return.

b $9EB9 Battery Bar Data
@ $9EB9 label=BatteryBarPattern
D $9EB9 The pattern of the pixels of a column of the battery bar, one byte per
. pixel row, followed by the number of rows that are skipped at the top and
. bottom of each of the first five columns, so that the bar has rounded ends.
B $9EB9,$08,$08 The pattern of a column.
@ $9EC1 label=BatteryBarRoundedEnd
B $9EC1,$05,$05 The number of rows to skip for each of the first five columns.

c $9EC6 Check Battery Low
@ $9EC6 label=CheckBatteryLow
D $9EC6 Called every frame. If the battery is almost empty then the message
. "BATTERY LOW" is queued, once, and the battery bar flashes red and yellow.
  $9EC6,$03 Fetch the level of the battery.
  $9EC9,$04 Jump if it is at least #N$18.
  $9ECD,$03 Fetch the flag that says the message has been queued.
  $9ED0,$03 Jump if it has.
  $9ED3,$01 Set the flag...
  $9ED4,$03 ...and store it.
  $9ED7,$03 Queue message #N($05), "BATTERY LOW"...
  $9EDA,$03 ...using #R$9C76.
@ $9EDD label=CheckBatteryLow_Flash
  $9EDD,$03 Fetch the frame counter.
  $9EE0,$03 Return on every other frame.
  $9EE3,$02 Use red on black as the attribute.
  $9EE5,$04 Test bit 1 of the frame counter, and jump to use red on black if it
. is not set.
  $9EE9,$02 Otherwise use yellow on black.
N $9EEB This entry point sets the attribute of the battery bar.
@ $9EEB label=SetBatteryAttributes
R $9EC6 C Attribute
  $9EEB,$03 Point #REGhl at the position of the bar, with an X position of #N$40
. and a Y position of #N$90.
  $9EEE,$03 Convert it into an address in the attribute file using #R$BD6A.
  $9EF1,$02 There are two rows of attributes.
@ $9EF3 label=CheckBatteryLow_Row
  $9EF3,$02 Each row is #N$0F characters wide.
  $9EF5,$01 Save the address of the start of the row.
@ $9EF6 label=CheckBatteryLow_Column
  $9EF6,$01 Set the attribute of a character.
  $9EF7,$01 Move on to the next character.
  $9EF8,$02 Loop back until the row is done.
  $9EFA,$01 Restore the address of the start of the row.
  $9EFB,$02 Move down to the next row...
  $9EFD,$03 ...using #R$BF92.
  $9F00,$01 Count down the rows.
  $9F01,$02 Loop back until both rows have been done.
  $9F03,$01 Return.
N $9F04 The battery is not low, so the message can be queued again the next time
. it is.
@ $9F04 label=CheckBatteryLow_Ok
  $9F04,$01 Clear the flag...
  $9F05,$03 ...that says the message has been queued.
  $9F08,$01 Return.

c $9F09 Check Pause
@ $9F09 label=CheckPause
D $9F09 Called every frame. Pressing SPACE on its own pauses the game, while the
. lights run round the border. Pressing it again resumes the game.
  $9F09,$02 Read the half-row of the keyboard that contains SPACE...
  $9F0B,$03 ...using #R$C0AB.
  $9F0E,$03 Return if SPACE is not being pressed.
  $9F11,$03 Return if any of the other keys in the row are pressed.
  $9F14,$03 Make a beep using #R$C048.
@ $9F17 label=CheckPause_Release
  $9F17,$02 Read the half-row of the keyboard that contains SPACE...
  $9F19,$03 ...using #R$C0AB.
  $9F1C,$04 Loop back until SPACE has been released.
  $9F20,$03 Set up a delay...
@ $9F23 label=CheckPause_Wait
  $9F23,$02 Tell #R$9F4D to start another light running round the border...
  $9F25,$03 ...and wait for the next frame.
  $9F28,$02 Read the half-row of the keyboard that contains SPACE...
  $9F2A,$03 ...using #R$C0AB.
  $9F2D,$04 Loop back until SPACE is pressed again.
@ $9F31 label=CheckPause_Resume
  $9F31,$02 Tell #R$9F4D to start another light running round the border...
  $9F33,$03 ...and wait for the next frame.
  $9F36,$02 Read the half-row of the keyboard that contains SPACE...
  $9F38,$03 ...using #R$C0AB.
  $9F3B,$04 Loop back until SPACE has been released.
  $9F3F,$03 Set up a delay...
  $9F42,$03 ...and make a click using #R$C027.
@ $9F45 label=CheckPause_Finish
  $9F45,$02 Tell #R$9F4D not to start any more lights...
  $9F47,$03 ...and wait for the next frame.
  $9F4A,$02 Loop back until the lights have all finished.
  $9F4C,$01 Return.

c $9F4D Wait For Frame
@ $9F4D label=WaitForFrame
D $9F4D Waits for the next frame interrupt and then moves the lights that run
. round the border.
R $9F4D C #N$01 to start a new light, or #N$00 to leave the lights as they are
R $9F4D O:F The zero flag is set if there are no lights left
  $9F4D,$01 Save the register.
  $9F4E,$04 Restore #REGiy, which the ROM interrupt routine needs.
  $9F52,$01 Enable interrupts.
  $9F53,$01 Wait for the next interrupt.
  $9F54,$01 Disable interrupts again.
  $9F55,$01 Restore the register.
  $9F56,$01 Fetch the flag.
  $9F57,$03 Move the lights using #R$AF25.
  $9F5A,$01 Return.

w $9F5B Entity Handler Table
@ $9F5B label=EntityHandlers
D $9F5B The routine that runs each frame for an entity of each type. The type is
. the first byte of the entity, and bit 7 (which flips the sprite) is ignored.
. The numbers are also the numbers of the sprites that are drawn for the entity.
. The handlers are shown in the order they appear in the table.
. #TABLE(default,centre)
. { =h Types | =h Handler }
. { #N($00), #N$4C-#N($4D), #N$59-#N$5F and #N$68-#N$6D | #R$A625 (returns) }
. { #N$01 | #R$B059 (does nothing) }
. { #N$02-#N$07 | #R$B05A }
. { #N$08-#N$0B | #R$A826 }
. { #N$0C-#N$0F | #R$A833 }
. { #N$10-#N$13 and #N$18-#N$1B | #R$AB03 }
. { #N$14-#N$17 and #N$1C-#N$1F | #R$AAFD }
. { #N$20-#N$2F | #R$A8A4 }
. { #N$30-#N$37 | #R$A6E0 }
. { #N$38-#N$3A | #R$A70A }
. { #N$3B | #R$A713 }
. { #N$3C-#N$3F | #R$A144 }
. { #N$40-#N$4A | #R$A932 }
. { #N$4B | #R$A98B }
. { #N$4E-#N$4F | #R$A082 }
. { #N$50-#N$53 | #R$A218 }
. { #N$54-#N$56 | #R$A20D }
. { #N$57 | #R$A213 }
. { #N$58 | #R$A04B }
. { #N$60-#N$63 | #R$A4EC }
. { #N$64-#N$67 | #R$A2B5 }
. { #N$6E-#N$6F | #R$A36C }
. { #N$70-#N$73 | #R$B063 }
. { #N$74-#N$77 | #R$A4DC }
. TABLE#
W $9F5B,$F0,$10

c $A04B Start Robot Life
@ $A04B label=StartRobotLife
D $A04B The handler for entity type #N($58), which is the robot at the start of
. a life. A block of the panel flashes while a counter counts down, and then the
. robot starts to materialise (type #N$40).
R $A04B IX Entity
  $A04B,$05 Count down the timer of the entity, and jump to start the robot
. materialising when it reaches zero.
  $A050,$03 Fetch the timer.
  $A053,$02 Use the low two bits...
  $A055,$01 ...to make a beep using #R$C027 on every fourth frame...
  $A056,$03 ...by saving them...
  $A059,$01 ...and restoring them.
  $A05A,$06 Use bright black as the attribute, unless bit 1 of the timer is
. set...
  $A060,$02 ...in which case add red paper.
@ $A062 label=StartRobotLife_KeepAttribute
  $A062,$01 Keep the attribute.
  $A063,$03 Point #REGhl at the attributes of a block of the panel...
  $A066,$03 ...which is six characters wide (#REGb) and two characters tall
. (#REGc).
@ $A069 label=StartRobotLife_Row
  $A069,$01 Save the dimensions...
  $A06A,$01 ...and the address of the start of the row.
@ $A06B label=StartRobotLife_Column
  $A06B,$01 Fetch an attribute...
  $A06C,$03 ...keep the ink and combine it with the new attribute...
  $A06F,$01 ...and store it.
  $A070,$01 Move on to the next attribute.
  $A071,$02 Loop back until the row is done.
  $A073,$01 Restore the address of the start of the row...
  $A074,$04 ...and move down to the next row.
  $A078,$01 Restore the dimensions.
  $A079,$01 Count down the rows.
  $A07A,$02 Loop back until both rows have been done.
  $A07C,$01 Return.
@ $A07D label=StartRobotLife_Materialise
  $A07D,$04 Start the robot materialising by setting its type to #N$40.
  $A081,$01 Return.

c $A082 Flicker Transmitter
@ $A082 label=FlickerTransmitter
D $A082 The handler for entity types #N$4E and #N($4F), which are the program
. transmitters. A transmitter flickers between its two sprites.
R $A082 IX Entity
  $A082,$03 Fetch the random number...
  $A085,$02 ...limited to #N$00-#N$03.
  $A087,$04 Show the first sprite.
  $A08B,$01 Return unless the random number was zero.
  $A08C,$04 Otherwise show the second sprite.
  $A090,$01 Return.

c $A091 Recharge Battery
@ $A091 label=RechargeBattery
D $A091 Recharges the battery fully and shows the number of lives that are left,
. using a small picture of the robot followed by the number.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #POKES$5C36,$00;$5C37,$3C;$968B,$05
. #SIM(start=$9A65,stop=$9A68)
. #SCR$02(recharge-battery-before)
. | #SIM(start=$B6CA,stop=$B6CD)
. #SCR$02(recharge-battery-after) } UDGTABLE# #POPS
  $A091,$02 Set the level of the battery to the maximum of #N$74...
  $A093,$03 ...as the target level.
  $A096,$02 Use bright yellow as the attribute...
  $A098,$03 ...and set the attributes of the battery bar using #R$9EEB.
  $A09B,$03 This fetch has no effect, as #REGa is replaced immediately.
  $A09E,$03 Point #REGhl at the address of the sprite that is the picture of the
. robot...
  $A0A1,$03 ...and fetch it into #REGde.
  $A0A4,$03 Point #REGhl at the position in the display file where the picture
. of the robot is drawn.
  $A0A7,$03 Fetch the number of lives.
  $A0AA,$03 Skip the picture if there are none left.
  $A0AD,$01 Keep the number.
  $A0AE,$01 Move on to the height byte of the sprite.
  $A0AF,$03 Draw the picture using #R$A0CB.
@ $A0B2 label=RechargeBattery_ShowLives
  $A0B2,$03 Fetch the number of lives.
  $A0B5,$02 Convert it into a digit with bit 7 set...
  $A0B7,$03 ...and write it into the text.
  $A0BA,$03 Fetch the character set that the game uses...
  $A0BD,$03 ...and use it to print text.
  $A0C0,$03 Point #REGhl at the position of the number of lives.
  $A0C3,$03 Point #REGde at #R$A0C9.
  $A0C6,$03 Print the number in double height characters using #R$B52E.

t $A0C9 Messaging: Lives Text
@ $A0C9 label=Text_Lives
D $A0C9 The attribute and the digit of the number of lives that are left.
  $A0C9,$02,h$01:$01 Attribute: #COLOUR(#PEEK(#PC)) + the number of lives.

c $A0CB Draw Icon
@ $A0CB label=DrawIcon
D $A0CB Draws the pixels of a sprite that is three bytes wide, without its mask.
. The sprite is drawn from the bottom upwards, leaving out its first two rows
. (at the bottom) and its last row (at the top). This is used to draw the
. picture that shows the lives that are left.
R $A0CB DE Address of the height byte of the sprite
R $A0CB HL Screen address of the bottom left of the icon
R $A0CB O:HL Screen address four characters to the right of the icon
  $A0CB,$01 Save the screen address...
  $A0CC,$01 ...and the sprite address.
  $A0CD,$01 Fetch the height of the sprite...
  $A0CE,$02 ...and take three rows off it, as that is the number that are drawn.
  $A0D0,$01 Use that as the counter.
  $A0D1,$08 Skip the height byte and the first two rows of the sprite.
  $A0D9,$01 Point #REGhl at the sprite data and #REGde at the screen.
N $A0DA Each row of the sprite has three pairs of bytes. The mask byte and the
. other byte are combined to find the pixels.
@ $A0DA label=DrawIcon_Row
  $A0DA,$01 Fetch the first mask byte...
  $A0DB,$01 ...and move on to the other byte.
  $A0DC,$01 Combine the two...
  $A0DD,$01 ...and write the pixels to the screen.
  $A0DE,$01 Move on to the next byte of the screen.
  $A0DF,$01 Move on to the next pair.
  $A0E0,$01 Fetch the second mask byte...
  $A0E1,$01 ...and move on to the other byte.
  $A0E2,$01 Combine the two...
  $A0E3,$01 ...and write the pixels to the screen.
  $A0E4,$01 Move on to the next byte of the screen.
  $A0E5,$01 Move on to the next pair.
  $A0E6,$01 Fetch the third mask byte...
  $A0E7,$01 ...and move on to the other byte.
  $A0E8,$01 Combine the two...
  $A0E9,$01 ...and write the pixels to the screen.
  $A0EA,$01 Move on to the next row of the sprite.
  $A0EB,$02 Move back to the start of the row on the screen.
  $A0ED,$02 Move up one pixel row on the screen.
  $A0EF,$04 Jump if that is still inside the same character row.
  $A0F3,$04 Otherwise go back to the bottom pixel row of the character row...
  $A0F7,$04 ...and move up to the next character row.
@ $A0FB label=DrawIcon_NextRow
  $A0FB,$02 Loop back until every row has been drawn.
  $A0FD,$01 Restore the sprite address...
  $A0FE,$01 ...and the screen address.
  $A0FF,$04 Move four characters to the right.
  $A103,$01 Return.

c $A104 Remove Distant Entity
@ $A104 label=RemoveDistantEntity
D $A104 Removes an entity that is twelve cells or more from the camera in either
. direction. When the entity is removed the handler that called this routine is
. finished too.
R $A104 IX Entity
  $A104,$03 Fetch the X cell of the camera.
  $A107,$03 Subtract the X cell of the entity.
  $A10A,$05 Make the difference positive.
@ $A10F label=RemoveDistantEntity_TestX
  $A10F,$04 Jump to remove the entity if it is twelve or more cells away.
  $A113,$03 Fetch the Y cell of the camera.
  $A116,$03 Subtract the Y cell of the entity.
  $A119,$05 Make the difference positive.
@ $A11E label=RemoveDistantEntity_TestY
  $A11E,$03 Return if the entity is less than twelve cells away.
@ $A121 label=RemoveDistantEntity_Remove
  $A121,$04 Remove the entity by setting its type to zero.
  $A125,$01 Discard the return address, so that the handler stops here.
  $A126,$01 Return.

c $A127 Set Robot Facing
@ $A127 label=SetRobotFacing
D $A127 Sets the type that the robot takes on when it has finished
. materialising, which is the first of the sprites of the robot walking.
  $A127,$02 Use type #N$10...
  $A129,$03 ...as the type that the robot takes on after the sequence of sprites
. that shows it materialising.
  $A12C,$01 Return.

c $A12D Try Move
@ $A12D label=TryMove
D $A12D Moves an entity in the direction that it is heading, using #R$A9C3, and
. then tests whether it has been blocked. An entity that is blocked by a cell of
. type #N$0F is allowed to carry on.
R $A12D B Number of steps that can still be taken
R $A12D DE X position
R $A12D HL Y position
R $A12D O:A The type of the cell that is blocking the entity
R $A12D O:F The zero flag is set if the entity can carry on
  $A12D,$04 Move using #R$A9C3, and return if the entity can carry on.
  $A131,$01 Save the Y position.
  $A132,$03 Fetch the address of the cell that blocked the entity...
  $A135,$01 ...and fetch its type.
  $A136,$02 Keep the current type of the cell.
  $A138,$01 Restore the Y position.
  $A139,$03 Return if the cell is not type #N$0F.
  $A13C,$03 Otherwise restore the Y position that the entity had before the
. move...
  $A13F,$04 ...and the X position.
  $A143,$01 Return with the zero flag set.

c $A144 Move Spark
@ $A144 label=MoveSpark
D $A144 The handler for entity types #N$3C to #N($3F), which are the shots that
. the robot fires using the first weapon. A shot moves across the map until it
. hits something or has run out of range. The shot destroys the contents of the
. cell that it hits, apart from the cells that are solid.
R $A144 IX Entity
  $A144,$03 Move on to the next sprite using #R$B063.
  $A147,$03 Fetch the position of the shot.
  $A14A,$02 The shot can take up to #N$60 steps in this frame.
@ $A14C label=MoveSpark_Step
  $A14C,$03 Take a step using #R$A12D.
  $A14F,$02 Jump if the shot has hit something.
  $A151,$04 Jump if the shot is not at the start of a cell.
  $A155,$03 Fetch the range of the shot...
  $A158,$02 ...take away one cell...
  $A15A,$03 ...and store it.
  $A15D,$04 Jump to explode the shot if it has run out of range.
  $A161,$04 Loop back to take another step if there are steps left.
@ $A165 label=MoveSpark_Store
  $A165,$03 Store the new position of the shot.
  $A168,$03 Check whether it has hit an enemy using #R$A5A7.
  $A16B,$08 Fetch the type of the shot, and draw it using #R$BDCD unless it has
. become smoke.
  $A173,$07 Fetch the item that the enemy was carrying, and draw the shot if it
. was not carrying any.
  $A17A,$01 Keep the item.
  $A17B,$03 Fetch the address of the cell that the shot was in.
  $A17E,$01 Fetch the contents of the cell.
  $A17F,$03 Keep the initial type of the cell and use the item as the current
. type, so that the enemy drops it.
  $A182,$01 Store the new contents of the cell.
  $A183,$01 Clear the item that the enemy was carrying...
  $A184,$03 ...and store it.
  $A187,$03 Draw the shot using #R$BDCD.
@ $A18A label=MoveSpark_Explode
  $A18A,$04 Turn the shot into smoke by changing its type to #N$38.
  $A18E,$02 Store the position.
N $A190 The shot has hit something.
@ $A190 label=MoveSpark_Hit
  $A190,$01 Save the X position.
  $A191,$03 Each entity is #N$10 bytes long.
  $A194,$02 There are two entities that are used for puffs of smoke.
  $A196,$04 Point #REGiy at #R$98B0.
@ $A19A label=MoveSpark_FindPuff
  $A19A,$06 Fetch its type, and jump if it is not being used.
  $A1A0,$02 Move on to the next one.
  $A1A2,$02 Loop back until both have been tried.
  $A1A4,$01 Restore the X position.
  $A1A5,$02 Make the shot explode without hitting the cell, as there is no puff
. to use.
@ $A1A7 label=MoveSpark_Unused
  $A1A7,$01 Restore the X position.
  $A1A8,$01 Save the Y position.
  $A1A9,$03 Fetch the address of the cell that was hit.
  $A1AC,$01 Fetch its contents.
  $A1AD,$02 Keep the current type of the cell.
  $A1AF,$04 Jump to explode the shot if the type is #N$05.
  $A1B3,$04 Jump to explode the shot if the type is #N$04.
  $A1B7,$04 Jump to explode the shot if the type is #N$01.
  $A1BB,$04 Jump to explode the shot if the type is #N$07.
  $A1BF,$04 Jump to explode the shot if the type is #N$08.
  $A1C3,$04 Jump to explode the shot if the type is #N$09.
  $A1C7,$04 Jump to explode the shot if the type is #N$0C.
  $A1CB,$04 Jump to explode the shot if the type is #N$0E.
  $A1CF,$01 Fetch the contents of the cell again...
  $A1D0,$04 ...and keep the initial type, so that the cell is emptied.
@ $A1D4 label=MoveSpark_Replace
  $A1D4,$01 Store the new contents of the cell.
  $A1D5,$04 Start a puff of smoke...
  $A1D9,$03 ...at the position of the cell.
  $A1DC,$03 Set the X cell of the puff...
  $A1DF,$03 ...and then its Y cell.
@ $A1E2 label=MoveSpark_Restore
  $A1E2,$01 Restore the Y position.
  $A1E3,$02 Make the shot explode.
@ $A1E5 label=MoveSpark_Destroy
  $A1E5,$01 Keep the initial type of the cell.
  $A1E6,$01 Fetch the contents of the cell...
  $A1E7,$02 ...and keep its current type.
  $A1E9,$05 Jump to empty the cell if it is not type #N$02 (an installed
. program).
  $A1EE,$01 Save the contents...
  $A1EF,$01 ...and the X position...
  $A1F0,$01 ...and the Y position.
  $A1F1,$03 Find the sector that the cell is in using #R$9C5E.
  $A1F4,$03 Use the sector number as an index.
  $A1F7,$03 Point #REGhl at #R$965B.
  $A1FA,$01 Add the index.
  $A1FB,$04 Fetch the flag, and jump if the sector has been activated (as its
. programs are safe).
  $A1FF,$03 Otherwise take one unit of energy off the sector using #R$A32B.
  $A202,$01 Restore the Y position...
  $A203,$01 ...and the X position...
  $A204,$01 ...and the contents.
  $A205,$02 Jump back to empty the cell.
@ $A207 label=MoveSpark_Safe
  $A207,$01 Restore the Y position...
  $A208,$01 ...and the X position...
  $A209,$01 ...and the contents.
  $A20A,$01 Fetch the contents of the cell, which are left as they are.
  $A20B,$02 Jump back to start the puff of smoke.

c $A20D Animate Cloud
@ $A20D label=AnimateCloud
D $A20D The handler for entity types #N$54 to #N($56), which are the sprites of
. a cloud of smoke. It moves on to the next sprite and draws it. The last sprite
. of the cloud is handled by #R$A213.
R $A20D IX Entity
  $A20D,$03 Move on to the next sprite.
  $A210,$03 Draw the cloud using #R$BDCD.

c $A213 Remove Cloud
@ $A213 label=RemoveCloud
D $A213 The handler for entity type #N($57), which is the last sprite of a cloud
. of smoke. It removes the cloud.
R $A213 IX Entity
  $A213,$04 Remove the entity by setting its type to zero.
  $A217,$01 Return.

c $A218 Move Thief
@ $A218 label=MoveThief
D $A218 The handler for entity types #N$50 to #N($53), the enemies that go after
. the programs. The enemy heads for the robot, and picks up any program (map
. cell type #N$06) that is in the way. If the enemy is shot then it drops the
. program.
R $A218 IX Entity
  $A218,$03 Move on to the next sprite using #R$B063.
  $A21B,$03 Remove the enemy if it is far away from the camera using #R$A104.
  $A21E,$03 Fetch the position of the enemy.
  $A221,$02 The enemy can take up to #N$40 steps in this frame.
@ $A223 label=MoveThief_Step
  $A223,$03 Take a step using #R$A12D.
  $A226,$02 Jump if the enemy has been blocked by a cell.
  $A228,$03 Check whether another enemy is in the way using #R$A576.
  $A22B,$02 Jump if there is.
  $A22D,$04 Jump if the enemy is not at the start of a cell.
  $A231,$03 Choose a new direction using #R$A282...
  $A234,$03 ...and store it.
  $A237,$04 Loop back to take another step if there are steps left.
@ $A23B label=MoveThief_Store
  $A23B,$03 Store the new position of the enemy.
  $A23E,$03 Draw the enemy using #R$BDCD.
N $A241 The enemy has been blocked by a cell.
@ $A241 label=MoveThief_Blocked
  $A241,$01 Save the Y position.
  $A242,$03 Fetch the address of the cell that blocked the enemy...
  $A245,$01 ...and its type.
  $A246,$06 Jump unless it is a program (type #N$06).
  $A24C,$01 Keep the type.
  $A24D,$03 Fetch the item that the enemy is carrying.
  $A250,$03 Jump if it is carrying one already.
  $A253,$03 Remove the program from the cell using #R$A2AD...
  $A256,$01 ...after restoring the Y position...
  $A257,$02 ...and carry on. (The enemy has picked up the program, and takes it
. away.)
@ $A259 label=MoveThief_Skip
  $A259,$01 Restore the Y position.
  $A25A,$03 Fetch the frame counter.
  $A25D,$04 Test the lowest bit of the frame counter, and jump on every other
. frame to choose a direction towards the robot.
  $A261,$03 Otherwise fetch the random number...
  $A264,$02 ...limited to #N$00-#N$03...
  $A266,$05 ...and jump unless it is the direction that the enemy is already
. heading in.
  $A26B,$03 Otherwise use the next direction.
@ $A26E label=MoveThief_Direction
  $A26E,$03 Store the new direction.
  $A271,$02 Carry on.
@ $A273 label=MoveThief_Towards
  $A273,$03 Choose a direction towards the robot using #R$A282.
  $A276,$02 Carry on.
N $A278 The enemy is in the way of another enemy.
@ $A278 label=MoveThief_Reverse
  $A278,$03 Turn the enemy round using #R$A891.
  $A27B,$03 Draw the enemy using #R$BDCD.
  $A27E,$01 Return if it was not drawn.
  $A27F,$03 Otherwise make a sound using #R$C048.

c $A282 Find Direction To Robot
@ $A282 label=FindDirectionToRobot
D $A282 Chooses a direction for an enemy, at random, that heads towards the
. robot in either the X direction or the Y direction.
R $A282 IX Entity
R $A282 O:A Direction (#N$00 to #N$03)
  $A282,$03 Fetch the random number.
  $A285,$04 Jump to use the Y direction if the number is below #N$80.
  $A289,$03 Fetch the X cell of the camera...
  $A28C,$03 ...and subtract the X cell of the entity.
  $A28F,$02 Limit the difference to #N$00-#N$3F.
  $A291,$04 Jump if the robot is less than #N$20 cells ahead.
  $A295,$02 Otherwise use direction zero...
  $A297,$01 ...and return.
@ $A298 label=FindDirectionToRobot_DirectionTwo
  $A298,$02 Use direction two...
  $A29A,$01 ...and return.
@ $A29B label=FindDirectionToRobot_Y
  $A29B,$03 Fetch the Y cell of the camera...
  $A29E,$03 ...and subtract the Y cell of the entity.
  $A2A1,$02 Limit the difference to #N$00-#N$3F.
  $A2A3,$04 Jump if the robot is less than #N$20 cells ahead.
  $A2A7,$02 Otherwise use direction three...
  $A2A9,$01 ...and return.
@ $A2AA label=FindDirectionToRobot_DirectionOne
  $A2AA,$02 Use direction one...
  $A2AC,$01 ...and return.

c $A2AD Empty Cell
@ $A2AD label=EmptyCell
D $A2AD Sets the current type of the cell that last blocked an entity to zero,
. leaving its initial type as it was.
  $A2AD,$03 Fetch the address of the cell.
  $A2B0,$01 Fetch its contents.
  $A2B1,$02 Keep the initial type.
  $A2B3,$01 Store it.
  $A2B4,$01 Return.

c $A2B5 Move Destroyer
@ $A2B5 label=MoveDestroyer
D $A2B5 The handler for entity types #N$64 to #N($67), the enemies that destroy
. the programs that have been installed. They fly in a straight line until their
. time runs out. When one of them hits an installed program in a sector that has
. not been activated, the program is removed and the sector loses a unit of
. energy.
R $A2B5 IX Entity
  $A2B5,$03 Move on to the next sprite using #R$B063.
  $A2B8,$03 Fetch the position of the enemy.
  $A2BB,$02 The enemy can take up to #N$80 steps in this frame.
@ $A2BD label=MoveDestroyer_Step
  $A2BD,$03 Take a step using #R$A9C3.
  $A2C0,$02 Jump if the enemy has hit a cell.
@ $A2C2 label=MoveDestroyer_Store
  $A2C2,$03 Store the new position of the enemy.
  $A2C5,$06 Count down the time that the enemy has left, and draw it using
. #R$BDCD if there is any.
  $A2CB,$04 Otherwise turn it into smoke by changing its type to #N$38...
  $A2CF,$03 ...and draw it.
@ $A2D2 label=MoveDestroyer_HitCell
  $A2D2,$01 Save the Y position.
  $A2D3,$03 Fetch the address of the cell that the enemy hit...
  $A2D6,$01 ...and its type.
  $A2D7,$02 Keep the current type of the cell.
  $A2D9,$04 Jump unless the cell holds an installed program (type #N$02).
  $A2DD,$01 Save the X position.
  $A2DE,$03 Find the sector that the cell is in using #R$9C5E.
  $A2E1,$03 Use the sector number as an index.
  $A2E4,$01 Save the address of the cell.
  $A2E5,$03 Point #REGhl at #R$965B.
  $A2E8,$01 Add the index.
  $A2E9,$01 Fetch the flag.
  $A2EA,$01 Restore the address of the cell.
  $A2EB,$01 Restore the X position.
  $A2EC,$03 Jump if the sector has been activated, as its programs are safe.
  $A2EF,$01 Fetch the contents of the cell...
  $A2F0,$03 ...and keep its initial type in #REGb.
  $A2F3,$01 Fetch the contents of the cell again...
  $A2F4,$04 ...and change the current type from #N$02 to #N$0F.
  $A2F8,$01 Combine it with the initial type...
  $A2F9,$01 ...and store it.
  $A2FA,$01 Save the X position.
  $A2FB,$03 Take one unit of energy off the sector using #R$A32B.
  $A2FE,$01 Restore the X position.
  $A2FF,$01 Restore the Y position.
  $A300,$02 Carry on.
@ $A302 label=MoveDestroyer_NotProgram
  $A302,$01 Restore the Y position.
  $A303,$04 Jump to turn the enemy into smoke if the cell is type #N$04.
  $A307,$04 Jump to turn the enemy into smoke if the cell is type #N$05.
  $A30B,$04 Jump if the cell is not type #N($0C), to carry on.
@ $A30F label=MoveDestroyer_Smoke
  $A30F,$04 Turn the enemy into smoke by changing its type to #N$38...
  $A313,$03 ...and draw it.
@ $A316 label=MoveDestroyer_Safe
  $A316,$01 Restore the Y position.
@ $A317 label=MoveDestroyer_Undo
  $A317,$04 Restore the position that the enemy had before the step...
  $A31B,$05 ...and carry on.

c $A320 Find Sector Energy
@ $A320 label=FindSectorEnergy
D $A320 Finds the entry for the sector that an entity is in, in the table of
. sector energies.
R $A320 IX Entity
R $A320 O:DE Sector number
R $A320 O:HL Address of the energy of the sector
  $A320,$03 Find the sector using #R$9C5E.
  $A323,$01 Put the sector number in #REGe...
  $A324,$02 ...and clear #REGd.
  $A326,$03 Point #REGhl at #R$A361.
  $A329,$01 Add the sector number.
  $A32A,$01 Return.

c $A32B Reduce Sector Energy
@ $A32B label=ReduceSectorEnergy
D $A32B Takes one unit of energy off the sector that an entity is in. If the
. energy is down to five or fewer units then the player is told, and when it
. reaches zero the sector has been destroyed.
R $A32B IX Entity
  $A32B,$03 Find the energy of the sector using #R$A320.
  $A32E,$01 Take one unit of energy off.
  $A32F,$01 Fetch the energy that is left.
  $A330,$03 Return if there are at least six units.
  $A333,$01 Keep the energy.
  $A334,$03 Jump if there is some energy left.
  $A337,$03 Point #REGhl at the number of sectors that have been destroyed.
  $A33A,$01 Add one.
  $A33B,$03 Point #REGhl at #R$967E.
  $A33E,$01 Add the sector number.
  $A33F,$01 Fetch the state of the sector.
  $A340,$04 Change it to destroyed (bit 0 set and bit 1 clear), clearing the
. flag that says it is under attack.
  $A344,$01 Store the new state.
  $A345,$01 Save the sector number.
  $A346,$03 Colour the sector map using #R$ADEA.
  $A349,$01 Restore the sector number.
@ $A34A label=ReduceSectorEnergy_Message
  $A34A,$01 Fetch the sector number...
  $A34B,$02 ...and convert it into the last character of the message "SECTOR
. n"...
  $A34D,$03 ...by writing it into the message.
  $A350,$01 Use the sector number as the argument of the message...
  $A351,$02 ...for message #N$01.
  $A353,$03 Queue it using #R$9C76.
  $A356,$02 Use message #N($04), "DESTROYED"...
  $A358,$01 ...but use message #N($07), "CRITICAL", instead...
  $A359,$03 ...unless the sector has no energy left, in which case jump to use
. "DESTROYED".
  $A35C,$02 Use message #N($07), "CRITICAL".
@ $A35E label=ReduceSectorEnergy_QueueMessage
  $A35E,$03 Jump to #R$9C76.

g $A361 Sector Energy
@ $A361 label=SectorEnergy
D $A361 The number of programs that are installed in each sector, which is its
. energy. The energy of a sector goes down by one when one of its programs is
. destroyed and up by one when the robot installs a program. A sector with no
. energy is destroyed. The last two bytes are not used.
B $A361,$09,$01 Sectors #N$00 to #N$08.
B $A36A,$02,$01 Unused.

c $A36C Move Program Packet
@ $A36C label=MoveProgramPacket
D $A36C The handler for entity types #N$6E and #N($6F), which is the program
. packet that is sent from a transmitter to a sector. It follows the open cells
. of the map. If it reaches a receiving terminal (a cell of type #N$09) in a
. sector that has some energy then the sector is activated, and if it runs into
. a hazard (a cell of type #N$01 or #N$07) then the program is destroyed.
R $A36C IX Entity
  $A36C,$03 Fetch the position of the packet.
  $A36F,$03 Fetch the type of the packet...
  $A372,$05 ...and switch to the other sprite.
  $A377,$04 Jump if the packet is not at the start of a cell.
  $A37B,$03 Fetch the direction that the packet is heading in...
  $A37E,$02 ...limited to #N$00-#N$03.
  $A380,$03 Choose a direction that is not blocked using #R$A4C3.
  $A383,$02 Jump if there is one.
  $A385,$04 Otherwise turn the packet into smoke...
  $A389,$03 ...and draw it.
@ $A38C label=MoveProgramPacket_CheckCell
  $A38C,$04 Jump if the packet has reached a receiving terminal (a cell of type
. #N$09).
  $A390,$03 Jump to carry on if the cell is open (type #N$00).
  $A393,$02 Use the state that says that the packet has been destroyed...
  $A395,$04 ...and jump to set it if the cell is a hazard of type #N$01...
  $A399,$04 ...or of type #N$07.
  $A39D,$04 Jump to carry on if the cell is type #N$0F.
N $A3A1 The packet has been destroyed or has arrived, and is removed.
@ $A3A1 label=MoveProgramPacket_Remove
  $A3A1,$01 Remove the packet by setting its type to zero.
  $A3A2,$03 Store it.
  $A3A5,$01 Return.
N $A3A6 The terminal has no energy, so the packet turns round.
@ $A3A6 label=MoveProgramPacket_TurnRound
  $A3A6,$01 Restore the Y position.
  $A3A7,$01 Fetch the direction that the packet is heading in...
  $A3A8,$04 ...and reverse it.
  $A3AC,$01 Keep the reversed direction.
  $A3AD,$02 Carry on.
@ $A3AF label=MoveProgramPacket_Terminal
  $A3AF,$01 Save the Y position...
  $A3B0,$01 ...and the X position.
  $A3B1,$03 Find the sector that the terminal is in using #R$9C5E.
  $A3B4,$03 Use the sector number as an index.
  $A3B7,$03 Point #REGhl at #R$A361.
  $A3BA,$01 Add the index.
  $A3BB,$01 Restore the X position.
  $A3BC,$01 Fetch the energy of the sector.
  $A3BD,$03 Jump to turn the packet round if the sector has no energy.
  $A3C0,$03 Fetch the address of the terminal.
  $A3C3,$01 Fetch its contents.
  $A3C4,$02 Keep the initial type...
  $A3C6,$02 ...change the current type to #N($0E), the activated terminal...
  $A3C8,$01 ...and store the new contents.
  $A3C9,$02 Set the state of the packet to four...
  $A3CB,$01 ...after restoring the Y position.
@ $A3CC label=MoveProgramPacket_State
  $A3CC,$03 Store the state of the packet.
@ $A3CF label=MoveProgramPacket_Continue
  $A3CF,$03 Fetch the direction of the packet...
  $A3D2,$02 ...clear the old direction...
  $A3D4,$01 ...add the new direction...
  $A3D5,$03 ...and store it.
@ $A3D8 label=MoveProgramPacket_UpdateState
  $A3D8,$03 Fetch the state of the packet...
  $A3DB,$04 ...limited to the low four bits, and jump to carry on if it is zero.
  $A3DF,$03 Count down the state, and jump to store it if it has not reached
. zero.
  $A3E2,$06 Test the flag that says that the packet has been destroyed, and jump
. if it is not set.
  $A3E8,$03 Queue message #N($03), "PROGRAM HAS BEEN"...
  $A3EB,$03 ...using #R$9C76.
  $A3EE,$03 Queue message #N($04), "DESTROYED"...
  $A3F1,$03 ...using #R$9C76.
  $A3F4,$03 Start effect #N$03 (four tones)...
  $A3F7,$03 ...by storing the length and the effect number for #R$BFDA.
  $A3FA,$02 Remove the packet.
N $A3FC The packet has arrived at a terminal in a sector that has energy.
@ $A3FC label=MoveProgramPacket_Arrived
  $A3FC,$03 Queue message #N($08), "PROGRAM RECIEVED"...
  $A3FF,$03 ...using #R$9C76.
  $A402,$03 Find the sector that the packet is in using #R$9C5E.
  $A405,$02 Queue message #N($01), "SECTOR n"...
  $A407,$03 ...using #R$9C76.
  $A40A,$03 Point #REGhl at #R$965B.
  $A40D,$03 Use the sector number as an index.
  $A410,$01 Add the index.
  $A411,$02 Set the flag that says that the sector has been activated.
  $A413,$03 Point #REGhl at the number of sectors that have been activated.
  $A416,$01 Add one.
  $A417,$03 Point #REGhl at #R$967E.
  $A41A,$01 Add the sector number.
  $A41B,$01 Fetch the state of the sector.
  $A41C,$04 Change it to activated (bit 1 set and bit 0 clear), clearing the
. flag that says it is under attack.
  $A420,$01 Store the new state.
  $A421,$03 Point #REGhl at #R$A361.
  $A424,$01 Add the sector number.
  $A425,$01 Use the energy of the sector as a counter...
  $A426,$01 ...to count up in decimal.
@ $A427 label=MoveProgramPacket_CountEnergy
  $A427,$02 Add one.
  $A429,$01 Convert it to decimal.
  $A42A,$02 Loop back until the count is the energy.
  $A42C,$04 Swap the digits.
  $A430,$01 Keep the result.
  $A431,$03 Keep the digit that was the first.
  $A434,$03 Add the bonus to the score using #R$B573.
  $A437,$03 Colour the sector map using #R$ADEA.
  $A43A,$03 Add #N$5000 points...
  $A43D,$03 ...to the score using #R$B573.
  $A440,$03 Start effect #N$02 (seven tones)...
  $A443,$03 ...by storing the length and the effect number for #R$BFDA.
  $A446,$03 Remove the packet.
@ $A449 label=MoveProgramPacket_StoreCount
  $A449,$01 Keep the new count.
  $A44A,$03 Fetch the state of the packet...
  $A44D,$02 ...keep the bits that are not the count...
  $A44F,$01 ...and combine them with the new count...
  $A450,$03 ...and store it.
N $A453 The packet moves on.
@ $A453 label=MoveProgramPacket_Move
  $A453,$02 The packet can take up to #N$30 steps in this frame.
  $A455,$03 Take a step using #R$A12D.
  $A458,$02 Jump if the packet could carry on.
  $A45A,$04 Jump to carry on if the cell that blocked the packet is type #N$01.
  $A45E,$04 Jump to carry on if the cell that blocked the packet is type #N$07.
  $A462,$04 Jump if the cell that blocked the packet is not type #N$0E.
@ $A466 label=MoveProgramPacket_Restore
  $A466,$04 Restore the position that the packet had before the step...
  $A46A,$03 ...and the other coordinate.
@ $A46D label=MoveProgramPacket_CheckEntities
  $A46D,$03 Check whether any entity is in the way using #R$A56D.
  $A470,$02 Jump if there is none.
  $A472,$03 Fetch the direction of the packet...
  $A475,$04 ...and reverse it...
  $A479,$01 ...and keep it in #REGc.
  $A47A,$03 Fetch the byte again...
  $A47D,$03 ...and combine the other bits of the byte with the new direction...
  $A480,$03 ...and store it.
@ $A483 label=MoveProgramPacket_Store
  $A483,$03 Store the position of the packet.
  $A486,$04 Do not flip the sprite of the packet...
  $A48A,$04 ...if the lowest bit of the direction is clear...
  $A48E,$03 ...and draw the packet using #R$BDCD.
  $A491,$04 Otherwise flip the sprite...
  $A495,$03 ...and draw the packet using #R$BDCD.

c $A498 Test Cell In Direction
@ $A498 label=TestCellInDirection
D $A498 Finds the type of the cell next to an entity in a direction, and tests
. whether a program packet could go there. The directions are #N$00 for the
. lower X cell, #N$01 for the higher Y cell, #N$02 for the higher X cell and
. #N$03 for the lower Y cell.
R $A498 A Direction
R $A498 F The zero flag is set if the direction is zero
R $A498 DE X position
R $A498 HL Y position
R $A498 O:IY Address of the cell
R $A498 O:F The zero flag is set if the packet could go to the cell
R $A498 O:A The type of the cell
  $A498,$01 Keep the direction.
  $A499,$02 Save the position.
  $A49B,$02 Jump if the direction is zero.
  $A49D,$03 Jump if the direction is one.
  $A4A0,$03 Jump if the direction is two.
  $A4A3,$01 Otherwise use the lower Y cell.
@ $A4A4 label=TestCellInDirection_Cell
  $A4A4,$03 Find the cell using #R$BF97.
  $A4A7,$03 Copy its address into #REGiy.
  $A4AA,$02 Restore the position.
  $A4AC,$02 Return with the zero flag set if the cell is empty (type #N$00).
  $A4AE,$03 Return with the zero flag set if the type is #N$0F.
  $A4B1,$03 Return with the zero flag set if the type is #N$01.
  $A4B4,$03 Return with the zero flag set if the type is #N$07.
  $A4B7,$03 Compare the type with #N($09), and return.
@ $A4BA label=TestCellInDirection_X1
  $A4BA,$03 Use the lower X cell, and jump back.
@ $A4BD label=TestCellInDirection_Y1
  $A4BD,$03 Use the higher Y cell, and jump back.
@ $A4C0 label=TestCellInDirection_X2
  $A4C0,$03 Use the higher X cell, and jump back.

c $A4C3 Choose Direction
@ $A4C3 label=ChooseDirection
D $A4C3 Finds a direction for a program packet to go in, which is the one that
. it is heading in if that is possible, and otherwise the one to the side, the
. opposite one, and the other side.
R $A4C3 A Direction of the packet
R $A4C3 DE X position
R $A4C3 HL Y position
R $A4C3 O:A The type of the cell, if the zero flag is set
R $A4C3 O:C The direction that has been chosen
R $A4C3 O:F The zero flag is set if the packet can go on
  $A4C3,$04 Try the direction that the packet is heading in, and return if it
. can go there.
  $A4C7,$04 Try the direction before it...
  $A4CB,$04 ...and return if the packet can go there.
  $A4CF,$03 Try the opposite direction...
  $A4D2,$04 ...and return if the packet can go there.
  $A4D6,$04 Try the direction after the original one...
  $A4DA,$02 Jump to #R$A498.

c $A4DC Animate Program
@ $A4DC label=AnimateProgram
D $A4DC The handler for entity types #N$74 to #N($77), which are the sprites of
. an installed program in the map. The stripe moves on to the next frame.
. sprites in turn.
R $A4DC IX Entity
  $A4DC,$03 Fetch the type of the entity.
  $A4DF,$01 Keep the type.
  $A4E0,$03 Take one off and limit it to the four sprites...
  $A4E3,$01 ...and keep that in #REGd.
  $A4E4,$01 Fetch the type again.
  $A4E5,$03 Replace the sprite with the new one...
  $A4E8,$03 ...and store the type.
  $A4EB,$01 Return.

c $A4EC Move Hunter
@ $A4EC label=MoveHunter
D $A4EC The handler for entity types #N$60 to #N($63), which are enemies that
. hunt for the robot. The enemy heads for the robot, and chooses a new
. direction when it is blocked.
R $A4EC IX Entity
  $A4EC,$03 Move on to the next sprite using #R$B05A.
  $A4EF,$03 Remove the enemy if it is far away from the camera using #R$A104.
  $A4F2,$03 Fetch the position of the enemy.
  $A4F5,$02 The enemy can take up to #N$40 steps in this frame.
@ $A4F7 label=MoveHunter_Step
  $A4F7,$03 Take a step using #R$A12D.
  $A4FA,$02 Jump if the enemy has been blocked by a cell.
  $A4FC,$03 Check whether another enemy is in the way using #R$A576.
  $A4FF,$02 Jump if there is.
  $A501,$04 Jump if the enemy is not at the start of a cell.
  $A505,$03 Choose a direction towards the robot using #R$A282...
  $A508,$03 ...and store it.
  $A50B,$04 Loop back to take another step if there are steps left.
@ $A50F label=MoveHunter_Store
  $A50F,$03 Store the new position of the enemy.
  $A512,$03 Face the enemy in the direction that it is heading using #R$A550.
  $A515,$03 Draw the enemy using #R$BDCD.
@ $A518 label=MoveHunter_Blocked
  $A518,$01 Save the Y position.
  $A519,$03 Fetch the address of the cell that blocked the enemy...
  $A51C,$01 ...and its type.
  $A51D,$02 Keep the current type of the cell.
  $A51F,$02 Jump to choose a direction.
N $A521 This code is never run. It would have let the enemy pick up programs,
. like #R$A218.
@ $A521 label=MoveHunter_Unused
  $A521,$04 Jump to pick up the item if the cell is type #N$06...
  $A525,$04 ...or type #N$07.
@ $A529 label=MoveHunter_Unused_Pick
  $A529,$01 Keep the type.
  $A52A,$03 Fetch the item that the enemy is carrying.
  $A52D,$03 Jump if it is carrying one already.
  $A530,$03 Store the item that it has picked up.
  $A533,$03 Remove it from the cell using #R$A2AD.
  $A536,$01 Restore the Y position.
  $A537,$02 Carry on.
@ $A539 label=MoveHunter_Turn
  $A539,$01 Restore the Y position.
  $A53A,$03 Choose a direction towards the robot using #R$A282...
  $A53D,$03 ...and store it.
  $A540,$03 Draw the enemy using #R$BDCD.
N $A543 The enemy is in the way of another enemy.
@ $A543 label=MoveHunter_Reverse
  $A543,$03 Turn the enemy round using #R$A891.
  $A546,$03 Face the enemy in the direction that it is heading using #R$A550.
  $A549,$03 Draw the enemy using #R$BDCD.
  $A54C,$01 Return if it was not drawn.
  $A54D,$03 Otherwise make a sound using #R$C048.

c $A550 Face Enemy
@ $A550 label=FaceEnemy
D $A550 Sets the flags of the type of an enemy, which select how its sprite is
. flipped, according to the direction that it is heading in.
R $A550 IX Entity
  $A550,$04 Do not flip the sprite...
  $A554,$04 ...and use the first pair of sprites...
  $A558,$03 ...and fetch the direction.
  $A55B,$04 Jump if the lowest bit of the direction is set.
  $A55F,$04 Otherwise flip the sprite.
@ $A563 label=FaceEnemy_Sprite
  $A563,$02 Invert the direction...
  $A565,$03 ...and return if bit 1 of the result is set.
  $A568,$04 Otherwise use the second pair of sprites.
  $A56C,$01 Return.

c $A56D Check Entity Overlap
@ $A56D label=CheckEntityOverlap
D $A56D Checks whether the entity overlaps any of the first fourteen entities,
. which are the robot, the shots, the enemies and the program packet.
R $A56D IX Entity
R $A56D DE X position
R $A56D HL Y position
R $A56D O:IY The entity that has been hit
R $A56D O:F The carry flag is set if there is one
  $A56D,$01 Save the registers.
  $A56E,$02 There are #N$0E entities to check.
  $A570,$04 Point #REGiy at #R$9690.
  $A574,$02 Jump to check them.

c $A576 Check Enemy Overlap
@ $A576 label=CheckEnemyOverlap
D $A576 Checks whether the entity overlaps any of the ten entities that are
. enemies (entities #N$04 to #N$0D), apart from itself.
R $A576 IX Entity
R $A576 DE X position
R $A576 HL Y position
R $A576 O:IY The entity that has been hit
R $A576 O:F The carry flag is set if there is one
  $A576,$01 Save the register.
  $A577,$02 There are ten enemies to check.
  $A579,$04 Point #REGiy at #R$96D0.
@ $A57D label=CheckEnemyOverlap_Next
  $A57D,$01 Save the counter.
  $A57E,$03 Fetch the type of the entity.
  $A581,$03 Jump if the entity is not in use.
  $A584,$01 Save the Y position.
  $A585,$03 Copy the address of the entity being moved into #REGhl...
  $A588,$03 ...and the address of the entity that is being checked into #REGbc.
  $A58B,$03 Subtract one from the other...
  $A58E,$01 ...restoring the Y position...
  $A58F,$02 ...and jump if they are the same entity.
  $A591,$03 Use #N$F0 as the distance in both directions.
  $A594,$03 Compare the positions using #R$A5EA.
  $A597,$02 Jump if they overlap.
@ $A599 label=CheckEnemyOverlap_Skip
  $A599,$03 Each entity is #N$10 bytes long.
  $A59C,$02 Move on to the next one.
  $A59E,$01 Restore the counter.
  $A59F,$02 Loop back until every entity has been checked.
  $A5A1,$01 Clear the carry flag...
  $A5A2,$01 ...restore the register...
  $A5A3,$01 ...and return.
@ $A5A4 label=CheckEnemyOverlap_Hit
  $A5A4,$01 Discard the counter...
  $A5A5,$01 ...and restore the register.
  $A5A6,$01 Return with the carry flag set.

c $A5A7 Check Shot Hit
@ $A5A7 label=CheckShotHit
D $A5A7 Checks whether an entity (a shot, or the robot) has run into an enemy.
. If it has, then both are turned into smoke and the player is awarded some
. points.
R $A5A7 IX Entity
R $A5A7 O:IY The enemy that has been hit
  $A5A7,$02 There are ten enemies to check.
  $A5A9,$04 Point #REGiy at #R$96D0.
@ $A5AD label=CheckShotHit_Next
  $A5AD,$01 Save the counter.
  $A5AE,$03 Fetch the type of the enemy.
  $A5B1,$03 Jump if the entity is not in use.
  $A5B4,$06 Jump if it is smoke or a sprite of a materialising enemy (types
. #N$38 to #N$4F).
  $A5BA,$03 Use #N$C0 as the distance in both directions.
  $A5BD,$03 Compare the positions using #R$A5EA.
  $A5C0,$02 Jump if they overlap.
@ $A5C2 label=CheckShotHit_Skip
  $A5C2,$03 Each entity is #N$10 bytes long.
  $A5C5,$02 Move on to the next one.
  $A5C7,$01 Restore the counter.
  $A5C8,$02 Loop back until every enemy has been checked.
  $A5CA,$01 Return.
@ $A5CB label=CheckShotHit_Hit
  $A5CB,$01 Discard the counter.
  $A5CC,$03 Fetch the type of the entity that has hit the enemy...
  $A5CF,$03 ...and keep it.
  $A5D2,$04 Keep the address of the enemy that was hit.
  $A5D6,$03 Fetch the type of the enemy...
  $A5D9,$03 ...and keep it.
  $A5DC,$05 Turn the shot into smoke...
  $A5E1,$03 ...and the enemy too.
  $A5E4,$03 Add #N$0123 points...
  $A5E7,$03 Jump to #R$B573.

c $A5EA Compare Positions
@ $A5EA label=ComparePositions
D $A5EA Compares the position of an entity with the position of another one, in
. both directions.
R $A5EA IY Entity to compare with
R $A5EA DE X position
R $A5EA HL Y position
R $A5EA B Maximum difference in the Y direction
R $A5EA C Maximum difference in the X direction
R $A5EA O:F The carry flag is set if both differences are small enough
  $A5EA,$01 Save the Y position...
  $A5EB,$01 ...and the X position.
  $A5EC,$06 Fetch the Y position of the other entity.
  $A5F2,$05 Subtract it from the Y position, and jump if the result is positive.
  $A5F7,$07 Otherwise negate it.
@ $A5FE label=ComparePositions_TestY
  $A5FE,$05 Jump if the difference is more than the size of the world.
  $A603,$04 Jump if the difference is not less than the maximum.
  $A607,$02 Restore the X position into #REGhl and save it again.
  $A609,$06 Fetch the X position of the other entity.
  $A60F,$05 Subtract it from the X position, and jump if the result is positive.
  $A614,$07 Otherwise negate it.
@ $A61B label=ComparePositions_TestX
  $A61B,$05 Jump if the difference is more than the size of the world.
  $A620,$02 Compare the difference with the maximum, which sets the carry flag
. if it is less.
@ $A622 label=ComparePositions_Done
  $A622,$01 Restore the X position...
  $A623,$01 ...and the Y position.
  $A624,$01 Return.

c $A625 Do Nothing
@ $A625 label=DoNothing
D $A625 The handler for entity types that do nothing.
  $A625,$01 Return.

c $A626 Fire Weapon A
@ $A626 label=FireWeaponA
D $A626 Fires a spark, which is the first weapon of the robot. It costs eight
. units of energy and needs the battery to have at least #N$10 units.
R $A626 A Controls that are being pressed
R $A626 IX Robot
  $A626,$02 Clear the flag that says that the first weapon has been fired...
  $A628,$03 ...and store the controls.
  $A62B,$03 Point #REGhl at the first of the three entities that are used for
. shots.
  $A62E,$03 Each entity is #N$10 bytes long.
  $A631,$02 There are three entities to check.
@ $A633 label=FireWeaponA_Check
  $A633,$01 Fetch the type of the entity.
  $A634,$05 Return if it is one of the sprites #N$58 to #N$5B (the shots never
. use these types, so this never stops the weapon).
  $A639,$01 Move on to the next entity.
  $A63A,$02 Loop back until all three have been checked.
  $A63C,$03 Set the cost of the shot to #N$0800...
  $A63F,$04 ...and store it.
  $A643,$03 Point #REGhl at the first of the entities for shots again.
  $A646,$03 Use three entities, and use type #N$3C for the sprite.
  $A649,$02 Use the lowest two bits of the type of the robot...
  $A64B,$03 ...to choose the sprite of the shot (this changes the mask used by
. the instruction at #R$A689).
  $A64E,$03 Fetch the level of the battery.
  $A651,$03 Return if it is below #N$10.
  $A654,$02 Jump to fire the shot.

c $A656 Fire Weapon B
@ $A656 label=FireWeaponB
D $A656 Fires a pellet, which is the second weapon of the robot. It is cheaper
. than a spark, as it only costs half a unit of energy.
R $A656 A Controls that are being pressed
R $A656 IX Robot
  $A656,$02 Clear the flag that says that the second weapon has been fired...
  $A658,$03 ...and store the controls.
  $A65B,$03 Point #REGhl at the first of the three entities that are used for
. shots.
  $A65E,$03 Each entity is #N$10 bytes long.
  $A661,$03 Set the cost of the shot to #N$0080...
  $A664,$04 ...and store it.
  $A668,$03 Use three entities, and use type #N$30 for the sprite.
  $A66B,$02 Use the lowest three bits of the type of the robot...
  $A66D,$03 ...to choose the sprite of the shot (this changes the mask used by
. the instruction at #R$A689).
N $A670 This entry point finds an entity that is not in use and starts a shot
. there.
@ $A670 label=FireWeapon_Find
  $A670,$01 Fetch the type of the entity.
  $A671,$03 Jump if it is not in use.
  $A674,$01 Move on to the next entity.
  $A675,$02 Loop back until all of them have been tried.
  $A677,$01 Return, as all are in use.
@ $A678 label=FireWeapon_Start
  $A678,$01 Save the address of the entity...
  $A679,$01 ...and the size of an entity.
  $A67A,$04 Fetch the cost of the shot.
  $A67E,$03 Take it off the energy of the battery using #R$A6AE.
  $A681,$01 Restore the size of an entity...
  $A682,$01 ...and the address of the entity.
  $A683,$01 Return if there was not enough energy.
  $A684,$03 Fetch the type of the robot...
  $A687,$01 ...divide it by two...
  $A688,$01 ...and keep it in #REGb.
  $A689,$02 Keep the bits that choose the sprite (the mask is changed by the
. code above, from #N$07 to #N$03 for the first weapon)...
  $A68B,$01 ...and use them with the first sprite of the shot...
  $A68C,$01 ...as the type of the shot.
  $A68D,$01 Move on to the X fraction of the shot.
  $A68E,$04 Copy the X fraction of the robot to the shot.
  $A692,$01 Move on to the X cell of the shot.
  $A693,$04 Copy the X cell of the robot to the shot.
  $A697,$01 Move on to the Y fraction of the shot.
  $A698,$04 Copy the Y fraction of the robot to the shot.
  $A69C,$01 Move on to the Y cell of the shot.
  $A69D,$04 Copy the Y cell of the robot to the shot.
  $A6A1,$03 Move on to the byte that holds the direction and the range.
  $A6A4,$01 Fetch the type of the robot, divided by two.
  $A6A5,$01 Divide it by two again...
  $A6A6,$02 ...and keep the direction...
  $A6A8,$02 ...together with the range of six cells.
  $A6AA,$01 Store them.
  $A6AB,$03 Jump to #R$C04E.

c $A6AE Use Energy
@ $A6AE label=UseEnergy
D $A6AE Takes an amount of energy out of the battery. If there is not enough
. then the battery is empty and the robot is destroyed, along with all of the
. enemies. The energy is free once every sector has been either activated or
. destroyed.
R $A6AE DE Energy to use
R $A6AE O:F The carry flag is set if there was not enough energy
  $A6AE,$03 Fetch the number of sectors that have been activated.
  $A6B1,$01 Keep the number of activated sectors.
  $A6B2,$03 Fetch the number of sectors that have been destroyed.
  $A6B5,$01 Add the number that have been activated...
  $A6B6,$03 ...and store the number of sectors that have been dealt with.
  $A6B9,$04 Jump if some sectors have not been dealt with.
  $A6BD,$02 Otherwise clear the carry flag and return, as the energy is free.
@ $A6BF label=UseEnergy_Take
  $A6BF,$03 Fetch the energy of the battery.
N $A6C2 See #POKE(infinite_energy,Infinite Energy).
  $A6C2,$03 Subtract the energy that is to be used.
  $A6C5,$02 Jump if there is not enough energy.
  $A6C7,$03 Otherwise store the new energy...
  $A6CA,$01 ...and return.
@ $A6CB label=UseEnergy_Empty
  $A6CB,$03 The battery is empty.
  $A6CE,$03 Store that.
  $A6D1,$01 Save the carry flag.
  $A6D2,$02 Turn the robot into smoke...
  $A6D4,$03 ...by setting its type to #N$38.
  $A6D7,$01 Clear the controls...
  $A6D8,$03 ...so that nothing is fired.
  $A6DB,$03 Turn all of the enemies into smoke using #R$A727.
  $A6DE,$01 Restore the carry flag...
  $A6DF,$01 ...and return.

c $A6E0 Move Pellet
@ $A6E0 label=MovePellet
D $A6E0 The handler for entity types #N$30 to #N($37), which are the shots that
. the robot fires using the second weapon. A pellet moves across the map until
. it hits something or has run out of range.
R $A6E0 IX Entity
  $A6E0,$03 Move on to the next sprite using #R$B05A.
  $A6E3,$03 Fetch the position of the pellet.
  $A6E6,$02 The pellet can take up to #N$C0 steps in this frame.
@ $A6E8 label=MovePellet_Step
  $A6E8,$03 Take a step using #R$A12D.
  $A6EB,$02 Jump if the pellet has hit something.
  $A6ED,$04 Jump if the pellet is not at the start of a cell.
  $A6F1,$03 Fetch the range of the pellet...
  $A6F4,$02 ...take away one cell...
  $A6F6,$03 ...and store it.
  $A6F9,$04 Jump to turn the pellet into smoke if it has run out of range.
  $A6FD,$04 Loop back to take another step if there are steps left.
@ $A701 label=MovePellet_Store
  $A701,$03 Store the position of the pellet, check whether it has hit an enemy
. and draw it using #R$A165.
@ $A704 label=MovePellet_Explode
  $A704,$04 Turn the pellet into smoke by changing its type to #N$38.
  $A708,$02 Jump back to store the position.

c $A70A Animate Smoke
@ $A70A label=AnimateSmoke
D $A70A The handler for entity types #N$38 to #N($3A), which are the sprites of
. smoke. It moves on to the next sprite, makes a sound and draws the smoke. The
. last sprite of the smoke is handled by #R$A713.
R $A70A IX Entity
  $A70A,$03 Move on to the next sprite.
  $A70D,$03 Make the sound of an explosion using #R$C08D.
  $A710,$03 Draw the smoke using #R$BDCD.

c $A713 End Smoke
@ $A713 label=EndSmoke
D $A713 The handler for entity type #N($3B), which is the last sprite of the
. smoke. If the robot has exploded then it loses a life, and otherwise the
. entity is removed.
R $A713 IX Entity
  $A713,$03 Make the sound of an explosion using #R$C08D.
  $A716,$03 Copy the address of the entity into #REGhl.
  $A719,$03 Point #REGde at #R$9690.
  $A71C,$06 Subtract the address of the robot, and lose a life using #R$B6BC if
. the entity is the robot.
  $A722,$04 Otherwise remove the entity by setting its type to zero.
  $A726,$01 Return.

c $A727 Explode Enemies
@ $A727 label=ExplodeEnemies
D $A727 Turns every enemy that is in use into smoke.
  $A727,$03 Point #REGhl at the first enemy.
  $A72A,$03 Each entity is #N$10 bytes long.
  $A72D,$02 There are ten enemies.
@ $A72F label=ExplodeEnemies_Next
  $A72F,$01 Fetch the type of the enemy.
  $A730,$03 Jump if the enemy is not in use.
  $A733,$02 Otherwise turn it into smoke.
@ $A735 label=ExplodeEnemies_Skip
  $A735,$01 Move on to the next enemy.
  $A736,$02 Loop back until every enemy has been dealt with.
  $A738,$01 Return.

c $A739 Spawn Enemies
@ $A739 label=SpawnEnemies
D $A739 Called every frame while the robot is alive. It tries to start a new
. enemy at a random position in the sector that the robot is in, and tries to
. start a new destroyer in the sector that is under attack. A new enemy starts
. as the sprites that show it materialising. The enemy is only started if there
. is a free entity, and if the cell that is chosen at random is empty.
  $A739,$03 Fetch the type of the robot.
  $A73C,$03 Return if it is below #N$10.
  $A73F,$03 Return if it is #N$30 or above, as the robot is not in a walking
. state.
  $A742,$03 Point #REGhl at the first of the six entities that are used for
. enemies.
  $A745,$03 Each entity is #N$10 bytes long.
  $A748,$02 There are six entities to check.
@ $A74A label=SpawnEnemies_Find
  $A74A,$01 Fetch the type of the entity.
  $A74B,$03 Jump if it is not in use.
  $A74E,$01 Move on to the next entity.
  $A74F,$02 Loop back until all of them have been tried.
  $A751,$02 Jump to try to start a destroyer.
@ $A753 label=SpawnEnemies_UseFirstEntity
  $A753,$01 Copy the address of the entity into #REGix...
  $A754,$02 Pop it into #REGix.
  $A756,$02 There are #N$10 bytes to clear.
@ $A758 label=SpawnEnemies_Clear
  $A758,$02 Clear a byte of the entity.
  $A75A,$01 Move on to the next byte.
  $A75B,$02 Loop back until the entity has been cleared.
  $A75D,$03 Fetch the X cell of the camera...
  $A760,$02 ...and keep the sector (a multiple of #N$10).
  $A762,$01 Keep the sector column of the camera.
  $A763,$03 Fetch the random number...
  $A766,$02 ...limited to #N$00-#N$0F...
  $A768,$01 ...and combine it with the sector to choose the X cell.
  $A769,$04 Jump if it is outside the map, which is #N$30 cells wide.
  $A76D,$01 Keep the X cell...
  $A76E,$02 ...and use zero for the fraction.
  $A770,$03 Fetch the Y cell of the camera...
  $A773,$02 ...and keep the sector.
  $A775,$01 Keep the sector row of the camera.
  $A776,$03 Fetch the frame counter...
  $A779,$02 ...limited to #N$00-#N$0F...
  $A77B,$01 ...and combine it with the sector to choose the Y cell.
  $A77C,$04 Jump if it is outside the map, which is #N$30 cells high.
  $A780,$01 Keep the Y cell...
  $A781,$02 ...and use zero for the fraction.
  $A783,$03 Find the cell using #R$BF97.
  $A786,$02 Jump if it is not empty.
  $A788,$04 Start the enemy with the first sprite of the sequence that shows it
. materialising.
  $A78C,$03 Store its position.
  $A78F,$03 Check whether another enemy is in the way using #R$A576.
  $A792,$02 Jump if there is not.
  $A794,$04 Otherwise cancel the new enemy...
  $A798,$02 ...and jump to try to start a destroyer.
@ $A79A label=SpawnEnemies_Random
  $A79A,$02 Fetch a number from the memory refresh register...
  $A79C,$02 ...limit it to a time and a direction...
  $A79E,$03 ...and store it.
  $A7A1,$03 Fetch the number of sectors that have been activated.
  $A7A4,$01 Test whether there are any.
  $A7A5,$03 Fetch the random number.
  $A7A8,$02 Jump if some sectors have been activated, to use any of the kinds of
. enemy.
  $A7AA,$02 Otherwise limit the choice to the first two kinds of enemy...
@ $A7AC label=SpawnEnemies_AnyKind
  $A7AC,$02 ...and limit the choice to the eight entries of the table.
  $A7AE,$03 Use it as an index...
  $A7B1,$03 Point #REGbc at #R$A81E.
  $A7B4,$01 Add the index.
  $A7B5,$01 Fetch the type that the enemy is going to have...
  $A7B6,$03 ...and store it.
N $A7B9 Now try to start a destroyer. Destroyers are only started while a sector
. is under attack.
@ $A7B9 label=SpawnEnemies_Destroyer
  $A7B9,$03 Point #REGhl at the first of the four entities that are used for
. destroyers.
  $A7BC,$03 Each entity is #N$10 bytes long.
  $A7BF,$02 There are four entities to check.
@ $A7C1 label=SpawnEnemies_FindDestroyer
  $A7C1,$01 Fetch the type of the entity.
  $A7C2,$03 Jump if it is not in use.
  $A7C5,$01 Move on to the next entity.
  $A7C6,$02 Loop back until all of them have been tried.
  $A7C8,$01 Return.
@ $A7C9 label=SpawnEnemies_UseSecondEntity
  $A7C9,$01 Copy the address of the entity into #REGix...
  $A7CA,$02 Pop it into #REGix.
  $A7CC,$02 There are #N$10 bytes to clear.
@ $A7CE label=SpawnEnemies_ClearDestroyer
  $A7CE,$02 Clear a byte of the entity.
  $A7D0,$01 Move on to the next byte.
  $A7D1,$02 Loop back until the entity has been cleared.
  $A7D3,$03 Fetch the code of the sector that is under attack...
  $A7D6,$01 ...and keep it in #REGc.
  $A7D7,$01 Move the bits for the row into place...
  $A7D8,$01 Shift the row one more place.
  $A7D9,$02 ...and keep them.
  $A7DB,$03 Return if there is no sector under attack.
  $A7DE,$02 Turn the row upside down...
  $A7E0,$02 ...and use it to find the Y cell of the sector.
  $A7E2,$01 Keep the Y cell.
  $A7E3,$03 Fetch the random number...
  $A7E6,$02 ...limited to #N$00-#N$0F...
  $A7E8,$01 ...and combine it with the sector to choose the Y cell...
  $A7E9,$01 ...and keep it in #REGh.
  $A7EA,$01 Fetch the code of the sector again.
  $A7EB,$03 Move the bits for the column into place...
  $A7EE,$02 ...and keep them.
  $A7F0,$03 Return if there is no sector under attack.
  $A7F3,$01 Keep the sector.
  $A7F4,$02 Fetch a number from the memory refresh register...
  $A7F6,$02 ...limited to #N$00-#N$0F...
  $A7F8,$01 ...combine it with the sector to choose the X cell...
  $A7F9,$01 ...and keep it in #REGd.
  $A7FA,$02 Use zero for the fraction of the Y position...
  $A7FC,$01 ...and of the X position.
  $A7FD,$03 Find the cell using #R$BF97.
  $A800,$01 Return if it is not empty.
  $A801,$04 Start the destroyer with the first sprite of the sequence that shows
. it materialising.
  $A805,$03 Store its position.
  $A808,$03 Check whether another enemy is in the way using #R$A576.
  $A80B,$02 Jump if there is not.
  $A80D,$04 Otherwise cancel the new destroyer...
  $A811,$01 ...and return.
@ $A812 label=SpawnEnemies_SetType
  $A812,$04 Set the type that the destroyer will have when it has materialised.
  $A816,$04 Choose a random direction and time...
  $A81A,$03 ...and store it.
  $A81D,$01 Return.

b $A81E Enemy Types
@ $A81E label=EnemyTypes
D $A81E The types of enemy that are started, selected at random. Until the first
. sector has been activated only the first two types (#N$08 and #N$0C) are used.
B $A81E,$08,$04 Types #N$08 and #N($0C), then #N$50 and #N$60.

c $A826 Move Saucer
@ $A826 label=MoveSaucer
D $A826 The handler for entity types #N$08 to #N($0B), which are the saucers. A
. saucer is the faster of the two types of enemy that wander about at random; it
. can take up to #N$60 steps in a frame. A saucer that hits the robot explodes.
R $A826 IX Entity
  $A826,$03 Move on to the next sprite using #R$B063.
  $A829,$03 Remove the entity if it is far from the camera using #R$A104.
  $A82C,$03 Fetch the position of the entity.
  $A82F,$02 The saucer can take up to #N$60 steps in this frame.
  $A831,$02 Jump to take the first step.

c $A833 Move Dome
@ $A833 label=MoveDome
D $A833 The handler for entity types #N$0C to #N($0F), which are the domes.
. A dome is the slower of the two types of enemy that wander about at
. random; it can take up to #N$20 steps in a frame.
R $A833 IX Entity
  $A833,$03 Move on to the next sprite using #R$B063.
  $A836,$03 Remove the entity if it is far from the camera using #R$A104.
  $A839,$03 Fetch the position of the entity.
  $A83C,$02 The dome can take up to #N$20 steps in this frame.
N $A83E This entry point is shared by both kinds of enemy.
@ $A83E label=MoveEnemy_Step
  $A83E,$03 Take a step using #R$A12D.
  $A841,$02 Jump if the enemy has been blocked.
  $A843,$03 Check whether the enemy has run into another entity using #R$A576.
  $A846,$02 Jump if it has, to turn it round.
  $A848,$04 Jump if the enemy is not at the start of a cell.
  $A84C,$03 Fetch the time and direction of the enemy...
  $A84F,$02 ...take away one cell...
  $A851,$03 ...and store it.
  $A854,$04 Jump to choose a new direction if the time has run out.
  $A858,$04 Loop back to take another step if there are steps left.
@ $A85C label=MoveEnemy_Store
  $A85C,$03 Store the position of the enemy using #R$AEE0.
  $A85F,$03 Jump to #R$BDCD.
@ $A862 label=MoveEnemy_Turn
  $A862,$03 Fetch the time and direction of the enemy...
  $A865,$02 ...keep the direction only...
  $A867,$03 ...and store it.
  $A86A,$03 Fetch the frame counter...
  $A86D,$02 ...and use it as a random direction.
  $A86F,$03 Compare it with the current direction.
  $A872,$02 Jump if they are different.
  $A874,$01 Otherwise turn a quarter of a turn.
  $A875,$02 Keep the direction within four.
@ $A877 label=MoveDome_NewDirection
  $A877,$01 Keep the new direction.
  $A878,$03 Fetch the random number...
  $A87B,$04 ...and use the upper bits as the time to keep going in this
. direction.
  $A87F,$02 Use a time of one cell if that is zero.
@ $A881 label=MoveDome_SetTime
  $A881,$01 Combine the time with the new direction...
  $A882,$03 ...and store them.
  $A885,$02 Jump back to store the position.
@ $A887 label=MoveEnemy_Collide
  $A887,$03 Turn the enemy round using #R$A891.
  $A88A,$03 Draw it using #R$BDCD.
  $A88D,$01 Return if it is off the screen.
  $A88E,$03 Make the sound of a bump using #R$C048.

c $A891 Reverse Direction
@ $A891 label=ReverseDirection
D $A891 Turns an enemy round, so that it faces the opposite direction.
R $A891 IX Entity
  $A891,$01 Save #REGbc.
  $A892,$03 Fetch the time and direction of the enemy...
  $A895,$01 ...and keep them in #REGc.
  $A896,$02 Add two to the direction...
  $A898,$02 ...and keep just the direction...
  $A89A,$01 ...in #REGb.
  $A89B,$01 Fetch the time and direction again...
  $A89C,$02 ...clear the old direction...
  $A89E,$01 ...and use the new one.
  $A89F,$03 Store them.
  $A8A2,$01 Restore #REGbc.
  $A8A3,$01 Return.

c $A8A4 Finish Robot Turn
@ $A8A4 label=FinishRobotTurn
D $A8A4 The handler for entity types #N$20 to #N($2F), which are the sprites
. that the robot has while it is turning. The turn is finished at once;
. the entity gets one of the types for walking (#N$10 to #N$1F) and the robot
. is checked
. for a collision with an enemy. If the robot has hit an enemy it loses some
. energy, and it is destroyed if it has none left. This routine then handles the
. entity again as its new type, without drawing it.
R $A8A4 IX Entity
  $A8A4,$03 Fetch the controls...
  $A8A7,$02 ...clear the left and right bits...
  $A8A9,$03 ...and store them.
  $A8AC,$03 Fetch the speed of the robot into #REGb.
  $A8AF,$02 Clear the low byte of the step count.
  $A8B1,$03 Fetch the type of the robot...
  $A8B4,$04 ...change it into the matching type for walking...
  $A8B8,$03 ...and store it.
  $A8BB,$03 Fetch the new type...
  $A8BE,$01 ...and keep it in #REGa'.
  $A8BF,$03 Check whether the robot has hit an enemy using #R$A5A7.
  $A8C2,$03 Fetch the type of the robot again.
  $A8C5,$04 Jump if it has not been turned into smoke.
  $A8C9,$03 Fetch the number of sectors that have been dealt with.
  $A8CC,$02 Add #N$1A to get the energy that the collision costs...
  $A8CE,$01 ...and keep it in #REGb.
  $A8CF,$03 Fetch the energy of the battery.
  $A8D2,$01 Take off the cost.
  $A8D3,$02 Jump if there is not enough energy.
  $A8D5,$01 Otherwise get the type that the robot had...
  $A8D6,$03 ...and restore it, so that it is not destroyed...
  $A8D9,$01 Switch back to the energy.
  $A8DA,$02 ...and jump to store the energy.
@ $A8DC label=FinishRobotTurn_NoEnergy
  $A8DC,$01 The battery is empty.
@ $A8DD label=FinishRobotTurn_Store
  $A8DD,$03 Store the energy of the battery.
@ $A8E0 label=FinishRobotTurn_Discard
  $A8E0,$01 Discard the return address...
  $A8E1,$03 ...and handle the entity again as its new type using #R$9970.

c $A8E4 Get Robot Speed
@ $A8E4 label=GetRobotSpeed
D $A8E4 Works out how far the robot moves in this frame. When the robot is told
. to speed up it uses some energy and accelerates, up to a limit of #N$40. When
. it is not it slows down: the speed is the distance to the next cell, in the
. direction that it is heading, so the robot always stops at the start of a
. cell.
R $A8E4 IX Robot
R $A8E4 O:B The distance to move
  $A8E4,$03 Fetch the controls.
  $A8E7,$04 Jump if the key to speed up is being pressed.
  $A8EB,$03 Fetch the type of the robot...
  $A8EE,$02 ...and turn it into the direction that it is heading in.
  $A8F0,$04 Jump if the robot is heading in direction zero (X decreasing).
  $A8F4,$01 Count down the direction.
  $A8F5,$02 Jump if the robot is heading in direction one (Y increasing).
  $A8F7,$01 Count down the direction.
  $A8F8,$02 Jump if the robot is heading in direction two (X increasing).
  $A8FA,$03 The robot is heading in direction three (Y decreasing), so fetch the
. fraction of the Y position...
  $A8FD,$02 ...and jump to limit the distance.
@ $A8FF label=GetRobotSpeed_XIncreasing
  $A8FF,$03 Fetch the fraction of the X position of the robot...
  $A902,$02 ...and jump to turn it round.
@ $A904 label=GetRobotSpeed_YIncreasing
  $A904,$03 Fetch the fraction of the Y position of the robot.
@ $A907 label=GetRobotSpeed_Negate
  $A907,$02 Subtract it from zero, to get the distance to the next cell.
  $A909,$02 Jump to limit the distance.
@ $A90B label=GetRobotSpeed_XDecreasing
  $A90B,$03 Fetch the fraction of the X position of the robot.
@ $A90E label=GetRobotSpeed_Limit
  $A90E,$04 Jump if the distance is below #N$40...
@ $A912 label=GetRobotSpeed_UseDefault
  $A912,$02 ...otherwise use #N$40.
@ $A914 label=GetRobotSpeed_Store
  $A914,$03 Store the speed of the robot...
  $A917,$03 ...and fetch it...
  $A91A,$01 ...into #REGb.
  $A91B,$01 Return.
@ $A91C label=GetRobotSpeed_Accelerate
  $A91C,$02 Clear the bit for speeding up...
  $A91E,$03 ...and store the controls.
  $A921,$03 Using this costs eight units of energy.
  $A924,$03 Take them out of the battery using #R$A6AE.
  $A927,$03 Fetch the speed of the robot...
  $A92A,$02 ...and add #N$10.
  $A92C,$04 Jump to store it if the new speed is below #N$40.
  $A930,$02 Otherwise jump to use #N$40.

c $A932 Materialise Entity
@ $A932 label=MaterialiseEntity
D $A932 The handler for entity types #N$40 to #N($4A), which are the sprites
. that show an enemy, or the robot, materialising. When the entity is
. going to be the robot it is drawn twice, once at a slight offset, which makes
. the picture look
. like it is shimmering. Each sprite is shown for a frame, and the next one is
. chosen by changing the type.
R $A932 IX Entity
  $A932,$03 Fetch the type that the entity will have when it has finished
. materialising.
  $A935,$06 Jump if that is a type for the robot (#N$10 to #N$2F).
  $A93B,$03 Draw the entity using #R$BDCD.
  $A93E,$02 Jump if it is not on the screen.
  $A940,$03 Make the sound of materialising using #R$C01A.
@ $A943 label=MaterialiseEntity_Next
  $A943,$03 Move on to the next sprite.
  $A946,$01 Return.
@ $A947 label=MaterialiseEntity_Robot
  $A947,$02 Save the address of the entity...
  $A949,$01 ...and copy it into #REGhl.
  $A94A,$01 Save it again.
  $A94B,$04 Use a temporary entity at #R$A96C...
  $A94F,$03 ...as the destination...
  $A952,$03 ...and copy the first eight bytes...
  $A955,$02 ...of the entity into it.
  $A957,$03 Fetch the X position of the entity...
  $A95A,$03 ...and the Y position.
  $A95D,$03 Use an offset of #N$0040 in the X direction.
  $A960,$03 Draw the entity at the offset using #R$A974.
  $A963,$02 Jump if it is not on the screen.
  $A965,$03 Make the sound of materialising using #R$C01A.
@ $A968 label=MaterialiseEntity_OffScreen
  $A968,$02 Restore the entity.
  $A96A,$02 Jump to move on to the next sprite.

b $A96C Temporary Entity
@ $A96C label=TemporaryEntity
D $A96C A copy of the first eight bytes of an entity, which is used while a
. robot is drawn at an offset.
B $A96C,$08,$08

c $A974 Draw Shifted Entity
@ $A974 label=DrawShiftedEntity
D $A974 Draws an entity at an offset in the X direction, and then puts its
. position back.
R $A974 IX Entity
R $A974 HL X position
R $A974 DE Offset
  $A974,$01 Save the X position.
  $A975,$01 Add the offset...
  $A976,$04 ...and keep the X cell within the map.
  $A97A,$03 Store the X position of the entity...
  $A97D,$03 Store the X cell.
  $A980,$03 Draw the entity using #R$BDCD.
  $A983,$01 Restore the X position...
  $A984,$03 ...and store it again.
  $A987,$03 Store the X cell again.
  $A98A,$01 Return.

c $A98B Finish Materialising
@ $A98B label=FinishMaterialising
D $A98B The handler for entity type #N($4B), which is the last sprite that shows
. an entity materialising. The entity is drawn, and then given the type that it
. is going to keep. If it is the robot then the controls are cleared.
R $A98B IX Entity
  $A98B,$03 Draw the entity using #R$BDCD.
  $A98E,$03 Fetch the type that the entity is going to have...
  $A991,$03 ...and set it.
  $A994,$03 Return if it is below #N$10.
  $A997,$03 Return if it is #N$30 or above, as it is not the robot.
  $A99A,$01 Clear the controls...
  $A99B,$03 Store the controls.
  $A99E,$01 Return.

c $A99F Start Robot
@ $A99F label=StartRobot
D $A99F Starts a new life. The robot is given the type that makes it wait, the
. number of lives goes down by one, the battery is filled up and the robot is
. shown on the map of the sectors.
  $A99F,$05 Set the type of the robot to #N($58), which makes it wait.
  $A9A4,$05 Set its timer to #N$20 frames.
N $A9A9 See #POKE(infinite_lives,Infinite Lives).
  $A9A9,$03 Point #REGhl at #R$968B.
  $A9AC,$01 ...and take one off.
  $A9AD,$04 Clear the controls.
  $A9B1,$05 Fill up the battery.
  $A9B6,$04 Fetch the X position of the robot...
  $A9BA,$03 ...and the Y position.
  $A9BD,$03 Draw the robot on the map of the sectors using #R$AE67.
  $A9C0,$03 Flash the panel using #R$A091.

c $A9C3 Move Entity
@ $A9C3 label=MoveEntity
D $A9C3 Moves an entity in the direction that it is heading, by up to the number
. of steps that is given. The entity stops at the start of a cell if the next
. cell is not empty. The routine keeps a copy of the position, so that a move
. can be undone.
R $A9C3 B Number of steps to take
R $A9C3 DE X position
R $A9C3 HL Y position
R $A9C3 IX Entity
R $A9C3 O:A #N$01 if the entity has been blocked
R $A9C3 O:B Number of steps that are left
R $A9C3 O:DE New X position
R $A9C3 O:HL New Y position
R $A9C3 O:F The zero flag is reset if the entity has been blocked
  $A9C3,$04 Keep the X position...
  $A9C7,$03 ...and the Y position, so that the move can be undone.
  $A9CA,$03 Fetch the direction of the entity...
  $A9CD,$05 ...and jump to move in direction zero (X decreasing)...
  $A9D2,$04 ...or direction one (Y increasing)...
  $A9D6,$04 ...or direction two (X increasing)...
  $A9DA,$03 ...or otherwise direction three (Y decreasing).

c $A9DD Move Left
@ $A9DD label=MoveLeft
D $A9DD Moves an entity in direction zero, which decreases the X position. See
. #R$A9C3 for how the move works.
R $A9DD B Number of steps to take
R $A9DD DE X position
R $A9DD HL Y position
R $A9DD O:A #N$01 if the entity has been blocked
R $A9DD O:B Number of steps that are left
R $A9DD O:DE New X position
R $A9DD O:F The zero flag is reset if the entity has been blocked
  $A9DD,$03 Return if there are no steps left.
  $A9E0,$04 Jump if the entity is at the start of a cell.
  $A9E4,$03 Take the steps off the fraction, and jump if that goes back into the
. previous cell.
  $A9E7,$01 Store the new fraction.
@ $A9E8 label=MoveLeft_Finish
  $A9E8,$03 Clear the number of steps that are left, and return with the zero
. flag set.
@ $A9EB label=MoveLeft_NextCell
  $A9EB,$02 Work out how many steps are left over...
  $A9ED,$01 ...and keep them in #REGb.
  $A9EE,$02 Move to the start of the cell, and return with the zero flag set.
  $A9F0,$01 Return.
@ $A9F1 label=MoveLeft_CellStart
  $A9F1,$01 Save the X position.
  $A9F2,$01 Take the steps off the fraction, which goes back into the previous
. cell...
  $A9F3,$01 ...and keep it.
  $A9F4,$01 Fetch the X cell...
  $A9F5,$02 ...and take one off...
  $A9F7,$03 ...making sure that the cell is within the map.
  $A9FA,$04 Keep this position.
  $A9FE,$03 Find the cell using #R$BF97.
  $AA01,$02 Jump if the cell is empty.
  $AA03,$01 Save the Y position.
  $AA04,$03 Fetch the address of the cell...
  $AA07,$01 ...and its contents...
  $AA08,$01 ...and restore the Y position.
  $AA09,$04 Jump if the cell has no type.
  $AA0D,$04 Jump if the cell is not type #N($0F), which is an obstacle.
@ $AA11 label=MoveLeft_Clear
  $AA11,$02 Discard the old X position...
  $AA13,$02 ...and jump to finish the move.
@ $AA15 label=MoveLeft_Blocked
  $AA15,$01 The entity is blocked, so restore the old X position.
  $AA16,$02 Clear the number of steps that are left...
  $AA18,$01 ...and set #REGa to #N$01.
  $AA19,$01 Return.

c $AA1A Move Up
@ $AA1A label=MoveUp
D $AA1A Moves an entity in direction one, which increases the Y position. See
. #R$A9C3 for how the move works.
R $AA1A B Number of steps to take
R $AA1A DE X position
R $AA1A HL Y position
R $AA1A O:A #N$01 if the entity has been blocked
R $AA1A O:B Number of steps that are left
R $AA1A O:HL New Y position
R $AA1A O:F The zero flag is reset if the entity has been blocked
  $AA1A,$03 Return if there are no steps left.
  $AA1D,$04 Jump if the entity is at the start of a cell.
  $AA21,$03 Add the steps to the fraction, and jump if that goes into the next
. cell.
  $AA24,$01 Store the new fraction.
@ $AA25 label=MoveUp_Finish
  $AA25,$03 Clear the number of steps that are left, and return with the zero
. flag set.
@ $AA28 label=MoveUp_NextCell
  $AA28,$01 Keep the steps that are left over.
  $AA29,$01 Fetch the Y cell...
  $AA2A,$01 ...and add one...
  $AA2B,$03 ...making sure that the cell is within the map.
  $AA2E,$02 Move to the start of the cell, and return with the zero flag set.
  $AA30,$01 Return.
@ $AA31 label=MoveUp_CellStart
  $AA31,$01 Add the steps to the fraction...
  $AA32,$01 ...and keep it.
  $AA33,$03 Keep this position.
  $AA36,$01 Save the Y position.
  $AA37,$01 Fetch the Y cell...
  $AA38,$01 ...and add one...
  $AA39,$03 ...making sure that the cell is within the map.
  $AA3C,$03 Find the cell using #R$BF97.
  $AA3F,$02 Jump if the cell is empty.
  $AA41,$01 Save the Y position.
  $AA42,$03 Fetch the address of the cell...
  $AA45,$01 ...and its contents...
  $AA46,$01 ...and restore the Y position.
  $AA47,$04 Jump if the cell has no type.
  $AA4B,$04 Jump if the cell is not type #N($0F), which is an obstacle.
@ $AA4F label=MoveUp_Clear
  $AA4F,$01 Restore the Y position...
  $AA50,$02 ...and jump to finish the move.
@ $AA52 label=MoveUp_Blocked
  $AA52,$01 The entity is blocked, so restore the old Y position.
  $AA53,$02 Clear the number of steps that are left...
  $AA55,$01 ...and the fraction...
  $AA56,$01 ...and set #REGa to #N$01.
  $AA57,$01 Return.

c $AA58 Move Right
@ $AA58 label=MoveRight
D $AA58 Moves an entity in direction two, which increases the X position. See
. #R$A9C3 for how the move works.
R $AA58 B Number of steps to take
R $AA58 DE X position
R $AA58 HL Y position
R $AA58 O:A #N$01 if the entity has been blocked
R $AA58 O:B Number of steps that are left
R $AA58 O:DE New X position
R $AA58 O:F The zero flag is reset if the entity has been blocked
  $AA58,$03 Return if there are no steps left.
  $AA5B,$04 Jump if the entity is at the start of a cell.
  $AA5F,$03 Add the steps to the fraction, and jump if that goes into the next
. cell.
  $AA62,$01 Store the new fraction.
@ $AA63 label=MoveRight_Finish
  $AA63,$03 Clear the number of steps that are left, and return with the zero
. flag set.
@ $AA66 label=MoveRight_NextCell
  $AA66,$01 Keep the steps that are left over.
  $AA67,$01 Fetch the X cell...
  $AA68,$01 ...and add one...
  $AA69,$03 ...making sure that the cell is within the map.
  $AA6C,$02 Move to the start of the cell, and return with the zero flag set.
  $AA6E,$01 Return.
@ $AA6F label=MoveRight_CellStart
  $AA6F,$01 Add the steps to the fraction...
  $AA70,$01 ...and keep it.
  $AA71,$04 Keep this position.
  $AA75,$01 Save the X position.
  $AA76,$01 Fetch the X cell...
  $AA77,$01 ...and add one...
  $AA78,$03 ...making sure that the cell is within the map.
  $AA7B,$03 Find the cell using #R$BF97.
  $AA7E,$02 Jump if the cell is empty.
  $AA80,$01 Save the Y position.
  $AA81,$03 Fetch the address of the cell...
  $AA84,$01 ...and its contents...
  $AA85,$01 ...and restore the Y position.
  $AA86,$04 Jump if the cell has no type.
  $AA8A,$04 Jump if the cell is not type #N($0F), which is an obstacle.
@ $AA8E label=MoveRight_Clear
  $AA8E,$01 Restore the X position...
  $AA8F,$02 ...and jump to finish the move.
@ $AA91 label=MoveRight_Blocked
  $AA91,$01 The entity is blocked, so restore the old X position.
  $AA92,$02 Clear the number of steps that are left...
  $AA94,$01 ...and the fraction...
  $AA95,$01 ...and set #REGa to #N$01.
  $AA96,$01 Return.

c $AA97 Move Down
@ $AA97 label=MoveDown
D $AA97 Moves an entity in direction three, which decreases the Y position. See
. #R$A9C3 for how the move works.
R $AA97 B Number of steps to take
R $AA97 DE X position
R $AA97 HL Y position
R $AA97 O:A #N$01 if the entity has been blocked
R $AA97 O:B Number of steps that are left
R $AA97 O:HL New Y position
R $AA97 O:F The zero flag is reset if the entity has been blocked
  $AA97,$03 Return if there are no steps left.
  $AA9A,$04 Jump if the entity is at the start of a cell.
  $AA9E,$03 Take the steps off the fraction, and jump if that goes back into the
. previous cell.
  $AAA1,$01 Store the new fraction.
@ $AAA2 label=MoveDown_Finish
  $AAA2,$03 Clear the number of steps that are left, and return with the zero
. flag set.
@ $AAA5 label=MoveDown_NextCell
  $AAA5,$02 Work out how many steps are left over...
  $AAA7,$01 ...and keep them in #REGb.
  $AAA8,$02 Move to the start of the cell, and return with the zero flag set.
  $AAAA,$01 Return.
@ $AAAB label=MoveDown_CellStart
  $AAAB,$01 Save the Y position.
  $AAAC,$01 Take the steps off the fraction, which goes back into the previous
. cell...
  $AAAD,$01 ...and keep it.
  $AAAE,$01 Fetch the Y cell...
  $AAAF,$02 ...and take one off...
  $AAB1,$03 ...making sure that the cell is within the map.
  $AAB4,$03 Keep this position.
  $AAB7,$03 Find the cell using #R$BF97.
  $AABA,$02 Jump if the cell is empty.
  $AABC,$01 Save the Y position.
  $AABD,$03 Fetch the address of the cell...
  $AAC0,$01 ...and its contents...
  $AAC1,$01 ...and restore the Y position.
  $AAC2,$04 Jump if the cell has no type.
  $AAC6,$04 Jump if the cell is not type #N($0F), which is an obstacle.
@ $AACA label=MoveDown_Clear
  $AACA,$02 Discard the old Y position...
  $AACC,$02 ...and jump to finish the move.
@ $AACE label=MoveDown_Blocked
  $AACE,$01 The entity is blocked, so restore the old Y position.
  $AACF,$02 Clear the number of steps that are left...
  $AAD1,$01 ...and set #REGa to #N$01.
  $AAD2,$01 Return.

c $AAD3 Turn Robot Left
@ $AAD3 label=TurnRobotLeft
D $AAD3 Turns the robot a quarter of a turn, so that its direction goes down by
. one. The robot is moved to the start of the cell, and it gets one of the types
. for turning (#N$20 to #N$2F).
R $AAD3 A Controls
R $AAD3 IX Robot
  $AAD3,$02 Clear the bit of the controls for turning left...
  $AAD5,$03 ...and store them.
  $AAD8,$03 Fetch the type of the robot.
  $AADB,$04 Go back by one direction...
  $AADF,$02 ...keep the bits that are used for the sprite and mark it as
. turning.
@ $AAE1 label=TurnRobot_Store
  $AAE1,$03 Store the type of the robot.
  $AAE4,$04 Move the robot to the start of the cell in the X direction...
  $AAE8,$04 ...and in the Y direction.
  $AAEC,$01 Return.

c $AAED Turn Robot Right
@ $AAED label=TurnRobotRight
D $AAED Turns the robot a quarter of a turn, so that its direction goes up by
. one. The robot is moved to the start of the cell, and it gets one of the types
. for turning (#N$20 to #N$2F).
R $AAED A Controls
R $AAED IX Robot
  $AAED,$02 Clear the bit of the controls for turning right...
  $AAEF,$03 ...and store them.
  $AAF2,$03 Fetch the type of the robot.
  $AAF5,$04 Go forward by one direction...
  $AAF9,$02 ...keep the bits that are used for the sprite and mark it as
. turning.
  $AAFB,$02 Jump to store the type and finish.

c $AAFD Move Robot Vertically
@ $AAFD label=MoveRobotVertically
D $AAFD The handler for entity types #N$14 to #N$17 and #N$1C to #N($1F), which
. are the robot when it is heading in direction one or three (up and down the
. map).
R $AAFD IX Robot
  $AAFD,$04 Show the sprite without flipping it.
  $AB01,$02 Jump to move the robot.

c $AB03 Move Robot Horizontally
@ $AB03 label=MoveRobotHorizontally
D $AB03 The handler for entity types #N$10 to #N$13 and #N$18 to #N($1B), which
. are the robot when it is heading in direction zero or two (across the map).
R $AB03 IX Robot
  $AB03,$04 Show the sprite flipped.
N $AB07 This entry point is shared by both handlers. It does all of the work for
. the robot in a frame: it looks at the action key, shows the robot on the map,
. works out how far to move, moves the robot, checks whether it has hit an enemy
. and fires the weapons.
@ $AB07 label=UpdateRobot
  $AB07,$03 Deal with the action key using #R$AC7E.
  $AB0A,$03 Update the position of the robot on the map of the sectors using
. #R$AE67.
  $AB0D,$03 Find how far the robot can move using #R$A8E4.
  $AB10,$03 Fetch the speed of the robot...
  $AB13,$05 ...and move on to the next sprite using #R$B063 if the robot is
. moving fast enough.
  $AB18,$03 Move the robot using #R$AB57.
  $AB1B,$03 Fetch the type of the robot...
  $AB1E,$01 ...and keep it in #REGa'.
  $AB1F,$03 Check whether the robot has hit an enemy using #R$A5A7.
  $AB22,$03 Fetch the type of the robot again.
  $AB25,$04 Jump if it has not been turned into smoke.
  $AB29,$03 Fetch the number of sectors that have been dealt with.
  $AB2C,$02 Add #N$1A to get the energy that the collision costs...
  $AB2E,$01 ...and keep it in #REGb.
  $AB2F,$03 Fetch the energy of the battery.
  $AB32,$01 Take off the cost.
  $AB33,$02 Jump if there is not enough energy.
  $AB35,$01 Otherwise get the type that the robot had...
  $AB36,$03 ...and restore it, so that it is not destroyed...
  $AB39,$01 Switch back to the energy.
  $AB3A,$02 ...and jump to store the energy.
@ $AB3C label=MoveRobotHorizontally_NoEnergy
  $AB3C,$03 The battery is empty, so turn all of the enemies into smoke using
. #R$A727.
  $AB3F,$01 Set the energy to zero.
@ $AB40 label=UpdateRobot_Store
  $AB40,$03 Store the energy of the battery.
@ $AB43 label=MoveRobotHorizontally_ReadControls
  $AB43,$03 Fetch the controls.
  $AB46,$04 Jump if the second weapon is not being fired.
  $AB4A,$03 Fire the second weapon using #R$A656.
  $AB4D,$02 Jump to draw the robot.
@ $AB4F label=MoveRobotHorizontally_FirstWeapon
  $AB4F,$05 Fire the first weapon using #R$A626 if it is being fired.
@ $AB54 label=UpdateRobot_Draw
  $AB54,$03 Draw the robot using #R$BDCD.

c $AB57 Move Robot
@ $AB57 label=MoveRobot
D $AB57 Moves the robot in the direction that it is heading, by the number of
. steps that is in #REGb. The robot can only turn when it is at the start of a
. cell: if a turn key is being pressed then the robot turns and carries on in
. the new direction. When the robot is blocked by something in the map then
. #R$AC30 deals with it.
R $AB57 B Number of steps to take
R $AB57 IX Robot
  $AB57,$03 Fetch the position of the robot.
  $AB5A,$04 Keep the X position...
  $AB5E,$03 ...and the Y position, so that the move can be undone.
  $AB61,$03 Fetch the type of the robot...
  $AB64,$02 ...and turn it into the direction that it is heading in.
  $AB66,$05 Jump to move in direction zero (X decreasing)...
  $AB6B,$04 ...or direction one (Y increasing)...
  $AB6F,$04 ...or direction two (X increasing)...
N $AB73 Direction three (Y decreasing). The four sections that follow all work
. in the same way. When the robot is at the start of a cell, and a key to turn
. is being pressed, the robot is turned and the routine carries on with the
. section for the new direction. Otherwise the robot moves, and if it was
. blocked then #R$AC30 is called to deal with the obstacle. This is repeated
. until there are no more steps.
@ $AB73 label=MoveRobot_Down
  $AB73,$04 Jump if the robot is not at the start of a cell.
  $AB77,$03 Fetch the controls.
  $AB7A,$04 Jump if the key to turn left is pressed.
  $AB7E,$04 Jump if the key to turn right is pressed.
@ $AB82 label=MoveRobot_DownStep
  $AB82,$03 Move the robot down using #R$AA97.
  $AB85,$03 Deal with the obstacle using #R$AC30 if it was blocked.
  $AB88,$04 Loop back if there are steps left.
  $AB8C,$03 Jump to #R$AC1A.
@ $AB8F label=MoveRobot_Down_TurnLeft
  $AB8F,$03 Turn the robot left using #R$AAD3...
  $AB92,$04 ...and show the sprite without flipping it.
  $AB96,$02 Jump to carry on heading right.
@ $AB98 label=MoveRobot_Down_TurnRight
  $AB98,$03 Turn the robot right using #R$AAED...
  $AB9B,$04 ...and show the sprite flipped.
  $AB9F,$02 Jump to carry on heading left.
@ $ABA1 label=MoveRobot_Right
  $ABA1,$04 Jump if the robot is not at the start of a cell.
  $ABA5,$03 Fetch the controls.
  $ABA8,$04 Jump if the key to turn left is pressed.
  $ABAC,$04 Jump if the key to turn right is pressed.
@ $ABB0 label=MoveRobot_RightStep
  $ABB0,$03 Move the robot right using #R$AA58.
  $ABB3,$03 Deal with the obstacle using #R$AC30 if it was blocked.
  $ABB6,$04 Loop back if there are steps left.
  $ABBA,$04 Show the sprite flipped.
  $ABBE,$03 Jump to #R$AC1A.
@ $ABC1 label=MoveRobot_Right_TurnLeft
  $ABC1,$03 Turn the robot left using #R$AAD3...
  $ABC4,$04 ...and show the sprite flipped.
  $ABC8,$02 Jump to carry on heading up.
@ $ABCA label=MoveRobot_Right_TurnRight
  $ABCA,$03 Turn the robot right using #R$AAED...
  $ABCD,$04 ...and show the sprite flipped.
  $ABD1,$02 Jump to carry on heading down.
@ $ABD3 label=MoveRobot_Up
  $ABD3,$04 Jump if the robot is not at the start of a cell.
  $ABD7,$03 Fetch the controls.
  $ABDA,$04 Jump if the key to turn left is pressed.
  $ABDE,$04 Jump if the key to turn right is pressed.
@ $ABE2 label=MoveRobot_UpStep
  $ABE2,$03 Move the robot up using #R$AA1A.
  $ABE5,$03 Deal with the obstacle using #R$AC30 if it was blocked.
  $ABE8,$04 Loop back if there are steps left.
  $ABEC,$03 Jump to #R$AC1A.
@ $ABEF label=MoveRobot_Up_TurnLeft
  $ABEF,$03 Turn the robot left using #R$AAD3...
  $ABF2,$04 ...and show the sprite without flipping it.
  $ABF6,$02 Jump to carry on heading left.
@ $ABF8 label=MoveRobot_Up_TurnRight
  $ABF8,$03 Turn the robot right using #R$AAED...
  $ABFB,$04 ...and show the sprite flipped.
  $ABFF,$02 Jump to carry on heading right.
@ $AC01 label=MoveRobot_Left
  $AC01,$04 Jump if the robot is not at the start of a cell.
  $AC05,$03 Fetch the controls.
  $AC08,$04 Jump if the key to turn left is pressed.
  $AC0C,$04 Jump if the key to turn right is pressed.
@ $AC10 label=MoveRobot_LeftStep
  $AC10,$03 Move the robot left using #R$A9DD.
  $AC13,$03 Deal with the obstacle using #R$AC30 if it was blocked.
  $AC16,$04 Loop back if there are steps left.
@ $AC1A label=MoveRobot_Store
  $AC1A,$03 Jump to #R$AEE0.
@ $AC1D label=MoveRobot_Left_TurnLeft
  $AC1D,$03 Turn the robot left using #R$AAD3...
  $AC20,$04 ...and show the sprite without flipping it.
  $AC24,$03 Jump to carry on heading down.
@ $AC27 label=MoveRobot_Left_TurnRight
  $AC27,$03 Turn the robot right using #R$AAED...
  $AC2A,$04 ...and show the sprite without flipping it.
  $AC2E,$02 Jump to carry on heading up.

c $AC30 Handle Obstacle
@ $AC30 label=HandleObstacle
D $AC30 Deals with the cell that has blocked the robot. If it is a battery then
. the cell is emptied and the battery is refilled; otherwise a beep is made.
R $AC30 IX Robot
  $AC30,$01 Save the Y position.
  $AC31,$03 Fetch the address of the cell...
  $AC34,$01 ...and its contents...
  $AC35,$02 ...and keep the type.
  $AC37,$04 Jump if the cell is not a battery (type #N$03).
  $AC3B,$01 Fetch the contents of the cell...
  $AC3C,$03 ...and clear the type, so that the battery is gone...
  $AC3F,$03 Make a sound using #R$C048.
  $AC42,$05 Fill up the battery.
  $AC47,$01 Save #REGbc...
  $AC48,$01 ...and #REGde.
  $AC49,$05 Flash the panel in bright yellow using #R$9EEB.
  $AC4E,$01 Restore #REGde...
  $AC4F,$01 ...and #REGbc.
@ $AC50 label=HandleObstacle_Return
  $AC50,$01 Restore the Y position.
  $AC51,$01 Return.
@ $AC52 label=HandleObstacle_NotBattery
  $AC52,$04 Jump if the cell is type #N($0F), to undo the move.
  $AC56,$03 Make a beep using #R$C027.
  $AC59,$02 Jump to return.
@ $AC5B label=HandleObstacle_Undo
  $AC5B,$01 Discard the saved Y position.
  $AC5C,$03 Restore the Y position...
  $AC5F,$04 ...and the X position from before the move.
  $AC63,$01 Return.

c $AC64 Use Action Key
@ $AC64 label=UseActionKey_Up
D $AC64 Handles the action key, which picks up a program from the cell that is
. in front of the robot, drops a program into it, or installs a program in a
. socket (a cell of type #N$0F). It only works when the robot is at the start of
. a cell, and the key has to be released between presses. The programs that the
. robot carries are kept in a queue, which is handled by #R$AD34.
N $AC64 The first part of the code works out the position of the cell in front
. of the robot. These entry points are used when the robot is heading up, right
. and left.
  $AC64,$05 Move up one cell, keeping the Y cell within the map.
  $AC69,$02 Jump to use the cell.
@ $AC6B label=UseActionKey_Right
  $AC6B,$05 Move right one cell, keeping the X cell within the map.
  $AC70,$02 Jump to use the cell.
@ $AC72 label=UseActionKey_Left
  $AC72,$05 Move left one cell, keeping the X cell within the map.
  $AC77,$02 Jump to use the cell.
@ $AC79 label=UseActionKey_Release
  $AC79,$04 Clear the flag that says that the action key has been used.
  $AC7D,$01 Return.
N $AC7E This is the entry point of the routine.
@ $AC7E label=UseActionKey
  $AC7E,$03 Fetch the position of the robot.
  $AC81,$03 Return if the robot is not at the start of a cell.
  $AC84,$07 Jump to clear the flag if the action key is not being pressed.
  $AC8B,$05 Return if the action key has been used already.
  $AC90,$05 Set the flag that says that the action key has been used.
  $AC95,$08 Start effect #N$00 (four tones) for #R$BFDA.
  $AC9D,$03 Fetch the type of the robot...
  $ACA0,$02 ...and turn it into the direction that it is heading in.
  $ACA2,$04 Jump if the robot is heading in direction zero (X decreasing).
  $ACA6,$03 Jump if the robot is heading in direction one (Y increasing).
  $ACA9,$03 Jump if the robot is heading in direction two (X increasing).
  $ACAC,$05 Otherwise move down one cell, keeping the Y cell within the map.
@ $ACB1 label=UseActionKey_Cell
  $ACB1,$04 Keep the X position of the cell...
  $ACB5,$03 ...and the Y position.
  $ACB8,$03 Find the cell using #R$BF97.
  $ACBB,$03 Fetch the address of the cell.
  $ACBE,$02 Jump if the cell is empty.
  $ACC0,$01 Fetch the contents of the cell...
  $ACC1,$02 ...and keep the type.
  $ACC3,$04 Jump if the cell is a program (type #N$06).
  $ACC7,$03 Return if the cell is not a socket (type #N$0F).
  $ACCA,$01 Use zero, as there is no program to pick up.
@ $ACCB label=UseActionKey_Queue
  $ACCB,$03 Add the program, or zero, to the queue using #R$AD34.
  $ACCE,$03 Jump if a program was pushed out of the queue.
  $ACD1,$01 Fetch the contents of the cell...
  $ACD2,$01 ...and keep them.
  $ACD3,$02 Keep the type.
  $ACD5,$03 Return if the cell is a socket.
  $ACD8,$01 Fetch the contents of the cell...
  $ACD9,$02 ...clear the type, so that the program has gone...
  $ACDB,$01 ...and store it.
  $ACDC,$01 Return.
@ $ACDD label=UseActionKey_Drop
  $ACDD,$01 Fetch the contents of the cell.
  $ACDE,$02 Keep the type.
  $ACE0,$02 Test whether it is a socket.
  $ACE2,$02 Use type #N($06), so that the program is dropped on the floor...
  $ACE4,$02 ...unless the cell is a socket.
  $ACE6,$01 Save the address of the cell.
  $ACE7,$03 Find the sector that the robot is in using #R$9C5E.
  $ACEA,$01 Put the sector number in #REGe...
  $ACEB,$02 ...and clear #REGd.
  $ACED,$03 Point #REGhl at #R$A361.
  $ACF0,$01 Add the sector number.
  $ACF1,$01 Fetch the energy of the sector.
  $ACF2,$03 Jump if there is none.
  $ACF5,$03 Point #REGhl at #R$965B.
  $ACF8,$01 Add the sector number.
  $ACF9,$01 Fetch the flag of the sector.
  $ACFA,$03 Jump to install the program if the sector has not been activated.
@ $ACFD label=UseActionKey_Refuse
  $ACFD,$01 Restore the address of the cell.
  $ACFE,$04 Point #REGiy at the first of the two entities that are used for
. clouds.
  $AD02,$03 Each entity is #N$10 bytes long.
  $AD05,$03 Fetch the type of the entity.
  $AD08,$03 Jump if it is not in use.
  $AD0B,$02 Move on to the second entity.
  $AD0D,$03 Fetch the type of the entity.
  $AD10,$02 Return if it is in use as well.
@ $AD12 label=UseActionKey_Up_StartSmoke
  $AD12,$04 Start a cloud of smoke in the entity (type #N$54).
  $AD16,$03 Fetch the X cell where the program was refused...
  $AD19,$03 ...and use it for the cloud.
  $AD1C,$03 Fetch the Y cell...
  $AD1F,$03 ...and use it for the cloud.
  $AD22,$01 Return.
@ $AD23 label=UseActionKey_Install
  $AD23,$01 Restore the address of the cell...
  $AD24,$01 ...and save it again.
  $AD25,$01 Save the sector number.
  $AD26,$03 Add the program to the sector using #R$ADB2.
  $AD29,$01 Restore the sector number...
  $AD2A,$01 ...and the address of the cell.
  $AD2B,$02 Use type #N($02), which is an installed program.
@ $AD2D label=UseActionKey_Store
  $AD2D,$01 Keep the new type of the cell.
  $AD2E,$01 Fetch the contents of the cell...
  $AD2F,$02 ...keep the initial type...
  $AD31,$01 ...and combine it with the new type.
  $AD32,$01 Store the contents of the cell.
  $AD33,$01 Return.

c $AD34 Queue Program
@ $AD34 label=QueueProgram
D $AD34 Adds a program to the queue of programs that the robot is carrying (or
. adds a blank, if the robot is not picking one up), and then draws the four
. icons of the queue in the panel. The queue holds five entries, and the oldest
. one is pushed out of the end.
R $AD34 A Program to add (#N$06), or #N$00 for a blank
R $AD34 O:A The entry that was pushed out of the queue (#N$00 if it was blank)
  $AD34,$03 Save the registers.
  $AD37,$03 Point #REGde at the end of the queue...
  $AD3A,$03 ...and #REGhl at the entry before it.
  $AD3D,$03 There are four entries to move along.
  $AD40,$02 Move the entries along.
  $AD42,$02 Put the new entry at the start of the queue.
  $AD44,$03 Point #REGhl at the screen address of the first icon.
  $AD47,$03 Point #REGde at #R$9641.
  $AD4A,$02 There are two rows of icons...
@ $AD4C label=QueueProgram_Row
  $AD4C,$02 ...with two icons in each.
@ $AD4E label=QueueProgram_Icon
  $AD4E,$03 Clear the area of the screen for the icon using #R$AD87.
  $AD51,$01 Fetch the entry of the queue.
  $AD52,$03 Jump if it is blank.
  $AD55,$01 Save the address in the queue...
  $AD56,$01 ...and the screen address.
  $AD57,$01 Take one off the type...
  $AD58,$02 ...and keep it within the range of cell types.
  $AD5A,$04 Multiply it by sixteen, which is the size of an entry in the table
. of cell templates.
  $AD5E,$03 Point #REGhl at #R$97C0.
  $AD61,$03 Add the offset of the entry.
  $AD64,$01 Fetch the number of the sprite for the cell.
  $AD65,$03 Point #REGhl at #R$60A3.
  $AD68,$01 Double the number of the sprite...
  $AD69,$03 ...and add it to find the address of the sprite.
  $AD6C,$01 Fetch the low byte of the address of the sprite...
  $AD6D,$01 ...move on...
  $AD6E,$01 ...and fetch the high byte.
  $AD6F,$01 Move on to the byte after the height of the sprite.
  $AD70,$01 Restore the screen address.
  $AD71,$01 Save the counters.
  $AD72,$03 Draw the icon using #R$A0CB.
  $AD75,$01 Restore the counters.
  $AD76,$01 Restore the address in the queue.
@ $AD77 label=QueueProgram_Next
  $AD77,$01 Move on to the next entry.
  $AD78,$02 Loop back until both icons of the row have been drawn.
  $AD7A,$03 Point #REGhl at the screen address of the second row.
  $AD7D,$03 Loop back until both rows have been drawn.
  $AD80,$03 Restore the registers.
  $AD83,$03 Return the entry that was pushed out of the queue.
  $AD86,$01 Return.

c $AD87 Clear Icon Area
@ $AD87 label=ClearIconArea
D $AD87 Clears an area of the screen that is four characters wide and thirty-two
. lines high, working upwards from the address that is given.
R $AD87 HL Screen address of the bottom left
  $AD87,$03 Save the registers.
  $AD8A,$02 There are #N$20 lines to clear.
@ $AD8C label=ClearIconArea_Line
  $AD8C,$02 There are four bytes in a line.
  $AD8E,$01 Clear a byte...
@ $AD8F label=ClearIconArea_Byte
  $AD8F,$01 ...on the screen.
  $AD90,$01 Move on to the next byte.
  $AD91,$02 Loop back until the line has been cleared.
  $AD93,$04 Go back to the start of the line.
  $AD97,$01 Fetch the high byte of the address...
  $AD98,$01 ...and move up one line.
  $AD99,$04 Jump if that has not moved into the character above.
  $AD9D,$01 Otherwise fetch the high byte again, as it has moved up a row of
. characters...
  $AD9E,$02 ...add eight to it...
  $ADA0,$01 ...and store it.
  $ADA1,$01 Fetch the low byte...
  $ADA2,$02 ...take one row of characters off it...
  $ADA4,$01 ...and store it.
@ $ADA5 label=ClearIconArea_Next
  $ADA5,$03 Loop back until all of the lines have been cleared.
  $ADA8,$03 Restore the registers.
  $ADAB,$01 Return.

c $ADAC Skip Blank Icon
@ $ADAC label=SkipBlankIcon
D $ADAC Moves on to the screen address of the next icon when an entry of the
. queue is blank. This is part of #R$AD34, which it rejoins.
R $ADAC HL Screen address of the icon
R $ADAC O:HL Screen address of the next icon
  $ADAC,$01 Fetch the low byte of the screen address...
  $ADAD,$02 ...add four to it, to move four characters to the right...
  $ADAF,$01 ...and store it.
  $ADB0,$02 Jump to move on to the next entry of the queue.

c $ADB2 Install Program
@ $ADB2 label=InstallProgram
D $ADB2 Adds a program to the sector that the robot is in, which gives the
. sector one more unit of energy, and awards #N$0100 points to the score.
R $ADB2 IX Robot
  $ADB2,$03 Find the energy of the sector using #R$A320.
  $ADB5,$01 Add one to it.
  $ADB6,$01 Save #REGbc.
  $ADB7,$03 Use #N$0100 as the number of points...
  $ADBA,$03 ...and add them to the score using #R$B573.
  $ADBD,$01 Restore #REGbc.
  $ADBE,$01 Return.

g $ADBF Action Cell Position
@ $ADBF label=ActionCellPosition
D $ADBF The position of the cell that the action key was used on. The first word
. is the X position and the second is the Y position, each as a fraction byte
. followed by a cell number.
W $ADBF,$04,$02

c $ADC3 Set Attacked Sector
@ $ADC3 label=SetAttackedSector
D $ADC3 Changes the sector that is shown as being under attack, and then draws
. the map of the sectors. The code of a sector has the row in bits 6 and 7 and
. the column in bits 1 and 2; a row or column of #N$03 means that there is no
. sector. The flag that says the old sector is under attack is cleared.
R $ADC3 C Code of the sector that is now under attack
  $ADC3,$03 Point #REGhl at the code of the sector that is under attack.
  $ADC6,$01 Fetch the old code...
  $ADC7,$01 ...and store the new one.
  $ADC8,$03 Jump to draw the map if the code has not changed.
  $ADCB,$01 Keep the old code.
  $ADCC,$02 Keep the column of the old sector...
  $ADCE,$04 Jump to draw the map if the old code was not a sector.
  $ADD2,$01 Halve the column...
  $ADD3,$01 ...and keep it in #REGd.
  $ADD4,$01 Fetch the old code again...
  $ADD5,$02 ...and move the row into the low bits.
  $ADD7,$02 Keep the row.
  $ADD9,$04 Jump to draw the map if the old code was not a sector.
  $ADDD,$01 Keep the row.
  $ADDE,$01 Double the row...
  $ADDF,$01 ...add the row again, to multiply it by three...
  $ADE0,$01 ...add the column...
  $ADE1,$01 ...and keep the number of the old sector in #REGe.
  $ADE2,$02 Clear the high byte of the sector number.
  $ADE4,$03 Point #REGhl at #R$967E.
  $ADE7,$01 Add the number of the sector.
  $ADE8,$02 Clear the flag that says that the sector is under attack.

c $ADEA Draw Sector Map
@ $ADEA label=DrawSectorMap
D $ADEA Colours the map of the sectors that is shown in the panel. Each of the
. nine sectors is a block of two by two attributes, and its colour depends on
. the state of the sector.
  $ADEA,$03 Point #REGhl at the table of sector states.
  $ADED,$02 There are nine sectors.
@ $ADEF label=DrawSectorMap_Next
  $ADEF,$01 Fetch the state of the sector...
  $ADF0,$02 ...and clear #REGd.
  $ADF2,$01 Save the address of the state.
  $ADF3,$03 Point #REGhl at #R$AE25.
  $ADF6,$01 Add the state.
  $ADF7,$01 Fetch the attribute.
  $ADF8,$01 Save the counter.
  $ADF9,$01 Fetch the counter into #REGc...
  $ADFA,$01 ...and take one off.
  $ADFB,$02 Clear the high byte of the counter.
  $ADFD,$03 Point #REGhl at #R$AE1C.
  $AE00,$01 Add the number of the sector.
  $AE01,$01 Fetch the offset into #REGc.
  $AE02,$02 Use #N$0100 as the high byte of the offset.
  $AE04,$03 Colour the sector using #R$AE0D.
  $AE07,$01 Restore the counter...
  $AE08,$01 ...and the address of the state.
  $AE09,$01 Move on to the next state.
  $AE0A,$02 Loop back until all nine sectors have been drawn.
  $AE0C,$01 Return.

c $AE0D Colour Sector Square
@ $AE0D label=ColourSectorSquare
D $AE0D Sets the attributes of a block of two by two characters.
R $AE0D A Attribute
R $AE0D BC Offset from #N$5800
  $AE0D,$03 Point #REGhl at the attribute file...
  $AE10,$01 ...and add the offset.
  $AE11,$01 Colour the top left character...
  $AE12,$01 ...move to the right...
  $AE13,$01 ...and colour the top right character.
  $AE14,$03 Use an offset of #N$001F...
  $AE17,$01 ...to move to the character on the left of the next row.
  $AE18,$01 Colour the bottom left character...
  $AE19,$01 ...move to the right...
  $AE1A,$01 ...and colour the bottom right character.
  $AE1B,$01 Return.

b $AE1C Sector Map Offsets
@ $AE1C label=SectorMapOffsets
D $AE1C The offsets from #N$5900 of the attributes of the top left character of
. each of the nine sectors on the map, in the order of the sector numbers.
B $AE1C,$09,$03

b $AE25 Sector State Attributes
@ $AE25 label=SectorStateAttributes
D $AE25 The attributes that are used to show a sector, indexed by its state. The
. states with bit 2 set are flashing, which shows that the sector is under
. attack.
B $AE25,$01 #COLOUR(#PEEK(#PC)).
L $AE25,$01,$08

c $AE2D Update Packet Marker
@ $AE2D label=UpdatePacketMarker
D $AE2D Shows the position of the program packet on the map of the sectors. The
. marker is drawn with XOR, so the old marker is removed by drawing it again.
. Nothing is done if the packet has not moved.
  $AE2D,$03 Fetch the X cell where the marker was drawn last...
  $AE30,$01 ...and keep it in #REGd.
  $AE31,$03 Fetch the Y cell...
  $AE34,$01 ...and keep it in #REGh.
  $AE35,$03 Fetch the flag that says whether there was a marker.
  $AE38,$03 Jump if there was not.
  $AE3B,$03 Fetch the type of the packet.
  $AE3E,$03 Jump to remove the old marker if there is no packet now.
  $AE41,$03 Fetch the X cell of the packet.
  $AE44,$03 Jump to remove the old marker if the packet has moved in the X
. direction.
  $AE47,$03 Fetch the Y cell of the packet.
  $AE4A,$02 Return if the packet has not moved.
@ $AE4C label=UpdatePacketMarker_Remove
  $AE4C,$03 Remove the old marker using #R$AE93.
@ $AE4F label=UpdatePacketMarker_Draw
  $AE4F,$03 Fetch the X cell of the packet...
  $AE52,$03 ...and store it...
  $AE55,$01 ...and keep it in #REGd.
  $AE56,$03 Fetch the Y cell of the packet...
  $AE59,$03 ...and store it...
  $AE5C,$01 ...and keep it in #REGh.
  $AE5D,$03 Fetch the type of the packet.
  $AE60,$04 Store the flag that says whether there is a marker...
  $AE64,$01 ...and return if there is not.
  $AE65,$02 Jump to #R$AE93.

c $AE67 Update Robot Marker
@ $AE67 label=UpdateRobotMarker
D $AE67 Shows the position of the robot on the map of the sectors. The marker is
. drawn with XOR, so the old marker is removed by drawing it again. Nothing is
. done if the robot has not moved to a different cell.
  $AE67,$04 Fetch the X position of the robot...
  $AE6B,$03 ...and the Y position.
  $AE6E,$03 Fetch the X cell where the marker was drawn last.
  $AE71,$03 Jump if the robot is in a different X cell.
  $AE74,$03 Fetch the Y cell where the marker was drawn last.
  $AE77,$02 Return if the robot has not moved to a different cell.
@ $AE79 label=UpdateRobotMarker_NewCell
  $AE79,$01 Save the X position...
  $AE7A,$01 ...and the Y position.
  $AE7B,$03 Draw the marker at the new position using #R$AE93.
  $AE7E,$01 Restore the Y position.
  $AE7F,$04 Fetch the old Y position...
  $AE83,$03 ...and store the new one.
  $AE86,$01 Put the old one in #REGhl.
  $AE87,$01 Restore the new X position...
  $AE88,$04 ...fetch the old one...
  $AE8C,$04 ...and store the new one.
  $AE90,$01 Combine the cells of the old position...
  $AE91,$02 ...and return if there was no marker.
N $AE93 This entry point draws, or removes, a marker.
@ $AE93 label=ToggleMarker
D $AE67 Draws a marker of three pixels by three on the map of the sectors, using
. XOR. Each cell of the map is one pixel on the screen.
R $AE67 D X cell
R $AE67 H Y cell
  $AE93,$01 Fetch the X cell...
  $AE94,$04 ...and find the X coordinate of the marker, which is #N$BE plus the
. cell.
  $AE98,$01 Keep the X coordinate of the marker.
  $AE99,$02 Use the lowest three bits...
  $AE9B,$01 ...to find the pre-shifted data...
  $AE9C,$02 ...in the table of shifted bytes.
  $AE9E,$01 Keep the shifted graphic.
  $AE9F,$01 Fetch the Y cell...
  $AEA0,$02 Turn the Y cell upside down...
  $AEA2,$02 ...and find the Y coordinate of the marker.
  $AEA4,$01 Keep the Y coordinate of the marker.
  $AEA5,$03 Find the screen address using #R$BD4B.
  $AEA8,$02 There are three rows to draw.
  $AEAA,$03 Point #REGde at #R$AED0.
@ $AEAD label=ToggleMarker_Row
  $AEAD,$01 Save the counter.
  $AEAE,$01 Fetch the pattern for the row...
  $AEAF,$01 ...to use as the offset into the shifted data.
  $AEB0,$01 Fetch the shifted byte...
  $AEB1,$01 ...combine it with the screen...
  $AEB2,$01 ...and write it back.
  $AEB3,$01 Move on to the next byte of the screen.
  $AEB4,$01 Move on to the second table of shifted bytes.
  $AEB5,$01 Fetch the byte that has spilled over...
  $AEB6,$01 ...combine it with the screen...
  $AEB7,$01 ...and write it back.
  $AEB8,$01 Go back to the first table...
  $AEB9,$01 ...and the first byte of the screen.
  $AEBA,$01 Fetch the high byte of the screen address...
  $AEBB,$01 ...and move up one line.
  $AEBC,$04 Jump if that has not moved into the character above.
  $AEC0,$01 Fetch the low byte of the screen address...
  $AEC1,$02 ...take one row of characters off it...
  $AEC3,$01 ...and store it.
  $AEC4,$02 Jump if there is no row of characters above, in this third of the
. screen...
  $AEC6,$01 Otherwise fetch the high byte...
  $AEC7,$02 ...add eight to it...
  $AEC9,$01 ...and store it.
@ $AECA label=ToggleMarker_Next
  $AECA,$01 Restore the counter.
  $AECB,$01 Move on to the next pattern.
  $AECC,$01 Count down the rows.
  $AECD,$02 Loop back until all three rows have been drawn.
  $AECF,$01 Return.

b $AED0 Marker Pattern
@ $AED0 label=MarkerPattern
D $AED0 The three rows of the marker, which is a plus shape. They are used as
. offsets into the pre-shifted data.
B $AED0,$03,$03

c $AED3 Get Position
@ $AED3 label=GetPosition
D $AED3 Fetches the position of an entity.
R $AED3 IX Entity
R $AED3 O:DE X position (the fraction in #REGe and the cell in #REGd)
R $AED3 O:HL Y position (the fraction in #REGl and the cell in #REGh)
  $AED3,$03 Fetch the X fraction...
  $AED6,$03 ...and the X cell.
  $AED9,$03 Fetch the Y fraction...
  $AEDC,$03 ...and the Y cell.
  $AEDF,$01 Return.

c $AEE0 Set Position
@ $AEE0 label=SetPosition
D $AEE0 Stores the position of an entity.
R $AEE0 DE X position
R $AEE0 HL Y position
R $AEE0 IX Entity
  $AEE0,$03 Store the X fraction...
  $AEE3,$03 ...and the X cell.
  $AEE6,$03 Store the Y fraction...
  $AEE9,$03 ...and the Y cell.
  $AEEC,$01 Return.

c $AEED Start Light
@ $AEED label=StartLight
D $AEED Starts a new light, in a slot that is not in use. The light is given a
. random colour and direction, and a random delay. It starts at the top left of
. the frame of the screen, which is made of attributes of the value #N$48. The
. lights then move along the frame, one cell a frame.
R $AEED HL Address of the slot of the light
  $AEED,$01 Copy the address of the slot into #REGix...
  $AEEE,$02 Pop it into #REGix.
  $AEF0,$03 Fetch the random number...
  $AEF3,$01 ...and keep it in #REGe.
  $AEF4,$03 Keep the low two bits...
  $AEF7,$02 ...and clear #REGh.
  $AEF9,$03 Point #REGbc at #R$AF19.
  $AEFC,$01 Add the offset.
  $AEFD,$01 Fetch the colour...
  $AEFE,$01 ...and fetch the random number again.
  $AEFF,$03 Keep the bits that choose the direction, and add the colour.
  $AF02,$03 Store the type of the light.
  $AF05,$03 Fetch the random number again...
  $AF08,$04 ...keep a number between #N$00 and #N($3F), and add #N$20 to it...
  $AF0C,$03 ...to find the time before the light can finish.
  $AF0F,$04 Store the low byte of the address of the attribute, #N$21...
  $AF13,$04 ...and the high byte, #N$58.
  $AF17,$02 Jump to move the lights.

b $AF19 Light Colours
@ $AF19 label=LightColours
D $AF19 The colours of the lights: red, magenta, yellow and yellow.
B $AF19,$01 #COLOUR(#PEEK(#PC)).
L $AF19,$01,$04

c $AF1D Check Lights
@ $AF1D label=CheckLights
D $AF1D Checks whether any of the lights are in use.
R $AF1D B Number of lights
R $AF1D HL Address of the first light
R $AF1D DE Size of a light
R $AF1D O:F The zero flag is set if no lights are in use
  $AF1D,$01 Start the count of lights at zero.
@ $AF1E label=CheckLights_Next
  $AF1E,$01 Combine the type of the light with the others...
  $AF1F,$01 ...and move on to the next light.
  $AF20,$02 Loop back until all the lights have been checked.
  $AF22,$01 Return if no lights are in use.
  $AF23,$02 Jump to move the lights.

c $AF25 Move Lights
@ $AF25 label=MoveLights
D $AF25 Moves the lights that travel around the frame of the screen, and starts
. a new one when it is asked to. This is done every frame. There are eight
. lights, each of which is a type, a delay, and the address of the attribute
. that it is in. The lights follow the cells of the frame, which have an
. attribute of #N($48), and a light finishes when it gets back to the top
. left of the frame.
R $AF25 A #N$01 to start a new light, or #N$00 to leave the lights as they are
R $AF25 O:F The zero flag is set if no lights are in use
  $AF25,$02 There are eight lights.
  $AF27,$03 Point #REGhl at #R$AF8E.
  $AF2A,$03 Each light is four bytes long.
  $AF2D,$03 Jump to check whether any lights are in use if a new light is not
. wanted.
@ $AF30 label=MoveLights_FindFree
  $AF30,$01 Fetch the type of the light.
  $AF31,$03 Jump to start a new light if the slot is not in use.
  $AF34,$01 Move on to the next light.
  $AF35,$02 Loop back until all of the lights have been tried.
@ $AF37 label=MoveLights_Update
  $AF37,$04 Point #REGix at the first light.
@ $AF3B label=MoveLights_Light
  $AF3B,$03 Fetch the random number...
  $AF3E,$01 ...and keep it in #REGc.
  $AF3F,$03 Add a number from the memory refresh register...
  $AF42,$03 ...and store the new random number.
  $AF45,$03 Fetch the type of the light.
  $AF48,$03 Jump to the next light if it is not in use.
  $AF4B,$03 Fetch the delay of the light.
  $AF4E,$03 Jump if it has run out.
  $AF51,$01 Take one off the delay...
  $AF52,$03 ...and store it.
@ $AF55 label=MoveLights_NextLight
  $AF55,$03 Fetch the address of the attribute of the light...
  $AF58,$03 ...into #REGde.
  $AF5B,$04 Clear the flag that says that the light has turned.
  $AF5F,$03 Point #REGhl at #R$AF7A...
  $AF62,$01 ...and make the routine return there when it has finished.
  $AF63,$03 Fetch the type of the light...
  $AF66,$03 ...and turn it into the direction that it is heading in.
  $AF69,$02 Keep the direction...
  $AF6B,$01 ...and use it as the index into the table.
  $AF6C,$03 Point #REGbc at #R$AF72.
  $AF6F,$03 ...and jump to the routine for the direction, using #R$997A.

w $AF72 Light Handlers
@ $AF72 label=LightHandlers
D $AF72 The routines that move a light, for each of the four directions.
W $AF72,$08,$02

c $AF7A Next Light
@ $AF7A label=NextLight
D $AF7A Moves on to the next light, and when all of them have been moved makes
. the routine return.
R $AF7A IX Light
R $AF7A O:A #N$01
R $AF7A O:F The zero flag is reset
  $AF7A,$03 Each light is four bytes long.
  $AF7D,$02 Move on to the next light.
  $AF7F,$02 Copy the address into #REGhl...
  $AF81,$01 Pop it into #REGhl.
  $AF82,$03 Point #REGde at the end of the lights.
  $AF85,$03 Compare the address with it.
  $AF88,$02 Loop back if there are more lights.
  $AF8A,$03 Set #REGa to #N$01 and clear the zero flag.
  $AF8D,$01 Return.

g $AF8E Lights
@ $AF8E label=Lights
D $AF8E The eight lights. Each light is four bytes long: the type (zero if the
. slot is not in use; bits 0-2 are the colour and bits 3-4 are the direction), a
. delay before the light can finish, and the address of the attribute that the
. light is in.
B $AF8E,$20,$04

c $AFAE Move Light Left
@ $AFAE label=MoveLightLeft
D $AFAE Moves a light one cell to the left, along the frame of the screen, if
. the cell on the left is part of the frame. If it is not then the light turns.
. A light that gets back to the top left of the frame after its delay has run
. out is finished.
R $AFAE DE Address of the attribute that the light is in
R $AFAE IX Light
  $AFAE,$03 Point #REGhl at the cell on the left.
@ $AFB1 label=MoveLightLeft_Move
  $AFB1,$01 Fetch the attribute of the cell.
  $AFB2,$04 Jump to turn the light if it is not part of the frame.
@ $AFB6 label=MoveLight_Move
  $AFB6,$03 Restore the attribute of the frame in the cell that the light is
. leaving.
  $AFB9,$01 Put the address of the new cell in #REGde.
  $AFBA,$03 Fetch the delay of the light.
  $AFBD,$03 Jump to show the light if the delay has not run out.
  $AFC0,$03 Point #REGhl at the top left of the frame.
  $AFC3,$05 Jump to show the light if it has not got there.
  $AFC8,$04 Otherwise the light has finished, so free its slot...
  $AFCC,$01 ...and return.
@ $AFCD label=MoveLight_Show
  $AFCD,$03 Fetch the type of the light.
  $AFD0,$02 Keep the colour...
  $AFD2,$02 ...and add the attribute of the frame.
  $AFD4,$01 Show the light in the new cell.
  $AFD5,$03 Store the address of the cell...
  $AFD8,$03 ...in the light.
  $AFDB,$01 Return.

c $AFDC Move Light Right
@ $AFDC label=MoveLightRight
D $AFDC Moves a light one cell to the right. See #R$AFAE.
R $AFDC DE Address of the attribute that the light is in
R $AFDC IX Light
  $AFDC,$03 Point #REGhl at the cell on the right.
  $AFDF,$02 Jump to move the light.

c $AFE1 Move Light Up
@ $AFE1 label=MoveLightUp
D $AFE1 Is meant to move a light one cell up. However, the instruction that
. should take one row off the address is missing, so the cell that is tested is
. the cell that the light is already in. That cell never has the attribute of
. the frame, and so the light always turns instead.
R $AFE1 DE Address of the attribute that the light is in
R $AFE1 IX Light
  $AFE1,$02 Point #REGhl at the cell that the light is in.
  $AFE3,$03 Use a row of #N$20 characters.
  $AFE6,$01 Clear the carry flag.
@ $AFE7 label=MoveLight_Test
  $AFE7,$01 Fetch the attribute of the cell.
  $AFE8,$04 Jump to turn the light sideways if it is not part of the frame.
  $AFEC,$02 Jump to move the light.

c $AFEE Move Light Down
@ $AFEE label=MoveLightDown
D $AFEE Moves a light one cell down. See #R$AFAE.
R $AFEE DE Address of the attribute that the light is in
R $AFEE IX Light
  $AFEE,$02 Point #REGhl at the cell that the light is in.
  $AFF0,$03 Use a row of #N$20 characters...
  $AFF3,$01 ...and move down to the cell below.
  $AFF4,$02 Jump to test the cell.

c $AFF6 Turn Light Vertically
@ $AFF6 label=TurnLightVertically
D $AFF6 Tries to turn a light so that it goes up or down. If neither of the
. cells is part of the frame then the light is turned round, and the routine
. tries again, but only once.
R $AFF6 DE Address of the attribute that the light is in
R $AFF6 IX Light
  $AFF6,$02 Point #REGhl at the cell that the light is in.
  $AFF8,$03 Use a row of #N$20 characters.
  $AFFB,$03 Take it off to find the cell above.
  $AFFE,$01 Fetch the attribute of the cell.
  $AFFF,$04 Jump to turn up if it is part of the frame.
  $B003,$02 Move down to the cell below.
  $B005,$01 Fetch the attribute of the cell.
  $B006,$04 Jump to turn down if it is part of the frame.
  $B00A,$03 Fetch the flag that says that the light has turned.
  $B00D,$02 Return if it has.
  $B00F,$02 Set the flag...
  $B011,$03 ...and store it.
  $B014,$03 Fetch the type of the light.
  $B017,$05 Turn the light round, and store it.

c $B01C Turn Light Horizontally
@ $B01C label=TurnLightHorizontally
D $B01C Tries to turn a light so that it goes left or right. If neither of the
. cells is part of the frame then the light is turned round, and the routine
. tries to turn it vertically instead, but only once.
R $B01C DE Address of the attribute that the light is in
R $B01C IX Light
  $B01C,$03 Point #REGhl at the cell on the left.
  $B01F,$01 Fetch the attribute of the cell.
  $B020,$04 Jump to turn left if it is part of the frame.
  $B024,$02 Move to the cell on the right.
  $B026,$01 Fetch the attribute of the cell.
  $B027,$04 Jump to turn right if it is part of the frame.
  $B02B,$03 Fetch the flag that says that the light has turned.
  $B02E,$02 Return if it has.
  $B030,$02 Set the flag...
  $B032,$03 ...and store it.
  $B035,$03 Fetch the type of the light.
  $B038,$05 Turn the light round, and store it.
  $B03D,$02 Jump to try to turn the light vertically.

c $B03F Set Light Direction
@ $B03F label=SetLightUp
D $B03F Gives a light a new direction and moves it. The entry points are for
. turning up, down, left and right.
R $B03F HL Address of the attribute that the light is going to
R $B03F IX Light
  $B03F,$02 Use the code for up.
@ $B041 label=SetLight_Direction
  $B041,$03 Fetch the type of the light.
  $B044,$02 Keep the colour...
  $B046,$01 ...and add the new direction.
  $B047,$03 Store the type of the light.
  $B04A,$03 Jump to move the light.
@ $B04D label=SetLightDown
  $B04D,$02 Use the code for down.
  $B04F,$02 Jump to set the direction.
@ $B051 label=SetLightLeft
  $B051,$02 Use the code for left.
  $B053,$02 Jump to set the direction.
@ $B055 label=SetLightRight
  $B055,$02 Use the code for right.
  $B057,$02 Jump to set the direction.

c $B059 Do Nothing Cell
@ $B059 label=DoNothingCell
D $B059 The handler for entity type #N($01), which does nothing.
  $B059,$01 Return.

c $B05A Toggle Sprite
@ $B05A label=ToggleSprite
D $B05A Flips the lowest bit of an entity's type, which switches it between two
. sprites. This is the handler for entity types #N$02 to #N$07. Types #N$06 and
. #N$07 are the battery and share one picture. Nothing sets types #N$02 to
. #N$05.
R $B05A IX Entity
  $B05A,$03 Fetch the type of the entity...
  $B05D,$02 ...flip the lowest bit...
  $B05F,$03 ...and store it.
  $B062,$01 Return.

c $B063 Next Sprite Number
@ $B063 label=NextSpriteNumber
D $B063 Adds one to the lowest two bits of an entity's type, so a four-frame
. sprite moves on to the next frame. This is the handler for entity types #N$70
. to #N($73), the activated terminal.
E $B063 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$CCAE }
. { #NIGHTSHADE$CEF8 }
. LIST#
R $B063 IX Entity
  $B063,$01 Save #REGbc.
  $B064,$03 Fetch the type of the entity...
  $B067,$01 ...and keep it in #REGc.
  $B068,$01 Add one...
  $B069,$03 ...keep the lowest two bits, and put them in #REGb.
  $B06C,$01 Fetch the type again...
  $B06D,$03 ...replace the lowest two bits with the new ones.
  $B070,$03 Store the type of the entity.
  $B073,$01 Restore #REGbc.
  $B074,$01 Return.

c $B075 Read Controls
@ $B075 label=ReadControls
D $B075 Reads the controls, using the method that has been chosen in the menu:
. keyboard, Kempston joystick, cursor keys or Sinclair interface 2. The controls
. are kept as bits that stay set until the robot has used them.
. #TABLE(default,centre,centre)
. { =h Bit | =h Meaning }
. { #N$00 | Turn right }
. { #N$01 | Turn left }
. { #N$02 | Move forward }
. { #N$03 | Fire the second weapon }
. { #N$04 | Fire the first weapon }
. { #N$06 | Use the action key }
. TABLE#
R $B075 O:A The controls
R $B075 O:C The controls
  $B075,$01 Save #REGbc.
  $B076,$03 Fetch the method of control...
  $B079,$01 ...and keep the bits that choose it.
  $B07A,$05 Jump to read the keyboard if the method is zero.
  $B07F,$03 Jump to read the Kempston joystick if it is one.
  $B082,$03 Jump to read the cursor keys if it is two.

c $B085 Read Interface 2
@ $B085 label=ReadInterface2
D $B085 Reads the Sinclair interface 2 joysticks. The keys #N$06 to #N$00 are
. one joystick and the keys #N$01 to #N$05 are the other; both are used at once.
  $B085,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $B08A,$01 Keep the keys in #REGc.
  $B08B,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $B090,$01 Combine the keys of both.
  $B091,$02 Clear the controls.
  $B093,$04 Jump if the first key is not pressed (#N$00 or #N$01).
  $B097,$02 Set the bit for firing the second weapon.
@ $B099 label=ReadInterface2_Key2
  $B099,$04 Jump if the second key is not pressed (#N$09 or #N$02).
  $B09D,$02 Set the bit for moving forward.
@ $B09F label=ReadInterface2_Key3
  $B09F,$04 Jump if the third key is not pressed (#N$08 or #N$03).
  $B0A3,$02 Set the bit for the action key.
@ $B0A5 label=ReadInterface2_Key4
  $B0A5,$04 Jump if the fourth key is not pressed (#N$07 or #N$04).
  $B0A9,$02 Set the bit for turning right.
@ $B0AB label=ReadInterface2_Key5
  $B0AB,$04 Jump if the fifth key is not pressed (#N$06 or #N$05).
  $B0AF,$02 Set the bit for turning left.
@ $B0B1 label=ReadInterface2_Finish
  $B0B1,$03 Jump to finish.

c $B0B4 Controls: Kempston Joystick
@ $B0B4 label=ReadKempstonJoystick
D $B0B4 Reads the Kempston joystick.
E $B0B4 View the equivalent code in;
. #LIST
. { #SABREWULF$B0D9 }
. LIST#
  $B0B4,$02 Read the joystick.
  $B0B6,$02 Clear the controls.
  $B0B8,$04 Jump if the joystick is not pushed right.
  $B0BC,$02 Set the bit for turning right.
@ $B0BE label=ReadKempstonJoystick_Left
  $B0BE,$04 Jump if the joystick is not pushed left.
  $B0C2,$02 Set the bit for turning left.
@ $B0C4 label=ReadKempstonJoystick_Down
  $B0C4,$04 Jump if the joystick is not pushed down.
  $B0C8,$02 Set the bit for the action key.
@ $B0CA label=ReadKempstonJoystick_Up
  $B0CA,$04 Jump if the joystick is not pushed up.
  $B0CE,$02 Set the bit for moving forward.
@ $B0D0 label=ReadKempstonJoystick_Fire
  $B0D0,$04 Jump to finish if the fire button is not pressed.
  $B0D4,$02 Set the bit for firing the second weapon.
  $B0D6,$03 Jump to finish.

c $B0D9 Read Cursor Keys
@ $B0D9 label=ReadCursorKeys
D $B0D9 Reads the cursor keys, which are the keys #N$05 (left), #N$06 (down),
. #N$07 (up), #N$08 (right) and #N$00. The code does not work properly: for up,
. right and #N$00 the test is the wrong way round, so the bits are set when the
. keys are not being pressed.
  $B0D9,$02 Clear the controls.
  $B0DB,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $B0E0,$04 Jump if the key #N$05 (left) is not pressed.
  $B0E4,$02 Set the bit for turning left.
@ $B0E6 label=ReadCursorKeys_Digits
  $B0E6,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $B0EB,$04 Jump if the key #N$06 (down) is not pressed.
  $B0EF,$02 Set the bit for the action key.
@ $B0F1 label=ReadCursorKeys_CheckUp
  $B0F1,$04 Jump if the key #N$07 (up) is pressed.
  $B0F5,$02 Set the bit for moving forward.
@ $B0F7 label=ReadCursorKeys_CheckRight
  $B0F7,$04 Jump if the key #N$08 (right) is pressed.
  $B0FB,$02 Set the bit for turning right.
@ $B0FD label=ReadCursorKeys_CheckFire
  $B0FD,$04 Jump if the key #N$00 is pressed.
  $B101,$02 Set the bit for firing the second weapon.

c $B103 Finish Joystick Controls
@ $B103 label=FinishJoystickControls
D $B103 Adds the keys that work with every method of control, and stores the
. controls. Any of the keys Z, X, C, V, Symbol Shift, M, N and B fires the first
. weapon.
R $B103 C Controls that were read
  $B103,$03 Fetch the controls that have not been used yet...
  $B106,$02 ...clear the bit for the action key...
  $B108,$01 ...and add the controls that were read.
  $B109,$01 Keep the controls.
  $B10A,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SHIFT / SPACE | Z / SYM | X / M | C / N | V / B }
. TABLE#
  $B10F,$04 Jump if none of the keys Z, X, C, V, Symbol Shift, M, N and B is
. pressed.
  $B113,$02 Set the bit for firing the first weapon.
@ $B115 label=FinishJoystickControls_Store
  $B115,$01 Fetch the controls...
  $B116,$03 ...and store them.
  $B119,$01 Restore #REGbc.
  $B11A,$01 Return the controls in #REGc as well.
  $B11B,$01 Return.

c $B11C Read Keyboard
@ $B11C label=ReadKeyboard
D $B11C Reads the keyboard. The keys C, M and B turn right, and X, V and N turn
. left. Any of A, S, D, F, G, Enter, L, K, J and H moves forward. The keys O, U,
. Q, E and T fire the second weapon, and P, I, Y, W and R fire the first one. Z,
. Symbol Shift and all of the number keys use the action key.
R $B11C O:A The controls
R $B11C O:C The controls
  $B11C,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $B121,$01 Save #REGbc.
  $B122,$01 Move the keys Z, X, C and V into the lowest bits...
  $B123,$02 ...and keep X, C and V.
  $B125,$01 Keep the keys X, C and V.
  $B126,$02 Keep X, which turns left...
  $B128,$02 ...and move C and V down by two bits.
  $B12A,$02 Shift C into the right-turn bit and V into the left-turn bit.
  $B12C,$01 Combine them, so that C turns right and X or V turn left...
  $B12D,$03 ...and keep just the bits for turning.
  $B130,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | SYMBOL SHIFT | M | N | B }
. TABLE#
  $B135,$01 Move the keys Symbol Shift, M, N and B into the lowest bits...
  $B136,$02 ...and keep M, N and B.
  $B138,$01 Keep the keys M, N and B.
  $B139,$02 Rotate the keys round, so that N turns left and M turns right...
  $B13B,$01 Shift the next key in.
  $B13C,$02 Rotate the keys that are left.
  $B13E,$01 Shift the next key in.
  $B13F,$03 ...keep just the bits for turning and combine them with the others.
  $B142,$01 Keep the turning bits.
  $B143,$02 Do the same for the last of the keys, so that B turns right...
  $B145,$01 Shift the last key in.
  $B146,$02 Rotate the keys that are left.
  $B148,$01 Shift the last key in.
  $B149,$03 ...keep just the bits for turning and combine them with the others.
  $B14C,$01 Restore #REGbc.
  $B14D,$01 Keep the bits for turning.
  $B14E,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$BD | A / ENTER | S / L | D / K | F / J | G / H }
. TABLE#
  $B153,$04 Jump if none of them is pressed.
  $B157,$02 Set the bit for moving forward.
@ $B159 label=ReadKeyboard_ReadPToY
  $B159,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$DF | P | O | I | U | Y }
. TABLE#
  $B15E,$01 Keep the keys P to Y.
  $B15F,$04 Jump if neither O nor U is pressed.
  $B163,$02 Set the bit for firing the second weapon.
@ $B165 label=ReadKeyboard_CheckPIY
  $B165,$01 Fetch the keys again.
  $B166,$04 Jump if none of P, I and Y is pressed.
  $B16A,$02 Set the bit for firing the first weapon.
@ $B16C label=ReadKeyboard_ReadQToT
  $B16C,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FB | Q | W | E | R | T }
. TABLE#
  $B171,$01 Keep the keys Q to T.
  $B172,$04 Jump if none of Q, E and T is pressed.
  $B176,$02 Set the bit for firing the second weapon.
@ $B178 label=ReadKeyboard_CheckQET
  $B178,$01 Fetch the keys again.
  $B179,$04 Jump if neither W nor R is pressed.
  $B17D,$02 Set the bit for firing the first weapon.
@ $B17F label=ReadKeyboard_Controls
  $B17F,$03 Fetch the controls that have not been used yet...
  $B182,$01 ...and add the new ones.
  $B183,$01 Keep the controls.
  $B184,$02 Clear the bit for the action key.
  $B186,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7E | SHIFT / SPACE | Z / SYM | X / M | C / N | V / B }
. TABLE#
  $B18B,$04 Jump if neither Z nor Symbol Shift is pressed.
  $B18F,$02 Set the bit for the action key.
@ $B191 label=ReadKeyboard_ReadNumbers
  $B191,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$E7 | 1 / 0 | 2 / 9 | 3 / 8 | 4 / 7 | 5 / 6 }
. TABLE#
  $B196,$04 Jump if none of the number keys is pressed.
  $B19A,$02 Set the bit for the action key.
@ $B19C label=ReadKeyboard_Store
  $B19C,$01 Fetch the controls...
  $B19D,$03 ...and store them.
  $B1A0,$01 Restore #REGbc.
  $B1A1,$01 Return the controls in #REGc as well.
  $B1A2,$01 Return.

c $B1A3 Fill Memory
@ $B1A3 label=FillMemory
D $B1A3 Fills an area of memory with zero. The entry point at #R$B1A5 fills it
. with the byte in #REGe.
E $B1A3 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$CE56 }
. { #GUNFRIGHT$D6E1 }
. { #KNIGHTLORE$D53A }
. { #NIGHTSHADE$E5BA }
. { #PENTAGRAM$CB77 }
. { #UNDERWURLDE$9569 }
. LIST#
R $B1A3 BC Number of bytes
R $B1A3 HL Address of the first byte
  $B1A3,$02 Set #REGe to #N$00.
@ $B1A5 label=FillMemory_WithValue
  $B1A5,$01 Write #REGe.
  $B1A6,$01 Increment #REGhl.
  $B1A7,$01 Decrement #REGbc.
  $B1A8,$04 Loop back until the byte counter is zero.
  $B1AC,$01 Return.

c $B1AD Clear Screen
@ $B1AD label=ClearScreen
D $B1AD Resets the whole display: the attributes are set to bright white on
. black and the pixels are cleared.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SCR$02(clear-screen-before)
. | #SIM(start=$98E9,stop=$98EC,clear=1,sp=$5E00)
. #SCR$02(clear-screen-after) } UDGTABLE# #POPS
  $B1AD,$03 Set every attribute using #R$B1B8.
  $B1B0,$03 Point #REGhl at the start of the display file.
  $B1B3,$03 There are #N$1800 bytes of pixels to clear.
  $B1B6,$02 Clear them using #R$B1A3.

c $B1B8 Reset Attributes
@ $B1B8 label=ResetAttributes
D $B1B8 Sets all #N$0300 attribute bytes to #N$47 (bright white ink on black
. paper).
  $B1B8,$02 Use the attribute #N$47.
  $B1BA,$03 Point #REGhl at the start of the attribute file.
  $B1BD,$03 There are #N$0300 attributes.
  $B1C0,$02 Fill them using #R$B1A5.

c $B1C2 Fill Play Window Attributes
@ $B1C2 label=FillPlayWindowAttributes
D $B1C2 Fills the attributes of the play window, which is #N$14 characters wide
. and #N$0E characters tall and starts at column #N$02 of row #N($02), with a
. single attribute.
R $B1C2 A Attribute
  $B1C2,$03 Point #REGhl at the top left attribute of the play window.
  $B1C5,$03 There are #N$0C attributes between the end of one window row and the
. start of the next.
  $B1C8,$03 The window is #N$14 columns wide (#REGb) and #N$0E rows tall
. (#REGc).
@ $B1CB label=FillAttributes_Row
  $B1CB,$01 Save the dimensions.
@ $B1CC label=FillAttributes_Column
  $B1CC,$01 Write the attribute to the current cell.
  $B1CD,$01 Move on to the next column.
  $B1CE,$02 Loop back until the row is complete.
  $B1D0,$01 Move on to the start of the next row.
  $B1D1,$01 Restore the dimensions.
  $B1D2,$01 Decrease the row counter by one.
  $B1D3,$02 Loop back until every row has been filled.
  $B1D5,$01 Return.

c $B1D6 Fill Large Window Attributes
@ $B1D6 label=FillLargeWindowAttributes
D $B1D6 Fills the attributes of the large window, which is #N$14 characters wide
. and #N$14 characters tall and starts at column #N$02 of row #N($02), with a
. single attribute. This is the play window plus the rows below it.
R $B1D6 A Attribute
  $B1D6,$03 Point #REGhl at the top left attribute of the window.
  $B1D9,$03 There are #N$0C attributes between the end of one window row and the
. start of the next.
  $B1DC,$03 The window is #N$14 columns wide (#REGb) and #N$14 rows tall
. (#REGc).
  $B1DF,$02 Fill the window using #R$B1CB.

c $B1E1 Fill Message Attributes
@ $B1E1 label=FillMessageAttributes
D $B1E1 Fills the attributes of the message area at the bottom of the screen,
. which is #N$18 characters wide and #N$06 characters tall and starts at column
. #N$00 of row #N($12), with a single attribute.
R $B1E1 A Attribute
  $B1E1,$03 Point #REGhl at the first attribute of row #N$12.
  $B1E4,$03 There are #N$08 attributes between the end of one row and the start
. of the next.
  $B1E7,$03 The area is #N$18 columns wide (#REGb) and #N$06 rows tall (#REGc).
  $B1EA,$02 Fill the area using #R$B1CB.

c $B1EC Blank Play Area
@ $B1EC label=BlankPlayArea
D $B1EC Clears the pixels of the play window: #N$14 bytes wide and #N$70 pixel
. rows tall, starting at column #N$02 of the first pixel row.
E $B1EC Continue on to #R$B1F2.
E $B1EC View the equivalent code in;
. #LIST
. { #LUNARJETMAN$8BA5 }
. LIST#
  $B1EC,$03 Point #REGhl at the top left of the play window.
  $B1EF,$03 The window is #N$14 bytes wide (#REGb) and #N$70 pixel rows tall
. (#REGc).

c $B1F2 Clear Pixel Block
@ $B1F2 label=ClearPixelBlock
D $B1F2 Clears a rectangle of the display file.
R $B1F2 HL Screen address of the top left byte
R $B1F2 B Width in bytes
R $B1F2 C Height in pixel rows
  $B1F2,$01 Save the dimensions.
  $B1F3,$01 Save the screen address of the start of the row.
@ $B1F4 label=ClearPixelBlock_Byte
  $B1F4,$02 Clear the current byte of the row.
  $B1F6,$01 Move on to the next byte.
  $B1F7,$02 Loop back until the whole row has been cleared.
  $B1F9,$01 Restore the screen address of the start of the row.
  $B1FA,$03 Move down to the next pixel row using #R$BD3A.
  $B1FD,$01 Restore the dimensions.
  $B1FE,$01 Decrease the pixel row counter by one.
  $B1FF,$02 Loop back until every row has been cleared.
  $B201,$01 Return.

c $B202 Clear Message Area
@ $B202 label=ClearMessageArea
D $B202 Clears the pixels of the message area at the bottom of the screen: #N$18
. bytes wide and #N$30 pixel rows tall, starting at row #N$12.
  $B202,$03 Point #REGhl at the first pixel row of row #N$12.
  $B205,$03 The area is #N$18 bytes wide (#REGb) and #N$30 pixel rows tall
. (#REGc).
  $B208,$02 Clear it using #R$B1F2.

c $B20A Clear Large Window
@ $B20A label=ClearLargeWindow
D $B20A Clears the pixels of the large window: #N$14 bytes wide and #N$A0 pixel
. rows tall, starting at column #N$02 of the first pixel row.
  $B20A,$03 Point #REGhl at the top left of the window.
  $B20D,$03 The window is #N$14 bytes wide (#REGb) and #N$A0 pixel rows tall
. (#REGc).
  $B210,$02 Clear it using #R$B1F2.

c $B212 Clear Large Window With Attributes
@ $B212 label=ClearLargeWindowWithAttributes
D $B212 Fills the large window with an attribute and then clears its pixels.
R $B212 A Attribute
  $B212,$03 Fill the attributes using #R$B1D6.
  $B215,$02 Clear the pixels using #R$B20A.

c $B217 Clear Play Window With Attributes
@ $B217 label=ClearPlayWindowWithAttributes
D $B217 Fills the play window with an attribute and then clears its pixels.
R $B217 A Attribute
  $B217,$03 Fill the attributes using #R$B1C2.
  $B21A,$02 Clear the pixels using #R$B1EC.

c $B21C Draw Play Window
@ $B21C label=DrawPlayWindow
D $B21C Copies the off-screen play window buffer to the display, and at the same
. time resets the buffer to the dithered grey background of the play window
. (alternate lines of #N$55 and #N$AA). The buffer occupies #N$F580 to #N$FFFF:
. #N$70 lines of #N$18 bytes. Only the middle #N$14 bytes of each line are shown
. on screen, as the #N$02 bytes at each end are margins that let sprites
. overhang the edges of the window. The lines are copied from the bottom of the
. window to the top, working backwards through the buffer. The stack pointer is
. pointed at the display and each pair of bytes taken from the buffer is written
. using a PUSH instruction, which is much faster than storing the bytes one at a
. time.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #POKES$D355,$10;$D356,$50;$D357,$50
. #POKES$D358,$08;$D359,$78;$D35A,$70
. #POKES$D35B,$60;$D35C,$A0;$D35D,$50
. #POKES$D35E,$68;$D35F,$50;$D360,$88
. #POKES$D361,$50;$D362,$B0;$D363,$88
. #POKES$D364,$00
. #SIM(start=$99F8,stop=$99FB)
. #SCR$02(draw-play-window-before)
. | #SIM(start=$99FB,stop=$99FE)
. #SCR$02(draw-play-window-after) } UDGTABLE# #POPS
E $B21C Continue on to #R$B21F.
  $B21C,$03 Point #REGde at the screen address just after the bottom right byte
. of the play window.
N $B21F Entered from #R$98E3 with #REGde pointing at the ROM, to fill the buffer
. with the dithered background without drawing anything. #REGde holds the screen
. address just after the bottom right byte of the window.
@ $B21F label=DrawPlayWindow_Entry
  $B21F,$04 Save the stack pointer.
  $B223,$03 Point #REGhl at the last visible byte of the buffer, which is the
. bottom right of the window.
  $B226,$03 Set the line counter to #N$70 (the height of the play window in
. pixels) and the background pattern for the bottom line to #N$55.
  $B229,$01 Put the screen address in #REGhl, so that it can be used as the
. stack pointer.
@ $B22A label=DrawPlayWindow_Screen
  $B22A,$02 Point the stack pointer at the screen address, and swap the buffer
. pointer back into #REGhl.
@ $B22C label=DrawPlayWindow_Line
N $B22C Copy a line of the buffer, two bytes at a time, and replace each byte
. with the background pattern.
  $B22C,$07 Copy two bytes from the buffer to the screen and replace them with
. the pattern.
  $B233,$07 Copy the next two bytes.
  $B23A,$07 Copy the next two bytes.
  $B241,$07 Copy the next two bytes.
  $B248,$07 Copy the next two bytes.
  $B24F,$07 Copy the next two bytes.
  $B256,$07 Copy the next two bytes.
  $B25D,$07 Copy the next two bytes.
  $B264,$07 Copy the next two bytes.
  $B26B,$07 Copy the last two bytes of the line (#N$14 bytes have now been
. copied).
  $B272,$04 Skip the margin bytes: the two on the left of this line and the two
. on the right of the line above.
  $B276,$02 Swap the background pattern between #N$55 and #N$AA for the next
. line.
  $B278,$01 Keep the buffer pointer.
N $B279 Work out the screen address of the end of the pixel line above.
  $B279,$04 Add #N($FF14, $04, $04) (-#N$EC) to the stack pointer, which has
. moved back #N$14 bytes along the line, to give the address one pixel line up.
  $B27D,$04 Test whether the new address is the bottom pixel line of the
. character row above.
  $B281,$02 Jump if it is not, as the address is correct.
  $B283,$04 Move up a character row by subtracting #N$20 from the low byte.
  $B287,$02 Jump if that crossed a third of the display.
  $B289,$04 Otherwise move to the bottom pixel line of the row.
@ $B28D label=DrawPlayWindow_NextLine
  $B28D,$02 Loop back until all #N$70 lines have been copied.
  $B28F,$04 Restore the stack pointer.
  $B293,$01 Return.

c $B294 Build Shift Tables
@ $B294 label=BuildShiftTables
D $B294 Builds the lookup tables used to shift sprite bytes right by any number
. of pixels, and the table used to reverse the bits of a byte. The shift tables
. occupy #N$E000 to #N$EFFF. For each byte value #N$00 to #N$FF and each shift
. of #N$00 to #N$07 bits to the left, the byte is stored as a #N$10 bit number.
. The low byte of the number is stored in page #N$EF for a shift of #N($00),
. page #N$ED for a shift of #N($01), and so on in steps of two pages. The high
. byte is
. stored in the page below it. Both are stored at the offset given by the
. original value. The table at #N$F000 gives the value of each byte with its
. bits reversed, and is used to flip sprites.
  $B294,$02 Start with the byte value #N$00.
@ $B296 label=BuildShiftTables_NextValue
  $B296,$02 Clear the high byte of the shifted value.
  $B298,$01 Copy the byte value into the low byte of the shifted value.
  $B299,$02 Point #REGh at the first table page, #N$EF.
  $B29B,$02 There are #N$08 shifts to tabulate.
@ $B29D label=BuildShiftTables_Shift
  $B29D,$02 Store the low byte of the shifted value.
  $B29F,$01 Move to the page below.
  $B2A0,$02 Store the high byte of the shifted value.
  $B2A2,$01 Move to the next page below.
  $B2A3,$04 Shift the #N$10 bit value left by one bit.
  $B2A7,$02 Loop back until all shifts have been stored.
  $B2A9,$03 Move on to the next byte value, and loop back until all #N$0100 have
. been done.
  $B2AC,$03 Point #REGhl at #R$F000.
@ $B2AF label=BuildShiftTables_ReverseByte
  $B2AF,$01 Take the byte value to reverse.
  $B2B0,$02 There are #N$08 bits to move.
@ $B2B2 label=BuildShiftTables_ReverseBit
  $B2B2,$01 Move the lowest bit out into the carry flag.
  $B2B3,$02 Move the carry flag in at the bottom of #REGe, so the bits end up
. reversed.
  $B2B5,$02 Loop back until all #N$08 bits have been moved.
  $B2B7,$01 Store the reversed byte.
  $B2B8,$03 Move on to the next byte value, and loop back until all #N$0100 have
. been done.
  $B2BB,$01 Return.

c $B2BC Draw Sprite
@ $B2BC label=DrawSprite
D $B2BC Draws one sprite into the off-screen play window buffer. The sprite is
. found using the type in the draw list entry, as an index into the table of
. sprite pointers at #R$60A3. A sprite has a two byte header (the width in bytes
. plus flags, then the height in pixel rows) followed by its pixel rows, each
. made of pairs of bytes, one pair for each byte of width. The first byte of
. each pair is ORed onto the buffer and the second is then XORed onto the
. result. The rows are stored from the bottom of the sprite to the top. A sprite
. whose width and height are both zero is blank and is not drawn. Bit 7 of the
. type in the draw list entry means the sprite is drawn facing the other way.
. The flag in bit 7 of the sprite's own header records which way its data is
. currently stored, and if the two differ then the sprite's data is flipped in
. place first, using #R$B453. The x position is a pixel position in the buffer,
. where #N$10 is the left edge of the play window. The y position is the height
. of the bottom of the sprite above the bottom of the buffer, so it increases up
. the screen: #N$30 is the bottom of the play window and #N$A0 is the top.
. Sprites that overlap the top or bottom are clipped, and #N$10 pixels either
. side are available for sprites that overhang the left or right edge. If the
. sprite is not on a byte boundary then each pair of bytes is shifted right by
. the number of pixels using the tables built by #R$B294, and an extra byte is
. written for each row. The drawing is done by unrolled loops at #R$B36B
. (shifted) and #R$B42E (byte aligned), which are entered part way along
. according to the width of the sprite so that exactly the right number of bytes
. are drawn on each row. The sprite data is read by pointing the stack pointer
. at it and using POP.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #SCR$02(draw-sprite-before)
. | #POKES$D355,$10;$D356,$50;$D357,$50
. #POKES$D358,$00
. #SIM(start=$BF6A,stop=$BF76)
. #SIM(start=$99FB,stop=$99FE)
. #SCR$02(draw-sprite-after) } UDGTABLE# #POPS
R $B2BC IX Draw list entry: type, x position, y position
N $B2BC Find the sprite for this entry.
  $B2BC,$03 Fetch the type.
  $B2BF,$01 Double it, discarding the "face the other way" bit, to give the
. offset into the table of pointers.
  $B2C0,$07 Add the offset to the address of the table of sprite pointers at
. #R$60A3.
  $B2C7,$03 Fetch the address of the sprite into #REGde.
  $B2CA,$02 Fetch the width byte of the header into #REGc.
  $B2CC,$02 Fetch the height from the header.
  $B2CE,$03 Combine them and keep bits 0-5.
  $B2D1,$01 Return if both the width and the height are zero, as the sprite is
. blank.
  $B2D2,$01 Point #REGde at the start of the header again.
  $B2D3,$03 Flip the sprite data if it is stored facing the wrong way, using
. #R$B453.
N $B2D6 Find which page of the shift tables to use, which depends on the x
. position within a byte.
  $B2D6,$03 Fetch the x position.
  $B2D9,$04 Take one off, shift the result left by one (multiplying by two) and
. keep only the three bits of the shift, so that this is the shift amount
. multiplied by two.
  $B2DD,$03 Add the base of the shift tables to give the page number, in #REGh.
  $B2E0,$03 Fetch the x position again.
  $B2E3,$02 Test whether it is a multiple of #N$08.
  $B2E5,$01 Fetch the width byte of the header.
  $B2E6,$03 Jump to #R$B3B3 to draw the sprite without shifting if the x
. position is exactly on a byte boundary.
N $B2E9 The sprite needs shifting, so it will cover one more byte on each row
. than its width.
  $B2E9,$03 Add one to the width in bytes.
  $B2EC,$03 Store it as the number of bytes written to the buffer for each row.
  $B2EF,$01 Take a copy of it.
  $B2F0,$02 Add #N$17 to give the amount to subtract to get from the end of one
. row of the buffer to the start of the row above, since each row is #N$18 bytes
. long.
  $B2F2,$03 Write that as the number to subtract in the SUB instruction at
. #R$B3A4.
  $B2F5,$01 Fetch the width back, plus one.
  $B2F6,$01 Take one off to get the width.
  $B2F7,$01 Point #REGde at the height.
  $B2F8,$04 Negate the width and keep the bottom two bits, so that this is the
. number of unused copies of the unrolled loop out of the four available.
  $B2FC,$06 Multiply by #N($0E), the length of one copy of the unrolled loop.
  $B302,$01 Hold the shift table page in #REGb.
  $B303,$03 Point #REGhl at #R$B36B.
  $B306,$03 Add the offset using #R$BF92, to skip the copies that are not
. needed.
  $B309,$03 Write the address into the jump at #R$B368, so that it enters the
. loop at the right place.
  $B30C,$01 Fetch the height of the sprite.
  $B30D,$03 Store it as the number of rows still to draw.
  $B310,$01 Put the page number back into #REGh.
  $B311,$03 Fetch the x position into #REGc.
  $B314,$03 Fetch the y position into #REGb.
N $B317 Clip the bottom of the sprite, if it is below the bottom of the play
. window.
  $B317,$03 Is the bottom of the sprite on or above the bottom of the play
. window (#N$30)?
  $B31A,$02 Jump to #R$B33E if so.
  $B31C,$01 Keep the y position.
  $B31D,$01 Fetch the height of the sprite.
  $B31E,$01 Add the y position to get the top of the sprite.
  $B31F,$02 Is the top of the sprite below the bottom of the play window?
  $B321,$01 Return if it is, as the sprite is not visible at all.
  $B322,$02 Work out how many rows of the sprite are below the play window.
  $B324,$01 Subtract the y position from the bottom of the play window.
  $B325,$01 Keep that number of rows.
  $B326,$01 Fetch the height of the sprite.
  $B327,$01 Take away the number of rows that are cut off.
  $B328,$01 Return if nothing is left.
  $B329,$03 Store the number of rows that are left to be drawn.
  $B32C,$01 Save the number of rows that are cut off.
  $B32D,$03 Fetch the number of bytes written for each row.
  $B330,$01 Take one off to get the width in bytes.
  $B331,$01 Use it as a counter.
  $B332,$02 Start the total at zero, and clear the high byte of #REGhl.
@ $B334 label=DrawSprite_Shifted_Multiply
  $B334,$03 Add the number of rows that were cut off to the total, once for each
. byte of the width, to multiply them.
  $B337,$01 Keep the size of the hidden rows.
  $B338,$01 Double it, as each byte of the width has a pair of bytes of data.
  $B339,$01 Add the address of the sprite to give the address of the first
. visible row of data.
  $B33A,$01 Keep the address of the first visible row.
  $B33B,$01 Restore #REGhl.
  $B33C,$02 Start drawing from the bottom of the play window.
N $B33E Find the address in the buffer and point the stack pointer at the sprite
. data.
@ $B33E label=DrawSprite_Shifted_Address
  $B33E,$03 Find the address in the buffer of the first byte to draw, using
. #R$B48E.
  $B341,$04 Save the stack pointer.
  $B345,$03 Point the stack pointer at the sprite, so that POP fetches the data.
  $B348,$01 Take it past the height byte, to the first pair of data bytes.
N $B349 Clip the top of the sprite, if it is above the top of the play window.
  $B349,$03 Fetch the y position.
  $B34C,$05 Jump to #R$B3AE to finish if it is, as the sprite is not visible.
  $B351,$01 Keep the y position.
  $B352,$03 Fetch the number of rows to draw.
  $B355,$01 Add the y position to get the top of the sprite.
  $B356,$02 Subtract the top of the play window.
  $B358,$02 Jump if the sprite does not reach above the top of the play window.
  $B35A,$01 Keep the number of rows that are cut off.
  $B35B,$05 Take the cut off rows away from the number of rows to draw.
@ $B360 label=DrawSprite_Shifted_Rows
  $B360,$03 Fetch the number of rows to be drawn.
  $B363,$02 Switch to the shadow registers, and keep the number of rows to draw
. in #REGb'.
@ $B365 label=DrawSprite_Shifted_Row
  $B365,$01 Switch back to the main registers.
  $B366,$01 Fetch the first pair of data bytes into #REGde.
  $B367,$01 Fetch the first byte of the buffer to be changed.
@ $B368 label=DrawSprite_Shifted_Jump
  $B368,$03 Jump into the unrolled loop.
N $B36B The unrolled loop that draws one row of a sprite that is not on a byte
. boundary. #REGbc points at the buffer, #REGde holds the current pair of data
. bytes (OR byte in #REGe and XOR byte in #REGd) and #REGh holds the shift table
. page. Each pair of bytes is split by the shift table into a left part that is
. merged into the buffer byte already in #REGa and a right part that is merged
. into the next buffer byte.
@ $B36B label=DrawSprite_Shifted
  $B36B,$07 Merge the left part of the shifted pair into the buffer byte already
. in #REGa: OR on the shifted OR byte and XOR on the shifted XOR byte. Store the
. result and move on to the next buffer byte, and the right half of the shift
. table.
  $B372,$07 Merge the right part of the shifted pair into the next buffer byte
. and leave it in #REGa, as the next pair also overlaps it. Go back to the left
. half of the table and fetch the next pair of data bytes.
  $B379,$07 Merge the left part of the second pair and store it.
  $B380,$07 Merge the right part of the second pair and fetch the third.
  $B387,$07 Merge the left part of the third pair and store it.
  $B38E,$07 Merge the right part of the third pair and fetch the fourth.
  $B395,$07 Merge the left part of the fourth pair and store it.
  $B39C,$06 Merge the right part of the fourth pair.
  $B3A2,$01 Store the last buffer byte of the row.
N $B3A3 Move up to the start of the previous row of the buffer. The number to
. subtract is written by #R$B2F2 for each sprite.
  $B3A3,$04 Subtract the number of bytes to step back (the operand of this
. instruction is modified) from the low byte of the buffer address.
  $B3A7,$04 Take a carry from the high byte if there was a borrow.
@ $B3AB label=DrawSprite_Shifted_Next
  $B3AB,$01 Switch to the shadow registers, where #REGb' holds the number of
. rows left to draw.
  $B3AC,$02 Loop back until every row of the sprite has been drawn.
@ $B3AE label=DrawSprite_Done
  $B3AE,$04 Restore the stack pointer.
  $B3B2,$01 Return.
N $B3B3 The sprite is on a byte boundary, so no shifting is needed and each pair
. of bytes is combined with just one byte of the buffer.
@ $B3B3 label=DrawSprite_Aligned
  $B3B3,$02 Keep the width of the sprite in bytes.
  $B3B5,$03 Store it as the number of bytes written to the buffer for each row.
  $B3B8,$01 Take a copy of it.
  $B3B9,$02 Add #N$17 to give the amount to subtract to get back to the start of
. the row above, once the last byte of a row has been written.
  $B3BB,$03 Write that as the number to subtract in the SUB instruction at
. #R$B446.
  $B3BE,$01 Fetch the width back.
  $B3BF,$01 Point #REGde at the height.
  $B3C0,$04 Negate the width and keep the bottom two bits, so that this is the
. number of unused copies of the unrolled loop out of the four available.
  $B3C4,$01 Keep the number of unused copies of the loop.
  $B3C5,$03 Multiply by #N($06), the length of one copy of the unrolled loop.
  $B3C8,$03 Point #REGhl at #R$B42E.
  $B3CB,$03 Add the offset using #R$BF92, to skip the copies that are not
. needed.
  $B3CE,$03 Write the address into the jump at #R$B42B, so that it enters the
. loop at the right place.
  $B3D1,$01 Fetch the height of the sprite.
  $B3D2,$03 Store it as the number of rows still to draw.
  $B3D5,$03 Fetch the x position into #REGc.
  $B3D8,$03 Fetch the y position into #REGb.
N $B3DB Clip the bottom of the sprite, as in #R$B317.
  $B3DB,$03 Is the bottom of the sprite on or above the bottom of the play
. window (#N$30)?
  $B3DE,$02 Jump to #R$B401 if so.
  $B3E0,$01 Keep the y position.
  $B3E1,$01 Fetch the height of the sprite.
  $B3E2,$01 Add the y position to get the top of the sprite.
  $B3E3,$02 Is the top of the sprite below the bottom of the play window?
  $B3E5,$01 Return if it is, as the sprite is not visible at all.
  $B3E6,$02 Work out how many rows of the sprite are below the play window.
  $B3E8,$01 Subtract the y position from the bottom of the play window.
  $B3E9,$01 Keep that number of rows.
  $B3EA,$01 Fetch the height of the sprite.
  $B3EB,$01 Take away the number of rows that are cut off.
  $B3EC,$01 Return if nothing is left.
  $B3ED,$03 Store the number of rows that are left to be drawn.
  $B3F0,$01 Save the number of rows that are cut off.
  $B3F1,$03 Fetch the width of the sprite in bytes.
  $B3F4,$01 Use it as a counter.
  $B3F5,$02 Start the total at zero, and clear the high byte of #REGhl.
@ $B3F7 label=DrawSprite_Aligned_Multiply
  $B3F7,$03 Add the number of rows that were cut off to the total, once for each
. byte of the width, to multiply them.
  $B3FA,$01 Keep the size of the hidden rows.
  $B3FB,$01 Double it, as each byte of the width has a pair of bytes of data.
  $B3FC,$01 Add the address of the sprite to give the address of the first
. visible row of data.
  $B3FD,$01 Keep the address of the first visible row.
  $B3FE,$01 Restore #REGhl.
  $B3FF,$02 Start drawing from the bottom of the play window.
@ $B401 label=DrawSprite_Aligned_Clip
  $B401,$03 Find the address in the buffer of the first byte to draw, using
. #R$B48E.
  $B404,$04 Save the stack pointer.
  $B408,$03 Point the stack pointer at the sprite, so that POP fetches the data.
  $B40B,$01 Take it past the height byte, to the first pair of data bytes.
N $B40C Clip the top of the sprite, as in #R$B349.
  $B40C,$03 Fetch the y position.
  $B40F,$05 Jump to #R$B3AE to finish if it is, as the sprite is not visible.
  $B414,$01 Keep the y position.
  $B415,$03 Fetch the number of rows to draw.
  $B418,$01 Add the y position to get the top of the sprite.
  $B419,$02 Subtract the top of the play window.
  $B41B,$02 Jump if the sprite does not reach above the top of the play window.
  $B41D,$01 Keep the number of rows that are cut off.
  $B41E,$01 Fetch the height of the sprite.
  $B41F,$01 Take the cut off rows away from the number of rows to draw.
  $B420,$03 Store the number of rows to be drawn.
@ $B423 label=DrawSprite_Aligned_Rows
  $B423,$03 Fetch the number of rows to be drawn.
  $B426,$02 Move the buffer address into #REGhl.
  $B428,$02 Switch to the shadow registers, and keep the number of rows to draw
. in #REGb'.
@ $B42A label=DrawSprite_Aligned_Row
  $B42A,$01 Switch back to the main registers.
@ $B42B label=DrawSprite_Aligned_Jump
  $B42B,$03 Jump into the unrolled loop.
N $B42E The unrolled loop that draws one row of a sprite on a byte boundary.
. #REGhl points at the buffer and each pair of data bytes is fetched into
. #REGde: the OR byte (#REGe) is ORed onto the buffer byte and the XOR byte
. (#REGd) is XORed onto the result.
@ $B42E label=DrawSprite_Unrolled
  $B42E,$06 Merge the first pair of data bytes with the buffer byte and move on.
  $B434,$06 Merge the second pair of data bytes with the buffer byte and move
. on.
  $B43A,$06 Merge the third pair of data bytes with the buffer byte and move on.
  $B440,$05 Merge the fourth pair of data bytes with the buffer byte.
N $B445 Move up to the start of the previous row of the buffer.
  $B445,$03 Subtract the number of bytes to step back (the operand of this
. instruction is modified) from the low byte of the buffer address.
  $B448,$01 Keep the result.
  $B449,$04 Take a carry from the high byte if there was a borrow.
@ $B44D label=DrawSprite_Aligned_Next
  $B44D,$01 Switch to the shadow registers, where #REGb' holds the number of
. rows left to draw.
  $B44E,$02 Loop back until every row of the sprite has been drawn.
  $B450,$03 Jump to #R$B3AE.

c $B453 Flip Sprite
@ $B453 label=FlipSprite
D $B453 Flips a sprite in place, so that it is stored facing the other way, if
. the way it is stored does not match the direction of the entity being drawn.
. Each row of the sprite has its pairs of bytes put in the opposite order and
. each byte is reversed using the table at #R$F000.
R $B453 DE Address of the sprite header
R $B453 IX Draw list entry
  $B453,$01 Save the address of the sprite.
  $B454,$01 Fetch the header flags of the sprite.
  $B455,$03 Compare bit 7 with bit 7 of the type of the sprite being drawn.
  $B458,$02 Keep only bit 7.
  $B45A,$02 Jump to #R$B48C if the sprite is already facing the right way.
  $B45C,$01 Fetch the width byte of the header.
  $B45D,$02 Toggle bit 7, as the sprite is being flipped.
  $B45F,$01 Store it.
  $B460,$02 Keep the width in bytes.
  $B462,$02 Use it as the counter for the pairs in a row, and keep a copy in
. #REGc.
  $B464,$01 Point #REGde at the height.
  $B465,$01 Fetch the height.
  $B466,$01 Keep the height, to count the rows.
  $B467,$01 Point #REGde at the first row of data.
  $B468,$01 Point #REGhl at it.
  $B469,$01 Take a copy of the address.
  $B46A,$02 Switch to the shadow registers and make #REGhl' the source pointer.
  $B46C,$02 Set #REGb' to the page of the table of reversed bytes.
  $B46E,$01 Switch back.
@ $B46F label=FlipSprite_Row
  $B46F,$01 Switch to the shadow registers.
  $B470,$01 Fetch the OR byte of the pair.
  $B471,$01 Look up the byte with its bits reversed.
  $B472,$01 Keep the reversed OR byte.
  $B473,$01 Move on to the XOR byte.
  $B474,$01 Fetch the XOR byte of the pair.
  $B475,$01 Look up the byte with its bits reversed.
  $B476,$01 Keep the reversed XOR byte.
  $B477,$01 Move on to the next pair.
  $B478,$01 Save the reversed pair on the stack.
  $B479,$01 Switch back to the main registers.
  $B47A,$02 Loop back until every pair in the row has been saved.
  $B47C,$01 Set the counter to the number of pairs in a row.
@ $B47D label=FlipSprite_Write
  $B47D,$01 Take a pair off the stack, so that the last pair of the row comes
. first.
  $B47E,$01 Write the reversed OR byte.
  $B47F,$01 Move on.
  $B480,$01 Write the reversed XOR byte.
  $B481,$01 Move on to the next pair.
  $B482,$02 Loop back until the row has been written back.
  $B484,$01 Fetch the row counter.
  $B485,$01 Decrease it by one.
  $B486,$02 Jump to #R$B48C if every row has been flipped.
  $B488,$01 Store the row counter again.
  $B489,$01 Set the counter to the number of pairs in a row.
  $B48A,$02 Jump back to flip the next row.
@ $B48C label=FlipSprite_Done
  $B48C,$01 Restore the address of the sprite.
  $B48D,$01 Return.

c $B48E Get Buffer Address
@ $B48E label=GetBufferAddress
D $B48E Finds the address in the play window buffer of the byte that holds a
. given pixel position. The address is #N$F400 plus #N$18 times (#N$AF minus the
. y position) plus the x position divided by #N$08.
R $B48E B y position
R $B48E C x position
R $B48E O:BC Address in the buffer
  $B48E,$01 Save #REGhl.
  $B48F,$01 Save the x position.
  $B490,$06 Take the y position, subtract #N$20 and flip the bits (which is the
. same as taking it away from #N$11F), then add #N$90 to give #N$AF minus the y
. position.
  $B496,$03 Put the result in #REGhl.
  $B499,$02 Copy it into #REGbc.
  $B49B,$05 Multiply by #N$18: double it, add the original, then double three
. times.
  $B4A0,$01 Restore the x position into #REGc.
  $B4A1,$01 Clear the high byte of the x position.
  $B4A2,$06 Divide the x position by #N$08.
  $B4A8,$01 Add it to the offset.
  $B4A9,$04 Add the base of the buffer.
  $B4AD,$02 Put the address into #REGbc.
  $B4AF,$01 Restore #REGhl.
  $B4B0,$01 Return.

c $B4B1 Negate HL
@ $B4B1 label=NegateHL
D $B4B1 Negates #REGhl. This routine is not used.
E $B4B1 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D01B }
. { #NIGHTSHADE$E0DD }
. { #TRANZAM$6BF6 }
. { #LUNARJETMAN$8947 }
. LIST#
R $B4B1 HL The word
R $B4B1 O:HL The negative of the word
N $B4B1 Invert both bytes, then add one.
  $B4B1,$03 Invert the low byte.
  $B4B4,$03 Invert the high byte.
  $B4B7,$01 Add one.
  $B4B8,$01 Return.

c $B4B9 Draw Panel
@ $B4B9 label=DrawPanel
D $B4B9 Draws the panel on the right of the screen, which holds the score, the
. hi-score and the sector map. It is #N$08 characters wide and #N$0F characters
. tall, and is built from the characters at #R$9511 using the graphics at
. #R$9421, and coloured using the attributes at #R$9589.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SCR$02(draw-panel-before)
. | #SIM(start=$98EF,stop=$98F2)
. #SCR$02(draw-panel-after) } UDGTABLE# #POPS
  $B4B9,$03 Point #REGhl at the user interface graphics.
  $B4BC,$03 Use them as the current character set.
  $B4BF,$03 Point #REGde at #R$9511.
  $B4C2,$03 The panel is #N$08 characters wide (#REGb) and #N$0F rows tall
. (#REGc).
  $B4C5,$03 Point #REGhl at the top left of the panel, in column #N$18 of the
. display file.
  $B4C8,$03 Print the characters of the panel using #R$B4E6.
  $B4CB,$03 The panel is #N$08 characters wide (#REGb) and #N$0F rows tall
. (#REGc).
  $B4CE,$03 Point #REGhl at the top left of the panel, in column #N$18 of the
. attribute file.
  $B4D1,$03 Point #REGde at #R$9589.
@ $B4D4 label=DrawPanel_Row
  $B4D4,$01 Save the dimensions.
  $B4D5,$01 Save the address of the start of the row.
@ $B4D6 label=DrawPanel_Attribute
  $B4D6,$06 Copy an attribute into the attribute file and move on to the next
. column, until the row is done.
  $B4DC,$01 Restore the address of the start of the row.
  $B4DD,$04 Move down to the next row of attributes.
  $B4E1,$01 Restore the dimensions.
  $B4E2,$01 Decrease the row counter by one.
  $B4E3,$02 Loop back until every row of the panel has been coloured.
  $B4E5,$01 Return.

c $B4E6 Print Character Block
@ $B4E6 label=PrintCharacterBlock
D $B4E6 Prints a rectangle of characters.
R $B4E6 DE Address of the character codes
R $B4E6 HL Screen address of the top left
R $B4E6 B Width in characters
R $B4E6 C Height in characters
  $B4E6,$01 Save the dimensions.
  $B4E7,$01 Save the screen address of the start of the row.
@ $B4E8 label=PrintCharacterBlock_Character
  $B4E8,$02 Fetch the next character code.
  $B4EA,$03 Print it using #R$B5CB.
  $B4ED,$02 Loop back until a row of characters has been printed.
  $B4EF,$01 Restore the screen address of the start of the row.
  $B4F0,$03 Move down to the next character row using #R$B6B2.
  $B4F3,$01 Restore the dimensions.
  $B4F4,$01 Decrease the row counter by one.
  $B4F5,$02 Loop back until every row has been printed.
  $B4F7,$01 Return.

c $B4F8 Print Big Digit
@ $B4F8 label=PrintBigDigit
D $B4F8 Prints a digit that is two characters tall, using the digit graphics at
. #R$6003.
R $B4F8 A Digit (#N$00 to #N$09)
R $B4F8 HL Screen address
R $B4F8 O:HL Screen address of the next column
  $B4F8,$01 Save the screen address.
  $B4F9,$01 Double the digit, to give the number of the top half of the digit.
  $B4FA,$01 Save the number.
  $B4FB,$03 Print the top half of the digit using #R$B5CB.
  $B4FE,$01 Move back to the column of the digit.
  $B4FF,$03 Move down to the next character row using #R$B6B2.
  $B502,$01 Restore the number of the top half.
  $B503,$01 Move on to the bottom half of the digit.
  $B504,$03 Print the bottom half of the digit.
  $B507,$01 Restore the original screen address.
  $B508,$01 Move on to the next column.
  $B509,$01 Return.

c $B50A Print Double Height Character
@ $B50A label=PrintDoubleHeightCharacter
D $B50A Prints a character with every pixel row drawn twice, so that it is two
. characters tall.
R $B50A A Character code (bit 7 is ignored)
R $B50A HL Screen address
R $B50A DE Pointer to the next character of the text
R $B50A O:DE Pointer to the following character of the text
R $B50A O:HL Screen address of the next column
  $B50A,$01 Save the pointer into the text.
  $B50B,$01 Save the screen address.
  $B50C,$04 Fetch the address of the current character set.
  $B510,$06 Multiply the character code by #N$08 (by doubling it and then
. multiplying it by four), ignoring bit 7.
  $B516,$01 Add the address of the character set.
  $B517,$01 Point #REGde at the graphics of the character.
  $B518,$01 Restore the screen address.
  $B519,$01 Save it again.
  $B51A,$02 There are #N$08 pixel rows in a character.
@ $B51C label=PrintDoubleHeightCharacter_Row
  $B51C,$01 Fetch a pixel row of the character.
  $B51D,$01 Write it to the screen.
  $B51E,$01 Keep a copy.
  $B51F,$03 Move down to the next pixel row using #R$B558.
  $B522,$01 Write the pixel row again.
  $B523,$03 Move down to the next pixel row.
  $B526,$01 Move on to the next pixel row of the character.
  $B527,$02 Loop back until the whole character has been printed.
  $B529,$01 Restore the screen address.
  $B52A,$01 Restore the pointer into the text.
  $B52B,$01 Move on to the next character of the text.
  $B52C,$01 Move on to the next column.
  $B52D,$01 Return.

c $B52E Print Double Height Text
@ $B52E label=PrintDoubleHeightText
D $B52E Prints a string of text that is two characters tall. The string starts
. with an attribute byte, and its last character has bit 7 set.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$9901,stop=$9904)
. #SCR$02(print-double-height-before)
. | #SIM(start=$B8B3,stop=$B8C2)
. #SCR$02(print-double-height-after) } UDGTABLE# #POPS
R $B52E HL Position (#REGh is y, #REGl is x, in pixels)
R $B52E DE Address of the string
  $B52E,$01 Save the position.
  $B52F,$03 Find the address of the attributes at that position using #R$BD6A.
  $B532,$01 Fetch the attribute from the start of the string.
  $B533,$01 Move on to the first character.
  $B534,$01 Keep the attribute.
  $B535,$02 The text is two characters tall.
@ $B537 label=PrintDoubleHeightText_Attributes
  $B537,$01 Save the pointer to the text.
  $B538,$01 Save the attribute address.
@ $B539 label=PrintDoubleHeightText_Attribute
  $B539,$01 Colour the current cell.
  $B53A,$01 Fetch the next character code.
  $B53B,$01 Move on.
  $B53C,$01 Move on to the next column.
  $B53D,$02 Test whether it was the last character of the text.
  $B53F,$02 Loop back until the whole row has been coloured.
  $B541,$01 Restore the attribute address.
  $B542,$04 Move down to the next row.
  $B546,$01 Restore the pointer to the text.
  $B547,$02 Loop back to colour the second row.
  $B549,$01 Restore the position.
  $B54A,$03 Find the screen address using #R$BD4B.
@ $B54D label=PrintDoubleHeightText_Character
  $B54D,$01 Fetch the next character code.
  $B54E,$05 Jump to #R$B50A to print the last character.
  $B553,$03 Print the character using #R$B50A.
  $B556,$02 Jump back to print the next character.

c $B558 Next Pixel Row
@ $B558 label=NextPixelRow
D $B558 Moves down by one pixel row in the display file.
R $B558 HL Screen address
R $B558 O:HL Screen address one pixel row down
  $B558,$01 Move down one pixel row within the character.
  $B559,$03 Test whether that has moved into the next character row.
  $B55C,$01 Return if it has not.
  $B55D,$04 Move back to the top pixel row of the character.
  $B561,$04 Move down by one character row.
  $B565,$01 Return if that did not move into the next third of the display.
  $B566,$04 Otherwise move on to the next third.
  $B56A,$01 Return.

c $B56B Print Hi-Score
@ $B56B label=PrintHiScore
D $B56B Prints the hi-score in big digits, in the panel on the right of the
. screen. The hi-score is the first entry in the table of high scores at
. #R$B7C6.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SCR$02(print-hiscore-before)
. | #SIM(start=$98F5,stop=$98F8)
. #SCR$02(print-hiscore-after) } UDGTABLE# #POPS
  $B56B,$03 Point #REGhl at the display file position of the hi-score.
  $B56E,$03 Point #REGde at #R$B7C6.
  $B571,$02 Print it using #R$B58B.

c $B573 Add Points To Score
@ $B573 label=AddPointsToScore
D $B573 Adds points to the score of the player and then prints the new score.
. The score is stored as six decimal digits in three bytes.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #SCR$02(add-points-before)
. | #SIM(start=$B573,stop=$B5CA,bc=$0550)
. #SCR$02(add-points-after) } UDGTABLE# #POPS
E $B573 View the equivalent code in;
. #LIST
. { #ATICATAC$A19C }
. { #BUBBLER$9662 }
. { #COOKIE$7415 }
. { #CYBERUN$925E }
. { #JETPAC$70F9 }
. { #LUNARJETMAN$899C }
. { #NIGHTSHADE$C2ED }
. { #PENTAGRAM$BB29 }
. { #PSSST$737A }
. { #SABREWULF$B5A9 }
. { #TRANZAM$6046 }
. { #UNDERWURLDE$A045 }
. LIST#
R $B573 B Points to add (the hundreds and thousands digits)
R $B573 C Points to add (the units and tens digits)
E $B573 Continue on to #R$B585.
  $B573,$03 Point #REGhl at the least significant byte of the score.
  $B576,$03 Add the units and tens.
  $B579,$01 Store the result.
  $B57A,$01 Move on to the middle byte of the score.
  $B57B,$03 Add the hundreds and thousands, plus the carry.
  $B57E,$01 Store the result.
  $B57F,$01 Move on to the most significant byte of the score.
  $B580,$04 Add the carry.
  $B584,$01 Store the result.

c $B585 Print Score
@ $B585 label=PrintScore
D $B585 Prints the score of the player in big digits, in the panel on the right
. of the screen.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SCR$02(print-score-before)
. | #SIM(start=$98F2,stop=$98F5)
. #SCR$02(print-score-after) } UDGTABLE# #POPS
  $B585,$03 Point #REGhl at the display file position of the score.
  $B588,$03 Point #REGde at #R$961B.
@ $B58B label=PrintScore_Digits
  $B58B,$02 There are #N$03 bytes of the number to print, which makes six
. digits.
  $B58D,$02 Print the number using #R$B5AF.

c $B58F Print Small Number
@ $B58F label=PrintSmallNumber
D $B58F Prints a number stored as three BCD bytes using the normal character
. set, which is used in the hall of fame.
R $B58F DE Address of the number
R $B58F HL Screen address
R $B58F O:DE Address after the number
R $B58F O:HL Screen address after the number
  $B58F,$01 Save the screen address.
  $B590,$03 Fetch the address of the character set.
  $B593,$03 Use it as the current character set.
  $B596,$01 Restore the screen address.
@ $B597 label=PrintSmallNumber_Byte
  $B597,$01 Fetch a byte of the number.
  $B598,$04 Move the tens digit down into the bottom four bits.
  $B59C,$02 Keep only that digit.
  $B59E,$02 Convert it to the character code of the digit.
  $B5A0,$03 Print it using #R$B5CB.
  $B5A3,$01 Fetch the byte again.
  $B5A4,$02 Keep only the units digit.
  $B5A6,$02 Convert it to the character code of the digit.
  $B5A8,$03 Print it.
  $B5AB,$01 Move on to the next byte of the number.
  $B5AC,$02 Loop back until all of the bytes have been printed.
  $B5AE,$01 Return.

c $B5AF Print Big Number
@ $B5AF label=PrintBigNumber
D $B5AF Prints a number stored as BCD bytes using big digits, which are two
. characters tall.
E $B5AF View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BA62 }
. { #NIGHTSHADE$C314 }
. { #PENTAGRAM$BB48 }
. LIST#
R $B5AF B Number of bytes of the number
R $B5AF DE Address of the number
R $B5AF HL Screen address
R $B5AF O:DE Address after the number
  $B5AF,$01 Save the screen address.
  $B5B0,$03 Point #REGhl at #R$6003.
  $B5B3,$03 Use them as the current character set.
  $B5B6,$01 Restore the screen address.
@ $B5B7 label=PrintBigNumber_Byte
  $B5B7,$01 Fetch a byte of the number.
  $B5B8,$04 Move the upper digit down into the bottom four bits.
  $B5BC,$02 Keep only that digit.
  $B5BE,$03 Print it using #R$B4F8.
  $B5C1,$01 Fetch the byte again.
  $B5C2,$02 Keep only the lower digit.
  $B5C4,$03 Print it.
  $B5C7,$01 Move on to the next byte of the number.
  $B5C8,$02 Loop back until every byte has been printed.
  $B5CA,$01 Return.

c $B5CB Print Character
@ $B5CB label=PrintScreen
D $B5CB Prints a single character to the display file, at a character position.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #POKES$5C36,$00;$5C37,$3C;$9618,$00
. #POKES$9619,$3C
. #SIM(start=$9901,stop=$9904)
. #SCR$02(print-character-before)
. | #SIM(start=$B5CB,stop=$B5EA,a=$004D,hl=$480E)
. #SCR$02(print-character-after) } UDGTABLE# #POPS
E $B5CB View the equivalent code in;
. #LIST
. { #ATICATAC$A1D3 }
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #NIGHTSHADE$CB19 }
. { #PSSST$73CD }
. { #SABREWULF$B589 }
. { #TRANZAM$6C96 }
. { #UNDERWURLDE$98DF }
. LIST#
R $B5CB A Character code
R $B5CB HL Screen address
R $B5CB O:HL Screen address of the next column
  $B5CB,$03 Save the registers.
  $B5CE,$06 Multiply the character code by #N($08), using doubling.
  $B5D4,$05 Add the address of the current character set.
  $B5D9,$01 Point #REGde at the graphics of the character.
  $B5DA,$01 Restore the screen address.
  $B5DB,$02 There are #N$08 pixel rows in a character.
@ $B5DD label=PrintScreen_Row
  $B5DD,$01 Fetch a pixel row of the character.
  $B5DE,$01 Write it to the screen.
  $B5DF,$01 Move on to the next pixel row of the character.
  $B5E0,$01 Move down to the next pixel row on the screen.
  $B5E1,$02 Loop back until the whole character has been printed.
  $B5E3,$02 Restore the registers.
  $B5E5,$04 Move back up to the top of the character.
  $B5E9,$01 Move on to the next column.
  $B5EA,$01 Return.

c $B5EB Draw Border
@ $B5EB label=DrawBorder
D $B5EB Draws the decorative frame that surrounds the play window and the screen
. text: two rings of beads, one inside the other, each made of two characters
. that alternate. The frame is #N$18 characters wide and #N$18 characters tall,
. and the attributes are bright blue.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SCR$02(draw-border-before)
. | #SIM(start=$98EC,stop=$98EF)
. #SCR$02(draw-border-after) } UDGTABLE# #POPS
  $B5EB,$03 Point #REGhl at the border graphics.
  $B5EE,$03 Use them as the current character set.
N $B5F1 Draw the outer ring of beads, which uses characters #N$00 and #N$01.
  $B5F1,$03 Point #REGhl at the top left of the display file.
  $B5F4,$03 The top row is #N$18 characters wide (#REGb) and starts with
. character #N$01 (#REGc).
  $B5F7,$03 Draw the top row using #R$B6A6.
  $B5FA,$03 Point #REGhl at the start of the bottom row, in the last character
. row.
  $B5FD,$03 The bottom row is #N$18 characters wide (#REGb) and starts with
. character #N$00 (#REGc).
  $B600,$03 Draw the bottom row.
  $B603,$03 Point #REGhl at the left column, on the second character row.
  $B606,$03 The column is #N$16 characters tall (#REGb) and starts with
. character #N$00 (#REGc).
  $B609,$03 Draw the left column using #R$B696.
  $B60C,$03 Point #REGhl at the right column, on the second character row.
  $B60F,$03 The column is #N$16 characters tall (#REGb) and starts with
. character #N$01 (#REGc).
  $B612,$03 Draw the right column.
N $B615 Draw the inner ring of beads, which uses characters #N$02 and #N$03.
  $B615,$03 Point #REGhl at the start of the second character row, one column
. in.
  $B618,$03 The row is #N$16 characters long (#REGb) and starts with character
. #N$03 (#REGc).
  $B61B,$03 Draw the second row.
  $B61E,$03 Point #REGhl at the start of the last but one character row, one
. column in.
  $B621,$02 The row is #N$16 characters long.
  $B623,$03 Draw it.
  $B626,$03 Point #REGhl at the second column, on the third character row.
  $B629,$02 The column is #N$14 characters tall.
  $B62B,$03 Draw it using #R$B696.
  $B62E,$03 Point #REGhl at the second to last column, on the third character
. row.
  $B631,$02 The column is #N$14 characters tall.
  $B633,$03 Draw it.
N $B636 Colour the frame.
  $B636,$02 Use #N$48 (bright, black ink on blue paper) for the top left and
. bottom left corners.
  $B638,$03 Write the attribute to the top left corner.
  $B63B,$03 Write the attribute to the bottom left corner.
  $B63E,$02 Use #N$41 (bright, blue ink on black paper) for the top right and
. bottom right corners.
  $B640,$03 Write the attribute to the top right corner.
  $B643,$03 Write the attribute to the bottom right corner.
  $B646,$03 Point #REGhl at the top row, after the corner.
  $B649,$03 The row is #N$16 attributes long (#REGb) and the attribute is #N$49
. (bright, blue ink on blue paper) (#REGc).
  $B64C,$03 Colour the top row using #R$B689.
  $B64F,$03 Point #REGhl at the bottom row, after the corner.
  $B652,$02 The row is #N$16 attributes long.
  $B654,$03 Colour the bottom row.
  $B657,$03 Point #REGhl at the left column, below the corner.
  $B65A,$02 The column is #N$16 attributes tall.
  $B65C,$03 Colour the left column using #R$B68E.
  $B65F,$03 Point #REGhl at the right column, below the corner.
  $B662,$02 The column is #N$16 attributes tall.
  $B664,$03 Colour the right column.
  $B667,$03 Point #REGhl at the second row, one column in.
  $B66A,$03 The row is #N$16 attributes long (#REGb) and the attribute is #N$48
. (#REGc).
  $B66D,$03 Colour the second row.
  $B670,$03 Point #REGhl at the last but one row, one column in.
  $B673,$02 The row is #N$16 attributes long.
  $B675,$03 Colour it.
  $B678,$03 Point #REGhl at the second column, on the third row.
  $B67B,$02 The column is #N$14 attributes tall.
  $B67D,$03 Colour it.
  $B680,$03 Point #REGhl at the second to last column, on the third row.
  $B683,$02 The column is #N$14 attributes tall.
  $B685,$03 Colour it.
  $B688,$01 Return.

c $B689 Fill Attribute Row
@ $B689 label=FillAttributeRow
D $B689 Writes an attribute to a run of cells along a row of the attribute file.
R $B689 HL Address of the first cell
R $B689 B Number of cells
R $B689 C Attribute
  $B689,$01 Write the attribute.
  $B68A,$01 Move on to the next cell.
  $B68B,$02 Loop back until all of the cells have been filled.
  $B68D,$01 Return.

c $B68E Fill Attribute Column
@ $B68E label=FillAttributeColumn
D $B68E Writes an attribute to a run of cells down a column of the attribute
. file.
R $B68E HL Address of the first cell
R $B68E B Number of cells
R $B68E C Attribute
  $B68E,$03 Set the distance to the next row to #N$20.
@ $B691 label=FillAttributeColumn_Loop
  $B691,$01 Write the attribute.
  $B692,$01 Move down to the next row.
  $B693,$02 Loop back until all of the cells have been filled.
  $B695,$01 Return.

c $B696 Print Border Column
@ $B696 label=PrintBorderColumn
D $B696 Prints a column of border characters, alternating between two
. characters.
R $B696 HL Screen address of the top
R $B696 B Number of characters
R $B696 C Character code (bit 0 is flipped each time)
  $B696,$01 Fetch the character code.
  $B697,$02 Switch to the other character of the pair.
  $B699,$01 Keep it.
  $B69A,$01 Save the counters.
  $B69B,$03 Print the character using #R$B5CB.
  $B69E,$01 Move back to the column of the character.
  $B69F,$03 Move down to the next character row using #R$B6B2.
  $B6A2,$01 Restore the counters.
  $B6A3,$02 Loop back until the whole column has been printed.
  $B6A5,$01 Return.

c $B6A6 Print Border Row
@ $B6A6 label=PrintBorderRow
D $B6A6 Prints a row of border characters, alternating between two characters.
R $B6A6 HL Screen address of the left end
R $B6A6 B Number of characters
R $B6A6 C Character code (bit 0 is flipped each time)
  $B6A6,$01 Fetch the character code.
  $B6A7,$02 Switch to the other character of the pair.
  $B6A9,$01 Keep it.
  $B6AA,$01 Save the counters.
  $B6AB,$03 Print the character using #R$B5CB.
  $B6AE,$01 Restore the counters.
  $B6AF,$02 Loop back until the whole row has been printed.
  $B6B1,$01 Return.

c $B6B2 Move Down Row
@ $B6B2 label=MoveDownRow
D $B6B2 Moves down by one character row in the display file.
E $B6B2 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$D64F }
. { #NIGHTSHADE$CB71 }
. { #UNDERWURLDE$98D5 }
. LIST#
R $B6B2 HL Screen address
R $B6B2 O:HL Screen address one character row down
  $B6B2,$04 Add #N$20 to the low byte of the address.
  $B6B6,$01 Return if that did not move into the next third of the display.
  $B6B7,$04 Otherwise move on to the next third.
  $B6BB,$01 Return.

c $B6BC Lose Life
@ $B6BC label=LoseLife
D $B6BC Called when the robot has been destroyed. If there are no lives left
. then the game is over. Otherwise a life is taken away, the battery is
. recharged and the robot starts to materialise again.
R $B6BC IX Pointer to the robot (entity #N$00)
  $B6BC,$03 This load has no effect, as #REGa is replaced immediately.
  $B6BF,$03 Fetch the number of lives left.
  $B6C2,$01 Test whether there are any.
  $B6C3,$03 Jump to #R$9AA5 if there are none, as the game is over.
N $B6C6 See #POKE(infinite_lives,Infinite Lives).
  $B6C6,$03 Point #REGhl at #R$968B.
  $B6C9,$01 Take away a life.
  $B6CA,$03 Recharge the battery and show the number of lives left using
. #R$A091.
  $B6CD,$04 Set the type of the robot to #N($40), the start of the sequence of
. sprites that shows it materialising.
  $B6D1,$01 Return.

c $B6D2 Show Game Over
@ $B6D2 label=ShowGameOver
D $B6D2 Clears the play window and shows "GAME  OVER" followed by the number of
. the player, then waits for a while.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #POKES$5C36,$00;$5C37,$3C
. #SCR$02(game-over-before)
. | #SIM(start=$B6D2,stop=$B6EA)
. #SCR$02(game-over-after) } UDGTABLE# #POPS
E $B6D2 The entry point at #R$B6F7 would show "PLAYER 2". It is not used, and
. nor is #R$B6FB, as the game only has a single player.
  $B6D2,$02 Use the "1" of "PLAYER 1" as the last character of the text.
@ $B6D4 label=ShowGameOver_Player
  $B6D4,$03 Write it as the last character of the second text message.
  $B6D7,$01 Use black as the attribute.
  $B6D8,$03 Clear the play window to black using #R$B217.
  $B6DB,$03 Point #REGde at #R$B717.
  $B6DE,$03 Point #REGhl at the position of the message (x position #N($38), y
. position #N$40).
  $B6E1,$03 Print it using #R$BD99.
  $B6E4,$03 Point #REGhl at the position of the second message (x position
. #N($40), y position #N$50).
  $B6E7,$03 Print "PLAYER 1" using #R$BD99.
  $B6EA,$05 Delay for #N$08 times #N$010000 iterations.
  $B6EF,$03 Delay using #R$BD32.
  $B6F2,$02 Use bright white on black as the attribute.
  $B6F4,$03 Jump to #R$B1C2.
N $B6F7 This entry point is not used. It shows "PLAYER 2" instead.
@ $B6F7 label=ShowGameOver_Player2
  $B6F7,$02 Use the "2" of "PLAYER 2" as the last character of the text.
  $B6F9,$02 Jump to #R$B6D4.
N $B6FB This entry point is not used.
@ $B6FB label=ShowGameOver_Unused
  $B6FB,$02 Jump to #R$B6D2.

c $B6FD Game Over
@ $B6FD label=GameOver
D $B6FD Ends the game. The game over message is shown and then the high score
. table is updated. If the player has earned a place in the table the hall of
. fame is shown, and then the game restarts from the title screen.
N $B6FD Show the game over message.
  $B6FD,$03 Show the game over message using #R$B6D2.
  $B700,$03 Draw the border around the screen using #R$B5EB.
  $B703,$02 Use bright white on black as the attribute.
  $B705,$03 Clear the large window using #R$B212.
N $B708 Update the high score table.
  $B708,$03 Insert the score into the high score table, if it is high enough,
. using #R$B958.
  $B70B,$03 Fetch the flag that is set if a name was entered in the table.
  $B70E,$01 Test whether it is set.
  $B70F,$02 Jump to #R$B714 if not.
  $B711,$03 Show the hall of fame using #R$B76C.
N $B714 Go back to the title screen.
@ $B714 label=GameOver_Title
  $B714,$03 Jump to #R$98EF to go back to the title screen.

t $B717 Messaging: Game Over
@ $B717 label=Message_GameOver
D $B717 The text of the game over message. Each message starts with an attribute
. byte and its last character has bit 7 set. The number of the player in the
. second message is modified by #R$B6D4.
  $B717,$0B,h$01,$09:$01 Attribute: #COLOUR(#PEEK(#PC)) + "GAME  OVER".
@ $B722 label=Message_Player
  $B722,$09,h$01,$07:$01 Attribute: #COLOUR(#PEEK(#PC)) + "PLAYER " and the
. number of the player.

c $B72B Start Game
@ $B72B label=StartGame
D $B72B Starts a new game. The lives are set, the play window is cleared, the
. robot starts its first life and both scores are cleared.
  $B72B,$03 Set the number of lives using #R$B74D.
  $B72E,$05 Set a variable that is never used to #N$80.
  $B733,$05 Clear the play window to bright cyan on black using #R$B217.
  $B738,$03 Start the first life using #R$A99F.
  $B73B,$03 Point #REGhl at #R$961B.
  $B73E,$02 There are six bytes to clear.
@ $B740 label=StartGame_Clear
  $B740,$02 Clear a byte of the scores.
  $B742,$01 Move on to the next byte.
  $B743,$02 Loop back until both scores have been cleared.
  $B745,$03 Print the score using #R$B585.
  $B748,$01 Clear the displayed battery level...
  $B749,$03 ...so that the battery bar is redrawn from the start.
  $B74C,$01 Return.

c $B74D Reset Lives
@ $B74D label=ResetLives
D $B74D Gives the player five lives, and sets the robot to face its starting
. direction.
  $B74D,$05 Set the number of lives to five.
  $B752,$04 Clear the number of the player.
  $B756,$03 Jump to #R$A127.

c $B759 Reset Idle Timer
@ $B759 label=ResetIdleTimer
D $B759 Sets the timer that is used to show the hall of fame while the menu is
. being shown.
  $B759,$03 Use a timer of #N$0300 frames...
  $B75C,$03 ...and store it.
  $B75F,$01 Return.

c $B760 Update Idle Timer
@ $B760 label=UpdateIdleTimer
D $B760 Counts down the idle timer. If it reaches zero then the hall of fame is
. shown, until a key is pressed. The timer is reset if the zero flag is not set
. when this routine is called.
E $B760 Continue on to #R$B76C.
E $B760 View the equivalent code in;
. #LIST
. { #SABREWULF$B272 }
. LIST#
R $B760 F The zero flag is reset to reset the timer
  $B760,$02 Jump to reset the timer if the zero flag is not set.
  $B762,$03 Fetch the timer...
  $B765,$01 ...take one off...
  $B766,$03 ...and store it.
  $B769,$03 Return if the timer has not reached zero.

c $B76C Handler: Hall Of Fame
@ $B76C label=HandlerHallOfFame
D $B76C Shows the hall of fame, and waits for a key to be pressed or for a delay
. to run out. Then the menu is drawn again.
E $B76C View the equivalent code in;
. #LIST
. { #SABREWULF$B272 }
. LIST#
  $B76C,$03 Draw the hall of fame using #R$B78C.
  $B76F,$02 Wait for up to twelve times #N$010000 iterations...
  $B771,$03 Start the inner count at #N$0000.
@ $B774 label=HandlerHallOfFame_Wait
  $B774,$01 Read every row of keys...
  $B775,$03 Read the keyboard.
  $B778,$04 ...and jump to finish if any key is pressed.
  $B77C,$01 Count down the delay.
  $B77D,$04 Loop back until the count has run out...
  $B781,$02 ...and the outer count too.
@ $B783 label=HandlerHallOfFame_Finish
  $B783,$01 Clear the large window to black using #R$B212.
  $B784,$03 Clear the large window.
  $B787,$03 Draw the menu using #R$B8B3.
  $B78A,$02 Jump to reset the idle timer.

c $B78C Show Hall Of Fame
@ $B78C label=HallOfFame
D $B78C Draws the hall of fame: the heading, the eight places of the table, and
. the score and the three letters of the name for each of them.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$9901,stop=$9904)
. #SCR$02(hall-of-fame-before)
. | #SIM(start=$B76C,stop=$B76F)
. #SCR$02(hall-of-fame-after) } UDGTABLE# #POPS
E $B78C View the equivalent code in;
. #LIST
. { #SABREWULF$B29F }
. LIST#
  $B78C,$01 Clear the large window to black using #R$B212.
  $B78D,$03 Clear the large window.
  $B790,$03 Point #REGde' at #R$B7FC.
  $B793,$01 Switch that address into #REGde'.
  $B794,$03 Point #REGhl at #R$B805.
  $B797,$03 Point #REGde at #R$B817.
  $B79A,$02 There are nine lines of text.
  $B79C,$03 Print the heading and the places using #R$B8CE.
  $B79F,$03 There are eight rows of scores...
  $B7A2,$03 ...in the table of the high scores.
  $B7A5,$03 Point #REGhl at the coordinates of the first row.
@ $B7A8 label=HallOfFame_Loop
  $B7A8,$01 Save the counter...
  $B7A9,$01 ...and the coordinates.
  $B7AA,$03 Find the screen address using #R$BD4B.
  $B7AD,$03 Print the score using #R$B58F.
  $B7B0,$02 There are three letters in a name.
  $B7B2,$03 Move on three characters to the right.
@ $B7B5 label=HallOfFame_Initials
  $B7B5,$01 Fetch a letter of the name...
  $B7B6,$01 ...and move on to the next one.
  $B7B7,$03 Print it using #R$B5CB.
  $B7BA,$02 Loop back until all three letters have been printed.
  $B7BC,$01 Restore the coordinates.
  $B7BD,$01 Fetch the Y coordinate...
  $B7BE,$02 ...move down by #N$10 pixels...
  $B7C0,$01 ...and keep it.
  $B7C1,$01 Restore the counter.
  $B7C2,$01 Count down the rows.
  $B7C3,$02 Loop back until all eight rows have been printed.
  $B7C5,$01 Return.

g $B7C6 Hall Of Fame Table
@ $B7C6 label=HallOfFameTable
D $B7C6 The eight places of the hall of fame. Each place is the score, which is
. three bytes of binary coded decimal, followed by the three letters of the
. name. The first entry is also the hi-score that is shown in the panel. The
. last six bytes are the work area that is used by #R$B958.
@ $B7F0 label=HallOfFameTable_LastPlace
B $B7C6,$30,$06 Score and name.
@ $B7F6 label=HallOfFameWork
B $B7F6,$06,$06 Work area.

t $B7FC Messaging: Hall Of Fame Text
@ $B7FC label=HallOfFame_Attributes
D $B7FC The attributes, coordinates and text of the hall of fame, for #R$B8CE.
B $B7FC,$01 #COLOUR(#PEEK(#PC)).
L $B7FC,$01,$09
@ $B805 label=HallOfFame_Coordinates
B $B805,$12,$02 Coordinates of the nine lines of text.
@ $B817 label=HallOfFame_Heading
  $B817,$0C,$0B:$01 "HALL OF FAME".
@ $B823 label=HallOfFame_Places
  $B823,$12,$11:$01 "1ST" and spaces, where the name will be shown.
  $B835,$12,$11:$01 "2ND" and spaces.
  $B847,$12,$11:$01 "3RD" and spaces.
  $B859,$12,$11:$01 "4TH" and spaces.
  $B86B,$12,$11:$01 "5TH" and spaces.
  $B87D,$12,$11:$01 "6TH" and spaces.
  $B88F,$12,$11:$01 "7TH" and spaces.
  $B8A1,$12,$11:$01 "8TH" and spaces.

c $B8B3 Display Menu
@ $B8B3 label=DisplayMenu
D $B8B3 Draws the title and the menu, which shows the keys that choose the
. method of control and the key that starts the game. It also keeps a copy of
. the pointer to the character set.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$9901,stop=$9904)
. #SCR$02(game-menu-before)
. | #SIM(start=$B8B3,stop=$B8E4)
. #SCR$02(game-menu-after) } UDGTABLE#
. #HTML(<div hidden>)
. #SCR$02,$00,$00,$18,$18(screen-frame)
. #HTML(</div>)
. #POPS
E $B8B3 View the equivalent code in;
. #LIST
. { #SABREWULF$B473 }
. LIST#
  $B8B3,$03 Fetch the address of the character set...
  $B8B6,$03 ...and keep it.
  $B8B9,$03 Point #REGhl at the coordinates of the title.
  $B8BC,$03 Point #REGde at #R$B8F7.
  $B8BF,$03 Print it using #R$B52E.
  $B8C2,$03 Point #REGde' at #R$B8E5.
  $B8C5,$01 Switch that address into #REGde'.
  $B8C6,$03 Point #REGhl at #R$B8EB.
  $B8C9,$03 ...and #REGde at the lines of text.
  $B8CC,$02 There are six lines of text.

c $B8CE Print Text List
@ $B8CE label=PrintTextList
D $B8CE Prints a list of lines of text, each with its own attribute and
. coordinates.
R $B8CE B Number of lines
R $B8CE DE' Address of the attributes
R $B8CE HL Address of the coordinates (X and Y in pixels, for each line)
R $B8CE DE Address of the text
  $B8CE,$01 Switch to the attributes.
  $B8CF,$01 Fetch the attribute...
  $B8D0,$03 ...and set it as the colour of the text.
  $B8D3,$01 Move on to the next attribute.
  $B8D4,$01 Switch back to the text.
  $B8D5,$01 Save the counter.
  $B8D6,$01 Fetch the X coordinate.
  $B8D7,$02 Move on to the next coordinates.
  $B8D9,$01 Save the address of the coordinates.
  $B8DA,$01 Go back to the Y coordinate...
  $B8DB,$01 ...and fetch it.
  $B8DC,$01 Put the X coordinate in #REGl.
  $B8DD,$03 Print the text using #R$BD82.
  $B8E0,$01 Restore the address of the coordinates.
  $B8E1,$01 Restore the counter.
  $B8E2,$02 Loop back until all of the lines have been printed.
  $B8E4,$01 Return.

t $B8E5 Messaging: Menu Text
@ $B8E5 label=Menu_Attributes
D $B8E5 The attributes, coordinates and text of the menu.
B $B8E5,$01 #COLOUR(#PEEK(#PC)).
L $B8E5,$01,$06
@ $B8EB label=Menu_Coordinates
B $B8EB,$0C,$02 Coordinates of the six lines of text.
@ $B8F7 label=Message_Title
  $B8F7,$0C,h$01,$0A:$01 Attribute: #COLOUR(#PEEK(#PC)) + "MARTIANOIDS".
@ $B903 label=Menu_Text
  $B903,$0B,$0A:$01 "1  KEYBOARD".
  $B90E,$10,$0F:$01 "2  KEMPSTON UNIT".
  $B91E,$10,$0F:$01 "3  CURSOR   UNIT".
  $B92E,$0F,$0E:$01 "4  INTERFACE II".
  $B93D,$0D,$0C:$01 "0  START GAME".
  $B94A,$0E,$0D:$01 "@ 1987  A.C.G.".

c $B958 New High Score
@ $B958 label=NewHighScore
D $B958 Puts the scores of the two players into the hall of fame, if they are
. high enough, starting with the higher of the two. If a score gets a place then
. the player is asked for their initials.
E $B958 View the equivalent code in;
. #LIST
. { #SABREWULF$B5FC }
. LIST#
  $B958,$03 Point #REGhl at the score of player 1.
  $B95B,$03 Point #REGde at #R$961E.
  $B95E,$03 Compare the scores using #R$B9EE.
  $B961,$05 Clear the flag that says that a name has been entered.
  $B966,$02 Jump to insert player 1 first if the scores are the same...
  $B968,$02 ...or if player 1 has the higher score.
  $B96A,$01 Otherwise swap the scores, so that the higher one is first.
  $B96B,$01 Swap the two scores.
@ $B96C label=NewHighScore_Process
  $B96C,$03 Insert the first score using #R$B970.
  $B96F,$01 Swap the scores back, and insert the other one.

c $B970 Enter High Score
@ $B970 label=NewHighScore_Enter
D $B970 Inserts a score into the hall of fame. The scores of the places that are
. lower than the new score are moved down one place; then the new score is
. shown, and the player is asked for their initials.
E $B970 View the equivalent code in;
. #LIST
. { #SABREWULF$B61E }
. LIST#
R $B970 HL Address of the score
  $B970,$01 Save the address of the other score...
  $B971,$01 ...and the address of this score.
  $B972,$02 There are eight places in the table.
  $B974,$03 Start with the last place.
@ $B977 label=NewHighScore_Enter_Compare
  $B977,$03 Compare the score of the place with the new score using #R$B9EE.
  $B97A,$02 Jump if the place has a score that is as high, or higher.
  $B97C,$03 Move up to the previous place using #R$B9E7.
  $B97F,$02 Loop back until all of the places have been tried.
@ $B981 label=NewHighScore_CountPlaces
  $B981,$01 Fetch the number of places that the score is not as high as.
  $B982,$04 Jump to finish if it is not higher than the last place.
  $B986,$03 Point #REGhl at the last place.
  $B989,$03 Point #REGde at #R$B7F6.
  $B98C,$05 Work out how many places the new score is higher than...
  $B991,$03 ...and keep it.
@ $B994 label=NewHighScore_Enter_Shift
  $B994,$03 Each place is six bytes.
  $B997,$01 Save the address of the place.
  $B998,$02 Copy the place down one place.
  $B99A,$01 Restore the address of the place...
  $B99B,$02 ...and move it into #REGhl.
  $B99D,$03 Move #REGde up to the previous place using #R$B9E7.
  $B9A0,$01 Swap the places, so that #REGhl is the previous place and #REGde is
. the one to copy it to.
  $B9A1,$01 Count down the places.
  $B9A2,$02 Loop back until the places have been moved.
  $B9A4,$01 Fetch the address of the new score...
  $B9A5,$01 ...and save it again.
  $B9A6,$03 The score is three bytes...
  $B9A9,$02 ...so copy it into the place.
  $B9AB,$01 Save the address of the name.
  $B9AC,$03 Show the new hi-score using #R$B56B.
  $B9AF,$05 Set the flag that says that a name has been entered.
  $B9B4,$04 Clear the large window to black using #R$B212.
  $B9B8,$03 Fetch the number of places that the score is higher than...
  $B9BB,$01 ...and keep it in #REGb.
  $B9BC,$02 Start with an offset of minus three...
@ $B9BE label=NewHighScore_MultiplyPlaces
  $B9BE,$02 ...and add three for each place that the score is higher than...
  $B9C0,$02 Count down the places.
  $B9C2,$01 Keep the offset.
  $B9C3,$02 Clear the high byte of the offset.
  $B9C5,$03 Point #REGhl at #R$BA01.
  $B9C8,$01 Add the offset.
  $B9C9,$03 Point #REGde at #R$BAE1.
  $B9CC,$03 The name is three characters.
  $B9CF,$02 Copy it into the message.
  $B9D1,$03 Point #REGde' at #R$BAA5.
  $B9D4,$01 Switch that address into #REGde'.
  $B9D5,$03 Point #REGhl at #R$BAAC.
  $B9D8,$03 Point #REGde at #R$BABA.
  $B9DB,$02 There are seven lines.
  $B9DD,$03 Print the message using #R$B8CE.
  $B9E0,$01 Restore the address of the name.
  $B9E1,$03 Ask for the initials using #R$BA19.
@ $B9E4 label=NewHighScore_Enter_Finish
  $B9E4,$01 Restore the address of the score.
  $B9E5,$01 Restore the address of the other score.
  $B9E6,$01 Return.

c $B9E7 Previous High Score
@ $B9E7 label=NewHighScore_Next
D $B9E7 Moves an address back by one place of the hall of fame.
E $B9E7 View the equivalent code in;
. #LIST
. { #SABREWULF$B6AB }
. LIST#
R $B9E7 DE Address of a place
R $B9E7 O:DE Address of the previous place
  $B9E7,$06 Take six bytes off the address.
  $B9ED,$01 Return.

c $B9EE Compare Scores
@ $B9EE label=NewHighScore_Compare
D $B9EE Compares two scores, which are three bytes of binary coded decimal,
. starting with the most significant byte.
E $B9EE View the equivalent code in;
. #LIST
. { #SABREWULF$B6B2 }
. LIST#
R $B9EE DE Address of the first score
R $B9EE HL Address of the second score
R $B9EE O:F Carry set if the first is lower, zero set if they are equal
  $B9EE,$03 Save the registers.
  $B9F1,$02 There are three bytes to compare.
@ $B9F3 label=NewHighScore_Compare_Loop
  $B9F3,$01 Fetch a byte of the first score.
  $B9F4,$03 Jump if it is lower than the byte of the second score.
  $B9F7,$02 Jump if it is higher.
  $B9F9,$01 Move on to the next byte of the second score...
  $B9FA,$01 ...and the first.
  $B9FB,$02 Loop back until all of the bytes have been compared.
@ $B9FD label=NewHighScore_Compare_Return
  $B9FD,$03 Restore the registers.
  $BA00,$01 Return.

t $BA01 Messaging: Place Names
@ $BA01 label=PlaceNames
D $BA01 The names of the places of the hall of fame, starting with the lowest.
. The name of the highest place is blank.
  $BA01,$18,$03 "8TH", "7TH", "6TH", "5TH", "4TH", "3RD", "2ND" and "   ".

c $BA19 Enter Initials
@ $BA19 label=EnterInitials
D $BA19 Asks the player for three initials. The turning controls change the
. letter, which cycles through the space and the letters A to Z, and the fire
. control for the first weapon accepts it.
E $BA19 View the equivalent code in;
. #LIST
. { #SABREWULF$B6D7 }
. LIST#
R $BA19 DE Address of the name
  $BA19,$02 There are three letters.
  $BA1B,$04 Clear the controls.
  $BA1F,$03 Point #REGhl at the screen address of the first letter.
@ $BA22 label=EnterInitials_Letter
  $BA22,$02 Start with a space.
@ $BA24 label=EnterInitials_Read
  $BA24,$01 Save the letter.
  $BA25,$03 Read the controls using #R$B075.
  $BA28,$04 Clear the controls.
  $BA2C,$01 Restore the letter.
  $BA2D,$04 Jump to accept the letter if the fire control is being used.
  $BA31,$04 Jump to go back a letter if the control to turn left is being used.
  $BA35,$04 Jump to go on a letter if the control to turn right is being used.
  $BA39,$02 Jump to read the controls again.
@ $BA3B label=EnterInitials_PreviousLetter
  $BA3B,$03 Make a sound using #R$BA93.
  $BA3E,$01 Go back a letter.
  $BA3F,$04 Jump if that is not the character before #N$41 ("A").
  $BA43,$02 Use a space.
@ $BA45 label=EnterInitials_CheckSpace
  $BA45,$04 Jump if that is not the character before a space.
  $BA49,$02 Use "Z".
@ $BA4B label=EnterInitials_Show
  $BA4B,$01 Save the letter.
  $BA4C,$03 Print the letter using #R$B5CB.
  $BA4F,$01 Restore the letter.
  $BA50,$01 Go back to the screen address of the letter.
  $BA51,$02 Jump to read the controls again.
@ $BA53 label=EnterInitials_NextLetter
  $BA53,$03 Make a sound using #R$BA93.
  $BA56,$01 Go on a letter.
  $BA57,$04 Jump if that is not the character after "Z".
  $BA5B,$02 Use a space.
@ $BA5D label=EnterInitials_CheckAfterZ
  $BA5D,$04 Jump if that is not the character after a space.
  $BA61,$02 Use "A".
  $BA63,$02 Jump to show the letter.
@ $BA65 label=EnterInitials_Fire
  $BA65,$01 Save the letter.
  $BA66,$03 Read the controls using #R$B075.
  $BA69,$04 Clear the controls.
  $BA6D,$01 Restore the letter.
  $BA6E,$04 Jump back until the fire control is released.
  $BA72,$01 Store the letter in the name.
  $BA73,$01 Move on to the next letter of the name.
  $BA74,$01 Save the letter...
  $BA75,$01 ...and the counter.
  $BA76,$03 Print the letter using #R$B5CB.
  $BA79,$01 Leave a gap before the next letter.
  $BA7A,$05 Make a sound using #R$C050.
  $BA7F,$03 Wait for #N$010000 iterations.
@ $BA82 label=EnterInitials_Delay
  $BA82,$01 Count down the delay.
  $BA83,$04 Loop back until the count reaches zero.
  $BA87,$01 Restore the counter...
  $BA88,$01 ...and the letter.
  $BA89,$02 Loop back until all three letters have been entered.
  $BA8B,$02 Use one pass of the delay...
  $BA8D,$03 ...with a count of #N$0000...
  $BA90,$03 ...and wait using #R$BD32.

c $BA93 Delay And Beep
@ $BA93 label=NewHighScore_Return
D $BA93 Makes a short beep and a pause, which is used when the letter is
. changed.
E $BA93 View the equivalent code in;
. #LIST
. { #SABREWULF$B743 }
. LIST#
  $BA93,$01 Save the letter...
  $BA94,$01 ...the counter...
  $BA95,$01 ...and the screen address.
  $BA96,$02 Use a count of one...
  $BA98,$03 ...and #N$8000 iterations...
  $BA9B,$03 ...for the delay using #R$BD32.
  $BA9E,$03 Make a beep using #R$C027.
  $BAA1,$01 Restore the screen address...
  $BAA2,$01 ...the counter...
  $BAA3,$01 ...and the letter.
  $BAA4,$01 Return.

t $BAA5 Messaging: Initials
@ $BAA5 label=InitialsMessage_Attributes
D $BAA5 The attributes, coordinates and text of the message that asks for the
. initials. The three characters of the third line, after "TODAYS", are replaced
. with the name of the place.
B $BAA5,$01 #COLOUR(#PEEK(#PC)).
L $BAA5,$01,$07
@ $BAAC label=InitialsMessage_Coordinates
B $BAAC,$0E,$02 Coordinates of the seven lines of text.
@ $BABA label=InitialsMessage_Text
  $BABA,$0F,$0E:$01 "CONGRATULATIONS".
  $BAC9,$11,$10:$01 "YOU HAVE ACHIEVED".
  $BADA,$07,$07 "TODAYS" and a space.
@ $BAE1 label=InitialsMessage_PlaceName
  $BAE1,$0B,$0A:$01 The name of the place is written over the spaces, then
. "HIGHEST".
  $BAEC,$05,$04:$01 "SCORE".
  $BAF1,$0F,$0E:$01 "PLEASE REGISTER".
  $BB00,$0D,$0C:$01 "YOUR INITIALS".
  $BB0D,$05,$04:$01 "- - -".

c $BB12 Game Selection Menu
@ $BB12 label=GameMenu
D $BB12 Displays the menu and waits for the control method to be chosen and the
. game to be started. The keys "1" to "4" choose the keyboard, the Kempston
. joystick, the cursor joystick and Interface II, and "0" starts the game. The
. menu tune is played once. The choice is held in #R$961A. If nothing is done
. for a while then the hall of fame is shown.
E $BB12 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BA7E }
. { #KNIGHTLORE$BD0C }
. { #NIGHTSHADE$C8CA }
. { #PENTAGRAM$BB74 }
. LIST#
  $BB12,$05 Set the last method of control that was seen to an impossible value.
  $BB17,$01 Clear the attribute.
  $BB18,$03 Call #R$B212.
N $BB1B Read the keys that choose the control method.
@ $BB1B label=GameMenu_Loop
  $BB1B,$03 Draw the menu using #R$B8B3.
N $BB1E #HTML(#AUDIO0(title-tune.wav)(#INCLUDE(TitleTune)))
  $BB1E,$03 Point #REGde at #R$C1E9.
  $BB21,$03 Play it using #R$C0B6, if it has not been played yet.
  $BB24,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $BB29,$01 Keep the keys that are pressed in #REGe.
  $BB2A,$03 Fetch the method of control.
  $BB2D,$04 Jump if the key #N$01 is not pressed.
  $BB31,$02,b$01 Use method zero (keyboard).
N $BB33 Choose a joystick if one of those keys is pressed.
@ $BB33 label=GameMenu_CheckKey2
  $BB33,$04 Jump if the key #N$02 is not pressed.
  $BB37,$02,b$01 Use method one (Kempston joystick)...
  $BB39,$02,b$01 Set the method to the Kempston joystick.
@ $BB3B label=GameMenu_CheckKey3
  $BB3B,$04 Jump if the key #N$03 is not pressed.
  $BB3F,$02,b$01 Use method two (cursor keys)...
  $BB41,$02,b$01 Set the method to the cursor keys.
@ $BB43 label=GameMenu_CheckKey4
  $BB43,$04 Jump if the key #N$04 is not pressed.
  $BB47,$02,b$01 Choose Interface II.
@ $BB49 label=GameMenu_StoreControl
  $BB49,$03 Store the method of control.
N $BB4C Start the game if "0" is pressed.
  $BB4C,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $BB51,$02,b$01 ...and keep the key #N$00.
  $BB53,$02 Jump to start the game if it is pressed.
  $BB55,$03 Point #REGhl at the last method of control that was seen.
  $BB58,$03 Fetch the method of control...
  $BB5B,$01 Compare it with the last method.
  $BB5C,$03 Set #R$9632.
  $BB5F,$03 Reset the idle timer if the method has changed, or count it down,
. using #R$B760.
N $BB62 Flash the chosen control method.
  $BB62,$03 Point #REGhl at #R$B8E5.
  $BB65,$03 Fetch the method of control...
  $BB68,$01 Move the method to bits 0 and 1.
  $BB69,$02,b$01 Keep only bits 0 and 1.
  $BB6B,$02 There are four lines for the methods of control.
  $BB6D,$03 Make the line for the method flash using #R$BB73.
  $BB70,$03 Jump back to draw the menu again.

c $BB73 Set Flashing Attribute
@ $BB73 label=SetFlashingAttribute
D $BB73 Makes the line of the menu that is selected flash, by setting bit 7 of
. its attribute. The other lines have it cleared.
E $BB73 View the equivalent code in;
. #LIST
. { #ALIENEIGHT$BC15 }
. { #PENTAGRAM$BB64 }
. LIST#
R $BB73 A Number of the line to highlight
R $BB73 B Number of lines
R $BB73 HL Address of the attributes of the lines
  $BB73,$03 Jump to make the line flash if it is the first one.
@ $BB76 label=HighlightMenuItem_Flash
  $BB76,$02 Make the line flash...
  $BB78,$02 ...and jump to move on to the next line.
@ $BB7A label=HighlightMenuItem_Next
  $BB7A,$01 Count down the lines.
  $BB7B,$02 Jump to make the line flash if it is the one that is selected.
@ $BB7D label=HighlightMenuItem_Steady
  $BB7D,$02 Make the line steady.
@ $BB7F label=HighlightMenuItem_NextLine
  $BB7F,$01 Move on to the next attribute.
  $BB80,$02 Loop back until all of the lines have been done.
  $BB82,$01 Return.

c $BB83 Unused Jump
@ $BB83 label=GameMenu_Unused
D $BB83 This jump to #R$BB12 is not used.
  $BB83,$03 Jump to show the menu.

c $BB86 Start Game Sequence
@ $BB86 label=StartGameSequence
D $BB86 Runs when the key to start the game is pressed. Lights are started
. around the frame of the screen, and when they have all finished the tune that
. starts the game is played and the game screen is drawn.
  $BB86,$02 There are eight lights to start.
@ $BB88 label=StartGameSequence_Light
  $BB88,$01 Save the counter.
  $BB89,$03 Draw the menu using #R$B8B3.
  $BB8C,$05 Start a new light using #R$AF25.
  $BB91,$01 Restore the counter.
  $BB92,$02 Loop back until all eight lights have been started.
  $BB94,$03 Draw the menu using #R$B8B3.
@ $BB97 label=StartGameSequence_Wait
  $BB97,$04 Restore #REGiy, which the ROM interrupt routine needs.
  $BB9B,$01 Enable interrupts...
  $BB9C,$01 ...and wait for the next one.
  $BB9D,$01 Disable interrupts again.
  $BB9E,$04 Move the lights without starting a new one, using #R$AF25.
  $BBA2,$02 Loop back until all of the lights have finished.
  $BBA4,$03 Point #REGde at #R$C289.
  $BBA7,$03 Play it using #R$C0CF.

c $BBAA Draw Game Screen
@ $BBAA label=DrawGameScreen
D $BBAA Resets the map and draws the parts of the game screen that are not the
. play window: the rows of beads above the message area, the message area itself
. with its rounded box, and the box for the battery meter with its title. It is
. used when a game is started, and when a round has been completed.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #POKES$5C36,$00;$5C37,$3C
. #SCR$02(draw-game-screen-before)
. | #SIM(start=$9A65,stop=$9A68)
. #SCR$02(draw-game-screen-after) } UDGTABLE# #POPS
  $BBAA,$03 Reset the map using #R$BD13.
  $BBAD,$03 Point #REGhl at #R$9401.
  $BBB0,$03 ...and use them as the current character set.
N $BBB3 Draw the two rows of beads that divide the play window from the message
. area.
  $BBB3,$03 Point #REGhl at the start of the row on character row #N$11.
  $BBB6,$03 The row is #N$18 characters wide (#REGb) and starts with character
. #N$01 (#REGc).
  $BBB9,$03 Draw the row using #R$B6A6.
  $BBBC,$03 The row is #N$16 characters wide and starts with character #N$02.
  $BBBF,$03 Point #REGhl at the start of the row on character row #N($10), one
. column in.
  $BBC2,$03 Draw the row.
  $BBC5,$03 Point #REGhl at the attributes of the lower row.
  $BBC8,$02 Set the first attribute, blue paper with black ink.
  $BBCA,$01 Move on to the second cell.
  $BBCB,$03 There are #N$16 cells, and the attribute is blue paper with blue
. ink.
  $BBCE,$03 Set the attributes using #R$B689.
  $BBD1,$02 Set the last attribute, blue ink on a black paper.
  $BBD3,$03 Point #REGhl at the attributes of the upper row.
  $BBD6,$03 There are #N$16 cells, and the attribute is blue paper with black
. ink.
  $BBD9,$03 Set the attributes.
  $BBDC,$03 Clear the message area using #R$B202.
  $BBDF,$05 Fill the attributes of the message area with bright white using
. #R$B1E1.
  $BBE4,$03 Fetch the address of the ROM character set...
  $BBE7,$03 ...and use it as the current character set.
  $BBEA,$03 Point #REGhl at the position of the title of the battery meter.
  $BBED,$03 Point #REGde at #R$BCCB.
  $BBF0,$03 Print it using #R$B52E.
N $BBF3 Draw the rounded box of the message area, which is made of four rows of
. characters.
  $BBF3,$03 Point #REGhl at #R$BC54.
  $BBF6,$03 ...and use them as the current character set.
  $BBF9,$03 Point #REGde at #R$BC8C.
  $BBFC,$03 Point #REGhl at the position of the top row.
  $BBFF,$03 Print it using #R$BDA1.
  $BC02,$03 Point #REGde at #R$BCA1.
  $BC05,$03 Point #REGhl at the position of the second row.
  $BC08,$03 Print it.
  $BC0B,$03 Point #REGde at the middle row of the box again.
  $BC0E,$03 Point #REGhl at the position of the third row.
  $BC11,$03 Print it.
  $BC14,$03 Point #REGde at #R$BCB6.
  $BC17,$03 Point #REGhl at the position of the bottom row.
  $BC1A,$03 Print it.
N $BC1D Draw the box for the battery meter.
  $BC1D,$03 Point #REGhl at #R$BCE3.
  $BC20,$03 ...and use them as the current character set.
  $BC23,$03 Point #REGhl at the position of the box.
  $BC26,$03 Point #REGde at #R$BCD3.
@ $BC29 label=DrawGameScreen_Attributes
  $BC29,$01 Save the position.
  $BC2A,$03 Find the address of the attributes using #R$BD6A.
  $BC2D,$01 Fetch the attribute...
  $BC2E,$01 ...and move on to the first character.
  $BC2F,$01 Keep the attribute.
  $BC30,$02 There are two rows of characters.
@ $BC32 label=DrawGameScreen_Row
  $BC32,$01 Save the address of the characters...
  $BC33,$01 ...and the address of the attributes.
@ $BC34 label=DrawGameScreen_Cell
  $BC34,$01 Set an attribute.
  $BC35,$01 Fetch a character...
  $BC36,$01 ...and move on to the next one.
  $BC37,$01 Move on to the next attribute.
  $BC38,$04 Loop back until the last character has been reached.
  $BC3C,$01 Restore the address of the attributes...
  $BC3D,$03 ...and move down to the next row...
  $BC40,$01 ...of the attributes.
  $BC41,$01 Restore the address of the characters.
  $BC42,$02 Loop back until both rows have been done.
  $BC44,$01 Restore the position of the box.
  $BC45,$03 Find the screen address using #R$BD4B.
@ $BC48 label=DrawGameScreen_Character
  $BC48,$01 Fetch a character.
  $BC49,$01 Move on to the next one.
  $BC4A,$05 Jump to #R$B4F8 to print the last character of the box.
  $BC4F,$03 Print a character using #R$B4F8.
  $BC52,$02 Loop back until the whole box has been printed.

b $BC54 Message Box Graphics
@ $BC54 label=MessageBoxGraphics
D $BC54 The graphics of the rounded box that goes round the message area. They
. are the top left corner, the top and bottom edges, the top right corner, the
. sides, the bottom left corner, the bottom right corner and a blank.
B $BC54,$38,$08

b $BC8C Message Box Text
D $BC8C The rows of the message box. Each one starts with an attribute (bright
. cyan) and ends with a character that has bit 7 set.
@ $BC8C label=MessageBox_Top
B $BC8C,$01 Attribute.
B $BC8D,$01 The top left corner.
B $BC8E,$12,$12 The top edge.
B $BCA0,$01 The top right corner.
@ $BCA1 label=MessageBox_Middle
B $BCA1,$01 Attribute.
B $BCA2,$01 The left side.
B $BCA3,$12,$12 The blank middle.
B $BCB5,$01 The right side.
@ $BCB6 label=MessageBox_Bottom
B $BCB6,$01 Attribute.
B $BCB7,$01 The bottom left corner.
B $BCB8,$12,$12 The bottom edge.
B $BCCA,$01 The bottom right corner.

b $BCCB Battery Meter Data
@ $BCCB label=Message_Battery
D $BCCB The title of the battery meter. It starts with an attribute (bright
. yellow).
B $BCCB,$01 Attribute.
T $BCCC,$07,$06:$01 "BATTERY".
@ $BCD3 label=BatteryMeterBox
D $BCCB The box for the battery meter. It starts with an attribute (bright
. yellow on black) and ends with a character that has bit 7 set. The characters
. are each two rows tall.
B $BCD3,$01 Attribute.
B $BCD4,$01 The left end.
B $BCD5,$0D,$0D The middle.
B $BCE2,$01 The right end.

b $BCE3 Battery Meter Box Graphics
@ $BCE3 label=BatteryMeterBoxGraphics
D $BCE3 The graphics of the box for the battery meter, which is two rows tall.
. They are the left end, the middle (the top line and the bottom line) and the
. right end, each of which is made of an upper and a lower graphic.
B $BCE3,$30,$08

c $BD13 Reset Map
@ $BD13 label=ResetMap
D $BD13 Puts every cell of the map back to its initial type, by copying the
. upper four bits of each cell into the lower four bits.
  $BD13,$03 Point #REGhl at the end of the map.
  $BD16,$03 Point #REGbc at #R$C515.
  $BD19,$03 Find the size of the map...
  $BD1C,$02 ...and keep it in #REGbc.
  $BD1E,$03 Point #REGhl at #R$C515.
@ $BD21 label=ResetMap_Cell
  $BD21,$01 Fetch a cell.
  $BD22,$03 Keep the initial type.
  $BD25,$04 Move it into the lower four bits...
  $BD29,$01 ...and combine it with the original.
  $BD2A,$01 Store the cell.
  $BD2B,$01 Move on to the next cell.
  $BD2C,$01 Count down the size.
  $BD2D,$04 Loop back until every cell has been reset.
  $BD31,$01 Return.

c $BD32 Delay
@ $BD32 label=Delay
D $BD32 Waits for a while. The time is about #REGb times the number of times
. that #REGhl can be counted down to zero, which is #N$10000 if it starts as
. zero.
E $BD32 View the equivalent code in;
. #LIST
. { #SABREWULF$A1FF }
. { #TRANZAM$6386 }
. LIST#
R $BD32 B Number of times to repeat the wait
R $BD32 HL Length of each wait
  $BD32,$05 Count down #REGhl until it reaches zero.
  $BD37,$02 Loop back until the wait has been repeated #REGb times.
  $BD39,$01 Return.

c $BD3A Screen Address One Pixel Below
@ $BD3A label=ScreenPosition1PixelBelow
D $BD3A Moves down by one pixel line in the display file.
E $BD3A View the equivalent code in;
. #LIST
. { #ATICATAC$9BC1 }
. { #SABREWULF$B8CC }
. { #UNDERWURLDE$9C2B }
. LIST#
R $BD3A HL Screen address
R $BD3A O:HL Screen address one pixel line down
  $BD3A,$01 Move down to the next pixel line in the character row.
  $BD3B,$04 Return if that is still inside the character row.
  $BD3F,$04 Otherwise move on to the next character row in the third...
  $BD43,$03 ...and return if that is still inside the third of the display.
  $BD46,$04 Otherwise move on to the next third.
  $BD4A,$01 Return.

c $BD4B Calculate Screen Address
@ $BD4B label=ScreenAddress
D $BD4B Finds the address in the display file of a pixel position.
E $BD4B View the equivalent code in;
. #LIST
. { #LUNARJETMAN$851E }
. { #PSSST$759A }
. { #SABREWULF$B8AD }
. { #TRANZAM$6F10 }
. LIST#
R $BD4B L Horizontal position in pixels (the address is of the byte it is in)
R $BD4B H Vertical position in pixels, from the top
R $BD4B O:HL Screen address
  $BD4B,$04 Divide the horizontal position by eight...
  $BD4F,$03 ...to find the column.
  $BD52,$03 Find the bits of the character row that are within a third of the
. display, and shift them up...
  $BD55,$04 ...combine them with the column and store them in #REGl.
  $BD59,$04 Keep the pixel line within the character row.
  $BD5D,$08 Find the third of the display and add the base address of the
. display file.
  $BD65,$01 Store it in #REGh.
  $BD66,$03 Add the pixel line within the character row.
  $BD69,$01 Return.

c $BD6A Calculate Attribute Address
@ $BD6A label=AttributeAddress
D $BD6A Finds the address in the attribute file of a pixel position.
E $BD6A View the equivalent code in;
. #LIST
. { #ATICATAC$9BD2 }
. { #LUNARJETMAN$8506 }
. { #SABREWULF$B8DD }
. { #UNDERWURLDE$ADE0 }
. LIST#
R $BD6A L Horizontal position in pixels
R $BD6A H Vertical position in pixels, from the top
R $BD6A O:HL Attribute address
  $BD6A,$01 Save #REGbc.
  $BD6B,$04 Divide the horizontal position by eight...
  $BD6F,$03 ...to find the column.
  $BD72,$04 Multiply the vertical position by four, keeping it in #REGc.
  $BD76,$04 Combine the bits of the character row with the column and store them
. in #REGl.
  $BD7A,$06 Find the third of the attribute file and add its base address.
  $BD80,$01 Restore #REGbc.
  $BD81,$01 Return.

c $BD82 Print Text
@ $BD82 label=PrintText
D $BD82 Prints a string using the ROM character set. The colour of the text is
. taken from the variable that holds the attribute.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #POKES$5C36,$00;$5C37,$3C;$9628,$47
. #SIM(start=$9901,stop=$9904)
. #SCR$02(print-text-before)
. | #SIM(start=$BD82,stop=$BDCC,de=$B718,hl=$5040)
. #SCR$02(print-text-after) } UDGTABLE# #POPS
R $BD82 DE Address of the string, which ends with a character that has bit 7 set
R $BD82 HL Pixel position of the start of the text (#REGl is x and #REGh is y)
  $BD82,$08 Use the ROM character set.
@ $BD8A label=PrintText_Position
  $BD8A,$04 Find the address of the display file using #R$BD4B.
  $BD8E,$04 Fetch the attribute and keep it in #REGa'.
  $BD92,$05 Switch to the alternate registers and find the address of the
. attributes using #R$BD6A.
  $BD97,$02 Jump to print the text.

c $BD99 Print Colour String
@ $BD99 label=PrintStringColour
D $BD99 Prints a string using the ROM character set. The first byte of the
. string is the attribute of the text.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #POKES$5C36,$00;$5C37,$3C
. #SIM(start=$9901,stop=$9904)
. #SCR$02(print-colour-string-before)
. | #SIM(start=$BD99,stop=$BDCC,de=$B717,hl=$4038)
. #SCR$02(print-colour-string-after) } UDGTABLE# #POPS
E $BD99 View the equivalent code in;
. #LIST
. { #LUNARJETMAN$8A11 }
. { #PSSST$73ED }
. { #SABREWULF$B53D }
. { #TRANZAM$6518 }
. LIST#
R $BD99 DE Address of the string, which starts with an attribute
R $BD99 HL Pixel position of the start of the text (#REGl is x and #REGh is y)
  $BD99,$08 Use the ROM character set.
@ $BDA1 label=PrintStringColour_CustomFont
N $BDA1 This entry point uses the current character set.
  $BDA1,$04 Find the address of the display file using #R$BD4B.
  $BDA5,$02 Fetch the attribute from the string and keep it in #REGa'...
  $BDA7,$01 ...and move on to the first character.
  $BDA8,$05 Switch to the alternate registers and find the address of the
. attributes using #R$BD6A.
@ $BDAD label=PrintStringColour_Loop
  $BDAD,$01 Switch back to the main registers.
  $BDAE,$01 Fetch a character.
  $BDAF,$04 Jump if it is the last one.
  $BDB3,$01 Save the address of the string.
  $BDB4,$03 Print the character using #R$B5CB.
  $BDB7,$01 Restore the address of the string...
  $BDB8,$01 ...and move on to the next character.
  $BDB9,$01 Switch to the alternate registers.
  $BDBA,$01 Fetch the attribute...
  $BDBB,$01 ...and set it...
  $BDBC,$01 ...and move on to the next cell...
  $BDBD,$01 ...keeping the attribute.
  $BDBE,$02 Loop back to print the next character.
@ $BDC0 label=PrintStringColour_Last
  $BDC0,$02 Clear bit 7 of the last character.
  $BDC2,$01 Save the address of the string.
  $BDC3,$03 Print the character.
  $BDC6,$01 Restore the address of the string.
  $BDC7,$01 Move on to the next character.
  $BDC8,$01 Switch to the alternate registers.
  $BDC9,$01 Fetch the attribute...
  $BDCA,$01 ...and set it for the last cell.
  $BDCB,$01 Switch back to the main registers.
  $BDCC,$01 Return.

c $BDCD Add Entity
@ $BDCD label=AddEntity
D $BDCD Adds an entity to the draw list, if it can be seen. The view is centred
. on the robot (the first entity), and an entity can only be seen if it is
. within about #N$10 cells of it. The distances between the entity and the robot
. in the two directions are projected onto the screen: the sum of them gives the
. height of the entity above the bottom of the buffer and the difference gives
. its horizontal position, both in units of one sixteenth of a cell. If it is
. added then bit 0 of (#REGix+#N$0F) is set. The draw list entry that is added
. is made of the type of the entity, the horizontal position and the height.
R $BDCD IX Entity
R $BDCD O:F Carry set if the entity was added
  $BDCD,$03 Set the offset that puts the robot five and a quarter cells from the
. start of the view.
  $BDD0,$04 Mark the entity as not visible.
  $BDD4,$06 Fetch the horizontal position of the entity.
  $BDDA,$04 Fetch the horizontal position of the robot.
  $BDDE,$03 Find the distance from the robot...
  $BDE1,$01 ...and add the offset.
  $BDE2,$03 Keep it within the width of the map (#N$40 cells).
  $BDE5,$03 Return, as the entity cannot be seen, if it is further than #N$0F
. cells from the start of the view.
  $BDE8,$01 Keep the cell number.
  $BDE9,$01 Save the horizontal distance.
  $BDEA,$06 Fetch the vertical position of the entity.
  $BDF0,$04 Fetch the vertical position of the robot.
  $BDF4,$03 Find the distance from the robot.
  $BDF7,$04 Keep it within the height of the map (#N$40 cells).
  $BDFB,$01 Move the vertical distance into #REGde.
  $BDFC,$02 Restore the horizontal distance, keeping a copy of it too.
  $BDFE,$01 Add the vertical distance.
  $BDFF,$03 Divide it by sixteen using #R$BE4E, to find the height.
  $BE02,$05 Jump to throw the entity away if the height does not fit in a byte.
  $BE07,$05 Jump to throw the entity away if the height is more than #N$A7.
  $BE0C,$04 Fetch the address of the next free entry of the draw list.
  $BE10,$03 Store the height in it.
  $BE13,$01 Restore the horizontal distance.
  $BE14,$03 Subtract the vertical distance...
  $BE17,$03 ...and divide it by sixteen, to find the horizontal position.
  $BE1A,$04 Add eight to it...
  $BE1E,$03 ...carrying on into the high byte.
  $BE21,$03 Return, as the entity cannot be seen, if it is out of range.
  $BE24,$04 Return, as the entity cannot be seen, if it is further right than
. #N$B7.
  $BE28,$06 Take the eight off again. If that goes below zero then subtract
. #N$40.
@ $BE2E label=AddEntity_StoreX
  $BE2E,$03 Store the horizontal position in the entry.
  $BE31,$06 Copy the type of the entity into the entry.
  $BE37,$06 Move on to the next entry.
  $BE3D,$04 End the list after it.
  $BE41,$04 Store the address of the next free entry.
  $BE45,$04 Mark the entity as visible.
  $BE49,$02 Set the carry flag to show that the entity was added, and return.
@ $BE4B label=AddEntity_Hidden
  $BE4B,$01 Throw away the horizontal distance.
  $BE4C,$02 Clear the carry flag, and return.

c $BE4E Divide By Sixteen
@ $BE4E label=DivideBySixteen
D $BE4E Shifts a 16-bit number right by four bits.
R $BE4E HL Number to divide
R $BE4E O:HL Number divided by sixteen
  $BE4E,$10 Shift #REGhl right four times.
  $BE5E,$01 Return.

c $BE5F Add Map Cells
@ $BE5F label=AddMapCells
D $BE5F Adds the cells of the map that can be seen to the end of the draw list.
. They are the cells in a diamond shape around the robot: twelve rows along the
. map, which run from six rows further on than the robot to five rows behind it.
. The rows have #N($01), #N($03), #N($05), #N($07), #N($09), #N($0B), #N($0D),
. #N($0B), #N($09), #N($07), #N$05 and #N$03 cells in them. Each empty cell is
. skipped. The position
. of each of the others on the screen is found from its place in the diamond,
. the position of the robot inside its own cell and the offsets in the template
. for the type of the cell, which are the same projection as #R$BDCD uses. Cells
. that are outside of the play window are not added.
  $BE5F,$04 Fetch the address of the next free entry of the draw list.
  $BE63,$0A Fetch the fraction of the horizontal position of the robot, in
. sixteenths of a cell, in #REGe.
  $BE6D,$0A Fetch the fraction of the vertical position of the robot, in
. sixteenths of a cell, in #REGl.
  $BE77,$05 Store the sum of them.
  $BE7C,$05 Store the difference between them.
  $BE81,$04 Fetch the map column of the robot into #REGe.
  $BE85,$08 Fetch the map row of the robot, add six to it and keep it within the
. map, in #REGd.
  $BE8D,$02 There are twelve rows of cells.
@ $BE8F label=AddMapCells_Row
  $BE8F,$03 Point #REGhl at the table of half widths of the rows.
  $BE92,$04 Fetch the half width of this row into #REGl.
  $BE96,$01 Save the position.
  $BE97,$04 Find the number of the cell at the start of the row, which is six
. more than the half width...
  $BE9B,$03 ...and the number of the cell after the end of the row, which is six
. less, in #REGh.
  $BE9E,$05 Move to the right hand end of the row.
@ $BEA3 label=AddMapCells_Cell
  $BEA3,$03 Find the cell using #R$BF9D.
  $BEA6,$02 Jump to move on to the next cell if it is empty.
  $BEA8,$01 Switch to the alternate registers.
  $BEA9,$03 Find the number of the template for the type of cell...
  $BEAC,$04 ...multiply it by sixteen...
  $BEB0,$03 ...and put it in #REGde.
  $BEB3,$06 Point #REGiy at the template.
  $BEB9,$01 Switch back to the main registers.
  $BEBA,$04 Find the number of the column in the diamond...
  $BEBE,$04 ...and multiply it by sixteen.
  $BEC2,$01 Save the position.
  $BEC3,$04 Fetch the sum and difference of the fractions of the position of the
. robot.
  $BEC7,$01 Subtract the difference, to give the horizontal position.
  $BEC8,$03 Add the first offset from the template...
  $BECB,$03 ...and subtract the second one.
  $BECE,$02 Subtract three.
  $BED0,$04 Jump to throw the cell away if it is further right than #N$B7.
  $BED4,$06 Take eight off. If that goes below zero then subtract #N$40.
@ $BEDA label=AddMapCells_StoreX
  $BEDA,$03 Store the horizontal position in the entry.
  $BEDD,$04 Find the number of the row in the diamond...
  $BEE1,$04 ...and multiply it by sixteen.
  $BEE5,$01 Subtract the sum of the fractions, to give the height.
  $BEE6,$03 Add the first offset from the template...
  $BEE9,$03 ...and also the second one.
  $BEEC,$02 Subtract #N$0B.
  $BEEE,$05 Jump to throw the cell away if the height is less than #N$10.
  $BEF3,$02 The carry flag is set if the height is less than #N$A0.
@ $BEF5 label=AddMapCells_Discard
  $BEF5,$01 Restore the position.
  $BEF6,$02 Jump to move on to the next cell if it is out of the window.
  $BEF8,$03 Store the height in the entry.
  $BEFB,$06 Copy the sprite type from the template into the entry.
  $BF01,$06 Move on to the next entry.
@ $BF07 label=AddMapCells_Next
  $BF07,$04 Jump if that was the last cell of the row.
  $BF0B,$01 Move on to the next cell...
  $BF0C,$05 ...which is one column to the left.
  $BF11,$02 Loop back to deal with it.
@ $BF13 label=AddMapCells_NextRow
  $BF13,$01 Restore the position.
  $BF14,$05 Move back one row.
  $BF19,$04 Loop back until all twelve rows have been done.
  $BF1D,$04 End the list.
  $BF21,$01 Return.

c $BF22 Sort Draw List
@ $BF22 label=SortDrawList
D $BF22 Sorts the draw list, so that the sprites that are highest up the screen
. are drawn first. Sprites at the same height are drawn from left to right. It
. is a bubble sort, which is repeated until there is a pass without any swaps.
  $BF22,$05 Return if there are fewer than two entries in the list.
@ $BF27 label=SortDrawList_Pass
  $BF27,$03 Point #REGde at the height of the first entry.
  $BF2A,$03 Point #REGhl at #R$D35A.
  $BF2D,$02 Clear the flag that records that a swap was made.
@ $BF2F label=SortDrawList_Compare
  $BF2F,$01 Fetch the height of the first entry...
  $BF30,$01 ...and compare it with the height of the second.
  $BF31,$02 Point at the horizontal positions.
  $BF33,$02 Jump to swap them if the first is lower.
  $BF35,$02 Jump if the first is higher, as they are in order.
  $BF37,$02 Otherwise fetch the horizontal position of the first entry.
  $BF39,$02 Compare it with the horizontal position of the second.
  $BF3B,$02 Jump if they are in order.
@ $BF3D label=SortDrawList_Swap
  $BF3D,$04 Record that a swap has been made.
  $BF41,$02 Point at the types.
  $BF43,$05 Swap the types.
  $BF48,$02 Point at the horizontal positions.
  $BF4A,$05 Swap the horizontal positions.
  $BF4F,$02 Point at the heights.
  $BF51,$05 Swap the heights.
@ $BF56 label=SortDrawList_Advance
  $BF56,$02 Point at the type of the next entry.
  $BF58,$04 Jump if there are no more entries.
  $BF5C,$04 Point at the heights of the entries.
  $BF60,$02 Loop back to compare them.
@ $BF62 label=SortDrawList_Finish
  $BF62,$03 Go round again if any swap was made.
  $BF65,$01 Return.
@ $BF66 label=SortDrawList_InOrder
  $BF66,$04 Point at the heights and jump.

c $BF6A Draw List
@ $BF6A label=DrawList
D $BF6A Draws every sprite in the draw list into the off-screen buffer, in
. order.
. #PUSHS #UDGTABLE(default,centre,centre)
. { =h Before | =h After }
. { #SIM(start=$98E0,stop=$98EC,clear=1,sp=$5E00)
. #SIM(start=$98EC,stop=$98EF)
. #SIM(start=$98EF,stop=$98F2)
. #SIM(start=$98F2,stop=$98F5)
. #SIM(start=$98F5,stop=$98F8)
. #SCR$02(draw-list-before)
. | #POKES$D355,$10;$D356,$50;$D357,$50
. #POKES$D358,$08;$D359,$78;$D35A,$70
. #POKES$D35B,$60;$D35C,$A0;$D35D,$50
. #POKES$D35E,$68;$D35F,$50;$D360,$88
. #POKES$D361,$50;$D362,$B0;$D363,$88
. #POKES$D364,$00
. #SIM(start=$99F8,stop=$99FB)
. #SIM(start=$99FB,stop=$99FE)
. #SCR$02(draw-list-after) } UDGTABLE# #POPS
  $BF6A,$04 Point #REGix at the start of the draw list.
@ $BF6E label=DrawList_Loop
  $BF6E,$05 Return if the type is zero, which is the end of the list.
  $BF73,$03 Draw the sprite using #R$B2BC.
  $BF76,$06 Move on to the next entry.
  $BF7C,$02 Loop back.

c $BF7E Get Entity Address
@ $BF7E label=GetEntityAddress
D $BF7E Finds the address of an entity from its number. The entities are #N$10
. bytes long and this uses #N($08), so it does not work. It is not used.
R $BF7E A Entity number
R $BF7E O:IY Address
  $BF7E,$01 Save #REGbc.
  $BF7F,$03 Put the entity number in #REGbc.
  $BF82,$03 Move it into #REGiy.
  $BF85,$06 Multiply it by eight.
  $BF8B,$05 Add the address of the first entity.
  $BF90,$01 Restore #REGbc.
  $BF91,$01 Return.

c $BF92 Add A To HL
@ $BF92 label=AddAToHL
D $BF92 Adds an 8-bit number to a 16-bit number.
R $BF92 A Number to add
R $BF92 HL Number to add it to
R $BF92 O:HL Result
  $BF92,$03 Add #REGa to #REGl and return if that did not carry.
  $BF95,$01 Carry on into the high byte.
  $BF96,$01 Return.

c $BF97 Find Map Cell
@ $BF97 label=FindMapCell
D $BF97 Finds a cell of the map from its column and row, and tests whether it is
. empty. The address of the cell is also stored. The routine returns with all of
. the registers kept, apart from #REGa and the flags.
R $BF97 D Column
R $BF97 H Row
R $BF97 O:A Type of the cell, which is zero if it is empty
R $BF97 O:F Zero flag set if the cell is empty
  $BF97,$02 Save #REGde and #REGhl.
  $BF99,$02 Move the column into #REGe and the row into #REGd.
  $BF9B,$02 Jump to find the cell.
@ $BF9D label=FindMapCell_ColumnRow
N $BF9D This entry point takes the column in #REGe and the row in #REGd.
  $BF9D,$02 Save #REGde and #REGhl.
@ $BF9F label=FindMapCell_Find
  $BF9F,$04 Store the column and the row.
  $BFA3,$01 Clear the high part of the cell offset.
  $BFA4,$06 Divide the row by four, keeping the bits that come out in the top of
. #REGa.
  $BFAA,$02 Combine them with the column, to give the low byte of the offset of
. the cell, as there are #N$40 cells in each row.
  $BFAC,$04 Add the offset to the address of the map.
  $BFB0,$03 Store the address of the cell.
  $BFB3,$05 Fetch the type of the cell, which is in the lower four bits, and
. jump if it is zero.
@ $BFB8 label=FindMapCell_Return
  $BFB8,$02 Restore #REGhl and #REGde.
  $BFBA,$01 Return.
@ $BFBB label=FindMapCell_Empty
  $BFBB,$03 Mark the cell as empty and jump.

c $BFBE Unused Map Address
@ $BFBE label=MapAddress_Unused
D $BFBE Part of a way to find the address of a map cell that is not used. It
. does not clear #REGa first, so it would not work properly.
R $BFBE D Row
R $BFBE E Column
R $BFBE O:HL Address of the cell
  $BFBE,$06 Divide the row by four, keeping the bits that come out in the top of
. #REGa.
  $BFC4,$04 Combine them with the column.
  $BFC8,$04 Add the offset to the address of the map.
  $BFCC,$01 Return.

b $BFCD Row Half Widths
@ $BFCD label=RowHalfWidths
D $BFCD The half widths of the rows of the diamond of cells that is drawn by
. #R$BE5F, which is read from the end.
B $BFCD,$0D,$0D

c $BFDA Play Sound Effect Step
@ $BFDA label=PlaySoundStep
D $BFDA Called once a frame. If a sound effect is playing, one tone of it is
. made and the counter is counted down. An effect is started by storing a
. length and an effect number at #R$9688.
. #TABLE(default,centre,centre)
. { =h Effect | =h Tones | =h Started when }
. { #N$00 | #N$04 | The action key is used (#R$AC96). }
. { #N$01 | #N$05 | A program packet is sent (#R$9E45). }
. { #N$02 | #N$07 | A sector is activated (#R$A440). }
. { #N$03 | #N$04 | A program is destroyed (#R$A3F4). }
. TABLE#
. The effect number is stored and never loaded. #R$C010 takes its index from
. #REGa', which is whatever the frame left there. The lists at #R$BFF4 are used
. only when #REGa' is #N($00), #N($01), #N($02) or #N$03. At the start of play
. #REGa' is #N($50), so the first tone is read from outside those lists. The
. samples are the four effects as they sound then, one tone a frame. Effects
. #N$00 and #N$03 both ask for four tones, so they sound the same.
. #HTML(#AUDIO0(action-sound.wav)(#INCLUDE(ActionSound)))
. #HTML(#AUDIO0(program-sent-sound.wav)(#INCLUDE(ProgramSentSound)))
. #HTML(#AUDIO0(sector-activated-sound.wav)(#INCLUDE(SectorActivatedSound)))
. #HTML(#AUDIO0(program-destroyed-sound.wav)(#INCLUDE(ProgramDestroyedSound)))
E $BFDA View the equivalent code in;
. #LIST
. { #NIGHTSHADE$C3BD }
. { #PENTAGRAM$D5F2 }
. LIST#
  $BFDA,$03 Point at the tone counter.
  $BFDD,$03 Return if no sound effect is playing.
  $BFE0,$01 Count it down.
  $BFE1,$01 Keep the old counter in #REGa'.
  $BFE2,$01 Point at the effect number, which is not loaded.
  $BFE3,$03 Point at the table of pitch lists.
  $BFE6,$03 Choose a pitch list with #R$C010, using #REGa' as the index.
  $BFE9,$01 Fetch the old counter.
  $BFEA,$03 Use the old counter as the offset...
  $BFED,$01 ...and add it to the address.
  $BFEE,$01 Fetch the pitch.
  $BFEF,$02 The tone is made of #N$0C cycles.
  $BFF1,$03 Make the tone using #R$C05B.

w $BFF4 Sound Effect Table
@ $BFF4 label=SoundEffectTable
D $BFF4 The addresses of the four pitch lists. #R$BFDA uses a list only when
. #REGa' is that list's number.
W $BFF4,$08,$02

b $BFFC Sound Effect Pitches
@ $BFFC label=SoundEffectPitches
D $BFFC The pitches of the four sound effects, one list for each effect number.
. #R$BFDA reads a list from the end, because it adds the tone counter to the
. address of the list. It only reaches these bytes when #REGa' is #N($00),
. #N($01), #N($02) or #N$03.
B $BFFC,$04,$04
B $C000,$05,$05
B $C005,$07,$07
B $C00C,$04,$04

c $C010 Get Table Entry
@ $C010 label=GetTableEntry
D $C010 Reads a word from a table of words.
E $C010 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$C75C }
. { #NIGHTSHADE$D589 }
. { #PENTAGRAM$D692 }
. LIST#
R $C010 A Index into the table
R $C010 BC Address of the table
R $C010 O:HL The word
  $C010,$03 Put the index in #REGhl.
  $C013,$01 Multiply it by two.
  $C014,$01 Add the address of the table.
  $C015,$01 Fetch the low byte of the word.
  $C016,$01 Point at the high byte.
  $C017,$01 Fetch it into #REGh.
  $C018,$01 Assemble the low byte of the word.
  $C019,$01 Return.

c $C01A Make Random Beep
@ $C01A label=MakeRandomBeep
D $C01A Makes a short tone of random pitch.
. #HTML(#AUDIO0(appearing-sound.wav)(#INCLUDE(AppearingSound)))
  $C01A,$03 Fetch the random number.
  $C01D,$04 Keep it between #N$20 and #N$3F...
  $C021,$01 ...to use as the pitch.
  $C022,$02 The tone is made of #N$0C cycles.
  $C024,$03 Make the tone using #R$C05B.

c $C027 Make Beep
@ $C027 label=MakeBeep
D $C027 Makes a short beep.
. #HTML(#AUDIO0(short-beep.wav)(#INCLUDE(ShortBeep)))
  $C027,$01 Save #REGbc.
  $C028,$03 Set the pitch to #N$80 and the number of cycles to #N$20.
  $C02B,$03 Make the tone using #R$C05B.
  $C02E,$01 Restore #REGbc.
  $C02F,$01 Return.

c $C030 Play Melody
@ $C030 label=PlayMelody
D $C030 Plays a short melody from a list of pitches. It is not used.
  $C030,$03 Point #REGhl at the melody.
@ $C033 label=PlayMelody_Loop
  $C033,$01 Fetch a pitch.
  $C034,$01 Move on to the next one.
  $C035,$02 Return if it is zero, which is the end of the melody.
  $C037,$01 Use it as the pitch.
  $C038,$02 Each tone is made of #N$08 cycles.
  $C03A,$03 Make the tone using #R$C05B.
  $C03D,$02 Loop back for the next one.

b $C03F Melody Data
@ $C03F label=MelodyData
D $C03F The pitches of the melody that is played by #R$C030, ended by zero.
B $C03F,$09,$09

c $C048 Make Bump Sound
@ $C048 label=MakeBumpSound
D $C048 Makes a short, low tone.
. #HTML(#AUDIO0(low-tone.wav)(#INCLUDE(LowTone)))
  $C048,$03 Set the pitch to #N$40 and the number of cycles to #N$30.
  $C04B,$03 Make the tone using #R$C05B.

c $C04E Play Noise Sound
@ $C04E label=PlayNoiseSound
D $C04E Makes the sound of a shot. Plays #N$28 tones, each with a pitch worked
. out from a counter that counts down, so the sound falls in pitch.
.
. #HTML(#AUDIO0(shot-sound.wav)(#INCLUDE(ShotSound)))
E $C04E View the equivalent code in;
. #LIST
. { #GUNFRIGHT$AF22 }
. { #NIGHTSHADE$C3AA }
. { #PENTAGRAM$D5E4 }
. { #SABREWULF$BF2F }
. LIST#
N $C04E Play #N$28 pulses of different lengths.
  $C04E,$02 Use #N$28 cycles.
@ $C050 label=PlayNoiseSound_Counter
N $C050 This entry point takes the number of pulses in #REGc.
N $C050 Play the next pulse.
  $C050,$01 Fetch the number of the pulse.
  $C051,$02,b$01 Change it.
  $C053,$01 Use it as the length of the pulse.
  $C054,$03 Make a single cycle using #R$C062.
N $C057 Loop back until all of the cycles have been made.
  $C057,$01 Count down the pulses.
  $C058,$02 Loop back until all of the pulses have been played.
  $C05A,$01 Return.

c $C05B Play Wave Sequence
@ $C05B label=PlayWaveSequence
D $C05B Makes a tone, which is made of a number of cycles.
E $C05B View the equivalent code in;
. #LIST
. { #GUNFRIGHT$AF5F }
. { #PENTAGRAM$D67B }
. LIST#
R $C05B B Pitch (the higher it is, the lower the note)
R $C05B C Number of cycles
  $C05B,$03 Make a single cycle using #R$C062.
  $C05E,$03 Loop back until all of the cycles have been made.
  $C061,$01 Return.

c $C062 Play Square Wave
@ $C062 label=PlaySquareWave
D $C062 Plays a single beep by switching the speaker on, waiting, switching it
. off and waiting again. The bigger the pitch, the longer the beep. The border
. is set to black.
E $C062 View the equivalent code in;
. #LIST
. { #CYBERUN$71E0 }
. { #GUNFRIGHT$AF66 }
. { #NIGHTSHADE$C471 }
. { #PENTAGRAM$D682 }
. { #PSSST$64AA }
. { #SABREWULF$BF74 }
. LIST#
R $C062 B Pitch
N $C062 Hold the speaker on, then off.
  $C062,$04 Switch the speaker on.
  $C066,$01 Keep the pitch in #REGa.
@ $C067 label=PlaySquareWave_FirstWait
  $C067,$02 Wait for a time that depends on the pitch.
  $C069,$01 Restore the pitch.
  $C06A,$03 Switch the speaker off.
  $C06D,$01 Keep the pitch in #REGa.
@ $C06E label=PlaySquareWave_SecondWait
  $C06E,$02 Wait for the second half of the beep.
  $C070,$01 Restore the pitch.
  $C071,$01 Return.

c $C072 Make Explosion Sound
@ $C072 label=MakeExplosionSound
D $C072 Makes a burst of noise, made of four short tones with pitches that come
. from bytes of the ROM picked at random.
. #HTML(#AUDIO0(explosion.wav)(#INCLUDE(Explosion)))
  $C072,$05 Pick a random page of the ROM...
  $C077,$04 ...and a random place in it.
  $C07B,$02 There are four tones.
@ $C07D label=MakeExplosionSound_Loop
  $C07D,$02 Fetch a byte of the ROM, and move on to the next one.
  $C07F,$02 Keep the lower seven bits of it.
  $C081,$02 Make sure that the pitch is at least #N$8F.
  $C083,$01 Use it as the pitch.
  $C084,$02 Each tone is made of one cycle.
  $C086,$03 Make the tone using #R$C05B.
  $C089,$03 Loop back until all four tones have been made.
  $C08C,$01 Return.

c $C08D Make Noise If Visible
@ $C08D label=MakeNoiseIfVisible
D $C08D Makes a burst of noise, if the entity is visible. It is made of sixteen
. short tones with pitches that come from bytes of the ROM picked at random.
. #HTML(#AUDIO0(random-noise.wav)(#INCLUDE(RandomNoise)))
R $C08D IX Entity
  $C08D,$05 Return if the entity cannot be seen.
  $C092,$05 Pick a random page of the ROM...
  $C097,$04 ...and a random place in it.
  $C09B,$02 There are sixteen tones.
@ $C09D label=MakeNoiseIfVisible_Loop
  $C09D,$02 Fetch a byte of the ROM, and move on to the next one.
  $C09F,$02 Keep the lower seven bits of it.
  $C0A1,$01 Use it as the pitch.
  $C0A2,$02 Each tone is made of one cycle.
  $C0A4,$03 Make the tone using #R$C05B.
  $C0A7,$03 Loop back until all sixteen tones have been made.
  $C0AA,$01 Return.

c $C0AB Read Keys
@ $C0AB label=ReadKeys
D $C0AB Reads the keyboard.
R $C0AB A High byte of the port (zero reads every half row)
R $C0AB O:A The keys that are pressed, in bits 0 to 4
R $C0AB O:F Zero flag set if no keys are pressed
  $C0AB,$01 Save #REGbc.
  $C0AC,$03 Set up the port.
  $C0AF,$02 Read the keys.
  $C0B1,$01 Restore #REGbc.
  $C0B2,$01 Make a set bit mean that a key is pressed...
  $C0B3,$02 ...and keep only the bits of the five keys.
  $C0B5,$01 Return.

c $C0B6 Play Music Until Key Pressed
@ $C0B6 label=PlayMusic_WaitKey
D $C0B6 Plays a tune, but only the first time that it is used, and stops if a
. key is pressed. The tune is a list of notes that ends with #N$FF. See #R$C0DA
. for what the notes are. After the tune has been played, nothing happens until
. #R$9637 is cleared.
.
. The tunes played by this routine are:
. #TABLE(default,centre,centre)
. { =h Tune | =h Sound }
. { Title Tune |
. #HTML(#AUDIO0(title-tune.wav)(#INCLUDE(TitleTune))) }
. TABLE#
E $C0B6 View the equivalent code in;
. #LIST
. { #GUNFRIGHT$AF76 }
. { #NIGHTSHADE$C63D }
. { #PENTAGRAM$D69C }
. LIST#
R $C0B6 DE The address of the tune
  $C0B6,$03 Point #REGhl at the flag that records that a tune has been played.
  $C0B9,$01 Fetch the flag.
  $C0BA,$02 Return if the tune has already been played.
  $C0BC,$02 Set the flag.
N $C0BE Select every half row of the keyboard.
@ $C0BE label=PlayMusic_WaitKey_Loop
  $C0BE,$04 Read every row of the keyboard.
  $C0C2,$02 Jump to #R$C0C5 if no key is pressed.
  $C0C4,$01 Return as a key has been pressed.
N $C0C5 Play the next note.
@ $C0C5 label=PlayMusic_WaitKey_Next
  $C0C5,$01 Fetch the next note.
  $C0C6,$04 Jump to #R$C0D9 if the terminator has been reached.
  $C0CA,$03 Play the note using #R$C0DA.
  $C0CD,$02 Loop back for the next note.

c $C0CF Play Music
@ $C0CF label=PlayMusic
D $C0CF Plays a tune, which cannot be stopped. A tune is a list of notes (see
. #R$C0DA) which ends with #N$FF.
.
. The tunes played by this routine are:
. #TABLE(default,centre,centre)
. { =h Tune | =h Sound }
. { Start Tune |
. #HTML(#AUDIO0(start-tune.wav)(#INCLUDE(StartTune))) }
. { Level Complete Tune |
. #HTML(#AUDIO0(level-complete-tune.wav)(#INCLUDE(LevelCompleteTune))) }
. { Game Over Tune |
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune))) }
. TABLE#
E $C0CF View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4BA }
. { #CYBERUN$9AA9 }
. { #GUNFRIGHT$AF8F }
. { #NIGHTSHADE$C656 }
. { #PENTAGRAM$D6B5 }
. { #SABREWULF$BD6E }
. LIST#
R $C0CF DE Address of the tune
N $C0CF Play each note until #N$FF.
  $C0CF,$01 Fetch the next note.
  $C0D0,$04 Jump to #R$C0D9 if it is #N$FF.
  $C0D4,$03 Play the note using #R$C0DA.
  $C0D7,$02 Loop back for the next note.
@ $C0D9 label=PlayMusic_Return
  $C0D9,$01 Return.

c $C0DA Play Note
@ $C0DA label=PlayNote
D $C0DA Plays a note of a tune, or a rest if the note number is zero.
. Bits 0 to 5 select the entry in #R$C132 that holds the two delays of a cycle
. and the number of cycles. Bits 6 and 7 are the length less one, which
. multiplies the number of cycles, so the note is one to four times as long.
E $C0DA View the equivalent code in;
. #LIST
. { #ALIENEIGHT$B4C5 }
. { #CYBERUN$9AB4 }
. { #GUNFRIGHT$AF9A }
. { #NIGHTSHADE$C661 }
. { #PENTAGRAM$D6C0 }
. { #SABREWULF$BD7B }
. LIST#
R $C0DA A The note
R $C0DA DE Address of the note
R $C0DA O:DE Address of the next note
  $C0DA,$02,b$01 Keep the note number.
  $C0DC,$02 Jump to make a rest if the note number is zero.
N $C0DE Look up the delays and the number of cycles.
  $C0DE,$03 Set #REGhl to the note number.
  $C0E1,$01 Double the number.
  $C0E2,$03 ...and add the note number to give three times it, using #R$BF92.
  $C0E5,$04 Add the address of the table of notes.
  $C0E9,$01 Fetch the first delay.
  $C0EA,$01 Move on.
  $C0EB,$01 Fetch the second delay.
  $C0EC,$01 Move on.
  $C0ED,$01 Fetch the number of cycles of the shortest note.
  $C0EE,$02 Set #REGh to #N$00.
N $C0F0 Bits 6 and 7 are the length, less one.
  $C0F0,$01 Fetch the note again.
  $C0F1,$02 Move bits 6 and 7 to bits 0 and 1.
  $C0F3,$02,b$01 Keep bits 0 and 1.
  $C0F5,$01 Add one.
  $C0F6,$01 Save the address of the note.
  $C0F7,$02 Copy the number of cycles of the shortest note into #REGde.
N $C0F9 Multiply the number of cycles by the length.
@ $C0F9 label=PlayMusic_Process_Multiply
  $C0F9,$01 Count down the length.
  $C0FA,$02 Jump to #R$C0FF if the length has been used up.
  $C0FC,$01 Otherwise add on the number of cycles of the shortest note again...
  $C0FD,$02 Jump to #R$C0F9.
@ $C0FF label=PlayMusic_Process_Finished
  $C0FF,$01 Restore the note address from the stack.
N $C100 Each pass makes one cycle of the note.
@ $C100 label=PlayMusic_Process_Cycle
  $C100,$01 Stash the delays on the stack.
  $C101,$01 Set #REGa to #N$00.
  $C102,$02 Turn the speaker off.
@ $C104 label=PlayMusic_Process_LowWait
  $C104,$02 Wait for the time of the low half of a cycle...
N $C106 Count down the rest of the delay.
  $C106,$01 Count down the second delay.
  $C107,$02 Jump to #R$C104 until it has finished.
  $C109,$01 Restore the delays from the stack.
  $C10A,$01 Stash the delays on the stack.
  $C10B,$02 Set bit 4.
  $C10D,$02 Turn the speaker on.
@ $C10F label=PlayMusic_Process_HighWait
  $C10F,$02 Wait for the time of the high half of a cycle...
N $C111 Count down the rest of the delay.
  $C111,$01 Count down the second delay.
  $C112,$02 Jump to #R$C10F until it has finished.
  $C114,$01 Restore the delays from the stack.
N $C115 Count down the number of cycles, and loop back until it reaches zero.
  $C115,$01 Count down the cycles.
  $C116,$04 Jump to #R$C100 until all of the cycles have been played.
  $C11A,$01 Move on to the next note.
  $C11B,$01 Return.

c $C11C Play Rest
@ $C11C label=PlayRest
D $C11C Waits for the length of a rest, which is one to four times as long as
. the shortest. It is used by #R$C0DA.
E $C11C View the equivalent code in;
. #LIST
. { #GUNFRIGHT$AFDC }
. LIST#
R $C11C DE The address of the rest
R $C11C O:DE The address after the rest
N $C11C Work out the length of the rest in beats.
  $C11C,$01 Fetch the rest.
  $C11D,$01 Move on to the next note.
  $C11E,$02 Rotate the length bits into the bottom of the byte.
  $C120,$02,b$01 Keep them.
  $C122,$01 Add one to get the length in beats.
  $C123,$01 Copy the length into #REGl.
  $C124,$03 Set the length of a beat.
N $C127 Wait for each beat.
@ $C127 label=PlayRest_Loop
  $C127,$01 Stash the length of a beat on the stack.
@ $C128 label=PlayRest_Wait
  $C128,$01 Count down.
  $C129,$04 Jump to #R$C128 if the count is not zero.
  $C12D,$01 Retrieve the length of a beat.
N $C12E Loop back until the length has been counted down.
  $C12E,$01 Count down the beats.
  $C12F,$02 Loop back until the rest is over.
  $C131,$01 Return.

b $C132 Note Table
@ $C132 label=NoteTable
D $C132 The notes that are used by #R$C0DA, which are numbered from #N$00. There
. are three bytes for each note. They are the delay for each half of a cycle, as
. two bytes (the first is the number of repeats of the second), and then the
. number of cycles in the shortest note. The first entry is for the rests, which
. are not played.
B $C132,$B7,$03

b $C1E9 Title Tune
@ $C1E9 label=TitleTune
D $C1E9 The tune that is played on the menu, which is a list of notes that ends
. with #N$FF. The bottom six bits of each byte are the note and the top two bits
. are one less than its length.
. #HTML(#AUDIO0(title-tune.wav)(#INCLUDE(TitleTune)))
B $C1E9,$A0,$10

b $C289 Start Game Tune
@ $C289 label=StartGameTune
D $C289 The tune that is played when a game is started.
. #HTML(#AUDIO0(start-tune.wav)(#INCLUDE(StartTune)))
B $C289,$1E,$10

b $C2A7 Round Won Tune
@ $C2A7 label=RoundWonTune
D $C2A7 The tune that is played when a round has been won.
. #HTML(#AUDIO0(level-complete-tune.wav)(#INCLUDE(LevelCompleteTune)))
B $C2A7,$42,$10

b $C2E9 Game Lost Tune
@ $C2E9 label=GameLostTune
D $C2E9 The tune that is played when the game is lost.
. #HTML(#AUDIO0(game-over-tune.wav)(#INCLUDE(GameOverTune)))
B $C2E9,$17,$10

b $C300 Unused Tunes
@ $C300 label=UnusedTune1
D $C300 Two tunes that are not used.
B $C300,$1C,$10
@ $C31C label=UnusedTune2
B $C31C,$20,$10

b $C33C Font
@ $C33C label=Font
D $C33C The characters that are used for the text in the game, which start with
. the space (character code #N$20), so that the character set pointer is set
. #N$0100 bytes before this.
E $C33C View the equivalent code in;
. #LIST
. { #ALIENEIGHT$6308 }
. { #KNIGHTLORE$6108 }
. { #NIGHTSHADE$6CDE }
. { #PENTAGRAM$8355 }
. { #UNDERWURLDE$EEA4 }
. LIST#
B $C33C,$08,$08 #UDG(#PC)
L $C33C,$08,$3B
B $C514,$01 Unused.

g $C515 Map
@ $C515 label=Map
D $C515 The map of the world, which is made of #N$40 columns and #N$40 rows of
. cells, although only the first #N$31 columns and rows have anything in them.
. The lower four bits of each cell are the type that it is now, and the upper
. four bits are the type that it started as. Each row of the map is #N$40 bytes
. long, and the first row is at the top. The walls between the nine sectors of
. #N$10 by #N$10 cells are the types #N$04 and #N($05), and #N$0C and #N$05
. where they meet. The other types are described with the templates that
. are used to draw them.
B $C515,$C40,$40

g $D155 Unused Map
@ $D155 label=MapUnused
D $D155 The rest of the area that is cleared when the map is reset. Nothing is
. ever put in it.
S $D155,$0200,$0200

g $D355 Draw List
@ $D355 label=DrawListEntries
D $D355 The list of the sprites to be drawn. Each entry is three bytes: the
. type, the horizontal position and the height. It is ended by an entry with a
. type of zero. It is built in every frame, sorted by #R$BF22 and drawn by
. #R$BF6A. Only the start of this area is ever used, as the list is not long.
B $D355,$02,$01
@ $D357 label=DrawListEntries_FirstHeight
B $D357,$01,$01
B $D358,$02,$01
@ $D35A label=DrawListEntries_SecondHeight
B $D35A,$01,$01
S $D35B,$0C9F,$03

g $E000 Shift Tables
@ $E000 label=ShiftTables
D $E000 The tables that are used to shift the bytes of a sprite to the right by
. one to seven pixels, which are built by #R$B294. There are two pages for each
. shift, which hold the low bytes and the high bytes of each byte of the sprite
. when it is shifted. The page for the low bytes starts at #N$EF00 for no shift,
. and moves down by two pages for each pixel of shift. The page below it is for
. the high bytes.
S $E000,$1000,$0100

g $F000 Reversed Bytes
@ $F000 label=ReversedBytes
D $F000 The table that gives each byte with its bits in the opposite order,
. which is built by #R$B294 and used to flip a sprite.
S $F000,$0100,$0100

g $F100 Unused Memory
@ $F100 label=UnusedMemory
D $F100 This area is not used.
S $F100,$0480,$0480

g $F580 Play Window Buffer
@ $F580 label=PlayWindowBuffer
D $F580 The off-screen buffer that the play window is drawn into, which is
. copied to the screen by #R$B21C. It is #N$70 lines of #N$18 bytes, and the
. first line is at the bottom of the window. Only the middle #N$14 bytes of each
. line are shown, as there are margins of two bytes at each end. The snapshot
. has some left over contents.
B $F580,$0A80,$18
