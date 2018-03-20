function [err_x, err_y] = error(f,analytic)
    n = 300;
    
    err_x = zeros(2,8);
    err_y = zeros(2,8);
    
   
    % Check error/corvergance rate in m-direction
    for p =1:8    
        m= 2^p;
        h = 1/(m+1);
        k = 1/(n+1);
        
        x = linspace(h,1-h,m);
        y = linspace(k,1-k,n);
        [X,Y] = meshgrid(x,y);
        
        fval = reshape(f(X,Y),m*n,1);
        u = reshape(analytic(X,Y),m*n,1);
        U = fivepoint(fval,m,n);
        err_x(2,p) = norm(U-u,2)*sqrt(h*k);
        err_x(1,p) = h;
    end
    
   % Check error/corvergance rate in m-direction

    m = 200;
    for p = 1:8
        n= 2^p;
        h = 1/(m+1);
        k = 1/(n+1);
        
        x = linspace(h,1-h,m);
        y = linspace(k,1-k,n);
        [X,Y] = meshgrid(x,y);
        
        fval = reshape(f(X,Y),m*n,1);
        u = reshape(analytic(X,Y),m*n,1);
        U = fivepoint(fval,m,n);
        err_y(2,p) = norm(U-u,2)*sqrt(h*k);
        err_y(1,p) = k;
    end
end