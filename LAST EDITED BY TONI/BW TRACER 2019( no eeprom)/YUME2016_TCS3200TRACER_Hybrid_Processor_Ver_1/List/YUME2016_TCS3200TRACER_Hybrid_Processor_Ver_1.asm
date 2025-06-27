
;CodeVisionAVR C Compiler V2.05.3 Standard
;(C) Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega8
;Program type             : Application
;Clock frequency          : 16.000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 256 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;Global 'const' stored in FLASH     : No
;Enhanced function parameter passing: Yes
;Enhanced core instructions         : On
;Smart register allocation          : On
;Automatic register allocation      : On

	#pragma AVRPART ADMIN PART_NAME ATmega8
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1119
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _DETECTED_COLOUR=R4
	.DEF _Threshold_White=R6
	.DEF _Threshold_Black=R8
	.DEF _Threshold_Gray=R10
	.DEF _TRACER_GRAYDATA=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _timer1_ovf_isr
	RJMP 0x00
	RJMP 0x00
	RJMP _usart_rx_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

_0x3:
	.DB  0x41,0x7
_0x4:
	.DB  0xB4,0x1
_0x5:
	.DB  0xAA
_0x6:
	.DB  0x28
_0x7:
	.DB  0x3C
_0x8:
	.DB  0x3E
_0x9:
	.DB  0x7C
_0xA:
	.DB  0x29
_0xB:
	.DB  0x2A
_0xC:
	.DB  0x2B
_0xD:
	.DB  0x2C
_0xE:
	.DB  0x2D
_0xF:
	.DB  0x2E
_0x10:
	.DB  0x35
_0x11:
	.DB  0x5E
_0x12:
	.DB  0x53
_0x13:
	.DB  0x41
_0x14:
	.DB  0x42
_0x15:
	.DB  0x58
_0x16:
	.DB  0x5E
_0x17:
	.DB  0x41
_0x18:
	.DB  0x42
_0x19:
	.DB  0x43
_0x1A:
	.DB  0x5A
_0x1B:
	.DB  0x58
_0x1C:
	.DB  0x46
_0x1D:
	.DB  0x47
_0x1E:
	.DB  0x48
_0x1F:
	.DB  0x49
_0x20:
	.DB  0x4A
_0x21:
	.DB  0x4B
_0x22:
	.DB  0x4D
_0x23:
	.DB  0x4C
_0x24:
	.DB  0xFE
_0x25:
	.DB  0x52
_0x26:
	.DB  0x53
_0x27:
	.DB  0x1
_0x28:
	.DB  0xD0,0x7
_0x29:
	.DB  0x3F,0xC
_0x2A:
	.DB  0x52
_0xD4:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0
_0x155:
	.DB  0x0,0x0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x02
	.DW  _Threshold_BW
	.DW  _0x3*2

	.DW  0x02
	.DW  _Threshold_BG
	.DW  _0x4*2

	.DW  0x01
	.DW  _TRACER_THRESHOLD_UP
	.DW  _0x5*2

	.DW  0x01
	.DW  _TRACER_THRESHOLD_DOWN
	.DW  _0x6*2

	.DW  0x01
	.DW  _COMMAND_FLAG_A
	.DW  _0x7*2

	.DW  0x01
	.DW  _COMMAND_FLAG_B
	.DW  _0x8*2

	.DW  0x01
	.DW  _CMD_IDLE
	.DW  _0x16*2

	.DW  0x01
	.DW  _RAW_VAL_FLAG
	.DW  _0x2A*2

	.DW  0x02
	.DW  0x04
	.DW  _0x155*2

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.0 Professional
;Automatic Program Generator
;© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : YUME TCS3200 + Photodiode Tracer Processor
;Version : Ver.3.0
;Date    : April 21st 2016
;Author  : Ryan Batch 2013
;Company : Intelligent Fire Fighting Robot Division - Brawijaya University
;Comments:   Ver. 1 -> Basic function
;            Ver. 2 -> EEPROM autocalibration feature
;            Ver. 3 -> Optimization
;
;
;Chip type               : ATmega8
;Program type            : Application
;AVR Core Clock frequency: 16.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*****************************************************/
;
;#include <mega8.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <stdio.h>
;#include <stdlib.h>
;#include <delay.h>
;#include <math.h>
;#include <YUME2016_TCS3200TRACER_Hybrid_Processor_Ver_1.h>

	.DSEG
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;
;
;#ifndef RXB8
;#define RXB8 1
;#endif
;
;#ifndef TXB8
;#define TXB8 0
;#endif
;
;#ifndef UPE
;#define UPE 2
;#endif
;
;#ifndef DOR
;#define DOR 3
;#endif
;
;#ifndef FE
;#define FE 4
;#endif
;
;#ifndef UDRE
;#define UDRE 5
;#endif
;
;#ifndef RXC
;#define RXC 7
;#endif
;
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;
;// USART Receiver buffer
;#define RX_BUFFER_SIZE 8
;char rx_buffer[RX_BUFFER_SIZE];
;
;#if RX_BUFFER_SIZE <= 256
;unsigned char rx_wr_index,rx_rd_index,rx_counter;
;#else
;unsigned int rx_wr_index,rx_rd_index,rx_counter;
;#endif
;
;// This flag is set on USART Receiver buffer overflow
;bit rx_buffer_overflow;
;
;// USART Receiver interrupt service routine
;interrupt [USART_RXC] void usart_rx_isr(void)
; 0000 0057 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0058 char status,data;
; 0000 0059 status=UCSRA;
	RCALL __SAVELOCR2
;	status -> R17
;	data -> R16
	IN   R17,11
; 0000 005A data=UDR;
	IN   R16,12
