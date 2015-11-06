function gOut = classifier( x,uL,covL,P)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A simple classifier, accepts a list of "trained" paramters and returns a
%3xN matrix of discriminant values for each case, as the rows, and each
%class, as the column.
%Use [score,class] = max(gOut(caseType,:)) to get the class (as 1,..,N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gOut = [1:3;1:3;1:3];%3x3 value output
sigma = 1;%a default value, not sure that it's set
for i=1:size(uL,2)
    %converting the parameters from the input lists for all classes
    u = cell2mat(uL(i));
    cov = cell2mat(covL(i));
    %Case 1
    wi = u/(sigma^2);
    wi0 = ((-1/(sigma^2))*(u'*u))+log(P);
    g = wi'*x'+wi0;
    gOut(1,i) = g;
    %Case 2
    wi = inv(cov)*u;
    wi0 = (-1/2)*(u'*inv(cov)*u)+log(P);
    g = wi'*x'+wi0;
    gOut(2,i) = g;
    %Case 3
    aI = [-1/2,-1/2]*inv(cov);
    bI = u'*inv(cov);
    cI = -(1/2)*(u'*(inv(cov))*u)-(1/2)*log(det(cov))+ log(P);
    g = aI*((x.^2)')+bI*x'+cI;
    gOut(3,i) = g;
end
end

