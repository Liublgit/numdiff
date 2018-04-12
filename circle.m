function U =  circle(fval,M,N)
%fval: (NxM) x1 vector with rhs-value in grid points
%Direction of iteration: First r (from 0 to 1) and then theta (counterclockwise)
%M: number of interior points in theta-direction
%N: number of interior points in r-direction
%returns value U NxM x 1 in the grid points

%Construct A, the sparse diagonal block matrix
h = 2/(2*M+1); %distance between nodes in r-dir
r_num = (1:M) - 1/2;
lam = 1./(2*(r_num));
k =2*pi/N; %delta theta
r_values = repmat(r_num,N,1)';
r_val = reshape(r_values,N*M,1);

lam_left = [lam(2:end),1];
lam_right = [1,lam(1:(end-1))];
lam_values_l = repmat(lam_left,N,1)';
lam_val_l = reshape(lam_values_l,N*M,1);
lam_values_r = repmat(lam_right,N,1)';
lam_val_r = reshape(lam_values_r,N*M,1);

e = ones(N*M,1);
f = ones(N*M,1);
f(M:M:M*N) = 0;
g = [1;f(1:end-1)];
A = spdiags([1./(r_val.*k).^2.*e,1./(r_val.*k).^2.*e,(1 - lam_val_l).*f,(-2 -2./(r_val.*k).^2).*e, (1 + lam_val_r).*g, 1./(r_val.*k).^2.*e,1./(r_val.*k).^2.*e ],[-(N-1)*M,-M,-1,0,1,M,(N-1)*M],N*M,N*M);

%solve the linear system to find U
U = A\(fval.*h^2);
end