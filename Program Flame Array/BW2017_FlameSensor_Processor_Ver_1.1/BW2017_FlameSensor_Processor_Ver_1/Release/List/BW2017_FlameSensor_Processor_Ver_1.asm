
;CodeVisionAVR C Compiler V2.05.0 Advanced
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
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
;global 'const' stored in FLASH: Yes
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

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
	.DEF _baud_mode=R4
	.DEF _rx_wr_index=R7
	.DEF _rx_rd_index=R6
	.DEF _rx_counter=R9
	.DEF _FRONT_ANALOG=R10
	.DEF _FLAME_SENSOR=R12

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
	RJMP 0x00
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

_0xD:
	.DB  0x3C
_0xE:
	.DB  0x3E
_0xF:
	.DB  0x1
_0x10:
	.DB  0x2
_0x11:
	.DB  0x3
_0x12:
	.DB  0x4
_0x13:
	.DB  0x5
_0x14:
	.DB  0x6
_0x15:
	.DB  0x7
_0x16:
	.DB  0x4
_0x71:
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

	.DW  0x01
	.DW  _COMMAND_FLAG_A
	.DW  _0xD*2

	.DW  0x01
	.DW  _COMMAND_FLAG_B
	.DW  _0xE*2

	.DW  0x01
	.DW  _FLAME_REAR_LEFT
	.DW  _0xF*2

	.DW  0x01
	.DW  _FLAME_LEFT
	.DW  _0x10*2

	.DW  0x01
	.DW  _FLAME_ASKEW_LEFT
	.DW  _0x11*2

	.DW  0x01
	.DW  _FLAME_FRONT
	.DW  _0x12*2

	.DW  0x01
	.DW  _FLAME_ASKEW_RIGHT
	.DW  _0x13*2

	.DW  0x01
	.DW  _FLAME_RIGHT
	.DW  _0x14*2

	.DW  0x01
	.DW  _FLAME_REAR_RIGHT
	.DW  _0x15*2

	.DW  0x01
	.DW  _FLAME_CENTER
	.DW  _0x16*2

	.DW  0x02
	.DW  0x0C
	.DW  _0x71*2

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
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.12 Advanced
;Automatic Program Generator
;© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : BW Digital Flame Sensor Ver 1
;Version : Ver 1
;Date    : 2/1/2017
;Author  : Intelligent Fire Fighting Robot Division
;Company : University of Brawijaya
;Comments:
;
;
;Chip type               : ATmega8
;Program type            : Application
;AVR Core Clock frequency: 16.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*******************************************************/
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
;#include <sleep.h>
;
;//char x=0;
;int baud_mode;
;int RANK[8];
;
;//UART SPEED CONFIG VARIABLES
;const int DEBUG_MODE = 2;
;const int ROBOT_MODE = 1;
;void UART_Speed_Config(int mode);
;
;
;void BW_Initialization(void);
;void Send_UART(unsigned char data);
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
; 0000 005D {

	.CSEG
_usart_rx_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 005E char status,data;
; 0000 005F status=UCSRA;
	RCALL __SAVELOCR2
;	status -> R17
;	data -> R16
	IN   R17,11
; 0000 0060 data=UDR;
	IN   R16,12
; 0000 0061 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x3
; 0000 0062    {
; 0000 0063    rx_buffer[rx_wr_index++]=data;
	MOV  R30,R7
	INC  R7
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	ST   Z,R16
; 0000 0064 #if RX_BUFFER_SIZE == 256
; 0000 0065    // special case for receiver buffer size=256
; 0000 0066    if (++rx_counter == 0)
; 0000 0067       {
; 0000 0068 #else
; 0000 0069    if (rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	LDI  R30,LOW(8)
	CP   R30,R7
	BRNE _0x4
	CLR  R7
; 0000 006A    if (++rx_counter == RX_BUFFER_SIZE)
_0x4:
	INC  R9
	LDI  R30,LOW(8)
	CP   R30,R9
	BRNE _0x5
; 0000 006B       {
; 0000 006C       rx_counter=0;
	CLR  R9
; 0000 006D #endif
; 0000 006E       rx_buffer_overflow=1;
	SET
	BLD  R2,0
; 0000 006F       }
; 0000 0070    }
_0x5:
; 0000 0071 }
_0x3:
	RCALL __LOADLOCR2P
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0000 0078 {
; 0000 0079 char data;
; 0000 007A while (rx_counter==0);
;	data -> R17
; 0000 007B data=rx_buffer[rx_rd_index++];
; 0000 007C #if RX_BUFFER_SIZE != 256
; 0000 007D if (rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
; 0000 007E #endif
; 0000 007F #asm("cli")
; 0000 0080 --rx_counter;
; 0000 0081 #asm("sei")
; 0000 0082 return data;
; 0000 0083 }
;#pragma used-
;#endif
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;#define ADC_VREF_TYPE 0x60
;
;// Read the 8 most significant bits
;// of the AD conversion result
;unsigned char read_adc(unsigned char adc_input)
; 0000 008F {
_read_adc:
; 0000 0090 ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
;	adc_input -> Y+0
	LD   R30,Y
	ORI  R30,LOW(0x60)
	OUT  0x7,R30
; 0000 0091 // Delay needed for the stabilization of the ADC input voltage
; 0000 0092 delay_us(10);
	__DELAY_USB 53
; 0000 0093 // Start the AD conversion
; 0000 0094 ADCSRA|=0x40;
	SBI  0x6,6
; 0000 0095 // Wait for the AD conversion to complete
; 0000 0096 while ((ADCSRA & 0x10)==0);
_0xA:
	SBIS 0x6,4
	RJMP _0xA
; 0000 0097 ADCSRA|=0x10;
	SBI  0x6,4
; 0000 0098 return ADCH;
	IN   R30,0x5
	RJMP _0x20C0001
; 0000 0099 }
;
;// Declare your global variables here
;unsigned int FLAME_ANALOG[9]={0,0,0,0,0,0,0,0,0};
;//unsigned int FLAME_LOGIC[8]={0,0,0,0,0,0,0,0};
;unsigned int FRONT_ANALOG;
;
;
;int FLAME_SENSOR=0;
;
;//FLAG VARIABLES
;unsigned int COMMAND_FLAG_A = 0x3C;

	.DSEG
;unsigned int COMMAND_FLAG_B = 0x3E;
;const unsigned int COMMAND_COMPLETED = 0x7C;
;
;unsigned int MAX_VAL;
;//MACRO
;int NO_FLAME            = 0;
;
;int FLAME_REAR_LEFT     = 1;
;int FLAME_LEFT          = 2;
;int FLAME_ASKEW_LEFT    = 3;
;int FLAME_FRONT         = 4;
;int FLAME_ASKEW_RIGHT   = 5;
;int FLAME_RIGHT         = 6;
;int FLAME_REAR_RIGHT    = 7;
;int FLAME_CENTER        = 4;
;
;//           ADC4
;//           ADC3
;//     ADC2       ADC5
;//  ADC1              ADC6
;//   ADC0           ADC7
;
;int m,k,flame_buffer[2];
;int SELECT[8] = {0,0,0,0,0,0,0,0};
;
;void CLEAR_SELECTION(void)
; 0000 00BF {

	.CSEG
_CLEAR_SELECTION:
; 0000 00C0     int g;
; 0000 00C1     for(g=0;g <= 7;g++)
	RCALL __SAVELOCR2
;	g -> R16,R17
	__GETWRN 16,17,0
_0x18:
	__CPWRN 16,17,8
	BRGE _0x19
; 0000 00C2     {
; 0000 00C3         SELECT[g] = 0;
	MOVW R30,R16
	LDI  R26,LOW(_SELECT)
	LDI  R27,HIGH(_SELECT)
	RCALL SUBOPT_0x1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RCALL SUBOPT_0x2
; 0000 00C4     }
	__ADDWRN 16,17,1
	RJMP _0x18
_0x19:
; 0000 00C5 }
	RCALL __LOADLOCR2P
	RET
;
;void swap(int *xp, int *yp)
; 0000 00C8 {
_swap:
; 0000 00C9     int temp = *xp;
; 0000 00CA     *xp = *yp;
	RCALL __SAVELOCR2
;	*xp -> Y+4
;	*yp -> Y+2
;	temp -> R16,R17
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	RCALL __GETW1P
	MOVW R16,R30
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	RCALL __GETW1P
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	RCALL SUBOPT_0x2
; 0000 00CB     *yp = temp;
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X+,R16
	ST   X,R17
; 0000 00CC }
	RCALL __LOADLOCR2
	ADIW R28,6
	RET
;
;void bubbleSort(int arr[], int n)
; 0000 00CF {
_bubbleSort:
; 0000 00D0    int i, j;
; 0000 00D1    for (i = 0; i < n-1; i++)
	RCALL __SAVELOCR4
;	arr -> Y+6
;	n -> Y+4
;	i -> R16,R17
;	j -> R18,R19
	__GETWRN 16,17,0
_0x1B:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	SBIW R30,1
	CP   R16,R30
	CPC  R17,R31
	BRGE _0x1C
; 0000 00D2 
; 0000 00D3        // Last i elements are already in place
; 0000 00D4        for (j = 0; j < n-i-1; j++)
	__GETWRN 18,19,0
_0x1E:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SUB  R26,R16
	SBC  R27,R17
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RCALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	CP   R18,R30
	CPC  R19,R31
	BRGE _0x1F
; 0000 00D5            if (arr[j] > arr[j+1])
	MOVW R30,R18
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RCALL SUBOPT_0x1
	LD   R0,X+
	LD   R1,X
	MOVW R30,R18
	ADIW R30,1
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RCALL SUBOPT_0x1
	RCALL __GETW1P
	CP   R30,R0
	CPC  R31,R1
	BRGE _0x20
; 0000 00D6               swap(&arr[j], &arr[j+1]);
	MOVW R30,R18
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RCALL SUBOPT_0x3
	MOVW R30,R18
	ADIW R30,1
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	RCALL SUBOPT_0x3
	RCALL _swap
; 0000 00D7 }
_0x20:
	__ADDWRN 18,19,1
	RJMP _0x1E
_0x1F:
	__ADDWRN 16,17,1
	RJMP _0x1B
_0x1C:
	RCALL __LOADLOCR4
	ADIW R28,8
	RET
;
;void main(void)
; 0000 00DA {
_main:
; 0000 00DB     // Declare your local variables here
; 0000 00DC     BW_Initialization();
	RCALL _BW_Initialization
; 0000 00DD //    UART_Speed_Config(DEBUG_MODE);
; 0000 00DE 
; 0000 00DF 
; 0000 00E0     while (1)
_0x21:
; 0000 00E1       {
; 0000 00E2             FLAME_ANALOG[0]=read_adc(0);
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x0
	STS  _FLAME_ANALOG,R30
	STS  _FLAME_ANALOG+1,R31
; 0000 00E3             FLAME_ANALOG[1]=read_adc(1);
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x4
	__POINTW2MN _FLAME_ANALOG,2
	RCALL SUBOPT_0x5
; 0000 00E4             FLAME_ANALOG[2]=read_adc(2); //DI KALI 1.15 BIAR NILAI NYA BISA MAKS, KARENA GK TAU KENAPA NILAI ADC NYA GK MAU MAKS..
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x4
	__POINTW2MN _FLAME_ANALOG,4
	RCALL SUBOPT_0x5
; 0000 00E5             FLAME_ANALOG[3]=read_adc(3);
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x4
	__POINTW2MN _FLAME_ANALOG,6
	RCALL SUBOPT_0x5
; 0000 00E6             FLAME_ANALOG[4]=read_adc(4);
	LDI  R30,LOW(4)
	RCALL SUBOPT_0x4
	__POINTW2MN _FLAME_ANALOG,8
	RCALL SUBOPT_0x5
; 0000 00E7             FLAME_ANALOG[5]=read_adc(5);
	LDI  R30,LOW(5)
	RCALL SUBOPT_0x4
	__POINTW2MN _FLAME_ANALOG,10
	RCALL SUBOPT_0x5
; 0000 00E8             FLAME_ANALOG[6]=read_adc(6);
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x4
	__POINTW2MN _FLAME_ANALOG,12
	RCALL SUBOPT_0x5
; 0000 00E9             FLAME_ANALOG[7]=read_adc(7);
	LDI  R30,LOW(7)
	RCALL SUBOPT_0x4
	__POINTW2MN _FLAME_ANALOG,14
	RCALL SUBOPT_0x5
; 0000 00EA 
; 0000 00EB             for(m = 0;m <= 7;m++)
	RCALL SUBOPT_0x6
_0x25:
	RCALL SUBOPT_0x7
	BRGE _0x26
; 0000 00EC             {
; 0000 00ED                 RANK[m] = FLAME_ANALOG[m];
	RCALL SUBOPT_0x8
	LDI  R26,LOW(_RANK)
	LDI  R27,HIGH(_RANK)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	MOVW R0,R30
	RCALL SUBOPT_0x8
	LDI  R26,LOW(_FLAME_ANALOG)
	LDI  R27,HIGH(_FLAME_ANALOG)
	RCALL SUBOPT_0x1
	RCALL __GETW1P
	MOVW R26,R0
	RCALL SUBOPT_0x2
; 0000 00EE             }
	RCALL SUBOPT_0x9
	RJMP _0x25
_0x26:
; 0000 00EF 
; 0000 00F0             bubbleSort(RANK, 8);
	LDI  R30,LOW(_RANK)
	LDI  R31,HIGH(_RANK)
	RCALL SUBOPT_0xA
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	RCALL SUBOPT_0xA
	RCALL _bubbleSort
; 0000 00F1 
; 0000 00F2 
; 0000 00F3             FRONT_ANALOG=FLAME_ANALOG[4];
	__GETWRMN 10,11,_FLAME_ANALOG,8
; 0000 00F4 
; 0000 00F5             MAX_VAL= max(FLAME_ANALOG[0],FLAME_ANALOG[1]);
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0xC
	RCALL SUBOPT_0xD
; 0000 00F6             MAX_VAL= max(MAX_VAL,FLAME_ANALOG[2]);
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0xD
; 0000 00F7             MAX_VAL= max(MAX_VAL,FLAME_ANALOG[3]);
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0xD
; 0000 00F8 //            MAX_VAL= max(MAX_VAL,FLAME_ANALOG[4]);
; 0000 00F9             MAX_VAL= max(MAX_VAL,FLAME_ANALOG[5]);
	RCALL SUBOPT_0x10
	RCALL SUBOPT_0xD
; 0000 00FA             MAX_VAL= max(MAX_VAL,FLAME_ANALOG[6]);
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0xD
; 0000 00FB             MAX_VAL= max(MAX_VAL,FLAME_ANALOG[7]);
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0xA
	RCALL _max
	STS  _MAX_VAL,R30
	STS  _MAX_VAL+1,R31
; 0000 00FC 
; 0000 00FD             if(MAX_VAL>=100)
	RCALL SUBOPT_0x13
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRLO _0x27
; 0000 00FE             {
; 0000 00FF //                if(MAX_VAL==FLAME_ANALOG[4])
; 0000 0100 //                {
; 0000 0101 //                    FLAME_SENSOR=FLAME_CENTER;
; 0000 0102 //                }
; 0000 0103 //                else
; 0000 0104                 if(MAX_VAL==FLAME_ANALOG[3])
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0x14
	BRNE _0x28
; 0000 0105                 {
; 0000 0106                     FLAME_SENSOR=FLAME_FRONT;
	RCALL SUBOPT_0x15
; 0000 0107                 }
; 0000 0108                 else if(MAX_VAL==FLAME_ANALOG[2])
	RJMP _0x29
_0x28:
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x14
	BRNE _0x2A
; 0000 0109                 {
; 0000 010A                     FLAME_SENSOR=FLAME_ASKEW_LEFT;
	RCALL SUBOPT_0x16
; 0000 010B                 }
; 0000 010C                 else if(MAX_VAL==FLAME_ANALOG[5])
	RJMP _0x2B
_0x2A:
	RCALL SUBOPT_0x10
	RCALL SUBOPT_0x14
	BRNE _0x2C
; 0000 010D                 {
; 0000 010E                     FLAME_SENSOR=FLAME_ASKEW_RIGHT;
	RCALL SUBOPT_0x17
; 0000 010F                 }
; 0000 0110                 else if(MAX_VAL==FLAME_ANALOG[1])
	RJMP _0x2D
_0x2C:
	RCALL SUBOPT_0xC
	RCALL SUBOPT_0x14
	BRNE _0x2E
; 0000 0111                 {
; 0000 0112                     FLAME_SENSOR=FLAME_LEFT;
	RCALL SUBOPT_0x18
; 0000 0113                 }
; 0000 0114                 else if(MAX_VAL==FLAME_ANALOG[6])
	RJMP _0x2F
_0x2E:
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x14
	BRNE _0x30
; 0000 0115                 {
; 0000 0116                     FLAME_SENSOR=FLAME_RIGHT;
	RCALL SUBOPT_0x19
; 0000 0117                 }
; 0000 0118                 else if(MAX_VAL==FLAME_ANALOG[0])
	RJMP _0x31
_0x30:
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0x14
	BRNE _0x32
; 0000 0119                 {
; 0000 011A                     FLAME_SENSOR=FLAME_REAR_LEFT;
	RCALL SUBOPT_0x1A
; 0000 011B                 }
; 0000 011C                 else if(MAX_VAL==FLAME_ANALOG[7])
	RJMP _0x33
_0x32:
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x14
	BRNE _0x34
; 0000 011D                 {
; 0000 011E                     FLAME_SENSOR=FLAME_REAR_RIGHT;
	RCALL SUBOPT_0x1B
; 0000 011F                 }
; 0000 0120 
; 0000 0121             }
_0x34:
_0x33:
_0x31:
_0x2F:
_0x2D:
_0x2B:
_0x29:
; 0000 0122             else
	RJMP _0x35
_0x27:
; 0000 0123             {
; 0000 0124                 FLAME_SENSOR=NO_FLAME;
	RCALL SUBOPT_0x1C
; 0000 0125             }
_0x35:
; 0000 0126 
; 0000 0127             Send_UART(COMMAND_FLAG_A);
	LDS  R30,_COMMAND_FLAG_A
	ST   -Y,R30
	RCALL _Send_UART
; 0000 0128             Send_UART(COMMAND_FLAG_B);
	LDS  R30,_COMMAND_FLAG_B
	ST   -Y,R30
	RCALL _Send_UART
; 0000 0129 
; 0000 012A             Send_UART(FLAME_SENSOR);
	ST   -Y,R12
	RCALL _Send_UART
; 0000 012B             if(FLAME_ANALOG[4] >= 110)
	__GETW2MN _FLAME_ANALOG,8
	CPI  R26,LOW(0x6E)
	LDI  R30,HIGH(0x6E)
	CPC  R27,R30
	BRLO _0x36
; 0000 012C             {
; 0000 012D                 FLAME_SENSOR = FLAME_FRONT;
	RCALL SUBOPT_0x15
; 0000 012E                 Send_UART(FLAME_SENSOR);
	ST   -Y,R12
	RJMP _0x6D
; 0000 012F             }
; 0000 0130             else Send_UART(NO_FLAME);
_0x36:
	LDS  R30,_NO_FLAME
	ST   -Y,R30
_0x6D:
	RCALL _Send_UART
; 0000 0131 
; 0000 0132             CLEAR_SELECTION();
	RCALL _CLEAR_SELECTION
; 0000 0133 
; 0000 0134             for(m = 0;m <= 7;m++)
	RCALL SUBOPT_0x6
_0x39:
	RCALL SUBOPT_0x7
	BRLT PC+2
	RJMP _0x3A
; 0000 0135             {
; 0000 0136                 flame_buffer[0] = RANK[m];
	RCALL SUBOPT_0x8
	LDI  R26,LOW(_RANK)
	LDI  R27,HIGH(_RANK)
	RCALL SUBOPT_0x1
	RCALL __GETW1P
	STS  _flame_buffer,R30
	STS  _flame_buffer+1,R31
; 0000 0137                 for(k = 0;k <= 7;k++)
	LDI  R30,LOW(0)
	STS  _k,R30
	STS  _k+1,R30
_0x3C:
	RCALL SUBOPT_0x1D
	SBIW R26,8
	BRLT PC+2
	RJMP _0x3D
; 0000 0138                 {
; 0000 0139                     flame_buffer[1] = FLAME_ANALOG[k];
	LDS  R30,_k
	LDS  R31,_k+1
	LDI  R26,LOW(_FLAME_ANALOG)
	LDI  R27,HIGH(_FLAME_ANALOG)
	RCALL SUBOPT_0x1
	RCALL __GETW1P
	__PUTW1MN _flame_buffer,2
; 0000 013A                     if((flame_buffer[0] == flame_buffer[1]) && (flame_buffer[0] > 100))
	__GETW1MN _flame_buffer,2
	RCALL SUBOPT_0x1E
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x3F
	RCALL SUBOPT_0x1E
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRGE _0x40
_0x3F:
	RJMP _0x3E
_0x40:
; 0000 013B                     {
; 0000 013C                         if(k == 4 && SELECT[4] == 0){FLAME_SENSOR = FLAME_CENTER;SELECT[4] = 1;}
	RCALL SUBOPT_0x1D
	SBIW R26,4
	BRNE _0x42
	__GETW1MN _SELECT,8
	SBIW R30,0
	BREQ _0x43
_0x42:
	RJMP _0x41
_0x43:
	__GETWRMN 12,13,0,_FLAME_CENTER
	__POINTW1MN _SELECT,8
	RJMP _0x6E
; 0000 013D                         else if(k == 3 && SELECT[3] == 0){FLAME_SENSOR = FLAME_FRONT;SELECT[3] = 1;}
_0x41:
	RCALL SUBOPT_0x1D
	SBIW R26,3
	BRNE _0x46
	__GETW1MN _SELECT,6
	SBIW R30,0
	BREQ _0x47
_0x46:
	RJMP _0x45
_0x47:
	RCALL SUBOPT_0x15
	__POINTW1MN _SELECT,6
	RJMP _0x6E
; 0000 013E                         else if(k == 2 && SELECT[2] == 0){FLAME_SENSOR = FLAME_ASKEW_LEFT;SELECT[2] = 1;}
_0x45:
	RCALL SUBOPT_0x1D
	SBIW R26,2
	BRNE _0x4A
	__GETW1MN _SELECT,4
	SBIW R30,0
	BREQ _0x4B
_0x4A:
	RJMP _0x49
_0x4B:
	RCALL SUBOPT_0x16
	__POINTW1MN _SELECT,4
	RJMP _0x6E
; 0000 013F                         else if(k == 5 && SELECT[5] == 0){FLAME_SENSOR = FLAME_ASKEW_RIGHT;SELECT[5] = 1;}
_0x49:
	RCALL SUBOPT_0x1D
	SBIW R26,5
	BRNE _0x4E
	__GETW1MN _SELECT,10
	SBIW R30,0
	BREQ _0x4F
_0x4E:
	RJMP _0x4D
_0x4F:
	RCALL SUBOPT_0x17
	__POINTW1MN _SELECT,10
	RJMP _0x6E
; 0000 0140                         else if(k == 1 && SELECT[1] == 0){FLAME_SENSOR = FLAME_LEFT;SELECT[1] = 1;}
_0x4D:
	RCALL SUBOPT_0x1D
	SBIW R26,1
	BRNE _0x52
	__GETW1MN _SELECT,2
	SBIW R30,0
	BREQ _0x53
_0x52:
	RJMP _0x51
_0x53:
	RCALL SUBOPT_0x18
	__POINTW1MN _SELECT,2
	RJMP _0x6E
; 0000 0141                         else if(k == 6 && SELECT[6] == 0){FLAME_SENSOR = FLAME_RIGHT;SELECT[6] = 1;}
_0x51:
	RCALL SUBOPT_0x1D
	SBIW R26,6
	BRNE _0x56
	__GETW1MN _SELECT,12
	SBIW R30,0
	BREQ _0x57
_0x56:
	RJMP _0x55
_0x57:
	RCALL SUBOPT_0x19
	__POINTW1MN _SELECT,12
	RJMP _0x6E
; 0000 0142                         else if(k == 0 && SELECT[0] == 0){FLAME_SENSOR = FLAME_REAR_LEFT;SELECT[0] = 1;}
_0x55:
	RCALL SUBOPT_0x1D
	SBIW R26,0
	BRNE _0x5A
	LDS  R26,_SELECT
	LDS  R27,_SELECT+1
	SBIW R26,0
	BREQ _0x5B
_0x5A:
	RJMP _0x59
_0x5B:
	RCALL SUBOPT_0x1A
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _SELECT,R30
	STS  _SELECT+1,R31
; 0000 0143                         else if(k == 7 && SELECT[7] == 0){FLAME_SENSOR = FLAME_REAR_RIGHT;SELECT[7] = 1;}
	RJMP _0x5C
_0x59:
	RCALL SUBOPT_0x1D
	SBIW R26,7
	BRNE _0x5E
	__GETW1MN _SELECT,14
	SBIW R30,0
	BREQ _0x5F
_0x5E:
	RJMP _0x5D
_0x5F:
	RCALL SUBOPT_0x1B
	__POINTW1MN _SELECT,14
_0x6E:
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 0144                         break;
_0x5D:
_0x5C:
	RJMP _0x3D
; 0000 0145                     }
; 0000 0146                     else FLAME_SENSOR = NO_FLAME;
_0x3E:
	RCALL SUBOPT_0x1C
; 0000 0147                 }
	LDI  R26,LOW(_k)
	LDI  R27,HIGH(_k)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RJMP _0x3C
_0x3D:
; 0000 0148                Send_UART(FLAME_SENSOR);
	ST   -Y,R12
	RCALL _Send_UART
; 0000 0149             }
	RCALL SUBOPT_0x9
	RJMP _0x39
_0x3A:
; 0000 014A 
; 0000 014B //            printf("FLAME = %d \t",FLAME_SENSOR);
; 0000 014C //            printf("FA = %d \r",FRONT_ANALOG);
; 0000 014D //            delay_ms(100);
; 0000 014E //
; 0000 014F 
; 0000 0150       }
	RJMP _0x21
; 0000 0151 }
_0x61:
	RJMP _0x61
;
;
;void BW_Initialization(void)
; 0000 0155 {
_BW_Initialization:
; 0000 0156     // Input/Output Ports initialization
; 0000 0157     // Port B initialization
; 0000 0158     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0159     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 015A     PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 015B     DDRB=0x00;
	OUT  0x17,R30
; 0000 015C 
; 0000 015D     // Port C initialization
; 0000 015E     // Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 015F     // State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0160     PORTC=0x00;
	OUT  0x15,R30
; 0000 0161     DDRC=0x00;
	OUT  0x14,R30
; 0000 0162 
; 0000 0163     // Port D initialization
; 0000 0164     // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0165     // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0166     PORTD=0x00;
	OUT  0x12,R30
; 0000 0167     DDRD=0x00;
	OUT  0x11,R30
; 0000 0168 
; 0000 0169     // Timer/Counter 0 initialization
; 0000 016A     // Clock source: System Clock
; 0000 016B     // Clock value: Timer 0 Stopped
; 0000 016C     TCCR0=0x00;
	OUT  0x33,R30
; 0000 016D     TCNT0=0x00;
	OUT  0x32,R30
; 0000 016E 
; 0000 016F     // Timer/Counter 1 initialization
; 0000 0170     // Clock source: System Clock
; 0000 0171     // Clock value: Timer1 Stopped
; 0000 0172     // Mode: Normal top=0xFFFF
; 0000 0173     // OC1A output: Discon.
; 0000 0174     // OC1B output: Discon.
; 0000 0175     // Noise Canceler: Off
; 0000 0176     // Input Capture on Falling Edge
; 0000 0177     // Timer1 Overflow Interrupt: Off
; 0000 0178     // Input Capture Interrupt: Off
; 0000 0179     // Compare A Match Interrupt: Off
; 0000 017A     // Compare B Match Interrupt: Off
; 0000 017B     TCCR1A=0x00;
	OUT  0x2F,R30
; 0000 017C     TCCR1B=0x00;
	OUT  0x2E,R30
; 0000 017D     TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 017E     TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 017F     ICR1H=0x00;
	OUT  0x27,R30
; 0000 0180     ICR1L=0x00;
	OUT  0x26,R30
; 0000 0181     OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0182     OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0183     OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0184     OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0185 
; 0000 0186     // Timer/Counter 2 initialization
; 0000 0187     // Clock source: System Clock
; 0000 0188     // Clock value: Timer2 Stopped
; 0000 0189     // Mode: Normal top=0xFF
; 0000 018A     // OC2 output: Disconnected
; 0000 018B     ASSR=0x00;
	OUT  0x22,R30
; 0000 018C     TCCR2=0x00;
	OUT  0x25,R30
; 0000 018D     TCNT2=0x00;
	OUT  0x24,R30
; 0000 018E     OCR2=0x00;
	OUT  0x23,R30
; 0000 018F 
; 0000 0190     // External Interrupt(s) initialization
; 0000 0191     // INT0: Off
; 0000 0192     // INT1: Off
; 0000 0193     MCUCR=0x00;
	OUT  0x35,R30
; 0000 0194 
; 0000 0195     // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 0196     TIMSK=0x00;
	OUT  0x39,R30
; 0000 0197 
; 0000 0198     // USART initialization
; 0000 0199     // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 019A     // USART Receiver: On
; 0000 019B     // USART Transmitter: On
; 0000 019C     // USART Mode: Asynchronous
; 0000 019D     // USART Baud Rate: 9600
; 0000 019E     UCSRA=0x00;
	OUT  0xB,R30
; 0000 019F     UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
; 0000 01A0     UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 01A1     UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 01A2     UBRRL=0x67;
	LDI  R30,LOW(103)
	OUT  0x9,R30
; 0000 01A3 
; 0000 01A4     // Analog Comparator initialization
; 0000 01A5     // Analog Comparator: Off
; 0000 01A6     // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 01A7     ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 01A8     SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 01A9 
; 0000 01AA     // ADC initialization
; 0000 01AB     // ADC Clock frequency: 1000.000 kHz
; 0000 01AC     // ADC Voltage Reference: AVCC pin
; 0000 01AD     // Only the 8 most significant bits of
; 0000 01AE     // the AD conversion result are used
; 0000 01AF     ADMUX=ADC_VREF_TYPE & 0xff;
	LDI  R30,LOW(96)
	OUT  0x7,R30
; 0000 01B0     ADCSRA=0x84;
	LDI  R30,LOW(132)
	OUT  0x6,R30
; 0000 01B1 
; 0000 01B2     // SPI initialization
; 0000 01B3     // SPI disabled
; 0000 01B4     SPCR=0x00;
	LDI  R30,LOW(0)
	OUT  0xD,R30
; 0000 01B5 
; 0000 01B6     // TWI initialization
; 0000 01B7     // TWI disabled
; 0000 01B8     TWCR=0x00;
	OUT  0x36,R30
; 0000 01B9 
; 0000 01BA     // Global enable interrupts
; 0000 01BB     #asm("sei")
	sei
; 0000 01BC 
; 0000 01BD }
	RET
;
;void UART_Speed_Config(int mode)
; 0000 01C0 {
; 0000 01C1     //BAUD RATE SELECT INITIALIZATION
; 0000 01C2     if (PINB.3==0) baud_mode=1;
;	mode -> Y+0
; 0000 01C3     else if (PINB.3==1) baud_mode=2;
; 0000 01C4 
; 0000 01C5     switch(mode)
; 0000 01C6     {
; 0000 01C7         case 1:
; 0000 01C8             {
; 0000 01C9                 UBRRH=0x00;
; 0000 01CA                 UBRRL=0x00;
; 0000 01CB             }break;
; 0000 01CC         case 2:
; 0000 01CD             {
; 0000 01CE                 UBRRH=0x00;
; 0000 01CF                 UBRRL=0x67;
; 0000 01D0             }break;
; 0000 01D1 
; 0000 01D2     }
; 0000 01D3 
; 0000 01D4     #asm("cli")
; 0000 01D5 
; 0000 01D6     #asm("sei")
; 0000 01D7 }
;
;void Send_UART(unsigned char data)
; 0000 01DA {
_Send_UART:
; 0000 01DB     while(!(UCSRA & (1<<UDRE))){};
;	data -> Y+0
_0x6A:
	SBIS 0xB,5
	RJMP _0x6A
; 0000 01DC     UDR=data;
	LD   R30,Y
	OUT  0xC,R30
; 0000 01DD }
_0x20C0001:
	ADIW R28,1
	RET
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
_max:
    ld   r26,y+
    ld   r27,y+
    ld   r30,y+
    ld   r31,y+
    cp   r26,r30
    cpc  r27,r31
    brlt __max0
    movw r30,r26
__max0:
    ret
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

	.CSEG

	.DSEG
_RANK:
	.BYTE 0x10
_rx_buffer:
	.BYTE 0x8
_FLAME_ANALOG:
	.BYTE 0x12
_COMMAND_FLAG_A:
	.BYTE 0x2
_COMMAND_FLAG_B:
	.BYTE 0x2
_MAX_VAL:
	.BYTE 0x2
_NO_FLAME:
	.BYTE 0x2
_FLAME_REAR_LEFT:
	.BYTE 0x2
_FLAME_LEFT:
	.BYTE 0x2
_FLAME_ASKEW_LEFT:
	.BYTE 0x2
_FLAME_FRONT:
	.BYTE 0x2
_FLAME_ASKEW_RIGHT:
	.BYTE 0x2
_FLAME_RIGHT:
	.BYTE 0x2
_FLAME_REAR_RIGHT:
	.BYTE 0x2
_FLAME_CENTER:
	.BYTE 0x2
_m:
	.BYTE 0x2
_k:
	.BYTE 0x2
_flame_buffer:
	.BYTE 0x4
_SELECT:
	.BYTE 0x10
__seed_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x0:
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1:
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x2:
	ST   X+,R30
	ST   X,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	ST   -Y,R30
	RJMP _read_adc

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x5:
	RCALL SUBOPT_0x0
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(0)
	STS  _m,R30
	STS  _m+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x7:
	LDS  R26,_m
	LDS  R27,_m+1
	SBIW R26,8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	LDS  R30,_m
	LDS  R31,_m+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x9:
	LDI  R26,LOW(_m)
	LDI  R27,HIGH(_m)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xA:
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	LDS  R30,_FLAME_ANALOG
	LDS  R31,_FLAME_ANALOG+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	__GETW1MN _FLAME_ANALOG,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:38 WORDS
SUBOPT_0xD:
	RCALL SUBOPT_0xA
	RCALL _max
	STS  _MAX_VAL,R30
	STS  _MAX_VAL+1,R31
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	__GETW1MN _FLAME_ANALOG,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	__GETW1MN _FLAME_ANALOG,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	__GETW1MN _FLAME_ANALOG,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	__GETW1MN _FLAME_ANALOG,12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	__GETW1MN _FLAME_ANALOG,14
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x13:
	LDS  R26,_MAX_VAL
	LDS  R27,_MAX_VAL+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x14:
	RCALL SUBOPT_0x13
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x15:
	__GETWRMN 12,13,0,_FLAME_FRONT
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x16:
	__GETWRMN 12,13,0,_FLAME_ASKEW_LEFT
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	__GETWRMN 12,13,0,_FLAME_ASKEW_RIGHT
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x18:
	__GETWRMN 12,13,0,_FLAME_LEFT
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x19:
	__GETWRMN 12,13,0,_FLAME_RIGHT
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	__GETWRMN 12,13,0,_FLAME_REAR_LEFT
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1B:
	__GETWRMN 12,13,0,_FLAME_REAR_RIGHT
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1C:
	__GETWRMN 12,13,0,_NO_FLAME
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x1D:
	LDS  R26,_k
	LDS  R27,_k+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	LDS  R26,_flame_buffer
	LDS  R27,_flame_buffer+1
	RET


	.CSEG
__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

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

;END OF CODE MARKER
__END_OF_CODE:
