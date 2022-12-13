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
	;Hw5
	
				LDR r0, =samplelist ; Load all of the pointers
				LDR r1, =resultlist
				LDR r2, =eol1
				LDR r3, =eol2
loop1			CMP r1,r3 			; Check if the program is finished
				BEQ endless
				MOV r4, r0			; Copy the address in r0 to r4
				ADD r0, #4			; Increment to the next item in the list
loop2			CMP r4, r0			; Check if done with the current word
				BEQ loop1
				LDRB r5, [r4],#1	; Load first byte 
				AND r6, r5, #0xC0
				TEQ r6, #0x40
				ADDEQ r10, #1
				AND r6, r5, #0x30	;; All of this code checks if there is a 01 in any of the two bit bitfields and increments if there is
				TEQ r6, #0x10
				ADDEQ r10, #1
				AND r6, r5, #0x0C
				TEQ r6, #0x04
				ADDEQ r10, #1
				AND r6, r5, #0x03
				TEQ r6, #0x01
				ADDEQ r10, #1
				CMP r4,r0
				BEQ result
				B loop2
				
				
result			STR r10, [r1],#4	; This code stores the number of 01's in the word
				MOV r10, #0
				B loop2
				
endless 		b endless

				ENDP
				ALIGN

samplelist 		dcd 0x12345678, 0xbeeffeed, 0x55555555, 0xa5a5a5a5
eol1
resultlist 		dcd 0,0,0,0
eol2
				END