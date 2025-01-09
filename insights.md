# Structure

Rooms, items, and everything else is referenced by an index.

The room index is stored in the R variable and the item index in the B
variable.

To ease the check for <location,item>, the pair is stored in the HB
variable built by concatenating the two numbers.

For example R=71 and B=3 is stored as HB=713. There is ambiguity
because <7,13> and <71,3> would be represented by the same HB, however
the original program seem to avoid these situations.

A better approach would have been HB=R*100+B because there are less
than 100 items in total.

## Tunnels

The directions to exit the maze of tunnels are stored in the G$()
array: G$(1) when the direction is E, G$(2) when the direction is W.

## Rooms by index

1. grave "in a half-dug grave"
2. goblin-graveyard "in the goblin graveyard"
3. hollow-tomb "in a hollow tomb"
4. stalactites "near some stalactites and stalagmites"
5. tunnels "in a maze of tunnels"
6. vaulted-cavern "in a vaulted cavern"
7. glass-gates "near some high glass gates"
8. palace-entrance "in the entrance hall to the palace"
9. sentry-post "by a grarg sentry post"
10. guard-room "in the guard room"
11. marshy-inlet "by a marshy inlet"
12. rusty-gates "near some rusty gates"
13. gamekeepers-cottage "in the gamekeepers cottage"
14. misty-pool "by a misty pool"
15. high-walled-garden "in a high-walled garden"
16. inscribed-cavern "in an inscribed cavern"
17. ornate-fountain "by an ornate fountain"
18. dank-corridor "in a dank corridor"
19. long-gallery "in the long gallery"
20. palace-kitchens "in the kitchens of the palace"
21. old-kiln "by an old kiln"
22. overgrown-track "on an overgrown track"
23. disused-waterwheel "by a disused waterwheel"
24. sluice-gates "by some sluice gates"
25. between-boulders "in a gap between some boulders"
26. perilous-path "on a perilous path"
27. silver-bell "by a silver bell in the rock"
28. palace-dungeons "in the dungeons of the palace"
29. banqueting-hall "in a banqueting hall"
30. palace-battlements "on the palace battlements"
31. island-shore "on an island shore"
32. beached-ketch "by a beached ketch"
33. barren-countryside "in some barren countryside"
34. upper-windmill "by some sack on the upper floor"
35. frozen-pond "on a small frozen pond"
36. mountain-hut "near a mountain hut"
37. row-of-casks "by a row of casks"
38. wine-cellar "in a wine cellar"
39. hall-of-tapestries "in the hall of tapestries"
40. dusty-library "in a dusty library"
41. rough-water "in some rough water"
42. ploughed-field "in a ploughed field"
43. outside-windmill "outside a windmill"
44. lower-windmill "on the lower floor of the mill"
45. icy-path "on an icy path"
46. scree-slope "on a scree slope"
47. silver-chamber "in the silver chamber"
48. wizards-lair "in the wizard's lair"
49. mosaic-hall "in a mosaic-floored hall"
50. silver-throne "in the silver throne room"
51. lake-middle "in the middle of the lake"
52. lake-edge "on the edge of an icy lake"
53. pitted-track "on a pitted track"
54. high-pinnacle "on a high pinnacle"
55. above-glacier "above a glacier"
56. fallen-oak "near a huge fallen oak"
57. turret-room "in a turret room with a slot machine"
58. cobwebby-room "in a cobwebby room"
59. ogbans-chamber "by a safe in ogban's chamber"
60. attic-cupboard "by a cupboard in a corner"
61. narrow-passage "in a narrow passage"
62. small-cave "in a small cave"
63. woodmans-hut "in a woodman's hut"
64. valley "on the side of a wooded valley"
65. valley-stream "near a stream in a valley bottom"
66. dark-wood "in a deep dark wood"
67. shady-hollow "in a shady hollow"
68. stone-circle "by an ancient stone circle"
69. small-stable "in a small stable"
70. attic-bedroom "in an attic bedroom"
71. well-bottom "in a damp well bottom"
72. deep-well "by the top of a deep well"
73. campfire "by a burnt-out campfire"
74. small-orchard "in a small orchard"
75. west-bridge "at the end of a bridge"
76. east-bridge "at the end of a bridge"
77. crossroads "at a crossroads"
78. winding-road "on a winding road"
79. rustic-village "in a village of rustic houses"
80. white-cottage "in a white cottage"

## Items by index

These are the "dynamic" items that the player can get into its
inventory.

The location of each item is stored in the C() array. The item is
hidden when the F(index) == 1.

There are two special locations:

 * the location of the player's pocket with index 0
 * no location with index 81

The index of each item is listed below:

1. coins "coins" "some" white-cottage
2. sheet "sheet" "a" attic-bedroom
3. boots "boots" "some" attic-cupboard
4. horseshoe "horseshoe" "a" small-stable
5. apples "apples" "some" small-orchard
6. bucket "bucket" "a" deep-well
7. axe "axe" "an" woodmans-hut
8. boat "boat" "a" lake-edge
9. phial "phial" "a" palace-kitchens
10. reeds "reeds" "some" marshy-inlet
11. bone "bone" "a" grave
12. shield "shield" "a" misty-pool
13. planks "planks" "some" mountain-hut
14. rope "rope" "a" high-pinnacle
15. ring "ring" "a" narrow-passage
16. jug "jug" "a" old-kiln
17. net "net" "a" beached-ketch
18. sword "sword" "a" guard-room
19. silver-plate "silver plate" "a" silver-throne
20. uniform "uniform" "a" banqueting-hall
21. key "key" "a" ogbans-chamber
22. seeds "seeds" "some" upper-windmill
23. lamp "lamp" "a" gamekeepers-cottage
24. bread "bread" "some" white-cottage
25. brooch "brooch" "a" palace-battlements
26. matches "matches" "some" nil
27. stone-of-destiny "stone of destiny" "the" silver-chamber
28. apple "apple" "an" small-orchard

