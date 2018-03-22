%% solving the biharmonic eqution by solving the system of two poisson equations
close all
clear 


%% Define function f and corresponding analytic solution for omega = [0,1]x[0,1]

f =@(x,y) sin(2*pi*x).*sin(2*pi*y);
u_exact = @(x,y) sin(2*pi*x).*sin(2*pi*y)/(64*pi^4);

%% 

M = 50; %number of internal nodes in x-dir
N = 50; %number of internal nodes in y-dir
h = 1/(M+1);
k = 1/(N+1);

%construct the matrix fval with f(x,y) in all gridpoints
x = linspace(h,1-h,M);
y = linspace(k,1-k,N);
[X,Y] = meshgrid(x,y);
F = f(X,Y)';%need to take the transpose in order to get it row-wise, since default reshape is by column
%reshape to vector-form, [f(row_1),f(row_2,...,f(row_M)]
fval = reshape(F,M*N,1);

%% Solve with five-point / nine-point stencil %%

% Five point
V =  fivepoint(fval,M,N); 
U = fivepoint(V,M,N);
U_matrix = reshape(U,M,N)';
u_exact_matrix = u_exact(X,Y);

figure(1)
plot3(X,Y,U_matrix,'b*',X,Y,u_exact_matrix,'ro')

figure(2)
plot3(X,Y,U_matrix-u_exact_matrix)

% Nine point 
V = ninepoint(fval,M,N);
U = ninepoint(V,M,N);
U_matrix = reshape(U,M,N)';
u_exact_matrix = u_exact(X,Y);

figure(3)
plot3(X,Y,U_matrix,'b*',X,Y,u_exact_matrix,'ro')


%% Compute solution error in 2-norm, a.f.o. steplength %%
[five, nine] = error_rectangle(f,u_exact);

%% Plot & Business %%
figure(5)
loglog(five(1,:), five(2,:))
grid on
xlabel('h/k')
ylabel('2-norm error x-direction')
title('loglog')

figure(6)
loglog(nine(1,:), nine(2,:))
grid on
xlabel('h/k')
ylabel('2-norm error x-direction')
title('loglog')



%% Define function f and corresponding analytic solution for disk centered in (0,0) with radius 1
u = @(r,theta) r.^4.*(1-r).*sin(3*theta).*cos(pi*r/2).*sin(pi*r);
%for now, we are solving the problem laplacian(u) = f, in order to test the
%circle-fivepoint function
f =@(r,theta) (9/2).*sin(3.*theta).*r.^2.*(-(22/3.*(r-9/11)).*r.*pi.*cos((1/2)*pi.*r).^3+sin((1/2)*pi.*r).*(pi^2.*r.^3-pi^2.*r.^2-(64/9).*r+28/9).*cos((1/2).*pi.*r).^2+ (44/9.*(r-9/11)).*r*pi.*cos((1/2)*pi.*r)-(2/9).*r.^2*pi^2.*sin((1/2)*pi.*r).*(r-1));



