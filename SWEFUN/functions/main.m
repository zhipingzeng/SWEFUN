tic
clc,clearvars,close all
sigmoid_dichroic
GenerateSingleChannel_1(Alpha1);
GenerateSingleChannel_2(Alpha2);
GenerateSingleChannel_3(Alpha3);
GenerateSingleChannel_4(Alpha4);
GenerateSingleChannel_5(Alpha5);
GenerateSingleChannel_6(Alpha6);
CombineStack_R;
CombineStack_T;
filename0=strcat(cd,'\RawData\stack\stack_R.tif');
filename1=strcat(cd,'\RawData\stack\stack_T.tif');
CSU_SRRF_3_0;
CSU_SRRF_3_1;
CSU_SRRF_3_2;
CSU_SRRF_3_3;
CSU_SRRF_3_4;
CSU_SRRF_3_5;
solve_matrix_32bit_simulation_4_balance;