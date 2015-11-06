
%A script to run and compile the error rates as well as loading the data
%by class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%reading in the data
[a,b,c,d,class] = textread('iris.txt','%f,%f,%f,%f,%d');
data = [a,b,c,d,class];
c1 = data(find(data(:,5)==1),:);
c2 = data(find(data(:,5)==2),:);
c3 = data(find(data(:,5)==3),:);

nT = 33;%number for training, shouldn't exceed total class count
h = [.01;.5;10];%parzen window widths

nItter = 15;%number of itterations

accumError = zeros(nItter,size(h,1));%an array to accumulate errors

for i=1:nItter
    accumError(i,:) = pwBTrainTest(c1,c2,c3,nT,h);
end

%compiling and calculating the total errors,their means and variences
totalError = accumError;
errMean = mean(accumError);
errVar = var(accumError);
