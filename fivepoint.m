function U =  fivepoint(fval,M,N)
%fval: MxN x1 vector with rhs-value in grid points
%M: number of interior points in x-direction
%N: number of interior points in y-direction
%returns value U MxN X 1 in the grid points

h = 1/(M+1); %distance between nodes in x-dir
k = 1/(N+1); %distance between nodes in y-dir
%Construct A, the sparse diagonal block matrix diag(I,T,I)
e = ones(M*N,1);
f = ones(M*N,1);
f(M:M:N*M) = 0;
g = [1;f(1:end-1)];
A = spdiags([1/k^2*e,1/h^2*f,-2*(1/h^2 + 1/k^2)*e, 1/h^2*g, 1/k^2*e],[-M,-1,0,1,M],M*N,M*N);
%solve the linear system to find U
U = A\fval;
end