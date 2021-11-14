clear, pack, clc
%parametros del modelo de referencia
am=2
bm=2
% parametros de la planta
a=1
b=0.5 
%  verificacion de convergencia
theta1final=bm/b;
theta2final=(am-a)/b;
%%
function dxdt = dynamics_adaptive(t, x, um, ym, time_um,am,bm,a,b,gamma)

um_interp = interp1(time_um, um, t); % Interpolación
ym_interp = interp1(time_um, ym, t); 

dxdt(1,1)=x(2);
dxdt(2,1)=-am*x(2).^2*cos(3*x(1))+um_interp;
end
am=2
bm=2
% modelo de referencia
pkg load control%cargamos paquete
Wm=tf([bm],[1 am]);
tmax=100 % max time
time=0:0.001:tmax;  %time vector 
% pulso de entrada
pulsew = 10; %pulse width
delayop= pulsew/2:pulsew*2:tmax; %delay vector
% entrada de referencia
pkg load signal
ur=2*pulstran(time,delayop,'rectpuls',pulsew)-1; 
% Señal
yr=lsim(Wm,ur,time)
figure(1)
plot(time,yr,'r')
hold on
plot(time,ur,'k')
legend('sal mod ref','sal mod planta')
axis([0 100 -1.2 1.2])
title('Salida del modelo de referencia y modelo actual ')
