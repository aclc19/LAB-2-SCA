close all; clear all; clc
R=dlmread ('datos.txt');
plot (R(:,1),R(:,2),R(:,1),R(:,3),R(:,1),R(:,4));
xlabel('Time (s)');
ylabel('amplitude');
legend('u','x1','x2'); 
grid
