ORG 0

LOOP:
IN 	Switches
OUT HSPG
OUT Hex0
JUMP LOOP
   
; IO address constants
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005
HSPG:      EQU &H50