;******************** (C) Andrew Wolfe *******************************************
; @file    main_hw_proto.s
; @author  Andrew Wolfe
; @date    August 18, 2019
; @note
;           This code is for the book "Embedded Systems with ARM Cortex-M 
;           Microcontrollers in Assembly Language and C, Yifeng Zhu, 
;           ISBN-13: 978-0982692639, ISBN-10: 0982692633 as used at Santa Clara University
;*******************************************************************************



	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s   
	
			AREA    main, CODE, READONLY
			EXPORT	__main				
			ENTRY			
				
__main	PROC
		;Lab 4
		
		LDR r4, =store
		MOV r6, #0
		PUSH {r1}
		BL portA 
	
	
loop	CMP r6, #5
		BEQ endless
		BL readStick
		BL decStick
		CMP r0, #0
		BEQ loop
		SUB r5,r4, #1
		LDR r7, [r5]
		CMP r0, r7
		BEQ loop
		STRB r0, [r4]
		ADD r4, #1
		ADD r6, #1
		B loop
		
		
endless	B endless

		ENDP
		
		
portA	PROC
		LDR r0,=RCC_BASE;
		LDR r1,[r0,#RCC_AHB2ENR]
		ORR r1,r1,#RCC_AHB2ENR_GPIOAEN
		STR r1,[r0,#RCC_AHB2ENR]
		
		LDR r0,=GPIOA_BASE
		LDR r1,[r0,#GPIO_MODER]
		BIC r1, #(3 << (2 *5))
		BIC r1, #0xFF
		STR r1,[r0,#GPIO_MODER]
		
		LDR r0,=GPIOA_BASE
		LDR r1,[r0,#GPIO_PUPDR]
		LDR r2, =0x8AA
		ORR r1, r2
		STR r1,[r0,#GPIO_PUPDR]
		BX lr
	
		ENDP
		
readStick	PROC
			
			LDR r0, =GPIOA_BASE
			LDRB r1, [r0, #GPIO_IDR]
			AND r0, r1, #0x2F
			BX lr

			ENDP
				
decStick	PROC
			
			PUSH {lr}
			TEQ r0, #0
			LDREQ r2, =0x0
			TEQ r0, #1
			LDREQ r2, =0x63
			TEQ r0, #2
			LDREQ r2, =0x6C
			TEQ r0, #4
			LDREQ r2, =0x72
			TEQ r0, #8
			LDREQ r2, =0x75
			TEQ r0, #0x20
			LDREQ r2, =0x64
			MOV r0, r2
			POP {lr}
			BX lr
	
			ENDP

		ALIGN						
		AREA    myData, DATA, READWRITE
		ALIGN			
	
store	dcb	0,0,0,0,0


		END
