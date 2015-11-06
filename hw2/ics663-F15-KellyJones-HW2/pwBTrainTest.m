%this function finds the total error per h width for random training and
%holdout sets selected from the provided data
%c1,c2,c3 are the 3 sets of labeled data
%h is an array of window widths
%nT is the split between holdout and training sets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function totalError = pwBTrainTest(c1,c2,c3,nT,h)
    
    %getting training and holdout sets
    [c1Train,c1i] = datasample(c1(:,1:4),nT,'Replace',false);
    c1Hold = c1(setdiff(1:1:50,c1i'),:);
    [c2Train,c2i] = datasample(c2(:,1:4),nT,'Replace',false);
    c2Hold = c2(setdiff(1:1:50,c2i'),:);
    [c3Train,c3i] = datasample(c3(:,1:4),nT,'Replace',false);
    c3Hold = c3(setdiff(1:1:50,c3i'),:);
    
    %compiling a total holdout for error determination
    allHold = [c1Hold;c2Hold;c3Hold];
    %disp(allHold);
    
    %finding the parameters for gaussian kernels
    sigma1 = diag(diag(cov(c1Train)));%diagonal varience matrix
    u1 = mean(c1Train);%column means
    sigma2 = diag(diag(cov(c2Train)));
    u2 = mean(c2Train);
    sigma3 = diag(diag(cov(c3Train)));
    u3 = mean(c3Train);
        
    totalError = zeros(size(h,1),1)';%accumulates the errors
    for j=1:size(h,1);
        error = 0;
        for i=1:size(allHold,1)
            pX = zeros(1,3);%store the p(x) for each class
            x = allHold(i,1:4);
            pX(1) = pwBayes(x,c1Train,h(j),sigma1,u1);
            pX(2) = pwBayes(x,c2Train,h(j),sigma2,u2);
            pX(3) = pwBayes(x,c3Train,h(j),sigma3,u3);
            %find the max p(x) from the classifier and classify
            disp(pX);
            disp(allHold(i,5));
            if find(pX==max(pX)) ~= (allHold(i,5))
                disp 'error';
                error = error + 1;%if the class isn't the label, add error
            end
            if max(pX) == 0
                disp '0 error';
                error = error + 1;%if the class isn't the label, add error
            end
        end
        totalError(j) = error/size(allHold,1);%getting the mean error
        %disp(totalError);
    end
end