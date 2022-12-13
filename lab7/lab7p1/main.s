;******************** (C) Andrew Wolfe *******************************************
; @file    main_hw_proto.s
; @author  Andrew Wolfe
; @date    August 29, 2019
; @note
;           This code is for the book "Embedded Systems with ARM Cortex-M 
;           Microcontrollers in Assembly Language and C, Yifeng Zhu, 
;           ISBN-13: 978-0982692639, ISBN-10: 0982692633 as used at Santa Clara University
;*******************************************************************************



	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s   

	INCLUDE leds.h

	INCLUDE	adc.h

	
			AREA    main, CODE, READONLY
			EXPORT	__main				
			ENTRY			
				
__main	PROC
	

; Add code here to configure the proper GPIO port to drive the red LED.  
; You may use the routines provided in leds.s 		
		
		
		LDR r0, =RCC_BASE 
		LDR r1, [r0, #RCC_AHB2ENR] 
		ORR r1, r1, #RCC_AHB2ENR_GPIOBEN 
		STR r1, [r0, #RCC_AHB2ENR] 
			
		LDR r0, =GPIOB_BASE 
		LDR r1, [r0, #GPIO_MODER] 
		EOR r1, #0x30 
		ORR r1, r1, #0x10 
		STR r1, [r0, #GPIO_MODER] 
		
		
		bl		adc_init

loop	bl		adc_read
		
		
		cmp r0, #0x800
		bge		redon
		blt 	redoff
		
		b 		loop
		
		
redon	bl 		red_on
		b 		loop

redoff	bl 		red_off
		b		loop
		
; Add and/or modify code here to repeatedly read the A/D converter and turn the red LED on if 
; the reading is greater than or equal to 2048 and turn off the red LED is the reading is less than that.

endless	b		endless		
		ENDP
			
	

			
			
			ALIGN						
			AREA    myData, DATA, READWRITE
			
			ALIGN			


	END