; 0000 005B if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x2B
; 0000 005C    {
; 0000 005D    rx_buffer[rx_wr_index++]=data;
	LDS  R30,_rx_wr_index
	SUBI R30,-LOW(1)
	STS  _rx_wr_index,R30
	RCALL SUBOPT_0x0
	ST   Z,R16
; 0000 005E #if RX_BUFFER_SIZE == 256
; 0000 005F    // special case for receiver buffer size=256
; 0000 0060    if (++rx_counter == 0)
; 0000 0061       {
; 0000 0062 #else
; 0000 0063    if (rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	LDS  R26,_rx_wr_index
	CPI  R26,LOW(0x8)
	BRNE _0x2C
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
; 0000 0064    if (++rx_counter == RX_BUFFER_SIZE)
_0x2C:
	LDS  R26,_rx_counter
	SUBI R26,-LOW(1)
	STS  _rx_counter,R26
	CPI  R26,LOW(0x8)
	BRNE _0x2D
; 0000 0065       {
; 0000 0066       rx_counter=0;
	LDI  R30,LOW(0)
	STS  _rx_counter,R30
; 0000 0067 #endif
; 0000 0068       rx_buffer_overflow=1;
	SET
	BLD  R2,0
; 0000 0069       }
; 0000 006A    }
_0x2D:
; 0000 006B }
_0x2B:
	RCALL __LOADLOCR2P
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0000 0072 {
_getchar:
; 0000 0073 char data;
; 0000 0074 while (rx_counter==0);
	ST   -Y,R17
;	data -> R17
_0x2E:
	LDS  R30,_rx_counter
	CPI  R30,0
	BREQ _0x2E
; 0000 0075 data=rx_buffer[rx_rd_index++];
	LDS  R30,_rx_rd_index
	SUBI R30,-LOW(1)
	STS  _rx_rd_index,R30
	RCALL SUBOPT_0x0
	LD   R17,Z
; 0000 0076 #if RX_BUFFER_SIZE != 256
; 0000 0077 if (rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
	LDS  R26,_rx_rd_index
	CPI  R26,LOW(0x8)
	BRNE _0x31
	LDI  R30,LOW(0)
	STS  _rx_rd_index,R30
; 0000 0078 #endif
; 0000 0079 #asm("cli")
_0x31:
	cli
; 0000 007A --rx_counter;
	LDS  R30,_rx_counter
	SUBI R30,LOW(1)
	STS  _rx_counter,R30
; 0000 007B #asm("sei")
	sei
; 0000 007C return data;
	MOV  R30,R17
	LD   R17,Y+
	RET
; 0000 007D }
;#pragma used-
;#endif
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;// Timer1 overflow interrupt service routine
;interrupt [TIM1_OVF] void timer1_ovf_isr(void)
; 0000 0086 {
_timer1_ovf_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0087 // Place your code here
; 0000 0088     TCS3200_COUNTER++;
	LDI  R26,LOW(_TCS3200_COUNTER)
	LDI  R27,HIGH(_TCS3200_COUNTER)
	RCALL SUBOPT_0x1
; 0000 0089 
; 0000 008A }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;
;#define ADC_VREF_TYPE 0x60
;
;// Read the 8 most significant bits
;// of the AD conversion result
;unsigned char read_adc(unsigned char adc_input)
; 0000 0091 {
_read_adc:
; 0000 0092 ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
	ST   -Y,R26
;	adc_input -> Y+0
	LD   R30,Y
	ORI  R30,LOW(0x60)
	OUT  0x7,R30
; 0000 0093 // Delay needed for the stabilization of the ADC input voltage
; 0000 0094 delay_us(10);
	__DELAY_USB 53
; 0000 0095 // Start the AD conversion
; 0000 0096 ADCSRA|=0x40;
	SBI  0x6,6
; 0000 0097 // Wait for the AD conversion to complete
; 0000 0098 while ((ADCSRA & 0x10)==0);
_0x32:
	SBIS 0x6,4
	RJMP _0x32
; 0000 0099 ADCSRA|=0x10;
	SBI  0x6,4
; 0000 009A return ADCH;
	IN   R30,0x5
	RJMP _0x20A0003
; 0000 009B }
;
;// Declare your global variables here
;
;//int adc1,adc2,adc3;
;void main(void)
; 0000 00A1 {
_main:
; 0000 00A2 
; 0000 00A3     YUME_Initialization();
	RCALL _YUME_Initialization
; 0000 00A4     TCS3200_Config(3);
	RCALL SUBOPT_0x2
	RCALL _TCS3200_Config
; 0000 00A5 //    TRACER_THRESHOLD_UP = EEPROM_A;
; 0000 00A6 //    TRACER_THRESHOLD_DOWN = EEPROM_B;
; 0000 00A7 
; 0000 00A8     while (1)
_0x35:
; 0000 00A9     {
; 0000 00AA //        TRIGGER= getchar();
; 0000 00AB //        printf("\r\r");
; 0000 00AC //        if(TRIGGER=='X')
; 0000 00AD //        {
; 0000 00AE //            Tracer_Sampling(FRONT);
; 0000 00AF //            Tracer_Sampling(MIDDLE);
; 0000 00B0 //            Tracer_Sampling(REAR);
; 0000 00B1 ////
; 0000 00B2 //            Tracer_GetRule();
; 0000 00B3 //
; 0000 00B4 //            //TCS3200_Sampling();
; 0000 00B5 ////            TCS3200_GetRule();
; 0000 00B6 //            TRIGGER=0;
; 0000 00B7 //        }
; 0000 00B8 
; 0000 00B9         Get_CMD();
	RCALL _Get_CMD
; 0000 00BA //         adc1 = read_adc(0);
; 0000 00BB //         adc2 = read_adc(1);
; 0000 00BC //         adc3 = read_adc(2);
; 0000 00BD //
; 0000 00BE //         printf("ADC 1 : %d \t",adc1);
; 0000 00BF //         printf("ADC 2 : %d \t",adc2);
; 0000 00C0 //         printf("ADC 3 : %d \r",adc3);
; 0000 00C1 //         delay_ms(10);
; 0000 00C2 
; 0000 00C3 
; 0000 00C4     }
	RJMP _0x35
; 0000 00C5 }
_0x38:
	RJMP _0x38
;
;
;void YUME_Initialization(void)
; 0000 00C9 {
_YUME_Initialization:
; 0000 00CA     // Declare your local variables here
; 0000 00CB 
; 0000 00CC     // Input/Output Ports initialization
; 0000 00CD     // Port B initialization
; 0000 00CE     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=Out Func1=Out Func0=Out
; 0000 00CF     // State7=T State6=T State5=T State4=T State3=T State2=1 State1=1 State0=1
; 0000 00D0     PORTB=0x07;
	LDI  R30,LOW(7)
	OUT  0x18,R30
; 0000 00D1     DDRB=0x07;
	OUT  0x17,R30
; 0000 00D2 
; 0000 00D3     // Port C initialization
; 0000 00D4     // Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 00D5     // State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 00D6     PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 00D7     DDRC=0x00;
	OUT  0x14,R30
; 0000 00D8 
; 0000 00D9     // Port D initialization
; 0000 00DA     // Func7=In Func6=In Func5=Out Func4=Out Func3=Out Func2=In Func1=In Func0=In
; 0000 00DB     // State7=T State6=T State5=1 State4=1 State3=1 State2=T State1=T State0=T
; 0000 00DC     PORTD=0x38;
	LDI  R30,LOW(56)
	OUT  0x12,R30
; 0000 00DD     DDRD=0x38;
	OUT  0x11,R30
; 0000 00DE 
; 0000 00DF     // Timer/Counter 0 initialization
; 0000 00E0     // Clock source: System Clock
; 0000 00E1     // Clock value: Timer 0 Stopped
; 0000 00E2     TCCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0000 00E3     TCNT0=0x00;
	OUT  0x32,R30
; 0000 00E4 
; 0000 00E5     // Timer/Counter 1 initialization
; 0000 00E6     // Clock source: System Clock
; 0000 00E7     // Clock value: Timer1 Stopped
; 0000 00E8     // Mode: Normal top=0xFFFF
; 0000 00E9     // OC1A output: Discon.
; 0000 00EA     // OC1B output: Discon.
; 0000 00EB     // Noise Canceler: Off
; 0000 00EC     // Input Capture on Falling Edge
; 0000 00ED     // Timer1 Overflow Interrupt: On
; 0000 00EE     // Input Capture Interrupt: Off
; 0000 00EF     // Compare A Match Interrupt: Off
; 0000 00F0     // Compare B Match Interrupt: Off
; 0000 00F1     TCCR1A=0x00;
	OUT  0x2F,R30
; 0000 00F2     TCCR1B=0x00;
	RCALL SUBOPT_0x3
; 0000 00F3     TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 00F4     TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 00F5     ICR1H=0x00;
	OUT  0x27,R30
; 0000 00F6     ICR1L=0x00;
	OUT  0x26,R30
; 0000 00F7     OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 00F8     OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 00F9     OCR1BH=0x00;
	OUT  0x29,R30
; 0000 00FA     OCR1BL=0x00;
	OUT  0x28,R30
; 0000 00FB 
; 0000 00FC     // Timer/Counter 2 initialization
; 0000 00FD     // Clock source: System Clock
; 0000 00FE     // Clock value: Timer2 Stopped
; 0000 00FF     // Mode: Normal top=0xFF
; 0000 0100     // OC2 output: Disconnected
; 0000 0101     ASSR=0x00;
	OUT  0x22,R30
; 0000 0102     TCCR2=0x00;
	OUT  0x25,R30
; 0000 0103     TCNT2=0x00;
	OUT  0x24,R30
; 0000 0104     OCR2=0x00;
	OUT  0x23,R30
; 0000 0105 
; 0000 0106     // External Interrupt(s) initialization
; 0000 0107     // INT0: Off
; 0000 0108     // INT1: Off
; 0000 0109     MCUCR=0x00;
	OUT  0x35,R30
; 0000 010A 
; 0000 010B     // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 010C     TIMSK=0x04;
	LDI  R30,LOW(4)
	OUT  0x39,R30
; 0000 010D 
; 0000 010E     // USART initialization
; 0000 010F     // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0110     // USART Receiver: On
; 0000 0111     // USART Transmitter: On
; 0000 0112     // USART Mode: Asynchronous
; 0000 0113     // USART Baud Rate: 9600
; 0000 0114     UCSRA=0x00;
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 0115     UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
; 0000 0116     UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 0117     UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 0118     UBRRL=0x67;
	LDI  R30,LOW(103)
	OUT  0x9,R30
; 0000 0119 
; 0000 011A     // Analog Comparator initialization
; 0000 011B     // Analog Comparator: Off
; 0000 011C     // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 011D     ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 011E     SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 011F 
; 0000 0120     // ADC initialization
; 0000 0121     // ADC Clock frequency: 500.000 kHz
; 0000 0122     // ADC Voltage Reference: AVCC pin
; 0000 0123     // Only the 8 most significant bits of
; 0000 0124     // the AD conversion result are used
; 0000 0125     ADMUX=ADC_VREF_TYPE & 0xff;
	LDI  R30,LOW(96)
	OUT  0x7,R30
; 0000 0126     ADCSRA=0x85;
	LDI  R30,LOW(133)
	OUT  0x6,R30
; 0000 0127 
; 0000 0128     // SPI initialization
; 0000 0129     // SPI disabled
; 0000 012A     SPCR=0x00;
	LDI  R30,LOW(0)
	OUT  0xD,R30
; 0000 012B 
; 0000 012C     // TWI initialization
; 0000 012D     // TWI disabled
; 0000 012E     TWCR=0x00;
	OUT  0x36,R30
; 0000 012F 
; 0000 0130     // Global enable interrupts
; 0000 0131     #asm("sei")
	sei
; 0000 0132 
; 0000 0133 }
	RET
;
;void Send_UART(unsigned char data)
; 0000 0136 {
_Send_UART:
; 0000 0137     while(!(UCSRA & (1<<UDRE))){};
	ST   -Y,R26
;	data -> Y+0
_0x39:
	SBIS 0xB,5
	RJMP _0x39
; 0000 0138     UDR=data;
	LD   R30,Y
	OUT  0xC,R30
; 0000 0139 }
_0x20A0003:
	ADIW R28,1
	RET
;
;
;void TCS3200_Config(unsigned int mode)
; 0000 013D {
_TCS3200_Config:
; 0000 013E     if(mode==0)         //output frequency scaling power down
	ST   -Y,R27
	ST   -Y,R26
;	mode -> Y+0
	LD   R30,Y
	LDD  R31,Y+1
	SBIW R30,0
	BRNE _0x3C
; 0000 013F     {
; 0000 0140         TCS3200_S0=0;
	CBI  0x18,0
; 0000 0141         TCS3200_S1=0;
	CBI  0x18,1
; 0000 0142     }
; 0000 0143     if(mode==1)         //output frequency scaling 1:50
_0x3C:
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,1
	BRNE _0x41
; 0000 0144     {
; 0000 0145         TCS3200_S0=0;
	CBI  0x18,0
; 0000 0146         TCS3200_S1=1;
	SBI  0x18,1
; 0000 0147     }
; 0000 0148     if(mode==2)         //output frequency scaling 1:5
_0x41:
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,2
	BRNE _0x46
; 0000 0149     {
; 0000 014A         TCS3200_S0=1;
	SBI  0x18,0
; 0000 014B         TCS3200_S1=0;
	CBI  0x18,1
; 0000 014C     }
; 0000 014D     if(mode==3)         //output frequency scaling 1:1
_0x46:
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,3
	BRNE _0x4B
; 0000 014E     {
; 0000 014F         TCS3200_S0=1;
	SBI  0x18,0
; 0000 0150         TCS3200_S1=1;
	SBI  0x18,1
; 0000 0151     }
; 0000 0152     return;
_0x4B:
	ADIW R28,2
	RET
; 0000 0153 }
;
;
;void TCS3200Read(void)
; 0000 0157 {
_TCS3200Read:
; 0000 0158     TCS3200Read_R();
	RCALL _TCS3200Read_R
; 0000 0159     TCS3200Read_G();
	RCALL _TCS3200Read_G
; 0000 015A     TCS3200Read_B();
	RCALL _TCS3200Read_B
; 0000 015B     TCS3200Read_W();
	RCALL _TCS3200Read_W
; 0000 015C 
; 0000 015D //    printf("Red  : %d \t",(int)TCS3200_Pulse_R);
; 0000 015E //    printf("Green: %d \t",(int)TCS3200_Pulse_G);
; 0000 015F //    printf("Blue: %d \t",(int)TCS3200_Pulse_B);
; 0000 0160 //    printf("White: %d \r",(int)TCS3200_Pulse_W);
; 0000 0161 }
	RET
;
;int TCS3200Read_R(void)
; 0000 0164 {
_TCS3200Read_R:
; 0000 0165      TCS3200_S2=0;
	CBI  0x18,2
; 0000 0166      TCS3200_S3=0;
	RCALL SUBOPT_0x4
; 0000 0167      delay_ms(5);
; 0000 0168      TCCR1B=0x06;
; 0000 0169      delay_ms(5);
; 0000 016A      TCCR1B=0x00;
; 0000 016B      TCS3200_Pulse_R=((int)TCS3200_COUNTER*256)+(int)TCNT1;
	RCALL SUBOPT_0x5
	STS  _TCS3200_Pulse_R,R30
	STS  _TCS3200_Pulse_R+1,R31
; 0000 016C      TCNT1=0;
	RCALL SUBOPT_0x6
; 0000 016D      TCS3200_COUNTER=0;
; 0000 016E      delay_ms(10);
; 0000 016F      return TCS3200_Pulse_R;
	LDS  R30,_TCS3200_Pulse_R
	LDS  R31,_TCS3200_Pulse_R+1
	RET
; 0000 0170 
; 0000 0171 }
;
;int TCS3200Read_G(void)
; 0000 0174 {
_TCS3200Read_G:
; 0000 0175      TCS3200_S2=1;
	SBI  0x18,2
; 0000 0176      TCS3200_S3=1;
	RCALL SUBOPT_0x7
; 0000 0177      delay_ms(5);
; 0000 0178      TCCR1B=0x06;
; 0000 0179      delay_ms(5);
; 0000 017A      TCCR1B=0x00;
; 0000 017B      TCS3200_Pulse_G=((int)TCS3200_COUNTER*256)+(int)TCNT1;
	RCALL SUBOPT_0x5
	STS  _TCS3200_Pulse_G,R30
	STS  _TCS3200_Pulse_G+1,R31
; 0000 017C //    TCS3200_Pulse_G=((int)MIDDLE_COUNTER*65536)+(int)TCNT1;
; 0000 017D      TCNT1=0;
	RCALL SUBOPT_0x6
; 0000 017E      TCS3200_COUNTER=0;
; 0000 017F      delay_ms(10);
; 0000 0180      return TCS3200_Pulse_G;
	RCALL SUBOPT_0x8
	RET
; 0000 0181 
; 0000 0182 }
;
;int TCS3200Read_B(void)
; 0000 0185 {
_TCS3200Read_B:
; 0000 0186      TCS3200_S2=0;
	CBI  0x18,2
; 0000 0187      TCS3200_S3=1;
	RCALL SUBOPT_0x7
; 0000 0188      delay_ms(5);
; 0000 0189      TCCR1B=0x06;
; 0000 018A      delay_ms(5);
; 0000 018B      TCCR1B=0x00;
; 0000 018C      TCS3200_Pulse_B=((int)TCS3200_COUNTER*256)+(int)TCNT1;
	RCALL SUBOPT_0x5
	STS  _TCS3200_Pulse_B,R30
	STS  _TCS3200_Pulse_B+1,R31
; 0000 018D //     TCS3200_Pulse_B=((int)TCS3200_COUNTER*65536)+(int)TCNT1;
; 0000 018E      TCNT1=0;
	RCALL SUBOPT_0x6
; 0000 018F      TCS3200_COUNTER=0;
; 0000 0190      delay_ms(10);
; 0000 0191      return TCS3200_Pulse_B;
	RCALL SUBOPT_0x9
	RET
; 0000 0192 
; 0000 0193 }
;
;int TCS3200Read_W(void)
; 0000 0196 {
_TCS3200Read_W:
; 0000 0197      TCS3200_S2=1;
	SBI  0x18,2
; 0000 0198      TCS3200_S3=0;
	RCALL SUBOPT_0x4
; 0000 0199      delay_ms(5);
; 0000 019A      TCCR1B=0x06;
; 0000 019B      delay_ms(5);
; 0000 019C      TCCR1B=0x00;
; 0000 019D      TCS3200_Pulse_W=((int)TCS3200_COUNTER*256)+(int)TCNT1;
	RCALL SUBOPT_0x5
	STS  _TCS3200_Pulse_W,R30
	STS  _TCS3200_Pulse_W+1,R31
; 0000 019E //    TCS3200_Pulse_W=((int)TCS3200_COUNTER*65536)+(int)TCNT1;
; 0000 019F      TCNT1=0;
	RCALL SUBOPT_0x6
; 0000 01A0      TCS3200_COUNTER=0;
; 0000 01A1      delay_ms(10);
; 0000 01A2      return TCS3200_Pulse_W;
	RCALL SUBOPT_0xA
	RET
; 0000 01A3 
; 0000 01A4 }
;
;
;
;/*
; * DATA PACKET STRUCTURE
; * [COMMAND_FLAG_A] [COMMAND_FLAG_B] [F_DETECTED_COLOUR] [M_DETECTED_COLOUR] [TRACER_STAT] [COLOUR_STAT]
; *
;*/
;void Send_TCS3200_Conclusion(void)
; 0000 01AE {
; 0000 01AF     Send_UART(COMMAND_FLAG_A);
; 0000 01B0     Send_UART(COMMAND_FLAG_B);
; 0000 01B1     Send_UART(DETECTED_COLOUR);
; 0000 01B2     Send_UART(TRACER_STAT);
; 0000 01B3 }
;
;void Get_CMD(void)
; 0000 01B6 {
_Get_CMD:
; 0000 01B7     TCS3200_CMD[TEMPORARY] = getchar();;
	RCALL _getchar
	__POINTW2MN _TCS3200_CMD,4
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0xC
; 0000 01B8 
; 0000 01B9     if(TCS3200_CMD[TEMPORARY]!=CMD_IDLE)
	__GETW2MN _TCS3200_CMD,4
	LDS  R30,_CMD_IDLE
	LDS  R31,_CMD_IDLE+1
	RCALL SUBOPT_0xD
	BREQ _0x60
; 0000 01BA     {
; 0000 01BB         TCS3200_CMD[1] = TCS3200_CMD[0];
	RCALL SUBOPT_0xE
	__PUTW1MN _TCS3200_CMD,2
; 0000 01BC         TCS3200_CMD[0] = TCS3200_CMD[TEMPORARY];
	__GETW1MN _TCS3200_CMD,4
	STS  _TCS3200_CMD,R30
	STS  _TCS3200_CMD+1,R31
; 0000 01BD     }
; 0000 01BE 
; 0000 01BF     //Switch-case version
; 0000 01C0     switch(TCS3200_CMD[0])
_0x60:
	RCALL SUBOPT_0xE
; 0000 01C1     {
; 0000 01C2         case TCS3200_CMD_SEND_RAW:{
	CPI  R30,LOW(0x41)
	LDI  R26,HIGH(0x41)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x64
; 0000 01C3 ////                                TCS3200_Sampling();
; 0000 01C4                                     Send_UART(COMMAND_FLAG_A);
	RCALL SUBOPT_0xF
; 0000 01C5                                     Send_UART(COMMAND_FLAG_B);
; 0000 01C6                                     Send_UART(RAW_VAL_FLAG);
; 0000 01C7 
; 0000 01C8                                     //RED FILTER RAW VALUE
; 0000 01C9                                     MULTIPLY_COUNTER=0;
	RCALL SUBOPT_0x10
; 0000 01CA                                     if(MOV_AVG[TCS3200_RED]>255)
	RCALL SUBOPT_0x11
	BRLT _0x65
; 0000 01CB                                     {
; 0000 01CC                                         while( MOV_AVG[TCS3200_RED] >255)
_0x66:
	RCALL SUBOPT_0x11
	BRLT _0x68
; 0000 01CD                                         {
; 0000 01CE                                            MOV_AVG[TCS3200_RED]-=255;
	__GETW1MN _MOV_AVG,10
	RCALL SUBOPT_0x12
	__PUTW1MN _MOV_AVG,10
; 0000 01CF                                            MULTIPLY_COUNTER++;
	RCALL SUBOPT_0x13
; 0000 01D0                                         }
	RJMP _0x66
_0x68:
; 0000 01D1                                     }
; 0000 01D2                                     Send_UART(MULTIPLY_COUNTER);
_0x65:
	RCALL SUBOPT_0x14
; 0000 01D3                                     Send_UART(MOV_AVG[TCS3200_RED]);
	__GETB2MN _MOV_AVG,10
	RCALL SUBOPT_0x15
; 0000 01D4 
; 0000 01D5                                     //GREEN FILTER RAW VALUE
; 0000 01D6                                     MULTIPLY_COUNTER=0;
; 0000 01D7                                     if(MOV_AVG[TCS3200_GREEN]>255)
	RCALL SUBOPT_0x16
	BRLT _0x69
; 0000 01D8                                     {
; 0000 01D9                                         while( MOV_AVG[TCS3200_GREEN] >255)
_0x6A:
	RCALL SUBOPT_0x16
	BRLT _0x6C
; 0000 01DA                                         {
; 0000 01DB                                            MOV_AVG[TCS3200_GREEN]-=255;
	__GETW1MN _MOV_AVG,12
	RCALL SUBOPT_0x12
	__PUTW1MN _MOV_AVG,12
; 0000 01DC                                            MULTIPLY_COUNTER++;
	RCALL SUBOPT_0x13
; 0000 01DD                                         }
	RJMP _0x6A
_0x6C:
; 0000 01DE                                     }
; 0000 01DF                                     Send_UART(MULTIPLY_COUNTER);
_0x69:
	RCALL SUBOPT_0x14
; 0000 01E0                                     Send_UART(MOV_AVG[TCS3200_GREEN]);
	__GETB2MN _MOV_AVG,12
	RCALL SUBOPT_0x15
; 0000 01E1 
; 0000 01E2                                     //BLUE FILTER RAW VALUE
; 0000 01E3                                     MULTIPLY_COUNTER=0;
; 0000 01E4                                     if(MOV_AVG[TCS3200_BLUE]>255)
	RCALL SUBOPT_0x17
	BRLT _0x6D
; 0000 01E5                                     {
; 0000 01E6                                         while( MOV_AVG[TCS3200_BLUE] >255)
_0x6E:
	RCALL SUBOPT_0x17
	BRLT _0x70
; 0000 01E7                                         {
; 0000 01E8                                            MOV_AVG[TCS3200_BLUE]-=255;
	__GETW1MN _MOV_AVG,14
	RCALL SUBOPT_0x12
	__PUTW1MN _MOV_AVG,14
; 0000 01E9                                            MULTIPLY_COUNTER++;
	RCALL SUBOPT_0x13
; 0000 01EA                                         }
	RJMP _0x6E
_0x70:
; 0000 01EB                                     }
; 0000 01EC                                     Send_UART(MULTIPLY_COUNTER);
_0x6D:
	RCALL SUBOPT_0x14
; 0000 01ED                                     Send_UART(MOV_AVG[TCS3200_BLUE]);
	__GETB2MN _MOV_AVG,14
	RCALL SUBOPT_0x15
; 0000 01EE 
; 0000 01EF                                     //WHITE FILTER RAW VALUE
; 0000 01F0                                     MULTIPLY_COUNTER=0;
; 0000 01F1                                     if(MOV_AVG[TCS3200_WHITE]>255)
	RCALL SUBOPT_0x18
	BRLT _0x71
; 0000 01F2                                     {
; 0000 01F3                                         while( MOV_AVG[TCS3200_WHITE] >255)
_0x72:
	RCALL SUBOPT_0x18
	BRLT _0x74
; 0000 01F4                                         {
; 0000 01F5                                            MOV_AVG[TCS3200_WHITE]-=255;
	__GETW1MN _MOV_AVG,16
	RCALL SUBOPT_0x12
	__PUTW1MN _MOV_AVG,16
; 0000 01F6                                            MULTIPLY_COUNTER++;
	RCALL SUBOPT_0x13
; 0000 01F7                                         }
	RJMP _0x72
_0x74:
; 0000 01F8                                     }
; 0000 01F9                                     Send_UART(MULTIPLY_COUNTER);
_0x71:
	RCALL SUBOPT_0x14
; 0000 01FA                                     Send_UART(MOV_AVG[TCS3200_WHITE]);
	__GETB2MN _MOV_AVG,16
	RCALL SUBOPT_0x15
; 0000 01FB 
; 0000 01FC                                     //SUM FILTER RAW VALUE
; 0000 01FD                                     MULTIPLY_COUNTER=0;
; 0000 01FE                                     if(TCS3200_TOTAL_SUM>255)
	RCALL SUBOPT_0x19
	BRLT _0x75
; 0000 01FF                                     {
; 0000 0200                                         while( TCS3200_TOTAL_SUM >255)
_0x76:
	RCALL SUBOPT_0x19
	BRLT _0x78
; 0000 0201                                         {
; 0000 0202                                            TCS3200_TOTAL_SUM-=255;
	LDS  R30,_TCS3200_TOTAL_SUM
	LDS  R31,_TCS3200_TOTAL_SUM+1
	RCALL SUBOPT_0x12
	STS  _TCS3200_TOTAL_SUM,R30
	STS  _TCS3200_TOTAL_SUM+1,R31
; 0000 0203                                            MULTIPLY_COUNTER++;
	RCALL SUBOPT_0x13
; 0000 0204                                         }
	RJMP _0x76
_0x78:
; 0000 0205                                     }
; 0000 0206                                     Send_UART(MULTIPLY_COUNTER);
_0x75:
	RCALL SUBOPT_0x14
; 0000 0207                                     Send_UART(TCS3200_TOTAL_SUM);
	LDS  R26,_TCS3200_TOTAL_SUM
	RCALL _Send_UART
; 0000 0208 
; 0000 0209                                 }break;
	RJMP _0x63
; 0000 020A 
; 0000 020B 
; 0000 020C         case TRACER_CMD_SEND_RAW:{
_0x64:
	CPI  R30,LOW(0x42)
	LDI  R26,HIGH(0x42)
	CPC  R31,R26
	BRNE _0x79
; 0000 020D                                         Tracer_GetRule();
	RCALL _Tracer_GetRule
; 0000 020E                                         Send_UART(COMMAND_FLAG_A);
	RCALL SUBOPT_0xF
; 0000 020F                                         Send_UART(COMMAND_FLAG_B);
; 0000 0210                                         Send_UART(RAW_VAL_FLAG);
; 0000 0211                                         Send_UART(TRACER[FRONT]);
	LDS  R26,_TRACER
	RCALL _Send_UART
; 0000 0212                                         Send_UART(TRACER[MIDDLE]);
	__GETB2MN _TRACER,2
	RCALL _Send_UART
; 0000 0213                                         Send_UART(TRACER[REAR]);
	__GETB2MN _TRACER,4
	RCALL _Send_UART
; 0000 0214                                         Send_UART(TRACER[FRONT_2]);
	__GETB2MN _TRACER,6
	RCALL _Send_UART
; 0000 0215                                         Send_UART(TRACER[MIDDLE_2]);
	__GETB2MN _TRACER,8
	RCALL _Send_UART
; 0000 0216                                         Send_UART(TRACER[REAR_2]);
	__GETB2MN _TRACER,10
	RCALL SUBOPT_0x1A
; 0000 0217                                         Send_UART(TRACER_STAT);             //yang akan dirubah tracer stat
; 0000 0218                                         Send_UART(TRACER_THRESHOLD_UP);
	LDS  R26,_TRACER_THRESHOLD_UP
	RCALL _Send_UART
; 0000 0219                                         Send_UART(TRACER_THRESHOLD_DOWN);
	LDS  R26,_TRACER_THRESHOLD_DOWN
	RCALL _Send_UART
; 0000 021A 
; 0000 021B                                 }break;
	RJMP _0x63
; 0000 021C 
; 0000 021D         case HYBRID_CMD_SEND_CONCLUSION:
_0x79:
	CPI  R30,LOW(0x43)
	LDI  R26,HIGH(0x43)
	CPC  R31,R26
	BRNE _0x7A
; 0000 021E                                     {
; 0000 021F                                         Tracer_GetRule();
	RCALL SUBOPT_0x1B
; 0000 0220                                         //TCS3200_GetRule();
; 0000 0221                                         Send_UART(COMMAND_FLAG_A);
; 0000 0222                                         Send_UART(COMMAND_FLAG_B);
; 0000 0223                                         Send_UART(DETECTED_COLOUR);
	MOV  R26,R4
	RCALL SUBOPT_0x1A
; 0000 0224                                         Send_UART(TRACER_STAT);
; 0000 0225 //                                        Send_UART(TRACER[FRONT]);
; 0000 0226 //                                        Send_UART(TRACER[MIDDLE]);
; 0000 0227 //                                        Send_UART(TRACER[REAR]);
; 0000 0228 
; 0000 0229                                     }break;
	RJMP _0x63
; 0000 022A         case CMD_GET_TCS3200            :
_0x7A:
	CPI  R30,LOW(0x52)
	LDI  R26,HIGH(0x52)
	CPC  R31,R26
	BRNE _0x7B
; 0000 022B                                     {
; 0000 022C //                                        TCS3200_GetRule();
; 0000 022D                                         Send_UART(COMMAND_FLAG_A);
	LDS  R26,_COMMAND_FLAG_A
	RCALL _Send_UART
; 0000 022E                                         Send_UART(COMMAND_FLAG_B);
	LDS  R26,_COMMAND_FLAG_B
	RCALL _Send_UART
; 0000 022F                                         Send_UART(DETECTED_COLOUR);
	MOV  R26,R4
	RCALL _Send_UART
; 0000 0230                                         Send_UART(0x00);
	LDI  R26,LOW(0)
	RCALL _Send_UART
; 0000 0231                                     }break;
	RJMP _0x63
; 0000 0232         case CMD_GET_TRACER            :
_0x7B:
	CPI  R30,LOW(0x53)
	LDI  R26,HIGH(0x53)
	CPC  R31,R26
	BRNE _0x7C
; 0000 0233                                     {
; 0000 0234                                         Tracer_GetRule();
	RCALL SUBOPT_0x1B
; 0000 0235                                         Send_UART(COMMAND_FLAG_A);
; 0000 0236                                         Send_UART(COMMAND_FLAG_B);
; 0000 0237                                         Send_UART(0x00);
	LDI  R26,LOW(0)
	RCALL SUBOPT_0x1A
; 0000 0238                                         Send_UART(TRACER_STAT);
; 0000 0239                                     }break;
	RJMP _0x63
; 0000 023A 
; 0000 023B         case TCS3200_CMD_SAVE_EEPROM:
_0x7C:
	CPI  R30,LOW(0x5A)
	LDI  R26,HIGH(0x5A)
	CPC  R31,R26
	BRNE _0x7D
; 0000 023C                                     {
; 0000 023D                                         TCS3200Read();
	RCALL _TCS3200Read
; 0000 023E                                         EEPROM_A= TCS3200_Pulse_G;
	RCALL SUBOPT_0x8
	LDI  R26,LOW(_EEPROM_A)
	LDI  R27,HIGH(_EEPROM_A)
	RCALL __EEPROMWRW
; 0000 023F                                         EEPROM_B= TCS3200_Pulse_B;
	RCALL SUBOPT_0x9
	LDI  R26,LOW(_EEPROM_B)
	LDI  R27,HIGH(_EEPROM_B)
	RCALL __EEPROMWRW
; 0000 0240                                         EEPROM_C= TCS3200_Pulse_W;
	RCALL SUBOPT_0xA
	LDI  R26,LOW(_EEPROM_C)
	LDI  R27,HIGH(_EEPROM_C)
	RCALL __EEPROMWRW
; 0000 0241                                         EEPROM_D= TCS3200_Pulse_Sum;
	LDS  R30,_TCS3200_Pulse_Sum
	LDS  R31,_TCS3200_Pulse_Sum+1
	LDI  R26,LOW(_EEPROM_D)
	LDI  R27,HIGH(_EEPROM_D)
	RJMP _0x149
; 0000 0242                                     }break;
; 0000 0243 
; 0000 0244         case HYBRID_CMD_SEND_THRESHOLD:
_0x7D:
	CPI  R30,LOW(0x58)
	LDI  R26,HIGH(0x58)
	CPC  R31,R26
	BRNE _0x7E
; 0000 0245                                     {
; 0000 0246                                         Send_Threshold();
	RCALL _Send_Threshold
; 0000 0247                                     }break;
	RJMP _0x63
; 0000 0248 
; 0000 0249         case TCS3200_CALIBRATE_WHITE:
_0x7E:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0x7F
; 0000 024A                                     {
; 0000 024B //                                        TCS3200_Sampling();
; 0000 024C                                         Threshold_White= TCS3200_TOTAL_SUM;
	__GETWRMN 6,7,0,_TCS3200_TOTAL_SUM
; 0000 024D                                     }break;
	RJMP _0x63
; 0000 024E         case TCS3200_CALIBRATE_BLACK:
_0x7F:
	CPI  R30,LOW(0x47)
	LDI  R26,HIGH(0x47)
	CPC  R31,R26
	BRNE _0x80
; 0000 024F                                     {
; 0000 0250 
; 0000 0251 //                                        TCS3200_Sampling();
; 0000 0252                                         Threshold_Black = TCS3200_TOTAL_SUM;
	__GETWRMN 8,9,0,_TCS3200_TOTAL_SUM
; 0000 0253                                     }break;
	RJMP _0x63
; 0000 0254         case TCS3200_CALIBRATE_GRAY:
_0x80:
	CPI  R30,LOW(0x48)
	LDI  R26,HIGH(0x48)
	CPC  R31,R26
	BRNE _0x81
; 0000 0255                                     {
; 0000 0256 
; 0000 0257 //                                        TCS3200_Sampling();
; 0000 0258                                         Threshold_Gray = TCS3200_TOTAL_SUM;
	__GETWRMN 10,11,0,_TCS3200_TOTAL_SUM
; 0000 0259                                     }break;
	RJMP _0x63
; 0000 025A         case TCS3200_CALIBRATE_GETRULE:
_0x81:
	CPI  R30,LOW(0x49)
	LDI  R26,HIGH(0x49)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x82
; 0000 025B                                     {
; 0000 025C                                         Threshold_Diff = Threshold_White-Threshold_Gray;
	MOVW R30,R6
	SUB  R30,R10
	SBC  R31,R11
	RCALL SUBOPT_0x1C
; 0000 025D 
; 0000 025E                                         if(Threshold_Diff>1400)
	CPI  R26,LOW(0x579)
	LDI  R30,HIGH(0x579)
	CPC  R27,R30
	BRLT _0x83
; 0000 025F                                         {
; 0000 0260                                             Threshold_BW = Threshold_Gray + 1390;
	MOVW R30,R10
	SUBI R30,LOW(-1390)
	SBCI R31,HIGH(-1390)
	RJMP _0x14A
; 0000 0261                                         }
; 0000 0262                                         else if(Threshold_Diff>1350)
_0x83:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x547)
	LDI  R30,HIGH(0x547)
	CPC  R27,R30
	BRLT _0x85
; 0000 0263                                         {
; 0000 0264                                             Threshold_BW = Threshold_Gray + 1340;
	MOVW R30,R10
	SUBI R30,LOW(-1340)
	SBCI R31,HIGH(-1340)
	RJMP _0x14A
; 0000 0265                                         }
; 0000 0266 
; 0000 0267                                         else if(Threshold_Diff>1300)
_0x85:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x515)
	LDI  R30,HIGH(0x515)
	CPC  R27,R30
	BRLT _0x87
; 0000 0268                                         {
; 0000 0269                                             Threshold_BW = Threshold_Gray + 1290;
	MOVW R30,R10
	SUBI R30,LOW(-1290)
	SBCI R31,HIGH(-1290)
	RJMP _0x14A
; 0000 026A                                         }
; 0000 026B                                         else if(Threshold_Diff>1250)
_0x87:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x4E3)
	LDI  R30,HIGH(0x4E3)
	CPC  R27,R30
	BRLT _0x89
; 0000 026C                                         {
; 0000 026D                                             Threshold_BW = Threshold_Gray + 1240;
	MOVW R30,R10
	SUBI R30,LOW(-1240)
	SBCI R31,HIGH(-1240)
	RJMP _0x14A
; 0000 026E                                         }
; 0000 026F 
; 0000 0270                                         else if(Threshold_Diff>1200)
_0x89:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x4B1)
	LDI  R30,HIGH(0x4B1)
	CPC  R27,R30
	BRLT _0x8B
; 0000 0271                                         {
; 0000 0272                                             Threshold_BW = Threshold_Gray + 1190;
	MOVW R30,R10
	SUBI R30,LOW(-1190)
	SBCI R31,HIGH(-1190)
	RJMP _0x14A
; 0000 0273                                         }
; 0000 0274                                         else if(Threshold_Diff>1150)
_0x8B:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x47F)
	LDI  R30,HIGH(0x47F)
	CPC  R27,R30
	BRLT _0x8D
