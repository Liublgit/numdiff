function [err_x, err_y] = error(f,analytic)
    n = 100;
    n_points = 8;
    err_x = zeros(2,n_points);
    err_y = zeros(2,n_points);
   
    % Check error/corvergance rate in m-direction
    for p =1:n_points    
        m= 2^p;
        h = 1/(m+1);
        k = 1/(n+1);
        
        x = linspace(h,1-h,m);
        y = linspace(k,1-k,n);
        [X,Y] = meshgrid(x,y);
        
        fval = reshape(f(X,Y),m*n,1);
        u = reshape(analytic(X,Y),m*n,1);
        V = fivepoint(fval,m,n);
        U = fivepoint(V,m,n);
        err_x(2,p) = norm(U-u,2)*sqrt(h*k);
        err_x(1,p) = h;
    end
    
   % Check error/corvergance rate in n-direction

    m = 100;
    for p = 1:n_points
        n= 2^p;
        h = 1/(m+1);
        k = 1/(n+1);
        
        x = linspace(h,1-h,m);
        y = linspace(k,1-k,n);
        [X,Y] = meshgrid(x,y);
        
        fval = reshape(f(X,Y),m*n,1);
        u = reshape(analytic(X,Y),m*n,1);
        V = fivepoint(fval,m,n);
        U = fivepoint(V,m,n);
        
        err_y(2,p) = norm(U-u,2)*sqrt(h*k);
        err_y(1,p) = k;
    end
end