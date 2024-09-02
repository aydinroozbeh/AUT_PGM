function [d] = get_delta_energy(ref_im , cur_state , next_state, count, std, beta, num_n)

d=0;

s=size(cur_state);
r2 = mod(count , s(2))+1;
r1 = (count-(r2-1))/s(2) + 1;
disp([r1,r2]);

est_cur_im = label_to_image(cur_state);
est_next_im = label_to_image(next_state);

d=d + ( ((ref_im(r1,r2) - est_next_im(r1,r2))^2) - ((ref_im(r1,r2) - est_cur_im(r1,r2))^2) )/(2*std^2);

coor = [r1 , r2];
cur_neigh_energy  = 0;
next_neigh_energy = 0;

if(num_n==4)
    cur_neigh_energy  = get_neighbor_4(coor ,  cur_state , beta);
    next_neigh_energy = get_neighbor_4(coor , next_state , beta);
elseif(num_n==8)
    cur_neigh_energy  = get_neighbor_8(coor ,  cur_state , beta);
    next_neigh_energy = get_neighbor_8(coor , next_state , beta);
end

delta_neighbor_energy = next_neigh_energy - cur_neigh_energy;

d=d+delta_neighbor_energy;

