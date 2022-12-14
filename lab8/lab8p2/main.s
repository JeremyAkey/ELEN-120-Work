;******************** (C) Andrew Wolfe *******************************************
; @file    lcd-r.s
; @author  Andrew Wolfe
; @date    Nov. 19, 2019
; @note
;           This code is for the book "Embedded Systems with ARM Cortex-M 
;           Microcontrollers in Assembly Language and C, Yifeng Zhu, 
;           ISBN-13: 978-0982692639, ISBN-10: 0982692633 as used at Santa Clara University
;*******************************************************************************



	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s   

	INCLUDE lcd.h



	
			AREA    main, CODE, READONLY
			EXPORT	__main				
			ENTRY			
				
__main	PROC
	
		bl		lcd_init
endless	bl		lcd_clear

;******************************************
;	Put your code here to display Santa Clara
;******************************************
		MOV r0, #'1'
		bl		num2font
		MOV r1, #1
		bl		lcd_draw
		MOV r0, #'2'
		bl		num2font
		MOV r1, #2
		bl		lcd_draw
		MOV r0, #'3'
		bl		num2font
		MOV r1, #3
		bl		lcd_draw
		MOV r0, #'4'
		bl		num2font
		MOV r1, #4
		bl		lcd_draw
		MOV r0, #'5'
		bl		num2font
		MOV r1, #5
		bl		lcd_draw
		
		;Put 1 second delay
		mov	r3, #0x00150000 ; Loop that runs ~1.37 million times which is ~1 second
			
loop	subs	r3,#1
		bne		loop
		
		
		bl lcd_clear
		
		MOV r0, #'2'
		bl		num2font
		MOV r1, #1
		bl		lcd_draw
		MOV r0, #'3'
		bl		num2font
		MOV r1, #2
		bl		lcd_draw
		MOV r0, #'4'
		bl		num2font
		MOV r1, #3
		bl		lcd_draw
		MOV r0, #'5'
		bl		num2font
		MOV r1, #4 
		bl		lcd_draw
		MOV r0, #'6'
		bl		num2font
		MOV r1, #5
		bl		lcd_draw
	
		
		mov	r3, #0x00150000 ; Loop that runs ~1.37 million times which is ~1 second
			
loop2	subs	r3,#1
		bne		loop2
			
		b		endless		
		ENDP
			

			
			ALIGN						
			AREA    myData, DATA, READWRITE
			
			ALIGN			


	END
