function [ output_args ] = Traindata( source,destiny,mul )
img_files = dir(source);
j=size(img_files,1);
disp(j);
for img = 3:size(img_files,1)
     
     I=imread([source,img_files(img).name]);
     I=rgb2gray(I);
     filtersize=8;
     filterradius=1;
     filtR=generateRadialFilterLBP(filtersize, filterradius);
     RILBP= efficientLBP(I, 'filtR', filtR, 'isRotInv', true, 'isChanWiseRot', false);
     uniqueRotInvLBP=findUVRILBP(filtersize);
     tightValsRILBP=1:length(uniqueRotInvLBP);
     effTightRILBP=tightHistImg(RILBP, 'inMap', uniqueRotInvLBP, 'outMap', tightValsRILBP);
     %imtool(effTightRILBP);
     featureVec = imhist(effTightRILBP);
     featureVec=featureVec';
     %disp(featureVec);
     %label=strcat('s','i');
     %str=string(label);
     label=ones(1,10);
     label=label*mul;
     label=num2cell(label);
     database(featureVec,label(1));
    %
    % imwrite(effRILBP,[destiny,'-LBP-',img_files(img).name]);
 end

end


