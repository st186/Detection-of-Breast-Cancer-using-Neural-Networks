function varargout = guidemo(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guidemo_OpeningFcn, ...
                   'gui_OutputFcn',  @guidemo_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before guidemo is made visible.
function guidemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guidemo (see VARARGIN)

% Choose default command line output for guidemo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guidemo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guidemo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    [filename, pathname] = uigetfile('*.jpg', 'Pick a Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
    filename=strcat(pathname,filename);
    
    InputImage=imread(filename);
    
    axes(handles.axes1);
    imshow(InputImage);
    
    handles.InputImage=InputImage;
    end
    % Update handles structure
guidata(hObject, handles);


% --- Executes on button press in AdaptiveMedianFilter.
function AdaptiveMedianFilter_Callback(hObject, eventdata, handles)
% hObject    handle to AdaptiveMedianFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

        InputImage=handles.InputImage;
        GrayScaleImage=rgb2gray(InputImage);
               
        NoisyImage=GrayScaleImage;
        NoisyImage=double(GrayScaleImage);
        [R C P]=size(NoisyImage);
        OutImage=zeros(R,C);
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
                                              PreProcessedImage(i,j)= Zxy;
                                          else
                                              PreProcessedImage(i,j)= Zmed;

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
                                         PreProcessedImage(i,j)= Zmed2;
                                         else

                                         PreProcessedImage(i,j)= Zmed;

                                         end

                                     end         

                  end    

            end
        end
        
        
        
        
        PreProcessedImage3=[]
        PreProcessedImage3(:,:,1)=PreProcessedImage;
        PreProcessedImage3(:,:,2)=PreProcessedImage;
        PreProcessedImage3(:,:,3)=PreProcessedImage;

        PreProcessedImage=PreProcessedImage3;
        PreProcessedImage=uint8(PreProcessedImage);
        axes(handles.axes2);
        imshow(PreProcessedImage,[]);
        handles.PreProcessedImage=PreProcessedImage;
    
    % Update handles structure
guidata(hObject, handles);

warndlg('Process completed'); 
    
    
    


% --- Executes on button press in GMMSegmentation.
function GMMSegmentation_Callback(hObject, eventdata, handles)
% hObject    handle to GMMSegmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        PreProcessedImage=  handles.PreProcessedImage;

        
        Y=double(PreProcessedImage);

        k=2; % k: number of regions

        g=2; % g: number of GMM components

        beta=1; % beta: unitary vs. pairwise

        EM_iter=10; % max num of iterations

        MAP_iter=10; % max num of iterations

       % fprintf('Performing k-means segmentation\n');

        [X,GMM,ShapeTexture]=image_kmeans(Y,k,g);
        [X,Y,GMM]=HMRF_EM(X,Y,GMM,k,g,EM_iter,MAP_iter,beta);

        Y=Y*80;

        Y=uint8(Y);
 %OutImage=Y;


        
        Y=rgb2gray(Y);
    Y=double(Y);
    
    statsa = glcm(Y,0,ShapeTexture);
    ExtractedFeatures1=statsa;
    axes(handles.axes2);

    imshow(Y,[]);
Y=uint8(Y);

    handles.ExtractedFeatures=ExtractedFeatures1;
    disp('exit');    
    handles.gmm=1;

    % Update handles structure
    guidata(hObject, handles);
warndlg('Process completed'); 

% --- Executes on button press in Classifier.
function Classifier_Callback(hObject, eventdata, handles)
% hObject    handle to Classifier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gmm=0;
gmm=handles.gmm;


load ExtractedFeatures

A=1:20;
B=21:40;
C=41:60;

P = [A B C];
Tc = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3];

k=2; % k: number of regions
g=2; % g: number of GMM components

beta=1; % beta: unitary vs. pairwise
EM_iter=10; % max num of iterations
MAP_iter=10; % max num of iterations


% load ExtractedFeatures;
% load Featuresb1
% load Featuresm1
% load Featuresn1
% load Featuresb2
% load Featuresm2
% load Featuresn2
% load Featuresb3
% load Featuresm3
% load Featuresn3
% load Featuresb4
% load Featuresm4
% load Featuresn4
% load Featuresb5
% load Featuresm5
% load Featuresn5
% load Featuresb6
% load Featuresm6
% load Featuresn6
% load Featuresb7
% load Featuresm7
% load Featuresn7
% load Featuresb8
% load Featuresm8
% load Featuresn8
% load Featuresb9
% load Featuresm9
% load Featuresn9
% load Featuresb10
% load Featuresm10
% load Featuresn10
% load Featuresb11
% load Featuresm11
% load Featuresn11
% load Featuresb12
% load Featuresm12
% load Featuresn12
% load Featuresb13
% load Featuresm13
% load Featuresn13
% load Featuresb14
% load Featuresm14
% load Featuresn14
% load Featuresb15
% load Featuresm15
% load Featuresn15
% load Featuresb16
% load Featuresm16
% load Featuresn16
% load Featuresb17
% load Featuresm17
% load Featuresn17
% load Featuresb18
% load Featuresm18
% load Featuresn18
% load Featuresb19
% load Featuresm19
% load Featuresn19
% load Featuresb20
% load Featuresm20
% load Featuresn20
% 
% 
% Out(1)=corr2(ExtractedFeatures.ShapeTexture,Featuresb1.ShapeTexture);
% Out(2)=corr2(ExtractedFeatures.ShapeTexture,Featuresb2.ShapeTexture);
% Out(3)=corr2(ExtractedFeatures.ShapeTexture,Featuresb3.ShapeTexture);
% Out(4)=corr2(ExtractedFeatures.ShapeTexture,Featuresb4.ShapeTexture);
% Out(5)=corr2(ExtractedFeatures.ShapeTexture,Featuresb5.ShapeTexture);
% Out(6)=corr2(ExtractedFeatures.ShapeTexture,Featuresb6.ShapeTexture);
% Out(7)=corr2(ExtractedFeatures.ShapeTexture,Featuresb7.ShapeTexture);
% Out(8)=corr2(ExtractedFeatures.ShapeTexture,Featuresb8.ShapeTexture);
% Out(9)=corr2(ExtractedFeatures.ShapeTexture,Featuresb9.ShapeTexture);
% Out(10)=corr2(ExtractedFeatures.ShapeTexture,Featuresb10.ShapeTexture);
% Out(11)=corr2(ExtractedFeatures.ShapeTexture,Featuresb11.ShapeTexture);
% Out(12)=corr2(ExtractedFeatures.ShapeTexture,Featuresb12.ShapeTexture);
% Out(13)=corr2(ExtractedFeatures.ShapeTexture,Featuresb13.ShapeTexture);
% Out(14)=corr2(ExtractedFeatures.ShapeTexture,Featuresb14.ShapeTexture);
% Out(15)=corr2(ExtractedFeatures.ShapeTexture,Featuresb15.ShapeTexture);
% Out(16)=corr2(ExtractedFeatures.ShapeTexture,Featuresb16.ShapeTexture);
% Out(17)=corr2(ExtractedFeatures.ShapeTexture,Featuresb17.ShapeTexture);
% Out(18)=corr2(ExtractedFeatures.ShapeTexture,Featuresb18.ShapeTexture);
% Out(19)=corr2(ExtractedFeatures.ShapeTexture,Featuresb19.ShapeTexture);
% Out(20)=corr2(ExtractedFeatures.ShapeTexture,Featuresb20.ShapeTexture);
% 
% 
% 
% Out(21)=corr2(ExtractedFeatures.ShapeTexture,Featuresm1.ShapeTexture);
% Out(22)=corr2(ExtractedFeatures.ShapeTexture,Featuresm2.ShapeTexture);
% Out(23)=corr2(ExtractedFeatures.ShapeTexture,Featuresm3.ShapeTexture);
% Out(24)=corr2(ExtractedFeatures.ShapeTexture,Featuresm4.ShapeTexture);
% Out(25)=corr2(ExtractedFeatures.ShapeTexture,Featuresm5.ShapeTexture);
% Out(26)=corr2(ExtractedFeatures.ShapeTexture,Featuresm6.ShapeTexture);
% Out(27)=corr2(ExtractedFeatures.ShapeTexture,Featuresm7.ShapeTexture);
% Out(28)=corr2(ExtractedFeatures.ShapeTexture,Featuresm8.ShapeTexture);
% Out(29)=corr2(ExtractedFeatures.ShapeTexture,Featuresm9.ShapeTexture);
% Out(30)=corr2(ExtractedFeatures.ShapeTexture,Featuresm10.ShapeTexture);
% Out(31)=corr2(ExtractedFeatures.ShapeTexture,Featuresm11.ShapeTexture);
% Out(32)=corr2(ExtractedFeatures.ShapeTexture,Featuresm12.ShapeTexture);
% Out(33)=corr2(ExtractedFeatures.ShapeTexture,Featuresm13.ShapeTexture);
% Out(34)=corr2(ExtractedFeatures.ShapeTexture,Featuresm14.ShapeTexture);
% Out(35)=corr2(ExtractedFeatures.ShapeTexture,Featuresm15.ShapeTexture);
% Out(36)=corr2(ExtractedFeatures.ShapeTexture,Featuresm16.ShapeTexture);
% Out(37)=corr2(ExtractedFeatures.ShapeTexture,Featuresm17.ShapeTexture);
% Out(38)=corr2(ExtractedFeatures.ShapeTexture,Featuresm18.ShapeTexture);
% Out(39)=corr2(ExtractedFeatures.ShapeTexture,Featuresm19.ShapeTexture);
% Out(40)=corr2(ExtractedFeatures.ShapeTexture,Featuresm20.ShapeTexture);
% 
% 
% Out(41)=corr2(ExtractedFeatures.ShapeTexture,Featuresn1.ShapeTexture);
% Out(42)=corr2(ExtractedFeatures.ShapeTexture,Featuresn2.ShapeTexture);
% Out(43)=corr2(ExtractedFeatures.ShapeTexture,Featuresn3.ShapeTexture);
% Out(44)=corr2(ExtractedFeatures.ShapeTexture,Featuresn4.ShapeTexture);
% Out(45)=corr2(ExtractedFeatures.ShapeTexture,Featuresn5.ShapeTexture);
% Out(46)=corr2(ExtractedFeatures.ShapeTexture,Featuresn6.ShapeTexture);
% Out(47)=corr2(ExtractedFeatures.ShapeTexture,Featuresn7.ShapeTexture);
% Out(48)=corr2(ExtractedFeatures.ShapeTexture,Featuresn8.ShapeTexture);
% Out(49)=corr2(ExtractedFeatures.ShapeTexture,Featuresn9.ShapeTexture);
% Out(50)=corr2(ExtractedFeatures.ShapeTexture,Featuresn10.ShapeTexture);
% Out(51)=corr2(ExtractedFeatures.ShapeTexture,Featuresn11.ShapeTexture);
% Out(52)=corr2(ExtractedFeatures.ShapeTexture,Featuresn12.ShapeTexture);
% Out(53)=corr2(ExtractedFeatures.ShapeTexture,Featuresn13.ShapeTexture);
% Out(54)=corr2(ExtractedFeatures.ShapeTexture,Featuresn14.ShapeTexture);
% Out(55)=corr2(ExtractedFeatures.ShapeTexture,Featuresn15.ShapeTexture);
% Out(56)=corr2(ExtractedFeatures.ShapeTexture,Featuresn16.ShapeTexture);
% Out(57)=corr2(ExtractedFeatures.ShapeTexture,Featuresn17.ShapeTexture);
% Out(58)=corr2(ExtractedFeatures.ShapeTexture,Featuresn18.ShapeTexture);
% Out(59)=corr2(ExtractedFeatures.ShapeTexture,Featuresn19.ShapeTexture);
% Out(60)=corr2(ExtractedFeatures.ShapeTexture,Featuresn20.ShapeTexture);
% 
% 
% disp('exit');

 file=handles.InputImage;

%    [filename, pathname] = uigetfile('*.jpg', 'Pick a MATLAB code file');
%diff=[];
%     file=imread(filename);
    file=rgb2gray(file);
    file=adaptivemedian(file);
    [Xk,GMMk,ShapeTexture]=image_kmeans(file,k,g);
    PreProcessedImage(:,:,1)=file;
    PreProcessedImage(:,:,2)=file;
    PreProcessedImage(:,:,3)=file;

    
    stats= gmmsegmentation(Xk,PreProcessedImage,GMMk,k,g,beta,EM_iter,MAP_iter,ShapeTexture);

    ShapeTexture=stats.ShapeTexture;
    
    for i=1:60
        
         statsa=ExtractedFeature{i};
         ShapeTexturea=statsa.ShapeTexture;
         
%           contr: 1.009343523879179e+04
%            corrm: -1.418636507817068e-01
%            corrp: -1.418636507820288e-01
%            cprom: 1.401715132552546e+08
%            cshad: -5.383904478067012e+04
%            dissi: 7.682897985689002e+01
%            energ: 3.431092389799559e-05
%            entro: 1.062998117740541e+01
%            homom: 4.224863191210370e-02
%            homop: 1.433346931769391e-02
%            maxpr: 5.297210924967812e-05
%            sosvh: 1.408273420241230e+04
%            savgh: 2.434734485092406e+02
%            svarh: 6.299666464377906e+04
%            senth: 5.757012620902187e+00
%            dvarh: 1.009343523879205e+04
%            denth: 5.258320847693307e+00
%            inf1h: -3.933982450962872e-02
%            inf2h: 5.914821945236276e-01
%            indnc: 7.945157263269642e-01
%            idmnc: 8.914962508154409e-01
%            
         
         diff1(i)=corr2(stats.autoc,statsa.autoc);
         diff2(i)=corr2(stats.contr,statsa.contr);
         diff3(i)=corr2(stats.corrm,statsa.corrm);
         diff4(i)=corr2(stats.cprom,statsa.cprom);
         diff5(i)=corr2(stats.cshad,statsa.cshad);
         diff6(i)=corr2(stats.dissi,statsa.dissi);
         diff7(i)=corr2(stats.energ,statsa.energ);
         diff8(i)=corr2(stats.entro,statsa.entro);
         diff9(i)=corr2(stats.homom,statsa.homom);
         diff10(i)=corr2(stats.homop,statsa.homop);
         diff11(i)=corr2(stats.maxpr,statsa.maxpr);
         diff12(i)=corr2(stats.sosvh,statsa.sosvh);
         diff13(i)=corr2(stats.savgh,statsa.savgh);
         diff14(i)=corr2(stats.svarh,statsa.svarh);
         diff15(i)=corr2(stats.senth,statsa.senth);
         diff16(i)=corr2(stats.dvarh,statsa.dvarh);
         diff17(i)=corr2(stats.denth,statsa.denth);
         diff18(i)=corr2(stats.inf1h,statsa.inf1h);
         diff19(i)=corr2(stats.inf2h,statsa.inf2h);
         diff19(i)=corr2(stats.indnc,statsa.indnc);
         diff19(i)=corr2(stats.idmnc,statsa.idmnc);
         diff20(i)=corr2(ShapeTexture,ShapeTexturea);
    


     
     
    
    end

    [val1 index1]=max(diff1);
    [val2 index2]=max(diff2);
    [val3 index3]=max(diff3);
    [val4 index4]=max(diff4);
    [val5 index5]=max(diff5);
    [val6 index6]=max(diff6);
    [val7 index7]=max(diff7);
    [val8 index8]=max(diff8);
    [val9 index9]=max(diff9);
    [val10 index10]=max(diff10);
    [val11 index11]=max(diff11);
    [val12 index12]=max(diff12);
    [val13 index13]=max(diff13);
    [val14 index14]=max(diff14);
    [val15 index15]=max(diff15);
    [val16 index16]=max(diff16);
    [val17 index17]=max(diff17);
    [val18 index18]=max(diff18);
    [val19 index19]=max(diff19);
    [val20 index20]=max(diff20);


% for i=1:3, text(P(1,i)+0.1,P(2,i),sprintf('class %g',Tc(i))), end
% axis([0 3 0 3])
% title('Three vectors and their classes.')
% xlabel('P(1,:)')
% ylabel('P(2,:)')

T = ind2vec(Tc);

spread = 1;

net = newpnn(P,T,spread);

A = sim(net,P);
Ac = vec2ind(A);
% plot(P(1,:),P(2,:),'.','markersize',30)
% axis([0 3 0 3])
% for i=1:3,text(P(1,i)+0.1,P(2,i),sprintf('class %g',Ac(i))),end
% title('Testing the network.')
% xlabel('P(1,:)')
% ylabel('P(2,:)')
pl(1) = index20;
p1(2) = index1;
p1(3) = index2;
p1(4) = index3;
p1(5) = index4;
p1(6) = index5;
p1(7) = index6;
p1(8) = index7;
p1(9) = index8;
p1(10) = index9;
p1(11) = index10;
p1(12) = index11;
p1(13) = index12;
p1(14) = index13;
p1(15) = index14;
p1(16) = index15;
p1(17)= index16;
p1(18) = index17;
p1(19) = index18;
p1(20) = index19;


% pl = index20;
a = sim(net,pl);
ac = vec2ind(a);
disp(ac);
ac=num2str(ac)

set(handles.edit1,'String',ac);

warndlg('Process completed'); 




% --- Executes on button press in loaddatabase.
function loaddatabase_Callback(hObject, eventdata, handles)
% hObject    handle to loaddatabase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    clc;
    ;
%     [filename, pathname] = uigetfile('*.jpg', 'Pick a MATLAB code file');
% load diff;
    k=2; % k: number of regions
    g=2; % g: number of GMM components

    beta=1; % beta: unitary vs. pairwise
    EM_iter=10; % max num of iterations
    MAP_iter=10; % max num of iterations

    
    helpdlg('In case of error please rerun the same program on system with 8gb ram to avoid empty clusters');
%     file=imread(filename);
%     file=rgb2gray(file);
%     file=adaptivemedian(file);
%     [Xk,GMMk,ShapeTexture]=image_kmeans(file,k,g);
%     PreProcessedImage(:,:,1)=file;
%     PreProcessedImage(:,:,2)=file;
%     PreProcessedImage(:,:,3)=file;
% 
%     
%     statsa= gmmsegmentation(Xk,PreProcessedImage,GMMk,k,g,beta,EM_iter,MAP_iter,ShapeTexture);
% 
%     ShapeTexture=statsa.ShapeTexture;

    %b1=wlt4(file);



    len=1;
    len1=21;
    len2=41;
             h = waitbar(0,'Please wait...');
        
for num=1:20

%num=15;
waitbar(num/20,h)

    filename1=strcat('Beningn',num2str(num),'.jpg');
    filename2=strcat('Malign',num2str(num),'.jpg');
    filename3=strcat('Malign',num2str(num),'.jpg');
    a=imread(filename1);
    b=imread(filename2);
    c=imread(filename3);

    a=rgb2gray(a);
    b=rgb2gray(b);
    c=rgb2gray(c);
    a=adaptivemedian(a);
    
    b=adaptivemedian(b);
    c=adaptivemedian(c);

        
   [Xka,GMMka,ShapeTexturea]=image_kmeans(a,k,g);
   [Xkb,GMMkb,ShapeTextureb]=image_kmeans(b,k,g);
   [Xkc,GMMkc,ShapeTexturec]=image_kmeans(c,k,g);

%     a=wlt4(a);
%     b=wlt4(b);
% 
%     c=wlt4(c);

%[Xk,GMMk,ShapeTexture]=image_kmeans(file,k,g);
    PreProcessedImagea(:,:,1)=a;
    PreProcessedImagea(:,:,2)=a;
    PreProcessedImagea(:,:,3)=a;

    PreProcessedImageb(:,:,1)=b;
    PreProcessedImageb(:,:,2)=b;
    PreProcessedImageb(:,:,3)=b;

    PreProcessedImagec(:,:,1)=c;
    PreProcessedImagec(:,:,2)=c;
    PreProcessedImagec(:,:,3)=c;


    statsa= gmmsegmentation(Xka,PreProcessedImagea,GMMka,k,g,beta,EM_iter,MAP_iter,ShapeTexturea);
    statsb= gmmsegmentation(Xkb,PreProcessedImageb,GMMkb,k,g,beta,EM_iter,MAP_iter,ShapeTextureb);
    statsc= gmmsegmentation(Xkc,PreProcessedImagec,GMMkc,k,g,beta,EM_iter,MAP_iter,ShapeTexturec);

%     ShapeTexturea=statsa.ShapeTexture;
%     ShapeTextureb=statsb.ShapeTexture;
%     ShapeTexturec=statsc.ShapeTexture;

% Featuresb15=statsa;
% Featuresm15=statsb;
% Featuresn15=statsc;


     diff{len}=statsa;
     diff{len1}=statsb;
     diff{len2}=statsc;

    len=len+1;
    len1=len1+1;
    len2=len2+1;


     
     
    
end
save extractedfeatures diff
close(h);




[val index]=max(diff);

disp('exit');

warndlg('Process completed'); 

% --- Executes on button press in TrainPNN.
function TrainPNN_Callback(hObject, eventdata, handles)
% hObject    handle to TrainPNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A=1:20;
B=21:40;
C=41:60;

P = [A B C];
Tc = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3];

T = ind2vec(Tc);
spread = 1;
net = newpnn(P,T,spread);

warndlg('Training Completed Sucessfully');


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=ones(256,256);
axes(handles.axes1);
imshow(a);
axes(handles.axes2);
imshow(a);
a='0'
clear;
set(handles.edit1,'String',a);
