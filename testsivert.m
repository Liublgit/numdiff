M=100;
N=M;
e=ones(M*N,1);
f=ones(M*N,1);
f(M:M:N*M)=0;
g=[1;f(1:end-1)];
A = spdiags([1/k^2*e, 1/h^2*f, -2*(1/h^2+1/k^2)*e, 1/h^2*g, 1/k^2*e],[-M,-1,0,1,M],M*N,M*N);