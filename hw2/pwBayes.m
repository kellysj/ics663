function  pXD = pwBayes(xIn,xAll,h,sigma,u)
    n = size(xAll,1);
    %h = h/sqrt(n);
    V = h^size(xIn,2); %just h^d, multidimensional hypercube as volume
    x = bsxfun(@minus,xAll,xIn)/h;%(x-xi)/h
    pXD = 0;
    for i = drange(1:n)
        %disp(i);
        %disp(x(i,:));
        pXD = pXD + (1/V)*bayesKernel(x(i,:),sigma,u);
    end
    pXD = pXD/n;
end

function out = bayesKernel(x,sigma,u)
    out = ((sqrt(2*pi*det(sigma)))^-1)*exp(-((x-u)*(2*sigma)^-1*(x-u)'));
end