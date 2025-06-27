/*==============================================================================================
								  	 PROJECT BW Ver.1.0
								  	 BW PID CONTROLLER
==============================================================================================*/

#ifndef BW_PID_CONTROLLER_H
#define BW_PID_CONTROLLER_H

#include "main.h"

/*
 *  BW PID CONTROLLER TYPEDEF
 */
GPIO_InitTypeDef      	   GPIO_InitStructure;
TIM_OCInitTypeDef          TIM_OCInitStructure;
TIM_TimeBaseInitTypeDef    TIM_TimeBaseStructure;
NVIC_InitTypeDef           NVIC_InitStructure;

/*
 * BW PID CONTROLLER GLOBAL VARIABLES
 */
struct PID_t
{
	volatile float P[3];
	volatile float I[3];
	volatile float D[3];
	volatile float Kp;
	volatile float Ki;
	volatile float Kd;
	volatile float Ts;
	volatile float error[3];
	volatile float pid_value[3];
	volatile float set_point;
	volatile float set_point_upper;
	volatile float set_point_lower;
}PID_F_R,PID_F_L,PID_DFL_R,PID_DFL_L,PID_FLAME;

struct PID_OLD_t
{
	float P[3];
	float I[3];
	float D[3];
	float Kp;
	float Ki;
	float Kd;
	float Ts;
	float error[3];
	float pid_value[3];
	float set_point;
	float set_point_upper;
	float set_point_lower;
}PID_F_R_OLD,PID_F_L_OLD,PID_DFL_R_OLD,PID_DFL_L_OLD,PID_FLAME_OLD;

//void TIM14_IRQHandler(void);
extern unsigned int Ping[9];
extern unsigned int usart_count;
extern unsigned int FIRE;

extern unsigned int CAT_DETECTOR;
extern unsigned int CAT_ACTIVATED;
extern unsigned int CAT_DIACTIVATED;

extern volatile unsigned int FOLLOW_MARK_L, FOLLOW_MARK_R;
volatile int CALC_EN;

extern float speed_slow;
extern float speed_med_slow;
extern float speed_medium;
extern float speed_med_fast;
extern float speed_fast;
extern float angel_low;
extern float angel_med_low;
extern float angel_medium;
extern float angel_med_high;
extern float angel_high;
extern int Fuzzy_FKR_SP;
extern float ERROR_DATA[5];
extern int   selisih;
extern int   selisih_kanan;
extern float jarak[5];
extern float final_speed,final_angel[2];
extern float Defuzzy_foward;
extern float Defuzzy_follow_kiri;
extern float Defuzzy_follow_kanan;

extern const int LEFT_FOLLOW;
extern const int RIGHT_FOLLOW;


void BW_PID_Interrupt_Init(void);
void BW_PID_Init(void);
void BW_PID_Init_Reverse(void);
void BW_PID_Init_Room(void);
void BW_PID_Init_FAR(void);
void BW_PID_Init_Furniture(void);
void BW_PID_Flame_Init(void);
void PID_Calc_RightRule(void);
void PID_Calc_RightRule_Reverse(void);
void PID_Calc_LeftRule(void);
void PID_Calc_LeftRule_Reverse(void);
void PID_Calc_FlameRule(void);
void PID_Calculate_Rule_Interrupt_Init(void);
void Restore_Old_Error_Right(void);
void Restore_Old_Error_Left(void);
void Fuzzy_Follow_kanan(void);
void Fuzzy_Follow_kiri(void);


void PID_Runtime_Tuning(void);
void Kp_Tuning_R(void);
void Ki_Tuning_R(void);
void Kd_Tuning_R(void);
void Kp_Tuning_L(void);
void Ki_Tuning_L(void);
void Kd_Tuning_L(void);


#endif
