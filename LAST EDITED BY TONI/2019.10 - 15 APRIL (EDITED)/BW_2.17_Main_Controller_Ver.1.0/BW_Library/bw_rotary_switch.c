/*==============================================================================================
								 	 PROJECT BW Ver.1.0
								  	 ROTARY SWITCH LIBRARY
==============================================================================================*/

#include "bw_rotary_switch.h"

//uint16_t ADCResult;


//prescaler =2, ADCCLK= APB2/2 => 84MHz/2 = 42 MHz =>
//T ADC= 1/42MHz
//two sampling delay = 5 cycles
//sampletime= 3 cycles
//T Conversion= (3+5) cycles x (1/42MHz)
//T conv: 8 x 1 / 42MHz = 0.19047 us (APB2= 82 MHz
unsigned int ADCResult;
void RotSwitch_Init(void)
{
	//Enable Port C Clock
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOC, ENABLE);

	//-----------------Pin ADC3 Channel1 pin as analog input--------
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_4;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AN;
	//GPIO_InitStructure.GPIO_OType = GPIO_OType_PP; //gak perlu
	GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL ;
	GPIO_Init(GPIOC, &GPIO_InitStructure);

	/*Enable ADC3 clock*********************************************************/
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_ADC2, ENABLE);

	/* ADC Common Init **********************************************************/
	ADC_CommonInitStructure.ADC_Mode = ADC_Mode_Independent;
	ADC_CommonInitStructure.ADC_Prescaler = ADC_Prescaler_Div2;

	ADC_CommonInitStructure.ADC_DMAAccessMode = ADC_DMAAccessMode_Disabled;
	ADC_CommonInitStructure.ADC_TwoSamplingDelay = ADC_TwoSamplingDelay_5Cycles;
	ADC_CommonInit(&ADC_CommonInitStructure);

	/* ADC3 Init ****************************************************************/
	ADC_InitStructure.ADC_Resolution = ADC_Resolution_8b;
	ADC_InitStructure.ADC_ScanConvMode = DISABLE;
	ADC_InitStructure.ADC_ContinuousConvMode = ENABLE;
	ADC_InitStructure.ADC_ExternalTrigConvEdge = ADC_ExternalTrigConvEdge_None;
	ADC_InitStructure.ADC_ExternalTrigConv = ADC_ExternalTrigConv_T1_CC1;
	ADC_InitStructure.ADC_DataAlign = ADC_DataAlign_Right;
	ADC_InitStructure.ADC_NbrOfConversion = 1;

	ADC_Init(ADC2, &ADC_InitStructure);

	/* Enable ADC3 */
	ADC_Cmd(ADC2, ENABLE);
	ADC_ContinuousModeCmd(ADC2, ENABLE);
	ADC_RegularChannelConfig(ADC2,ADC_Channel_14,1,ADC_SampleTime_3Cycles); //channel 13 = IN1= datasheet PA.1(ADC323,IN1)
}

