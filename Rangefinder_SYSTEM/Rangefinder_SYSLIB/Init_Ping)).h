#ifndef INIT_PING_H
#define INIT_PING_H

#include "main.h"

#define SIG_PIN				RCC_APB2Periph_GPIOB
#define SIG					GPIOB

// PIN GPIOB
//#define ASKEW_FR_SIG 		GPIO_Pin_13
//#define ASKEW_FL_SIG		GPIO_Pin_12
//#define PING_R_SIG			GPIO_Pin_14
//#define PING_L_SIG			GPIO_Pin_4
//#define ASKEW_RL_SIG		GPIO_Pin_15
//#define ASKEW_RR_SIG		GPIO_Pin_5
//#define PING_REAR_SIG		GPIO_Pin_3
//#define PING_FRONT_SIG		GPIO_Pin_8

#define ASKEW_FR_SIG 		GPIO_Pin_12
#define ASKEW_FL_SIG		GPIO_Pin_15
#define PING_R_SIG			GPIO_Pin_5
#define PING_L_SIG			GPIO_Pin_3
#define ASKEW_RL_SIG		GPIO_Pin_8
#define ASKEW_RR_SIG		GPIO_Pin_4
#define PING_REAR_SIG		GPIO_Pin_14
#define PING_FRONT_SIG		GPIO_Pin_13

// Identifier PING
#define ASKEW_FR			0
#define ASKEW_FL			1
#define PING_R				2
#define PING_L				3
#define ASKEW_RR			4
#define ASKEW_RL			5
#define PING_FRONT			6
#define PING_REAR			7

#define ENA					1
#define DIS					0

#define UV_PIN				RCC_APB2Periph_GPIOB
#define UV					GPIO_Pin_7

uint32_t time_us;
uint8_t distance[8];
uint32_t time_out_flag;
uint8_t UV_DATA, CAT_DATA;

void PING_Init(void);
void PING_Init_IN(int PING);
void PING_Init_OUT(int PING);
void TIM4_SWITCH(int PARAM);
void TIM4_IRQHandler(void);
void USART1_Init(int baudrate);
void USART_Send(USART_TypeDef *USARTx, unsigned int DATA);
void USART1_IRQHandler(void);
void TIM_Reset(TIM_TypeDef *TIMx);
void PingScan(uint32_t PING);
void GPIO_driver_motor(void);
void PING_TIM_Init(void);
int timeout(int val);
void Start_TIM4(void);
void UV_Read(void);
void UV_GPIO_Init(void);
void IR_CAT_Init(void);
void CAT_READ(void);


#endif
