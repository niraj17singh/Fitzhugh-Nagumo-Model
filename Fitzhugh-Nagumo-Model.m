%------------------------------------------------------------------------%
% Assignment 2
% FitzHugh-Nagumo neuron model
% Getting the Phase Graph
%------------------------------------------------------------------------%
r=0.1;
b=0.1;
a=0.5;
Iext=0.0;
i = 1;
wtemp = linspace(-0.2,0.2);
vtemp= linspace(-0.2,1.2);

vnew=wtemp.*r/b;
wnew=vtemp.*(a-vtemp).*(vtemp-1)+Iext;

figure(1);
plot(vnew, wtemp);
hold on
plot(vtemp, wnew)


%------------------------------------------------------------------------%
% Finding phase plot at Iext == 0 
%------------------------------------------------------------------------%

v=zeros(1000,1);
w=zeros(1000,1);
t=zeros(1000,1);

v(1)=0.6;
%v(1)=0.6; % Use this value to get the plot at v>a (==0.6)
w(1)=0;
t(1)=0;
dt=0.001;

%------------------------------------------------------------------------%
% Forward Euler Method, for solving the ODE
%------------------------------------------------------------------------%
for i=1:500000
    t(i+1)=t(i)+dt;
    v(i+1) = v(i)+ dt*((v(i)*(a-v(i))*(v(i)-1))-w(i)+Iext);
    w(i+1) = w(i)+ dt*(b.*v(i)-r*w(i));
end

% Getting the phase plot

figure(1);
plot(vnew, wtemp);
hold on
plot(vtemp, wnew)
hold on
plot(v,w,'b')
legend('Trajectory','v-nullcline','w-nullcline')
title('Phase Plot SuperImposed')
xlabel('V')
ylabel('W')
x1=1.3
y2=-0.1
txt1 = 'V = 0.4'; % text1 = 'V = 0.6', for v = 0.6
txt2 = 'W = 0.0';
txt3 = 'Iext = 0.834';
txt4 = 'Iext > I2'
text(x1,y2,txt1)
text(x1,y2+0.04,txt2)
text(x1,y2+0.08,txt3)
text(x1, y2+0.12, txt4)

% plotting V vs t and W vs t

figure(2);
plot(t,v)
hold on
plot(t,w)
legend('V','W','Trajectory')
title('Voltage(V) and W vs Time')
xlabel('Time')
ylabel('V or W')
x1=22
y1=-0.2
y2=-0.18
text(x1,y1,txt1)
text(x1,y2,txt2)
Iext