; 0000 0275                                         {
; 0000 0276                                             Threshold_BW = Threshold_Gray + 1140;
	MOVW R30,R10
	SUBI R30,LOW(-1140)
	SBCI R31,HIGH(-1140)
	RJMP _0x14A
; 0000 0277                                         }
; 0000 0278 
; 0000 0279                                         else if(Threshold_Diff>1100)
_0x8D:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x44D)
	LDI  R30,HIGH(0x44D)
	CPC  R27,R30
	BRLT _0x8F
; 0000 027A                                         {
; 0000 027B                                             Threshold_BW = Threshold_Gray + 1190;
	MOVW R30,R10
	SUBI R30,LOW(-1190)
	SBCI R31,HIGH(-1190)
	RJMP _0x14A
; 0000 027C                                         }
; 0000 027D                                         else if(Threshold_Diff>1050)
_0x8F:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x41B)
	LDI  R30,HIGH(0x41B)
	CPC  R27,R30
	BRLT _0x91
; 0000 027E                                         {
; 0000 027F                                             Threshold_BW = Threshold_Gray + 1040;
	MOVW R30,R10
	SUBI R30,LOW(-1040)
	SBCI R31,HIGH(-1040)
	RJMP _0x14A
; 0000 0280                                         }
; 0000 0281                                         else if(Threshold_Diff>1000)
_0x91:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x3E9)
	LDI  R30,HIGH(0x3E9)
	CPC  R27,R30
	BRLT _0x93
