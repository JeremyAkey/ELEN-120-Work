
	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s 
	INCLUDE rgb60.h
	
	AREA    main, CODE, READONLY
		
	
portclock_en	PROC		;receives the enable bitmask in r0; returns nothing
		EXPORT	portclock_en
		ldr		r2,=(RCC_BASE+RCC_AHB2ENR)	
		ldr		r1,[r2]
		orr		r1,r0
		str		r1,[r2]	
		bx		lr
				ENDP

port_bit_pushpull	PROC		; r0 is the GPIO Base, r1 is the low bitmask
		EXPORT	port_bit_pushpull
		ldr		r2, =GPIO_MODER
		add		r0,r2
		ldr		r2,[r0]
		orr		r2,r1
		lsl		r1,#1
		bic		r2,r1
		str		r2,[r0]
		bx		lr
			ENDP
				
red_on	PROC			;turns on the red LED	
		EXPORT	red_on
		ldr		r0,=(GPIOB_BASE+GPIO_ODR)
		ldr		r1,[r0]
		orr		r1,#GPIO_ODR_ODR_2				;Set bit 2 of GPIOB_ODR to 1
		str		r1,[r0]	
		bx		lr
			ENDP
	
green_on	PROC			;turns on the green LED	
		EXPORT	green_on
		ldr		r0,=(GPIOE_BASE+GPIO_ODR)
		ldr		r1,[r0]
		orr		r1,#GPIO_ODR_ODR_8				;Set bit 8 of GPIOE_ODR to 1
		str		r1,[r0]	
		bx		lr
			ENDP

red_off	PROC			;turns off the red LED	
		EXPORT	red_off
		ldr		r0,=(GPIOB_BASE+GPIO_ODR)
		ldr		r1,[r0]
		bic		r1,#GPIO_ODR_ODR_2				;Set bit 2 of GPIOB_ODR to 1
		str		r1,[r0]	
		bx		lr
			ENDP
	
green_off	PROC			;turns off the green LED	
		EXPORT	green_off
		ldr		r0,=(GPIOE_BASE+GPIO_ODR)
		ldr		r1,[r0]
		bic		r1,#GPIO_ODR_ODR_8				;Set bit 8 of GPIOE_ODR to 1
		str		r1,[r0]	
		bx		lr
			ENDP

red_tog	PROC			;toggles the red LED	
		EXPORT	red_tog
		ldr		r0,=(GPIOB_BASE+GPIO_ODR)
		ldr		r1,[r0]
		eor		r1,#GPIO_ODR_ODR_2				;Set bit 2 of GPIOB_ODR to 1
		str		r1,[r0]	
		bx		lr
			ENDP
	
green_tog	PROC			;toggles the green LED	
		EXPORT	green_tog
		ldr		r0,=(GPIOE_BASE+GPIO_ODR)
		ldr		r1,[r0]
		eor		r1,#GPIO_ODR_ODR_8				;Set bit 8 of GPIOE_ODR to 1
		str		r1,[r0]	
		bx		lr
			ENDP
				
				
rainbow		PROC
		EXPORT rainbow
		PUSH {lr}
		CMP r11, #0
		BNE skip1
		
		mov r0, #0x00000000
		bl spi32
		mov r10, #10
loop1	ldr r0, =0xEA0000FF
		bl spi32
		ldr r0, =0xEAFC03B1
		bl spi32
		ldr r0, =0xEA00FF00
		bl spi32
		ldr r0, =0xEAFF0000
		bl spi32
		ldr r0, =0xEA03FCF8
		bl spi32
		ldr r0, =0xE803A1FC
		bl spi32
		subs r10, #1
		bne loop1
		mov r0, #0xFFFFFFFF
		bl spi32
		
		add r11, #1
		pop{lr}
		bx lr
		
skip1	CMP r11, #1
		BNE skip2
		
		mov r0, #0x00000000
		bl spi32
		mov r10, #10
loop2	ldr r0, =0xEAFC03B1
		bl spi32
		ldr r0, =0xEA00FF00
		bl spi32
		ldr r0, =0xEAFF0000
		bl spi32
		ldr r0, =0xEA03FCF8
		bl spi32
		ldr r0, =0xE803A1FC
		bl spi32
		ldr r0, =0xEA0000FF
		bl spi32
		subs r10, #1
		bne loop2
		mov r0, #0xFFFFFFFF
		bl spi32
		
		add r11, #1
		pop{lr}
		bx lr
		
skip2	CMP r11, #2
		BNE skip3
		
		mov r0, #0x00000000
		bl spi32
		mov r10, #10
loop3	ldr r0, =0xEAFF0000
		bl spi32
		ldr r0, =0xEA03FCF8
		bl spi32
		ldr r0, =0xE803A1FC
		bl spi32
		ldr r0, =0xEA0000FF
		bl spi32
		ldr r0, =0xEA00FF00
		bl spi32
		ldr r0, =0xEAFC03B1
		bl spi32
		subs r10, #1
		bne loop3
		mov r0, #0xFFFFFFFF
		bl spi32
		
		add r11, #1
		pop{lr}
		bx lr
		
skip3	CMP r11, #2
		BNE skip4
		
		mov r0, #0x00000000
		bl spi32
		mov r10, #10
loop4	ldr r0, =0xEA03FCF8
		bl spi32
		ldr r0, =0xE803A1FC
		bl spi32
		ldr r0, =0xEA0000FF
		bl spi32
		ldr r0, =0xEA00FF00
		bl spi32
		ldr r0, =0xEAFC03B1
		bl spi32
		ldr r0, =0xEAFF0000
		bl spi32
		subs r10, #1
		bne loop4
		mov r0, #0xFFFFFFFF
		bl spi32
		
		add r11, #1
		pop{lr}
		bx lr
		
skip4	CMP r11, #2
		BNE skip5
		
		mov r0, #0x00000000
		bl spi32
		mov r10, #10
loop5	ldr r0, =0xE803A1FC
		bl spi32
		ldr r0, =0xEA0000FF
		bl spi32
		ldr r0, =0xEA00FF00
		bl spi32
		ldr r0, =0xEAFC03B1
		bl spi32
		ldr r0, =0xEAFF0000
		bl spi32
		ldr r0, =0xEA03FCF8
		bl spi32
		subs r10, #1
		bne loop5
		mov r0, #0xFFFFFFFF
		bl spi32
		
		
		add r11, #1
		pop{lr}
		bx lr
		
skip5	
		
		mov r0, #0x00000000
		bl spi32
		mov r10, #10
loop6	ldr r0, =0xEA0000FF
		bl spi32
		ldr r0, =0xEA00FF00
		bl spi32
		ldr r0, =0xEAFC03B1
		bl spi32
		ldr r0, =0xEAFF0000
		bl spi32
		ldr r0, =0xEA03FCF8
		bl spi32
		ldr r0, =0xE803A1FC
		bl spi32
		subs r10, #1
		bne loop6
		mov r0, #0xFFFFFFFF
		bl spi32
		
		mov r11, #0
		pop{lr}
		bx lr

		
		ENDP

delay75		PROC			;delays .75us per count - count in r0
		EXPORT	delay75
				;delay in units of 0.75us		
d75		subs	r0,#1
		bne		d75
		bx		lr
			ENDP
	ALIGN
	END