
Pw = 0.5;
lambR = (1/4);
range1 = [-7:.1:7];
range2 = [-7:.1:7];
pxw1N = normpdf(range,1,1);
pxw2N = normpdf(range,-1,1);
f1 = pxw1N*Pw;
f2 = 1-lambR*(pxw2N*Pw);
figure;
hold on
p1 = plot(range,f1);
p2 = plot(range,f2);
hold off