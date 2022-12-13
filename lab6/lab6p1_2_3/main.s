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
	INCLUDE jstick.h
	INCLUDE leds.h
	INCLUDE rgb60.h
	
	

	
			AREA    main, CODE, READONLY
			EXPORT	__main				
			ENTRY			
				
__main	PROC
		
		bl	spisw_init
		mov r10, #15
		ldr r0, =0x00000000
		bl spi32
loop1	ldr r0, =0xEA0000FF
		bl spi32
		ldr r0, =0xEA00FF00
		bl spi32
		ldr r0, =0xEAFF0000
		bl spi32
		ldr r0, =0xEAFFFFFF
		bl spi32
		subs r10, #1
		bne loop1
		mov r0, #0xFFFFFFFF
		bl spi32
		

endless	b		endless		
		ENDP
			

			
			
			ALIGN						
			AREA    myData, DATA, READWRITE
			
			ALIGN			
	

	END
