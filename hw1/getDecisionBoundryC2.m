function [a,b,c] = getDecisionBoundryC2(cA,uA,uI,PI,PA)
%A function to calculate coefficients for plotting of the case 2 decision
%boundry, values calculated with supplied variences rather than measured
%variences. In the case that this wasn't the right course of action for
%this assignment, see getDecisionBoundryC3 for a more explicit calculation
%of means and covariences.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X0=(1/2)*(uI+uA)-(1/((uI-uA)'*inv(cA)*(uI-uA)))*(log(PI/PA)*(uI-uA));
W = inv(cA)*(uI-uA);

a = W(1);
b = W(2);
c = a*X0(1)+b*X0(2);
end

