#include "adc_comp.h"


GPIO_InitTypeDef GPIO_InitStructure;
ADC_InitTypeDef	ADC_InitStructure;

void ADC_Config_X(void)
{
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_ADC1, ENABLE);
	RCC_ADCCLKConfig(RCC_PCLK2_Div2);
	ADC_DeInit(ADC1);

	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AIN;
	GPIO_InitStructure.GPIO_Pin = SHARP_FL_PIN;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA, &GPIO_InitStructure);

	ADC_InitStructure.ADC_Mode = ADC_Mode_Independent;
	ADC_InitStructure.ADC_ScanConvMode = DISABLE;
	ADC_InitStructure.ADC_ContinuousConvMode = ENABLE;	// we work in continuous sampling mode
	ADC_InitStructure.ADC_ExternalTrigConv = ADC_ExternalTrigConv_None;
	ADC_InitStructure.ADC_DataAlign = ADC_DataAlign_Right;
	ADC_InitStructure.ADC_NbrOfChannel = 1;

	ADC_Init ( ADC1, &ADC_InitStructure);	//set config of ADC1

	// enable ADC

	ADC_RegularChannelConfig(ADC1,ADC_Channel_1, 1,ADC_SampleTime_28Cycles5); // define regular conversion config
	ADC_Cmd(ADC1,ENABLE);	//enable ADC1
//	ADC_TempSensorVrefintCmd(ENABLE);
	ADC_Calibration();
	ADC_SoftwareStartConvCmd(ADC1, ENABLE);
//	while(ADC_GetFlagStatus(ADC1, ADC_FLAG_EOC) == RESET);
}

void ADC_Config(void)
{
//    ADC_InitTypeDef ADC_InitStructure;
//    GPIO_InitTypeDef  GPIO_InitStructure;
    // input of ADC (it doesn't seem to be needed, as default GPIO state is floating input)
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
    GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_AIN;
    GPIO_InitStructure.GPIO_Pin   = GPIO_Pin_2 | GPIO_Pin_1 | GPIO_Pin_0;        // that's ADC1 (PA1 on STM32)
    GPIO_Init(GPIOA, &GPIO_InitStructure);

    //clock for ADC (max 14MHz --> 72/6=12MHz)
    RCC_ADCCLKConfig (RCC_PCLK2_Div6);
    // enable ADC system clock
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_ADC1, ENABLE);

    // define ADC config
    ADC_InitStructure.ADC_Mode = ADC_Mode_Independent;
    ADC_InitStructure.ADC_ScanConvMode = DISABLE;
    ADC_InitStructure.ADC_ContinuousConvMode = ENABLE;  // we work in continuous sampling mode
    ADC_InitStructure.ADC_ExternalTrigConv = ADC_ExternalTrigConv_None;
    ADC_InitStructure.ADC_DataAlign = ADC_DataAlign_Right;
    ADC_InitStructure.ADC_NbrOfChannel = 1;

    ADC_RegularChannelConfig(ADC1,ADC_Channel_1, 1,ADC_SampleTime_28Cycles5); // define regular conversion config
    ADC_Init ( ADC1, &ADC_InitStructure);   //set config of ADC1

    // enable ADC
    ADC_Cmd (ADC1,ENABLE);  //enable ADC1

    //  ADC calibration (optional, but recommended at power on)
    ADC_ResetCalibration(ADC1); // Reset previous calibration
    while(ADC_GetResetCalibrationStatus(ADC1));
    ADC_StartCalibration(ADC1); // Start new calibration (ADC must be off at that time)
    while(ADC_GetCalibrationStatus(ADC1));

    // start conversion
    ADC_Cmd (ADC1,ENABLE);  //enable ADC1
//    ADC_SoftwareStartConvCmd(ADC1, ENABLE); // start conversion (will be endless as we are in continuous mode)

}


void ADCInit(void) {

  // ADC init
  // ADC Deinit
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_ADC1|RCC_APB2Periph_GPIOA, ENABLE);
  ADC_DeInit(ADC1);

  // RA1 - analog input
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_1;
  GPIO_InitStructure.GPIO_Speed = 0;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AIN;
  GPIO_Init (GPIOA, &GPIO_InitStructure);

  // ADC Structure Initialization
  ADC_StructInit(&ADC_InitStructure);

  // Preinit
  ADC_InitStructure.ADC_Mode = ADC_Mode_Independent;
  ADC_InitStructure.ADC_ScanConvMode = DISABLE;
  ADC_InitStructure.ADC_ContinuousConvMode = DISABLE;
  ADC_InitStructure.ADC_ExternalTrigConv = ADC_ExternalTrigConv_None;
  ADC_InitStructure.ADC_DataAlign = ADC_DataAlign_Right;
  ADC_InitStructure.ADC_NbrOfChannel = 1;
  ADC_Init(ADC1, &ADC_InitStructure);

  // Enable the ADC
  ADC_Cmd(ADC1, ENABLE);
}

