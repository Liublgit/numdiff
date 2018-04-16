function [err_five, err_nine] = error_rectangle(f,analytic)
    
    M = 8;
    err_five = zeros(2,M);
    err_nine = zeros(2,M);
   
    % Check error/corvergance rate in x/y
    for p =1:M    
        m= 2^p;
        n = m; % shrink steplength x/y simultanously
        h = 1/(m+1);
        x = linspace(h,1-h,m);
        
        [X,Y] = meshgrid(x,x); 
        
        fval = reshape(f(X,Y)',m*n,1);
        u = reshape(analytic(X,Y)',m*n,1);
        V = fivepoint(fval,m,n);
        U = fivepoint(V,m,n);
        err_five(2,p) = norm(U-u,2)*sqrt(h^2);
        err_five(1,p) = h;
        
        V = ninepoint(fval,m);%m=n
        U = ninepoint(V,m);%m=n
        err_nine(2,p) = norm(U-u,2)*sqrt(h^2);
        err_nine(1,p) = h;
    end
end