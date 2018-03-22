clear 
clc
close
%DETTE ER KUN ET TESTE SKRIPT: TING SKAL ETTER HVERT FLYTTES HERFRA TIL
%MAIN
%f =@(r,theta) 15*(1-r).*(3*(1-r).^4 - 49*r.*(1-r).^3 + 124.*r.^2.*(1-r).^2 - 72*r.^3.*(1-r) + 8*r.^4).*cos(theta);

u = @(r,theta) r.^4.*(1-r).*sin(3*theta).*cos(pi*r/2).*sin(pi*r);
% f is the laplacian of u -> can test the circle-function, for
% laplacian(u)=f
f =@(r,theta) (9/2).*sin(3.*theta).*r.^2.*(-(22/3.*(r-9/11)).*r.*pi.*cos((1/2)*pi.*r).^3+sin((1/2)*pi.*r).*(pi^2.*r.^3-pi^2.*r.^2-(64/9).*r+28/9).*cos((1/2).*pi.*r).^2+ (44/9.*(r-9/11)).*r*pi.*cos((1/2)*pi.*r)-(2/9).*r.^2*pi^2.*sin((1/2)*pi.*r).*(r-1));



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
U = V;
%eq 2: solve grad^2 u = v
%U = circle2(V,M,N);

U_matrix = reshape(U,M,N)';
%m� finne korresponderende x og y-verdier
X =R.*cos(THETA);
Y = R.*sin(THETA);

%u_exact_matrix = u_exact(X,Y);
% figure(1)    
% plot3(X,Y,u(R,THETA))%,X,Y,u_exact_matrix,'ro')

figure(2)
plot3(X,Y,U_matrix,'b*',X,Y,u(R,THETA),'r*')
figure(3)
surf(X,Y,U_matrix)
figure(4)
surf(X,Y,u(R,THETA))