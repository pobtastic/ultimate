> $4000 @org=$4000
> $4000 @start=$5B80
b $4000 Loading screen
D $4000 #UDGTABLE { =h Atic Atac Loading Screen } { #SCR$02(loading) } UDGTABLE#
@ $4000 label=Loading
B $4000,$1800,$20 Pixels
B $5800,$0300,$20 Attributes

i $5B00

c $5B80 Decryption Routine
N $5B80 Runs "RRD" on every byte from #N$5FFF-#N$DBFF.
E $5B80 View the equivalent code in #LUNARJETMAN$5B80.
E $5B80 Earlier Ultimate games use a much simpler mechanism;
. #LIST
. { #COOKIE$5B80 }
. { #JETPAC$5B80 }
. { #PSSST$5B80 }
. { #TRANZAM$5B80 }
. LIST#
@ $5B80 label=GameEntry
  $5B80,$03 #REGhl=#N$5FFF.
  $5B83,$03 #REGbc=#N$007C.
  $5B86,$01 Reset the flags.
@ $5B87 label=Decryption_Loop
  $5B87,$02 RRD operation.
  $5B89,$01 Increment #REGhl by one.
  $5B8A,$02 Decrease counter by one and loop back to #R$5B87 until counter is zero.
  $5B8C,$01 Decrease #REGc by one.
  $5B8D,$02 Loop back to #R$5B87 until #REGc is zero.
  $5B8F,$03 Jump to #R$6000.

i $5B92

g $5E00 Game Options
@ $5E00 label=GameOptions
D $5E00 #TABLE(default,centre,centre,centre,centre)
. { =h Byte | =h Binary | =h Character | =h Option }
. { #N$00 | #EVAL($00, $02, $08) | Knight | Keyboard }
. { #N$02 | #EVAL($02, $02, $08) | Knight | Kempston Joystick }
. { #N$04 | #EVAL($04, $02, $08) | Knight | Cursor Joystick }
. { #N$08 | #EVAL($08, $02, $08) | Wizard | Keyboard }
. { #N$0A | #EVAL($0A, $02, $08) | Wizard | Kempston Joystick }
. { #N$0C | #EVAL($0C, $02, $08) | Wizard | Cursor Joystick }
. { #N$10 | #EVAL($10, $02, $08) | Serf | Keyboard }
. { #N$12 | #EVAL($12, $02, $08) | Serf | Kempston Joystick }
. { #N$14 | #EVAL($14, $02, $08) | Serf | Cursor Joystick }
. TABLE#
B $5E00,$01

g $5E01 Font Pointer
D $5E01 Holds a pointer to the currently used font data.
@ $5E01 label=FontPointer
W $5E01,$02

g $5E03 Last FRAMES
B $5E03,$01

g $5E04 In Handlers
g $5E05 Rand8
W $5E05,$02

s $5E07

g $5E10 Width Bytes
B $5E10,$01

g $5E11 Height Lines
B $5E11,$01

g $5E12 Counter Low
@ $5E12 label=CounterLow
B $5E12,$01

g $5E13 Counter High
@ $5E13 label=CounterHigh
B $5E13,$01

g $5E14 Game Flags
@ $5E14 label=GameFlags
B $5E14,$01

g $5E15 Saved Graphic
B $5E15,$01

g $5E16 Saved X
@ $5E16 label=Saved_X
B $5E16,$01

g $5E17 Saved Y
@ $5E17 label=Saved_Y
B $5E17,$01

g $5E18 Some Width
B $5E18,$01

g $5E19 Some Height
B $5E19,$01

g $5E1A Room Attribute
@ $5E1A label=CurrentRoom_Attribute
B $5E1A,$01

g $5E1B Room Pointer
@ $5E1B label=CurrentRoom
W $5E1B,$02

g $5E1D Room Width
@ $5E1D label=CurrentRoom_Width
B $5E1D,$01

g $5E1E Room Height
@ $5E1E label=CurrentRoom_Height
B $5E1E,$01

g $5E1F Pickup Flags
g $5E20 Pickup Pressed

g $5E21 Lives
@ $5E21 label=PlayerLives
B $5E21,$01

g $5E22 Current menu item colour attribute
@ $5E22 label=Current_MenuAttr

g $5E23 Line Counter
g $5E24 Line Flags

g $5E25 Number Creatures
D $5E25 Number of creatures processed this frame.
@ $5E25 label=NumCreatures

g $5E26 Last Creature Room
g $5E27 Creature Delay

g $5E28 Player Energy
@ $5E28 label=PlayerEnergy
B $5E28,$01

g $5E29 Chicken Level
@ $5E29 label=ChickenLevel
B $5E29,$01

g $5E2A Score
D $5E2A 3-byte representation of the score.
@ $5E2A label=Score_1
  $5E2A,$01 Byte #1.
@ $5E2B label=Score_2
  $5E2B,$01 Byte #2.
@ $5E2C label=Score_3
  $5E2C,$01 Byte #3.

g $5E2D In Doorway

g $5E2E Door Timer

g $5E2F Walk Counter

g $5E30 Inventory 1
B $5E30,$04,$01
g $5E34 Inventory 2
B $5E34,$04,$01
g $5E38 Inventory 3
B $5E38,$04,$01

g $5E3C Flash Timer

g $5E3D Clock Hours
@ $5E3D label=ClockHours
B $5E3D,$01

g $5E3E Clock Minutes
@ $5E3E label=ClockMinutes
B $5E3E,$01

g $5E3F Clock Seconds
@ $5E3F label=ClockSeconds
B $5E3F,$01

g $5E40 Visited Rooms
@ $5E40 label=VisitedRooms
E $5E40 View the equivalent code in;
. #LIST
. { #SABREWULF$96BF }
. LIST#
B $5E40,$14,$01

g $5E54 Visited Percentage
@ $5E54 label=VisitedPercentage
B $5E54,$01

g $5E55 Food Pointer
@ $5E55 label=FoodPointer
W $5E55,$02

c $6000 Security Check
E $6000 View the equivalent code in;
. #LIST
. { #COOKIE$5F00 }
. { #JETPAC$61E5 }
. { #LUNARJETMAN$8000 }
. { #PSSST$61C6 }
. { #TRANZAM$5F00 }
. LIST#
@ $6000 label=SecurityCheck
  $6000,$01 Disable interrupts.
  $6001,$03 Set the stack pointer to #N$5E00.
  $6004,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>+#N$01.)
  $6007,$03 Return if #REGa is not #N$25.
  $600A,$03 Jump to #R$7C19.

g $600D Player Initialisation Data
@ $600D label=Initialisation_Player
  $600D,$08

g $6015 Weapon Initialisation Data
@ $6015 label=Initialisation_Weapon
  $6015,$08

g $601D Sound Initialisation Data
@ $601D label=Initialisation_Sound
  $601D,$08

g $6025 A.C.G. Initialisation Data
@ $6025 label=Initialisation_Key_ACG
  $6025,$18,$08

g $603D Key Initialisation Data
@ $603D label=Initialisation_Key_Green
@ $6045 label=Initialisation_Key_Red
@ $604D label=Initialisation_Key_Cyan
@ $6055 label=Initialisation_Key_Yellow

g $605D Leaf Initialisation Data
@ $605D label=Initialisation_Leaf

g $6065 Tombstone 1 Initialisation Data
@ $6065 label=Initialisation_Tombstone_1

g $606D Tombstone 2 Initialisation Data
@ $606D label=Initialisation_Tombstone_2

g $6075 Tombstone 3 Initialisation Data
@ $6075 label=Initialisation_Tombstone_3

g $607D Tombstone 4 Initialisation Data
@ $607D label=Initialisation_Tombstone_4

g $6085 Crucifix Initialisation Data
@ $6085 label=Initialisation_Crucifix

g $608D Spanner Initialisation Data
@ $608D label=Initialisation_Spanner

g $6095 Wine Initialisation Data
@ $6095 label=Initialisation_Wine

g $609D Coin Initialisation Data
@ $609D label=Initialisation_Coin

g $60A5 Wing Initialisation Data
@ $60A5 label=Initialisation_Wing

g $60AD Whip Initialisation Data
@ $60AD label=Initialisation_Whip

g $60B5 Frog Leg Initialisation Data
@ $60B5 label=Initialisation_Frog_Leg

g $60BD Gem Initialisation Data
@ $60BD label=Initialisation_Gem

g $60C5 Moneybag Initialisation Data
@ $60C5 label=Initialisation_Moneybag

g $60CD Skull Initialisation Data
@ $60CD label=Initialisation_Skull

g $60D5 Can Initialisation Data
@ $60D5 label=Initialisation_Can
  $60D5,$30,$08

g $6105 Candy Initialisation Data
@ $6105 label=Initialisation_Candy
  $6105,$30,$08

g $6135 Chop Initialisation Data
@ $6135 label=Initialisation_Chop
  $6135,$30,$08

g $6165 Lollipop Initialisation Data
@ $6165 label=Initialisation_Lollipop

g $640D Mummy Initialisation Data
@ $640D label=Initialisation_Mummy

g $641D Dracula Initialisation Data
@ $641D label=Initialisation_Dracula

g $642D Devil Initialisation Data
@ $642D label=Initialisation_Devil

g $643D Frankenstein Initialisation Data
@ $643D label=Initialisation_Frankenstein

g $644D Hunchback Initialisation Data
@ $644D label=Initialisation_Hunchback

g $645D Door: #N$07 / #N$00
@ $645D label=Door_07_00
  $645D,$10,$08

g $646D Door: #N$19 / #N$00
@ $646D label=Door_19_00
  $646D,$10,$08

g $647D Door: #N$01 / #N$00
@ $647D label=Door_01_00
  $647D,$10,$08

g $648D Door: #N$02 / #N$01
@ $648D label=Door_02_01
  $648D,$10,$08

g $649D Door: #N$03 / #N$02
@ $649D label=Door_03_02
  $649D,$10,$08

g $64AD Door: #N$04 / #N$03
@ $64AD label=Door_04_03
  $64AD,$10,$08

g $64BD Door: #N$19 / #N$04
@ $64BD label=Door_19_04
  $64BD,$10,$08

g $64CD Door: #N$05 / #N$04
@ $64CD label=Door_05_04
  $64CD,$10,$08

g $64DD Door: #N$06 / #N$05
@ $64DD label=Door_06_05
  $64DD,$10,$08

g $64ED Door: #N$1A / #N$06
@ $64ED label=Door_1A_06
  $64ED,$10,$08

g $64FD Door: #N$08 / #N$06
@ $64FD label=Door_08_06
  $64FD,$10,$08

g $650D Door: #N$07 / #N$06
@ $650D label=Door_07_06
  $650D,$10,$08

g $651D Door: #N$09 / #N$08
@ $651D label=Door_09_08
  $651D,$10,$08

g $652D Door: #N$0A / #N$09
@ $652D label=Door_0A_09
  $652D,$10,$08

g $653D Door: #N$0B / #N$0A
@ $653D label=Door_0B_0A
  $653D,$10,$08

g $654D Door: #N$0C / #N$0B
@ $654D label=Door_0C_0B
  $654D,$10,$08

g $655D Door: #N$0D / #N$0C
@ $655D label=Door_0D_0C
  $655D,$10,$08

g $656D Door: #N$0E / #N$0D
@ $656D label=Door_0E_0D
  $656D,$10,$08

g $657D Door: #N$0F / #N$0E
@ $657D label=Door_0F_0E
  $657D,$10,$08

g $658D Door: #N$10 / #N$0F
@ $658D label=Door_10_0F
  $658D,$10,$08

g $659D Door: #N$11 / #N$10
@ $659D label=Door_11_10
  $659D,$10,$08

g $65AD Door: #N$12 / #N$11
@ $65AD label=Door_12_11
  $65AD,$10,$08

g $65BD Door: #N$13 / #N$12
@ $65BD label=Door_13_12
  $65BD,$10,$08

g $65CD Door: #N$14 / #N$13
@ $65CD label=Door_14_13
  $65CD,$10,$08

g $65DD Door: #N$15 / #N$14
@ $65DD label=Door_15_14
  $65DD,$10,$08

g $65ED Door: #N$16 / #N$15
@ $65ED label=Door_16_15
  $65ED,$10,$08

g $65FD Door: #N$17 / #N$16
@ $65FD label=Door_17_16
  $65FD,$10,$08

g $660D Door: #N$18 / #N$17
@ $660D label=Door_18_17
  $660D,$10,$08

g $661D Door: #N$18 / #N$02
@ $661D label=Door_18_02
  $661D,$10,$08

g $662D Door: #N$1A / #N$1B
@ $662D label=Door_1A_1B
  $662D,$10,$08

g $663D Door: #N$1B / #N$1C
@ $663D label=Door_1B_1C
  $663D,$10,$08

g $664D Door: #N$1C / #N$1D
@ $664D label=Door_1C_1D
  $664D,$10,$08

g $665D Door: #N$1E / #N$1F
@ $665D label=Door_1E_1F
  $665D,$10,$08

g $666D Door: #N$1F / #N$20
@ $666D label=Door_1F_20
  $666D,$10,$08

g $667D Door: #N$20 / #N$21
@ $667D label=Door_20_21
  $667D,$10,$08

g $668D Door: #N$21 / #N$22
@ $668D label=Door_21_22
  $668D,$10,$08

g $669D Door: #N$22 / #N$23
@ $669D label=Door_22_23
  $669D,$10,$08

g $66AD Door: #N$23 / #N$24
@ $66AD label=Door_23_24
  $66AD,$10,$08

g $66BD Door: #N$24 / #N$25
@ $66BD label=Door_24_25
  $66BD,$10,$08

g $66CD Door: #N$25 / #N$1E
@ $66CD label=Door_25_1E
  $66CD,$10,$08

g $66DD Door: #N$24 / #N$26
@ $66DD label=Door_24_26
  $66DD,$10,$08

g $66ED Door: #N$03 / #N$26
@ $66ED label=Door_03_26
  $66ED,$10,$08

g $66FD Door: #N$27 / #N$28
@ $66FD label=Door_27_28
  $66FD,$10,$08

g $670D Door: #N$28 / #N$29
@ $670D label=Door_28_29
  $670D,$10,$08

g $671D Door: #N$29 / #N$2A
@ $671D label=Door_29_2A
  $671D,$10,$08

g $672D Door: #N$2A / #N$2B
@ $672D label=Door_2A_2B
  $672D,$10,$08

g $673D Door: #N$2B / #N$2C
@ $673D label=Door_2B_2C
  $673D,$10,$08

g $674D Door: #N$2C / #N$2D
@ $674D label=Door_2C_2D
  $674D,$10,$08

g $675D Door: #N$2D / #N$2E
@ $675D label=Door_2D_2E
  $675D,$10,$08

g $676D Door: #N$2E / #N$27
@ $676D label=Door_2E_27
  $676D,$10,$08

g $677D Door: #N$27 / #N$2F
@ $677D label=Door_27_2F
  $677D,$10,$08

g $678D Door: #N$20 / #N$2F
@ $678D label=Door_20_2F
  $678D,$10,$08

g $679D Door: #N$30 / #N$31
@ $679D label=Door_30_31
  $679D,$10,$08

g $67AD Door: #N$31 / #N$32
@ $67AD label=Door_31_32
  $67AD,$10,$08

g $67BD Door: #N$32 / #N$33
@ $67BD label=Door_32_33
  $67BD,$10,$08

g $67CD Door: #N$33 / #N$34
@ $67CD label=Door_33_34
  $67CD,$10,$08

g $67DD Door: #N$34 / #N$35
@ $67DD label=Door_34_35
  $67DD,$10,$08

g $67ED Door: #N$33 / #N$36
@ $67ED label=Door_33_36
  $67ED,$10,$08

g $67FD Door: #N$36 / #N$37
@ $67FD label=Door_36_37
  $67FD,$10,$08

g $680D Door: #N$37 / #N$38
@ $680D label=Door_37_38
  $680D,$10,$08

g $681D Door: #N$38 / #N$39
@ $681D label=Door_38_39
  $681D,$10,$08

g $682D Door: #N$38 / #N$3A
@ $682D label=Door_38_3A
  $682D,$10,$08

g $683D Door: #N$39 / #N$3B
@ $683D label=Door_39_3B
  $683D,$10,$08

g $684D Door: #N$3A / #N$3B
@ $684D label=Door_3A_3B
  $684D,$10,$08

g $685D Door: #N$3B / #N$3C
@ $685D label=Door_3B_3C
  $685D,$10,$08

g $686D Door: #N$3B / #N$3D
@ $686D label=Door_3B_3D
  $686D,$10,$08

g $687D Door: #N$3C / #N$3E
@ $687D label=Door_3C_3E
  $687D,$10,$08

g $688D Door: #N$3D / #N$3E
@ $688D label=Door_3D_3E
  $688D,$10,$08

g $689D Door: #N$3D / #N$3F
@ $689D label=Door_3D_3F
  $689D,$10,$08

g $68AD Door: #N$34 / #N$40
@ $68AD label=Door_34_40
  $68AD,$10,$08

g $68BD Door: #N$40 / #N$41
@ $68BD label=Door_40_41
  $68BD,$10,$08

g $68CD Door: #N$40 / #N$42
@ $68CD label=Door_40_42
  $68CD,$10,$08

g $68DD Door: #N$42 / #N$43
@ $68DD label=Door_42_43
  $68DD,$10,$08

g $68ED Door: #N$43 / #N$44
@ $68ED label=Door_43_44
  $68ED,$10,$08

g $68FD Door: #N$44 / #N$45
@ $68FD label=Door_44_45
  $68FD,$10,$08

g $690D Door: #N$43 / #N$46
@ $690D label=Door_43_46
  $690D,$10,$08

g $691D Door: #N$46 / #N$47
@ $691D label=Door_46_47
  $691D,$10,$08

g $692D Door: #N$47 / #N$48
@ $692D label=Door_47_48
  $692D,$10,$08

g $693D Door: #N$48 / #N$49
@ $693D label=Door_48_49
  $693D,$10,$08

g $694D Door: #N$48 / #N$4A
@ $694D label=Door_48_4A
  $694D,$10,$08

g $695D Door: #N$4A / #N$4B
@ $695D label=Door_4A_4B
  $695D,$10,$08

g $696D Door: #N$4B / #N$4C
@ $696D label=Door_4B_4C
  $696D,$10,$08

g $697D Door: #N$48 / #N$4D
@ $697D label=Door_48_4D
  $697D,$10,$08

g $698D Door: #N$4D / #N$4E
@ $698D label=Door_4D_4E
  $698D,$10,$08

g $699D Door: #N$4E / #N$4F
@ $699D label=Door_4E_4F
  $699D,$10,$08

g $69AD Door: #N$4F / #N$50
@ $69AD label=Door_4F_50
  $69AD,$10,$08

g $69BD Door: #N$50 / #N$51
@ $69BD label=Door_50_51
  $69BD,$10,$08

g $69CD Door: #N$50 / #N$52
@ $69CD label=Door_50_52
  $69CD,$10,$08

g $69DD Door: #N$52 / #N$53
@ $69DD label=Door_52_53
  $69DD,$10,$08

g $69ED Door: #N$1D / #N$43
@ $69ED label=Door_1D_43
  $69ED,$10,$08

g $69FD Door: #N$46 / #N$51
@ $69FD label=Door_46_51
  $69FD,$10,$08

g $6A0D Door: #N$4C / #N$55
@ $6A0D label=Door_4C_55
  $6A0D,$10,$08

g $6A1D Door: #N$54 / #N$55
@ $6A1D label=Door_54_55
  $6A1D,$10,$08

g $6A2D Door: #N$54 / #N$30
@ $6A2D label=Door_54_30
  $6A2D,$10,$08

g $6A3D Door: #N$2D / #N$75
@ $6A3D label=Door_2D_75
  $6A3D,$10,$08

g $6A4D Door: #N$75 / #N$76
@ $6A4D label=Door_75_76
  $6A4D,$10,$08

g $6A5D Door: #N$76 / #N$77
@ $6A5D label=Door_76_77
  $6A5D,$10,$08

g $6A6D Door: #N$77 / #N$78
@ $6A6D label=Door_77_78
  $6A6D,$10,$08

g $6A7D Door: #N$78 / #N$79
@ $6A7D label=Door_78_79
  $6A7D,$10,$08

g $6A8D Door: #N$79 / #N$7A
@ $6A8D label=Door_79_7A
  $6A8D,$10,$08

g $6A9D Door: #N$7A / #N$7B
@ $6A9D label=Door_7A_7B
  $6A9D,$10,$08

g $6AAD Door: #N$7B / #N$7C
@ $6AAD label=Door_7B_7C
  $6AAD,$10,$08

g $6ABD Door: #N$7C / #N$7D
@ $6ABD label=Door_7C_7D
  $6ABD,$10,$08

g $6ACD Door: #N$7D / #N$76
@ $6ACD label=Door_7D_76
  $6ACD,$10,$08

g $6ADD Door: #N$7A / #N$7E
@ $6ADD label=Door_7A_7E
  $6ADD,$10,$08

g $6AED Door: #N$7E / #N$29
@ $6AED label=Door_7E_29
  $6AED,$10,$08

g $6AFD Door: #N$21 / #N$88
@ $6AFD label=Door_21_88
  $6AFD,$10,$08

g $6B0D Door: #N$7F / #N$80
@ $6B0D label=Door_7F_80
  $6B0D,$10,$08

g $6B1D Door: #N$80 / #N$82
@ $6B1D label=Door_80_82
  $6B1D,$10,$08

g $6B2D Door: #N$82 / #N$81
@ $6B2D label=Door_82_81
  $6B2D,$10,$08

g $6B3D Door: #N$81 / #N$7F
@ $6B3D label=Door_81_7F
  $6B3D,$10,$08

g $6B4D Door: #N$82 / #N$87
@ $6B4D label=Door_82_87
  $6B4D,$10,$08

g $6B5D Door: #N$87 / #N$88
@ $6B5D label=Door_87_88
  $6B5D,$10,$08

g $6B6D Door: #N$87 / #N$8B
@ $6B6D label=Door_87_8B
  $6B6D,$10,$08

g $6B7D Door: #N$8B / #N$8C
@ $6B7D label=Door_8B_8C
  $6B7D,$10,$08

g $6B8D Door: #N$8C / #N$8D
@ $6B8D label=Door_8C_8D
  $6B8D,$10,$08

g $6B9D Door: #N$83 / #N$84
@ $6B9D label=Door_83_84
  $6B9D,$10,$08

g $6BAD Door: #N$84 / #N$86
@ $6BAD label=Door_84_86
  $6BAD,$10,$08

g $6BBD Door: #N$86 / #N$85
@ $6BBD label=Door_86_85
  $6BBD,$10,$08

g $6BCD Door: #N$85 / #N$83
@ $6BCD label=Door_85_83
  $6BCD,$10,$08

g $6BDD Door: #N$84 / #N$89
@ $6BDD label=Door_84_89
  $6BDD,$10,$08

g $6BED Door: #N$89 / #N$8D
@ $6BED label=Door_89_8D
  $6BED,$10,$08

g $6BFD Door: #N$89 / #N$8A
@ $6BFD label=Door_89_8A
  $6BFD,$10,$08

g $6C0D Door: #N$8A / #N$23
@ $6C0D label=Door_8A_23
  $6C0D,$10,$08

g $6C1D Door: #N$13 / #N$73
@ $6C1D label=Door_13_73
  $6C1D,$10,$08

g $6C2D Door: #N$11 / #N$6B
@ $6C2D label=Door_11_6B
  $6C2D,$10,$08

g $6C3D Door: #N$6B / #N$6C
@ $6C3D label=Door_6B_6C
  $6C3D,$10,$08

g $6C4D Door: #N$6C / #N$03
@ $6C4D label=Door_6C_03
  $6C4D,$10,$08

g $6C5D Door: #N$0F / #N$6D
@ $6C5D label=Door_0F_6D
  $6C5D,$10,$08

g $6C6D Door: #N$6D / #N$6E
@ $6C6D label=Door_6D_6E
  $6C6D,$10,$08

g $6C7D Door: #N$6E / #N$05
@ $6C7D label=Door_6E_05
  $6C7D,$10,$08

g $6C8D Door: #N$0D / #N$6F
@ $6C8D label=Door_0D_6F
  $6C8D,$10,$08

g $6C9D Door: #N$6F / #N$70
@ $6C9D label=Door_6F_70
  $6C9D,$10,$08

g $6CAD Door: #N$70 / #N$71
@ $6CAD label=Door_70_71
  $6CAD,$10,$08

g $6CBD Door: #N$71 / #N$72
@ $6CBD label=Door_71_72
  $6CBD,$10,$08

g $6CCD Door: #N$72 / #N$35
@ $6CCD label=Door_72_35
  $6CCD,$10,$08

g $6CDD Door: #N$30 / #N$74
@ $6CDD label=Door_30_74
  $6CDD,$10,$08

g $6CED Door: #N$56 / #N$57
@ $6CED label=Door_56_57
  $6CED,$10,$08

g $6CFD Door: #N$57 / #N$58
@ $6CFD label=Door_57_58
  $6CFD,$10,$08

g $6D0D Door: #N$58 / #N$59
@ $6D0D label=Door_58_59
  $6D0D,$10,$08

g $6D1D Door: #N$5A / #N$5B
@ $6D1D label=Door_5A_5B
  $6D1D,$10,$08

g $6D2D Door: #N$5B / #N$5C
@ $6D2D label=Door_5B_5C
  $6D2D,$10,$08

g $6D3D Door: #N$5C / #N$5D
@ $6D3D label=Door_5C_5D
  $6D3D,$10,$08

g $6D4D Door: #N$5E / #N$5F
@ $6D4D label=Door_5E_5F
  $6D4D,$10,$08

g $6D5D Door: #N$5F / #N$60
@ $6D5D label=Door_5F_60
  $6D5D,$10,$08

g $6D6D Door: #N$60 / #N$61
@ $6D6D label=Door_60_61
  $6D6D,$10,$08

g $6D7D Door: #N$62 / #N$63
@ $6D7D label=Door_62_63
  $6D7D,$10,$08

g $6D8D Door: #N$63 / #N$64
@ $6D8D label=Door_63_64
  $6D8D,$10,$08

g $6D9D Door: #N$64 / #N$65
@ $6D9D label=Door_64_65
  $6D9D,$10,$08

g $6DAD Door: #N$56 / #N$5A
@ $6DAD label=Door_56_5A
  $6DAD,$10,$08

g $6DBD Door: #N$5A / #N$5E
@ $6DBD label=Door_5A_5E
  $6DBD,$10,$08

g $6DCD Door: #N$5E / #N$62
@ $6DCD label=Door_5E_62
  $6DCD,$10,$08

g $6DDD Door: #N$57 / #N$5B
@ $6DDD label=Door_57_5B
  $6DDD,$10,$08

g $6DED Door: #N$5B / #N$5F
@ $6DED label=Door_5B_5F
  $6DED,$10,$08

g $6DFD Door: #N$5F / #N$63
@ $6DFD label=Door_5F_63
  $6DFD,$10,$08

g $6E0D Door: #N$58 / #N$5C
@ $6E0D label=Door_58_5C
  $6E0D,$10,$08

g $6E1D Door: #N$5C / #N$60
@ $6E1D label=Door_5C_60
  $6E1D,$10,$08

g $6E2D Door: #N$60 / #N$64
@ $6E2D label=Door_60_64
  $6E2D,$10,$08

g $6E3D Door: #N$59 / #N$5D
@ $6E3D label=Door_59_5D
  $6E3D,$10,$08

g $6E4D Door: #N$5D / #N$61
@ $6E4D label=Door_5D_61
  $6E4D,$10,$08

g $6E5D Door: #N$61 / #N$65
@ $6E5D label=Door_61_65
  $6E5D,$10,$08

g $6E6D Door: #N$67 / #N$56
@ $6E6D label=Door_67_56
  $6E6D,$10,$08

g $6E7D Door: #N$68 / #N$59
@ $6E7D label=Door_68_59
  $6E7D,$10,$08

g $6E8D Door: #N$69 / #N$56
@ $6E8D label=Door_69_56
  $6E8D,$10,$08

g $6E9D Door: #N$6A / #N$62
@ $6E9D label=Door_6A_62
  $6E9D,$10,$08

g $6EAD Door: #N$66 / #N$5B
@ $6EAD label=Door_66_5B
  $6EAD,$10,$08

g $6EBD Door: #N$66 / #N$5C
@ $6EBD label=Door_66_5C
  $6EBD,$10,$08

g $6ECD Door: #N$66 / #N$5F
@ $6ECD label=Door_66_5F
  $6ECD,$10,$08

g $6EDD Door: #N$66 / #N$60
@ $6EDD label=Door_66_60
  $6EDD,$10,$08

g $6EED Door: #N$65 / #N$1B
@ $6EED label=Door_65_1B
  $6EED,$10,$08

g $6EFD Door: #N$40 / #N$8F
@ $6EFD label=Door_40_8F
  $6EFD,$10,$08

g $6F0D Door: #N$54 / #N$90
@ $6F0D label=Door_54_90
  $6F0D,$10,$08

g $6F1D Door: #N$90 / #N$91
@ $6F1D label=Door_90_91
  $6F1D,$10,$08

g $6F2D Door: #N$91 / #N$92
@ $6F2D label=Door_91_92
  $6F2D,$10,$08

g $6F3D Door: #N$92 / #N$93
@ $6F3D label=Door_92_93
  $6F3D,$10,$08

g $6F4D Door: #N$93 / #N$94
@ $6F4D label=Door_93_94
  $6F4D,$10,$08

g $6F5D Door: #N$3A / #N$94
@ $6F5D label=Door_3A_94
  $6F5D,$10,$08

b $757D Room Table
@ $757D label=RoomTable
W $757D,$02 Room ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#EVAL((#PC - $757D) / 2)).
L $757D,$02,$95
W $76A7,$02 Room ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(None).

w $76A9 Room: #N$00
@ $76A9 label=Room_00
  $76C1,$02 Terminator.

w $76C3 Room: #N$01
@ $76C3 label=Room_01
  $76CB,$02 Terminator.

w $76CD Room: #N$02
@ $76CD label=Room_02
  $76D5,$02 Terminator.

w $76D7 Room: #N$03
@ $76D7 label=Room_03
  $76E3,$02 Terminator.

w $76E5 Room: #N$04
@ $76E5 label=Room_04
  $76EF,$02 Terminator.

w $76F1 Room: #N$05
@ $76F1 label=Room_05
  $76F9,$02 Terminator.

w $76FB Room: #N$06
@ $76FB label=Room_06
  $770B,$02 Terminator.

w $770D Room: #N$07
@ $770D label=Room_07
  $7715,$02 Terminator.

w $7717 Room: #N$08
@ $7717 label=Room_08
  $771F,$02 Terminator.

w $7721 Room: #N$09
@ $7721 label=Room_09
  $7731,$02 Terminator.

w $7733 Room: #N$0A
@ $7733 label=Room_0A
  $773B,$02 Terminator.

w $773D Room: #N$0B
@ $773D label=Room_0B
  $7745,$02 Terminator.

w $7747 Room: #N$0C
@ $7747 label=Room_0C
  $774F,$02 Terminator.

w $7751 Room: #N$0D
@ $7751 label=Room_0D
  $775D,$02 Terminator.

w $775F Room: #N$0E
@ $775F label=Room_0E
  $7769,$02 Terminator.

w $776B Room: #N$0F
@ $776B label=Room_0F
  $7773,$02 Terminator.

w $7775 Room: #N$10
@ $7775 label=Room_10
  $777B,$02 Terminator.

w $777D Room: #N$11
@ $777D label=Room_11
  $7785,$02 Terminator.

w $7787 Room: #N$12
@ $7787 label=Room_12
  $778D,$02 Terminator.

w $778F Room: #N$13
@ $778F label=Room_13
  $779B,$02 Terminator.

w $779D Room: #N$14
@ $779D label=Room_14
  $77A5,$02 Terminator.

w $77A7 Room: #N$15
@ $77A7 label=Room_15
  $77B3,$02 Terminator.

w $77B5 Room: #N$16
@ $77B5 label=Room_16
  $77BD,$02 Terminator.

w $77BF Room: #N$17
@ $77BF label=Room_17
  $77C9,$02 Terminator.

w $77CB Room: #N$18
@ $77CB label=Room_18
  $77D7,$02 Terminator.

w $77D9 Room: #N$19
@ $77D9 label=Room_19
  $77E1,$02 Terminator.

w $77E3 Room: #N$1A
@ $77E3 label=Room_1A
  $77E7,$02 Terminator.

w $77E9 Room: #N$1B
@ $77E9 label=Room_1B
  $77F1,$02 Terminator.

w $77F3 Room: #N$1C
@ $77F3 label=Room_1C
  $77F7,$02 Terminator.

w $77F9 Room: #N$1D
@ $77F9 label=Room_1D
  $77FD,$02 Terminator.

w $77FF Room: #N$1E
@ $77FF label=Room_1E
  $7803,$02 Terminator.

w $7805 Room: #N$1F
@ $7805 label=Room_1F
  $780B,$02 Terminator.

w $780D Room: #N$20
@ $780D label=Room_20
  $7813,$02 Terminator.

w $7815 Room: #N$21
@ $7815 label=Room_21
  $781F,$02 Terminator.

w $7821 Room: #N$22
@ $7821 label=Room_22
  $7827,$02 Terminator.

w $7829 Room: #N$23
@ $7829 label=Room_23
  $7831,$02 Terminator.

w $7833 Room: #N$24
@ $7833 label=Room_24
  $783D,$02 Terminator.

w $783F Room: #N$25
@ $783F label=Room_25
  $7845,$02 Terminator.

w $7847 Room: #N$26
@ $7847 label=Room_26
  $784B,$02 Terminator.

w $784D Room: #N$27
@ $784D label=Room_27
  $785B,$02 Terminator.

w $785D Room: #N$28
@ $785D label=Room_28
  $7861,$02 Terminator.

w $7863 Room: #N$29
@ $7863 label=Room_29
  $786F,$02 Terminator.

w $7871 Room: #N$2A
@ $7871 label=Room_2A
  $7879,$02 Terminator.

w $787B Room: #N$2B
@ $787B label=Room_2B
  $7883,$02 Terminator.

w $7885 Room: #N$2C
@ $7885 label=Room_2C
  $7889,$02 Terminator.

w $788B Room: #N$2D
@ $788B label=Room_2D
  $7897,$02 Terminator.

w $7899 Room: #N$2E
@ $7899 label=Room_2E
  $78A1,$02 Terminator.

w $78A3 Room: #N$2F
@ $78A3 label=Room_2F
  $78A7,$02 Terminator.

w $78A9 Room: #N$30
@ $78A9 label=Room_30
  $78AF,$02 Terminator.

w $78B1 Room: #N$31
@ $78B1 label=Room_31
  $78B5,$02 Terminator.

w $78B7 Room: #N$32
@ $78B7 label=Room_32
  $78BB,$02 Terminator.

w $78BD Room: #N$33
@ $78BD label=Room_33
  $78C5,$02 Terminator.

w $78C7 Room: #N$34
@ $78C7 label=Room_34
  $78CB,$02 Terminator.

w $78CD Room: #N$35
@ $78CD label=Room_35
  $78D3,$02 Terminator.

w $78D5 Room: #N$36
@ $78D5 label=Room_36
  $78D9,$02 Terminator.

w $78DB Room: #N$37
@ $78DB label=Room_37
  $78DF,$02 Terminator.

w $78E1 Room: #N$38
@ $78E1 label=Room_38
  $78E9,$02 Terminator.

w $78EB Room: #N$39
@ $78EB label=Room_39
  $78EF,$02 Terminator.

w $78F1 Room: #N$3A
@ $78F1 label=Room_3A
  $78F7,$02 Terminator.

w $78F9 Room: #N$3B
@ $78F9 label=Room_3B
  $7901,$02 Terminator.

w $7903 Room: #N$3C
@ $7903 label=Room_3C
  $7907,$02 Terminator.

w $7909 Room: #N$3D
@ $7909 label=Room_3D
  $7913,$02 Terminator.

w $7915 Room: #N$3E
@ $7915 label=Room_3E
  $791B,$02 Terminator.

w $791D Room: #N$3F
@ $791D label=Room_3F
  $7921,$02 Terminator.

w $7923 Room: #N$40
@ $7923 label=Room_40
  $792B,$02 Terminator.

w $792D Room: #N$41
@ $792D label=Room_41
  $7931,$02 Terminator.

w $7933 Room: #N$42
@ $7933 label=Room_42
  $7937,$02 Terminator.

w $7939 Room: #N$43
@ $7939 label=Room_43
  $7941,$02 Terminator.

w $7943 Room: #N$44
@ $7943 label=Room_44
  $7947,$02 Terminator.

w $7949 Room: #N$45
@ $7949 label=Room_45
  $794D,$02 Terminator.

w $794F Room: #N$46
@ $794F label=Room_46
  $7955,$02 Terminator.

w $7957 Room: #N$47
@ $7957 label=Room_47
  $795B,$02 Terminator.

w $795D Room: #N$48
@ $795D label=Room_48
  $7965,$02 Terminator.

w $7967 Room: #N$49
@ $7967 label=Room_49
  $796B,$02 Terminator.

w $796D Room: #N$4A
@ $796D label=Room_4A
  $7971,$02 Terminator.

w $7973 Room: #N$4B
@ $7973 label=Room_4B
  $797B,$02 Terminator.

w $797D Room: #N$4C
@ $797D label=Room_4C
  $7983,$02 Terminator.

w $7985 Room: #N$4D
@ $7985 label=Room_4D
  $7989,$02 Terminator.

w $798B Room: #N$4E
@ $798B label=Room_4E
  $7991,$02 Terminator.

w $7993 Room: #N$4F
@ $7993 label=Room_4F
  $7997,$02 Terminator.

w $7999 Room: #N$50
@ $7999 label=Room_50
  $799F,$02 Terminator.

w $79A1 Room: #N$51
@ $79A1 label=Room_51
  $79A5,$02 Terminator.

w $79A7 Room: #N$52
@ $79A7 label=Room_52
  $79AB,$02 Terminator.

w $79AD Room: #N$53
@ $79AD label=Room_53
  $79B3,$02 Terminator.

w $79B5 Room: #N$54
@ $79B5 label=Room_54
  $79BB,$02 Terminator.

w $79BD Room: #N$55
@ $79BD label=Room_55
  $79C3,$02 Terminator.

w $79C5 Room: #N$56
@ $79C5 label=Room_56
  $79D1,$02 Terminator.

w $79D3 Room: #N$57
@ $79D3 label=Room_57
  $79D9,$02 Terminator.

w $79DB Room: #N$58
@ $79DB label=Room_58
  $79E1,$02 Terminator.

w $79E3 Room: #N$59
@ $79E3 label=Room_59
  $79E9,$02 Terminator.

w $79EB Room: #N$5A
@ $79EB label=Room_5A
  $79F5,$02 Terminator.

w $79F7 Room: #N$5B
@ $79F7 label=Room_5B
  $7A03,$02 Terminator.

w $7A05 Room: #N$5C
@ $7A05 label=Room_5C
  $7A11,$02 Terminator.

w $7A13 Room: #N$5D
@ $7A13 label=Room_5D
  $7A1D,$02 Terminator.

w $7A1F Room: #N$5E
@ $7A1F label=Room_5E
  $7A25,$02 Terminator.

w $7A27 Room: #N$5F
@ $7A27 label=Room_5F
  $7A31,$02 Terminator.

w $7A33 Room: #N$60
@ $7A33 label=Room_60
  $7A3D,$02 Terminator.

w $7A3F Room: #N$61
@ $7A3F label=Room_61
  $7A49,$02 Terminator.

w $7A4B Room: #N$62
@ $7A4B label=Room_62
  $7A53,$02 Terminator.

w $7A55 Room: #N$63
@ $7A55 label=Room_63
  $7A5F,$02 Terminator.

w $7A61 Room: #N$64
@ $7A61 label=Room_64
  $7A69,$02 Terminator.

w $7A6B Room: #N$65
@ $7A6B label=Room_65
  $7A75,$02 Terminator.

w $7A77 Room: #N$66
@ $7A77 label=Room_66
  $7A89,$02 Terminator.

w $7A8B Room: #N$67
@ $7A8B label=Room_67
  $7A8F,$02 Terminator.

w $7A91 Room: #N$68
@ $7A91 label=Room_68
  $7A95,$02 Terminator.

w $7A97 Room: #N$69
@ $7A97 label=Room_69
  $7A9B,$02 Terminator.

w $7A9D Room: #N$6A
@ $7A9D label=Room_6A
  $7AA3,$02 Terminator.

w $7AA5 Room: #N$6B
@ $7AA5 label=Room_6B
  $7AAB,$02 Terminator.

w $7AAD Room: #N$6C
@ $7AAD label=Room_6C
  $7AB5,$02 Terminator.

w $7AB7 Room: #N$6D
@ $7AB7 label=Room_6D
  $7AC1,$02 Terminator.

w $7AC3 Room: #N$6E
@ $7AC3 label=Room_6E
  $7ACD,$02 Terminator.

w $7ACF Room: #N$6F
@ $7ACF label=Room_6F
  $7AD5,$02 Terminator.

w $7AD7 Room: #N$70
@ $7AD7 label=Room_70
  $7ADF,$02 Terminator.

w $7AE1 Room: #N$71
@ $7AE1 label=Room_71
  $7AE5,$02 Terminator.

w $7AE7 Room: #N$72
@ $7AE7 label=Room_72
  $7AEB,$02 Terminator.

w $7AED Room: #N$73
@ $7AED label=Room_73
  $7AF5,$02 Terminator.

w $7AF7 Room: #N$74
@ $7AF7 label=Room_74
  $7AFB,$02 Terminator.

w $7AFD Room: #N$75
@ $7AFD label=Room_75
  $7B03,$02 Terminator.

w $7B05 Room: #N$76
@ $7B05 label=Room_76
  $7B0F,$02 Terminator.

w $7B11 Room: #N$77
@ $7B11 label=Room_77
  $7B15,$02 Terminator.

w $7B17 Room: #N$78
@ $7B17 label=Room_78
  $7B1D,$02 Terminator.

w $7B1F Room: #N$79
@ $7B1F label=Room_79
  $7B23,$02 Terminator.

w $7B25 Room: #N$7A
@ $7B25 label=Room_7A
  $7B31,$02 Terminator.

w $7B33 Room: #N$7B
@ $7B33 label=Room_7B
  $7B37,$02 Terminator.

w $7B39 Room: #N$7C
@ $7B39 label=Room_7C
  $7B41,$02 Terminator.

w $7B43 Room: #N$7D
@ $7B43 label=Room_7D
  $7B4B,$02 Terminator.

w $7B4D Room: #N$7E
@ $7B4D label=Room_7E
  $7B55,$02 Terminator.

w $7B57 Room: #N$7F
@ $7B57 label=Room_7F
  $7B5F,$02 Terminator.

w $7B61 Room: #N$80
@ $7B61 label=Room_80
  $7B65,$02 Terminator.

w $7B67 Room: #N$81
@ $7B67 label=Room_81
  $7B6D,$02 Terminator.

w $7B6F Room: #N$82
@ $7B6F label=Room_82
  $7B79,$02 Terminator.

w $7B7B Room: #N$83
@ $7B7B label=Room_83
  $7B7F,$02 Terminator.

w $7B81 Room: #N$84
@ $7B81 label=Room_84
  $7B89,$02 Terminator.

w $7B8B Room: #N$85
@ $7B8B label=Room_85
  $7B8F,$02 Terminator.

w $7B91 Room: #N$86
@ $7B91 label=Room_86
  $7B95,$02 Terminator.

w $7B97 Room: #N$87
@ $7B97 label=Room_87
  $7BA1,$02 Terminator.

w $7BA3 Room: #N$88
@ $7BA3 label=Room_88
  $7BAD,$02 Terminator.

w $7BAF Room: #N$89
@ $7BAF label=Room_89
  $7BB9,$02 Terminator.

w $7BBB Room: #N$8A
@ $7BBB label=Room_8A
  $7BC7,$02 Terminator.

w $7BC9 Room: #N$8B
@ $7BC9 label=Room_8B
  $7BD1,$02 Terminator.

w $7BD3 Room: #N$8C
@ $7BD3 label=Room_8C
  $7BDB,$02 Terminator.

w $7BDD Room: #N$8D
@ $7BDD label=Room_8D
  $7BE9,$02 Terminator.

w $7BEB Room: #N$8E
@ $7BEB label=Room_8E
  $7BED,$02 Terminator.

w $7BEF Room: #N$8F
@ $7BEF label=Room_8F
  $7BF5,$02 Terminator.

w $7BF7 Room: #N$90
@ $7BF7 label=Room_90
  $7BFB,$02 Terminator.

w $7BFD Room: #N$91
@ $7BFD label=Room_91
  $7C03,$02 Terminator.

w $7C05 Room: #N$92
@ $7C05 label=Room_92
  $7C09,$02 Terminator.

w $7C0B Room: #N$93
@ $7C0B label=Room_93
  $7C0F,$02 Terminator.

w $7C11 Room: #N$94
@ $7C11 label=Room_94
  $7C11,$02
  $7C13,$02
  $7C15,$02 Terminator.

w $7C17 Room: None
@ $7C17 label=Room_None
  $7C17,$02 Terminator.

c $7C19 Game Entry Point
E $7C19 View the equivalent code in;
. #LIST
. { #COOKIE$6298 }
. { #LUNARJETMAN$800A }
. { #PSSST$61CD }
. { #TRANZAM$5F07 }
. LIST#
@ $7C19 label=GameInitialisation
  $7C19,$0A Write #N$00 to #N$10 bytes, from #R$5E00 to #N$5E10.
@ $7C1E label=GameInitialisation_Loop
  $7C23,$06 Write #R$BE4C to #R$5E01.
@ $7C29 label=Game_Restart
  $7C29,$03 Call #R$80AA.
  $7C2C,$03 Call #R$A311.
@ $7C2F label=GameSelect_Loop
  $7C2F,$03 Call #R$7CAF.
  $7C32,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $7C38,$01 Flip the bits.
  $7C39,$01 #REGe=#REGa.
  $7C3A,$03 #REGa=#R$5E00.
N $7C3D Handle Keyboard selection.
  $7C3D,$02 Has key "1" been pressed? ("KEYBOARD").
  $7C3F,$02 If not jump to #R$7C43.
  $7C41,$02,b$01 Keep only bits 0, 3-7.
N $7C43 Handle Kempston Joystick selection.
@ $7C43 label=GameSelect_CheckKempston
  $7C43,$02 Has key "2" been pressed? ("KEMPSTON JOYSTICK").
  $7C45,$02 If not jump to #R$7C4B.
  $7C47,$02,b$01 Keep only bits 0, 3-7.
  $7C49,$02,b$01 Set control method = #N$02.
N $7C4B Handle Cursor Joystick selection.
@ $7C4B label=GameSelect_CheckCursor
  $7C4B,$02 Has key "3" been pressed? ("CURSOR JOYSTICK").
  $7C4D,$02 If not jump to #R$7C53.
  $7C4F,$02,b$01 Keep only bits 0, 3-7.
  $7C51,$02,b$01 Set control method = #N$04.
N $7C53 Handle "Knight" selection.
@ $7C53 label=GameSelect_CheckKnight
  $7C53,$02 Has key "4" been pressed? ("KNIGHT").
  $7C55,$02 If not jump to #R$7C59.
  $7C57,$02,b$01 Keep only bits 0-2, 5-7.
N $7C59 Handle "Wizard" selection.
@ $7C59 label=GameSelect_CheckWizard
  $7C59,$02 Has key "5" been pressed? ("WIZARD").
  $7C5B,$02 If not jump to #R$7C61.
  $7C5D,$02,b$01 Keep only bits 0-2, 5-7.
  $7C5F,$02,b$01 Set player = #N$08.

  $7C62,$06 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$EF | 0 | 9 | 8 | 7 | 6 }
. TABLE#
  $7C68,$01 Flip the bits.
N $7C6B Handle choosing "Serf".
@ $7C6B label=GameSelect_CheckSerf
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

  $7C7C,$03 #REGhl=#R$7CEA.
  $7C7F,$02 #REGb=#N$03 (counter).
  $7C81,$01 #REGa=#REGc.
  $7C82,$03 Call #R$7C90.
  $7C85,$02 #REGb=#N$03 (counter).
  $7C87,$03 #REGa=#REGc / #N$04.
  $7C8A,$03 Call #R$7C90.
  $7C8D,$03 Jump to #R$7C2F.

c $7C90
  $7C90,$01 Divide by 2.
  $7C91,$02,b$01 Keep only bits 0-2.
  $7C93,$02 If zero then jump to #R$7C9C.
  $7C95,$03 Call #R$7CA4.
  $7C9B,$01 Return.
  $7C9C,$03 Call #R$7CAB.
  $7C9F,$02 Jump to #R$7C98.
  $7CA7,$01 Return.
  $7CAE,$01 Return.

c $7CAF Game Selection Menu
E $7CAF View the equivalent code in;
. #LIST
. { #COOKIE$6332 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$80D1 }
. { #PSSST$6250 }
. { #TRANZAM$0000 }
. LIST#
@ $7CAF label=GameMenu
  $7CAF,$03 #REGhl=#R$BE4C.
  $7CB2,$03 Write #R$BE4C to #R$5E01.
  $7CB5,$03 #REGde=#R$7CEA.
  $7CB8,$01 Switch to the shadow registers.
  $7CB9,$03 #REGhl=#R$7CF1.
  $7CBC,$03 #REGde=#R$7CF8.
N $7CBF There are seven lines of text.
  $7CBF,$02 #REGb'=#N$07 (counter).
@ $7CC1 label=GameMenu_Loop
  $7CC1,$01 Switch back to the normal registers.
  $7CC2,$04 Copy a byte from #REGde to #R$5E22.
  $7CC6,$01 Increment #REGde by one.
  $7CC7,$01 Switch to the shadow registers.
  $7CC8,$01 Stash #REGbc' on the stack.
  $7CC9,$01 #REGa=#REGhl' (grab the position data).
  $7CCA,$01 Increment #REGhl' (position data pointer) by one.
  $7CCB,$01 Stash #REGhl' (position data pointer) on the stack.
  $7CCC,$03 #REGh'=#REGa #REGl'=#N$58.
  $7CCF,$03 Call #R$7D8A.
  $7CD2,$01 Switch back to the normal registers.
  $7CD3,$02 Restore #REGhl and #REGbc from the stack.
  $7CD5,$01 Increase #REGde by one.
  $7CD6,$02 Decrease counter by one and loop back to #R$7CC1 until counter is zero.
  $7CD8,$03 #REGhl=#N($B800, $04, $04).
  $7CDB,$03 #REGde=#R$7D51.
  $7CDE,$03 Call #R$A1F3.
  $7CE1,$03 #REGhl=#N($0020, $04, $04).
  $7CE4,$03 #REGde=#R$7D72.
  $7CE7,$03 Jump to #R$A1F3.

b $7CEA Game Select Attribute Table
E $7CEA View the equivalent code in;
. #LIST
. { #COOKIE$635E }
. { #JETPAC$628D }
. { #LUNARJETMAN$810E }
. { #PSSST$627C }
. { #TRANZAM$5FA7 }
. LIST#
@ $7CEA label=GameSelection_Attributes
  $7CEA,$07,$01 #TABLE(default,centre)
. { =h Byte(n) | =h Menu Item }
. { #N$01 | 1 Keyboard }
. { #N$02 | 2 Kempston Joystick }
. { #N$03 | 3 Cursor Joystick }
. { #N$04 | 4 Knight }
. { #N$05 | 5 Wizard }
. { #N$06 | 6 Serf }
. { #N$07 | 0 Start Game }
. TABLE#

b $7CF1 Game Select Y Position Table
E $7CF1 View the equivalent code in;
. #LIST
. { #COOKIE$6365 }
. { #JETPAC$6293 }
. { #LUNARJETMAN$8115 }
. { #PSSST$6282 }
. { #TRANZAM$5FAC }
. LIST#
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
E $7CF8 View the equivalent code in;
. #LIST
. { #COOKIE$636C }
. { #JETPAC$6299 }
. { #LUNARJETMAN$811C }
. { #PSSST$6288 }
. { #TRANZAM$5FB1 }
. LIST#
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

c $7D8A Write Menu Line
E $7D8A View the equivalent code in;
. #LIST
. { #COOKIE$63E0 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$62E7 }
. { #TRANZAM$0000 }
. LIST#
@ $7D8A label=MenuWriteText
  $7D8A,$01 Stash #REGhl containing the co-ordinate on the stack.
  $7D8B,$03 Call #R$9BA2.
  $7D8E,$03 #REGa=the menu attribute byte from #R$5E22.
  $7D91,$01 Switch to the shadow #REGaf register.
  $7D92,$01 Switch to the shadow registers.
  $7D93,$01 Restore #REGhl from the stack.
  $7D94,$03 Call #R$9BD2.
  $7D97,$03 Jump to #R$A1FF.

c $7D9A Start Game
E $7D9A View the equivalent code in;
. #LIST
. { #COOKIE$6428 }
. { #JETPAC$6333 }
. { #LUNARJETMAN$81BB }
. { #PSSST$631E }
. { #TRANZAM$5FEF }
. LIST#
@ $7D9A label=StartGame
  $7D9A,$03 Call #R$80CB.
  $7D9D,$05 Write starting lives to #R$5E21.
  $7DA2,$06 Write #R$EB58 to #R$5E55.
  $7DA8,$03 Call #R$80AA.
  $7DAB,$03 Call #R$A219.
  $7DAE,$03 Call #R$A2CE.
  $7DB1,$03 Call #R$94B6.
  $7DB4,$03 Call #R$98D2.
  $7DB7,$03 Call #R$8D61.
  $7DBA,$03 Call #R$94F5.
  $7DBD,$03 Call #R$9443.
  $7DC0,$03 Jump to #R$9147.

c $7DC3 Main Loop
@ $7DC3 label=MainLoop
  $7DC3,$03 Set stack pointer to #N$5E00.
  $7DC6,$01 Enable interrupts.
  $7DC7,$04 Write #N$00 to #R$5E25.
  $7DCB,$04 #REGix=#R$EAA8.
  $7DCF,$07 Checking bit 0 of #R$5E14; jump to #R$7DDC if the room content is already drawn.
  $7DD6,$04 #REGix=#R$EEE0.
  $7DDA,$02 Jump to #R$7E23.

  $7DDC,$04 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $7DE0,$03 #REGa=#R$5E03.
  $7DE7,$03 #REGa=#R$EA91.
  $7DED,$03 #REGhl=#R$7DF3.
  $7DF3,$03 #REGde=#N($0008, $04, $04).
  $7DFB,$03 #REGde=#R$EE60.
  $7E03,$04 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $7E07,$03 #REGa=#R$5E03.
  $7E0E,$03 #REGhl=#R$7E13.
  $7E13,$03 #REGde=#N($0010, $04, $04).
  $7E1B,$03 #REGde=#R$EEE0.

c $7E23 Draw Room
@ $7E23 label=DrawRoom
  $7E23,$03 #REGa=#R$EA91.
  $7E26,$04 Create an offset in #REGhl (#REGa * #N$02).
  $7E2A,$04 #REGhl=#R$757D + offset.
  $7E2E,$04 #REGhl=the current room data.
  $7E32,$03 Stash the room data pointer at #R$5E1B.
@ $7E35 label=Decor_Loop
  $7E35,$03 #REGhl=#R$5E1B.
  $7E44,$03 #REGhl=#R$5E12.
  $7E4B,$03 #REGhl=#R$5E14.
  $7E55,$03 #REGhl=#R$5E14.
  $7E62,$03 #REGa=#R$5E12.
  $7E73,$03 #REGa=#R$EA91.
  $7E7B,$03 Jump to #R$7DC3.

c $7E7E Process Action
@ $7E7E label=ProcessAction

w $7EE6 Handler Table
@ $7EE6 label=HandlerTable

w $802A Handler Table 2
@ $802A label=HandlerTable2
  $802A,$02 "#D(#PEEK(#PC) + #PEEK(#PC + $01) * $100)".
L $802A,$02,$28

c $807A Create Delay
@ $807A label=CreateDelay
  $807D,$03 #REGde=#R$EE60.
  $808A,$03 #REGhl=#N($00C0, $04, $04).
@ $808D label=CreateDelay_Loop
  $8092,$01 Return.

c $8093 Clear Play Area
@ $8093 label=ClearPlayArea

c $80AA Clear Screen
@ $80AA label=ClearScreen
E $80AA View the equivalent code in #COOKIE$5FB7.
E $80AA View the equivalent code in #PSSST$5F53.
  $80AA,$03 Call #R$80C2.
  $80AD,$03 Call #R$80B4.
  $80B0,$03 Set the border to black.
  $80B3,$01 Return.

c $80B4 Reset Screen Buffer
E $80B4 View the equivalent code in;
. #LIST
. { #COOKIE$74D4 }
. { #JETPAC$71B8 }
. { #LUNARJETMAN$84AD }
. { #PSSST$7439 }
. { #TRANZAM$7211 }
. LIST#
@ $80B4 label=ResetScreen
E $80B4 Continue on to #R$80BB to blank the screen buffer.
  $80B4,$03 #REGhl=#R$4000(screen buffer).
  $80B7,$02 #REGb=#N$58 (i.e. finish once we reach the start of #R$5800(attribute buffer)).
  $80B9,$02 #REGc=#N$00 (value to write).

c $80BB Reset Routine
E $80BB View the equivalent code in;
. #LIST
. { #COOKIE$74DB }
. { #JETPAC$71B8 }
. { #LUNARJETMAN$84B4 }
. { #PSSST$7440 }
. { #TRANZAM$7218 }
. LIST#
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
E $80C2 View the equivalent code in;
. #LIST
. { #COOKIE$74E2 }
. { #JETPAC$71C6 }
. { #LUNARJETMAN$84BB }
. { #PSSST$7447 }
. { #TRANZAM$7200 }
. LIST#
@ $80C2 label=ResetAttributes
  $80C2,$03 #REGhl=#R$5800(attribute buffer).
  $80C5,$02 #REGb=#N$5B (i.e. finish once we reach the end of the #R$5800(attribute buffer)).
  $80C7,$02 #REGc=#N$00 (value to write).
  $80C9,$02 Jump to #R$80BB.

c $80CB Reset Player Data
@ $80CB label=ResetPlayerData
  $80CB,$03 #REGhl=#R$5E10.
  $80CE,$02 #REGb=#N$60.
  $80D0,$02 Jump to #R$80B9.

c $80D2 Handler: Wizard
@ $80D2 label=HandlerWizard

c $81DB Handler: Axe
@ $81DB label=HandlerAxe
  $81DB,$03 Call #R$9FFB to prepare for the mask.
  $81DE,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $81E1,$01
  $81E2,$01
  $81E3,$02,b$01 Keep only bits 0-2 (there are 8 animation frames).
  $81E5,$02 Add #N$40 to point to the correct frame/ sprite ID (the axe base sprite ID is: #R($A4BE + $40 * $02)(#N$40)).
  $81EA,$04 Store the attribute byte #N$42 (BRIGHT red).
  $81EE,$02 Jump to #R$8209.

c $81F0 Handler: Fireball
@ $81F0 label=HandlerFireball
E $81F0 Continue on to #R$8209.
  $81F0,$03 Call #R$9FFB to prepare for the mask.
  $81F3,$04 Grab the current frame and increment it by one.
  $81F7,$02,b$01 Keep only bits 0-2 (there are 8 animation frames).
  $81F9,$02 Add #N$34 to point to the correct frame/ sprite ID (the fireball base sprite ID is: #R($A4BE + $34 * $02)(#N$34)).
  $81FB,$03 Write the new frame/ sprite ID back to the entity.
  $81FE,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $8202,$02,b$01 Keep only bit 1.

c $8209 Handler: Weapon
@ $8209 label=HandlerWeapon

c $82C3 Sword Direction
@ $82C3 label=SwordDirection
N $82C3 Set the sword direction to match the players direction.
  $82C3,$02 #REGc=#N$00 (down).
  $82C5,$04 If the byte at #REGhl is zero then jump to #R$82E4.
  $82C9,$03
  $82CC,$02 #REGc=#N$04 (up).
  $82D8,$02,b$01 Keep only bits 0-2 (there are 8 animation frames).
  $82DA,$02 Add #N$38 to point to the correct frame/ sprite ID (the sword base sprite ID is: #R($A4BE + $38 * $02)(#N$38)).
  $82DC,$04 Write the new frame/ sprite ID back to #R$EA98.
  $82E0,$01 Return.
  $82E2,$02 Jump to #R$82D7.
  $82E9,$02 #REGc=#N$06 (left).
  $82EB,$02 Jump to #R$82D7.
  $82ED,$02 #REGc=#N$02 (right).
  $82EF,$02 Jump to #R$82D7.

c $82F1 Handler: Sword
@ $82F1 label=HandlerSword
  $82F1,$03 Call #R$9FFB to prepare for the mask.
  $82F4,$04 Store the attribute byte #N$46 (BRIGHT yellow).
  $82F8,$03 #REGhl=#N$EA9F.
  $82FB,$03 Call #R$82C3.
  $82FE,$03 Jump to #R$8209.

c $8301 Handler: Batlet
@ $8301 label=HandlerBatlet

b $8B6A Creature Defaults
@ $8B6A label=CreatureDefaults
  $8B6A,$10,$08

b $8B7A Creatures
@ $8B7A label=Creatures
  $8B7A,$01 #SPRITENAME(#PEEK(#PC))
L $8B7A,$01,$10

c $8B8A Draw Chicken
@ $8B8A label=DrawChicken
  $8B8A,$03 #REGa=#R$5E28.
  $8B94,$03 #REGa=#R$5E29.
  $8BAA,$04 #REGix=#R$8C2D.
  $8C11,$01 Return.
  $8C12,$04 Write #REGc to #R$C543.
  $8C16,$05 Write #N$13 to #REGix+#N$00.
  $8C1B,$06 Write #N$77C8 to #R$8C2D(#N$8C30).
  $8C21,$03 Call #R$9213.
  $8C24,$02 #REGb=#N$06 (counter).
  $8C26,$02 Write #N$00 to #REGhl.
  $8C28,$01 Increment #REGl by one.
  $8C29,$02 Decrease counter by one and loop back to #R$8C26 until counter is zero.
  $8C2B,$02 Jump to #R$8C00.

N $8C2D Chicken Entity
@ $8C2D label=Entity_Chicken
B $8C2D,$08

c $8C35 Game Over
@ $8C35 label=GameOver
  $8C35,$03 Call #R$8093.
  $8C38,$06 Write #R$BE4C to #R$5E01.
N $8C3E Handle printing "Game Over" messaging.
  $8C3E,$03 #REGhl=#N$3040 (screen buffer location).
  $8C41,$03 #REGde=#R$8C59.
  $8C44,$03 Call #R$A1F3.
N $8C47 Handle printing the game statistics.
  $8C47,$03 Call #R$9641.
N $8C4A Provide a pause for us to reflect that the game has now ended.
@ $8C4A label=GameOverDelay
  $8C4A,$02 #REGb=#N$14.
  $8C4C,$03 #REGhl=#N($0000, $04, $04).
N $8C4F From #REGhl being set above (and for each loop), decrementing #N($0000, $04, $04) by one gives #N$FFFF.
@ $8C4F label=GameOverDelay_Loop
  $8C4F,$01 Decrease #REGhl by one.
  $8C50,$04 Loop back to #R$8C4F until #REGhl is zero.
  $8C54,$02 Decrease counter by one and loop back to #R$8C4F until counter is zero.
  $8C56,$03 Jump to #R$7C29.
N $8C59 "Game Over" messaging.
@ $8C59 label=StringGameOver
T $8C59,$0A,h$01,$08:$01 Attribute: #N(#PEEK(#PC)) + "GAME OVER".

c $8C63 Handler: Food Item
@ $8C63 label=HandlerFoodItem

c $8D61 Reset Game State
@ $8D61 label=ResetGameState
  $8D61,$0B Copy #N$1570 bytes from #R$600D to #R$EA90.
  $8D6C,$01 Return.

c $8D6D Auto Walk Step
@ $8D6D label=AutoWalkStep
  $8D70,$02,b$01 Keep only bits 0-3.
  $8D72,$01 Return if the result is zero.
  $8D76,$01 Return.

c $8D77 Control Player
@ $8D77 label=ControlPlayer
  $8D77,$03 #REGa=#R$EA91.
  $8D7D,$03 Stash #REGbc, #REGde and #REGhl on the stack.
  $8D80,$03 Call #R$8D6D.
  $8D86,$02,b$01 Set bits 4-5.
  $8D8B,$03 Call #R$9FFB.
  $8D8E,$03 Call #R$93BE.
  $8D92,$01 Restore #REGhl from the stack.
  $8D93,$03 #REGde=#N($0000, $04, $04).
  $8DB0,$01 Restore #REGhl from the stack.
  $8DB1,$03 Call #R$8F96.
  $8DB4,$01 Restore #REGhl from the stack.
  $8DB5,$03 Call #R$8EEF.
  $8DB8,$03 Call #R$8FCA.
  $8DBB,$03 Call #R$957D.
  $8DBE,$03 Call #R$900A.
  $8DC1,$03 Jump to #R$8F66.

c $8DC4 Handler: Serf
@ $8DC4 label=HandlerSerf

c $8E26 Handler: Knight
@ $8E26 label=HandlerKnight

c $8F66 Apply Movement
@ $8F66 label=ApplyMovement

c $9147 Enter Room
@ $9147 label=EnterRoom
  $9147,$03 #REGa=#R$EA91.
  $914A,$03 Call #R$96AF.
  $914D,$03 Call #R$8093.
  $9150,$03 Call #R$9BEA.
  $9153,$03 Call #R$A240.
  $9156,$03 Call #R$A13B.
  $9159,$03 Call #R$A403.
  $915C,$03 Jump to #R$7DC3.

c $915F Handler: Door Open
@ $915F label=HandlerDoorOpen

c $917D Handler: Door Closed
@ $917D label=HandlerDoorClosed

c $91BC Handler: Trap Closed
@ $91BC label=HandlerTrapClosed

c $91C5 Handler: Trap Open
@ $91C5 label=HandlerTrapOpen

c $91ED Handler: Big Door Exit
@ $91ED label=HandlerDoorBigExit

c $91F2 Handler: Door Exit
@ $91F2 label=HandlerDoorExit

c $91FE Handler: Room Item
@ $91FE label=HandlerRoomItem

c $9244 Handler: Door Locked
@ $9244 label=HandlerDoorLocked

c $9252 Handler: Cave Door Locked
@ $9252 label=HandlerCaveDoorLocked

c $93E3 Handler: Blank
@ $93E3 label=HandlerBlank

c $9421 Handler: Barrel
@ $9421 label=HandlerBarrel

c $9428 Handler: Bookcase
@ $9428 label=HandlerBookcase

c $942F Handler: Clock
@ $942F label=HandlerClock

c $9443 Prepare Player
@ $9443 label=PreparePlayer
N $9443 Work out the sprite ID to use.
. #TABLE(default,centre,centre,centre,centre,centre)
. { =h Byte | =h Character | =h * #N$02 | =h Only Bits 4-5 | =h + #N$08 }
. #LET(char=$00) #LET(id=#EVAL((({char} * $02) & $30) + $08)) { #N({char}) | Knight (+ Keyboard) | #N(#EVAL({char} * $02)) | #N(#EVAL(({char} * $02) & $30)) | Sprite ID: #R($A4BE + {id} * $02)(#N({id})) }
. #LET(char=$08) #LET(id=#EVAL((({char} * $02) & $30) + $08)) { #N({char}) | Wizard (+ Kempston Joystick) | #N(#EVAL({char} * $02)) | #N(#EVAL(({char} * $02) & $30)) | Sprite ID: #R($A4BE + {id} * $02)(#N({id})) }
. #LET(char=$14) #LET(id=#EVAL((({char} * $02) & $30) + $08)) { #N({char}) | Serf (+ Cursor Joystick) | #N(#EVAL({char} * $02)) | #N(#EVAL(({char} * $02) & $30)) | Sprite ID: #R($A4BE + {id} * $02)(#N({id})) }
. TABLE#
  $9443,$04 #REGa=#R$5E00 * #N$02.
M $9447,$04 Keep only bits 4-5 (the base character address) + #N$08 frames (for the character direction).
  $9447,$02,b$01
  $9449,$02
  $944B,$03 Write #REGa to #R$9481(#N$9488).
N $944E Update the current room.
  $944E,$06 Write #R$EA91 to #R$9481(#N$9482).
  $9454,$0B Copy #N$08 bytes of data from #R$9481 to #R$EA90.
  $9471,$03 Call #R$9F4A.
N $9476 Set starting energy.
@ $9476 label=PreparePlayer_Energy
  $9476,$05 Write #N$F0 to #R$5E28.
  $947B,$03 Call #R$8B8A.
  $947E,$03 Jump to #R$A2CE.
B $9481,$08

c $9489

c $94B6 Place Key Pieces
@ $94B6 label=PlaceKeyPieces

c $94F5 Randomise Doors
@ $94F5 label=RandomiseDoors

c $957D Check Doorway
@ $957D label=CheckDoorway
  $957D,$01 Stash #REGde on the stack.
  $9580,$03 #REGhl=#R$5E1D.
  $95A7,$01 Restore #REGde from the stack.
  $95A8,$01 Return.

c $95A9
  $95A9,$03 #REGhl=#R$EAE8.
  $95AC,$03 #REGde=#N($0008, $04, $04).
  $95AF,$02 #REGb=#N$04.
  $95B8,$01 Return.
  $95B9,$02 #REGa=#N$45.
  $95C3,$03 #REGhl=#R$EA91.
  $95D6,$01 Return.

c $95DA Clock Tick
@ $95DA label=ClockTick
  $95DA,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)

@ $9607 label=PrintClock

c $961B  Handler: A.C.G. Door Exit
@ $961B label=HandlerDoorACGExit

c $9641 Show Game Statistics
@ $9641 label=GameStats
  $9641,$03 Call #R$96C9.
N $9644 Handle printing the time.
  $9644,$03 #REGhl=#N$4040 (screen buffer location).
  $9647,$03 #REGde=#R$967F.
  $964A,$03 Call #R$A1F3.
N $964D Handle printing the score.
  $964D,$03 #REGhl=#N$5040 (screen buffer location).
  $9650,$03 #REGde=#R$968F.
  $9653,$03 Call #R$A1F3.
N $9656 Handle printing the money total.
  $9656,$03 #REGhl=#N$6040 (screen buffer location).
  $9659,$03 #REGde=#R$969F.
  $965C,$03 Call #R$A1F3.
N $965F Handle printing the clock.
  $965F,$06 Write #R$BFCC(main font "0") to #R$5E01.
  $9665,$03 #REGhl=#N$4080 (screen buffer location).
  $9668,$03 Call #R$9607.
N $966B Handle printing the "visited percentage".
  $966B,$03 #REGhl=#N$5080 (screen buffer location).
  $966E,$03 Call #R$A1B7.
  $9671,$03 #REGhl=#N$6080 (screen buffer location).
  $9674,$03 Call #R$9BA2.
  $9677,$03 #REGde=#R$5E54.
  $967A,$02 #REGb=#N$01.
  $967C,$03 Jump to #R$A1BF.
@ $967F label=StringTime
T $967F,$10,h$01,$0E:$01 Attribute: #N(#PEEK(#PC)) + "TIME".
@ $968F label=StringScore
T $968F,$10,h$01,$0E:$01 Attribute: #N(#PEEK(#PC)) + "SCORE".
@ $969F label=StringMoney
T $969F,$10,h$01,$0E:$01 Attribute: #N(#PEEK(#PC)) + "".

c $96AF Visit Room
@ $96AF label=VisitRoom
E $96AF View the equivalent code in;
. #LIST
. { #SABREWULF$9D23 }
. LIST#
R $96AF A The room ID
N $96AF Create an offset in #REGbc.
  $96AF,$01 #REGc=#REGa.
  $96B0,$06 Divide by #N$08.
  $96B6,$02 #REGb=#N$00.
  $96B8,$04 #REGhl=#R$5E40 + #REGbc.
  $96BC,$03 Multiply by #N$08.
  $96BF,$02,b$01 Keep only bits 3-5.
  $96C1,$02,b$01 Set bits 1-2, 6-7.
  $96C3,$03 Write this value to #R$96C6(#N$96C7) which updates the bit to set.
  $96C6,$02 With above, set the bit to mark the room as having been visited.
  $96C8,$01 Return.

c $96C9 Calculate Rooms Visited
@ $96C9 label=CalcRoomsVisited
E $96C9 View the equivalent code in;
. #LIST
. { #SABREWULF$9CC6 }
. LIST#
  $96C9,$03 #REGhl=#R$5E40.
  $96CC,$03 #REGbc=#N$0813.
  $96CF,$02 #REGd=#N$03.
  $96D2,$01 Stash #REGbc on the stack.
  $96E3,$01 Restore #REGbc from the stack.
  $96EB,$01 Return.

c $96EC Game Complete
@ $96EC label=GameComplete
  $96EC,$03 #REGhl=#R$EA90.
  $96F2,$06 Write #R$BE4C to #R$5E01.
N $96F8 Handle printing "CONGRATULATIONS".
  $96F8,$03 #REGhl=#N$2040 (screen buffer location).
  $96FB,$03 #REGde=#R$9710.
  $96FE,$03 Call #R$A1F3.
N $9701 Handle printing "YOU HAVE ESCAPED".
  $9701,$03 #REGhl=#N$3040 (screen buffer location).
  $9704,$03 #REGde=#R$9720.
  $9707,$03 Call #R$A1F3.
N $970A Show the game statistics.
  $970A,$03 Call #R$9641.
N $970D Disappointingly cut into the "normal" game over routine.
  $970D,$03 Jump to #R$8C4A.
N $9710 Congratulations messaging.
T $9710,$10,h$01,$0E:$01 Attribute: #N(#PEEK(#PC)) + "CONGRATULATIONS".
T $9720,$11,h$01,$0F:$01 Attribute: #N(#PEEK(#PC)) + "YOU HAVE ESCAPED".

c $98D2 Set Key Positions
@ $98D2 label=SetKeyPositions

c $9BA2 Calculate Screen Address
E $9BA2 View the equivalent code in;
. #LIST
. { #COOKIE$76E3 }
. { #JETPAC$7308 }
. { #LUNARJETMAN$851E }
. { #PSSST$759A }
. { #TRANZAM$6F10 }
. LIST#
@ $9BA2 label=ScreenAddress
  $9BA2,$01 #REGa=#REGl.
  $9BA3,$03 #REGa=#REGa / #N$08.
  $9BA6,$02,b$01 Keep only bits 0-4.
  $9BA8,$01 #REGl=#REGa.
  $9BA9,$01 #REGa=#REGh.
  $9BAA,$02 #REGa=#REGa * #N$04.
  $9BAC,$02,b$01 Keep only bits 5-7.
  $9BAE,$01
  $9BAF,$01 #REGl=#REGa.
  $9BB0,$01 #REGa=#REGh.
  $9BB1,$02,b$01 Keep only bits 0-2.
  $9BB3,$01 Switch to the shadow #REGaf register.
  $9BB4,$01 #REGa=#REGh.
  $9BB5,$03 #REGa=#REGa / #N$08.
  $9BB8,$02,b$01 Keep only bits 3-4.
  $9BBA,$02,b$01 Set bit 6.
  $9BBC,$01 #REGh=#REGa.
  $9BBD,$01 Switch to the shadow #REGaf register.
  $9BBE,$01
  $9BBF,$01 #REGh=#REGa.
  $9BC0,$01 Return.

c $9BC1

c $9BD2 Calculate Attribute Address
E $9BD2 View the equivalent code in;
. #LIST
. { #COOKIE$7534 }
. { #JETPAC$720E }
. { #LUNARJETMAN$8506 }
. { #PSSST$748F }
. { #TRANZAM$7097 }
. LIST#
N $9BD2 Converts a given pixel address to the associated attribute buffer address.
R $9BD2 HL Pixel address co-ordinates
R $9BD2 O:HL Attribute buffer address
@ $9BD2 label=AttributeAddress
  $9BD2,$01 Stash #REGbc on the stack.
  $9BD3,$01 Horizontal co-ordinate.
  $9BD4,$03 Divide by #N08.
  $9BD7,$02,b$01 Keep only bits 0-4 (#N$00-#N$1F / minimum-maximum horizontal screen values).
  $9BD9,$01 Store this back in #REGl.
  $9BDA,$01 Vertical co-ordinate.
  $9BDB,$02 Multiply by #N$04.
  $9BDD,$01 Store this in #REGc temporarily.
  $9BDE,$02,b$01 Keep only bits 5-7.
  $9BE0,$01 Set the bits from #REGl.
  $9BE1,$01 #REGl=#REGa.
  $9BE2,$01 Fetch the stored value from #REGc.
  $9BE3,$02,b$01 Keep only bits 0-1.
  $9BE5,$02,b$01 Set MSB of the attribute buffer #N$58. This ensures our value is >= #R$5800.
  $9BE7,$01 Store this back in #REGh.
  $9BE8,$01 Restore #REGbc from the stack.
  $9BE9,$01 Return.

c $9BEA Draw Room Frame
@ $9BEA label=DrawRoomFrame

c $9D19 Get Blend Instruction
@ $9D19 label=GetBlendInstruction
  $9D19,$01 #REGa=#REGb.
  $9D1A,$02,b$01 Keep only bits 0-1.
  $9D1C,$01 Return if #N$00 (no blending).
  $9D1D,$02 Compare #REGa with #N$01...
  $9D1F,$02 #REGa=#N$AE.
  $9D21,$01 Return if the comparison was not zero (XOR blending).
  $9D22,$02 #REGa+=#N$08.
  $9D24,$01 Return (OR blending).

c $9D25 Draw Attr 0
c $9D47 Draw Attr 1
c $9D6F Draw Attr 2
c $9DA0 Draw Attr 3
c $9DCE Draw Attr 4
c $9DF8 Draw Attr 5
c $9E21 Draw Attr 6
c $9E55 Draw Attr 7

c $9E86 Get Sprite "A"
R $9E86 O:DE The sprite address
E $9E86 View the equivalent code in;
. #LIST
. { #SABREWULF$B925 }
. LIST#
E $9E86 Continue on to #R$9E89.
@ $9E86 label=GetSpriteA
  $9E86,$03 #REGa=#R$5E15.

c $9E89 Get Sprite Address
R $9E89 A The Sprite ID
R $9E89 O:DE The sprite address
E $9E89 View the equivalent code in;
. #LIST
. { #SABREWULF$B934 }
. LIST#
@ $9E89 label=GetSpriteAddress
  $9E89,$01 Decrease #REGa by one.
  $9E8A,$03 Create an offset in #REGhl.
  $9E8D,$01 #REGhl=#REGhl * 2.
  $9E8E,$04 #REGhl=#R$A4BE + offset.
  $9E92,$03 #REGde=the sprite address.
  $9E95,$01 Return.

c $9E96 Get Entity Sprite
E $9E96 View the equivalent code in;
. #LIST
. { #SABREWULF$B934 }
. LIST#
@ $9E96 label=GetEntitySprite
  $9E96,$03 #REGa=#REGix+#N$00.
  $9E99,$02 Jump to #R$9E89.

c $9E9B

c $9F4A Draw Entity
@ $9F4A label=DrawEntity
  $9F4A,$03 Call #R$9F9F.
  $9F4D,$01 Switch to the shadow registers.
  $9F4E,$04 Write #N$00 to #R$5E18.
  $9F52,$01 #REGc=#N$00.
  $9F53,$03 Jump to #R$9E9B.

c $9F56 Remove Entity
E $9F56 View the equivalent code in;
. #LIST
. { #SABREWULF$B8F5 }
. LIST#
@ $9F56 label=RemoveEntity

c $9F80 Prepare Draw 2/ 3 Byte Sprite
E $9F80 View the equivalent code in;
. #LIST
. { #SABREWULF$B939 }
. LIST#
@ $9F80 label=PrepDraw23
  $9F80,$03 Call #R$9E86.
  $9F83,$03 #REGhl=#R$5E16 (saved X position).
  $9F89,$02,b$01 Keep only bits 1-3.
  $9F9E,$01 Return.

c $9F9F Prepare Draw 2 Byte Sprite
E $9F9F View the equivalent code in;
. #LIST
. { #SABREWULF$B969 }
. LIST#
@ $9F9F label=PrepDraw2
  $9F9F,$03 Call #R$9E96.

c $9FCA Display Entity
E $9FCA View the equivalent code in;
. #LIST
. { #SABREWULF$B9A9 }
. LIST#
@ $9FCA label=DisplayEntity

c $9FFB Store Entity
@ $9FFB label=StoreEntity
  $A00D,$01 Return.

c $A00E Set Entity Attributes
R $A00E IX The entity to colour
@ $A00E label=SetEntityAttributes
  $A00E,$06 Write the entity X position to #R$5E16.
  $A014,$06 Write the entity X position to #R$5E17.
  $A01A,$06 #REGhl=Entity screen position.
  $A020,$03 #REGd=Entity attribute.
  $A023,$04 #REGe=Room attribute.
  $A027,$04 #REGb=Entity width in bytes.
  $A02B,$03 #REGa=Entity height in pixels.
  $A02E,$02 Divide by #N$04.
  $A030,$01 Increment #REGa by one.
  $A031,$01 Divide by #N$02.
  $A032,$02,b$01 Keep only bits 0-4.
  $A034,$01 Increment #REGa by one.
  $A035,$01 Store the result in #REGc.
  $A036,$01 Stash #REGbc on the stack.
  $A037,$02 #REGb=#N$00.
  $A039,$04 Compare #R$5E16 against #REGl to see if the X position is unchanged.
  $A03D,$02 If it hasn't changed then jump to #R$A043.
  $A03F,$02 If the entity has moved left then jump to #R$A042.
  $A041,$01 #REGb=#REGb + #N$01.
  $A042,$01 #REGb=#REGb + #N$01.
  $A043,$04 Compare #R$5E17 against #REGh to see if the Y position is unchanged.
  $A047,$01 #REGa=#REGb.
  $A048,$02 If it hasn't changed then jump to #R$A050.
  $A04A,$02 If the entity has moved up then jump to #R$A04E.
  $A04C,$02 #REGa=#REGa + #N$04.
  $A04E,$02 #REGa=#REGa + #N$04.
  $A050,$01 Stash the result in #REGb.
  $A051,$03 Call #R$9BD2.
  $A054,$01 Restore the result back into #REGa.
  $A057,$03 #REGhl=#R$A064.
  $A05A,$02 #REGa=#REGa * #N$02.
  $A05C,$03 Call #R$926C.
  $A05F,$04 #REGhl=attribute routine selected from #R$A064.
  $A063,$01 Indirect jump to the address held in #REGhl.

w $A064 Attribute Jump Table
@ $A064 label=AttributeJumpTable
  $A064,$08,$02
  $A06C,$08,$02
  $A074,$06,$02

c $A07A Attribute: Draw Unchanged Position
@ $A07A label=AttrDrawUnchanged

c $A08D Attribute: Draw Moving Right
@ $A08D label=AttrDrawMovingRight

c $A0A3 Attribute: Draw Moving Left
@ $A0A3 label=AttrDrawMovingLeft

c $A0B7 Attribute: Draw Moving Down
@ $A0B7 label=AttrDrawMovingDown

c $A0D2 Attribute: Draw Moving Down-Right
@ $A0D2 label=AttrDrawMovingDownRight

c $A0EC Attribute: Draw Moving Up
@ $A0EC label=AttrDrawMovingUp

c $A0FE Attribute: Draw Moving Up-Left
@ $A0FE label=AttrDrawMovingUpLeft

c $A110 Attribute: Draw Moving Down-Left
@ $A110 label=AttrDrawMovingDownLeft

c $A127 Attribute: Draw Moving Up-Right
@ $A127 label=AttrDrawMovingUpRight

c $A13B Draw Inventory
@ $A13B label=DrawInventory
@ $A14D label=DrawInventoryItem
@ $A17D label=EntityToDraw
B $A17D,$08

c $A185 Clear Sprite
@ $A185 label=ClearSprite

c $A19C Add Points To Score
E $A19C View the equivalent code in;
. #LIST
. { #COOKIE$7415 }
. { #JETPAC$70F9 }
. { #PSSST$737A }
. { #TRANZAM$6046 }
. LIST#
R $A19C BC Points to add to score
@ $A19C label=AddPointsToScore
  $A19C,$03 #REGhl=#R$5E2C.
  $A19F,$01 #REGa=score byte #3.
  $A1A0,$02 Add #REGc to score byte #3 with BCD conversion.
  $A1A2,$01 Update score byte #3.
  $A1A3,$01 Move onto the next score byte.
  $A1A4,$01 #REGa=score byte #2.
  $A1A5,$02 Add (with carry) #REGb to score byte #2 with BCD conversion.
  $A1A7,$01 Update score byte #2.
  $A1A8,$01 Move onto the next score byte.
  $A1A9,$01 #REGa=score byte #1.
  $A1AA,$03 Add #N$00 (i.e. just the carry flag) to score byte #1 with BCD conversion.
  $A1AD,$01 Update score byte #1.

c $A1AE Print Scores
E $A1AE View the equivalent code in;
. #LIST
. { #COOKIE$7438 }
. { #JETPAC$711C }
. { #LUNARJETMAN$89BF }
. { #PSSST$739D }
. LIST#
N $A1AE Sets up the player score.
@ $A1AE label=PrintScore
  $A1AE,$06 Write #R$BFCC to #R$5E01.
  $A1B4,$03 #REGhl=#N$50C8.
  $A1B7,$03 Call #R$9BA2.
  $A1BA,$03 #REGde=#N$5E2A.
  $A1BD,$02 #REGb=#N$03.
@ $A1BF label=PrintScore_Loop
  $A1BF,$01 #REGa=#REGde.
  $A1C0,$04 #REGa=#REGa / #N$10.
  $A1C4,$02,b$01 Keep only bits 0-3.
  $A1C6,$03 Call #R$A1D3.
  $A1C9,$01 #REGa=#REGde.
  $A1CA,$02,b$01 Keep only bits 0-3.
  $A1CC,$03 Call #R$A1D3.
  $A1CF,$01 Increment #REGde by one.
  $A1D0,$02 Decrease counter by one and loop back to #R$A1BF until counter is zero.
  $A1D2,$01 Return.

c $A1D3 Print Character
E $A1D3 View the equivalent code in;
. #LIST
. { #COOKIE$7468 }
. { #JETPAC$714C }
. { #LUNARJETMAN$89EF }
. { #PSSST$73CD }
. { #TRANZAM$6C96 }
. LIST#
@ $A1D3 label=PrintCharacter

c $A1F3 Print Colour String
E $A1F3 View the equivalent code in;
. #LIST
. { #COOKIE$7488 }
. { #JETPAC$716C }
. { #LUNARJETMAN$0000 }
. { #PSSST$73ED }
. { #TRANZAM$0000 }
. LIST#
@ $A1F3 label=PrintStringColour
R $A1F3 DE Pointer to string data
  $A1F3,$01 Stash #REGhl on the stack.
  $A1F4,$03 Call #R$9BA2.
  $A1F7,$01 Fetch the attribute byte.
  $A1F8,$01 Switch to the shadow #REGaf register.
  $A1F9,$01 Increment #REGde by one to point to the text of the string.
  $A1FA,$01 Switch to the shadow registers.
  $A1FB,$01 Restore #REGhl from the stack.
  $A1FC,$03 Call #R$9BD2.

@ $A1FF label=PrintString_Loop
  $A1FF,$01 Switch back to the normal registers.
  $A200,$01 Fetch the character to print.
  $A201,$04 If bit 7 is set (which signifies the end of the string), jump to #R$A210.
  $A205,$03 Call #R$A1D3.
  $A208,$01 Increment #REGde by one.
  $A209,$01 Switch to the shadow registers.
  $A20A,$01 Switch to the shadow #REGaf register.
  $A20B,$01 Copy the attribute byte to the screen.
  $A20C,$01 Increment #REGl by one.
  $A20D,$01 Switch to the shadow #REGaf register.
  $A20E,$02 Jump to #R$A1FF.
N $A210 Because the last character contains the terminator, it needs to be handled separately.
@ $A210 label=PrintString_LastCharacter
  $A210,$02,b$01 Keep only bits 0-6 (i.e. strip the bit 7 terminator).
  $A212,$03 Call #R$A1D3.
  $A215,$01 Switch to the shadow registers.
  $A216,$01 Switch to the shadow #REGaf register.
  $A217,$01 Copy the attribute byte to the screen.
  $A218,$01 Return.

c $A219 Draw Side Panel
@ $A219 label=DrawSidePanel
  $A219,$06 Write #R$B03A to #R$5E01.
  $A21F,$03 #REGhl=#N($00C0, $04, $04) (screen buffer location).
  $A222,$03 #REGde=#R$B32A.
  $A225,$03 #REGbc=#N$08 (width), #N$18 (height).
@ $A228 label=SidePanel_Loop_Y
  $A228,$02 Stash #REGbc and #REGhl on the stack.
  $A22A,$03 Call #R$9BA2.
@ $A22D label=SidePanel_Loop_X
  $A22D,$01 #REGa=character data byte.
  $A22E,$01 Increment the character data pointer by one.
  $A22F,$03 Call #R$A1D3.
  $A232,$02 Decrease width counter by one and loop back to #R$A22D until counter is zero.
  $A234,$01 Restore #REGhl from the stack.
  $A235,$04 #REGh=#REGh + #N$08.
  $A239,$01 Restore #REGbc from the stack.
  $A23A,$03 Decrease height counter by one and loop back to #R$A228 until counter is zero.
  $A23D,$03 Jump to #R$A1AE.

c $A240 Draw Side Panel Attributes
@ $A240 label=DrawSidePanelAttrs

c $A2CE Draw Lives
@ $A2CE label=DrawLives

c $A311 Menu Icons
@ $A311 label=MenuIcons
  $A311,$04 #REGix=#R$A17D.
  $A315,$03 #REGhl=#R$A331.
  $A318,$02 #REGb=#N$09 (counter).
@ $A31A label=MenuIcons_Loop
  $A31A,$01 Stash the counter on the stack.
  $A31B,$08 Copy #N$08 bytes of data from #REGhl to #R$A17D.
  $A323,$02 Stash #REGhl and #REGde on the stack.
  $A325,$03 Call #R$9F4A.
  $A328,$03 Call #R$A00E.
  $A32B,$02 Restore #REGde and #REGhl from the stack.
  $A32D,$01 Restore the counter from the stack.
  $A32E,$02 Decrease counter by one and loop back to #R$A31A until counter is zero.
  $A330,$01 Return.
N $A331 The sprite IDs are stored +#N$01 higher than their actual value.
@ $A331 label=MenuEntities
B $A331,$48,$08
. #TABLE(default,centre,centre,centre,centre)
.   { =h Address | =h Sprite | =h Attribute | =h Screen Buffer Location }
.   { #N$A331 | #SPRITENAME(#PEEK($A331) - $01) | #N(#PEEK($A334)) | #N(#PEEK($A335) + #PEEK($A336) * $100) }
.   { #N$A339 | #SPRITENAME(#PEEK($A339) - $01) | #N(#PEEK($A33C)) | #N(#PEEK($A33D) + #PEEK($A33E) * $100) }
.   { #N$A341 | #SPRITENAME(#PEEK($A341) - $01) | #N(#PEEK($A344)) | #N(#PEEK($A335) + #PEEK($A346) * $100) }
.   { #N$A349 | #SPRITENAME(#PEEK($A349) - $01) | #N(#PEEK($A34C)) | #N(#PEEK($A335) + #PEEK($A34E) * $100) }
.   { #N$A351 | #SPRITENAME(#PEEK($A351) - $01) | #N(#PEEK($A354)) | #N(#PEEK($A335) + #PEEK($A356) * $100) }
.   { #N$A359 | #SPRITENAME(#PEEK($A359) - $01) | #N(#PEEK($A35C)) | #N(#PEEK($A335) + #PEEK($A35E) * $100) }
.   { #N$A361 | #SPRITENAME(#PEEK($A361) - $01) | #N(#PEEK($A364)) | #N(#PEEK($A335) + #PEEK($A366) * $100) }
.   { #N$A369 | #SPRITENAME(#PEEK($A369) - $01) | #N(#PEEK($A36C)) | #N(#PEEK($A335) + #PEEK($A36E) * $100) }
.   { #N$A371 | #SPRITENAME(#PEEK($A371) - $01) | #N(#PEEK($A374)) | #N(#PEEK($A375) + #PEEK($A376) * $100) }
. TABLE#

c $A379 Determine Line Slope

c $A3A8 Sounds: Click
@ $A3A8 label=SoundsClick
@ $A3AA label=SoundsBeep

c $A3BD Sounds: Inventory
@ $A3BD label=SoundsInventory

c $A3C2 Sounds: Drop Item
@ $A3C2 label=SoundsDrop

c $A3C7 Sounds: Walking
@ $A3C7 label=SoundsWalking

c $A3D8 Sounds: Walk Low
@ $A3D8 label=SoundsWalkLow

c $A3E0 Sounds: Start Beep
@ $A3E0 label=SoundsStart

c $A3E5 Sounds: Touching
@ $A3E5 label=SoundsTouching

c $A3E8 Queue Sound
@ $A3E8 label=QueueSound

c $A3EF Sound Effect
@ $A3EF label=SoundEffect

c $A3FE Clear Sound
@ $A3FE label=ClearSound

c $A403 Sounds: Entry
@ $A403 label=SoundsEntry

c $A408 Sound Effect Next Note
@ $A408 label=SoundEffectNext

c $A41B Sounds: Axe Throw
@ $A41B label=SoundsAxeThrow

c $A427 Sounds: Sword
@ $A427 label=SoundsSword

c $A438 Sounds: Fireball
@ $A438 label=SoundsFireball

c $A445 Sounds: Weapon Pop
@ $A445 label=SoundsWeaponPop

c $A45F Sounds: Appear
@ $A45F label=SoundsAppear

c $A46E Sounds: Door
@ $A46E label=SoundsDoor

c $A485 Sounds: Eating
@ $A485 label=SoundsEating
@ $A4A0 label=TableTonesEating
B $A4A0,$10,$08

c $A4B0 Sounds: Bounce
@ $A4B0 label=SoundsBounce

w $A4BE Sprites Table
E $A4BE View the equivalent code in;
. #LIST
. { #COOKIE$7702 }
. { #JETPAC$0000 }
. { #LUNARJETMAN$0000 }
. { #PSSST$761A }
. { #SABREWULF$BF84 }
. { #TRANZAM$7F06 }
. LIST#
@ $A4BE label=SpritesTable
  $A4BE,$02 Sprite ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $A4BE) / 2)) #SPRITENAME((#PC - $A4BE) / 2).
L $A4BE,$02,$A1

w $A600 Graphics Table
@ $A600 label=GraphicsTable
  $A600,$02 Graphic ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $A600) / 2)) #GRAPHICNAME((#PC - $A600) / 2).
L $A600,$02,$27

w $A64E Graphics Attributes Table
@ $A64E label=GraphicsAttributesTable
  $A64E,$02 Graphic ID: #R(#PEEK(#PC) + #PEEK(#PC + 1) * $100)(#N((#PC - $A64E) / 2)) #GRAPHICNAME((#PC - $A64E) / 2).
L $A64E,$02,$27

b $A69C Graphic: Door Locked
  $A69C,$01 Width = #N(#PEEK(#PC)) bytes.
  $A69D,$01 Height = #N(#PEEK(#PC)) pixels.
  $A69E,$60,$04 #GRAPHIC$07(door-locked)

b $A6FE Graphic Attributes: Door Locked
N $A6FE Red.
  $A6FE,$01 Width = #N(#PEEK(#PC)) bytes.
  $A6FF,$01 Height = #N(#PEEK(#PC)) bytes.
  $A700,$0C,$04 #GRAPHIC$07,1(door-locked-red)

N $A70C Green.
  $A70C,$01 Width = #N(#PEEK(#PC)) bytes.
  $A70D,$01 Height = #N(#PEEK(#PC)) bytes.
  $A70E,$0C,$04 #GRAPHIC$08,1(door-locked-green)

N $A71A Cyan.
  $A71A,$01 Width = #N(#PEEK(#PC)) bytes.
  $A71B,$01 Height = #N(#PEEK(#PC)) bytes.
  $A71C,$0C,$04 #GRAPHIC$09,1(door-locked-cyan)

N $A728 Yellow.
  $A728,$01 Width = #N(#PEEK(#PC)) bytes.
  $A729,$01 Height = #N(#PEEK(#PC)) bytes.
  $A72A,$0C,$04 #GRAPHIC$0A,1(door-locked-yellow)

b $A736 Graphic Attributes: Cave Door Locked
N $A736 Red.
  $A736,$01 Width = #N(#PEEK(#PC)) bytes.
  $A737,$01 Height = #N(#PEEK(#PC)) bytes.
  $A738,$0C,$04 #GRAPHIC$0B,1(cave-door-locked-red)

N $A744 Green.
  $A744,$01 Width = #N(#PEEK(#PC)) bytes.
  $A745,$01 Height = #N(#PEEK(#PC)) bytes.
  $A746,$0C,$04 #GRAPHIC$0C,1(cave-door-locked-green)

N $A752 Cyan.
  $A752,$01 Width = #N(#PEEK(#PC)) bytes.
  $A753,$01 Height = #N(#PEEK(#PC)) bytes.
  $A754,$0C,$04 #GRAPHIC$0D,1(cave-door-locked-cyan)

N $A760 Yellow.
  $A760,$01 Width = #N(#PEEK(#PC)) bytes.
  $A761,$01 Height = #N(#PEEK(#PC)) bytes.
  $A762,$0C,$04 #GRAPHIC$0E,1(cave-door-locked-yellow)

b $A76E Graphic: Door Frame
  $A76E,$01 Width = #N(#PEEK(#PC)) bytes.
  $A76F,$01 Height = #N(#PEEK(#PC)) pixels.
  $A770,$60,$04 #GRAPHIC$01(door)

b $A7D0 Graphic Attributes: Door Frame
  $A7D0,$01 Width = #N(#PEEK(#PC)) bytes.
  $A7D1,$01 Height = #N(#PEEK(#PC)) bytes.
  $A7D2,$0C,$04 #GRAPHIC$01,1(door-colour)

b $A7DE Graphic Attributes: Cave Door Frame
  $A7DE,$01 Width = #N(#PEEK(#PC)) bytes.
  $A7DF,$01 Height = #N(#PEEK(#PC)) bytes.
  $A7E0,$0C,$04 #GRAPHIC$00,1(cave-door-colour)

b $A7EC Graphic: Table
  $A7EC,$01 Width = #N(#PEEK(#PC)) bytes.
  $A7ED,$01 Height = #N(#PEEK(#PC)) pixels.
  $A7EE,$58,$04 #GRAPHIC$11(table)

b $A846 Graphic Attributes: Table
  $A846,$01 Width = #N(#PEEK(#PC)) bytes.
  $A847,$01 Height = #N(#PEEK(#PC)) bytes.
  $A848,$0C,$04 #GRAPHIC$11,1(table-colour)

b $A854

b $B3EA Graphic: Big Door Frame
  $B3EA,$01 Width = #N(#PEEK(#PC)) bytes.
  $B3EB,$01 Height = #N(#PEEK(#PC)) pixels.
  $B3EC,$C0,$04 #GRAPHIC$02(big-door)

b $B4AC Graphic Attributes: Big Door Frame
  $B4AC,$01 Width = #N(#PEEK(#PC)) bytes.
  $B4AD,$01 Height = #N(#PEEK(#PC)) pixels.
  $B4AE,$18,$04 #GRAPHIC$02,1(big-door-colour)

b $AD2E Sprite: Knight
E $AD2E #UDGTABLE(default,centre)
. { =h Down | =h Up | =h Left | =h Right }{
.   #UDGARRAY*knight-down-01,25;knight-down-02;knight-down-03;knight-down-02(knight-down) |
.   #UDGARRAY*knight-up-01,25;knight-up-02;knight-up-03;knight-up-02(knight-up) |
.   #UDGARRAY*knight-left-01,25;knight-left-02;knight-left-03;knight-left-02(knight-left) |
.   #UDGARRAY*knight-right-01,25;knight-right-02;knight-right-03;knight-right-02(knight-right)
. }
. UDGTABLE#
N $AD2E Down Frame 1.
  $AD2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $AD2F,$24,$02 #SPRITE$0C(knight-down-01*)

N $AD53 Down Frame 2.
  $AD53,$01 Height = #N(#PEEK(#PC)) pixels.
  $AD54,$24,$02 #SPRITE$0D(knight-down-02*)

N $AD78 Down Frame 3.
  $AD78,$01 Height = #N(#PEEK(#PC)) pixels.
  $AD79,$24,$02 #SPRITE$0E(knight-down-03*)

N $AD9D Up Frame 1.
  $AD9D,$01 Height = #N(#PEEK(#PC)) pixels.
  $AD9E,$24,$02 #SPRITE$08(knight-up-01*)

N $ADC2 Up Frame 2.
  $ADC2,$01 Height = #N(#PEEK(#PC)) pixels.
  $ADC3,$24,$02 #SPRITE$09(knight-up-02*)

N $ADE7 Up Frame 3.
  $ADE7,$01 Height = #N(#PEEK(#PC)) pixels.
  $ADE8,$24,$02 #SPRITE$0A(knight-up-03*)

N $AE0C Left Frame 1.
  $AE0C,$01 Height = #N(#PEEK(#PC)) pixels.
  $AE0D,$24,$02 #SPRITE$00(knight-left-01*)

N $AE31 Left Frame 2.
  $AE31,$01 Height = #N(#PEEK(#PC)) pixels.
  $AE32,$24,$02 #SPRITE$01(knight-left-02*)

N $AE56 Left Frame 3.
  $AE56,$01 Height = #N(#PEEK(#PC)) pixels.
  $AE57,$24,$02 #SPRITE$02(knight-left-03*)

N $AE7B Right Frame 1.
  $AE7B,$01 Height = #N(#PEEK(#PC)) pixels.
  $AE7C,$24,$02 #SPRITE$04(knight-right-01*)

N $AEA0 Right Frame 2.
  $AEA0,$01 Height = #N(#PEEK(#PC)) pixels.
  $AEA1,$24,$02 #SPRITE$05(knight-right-02*)

N $AEC5 Right Frame 3.
  $AEC5,$01 Height = #N(#PEEK(#PC)) pixels.
  $AEC6,$24,$02 #SPRITE$06(knight-right-03*)

b $AEEA Sprite: None
  $AEEA,$01 Height = #N(#PEEK(#PC)) pixels.
  $AEEB,$01

b $AEEC Sprite: Blank
  $AEEC,$01 Height = #N(#PEEK(#PC)) pixels.
  $AEED,$20,$02 #SPRITE$30(blank)

b $AF0D Sprite: Leaf
  $AF0D,$01 Height = #N(#PEEK(#PC)) pixels.
  $AF0E,$20,$02 #SPRITE$7F(leaf)

b $AF2E Sprite: Key
  $AF2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $AF2F,$14,$02 #SPRITE$80(key)

b $AF43 Sprite: Wine
  $AF43,$01 Height = #N(#PEEK(#PC)) pixels.
  $AF44,$28,$02 #SPRITE$81(wine)

b $AF6C Sprite: Bottle
  $AF6C,$01 Height = #N(#PEEK(#PC)) pixels.
  $AF6D,$28,$02 #SPRITE$56(bottle)

b $AF95 Sprite: Wing
  $AF95,$01 Height = #N(#PEEK(#PC)) pixels.
  $AF96,$20,$02 #SPRITE$83(wing)

b $AFB6 Sprite: Whip
  $AFB6,$01 Height = #N(#PEEK(#PC)) pixels.
  $AFB7,$20,$02 #SPRITE$84(whip)

b $AFD7 Sprite: Frog Leg
  $AFD7,$01 Height = #N(#PEEK(#PC)) pixels.
  $AFD8,$20,$02 #SPRITE$85(frogleg)

b $AFF8 Sprite: Dessert
  $AFF8,$01 Height = #N(#PEEK(#PC)) pixels.
  $AFF9,$20,$02 #SPRITE$54(dessert)

b $B019 Sprite: Apple
  $B019,$01 Height = #N(#PEEK(#PC)) pixels.
  $B01A,$20,$02 #SPRITE$55(apple)

b $B03A Side Panel UDGs
D $B03A The image is assembled by #R$A219 using the data held at #R$B32A.
@ $B03A label=SidePanelUDG
  $B03A,$08 #UDG(#PC)
L $B03A,$08,$5E

b $B32A Side Panel Data
D $B32A Uses the UDG data at #R$B03A. The image is assembled by #R$A219.
@ $B32A label=SidePanelData
  $B32A,$08 #FOR($00,$07)||x|#UDG($B03A + (#PEEK(#PC + x) * $08))||
L $B32A,$08,$18

b $B4C6 Graphic: Ghost Picture
  $B4C6,$01 Width = #N(#PEEK(#PC)) bytes.
  $B4C7,$01 Height = #N(#PEEK(#PC)) pixels.
  $B4C8,$60,$04 #GRAPHIC$10(ghost-pic)

b $B528 Graphic Attributes: Ghost Picture
  $B528,$01 Width = #N(#PEEK(#PC)) bytes.
  $B529,$01 Height = #N(#PEEK(#PC)) bytes.
  $B52A,$0C,$04 #GRAPHIC$10,1(ghost-pic-colour)

b $B536 Sprite: Serf
E $B536 #UDGTABLE(default,centre)
. { =h Down | =h Up | =h Left | =h Right }{
.   #UDGARRAY*serf-down-01,25;serf-down-02;serf-down-03;serf-down-02(serf-down) |
.   #UDGARRAY*serf-up-01,25;serf-up-02;serf-up-03;serf-up-02(serf-up) |
.   #UDGARRAY*serf-left-01,25;serf-left-02;serf-left-03;serf-left-02(serf-left) |
.   #UDGARRAY*serf-right-01,25;serf-right-02;serf-right-03;serf-right-02(serf-right)
. }
. UDGTABLE#
N $B536 Down Frame 1.
  $B536,$01 Height = #N(#PEEK(#PC)) pixels.
  $B537 #SPRITE$2C(serf-down-01*)

N $B55B Down Frame 2.
  $B55B,$01 Height = #N(#PEEK(#PC)) pixels.
  $B55C #SPRITE$2D(serf-down-02*)

N $B580 Down Frame 3.
  $B580,$01 Height = #N(#PEEK(#PC)) pixels.
  $B581 #SPRITE$2E(serf-down-03*)

N $B5A5 Up Frame 1.
  $B5A5,$01 Height = #N(#PEEK(#PC)) pixels.
  $B5A6 #SPRITE$28(serf-up-01*)

N $B5CA Up Frame 2.
  $B5CA,$01 Height = #N(#PEEK(#PC)) pixels.
  $B5CB #SPRITE$29(serf-up-02*)

N $B5EF Up Frame 3.
  $B5EF,$01 Height = #N(#PEEK(#PC)) pixels.
  $B5F0 #SPRITE$2A(serf-up-03*)

N $B614 Left Frame 1.
  $B614,$01 Height = #N(#PEEK(#PC)) pixels.
  $B615 #SPRITE$20(serf-left-01*)

N $B639 Left Frame 2.
  $B639,$01 Height = #N(#PEEK(#PC)) pixels.
  $B63A #SPRITE$21(serf-left-02*)

N $B65E Left Frame 3.
  $B65E,$01 Height = #N(#PEEK(#PC)) pixels.
  $B65F #SPRITE$22(serf-left-03*)

N $B683 Right Frame 1.
  $B683,$01 Height = #N(#PEEK(#PC)) pixels.
  $B684 #SPRITE$24(serf-right-01*)

N $B6A8 Right Frame 2.
  $B6A8,$01 Height = #N(#PEEK(#PC)) pixels.
  $B6A9 #SPRITE$25(serf-right-02*)

N $B6CD Right Frame 3.
  $B6CD,$01 Height = #N(#PEEK(#PC)) pixels.
  $B6CE #SPRITE$26(serf-right-03*)

b $B6F2 Graphic: Clock
  $B6F2,$01 Width = #N(#PEEK(#PC)) bytes.
  $B6F3,$01 Height = #N(#PEEK(#PC)) pixels.
  $B6F4,$80,$04 #GRAPHIC$0F(clock)

b $B774 Graphic Attributes: Clock
  $B774,$01 Width = #N(#PEEK(#PC)) bytes.
  $B775,$01 Height = #N(#PEEK(#PC)) bytes.
  $B776,$10,$04 #GRAPHIC$0F,1(clock-colour)

b $B786 Sprite: Wizard
E $B786 #UDGTABLE(default,centre)
. { =h Down | =h Up | =h Left | =h Right }{
.   #UDGARRAY*wizard-down-01,25;wizard-down-02;wizard-down-03;wizard-down-02(wizard-down) |
.   #UDGARRAY*wizard-up-01,25;wizard-up-02;wizard-up-03;wizard-up-02(wizard-up) |
.   #UDGARRAY*wizard-left-01,25;wizard-left-02;wizard-left-03;wizard-left-02(wizard-left) |
.   #UDGARRAY*wizard-right-01,25;wizard-right-02;wizard-right-03;wizard-right-02(wizard-right)
. }
. UDGTABLE#
N $B786 Down Frame 1.
  $B786,$01 Height = #N(#PEEK(#PC)) pixels.
  $B787,$28,$02 #SPRITE$1C(wizard-down-01*)

N $B7AF Down Frame 2.
  $B7AF,$01 Height = #N(#PEEK(#PC)) pixels.
  $B7B0,$28,$02 #SPRITE$1D(wizard-down-02*)

N $B7D8 Down Frame 3.
  $B7D8,$01 Height = #N(#PEEK(#PC)) pixels.
  $B7D9,$28,$02 #SPRITE$1E(wizard-down-03*)

N $B801 Up Frame 1.
  $B801,$01 Height = #N(#PEEK(#PC)) pixels.
  $B802,$28,$02 #SPRITE$18(wizard-up-01*)

N $B82A Up Frame 2.
  $B82A,$01 Height = #N(#PEEK(#PC)) pixels.
  $B82B,$28,$02 #SPRITE$19(wizard-up-02*)

N $B853 Up Frame 3.
  $B853,$01 Height = #N(#PEEK(#PC)) pixels.
  $B854,$28,$02 #SPRITE$1A(wizard-up-03*)

N $B87C Left Frame 1.
  $B87C,$01 Height = #N(#PEEK(#PC)) pixels.
  $B87D,$28,$02 #SPRITE$10(wizard-left-01*)

N $B8A5 Left Frame 2.
  $B8A5,$01 Height = #N(#PEEK(#PC)) pixels.
  $B8A6,$28,$02 #SPRITE$11(wizard-left-02*)

N $B8CE Left Frame 3.
  $B8CE,$01 Height = #N(#PEEK(#PC)) pixels.
  $B8CF,$28,$02 #SPRITE$12(wizard-left-03*)

N $B8F7 Right Frame 1.
  $B8F7,$01 Height = #N(#PEEK(#PC)) pixels.
  $B8F8,$28,$02 #SPRITE$14(wizard-right-01*)

N $B920 Right Frame 2.
  $B920,$01 Height = #N(#PEEK(#PC)) pixels.
  $B921,$28,$02 #SPRITE$15(wizard-right-02*)

N $B949 Right Frame 3.
  $B949,$01 Height = #N(#PEEK(#PC)) pixels.
  $B94A,$28,$02 #SPRITE$16(wizard-right-03*)

b $B972 Sprite: Sword
N $B972 Frame 7.
  $B972,$01 Height = #N(#PEEK(#PC)) pixels.
  $B973,$18,$02 #SPRITE$3D(sword-07)

N $B98B Frame 4.
  $B98B,$01 Height = #N(#PEEK(#PC)) pixels.
  $B98C,$1A,$02 #SPRITE$3A(sword-04)

N $B9A6 Frame 5.
  $B9A6,$01 Height = #N(#PEEK(#PC)) pixels.
  $B9A7,$20,$02 #SPRITE$3B(sword-05)

N $B9C7 Frame 6.
  $B9C7,$01 Height = #N(#PEEK(#PC)) pixels.
  $B9C8,$1A,$02 #SPRITE$3C(sword-06)

N $B9E2 Frame 3.
  $B9E2,$01 Height = #N(#PEEK(#PC)) pixels.
  $B9E3,$18,$02 #SPRITE$39(sword-03)

N $B9FB Frame 2.
  $B9FB,$01 Height = #N(#PEEK(#PC)) pixels.
  $B9FC,$18,$02 #SPRITE$38(sword-02)

N $BA16 Frame 1.
  $BA16,$01 Height = #N(#PEEK(#PC)) pixels.
  $BA17,$20,$02 #SPRITE$37(sword-01)

N $BA37 Frame 8.
  $BA37,$01 Height = #N(#PEEK(#PC)) pixels.
  $BA38,$20,$02 #SPRITE$3E(sword-08)

b $BA58 Sprite: Axe
E $BA58 #UDGARRAY*axe-01,25;axe-02;axe-03;axe-04;axe-05;axe-06;axe-07;axe-08(axe)
N $BA58 Frame 1.
  $BA58,$01 Height = #N(#PEEK(#PC)) pixels.
  $BA59,$20,$02 #SPRITE$3F(axe-01*)

N $BA79 Frame 2.
  $BA79,$01 Height = #N(#PEEK(#PC)) pixels.
  $BA7A,$20,$02 #SPRITE$40(axe-02*)

N $BA9A Frame 3.
  $BA9A,$01 Height = #N(#PEEK(#PC)) pixels.
  $BA9B,$20,$02 #SPRITE$41(axe-03*)

N $BABB Frame 4.
  $BABB,$01 Height = #N(#PEEK(#PC)) pixels.
  $BABC,$20,$02 #SPRITE$42(axe-04*)

N $BADC Frame 5.
  $BADC,$01 Height = #N(#PEEK(#PC)) pixels.
  $BADD,$20,$02 #SPRITE$43(axe-05*)

N $BAFD Frame 6.
  $BAFD,$01 Height = #N(#PEEK(#PC)) pixels.
  $BAFE,$20,$02 #SPRITE$44(axe-06*)

N $BB1E Frame 7.
  $BB1E,$01 Height = #N(#PEEK(#PC)) pixels.
  $BB1F,$20,$02 #SPRITE$45(axe-07*)

N $BB3F Frame 8.
  $BB3F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BB40,$20,$02 #SPRITE$46(axe-08*)

b $BB60 Sprite: Fireball
E $BB60 #UDGARRAY*fireball-01,25;fireball-02;fireball-03;fireball-04(fireball)
N $BB60 Frame 1.
  $BB60,$01 Height = #N(#PEEK(#PC)) pixels.
  $BB61,$1E,$02 #SPRITE$33(fireball-01*)

N $BB7F Frame 2.
  $BB7F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BB80,$1E,$02 #SPRITE$34(fireball-02*)

N $BB9E Frame 3.
  $BB9E,$01 Height = #N(#PEEK(#PC)) pixels.
  $BB9F,$1E,$02 #SPRITE$35(fireball-03*)

N $BBBD Frame 4.
  $BBBD,$01 Height = #N(#PEEK(#PC)) pixels.
  $BBBE,$1E,$02 #SPRITE$36(fireball-04*)

b $BBDC Sprite: Cursor
E $BBDC #UDGTABLE(default) { =h Output: } { #SPRITE$31(cursor-left)#SPRITE$32(cursor-right) } UDGTABLE#
N $BBDC Left.
  $BBDC,$01 Height = #N(#PEEK(#PC)) pixels.
  $BBDD,$28,$02 #SPRITE$31(cursor-left)

N $BC05 Right.
  $BC05,$01 Height = #N(#PEEK(#PC)) pixels.
  $BC06,$28,$02 #SPRITE$32(cursor-right)

b $BC2E Sprite: Keyboard
E $BC2E #UDGTABLE(default) { =h Output: } { #SPRITE$47(keyboard-left)#SPRITE$48(keyboard-right) } UDGTABLE#
N $BC2E Left.
  $BC2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $BC2F,$20,$02 #SPRITE$47(keyboard-left)

N $BC4F Right.
  $BC4F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BC50,$20,$02 #SPRITE$48(keyboard-right)

b $BC70 Sprite: Kempston
E $BC70 #UDGTABLE(default) { =h Output: } { #SPRITE$49(kempston-left)#SPRITE$4A(kempston-right) } UDGTABLE#
N $BC70 Left.
  $BC70,$01 Height = #N(#PEEK(#PC)) pixels.
  $BC71,$2E,$02 #SPRITE$49(kempston-left)

N $BC9F Right.
  $BC9F,$01 Height = #N(#PEEK(#PC)) pixels.
  $BCA0,$2E,$02 #SPRITE$4A(kempston-right)

b $BCCE Graphic: Cave Door Frame
  $BCCE,$01 Width = #N(#PEEK(#PC)) bytes.
  $BCCF,$01 Height = #N(#PEEK(#PC)) pixels.
  $BCD0,$60,$04 #GRAPHIC$00(cave-door)

b $BD30 Sprite: Pumpkin
N $BD30 Frame 1.
  $BD30,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD31,$26,$02 #SPRITE$4B(pumpkin-01)

N $BD57 Frame 2.
  $BD57,$01 Height = #N(#PEEK(#PC)) pixels.
  $BD58,$26,$02 #SPRITE$4C(pumpkin-02)

b $BD7E

b $BE4C Main Font
@ $BE4C label=MainFont
  $BE4C,$08 #UDG(#PC)
L $BE4C,$08,$5B

b $C124 Sprite: Can
  $C124,$01 Height = #N(#PEEK(#PC)) pixels.
  $C125,$28,$02 #SPRITE$4F(can)

b $C14D Sprite: Money Bag
  $C14D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C14E,$20,$02 #SPRITE$87(moneybag)

b $C16E Sprite: Coin
  $C16E,$01 Height = #N(#PEEK(#PC)) pixels.
  $C16F,$20,$02 #SPRITE$82(coin)

b $C18F Sprite: Gem
  $C18F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C190,$1A,$02 #SPRITE$86(gem)

b $C1AA Sprite: Candy
  $C1AA,$01 Height = #N(#PEEK(#PC)) pixels.
  $C1AB,$20,$02 #SPRITE$50(candy)

b $C1CB Sprite: Chop
  $C1CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $C1CC,$28,$02 #SPRITE$51(chop)

b $C1F4 Sprite: Lollipop
  $C1F4,$01 Height = #N(#PEEK(#PC)) pixels.
  $C1F5,$24,$02 #SPRITE$52(lollipop)

b $C219 Sprite: Ice Cream
  $C219,$01 Height = #N(#PEEK(#PC)) pixels.
  $C21A,$20,$02 #SPRITE$53(icecream)

b $C23A Sprite: Sparkle
E $C23A #UDGARRAY*sparkle-04,25;sparkle-03;sparkle-02;sparkle-01(sparkle)
N $C23A Frame 1.
  $C23A,$01 Height = #N(#PEEK(#PC)) pixels.
  $C23B,$18,$02 #SPRITE$57(sparkle-01*)

N $C253 Frame 2.
  $C253,$01 Height = #N(#PEEK(#PC)) pixels.
  $C254,$1A,$02 #SPRITE$58(sparkle-02*)

N $C26E Frame 3.
  $C26E,$01 Height = #N(#PEEK(#PC)) pixels.
  $C26F,$1E,$02 #SPRITE$59(sparkle-03*)

N $C28D Frame 4.
  $C28D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C28E,$20,$02 #SPRITE$5A(sparkle-04*)

b $C2AE Graphic: Cave Door Locked
  $C2AE,$01 Width = #N(#PEEK(#PC)) bytes.
  $C2AF,$01 Height = #N(#PEEK(#PC)) pixels.
  $C2B0,$60,$04 #GRAPHIC$0B(cave-door-locked)

b $C310 Sprite: Spider
N $C310 Frame 1.
  $C310,$01 Height = #N(#PEEK(#PC)) pixels.
  $C311,$1C,$02 #SPRITE$5B(spider-01)

N $C32D Frame 2.
  $C32D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C32E,$1C,$02 #SPRITE$5C(spider-02)

b $C34A Sprite: Spikey
N $C34A Frame 1.
  $C34A,$01 Height = #N(#PEEK(#PC)) pixels.
  $C34B,$20,$02 #SPRITE$5D(spikey-01)

N $C36B Frame 2.
  $C36B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C36C,$20,$02 #SPRITE$5E(spikey-02)

b $C38C Sprite: Blob
N $C38C Frame 1.
  $C38C,$01 Height = #N(#PEEK(#PC)) pixels.
  $C38D,$16,$02 #SPRITE$5F(blob-01)

N $C3A3 Frame 2.
  $C3A3,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3A4,$12,$02 #SPRITE$60(blob-02)

b $C3B6 Sprite: Ghoul
N $C3B6 Frame 1.
  $C3B6,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3B7,$28,$02 #SPRITE$61(ghoul-01)

N $C3DF Frame 2.
  $C3DF,$01 Height = #N(#PEEK(#PC)) pixels.
  $C3E0,$28,$02 #SPRITE$62(ghoul-02)

b $C408 Sprite: Ghost
N $C408 Frame 1.
  $C408,$01 Height = #N(#PEEK(#PC)) pixels.
  $C409,$20,$02 #SPRITE$67(ghost-01)

N $C429 Frame 2.
  $C429,$01 Height = #N(#PEEK(#PC)) pixels.
  $C42A,$20,$02 #SPRITE$68(ghost-02)

b $C44A Sprite: Bat
N $C44A Frame 1.
  $C44A,$01 Height = #N(#PEEK(#PC)) pixels.
  $C44B,$24,$02 #SPRITE$69(bat-01)

N $C46F Frame 2.
  $C46F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C470,$1C,$02 #SPRITE$6A(bat-02)

b $C48C Graphic: Chicken
N $C48C Empty.
  $C48C,$01 Width = #N(#PEEK(#PC)) bytes.
  $C48D,$01 Height = #N(#PEEK(#PC)) pixels.
  $C48E,$B4,$06 #GRAPHIC$13(chicken-empty)

N $C542 Full.
  $C542,$01 Width = #N(#PEEK(#PC)) bytes.
  $C543,$01 Height = #N(#PEEK(#PC)) pixels.
  $C544,$B4,$06 #GRAPHIC$12(chicken-full)

b $C5F8 Sprite: Pop
N $C5F8 Frame 1.
  $C5F8,$01 Height = #N(#PEEK(#PC)) pixels.
  $C5F9,$16,$02 #SPRITE$6B(pop-01)

N $C60F Frame 2.
  $C60F,$01 Height = #N(#PEEK(#PC)) pixels.
  $C610,$1A,$02 #SPRITE$6C(pop-02)

N $C62A Frame 3.
  $C62A,$01 Height = #N(#PEEK(#PC)) pixels.
  $C62B,$1E,$02 #SPRITE$6D(pop-03)

N $C649 Frame 4.
  $C649,$01 Height = #N(#PEEK(#PC)) pixels.
  $C64A,$20,$02 #SPRITE$6E(pop-04)

b $C66A Graphic: Wall Antlers
  $C66A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C66B,$01 Height = #N(#PEEK(#PC)) pixels.
  $C66C,$40,$04 #GRAPHIC$14(wall-antlers)

b $C6AC Graphic: Wall Trophy
  $C6AC,$01 Width = #N(#PEEK(#PC)) bytes.
  $C6AD,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6AE,$20,$02 #GRAPHIC$15(wall-trophy)

b $C6CE Graphic: Bookcase
  $C6CE,$01 Width = #N(#PEEK(#PC)) bytes.
  $C6CF,$01 Height = #N(#PEEK(#PC)) pixels.
  $C6D0,$A0,$05 #GRAPHIC$16(bookcase)

b $C770 Graphic: Trap
N $C770 Open.
  $C770,$01 Width = #N(#PEEK(#PC)) bytes.
  $C771,$01 Height = #N(#PEEK(#PC)) pixels.
  $C772,$80,$04 #GRAPHIC$18(trap-open)

N $C7F2 Closed.
  $C7F2,$01 Width = #N(#PEEK(#PC)) bytes.
  $C7F3,$01 Height = #N(#PEEK(#PC)) pixels.
  $C7F4,$80,$04 #GRAPHIC$17(trap-closed)

b $C874 Graphic: Rug
  $C874,$01 Width = #N(#PEEK(#PC)) bytes.
  $C875,$01 Height = #N(#PEEK(#PC)) pixels.
  $C876,$EA,$06 #GRAPHIC$1A(rug)

b $C960 Graphic Attributes: Wall Antlers
  $C960,$01 Width = #N(#PEEK(#PC)) bytes.
  $C961,$01 Height = #N(#PEEK(#PC)) bytes.
  $C962,$08,$04 #GRAPHIC$14,1(wall-antlers-colour)

b $C96A Graphic Attributes: Wall Trophy
  $C96A,$01 Width = #N(#PEEK(#PC)) bytes.
  $C96B,$01 Height = #N(#PEEK(#PC)) bytes.
  $C96C,$04,$02 #GRAPHIC$15,1(wall-trophy-colour)

b $C970 Graphic Attributes: Bookcase
  $C970,$01 Width = #N(#PEEK(#PC)) bytes.
  $C971,$01 Height = #N(#PEEK(#PC)) bytes.
  $C972,$14,$05 #GRAPHIC$16,1(bookcase-colour)

b $C986 Graphic Attributes: Trap
N $C986 Open.
  $C986,$01 Width = #N(#PEEK(#PC)) bytes.
  $C987,$01 Height = #N(#PEEK(#PC)) bytes.
  $C988,$10,$04 #GRAPHIC$18,1(trap-open-colour)

N $C998 Closed.
  $C998,$01 Width = #N(#PEEK(#PC)) bytes.
  $C999,$01 Height = #N(#PEEK(#PC)) pixels.
  $C99A,$10,$04 #GRAPHIC$17,1(trap-closed-colour)

b $C9AA Graphic Attributes: Rug
  $C9AA,$01 Width = #N(#PEEK(#PC)) bytes.
  $C9AB,$01 Height = #N(#PEEK(#PC)) bytes.
  $C9AC,$1E,$06 #GRAPHIC$1A,1(rug-colour)

b $C9CA Graphic: A.C.G. Shield
  $C9CA,$01 Width = #N(#PEEK(#PC)) bytes.
  $C9CB,$01 Height = #N(#PEEK(#PC)) pixels.
  $C9CC,$20,$02 #GRAPHIC$1B(acg-shield)

b $C9EC Graphic: Wall Shield
  $C9EC,$01 Width = #N(#PEEK(#PC)) bytes.
  $C9ED,$01 Height = #N(#PEEK(#PC)) pixels.
  $C9EE,$20,$02 #GRAPHIC$1C(wall-shield)

b $CA0E Graphic: Suit Of Armour
  $CA0E,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA0F,$01 Height = #N(#PEEK(#PC)) pixels.
  $CA10,$40,$02 #GRAPHIC$1D(suit-armour)

b $CA50 Graphic Attributes: A.C.G. Shield
  $CA50,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA51,$01 Height = #N(#PEEK(#PC)) bytes.
  $CA52,$04,$02 #GRAPHIC$1B,1(acg-shield-colour)

b $CA56 Graphic Attributes: Wall Shield
  $CA56,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA57,$01 Height = #N(#PEEK(#PC)) bytes.
  $CA58,$04,$02 #GRAPHIC$1C,1(wall-shield-colour)

b $CA5C Graphic Attributes: Suit Of Armour
  $CA5C,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA5D,$01 Height = #N(#PEEK(#PC)) bytes.
  $CA5E,$08,$02 #GRAPHIC$1D,1(suit-armour-colour)

b $CA66 Graphic Attributes: Cave Door Shut
  $CA66,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA67,$01 Height = #N(#PEEK(#PC)) bytes.
  $CA68,$0C,$04 #GRAPHIC$21,1(cave-door-shut-colour)

b $CA74 Graphic Attributes: Door shut
  $CA74,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA75,$01 Height = #N(#PEEK(#PC)) bytes.
  $CA76,$0C,$04 #GRAPHIC$1F,1(door-shut-colour)

b $CA82 Graphic: Door shut
  $CA82,$01 Width = #N(#PEEK(#PC)) bytes.
  $CA83,$01 Height = #N(#PEEK(#PC)) pixels.
  $CA84,$60,$04 #GRAPHIC$1F(door-shut)

b $CAE4 Graphic: Cave Door Shut
  $CAE4,$01 Width = #N(#PEEK(#PC)) bytes.
  $CAE5,$01 Height = #N(#PEEK(#PC)) pixels.
  $CAE6,$60,$04 #GRAPHIC$21(cave-door-shut)

b $CB46 Sprite: Mummy
N $CB46 Frame 1.
  $CB46,$01 Height = #N(#PEEK(#PC)) pixels.
  $CB47,$30,$02 #SPRITE$6F(mummy-01)

N $CB77 Frame 2.
  $CB77,$01 Height = #N(#PEEK(#PC)) pixels.
  $CB78,$30,$02 #SPRITE$70(mummy-02)

N $CBA8 Frame 3.
  $CBA8,$01 Height = #N(#PEEK(#PC)) pixels.
  $CBA9,$30,$02 #SPRITE$71(mummy-03)

b $CBD9 Sprite: Frankenstein
N $CBD9 Frame 1.
  $CBD9,$01 Height = #N(#PEEK(#PC)) pixels.
  $CBDA,$30,$02 #SPRITE$73(franken-01)

N $CC0A Frame 2.
  $CC0A,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC0B,$30,$02 #SPRITE$74(franken-02)

N $CC3B Frame 3.
  $CC3B,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC3C,$30,$02 #SPRITE$75(franken-03)

b $CC6C Sprite: Devil
N $CC6C Frame 1.
  $CC6C,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC6D,$30,$02 #SPRITE$77(devil-01)

N $CC9D Frame 2.
  $CC9D,$01 Height = #N(#PEEK(#PC)) pixels.
  $CC9E,$30,$02 #SPRITE$78(devil-02)

N $CCCE Frame 3.
  $CCCE,$01 Height = #N(#PEEK(#PC)) pixels.
  $CCCF,$30,$02 #SPRITE$79(devil-03)

b $CCFF Sprite: Dracula
N $CCFF Frame 1.
  $CCFF,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD00,$30,$02 #SPRITE$7B(dracula-01)

N $CD30 Frame 2.
  $CD30,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD31,$30,$02 #SPRITE$7C(dracula-02)

N $CD61 Frame 3.
  $CD61,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD62,$30,$02 #SPRITE$7D(dracula-03)

b $CD92 Sprite: Tombstone
  $CD92,$01 Height = #N(#PEEK(#PC)) pixels.
  $CD93,$2A,$02 #SPRITE$8E(tombstone)

b $CDBD Sprite: Crucifix
  $CDBD,$01 Height = #N(#PEEK(#PC)) pixels.
  $CDBE,$24,$02 #SPRITE$89(crucifix)

b $CDE2 Sprite: Skull
  $CDE2,$01 Height = #N(#PEEK(#PC)) pixels.
  $CDE3,$1E,$02 #SPRITE$88(skull)

b $CE01 Sprite: Witch
E $CE01 #UDGTABLE(default,centre)
. { =h Left | =h Right }{
.   #UDGARRAY*witch-left-01,25;witch-left-02(witch-left) |
.   #UDGARRAY*witch-right-01,25;witch-right-02(witch-right)
. }
. UDGTABLE#
N $CE01 Left Frame 1.
  $CE01,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE02,$2C,$02 #SPRITE$8F(witch-left-01*)

N $CE2E Left Frame 2.
  $CE2E,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE2F,$2C,$02 #SPRITE$90(witch-left-02*)

N $CE5B Right Frame 1.
  $CE5B,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE5C,$2C,$02 #SPRITE$91(witch-right-01*)

N $CE88 Right Frame 2.
  $CE88,$01 Height = #N(#PEEK(#PC)) pixels.
  $CE89,$2C,$02 #SPRITE$92(witch-right-02*)

b $CEB5 Sprite: Monk
E $CEB5 #UDGTABLE(default,centre)
. { =h Left | =h Right }{
.   #UDGARRAY*monk-left-01,25;monk-left-02(monk-left) |
.   #UDGARRAY*monk-right-01,25;monk-right-02(monk-right)
. }
. UDGTABLE#
N $CEB5 Left Frame 1.
  $CEB5,$01 Height = #N(#PEEK(#PC)) pixels.
  $CEB6,$26,$02 #SPRITE$93(monk-left-01*)

N $CEDC Left Frame 2.
  $CEDC,$01 Height = #N(#PEEK(#PC)) pixels.
  $CEDD,$26,$02 #SPRITE$94(monk-left-02*)

N $CF03 Right Frame 1.
  $CF03,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF04,$26,$02 #SPRITE$95(monk-right-01*)

N $CF2A Right Frame 2.
  $CF2A,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF2B,$26,$02 #SPRITE$96(monk-right-02*)

b $CF51 Sprite: Bat
N $CF51 Left Frame 1.
  $CF51,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF52,$26,$02 #SPRITE$97(bat-left-01)

N $CF78 Left Frame 2.
  $CF78,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF79,$1A,$02 #SPRITE$98(bat-left-02)

N $CF93 Right Frame 1.
  $CF93,$01 Height = #N(#PEEK(#PC)) pixels.
  $CF94,$1A,$02 #SPRITE$99(bat-right-01)

N $CFAE Right Frame 2.
  $CFAE,$01 Height = #N(#PEEK(#PC)) pixels.
  $CFAF,$26,$02 #SPRITE$9A(bat-right-02)

b $CFD5 Graphic: Barrel
  $CFD5,$01 Width = #N(#PEEK(#PC)) bytes.
  $CFD6,$01 Height = #N(#PEEK(#PC)) pixels.
  $CFD7,$80,$04 #GRAPHIC$19(barrel)

b $D057 Graphic Attributes: Barrel
  $D057,$01 Width = #N(#PEEK(#PC)) bytes.
  $D058,$01 Height = #N(#PEEK(#PC)) bytes.
  $D059,$10,$04 #GRAPHIC$19,1(barrel-colour)

b $D069 Graphic: A.C.G. Door
  $D069,$01 Width = #N(#PEEK(#PC)) bytes.
  $D06A,$01 Height = #N(#PEEK(#PC)) pixels.
  $D06B,$140,$08 #GRAPHIC$23(acg-door)

b $D1AB Graphic Attributes: A.C.G. Door
  $D1AB,$01 Width = #N(#PEEK(#PC)) bytes.
  $D1AC,$01 Height = #N(#PEEK(#PC)) bytes.
  $D1AD,$28,$08 #GRAPHIC$23,1(acg-door-colour)

b $D1D5 Sprite: A.C.G. Key
E $D1D5 #UDGTABLE(default) { =h Output: } { #SPRITE$8B(acg-01)#SPRITE$8C(acg-02)#SPRITE$8D(acg-03) } UDGTABLE#
N $D1D5 Key left.
  $D1D5,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1D6,$16,$02 #SPRITE$8B(acg-01)

N $D1EC Key middle.
  $D1EC,$01 Height = #N(#PEEK(#PC)) pixels.
  $D1ED,$1E,$02 #SPRITE$8C(acg-02)

N $D20B Key right.
  $D20B,$01 Height = #N(#PEEK(#PC)) pixels.
  $D20C,$26,$02 #SPRITE$8D(acg-03)

b $D232 Sprite: Mushroom
  $D232,$01 Height = #N(#PEEK(#PC)) pixels.
  $D233,$20,$02 #SPRITE$A0(mushroom)

b $D253 Graphic: Pumpkin Picture
  $D253,$01 Width = #N(#PEEK(#PC)) bytes.
  $D254,$01 Height = #N(#PEEK(#PC)) pixels.
  $D255,$40,$04 #GRAPHIC$24(pumpkin-picture)

b $D295 Graphic Attributes: Pumpkin Picture
  $D295,$01 Width = #N(#PEEK(#PC)) bytes.
  $D296,$01 Height = #N(#PEEK(#PC)) bytes.
  $D297,$08,$04 #GRAPHIC$24,1(pumpkin-picture-colour)

b $D29F Sprite: Spanner
  $D29F,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2A0,$20,$02 #SPRITE$8A(spanner)

b $D2C0 Sprite: Ghostlet
N $D2C0 Frame 1.
  $D2C0,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2C1,$16,$02 #SPRITE$4D(ghostlet-01)

N $D2D7 Frame 2.
  $D2D7,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2D8,$16,$02 #SPRITE$4E(ghostlet-02)

b $D2EE Graphic: Skeleton
  $D2EE,$01 Width = #N(#PEEK(#PC)) bytes.
  $D2EF,$01 Height = #N(#PEEK(#PC)) pixels.
  $D2F0,$C8,$05 #GRAPHIC$25(skeleton)

b $D3B8 Graphic Attributes: Skeleton
  $D3B8,$01 Width = #N(#PEEK(#PC)) bytes.
  $D3B9,$01 Height = #N(#PEEK(#PC)) bytes.
  $D3BA,$19,$05 #GRAPHIC$25,1(skeleton-colour)

b $D3D3 Sprite: Hunchback
E $D3D3 #UDGARRAY*hunchback-01,25;hunchback-02;hunchback-03;hunchback-02(hunchback)
N $D3D3 Frame 1.
  $D3D3,$01 Height = #N(#PEEK(#PC)) pixels.
  $D3D4,$30,$02 #SPRITE$9B(hunchback-01*)

N $D404 Frame 2.
  $D404,$01 Height = #N(#PEEK(#PC)) pixels.
  $D405,$30,$02 #SPRITE$9C(hunchback-02*)

N $D435 Frame 3.
  $D435,$01 Height = #N(#PEEK(#PC)) pixels.
  $D436,$30,$02 #SPRITE$9D(hunchback-03*)

b $D466 Graphic: Barrel Stack
  $D466,$01 Width = #N(#PEEK(#PC)) bytes.
  $D467,$01 Height = #N(#PEEK(#PC)) pixels.
  $D468,$87,$05 #GRAPHIC$26(barrel-stack)

b $D4EF Graphic Attributes: Barrel Stack
  $D4EF,$01 Width = #N(#PEEK(#PC)) bytes.
  $D4F0,$01 Height = #N(#PEEK(#PC)) bytes.
  $D4F1,$14,$05 #GRAPHIC$26,1(barrel-stack-colour)

b $D505

b $EA90 Player
@ $EA90 label=Player

b $EA91 Player Room
@ $EA91 label=PlayerRoom

b $EA98 Player Weapon
@ $EA98 label=PlayerWeapon

b $EAA8

b $EB58 Food Items
@ $EB58 label=FoodItems

b $EE60

b $EEE0
