.global Load2Bytes

Load2Bytes:
	PUSH {R9-R12, R14}
	LDRB R9, [R7];@ HIGHER ORDER BYTE
	LSL R9, #8
	LDRB R10, [R7, #1];@ LOWER ORDER BYTE
	ADD R7, R9, R10
	POP {R9-R12, R15}

.global Store2Bytes

Store2Bytes:
	PUSH {R9-R12, R14}
	LSR R9, R8, #8
	STRB R9, [R7,#0]
	AND R9, R8, #0b0000000011111111
	STRB R9, [R7,#1]
	POP {R9-R12, R15}


.global Load2BytesZstack

Load2BytesZstack:
	PUSH {R2,R10-R12, R14}
	MOV R2, #0
	SUB R5, #1
	LDRB R8, [R9, R5];@ HIGHER ORDER BYTE
	STRB R2, [R9, R5]
	LSL R8, #8
	SUB R5, #1
	LDRB R10, [R9, R5];@ LOWER ORDER BYTE
	STRB R2, [R9, R5]
	ADD R8, R10
	POP {R2,R10-R12, R15}

.global Store2BytesZstack

Store2BytesZstack:
	PUSH {R10-R12, R14}
	LSR R10, R8, #8
	STRB R10, [R9, R5];@ HIGHER ORDER BYTE
	ADD R5, #1
	AND R10, R8, #0b0000000011111111
	STRB R10, [R9, R5]
	ADD R5, #1
	POP {R10-R12, R15}

