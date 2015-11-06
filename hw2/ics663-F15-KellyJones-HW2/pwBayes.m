%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%helper method to find p(x) using a Bayesian kernel and given parameters
%xIn = the vector considered
%xAll = all the data for a class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  pXD = pwBayes(xIn,xAll,h,sigma,u)
    n = size(xAll,1);
    h = h/sqrt(n);
    %disp(h);
    V = h^size(xIn,2); %just h^d, multidimensional hypercube as volume
    x = bsxfun(@minus,xIn,xAll)/h;%(x-xi)/h
    pXD = 0;
    for i = drange(1:n)
        %disp(i);
        %disp(x(i,:));
        %disp(bayesKernel(x(i,:),sigma,u));
        pXD = pXD + (1/V)*bayesKernel(x(i,:),sigma,u);
    end
    %disp(pXD);
    pXD = pXD/n;
    %disp(pXD);
end