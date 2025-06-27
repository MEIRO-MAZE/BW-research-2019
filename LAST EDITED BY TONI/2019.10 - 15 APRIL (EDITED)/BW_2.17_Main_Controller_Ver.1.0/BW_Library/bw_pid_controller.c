/*==============================================================================================
								  	 PROJECT BW Ver.1.0
								  	 BW PID CONTROLLER
==============================================================================================*/

#include "bw_pid_controller.h"
// PID FOLLOW VARIABLES


int count=1;
/*
 * Note: PID Calc setiap 50 ms, program langsung stuck di inisialisasi
 */
//void BW_PID_Interrupt_Init(void)
//{
//	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM4, ENABLE);
//
//	TIM_TimeBaseInitTypeDef    TIM_TimeBaseStructure;
//
//	TIM_TimeBaseStructure.TIM_Prescaler = 33593;  //f per count= 84000000/(335+1)=250000Hz = 0.004ms
//	TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;
//	TIM_TimeBaseStructure.TIM_Period = 5000; //0.004*5000=50Hz jadi sampling adc setiap 20ms
//	TIM_TimeBaseStructure.TIM_ClockDivision = TIM_CKD_DIV1;
//	TIM_TimeBaseStructure.TIM_RepetitionCounter = 0;
//	TIM_TimeBaseInit(TIM4, &TIM_TimeBaseStructure);
//
//	TIM_Cmd(TIM2, ENABLE); //default di off dulu
//
//	TIM_ITConfig(TIM4, TIM_IT_Update, ENABLE);
//
//    NVIC_InitTypeDef NVIC_InitStructure;
//    NVIC_InitStructure.NVIC_IRQChannel = TIM4_IRQn;
//    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;
//    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 5;
//    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
//    NVIC_Init(&NVIC_InitStructure);
//
//}
//
//void TIM4_IRQHandler(void)
//{
//    if (TIM_GetITStatus(TIM4, TIM_IT_Update) != RESET)
//    	{
//    		count++;
//
//    		if (count==1) GPIO_SetBits(GPIOC, GPIO_Pin_0);
//    		//if (count==2) {GPIO_ResetBits(GPIOC, GPIO_Pin_0);count=1;}
//    		//PID_Calc_Interrupt_Init();
//    		//BW_RGB_Tracer_Encoder();
//    		//PID_Calc();
//    		TIM_ClearITPendingBit(TIM4, TIM_IT_Update);
//    	}
//}

//ADC INTERRUPT INIT
//void BW_PID_Interrupt_Init(void)
//{
////	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM5, ENABLE);
//
//	TIM_TimeBaseStructure.TIM_Prescaler = 335;  //f per count= 84000000/(335+1)=250000Hz = 0.004ms
//	TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;
//	TIM_TimeBaseStructure.TIM_Period = 5000; //0.004*5000=50ms jadi sampling adc setiap 20ms
//	TIM_TimeBaseStructure.TIM_ClockDivision = TIM_CKD_DIV1;
//	TIM_TimeBaseStructure.TIM_RepetitionCounter = 0;
//	TIM_TimeBaseInit(TIM5, &TIM_TimeBaseStructure);
//
//	TIM_Cmd(TIM5, ENABLE); //default di off dulu
//
//	TIM_ITConfig(TIM5, TIM_IT_Update, ENABLE);
//
//    NVIC_InitStructure.NVIC_IRQChannel = TIM5_IRQn;
//    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;
//    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
//    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
//    NVIC_Init(&NVIC_InitStructure);
//}
//
//void TIM5_IRQHandler(void)
//{
//    if (TIM_GetITStatus(TIM5, TIM_IT_Update) != RESET)
//    	{
//    		PID_Calc();
//    		//PID_follow_right();
//    		TIM_ClearITPendingBit(TIM5, TIM_IT_Update);
//    	}
//}

/*void Fuzzy_Follow_kanan(void)
{
	selisih = Ping[PING_ASKEW_RIGHT] - Fuzzy_FKR_SP;
	selisih = abs(selisih);

	//Error kecil
	if(selisih <= 3 ){ERROR_DATA[0] = 1; }
	else if(selisih > 3 && selisih <= 5)
	{
		ERROR_DATA[0]= ((float)selisih - 3.0)/(5.0-3.0);
	}
	else{ERROR_DATA[0] = 0;}

	//Error sedang
	if(selisih <= 3){ERROR_DATA[1] = 0;}
	else if(selisih > 3 && selisih <= 5)
	{
		ERROR_DATA[1]= ((float)selisih - 3.0)/(5.0-3.0);
	}
	else if(selisih > 5 && selisih <= 10)
	{
		ERROR_DATA[1]= ((float)selisih - 5.0)/(10.0-5.0);
	}
	else{ERROR_DATA[1] = 0;}

	//Error besar
	if(selisih <= 5){ERROR_DATA[2] = 0;}
	else if(selisih > 5 && selisih <= 10)
	{
		ERROR_DATA[2]= ((float)selisih - 5.0)/(10.0-5.0);
	}
	else{ERROR_DATA[2] = 1;}

	final_angel = (ERROR_DATA[0]*angle_low)  + (ERROR_DATA[1]*angle_medium)  + (ERROR_DATA[2]*angle_high);
	Defuzzy_follow_kiri = ERROR_DATA[0] + ERROR_DATA[1] + ERROR_DATA[2];
	final_angel = final_angel/Defuzzy_follow_kiri;
}*/

/*void Fuzzy_Follow_kiri(void)
{
	selisih = Ping[PING_ASKEW_LEFT] - Fuzzy_FKR_SP;
	selisih = abs(selisih);

	//Error kecil
	if(selisih <= 3 ){ERROR_DATA[0] = 1; }
	else if(selisih > 3 && selisih <= 5)
	{
		ERROR_DATA[0]= ((float)selisih - 3.0)/(5.0-3.0);
	}
	else{ERROR_DATA[0] = 0;}

	//Error sedang
	if(selisih <= 3){ERROR_DATA[1] = 0;}
	else if(selisih > 3 && selisih <= 5)
	{
		ERROR_DATA[1]= ((float)selisih - 3.0)/(5.0-3.0);
	}
	else if(selisih > 5 && selisih <= 10)
	{
		ERROR_DATA[1]= ((float)selisih - 5.0)/(10.0-5.0);
	}
	else{ERROR_DATA[1] = 0;}

	//Error besar
	if(selisih <= 5){ERROR_DATA[2] = 0;}
	else if(selisih > 5 && selisih <= 10)
	{
		ERROR_DATA[2]= ((float)selisih - 5.0)/(10.0-5.0);
	}
	else{ERROR_DATA[2] = 1;}

	final_angel = (ERROR_DATA[0]*angle_low)  + (ERROR_DATA[1]*angle_medium)  + (ERROR_DATA[2]*angle_high);
	Defuzzy_follow_kiri = ERROR_DATA[0] + ERROR_DATA[1] + ERROR_DATA[2];
	final_angel = final_angel/Defuzzy_follow_kiri;
}*/

void Fuzzy_Follow_kanan(void)
{
	selisih = Ping[PING_ASKEW_RIGHT] - Fuzzy_FKR_SP;
	if((selisih == 1) || (selisih == -1)){selisih = 0;}
//	else{selisih = abs(selisih);}
	selisih = abs(selisih);

	//Error kecil
	if(selisih <= 3 ){ERROR_DATA[0] = 1; }
	else if(selisih > 3 && selisih <= 4.75)
	{
		ERROR_DATA[0]= ((float)selisih - 3.0)/(4.75-3.0);
	}
	else if(selisih > 4.75 && selisih <= 6.75)
	{
		ERROR_DATA[0]= ((float)selisih - 4.75)/(6.75-4.75);
	}
	else{ERROR_DATA[0] = 0;}

	//Error med kecil
	if(selisih <= 3){ERROR_DATA[1]=0;}
	else if(selisih > 3 && selisih <= 4.75)
	{
		ERROR_DATA[1]= ((float)selisih - 3.0)/(4.75-3.0);
	}
	else{ERROR_DATA[1]= 0;}

	//Error sedang
	if(selisih <= 4.75){ERROR_DATA[2] = 0;}
	else if(selisih > 4.75 && selisih <= 6.5)
	{
		ERROR_DATA[2]= ((float)selisih - 4.75)/(6.5-4.75);
	}
	else if(selisih > 6.5 && selisih <= 8.25)
	{
		ERROR_DATA[2]= ((float)selisih - 6.5)/(8.25-6.5);
	}
	else{ERROR_DATA[2] = 0;}

	//Error med besar
	if(selisih <= 8.25){ERROR_DATA[3]=0;}
		else if(selisih > 8.25 && selisih <= 10)
		{
			ERROR_DATA[3]= ((float)selisih - 8.25)/(10.0-8.25);
		}
		else{ERROR_DATA[3]= 0;}

	//Error besar
	if(selisih <= 6.5){ERROR_DATA[2] = 0;}
	else if(selisih > 6.5 && selisih <= 8.25)
	{
		ERROR_DATA[4]= ((float)selisih - 6.5)/(8.25-6.5);
	}
	else if(selisih > 8.25 && selisih <= 10)
	{
		ERROR_DATA[4]= ((float)selisih - 8.25)/(10-8.25);
	}

	else{ERROR_DATA[4] = 1;}

	final_angel[RIGHT_FOLLOW] = (ERROR_DATA[0]*angel_low)  + (ERROR_DATA[1]*angel_med_low)  + (ERROR_DATA[2]*angel_medium) + (ERROR_DATA[3]*angel_med_high) + (ERROR_DATA[4]*angel_high);
	Defuzzy_follow_kanan = ERROR_DATA[0] + ERROR_DATA[1] + ERROR_DATA[2] + ERROR_DATA[3] + ERROR_DATA[4];
	final_angel[RIGHT_FOLLOW] = final_angel[RIGHT_FOLLOW]/Defuzzy_follow_kanan;
}

