

function GMM=get_GMM(X,Y,g)

k=max(X(:));
GMM=cell(k,1);

for i=1:k
    index=(X==i);
    Y1=Y(:,:,1);
    Y2=Y(:,:,2);
    Y3=Y(:,:,3);
    XX=[Y1(index) Y2(index) Y3(index)];
    GMM{i} = gmdistribution.fit(XX,g,'Regularize',1);
end