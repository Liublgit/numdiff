function U =  circle2(fval,M,N)
%TEST
%fval: (MxN) x1 vector with rhs-value in grid points
%Direction of iteration: First r (from 0 to 1) and then theta (from 0 to
%2pi)
%M: number of interior points in r-direction
%N: number of interior points in theta-direction
%returns value U MxN X 1 in the grid points
h = 1/(M+1); %distance between nodes in r-dir
%Construct A, the sparse diagonal block matrix diag(I,T,I)
r=linspace(h,1-h,M); 
k =2*pi/N; % vektor med k-verdier,
r_values = repmat(r,N,1)';
%k_values = repmat(k,N,1)'; % stabler N vektorer som med r-verdiene
r_val = reshape(r_values,M*N,1);
%k = reshape(k_values,M*N,1); % lagrer stabelen i opprinnelig navn k så vi slipper å endre "A"
e = ones(M*N,1);
f = ones(M*N,1);
f(M:M:N*M) = 0;
g = [1;f(1:end-1)];
A = spdiags([1./(r_val.*k).^2.*e,(1 - 1./r_val)./h^2.*f,-2*(1/h^2 + 1./(r_val.*k).^2).*e, (1 + 1./r_val)./h^2.*g, 1./(r_val.*k).^2.*e],[-M,-1,0,1,M],M*N,M*N);

%dette er en midlertidig og treig m�te � gj�re det p�
for ind = 1:M
    %block corresponding to row j = 1
    A(ind,(N-1)*M+ind) = 1/(k*r(ind))^2;
    %block corresponding to row j = N
    A((N-1)*M+ind, ind) = 1/(k*r(ind))^2;
end
%solve the linear system to find U
U = A\fval;
end