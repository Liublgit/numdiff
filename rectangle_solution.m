%% solving the biharmonic eqution by solving the system of two poisson equations
f =@(x,y) sin(2*pi*x).*cos(2*pi*x);
M = 2; %number of internal nodes in x-dir
N = 3; %number of internal nodes in y-dir
h = 1/(M+1);
k = 1/(M+1);
%eq 1: solve grad^2 v = f


%construct the matrix fval with f(x,y) in all gridpoints

x = linspace(h,1-h,M);
y = linspace(k,1-k,N);
[X,Y] = meshgrid(x,y);







