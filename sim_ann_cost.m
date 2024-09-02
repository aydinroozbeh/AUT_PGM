% Implementation of the cost function defined in the problem 
% to be used in simulated annealing
% num_n = either 4 or 8
function [cost] = sim_ann_cost(est_image, ref_image , std, beta ,num_n)

s=size(est_image);
cost = 0;

for i=1:1:s(1)-3
    for j=1:1:s(2)-3
        coor = [i,j];
        if(num_n==4)
            neighbor_cost = get_neighbor_4(coor,est_image,beta);
        elseif(num_n==8)
            neighbor_cost = get_neighbor_8(coor,est_image,beta);
        end

        temp =  ((ref_image(i,j)-est_image(i,j))/(sqrt(2)*std))^2 + neighbor_cost ;
        cost = cost + temp;
        %log(sqrt(2*pi*std)) + 
    end
end

    