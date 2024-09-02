function [image] = label_to_image(label)

% This is hard coded for the first part

s = size(label);
image = zeros(s);

for i=1:1:s(1)
    for j=1:1:s(2)
        if(label(i,j) == 3)     % Black
            image(i,j)=0;
        
        elseif(label(i,j)==2)   % Gray
            image(i,j)=0.5;
       
        elseif(label(i,j)==1)   % White
            image(i,j)=1;
        end
    end
end