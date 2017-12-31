clc;
clear;
close all;
a=imread('mdb005ll.jpg');
b=rgb2gray(a);
J = imnoise(b,'salt & pepper', 0.02);
NoisyImage=J;
[R C P]=size(NoisyImage);
OutImage=zeros(R,C);
figure;
% imshow(J);
Zmin=[];
Zmax=[];
Zmed=[];

for i=1:R
    for j=1:C
               if (i==1 & j==1)
                        
                        
          % for right top corner[8,7,6]
                elseif (i==1 & j==C)
                        
                        
			% for bottom left corner[2,3,4]
                elseif (i==R & j==1)
                        
                        
        		     % for bottom right corner[8,1,2]

                elseif (i==R & j==C)
                        
                        
        		    %for top edge[8,7,6,5,4]

                elseif (i==1)
		      			 	
		      			 
                     		      			% for right edge[2,1,8,7,6]

                elseif (i==R)
		      			 
		      			% // for bottom edge[8,1,2,3,4]
		      			 
                elseif (j==C)
		      			 
						 
                         %// for left edge[2,3,4,5,6]
						 
                elseif (j==1)
                    
						 
                            
                         
						 
               else
                    
                   
						 	
                             SR1 = NoisyImage((i-1),(j-1));
 							 SR2 = NoisyImage((i-1),(j));
    						 SR3 = NoisyImage((i-1),(j+1));
 							 SR4 = NoisyImage((i),(j-1));
                             SR5 = NoisyImage(i,j);
 							 SR6 = NoisyImage((i),(j+1));
 							 SR7 = NoisyImage((i+1),(j-1));
 							 SR8 = NoisyImage((i+1),(j));
 							 SR9 = NoisyImage((i+1)),((j+1));
                             TempPixel=[SR1,SR2,SR3,SR4,SR5,SR6,SR7,SR8,SR9];
                             Zxy=NoisyImage(i,j);
                             Zmin=min(TempPixel);
                             Zmax=max(TempPixel);
                             Zmed=median(TempPixel);
                             A1 = Zmed - Zmin;
                             A2 = Zmed - Zmax;
                         
                             if A1 > 0 && A2 < 0
                             
                                  %   go to level B
                                  B1 = Zxy - Zmin;
                                  B2 = Zxy - Zmax;
                                  if B1 > 0 && B2 < 0
                                      OutImage(i,j)= Zxy;
                                  else
                                      OutImage(i,j)= Zmed;

                                  end
                             else
                                 
                                 if ((R > 4 && R < R-5) && (C > 4 && C < C-5))
                                 
                                 S1 = NoisyImage((i-1),(j-1));
                                 S2 = NoisyImage((i-2),(j-2));
                                 S3 = NoisyImage((i-1),(j));
                                 S4 = NoisyImage((i-2),(j));
                                 S5 = NoisyImage((i-1),(j+1));
                                 S6 = NoisyImage((i-2),(j+2));
                                 S7 = NoisyImage((i),(j-1));
                                 S8 = NoisyImage((i),(j-2));

                                 S9 = NoisyImage(i,j);
                                 S10 = NoisyImage((i),(j+1));
                                 S11 = NoisyImage((i),(j+2));
                                 S12 = NoisyImage((i+1),(j-1));
                                 S13 = NoisyImage((i+2),(j-2));
                                 S14 = NoisyImage((i+1),(j));
                                 S15 = NoisyImage((i+2),(j));
                                 S16 = NoisyImage((i+1)),((j+1));
                                 S17 = NoisyImage((i+2)),((j+2));
                                 TempPixel2=[S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17];
                                 Zmed2=median(TempPixel2);
                                 OutImage(i,j)= Zmed2;
                                 else
                                     
                                 OutImage(i,j)= Zmed;

                                 end

                             end         
                     
          end    
      
    end
end
imshow(OutImage,[]);
disp('exit');