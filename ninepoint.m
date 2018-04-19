function U =  ninepoint(fval,M)
%fval: MxN x1 vector with rhs-value in grid points
%M = N: number of interior points in x-direction and y-direction
%returns value U MxN X 1 in the grid points
N=M;
h = 1/(M+1); %distance between nodes in x-dir
%k = 1/(N+1); %distance between nodes in y-dir
%Construct A, the sparse diagonal block matrix diag(I,T,I)

e = ones(M*N,1);
f = ones(M*N,1);
f(M:M:N*M) = 0;
g = [1;f(1:end-1)];
t = [0;g(2:end)];
A = spdiags([f,4*e,t,4*f, -20*e, 4*g, f ,4*e,g],[-M-1,-M,-M+1,-1,0,1,M-1,M,M+1],M*N,M*N)/6;
F = spdiags([e,f,8*e,g,e],[-M,-1,0,1,M],M*N,M*N)*(h^2)/12;
fval = F*fval;

%solve the linear system to find U
U = A\fval;
end