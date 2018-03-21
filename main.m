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
[errorx, errory] = error(f,u_exact);

%% Plot & Business %%
figure(5)
loglog(errorx(1,:), errorx(2,:))
figure(6)
loglog(errory(1,:), errory(2,:))

grid on
xlabel('h/k')
ylabel('2-norm error x-direction')
title('loglog base 10 on x')



