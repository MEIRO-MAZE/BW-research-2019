#ifndef ADC_COMP_H
#define ADC_COMP_H

#include "main.h"
#include <stm32f10x_adc.h>
//#include <math.h>
//#include <stdio.h>

#define SHARP_FR_PIN	GPIO_Pin_3
#define SHARP_FL_PIN	GPIO_Pin_1
#define ChannelNol		ADC_Channel_0
#define ChannelSatu		ADC_Channel_1
#define ChannelDua		ADC_Channel_2

uint32_t adc_value;

void ADC_Config(void);
void ADC_Calibration(void);
uint16_t ADC1_Read(void);
uint16_t Sharp[2];
void SHARP_FL_read(void);
void BW_ADC_Init(void);
void SHARP_BUMPER_RIGHT_Read(void);
void SHARP_BUMPER_LEFT_Read(void);
uint16_t GetADCChanel(int8_t chanel);

#endif