uint16_t GetADCChanel(int8_t chanel) {

  // Configure chanel
  ADC_RegularChannelConfig(ADC1, chanel, 1, ADC_SampleTime_28Cycles5);

  // Start the conversion
  ADC_SoftwareStartConvCmd(ADC1, ENABLE);

  // Wait until conversion completion
  while(ADC_GetFlagStatus(ADC1, ADC_FLAG_EOC) == RESET);

  // Get the conversion value
  return ADC_GetConversionValue(ADC1);

}

void ADC_Calibration(void)
{
	ADC_ResetCalibration(ADC1);	// Reset previous calibration
	while(ADC_GetResetCalibrationStatus(ADC1));
	ADC_StartCalibration(ADC1);	// Start new calibration (ADC must be off at that time)
	while(ADC_GetCalibrationStatus(ADC1));
}

uint16_t ADC1_Read(void)
{
	ADC_SoftwareStartConvCmd(ADC1,ENABLE);
	int adc_value = ADC_GetConversionValue(ADC1);
	return adc_value;
}

void BW_ADC_Init(void)
{
	ADC_Config();
//	ADC_Calibration();
//	ADCInit();
}

void Sharp_Distance_Calc(uint16_t val)
{

}

//void SHARP_FL_read(void)
//{
//	uint16_t counter, ADC_Value;
//	float SHARP_Vo, SHARP_TEMP[5];
//    for(counter=0;counter<=4;counter++)
//    {
//       ADC_Value = ADC1_Read();
//       SHARP_Vo  = (float)ADC_Value/51;
//       SHARP_TEMP[counter]= (float)((1/((0.0821*SHARP_Vo)-0.0042)-0.42));
//      SHARP_TEMP[counter] = 12343.85/ADC_Value;
//       SHARP_TEMP[counter] = ADC_Value;
//       if(SHARP_TEMP[counter]>80)
//       {
//           SHARP_TEMP[counter]=81;
//       }
//       DelayMs(2);
//    }
//    Sharp[0]= (int)((float)(SHARP_TEMP[0]+SHARP_TEMP[1]+SHARP_TEMP[2]+SHARP_TEMP[3]+SHARP_TEMP[4])/5);
//}

void SHARP_FL_read(void)
{
	uint16_t ADC_Val[30];
	float SHARP_Vo;
	int i;
	float buffer;
	for(i = 0;i <= 9;i++)
	{
		ADC_Val[i] = GetADCChanel(ChannelSatu); //ADC_GetConversionValue(ADC1);
		DelayMs(1);
		buffer = buffer + ADC_Val[i];
	}
	buffer = buffer/10;
	SHARP_Vo = (float)(buffer/4096)*5;
	buffer = (float)((1/((0.0413*SHARP_Vo)-0.0042)-0.42));
	USART_Send(USART1, (int)buffer);
}

void SHARP_BUMPER_LEFT_Read(void)
{
	uint16_t ADC_Val[30];
	float SHARP_Vo;
	int i;
	float buffer;
	for(i = 0;i <= 9;i++)
	{
		ADC_Val[i] = GetADCChanel(ChannelDua); //ADC_GetConversionValue(ADC1);
		DelayMs(1);
		buffer = buffer + ADC_Val[i];
	}
	buffer = buffer/10;
	SHARP_Vo = (float)(buffer/4096)*5;
	buffer = (float)((1/((0.0413*SHARP_Vo)-0.0042)-0.42));
	USART_Send(USART1, (int)buffer);
}

void SHARP_BUMPER_RIGHT_Read(void)
{
	uint16_t ADC_Val[30];
	float SHARP_Vo;
	int i;
	float buffer;
	for(i = 0;i <= 9;i++)
	{
		ADC_Val[i] = GetADCChanel(ChannelNol); //ADC_GetConversionValue(ADC1);
		DelayMs(1);
		buffer = buffer + ADC_Val[i];
	}
	buffer = buffer/10;
	SHARP_Vo = (float)(buffer/4096)*5;
	buffer = (float)((1/((0.0413*SHARP_Vo)-0.0042)-0.42));
	USART_Send(USART1, (int)buffer);
}