; 0000 0282                                         {
; 0000 0283                                             Threshold_BW = Threshold_Gray + 990;
	MOVW R30,R10
	SUBI R30,LOW(-990)
	SBCI R31,HIGH(-990)
	RJMP _0x14A
; 0000 0284                                         }
; 0000 0285 
; 0000 0286                                         else if(Threshold_Diff>950)
_0x93:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x3B7)
	LDI  R30,HIGH(0x3B7)
	CPC  R27,R30
	BRLT _0x95
; 0000 0287                                         {
; 0000 0288                                             Threshold_BW = Threshold_Gray + 940;
	MOVW R30,R10
	SUBI R30,LOW(-940)
	SBCI R31,HIGH(-940)
	RJMP _0x14A
; 0000 0289                                         }
; 0000 028A 
; 0000 028B                                         else if(Threshold_Diff>900)
_0x95:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x385)
	LDI  R30,HIGH(0x385)
	CPC  R27,R30
	BRLT _0x97
; 0000 028C                                         {
; 0000 028D                                             Threshold_BW = Threshold_Gray + 890;
	MOVW R30,R10
	SUBI R30,LOW(-890)
	SBCI R31,HIGH(-890)
	RJMP _0x14A
; 0000 028E                                         }
; 0000 028F 
; 0000 0290                                         else if(Threshold_Diff>850)
_0x97:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x353)
	LDI  R30,HIGH(0x353)
	CPC  R27,R30
	BRLT _0x99
; 0000 0291                                         {
; 0000 0292                                             Threshold_BW = Threshold_Gray + 840;
	MOVW R30,R10
	SUBI R30,LOW(-840)
	SBCI R31,HIGH(-840)
	RJMP _0x14A
; 0000 0293                                         }
; 0000 0294 
; 0000 0295                                         else if(Threshold_Diff>800)
_0x99:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x321)
	LDI  R30,HIGH(0x321)
	CPC  R27,R30
	BRLT _0x9B
; 0000 0296                                         {
; 0000 0297                                             Threshold_BW = Threshold_Gray + 790;
	MOVW R30,R10
	SUBI R30,LOW(-790)
	SBCI R31,HIGH(-790)
	RJMP _0x14A
; 0000 0298                                         }
; 0000 0299                                         else if(Threshold_Diff>700)
_0x9B:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x2BD)
	LDI  R30,HIGH(0x2BD)
	CPC  R27,R30
	BRLT _0x9D
; 0000 029A                                         {
; 0000 029B                                             Threshold_BW = Threshold_Gray + 690;
	MOVW R30,R10
	SUBI R30,LOW(-690)
	SBCI R31,HIGH(-690)
	RJMP _0x14A
; 0000 029C                                         }
; 0000 029D                                         else if(Threshold_Diff>600)
_0x9D:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x259)
	LDI  R30,HIGH(0x259)
	CPC  R27,R30
	BRLT _0x9F
; 0000 029E                                         {
; 0000 029F                                             Threshold_BW = Threshold_Gray + 590;
	MOVW R30,R10
	SUBI R30,LOW(-590)
	SBCI R31,HIGH(-590)
	RJMP _0x14A
; 0000 02A0                                         }
; 0000 02A1                                         else if(Threshold_Diff>500)
_0x9F:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x1F5)
	LDI  R30,HIGH(0x1F5)
	CPC  R27,R30
	BRLT _0xA1
; 0000 02A2                                         {
; 0000 02A3                                             Threshold_BW = Threshold_Gray + 490;
	MOVW R30,R10
	SUBI R30,LOW(-490)
	SBCI R31,HIGH(-490)
	RJMP _0x14A
; 0000 02A4                                         }
; 0000 02A5                                         else if(Threshold_Diff>450)
_0xA1:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x1C3)
	LDI  R30,HIGH(0x1C3)
	CPC  R27,R30
	BRLT _0xA3
; 0000 02A6                                         {
; 0000 02A7                                             Threshold_BW = Threshold_Gray + 440;
	MOVW R30,R10
	SUBI R30,LOW(-440)
	SBCI R31,HIGH(-440)
	RJMP _0x14A
; 0000 02A8                                         }
; 0000 02A9                                         else if(Threshold_Diff>400)
_0xA3:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x191)
	LDI  R30,HIGH(0x191)
	CPC  R27,R30
	BRLT _0xA5
; 0000 02AA                                         {
; 0000 02AB                                             Threshold_BW = Threshold_Gray + 390;
	MOVW R30,R10
	SUBI R30,LOW(-390)
	SBCI R31,HIGH(-390)
	RJMP _0x14A
; 0000 02AC                                         }
; 0000 02AD                                         else if(Threshold_Diff>350)
_0xA5:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x15F)
	LDI  R30,HIGH(0x15F)
	CPC  R27,R30
	BRLT _0xA7
; 0000 02AE                                         {
; 0000 02AF                                             Threshold_BW = Threshold_Gray + 340;
	MOVW R30,R10
	SUBI R30,LOW(-340)
	SBCI R31,HIGH(-340)
	RJMP _0x14A
; 0000 02B0                                         }
; 0000 02B1                                         else if(Threshold_Diff>300)
_0xA7:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x12D)
	LDI  R30,HIGH(0x12D)
	CPC  R27,R30
	BRLT _0xA9
; 0000 02B2                                         {
; 0000 02B3                                             Threshold_BW = Threshold_Gray + 290;
	MOVW R30,R10
	SUBI R30,LOW(-290)
	SBCI R31,HIGH(-290)
	RJMP _0x14A
; 0000 02B4                                         }
; 0000 02B5                                         else if(Threshold_Diff>250)
_0xA9:
	RCALL SUBOPT_0x1E
	BRLT _0xAB
; 0000 02B6                                         {
; 0000 02B7                                             Threshold_BW = Threshold_Gray + 240;
	MOVW R30,R10
	SUBI R30,LOW(-240)
	SBCI R31,HIGH(-240)
	RJMP _0x14A
; 0000 02B8                                         }
; 0000 02B9                                         else if(Threshold_Diff>200)
_0xAB:
	RCALL SUBOPT_0x1F
	BRLT _0xAD
; 0000 02BA                                         {
; 0000 02BB                                             Threshold_BW = Threshold_Gray + 190;
	MOVW R30,R10
	SUBI R30,LOW(-190)
	SBCI R31,HIGH(-190)
	RJMP _0x14A
; 0000 02BC                                         }
; 0000 02BD                                         else if(Threshold_Diff>150)
_0xAD:
	RCALL SUBOPT_0x20
	BRLT _0xAF
; 0000 02BE                                         {
; 0000 02BF                                             Threshold_BW = Threshold_Gray + 140;
	MOVW R30,R10
	SUBI R30,LOW(-140)
	SBCI R31,HIGH(-140)
	RJMP _0x14A
; 0000 02C0                                         }
; 0000 02C1                                         else if(Threshold_Diff>100)
_0xAF:
	RCALL SUBOPT_0x21
	BRLT _0xB1
; 0000 02C2                                         {
; 0000 02C3                                             Threshold_BW = Threshold_Gray + 90;
	MOVW R30,R10
	SUBI R30,LOW(-90)
	SBCI R31,HIGH(-90)
	RJMP _0x14A
; 0000 02C4                                         }
; 0000 02C5                                         else if(Threshold_Diff>50)
_0xB1:
	RCALL SUBOPT_0x1D
	SBIW R26,51
	BRLT _0xB3
; 0000 02C6                                         {
; 0000 02C7                                             Threshold_BW = Threshold_Gray + 40;
	MOVW R30,R10
	ADIW R30,40
	RJMP _0x14A
; 0000 02C8                                         }
; 0000 02C9                                         else
_0xB3:
; 0000 02CA                                         {
; 0000 02CB                                             Threshold_BW = Threshold_Gray + 30;
	MOVW R30,R10
	ADIW R30,30
_0x14A:
	STS  _Threshold_BW,R30
	STS  _Threshold_BW+1,R31
; 0000 02CC                                         }
; 0000 02CD 
; 0000 02CE 
; 0000 02CF                                         Threshold_Diff= Threshold_Gray - Threshold_Black;
	MOVW R30,R10
	SUB  R30,R8
	SBC  R31,R9
	RCALL SUBOPT_0x1C
; 0000 02D0 
; 0000 02D1 //                                        if(Threshold_Diff>400)
; 0000 02D2 //                                        {
; 0000 02D3 //                                            Threshold_BG = Threshold_Black + 375;
; 0000 02D4 //                                        }
; 0000 02D5 //                                        if(Threshold_Diff>375)
; 0000 02D6 //                                        {
; 0000 02D7 //                                            Threshold_BG = Threshold_Black + 350;
; 0000 02D8 //                                        }
; 0000 02D9 //                                        else if(Threshold_Diff>350)
; 0000 02DA //                                        {
; 0000 02DB //                                            Threshold_BG = Threshold_Black + 325;
; 0000 02DC //                                        }
; 0000 02DD 
; 0000 02DE //======COMMENT 03-10-2016======//
; 0000 02DF /*
; 0000 02E0                                         if(Threshold_Diff>310)
; 0000 02E1                                         {
; 0000 02E2                                             Threshold_BG = Threshold_Black + 300;
; 0000 02E3                                         }
; 0000 02E4 
; 0000 02E5                                         else if(Threshold_Diff>300)
; 0000 02E6                                         {
; 0000 02E7                                             Threshold_BG = Threshold_Black + 290;
; 0000 02E8                                         }
; 0000 02E9 */
; 0000 02EA 
; 0000 02EB                                        // else
; 0000 02EC                                         if(Threshold_Diff>290)
	CPI  R26,LOW(0x123)
	LDI  R30,HIGH(0x123)
	CPC  R27,R30
	BRLT _0xB5
; 0000 02ED                                         {
; 0000 02EE                                             Threshold_BG = Threshold_Black + 280;
	MOVW R30,R8
	SUBI R30,LOW(-280)
	SBCI R31,HIGH(-280)
	RJMP _0x14B
; 0000 02EF                                         }
; 0000 02F0 
; 0000 02F1 
; 0000 02F2                                         else if(Threshold_Diff>280)
_0xB5:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x119)
	LDI  R30,HIGH(0x119)
	CPC  R27,R30
	BRLT _0xB7
; 0000 02F3                                         {
; 0000 02F4                                             Threshold_BG = Threshold_Black + 270;
	MOVW R30,R8
	SUBI R30,LOW(-270)
	SBCI R31,HIGH(-270)
	RJMP _0x14B
; 0000 02F5                                         }
; 0000 02F6 
; 0000 02F7                                         else if(Threshold_Diff>270)
_0xB7:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x10F)
	LDI  R30,HIGH(0x10F)
	CPC  R27,R30
	BRLT _0xB9
; 0000 02F8                                         {
; 0000 02F9                                             Threshold_BG = Threshold_Black + 260;
	MOVW R30,R8
	SUBI R30,LOW(-260)
	SBCI R31,HIGH(-260)
	RJMP _0x14B
; 0000 02FA                                         }
; 0000 02FB 
; 0000 02FC                                         else if(Threshold_Diff>260)
_0xB9:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x105)
	LDI  R30,HIGH(0x105)
	CPC  R27,R30
	BRLT _0xBB
