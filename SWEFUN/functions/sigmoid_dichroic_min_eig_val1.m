tic
% clc;
% clearvars
%y1 = (2/(1+exp(-a*u1)))-1;
%测试不同的a值曲线的变化
t=450:1:750;
b = 1; % 调节y轴大小
X=0;
for a1 =0:0.001:0.100  % 调节曲线陡峭程度，0.057条件数最小,0.12无法分离
    X=X+1;
    Y=0;
    for n=530:630
        Y=Y+1;
        a1_val(X,Y)=a1;
        N_val(X,Y)=n;
% Fluor1 = 525;
% Fluor2 = 565;
% Fluor3 = 585;
% Fluor4 = 605;
% Fluor5 = 655;
% Fluor6 = 705;
Fluor1 = app.Fluor1;
Fluor2 = app.Fluor2;
Fluor3 = app.Fluor3;
Fluor4 = app.Fluor4;
Fluor5 = app.Fluor5;
Fluor6 = app.Fluor6;
y1 = b./(1+exp(-a1*(t-n)));%一个数除以矩阵
y1_1 = b./(1+exp(-a1*(Fluor1-n)))
y1_2 = b./(1+exp(-a1*(Fluor2-n)))
y1_3 = b./(1+exp(-a1*(Fluor3-n)))
y1_4 = b./(1+exp(-a1*(Fluor4-n)))
y1_5 = b./(1+exp(-a1*(Fluor5-n)))
y1_6 = b./(1+exp(-a1*(Fluor6-n)))
y1_1_reflection = 1-y1_1;
y1_2_reflection = 1-y1_2;
y1_3_reflection = 1-y1_3;
y1_4_reflection = 1-y1_4;
y1_5_reflection = 1-y1_5;
y1_6_reflection = 1-y1_6;
% y2 = (b./(1+exp(-a2*t)))-1;
% y3 = (b./(1+exp(-a3*t)))-1;
% y4 = (b./(1+exp(-a4*t)))-1;
% y5 = (b./(1+exp(-a5*t)))-1;
%绘制不同的a值得曲线变化
% figure(1)
% 
% plot(t,y1,'r','linewidth',0.5);
% 
% title('a值不同的sigmoid曲线')

%%
% Alpha1=0.1;
% Alpha2=0.25;
% Alpha3=0.51;
% Alpha4=3;
% Alpha5=6.03;
% Alpha6=43.1;
Alpha1=(1-y1_1_reflection)/y1_1_reflection;  %0.1
Alpha2=(1-y1_2_reflection)/y1_2_reflection;  %0.3
Alpha3=(1-y1_3_reflection)/y1_3_reflection;  %0.51
Alpha4=(1-y1_4_reflection)/y1_4_reflection;  % 3
Alpha5=(1-y1_5_reflection)/y1_5_reflection;  %6.03
Alpha6=(1-y1_6_reflection)/y1_6_reflection;  %43.1
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
R_cond(X,Y) = cond(R);
N_cond(X,Y) = cond(N);
[R_eig_vector, R_eig_value] = eig(R);
R_eig(X,Y)=min(diag(R_eig_value));
R_eig_sum(X,Y)=sum(diag(R_eig_value));
[N_eig_vector, N_eig_value] = eig(N);
N_eig(X,Y)=min(diag(N_eig_value));
N_eig_sum(X,Y)=sum(diag(N_eig_value));
    end
end

minimum_R_cond = min(min(R_cond));
[a1_R_cond,n_R_cond]=find(R_cond==minimum_R_cond);
a1_val(a1_R_cond,n_R_cond)
N_val(a1_R_cond,n_R_cond)

minimum_N_cond = min(min(N_cond));
[a1_N_cond,n_N_cond]=find(N_cond==minimum_N_cond);
a1_val(a1_N_cond,n_N_cond)
N_val(a1_N_cond,n_N_cond)

