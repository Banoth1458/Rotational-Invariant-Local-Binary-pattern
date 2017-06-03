function [ Trainingdata ] = database( limg,labe )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
     features=limg;
     lab=labe;
     try
         load Training.mat
         load label.mat
         features=[features;limg];
         lab=[lab;labe];
         %disp(db);
         save Training.mat features
         save label.mat lab
     catch
         features=limg;
         lab=labe;
         %disp(db);
         save Training.mat features
         save label.mat lab
     end
    
end

