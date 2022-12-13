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
	;Lab2
	
		LDR r0,=sequence 
		LDR r3,=numElements 
		LDR r8, [r3] 
		SUB r9, r8, #2 ; Only move numElements - 2 times, because we aren't changing values 1 and 2
		ADD r10, #0 ; 
loop    ADD r1, r0, #4 ; Increment the pointers by 4 to move up an element
		ADD r2, r1, #4 ; 
		LDR r4, [r0]
		LDR r5, [r1]
		ADD r6, r4, r5 ; Add two foremost values and store them in front of them
		STR r6, [r2]
		ADD r0, #4 ; Increment the pointer by 4
		ADD r10,#1 ; Increment the counter
		CMP r10, r9
		BNE loop ; Stop if you've reached the end
		
endless B endless
		

		ENDP
		ALIGN
			
numElements DCD 10
sequence DCD 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


		END