; 0000 02FD                                         {
; 0000 02FE                                             Threshold_BG = Threshold_Black + 250;
	MOVW R30,R8
	SUBI R30,LOW(-250)
	SBCI R31,HIGH(-250)
	RJMP _0x14B
; 0000 02FF                                         }
; 0000 0300 
; 0000 0301                                         else if(Threshold_Diff>250)
_0xBB:
	RCALL SUBOPT_0x1E
	BRLT _0xBD
; 0000 0302                                         {
; 0000 0303                                             Threshold_BG = Threshold_Black + 225;
	MOVW R30,R8
	SUBI R30,LOW(-225)
	SBCI R31,HIGH(-225)
	RJMP _0x14B
; 0000 0304                                         }
; 0000 0305                                         else if(Threshold_Diff>225)
_0xBD:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0xE2)
	LDI  R30,HIGH(0xE2)
	CPC  R27,R30
	BRLT _0xBF
; 0000 0306                                         {
; 0000 0307                                             Threshold_BG = Threshold_Black + 200;
	MOVW R30,R8
	SUBI R30,LOW(-200)
	SBCI R31,HIGH(-200)
	RJMP _0x14B
; 0000 0308                                         }
; 0000 0309 
; 0000 030A                                         else if(Threshold_Diff>200)
_0xBF:
	RCALL SUBOPT_0x1F
	BRLT _0xC1
; 0000 030B                                         {
; 0000 030C                                             Threshold_BG = Threshold_Black + 175;
	MOVW R30,R8
	SUBI R30,LOW(-175)
	SBCI R31,HIGH(-175)
	RJMP _0x14B
; 0000 030D                                         }
; 0000 030E                                         else if(Threshold_Diff>175)
_0xC1:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0xB0)
	LDI  R30,HIGH(0xB0)
	CPC  R27,R30
	BRLT _0xC3
; 0000 030F                                         {
; 0000 0310                                             Threshold_BG = Threshold_Black + 150;
	MOVW R30,R8
	SUBI R30,LOW(-150)
	SBCI R31,HIGH(-150)
	RJMP _0x14B
; 0000 0311                                         }
; 0000 0312 
; 0000 0313                                         else if(Threshold_Diff>150)
_0xC3:
	RCALL SUBOPT_0x20
	BRLT _0xC5
; 0000 0314                                         {
; 0000 0315                                             Threshold_BG = Threshold_Black + 125;
	MOVW R30,R8
	SUBI R30,LOW(-125)
	SBCI R31,HIGH(-125)
	RJMP _0x14B
; 0000 0316                                         }
; 0000 0317                                         else if(Threshold_Diff>125)
_0xC5:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x7E)
	LDI  R30,HIGH(0x7E)
	CPC  R27,R30
	BRLT _0xC7
; 0000 0318                                         {
; 0000 0319                                             Threshold_BG = Threshold_Black + 100;
	MOVW R30,R8
	SUBI R30,LOW(-100)
	SBCI R31,HIGH(-100)
	RJMP _0x14B
; 0000 031A                                         }
; 0000 031B                                         else if(Threshold_Diff>100)
_0xC7:
	RCALL SUBOPT_0x21
	BRLT _0xC9
; 0000 031C                                         {
; 0000 031D                                             Threshold_BG = Threshold_Black + 75;
	MOVW R30,R8
	SUBI R30,LOW(-75)
	SBCI R31,HIGH(-75)
	RJMP _0x14B
; 0000 031E                                         }
; 0000 031F                                         else if(Threshold_Diff>75)
_0xC9:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x4C)
	LDI  R30,HIGH(0x4C)
	CPC  R27,R30
	BRLT _0xCB
; 0000 0320                                         {
; 0000 0321                                             Threshold_BG = Threshold_Black + 50;
	MOVW R30,R8
	ADIW R30,50
	RJMP _0x14B
; 0000 0322                                         }
; 0000 0323                                         else if(Threshold_Diff>50)
_0xCB:
	RCALL SUBOPT_0x1D
	SBIW R26,51
; 0000 0324                                         {
; 0000 0325                                             Threshold_BG = Threshold_Black + 25;
; 0000 0326                                         }
; 0000 0327                                         else
; 0000 0328                                         {
; 0000 0329                                             Threshold_BG = Threshold_Black + 25;
_0x14C:
	MOVW R30,R8
	ADIW R30,25
_0x14B:
	STS  _Threshold_BG,R30
	STS  _Threshold_BG+1,R31
; 0000 032A                                         }
; 0000 032B                                     }break;
	RJMP _0x63
; 0000 032C 
; 0000 032D             case TRACER_CALIBRATE_GRAY:
_0x82:
	CPI  R30,LOW(0x4A)
	LDI  R26,HIGH(0x4A)
	CPC  R31,R26
	BRNE _0xCF
; 0000 032E                                     {
; 0000 032F                                         Tracer_GetData_Gray();
	RCALL _Tracer_GetData_Gray
; 0000 0330                                     }break;
	RJMP _0x63
; 0000 0331 
; 0000 0332             case TRACER_CALIBRATE_WHITE:
_0xCF:
	CPI  R30,LOW(0x4B)
	LDI  R26,HIGH(0x4B)
	CPC  R31,R26
	BRNE _0xD0
; 0000 0333                                     {
; 0000 0334                                         Tracer_GetData_White();
	RCALL _Tracer_GetData_White
; 0000 0335                                     }break;
	RJMP _0x63
; 0000 0336 
; 0000 0337             case TRACER_CALIBRATE_BLACK:
_0xD0:
	CPI  R30,LOW(0x4D)
	LDI  R26,HIGH(0x4D)
	CPC  R31,R26
	BRNE _0xD1
; 0000 0338                                     {
; 0000 0339                                         Tracer_GetData_Black();
	RCALL _Tracer_GetData_Black
; 0000 033A                                     }break;
	RJMP _0x63
; 0000 033B 
; 0000 033C             case TRACER_CALIBRATE_GETRULE:
_0xD1:
	CPI  R30,LOW(0x4C)
	LDI  R26,HIGH(0x4C)
	CPC  R31,R26
	BRNE _0xD2
; 0000 033D                                     {
; 0000 033E                                         Tracer_Calibrate_GetRule();
	RCALL _Tracer_Calibrate_GetRule
; 0000 033F                                     }break;
	RJMP _0x63
; 0000 0340             case TRACER_COPY_DATA :
_0xD2:
	CPI  R30,LOW(0xFE)
	LDI  R26,HIGH(0xFE)
	CPC  R31,R26
	BRNE _0x63
; 0000 0341                                     {
; 0000 0342                                         EEPROM_A = getchar();
	RCALL _getchar
	LDI  R26,LOW(_EEPROM_A)
	LDI  R27,HIGH(_EEPROM_A)
	RCALL SUBOPT_0xB
	RCALL __EEPROMWRW
; 0000 0343                                         EEPROM_B = getchar();
	RCALL _getchar
	LDI  R26,LOW(_EEPROM_B)
	LDI  R27,HIGH(_EEPROM_B)
	RCALL SUBOPT_0xB
_0x149:
	RCALL __EEPROMWRW
; 0000 0344                                     }break;
; 0000 0345   }
_0x63:
; 0000 0346 }
	RET