void Fuzzy_Follow_kiri(void)
{
	selisih = Ping[PING_ASKEW_LEFT] - Fuzzy_FKR_SP;
	if((selisih == 1) || (selisih == -1)){selisih = 0;}
//	else{selisih = abs(selisih);}
	selisih = abs(selisih);

		//Error kecil
		if(selisih <= 3 ){ERROR_DATA[0] = 1; }
		else if(selisih > 3 && selisih <= 4.75)
		{
			ERROR_DATA[0]= ((float)selisih - 3.0)/(4.75-3.0);
		}
		else if(selisih > 4.75 && selisih <= 6.75)
		{
			ERROR_DATA[0]= ((float)selisih - 4.75)/(6.75-4.75);
		}
		else{ERROR_DATA[0] = 0;}

		//Error med kecil
		if(selisih <= 3){ERROR_DATA[1]=0;}
		else if(selisih > 3 && selisih <= 4.75)
		{
			ERROR_DATA[1]= ((float)selisih - 3.0)/(4.75-3.0);
		}
		else{ERROR_DATA[1]= 0;}

		//Error sedang
		if(selisih <= 4.75){ERROR_DATA[2] = 0;}
		else if(selisih > 4.75 && selisih <= 6.5)
		{
			ERROR_DATA[2]= ((float)selisih - 4.75)/(6.5-4.75);
		}
		else if(selisih > 6.5 && selisih <= 8.25)
		{
			ERROR_DATA[2]= ((float)selisih - 6.5)/(8.25-6.5);
		}
		else{ERROR_DATA[2] = 0;}

		//Error med besar
		if(selisih <= 8.25){ERROR_DATA[3]=0;}
			else if(selisih > 8.25 && selisih <= 10)
			{
				ERROR_DATA[3]= ((float)selisih - 8.25)/(10.0-8.25);
			}
			else{ERROR_DATA[3]= 0;}

		//Error besar
		if(selisih <= 6.5){ERROR_DATA[2] = 0;}
		else if(selisih > 6.5 && selisih <= 8.25)
		{
			ERROR_DATA[4]= ((float)selisih - 6.5)/(8.25-6.5);
		}
		else if(selisih > 8.25 && selisih <= 10)
		{
			ERROR_DATA[4]= ((float)selisih - 8.25)/(10-8.25);
		}

		else{ERROR_DATA[4] = 1;}

		final_angel[LEFT_FOLLOW] = (ERROR_DATA[0]*angel_low)  + (ERROR_DATA[1]*angel_med_low)  + (ERROR_DATA[2]*angel_medium) + (ERROR_DATA[3]*angel_med_high) + (ERROR_DATA[4]*angel_high);
		Defuzzy_follow_kiri = ERROR_DATA[0] + ERROR_DATA[1] + ERROR_DATA[2] + ERROR_DATA[3] + ERROR_DATA[4];
		final_angel[LEFT_FOLLOW] = final_angel[LEFT_FOLLOW]/Defuzzy_follow_kiri;
}

/*
 * WALL FOLLOWING FUNCTIONS
 */


/*
 * func : void BW_PID_Init(void)
 * brief: initialize PID variables
 * param: N/A
 * Programmer's Note: This function only required to be called once in the early initialization
 * 					  Call this function in the BW_Initialization function
 */
void BW_PID_Init(void)
{
	Fuzzy_FKR_SP = 16;
	CAT_DETECTOR=CAT_DIACTIVATED;
	CALC_EN = 1;
	RIGHT_COUNTER = 0;
	LEFT_COUNTER = 0;
	speed_cnt = 0;
	//BW PID WALL FOLLOWING RIGHT RULE
	PID_F_R.P[0]=0;
	PID_F_R.P[1]=0;
	PID_F_R.P[2]=0;
	PID_F_R.I[0]=0;
	PID_F_R.I[1]=0;
	PID_F_R.I[2]=0;
	PID_F_R.D[0]=0;
	PID_F_R.D[1]=0;
	PID_F_R.D[2]=0;

	//DEFAULT FOLLOW MAJU
//	PID_F_R.Kp=20; untuk mov fwd tx delay 700
	PID_F_R.Kp=2.4;//2.1;//2.6;//2.5;//15.3;//15;
//	PID_F_R.Kp=3.9;//15.3;//15;
	PID_F_R.Ki=0;
	PID_F_R.Kd=0;

//	PID_F_R.Kp=3;
//	PID_F_R.Ki=6;
//	PID_F_R.Kd=0.675;

//	PID_F_R.Kp=2;
//	PID_F_R.Ki=2;
//	PID_F_R.Kd=1;

	PID_F_R.Ts=0.005;

	//NEW METHOD
//	PID_F_R.Kp=6;
//	PID_F_R.Ki=1;
//	PID_F_R.Kd=1;
//	PID_F_R.Ts=1;

	//===FIX 11/10/16===//
	PID_F_R.set_point_upper=15;
	PID_F_R.set_point_lower=14;
	PID_F_R.set_point=14;

//	PID_F_R.set_point_upper=20;
//	PID_F_R.set_point_lower=16;
//	PID_F_R.set_point=16;
	//==================//
//	PID_F_R.set_point_upper=20;
//	PID_F_R.set_point_lower=16;
//	PID_F_R.set_point=16;

/*	PID_F_R.error[0]=0;
	PID_F_R.error[1]=0;
	PID_F_R.error[2]=0;*/
	PID_F_R_OLD.error[0]=PID_F_R.error[0];
	PID_F_R_OLD.error[1]=PID_F_R.error[1];
	PID_F_R_OLD.error[2]=PID_F_R.error[2];
	PID_F_R.error[0]=0;
	PID_F_R.error[1]=0;
	PID_F_R.error[2]=0;
	PID_F_R.pid_value[0]=0;
	PID_F_R.pid_value[1]=0;
	PID_F_R.pid_value[2]=0;
	PID_F_L.P[1]=0;
	PID_F_L.P[2]=0;
	PID_F_L.I[0]=0;
	PID_F_L.I[1]=0;
	PID_F_L.I[2]=0;
	PID_F_L.D[0]=0;
	PID_F_L.D[1]=0;
	PID_F_L.D[2]=0;

	//DEFAULT FOLLOW MAJU
//	PID_F_L.Kp=20; untuk mov fwd tx delay 700
	PID_F_L.Kp=2.4;//2.1;//2.6;//2.5;//15.3;//15;
//	PID_F_L.Kp=3.9;//15.3;//15;
	PID_F_L.Ki=0;
	PID_F_L.Kd=0;
	PID_F_L.Ts=0.005;

/*	PID_F_L.error[0]=0;
	PID_F_L.error[1]=0;
	PID_F_L.error[2]=0;*/

	PID_F_L_OLD.error[0]=PID_F_L.error[0];
	PID_F_L_OLD.error[1]=PID_F_L.error[1];
	PID_F_L_OLD.error[2]=PID_F_L.error[2];
	PID_F_L.error[0]=0;
	PID_F_L.error[1]=0;
	PID_F_L.error[2]=0;

	PID_F_L.pid_value[0]=0;
	PID_F_L.pid_value[1]=0;
	PID_F_L.pid_value[2]=0;

	PID_F_L.set_point=14;
	PID_F_L.set_point_upper=15;
	PID_F_L.set_point_lower=14;

	//BW PID WALL CENTERING DEFLECT RIGHT RULE
	PID_DFL_R.P[0]=0;
	PID_DFL_R.P[1]=0;
	PID_DFL_R.P[2]=0;
	PID_DFL_R.I[0]=0;
	PID_DFL_R.I[1]=0;
	PID_DFL_R.I[2]=0;
	PID_DFL_R.D[0]=0;
	PID_DFL_R.D[1]=0;
	PID_DFL_R.D[2]=0;
	PID_DFL_R.Kp=4;
	PID_DFL_R.Ki=4;
	PID_DFL_R.Kd=3;
	PID_DFL_R.Ts=1;
	PID_DFL_R.error[0]=0;
	PID_DFL_R.error[1]=0;
	PID_DFL_R.error[2]=0;
	PID_DFL_R.pid_value[0]=0;
	PID_DFL_R.pid_value[1]=0;
	PID_DFL_R.pid_value[2]=0;
	PID_DFL_R.set_point=16;

	//BW PID WALL CENTERING DEFLECT RIGHT RULE
	PID_DFL_L.P[0]=0;
	PID_DFL_L.P[1]=0;
	PID_DFL_L.P[2]=0;
	PID_DFL_L.I[0]=0;
	PID_DFL_L.I[1]=0;
	PID_DFL_L.I[2]=0;
	PID_DFL_L.D[0]=0;
	PID_DFL_L.D[1]=0;
	PID_DFL_L.D[2]=0;
	PID_DFL_L.Kp=1;
	PID_DFL_L.Ki=0;
	PID_DFL_L.Kd=0;
	PID_DFL_L.Ts=1;
	PID_DFL_L.error[0]=0;
	PID_DFL_L.error[1]=0;
	PID_DFL_L.error[2]=0;
	PID_DFL_L.pid_value[0]=0;
	PID_DFL_L.pid_value[1]=0;
	PID_DFL_L.pid_value[2]=0;
	PID_DFL_L.set_point=16;
}

/*
 * func : void BW_PID_Init_Revers(void)
 * brief: initialize PID variables
 * param: N/A
 * Programmer's Note: This function only required to be called once in the early initialization
 * 					  Call this function in the BW_Initialization function
 */
