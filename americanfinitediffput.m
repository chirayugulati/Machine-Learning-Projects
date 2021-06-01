function f= americanfinitediffput(K,Smax,r,sigma,M,N,T)
clc;

dt=T/N; % time step
dS=Smax/M; % asset step
Szero = 0;

mesh=zeros(N+1,M+1); % Create Mesh
Smesh=0:(Smax/M):Smax; % Mesh of S values
Tmesh=T:-(T/N):0; % Mesh of T values

mesh(1,:)= max(K-Smesh,0); % Payoff Boundary Condition 
mesh(:,1)= K*exp(-r*(T-Tmesh)); % at S=0
mesh(:,M+1)= 0; % S=M

% Calculating a, b and c from the formulae as given in lecture slides
a = @(i) 0.5*dt*(r*i-sigma^2*i^2);
b = @(i) 1 + (sigma^2*i^2 + r)*dt; 
c = @(i) -0.5*dt*(sigma^2*i^2+r*i);

% Tridiagonal Matrix
avalues = zeros(M+1,1);
bvalues = zeros(M+1,1);
cvalues = zeros(M+1,1);

for i = 1:M+1
avalues(i) = a(i-1);
bvalues(i) = b(i-1);
cvalues(i) = c(i-1);
end

Tri=diag(avalues(3:M),-1)+diag(bvalues(2:M))+diag(cvalues(2:M-1),+1);

for i = 1:N
mat_B=mesh(i,2:M);
mat_B(2)=mat_B(2)-avalues(1)*K;
  AS=linsolve(Tri,transpose(mat_B));

  AS=max(AS,K*ones(M-1,1)-transpose(Smesh(2:M)));
mesh(i+1,2:M)=transpose(AS);


end

f=mesh(N+1,:);
return


