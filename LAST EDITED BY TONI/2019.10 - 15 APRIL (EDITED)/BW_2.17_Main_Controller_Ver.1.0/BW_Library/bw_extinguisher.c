/*========================================================================================
								   PROJECT BW 2.16 Ver.1.0
								  BW Hydro Extinguisher Library
==============================================================================================*/

#include "bw_extinguisher.h"
#define DYNA_EXT_ID		63
#define OPEN			160 //60	//170
#define CLOSE			230 //190

void BW_Extinguisher_Init(void)
{
//	EXTINGUISHER_OFF;
	Pump_GPIOInit();
	EXTINGUISHER_OFF;
}

void Pump_GPIOInit(void)
{

	RCC_AHB1PeriphClockCmd (RCC_AHB1Periph_EXTINGUISHER, ENABLE); // Clocking GPIOC (AHB1/APB1 = 42MHz)
	GPIO_InitStructure.GPIO_Pin = EXTINGUISHER_PIN | GPIO_Pin_13;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;       // Pin ini memiliki Mode Ouput
	GPIO_InitStructure.GPIO_OType = GPIO_OType_OD; 		// Pin bersifat Push Pull (Pull-up, down or no Pull)
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_100MHz; 	// kecepatan clock(2, 25, 50 or 100 MHz)
	GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP; 	// pin tidak diberikan pull up
	GPIO_Init(EXTINGUISHER_PORT, &GPIO_InitStructure); 		// inisialisasi peripheral GPIO sesuai parameter typdef diatas

}

void DynaExt(int Degree)
{
	Dyna_Actuate(DYNA_EXT_ID, Degree, HEXSPD_ULTRAFAST, 220);
}

void CO2_LAUNCHER(int EXTEND_DEG, int delay_val)
{
	DynaExt(CLOSE);
	delay_ms(200);
	DynaExt(OPEN - EXTEND_DEG);
	delay_ms(delay_val);
	DynaExt(CLOSE);
}

void TEST_CO2_EXTI(int degree)
{
	DynaExt(CLOSE);
	DynaExt(degree);
	delay_ms(300);
	DynaExt(CLOSE);
}

void BW_HydroPump (void)
{
	EXTINGUISHER_ON;
	EXT_1_ON;
	delay_ms(2200);
	EXT_1_OFF;
	EXTINGUISHER_OFF;
}

