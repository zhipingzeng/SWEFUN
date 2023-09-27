
%y1 = (2/(1+exp(-a*u1)))-1;
%测试不同的a值曲线的变化
t=450:1:750;
b = 1; % 调节y轴大小
  a1 =app.a1;  % 调节曲线陡峭程度，0.057条件数最小,0.12无法分离，0.037
  N=app.N;  %598
%a1,N 由数值框输入
Qdot1 = app.Fluor1;
Qdot2 = app.Fluor2;
Qdot3 = app.Fluor3;
Qdot4 = app.Fluor4;
Qdot5 = app.Fluor5;
Qdot6 = app.Fluor6;
y1 = b./(1+exp(-a1*(t-N)));%一个数除以矩阵
y1_1 = b./(1+exp(-a1*(Qdot1-N)));
y1_2 = b./(1+exp(-a1*(Qdot2-N)));
y1_3 = b./(1+exp(-a1*(Qdot3-N)));
y1_4 = b./(1+exp(-a1*(Qdot4-N)));
y1_5 = b./(1+exp(-a1*(Qdot5-N)));
y1_6 = b./(1+exp(-a1*(Qdot6-N)));
y1_1_reflection = 1-y1_1;
app.rr1.Value = y1_1_reflection;
y1_2_reflection = 1-y1_2;
app.rr2.Value = y1_2_reflection;
y1_3_reflection = 1-y1_3;
app.rr3.Value = y1_3_reflection;
y1_4_reflection = 1-y1_4;
app.rr4.Value = y1_4_reflection;
y1_5_reflection = 1-y1_5;
app.rr5.Value = y1_5_reflection;
y1_6_reflection = 1-y1_6;
app.rr6.Value = y1_6_reflection;
% y2 = (b./(1+exp(-a2*t)))-1;
% y3 = (b./(1+exp(-a3*t)))-1;
% y4 = (b./(1+exp(-a4*t)))-1;
% y5 = (b./(1+exp(-a5*t)))-1;
%绘制不同的a值得曲线变化

% plot(t,y1,'r',t,y2,'--b',t,y3,'g',t,y4,'y',t,y5,'k','linewidth',0.5);

% hold on;
% grid on;
% legend('a=1','a=2','a=3','a=4','a=5','fontsize',5);


%%
Alpha1=(1-y1_1_reflection)/y1_1_reflection ; %0.1
Alpha2=(1-y1_2_reflection)/y1_2_reflection ; %0.3
Alpha3=(1-y1_3_reflection)/y1_3_reflection;  %0.51
Alpha4=(1-y1_4_reflection)/y1_4_reflection ;% 3
Alpha5=(1-y1_5_reflection)/y1_5_reflection; %6.03
Alpha6=(1-y1_6_reflection)/y1_6_reflection ;%43.1
R1=1/(1+Alpha1);
R2=1/(1+Alpha2);
R3=1/(1+Alpha3);
R4=1/(1+Alpha4);
R5=1/(1+Alpha5);
R6=1/(1+Alpha6);
T1=Alpha1/(1+Alpha1);
T2=Alpha2/(1+Alpha2);
T3=Alpha3/(1+Alpha3);
T4=Alpha4/(1+Alpha4);
T5=Alpha5/(1+Alpha5);
T6=Alpha6/(1+Alpha6);
R = [R1^5 R2^5 R3^5 R4^5 R5^5 R6^5;T1*R1^4 T2*R2^4 T3*R3^4 T4*R4^4 T5*R5^4 T6*R6^4;T1^2*R1^3 T2^2*R2^3 T3^2*R3^3 T4^2*R4^3 T5^2*R5^3 T6^2*R6^3;T1^3*R1^2 T2^3*R2^2 T3^3*R3^2 T4^3*R4^2 T5^3*R5^2 T6^3*R6^2;T1^4*R1 T2^4*R2 T3^4*R3 T4^4*R4 T5^4*R5 T6^4*R6;T1^5 T2^5 T3^5 T4^5 T5^5 T6^5;];  % note that the accuracy
% R=1e4.*R;  %加权以降低矩阵的条件数
% R = power(R,1/5);
R_max_1=max(R(1,:));
R_max_2=max(R(2,:));
R_max_3=max(R(3,:));
R_max_4=max(R(4,:));
R_max_5=max(R(5,:));
R_max_6=max(R(6,:));
v=[1/R_max_1 1/R_max_2 1/R_max_3 1/R_max_4 1/R_max_5 1/R_max_6];
D = diag(v);
N=D*R;
R_cond = cond(R);
N_cond = cond(N);
[R_eig_vector, R_eig_value] = eig(R);
[N_eig_vector, N_eig_value] = eig(N);
R_eig_sum=sum(diag(R_eig_value));
N_eig_sum=sum(diag(N_eig_value));
pjjjjj= [y1_1  y1_2 y1_3 y1_4 y1_5 y1_6 ; y1_1_reflection y1_2_reflection y1_3_reflection y1_4_reflection y1_5_reflection y1_6_reflection ]';

