function U = five_point_formula_inspo(M,N)
h = 1/(M+1);
k = 1/(N+1);
%Construct A
e = ones(M*N,1);
f = ones(M*N,1);
f(M:M:N*M) = 0;
g = [1;f(1:end-1)];
A = spdiags([1/k^2*e,1/h^2*f,-2*(1/h^2 + 1/k^2)*e, 1/h^2*g, 1/k^2*e],[-M,-1,0,1,M],M*N,M*N);


x = 0:h:1;
gx1 = sin(pi*x(2:end-1))'; %g(x,1)
F = zeros(M*N,1);
F(M*(N-1)+1:end)=-gx1/k^2; %hvorfor minus? jo, fordi det er flyttet over fra andre siden. husk � dele p� k^2 ogs�!!

Uvec = A\F;
U = reshape(Uvec,M,N)';

end
