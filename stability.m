
maxM = 100;
%Demonstrating stability for five-point:
norm_five = zeros(1, maxM);
for M = 1:maxM
    N = M;
    h = 1/(M+1); %distance between nodes in x-dir
    k = 1/(N+1); %distance between nodes in y-dir
    e = ones(M*N,1);
    f = ones(M*N,1);
    f(M:M:N*M) = 0;
    g = [1;f(1:end-1)];
    A = spdiags([1/k^2*e,1/h^2*f,-2*(1/h^2 + 1/k^2)*e, 1/h^2*g, 1/k^2*e],[-M,-1,0,1,M],M*N,M*N);
    norm_five(M) = max(sum(abs(inv(A)), 2));
end
%plot(1:maxM, norm_five)

%%
%%Nine point:
norm_nine = zeros(1, M);
for M = 95:maxM
    N = M
    h = 1/(M+1); %distance between nodes in x-dir
    k = 1/(N+1); %distance between nodes in y-dir
    e = ones(M*N,1);
    f = ones(M*N,1);
    f(M:M:N*M) = 0;
    g = [1;f(1:end-1)];
    t = [0;g(2:end)];
    A = spdiags([f,4*e,t,4*f, -20*e, 4*g, f ,4*e,g],[-M-1,-M,-M+1,-1,0,1,M-1,M,M+1],M*N,M*N)/(6*h^2);
    norm_nine(M) = max(sum(abs(inv(A)), 2));
end
%%
figure(1)
plot_five = plot(1:maxM, norm_five);
hold on;
plot_nine = plot(1:maxM, norm_nine);
legend([plot_five,plot_nine],"5-point","9-point", 'Location', 'southeast')
xlabel("$M$", 'Interpreter', 'Latex')
ylabel("$\left\| A_h^{-1}\right\|_\infty$", 'Interpreter', 'Latex')
grid on;
pos = get(gca, 'Position');
pos(1) = 0.16;
pos(3) = 0.80;
pos(2) = 0.14;
pos(4) = 0.84;
set(gca, 'Position', pos)
fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'norm59','-dpdf');
%%
%%Circular:
norm_circ = zeros(1, M);
for M = 1:maxM
    N = M
    h = 2/(2*M+1);
    k =2*pi/N;
    r_num = (1:M)-1/2;
    lam = 1./(2*(r_num));
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
    A = spdiags([1./(r_val.*k).^2.*e,1./(r_val.*k).^2.*e,(1 - lam_val_l).*f,(-2 -2./(r_val.*k).^2).*e, (1 + lam_val_r).*g, 1./(r_val.*k).^2.*e,1./(r_val.*k).^2.*e ],[-(N-1)*M,-M,-1,0,1,M,(N-1)*M],N*M,N*M)/h^2;
    norm_circ(M) = max(sum(abs(inv(A)), 2));
end
%%
figure(2)
plot_circ = plot(1:maxM, norm_circ);
%hold on;
%plot_upper = plot(1:maxM, 0.25*ones(1, maxM));
%leg2 = legend([plot_circ,plot_upper],"5-point scheme on circular domain","$\left\| A_h^{-1}\right\|_\infty=1/4$", 'Location', 'southeast');
%set(leg2, 'Interpreter', 'latex');
xlabel("$M$", 'Interpreter', 'Latex');
ylabel("$\left\| A_h^{-1}\right\|_\infty$", 'Interpreter', 'Latex');
axis([0 50 0.22 0.252]);
grid on;
pos = get(gca, 'Position');
pos(1) = 0.16;
pos(3) = 0.80;
pos(2) = 0.14;
pos(4) = 0.84;
set(gca, 'Position', pos)
fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'normcirc','-dpdf');
%%
