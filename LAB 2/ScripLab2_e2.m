function backl ()
clear all; close all
to=0; %start time
clc
tf=60; %Z%end time
t=linspace(to,tf ,200);
xo(1)=-20; % initial condition
xo(2)=30;
%u=1;
global fileID
fileID = fopen('datos.txt','w')
options1=odeset('RelTol', 0.01); %La tolerancia para el cálculo del intervalo de tiempo
[t,x] = ode23(@(t,x)nonlinear(t,x),t,xo,options1);

%[T,Y] = ode45(@(t,y) test(t,y,b), tspan, y0); % One comma removed
fclose(fileID);
xlabel('Time (s)')
ylabel('Amplitude')
hold on
plot(t,x(:,1))
plot(t,x(:,2))
legend('x1','x2');
grid


function [xdot] = nonlinear(t,x)
% nonlinear model to integrate with ODE45
% parameters
% deslizante control
global fileID
%
a=1;
k=1;
%u=0;
% backstepping control law
u=(-2 - a*cos(x(1)))*(x(1)+a*sin(x(1))+x(2))-x(1)-k*(x(2)+2*x(1)+a*sin(x(1)));
% model dynamics
xdot=[x(1)+a*sin(x(1))+x(2);u];
fprintf (fileID ,' %10.6f %10.6f %10.6f %10.6f \n',t,u,x(1),x(2));