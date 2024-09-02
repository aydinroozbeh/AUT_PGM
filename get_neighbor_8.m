function [point] = get_neighbor_8(coor , states , beta)

i=coor(1);
j=coor(2);
point=0;
s=size(states);

% Top Left Corner
if(i==1 && j==1)
    point = point + beta*give_points(states(i,j) , states(i,j+1));
    point = point + beta*give_points(states(i,j) , states(i+1,j));
    point = point + beta*give_points(states(i,j) , states(i+1,j+1));
end

% Top Right Corner
if(i==1 && j==s(2))
        point = point + beta*give_points(states(i,j) , states(i,j-1));
        point = point + beta*give_points(states(i+1,j) , states(i,j));
        point = point + beta*give_points(states(i+1,j) , states(i,j-1));
end

% Bottom Left Corner
if(i==s(1) && j==1)
    point = point + beta*give_points(states(i,j) , states(i-1,j));
    point = point + beta*give_points(states(i,j) , states(i,j+1));
    point = point + beta*give_points(states(i,j) , states(i-1,j+1));
end

% Bottom Right Corner
if(i==s(1) && j==s(2))
    point = point + beta*give_points(states(i,j) , states(i-1,j));
    point = point + beta*give_points(states(i,j) , states(i,j-1));
    point = point + beta*give_points(states(i,j) , states(i-1,j-1));

end

% Upper row, except for the corners
if(i==1 && j~=1 && j~=s(2))
        point = point + beta*give_points(states(i,j) , states(i,j+1));
        point = point + beta*give_points(states(i,j) , states(i,j-1));
        point = point + beta*give_points(states(i,j) , states(i+1,j));
        point = point + beta*give_points(states(i,j) , states(i+1,j+1));
        point = point + beta*give_points(states(i,j) , states(i+1,j-1));

end 

% Lower row, except for the corners
if(i==s(1) && j~=1 && j~=s(2))
        point = point + beta*give_points(states(i,j) , states(i,j+1));
        point = point + beta*give_points(states(i,j) , states(i,j-1));
        point = point + beta*give_points(states(i,j) , states(i-1,j));
        point = point + beta*give_points(states(i,j) , states(i-1,j-1));
        point = point + beta*give_points(states(i,j) , states(i-1,j+1));
end 

% Left Column, except for the corners
if(i~=1 && i~=s(2) && j==1)
        point = point + beta*give_points(states(i,j) , states(i,j+1));
        point = point + beta*give_points(states(i,j) , states(i-1,j));
        point = point + beta*give_points(states(i,j) , states(i+1,j));
        point = point + beta*give_points(states(i,j) , states(i-1,j+1));
        point = point + beta*give_points(states(i,j) , states(i+1,j+1));
end 

% Right Column, except for the corners
if(i~=1 && i~=s(2) && j==s(2))
        point = point + beta*give_points(states(i,j) , states(i,j-1));
        point = point + beta*give_points(states(i,j) , states(i-1,j));
        point = point + beta*give_points(states(i,j) , states(i+1,j));
        point = point + beta*give_points(states(i,j) , states(i-1,j-1));
        point = point + beta*give_points(states(i,j) , states(i+1,j-1));
end 

% Center
if(i~=1 && i~=s(2) && j~=1 && j~=s(2))
        point = point + beta*give_points(states(i,j) , states(i,j-1));
        point = point + beta*give_points(states(i,j) , states(i,j+1));
        point = point + beta*give_points(states(i,j) , states(i+1,j));
        point = point + beta*give_points(states(i,j) , states(i-1,j));
        point = point + beta*give_points(states(i,j) , states(i,j-1));
        point = point + beta*give_points(states(i,j) , states(i,j+1));
        point = point + beta*give_points(states(i,j) , states(i+1,j));
        point = point + beta*give_points(states(i,j) , states(i-1,j));

end

end

