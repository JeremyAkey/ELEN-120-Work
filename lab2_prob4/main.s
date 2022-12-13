;******************** (C) Andrew Wolfe *******************************************
; @file    mainproto.s
; @author  Andrew Wolfe
; @date    August 18, 2019
; @note
;           This code is for the book "Embedded Systems with ARM Cortex-M 
;           Microcontrollers in Assembly Language and C, Yifeng Zhu, 
;           ISBN-13: 978-0982692639, ISBN-10: 0982692633 as used at Santa Clara University
;*******************************************************************************

	
			AREA    main, CODE, READONLY
			EXPORT	__main				
			ENTRY			
				
__main	PROC
	
	
			ldr 	r2,=listsize
			ldr		r3,[r2]
			ldr		r2,=list
			mov		r0,#0
loop 		ldrb 	r1,[r2]
			sxtb	r1,r1
			cmp		r1,#0
			addge	r0,#1
			add 	r2,#1
			subs	r3,#1
			bne		loop

endless		b		endless

			ENDP
			ALIGN
list		dcb			-2, 0, 1, 5, -3, -5, 3, 9, 2, 12
			ALIGN
listsize	dcd			10
	
			END