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
	INCLUDE timer.h
	
	

	
			AREA    main, CODE, READONLY
			EXPORT	__main				
			ENTRY			
				
__main	PROC
		bl	spisw_init
		bl 	tim2_init
endless	b		endless		
		ENDP
			
TIM2_IRQHandler PROC
		EXPORT	TIM2_IRQHandler
		push	{lr}
		
		
		bl rainbow
		
		
		pop		{lr}
		ldr		r2,=(TIM2_BASE+TIM_SR)	;reset pending interrupt for TIM2		
		mov		r1,#~TIM_SR_UIF
		str		r1,[r2]
		dsb
		bx		lr
		ENDP
			
			
			ALIGN						
			AREA    myData, DATA, READWRITE
			
			ALIGN			
	

	END
