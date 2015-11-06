function [aX,aY,bX,bY,c] = getDecisionBoundryC3(pos,neg)
%This function generates coefficients for plotting a case 3 decision
%boundry between 2 classes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%computing covariances, there is a function that round near 0 values to 0
%to prevent the function from exploding with close to 0 covariences
covI = noZ(cov(pos));
covA = noZ(cov(neg));
%computing the means
uI=mean(pos)';
uA=mean(neg)';

%computing prior probabilities, this is a 2 class boundry based on training
%positive and negative data specific to that class so p(w) is usually .5
PI= size(pos,1)/(size(pos,1)+size(neg,1));
PA= size(neg,1)/(size(pos,1)+size(neg,1));
%computing training coefficients
aI = [-1/2,-1/2]*inv(covI);
bI = uI'*inv(covI);
cI = -(1/2)*(uI'*(inv(covI))*uI)-(1/2)*log(det(covI))+ log(PI);
%computing holdout coefficients
aA = [-1/2,-1/2]*inv(covA);
bA = uA'*inv(covA);
cA = -(1/2)*(uA'*(inv(covA))*uA)-(1/2)*log(det(covA))+ log(PA);

%Calculating per dimension coefficients
%function is of the form:
%aX*(x^2)+aY*(y^2)+bX*x+bY*y+c=0
aX = aI(1)-aA(1);
aY = aI(2)-aA(2);
bX = bI(1)-bA(1);
bY = bI(2)-bA(2);
c = cI-cA;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function M = noZ(M)
%Helper function to prevent boundry explosions with close to 0 values
for i = 1:size(M,1)
   for j = 1:size(M,2)
       if(M(i,j)<=0.1)
           M(i,j) = 0;
       end
   end
end
end
