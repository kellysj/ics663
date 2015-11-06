function totalError = pwBTrainTest(c1,c2,c3,nT,h)
    
    [c1Train,c1i] = datasample(c1(:,1:4),nT,'Replace',false);
    c1Hold = c1(setdiff(1:1:50,c1i'),:);
    [c2Train,c2i] = datasample(c2(:,1:4),nT,'Replace',false);
    c2Hold = c2(setdiff(1:1:50,c2i'),:);
    [c3Train,c3i] = datasample(c3(:,1:4),nT,'Replace',false);
    c3Hold = c3(setdiff(1:1:50,c3i'),:);
    
    allHold = [c1Hold;c2Hold;c3Hold];
    
    sigma1 = diag(diag(cov(c1Train)));
    u1 = mean(c1Train);
    sigma2 = diag(diag(cov(c2Train)));
    u2 = mean(c2Train);
    sigma3 = diag(diag(cov(c3Train)));
    u3 = mean(c3Train);
    
    
    totalError = zeros(size(h,1),1)';
    for j=1:size(h,1);
        error = 0;
        for i=1:size(allHold,1)
            pX = zeros(1,3);
            pX(1) = pwBayes(allHold(i,1:4),c1Train,h(j),sigma1,u1);
            pX(2) = pwBayes(allHold(i,1:4),c2Train,h(j),sigma2,u2);
            pX(3) = pwBayes(allHold(i,1:4),c3Train,h(j),sigma3,u3);
            if find(pX==max(pX))~= allHold(i,5)
                error = error + 1;
            end
        end
        %disp(h(j));
        %disp(error);
        totalError(j) = error/size(allHold,1);
    end
end

function  pXD = pwBayes(xIn,xAll,h,sigma,u)
    n = size(xAll,1);
    h = h/sqrt(n);
    V = h^size(xIn,2); %just h^d, multidimensional hypercube as volume
    x = bsxfun(@minus,xAll,xIn)/h;%(x-xi)/h
    pXD = 0;
    for i = drange(1:n)
        %disp(i);
        %disp(x(i,:));
        pXD = pXD + (1/V)*bayesKernel(x(i,:),sigma,u);
    end
    pXD = pXD/n;
end

function out = bayesKernel(x,sigma,u)
    out = ((sqrt(2*pi*det(sigma)))^-1)*exp(-((x-u)*(2*sigma)^-1*(x-u)'));
end