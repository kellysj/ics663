function Y = BayesTest(x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
sigma = .5;
u = 0;
Y = ((sqrt(2*pi*det(sigma)))^-1)*exp(-((x-u)*(2*sigma)^-1*(x-u)'));
end

%sigma3=    [0.4371,0,0,0;0,0.1131,0,0;0,0,0.3226,0;0,0,0,0.0913]
%u3 = 6.5880    2.9740    5.5520    2.0260    3.0000