function [point] = get_neighbor_4(coor , states , beta)

i=coor(1);
j=coor(2);

point=0;
s=size(states);

% Top Left Corner
if(i==1 && j==1)
    point = point + beta*give_points(states(i,j) , states(i,j+1));
    point = point + beta*give_points(states(i,j) , states(i+1,j));
end

% Top Right Corner
if(i==1 && j==s(2))
        point = point + beta*give_points(states(i,j) , states(i,j-1));
        point = point + beta*give_points(states(i+1,j) , states(i,j));
end

% Bottom Left Corner
if(i==s(1) && j==1)
    point = point + beta*give_points(states(i,j) , states(i-1,j));
    point = point + beta*give_points(states(i,j) , states(i,j+1));
end

% Bottom Right Corner
if(i==s(1) && j==s(2))
    point = point + beta*give_points(states(i,j) , states(i-1,j));
    point = point + beta*give_points(states(i,j) , states(i,j-1));
end

% Upper row, except for the corners
if(i==1 && j~=1 && j~=s(2))
        point = point + beta*give_points(states(i,j) , states(i,j+1));
        point = point + beta*give_points(states(i,j) , states(i,j-1));
        point = point + beta*give_points(states(i,j) , states(i+1,j));
end 

% Lower row, except for the corners
if(i==s(1) && j~=1 && j~=s(2))
        point = point + beta*give_points(states(i,j) , states(i,j+1));
        point = point + beta*give_points(states(i,j) , states(i,j-1));
        point = point + beta*give_points(states(i,j) , states(i-1,j));
end 

% Left Column, except for the corners
if(i~=1 && i~=s(2) && j==1)
        point = point + beta*give_points(states(i,j) , states(i,j+1));
        point = point + beta*give_points(states(i,j) , states(i-1,j));
        point = point + beta*give_points(states(i,j) , states(i+1,j));
end 

% Right Column, except for the corners
if(i~=1 && i~=s(2) && j==s(2))
        point = point + beta*give_points(states(i,j) , states(i,j-1));
        point = point + beta*give_points(states(i,j) , states(i-1,j));
        point = point + beta*give_points(states(i,j) , states(i+1,j));
end 

% Center
if(i~=1 && i~=s(2) && j~=1 && j~=s(2))
        point = point + beta*give_points(states(i,j) , states(i,j-1));
        point = point + beta*give_points(states(i,j) , states(i,j+1));
        point = point + beta*give_points(states(i,j) , states(i+1,j));
        point = point + beta*give_points(states(i,j) , states(i-1,j));

end

end