void BW_Pump_R4(void)
{
	while(FlameSenseDigi[0] != 4 && FlameFrontDigi[0] != 4)
	{
		FlameTracking_Center();
	}
	if(FlameSenseDigi[0] == 4 && FlameFrontDigi[0] == 4)
	{
		if(SHARP[SHARP_FRONT_L] > 12)Dynamx_MovFwd4cm_Interpolate(4,LEVEL5,IKCALC_DISABLE);
		if(SHARP[SHARP_FRONT_L] > 12)Dynamx_MovFwd4cm_Interpolate(4,LEVEL5,IKCALC_DISABLE);
		while(FlameSenseDigi[0] != 4 && FlameFrontDigi[0] != 4)
		{
			FlameTracking_Center();
		}
		/*EXTINGUISHER_ON;*/
//		DynaExt(OPEN);
		Dynamx_Mov_Static_Interpolate(LEVEL3,IKCALC_DISABLE);
		BW_HydroPump_V10();
//		Dynamx_Mov_Extinguish_V10(LEVEL2);
//		Dynamx_Mov_Extinguish_V10(LEVEL2);
//		DynaExt(CLOSE);
	}
	UVLock_Refresh();
	delay_ms(200);
	if(UV_Lock == UVLOCK_ACTIVE)
	{
//		Dynamx_Rot_Right_Interpolate(LEVEL3,HEXSTEP_CLOSE,IKCALC_DISABLE);
//		Dynamx_Rot_Right_Interpolate(LEVEL3,HEXSTEP_CLOSE,IKCALC_DISABLE);
		UVLock_Refresh();
		delay_ms(200);
		if(UV_Lock == UVLOCK_ACTIVE)
		{
		if((FlameSenseDigi[0] != 4 && FlameFrontDigi[0] != 4) && UV_Lock == UVLOCK_ACTIVE)
		{
			FlameTracking_Center();
		}
		if(SHARP[SHARP_FRONT_L] > 12)
		{
			Dynamx_MovFwd4cm_Interpolate(4,LEVEL5,IKCALC_DISABLE);
		}
		if(SHARP[SHARP_FRONT_L] > 12)
		{
			Dynamx_MovFwd4cm_Interpolate(4,LEVEL5,IKCALC_DISABLE);
		}
		}

		UVLock_Refresh();
		delay_ms(200);
		if((FlameSenseDigi[0] != 4 && FlameFrontDigi[0] != 4) && UV_Lock == UVLOCK_ACTIVE)
		{
			FlameTracking_Center();
			BW_HydroPump_V10();
		}

//		Dynamx_Rot_Left_Interpolate(LEVEL3,HEXSTEP_CLOSE,IKCALC_DISABLE);
//		Dynamx_Rot_Left_Interpolate(LEVEL3,HEXSTEP_CLOSE,IKCALC_DISABLE);
		UVLock_Refresh();
		delay_ms(200);
		if(UV_Lock == UVLOCK_ACTIVE)
		{
		if((FlameSenseDigi[0] != 4 && FlameFrontDigi[0] != 4) && UV_Lock == UVLOCK_ACTIVE)
		{
			FlameTracking_Center();
		}
		if(SHARP[SHARP_FRONT_L] > 12)
		{
			Dynamx_MovFwd4cm_Interpolate(4,LEVEL5,IKCALC_DISABLE);
		}
		if(SHARP[SHARP_FRONT_L] > 12)
		{
			Dynamx_MovFwd4cm_Interpolate(4,LEVEL5,IKCALC_DISABLE);
		}
		if((FlameSenseDigi[0] != 4 && FlameFrontDigi[0] != 4) && UV_Lock == UVLOCK_ACTIVE)
		{
			FlameTracking_Center();
			BW_HydroPump_V10();
		}
		}

	}
}

void BW_HydroPump_V10 (void)
{
	Dynamx_Mov_Static_Interpolate(LEVEL5,IKCALC_DISABLE);
	if(ROOM[2] == ROOM_1A || ROOM[2] == ROOM_1B || ROOM[2] == ROOM_1C)
	{
		CO2_LAUNCHER(0, 500);
	}

	else if(ROOM[2] == ROOM_4A || ROOM[2] == ROOM_4B)
	{
		CO2_LAUNCHER(0, 300);
	}

	else CO2_LAUNCHER(0, 300);
}

void BW_CO2_TEST(void)
{
		int kwontlo = CLOSE;
		while(1)
		{
			lcd_display_clear();
			lcd_gotoxy(1,0);sprintf(lcd,"BHATARA WIJAYA");lcd_putstr(lcd);
			lcd_gotoxy(2,2);sprintf(lcd,"CO2 EXTI");lcd_putstr(lcd);
			lcd_gotoxy(2,3);sprintf(lcd,"Degree : %d",kwontlo);lcd_putstr(lcd);

			if(BUTTON_A_CLICKED)
			{
				while(BUTTON_A_CLICKED);
				kwontlo = kwontlo + 5;
			}

			else if(BUTTON_B_CLICKED)
			{
				while(BUTTON_B_CLICKED);
				kwontlo = kwontlo - 5;
			}
			if(kwontlo < 0)kwontlo = 0;
			if(BW_BUTTON_CLICKED)
			{
				TEST_CO2_EXTI(kwontlo);
				//DynaExt(kwontlo);
			}
			delay_ms(100);
		}
}

