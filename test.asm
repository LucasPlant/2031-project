ORG 0

Start:
IN Switches
Store Pattern

Check:
Load Bit0
sub pattern
jzero Switch1

Loadi 0
Load Bit1
sub pattern
jzero Switch2

Loadi 0
Load Bit8
sub pattern
jzero Switch8

Loadi 0
Load Bit9
sub pattern
jzero Switch9

Jump Start

Switch1:
Loadi 0
Out HSPG
Jump Start

Switch2:
Loadi 180
Out HSPG
Jump Start

Switch8:
Loadi 220
Out HSPG
Jump Start

Switch9:
Loadi 85
Out HSPG
Jump Start


Pattern: DW 0
Bit0:      DW &B0000000001
Bit1:    DW &B0000000010
Bit8:      DW &B0100000000
Bit9:      DW &B1000000000
   
; IO address constants
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005
HSPG:      EQU &H50