;
;int Tracer_Sampling(int MODE)
; 0000 0349 {
_Tracer_Sampling:
; 0000 034A 
; 0000 034B     int counter=0;
; 0000 034C     int TRACER_TEMP[5]={0,0,0,0,0};
; 0000 034D     int TRACER_SUM=0;
; 0000 034E 
; 0000 034F 
; 0000 0350     switch(MODE)
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,10
	LDI  R24,10
	RCALL SUBOPT_0x22
	LDI  R30,LOW(_0xD4*2)
	LDI  R31,HIGH(_0xD4*2)
	RCALL __INITLOCB
	RCALL __SAVELOCR4
;	MODE -> Y+14
;	counter -> R16,R17
;	TRACER_TEMP -> Y+4
;	TRACER_SUM -> R18,R19
	RCALL SUBOPT_0x23
	__GETWRN 18,19,0
	LDD  R30,Y+14
	LDD  R31,Y+14+1
; 0000 0351     {
; 0000 0352         case 0: {
	SBIW R30,0
	BRNE _0xD8
; 0000 0353                     for(counter=0;counter<=4;counter++)
	RCALL SUBOPT_0x23
_0xDA:
	RCALL SUBOPT_0x24
	BRGE _0xDB
; 0000 0354                     {
; 0000 0355                         TRACER_TEMP[counter]= read_adc(2);
	RCALL SUBOPT_0x25
	PUSH R31
	PUSH R30
	LDI  R26,LOW(2)
	RCALL _read_adc
	POP  R26
	POP  R27
	RCALL SUBOPT_0x26
; 0000 0356                     }
	RCALL SUBOPT_0x27
	RJMP _0xDA
_0xDB:
; 0000 0357 
; 0000 0358                     TRACER_SUM= TRACER_TEMP[0]+TRACER_TEMP[1]+TRACER_TEMP[2]+TRACER_TEMP[3]+TRACER_TEMP[4];
	RCALL SUBOPT_0x28
; 0000 0359                     TRACER[FRONT]=TRACER_SUM/5;
	STS  _TRACER,R30
	STS  _TRACER+1,R31
; 0000 035A 
; 0000 035B                     if(TRACER[FRONT]>=TRACER_THRESHOLD_UP)
	RCALL SUBOPT_0x29
	RCALL SUBOPT_0x2A
	RCALL SUBOPT_0x2B
	BRLT _0xDC
; 0000 035C                     {
; 0000 035D //                        printf("TRACER FRONT WHITE \r");                         !!!!!!!!    diganti 3 if else tiap warna  !!!!!!!!!
; 0000 035E                         TRACER_SECTION[FRONT]= TRACER_WHITE;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RJMP _0x14D
; 0000 035F                     }
; 0000 0360 
; 0000 0361                     else if(TRACER[FRONT]<=TRACER_THRESHOLD_DOWN)
_0xDC:
	RCALL SUBOPT_0x2C
	RCALL SUBOPT_0x2A
	RCALL SUBOPT_0xD
	BRLT _0xDE
; 0000 0362                     {
; 0000 0363 //                        printf("TRACER FRONT BLACK \r");
; 0000 0364                         TRACER_SECTION[FRONT]= TRACER_BLACK;
	LDI  R30,LOW(0)
	STS  _TRACER_SECTION,R30
	STS  _TRACER_SECTION+1,R30
; 0000 0365                     }
; 0000 0366                     else
	RJMP _0xDF
_0xDE:
; 0000 0367                     {
; 0000 0368 //                        printf("TRACER FRONT GRAY \r");
; 0000 0369                         TRACER_SECTION[FRONT]= TRACER_GRAY;
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
_0x14D:
	STS  _TRACER_SECTION,R30
	STS  _TRACER_SECTION+1,R31
; 0000 036A                     }
_0xDF:
; 0000 036B                     return TRACER[FRONT];
	LDS  R30,_TRACER
	LDS  R31,_TRACER+1
	RJMP _0x20A0002
; 0000 036C                 }break;
; 0000 036D 
; 0000 036E         case 1: {
_0xD8:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0xE0
; 0000 036F 
; 0000 0370                     for(counter=0;counter<=4;counter++)
	RCALL SUBOPT_0x23
_0xE2:
	RCALL SUBOPT_0x24
	BRGE _0xE3
; 0000 0371                     {
; 0000 0372                         TRACER_TEMP[counter]= read_adc(1);
	RCALL SUBOPT_0x25
	PUSH R31
	PUSH R30
	LDI  R26,LOW(1)
	RCALL _read_adc
	POP  R26
	POP  R27
	RCALL SUBOPT_0x26
; 0000 0373                     }
	RCALL SUBOPT_0x27
	RJMP _0xE2
_0xE3:
; 0000 0374 
; 0000 0375                     TRACER_SUM= TRACER_TEMP[0]+TRACER_TEMP[1]+TRACER_TEMP[2]+TRACER_TEMP[3]+TRACER_TEMP[4];
	RCALL SUBOPT_0x28
; 0000 0376                     TRACER[MIDDLE]=TRACER_SUM/5;
	__PUTW1MN _TRACER,2
; 0000 0377 
; 0000 0378                     if(TRACER[MIDDLE]>=TRACER_THRESHOLD_UP)
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x2E
	BRLT _0xE4
; 0000 0379                     {
; 0000 037A //                        printf("TRACER FRONT WHITE \r");
; 0000 037B                         TRACER_SECTION[MIDDLE]= TRACER_WHITE;
	__POINTW1MN _TRACER_SECTION,2
	RCALL SUBOPT_0x2F
	RJMP _0x14E
; 0000 037C                     }
; 0000 037D 
; 0000 037E                     else if(TRACER[MIDDLE]<=TRACER_THRESHOLD_DOWN)
_0xE4:
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x30
	BRLT _0xE6
; 0000 037F                     {
; 0000 0380 //                        printf("TRACER FRONT BLACK \r");
; 0000 0381                         TRACER_SECTION[MIDDLE]= TRACER_BLACK;
	__POINTW1MN _TRACER_SECTION,2
	RCALL SUBOPT_0x22
	RJMP _0x14E
; 0000 0382                     }
; 0000 0383                     else
_0xE6:
; 0000 0384                     {
; 0000 0385 //                        printf("TRACER FRONT GRAY \r");
; 0000 0386                         TRACER_SECTION[MIDDLE]= TRACER_GRAY;
	__POINTW1MN _TRACER_SECTION,2
	RCALL SUBOPT_0x31
_0x14E:
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 0387                     }
; 0000 0388                     return TRACER[MIDDLE];
	__GETW1MN _TRACER,2
	RJMP _0x20A0002
; 0000 0389                 }break;
; 0000 038A 
; 0000 038B         case 2: {
_0xE0:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0xE8
; 0000 038C                     for(counter=0;counter<=4;counter++)
	RCALL SUBOPT_0x23
_0xEA:
	RCALL SUBOPT_0x24
	BRGE _0xEB
; 0000 038D                     {
; 0000 038E                         TRACER_TEMP[counter]= read_adc(0);
	RCALL SUBOPT_0x25
	PUSH R31
	PUSH R30
	LDI  R26,LOW(0)
	RCALL _read_adc
	POP  R26
	POP  R27
	RCALL SUBOPT_0x26
; 0000 038F                     }
	RCALL SUBOPT_0x27
	RJMP _0xEA
_0xEB:
; 0000 0390 
; 0000 0391                     TRACER_SUM= TRACER_TEMP[0]+TRACER_TEMP[1]+TRACER_TEMP[2]+TRACER_TEMP[3]+TRACER_TEMP[4];
	RCALL SUBOPT_0x28
; 0000 0392                     TRACER[REAR]=TRACER_SUM/5;
	__PUTW1MN _TRACER,4
; 0000 0393 
; 0000 0394                     if(TRACER[REAR]>=TRACER_THRESHOLD_UP)
	RCALL SUBOPT_0x32
	RCALL SUBOPT_0x2E
	BRLT _0xEC
; 0000 0395                     {
; 0000 0396 //                        printf("TRACER FRONT WHITE \r");
; 0000 0397                         TRACER_SECTION[REAR]= TRACER_WHITE;
	__POINTW1MN _TRACER_SECTION,4
	RCALL SUBOPT_0x2F
	RJMP _0x14F
; 0000 0398                     }
; 0000 0399 
; 0000 039A                     else if(TRACER[REAR]<=TRACER_THRESHOLD_DOWN)
_0xEC:
	RCALL SUBOPT_0x32
	RCALL SUBOPT_0x30
	BRLT _0xEE
; 0000 039B                     {
; 0000 039C //                        printf("TRACER FRONT BLACK \r");
; 0000 039D                         TRACER_SECTION[REAR]= TRACER_BLACK;
	__POINTW1MN _TRACER_SECTION,4
	RCALL SUBOPT_0x22
	RJMP _0x14F
; 0000 039E                     }
; 0000 039F                     else
_0xEE:
; 0000 03A0                     {
; 0000 03A1 //                        printf("TRACER FRONT GRAY \r");
; 0000 03A2                         TRACER_SECTION[REAR]= TRACER_GRAY;
	__POINTW1MN _TRACER_SECTION,4
	RCALL SUBOPT_0x31
_0x14F:
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 03A3                     }
; 0000 03A4                     return TRACER[REAR];
	__GETW1MN _TRACER,4
	RJMP _0x20A0002
; 0000 03A5                 }break;
; 0000 03A6 
; 0000 03A7         case 3: {
_0xE8:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0xF0
; 0000 03A8                     for(counter=0;counter<=4;counter++)
	RCALL SUBOPT_0x23
_0xF2:
	RCALL SUBOPT_0x24
	BRGE _0xF3
; 0000 03A9                     {
; 0000 03AA                         TRACER_TEMP[counter]= read_adc(5);
	RCALL SUBOPT_0x25
	PUSH R31
	PUSH R30
	LDI  R26,LOW(5)
	RCALL _read_adc
	POP  R26
	POP  R27
	RCALL SUBOPT_0x26
; 0000 03AB                     }
	RCALL SUBOPT_0x27
	RJMP _0xF2
_0xF3:
; 0000 03AC 
; 0000 03AD                     TRACER_SUM= TRACER_TEMP[0]+TRACER_TEMP[1]+TRACER_TEMP[2]+TRACER_TEMP[3]+TRACER_TEMP[4];
	RCALL SUBOPT_0x28
; 0000 03AE                     TRACER[FRONT_2]=TRACER_SUM/5;
	__PUTW1MN _TRACER,6
; 0000 03AF 
; 0000 03B0                     if(TRACER[FRONT_2]>=TRACER_THRESHOLD_UP)
	RCALL SUBOPT_0x33
	RCALL SUBOPT_0x2E
	BRLT _0xF4
; 0000 03B1                     {
; 0000 03B2 //                        printf("TRACER FRONT WHITE \r");                         !!!!!!!!    diganti 3 if else tiap warna  !!!!!!!!!
; 0000 03B3                         TRACER_SECTION[FRONT]= TRACER_WHITE;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _TRACER_SECTION,R30
	STS  _TRACER_SECTION+1,R31
; 0000 03B4                     }
; 0000 03B5 
; 0000 03B6                     else if(TRACER[FRONT_2]<=TRACER_THRESHOLD_DOWN)
	RJMP _0xF5
_0xF4:
	RCALL SUBOPT_0x33
	RCALL SUBOPT_0x30
	BRLT _0xF6
; 0000 03B7                     {
; 0000 03B8 //                        printf("TRACER FRONT BLACK \r");
; 0000 03B9                         TRACER_SECTION[FRONT_2]= TRACER_BLACK;
	__POINTW1MN _TRACER_SECTION,6
	RCALL SUBOPT_0x22
	RJMP _0x150
; 0000 03BA                     }
; 0000 03BB                     else
_0xF6:
; 0000 03BC                     {
; 0000 03BD //                        printf("TRACER FRONT GRAY \r");
; 0000 03BE                         TRACER_SECTION[FRONT_2]= TRACER_GRAY;
	__POINTW1MN _TRACER_SECTION,6
	RCALL SUBOPT_0x31
_0x150:
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 03BF                     }
_0xF5:
; 0000 03C0                     return TRACER[FRONT_2];
	__GETW1MN _TRACER,6
	RJMP _0x20A0002
; 0000 03C1                 }break;
; 0000 03C2 
; 0000 03C3         case 4: {
_0xF0:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0xF8
; 0000 03C4 
; 0000 03C5                     for(counter=0;counter<=4;counter++)
	RCALL SUBOPT_0x23
_0xFA:
	RCALL SUBOPT_0x24
	BRGE _0xFB
; 0000 03C6                     {
; 0000 03C7                         TRACER_TEMP[counter]= read_adc(4);
	RCALL SUBOPT_0x25
	PUSH R31
	PUSH R30
	LDI  R26,LOW(4)
	RCALL _read_adc
	POP  R26
	POP  R27
	RCALL SUBOPT_0x26
; 0000 03C8                     }
	RCALL SUBOPT_0x27
	RJMP _0xFA
_0xFB:
; 0000 03C9 
; 0000 03CA                     TRACER_SUM= TRACER_TEMP[0]+TRACER_TEMP[1]+TRACER_TEMP[2]+TRACER_TEMP[3]+TRACER_TEMP[4];
	RCALL SUBOPT_0x28
; 0000 03CB                     TRACER[MIDDLE_2]=TRACER_SUM/5;
	__PUTW1MN _TRACER,8
; 0000 03CC 
; 0000 03CD                     if(TRACER[MIDDLE_2]>=TRACER_THRESHOLD_UP)
	RCALL SUBOPT_0x34
	RCALL SUBOPT_0x2E
	BRLT _0xFC
; 0000 03CE                     {
; 0000 03CF //                        printf("TRACER FRONT WHITE \r");
; 0000 03D0                         TRACER_SECTION[MIDDLE_2]= TRACER_WHITE;
	__POINTW1MN _TRACER_SECTION,8
	RCALL SUBOPT_0x2F
	RJMP _0x151
; 0000 03D1                     }
; 0000 03D2 
; 0000 03D3                     else if(TRACER[MIDDLE_2]<=TRACER_THRESHOLD_DOWN)
_0xFC:
	RCALL SUBOPT_0x34
	RCALL SUBOPT_0x30
	BRLT _0xFE
; 0000 03D4                     {
; 0000 03D5 //                        printf("TRACER FRONT BLACK \r");
; 0000 03D6                         TRACER_SECTION[MIDDLE_2]= TRACER_BLACK;
	__POINTW1MN _TRACER_SECTION,8
	RCALL SUBOPT_0x22
	RJMP _0x151
; 0000 03D7                     }
; 0000 03D8                     else
_0xFE:
; 0000 03D9                     {
; 0000 03DA //                        printf("TRACER FRONT GRAY \r");
; 0000 03DB                         TRACER_SECTION[MIDDLE_2]= TRACER_GRAY;
	__POINTW1MN _TRACER_SECTION,8
	RCALL SUBOPT_0x31
_0x151:
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 03DC                     }
; 0000 03DD                     return TRACER[MIDDLE_2];
	__GETW1MN _TRACER,8
	RJMP _0x20A0002
; 0000 03DE                 }break;
; 0000 03DF 
; 0000 03E0         case 5: {
_0xF8:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0xD7
; 0000 03E1                     for(counter=0;counter<=4;counter++)
	RCALL SUBOPT_0x23
_0x102:
	RCALL SUBOPT_0x24
	BRGE _0x103
; 0000 03E2                     {
; 0000 03E3                         TRACER_TEMP[counter]= read_adc(3);
	RCALL SUBOPT_0x25
	PUSH R31
	PUSH R30
	LDI  R26,LOW(3)
	RCALL _read_adc
	POP  R26
	POP  R27
	RCALL SUBOPT_0x26
; 0000 03E4                     }
	RCALL SUBOPT_0x27
	RJMP _0x102
_0x103:
; 0000 03E5 
; 0000 03E6                     TRACER_SUM= TRACER_TEMP[0]+TRACER_TEMP[1]+TRACER_TEMP[2]+TRACER_TEMP[3]+TRACER_TEMP[4];
	RCALL SUBOPT_0x28
; 0000 03E7                     TRACER[REAR_2]=TRACER_SUM/5;
	__PUTW1MN _TRACER,10
; 0000 03E8 
; 0000 03E9                     if(TRACER[REAR_2]>=TRACER_THRESHOLD_UP)
	RCALL SUBOPT_0x35
	RCALL SUBOPT_0x2E
	BRLT _0x104
; 0000 03EA                     {
; 0000 03EB //                        printf("TRACER FRONT WHITE \r");
; 0000 03EC                         TRACER_SECTION[REAR_2]= TRACER_WHITE;
	__POINTW1MN _TRACER_SECTION,10
	RCALL SUBOPT_0x2F
	RJMP _0x152
; 0000 03ED                     }
; 0000 03EE 
; 0000 03EF                     else if(TRACER[REAR_2]<=TRACER_THRESHOLD_DOWN)
_0x104:
	RCALL SUBOPT_0x35
	RCALL SUBOPT_0x30
	BRLT _0x106
; 0000 03F0                     {
; 0000 03F1 //                        printf("TRACER FRONT BLACK \r");
; 0000 03F2                         TRACER_SECTION[REAR_2]= TRACER_BLACK;
	__POINTW1MN _TRACER_SECTION,10
	RCALL SUBOPT_0x22
	RJMP _0x152
; 0000 03F3                     }
; 0000 03F4                     else
_0x106:
; 0000 03F5                     {
; 0000 03F6 //                        printf("TRACER FRONT GRAY \r");
; 0000 03F7                         TRACER_SECTION[REAR_2]= TRACER_GRAY;
	__POINTW1MN _TRACER_SECTION,10
	RCALL SUBOPT_0x31
_0x152:
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 03F8                     }
; 0000 03F9                     return TRACER[REAR_2];
	__GETW1MN _TRACER,10
; 0000 03FA                 }break;
; 0000 03FB     }
_0xD7:
; 0000 03FC }
_0x20A0002:
	RCALL __LOADLOCR4
	ADIW R28,16
	RET
;
;
;void Tracer_GetRule(void)                 //harus dirubah untuk navigasi memakai tracer saja
; 0000 0400 {
_Tracer_GetRule:
; 0000 0401     Tracer_Sampling(FRONT);
	RCALL SUBOPT_0x36
; 0000 0402     Tracer_Sampling(MIDDLE);
	RCALL SUBOPT_0x37
; 0000 0403     Tracer_Sampling(REAR);
	RCALL SUBOPT_0x38
; 0000 0404     Tracer_Sampling(FRONT_2);
	RCALL SUBOPT_0x2
	RCALL _Tracer_Sampling
; 0000 0405     Tracer_Sampling(MIDDLE_2);
	LDI  R26,LOW(4)
	RCALL SUBOPT_0x39
; 0000 0406     Tracer_Sampling(REAR_2);
	LDI  R26,LOW(5)
	RCALL SUBOPT_0x39
; 0000 0407 
; 0000 0408 //    printf("TRACER[FRONT]: %d \t TRACER[MIDDLE]: %d \t TRACER[REAR]: %d  \r",TRACER[FRONT],TRACER[MIDDLE],TRACER[REAR] );
; 0000 0409 
; 0000 040A     if( (TRACER_SECTION[FRONT]==TRACER_WHITE) || (TRACER_SECTION[MIDDLE]==TRACER_WHITE) || (TRACER_SECTION[REAR]==TRACER_WHITE) /*|| (TRACER_SECTION[FRONT_2]==TRACER_WHITE) || (TRACER_SECTION[MIDDLE_2]==TRACER_WHITE) || (TRACER_SECTION[REAR_2]==TRACER_WHITE)*/)
	RCALL SUBOPT_0x3A
	SBIW R26,1
	BREQ _0x109
	RCALL SUBOPT_0x3B
	SBIW R30,1
	BREQ _0x109
	RCALL SUBOPT_0x3C
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x108
_0x109:
; 0000 040B     {
; 0000 040C //        printf("TRACER STAT WHITE \r");
; 0000 040D         TRACER_STAT=TRACER_WHITE;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RCALL SUBOPT_0x3D
; 0000 040E     }
; 0000 040F     else if( (TRACER_SECTION[FRONT]==TRACER_GRAY) || ((TRACER_SECTION[MIDDLE]==TRACER_GRAY) && (TRACER_SECTION[REAR]==TRACER_GRAY)) /* || (TRACER_SECTION[FRONT_2]==TRACER_GRAY) || (TRACER_SECTION[MIDDLE_2]==TRACER_GRAY) || (TRACER_SECTION[REAR_2]==TRACER_GRAY)*/)
	RJMP _0x10B
_0x108:
	RCALL SUBOPT_0x3A
	SBIW R26,2
	BREQ _0x10D
	RCALL SUBOPT_0x3B
	SBIW R30,2
	BRNE _0x10E
	RCALL SUBOPT_0x3C
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BREQ _0x10D
_0x10E:
	RJMP _0x10C
_0x10D:
; 0000 0410     {
; 0000 0411 //        printf("TRACER STAT GRAY \r");
; 0000 0412         TRACER_STAT=TRACER_GRAY;
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x3D
; 0000 0413     }
; 0000 0414     else
	RJMP _0x111
_0x10C:
; 0000 0415     {
; 0000 0416 //        printf("TRACER STAT BLACK \r");
; 0000 0417         TRACER_STAT=TRACER_BLACK;
	LDI  R30,LOW(0)
	STS  _TRACER_STAT,R30
	STS  _TRACER_STAT+1,R30
; 0000 0418     }
_0x111:
_0x10B:
; 0000 0419 
; 0000 041A }
	RET
