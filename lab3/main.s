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
	
			AREA    main, CODE, READONLY
			EXPORT	__main				
			ENTRY			
				
__main	PROC
		; Red LED
			
			LDR r0, =RCC_BASE ;
			LDR r1, [r0, #RCC_AHB2ENR] ; Load the address of the Clock Enable register
			ORR r1, r1, #RCC_AHB2ENR_GPIOBEN ; Enable the clock for GPIOB
			STR r1, [r0, #RCC_AHB2ENR] ;
			
			LDR r0, =GPIOB_BASE ;
			LDR r1, [r0, #GPIO_MODER] ; ; Load the Address of the GPIO Mode register
			EOR r1, #0x30 ;
			ORR r1, r1, #0x10 ; ; Clear then set MODE 2 to the correct mode
			STR r1, [r0, #GPIO_MODER] ;
			
			LDR r1, [r0, #GPIO_ODR] ; Load the address of the GPIO Output register
			ORR r1, r1, #0x04 ; Set the correct pin to 1
			STR r1, [r0, #GPIO_ODR] ; 
			
		; Green LED
		
			LDR r0, =RCC_BASE ;
			LDR r1, [r0, #RCC_AHB2ENR] ; Load the address of the Clock Enable register
			ORR r1, r1, #RCC_AHB2ENR_GPIOEEN ; Enable the clock for GPIOB
			STR r1, [r0, #RCC_AHB2ENR] ;
			
			LDR r0, =GPIOE_BASE ;
			LDR r1, [r0, #GPIO_MODER] ; ; Load the Address of the GPIO Mode register
			EOR r1, #(0x03<<(2*8)) ;
			ORR r1, r1, #(0x01<<(2*8)) ; ; Clear then set MODE 8 to the correct mode
			STR r1, [r0, #GPIO_MODER] ;
			
			LDR r1, [r0, #GPIO_ODR] ; Load the address of the GPIO Output register
			ORR r1, r1, #0x100 ; Set the correct pin to 1
			STR r1, [r0, #GPIO_ODR] ; 
			
		
			
			
			
			
			
			
begin		LDR r0, =GPIOB_BASE ;
			LDR r1, [r0, #GPIO_ODR] ; Load the address of the GPIO Output register
			ORR r1, r1, #0x04 ; Clear the correct pin
			STR r1, [r0, #GPIO_ODR] ; 
			LDR r0, =GPIOE_BASE ;
			LDR r1, [r0, #GPIO_ODR] ; Load the address of the GPIO Output register
			EOR r1, r1, #0x100 ; Clear the correct pin
			STR r1, [r0, #GPIO_ODR] ; 
			
			mov	r1, #0x00150000 ; Loop that runs ~1.37 million times which is ~1 second
			
loop		subs	r1,#1
			bne		loop
			
			; Turn of the lights after 1 second
			LDR r0, =GPIOB_BASE ;
			LDR r1, [r0, #GPIO_ODR] ; Load the address of the GPIO Output register
			EOR r1, r1, #0x04 ; Clear the correct pin
			STR r1, [r0, #GPIO_ODR] ; 
			LDR r0, =GPIOE_BASE ;
			LDR r1, [r0, #GPIO_ODR] ; Load the address of the GPIO Output register
			ORR r1, r1, #0x100 ; Clear the correct pin
			STR r1, [r0, #GPIO_ODR] ; 
			
			mov	r1, #0x00150000 ; Loop that runs ~1.37 million times which is ~1 second
			
loop2		subs	r1,#1
			bne		loop2
			b		begin

		ENDP
			ALIGN						
			AREA    myData, DATA, READWRITE
			ALIGN			



	END
