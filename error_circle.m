function err_r = error_circle(f,analytic)
    M = 8;
    err_r = zeros(2,M);
    n = 300;
    k = 2*pi/n;
    theta = k*(0:(n-1));
   
    % Check error/corvergance rate in r-direction
    for p =1:M    
        m= 2^p;
        h = 2/(2*m+1);
        r = linspace(h,1-h,m);
        [R,THETA] = meshgrid(r,theta);
        F = f(R,THETA)';
        fval = reshape(F,m*n,1);
 
        u = reshape(analytic(R,THETA)',m*n,1);
        
        %use the polar solver to solve the equation
        V = circle(fval,m,n);
        U = circle(V,m,n); 
        %compute the error in 2-norm
        err_r(2,p) = norm(U-u,2)*sqrt(h^2);
        err_r(1,p) = h;
       
    end
end