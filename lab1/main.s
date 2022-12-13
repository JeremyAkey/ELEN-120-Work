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
	;Lab1
	
	;	LDR r1, =value
		;LDR r2, [r1]
		;NOT r3, r2
	;	ADD r3, r3, #1
;endless B endless


		;ALIGN
;value   DCD 0xFFFFFFFF

		;LDR r1, =list
		;LDR r2, [r1]
		;LSL r2, r2, #1
		;STR r2, [r1]
		;ADD r1, r1, #4
		;LDR r2, [r1]
		;LSL r2, r2, #1
		;STR r2, [r1]
		;ADD r1, r1, #4
		;LDR r2, [r1]
		;LSL r2, r2, #1
		;STR r2, [r1]
;endless B endless
		
		
;		ENDP
;		ALIGN

;list 	DCD 3, 4, 5


		LDR r0, =0xFFFFFFFF
		LDR r1, =0x00000003
		SUBS r0,r1
		

endless B endless




		ENDP
		ALIGN




;********************************************************************************
; Put Your Code Here
;********************************************************************************

		

;********************************************************************************
; Put Your Data Here
;********************************************************************************

	END
