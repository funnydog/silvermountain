5 DEFINT A-Z:CLEAR 2000:WIDTH 40:KEY OFF
10 LET EL=39:LET NO=88:LET NV=57:LET G=28
20 GOSUB 3380
30 GOSUB 4400
40 LET LL=1
50 GOSUB 3310
60 LET P$=X$(VAL(LEFT$(D$,1)))+" "+Y$(VAL(MID$(D$,2,1)))+" "
70 LET J$=R$+". "+"YOU ARE "+P$+RIGHT$(D$,LEN(D$)-2)+" ":GOSUB 4830
80 GOSUB 3330:LET J$=""
90 FOR I=1 TO G-1
100 READ O$
110 LET P$=Y$(VAL(LEFT$(O$,1))):GOSUB 3350
120 IF F(I)=0 AND C(I)=R THEN LET J$=J$+" "+P$+" "+O$+","
130 NEXT I
140 IF R=29 AND F(48)=0 THEN LET J$=J$+" GRARGS FEASTING,"
150 IF R=29 AND F(48)=1 THEN LET J$=J$+" A SLEEPING GRARG,"
160 IF R=12 OR R=22 THEN LET J$=J$+" A PONY,"
170 IF R=64 THEN LET J$=J$+" A HERMIT,"
180 IF R=18 AND E$(18)="N" THEN LET J$=J$+" AN OAK DOOR,"
190 IF R=59 AND F(68)=1 THEN LET J$=J$+ " OGBAN (DEAD),"
200 IF J$<>"" THEN LET J$=", YOU CAN SEE"+J$
210 IF LEN(E$(R))>0 THEN LET J$=J$+" AND YOU CAN GO "
220 FOR I=1 TO LEN(E$(R)):LET J$=J$+MID$(E$(R),I,1)+",":NEXT I
230 GOSUB 4830
240 PRINT:PRINT
250 LET R$="PARDON?":PRINT "======================================="
260 PRINT:PRINT:PRINT "WHAT WILL YOU DO NOW "
270 INPUT I$:GOSUB 4900
280 IF I$="SAVE GAME" THEN GOSUB 4630:GOTO 30
290 LET V$="":LET T$="":LET VB=0:LET B=0
300 FOR I=1 TO LEN(I$)
310 IF MID$(I$,I,1)=" " AND V$="" THEN LET V$=LEFT$(I$,I-1)
320 IF MID$(I$,I+1,1)<>" " AND V$<>"" THEN LET T$=MID$(I$,I+1,LEN(I$)-1):LET I=LEN(I$)
330 NEXT I:IF T$="" THEN LET V$=I$
340 IF LEN(V$)<3 THEN LET V$=V$+"O":GOTO 340
350 IF V$="PLAY" THEN LET V$="BLO"
360 LET U$=LEFT$(V$,3)
370 FOR I=1 TO NV:IF MID$(B$,I*3-2,3)=U$ THEN LET VB=I:LET I=NV
380 NEXT I:LET F(36)=0
390 GOSUB 3330
400 FOR I=1 TO NO:READ O$:IF I<=G THEN GOSUB 3350
410 IF T$=O$ THEN LET B=I:LET I=NO
420 NEXT I
430 IF B=0 AND F(36)=0 AND T$>"" THEN LET T$=T$+"S":LET F(36)=1:GOTO 390
440 IF VB=0 THEN LET VB=NV+1
450 IF T$="" THEN LET R$="I NEED TWO WORDS"
460 IF VB>NV THEN LET R$="TRY SOMETHING ELSE"
470 IF VB>NV AND B=0 THEN LET R$="YOU CANNOT "+I$
480 IF B>G OR B=0 THEN GOTO 510
490 IF VB=8 OR VB=9 OR VB=14 OR VB=17 OR VB=44 OR VB>54 THEN GOTO 510
500 IF VB<NV AND C(B)<>0 THEN LET R$="YOU DO NOT HAVE THE "+T$:GOTO 30
510 IF R=56 AND F(35)=0 AND VB<>37 AND VB<>53 THEN LET R$=X1$+" HAS GOT YOU!":GOTO 30
520 IF VB=44 OR VB=47 OR VB=19 OR VB=57 OR VB=49 THEN GOTO 540
530 IF R=48 AND F(63)=0 THEN LET R$=X9$:GOTO 30
540 LET H=VAL(STR$(R)+STR$(B))
550 ON INT((VB-1)/13)+1 GOTO 560,580,600,620,640
560 ON VB GOSUB 800,800,800,800,800,800,1220,1290,1290,1470,1470,1750,1890
570 GOTO 650
580 ON VB-13 GOSUB 1960,1980,2010,2050,2870,2120,2220,2310,2380,2420,2450,2470,2520
590 GOTO 650
600 ON VB-26 GOSUB 2550,2580,2610,2650,2670,2700,2720,2730,2830,2800,2870,2730,2920
610 GOTO 650
620 ON VB-39 GOSUB 2950,2990,3010,3050,3070,2310,2990,3070,3130,2120,3190,1470,3100
630 GOTO 650
640 ON VB-52 GOSUB 2870,3150,1290,1290,3170,3200
650 IF F(62)=1 THEN GOTO 730
660 IF R=41 THEN LET F(67)=F(67)+1:IF F(67)=10 THEN LET F(56)=1:LET R$="YOU SANK!"
670 IF R=56 AND F(35)=0 AND C(10)<>0 THEN LET R$=X1$+" GETS YOU!":LET F(56)=1
680 IF F(56)=0 THEN GOTO 30
690 GOSUB 4400:PRINT R$
700 PRINT "YOU HAVE FAILED YOUR QUEST!"
710 PRINT:PRINT "BUT YOU ARE GRANTED ANOTHER TRY"
720 GOSUB 3360:RUN
730 GOSUB 4400
740 PRINT "HOOOOORRRRRRAAAAAYYYYYY!"
750 PRINT
760 PRINT "YOU HAVE SUCCEEDED IN YOUR"
770 PRINT "QUEST AND BROUGHT PEACE TO"
780 PRINT "THE LAND"
790 END
800 LET D=VB
810 IF D=5 THEN LET D=1
820 IF D=6 THEN LET D=3
830 IF NOT ((R=75 AND D=2) OR (R=76 AND D=4)) OR F(64)=1 THEN GOTO 850
840 LET R$="B USPMM TUPQT ZPV DSPTTJOH":GOSUB 4260:RETURN
850 IF F(64)=1 THEN LET F(64)=0
860 IF F(51)=1 OR F(29)=1 THEN GOTO 900
870 IF F(55)=1 THEN LET F(56)=1:LET R$="GRARGS HAVE GOT YOU!":RETURN
880 IF R=29 AND F(48)=0 THEN LET R$="GRARGS WILL SEE YOU!":RETURN
890 IF R=73 OR R=42 OR R=9 OR R=10 THEN LET R$=X3$:LET F(55)=1:RETURN
900 IF C(8)=0 AND ((R=52 AND D=2) OR (R=31 AND D<>3)) THEN LET R$="THE BOAT IS TOO HEAVY":RETURN
910 IF C(8)<>0 AND ((R=52 AND D=4) OR (R=31 AND D=3)) THEN LET R$="YOU CANNOT SWIM":RETURN
920 IF R=52 AND C(8)=0 AND D=4 AND F(30)=0 THEN LET R$="NO POWER!":RETURN
930 IF R=41 AND D=3 AND F(31)=0 THEN LET R$="UIF CPBU JT TJOLJOH!":GOSUB 4260:RETURN
940 IF R=33 AND D=1 AND F(32)=0 THEN LET R$="OGBAN'S BOAR BLOCKS YOUR PATH":RETURN
950 IF ((R=3 AND D=2) OR (R=4 AND D=4)) AND F(45)=0 THEN LET R$=X5$:RETURN
960 IF R=35 AND C(13)<>R THEN LET R$="THE ICE IS BREAKING!":RETURN
970 IF R=5 AND (D=2 OR D=4) THEN GOSUB 4310
980 IF R=4 AND D=4 THEN LET R$="PASSAGE IS TOO STEEP":RETURN
990 IF R=7 AND D=2 AND F(46)=0 THEN LET R$="A HUGE HOUND BARS YOUR WAY":RETURN
1000 IF (R=38 OR R=37) AND F(50)=0 THEN LET R$="JU JT UPP EBSL":GOSUB 4260:RETURN
1010 IF R=49 AND D=2 AND F(54)=0 THEN LET R$="MYSTERIOUS FORCES HOLD YOU BACK":RETURN
1020 IF R=49 AND D=3 AND F(68)=0 THEN LET R$="YOU MET OGBAN!!!":LET F(56)=1:RETURN
1030 IF R=38 AND F(65)=0 THEN LET R$="RATS NIBBLE YOUR ANKLES":RETURN
1040 IF R=58 AND (D=1 OR D=4) AND F(66)=0 THEN LET R$="YOU GET CAUGHT IN THE WEBS!":RETURN
1050 IF R=48 AND D=4 AND F(70)=0 THEN LET R$="THE DOOR DOES NOT OPEN":RETURN
1060 IF R=40 AND F(47)=1 THEN LET F(68)=1
1070 IF R=37 AND D=4 AND E$(37)="EW" THEN LET R=67:LET R$="THE PASSAGE WAS STEEP!":RETURN
1080 IF R=29 AND D=3 THEN LET F(48)=1:LET F(20)=0
1090 IF R=8 AND D=2 THEN LET F(46)=0
1100 LET OM=R:FOR I=1 TO LEN(E$(R))
1110 LET K$=MID$(E$(OM),I,1)
1120 IF (K$="N" OR K$="U") AND D=1 THEN LET R=R-10
1130 IF K$="E" AND D=2 THEN LET R=R+1
1140 IF (K$="S" OR K$="D") AND D=3 THEN LET R=R+10
1150 IF K$="W" AND D=4 THEN LET R=R-1
1160 NEXT I:LET R$="OK"
1170 IF R=OM THEN LET R$="YOU CANNOT GO THAT WAY"
1180 IF ((OM=75 AND D=2) OR (OM=76 AND D=4)) THEN LET R$="OK, YOU CROSSED"
1190 IF F(29)=1 THEN LET F(39)=F(39)+1
1200 IF (F39)>5 AND F(29)=1 THEN LET R$="CPPUT IBWF XPSO PVU":GOSUB 4260:LET F(29)=0:LET C(3)=81
1210 RETURN
1220 GOSUB 3330:LET R$="OK":LET F(49)=0
1230 PRINT "YOU HAVE ";
1240 FOR I=1 TO G:READ O$:GOSUB 3350:IF I=1 AND C(1)=0 AND F(44)=1 THEN LET O$="COIN"
1250 IF I=G AND C(5)=0 THEN GOTO 1270
1260 IF C(I)=0 THEN PRINT O$;",";:LET F(49)=1
1270 NEXT I:IF F(49)=0 THEN PRINT "NOTHING"
1280 PRINT:GOSUB 3360:RETURN
1290 IF H=6577 THEN LET R$="HOW?":RETURN
1300 IF H=4177 OR H=5177 THEN LET B=16:GOSUB 2380:RETURN
1310 IF B=38 THEN LET R$="TOO HEAVY!":RETURN
1320 IF B=4 AND F(43)=0 THEN LET R$="IT IS FIRMLY NAILED ON!":RETURN
1330 LET CO=0:FOR I=1 TO G-1:IF C(I)=0 THEN LET CO=CO+1
1340 NEXT I:IF CO>13 THEN LET R$="YOU CANNOT CARRY ANY MORE":RETURN
1350 IF B>G THEN LET R$="YOU CANNOT GET THE "+T$:RETURN
1360 IF B=0 THEN RETURN
1370 IF C(B)<>R THEN LET R$="IT IS NOT HERE!"
1380 IF F(B)=1 THEN LET R$="WHAT "+T$+"?"
1390 IF C(B)=0 THEN LET R$="YOU ALREADY HAVE IT"
1400 IF C(B)=R AND F(B)=0 THEN LET C(B)=0:LET R$="YOU HAVE THE "+T$
1410 IF B=28 THEN LET C(5)=81
1420 IF B=5 THEN LET C(28)=0
1430 IF C(4)=0 AND C(12)=0 AND C(15)=0 THEN LET F(54)=1
1440 IF B=8 AND F(30)=1 THEN LET C(2)=0
1450 IF B=2 THEN LET F(30)=0
1460 RETURN
1470 LET R$="YOU SEE WHAT YOU MIGHT EXPECT!"
1480 IF B>0 THEN LET R$="NOTHING SPECIAL"
1490 IF B=49 OR B=88 THEN GOSUB 2550
1500 IF H=8076 THEN LET R$="IT IS EMPTY"
1510 IF H=8080 THEN LET R$="AHA!":LET F(1)=0
1520 IF H=7029 THEN LET R$="OK":LET F(2)=0
1530 IF B=20 THEN LET R$="NBUDIFT JO QPDLFU":GOSUB 4260:LET C(26)=0
1540 IF H=1648 THEN LET R$="THERE ARE SOME LETTERS '"+G$(2)+"'"
1550 IF H=7432 THEN LET R$="UIFZ BSF BQQMF USFFT":GOSUB 4260:LET F(5)=0
1560 IF H=2134 OR H=2187 THEN LET R$="OK": LET F(16)=0
1570 IF B=35 THEN LET R$="IT IS FISHY!":LET F(17)=0
1580 IF H=3438 THEN LET R$="OK":LET F(22)=0
1590 IF H=242 THEN LET R$="A FADED INSCRIPTION"
1600 IF (H=1443 OR H=1485) AND F(33)=0 THEN LET R$="B HMJNNFSJOH GPSN UIF EFQUIT":GOSUB 4260
1610 IF (H=1443 OR H=1485) AND F(33)=1 THEN LET R$="SOMETHING HERE...":LET F(12)=0
1620 IF H=2479 OR H=2444 THEN LET R$="THERE IS A HANDLE"
1630 IF B=9 THEN LET R$="UIF MBCFM SFBET 'QPJTPO'":GOSUB 4260
1640 IF H=4055 THEN GOSUB 3290
1650 IF H=2969 AND F(48)=1 THEN LET R$="VERY UGLY!"
1660 IF H=7158 OR H=7186 THEN LET R$="THERE ARE LOOSE BRICKS"
1670 IF R=49 THEN LET R$="VERY INTERESTING!"
1680 IF B=52 OR B=82 OR B=81 THEN LET R$="INTERESTING!"
1690 IF H=6978 THEN LET R$="THERE IS A WOODEN DOOR"
1700 IF H=6970 THEN LET R$="YOU FOUND SOMETHING":LET F(4)=0
1710 IF H=2066 THEN LET R$="A LARGE CUPBOARD IN THE CORNER"
1720 IF H=6865 OR H=6853 THEN LET R$="THERE ARE NINE STONES"
1730 IF H=248 THEN LET R$="B GBEFE XPSE - 'N S I T'":GOSUB 4260
1740 RETURN
1750 IF R=64 THEN LET R$="HE GIVES IT BACK!"
1760 IF H=6425 THEN GOSUB 3210
1770 IF R=75 OR R=76 THEN LET R$="HE DOES NOT WANT IT"
1780 IF B=62 AND F(44)=0 THEN LET R$="YOU HAVE RUN OUT!"
1790 IF (H=7562 OR H=7662) AND F(44)>0 AND C(1)=0 THEN LET R$="HE TAKES IT":LET F(64)=1
1800 IF F(64)=1 THEN LET F(44)=F(44)-1:IF F(44)=0 THEN LET C(1)=81
1810 IF B=1 THEN LET R$="HE TAKES THEM ALL!":LET C(1)=81:LET F(64)=1:LET F(44)=0
1820 IF H=2228 AND C(5)=81 THEN LET R$=XB$+"NORTH":LET C(28)=81:LET R=12
1830 IF (H=2228 AND C(5)=0) OR H=225 THEN LET R$=XB$+"NORTH":LET R=12
1840 IF (H=1228 AND C(5)=0) OR H=125 THEN LET R$=XB$+"SOUTH":LET R=22
1850 IF R=7 OR R=33 THEN LET R$="HE EATS IT!":LET C(B)=81
1860 IF H=711 THEN LET F(46)=1:LET R$="HE IS DISTRACTED"
1870 IF H=385 OR H=3824 THEN LET R$="THEY SCURRY AWAY":LET C(B)=81:LET F(65)=1
1880 RETURN
1890 LET R$="YOU SAID IT"
1900 IF B=84 THEN LET R$="YOU MUST SAY THEM ONE BY ONE!":RETURN
1910 IF R<>47 OR B<71 OR B>75 OR C(27)<>0 THEN RETURN
1920 IF B=71 AND F(60)=0 THEN LET R$=X7$:LET F(60)=1:RETURN
1930 IF B=72 AND F(60)=1 AND F(61)=0 THEN LET R$=X8$:LET F(61)=1:RETURN
1940 IF B=(F(52)+73) AND F(60)=1 AND F(61)=1 THEN LET F(62)=1:RETURN
1950 LET R$="THE WRONG SACRED WORD!":LET F(56)=1:RETURN
1960 IF B=5 OR B=10 THEN GOSUB 1290
1970 RETURN
1980 IF B=3 THEN LET F(29)=1:LET R$="ZPV BSF JOWJTJCMF":LET F(55)=0:GOSUB 4260
1990 IF B=20 THEN LET F(51)=1:LET R$="ZPV BSF EJTHVJTFE":LET F(55)=0:GOSUB 4260
2000 RETURN
2010 IF B=2 OR B=14 THEN LET R$="NOTHING TO TIE IT TO!"
2020 IF H=7214 THEN LET R$="IT IS TIED":LET C(14)=72:LET F(53)=1
2030 IF H=722 THEN LET R$="OK":LET F(40)=1:LET C(2)=72
2040 RETURN
2050 IF H=1547 AND F(38)=1 THEN LET R$="ALL RIGHT":LET R=16
2060 IF B=14 OR B=2 THEN LET R$="NOT ATTACHED TO ANYTHING!"
2070 IF H=5414 AND C(14)=54 THEN LET R$="YOU ARE AT THE TOP"
2080 IF H=7214 AND F(53)=1 THEN LET R$="GOING DOWN": LET R=71
2090 IF H=722 AND F(40)=1 THEN LET R=71:LET R$="IT IS TORN":LET C(2)=81:LET F(40)=0
2100 IF H=7114 AND F(53)=1 THEN LET C(14)=71:LET F(53)=0: LET R$="IT FALLS DOWN-BUMP!"
2110 RETURN
2120 IF H=522 THEN LET R$="OK":LET F(30)=1
2130 IF B=1 OR B=62 OR B=5 OR B=28 OR B=11 OR B=24 THEN GOSUB 1750
2140 IF H=416 THEN LET R$="ZPV IBWF LFQU BGMPBU":LET F(31)=1:GOSUB 4260:RETURN
2150 IF H=4116 THEN LET R$="IT IS NOT BIG ENOUGH!":RETURN
2160 IF B=18 OR B=7 THEN GOSUB 2470
2170 IF B=13 THEN GOSUB 2730
2180 IF B=19 THEN GOSUB 3070
2190 IF B=10 THEN GOSUB 2870
2200 IF B=16 OR B=6 THEN GOSUB 2380
2210 RETURN
2220 IF B=76 OR B=38 THEN GOSUB 1470
2230 IF H=2030 THEN LET F(9)=0:LET R$="OK"
2240 IF H=6030 THEN LET F(3)=0:LET R$="OK"
2250 IF H=2444 OR H=1870 THEN LET R$="YOU ARE NOT STRONG ENOUGH"
2260 IF H=3756 THEN LET R$="A PASSAGE!":LET E$(37)="EW"
2270 IF H=5960 THEN GOSUB 3260
2280 IF H=6970 THEN LET R$="IT FALLS OFF ITS HINGES"
2290 IF H=4870 THEN LET R$="IT IS LOCKED"
2300 RETURN
2310 IF B>G THEN LET R$="IT DOES NOT BURN"
2320 IF B=26 THEN LET R$="YOU LIT THEM"
2330 IF H=3826 THEN LET R$="NOT BRIGHT ENOUGH"
2340 IF (B=23 OR H=6970) AND C(26)<>0 THEN LET R$="OP NBUDIFT":GOSUB 4260
2350 IF B=23 AND C(26)=0 THEN LET R$="A BRIGHT "+V$:LET F(50)=1
2360 IF H=6970 AND C(26)=0 THEN LET F(43)=1:LET R$="IT HAS TURNED TO ASHES"
2370 RETURN
2380 IF (B=16 OR B=6) AND (R=41 OR R=51) THEN LET R$="YOU CAPSIZED!":LET F(56)=1
2390 IF H=6516 AND C(16)=0 THEN LET R$="IT IS NOW FULL":LET F(34)=1
2400 IF H=656 THEN LET R$="IT LEAKS OUT!"
2410 RETURN
2420 IF B<>22 OR R<>15 THEN LET R$="DOES NOT GROW!":RETURN
2430 LET R$="OK":LET F(37)=1
2440 RETURN
2450 IF B=22 AND F(37)=1 AND F(34)=1 THEN LET R$=X2$:LET F(38)=1:GOSUB 4260
2460 RETURN
2470 IF B=7 OR B=18 THEN LET R$="THWACK!"
2480 IF H=5818 THEN LET R$="YOU CLEARED THE WEBS":LET F(66)=1
2490 IF H=187 THEN LET R$="THE DOOR BROKE!":LET E$(18)="NS":LET E$(28)="NS"
2500 IF H=717 THEN LET R$="YOU BROKE THROUGH!":LET E$(71)="N"
2510 RETURN
2520 IF B=16 THEN LET B=22:GOSUB 2450
2530 IF H=499 THEN LET R$="WHERE?"
2540 RETURN
2550 IF H=4337 THEN LET VB=2:GOSUB 800:RETURN
2560 IF R=36 THEN LET R$="YOU FOUND SOMETHING":LET F(13)=0
2570 RETURN
2580 IF R=76 THEN LET VB=4:GOSUB 800:RETURN
2590 IF R=75 THEN LET VB=2:GOSUB 800
2600 RETURN
2610 IF (B=3 AND F(29)=1) THEN LET R$="TAKEN OFF": LET F(29)=0
2620 IF (B=20 AND F(51)=1) THEN LET R$="OK": LET F(51)=0
2630 IF B=36 OR B=50 THEN GOSUB 2950
2640 RETURN
2650 IF H=3859 OR H=3339 OR H=1241 OR H=2241 OR H=751 THEN LET R$="WITH WHAT?"
2660 RETURN
2670 IF H=2340 THEN LET R$="IT GOES ROUND"
2680 IF H=2445 THEN LET R$="UIF HBUFT PQFO, UIF QPPM FNQUJFT":LET F(33)=1:GOSUB 4260
2690 RETURN
2700 IF R=14 OR R=51 THEN LET R$="YOU HAVE DROWNED": LET F(56)=1
2710 RETURN
2720 LET R$="HOW?":RETURN
2730 IF B=0 OR B>G THEN RETURN
2740 LET C(B)=R: LET R$="DONE"
2750 IF H=418 OR H=518 THEN LET R$="YOU DROWNED!":LET F(56)=1
2760 IF B=8 AND F(30)=1 THEN LET C(2)=R
2770 IF B=16 AND F(34)=1 THEN LET R$="YOU LOST THE WATER!":LET F(34)=0
2780 IF B=2 AND F(30)=1 THEN LET F(30)=0
2790 RETURN
2800 IF B=62 AND F(44)=0 THEN LET R$="YOU DO NOT HAVE ANY"
2810 IF H=5762 AND C(1)=0 AND F(44)>0 THEN GOSUB 3230
2820 RETURN
2830 IF B=0 OR B>G THEN RETURN
2840 LET R$="DID NOT GO FAR!":LET C(B)=R
2850 IF H=3317 THEN LET R$="ZPV DBVHIU UIF CPBS":LET F(32)=1:GOSUB 4260
2860 RETURN
2870 IF B=10 THEN LET R$="B OJDF UVOF":GOSUB 4260
2880 IF H=5233 THEN LET R$="WHAT WITH?"
2890 IF B=83 THEN LET R$="HOW, O MUSICAL ONE?"
2900 IF H=5610 THEN LET F(35)=1:LET R$=X1$+" IS FREE!":LET E$(56)="NS"
2910 RETURN
2920 IF B=0 OR B>G THEN RETURN
2930 IF B=5 OR B=24 THEN LET R$="YUM YUM!":LET C(B)=81
2940 RETURN
2950 IF R=4 AND B=50 THEN LET F(45)=1:LET R$="YOU REVEALED A STEEP PASSAGE"
2960 IF R=3 AND B=50 THEN LET R$="YOU CANNOT MOVE RUBBLE FROM HERE"
2970 IF H=7136 THEN LET R$="THEY ARE WEDGED IN!"
2980 RETURN
2990 IF (B=67 OR B=68) AND C(9)=0 AND R=49 THEN LET R$="OK":LET F(47)=1
3000 RETURN
3010 IF R<>27 OR B<>63 THEN RETURN
3020 PRINT:PRINT "HOW MANY TIMES?":INPUT MR:IF MR=0 THEN PRINT "A NUMBER":GOTO 3020
3030 IF MR=F(42) THEN LET R$="A ROCK DOOR OPENS":LET E$(27)="EW":RETURN
3040 LET R$="ZPV IBWF NJTUSFBUFE UIF CFMM!":LET F(56)=1:GOSUB 4260:RETURN
3050 IF H=5861 THEN LET H=5818:GOSUB 2470
3060 RETURN
3070 IF (H=4864 OR H=4819) AND C(19)=0 THEN LET R$=X6$:LET F(63)=1:GOSUB 4260
3080 IF B=27 THEN GOSUB 1290
3090 RETURN
3100 IF H=7549 OR H=7649 THEN LET R$="WHAT WITH?"
3110 IF B=1 OR B=62 THEN GOSUB 1750
3120 RETURN
3130 IF H=4870 AND C(21)=0 THEN LET R$="THE KEY TURNS!":LET F(70)=1
3140 RETURN
3150 IF H=1870 THEN LET R$="HOW?"
3160 RETURN
3170 IF R=48 THEN LET R$="HOW?"
3180 RETURN
3190 LET R$="ARE YOU THIRSTY?"
3200 RETURN
3210 LET R$="HE TAKES IT AND SAYS '"+STR$(F(42))+" RINGS ARE NEEDED'":LET C(25)=81
3220 RETURN
3230 LET F(44)=F(44)-1:LET R$="A NUMBER APPEARS - "+STR$(F(41))
3240 IF F(44)=0 THEN LET C(1)=81
3250 RETURN
3260 PRINT:LET R$="XIBU JT UIF DPEF":GOSUB 4260:PRINT R$:INPUT CN
3270 LET R$="WRONG!":IF CN=F(41) THEN LET R$="IT OPENS":LET F(21)=0
3280 RETURN
3290 LET T=R:LET R=F(F(52)+57):GOSUB 3310:LET R=T
3300 LET R$=X4$+RIGHT$(D$,LEN(D$)-2):RETURN
3310 RESTORE 3630:FOR I=1 TO R:READ D$:NEXT I
3320 RETURN
3330 RESTORE 4030:REM FOR I=1 TO 80:READ D$:NEXT I
3340 RETURN
3350 LET O$=RIGHT$(O$,LEN(O$)-1):RETURN
3360 PRINT "PRESS RETURN TO CONTINUE"
3370 INPUT Z$:RETURN
3380 DIM C(G), E$(80), F(70), X$(6), Y$(6), G$(2)
3390 GOSUB 3330
3400 FOR I=1 TO NO:READ T$:NEXT I
3410 FOR I=1 TO 6:READ X$(I),Y$(I):NEXT I
3420 B$="NOOEOOSOOWOOUOODOOINVGETTAKEXAREAGIVSAYPICWEATIECLIRIGUSEOPE"
3430 B$=B$+"LIGFILPLAWATSWIEMPENTCROREMFEETURDIVBAILEATHRINSBLODROEATMOV"
3440 B$=B$+"INTRINCUTHOLBURPOISHOUNLWITDRICOUPAYMAKBRESTEGATREF"
3450 X6$="ZPV SFGMFDUFE UIF XJABSET HMBSF! IF JT EFBE"
3460 X1$="THE GHOST OF THE GOBLIN GUARDIAN"
3470 X2$="B MBSHF WJOF HSPXT JO TFDPOET!"
3480 X3$="A GRARG PATROL APPROACHES"
3490 X4$="MAGIC WORDS LIE AT THE CROSSROADS, THE FOUNTAIN AND THE "
3500 X5$="A PILE OF RUBBLE BLOCKS YOUR PATH"
3510 X7$="THE MOUNTAIN RUMBLES!"
3520 X8$="TOWERS FALL DOWN!"
3530 X9$="THE WIZARD HAS YOU IN HIS GLARE"
3540 XB$="HE LEADS YOU "
3550 GOSUB 4400:PRINT "DO YOU WANT TO"
3560 PRINT:PRINT "   1. START A NEW GAME"
3570 PRINT "OR 2. CONTINUE A SAVED GAME"
3580 PRINT:PRINT:PRINT "TYPE IN EITHER 1 OR 2"
3590 INPUT C:IF C<>1 AND C<>2 THEN GOTO 3580
3600 IF C=1 THEN GOSUB 4450
3610 IF C=2 THEN GOSUB 4600
3620 RETURN
3630 DATA 11HALF-DUG GRAVE,12GOBLIN GRAVEYARD
3640 DATA 11HOLLOW TOMB,23STALACTITES AND STALAGMITES
3650 DATA 11MAZE OF TUNNELS,11VAULTED CAVERN
3660 DATA 23HIGH GLASS GATES,12ENTRANCE HALL TO THE PALACE
3670 DATA 31GRARG SENTRY POST,12GUARD ROOM
3680 DATA 31MARSHY INLET,23RUSTY GATES
3690 DATA 12GAMEKEEPERS COTTAGE,31MISTY POOL
3700 DATA 11HIGH-WALLED GARDEN,14INSCRIBED CAVERN
3710 DATA 34ORNATE FOUNTAIN,11DANK CORRIDOR
3720 DATA 12LONG GALLERY,12KITCHENS OF THE PALACE
3730 DATA 34OLD KILN,44OVERGROWN TRACK
3740 DATA 31DISUSED WATERWHEEL,33SLUICE GATES
3750 DATA 11GAP BETWEEN SOME BOULDERS,41PERILOUS PATH
3760 DATA 31SILVER BELL IN THE ROCK,12DUNGEONS OF THE PALACE
3770 DATA 11BANQUETING HALL,42PALACE BATTLEMENTS
3780 DATA 44ISLAND SHORE,31BEACHED KETCH
3790 DATA 13BARREN COUNTRYSIDE,33SACK ON THE UPPER FLOOR
3800 DATA 46FROZEN POND,21MOUNTAIN HUT
3810 DATA 31ROW OF CASKS,11WINE CELLAR
3820 DATA 12HALL OF TAPESTRIES,11DUSTY LIBRARY
3830 DATA 13ROUGH WATER,11PLOUGHED FIELD
3840 DATA 55OUTSIDE A WINDMILL,42LOWER FLOOR OF THE MILL
3850 DATA 44ICY PATH,41SCREE SLOPE
3860 DATA 12SILVER CHAMBER,12WIZARDS LAIR
3870 DATA 11MOSAIC-FLOORED HALL,12SILVER THRONE ROOM
3880 DATA 12MIDDLE OF THE LAKE,42EDGE OF AN ICY LAKE
3890 DATA 41PITTED TRACK,41HIGH PINNACLE
3900 DATA 55ABOVE A GLACIER,21HUGE FALLEN OAK
3910 DATA 11TURRET ROOM WITH A SLOT MACHINE,11COBWEBBY ROOM
3920 DATA 31SAFE IN OGBANS CHAMBER,31CUPBOARD IN A CORNER
3930 DATA 11NARROW PASSAGE,16CAVE
3940 DATA 11WOODMANS HUT,42SIDE OF A WOODED VALLEY
3950 DATA 21STREAM IN A VALLEY BOTTOM,11DEEP DARK WOOD
3960 DATA 11SHADY HOLLOW,34ANCIENT STONE CIRCLE
3970 DATA 16STABLE,14ATTIC BEDROOM
3980 DATA 11DAMP WELL BOTTOM,32TOP OF A DEEP WELL
3990 DATA 31BURNT-OUT CAMPFIRE,16ORCHARD
4000 DATA 62END OF A BRIDGE,62END OF A BRIDGE
4010 DATA 61CROSSROADS,41WINDING ROAD
4020 DATA 11VILLAGE OF RUSTIC HOUSES,11WHITE COTTAGE
4030 DATA 3COINS,1SHEET,3BOOTS,1HORSESHOE,3APPLES,1BUCKET,4AXE,1BOAT,1PHIAL
4040 DATA 3REEDS,1BONE,1SHIELD,3PLANKS,1ROPE,1RING,1JUG,1NET,1SWORD
4050 DATA 1SILVER PLATE,1UNIFORM,1KEY,3SEEDS,1LAMP,3BREAD,1BROOCH,3MATCHES
4060 DATA 2STONE OF DESTINY,4APPLE,BED,CUPBOARD,BRIDGE,TREES,SAIL,KILN
4070 DATA KETCH,BRICKS,WINDMILL,SACKS,OGBANS BOAR,WHEEL
4080 DATA PONY,GRAVESTONES,POOL,GATES,HANDLE,HUT,VINE,INSCRIPTIONS,TROLL,RUBBLE
4090 DATA HOUND,FOUNTAIN,CIRCLE,MOSAICS,BOOKS,CASKS,WELL,WALLS,RATS,SAFE
4100 DATA COBWEBS,COIN,BELL,UP SILVER PLATE,STONES,KITCHENS,GOBLET,WINE
4110 DATA GRARGS,DOOR,AWAKE,GUIDE,PROTECT,LEAD,HELP,CHEST,WATER
4120 DATA STABLES,SLUICE GATES,POT,STATUE,PINNACLE,MUSIC,MAGIC WORDS
4130 DATA MISTY POOL,WELL BOTTOM,OLD KILN,MOUNTAIN HUT
4140 DATA IN,A,NEAR,THE,BY,SOME,ON,AN,"","",AT,A SMALL
4150 DATA E,ESW,WE,EW,EW,ESW,ESW,ES,EW,SW
4160 DATA S,N,ES,SW,S,NW,N,N,ES,NSW
4170 DATA NS,E,NSW,N,NES,EW,W,S,NS,N
4180 DATA NES,W,NS,D,NES,SW,E,NW,NS,S
4190 DATA NS,E,NSEW,WU,UD,NS,E,SW,NSE,NW
4200 DATA NE,EW,NSW,E,WN,S,E,NEW,NW,S
4210 DATA ES,SW,NES,EW,SW,NE,EW,ESW,SW,ND
4220 DATA "",E,NEW,EW,NEW,EW,EW,NEW,NEW,WU
4230 DATA 80,70,60,69,74,72,63,52,20,11,1,14,36,54,61,21,32,10,50
4240 DATA 29,59,34,13,80,30,81,47,74
4250 DATA 1,2,3,4,5,9,12,13,16,17,20,21,22
4260 LET Z$="":FOR I=1 TO LEN(R$)
4270 LET C$=MID$(R$,I,1) : IF C$<"A" THEN LET Z$=Z$+C$:GOTO 4300
4280 LET C=ASC(C$)-1:IF C=64 THEN LET C=90
4290 LET Z$=Z$+CHR$(C)
4300 NEXT I:LET R$=Z$:RETURN
4310 LET J$="SSSSSSSS":LET NG=0
4320 LET MP=D/2:GOSUB 4400
4330 PRINT "YOU ARE LOST IN THE":PRINT "      TUNNELS"
4340 PRINT "WHICH WAY? (N,S,W OR E)"
4350 IF NG>15 THEN PRINT "(OR G TO GIVE UP!)"
4360 PRINT:INPUT I$:GOSUB 4900:LET J$=RIGHT$(J$+RIGHT$(I$,1),8)
4370 IF I$="G" THEN LET F(56)=1:RETURN
4380 IF J$<>G$(MP) THEN LET NG=NG+1:GOTO 4320
4390 RETURN
4400 CLS:PRINT
4410 PRINT TAB(EL/2-9);"MYSTERY OF SILVER"
4420 PRINT TAB(EL/2-9);"    MOUNTAIN"
4430 PRINT "======================================="
4440 PRINT:PRINT:RETURN
4450 FOR I=1 TO 80:READ E$(I):NEXT I
4460 FOR I=1 TO G:READ C(I):NEXT I
4470 FOR I=1 TO 13:READ A:LET F(A)=1:NEXT I
4480 LET F(41)=INT(RND(1)*900)+100:LET F(42)=INT(RND(1)*3)+2
4490 LET F(44)=4:LET F(57)=68:LET F(58)=54:LET F(59)=15:LET F(52)=INT(RND(1)*3)
4500 LET R=77:LET R$="GOOD LUCK ON YOUR QUEST!"
4510 LET G$(1)="":FOR I=1 TO 8
4520 LET F$=MID$(B$,1+INT(RND(1)*4)*3,1)
4530 LET G$(1)=G$(1)+F$
4540 IF F$="N" THEN LET L$="S"
4550 IF F$="S" THEN LET L$="N"
4560 IF F$="E" THEN LET L$="W"
4570 IF F$="W" THEN LET L$="E"
4580 LET G$(2)=L$+G$(2)
4590 NEXT I:RETURN
4600 GOSUB 4640:GOSUB 4670
4610 LET R=F(69):LET R$="OK. CARRY ON"
4620 RETURN
4630 LET F(69)=R:GOSUB 4640:GOSUB 4760:GOTO 4610
4640 PRINT:PRINT "PLEASE ENTER FILE NAME":INPUT FL$
4650 RETURN
4660 REM READ DATA FILE
4670 REM
4680 PRINT "OK. SEARCHING FOR ";FL$
4690 OPEN FL$ FOR INPUT AS #1:PRINT "OK. LOADING"
4700 FOR I=1 TO 80:INPUT #1,E$(I) : NEXT I
4710 FOR I=1 TO G:INPUT #1,C(I) : NEXT I
4720 FOR I=1 TO 70:INPUT #1,F(I) : NEXT I
4730 INPUT #1,G$(1):INPUT #1,G$(2)
4740 CLOSE #1:RETURN
4750 REM SAVE DATA FILE
4760 REM
4770 OPEN FL$ FOR OUTPUT AS #1:PRINT "OK. SAVING"
4780 FOR I=1 TO 80:PRINT #1,E$(I):NEXT I
4790 FOR I=1 TO G:PRINT #1,C(I):NEXT I
4800 FOR I=1 TO 70:PRINT #1,F(I):NEXT I
4810 PRINT #1,G$(1):PRINT #1,G$(2)
4820 CLOSE #1:RETURN
4830 LET LS=1:LET LP=1
4840 FOR I=1 TO LEN(J$):IF MID$(J$,I,1)<>" " THEN GOTO 4870
4850 IF LL-1>EL THEN PRINT MID$(J$,LP,LS-LP):LET LL=I-LS-1:LET LP=LS+1
4860 LET LS=I
4870 LET LL=LL+1:NEXT I
4880 PRINT MID$(J$,LP,LEN(J$)-LP);
4890 RETURN
4900 IF LEN(I$)=0 THEN GOTO 4970
4910 LET W$=I$:LET I$=""
4920 FOR I=1 TO LEN(W$)
4930 C=ASC(MID$(W$,I,1))
4940 IF 97<=C AND C<=122 THEN C=C-32
4950 LET I$=I$+CHR$(C)
4960 NEXT I
4970 RETURN
