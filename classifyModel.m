function [ Model ] = classifyModel( )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
load db.mat
load label.mat
lab = cell2mat(lab);
Model=fitcknn(features,lab,'NumNeighbors',5,'Standardize',1);


end

