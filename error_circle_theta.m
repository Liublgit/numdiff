function err_theta = error_circle_theta(f,analytic)
    M = 6;
    err_theta = zeros(2,M);
    m = 2^8;
    h = 2/(2*m+1);
    r = linspace(h,1-h,m);
    
   
    % Check error/corvergance rate in r-direction
    for p =1:M    
        n= 2^(p+1);
        k = 2*pi/n;
        theta = k*(0:(n-1));
        [R,THETA] = meshgrid(r,theta);
        F = f(R,THETA)';
        fval = reshape(F,m*n,1);
 
        u = reshape(analytic(R,THETA)',m*n,1);
        
        %use the polar solver to solve the equation
        V = circle(fval,m,n);
        U = circle(V,m,n); 
        %compute the error in 2-norm
        r_values = repmat(r,n,1)';
        r_val = reshape(r_values,n*m,1);
        err_theta(2,p) = norm((U-u).*sqrt(r_val),2)*sqrt(h*k);
        err_theta(1,p) = k;
       
    end
end