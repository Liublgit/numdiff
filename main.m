%% solving the biharmonic eqution by solving the system of two poisson equations
close all
clear 

circle = 1;
if ~circle


%% Define function f and corresponding analytic solution for omega = [0,1]x[0,1]
%test
%f =@(x,y) sin(2*pi*x).*sin(2*pi*y);
%u_exact = @(x,y) sin(2*pi*x).*sin(2*pi*y)/(64*pi^4);

%new
f =@(x,y) sin(pi*x).*sin(pi*y)*4*pi^4;
u_exact = @(x,y) sin(pi*x).*sin(pi*y);




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
%vil ha loglog til five og nine i samme plot
five_log =loglog(five(1,:), five(2,:),'-bo');
hold on
nine_log =loglog(nine(1,:), nine(2,:),'-ro');
five_h =loglog(five(1,:),.4*five(1,:).^2,'b--');
nine_h = loglog(nine(1,:),.12*nine(1,:).^4,'r--');
legend([five_log,nine_log,five_h,nine_h],"5-point","9-point", "O(h^2)","O(h^4)")
xlabel('h/k')
ylabel('2-norm error')

else
%% Define function f and corresponding analytic solution for disk centered in (0,0) with radius 1
u = @(r,theta) r.^4.*(1-r).*sin(3*theta).*cos(pi*r/2).*sin(pi*r);
f =@(r,theta) -(81/8).*sin(3*theta).*(-(44/3).*r.*pi.*(r.^2.*(r-9/11).*pi^2-(42/11).*r+70/99).*cos((1/2)*pi.*r).^3+(560/81+r.^4.*(r-1).*pi^4+(-(524/9).*r.^3+(308/9).*r.^2)*pi^2).*sin((1/2)*pi.*r).*cos((1/2)*pi.*r).^2+(880/81*(r.^2.*(r-9/11).*pi^2-(189/55).*r+7/11)).*r*pi.*cos((1/2).*pi.*r)-(20/81).*r.^2*pi^2.*(r.^2.*(r-1)*pi^2-(262/5).*r+154/5).*sin((1/2)*pi.*r));
%% 

%% Solve using a circular grid

M = 50; %number of internal nodes in r-dir
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
V =  circle2(fval,M,N);
%U = V;
%eq 2: solve grad^2 u = v
U = circle2(V,M,N);

U_matrix = reshape(U,M,N)';
%m� finne korresponderende x og y-verdier
X =R.*cos(THETA);
Y = R.*sin(THETA);
figure(2)
plot3(X,Y,U_matrix,'b*',X,Y,u(R,THETA),'r*') %just for comparing the solutions visually




figure(3)
surf(X,Y,U_matrix)
figure(4)
surf(X,Y,u(R,THETA))









err_r =error_circle(f,u);
figure(1)
loglog(err_r(1,:),err_r(2,:),'o-')
hold on
loglog(err_r(1,:),err_r(1,:).^2,'--')


end