maximum_R_eig = max(max(R_eig));
[a1_R_eig,n_R_eig]=find(R_eig==maximum_R_eig);
a1_val(a1_R_eig,n_R_eig)
N_val(a1_R_eig,n_R_eig)


maximum_N_eig = max(max(N_eig));
[a1_N_eig,n_N_eig]=find(N_eig==maximum_N_eig);
a1_val(a1_N_eig,n_N_eig)
N_val(a1_N_eig,n_N_eig)


maximum_R_eig_sum = max(max(R_eig_sum));
[a1_R_eig_sum,n_R_eig_sum]=find(R_eig_sum==maximum_R_eig_sum);
a1_val(a1_R_eig_sum,n_R_eig_sum)
N_val(a1_R_eig_sum,n_R_eig_sum)

maximum_N_eig_sum = max(max(N_eig_sum));
[a1_N_eig_sum,n_N_eig_sum]=find(N_eig_sum>=maximum_N_eig_sum-0.000001);
a1_val(a1_N_eig_sum,n_N_eig_sum)
N_val(a1_N_eig_sum,n_N_eig_sum)
for ii = 1:length(a1_N_eig_sum)
    N_cond_2(ii) = N_cond(a1_N_eig_sum(ii),n_N_eig_sum(ii));
end
    minimum_N_cond_2 = min(min(N_cond_2));
    [a1_N_cond_2,n_N_cond_2]=find(N_cond==minimum_N_cond_2);
    a1_val(a1_N_cond_2,n_N_cond_2)
    N_val(a1_N_cond_2,n_N_cond_2)

 a=0.01:0.001:0.100;
 b=530:630;
 %fig1 = figure(1);
 axesHandle = app.UIAxes1;
%imagesc(b,a,log(N_cond(11:101,:)),'parent',axesHandle);
axesPosition = get(axesHandle, 'Position');
resizedData = imresize(log(N_cond(11:101,:)), [axesPosition(4), axesPosition(3)]);%调整热图数据的大小
imagesc(b, a, resizedData, 'Parent', axesHandle);
xlim(axesHandle, [min(b), max(b)]);
ylim(axesHandle, [min(a), max(a)]);%设置坐标区的限制
 xticks(axesHandle,530:20:630);
 yticks(axesHandle,0.01:0.02:0.100);
flippedColormap = flipud(jet);
colormap(axesHandle,flippedColormap);
colorbar(axesHandle, 'Ticks',0:2:20);
 set(axesHandle,'FontName','Times New Roman','FontSize',15,'FontWeight','bold','xminortick','on','yminortick','on')
 %saveas(f,strcat(cd,'\cond_number_map.tif'));
 %print(fig1,strcat(cd,'\cond_number_map.tif'),'-dtiff','-r600')




%fig2 = figure(2);
axesHandle2 = app.UIAxes2;
 %imagesc(b,a,N_eig_sum(11:101,:),'parent',axesHandle2);
 axesPosition2 = get(axesHandle2, 'Position');
resizedData2 = imresize(N_eig_sum(11:101,:), [axesPosition2(3), axesPosition2(4)]);%调整热图数据的大小
imagesc(b, a, resizedData2, 'Parent', axesHandle2);
xlim(axesHandle2, [min(b), max(b)]);
ylim(axesHandle2, [min(a), max(a)]);%设置坐标区的限制
  xticks(axesHandle2,530:20:630);
 yticks(axesHandle2,0.01:0.02:0.100);
 colormap(axesHandle2,"jet")
 colorbar(axesHandle2,'Ticks',0:0.5:8)
 set(axesHandle2,'FontName','Times New Roman','FontSize',15,'FontWeight','bold','xminortick','on','yminortick','on')
%  saveas(gcf,strcat(cd,'\eig_val_map.tif'));
 %print(fig2,strcat(cd,'\eig_val_map.tif'),'-dtiff','-r600')
toc
