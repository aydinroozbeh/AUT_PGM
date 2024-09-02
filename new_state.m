function [state] = new_state(cur_state,count)

state = cur_state;
s=size(cur_state);
r2 = mod(count , s(2))+1;
r1 = (count-(r2-1))/s(2) + 1;

%n = randi(2);
state(r1 , r2) = randi(3);