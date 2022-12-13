;******************** (C) Andrew Wolfe *******************************************
; @file    HW4 Problem 2
; @author  Andrew Wolfe
; @date    Nov 3, 2019
;*******************************************************************************

	
			AREA    main, CODE, READONLY
			EXPORT	__main				
			ENTRY			
				
__main	PROC
	
			ldr		r0, =strarray	; Pointer to array of string pointers
			ldr		r1, =7			; Number of pointers in strarray
			bl		mysort			; Call sorting routine
			
			LDR r0, = strarray
			LDR r1, [r0],#4
			LDR r2, [r0],#4			;Outputs the list to see if they are in the correct order
			LDR r3, [r0],#4
			LDR r4, [r0],#4
			LDR r5, [r0],#4
			LDR r6, [r0],#4
			LDR r7, [r0]
			
			
			
			
			
endless		b		endless

		ENDP

			
	

									;r0 = i, r1=j
mysort		PROC

			PUSH {lr}
sortloop	BL	compare_and_swap;Place your code here
			ADD r0, #4
			SUBS r1, #1
			CMP r1, #1
			BNE sortloop
			
			pop 	{lr}
			bx		lr
			ENDP

compare_and_swap	PROC
			
			PUSH {r1,r4,r5,r6,r7,r8,r9,r10}
			MOV r2, r0
			
			
			LDR r7, [r2]

comploop	LDR r4, [r2, #4]!
			MOV r8, r7
			MOV r9, r4
compchar	LDRB r5, [r8],#1
rt1			CMP r5, #'a'
			SUBGE r5, #32
			CMP r5, #' '
			BEQ	space1
			LDRB r6, [r9],#1
rt2			CMP r6, #'a'
			SUBGE r6, #32
			CMP r6, #' '
			BEQ	space1
			CMP r6,r5
			BEQ compchar
			MOVLT r7, r4
			MOVLT r10, r2
			SUB r1, #1
			CMP r1, #1
			BNE comploop
			
			
			MOV r2, r0
			LDR r3, [r2]
			STR r7, [r2]
			STR r3, [r10]
			
			
skipswap	POP {r1,r4,r5,r6,r7,r8,r9,r10}
			
			bx		lr
			
space1		LDRB r5, [r8],#1
			B rt1
space2		LDRB r6, [r9],#1
			B rt2
			
			
			

			ENDP
			
			AREA mydata, DATA, READONLY
				
strarray	DCD	str1, str2, str3, str4, str5, str6, str7
	
	
str1 DCB "First string",0
str2 DCB "Second string",0
str3 DCB "So, do I really need a third string",0
str4 DCB "Tetraphobia is the fear of the number 4",0
str5 DCB "A is for apple",0
str6 DCB "Z is called \'zed\' in Canada",0
str7 DCB "M is for middle",0
		END