void BW_PID_Init_Reverse(void)
{
	//BW PID WALL FOLLOWING RIGHT RULE
	PID_F_R.P[0]=0;
	PID_F_R.P[1]=0;
	PID_F_R.P[2]=0;
	PID_F_R.I[0]=0;
	PID_F_R.I[1]=0;
	PID_F_R.I[2]=0;
	PID_F_R.D[0]=0;
	PID_F_R.D[1]=0;
	PID_F_R.D[2]=0;

//	//DEFAULT FOLLOW MAJU
//	PID_F_R.Kp=20;
//	PID_F_R.Ki=0;
//	PID_F_R.Kd=0;
	//DEFAULT
	PID_F_R.Kp=1;
	PID_F_R.Ki=0;
	PID_F_R.Kd=0;

//	PID_F_R.Kp=3;
//	PID_F_R.Ki=6;
//	PID_F_R.Kd=0.675;

//	PID_F_R.Kp=2;
//	PID_F_R.Ki=2;
//	PID_F_R.Kd=1;

	PID_F_R.Ts=1;

	//NEW METHOD
//	PID_F_R.Kp=6;
//	PID_F_R.Ki=1;
//	PID_F_R.Kd=1;
//	PID_F_R.Ts=1;

	//===FIX 11/10/16===//
	PID_F_R.set_point_upper=13;
	PID_F_R.set_point_lower=12;
	PID_F_R.set_point=12;

//	PID_F_R.set_point_upper=20;
//	PID_F_R.set_point_lower=16;
//	PID_F_R.set_point=16;
	//==================//
//	PID_F_R.set_point_upper=20;
//	PID_F_R.set_point_lower=16;
//	PID_F_R.set_point=16;

	PID_F_R.error[0]=0;
	PID_F_R.error[1]=0;
	PID_F_R.error[2]=0;
	PID_F_R.pid_value[0]=0;
	PID_F_R.pid_value[1]=0;
	PID_F_R.pid_value[2]=0;
	PID_F_L.P[1]=0;
	PID_F_L.P[2]=0;
	PID_F_L.I[0]=0;
	PID_F_L.I[1]=0;
	PID_F_L.I[2]=0;
	PID_F_L.D[0]=0;
	PID_F_L.D[1]=0;
	PID_F_L.D[2]=0;

//	//DEFAULT FOLLOW MAJU
//	PID_F_L.Kp=20;
//	PID_F_L.Ki=0;
//	PID_F_L.Kd=0;

	PID_F_L.Kp=1;
	PID_F_L.Ki=0;
	PID_F_L.Kd=0;
	PID_F_L.Ts=1;

	PID_F_L.error[0]=0;
	PID_F_L.error[1]=0;
	PID_F_L.error[2]=0;

	PID_F_L.pid_value[0]=0;
	PID_F_L.pid_value[1]=0;
	PID_F_L.pid_value[2]=0;

	PID_F_L.set_point=12;
	PID_F_L.set_point_upper=13;
	PID_F_L.set_point_lower=12;

	//BW PID WALL CENTERING DEFLECT RIGHT RULE
	PID_DFL_R.P[0]=0;
	PID_DFL_R.P[1]=0;
	PID_DFL_R.P[2]=0;
	PID_DFL_R.I[0]=0;
	PID_DFL_R.I[1]=0;
	PID_DFL_R.I[2]=0;
	PID_DFL_R.D[0]=0;
	PID_DFL_R.D[1]=0;
	PID_DFL_R.D[2]=0;
	PID_DFL_R.Kp=4;
	PID_DFL_R.Ki=4;
	PID_DFL_R.Kd=3;
	PID_DFL_R.Ts=1;
	PID_DFL_R.error[0]=0;
	PID_DFL_R.error[1]=0;
	PID_DFL_R.error[2]=0;
	PID_DFL_R.pid_value[0]=0;
	PID_DFL_R.pid_value[1]=0;
	PID_DFL_R.pid_value[2]=0;
	PID_DFL_R.set_point=16;

	//BW PID WALL CENTERING DEFLECT RIGHT RULE
	PID_DFL_L.P[0]=0;
	PID_DFL_L.P[1]=0;
	PID_DFL_L.P[2]=0;
	PID_DFL_L.I[0]=0;
	PID_DFL_L.I[1]=0;
	PID_DFL_L.I[2]=0;
	PID_DFL_L.D[0]=0;
	PID_DFL_L.D[1]=0;
	PID_DFL_L.D[2]=0;
	PID_DFL_L.Kp=1;
	PID_DFL_L.Ki=0;
	PID_DFL_L.Kd=0;
	PID_DFL_L.Ts=1;
	PID_DFL_L.error[0]=0;
	PID_DFL_L.error[1]=0;
	PID_DFL_L.error[2]=0;
	PID_DFL_L.pid_value[0]=0;
	PID_DFL_L.pid_value[1]=0;
	PID_DFL_L.pid_value[2]=0;
	PID_DFL_L.set_point=16;
}


/*
 * func : void BW_PID_Init(void)
 * brief: initialize PID variables
 * param: N/A
 * Programmer's Note: This function only required to be called once in the early initialization
 * 					  Call this function in the BW_Initialization function
 */
void BW_PID_Init_FAR(void)
{
	Fuzzy_FKR_SP = 17;
	CAT_DETECTOR=CAT_ACTIVATED;
	CALC_EN = 1;
	RIGHT_COUNTER = 0;
	LEFT_COUNTER = 0;
	speed_cnt = 0;
	//BW PID WALL FOLLOWING RIGHT RULE
	PID_F_R.P[0]=0;
	PID_F_R.P[1]=0;
	PID_F_R.P[2]=0;
	PID_F_R.I[0]=0;
	PID_F_R.I[1]=0;
	PID_F_R.I[2]=0;
	PID_F_R.D[0]=0;
	PID_F_R.D[1]=0;
	PID_F_R.D[2]=0;

//	//DEFAULT
//	PID_F_R.Kp=45;
//	PID_F_R.Ki=1;
//	PID_F_R.Kd=2;
	//DEFAULT
//	PID_F_R.Kp=20; untuk mov fwd tx delay 700
	PID_F_R.Kp=2.4;//2.4;//2.4;//17;
	PID_F_R.Ki=0;
	PID_F_R.Kd=0;

//	PID_F_R.Kp=3;
//	PID_F_R.Ki=6;
//	PID_F_R.Kd=0.675;

//	PID_F_R.Kp=2;
//	PID_F_R.Ki=2;
//	PID_F_R.Kd=1;

	PID_F_R.Ts=0.005;

	//NEW METHOD
//	PID_F_R.Kp=6;
//	PID_F_R.Ki=1;
//	PID_F_R.Kd=1;
//	PID_F_R.Ts=1;

	//===FIX 11/10/16===//
	PID_F_R.set_point_upper=15;
	PID_F_R.set_point_lower=14;
	PID_F_R.set_point=15;

//	PID_F_R.set_point_upper=20;
//	PID_F_R.set_point_lower=16;
//	PID_F_R.set_point=16;
	//==================//
//	PID_F_R.set_point_upper=20;
//	PID_F_R.set_point_lower=16;
//	PID_F_R.set_point=16;

/*	PID_F_R.error[0]=0;
	PID_F_R.error[1]=0;
	PID_F_R.error[2]=0;*/
	PID_F_R_OLD.error[0]=PID_F_R.error[0];
	PID_F_R_OLD.error[1]=PID_F_R.error[1];
	PID_F_R_OLD.error[2]=PID_F_R.error[2];
	PID_F_R.error[0]=0;
	PID_F_R.error[1]=0;
	PID_F_R.error[2]=0;
	PID_F_R.pid_value[0]=0;
	PID_F_R.pid_value[1]=0;
	PID_F_R.pid_value[2]=0;
	PID_F_L.P[1]=0;
	PID_F_L.P[2]=0;
	PID_F_L.I[0]=0;
	PID_F_L.I[1]=0;
	PID_F_L.I[2]=0;
	PID_F_L.D[0]=0;
	PID_F_L.D[1]=0;
	PID_F_L.D[2]=0;

//	PID_F_L.Kp=20; untuk mov fwd tx delay 700
	PID_F_L.Kp=2.4;//2.4;//2.4;//2.4;//17;
	PID_F_L.Ki=0;
	PID_F_L.Kd=0;
	PID_F_L.Ts=0.005;

//	PID_F_L.Kp=30;
//	PID_F_L.Ki=2;
//	PID_F_L.Kd=0;
//	PID_F_L.Ts=1;

/*	PID_F_L.error[0]=0;
	PID_F_L.error[1]=0;
	PID_F_L.error[2]=0;*/

	PID_F_L_OLD.error[0]=PID_F_L.error[0];
	PID_F_L_OLD.error[1]=PID_F_L.error[1];
	PID_F_L_OLD.error[2]=PID_F_L.error[2];
	PID_F_L.error[0]=0;
	PID_F_L.error[1]=0;
	PID_F_L.error[2]=0;

	PID_F_L.pid_value[0]=0;
	PID_F_L.pid_value[1]=0;
	PID_F_L.pid_value[2]=0;

	PID_F_L.set_point=14;
	PID_F_L.set_point_upper=15;
	PID_F_L.set_point_lower=14;

	//BW PID WALL CENTERING DEFLECT RIGHT RULE
	PID_DFL_R.P[0]=0;
	PID_DFL_R.P[1]=0;
	PID_DFL_R.P[2]=0;
	PID_DFL_R.I[0]=0;
	PID_DFL_R.I[1]=0;
	PID_DFL_R.I[2]=0;
	PID_DFL_R.D[0]=0;
	PID_DFL_R.D[1]=0;
	PID_DFL_R.D[2]=0;
	PID_DFL_R.Kp=4;
	PID_DFL_R.Ki=4;
	PID_DFL_R.Kd=3;
	PID_DFL_R.Ts=1;
	PID_DFL_R.error[0]=0;
	PID_DFL_R.error[1]=0;
	PID_DFL_R.error[2]=0;
	PID_DFL_R.pid_value[0]=0;
	PID_DFL_R.pid_value[1]=0;
	PID_DFL_R.pid_value[2]=0;
	PID_DFL_R.set_point=16;

	//BW PID WALL CENTERING DEFLECT RIGHT RULE
	PID_DFL_L.P[0]=0;
	PID_DFL_L.P[1]=0;
	PID_DFL_L.P[2]=0;
	PID_DFL_L.I[0]=0;
	PID_DFL_L.I[1]=0;
	PID_DFL_L.I[2]=0;
	PID_DFL_L.D[0]=0;
	PID_DFL_L.D[1]=0;
	PID_DFL_L.D[2]=0;
	PID_DFL_L.Kp=1;
	PID_DFL_L.Ki=0;
	PID_DFL_L.Kd=0;
	PID_DFL_L.Ts=1;
	PID_DFL_L.error[0]=0;
	PID_DFL_L.error[1]=0;
	PID_DFL_L.error[2]=0;
	PID_DFL_L.pid_value[0]=0;
	PID_DFL_L.pid_value[1]=0;
	PID_DFL_L.pid_value[2]=0;
	PID_DFL_L.set_point=16;
}

