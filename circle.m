function U =  circle(fval,M,N)
%fval: (MxN) x1 vector with rhs-value in grid points
%Direction of iteration: First r (from 0 to 1) and then theta (from 0 to
%2pi)
%M: number of interior points in r-direction
%N: number of interior points in theta-direction
%returns value U MxN X 1 in the grid points
h = 1/(M+1); %distance between nodes in r-dir
k = 2*pi/N; %distance between nodes in theta-dir
%Construct A, the sparse diagonal block matrix diag(I,T,I)
r=linspace(h,1-h,M); 
r_values = repmat(r,N,1);
r_val = reshape(r_values,M*N,1);
e = ones(M*N,1);
f = ones(M*N,1);
f(M:M:N*M) = 0;
g = [1;f(1:end-1)];
A = spdiags([1./(r_val.*k).^2.*e,(1 - 1./r_val)./h^2.*f,-2*(1/h^2 + 1./(r_val.*k).^2).*e, (1 + 1./r_val)./h^2.*g, 1./(r_val.*k).^2.*e],[-M,-1,0,1,M],M*N,M*N);
r_values = repmat(r,M,1);
r_val = reshape(r_values,M*N,1);


%solve the linear system to find U
U = A\fval;
end