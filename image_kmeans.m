

function [X GMM ShapeTexture]=image_kmeans(Y,k,g)
[m n temp]=size(Y);

if temp==3
   b=rgb2gray(Y);
   ShapeTexture=wlt4(b);
   
elseif temp==1
    
      ShapeTexture=wlt4(Y);
        Y1(:,:,1)=Y;
        Y1(:,:,2)=Y;
        Y1(:,:,3)=Y;
Y=Y1;
end


y=reshape(Y,[m*n 3]);
x=kmeans(y,k);
X=reshape(x,[m n]);

GMM=get_GMM(X,Y,g);