;
;void Tracer_GetData_Black(void)
; 0000 041D {
_Tracer_GetData_Black:
; 0000 041E      int TRC_FRONT,TRC_MIDDLE,TRC_REAR;
; 0000 041F      int THold_Temp;
; 0000 0420 
; 0000 0421      TRC_FRONT  = Tracer_Sampling(FRONT);
	RCALL SUBOPT_0x3E
;	TRC_FRONT -> R16,R17
;	TRC_MIDDLE -> R18,R19
;	TRC_REAR -> R20,R21
;	THold_Temp -> Y+6
	MOVW R16,R30
; 0000 0422      TRC_MIDDLE = Tracer_Sampling(MIDDLE);
	RCALL SUBOPT_0x37
	MOVW R18,R30
; 0000 0423      TRC_REAR   = Tracer_Sampling(REAR);
	RCALL SUBOPT_0x38
	MOVW R20,R30
; 0000 0424 
; 0000 0425 //     THold_Temp = max(TRC_FRONT, TRC_MIDDLE);
; 0000 0426 //     THold_Temp = max(THold_Temp, TRC_REAR);
; 0000 0427      if(TRC_FRONT >= TRC_MIDDLE) THold_Temp = TRC_FRONT;
	__CPWRR 16,17,18,19
	BRLT _0x112
	__PUTWSR 16,17,6
; 0000 0428      else THold_Temp= TRC_MIDDLE;
	RJMP _0x113
_0x112:
	__PUTWSR 18,19,6
; 0000 0429 
; 0000 042A      if(TRC_REAR >= THold_Temp) THold_Temp = TRC_REAR;
_0x113:
	RCALL SUBOPT_0x3F
	CP   R20,R30
	CPC  R21,R31
	BRLT _0x114
	__PUTWSR 20,21,6
; 0000 042B 
; 0000 042C      TRACER_BLACKDATA= THold_Temp;
_0x114:
	RCALL SUBOPT_0x3F
	STS  _TRACER_BLACKDATA,R30
	STS  _TRACER_BLACKDATA+1,R31
; 0000 042D 
; 0000 042E }
	RJMP _0x20A0001
;
;void Tracer_GetData_Gray(void)
; 0000 0431 {
_Tracer_GetData_Gray:
; 0000 0432      int TRC_FRONT,TRC_MIDDLE,TRC_REAR;
; 0000 0433      int THold_Temp;
; 0000 0434 
; 0000 0435      TRC_FRONT  = Tracer_Sampling(FRONT);
	RCALL SUBOPT_0x3E
;	TRC_FRONT -> R16,R17
;	TRC_MIDDLE -> R18,R19
;	TRC_REAR -> R20,R21
;	THold_Temp -> Y+6
	MOVW R16,R30
; 0000 0436      TRC_MIDDLE = Tracer_Sampling(MIDDLE);
	RCALL SUBOPT_0x37
	MOVW R18,R30
; 0000 0437      TRC_REAR   = Tracer_Sampling(REAR);
	RCALL SUBOPT_0x38
	MOVW R20,R30
; 0000 0438 
; 0000 0439 //     THold_Temp = max(TRC_FRONT, TRC_MIDDLE);
; 0000 043A //     THold_Temp = max(THold_Temp, TRC_REAR);
; 0000 043B      if(TRC_FRONT >= TRC_MIDDLE) THold_Temp = TRC_MIDDLE;//TRC_FRONT;
	__CPWRR 16,17,18,19
	BRLT _0x115
	__PUTWSR 18,19,6
; 0000 043C      else THold_Temp= TRC_FRONT;//TRC_MIDDLE;
	RJMP _0x116
_0x115:
	__PUTWSR 16,17,6
; 0000 043D 
; 0000 043E      if(TRC_REAR >= THold_Temp) THold_Temp = THold_Temp;//TRC_REAR;
_0x116:
	RCALL SUBOPT_0x3F
	CP   R20,R30
	CPC  R21,R31
	BRLT _0x117
	RCALL SUBOPT_0x3F
	STD  Y+6,R30
	STD  Y+6+1,R31
; 0000 043F 
; 0000 0440      TRACER_GRAYDATA= TRC_REAR;//THold_Temp;
_0x117:
	MOVW R12,R20
; 0000 0441 
; 0000 0442 }
	RJMP _0x20A0001
;
;void Tracer_GetData_White(void)
; 0000 0445 {
_Tracer_GetData_White:
; 0000 0446      int TRC_FRONT,TRC_MIDDLE,TRC_REAR;
; 0000 0447      int THold_Temp;
; 0000 0448 
; 0000 0449      TRC_FRONT  = Tracer_Sampling(FRONT);
	RCALL SUBOPT_0x3E
;	TRC_FRONT -> R16,R17
;	TRC_MIDDLE -> R18,R19
;	TRC_REAR -> R20,R21
;	THold_Temp -> Y+6
	MOVW R16,R30
; 0000 044A      TRC_MIDDLE = Tracer_Sampling(MIDDLE);
	RCALL SUBOPT_0x37
	MOVW R18,R30
; 0000 044B      TRC_REAR   = Tracer_Sampling(REAR);
	RCALL SUBOPT_0x38
	MOVW R20,R30
; 0000 044C 
; 0000 044D //     THold_Temp = min(TRC_FRONT, TRC_MIDDLE);
; 0000 044E //     THold_Temp = min(THold_Temp, TRC_REAR);
; 0000 044F 
; 0000 0450      if(TRC_FRONT <= TRC_MIDDLE) THold_Temp = TRC_FRONT;
	__CPWRR 18,19,16,17
	BRLT _0x118
	__PUTWSR 16,17,6
; 0000 0451      else THold_Temp= TRC_MIDDLE;
	RJMP _0x119
_0x118:
	__PUTWSR 18,19,6
; 0000 0452 
; 0000 0453      if(TRC_REAR <= THold_Temp) THold_Temp = TRC_REAR;
_0x119:
	RCALL SUBOPT_0x3F
	CP   R30,R20
	CPC  R31,R21
	BRLT _0x11A
	__PUTWSR 20,21,6
; 0000 0454 
; 0000 0455      TRACER_WHITEDATA= THold_Temp;
_0x11A:
	RCALL SUBOPT_0x3F
	STS  _TRACER_WHITEDATA,R30
	STS  _TRACER_WHITEDATA+1,R31
; 0000 0456 }
	RJMP _0x20A0001
;
;void Tracer_Calibrate_GetRule(void)
; 0000 0459 {
_Tracer_Calibrate_GetRule:
; 0000 045A     int Tracer_Diff_Up;
; 0000 045B     int Tracer_Diff_Down;
; 0000 045C     int Tracer_White= TRACER_WHITEDATA;
; 0000 045D     int Tracer_Gray= TRACER_GRAYDATA;
; 0000 045E     int Tracer_Black= TRACER_BLACKDATA;
; 0000 045F 
; 0000 0460     //Tracer_Diff= TRACER_WHITEDATA-TRACER_GRAYDATA;
; 0000 0461     Tracer_Diff_Up= Tracer_White-Tracer_Gray;
	SBIW R28,4
	RCALL __SAVELOCR6
;	Tracer_Diff_Up -> R16,R17
;	Tracer_Diff_Down -> R18,R19
;	Tracer_White -> R20,R21
;	Tracer_Gray -> Y+8
;	Tracer_Black -> Y+6
	__GETWRMN 20,21,0,_TRACER_WHITEDATA
	__PUTWSR 12,13,8
	LDS  R30,_TRACER_BLACKDATA
	LDS  R31,_TRACER_BLACKDATA+1
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	MOVW R30,R20
	SUB  R30,R26
	SBC  R31,R27
	MOVW R16,R30
; 0000 0462     Tracer_Diff_Down= Tracer_Gray-Tracer_Black;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RCALL SUBOPT_0x40
	SUB  R30,R26
	SBC  R31,R27
	MOVW R18,R30
; 0000 0463 
; 0000 0464     if(Tracer_Diff_Up>=80)     TRACER_THRESHOLD_UP   = Tracer_Gray + 75;
	__CPWRN 16,17,80
	BRLT _0x11B
	RCALL SUBOPT_0x40
	SUBI R30,LOW(-75)
	SBCI R31,HIGH(-75)
	RJMP _0x153
; 0000 0465     else if(Tracer_Diff_Up>=75) TRACER_THRESHOLD_UP   = Tracer_Gray + 70;
_0x11B:
	__CPWRN 16,17,75
	BRLT _0x11D
	RCALL SUBOPT_0x40
	SUBI R30,LOW(-70)
	SBCI R31,HIGH(-70)
	RJMP _0x153
; 0000 0466     else if(Tracer_Diff_Up>=70) TRACER_THRESHOLD_UP   = Tracer_Gray + 65;
_0x11D:
	__CPWRN 16,17,70
	BRLT _0x11F
	RCALL SUBOPT_0x40
	SUBI R30,LOW(-65)
	SBCI R31,HIGH(-65)
	RJMP _0x153
; 0000 0467     else if(Tracer_Diff_Up>=65) TRACER_THRESHOLD_UP   = Tracer_Gray + 60;
_0x11F:
	__CPWRN 16,17,65
	BRLT _0x121
	RCALL SUBOPT_0x40
	ADIW R30,60
	RJMP _0x153
; 0000 0468     else if(Tracer_Diff_Up>=60) TRACER_THRESHOLD_UP   = Tracer_Gray + 55;
_0x121:
	__CPWRN 16,17,60
	BRLT _0x123
	RCALL SUBOPT_0x40
	ADIW R30,55
	RJMP _0x153
; 0000 0469     else if(Tracer_Diff_Up>=50) TRACER_THRESHOLD_UP   = Tracer_Gray + 45;
_0x123:
	__CPWRN 16,17,50
	BRLT _0x125
	RCALL SUBOPT_0x40
	ADIW R30,45
	RJMP _0x153
; 0000 046A     else if(Tracer_Diff_Up>=40) TRACER_THRESHOLD_UP   = Tracer_Gray + 35;
_0x125:
	__CPWRN 16,17,40
	BRLT _0x127
	RCALL SUBOPT_0x40
	ADIW R30,35
	RJMP _0x153
; 0000 046B     else if(Tracer_Diff_Up>=30) TRACER_THRESHOLD_UP   = Tracer_Gray + 25;
_0x127:
	__CPWRN 16,17,30
	BRLT _0x129
	RCALL SUBOPT_0x40
	ADIW R30,25
	RJMP _0x153
; 0000 046C     else if(Tracer_Diff_Up>=20) TRACER_THRESHOLD_UP   = Tracer_Gray + 15;
_0x129:
	__CPWRN 16,17,20
	BRLT _0x12B
	RCALL SUBOPT_0x40
	ADIW R30,15
	RJMP _0x153
; 0000 046D     else if(Tracer_Diff_Up>=10) TRACER_THRESHOLD_UP   = Tracer_Gray + 7;
_0x12B:
	__CPWRN 16,17,10
	BRLT _0x12D
	RCALL SUBOPT_0x40
	ADIW R30,7
_0x153:
	STS  _TRACER_THRESHOLD_UP,R30
	STS  _TRACER_THRESHOLD_UP+1,R31
; 0000 046E 
; 0000 046F         if(Tracer_Diff_Down>=80) TRACER_THRESHOLD_DOWN   = Tracer_Gray - 75;
_0x12D:
	__CPWRN 18,19,80
	BRLT _0x12E
	RCALL SUBOPT_0x40
	SUBI R30,LOW(75)
	SBCI R31,HIGH(75)
	RJMP _0x154
; 0000 0470     else if(Tracer_Diff_Down>=75) TRACER_THRESHOLD_DOWN   = Tracer_Gray - 70;
_0x12E:
	__CPWRN 18,19,75
	BRLT _0x130
	RCALL SUBOPT_0x40
	SUBI R30,LOW(70)
	SBCI R31,HIGH(70)
	RJMP _0x154
; 0000 0471     else if(Tracer_Diff_Down>=70) TRACER_THRESHOLD_DOWN   = Tracer_Gray - 65;
_0x130:
	__CPWRN 18,19,70
	BRLT _0x132
	RCALL SUBOPT_0x40
	SUBI R30,LOW(65)
	SBCI R31,HIGH(65)
	RJMP _0x154
; 0000 0472     else if(Tracer_Diff_Down>=65) TRACER_THRESHOLD_DOWN   = Tracer_Gray - 60;
_0x132:
	__CPWRN 18,19,65
	BRLT _0x134
	RCALL SUBOPT_0x40
	SBIW R30,60
	RJMP _0x154
; 0000 0473     else if(Tracer_Diff_Down>=60) TRACER_THRESHOLD_DOWN   = Tracer_Gray - 55;
_0x134:
	__CPWRN 18,19,60
	BRLT _0x136
	RCALL SUBOPT_0x40
	SBIW R30,55
	RJMP _0x154
; 0000 0474     else if(Tracer_Diff_Down>=50) TRACER_THRESHOLD_DOWN   = Tracer_Gray - 45;
_0x136:
	__CPWRN 18,19,50
	BRLT _0x138
	RCALL SUBOPT_0x40
	SBIW R30,45
	RJMP _0x154
; 0000 0475     else if(Tracer_Diff_Down>=40) TRACER_THRESHOLD_DOWN   = Tracer_Gray - 35;
_0x138:
	__CPWRN 18,19,40
	BRLT _0x13A
	RCALL SUBOPT_0x40
	SBIW R30,35
	RJMP _0x154
; 0000 0476     else if(Tracer_Diff_Down>=30) TRACER_THRESHOLD_DOWN   = Tracer_Gray - 25;
_0x13A:
	__CPWRN 18,19,30
	BRLT _0x13C
	RCALL SUBOPT_0x40
	SBIW R30,25
	RJMP _0x154
; 0000 0477     else if(Tracer_Diff_Down>=20) TRACER_THRESHOLD_DOWN   = Tracer_Gray - 12;//15;
_0x13C:
	__CPWRN 18,19,20
	BRLT _0x13E
	RCALL SUBOPT_0x40
	SBIW R30,12
	RJMP _0x154
; 0000 0478     else if(Tracer_Diff_Down>=10) TRACER_THRESHOLD_DOWN   = Tracer_Gray - 0;//7;
_0x13E:
	__CPWRN 18,19,10
	BRLT _0x140
	RCALL SUBOPT_0x40
	SBIW R30,0
_0x154:
	STS  _TRACER_THRESHOLD_DOWN,R30
	STS  _TRACER_THRESHOLD_DOWN+1,R31
; 0000 0479 
; 0000 047A     EEPROM_A = TRACER_THRESHOLD_UP;
_0x140:
	RCALL SUBOPT_0x29
	LDI  R26,LOW(_EEPROM_A)
	LDI  R27,HIGH(_EEPROM_A)
	RCALL __EEPROMWRW
; 0000 047B     EEPROM_B = TRACER_THRESHOLD_DOWN;
	RCALL SUBOPT_0x2C
	LDI  R26,LOW(_EEPROM_B)
	LDI  R27,HIGH(_EEPROM_B)
	RCALL __EEPROMWRW
; 0000 047C 
; 0000 047D }
	RCALL __LOADLOCR6
	ADIW R28,10
	RET
