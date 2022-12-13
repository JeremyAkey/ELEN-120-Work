;******************** (C) Andrew Wolfe *******************************************
; @file    HW8 Problem 1
; @author  Andrew Wolfe
; @date    Nov 3, 2019
;*******************************************************************************

	
			AREA    main, CODE, READONLY
			EXPORT	__main				
			ENTRY			
				
__main	PROC
	
			ldr		r0, =array	; Pointer to array of string pointers
			ldr		r1, =10			; Number of items in array
			bl		mysort			; Call sorting routine
endless		b		endless

		ENDP

			
	

									;r0 = i, r1=j
mysort		PROC
			;Put your code here
			push {lr}
			
sortloop	bl compare_and_swap
			ADD r0, #4
			SUBS r1, #1
			BNE sortloop
			
			pop {lr}
			bx		lr
			ENDP

compare_and_swap	PROC
			;Put your code here
			push {r1,r4,r5,r6}
			MOV r2, r0
			LDR r5, [r2]
loop		LDR r4, [r2]
			LDR r3, [r2,#4]!
			CMP r3, r5
			MOVLT r5, r3
			MOVLT r6, r2
			SUBS r1, #1
			BNE loop
			
			MOV r2, r0
			LDR r3, [r2]
			
			STR r5, [r2]
			STR r3, [r6]
			
			pop {r1,r4,r5,r6}
			bx		lr
			ENDP
						
			ALIGN
			AREA mydata, DATA, READONLY

				
array		DCD		9,2,5,1,8,6,7,0,3,4
	

		END