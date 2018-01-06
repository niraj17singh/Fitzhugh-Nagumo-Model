%------------------------------------------------------------------------%
% Assignment 2
% FitzHugh-Nagumo neuron model
% Getting I1 and I2
%------------------------------------------------------------------------%

%------------------------------------------------------------------------%
% Finding phase plot at Iext == 0 
%------------------------------------------------------------------------%
k=1
delta = 0.001
for Iext = 0:delta:1;
r=0.1;
b=0.1;
a=0.5;
niter=5000;
dt = 0.001;

v(1)=0.6;
w(1)=0;
t(1)=0;
dt=0.001;

% Forward Euler method
for i=1:500000
    t(i+1)=t(i)+dt;
    v(i+1) = v(i)+ dt*((v(i)*(a-v(i))*(v(i)-1))-w(i)+Iext);
    w(i+1) = w(i)+ dt*(b.*v(i)-r*w(i));
end

peaks = zeros;
j=1;
total_peaks=zeros;      % Defining a variable for total number of peaks
peaks=findpeaks(v);
if peaks ~=0
    for a=2:length(peaks)-1     % Running a loop to identify APs  
        if peaks(a) >=0.5       % min value for a waveform to considered an AP.
            total_peaks(j)=peaks(a);
            j=j+1;
        end;
    end
end;

if total_peaks ~= 0       % Selecting peaks with non zero value
        num_of_peaks(k)=length(total_peaks);
else
        num_of_peaks(k)=0;
end;
k = k+1
end

%------------------------------------------------------------------------%
% Running loop to find oscillations
%------------------------------------------------------------------------%


for l=2:length(num_of_peaks)                     % Defining I1, I2 
if num_of_peaks(l)>20 && num_of_peaks(l)>num_of_peaks(l-1) && num_of_peaks(l)<22    
         I1=(l)*delta;
end;
if num_of_peaks(l)>20 && num_of_peaks(l)<num_of_peaks(l-1) && num_of_peaks(l)<22
         I2=(l)*delta;
end;
end;

%------------------------------------------------------------------------%
% Plotting the curve
%------------------------------------------------------------------------%
%k=1
figure(4);
x=0:delta:1;                                              % x coordinate
plot(x,num_of_peaks*1000/(niter/100));
xlabel('I_{Ext}');
ylabel('Firing Rate')
hold on;
plot([I1,I1],[0,500])
hold on
plot([I2,I2],[0,500])
text(I1,-10,'I1');
text(I2,-10,'I2');



