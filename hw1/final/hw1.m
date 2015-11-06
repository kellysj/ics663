%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A matlab script to perform the tasks in assignment 1 for ics663
%Learnig about classifiers and decision boundries
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
%loading data into the script
formatSpec = '%f %f';
sizeA = [2 Inf];
testDataF = fopen('hw1_testdata.txt','r');
trainDataF = fopen('hw1_traindata.txt','r');
testData = fscanf(testDataF,formatSpec,sizeA)';
trainData = fscanf(trainDataF,formatSpec,sizeA)';
fclose(trainDataF);
fclose(testDataF);

%Parameters provided by the assignment
u1 = [0;0];
cov1 = [1,0;0,1];
u2 = [3;3];
cov2 = [1,1.6;1.6,4];
u3 = [0;3.5];
cov3 = [2,0;0,1];
sigma = 1;

%Calculated parameters for classifier function
uC1 = mean(trainData(1:100,:))';
uC2 = mean(trainData(101:200,:))';
uC3 = mean(trainData(201:300,:))';
covC1 = cov(trainData(1:100,:));
covC2 = cov(trainData(101:200,:));
covC3 = cov(trainData(201:300,:));
covL = {covC1,covC2,covC3};
uL = {uC1,uC2,uC3};
%%%%%%%%%%%%%%%%%%%%%%%%STARTING CLASSIFICATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Training Classification
    errR1 = 0;
    errR2 = 0;
    errR3 = 0;
    curClass = 0;
data = trainData;
i = 0;
for i = 1:size(data,1)
    if i <= 1+size(data,1)/3
        curClass = 1;
    else
        if i <= 1+2*size(data,1)/3
            curClass = 2;
        else
            curClass = 3;
        end
    end
    %disp(i);
    %disp(curClass);
    scoreMatrix = classifier(data(i,:),uL,covL,.5);
    %Case 1
    [score1,classC1] = max(scoreMatrix(1,:));
    %Case 2
    [score2,classC2] = max(scoreMatrix(2,:));
    %Case 3
    [score3,classC3] = max(scoreMatrix(3,:));
    
    if classC1 ~= curClass
        errR1 = errR1 + 1;
    end
    if classC2 ~= curClass
        errR2 = errR2 + 1;
    end
    if classC3 ~= curClass
        errR3 = errR3 + 1;
    end
end
disp(i);
disp(errR1/i);
disp(errR2/i);
disp(errR3/i);
    errE1 = 0;
    errE2 = 0;
    errE3 = 0;
%Testing Classification
data = testData;
for i = 1:size(data,1)
    if i <= 1+size(data,1)/3
        curClass = 1;
    else
        if i <= 1+2*size(data,1)/3
            curClass = 2;
        else
            curClass = 3;
        end
    end
%     disp(i);
%     disp(curClass);
    scoreMatrix = classifier(data(i,:),uL,covL,.5);
    %Case 1
    [score1,classC1] = max(scoreMatrix(1,:));
    %Case 2
    [score2,classC2] = max(scoreMatrix(2,:));
    %Case 3
    [score3,classC3] = max(scoreMatrix(3,:));
    
    if classC1 ~= curClass
        errE1 = errE1 + 1;
    end
    if classC2 ~= curClass
        errE2 = errE2 + 1;
    end
    if classC3 ~= curClass
        errE3 = errE3 + 1;
    end