void BW_PID_Init_Room(void)
{
	Fuzzy_FKR_SP = 11;
	CALC_EN = 1;
	RIGHT_COUNTER = 0;
	LEFT_COUNTER = 0;
	speed_cnt = 0;
	//BW PID WALL FOLLOWING RIGHT RULE
	PID_F_R.P[0]=0;
	PID_F_R.P[1]=0;
	PID_F_R.P[2]=0;
	PID_F_R.I[0]=0;
	PID_F_R.I[1]=0;
	PID_F_R.I[2]=0;
	PID_F_R.D[0]=0;
	PID_F_R.D[1]=0;
	PID_F_R.D[2]=0;

	//DEFAULT
	PID_F_R.Kp=3.3;//14.7;//17;
	PID_F_R.Ki=0;
	PID_F_R.Kd=0;

//	PID_F_R.Kp=2;
//	PID_F_R.Ki=2;
//	PID_F_R.Kd=1;

	PID_F_R.Ts=0.005;

	//NEW METHOD
//	PID_F_R.Kp=6;
//	PID_F_R.Ki=1;
//	PID_F_R.Kd=1;
//	PID_F_R.Ts=1;

	//===FIX 11/10/16===//
	PID_F_R.set_point_upper=12;
	PID_F_R.set_point_lower=11;
	PID_F_R.set_point=11;

//	PID_F_R.set_point_upper=20;
//	PID_F_R.set_point_lower=16;
//	PID_F_R.set_point=16;
	//==================//
//	PID_F_R.set_point_upper=20;
//	PID_F_R.set_point_lower=16;
//	PID_F_R.set_point=16;

/*	PID_F_R.error[0]=0;
	PID_F_R.error[1]=0;
	PID_F_R.error[2]=0;*/
	PID_F_R_OLD.error[0]=PID_F_R.error[0];
	PID_F_R_OLD.error[1]=PID_F_R.error[1];
	PID_F_R_OLD.error[2]=PID_F_R.error[2];
	PID_F_R.error[0]=0;
	PID_F_R.error[1]=0;
	PID_F_R.error[2]=0;
	PID_F_R.pid_value[0]=0;
	PID_F_R.pid_value[1]=0;
	PID_F_R.pid_value[2]=0;
	PID_F_L.P[1]=0;
	PID_F_L.P[2]=0;
	PID_F_L.I[0]=0;
	PID_F_L.I[1]=0;
	PID_F_L.I[2]=0;
	PID_F_L.D[0]=0;
	PID_F_L.D[1]=0;
	PID_F_L.D[2]=0;

	PID_F_L.Kp=3.3;//14.7;//17;
	PID_F_L.Ki=0;
	PID_F_L.Kd=0;
	PID_F_L.Ts=0.005;

/*	PID_F_L.error[0]=0;
	PID_F_L.error[1]=0;
	PID_F_L.error[2]=0;*/

	PID_F_L_OLD.error[0]=PID_F_L.error[0];
	PID_F_L_OLD.error[1]=PID_F_L.error[1];
	PID_F_L_OLD.error[2]=PID_F_L.error[2];
	PID_F_L.error[0]=0;
	PID_F_L.error[1]=0;
	PID_F_L.error[2]=0;

	PID_F_L.pid_value[0]=0;
	PID_F_L.pid_value[1]=0;
	PID_F_L.pid_value[2]=0;

	PID_F_L.set_point=11;
	PID_F_L.set_point_upper=12;
	PID_F_L.set_point_lower=11;

	//BW PID WALL CENTERING DEFLECT RIGHT RULE
	PID_DFL_R.P[0]=0;
	PID_DFL_R.P[1]=0;
	PID_DFL_R.P[2]=0;
	PID_DFL_R.I[0]=0;
	PID_DFL_R.I[1]=0;
	PID_DFL_R.I[2]=0;
	PID_DFL_R.D[0]=0;
	PID_DFL_R.D[1]=0;
	PID_DFL_R.D[2]=0;
	PID_DFL_R.Kp=4;
	PID_DFL_R.Ki=4;
	PID_DFL_R.Kd=3;
	PID_DFL_R.Ts=1;
	PID_DFL_R.error[0]=0;
	PID_DFL_R.error[1]=0;
	PID_DFL_R.error[2]=0;
	PID_DFL_R.pid_value[0]=0;
	PID_DFL_R.pid_value[1]=0;
	PID_DFL_R.pid_value[2]=0;
	PID_DFL_R.set_point=16;

	//BW PID WALL CENTERING DEFLECT RIGHT RULE
	PID_DFL_L.P[0]=0;
	PID_DFL_L.P[1]=0;
	PID_DFL_L.P[2]=0;
	PID_DFL_L.I[0]=0;
	PID_DFL_L.I[1]=0;
	PID_DFL_L.I[2]=0;
	PID_DFL_L.D[0]=0;
	PID_DFL_L.D[1]=0;
	PID_DFL_L.D[2]=0;
	PID_DFL_L.Kp=1;
	PID_DFL_L.Ki=0;
	PID_DFL_L.Kd=0;
	PID_DFL_L.Ts=1;
	PID_DFL_L.error[0]=0;
	PID_DFL_L.error[1]=0;
	PID_DFL_L.error[2]=0;
	PID_DFL_L.pid_value[0]=0;
	PID_DFL_L.pid_value[1]=0;
	PID_DFL_L.pid_value[2]=0;
	PID_DFL_L.set_point=16;
}

void BW_PID_Init_Furniture(void)
{
	Fuzzy_FKR_SP = 10;
	CALC_EN = 1;
	RIGHT_COUNTER = 0;
	LEFT_COUNTER = 0;
	speed_cnt = 0;
	//BW PID WALL FOLLOWING RIGHT RULE
	PID_F_R.P[0]=0;
	PID_F_R.P[1]=0;
	PID_F_R.P[2]=0;
	PID_F_R.I[0]=0;
	PID_F_R.I[1]=0;
	PID_F_R.I[2]=0;
	PID_F_R.D[0]=0;
	PID_F_R.D[1]=0;
	PID_F_R.D[2]=0;

	//DEFAULT
	PID_F_R.Kp=2.7;//6.5;
	PID_F_R.Ki=0;
	PID_F_R.Kd=0;

//	PID_F_R.Kp=2;
//	PID_F_R.Ki=2;
//	PID_F_R.Kd=1;

	PID_F_R.Ts=0.005;

	//NEW METHOD
//	PID_F_R.Kp=6;
//	PID_F_R.Ki=1;
//	PID_F_R.Kd=1;
//	PID_F_R.Ts=1;

	//===FIX 11/10/16===//
	PID_F_R.set_point_upper=11;
	PID_F_R.set_point_lower=10;
	PID_F_R.set_point=10;

//	PID_F_R.set_point_upper=20;
//	PID_F_R.set_point_lower=16;
//	PID_F_R.set_point=16;
	//==================//
//	PID_F_R.set_point_upper=20;
//	PID_F_R.set_point_lower=16;
//	PID_F_R.set_point=16;

/*	PID_F_R.error[0]=0;
	PID_F_R.error[1]=0;
	PID_F_R.error[2]=0;*/
	PID_F_R_OLD.error[0]=PID_F_R.error[0];
	PID_F_R_OLD.error[1]=PID_F_R.error[1];
	PID_F_R_OLD.error[2]=PID_F_R.error[2];
	PID_F_R.error[0]=0;
	PID_F_R.error[1]=0;
	PID_F_R.error[2]=0;
	PID_F_R.pid_value[0]=0;
	PID_F_R.pid_value[1]=0;
	PID_F_R.pid_value[2]=0;
	PID_F_L.P[1]=0;
	PID_F_L.P[2]=0;
	PID_F_L.I[0]=0;
	PID_F_L.I[1]=0;
	PID_F_L.I[2]=0;
	PID_F_L.D[0]=0;
	PID_F_L.D[1]=0;
	PID_F_L.D[2]=0;

	PID_F_L.Kp=2.7;//6.5;
	PID_F_L.Ki=0;
	PID_F_L.Kd=0;
	PID_F_L.Ts=0.005;

/*	PID_F_L.error[0]=0;
	PID_F_L.error[1]=0;
	PID_F_L.error[2]=0;*/

	PID_F_L_OLD.error[0]=PID_F_L.error[0];
	PID_F_L_OLD.error[1]=PID_F_L.error[1];
	PID_F_L_OLD.error[2]=PID_F_L.error[2];
	PID_F_L.error[0]=0;
	PID_F_L.error[1]=0;
	PID_F_L.error[2]=0;

	PID_F_L.pid_value[0]=0;
	PID_F_L.pid_value[1]=0;
	PID_F_L.pid_value[2]=0;

	PID_F_L.set_point_upper=11;
	PID_F_L.set_point=10;
	PID_F_L.set_point_lower=10;

	//BW PID WALL CENTERING DEFLECT RIGHT RULE
	PID_DFL_R.P[0]=0;
	PID_DFL_R.P[1]=0;
	PID_DFL_R.P[2]=0;
	PID_DFL_R.I[0]=0;
	PID_DFL_R.I[1]=0;
	PID_DFL_R.I[2]=0;
	PID_DFL_R.D[0]=0;
	PID_DFL_R.D[1]=0;
	PID_DFL_R.D[2]=0;
	PID_DFL_R.Kp=4;
	PID_DFL_R.Ki=4;
	PID_DFL_R.Kd=3;
	PID_DFL_R.Ts=1;
	PID_DFL_R.error[0]=0;
	PID_DFL_R.error[1]=0;
	PID_DFL_R.error[2]=0;
	PID_DFL_R.pid_value[0]=0;
	PID_DFL_R.pid_value[1]=0;
	PID_DFL_R.pid_value[2]=0;
	PID_DFL_R.set_point=16;

	//BW PID WALL CENTERING DEFLECT RIGHT RULE
	PID_DFL_L.P[0]=0;
	PID_DFL_L.P[1]=0;
	PID_DFL_L.P[2]=0;
	PID_DFL_L.I[0]=0;
	PID_DFL_L.I[1]=0;
	PID_DFL_L.I[2]=0;
	PID_DFL_L.D[0]=0;
	PID_DFL_L.D[1]=0;
	PID_DFL_L.D[2]=0;
	PID_DFL_L.Kp=1;
	PID_DFL_L.Ki=0;
	PID_DFL_L.Kd=0;
	PID_DFL_L.Ts=1;
	PID_DFL_L.error[0]=0;
	PID_DFL_L.error[1]=0;
	PID_DFL_L.error[2]=0;
	PID_DFL_L.pid_value[0]=0;
	PID_DFL_L.pid_value[1]=0;
	PID_DFL_L.pid_value[2]=0;
	PID_DFL_L.set_point=16;
}