void BW_HydroPump_2 (void)
{

	BW_Buzz(4);

//	unsigned int SPEED=HEXSPD_SLOW;
	int i=0;
	int CNT=0;
	int g;
	int y;

	BW_Buzz(4);
	EXTINGUISHER_ON;
//	delay_ms(1000);

		Get_UV();
		lcd_display_clear();
		while(UV_state==0)
		{
			Get_UV();
			if(UV_state == 1)break;
			lcd_gotoxy(2,0);sprintf(lcd,"EXT FUNCTION");lcd_putstr(lcd);
			for(y = 0;y <=1;y++)
			{
				Dynamx_Mov_Extinguish_V10(LEVEL2);
			}
			Get_UV();
			if(UV_state == 1)break;
			while(i>0 && UV_state==0)//&& ((Ping[PING_FRONT]>20) || (SHARP[SHARP_FRONT_R]>20) || (SHARP[SHARP_FRONT_L]>20)))
			{
//				delay_ms(500);
				Get_UV();
				if(UV_state==1)break;

//				lcd_display_clear();
//				lcd_gotoxy(2,0);sprintf(lcd,"EXT FUNCTION PLUS");lcd_putstr(lcd);
				CNT++;
//				lcd_gotoxy(0,3);sprintf(lcd,"CNT = %d",CNT);lcd_putstr(lcd);

				for(y = 0;y <=1;y++)
				{
					Dynamx_Mov_Extinguish_V10(LEVEL2);
				}
//				Dynamx_Mov_Extinguish_V10(HEXSPD_FAST);
//				delay_ms(500);
				Get_UV();
				if(UV_state==1)break;

				if((FlameFrontDigi[0]==4) && UV_state==0 &&(Ping[PING_FRONT]>30) && ((SHARP[SHARP_FRONT_R]>25) || (SHARP[SHARP_FRONT_L]>25)))
				{
					EXTINGUISHER_OFF;
					lcd_display_clear();
					lcd_gotoxy(2,0);sprintf(lcd,"FORWARD CORRECTION");lcd_putstr(lcd);
//					while (Ping[PING_FRONT]>30)
//					{
//						Dynamx_MovFwd4cm(4,HEXSPD_MEDFAST,IKCALC_DISABLE);
//						Furniture_Avoider();
//						Bumper_Follow();
//					}
					Dynamx_MovFwd4cm_Interpolate(4,LEVEL3,IKCALC_DISABLE);
					Furniture_Avoider();
					Bumper_Follow();

					Get_UV();
					if(UV_state==1)break;

					FlameTracking_Center();

					if((SHARP[SHARP_FRONT_R]<11) || (SHARP[SHARP_FRONT_L]<11))
					{
						Dynamx_Mov_Static_Interpolate(LEVEL5,IKCALC_DISABLE);
						delay_ms(50);
						Dynamx_MovBwd_Interpolate(4,LEVEL5,IKCALC_DISABLE);

					}
					if((SHARP[SHARP_FRONT_R]>12) || (SHARP[SHARP_FRONT_L]>15))Dynamx_MovFwd4cm_Interpolate(4,LEVEL5,IKCALC_DISABLE);
					if((SHARP[SHARP_FRONT_R]>12) || (SHARP[SHARP_FRONT_L]>15))Dynamx_MovFwd4cm_Interpolate(4,LEVEL5,IKCALC_DISABLE);

					FlameTracking_Center();

					EXTINGUISHER_ON;

				}
			if(CNT==2 && UV_state==0)
			{
				// UNTUK LILIN TENGAH
				Get_UV();
				if(UV_state==1)break;

				if((SP_FIRE_1B==SP_FIRE_ACTIVE) && ((Ping[PING_FRONT]>40) || ((SHARP[SHARP_FRONT_R]<10) || (SHARP[SHARP_FRONT_L]<10))))
				{
					lcd_display_clear();
					lcd_gotoxy(2,0);sprintf(lcd,"LILIN TENGAH !!!");lcd_putstr(lcd);
					Dynamx_MovBwd_Interpolate(4,LEVEL5,IKCALC_DISABLE);
					SP_FIRE_1B=SP_FIRE_INACTIVE;
//					FIREROOM_R1A_FLAG==FIREROOM_R1A_INACTIVE;
				}
				else if((FIRESCAN_DIRECTION==SCAN_RIGHT ||(FOLLOW_FLAG==KIRI)) && UV_Lock==UVLOCK_ACTIVE)
				{
					lcd_display_clear();
					lcd_gotoxy(2,0);sprintf(lcd,"FOLLOW CORRECTION LEFT");lcd_putstr(lcd);
					EXTINGUISHER_OFF;
					BW_PID_Init_Room();
					for(g=0;g<=10;g++)
					{
						BW_FollowCounter_Left(1);
						if(g>1)
						{
							TRACER_STAT=TRACER_BLACK;
							TCSlave_Check();
							if (TRACER_STAT==TRACER_WHITE)
							{
								lcd_display_clear();
								lcd_gotoxy(0,0);sprintf(lcd,"TRACER STATS");lcd_putstr(lcd);
								lcd_gotoxy(0,1);sprintf(lcd,"WHITE");lcd_putstr(lcd);
								delay_ms(50);
								Dynamx_MovBwd_Interpolate(8,LEVEL5,IKCALC_DISABLE);
								Nav_TurnAround(TURN_RIGHT);
								Dynamx_MovFwd4cm_Interpolate(4,LEVEL5,IKCALC_DISABLE);
//								break;
							}
							if((FlameSenseDigi[0]==4) || (FlameSenseDigi[0]==5))break;
//							if((FlameSenseDigi[0]==3) || (FlameSenseDigi[0]==2))Dynamx_MovFwd4cm(4,HEXSPD_MEDFAST,IKCALC_DISABLE);break;
							if(FlameFrontDigi[0]==4)break;
						}
					}

					Get_UV();
					if(UV_state==1)break;
					for(x=0;x<=3;x++)
					{
						FlameTracking_Center();
						while(SHARP[SHARP_FRONT_R]>13 && (SHARP[SHARP_FRONT_L]>13))
						{
							Dynamx_MovFwd4cm_Interpolate(4,LEVEL3,IKCALC_DISABLE);

							Furniture_Avoider();
							Bumper_Follow();

							if(FlameFrontDigi[0]!=4)break;
						}

						Bumper_Follow();
						FlameTracking_Center();
						while(SHARP[SHARP_FRONT_R]>13 && (SHARP[SHARP_FRONT_L]>13))
						{
							Dynamx_MovFwd4cm_Interpolate(4,LEVEL3,IKCALC_DISABLE);

							Furniture_Avoider();
							Bumper_Follow();

							if(FlameFrontDigi[0]!=4)break;
						}

						Bumper_Follow();
					}
					if((SHARP[SHARP_FRONT_R]<13) || (SHARP[SHARP_FRONT_L]<13))
					{
						Dynamx_Mov_Static_Interpolate(LEVEL5,IKCALC_DISABLE);
						delay_ms(50);
						Dynamx_MovBwd_Interpolate(4,LEVEL5,IKCALC_DISABLE);
					}

				EXTINGUISHER_ON;
				}

				else if((FIREROOM_R1A_FLAG==FIREROOM_R1A_ACTIVE || FIRESCAN_DIRECTION==SCAN_LEFT ||(FOLLOW_FLAG==KANAN)) && UV_Lock==UVLOCK_ACTIVE)
				{
					Get_UV();
					if(UV_state==1)break;
					EXTINGUISHER_OFF;
					lcd_display_clear();
					lcd_gotoxy(2,0);sprintf(lcd,"FOLLOW CORRECTION RIGHT");lcd_putstr(lcd);
					BW_PID_Init_Room();
						for(g=0;g<=10;g++)
						{
							BW_FollowCounter_Right(1);

							if(g>1)
							{
								TRACER_STAT=TRACER_BLACK;
								TCSlave_Check();
								if (TRACER_STAT==TRACER_WHITE)
									{
										lcd_display_clear();
										lcd_gotoxy(0,0);sprintf(lcd,"TRACER STATS");lcd_putstr(lcd);
										lcd_gotoxy(0,1);sprintf(lcd,"WHITE");lcd_putstr(lcd);
										delay_ms(50);

										Dynamx_Mov_Static_Interpolate(LEVEL5,IKCALC_DISABLE);
										delay_ms(50);
										Dynamx_MovBwd_Interpolate(8,LEVEL5,IKCALC_DISABLE);
										Nav_TurnAround(TURN_RIGHT);
										Dynamx_MovFwd4cm_Interpolate(4,LEVEL3,IKCALC_DISABLE);
//										break;
									}
								if((FlameSenseDigi[0]==4) || (FlameSenseDigi[0]==3))break;
							}
							if(FlameFrontDigi[0]==4)break;
						}
					Get_UV();
					if(UV_state==1)break;

					FlameTracking_Center();

					for(x=0;x<=3;x++)
					{
						FlameTracking_Center();
						while(SHARP[SHARP_FRONT_R]>13 && (SHARP[SHARP_FRONT_L]>13))
						{
							Dynamx_MovFwd4cm_Interpolate(4,LEVEL3,IKCALC_DISABLE);

							Furniture_Avoider();
							Bumper_Follow();

							if(FlameFrontDigi[0]!=4)break;
						}

						Bumper_Follow();

						FlameTracking_Center();
						while(SHARP[SHARP_FRONT_R]>13 && (SHARP[SHARP_FRONT_L]>13))
						{
							Dynamx_MovFwd4cm_Interpolate(4,LEVEL3,IKCALC_DISABLE);

							Furniture_Avoider();
							Bumper_Follow();

							if(FlameFrontDigi[0]!=4)break;
						}

						Bumper_Follow();
					}
					if(SHARP[SHARP_FRONT_R]<11 || (SHARP[SHARP_FRONT_L]<11))
					{
						Dynamx_Mov_Static_Interpolate(LEVEL5,IKCALC_DISABLE);
						delay_ms(50);
						Dynamx_MovBwd_Interpolate(4,LEVEL5,IKCALC_DISABLE);
					}

				EXTINGUISHER_ON;
					}
				}
			}
			i++;
			UVLock_Refresh();
			if(UV_Lock==UVLOCK_INACTIVE){lcd_display_clear();lcd_gotoxy(2,0);sprintf(lcd,"UV INACTIVE");lcd_putstr(lcd);EXTINGUISHER_OFF;break;}
		}
	EXTINGUISHER_OFF;
}

void PushTo_Burst (void)
{
	lcd_display_clear();
	lcd_gotoxy(2,0);sprintf(lcd,"PROJECT BW");lcd_putstr(lcd);
	lcd_gotoxy(4,1);sprintf(lcd,"BRAWIJAYA");lcd_putstr(lcd);
	lcd_gotoxy(2,2);sprintf(lcd,"PUSH TO BURST");lcd_putstr(lcd);
	lcd_gotoxy(2,3);sprintf(lcd,"JTE FT-UB 63");lcd_putstr(lcd);
	delay_ms(100);

//	mov_static();
//	delay_ms(100);

//	EXTINGUISHER_OFF;

/*	BW_START=BW_BUTTON_INPUT;
	if(BW_START==1)
	{
//		BW_Buzz(2);
//		BW_HydroPump();
//		BW_BLDC_Fight();
		CO2_LAUNCHER(0,500);
	}
	else EXTINGUISHER_OFF;*/
	if(BW_BUTTON_CLICKED)
	{
		while(BW_BUTTON_CLICKED)
		CO2_LAUNCHER(0,300);
	}
}
