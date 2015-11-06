function error = pwBTrainTest(in)
    
    nC = size(in,3); %number of classes
    for i = drange(1:nC)
        train(:,:,i), iT = datasample(in(:,1:4,i),nT,'Replace',false)
        hold = c2(setdiff(1:1:50,iT'));
    
    c1Hold = c1(setdiff(1:1:50,c1i'));
    [c2Train,c2i] = 
    c2Hold = c2(setdiff(1:1:50,c2i'));
    [c3Train,c3i] = datasample(c3(:,1:4),nT,'Replace',false)
    c3Hold = c3(setdiff(1:1:50,c3i'));
    
    sigma1 = diag(diag(cov(c1Train)));
    u1 = mean(c1Train);
    sigma2 = diag(diag(cov(c2Train)));
    u2 = mean(c2Train);
    sigma3 = diag(diag(cov(c3Train)));
    u3 = mean(c3Train);
    
    h = 1;
    
    px1 = pwBayes(c1Hold(i,1:4),c1Train,h,sigma1,u1);
    px2 = pwBayes(c2Hold(i,1:4),c2Train,h,sigma2,u2);
    px3 = pwBayes(c3Hold(i,1:4),c3Train,h,sigma3,u3);
    
    
end