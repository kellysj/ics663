function out = bayesKernel(x,sigma,u)
    out = ((sqrt(2*pi*det(sigma)))^-1)*exp(-((x-u)*(2*sigma)^-1*(x-u)'));
end