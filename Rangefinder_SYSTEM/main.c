#include "main.h"
unsigned int COMMAND_FLAG_A = 0x3C;
unsigned int COMMAND_FLAG_B = 0x3E;
int nilai_ADC;
int kanan,kiri;

void ClockSetup()//  system and peripheral clock setup
{
      RCC_DeInit ();                    /* RCC system reset(for debug purpose)*/
      RCC_HSEConfig (RCC_HSE_ON);       /* Enable HSE                         */

      /* Wait till HSE is ready                                               */
      while (RCC_GetFlagStatus(RCC_FLAG_HSERDY) == RESET);

      RCC_HCLKConfig   (RCC_SYSCLK_Div1);   /* HCLK   = SYSCLK                */
      RCC_PCLK2Config  (RCC_HCLK_Div1);     /* PCLK2  = HCLK                  */
      RCC_PCLK1Config  (RCC_HCLK_Div2);     /* PCLK1  = HCLK/2                */
      RCC_ADCCLKConfig (RCC_PCLK2_Div6);    /* ADCCLK = PCLK2/4               */

      /* PLLCLK = 8MHz * 9 = 72 MHz                                           */
      RCC_PLLConfig (0x00010000, RCC_PLLMul_9);

      RCC_PLLCmd (ENABLE);                  /* Enable PLL                     */

      /* Wait till PLL is ready                                               */
      while (RCC_GetFlagStatus(RCC_FLAG_PLLRDY) == RESET);

      /* Select PLL as system clock source                                    */
      RCC_SYSCLKConfig (RCC_SYSCLKSource_PLLCLK);

      /* Wait till PLL is used as system clock source                         */
      while (RCC_GetSYSCLKSource() != 0x08);
}

void SetSysClockTo72(void)
{
	ErrorStatus HSEStartUpStatus;
    /* SYSCLK, HCLK, PCLK2 and PCLK1 configuration -----------------------------*/
    /* RCC system reset(for debug purpose) */
    RCC_DeInit();

    /* Enable HSE */
    RCC_HSEConfig( RCC_HSE_ON);

    /* Wait till HSE is ready */
    HSEStartUpStatus = RCC_WaitForHSEStartUp();

    if (HSEStartUpStatus == SUCCESS)
    {
        /* Enable Prefetch Buffer */
    	//FLASH_PrefetchBufferCmd( FLASH_PrefetchBuffer_Enable);

        /* Flash 2 wait state */
        //FLASH_SetLatency( FLASH_Latency_2);

        /* HCLK = SYSCLK */
        RCC_HCLKConfig( RCC_SYSCLK_Div1);

        /* PCLK2 = HCLK */
        RCC_PCLK2Config( RCC_HCLK_Div1);

        /* PCLK1 = HCLK/2 */
        RCC_PCLK1Config( RCC_HCLK_Div2);

        /* PLLCLK = 8MHz * 9 = 72 MHz */
        RCC_PLLConfig(0x00010000, RCC_PLLMul_9);

        /* Enable PLL */
        RCC_PLLCmd( ENABLE);

        /* Wait till PLL is ready */
        while (RCC_GetFlagStatus(RCC_FLAG_PLLRDY) == RESET)
        {
        }

        /* Select PLL as system clock source */
        RCC_SYSCLKConfig( RCC_SYSCLKSource_PLLCLK);

        /* Wait till PLL is used as system clock source */
        while (RCC_GetSYSCLKSource() != 0x08)
        {
        }
    }
    else
    { /* If HSE fails to start-up, the application will have wrong clock configuration.
     User can add here some code to deal with this error */

        /* Go to infinite loop */
        while (1)
        {
        }
    }
}

int main(void)
{
	SetSysClockTo72();
	BW_ADC_Init();
	USART1_Init(9600);
	DelayInit();
	RCC->APB2ENR |= RCC_APB2ENR_AFIOEN; AFIO->MAPR = AFIO_MAPR_SWJ_CFG_1; // Remap JTAG Debugger di PB3 PB4, agar dapat dipakai GPIO biasa
	PING_TIM_Init();
    while(1)
    {
//    	SHARP_FL_read();
//    	ADC_GetConversionValue(ADC1);
//    	nilai_ADC = ADC1_Read();
//    	DelayMs(10);
//    	USART_Send(USART1, nilai_ADC);
//    	USART_Send(USART1, COMMAND_FLAG_A);
//    	USART_Send(USART1, COMMAND_FLAG_B);
//    	DelayMs(300);
    	USART_Send(USART1, COMMAND_FLAG_A);
    	USART_Send(USART1, COMMAND_FLAG_B);

    	PingScan(PING_FRONT);USART_Send(USART1,distance[PING_FRONT]);
    	PingScan(PING_R);USART_Send(USART1,distance[PING_R]);
    	PingScan(PING_L);USART_Send(USART1,distance[PING_L]);
    	DelayMs(3);

//    	SHARP_FL_read();USART_Send(USART1, (Sharp[0] >> 8));USART_Send(USART1, (Sharp[0]));
    	SHARP_FL_read();
    	DelayMs(3);

    	PingScan(ASKEW_FL);USART_Send(USART1,distance[ASKEW_FL]);
    	PingScan(ASKEW_FR);USART_Send(USART1,distance[ASKEW_FR]);
    	PingScan(PING_REAR);USART_Send(USART1,distance[PING_REAR]);
    	DelayMs(3);

    	SHARP_FL_read();
    	DelayMs(3);
    	PingScan(ASKEW_RR);USART_Send(USART1,distance[ASKEW_RR]);
    	PingScan(ASKEW_RL);USART_Send(USART1,distance[ASKEW_RL]);
//    	PingScan(PING_REAR);USART_Send(USART1,distance[PING_REAR]);
    	DelayMs(3);

    	SHARP_BUMPER_LEFT_Read();
    	SHARP_BUMPER_RIGHT_Read();
    	UV_Read();
    	CAT_READ();

    	DelayMs(3);
    }
}
