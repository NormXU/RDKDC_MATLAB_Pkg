function E_inv = homogeneousINV(E)
% accepts a 4 x 4 homogeneous transformation and returns its MATRIX
% inverse
R = E(1:3,1:3);
t = E(1:3,4);
E_inv = [R' -R'*t; 0 0 0 1];
end