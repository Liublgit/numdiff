f =@(r,theta) 15*(1-r).*(r.*(1-r).^4 - 49*r.*(1-r).^3 + 124.*r.^2.*(1-r).^2 - 72*r.^3.*(1-r) + 8*r.^4).*cos(theta);
u = @(r,theta) r.^4.*(1-r).*sin(3*theta).*cos(pi*r/2).*sin(pi*r);




%test plotting
% M = 4;
% N = 2;
% k = 2*pi/N;
% h = 1/(M+1);
% theta = (0:(N-1))*k;
% r = h:h:1-h;
% [R,THETA] = meshgrid(r,theta);


M = 100; %number of internal nodes in r-dir
N = 100; %number of internal nodes in theta-dir
h = 1/(M+1);
k = 2*pi/N;
%construct the matrix fval with f(r,theta) in all gridpoints
r = linspace(h,1-h,M);
theta = k*(0:(N-1));
[R,THETA] = meshgrid(r,theta);
F = f(R,THETA)';%need to take the transpose in order to get it row-wise, since default reshape is by column
%reshape to vector-form, [f(row_1),f(row_2,...,f(row_M)]
fval = reshape(F,M*N,1);

%eq 1: solve grad^2 v = f
V =  circle(fval,M,N);
%eq 2: solve grad^2 u = v
U = circle(V,M,N);

U_matrix = reshape(U,M,N)';
%må finne korresponderende x og y-verdier
X =R.*cos(THETA);
Y = R.*sin(THETA);

%u_exact_matrix = u_exact(X,Y);
% figure(1)    
% plot3(X,Y,u(R,THETA))%,X,Y,u_exact_matrix,'ro')

figure(2)
plot3(X,Y,U_matrix,'*')