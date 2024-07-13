# 1 "main.asm"
# 1 "<built-in>" 1
# 1 "main.asm" 2
;---------------------------------------------------------------------------
; FILE: Intro.asm
; DESC: Experiment 1 ? Simple Counter
; DATE: 5-18-06
; AUTH: Class
; DEVICE: PICmicro (PIC18F1220)
;---------------------------------------------------------------------------
    list p=18f1220 ; Set processor type
    radix hex ; Sets the default radix for data exp.
    ; Disable Watchdog timer, Low V. Prog, and RA6 as a clock
    config WDT=OFF, LVP=OFF, OSC = INTIO2
# 21 "main.asm"
    org 0x000 ; Set the program origin (start) to absolute 0x000
; Initialize all I/O ports
    CLRF 0xF80 ; Initialize 0xF80
    CLRF 0xF81 ; Initialize 0xF81
    MOVLW 0x7F ; Set all A/D Converter Pins as
    MOVWF 0xFC1 ; digital I/O pins
    MOVLW 0x00 ; Value used to initialize data direction
    MOVWF 0xF93 ; Set Port B RB<7:0> as outputs
    MOVLW 0x01 ; Value used to initialize data direction
    MOVWF 0xF92 ; Set Port A Pin 0 RA<0> as input
    MOVLW 0x00 ; W = 0
    MOVWF 0x080 ; 0x080 = WREG
    MOVWF 0x081 ; 0x081 = WREG
Loop:
    MOVFF 0xF80, 0x082 ; 0x082 = 0xF80
    MOVF 0x082, 0 ; W = 0xF80
    XORWF 0x081, 0 ; W = W XOR 0x081
    ANDLW 0x1 ; W = W AND 0x1
    MOVFF 0x082, 0x081 ; 0x081 = 0xF80
    MOVWF 0x083 ; 0x083 = W
    BTFSC 0x083, 0 ; If 0x083<0> = 0 Then Skip Next Command
    CALL IncL
    GOTO Loop
IncL:
    MOVF 0x080, 0 ; W = 0x080
    ADDLW 1 ; W = W + 1
    MOVWF 0x080 ; 0x080 = W
    MOVWF 0xF81 ; 0xF81 = W
    RETURN
    end ; Indicates the end of the program.
