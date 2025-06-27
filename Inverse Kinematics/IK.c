#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#define Length1 4 //panjang TIBIA
#define Length2 5.5 //ketinggian robot
//#define IK_L -90
//#define IK_H 90
#define	MODE1 0
#define MODE2 1

#define FRONT_RIGHT_DX 0
#define RIGHT_DX 1
#define REAR_RIGHT_DX 2
#define FRONT_LEFT_DX 3
#define LEFT_DX 4
#define REAR_LEFT_DX 5

#define COXA_ANGLE 0
#define FEMUR_ANGLE 1
#define TIBIA_ANGLE 2

float rad_teta1;
float rad_teta2;
float rad_teta3;

float deg_teta1;
float deg_teta2;
float deg_teta3;

float FR_LEG[3];
float R_LEG[3];
float RR_LEG[3];
float FL_LEG[3];
float L_LEG[3];
float RL_LEG[3];

float X,Y,Z;

void Dynamx_IKCALC(float x,float y, float z, int leg)
{
	float A = ((x*x)+(y*y)+(z*z)-(Length1*Length1)-(Length2*Length2))/(2*Length1*Length2);
	rad_teta3 = acos(A);
	float B = (z*(Length2*cos(rad_teta3)+Length1))-((sqrt((x*x)+(y*y)))*Length2*sin(rad_teta3));
	float C = (sqrt((x*x)+(y*y)))*(Length2*cos(rad_teta3)+Length1)+(z*Length2*sin(rad_teta3));
	rad_teta2 = atan(B/C);
	rad_teta1 = atan(y/x);
	
	deg_teta1= rad_teta1*57.295;
	deg_teta2= rad_teta2*57.295;
	deg_teta3= rad_teta3*57.295;
		
	switch(leg)
	{
		case FRONT_RIGHT_DX:
		{
			FR_LEG[COXA_ANGLE] = deg_teta1;
			FR_LEG[FEMUR_ANGLE] = deg_teta2;
			FR_LEG[TIBIA_ANGLE] = deg_teat3;
			break;
		
		}
		case RIGHT_DX:
		{
			R_LEG[COXA_ANGLE] = deg_teta1;
			R_LEG[FEMUR_ANGLE] = deg_teta2;
			R_LEG[TIBIA_ANGLE] = deg_teta3;
			break;
		}
		case REAR_RIGHT_DX:
		{
			RR_LEG[COXA_ANGLE] = deg_teta1;
			RR_LEG[FEMUR_ANGLE] = deg_teta2;
			RR_LEG[TIBIA_ANGLE] = deg_teta3;
			break;	
		}
		case FRONT_LEFT_DX:
		{
			FL_LEG[COXA_ANGLE] = deg_teta1;
			FL_LEG[FEMUR_ANGLE] = deg_teta2;
			FL_LEG[TIBIA_ANGLE] = deg_teta3;
			break;		
		}
		case LEFT_DX:
		{
			L_LEG[COXA_ANGLE] = deg_teta1;
			L_LEG[FEMUR_ANGLE] = deg_teta2;
			L_LEG[TIBIA_ANGLE] = deg_teta3;	
			break;	
		}
		case REAR_LEFT_DX:
		{
			RL_LEG[COXA_ANGLE] = deg_teta1;
			RL_LEG[FEMUR_ANGLE] = deg_teta2;
			RL_LEG[TIBIA_ANGLE] = deg_teta3;
			break;	
		}
	}
}
	
//	if(deg_teta1 < IK_L)
//	{
//		deg_teta1 = IK_L;
//	}
//	else if(deg_teta1 > IK_H)
//	{
//		deg_teta1 = IK_H;
//		
//	}
//	else if(deg_teta2 < IK_L)
//	{
//		deg_teta2 = IK_L;
//	}
//	else if(deg_teta2 > IK_H)
//	{
//		deg_teta2 = IK_H;
//		
//	}
//	else if(deg_teta3 < IK_L)
//	{
//		deg_teta3 = IK_L;
//	}
//	else if(deg_teta3 > IK_H)
//	{
//		deg_teta3 = IK_H;
//		
//	}
}



//	float A= ((x*x)+(y*y)+(z*z)-(Length1*Length1)-(Length2*Length2))/(2*Length1*Length2);
//	float B=sqrt(1-(A*A));
//	rad_teta3= atan2(B,A);
//	float buff_1= (Length2*cos(rad_teta3))+Length1;
//	float buff_2= sqrt((x*x)+(y*y));
//	float buff_3= Length2*sin(rad_teta3);
//	float C= (z*buff_1)-(buff_2*buff_3);
//	float D= (buff_1*buff_2)+(z*buff_3);
//	rad_teta2=atan2(C,D);
//	rad_teta1=atan2(x,y);
int main()
{
	while(1)
	{
		printf("X=");
		scanf("%f",&X);
		printf("Y=");
		scanf("%f",&Y);
		printf("Z=");
		scanf("%f",&Z);
		printf("------------------------\n");
		Dynamx_IKCALC(X,Y,Z,FRONT_RIGHT_DX);
		printf("COXA = %.3f\n",rad_teta1); 
		printf("FEMUR = %.3f\n",rad_teta2);
		printf("TIBIA = %.3f\n",rad_teta3);  
	//	printf("X = %.2f\n",X);
	//	printf("Y = %.2f\n",Y);
	//	printf("Z = %.2f\n",Z);
		printf("\n");
		printf("COXA = %.3f\n",deg_teta1); 
		printf("FEMUR = %.3f\n",deg_teta2);
		printf("TIBIA = %.3f\n",deg_teta3);  
		system("PAUSE");
		system("cls");	
	}
	
}
