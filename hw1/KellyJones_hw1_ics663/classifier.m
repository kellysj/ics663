function gOut = classifier( x,uL,covL,P)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
gOut = [1:3;1:3;1:3];
sigma = 1;

for i=1:size(uL)
    u = uL(i);
    cov = covL(i);
    wi = u/(sigma^2);
    wi0 = ((-1/(sigma^2))*(u'*u))+log(P);
    g = wi'*x'+wi0;
    gOut(1,i) = g;

    wi = inv(cov)*u;
    wi0 = (-1/2)*(u'*inv(cov)*u)+log(P);
    g = wi'*x'+wi0;
    gOut(2,i) = g;

    aI = [-1/2,-1/2]*inv(cov);
    bI = u'*inv(cov);
    cI = -(1/2)*(u'*(inv(cov))*u)-(1/2)*log(det(cov))+ log(P);
    disp(aI);
    disp(bI);
    disp(cI);
    g = aI*((x.^2)')+bI*x'+cI;
    gOut(3,i) = g;
end
end

