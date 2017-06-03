%This is inorder to generate the feature vector of the face u want to test
%our filepath to test images are at "~/16IS06F-16IS09F/Testdata/"
imgRGB=imread('D:\mySuccess\RILBP\input1\male\9332898\9332898.18.jpg');
img=rgb2gray(imgRGB);
filtersize=8;
filterradius=1;
filtR=generateRadialFilterLBP(filtersize, filterradius);
%% Test regular LBP vs RI-LBP
LBP= efficientLBP(img, 'filtR', filtR, 'isRotInv', false, 'isChanWiseRot', false);
RILBP= efficientLBP(img, 'filtR', filtR, 'isRotInv', true, 'isChanWiseRot', false);
uniqueRotInvLBP=findUVRILBP(filtersize);
tightValsRILBP=1:length(uniqueRotInvLBP);
TightRILBP=tightHistImg(RILBP, 'inMap', uniqueRotInvLBP, 'outMap', tightValsRILBP);
featureVec = imhist(TightRILBP);
featureVec=featureVec';
