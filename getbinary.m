function  b=getbinary(a,X);
Centeroid=180;
a=uint8(a);
ag=rgb2gray(a);
[r c p]=size(ag);
for i=1:r
    for j=1:c
        data=ag(i,j);
        if data >Centeroid;
           X(i,j,1)=255; 
           X(i,j,2)=255; 
           X(i,j,3)=255; 
        end
   
    end
end
b=X;
% figure;
% title('seg');
% imshow(a);
% impixelinfo
