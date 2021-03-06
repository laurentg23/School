.global branchCall

branchCall:
    LDR R7, =Zmemory
    LDRB R7, [R7,R4]
    ADD R4, #1
    LSR R9, R7, #7
    CMP R9, #0b00000001
    BNE flipConditions
    BEQ branchLength2

branchLength2:
    LSR R9, R7, #6
    AND R9, #0b1
    CMP R9, #0b1
    BEQ shortBranch
    B longBranch

shortBranch:
    AND R9, R7, #0b00111111
    CMP R9, #0
    BEQ returnZero
     CMP R9, #1
    BEQ returnOne
    B Zbranch

returnZero:
    MOV R12, #0
    B DonePrevInstr

returnOne:
    MOV R12, #1
    B DonePrevInstr


longBranch:
	PUSH {R7}
	LDR R7, = Zmemory
    LDRB R10, [R7,R4];@ load second offset byte
    POP {R7}
    ADD R4, #1
    AND R9, R7, #0b00111111
    LSL R9, #8
    BL signExtension
    ;@AND R11, R9, #0b00100000
    ;@CMP R11, #0b00100000
    ;@ADDEQ R9, #0b11000000
    ;@LSL R9, #8
    ;@ADD R9, R10
    B Zbranch

signExtension:
;@ what is this used for
    PUSH {R8, R10, R14}
    /*LSR R10, R9, #13
    AND R10, R10, #0b1
    LSL R8, R10, #14
    ADD R9, R8
    LSL R8, R10, #15
    ADD R9, R8
    SXTH R9, R9*/
    AND R11, R9, #0b0010000000000000
    CMP R11, #0b0010000000000000
    ADDEQ R9, #0b1100000000000000

    ADD R9, R10
    POP {R8, R10, R15}

Zbranch:
    ADD R4, R4, R9
    SUB R4, #2
    B DonePrevInstr


flipConditions:
	;@ how does this work
    LSR R9, R8, #6
    CMP R9, #0b00000001
    BNE shortBranch
    B longBranch
    ;@ Figure out what to do here
