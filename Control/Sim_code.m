clc; 
clear variables;
close all;
set(0,'DefaultAxesFontName','Times','DefaultAxesFontSize',12)
set(0,'defaultLineLineWidth',1.5,'defaultLineMarkerSize',8)
%% Pararmeters
% Inertia matrix [kg*m^2]
% Old one
% Params.J = 1e-9 * [[244079928.67,539549.34,5734372.12];...
%                    [539549.34,83010901.99,317734.95];...
%                    [5734372.12,317734.95,215583426.01]];
% New one
Params.J = [[0.27,0.00,-0.01];...
           [0.00,0.10,0.00];...
           [-0.01,0.00,0.24]];
% wheel's inertia [kg*m^2]
Params.Jw = 5.01e-5;

% Controller Gains
% Params.gains.kpx = 6.102e-02; 
% Params.gains.kdx = 1.220e-01;
% Params.gains.kpy = 2.075e-02;
% Params.gains.kdy = 4.151e-02;
% Params.gains.kpz = 5.390e-02;
% Params.gains.kdz = 1.078e-01;

% New gains
% Params.gains.kpx = 1.5621e-3; 
% Params.gains.kdx = 31.2422e-3;
% Params.gains.kpy = 531.278e-6;
% Params.gains.kdy = 10.6254e-3;
% Params.gains.kpz = 1.38e-3;
% Params.gains.kdz = 27.6e-3;

zeta = 1.0;
wn = 0.1;
kp = 2*wn*wn*Params.J(1,1);
kd = 2*zeta*wn*Params.J(1,1);
Params.gains.kpx = kp;
Params.gains.kdx = kd;
Params.gains.kpy = kp;
Params.gains.kdy = kd;
Params.gains.kpz = kp;
Params.gains.kdz = kd;



% eul_0 = [-45,30,-10];
% quat_0 = eul2quat(deg2rad(eul_0));
% Params.q0 = [quat_0(2),quat_0(3),quat_0(4),quat_0(1)]';
% Params.w0 = [0.5300,0.5300,0.0530]';        %[deg/sec]
% 
Params.w0 = [0.53,0.53,0.053]';   

% Initial conditions
Params.q0 = [0,0,0,1]';
Params.w0 = [0,0,0]'; %[deg/sec]
Params.w0_W = 0*[1,1,1,1]';

% Target conditions
Params.q_T = [0.1767767,0.3061862,0.1767767,0.9185587]';
% Params.q_T = [0,0,0,1]';



% Wheel configuration
i_W = 2;

if (i_W == 1)
    aux = 1/sqrt(3);
    Params.W1 = aux * [1;-1;1];
    Params.W2 = aux * [-1;1;1];
    Params.W3 = aux * [-1;-1;1];
    Params.W4 = aux * [1;1;1];
elseif (i_W == 2)
    aux = 1/sqrt(3);
    Params.W1 = [1;0;0];
    Params.W2 = [0;1;0];
    Params.W3 = [0;0;1];
    Params.W4 = aux * [1;1;1];
elseif (i_W == 3)
    aux = 1/3;
    Params.W1 =  [0;0;-1];
    Params.W2 =  aux * [0;-2*sqrt(2);1];
    Params.W3 =  aux * [sqrt(6);sqrt(2);1];
    Params.W4 =  aux * [-sqrt(6);sqrt(2);1];
end
Params.W = [Params.W1,Params.W2,Params.W3,Params.W4];
Params.Winv = pinv(Params.W);

Params.torquebox = load('torquebox_modified.mat');

Params.tf = 400; %[sec]
% Params.dt = 1e-2; %[sec]
% Wheels limits 
H_lim = 0.03; %[Nms]
T_lim = 2e-3; %[Nm]
ss_eul = 30;

%% Simulate and extract the data
Outsim = sim('Oren_Sim');
Data = Outsim.Data.signals.values(:,:,:);
Data = reshape(Data,[26 length(Data)]);
q_t = Data(1:4,:);
w_t = Data(5:7,:);
q_error = Data(8:11,:);
w_error = Data(12:14,:);
Tc = Data(15:18,:);
TW = Data(19:22,:);
HW = Data(23:26,:);
t = Outsim.tout;

%% Plotting the data 
% Angular velocity 
w_t = rad2deg(w_t);
figure,
subplot(2,1,1)
plot(t,w_t);
hold on
plot([0 Params.tf],[-0.02,-0.02],'k--','LineWidth',1.00);
plot([0 Params.tf],[0.02,0.02],'k--','LineWidth',1.00);
ylabel('\omega(t) [deg/sec]');
grid on 
legend('P','Q','R');
title('Angular velocity');
xlabel('t[sec]');

