/*****************************************************
Project   : BW* Main Controller
Version   : 1.1
Year      : 2018
Date      : October 1st
Author    : REYHAN RIFQI IHSAN(2016)
University: University of Brawijaya
Department: Electrical Engineering Department, Engineering Faculty
Division  : Legged Fire-Fighting Division (KRPAI)
Comments  : *Bhatara Wijaya GO INTERNASIONAL

What's New: New Pin Mapping for New Board Design
			Implemented I2C LCD
			Optimization from 1.0

Board Type: STM32F4 Discovery Board
Chip  Type: STM32F407VG
*****************************************************/


#include "main.h"


int toggle=1;
int Time_Ms = 1;
void BW_Initialization(void);
void BW_SystemCheck(void);
int main(void)
{
	int BUTTON_ACT;
	int SOUND_ACT;

	BW_Initialization();

/*	SetMaxTorque(FRONT_RIGHT_DX_COXA);
	SetMaxTorque(FRONT_RIGHT_DX_FEMUR);
	SetMaxTorque(FRONT_RIGHT_DX_TIBIA);

	delay_ms(10);

	SetMaxTorque(FRONT_LEFT_DX_COXA);
	SetMaxTorque(FRONT_LEFT_DX_FEMUR);
	SetMaxTorque(FRONT_LEFT_DX_TIBIA);

	delay_ms(10);

	SetMaxTorque(MIDDLE_RIGHT_DX_COXA);
	SetMaxTorque(MIDDLE_RIGHT_DX_FEMUR);
	SetMaxTorque(MIDDLE_RIGHT_DX_TIBIA);

	delay_ms(10);

	SetMaxTorque(MIDDLE_LEFT_DX_COXA);
	SetMaxTorque(MIDDLE_LEFT_DX_FEMUR);
	SetMaxTorque(MIDDLE_LEFT_DX_TIBIA);

	delay_ms(10);

	SetMaxTorque(REAR_RIGHT_DX_COXA);
	SetMaxTorque(REAR_RIGHT_DX_FEMUR);
	SetMaxTorque(REAR_RIGHT_DX_TIBIA);

	delay_ms(10);

	SetMaxTorque(REAR_LEFT_DX_COXA);
	SetMaxTorque(REAR_LEFT_DX_FEMUR);
	SetMaxTorque(REAR_LEFT_DX_TIBIA);

	delay_ms(10);*/

/*	Lock_EEPROM(FRONT_RIGHT_DX_COXA);
	Lock_EEPROM(FRONT_RIGHT_DX_FEMUR);
	Lock_EEPROM(FRONT_RIGHT_DX_TIBIA);

	Lock_EEPROM(FRONT_LEFT_DX_COXA);
	Lock_EEPROM(FRONT_LEFT_DX_FEMUR);
	Lock_EEPROM(FRONT_LEFT_DX_TIBIA);

	Lock_EEPROM(MIDDLE_RIGHT_DX_COXA);
	Lock_EEPROM(MIDDLE_RIGHT_DX_FEMUR);
	Lock_EEPROM(MIDDLE_RIGHT_DX_TIBIA);

	Lock_EEPROM(MIDDLE_LEFT_DX_COXA);
	Lock_EEPROM(MIDDLE_LEFT_DX_FEMUR);
	Lock_EEPROM(MIDDLE_LEFT_DX_TIBIA);

	Lock_EEPROM(REAR_RIGHT_DX_COXA);
	Lock_EEPROM(REAR_RIGHT_DX_FEMUR);
	Lock_EEPROM(REAR_RIGHT_DX_TIBIA);

	Lock_EEPROM(REAR_LEFT_DX_COXA);
	Lock_EEPROM(REAR_LEFT_DX_FEMUR);
	Lock_EEPROM(REAR_LEFT_DX_TIBIA);*/

	DynaExt(230);

//	Dynamx_MoveLeg_Interpolate(FRONT_RIGHT_DX, 500,SUDUT_STATIC[0],SUDUT_STATIC[1],SUDUT_STATIC[2]);
	Dynamx_Mov_Static_Interpolate(1500, IKCALC_DISABLE);
/*	while(1)
	{
		Dynamx_MovFwd4cm_Interpolate(4, 3000, IKCALC_DISABLE);
	}*/
	int RT_MODE = 1;

/*	unsigned int deg_test = 0;
	int buffer_deg = 0;
	unsigned char ID = 1;
	while(1)
	{
		lcd_display_clear();
		lcd_gotoxy(0,0);sprintf(lcd,"DEGREE : %d", deg_test);lcd_putstr(lcd);
		if(BW_BUTTON_CLICKED)
		{
			while(BW_BUTTON_CLICKED)
			{}
			deg_test = deg_test+5;
		}
		else if(BUTTON_A_CLICKED)
		{
			while(BUTTON_A_CLICKED)
			{}
			deg_test = deg_test - 5;
		}
		else if(BUTTON_B_CLICKED)
		{
			Dynamx_MoveLeg_Interpolate(MIDDLE_LEFT_DX, 500, SUDUT_STATIC[0]+deg_test,SUDUT_STATIC[1],SUDUT_STATIC[2]);
		}
		delay_ms(100);

	}*/
/*	volatile float tss = 99;

	while(1)
	{
		if(BW_BUTTON_CLICKED)
		{
			while(1)
			{
				Dynamx_CurveLeft_PID_Interpolate(LEVEL6, HEXSTEP_FAR, &tss, IKCALC_DISABLE, NO_FOLLOW, NO_FOLLOW);
			}
		}
		else if(BUTTON_A_CLICKED)
		{
			while(1)
			{
				Dynamx_Slide_Left_Interpolate(HEXSTEP_MED, LEVEL3);
			}
		}
		else if(BUTTON_B_CLICKED)
		{
			while(1)
			{
				Dynamx_Slide_Right_Interpolate(HEXSTEP_MED, LEVEL3);
			}
		}
	}*/

/*	BW_PID_Init();
	while(1)
	{

		//BW_FollowTracer_Left();
		BW_FollowCounter_Left(1);
	}*/
/*

	GetCMPS11_Angle8Bit();
	while(1)
	{
		CMPS12_Get_Calibration_Status();
		if(BW_BUTTON_CLICKED)
		{
			while(BW_BUTTON_CLICKED)
			{

			}
			CMPS12_I2C_Store_Profile();
			break;
		}
	}
	while(1)
	{
		EXTINGUISHER_ON;
		delay_ms(1500);
		EXTINGUISHER_OFF;
		delay_ms(1500);
	}*/

	if(RT_MODE == 0)
	{
	SND_ACT_LED_ON;
	FIRE_LED_ON;
	delay_ms(200);
	FIRE_LED_OFF;
	SND_ACT_LED_OFF;
	}
	BW_PID_Init();

/*	while(1)
	{
		BW_FollowTracer_Left_Interpolate();
		//BW_FollowCounter_Left(1);
	}*/
/*	int p;
	for(p = 0; p <= 254;p++)
	{
		Dynamx_LED_Status(p, 1, 200);
	}*/
//	FIRE_LED_BLINK_ON;

/*	while(1)
	{
		GetCMPS11_Angle8Bit();
		CMPS11_I2C_Calibration();
		while(1);
	}*/


/*	while(1)
	{
		Display_Ping_Status();
	}*/

/*	while(1)
	{
		//Dynamx_MoveLeg_Interpolate(REAR_LEFT_DX,   LEVEL3,SUDUT_STATIC[15]+IKFWD_COXA_L[2],SUDUT_STATIC[16]+SUDUT_ANGKAT,SUDUT_STATIC[17]+IKFWD_TIBIA_L[0]);
		Dynamx_Mov_Extinguish_V10(LEVEL6);
	}*/
//	Dynamx_MoveLeg_Interpolate(1,1200,90,18,130);

/*	BW_PID_Init();
	volatile float testtest = 999;
	while(1)
	{
//		BW_FollowTracer_Right_Interpolate();
		//Trajectory_Test(2000);
//		Dynamx_MovFwd4cm_Interpolate(4,3000,IKCALC_DISABLE);
		BW_LOCATION[0] = LOCATION_CORRIDOR;
		if(BW_BUTTON_CLICKED)
		{
			while(1)
			{
				//BW_FollowTracer_Right_Interpolate();
				//Dynamx_Rot_Right_Interpolate(LEVEL3, HEXSTEP_MED, IKCALC_DISABLE);
				//Dynamx_Rot_Left_Interpolate(LEVEL3, HEXSTEP_MED, IKCALC_DISABLE);
				Dynamx_CurveLeft_PID_Interpolate(3000, HEXSTEP_FAR, &testtest, IKCALC_DISABLE, NO_FOLLOW, NO_FOLLOW);
				//Dynamx_MovFwd4cm_Interpolate(4,3000,IKCALC_DISABLE);
			}
		}
		else if(BUTTON_A_CLICKED)
		{
			BW_FollowTracer_Left_Interpolate();
		}
		else if(BUTTON_B_CLICKED)
		{
			while(1)
			{
			Dynamx_CurveRight_PID_Interpolate(3000, HEXSTEP_FAR, &testtest, IKCALC_DISABLE, NO_FOLLOW, NO_FOLLOW);
			}
		}
	}*/

/*	while(1)
	{
		CMPS12_Get_Calibration_Status();
		delay_ms(500);
		if(BW_BUTTON_CLICKED)
		{
			while(BW_BUTTON_CLICKED){}
			lcd_display_clear();
			lcd_gotoxy(0,0);sprintf(lcd,"CALIBRATION DATA");lcd_putstr(lcd);
			lcd_gotoxy(0,1);sprintf(lcd,"SAVED");lcd_putstr(lcd);
			CMPS12_I2C_Store_Profile();
			delay_ms(2000);
		}

		else if(BUTTON_A_CLICKED)
		{
			while(BUTTON_A_CLICKED){}
			lcd_display_clear();
			lcd_gotoxy(0,0);sprintf(lcd,"DELETE CALIBRATION");lcd_putstr(lcd);
			CMPS12_I2C_Delete_Profile();
			delay_ms(2000);
		}
	}*/

/*	while(BW_BUTTON_UNCLICKED)
	{

	}
	BW_PID_Init();
	while(1)
	{
		BW_FollowCounter_Left(1);
	}*/

	if(RT_MODE == 0)
	{
	lcd_display_clear();
	lcd_gotoxy(0,0);sprintf(lcd,"SKIP SYS CHECK ?");lcd_putstr(lcd);
	while(1)
	{
	if(BW_BUTTON_CLICKED)
	{
		BW_SystemCheck();

		if(RCC_GetFlagStatus(RCC_FLAG_SFTRST))
		{
			lcd_display_clear();
			lcd_gotoxy(0,0);sprintf(lcd,"SFT");lcd_putstr(lcd);
			RCC_ClearFlag();
			delay_ms(1000);
		}

		else if(RCC_GetFlagStatus(RCC_FLAG_PORRST))
		{
			lcd_display_clear();
			lcd_gotoxy(0,0);sprintf(lcd,"PWR");lcd_putstr(lcd);
			RCC_ClearFlag();
			delay_ms(1000);
		}

		else if(RCC_GetFlagStatus(RCC_FLAG_PINRST))
		{
			lcd_display_clear();
			lcd_gotoxy(0,0);sprintf(lcd,"PIN");lcd_putstr(lcd);
			RCC_ClearFlag();
			delay_ms(1000);
		}

		else
		{
			lcd_display_clear();
			lcd_gotoxy(0,0);sprintf(lcd,"STM32 OK");lcd_putstr(lcd);
			delay_ms(1000);
		}
		break;
	}
	else if(BUTTON_A_CLICKED)break;
	}
	}

/*	DIFF_4A_1BC = R4A_THRESHOLD_MIDDLE - R1BC_THRESHOLD_MIDDLE;
	if(abs(DIFF_4A_1BC) > 90)
	{
		if(R4A_THRESHOLD_MIDDLE > R1BC_THRESHOLD_MIDDLE)
		{
			DIFF_4A_1BC = 360 - (R4A_THRESHOLD_MIDDLE - R1BC_THRESHOLD_MIDDLE);
		}
		else
		{
			DIFF_4A_1BC = 360 - (R1BC_THRESHOLD_MIDDLE - R4A_THRESHOLD_MIDDLE);
		}
	}
	else
	{
		if(R4A_THRESHOLD_MIDDLE < R1BC_THRESHOLD_MIDDLE)
		{
			DIFF_4A_1BC = (R4A_THRESHOLD_MIDDLE - R1BC_THRESHOLD_MIDDLE);
		}
		else
		{
			DIFF_4A_1BC = (R4A_THRESHOLD_MIDDLE - R1BC_THRESHOLD_MIDDLE);
		}
	}*/
/*int y = 0,k = 0;
BW_Write_I2C_EEPROM(0x50,0x02,2);
delay_ms(100);*/
//k = BW_Read_I2C2(0x50,1,2);
/*while(1)
{
		BW_Read_I2C2(0x50,1,2);
		lcd_display_clear();
		lcd_gotoxy(0,0);sprintf(lcd,"ERROR W : %d", y);lcd_putstr(lcd);
//		lcd_gotoxy(0,1);sprintf(lcd,"ERROR R : %d", k);lcd_putstr(lcd);
		lcd_gotoxy(0,2);sprintf(lcd,"Data : %d", DATA);lcd_putstr(lcd);
		delay_ms(100);
}*/
//	lcd_display_clear();
//	lcd_gotoxy(0,0);sprintf(lcd,"PROJECT BW");lcd_putstr(lcd);
//	lcd_gotoxy(0,1);sprintf(lcd,"MOV STATIC");lcd_putstr(lcd);

//	Dynamx_Mov_Static(HEXSPD_ULTRASLOW,IKCALC_DISABLE);
/*	Save_CMPS11_DATA();
	while(1);*/
//	Load_CMPS_DATA();

/*	while(1)
	{
		display_EEPROM_DATA();
		delay_ms(200);
	}*/

//	while(1)
//	{
//		lcd_display_clear();
//		lcd_gotoxy(0,0);sprintf(lcd,"PROJECT BW");lcd_putstr(lcd);
//		lcd_gotoxy(0,1);sprintf(lcd,"MOV SLIDE R");lcd_putstr(lcd);
//
//		Dynamx_Slide_Right(HEXSTEP_MED,HEXSPD_MED);
//	}
//	kinematik_invers(FRONT_LEFT_DX,HEXSPD_SLOW,4,0,3);

//	static_syncwrite();
//	Dynamx_Mov_Static_Low(HEXSPD_ULTRASLOW);

//	while(1)
//	{
//		Dynamx_MovFwd4cm(4,HEXSPD_SLOW,IKCALC_DISABLE);
////		delay_ms(1000);
////		HexDemo();
//	}




/*			lcd_display_clear();
			lcd_gotoxy(0,0);sprintf(lcd,"CMPS12");lcd_putstr(lcd);
			lcd_gotoxy(0,1);sprintf(lcd,"Stabiliization");lcd_putstr(lcd);
			delay_ms(300);*/
			Load_CAT_MIN_DATA();
			if(Load_CMPS_DATA() != 0)
			{
				lcd_display_clear();
				lcd_gotoxy(0,0);sprintf(lcd,"EEPROM NO DATA");lcd_putstr(lcd);
				START_MID_MANUAL=1; // MALFUNGSI START MID
				FOUR_WAY_MANUAL=1; // MALFUNGSI PEREMPATAN
				ROOM_1A_MANUAL=1; // MALFUNGSI DI DEPAN R1A
				ROOM_2_1BC_MANUAL=1; // MALFUNGSI DI DAERAH R 2 1BC
				ROOM_4A_MANUAL=1; // MALFUNGSI DI R 4A
				ROOM_4B_ROT_MANUAL=1; // MALFUNGSI DI DAERAH PEREMPATAN 4B KE KUCING A
				ROOM_1A_RETURN_MANUAL=1; // MALFUNGSI KEMBALI DARI R 1
				ROOM_4B_MANUAL=1; // MALFUNGSI DI DEPAN R4B

			}
			if(CAT_MIN_RANGE <= 0)
			{
				CAT_MIN_RANGE = 10;
			}
			R4AB_THRESHOLD_MIDDLE=(R4AB_THRESHOLD_UPPER+R4AB_THRESHOLD_LOWER)/2;

			USART3_PutChar(NOT_IN_ROOM_STAT);

/*			while(BW_BUTTON_UNCLICKED)
				{
					if(BW_BUTTON_CLICKED){break;}
				}
				Nav_3_To_4AB();
				while(1)*/


/*			while(1)
			{
				if(BW_BUTTON_CLICKED)
				{
					while(BW_BUTTON_CLICKED)
					break;
				}
				lcd_display_clear();
				lcd_gotoxy(0,0);sprintf(lcd,"S_L:%d |",SHARP[SHARP_FRONT_L]);lcd_putstr(lcd);
				lcd_gotoxy(8,0);sprintf(lcd,"S_R:%d ",SHARP[SHARP_FRONT_R]);lcd_putstr(lcd);
				lcd_gotoxy(0,1);sprintf(lcd,"CONFIRM ?");lcd_putstr(lcd);
				delay_ms(100);
			}*/

			USART3_PutChar(IN_ROOM_STAT);
			while( (BW_BUTTON_UNCLICKED) && (SOUND_INACTIVE) )
			{
				if(BW_BUTTON_CLICKED){BUTTON_ACT=1;break;}
				if(SOUND_ACTIVATED){SOUND_ACT=1;break;}
				if(BUTTON_A_CLICKED)
				{
					while(BUTTON_A_CLICKED){}
					ENABLE_UV1 = (!ENABLE_UV1);
				}
				if(BUTTON_B_CLICKED)
				{
					while(BUTTON_B_CLICKED){}
					ENABLE_UV2 = (!ENABLE_UV2);
				}
				RotSwitch_Sampling();
				Display_MODE();
				if(BW_BUTTON_CLICKED){BUTTON_ACT=1;break;}
				if(SOUND_ACTIVATED){SOUND_ACT=1;break;}
			}

		if(BW_BUTTON_CLICKED){BUTTON_ACT=1;}
		if(SOUND_ACTIVATED){SOUND_ACT=1;}

	if(BUTTON_ACT==1)
	{
		BW_Buzz(1);
		Sendto_PC(USART1,"BW BUTTON ACTIVATED! \r");
		lcd_display_clear();
		lcd_gotoxy(5,0);sprintf(lcd,"PROJECT BW");lcd_putstr(lcd);
		lcd_gotoxy(4,1);sprintf(lcd,"BRAWIJAYA");lcd_putstr(lcd);
		lcd_gotoxy(0,2);sprintf(lcd,"FIREFIGHTER ROBO");lcd_putstr(lcd);
		lcd_gotoxy(0,3);sprintf(lcd,"BUTTON ACTIVATED");lcd_putstr(lcd);
		delay_ms(100);
//		BW_Dimension_Check();
//		Dynamx_Mov_Static(HEXSPD_ULTRASLOW,IKCALC_ENABLE);

	}
	else if(SOUND_ACT==1)
	{
		BW_Buzz(2);
		Sendto_PC(USART1,"BW SOUND ACTIVATED! \r");
		lcd_display_clear();
		lcd_gotoxy(5,0);sprintf(lcd,"PROJECT BW");lcd_putstr(lcd);
		lcd_gotoxy(4,1);sprintf(lcd,"BRAWIJAYA");lcd_putstr(lcd);
		lcd_gotoxy(0,2);sprintf(lcd,"FIREFIGHTER ROBO");lcd_putstr(lcd);
		lcd_gotoxy(0,3);sprintf(lcd,"SOUND ACTIVATED");lcd_putstr(lcd);
		delay_ms(100);

		SND_ACT_LED_ON;		//turn on sound led indicator
//		BW_LED_BLINK_ON;
	}

	switch(rot_switch_mode)
	{
//		//BW FAILED INITIALIZATION
		case BW_MODE_DEFAULT:
			{

			}break;

//		//BW TRIAL ALGORITHM MODE
		case BW_MODE_1:
			{
				USART3_PutChar(NOT_IN_ROOM_STAT);
				BW_Initial_Setup(rot_switch_mode);

				while(1)
				{
/*					while(BW_BUTTON_CLICKED)
					{

					}
					Instant_Trial();
					while(BW_BUTTON_CLICKED)
					{

					}
					lcd_display_clear();
					lcd_gotoxy(1,0);sprintf(lcd,"READY...");lcd_putstr(lcd);
					while(BW_BUTTON_UNCLICKED);*/
					SND_ACT_LED_ON;
					H_2017_Algorithm();
					while(1)
					{
						BW_Buzz(1);
						Dynamx_Mov_Static(HEXSPD_SLOW,IKCALC_DISABLE);
//						Dynamx_Mov_Static_Low(HEXSPD_SLOW);

					}

				}
			}break;

//		//BW TEST DRIVE MODE
		case BW_MODE_2:
			{
				BW_Initial_Setup(rot_switch_mode);
//				lcd_gotoxy(3,3);sprintf(lcd,":)");lcd_putstr(lcd);
//				lcd_display_clear();
//				int g;
//				int a,b,c,d,e,f;
//				int a;
//				ROOM1_FLAG=ROOM1FLAG_ACTIVE;

/*				CAT_FLAG_B=CAT_NOT_DETECTED;
				BW_LOCATION[0]=LOCATION_CORRIDOR;
				R4ATO3_SP_ROUTE=R4ATO3_SP_ACTIVE;
				BW_PID_Init();

				BW_LOCATION[0]=LOCATION_ROOM;
//				FOLLOW_FLAG=KANAN;
				BW_PID_Init();
				int kwontlo = 190;*/

//				FIRESCAN_DIRECTION=SCAN_LEFT;
				while(1)
				{
					BW_Settings_2019();
/*
					lcd_display_clear();
					lcd_gotoxy(1,0);sprintf(lcd,"BHATARA WIJAYA");lcd_putstr(lcd);
					lcd_gotoxy(2,2);sprintf(lcd,"CO2 EXTI");lcd_putstr(lcd);
					lcd_gotoxy(2,3);sprintf(lcd,"Degree : %d",kwontlo);lcd_putstr(lcd);

					if(BUTTON_A_CLICKED)
					{
						delay_ms(300);
						kwontlo = kwontlo + 5;
					}

					else if(BUTTON_B_CLICKED)
					{
						delay_ms(300);
						kwontlo = kwontlo - 5;
					}
//					Dynamx_Slide_Left(HEXSTEP_MED,HEXSPD_MED);

//					delay_ms(50);
//					BW_FollowTracer_Right();
//					Dynamx_MovFwd4cm_Button_Trigger(4,HEXSPD_MEDFAST,IKCALC_DISABLE);
*/
/*
					if(BW_BUTTON_CLICKED)
					{
						delay_ms(200);
						TEST_CO2_EXTI(kwontlo);
						PushTo_Burst();
//						while(BW_BUTTON_UNCLICKED){}
//						delay_ms(400);
//						lcd_display_clear();
//						lcd_gotoxy(1,0);sprintf(lcd,"BHATARA WIJAYA");lcd_putstr(lcd);
//						lcd_gotoxy(2,2);sprintf(lcd,"ROT RIGHT");lcd_putstr(lcd);
//						lcd_gotoxy(3,0);sprintf(lcd,"FAST,FAR");lcd_putstr(lcd);
//						Dynamx_Rot_Right(HEXSPD_FAST,HEXSTEP_FAR,IKCALC_DISABLE);
//						Dynamx_Rot_Right(HEXSPD_MEDFAST,HEXSTEP_FAR,IKCALC_DISABLE);
//						lcd_display_clear();
//						lcd_gotoxy(1,0);sprintf(lcd,"BHATARA WIJAYA");lcd_putstr(lcd);
//						lcd_gotoxy(2,2);sprintf(lcd,"ROT RIGHT");lcd_putstr(lcd);
//						lcd_gotoxy(3,0);sprintf(lcd,"MEDFAST,FAR");lcd_putstr(lcd);
//						while(BW_BUTTON_UNCLICKED){}
//						delay_ms(400);
//						Dynamx_Rot_Right(HEXSPD_MEDFAST,HEXSTEP_FAR,IKCALC_DISABLE);
//						lcd_display_clear();
//						lcd_gotoxy(1,0);sprintf(lcd,"BHATARA WIJAYA");lcd_putstr(lcd);
//						lcd_gotoxy(2,2);sprintf(lcd,"ROT RIGHT");lcd_putstr(lcd);
//						lcd_gotoxy(3,0);sprintf(lcd,"ULTRAFAST,FAR");lcd_putstr(lcd);
//						while(BW_BUTTON_UNCLICKED){}
//						delay_ms(400);
//						Dynamx_Rot_Right(HEXSPD_ULTRAFAST,HEXSTEP_FAR,IKCALC_DISABLE);
//						lcd_display_clear();
//						lcd_gotoxy(1,0);sprintf(lcd,"COMPLETE");lcd_putstr(lcd);
//						Dynamx_Rot_Correction_Left(HEXSPD_MEDFAST);
//						delay_ms(1000);

					}
*/

//					delay_ms(300);
//					Nav_4B_To_1A();
					//test_IK();
//					Bumper_Follow();
//					BW_PID_Init_Room();
//					HexDemo();
//					Gerak(0);
//					Dynamx_Extinguish_High(HEXSPD_SLOW);
//					Set_Servo(0);
////				Dynamx_Rot_Left(HEXSPD_MED,HEXSTEP_MED,IKCALC_DISABLE);
//					Dynamx_MovBwd(4,HEXSPD_ULTRAFAST,IKCALC_DISABLE);
//					BW_FollowTracer_Right_Reverse();
				}
			}break;

//		//BW NAVIGATION MENU MODE
		case BW_MODE_3:
			{
				BW_Initial_Setup(rot_switch_mode);
				lcd_display_clear();
				lcd_gotoxy(1,0);sprintf(lcd,"BHATARA WIJAYA");lcd_putstr(lcd);
				lcd_gotoxy(4,2);sprintf(lcd,"PID TUNING ");lcd_putstr(lcd);
				lcd_gotoxy(3,3);sprintf(lcd,"TEST");lcd_putstr(lcd);
//				R4ATO3_SP_ROUTE==R4ATO3_SP_INACTIVE;
//				FOLLOW_FLAG=KIRI;
//				CAT_FLAG_B=CAT_NOT_DETECTED;
//				BW_LOCATION[0]=LOCATION_CORRIDOR;
//				R4ATO3_SP_ROUTE=R4ATO3_SP_ACTIVE;
				BW_PID_Init();
				BW_LOCATION[0] = LOCATION_CORRIDOR;
				ROOM4A_CAT_AVOIDER = ROOM4A_CAT_AVOIDER_ACTIVE;

				while(1)
				{
					lcd_gotoxy(1,0);sprintf(lcd,"BHATARA WIJAYA");lcd_putstr(lcd);
					lcd_gotoxy(4,2);sprintf(lcd,"PID TUNING ");lcd_putstr(lcd);
					lcd_gotoxy(3,3);sprintf(lcd,"TEST");lcd_putstr(lcd);
//					ROOM4A_CAT_AVOIDER = ROOM4A_CAT_AVOIDER_ACTIVE;
//					if(Cat_Avoider_Test() == 1)
//					{
//						lcd_display_clear();
//						lcd_gotoxy(3,0);sprintf(lcd,"DETECT TEST");lcd_putstr(lcd);
//						lcd_gotoxy(3,1);sprintf(lcd,"ACTIVATED");lcd_putstr(lcd);
//						delay_ms(200);
//					}
//					else lcd_display_clear();

					//BW_PID_Init_Room();
					//BW_PID_Init_Furniture();
					BW_PID_Init();
					if(BW_BUTTON_CLICKED)
					{
						while(BW_BUTTON_CLICKED){}
						delay_ms(200);
						Kp_Tuning_L();
						while(BW_BUTTON_CLICKED){}
						delay_ms(200);
						Ki_Tuning_L();
						while(BW_BUTTON_CLICKED){}
						delay_ms(200);
						Kd_Tuning_L();
						while(BW_BUTTON_CLICKED){}
						while(BW_BUTTON_UNCLICKED)
						{
							if(BUTTON_A_CLICKED)
							{
								while(BUTTON_A_CLICKED){};
								DELTA_TEST += 1;
							}
							if(BUTTON_B_CLICKED)
							{
								while(BUTTON_B_CLICKED){};
								DELTA_TEST -= 1;
							}

							lcd_display_clear();
							lcd_gotoxy(0,0);sprintf(lcd,"DELTA : %.1f",DELTA_TEST);lcd_putstr(lcd);
							delay_ms(100);
						}

						BW_FollowTracer_Left_Interpolate();
						FOLLOW_CALC = KOSONG;

					}

					else if(BUTTON_B_CLICKED)
					{
						while(BW_BUTTON_CLICKED){}
						delay_ms(200);
						Kp_Tuning_R();
						while(BW_BUTTON_CLICKED){}
						delay_ms(200);
						Ki_Tuning_R();
						while(BW_BUTTON_CLICKED){}
						delay_ms(200);
						Kd_Tuning_R();
						while(BW_BUTTON_CLICKED){}
						while(BW_BUTTON_UNCLICKED)
						{
							if(BUTTON_A_CLICKED)
							{
								while(BUTTON_A_CLICKED){};
								DELTA_TEST += 1;
							}
							if(BUTTON_B_CLICKED)
							{
								while(BUTTON_B_CLICKED){};
								DELTA_TEST -= 1;
							}

							lcd_display_clear();
							lcd_gotoxy(0,0);sprintf(lcd,"DELTA : %.1f",DELTA_TEST);lcd_putstr(lcd);
							delay_ms(100);
						}
						BW_FollowTracer_Right_Interpolate();
						FOLLOW_CALC = KOSONG;
					}

//					Dynamx_Rot_Left(HEXSPD_FAST,HEXSTEP_FAR,IKCALC_DISABLE);

//					lcd_display_clear();
//					lcd_gotoxy(1,0);sprintf(lcd,"BHATARA WIJAYA");lcd_putstr(lcd);
//					lcd_gotoxy(2,2);sprintf(lcd,"SLIDE LEFT");lcd_putstr(lcd);
//					Nav_Test_Menu();
//					Nav_4A_To_1A_VER2();
//					Dynamx_Slide_Left(HEXSTEP_MED,HEXSPD_MED);

				}

			}break;

//		//BW TCS3200Tracer MODE
		case BW_MODE_4:
			{
				BW_Initial_Setup(rot_switch_mode);
				lcd_display_clear();

//				BW_LOCATION[0]=LOCATION_ROOM;
//				FOLLOW_FLAG=KIRI;
				BW_PID_Init();
//				Dynamx_Rot_Right(HEXSPD_FAST,HEXSTEP_CLOSE,IKCALC_DISABLE);
				while(1)
				{

//					Dynamx_Rot_Right(HEXSPD_FAST,HEXSTEP_FAR,IKCALC_DISABLE);

//					Dynamx_Slide_Right(HEXSTEP_MED,HEXSPD_MED);
//					Dynamx_Slide_Right(HEXSTEP_MED,HEXSPD_MED);
//					Dynamx_Slide_Right(HEXSTEP_MED,HEXSPD_MED);
//					Dynamx_Slide_Right(HEXSTEP_MED,HEXSPD_MED);
//					Dynamx_Slide_Right(HEXSTEP_MED,HEXSPD_MED);
//					BW_FollowTracer_Left_Reverse();
//					Dynamx_MovBwd(4,HEXSPD_MEDFAST,IKCALC_DISABLE);
//					Dynamx_MovFwd4cm_slow(4,HEXSPD_MEDFAST,IKCALC_DISABLE);
//					BW_FollowTracer_Left();
//					Dynamx_CurveRight_Reverse(HEXSPD_FAST, HEXSTEP_FAR, IKCALC_DISABLE);
					Hybrid_TCS3200Tracer_MainMenu();
//					Dynamx_CurveLeft(HEXSPD_MEDFAST, HEXSTEP_MED, IKCALC_DISABLE);
//					Dynamx_Rot_Left(HEXSPD_FAST,HEXSTEP_FAR,IKCALC_DISABLE);
				}
			}break;

//		//BW SENSOR MODE
		case BW_MODE_5:
			{
				BW_Initial_Setup(rot_switch_mode);
				lcd_display_clear();

//				Dynamx_Rot_Right(HEXSPD_FAST,HEXSTEP_VERYCLOSE,IKCALC_DISABLE);
				//Dynamx_MovFwd4cm(4,HEXSPD_MEDFAST,IKCALC_DISABLE);
				while(1)
				{
					Sensor_Menu();
				}
			}break;

//		//BW DEMO
		case BW_MODE_6:
			{
				BW_Initial_Setup(rot_switch_mode);
				lcd_display_clear();
//				float val_test = 0;
//				SHIFT_ALGORITHM_FLAG = SHIFT_ALGORITHM_ACTIVE;
//				ROOM4A_CAT_AVOIDER = ROOM4A_CAT_AVOIDER_ACTIVE;
//				BW_LOCATION[0] = LOCATION_CORRIDOR;
				USART3_PutChar(IN_ROOM_STAT);
//				BW_PID_Flame_Init();
//				ROOM[2]=ROOM_2A;
//				FIRESCAN_DIRECTION=SCAN_RIGHT;
				lcd_gotoxy(1,0);sprintf(lcd,"BHATARA WIJAYA");lcd_putstr(lcd);
				lcd_gotoxy(4,2);sprintf(lcd,"FLAME TRACKING");lcd_putstr(lcd);
//				lcd_gotoxy(3,3);sprintf(lcd,"INTERPOLATE");lcd_putstr(lcd);
				BW_PID_Init();
//				FOLLOW_CALC = KANAN;
				while(1)
				{
					BW_FlameFollowDemo_Dynamixel();
					//Demo_TO();
/*					lcd_display_clear();
					lcd_gotoxy(1,0);sprintf(lcd,"BHATARA WIJAYA");lcd_putstr(lcd);
					lcd_gotoxy(4,1);sprintf(lcd,"FERGUSO");lcd_putstr(lcd);
					lcd_gotoxy(0,2);sprintf(lcd,"COUNT = %d", RIGHT_COUNTER);lcd_putstr(lcd);
					delay_ms(200);*/
/*					Dynamx_Mov_Static_Interpolate(LEVEL5,IKCALC_DISABLE);
					Cat_Avoider_Test();*/

/*					BW_PID_Init_FAR();
//					BWFollowCarpet_Right_Interpolate(COLOUR_GRAY, INVERSE);

					BW_PID_Init_FAR();
					BW_FollowCounter_Right(8);*/
//					BWFollowCarpet_Right_Interpolate(COLOUR_BLACK, INVERSE);

//					while(1);
/*
					if(BUTTON_B_CLICKED)
					{
						delay_ms(200);
						val_test -= 1;
//						BW_PID_Init();
//						delay_ms(200);
//						BW_FollowCounter_Left(15);
//						while(Ping[PING_FRONT] > 15)
//						{
//							Dynamx_MovFwd4cm_Interpolate(4,LEVEL5,IKCALC_DISABLE);
//						}
//						BW_FlameFollowDemo_Dynamixel();
//						BW_FollowTracer_Left_Interpolate();
						//Dynamx_Rot_Left_Interpolate(75,HEXSTEP_FAR,IKCALC_DISABLE);
						//Dynamx_MovFwd4cm_Interpolate(8,50,IKCALC_DISABLE);
						//Dynamx_Slide_Left_Interpolate(HEXSTEP_MED, 100);
//						while(1)
//						{
//							Dynamx_MovFwd4cm(4,HEXSPD_FAST, IKCALC_DISABLE);
//						}
					}
					else if(BUTTON_A_CLICKED)
					{
						delay_ms(200);
						val_test += 1;
						BW_PID_Init();
						BW_FollowTracer_Right_Interpolate();
//						delay_ms(200);
//						BWFollowCarpet_Left_Interpolate(COLOUR_GRAY,INVERSE);
//						Dynamx_MovFwd4cm_Interpolate(4,LEVEL4,IKCALC_DISABLE);
//						BWFollowCarpet_Right_Interpolate(COLOUR_BLACK,INVERSE);
						while(Ping[PING_FRONT] > 15)
						{
							//Dynamx_MovFwd4cm_Interpolate_Test(4,LEVEL5,IKCALC_DISABLE);
						}
//						lcd_display_clear();
//						lcd_gotoxy(1,0);sprintf(lcd,"BHATARA WIJAYA");lcd_putstr(lcd);
//						lcd_gotoxy(4,2);sprintf(lcd,"MOVE DX");lcd_putstr(lcd);
//						lcd_gotoxy(3,3);sprintf(lcd,"KANAN GRAY");lcd_putstr(lcd);
//						BWFollowCarpet_Right_Interpolate(COLOUR_BLACK,INVERSE);
//						lcd_display_clear();
//						lcd_gotoxy(1,0);sprintf(lcd,"BHATARA WIJAYA");lcd_putstr(lcd);
//						lcd_gotoxy(4,2);sprintf(lcd,"MOVE DX");lcd_putstr(lcd);
//						lcd_gotoxy(3,3);sprintf(lcd,"KIRI BLACK");lcd_putstr(lcd);
//						BWFollowCarpet_Left_Interpolate(COLOUR_GRAY,INVERSE);
						//Dynamx_Rot_Left_Interpolate(150,HEXSTEP_FAR,IKCALC_DISABLE);
//						while(1)
//						{
//							Trajectory_Test(2000);
//						}
						//Dynamx_Slide_Right_Interpolate(HEXSTEP_MED, 100);
//						while(1)
//						{
//							Dynamx_MovFwd4cm(4, HEXSPD_MEDFAST, IKCALC_DISABLE);
//						}
 *
 */
/*					if(BW_BUTTON_CLICKED)
					{
						BW_PID_Init();
						while(Ping[PING_FRONT] > 17)
						{
							BW_FollowCounter_Left(1);
						}

						while(Ping[PING_FRONT] < 18)
						{
							Dynamx_Rot_Right_Interpolate(LEVEL3,HEXSTEP_MED,IKCALC_DISABLE);
						}
						BW_FlameFollowDemo_Dynamixel();
						//Demo_TO();
						BW_PID_Init_Room();
						RIGHT_COUNTER = 0;
						BW_FollowCounter_Right(30);
					}*/


//					Dynamx_MovFwd4cm(4,HEXSPD_MEDFAST,IKCALC_DISABLE);
//					Dynamx_MovBwd(4,HEXSPD_FAST,IKCALC_DISABLE);
//					Dynamx_MovFwd4cm_slow(4,HEXSPD_ULTRAFAST,IKCALC_DISABLE);
//					BW_FollowFlame();
//					BW_FlameFollowDemo();
//					BW_FireFight();
//					BW_FollowTracer_Right();
//					BWFollowCarpet_Left(COLOUR_GRAY,INVERSE);


//					Dynamx_CurveLeft_Reverse(HEXSPD_FAST, HEXSTEP_FAR, IKCALC_DISABLE);

//					Dynamx_MovFwd4cm_slow(4,HEXSPD_MED,IKCALC_DISABLE);
//					Dynamx_MovFwd4cm_slow(4,HEXSPD_MED,IKCALC_DISABLE);
//					Dynamx_MovFwd4cm_slow(4,HEXSPD_MED,IKCALC_DISABLE);
////				while(1)
////				{
//					Dynamx_MovFwd4cm(4,HEXSPD_MEDFAST,IKCALC_DISABLE);
//					Dynamx_MovFwd4cm(4,HEXSPD_MEDFAST,IKCALC_DISABLE);
//					Dynamx_MovFwd4cm(4,HEXSPD_MEDFAST,IKCALC_DISABLE);
//
//					lcd_display_clear();
//					lcd_gotoxy(3,0);sprintf(lcd,"GRAY DETECTED");lcd_putstr(lcd);
//					}
//					Dynamx_Slide_Right(FAR, HEXSPD_MEDFAST);
//					Dynamx_Slide_Left(HEXSTEP_MED,HEXSPD_MED);
//					Dynamx_CurveRight(HEXSPD_MEDFAST, HEXSTEP_FAR, IKCALC_DISABLE);
//					Dynamx_Rot_Right(HEXSPD_FAST,HEXSTEP_FAR,IKCALC_DISABLE);
//					while(1)
//					{
//						mov_celebrate();
//					}

				}
			}break;
	}
	while(1)

	return 0;
}

