% project_01_script.m
%
% Charlie Lambert and Troy Kaufman
% E102 Spring 2024, Prof. Cha, Tsai, Wu, and Yang
%
% Project 1

clear
clc 
close all

% Define system parameters
g = 9.8;
l = 0.5;
ts = 10;
z = 0.99;
z1 = 0.9;
wn = 4.6/(z*ts);
alpha = 0.5;

% Create system matrix
A = [0 1 0 0; 
     g/l 0 0 0; 
     0 0 0 1; 
     0 0 0 0];
B = [0; 
     -1/l;
     0;
     1];
C = [1 0 0 0;
     0 0 1 0];
D = [0;0];

% Create state space system
sys = ss(A,B,C,D);

% Check stability, controlability, and observatbility
stability = isstable(sys)
poles = eig(A)
rank(ctrb(A,B))
rank(obsv(A,C))

% Observer design
Po = [-10 -50 -80 -100] % Choose poles for observer
L = place(A', C', Po)';
Ao = [A-L*C];
Bo = B;
Co = C;
Do = D;
observer = ss(Ao, Bo, Co, Do);

% Calculating control poles
Pc = [(-z*wn-j*wn*sqrt(1-z^2)) (-z*wn+j*wn*sqrt(1-z^2)) (-z1*wn-j*wn*sqrt(1-z1^2)) (-z1*wn+j*wn*sqrt(1-z1^2)) -20]
Aa = [0 -C(2,:);
      zeros(4,1) A]
Ba = [-D(1,:);
       B];
Ka = place(Aa, Ba, Pc);
Ki = Ka(1)
K = [Ka(2) Ka(3) Ka(4) Ka(5)]
Af = [-D(2,:)*Ki -C(2,:)+D(2,:)*K;
      B*Ki A-B*K];

% Load and run the simulink model
load_system('project_01_model.slx')
simOut = sim('project_01_model.slx', 'SaveOutput', 'on', 'OutputSaveName', 'yout');

% Extract signals
logs = simOut.yout;
theta = logs.get('theta');
theta_time = theta.Values.Time;
theta_data = theta.Values.Data;
s = logs.get('s');
s_time = s.Values.Time;
s_data = s.Values.Data;
a = logs.get('a');
a_time = a.Values.Time;
a_data = a.Values.Data;
step = logs.get('step');
step_time = step.Values.Time;
step_data = step.Values.Data;

% Plot signals
subplot(4, 1, 1)
plot(theta_time, theta_data)
title('Theta')
xlabel('time [s]')
ylabel('theta(t) [radians]')
subplot(4, 1, 2)
plot(s_time, s_data)
title('Cart Position')
xlabel('time [s]')
ylabel('s(t) [m]')
subplot(4, 1, 3)
plot(a_time, a_data)
title('Control Signal')
xlabel('time [s]')
ylabel('a(t) [m?]')
subplot(4, 1, 4)
plot(step_time, step_data)
title('Step Input')
xlabel('time [s]')
ylabel('u(t) [m]')