end
disp(i)
disp(errE1/i);
disp(errE2/i);
disp(errE3/i);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%STARTING PLOTS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plots are made based on 2 class decision boundries plotted simultaneously
%Lines are only plotted to the intercept for better accuracy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Case 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms y x;%symbolic variables for matlab's plot function
figure('Name','Case 1')
%setting up dimensions of the plots based on training data values
xMax = 6;
yMax = 7;
xMin = -4;
yMin = -3;
axis([xMin xMax yMin yMax]);
hold on;
%adding scatter plots and formatting to the figure for the case
s1 = scatter(trainData(1:100,1),trainData(1:100,2),8,'green','d');
s2 = scatter(trainData(101:200,1),trainData(101:200,2),8,'red','d');
s3 = scatter(trainData(201:300,1),trainData(201:300,2),8,'blue','d');
a1 = plot(u1(1),u1(2),'*','Color','green');
a2 = plot(u2(1),u2(2),'*','Color','red');
a3 = plot(u3(1),u3(2),'*','Color','blue');
%calculating and plotting the decision boundries
[a,b,c] = getDecisionBoundryC1(u2,u1,.5,.5,1);%between class 1 and 2
p12 = ezplot(subs('a*x+b*y-c'),[xMin,xMax,yMin,1.75]);
[aT,bT,cT] = getDecisionBoundryC1(u1,u3,.5,.5,1); %between class 1 and 2
line('XData',[xMin 1.25],'YData',[cT/bT cT/bT]);
[a,b,c] = getDecisionBoundryC1(u2,u3,.5,.5,1);%between class 3 and 2
p32 = ezplot(subs('a*x+b*y-c'),[xMin,xMax,1.75,yMax]);
set([p12,p32],'Color','black');
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Case 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Case 2')
%setting up dimensions of the plots based on training data values
xMax = 6;
yMax = 7;
xMin = -4;
yMin = -3;
axis([xMin xMax yMin yMax]);
hold on;
%adding scatter plots and formatting to the figure for the case
s1 = scatter(trainData(1:100,1),trainData(1:100,2),8,'green','d');
s2 = scatter(trainData(101:200,1),trainData(101:200,2),8,'red','d');
s3 = scatter(trainData(201:300,1),trainData(201:300,2),8,'blue','d');
a1 = plot(u1(1),u1(2),'*','Color','green');
a2 = plot(u2(1),u2(2),'*','Color','red');
a3 = plot(u3(1),u3(2),'*','Color','blue');
%calculating and plotting the decision boundries
[a,b,c] = getDecisionBoundryC2(((cov2+cov3+cov1)/3),u2,u1,(1/2),(1/2));%between class 1 and 2
p12 = ezplot(subs('a*x+b*y-c'),[xMin,xMax,yMin,2.2]);
[a,b,c] = getDecisionBoundryC2(((cov2+cov3+cov1)/3),u3,u2,(1/2),(1/2));%between class 3 and 2
p23 = ezplot(subs('a*x+b*y-c'),[xMin,xMax,2.2,yMax]);
[a,b,c] = getDecisionBoundryC2(((cov2+cov3+cov1)/3),u1,u3,(1/2),(1/2));%between class 1 and 3
p31 = ezplot(subs('a*x+b*y-c'),[xMin,1.1,yMin,yMax]);
set([p12,p23,p31],'Color','black');
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Case 3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Case 3')
%setting up dimensions of the plots based on training data values
xMax = 6;
yMax = 7;
xMin = -4;
yMin = -3;
xInt = 1.31;%predetermined intercepts of boundries
yInt = 1.64;
axis([xMin xMax yMin yMax]);
hold on;
%adding scatter plots and formatting to the figure for the case
s1 = scatter(trainData(1:100,1),trainData(1:100,2),8,'green','d');
s2 = scatter(trainData(101:200,1),trainData(101:200,2),8,'red','d');
s3 = scatter(trainData(201:300,1),trainData(201:300,2),8,'blue','d');
u1 = mean(trainData(1:100,:));
u2 = mean(trainData(101:200,:));
u3 = mean(trainData(201:300,:));
a1 = plot(u1(1),u1(2),'*','Color','green');
a2 = plot(u2(1),u2(2),'*','Color','red');
a3 = plot(u3(1),u3(2),'*','Color','blue');
%calculating and plotting the decision boundries
[aX2,aY2,bX2,bY2,c2] = getDecisionBoundryC3(trainData(101:200,:),trainData(201:300,:));%between class 3 and 2
p23 = ezplot(subs('aX2*(x^2)+aY2*(y^2)+bX2*x+bY2*y+c2'),[xMin,xMax,yInt,yMax]);
[aX2,aY2,bX2,bY2,c2] = getDecisionBoundryC3(trainData(101:200,:),trainData(1:100,:));%between class 1 and 2
p21 = ezplot(subs('aX2*(x^2)+aY2*(y^2)+bX2*x+bY2*y+c2'),[xMin,xMax,yMin,yInt]);
[aX3,aY3,bX3,bY3,c3] = getDecisionBoundryC3(trainData(201:300,:),trainData(1:100,:));%between class 1 and 3
p31 = ezplot(subs('aX3*(x^2)+aY3*(y^2)+bX3*x+bY3*y+c3'),[xMin,xInt,yMin,yMax]);
set([p21,p31,p23],'Color','black');
hold off;
