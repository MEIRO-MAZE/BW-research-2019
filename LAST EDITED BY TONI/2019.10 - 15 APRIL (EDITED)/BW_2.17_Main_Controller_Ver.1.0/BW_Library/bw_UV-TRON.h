/*==============================================================================================
								  	  PROJECT BW Ver.1.0
								  HAMAMATSU UV-TRON SENSOR LIBRARY
==============================================================================================*/

#ifndef BW_UV_TRON_H
#define BW_UV_TRON_H

//#include "stm32f4xx.h"
//#include "stm32f4xx_gpio.h"
//#include "stm32f4xx_rcc.h"
//#include "bw_macro_lib.h"
//#include "bw_global_var.h"
//#include "stm32f4xx_tim.h"
//#include "misc.h"
//#include "bw_systick_delay.h"

#include "main.h"
/*
 * BW UV-TRON OLD PIN MAPPING
 */
//#define RCC_AHB1Periph_UV RCC_AHB1Periph_GPIOD
//#define UV_PORT GPIOD
//#define UV_PIN  GPIO_Pin_3
//
//#define UV_READ  GPIO_ReadInputDataBit(GPIOD, GPIO_Pin_3)


/*
 * BW UV-TRON NEW PIN MAPPING
 */
//#define RCC_AHB1Periph_UV 	RCC_AHB1Periph_GPIOD
//#define UV_PORT 			GPIOD
//#define UV_PIN  			GPIO_Pin_11
//
//#define UV_READ  			GPIO_ReadInputDataBit(GPIOD, GPIO_Pin_11)

#define RCC_AHB1Periph_UV_Right 	RCC_AHB1Periph_GPIOB
#define RCC_AHB1Periph_UV_Left	 	RCC_AHB1Periph_GPIOE
#define UV_PORT_Left 			GPIOE
#define UV_PORT_Right 			GPIOB
#define UV_PIN_Left  			GPIO_Pin_4
//#define UV_PIN_Left  			GPIO_Pin_7
#define UV_PIN_Right  			GPIO_Pin_6
#define UV_READ_Right  			GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_6)
//#define UV_READ_Left  			GPIO_ReadInputDataBit(GPIOD, GPIO_Pin_7)
#define UV_READ_Left  			GPIO_ReadInputDataBit(GPIOE, GPIO_Pin_4)

#define UVSTATE_ACTIVE 		0
#define UVSTATE_INACTIVE 	1

#define UVLOCK_ACTIVE 		1
#define UVLOCK_INACTIVE 	0

#define FIRE_OFF		0
#define FIRE_ON 		1
#define FIRE_SUCCESS	2

extern unsigned int UV_state;
extern unsigned int UV_Lock;

extern unsigned int UV_R2FLAG;
extern unsigned int UV_R2FLAG_ACTIVE;
extern unsigned int UV_R2FLAG_INACTIVE;
extern int UV_VARIABLE;
extern int UV_VARIABLE2;
extern int ENABLE_UV1;
extern int ENABLE_UV2;
extern int DUMMY_VAR;
extern int IN_ROOM_STAT, NOT_IN_ROOM_STAT;

/*
 *  BW HAMAMATSU UV-TRON GLOBAL VARIABLE
 */
void BW_UV_TRON_Init(void);
void UV_GPIO_Init_Right(void);
void UV_GPIO_Init_Left(void);
void BW_Display_UV_Stat(void);

void Get_UV(void);
void IR_Proximity_Init(void);
void IR_Control(void);
void IR_Interrupt_Init(void);


#endif