void BW_Initialization(void)
{
	//CLOCK CONFIG
	SystemInit();

	//SYSTICK DELAY INIT
	SysTick_Init();

	//BW EXTINGUISHER INIT
	BW_Extinguisher_Init();

//	BW_UV_TRON_Init();

	//BW HEXAPOD SERVO INIT
//	BW_Servo_Initialization();

	//LCD INIT
	delay_ms(50);
	BW_LCD_Init();
	lcd_cursor_off_blink_off();
	lcd_display_clear();

	lcd_display_clear();
	lcd_gotoxy(2,0);sprintf(lcd,"PROJECT BW");lcd_putstr(lcd);
	lcd_gotoxy(5,1);sprintf(lcd,"SYSTEM");lcd_putstr(lcd);
	lcd_gotoxy(1,2);sprintf(lcd,"INITIALIZATION");lcd_putstr(lcd);
	lcd_gotoxy(1,3);sprintf(lcd,"BRAWIJAYA 2019");lcd_putstr(lcd);
	delay_ms(500);

//	USART1_Init(9600);

	//INERTIAL MEASUREMENT UNIT (IMU) SENSOR
	BW_CMPS11_Init();

//	UV_GPIO_Init_Left();

	//BW USART COMMUNICATION PROTOCOLS

//	USART2_Init(9600);
	USART1_Init_Tracer(9600);
	USART3_Init(9600);
//	UART4_Init(115200);
	UART4_Init(9600);
//	UART5_Init(9600);
//	USART6_Init(9600);
	Dynamixel_USART2_Init(1000000);
//	Dynamixel_USART6_Init(1000000);

	//BW USER INTERFACE
	Button_Init();
	Buzzer_Init();
	FIRE_LED_Init();
	BW_LED_Interrupt_Init();
	RotSwitch_Init();
	RotSwitch_Sampling();

	SND_ACT_LED_Init();

	//INFRARED PROXIMITY SENSOR
	IR_Proximity_Init();

	//BW PID CONTROLLER INITIALIZATION
	BW_PID_Init();
	PID_Calculate_Rule_Interrupt_Init();

//	Cat_Avoider_Interrupt_Init();
	//BW CONTACT BUMPER
//	Bumper_Init();

	//BW SENSOR STAT INTERRUPT
	FlameSensor_Init();

	//BW FLAME TRACKING PID
	FlameSense_PID_Init();

	//BW TPA81 INIT
	BW_TPA81_I2C_Init();

	//BW SOUND ACTIVATION INIT
	BW_Sound_Activation_Init();

//	BW TPA SERVO INIT
//	PanServo_Init();

//	BW DYNAMIXEL INTERRUPT INIT
//	Dynamixel_Drive_Interrupt_Init();

//	BW_Buzz_New(2);
	lcd_display_clear();
	lcd_gotoxy(2,0);sprintf(lcd,"PROJECT BW");lcd_putstr(lcd);
	lcd_gotoxy(5,1);sprintf(lcd,"SYSTEM");lcd_putstr(lcd);
	lcd_gotoxy(1,2);sprintf(lcd,"INITIALIZATION");lcd_putstr(lcd);
	lcd_gotoxy(3,3);sprintf(lcd,"COMPLETED");lcd_putstr(lcd);
	delay_ms(50);

	Sendto_PC(USART1,"PROJECT BW 2019 \r");
	Sendto_PC(USART1,"ELECTRICAL ENGINEERING - UNIVERSITY OF BRAWIJAYA \r");
	Sendto_PC(USART1,"SYSTEM INITIALIZATION");
	Sendto_PC(USART1,".");
	Sendto_PC(USART1,".");
	Sendto_PC(USART1,". \r");
	Sendto_PC(USART1,"INITIALIZATION COMPLETED \r");
}