% Euler angles
% eul = quat2eul(flip(q_t)');
eul = quat2eul([q_t(4,:)',q_t(1,:)',q_t(2,:)',q_t(3,:)']);
eul = rad2deg((eul));
% % figure,
subplot(2,1,2)
plot(t,fliplr(eul))
hold on
plot([0 Params.tf],[ss_eul,ss_eul]*0.98,'k--','LineWidth',1.00);
plot([0 Params.tf],[ss_eul,ss_eul]*1.02,'k--','LineWidth',1.00);
ylabel('eul(t) [deg]');
grid on 
legend('\phi','\theta','\psi');
title('Euler angles');
xlabel('t[sec]');

% subplot(2,1,2)
% plot(t,q_t)
% xlabel('t');
% ylabel('q(t)');
% grid on 
% legend('q1','q2','q3','q4');

% Wheels torque
figure,
subplot(2,1,1)
plot(t,TW); 
hold on;
% plot(t,Tc,'--');
plot([0,t(end)],T_lim*ones(1,2),'--r');
plot([0,t(end)],-T_lim*ones(1,2),'--r');
xlabel('t[sec]');
ylabel('Wheels torque [Nm]');
lgd = legend('RW 1 A','RW 2 A','RW 3 A','RW 4 A');
% ,'RW 1 C','RW 2 C','RW 3 C','RW 4 C');
lgd.NumColumns = 2;
grid on
title('Wheels torque');

subplot(2,1,2)
plot(t,HW);
hold on;
plot([0,t(end)],H_lim*ones(1,2),'--r');
plot([0,t(end)],-H_lim*ones(1,2),'--r');
xlabel('t[sec]');
ylabel('Wheels angular momentum [Nms]');
legend('RW 1','RW 2','RW 3','RW 4');
grid on
title('Wheels angular momentum');

% quaternion error
figure,
plot(t,q_error)
hold on
plot([0 Params.tf],[-0.02,-0.02],'k--','LineWidth',1.00);
plot([0 Params.tf],[0.02,0.02],'k--','LineWidth',1.00);
plot([0,Params.tf],[0.98,0.98],'k--','LineWidth',1.00);
plot([0 Params.tf],[1.02,1.02],'k--','LineWidth',1.00);
xlabel('t[sec]');
ylabel('\delta q');
legend('\delta q_1','\delta q_2','\delta q_3','\delta q_4');
grid on
title('Quaternion error');

% angle error
angle_error = 2*atan2d(sqrt(q_error(1,:).^2+q_error(2,:).^2+q_error(3,:).^2),q_error(4,:));
figure,
plot(t,angle_error);
xlabel('t[sec]');
ylabel('\phi_{error}[deg]');
grid on
%% 
% TBD = load('torquebox.mat');
% TBD = TBD.torquebox;
% H = TBD(:,2);
% T = TBD(:,3);
% 
% figure,
% plot(H,T)
% grid on 
% xlabel('H [Nm-sec]');
% ylabel('T [Nm]');
% 
% x = [H(698),H(686)];
% v = [T(698),T(686)];
% xq = linspace(H(698),H(686),13);
% vq = interp1(x,v,xq);
% 
% H(686:698) = flip(xq);
% T(686:698) = flip(vq);
% 
% x = [H(115),H(1225)];
% v = [T(115),T(1225)];
% xq = linspace(x(1),x(2),10);
% vq = interp1(x,v,xq);
% 
% H(106:115) = flip(xq);
% T(106:115) = flip(vq);
% 
% H = H(106:1225);
% T = T(106:1225);
% 
% 
% x1 = flip([H(488),H(1029)]);
% v1 = flip([T(488),T(1029)]);
% xq1 = linspace(x1(1),x1(2),100);
% vq1 = interp1(x1,v1,xq1);
% 
% 
% x2 = [H(464),H(1033)];
% v2 = [T(464),T(1033)];
% xq2 = linspace(x2(1),x2(2),100);
% vq2 = interp1(x2,v2,xq2);
% 
% x3 = [H(1029),H(464)];
% v3 = [T(1029),T(464)];
% xq3 = linspace(x3(1),x3(2),100);
% vq3 = interp1(x3,v3,xq3);
% 
% H_new = [xq1,xq2,xq1(1)];
% T_new = [vq1,vq2,vq1(1)];
% 
% 
% 
% 
% 
% 
% figure,
% plot(H_new,T_new)
% grid on 
% xlabel('H [Nm-sec]');
% ylabel('T [Nm]');
% 
% 
% torquebox_modified = [TBD(1:201,1),H_new',T_new'];