## Static Items by index

These are static items, used only for item lookup by the parser: this
way the code can refer them by number instead of comparing strings.

The index for each static item is listed below:

29. bed "bed"
30. cupboard "cupboard"
31. bridge "bridge"
32. trees "trees"
33. sail "sail"
34. kiln "kiln"
35. ketch "ketch"
36. bricks "bricks"
37. windmill "windmill"
38. sacks "sacks"
39. boar "ogbans boar"
40. wheel "wheel"
41. pony "pony"
42. gravestones "gravestones"
43. pool "pool"
44. gates "gates"
45. handle "handle"
46. hut "hut"
47. vine "vine"
48. inscriptions "inscriptions"
49. troll "troll"
50. rubble "rubble"
51. hound "hound"
52. fountain "fountain"
53. circle "circle"
54. mosaics "mosaics"
55. books "books"
56. casks "casks"
57. well "well"
58. walls "walls"
59. rats "rats"
60. safe "safe"
61. cobwebs "cobwebs"
62. coin "coin"
63. bell "bell"
64. up-silver-plate "up silver plate"
65. stones "stones"
66. kitchens "kitchens"
67. goblet "goblet"
68. wine "wine"
69. grargs "grargs"
70. door "door"
71. awake "awake"
72. guide "guide"
73. protect "protect"
74. lead "lead"
75. help "help"
76. chest "chest"
77. water "water"
78. stables "stables"
79. sluice-gates "sluice gates"
80. pot "pot"
81. statue "statue"
82. pinnacle "pinnacle"
83. music "music"
84. magic-words "magic words"
85. misty-pool "misty pool"
86. well-boom "well bottom"
87. old-kiln "old kiln"
88. mountain-hut "mountain hut"

## Array of variables

The game's variables are stored in the F() array.

Each variable is an integer number.

Indices from 1..28 are used to store if the item is hidden (1) or
visible (0 default).

The other indices represent the other variables of the game.

29. wearing-boots (invisibility)
30. using-sheet (for boot or...?)
31. boat-saved
32. boar-caught
33. pool-empty
34. jug-filled
35. ghost-free
36. `an item by adding a S`
37. seeds-planted
38. vine-grown
39. boots-time (if > 5 the boots are worn out)
40. sheet-tied
41. safe-code (between [100..999] initialized at the start)
42. rings-needed (between [2..4] initialized at the start)
43. door-burned
44. money (initialized to 4 at the start)
45. rubble-moved (to pass pile rubble)
46. hound-distracted to hound
47. wine-poisoned
48. grarg-sleeping
49. `inside inventory subroutine`
50. lamp-lit
51. wearing-uniform
52. third-word (between [0..2] decides the third word and location)
53. rope-tied
54. throne-open
55. grarg-patrol (approaching)
56. quest-failed (U R DEAD)
57. initially set to 58 cobwebby-room (ignore)
58. initially set to 54 high-pinnacle (ignore)
59. initially set to 15 high-walled-garden (ignore)
60. mountain-awoken
61. towers-fallen
62. quest-won
63. wizard-dead
64. troll-paid
65. rats-fed (given bread or apples)
66. webs-cleared (swinging the sword)
67. water-time (if == 10 the boats sunks) (set in the game loop)
68. ogban-dead
69. `current room` i.e. R, set before saving
70. door-unlocked (in wizards-lair)

## Verb Handlers by line number

There are 57 recognized verbs (58 if we also count PLAy which is
replaced with BLOw).

Many verbs require that the item is in the pocket but other verbs
 allow any items (like GET).

Also some verbs are marked as usable under the wizard's glare.

Each verb has its own handler at a specific line number listed below:

	800: N
	800: E
	800: S
	800: W
	800: U
	800: D
	1220: INV
	1290: GET       (N)
	1290: TAKe      (N)
	1470: EXAmine
	1470: REAd
	1750: GIVe
	1890: SAY
	1960: PICk      (N)
	1980: WEAr
	2010: TIE
	2050: CLImb     (N)
	2870: RIG
	2120: USE       (W)
	2220: OPEn
	2310: LIGht
	2380: FILl
	2430: PLAnt
	2450: WATer
	2470: SWIng
	2520: EMPty
	2550: ENTer
	2580: CROss
	2610: REMove
	2650: FEEd
	2670: TURn
	2700: DIVe
	2720: BAIl
	2730: LEAve
	2830: THRrow
	2800: INSert
	2870: BLOw
	2730: DROp
	2920: EAT
	2950: MOVe
	2990: INToxicate
	3010: RINg
	3050: CUT
	3070: HOLd      (NW)
	2310: BURn
	2990: POIson
	3070: SHOw      (W)
	3130: UNLock
	2120: WITh      (W)
	3190: DRInk
	1470: COUnt
	3100: PAY
	2870: MAKe
	3150: BREak
	1290: STEal     (N)
	1290: GATther   (N)
	3170: REFlect   (NW)