/*
 * func : void BW_PID_Init(void)
 * brief: initialize PID variables
 * param: N/A
 * Programmer's Note: This function only required to be called once in the early initialization
 * 					  Call this function in the BW_Initialization function
 */
void BW_PID_Flame_Init(void)
{
	CAT_DETECTOR=CAT_DIACTIVATED;
	//BW PID WALL FOLLOWING RIGHT RULE
	PID_F_R.P[0]=0;
	PID_F_R.P[1]=0;
	PID_F_R.P[2]=0;
	PID_F_R.I[0]=0;
	PID_F_R.I[1]=0;
	PID_F_R.I[2]=0;
	PID_F_R.D[0]=0;
	PID_F_R.D[1]=0;
	PID_F_R.D[2]=0;

	//DEFAULT FOLLOW MAJU
	PID_F_R.Kp=30;
	PID_F_R.Ki=0;
	PID_F_R.Kd=0;

//	PID_F_R.Kp=3;
//	PID_F_R.Ki=6;
//	PID_F_R.Kd=0.675;

//	PID_F_R.Kp=2;
//	PID_F_R.Ki=2;
//	PID_F_R.Kd=1;

	PID_F_R.Ts=1;

	//NEW METHOD
//	PID_F_R.Kp=6;
//	PID_F_R.Ki=1;
//	PID_F_R.Kd=1;
//	PID_F_R.Ts=1;

	//===FIX 11/10/16===//
	PID_F_R.set_point=4;

//	PID_F_R.set_point_upper=20;
//	PID_F_R.set_point_lower=16;
//	PID_F_R.set_point=16;
	//==================//
//	PID_F_R.set_point_upper=20;
//	PID_F_R.set_point_lower=16;
//	PID_F_R.set_point=16;

	PID_F_R.error[0]=0;
	PID_F_R.error[1]=0;
	PID_F_R.error[2]=0;
	PID_F_R.pid_value[0]=0;
	PID_F_R.pid_value[1]=0;
	PID_F_R.pid_value[2]=0;
	PID_F_L.P[1]=0;
	PID_F_L.P[2]=0;
	PID_F_L.I[0]=0;
	PID_F_L.I[1]=0;
	PID_F_L.I[2]=0;
	PID_F_L.D[0]=0;
	PID_F_L.D[1]=0;
	PID_F_L.D[2]=0;

	//DEFAULT FOLLOW MAJU
	PID_F_L.Kp=30;
	PID_F_L.Ki=0;
	PID_F_L.Kd=0;
	PID_F_L.Ts=1;

	PID_F_L.error[0]=0;
	PID_F_L.error[1]=0;
	PID_F_L.error[2]=0;

	PID_F_L.pid_value[0]=0;
	PID_F_L.pid_value[1]=0;
	PID_F_L.pid_value[2]=0;

	PID_F_L.set_point=4;

	//BW PID WALL CENTERING DEFLECT RIGHT RULE
	PID_DFL_R.P[0]=0;
	PID_DFL_R.P[1]=0;
	PID_DFL_R.P[2]=0;
	PID_DFL_R.I[0]=0;
	PID_DFL_R.I[1]=0;
	PID_DFL_R.I[2]=0;
	PID_DFL_R.D[0]=0;
	PID_DFL_R.D[1]=0;
	PID_DFL_R.D[2]=0;
	PID_DFL_R.Kp=4;
	PID_DFL_R.Ki=4;
	PID_DFL_R.Kd=3;
	PID_DFL_R.Ts=1;
	PID_DFL_R.error[0]=0;
	PID_DFL_R.error[1]=0;
	PID_DFL_R.error[2]=0;
	PID_DFL_R.pid_value[0]=0;
	PID_DFL_R.pid_value[1]=0;
	PID_DFL_R.pid_value[2]=0;
	PID_DFL_R.set_point=16;

	//BW PID WALL CENTERING DEFLECT RIGHT RULE
	PID_DFL_L.P[0]=0;
	PID_DFL_L.P[1]=0;
	PID_DFL_L.P[2]=0;
	PID_DFL_L.I[0]=0;
	PID_DFL_L.I[1]=0;
	PID_DFL_L.I[2]=0;
	PID_DFL_L.D[0]=0;
	PID_DFL_L.D[1]=0;
	PID_DFL_L.D[2]=0;
	PID_DFL_L.Kp=1;
	PID_DFL_L.Ki=0;
	PID_DFL_L.Kd=0;
	PID_DFL_L.Ts=1;
	PID_DFL_L.error[0]=0;
	PID_DFL_L.error[1]=0;
	PID_DFL_L.error[2]=0;
	PID_DFL_L.pid_value[0]=0;
	PID_DFL_L.pid_value[1]=0;
	PID_DFL_L.pid_value[2]=0;
	PID_DFL_L.set_point=16;
}

/*
 * func      : void PID_Calc_LeftRule(void)
 * brief     : PID Controller Calculations
 * param     : N/A
 * Written By: Ryan
 * Revised By: Reyhan
 * Ver       : 1
 * Programmer's Note: PID Formula rewritten with guidance from KRPAI Senior, Desta.
 * 					  This function should be called everytime PID function executed.
 *
 * Rev. Notes :	Function Rewritten for decreasing sensitivity, which reduce oscilliation
 *				and increasing movement speed.
 */
void PID_Calc_RightRule(void)
{

	/*
	 * Update Nilai Variable PID & Set-Point Error
	 */
	PID_F_R.pid_value[2]=PID_F_R.pid_value[1];
	PID_F_R.pid_value[1]=PID_F_R.pid_value[0];

	PID_F_R.error[2]=PID_F_R.error[1];
	PID_F_R.error[1]=PID_F_R.error[0];

//	PID_F_R.error[0] = Ping[PING_ASKEW_RIGHT] - PID_F_R.set_point;

	if ((Ping[PING_ASKEW_RIGHT] <= (PID_F_R.set_point)) && (Ping[PING_ASKEW_RIGHT]) >= PID_F_R.set_point+1) {PID_F_R.error[0]=0;}
	else PID_F_R.error[0] = Ping[PING_ASKEW_RIGHT] - PID_F_R.set_point;

	if(PID_F_R.error[0] < 0)PID_F_R.error[0]*=1.2;
//	else if (Ping[PING_ASKEW_RIGHT] > PID_F_R.set_point)
//		{
//			PID_F_R.error[0] = Ping[PING_ASKEW_RIGHT] - PID_F_R.set_point;
//		}
//
//	else if (Ping[PING_ASKEW_RIGHT] < PID_F_R.set_point)
//		{
//			PID_F_R.error[0] = PID_F_R.set_point - Ping[PING_ASKEW_RIGHT];
//		}
//	if (SHARP[SHARP_RIGHT]==PID_F_R.set_point) {PID_F_R.error[0]=0;}
//	else if (SHARP[SHARP_RIGHT] > PID_F_R.set_point)
//		{
//			PID_F_R.error[0] = SHARP[SHARP_RIGHT] - PID_F_R.set_point;
//		}
//
//	else if (SHARP[SHARP_RIGHT] < PID_F_R.set_point)
//		{
//			PID_F_R.error[0] = PID_F_R.set_point - SHARP[SHARP_RIGHT];
//		}

	/*
	 * PID FORMULA
	 */
//	PID_F_R.P[2]= PID_F_R.error[0]/*-PID_F_R.error[2]*/;
//	PID_F_R.P[1]= PID_F_R.Kp;
//	PID_F_R.P[0]= PID_F_R.P[1]*PID_F_R.P[2]; //Proportional Controller
//
//	PID_F_R.I[2]= PID_F_R.Ki*PID_F_R.Ts/2;
//	PID_F_R.I[1]= PID_F_R.error[0]+(2*PID_F_R.error[1])+PID_F_R.error[2];
//	PID_F_R.I[0]= PID_F_R.I[2]*PID_F_R.I[1]; //Integral Controller
//
//
//	PID_F_R.D[2]= 2*PID_F_R.Kd/PID_F_R.Ts;
//	PID_F_R.D[1]= PID_F_R.error[0]-(2*PID_F_R.error[1])+PID_F_R.error[2];
//	PID_F_R.D[0]= PID_F_R.D[2]*PID_F_R.D[1]; //Derivative Controller

//	PID_F_R.I= ( (PID_F_R.Ki*PID_F_R.Ts/2)*(PID_F_R.error[0]+(2*PID_F_R.error[1])+PID_F_R.error[2]) );
//	PID_F_R.D= ( (2*PID_F_R.Kd/PID_F_R.Ts)*(PID_F_R.error[0]-(2*PID_F_R.error[1])+PID_F_R.error[2]));

	PID_F_R.P[2]= PID_F_R.error[0]/*-PID_F_R.error[2]*/;
	PID_F_R.P[1]= PID_F_R.Kp;
	PID_F_R.P[0]= PID_F_R.P[1]*PID_F_R.P[2]; //Proportional Controller

	PID_F_R.I[2]= PID_F_R.Ki*PID_F_R.Ts;
	PID_F_R.I[1]= PID_F_R.error[0]+PID_F_R.error[2];
	PID_F_R.I[0]= PID_F_R.I[2]*PID_F_R.I[1]; //Integral Controller

	PID_F_R.D[2]= PID_F_R.Kd/PID_F_R.Ts;
	PID_F_R.D[1]= PID_F_R.error[0]-PID_F_R.error[2];
	PID_F_R.D[0]= PID_F_R.D[2]*PID_F_R.D[1]; //Derivative Controller

	PID_F_R.pid_value[0]= /*PID_F_R.pid_value[2] +*/ PID_F_R.P[0] + PID_F_R.I[0] + PID_F_R.D[0];
	PID_F_R.pid_value[0]=fabsf(PID_F_R.pid_value[0]);
}



/*
 * func      : void PID_Calc_Reverse(void)
 * brief     : PID Controller Calculations
 * param     : N/A
 * Written By: Hafidin
 * Ver       : 1
 * Programmer's Note: PID Formula rewritten with guidance from KRPAI Senior, Desta.
 * 					  This function should be called everytime PID function executed
 */
