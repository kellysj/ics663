nT = 30;%number for training, shouldn't exceed total class count

%reading in the data
[a,b,c,d,class] = textread('iris.txt','%f,%f,%f,%f,%d');
data = [a,b,c,d,class];
c1 = data(find(data(:,5)==1),:);
c2 = data(find(data(:,5)==2),:);
c3 = data(find(data(:,5)==3),:);

%splitting into training and hold sets
[c1Train,c1i] = datasample(c1,nT,'Replace',false);
c1Hold = c1(setdiff(1:1:50,c1i'),:)
[c2Train,c2i] = datasample(c2,nT,'Replace',false);
c2Hold = c2(setdiff(1:1:50,c2i'),:)
[c3Train,c3i] = datasample(c3,nT,'Replace',false);
c3Hold = c3(setdiff(1:1:50,c3i'),:)

