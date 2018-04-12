%% solving the biharmonic eqution by solving the system of two poisson equations
close all
clear 

    
    
%% Define function f and corresponding analytic solution for omega = [0,1]x[0,1]
f =@(x,y) sin(pi*x).*sin(pi*y)*4*pi^4;
u_exact = @(x,y) sin(pi*x).*sin(pi*y);

%plot of exact solution
N_points = 1000;
x = linspace(0,1,N_points);
y = linspace(0,1,N_points);
[X,Y]= meshgrid(x,y);
figure(1)
s =surf(X,Y,u_exact(X,Y));
s.EdgeColor = 'None';
xlabel('$x$', 'Interpreter', 'LaTeX', 'Fontsize', 14);
ylabel('$y$', 'Interpreter', 'LaTeX', 'Fontsize', 14);
zlabel('$u(x,y)$', 'Interpreter', 'LaTeX', 'Fontsize', 14);

%% Construct grid

M = 100; %number of internal nodes in x-dir
N = 100; %number of internal nodes in y-dir
h = 1/(M+1);
k = 1/(N+1);
x = linspace(h,1-h,M);
y = linspace(k,1-k,N);
[X,Y] = meshgrid(x,y);

%construct the matrix fval with f(x,y) in all gridpoints
F = f(X,Y)';%need to take the transpose in order to get it row-wise, since default reshape is by column
%reshape to vector-form, [f(row_1),f(row_2,...,f(row_M)]
fval = reshape(F,M*N,1);

%% Solve with five-point / nine-point stencil %%

% Five point
V =  fivepoint(fval,M,N); 
U = fivepoint(V,M,N);
U_matrix = reshape(U,M,N)';
u_exact_matrix = u_exact(X,Y);

% Compare analytical solution with the solution found by fivepoint
figure(2)
subplot(1,2,1)
plot3(X,Y,U_matrix,'b*',X,Y,u_exact_matrix,'ro');
title('5-point method');

% Nine point 
V = ninepoint(fval,M,N);
U = ninepoint(V,M,N);
U_matrix = reshape(U,M,N)';
u_exact_matrix = u_exact(X,Y);

% Compare analytical solution with the solution found by ninepoint
subplot(1,2,2)
plot3(X,Y,U_matrix,'b*',X,Y,u_exact_matrix,'ro');
title('9-point method');

%% Compute solution error in 2-norm, a.f.o. steplength %%
[five, nine] = error_rectangle(f,u_exact);

%make a loglog-plot of the error
figure(3)
five_log =loglog(five(1,:), five(2,:),'-bo');
hold on
nine_log =loglog(nine(1,:), nine(2,:),'-ro');
five_h =loglog(five(1,:),.4*five(1,:).^2,'b--');
nine_h = loglog(nine(1,:),.12*nine(1,:).^4,'r--');
xlabel('$h=k$', 'Interpreter', 'LaTeX', 'Fontsize', 14);
ylabel('$\left\| e_h\right\|_2$','Interpreter', 'LaTeX', 'Fontsize', 14);
legend({'5-point','9-point','$y =  h^2$','$y =  h^4$'},'Interpreter', 'LaTeX', 'Fontsize', 12);
p_five = polyfit(log(five(1,:)),log(five(2,:)),1);
p_nine = polyfit(log(nine(1,:)),log(nine(2,:)),1);
convergence_order_five = p_five(1)
convergence_order_nine = p_nine(1)


%% Define function f and corresponding analytic solution for disk centered in (0,0) with radius 1
u = @(r,theta) r.^4.*(1-r).*sin(3*theta).*cos(pi*r/2).*sin(pi*r);
f =@(r,theta) -(81/8).*sin(3*theta).*(-(44/3).*r.*pi.*(r.^2.*(r-9/11).*pi^2-(42/11).*r+70/99).*cos((1/2)*pi.*r).^3+(560/81+r.^4.*(r-1).*pi^4+(-(524/9).*r.^3+(308/9).*r.^2)*pi^2).*sin((1/2)*pi.*r).*cos((1/2)*pi.*r).^2+(880/81*(r.^2.*(r-9/11).*pi^2-(189/55).*r+7/11)).*r*pi.*cos((1/2).*pi.*r)-(20/81).*r.^2*pi^2.*(r.^2.*(r-1)*pi^2-(262/5).*r+154/5).*sin((1/2)*pi.*r));

% Plot analytical solution
Npoints = 500;
r = linspace(0,1,Npoints);
theta = linspace(0,2*pi,Npoints);
[R,THETA]=meshgrid(r,theta);
figure(4)
s = surf(R.*cos(THETA),R.*sin(THETA),u(R,THETA));

s.EdgeColor = 'None';
xlabel('$x$', 'Interpreter', 'LaTeX', 'Fontsize', 14);
ylabel('$y$', 'Interpreter', 'LaTeX', 'Fontsize', 14);
zlabel('$u(x,y)$', 'Interpreter', 'LaTeX', 'Fontsize', 14);



%% Solve using a circular grid
M = 100; %number of internal nodes in r-dir
N = 100; %number of internal nodes in theta-dir
h = 2/(2*M+1);
k = 2*pi/N;
%construct the matrix fval with f(r,theta) in all gridpoints
r = ((1:M) - 1/2)*h;
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

%find corresponding x- and y-values for plotting
X =R.*cos(THETA);
Y = R.*sin(THETA);
%add theta = 0 to the last row for plotting 
Xp = [X;X(1,:)];
Yp = [Y;Y(1,:)];
Up = [U_matrix;U_matrix(1,:)];
[Rp,THETAp] = meshgrid(r,[theta,theta(1)]); 
%compare the numerical solution visually with the exact solution
figure(5)
subplot(1,2,1)
surf(Xp,Yp,Up);
title('Numerical solution');
subplot(1,2,2);
surf(Xp,Yp,u(Rp,THETAp));
title('Exact solution');


%% Compute solution error in 2-norm, a.f.o. steplength in r-direction %%
err_r =error_circle(f,u);
figure(6)
loglog(err_r(1,:),err_r(2,:),'o-k');
hold on
loglog(err_r(1,:),.7*err_r(1,:).^2,'--b');
xlabel('$h$', 'Interpreter', 'LaTeX', 'Fontsize', 14);
ylabel('$\left\| e_h\right\|_2$','Interpreter', 'LaTeX', 'Fontsize', 14);
legend({'Error','$y =  h^2$'},'Interpreter', 'LaTeX', 'Fontsize', 12);

p_radial = polyfit(log(err_r(1,:)),log(err_r(2,:)),1);
convergence_order_r = p_radial(1)