void PID_Calc_RightRule_Reverse(void)
{
	/*
	 * Update Nilai Variable PID & Set-Point Error
	 */

	PID_F_L.pid_value[2]=PID_F_L.pid_value[1];
	PID_F_L.pid_value[1]=PID_F_L.pid_value[0];

	PID_F_L.error[2]=PID_F_L.error[1];
	PID_F_L.error[1]=PID_F_L.error[0];

	if (Ping[PING_REAR_LEFT]==PID_F_L.set_point) {PID_F_L.error[0]=0;}

	else if (Ping[PING_REAR_LEFT] > PID_F_L.set_point)
		{
			PID_F_L.error[0] = Ping[PING_REAR_LEFT] - PID_F_L.set_point;
		}

	else if (Ping[PING_REAR_LEFT] < PID_F_L.set_point)
		{
			PID_F_L.error[0] = PID_F_L.set_point - Ping[PING_REAR_LEFT];
		}

	/*
	 * PID FORMULA
	 */
	PID_F_L.P[2]= PID_F_L.error[0]-PID_F_L.error[2];
	PID_F_L.P[1]= PID_F_L.Kp;
	PID_F_L.P[0]= PID_F_L.P[1]*PID_F_L.P[2]; //Proportional Controller

	PID_F_L.I[2]= PID_F_L.Ki*PID_F_L.Ts/2;
	PID_F_L.I[1]= PID_F_L.error[0]+(2*PID_F_L.error[1])+PID_F_L.error[2];
	PID_F_L.I[0]= PID_F_L.I[2]*PID_F_L.I[1]; //Integral Controller

	PID_F_L.D[2]= 2*PID_F_L.Kd/PID_F_L.Ts;
	PID_F_L.D[1]= PID_F_L.error[0]-(2*PID_F_L.error[1])+PID_F_L.error[2];
	PID_F_L.D[0]= PID_F_L.D[2]*PID_F_L.D[1]; //Derivative Controller

//	PID_F_L.I= ( (PID_F_L.Ki*PID_F_L.Ts/2)*(PID_F_L.error[0]+(2*PID_F_L.error[1])+PID_F_L.error[2]) );
//	PID_F_L.D= ( (2*PID_F_L.Kd/PID_F_L.Ts)*(PID_F_L.error[0]-(2*PID_F_L.error[1])+PID_F_L.error[2]));

	PID_F_L.pid_value[0]= PID_F_L.pid_value[2] + PID_F_L.P[0] + PID_F_L.I[0] + PID_F_L.D[0];
}

/*
 * PID FOLLOW LEFT RULE
 */

/*
 * func      : void PID_Calc_LeftRule(void)
 * brief     : PID Controller Calculations
 * param     : N/A
 * Written By: Ryan
 * Revised By: Reyhan
 * Ver       : 1
 * Programmer's Note: PID Formula rewritten with guidance from KRPAI Senior, Desta.
 * 					  This function should be called everytime PID function executed.
 *
 * Rev. Notes :	Function Rewritten for decreasing sensitivity, which reduce oscilliation
 * 				and increasing movement speed.
 */
void PID_Calc_LeftRule(void)
{
	/*
	 * Update Nilai Variable PID & Set-Point Error
	 */

	PID_F_L.pid_value[2]=PID_F_L.pid_value[1];
	PID_F_L.pid_value[1]=PID_F_L.pid_value[0];

	PID_F_L.error[2]=PID_F_L.error[1];
	PID_F_L.error[1]=PID_F_L.error[0];

//	PID_F_L.error[0] = Ping[PING_ASKEW_LEFT] - PID_F_L.set_point;

	if ((Ping[PING_ASKEW_LEFT] <= (PID_F_L.set_point)) && (Ping[PING_ASKEW_LEFT]) >= PID_F_L.set_point+1){PID_F_L.error[0]=0;}
	else PID_F_L.error[0] = Ping[PING_ASKEW_LEFT] - PID_F_L.set_point;

	if(PID_F_L.error[0] < 0)PID_F_L.error[0]*=1.2;

//	else if (Ping[PING_ASKEW_LEFT] > PID_F_L.set_point)
//		{
//			PID_F_L.error[0] = Ping[PING_ASKEW_LEFT] - PID_F_L.set_point;
//		}
//
//	else if (Ping[PING_ASKEW_LEFT] < PID_F_L.set_point)
//		{
//			PID_F_L.error[0] = PID_F_L.set_point - Ping[PING_ASKEW_LEFT];
//		}

//	if (SHARP[SHARP_LEFT]==PID_F_L.set_point) {PID_F_L.error[0]=0;}
//
//	else if (SHARP[SHARP_LEFT] > PID_F_L.set_point)
//		{
//			PID_F_L.error[0] = SHARP[SHARP_LEFT] - PID_F_L.set_point;
//		}
//
//	else if (SHARP[SHARP_LEFT] < PID_F_L.set_point)
//		{
//			PID_F_L.error[0] = PID_F_L.set_point - SHARP[SHARP_LEFT];
//		}

	/*
	 * PID FORMULA
	 */
//	PID_F_L.P[2]= PID_F_L.error[0]/*-PID_F_L.error[2]*/;
//	PID_F_L.P[1]= PID_F_L.Kp;
//	PID_F_L.P[0]= PID_F_L.P[1]*PID_F_L.P[2]; //Proportional Controller
//
//	PID_F_L.I[2]= PID_F_L.Ki*PID_F_L.Ts/2;
//	PID_F_L.I[1]= PID_F_L.error[0]+(2*PID_F_L.error[1])+PID_F_L.error[2];
//	PID_F_L.I[0]= PID_F_L.I[2]*PID_F_L.I[1]; //Integral Controller
//
//	PID_F_L.D[2]= 2*PID_F_L.Kd/PID_F_L.Ts;
//	PID_F_L.D[1]= PID_F_L.error[0]-(2*PID_F_L.error[1])+PID_F_L.error[2];
//	PID_F_L.D[0]= PID_F_L.D[2]*PID_F_L.D[1]; //Derivative Controller

//	PID_F_L.I= ( (PID_F_L.Ki*PID_F_L.Ts/2)*(PID_F_L.error[0]+(2*PID_F_L.error[1])+PID_F_L.error[2]) );
//	PID_F_L.D= ( (2*PID_F_L.Kd/PID_F_L.Ts)*(PID_F_L.error[0]-(2*PID_F_L.error[1])+PID_F_L.error[2]));
	PID_F_L.P[2]= PID_F_L.error[0]/*-PID_F_L.error[2]*/;
	PID_F_L.P[1]= PID_F_L.Kp;
	PID_F_L.P[0]= PID_F_L.P[1]*PID_F_L.P[2]; //Proportional Controller

	PID_F_L.I[2]= PID_F_L.Ki*PID_F_L.Ts;
	PID_F_L.I[1]= PID_F_L.error[0]+PID_F_L.error[2];
	PID_F_L.I[0]= PID_F_L.I[2]*PID_F_L.I[1]; //Integral Controller

	PID_F_L.D[2]= PID_F_L.Kd/PID_F_L.Ts;
	PID_F_L.D[1]= PID_F_L.error[0]-PID_F_L.error[2];
	PID_F_L.D[0]= PID_F_L.D[2]*PID_F_L.D[1]; //Derivative Controller

	PID_F_L.pid_value[0]= /*PID_F_L.pid_value[2] +*/ PID_F_L.P[0] + PID_F_L.I[0] + PID_F_L.D[0];
	PID_F_L.pid_value[0]=fabsf(PID_F_L.pid_value[0]);
}


/*
 * func      : void PID_Calc_Reverse(void)
 * brief     : PID Controller Calculations
 * param     : N/A
 * Written By: Hafidin
 * Ver       : 1
 * Programmer's Note: PID Formula rewritten with guidance from KRPAI Senior, Desta.
 * 					  This function should be called everytime PID function executed
 */
void PID_Calc_LeftRule_Reverse(void)
{
	/*
	 * Update Nilai Variable PID & Set-Point Error
	 */
	PID_F_R.pid_value[2]=PID_F_R.pid_value[1];
	PID_F_R.pid_value[1]=PID_F_R.pid_value[0];

	PID_F_R.error[2]=PID_F_R.error[1];
	PID_F_R.error[1]=PID_F_R.error[0];

	if (Ping[PING_REAR_RIGHT]==PID_F_R.set_point) {PID_F_R.error[0]=0;}
	else if (Ping[PING_REAR_RIGHT] > PID_F_R.set_point)
		{
			PID_F_R.error[0] = Ping[PING_REAR_RIGHT] - PID_F_R.set_point;
		}

	else if (Ping[PING_REAR_RIGHT] < PID_F_R.set_point)
		{
			PID_F_R.error[0] = PID_F_R.set_point - Ping[PING_REAR_RIGHT];
		}

	/*
	 * PID FORMULA
	 */
	PID_F_R.P[2]= PID_F_R.error[0]-PID_F_R.error[2];
	PID_F_R.P[1]= PID_F_R.Kp;
	PID_F_R.P[0]= PID_F_R.P[1]*PID_F_R.P[2]; //Proportional Controller

	PID_F_R.I[2]= PID_F_R.Ki*PID_F_R.Ts/2;
	PID_F_R.I[1]= PID_F_R.error[0]+(2*PID_F_R.error[1])+PID_F_R.error[2];
	PID_F_R.I[0]= PID_F_R.I[2]*PID_F_R.I[1]; //Integral Controller


	PID_F_R.D[2]= 2*PID_F_R.Kd/PID_F_R.Ts;
	PID_F_R.D[1]= PID_F_R.error[0]-(2*PID_F_R.error[1])+PID_F_R.error[2];
	PID_F_R.D[0]= PID_F_R.D[2]*PID_F_R.D[1]; //Derivative Controller

//	PID_F_R.I= ( (PID_F_R.Ki*PID_F_R.Ts/2)*(PID_F_R.error[0]+(2*PID_F_R.error[1])+PID_F_R.error[2]) );
//	PID_F_R.D= ( (2*PID_F_R.Kd/PID_F_R.Ts)*(PID_F_R.error[0]-(2*PID_F_R.error[1])+PID_F_R.error[2]));

	PID_F_R.pid_value[0]= PID_F_R.pid_value[2] + PID_F_R.P[0] + PID_F_R.I[0] + PID_F_R.D[0];
}

/*	============= PID FOLLOW FLAME ===============
 * func      : void PID_Calc_FlameRule(void)
 * brief     : PID Controller Calculations
 * param     : N/A
 * Written By: Toni
 * Ver       : 1
 * Programmer's Note: PID Formula rewritten with guidance from KRPAI Senior, Desta.
 * 					  This function should be called everytime PID function executed
 */
