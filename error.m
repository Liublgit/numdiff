function [err_x, err_y] = error(f,solver,analytic)
    n = 120;
    err_x = zeros(2,8);
    err_y = zeros(2,8);
    
    % Check error/corvergance rate in m-direction
    for p =1:8    
        m= 2^p;
        h = 1/(m+1);
        k = 1/(n+1);
        U = solver(f,m,n);
        u = analytic(m,n);
        err_x(1,p-1) = norm(u-U,2)*np.sqrt(h*k);
        err_x(0,p-1) = h;
    end
    
   % Check error/corvergance rate in m-direction

    m = 120;
    for p = 1:8
        n= 2^p;
        h = 1/(m+1);
        k = 1/(n+1);
        U = solver(f,m,n);
        u = analytic(m,n);
        err_y(1,p-1) = norm(u-U,2)*np.sqrt(h*k);
        err_y(0,p-1) = k;
    end
end