PROCESSOR 16F887
#include <xc.inc>

;CONFIG1
CONFIG FOSC = INTRC_NOCLKOUT
CONFIG WDTE = OFF
CONFIG PWRTE= ON
CONFIG MCLRE= OFF
CONFIG CP   = OFF
CONFIG CPD  = OFF
CONFIG BOREN= OFF
CONFIG IESO = OFF
CONFIG FCMEN= ON
CONFIG LVP  = OFF
CONFIG DEBUG= ON

;CONFIG2
CONFIG BOR4V= BOR40V
CONFIG WRT  = OFF

PSECT udata  
 
Max:
    DS 1
Mid:
    DS 1
Min:
    DS 1
    
PSECT resetVec,class=CODE,delta=2

resetVec:
    PAGESEL main
    goto main
    
PSECT code
 
main:
    BANKSEL OSCCON
    movlw 0b01100000
    movwf OSCCON
    BANKSEL ANSEL
    clrf ANSEL
    BANKSEL TRISA
    movlw 0b00000000
    movwf TRISA
    BANKSEL PORTA
    clrf PORTA
    bcf STATUS,5
    bsf STATUS,6
    bcf STATUS,0

inicio:
    bcf STATUS,0
    bcf STATUS,5
    bcf STATUS,6
    movlw 0b00000001
    movwf PORTA
    goto bit_izq
bit_izq:
    rlf PORTA
    btfss PORTA,7
    goto bit_izq
    goto bit_right
bit_right:
    rrf PORTA
    btfss PORTA,0
    goto bit_right
    goto inicio 
    END