void PID_Calc_FlameRule(void)
{
	/*
	 * Update Nilai Variable PID & Set-Point Error
	 */
	PID_F_R.pid_value[2]=PID_F_R.pid_value[1];
	PID_F_R.pid_value[1]=PID_F_R.pid_value[0];

	PID_F_R.error[2]=PID_F_R.error[1];
	PID_F_R.error[1]=PID_F_R.error[0];

	if (FlameSenseDigi[0]==PID_F_R.set_point) {PID_F_R.error[0]=0;}
	else if (FlameSenseDigi[0] > PID_F_R.set_point)
		{
			PID_F_R.error[0] = FlameSenseDigi[0] - PID_F_R.set_point;
		}

	else if (FlameSenseDigi[0] < PID_F_R.set_point)
		{
			PID_F_R.error[0] = PID_F_R.set_point - FlameSenseDigi[0];
		}

	/*
	 * PID FORMULA
	 */
	PID_F_R.P[2]= PID_F_R.error[0]-PID_F_R.error[2];
	PID_F_R.P[1]= PID_F_R.Kp;
	PID_F_R.P[0]= PID_F_R.P[1]*PID_F_R.P[2]; //Proportional Controller

	PID_F_R.I[2]= PID_F_R.Ki*PID_F_R.Ts/2;
	PID_F_R.I[1]= PID_F_R.error[0]+(2*PID_F_R.error[1])+PID_F_R.error[2];
	PID_F_R.I[0]= PID_F_R.I[2]*PID_F_R.I[1]; //Integral Controller


	PID_F_R.D[2]= 2*PID_F_R.Kd/PID_F_R.Ts;
	PID_F_R.D[1]= PID_F_R.error[0]-(2*PID_F_R.error[1])+PID_F_R.error[2];
	PID_F_R.D[0]= PID_F_R.D[2]*PID_F_R.D[1]; //Derivative Controller

//	PID_F_R.I= ( (PID_F_R.Ki*PID_F_R.Ts/2)*(PID_F_R.error[0]+(2*PID_F_R.error[1])+PID_F_R.error[2]) );
//	PID_F_R.D= ( (2*PID_F_R.Kd/PID_F_R.Ts)*(PID_F_R.error[0]-(2*PID_F_R.error[1])+PID_F_R.error[2]));

	PID_F_R.pid_value[0]= PID_F_R.pid_value[2] + PID_F_R.P[0] + PID_F_R.I[0] + PID_F_R.D[0];
}


/* func      : void PID_Calculate_RightRule_Interrupt_Init(void)
 * brief     : PID Calculate RightRule Timer Interrupt Initialization
 * retval    : N/A
 * Ver       : 1
 * written By: Toni
 * revise By : Reyhan
 * Programmer's Note: PID Calculate RightRule Initialization using timer 3
 * Revision note :
 */
void PID_Calculate_Rule_Interrupt_Init(void)
{

	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM3, ENABLE);

	TIM_TimeBaseInitTypeDef TIM_TimeBaseStructure;

	TIM_TimeBaseStructure.TIM_Prescaler = 8399;
	TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;
	TIM_TimeBaseStructure.TIM_Period = 249;//
	TIM_TimeBaseStructure.TIM_ClockDivision = TIM_CKD_DIV1;
	TIM_TimeBaseStructure.TIM_RepetitionCounter = 0;
	TIM_TimeBaseInit(TIM3, &TIM_TimeBaseStructure);
	TIM_Cmd(TIM3, ENABLE);
	TIM_ITConfig(TIM3, TIM_IT_Update, ENABLE);

    NVIC_InitTypeDef NVIC_InitStructure;
    NVIC_InitStructure.NVIC_IRQChannel = TIM3_IRQn;
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
    NVIC_Init(&NVIC_InitStructure);
}

/* func      : void TIM3_IRQHandler(void)
 * brief     : PID_Calculate_RightRule Timer Handler
 * retval    : N/A
 * Ver       : 1
 * written By: Toni
 * Programmer's Note: PID_Calculate_RightRule Handler
 */
void TIM3_IRQHandler(void)
{
    if (TIM_GetITStatus(TIM3, TIM_IT_Update) != RESET)
    {
    	if(FOLLOW_CALC==KANAN)
    	{
   		if(FOLLOW_MARK_R == 0 && CALC_EN == 1)
    		{
    			Restore_Old_Error_Right();
    			CALC_EN = 0;
    			FOLLOW_MARK_L = 1;
    		}
    		else if(FOLLOW_MARK_R == 1 && CALC_EN == 1)
    		{
    			FOLLOW_MARK_R = 0;
    			FOLLOW_MARK_L = 1;
    			CALC_EN = 0;
    		}
    		PID_Calc_RightRule();
//    		Fuzzy_Follow_kanan();
    	}
    	else if(FOLLOW_CALC==KANAN_BELAKANG)
    	{
    		PID_Calc_RightRule_Reverse();
    	}
    	else if(FOLLOW_CALC==KIRI)
    	{
    		if(FOLLOW_MARK_L == 0 && CALC_EN == 1)
    		{
    			Restore_Old_Error_Left();
    			CALC_EN = 0;
    			FOLLOW_MARK_R = 1;
    		}
    		else if(FOLLOW_MARK_L == 1 && CALC_EN == 1)
    		{
    			FOLLOW_MARK_R = 1;
    			FOLLOW_MARK_L = 0;
    			CALC_EN = 0;
    		}
    		PID_Calc_LeftRule();
//    		Fuzzy_Follow_kiri();
    	}
    	else if(FOLLOW_CALC==KIRI_BELAKANG)
    	{
    		PID_Calc_LeftRule_Reverse();
    	}
    	else if(FOLLOW_CALC==FLAME)
    	{
    		PID_Calc_FlameRule();
    	}
		TIM_ClearITPendingBit(TIM3, TIM_IT_Update);
    }
}

void Restore_Old_Error_Right(void)
{
	PID_F_R.error[0]=PID_F_R_OLD.error[0];
	PID_F_R.error[1]=PID_F_R_OLD.error[1];
	PID_F_R.error[2]=PID_F_R_OLD.error[2];
}

void Restore_Old_Error_Left(void)
{
	PID_F_L.error[0]=PID_F_L_OLD.error[0];
	PID_F_L.error[1]=PID_F_L_OLD.error[1];
	PID_F_L.error[2]=PID_F_L_OLD.error[2];
}

//PID TS SAMPLING COUNT
//stop counter
//pid calculate
//ts = counter
//reset counter
//start counter
//Sinyal kontrol ke actuator

///*
// * func      : void PID_Calc(void)
// * brief     : PID Controller Calculations
// * param     : N/A
// * Written By: Ryan
// * Ver       : 1
// * Programmer's Note: PID Formula rewritten with guidance from KRPAI Senior, Desta.
// * 					  This function should be called everytime PID function executed
// */
//void Centerize_PID_Calc(void)
//{
//	/*
//	 * Update Nilai Variable PID & Set-Point Error
//	 */
//
//	PID_DFL_R.pid_value[2]=PID_DFL_R.pid_value[1];
//	PID_DFL_R.pid_value[1]=PID_DFL_R.pid_value[0];
//
//	PID_DFL_R.error[2]=PID_DFL_R.error[1];
//	PID_DFL_R.error[1]=PID_DFL_R.error[0];
//
//	if (Ping[PING_RIGHT]==PID_DFL_R.set_point) {PID_DFL_R.error[0]=0;}
//	else if (Ping[PING_RIGHT] > PID_DFL_R.set_point)
//		{
//			PID_DFL_R.error[0] = Ping[PING_RIGHT] - PID_DFL_R.set_point;
//		}
//
//	else if (Ping[PING_RIGHT] < PID_DFL_R.set_point)
//		{
//			PID_DFL_R.error[0] = PID_DFL_R.set_point - Ping[PING_RIGHT];
//		}
//
//	/*
//	 * PID FORMULA
//	 */
//	PID_DFL_R.P[2]= PID_DFL_R.error[0]-PID_DFL_R.error[2];
//	PID_DFL_R.P[1]= PID_DFL_R.Kp;
//	PID_DFL_R.P[0]= PID_DFL_R.P[1]*PID_DFL_R.P[2]; //Proportional Controller
//
//	PID_DFL_R.I[2]= PID_DFL_R.Ki*PID_DFL_R.Ts/2;
//	PID_DFL_R.I[1]= PID_DFL_R.error[0]+(2*PID_DFL_R.error[1])+PID_DFL_R.error[2];
//	PID_DFL_R.I[0]= PID_DFL_R.I[2]*PID_DFL_R.I[1]; //Integral Controller
//
//	PID_DFL_R.D[2]= 2*PID_DFL_R.Kd/PID_DFL_R.Ts;
//	PID_DFL_R.D[1]= PID_DFL_R.error[0]-(2*PID_DFL_R.error[1])+PID_DFL_R.error[2];
//	PID_DFL_R.D[0]= PID_DFL_R.D[2]*PID_DFL_R.D[1]; //Derivative Controller
//
//	//PID_F_R.I= ( (PID_F_R.Ki*PID_F_R.Ts/2)*(PID_F_R.error[0]+(2*PID_F_R.error[1])+PID_F_R.error[2]) );
//	//PID_F_R.D= ( (2*PID_F_R.Kd/PID_F_R.Ts)*(PID_F_R.error[0]-(2*PID_F_R.error[1])+PID_F_R.error[2]));
//
//	PID_DFL_R.pid_value[0]= PID_DFL_R.pid_value[2] + PID_DFL_R.P[0] + PID_DFL_R.I[0] + PID_DFL_R.D[0];
//}