void BW_SystemCheck(void)
{
	ping_count = 0;
	lcd_display_clear();
	lcd_gotoxy(2,0);sprintf(lcd,"PROJECT BW");lcd_putstr(lcd);
	lcd_gotoxy(2,1);sprintf(lcd,"SYSTEM CHECK");lcd_putstr(lcd);
	delay_ms(500);
	lcd_display_clear();
	lcd_gotoxy(2,0);sprintf(lcd,"PROJECT BW");lcd_putstr(lcd);
	lcd_gotoxy(3,1);sprintf(lcd,"PING CHECK");lcd_putstr(lcd);
	delay_ms(500);
	lcd_display_clear();
	if((Ping[PING_FRONT] != 253)&&(Ping[PING_FRONT] != 0))
	{
//		lcd_gotoxy(0,0);sprintf(lcd,"FRONT O");lcd_putstr(lcd);

	}
	else
	{
//		lcd_gotoxy(0,0);sprintf(lcd,"FRONT X");lcd_putstr(lcd);
		PING_ERROR[ping_count] = 1;
		ping_count++;
	}
//	delay_ms(200);
	if((Ping[PING_REAR] != 253)&&(Ping[PING_REAR] != 0))
	{

//		lcd_gotoxy(0,1);sprintf(lcd,"REAR  O");lcd_putstr(lcd);
	}
	else
	{
//		lcd_gotoxy(0,1);sprintf(lcd,"REAR  X");lcd_putstr(lcd);
		PING_ERROR[ping_count] = 2;
		ping_count++;
	}
//	delay_ms(200);
	if((Ping[PING_RIGHT] != 253)&&(Ping[PING_RIGHT] != 0))
	{

//		lcd_gotoxy(0,2);sprintf(lcd,"RIGHT O");lcd_putstr(lcd);
	}
	else
	{
//		lcd_gotoxy(0,2);sprintf(lcd,"RIGHT X");lcd_putstr(lcd);
		PING_ERROR[ping_count] = 3;
		ping_count++;
	}
//	delay_ms(200);
	if((Ping[PING_LEFT] != 253)&&(Ping[PING_LEFT] != 0))
	{

//		lcd_gotoxy(0,3);sprintf(lcd,"LEFT  O");lcd_putstr(lcd);
	}
	else
	{
//		lcd_gotoxy(0,3);sprintf(lcd,"LEFT  X");lcd_putstr(lcd);
		PING_ERROR[ping_count] = 4;
		ping_count++;
	}
//	delay_ms(200);
	if((Ping[PING_ASKEW_RIGHT] != 253)&&(Ping[PING_ASKEW_RIGHT] != 0))
	{

//		lcd_gotoxy(8,0);sprintf(lcd,"F_R   O");lcd_putstr(lcd);
	}
	else
	{
//		lcd_gotoxy(8,0);sprintf(lcd,"F_R   X");lcd_putstr(lcd);
		PING_ERROR[ping_count] = 5;
		ping_count++;
	}
//	delay_ms(200);
	if((Ping[PING_ASKEW_LEFT] != 253)&&(Ping[PING_ASKEW_LEFT] != 0))
	{

//		lcd_gotoxy(8,1);sprintf(lcd,"F_L   O");lcd_putstr(lcd);
	}
	else
	{
//		lcd_gotoxy(8,1);sprintf(lcd,"F_L   X");lcd_putstr(lcd);
		PING_ERROR[ping_count] = 6;
		ping_count++;
	}
//	delay_ms(200);
	if((Ping[PING_REAR_RIGHT] != 253)&&(Ping[PING_REAR_RIGHT] != 0))
	{

//		lcd_gotoxy(8,2);sprintf(lcd,"R_R   O");lcd_putstr(lcd);
	}
	else
	{
//		lcd_gotoxy(8,2);sprintf(lcd,"R_R   X");lcd_putstr(lcd);
		PING_ERROR[ping_count] = 7;
		ping_count++;
	}
//	delay_ms(200);
	if((Ping[PING_REAR_LEFT] != 253)&&(Ping[PING_REAR_LEFT] != 0))
	{

//		lcd_gotoxy(8,3);sprintf(lcd,"R_L   O");lcd_putstr(lcd);
	}
	else
	{
//		lcd_gotoxy(8,3);sprintf(lcd,"R_L   X");lcd_putstr(lcd);
		PING_ERROR[ping_count] = 8;
		ping_count++;
	}

	if(ping_count > 0)
	{
		int f;
		for(f = 0;f < ping_count;f++)
		{
		switch(PING_ERROR[f])
		{
			case 1 :
				lcd_display_clear();
				lcd_gotoxy(0,0);sprintf(lcd,"ERROR FRONT");lcd_putstr(lcd);
				while(BW_BUTTON_UNCLICKED && (Ping[PING_FRONT] == 0 || Ping[PING_FRONT] == 253))
				{
					lcd_gotoxy(0,1);sprintf(lcd,"CEK PLISS");lcd_putstr(lcd);
				}
				break;
			case 2 :
				lcd_display_clear();
				lcd_gotoxy(0,0);sprintf(lcd,"ERROR REAR");lcd_putstr(lcd);
				while(BW_BUTTON_UNCLICKED && (Ping[PING_REAR] == 0 || Ping[PING_REAR] == 253))
				{
					lcd_gotoxy(0,1);sprintf(lcd,"CEK PLISS");lcd_putstr(lcd);
				}
				break;
			case 3 :
				lcd_display_clear();
				lcd_gotoxy(0,0);sprintf(lcd,"ERROR RIGHT");lcd_putstr(lcd);
				while(BW_BUTTON_UNCLICKED && (Ping[PING_RIGHT] == 0 || Ping[PING_RIGHT] == 253))
				{
					lcd_gotoxy(0,1);sprintf(lcd,"CEK PLISS");lcd_putstr(lcd);
				}
				break;
			case 4 :
				lcd_display_clear();
				lcd_gotoxy(0,0);sprintf(lcd,"ERROR LEFT");lcd_putstr(lcd);
				while(BW_BUTTON_UNCLICKED && (Ping[PING_LEFT] == 0 || Ping[PING_LEFT] == 253))
				{
					lcd_gotoxy(0,1);sprintf(lcd,"CEK PLISS");lcd_putstr(lcd);
				}
				break;
			case 5 :
				lcd_display_clear();
				lcd_gotoxy(0,0);sprintf(lcd,"ERROR FRONT RIGHT");lcd_putstr(lcd);
				while(BW_BUTTON_UNCLICKED && (Ping[PING_ASKEW_RIGHT] == 0 || Ping[PING_ASKEW_RIGHT] == 253))
				{
					lcd_gotoxy(0,1);sprintf(lcd,"CEK PLISS");lcd_putstr(lcd);
				}
				break;
			case 6 :
				lcd_display_clear();
				lcd_gotoxy(0,0);sprintf(lcd,"ERROR FRONT LEFT");lcd_putstr(lcd);
				while(BW_BUTTON_UNCLICKED && (Ping[PING_ASKEW_LEFT] == 0 || Ping[PING_ASKEW_LEFT] == 253))
				{
					lcd_gotoxy(0,1);sprintf(lcd,"CEK PLISS");lcd_putstr(lcd);
				}
				break;
			case 7 :
				lcd_display_clear();
				lcd_gotoxy(0,0);sprintf(lcd,"ERROR REAR RIGHT");lcd_putstr(lcd);
				while(BW_BUTTON_UNCLICKED && (Ping[PING_REAR_RIGHT] == 0 || Ping[PING_REAR_RIGHT] == 253))
				{
					lcd_gotoxy(0,1);sprintf(lcd,"CEK PLISS");lcd_putstr(lcd);
				}
				break;
			case 8 :
				lcd_display_clear();
				lcd_gotoxy(0,0);sprintf(lcd,"ERROR REAR LEFT");lcd_putstr(lcd);
				while(BW_BUTTON_UNCLICKED && (Ping[PING_REAR_LEFT] == 0 || Ping[PING_REAR_LEFT] == 253))
				{
					lcd_gotoxy(0,1);sprintf(lcd,"CEK PLISS");lcd_putstr(lcd);
				}
				break;
			case 0 :
				lcd_display_clear();
				lcd_gotoxy(6,0);sprintf(lcd,"AMAN");lcd_putstr(lcd);
				delay_ms(1000);
				break;
		}
		}
	}
	lcd_display_clear();
	lcd_gotoxy(0,0);sprintf(lcd,"PROJECT BW");lcd_putstr(lcd);
	lcd_gotoxy(0,1);sprintf(lcd,"FLAME CHECK");lcd_putstr(lcd);
	if(Flame_Stat == 1)
	{
		lcd_display_clear();
		lcd_gotoxy(0,0);sprintf(lcd,"FLAME MANTULL");lcd_putstr(lcd);
		delay_ms(1000);
	}
	else
	{
		lcd_display_clear();
		lcd_gotoxy(0,0);sprintf(lcd,"FLAME MODAR");lcd_putstr(lcd);
		while(BW_BUTTON_UNCLICKED && Flame_Stat == 0)
		{
			lcd_gotoxy(0,1);sprintf(lcd,"CEK PLISS");lcd_putstr(lcd);
		}
	}
	I2C3_Test();
	delay_ms(1000);

}

