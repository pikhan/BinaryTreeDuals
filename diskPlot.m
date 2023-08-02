function [plot] = diskPlot(treeOrDual,points)
%This function plots the disk embedding of a tree or alternatively it plots
%a graph embedded in the disk. 

if treeOrDual==0 %if we expect a tree, then points is a parentPointer
    treeplot(points);
    plot=1;
elseif treeOrDual==1
    disp("Graph Plot");
else
    disp("treeOrDual input not accepted.");
end