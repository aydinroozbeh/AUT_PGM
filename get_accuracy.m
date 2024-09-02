function [acc] = get_accuracy(mat1 , mat2)

s=size(mat1);
count=0;

for i=1:1:s(1)
    for j=1:1:s(2)
        if(mat1(i,j)==mat2(i,j))
            count=count+1;
        end
    end
end

acc = count/(s(1)*s(2));