;
;
;void Send_Threshold(void)
; 0000 0481 {
_Send_Threshold:
; 0000 0482     int Thold_BW,Thold_BG,Thold_Tracer_Up,Thold_Tracer_Down;
; 0000 0483     Thold_BW= Threshold_BW;
	SBIW R28,2
	RCALL __SAVELOCR6
;	Thold_BW -> R16,R17
;	Thold_BG -> R18,R19
;	Thold_Tracer_Up -> R20,R21
;	Thold_Tracer_Down -> Y+6
	__GETWRMN 16,17,0,_Threshold_BW
; 0000 0484     Thold_BG= Threshold_BG;
	__GETWRMN 18,19,0,_Threshold_BG
; 0000 0485     Thold_Tracer_Up= TRACER_THRESHOLD_UP;
	__GETWRMN 20,21,0,_TRACER_THRESHOLD_UP
; 0000 0486     Thold_Tracer_Down= TRACER_THRESHOLD_DOWN;
	RCALL SUBOPT_0x2C
	STD  Y+6,R30
	STD  Y+6+1,R31
; 0000 0487     Send_UART(COMMAND_FLAG_A);
	RCALL SUBOPT_0xF
; 0000 0488     Send_UART(COMMAND_FLAG_B);
; 0000 0489     Send_UART(RAW_VAL_FLAG);
; 0000 048A 
; 0000 048B     //Threshold_BW VALUE
; 0000 048C     MULTIPLY_COUNTER=0;
	RCALL SUBOPT_0x10
; 0000 048D     if(Thold_BW>255)
	__CPWRN 16,17,256
	BRLT _0x141
; 0000 048E     {
; 0000 048F         while( Thold_BW >255)
_0x142:
	__CPWRN 16,17,256
	BRLT _0x144
; 0000 0490         {
; 0000 0491            Thold_BW-=255;
	__SUBWRN 16,17,255
; 0000 0492            MULTIPLY_COUNTER++;
	RCALL SUBOPT_0x13
; 0000 0493         }
	RJMP _0x142
_0x144:
; 0000 0494     }
; 0000 0495     Send_UART(MULTIPLY_COUNTER);
_0x141:
	RCALL SUBOPT_0x14
; 0000 0496     Send_UART(Thold_BW);
	MOV  R26,R16
	RCALL SUBOPT_0x15
; 0000 0497 
; 0000 0498     //Threshold_BG VALUE
; 0000 0499     MULTIPLY_COUNTER=0;
; 0000 049A     if(Thold_BG>255)
	__CPWRN 18,19,256
	BRLT _0x145
; 0000 049B     {
; 0000 049C         while( Thold_BG >255)
_0x146:
	__CPWRN 18,19,256
	BRLT _0x148
; 0000 049D         {
; 0000 049E            Thold_BG-=255;
	__SUBWRN 18,19,255
; 0000 049F            MULTIPLY_COUNTER++;
	RCALL SUBOPT_0x13
; 0000 04A0         }
	RJMP _0x146
_0x148:
; 0000 04A1     }
; 0000 04A2     Send_UART(MULTIPLY_COUNTER);
_0x145:
	RCALL SUBOPT_0x14
; 0000 04A3     Send_UART(Thold_BG);
	MOV  R26,R18
	RCALL _Send_UART
; 0000 04A4 
; 0000 04A5     //PHOTODIODE TRACER B/W THRESHOLD
; 0000 04A6     Send_UART(Thold_Tracer_Up);
	MOV  R26,R20
	RCALL _Send_UART
; 0000 04A7     Send_UART(Thold_Tracer_Down);
	LDD  R26,Y+6
	RCALL _Send_UART
; 0000 04A8 }
_0x20A0001:
	RCALL __LOADLOCR6
	ADIW R28,8
	RET
;
;
;
;/*=============== MOVING AVERAGE SMOOTHING ALGORITHM =================
;New average = old average * (n-1)/n + new value /n
;=====================================================================*/
;
;// Function Prototypes
;//int GetMov_AVG(unsigned int TCS_MODE, unsigned int NewVal)
;//{
;//    Mov_AVG[TCS_MODE]= Mov_AVG[TCS_MODE] * (MovAVG_Counter[TCS_MODE]-1) / MovAVG_Counter[TCS_MODE] + NewVal/MovAVG_Counter[TCS_MODE];
;//    MovAVG_Counter[TCS_MODE]++;
;//    return Mov_AVG[TCS_MODE];
;//}
;
;//void GetRule_MovAVG(void)
;//{
;////    int buff_1,buff_2;
;////
;////    for(MovAVG_Counter=1;MovAVG_Counter<=5;MovAVG_Counter++)
;////    {
;////        NewVal=FRONT_Read_R();
;////        buff_1= Mov_AVG * (MovAVG_Counter-1);
;////        buff_1= buff_1/ MovAVG_Counter;
;////        buff_2= NewVal/MovAVG_Counter;
;////        Mov_AVG= buff_1 + buff_2 ;
;////    }
;////
;//
;////   NewVal[F_GREEN]=FRONT_Read_G();
;////   GetMov_AVG(F_GREEN,NewVal[F_GREEN]);
;////
;////   NewVal[F_BLUE]=FRONT_Read_B();
;////   GetMov_AVG(F_BLUE,NewVal[F_BLUE]);
;////
;////   NewVal[F_WHITE]=FRONT_Read_W();
;////   GetMov_AVG(F_WHITE,NewVal[F_WHITE]);
;//
;//    printf("============================================================================= \r",);
;//    printf("==========================FRONT TCS3200 MONITOR============================== \r",);
;//    printf("============================================================================= \r",);
;//    printf("Red  : %d \t",(int)Mov_AVG);
;////    printf("Green: %d \t",(int)Mov_AVG[F_GREEN]);
;////    printf("Blue : %d \t",(int)Mov_AVG[F_BLUE]);
;////    printf("White: %d \r",(int)Mov_AVG[F_WHITE]);
;//    printf("============================================================================= \r",);
;//}void Send_UART(unsigned char data)
;
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_TRACER_WHITEDATA:
	.BYTE 0x2
_TRACER_BLACKDATA:
	.BYTE 0x2
_Threshold_BW:
	.BYTE 0x2
_Threshold_BG:
	.BYTE 0x2
_TRACER_THRESHOLD_UP:
	.BYTE 0x2
_TRACER_THRESHOLD_DOWN:
	.BYTE 0x2
_COMMAND_FLAG_A:
	.BYTE 0x2
_COMMAND_FLAG_B:
	.BYTE 0x2
_CMD_IDLE:
	.BYTE 0x2
_MOV_AVG:
	.BYTE 0x14
_TCS3200_COUNTER:
	.BYTE 0x2
_TCS3200_Pulse_R:
	.BYTE 0x2
_TCS3200_Pulse_G:
	.BYTE 0x2
_TCS3200_Pulse_B:
	.BYTE 0x2
_TCS3200_Pulse_W:
	.BYTE 0x2
_TCS3200_Pulse_Sum:
	.BYTE 0x2
_TCS3200_TOTAL_SUM:
	.BYTE 0x2
_TCS3200_CMD:
	.BYTE 0x10

	.ESEG
_EEPROM_A:
	.BYTE 0x2
_EEPROM_B:
	.BYTE 0x2
_EEPROM_C:
	.BYTE 0x2
_EEPROM_D:
	.BYTE 0x2

	.DSEG
_Threshold_Diff:
	.BYTE 0x2
_RAW_VAL_FLAG:
	.BYTE 0x2
_MULTIPLY_COUNTER:
	.BYTE 0x2
_TRACER:
	.BYTE 0xC
_TRACER_STAT:
	.BYTE 0x2
_TRACER_SECTION:
	.BYTE 0xC
_rx_buffer:
	.BYTE 0x8
_rx_wr_index:
	.BYTE 0x1
_rx_rd_index:
	.BYTE 0x1
_rx_counter:
	.BYTE 0x1
__seed_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:26 WORDS
SUBOPT_0x1:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(3)
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3:
	LDI  R30,LOW(0)
	OUT  0x2E,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x4:
	CBI  0x15,3
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
	LDI  R30,LOW(6)
	OUT  0x2E,R30
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x5:
	LDS  R31,_TCS3200_COUNTER
	LDI  R30,LOW(0)
	MOVW R26,R30
	IN   R30,0x2C
	IN   R31,0x2C+1
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:37 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
	STS  _TCS3200_COUNTER,R30
	STS  _TCS3200_COUNTER+1,R30
	LDI  R26,LOW(10)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x7:
	SBI  0x15,3
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
	LDI  R30,LOW(6)
	OUT  0x2E,R30
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	LDS  R30,_TCS3200_Pulse_G
	LDS  R31,_TCS3200_Pulse_G+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	LDS  R30,_TCS3200_Pulse_B
	LDS  R31,_TCS3200_Pulse_B+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	LDS  R30,_TCS3200_Pulse_W
	LDS  R31,_TCS3200_Pulse_W+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0xB:
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xC:
	ST   X+,R30
	ST   X,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xD:
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	LDS  R30,_TCS3200_CMD
	LDS  R31,_TCS3200_CMD+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0xF:
	LDS  R26,_COMMAND_FLAG_A
	RCALL _Send_UART
	LDS  R26,_COMMAND_FLAG_B
	RCALL _Send_UART
	LDS  R26,_RAW_VAL_FLAG
	RJMP _Send_UART

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x10:
	LDI  R30,LOW(0)
	STS  _MULTIPLY_COUNTER,R30
	STS  _MULTIPLY_COUNTER+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x11:
	__GETW2MN _MOV_AVG,10
	CPI  R26,LOW(0x100)
	LDI  R30,HIGH(0x100)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x12:
	SUBI R30,LOW(255)
	SBCI R31,HIGH(255)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x13:
	LDI  R26,LOW(_MULTIPLY_COUNTER)
	LDI  R27,HIGH(_MULTIPLY_COUNTER)
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x14:
	LDS  R26,_MULTIPLY_COUNTER
	RJMP _Send_UART

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x15:
	RCALL _Send_UART
	RJMP SUBOPT_0x10

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x16:
	__GETW2MN _MOV_AVG,12
	CPI  R26,LOW(0x100)
	LDI  R30,HIGH(0x100)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x17:
	__GETW2MN _MOV_AVG,14
	CPI  R26,LOW(0x100)
	LDI  R30,HIGH(0x100)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x18:
	__GETW2MN _MOV_AVG,16
	CPI  R26,LOW(0x100)
	LDI  R30,HIGH(0x100)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x19:
	LDS  R26,_TCS3200_TOTAL_SUM
	LDS  R27,_TCS3200_TOTAL_SUM+1
	CPI  R26,LOW(0x100)
	LDI  R30,HIGH(0x100)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1A:
	RCALL _Send_UART
	LDS  R26,_TRACER_STAT
	RJMP _Send_UART

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1B:
	RCALL _Tracer_GetRule
	LDS  R26,_COMMAND_FLAG_A
	RCALL _Send_UART
	LDS  R26,_COMMAND_FLAG_B
	RJMP _Send_UART

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1C:
	STS  _Threshold_Diff,R30
	STS  _Threshold_Diff+1,R31
	LDS  R26,_Threshold_Diff
	LDS  R27,_Threshold_Diff+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 36 TIMES, CODE SIZE REDUCTION:103 WORDS
SUBOPT_0x1D:
	LDS  R26,_Threshold_Diff
	LDS  R27,_Threshold_Diff+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0xFB)
	LDI  R30,HIGH(0xFB)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1F:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0xC9)
	LDI  R30,HIGH(0xC9)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x20:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x97)
	LDI  R30,HIGH(0x97)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	RCALL SUBOPT_0x1D
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x22:
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x23:
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x24:
	__CPWRN 16,17,5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:28 WORDS
SUBOPT_0x25:
	MOVW R30,R16
	MOVW R26,R28
	ADIW R26,4
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x26:
	RCALL SUBOPT_0xB
	RJMP SUBOPT_0xC

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x27:
	__ADDWRN 16,17,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:108 WORDS
SUBOPT_0x28:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADD  R30,R26
	ADC  R31,R27
	MOVW R18,R30
	MOVW R26,R18
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RCALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x29:
	LDS  R30,_TRACER_THRESHOLD_UP
	LDS  R31,_TRACER_THRESHOLD_UP+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2A:
	LDS  R26,_TRACER
	LDS  R27,_TRACER+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2B:
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x2C:
	LDS  R30,_TRACER_THRESHOLD_DOWN
	LDS  R31,_TRACER_THRESHOLD_DOWN+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2D:
	__GETW2MN _TRACER,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2E:
	RCALL SUBOPT_0x29
	RJMP SUBOPT_0x2B

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2F:
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x30:
	RCALL SUBOPT_0x2C
	RJMP SUBOPT_0xD

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x31:
	LDI  R26,LOW(2)
	LDI  R27,HIGH(2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x32:
	__GETW2MN _TRACER,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x33:
	__GETW2MN _TRACER,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x34:
	__GETW2MN _TRACER,8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x35:
	__GETW2MN _TRACER,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x36:
	LDI  R26,LOW(0)
	LDI  R27,0
	RJMP _Tracer_Sampling

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x37:
	LDI  R26,LOW(1)
	LDI  R27,0
	RJMP _Tracer_Sampling

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x38:
	LDI  R26,LOW(2)
	LDI  R27,0
	RJMP _Tracer_Sampling

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x39:
	LDI  R27,0
	RJMP _Tracer_Sampling

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3A:
	LDS  R26,_TRACER_SECTION
	LDS  R27,_TRACER_SECTION+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3B:
	__GETW1MN _TRACER_SECTION,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3C:
	__GETW1MN _TRACER_SECTION,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3D:
	STS  _TRACER_STAT,R30
	STS  _TRACER_STAT+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3E:
	SBIW R28,2
	RCALL __SAVELOCR6
	RJMP SUBOPT_0x36

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3F:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 21 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x40:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__EEPROMWRW:
	RCALL __EEPROMWRB
	ADIW R26,1
	PUSH R30
	MOV  R30,R31
	RCALL __EEPROMWRB
	POP  R30
	SBIW R26,1
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__LOADLOCR2P:
	LD   R16,Y+
	LD   R17,Y+
	RET

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