//void Centerize_Right(void)
//{
//	if (Ping[PING_FRONT]<=25)
//	{
//		while (Ping[PING_ASKEW_RIGHT]<=15)
//		{
//			mov_rot_left(MED, FAR);
//		}
//
//		if (Ping[PING_ASKEW_RIGHT]>50)
//		{
//			mov_rot_right(MED, FAR);
//		}
//	}
//	else PID_Centerize_Right();
//}
//
//void PID_Centerize_Right(void)
//{
//	Centerize_PID_Calc();
//
//	//KONDISI ROBOT SESUAI
//	if ( Ping[PING_RIGHT]==PID_DFL_R.set_point )
//		{
//			mov_fwd_5cm(5, MED);
//		}
//
//	//KONDISI ROBOT JAUH DARI DINDING
//	else if ( Ping[PING_RIGHT]>PID_DFL_R.set_point )
//		{
//			//if (PID_DFL_R.pid_value[0]>=3) PID_DFL_R.pid_value[0]=3; //windup
//
//			if ((PID_DFL_R.pid_value[0]<1)&&(PID_DFL_R.pid_value[0]>=0))
//				{
//					mov_fwd_5cm(5, MED);
//				}
//			Centerize_deflect_right(MED, FAR, &PID_DFL_R.pid_value[0]);
//		}
//
//	//KONDISI ROBOT DEKAT DENGAN DINDING
//	else if ( Ping[PING_RIGHT]<PID_DFL_R.set_point )
//		{
//			//if (PID_DFL_R.pid_value[0]>=3) PID_DFL_R.pid_value[0]=3; //windup
//			if ((PID_DFL_R.pid_value[0]<1)&&(PID_DFL_R.pid_value[0]>=0))
//				{
//					mov_fwd_5cm(5, MED);
//				}
//			 Centerize_deflect_left(MED, FAR, &PID_DFL_R.pid_value[0]);
//		}
//}
//
//
//void Centerize_deflect_right(int SPEED, int STEP, float *COMMAND_LOOP)
//{
//	int counter;
//	//int limit= *COMMAND_LOOP;
//
//	for(counter=1;counter<=*COMMAND_LOOP;counter++)
//	{
//		mov_deflect_right(MED, FAR);
//	}
//
//}
//
//void Centerize_deflect_left(int SPEED, int STEP, float *COMMAND_LOOP)
//{
//	int counter;
//	//int limit= *COMMAND_LOOP;
//	mov_askew_left_transition();
//	for(counter=1;counter<=*COMMAND_LOOP;counter++)
//	{
//		mov_deflect_left(MED, FAR);
//	}
//
//}




/*
 *  BW PID CONTROLLER RUNTIME TUNING
 */
void PID_Runtime_Tuning(void)
{
	int MENU_VAR;

	while(BUTTON_IDLE)
	{
		lcd_display_clear();
		lcd_gotoxy(0,0);sprintf(lcd,"BW 2016");lcd_putstr(lcd);
		lcd_gotoxy(0,1);sprintf(lcd,"PID CONTROLLER");lcd_putstr(lcd);
		lcd_gotoxy(0,2);sprintf(lcd,"RUNTIME");lcd_putstr(lcd);
		lcd_gotoxy(0,3);sprintf(lcd,"TUNING");lcd_putstr(lcd);
		delay_ms(100);
	}

	if(BW_BUTTON_CLICKED)
	{


		while(1)
		{
//			while(BUTTON_IDLE)
//			{
//				BW_Buzz(1);
//				lcd_display_clear();
//				lcd_gotoxy(0,0);sprintf(lcd,"BW 2016");lcd_putstr(lcd);
//				lcd_gotoxy(0,1);sprintf(lcd,"PID TUNING");lcd_putstr(lcd);
//				lcd_gotoxy(0,2);sprintf(lcd,"INITIALIZING");lcd_putstr(lcd);
//				delay_ms(100);
//			}

			if(BUTTON_A_CLICKED)
			{
				BW_Buzz(2);
				while(BUTTON_A_CLICKED){};
				MENU_VAR++;
			}
			if(BUTTON_B_CLICKED)
			{
				BW_Buzz(1);
				while(BUTTON_B_CLICKED){};
				MENU_VAR--;
			}

			if(MENU_VAR>3) MENU_VAR=0;
			else if (MENU_VAR<0) MENU_VAR=3;

			switch(MENU_VAR)
			{
				case 0:
						{
							lcd_display_clear();
							lcd_gotoxy(0,0);sprintf(lcd,"FOLLOW RIGHT");lcd_putstr(lcd);
							delay_ms(100);
							while(MENU_VAR==0)
							{
								follow_right_counter(1);

								if(BUTTON_A_CLICKED)
								{
									BW_Buzz(2);
									while(BUTTON_A_CLICKED){};
									MENU_VAR++;
								}
								if(BUTTON_B_CLICKED)
								{
									BW_Buzz(1);
									while(BUTTON_B_CLICKED){};
									MENU_VAR--;
								}

								if(MENU_VAR>3) MENU_VAR=0;
								else if (MENU_VAR<0) MENU_VAR=3;
								//WALL FOLLOW START
							}


						}break;

				case 1:
						{
							mov_static();
							Kp_Tuning_R();

							if(BUTTON_A_CLICKED)
							{
								BW_Buzz(2);
								while(BUTTON_A_CLICKED){};
								MENU_VAR++;
							}
							if(BUTTON_B_CLICKED)
							{
								BW_Buzz(1);
								while(BUTTON_B_CLICKED){};
								MENU_VAR--;
							}

							if(MENU_VAR>3) MENU_VAR=0;
							else if (MENU_VAR<0) MENU_VAR=3;
							//Kp Tuning

						}break;
				case 2:
						{
							mov_static();
							Ki_Tuning_R();

							if(BUTTON_A_CLICKED)
							{
								BW_Buzz(2);
								while(BUTTON_A_CLICKED){};
								MENU_VAR++;
							}
							if(BUTTON_B_CLICKED)
							{
								BW_Buzz(1);
								while(BUTTON_B_CLICKED){};
								MENU_VAR--;
							}

							if(MENU_VAR>3) MENU_VAR=0;
							else if (MENU_VAR<0) MENU_VAR=3;
							//Ki Tuning
						}break;
				case 3:
						{
							mov_static();
							Kd_Tuning_R();

							if(BUTTON_A_CLICKED)
							{
								BW_Buzz(2);
								while(BUTTON_A_CLICKED){};
								MENU_VAR++;
							}
							if(BUTTON_B_CLICKED)
							{
								BW_Buzz(1);
								while(BUTTON_B_CLICKED){};
								MENU_VAR--;
							}

							if(MENU_VAR>3) MENU_VAR=0;
							else if (MENU_VAR<0) MENU_VAR=3;
							//Kd Tuning
						}break;

			}
		}

	}

}

void Kp_Tuning_R(void)
{
	while(BW_BUTTON_UNCLICKED)
	{
		if(BUTTON_A_CLICKED)
		{
			BW_Buzz(2);
			while(BUTTON_A_CLICKED){};
			PID_F_R.Kp += 1.0;
		}
		if(BUTTON_B_CLICKED)
		{
			BW_Buzz(1);
			while(BUTTON_B_CLICKED){};
			PID_F_R.Kp -= 1.0;
		}

		lcd_display_clear();
		lcd_gotoxy(0,0);sprintf(lcd,"PID_F_R.Kp: %.1f",PID_F_R.Kp);lcd_putstr(lcd);
		delay_ms(100);
	}
}

void Ki_Tuning_R(void)
{
	while(BW_BUTTON_UNCLICKED)
	{
		if(BUTTON_A_CLICKED)
		{
			BW_Buzz(2);
			while(BUTTON_A_CLICKED){};
			PID_F_R.Ki += 1.0;
		}
		if(BUTTON_B_CLICKED)
		{
			BW_Buzz(1);
			while(BUTTON_B_CLICKED){};
			PID_F_R.Ki -= 1.0;
		}

		lcd_display_clear();
		lcd_gotoxy(0,0);sprintf(lcd,"PID_F_R.Ki: %.1f",PID_F_R.Ki);lcd_putstr(lcd);
		delay_ms(100);
	}
}

void Kd_Tuning_R(void)
{
	while(BW_BUTTON_UNCLICKED)
	{
		if(BUTTON_A_CLICKED)
		{
			BW_Buzz(2);
			while(BUTTON_A_CLICKED){};
			PID_F_R.Kd += 1.0;
		}
		if(BUTTON_B_CLICKED)
		{
			BW_Buzz(1);
			while(BUTTON_B_CLICKED){};
			PID_F_R.Kd -= 1.0;
		}

		lcd_display_clear();
		lcd_gotoxy(0,0);sprintf(lcd,"PID_F_R.Kd: %.1f",PID_F_R.Kd);lcd_putstr(lcd);
		delay_ms(100);
	}
}

void Kp_Tuning_L(void)
{

	while(BW_BUTTON_UNCLICKED)
	{
		if(BUTTON_A_CLICKED)
		{
			BW_Buzz(2);
			while(BUTTON_A_CLICKED){};
			PID_F_L.Kp+=1.0;
		}
		if(BUTTON_B_CLICKED)
		{
			BW_Buzz(1);
			while(BUTTON_B_CLICKED){};
			PID_F_L.Kp-=1.0;
		}

		lcd_display_clear();
		lcd_gotoxy(0,0);sprintf(lcd,"PID_F_L.Kp: %.2f",PID_F_L.Kp);lcd_putstr(lcd);
		delay_ms(100);
	}

}

void Ki_Tuning_L(void)
{

	while(BW_BUTTON_UNCLICKED)
	{
		if(BUTTON_A_CLICKED)
		{
			BW_Buzz(2);
			while(BUTTON_A_CLICKED){};
			PID_F_L.Ki+=1.0;
		}
		if(BUTTON_B_CLICKED)
		{
			BW_Buzz(1);
			while(BUTTON_B_CLICKED){};
			PID_F_L.Ki-=1.0;
		}

		lcd_display_clear();
		lcd_gotoxy(0,0);sprintf(lcd,"PID_F_L.Ki: %.2f",PID_F_L.Ki);lcd_putstr(lcd);
		delay_ms(100);
	}
}

void Kd_Tuning_L(void)
{

	while(BW_BUTTON_UNCLICKED)
	{
		if(BUTTON_A_CLICKED)
		{
			BW_Buzz(2);
			while(BUTTON_A_CLICKED){};
			PID_F_L.Kd+=1.0;
		}
		if(BUTTON_B_CLICKED)
		{
			BW_Buzz(1);
			while(BUTTON_B_CLICKED){};
			PID_F_L.Kd-=1.0;
		}

		lcd_display_clear();
		lcd_gotoxy(0,0);sprintf(lcd,"PID_F_L.Kd: %.2f",PID_F_L.Kd);lcd_putstr(lcd);
		delay_ms(100);
	}

}

