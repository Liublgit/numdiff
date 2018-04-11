function err_r = error_circle(f,analytic)
    %gir det mening å gjøre dette for theta?
    M = 8;
    err_r = zeros(2,M);
    %err_theta = zeros(2,M);
    n = 80;
    k = 2*pi/n;
    theta = k*(0:(n-1));
   
    % Check error/corvergance rate in r-direction
    for p =1:M    
        m= 2^p;
%         h = 1/(m+1);
        h = 2/(2*m+1);
        r = linspace(h,1-h,m);
        [R,THETA] = meshgrid(r,theta);
        F = f(R,THETA)';%need to take the transpose in order to get it row-wise, since default reshape is by column
        %reshape to vector-form, [f(row_1),f(row_2,...,f(row_M)]
        fval = reshape(F,m*n,1);
 
        u = reshape(analytic(R,THETA)',m*n,1);
        
        V = circle(fval,m,n);
        U = circle(V,m,n); %ikke sikker på at korresponderende punkter for u og U treffer nå
        
        %U_matrix = reshape(U,m,n)';
        err_r(2,p) = norm(U-u,2)*sqrt(h^2);
        err_r(1,p) = h;
       
    end
end