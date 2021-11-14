function dez ()
clear all; close all
to=0; %start time
tf=60; %%end time
t=linspace(to,tf ,200);
xo(1)=-20; % initial condition
xo(2)=30;
%u=1;
global fileID

fileID = fopen('dez.txt','w')
options1=odeset('RelTol', 0.01); %La tolerancia para el cálculo del intervalo de tiempo
[t,x] = ode23(@(t,x)nonlinear(t,x),t,xo,options1);
fclose(fileID);
hold on
plot(t,x(:,1))
plot(t,x(:,2))
hold on

R=dlmread ('dez.txt');
%
plot (R(:,1),R(:,2));
xlabel('Time (s)');
ylabel('amplitude');
grid

legend('x1','x2','u');
function [xdot] = nonlinear(t,x)
  global fileID
c =1.5;
eta = 1;
w=0.25*pi;
xd=sin(w*t);
xd1=cos(w*t)*w;
xd2=-sin(w*t)*w^2;
lamda=1;

F=0.5*x(2)^2*cos(3*x(1));
k=F+eta;
s=x(2)-xd1+lamda.*(x(1)-xd);
  %ley de control
  u=-(1.5*x(2)^2*cos(3*x(1)))+xd2-lamda*(x(2)-xd1)-k*sign(s);
xdot =[ x(2);c*x(2)^2*cos(3*x(1))+u];%dinamica del sistema
  fprintf (fileID ,' %10.6f %10.6f %10.6f %10.6f \n',t,u,x(1),x(2));