void RotSwitch_Sampling(void)
{

//	uint16_t ADCResult;
//	delay_ms(50);
	ADC_SoftwareStartConv(ADC2); //harus masuk while(1)
	ADC_GetConversionValue(ADC2);
	ADCResult= ADC_GetConversionValue(ADC2);

//	rot_switch_mode=2;
	//DISABLE ADC3
//	ADC_Cmd(ADC3, DISABLE);
//	ADC_ContinuousModeCmd(ADC3, DISABLE);
//	RCC_APB2PeriphClockCmd(RCC_APB2Periph_ADC3, DISABLE);
//	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOC, DISABLE);

	//rot_switch_mode=ADCResult/50;
	//printf("Rotary Switch ADC: %d | \n",ADCResult);

	Sendto_PC(USART1,"BW Rotary Switch Initializing... \t\t");
	Sendto_PC(USART1,"Rotary Switch ADC: %d \t\t",ADCResult);
	if (ADCResult<=15)
		{
			rot_switch_mode=1;//{printf("BW Mode: 1| ");}
		}
	else if (((ADCResult>=45)&&(ADCResult<=75)))
		{
			rot_switch_mode=2;//{printf("BW Mode: 1| ");}
		}
	else if (((ADCResult>=80)&&(ADCResult<=125)))
		{
			rot_switch_mode=3;//{printf("BW Mode: 1| ");}
		}
	else if (((ADCResult>=135)&&(ADCResult<=180)))
		{
			rot_switch_mode=4;//{printf("BW Mode: 1| ");}
		}
	else if (((ADCResult>=183)&&(ADCResult<=251)))
		{
			rot_switch_mode=5;//{printf("BW Mode: 1| ");}
		}
	else if (ADCResult>=252)
		{
			rot_switch_mode=6;//{printf("BW Mode: 1| ");}
		}
	else rot_switch_mode=0;

	if (rot_switch_mode==0) Sendto_PC(USART1,"BW Sampling Error \r",rot_switch_mode);
	else Sendto_PC(USART1,"BW Mode: %d \r",rot_switch_mode);

//	lcd_display_clear();

//	lcd_gotoxy(0,0);sprintf(lcd,"ADC_Result: %d",(int)ADCResult);lcd_putstr(lcd);
//	lcd_gotoxy(0,1);sprintf(lcd,"BW Mode: %d",rot_switch_mode);lcd_putstr(lcd);
//	delay_ms(400);
//
//
//	mov_static();
//	delay_ms(100);

}

void Display_MODE(void)
{
	lcd_display_clear();

	lcd_gotoxy(0,0);sprintf(lcd,"%d  BW  2019    %d",UV_VARIABLE,UV_VARIABLE2);lcd_putstr(lcd);
	lcd_gotoxy(5,1);sprintf(lcd,"MODE %d",rot_switch_mode);lcd_putstr(lcd);

	switch(rot_switch_mode)
	{
		case 1:
				{
					lcd_gotoxy(0,2);
//					sprintf(lcd,"ADC: %d",(int)ADCResult);lcd_putstr(lcd);
					sprintf(lcd,"TRIAL  ALGORITHM");lcd_putstr(lcd);

				}break;
		case 2:
				{
					lcd_gotoxy(0,2);
//					lcd_gotoxy(0,2);
//					sprintf(lcd,"ADC: %d",(int)ADCResult);lcd_putstr(lcd);
					sprintf(lcd,"BW SETTINGS 2019");lcd_putstr(lcd);
				}break;
		case 3:
				{
					lcd_gotoxy(0,2);
//					lcd_gotoxy(0,2);
//					sprintf(lcd,"ADC: %d",(int)ADCResult);lcd_putstr(lcd);
					sprintf(lcd,"PID TUNING");lcd_putstr(lcd);
				}break;
		case 4:
				{
					lcd_gotoxy(0,2);
//					sprintf(lcd,"ADC: %d",(int)ADCResult);lcd_putstr(lcd);
					sprintf(lcd,"TCS3200 SLV MENU");lcd_putstr(lcd);
				}break;
		case 5:
				{
					lcd_gotoxy(0,2);
//					lcd_gotoxy(0,2);
//					sprintf(lcd,"ADC: %d",(int)ADCResult);lcd_putstr(lcd);
					sprintf(lcd,"SENSOR MONITOR");lcd_putstr(lcd);
				}break;
		case 6:
				{
					lcd_gotoxy(0,2);
//					lcd_gotoxy(0,2);
//					sprintf(lcd,"ADC: %d",(int)ADCResult);lcd_putstr(lcd);
					sprintf(lcd,"FLAME FOLLOW");lcd_putstr(lcd);
				}break;

	}
//	lcd_gotoxy(0,3);sprintf(lcd,"JTE-FT BRAWIJAYA");lcd_putstr(lcd);
	lcd_gotoxy(2,3);sprintf(lcd,"JTE FT-UB 63");lcd_putstr(lcd);
	delay_ms(100);


}
