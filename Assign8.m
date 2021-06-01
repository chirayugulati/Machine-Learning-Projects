S = 50; % Value of the underlying
K = 100; % Strike (exercise price)
r = 0.01; % Risk free interest rate
sigma = 0.2; % Volatility
T = 1;
Smax=200;

%Initial Grid Condition
M = 50; % No. of asset mesh points
N = 50; % No. of time mesh points
A=americanfinitediffput(K,Smax,r,sigma,M,N,T);
Smesh=0:(Smax/M):Smax;
figure(1);
plot(Smesh,A); %plot of free boundary

%Refining the grid - (multiplying the number of mesh points by 2)
M=100;
N=100;
B=americanfinitediffput(K,Smax,r,sigma,M,N,T);
Smesh=0:(Smax/M):Smax;
figure(2);
plot(Smesh,B);%plot of american put option at t=0 for grid size M=100, N=100

M=200;
N=200;
C=americanfinitediffput(K,Smax,r,sigma,M,N,T);
Smesh=0:(Smax/M):Smax;
figure(3);
plot(Smesh,C);

M=400;
N=400;
D=americanfinitediffput(K,Smax,r,sigma,M,N,T);
Smesh=0:(Smax/M):Smax;
figure(4);
plot(Smesh,D);

M=800;
N=800;
E=americanfinitediffput(K,Smax,r,sigma,M,N,T);
Smesh=0:(Smax/M):Smax;
figure(5);
plot(Smesh,E);


disp('Error Estimates'); 
errorNM100=max(abs(A(1:end)-B(1:2:end)));
disp('Error for N=100; M=100');
disp(errorNM100);

errorNM200=max(abs(B(1:end)-C(1:2:end)));
disp('Error For N=200; M=200');
disp((errorNM200));

errorNM400=max(abs(C(1:end)-D(1:2:end)));
disp('Error for N=400;M=400');
disp((errorNM400));

errorNM800=max(abs(D(1:end)-E(1:2:end)));
disp('Error for N=800; M=800');
disp(errorNM800);

