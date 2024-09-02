function [label] = image_to_label(image ,th)

% This is hard coded for the first part

s = size(image);
label = zeros(s)-1;

for i=1:1:s(1)
    for j=1:1:s(2)
        if(image(i,j) > th(1))     % White
            label(i,j)=1;
        elseif(image(i,j) > th(2)) % Gray
            label(i,j)=2;
        else                       % Black
            label(i,j)=3;
        end
    end
end