%------------------------------------------------------------------------%
% Assignment 2
% FitzHugh-Nagumo neuron model
% Getting the Phase Graph for Bistability condition
%------------------------------------------------------------------------%
r=0.8;
b=0.01;
a=0.5;
Iext=0.02;
i = 1;

dx=0.0000001;
v1 = -0.2:dx:1.2; 
v2= -0.2:dx:1.2;

w1=v1.*b/r;                   % W-nullcline
w2=v2.*(a-v2).*(v2-1)+Iext;   % V-nullcline



diff = abs(w1-w2);         % Finding the difference between the w values
diff2 = diff';


% Running loop to find the points where both the nullclines intersect
temp = [length(diff-1),1]; 
%lali = min(diff2)

for i= 2:length(diff)-1
    temp(i) = diff(i)<diff(i+1) && diff(i)< diff(i-1);
end
    
intercept = find(temp==1);

% Getting the corrdinates of the point of intersection
iterw1 = w1(intercept(1));
iterw2 = w1(intercept(2));
iterw3 = w1(intercept(3));
iterv1 = v1(intercept(1));
iterv2 = v1(intercept(2));
iterv3 = v1(intercept(3));


% Analysing the trajectory around P2, to check if its a stable, unstable or
% a saddle point

% voltage greater than voltage at P2

v(1)= iterv2+0.01;
w(1)=0;
t(1)=0;
dt=0.001;

for i=1:50000
    t(i+1)=t(i)+dt;
    v(i+1) = v(i)+ dt*((v(i)*(a-v(i))*(v(i)-1))-w(i)+Iext);
    w(i+1) = w(i)+ dt*(b.*v(i)-r*w(i));
end

figure(1)
plot (t,v,...
    t,w)

% Plotting the graphs obtanined
figure(2)
p = plot(v1, w1,'y',...
         v2,w2,'r',...
         v,w,'b',...
         iterv1, iterw1,'ko',...
         iterv2, iterw2,'ko',...
         iterv3, iterw3,'ko');
     hold on

     
% Voltage less than voltage at P2  
v(1)= iterv2-0.01;     
     
for i=1:500000
    t(i+1)=t(i)+dt;
    v(i+1) = v(i)+ dt*((v(i)*(a-v(i))*(v(i)-1))-w(i)+Iext);
    w(i+1) = w(i)+ dt*(b.*v(i)-r*w(i));
end   
   
plot(v,w,'b')
     
     
% Plotting the points P1, P2, P3     
plot (v,w,'b')
x1 = iterv1+0.01; 
y1 = iterw1+0.01;
txt1 = 'P1';
txt1_1 = 'Stable Point';
x2 = iterv2-0.02;
y2 = iterw2+0.01;
txt2 ='P2';
txt2_1 = 'Saddle Point';
x3 = iterv3+0.01;
y3 = iterw3+0.01;
txt3 = 'P3';
txt3_1 = 'Stable Point';

text(x1,y1,txt1)
text(x2,y2,txt2)
text(x3,y3,txt3)
text(x1, y1+0.01, txt1_1)
text(x2, y2+0.01, txt2_1)
text(x3, y3+0.01, txt3_1)

v=zeros(1000,1);
w=zeros(1000,1);
t=zeros(1000,1);

title('Bistability Condition')
legend('v-nullcline','w-nullcline','trajectory')
xlabel('v');
ylabel('w')








