

function statsa= gmmsegmentation(X,PreProcessedImage,GMM,k,g,beta,EM_iter,MAP_iter,ShapeTexture);

        Y=double(PreProcessedImage);

        

        [X,Y,GMM]=HMRF_EM(X,Y,GMM,k,g,EM_iter,MAP_iter,beta);
        Y=Y*80;
        Y=uint8(Y);
      %OutImage=Y;
    
       Y=rgb2gray(Y);
       Y=double(Y);
  
       statsa = glcm(Y,0,ShapeTexture);
