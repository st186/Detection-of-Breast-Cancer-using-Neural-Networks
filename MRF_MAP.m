

function [X sum_U]=MRF_MAP(X,Y,GMM,k,g,MAP_iter,beta,show_plot)

[m n temp]=size(Y);
%   Y1(:,:,1)=Y;
%         Y1(:,:,2)=Y;
%         Y1(:,:,3)=Y;
% Y=Y1;

x=X(:);
y=reshape(Y,[m*n 3]);

sum_U_MAP=zeros(1,MAP_iter);
for it=1:MAP_iter % iterations
   % fprintf('  Inner iteration: %d\n',it);
    U=zeros(m*n,k);
    U1=U;
    U2=U;

    for l=1:k % all labels
        for c=1:g
            mu=GMM{l}.mu(c,:);
            Sigma=GMM{l}.Sigma(:,:,c);
            p=GMM{l}.PComponents(c);
            
            yi=bsxfun(@minus,y,mu);
            temp1=(yi*inv(Sigma)).*yi;
            temp1=sum(temp1,2)/2;
            temp1=temp1+log(sqrt(det(Sigma)));
            U1(:,l)=U1(:,l)+temp1*p;
        end
     
        for ind=1:m*n % all pixels
            [i j]=ind2ij(ind,m);
            u2=0;
            if i-1>=1 
                u2=u2+(l ~= X(i-1,j))/2;
            end
            if i+1<=m 
                u2=u2+(l ~= X(i+1,j))/2;
            end
            if j-1>=1 
                u2=u2+(l ~= X(i,j-1))/2;
            end
            if j+1<=n 
                u2=u2+(l ~= X(i,j+1))/2;
            end
            U2(ind,l)=u2;
        end
    end
    U=U1+U2*beta;
    [temp x]=min(U,[],2);
    sum_U_MAP(it)=sum(temp(:));
    X=reshape(x,m,n);
    
    if it>=3 && std(sum_U_MAP(it-2:it))<0.01
        break;
    end
end

sum_U=0;
for ind=1:m*n % all pixels
    sum_U=sum_U+U(ind,x(ind));
end
if show_plot==1
    figure;
    plot(1:it,sum_U_MAP(1:it),'r');
    title('sum U MAP');
    xlabel('MAP iteration');
    ylabel('sum U MAP');
    drawnow;
end
